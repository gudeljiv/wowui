--- Displays current time, remaining time, and percentage values for encounters.
---
--- Provides a module for monitoring and visualizing encounter progress.
--- @module "NAG.EncounterStopwatch"
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

---@diagnostic disable: invisible
-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
-- Addon
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access

--- @type StateManager
local StateManager
local UnitExists = _G.UnitExists
local IsInRaid = _G.IsInRaid
local CreateFrame = _G.CreateFrame

--- @type OptionsFactory
--- @type TimerManager
local OptionsFactory, TimerManager

local L = ns.AceLocale:GetLocale("NAG", true)
local AceGUI = ns.AceGUI

-- Lua APIs
local format = string.format

-- Constants
local UPDATE_INTERVAL = 0.1
local FRAME_WIDTH = 280  -- Original width
local FRAME_HEIGHT = 220 -- Increased height to accommodate all sliders comfortably
local DEFAULT_ANCHOR = {
    point = "TOPLEFT",
    relativePoint = "TOPLEFT",
    x = 250,
    y = -250
}

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~
--- @class EncounterStopwatch: DebugModule
local EncounterStopwatch = NAG:CreateModule("EncounterStopwatch", {
    global = {
        enabled = true,  -- Enable by default so auto-show can work
        autoShow = true, -- New option to control auto-show behavior
        windowStatus = {}
    }
}, {
    libs = {"AceHook-3.0"},
    moduleType = ns.MODULE_TYPES.FEATURE,
    -- Show module if debug mode is enabled OR we're in a capital city with a training dummy
    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.DEBUG,
        ns.DEBUG_CATEGORIES.FEATURES
    },
    -- ZERO-BOILERPLATE: Declarative event and message handlers
    eventHandlers = {
        PLAYER_TARGET_CHANGED = true,
        PLAYER_REGEN_DISABLED = true,
        PLAYER_REGEN_ENABLED = true,
    }
})
local module = EncounterStopwatch
ns.EncounterStopwatch = EncounterStopwatch

-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~
do
    function EncounterStopwatch:ModuleInitialize()
        -- ZERO-BOILERPLATE: Events are automatically registered via declarative patterns
        -- ============================ MODULE ASSIGNMENT ============================
        -- Assign Ace3 modules directly (no metatable access)
        StateManager = NAG:GetModule("StateManager")
        OptionsFactory = NAG:GetModule("OptionsFactory")
        TimerManager = NAG:GetModule("TimerManager")

        -- Track whether we set the party override for stopwatch testing
        self.stopwatchPartyOverrideActive = false
    end

    function EncounterStopwatch:ModuleEnable()
        -- Always create frame when module is enabled


        -- ============================ MODULE INITIALIZATION ============================
        self:CreateFrame()

        -- Show frame if auto-show is enabled (regardless of current target)
        if self.db.global.autoShow then
            self.frame:Show()
        end

        -- Check current state and adjust visibility/timer as needed
        self:CheckTarget()
    end

    function EncounterStopwatch:ModuleDisable()
        -- Clear party override if we set it for stopwatch testing
        if self.stopwatchPartyOverrideActive then
            local currentPartyOverride = StateManager.state.group.overridePartyCount
            if currentPartyOverride == 3 then
                StateManager:SetGroupOverride("party_count", nil, false)
            end
            self.stopwatchPartyOverrideActive = false
        end

        if self.frame then
            self.frame:Hide()
        end
        TimerManager:Cancel(TimerManager.Categories.COMBAT, "encounterStopwatch")
        -- ZERO-BOILERPLATE: Events are automatically unregistered via declarative patterns
    end
end

-- ~~~~~~~~~~ EVENT HANDLERS ~~~~~~~~~~
do
    function EncounterStopwatch:OnCombatChange(event)
        if not self.db.global.autoShow then return end

        local inCombat = (event == "PLAYER_REGEN_DISABLED")
        if inCombat and self:IsTrainingDummy() then
            -- Enable encounter timer settings when entering combat
            NAG:SetSetting("global", "enableEncounterTimer", true)
            local encounterDuration = NAG.db.global.encounterDuration
            if not encounterDuration then
                NAG:SetSetting("global", "encounterDuration", 180) -- Default to 3 minutes if not set
            end

            -- Ensure frame exists and show it
            if not self.frame then
                self:CreateFrame()
            end
            self.frame:Show()

            -- Set party override to 3 if no override exists (to avoid confusion with rogue single target abilities)
            if not self.stopwatchPartyOverrideActive then
                local hasRaidOverride = StateManager.state.group.overrideRaidCount ~= nil
                local hasPartyOverride = StateManager.state.group.overridePartyCount ~= nil
                if not hasRaidOverride and not hasPartyOverride then
                    StateManager:SetGroupOverride("party_count", 3, false)
                    self.stopwatchPartyOverrideActive = true
                end
            end

            -- Start update timer (simplified logic)
            TimerManager:Create(
                TimerManager.Categories.COMBAT,
                "encounterStopwatch",
                function() self:Update() end,
                UPDATE_INTERVAL,
                true
            )
        else
            -- Clear party override if we set it for stopwatch testing
            if self.stopwatchPartyOverrideActive then
                -- Only clear if the current override is still 3 (user didn't change it)
                local currentPartyOverride = StateManager.state.group.overridePartyCount
                if currentPartyOverride == 3 then
                    StateManager:SetGroupOverride("party_count", nil, false)
                end
                self.stopwatchPartyOverrideActive = false
            end

            -- Hide frame and cancel timer when leaving combat or not on dummy
            if self.frame then
                self.frame:Hide()
            end
            TimerManager:Cancel(TimerManager.Categories.COMBAT, "encounterStopwatch")
        end
    end

    function EncounterStopwatch:CheckTarget()
        if not self.db.global.autoShow then return end

        -- Ensure frame exists
        if not self.frame then
            self:CreateFrame()
        end

        if self:IsTrainingDummy() then
            -- Show frame if targeting training dummy
            self.frame:Show()

            -- Set party override to 3 if no override exists (to avoid confusion with rogue single target abilities)
            if not self.stopwatchPartyOverrideActive then
                local hasRaidOverride = StateManager.state.group.overrideRaidCount ~= nil
                local hasPartyOverride = StateManager.state.group.overridePartyCount ~= nil
                if not hasRaidOverride and not hasPartyOverride then
                    StateManager:SetGroupOverride("party_count", 3, false)
                    self.stopwatchPartyOverrideActive = true
                end
            end

            -- Start timer if not already running
            TimerManager:Create(
                TimerManager.Categories.COMBAT,
                "encounterStopwatch",
                function() self:Update() end,
                UPDATE_INTERVAL,
                true
            )
        else
            -- Clear party override if we set it for stopwatch testing
            if self.stopwatchPartyOverrideActive then
                -- Only clear if the current override is still 3 (user didn't change it)
                local currentPartyOverride = StateManager.state.group.overridePartyCount
                if currentPartyOverride == 3 then
                    StateManager:SetGroupOverride("party_count", nil, false)
                end
                self.stopwatchPartyOverrideActive = false
            end

            -- Hide frame and cancel timer if no training dummy
            if self.frame then
                self.frame:Hide()
            end
            TimerManager:Cancel(TimerManager.Categories.COMBAT, "encounterStopwatch")
        end
    end

    function EncounterStopwatch:PLAYER_TARGET_CHANGED(event, newGuid)
        self:CheckTarget()
    end

    function EncounterStopwatch:PLAYER_REGEN_DISABLED(event)
        self:OnCombatChange("PLAYER_REGEN_DISABLED")
    end

    function EncounterStopwatch:PLAYER_REGEN_ENABLED(event)
        self:OnCombatChange("PLAYER_REGEN_ENABLED")
    end
end

-- ~~~~~~~~~~ OPTIONS UI ~~~~~~~~~~
do
    function EncounterStopwatch:GetOptions()
        -- Ace3-compliant group table for options UI
        return {
            type = "group",
            name = function() return L["EncounterStopwatch"] or "Encounter Stopwatch" end,
            order = 250,
            args = {
                enabled = OptionsFactory:CreateToggle(L["enabled"] or "Enable", L["enabledDesc"] or "Enable or disable this module/feature",
                    function(info) return self:GetSetting("global", "enabled") end,
                    function(info, value)
                        self:SetSetting("global", "enabled", value)
                        if value then
                            self:Enable()
                        else
                            self:Disable()
                        end
                    end,
                    { order = 1 }
                ),
                autoShow = OptionsFactory:CreateToggle(L["autoShow"] or "Auto-Show for Training Dummies", L["autoShowDesc"] or "Automatically show the stopwatch when targeting training dummies in major cities",
                    function(info) return self.db.global.autoShow end,
                    function(info, value)
                        self.db.global.autoShow = value
                        if value then
                            self:CheckTarget()
                        else
                            -- Clear party override if we set it for stopwatch testing
                            if self.stopwatchPartyOverrideActive then
                                local currentPartyOverride = StateManager.state.group.overridePartyCount
                                if currentPartyOverride == 3 then
                                    StateManager:SetGroupOverride("party_count", nil, false)
                                end
                                self.stopwatchPartyOverrideActive = false
                            end

                            -- Hide frame if auto-show is disabled
                            if self.frame then
                                self.frame:Hide()
                            end
                            TimerManager:Cancel(TimerManager.Categories.COMBAT, "encounterStopwatch")
                        end
                    end,
                    { order = 2 }
                ),
                resetStopwatchPosition = OptionsFactory:CreateExecute(L["resetStopwatchPosition"] or "Reset Stopwatch Position", L["resetStopwatchPositionDesc"] or "Reset the stopwatch position to the center of the screen",
                    function()
                        self:SetSetting("global", "position", {
                            point = "CENTER",
                            relativePoint = "CENTER",
                            x = 0,
                            y = 0
                        })
                        if self.frame then
                            self.frame.frame:ClearAllPoints()
                            self.frame.frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
                        end
                    end,
                    { order = 3 }
                )
            }
        }
    end
end

-- ~~~~~~~~~~ HELPERS & PUBLIC API ~~~~~~~~~~
function EncounterStopwatch:IsTrainingDummy()
    if not UnitExists("target") then return false end

    -- Use centralized dummy detection so TBC dummy-equivalent targets are included.
    return ns.IsTrainingDummy()
end

function EncounterStopwatch:CreateFrame()
    -- Create main frame using AceGUI Window type (no close button by default)
    local frame = AceGUI:Create("Window")
    frame:SetTitle("NAG - Encounter Simulation")
    frame:SetWidth(FRAME_WIDTH)
    frame:SetHeight(FRAME_HEIGHT)
    frame:SetLayout("List") -- Changed to List layout for better control
    frame:EnableResize(false)

    -- Use AceGUI status table for built-in position persistence
    self:EnsureWindowStatus(frame)

    -- Create a container for better spacing
    local container = AceGUI:Create("SimpleGroup")
    container:SetFullWidth(true)
    container:SetLayout("List")
    frame:AddChild(container)

    -- Create labels using AceGUI with improved styling
    local currentTimeLabel = AceGUI:Create("Label")
    currentTimeLabel:SetFullWidth(true)
    currentTimeLabel:SetText("Current Time: 0.0s")
    currentTimeLabel:SetFontObject(GameFontHighlight)
    container:AddChild(currentTimeLabel)

    local remainingTimeLabel = AceGUI:Create("Label")
    remainingTimeLabel:SetFullWidth(true)
    remainingTimeLabel:SetText("Remaining Time: 0.0s")
    remainingTimeLabel:SetFontObject(GameFontHighlight)
    container:AddChild(remainingTimeLabel)

    local targetHealthLabel = AceGUI:Create("Label")
    targetHealthLabel:SetFullWidth(true)
    targetHealthLabel:SetText("Simulated Target HP: 100.0%")
    targetHealthLabel:SetFontObject(GameFontHighlight)
    container:AddChild(targetHealthLabel)

    -- Add duration slider control
    local durationSlider = AceGUI:Create("Slider")
    durationSlider:SetFullWidth(true)
    durationSlider:SetLabel("Duration: 180s")
    durationSlider:SetSliderValues(30, 600, 5) -- 30 seconds to 10 minutes, 5 second steps
    durationSlider:SetValue(NAG.db.global.encounterDuration)
    durationSlider:SetCallback("OnValueChanged", function(widget, event, value)
        -- Update the global setting
        NAG:SetSetting("global", "encounterDuration", value)
        -- Update the label
        widget:SetLabel(format("Duration: %ds", value))
        -- Refresh the display
        self:Update()
    end)
    container:AddChild(durationSlider)

    -- Add combined override controls (more compact)
    local TTDManager = NAG:GetModule("TTDManager")
    local hasTargetOverride = TTDManager:IsTargetCountOverrideActive()
    local currentTargetOverride = hasTargetOverride and (TTDManager:GetTargetCountOverride() or TTDManager.db.global.targetCountOverride) or 1

    local hasRaidOverride = StateManager.state.group.overrideRaidCount ~= nil
    local hasPartyOverride = StateManager.state.group.overridePartyCount ~= nil
    local currentRaidOverride = hasRaidOverride and StateManager.state.group.overrideRaidCount or 25

    -- Target count override slider
    local targetCountSlider = AceGUI:Create("Slider")
    targetCountSlider:SetFullWidth(true)
    targetCountSlider:SetLabel(hasTargetOverride and format("Targets: %d", currentTargetOverride) or "Targets: Disabled")
    targetCountSlider:SetSliderValues(1, 20, 1) -- 1 to 20 targets, 1 target steps
    targetCountSlider:SetValue(currentTargetOverride)
    targetCountSlider:SetCallback("OnValueChanged", function(widget, event, value)
        -- Only update the label while dragging (no override setting yet)
        widget:SetLabel(format("Targets: %d", value))
    end)
    targetCountSlider:SetCallback("OnMouseUp", function(widget, event, value)
        -- Apply the target count override on mouse release
        if TTDManager then
            TTDManager:SetTargetCountOverride(value)
        end
        -- Update the label with final value
        widget:SetLabel(format("Targets: %d", value))
    end)
    -- Add tooltip for target count override
    targetCountSlider:SetCallback("OnEnter", function()
        GameTooltip:SetOwner(targetCountSlider.frame, "ANCHOR_RIGHT")
        GameTooltip:SetText("Target Count Override", 1, 1, 1)
        GameTooltip:AddLine("Simulates having multiple targets for testing purposes.", 1, 1, 1, true)
        GameTooltip:AddLine("", 1, 1, 1)
        GameTooltip:AddLine("Examples:", 0.7, 0.7, 0.7)
        GameTooltip:AddLine("• Set to 5: Simulates 5 targets", 1, 1, 1)
        GameTooltip:AddLine("• NAG:CountTargets() returns 5", 1, 1, 1)
        GameTooltip:AddLine("• Use for testing AoE conditions", 1, 1, 1)
        GameTooltip:Show()
    end)
    targetCountSlider:SetCallback("OnLeave", function()
        GameTooltip:Hide()
    end)
    container:AddChild(targetCountSlider)

    -- Group/Raid override slider (compact)
    local groupOverrideSlider = AceGUI:Create("Slider")
    groupOverrideSlider:SetFullWidth(true)
    local currentPartyOverride = hasPartyOverride and StateManager.state.group.overridePartyCount or nil
    local groupLabel
    local initialValue
    if hasRaidOverride then
        groupLabel = format("Group: Raid (%d)", currentRaidOverride)
        initialValue = currentRaidOverride
    elseif hasPartyOverride then
        if currentPartyOverride == 1 then
            groupLabel = "Group: Solo"
        else
            groupLabel = format("Group: Party (%d)", currentPartyOverride)
        end
        initialValue = currentPartyOverride
    else
        groupLabel = "Group: Disabled"
        initialValue = 0
    end
    groupOverrideSlider:SetLabel(groupLabel)
    groupOverrideSlider:SetSliderValues(0, 40, 1) -- 0=disabled, 1=solo, 2-5=party, 6-40=raid
    groupOverrideSlider:SetValue(initialValue)
    groupOverrideSlider:SetCallback("OnValueChanged", function(widget, event, value)
        -- Only update the label while dragging (no override setting yet)
        if value == 0 then
            widget:SetLabel("Group: Disabled")
        elseif value == 1 then
            widget:SetLabel("Group: Solo")
        elseif value >= 2 and value <= 5 then
            widget:SetLabel(format("Group: Party (%d)", value))
        else
            widget:SetLabel(format("Group: Raid (%d)", value))
        end
    end)
    groupOverrideSlider:SetCallback("OnMouseUp", function(widget, event, value)
        -- Apply the group override on mouse release
        if value == 0 then
            -- Disabled - clear all overrides (normal behavior)
            StateManager:ClearGroupOverrides(false)
            widget:SetLabel("Group: Disabled")
        elseif value == 1 then
            -- Solo - clear all first, then set party_count to 1
            StateManager:ClearGroupOverrides(false)
            StateManager:SetGroupOverride("party_count", 1, false)
            widget:SetLabel("Group: Solo")
        elseif value >= 2 and value <= 5 then
            -- Party - clear raid overrides first to prevent conflicts
            StateManager:SetGroupOverride("raid_count", nil, false)
            StateManager:SetGroupOverride("party_count", value, false)
            widget:SetLabel(format("Group: Party (%d)", value))
        else
            -- Raid - clear party overrides first to prevent conflicts
            StateManager:SetGroupOverride("party_count", nil, false)
            StateManager:SetGroupOverride("raid_count", value, false)
            widget:SetLabel(format("Group: Raid (%d)", value))
        end
    end)
    -- Add tooltip for group override
    groupOverrideSlider:SetCallback("OnEnter", function()
        GameTooltip:SetOwner(groupOverrideSlider.frame, "ANCHOR_RIGHT")
        GameTooltip:SetText("Group/Raid Override", 1, 1, 1)
        GameTooltip:AddLine("Simulates group composition for testing purposes.", 1, 1, 1, true)
        GameTooltip:AddLine("", 1, 1, 1)
        GameTooltip:AddLine("Values:", 0.7, 0.7, 0.7)
        GameTooltip:AddLine("• 0 = Disabled (normal behavior)", 1, 1, 1)
        GameTooltip:AddLine("• 1 = Solo (simulate solo with overrides)", 1, 1, 1)
        GameTooltip:AddLine("• 2-5 = Party (auto-sets in_party)", 1, 1, 1)
        GameTooltip:AddLine("• 6-40 = Raid (auto-sets in_raid)", 1, 1, 1)
        GameTooltip:AddLine("", 1, 1, 1)
        GameTooltip:AddLine("Examples:", 0.7, 0.7, 0.7)
        GameTooltip:AddLine("• Set to 25: Simulates 25-man raid", 1, 1, 1)
        GameTooltip:AddLine("• NAG:PlayerIsInRaid() returns true", 1, 1, 1)
        GameTooltip:AddLine("• CountRaidMembersWithAura() returns 25", 1, 1, 1)
        GameTooltip:AddLine("  (if you have the aura) or 0 (if not)", 1, 1, 1)
        GameTooltip:Show()
    end)
    groupOverrideSlider:SetCallback("OnLeave", function()
        GameTooltip:Hide()
    end)
    container:AddChild(groupOverrideSlider)

    -- Store references to update later
    frame.currentTime = currentTimeLabel
    frame.remainingTime = remainingTimeLabel
    frame.targetHealth = targetHealthLabel
    frame.durationSlider = durationSlider
    frame.targetCountSlider = targetCountSlider
    frame.groupOverrideSlider = groupOverrideSlider

    self.frame = frame
end

function EncounterStopwatch:Update()
    if not self.frame or not self.frame:IsShown() then return end

    local currentTime = NAG:CurrentTime() or 0
    local remainingTime = NAG:RemainingTime() or 0
    local remainingPercent = NAG:RemainingTimePercent() or 100

    -- For simulated encounters, target HP should decrease with progress
    local simulatedTargetHP = remainingPercent -- Target HP matches remaining time percentage

    -- Format times with 1 decimal place
    self.frame.currentTime:SetText(format("Current Time: %.1fs", currentTime))
    self.frame.remainingTime:SetText(format("Remaining Time: %.1fs", remainingTime))
    self.frame.targetHealth:SetText(format("Simulated Target HP: %.1f%%", simulatedTargetHP))

    -- Update target count slider to reflect current override state
    if self.frame.targetCountSlider then
        local TTDManager = NAG:GetModule("TTDManager")
        if TTDManager then
            local hasOverride = TTDManager:IsTargetCountOverrideActive()
            local currentOverride = hasOverride and (TTDManager:GetTargetCountOverride() or TTDManager.db.global.targetCountOverride) or 1

            self.frame.targetCountSlider:SetValue(currentOverride)
            self.frame.targetCountSlider:SetLabel(hasOverride and format("Targets: %d", currentOverride) or "Targets: Disabled")
        end
    end

    -- Update group override slider to reflect current override state
    if self.frame.groupOverrideSlider then
        local hasRaidOverride = StateManager.state.group.overrideRaidCount ~= nil
        local hasPartyOverride = StateManager.state.group.overridePartyCount ~= nil

        if hasRaidOverride then
            local currentRaidOverride = StateManager.state.group.overrideRaidCount
            self.frame.groupOverrideSlider:SetValue(currentRaidOverride)
            self.frame.groupOverrideSlider:SetLabel(format("Group: Raid (%d)", currentRaidOverride))
        elseif hasPartyOverride then
            local currentPartyOverride = StateManager.state.group.overridePartyCount
            self.frame.groupOverrideSlider:SetValue(currentPartyOverride)
            if currentPartyOverride == 1 then
                self.frame.groupOverrideSlider:SetLabel("Group: Solo")
            else
                self.frame.groupOverrideSlider:SetLabel(format("Group: Party (%d)", currentPartyOverride))
            end
        else
            self.frame.groupOverrideSlider:SetValue(0)
            self.frame.groupOverrideSlider:SetLabel("Group: Disabled")
        end
    end
end

-- ============================ WINDOW STATE ============================
--- Ensure the AceGUI Window has a valid status table and migrate any legacy position data.
--- @param frame table A created AceGUI Window widget
function EncounterStopwatch:EnsureWindowStatus(frame)
    local status = self.db.global.windowStatus or {}

    -- Seed defaults if empty
    if not status.left or not status.top then
        frame.frame:ClearAllPoints()
        frame.frame:SetPoint(
            DEFAULT_ANCHOR.point,
            UIParent,
            DEFAULT_ANCHOR.relativePoint,
            DEFAULT_ANCHOR.x,
            DEFAULT_ANCHOR.y
        )
        status.left = frame.frame:GetLeft()
        status.top = frame.frame:GetTop()
        status.width = frame.frame:GetWidth()
        status.height = frame.frame:GetHeight()
    end

    self.db.global.windowStatus = status
    frame:SetStatusTable(status)
end

--- Clean up hooks when module is disabled
function EncounterStopwatch:ModuleDisable()
    self:UnhookAll()
    if self.frame then
        self.frame:Hide()
    end
end
