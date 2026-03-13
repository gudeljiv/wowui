--- @module "BasicRotationStringEditor.GroupsVariablesEditor"
--- String-based groups and variables editor for BasicRotationStringEditor
--- No aplProto dependencies - works purely with string editing
--- License: CC BY-NC 4.0
--- Authors: Rakizi, Fonsas

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- Localizations
local AceGUI = ns.AceGUI
local L = ns.AceLocale:GetLocale("NAG", true)

-- Lua APIs
local format = string.format
local tinsert = tinsert
local tremove = tremove
local tostring = tostring
local ipairs = ipairs

-- ~~~~~~~~~~ MODULE DEFINITION ~~~~~~~~~~

local GroupsVariablesEditor = {}
ns.BasicRotationStringEditor = ns.BasicRotationStringEditor or {}
ns.BasicRotationStringEditor.GroupsVariablesEditor = GroupsVariablesEditor

-- ~~~~~~~~~~ MAIN TAB RENDERER ~~~~~~~~~~

--- Render the Groups & Variables tab
--- @param container table AceGUI container
--- @param editorState table Editor state with workingConfig
function GroupsVariablesEditor:RenderGroupsVariablesTab(container, editorState)
    container:SetLayout("Flow")

    -- Ensure groups and variables arrays exist
    local config = editorState.workingConfig
    if not config.groups then
        config.groups = {}
    end
    if not config.variables then
        config.variables = {}
    end

    -- Create split view: left list, right editor
    local mainContainer = AceGUI:Create("SimpleGroup")
    mainContainer:SetLayout("Flow")
    mainContainer:SetFullWidth(true)
    mainContainer:SetFullHeight(true)
    container:AddChild(mainContainer)

    -- Left panel: List of groups/variables
    local leftPanel = AceGUI:Create("SimpleGroup")
    leftPanel:SetLayout("Fill")
    leftPanel:SetRelativeWidth(0.3)
    leftPanel:SetFullHeight(true)
    mainContainer:AddChild(leftPanel)

    -- Right panel: Editor
    local rightPanel = AceGUI:Create("SimpleGroup")
    rightPanel:SetLayout("Fill")
    rightPanel:SetRelativeWidth(0.7)
    rightPanel:SetFullHeight(true)
    mainContainer:AddChild(rightPanel)

    -- Store references for refresh
    editorState.groupsVariablesLeftPanel = leftPanel
    editorState.groupsVariablesRightPanel = rightPanel

    -- Initialize selection state
    if not editorState.groupsVariablesSelection then
        editorState.groupsVariablesSelection = {
            type = nil, -- "group" or "variable"
            index = nil
        }
    end

    -- Render left list
    self:RenderGroupsVariablesList(leftPanel, editorState)

    -- Render right editor (or empty state)
    self:RenderEditorPanel(rightPanel, editorState)
end

-- ~~~~~~~~~~ LIST RENDERING ~~~~~~~~~~

--- Render the list of groups and variables
--- @param container table AceGUI container
--- @param editorState table Editor state
function GroupsVariablesEditor:RenderGroupsVariablesList(container, editorState)
    container:ReleaseChildren()

    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("List")
    scroll:SetFullWidth(true)
    scroll:SetFullHeight(true)
    container:AddChild(scroll)

    local config = editorState.workingConfig

    -- Groups section
    local groupsHeader = AceGUI:Create("Heading")
    groupsHeader:SetText(format("Groups (%d)", #(config.groups or {})))
    groupsHeader:SetFullWidth(true)
    scroll:AddChild(groupsHeader)

    -- Add Group button
    local addGroupBtn = AceGUI:Create("Button")
    addGroupBtn:SetText("+ Add Group")
    addGroupBtn:SetWidth(150)
    addGroupBtn:SetCallback("OnClick", function()
        self:AddGroup(editorState)
    end)
    scroll:AddChild(addGroupBtn)

    -- Group list
    for i, group in ipairs(config.groups or {}) do
        local groupBtn = AceGUI:Create("Button")
        local groupName = group.name or format("Group %d", i)
        local actionCount = #(group.actions or {})
        groupBtn:SetText(format("|cFF00FF00%s|r (%d actions)", groupName, actionCount))
        groupBtn:SetFullWidth(true)
        groupBtn:SetCallback("OnClick", function()
            editorState.groupsVariablesSelection = {
                type = "group",
                index = i
            }
            self:RenderEditorPanel(editorState.groupsVariablesRightPanel, editorState)
        end)
        scroll:AddChild(groupBtn)
    end

    -- Spacer
    local spacer = AceGUI:Create("Label")
    spacer:SetText("\n")
    spacer:SetFullWidth(true)
    scroll:AddChild(spacer)

    -- Variables section
    local variablesHeader = AceGUI:Create("Heading")
    variablesHeader:SetText(format("Variables (%d)", #(config.variables or {})))
    variablesHeader:SetFullWidth(true)
    scroll:AddChild(variablesHeader)

    -- Add Variable button
    local addVariableBtn = AceGUI:Create("Button")
    addVariableBtn:SetText("+ Add Variable")
    addVariableBtn:SetWidth(150)
    addVariableBtn:SetCallback("OnClick", function()
        self:AddVariable(editorState)
    end)
    scroll:AddChild(addVariableBtn)

    -- Variable list
    for i, variable in ipairs(config.variables or {}) do
        local varBtn = AceGUI:Create("Button")
        local varName = variable.name or format("Variable %d", i)
        varBtn:SetText(format("|cFF00CCFF%s|r", varName))
        varBtn:SetFullWidth(true)
        varBtn:SetCallback("OnClick", function()
            editorState.groupsVariablesSelection = {
                type = "variable",
                index = i
            }
            self:RenderEditorPanel(editorState.groupsVariablesRightPanel, editorState)
        end)
        scroll:AddChild(varBtn)
    end
end

-- ~~~~~~~~~~ EDITOR PANEL ~~~~~~~~~~

--- Render the editor panel (group or variable editor, or empty state)
--- @param container table AceGUI container
--- @param editorState table Editor state
function GroupsVariablesEditor:RenderEditorPanel(container, editorState)
    container:ReleaseChildren()

    local selection = editorState.groupsVariablesSelection
    if not selection or not selection.type or not selection.index then
        -- Empty state
        local emptyLabel = AceGUI:Create("Label")
        emptyLabel:SetText("|cFF888888Select a group or variable from the list to edit|r")
        emptyLabel:SetFullWidth(true)
        emptyLabel:SetFullHeight(true)
        container:AddChild(emptyLabel)
        return
    end

    if selection.type == "group" then
        self:RenderGroupEditor(container, selection.index, editorState)
    elseif selection.type == "variable" then
        self:RenderVariableEditor(container, selection.index, editorState)
    end
end

-- ~~~~~~~~~~ GROUP MANAGEMENT ~~~~~~~~~~

--- Render group editor
--- @param container table AceGUI container
--- @param groupIdx number Group index (1-based)
--- @param editorState table Editor state
function GroupsVariablesEditor:RenderGroupEditor(container, groupIdx, editorState)
    local config = editorState.workingConfig
    local group = config.groups and config.groups[groupIdx]

    if not group then
        local errorLabel = AceGUI:Create("Label")
        errorLabel:SetText(format("|cFFFF0000Error: Group %d not found|r", groupIdx))
        errorLabel:SetFullWidth(true)
        container:AddChild(errorLabel)
        return
    end

    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("List")
    scroll:SetFullWidth(true)
    scroll:SetFullHeight(true)
    container:AddChild(scroll)

    -- Group name editor
    local nameGroup = AceGUI:Create("InlineGroup")
    nameGroup:SetTitle("Group Settings")
    nameGroup:SetLayout("Flow")
    nameGroup:SetFullWidth(true)
    scroll:AddChild(nameGroup)

    local nameEdit = AceGUI:Create("EditBox")
    nameEdit:SetLabel("Group Name")
    nameEdit:SetFullWidth(true)
    nameEdit:SetText(group.name or "")
    nameEdit:SetCallback("OnEnterPressed", function(widget, event, text)
        group.name = text
        self:RefreshList(editorState)
    end)
    nameGroup:AddChild(nameEdit)

    -- Actions section
    local actionsGroup = AceGUI:Create("InlineGroup")
    actionsGroup:SetTitle(format("Actions (%d)", #(group.actions or {})))
    actionsGroup:SetLayout("List")
    actionsGroup:SetFullWidth(true)
    scroll:AddChild(actionsGroup)

    -- Ensure actions array exists
    if not group.actions then
        group.actions = {}
    end

    for i, action in ipairs(group.actions) do
        local actionGroup = AceGUI:Create("SimpleGroup")
        actionGroup:SetLayout("Flow")
        actionGroup:SetFullWidth(true)
        actionsGroup:AddChild(actionGroup)

        local actionEdit = AceGUI:Create("MultiLineEditBox")
        actionEdit:SetLabel(format("Action %d", i))
        actionEdit:SetRelativeWidth(0.85)
        actionEdit:SetNumLines(3)
        actionEdit:SetText(tostring(action or ""))
        actionEdit:SetCallback("OnEnterPressed", function(widget, event, text)
            group.actions[i] = text
        end)
        actionGroup:AddChild(actionEdit)

        local deleteBtn = AceGUI:Create("Button")
        deleteBtn:SetText("Delete")
        deleteBtn:SetRelativeWidth(0.14)
        deleteBtn:SetCallback("OnClick", function()
            tremove(group.actions, i)
            self:RenderGroupEditor(container, groupIdx, editorState)
        end)
        actionGroup:AddChild(deleteBtn)
    end

    -- Add action button
    local addBtn = AceGUI:Create("Button")
    addBtn:SetText("Add Action")
    addBtn:SetWidth(120)
    addBtn:SetCallback("OnClick", function()
        tinsert(group.actions, "")
        self:RenderGroupEditor(container, groupIdx, editorState)
    end)
    actionsGroup:AddChild(addBtn)

    -- Delete group button
    local deleteGroupBtn = AceGUI:Create("Button")
    deleteGroupBtn:SetText("Delete Group")
    deleteGroupBtn:SetWidth(120)
    deleteGroupBtn:SetCallback("OnClick", function()
        self:DeleteGroup(editorState, groupIdx)
    end)
    scroll:AddChild(deleteGroupBtn)
end

--- Add a new group
--- @param editorState table Editor state
function GroupsVariablesEditor:AddGroup(editorState)
    local config = editorState.workingConfig
    if not config.groups then
        config.groups = {}
    end

    tinsert(config.groups, {
        name = format("Group %d", #config.groups + 1),
        actions = {}
    })

    -- Select the new group
    editorState.groupsVariablesSelection = {
        type = "group",
        index = #config.groups
    }

    -- Refresh UI
    self:RefreshList(editorState)
    self:RenderEditorPanel(editorState.groupsVariablesRightPanel, editorState)
end

--- Delete a group
--- @param editorState table Editor state
--- @param groupIdx number Group index (1-based)
function GroupsVariablesEditor:DeleteGroup(editorState, groupIdx)
    local config = editorState.workingConfig
    if not config.groups or not config.groups[groupIdx] then
        return
    end

    tremove(config.groups, groupIdx)

    -- Clear selection if deleted group was selected
    if editorState.groupsVariablesSelection and
       editorState.groupsVariablesSelection.type == "group" and
       editorState.groupsVariablesSelection.index == groupIdx then
        editorState.groupsVariablesSelection = {
            type = nil,
            index = nil
        }
    end

    -- Refresh UI
    self:RefreshList(editorState)
    self:RenderEditorPanel(editorState.groupsVariablesRightPanel, editorState)
end

-- ~~~~~~~~~~ VARIABLE MANAGEMENT ~~~~~~~~~~

--- Render variable editor
--- @param container table AceGUI container
--- @param varIdx number Variable index (1-based)
--- @param editorState table Editor state
function GroupsVariablesEditor:RenderVariableEditor(container, varIdx, editorState)
    local config = editorState.workingConfig
    local variable = config.variables and config.variables[varIdx]

    if not variable then
        local errorLabel = AceGUI:Create("Label")
        errorLabel:SetText(format("|cFFFF0000Error: Variable %d not found|r", varIdx))
        errorLabel:SetFullWidth(true)
        container:AddChild(errorLabel)
        return
    end

    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("List")
    scroll:SetFullWidth(true)
    scroll:SetFullHeight(true)
    container:AddChild(scroll)

    -- Variable name editor
    local nameGroup = AceGUI:Create("InlineGroup")
    nameGroup:SetTitle("Variable Settings")
    nameGroup:SetLayout("List")
    nameGroup:SetFullWidth(true)
    scroll:AddChild(nameGroup)

    local nameEdit = AceGUI:Create("EditBox")
    nameEdit:SetLabel("Variable Name")
    nameEdit:SetFullWidth(true)
    nameEdit:SetText(variable.name or "")
    nameEdit:SetCallback("OnEnterPressed", function(widget, event, text)
        variable.name = text
        self:RefreshList(editorState)
    end)
    nameGroup:AddChild(nameEdit)

    -- Variable value editor
    local valueGroup = AceGUI:Create("InlineGroup")
    valueGroup:SetTitle("Variable Value")
    valueGroup:SetLayout("List")
    valueGroup:SetFullWidth(true)
    scroll:AddChild(valueGroup)

    local valueEdit = AceGUI:Create("MultiLineEditBox")
    valueEdit:SetLabel("Value Expression")
    valueEdit:SetFullWidth(true)
    valueEdit:SetNumLines(10)
    valueEdit:SetText(tostring(variable.value or ""))
    valueEdit:SetCallback("OnEnterPressed", function(widget, event, text)
        variable.value = text
    end)
    valueGroup:AddChild(valueEdit)

    -- Delete variable button
    local deleteVarBtn = AceGUI:Create("Button")
    deleteVarBtn:SetText("Delete Variable")
    deleteVarBtn:SetWidth(120)
    deleteVarBtn:SetCallback("OnClick", function()
        self:DeleteVariable(editorState, varIdx)
    end)
    scroll:AddChild(deleteVarBtn)
end

--- Add a new variable
--- @param editorState table Editor state
function GroupsVariablesEditor:AddVariable(editorState)
    local config = editorState.workingConfig
    if not config.variables then
        config.variables = {}
    end

    tinsert(config.variables, {
        name = format("Variable%d", #config.variables + 1),
        value = ""
    })

    -- Select the new variable
    editorState.groupsVariablesSelection = {
        type = "variable",
        index = #config.variables
    }

    -- Refresh UI
    self:RefreshList(editorState)
    self:RenderEditorPanel(editorState.groupsVariablesRightPanel, editorState)
end

--- Delete a variable
--- @param editorState table Editor state
--- @param varIdx number Variable index (1-based)
function GroupsVariablesEditor:DeleteVariable(editorState, varIdx)
    local config = editorState.workingConfig
    if not config.variables or not config.variables[varIdx] then
        return
    end

    tremove(config.variables, varIdx)

    -- Clear selection if deleted variable was selected
    if editorState.groupsVariablesSelection and
       editorState.groupsVariablesSelection.type == "variable" and
       editorState.groupsVariablesSelection.index == varIdx then
        editorState.groupsVariablesSelection = {
            type = nil,
            index = nil
        }
    end

    -- Refresh UI
    self:RefreshList(editorState)
    self:RenderEditorPanel(editorState.groupsVariablesRightPanel, editorState)
end

-- ~~~~~~~~~~ UTILITY FUNCTIONS ~~~~~~~~~~

--- Refresh the list panel
--- @param editorState table Editor state
function GroupsVariablesEditor:RefreshList(editorState)
    if editorState.groupsVariablesLeftPanel then
        self:RenderGroupsVariablesList(editorState.groupsVariablesLeftPanel, editorState)
    end
end

return GroupsVariablesEditor

