--- @module "NAG.StateMachine"
--- Shared state machine utilities for class and feature modules.
---
--- Provides:
--- - Event-driven finite state machine instances (`Create`)
--- - Timeline predictor instances for time-stepped state simulations (`CreateTimelinePredictor`)
---
--- License: CC BY-NC 4.0
--- Authors: Rakizi, Fonsas

-- ============================ LOCALIZE ============================
local _, ns = ...

--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ CONSTANTS ============================
local DEFAULT_MAX_TIMELINE_STEPS = 128

-- ============================ MODULE TABLE ============================
--- @class StateMachine
local StateMachine = {}

-- ============================ INTERNAL HELPERS ============================
--- @param value any
--- @return boolean
local function IsTable(value)
    return type(value) == "table"
end

--- @param transition table
--- @param index number
local function ValidateTransition(transition, index)
    if not IsTable(transition) then
        error(string.format("StateMachine.Create: transition[%d] must be a table", index))
    end

    local fromState = transition.from
    if fromState == nil then
        error(string.format("StateMachine.Create: transition[%d].from is required", index))
    end

    local eventName = transition.event
    if type(eventName) ~= "string" or eventName == "" then
        error(string.format("StateMachine.Create: transition[%d].event must be a non-empty string", index))
    end

    if transition.to == nil then
        error(string.format("StateMachine.Create: transition[%d].to is required", index))
    end

    if transition.action ~= nil and type(transition.action) ~= "function" then
        error(string.format("StateMachine.Create: transition[%d].action must be a function when provided", index))
    end
end

--- @param map table
--- @param fromState any
--- @param eventName string
--- @param toState any
--- @param action function|nil
local function RegisterTransition(map, fromState, eventName, toState, action)
    if map[fromState] == nil then
        map[fromState] = {}
    end
    map[fromState][eventName] = {
        to = toState,
        action = action,
    }
end

-- ============================ EVENT FSM ============================
local EventMachineMethods = {}
EventMachineMethods.__index = EventMachineMethods

--- Returns the machine's current state.
--- @return any
function EventMachineMethods:getState()
    return self.currentState
end

--- Returns the machine's mutable context table.
--- @return table
function EventMachineMethods:getContext()
    return self.context
end

--- Forces the machine state (intended for testing/debug).
--- @param nextState any
function EventMachineMethods:setState(nextState)
    self.currentState = nextState
end

--- Returns true when the current state can handle the given event.
--- @param eventName string
--- @return boolean
function EventMachineMethods:canFire(eventName)
    local byState = self.transitionMap[self.currentState] or self.transitionMap["*"]
    if not byState then
        return false
    end
    return byState[eventName] ~= nil
end

--- Executes one event transition.
--- @param eventName string
--- @param payload any|nil Optional payload passed to transition action
--- @return boolean transitioned
--- @return any toState
--- @return table|nil transition
function EventMachineMethods:fire(eventName, payload)
    local byState = self.transitionMap[self.currentState] or self.transitionMap["*"]
    local transition = byState and byState[eventName] or nil
    if not transition then
        return false, self.currentState, nil
    end

    local fromState = self.currentState
    local toState = transition.to
    if transition.action then
        transition.action(self.context, fromState, eventName, toState, payload, self)
    end
    self.currentState = toState
    return true, toState, transition
end

--- Creates an event-driven finite state machine instance.
--- @param config table
--- @return table machine
function StateMachine.Create(config)
    if not IsTable(config) then
        error("StateMachine.Create: config table is required")
    end
    if config.initial == nil then
        error("StateMachine.Create: config.initial is required")
    end
    if not IsTable(config.transitions) then
        error("StateMachine.Create: config.transitions table is required")
    end

    local transitionMap = {}
    for i = 1, #config.transitions do
        local transition = config.transitions[i]
        ValidateTransition(transition, i)

        local fromState = transition.from
        local eventName = transition.event
        local toState = transition.to
        local action = transition.action

        if IsTable(fromState) then
            for j = 1, #fromState do
                RegisterTransition(transitionMap, fromState[j], eventName, toState, action)
            end
        else
            RegisterTransition(transitionMap, fromState, eventName, toState, action)
        end
    end

    local machine = {
        transitionMap = transitionMap,
        currentState = config.initial,
        context = IsTable(config.context) and config.context or {},
    }
    return setmetatable(machine, EventMachineMethods)
end

-- ============================ TIMELINE PREDICTOR ============================
local TimelinePredictorMethods = {}
TimelinePredictorMethods.__index = TimelinePredictorMethods

--- Runs timeline prediction by repeatedly invoking the configured step function.
--- @param context table|nil
--- @param input table|nil
--- @return table result
function TimelinePredictorMethods:predict(context, input)
    local runContext = IsTable(context) and context or {}
    if self.cloneContext then
        runContext = self.cloneContext(runContext)
        if not IsTable(runContext) then
            error("StateMachine.CreateTimelinePredictor: cloneContext must return a table")
        end
    end

    local states = {}
    local done = false
    local maxStepsReached = false
    local stepCount = 0

    for stepIndex = 1, self.maxSteps do
        if self.shouldContinue and not self.shouldContinue(runContext, input, stepIndex, states) then
            done = true
            break
        end

        local stepResult = self.step(runContext, input, {
            stepIndex = stepIndex,
            maxSteps = self.maxSteps,
        })
        if not IsTable(stepResult) then
            error("StateMachine.CreateTimelinePredictor: step must return a table")
        end

        local nextContext = IsTable(stepResult.context) and stepResult.context or runContext
        local stateRecord = stepResult.state
        if stateRecord ~= nil then
            if not IsTable(stateRecord) then
                error("StateMachine.CreateTimelinePredictor: step state must be a table when provided")
            end
            states[#states + 1] = stateRecord
        end

        runContext = nextContext
        stepCount = stepIndex
        if stepResult.done == true then
            done = true
            break
        end
    end

    if not done and stepCount >= self.maxSteps then
        maxStepsReached = true
    end

    return {
        states = states,
        context = runContext,
        done = done,
        maxStepsReached = maxStepsReached,
        stepCount = stepCount,
    }
end

--- Creates a timeline predictor driven by a step function.
--- @param config table
--- @return table predictor
function StateMachine.CreateTimelinePredictor(config)
    if not IsTable(config) then
        error("StateMachine.CreateTimelinePredictor: config table is required")
    end
    if type(config.step) ~= "function" then
        error("StateMachine.CreateTimelinePredictor: config.step function is required")
    end
    if config.shouldContinue ~= nil and type(config.shouldContinue) ~= "function" then
        error("StateMachine.CreateTimelinePredictor: config.shouldContinue must be a function when provided")
    end
    if config.cloneContext ~= nil and type(config.cloneContext) ~= "function" then
        error("StateMachine.CreateTimelinePredictor: config.cloneContext must be a function when provided")
    end

    local maxSteps = tonumber(config.maxSteps or DEFAULT_MAX_TIMELINE_STEPS) or DEFAULT_MAX_TIMELINE_STEPS
    if maxSteps < 1 then
        maxSteps = 1
    end

    local predictor = {
        step = config.step,
        shouldContinue = config.shouldContinue,
        cloneContext = config.cloneContext,
        maxSteps = maxSteps,
    }
    return setmetatable(predictor, TimelinePredictorMethods)
end

-- ============================ EXPORTS ============================
ns.StateMachine = StateMachine
if NAG then
    NAG.StateMachine = StateMachine
end

