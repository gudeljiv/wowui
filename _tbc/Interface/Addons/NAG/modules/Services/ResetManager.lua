--- @module 'NAG.ResetManager'
--- Smart reset system with configurable preservation groups for NAG addon
---
--- This module provides a configurable reset system that allows users to selectively
--- preserve certain groups of settings during resets, such as keybinds, UI layout,
--- and other user preferences.
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

--- ============================ LOCALIZE ============================
local _, ns = ...
local CreateFrame = _G.CreateFrame
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access

--- @type OptionsManager
--- @type DisplayManager
--- @type OptionsFactory
local OptionsManager, DisplayManager, OptionsFactory

local L = LibStub("AceLocale-3.0"):GetLocale("NAG", true)

-- WoW API for dialogs
local StaticPopup_Show = _G.StaticPopup_Show
local StaticPopup_OnClick = _G.StaticPopup_OnClick
local UIDropDownMenu_Initialize = _G.UIDropDownMenu_Initialize
local UIDropDownMenu_SetWidth = _G.UIDropDownMenu_SetWidth
local UIDropDownMenu_JustifyText = _G.UIDropDownMenu_JustifyText
local UIDropDownMenu_SetText = _G.UIDropDownMenu_SetText
local UIDropDownMenu_CreateInfo = _G.UIDropDownMenu_CreateInfo
local UIDropDownMenu_AddButton = _G.UIDropDownMenu_AddButton
local ACCEPT = _G.ACCEPT
local CANCEL = _G.CANCEL
local YES = _G.YES
local NO = _G.NO
local strsplit = strsplit
local ReloadUI = _G.ReloadUI

-- Lua APIs
local format = string.format
local pairs = pairs
local ipairs = ipairs
local type = type
local tostring = tostring
local CopyTable = _G.CopyTable
local wipe = wipe
local TableUtils = ns.TableUtils

--- ============================ PRIVATE HELPER FUNCTIONS ============================

--- Deep copy a table structure
--- @param orig table The original table to copy
--- @return table|nil The copied table, or nil if orig is not a table
local DeepCopyTable = TableUtils.DeepClone

--- Get a nested setting value using dot notation
--- @param db table The database table
--- @param path string The dot-notation path (e.g., "char.keybindOverrides")
--- @return any The value at the path, or nil if not found
local function GetNestedSetting(db, path)
    if not db or not path then
        return nil
    end

    local keys = { strsplit(".", path) }
    local current = db

    for _, key in ipairs(keys) do
        if type(current) == "table" and current[key] ~= nil then
            current = current[key]
        else
            return nil
        end
    end

    return current
end

--- Set a nested setting value using dot notation
--- @param db table The database table
--- @param path string The dot-notation path (e.g., "char.keybindOverrides")
--- @param value any The value to set
local function SetNestedSetting(db, path, value)
    if not db or not path then
        return
    end

    local keys = { strsplit(".", path) }
    local current = db

    -- Navigate to the parent of the target key
    for i = 1, #keys - 1 do
        local key = keys[i]
        if type(current[key]) ~= "table" then
            current[key] = {}
        end
        current = current[key]
    end

    -- Set the final value
    local finalKey = keys[#keys]
    current[finalKey] = value
end

--- ============================ MODULE ACCESS ============================

--- ============================ CONTENT ============================

--- Default preservation groups configuration
local defaultPreservationGroups = {
    keybinds = {
        name = L["keybinds"] or "Keybinds",
        description = L["keybindsDescription"] or "Preserve all keybind settings and overrides",
        settings = {
            char = { "keybindOverrides" },
            global = { "keybindSettings", "keybindConfig" }
        },
        alwaysPreserve = false
    },
    uiLayout = {
        name = L["uiLayout"] or "UI Layout",
        description = L["uiLayoutDescription"] or "Preserve frame positions, scales, and visibility settings",
        settings = {
            char = { "framePositions", "frameScales", "frameVisibility", "frameConfig" },
            global = { "uiConfig", "displaySettings" }
        },
        alwaysPreserve = false
    },
    rotations = {
        name = L["ResetManagerRotations"] or "Custom Rotations & APL Data",
        description = L["rotationsDescription"] or "Preserve all custom rotations, spell locations, and APL data",
        -- Note: specSpellLocations are stored in class module namespaces
        -- (e.g., NAG.db.namespaces.MONK.class.specSpellLocations), not in centralized NAG.db.class
        -- The ResetManager will handle accessing the correct module-specific locations
        settings = {
            char = { "selectedRotations" },
            class = { "specSpellLocations" }
        },
        alwaysPreserve = false
    },
    licenseKeys = {
        name = L["licenseKeys"] or "License Keys",
        description = L["licenseKeysDescription"] or "Preserve license key information",
        settings = {
            global = { "keys" }
        },
        alwaysPreserve = true -- Cannot be disabled
    },
    userPreferences = {
        name = L["userPreferences"] or "User Preferences",
        description = L["userPreferencesDescription"] or "Preserve user-specific preferences and customizations",
        settings = {
            char = { "userPreferences", "customSettings" },
            global = { "userConfig", "preferences" }
        },
        alwaysPreserve = false
    },
    aliases = {
        name = L["aliases"] or "Chat Aliases",
        description = L["aliasesDescription"] or "Preserve chat command aliases and shortcuts",
        settings = {
            global = { "chatAliases", "commandAliases" }
        },
        alwaysPreserve = false
    }
}

--- Default settings for the ResetManager
local defaults = {
    global = {
        resetPreservation = {
            enabled = false, -- Enable smart reset system TODO: Enable this
            preserveGroups = {
                keybinds = true,
                uiLayout = true,
                rotations = true,   -- Preserve rotations by default
                licenseKeys = true, -- Always true
                userPreferences = false,
                aliases = false
            }
        }
    }
}

--- Create the ResetManager module
--- @class ResetManager : CoreModule
local ResetManager = NAG:CreateModule("ResetManager", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,
    debugCategories = { ns.DEBUG_CATEGORIES.SYSTEM },
    hidden = function() return not NAG:IsDevModeEnabled() end,

    -- Automatic message registration
    messageHandlers = {
        NAG_DB_RESET = true
    }
})
local module = ResetManager
ns.ResetManager = ResetManager

--- Registered preservation groups from other modules
-- Structure: { groupName = { modules = { moduleName = groupConfig }, name = "Display Name", description = "Description" } }
ResetManager.registeredGroups = {}

--- Temporary storage for preserved settings during reset
ResetManager.preservedSettings = {}

--- ============================ MODULE LIFECYCLE ============================

function ResetManager:ModuleInitialize()
    -- ============================ MODULE ASSIGNMENT ============================
    -- Assign Ace3 modules directly (no metatable access)
    OptionsManager = NAG:GetModule("OptionsManager")
    DisplayManager = NAG:GetModule("DisplayManager")
    OptionsFactory = NAG:GetModule("OptionsFactory")

    -- ============================ MODULE INITIALIZATION ============================
    -- Initialize registered groups with new structure
    self.registeredGroups = {}
    for groupName, groupConfig in pairs(defaultPreservationGroups) do
        self.registeredGroups[groupName] = {
            modules = {}, -- Initialize with empty modules table
            name = groupConfig.name,
            description = groupConfig.description,
            alwaysPreserve = groupConfig.alwaysPreserve or false
        }
    end

    -- Message registration is now handled automatically via messageHandlers
end

function ResetManager:ModuleEnable()
end

function ResetManager:ModuleDisable()
    -- Clear temporary storage

    self.preservedSettings = {}
end

--- ============================ PRESERVATION GROUP MANAGEMENT ============================

--- Register a preservation group from another module
--- @param groupName string The name of the preservation group
--- @param groupConfig table The group configuration
--- @param moduleName string The name of the module registering (optional, defaults to "unknown")
function ResetManager:RegisterPreservationGroup(groupName, groupConfig, moduleName)
    if not groupName or not groupConfig then
        self:Error("RegisterPreservationGroup: Invalid parameters")
        return
    end

    -- Validate group configuration
    if not groupConfig.name or not groupConfig.description or not groupConfig.settings then
        self:Error("RegisterPreservationGroup: Invalid group configuration for " .. groupName)
        return
    end

    moduleName = moduleName or "unknown"

    -- Initialize group if it doesn't exist or migrate old structure
    if not self.registeredGroups[groupName] then
        self.registeredGroups[groupName] = {
            modules = {},
            name = groupConfig.name,
            description = groupConfig.description,
            alwaysPreserve = groupConfig.alwaysPreserve or false
        }
    elseif not self.registeredGroups[groupName].modules then
        -- Migrate old structure to new structure
        self:Debug("Migrating old group structure to new structure for: " .. groupName)
        local oldGroup = self.registeredGroups[groupName]
        self.registeredGroups[groupName] = {
            modules = {},
            name = oldGroup.name or groupConfig.name,
            description = oldGroup.description or groupConfig.description,
            alwaysPreserve = oldGroup.alwaysPreserve or groupConfig.alwaysPreserve or false
        }
    end

    -- Check for conflicts (same module registering same settings)
    if self.registeredGroups[groupName].modules[moduleName] then
        self:Warn("Module " ..
            moduleName ..
            " is re-registering preservation group " .. groupName .. " - this may indicate a configuration issue")
    end

    -- Register the module's settings for this group
    self.registeredGroups[groupName].modules[moduleName] = CopyTable(groupConfig)
    self:Debug("Registered module " .. moduleName .. " for preservation group: " .. groupName)
end

--- Get all available preservation groups
--- @return table The preservation groups
function ResetManager:GetPreservationGroups()
    return CopyTable(self.registeredGroups)
end

--- Get user's preservation preferences
--- @return table The user's preservation preferences
function ResetManager:GetPreservationPreferences()
    return self.db.global.resetPreservation.preserveGroups
end

--- Check if smart reset is enabled
--- @return boolean True if smart reset is enabled
function ResetManager:IsSmartResetEnabled()
    return self.db.global.resetPreservation.enabled
end

--- ============================ SETTING PRESERVATION ============================

--- Save settings that should be preserved based on user preferences
--- @param resetType string The type of reset being performed
function ResetManager:SavePreservedSettings(resetType)
    if not self:IsSmartResetEnabled() then
        self:Debug("Smart reset disabled, skipping preservation")
        return
    end

    self:Debug("Saving preserved settings for reset type: " .. resetType)

    -- Clear previous preserved settings
    self.preservedSettings = {}

    local preferences = self:GetPreservationPreferences()
    local db = OptionsManager:GetDatabase()

    if not db then
        self:Error("No database available for preservation")
        return
    end

    -- Save settings for each preservation group
    for groupName, groupData in pairs(self.registeredGroups) do
        -- Check if this group should be preserved
        local shouldPreserve = groupData.alwaysPreserve or preferences[groupName]

        if shouldPreserve then
            self:Debug("Preserving group: " .. groupName)
            self.preservedSettings[groupName] = {}

            -- Handle both old and new group structures
            if groupData.modules then
                -- New structure: multiple modules per group
                for moduleName, groupConfig in pairs(groupData.modules) do
                    self.preservedSettings[groupName][moduleName] = {}

                    -- Try to get the module's database
                    local moduleDB = nil
                    local module = NAG:GetModule(moduleName, true)
                    if module and module.db then
                        moduleDB = module.db
                    end

                    -- If no module-specific DB, fall back to main DB
                    if not moduleDB then
                        moduleDB = db
                    end

                    -- Save settings for each namespace
                    for namespace, settingPaths in pairs(groupConfig.settings) do
                        if moduleDB[namespace] then
                            self.preservedSettings[groupName][moduleName][namespace] = {}

                            for _, settingPath in ipairs(settingPaths) do
                                local value = GetNestedSetting(moduleDB[namespace], settingPath)
                                if value ~= nil then
                                    self.preservedSettings[groupName][moduleName][namespace][settingPath] = DeepCopyTable(
                                        value)
                                    self:Debug("Preserved: " .. moduleName .. "." .. namespace .. "." .. settingPath)
                                end
                            end
                        end
                    end
                end
            else
                -- Old structure: single module per group (backward compatibility)
                self:Debug("Using old group structure for: " .. groupName)
                self.preservedSettings[groupName] = {}

                -- Save settings for each namespace
                for namespace, settingPaths in pairs(groupData.settings) do
                    if db[namespace] then
                        self.preservedSettings[groupName][namespace] = {}

                        for _, settingPath in ipairs(settingPaths) do
                            local value = GetNestedSetting(db[namespace], settingPath)
                            if value ~= nil then
                                self.preservedSettings[groupName][namespace][settingPath] = DeepCopyTable(value)
                                self:Debug("Preserved: " .. namespace .. "." .. settingPath)
                            end
                        end
                    end
                end
            end
        end
    end
end

--- Restore preserved settings after reset
--- @param resetType string The type of reset being performed
function ResetManager:RestorePreservedSettings(resetType)
    if not self:IsSmartResetEnabled() or not self.preservedSettings then
        self:Debug("No preserved settings to restore")
        return
    end

    self:Debug("Restoring preserved settings for reset type: " .. resetType)

    local db = OptionsManager:GetDatabase()
    if not db then
        self:Error("No database available for restoration")
        return
    end

    -- Restore settings for each preserved group
    for groupName, groupData in pairs(self.preservedSettings) do
        self:Debug("Restoring group: " .. groupName)

        -- Check if this is new structure (module-based) or old structure (namespace-based)
        local isNewStructure = false
        for moduleName, moduleData in pairs(groupData) do
            if type(moduleData) == "table" and moduleData.global or moduleData.char or moduleData.class then
                isNewStructure = true
                break
            end
        end

        if isNewStructure then
            -- New structure: module-based restoration
            for moduleName, moduleData in pairs(groupData) do
                -- Try to get the module's database
                local moduleDB = nil
                local module = NAG:GetModule(moduleName, true)
                if module and module.db then
                    moduleDB = module.db
                end

                -- If no module-specific DB, fall back to main DB
                if not moduleDB then
                    moduleDB = db
                end

                -- Restore settings for each namespace
                for namespace, settings in pairs(moduleData) do
                    if moduleDB[namespace] then
                        for settingPath, value in pairs(settings) do
                            SetNestedSetting(moduleDB[namespace], settingPath, DeepCopyTable(value))
                            self:Debug("Restored: " .. moduleName .. "." .. namespace .. "." .. settingPath)
                        end
                    end
                end
            end
        else
            -- Old structure: namespace-based restoration (backward compatibility)
            for namespace, settings in pairs(groupData) do
                if db[namespace] then
                    for settingPath, value in pairs(settings) do
                        SetNestedSetting(db[namespace], settingPath, DeepCopyTable(value))
                        self:Debug("Restored: " .. namespace .. "." .. settingPath)
                    end
                end
            end
        end
    end

    -- Clear preserved settings
    self.preservedSettings = {}

    -- Notify modules that settings have been restored
    NAG:SendMessage("NAG_RESET_PRESERVATION_RESTORED", resetType)
end

--- ============================ SMART RESET FUNCTIONS ============================

--- Perform a smart reset with preservation
--- @param resetType string The type of reset to perform ("all", "global", "char", "class")
function ResetManager:PerformSmartReset(resetType)
    self:Debug("Performing smart reset for type: " .. resetType)

    -- Check if smart reset is enabled
    if not self:IsSmartResetEnabled() then
        self:Debug("Smart reset disabled, performing normal reset")
        self:PerformNormalReset(resetType)
        return
    end

    -- Save settings that should be preserved
    self:SavePreservedSettings(resetType)

    -- Perform the normal reset
    self:PerformNormalReset(resetType)

    -- Restore preserved settings
    self:RestorePreservedSettings(resetType)

    self:Debug("Smart reset completed for type: " .. resetType)
end

--- Perform a normal reset (without preservation)
--- @param resetType string The type of reset to perform
function ResetManager:PerformNormalReset(resetType)
    self:Debug("Performing normal reset for type: " .. resetType)

        -- Perform the actual reset based on type
    if resetType == "all" then
        -- Disable addon first
        NAG:Disable()

        -- Preserve keys before reset (same as global reset)
        local tempKeys = CopyTable(OptionsManager:GetKeys())

        -- Reset the database through OptionsManager
        local db = OptionsManager:GetDatabase()
        if db then
            db:ResetDB(true)
            -- Restore keys after reset (preserving user's license keys)
            OptionsManager:SetKeys(tempKeys)
        end

        NAG:SendMessage("NAG_DB_RESET", "all")
        self:ShowReloadDialog()
    elseif resetType == "global" then
        local db = OptionsManager:GetDatabase()
        if db and db.global then
            -- Preserve keys before reset
            local tempKeys = CopyTable(OptionsManager:GetKeys())
            wipe(db.global)
            -- Use OptionsManager's defaults instead of NAG.defaults
            db:RegisterDefaults(OptionsManager.defaults)
            -- Restore keys after reset (preserving user's license keys)
            OptionsManager:SetKeys(tempKeys)
        end
        NAG:SendMessage("NAG_DB_RESET", "global")
    elseif resetType == "char" then
        local db = OptionsManager:GetDatabase()
        if db and db.char then
            wipe(db.char)
            -- Use OptionsManager's defaults instead of NAG.defaults
            db:RegisterDefaults(OptionsManager.defaults)
        end
        NAG:SendMessage("NAG_DB_RESET", "char")

        -- Update display after character reset

        DisplayManager:UpdateFramePosition()
        DisplayManager:UpdateFrameScale()
        DisplayManager:ToggleFrameEditMode(false)
    elseif resetType == "class" then
        local db = OptionsManager:GetDatabase()
        if db and db.class then
            wipe(db.class)
            -- Use OptionsManager's defaults instead of NAG.defaults
            db:RegisterDefaults(OptionsManager.defaults)
        end
        NAG:SendMessage("NAG_DB_RESET", "class")
    else
        self:Error("Unknown reset type: " .. tostring(resetType))
    end
end

--- ============================ EVENT HANDLERS ============================

--- Handle database reset events
--- @param event string The event name
--- @param resetType string The type of reset that occurred
function ResetManager:NAG_DB_RESET(event, resetType)
    self:Debug("Database reset event received: " .. resetType)

    -- If this was a smart reset, we don't need to do anything here
    -- as the preservation is handled in PerformSmartReset
    -- This is mainly for logging and debugging
end

--- ============================ OPTIONS UI ============================

function ResetManager:GetOptions()
    local options = {
        type = "group",
        name = L["resetManager"] or "Reset Manager",
        desc = L["resetManagerDesc"] or "Configure smart reset system with selective preservation",
        --childGroups = "tree",
        args = {
            -- Smart Reset Configuration
            smartResetHeader = OptionsFactory:CreateHeader(
                function() return L["smartResetConfiguration"] or "Smart Reset Configuration" end,
                { order = 1 }
            ),
            smartResetDesc = {
                type = "description",
                name = "",
                order = 2,
                fontSize = "medium",
                width = "full",
                func = function() return L["smartResetDesc"] or "Configure which settings to preserve during resets" end
            },
            enabled = OptionsFactory:CreateToggle(
                function() return L["enableSmartReset"] or "Enable Smart Reset" end,
                function()
                    return L["enableSmartResetDesc"] or
                        "Enable the smart reset system with selective preservation"
                end,
                function() return self:IsSmartResetEnabled() end,
                function(_, value)
                    self:SetSetting("global", "resetPreservation.enabled", value)
                end,
                {
                    order = 3,
                    width = "full"
                }
            ),

            -- Preservation Groups
            preservationGroupsHeader = OptionsFactory:CreateHeader(
                function() return L["preservationGroups"] or "Preservation Groups" end,
                { order = 10 }
            ),
            preservationGroupsDesc = {
                type = "description",
                name = "",
                order = 11,
                fontSize = "medium",
                width = "full",
                func = function()
                    return L["preservationGroupsDesc"] or
                        "Select which groups of settings to preserve during resets:"
                end
            },
        }
    }

    -- Add preservation group toggles
    local order = 20
    for groupName, groupData in pairs(self.registeredGroups) do
        if groupData.alwaysPreserve ~= true then
            local name, description

            if groupData.modules then
                -- New structure: multiple modules per group
                name = groupData.name
                local moduleList = {}
                for moduleName in pairs(groupData.modules) do
                    table.insert(moduleList, moduleName)
                end
                table.sort(moduleList)

                description = groupData.description
                if #moduleList > 0 then
                    description = description .. "\n\nModules: " .. table.concat(moduleList, ", ")
                end
            else
                -- Old structure: single module per group (backward compatibility)
                name = groupData.name
                description = groupData.description
            end

            options.args["preserve_" .. groupName] = OptionsFactory:CreateToggle(
                function() return name end,
                function() return description end,
                function()
                    local preferences = self:GetPreservationPreferences()
                    return preferences[groupName] or false
                end,
                function(_, value)
                    local preferences = self:GetPreservationPreferences()
                    preferences[groupName] = value
                    self:SetSetting("global", "resetPreservation.preserveGroups", preferences)
                end,
                {
                    order = order,
                    width = "full"
                }
            )
            order = order + 1
        else
            -- Show always-preserved groups as disabled toggles
            local name, description
            if groupData.modules then
                name = groupData.name
                description = groupData.description .. " (Always Preserved)"
            else
                name = groupData.name
                description = groupData.description .. " (Always Preserved)"
            end

            options.args["preserve_" .. groupName] = OptionsFactory:CreateToggle(
                function() return name end,
                function() return description end,
                function() return true end,
                function() end,
                {
                    order = order,
                    width = "full",
                    disabled = true
                }
            )
            order = order + 1
        end
    end

    -- Add Smart Reset Actions
    options.args.smartResetActionsHeader = OptionsFactory:CreateHeader(
        function() return L["smartResetActions"] or "Smart Reset Actions" end,
        { order = 100 }
    )
    options.args.smartResetAll = OptionsFactory:CreateExecute(
        function() return L["smartResetAll"] or "Smart Reset All" end,
        function() return L["smartResetAllDesc"] or "Reset all settings while preserving selected groups" end,
        function()
            self:PerformSmartReset("all")
        end,
        {
            order = 101,
            width = "full",
            confirm = true,
            confirmText = L["smartResetAllConfirm"] or
                "Are you sure you want to perform a smart reset? This will reset all settings while preserving your selected groups."
        }
    )

    return options
end

--- ============================ PUBLIC API ============================

--- Get the ResetManager instance
--- @return ResetManager The ResetManager instance
function ResetManager:GetInstance()
    return self
end

--- ============================ RESET DIALOGS ============================

-- Reload UI dialog
StaticPopupDialogs["NAG_RELOAD_UI"] = {
    text = L["reloadUIPrompt"] or "Reload UI to apply changes?",
    button1 = YES,
    button2 = NO,
    OnShow = function(dialog)
        dialog:SetFrameStrata("FULLSCREEN_DIALOG")
        dialog:SetFrameLevel(200)
    end,
    OnAccept = function() ReloadUI() end,
    enterClicksFirstButton = true,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

-- Reset dialog definitions
StaticPopupDialogs["NAG_RESET_TYPE"] = {
    text = L["resetTypeSelect"] or "Select which settings to reset:",
    button1 = ACCEPT,
    button2 = CANCEL,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    height = 150,  -- Increased height to accommodate dropdown
    EditBoxOnEscapePressed = function(editBox)
        editBox:GetParent():Hide()
    end,
    OnHide = function(dialog)
        if dialog.dropDown then
            dialog.dropDown:Hide()
            dialog.dropDown = nil
        end
    end,
    OnCancel = function(dialog)
        if dialog.dropDown then
            dialog.dropDown:Hide()
            dialog.dropDown = nil
        end
    end,
    OnShow = function(dialog)
        dialog:SetFrameStrata("FULLSCREEN_DIALOG")
        dialog:SetFrameLevel(200)

        if dialog.dropDown then
            dialog.dropDown:Hide()
            dialog.dropDown = nil
        end

        local dropdown = CreateFrame("Frame", dialog:GetName() .. "DropDown", dialog, "UIDropDownMenuTemplate")
        dropdown:SetPoint("CENTER", 0, -20)  -- Move dropdown down to avoid overlapping with text
        dialog.dropDown = dropdown

        local function OnClick(_, arg1)
            dialog.data = arg1
            UIDropDownMenu_SetText(dialog.dropDown, arg1.text)
        end

        local function Initialize(frame, level)
            local info = UIDropDownMenu_CreateInfo()
            info.func = OnClick

            -- Position/Display Settings (Default)
            info.text = L["resetPosition"] or "Reset Position"
            info.arg1 = { type = "position", text = info.text }
            UIDropDownMenu_AddButton(info)

            -- License Keys
            info.text = L["resetKeys"] or "License Keys"
            info.arg1 = { type = "keys", text = info.text }
            UIDropDownMenu_AddButton(info)

            -- Character Settings
            info.text = L["resetCharacter"] or "Character Settings"
            info.arg1 = { type = "char", text = info.text }
            UIDropDownMenu_AddButton(info)

            -- Class Settings
            info.text = L["resetClass"] or "Class Settings"
            info.arg1 = { type = "class", text = info.text }
            UIDropDownMenu_AddButton(info)

            -- Global Settings
            info.text = L["resetGlobal"] or "Global Settings"
            info.arg1 = { type = "global", text = info.text }
            UIDropDownMenu_AddButton(info)

            -- All Settings
            info.text = L["resetAll"] or "All Settings"
            info.arg1 = { type = "all", text = info.text }
            UIDropDownMenu_AddButton(info)
        end

        UIDropDownMenu_Initialize(dialog.dropDown, Initialize)
        UIDropDownMenu_SetWidth(dialog.dropDown, 200)
        UIDropDownMenu_JustifyText(dialog.dropDown, "LEFT")

        -- Set default selection to Position & Display
        dialog.data = { type = "position", text = L["resetPosition"] or "Reset Position" }
        UIDropDownMenu_SetText(dialog.dropDown, dialog.data.text)

        -- Ensure dropdown is visible
        dialog.dropDown:Show()
    end,
    OnAccept = function(dialog)
        if not dialog.data then return end

        local resetType = dialog.data.type
        if resetType == "all" then
            ResetManager:PerformSmartReset("all")
        elseif resetType == "global" then
            ResetManager:PerformSmartReset("global")
        elseif resetType == "char" then
            ResetManager:PerformSmartReset("char")
        elseif resetType == "class" then
            ResetManager:PerformSmartReset("class")
        elseif resetType == "position" then
            ResetManager:ResetPosition()
        elseif resetType == "keys" then
            ResetManager:ShowResetConfirmDialog(L["resetKeysConfirm"],
                function() ResetManager:ResetKeys() end)
        end
    end,
}

StaticPopupDialogs["NAG_RESET_CONFIRM"] = {
    text = L["resetConfirm"] or "Are you sure you want to reset? This cannot be undone.",
    button1 = YES,
    button2 = NO,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    EditBoxOnEscapePressed = function(editBox)
        editBox:GetParent():Hide()
    end,
    OnShow = function(dialog)
        dialog:SetFrameStrata("FULLSCREEN_DIALOG")
        dialog:SetFrameLevel(200)
    end,
}

--- ============================ RESET DIALOG FUNCTIONS ============================

--- Show reload UI dialog
function ResetManager:ShowReloadDialog(text)
    StaticPopupDialogs["NAG_RELOAD_UI"].text = text or (L["reloadUIPrompt"] or "Reload UI to apply changes?")
    StaticPopup_Show("NAG_RELOAD_UI")
end

--- Show the reset type selection dialog
function ResetManager:ShowResetTypeDialog()
    StaticPopup_Show("NAG_RESET_TYPE")
end

--- Show a confirmation dialog for resets
--- @param text string The confirmation text
--- @param acceptFunc function The function to call on accept
function ResetManager:ShowResetConfirmDialog(text, acceptFunc)
    StaticPopupDialogs["NAG_RESET_CONFIRM"].text = text or
        (L["resetConfirm"] or "Are you sure you want to reset? This cannot be undone.")
    StaticPopupDialogs["NAG_RESET_CONFIRM"].OnAccept = function()
        if type(acceptFunc) == "function" then
            acceptFunc()
        end
    end
    StaticPopup_Show("NAG_RESET_CONFIRM")
end

--- Reset frame position settings to default
function ResetManager:ResetPosition()
    if DisplayManager.ResetFrameSettingsToDefault then
        DisplayManager:ResetFrameSettingsToDefault()
    end
    DisplayManager:UpdateFramePosition()
    DisplayManager:UpdateFrameScale()
    DisplayManager:ToggleFrameEditMode(false)
    NAG:SendMessage("NAG_FRAME_UPDATED")
end

--- Reset all license key information
function ResetManager:ResetKeys()
    self:Debug("Resetting all license key information")
    ns.clearKeys()
    NAG:SendMessage("NAG_KEYS_RESET")
    self:Info("All license key information has been cleared from the database")
end

--- ============================ EXPORT ============================
