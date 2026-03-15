--- @module "NAG.CLEUDebugger"
--- Debug utilities for monitoring Combat Log Event Unfiltered (CLEU) events.
---
--- Provides a module for filtering and logging CLEU events based on various
--- conditions and parameters.
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access

--- @type OptionsFactory
local OptionsFactory
local WoWAPI = ns.WoWAPI



local L = ns.AceLocale:GetLocale("NAG", true)

local AceConfigRegistry = ns.AceConfigRegistry
local AceGUI = ns.AceGUI


-- Lua APIs (using WoW's optimized versions where available)
local format = string.format -- WoW's optimized version if available
local UnitGUID = _G.UnitGUID
local IsShiftKeyDown = _G.IsShiftKeyDown
local IsAltKeyDown = _G.IsAltKeyDown
local IsControlKeyDown = _G.IsControlKeyDown


-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~
-- Default settings
local defaults = {
    global = {
        filters = {
            excludeCommon = false,
            excludedEvents = {},
            sourceUnit = "any",
            destUnit = "any",
            outputMode = "DEBUG",    -- Default to Debug output
            fullEventLogging = false -- New option for full event logging
        }
    },
    class = {
        spellIDs = {},
        enabled = {}
    }
}

-- Output mode constants
local OUTPUT_MODES = {
    DEBUG = "DEBUG",
    CHAT = "CHAT",
    BOTH = "BOTH"
}

--- @class CLEUDebugger: DebugModule
local CLEUDebugger = NAG:CreateModule("CLEUDebugger", defaults, {
    moduleType = ns.MODULE_TYPES.DEBUG,
    -- Hide this module's options unless debug mode is enabled
    hidden = function() return not NAG:IsDevModeEnabled() end,
    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.DEBUG,
        ns.DEBUG_CATEGORIES.EVENTS
    },
    -- ZERO-BOILERPLATE: Declarative CLEU handlers
    cleuHandlers = {
        ["*"] = "HandleCLEUEvent",
    },

    -- Slash commands using zero-boilerplate pattern
    slashCommands = {
        ["cleudebug"] = {
            handler = "HandleCLEUDebugSlashCommand",
            help = "Toggle CLEU Debugger on/off. Usage: /nagdebug cleudebug",
            root = "nagdebug",
            category = "Debug"
        },
        ["trackspell"] = {
            handler = "HandleTrackSpellSlashCommand",
            help = "Track a spell ID. Usage: /nagdebug trackspell <spellId>",
            root = "nagdebug",
            category = "Debug"
        }
    }
})
local module = CLEUDebugger
ns.CLEUDebugger = CLEUDebugger

-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~
do
    --- Initialize the module

    --- @param self CLEUDebugger
    function CLEUDebugger:ModuleInitialize()
        -- ============================ MODULE ASSIGNMENT ============================
        -- Assign Ace3 modules directly (no metatable access)
        OptionsFactory = NAG:GetModule("OptionsFactory")

        -- Slash commands are now handled via zero-boilerplate slashCommands table
    end

    --- Enable the module
    --- @param self CLEUDebugger
    function CLEUDebugger:ModuleEnable()
        -- ZERO-BOILERPLATE: Events are automatically registered via declarative patterns


        -- ============================ MODULE INITIALIZATION ============================
    end

    --- Disable the module
    --- @param self CLEUDebugger
    function CLEUDebugger:ModuleDisable()
    end
end

-- ~~~~~~~~~~ EVENT HANDLERS ~~~~~~~~~~
--- Handle centralized CLEU events
function CLEUDebugger:HandleCLEUEvent(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
    sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID, spellName, spellSchool, auraType, ...)
    local filters = {
        excludeCommon = self.db.global.filters.excludeCommon,
        excludedEvents = self.db.global.filters.excludedEvents,
        sourceUnit = self.db.global.filters.sourceUnit,
        destUnit = self.db.global.filters.destUnit,
        fullEventLogging = self.db.global.filters.fullEventLogging,
    }
    local spellIDs = self.db.class.spellIDs
    local enabled = self.db.class.enabled

    -- Check if event should be excluded
    if filters.excludeCommon and filters.excludedEvents[subEvent] then
        if self.debug then self:Debug("Excluded event: %s", subEvent) end
        return
    end
    -- Apply source unit filter
    if filters.sourceUnit and filters.sourceUnit ~= "any" then
        if filters.sourceUnit == "player" and (sourceGUID ~= UnitGUID("player")) then
            return
        elseif filters.sourceUnit == "target" and (sourceGUID ~= UnitGUID("target")) then
            return
        end
    end
    -- Apply destination unit filter
    if filters.destUnit and filters.destUnit ~= "any" then
        if filters.destUnit == "player" and (destGUID ~= UnitGUID("player")) then
            return
        elseif filters.destUnit == "target" and (destGUID ~= UnitGUID("target")) then
            return
        end
    end
    -- Decide whether to log this event:
    -- - fullEventLogging: log everything (covers SWING/non-spell events)
    -- - otherwise: require spellID and (no specific filter) or explicitly enabled tracking
    local shouldLog = false
    if filters.fullEventLogging then
        shouldLog = true
    elseif spellID and (not next(spellIDs) or (spellIDs[spellID] and enabled[spellID])) then
        shouldLog = true
    end

    if shouldLog then
        local msg
        if filters.fullEventLogging then
            msg = self:FormatFullEvent(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
                sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID, spellName, spellSchool, auraType, ...)
        else
            msg = format("CLEU: %s | Source: %s | Dest: %s | SpellID: %s | SpellName: %s", subEvent, sourceName or "nil",
                destName or "nil", spellID or "nil", spellName or "nil")
        end
        -- Add to UI log
        table.insert(self._eventLog, 1, msg)
        if #self._eventLog > self._maxLog then table.remove(self._eventLog) end
        -- Output to chat/debug log
        self:OutputMessage(msg)
    end
end

-- ~~~~~~~~~~ MESSAGE HANDLERS ~~~~~~~~~~
-- (none)

-- ~~~~~~~~~~ OPTIONS UI ~~~~~~~~~~
do
    --- Gets the options table for CLEU Debugger settings

    --- @param self CLEUDebugger
    --- @return table The options table for AceConfig
    function CLEUDebugger:GetOptions()
        -- Ace3-compliant group table for options UI
        return {
            type = "group",
            name = function() return L["CLEUDebugger"] or "CLEU Debugger" end,
            order = 31,
            args = {
                enableModule = OptionsFactory:CreateToggle(
                    function() return L["enableModule"] or "Enable Debugger" end,
                    function() return L["enableModuleDesc"] or "Enable or disable the CLEU Debugger module" end,
                    function() return self:IsEnabled() end,
                    function(_, value)
                        if value then
                            self:Enable()
                        else
                            self:Disable()
                        end
                    end,
                    { order = 0 }
                ),
                filters = {
                    type = "group",
                    name = function(info) return L[info[#info]] or info[#info] end,
                    desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                    order = 5,
                    inline = true,
                    args = {
                        outputMode = OptionsFactory:CreateSelect(
                            function() return L["outputMode"] or "Output Mode" end,
                            function() return L["outputModeDesc"] or "Select where to output CLEU messages" end,
                            function() return self:GetSetting("global", "filters.outputMode") end,
                            function(_, value) self:SetSetting("global", "filters.outputMode", value) end,
                            {
                                order = 0,
                                values = {
                                    [OUTPUT_MODES.DEBUG] = L["debugOutput"] or "Debug Only",
                                    [OUTPUT_MODES.CHAT] = L["chatOutput"] or "Chat Only",
                                    [OUTPUT_MODES.BOTH] = L["bothOutput"] or "Debug and Chat",
                                }
                            }
                        ),
                        excludeCommon = OptionsFactory:CreateToggle(
                            function() return L["excludeCommon"] or "excludeCommon" end,
                            function() return L["excludeCommonDesc"] or "" end,
                            function() return self:GetSetting("global", "filters.excludeCommon") end,
                            function(_, value) self:SetSetting("global", "filters.excludeCommon", value) end,
                            { order = 1 }
                        ),
                        sourceUnit = OptionsFactory:CreateSelect(
                            function() return L["sourceUnit"] or "sourceUnit" end,
                            function() return L["sourceUnitDesc"] or "" end,
                            function() return self:GetSetting("global", "filters.sourceUnit") end,
                            function(_, value) self:SetSetting("global", "filters.sourceUnit", value) end,
                            {
                                order = 2,
                                values = {
                                    ["any"] = L["any"] or "Any",
                                    ["player"] = L["player"] or "Player",
                                    ["target"] = L["target"] or "Target",
                                }
                            }
                        ),
                        destUnit = OptionsFactory:CreateSelect(
                            function() return L["destUnit"] or "destUnit" end,
                            function() return L["destUnitDesc"] or "" end,
                            function() return self:GetSetting("global", "filters.destUnit") end,
                            function(_, value) self:SetSetting("global", "filters.destUnit", value) end,
                            {
                                order = 3,
                                values = {
                                    ["any"] = L["any"] or "Any",
                                    ["player"] = L["player"] or "Player",
                                    ["target"] = L["target"] or "Target",
                                }
                            }
                        ),
                        spellIDsHeader = OptionsFactory:CreateHeader(
                            function() return L["spellIDsHeader"] or "Tracked Spell IDs" end,
                            { order = 4 }
                        ),
                        addSpellID = OptionsFactory:CreateInput(
                            function() return L["addSpellID"] or "Add Spell ID" end,
                            function() return L["addSpellIDDesc"] or "Enter a spell ID to track" end,
                            function() return "" end,
                            function(_, value)
                                local spellID = tonumber(value)
                                if spellID then
                                    self:AddSpellID(spellID)
                                end
                            end,
                            { order = 5 }
                        ),
                        trackedSpellIDs = OptionsFactory:CreateMultiSelect(
                            function() return L["trackedSpellIDs"] or "Tracked Spells" end,
                            function() return L["trackedSpellIDsDesc"] or "Toggle or remove tracked spells" end,
                            function(_, key)
                                local enabled = self:GetSetting("class", "enabled")
                                return enabled[key]
                            end,
                            function(_, key, value)
                                if IsShiftKeyDown() then
                                    -- Remove spell if shift is held
                                    self:RemoveSpellID(key)
                                else
                                    -- Toggle spell tracking
                                    self:ToggleSpellID(key)
                                end
                            end,
                            {
                                order = 6,
                                values = function()
                                    local spells = {}
                                    local spellIDs = self:GetSetting("class", "spellIDs")
                                    for spellID, spellName in pairs(spellIDs) do
                                        spells[spellID] = format("%s (%d)", spellName, spellID)
                                    end
                                    return spells
                                end
                            }
                        ),
                        clearSpellIDs = OptionsFactory:CreateExecute(
                            function() return L["clearSpellIDs"] or "Clear All Tracked Spells" end,
                            function() return L["clearSpellIDsDesc"] or "Remove all tracked spell IDs" end,
                            function()
                                self:SetSetting("class", "spellIDs", {})
                                self:SetSetting("class", "enabled", {})
                            end,
                            { order = 7 }
                        ),
                        excludedEventsHeader = OptionsFactory:CreateHeader(
                            function() return L["excludedEventsHeader"] or "excludedEventsHeader" end,
                            { order = 8 }
                        ),
                        addExcludedEvent = OptionsFactory:CreateInput(
                            function() return L["addExcludedEvent"] or "addExcludedEvent" end,
                            function() return L["addExcludedEventDesc"] or "" end,
                            function() return "" end,
                            function(_, value)
                                if value and value ~= "" then
                                    local excludedEvents = self:GetSetting("global", "filters.excludedEvents")
                                    excludedEvents[value] = true
                                    self:SetSetting("global", "filters.excludedEvents", excludedEvents)
                                end
                            end,
                            { order = 9 }
                        ),
                        excludedEventsList = OptionsFactory:CreateMultiSelect(
                            function() return L["excludedEventsList"] or "excludedEventsList" end,
                            function() return L["excludedEventsListDesc"] or "" end,
                            function(_, key)
                                local excludedEvents = self:GetSetting("global", "filters.excludedEvents")
                                return excludedEvents[key]
                            end,
                            function(_, key, value)
                                if not value then
                                    local excludedEvents = self:GetSetting("global", "filters.excludedEvents")
                                    excludedEvents[key] = nil
                                    self:SetSetting("global", "filters.excludedEvents", excludedEvents)
                                end
                            end,
                            {
                                order = 10,
                                values = function()
                                    local events = {}
                                    local excludedEvents = self:GetSetting("global", "filters.excludedEvents")
                                    for event in pairs(excludedEvents) do
                                        events[event] = event
                                    end
                                    return events
                                end
                            }
                        ),
                        fullEventLogging = OptionsFactory:CreateToggle(
                            function() return L["fullEventLogging"] or "Full Event Logging" end,
                            function() return L["fullEventLoggingDesc"] or "Log all available CLEU event parameters" end,
                            function() return self:GetSetting("global", "filters.fullEventLogging") end,
                            function(_, value) self:SetSetting("global", "filters.fullEventLogging", value) end,
                            { order = 1.5 } -- Place it near the top
                        ),
                    }
                },
                developer = {
                    type = "group",
                    name = L["DeveloperOptions"] or "Developer Options",
                    order = 50,
                    inline = true,
                    args = {
                        enableModule = OptionsFactory:CreateToggle(
                            function() return L["enableModule"] or "Enable Debugger" end,
                            function() return L["enableModuleDesc"] or "Enable or disable the CLEU Debugger module" end,
                            function() return self:IsEnabled() end,
                            function(_, value)
                                if value then
                                    self:Enable()
                                else
                                    self:Disable()
                                end
                            end,
                            { order = 0 }
                        ),
                    }
                }
            }
        }
    end
end

-- ~~~~~~~~~~ HELPERS & PUBLIC API ~~~~~~~~~~
--- Add a spell ID to track
--- @param self CLEUDebugger
--- @param spellID number The spell ID to track
function CLEUDebugger:AddSpellID(spellID)
    if not spellID then return end
    local spellInfo = WoWAPI.GetSpellInfo(spellID)
    local spellName = spellInfo and spellInfo.name
    local spellIDs = self.db.class.spellIDs
    local enabled = self.db.class.enabled

    spellIDs[spellID] = spellName or tostring(spellID)
    enabled[spellID] = true

    self:SetSetting("class", "spellIDs", spellIDs)
    self:SetSetting("class", "enabled", enabled)

    if self.debug then self:Debug("Added spell ID %d (%s) to tracking", spellID, spellName or "Unknown") end
end

--- Remove a spell ID from tracking
--- @param self CLEUDebugger
--- @param spellID number The spell ID to remove
function CLEUDebugger:RemoveSpellID(spellID)
    if not spellID then return end
    local spellIDs = self.db.class.spellIDs
    local enabled = self.db.class.enabled

    local spellName = spellIDs[spellID]
    spellIDs[spellID] = nil
    enabled[spellID] = nil

    self:SetSetting("class", "spellIDs", spellIDs)
    self:SetSetting("class", "enabled", enabled)

    if self.debug then self:Debug("Removed spell ID %d (%s) from tracking", spellID, spellName or "Unknown") end
end

--- Toggle tracking for a spell ID
--- @param self CLEUDebugger
--- @param spellID number The spell ID to toggle
function CLEUDebugger:ToggleSpellID(spellID)
    if not spellID then return end
    local spellIDs = self.db.class.spellIDs
    local enabled = self.db.class.enabled

    enabled[spellID] = not enabled[spellID]

    self:SetSetting("class", "enabled", enabled)

    local spellName = spellIDs[spellID]
    if self.debug then
        self:Debug("Toggled spell ID %d (%s) to %s", spellID, spellName or "Unknown",
            tostring(enabled[spellID]))
    end
end

--- Output a CLEU message based on the selected output mode
--- @param self CLEUDebugger
--- @param message string The message to output
function CLEUDebugger:OutputMessage(message)
    local mode = self.db.global.filters.outputMode

    if mode == OUTPUT_MODES.DEBUG or mode == OUTPUT_MODES.BOTH then
        self:DebugLog("CLEU", message)
    end

    if mode == OUTPUT_MODES.CHAT or mode == OUTPUT_MODES.BOTH then
        self:Print(message)
    end
end

--- Format a full CLEU event for logging
--- @param self CLEUDebugger
--- @param ... any The CLEU event parameters
--- @return string The formatted event string
function CLEUDebugger:FormatFullEvent(...)
    local timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags,
    destGUID, destName, destFlags, destRaidFlags = ...

    -- Base event information that's always present
    local parts = {
        format("Event: %s", event or "nil"),
        format("Time: %.3f", timestamp or 0),
        format("Source: %s (%s)", sourceName or "nil", sourceGUID or "nil"),
        format("SourceFlags: 0x%x", sourceFlags or 0),
        format("SourceRaidFlags: 0x%x", sourceRaidFlags or 0),
        format("Dest: %s (%s)", destName or "nil", destGUID or "nil"),
        format("DestFlags: 0x%x", destFlags or 0),
        format("DestRaidFlags: 0x%x", destRaidFlags or 0)
    }

    -- Handle different event types
    if event then
        if event:match("^SPELL_") or event:match("^RANGE_") then
            -- Spell/Range events have spell information
            local spellID, spellName, spellSchool = select(12, ...)
            if spellID then
                table.insert(parts, format("SpellID: %d", spellID))
                table.insert(parts, format("SpellName: %s", spellName or "nil"))
                table.insert(parts, format("SpellSchool: %d", spellSchool or 0))
            end

            -- Additional parameters for damage/heal events
            if event:match("_DAMAGE$") then
                local amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand =
                    select(15, ...)
                if amount then
                    table.insert(parts, format("Amount: %d", amount))
                    if overkill and overkill > 0 then table.insert(parts, format("Overkill: %d", overkill)) end
                    if school then table.insert(parts, format("School: %d", school)) end
                    if resisted and resisted > 0 then table.insert(parts, format("Resisted: %d", resisted)) end
                    if blocked and blocked > 0 then table.insert(parts, format("Blocked: %d", blocked)) end
                    if absorbed and absorbed > 0 then table.insert(parts, format("Absorbed: %d", absorbed)) end
                    if critical then table.insert(parts, "Critical") end
                    if glancing then table.insert(parts, "Glancing") end
                    if crushing then table.insert(parts, "Crushing") end
                    if isOffHand then table.insert(parts, "OffHand") end
                end
            elseif event:match("_HEAL$") then
                local amount, overhealing, absorbed, critical = select(15, ...)
                if amount then
                    table.insert(parts, format("Heal: %d", amount))
                    if overhealing and overhealing > 0 then
                        table.insert(parts,
                            format("Overheal: %d", overhealing))
                    end
                    if absorbed and absorbed > 0 then table.insert(parts, format("Absorbed: %d", absorbed)) end
                    if critical then table.insert(parts, "Critical") end
                end
            end
        elseif event:match("^SWING_") then
            -- Swing events have no spell information, but may have damage info
            if event == "SWING_DAMAGE" then
                local amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing, isOffHand =
                    select(12, ...)
                if amount then
                    table.insert(parts, format("Amount: %d", amount))
                    if overkill and overkill > 0 then table.insert(parts, format("Overkill: %d", overkill)) end
                    if school then table.insert(parts, format("School: %d", school)) end
                    if resisted and resisted > 0 then table.insert(parts, format("Resisted: %d", resisted)) end
                    if blocked and blocked > 0 then table.insert(parts, format("Blocked: %d", blocked)) end
                    if absorbed and absorbed > 0 then table.insert(parts, format("Absorbed: %d", absorbed)) end
                    if critical then table.insert(parts, "Critical") end
                    if glancing then table.insert(parts, "Glancing") end
                    if crushing then table.insert(parts, "Crushing") end
                    if isOffHand then table.insert(parts, "OffHand") end
                end
            end
        elseif event:match("^ENVIRONMENTAL_") then
            -- Environmental events have their own format
            local environmentalType = select(12, ...)
            local amount, overkill, school, resisted, blocked, absorbed, critical = select(13, ...)
            if environmentalType then
                table.insert(parts, format("Type: %s", environmentalType))
                if amount then
                    table.insert(parts, format("Amount: %d", amount))
                    if overkill and overkill > 0 then table.insert(parts, format("Overkill: %d", overkill)) end
                    if school then table.insert(parts, format("School: %d", school)) end
                    if resisted and resisted > 0 then table.insert(parts, format("Resisted: %d", resisted)) end
                    if blocked and blocked > 0 then table.insert(parts, format("Blocked: %d", blocked)) end
                    if absorbed and absorbed > 0 then table.insert(parts, format("Absorbed: %d", absorbed)) end
                    if critical then table.insert(parts, "Critical") end
                end
            end
        end
    end

    return table.concat(parts, " | ")
end

--- Handler for /nagcleudebug slash command
--- @param self CLEUDebugger
--- @param input string
function CLEUDebugger:HandleCLEUDebugSlashCommand(input)
    self:ShowDebugFrame()
end

--- Handler for /nagtrackspell slash command
--- @param self CLEUDebugger
--- @param input string
function CLEUDebugger:HandleTrackSpellSlashCommand(input)
    local spellID = tonumber(input)
    if spellID then
        self:AddSpellID(spellID)
        if not self:IsEnabled() then
            self:Enable()
        end
        local spellInfo = WoWAPI.GetSpellInfo(spellID)
        self:Info(format("Now tracking spell ID: %d (%s)", spellID, spellInfo and spellInfo.name or "Unknown"))
    else
        self:Print("Usage: /nagtrackspell spellId")
    end
end

-- Store recent CLEU events for debug UI
CLEUDebugger._eventLog = CLEUDebugger._eventLog or {}
CLEUDebugger._maxLog = 100

function CLEUDebugger:GetDebugSections()
    local function eventLogSection()
        local lines = {}
        for i = 1, math.min(#self._eventLog, 50) do
            table.insert(lines, self._eventLog[i])
        end
        if #lines == 0 then table.insert(lines, "No events logged yet.") end
        return lines
    end
    return {
        { header = "Recent CLEU Events", dataFn = eventLogSection },
    }
end

function CLEUDebugger:GetDebugControls()
    return {
        {
            type = "input",
            label = "Track Spell ID",
            defaultText = "",
            width = 120,
            onChange = function(value)
                local spellID = tonumber(value)
                if spellID then
                    self:AddSpellID(spellID)
                    if self.debugFrame and self.debugFrame.SetInputFieldText then
                        self.debugFrame:SetInputFieldText("")
                    end
                    if self.debugFrame and self.debugFrame.UpdateDebugFrame then
                        self.debugFrame:UpdateDebugFrame()
                    end
                end
            end
        },
        {
            type = "dropdown",
            label = "Output Mode",
            values = { DEBUG = "Debug Only", CHAT = "Chat Only", BOTH = "Debug and Chat" },
            getValue = function() return self.db.global.filters.outputMode end,
            setValue = function(value)
                self:SetSetting("global", "filters.outputMode", value)
            end,
            width = 140
        },
        {
            type = "toggle",
            label = "Full Event Logging",
            getValue = function() return self.db.global.filters.fullEventLogging end,
            setValue = function(value)
                self:SetSetting("global", "filters.fullEventLogging", value)
                if self.debugFrame and self.debugFrame.UpdateDebugFrame then
                    self.debugFrame:UpdateDebugFrame()
                end
            end
        },
        {
            type = "button",
            text = "Clear Log",
            width = 80,
            onClick = function()
                wipe(self._eventLog)
                if self.debugFrame and self.debugFrame.UpdateDebugFrame then
                    self.debugFrame:UpdateDebugFrame()
                end
            end
        }
    }
end

function CLEUDebugger:ShowDebugFrame()
    ns.DebugFrameUtil:ShowDebugFrame(self, {
        title = "CLEU Debugger",
        sections = function() return self:GetDebugSections() end,
        customControls = self:GetDebugControls(),
        refreshInterval = 0.5,
    })
end
