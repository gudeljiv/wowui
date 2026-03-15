--- @module "NAG.MinimapSelector"
--- Unified minimap icon and rotation selector for NAG
--- License: CC BY-NC 4.0
--- Authors: @Rakizi, @Fonsas

-- ============================ LOCALIZE ============================
local _, ns = ...
local GetCursorPosition = _G.GetCursorPosition
local IsShiftKeyDown = _G.IsShiftKeyDown
local IsAltKeyDown = _G.IsAltKeyDown
local IsControlKeyDown = _G.IsControlKeyDown
local IsInGroup = _G.IsInGroup
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access

--- @type StateManager
local StateManager

--- @type OptionsFactory
local OptionsFactory

--- @type DisplayManager
local DisplayManager

--- @type SpecCompat
local SpecCompat
local WoWAPI = ns.WoWAPI


local L = ns.AceLocale:GetLocale("NAG", true)
local AceConfigRegistry = ns.AceConfigRegistry
local AceConfigDialog = ns.AceConfigDialog
local AceGUI = ns.AceGUI
local LibDBIcon = LibStub("LibDBIcon-1.0")
local LUIDropDownMenu = LibStub("LibUIDropDownMenu-4.0")

-- Enhanced error handling
local pcall = ns.pcall


-- ============================ DEFAULTS ============================
local defaults = {
    global = {
        minimap = {
            hide = false,
            position = 220, -- Changed from minimapPos to position to match OptionsManager
        },
    },
    char = {},
}

--- @class MinimapSelector : CoreModule
local MinimapSelector = NAG:CreateModule("MinimapSelector", defaults, {
    optionsCategory = ns.MODULE_CATEGORIES.UI,
    optionsOrder = 20,
    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.DISPLAY,
        ns.DEBUG_CATEGORIES.UTILITIES
    }
})
local module = MinimapSelector
ns.MinimapSelector = MinimapSelector

-- ============================ CONTENT ============================

function MinimapSelector:ModuleInitialize()
    -- OnInitialize: Database is being registered but not guaranteed to be ready yet
    -- Only set up static objects that don't need database access
    -- ============================ MODULE ASSIGNMENT ============================
    -- Assign Ace3 modules directly (no metatable access)
    StateManager = NAG:GetModule("StateManager")
    OptionsFactory = NAG:GetModule("OptionsFactory")
    DisplayManager = NAG:GetModule("DisplayManager")
    SpecCompat = NAG:GetModule("SpecCompat")

    -- Capture module reference for use in DataBroker callbacks
    local module = self

    if not self.iconLDB then
        self.iconLDB = LibStub("LibDataBroker-1.1"):NewDataObject("NAGMinimapSelector", {
            type = "launcher",
            icon = "Interface\\AddOns\\NAG\\Media\\NAGMiniMap.png",
            OnClick = function(_, button)
                module:HandleSelectorClick(button)
            end,
            OnTooltipShow = function(tooltip)
                module:ShowSelectorTooltip(tooltip)
            end,
        })
    end
end

function MinimapSelector:ModuleEnable()
    -- OnEnable: Database is guaranteed to be ready and module is enabled
    -- Now we can safely access settings and create frames


    -- ============================ MODULE INITIALIZATION ============================
    if not self.db then
        self:Warn("ModuleEnable called but database not ready - skipping setup")
        return
    end

    self:SetupIcon()
    self:UpdateIconVisibility()
end

function MinimapSelector:ModuleDisable()
    -- OnDisable: Clean up frames and hide UI elements

    LibDBIcon:Hide("NAGMinimapSelector")
end

function MinimapSelector:SetupIcon()
    -- Database is guaranteed to be ready during OnEnable
    if not self.db then
        self:Warn("SetupIcon called but database not ready")
        return
    end

    -- Remove old icon if present
    if LibDBIcon:IsRegistered("NAGMinimapSelector") then
        LibDBIcon:Hide("NAGMinimapSelector")
    end

    local db = self.db.global.minimap

    if not LibDBIcon:GetMinimapButton("NAGMinimapSelector") then
        LibDBIcon:Register("NAGMinimapSelector", self.iconLDB, db)
    end
end

function MinimapSelector:UpdateIconVisibility()
    -- Database is guaranteed to be ready during OnEnable
    if not self.db then
        self:Warn("UpdateIconVisibility called but database not ready")
        return
    end

    local db = self.db.global.minimap

    -- Update visibility based on settings
    if db.hide then
        LibDBIcon:Hide("NAGMinimapSelector")
    else
        LibDBIcon:Show("NAGMinimapSelector")
    end
end

function MinimapSelector:ShowRotationMenu()
    local classModule = NAG:GetClassModule()
    if not classModule then return end

    local specIndex = (SpecCompat and SpecCompat:GetCurrentSpecIndex()) or 0

    local rotations, displayNames = classModule:GetAvailableRotations(specIndex)
    local currentRotationName = select(2, classModule:GetCurrentRotation())

    local tinsert, tsort = table.insert, table.sort
    local rotationListForSorting = {}

    for name in pairs(rotations) do
        tinsert(rotationListForSorting, {
            name = name,
            displayName = displayNames[name] or name,
            isSelected = (name == currentRotationName)
        })
    end

    if #rotationListForSorting == 0 then return end

    tsort(rotationListForSorting, function(a, b) return a.displayName < b.displayName end)

    local menuList = {}

    -- Add rotation entries
    for _, rotInfo in ipairs(rotationListForSorting) do
        local menuItem = {
            text = rotInfo.isSelected and ("|cff00ff00" .. rotInfo.displayName .. "|r") or rotInfo.displayName,
            value = rotInfo.name,
            func = function()
                classModule:SelectRotation(specIndex, rotInfo.name)
            end,
            checked = rotInfo.isSelected,
        }
        tinsert(menuList, menuItem)
    end

    -- Add assignments submenu if available
    local assignmentsSubmenu = self:BuildAssignmentsSubmenu(classModule)
    if assignmentsSubmenu then
        -- Add separator before assignments
        tinsert(menuList, {
            text = "",
            isTitle = true,
            notCheckable = true,
        })

        tinsert(menuList, assignmentsSubmenu)
    end

    -- Add separator before close
    tinsert(menuList, {
        text = "",
        isTitle = true,
        notCheckable = true,
    })

    -- Add close option
    tinsert(menuList, {
        text = L["close"] or "Close",
        func = function() end,
        notCheckable = true
    })

    if not self.rotationDropdownFrame then
        self.rotationDropdownFrame = LUIDropDownMenu:Create_UIDropDownMenu("NAGMinimapSelectorDropdownMenu", UIParent)
    end
    LUIDropDownMenu:EasyMenu(menuList, self.rotationDropdownFrame, "cursor", 0, 0, "MENU")
end

--- Builds the assignments submenu structure for the rotation selector
--- @param classModule ClassBase The class module to get assignments from
--- @return table|nil assignmentsMenu The assignments submenu structure or nil if no assignments
function MinimapSelector:BuildAssignmentsSubmenu(classModule)
    if not classModule or not classModule.defaults or not classModule.defaults.class then
        return nil
    end
    if classModule.IsClassAssignmentsEnabled and not classModule:IsClassAssignmentsEnabled() then
        return nil
    end

    local assignments = classModule.defaults.class.classAssignments or {}

    -- Return nil if no assignments configured
    if not assignments or #assignments == 0 then
        return nil
    end

    local assignmentsSubmenu = {
        text = L["classAssignments"] or "Assignments",
        hasArrow = true,
        notCheckable = true,
        menuList = {}
    }

    local tinsert = table.insert

    -- Add info header
    tinsert(assignmentsSubmenu.menuList, {
        text = L["raidAssignments"] or "Raid Assignments",
        isTitle = true,
        notCheckable = true,
    })

    local allowMultiple = classModule.AllowsMultipleAssignments and classModule:AllowsMultipleAssignments() or false
    local selectedId = classModule.GetSelectedAssignmentId and classModule:GetSelectedAssignmentId() or nil
    local states = classModule.GetAssignmentStates and classModule:GetAssignmentStates() or {}
    local hasEnabled = false
    for _, enabled in pairs(states) do
        if enabled then
            hasEnabled = true
            break
        end
    end

    local inGroup = IsInGroup()

    local assignmentTooltip = allowMultiple
        and "Select one or more abilities you are assigned to maintain."
        or (L["assignmentSelectDesc"] or "Select the single ability you are assigned to maintain.")

    tinsert(assignmentsSubmenu.menuList, {
        text = L["assignmentNone"] or "None",
        checked = allowMultiple and (not hasEnabled) or selectedId == nil,
        isNotRadio = allowMultiple,
        keepShownOnClick = allowMultiple,
        disabled = not inGroup,
        tooltipTitle = L["assignmentNone"] or "None",
        tooltipText = assignmentTooltip,
        func = function()
            classModule:SetSelectedAssignmentId(nil)
        end
    })

    -- Add each assignment as a radio option
    for _, assignment in ipairs(assignments) do
        -- Format spell icon for display (just show first spell's icon)
        local spellIcon = ""
        if assignment.spellIds and #assignment.spellIds > 0 then
            local spellInfo = WoWAPI.GetSpellInfo(assignment.spellIds[1])
            if spellInfo and spellInfo.iconID then
                spellIcon = string.format("|T%s:16:16:0:0|t ", spellInfo.iconID)
            end
        end

        tinsert(assignmentsSubmenu.menuList, {
            text = spellIcon .. assignment.name,
            checked = allowMultiple and states[assignment.id] == true or selectedId == assignment.id,
            isNotRadio = allowMultiple,
            keepShownOnClick = allowMultiple,
            disabled = not inGroup,
            tooltipTitle = assignment.name,
            tooltipText = assignment.description or assignmentTooltip,
            func = function()
                if allowMultiple and classModule.ToggleAssignment then
                    classModule:ToggleAssignment(assignment.id, not (states[assignment.id] == true))
                else
                    classModule:SetSelectedAssignmentId(assignment.id)
                end
            end
        })
    end

    return assignmentsSubmenu
end

function MinimapSelector:ShowSettingsMenu()
    if self.selectorMenu and self.selectorMenu:IsShown() then
        AceGUI:Release(self.selectorMenu)
        self.selectorMenu = nil
        return
    end
    local menu = AceGUI:Create("Frame")
    menu:SetTitle(L["selectorSettings"] or "Selector Settings")
    menu:SetLayout("Fill")
    menu:EnableResize(false)
    menu:SetWidth(320)
    menu:SetHeight(340)
    menu:SetCallback("OnClose", function(widget)
        AceGUI:Release(widget)
        if self.selectorMenu == widget then
            self.selectorMenu = nil
        end
    end)
    self.selectorMenu = menu
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("List")
    scroll:SetFullWidth(true)
    scroll:SetFullHeight(true)
    menu:AddChild(scroll)
    -- Option: Import Rotation
    local importBtn = AceGUI:Create("Button")
    importBtn:SetText(L["rotationImport"] or "Import Rotation")
    importBtn:SetFullWidth(true)
    importBtn:SetCallback("OnClick", function()
        StaticPopup_Show("NAG_IMPORT_ROTATION_STRING")
        menu:Hide()
    end)
    scroll:AddChild(importBtn)
    -- Option: Automatic Rotation Switching
    local autoRotationToggle = AceGUI:Create("CheckBox")
    autoRotationToggle:SetLabel(L["autoRotationSwitching"] or "Automatic Rotation Switching")
    autoRotationToggle:SetDescription(
        "Automatically switch rotations based on target count, weapon type, and other context changes")
    autoRotationToggle:SetFullWidth(true)

    -- Set initial value
    local classModule = NAG:GetClassModule()
    if classModule then
        autoRotationToggle:SetValue(classModule:IsAutomaticRotationSwitchingEnabled())
    end

    autoRotationToggle:SetCallback("OnValueChanged", function(_, _, value)
        local classModule = NAG:GetClassModule()
        if classModule then
            classModule.db.char.enableAutomaticRotationSwitching = value
            -- Send message to notify other components that the setting changed
            local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
            local rotationName = nil
            if specIndex then
                local currentRotation = select(1, classModule:GetCurrentRotation(specIndex))
                rotationName = currentRotation and currentRotation.name
            end
            NAG:SendMessage(ns.Messages.ROTATION_CHANGED, {
                specIndex = specIndex,
                rotationName = rotationName,
                dataChanged = false,
                selectionChanged = true,
                autoRotationToggled = true,
                action = "auto_rotation_toggle"
            })
        end
    end)
    scroll:AddChild(autoRotationToggle)
    -- Add a close button at the bottom
    local closeBtn = AceGUI:Create("Button")
    closeBtn:SetText(L["close"] or "Close")
    closeBtn:SetFullWidth(true)
    closeBtn:SetCallback("OnClick", function()
        menu:Hide()
    end)
    scroll:AddChild(closeBtn)
    -- Position the menu at the cursor
    local x, y = GetCursorPosition()
    local scale = UIParent:GetEffectiveScale()
    menu:ClearAllPoints()
    menu:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x / scale, y / scale)
end

function MinimapSelector:ShowDevMenu()
    if not self.devMenuFrame then
        self.devMenuFrame = LUIDropDownMenu:Create_UIDropDownMenu("NAGMinimapSelectorDevMenu", UIParent)
    end
    local menu = {
        { text = "Next Action Guide Dev",   isTitle = true,                                                       notCheckable = true },
        { text = "Encounter Stopwatch",     func = function() NAG:GetModule("EncounterStopwatch"):Toggle() end,   notCheckable = true },
        { text = "APL Monitor",             func = function() NAG:GetModule("APLMonitor"):Toggle() end,           notCheckable = true },
        { text = "CLEU Debugger",           func = function() NAG:GetModule("CLEUDebugger"):Toggle() end,         notCheckable = true },
        { text = "Toggle Script Errors",    func = function() NAG:ToggleScriptErrors() end,                       notCheckable = true },
        { text = L["close"] or "Close",     func = function() end,                                                notCheckable = true },
    }
    LUIDropDownMenu:EasyMenu(menu, self.devMenuFrame, "cursor", 0, 0, "MENU")
end

function MinimapSelector:GetOptions()
    return {
        type = "group",
        name = L["rotationSelector"] or "Minimap/Rotation Selector",
        order = self.optionsOrder or 10,
        args = {
            minimapIcon = OptionsFactory:CreateToggle(
                L["minimapIcon"] or "Show Minimap Icon",
                L["minimapIconDesc"] or "Toggle the visibility of the minimap icon",
                function() return not self:GetSetting("global", "minimap.hide") end,
                function(_, value)
                    self:SetSetting("global", "minimap.hide", not value)
                    if value then
                        LibDBIcon:Show("NAGMinimapSelector")
                    else
                        LibDBIcon:Hide("NAGMinimapSelector")
                    end
                end,
                { order = 1 }
            ),
        },
    }
end

-- ============================ FRAME POSITION MENU ============================
function MinimapSelector:ToggleFrameEditMode(enable)
    if not DisplayManager then
        self:Warn("ToggleFrameEditMode: DisplayManager not available")
        return
    end

    if enable then
        if DisplayManager:IsGroupDisplayMode() then
            DisplayManager:EnableEditMode()
        end
        if DisplayManager:IsLegacyFrameEnabled() then
            DisplayManager:ToggleFrameEditMode(true)
        end
    else
        if DisplayManager:IsGroupDisplayMode() then
            DisplayManager:DisableEditMode()
        end
        if DisplayManager:IsLegacyFrameEnabled() then
            DisplayManager:ToggleFrameEditMode(false)
        end
    end
end

function MinimapSelector:GetActiveFrameSettings()
    if not DisplayManager or not DisplayManager.db then
        return nil
    end

    if DisplayManager:IsGroupDisplayMode() then
        return DisplayManager.db.char.groupDisplayFrame, "Group"
    end

    return DisplayManager.db.char.frameSettings, "Legacy"
end

function MinimapSelector:ApplyFrameOffsets(offsetX, offsetY)
    if not DisplayManager or not DisplayManager.db then
        self:Warn("ApplyFrameOffsets: DisplayManager not ready")
        return
    end

    local settings, modeLabel = self:GetActiveFrameSettings()
    if not settings then
        self:Warn("ApplyFrameOffsets: No active frame settings")
        return
    end

    settings.offsetX = offsetX
    settings.offsetY = offsetY

    if DisplayManager:IsGroupDisplayMode() and NAG.GroupDisplayFrame then
        local parent = DisplayManager:GetAnchorParent()
        NAG.GroupDisplayFrame:ClearAllPoints()
        NAG.GroupDisplayFrame:SetPoint(settings.point or "CENTER", parent, settings.relativePoint or "CENTER",
            settings.offsetX or 0, settings.offsetY or 0)
    else
        DisplayManager:UpdateFramePosition()
    end

    self:Info(string.format("Updated %s frame position: x=%s, y=%s", modeLabel, tostring(offsetX), tostring(offsetY)))
end

function MinimapSelector:ShowFramePositionMenu()
    if self.framePositionMenu and self.framePositionMenu:IsShown() then
        AceGUI:Release(self.framePositionMenu)
        self.framePositionMenu = nil
        return
    end

    local settings, modeLabel = self:GetActiveFrameSettings()
    if not settings then
        self:Warn("Frame position settings unavailable")
        return
    end

    local menu = AceGUI:Create("Frame")
    menu:SetTitle(L["framePosition"] or "Frame Position")
    menu:SetLayout("List")
    menu:EnableResize(false)
    menu:SetWidth(320)
    menu:SetHeight(240)
    menu:SetCallback("OnClose", function(widget)
        AceGUI:Release(widget)
        if self.framePositionMenu == widget then
            self.framePositionMenu = nil
        end
    end)
    self.framePositionMenu = menu

    local modeLabelText = AceGUI:Create("Label")
    modeLabelText:SetText(string.format("Active display: %s", modeLabel))
    modeLabelText:SetFullWidth(true)
    menu:AddChild(modeLabelText)

    local instructions = AceGUI:Create("Label")
    instructions:SetText("Unlock frames to drag the display. Use X/Y for exact positioning.")
    instructions:SetFullWidth(true)
    menu:AddChild(instructions)

    local unlockToggle = AceGUI:Create("CheckBox")
    unlockToggle:SetLabel(L["unlockFrame"] or "Unlock Frames")
    unlockToggle:SetDescription(L["unlockFrameDescription"] or "Enable drag and mouse controls for positioning")
    unlockToggle:SetValue(NAG:IsAnyEditMode())
    unlockToggle:SetFullWidth(true)
    unlockToggle:SetCallback("OnValueChanged", function(_, _, value)
        self:ToggleFrameEditMode(value)
    end)
    menu:AddChild(unlockToggle)

    local offsetXInput = AceGUI:Create("EditBox")
    offsetXInput:SetLabel(L["offsetX"] or "Offset X")
    offsetXInput:SetText(tostring(settings.offsetX or 0))
    offsetXInput:SetFullWidth(true)
    menu:AddChild(offsetXInput)

    local offsetYInput = AceGUI:Create("EditBox")
    offsetYInput:SetLabel(L["offsetY"] or "Offset Y")
    offsetYInput:SetText(tostring(settings.offsetY or 0))
    offsetYInput:SetFullWidth(true)
    menu:AddChild(offsetYInput)

    local applyButton = AceGUI:Create("Button")
    applyButton:SetText(L["apply"] or "Apply")
    applyButton:SetFullWidth(true)
    applyButton:SetCallback("OnClick", function()
        local xValue = tonumber(offsetXInput:GetText())
        local yValue = tonumber(offsetYInput:GetText())
        if xValue == nil or yValue == nil then
            self:Warn("Invalid coordinates. Please enter numeric values.")
            return
        end
        self:ApplyFrameOffsets(xValue, yValue)
    end)
    menu:AddChild(applyButton)
end

-- Shared click handler for both minimap and detached selector icon
function MinimapSelector:HandleSelectorClick(button)
    self:Debug("HandleSelectorClick called with button: " .. tostring(button))

    if button == "LeftButton" then
        if IsAltKeyDown() then
            self:ShowFramePositionMenu()
        else
            local AceConfigDialog = AceConfigDialog
            if AceConfigDialog.OpenFrames and AceConfigDialog.OpenFrames["NAG"] then
                AceConfigDialog:Close("NAG")
            else
                AceConfigDialog:Open("NAG")
            end
        end
    elseif button == "RightButton" then
        if IsControlKeyDown() then
            self:ShowDevMenu()
        elseif IsShiftKeyDown() then
            self:ShowSettingsMenu()
        else
            self:ShowRotationMenu()
        end
    end
end

-- Shared tooltip handler for both minimap and detached selector icon
function MinimapSelector:ShowSelectorTooltip(tooltipOrFrame)
    local tooltip = tooltipOrFrame
    if not tooltip.AddLine then -- If it's a frame, use GameTooltip
        tooltip = GameTooltip
        tooltip:SetOwner(tooltipOrFrame, "ANCHOR_RIGHT")
    end
    tooltip:AddLine(L["rotationSelector"] or "Rotation Selector")
    tooltip:AddLine("|cffeda55fLeft-click|r to open NAG options")
    tooltip:AddLine("|cffeda55fAlt+Left-click|r for frame position controls")
    tooltip:AddLine("|cffeda55fRight-click|r to select rotation")
    tooltip:AddLine("|cffeda55fUnlock Frames|r to drag, or enter exact X/Y")
    tooltip:AddLine("|cffeda55fShift+Right-click|r for selector settings")
    tooltip:AddLine("|cffeda55fCtrl+Right-click|r for dev menu")
    tooltip:Show()
end

-- Addon Compartment integration for Retail
function NAG_OnAddonCompartmentClick(frame, button)
    local MinimapSelector = NAG:GetModule("MinimapSelector")
    if MinimapSelector then
        MinimapSelector:HandleSelectorClick(button)
    end
end

function NAG_OnAddonCompartmentEnter(frame)
    local MinimapSelector = NAG:GetModule("MinimapSelector")
    if MinimapSelector then
        MinimapSelector:ShowSelectorTooltip(frame)
    end
end

function NAG_OnAddonCompartmentLeave(frame)
    GameTooltip:Hide()
end

-- Expose in private namespace
