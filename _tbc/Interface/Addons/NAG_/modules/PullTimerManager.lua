--- @module "NAG.PullTimerManager"
--- Handles pull timer management and countdown functionality for NAG.
---
--- This module provides functions for managing pull timers and countdown functionality.
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold



-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
-- Addon
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access
local WoWAPI = ns.WoWAPI
local GetSpellTexture = C_Spell and C_Spell.GetSpellTexture or _G.GetSpellTexture
local GetItemIcon = C_Item and C_Item.GetItemIconByID or _G.GetItemIcon

--- @type DataManager
--- @type StateManager
local DataManager, StateManager

--- @type OptionsFactory
--- @type DisplayManager
--- @type TimerManager
--- @type SpellbookManager
local OptionsFactory, DisplayManager, TimerManager, SpellbookManager

--- @type SpecCompat
local SpecCompat

local L = ns.AceLocale:GetLocale("NAG", true) -- Enable silent fallback
local AceConfigRegistry = ns.AceConfigRegistry

-- WoW API Compatibility

-- Lua APIs (using WoW's optimized versions where available)
local GetTime = _G.GetTime
local UnitAffectingCombat = _G.UnitAffectingCombat
local IsMouseButtonDown = _G.IsMouseButtonDown
local format = string.format -- WoW's optimized version if available
local min = math.min
local max = math.max
local abs = math.abs

local tinsert = tinsert
local tremove = tremove
local wipe = wipe

local sort = table.sort
local concat = table.concat
local ipairs = ipairs

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~
-- Local constants
local PULL_TIMER_UPDATE_INTERVAL = 0.1

--- Build canonical secondarySpells entry: { spellId, position?, itemId? } for pipeline consistency.
--- @param spellId number
--- @return table
local function makeCanonicalSecondaryEntry(spellId)
    local position = nil
    if SpellbookManager and SpellbookManager.GetSpellPosition and spellId then
        position = SpellbookManager:GetSpellPosition(spellId)
    end
    if NAG.NormalizeSecondaryAction then
        return NAG:NormalizeSecondaryAction(spellId, position, { context = "pulltimer_secondary" })
    end
    return { spellId = spellId, position = position, itemId = nil }
end

--- @param spellId number|nil
--- @return table|nil
local function makeCanonicalPrimaryEntry(spellId)
    if not spellId then
        return nil
    end
    if NAG.NormalizePrimaryAction then
        return NAG:NormalizePrimaryAction(spellId, { context = "pulltimer_primary" })
    end
    return { spellId = spellId, itemId = nil, position = nil }
end

-- Add defaults for the module
local defaults = {
    char = {
        enabled = true,
        prePullEnabled = true,
        prePull = {},             -- Default pre-pull actions
        useRotationPrePull = true, -- Whether to use rotation-specific pre-pull settings if available
        showOnMainDuringPrepull = false, -- If true, mirror pre-pull onto main NAG icon
    }
}

--- @class PullTimerManager: CoreModule, AceEvent-3.0
local PullTimerManager = NAG:CreateModule("PullTimerManager", defaults, {
    optionsCategory = ns.MODULE_CATEGORIES.CLASS, -- Place in spec options since it's spec-specific

    -- Define default state
    defaultState = {
        pullTimer = 0,
        pullStartTime = nil,
        timeToZero = nil,
        nextSpell = nil,
        secondarySpells = {},
        currentRotation = nil,
        currentRotationName = nil
    },
    eventHandlers = {
        START_PLAYER_COUNTDOWN = true,
        CANCEL_PLAYER_COUNTDOWN = true,
    },
    messageHandlers = {
        NAG_ROTATION_CHANGED = true,           -- Unified rotation change message
        NAG_PREPULL_UPDATED = true,
        NAG_PREPULL_PREVIEW_END = true,
    },
    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.FEATURES,
        ns.DEBUG_CATEGORIES.MANAGERS
    }
})
local module = PullTimerManager
ns.PullTimerManager = PullTimerManager

-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~
do
    function PullTimerManager:ModuleInitialize()
        self:Debug("PullTimerManager:ModuleInitialize called")
        -- ============================ MODULE ASSIGNMENT ============================
        -- Assign Ace3 modules directly (no metatable access)
        OptionsFactory = NAG:GetModule("OptionsFactory")
        DataManager = NAG:GetModule("DataManager")
        StateManager = NAG:GetModule("StateManager")
        DisplayManager = NAG:GetModule("DisplayManager")
        TimerManager = NAG:GetModule("TimerManager")
        SpellbookManager = NAG:GetModule("SpellbookManager")
        SpecCompat = NAG:GetModule("SpecCompat")

        -- Preview state for live PrePull edits
        self.state.previewPrePull = nil
        self.state.previewSpecIndex = nil
        self.state.previewRotationName = nil

    end

    function PullTimerManager:ModuleEnable()
        -- Initialize current rotation


        -- ============================ MODULE INITIALIZATION ============================
        self:UpdateCurrentRotation()
    end

    function PullTimerManager:ModuleDisable()
        self:CancelPullTimer()
    end
end

-- ~~~~~~~~~~ EVENT HANDLERS ~~~~~~~~~~
do
    function PullTimerManager:START_PLAYER_COUNTDOWN(event, initiatedBy, timeRemaining, duration)
        if UnitAffectingCombat("player") then return end
        self:StartPullTimer(timeRemaining)
    end

    function PullTimerManager:CANCEL_PLAYER_COUNTDOWN()
        self:CancelPullTimer()
    end
end

-- ~~~~~~~~~~ MESSAGE HANDLERS ~~~~~~~~~~
do
    function PullTimerManager:NAG_ROTATION_CHANGED(message, payload)
        self:Debug("NAG_ROTATION_CHANGED: Rotation changed (action: %s, dataChanged: %s, selectionChanged: %s)",
            payload and payload.action or "unknown",
            payload and tostring(payload.dataChanged) or "unknown",
            payload and tostring(payload.selectionChanged) or "unknown")
        self:UpdateCurrentRotation()
        -- Clear preview if rotation changed
        self.state.previewPrePull = nil
        self.state.previewSpecIndex = nil
        self.state.previewRotationName = nil
        -- Clear display state when rotation/spec changes
        self.state.nextSpell = nil
        wipe(self.state.secondarySpells)
    end

    function PullTimerManager:NAG_PREPULL_UPDATED(message, payload)
        if not payload or type(payload) ~= "table" then return end
        local currentSpecIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex() or nil
        if currentSpecIndex and payload.specIndex and currentSpecIndex ~= payload.specIndex then return end
        local classModule = NAG:GetClassModule()
        local _, currentRotationName = classModule and classModule.GetCurrentRotation and classModule:GetCurrentRotation() or nil
        if payload.rotationName and currentRotationName and payload.rotationName ~= currentRotationName then return end

        self.state.previewSpecIndex = payload.specIndex
        self.state.previewRotationName = payload.rotationName
        self.state.previewPrePull = {}
        for i, v in ipairs(payload.prePull or {}) do
            self.state.previewPrePull[i] = { time = v.time, action = v.action }
        end
    end

    function PullTimerManager:NAG_PREPULL_PREVIEW_END(message, payload)
        if payload and payload.specIndex and self.state.previewSpecIndex and payload.specIndex ~= self.state.previewSpecIndex then return end
        if payload and payload.rotationName and self.state.previewRotationName and payload.rotationName ~= self.state.previewRotationName then return end
        self.state.previewPrePull = nil
        self.state.previewSpecIndex = nil
        self.state.previewRotationName = nil
    end
end

-- ~~~~~~~~~~ OPTIONS UI ~~~~~~~~~~
do --== Options Functions ==--
    --- Gets the options table for the PullTimerManager module
    --- @return table The options table for AceConfig-3.0
    function PullTimerManager:GetOptions()
        self:Debug("PullTimerManager:GetOptions called")
        return {
            type = "group",
            name = function() return L["pullTimer"] or "Pull Timer" end,
            order = 201,
            args = {
                --[[
                -- PrePull description (temporarily disabled, kept for future use)
                description = {
                    type = "description",
                    name = function()
                        local text = L["prePullDescription"]
                        if self:GetSetting("char", "useRotationPrePull") and self.state.currentRotationName then
                            text = text .. "\n\n" .. L["currentRotationFormat"]:format(self.state.currentRotationName)
                        end
                        return L["coloredText"]:format(text)
                    end,
                    order = 1,
                    fontSize = "medium",
                },
                --]]
                enablePrepull = OptionsFactory:CreateToggle(
                    L["enablePrepull"],
                    L["enablePrepullDesc"],
                    function() return self:GetSetting("char", "prePullEnabled") end,
                    function(_, value)
                        self:SetSetting("char", "prePullEnabled", value)
                        AceConfigRegistry:NotifyChange("NAG")
                    end,
                    { order = 2 }
                ),
                -- Other options intentionally simplified/hidden
                --[[
                -- Pre-Pull Suggestions container (temporarily disabled, kept for future use)
                prepullContainer = {
                    type = "group",
                    name = L["prePullActions"],
                    order = 5,
                    inline = true,
                    hidden = function()
                        return not self:GetSetting("char", "prePullEnabled")
                    end,
                    args = self:CreatePrepullActionOptions(self:GetCurrentPrePullSettings()),
                },
                --]]
            }
        }
    end

    --- Helper to extract spell/item ID from action string
    --- @param actionString string The action string (e.g., "NAG:CastSpell(12345)" or "NAG:GetBattlePotion()")
    --- @return number|nil The extracted ID, or nil if not found
    local function ExtractIdFromAction(actionString)
        if not actionString then return nil end

        -- Match patterns like NAG:CastSpell(12345) or similar function calls with numeric arguments
        local id = actionString:match("%((%d+)%)")
        return id and tonumber(id) or nil
    end

    --- Creates and returns the pre-pull action options configuration
    --- @param prepullConfig table The pre-pull configuration table
    --- @return table The pre-pull action options configuration table
    function PullTimerManager:CreatePrepullActionOptions(prepullConfig)
        if not prepullConfig then return {} end

        local args = {
            description = {
                type = "description",
                name = L["prePullActionsDescription"],
                order = 1,
                fontSize = "medium",
            },
            newAction = OptionsFactory:CreateInput(
                L["spellOrItemID"],
                L["spellOrItemIDDesc"],
                nil, -- No getter needed for input
                function(_, value)
                    local id = tonumber(value)
                    if self:GetSetting("char", "useRotationPrePull") and self.state.currentRotation then
                        -- Add to rotation pre-pull (new format)
                        self.state.currentRotation.prePull = self.state.currentRotation.prePull or {}
                        tinsert(self.state.currentRotation.prePull, { time = -3, action = format("NAG:CastSpell(%d)", id) })
                        table.sort(self.state.currentRotation.prePull, function(a, b)
                            local timeA = a.time or a[2] or 0
                            local timeB = b.time or b[2] or 0
                            return timeA < timeB
                        end)
                    else
                        -- Add to char pre-pull (old format for backward compatibility)
                        local prePull = self:GetSetting("char", "prePull")
                        tinsert(prePull, { id, -3 })
                        table.sort(prePull, function(a, b) return a[2] < b[2] end)
                        self:SetSetting("char", "prePull", prePull)
                    end
                    AceConfigRegistry:NotifyChange("NAG")
                end,
                {
                    order = 2,
                    width = "full",
                    validate = function(_, value)
                        local id = tonumber(value)
                        if not id then
                            return L["invalidID"]
                        end
                        -- Check if it's a spell or item using DataManager
                        local spellEntry = DataManager:GetSpell(id)
                        local itemEntry = DataManager:GetItem(id)
                        if not spellEntry and not itemEntry then
                            return L["invalidSpellOrItem"]
                        end
                        return true
                    end
                }
            )
        }

        -- Add existing actions
        for index, action in ipairs(prepullConfig) do
            local id, timing, actionString

            -- Handle both old and new formats
            if action.time and action.action then
                -- New format: { time = -1.5, action = "NAG:CastSpell(12345)" }
                timing = action.time
                actionString = action.action
                id = ExtractIdFromAction(actionString)
            elseif action.spellId then
                -- Converted old format from GetCurrentPrePullSettings
                id = action.spellId
                timing = action.time
            else
                -- Original old format: { spellId, time }
                id = action[1]
                timing = action[2]
            end

            local name, icon

            if id then
                -- Check if it's a spell or item using DataManager
                local spellEntry = DataManager:GetSpell(id)
                local itemEntry = DataManager:GetItem(id)
                --TODO: This needs to be fixed, id's are essentially guessed and if we have both item/spell same id it's a big issue.
                if spellEntry and spellEntry.name and spellEntry.icon then
                    name = spellEntry.name
                    icon = spellEntry.icon
                elseif itemEntry and itemEntry.name and itemEntry.icon then
                    name = itemEntry.name
                    icon = itemEntry.icon
                else
                    -- Fallback to direct API calls if not found in DataManager or entries are invalid
                    local spellInfo = WoWAPI.GetSpellInfo(id)
                    name = (spellInfo and spellInfo.name) or WoWAPI.GetItemInfo(id) or "Unknown"
                    icon = GetSpellTexture(id) or GetItemIcon(id) or "Interface\\Icons\\INV_Misc_QuestionMark"
                end
            else
                -- No ID extracted (e.g., NAG:GetBattlePotion())
                name = actionString or "Unknown Action"
                icon = "Interface\\Icons\\INV_Misc_QuestionMark"
            end

            local actionGroup = format("action%d", index)
            args[actionGroup] = {
                type = "group",
                name = "",
                order = index + 10,
                inline = true,
                args = {
                    icon = {
                        type = "description",
                        name = format("|T%s:24:24:0:0:64:64:5:59:5:59|t |cFFFFFFFF%s|r", icon, name),
                        order = 1,
                        width = 1.5,
                    },
                    timing = OptionsFactory:CreateRange(
                        L["timing"],
                        L["timingDesc"],
                        function()
                            -- Ensure displayed value is negative
                            return timing > 0 and -timing or timing
                        end,
                        function(_, value)
                            -- Always store as negative
                            value = value > 0 and -value or value
                            if self:GetSetting("char", "useRotationPrePull") then
                                -- Update rotation pre-pull (new format)
                                if self.state.currentRotation and self.state.currentRotation.prePull then
                                    local entry = self.state.currentRotation.prePull[index]
                                    if entry.time then
                                        entry.time = value
                                    else
                                        entry[2] = value
                                    end
                                    if not IsMouseButtonDown() then
                                        table.sort(self.state.currentRotation.prePull, function(a, b)
                                            local timeA = a.time or a[2] or 0
                                            local timeB = b.time or b[2] or 0
                                            return timeA < timeB
                                        end)
                                    end
                                end
                            else
                                -- Update char pre-pull (old format)
                                local prePull = self:GetSetting("char", "prePull")
                                prePull[index][2] = value
                                if not IsMouseButtonDown() then
                                    table.sort(prePull, function(a, b) return a[2] < b[2] end)
                                end
                                self:SetSetting("char", "prePull", prePull)
                            end
                            if not IsMouseButtonDown() then
                                AceConfigRegistry:NotifyChange("NAG")
                            end
                        end,
                        {
                            order = 2,
                            min = -30,
                            max = 0,
                            step = 0.1,
                            width = 1
                        }
                    ),
                    remove = {
                        type = "execute",
                        name = L["remove"],
                        desc = format(L["removeActionConfirm"], name),
                        order = 3,
                        width = 0.75,
                        confirm = true,
                        func = function()
                            if self:GetSetting("char", "useRotationPrePull") then
                                -- Remove from rotation pre-pull
                                if self.state.currentRotation and self.state.currentRotation.prePull then
                                    tremove(self.state.currentRotation.prePull, index)
                                end
                            else
                                -- Remove from char pre-pull
                                local prePull = self:GetSetting("char", "prePull")
                                tremove(prePull, index)
                                self:SetSetting("char", "prePull", prePull)
                            end
                            AceConfigRegistry:NotifyChange("NAG")
                        end,
                    },
                },
            }
        end

        return args
    end
end

-- ~~~~~~~~~~ HELPERS & PUBLIC API ~~~~~~~~~~
-- (Local helpers and public API functions should be outside do blocks for scope)

function PullTimerManager:UpdateCurrentRotation()
    --- @type ClassBase|AceModule|CoreModule
    local classModule = NAG.classModule
    if classModule then
        local rotation, name = classModule:GetCurrentRotation()
        self.state.currentRotation = rotation
        self.state.currentRotationName = name
    end
end

--- Start a pull timer countdown
--- @param duration number The duration of the countdown in seconds
function PullTimerManager:StartPullTimer(duration)
    self.state.pullTimer = duration
    self.state.pullStartTime = GetTime()
    self.state.timeToZero = -duration

    -- Create pull ticker timer
    TimerManager:Create(
        TimerManager.Categories.COMBAT,
        "pullTicker",
        function()
            if self.state.timeToZero and self.state.timeToZero < 0 then
                self.state.timeToZero = self.state.timeToZero + PULL_TIMER_UPDATE_INTERVAL
            else
                self.state.timeToZero = nil
                TimerManager:Cancel(TimerManager.Categories.COMBAT, "pullTicker")
                TimerManager:Cancel(TimerManager.Categories.COMBAT, "prePull")
            end
        end,
        PULL_TIMER_UPDATE_INTERVAL,
        true
    )

    -- Create pre-pull timer
    TimerManager:Create(
        TimerManager.Categories.COMBAT,
        "prePull",
        function()
            if not UnitAffectingCombat("player") then
                self:PrePull()
            else
                TimerManager:Cancel(TimerManager.Categories.COMBAT, "prePull")
            end
        end,
        PULL_TIMER_UPDATE_INTERVAL,
        true
    )
end

--- Gets the current pre-pull settings, merging module defaults with rotation settings if available
--- @return table|nil The current pre-pull settings, or nil if none available
function PullTimerManager:GetCurrentPrePullSettings()
    -- If a preview is active for current rotation/spec, prioritize it
    if self.state.previewPrePull and type(self.state.previewPrePull) == "table" then
        local resolvedSettings = {}
        for _, entry in ipairs(self.state.previewPrePull) do
            if entry and type(entry) == "table" then
                if entry.time and entry.action then
                    tinsert(resolvedSettings, { time = entry.time, action = entry.action })
                end
            end
        end
        if #resolvedSettings > 0 then
            return resolvedSettings
        end
    end

    local settings = self.db.char.prePull

    -- If rotation settings should be used and are available, merge them
    if self.db.char.useRotationPrePull and self.state.currentRotation then
        local rotPrePull = self.state.currentRotation.prePull
        if rotPrePull and type(rotPrePull) == "table" and #rotPrePull > 0 then
            settings = CopyTable(rotPrePull)
        elseif self.state.currentRotationName then
            -- Safety net: saved rotation not yet backfilled by ReconcileDefaultRotations (e.g. first load). Use class default.
            local classModule = NAG.classModule or (NAG.GetClassModule and NAG:GetClassModule())
            local specIndex = SpecCompat and SpecCompat.GetCurrentSpecIndex and SpecCompat:GetCurrentSpecIndex()
            if classModule and specIndex and classModule.defaults and classModule.defaults.class and classModule.defaults.class.rotations then
                local specRotations = classModule.defaults.class.rotations[specIndex]
                local defaultRot = specRotations and specRotations[self.state.currentRotationName]
                if defaultRot and defaultRot.prePull and type(defaultRot.prePull) == "table" and #defaultRot.prePull > 0 then
                    settings = CopyTable(defaultRot.prePull)
                end
            end
        end
    end

    if not settings or type(settings) ~= "table" then return nil end

    -- Create a new table with resolved values
    local resolvedSettings = {}
    for _, entry in ipairs(settings) do
        -- Check condition if present
        if entry.condition then
            local conditionFunc, err = loadstring("return " .. entry.condition)
            if not conditionFunc then
                self:Debug("Invalid condition in pre-pull entry: %s", err or "unknown error")
                -- Skip this entry
            else
                -- Execute condition in NAG environment
                setfenv(conditionFunc, getfenv(1))
                local success, result = pcall(conditionFunc)
                if not success or not result then
                    -- Condition failed, skip this entry
                    -- Lua 5.1 doesn't have goto, so we'll use a continue pattern
                else
                    -- Condition passed, continue processing
                    -- Handle both old format { spellId, time } and new format { time = ..., action = ... }
                    if entry.time and entry.action then
                        -- New format: { time = -1.5, action = "NAG:CastSpell(12345)" }
                        tinsert(resolvedSettings, { time = entry.time, action = entry.action, condition = entry.condition })
                    else
                        -- Old format: { spellId, time }
                        local spellId, time = entry[1], entry[2]
                        -- Handle special cases
                        if spellId == "defaultBattlePotion" then
                            local potionId = NAG:GetBattlePotion()
                            if potionId and potionId ~= 0 then
                                tinsert(resolvedSettings, { time = time, spellId = potionId, condition = entry.condition })
                            else
                                self:Debug("Skipping defaultBattlePotion - no potion selected")
                            end
                        else
                            tinsert(resolvedSettings, { time = time, spellId = spellId, condition = entry.condition })
                        end
                    end
                end
            end
        else
            -- No condition, process normally
            -- Handle both old format { spellId, time } and new format { time = ..., action = ... }
            if entry.time and entry.action then
                -- New format: { time = -1.5, action = "NAG:CastSpell(12345)" }
                tinsert(resolvedSettings, { time = entry.time, action = entry.action })
            else
                -- Old format: { spellId, time }
                local spellId, time = entry[1], entry[2]
                -- Handle special cases
                if spellId == "defaultBattlePotion" then
                    local potionId = NAG:GetBattlePotion()
                    if potionId and potionId ~= 0 then
                        tinsert(resolvedSettings, { time = time, spellId = potionId })
                    else
                        self:Debug("Skipping defaultBattlePotion - no potion selected")
                    end
                else
                    tinsert(resolvedSettings, { time = time, spellId = spellId })
                end
            end
        end
    end

    return resolvedSettings
end

--- Helper to execute action string safely
--- @param actionString string The action string to execute (e.g., "NAG:CastSpell(12345)")
--- @return boolean success Whether the action executed successfully
local function ExecuteAction(actionString)
    if not actionString then return false end

    -- Execute the action string safely
    local func, err = loadstring("return " .. actionString)
    if func then
        local success, result = pcall(func)
        if success then
            return result ~= false -- Consider nil or true as success
        else
            module:Debug("PrePull action execution failed: " .. tostring(result))
            return false
        end
    else
        module:Debug("PrePull action compilation failed: " .. tostring(err))
        return false
    end
end

--- Pre-pull function that handles spell casting before combat.
--- @return number|nil nextSpell The next spell ID to cast, or nil if none found
function PullTimerManager:PrePull()
    if not self.state.timeToZero then return end

    local currentTime = abs(self.state.timeToZero)
    self.state.nextSpell = nil
    wipe(self.state.secondarySpells)

    -- Get current pre-pull settings
    local prePullSettings = self:GetCurrentPrePullSettings()
    if not prePullSettings then return end

    -- Sort settings by time to ensure proper order
    table.sort(prePullSettings, function(a, b)
        local timeA = a.time or a[2] or 0
        local timeB = b.time or b[2] or 0
        timeA = timeA > 0 and -timeA or timeA
        timeB = timeB > 0 and -timeB or timeB
        return abs(timeA) > abs(timeB)
    end)

    -- Find the next spell to cast and upcoming spells
    for _, entry in ipairs(prePullSettings) do
        -- Check condition if present (re-evaluate at execution time)
        if entry.condition then
            local conditionFunc, err = loadstring("return " .. entry.condition)
            if not conditionFunc then
                self:Debug("Invalid condition in pre-pull entry: %s", err or "unknown error")
                -- Skip this entry
            else
                setfenv(conditionFunc, getfenv(1))
                local success, result = pcall(conditionFunc)
                if not success or not result then
                    -- Condition failed, skip this entry
                    -- Lua 5.1 doesn't have goto, so we'll use a continue pattern via nested if
                else
                    -- Condition passed, continue processing (nested in else block)
                    local spellId, time, actionString

                    -- Handle both old and new formats
                    if entry.action then
                        -- New format: { time = -1.5, action = "NAG:CastSpell(12345)" }
                        actionString = entry.action
                        time = entry.time
                        -- Try to extract spell ID for display purposes
                        spellId = actionString:match("%((%d+)%)")
                        spellId = spellId and tonumber(spellId)
                    elseif entry.spellId or entry.itemId then
                        -- Converted old format or canonical: { time = ..., spellId = ..., itemId? = ... }
                        spellId = entry.spellId or entry.itemId
                        time = entry.time
                    else
                        -- Original old format: { spellId, time }
                        spellId = entry[1]
                        time = entry[2]
                        -- Handle special cases like defaultBattlePotion
                        if spellId == "defaultBattlePotion" then
                            spellId = NAG:GetBattlePotion()
                        end
                    end

                    -- Skip if no valid spell ID or action
                    if not spellId and not actionString then
                        self:Debug("Skipping invalid pre-pull entry")
                    else
                        -- Process the entry (moved the rest of the logic inside this block)
                        -- Ensure time is negative for consistent comparison
                        time = time > 0 and -time or time
                        local absTime = abs(time)
                        local timeUntilCast = absTime - currentTime

                        -- Check if spell is already active (only for spell IDs)
                        local isActive = spellId and NAG:AuraIsActive(spellId) or false

                        if not isActive then
                            if timeUntilCast > 0 then
                                -- This spell is coming up
                                if not self.state.nextSpell and spellId then
                                    self.state.nextSpell = makeCanonicalPrimaryEntry(spellId)
                                    -- Optionally mirror countdown to main icons
                                    if (self.db.char.showOnMainDuringPrepull ~= false) and DisplayManager:AreCooldownSwipesEnabled() then
                                        for _, frame in ipairs(DisplayManager:GetActivePrimaryFrames()) do
                                            if frame.cooldown then
                                                frame.cooldown:SetCooldown(GetTime(), timeUntilCast)
                                            end
                                        end
                                    end
                                elseif spellId then
                                    tinsert(self.state.secondarySpells, makeCanonicalSecondaryEntry(spellId))
                                    -- Optionally mirror secondary cooldowns
                                    if (self.db.char.showOnMainDuringPrepull ~= false) and DisplayManager:AreCooldownSwipesEnabled() then
                                        -- Legacy frame secondary icons
                                        if DisplayManager:IsLegacyFrameEnabled() and NAG.Frame and NAG.Frame.iconFrames then
                                            local iconKey = "left" .. (#self.state.secondarySpells)
                                            local iconFrame = NAG.Frame.iconFrames[iconKey]
                                            if iconFrame and iconFrame.cooldown then
                                                iconFrame.cooldown:SetCooldown(GetTime(), timeUntilCast)
                                            end
                                        end
                                        -- TODO: Group display secondary icons - needs mapping logic between
                                        -- legacy "left" concept and group display system
                                    end
                                end
                            elseif currentTime <= absTime and currentTime > absTime - 1 then
                                -- Time to cast this spell
                                local canExecute = false

                                if actionString then
                                    -- New format: execute the action string
                                    canExecute = ExecuteAction(actionString)
                                elseif spellId and NAG:SpellCanCast(spellId) then
                                    -- Old format: check if spell can be cast
                                    canExecute = true
                                end

                                if canExecute and spellId then
                                    if not self.state.nextSpell then
                                        self.state.nextSpell = makeCanonicalPrimaryEntry(spellId)
                                    else
                                        tinsert(self.state.secondarySpells, makeCanonicalSecondaryEntry(spellId))
                                    end
                                end
                            end
                        end
                    end
                end
            end
        else
            -- No condition, process normally
            local spellId, time, actionString

            -- Handle both old and new formats
            if entry.action then
                -- New format: { time = -1.5, action = "NAG:CastSpell(12345)" }
                actionString = entry.action
                time = entry.time
                -- Try to extract spell ID for display purposes
                spellId = actionString:match("%((%d+)%)")
                spellId = spellId and tonumber(spellId)
            elseif entry.spellId or entry.itemId then
                -- Converted old format or canonical: { time = ..., spellId = ..., itemId? = ... }
                spellId = entry.spellId or entry.itemId
                time = entry.time
            else
                -- Original old format: { spellId, time }
                spellId = entry[1]
                time = entry[2]
                -- Handle special cases like defaultBattlePotion
                if spellId == "defaultBattlePotion" then
                    spellId = NAG:GetBattlePotion()
                end
            end

            -- Skip if no valid spell ID or action
            if not spellId and not actionString then
                self:Debug("Skipping invalid pre-pull entry")
            else
                -- Ensure time is negative for consistent comparison
                time = time > 0 and -time or time
                local absTime = abs(time)
                local timeUntilCast = absTime - currentTime

                -- Check if spell is already active (only for spell IDs)
                local isActive = spellId and NAG:AuraIsActive(spellId) or false

                if not isActive then
                    if timeUntilCast > 0 then
                        -- This spell is coming up
                        if not self.state.nextSpell and spellId then
                            self.state.nextSpell = makeCanonicalPrimaryEntry(spellId)
                            -- Optionally mirror countdown to main icons
                            if (self.db.char.showOnMainDuringPrepull ~= false) and DisplayManager:AreCooldownSwipesEnabled() then
                                for _, frame in ipairs(DisplayManager:GetActivePrimaryFrames()) do
                                    if frame.cooldown then
                                        frame.cooldown:SetCooldown(GetTime(), timeUntilCast)
                                    end
                                end
                            end
                        elseif spellId then
                            tinsert(self.state.secondarySpells, makeCanonicalSecondaryEntry(spellId))
                            -- Optionally mirror secondary cooldowns
                            if (self.db.char.showOnMainDuringPrepull ~= false) and DisplayManager:AreCooldownSwipesEnabled() then
                                -- Legacy frame secondary icons
                                if DisplayManager:IsLegacyFrameEnabled() and NAG.Frame and NAG.Frame.iconFrames then
                                    local iconKey = "left" .. (#self.state.secondarySpells)
                                    local iconFrame = NAG.Frame.iconFrames[iconKey]
                                    if iconFrame and iconFrame.cooldown then
                                        iconFrame.cooldown:SetCooldown(GetTime(), timeUntilCast)
                                    end
                                end
                                -- TODO: Group display secondary icons - needs mapping logic between
                                -- legacy "left" concept and group display system
                            end
                        end
                    elseif currentTime <= absTime and currentTime > absTime - 1 then
                        -- Time to cast this spell
                        local canExecute = false

                        if actionString then
                            -- New format: execute the action string
                            canExecute = ExecuteAction(actionString)
                        elseif spellId and NAG:SpellCanCast(spellId) then
                            -- Old format: check if spell can be cast
                            canExecute = true
                        end

                        if canExecute and spellId then
                            if not self.state.nextSpell then
                                self.state.nextSpell = makeCanonicalPrimaryEntry(spellId)
                            else
                                tinsert(self.state.secondarySpells, makeCanonicalSecondaryEntry(spellId))
                            end
                        end
                    end
                end
            end
        end
    end

    -- Only mirror to main NAG display if explicitly enabled
    if self.db.char.showOnMainDuringPrepull ~= false then
        DisplayManager:UpdateIcons(self.state.nextSpell, self.state.secondarySpells)
    end
end

--- Cancel the current pull timer
function PullTimerManager:CancelPullTimer()
    self.state.pullTimer = 0
    self.state.pullStartTime = nil
    self.state.timeToZero = nil
    if NAG and self.state.nextSpell then
        local id = NAG.GetActionDisplayId and NAG:GetActionDisplayId(self.state.nextSpell)
            or (NAG.GetActionResolveId and NAG:GetActionResolveId(self.state.nextSpell))
        if id then
            NAG:ClearCastOverlayText(id)
        end
    end
    if NAG and NAG.ClearSecondarySpellOverlays and self.state.secondarySpells then
        NAG:ClearSecondarySpellOverlays(self.state.secondarySpells)
    end
    self.state.nextSpell = nil
    wipe(self.state.secondarySpells)

    -- Cancel timers
    TimerManager:Cancel(TimerManager.Categories.COMBAT, "pullTicker")
    TimerManager:Cancel(TimerManager.Categories.COMBAT, "prePull")
end

--- Update the pull timer state
function PullTimerManager:UpdatePullTimer()
    if self.state.pullStartTime then
        local timeLeft = self.state.pullTimer - (GetTime() - self.state.pullStartTime)
        if timeLeft <= 0 then
            self:CancelPullTimer()
        end
    end
end

-- Public API
function PullTimerManager:IsPullTimer()
    if not self.state then self:ModuleInitialize() end
    return self.state.timeToZero ~= nil
end

function PullTimerManager:GetTimeToZero()
    if not self.state then self:ModuleInitialize() end
    return self.state.timeToZero
end

function PullTimerManager:GetPullTimer()
    if not self.state then self:ModuleInitialize() end
    return self.state.pullTimer
end

function PullTimerManager:GetPullStartTime()
    if not self.state then self:ModuleInitialize() end
    return self.state.pullStartTime
end
