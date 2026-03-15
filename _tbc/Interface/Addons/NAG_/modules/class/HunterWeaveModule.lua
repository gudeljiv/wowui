--- @module "NAG.HunterWeaveModule"
--- Swing-aware timing primitives for TBC BM Hunter weaving.
---
--- This module intentionally does NOT implement named rotations. It exposes
--- latency-aware timing windows that other systems (rotation strings + weave bar UI)
--- can use to recommend actions without clipping ranged Auto Shots.
---
--- License: CC BY-NC 4.0
--- Authors: Adapted from MoP Shaman weave patterns (Rakizi/Fonsas), reworked for Hunters

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local GetTime = _G.GetTime
local date = _G.date
local UnitExists = _G.UnitExists
local UnitIsDead = _G.UnitIsDead
local UnitAffectingCombat = _G.UnitAffectingCombat
local UnitLevel = _G.UnitLevel
local UnitClassBase = _G.UnitClassBase
local UnitCastingInfo = _G.UnitCastingInfo
local UnitRangedDamage = _G.UnitRangedDamage
local CheckInteractDistance = _G.CheckInteractDistance
local IsSpellInRange = C_Spell and C_Spell.IsSpellInRange or _G.IsSpellInRange
local GetInventoryItemLink = _G.GetInventoryItemLink
local GetSpellInfo = _G.GetSpellInfo
local C_Item = _G.C_Item
local UnitIsVisible = _G.UnitIsVisible
local UnitCanAttack = _G.UnitCanAttack

--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local WoWAPI = ns.WoWAPI
local Version = ns.Version

-- LibClassicSwingTimerAPI is the authoritative source for ranged expiration timing.
local swingTimerLib = LibStub("LibClassicSwingTimerAPI", true)

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
--- @type SpecCompat
local SpecCompat
--- @type TBCHunterAPI|nil
local TBCHunterAPI

-- Constants (TBC)
local BM_SPEC_INDEX = 1

local STEADY_SHOT_ID = 34120 -- Steady Shot (TBC, level 62+)
local MULTI_SHOT_ID = 2643  -- Multi-Shot (Rank 1)
local ARCANE_SHOT_ID = 3044 -- Arcane Shot (Rank 1) (instant)
local AIMED_SHOT_ID = 27065 -- Aimed Shot (Rank 7, TBC) - prepatch / when no Steady; 3s cast, 6s CD
-- Serpent Sting rank differs by expansion/client. We intentionally do not hardcode a rank ID here.
-- TODO: Resolve a known Serpent Sting spell ID at runtime via spellbook scanning if/when we visualize it.
local SERPENT_STING_ID = nil
local RAPTOR_STRIKE_ID = 2973 -- Raptor Strike (Rank 1)

-- Internal counters for swing detection
local lastRangedSwingAt = nil
local rangedAutoCount = 0
local lastMeleeSwingAt = nil
local meleeSwingCount = 0
local lastPatternName = nil
local wasInCombat = false
local HOLD_SPELL_ID = 75 -- Auto Shot icon for WAIT overlay

-- Per-ranged-swing action budgeting (avoid too many distinct actions per auto window)
local actionBudgetSwingKey = nil
local actionBudgetMax = 2
local actionBudgetUsed = 0
local actionBudgetSeen = {}

-- Auto Shot warm-up tracking (TBC): when Auto Shot is toggled ON, it takes 0.5s wind-up to fire.
local autoShotWasOn = false
local autoShotEnabledAt = nil
local autoShotRequestedAt = nil

-- Filler bookkeeping (runtime-only; no AceDB writes)
local needsSteadyAfterMulti = false
local lastArcaneQueuedAt = nil
local extraGapUntil = nil

-- Debug throttling (avoid chat spam)
local lastSteadyDebugAt = 0

-- Learned (runtime) hasted cast times to improve queued-state prediction
local learnedSteadyCastSeconds = nil
local learnedMultiCastSeconds = nil

-- Debug-only: track last cast-time model inputs to explain queued vs casting discrepancies.
local lastSteadyCastModel = nil -- "hasteFactor" | "learned" | "unitCastingInfo"
local lastBaseSteadyCastObserved = nil
local lastHasteFactorObserved = nil

-- ============================ THROTTLED DEBUG TRACE (ALWAYS ON) ============================

local debugLastByKey = {}
local DEBUG_INTERVAL_DEFAULT = 0.35

local function DebugTrace(self, key, message, interval)
    if not self or not self.Print then
        return
    end
    local now = GetTime()
    local minInterval = interval or DEBUG_INTERVAL_DEFAULT
    local lastAt = debugLastByKey[key] or 0
    if (now - lastAt) < minInterval then
        return
    end
    debugLastByKey[key] = now
    self:Print(string.format("|cffffff00[HUNTER_DBG:%s]|r %s", tostring(key), tostring(message)))
end

-- ============================ FILLER WINDOW (GCD/MID-CYCLE) ============================

local function GetEffectiveReadyIn(snap)
    local readyIn = tonumber(snap and snap.nextActionDelay or 0) or 0
    -- If Steady is queued in wind-up, the next-action delay can be "too early" because GCD already started
    -- at key-press time, but the queued cast itself will still consume time until it ends.
    if snap and snap.steadyQueued and snap.queuedSteadyEndAt and snap.now then
        local queuedEndIn = (tonumber(snap.queuedSteadyEndAt) or 0) - (tonumber(snap.now) or 0)
        if queuedEndIn < 0 then queuedEndIn = 0 end
        if queuedEndIn > readyIn then
            readyIn = queuedEndIn
        end
    end
    return readyIn
end

--- True when we're in the "filler-only" situation:
--- - GCD is currently running and will end before the next Auto Shot fires (mid-cycle)
--- - There is NOT enough remaining time after GCD ends to fit a Steady Shot before the Auto boundary
--- In that case, we allow instants / Multi as fillers; otherwise we prefer SS or HOLD.
--- @param snap table Hunter weave snapshot
--- @return boolean
local function ShouldUseFillerThisCycle(snap)
    if not snap or not snap.ok then
        return false
    end
    local nextActionDelay = GetEffectiveReadyIn(snap)
    if nextActionDelay <= 0 then
        return false
    end

    local ttn = tonumber(snap.rangedTimeToNext or 0) or 0
    if ttn <= 0 then
        return false
    end

    -- Next-action moment must happen before the next Auto (otherwise there's no actionable mid-cycle window)
    if nextActionDelay >= ttn then
        return false
    end

    local remainingAfterReady = ttn - nextActionDelay
    local steadyNeeded = (tonumber(snap.steadyCast or 0) or 0) + (tonumber(snap.adjustedInputDelay or 0) or 0)
    -- If we can still fit a Steady after we're ready to act, then filler is NOT allowed by the rule.
    if remainingAfterReady > steadyNeeded then
        return false
    end

    return true
end

local INVSLOT_MAINHAND = 16
local INVSLOT_OFFHAND = 17

-- Default settings (kept small; most UI settings live in HunterWeaveBar)
local defaults = {
    class = {
        enabled = true,
        debug = false,
        debugMouseoverWeave = false,
        preferSweetSpotItem = true,
        sweetSpotItemId = 8149,

        -- Latency/input model (copied from Shaman weave math)
        -- NOTE: for the hunter weave bar we can disable this to show "pure" cast-time gaps.
        useInputDelayModel = false,
        staticPressBuffer = 0.200, -- seconds
        inputDelayFallback = 0.050, -- seconds
        inputDelayCap = 0.45, -- seconds

        -- Safety buffers
        instantSafetyBuffer = 0.050, -- extra buffer for instants near the Auto boundary
        waitThreshold = 0.15, -- seconds: when <= this, we consider "WAIT/RESET now"
        clipToleranceSeconds = 0.10, -- seconds: allow small Auto delays (max tolerated clip)

        -- Melee weaving window shaping (UI-facing; doesn't attempt to model movement travel time)
        meleeGapMin = 0.20, -- minimum swing-left required to show a melee weave window

        -- Positioning suggestions (2H melee weaving only)
        showPositioningSuggestions = true, -- show arrow/minus near next-action icon; Raptor still suggested at melee when disabled

        -- Weave heuristics
        weaveProcessCostSeconds = 0.360, -- estimated time cost for a weave (movement/retargeting)
        maxActionsPerRangedSwing = 2, -- avoid suggesting more than N distinct actions between two autos

        -- SIM-like adaptive scoring (testing / tuning)
        -- IMPORTANT: these are *relative weights* only (not a full damage sim).
        adaptiveScoringEnabled = false,
        adaptiveCatchupThreshold = 0.95, -- mirrors wowsims `useMultiForCatchup` threshold
        adaptiveWeights = {
            shoot = 1.0,
            steady = 1.0,
            multi = 1.0,
            arcane = 1.0,
            weave = 1.0,
        },

        -- Universal scale for all hunter bar UIs (weave bar, steady gap, timeline, future bars)
        barScale = 1.0,
    }
}

--- @class HunterWeaveModule:CoreModule
local HunterWeaveModule = NAG:CreateModule("HunterWeaveModule", defaults, {
    moduleType = ns.MODULE_TYPES.CLASS,
    className = "HUNTER",
    optionsCategory = ns.MODULE_CATEGORIES.CLASS,
    hidden = function() return true end, -- Options hidden; module logic (HunterWeaveSnapshot, etc.) still runs
    messageHandlers = {
        NAG_SPEC_UPDATED = true,
    },
    eventHandlers = {
        UNIT_SPELLCAST_START = true,
        UNIT_SPELLCAST_SENT = true,
        PLAYER_REGEN_ENABLED = "OnCombatEnd",
    },
    cleuHandlers = {
        SPELL_CAST_SUCCESS = "HandleCLEUAutoShot",
    },
})

-- Keep module enabled across specs; behavior is gated by this flag.
HunterWeaveModule.isBM = false

-- ============================ WIND-UP (LATENCY-PADDED) ============================

local function GetPaddedRangedWindupSeconds(rangedSpeed)
    local currentRangedSpeed = tonumber(rangedSpeed or 0) or 0
    if currentRangedSpeed <= 0 and swingTimerLib and swingTimerLib.UnitSwingTimerInfo then
        local speed = select(1, swingTimerLib:UnitSwingTimerInfo("player", "ranged"))
        currentRangedSpeed = tonumber(speed or 0) or 0
    end
    if currentRangedSpeed <= 0 and UnitRangedDamage then
        currentRangedSpeed = tonumber(UnitRangedDamage("player") or 0) or 0
    end

    local baseRangedSpeed = 0
    if swingTimerLib and swingTimerLib.player and swingTimerLib.player.rangedBaseSpeed then
        baseRangedSpeed = tonumber(swingTimerLib.player.rangedBaseSpeed) or 0
    end
    if baseRangedSpeed <= 0 then
        baseRangedSpeed = currentRangedSpeed
    end

    local computeWindup = ns and ns.HunterComputeWindupSeconds
    local base = 0.5
    if type(computeWindup) == "function" then
        base = tonumber(computeWindup(currentRangedSpeed, baseRangedSpeed, 0.5) or 0.5) or 0.5
    elseif currentRangedSpeed > 0 and baseRangedSpeed > 0 then
        base = 0.5 * (currentRangedSpeed / baseRangedSpeed)
    end

    local factor = 0.8
    local latency = (NAG.GetNetStats and NAG:GetNetStats()) or 0
    if latency < 0 then latency = 0 end

    -- Keep latency padding as a safety envelope on top of haste-scaled windup.
    local padded = base + (factor * latency)
    if padded < base then padded = base end
    if currentRangedSpeed > 0 and padded > currentRangedSpeed then
        padded = currentRangedSpeed
    end
    if padded > 1.0 then padded = 1.0 end
    return padded
end

-- ============================ EVENT (LEARNED CAST TIMES) ============================

--- We keep UNIT_SPELLCAST_START only to learn the true (hasted) cast time from UnitCastingInfo.
function HunterWeaveModule:UNIT_SPELLCAST_START(event, unit, castString, spellId)
    if unit ~= "player" then
        return
    end
    if type(spellId) ~= "number" then
        return
    end

    if spellId ~= STEADY_SHOT_ID and spellId ~= MULTI_SHOT_ID then
        return
    end

    local _, _, _, startTimeMS, endTimeMS = UnitCastingInfo("player")
    if not (startTimeMS and endTimeMS and endTimeMS > startTimeMS) then
        return
    end

    local learned = (endTimeMS - startTimeMS) / 1000
    if learned <= 0 then
        return
    end

    if spellId == STEADY_SHOT_ID then
        learnedSteadyCastSeconds = learned
    else
        learnedMultiCastSeconds = learned
    end
end

-- ============================ EVENT (QUEUE INTENT) ============================

-- Record recent “intent” to cast Multi-Shot. This is NOT treated as queued on its own; we only
-- consider it inside the queue acceptance window near nextActionDelay.
local lastMultiSentAt = nil

-- Auto Shot clipping measurement: delay = elapsed - rangedSpeed (positive = clipped).
local lastAutoShotAt = nil
local firstAutoShotInCombat = true

function HunterWeaveModule:OnCombatEnd()
    firstAutoShotInCombat = true
    lastAutoShotAt = nil
end

--- Resolve expected clipping for a specific recommended spell from a snapshot.
--- @param snapshot table|nil
--- @param spellId number|nil
--- @return number|nil expectedClipSeconds
--- @return string|nil actionType
local function ResolveExpectedClipForSpell(snapshot, spellId)
    if type(snapshot) ~= "table" then
        return nil, nil
    end
    local id = tonumber(spellId or 0) or 0
    if id == STEADY_SHOT_ID then
        return tonumber(snapshot.expectedClipIfSteadyNow or 0) or 0, "SS"
    end
    if id == MULTI_SHOT_ID or id == 2643 then
        return tonumber(snapshot.expectedClipIfMultiNow or 0) or 0, "MS"
    end
    if id == ARCANE_SHOT_ID or id == 3044 then
        return tonumber(snapshot.expectedClipIfArcaneNow or 0) or 0, "AR"
    end

    return nil, nil
end

--- Handle CLEU SPELL_CAST_SUCCESS for Auto Shot (75). Measures clipping: delay = elapsed - rangedSpeed.
function HunterWeaveModule:HandleCLEUAutoShot(timestamp, subEvent, hideCaster, sourceGUID, sourceName,
    sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId)
    if spellId ~= 75 then
        -- Log SS/MS/AR casts to correlate with auto delay (gated behind dev mode).
        if NAG.IsDevModeEnabled and NAG:IsDevModeEnabled() and sourceGUID == UnitGUID("player") and lastAutoShotAt then
            local castTime = GetTime()
            local timeSinceAuto = castTime - lastAutoShotAt
            local name = (spellId == STEADY_SHOT_ID and "SS") or ((spellId == MULTI_SHOT_ID or spellId == 27021) and "MS") or ((spellId == ARCANE_SHOT_ID or spellId == 3044) and "AR") or nil
            if name then
                local ts = date("%H:%M:%S")
                NAG:Print(string.format("[AutoShot] %s spell cast: %s at t=%.3f | timeSinceLastAuto=%.3fs", ts, name, castTime, timeSinceAuto))
            end
        end
        return
    end
    if sourceGUID ~= UnitGUID("player") then
        return
    end
    if not UnitAffectingCombat("player") then
        firstAutoShotInCombat = true
        lastAutoShotAt = nil
        return
    end

    local currentTime = GetTime()
    local rangedSpeed = 0
    if swingTimerLib and swingTimerLib.UnitSwingTimerInfo then
        rangedSpeed = select(1, swingTimerLib:UnitSwingTimerInfo("player", "ranged")) or 0
    end
    if (not rangedSpeed or rangedSpeed <= 0) and UnitRangedDamage then
        rangedSpeed = tonumber(UnitRangedDamage("player") or 0) or 0
    end

    if firstAutoShotInCombat then
        lastAutoShotAt = currentTime
        firstAutoShotInCombat = false
        if NAG.IsDevModeEnabled and NAG:IsDevModeEnabled() then
            local snapshot = self:GetWeaveSnapshot()
            local nextSpellId = tonumber(NAG and NAG.nextSpell or 0) or 0
            local expectedClip, actionType = ResolveExpectedClipForSpell(snapshot, nextSpellId)
            local ts = date("%H:%M:%S")
            if expectedClip ~= nil and actionType then
                NAG:Print(string.format(
                    "[AutoShot] %s first shot | speed=%.2fs | expectedClip[%s]=%.2fs",
                    ts,
                    rangedSpeed > 0 and rangedSpeed or 0,
                    actionType,
                    expectedClip
                ))
            else
                NAG:Print(string.format("[AutoShot] %s first shot | speed=%.2fs", ts, rangedSpeed > 0 and rangedSpeed or 0))
            end
        end
        return
    end

    local delay = 0
    local elapsed = 0
    if lastAutoShotAt and rangedSpeed > 0 then
        elapsed = currentTime - lastAutoShotAt
        delay = elapsed - rangedSpeed
    end
    lastAutoShotAt = currentTime
    local measuredDelay = delay > 0 and delay or 0
    local largeDelayMarker = (measuredDelay > 0.5) and " | !! LARGE_DELAY !!" or ""
    local nextSpellId = tonumber(NAG and NAG.nextSpell or 0) or 0
    if NAG.IsDevModeEnabled and NAG:IsDevModeEnabled() then
        local snapshot = self:GetWeaveSnapshot()
        local expectedClip, actionType = ResolveExpectedClipForSpell(snapshot, nextSpellId)
        local timeStr = date("%H:%M:%S")
        if expectedClip ~= nil and actionType then
            NAG:Print(string.format(
                "[AutoShot] %s delay=%.2fs | elapsed=%.2fs speed=%.2fs | expectedClip[%s]=%.2fs%s",
                timeStr,
                measuredDelay,
                elapsed,
                rangedSpeed,
                actionType,
                expectedClip,
                largeDelayMarker
            ))
        else
            NAG:Print(string.format("[AutoShot] %s delay=%.2fs | elapsed=%.2fs speed=%.2fs%s",
                timeStr, measuredDelay, elapsed, rangedSpeed, largeDelayMarker))
        end
    end
    if measuredDelay > 0.5 and NAG.IsDevModeEnabled and NAG:IsDevModeEnabled() then
        local steadyBar = NAG:GetModule("HunterSteadyWeaveBar", true)
        local debugInfo = steadyBar and steadyBar.state and steadyBar.state.lastComputationDebug
        if debugInfo then
            local ts = (debugInfo.timestampStr or ("t=" .. tostring(debugInfo.timestamp or 0)))
            NAG:Print(string.format("[LARGE_DELAY] Last compute: %s | trigger=%s | nextSpellId=%s",
                ts, tostring(debugInfo.triggerSource or "?"), tostring(nextSpellId)))
            if debugInfo.state0 then
                NAG:Print(string.format("  state0: chosen=%s reason=%s | slot2=%s reason2=%s | actionIn=%.3f",
                    debugInfo.state0.chosen or "?", debugInfo.state0.reason or "?",
                    debugInfo.state0.chosen2 or "?", debugInfo.state0.reason2 or "?",
                    tonumber(debugInfo.state0.actionIn) or 0))
            end
            if debugInfo.state1 then
                NAG:Print(string.format("  state1: chosen=%s reason=%s | slot2=%s reason2=%s | actionIn=%.3f",
                    debugInfo.state1.chosen or "?", debugInfo.state1.reason or "?",
                    debugInfo.state1.chosen2 or "?", debugInfo.state1.reason2 or "?",
                    tonumber(debugInfo.state1.actionIn) or 0))
            end
            if debugInfo.next6 and #debugInfo.next6 > 0 then
                local parts = {}
                for i = 1, #debugInfo.next6 do
                    local a = debugInfo.next6[i]
                    if a and a[1] then
                        if a[2] and a[3] then
                            parts[#parts + 1] = string.format("{%s,%.3f,%.3f}", a[1], a[2], a[3])
                        else
                            parts[#parts + 1] = string.format("{%s,%.3f}", a[1], a[2] or 0)
                        end
                    end
                end
                NAG:Print("  next6: " .. (table.concat(parts, ", ") or "{}"))
            end
        else
            NAG:Print("[LARGE_DELAY] No lastComputationDebug available (bar may be disabled)")
        end
    end
end

function HunterWeaveModule:UNIT_SPELLCAST_SENT(event, unit, ...)
    if unit ~= "player" then
        return
    end
    local argc = select("#", ...)
    local spellId = nil
    for i = 1, argc do
        local v = select(i, ...)
        if type(v) == "number" then
            spellId = v
        end
    end
    if spellId == MULTI_SHOT_ID then
        lastMultiSentAt = GetTime()
    end
end

-- ============================ INTERNAL HELPERS ============================

--- Normalize IsSpellInRange results across client variants and spellId/spellName calls.
--- Returns: true (in range), false (out of range), nil (unknown / api returned nil)
--- @param spellId number
--- @param unit string
--- @return boolean|nil
local function IsSpellInRangeUnified(spellId, unit)
    if not IsSpellInRange then
        return nil
    end

    local res = IsSpellInRange(spellId, unit)
    if res == 1 or res == true then
        return true
    elseif res == 0 or res == false then
        return false
    end

    -- Fallback: try by spell name (some clients are pickier here)
    if GetSpellInfo then
        local name = GetSpellInfo(spellId)
        if name then
            res = IsSpellInRange(name, unit)
            if res == 1 or res == true then
                return true
            elseif res == 0 or res == false then
                return false
            end
        end
    end

    return nil
end

--- Normalize IsItemInRange results across client variants.
--- Returns: true (in range), false (out of range), nil (unknown / api not available)
--- @param itemId number
--- @param unit string
--- @return boolean|nil
local function IsItemInRangeUnified(itemId, unit)
    if not itemId or not unit then
        return nil
    end

    -- Classic/TBC usually exposes global IsItemInRange, some clients expose C_Item.IsItemInRange.
    local fn = _G.IsItemInRange or (_G.C_Item and _G.C_Item.IsItemInRange) or nil
    if not fn then
        return nil
    end

    local itemRef = "item:" .. tostring(itemId)
    local res = fn(itemRef, unit)
    if res == 1 or res == true then
        return true
    elseif res == 0 or res == false then
        return false
    end
    return nil
end

-- ============================ STEADY QUEUE TRACKING ============================

-- ============================ HOLD (STEADY) ============================

-- ============================ AUTO SHOT (WARM-UP) ============================

--- True if Auto Shot is currently toggled on (auto-repeat).
--- This is intentionally separate from "swing timer has data"; it answers "did the user enable Auto Shot?".
--- @return boolean
function HunterWeaveModule:HunterIsAutoShooting()
    if not _G.UnitExists or not _G.UnitCanAttack then
        return false
    end
    if not _G.UnitExists("target") or not _G.UnitCanAttack("player", "target") then
        return false
    end

    -- IsAutoRepeatSpell(75) works correctly for detecting Auto Shot
    if _G.IsAutoRepeatSpell then
        local result = _G.IsAutoRepeatSpell(75) -- Auto Shot
        return (result == 1 or result == true)
    end

    return false
end

--- Record Auto Shot toggle transitions and return the moment Auto was enabled.
--- @return number|nil enabledAt
function HunterWeaveModule:GetAutoShotEnabledAt()
    local now = GetTime()
    local isOn = self:HunterIsAutoShooting()
    if isOn and not autoShotWasOn then
        autoShotEnabledAt = now
    end
    autoShotWasOn = isOn
    return autoShotEnabledAt
end

--- Update auto-shot tracking state early in the APL and return false to allow fall-through.
--- This ensures we observe the not-auto -> auto transition even on ticks where HunterEnsureAutoShot blocks.
--- @return boolean always false
function HunterWeaveModule:HunterUpdateAutoShotState()
    self:GetAutoShotEnabledAt()
    -- DEBUG (BMDBG): temporarily disabled to reduce chat/log spam while iterating.
    if false and self.Print then
        local snap = self:GetWeaveSnapshot()

        local inWarmUp = self:HunterInWarmUp() and true or false
        local notWarmUp = (not inWarmUp) and true or false

        local msQueued = self:HunterMSQueued() and true or false
        local condNotMSQueued = (not msQueued) and true or false

        local apiQueuedSS = (NAG.IsQueued and NAG:IsQueued(STEADY_SHOT_ID)) and true or false
        local apiQueuedMS = (NAG.IsQueued and NAG:IsQueued(MULTI_SHOT_ID)) and true or false

        local safeToCastMS = self:HunterSafeToCast(MULTI_SHOT_ID) and true or false

        local gcdLeft = (NAG.GCDTimeToReady and NAG:GCDTimeToReady()) or 0
        if gcdLeft < 0 then gcdLeft = 0 end
        local gcdActive = (gcdLeft > 0) and true or false

        local isCasting = (NAG.IsCasting and NAG:IsCasting()) and true or false
        local busyRecent = (NAG.IsGCDOrCastingRecently and NAG:IsGCDOrCastingRecently(0.200, STEADY_SHOT_ID)) and true or false

        local result = (notWarmUp and condNotMSQueued and safeToCastMS and busyRecent) and true or false

        local ttn = tonumber(snap and snap.rangedTimeToNext or 0) or 0
        local baseReadyIn = tonumber(snap and snap.nextActionDelay or 0) or 0
        local readyIn = GetEffectiveReadyIn(snap)
        local lastSuccId, lastSuccAge = nil, nil
        if NAG.GetLastPlayerSpellSucceededInfo then
            lastSuccId, lastSuccAge = NAG:GetLastPlayerSpellSucceededInfo()
        end

        self:Print(string.format(
            "[BMDBG] MSExpr notWarmUp:%s and not(msQueued:%s)=%s and safeToCastMS:%s and IsGCDOrCastingRecently(0.200,SS):%s (gcd>0:%s(%.3f) casting:%s lastSuccId:%s age:%.3f) => RESULT=%s apiQueuedSS:%s apiQueuedMS:%s ttn=%.3f readyIn=%.3f(base=%.3f)",
            tostring(notWarmUp),
            tostring(msQueued),
            tostring(condNotMSQueued),
            tostring(safeToCastMS),
            tostring(busyRecent),
            tostring(gcdActive),
            tonumber(gcdLeft) or 0,
            tostring(isCasting),
            tostring(lastSuccId),
            tonumber(lastSuccAge or 0) or 0,
            tostring(result),
            tostring(apiQueuedSS),
            tostring(apiQueuedMS),
            tonumber(ttn) or 0,
            tonumber(readyIn) or 0,
            tonumber(baseReadyIn) or 0
        ))
    end
    return false
end

-- ============================ BM DEBUG WRAPPERS (ONE-LINERS) ============================

local function SpellName(spellId)
    if not GetSpellInfo then
        return tostring(spellId)
    end
    local name = GetSpellInfo(spellId)
    return name or tostring(spellId)
end

function HunterWeaveModule:HunterDbg_UpdateAutoShotState()
    local wasOn = autoShotWasOn and true or false
    local enabledAt = self:GetAutoShotEnabledAt()
    local isOn = autoShotWasOn and true or false
    if self.Print then
        self:Print(string.format("[BMDBG] UpdateAutoShotState wasOn=%s isOn=%s enabledAt=%s requestedAt=%s -> false",
            tostring(wasOn), tostring(isOn), tostring(enabledAt), tostring(autoShotRequestedAt)))
    end
    return false
end

function HunterWeaveModule:HunterDbg_EnsureAutoShot()
    local isOn = self:HunterIsAutoShooting()
    if isOn then
        if self.Print then
            self:Print("[BMDBG] EnsureAutoShot isOn=true -> false")
        end
        return false
    end
    local ok = NAG:Cast(75)
    if ok then
        autoShotRequestedAt = GetTime()
    end
    if self.Print then
        self:Print(string.format("[BMDBG] EnsureAutoShot isOn=false -> Cast(75)=%s", tostring(ok)))
    end
    return ok
end

function HunterWeaveModule:HunterDbg_InWarmUp()
    local snap = self:GetWeaveSnapshot()
    local windup = GetPaddedRangedWindupSeconds()
    local ttn = snap and tonumber(snap.rangedTimeToNext or 0) or 0
    local readyIn = snap and tonumber(snap.nextActionDelay or 0) or 0
    local ttnAtReady = ttn - readyIn
    local ok = self:HunterInWarmUp()
    if self.Print then
        self:Print(string.format("[BMDBG] InWarmUp=%s ttn=%.3f readyIn=%.3f ttnAtReady=%.3f enabledAt=%s requestedAt=%s",
            tostring(ok), ttn, readyIn, ttnAtReady, tostring(autoShotEnabledAt), tostring(autoShotRequestedAt)))
    end
    return ok
end

function HunterWeaveModule:HunterDbg_SSQueued()
    local snap = self:GetWeaveSnapshot()
    local apiQueued = (NAG.IsQueued and NAG:IsQueued(STEADY_SHOT_ID)) and true or false
    local _, _, _, _, _, _, _, _, castingSpellId = UnitCastingInfo("player")
    local isCasting = (castingSpellId == STEADY_SHOT_ID) and true or false
    local q = (apiQueued or isCasting) and true or false
    if self.Print then
        self:Print(string.format("[BMDBG] SSQueued=%s apiQueued=%s casting=%s inWindup=%s ttn=%.3f",
            tostring(q),
            tostring(apiQueued),
            tostring(isCasting),
            tostring(snap and snap.rangedInWindup),
            tonumber(snap and snap.rangedTimeToNext or 0) or 0
        ))
    end
    return q
end

function HunterWeaveModule:HunterDbg_SafeToCast(spellId)
    local snap = self:GetWeaveSnapshot()
    local ttn = snap and tonumber(snap.rangedTimeToNext or 0) or 0
    local readyIn = snap and tonumber(snap.nextActionDelay or 0) or 0
    local ttnAtReady = ttn - readyIn
    local delay = snap and tonumber(snap.adjustedInputDelay or 0) or 0
    local cast = 0
    if spellId == STEADY_SHOT_ID then
        cast = snap and tonumber(snap.steadyCast or 0) or 0
    elseif spellId == MULTI_SHOT_ID then
        cast = 0.5
    else
        cast = 0
    end
    local needed = cast + delay
    local ok = self:HunterSafeToCast(spellId)
    if self.Print then
        self:Print(string.format("[BMDBG] SafeToCast(%s)=%s ttnAtReady=%.3f needed=%.3f (cast=%.3f delay=%.3f)",
            SpellName(spellId), tostring(ok), ttnAtReady, needed, cast, delay))
    end
    return ok
end

function HunterWeaveModule:HunterDbg_SpellReady(spellId)
    local ok = (NAG.SpellIsReady and NAG:SpellIsReady(spellId)) and true or false
    if self.Print then
        self:Print(string.format("[BMDBG] SpellIsReady(%s)=%s", SpellName(spellId), tostring(ok)))
    end
    return ok
end

function HunterWeaveModule:HunterDbg_GCDLeft()
    local gcd = (NAG.GCDTimeToReady and NAG:GCDTimeToReady()) or 0
    if self.Print then
        self:Print(string.format("[BMDBG] GCDLeft=%.3f", tonumber(gcd) or 0))
    end
    return gcd or 0
end

function HunterWeaveModule:HunterDbg_IsCasting()
    local ok = (NAG.IsCasting and NAG:IsCasting()) and true or false
    if self.Print then
        self:Print(string.format("[BMDBG] IsCasting=%s", tostring(ok)))
    end
    return ok
end

function HunterWeaveModule:HunterDbg_Cast(spellId)
    local ok = NAG:Cast(spellId)
    if self.Print then
        self:Print(string.format("[BMDBG] Cast(%s)=%s", SpellName(spellId), tostring(ok)))
    end
    return ok
end

function HunterWeaveModule:HunterDbg_SteadyHold()
    local ok = NAG:HunterSteadyHold()
    if self.Print then
        self:Print(string.format("[BMDBG] SteadyHold=%s", tostring(ok)))
    end
    return ok
end

--- Debug probe for BM APL MS/AR branch gates.
--- Prints each predicate value and always returns false (no behavior change).
--- @return boolean
function HunterWeaveModule:HunterDbg_MSARGates()
    local snap = self:GetWeaveSnapshot()
    local inWarmUp = self:HunterInWarmUp() and true or false
    local msQueued = self:HunterMSQueued() and true or false
    local msSafe = self:HunterSafeToCast(27021) and true or false
    local arSafe = self:HunterSafeToCast(27019) and true or false
    local msReady = (NAG.SpellIsReady and NAG:SpellIsReady(27021)) and true or false
    local busyRecent = (NAG.IsGCDOrCastingRecently and NAG:IsGCDOrCastingRecently(0.200, STEADY_SHOT_ID)) and true or false
    local ssKnown = (NAG.SpellIsKnown and NAG:SpellIsKnown(STEADY_SHOT_ID)) and true or false

    local msExpr = (ssKnown and (not inWarmUp) and (not msQueued) and msSafe and busyRecent) and true or false
    local arExpr = (ssKnown and (not msReady) and (not inWarmUp) and arSafe and busyRecent) and true or false

    local gcdLeft = (NAG.GCDTimeToReady and NAG:GCDTimeToReady()) or 0
    if gcdLeft < 0 then
        gcdLeft = 0
    end
    local lastSuccId, lastSuccAge = nil, nil
    if NAG.GetLastPlayerSpellSucceededInfo then
        lastSuccId, lastSuccAge = NAG:GetLastPlayerSpellSucceededInfo()
    end

    local ttn = tonumber(snap and snap.rangedTimeToNext or 0) or 0
    local readyIn = GetEffectiveReadyIn(snap)
    local ttnAtReady = ttn - readyIn

    DebugTrace(self, "apl_msar", string.format(
        "BM APL gates ssKnown=%s notWarm=%s notMSQueued=%s msSafe=%s arSafe=%s msReady=%s busyRecent=%s lastSucc=%s age=%.3f gcd=%.3f ttn=%.3f readyIn=%.3f ttnAtReady=%.3f => MS=%s AR=%s",
        tostring(ssKnown),
        tostring(not inWarmUp),
        tostring(not msQueued),
        tostring(msSafe),
        tostring(arSafe),
        tostring(msReady),
        tostring(busyRecent),
        tostring(lastSuccId),
        tonumber(lastSuccAge or 0) or 0,
        tonumber(gcdLeft) or 0,
        tonumber(ttn) or 0,
        tonumber(readyIn) or 0,
        tonumber(ttnAtReady) or 0,
        tostring(msExpr),
        tostring(arExpr)
    ), 0.10)

    return false
end

--- True if an Auto Shot is "about to happen" (queue zone).
--- Defined as:
--- - inside the fixed 0.5s wind-up before next scheduled Auto (swing timer), OR
--- - within 0.5s after the user toggled Auto Shot ON (warm-up start).
--- @return boolean
function HunterWeaveModule:HunterAutoQueueZone()
    local windup = GetPaddedRangedWindupSeconds()

    local enabledAt = self:GetAutoShotEnabledAt()
    local now = GetTime()
    if enabledAt and (now - enabledAt) >= 0 and (now - enabledAt) <= windup then
        return true
    end

    local snap = self:GetWeaveSnapshot()
    if snap and snap.ok and snap.rangedInWindup then
        return true
    end

    return false
end

--- Ensure Auto Shot is toggled on before suggesting other shots.
--- Returns true if it recommended Auto Shot this tick (APL should stop).
--- @return boolean
function HunterWeaveModule:HunterEnsureAutoShot()
    -- Auto Shot doesn't make sense in melee range; don't block the APL with an "ensure" prompt.
    if NAG.TargetInMeleeRange and NAG:TargetInMeleeRange(1) then
        return false
    end
    if self:HunterIsAutoShooting() then
        return false
    end
    -- Prompt user to start auto shots first.
    local ok = NAG:Cast(75)
    if ok then
        autoShotRequestedAt = GetTime()
    end
    return ok
end

--- Returns the time until Steady Shot becomes safe to start (won't clip next Auto).
--- This is specifically for the HOLD-swipe UX (not for general decision-making).
--- The returned value is the remaining wait (from now) AFTER you are free to act (GCD/cast ready),
--- until the start of the next Auto wind-up window (when Steady becomes press-safe to queue).
--- @return number seconds (0 if not in HOLD state)
function HunterWeaveModule:HunterSteadyTimeToSafeStart()
    if not (self.db and self.db.class and self.db.class.enabled) then
        return 0
    end

    local snap = self:GetWeaveSnapshot()
    if not snap or not snap.ok then
        return 0
    end

    -- HOLD swipe semantics (TBC):
    -- We want the swipe to end when it's safe to START SPAMMING Steady such that it queues behind the next Auto.
    -- That moment is the start of Auto's wind-up window: ttn <= 0.5.

    -- If Steady is already safe to execute now (finish-before-auto), no HOLD.
    if snap.canSteadyNow then
        return 0
    end

    local ttn = snap.rangedTimeToNext or 0
    if ttn <= 0 then
        return 0
    end

    local windup = tonumber(snap.rangedWindupSeconds or GetPaddedRangedWindupSeconds(snap.rangedSpeed)) or 0.5
    -- Once we're in wind-up, Steady is press-safe (queues) so no HOLD.
    if ttn <= windup then
        return 0
    end

    -- Time until wind-up begins (from NOW).
    local timeToWindupStart = ttn - windup
    if timeToWindupStart <= 0 then
        return 0
    end

    -- If we are GCD/cast-locked, the HOLD swipe should represent only the *extra* waiting AFTER we're free.
    local readyDelay = tonumber(snap.nextActionDelay or 0) or 0
    if readyDelay < 0 then readyDelay = 0 end
    local holdAfterReady = timeToWindupStart - readyDelay
    if holdAfterReady <= 0 then
        -- By the time we're free, we'll be in (or past) wind-up; don't show HOLD.
        return 0
    end

    return holdAfterReady
end

--- Emit a Steady HOLD marker (no text) which DisplayManager converts into a HOLD swipe.
--- Returns true if it set Steady as the primary recommendation, false otherwise.
--- @return boolean
function HunterWeaveModule:HunterSteadyHold()
    local snap = self:GetWeaveSnapshot()
    if not snap or not snap.ok then
        return false
    end


    local ttn = tonumber(snap.rangedTimeToNext or 0) or 0
    local windup = tonumber(snap.rangedWindupSeconds or GetPaddedRangedWindupSeconds(snap.rangedSpeed)) or 0.5
    local readyDelay = tonumber(snap.nextActionDelay or 0) or 0
    if readyDelay < 0 then readyDelay = 0 end
    local ttnAtReady = ttn - readyDelay

    -- If we're currently (or will be, when we're free) inside the Auto wind-up zone,
    -- we should NOT show the HOLD overlay; instead show Steady so the user spams/queues it.
    if ttn <= windup or ttnAtReady <= windup then
        return NAG:CastSpell(STEADY_SHOT_ID, 3, ns.SPELL_POSITIONS.PRIMARY)
    end

   -- local holdSeconds = self:HunterSteadyTimeToSafeStart()
   -- if holdSeconds <= -0.1 then
   --     return false
   -- end

   if ttn <= -0.1 then
       return false
   end
    -- Make Steady the primary icon while holding, so the HOLD swipe is visible and actionable.
    -- This is intentionally tolerant so it shows during GCD and doesn't require spam-to-queue refreshes.
    return NAG:CastSpell(STEADY_SHOT_ID, 3, ns.SPELL_POSITIONS.PRIMARY)
end

--- Emit an Aimed Shot HOLD marker (prepatch) which DisplayManager converts into a HOLD swipe.
--- Returns true if it set Aimed Shot as the primary recommendation, false otherwise.
--- @return boolean
function HunterWeaveModule:HunterAimedHold()
    if NAG.SpellIsKnown and not NAG:SpellIsKnown(AIMED_SHOT_ID) then
        return false
    end

    local snap = self:GetWeaveSnapshot()
    if not snap or not snap.ok then
        return false
    end

    local ttn = tonumber(snap.rangedTimeToNext or 0) or 0
    local windup = tonumber(snap.rangedWindupSeconds or GetPaddedRangedWindupSeconds(snap.rangedSpeed)) or 0.5
    local readyDelay = tonumber(snap.nextActionDelay or 0) or 0
    if readyDelay < 0 then readyDelay = 0 end
    local ttnAtReady = ttn - readyDelay

    -- If we're inside (or will be inside) wind-up, show Aimed so the user can spam/queue it.
    if ttn <= windup or ttnAtReady <= windup then
        return NAG:CastSpell(AIMED_SHOT_ID, 3, ns.SPELL_POSITIONS.PRIMARY)
    end

    if ttn <= -0.1 then
        return false
    end

    -- Make Aimed the primary icon while holding, so the HOLD swipe is visible and actionable.
    return NAG:CastSpell(AIMED_SHOT_ID, 3, ns.SPELL_POSITIONS.PRIMARY, nil, "HOLD_AS")
end

-- ============================ HOLD (MULTI) ============================

--- Returns the time until Multi-Shot becomes safe to start without delaying the next Auto.
--- HOLD swipe ends when it's safe to start spamming Multi such that it will queue behind the next Auto
--- (i.e., when Auto wind-up begins: ttn <= 0.5).
--- @return number seconds (0 if not in HOLD state)
function HunterWeaveModule:HunterMSTimeToSafeStart()
    if not (self.db and self.db.class and self.db.class.enabled) then
        return 0
    end

    local snap = self:GetWeaveSnapshot()
    if not snap or not snap.ok then
        return 0
    end

    -- If Multi is safe to complete before the Auto, no HOLD.
    if snap.canMultiNow then
        return 0
    end

    -- Only show HOLD if Multi is actually ready/usable (otherwise it's misleading).
    if NAG.SpellIsReady and not NAG:SpellIsReady(MULTI_SHOT_ID) then
        return 0
    end

    local ttn = snap.rangedTimeToNext or 0
    if ttn <= 0 then
        return 0
    end

    local windup = tonumber(snap.rangedWindupSeconds or GetPaddedRangedWindupSeconds(snap.rangedSpeed)) or 0.5
    if ttn <= windup then
        return 0
    end

    return ttn - windup
end

--- Emit a Multi-Shot HOLD marker (no text) which DisplayManager converts into a HOLD swipe.
--- Returns true if it set Multi-Shot as the primary recommendation, false otherwise.
--- @return boolean
function HunterWeaveModule:HunterMSHold()
    local holdSeconds = self:HunterMSTimeToSafeStart()
    if holdSeconds <= 0 then
        return false
    end

    -- Make Multi the primary icon while holding, so the HOLD swipe is visible and actionable.
    return NAG:CastSpell(MULTI_SHOT_ID, 3, ns.SPELL_POSITIONS.AOE, nil, "HOLD_MS")
end

local function GetRangedSwingInfo()
    if not swingTimerLib then
        return nil
    end
    local speed, expiration, lastSwing = swingTimerLib:UnitSwingTimerInfo("player", "ranged")
    if not speed or not expiration or speed <= 0 then
        return nil
    end
    local now = GetTime()

    -- Auto timing is combat-log-only: never advance from cast-end heuristics.
    local timeToNext = expiration - now
    if timeToNext < 0 then
        -- LibClassicSwingTimerAPI can briefly report an expired expiration (ttn=0) right as the shot fires.
        -- That 1-tick "hole" causes SafeToCast and warm-up predicates to flicker.
        -- If we're only slightly past the expiration, project the next cycle as (expiration + speed).
        local over = now - expiration
        if over >= 0 and over <= 0.05 then
            expiration = expiration + speed
            timeToNext = expiration - now
        else
            timeToNext = 0
        end
    end
    return {
        now = now,
        speed = speed,
        expiration = expiration,
        timeToNext = timeToNext,
        lastSwing = lastSwing,
    }
end

local function GetMeleeSwingInfo()
    if not swingTimerLib then
        return nil
    end
    local speed, expiration, lastSwing = swingTimerLib:UnitSwingTimerInfo("player", "mainhand")
    if not speed or not expiration or speed <= 0 then
        return nil
    end
    local now = GetTime()
    local timeToNext = expiration - now
    if timeToNext < 0 then
        timeToNext = 0
    end
    return {
        now = now,
        speed = speed,
        expiration = expiration,
        timeToNext = timeToNext,
        lastSwing = lastSwing,
    }
end

local function UpdateSwingCounters(rangedSwing, meleeSwing)
    if rangedSwing and rangedSwing.lastSwing and rangedSwing.lastSwing > 0 then
        if not lastRangedSwingAt or rangedSwing.lastSwing > lastRangedSwingAt then
            rangedAutoCount = rangedAutoCount + 1
            lastRangedSwingAt = rangedSwing.lastSwing
        end
    end

    if meleeSwing and meleeSwing.lastSwing and meleeSwing.lastSwing > 0 then
        if not lastMeleeSwingAt or meleeSwing.lastSwing > lastMeleeSwingAt then
            meleeSwingCount = meleeSwingCount + 1
            lastMeleeSwingAt = meleeSwing.lastSwing
        end
    end
end

local function classifyPattern(ews)
    if not ews or ews <= 0 then
        return { name = "unknown", label = "Unknown", band = "unknown", rotationKey = "unknown" }
    end
    -- Relevant rotations only (from rotationtools):
    -- 5:5:1:1 ~2.8 -> 1.95
    -- 5:6:1:1 ~1.95 -> 1.75
    -- 1:1     ~1.75 -> 1.45
    -- 5:9:1:1 ~1.45 -> 1.25
    -- 1:2     ~1.25 -> 1.05
    -- 1:3     < 1.05
    -- For slower than ~2.8, stay on 5:5:1:1.
    if ews >= 2.8 then
        return { name = "french_5511", label = "French 5:5:1:1", band = "slow", rotationKey = "5:5:1:1" }
    end
    if ews >= 1.95 then
        return { name = "french_5511", label = "French 5:5:1:1", band = "slow", rotationKey = "5:5:1:1" }
    end
    if ews >= 1.75 then
        return { name = "french_5611", label = "French 5:6:1:1", band = "slowish", rotationKey = "5:6:1:1" }
    end
    if ews >= 1.45 then
        return { name = "one_to_one", label = "1:1", band = "mid", rotationKey = "1:1" }
    end
    if ews >= 1.25 then
        return { name = "french_5911", label = "French 5:9:1:1", band = "fast", rotationKey = "5:9:1:1" }
    end
    if ews >= 1.05 then
        return { name = "one_to_two", label = "1:2", band = "very_fast", rotationKey = "1:2" }
    end
    return { name = "one_to_three", label = "1:3", band = "extreme", rotationKey = "1:3" }
end

local function shouldLog(module, message)
    return module.db and module.db.class and module.db.class.debug and message
end

local function UpdateActionBudgetMax(module)
    local maxActions = module.db and module.db.class and module.db.class.maxActionsPerRangedSwing or 2
    if type(maxActions) ~= "number" or maxActions < 1 then
        maxActions = 1
    end
    actionBudgetMax = maxActions
end

local function ResetActionBudget(newSwingKey)
    actionBudgetSwingKey = newSwingKey
    actionBudgetUsed = 0
    if wipe then
        wipe(actionBudgetSeen)
    else
        actionBudgetSeen = {}
    end
end

local function TrySpendActionBudget(module, swingKey, spellId)
    if not swingKey then
        return true
    end

    UpdateActionBudgetMax(module)

    if actionBudgetSwingKey ~= swingKey then
        ResetActionBudget(swingKey)
    end

    if spellId and actionBudgetSeen[spellId] then
        return true
    end

    if actionBudgetUsed >= actionBudgetMax then
        return false
    end

    actionBudgetUsed = actionBudgetUsed + 1
    if spellId then
        actionBudgetSeen[spellId] = true
    end
    return true
end

function HunterWeaveModule:GetAdjustedInputDelay()
    if not self.db.class.useInputDelayModel then
        return 0
    end
    local baseInputDelay = (NAG.InputDelay and NAG:InputDelay()) or (self.db.class.inputDelayFallback or 0.050)
    local ping = (NAG.GetNetStats and NAG:GetNetStats()) or 0
    local staticPressBuffer = self.db.class.staticPressBuffer or 0.200
    local cap = self.db.class.inputDelayCap or 0.45

    local adjusted = (baseInputDelay or 0) + (ping or 0) + staticPressBuffer
    if cap and cap > 0 then
        adjusted = math.min(adjusted, cap)
    end
    return adjusted
end

function HunterWeaveModule:InMeleeRange()
    if not UnitExists("target") or UnitIsDead("target") then
        return false
    end
    if IsSpellInRange then
        local inRange = IsSpellInRange(RAPTOR_STRIKE_ID, "target")
        if inRange == 0 or inRange == false or inRange == nil then
            return false
        end
    end
    if CheckInteractDistance and not CheckInteractDistance("target", 3) then
        return false
    end
    return true
end

function HunterWeaveModule:GetSwingState()
    local inCombat = UnitAffectingCombat("player") and true or false
    if inCombat and not wasInCombat then
        rangedAutoCount = 0
        meleeSwingCount = 0
        lastRangedSwingAt = nil
        lastMeleeSwingAt = nil
    end
    wasInCombat = inCombat

    local rangedSwing = GetRangedSwingInfo()
    local meleeSwing = GetMeleeSwingInfo()

    UpdateSwingCounters(rangedSwing, meleeSwing)

    return {
        ok = rangedSwing ~= nil,
        ranged = rangedSwing and {
            speed = rangedSwing.speed,
            timeToNext = rangedSwing.timeToNext,
            expiration = rangedSwing.expiration,
            lastSwing = rangedSwing.lastSwing,
            count = rangedAutoCount,
        } or nil,
        melee = meleeSwing and {
            speed = meleeSwing.speed,
            timeToNext = meleeSwing.timeToNext,
            expiration = meleeSwing.expiration,
            lastSwing = meleeSwing.lastSwing,
            count = meleeSwingCount,
        } or nil,
    }
end

-- ============================ PUBLIC API ============================

--- Returns a latency-aware snapshot of weave-relevant timing.
--- This is the single source of truth for the HunterWeaveBar and future rotation verification.
--- @return table
function HunterWeaveModule:GetWeaveSnapshot()
    -- NOTE:
    -- Spec detection in Classic/TBC can be unreliable (SpecCompat availability varies).
    -- These timing primitives are safe and useful for any TBC hunter; gate on core preconditions only.
    if UnitClassBase("player") ~= "HUNTER" then
        return { ok = false, reason = "not_hunter" }
    end
    if not Version:IsTBC() then
        return { ok = false, reason = "not_tbc" }
    end
    local playerLevel = UnitLevel("player") or 0
    if playerLevel < 10 then
        return { ok = false, reason = "low_level" }
    end
    if not (self.db and self.db.class and self.db.class.enabled) then
        return { ok = false, reason = "disabled" }
    end

    local swing = GetRangedSwingInfo()
    if not swing then
        return { ok = false, reason = "no_ranged_swing_info" }
    end
    UpdateSwingCounters(swing, nil)

    local gcdLeft = (NAG.GCDTimeToReady and NAG:GCDTimeToReady()) or 0
    if gcdLeft < 0 then gcdLeft = 0 end

    local adjustedDelay = self:GetAdjustedInputDelay()
    -- Per request: for "pure cast gaps" we also treat instant safety as 0 by default.
    local instantSafety = (self.db.class.useInputDelayModel and (self.db.class.instantSafetyBuffer or 0.050)) or 0
    local waitThreshold = self.db.class.waitThreshold or 0.15
    local clipTolerance = self.db.class.clipToleranceSeconds
    if type(clipTolerance) ~= "number" or clipTolerance < 0 then
        clipTolerance = 0.10
    end
    local meleeGapMin = self.db.class.meleeGapMin or 0.20
    -- Auto Shot wind-up (0.5s base, haste-scaled) + latency pad for safety.
    local rangedWindupSeconds = GetPaddedRangedWindupSeconds(swing.speed)

    -- Cast-time model:
    -- - NAG:SpellCastTime() returns base cast time (unhasted).
    -- - For rotation safety we want the *hasted* cast duration (matches UnitCastingInfo prediction).
    local baseSteadyCast = (NAG.SpellCastTime and NAG:SpellCastTime(STEADY_SHOT_ID)) or 1.5
    local baseMultiCast = (NAG.SpellCastTime and NAG:SpellCastTime(MULTI_SHOT_ID)) or 0.5
    if baseSteadyCast < 0 then baseSteadyCast = 0 end
    if baseMultiCast < 0 then baseMultiCast = 0 end

    local hasteFactor = (NAG.GetHasteFactor and NAG:GetHasteFactor()) or 1
    if type(hasteFactor) ~= "number" or hasteFactor <= 0 then
        hasteFactor = 1
    end

    local steadyCast = baseSteadyCast / hasteFactor
    local multiCast = baseMultiCast / hasteFactor

    -- Debug tracking (helps explain why queued-steady predictions can differ from in-cast timings).
    lastSteadyCastModel = "hasteFactor"
    lastBaseSteadyCastObserved = baseSteadyCast
    lastHasteFactorObserved = hasteFactor

    -- Prefer learned durations (from UnitCastingInfo) for queued-state predictions.
    -- This matters for hunters because Steady cast time scales with ranged haste, which is not always reflected
    -- in UnitSpellHaste/GetMeleeHaste on all clients.
    --
    -- steadyCast = cast bar duration only (time from cast start to cast end). Used for gap math,
    -- queuedSteadyEndAt, and state machine. Do NOT add wind-up: gap formulas already subtract windup
    -- separately (earlyGap = rangedSpeed - windup - steadyCast). Adding wind-up would double-count it
    -- and shrink the early gap, leaving no room for fillers.
    if learnedSteadyCastSeconds and learnedSteadyCastSeconds > 0 then
        steadyCast = learnedSteadyCastSeconds
        lastSteadyCastModel = "learned"
    end
    if learnedMultiCastSeconds and learnedMultiCastSeconds > 0 then
        multiCast = learnedMultiCastSeconds
    end

    -- If we're currently casting one of these, prefer the API-reported hasted cast bar for accuracy.
    local _, _, _, startTimeMS, endTimeMS, _, _, _, castingSpellId = UnitCastingInfo("player")
    if castingSpellId == STEADY_SHOT_ID and startTimeMS and endTimeMS and endTimeMS > startTimeMS then
        steadyCast = (endTimeMS - startTimeMS) / 1000
        lastSteadyCastModel = "unitCastingInfo"
    elseif castingSpellId == MULTI_SHOT_ID and startTimeMS and endTimeMS and endTimeMS > startTimeMS then
        multiCast = (endTimeMS - startTimeMS) / 1000
    end

    -- Next-action timing: when will we be allowed to press the next ability?
    -- This is the later of:
    -- - GCD becoming ready
    -- - Current cast finishing
    local castRemaining = 0
    if castingSpellId and endTimeMS then
        castRemaining = (endTimeMS / 1000) - (swing.now or GetTime())
        if castRemaining < 0 then castRemaining = 0 end
    end
    local nextActionDelay = gcdLeft
    if castRemaining > nextActionDelay then
        nextActionDelay = castRemaining
    end

    local timeToNext = swing.timeToNext or 0
    local speed = swing.speed or 0
    local rangedInWindup = (timeToNext > 0 and timeToNext <= rangedWindupSeconds) or false

    -- Queue detection:
    -- We use IsCurrentSpell (via NAG:IsQueued) as the primary queued signal.
    -- IMPORTANT:
    -- - Once the spell actually begins casting, treat it as NOT queued (even if IsCurrentSpell remains true briefly).
    -- - For "normal spell queue window" behavior (e.g., trying to queue MS while finishing SS),
    --   only consider a spell "queued" if it is within the last 200ms before we're allowed to act:
    --   nextActionDelay = max(GCD end, current cast end).
    local isCastingSteady = (castingSpellId == STEADY_SHOT_ID) and true or false
    local isCastingMulti = (castingSpellId == MULTI_SHOT_ID) and true or false

    local steadyQueuedNow = (NAG.IsQueued and NAG:IsQueued(STEADY_SHOT_ID)) and true or false
    local multiQueuedRaw = (NAG.IsQueued and NAG:IsQueued(MULTI_SHOT_ID)) and true or false

    if isCastingSteady then
        steadyQueuedNow = false
    end

    local queueWindow = 0.200
    local inQueueWindow = (nextActionDelay <= queueWindow) and true or false
    local multiQueuedNow = multiQueuedRaw
    if isCastingMulti then
        multiQueuedNow = false
    else
        -- When not in Auto wind-up, require being inside the spell-queue window to accept MS as truly queued.
        -- This prevents "false queued MS" states that would stop recommending MS while you're spamming early.
        if not rangedInWindup then
            local sentRecently = false
            if lastMultiSentAt then
                local age = (swing.now or GetTime()) - lastMultiSentAt
                sentRecently = (age >= 0 and age <= 0.35) and true or false
            end
            multiQueuedNow = ((multiQueuedRaw or sentRecently) and inQueueWindow) and true or false
        end
    end

    -- Clipping boundary = wind-up start (not Auto fire). Casts must finish before wind-up starts.
    local timeToWindupStart = timeToNext - rangedWindupSeconds
    if timeToWindupStart < 0 then
        timeToWindupStart = 0
    end

    -- "Visual gap" means: if you press NOW, do you still have room before wind-up starts?
    local steadyVisualGap = timeToWindupStart - (steadyCast + adjustedDelay)
    local multiVisualGap = timeToWindupStart - (multiCast + adjustedDelay)

    -- Instant-safe gap is stricter than "castTime==0 is always fine":
    -- we avoid recommending instants inside the last (adjustedDelay + buffer) window.
    local instantSafeGap = timeToNext - (adjustedDelay + instantSafety)

    -- Upcoming window size (next cycle): how much room before wind-up starts.
    local nextSteadyWindow = (speed - rangedWindupSeconds) - (steadyCast + adjustedDelay)
    local nextMultiWindow = (speed - rangedWindupSeconds) - (multiCast + adjustedDelay)
    if nextSteadyWindow < 0 then nextSteadyWindow = 0 end
    if nextMultiWindow < 0 then nextMultiWindow = 0 end

    -- Melee weave window: only shown if already in melee range and you have a minimum gap.
    local inMelee = self:InMeleeRange()
    local meleeVisualGap = 0
    local nextMeleeWindow = 0
    if inMelee and timeToNext > 0 then
        meleeVisualGap = timeToNext - meleeGapMin
        if meleeVisualGap < 0 then meleeVisualGap = 0 end
        nextMeleeWindow = speed - meleeGapMin
        if nextMeleeWindow < 0 then nextMeleeWindow = 0 end
    end

    -- IMPORTANT (TBC Hunter wind-up semantics):
    -- We do NOT show "wait now" during wind-up; casted shots are press-safe and will queue.
    local waitNow = (not rangedInWindup) and (timeToNext > 0 and timeToNext <= waitThreshold) or false

    -- Expected clipping if pressed now (strict wind-up boundary; tolerance excluded here by design).
    local expectedClipIfSteadyNow = (nextActionDelay + steadyCast + adjustedDelay) - timeToWindupStart
    local expectedClipIfMultiNow = (nextActionDelay + multiCast + adjustedDelay) - timeToWindupStart
    local expectedClipIfArcaneNow = (nextActionDelay + adjustedDelay + instantSafety) - timeToWindupStart
    if rangedInWindup then
        -- In wind-up, casted shots queue after Auto; treat expected clip as zero for queueable casts.
        expectedClipIfSteadyNow = 0
        expectedClipIfMultiNow = 0
    end
    if expectedClipIfSteadyNow < 0 then expectedClipIfSteadyNow = 0 end
    if expectedClipIfMultiNow < 0 then expectedClipIfMultiNow = 0 end
    if expectedClipIfArcaneNow < 0 then expectedClipIfArcaneNow = 0 end

    return {
        ok = true,
        now = swing.now,
        inCombat = UnitAffectingCombat("player") and true or false,
        inMelee = inMelee and true or false,

        -- Ranged swing
        rangedSpeed = speed,
        rangedTimeToNext = timeToNext,
        rangedExpiration = swing.expiration,
        rangedLastSwing = swing.lastSwing,

        -- If Steady is queued in wind-up, predict when it will actually start/end.
        -- In TBC, a queued cast will begin immediately after the Auto fires (at expiration).
        queuedSteadyStartAt = (steadyQueuedNow and rangedInWindup and swing.expiration) or nil,
        queuedSteadyEndAt = (steadyQueuedNow and rangedInWindup and swing.expiration and (swing.expiration + steadyCast)) or nil,
        queuedMultiStartAt = (multiQueuedNow and rangedInWindup and swing.expiration) or nil,
        queuedMultiEndAt = (multiQueuedNow and rangedInWindup and swing.expiration and (swing.expiration + multiCast)) or nil,

        -- Actionability
        gcdLeft = gcdLeft,
        steadyQueued = steadyQueuedNow,
        multiQueued = multiQueuedNow,
        castingSpellId = castingSpellId,
        castRemaining = castRemaining,
        nextActionDelay = nextActionDelay,

        -- Latency model
        adjustedInputDelay = adjustedDelay,
        instantSafetyBuffer = instantSafety,
        waitThreshold = waitThreshold,
        clipToleranceSeconds = clipTolerance,
        meleeGapMin = meleeGapMin,
        rangedWindupSeconds = rangedWindupSeconds,
        rangedInWindup = rangedInWindup,

        -- Cast times
        steadyCast = steadyCast,
        multiCast = multiCast,

        -- Current-cycle windows
        steadyVisualGap = steadyVisualGap,
        multiVisualGap = multiVisualGap,
        instantSafeGap = instantSafeGap,
        meleeVisualGap = meleeVisualGap,

        -- Next-cycle window sizes (for upcoming indicators)
        nextSteadyWindow = nextSteadyWindow,
        nextMultiWindow = nextMultiWindow,
        nextMeleeWindow = nextMeleeWindow,

        -- Booleans for consumers that want simple predicates
        canSteadyNow = steadyVisualGap > (-clipTolerance),
        canSteadyPress = (steadyVisualGap > (-clipTolerance)) or rangedInWindup,
        canMultiNow = multiVisualGap > (-clipTolerance),
        canMultiPress = (multiVisualGap > (-clipTolerance)) or rangedInWindup,
        -- Back-compat aliases (keep old meaning: safe-to-complete-before-auto)
        canSteady = steadyVisualGap > (-clipTolerance),
        canMulti = multiVisualGap > (-clipTolerance),
        -- Instants should NOT use clip tolerance: recommending instants too close to the Auto boundary feels wrong in-game.
        -- Keep the strict instant-safe window here; cast tolerance is handled by HunterSafeToCast().
        canInstant = instantSafeGap > 0,
        canMelee = meleeVisualGap > 0,
        waitNow = waitNow,
        expectedClipIfSteadyNow = expectedClipIfSteadyNow,
        expectedClipIfMultiNow = expectedClipIfMultiNow,
        expectedClipIfArcaneNow = expectedClipIfArcaneNow,

        -- Spell IDs (for UI icon selection)
        spellIds = {
            steady = STEADY_SHOT_ID,
            multi = MULTI_SHOT_ID,
            arcane = ARCANE_SHOT_ID,
            serpent = SERPENT_STING_ID,
            raptor = RAPTOR_STRIKE_ID,
        },
    }
end

--- Returns expected clipping for the currently recommended action when available.
--- @return number|nil expectedClipSeconds
--- @return string|nil actionType
function HunterWeaveModule:GetExpectedClipNow()
    local snapshot = self:GetWeaveSnapshot()
    if type(snapshot) ~= "table" or snapshot.ok ~= true then
        return nil, nil
    end
    local nextSpellId = tonumber(NAG and NAG.nextSpell or 0) or 0
    return ResolveExpectedClipForSpell(snapshot, nextSpellId)
end

--- External accessor for UI/debug modules without direct module coupling.
--- @return number|nil expectedClipSeconds
--- @return string|nil actionType
function NAG:GetHunterExpectedClip()
    local module = NAG:GetModule("HunterWeaveModule", true)
    if not module or type(module.GetExpectedClipNow) ~= "function" then
        return nil, nil
    end
    return module:GetExpectedClipNow()
end

function HunterWeaveModule:GetRotationPattern()
    local swingState = self:GetSwingState()
    if not swingState.ok or not swingState.ranged then
        return { ok = false, reason = "no_ranged_swing_info" }
    end

    local ews = swingState.ranged.speed
    local pattern = classifyPattern(ews)
    local snapshot = self:GetWeaveSnapshot()
    if not snapshot.ok then
        return { ok = false, reason = snapshot.reason or "snapshot_unavailable" }
    end

    local canFrench = pattern.name == "french_5511" or pattern.name == "french_5611"
    local wantsCatchup = pattern.name == "french_5911" or pattern.name == "one_to_two" or pattern.name == "one_to_three"
    local result = {
        ok = true,
        ews = ews,
        pattern = pattern.name,
        label = pattern.label,
        band = pattern.band,
        rotationKey = pattern.rotationKey,
        canFrench = canFrench,
        wantsCatchup = wantsCatchup,
        waitNow = snapshot.waitNow,
        snapshot = snapshot,
    }

    if shouldLog(self, "pattern") then
        if pattern.name ~= lastPatternName then
            lastPatternName = pattern.name
            local formattedEws = ews and string.format("%.2f", ews) or "?"
            if NAG.DevDebug then
                NAG:DevDebug("HunterWeave pattern -> " .. tostring(pattern.name) .. " (eWS=" .. formattedEws .. ")")
            end
        end
    end

    return result
end

function HunterWeaveModule:GetRotationKey()
    local pat = self:GetRotationPattern()
    if not pat or not pat.ok then
        return "unknown"
    end
    return pat.rotationKey or "unknown"
end

function HunterWeaveModule:HunterHasTwoHanderEquipped()
    if not GetInventoryItemLink then
        return false
    end
    local mainHandLink = GetInventoryItemLink("player", INVSLOT_MAINHAND)
    if not mainHandLink then
        return false
    end
    local offhandLink = GetInventoryItemLink("player", INVSLOT_OFFHAND)
    return offhandLink == nil
end

--- Check if the player has Windfury Totem weapon buff active
--- Uses NAG:AuraIsActive to check for Windfury Totem buff IDs on the player only
--- @return boolean True if player has any rank of Windfury Totem buff active
function HunterWeaveModule:HunterHasWindfury()
    -- Windfury Totem weapon buff spell IDs (TBC ranks)
    -- These are the buff IDs that appear on the player when they have Windfury Totem
    local windfuryBuffIds = {
        [8516] = true,   -- Windfury Totem (Rank 1 weapon buff)
        [10608] = true,  -- Windfury Totem (Rank 2 weapon buff)
        [10610] = true,  -- Windfury Totem (Rank 3 weapon buff)
        [25583] = true,  -- Windfury Totem (Rank 4 weapon buff)
        [25584] = true,  -- Windfury Totem (Rank 5 weapon buff)
    }

    -- Check if player has any of the Windfury Totem buffs active
    if NAG and NAG.AuraIsActive then
        for buffId, _ in pairs(windfuryBuffIds) do
            if NAG:AuraIsActive(buffId, "player") then
                return true
            end
        end
    end

    return false
end

function HunterWeaveModule:HunterIsCasting()
    if not UnitCastingInfo then
        return false
    end
    local spellName = UnitCastingInfo("player")
    return spellName ~= nil
end

--- Get precise distance information to target (debug function)
--- Returns detailed distance information using LibRangeCheck-3.0
--- @param unit string Optional unit to check (defaults to "target")
--- @return number|nil, number|nil, string Returns: bestDistance, maxDistance, precisionInfo
---         bestDistance: Most precise distance estimate (minRange when available, else maxRange)
---         maxDistance: Maximum distance bound (nil if beyond detectable range)
---         precisionInfo: String describing precision ("exact", "range band", "minimum only", "unknown")
function HunterWeaveModule:HunterGetTargetDistance(unit)
    -- Ensure unit is a valid string
    if not unit or type(unit) ~= "string" then
        unit = "target"
    end

    local RC = ns.RC
    if not RC or not RC.GetRange then
        return nil, nil, "no range checker"
    end

    -- RC:GetRange handles UnitExists check internally and returns nil,nil if unit doesn't exist
    -- Try without visibility check first (more lenient)
    local minRange, maxRange = RC:GetRange(unit, false)

    -- If no result, try with visibility check
    if not minRange and not maxRange then
        minRange, maxRange = RC:GetRange(unit, true)
    end

    -- If still no result, check if unit exists for better error message
    if not minRange and not maxRange then
        -- Check if unit exists (UnitName would error if unit doesn't exist, so just check UnitExists)
        if _G.UnitExists and not _G.UnitExists(unit) then
            return nil, nil, "no target"
        end
        return nil, nil, "out of range"
    end

    -- Determine precision and best estimate
    local bestDistance
    local precisionInfo

    if minRange and maxRange then
        -- We have both bounds - this gives us a range band
        if minRange == maxRange then
            -- Exact distance
            bestDistance = minRange
            precisionInfo = string.format("exact (%d yd)", minRange)
        else
            -- Range band - use minRange as best estimate (closest bound)
            bestDistance = minRange
            precisionInfo = string.format("range band (%d-%d yd)", minRange, maxRange)
        end
    elseif minRange then
        -- Only minimum distance (target is at least X yards away, possibly further)
        bestDistance = minRange
        precisionInfo = string.format("minimum only (>=%d yd)", minRange)
    elseif maxRange then
        -- Only maximum distance (shouldn't happen, but handle it)
        bestDistance = maxRange
        precisionInfo = string.format("maximum only (<=%d yd)", maxRange)
    else
        return nil, nil, "unknown"
    end

    return bestDistance, maxRange, precisionInfo
end

--- Get precise distance information for 0-10 yard range using spell range checks
--- Uses spell range checks (no item dependencies) to provide granular distance bands critical for melee weaving
--- @param unit string Optional unit to check (defaults to "target")
--- @return number|nil, number|nil, string Returns: bestDistance, maxDistance, precisionInfo
---         bestDistance: Best distance estimate in yards
---         maxDistance: Maximum distance bound
---         precisionInfo: Detailed precision info with distance band
function HunterWeaveModule:HunterGetPreciseDistance(unit)
    -- Ensure unit is a valid string
    if not unit or type(unit) ~= "string" then
        unit = "target"
    end

    -- Basic validation
    if not _G.UnitExists(unit) or not UnitIsVisible(unit) then
        return nil, nil, "no target or not visible"
    end

    if not UnitCanAttack("player", unit) then
        return nil, nil, "cannot attack"
    end

    -- Spell IDs for range detection
    local RAPTOR_STRIKE_SPELL_ID = 2974 -- Melee ability (~5 yards max range)
    local ARCANE_SHOT_RANK1_ID = 3044 -- Arcane Shot Rank 1 (5-35 yard range - min 5, max 35)
    local AUTO_SHOT_SPELL_ID = 75 -- Auto Shot (~35 yards max range)

    -- Helper function to check if spell is in range
    -- Returns: true (in range), false (out of range), nil (unknown/not known)
    local function checkSpellInRange(spellId)
        if not IsSpellInRange then
            return nil
        end

        -- Check if spell is known first (optional but helps debugging)
        if NAG and NAG.IsKnownSpell and not NAG:IsKnownSpell(spellId) then
            return nil -- Spell not known
        end

        -- Try with spell ID first (TBC/Classic API)
        local result = IsSpellInRange(spellId, unit)
        if result == 1 then
            return true  -- In range
        elseif result == 0 then
            return false -- Out of range
        end
        -- If nil, try with spell name as fallback
        if GetSpellInfo then
            local spellName = GetSpellInfo(spellId)
            if spellName then
                result = IsSpellInRange(spellName, unit)
                if result == 1 then
                    return true
                elseif result == 0 then
                    return false
                end
            end
        end
        return nil -- Unknown or spell not known
    end

    -- Check if spell is usable (considers range, cooldown, mana, etc.)
    -- Note: IsUsableSpell returns nil if spell doesn't exist or isn't learned
    local function checkSpellUsable(spellId)
        local IsUsableSpell = _G.IsUsableSpell
        if not IsUsableSpell then
            return nil
        end
        local usable = IsUsableSpell(spellId)
        return usable -- true if usable, false/nil if not
    end

    -- Check ranges using spell-based detection
    -- IMPORTANT: This must work for non-target units (nameplates), so do NOT rely on TargetInMeleeRange here.
    -- Raptor Strike is the most reliable "0-5y" signal for any unit.
    local raptorInRange = IsSpellInRangeUnified(RAPTOR_STRIKE_SPELL_ID, unit)
    local inClosestMeleeRange = (raptorInRange == true)

    local inArcaneShotRange = IsSpellInRangeUnified(ARCANE_SHOT_RANK1_ID, unit)
    local inAutoShotRange = IsSpellInRangeUnified(AUTO_SHOT_SPELL_ID, unit)

    -- If Arcane Shot range is nil, the spell might not be known or IsSpellInRange failed
    -- In this case, fall back to LibRangeCheck which uses item/spell checks
    if inArcaneShotRange == nil then
        -- Arcane Shot check failed, use LibRangeCheck fallback
        local RC = ns.RC
        if RC and RC.GetRange then
            local minRange, maxRange = RC:GetRange(unit, false)
            if minRange or maxRange then
                local bestDistance = minRange or maxRange
                local maxDistance = maxRange
                local precisionInfo

                -- Best-effort labeling based on the returned band.
                if maxRange and maxRange <= 5 then
                    precisionInfo = "melee weave range (fallback, 0-5 yd)"
                elseif minRange and minRange >= 5 and maxRange and maxRange <= 8 then
                    precisionInfo = "sweetspot range (fallback, 5-8 yd)"
                else
                    precisionInfo = string.format("fallback range (%s-%s yd)", tostring(minRange or "?"), tostring(maxRange or "?"))
                end

                return bestDistance, maxDistance, precisionInfo
            end
        end
        return nil, nil, "unable to determine range (Arcane Shot not known or check failed)"
    end

    -- Determine precise distance band based on range checks
    local bestDistance, maxDistance
    local precisionInfo

    -- MELEE WEAVE RANGE (0-5 yards): Raptor Strike in range.
    -- We treat this as authoritative for per-unit checks.
    if inClosestMeleeRange == true then
        bestDistance = 2.5 -- Approximate middle of melee range
        maxDistance = 5
        precisionInfo = "melee weave range (0-5 yd)"
    -- SWEETSPOT RANGE (5-8 yards): Raptor out of range AND Arcane Shot is in range.
    -- Spell checks tell us "not melee" + ">=5". LibRangeCheck is used only to distinguish <=8 vs >8.
    elseif inArcaneShotRange == true and inClosestMeleeRange == false then
        -- Prefer the classic sweetspot item check if enabled/available (very accurate in practice).
        -- Item 8149 is commonly used by hunters to detect the ~8y bound.
        local preferItem = self.db and self.db.class and self.db.class.preferSweetSpotItem
        local sweetItemId = self.db and self.db.class and self.db.class.sweetSpotItemId or 8149
        if preferItem then
            local itemInRange = IsItemInRangeUnified(sweetItemId, unit)
            -- If item is in range AND we're not in melee AND Arcane is in range => sweetspot.
            if itemInRange == true then
                bestDistance = 6.5
                maxDistance = 8
                precisionInfo = "sweetspot range (5-8 yd, item check)"
            else
                -- fall through to LibRangeCheck refinement below
            end
        end

        if precisionInfo then
            return bestDistance, maxDistance, precisionInfo
        end

        local RC = ns.RC
        local minRange, maxRangeBand
        if RC and RC.GetRange then
            -- noItems=true avoids item-based checkers that can misreport 0-5 even when the spell checks say otherwise.
            minRange, maxRangeBand = RC:GetRange(unit, false, true)
        end

        -- If RC contradicts the spell checks (e.g. says 0-5 while Raptor is out and Arcane is in),
        -- trust the spell checks and treat as sweetspot (as-close-as-possible but not melee).
        if maxRangeBand and maxRangeBand <= 5 then
            bestDistance = 6.5
            maxDistance = 8
            precisionInfo = "sweetspot range (5-8 yd, RC contradicted)"
        -- If we have a max bound <=8, treat as sweetspot even if minRange is missing.
        elseif maxRangeBand and maxRangeBand <= 8 then
            bestDistance = 6.5 -- Middle of sweetspot range
            maxDistance = 8
            precisionInfo = "sweetspot range (5-8 yd)"
        else
            -- CLOSE-MEDIUM RANGE (8+ yards): Arcane Shot in range but not in sweetspot.
            -- Use LibRangeCheck (noItems=true) for a best-effort range band; otherwise fall back to a generic 8-35 label.
            if minRange or maxRangeBand then
                local minLabel = minRange or 8
                local maxLabel = maxRangeBand or 35
                if minLabel < 8 then minLabel = 8 end
                bestDistance = minLabel
                maxDistance = maxLabel
                precisionInfo = string.format("far away (close-medium range, %d-%d yd)", minLabel, maxLabel)
            else
                bestDistance = 20
                maxDistance = 35
                precisionInfo = "far away (close-medium range, 8-35 yd)"
            end
        end
    -- AUTO SHOT RANGE (35+ yards): Out of Arcane Shot but in Auto Shot range
    elseif inAutoShotRange == true and inArcaneShotRange == false then
        bestDistance = 35
        maxDistance = 35
        precisionInfo = "auto shot range (~35 yd, Arcane Shot out of range)"
    -- Out of range
    elseif inAutoShotRange == false then
        return nil, nil, "out of auto shot range (>35 yd)"
    -- Unable to determine
    else
        -- Fallback to LibRangeCheck if available
        local RC = ns.RC
        if RC and RC.GetRange then
            local minRange, maxRange = RC:GetRange(unit, false)
            if minRange or maxRange then
                bestDistance = minRange or maxRange
                maxDistance = maxRange
                precisionInfo = string.format("fallback range (%s-%s yd)", tostring(minRange or "?"), tostring(maxRange or "?"))
            else
                return nil, nil, "unable to determine range"
            end
        else
            return nil, nil, "unable to determine range"
        end
    end

    return bestDistance, maxDistance, precisionInfo
end

--- Check if the hunter is in sweetspot range (5-8 yards where Arcane Shot is castable)
--- @param unit string Optional unit to check (defaults to "target")
--- @return boolean True if in sweetspot range, false otherwise
function HunterWeaveModule:HunterInSweetSpot(unit)
    if not unit or type(unit) ~= "string" then
        unit = "target"
    end

    -- Use the same classification as HunterGetPreciseDistance (spell checks + minimal RC usage).
    local _, _, info = self:HunterGetPreciseDistance(unit)
    if not info then
        return false
    end
    return tostring(info):find("^sweetspot range") ~= nil
end

--- Check if the hunter is in melee range (0-5 yards where Arcane Shot is NOT castable)
--- @param unit string Optional unit to check (defaults to "target")
--- @return boolean True if in melee range, false otherwise
function HunterWeaveModule:HunterInMelee(unit)
    if not unit or type(unit) ~= "string" then
        unit = "target"
    end

    local debug = unit ~= "target" -- Only debug for non-target units

    if debug then
        print(string.format("[HunterInMelee] Checking unit: %s", unit))
    end

    if not _G.UnitExists(unit) then
        if debug then print("[HunterInMelee] Unit does not exist") end
        return false
    end

    -- Nameplates can report UnitIsVisible=nil/false; don't hard-block them.
    if not unit:find("^nameplate") then
        if not UnitIsVisible(unit) then
            if debug then print("[HunterInMelee] Unit is not visible") end
            return false
        end
    end

    if not UnitCanAttack("player", unit) then
        if debug then print("[HunterInMelee] Cannot attack unit") end
        return false
    end

    local ARCANE_SHOT_RANK1_ID = 3044
    local RAPTOR_STRIKE_ID = 2974

    local raptorInRange = IsSpellInRangeUnified(RAPTOR_STRIKE_ID, unit)
    if debug then
        print(string.format("[HunterInMelee] Raptor in range: %s", tostring(raptorInRange)))
    end

    -- For mouseover/nameplates: this is the most reliable "0-5y" signal.
    if raptorInRange == true then
        return true
    end

    -- Target fallback: preserve original semantics for "too close for Arcane Shot".
    if unit == "target" then
        local inClosestMeleeRange = NAG:TargetInMeleeRange(1) or false
        local arcaneInRange = IsSpellInRangeUnified(ARCANE_SHOT_RANK1_ID, unit)
        return inClosestMeleeRange == true and arcaneInRange == false
    end

    return false
end

--- Check if the hunter is far away (beyond sweetspot range)
--- @param unit string Optional unit to check (defaults to "target")
--- @return boolean True if far away (>8 yards), false otherwise
function HunterWeaveModule:HunterFarAway(unit)
    if not unit or type(unit) ~= "string" then
        unit = "target"
    end

    if not _G.UnitExists(unit) or not UnitIsVisible(unit) or not UnitCanAttack("player", unit) then
        return false
    end

    if not unit or type(unit) ~= "string" then
        unit = "target"
    end

    local _, _, info = self:HunterGetPreciseDistance(unit)
    if not info then
        return false
    end

    -- FarAway = anything other than melee and sweetspot (i.e. the next detectable range band)
    local s = tostring(info)
    if s:find("^melee weave range") then
        return false
    end
    if s:find("^sweetspot range") then
        return false
    end
    return true
end

--- Get melee weaving positioning suggestion for 2H hunters.
--- Only relevant when melee weaving is possible but mouseover weave is not available.
--- @param unit string Optional unit to check (defaults to "target")
--- @return "closer"|"farther"|"hold"|nil "closer" = move in, "farther" = move out, "hold" = stay put, nil = hide indicator
function HunterWeaveModule:GetWeavePositioningSuggestion(unit)
    if not (self.db and self.db.class and self.db.class.showPositioningSuggestions) then
        return nil
    end
    if not self:HunterHasTwoHanderEquipped() then
        return nil
    end
    if not self.isBM or not (self.db and self.db.class and self.db.class.enabled) then
        return nil
    end
    unit = unit or "target"
    if not _G.UnitExists(unit) or not UnitIsVisible(unit) or not UnitCanAttack("player", unit) then
        return nil
    end
    if self:HunterCanMouseoverWeave() then
        return nil
    end
    if self:HunterInMelee(unit) then
        return "farther"
    end
    if self:HunterInSweetSpot(unit) then
        return "hold"
    end
    if self:HunterFarAway(unit) then
        return "closer"
    end
    return nil
end

--- Debug function to test Arcane Shot range detection methods
--- Tests various APIs to determine when Arcane Shot Rank 1 (3044) is out of range due to being too close
--- @param unit string Optional unit to check (defaults to "target")
--- @return table Returns table with all range check results for debugging
function HunterWeaveModule:HunterTestArcaneShotRange(unit)
    -- Ensure unit is a valid string
    if not unit or type(unit) ~= "string" then
        unit = "target"
    end

    local ARCANE_SHOT_RANK1_ID = 3044

    local results = {
        unit = unit,
        spellId = ARCANE_SHOT_RANK1_ID,
    }

    -- Basic checks
    results.unitExists = _G.UnitExists(unit) or false
    results.unitVisible = UnitIsVisible and UnitIsVisible(unit) or false
    results.unitCanAttack = _G.UnitCanAttack and _G.UnitCanAttack("player", unit) or false

    -- Method 1: IsSpellInRange
    if IsSpellInRange then
        local spellName = GetSpellInfo and GetSpellInfo(ARCANE_SHOT_RANK1_ID)
        results.isSpellInRangeById = IsSpellInRange(ARCANE_SHOT_RANK1_ID, unit) -- 1 = in range, 0 = out, nil = unknown
        if spellName then
            results.isSpellInRangeByName = IsSpellInRange(spellName, unit)
        end
    end

    -- Method 2: IsUsableSpell (may not respect min range)
    local IsUsableSpell = _G.IsUsableSpell
    if IsUsableSpell then
        results.isUsableSpell = IsUsableSpell(ARCANE_SHOT_RANK1_ID) or false
        -- Get error message if not usable
        local usable, notEnoughMana = IsUsableSpell(ARCANE_SHOT_RANK1_ID)
        results.isUsableSpellUsable = usable or false
        results.isUsableSpellNotEnoughMana = notEnoughMana or false
    end

    -- Method 3: NAG:SpellCanCast (may not respect min range)
    if NAG and NAG.SpellCanCast then
        results.nagSpellCanCast = NAG:SpellCanCast(ARCANE_SHOT_RANK1_ID) or false
    end

    -- Method 4: TargetInMeleeRange check
    if NAG and NAG.TargetInMeleeRange then
        results.targetInMeleeRange1 = NAG:TargetInMeleeRange(1) or false
        results.targetInMeleeRange5 = NAG:TargetInMeleeRange(5) or false
    end

    -- Method 5: GetSpellInfo to check min/max range
    if GetSpellInfo then
        local name, rank, icon, castTime, minRange, maxRange = GetSpellInfo(ARCANE_SHOT_RANK1_ID)
        results.spellInfo = {
            name = name,
            minRange = minRange,
            maxRange = maxRange,
            castTime = castTime,
        }
    end

    -- Method 6: LibRangeCheck GetRange
    local RC = ns.RC
    if RC and RC.GetRange then
        local minRange, maxRange = RC:GetRange(unit, false)
        results.libRangeCheck = {
            minRange = minRange,
            maxRange = maxRange,
        }
    end

    -- Method 7: UnitDistance
    if NAG and NAG.UnitDistance then
        results.unitDistance = NAG:UnitDistance(unit) or -1
    end

    return results
end

--- Check if there are any other enemies in melee range that are not the main target
--- Uses TTDManager's existing enemy counting infrastructure for efficient detection
--- @return boolean True if there are other enemies in melee range besides the current target
function HunterWeaveModule:HunterCanMouseoverWeave()
    -- Check if there are other units around the hunter where NAG:HunterInMelee() is true
    -- but NOT for the main target (so we can mouseover weave them)

    -- local dbg = self.db and self.db.class and self.db.class.debugMouseoverWeave
    -- if dbg then
    --     print("[HunterCanMouseoverWeave] Starting check")
    -- end

    -- First check if main target is in melee - if it is, we don't want to mouseover weave
    local targetInMelee = NAG:HunterInMelee("target")
    -- if dbg then
    --     print("[HunterCanMouseoverWeave] Target in melee:", tostring(targetInMelee))
    -- end
    if targetInMelee then
        -- Target is in melee, we don't want to mouseover weave
        -- if dbg then
        --     print("[HunterCanMouseoverWeave] Target is in melee, returning false")
        -- end
        return false
    end

    -- Target is not in melee, check if there are any other enemies in melee range
    -- Use the same logic as NAG:NumberTargets - iterate through iterable units and check range
    local iterableUnits = ns.GetIterableUnits()
    if not iterableUnits then
        -- if dbg then
        --     print("[HunterCanMouseoverWeave] No iterable units, returning false")
        -- end
        return false
    end

    local targetGUID = UnitExists("target") and UnitGUID("target") or nil
    -- if dbg then
    --     print("[HunterCanMouseoverWeave] Target GUID:", tostring(targetGUID))
    --     print("[HunterCanMouseoverWeave] Total iterable units:", #iterableUnits)
    -- end

    -- Iterate through all iterable units (indices 1-4 are "player", "focus", "target", "mouseover")
    -- We start from index 1 to check all units, not just nameplates
    -- local checkedCount = 0
    -- local validEnemyCount = 0
    -- local skippedTargetCount = 0
    -- local inMeleeCount = 0

    for i = 1, #iterableUnits do
        local unit = iterableUnits[i]
        -- checkedCount = checkedCount + 1

        if UnitExists(unit) then
            local canAttack = UnitCanAttack("player", unit)
            -- if dbg then
            --     print(string.format("[HunterCanMouseoverWeave] Unit[%d]=%s exists=%s canAttack=%s", i, tostring(unit), tostring(UnitExists(unit)), tostring(canAttack)))
            -- end

            if canAttack then
                -- validEnemyCount = validEnemyCount + 1
                -- Skip if this is the main target (by GUID comparison)
                local unitGUID = UnitGUID(unit)
                -- if dbg then
                --     print(string.format("[HunterCanMouseoverWeave]   Unit GUID: %s", tostring(unitGUID)))
                -- end

                if unitGUID and targetGUID and unitGUID == targetGUID then
                    -- This is the main target, skip it
                    -- skippedTargetCount = skippedTargetCount + 1
                    -- if dbg then
                    --     print("[HunterCanMouseoverWeave]   Skipping main target")
                    -- end
                else
                    -- Per-unit melee check for mouseover weaving:
                    -- Use Raptor Strike range (0-5y) to determine if that unit is weaveable.
                    local inMelee = self:HunterInMelee(unit)
                    -- if dbg then
                    --     print(string.format("[HunterCanMouseoverWeave]   %s in melee: %s", unit, tostring(inMelee)))
                    -- end

                    if inMelee then
                        -- inMeleeCount = inMeleeCount + 1
                        -- Found another enemy in melee weave range - we can mouseover weave them
                        -- if dbg then
                        --     print(string.format("[HunterCanMouseoverWeave] Found unit %s in melee range, returning true", unit))
                        -- end
                        return true
                    end
                end
            end
        end
    end

    -- if dbg then
    --     print(string.format("[HunterCanMouseoverWeave] Summary: checked=%d, validEnemy=%d, skippedTarget=%d, inMelee=%d, returning false",
    --         checkedCount, validEnemyCount, skippedTargetCount, inMeleeCount))
    -- end
    return false
end

function HunterWeaveModule:HunterShouldWeave()
    -- Returns: shouldWeave, mode, unit
    -- mode: "target" | "mouseover"
    if not self.isBM or not (self.db and self.db.class and self.db.class.enabled) then
        return false, nil, nil
    end

    if not self:HunterHasTwoHanderEquipped() then
        return false, nil, nil
    end

    if self:HunterIsCasting() then
        return false, nil, nil
    end

    local snap = self:GetWeaveSnapshot()
    if not snap or not snap.ok then
        return false, nil, nil
    end

    local weaveCost = self.db.class.weaveProcessCostSeconds or 0.360
    if type(weaveCost) ~= "number" or weaveCost < 0 then
        weaveCost = 0.360
    end

    -- Weave must never jeopardize the next ranged auto.
    if (snap.rangedTimeToNext or 0) < weaveCost then
        return false, nil, nil
    end

    -- Target weave if already in melee.
    if self:InMeleeRange() then
        return true, "target", "target"
    end

    -- Mouseover weave: allow if a mouseover unit is in melee range (no movement required).
    if self:HunterCanMouseoverWeave() then
        return true, "mouseover", "mouseover"
    end

    return false, nil, nil
end

function HunterWeaveModule:HunterCastSteadyIfSafe()
    local snap = self:GetWeaveSnapshot()
    if not snap or not snap.ok then
        return false
    end
    -- Wind-up semantics: Steady is press-safe during the last 0.5s before Auto fires.
    if not snap.canSteadyPress then
        return false
    end

    local swingKey = snap.rangedLastSwing
    if not TrySpendActionBudget(self, swingKey, STEADY_SHOT_ID) then
        return false
    end

    -- If GCD is still ticking but Steady would be safe exactly at GCD end, show a HOLD overlay.
    local gcdLeft = snap.gcdLeft or 0
    if gcdLeft > 0 then
        local ttnAtGcdEnd = (snap.rangedTimeToNext or 0) - gcdLeft
        local needed = (snap.steadyCast or 0) + (snap.adjustedInputDelay or 0)
        if ttnAtGcdEnd > needed and NAG.CastSpell then
            return NAG:CastSpell(STEADY_SHOT_ID, 3, ns.SPELL_POSITIONS.PRIMARY, nil, "SS")
        end
    end

    return NAG:Cast(STEADY_SHOT_ID)
end

function HunterWeaveModule:HunterCastFillerIfSafe()
    local snap = self:GetWeaveSnapshot()
    if not snap or not snap.ok then
        return false
    end
    if snap.waitNow then
        return false
    end

    local swingKey = snap.rangedLastSwing

    -- Multi-Shot first if it is press-safe (including during Auto wind-up).
    if snap.canMultiPress and NAG.SpellIsReady and NAG:SpellIsReady(MULTI_SHOT_ID) then
        if TrySpendActionBudget(self, swingKey, MULTI_SHOT_ID) then
            return NAG:Cast(MULTI_SHOT_ID, nil, ns.SPELL_POSITIONS.AOE)
        end
    end

    -- Arcane as fallback filler (instant-safe window).
    if snap.canInstant and NAG.SpellIsReady and NAG:SpellIsReady(ARCANE_SHOT_ID) then
        if TrySpendActionBudget(self, swingKey, ARCANE_SHOT_ID) then
            return NAG:Cast(ARCANE_SHOT_ID)
        end
    end

    return false
end

function HunterWeaveModule:HunterWeaveNotClipping()
    local shouldWeave, mode, unit = self:HunterShouldWeave()
    if not shouldWeave then
        return false
    end

    local snap = self:GetWeaveSnapshot()
    if not snap or not snap.ok then
        return false
    end

    local swingKey = snap.rangedLastSwing
    if not TrySpendActionBudget(self, swingKey, RAPTOR_STRIKE_ID) then
        return false
    end

    local overlay = "Weave"
    if mode == "mouseover" then
        overlay = "Mouseover\nmacro\nand Weave"
    end

    local wf = self:HunterHasWindfury()
    local rsReady = NAG.SpellIsReady and NAG:SpellIsReady(RAPTOR_STRIKE_ID) or true

    -- Heuristic: without Windfury, only recommend when Raptor Strike is ready.
    if not wf and not rsReady then
        return false
    end

    -- NOTE: We do not attempt to force target switching; we only provide a recommendation + overlay text.
    return NAG:Cast(RAPTOR_STRIKE_ID, nil, ns.SPELL_POSITIONS.RIGHT, nil, overlay)
end

function HunterWeaveModule:HunterFrenchMultiReady()
    local pattern = self:GetRotationPattern()
    if not pattern.ok or not pattern.canFrench then
        return false
    end
    local snap = pattern.snapshot
    if not snap or not snap.ok then
        return false
    end
    if snap.waitNow then
        return false
    end
    -- Wind-up semantics: Multi is press-safe during the last 0.5s before Auto fires.
    if not snap.canMultiPress then
        return false
    end
    if NAG.SpellIsReady then
        return NAG:SpellIsReady(MULTI_SHOT_ID)
    end
    return true
end

function HunterWeaveModule:HunterFrenchArcaneReady()
    local pattern = self:GetRotationPattern()
    if not pattern.ok or not pattern.canFrench then
        return false
    end
    local snap = pattern.snapshot
    if not snap or not snap.ok then
        return false
    end
    if snap.waitNow then
        return false
    end
    if not snap.canInstant then
        return false
    end
    if NAG.SpellIsReady then
        return NAG:SpellIsReady(ARCANE_SHOT_ID)
    end
    return true
end

function HunterWeaveModule:HunterMeleeReady()
    local snap = self:GetWeaveSnapshot()
    if not snap.ok then
        return false
    end
    if not snap.canMelee then
        return false
    end
    if NAG.SpellIsReady then
        return NAG:SpellIsReady(RAPTOR_STRIKE_ID)
    end
    return true
end

function HunterWeaveModule:HunterWaitForAuto()
    local snap = self:GetWeaveSnapshot()
    if not snap.ok then
        return 0
    end
    if snap.waitNow then
        return snap.rangedTimeToNext or 0
    end
    return 0
end

function HunterWeaveModule:HunterSafeSteady()
    local snap = self:GetWeaveSnapshot()
    if not snap.ok then
        return false
    end
    if snap.waitNow then
        return false
    end
    return snap.canSteadyPress
end

function HunterWeaveModule:HunterSafeSteadyNow()
    local snap = self:GetWeaveSnapshot()
    if not snap or not snap.ok then
        return false
    end
    if snap.waitNow then
        return false
    end
    return snap.canSteadyNow or false
end

function HunterWeaveModule:HunterSafeMultiNow()
    local snap = self:GetWeaveSnapshot()
    if not snap or not snap.ok then
        return false
    end
    if snap.waitNow then
        return false
    end
    if NAG.SpellIsReady and not NAG:SpellIsReady(MULTI_SHOT_ID) then
        return false
    end
    return snap.canMultiNow or false
end

-- ============================ FILLER GAP / MS->SS->AR RULES ============================

function HunterWeaveModule:HunterArcaneAllowed()
    -- Enforce: at least one Steady between Multi and Arcane (no MS->AR back-to-back).
    return not needsSteadyAfterMulti
end

function HunterWeaveModule:HunterInExtraGap()
    local snap = self:GetWeaveSnapshot()
    if not snap or not snap.ok then
        return false
    end
    if not extraGapUntil then
        return false
    end
    local now = snap.now or GetTime()
    -- Extra gap is only meaningful while Auto Shot is running.
    if not self:HunterIsAutoShooting() then
        return false
    end
    return now < extraGapUntil
end

-- ============================ SIMLIKE CORE SHOTS (TIMING-ONLY) ============================

--- Determines whether Multi-Shot should be saved for catch-up timing.
--- Mirrors the wowsims TBC hunter `useMultiForCatchup` switch using only timing primitives.
--- @param snap table|nil Optional snapshot to reuse (for performance)
--- @return boolean
function HunterWeaveModule:HunterSimlikeUseMultiForCatchup(snap)
    snap = snap or self:GetWeaveSnapshot()
    if not snap or not snap.ok then
        return false
    end

    local rangedSpeed = tonumber(snap.rangedSpeed or 0) or 0
    local windup = tonumber(snap.rangedWindupSeconds or GetPaddedRangedWindupSeconds(snap.rangedSpeed)) or 0.5
    if rangedSpeed <= 0 then
        return false
    end

    local rangedGap = rangedSpeed - windup
    if rangedGap < 0 then
        rangedGap = 0
    end

    local gcdDefault = 1.5
    local autoCycleDuration = rangedGap
    local safetyBumps = 0
    -- In the sim this loop adds (rangedGap + windup) each iteration, which equals rangedSpeed.
    while autoCycleDuration < gcdDefault and safetyBumps < 10 do
        autoCycleDuration = autoCycleDuration + rangedSpeed
        safetyBumps = safetyBumps + 1
    end
    if autoCycleDuration < gcdDefault then
        autoCycleDuration = gcdDefault
    end

    local leftoverGCDRatio = (autoCycleDuration - gcdDefault) / rangedSpeed
    return leftoverGCDRatio < 0.95
end

--- Returns true if starting Steady at the next GCD-ready moment would finish after wind-up start (clipping boundary).
--- Mirrors the sim's `ssWouldClip` predicate in `lazyRotation`.
--- Clipping = delaying wind-up start; boundary is wind-up start, not Auto fire.
--- @param snap table|nil Optional snapshot to reuse (for performance)
--- @return boolean
function HunterWeaveModule:HunterSimlikeSteadyWouldClip(snap)
    snap = snap or self:GetWeaveSnapshot()
    if not snap or not snap.ok then
        return false
    end

    -- Evaluate at the *actual* next-action moment (max of GCD end / cast end / queued Steady end),
    -- consistent with other hunter timing predicates in this module.
    local readyIn = GetEffectiveReadyIn(snap)
    local shootAt = tonumber(snap.rangedTimeToNext or 0) or 0
    local windupSeconds = tonumber(snap.rangedWindupSeconds or 0.5) or 0.5
    local steadyCast = tonumber(snap.steadyCast or 0) or 0
    local clipTolerance = tonumber(snap.clipToleranceSeconds or 0.10) or 0.10
    if clipTolerance < 0 then
        clipTolerance = 0
    end
    -- Clipping boundary = wind-up start = shootAt - windupSeconds
    local windupStartAt = shootAt - windupSeconds
    if windupStartAt < 0 then
        windupStartAt = 0
    end
    return (readyIn + steadyCast) > (windupStartAt + clipTolerance)
end

--- Returns true if Multi-Shot should be used this GCD per SIM-like timing rules.
--- This intentionally avoids damage modeling; the key SIM behavior we mimic is Multi "catch-up" gating:
--- when `useMultiForCatchup` is enabled, only use Multi if it delays the next Auto less than Steady would.
--- @param snap table|nil Optional snapshot to reuse (for performance)
--- @return boolean
function HunterWeaveModule:HunterSimlikeMultiAllowedThisGCD(snap)
    snap = snap or self:GetWeaveSnapshot()
    if not snap or not snap.ok then
        return false
    end
    if snap.waitNow then
        return false
    end
    if snap.steadyQueued then
        -- A queued Steady consumes the next cast slot; don't try to front-run it with MS.
        return false
    end
    if NAG.SpellIsReady and not NAG:SpellIsReady(MULTI_SHOT_ID) then
        return false
    end
    if not self:HunterSafeToCast(MULTI_SHOT_ID) then
        return false
    end

    local useCatchup = self:HunterSimlikeUseMultiForCatchup(snap)
    if not useCatchup then
        return true
    end

    local readyIn = GetEffectiveReadyIn(snap)
    local shootAt = tonumber(snap.rangedTimeToNext or 0) or 0
    local windupSeconds = tonumber(snap.rangedWindupSeconds or 0.5) or 0.5
    local windupStartAt = shootAt - windupSeconds
    if windupStartAt < 0 then
        windupStartAt = 0
    end

    local multiCast = tonumber(snap.multiCast or 0) or 0
    local steadyCast = tonumber(snap.steadyCast or 0) or 0

    -- Delay measured against wind-up start (clipping boundary)
    local multiShootDelay = (readyIn + multiCast) - windupStartAt
    if multiShootDelay < 0 then multiShootDelay = 0 end
    local steadyShootDelay = (readyIn + steadyCast) - windupStartAt
    if steadyShootDelay < 0 then steadyShootDelay = 0 end

    return multiShootDelay < steadyShootDelay
end

--- Returns true if we should attempt a melee weave recommendation now (SIM-like).
--- In the sim, weaving is only chosen when Auto is not ready and we are otherwise GCD-locked.
--- @param snap table|nil Optional snapshot to reuse (for performance)
--- @return boolean
function HunterWeaveModule:HunterSimlikeShouldWeaveNow(snap)
    snap = snap or self:GetWeaveSnapshot()
    if not snap or not snap.ok then
        return false
    end
    if snap.waitNow then
        return false
    end

    -- Only during downtime: when both auto and GCD are currently on CD.
    local nextActionDelay = GetEffectiveReadyIn(snap)
    if nextActionDelay <= 0 then
        return false
    end

    local shouldWeave = self:HunterShouldWeave()
    return shouldWeave and true or false
end

--- Single entrypoint for SIM-like core shot decisions (timing-only, GCD-oriented).
--- Order mirrors sim `lazyRotation`: weave (downtime) -> shoot (handled elsewhere) -> multi -> arcane (only if SS would clip) -> steady -> hold.
--- @return boolean
function HunterWeaveModule:HunterSimlikeCoreShots()
    local snap = self:GetWeaveSnapshot()
    if not snap or not snap.ok then
        return false
    end

    -- 1) Weave only during downtime (GCD-locked) and only if it won't jeopardize next ranged auto.
    if self:HunterSimlikeShouldWeaveNow(snap) then
        if self:HunterWeaveNotClipping() then
            return true
        end
    end

    -- 2) Explicit wait if an Auto is imminent (but never during wind-up, where queueing a cast is intended).
    local waitSeconds = self:HunterWaitForAuto()
    if waitSeconds and waitSeconds > 0 then
        if NAG.Wait then
            return NAG:Wait(waitSeconds)
        end
        return true
    end

    -- 3) Multi-Shot if ready and allowed by catch-up timing.
    if self:HunterSimlikeMultiAllowedThisGCD(snap) then
        if self:HunterCastMultiNow() then
            return true
        end
    end

    -- 4) Arcane Shot only when Steady would clip the next Auto, and only when Arcane is allowed + safe.
    local arcaneReady = true
    if NAG.SpellIsReady and not NAG:SpellIsReady(ARCANE_SHOT_ID) then
        arcaneReady = false
    end
    if arcaneReady and self:HunterArcaneAllowed() and self:HunterSimlikeSteadyWouldClip(snap) and self:HunterSafeToCast(ARCANE_SHOT_ID) then
        if self:HunterCastArcaneNow() then
            return true
        end
    end

    -- 5) Default: Steady (includes wind-up queue semantics + queued-steady handling).
    if self:HunterCastSteadyNow() then
        return true
    end

    -- 6) HOLD overlay until it is time to start pressing / queueing Steady.
    return self:HunterSteadyHold()
end

--- Predict the next N castable actions using a real timing state machine.
--- This returns pressability times (includes GCD/cast lockout) and the hold time between ready and press.
--- Main kinds: SS, FILLER (MS > AR). WEAVE is scaffolded but not used unless enabled later.
--- @param count number|nil Number of future steps to return (default 3, max 30)
--- @return table
function HunterWeaveModule:HunterPredictFutureActions(count)
    return { ok = false, reason = "prediction_disabled" }
end

-- ============================ FILLER PREDICTOR (SS -> MS/AR) ============================

--- Predict the earliest filler (MS/AR) that can follow a correctly executed Steady Shot.
--- Assumes SS is the next action and will be queued/cast safely; returns the next filler timing.
--- @return table
function HunterWeaveModule:HunterPredictFillerAfterSteady()
    return { ok = false, reason = "prediction_disabled" }
end

--- Return the three slot views for the prediction bars (stable, takes turns, auto-anchored).
--- Slot mapping: bar(headSlot)=A1, next bar=A2, next bar=A3.
--- @return table
function HunterWeaveModule:HunterGetPredictionSlots()
    return { ok = false, reason = "prediction_disabled" }
end

-- ============================ SIMLIKE ADAPTIVE SCORING (RELATIVE WEIGHTS) ============================

local SCORE_DISABLED = -10000.0

local function ClampNumber(v, fallback)
    if type(v) ~= "number" then
        return fallback
    end
    if v ~= v then
        return fallback
    end
    return v
end

local function Max0(v)
    v = ClampNumber(v, 0)
    if v < 0 then
        return 0
    end
    return v
end

local function GetAdaptiveWeights(self)
    local w = (self and self.db and self.db.class and self.db.class.adaptiveWeights) or nil
    w = w or {}
    return {
        shoot = ClampNumber(w.shoot, 1.0),
        steady = ClampNumber(w.steady, 1.0),
        multi = ClampNumber(w.multi, 1.0),
        arcane = ClampNumber(w.arcane, 1.0),
        weave = ClampNumber(w.weave, 1.0),
    }
end

--- Compute a SIM-inspired score table (avgWeight - DPS*delay) at the next actionable moment.
--- This is for in-game testing/tuning and intentionally uses only relative weights (no damage sim).
--- @param snap table|nil Optional snapshot to reuse
--- @return table
function HunterWeaveModule:HunterAdaptiveScoreSnapshot(snap)
    snap = snap or self:GetWeaveSnapshot()
    if not snap or not snap.ok then
        return { ok = false, reason = (snap and snap.reason) or "no_snapshot" }
    end

    local weights = GetAdaptiveWeights(self)
    local threshold = ClampNumber(self.db and self.db.class and self.db.class.adaptiveCatchupThreshold, 0.95)

    local readyIn = GetEffectiveReadyIn(snap)
    local ttn = ClampNumber(snap.rangedTimeToNext, 0)
    local speed = ClampNumber(snap.rangedSpeed, 0)
    local windup = ClampNumber(snap.rangedWindupSeconds, 0.5)
    local delay = ClampNumber(snap.adjustedInputDelay, 0)
    local instantSafety = ClampNumber(snap.instantSafetyBuffer, 0)

    local steadyCast = ClampNumber(snap.steadyCast, 0)
    local multiCast = ClampNumber(snap.multiCast, 0)

    local weaveCost = ClampNumber(self.db and self.db.class and self.db.class.weaveProcessCostSeconds, 0.360)
    if weaveCost <= 0 then weaveCost = 0.360 end

    -- Rates (mirrors sim structure, but uses relative weights).
    local shootRate = (speed > 0) and (1.0 / speed) or 0
    local gcdRate = 1.0 / (1.5 + Max0(delay))
    local weaveRate = 1.0 / weaveCost

    local shootDPS = weights.shoot * shootRate
    local steadyDPS = weights.steady * gcdRate
    local weaveDPS = weights.weave * weaveRate

    -- Delays (all evaluated at next-action moment).
    local steadyNeeded = steadyCast + delay
    local multiNeeded = multiCast + delay
    local arcaneNeeded = delay + instantSafety

    local steadyShootDelay = Max0((readyIn + steadyNeeded) - ttn)
    local multiShootDelay = Max0((readyIn + multiNeeded) - ttn)
    local arcaneShootDelay = Max0((readyIn + arcaneNeeded) - ttn)

    -- Approximate "shoot option": do nothing until the next auto, then act.
    -- We treat the opportunity cost as delaying the next GCD-cast option by (ttn - readyIn) if ready before auto.
    local shootGCDDelay = Max0(ttn - readyIn)

    -- Weave delays
    local weaveShootDelay = Max0((readyIn + weaveCost) - ttn)
    local weaveGCDDelay = weaveCost

    local useCatchup = self:HunterSimlikeUseMultiForCatchup(snap)

    local scoreShoot = weights.shoot - (steadyDPS * shootGCDDelay)
    local scoreSteady = weights.steady - (shootDPS * steadyShootDelay)
    local scoreMulti = weights.multi - (shootDPS * multiShootDelay)
    local scoreArcane = weights.arcane - (shootDPS * arcaneShootDelay)
    local scoreWeave = weights.weave - (steadyDPS * weaveGCDDelay) - (shootDPS * weaveShootDelay)

    -- Apply availability/safety gates (keep the score shape but make invalid options unpickable).
    local canSteady = false
    if snap.rangedInWindup and not snap.steadyQueued then
        -- Queue semantics: Steady is press-safe in wind-up (queues behind Auto).
        canSteady = true
    else
        canSteady = self:HunterSafeToCast(STEADY_SHOT_ID) and true or false
    end
    if not canSteady then
        scoreSteady = SCORE_DISABLED
    end

    local canMulti = (not snap.steadyQueued) and (not snap.waitNow) and (self:HunterSafeToCast(MULTI_SHOT_ID)) and true or false
    if NAG.SpellIsReady and not NAG:SpellIsReady(MULTI_SHOT_ID) then
        canMulti = false
    end
    if useCatchup and (multiShootDelay >= steadyShootDelay) then
        canMulti = false
    end
    if not canMulti then
        scoreMulti = SCORE_DISABLED
    end

    local canArcane = (not snap.steadyQueued) and (not snap.waitNow) and self:HunterArcaneAllowed() and (self:HunterSafeToCast(ARCANE_SHOT_ID)) and true or false
    if NAG.SpellIsReady and not NAG:SpellIsReady(ARCANE_SHOT_ID) then
        canArcane = false
    end
    if not canArcane then
        scoreArcane = SCORE_DISABLED
    end

    local canWeave = self:HunterSimlikeShouldWeaveNow(snap) and true or false
    if not canWeave then
        scoreWeave = SCORE_DISABLED
    end

    -- Choose best option (ties prefer less disruptive ordering).
    local bestOption = "shoot"
    local bestScore = scoreShoot
    if scoreWeave > bestScore then bestOption, bestScore = "weave", scoreWeave end
    if scoreMulti > bestScore then bestOption, bestScore = "multi", scoreMulti end
    if scoreArcane > bestScore then bestOption, bestScore = "arcane", scoreArcane end
    if scoreSteady > bestScore then bestOption, bestScore = "steady", scoreSteady end

    return {
        ok = true,
        bestOption = bestOption,
        bestScore = bestScore,
        readyIn = readyIn,
        ttn = ttn,
        speed = speed,
        windup = windup,
        useCatchup = useCatchup,
        catchupThreshold = threshold,
        scores = {
            shoot = scoreShoot,
            steady = scoreSteady,
            multi = scoreMulti,
            arcane = scoreArcane,
            weave = scoreWeave,
        },
        delays = {
            shootGCD = shootGCDDelay,
            steadyShoot = steadyShootDelay,
            multiShoot = multiShootDelay,
            arcaneShoot = arcaneShootDelay,
            weaveShoot = weaveShootDelay,
            weaveGCD = weaveGCDDelay,
        },
        weights = weights,
    }
end

--- Execute the best-scoring SIM-like action at the current moment.
--- @return boolean
function HunterWeaveModule:HunterAdaptiveCoreShots()
    if not (self.db and self.db.class and self.db.class.adaptiveScoringEnabled) then
        return false
    end

    local snap = self:GetWeaveSnapshot()
    if not snap or not snap.ok then
        return false
    end

    local result = self:HunterAdaptiveScoreSnapshot(snap)
    if not result or not result.ok then
        return false
    end

    local best = result.bestOption
    if best == "weave" then
        return self:HunterWeaveNotClipping()
    elseif best == "multi" then
        -- Prefer filler preview while GCD is ticking; otherwise cast now.
        if (snap.gcdLeft or 0) > 0 and self:HunterCastMultiFiller() then
            return true
        end
        return self:HunterCastMultiNow()
    elseif best == "arcane" then
        if (snap.gcdLeft or 0) > 0 and self:HunterCastArcaneFiller() then
            return true
        end
        return self:HunterCastArcaneNow()
    elseif best == "steady" then
        -- If GCD is ticking, allow the tolerant preview mode; otherwise use the strict now/queue semantics.
        if (snap.gcdLeft or 0) > 0 and self:HunterCastSteadyIfSafe() then
            return true
        end
        return self:HunterCastSteadyNow()
    end

    -- Best was "shoot" (or nothing else was valid): prefer explicit wait if appropriate.
    local waitSeconds = self:HunterWaitForAuto()
    if waitSeconds and waitSeconds > 0 and NAG.Wait then
        return NAG:Wait(waitSeconds)
    end
    return self:HunterSteadyHold()
end

-- ============================ SIMPLE PREDICATES FOR APL ============================

--- Returns true when GCD landing still leaves room inside the early Steady gap.
--- We project GCD landing onto the current/next swing cycle(s) and require:
--- landingTtn > (steadyCast + 0.05).
--- @return boolean
function HunterWeaveModule:HunterEarlyGapMath()
    local snap = self:GetWeaveSnapshot()
    if not snap or not snap.ok then
        return false
    end

    local swingSpeed = tonumber(snap.rangedSpeed or 0) or 0
    if swingSpeed <= 0 then
        return false
    end

    local ttn = tonumber(snap.rangedTimeToNext or 0) or 0
    if ttn <= 0 then
        return false
    end

    local steadyCast = tonumber(snap.steadyCast or 0) or 0
    local gcdRemaining = (NAG.GCDTimeToReady and NAG:GCDTimeToReady()) or 0
    if gcdRemaining < 0 then
        gcdRemaining = 0
    end

    local landingTtn = ttn - gcdRemaining
    while landingTtn < 0 do
        landingTtn = landingTtn + swingSpeed
    end

    return landingTtn > (steadyCast + 0.05)
end

--- True if we are currently in Auto Shot's warm-up window (last 0.5s before Auto fires).
--- @return boolean
function HunterWeaveModule:HunterInWarmUp()
    local snap = self:GetWeaveSnapshot()
    if snap and snap.ok then
        local windup = tonumber(snap.rangedWindupSeconds or GetPaddedRangedWindupSeconds(snap.rangedSpeed)) or 0.5
        local ttn = tonumber(snap.rangedTimeToNext or 0) or 0
        local readyIn = tonumber(snap.nextActionDelay or 0) or 0

        -- If Steady is queued (pressed in wind-up) but not yet casting, nextActionDelay can be misleading:
        -- GCD may already be running, but the queued Steady cast will still "consume time" and can push the
        -- next actionable moment into (or out of) wind-up. For warm-up classification we must consider
        -- whichever ends later: max(GCD end, current cast end, queued Steady end).
        if snap.steadyQueued and snap.queuedSteadyEndAt and snap.now then
            local queuedEndIn = (tonumber(snap.queuedSteadyEndAt) or 0) - (tonumber(snap.now) or 0)
            if queuedEndIn < 0 then queuedEndIn = 0 end
            if queuedEndIn > readyIn then
                readyIn = queuedEndIn
            end
        end

        -- If swing timer is not yet providing a countdown (ttn==0) right after enabling Auto Shot,
        -- treat it as "unknown ttn" and fall back to the toggle-based warm-up model.
        if ttn <= 0 then
            local enabledAt = self.GetAutoShotEnabledAt and self:GetAutoShotEnabledAt() or nil
            local now = GetTime()
            local windupSec = GetPaddedRangedWindupSeconds(snap.rangedSpeed)
            if enabledAt and (now - enabledAt) >= 0 and (now - enabledAt) <= windupSec then
                local ttnFallback = windupSec - (now - enabledAt)
                local ttnAtReadyFallback = ttnFallback - readyIn
                return (ttnAtReadyFallback > 0 and ttnAtReadyFallback <= windupSec) and true or false
            end
            if autoShotRequestedAt and (now - autoShotRequestedAt) >= 0 and (now - autoShotRequestedAt) <= windupSec then
                local ttnFallback = windupSec - (now - autoShotRequestedAt)
                local ttnAtReadyFallback = ttnFallback - readyIn
                return (ttnAtReadyFallback > 0 and ttnAtReadyFallback <= windupSec) and true or false
            end
        end

        -- Consider warm-up at the moment we can actually press the next action:
        -- max(GCD end, current cast end, queued Steady end). If readyIn==0, this reduces to "right now".
        local ttnAtReady = ttn - readyIn
        return (ttnAtReady > 0 and ttnAtReady <= windup) and true or false
    end

    -- Fallback: handle the initial Auto Shot warm-up right after toggling Auto Shot on.
    -- When Auto Shot is enabled from an "off" state, there is a fixed 0.5s warm-up before the first Auto fires,
    -- and you can queue casted shots during that warm-up.
    local enabledAt = self.GetAutoShotEnabledAt and self:GetAutoShotEnabledAt() or nil
    if not enabledAt then
        if autoShotRequestedAt then
            local now = GetTime()
            local elapsed = now - autoShotRequestedAt
            local windup = GetPaddedRangedWindupSeconds()
            if elapsed >= 0 and elapsed <= windup then
                local ttn = windup - elapsed
                local gcdLeft = (NAG.GCDTimeToReady and NAG:GCDTimeToReady()) or 0
                if gcdLeft < 0 then gcdLeft = 0 end
                local castRemaining = 0
                local _, _, _, _, endTimeMS = UnitCastingInfo("player")
                if endTimeMS then
                    castRemaining = (endTimeMS / 1000) - now
                    if castRemaining < 0 then castRemaining = 0 end
                end
                local readyIn = gcdLeft
                if castRemaining > readyIn then
                    readyIn = castRemaining
                end
                local ttnAtReady = ttn - readyIn
                return (ttnAtReady > 0 and ttnAtReady <= windup) and true or false
            end
        end
        return false
    end

    local now = GetTime()
    local elapsed = now - enabledAt
    if elapsed < 0 then
        elapsed = 0
    end

    local windup = GetPaddedRangedWindupSeconds()
    if elapsed > windup then
        return false
    end

    -- Compute "time-to-first-auto" and then apply the same next-action-moment logic.
    local ttn = windup - elapsed
    if ttn <= 0 then
        return false
    end

    local gcdLeft = (NAG.GCDTimeToReady and NAG:GCDTimeToReady()) or 0
    if gcdLeft < 0 then gcdLeft = 0 end

    local castRemaining = 0
    local _, _, _, _, endTimeMS = UnitCastingInfo("player")
    if endTimeMS then
        castRemaining = (endTimeMS / 1000) - now
        if castRemaining < 0 then castRemaining = 0 end
    end

    local readyIn = gcdLeft
    if castRemaining > readyIn then
        readyIn = castRemaining
    end

    local ttnAtReady = ttn - readyIn
    return (ttnAtReady > 0 and ttnAtReady <= windup) and true or false
end

--- True if Steady Shot is currently queued (pressed during wind-up) but not yet casting.
--- @return boolean
function HunterWeaveModule:HunterSSQueued()
    local snap = self:GetWeaveSnapshot()
    if not snap or not snap.ok then
        return false
    end
    local isQueued = (NAG.IsQueued and NAG:IsQueued(STEADY_SHOT_ID)) and true or false

    local _, _, _, _, _, _, _, _, castingSpellId = UnitCastingInfo("player")
    local isCastingSteady = (castingSpellId == STEADY_SHOT_ID) and true or false
    if not isCastingSteady then
        -- Not casting: queued means queued-only (exactly what we want for "don't recommend Steady again yet").
        return isQueued
    end

    -- Casting Steady:
    -- We normally treat Steady as "in-flight" (block recommending it again), but we intentionally
    -- drop that block near the end of the GCD so the UI can show Steady again for back-to-back queueing.
    local gcdLeft = (NAG.GCDTimeToReady and NAG:GCDTimeToReady()) or 0
    if gcdLeft < 0 then gcdLeft = 0 end
    if gcdLeft <= 0.500 then
        return false
    end
    return true
end

--- True if Multi-Shot is currently queued (pressed during wind-up) or casting.
--- @return boolean
function HunterWeaveModule:HunterMSQueued()
    local snap = self:GetWeaveSnapshot()
    if not snap or not snap.ok then
        return false
    end
    local _, _, _, _, _, _, _, _, castingSpellId = UnitCastingInfo("player")
    local isCastingMulti = (castingSpellId == MULTI_SHOT_ID) and true or false
    return ((snap.multiQueued and true or false) or isCastingMulti) and true or false
end

--- Returns true when filler is still safe to show while Steady is queued.
--- Uses the later of (GCD end, SS cast end) and blocks if it lands after:
--- upcomingSwingTime + weaponSpeed - 0.6
--- @return boolean
function HunterWeaveModule:HunterQueuedSSFillerWindowOK()
    local snap = self:GetWeaveSnapshot()
    if not snap or not snap.ok then
        return false
    end

    local ttn = tonumber(snap.rangedTimeToNext or 0) or 0
    local speed = tonumber(snap.rangedSpeed or 0) or 0
    if ttn <= 0 or speed <= 0 then
        return false
    end

    local now = tonumber(snap.now or 0) or 0
    if now <= 0 then
        now = GetTime()
    end

    local gcdRemaining = (NAG.GCDTimeToReady and NAG:GCDTimeToReady()) or 0
    if gcdRemaining < 0 then
        gcdRemaining = 0
    end

    local ssCastRemaining = 0
    if snap.steadyQueued and snap.queuedSteadyEndAt and now > 0 then
        ssCastRemaining = (tonumber(snap.queuedSteadyEndAt) or 0) - now
        if ssCastRemaining < 0 then
            ssCastRemaining = 0
        end
    else
        local _, _, _, _, endTimeMS, _, _, _, castingSpellId = UnitCastingInfo("player")
        if castingSpellId == STEADY_SHOT_ID and endTimeMS then
            ssCastRemaining = (endTimeMS / 1000) - now
            if ssCastRemaining < 0 then
                ssCastRemaining = 0
            end
        end
    end

    local finishLater = gcdRemaining
    if ssCastRemaining > finishLater then
        finishLater = ssCastRemaining
    end

    local latestAllowed = ttn + speed - 0.6
    return finishLater <= latestAllowed
end

--- True if casting the given spell at the next-action moment (max of GCD end or cast end)
--- will finish before the next Auto Shot boundary (i.e., not clip/delay the next Auto).
--- @param spellId number
--- @return boolean
function HunterWeaveModule:HunterSafeToCast(spellId)
    if type(spellId) ~= "number" then
        return false
    end
    local snap = self:GetWeaveSnapshot()
    if not snap or not snap.ok then
        return false
    end

    local ttn = tonumber(snap.rangedTimeToNext or 0) or 0
    if ttn <= 0 then
        return false
    end

    local now = tonumber(snap.now or 0) or 0
    if now <= 0 then
        now = GetTime()
    end

    local baseReadyIn = tonumber(snap.nextActionDelay or 0) or 0
    local readyIn = baseReadyIn

    -- IMPORTANT (TBC Hunter): If Steady is queued during wind-up, it will not begin until the Auto fires,
    -- but the GCD typically starts at the moment you press/queue Steady (not at Steady cast start).
    -- Therefore, when SS is queued we must account for the upcoming Steady *cast lockout* (queued cast end),
    -- but we should NOT add an extra "GCD after Steady" window on top of the already-running GCD.
    local queuedDelay = 0
    local queuedStartAt = tonumber(snap.queuedSteadyStartAt or 0) or 0
    if snap.steadyQueued and queuedStartAt > 0 then
        local startIn = queuedStartAt - now
        if startIn < 0 then startIn = 0 end

        local steadyCast = tonumber(snap.steadyCast or 0) or 0
        queuedDelay = startIn + steadyCast
        if queuedDelay > readyIn then
            readyIn = queuedDelay
        end
    end

    -- If the next-action moment occurs AFTER the next Auto would have fired,
    -- we must evaluate against the *next* auto boundary in line (ttn + N*speed).
    -- This happens notably when:
    -- - a queued Steady will only start after the next Auto, and its GCD pushes the next action beyond that Auto
    -- - GCD/cast delays push readiness beyond the current-cycle Auto boundary
    local speed = tonumber(snap.rangedSpeed or 0) or 0
    if speed <= 0 then
        return false
    end

    local autoBoundaryIn = ttn
    local boundaryBumps = 0
    while autoBoundaryIn <= readyIn and boundaryBumps < 5 do
        autoBoundaryIn = autoBoundaryIn + speed
        boundaryBumps = boundaryBumps + 1
    end

    local ttnAtReady = autoBoundaryIn - readyIn
    if ttnAtReady <= 0 then
        return false
    end

    local windupSeconds = tonumber(snap.rangedWindupSeconds or GetPaddedRangedWindupSeconds(snap.rangedSpeed)) or 0.5
    -- Clipping boundary = wind-up start; time to wind-up start when we're ready
    local ttnToWindupStartAtReady = ttnAtReady - windupSeconds
    if ttnToWindupStartAtReady < 0 then
        ttnToWindupStartAtReady = 0
    end

    local delay = tonumber(snap.adjustedInputDelay or 0) or 0
    local clipTolerance = tonumber(snap.clipToleranceSeconds or 0.10) or 0.10
    if clipTolerance < 0 then
        clipTolerance = 0
    end
    local needed = 0
    -- Accept rank variants used by APL calls (e.g., max-rank IDs in TBC rotations).
    local isSteadySpell = (spellId == STEADY_SHOT_ID)
    local isMultiSpell = (spellId == MULTI_SHOT_ID) or (spellId == 27021) -- Multi-Shot Rank 6 (TBC)
    local isArcaneSpell = (spellId == ARCANE_SHOT_ID) or (spellId == 27019) -- Arcane Shot Rank 9 (TBC)
    local isAimedSpell = (spellId == AIMED_SHOT_ID)

    if isSteadySpell then
        needed = (tonumber(snap.steadyCast or 0) or 0) + delay
        return (ttnToWindupStartAtReady + clipTolerance) > needed
    end

    if isMultiSpell then
        -- Do NOT allow Multi to be recommended if we're currently in/near Auto wind-up
        -- (or if by the next-action moment we'd be there). In wind-up we keep queuing Steady.
        local windup = tonumber(snap.rangedWindupSeconds or GetPaddedRangedWindupSeconds(snap.rangedSpeed)) or 0.5
        local queueZoneBuffer = 0.075 -- 75ms safety margin
        local queueZoneThreshold = windup + queueZoneBuffer
        local inOrNearQueueZoneNow = ttn <= queueZoneThreshold
        local inOrNearQueueZoneAtReady = ttnAtReady <= queueZoneThreshold
        if inOrNearQueueZoneNow or inOrNearQueueZoneAtReady then
            return false
        end

        -- Per TBC hunter behavior: treat Multi as a fixed 0.5s cast for safety gating.
        -- Clipping boundary = wind-up start.
        needed = 0.5 + delay

        if false and self.Print then
            self:Print(string.format(
                "[BMDBG] SafeToCast(MS) queuedSS=%s steadyCast=%.3f learned=%.3f model=%s baseSteady=%.3f haste=%.3f queuedStartIn=%.3f queuedSteadyEndIn=%.3f baseReadyIn=%.3f queuedDelay=%.3f readyIn=%.3f ttn=%.3f speed=%.3f boundaryIn=%.3f bumps=%d ttnAtReady=%.3f needed=%.3f",
                tostring(snap.steadyQueued),
                tonumber(snap.steadyCast or 0) or 0,
                tonumber(learnedSteadyCastSeconds or 0) or 0,
                tostring(lastSteadyCastModel),
                tonumber(lastBaseSteadyCastObserved or 0) or 0,
                tonumber(lastHasteFactorObserved or 0) or 0,
                (snap.steadyQueued and queuedStartAt > 0) and ((queuedStartAt - now) > 0 and (queuedStartAt - now) or 0) or 0,
                (snap.steadyQueued and queuedStartAt > 0) and (function()
                    local startIn = queuedStartAt - now
                    if startIn < 0 then startIn = 0 end
                    local s = tonumber(snap.steadyCast or 0) or 0
                    return startIn + s
                end)() or 0,
                tonumber(baseReadyIn) or 0,
                tonumber(queuedDelay) or 0,
                tonumber(readyIn) or 0,
                tonumber(ttn) or 0,
                tonumber(speed) or 0,
                tonumber(autoBoundaryIn) or 0,
                tonumber(boundaryBumps) or 0,
                tonumber(ttnAtReady) or 0,
                tonumber(needed) or 0
            ))
        end
        return (ttnToWindupStartAtReady + clipTolerance) > needed
    end

    if isArcaneSpell then
        -- Do NOT allow Arcane to be recommended if it would be started inside the Auto wind-up (queue-zone),
        -- or even too close to it. In warm-up we only want Steady (queue SS), never fillers.
        local windup = tonumber(snap.rangedWindupSeconds or GetPaddedRangedWindupSeconds(snap.rangedSpeed)) or 0.5
        local queueZoneBuffer = 0.075 -- 75ms (same safety margin as Multi)
        local queueZoneThreshold = windup + queueZoneBuffer
        local inOrNearQueueZone = (ttn <= queueZoneThreshold) or (ttnAtReady <= queueZoneThreshold)
        if inOrNearQueueZone then
            if false and self.Print then
                self:Print(string.format(
                    "[BMDBG] SafeToCast(AR) BLOCKED(queueZone) ttnAtReady=%.3f windup=%.3f buffer=%.3f threshold=%.3f",
                    tonumber(ttnAtReady) or 0,
                    tonumber(windup) or 0,
                    tonumber(queueZoneBuffer) or 0,
                    tonumber(queueZoneThreshold) or 0
                ))
            end
            return false
        end

        needed = delay + (tonumber(snap.instantSafetyBuffer or 0) or 0)
        return (ttnToWindupStartAtReady + clipTolerance) > needed
    end

    -- Aimed Shot (27065): safe when cast in the wind-up (like queuing Steady), otherwise only when 3s cast fits before wind-up start.
    if isAimedSpell then
        if self:HunterInWarmUp() then
            return true
        end
        needed = 3.0 + delay
        return (ttnToWindupStartAtReady + clipTolerance) > needed
    end

    -- Default: unknown spell, assume unsafe.
    return false
end

function HunterWeaveModule:HunterCastSteadyNow()
    local snap = self:GetWeaveSnapshot()
    if not snap or not snap.ok or snap.waitNow then
        local now = GetTime()
        if not lastSteadyDebugAt or (now - lastSteadyDebugAt) > 0.50 then
            lastSteadyDebugAt = now
            local reason = (snap and snap.reason) or "nil_snap_or_waitNow"
            if self.Print then
                -- self:Print(string.format("[HunterCastSteadyNow] blocked: ok=%s waitNow=%s reason=%s",
                --     tostring(snap and snap.ok), tostring(snap and snap.waitNow), tostring(reason)))
            end
        end
        return false
    end

    -- If Steady is already queued during wind-up, don't keep recommending it.
    -- Let the APL flow to "next in line" predictions instead.
    if snap.steadyQueued and snap.rangedInWindup then
        DebugTrace(self, "decision", "SS: skip (already queued in wind-up)", 0.20)
        return false
    end

    -- Normal "finish-before-auto" cast.
    if snap.canSteadyNow then
        DebugTrace(self, "decision", string.format(
            "SS: castNow ttn=%.3f speed=%.3f steadyCast=%.3f queued=%s",
            tonumber(snap.rangedTimeToNext or 0) or 0,
            tonumber(snap.rangedSpeed or 0) or 0,
            tonumber(snap.steadyCast or 0) or 0,
            tostring(snap.steadyQueued)
        ), 0.20)
        local ok = NAG:Cast(STEADY_SHOT_ID)
        if ok then
            -- A Steady after Multi clears the MS->AR restriction.
            needsSteadyAfterMulti = false
        end
        local now = GetTime()
        if not lastSteadyDebugAt or (now - lastSteadyDebugAt) > 0.50 then
            lastSteadyDebugAt = now
            if self.Print then
                -- self:Print(string.format(
                --     "[HunterCastSteadyNow] canNow=%s castOk=%s ttn=%.3f speed=%.3f steadyCast=%.3f delay=%.3f inWindup=%s",
                --     tostring(snap.canSteadyNow),
                --     tostring(ok),
                --     tonumber(snap.rangedTimeToNext or 0) or 0,
                --     tonumber(snap.rangedSpeed or 0) or 0,
                --     tonumber(snap.steadyCast or 0) or 0,
                --     tonumber(snap.adjustedInputDelay or 0) or 0,
                --     tostring(snap.rangedInWindup)
                -- ))
            end
        end
        return ok
    end

    -- Queue semantics: inside Auto Shot wind-up, Steady is press-safe (queues behind Auto).
    -- We surface Steady as the primary icon via CastSpell so the user knows to start spamming to queue.
    if snap.rangedInWindup then
        DebugTrace(self, "decision", string.format("SS: showQueueIcon ttn=%.3f", tonumber(snap.rangedTimeToNext or 0) or 0), 0.20)
        local now = GetTime()
        if not lastSteadyDebugAt or (now - lastSteadyDebugAt) > 0.50 then
            lastSteadyDebugAt = now
            if self.Print then
                -- self:Print(string.format(
                --     "[HunterCastSteadyNow] windup-queue: ttn=%.3f steadyCast=%.3f (showing CastSpell)",
                --     tonumber(snap.rangedTimeToNext or 0) or 0,
                --     tonumber(snap.steadyCast or 0) or 0
                -- ))
            end
        end
        return NAG:CastSpell(STEADY_SHOT_ID, 3, ns.SPELL_POSITIONS.PRIMARY, nil, nil)
    end

    return false
end

--- When Steady is queued (pressed during wind-up) but not yet casting, show the next recommended action
--- instead of repeating Steady as "next".
--- In most practical haste regimes this will be a HOLD towards the next wind-up, but we keep the same priority:
--- SS > MS > Arcane > SS HOLD.
--- @return boolean
function HunterWeaveModule:HunterNextActionWhenSteadyQueued()
    local snap = self:GetWeaveSnapshot()
    if not snap or not snap.ok then
        return false
    end
    if not snap.steadyQueued then
        return false
    end
    -- If Steady already started casting, other logic handles it.
    if (snap.castingSpellId or 0) == STEADY_SHOT_ID then
        return false
    end

    -- Predict the timeline for a queued Steady:
    -- Auto fires at rangedExpiration, then the queued Steady starts immediately after that.
    -- We can then compute the remaining time before the *next* Auto boundary to decide fillers,
    -- even before Steady begins casting (this is the UX you want).
    local now = tonumber(snap.now or 0) or GetTime()
    local speed = tonumber(snap.rangedSpeed or 0) or 0
    local exp = tonumber(snap.rangedExpiration or 0) or 0
    if speed <= 0 or exp <= 0 then
        return false
    end

    local steadyStartAt = tonumber(snap.queuedSteadyStartAt or 0) or 0
    if steadyStartAt <= 0 then
        steadyStartAt = exp
    end
    local steadyEndAt = tonumber(snap.queuedSteadyEndAt or 0) or 0
    if steadyEndAt <= 0 then
        steadyEndAt = steadyStartAt + (tonumber(snap.steadyCast or 0) or 0)
    end

    -- Next Auto after the auto that triggers the queued cast.
    -- If Steady would overlap the next Auto, that Auto is delayed to Steady end.
    local nextAutoAfterSteadyAt = steadyStartAt + speed
    if steadyEndAt > nextAutoAfterSteadyAt then
        nextAutoAfterSteadyAt = steadyEndAt
    end

    -- Remaining time between Steady finishing and the next Auto boundary.
    local availableAfterSteady = nextAutoAfterSteadyAt - steadyEndAt
    if availableAfterSteady < 0 then
        availableAfterSteady = 0
    end

    -- Also account for any GCD time that might still be left when Steady ends.
    local gcdLeftNow = tonumber(snap.gcdLeft or 0) or 0
    local gcdLeftAtSteadyEnd = gcdLeftNow - (steadyEndAt - now)
    if gcdLeftAtSteadyEnd < 0 then
        gcdLeftAtSteadyEnd = 0
    end
    availableAfterSteady = availableAfterSteady - gcdLeftAtSteadyEnd
    if availableAfterSteady < 0 then
        availableAfterSteady = 0
    end

    local delay = tonumber(snap.adjustedInputDelay or 0) or 0
    local steadyNeeded = (tonumber(snap.steadyCast or 0) or 0) + delay
    local multiNeeded = (tonumber(snap.multiCast or 0) or 0) + delay
    local instantNeeded = delay + (tonumber(snap.instantSafetyBuffer or 0) or 0)

    -- Priority: SS > MS > AR > SS HOLD
    if availableAfterSteady > steadyNeeded then
        return NAG:CastSpell(STEADY_SHOT_ID, 3, ns.SPELL_POSITIONS.PRIMARY, nil, nil)
    end

    local multiReady = true
    if NAG.SpellIsReady then
        multiReady = NAG:SpellIsReady(MULTI_SHOT_ID) and true or false
    end
    if multiReady and availableAfterSteady > multiNeeded then
        return NAG:CastSpell(MULTI_SHOT_ID, 3, ns.SPELL_POSITIONS.PRIMARY, nil, nil)
    end

    local arcaneReady = true
    if NAG.SpellIsReady then
        arcaneReady = NAG:SpellIsReady(ARCANE_SHOT_ID) and true or false
    end
    if self:HunterArcaneAllowed() and arcaneReady and availableAfterSteady > instantNeeded then
        return NAG:CastSpell(ARCANE_SHOT_ID, 3, ns.SPELL_POSITIONS.PRIMARY, nil, nil)
    end

    return self:HunterSteadyHold()
end

-- ============================ NEXT ACTION (WHILE CASTING STEADY) ============================

--- While casting Steady Shot, predict the next best weave action within the current Auto Shot cycle.
--- Priority requested:
--- - If gap is weavable and SS fits: show SS (no HOLD)
--- - Else if gap is weavable and SS doesn't fit but MS fits: show MS (no HOLD)
--- - Else if gap is weavable and SS doesn't fit and MS is on CD: show Arcane (no HOLD)
--- - Else (gap not weavable): show Steady HOLD (until next wind-up / next Auto)
--- Additionally, if at cast completion we'll be inside wind-up (\(ttn <= 0.5\)), show Steady (queue) with no HOLD.
--- @return boolean
function HunterWeaveModule:HunterNextActionWhileCastingSteady()
    local snap = self:GetWeaveSnapshot()
    if not snap or not snap.ok then
        return false
    end
    if (snap.castingSpellId or 0) ~= STEADY_SHOT_ID then
        return false
    end

    local readyIn = tonumber(snap.nextActionDelay or 0) or 0
    if readyIn <= 0 then
        return false
    end

    local ttn = tonumber(snap.rangedTimeToNext or 0) or 0
    local ttnAtReady = ttn - readyIn
    if ttnAtReady <= 0 then
        return self:HunterSteadyHold()
    end

    local windup = tonumber(snap.rangedWindupSeconds or GetPaddedRangedWindupSeconds(snap.rangedSpeed)) or 0.5
    if ttnAtReady <= windup then
        -- Cast will finish in/near wind-up: Steady is press-safe to queue behind the imminent Auto.
        return NAG:CastSpell(STEADY_SHOT_ID, 3, ns.SPELL_POSITIONS.PRIMARY, nil, nil)
    end

    local steadyNeeded = (tonumber(snap.steadyCast or 0) or 0) + (tonumber(snap.adjustedInputDelay or 0) or 0)
    if ttnAtReady > steadyNeeded then
        return NAG:CastSpell(STEADY_SHOT_ID, 3, ns.SPELL_POSITIONS.PRIMARY, nil, nil)
    end

    local multiReady = true
    if NAG.SpellIsReady then
        multiReady = NAG:SpellIsReady(MULTI_SHOT_ID) and true or false
    end
    if multiReady then
        local multiNeeded = (tonumber(snap.multiCast or 0) or 0) + (tonumber(snap.adjustedInputDelay or 0) or 0)
        if ttnAtReady > multiNeeded then
            return NAG:CastSpell(MULTI_SHOT_ID, 3, ns.SPELL_POSITIONS.PRIMARY, nil, nil)
        end
    end

    local arcaneReady = true
    if NAG.SpellIsReady then
        arcaneReady = NAG:SpellIsReady(ARCANE_SHOT_ID) and true or false
    end
    if self:HunterArcaneAllowed() and arcaneReady then
        local instantNeeded = (tonumber(snap.adjustedInputDelay or 0) or 0) + (tonumber(snap.instantSafetyBuffer or 0) or 0)
        if ttnAtReady > instantNeeded then
            return NAG:CastSpell(ARCANE_SHOT_ID, 3, ns.SPELL_POSITIONS.PRIMARY, nil, nil)
        end
    end

    return self:HunterSteadyHold()
end

function HunterWeaveModule:HunterCastMultiNow()
    local snap = self:GetWeaveSnapshot()
    if not snap or not snap.ok or snap.waitNow then
        return false
    end
    if snap.rangedInWindup then
        return false
    end
    if not snap.canMultiNow then
        return false
    end
    if NAG.SpellIsReady and not NAG:SpellIsReady(MULTI_SHOT_ID) then
        return false
    end
    if snap.steadyQueued then
        -- A queued Steady will consume the next cast slot; do not suggest MS until after it resolves.
        DebugTrace(self, "decision", "MS: skip (SS queued)", 0.20)
        return false
    end
    DebugTrace(self, "decision", string.format("MS: castNow ttn=%.3f", tonumber(snap.rangedTimeToNext or 0) or 0), 0.20)
    local ok = NAG:Cast(MULTI_SHOT_ID)
    if ok then
        needsSteadyAfterMulti = true
    end
    return ok
end

--- Arcane Shot cast in the simplified 6-step APL:
--- - Only if MS is not ready
--- - Only if Arcane is allowed (MS->SS->AR rule)
--- - Only if it is safe (instant-safe window; avoids recommending too late near Auto boundary)
--- - Never during wind-up (when Steady queueing is the intended action)
--- @return boolean
function HunterWeaveModule:HunterCastArcaneNow()
    local snap = self:GetWeaveSnapshot()
    if not snap or not snap.ok or snap.waitNow then
        return false
    end
    if snap.rangedInWindup then
        return false
    end
    if snap.steadyQueued then
        DebugTrace(self, "decision", "AR: skip (SS queued)", 0.20)
        return false
    end
    if NAG.SpellIsReady and NAG:SpellIsReady(MULTI_SHOT_ID) then
        return false
    end
    if not self:HunterArcaneAllowed() then
        return false
    end
    if NAG.SpellIsReady and not NAG:SpellIsReady(ARCANE_SHOT_ID) then
        return false
    end
    -- Ensure Arcane respects the same queue-zone + boundary logic as our other recommendations.
    if not self:HunterSafeToCast(ARCANE_SHOT_ID) then
        return false
    end
    if not snap.canInstant then
        return false
    end

    DebugTrace(self, "decision", string.format("AR: castNow ttn=%.3f", tonumber(snap.rangedTimeToNext or 0) or 0), 0.20)
    return NAG:Cast(ARCANE_SHOT_ID)
end

function HunterWeaveModule:HunterCastArcane()
    local snap = self:GetWeaveSnapshot()
    if not snap or not snap.ok then
        return false
    end
    if not self:HunterArcaneAllowed() then
        return false
    end
    local ok = NAG:Cast(ARCANE_SHOT_ID)
    if ok then
        -- If Arcane was pressed in Auto's queue zone, it can create an "extra gap" between the next two autos.
        if self:HunterAutoQueueZone() then
            lastArcaneQueuedAt = snap.now or GetTime()
            -- The extra gap opportunity is the next full swing cycle after the committed Auto fires.
            -- We approximate as: until (nextAutoFire + speed).
            if snap.rangedExpiration and snap.rangedSpeed and snap.rangedSpeed > 0 then
                extraGapUntil = snap.rangedExpiration + snap.rangedSpeed
            else
                extraGapUntil = (snap.now or GetTime()) + (snap.rangedSpeed or 2.8)
            end
        end
    end
    return ok
end

--- Suggest Multi-Shot as a filler ONLY when:
--- - GCD will end mid Auto Shot cycle
--- - There will NOT be enough time to fit a Steady in that cycle after GCD ends
--- - Multi would still finish before the Auto boundary if started at GCD end
--- This uses CastSpell (tolerant) so it can show while GCD is ticking.
--- @return boolean
function HunterWeaveModule:HunterCastMultiFiller()
    local snap = self:GetWeaveSnapshot()
    if not snap or not snap.ok or snap.waitNow then
        return false
    end
    if not ShouldUseFillerThisCycle(snap) then
        return false
    end
    if NAG.SpellIsReady and not NAG:SpellIsReady(MULTI_SHOT_ID) then
        return false
    end

    local ttnAtReady = (tonumber(snap.rangedTimeToNext or 0) or 0) - GetEffectiveReadyIn(snap)
    local multiNeeded = (tonumber(snap.multiCast or 0) or 0) + (tonumber(snap.adjustedInputDelay or 0) or 0)
    if ttnAtReady <= multiNeeded then
        return false
    end

    if NAG.CastSpell then
        local ok = NAG:CastSpell(MULTI_SHOT_ID, 3, ns.SPELL_POSITIONS.PRIMARY, nil, nil)
        if ok then
            needsSteadyAfterMulti = true
        end
        return ok
    end
    return false
end

--- Suggest Arcane Shot as a filler with the same rule as Multi-Shot filler.
--- Also enforces the MS->SS->AR constraint via HunterArcaneAllowed().
--- @return boolean
function HunterWeaveModule:HunterCastArcaneFiller()
    local snap = self:GetWeaveSnapshot()
    if not snap or not snap.ok or snap.waitNow then
        return false
    end
    if not ShouldUseFillerThisCycle(snap) then
        return false
    end
    if not self:HunterArcaneAllowed() then
        return false
    end
    if not self:HunterSafeToCast(ARCANE_SHOT_ID) then
        return false
    end

    local ttnAtReady = (tonumber(snap.rangedTimeToNext or 0) or 0) - GetEffectiveReadyIn(snap)
    local instantNeeded = (tonumber(snap.adjustedInputDelay or 0) or 0) + (tonumber(snap.instantSafetyBuffer or 0) or 0)
    if ttnAtReady <= instantNeeded then
        return false
    end

    if NAG.CastSpell then
        local ok = NAG:CastSpell(ARCANE_SHOT_ID, 3, ns.SPELL_POSITIONS.PRIMARY, nil, nil)
        if ok and self:HunterAutoQueueZone() then
            lastArcaneQueuedAt = snap.now or GetTime()
            if snap.rangedExpiration and snap.rangedSpeed and snap.rangedSpeed > 0 then
                extraGapUntil = snap.rangedExpiration + snap.rangedSpeed
            else
                extraGapUntil = (snap.now or GetTime()) + (snap.rangedSpeed or 2.8)
            end
        end
        return ok
    end
    return false
end

function HunterWeaveModule:HunterCatchupAutoNeeded()
    local pattern = self:GetRotationPattern()
    if not pattern.ok then
        return false
    end
    if not pattern.wantsCatchup then
        return false
    end
    local snap = pattern.snapshot
    if not snap or not snap.ok then
        return false
    end
    local waitThreshold = snap.waitThreshold or 0.15
    return snap.waitNow or (snap.rangedTimeToNext or 0) <= waitThreshold
end

function HunterWeaveModule:HunterHold(overlayText)
    local text = overlayText or "WAIT"
    if not NAG.CastSpell then
        return false
    end
    -- Use tolerance so the overlay can show during the tail of the GCD without forcing a cast.
    return NAG:CastSpell(HOLD_SPELL_ID, 3, ns.SPELL_POSITIONS.PRIMARY, nil, text)
end

function HunterWeaveModule:HunterPatternWait()
    local pat = self:HunterRotationPattern()
    if not pat or not pat.ok then
        return false
    end
    if not pat.waitNow then
        return false
    end
    if not NAG.HunterWaitForAuto or not NAG:HunterWaitForAuto() or NAG:HunterWaitForAuto() <= 0 then
        return false
    end
    if NAG.HunterHold then
        return NAG:HunterHold("WAIT")
    end
    return false
end

function HunterWeaveModule:HunterPatternFrench()
    local pat = self:HunterRotationPattern()
    if not pat or not pat.ok or not pat.canFrench then
        return false
    end
    local snap = pat.snapshot
    if not snap or not snap.ok then
        return false
    end
    if pat.waitNow and self:HunterPatternWait() then
        return true
    end
    if self.HunterFrenchMultiReady and self:HunterFrenchMultiReady() then
        return NAG:Cast(MULTI_SHOT_ID, nil, ns.SPELL_POSITIONS.AOE)
    end
    if self.HunterFrenchArcaneReady and self:HunterFrenchArcaneReady() then
        return NAG:Cast(ARCANE_SHOT_ID)
    end
    return false
end

function HunterWeaveModule:HunterPatternCatchup()
    local pat = self:HunterRotationPattern()
    if not pat or not pat.ok or not pat.wantsCatchup then
        return false
    end
    local snap = pat.snapshot
    if not snap or not snap.ok then
        return false
    end
    if pat.waitNow and self:HunterPatternWait() then
        return true
    end
    if self.HunterCatchupAutoNeeded and self:HunterCatchupAutoNeeded() then
        if self.HunterHold then
            return self:HunterHold("WAIT")
        end
        return false
    end
    if self.HunterSafeSteady and self:HunterSafeSteady() then
        return NAG:Cast(STEADY_SHOT_ID)
    end
    if snap.canInstant then
        return NAG:Cast(ARCANE_SHOT_ID)
    end
    return false
end

function HunterWeaveModule:HunterPatternOneToOne()
    local pat = self:HunterRotationPattern()
    if not pat or not pat.ok then
        return false
    end
    if pat.canFrench or pat.wantsCatchup then
        return false
    end
    local snap = pat.snapshot
    if not snap or not snap.ok then
        return false
    end
    if pat.waitNow and self:HunterPatternWait() then
        return true
    end
    if self.HunterSafeSteady and self:HunterSafeSteady() then
        return NAG:Cast(STEADY_SHOT_ID)
    end
    if snap.canInstant then
        if NAG:SpellIsReady(27021) and NAG:NumberTargets() >= 2 then
            return NAG:Cast(MULTI_SHOT_ID, nil, ns.SPELL_POSITIONS.AOE)
        end
        return NAG:Cast(ARCANE_SHOT_ID)
    end
    return false
end

-- ============================ SPEC GATING ============================

function HunterWeaveModule:CheckSpecialization()
    if UnitClassBase("player") ~= "HUNTER" then
        self.isBM = false
        return
    end

    if not Version:IsTBC() then
        -- Keep the module present but inert outside TBC.
        self.isBM = false
        return
    end

    local playerLevel = UnitLevel("player") or 0
    if playerLevel < 10 then
        self.isBM = false
        return
    end

    if not SpecCompat then
        self.isBM = false
        return
    end

    local specStatus = SpecCompat:GetSpecializationStatus()
    if not specStatus or not specStatus.available or not specStatus.specIndex then
        self.isBM = false
        return
    end

    self.isBM = (specStatus.specIndex == BM_SPEC_INDEX)
end

function HunterWeaveModule:NAG_SPEC_UPDATED()
    self:CheckSpecialization()
end

-- ============================ LIFECYCLE ============================

function HunterWeaveModule:ModuleInitialize()
    SpecCompat = NAG:GetModule("SpecCompat")
    TBCHunterAPI = NAG:GetModule("TBCHunterAPI", true)
    self:CheckSpecialization()
end

function HunterWeaveModule:ModuleEnable()
    -- Expose snapshot helper to rotation-string environment + bar module.
    NAG.HunterWeaveSnapshot = function()
        return self:GetWeaveSnapshot()
    end

    NAG.HunterSwingState = function()
        return self:GetSwingState()
    end

    NAG.HunterRotationPattern = function()
        return self:GetRotationPattern()
    end

    NAG.HunterFrenchMultiReady = function()
        return self:HunterFrenchMultiReady()
    end

    NAG.HunterFrenchArcaneReady = function()
        return self:HunterFrenchArcaneReady()
    end

    NAG.HunterMeleeReady = function()
        return self:HunterMeleeReady()
    end

    NAG.HunterWaitForAuto = function()
        return self:HunterWaitForAuto()
    end

    NAG.HunterSafeSteady = function()
        return self:HunterSafeSteady()
    end

    NAG.HunterSafeSteadyNow = function()
        return self:HunterSafeSteadyNow()
    end

    NAG.HunterSafeMultiNow = function()
        return self:HunterSafeMultiNow()
    end

    NAG.HunterIsAutoShooting = function()
        return self:HunterIsAutoShooting()
    end

    NAG.HunterAutoQueueZone = function()
        return self:HunterAutoQueueZone()
    end

    NAG.HunterEnsureAutoShot = function()
        return self:HunterEnsureAutoShot()
    end

    NAG.HunterUpdateAutoShotState = function()
        return self:HunterUpdateAutoShotState()
    end

    -- BM debug wrappers (dot/colon safe)
    NAG.HunterDbg_UpdateAutoShotState = function()
        return self:HunterDbg_UpdateAutoShotState()
    end
    NAG.HunterDbg_EnsureAutoShot = function()
        return self:HunterDbg_EnsureAutoShot()
    end
    NAG.HunterDbg_InWarmUp = function()
        return self:HunterDbg_InWarmUp()
    end
    NAG.HunterDbg_SSQueued = function()
        return self:HunterDbg_SSQueued()
    end
    NAG.HunterDbg_SafeToCast = function(_, spellId)
        return self:HunterDbg_SafeToCast(spellId)
    end
    NAG.HunterDbg_SpellReady = function(_, spellId)
        return self:HunterDbg_SpellReady(spellId)
    end
    NAG.HunterDbg_GCDLeft = function()
        return self:HunterDbg_GCDLeft()
    end
    NAG.HunterDbg_IsCasting = function()
        return self:HunterDbg_IsCasting()
    end
    NAG.HunterDbg_Cast = function(_, spellId)
        return self:HunterDbg_Cast(spellId)
    end
    NAG.HunterDbg_SteadyHold = function()
        return self:HunterDbg_SteadyHold()
    end
    NAG.HunterDbg_MSARGates = function()
        return self:HunterDbg_MSARGates()
    end

    NAG.HunterArcaneAllowed = function()
        return self:HunterArcaneAllowed()
    end

    NAG.HunterSimlikeUseMultiForCatchup = function()
        return self:HunterSimlikeUseMultiForCatchup()
    end

    NAG.HunterSimlikeSteadyWouldClip = function()
        return self:HunterSimlikeSteadyWouldClip()
    end

    NAG.HunterSimlikeMultiAllowedThisGCD = function()
        return self:HunterSimlikeMultiAllowedThisGCD()
    end

    NAG.HunterSimlikeShouldWeaveNow = function()
        return self:HunterSimlikeShouldWeaveNow()
    end

    NAG.HunterSimlikeCoreShots = function()
        return self:HunterSimlikeCoreShots()
    end

    NAG.HunterAdaptiveScoreSnapshot = function()
        return self:HunterAdaptiveScoreSnapshot()
    end

    NAG.HunterAdaptiveCoreShots = function()
        return self:HunterAdaptiveCoreShots()
    end

    NAG.HunterInExtraGap = function()
        return self:HunterInExtraGap()
    end

    NAG.HunterEarlyGapMath = function()
        return self:HunterEarlyGapMath()
    end

    NAG.HunterInWarmUp = function()
        return self:HunterInWarmUp()
    end

    NAG.HunterSSQueued = function()
        return self:HunterSSQueued()
    end

    NAG.HunterMSQueued = function()
        return self:HunterMSQueued()
    end

    NAG.HunterQueuedSSFillerWindowOK = function()
        return self:HunterQueuedSSFillerWindowOK()
    end

    -- Accept both call styles:
    -- - NAG.HunterSafeToCast(34120)
    -- - NAG:HunterSafeToCast(34120)  (colon passes NAG as first arg)
    NAG.HunterSafeToCast = function(_, spellId)
        return self:HunterSafeToCast(spellId)
    end

    NAG.HunterCastSteadyNow = function()
        return self:HunterCastSteadyNow()
    end

    NAG.HunterCastMultiNow = function()
        return self:HunterCastMultiNow()
    end

    NAG.HunterCastArcane = function()
        return self:HunterCastArcane()
    end

    NAG.HunterNextActionWhileCastingSteady = function()
        return self:HunterNextActionWhileCastingSteady()
    end

    NAG.HunterNextActionWhenSteadyQueued = function()
        return self:HunterNextActionWhenSteadyQueued()
    end

    NAG.HunterCastArcaneNow = function()
        return self:HunterCastArcaneNow()
    end

    NAG.HunterCastMultiFiller = function()
        return self:HunterCastMultiFiller()
    end

    NAG.HunterCastArcaneFiller = function()
        return self:HunterCastArcaneFiller()
    end

    NAG.HunterCatchupAutoNeeded = function()
        return self:HunterCatchupAutoNeeded()
    end

    -- Accept both call styles (dot/colon) for Hold overlays as well.
    NAG.HunterHold = function(_, text)
        return self:HunterHold(text)
    end

    NAG.HunterPatternWait = function()
        return self:HunterPatternWait()
    end

    NAG.HunterPatternFrench = function()
        return self:HunterPatternFrench()
    end

    NAG.HunterPatternCatchup = function()
        return self:HunterPatternCatchup()
    end

    NAG.HunterPatternOneToOne = function()
        return self:HunterPatternOneToOne()
    end

    -- Simplified APL helper toolkit
    NAG.HunterRotationKey = function()
        return self:GetRotationKey()
    end

    NAG.HunterHasTwoHanderEquipped = function()
        return self:HunterHasTwoHanderEquipped()
    end

    NAG.HunterHasWindfury = function()
        return self:HunterHasWindfury()
    end

    NAG.HunterIsCasting = function()
        return self:HunterIsCasting()
    end

    NAG.HunterCanMouseoverWeave = function()
        return self:HunterCanMouseoverWeave()
    end

    NAG.HunterShouldWeave = function()
        return self:HunterShouldWeave()
    end

    NAG.HunterCastSteadyIfSafe = function()
        return self:HunterCastSteadyIfSafe()
    end

    NAG.HunterCastFillerIfSafe = function()
        return self:HunterCastFillerIfSafe()
    end

    NAG.HunterWeaveNotClipping = function()
        return self:HunterWeaveNotClipping()
    end

    NAG.HunterGetTargetDistance = function(unit)
        return self:HunterGetTargetDistance(unit)
    end

    NAG.HunterGetPreciseDistance = function(unit)
        return self:HunterGetPreciseDistance(unit)
    end

    NAG.HunterTestArcaneShotRange = function(unit)
        return self:HunterTestArcaneShotRange(unit)
    end

    NAG.HunterSteadyTimeToSafeStart = function()
        return self:HunterSteadyTimeToSafeStart()
    end

    NAG.HunterSteadyHold = function()
        return self:HunterSteadyHold()
    end

    NAG.HunterAimedHold = function()
        return self:HunterAimedHold()
    end

    NAG.HunterMSTimeToSafeStart = function()
        return self:HunterMSTimeToSafeStart()
    end

    NAG.HunterMSHold = function()
        return self:HunterMSHold()
    end

    NAG.HunterInSweetSpot = function(unit)
        return self:HunterInSweetSpot(unit)
    end

    NAG.HunterInMelee = function(unit)
        return self:HunterInMelee(unit)
    end

    NAG.HunterFarAway = function(unit)
        return self:HunterFarAway(unit)
    end

    NAG.HunterGetWeavePositioningSuggestion = function(unit)
        return self:GetWeavePositioningSuggestion(unit)
    end
end

function HunterWeaveModule:ModuleDisable()
    NAG.HunterWeaveSnapshot = nil
    NAG.HunterSwingState = nil
    NAG.HunterRotationPattern = nil
    NAG.HunterFrenchMultiReady = nil
    NAG.HunterFrenchArcaneReady = nil
    NAG.HunterMeleeReady = nil
    NAG.HunterWaitForAuto = nil
    NAG.HunterSafeSteady = nil
    NAG.HunterSafeSteadyNow = nil
    NAG.HunterSafeMultiNow = nil
    NAG.HunterIsAutoShooting = nil
    NAG.HunterAutoQueueZone = nil
    NAG.HunterEnsureAutoShot = nil
    NAG.HunterUpdateAutoShotState = nil
    NAG.HunterDbg_UpdateAutoShotState = nil
    NAG.HunterDbg_EnsureAutoShot = nil
    NAG.HunterDbg_InWarmUp = nil
    NAG.HunterDbg_SSQueued = nil
    NAG.HunterDbg_SafeToCast = nil
    NAG.HunterDbg_SpellReady = nil
    NAG.HunterDbg_GCDLeft = nil
    NAG.HunterDbg_IsCasting = nil
    NAG.HunterDbg_Cast = nil
    NAG.HunterDbg_SteadyHold = nil
    NAG.HunterDbg_MSARGates = nil
    NAG.HunterArcaneAllowed = nil
    NAG.HunterSimlikeUseMultiForCatchup = nil
    NAG.HunterSimlikeSteadyWouldClip = nil
    NAG.HunterSimlikeMultiAllowedThisGCD = nil
    NAG.HunterSimlikeShouldWeaveNow = nil
    NAG.HunterSimlikeCoreShots = nil
    NAG.HunterAdaptiveScoreSnapshot = nil
    NAG.HunterAdaptiveCoreShots = nil
    NAG.HunterInExtraGap = nil
    NAG.HunterEarlyGapMath = nil
    NAG.HunterInWarmUp = nil
    NAG.HunterSSQueued = nil
    NAG.HunterMSQueued = nil
    NAG.HunterQueuedSSFillerWindowOK = nil
    NAG.HunterSafeToCast = nil
    NAG.HunterCastSteadyNow = nil
    NAG.HunterCastMultiNow = nil
    NAG.HunterCastArcane = nil
    NAG.HunterNextActionWhileCastingSteady = nil
    NAG.HunterNextActionWhenSteadyQueued = nil
    NAG.HunterCastArcaneNow = nil
    NAG.HunterCastMultiFiller = nil
    NAG.HunterCastArcaneFiller = nil
    NAG.HunterCatchupAutoNeeded = nil
    NAG.HunterHold = nil
    NAG.HunterPatternWait = nil
    NAG.HunterPatternFrench = nil
    NAG.HunterPatternCatchup = nil
    NAG.HunterPatternOneToOne = nil

    NAG.HunterRotationKey = nil
    NAG.HunterHasTwoHanderEquipped = nil
    NAG.HunterHasWindfury = nil
    NAG.HunterIsCasting = nil
    NAG.HunterCanMouseoverWeave = nil
    NAG.HunterShouldWeave = nil
    NAG.HunterCastSteadyIfSafe = nil
    NAG.HunterCastFillerIfSafe = nil
    NAG.HunterWeaveNotClipping = nil
    NAG.HunterGetTargetDistance = nil
    NAG.HunterGetPreciseDistance = nil
    NAG.HunterTestArcaneShotRange = nil
    NAG.HunterInSweetSpot = nil
    NAG.HunterInMelee = nil
    NAG.HunterFarAway = nil
    NAG.HunterGetWeavePositioningSuggestion = nil
    NAG.HunterSteadyTimeToSafeStart = nil
    NAG.HunterSteadyHold = nil
    NAG.HunterAimedHold = nil
    NAG.HunterMSTimeToSafeStart = nil
    NAG.HunterMSHold = nil
end

-- ============================ OPTIONS ============================

--- Returns the universal scale for all hunter bar UIs (used by HunterWeaveBar, HunterAPITimelineBar, etc.)
--- @return number Scale factor (default 1)
function HunterWeaveModule:GetHunterBarScale()
    return self.db.class.barScale or 1
end

function HunterWeaveModule:GetOptions()
    local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)
    return {
        type = "group",
        name = L["Hunter Weave"] or "Hunter Weave",
        order = 29,
        args = {
            showPositioningSuggestions = {
                type = "toggle",
                name = L["Positioning Suggestions"] or "Positioning Suggestions",
                desc = L["Show arrow/minus icon near next-action when melee weaving with 2H weapon. Up=move closer, down=move away, minus=hold. Raptor Strike is still suggested at melee when disabled."] or
                    "Show arrow/minus icon near next-action when melee weaving with 2H weapon. Up=move closer, down=move away, minus=hold. Raptor Strike is still suggested at melee when disabled.",
                get = function() return self.db.class.showPositioningSuggestions end,
                set = function(_, v) self.db.class.showPositioningSuggestions = v end,
                order = 0,
            },
            barScale = {
                type = "range",
                name = L["Hunter bars scale"] or "Hunter bars scale",
                desc = L["Scale all hunter UI bars (weave bar, steady gap, timeline, future bars)."] or
                    "Scale all hunter UI bars (weave bar, steady gap, timeline, future bars).",
                min = 0.5,
                max = 2.0,
                step = 0.05,
                get = function() return self.db.class.barScale or 1 end,
                set = function(_, v)
                    self.db.class.barScale = v
                    NAG:SendMessage("NAG_HUNTER_BAR_SCALE_UPDATED")
                end,
                order = 2,
            },
            futurePredictor = {
                type = "group",
                name = "Future Predictor (3-step)",
                desc = "Predict next actions using a timing state machine.",
                inline = true,
                order = 5,
                args = {
                    enablePredictionMeleeWeave = {
                        type = "toggle",
                        name = "Enable Melee Weave (Prediction)",
                        desc = "Scaffold toggle: allows the future predictor to consider melee weaving. Default off; decision logic will be added later.",
                        get = function() return self.db.class.enablePredictionMeleeWeave and true or false end,
                        set = function(_, v) self.db.class.enablePredictionMeleeWeave = v and true or false end,
                        order = 0,
                    },
                },
            },
            adaptiveScoring = {
                type = "group",
                name = "SIM-like Adaptive Scoring",
                desc = "Test-only: SIM-inspired scoring using relative weights (not a full damage sim).",
                inline = true,
                order = 10,
                args = {
                    adaptiveScoringEnabled = {
                        type = "toggle",
                        name = "Enable Adaptive Scoring",
                        desc = "If enabled, `NAG:HunterAdaptiveCoreShots()` can be used by a rotation to pick actions using score math.",
                        get = function() return self.db.class.adaptiveScoringEnabled end,
                        set = function(_, v) self.db.class.adaptiveScoringEnabled = v and true or false end,
                        order = 0,
                    },
                    adaptiveCatchupThreshold = {
                        type = "range",
                        name = "Multi Catch-up Threshold",
                        desc = "Mirrors wowsims `useMultiForCatchup` threshold (default 0.95). Lower = save Multi more often.",
                        min = 0.50,
                        max = 1.00,
                        step = 0.01,
                        get = function() return self.db.class.adaptiveCatchupThreshold or 0.95 end,
                        set = function(_, v) self.db.class.adaptiveCatchupThreshold = v end,
                        order = 1,
                    },
                    wShoot = {
                        type = "range",
                        name = "Weight: Auto (Shoot)",
                        min = 0.0,
                        max = 10.0,
                        step = 0.05,
                        get = function() return (self.db.class.adaptiveWeights and self.db.class.adaptiveWeights.shoot) or 1.0 end,
                        set = function(_, v) self.db.class.adaptiveWeights.shoot = v end,
                        order = 2,
                    },
                    wSteady = {
                        type = "range",
                        name = "Weight: Steady Shot",
                        min = 0.0,
                        max = 10.0,
                        step = 0.05,
                        get = function() return (self.db.class.adaptiveWeights and self.db.class.adaptiveWeights.steady) or 1.0 end,
                        set = function(_, v) self.db.class.adaptiveWeights.steady = v end,
                        order = 3,
                    },
                    wMulti = {
                        type = "range",
                        name = "Weight: Multi-Shot",
                        min = 0.0,
                        max = 10.0,
                        step = 0.05,
                        get = function() return (self.db.class.adaptiveWeights and self.db.class.adaptiveWeights.multi) or 1.0 end,
                        set = function(_, v) self.db.class.adaptiveWeights.multi = v end,
                        order = 4,
                    },
                    wArcane = {
                        type = "range",
                        name = "Weight: Arcane Shot",
                        min = 0.0,
                        max = 10.0,
                        step = 0.05,
                        get = function() return (self.db.class.adaptiveWeights and self.db.class.adaptiveWeights.arcane) or 1.0 end,
                        set = function(_, v) self.db.class.adaptiveWeights.arcane = v end,
                        order = 5,
                    },
                    wWeave = {
                        type = "range",
                        name = "Weight: Weave (Raptor)",
                        min = 0.0,
                        max = 10.0,
                        step = 0.05,
                        get = function() return (self.db.class.adaptiveWeights and self.db.class.adaptiveWeights.weave) or 1.0 end,
                        set = function(_, v) self.db.class.adaptiveWeights.weave = v end,
                        order = 6,
                    },
                },
            },
        },
    }
end

return HunterWeaveModule
