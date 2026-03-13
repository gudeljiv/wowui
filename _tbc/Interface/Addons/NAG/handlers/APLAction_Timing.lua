--- @module "APLAction_Timing"
--- Timing-related APL action functions for the NAG addon
---
--- This module provides utility functions for timing-based actions, delays, and temporal conditions.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold
---
--- luacheck: ignore GetSpellInfo
---

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ HEADER LOCALS ============================

-- Lua APIs (WoW optimized where available)
local GetTime = _G.GetTime


local format = string.format



-- ============================ MODULE CACHING (PERFORMANCE) ============================
-- Cache frequently accessed modules to avoid GetModule overhead in hot paths
local TimerManager = ns.TimerManager

local sort = table.sort
local concat = table.concat
local type = type
local tostring = tostring

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~


-- ============================ TIMING ACTIONS ============================

--- Schedules an action after a specified delay.
--- @param time number Delay in seconds.
--- @param action function The function to execute after the delay.
--- @return boolean True if the action was scheduled successfully.
--- @usage local success = NAG:Schedule(5, function() print("Action performed") end)
function NAG:Schedule(time, action)
    if not time or not action then
        self:Error("Schedule: No time or action provided")
        return false
    end
    -- Input validation
    if type(time) ~= "number" or type(action) ~= "function" then
        self:Error("Schedule: Invalid parameters - time: %s, action: %s", time, action)
        return false
    end

    -- Create unique timer name based on time and current timestamp
    local timerName = "scheduled_" .. tostring(time) .. "_" .. tostring(GetTime())

    -- Create timer using TimerManager
    TimerManager:Create(
        TimerManager.Categories.COMBAT,
        timerName,
        function()
            --self:Debug("Schedule: Executing scheduled action")
            local success, err = pcall(action)
            if not success then
                self:Error("Schedule: Error in scheduled action: %s", tostring(err))
            end
        end,
        time,
        false -- Not repeating
    )

    --self:Debug("Schedule: Action scheduled to run in " .. tostring(time) .. " seconds")
    return true
end

--- Waits until a specified condition is met. Returns true while waiting, false when the condition is met.
--- @param func function The function to evaluate the condition.
--- @return boolean True if the wait is still in progress, false otherwise.
--- @usage local stillWaiting = NAG:WaitUntil(function() return UnitExists("target") end)
function NAG:WaitUntil(func)
    if not self.waitInProgress then
        self.waitInProgress = true -- Set waitInProgress flag
    end
    if func() then
        self.waitInProgress = false -- Reset waitInProgress flag
        return false
    end
    return true
end

--- Waits for a specified duration in seconds. Returns true while waiting, false when complete.
--- @param duration number The duration to wait in seconds.
--- @return boolean True if the wait is still in progress, false if it has completed.
--- @usage local stillWaiting = NAG:Wait(5)
--- @see NAG:WaitUntil
function NAG:Wait(duration)
    if not self.waitInProgress then
        self.waitUntilTime = GetTime() + duration
        self.waitInProgress = true -- Set waitInProgress flag
        return true
    end
    if GetTime() >= self.waitUntilTime then
        self.waitUntilTime = nil
        self.waitInProgress = false -- Reset waitInProgress flag
        self:SpellCastSucceeded(0)  -- Simulate a successful "spell cast" with ID 0 for the wait completion
        return false
    end
    return true
end
