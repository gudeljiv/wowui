--- @module "NAG.DisplayBroadcaster"
--- Broadcasts spell IDs from display groups via addon messages
---
--- This module fetches the current display group data and broadcasts
--- the spell/item IDs to other players via addon messages.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

--- ======= LOCALIZE =======
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access

--- @type OptionsFactory
local OptionsFactory

local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)

-- WoW API
local C_ChatInfo = C_ChatInfo
local GetTime = _G.GetTime
local UnitName = _G.UnitName

-- Lua APIs (using WoW's optimized versions where available)
local format = string.format
local strjoin = strjoin
local tinsert = tinsert
local wipe = wipe

-- Constants
local ADDON_PREFIX = "NAG_DISPLAY"
local BROADCAST_INTERVAL = 0.25 -- Broadcast every 250ms
local MAX_MESSAGE_LENGTH = 200  -- Safe limit for addon message payload (leaving room for prefix)

-- Group-specific prefixes for separate messages
local GROUP_PREFIXES = {
    main = "NAG_MAIN",
    aoe = "NAG_AOE",
    cooldowns = "NAG_COOLDOWNS",
    interrupts = "NAG_INTERRUPTS",
    defensives = "NAG_DEFENSIVES",
    sequence = "NAG_SEQUENCE"
}

-- Default settings (minimal, background-only)
local defaults = {
    char = {
        enabled = false,
        broadcastInterval = BROADCAST_INTERVAL
    }
}

--- @class DisplayBroadcaster : CoreModule
local DisplayBroadcaster = NAG:CreateModule("DisplayBroadcaster", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,

    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.DISPLAY,
        ns.DEBUG_CATEGORIES.EVENTS
    },

    -- Slash commands using zero-boilerplate pattern
    slashCommands = {
        ["broadcast"] = {
            handler = "HandleBroadcastSlashCommand",
            help = "Manually broadcast current display data. Usage: /nagdebug broadcast [on|off|now]",
            root = "nagdebug",
            category = "System"
        }
    },


    -- Default state
    defaultState = {
        lastBroadcast = 0,
        lastGroupData = {
            main = {},
            aoe = {},
            cooldowns = {},
            interrupts = {},
            defensives = {},
            sequence = {}
        }
    }
})
local module = DisplayBroadcaster
ns.DisplayBroadcaster = DisplayBroadcaster

-- Module variables
DisplayBroadcaster.broadcastTimer = nil

-- ~~~~~~~~~~ MODULE INITIALIZATION ~~~~~~~~~~

function DisplayBroadcaster:ModuleInitialize()
    -- ============================ MODULE ASSIGNMENT ============================
    -- Assign Ace3 modules directly (no metatable access)
    OptionsFactory = NAG:GetModule("OptionsFactory")

    -- Register addon message prefixes for all groups
    -- Ensure prefixes are registered before any broadcasting attempts
    C_ChatInfo.RegisterAddonMessagePrefix(ADDON_PREFIX)
    for _, prefix in pairs(GROUP_PREFIXES) do
        C_ChatInfo.RegisterAddonMessagePrefix(prefix)
    end

    -- Slash commands are now handled via zero-boilerplate slashCommands table
end

-- Start/stop the broadcaster when the module becomes enabled/disabled
function DisplayBroadcaster:ModuleEnable()
    -- Honor the per-character toggle


    -- ============================ MODULE INITIALIZATION ============================
    if self.db.char.enabled then
        self:StartBroadcasting()
    else
        self:StopBroadcasting()
    end
end

-- Optional explicit disable hook (OnDisable already stops the timer)
function DisplayBroadcaster:ModuleDisable()
    self:StopBroadcasting()
end

function DisplayBroadcaster:OnDisable()
    -- Clean up addon message prefixes to prevent memory leaks
    -- There is no WoW API to unregister an addon message prefix. This is a no-op.

    -- Stop broadcasting timer
    self:StopBroadcasting()

    -- Clear state data
    wipe(self.state.lastGroupData)
    self.state.lastBroadcast = 0
end

-- ~~~~~~~~~~ BROADCASTING LOGIC ~~~~~~~~~~

--- Start the broadcasting timer
function DisplayBroadcaster:StartBroadcasting()
    if self.broadcastTimer then
        self:CancelTimer(self.broadcastTimer)
    end

    local interval = self.db.char.broadcastInterval
    self.broadcastTimer = self:ScheduleRepeatingTimer("BroadcastDisplayData", interval)
end

--- Stop the broadcasting timer
function DisplayBroadcaster:StopBroadcasting()
    if self.broadcastTimer then
        self:CancelTimer(self.broadcastTimer)
        self.broadcastTimer = nil
    end
end

--- Broadcast current display data to self
function DisplayBroadcaster:BroadcastDisplayData()
    if not self.db.char.enabled then
        return
    end

    -- Get current display group data
    local groupData = NAG:GetDisplayGroupIconData()
    if not groupData then
        self:Warn("GetDisplayGroupIconData returned nil")
        return
    end
    if type(groupData) ~= "table" then
        self:Warn("GetDisplayGroupIconData returned invalid type: %s", type(groupData))
        return
    end

    -- Check each group for changes and send separate messages
    for groupName, groupIcons in pairs(groupData) do
        if self:HasGroupDataChanged(groupName, groupIcons) then
            self:SendGroupData(groupName, groupIcons)
            -- Update cached data for this group
            self.state.lastGroupData[groupName] = self:CopyGroupIcons(groupIcons)
        end
    end

    self.state.lastBroadcast = GetTime()
end

--- Check if a specific group's data has changed
--- @param groupName string The name of the group
--- @param newIcons table The new icons for this group
--- @return boolean True if data has changed
function DisplayBroadcaster:HasGroupDataChanged(groupName, newIcons)
    local lastIcons = self.state.lastGroupData[groupName] or {}

    -- Always broadcast if transitioning from empty to filled or vice versa
    local wasEmpty = #lastIcons == 0
    local isEmpty = #newIcons == 0
    if wasEmpty ~= isEmpty then
        return true
    end

    -- Check if number of icons changed
    if #newIcons ~= #lastIcons then
        return true
    end

    -- Check if any spell/item IDs changed
    for i, iconData in ipairs(newIcons) do
        local lastIcon = lastIcons[i] or {}
        if iconData.spellId ~= lastIcon.spellId or iconData.itemId ~= lastIcon.itemId then
            return true
        end
    end

    return false
end

--- Copy group icons to avoid reference issues
--- @param icons table The icons to copy
--- @return table A copy of the icons
function DisplayBroadcaster:CopyGroupIcons(icons)
    local copy = {}
    for i, icon in ipairs(icons) do
        copy[i] = {
            spellId = icon.spellId,
            itemId = icon.itemId
        }
    end
    return copy
end

function DisplayBroadcaster:SendGroupData(groupName, groupIcons)
    local prefix = GROUP_PREFIXES[groupName]
    if type(prefix) ~= "string" then
        self:Warn("Unknown or invalid group name received: %s", tostring(groupName))
        return
    end

    -- Ensure prefix is registered
    if not C_ChatInfo.IsAddonMessagePrefixRegistered(prefix) then
        C_ChatInfo.RegisterAddonMessagePrefix(prefix)
    end

    -- Serialize icons into a string
    local raw = self:SerializeGroupData(groupIcons)
    local message = type(raw) == "string" and raw or table.concat(raw, ",")
    if type(message) ~= "string" or message == "" then
        return
    end

    local chatType = "WHISPER"
    local target = UnitName("player")

    -- SendAddonMessage API changed behavior:
    -- - Patch 10.2.7+ returns Enum.SendAddonMessageResult (0 = success)
    -- - Prior versions returned boolean (true = success)
    -- - Deprecation wrapper may return boolean or multiple values
    -- Use select(-1, ...) to get last return value for forward compatibility
    local result = select(-1, C_ChatInfo.SendAddonMessage(prefix, message, chatType, target))

    -- Check for success: boolean true OR enum code 0
    local isSuccess = (result == true) or (type(result) == "number" and result == 0)

    if not isSuccess then
        -- Failure - log error codes with readable names
        if type(result) == "number" then
            local errorNames = {
                [1] = "InvalidPrefix",
                [2] = "InvalidMessage",
                [3] = "AddonMessageThrottle",
                [4] = "InvalidChatType",
                [5] = "NotInGroup",
                [6] = "TargetRequired",
                [7] = "InvalidChannel",
                [8] = "ChannelThrottle",
                [9] = "GeneralError",
                [10] = "NotInGuild"
            }
            local errorName = errorNames[result] or "Unknown"
            self:Warn("SendAddonMessage failed for group %s: %s (code: %d)", groupName, errorName, result)
        else
            self:Warn("SendAddonMessage failed for group %s: %s (type: %s)", groupName, tostring(result), type(result))
        end
    end
end

--- Serialize group data to simple ID list
--- @param groupIcons table The icons in the group
--- @return string The serialized data (comma-separated IDs or "0" if empty)
function DisplayBroadcaster:SerializeGroupData(groupIcons)
    if #groupIcons == 0 then
        return "0"
    end

    local ids = {}
    for _, iconData in ipairs(groupIcons) do
        if iconData.spellId then
            tinsert(ids, tostring(iconData.spellId))
        elseif iconData.itemId then
            tinsert(ids, "i" .. tostring(iconData.itemId))
        end
    end

    return strjoin(",", ids)
end

-- ~~~~~~~~~~ SLASH COMMAND HANDLER ~~~~~~~~~~

function DisplayBroadcaster:HandleBroadcastSlashCommand(input)
    local command = input:match("^%s*(%S+)")

    if command == "on" then
        self.db.char.enabled = true
        self:StartBroadcasting()
        print("DisplayBroadcaster: Broadcasting enabled")
    elseif command == "off" then
        self.db.char.enabled = false
        self:StopBroadcasting()
        print("DisplayBroadcaster: Broadcasting disabled")
    elseif command == "now" then
        self:BroadcastDisplayData()
        print("DisplayBroadcaster: Manual broadcast sent")
    else
        local enabled = self.db.char.enabled
        local status = enabled and "enabled" or "disabled"
        print(format("DisplayBroadcaster: Currently %s", status))
        print("Usage: /nagbroadcast [on|off|now]")
    end
end

-- ~~~~~~~~~~ OPTIONS MANAGEMENT ~~~~~~~~~~

function DisplayBroadcaster:GetOptions()
    return {
        type = "group",
        name = L["Display Broadcaster"] or "Display Broadcaster",
        desc = L["Configure display broadcasting settings"] or "Configure display broadcasting settings",
        args = {
            enabled = OptionsFactory:CreateToggle(L["enabled"] or "Enable", L["enabledDesc"] or "Enable or disable this module/feature",
                function() return self.db.char.enabled end,
                function(_, value)
                    self.db.char.enabled = value
                    if value then
                        self:StartBroadcasting()
                    else
                        self:StopBroadcasting()
                    end
                end,
                { order = 1 }
            ),
            broadcastInterval = OptionsFactory:CreateRange(L["broadcastInterval"] or "Broadcast Interval", L["broadcastIntervalDesc"] or "How often to broadcast display data (in seconds)",
                function() return self.db.char.broadcastInterval end,
                function(_, value)
                    self.db.char.broadcastInterval = value
                    -- Restart broadcasting with new interval if currently active
                    if self.db.char.enabled and self.broadcastTimer then
                        self:StartBroadcasting()
                    end
                end,
                {
                    order = 2,
                    min = 0.1,
                    max = 2.0,
                    step = 0.05
                }
            ),
            manualBroadcast = OptionsFactory:CreateExecute(L["manualBroadcast"] or "Send Manual Broadcast", L["manualBroadcastDesc"] or "Manually send a broadcast of current display data",
                function()
                    self:BroadcastDisplayData()
                end,
                { order = 3 }
            )
        }
    }
end

-- Make module available globally through NAG
