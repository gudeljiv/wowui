--- @module "NAG.TaskManager"
--- Manages periodic background tasks for NAG.
---
--- This module provides a centralized registration system for periodic background tasks.
--- Tasks can be registered with individual intervals and enable/disable functions.
--- Built-in tasks handle buff/debuff/cooldown checks, while public API allows
--- other modules to register their own periodic tasks.
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ============================ TASK MANAGER ARCHITECTURE ============================
-- This module implements a generic task scheduling system:
--
-- 1. SINGLE TICK TIMER: Configurable tick timer (default 250ms) checks all registered tasks
--    - Each task has its own individual execution interval
--    - Tasks are executed when their interval has elapsed since last execution
--    - Tick timer frequency is independent of task execution intervals
--
-- 2. TASK REGISTRATION SYSTEM:
--    - Built-in tasks: buff/debuff/cooldown checks (cannot be unregistered)
--    - Public API tasks: Any module can register periodic tasks
--    - Each task tracks: callback, interval, enabled state, last execution time
--
-- 3. SEPARATED RESPONSIBILITIES:
--    - TTD updates → TTDManager (own timer)
--    - Rotation updates → RotationManager (own timer, typically 100ms)
--    - Background maintenance → TaskManager (configurable tick timer for all tasks)

-- ~~~~~~~~~~ LOCALIZE ============================
local _, ns = ...
local GetTime = _G.GetTime
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access

--- @type OptionsFactory
--- @type TimerManager
local OptionsFactory, TimerManager
local DataManager = ns.DataManager

local L = ns.AceLocale:GetLocale("NAG", true)

-- Lua APIs (using WoW's optimized versions where available)
local format = string.format -- WoW's optimized version if available



-- ~~~~~~~~~~ DEFAULTS ============================

local UPDATE_INTERVALS = {
    BUFF_CHECK = 2.0,     -- Check buffs every 2 seconds
    DEBUFF_CHECK = 1.0,   -- Check debuffs every 1 second
    COOLDOWN_CHECK = 1.0, -- Check cooldowns every 1 second
}

--- @class TaskManager: CoreModule
local TaskManager = NAG:CreateModule("TaskManager", {
    global = {
        tickInterval = 0.25, -- How often to check all tasks (250ms default)
        intervals = UPDATE_INTERVALS,
    }
}, {
    optionsCategory = ns.MODULE_CATEGORIES.DEBUG,
    hidden = function() return not NAG:IsDevModeEnabled() end,
    messageHandlers = {
        NAG_EXPANSION_DATA_LOADED = true
    },

    defaultState = {
        tasks = {}, -- Task registry: [taskName] = { callback, interval, enabled, lastExecution, category }
    },
    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.SERVICES,
        ns.DEBUG_CATEGORIES.MANAGERS
    }
})
local module = TaskManager
ns.TaskManager = TaskManager

--- Check if DataManager has completed expansion data processing.
--- @return boolean True when expansion data is ready.
function TaskManager:IsDataReady()
    if not DataManager or not DataManager.IsDataReady then
        DataManager = NAG:GetModule("DataManager", true)
    end

    if not DataManager or not DataManager.IsDataReady then
        return false
    end

    return DataManager:IsDataReady()
end

--- Start task execution when the data-ready startup barrier is satisfied.
--- @param source string|nil Optional source label for diagnostics.
--- @return boolean started True when task ticking is active.
function TaskManager:InitializeDataDependentExecution(source)
    if self.tickTimerActive then
        return true
    end

    if not self:IsDataReady() then
        return false
    end

    self:StartTickTimer()
    if self.debug then
        self:Debug("TaskManager: Started data-dependent execution (%s)", tostring(source or "unknown"))
    end
    return true
end

-- ~~~~~~~~~~ ACE3 LIFECYCLE ============================

-- ============================ MODULE INITIALIZATION ============================
do
    function TaskManager:ModuleInitialize()
        -- ============================ MODULE ASSIGNMENT ============================
        -- Assign Ace3 modules directly (no metatable access)
        OptionsFactory = NAG:GetModule("OptionsFactory")
        TimerManager = NAG:GetModule("TimerManager")

        -- Initialize task registry
        if not self.state.tasks then
            self.state.tasks = {}
        end
    end

    function TaskManager:ModuleEnable()
        -- ============================ MODULE INITIALIZATION ============================
        -- Register built-in tasks
        self:RegisterBuiltInTasks()
        -- Start immediately in late-enable scenarios; otherwise wait for NAG_EXPANSION_DATA_LOADED.
        self:InitializeDataDependentExecution("ModuleEnable")
    end

    function TaskManager:ModuleDisable()
        -- Stop tick timer
        self:StopTickTimer()

        -- Clear all registered tasks (built-in tasks will be re-registered on next enable)
        self.state.tasks = {}
    end
end

-- ~~~~~~~~~~ TICK TIMER MANAGEMENT ============================

--- Start the tick timer that checks all registered tasks
function TaskManager:StartTickTimer()
    -- Cancel existing tick timer if it exists
    TimerManager:Cancel(TimerManager.Categories.CORE, "taskManagerTick")

    local tickInterval = self.db.global.tickInterval or 0.25

    -- Start tick timer
    TimerManager:Create(
        TimerManager.Categories.CORE,
        "taskManagerTick",
        function()
            self:Tick()
        end,
        tickInterval,
        true
    )

    self.tickTimerActive = true
end

--- Stop the tick timer
function TaskManager:StopTickTimer()
    TimerManager:Cancel(TimerManager.Categories.CORE, "taskManagerTick")
    self.tickTimerActive = false
end

--- Main tick function - checks all registered tasks and executes those that are due
function TaskManager:Tick()
    -- Skip if in edit mode
    if NAG:IsAnyEditMode() then
        return
    end

    -- Safety net for lifecycle ordering: skip task execution until data is ready.
    if not self:IsDataReady() then
        return
    end

    local currentTime = GetTime()

    -- Iterate through all registered tasks
    for taskName, task in pairs(self.state.tasks) do
        -- Check if task is enabled
        local isEnabled = task.enabled
        if type(isEnabled) == "function" then
            isEnabled = isEnabled()
        end

        if isEnabled then
            -- Check if enough time has passed since last execution
            local timeSinceLastExecution = currentTime - task.lastExecution
            if timeSinceLastExecution >= task.interval then
                -- Update last execution time immediately to prevent cascading
                task.lastExecution = currentTime

                -- Execute task callback
                local success, err = pcall(task.callback)
                if not success then
                    self:Error(format("TaskManager: Error executing task '%s': %s", taskName, tostring(err)))
                end
            end
        end
    end
end

--- Start task ticking after expansion data processing is complete.
function TaskManager:NAG_EXPANSION_DATA_LOADED()
    if not self:IsEnabled() then
        return
    end
    self:InitializeDataDependentExecution("NAG_EXPANSION_DATA_LOADED")
end

-- ~~~~~~~~~~ PUBLIC API ============================

--- Register a new periodic task
--- @param name string Unique name for the task
--- @param callback function The function to execute when task runs
--- @param interval number Execution interval in seconds
--- @param options table|nil Optional configuration
---   - enabled: function|boolean Whether task is enabled (default: true)
---   - category: string Category for organization (default: "custom")
--- @return boolean success True if task was registered successfully
function TaskManager:RegisterTask(name, callback, interval, options)
    if not name or type(name) ~= "string" or name == "" then
        self:Error("RegisterTask: name parameter is required and must be a non-empty string")
        return false
    end

    if not callback or type(callback) ~= "function" then
        self:Error(format("RegisterTask: callback parameter is required and must be a function (task: %s)", name))
        return false
    end

    if not interval or type(interval) ~= "number" or interval <= 0 then
        self:Error(format("RegisterTask: interval must be a positive number (task: %s)", name))
        return false
    end

    options = options or {}
    local enabled = options.enabled
    if enabled == nil then
        enabled = true
    end

    -- Check if task already exists
    if self.state.tasks[name] then
        self:Warn(format("RegisterTask: Task '%s' already exists, updating...", name))
    end

    -- Register the task
    self.state.tasks[name] = {
        callback = callback,
        interval = interval,
        enabled = enabled,
        lastExecution = 0, -- Will execute on first tick
        category = options.category or "custom"
    }

    self:Debug(format("TaskManager: Registered task '%s' with interval %.2fs", name, interval))
    return true
end

--- Unregister a task
--- @param name string Name of the task to unregister
--- @return boolean success True if task was unregistered
function TaskManager:UnregisterTask(name)
    if not name or type(name) ~= "string" then
        return false
    end

    if not self.state.tasks[name] then
        self:Warn(format("UnregisterTask: Task '%s' does not exist", name))
        return false
    end

    -- Prevent unregistering built-in tasks
    local task = self.state.tasks[name]
    if task.category == "builtin" then
        self:Warn(format("UnregisterTask: Cannot unregister built-in task '%s'", name))
        return false
    end

    self.state.tasks[name] = nil
    self:Debug(format("TaskManager: Unregistered task '%s'", name))
    return true
end

--- Enable a task
--- @param name string Name of the task to enable
--- @return boolean success True if task was enabled
function TaskManager:EnableTask(name)
    if not name or type(name) ~= "string" then
        return false
    end

    local task = self.state.tasks[name]
    if not task then
        self:Warn(format("EnableTask: Task '%s' does not exist", name))
        return false
    end

    task.enabled = true
    return true
end

--- Disable a task
--- @param name string Name of the task to disable
--- @return boolean success True if task was disabled
function TaskManager:DisableTask(name)
    if not name or type(name) ~= "string" then
        return false
    end

    local task = self.state.tasks[name]
    if not task then
        self:Warn(format("DisableTask: Task '%s' does not exist", name))
        return false
    end

    task.enabled = false
    return true
end

--- Update a task's execution interval
--- @param name string Name of the task
--- @param newInterval number New interval in seconds
--- @return boolean success True if interval was updated
function TaskManager:UpdateTaskInterval(name, newInterval)
    if not name or type(name) ~= "string" then
        return false
    end

    if not newInterval or type(newInterval) ~= "number" or newInterval <= 0 then
        self:Error(format("UpdateTaskInterval: newInterval must be a positive number (task: %s)", name))
        return false
    end

    local task = self.state.tasks[name]
    if not task then
        self:Warn(format("UpdateTaskInterval: Task '%s' does not exist", name))
        return false
    end

    task.interval = newInterval
    self:Debug(format("TaskManager: Updated task '%s' interval to %.2fs", name, newInterval))
    return true
end

--- Get task information
--- @param name string Name of the task
--- @return table|nil taskInfo Task information table or nil if task doesn't exist
function TaskManager:GetTaskInfo(name)
    if not name or type(name) ~= "string" then
        return nil
    end

    local task = self.state.tasks[name]
    if not task then
        return nil
    end

    -- Return a copy to prevent external modification
    local isEnabled = task.enabled
    if type(isEnabled) == "function" then
        isEnabled = isEnabled()
    end

    return {
        name = name,
        interval = task.interval,
        enabled = isEnabled,
        lastExecution = task.lastExecution,
        category = task.category
    }
end

-- ~~~~~~~~~~ BUILT-IN TASKS ============================

--- Register all built-in tasks
function TaskManager:RegisterBuiltInTasks()
    -- Buff check task
    self:RegisterTask("buffCheck", function()
        NAG:CheckRaidBuffs(NAG.db.char.buffSuggestionThreshold)
    end, self.db.global.intervals.BUFF_CHECK, {
        enabled = function() return NAG.db.char.enableBuffSuggestions end,
        category = "builtin"
    })

    -- Debuff check task
    self:RegisterTask("debuffCheck", function()
        NAG:CheckRaidDebuffs()
    end, self.db.global.intervals.DEBUFF_CHECK, {
        enabled = function() return NAG.db.char.enableDebuffSuggestions end,
        category = "builtin"
    })

    -- Cooldown check task
    -- NOTE: This enableAutocastOtherCooldowns setting only affects TaskManager's additional cooldown calls
    -- APL-included AutocastOtherCooldowns() calls always execute regardless of this setting
    -- Individual item enable toggles still control which specific items are used
    self:RegisterTask("cooldownCheck", function()
        local classModule = NAG:GetClassModule()
        if classModule and classModule.db.char.enableAutocastOtherCooldowns then
            NAG:AutocastOtherCooldowns()
        end
    end, self.db.global.intervals.COOLDOWN_CHECK, {
        enabled = function()
            local classModule = NAG:GetClassModule()
            return classModule and classModule.db.char.enableAutocastOtherCooldowns or false
        end,
        category = "builtin"
    })
end

-- ~~~~~~~~~~ OPTIONS UI ============================

-- ============================ OPTIONS MANAGEMENT ============================
do
    --- @return table The options table
    function TaskManager:GetOptions()
        return {
            type = "group",
            name = L["taskManager"] or "Task Manager",
            order = 100,
            args = {
                tickInterval = OptionsFactory:CreateRange(
                    L["tickInterval"] or "Tick Interval",
                    L["tickIntervalDesc"] or "How often TaskManager checks all registered tasks (default: 250ms)",
                    function() return self:GetSetting("global", "tickInterval") end,
                    function(_, value)
                        self:SetSetting("global", "tickInterval", value)
                        -- Restart tick timer with new interval
                        if self.tickTimerActive then
                            self:StartTickTimer()
                        end
                    end,
                    {
                        order = 0,
                        min = 0.1,
                        max = 1.0,
                        step = 0.05
                    }
                ),
                intervals = {
                    type = "group",
                    name = L["updateIntervals"] or "Update Intervals",
                    desc = L["updateIntervalsDesc"] or "Configure execution intervals for individual tasks",
                    inline = true,
                    order = 1,
                    args = {
                        BUFF_CHECK = OptionsFactory:CreateRange(
                            L["buffCheckInterval"] or "Buff Check Interval",
                            L["buffCheckIntervalDesc"] or "How often to check for missing raid buffs",
                            function() return self:GetSetting("global", "intervals.BUFF_CHECK") end,
                            function(_, value)
                                self:SetSetting("global", "intervals.BUFF_CHECK", value)
                                self:UpdateTaskInterval("buffCheck", value)
                            end,
                            {
                                order = 1,
                                min = 0.1,
                                max = 5.0,
                                step = 0.1
                            }
                        ),
                        DEBUFF_CHECK = OptionsFactory:CreateRange(
                            L["debuffCheckInterval"] or "Debuff Check Interval",
                            L["debuffCheckIntervalDesc"] or "How often to check for missing raid debuffs",
                            function() return self:GetSetting("global", "intervals.DEBUFF_CHECK") end,
                            function(_, value)
                                self:SetSetting("global", "intervals.DEBUFF_CHECK", value)
                                self:UpdateTaskInterval("debuffCheck", value)
                            end,
                            {
                                order = 2,
                                min = 0.1,
                                max = 5.0,
                                step = 0.1
                            }
                        ),
                        COOLDOWN_CHECK = OptionsFactory:CreateRange(
                            L["cooldownCheckInterval"] or "Cooldown Check Interval",
                            L["cooldownCheckIntervalDesc"] or "How often to check for available cooldowns",
                            function() return self:GetSetting("global", "intervals.COOLDOWN_CHECK") end,
                            function(_, value)
                                self:SetSetting("global", "intervals.COOLDOWN_CHECK", value)
                                self:UpdateTaskInterval("cooldownCheck", value)
                            end,
                            {
                                order = 3,
                                min = 0.1,
                                max = 5.0,
                                step = 0.1
                            }
                        ),
                    }
                }
            }
        }
    end
end
