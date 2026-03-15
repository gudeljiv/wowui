--- @module "RotationEditor.SmartSwitchingEditor"
--- Smart switching condition editor for RotationEditor
--- License: CC BY-NC 4.0
--- Authors: Rakizi, Fonsas

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- Module references
local EditorUtils = ns.RotationEditorUtils

-- Localizations
local L = ns.AceLocale:GetLocale("NAG", true)
local Libs = ns.Libs

-- Lua APIs
local format = string.format
local tinsert = tinsert
local tremove = tremove
local tostring = tostring
local tonumber = tonumber
local type = type
local ipairs = ipairs
local math_max = math.max
local UnitHealth = _G.UnitHealth
local UnitHealthMax = _G.UnitHealthMax

-- ~~~~~~~~~~ MODULE DEFINITION ~~~~~~~~~~

local SmartSwitchingEditor = {}
ns.RotationEditorSmartSwitching = SmartSwitchingEditor

-- ~~~~~~~~~~ SMART SWITCHING TAB ~~~~~~~~~~

--- Render the Smart Switching tab
--- @param container table Libs.AceGUI container
function SmartSwitchingEditor:RenderSmartSwitchingTab(container, editorState)
    container:SetLayout("Flow")

    local scrollContainer = Libs.AceGUI:Create("ScrollFrame")
    scrollContainer:SetLayout("Flow")
    scrollContainer:SetFullWidth(true)
    scrollContainer:SetFullHeight(true)
    container:AddChild(scrollContainer)

    -- Explanation section
    local explainHeader = Libs.AceGUI:Create("Heading")
    explainHeader:SetText(L["howItWorks"] or "How Smart Switching Works")
    explainHeader:SetFullWidth(true)
    scrollContainer:AddChild(explainHeader)

    local explanation = Libs.AceGUI:Create("Label")
    explanation:SetText("|cFFFFD100Smart Switching automatically selects the optimal rotation based on conditions you define.\n\n" ..
        "• Multiple rotations can have |cFF00FF00enableSmartSwitching = true|r\n" ..
        "• Rotations with |cFF00FF00customConditions|r are prioritized when ALL conditions are met\n" ..
        "• Rotations without conditions can serve as fallbacks when no conditions match\n" ..
        "• NAG evaluates conditions in real-time (target count, weapon type, assignments, etc.)\n" ..
        "• The first rotation with ALL conditions met becomes active\n" ..
        "• If no rotation matches, a fallback rotation (or default) is used|r")
    explanation:SetFullWidth(true)
    scrollContainer:AddChild(explanation)

    -- Quick-add templates section
    local templatesHeader = Libs.AceGUI:Create("Heading")
    templatesHeader:SetText(L["commonTemplates"] or "Common Condition Templates")
    templatesHeader:SetFullWidth(true)
    scrollContainer:AddChild(templatesHeader)

    local templatesDesc = Libs.AceGUI:Create("Label")
    templatesDesc:SetText("|cFF888888Click to quickly add common condition patterns:|r")
    templatesDesc:SetFullWidth(true)
    scrollContainer:AddChild(templatesDesc)

    -- Template buttons container
    local templatesGroup = Libs.AceGUI:Create("SimpleGroup")
    templatesGroup:SetLayout("Flow")
    templatesGroup:SetFullWidth(true)
    scrollContainer:AddChild(templatesGroup)

    -- Single Target template
    local stBtn = Libs.AceGUI:Create("Button")
    stBtn:SetText("+ Single Target (1-2)")
    stBtn:SetWidth(180)
    stBtn:SetCallback("OnClick", function()
        self:AddConditionTemplate("single_target", editorState)
    end)
    templatesGroup:AddChild(stBtn)

    -- Cleave template
    local cleaveBtn = Libs.AceGUI:Create("Button")
    cleaveBtn:SetText("+ Cleave (1-3)")
    cleaveBtn:SetWidth(180)
    cleaveBtn:SetCallback("OnClick", function()
        self:AddConditionTemplate("cleave", editorState)
    end)
    templatesGroup:AddChild(cleaveBtn)

    -- AOE 3+ template
    local aoe3Btn = Libs.AceGUI:Create("Button")
    aoe3Btn:SetText("+ AOE (3+ targets)")
    aoe3Btn:SetWidth(180)
    aoe3Btn:SetCallback("OnClick", function()
        self:AddConditionTemplate("aoe3", editorState)
    end)
    templatesGroup:AddChild(aoe3Btn)

    -- AOE 4+ template
    local aoe4Btn = Libs.AceGUI:Create("Button")
    aoe4Btn:SetText("+ AOE (4+ targets)")
    aoe4Btn:SetWidth(180)
    aoe4Btn:SetCallback("OnClick", function()
        self:AddConditionTemplate("aoe4", editorState)
    end)
    templatesGroup:AddChild(aoe4Btn)

    -- Dual Wield template
    local dwBtn = Libs.AceGUI:Create("Button")
    dwBtn:SetText("+ Dual Wield")
    dwBtn:SetWidth(180)
    dwBtn:SetCallback("OnClick", function()
        self:AddConditionTemplate("dual_wield", editorState)
    end)
    templatesGroup:AddChild(dwBtn)

    -- Two-Hand template
    local thBtn = Libs.AceGUI:Create("Button")
    thBtn:SetText("+ Two-Hand")
    thBtn:SetWidth(180)
    thBtn:SetCallback("OnClick", function()
        self:AddConditionTemplate("two_hand", editorState)
    end)
    templatesGroup:AddChild(thBtn)

    -- Current conditions header
    local header = Libs.AceGUI:Create("Heading")
    header:SetText(L["customConditions"] or "Current Conditions")
    header:SetFullWidth(true)
    scrollContainer:AddChild(header)

    local desc = Libs.AceGUI:Create("Label")
    desc:SetText(L["customConditionsDesc"] or "All conditions below must be satisfied for this rotation to be selected. Click Edit to modify or Add Condition to create a new one.")
    desc:SetFullWidth(true)
    scrollContainer:AddChild(desc)

    -- Initialize customConditions if not present
    if not editorState.workingConfig.customConditions then
        editorState.workingConfig.customConditions = {}
    end

    -- List existing conditions
    local conditions = editorState.workingConfig.customConditions
    for i, condition in ipairs(conditions) do
        self:RenderConditionSummary(scrollContainer, condition, i, editorState)
    end

    -- Add condition button
    local addBtn = Libs.AceGUI:Create("Button")
    addBtn:SetText(L["addCondition"] or "Add Condition")
    addBtn:SetWidth(200)
    addBtn:SetCallback("OnClick", function()
        self:ShowConditionEditor(nil, function(newCondition)
            tinsert(editorState.workingConfig.customConditions, newCondition)
            EditorUtils.MarkDirty(editorState)
            NAG:Print("|cFF00FF00Condition added (remember to Save rotation)|r")
            -- Re-render the tab to show changes
            EditorUtils.RefreshCurrentTab(SmartSwitchingEditor, editorState)
        end)
    end)
    scrollContainer:AddChild(addBtn)
end

--- Add a condition from a template
--- @param templateType string Template type identifier
function SmartSwitchingEditor:AddConditionTemplate(templateType, editorState)
    if not editorState.workingConfig.customConditions then
        editorState.workingConfig.customConditions = {}
    end

    local newCondition

    if templateType == "single_target" then
        newCondition = {
            type = ns.CUSTOM_CONDITION_TYPES.TARGET_COUNT,
            value = { min = 1, max = 2, operator = "range" },
            range = 8
        }
    elseif templateType == "cleave" then
        newCondition = {
            type = ns.CUSTOM_CONDITION_TYPES.TARGET_COUNT,
            value = { min = 1, max = 3, operator = "range" },
            range = 8
        }
    elseif templateType == "aoe3" then
        newCondition = {
            type = ns.CUSTOM_CONDITION_TYPES.TARGET_COUNT,
            value = { value = 3, operator = "gte" },
            range = 8
        }
    elseif templateType == "aoe4" then
        newCondition = {
            type = ns.CUSTOM_CONDITION_TYPES.TARGET_COUNT,
            value = { value = 4, operator = "gte" },
            range = 8
        }
    elseif templateType == "dual_wield" then
        newCondition = {
            type = ns.CUSTOM_CONDITION_TYPES.WEAPON_TYPE,
            value = "dualWield"
        }
    elseif templateType == "two_hand" then
        newCondition = {
            type = ns.CUSTOM_CONDITION_TYPES.WEAPON_TYPE,
            value = "twoHand"
        }
    else
        NAG:Error("Unknown template type: " .. tostring(templateType))
        return
    end

    tinsert(editorState.workingConfig.customConditions, newCondition)
    EditorUtils.MarkDirty(editorState)
    NAG:Print("|cFF00FF00Condition added from template (remember to Save rotation)|r")
    EditorUtils.RefreshCurrentTab(SmartSwitchingEditor, editorState)
end

--- Render a summary of a condition
--- @param container table Libs.AceGUI container
--- @param condition table The condition data
--- @param index number The condition index
--- @param editorState table The editor state for this instance
function SmartSwitchingEditor:RenderConditionSummary(container, condition, index, editorState)
    local group = Libs.AceGUI:Create("InlineGroup")
    group:SetTitle(format("Condition #%d: %s", index, condition.type or "Unknown"))
    group:SetFullWidth(true)
    group:SetLayout("Flow")
    container:AddChild(group)

    -- Summary text
    local summaryText = self:GetConditionSummary(condition)
    local label = Libs.AceGUI:Create("Label")
    label:SetText(summaryText)
    label:SetRelativeWidth(0.7)
    group:AddChild(label)

    -- Edit button
    local editBtn = Libs.AceGUI:Create("Button")
    editBtn:SetText(L["edit"] or "Edit")
    editBtn:SetWidth(80)
    editBtn:SetCallback("OnClick", function()
        self:ShowConditionEditor(condition, function(updatedCondition)
            editorState.workingConfig.customConditions[index] = updatedCondition
            EditorUtils.MarkDirty(editorState)
            NAG:Print("|cFF00FF00Condition updated (remember to Save rotation)|r")
            -- Re-render the tab to show changes
            EditorUtils.RefreshCurrentTab(SmartSwitchingEditor, editorState)
        end)
    end)
    group:AddChild(editBtn)

    -- Delete button
    local deleteBtn = Libs.AceGUI:Create("Button")
    deleteBtn:SetText(L["delete"] or "Delete")
    deleteBtn:SetWidth(80)
    deleteBtn:SetCallback("OnClick", function()
        tremove(editorState.workingConfig.customConditions, index)
        EditorUtils.MarkDirty(editorState)
        NAG:Print("|cFF00FF00Condition deleted (remember to Save rotation)|r")
        EditorUtils.RefreshCurrentTab(SmartSwitchingEditor, editorState)
    end)
    group:AddChild(deleteBtn)
end

--- Get a human-readable summary of a condition
--- @param condition table The condition data
--- @return string Summary text
function SmartSwitchingEditor:GetConditionSummary(condition)
    if not condition or not condition.type then
        return "|cFFFF0000Invalid condition|r"
    end

    local condType = condition.type
    local value = condition.value

    if condType == ns.CUSTOM_CONDITION_TYPES.TARGET_COUNT then
        if type(value) == "table" then
            if value.operator == "range" then
                return format("Target Count: %d to %d targets", value.min or 0, value.max or 0)
            elseif value.operator == "eq" then
                return format("Target Count: exactly %d", value.value or 0)
            elseif value.operator == "lt" then
                return format("Target Count: less than %d", value.value or 0)
            elseif value.operator == "lte" then
                return format("Target Count: %d or fewer", value.value or 0)
            elseif value.operator == "gt" then
                return format("Target Count: more than %d", value.value or 0)
            elseif value.operator == "gte" then
                return format("Target Count: %d or more", value.value or 0)
            end
        end
        return "Target Count: " .. tostring(value)
    elseif condType == ns.CUSTOM_CONDITION_TYPES.WEAPON_TYPE then
        return "Weapon Type: " .. tostring(value)
    elseif condType == ns.CUSTOM_CONDITION_TYPES.AURA_ACTIVE then
        if type(value) == "table" then
            local unit = value.unit or "player"
            local spellID = value.spellId or value.spellID or "?"
            local operator = value.operator or "active"

            if operator == "inactive" then
                return format("Aura Inactive: %s on %s", tostring(spellID), unit)
            elseif operator == "stacks" then
                local stacks = value.stacks or 1
                return format("Aura Stacks: %s on %s (%d+ stacks)", tostring(spellID), unit, stacks)
            else
                return format("Aura Active: %s on %s", tostring(spellID), unit)
            end
        end
        return "Aura Active"
    elseif condType == ns.CUSTOM_CONDITION_TYPES.GROUP_CONTEXT then
        if type(value) == "table" then
            return "Group Context: " .. table.concat(value, ", ")
        end
        return "Group Context: " .. tostring(value)
    elseif condType == ns.CUSTOM_CONDITION_TYPES.ASSIGNMENT then
        if type(value) == "table" then
            -- Get assignment names from class module
            local classModule = NAG:GetClassModule()
            if classModule then
                local assignments = classModule.defaults.class.classAssignments or {}
                local assignmentMap = {}
                for _, assignment in ipairs(assignments) do
                    assignmentMap[assignment.id] = assignment.name or assignment.id
                end
                local names = {}
                for _, assignmentId in ipairs(value) do
                    tinsert(names, assignmentMap[assignmentId] or assignmentId)
                end
                if #names > 0 then
                    return "Assignments: " .. table.concat(names, ", ")
                end
            end
            return "Assignments: " .. table.concat(value, ", ")
        end
        return "Assignment: " .. tostring(value)
    elseif condType == ns.CUSTOM_CONDITION_TYPES.CUSTOM_FUNCTION then
        return "Custom Function"
    end

    return "Condition: " .. condType
end

--- Show condition editor dialog
--- @param condition table|nil Existing condition to edit, or nil for new
--- @param onSave function Callback when saved
function SmartSwitchingEditor:ShowConditionEditor(condition, onSave)

    local function releaseWidget(widget)
        if not widget then
            return
        end
        if Libs.AceGUI.Release then
            Libs.AceGUI:Release(widget)
        elseif widget.ReleaseChildren then
            widget:ReleaseChildren()
        end
    end

    local Validation = ns.RotationEditorValidation

    -- Create a working copy
    local working = condition and EditorUtils.CopyTable(condition) or {type = ns.CUSTOM_CONDITION_TYPES.TARGET_COUNT, value = {}}

    local frame = Libs.AceGUI:Create("Frame")
    frame:SetTitle(condition and (L["editCondition"] or "Edit Condition") or (L["addCondition"] or "Add Condition"))
    frame:SetLayout("Fill")
    frame:SetWidth(600)
    frame:SetHeight(550)
    frame:SetCallback("OnClose", function(widget)
        releaseWidget(widget)
    end)

    -- Create main container with proper layout
    local mainContainer = Libs.AceGUI:Create("SimpleGroup")
    mainContainer:SetLayout("List")
    mainContainer:SetFullWidth(true)
    mainContainer:SetFullHeight(true)
    frame:AddChild(mainContainer)

    -- Scroll container for form fields
    local scrollContainer = Libs.AceGUI:Create("ScrollFrame")
    scrollContainer:SetLayout("Flow")
    scrollContainer:SetFullWidth(true)
    scrollContainer:SetHeight(400)
    mainContainer:AddChild(scrollContainer)

    -- Condition type dropdown (persistent)
    local typeDropdown = Libs.AceGUI:Create("Dropdown")
    typeDropdown:SetLabel(L["conditionType"] or "Condition Type")
    typeDropdown:SetFullWidth(true)
    typeDropdown:SetList({
        [ns.CUSTOM_CONDITION_TYPES.TARGET_COUNT] = "Target Count",
        [ns.CUSTOM_CONDITION_TYPES.WEAPON_TYPE] = "Weapon Type",
        [ns.CUSTOM_CONDITION_TYPES.AURA_ACTIVE] = "Aura Active",
        [ns.CUSTOM_CONDITION_TYPES.GROUP_CONTEXT] = "Group Context",
        [ns.CUSTOM_CONDITION_TYPES.ASSIGNMENT] = "Assignment",
        [ns.CUSTOM_CONDITION_TYPES.CUSTOM_FUNCTION] = "Custom Function"
    })
    typeDropdown:SetValue(working.type)
    scrollContainer:AddChild(typeDropdown)

    -- Container for type-specific fields (will be refreshed)
    local fieldsContainer = Libs.AceGUI:Create("SimpleGroup")
    fieldsContainer:SetLayout("Flow")
    fieldsContainer:SetFullWidth(true)
    scrollContainer:AddChild(fieldsContainer)

    -- Function to refresh fields when type changes
    local function RefreshFields()
        fieldsContainer:ReleaseChildren()
        self:RenderConditionFields(fieldsContainer, working)
    end

    -- Set callback after defining RefreshFields
    typeDropdown:SetCallback("OnValueChanged", function(widget, event, value)
        working.type = value
        working.value = {}
        RefreshFields()
    end)

    -- Initial render of fields
    RefreshFields()

    -- Button group at the bottom (outside scroll, fixed position)
    local buttonGroup = Libs.AceGUI:Create("SimpleGroup")
    buttonGroup:SetLayout("Flow")
    buttonGroup:SetFullWidth(true)
    buttonGroup:SetHeight(40)
    mainContainer:AddChild(buttonGroup)

    -- Save button
    local saveBtn = Libs.AceGUI:Create("Button")
    saveBtn:SetText(L["save"] or "Save")
    saveBtn:SetWidth(150)
    saveBtn:SetCallback("OnClick", function()
        -- Validate condition
        local valid, err = Validation:ValidateCondition(working)
        if not valid then
            NAG:Error("Invalid condition: " .. tostring(err))
            return
        end
        onSave(working)
        releaseWidget(frame)
    end)
    buttonGroup:AddChild(saveBtn)

    -- Cancel button
    local cancelBtn = Libs.AceGUI:Create("Button")
    cancelBtn:SetText(L["cancel"] or "Cancel")
    cancelBtn:SetWidth(150)
    cancelBtn:SetCallback("OnClick", function()
        releaseWidget(frame)
    end)
    buttonGroup:AddChild(cancelBtn)
end

--- Render condition type-specific fields
--- @param container table Libs.AceGUI container
--- @param working table Working condition data
function SmartSwitchingEditor:RenderConditionFields(container, working)
    if working.type == ns.CUSTOM_CONDITION_TYPES.TARGET_COUNT then
        self:RenderTargetCountFields(container, working)
    elseif working.type == ns.CUSTOM_CONDITION_TYPES.WEAPON_TYPE then
        self:RenderWeaponTypeFields(container, working)
    elseif working.type == ns.CUSTOM_CONDITION_TYPES.AURA_ACTIVE then
        self:RenderAuraActiveFields(container, working)
    elseif working.type == ns.CUSTOM_CONDITION_TYPES.GROUP_CONTEXT then
        self:RenderGroupContextFields(container, working)
    elseif working.type == ns.CUSTOM_CONDITION_TYPES.ASSIGNMENT then
        self:RenderAssignmentFields(container, working)
    elseif working.type == ns.CUSTOM_CONDITION_TYPES.CUSTOM_FUNCTION then
        self:RenderCustomFunctionFields(container, working)
    end
end

--- Render TARGET_COUNT condition fields
--- @param container table Libs.AceGUI container
--- @param working table Working condition data
function SmartSwitchingEditor:RenderTargetCountFields(container, working)
    if type(working.value) ~= "table" then
        working.value = {operator = "gte", value = 3}
    else
        working.value.operator = working.value.operator or "gte"
        if working.value.operator == "range" then
            working.value.min = tonumber(working.value.min) or 1
            working.value.max = tonumber(working.value.max) or math_max(working.value.min or 1, 1)
            if working.value.max < working.value.min then
                working.value.max = working.value.min
            end
        else
            working.value.value = tonumber(working.value.value) or 3
        end
    end

    -- Create a sub-container for value fields (will be refreshed)
    local valueFieldsContainer = Libs.AceGUI:Create("SimpleGroup")
    valueFieldsContainer:SetLayout("Flow")
    valueFieldsContainer:SetFullWidth(true)

    -- Function to render value fields based on operator
    local function RenderValueFields()
        valueFieldsContainer:ReleaseChildren()

        if working.value.operator == "range" then
            -- Min/Max inputs
            local minInput = Libs.AceGUI:Create("EditBox")
            minInput:SetLabel(L["minimum"] or "Minimum Targets")
            minInput:SetFullWidth(true)
            minInput:SetText(tostring(working.value.min or 1))
            minInput:SetCallback("OnEnterPressed", function(widget, event, text)
                working.value.min = tonumber(text) or 1
            end)
            valueFieldsContainer:AddChild(minInput)

            local maxInput = Libs.AceGUI:Create("EditBox")
            maxInput:SetLabel(L["maximum"] or "Maximum Targets")
            maxInput:SetFullWidth(true)
            maxInput:SetText(tostring(working.value.max or 3))
            maxInput:SetCallback("OnEnterPressed", function(widget, event, text)
                working.value.max = tonumber(text) or 3
            end)
            valueFieldsContainer:AddChild(maxInput)
        else
            -- Single value input
            local valueInput = Libs.AceGUI:Create("EditBox")
            valueInput:SetLabel(L["targetCount"] or "Target Count")
            valueInput:SetFullWidth(true)
            valueInput:SetText(tostring(working.value.value))
            valueInput:SetCallback("OnEnterPressed", function(widget, event, text)
                working.value.value = tonumber(text) or 3
            end)
            valueFieldsContainer:AddChild(valueInput)
        end

        -- Range override (optional)
        local rangeInput = Libs.AceGUI:Create("EditBox")
        rangeInput:SetLabel(L["rangeOverride"] or "Range Override (yards, optional)")
        rangeInput:SetFullWidth(true)
        rangeInput:SetText(tostring(working.value.range or ""))
        rangeInput:SetCallback("OnEnterPressed", function(widget, event, text)
            local num = tonumber(text)
            working.value.range = num
        end)
        valueFieldsContainer:AddChild(rangeInput)
    end

    -- Operator dropdown
    local operatorDropdown = Libs.AceGUI:Create("Dropdown")
    operatorDropdown:SetLabel(L["operator"] or "Operator")
    operatorDropdown:SetFullWidth(true)
    operatorDropdown:SetList({
        ["eq"] = "Equal (=)",
        ["lt"] = "Less Than (<)",
        ["lte"] = "Less Than or Equal (≤)",
        ["gt"] = "Greater Than (>)",
        ["gte"] = "Greater Than or Equal (≥)",
        ["range"] = "Range (min to max)"
    })
    operatorDropdown:SetValue(working.value.operator or "gte")
    operatorDropdown:SetCallback("OnValueChanged", function(widget, event, value)
        working.value.operator = value
        RenderValueFields()
    end)
    container:AddChild(operatorDropdown)

    -- Add the value fields container
    container:AddChild(valueFieldsContainer)

    -- Initial render
    RenderValueFields()
end

--- Render WEAPON_TYPE condition fields
--- @param container table Libs.AceGUI container
--- @param working table Working condition data
function SmartSwitchingEditor:RenderWeaponTypeFields(container, working)
    local weaponDropdown = Libs.AceGUI:Create("Dropdown")
    weaponDropdown:SetLabel(L["weaponType"] or "Weapon Type")
    weaponDropdown:SetFullWidth(true)
    weaponDropdown:SetList({
        ["dualWield"] = "Dual Wield",
        ["twoHand"] = "Two-Hand",
        ["oneHand"] = "One-Hand + Shield"
    })
    weaponDropdown:SetValue(working.value or "dualWield")
    weaponDropdown:SetCallback("OnValueChanged", function(widget, event, value)
        working.value = value
    end)
    container:AddChild(weaponDropdown)
end

--- Render AURA_ACTIVE condition fields
--- @param container table Libs.AceGUI container
--- @param working table Working condition data
function SmartSwitchingEditor:RenderAuraActiveFields(container, working)
    if type(working.value) ~= "table" then
        working.value = {spellId = 0, unit = "player", operator = "active"}
    else
        local spellId = working.value.spellId or working.value.spellID or 0
        working.value.spellId = spellId
        working.value.spellID = spellId
        working.value.unit = working.value.unit or "player"
        working.value.operator = working.value.operator or "active"
        if working.value.operator == "stacks" then
            working.value.stacks = tonumber(working.value.stacks) or 1
        else
            working.value.stacks = nil
        end
    end

    -- Spell ID input
    local spellInput = Libs.AceGUI:Create("EditBox")
    spellInput:SetLabel(L["spellID"] or "Spell ID")
    spellInput:SetFullWidth(true)
    spellInput:SetText(tostring(working.value.spellId or working.value.spellID or ""))
    spellInput:SetCallback("OnEnterPressed", function(widget, event, text)
        local id = tonumber(text)
        working.value.spellId = id
        working.value.spellID = id
    end)
    container:AddChild(spellInput)

    -- Unit input
    local unitInput = Libs.AceGUI:Create("EditBox")
    unitInput:SetLabel(L["unit"] or "Unit (default: player)")
    unitInput:SetFullWidth(true)
    unitInput:SetText(working.value.unit or "player")
    unitInput:SetCallback("OnEnterPressed", function(widget, event, text)
        working.value.unit = text
    end)
    container:AddChild(unitInput)

    -- Create a sub-container for optional stacks field
    local stacksContainer = Libs.AceGUI:Create("SimpleGroup")
    stacksContainer:SetLayout("Flow")
    stacksContainer:SetFullWidth(true)

    -- Function to render stacks field if needed
    local function RenderStacksField()
        stacksContainer:ReleaseChildren()

        if working.value.operator == "stacks" then
            local stacksInput = Libs.AceGUI:Create("EditBox")
            stacksInput:SetLabel(L["stackCount"] or "Stack Count")
            stacksInput:SetFullWidth(true)
            stacksInput:SetText(tostring(working.value.stacks or 1))
            stacksInput:SetCallback("OnEnterPressed", function(widget, event, text)
                working.value.stacks = tonumber(text) or 1
            end)
            stacksContainer:AddChild(stacksInput)
        end
    end

    -- Operator dropdown
    local operatorDropdown = Libs.AceGUI:Create("Dropdown")
    operatorDropdown:SetLabel(L["checkType"] or "Check Type")
    operatorDropdown:SetFullWidth(true)
    operatorDropdown:SetList({
        ["active"] = "Active (present)",
        ["inactive"] = "Inactive (not present)",
        ["stacks"] = "Stack Count"
    })
    operatorDropdown:SetValue(working.value.operator or "active")
    operatorDropdown:SetCallback("OnValueChanged", function(widget, event, value)
        working.value.operator = value
        RenderStacksField()
    end)
    container:AddChild(operatorDropdown)

    -- Add the stacks container
    container:AddChild(stacksContainer)

    -- Initial render
    RenderStacksField()
end

--- Render GROUP_CONTEXT condition fields
--- @param container table Libs.AceGUI container
--- @param working table Working condition data
function SmartSwitchingEditor:RenderGroupContextFields(container, working)
    if type(working.value) ~= "table" then
        working.value = {"solo"}
    elseif #working.value == 0 then
        working.value[1] = "solo"
    end

    -- Multi-select checkboxes
    local contexts = {"solo", "group", "raid"}
    local selected = {}
    for _, v in ipairs(working.value) do
        selected[v] = true
    end

    for _, context in ipairs(contexts) do
    local checkbox = Libs.AceGUI:Create("CheckBox")
        checkbox:SetLabel(context:sub(1,1):upper() .. context:sub(2))
        checkbox:SetFullWidth(true)
        checkbox:SetValue(selected[context] == true)
        checkbox:SetCallback("OnValueChanged", function(widget, event, value)
            if value then
                for _, existing in ipairs(working.value) do
                    if existing == context then
                        return
                    end
                end
                tinsert(working.value, context)
            else
                for i, v in ipairs(working.value) do
                    if v == context then
                        tremove(working.value, i)
                        break
                    end
                end
            end
        end)
        container:AddChild(checkbox)
    end
end

--- Render ASSIGNMENT condition fields
--- @param container table Libs.AceGUI container
--- @param working table Working condition data
function SmartSwitchingEditor:RenderAssignmentFields(container, working)
    -- Get class module to access assignments
    local classModule = NAG:GetClassModule()
    if not classModule then
        local label = Libs.AceGUI:Create("Label")
        label:SetText("|cFFFF0000Error: No class module available|r")
        label:SetFullWidth(true)
        container:AddChild(label)
        return
    end

    local assignments = classModule.defaults.class.classAssignments or {}
    if not assignments or #assignments == 0 then
        local label = Libs.AceGUI:Create("Label")
        label:SetText("|cFFFF6600No class assignments are configured for this class.|r")
        label:SetFullWidth(true)
        container:AddChild(label)
        return
    end

    -- Initialize working.value as array if needed
    if type(working.value) ~= "table" then
        working.value = {}
    end

    -- Build selected set for quick lookup
    local selected = {}
    for _, v in ipairs(working.value) do
        selected[v] = true
    end

    -- Multi-select checkboxes for each assignment
    for _, assignment in ipairs(assignments) do
        local checkbox = Libs.AceGUI:Create("CheckBox")
        checkbox:SetLabel(assignment.name or assignment.id)
        if assignment.description then
            checkbox:SetDescription(assignment.description)
        end
        checkbox:SetFullWidth(true)
        checkbox:SetValue(selected[assignment.id] == true)
        checkbox:SetCallback("OnValueChanged", function(widget, event, value)
            if value then
                -- Add to array if not already present
                for _, existing in ipairs(working.value) do
                    if existing == assignment.id then
                        return
                    end
                end
                tinsert(working.value, assignment.id)
            else
                -- Remove from array
                for i, v in ipairs(working.value) do
                    if v == assignment.id then
                        tremove(working.value, i)
                        break
                    end
                end
            end
        end)
        container:AddChild(checkbox)
    end
end

--- Render CUSTOM_FUNCTION condition fields
--- @param container table Libs.AceGUI container
--- @param working table Working condition data
function SmartSwitchingEditor:RenderCustomFunctionFields(container, working)
    local funcText = type(working.value) == "string" and working.value or ""

    local editor = Libs.AceGUI:Create("MultiLineEditBox")
    editor:SetLabel(L["customFunction"] or "Custom Lua Function")
    editor:SetFullWidth(true)
    editor:SetNumLines(15)
    editor:SetText(funcText)
    editor:DisableButton(true)

    -- Enable syntax highlighting
    local SyntaxHL = ns.RotationEditorSyntaxHighlighting
    if SyntaxHL and editor.editBox then
        SyntaxHL.EnableAPLSyntaxHighlighting(editor.editBox, 4, {
            preserveExistingIndent = true
        })
    end
    editor:SetCallback("OnTextChanged", function(widget, event, text)
        working.value = text
    end)
    container:AddChild(editor)

    local hint = Libs.AceGUI:Create("Label")
    hint:SetText("|cFF888888Example: function() return UnitHealth('player') > 50000 end|r")
    hint:SetFullWidth(true)
    container:AddChild(hint)
end

return SmartSwitchingEditor

