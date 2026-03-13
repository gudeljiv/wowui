--- @module "NAG.GarbageCollectorManager"
--- Opportunistic GC sweeps to reduce memory spikes from allocation churn.
---
--- This module intentionally changes runtime behavior by calling Lua's GC:
--- collectgarbage("collect")
---
--- Triggers:
--- - Leaving combat (PLAYER_REGEN_ENABLED)
--- - Out of combat + target changed (PLAYER_TARGET_CHANGED)
--- - Out of combat periodic sweep every N seconds (default 8s); target change resets the timer
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

-- ============================ LOCALIZE ============================

local _, ns = ...

-- ============================ ADDON ACCESS ============================

--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ MODULE ACCESS ============================

local TimerManager = ns.TimerManager

-- ============================ LUA API LOCALIZATION ============================

local collectgarbage = collectgarbage

-- ============================ WOW API LOCALIZATION ============================

local UnitAffectingCombat = _G.UnitAffectingCombat

-- ============================ CONSTANTS ============================

local TIMER_CATEGORY = TimerManager and TimerManager.Categories and TimerManager.Categories.CORE or "core"
local TIMER_NAME = "GarbageCollectorManager:oocSweep"

-- ============================ MODULE DEFAULTS ============================

local defaults = {
    global = {
        -- NOTE: This is a FEATURE module but enabled by default on purpose per request.
        -- It can cause small hitches depending on allocation volume when GC runs.
        enabled = true,
        intervalSeconds = 8,
    }
}

-- ============================ MODULE CREATION ============================

--- @class GarbageCollectorManager: CoreModule
local GarbageCollectorManager = NAG:CreateModule("GarbageCollectorManager", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,
    optionsCategory = ns.MODULE_CATEGORIES.FEATURE,

    eventHandlers = {
        PLAYER_REGEN_DISABLED = true,
        PLAYER_REGEN_ENABLED = true,
        PLAYER_TARGET_CHANGED = true,
    },

    defaultState = {
        inCombat = false,
    },

    debugCategories = {
        ns.DEBUG_CATEGORIES.FEATURES,
        ns.DEBUG_CATEGORIES.MANAGERS,
    }
})

ns.GarbageCollectorManager = GarbageCollectorManager

-- ============================ INTERNALS ============================

--- Run a full Lua GC collection pass if safe
--- @param reason string
function GarbageCollectorManager:_Collect(reason)
    if self.state.inCombat then
        return
    end

    if UnitAffectingCombat and UnitAffectingCombat("player") then
        -- Safety: avoid GC in combat even if our combat state tracking missed an edge.
        return
    end

    collectgarbage("collect")
end

function GarbageCollectorManager:_CancelOOC()
    if TimerManager then
        TimerManager:Cancel(TIMER_CATEGORY, TIMER_NAME)
    end
end

function GarbageCollectorManager:_ScheduleOOC()
    if self.state.inCombat then
        return
    end

    if not TimerManager then
        return
    end

    local interval = (self.db and self.db.global and self.db.global.intervalSeconds) or 8
    if type(interval) ~= "number" or interval <= 0 then
        interval = 8
    end

    -- Reset the one-shot timer so "target changed" pushes the next periodic sweep out.
    TimerManager:Cancel(TIMER_CATEGORY, TIMER_NAME)

    local module = self
    TimerManager:Create(TIMER_CATEGORY, TIMER_NAME, function()
        if module.state.inCombat then
            return
        end

        module:_Collect("oocPeriodic")
        module:_ScheduleOOC()
    end, interval, false)
end

-- ============================ LIFECYCLE ============================

function GarbageCollectorManager:ModuleInitialize()
    -- Intentionally minimal (no event registration, no timers).
end

function GarbageCollectorManager:ModuleEnable()
    self.state.inCombat = UnitAffectingCombat and UnitAffectingCombat("player") or false

    if not self.state.inCombat then
        self:_ScheduleOOC()
    end
end

function GarbageCollectorManager:ModuleDisable()
    self:_CancelOOC()
end

-- ============================ EVENT HANDLERS ============================

function GarbageCollectorManager:PLAYER_REGEN_DISABLED()
    self.state.inCombat = true
    self:_CancelOOC()
end

function GarbageCollectorManager:PLAYER_REGEN_ENABLED()
    self.state.inCombat = false
    self:_Collect("leaveCombat")
    self:_ScheduleOOC()
end

function GarbageCollectorManager:PLAYER_TARGET_CHANGED()
    if self.state.inCombat then
        return
    end

    -- Only when out of combat
    self:_Collect("targetChanged")
    self:_ScheduleOOC()
end


