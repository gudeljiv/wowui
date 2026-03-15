--- @module "NAG.HunterStateTimelineDebug"
--- Debug slash command and state visualizer for TBC Hunter timeline.
---
--- License: CC BY-NC 4.0
--- Authors: Rakizi, Fonsas

-- ============================ LOCALIZE ============================
local _, ns = ...

local CreateFrame = _G.CreateFrame
local UIParent = _G.UIParent
local UnitClassBase = _G.UnitClassBase
local GetTime = _G.GetTime
local date = _G.date
local tostring = _G.tostring
local tonumber = _G.tonumber
local format = string.format
local max = math.max
local min = math.min
local floor = math.floor

--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local Version = ns.Version

-- ============================ CONSTANTS ============================
local COMMAND_HORIZON_SECONDS = 15
local MAX_RENDER_STATES = 7
local NEXT_ACTION_COUNT = 9

local FRAME_NAME = "NAGHunterStateTimelineDebugFrame"
local FRAME_NAME_ADVANCED = "NAGHunterStateTimelineDebugAdvancedFrame"
local FRAME_PADDING = 10
local FRAME_TITLE_HEIGHT = 18
local BOX_WIDTH = 252   -- 20% wider than 210
local BOX_HEIGHT = 325 -- 30% taller than 250
-- Advanced boxes (with math): 30% taller than previous advanced height.
local BOX_HEIGHT_ADVANCED = floor(((BOX_HEIGHT * 2) * 0.75) * 1.30)
local BOX_GAP = 8
local ADVANCED_LATENCY_SECONDS = 0.05
local DEFAULT_WINDUP_SECONDS = 0.5

-- ============================ DEFAULTS ============================
local defaults = {
    class = {
        enabled = true,
    }
}

--- @class HunterStateTimelineDebug:CoreModule
local HunterStateTimelineDebug = NAG:CreateModule("HunterStateTimelineDebug", defaults, {
    moduleType = ns.MODULE_TYPES.CLASS,
    className = "HUNTER",
    optionsCategory = ns.MODULE_CATEGORIES.CLASS,
    hidden = function()
        return not (Version and Version:IsTBC()) or UnitClassBase("player") ~= "HUNTER"
    end,
    slashCommands = {
        ["hunter-state-debug"] = {
            handler = "RunStateDebug",
            help = "Snapshot hunter state timeline and show State 0 (NOW) plus next 6 states. Optional: /nagdebug hunter-state-debug <0-6> to print that state to chat.",
            root = "nagdebug",
        },
        ["hunter-state-debug-advanced"] = {
            handler = "RunStateDebugAdvanced",
            help = "Advanced snapshot with value math (Shoot/Steady/MS/AR), winner, and reasons for State 0 through 6.",
            root = "nagdebug",
        },
    },
})

ns.HunterStateTimelineDebug = HunterStateTimelineDebug

HunterStateTimelineDebug.state = HunterStateTimelineDebug.state or {}

-- ============================ HELPERS ============================
--- @param now number
--- @param at number|nil
--- @return number
local function SafeIn(now, at)
    local t = tonumber(at or 0) or 0
    local delta = t - now
    if delta < 0 then
        return 0
    end
    return delta
end

--- @param now number
--- @param at number|nil
--- @return string
local function FormatIn(now, at)
    return format("%.3f", SafeIn(now, at))
end

--- @param state table|nil
--- @return string
local function ActionLabel(state)
    if not state then
        return "none"
    end
    local primary = tostring(state.chosenAction or "none")
    local secondary = tostring(state.chosenAction2 or "none")
    return primary .. "/" .. secondary
end

--- @param now number
--- @param at number|nil
--- @return number
local function ClampFromNow(now, at)
    local t = tonumber(at or 0) or 0
    local delta = t - now
    if delta < 0 then
        return 0
    end
    return delta
end

--- @param state table
--- @param slot number
--- @return string
local function GetSlotActionName(state, slot)
    if slot == 1 then
        return tostring(state and state.chosenAction or "none")
    end
    return tostring(state and state.chosenAction2 or "none")
end

--- @param state table
--- @param slot number
--- @return string
local function GetSlotReason(state, slot)
    if slot == 1 then
        return tostring(state and state.stateReason or "")
    end
    return tostring(state and state.stateReason2 or "")
end

--- @param state table
--- @param slot number
--- @param actionName string
--- @return boolean
local function IsQueuedSSExecute(state, slot, actionName)
    if actionName ~= "SS" then
        return false
    end
    return GetSlotReason(state, slot) == "queued_ss_execute_at_state_start"
end

--- @param state table
--- @param slot number
--- @param actionName string
--- @return number
local function GetSlotPressAt(state, slot, actionName)
    if actionName == "SS" then
        if slot == 1 then
            -- For queued SS we treat the action time as queue press (ssPressAt), not cast start.
            return tonumber(state and state.ssPressAt or 0) or 0
        end
        return tonumber(state and state.ssPressAt2 or 0) or 0
    end
    if slot == 1 then
        return tonumber(state and state.fillerCastAt or 0) or 0
    end
    return tonumber(state and state.fillerCastAt2 or 0) or 0
end

--- @param state table
--- @param slot number
--- @param actionName string
--- @param pressAt number
--- @return number
local function GetSlotActionEndAt(state, slot, actionName, pressAt)
    local gcdEndAt = (slot == 1)
        and (tonumber(state and state.gcdEndAt1 or 0) or 0)
        or (tonumber(state and state.gcdEndAt2 or 0) or 0)

    local castEndAt = 0
    if actionName == "SS" then
        castEndAt = (slot == 1)
            and (tonumber(state and state.ssCastEndAt or 0) or 0)
            or (tonumber(state and state.ssCastEndAt2 or 0) or 0)
    else
        castEndAt = (slot == 1)
            and (tonumber(state and state.fillerCastEndAt or 0) or 0)
            or (tonumber(state and state.fillerCastEndAt2 or 0) or 0)
    end

    local endAt = max(gcdEndAt, castEndAt)
    if endAt <= 0 then
        endAt = tonumber(state and (state.postFillerActionableAt or state.nextActionableAt) or 0) or 0
    end
    if endAt <= 0 then
        endAt = pressAt
    end
    return endAt
end

--- Build next N predicted actions from rendered states.
--- @param now number
--- @param statesToRender table|nil
--- @param count number|nil
--- @param delaySeconds number|nil
--- @param gcdLeftFromTimeline number|nil
--- @return table
local function BuildNextActionsTimeline(now, statesToRender, count, delaySeconds, gcdLeftFromTimeline)
    local maxCount = tonumber(count or NEXT_ACTION_COUNT) or NEXT_ACTION_COUNT
    if maxCount <= 0 then
        return {}
    end

    local inputDelaySeconds = tonumber(delaySeconds or 0) or 0
    if inputDelaySeconds < 0 then
        inputDelaySeconds = 0
    end
    local gcdLeftSeconds = tonumber(gcdLeftFromTimeline or 0) or 0
    if gcdLeftSeconds < 0 then
        gcdLeftSeconds = 0
    end
    local gcdReadyAt = (tonumber(now or 0) or 0) + gcdLeftSeconds

    -- Latency adjustment for HOLD+SS only: move HOLD end and SS press earlier so user sends spell
    -- as close to predicted point as possible. 75% of latency, max 100ms. Visual-only.
    local latencyMs = (NAG.GetNetStats and NAG:GetNetStats()) or 0
    if type(latencyMs) ~= "number" or latencyMs < 0 then
        latencyMs = 0
    end
    local latencyReductionSeconds = min(0.75 * (latencyMs / 1000), 0.100)
    local HOLD_SS_MIN_GAP_SECONDS = 0.015

    local segments = {}
    local actionsCount = 0
    local lastActionableAt = tonumber(now or 0) or 0
    local states = statesToRender or {}
    for i = 1, #states do
        local state = states[i]
        if state then
            for slot = 1, 2 do
                if actionsCount >= maxCount then
                    break
                end

                local actionName = GetSlotActionName(state, slot)
                if actionName ~= "" and actionName ~= "none" then
                    local pressAt = GetSlotPressAt(state, slot, actionName)
                    local prevState = (i > 1) and states[i - 1] or nil
                    local prevQueued = prevState and prevState.ssQueuedThisState == true
                    if IsQueuedSSExecute(state, slot, actionName) and prevQueued then
                        -- This SS executes a queue from the previous state; we already showed it there.
                        lastActionableAt = GetSlotActionEndAt(state, slot, actionName, pressAt)
                    else
                        local hadHold = false
                        local adjustedHoldEnd = nil
                        if pressAt > lastActionableAt then
                            local effectiveHoldStartAt = max(lastActionableAt, gcdReadyAt)
                            local holdStart = ClampFromNow(now, effectiveHoldStartAt) + inputDelaySeconds
                            local holdEnd = ClampFromNow(now, pressAt) + inputDelaySeconds
                            if actionName == "SS" and latencyReductionSeconds > 0 then
                                adjustedHoldEnd = max(holdStart + HOLD_SS_MIN_GAP_SECONDS, holdEnd - latencyReductionSeconds)
                                segments[#segments + 1] = {
                                    "HOLD",
                                    holdStart,
                                    adjustedHoldEnd,
                                }
                                hadHold = true
                            else
                                segments[#segments + 1] = {
                                    "HOLD",
                                    holdStart,
                                    holdEnd,
                                }
                            end
                        end

                        if actionName == "SS" then
                            local slotReason = GetSlotReason(state, slot)
                            local gapEndAt = pressAt
                            if slotReason ~= "ss_cast_without_clip" then
                                gapEndAt = tonumber(state.stateEndAt or pressAt) or pressAt
                            end
                            local ssPress = ClampFromNow(now, pressAt) + inputDelaySeconds
                            local ssGapEnd = ClampFromNow(now, gapEndAt) + inputDelaySeconds
                            if hadHold and adjustedHoldEnd and latencyReductionSeconds > 0 then
                                ssPress = max(adjustedHoldEnd, ssPress - latencyReductionSeconds)
                            end
                            segments[#segments + 1] = {
                                actionName,
                                ssPress,
                                ssGapEnd,
                            }
                        else
                            segments[#segments + 1] = {
                                actionName,
                                ClampFromNow(now, pressAt) + inputDelaySeconds,
                            }
                        end

                        actionsCount = actionsCount + 1
                        lastActionableAt = GetSlotActionEndAt(state, slot, actionName, pressAt)
                    end
                end
            end
            if actionsCount >= maxCount then
                break
            end
        end
    end

    return segments
end

--- @param steadyWeaveBar table|nil
--- @return number
local function GetUserInputDelaySeconds(steadyWeaveBar)
    local barDb = steadyWeaveBar and steadyWeaveBar.db and steadyWeaveBar.db.class or nil
    local userInputDelayMs = tonumber(barDb and barDb.userInputDelayMs or 25) or 25
    if userInputDelayMs < 0 then
        userInputDelayMs = 0
    elseif userInputDelayMs > 500 then
        userInputDelayMs = 500
    end
    return userInputDelayMs / 1000
end

--- Build autoshot moments from state machine output.
--- Each state's end (`stateEndAt`) is when autoshot lands for that state.
--- @param now number
--- @param statesToRender table|nil
--- @return table
local function BuildAutoshotMomentsTimeline(now, statesToRender)
    local list = {}
    local dedup = {}
    local states = statesToRender or {}
    for i = 1, #states do
        local state = states[i]
        local endAt = tonumber(state and state.stateEndAt or 0) or 0
        if endAt > 0 then
            local fromNow = ClampFromNow(now, endAt)
            local key = format("%.3f", fromNow)
            if not dedup[key] then
                dedup[key] = true
                list[#list + 1] = fromNow
            end
        end
    end
    table.sort(list)
    return list
end

--- @param actions table|nil
--- @return string
local function FormatNextActionsString(actions)
    local list = actions or {}
    if #list == 0 then
        return "{}"
    end

    local formatted = "{"
    for i = 1, #list do
        local action = list[i]
        local actionName = tostring(action and action[1] or "none")
        local t1 = tonumber(action and action[2] or 0) or 0
        local t2 = tonumber(action and action[3] or 0) or 0
        if i > 1 then
            formatted = formatted .. ","
        end
        if actionName == "HOLD" or actionName == "SS" then
            formatted = formatted .. format("{'%s',%.3f,%.3f}", actionName, t1, t2)
        else
            formatted = formatted .. format("{'%s',%.3f}", actionName, t1)
        end
    end
    return formatted .. "}"
end

--- @param now number
--- @param stateIndex number
--- @param state table
--- @return string
local function BuildStatePrintLine(now, stateIndex, state)
    return format(
        "[HUNTER_STATE_DEBUG] idx=%d stateId=%d cycle=%d s1=%s reason1=%s s1PressIn=%s s1CastStartIn=%s s1CastEndIn=%s s1GcdStartIn=%s s1GcdEndIn=%s s2=%s reason2=%s s2PressIn=%s s2CastStartIn=%s s2CastEndIn=%s s2GcdStartIn=%s s2GcdEndIn=%s fillerReason=\"%s\" nextActionableIn=%s earlyGapExists=%s earlyGapLhs=%s earlyGapRhs=%s fillerSafetyEval=%s fillerLhs=%s fillerRhs=%s fillerSafe=%s",
        stateIndex,
        tonumber(state.stateId or 0) or 0,
        tonumber(state.absoluteCycleIndex or state.cycleIndex or 0) or 0,
        tostring(state.chosenAction or "none"),
        tostring(state.stateReason or "none"),
        FormatIn(now, state.ssPressAt),
        FormatIn(now, state.ssCastStartAt),
        FormatIn(now, state.ssCastEndAt),
        FormatIn(now, state.gcdStartAt1 or state.gcdStartAt or state.actionableAt),
        FormatIn(now, state.gcdEndAt1 or state.gcdEndAt),
        tostring(state.chosenAction2 or "none"),
        tostring(state.stateReason2 or "none"),
        FormatIn(now, state.ssPressAt2),
        FormatIn(now, state.ssCastStartAt2),
        FormatIn(now, state.ssCastEndAt2),
        FormatIn(now, state.gcdStartAt2),
        FormatIn(now, state.gcdEndAt2),
        tostring(state.fillerReason or "filler: unknown"),
        FormatIn(now, state.postFillerActionableAt or state.nextActionableAt),
        tostring(state.earlyGapExists == true),
        format("%.3f", tonumber(state.earlyGapLhs or 0) or 0),
        format("%.3f", tonumber(state.earlyGapRhs or 0) or 0),
        tostring(state.fillerSafetyEvaluated == true),
        format("%.3f", tonumber(state.fillerLhs or 0) or 0),
        format("%.3f", tonumber(state.fillerRhs or 0) or 0),
        tostring(state.fillerSafe == true)
    )
end

--- Print a single state's details to chat (readable multi-line block).
--- @param now number
--- @param stateIndex number
--- @param state table
local function PrintStateToChat(now, stateIndex, state)
    if not state then
        NAG:Print(format("|cffff0000[Hunter State %d] No data.|r", stateIndex))
        return
    end
    NAG:Print(format("|cff00bfff-------- Hunter State %d (id=%s cycle=%s) --------|r",
        stateIndex,
        tostring(state.stateId or "?"),
        tostring(state.absoluteCycleIndex or state.cycleIndex or "?")))
    NAG:Print(format("  actionSummary: %s", ActionLabel(state)))
    NAG:Print(format("  stateStart: %ss  |  stateEnd: %ss",
        FormatIn(now, state.stateStartAt), FormatIn(now, state.stateEndAt)))
    local gcdRem = tonumber(state.gcdRemainingSecondsAtStateStart or 0) or 0
    if gcdRem > 0 then
        NAG:Print(format("  gcdPendingAtStateStart: %.2fs remaining (GCD spans from previous state)",
            gcdRem))
    end
    NAG:Print(format("  gapStart: %ss  |  gapEnd: %ss",
        FormatIn(now, state.gapStartAt), FormatIn(now, state.gapEndAt)))
    NAG:Print(format(
        "  slot1: action=%s reason=%s press=%ss castStart=%ss castEnd=%ss gcdStart=%ss gcdEnd=%ss",
        tostring(state.chosenAction or "none"),
        tostring(state.stateReason or "none"),
        FormatIn(now, state.ssPressAt),
        FormatIn(now, state.ssCastStartAt),
        FormatIn(now, state.ssCastEndAt),
        FormatIn(now, state.gcdStartAt1 or state.gcdStartAt or state.actionableAt),
        FormatIn(now, state.gcdEndAt1 or state.gcdEndAt)
    ))
    NAG:Print(format(
        "  slot2: action=%s reason=%s press=%ss castStart=%ss castEnd=%ss gcdStart=%ss gcdEnd=%ss",
        tostring(state.chosenAction2 or "none"),
        tostring(state.stateReason2 or "none"),
        FormatIn(now, state.ssPressAt2),
        FormatIn(now, state.ssCastStartAt2),
        FormatIn(now, state.ssCastEndAt2),
        FormatIn(now, state.gcdStartAt2),
        FormatIn(now, state.gcdEndAt2)
    ))
    NAG:Print(format("  filler: %s  |  fillerStart: %ss  |  fillerEnd: %ss  |  fillerGcdEnd: %ss",
        tostring(state.fillerSpell or "none"),
        FormatIn(now, state.fillerCastAt), FormatIn(now, state.fillerCastEndAt), FormatIn(now, state.fillerGcdEndAt)))
    NAG:Print(format("  fillerReason: %s", tostring(state.fillerReason or "filler: unknown")))
    NAG:Print(format("  earlyGapExists: %s  |  earlyGapLhs: %.3f  |  earlyGapRhs: %.3f",
        tostring(state.earlyGapExists == true),
        tonumber(state.earlyGapLhs or 0) or 0,
        tonumber(state.earlyGapRhs or 0) or 0))
    NAG:Print(format("  fillerSafetyEval: %s  |  fillerLhs: %.3f  |  fillerRhs: %.3f  |  fillerSafe: %s",
        tostring(state.fillerSafetyEvaluated == true),
        tonumber(state.fillerLhs or 0) or 0,
        tonumber(state.fillerRhs or 0) or 0,
        tostring(state.fillerSafe == true)))
    NAG:Print(format("  nextActionable: %ss", FormatIn(now, state.postFillerActionableAt or state.nextActionableAt)))
    NAG:Print("|cff00bfff----------------------------------------|r")
end

--- @param box table
--- @param now number
--- @param state table|nil
--- @param stateIndex number
local function PopulateStateBox(box, now, state, stateIndex)
    if not box or not box.titleText or not box.bodyText then
        return
    end

    if not state then
        if stateIndex == 0 then
            box.titleText:SetText("State 0 (NOW)")
        else
            box.titleText:SetText(format("State %d", stateIndex))
        end
        box.bodyText:SetText("No data")
        return
    end

    local title
    if stateIndex == 0 then
        title = format(
            "State 0 (NOW) | id=%d | cycle=%d",
            tonumber(state.stateId or 0) or 0,
            tonumber(state.absoluteCycleIndex or state.cycleIndex or 0) or 0
        )
    else
        title = format(
            "State %d | id=%d | cycle=%d",
            stateIndex,
            tonumber(state.stateId or 0) or 0,
            tonumber(state.absoluteCycleIndex or state.cycleIndex or 0) or 0
        )
    end

    local gcdRemLine = ""
    local gcdRem = tonumber(state.gcdRemainingSecondsAtStateStart or 0) or 0
    if gcdRem > 0 then
        gcdRemLine = format("gcdPendingAtStateStart: %.2fs\n", gcdRem)
    end
    local body = format(
        "actionSummary: %s\n" ..
        "stateStart: %ss\nstateEnd: %ss\n" ..
        "%s" ..
        "gapStart: %ss\ngapEnd: %ss\n" ..
        "slot1 action: %s\nslot1 reason: %s\nslot1 press/castStart: %ss / %ss\nslot1 castEnd: %ss\nslot1 gcdStart/gcdEnd: %ss / %ss\n" ..
        "slot2 action: %s\nslot2 reason: %s\nslot2 press/castStart: %ss / %ss\nslot2 castEnd: %ss\nslot2 gcdStart/gcdEnd: %ss / %ss\n" ..
        "filler: %s\nfillerStart: %ss\nfillerEnd: %ss\nfillerGcdEnd: %ss\n" ..
        "fillerReason: %s\n" ..
        "earlyGapExists: %s\nearlyGapLhs/Rhs: %.3f / %.3f\n" ..
        "fillerSafetyEval: %s\nfillerLhs: %.3f | fillerRhs: %.3f\nfillerSafe: %s\n" ..
        "nextActionable: %ss",
        ActionLabel(state),
        FormatIn(now, state.stateStartAt),
        FormatIn(now, state.stateEndAt),
        gcdRemLine,
        FormatIn(now, state.gapStartAt),
        FormatIn(now, state.gapEndAt),
        tostring(state.chosenAction or "none"),
        tostring(state.stateReason or "none"),
        FormatIn(now, state.ssPressAt),
        FormatIn(now, state.ssCastStartAt),
        FormatIn(now, state.ssCastEndAt),
        FormatIn(now, state.gcdStartAt1 or state.gcdStartAt or state.actionableAt),
        FormatIn(now, state.gcdEndAt1 or state.gcdEndAt),
        tostring(state.chosenAction2 or "none"),
        tostring(state.stateReason2 or "none"),
        FormatIn(now, state.ssPressAt2),
        FormatIn(now, state.ssCastStartAt2),
        FormatIn(now, state.ssCastEndAt2),
        FormatIn(now, state.gcdStartAt2),
        FormatIn(now, state.gcdEndAt2),
        tostring(state.fillerSpell or "none"),
        FormatIn(now, state.fillerCastAt),
        FormatIn(now, state.fillerCastEndAt),
        FormatIn(now, state.fillerGcdEndAt),
        tostring(state.fillerReason or "filler: unknown"),
        tostring(state.earlyGapExists == true),
        tonumber(state.earlyGapLhs or 0) or 0,
        tonumber(state.earlyGapRhs or 0) or 0,
        tostring(state.fillerSafetyEvaluated == true),
        tonumber(state.fillerLhs or 0) or 0,
        tonumber(state.fillerRhs or 0) or 0,
        tostring(state.fillerSafe == true),
        FormatIn(now, state.postFillerActionableAt or state.nextActionableAt)
    )

    box.titleText:SetText(title)
    box.bodyText:SetText(body)
end

-- ============================ ADVANCED DEBUG HELPERS ============================
--- @param n number|nil
--- @return string
local function Fmt2(n)
    return format("%.2f", tonumber(n or 0) or 0)
end

--- @param n number|nil
--- @return string
local function Fmt3(n)
    return format("%.3f", tonumber(n or 0) or 0)
end

--- @param state table|nil
--- @param timelineResult table|nil
--- @return number
local function ResolveRangedSpeed(state, timelineResult)
    local speed = tonumber(state and state.rangedSpeed or 0) or 0
    if speed <= 0 then
        speed = tonumber(timelineResult and timelineResult.rangedSpeed or 0) or 0
    end
    if speed <= 0 and timelineResult and timelineResult.state0 then
        speed = tonumber(timelineResult.state0.rangedSpeed or 0) or 0
    end
    return speed > 0 and speed or 0
end

--- @param state table|nil
--- @param timelineResult table|nil
--- @return number
local function ResolveWindupSeconds(state, timelineResult)
    local fromState = tonumber(state and state.windupSeconds or 0) or 0
    if fromState > 0 then
        return fromState
    end
    local fromTimeline = tonumber(timelineResult and timelineResult.windupSeconds or 0) or 0
    if fromTimeline > 0 then
        return fromTimeline
    end
    local endAt = tonumber(state and state.stateEndAt or 0) or 0
    local gapStartAt = tonumber(state and state.gapStartAt or 0) or 0
    if endAt > gapStartAt and gapStartAt > 0 then
        return endAt - gapStartAt
    end
    local s0 = timelineResult and timelineResult.state0 or nil
    local s0End = tonumber(s0 and s0.stateEndAt or 0) or 0
    local s0GapStart = tonumber(s0 and s0.gapStartAt or 0) or 0
    if s0End > s0GapStart and s0GapStart > 0 then
        return s0End - s0GapStart
    end
    return DEFAULT_WINDUP_SECONDS
end

--- @param state table|nil
--- @param timelineResult table|nil
--- @return number
local function ResolveMsReadyAt(state, timelineResult)
    local fromState = tonumber(state and state.msReadyAtBefore or 0) or 0
    if fromState > 0 then
        return fromState
    end
    fromState = tonumber(state and state.msReadyAt or 0) or 0
    if fromState > 0 then
        return fromState
    end
    return tonumber(timelineResult and timelineResult.msReadyAt or 0) or 0
end

--- @param state table|nil
--- @param timelineResult table|nil
--- @return number
local function ResolveArReadyAt(state, timelineResult)
    local fromState = tonumber(state and state.arReadyAtBefore or 0) or 0
    if fromState > 0 then
        return fromState
    end
    fromState = tonumber(state and state.arReadyAt or 0) or 0
    if fromState > 0 then
        return fromState
    end
    return tonumber(timelineResult and timelineResult.arReadyAt or 0) or 0
end

--- Optional overrides for slot 2: actionableAt, gcdAt, msReadyAt, arReadyAt.
---
--- Value formula (sim-style): value = baseDamage - (opponentDPS * delaySeconds).
--- - Shoot (wait for auto): value = autoBase - (steadyDPS * shootGcdDelay).
---   shootGcdDelay = time from gcdAt until wind-up start (clipping boundary).
--- - Steady/Multi/Arcane: value = spellBase - (shootDPS * delayToNextAuto).
---   delayToNextAuto = max(0, (gcdAt + castTime) - windupStartAt) = how much we delay wind-up start.
--- Winner = argmax of available options (Multi/Arcane only if off CD).
---
--- @param state table|nil
--- @param timelineResult table|nil
--- @param stateIndex number
--- @param opts table|nil Optional: { actionableAt, gcdAt, msReadyAt, arReadyAt } for slot 2.
--- @return table
local function ComputeValueBasedDecision(state, timelineResult, stateIndex, opts)
    local result = {
        chosenAction = "none",
        reason = "advanced: no state data",
        mathLines = {},
        valueShoot = nil,
        valueSteady = nil,
        valueMulti = nil,
        valueArcane = nil,
        canMulti = false,
        canArcane = false,
    }
    if not state then
        return result
    end

    local actionableAt
    local gcdAt
    local msReadyAt
    local arReadyAt
    if opts and type(opts) == "table" then
        actionableAt = tonumber(opts.actionableAt or 0) or 0
        gcdAt = tonumber(opts.gcdAt or opts.actionableAt or 0) or 0
        msReadyAt = tonumber(opts.msReadyAt or 0) or 0
        arReadyAt = tonumber(opts.arReadyAt or 0) or 0
    else
        -- Use state's decision timing; fall back to stateStartAt so each state gets its own window.
        actionableAt = tonumber(state.actionableAt or state.gcdStartAt1 or state.gcdReadyAt or state.stateStartAt or 0) or 0
        gcdAt = actionableAt
        msReadyAt = ResolveMsReadyAt(state, timelineResult)
        arReadyAt = ResolveArReadyAt(state, timelineResult)
    end
    local shootAt = tonumber(state.stateEndAt or 0) or 0
    local rangedSpeed = ResolveRangedSpeed(state, timelineResult)
    local windupSeconds = ResolveWindupSeconds(state, timelineResult)

    local getAllBases = ns and ns.HunterDamageFormulas_GetAllBases
    local getSteadyCast = ns and ns.HunterDamageFormulas_GetSteadyCastTime
    local getMultiCast = ns and ns.HunterDamageFormulas_GetMultiCastTime
    if type(getAllBases) ~= "function" or type(getSteadyCast) ~= "function" or type(getMultiCast) ~= "function" then
        result.reason = "advanced: HunterDamageFormulas unavailable"
        result.mathLines[1] = "Shoot: N/A (damage formulas unavailable)"
        result.mathLines[2] = "Steady: N/A (damage formulas unavailable)"
        result.mathLines[3] = "Multi: N/A (damage formulas unavailable)"
        result.mathLines[4] = "Arcane: N/A (damage formulas unavailable)"
        result.mathLines[5] = "Weave: N/A (no weave timing in state)"
        return result
    end

    local bases = getAllBases(nil, nil) or {}
    local autoBase = tonumber(bases.auto or 0) or 0
    local steadyBase = tonumber(bases.steady or 0) or 0
    local multiBase = tonumber(bases.multi or 0) or 0
    local arcaneBase = tonumber(bases.arcane or 0) or 0

    local latency = ADVANCED_LATENCY_SECONDS
    local steadyCast = tonumber(getSteadyCast(latency) or (1.5 + latency)) or (1.5 + latency)
    local multiCast = tonumber(getMultiCast(latency) or (0.5 + latency)) or (0.5 + latency)
    local arcaneCast = latency

    local shootDPS = (rangedSpeed > 0) and (autoBase / rangedSpeed) or 0
    local steadyDPS = (steadyCast > 0) and (steadyBase / steadyCast) or 0

    local windupStartAt = shootAt - windupSeconds
    local shootGcdDelay = max(0, windupStartAt - gcdAt)
    -- Clipping = delaying wind-up start; measure delay against wind-up start boundary
    local steadyShootDelay = max(0, (gcdAt + steadyCast) - windupStartAt)
    local multiShootDelay = max(0, (gcdAt + multiCast) - windupStartAt)
    local arcaneShootDelay = max(0, (gcdAt + arcaneCast) - windupStartAt)

    local valueShoot = autoBase - (steadyDPS * shootGcdDelay)
    local valueSteady = steadyBase - (shootDPS * steadyShootDelay)

    local canMulti = actionableAt >= msReadyAt
    local canArcane = actionableAt >= arReadyAt

    local valueMulti = nil
    if canMulti then
        valueMulti = multiBase - (shootDPS * multiShootDelay)
    end

    local valueArcane = nil
    if canArcane then
        valueArcane = arcaneBase - (shootDPS * arcaneShootDelay)
    end

    result.valueShoot = valueShoot
    result.valueSteady = valueSteady
    result.valueMulti = valueMulti
    result.valueArcane = valueArcane
    result.canMulti = canMulti
    result.canArcane = canArcane

    local winner = "Shoot"
    local winnerValue = valueShoot
    if valueSteady > winnerValue then
        winner = "Steady"
        winnerValue = valueSteady
    end
    if canMulti and valueMulti and valueMulti > winnerValue then
        winner = "Multi"
        winnerValue = valueMulti
    end
    if canArcane and valueArcane and valueArcane > winnerValue then
        winner = "Arcane"
        winnerValue = valueArcane
    end

    result.chosenAction = winner
    result.reason = format("advanced_math_winner=%s value=%s (state=%d)", winner, Fmt2(winnerValue), tonumber(stateIndex or 0) or 0)
    result.actionableAtUsed = actionableAt
    result.stateEndAtUsed = shootAt
    result.windowSeconds = max(0, shootAt - actionableAt)

    result.mathLines[1] = format("Shoot:  %s - %s*%s = %s",
        Fmt2(autoBase), Fmt2(steadyDPS), Fmt3(shootGcdDelay), Fmt2(valueShoot))
    result.mathLines[2] = format("Steady: %s - %s*%s = %s",
        Fmt2(steadyBase), Fmt2(shootDPS), Fmt3(steadyShootDelay), Fmt2(valueSteady))

    if canMulti then
        result.mathLines[3] = format("Multi:  %s - %s*%s = %s",
            Fmt2(multiBase), Fmt2(shootDPS), Fmt3(multiShootDelay), Fmt2(valueMulti))
    else
        result.mathLines[3] = format("Multi:  N/A (cd, readyIn=%ss)", Fmt3(max(0, msReadyAt - actionableAt)))
    end

    if canArcane then
        result.mathLines[4] = format("Arcane: %s - %s*%s = %s",
            Fmt2(arcaneBase), Fmt2(shootDPS), Fmt3(arcaneShootDelay), Fmt2(valueArcane))
    else
        result.mathLines[4] = format("Arcane: N/A (cd, readyIn=%ss)", Fmt3(max(0, arReadyAt - actionableAt)))
    end
    result.mathLines[5] = "Weave: N/A (no weave timing in state)"
    result.mathLines[6] = format("Winner: %s (%s)", winner, Fmt2(winnerValue))

    return result
end

--- @param box table
--- @param now number
--- @param state table|nil
--- @param stateIndex number
local function PopulateStateBoxAdvanced(box, now, state, stateIndex)
    if not box or not box.titleText or not box.bodyText then
        return
    end

    if not state then
        if stateIndex == 0 then
            box.titleText:SetText("State 0 (NOW)")
        else
            box.titleText:SetText(format("State %d", stateIndex))
        end
        box.bodyText:SetText("No data")
        return
    end

    local title
    if stateIndex == 0 then
        title = format(
            "State 0 (NOW) | id=%d | cycle=%d",
            tonumber(state.stateId or 0) or 0,
            tonumber(state.absoluteCycleIndex or state.cycleIndex or 0) or 0
        )
    else
        title = format(
            "State %d | id=%d | cycle=%d",
            stateIndex,
            tonumber(state.stateId or 0) or 0,
            tonumber(state.absoluteCycleIndex or state.cycleIndex or 0) or 0
        )
    end

    local adv = state.advancedDecision or {}
    local mathLines = adv.mathLines or {}
    local adv2 = state.advancedDecision2 or {}
    local mathLines2 = adv2.mathLines or {}
    local slot2Block
    if state.advancedDecision2 then
        slot2Block = format(
            "Slot 2 winner: %s\n%s\n%s\n%s\n%s\n%s\n%s\nSlot 2 reason: %s",
            tostring(adv2.chosenAction or "none"),
            tostring(mathLines2[1] or "Shoot: N/A"),
            tostring(mathLines2[2] or "Steady: N/A"),
            tostring(mathLines2[3] or "Multi: N/A"),
            tostring(mathLines2[4] or "Arcane: N/A"),
            tostring(mathLines2[5] or "Weave: N/A"),
            tostring(mathLines2[6] or "Winner: N/A"),
            tostring(adv2.reason or "advanced: unknown")
        )
    else
        slot2Block = "Slot 2: N/A (no second action in this state)"
    end
    local body = format(
        "actionSummary: %s\n" ..
        "stateStart: %ss\nstateEnd: %ss\n" ..
        "gapStart: %ss\ngapEnd: %ss\n" ..
        "slot1 action: %s\nslot1 reason: %s\nslot1 press/castStart: %ss / %ss\nslot1 castEnd: %ss\nslot1 gcdStart/gcdEnd: %ss / %ss\n" ..
        "slot2 action: %s\nslot2 reason: %s\nslot2 press/castStart: %ss / %ss\nslot2 castEnd: %ss\nslot2 gcdStart/gcdEnd: %ss / %ss\n" ..
        "filler: %s\nfillerStart: %ss\nfillerEnd: %ss\nfillerGcdEnd: %ss\n" ..
        "fillerReason: %s\n" ..
        "earlyGapExists: %s\nearlyGapLhs/Rhs: %.3f / %.3f\n" ..
        "fillerSafetyEval: %s\nfillerLhs: %.3f | fillerRhs: %.3f\nfillerSafe: %s\n" ..
        "nextActionable: %ss\n" ..
        "--- Formula (value = base - penaltyDPS*delay) ---\n" ..
        "Shoot: autoBase - steadyDPS*shootGcdDelay (wait for auto)\n" ..
        "Steady/Multi/Arcane: spellBase - shootDPS*delayToNextAuto\n" ..
        "Winner = max(available). Slot1 at actionableAt; Slot2 at gcdEndAt1.\n" ..
        "--- Slot 1 scores (value-based) ---\n" ..
        "interval: actionableAt=%ss stateEndAt=%ss window=%ss\n" ..
        "Slot 1 winner: %s\n" ..
        "%s\n%s\n%s\n%s\n%s\n%s\n" ..
        "Slot 1 reason: %s\n" ..
        "--- Slot 2 scores (value-based) ---\n%s",
        ActionLabel(state),
        FormatIn(now, state.stateStartAt),
        FormatIn(now, state.stateEndAt),
        FormatIn(now, state.gapStartAt),
        FormatIn(now, state.gapEndAt),
        tostring(state.chosenAction or "none"),
        tostring(state.stateReason or "none"),
        FormatIn(now, state.ssPressAt),
        FormatIn(now, state.ssCastStartAt),
        FormatIn(now, state.ssCastEndAt),
        FormatIn(now, state.gcdStartAt1 or state.gcdStartAt or state.actionableAt),
        FormatIn(now, state.gcdEndAt1 or state.gcdEndAt),
        tostring(state.chosenAction2 or "none"),
        tostring(state.stateReason2 or "none"),
        FormatIn(now, state.ssPressAt2),
        FormatIn(now, state.ssCastStartAt2),
        FormatIn(now, state.ssCastEndAt2),
        FormatIn(now, state.gcdStartAt2),
        FormatIn(now, state.gcdEndAt2),
        tostring(state.fillerSpell or "none"),
        FormatIn(now, state.fillerCastAt),
        FormatIn(now, state.fillerCastEndAt),
        FormatIn(now, state.fillerGcdEndAt),
        tostring(state.fillerReason or "filler: unknown"),
        tostring(state.earlyGapExists == true),
        tonumber(state.earlyGapLhs or 0) or 0,
        tonumber(state.earlyGapRhs or 0) or 0,
        tostring(state.fillerSafetyEvaluated == true),
        tonumber(state.fillerLhs or 0) or 0,
        tonumber(state.fillerRhs or 0) or 0,
        tostring(state.fillerSafe == true),
        FormatIn(now, state.postFillerActionableAt or state.nextActionableAt),
        format("%.3f", tonumber(adv.actionableAtUsed or 0) or 0),
        format("%.3f", tonumber(adv.stateEndAtUsed or 0) or 0),
        format("%.3f", tonumber(adv.windowSeconds or 0) or 0),
        tostring(adv.chosenAction or "none"),
        tostring(mathLines[1] or "Shoot: N/A"),
        tostring(mathLines[2] or "Steady: N/A"),
        tostring(mathLines[3] or "Multi: N/A"),
        tostring(mathLines[4] or "Arcane: N/A"),
        tostring(mathLines[5] or "Weave: N/A"),
        tostring(mathLines[6] or "Winner: N/A"),
        tostring(adv.reason or "advanced: unknown"),
        slot2Block
    )

    box.titleText:SetText(title)
    box.bodyText:SetText(body)
end

-- ============================ FRAME BUILD/UPDATE ============================
--- @return table
function HunterStateTimelineDebug:GetOrCreateDebugFrame()
    if self.state.debugFrame then
        return self.state.debugFrame
    end

    local frameWidth = (BOX_WIDTH * MAX_RENDER_STATES) + (BOX_GAP * (MAX_RENDER_STATES - 1)) + (FRAME_PADDING * 2)
    local frameHeight = BOX_HEIGHT + FRAME_PADDING + FRAME_TITLE_HEIGHT + 6

    local frame = CreateFrame("Frame", FRAME_NAME, UIParent, "BackdropTemplate")
    frame:SetSize(frameWidth, frameHeight)
    frame:SetPoint("CENTER", UIParent, "CENTER", 0, 160)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", function(f)
        f:StartMoving()
    end)
    frame:SetScript("OnDragStop", function(f)
        f:StopMovingOrSizing()
    end)
    frame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 12,
        insets = { left = 3, right = 3, top = 3, bottom = 3 },
    })
    frame:SetBackdropColor(0.05, 0.05, 0.08, 0.92)
    frame:SetBackdropBorderColor(0.4, 0.4, 0.45, 1.0)

    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOPLEFT", frame, "TOPLEFT", FRAME_PADDING, -6)
    title:SetText("Hunter State Timeline Debug (State 0 NOW + next 6)")
    frame.titleText = title

    local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 1, 2)
    frame.closeButton = closeButton

    frame.boxes = {}
    for i = 1, MAX_RENDER_STATES do
        local box = CreateFrame("Frame", nil, frame, "BackdropTemplate")
        box:SetSize(BOX_WIDTH, BOX_HEIGHT)
        if i == 1 then
            box:SetPoint("TOPLEFT", frame, "TOPLEFT", FRAME_PADDING, -(FRAME_PADDING + FRAME_TITLE_HEIGHT))
        else
            box:SetPoint("LEFT", frame.boxes[i - 1], "RIGHT", BOX_GAP, 0)
        end
        box:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8x8",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile = true,
            tileSize = 8,
            edgeSize = 10,
            insets = { left = 2, right = 2, top = 2, bottom = 2 },
        })
        box:SetBackdropColor(0.02, 0.02, 0.02, 0.90)
        box:SetBackdropBorderColor(0.3, 0.3, 0.35, 1.0)

        box.titleText = box:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        box.titleText:SetPoint("TOPLEFT", box, "TOPLEFT", 8, -8)
        box.titleText:SetJustifyH("LEFT")
        box.titleText:SetText(format("State %d", i))

        box.bodyText = box:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        box.bodyText:SetPoint("TOPLEFT", box.titleText, "BOTTOMLEFT", 0, -6)
        box.bodyText:SetPoint("RIGHT", box, "RIGHT", -8, 0)
        box.bodyText:SetPoint("BOTTOM", box, "BOTTOM", 0, 8)
        box.bodyText:SetJustifyH("LEFT")
        box.bodyText:SetJustifyV("TOP")
        box.bodyText:SetText("No data")

        frame.boxes[i] = box
    end

    self.state.debugFrame = frame
    return frame
end

--- @return table
function HunterStateTimelineDebug:GetOrCreateAdvancedDebugFrame()
    if self.state.debugFrameAdvanced then
        return self.state.debugFrameAdvanced
    end

    local frameWidth = (BOX_WIDTH * MAX_RENDER_STATES) + (BOX_GAP * (MAX_RENDER_STATES - 1)) + (FRAME_PADDING * 2)
    local frameHeight = BOX_HEIGHT_ADVANCED + FRAME_PADDING + FRAME_TITLE_HEIGHT + 6

    local frame = CreateFrame("Frame", FRAME_NAME_ADVANCED, UIParent, "BackdropTemplate")
    frame:SetSize(frameWidth, frameHeight)
    frame:SetPoint("CENTER", UIParent, "CENTER", 0, -180)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", function(f)
        f:StartMoving()
    end)
    frame:SetScript("OnDragStop", function(f)
        f:StopMovingOrSizing()
    end)
    frame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 12,
        insets = { left = 3, right = 3, top = 3, bottom = 3 },
    })
    frame:SetBackdropColor(0.05, 0.05, 0.08, 0.92)
    frame:SetBackdropBorderColor(0.4, 0.4, 0.45, 1.0)

    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOPLEFT", frame, "TOPLEFT", FRAME_PADDING, -6)
    title:SetText("Hunter State Timeline Debug Advanced (State 0 NOW + next 6)")
    frame.titleText = title

    local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 1, 2)
    frame.closeButton = closeButton

    frame.boxes = {}
    for i = 1, MAX_RENDER_STATES do
        local box = CreateFrame("Frame", nil, frame, "BackdropTemplate")
        box:SetSize(BOX_WIDTH, BOX_HEIGHT_ADVANCED)
        if i == 1 then
            box:SetPoint("TOPLEFT", frame, "TOPLEFT", FRAME_PADDING, -(FRAME_PADDING + FRAME_TITLE_HEIGHT))
        else
            box:SetPoint("LEFT", frame.boxes[i - 1], "RIGHT", BOX_GAP, 0)
        end
        box:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8x8",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile = true,
            tileSize = 8,
            edgeSize = 10,
            insets = { left = 2, right = 2, top = 2, bottom = 2 },
        })
        box:SetBackdropColor(0.02, 0.02, 0.02, 0.90)
        box:SetBackdropBorderColor(0.3, 0.3, 0.35, 1.0)

        box.titleText = box:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        box.titleText:SetPoint("TOPLEFT", box, "TOPLEFT", 8, -8)
        box.titleText:SetJustifyH("LEFT")
        box.titleText:SetText(format("State %d", i))

        box.bodyText = box:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        box.bodyText:SetPoint("TOPLEFT", box.titleText, "BOTTOMLEFT", 0, -6)
        box.bodyText:SetPoint("RIGHT", box, "RIGHT", -8, 0)
        box.bodyText:SetPoint("BOTTOM", box, "BOTTOM", 0, 8)
        box.bodyText:SetJustifyH("LEFT")
        box.bodyText:SetJustifyV("TOP")
        box.bodyText:SetText("No data")

        frame.boxes[i] = box
    end

    self.state.debugFrameAdvanced = frame
    return frame
end

--- @param timelineResult table
--- @param statesToRender table
function HunterStateTimelineDebug:ShowStateBoxes(timelineResult, statesToRender)
    local frame = self:GetOrCreateDebugFrame()
    local now = tonumber(timelineResult and timelineResult.now or 0) or 0

    for i = 1, MAX_RENDER_STATES do
        local state = statesToRender[i]
        local displayIndex = tonumber(state and state.displayIndex or (i - 1)) or (i - 1)
        PopulateStateBox(frame.boxes[i], now, state, displayIndex)
    end

    frame:Show()
end

--- @param timelineResult table
--- @param statesToRender table
function HunterStateTimelineDebug:ShowStateBoxesAdvanced(timelineResult, statesToRender)
    local frame = self:GetOrCreateAdvancedDebugFrame()
    local now = tonumber(timelineResult and timelineResult.now or 0) or 0

    for i = 1, MAX_RENDER_STATES do
        local state = statesToRender[i]
        local displayIndex = tonumber(state and state.displayIndex or (i - 1)) or (i - 1)
        PopulateStateBoxAdvanced(frame.boxes[i], now, state, displayIndex)
    end

    frame:Show()
end

-- ============================ COMPUTE BREAKDOWN LOGGING ============================
--- Format a state for debug print (compact one-liner).
--- @param now number
--- @param state table|nil
--- @param label string
--- @return string
local function FormatStateDebugLine(now, state, label)
    if not state then
        return format("[%s] (no data)", label)
    end
    local actionIn = SafeIn(now, state.actionableAt or state.gcdReadyAt or state.nextActionableAt)
    local windupStartIn = SafeIn(now, state.windupStartAt or state.gapStartAt)
    local gapEndIn = SafeIn(now, state.gapEndAt or state.stateEndAt)
    local chosen = tostring(state.chosenAction or "none")
    local reason = tostring(state.stateReason or "")
    local chosen2 = tostring(state.chosenAction2 or "none")
    local reason2 = tostring(state.stateReason2 or "")
    return format("[%s] chosen=%s reason=%s | actionIn=%.3f windupStartIn=%.3f gapEndIn=%.3f | slot2=%s reason2=%s",
        label, chosen, reason, actionIn, windupStartIn, gapEndIn, chosen2, reason2)
end

--- Format next N actions for debug print.
--- @param actions table
--- @param count number
--- @return string
local function FormatNextActionsDebug(actions, count)
    local list = actions or {}
    local n = tonumber(count or 3) or 3
    if #list == 0 then
        return "{}"
    end
    local parts = {}
    for i = 1, min(n, #list) do
        local a = list[i]
        local name = tostring(a and a[1] or "none")
        local t1 = tonumber(a and a[2] or 0) or 0
        local t2 = tonumber(a and a[3] or 0) or 0
        if name == "HOLD" or name == "SS" then
            parts[#parts + 1] = format("{%s,%.3f,%.3f}", name, t1, t2)
        else
            parts[#parts + 1] = format("{%s,%.3f}", name, t1)
        end
    end
    return "{" .. table.concat(parts, ", ") .. "}"
end

--- Print full computation breakdown and store for LARGE_DELAY context.
--- @param triggerSource string
--- @param timelineResult table
--- @param statesToRender table
--- @param nextActions table
--- @param steadyWeaveBar table
local function IsDevModeEnabled()
    return NAG and NAG.IsDevModeEnabled and NAG:IsDevModeEnabled() or false
end

local function PrintComputeBreakdown(triggerSource, timelineResult, statesToRender, nextActions, steadyWeaveBar)
    local now = GetTime()
    local t = tonumber(timelineResult and timelineResult.now or 0) or 0
    local ts = date("%H:%M:%S") .. format(" t=%.3f", now)
    local s0 = statesToRender and statesToRender[1]
    local s1 = statesToRender and statesToRender[2]
    if IsDevModeEnabled() then
        NAG:Print(format("[COMPUTE] %s | trigger=%s | ok=%s",
            ts, tostring(triggerSource or "unknown"), tostring(timelineResult and timelineResult.ok == true)))
        NAG:Print("  " .. FormatStateDebugLine(t, s0, "state0"))
        NAG:Print("  " .. FormatStateDebugLine(t, s1, "state1"))
        NAG:Print(format("  next6=%s", FormatNextActionsDebug(nextActions, 6)))
    end
    if steadyWeaveBar and steadyWeaveBar.state then
        steadyWeaveBar.state.lastComputationDebug = {
            timestamp = now,
            timestampStr = ts,
            triggerSource = triggerSource,
            ok = timelineResult and timelineResult.ok == true,
            reason = timelineResult and timelineResult.reason or nil,
            state0 = s0 and {
                chosen = tostring(s0.chosenAction or "none"),
                reason = tostring(s0.stateReason or ""),
                chosen2 = tostring(s0.chosenAction2 or "none"),
                reason2 = tostring(s0.stateReason2 or ""),
                actionIn = SafeIn(t, s0.actionableAt or s0.gcdReadyAt or s0.nextActionableAt),
                windupStartIn = SafeIn(t, s0.windupStartAt or s0.gapStartAt),
                gapEndIn = SafeIn(t, s0.gapEndAt or s0.stateEndAt),
            } or nil,
            state1 = s1 and {
                chosen = tostring(s1.chosenAction or "none"),
                reason = tostring(s1.stateReason or ""),
                chosen2 = tostring(s1.chosenAction2 or "none"),
                reason2 = tostring(s1.stateReason2 or ""),
                actionIn = SafeIn(t, s1.actionableAt or s1.gcdReadyAt or s1.nextActionableAt),
                windupStartIn = SafeIn(t, s1.windupStartAt or s1.gapStartAt),
                gapEndIn = SafeIn(t, s1.gapEndAt or s1.stateEndAt),
            } or nil,
            next6 = {},
        }
        for i = 1, min(6, #(nextActions or {})) do
            local a = nextActions[i]
            if a then
                steadyWeaveBar.state.lastComputationDebug.next6[i] = {
                    tostring(a[1] or "none"),
                    tonumber(a[2] or 0) or 0,
                    tonumber(a[3] or 0) or 0,
                }
            end
        end
    end
end

-- ============================ SLASH COMMAND ============================
--- Refresh the HunterSteadyWeaveBar snapshot without chat prints/UI boxes.
--- Horizon is derived from the bar setting: visibleWindowSeconds + 1.
--- @param idleAtWindupOverride table|nil
--- @param triggerSource string|nil Source that triggered the compute (for debug logging).
--- @return boolean refreshed
function HunterStateTimelineDebug:RefreshBarSnapshot(idleAtWindupOverride, triggerSource)
    local steadyWeaveBar = NAG:GetModule("HunterSteadyWeaveBar", true)
    if not steadyWeaveBar or not steadyWeaveBar.SetDebugSnapshot then
        return false
    end

    local hunterAPI = NAG:GetModule("TBCHunterAPI", true)
    if not hunterAPI then
        return false
    end

    local barDb = steadyWeaveBar.db and steadyWeaveBar.db.class or nil
    local visibleWindowSeconds = tonumber(barDb and barDb.visibleWindowSeconds or 4) or 4
    if visibleWindowSeconds < 1 then
        visibleWindowSeconds = 1
    elseif visibleWindowSeconds > 30 then
        visibleWindowSeconds = 30
    end
    local horizonSeconds = visibleWindowSeconds + 1

    local delaySeconds = GetUserInputDelaySeconds(steadyWeaveBar)
    local timelineOptions = nil
    if type(idleAtWindupOverride) == "table" then
        local snapshotAt = tonumber(idleAtWindupOverride.snapshotAt or 0) or 0
        local firstAutoshotFromSnapshot = tonumber(idleAtWindupOverride.firstAutoshotFromSnapshot or 0) or 0
        local windupSeconds = tonumber(idleAtWindupOverride.windupSeconds or 0) or 0
        local rangedSpeed = tonumber(idleAtWindupOverride.rangedSpeed or 0) or 0
        if snapshotAt > 0 and firstAutoshotFromSnapshot >= 0 and windupSeconds > 0 then
            timelineOptions = {
                overrideNow = snapshotAt + firstAutoshotFromSnapshot,
                overrideRangedTimeToNext = windupSeconds,
                overrideRangedSpeed = rangedSpeed,
            }
        end
    end
    local hadIdleOverride = timelineOptions ~= nil
    timelineOptions = timelineOptions or {}
    timelineOptions.triggerSource = tostring(triggerSource or "unknown")

    local timelineResult = hunterAPI:PredictStateTimelineLive(horizonSeconds, timelineOptions)
    if not timelineResult or timelineResult.ok ~= true then
        return false
    end

    local allStates = timelineResult.states or {}
    local stateCount = #allStates
    local statesToRender = {}

    statesToRender[1] = timelineResult.state0
    if statesToRender[1] then
        statesToRender[1].displayIndex = 0
    end

    local maxFutureStates = MAX_RENDER_STATES - 1
    local futureRenderCount = (stateCount < maxFutureStates) and stateCount or maxFutureStates
    for i = 1, futureRenderCount do
        statesToRender[i + 1] = allStates[i]
        if statesToRender[i + 1] then
            statesToRender[i + 1].displayIndex = i
        end
    end

    local now = tonumber(timelineResult.now or 0) or 0
    local nextActions = BuildNextActionsTimeline(now, statesToRender, NEXT_ACTION_COUNT, delaySeconds, timelineResult.gcdLeft)
    local autoshotMoments = BuildAutoshotMomentsTimeline(now, statesToRender)
    PrintComputeBreakdown(tostring(triggerSource or "unknown"), timelineResult, statesToRender, nextActions, steadyWeaveBar)
    steadyWeaveBar:SetDebugSnapshot(now, nextActions, horizonSeconds, autoshotMoments, {
        idleAtWindup = hadIdleOverride,
        windupSeconds = tonumber(timelineResult.windupSeconds or 0) or 0,
        rangedSpeed = tonumber(timelineResult.rangedSpeed or 0) or 0,
    })
    return true
end

--- Run the state debug command and render state boxes.
--- @param input string|nil Optional: state index 0-6 to print that state to chat.
function HunterStateTimelineDebug:RunStateDebug(input)
    local hunterAPI = NAG:GetModule("TBCHunterAPI", true)
    if not hunterAPI then
        NAG:Print("|cffff0000[NAG] TBCHunterAPI module is unavailable.|r")
        return
    end

    local timelineResult = hunterAPI:PredictStateTimelineLive(COMMAND_HORIZON_SECONDS)
    if not timelineResult or timelineResult.ok ~= true then
        local reason = timelineResult and timelineResult.reason or "unknown"
        NAG:Print(format("|cffff0000[NAG] Hunter state debug failed: %s|r", tostring(reason)))
        return
    end

    local allStates = timelineResult.states or {}
    local stateCount = #allStates
    local statesToRender = {}

    statesToRender[1] = timelineResult.state0
    if statesToRender[1] then
        statesToRender[1].displayIndex = 0
    end

    local maxFutureStates = MAX_RENDER_STATES - 1
    local futureRenderCount = (stateCount < maxFutureStates) and stateCount or maxFutureStates
    for i = 1, futureRenderCount do
        statesToRender[i + 1] = allStates[i]
        if statesToRender[i + 1] then
            statesToRender[i + 1].displayIndex = i
        end
    end
    local renderCount = 1 + futureRenderCount

    local now = tonumber(timelineResult.now or 0) or 0

    -- Optional: print a specific state (e.g. /nagdebug hunter-state-debug 0)
    local printStateIndex = nil
    if input and type(input) == "string" then
        local s = input:match("^%s*(%d+)%s*$")
        if s then
            local n = tonumber(s)
            if n and n >= 0 and n <= (MAX_RENDER_STATES - 1) then
                printStateIndex = n
            end
        end
    end
    if printStateIndex ~= nil then
        local printState = nil
        for i = 1, renderCount do
            if statesToRender[i] and tonumber(statesToRender[i].displayIndex or -1) == printStateIndex then
                printState = statesToRender[i]
                break
            end
        end
        if printState then
            PrintStateToChat(now, printStateIndex, printState)
        else
            NAG:Print(format("|cffff0000[Hunter State %d] No data.|r", printStateIndex))
        end
    end

    NAG:Print(format(
        "[HUNTER_STATE_DEBUG] states=%d showing=%d (state0+future=%d) now=%.3f horizon=%.3f",
        stateCount,
        renderCount,
        futureRenderCount,
        now,
        tonumber(timelineResult.horizonSeconds or 0) or 0
    ))
    local steadyWeaveBar = NAG:GetModule("HunterSteadyWeaveBar", true)
    local delaySeconds = GetUserInputDelaySeconds(steadyWeaveBar)
    local nextActions = BuildNextActionsTimeline(now, statesToRender, NEXT_ACTION_COUNT, delaySeconds, timelineResult.gcdLeft)
    NAG:Print(format(
        "[HUNTER_STATE_DEBUG] Next %d actions: %s",
        NEXT_ACTION_COUNT,
        FormatNextActionsString(nextActions)
    ))
    if steadyWeaveBar and steadyWeaveBar.SetDebugSnapshot then
        local horizonSeconds = tonumber(timelineResult.horizonSeconds or 0) or 0
        local autoshotMoments = BuildAutoshotMomentsTimeline(now, statesToRender)
        steadyWeaveBar:SetDebugSnapshot(now, nextActions, horizonSeconds, autoshotMoments, {
            windupSeconds = tonumber(timelineResult.windupSeconds or 0) or 0,
            rangedSpeed = tonumber(timelineResult.rangedSpeed or 0) or 0,
        })
    end
    for i = 1, renderCount do
        local state = statesToRender[i]
        if state then
            NAG:Print(BuildStatePrintLine(now, tonumber(state.displayIndex or i) or i, state))
        end
    end

    self:ShowStateBoxes(timelineResult, statesToRender)
end

--- Run advanced state debug command with value-based math and separate frame.
--- @param input string|nil Optional: state index 0-6 to print that state to chat.
function HunterStateTimelineDebug:RunStateDebugAdvanced(input)
    local hunterAPI = NAG:GetModule("TBCHunterAPI", true)
    if not hunterAPI then
        NAG:Print("|cffff0000[NAG] TBCHunterAPI module is unavailable.|r")
        return
    end

    local timelineResult = hunterAPI:PredictStateTimelineLive(COMMAND_HORIZON_SECONDS)
    if not timelineResult or timelineResult.ok ~= true then
        local reason = timelineResult and timelineResult.reason or "unknown"
        NAG:Print(format("|cffff0000[NAG] Hunter advanced state debug failed: %s|r", tostring(reason)))
        return
    end

    local allStates = timelineResult.states or {}
    local stateCount = #allStates
    local statesToRender = {}

    statesToRender[1] = timelineResult.state0
    if statesToRender[1] then
        statesToRender[1].displayIndex = 0
    end

    local maxFutureStates = MAX_RENDER_STATES - 1
    local futureRenderCount = (stateCount < maxFutureStates) and stateCount or maxFutureStates
    for i = 1, futureRenderCount do
        statesToRender[i + 1] = allStates[i]
        if statesToRender[i + 1] then
            statesToRender[i + 1].displayIndex = i
        end
    end
    local renderCount = 1 + futureRenderCount

    local now = tonumber(timelineResult.now or 0) or 0

    for i = 1, renderCount do
        local state = statesToRender[i]
        if state then
            local displayIndex = tonumber(state.displayIndex or (i - 1)) or (i - 1)
            -- Slot 1: decision at state actionable time
            state.advancedDecision = ComputeValueBasedDecision(state, timelineResult, displayIndex, nil)
            state.advancedChosenAction = state.advancedDecision and state.advancedDecision.chosenAction or "none"
            state.advancedMathLines = state.advancedDecision and state.advancedDecision.mathLines or {}
            state.advancedReason = state.advancedDecision and state.advancedDecision.reason or "advanced: unknown"
            -- Slot 2: decision when we can start the second action (after slot 1 GCD), not after we finish slot 2
            local gcdEnd1 = tonumber(state.gcdEndAt1 or 0) or 0
            local endAt = tonumber(state.stateEndAt or 0) or 0
            local hasSlot2 = (state.chosenAction2 and state.chosenAction2 ~= "" and state.chosenAction2 ~= "none")
                or (gcdEnd1 > 0 and gcdEnd1 < endAt)
            if hasSlot2 then
                -- When we can act for slot 2 = when slot 1's GCD ends (or when slot 2 is pressed)
                local slot2ActionableAt = gcdEnd1 > 0 and gcdEnd1 or tonumber(state.ssPressAt2 or 0) or 0
                if slot2ActionableAt > 0 and slot2ActionableAt < endAt then
                    -- Use CD state after slot 1 only (so slot 2 math sees AR/MS available if slot 1 didn't use them)
                    local msSlot2 = tonumber(state.msReadyAtAfterSlot1 or state.msReadyAtAfter or 0) or 0
                    local arSlot2 = tonumber(state.arReadyAtAfterSlot1 or state.arReadyAtAfter or 0) or 0
                    state.advancedDecision2 = ComputeValueBasedDecision(state, timelineResult, displayIndex, {
                        actionableAt = slot2ActionableAt,
                        gcdAt = gcdEnd1,
                        msReadyAt = msSlot2,
                        arReadyAt = arSlot2,
                    })
                else
                    state.advancedDecision2 = nil
                end
            else
                state.advancedDecision2 = nil
            end
        end
    end

    local printStateIndex = nil
    if input and type(input) == "string" then
        local s = input:match("^%s*(%d+)%s*$")
        if s then
            local n = tonumber(s)
            if n and n >= 0 and n <= (MAX_RENDER_STATES - 1) then
                printStateIndex = n
            end
        end
    end
    if printStateIndex ~= nil then
        local printState = nil
        for i = 1, renderCount do
            if statesToRender[i] and tonumber(statesToRender[i].displayIndex or -1) == printStateIndex then
                printState = statesToRender[i]
                break
            end
        end
        if printState then
            PrintStateToChat(now, printStateIndex, printState)
            local adv1 = printState.advancedDecision
            if adv1 then
                NAG:Print("  |cff00ff00--- Slot 1 scores (value-based) ---|r")
                NAG:Print(format("  Slot 1 winner: %s  |  Shoot=%s  Steady=%s  Multi=%s  Arcane=%s",
                    tostring(adv1.chosenAction or "none"),
                    (adv1.valueShoot ~= nil) and Fmt2(adv1.valueShoot) or "N/A",
                    (adv1.valueSteady ~= nil) and Fmt2(adv1.valueSteady) or "N/A",
                    (adv1.valueMulti ~= nil) and Fmt2(adv1.valueMulti) or "N/A",
                    (adv1.valueArcane ~= nil) and Fmt2(adv1.valueArcane) or "N/A"))
                NAG:Print(format("  Slot 1 reason: %s", tostring(adv1.reason or "advanced: unknown")))
                local lines = adv1.mathLines or {}
                for idx = 1, #lines do
                    NAG:Print(format("  Slot1 math[%d]: %s", idx, tostring(lines[idx] or "")))
                end
            end
            local adv2 = printState.advancedDecision2
            if adv2 then
                NAG:Print("  |cff00ff00--- Slot 2 scores (value-based) ---|r")
                NAG:Print(format("  Slot 2 winner: %s  |  Shoot=%s  Steady=%s  Multi=%s  Arcane=%s",
                    tostring(adv2.chosenAction or "none"),
                    (adv2.valueShoot ~= nil) and Fmt2(adv2.valueShoot) or "N/A",
                    (adv2.valueSteady ~= nil) and Fmt2(adv2.valueSteady) or "N/A",
                    (adv2.valueMulti ~= nil) and Fmt2(adv2.valueMulti) or "N/A",
                    (adv2.valueArcane ~= nil) and Fmt2(adv2.valueArcane) or "N/A"))
                NAG:Print(format("  Slot 2 reason: %s", tostring(adv2.reason or "advanced: unknown")))
                local lines2 = adv2.mathLines or {}
                for idx = 1, #lines2 do
                    NAG:Print(format("  Slot2 math[%d]: %s", idx, tostring(lines2[idx] or "")))
                end
            elseif printState.advancedDecision then
                NAG:Print("  Slot 2 scores: N/A (no second action in this state)")
            end
        else
            NAG:Print(format("|cffff0000[Hunter State %d] No data.|r", printStateIndex))
        end
    end

    NAG:Print(format(
        "[HUNTER_STATE_DEBUG_ADVANCED] states=%d showing=%d (state0+future=%d) now=%.3f horizon=%.3f",
        stateCount,
        renderCount,
        futureRenderCount,
        now,
        tonumber(timelineResult.horizonSeconds or 0) or 0
    ))
    local steadyWeaveBar = NAG:GetModule("HunterSteadyWeaveBar", true)
    local delaySeconds = GetUserInputDelaySeconds(steadyWeaveBar)
    local nextActions = BuildNextActionsTimeline(now, statesToRender, NEXT_ACTION_COUNT, delaySeconds, timelineResult.gcdLeft)
    NAG:Print(format(
        "[HUNTER_STATE_DEBUG_ADVANCED] Next %d actions: %s",
        NEXT_ACTION_COUNT,
        FormatNextActionsString(nextActions)
    ))
    if steadyWeaveBar and steadyWeaveBar.SetDebugSnapshot then
        local horizonSeconds = tonumber(timelineResult.horizonSeconds or 0) or 0
        local autoshotMoments = BuildAutoshotMomentsTimeline(now, statesToRender)
        steadyWeaveBar:SetDebugSnapshot(now, nextActions, horizonSeconds, autoshotMoments, {
            windupSeconds = tonumber(timelineResult.windupSeconds or 0) or 0,
            rangedSpeed = tonumber(timelineResult.rangedSpeed or 0) or 0,
        })
    end
    for i = 1, renderCount do
        local state = statesToRender[i]
        if state then
            local displayIndex = tonumber(state.displayIndex or i) or i
            local adv1 = state.advancedDecision or {}
            NAG:Print(BuildStatePrintLine(now, displayIndex, state))
            NAG:Print(format(
                "[HUNTER_STATE_DEBUG_ADVANCED] idx=%d Slot1: winner=%s shoot=%s steady=%s multi=%s arcane=%s",
                displayIndex,
                tostring(adv1.chosenAction or "none"),
                (adv1.valueShoot ~= nil) and Fmt2(adv1.valueShoot) or "N/A",
                (adv1.valueSteady ~= nil) and Fmt2(adv1.valueSteady) or "N/A",
                (adv1.valueMulti ~= nil) and Fmt2(adv1.valueMulti) or "N/A",
                (adv1.valueArcane ~= nil) and Fmt2(adv1.valueArcane) or "N/A"
            ))
            local adv2 = state.advancedDecision2
            if adv2 then
                NAG:Print(format(
                    "[HUNTER_STATE_DEBUG_ADVANCED] idx=%d Slot2: winner=%s shoot=%s steady=%s multi=%s arcane=%s",
                    displayIndex,
                    tostring(adv2.chosenAction or "none"),
                    (adv2.valueShoot ~= nil) and Fmt2(adv2.valueShoot) or "N/A",
                    (adv2.valueSteady ~= nil) and Fmt2(adv2.valueSteady) or "N/A",
                    (adv2.valueMulti ~= nil) and Fmt2(adv2.valueMulti) or "N/A",
                    (adv2.valueArcane ~= nil) and Fmt2(adv2.valueArcane) or "N/A"
                ))
            end
        end
    end

    -- Show normal + advanced from the exact same snapshot for direct comparison.
    self:ShowStateBoxes(timelineResult, statesToRender)
    self:ShowStateBoxesAdvanced(timelineResult, statesToRender)
end
