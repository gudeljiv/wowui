--- @module "NAG.EventManager"
--- Centralized event management system for NAG addon
---
--- Provides true centralized handling of all events with intelligent batching
--- and performance optimization. Eliminates duplicate event registrations
--- and provides unified event distribution to all modules.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

-- ============================ LOCALIZE ============================
local _, ns = ...
local GetTime = _G.GetTime
local UnitName = _G.UnitName
local UnitGUID = _G.UnitGUID
local UnitAffectingCombat = _G.UnitAffectingCombat
local CombatLogGetCurrentEventInfo = _G.CombatLogGetCurrentEventInfo
local L = ns.AceLocale:GetLocale("NAG")
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local TableUtils = ns.TableUtils
local TablePool = ns.TablePool

-- Lua APIs (using WoW's optimized versions where available)
local format = string.format
local unpack = unpack
local pairs = pairs
local ipairs = ipairs
local type = type
local tostring = tostring
local next = next
local select = select
local tinsert = tinsert
local tremove = tremove
local wipe = wipe

-- Standard Lua functions
local sort = table.sort
local concat = table.concat

-- String functions
local strupper = string.upper

-- Enhanced error handling
local pcall = ns.pcall

-- ============================ TBC/VANILLA COMPATIBILITY ============================
-- Events that don't exist in TBC/Vanilla and should be skipped during discovery.
-- Note: LEARNED_SPELL_IN_TAB is Retail-only; registering it on TBC causes errors.
local TBC_UNAVAILABLE_EVENTS = {
    LEARNED_SPELL_IN_TAB = true,
    PLAYER_SPECIALIZATION_CHANGED = true,
    GLYPH_ADDED = true,
    GLYPH_REMOVED = true,
    GLYPH_UPDATED = true,
}

-- ============================ CONTENT ============================

--- @class EventManager : CoreModule
local EventManager = NAG:CreateModule("EventManager", {
    global = {
        -- EventManager settings
        eventManagerShowStats = false,
        eventManagerEnableMonitoring = false,
    }
}, {
    debugCategories = { ns.DEBUG_CATEGORIES.SERVICES },
    optionsCategory = ns.MODULE_CATEGORIES.DEBUG,
    eventHandlers = {
        PLAYER_ENTERING_WORLD = "OnPlayerEnteringWorld",
    },
    cleuHandlers = {
        -- Used to apply local parry-haste swing overrides (no lib edits).
        SWING_MISSED = "HandleCLEUParryHaste",
    },
    messageHandlers = {

    },
})
local module = EventManager
ns.EventManager = EventManager

-- ============================ INTERNAL STATE ============================

-- Event registration tracking
EventManager.registeredEvents = {} -- Events registered with WoW API
EventManager.moduleEventHandlers = {}    -- Module handlers for each event (internal tracking)
EventManager.eventStats = {}       -- Performance statistics
EventManager.cleuStats = {}        -- CLEU sub-event statistics
EventManager.moduleCLEUHandlers = {} -- CLEU handlers keyed by subEvent
EventManager.cleuWhitelist = {}     -- Sub-event whitelist for fast CLEU filtering
EventManager.moduleCLEURegistrations = {} -- Track module -> subEvents for clean unregistration
EventManager.externalCLEUHandlers = {} -- External CLEU callbacks keyed by subEvent
EventManager.externalCLEUWhitelist = {} -- External sub-event whitelist for fast CLEU filtering
EventManager.externalCLEURegistrations = {} -- Track ownerKey -> subEvents for clean unregistration
EventManager.cleuDispatchCache = {} -- Precomputed merged CLEU dispatch handlers
EventManager.diagnostics = {
    registrationFailures = 0,
    duplicateEventRegistrations = 0,
    duplicateCLEURegistrations = 0,
    duplicateExternalCLEURegistrations = 0,
    dispatchEventErrors = 0,
    dispatchCLEUErrors = 0,
    dispatchExternalCLEUErrors = 0,
    missingHandlerModules = 0,
    queuedEventsTotal = 0,
    queuedEventsPeak = 0,
    queueFlushCount = 0,
    queuedEventsFlushed = 0,
    startupQueueByEventPeak = {},
    batchProcessCount = 0,
    batchEventsProcessed = 0,
    batchByEvent = {},
    startupPrunedEvents = 0,
    idleEventsTotal = 0,
    idleEventsByEvent = {},
    idleMessagesSent = 0,
    idleMessagesReceived = 0,
    idleMessageByName = {},
}

-- Event batching system
EventManager.batchedEvents = {}
EventManager.batchTimers = {}

-- Performance monitoring
EventManager.performanceStats = {
    totalEvents = 0,
    totalHandlers = 0,
    startTime = GetTime()
}

-- Startup phase tracking
ns.StartupPhase = {
    LOADING = 1,           -- Addon just loaded, modules initializing
    DATABASE_READY = 2,    -- AceDB initialized (NAG_DATABASE_LOADED)
    DATA_READY = 3,        -- Expansion data loaded (NAG_EXPANSION_DATA_LOADED)
    GAME_READY = 4,        -- Player in world, WoW APIs stable
    COMPLETE = 5           -- All systems ready, normal operation
}

EventManager.currentPhase = ns.StartupPhase.LOADING
EventManager.queuedEvents = {}  -- Events queued during startup
EventManager.gameReadyTimer = nil  -- Timer for GAME_READY transition
EventManager.discoveredEvents = {}  -- Auto-discovered events from all modules' eventHandlers

-- ============================ INITIALIZATION ============================

--- Called when the module is initialized
function EventManager:ModuleInitialize()
    self.initialized = true

    -- Track failed event registrations for debugging
    self.failedEventRegistrations = {}

    -- Register for phase transition messages EARLY (before other modules enable)
    -- This ensures we catch the messages when they're sent
    self:RegisterMessage("NAG_DATABASE_LOADED", function()
        self:AdvancePhase(ns.StartupPhase.DATABASE_READY, "Database initialized")
    end)

    -- Authoritative startup barrier for all data-backed runtime systems.
    self:RegisterMessage("NAG_EXPANSION_DATA_LOADED", function()
        -- Record expansion data loaded time once per session (used by startup grace windows)
        ns.expansionDataLoadedAt = ns.expansionDataLoadedAt or (GetTime and GetTime() or 0)
        self:AdvancePhase(ns.StartupPhase.DATA_READY, "Expansion data loaded")

        -- Check if player is already in world (PLAYER_ENTERING_WORLD may have fired earlier)
        local playerName = UnitName("player")
        if playerName and playerName ~= "Unknown" and playerName ~= "" then
            self:Info("Player already in world when DATA_READY reached, advancing to GAME_READY")
            self:AdvancePhase(ns.StartupPhase.GAME_READY, "Player in world (already entered)")

            -- Schedule COMPLETE phase after 2 second stability delay
            if self.gameReadyTimer then
                self:CancelTimer(self.gameReadyTimer)
            end
            self.gameReadyTimer = self:ScheduleTimer(function()
                self:AdvancePhase(ns.StartupPhase.COMPLETE, "Game APIs stable")
                self.gameReadyTimer = nil
            end, 2.0)
        end
    end)

    -- Discover all events that modules want to handle
    local discoveredCount = self:DiscoverModuleEvents()

    if discoveredCount == 0 then
        self:Warn("No events discovered during ModuleInitialize - will retry in ModuleEnable")
        self.needsRediscovery = true
    else
        self:Info("EventManager initialized - monitoring %d events from %d modules",
            discoveredCount, TableUtils.Size(NAG.modules or {}))
    end

    -- Register for all discovered events EARLY to catch them even if they fire
    -- before modules register for them (e.g., PLAYER_LOGIN fires when Ace3 enables modules)
    for eventName, _ in pairs(self.discoveredEvents) do
        if not self.registeredEvents[eventName] then
            local success, err = self:SafeRegisterEvent(eventName, "OnEvent")
            if success then
                self.registeredEvents[eventName] = true
                -- Initialize empty handler list so OnEvent can queue events
                if not self.moduleEventHandlers[eventName] then
                    self.moduleEventHandlers[eventName] = {}
                end
                if self.debug then self:Debug("Early registered " .. eventName .. " for startup queueing") end
            else
                -- Event doesn't exist in this version, skip it
                if self.debug then self:Debug("Skipping " .. eventName .. " (not available in current version)") end
            end
        end
    end
end

-- ============================ CLEU HELPERS ============================

--- Applies parry-haste to the player's current swing deadline on defensive parries.
--- Mirrors SwedgeTimer behavior: `SWING_MISSED` where player is the destination and missType == "PARRY".
--- Important: this does NOT modify base weapon speed; it only shortens the active swing's endAt.
--- @param timestamp number
--- @param subEvent string
--- @param hideCaster boolean
--- @param sourceGUID string|nil
--- @param sourceName string|nil
--- @param sourceFlags number|nil
--- @param sourceRaidFlags number|nil
--- @param destGUID string|nil
--- @param destName string|nil
--- @param destFlags number|nil
--- @param destRaidFlags number|nil
--- @param missType string|nil
function EventManager:HandleCLEUParryHaste(
    timestamp,
    subEvent,
    hideCaster,
    sourceGUID,
    sourceName,
    sourceFlags,
    sourceRaidFlags,
    destGUID,
    destName,
    destFlags,
    destRaidFlags,
    missType
)
    if subEvent ~= "SWING_MISSED" then
        return
    end

    if missType ~= "PARRY" then
        return
    end

    local playerGUID = UnitGUID and UnitGUID("player") or nil
    if not playerGUID or destGUID ~= playerGUID then
        return
    end

    if NAG and NAG.ApplyParryHasteToAutoSwing then
        local applied, newRemaining, oldRemaining = NAG:ApplyParryHasteToAutoSwing()
        if applied and NAG.IsDevModeEnabled and NAG:IsDevModeEnabled() then
            print(string.format(
                "[PARRY_HASTE] applied=1 old=%.3f new=%.3f",
                oldRemaining or 0,
                newRemaining or 0
            ))
        end
    end
end

--- Discovers all events that modules want to handle by scanning their eventHandlers tables
--- @return number Count of unique events discovered
function EventManager:DiscoverModuleEvents()
    self.discoveredEvents = {}

    if not NAG or not NAG.modules then
        if self.debug then self:Debug("NAG.modules not available for event discovery") end
        return 0
    end

    -- Check if we're on TBC/Vanilla to filter unavailable events
    local Version = ns.Version
    local isTBCOrVanilla = Version and (Version:IsTBC() or Version:IsVanilla())

    local moduleCount = 0
    for moduleName, module in pairs(NAG.modules) do
        if module and module.eventHandlers and type(module.eventHandlers) == "table" then
            moduleCount = moduleCount + 1
            for event, _ in pairs(module.eventHandlers) do
                -- Skip events not available in TBC/Vanilla
                if isTBCOrVanilla and TBC_UNAVAILABLE_EVENTS[event] then
                    if self.debug then self:Debug("Filtering out event " .. event .. " (not available in TBC/Vanilla)") end
                else
                    self.discoveredEvents[event] = true
                end
            end
        end
    end

    local eventCount = TableUtils.Size(self.discoveredEvents)
    if self.debug then
        self:Debug("Discovered %d unique events from %d modules", eventCount, moduleCount)
    end

    return eventCount
end

--- Called when the module is enabled
function EventManager:ModuleEnable()
    -- Fallback: Re-discover events if initial discovery found none (load order issue)
    if self.needsRediscovery or TableUtils.Size(self.discoveredEvents) == 0 then
        local rediscoveredCount = self:DiscoverModuleEvents()
        if rediscoveredCount > 0 then
            self:Info("Fallback discovery found %d events (modules now loaded)", rediscoveredCount)
            -- Register any newly discovered events that weren't registered in ModuleInitialize
            for eventName, _ in pairs(self.discoveredEvents) do
                if not self.registeredEvents[eventName] then
                    local success, err = self:SafeRegisterEvent(eventName, "OnEvent")
                    if success then
                        self.registeredEvents[eventName] = true
                        -- Initialize empty handler list so OnEvent can queue events
                        if not self.moduleEventHandlers[eventName] then
                            self.moduleEventHandlers[eventName] = {}
                        end
                        if self.debug then self:Debug("Fallback registered " .. eventName .. " for startup queueing") end
                    else
                        -- Event doesn't exist in this version, skip it
                        if self.debug then self:Debug("Skipping " .. eventName .. " (not available in current version)") end
                    end
                end
            end
            self.needsRediscovery = nil
        end
    end

    -- Handle late initialization - if we enabled after messages were sent
    -- Check if database is already loaded (NAG.db exists)
    if NAG.db then
        self:Info("Late init: Database already loaded, advancing to DATABASE_READY")
        self:AdvancePhase(ns.StartupPhase.DATABASE_READY, "Database initialized (late)")
    end

    -- Check if DataManager has already loaded expansion data
    local DataManager = NAG:GetModule("DataManager")
    if DataManager and DataManager:IsDataReady() then
        self:Info("Late init: Expansion data already loaded, advancing to DATA_READY")
        self:AdvancePhase(ns.StartupPhase.DATA_READY, "Expansion data loaded (late)")

        -- If we're at DATA_READY after late init, check if player is already in world
        -- (PLAYER_ENTERING_WORLD may have fired before we registered for it)
        if self.currentPhase >= ns.StartupPhase.DATA_READY then
            local playerName = UnitName("player")
            if playerName and playerName ~= "Unknown" and playerName ~= "" then
                self:Info("Late init: Player already in world, advancing to GAME_READY")
                self:AdvancePhase(ns.StartupPhase.GAME_READY, "Player in world (late)")

                -- Schedule COMPLETE phase after 2 second stability delay
                self.gameReadyTimer = self:ScheduleTimer(function()
                    self:AdvancePhase(ns.StartupPhase.COMPLETE, "Game APIs stable (late)")
                    self.gameReadyTimer = nil
                end, 2.0)
            end
        end
    end

    -- Start performance monitoring if enabled
    if self.db.global.eventManagerEnableMonitoring then
        self:StartPerformanceMonitoring()
    end

    -- Ensure all tables are properly initialized
    if not self.moduleEventHandlers then
        self.moduleEventHandlers = {}
        if self.debug then self:Debug("Initialized moduleEventHandlers table") end
    end

    if not self.eventStats then
        self.eventStats = {}
        if self.debug then self:Debug("Initialized eventStats table") end
    end

    if not self.registeredEvents then
        self.registeredEvents = {}
        if self.debug then self:Debug("Initialized registeredEvents table") end
    end
end

--- Called when the module is disabled
function EventManager:ModuleDisable()
    -- Stop performance monitoring
    self:StopPerformanceMonitoring()

    -- Clear all batches
    self:ClearAllBatches()
end

-- ============================ CENTRALIZED EVENT REGISTRATION ============================

--- Normalizes and validates a WoW event key.
--- @param eventName any
--- @return string|nil
function EventManager:NormalizeEventKey(eventName)
    if type(eventName) ~= "string" or eventName == "" then
        return nil
    end
    return strupper(eventName)
end

--- Safely registers an event, catching errors for events that don't exist in current version
--- @param eventName string The event name to register
--- @param handler? string|function The handler method name or function
--- @return boolean success Whether registration succeeded
--- @return string|nil error Error message if registration failed
function EventManager:SafeRegisterEvent(eventName, handler)
    local success, err = pcall(function()
        self:RegisterEvent(eventName, handler)
    end)

    if not success then
        self.diagnostics.registrationFailures = (self.diagnostics.registrationFailures or 0) + 1
        -- Track failed registrations
        if not self.failedEventRegistrations then
            self.failedEventRegistrations = {}
        end
        self.failedEventRegistrations[eventName] = {
            error = err,
            timestamp = GetTime(),
            handler = handler
        }

        self:Warn("Failed to register event '%s' (not available in current version): %s",
            eventName, tostring(err))
        return false, err
    end

    return true, nil
end

--- Safely unregisters an event, catching errors for events that don't exist in current version
--- @param eventName string The event name to unregister
--- @param handler? string|function The handler method name or function
--- @return boolean success Whether unregistration succeeded
--- @return string|nil error Error message if unregistration failed
function EventManager:SafeUnregisterEvent(eventName, handler)
    local success, err = pcall(function()
        self:UnregisterEvent(eventName, handler)
    end)

    if not success then
        self.diagnostics.registrationFailures = (self.diagnostics.registrationFailures or 0) + 1
        -- Track failed unregistrations (for debugging, but less critical than registrations)
        if not self.failedEventRegistrations then
            self.failedEventRegistrations = {}
        end
        -- Store as unregistration failure (can coexist with registration failure)
        if not self.failedEventRegistrations[eventName] then
            self.failedEventRegistrations[eventName] = {}
        end
        self.failedEventRegistrations[eventName].unregisterError = err
        self.failedEventRegistrations[eventName].unregisterTimestamp = GetTime()
        self.failedEventRegistrations[eventName].unregisterHandler = handler

        if self.debug then
            self:Debug("Failed to unregister event '%s' (may not exist in current version): %s",
                eventName, tostring(err))
        end
        return false, err
    end

    return true, nil
end

--- Registers a module for a specific event (centralized registration)
--- @param moduleName string The module name
--- @param eventName string The event name
--- @param handler? string|function The handler method name or function
function EventManager:RegisterModuleForEvent(moduleName, eventName, handler)
    if type(moduleName) ~= "string" or moduleName == "" then
        self:Warn("Invalid parameters for RegisterModuleForEvent")
        return
    end

    local normalizedEventName = self:NormalizeEventKey(eventName)
    if not normalizedEventName then
        self:Warn("Invalid event key for module '%s': %s", tostring(moduleName), tostring(eventName))
        return
    end

    local resolvedHandler = handler or normalizedEventName

    -- Skip events that don't exist in TBC/Vanilla
    local Version = ns.Version
    if Version and (Version:IsTBC() or Version:IsVanilla()) then
        if TBC_UNAVAILABLE_EVENTS[normalizedEventName] then
            if self.debug then self:Debug("Skipping event " .. normalizedEventName .. " (not available in TBC/Vanilla)") end
            return
        end
    end

    -- Initialize event handlers table if needed
    if not self.moduleEventHandlers[normalizedEventName] then
        self.moduleEventHandlers[normalizedEventName] = {}
    end

    -- Check for duplicate registration
    for _, existingHandler in ipairs(self.moduleEventHandlers[normalizedEventName]) do
        if existingHandler.moduleName == moduleName and existingHandler.handler == resolvedHandler then
            self.diagnostics.duplicateEventRegistrations = (self.diagnostics.duplicateEventRegistrations or 0) + 1
            if self.debug then self:Debug("Module " .. moduleName .. " already registered for " .. normalizedEventName) end
            return
        end
    end

    -- Add handler to list
    tinsert(self.moduleEventHandlers[normalizedEventName], {
        moduleName = moduleName,
        handler = resolvedHandler,
        moduleRef = NAG:GetModule(moduleName, true),
        registered = GetTime()
    })

    -- Register event with WoW API if not already registered
    if not self.registeredEvents[normalizedEventName] then
        local success, err = self:SafeRegisterEvent(normalizedEventName, "OnEvent")
        if success then
            self.registeredEvents[normalizedEventName] = true
            if self.debug then self:Debug("Registered " .. normalizedEventName .. " with WoW API") end
        else
            -- Event doesn't exist in this version, but we still track the module's interest
            -- so if the event becomes available later, we can register it
            if self.debug then self:Debug("Event " .. normalizedEventName .. " not available, but tracking module interest") end
        end
    end

    -- Initialize stats
    if not self.eventStats[normalizedEventName] then
        self.eventStats[normalizedEventName] = {
            sent = 0,
            handlers = 0,
            lastSent = 0
        }
    end
    self.eventStats[normalizedEventName].handlers = #self.moduleEventHandlers[normalizedEventName]

    if self.debug then self:Debug("Registered module " .. moduleName .. " for event " .. normalizedEventName) end
end

--- Unregisters a module from a specific event
--- @param moduleName string The module name
--- @param eventName string The event name
function EventManager:UnregisterModuleFromEvent(moduleName, eventName)
    local normalizedEventName = self:NormalizeEventKey(eventName)
    if not normalizedEventName then
        return
    end

    if not self.moduleEventHandlers[normalizedEventName] then
        return
    end

    -- Remove handler from list
    for i = #self.moduleEventHandlers[normalizedEventName], 1, -1 do
        local handler = self.moduleEventHandlers[normalizedEventName][i]
        if handler.moduleName == moduleName then
            tremove(self.moduleEventHandlers[normalizedEventName], i)
            if self.debug then self:Debug("Unregistered module " .. moduleName .. " from event " .. normalizedEventName) end
            break
        end
    end

    -- Unregister from WoW API if no more handlers
    -- Don't unregister discovered events during startup (they're early-registered for queueing)
    if #self.moduleEventHandlers[normalizedEventName] == 0 then
        local isDiscovered = self.discoveredEvents[normalizedEventName]
        local isDuringStartup = self.currentPhase < ns.StartupPhase.COMPLETE

        if not isDiscovered or not isDuringStartup then
            local success, err = self:SafeUnregisterEvent(normalizedEventName, "OnEvent")
            if success then
                self.registeredEvents[normalizedEventName] = nil
                self.moduleEventHandlers[normalizedEventName] = nil
                self.eventStats[normalizedEventName] = nil
                if self.debug then self:Debug("Unregistered " .. normalizedEventName .. " from WoW API (no more handlers)") end
            else
                -- Event doesn't exist, but clean up our tracking anyway
                self.registeredEvents[normalizedEventName] = nil
                self.moduleEventHandlers[normalizedEventName] = nil
                self.eventStats[normalizedEventName] = nil
                if self.debug then self:Debug("Cleaned up tracking for " .. normalizedEventName .. " (event not available)") end
            end
        elseif self.debug then
            self:Debug("Keeping " .. normalizedEventName .. " registered (discovered event during startup)")
        end
    else
        -- Update stats
        if self.eventStats[normalizedEventName] then
            self.eventStats[normalizedEventName].handlers = #self.moduleEventHandlers[normalizedEventName]
        end
    end
end

--- Centralized event handler that distributes events to all registered modules
--- @param event string The event name
--- @param ... any Event arguments
function EventManager:OnEvent(event, ...)
    -- Safety check - ensure moduleEventHandlers table exists
    if not self.moduleEventHandlers then
        self:Error("EventManager internal error: moduleEventHandlers table is nil. " ..
            "This indicates a critical initialization failure - try /reload")
        return
    end

    -- Queue startup-sensitive events during initialization (even if no handlers registered yet)
    if self:ShouldQueueEvent(event) then
        self:QueueEvent(event, ...)
        return
    end

    -- Fast-path: avoid hot-path work for events with no active handlers.
    local handlers = self.moduleEventHandlers[event]
    if not handlers then
        return
    end
    if #handlers == 0 then
        -- Startup keeps discovered events registered for queueing.
        -- After COMPLETE, prune empty registrations lazily on first runtime hit.
        if self.currentPhase >= ns.StartupPhase.COMPLETE and self.registeredEvents[event] then
            local success = self:SafeUnregisterEvent(event, "OnEvent")
            if success then
                self.registeredEvents[event] = nil
                self.moduleEventHandlers[event] = nil
                self.eventStats[event] = nil
                self.diagnostics.startupPrunedEvents = (self.diagnostics.startupPrunedEvents or 0) + 1
            end
        end
        return
    end

    -- Update stats
    if not self.eventStats[event] then
        self.eventStats[event] = { sent = 0, handlers = 0, lastSent = 0 }
    end
    self.eventStats[event].sent = self.eventStats[event].sent + 1
    self.eventStats[event].lastSent = GetTime()
    self.performanceStats.totalEvents = self.performanceStats.totalEvents + 1
    if UnitAffectingCombat and not UnitAffectingCombat("player") then
        self.diagnostics.idleEventsTotal = (self.diagnostics.idleEventsTotal or 0) + 1
        self.diagnostics.idleEventsByEvent[event] = (self.diagnostics.idleEventsByEvent[event] or 0) + 1
    end

    -- Handle performance-critical events with batching
    if self:IsPerformanceEvent(event) then
        self:HandleBatchedEvent(event, ...)
        return
    end

    -- Distribute to all registered handlers
    -- Use TablePool for event args to reduce allocations (50-200 events/second)
    local args = TablePool:Acquire("small")
    local paramCount = select("#", ...)
    for i = 1, paramCount do
        args[i] = select(i, ...)
    end
    local handlerCount = 0

    for _, handlerInfo in ipairs(handlers) do
        local module = handlerInfo.moduleRef
        if not module then
            module = NAG:GetModule(handlerInfo.moduleName, true)
            if module then
                handlerInfo.moduleRef = module
            end
        end
        if module then
            local success, err = false, nil
            if type(handlerInfo.handler) == "function" then
                success, err = pcall(handlerInfo.handler, module, event, unpack(args, 1, paramCount))
            elseif type(handlerInfo.handler) == "string" and module[handlerInfo.handler] then
                success, err = pcall(module[handlerInfo.handler], module, event, unpack(args, 1, paramCount))
            end

            if success then
                handlerCount = handlerCount + 1
            elseif err then
                self.diagnostics.dispatchEventErrors = (self.diagnostics.dispatchEventErrors or 0) + 1
                self:Error("Error in event handler '%s' for event '%s': %s - " ..
                    "this may cause rotation issues for affected modules",
                    tostring(handlerInfo.moduleName), tostring(event), tostring(err))
            end
        else
            self.diagnostics.missingHandlerModules = (self.diagnostics.missingHandlerModules or 0) + 1
            -- Module not found, log warning but don't crash
            self:Warn("Event handler module '%s' not found for event '%s' - rotation updates may be delayed. " ..
                "This usually indicates a disabled or failed module",
                tostring(handlerInfo.moduleName), tostring(event))
        end
    end

    -- Release args table back to pool
    TablePool:Release("small", args)

    self.performanceStats.totalHandlers = self.performanceStats.totalHandlers + handlerCount
    -- Removed high-frequency TRACE - fires hundreds of times per second with no production value
    -- Performance stats can be viewed with /nag eventmanager performance if needed
end

-- ============================ STARTUP EVENT QUEUEING ============================

--- Checks if event should be queued during startup
--- @param event string The event name
--- @return boolean shouldQueue Whether the event should be queued
function EventManager:ShouldQueueEvent(event)
    return self.currentPhase < ns.StartupPhase.COMPLETE
        and (self.discoveredEvents[event] or false)
end

--- Queues an event for later processing
--- @param event string The event name
--- @param ... any Event arguments
function EventManager:QueueEvent(event, ...)
    if not self.queuedEvents[event] then
        self.queuedEvents[event] = {}
    end

    local queueEntry = { n = select("#", ...) }
    for i = 1, queueEntry.n do
        queueEntry[i] = select(i, ...)
    end

    tinsert(self.queuedEvents[event], queueEntry)
    local queueSize = #self.queuedEvents[event]
    self.diagnostics.queuedEventsTotal = (self.diagnostics.queuedEventsTotal or 0) + 1
    self.diagnostics.queuedEventsPeak = math.max(self.diagnostics.queuedEventsPeak or 0, queueSize)
    self.diagnostics.startupQueueByEventPeak[event] = math.max(
        self.diagnostics.startupQueueByEventPeak[event] or 0,
        queueSize
    )

    self:Debug("Queued %s (phase: %d, queue size: %d)",
        event, self.currentPhase, queueSize)
end

--- Flushes queued events (processes all queued events)
function EventManager:FlushQueuedEvents()
    local flushedCount = 0
    self.diagnostics.queueFlushCount = (self.diagnostics.queueFlushCount or 0) + 1

    for event, eventQueue in pairs(self.queuedEvents) do
        if #eventQueue > 0 then
            self:Debug("Flushing %d queued %s events", #eventQueue, event)

            -- Process all queued events (preserves payload data for events like LEARNED_SPELL_IN_TAB)
            -- Note: ShouldQueueEvent will return false now (phase is COMPLETE), so events process normally
            for i, args in ipairs(eventQueue) do
                self:OnEvent(event, unpack(args, 1, args.n or #args))
                flushedCount = flushedCount + 1
                eventQueue[i] = nil
            end
        end
    end

    -- Clear queue
    wipe(self.queuedEvents)
    self.diagnostics.queuedEventsFlushed = (self.diagnostics.queuedEventsFlushed or 0) + flushedCount

    self:Info("Flushed %d total events from startup queue", flushedCount)
end

-- ============================ STARTUP PHASE TRANSITIONS ============================

--- Advances to the next startup phase
--- @param newPhase number The new phase to advance to
--- @param reason string Reason for the phase transition
function EventManager:AdvancePhase(newPhase, reason)
    if newPhase <= self.currentPhase then
        self:Debug("Ignoring phase advance to %d (already at %d)", newPhase, self.currentPhase)
        return
    end

    self:Info("Startup Phase: %d -> %d (%s)", self.currentPhase, newPhase, reason)
    self.currentPhase = newPhase

    -- Check if we've reached COMPLETE
    if newPhase == ns.StartupPhase.COMPLETE then
        self:OnStartupComplete()
    end
end

--- Called when startup is complete
function EventManager:OnStartupComplete()
    self:Info("=== STARTUP COMPLETE - All systems ready ===")

    -- Flush all queued events
    self:FlushQueuedEvents()
    self:PruneInactiveDiscoveredEvents()

    -- Send completion message
    NAG:SendMessage("NAG_STARTUP_COMPLETE")
end

--- Unregisters discovered startup events that ended with zero active handlers.
--- Safe after COMPLETE phase: modules can re-register on demand later.
function EventManager:PruneInactiveDiscoveredEvents()
    local prunedCount = 0
    for eventName, discovered in pairs(self.discoveredEvents) do
        if discovered
            and eventName ~= "COMBAT_LOG_EVENT_UNFILTERED"
            and self.registeredEvents[eventName]
            and self.moduleEventHandlers[eventName]
            and #self.moduleEventHandlers[eventName] == 0 then
            local success = self:SafeUnregisterEvent(eventName, "OnEvent")
            if success then
                self.registeredEvents[eventName] = nil
                self.moduleEventHandlers[eventName] = nil
                self.eventStats[eventName] = nil
                prunedCount = prunedCount + 1
            end
        end
    end

    self.diagnostics.startupPrunedEvents = (self.diagnostics.startupPrunedEvents or 0) + prunedCount
    if prunedCount > 0 then
        self:Info("Pruned %d inactive startup event registrations", prunedCount)
    end
end

--- Handles PLAYER_ENTERING_WORLD for phase transitions
--- @param event string The event name
--- @param isLogin boolean Whether this is a login
--- @param isReload boolean Whether this is a reload
function EventManager:OnPlayerEnteringWorld(event, isLogin, isReload)
    -- Queue the actual event for modules
    if self:ShouldQueueEvent(event) then
        self:QueueEvent(event, isLogin, isReload)
    end

    -- Advance to GAME_READY if we're at DATA_READY
    if self.currentPhase >= ns.StartupPhase.DATA_READY then
        self:AdvancePhase(ns.StartupPhase.GAME_READY, "Player entered world")

        -- Wait 2 seconds for WoW APIs to stabilize, then mark COMPLETE
        if self.gameReadyTimer then
            self:CancelTimer(self.gameReadyTimer)
        end

        self.gameReadyTimer = self:ScheduleTimer(function()
            self:AdvancePhase(ns.StartupPhase.COMPLETE, "Game APIs stable")
            self.gameReadyTimer = nil
        end, 2.0)
    end
end

-- ============================ PERFORMANCE EVENT BATCHING ============================

--- Performance-critical events that should be batched
-- Temporarily commented out for testing core event system
EventManager.PERFORMANCE_EVENTS = {
    -- ["COMBAT_LOG_EVENT_UNFILTERED"] = { batchTime = 0.016, maxBatchSize = 50 },
    -- ["UNIT_SPELLCAST_SUCCEEDED"] = { batchTime = 0.016, maxBatchSize = 20 },
    -- ["UNIT_SPELLCAST_START"] = { batchTime = 0.016, maxBatchSize = 20 },
    -- ["UNIT_SPELLCAST_STOP"] = { batchTime = 0.016, maxBatchSize = 20 },
    -- ["UNIT_SPELLCAST_FAILED"] = { batchTime = 0.016, maxBatchSize = 20 },
    -- ["UNIT_SPELLCAST_INTERRUPTED"] = { batchTime = 0.016, maxBatchSize = 20 },
    ["PLAYER_TARGET_CHANGED"] = { batchTime = 0.1, maxBatchSize = 5 },
    ["PLAYER_REGEN_ENABLED"] = { batchTime = 0.1, maxBatchSize = 5 },
    ["PLAYER_REGEN_DISABLED"] = { batchTime = 0.1, maxBatchSize = 5 },
}

--- Checks if an event is performance-critical
--- @param event string The event name
--- @return boolean Whether the event should be batched
function EventManager:IsPerformanceEvent(event)
    return self.PERFORMANCE_EVENTS[event] ~= nil
end

--- Handles batched performance events
--- @param event string The event name
--- @param ... any Event arguments
function EventManager:HandleBatchedEvent(event, ...)
    local config = self.PERFORMANCE_EVENTS[event]
    if not config then
        return
    end

    -- Initialize batch if needed
    if not self.batchedEvents[event] then
        self.batchedEvents[event] = {
            events = {},
            timer = nil,
            lastProcessed = 0
        }
    end

    local batch = self.batchedEvents[event]

    -- Add event to batch with explicit argument count
    local packedEvent = { n = select("#", ...) }
    for i = 1, packedEvent.n do
        packedEvent[i] = select(i, ...)
    end
    tinsert(batch.events, packedEvent)

    -- Process batch if it's full or enough time has passed
    local currentTime = GetTime()
    local shouldProcess = #batch.events >= config.maxBatchSize or
        (currentTime - batch.lastProcessed) >= config.batchTime

    if shouldProcess then
        self:ProcessBatchedEvent(event, batch.events)
        wipe(batch.events)
        batch.lastProcessed = currentTime

        -- Cancel existing timer
        if batch.timer then
            self:CancelTimer(batch.timer)
            batch.timer = nil
        end
    else
        -- Schedule processing if not already scheduled
        if not batch.timer then
            batch.timer = self:ScheduleTimer(function()
                if #batch.events > 0 then
                    self:ProcessBatchedEvent(event, batch.events)
                    wipe(batch.events)
                    batch.lastProcessed = GetTime()
                end
                batch.timer = nil
            end, config.batchTime)
        end
    end
end

--- Processes a batch of events
--- @param event string The event name
--- @param batch table The batch of events
function EventManager:ProcessBatchedEvent(event, batch)
    if not self.moduleEventHandlers[event] then
        return
    end

    local handlerCount = 0
    self.diagnostics.batchProcessCount = (self.diagnostics.batchProcessCount or 0) + 1
    self.diagnostics.batchEventsProcessed = (self.diagnostics.batchEventsProcessed or 0) + #batch
    self.diagnostics.batchByEvent[event] = (self.diagnostics.batchByEvent[event] or 0) + #batch

    for _, handlerInfo in ipairs(self.moduleEventHandlers[event]) do
        local module = handlerInfo.moduleRef
        if not module then
            module = NAG:GetModule(handlerInfo.moduleName, true)
            if module then
                handlerInfo.moduleRef = module
            end
        end
        if module then
            local hadError = false
            for _, packedArgs in ipairs(batch) do
                local argCount = packedArgs.n or #packedArgs
                local success, err = false, nil
                if type(handlerInfo.handler) == "function" then
                    success, err = pcall(handlerInfo.handler, module, event, unpack(packedArgs, 1, argCount))
                elseif type(handlerInfo.handler) == "string" and module[handlerInfo.handler] then
                    success, err = pcall(module[handlerInfo.handler], module, event, unpack(packedArgs, 1, argCount))
                end

                if not success and err then
                    hadError = true
                    self.diagnostics.dispatchEventErrors = (self.diagnostics.dispatchEventErrors or 0) + 1
                    self:Error("Error in batched event handler " ..
                        handlerInfo.moduleName .. " for " .. event .. ": " .. tostring(err))
                    break
                end
            end

            if not hadError then
                handlerCount = handlerCount + 1
            end
        else
            self.diagnostics.missingHandlerModules = (self.diagnostics.missingHandlerModules or 0) + 1
        end
    end

    self.performanceStats.totalHandlers = self.performanceStats.totalHandlers + handlerCount
    self:Trace("Processed " .. event .. " batch with " .. #batch .. " events for " .. handlerCount .. " handlers")
end

-- ============================ MODULE INTEGRATION ============================

--- Registers all message handlers from a module's messageHandlers table
--- @param module CoreModule The module to register
function EventManager:RegisterModuleMessages(module)
    if not module.messageHandlers then
        return
    end

    self:Debug("Registering messages for module: " .. module:GetName())

    for message, handler in pairs(module.messageHandlers) do
        if handler == true then
            -- Use the message name as the method name
            if module[message] then
                module:RegisterMessage(message)
                self:Debug("Registered message: " .. message .. " for module: " .. module:GetName())
            else
                self:Warn("Message handler method '" .. message .. "' not found for module '" .. module:GetName() .. "'")
            end
        elseif type(handler) == "string" then
            -- Use the specified method name
            if module[handler] then
                module:RegisterMessage(message, handler)
                self:Debug("Registered message: " .. message .. " -> " .. handler .. " for module: " .. module:GetName())
            else
                self:Warn("Message handler method '" .. handler .. "' not found for module '" .. module:GetName() .. "'")
            end
        elseif type(handler) == "function" then
            -- Register the function directly
            module:RegisterMessage(message, handler)
            self:Debug("Registered message: " .. message .. " (function) for module: " .. module:GetName())
        end
    end
end

--- Registers all events from a module's eventHandlers table with centralized system
--- @param module CoreModule The module to register
function EventManager:RegisterModuleEvents(module)
    -- Add proper error handling for nil module
    if not module then
        self:Error("RegisterModuleEvents called with nil module parameter")
        return
    end

    -- Current convention: module.eventHandlers
    local handlersTable = module.eventHandlers
    if not handlersTable then
        return
    end

    -- Ensure module has GetName method
    if not module.GetName or type(module.GetName) ~= "function" then
        self:Error("RegisterModuleEvents called with invalid module (missing GetName method)")
        return
    end

    self:Debug("Registering events for module: " .. module:GetName())

    for event, handler in pairs(handlersTable) do
        local normalizedEvent = self:NormalizeEventKey(event)
        if not normalizedEvent then
            self:Warn("Invalid event key in module '%s': %s", module:GetName(), tostring(event))
        elseif handler == true then
            -- Use the event name as the method name
            if module[normalizedEvent] then
                self:RegisterModuleForEvent(module:GetName(), normalizedEvent, normalizedEvent)
                self:Debug("Registered event: " .. normalizedEvent .. " for module: " .. module:GetName())
            elseif module[event] then
                -- Backward compatibility for non-normalized method names
                self:RegisterModuleForEvent(module:GetName(), normalizedEvent, event)
                self:Warn("Module '%s' uses non-normalized event method '%s' for event '%s'",
                    module:GetName(), tostring(event), normalizedEvent)
            else
                self:Warn("Event handler method '" .. normalizedEvent .. "' not found for module '" .. module:GetName() .. "'")
            end
        elseif type(handler) == "string" then
            -- Use the specified method name
            if module[handler] then
                self:RegisterModuleForEvent(module:GetName(), normalizedEvent, handler)
                self:Debug("Registered event: " .. normalizedEvent .. " -> " .. handler .. " for module: " .. module:GetName())
            else
                self:Warn("Event handler method '" .. handler .. "' not found for module '" .. module:GetName() .. "'")
            end
        elseif type(handler) == "function" then
            -- Direct function handler support
            self:RegisterModuleForEvent(module:GetName(), normalizedEvent, handler)
            self:Debug("Registered event: " .. normalizedEvent .. " (function) for module: " .. module:GetName())
        else
            self:Warn("Invalid event handler type for " ..
                tostring(normalizedEvent) .. " in module '" .. module:GetName() .. "': " .. type(handler))
        end
    end
end

-- ============================ CENTRALIZED CLEU REGISTRATION ============================

--- Invalidates cached CLEU dispatch lists.
--- @param subEvent string|nil Specific subevent to invalidate, or nil for full reset
function EventManager:InvalidateCLEUDispatchCache(subEvent)
    self.cleuDispatchCache = self.cleuDispatchCache or {}
    if subEvent then
        self.cleuDispatchCache[subEvent] = nil
        return
    end
    wipe(self.cleuDispatchCache)
end

--- Builds merged dispatch handlers for a CLEU subevent.
--- @param subEvent string
--- @return table
function EventManager:BuildCLEUDispatchCacheForSubEvent(subEvent)
    local cache = {}
    local handlers = self.moduleCLEUHandlers[subEvent]
    local wildcardHandlers = self.moduleCLEUHandlers["*"]
    local externalHandlers = self.externalCLEUHandlers[subEvent]
    local externalWildcardHandlers = self.externalCLEUHandlers["*"]

    if handlers then
        for _, handlerInfo in ipairs(handlers) do
            tinsert(cache, {
                isExternal = false,
                moduleName = handlerInfo.moduleName,
                handler = handlerInfo.handler,
                moduleRef = handlerInfo.moduleRef,
            })
        end
    end

    if wildcardHandlers then
        for _, handlerInfo in ipairs(wildcardHandlers) do
            tinsert(cache, {
                isExternal = false,
                moduleName = handlerInfo.moduleName,
                handler = handlerInfo.handler,
                moduleRef = handlerInfo.moduleRef,
            })
        end
    end

    if externalHandlers then
        for _, handlerInfo in ipairs(externalHandlers) do
            tinsert(cache, {
                isExternal = true,
                ownerKey = handlerInfo.ownerKey,
                callback = handlerInfo.callback,
            })
        end
    end

    if externalWildcardHandlers then
        for _, handlerInfo in ipairs(externalWildcardHandlers) do
            tinsert(cache, {
                isExternal = true,
                ownerKey = handlerInfo.ownerKey,
                callback = handlerInfo.callback,
            })
        end
    end

    self.cleuDispatchCache[subEvent] = cache
    return cache
end

--- Gets merged dispatch handlers for a CLEU subevent.
--- @param subEvent string
--- @return table
function EventManager:GetCLEUDispatchHandlers(subEvent)
    self.cleuDispatchCache = self.cleuDispatchCache or {}
    local cached = self.cleuDispatchCache[subEvent]
    if cached then
        return cached
    end
    return self:BuildCLEUDispatchCacheForSubEvent(subEvent)
end

--- Registers all CLEU handlers from a module's cleuHandlers table
--- @param module CoreModule The module to register
--- CLEU handler contract: handlers should support
--- (timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags,
---  destGUID, destName, destFlags, destRaidFlags, arg12 ... arg24)
function EventManager:RegisterModuleCLEUHandlers(module)
    if not module or not module.cleuHandlers then
        return
    end

    if not module.GetName or type(module.GetName) ~= "function" then
        self:Error("RegisterModuleCLEUHandlers called with invalid module (missing GetName method)")
        return
    end

    local moduleName = module:GetName()
    self.cleuWhitelist = self.cleuWhitelist or {}
    self.moduleCLEUHandlers = self.moduleCLEUHandlers or {}
    self.moduleCLEURegistrations = self.moduleCLEURegistrations or {}

    for subEvent, handler in pairs(module.cleuHandlers) do
        if type(subEvent) ~= "string" or subEvent == "" then
            self:Warn("Invalid CLEU subevent key for module '%s': %s", moduleName, tostring(subEvent))
        else
            local normalizedSubEvent = (subEvent == "*") and "*" or strupper(subEvent)
            local resolvedHandler = nil

            if handler == true then
                if module[normalizedSubEvent] then
                    resolvedHandler = normalizedSubEvent
                else
                    self:Warn("CLEU handler method '%s' not found for module '%s'", normalizedSubEvent, moduleName)
                end
            elseif type(handler) == "string" then
                if module[handler] then
                    resolvedHandler = handler
                else
                    self:Warn("CLEU handler method '%s' not found for module '%s'", handler, moduleName)
                end
            elseif type(handler) == "function" then
                resolvedHandler = handler
            else
                self:Warn("Invalid CLEU handler type for %s in module '%s': %s",
                    tostring(subEvent), moduleName, type(handler))
            end

            if resolvedHandler then
                local targetKey = normalizedSubEvent
                if not self.moduleCLEUHandlers[targetKey] then
                    self.moduleCLEUHandlers[targetKey] = {}
                end

                -- Avoid duplicate registrations for the same module/subEvent pair
                local alreadyRegistered = false
                for _, existing in ipairs(self.moduleCLEUHandlers[targetKey]) do
                    if existing.moduleName == moduleName then
                        alreadyRegistered = true
                        break
                    end
                end

                if not alreadyRegistered then
                    tinsert(self.moduleCLEUHandlers[targetKey], {
                        moduleName = moduleName,
                        handler = resolvedHandler,
                        moduleRef = NAG:GetModule(moduleName, true),
                    })

                    -- Track per-module registrations for clean unregistration
                    if not self.moduleCLEURegistrations[moduleName] then
                        self.moduleCLEURegistrations[moduleName] = {}
                    end
                    self.moduleCLEURegistrations[moduleName][targetKey] = true

                    -- Initialize stats entry
                    self.cleuStats[targetKey] = self.cleuStats[targetKey] or { sent = 0, handlers = 0, lastSent = 0 }

                    -- Add to whitelist for fast filtering (skip wildcard)
                    if targetKey ~= "*" then
                        self.cleuWhitelist[targetKey] = true
                    end

                    if targetKey == "*" then
                        self:InvalidateCLEUDispatchCache()
                    else
                        self:InvalidateCLEUDispatchCache(targetKey)
                    end
                else
                    self.diagnostics.duplicateCLEURegistrations = (self.diagnostics.duplicateCLEURegistrations or 0) + 1
                end
            end
        end
    end

    self:UpdateCLEUHandlerCounts()

    -- Ensure the central CLEU event is registered once
    if not self.registeredEvents["COMBAT_LOG_EVENT_UNFILTERED"] then
        local success = self:SafeRegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "COMBAT_LOG_EVENT_UNFILTERED")
        if success then
            self.registeredEvents["COMBAT_LOG_EVENT_UNFILTERED"] = true
            if self.debug then self:Debug("Registered COMBAT_LOG_EVENT_UNFILTERED centrally") end
        end
    end
end

--- Recalculate CLEU handler counts for statistics
function EventManager:UpdateCLEUHandlerCounts()
    if not self.cleuStats then
        self.cleuStats = {}
    end

    local wildcardHandlers = self.moduleCLEUHandlers["*"]
    local externalWildcardHandlers = self.externalCLEUHandlers["*"]

    if wildcardHandlers or externalWildcardHandlers then
        self.cleuStats["*"] = self.cleuStats["*"] or { sent = 0, handlers = 0, lastSent = 0 }
        self.cleuStats["*"].handlers = (wildcardHandlers and #wildcardHandlers or 0)
            + (externalWildcardHandlers and #externalWildcardHandlers or 0)
    elseif self.cleuStats["*"] then
        self.cleuStats["*"] = nil
    end

    local knownSubEvents = {}
    for subEvent, handlers in pairs(self.moduleCLEUHandlers) do
        if subEvent ~= "*" then
            knownSubEvents[subEvent] = true
            local externalHandlers = self.externalCLEUHandlers[subEvent]
            local total = #handlers
                + (wildcardHandlers and #wildcardHandlers or 0)
                + (externalHandlers and #externalHandlers or 0)
                + (externalWildcardHandlers and #externalWildcardHandlers or 0)
            self.cleuStats[subEvent] = self.cleuStats[subEvent] or { sent = 0, handlers = 0, lastSent = 0 }
            self.cleuStats[subEvent].handlers = total
        end
    end

    for subEvent, handlers in pairs(self.externalCLEUHandlers) do
        if subEvent ~= "*" then
            knownSubEvents[subEvent] = true
            local moduleHandlers = self.moduleCLEUHandlers[subEvent]
            local total = (moduleHandlers and #moduleHandlers or 0)
                + #handlers
                + (wildcardHandlers and #wildcardHandlers or 0)
                + (externalWildcardHandlers and #externalWildcardHandlers or 0)
            self.cleuStats[subEvent] = self.cleuStats[subEvent] or { sent = 0, handlers = 0, lastSent = 0 }
            self.cleuStats[subEvent].handlers = total
        end
    end

    -- Cleanup stats for subevents that no longer exist
    for subEvent in pairs(self.cleuStats) do
        if subEvent ~= "*" and not knownSubEvents[subEvent] then
            self.cleuStats[subEvent] = nil
        end
    end
end

--- Unregisters all CLEU handlers for a module
--- @param moduleName string The module name
function EventManager:UnregisterModuleCLEUHandlers(moduleName)
    if not moduleName or not self.moduleCLEURegistrations or not self.moduleCLEURegistrations[moduleName] then
        return
    end

    for subEvent in pairs(self.moduleCLEURegistrations[moduleName]) do
        local handlers = self.moduleCLEUHandlers[subEvent]
        if handlers then
            for i = #handlers, 1, -1 do
                if handlers[i].moduleName == moduleName then
                    tremove(handlers, i)
                end
            end
            if #handlers == 0 then
                self.moduleCLEUHandlers[subEvent] = nil
                self.cleuWhitelist[subEvent] = nil
            end
            if subEvent == "*" then
                self:InvalidateCLEUDispatchCache()
            else
                self:InvalidateCLEUDispatchCache(subEvent)
            end
        end
    end

    self.moduleCLEURegistrations[moduleName] = nil

    self:UpdateCLEUHandlerCounts()

    -- If no CLEU handlers remain, unregister the event.
    if not next(self.cleuWhitelist)
        and not next(self.externalCLEUWhitelist)
        and self.registeredEvents["COMBAT_LOG_EVENT_UNFILTERED"] then
        local success = self:SafeUnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "COMBAT_LOG_EVENT_UNFILTERED")
        if success then
            self.registeredEvents["COMBAT_LOG_EVENT_UNFILTERED"] = nil
            if self.debug then self:Debug("Unregistered COMBAT_LOG_EVENT_UNFILTERED (no CLEU handlers remaining)") end
        end
    end
end

--- Registers an external CLEU callback (non-module handler).
--- @param ownerKey string Unique owner key for cleanup (e.g. "APLDRW")
--- @param subEvent string CLEU subevent name or "*" wildcard
--- @param callback function Callback invoked with CombatLog args
--- @return boolean
function EventManager:RegisterExternalCLEUHandler(ownerKey, subEvent, callback)
    if type(ownerKey) ~= "string" or ownerKey == "" then
        return false
    end
    if type(subEvent) ~= "string" or subEvent == "" then
        return false
    end
    if type(callback) ~= "function" then
        return false
    end

    local targetKey = (subEvent == "*") and "*" or strupper(subEvent)
    if not self.externalCLEUHandlers[targetKey] then
        self.externalCLEUHandlers[targetKey] = {}
    end

    local handlers = self.externalCLEUHandlers[targetKey]
    for _, info in ipairs(handlers) do
        if info.ownerKey == ownerKey then
            self.diagnostics.duplicateExternalCLEURegistrations =
                (self.diagnostics.duplicateExternalCLEURegistrations or 0) + 1
            info.callback = callback
            if targetKey == "*" then
                self:InvalidateCLEUDispatchCache()
            else
                self:InvalidateCLEUDispatchCache(targetKey)
            end
            return true
        end
    end

    tinsert(handlers, {
        ownerKey = ownerKey,
        callback = callback,
    })

    if not self.externalCLEURegistrations[ownerKey] then
        self.externalCLEURegistrations[ownerKey] = {}
    end
    self.externalCLEURegistrations[ownerKey][targetKey] = true

    if targetKey ~= "*" then
        self.externalCLEUWhitelist[targetKey] = true
    end

    if targetKey == "*" then
        self:InvalidateCLEUDispatchCache()
    else
        self:InvalidateCLEUDispatchCache(targetKey)
    end

    -- Ensure the central CLEU event is registered once.
    if not self.registeredEvents["COMBAT_LOG_EVENT_UNFILTERED"] then
        local success = self:SafeRegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "COMBAT_LOG_EVENT_UNFILTERED")
        if success then
            self.registeredEvents["COMBAT_LOG_EVENT_UNFILTERED"] = true
        end
    end

    self:UpdateCLEUHandlerCounts()
    return true
end

--- Unregister all external CLEU callbacks for an owner key.
--- @param ownerKey string
function EventManager:UnregisterExternalCLEUHandlers(ownerKey)
    if type(ownerKey) ~= "string" or ownerKey == "" then
        return
    end

    local registrations = self.externalCLEURegistrations[ownerKey]
    if not registrations then
        return
    end

    for subEvent in pairs(registrations) do
        local handlers = self.externalCLEUHandlers[subEvent]
        if handlers then
            for i = #handlers, 1, -1 do
                if handlers[i].ownerKey == ownerKey then
                    tremove(handlers, i)
                end
            end
            if #handlers == 0 then
                self.externalCLEUHandlers[subEvent] = nil
                self.externalCLEUWhitelist[subEvent] = nil
            end
            if subEvent == "*" then
                self:InvalidateCLEUDispatchCache()
            else
                self:InvalidateCLEUDispatchCache(subEvent)
            end
        end
    end

    self.externalCLEURegistrations[ownerKey] = nil
    self:UpdateCLEUHandlerCounts()

    if not next(self.cleuWhitelist)
        and not next(self.externalCLEUWhitelist)
        and self.registeredEvents["COMBAT_LOG_EVENT_UNFILTERED"] then
        local success = self:SafeUnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "COMBAT_LOG_EVENT_UNFILTERED")
        if success then
            self.registeredEvents["COMBAT_LOG_EVENT_UNFILTERED"] = nil
        end
    end
end

--- Centralized CLEU dispatcher
function EventManager:COMBAT_LOG_EVENT_UNFILTERED()
    local timestamp, subEvent, hideCaster,
        sourceGUID, sourceName, sourceFlags, sourceRaidFlags,
        destGUID, destName, destFlags, destRaidFlags,
        arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24 =
        CombatLogGetCurrentEventInfo()

    local wildcardHandlers = self.moduleCLEUHandlers["*"]
    local externalWildcardHandlers = self.externalCLEUHandlers["*"]
    if not self.cleuWhitelist[subEvent]
        and not self.externalCLEUWhitelist[subEvent]
        and not wildcardHandlers
        and not externalWildcardHandlers then
        return
    end

    local dispatchHandlers = self:GetCLEUDispatchHandlers(subEvent)
    if not dispatchHandlers or #dispatchHandlers == 0 then
        return
    end

    local handlerCount = 0
    for _, handlerInfo in ipairs(dispatchHandlers) do
        if handlerInfo.isExternal then
            local success, err = pcall(
                handlerInfo.callback,
                timestamp, subEvent, hideCaster,
                sourceGUID, sourceName, sourceFlags, sourceRaidFlags,
                destGUID, destName, destFlags, destRaidFlags,
                arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24
            )
            if not success then
                self.diagnostics.dispatchExternalCLEUErrors = (self.diagnostics.dispatchExternalCLEUErrors or 0) + 1
                self:Error("Error in external CLEU handler '%s' for subevent '%s': %s",
                    tostring(handlerInfo.ownerKey), tostring(subEvent), tostring(err))
            else
                handlerCount = handlerCount + 1
            end
        else
            local cleuModule = handlerInfo.moduleRef
            if not cleuModule then
                cleuModule = NAG:GetModule(handlerInfo.moduleName, true)
                if cleuModule then
                    handlerInfo.moduleRef = cleuModule
                end
            end
            if cleuModule then
                local success, err = false, nil
                if type(handlerInfo.handler) == "function" then
                    success, err = pcall(
                        handlerInfo.handler,
                        cleuModule,
                        timestamp, subEvent, hideCaster,
                        sourceGUID, sourceName, sourceFlags, sourceRaidFlags,
                        destGUID, destName, destFlags, destRaidFlags,
                        arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24
                    )
                elseif type(handlerInfo.handler) == "string" and cleuModule[handlerInfo.handler] then
                    success, err = pcall(
                        cleuModule[handlerInfo.handler],
                        cleuModule,
                        timestamp, subEvent, hideCaster,
                        sourceGUID, sourceName, sourceFlags, sourceRaidFlags,
                        destGUID, destName, destFlags, destRaidFlags,
                        arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24
                    )
                end

                if success then
                    handlerCount = handlerCount + 1
                elseif err then
                    self.diagnostics.dispatchCLEUErrors = (self.diagnostics.dispatchCLEUErrors or 0) + 1
                    self:Error("Error in CLEU handler '%s' for subevent '%s': %s",
                        tostring(handlerInfo.moduleName), tostring(subEvent), tostring(err))
                end
            else
                self.diagnostics.missingHandlerModules = (self.diagnostics.missingHandlerModules or 0) + 1
                self:Warn("CLEU handler module '%s' not found for subevent '%s'", tostring(handlerInfo.moduleName), tostring(subEvent))
            end
        end
    end

    -- Update CLEU statistics
    local stats = self.cleuStats[subEvent]
    if not stats then
        stats = { sent = 0, handlers = 0, lastSent = 0 }
        self.cleuStats[subEvent] = stats
    end
    stats.handlers = #dispatchHandlers
    stats.sent = stats.sent + 1
    stats.lastSent = GetTime()

    self.performanceStats.totalEvents = self.performanceStats.totalEvents + 1
    self.performanceStats.totalHandlers = self.performanceStats.totalHandlers + handlerCount
end

--- Gets a snapshot of active CLEU registrations for validation/debugging.
--- @return table
function EventManager:GetCLEURegistrationSnapshot()
    local snapshot = {
        moduleSubevents = {},
        moduleDetails = {},
        externalSubevents = {},
        externalDetails = {},
        moduleOwners = {},
        externalOwners = {},
    }

    for subEvent, handlers in pairs(self.moduleCLEUHandlers) do
        snapshot.moduleSubevents[subEvent] = #handlers
        for _, handlerInfo in ipairs(handlers) do
            snapshot.moduleOwners[handlerInfo.moduleName] = true
            snapshot.moduleDetails[#snapshot.moduleDetails + 1] = {
                subEvent = subEvent,
                moduleName = handlerInfo.moduleName,
                handler = handlerInfo.handler,
            }
        end
    end

    for subEvent, handlers in pairs(self.externalCLEUHandlers) do
        snapshot.externalSubevents[subEvent] = #handlers
        for _, handlerInfo in ipairs(handlers) do
            snapshot.externalOwners[handlerInfo.ownerKey] = true
            snapshot.externalDetails[#snapshot.externalDetails + 1] = {
                subEvent = subEvent,
                ownerKey = handlerInfo.ownerKey,
            }
        end
    end

    snapshot.moduleOwnerCount = TableUtils.Size(snapshot.moduleOwners)
    snapshot.externalOwnerCount = TableUtils.Size(snapshot.externalOwners)
    snapshot.moduleSubeventCount = TableUtils.Size(snapshot.moduleSubevents)
    snapshot.externalSubeventCount = TableUtils.Size(snapshot.externalSubevents)
    return snapshot
end

--- Prints detailed CLEU registration inventory.
function EventManager:PrintCLEURegistrationInventory()
    local snapshot = self:GetCLEURegistrationSnapshot()
    print("|cFF00FF00=== CLEU REGISTRATION INVENTORY ===|r")
    print(format("|cFF00FF00Module owners: %d, module subevents: %d|r",
        snapshot.moduleOwnerCount, snapshot.moduleSubeventCount))
    print(format("|cFF00FF00External owners: %d, external subevents: %d|r",
        snapshot.externalOwnerCount, snapshot.externalSubeventCount))

    print("")
    print("|cFF00FF00--- MODULE CLEU SUBEVENTS ---|r")
    for subEvent, count in pairs(snapshot.moduleSubevents) do
        print(format("|cFF00FF00%s: %d handler(s)|r", tostring(subEvent), count))
    end

    print("")
    print("|cFF00FF00--- EXTERNAL CLEU SUBEVENTS ---|r")
    for subEvent, count in pairs(snapshot.externalSubevents) do
        print(format("|cFF00FF00%s: %d handler(s)|r", tostring(subEvent), count))
    end

    print("")
    print("|cFF00FF00--- EXTERNAL CLEU OWNERS ---|r")
    local owners = {}
    for ownerKey in pairs(snapshot.externalOwners) do
        owners[#owners + 1] = ownerKey
    end
    sort(owners)
    for _, ownerKey in ipairs(owners) do
        print(format("|cFF00FF00%s|r", ownerKey))
    end
end

--- Convenience API to register both messages and events for a module
--- @param module CoreModule
function EventManager:RegisterModule(module)
    if not module or (not module.messageHandlers and not module.eventHandlers) then
        return
    end
    self:RegisterModuleMessages(module)
    self:RegisterModuleEvents(module)
end

-- ============================ PERFORMANCE MONITORING ============================

--- Starts performance monitoring
function EventManager:StartPerformanceMonitoring()
    self.performanceTimer = self:ScheduleRepeatingTimer(function()
        self:UpdatePerformanceStats()
    end, 5) -- Update every 5 seconds
    self:Debug("Performance monitoring started")
end

--- Stops performance monitoring
function EventManager:StopPerformanceMonitoring()
    if self.performanceTimer then
        self:CancelTimer(self.performanceTimer)
        self.performanceTimer = nil
    end
    self:Debug("Performance monitoring stopped")
end

--- Updates performance statistics
function EventManager:UpdatePerformanceStats()
    local currentTime = GetTime()
    local runtime = currentTime - self.performanceStats.startTime

    if runtime > 0 then
        local eventsPerSecond = self.performanceStats.totalEvents / runtime
        local handlersPerSecond = self.performanceStats.totalHandlers / runtime

        self:Debug(format("Performance: %.1f events/sec, %.1f handlers/sec",
            eventsPerSecond, handlersPerSecond))
    end
end

--- Gets event statistics
--- @return table Event statistics
function EventManager:GetEventStats()
    return self.eventStats
end

--- Gets performance statistics
--- @return table Performance statistics
function EventManager:GetPerformanceStats()
    return self.performanceStats
end

--- Gets active event registration snapshot.
--- @return table
function EventManager:GetEventRegistrationSnapshot()
    local snapshot = {
        events = {},
        modules = {},
        eventCount = 0,
        moduleCount = 0,
    }

    for eventName, handlers in pairs(self.moduleEventHandlers) do
        snapshot.events[eventName] = #handlers
        snapshot.eventCount = snapshot.eventCount + 1
        for _, handlerInfo in ipairs(handlers) do
            snapshot.modules[handlerInfo.moduleName] = true
        end
    end

    snapshot.moduleCount = TableUtils.Size(snapshot.modules)
    return snapshot
end

--- Prints event registration inventory.
function EventManager:PrintEventRegistrationInventory()
    local snapshot = self:GetEventRegistrationSnapshot()
    print("|cFF00FF00=== EVENT REGISTRATION INVENTORY ===|r")
    print(format("|cFF00FF00Events: %d, modules: %d|r", snapshot.eventCount, snapshot.moduleCount))
    print("")
    for eventName, count in pairs(snapshot.events) do
        print(format("|cFF00FF00%s: %d handler(s)|r", tostring(eventName), count))
    end
end

--- Prints EventManager diagnostics counters.
function EventManager:PrintDiagnostics()
    local d = self.diagnostics or {}
    print("|cFF00FF00=== EVENT MANAGER DIAGNOSTICS ===|r")
    print(format("|cFF00FF00Registration failures: %d|r", d.registrationFailures or 0))
    print(format("|cFF00FF00Duplicate event registrations: %d|r", d.duplicateEventRegistrations or 0))
    print(format("|cFF00FF00Duplicate CLEU registrations: %d|r", d.duplicateCLEURegistrations or 0))
    print(format("|cFF00FF00Duplicate external CLEU registrations: %d|r", d.duplicateExternalCLEURegistrations or 0))
    print(format("|cFF00FF00Missing handler modules: %d|r", d.missingHandlerModules or 0))
    print(format("|cFF00FF00Dispatch event errors: %d|r", d.dispatchEventErrors or 0))
    print(format("|cFF00FF00Dispatch CLEU errors: %d|r", d.dispatchCLEUErrors or 0))
    print(format("|cFF00FF00Dispatch external CLEU errors: %d|r", d.dispatchExternalCLEUErrors or 0))
    print("")
    print(format("|cFF00FF00Queue total: %d, queue peak: %d, flush count: %d, flushed total: %d|r",
        d.queuedEventsTotal or 0,
        d.queuedEventsPeak or 0,
        d.queueFlushCount or 0,
        d.queuedEventsFlushed or 0))
    print(format("|cFF00FF00Batch process count: %d, batched events processed: %d|r",
        d.batchProcessCount or 0,
        d.batchEventsProcessed or 0))
    print(format("|cFF00FF00Startup pruned events: %d|r", d.startupPrunedEvents or 0))
    print(format("|cFF00FF00Idle events total: %d, idle messages sent: %d, idle messages received: %d|r",
        d.idleEventsTotal or 0,
        d.idleMessagesSent or 0,
        d.idleMessagesReceived or 0))

    if d.startupQueueByEventPeak and next(d.startupQueueByEventPeak) then
        print("")
        print("|cFF00FF00--- STARTUP QUEUE PEAK BY EVENT ---|r")
        for eventName, count in pairs(d.startupQueueByEventPeak) do
            print(format("|cFF00FF00%s: %d|r", tostring(eventName), count))
        end
    end

    if d.batchByEvent and next(d.batchByEvent) then
        print("")
        print("|cFF00FF00--- BATCHED EVENTS PROCESSED BY EVENT ---|r")
        for eventName, count in pairs(d.batchByEvent) do
            print(format("|cFF00FF00%s: %d|r", tostring(eventName), count))
        end
    end

    if d.idleEventsByEvent and next(d.idleEventsByEvent) then
        print("")
        print("|cFF00FF00--- IDLE EVENTS BY EVENT ---|r")
        for eventName, count in pairs(d.idleEventsByEvent) do
            print(format("|cFF00FF00%s: %d|r", tostring(eventName), count))
        end
    end

    if d.idleMessageByName and next(d.idleMessageByName) then
        print("")
        print("|cFF00FF00--- IDLE MESSAGES BY NAME ---|r")
        for messageName, count in pairs(d.idleMessageByName) do
            print(format("|cFF00FF00%s: %d|r", tostring(messageName), count))
        end
    end
end

-- ============================ UTILITY METHODS ============================

--- Clears all batched events
function EventManager:ClearAllBatches()
    for event, batch in pairs(self.batchedEvents) do
        if batch.timer then
            self:CancelTimer(batch.timer)
        end
        wipe(batch.events)
    end
    wipe(self.batchedEvents)
end

--- Counts keys in a table (wrapper around TableUtils.Size)
--- @param tbl table The table to count
--- @return number Number of keys
function EventManager:CountTableKeys(tbl)
    return TableUtils.Size(tbl)
end

--- Gets failed event registrations for debugging
--- @return table Failed event registrations
function EventManager:GetFailedEventRegistrations()
    return self.failedEventRegistrations or {}
end

--- Prints failed event registrations
function EventManager:PrintFailedEventRegistrations()
    local failed = self:GetFailedEventRegistrations()
    if TableUtils.Size(failed) == 0 then
        self:Print("No failed event registrations")
        return
    end

    self:Print("=== FAILED EVENT REGISTRATIONS ===")
    for eventName, info in pairs(failed) do
        self:Print(format("%s: %s", eventName, tostring(info.error)))
    end
end

-- ============================ SYSTEM READY HANDLER ============================

--- Called when the system is ready

--     self:Info("System ready - EventManager fully operational")
--
--     -- Print initial statistics
--     if self.db.global.eventManagerShowStats then
--         self:PrintEventStats()
--     end
-- end

--- Prints event statistics
function EventManager:PrintEventStats()
    print("|cFF00FF00=== EVENT MANAGER STATISTICS ===")

    for event, stats in pairs(self.eventStats) do
        print("|cFF00FF00" .. format("%s: %d sent, %d handlers, last: %.2f",
            event, stats.sent or 0, stats.handlers or 0, stats.lastSent or 0) .. "|r")
    end

    if self.cleuStats and next(self.cleuStats) then
        print("")
        print("|cFF00FF00=== CLEU STATISTICS ===")
        for subEvent, stats in pairs(self.cleuStats) do
            print("|cFF00FF00" .. format("CLEU %s: %d sent, %d handlers, last: %.2f",
                subEvent, stats.sent or 0, stats.handlers or 0, stats.lastSent or 0) .. "|r")
        end
    end
end

--- Prints detailed module registration information
function EventManager:PrintModuleRegistrations()
    print("|cFF00FF00=== MODULE REGISTRATION INFORMATION ===")

    local totalEvents = 0
    local totalHandlers = 0
    local moduleCounts = {}

    -- Count events and handlers per module
    for event, handlers in pairs(self.moduleEventHandlers) do
        totalEvents = totalEvents + 1
        for _, handlerInfo in ipairs(handlers) do
            totalHandlers = totalHandlers + 1
            local moduleName = handlerInfo.moduleName
            moduleCounts[moduleName] = (moduleCounts[moduleName] or 0) + 1
        end
    end

    print("|cFF00FF00Total Events Registered: " .. totalEvents .. "|r")
    print("|cFF00FF00Total Handlers: " .. totalHandlers .. "|r")
    print("|cFF00FF00Total Modules: " .. self:CountTableKeys(moduleCounts) .. "|r")
    print("")

    -- CLEU summary
    local totalCLEUSubevents = self:CountTableKeys(self.moduleCLEUHandlers)
    local totalCLEUHandlers = 0
    local cleuModuleCounts = {}
    for subEvent, handlers in pairs(self.moduleCLEUHandlers) do
        totalCLEUHandlers = totalCLEUHandlers + #handlers
        for _, handlerInfo in ipairs(handlers) do
            local moduleName = handlerInfo.moduleName
            cleuModuleCounts[moduleName] = (cleuModuleCounts[moduleName] or 0) + 1
        end
    end

    print("|cFF00FF00=== CLEU REGISTRATION INFORMATION ===")
    print("|cFF00FF00Total CLEU Subevents: " .. totalCLEUSubevents .. "|r")
    print("|cFF00FF00Total CLEU Handlers: " .. totalCLEUHandlers .. "|r")
    print("|cFF00FF00Total CLEU Modules: " .. self:CountTableKeys(cleuModuleCounts) .. "|r")
    print("")

    -- Print per-module breakdown
    print("|cFF00FF00=== PER-MODULE BREAKDOWN ===")
    for moduleName, count in pairs(moduleCounts) do
        print("|cFF00FF00" .. moduleName .. ": " .. count .. " event handlers|r")
    end
    print("")

    -- Print per-module CLEU breakdown
    if next(cleuModuleCounts) then
        print("|cFF00FF00=== PER-MODULE CLEU BREAKDOWN ===")
        for moduleName, count in pairs(cleuModuleCounts) do
            print("|cFF00FF00" .. moduleName .. ": " .. count .. " CLEU handlers|r")
        end
        print("")
    end

    -- Print detailed event breakdown
    print("|cFF00FF00=== DETAILED EVENT BREAKDOWN ===")
    for event, handlers in pairs(self.moduleEventHandlers) do
        print("|cFF00FF00" .. event .. " (" .. #handlers .. " handlers):|r")
        for _, handlerInfo in ipairs(handlers) do
            local handlerType = type(handlerInfo.handler)
            local handlerDesc = handlerType == "string" and handlerInfo.handler or handlerType
            print("  |cFF00FF00  " .. handlerInfo.moduleName .. " -> " .. handlerDesc .. "|r")
        end
    end

    -- Print detailed CLEU breakdown
    if next(self.moduleCLEUHandlers) then
        print("")
        print("|cFF00FF00=== DETAILED CLEU BREAKDOWN ===")
        for subEvent, handlers in pairs(self.moduleCLEUHandlers) do
            print("|cFF00FF00CLEU " .. subEvent .. " (" .. #handlers .. " handlers):|r")
            for _, handlerInfo in ipairs(handlers) do
                local handlerType = type(handlerInfo.handler)
                local handlerDesc = handlerType == "string" and handlerInfo.handler or handlerType
                print("  |cFF00FF00  " .. handlerInfo.moduleName .. " -> " .. handlerDesc .. "|r")
            end
        end
    end
end

--- Prints detailed performance statistics
function EventManager:PrintPerformanceStats()
    print("|cFF00FF00=== PERFORMANCE STATISTICS ===")

    local currentTime = GetTime()
    local runtime = currentTime - self.performanceStats.startTime

    if runtime > 0 then
        local eventsPerSecond = self.performanceStats.totalEvents / runtime
        local handlersPerSecond = self.performanceStats.totalHandlers / runtime

        print("|cFF00FF00Runtime: " .. format("%.1f seconds", runtime) .. "|r")
        print("|cFF00FF00Total Events: " .. self.performanceStats.totalEvents .. "|r")
        print("|cFF00FF00Total Handlers: " .. self.performanceStats.totalHandlers .. "|r")
        print("|cFF00FF00Events/Second: " .. format("%.1f", eventsPerSecond) .. "|r")
        print("|cFF00FF00Handlers/Second: " .. format("%.1f", handlersPerSecond) .. "|r")
    else
        print("|cFF00FF00No runtime data available|r")
    end

    -- Print batch processing stats
    print("")
    print("|cFF00FF00=== BATCH PROCESSING STATISTICS ===")
    local totalBatchedEvents = 0
    for event, batch in pairs(self.batchedEvents) do
        totalBatchedEvents = totalBatchedEvents + #batch.events
    end
    print("|cFF00FF00Total Batched Events: " .. totalBatchedEvents .. "|r")
    print("|cFF00FF00Active Batches: " .. self:CountTableKeys(self.batchedEvents) .. "|r")
end

--- Shows current startup phase and queued events
function EventManager:ShowStartupPhase()
    local phaseNames = {
        [1] = "LOADING",
        [2] = "DATABASE_READY",
        [3] = "DATA_READY",
        [4] = "GAME_READY",
        [5] = "COMPLETE"
    }

    self:Print("Current Phase: %s (%d)",
        phaseNames[self.currentPhase] or "UNKNOWN",
        self.currentPhase)
    self:Print("Queued Events: %d types", TableUtils.Size(self.queuedEvents))

    for event, queue in pairs(self.queuedEvents) do
        self:Print("  - %s: %d queued", event, #queue)
    end
end

-- Note: Early event logging is now handled by Core.lua with independent buffering system

-- ============================ OPTIONS UI ============================

--- Gets the options table for EventManager settings
--- @return table The options table for AceConfig
function EventManager:GetOptions()
    return {
        type = "group",
        name = L["Event Manager"] or "Event Manager",
        order = 200,
        args = {
            showStats = {
                type = "toggle",
                name = L["EventManagerShowStats"] or "Show Event Statistics",
                desc = L["EventManagerShowStatsDesc"] or "Show event statistics in chat",
                order = 1,
                get = function() return self:GetSetting("global", "eventManagerShowStats") end,
                set = function(_, value) self:SetSetting("global", "eventManagerShowStats", value) end
            },
            performanceMode = {
                type = "toggle",
                name = L["performanceMode"] or "Enable Performance Monitoring",
                desc = L["performanceModeDesc"] or "Track and log EventManager performance statistics (events/sec, handlers/sec) every 5 seconds for debugging",
                order = 2,
                get = function() return self:GetSetting("global", "eventManagerEnableMonitoring") end,
                set = function(_, value) self:SetSetting("global", "eventManagerEnableMonitoring", value) end
            },
            dumpEventStats = {
                type = "execute",
                name = L["dumpEventStats"] or "Dump Event Statistics",
                desc = L["dumpEventStatsDesc"] or "Print detailed event statistics to chat",
                order = 3,
                func = function() self:PrintEventStats() end
            },
            dumpModuleRegistrations = {
                type = "execute",
                name = L["dumpModuleRegistrations"] or "Dump Module Registrations",
                desc = L["dumpModuleRegistrationsDesc"] or "Print detailed module registration information to chat",
                order = 4,
                func = function() self:PrintModuleRegistrations() end
            },
            dumpPerformanceStats = {
                type = "execute",
                name = L["dumpPerformanceStats"] or "Dump Performance Statistics",
                desc = L["dumpPerformanceStatsDesc"] or "Print detailed performance statistics to chat",
                order = 5,
                func = function() self:PrintPerformanceStats() end
            },
            dumpMessageStats = {
                type = "execute",
                name = L["dumpMessageStats"] or "Dump Message Statistics",
                desc = L["dumpMessageStatsDesc"] or "Print message usage statistics to chat",
                order = 6,
                func = function() self:PrintMessageStats() end
            },
            dumpMessageRegistry = {
                type = "execute",
                name = L["dumpMessageRegistry"] or "Dump Message Registry",
                desc = L["dumpMessageRegistryDesc"] or "Print the complete message registry with documentation",
                order = 7,
                func = function() self:PrintMessageRegistry() end
            },
            showStartupPhase = {
                type = "execute",
                name = L["showStartupPhase"] or "Show Startup Phase",
                desc = L["showStartupPhaseDesc"] or "Display current startup phase and queued events",
                order = 8,
                func = function() self:ShowStartupPhase() end
            },
            dumpFailedRegistrations = {
                type = "execute",
                name = L["dumpFailedRegistrations"] or "Dump Failed Event Registrations",
                desc = L["dumpFailedRegistrationsDesc"] or "Print events that failed to register (version incompatibility)",
                order = 9,
                func = function() self:PrintFailedEventRegistrations() end
            },
            dumpCLEUInventory = {
                type = "execute",
                name = L["dumpCLEUInventory"] or "Dump CLEU Inventory",
                desc = L["dumpCLEUInventoryDesc"] or "Print active CLEU module/external registrations and owners",
                order = 10,
                func = function() self:PrintCLEURegistrationInventory() end
            },
            dumpEventInventory = {
                type = "execute",
                name = L["dumpEventInventory"] or "Dump Event Inventory",
                desc = L["dumpEventInventoryDesc"] or "Print active centralized event registrations and handler counts",
                order = 11,
                func = function() self:PrintEventRegistrationInventory() end
            },
            dumpDiagnostics = {
                type = "execute",
                name = L["dumpDiagnostics"] or "Dump Diagnostics",
                desc = L["dumpDiagnosticsDesc"] or "Print EventManager diagnostic counters for queueing, batching, registration, and dispatch",
                order = 12,
                func = function() self:PrintDiagnostics() end
            }
        }
    }
end

-- ============================ MESSAGE REGISTRY ============================

--- Message Registry - Centralized message definitions and documentation
--- This provides a single source of truth for all NAG messages
ns.Messages = {
    -- ============================ ROTATION MESSAGES ============================
    ROTATION_CHANGED = "NAG_ROTATION_CHANGED",  -- Unified rotation change message

    -- ============================ DATABASE MESSAGES ============================
    DATABASE_LOADED = "NAG_DATABASE_LOADED",
    EXPANSION_DATA_LOADED = "NAG_EXPANSION_DATA_LOADED",
    VERSION_DATA_SELECTED = "NAG_VERSION_DATA_SELECTED",
    DB_RESET = "NAG_DB_RESET",
    RESET_PRESERVATION_RESTORED = "NAG_RESET_PRESERVATION_RESTORED",

    -- ============================ SYSTEM MESSAGES ============================
    STARTUP_COMPLETE = "NAG_STARTUP_COMPLETE",

    -- ============================ UI/DISPLAY MESSAGES ============================
    FRAME_UPDATED = "NAG_FRAME_UPDATED",
    KEYBIND_SETTING_CHANGED = "NAG_KEYBIND_SETTING_CHANGED",

    -- ============================ PLAYER STATE MESSAGES ============================
    SPEC_UPDATED = "NAG_SPEC_UPDATED",
    PET_STATE_CHANGED = "NAG_PET_STATE_CHANGED",
    TALENTS_UPDATED = "NAG_TALENTS_UPDATED",
    GROUP_ROSTER_UPDATED = "NAG_GROUP_ROSTER_UPDATED",
    EQUIPMENT_CHANGED = "NAG_EQUIPMENT_CHANGED",
    ASSIGNMENT_CHANGED = "NAG_ASSIGNMENT_CHANGED",

    -- ============================ COMBAT MESSAGES ============================
    SPELL_CAST_SUCCEEDED = "NAG_SPELL_CAST_SUCCEEDED",
    SPELL_LEARNED = "NAG_SPELL_LEARNED",
    MOB_COUNT_CHANGED = "NAG_MOB_COUNT_CHANGED",
    COMBAT_STATE_CHANGED = "NAG_COMBAT_STATE_CHANGED",

    -- ============================ WHITELIST MESSAGES ============================
    WHITELIST_CHANGED = "NAG_WHITELIST_CHANGED",
    WHITELIST_BATCH_CHANGED = "NAG_WHITELIST_BATCH_CHANGED",
    WHITELIST_CLEARED = "NAG_WHITELIST_CLEARED",

    -- ============================ SPELLBOOK MESSAGES ============================
    -- Informational messages (no receivers expected)

    -- ============================ SETTINGS MESSAGES ============================
    SETTING_CHANGED = "NAG_SETTING_CHANGED",
}

--- Message metadata providing detailed documentation
EventManager.MESSAGE_METADATA = {
    [ns.Messages.ROTATION_CHANGED] = {
        description = "Rotation changed (data, selection, or both)",
        payload = "{ specIndex: number, rotationName: string, dataChanged: boolean, selectionChanged: boolean, action: string, autoRotationToggled: boolean }",
        senders = { "ClassBase", "RotationManager", "NAG", "MinimapSelector", "ImportExport" },
        category = "rotation",
    },
    [ns.Messages.DATABASE_LOADED] = {
        description = "AceDB database initialized and ready",
        payload = "nil",
        senders = { "OptionsManager" },
        category = "database",
    },
    [ns.Messages.EXPANSION_DATA_LOADED] = {
        description = "Expansion/version data loaded from data files",
        payload = "nil",
        senders = { "DataManager" },
        category = "database",
    },
    [ns.Messages.VERSION_DATA_SELECTED] = {
        description = "Expansion version data selected and loaded",
        payload = "nil",
        senders = { "DataLoader" },
        category = "database",
    },
    [ns.Messages.DB_RESET] = {
        description = "Database reset performed",
        payload = "string (resetType: 'all', 'global', 'char', 'class')",
        senders = { "ResetManager" },
        category = "database",
    },
    [ns.Messages.RESET_PRESERVATION_RESTORED] = {
        description = "Preservation data restored after database reset",
        payload = "string (resetType)",
        senders = { "ResetManager" },
        category = "database",
        informational = true,
    },
    [ns.Messages.STARTUP_COMPLETE] = {
        description = "Addon startup complete - all systems initialized and ready",
        payload = "nil",
        senders = { "EventManager" },
        category = "system",
        informational = false,
    },
    [ns.Messages.FRAME_UPDATED] = {
        description = "Display frame updated (position, visibility, etc)",
        payload = "nil",
        senders = { "DisplayManager" },
        category = "display",
    },
    [ns.Messages.KEYBIND_SETTING_CHANGED] = {
        description = "Keybind display setting changed",
        payload = "string (settingName), any (newValue)",
        senders = { "KeybindManager", "ActionSlotManager" },
        category = "display",
    },
    [ns.Messages.SPEC_UPDATED] = {
        description = "Player specialization changed",
        payload = "{ specIndex: number, specName: string }",
        senders = { "StateManager" },
        category = "player",
    },
    [ns.Messages.PET_STATE_CHANGED] = {
        description = "Pet summoned/dismissed or changed",
        payload = "boolean (active), number (npcId), string (name)",
        senders = { "StateManager" },
        category = "player",
    },
    [ns.Messages.TALENTS_UPDATED] = {
        description = "Player talents changed",
        payload = "nil",
        senders = { "StateManager" },
        category = "player",
    },
    [ns.Messages.GROUP_ROSTER_UPDATED] = {
        description = "Group composition changed",
        payload = "{ inRaid: boolean, inGroup: boolean, raidSize: number, groupSize: number }",
        senders = { "StateManager" },
        category = "player",
        informational = true,
    },
    [ns.Messages.EQUIPMENT_CHANGED] = {
        description = "Equipment changed (any slot)",
        payload = "{ slot: number, hasCurrent: boolean, timestamp: number }",
        senders = { "StateManager" },
        category = "player",
    },
    [ns.Messages.SPELL_CAST_SUCCEEDED] = {
        description = "Spell cast succeeded",
        payload = "string (unit), string (castGUID), number (spellId), string (spellName)",
        senders = { "StateManager" },
        category = "combat",
    },
    [ns.Messages.MOB_COUNT_CHANGED] = {
        description = "Mob count changed (total and/or melee)",
        payload = "{ total: number, melee: number, oldTotal: number, oldMelee: number }",
        senders = { "TTDManager" },
        category = "combat",
    },
    [ns.Messages.COMBAT_STATE_CHANGED] = {
        description = "Combat state changed (entering/leaving combat)",
        payload = "{ inCombat: boolean, timestamp: number }",
        senders = { "StateManager" },
        category = "combat",
    },
    [ns.Messages.ASSIGNMENT_CHANGED] = {
        description = "Class assignment toggle changed",
        payload = "{ assignmentId: string, enabled: boolean }",
        senders = { "ClassBase" },
        category = "player",
    },
    [ns.Messages.WHITELIST_CHANGED] = {
        description = "Single whitelist entry changed",
        payload = "string (type), number (id), string (hotkey)",
        senders = { "ActionSlotManager" },
        category = "whitelist",
    },
    [ns.Messages.WHITELIST_BATCH_CHANGED] = {
        description = "Multiple whitelist entries changed",
        payload = "table (overrides)",
        senders = { "ActionSlotManager", "KeybindManager" },
        category = "whitelist",
    },
    [ns.Messages.WHITELIST_CLEARED] = {
        description = "Whitelist cleared",
        payload = "string (type: 'spell', 'item', 'all')",
        senders = { "ActionSlotManager" },
        category = "whitelist",
    },
}

--- Initialize message tracking
EventManager.messageStats = {}
EventManager.messageSenders = {}
EventManager.messageReceivers = {}

--- Tracks a message being sent
--- @param messageName string The message name
--- @param sender string The sender module name
function EventManager:TrackMessageSent(messageName, sender)
    if not self.messageStats[messageName] then
        self.messageStats[messageName] = { sent = 0, received = 0, lastSent = 0 }
    end
    self.messageStats[messageName].sent = self.messageStats[messageName].sent + 1
    self.messageStats[messageName].lastSent = GetTime()

    if not self.messageSenders[messageName] then
        self.messageSenders[messageName] = {}
    end
    self.messageSenders[messageName][sender] = true
    if UnitAffectingCombat and not UnitAffectingCombat("player") then
        self.diagnostics.idleMessagesSent = (self.diagnostics.idleMessagesSent or 0) + 1
        self.diagnostics.idleMessageByName[messageName] = (self.diagnostics.idleMessageByName[messageName] or 0) + 1
    end
end

--- Tracks a message being received
--- @param messageName string The message name
--- @param receiver string The receiver module name
function EventManager:TrackMessageReceived(messageName, receiver)
    if not self.messageStats[messageName] then
        self.messageStats[messageName] = { sent = 0, received = 0, lastSent = 0 }
    end
    self.messageStats[messageName].received = self.messageStats[messageName].received + 1

    if not self.messageReceivers[messageName] then
        self.messageReceivers[messageName] = {}
    end
    self.messageReceivers[messageName][receiver] = true
    if UnitAffectingCombat and not UnitAffectingCombat("player") then
        self.diagnostics.idleMessagesReceived = (self.diagnostics.idleMessagesReceived or 0) + 1
    end
end

--- Prints message statistics
function EventManager:PrintMessageStats()
    print("|cFF00FF00=== MESSAGE STATISTICS ===|r")

    for messageName, stats in pairs(self.messageStats) do
        local senderCount = self.messageSenders[messageName] and TableUtils.Size(self.messageSenders[messageName]) or 0
        local receiverCount = self.messageReceivers[messageName] and TableUtils.Size(self.messageReceivers[messageName]) or 0

        print(format("|cFF00FF00%s: %d sent, %d received, %d senders, %d receivers|r",
            messageName, stats.sent, stats.received, senderCount, receiverCount))
    end
end

--- Prints message registry information
function EventManager:PrintMessageRegistry()
    print("|cFF00FF00=== MESSAGE REGISTRY ===|r")
    print("")

    local categories = {}
    for messageName, metadata in pairs(self.MESSAGE_METADATA) do
        local category = metadata.category or "other"
        if not categories[category] then
            categories[category] = {}
        end
        tinsert(categories[category], { name = messageName, metadata = metadata })
    end

    for category, messages in pairs(categories) do
        print(format("|cFF00FF00=== %s MESSAGES ===|r", strupper(category)))
        for _, msgInfo in ipairs(messages) do
            print(format("|cFF00FF00%s|r", msgInfo.name))
            print(format("  Description: %s", msgInfo.metadata.description))
            print(format("  Payload: %s", msgInfo.metadata.payload))
            print(format("  Senders: %s", concat(msgInfo.metadata.senders, ", ")))
        end
        print("")
    end
end

-- ============================ EXPORT ============================
