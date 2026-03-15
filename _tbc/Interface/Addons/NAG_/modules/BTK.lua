--- @module "NAG.BTK"
--- Handles "Bend The Knee" functionality - makes other players kneel or salute when godtier users gain/lose buffs.
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


local AceConfigRegistry = ns.AceConfigRegistry
local L = ns.AceLocale:GetLocale("NAG", true)

-- Lua APIs (using WoW's optimized versions where available)
local GetTime = _G.GetTime
local UnitAffectingCombat = _G.UnitAffectingCombat
local IsInGroup = _G.IsInGroup



-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~
-- Constants
local DEFAULT_TIMER = 90
local GROUP_TIMER_BASE = 900
local GROUP_TIMER_VARIANCE = 40
local SPECIAL_MAP_ID = 1423
local SPECIAL_MAP_TIMER = 180

local EMOTE_CHANCES = {
    NONE = 10,   -- 10% chance to do nothing
    SALUTE = 30, -- 30% chance to salute
    KNEEL = 60   -- 60% chance to kneel
}
local defaults = {
    global = {
        enableBTK = true -- Global toggle to enable/disable BTK functionality
    }
}
--- "Bend The Knee" module for handling automatic emotes when godtier users gain/lose buffs
--- @class BTK:CoreModule
--- @field state table Module state containing lastEmoteTime and disableEmotes toggle
local BTK = NAG:CreateModule("BTK", defaults, {
    -- Event registration using eventHandlers table
    eventHandlers = {
        CHAT_MSG_ADDON = true
    },

    -- Default state (will be properly initialized in ModuleInitialize)
    defaultState = {
        lastEmoteTime = 0,
        disableEmotes = false -- Godtier toggle to disable emotes
    },
    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.FEATURES
    },

    -- Options composers for dynamic options integration
    optionsComposers = {
        ["splash"] = true -- Calls BTK:splash(options, context)
    }
})
local module = BTK
ns.BTK = BTK

-- ~~~~~~~~~~ ORGANIZATION ~~~~~~~~~~
do -- Ace3 lifecycle methods
    function BTK:ModuleEnable()
    end

    function BTK:ModuleDisable()
    end

    --- Initialize the BTK module
    --- Registers addon message prefix and sets initial emote timer
    function BTK:ModuleInitialize()
        -- ============================ MODULE ASSIGNMENT ============================
        -- Assign Ace3 modules directly (no metatable access)
        OptionsFactory = NAG:GetModule("OptionsFactory")

        -- Register addon message prefix
        if not C_ChatInfo.IsAddonMessagePrefixRegistered("NAGgodtier") then
            C_ChatInfo.RegisterAddonMessagePrefix("NAGgodtier")
        end
        -- Initialize with offset to allow immediate emote
        -- Done here rather than in defaultState to ensure GetTime() is called at the right moment
        self.state.lastEmoteTime = GetTime() - 300

        -- Options are now handled automatically via the optionsComposers mixin
    end
end

do -- Event handlers
    --- Handles incoming addon messages for the BTK module
    --- @param event string The event name
    --- @param prefix string The addon message prefix
    --- @param message string The message content
    --- @param channel string The channel type
    --- @param sender string The sender name
    function BTK:CHAT_MSG_ADDON(event, prefix, message, channel, sender)
        if prefix == "NAGgodtier" then
            self:HandleGodTierMessage()
        end
    end
end

--- Options composer for splash screen integration
--- Called automatically by the optionsComposers mixin system
--- @param options table The options table to modify
--- @param context table The context object
--- @return table The modified options table
function BTK:splash(options, context)
    -- Add BTK toggle to the control group in splash options (available to all users)
    if options.args.controlGroup and options.args.controlGroup.args then
        options.args.controlGroup.args.enableBTK = OptionsFactory:CreateToggle(
            L["enableBTK"] or "Bend The Knee",
            L["enableBTKDesc"] or
            "Enable the automatic emote functionality that makes other players kneel or salute when godtier users gain/lose buffs",
            function() return self.db.global.enableBTK end,
            function(_, value)
                self:SetSetting("global", "enableBTK", value)
                self:Debug("BTK functionality " .. (value and "enabled" or "disabled"))
                if AceConfigRegistry then
                    AceConfigRegistry:NotifyChange("NAG")
                end
            end,
            { order = 30 }
        )
    end

    -- Add godtier-specific emote disable toggle (only visible to godtier users)
    -- This is separate from the main BTK toggle - it only affects emotes, not the entire BTK system
    if ns.lm99 and options.args.controlGroup and options.args.controlGroup.args then
        options.args.controlGroup.args.btkDisableEmotes = OptionsFactory:CreateToggle(
            L["btkDisableEmotes"] or "Disable BTK Emotes",
            L["btkDisableEmotesDesc"] or "Disable only the automatic emotes (salute/kneel) while keeping BTK functionality active (Godtier only)",
            function() return self.state.disableEmotes end,
            function(_, value)
                self.state.disableEmotes = value
                self:Debug("BTK emotes " .. (value and "disabled" or "enabled"))
                if AceConfigRegistry then
                    AceConfigRegistry:NotifyChange("NAG")
                end
            end,
            { order = 50 }
        )
    end

    return options
end

-- ~~~~~~~~~~ HELPERS & PUBLIC API ~~~~~~~~~~

--- Process a received god tier message and potentially trigger an emote
function BTK:HandleGodTierMessage()
    -- Check global BTK setting first
    if not self.db.global.enableBTK then
        return -- BTK is globally disabled
    end

    local timer = self:GetEmoteTimer()
    if not UnitAffectingCombat("player") and (GetTime() - self.state.lastEmoteTime > timer) then
        self:PerformRandomEmote()
    end
end

--- Calculate the appropriate emote timer based on current conditions
--- @return number The calculated timer duration in seconds
function BTK:GetEmoteTimer()
    if IsInGroup() then
        return GROUP_TIMER_BASE + math.random(-GROUP_TIMER_VARIANCE, GROUP_TIMER_VARIANCE)
    end
    if (C_Map.GetBestMapForUnit("player")) == SPECIAL_MAP_ID then
        return SPECIAL_MAP_TIMER
    end
    return DEFAULT_TIMER
end

--- Perform a random emote based on predefined chances
--- Will not perform if player is eating, has l99 flag set, or if emotes are disabled
function BTK:PerformRandomEmote()
    -- Check global BTK setting first
    if not self.db.global.enableBTK then
        return -- BTK is globally disabled
    end

    if ns.eating or ns.lm99 or self.state.disableEmotes then return end
    self.state.lastEmoteTime = GetTime()
    local chance = math.random(1, 100)
    if chance <= EMOTE_CHANCES.NONE then
        -- Do nothing
    elseif chance <= (EMOTE_CHANCES.NONE + EMOTE_CHANCES.SALUTE) then
        DoEmote("SALUTE", "none")
    else
        DoEmote("KNEEL", "none")
    end
end

-- ~~~~~~~~~~ MODULE EXPOSURE ~~~~~~~~~~
