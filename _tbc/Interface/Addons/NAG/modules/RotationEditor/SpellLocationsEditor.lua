--- @module "RotationEditor.SpellLocationsEditor"
--- Spell locations editor for RotationEditor
--- License: CC BY-NC 4.0
--- Authors: Rakizi, Fonsas

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- Module references
local EditorUtils = ns.RotationEditorUtils

-- Localizations
local AceGUI = ns.AceGUI
local L = ns.AceLocale:GetLocale("NAG", true)

-- Lua APIs
local format = string.format
local tinsert = tinsert
local tonumber = tonumber
local pairs = pairs
local ipairs = ipairs
local next = next
local sort = table.sort

-- ~~~~~~~~~~ MODULE DEFINITION ~~~~~~~~~~

local SpellLocationsEditor = {}
ns.RotationEditorSpellLocations = SpellLocationsEditor

-- ~~~~~~~~~~ SPELL LOCATIONS TAB ~~~~~~~~~~

--- Render the Spell Locations tab
--- @param container table AceGUI container
function SpellLocationsEditor:RenderSpellLocationsTab(container, editorState)
    container:SetLayout("Flow")

    local scrollContainer = AceGUI:Create("ScrollFrame")
    scrollContainer:SetLayout("Flow")
    scrollContainer:SetFullWidth(true)
    scrollContainer:SetFullHeight(true)
    container:AddChild(scrollContainer)

    -- Header
    local header = AceGUI:Create("Heading")
    header:SetText(L["spellLocations"] or "Spell Locations")
    header:SetFullWidth(true)
    scrollContainer:AddChild(header)

    -- Initialize spellLocations if not present
    if not editorState.workingConfig.spellLocations then
        editorState.workingConfig.spellLocations = {}
    end

    -- Toggle: useCustomSpellLocations
    local toggleCustom = AceGUI:Create("CheckBox")
    toggleCustom:SetLabel(L["useCustomSpellLocations"] or "Use Rotation-Specific Spell Locations")
    toggleCustom:SetFullWidth(true)
    toggleCustom:SetValue(editorState.workingConfig.useCustomSpellLocations == true)
    toggleCustom:SetCallback("OnValueChanged", function(widget, event, value)
        -- When enabling for first time, copy spec defaults if rotation has no locations yet
        if value and (not editorState.workingConfig.spellLocations or not next(editorState.workingConfig.spellLocations)) then
            local classModule = editorState.classModule
            if classModule and classModule.db and classModule.db.class.specSpellLocations and classModule.db.class.specSpellLocations[editorState.specIndex] then
                editorState.workingConfig.spellLocations = EditorUtils.CopyTable(classModule.db.class.specSpellLocations[editorState.specIndex])
                NAG:Print("|cFF00FF00Copied spec defaults to rotation spell locations|r")
            else
                editorState.workingConfig.spellLocations = {}
            end
        end

        editorState.workingConfig.useCustomSpellLocations = value
        EditorUtils.MarkDirty(editorState)
        -- Refresh the tab to show/hide relevant info
        self:RenderSpellLocationsTab(container, editorState)
    end)
    scrollContainer:AddChild(toggleCustom)

    -- Info label
    local infoLabel = AceGUI:Create("Label")
    if editorState.workingConfig.useCustomSpellLocations then
        infoLabel:SetText("|cFF00FF00Editing rotation-specific spell locations.|r\n|cFFFFD100These overrides only apply to this rotation.|r")
    else
        infoLabel:SetText("|cFF888888This tab is only visible when custom locations are enabled.|r\n|cFFFFD100Enable the toggle above to customize spell locations for this rotation.|r")
    end
    infoLabel:SetFullWidth(true)
    scrollContainer:AddChild(infoLabel)

    -- Show additional spellbook spells checkbox
    local showAdditionalToggle = AceGUI:Create("CheckBox")
    showAdditionalToggle:SetLabel(L["showAdditionalSpells"] or "Show Additional Spellbook Spells")
    showAdditionalToggle:SetDescription(L["showAdditionalSpellsDesc"] or "Show all castable spells from your spellbook, not just those in the rotation string")
    showAdditionalToggle:SetFullWidth(true)
    -- Initialize state if needed
    if editorState.showAdditionalSpells == nil then
        editorState.showAdditionalSpells = false
    end
    showAdditionalToggle:SetValue(editorState.showAdditionalSpells)
    showAdditionalToggle:SetCallback("OnValueChanged", function(widget, event, value)
        editorState.showAdditionalSpells = value
        -- Refresh current tab to show/hide additional spells
        EditorUtils.RefreshCurrentTab(SpellLocationsEditor, editorState)
    end)
    scrollContainer:AddChild(showAdditionalToggle)

    -- Extract spells from rotation string
    local spellsByName = self:ExtractSpellsFromRotation(editorState.workingConfig.rotationString or "")

    -- Convert to sorted array for alphabetical display
    local sortedSpells = {}
    for spellName, spellData in pairs(spellsByName) do
        tinsert(sortedSpells, {name = spellName, data = spellData})
    end
    sort(sortedSpells, function(a, b) return a.name < b.name end)

    -- Render spell dropdowns from rotation (alphabetically)
    for _, entry in ipairs(sortedSpells) do
        self:RenderSpellDropdown(scrollContainer, entry.name, entry.data, editorState)
    end

    -- Render additional spellbook spells if checkbox enabled
    if editorState.showAdditionalSpells then
        local additionalHeader = AceGUI:Create("Heading")
        additionalHeader:SetText(L["additionalSpellbookSpells"] or "Additional Spellbook Spells")
        additionalHeader:SetFullWidth(true)
        scrollContainer:AddChild(additionalHeader)

        self:RenderAdditionalSpellbookSpells(scrollContainer, spellsByName, editorState)
    end

    -- Copy Spec Defaults button
    local copyDefaultsBtn = AceGUI:Create("Button")
    copyDefaultsBtn:SetText(L["copySpecDefaults"] or "Copy Spec Defaults")
    copyDefaultsBtn:SetWidth(200)
    copyDefaultsBtn:SetCallback("OnClick", function()
        local classModule = editorState.classModule
        if classModule and classModule.db and classModule.db.class.specSpellLocations and classModule.db.class.specSpellLocations[editorState.specIndex] then
            editorState.workingConfig.spellLocations = EditorUtils.CopyTable(classModule.db.class.specSpellLocations[editorState.specIndex])
            EditorUtils.MarkDirty(editorState)
            self:RenderSpellLocationsTab(container, editorState)
            NAG:Print("|cFF00FF00Copied spec defaults to rotation spell locations|r")
        else
            NAG:Print("|cFFFF8800No spec defaults found to copy|r")
        end
    end)
    scrollContainer:AddChild(copyDefaultsBtn)

    -- Reset button
    local resetBtn = AceGUI:Create("Button")
    resetBtn:SetText(L["resetToDefaults"] or "Reset to Defaults")
    resetBtn:SetWidth(200)
    resetBtn:SetCallback("OnClick", function()
        editorState.workingConfig.spellLocations = {}
        editorState.workingConfig.useCustomSpellLocations = false
        EditorUtils.MarkDirty(editorState)
        self:RenderSpellLocationsTab(container, editorState)
        NAG:Print("|cFF00FF00Spell locations cleared (will use spec defaults)|r")
    end)
    scrollContainer:AddChild(resetBtn)
end

--- Extract spell IDs from rotation string
--- @param rotationString string The rotation string
--- @return table Spells organized by name {[name] = {name, icon, spellIds}}
function SpellLocationsEditor:ExtractSpellsFromRotation(rotationString)
    if not rotationString or rotationString == "" then
        return {}
    end

    local spellsByName = {}
    local SpellbookManager = NAG:GetModule("SpellbookManager")
    -- Patterns to match spell IDs in rotation strings
    local patterns = {
        "NAG:Cast%((%d+)",
        "NAG:Spell%((%d+)",
        "NAG:IsActive%((%d+)",
        "NAG:AuraIsActive%((%d+)",
        "spellId%s*=%s*(%d+)",
        "id%s*=%s*(%d+)"
    }

    for _, pattern in ipairs(patterns) do
        for spellId in rotationString:gmatch(pattern) do
            spellId = tonumber(spellId)
            if spellId then
                local spellEntry = SpellbookManager:GetSpell(spellId)
                if spellEntry then
                    local spellName = spellEntry.name
                    if not spellsByName[spellName] then
                        spellsByName[spellName] = {
                            name = spellName,
                            icon = spellEntry.icon,
                            spellIds = {}
                        }
                    end
                    -- Add spell ID if not already present
                    local found = false
                    for _, id in ipairs(spellsByName[spellName].spellIds) do
                        if id == spellId then
                            found = true
                            break
                        end
                    end
                    if not found then
                        tinsert(spellsByName[spellName].spellIds, spellId)
                    end
                end
            end
        end
    end

    return spellsByName
end

--- Render additional spellbook spells not in rotation string
--- @param container table AceGUI container
--- @param rotationSpells table Spells already shown from rotation
--- @param editorState table The editor state for this instance
function SpellLocationsEditor:RenderAdditionalSpellbookSpells(container, rotationSpells, editorState)
    local SpellbookManager = NAG:GetModule("SpellbookManager")
    -- Force spellbook scan for fresh data
    if SpellbookManager.ForceScan then
        SpellbookManager:ForceScan()
    end

    local castableSpells = SpellbookManager:GetCastableSpells()
    if not castableSpells or not next(castableSpells) then
        return
    end

    -- Collect additional spells not in rotation
    local additionalSpells = {}
    for spellId, spellEntry in pairs(castableSpells) do
        local spellName = spellEntry.name
        if not rotationSpells[spellName] then
            tinsert(additionalSpells, {
                name = spellName,
                data = {
                    name = spellName,
                    icon = spellEntry.icon,
                    spellIds = { spellId }
                }
            })
        end
    end

    -- Sort alphabetically
    sort(additionalSpells, function(a, b) return a.name < b.name end)

    -- Render sorted spells
    for _, entry in ipairs(additionalSpells) do
        self:RenderSpellDropdown(container, entry.name, entry.data, editorState)
    end
end

--- Render a spell location dropdown
--- @param container table AceGUI container
--- @param spellName string Spell name
--- @param spellData table Spell data {name, icon, spellIds}
--- @param order number Optional order for sorting (defaults to alphabetical)
function SpellLocationsEditor:RenderSpellDropdown(container, spellName, spellData, editorState, order)
    local dropdown = AceGUI:Create("Dropdown")
    local icon = spellData.icon and format("|T%s:16:16:0:0|t ", spellData.icon) or ""
    local displayName = spellName
    if #spellData.spellIds > 1 then
        displayName = displayName .. " (" .. #spellData.spellIds .. " ranks)"
    end
    dropdown:SetLabel(icon .. displayName)
    dropdown:SetRelativeWidth(0.5)
    dropdown:SetList(self:GetAvailablePositions())

    -- Get current position for this spell
    local currentPosition = ""
    for _, spellId in ipairs(spellData.spellIds) do
        if editorState.workingConfig.spellLocations[spellId] then
            currentPosition = editorState.workingConfig.spellLocations[spellId]
            break
        end
    end
    dropdown:SetValue(currentPosition)

    dropdown:SetCallback("OnValueChanged", function(widget, event, value)
        self:SetSpellLocation(spellData.spellIds, value, editorState)
    end)
    container:AddChild(dropdown)
end

--- Get available spell position options
--- @return table Position options {[key] = displayName}
function SpellLocationsEditor:GetAvailablePositions()
    return {
        [""] = L["preSet"] or "Default",
        [ns.SPELL_POSITIONS.LEFT] = L["left"] or "Left",
        [ns.SPELL_POSITIONS.RIGHT] = L["right"] or "Right",
        [ns.SPELL_POSITIONS.ABOVE] = L["above"] or "Above",
        [ns.SPELL_POSITIONS.BELOW] = L["below"] or "Below",
        [ns.SPELL_POSITIONS.AOE] = L["aoe"] or "AoE",
        [ns.SPELL_POSITIONS.PRIMARY] = L["primary"] or "Primary",
        [ns.SPELL_POSITIONS.SEQUENCE] = L["sequence"] or "Sequence"
    }
end

--- Set spell location for spell IDs
--- @param spellIds table Array of spell IDs
--- @param position string Position key
function SpellLocationsEditor:SetSpellLocation(spellIds, position, editorState)
    if not editorState.workingConfig.spellLocations then
        editorState.workingConfig.spellLocations = {}
    end

    for _, spellId in ipairs(spellIds) do
        if position ~= "" then
            editorState.workingConfig.spellLocations[spellId] = position
        else
            editorState.workingConfig.spellLocations[spellId] = nil
        end
    end

    EditorUtils.MarkDirty(editorState)
end

return SpellLocationsEditor

