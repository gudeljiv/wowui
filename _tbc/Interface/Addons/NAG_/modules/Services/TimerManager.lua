--- @module "NAG.TimerManager"
--- Manages timer functionality for NAG.
---
--- This module provides functions for creating, canceling, and checking timers.
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- Lua APIs (using WoW's optimized versions where available)
local format = string.format -- WoW's optimized version if available
local tostring = tostring
local type = type
local unpack = unpack
local select = select
local pairs = pairs
local next = next
local xpcall = xpcall

local GetTime = _G.GetTime
local CreateFrame = _G.CreateFrame
local geterrorhandler = _G.geterrorhandler
local debugstack = _G.debugstack
local UnitAffectingCombat = _G.UnitAffectingCombat
local IsMounted = _G.IsMounted
local IsFlying = _G.IsFlying

local MIN_TIMER_INTERVAL_SEC = 0.01
local INTERNAL_FRAME_POLL_INTERVAL_SEC = 0.01
local INTERNAL_FRAME_POLL_INTERVAL_IDLE_SEC = 0.02



-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~
--- @class TimerManager
local TimerManager = NAG:CreateModule("TimerManager", nil, {
    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.SERVICES,
        ns.DEBUG_CATEGORIES.MANAGERS
    }
})
local module = TimerManager
ns.TimerManager = TimerManager

-- Timer categories for organization
TimerManager.Categories = {
    CORE = "core",                       -- Core addon functionality
    ROTATION = "rotation",               -- Rotation-related timers
    COMBAT = "combat",                   -- Combat-related timers
    UI_NOTIFICATION = "ui_notification", -- UI notification and alert timers
}

-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~
do
    function TimerManager:ModuleInitialize()
        -- Initialize timer tracking
        self.timers = {
            [self.Categories.CORE] = {},
            [self.Categories.ROTATION] = {},
            [self.Categories.COMBAT] = {},
            [self.Categories.UI_NOTIFICATION] = {},
        }

        -- Internal scheduler feature flag (now default-on; we no longer depend on AceTimer)
        self.useInternalScheduler = true

        -- Error tracking (in-memory only)
        self._timerErrors = {}
        self._timerErrorLastLog = {}
        self._timerErrorLogCooldown = 2

        -- Internal scheduler state
        self._internalTimers = {}
        self._internalNextId = 0
        self._internalFrame = nil
        self._internalMaxCallbacksPerUpdate = 50
        self._timerMetrics = {}
        self._internalPerf = {
            onUpdateCalls = 0,
            idleOnUpdateCalls = 0,
            callbacksProcessed = 0,
            activeTimersPeak = 0,
            lastReportAt = 0,
        }
    end

    function TimerManager:ModuleEnable()
        -- Nothing to do on enable - timers are created on demand
    end

    function TimerManager:ModuleDisable()
        self:CancelAllTimers()
    end
end

-- ~~~~~~~~~~ HELPERS & PUBLIC API ~~~~~~~~~~
local function SafeTimerKey(category, name)
    return tostring(category) .. ":" .. tostring(name)
end

local function EnsureTimerMetric(self, timerKey)
    if not self._timerMetrics then
        self._timerMetrics = {}
    end
    if not self._timerMetrics[timerKey] then
        self._timerMetrics[timerKey] = {
            callbacks = 0,
            lastLag = 0,
            maxLag = 0,
            lastFiredAt = 0,
        }
    end
    return self._timerMetrics[timerKey]
end

function TimerManager:_LogTimerError(timerKey, err)
    self._timerErrors[timerKey] = (self._timerErrors[timerKey] or 0) + 1

    local now = GetTime and GetTime() or 0
    local last = self._timerErrorLastLog[timerKey] or 0
    if (now - last) < (self._timerErrorLogCooldown or 2) then
        return
    end
    self._timerErrorLastLog[timerKey] = now

    local details = tostring(err)
    if debugstack then
        details = details .. "\n" .. tostring(debugstack(2, 8, 8))
    end
    self:Error("Timer error (%s): %s", tostring(timerKey), details)
end

function TimerManager:_SafeInvoke(timerKey, callback, ...)
    local handler = geterrorhandler and geterrorhandler() or function(e) return e end
    local ok, err = xpcall(callback, handler, ...)
    if not ok then
        self:_LogTimerError(timerKey, err)
    end
end

function TimerManager:_EnsureInternalFrame()
    if self._internalFrame then
        return
    end
    local frame = CreateFrame("Frame")
    frame:Hide()
    frame:SetScript("OnUpdate", function(_, elapsed)
        self:_InternalOnUpdate(elapsed)
    end)
    self._internalFrame = frame
end

function TimerManager:GetInternalFramePollIntervalSec()
    local inCombat = UnitAffectingCombat and UnitAffectingCombat("player")
    if inCombat then
        return INTERNAL_FRAME_POLL_INTERVAL_SEC
    end
    return INTERNAL_FRAME_POLL_INTERVAL_IDLE_SEC
end

function TimerManager:_InternalOnUpdate(elapsed)
    self._internalPerf.onUpdateCalls = (self._internalPerf.onUpdateCalls or 0) + 1
    if UnitAffectingCombat and not UnitAffectingCombat("player") then
        self._internalPerf.idleOnUpdateCalls = (self._internalPerf.idleOnUpdateCalls or 0) + 1
    end
    self._internalElapsedAccum = (self._internalElapsedAccum or 0) + (elapsed or 0)
    if self._internalElapsedAccum < self:GetInternalFramePollIntervalSec() then
        return
    end
    self._internalElapsedAccum = 0

    if not self._internalTimers or not next(self._internalTimers) then
        if self._internalFrame then
            self._internalFrame:Hide()
        end
        return
    end

    local now = GetTime()
    local processed = 0
    local maxCallbacks = self._internalMaxCallbacksPerUpdate or 50
    local activeTimers = 0

    for id, t in pairs(self._internalTimers) do
        activeTimers = activeTimers + 1
        if processed >= maxCallbacks then
            break
        end
        if t and not t.cancelled and t.nextFireAt and now >= t.nextFireAt then
            processed = processed + 1
            local timerKey = t.timerKey or ("internal:" .. tostring(id))
            local lag = now - (t.nextFireAt or now)
            if lag < 0 then
                lag = 0
            end
            local metric = EnsureTimerMetric(self, timerKey)
            metric.callbacks = (metric.callbacks or 0) + 1
            metric.lastLag = lag
            metric.lastFiredAt = now
            if lag > (metric.maxLag or 0) then
                metric.maxLag = lag
            end
            self:_SafeInvoke(timerKey, t.callback, unpack(t.args, 1, t.argsCount))

            if t.repeating and not t.cancelled then
                local interval = t.interval or MIN_TIMER_INTERVAL_SEC
                if interval < MIN_TIMER_INTERVAL_SEC then
                    interval = MIN_TIMER_INTERVAL_SEC
                end
                -- Compensate drift: advance from previous schedule until it's in the future.
                local nextAt = (t.nextFireAt or now) + interval
                if nextAt <= now then
                    nextAt = now + interval
                end
                t.nextFireAt = nextAt
            else
                self._internalTimers[id] = nil
            end
        end
    end
    self._internalPerf.callbacksProcessed = (self._internalPerf.callbacksProcessed or 0) + processed
    self._internalPerf.activeTimersPeak = math.max(self._internalPerf.activeTimersPeak or 0, activeTimers)
    local nowForReport = now
    if (nowForReport - (self._internalPerf.lastReportAt or 0)) >= 10 then
        self:Debug(
            "Internal scheduler stats: onUpdate=%d idleOnUpdate=%d callbacks=%d activePeak=%d activeNow=%d",
            self._internalPerf.onUpdateCalls or 0,
            self._internalPerf.idleOnUpdateCalls or 0,
            self._internalPerf.callbacksProcessed or 0,
            self._internalPerf.activeTimersPeak or 0,
            activeTimers
        )
        self._internalPerf.onUpdateCalls = 0
        self._internalPerf.idleOnUpdateCalls = 0
        self._internalPerf.callbacksProcessed = 0
        self._internalPerf.activeTimersPeak = activeTimers
        self._internalPerf.lastReportAt = nowForReport
    end
end

function TimerManager:_InternalSchedule(timerKey, repeating, callback, interval, ...)
    if not callback or type(callback) ~= "function" then
        return nil
    end

    local delay = interval or MIN_TIMER_INTERVAL_SEC
    if delay < MIN_TIMER_INTERVAL_SEC then
        delay = MIN_TIMER_INTERVAL_SEC
    end

    self:_EnsureInternalFrame()

    self._internalNextId = (self._internalNextId or 0) + 1
    local id = self._internalNextId

    local argsCount = select("#", ...)
    local args = { ... }

    self._internalTimers[id] = {
        id = id,
        timerKey = timerKey,
        repeating = repeating and true or false,
        callback = callback,
        interval = delay,
        nextFireAt = GetTime() + delay,
        args = args,
        argsCount = argsCount,
        cancelled = false,
    }

    if self._internalFrame then
        self._internalFrame:Show()
    end

    return { __nagTimer = true, id = id }
end

function TimerManager:_InternalCancel(handle)
    if not handle or not handle.__nagTimer or not handle.id then
        return false
    end
    local t = self._internalTimers and self._internalTimers[handle.id]
    if not t then
        return false
    end
    t.cancelled = true
    self._internalTimers[handle.id] = nil
    return true
end

function TimerManager:_InternalTimeLeft(handle)
    if not handle or not handle.__nagTimer or not handle.id then
        return 0
    end
    local t = self._internalTimers and self._internalTimers[handle.id]
    if not t or not t.nextFireAt then
        return 0
    end
    return t.nextFireAt - GetTime()
end

--- Schedule a one-shot timer (AceTimer-like API) with error hardening.
function TimerManager:ScheduleTimer(func, delay, ...)
    local timerKey = "handle:oneshot"
    if not self._internalTimers then
        self:ModuleInitialize()
    end
    return self:_InternalSchedule(timerKey, false, func, delay, ...)
end

--- Schedule a repeating timer (AceTimer-like API) with error hardening.
function TimerManager:ScheduleRepeatingTimer(func, delay, ...)
    local timerKey = "handle:repeating"
    if not self._internalTimers then
        self:ModuleInitialize()
    end
    return self:_InternalSchedule(timerKey, true, func, delay, ...)
end

--- Cancel a timer by handle (AceTimer-like API).
function TimerManager:CancelTimer(handle)
    if not self._internalTimers then
        return false
    end
    return self:_InternalCancel(handle)
end

--- Returns the time left for a handle-based timer (AceTimer-like API).
function TimerManager:TimeLeft(handle)
    if not self._internalTimers then
        return 0
    end
    return self:_InternalTimeLeft(handle)
end

--- Creates and registers a new timer
--- @param category string The category for the timer (use TimerManager.Categories)
--- @param name string Unique name for the timer within its category
--- @param callback function The function to call when the timer fires
--- @param interval number The interval in seconds
--- @param repeating boolean Whether the timer should repeat
--- @param args? table Optional arguments to pass to the callback
--- @return any|nil timerHandle The handle of the created timer, or nil if failed
function TimerManager:Create(category, name, callback, interval, repeating, args)
    -- Safety check: ensure timers are initialized
    if not self.timers then
        self:ModuleInitialize()
    end

    -- Validate inputs
    if not self.timers[category] then
        self:Error(format("Invalid timer category: %s", tostring(category)))
        return nil
    end

    if not name or type(name) ~= "string" then
        self:Error(format("Invalid timer name: %s", tostring(name)))
        return nil
    end

    if not callback or type(callback) ~= "function" then
        self:Error(format("Invalid timer callback: %s", tostring(callback)))
        return nil
    end

    if not interval or type(interval) ~= "number" or interval <= 0 then
        self:Error(format("Invalid timer interval: %s", tostring(interval)))
        return nil
    end

    if self.timers[category][name] then
        -- Don't spam debug for duplicate timers - just return existing
        return self.timers[category][name]
    end

    -- Create the timer using Ace3
    local timer
    local timerKey = SafeTimerKey(category, name)
    local nextExpectedAt = GetTime() + interval
    if repeating then
        timer = self:ScheduleRepeatingTimer(function()
            local now = GetTime()
            local lag = now - nextExpectedAt
            if lag < 0 then
                lag = 0
            end
            local metric = EnsureTimerMetric(self, timerKey)
            metric.callbacks = (metric.callbacks or 0) + 1
            metric.lastLag = lag
            metric.lastFiredAt = now
            if lag > (metric.maxLag or 0) then
                metric.maxLag = lag
            end
            nextExpectedAt = nextExpectedAt + interval
            if nextExpectedAt <= now then
                nextExpectedAt = now + interval
            end
            if args then
                self:_SafeInvoke(timerKey, callback, unpack(args))
            else
                self:_SafeInvoke(timerKey, callback)
            end
        end, interval)
    else
        timer = self:ScheduleTimer(function()
            local now = GetTime()
            local lag = now - nextExpectedAt
            if lag < 0 then
                lag = 0
            end
            local metric = EnsureTimerMetric(self, timerKey)
            metric.callbacks = (metric.callbacks or 0) + 1
            metric.lastLag = lag
            metric.lastFiredAt = now
            if lag > (metric.maxLag or 0) then
                metric.maxLag = lag
            end
            if args then
                self:_SafeInvoke(timerKey, callback, unpack(args))
            else
                self:_SafeInvoke(timerKey, callback)
            end
            -- Auto-cleanup non-repeating timers (even if callback errored)
            self.timers[category][name] = nil
        end, interval)
    end

    -- Store timer reference
    self.timers[category][name] = timer

    return timer
end

--- Returns timer execution metrics for diagnostics.
--- @param category string
--- @param name string
--- @return table
function TimerManager:GetTimerMetrics(category, name)
    local timerKey = SafeTimerKey(category, name)
    local metric = self._timerMetrics and self._timerMetrics[timerKey]
    if not metric then
        return {
            callbacks = 0,
            lastLag = 0,
            maxLag = 0,
            lastFiredAt = 0,
        }
    end
    return metric
end

--- Cancels a specific timer
--- @param category string The category of the timer
--- @param name string The name of the timer to cancel
function TimerManager:Cancel(category, name)
    -- Safety check: ensure timers are initialized
    if not self.timers then
        return
    end

    -- Validate inputs
    if not category or not self.timers[category] then
        return
    end

    if not name or not self.timers[category][name] then
        return
    end

    -- Cancel underlying timer handle
    self:CancelTimer(self.timers[category][name])
    self.timers[category][name] = nil
end

--- Cancels all timers in a category
--- @param category string The category of timers to cancel
function TimerManager:CancelCategoryTimers(category)
    -- Safety check: ensure timers are initialized
    if not self.timers then
        return
    end

    if not self.timers[category] then
        return
    end

    for name, timer in pairs(self.timers[category]) do
        self:Cancel(category, name)
    end
end

--- Cancels all registered timers
function TimerManager:CancelAllTimers()
    -- Safety check: ensure timers are initialized
    if not self.timers then
        return
    end

    for category in pairs(self.timers) do
        for name, timer in pairs(self.timers[category]) do
            self:Cancel(category, name)
        end
    end

    -- Also cancel any handle-based internal timers (ScheduleTimer/ScheduleRepeatingTimer)
    if self._internalTimers then
        for id, t in pairs(self._internalTimers) do
            self._internalTimers[id] = nil
        end
    end
    if self._internalFrame then
        self._internalFrame:Hide()
    end
end

--- Checks if a specific timer is active
--- @param category string The category to check
--- @param name string The name of the timer to check
--- @return boolean isActive Whether the timer exists and is active
function TimerManager:IsTimerActive(category, name)
    -- Safety check: ensure timers are initialized
    if not self.timers then
        return false
    end

    -- Validate inputs
    if not category or not name then
        return false
    end

    return self.timers[category] and self.timers[category][name] ~= nil
end

--- Prints all active timers to debug output
--- @param category string Optional category to filter by
function TimerManager:PrintActiveTimers(category)
    -- Safety check: ensure timers are initialized
    if not self.timers then
        self:Debug("TimerManager not initialized")
        return
    end

    local hasActiveTimers = false

    for cat, timers in pairs(self.timers) do
        -- Skip if filtering by category and this isn't it
        if category and cat ~= category then
            -- Continue to next iteration (Lua 5.1 compatible)
        else
            local categoryHasTimers = false
            for name, timer in pairs(timers) do
                if not categoryHasTimers then
                    self:Debug("=== Active Timers in Category: %s ===", cat)
                    categoryHasTimers = true
                    hasActiveTimers = true
                end
                self:Debug("  Timer: %s (Handle: %s)", name, tostring(timer))
            end
        end
    end

    if not hasActiveTimers then
        if category then
            self:Debug("No active timers in category: %s", category)
        else
            self:Debug("No active timers found")
        end
    end
end

--- Gets a count of active timers
--- @param category string Optional category to count
--- @return number count Number of active timers
function TimerManager:GetActiveTimerCount(category)
    -- Safety check: ensure timers are initialized
    if not self.timers then
        return 0
    end

    local count = 0

    for cat, timers in pairs(self.timers) do
        -- Skip if filtering by category and this isn't it
        if category and cat ~= category then
            -- Continue to next iteration (Lua 5.1 compatible)
        else
            for name, timer in pairs(timers) do
                count = count + 1
            end
        end
    end

    return count
end

--- Prints internal scheduler performance diagnostics.
function TimerManager:PrintInternalSchedulerStats()
    local activeInternal = 0
    if self._internalTimers then
        for _ in pairs(self._internalTimers) do
            activeInternal = activeInternal + 1
        end
    end
    self:Debug(
        "TimerManager internal scheduler: active=%d peak=%d onUpdate=%d idleOnUpdate=%d callbacks=%d pollCombat=%.3f pollIdle=%.3f",
        activeInternal,
        self._internalPerf.activeTimersPeak or 0,
        self._internalPerf.onUpdateCalls or 0,
        self._internalPerf.idleOnUpdateCalls or 0,
        self._internalPerf.callbacksProcessed or 0,
        INTERNAL_FRAME_POLL_INTERVAL_SEC,
        INTERNAL_FRAME_POLL_INTERVAL_IDLE_SEC
    )
end
