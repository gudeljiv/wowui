--- @module "RotationEditor.TabRenderers"
--- Tab rendering functions for RotationEditor (Properties, Tracking, Guide, etc.)
--- License: CC BY-NC 4.0
--- Authors: Rakizi, Fonsas

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- Localizations
local Libs = ns.Libs
local L = ns.AceLocale:GetLocale("NAG", true)
local WoWAPI = ns.WoWAPI

-- Lua APIs
local format = string.format
local tinsert = tinsert
local tostring = tostring
local tonumber = tonumber
local type = type
local pairs = pairs
local ipairs = ipairs
local sort = table.sort
local GetGlyphSocketInfo = _G.GetGlyphSocketInfo

local EditorUtils = ns.RotationEditorUtils
local SchemaUtils = ns.SchemaUtils

-- Module localizations (lazy-loaded to avoid circular dependencies)
local SchemaAccessor = nil
local SchemaValidator = nil
local RotationConversionService = nil

local function GetSchemaAccessor()
    if not SchemaAccessor then
        SchemaAccessor = NAG:GetModule("SchemaAccessor")
    end
    return SchemaAccessor
end

local function GetSchemaValidator()
    if not SchemaValidator then
        SchemaValidator = NAG:GetModule("SchemaValidator")
    end
    return SchemaValidator
end

local function GetRotationConversionService()
    if not RotationConversionService then
        RotationConversionService = NAG:GetModule("RotationConversionService")
    end
    return RotationConversionService
end

local ITEM_SWAP_SLOT_CONFIG = NAG.ITEM_SWAP_SLOT_CONFIG or {
    { protoIndex = 12, inventorySlot = 13 },
    { protoIndex = 13, inventorySlot = 14 },
    { protoIndex = 6,  inventorySlot = 10 },
    { protoIndex = 15, inventorySlot = 17 },
}
local ITEM_SWAP_SLOT_BY_PROTO = NAG.ITEM_SWAP_SLOT_BY_PROTO or {}
if not NAG.ITEM_SWAP_SLOT_CONFIG then
    NAG.ITEM_SWAP_SLOT_CONFIG = ITEM_SWAP_SLOT_CONFIG
    NAG.ITEM_SWAP_SLOT_BY_PROTO = ITEM_SWAP_SLOT_BY_PROTO
    for _, info in ipairs(ITEM_SWAP_SLOT_CONFIG) do
        ITEM_SWAP_SLOT_BY_PROTO[info.protoIndex] = info.inventorySlot
    end
elseif next(ITEM_SWAP_SLOT_BY_PROTO) == nil then
    for _, info in ipairs(ITEM_SWAP_SLOT_CONFIG) do
        ITEM_SWAP_SLOT_BY_PROTO[info.protoIndex] = info.inventorySlot
    end
end

local function NormalizeRotationStringPayload(rotationString)
    if not rotationString or rotationString == "" then
        return rotationString, false
    end

    local openStart, openEnd = rotationString:find("%[%[")
    local closeStart, closeEnd = rotationString:find("%]%]")
    if openStart and openEnd and closeStart and closeEnd and closeStart > openEnd then
        local payload = rotationString:sub(openEnd + 1, closeStart - 1)
        payload = (payload:match("^%s*(.-)%s*$")) or payload
        return payload, true
    end

    return rotationString, false
end

local C_Timer = C_Timer

local function ensureItemSwapConfig(workingConfig)
    workingConfig.itemSwap = workingConfig.itemSwap or {}
    local itemSwap = workingConfig.itemSwap
    if type(itemSwap) ~= "table" then
        itemSwap = {}
        workingConfig.itemSwap = itemSwap
    end
    if type(itemSwap.main) ~= "table" then
        itemSwap.main = {}
    end
    if type(itemSwap.swaps) ~= "table" then
        itemSwap.swaps = {}
    end
    return itemSwap
end

local function updateItemPreview(labelWidget, itemId, iconWidget)
    if labelWidget and type(labelWidget.SetText) == "function" then
        if not itemId or itemId == 0 then
            labelWidget:SetText(L["noItemSelected"] or "No item selected")
            if iconWidget and iconWidget.SetImage then
                iconWidget:SetImage(nil)
            end
            return
        end

        local itemName, _, _, _, _, _, _, _, _, itemIcon = WoWAPI.GetItemInfo(itemId)
        if not itemName then
            labelWidget:SetText(format(L["loadingItemData"] or "Loading item %d...", itemId))
            if iconWidget and iconWidget.SetImage then
                iconWidget:SetImage(nil)
            end
            if C_Timer and C_Timer.After then
                C_Timer.After(0.5, function()
                    updateItemPreview(labelWidget, itemId, iconWidget)
                end)
            end
            return
        end

        labelWidget:SetText(itemName)
        if iconWidget and iconWidget.SetImage then
            iconWidget:SetImage(itemIcon)
            iconWidget:SetImageSize(32, 32)
        end
    end
end

local consumableOptionsCache = {}

local function buildConsumableOptions(flags)
    if not flags or #flags == 0 then
        return nil, nil
    end

    local cacheKey = table.concat(flags, "|")
    local cached = consumableOptionsCache[cacheKey]
    if cached then
        return cached.list, cached.order
    end

    local DataManager = NAG:GetModule("DataManager")
    if not DataManager or not DataManager.GetAllByFlag or not DataManager.EntityTypes then
        NAG:Warn("DataManager module not available or missing required methods")
        consumableOptionsCache[cacheKey] = { list = nil, order = nil }
        return nil, nil
    end

    local combined = {}
    for _, flag in ipairs(flags) do
        local entries = DataManager:GetAllByFlag(flag, DataManager.EntityTypes.ITEM)
        if entries then
            for id, entry in pairs(entries) do
                combined[id] = entry
            end
        end
    end

    if next(combined) == nil then
        consumableOptionsCache[cacheKey] = { list = nil, order = nil }
        return nil, nil
    end

    local list = { ["0"] = L["none"] or "None" }
    local order = { "0" }

    for id, entry in pairs(combined) do
        local itemId = tonumber(id)
        if itemId and itemId > 0 then
            local name = entry and entry.name or nil
            local icon = entry and entry.icon or nil
            if not name or not icon then
                local itemName, _, _, _, _, _, _, _, _, itemIcon = WoWAPI.GetItemInfo(itemId)
                name = name or itemName
                icon = icon or itemIcon
            end
            name = name or format("Item %d", itemId)
            local label = icon and format("|T%s:16:16:0:0|t %s", icon, name) or name
            local key = tostring(itemId)
            list[key] = label
            table.insert(order, key)
        end
    end

    table.sort(order, function(a, b)
        if a == "0" then return true end
        if b == "0" then return false end
        local labelA = (list[a] or ""):gsub("|T.-|t%s*", "")
        local labelB = (list[b] or ""):gsub("|T.-|t%s*", "")
        if labelA == labelB then
            return tonumber(a) < tonumber(b)
        end
        return labelA < labelB
    end)

    consumableOptionsCache[cacheKey] = { list = list, order = order }
    return list, order
end

-- ~~~~~~~~~~ MODULE DEFINITION ~~~~~~~~~~

local TabRenderers = {}
ns.RotationEditorTabRenderers = TabRenderers

-- ============================ HELPER FUNCTIONS ============================

--- Create a scroll container with standard layout
--- @param container table AceGUI container to add scroll container to
--- @param layout string Layout type (default: "Flow")
--- @return table ScrollFrame widget
local function CreateScrollContainer(container, layout)
    layout = layout or "Flow"
    local scrollContainer = Libs.AceGUI:Create("ScrollFrame")
    scrollContainer:SetLayout(layout)
    scrollContainer:SetFullWidth(true)
    scrollContainer:SetFullHeight(true)
    container:AddChild(scrollContainer)
    return scrollContainer
end

--- Rebuild tabs when a tab visibility changes
--- @param editorState table The editor state for this instance
--- @param hiddenTab string|nil Tab name that was hidden (if any)
function TabRenderers:RebuildTabs(editorState, hiddenTab)
    if editorState.tabGroup and editorState.BuildTabList then
        local currentTab = editorState.currentTab
        editorState.tabGroup:SetTabs(editorState.BuildTabList())

        -- If we were on the hidden tab, switch to properties
        if hiddenTab and currentTab == hiddenTab then
            editorState.tabGroup:SelectTab("properties")
        else
            -- Reselect current tab to refresh
            editorState.tabGroup:SelectTab(currentTab)
        end
    end
end

--- Create an ID list edit box (for spells, items, auras, etc.)
--- @param container table AceGUI container
--- @param label string Label for the edit box
--- @param configKey string Key in workingConfig for the array
--- @param legacyKey string|nil Legacy key to migrate from (optional)
--- @param editorState table The editor state for this instance
--- @param numLines number|nil Number of lines (default: 5)
--- @return table MultiLineEditBox widget
function TabRenderers:CreateIDListEditBox(container, label, configKey, legacyKey, editorState, numLines)
    numLines = numLines or 5
    local box = Libs.AceGUI:Create("MultiLineEditBox")
    box:SetLabel(label)
    box:SetFullWidth(true)
    box:SetNumLines(numLines)
    box:DisableButton(true)

    -- Support legacy key for backward compatibility
    local array = editorState.workingConfig[configKey]
    if not array or #array == 0 then
        array = legacyKey and editorState.workingConfig[legacyKey] or {}
    end
    local text = (#array > 0) and table.concat(array, ", ") or ""
    box:SetText(text)

    box:SetCallback("OnTextChanged", function(widget, event, text)
        local parsed = self:ParseIDList(text)
        editorState.workingConfig[configKey] = parsed
        if legacyKey then
            editorState.workingConfig[legacyKey] = nil -- Remove old field
        end
        EditorUtils.MarkDirty(editorState)
    end)

    container:AddChild(box)
    return box
end

--- Create a text input field with OnTextChanged and OnEnterPressed callbacks
--- @param container table AceGUI container
--- @param label string Label for the input
--- @param configKey string Key in workingConfig for the value
--- @param editorState table The editor state for this instance
--- @return table EditBox widget
function TabRenderers:CreateTextInput(container, label, configKey, editorState)
    local input = Libs.AceGUI:Create("EditBox")
    input:SetLabel(label)
    input:SetFullWidth(true)
    input:SetText(editorState.workingConfig[configKey] or "")
    input:SetCallback("OnEnterPressed", function(widget, event, text)
        editorState.workingConfig[configKey] = text
        EditorUtils.MarkDirty(editorState)
    end)
    input:SetCallback("OnTextChanged", function(widget, event, text)
        editorState.workingConfig[configKey] = text
        EditorUtils.MarkDirty(editorState)
    end)
    container:AddChild(input)
    return input
end

--- Render a consumable field (dropdown, input, clear button)
--- @param container table AceGUI container
--- @param definition table Consumable definition with key, label, description, flags
--- @param consumablesConfig table Consumables config table
--- @param editorState table The editor state for this instance
function TabRenderers:RenderConsumableField(container, definition, consumablesConfig, editorState)
    local list, order = buildConsumableOptions(definition.flags)

    local group = Libs.AceGUI:Create("InlineGroup")
    group:SetTitle(definition.label)
    group:SetLayout("Flow")
    group:SetFullWidth(true)
    container:AddChild(group)

    if definition.description then
        local desc = Libs.AceGUI:Create("Label")
        desc:SetFullWidth(true)
        desc:SetText(definition.description)
        group:AddChild(desc)
    end

    local preview = Libs.AceGUI:Create("Label")
    preview:SetFullWidth(true)
    group:AddChild(preview)

    local dropdown
    local idInput

    local function applyConsumableValue(value, source)
        if value and value > 0 then
            consumablesConfig[definition.key] = value
        else
            consumablesConfig[definition.key] = nil
            value = nil
        end

        if dropdown and source ~= "dropdown" then
            local dropdownKey = "0"
            if value and list and list[tostring(value)] then
                dropdownKey = tostring(value)
            end
            dropdown:SetValue(dropdownKey)
        end

        if idInput and source ~= "input" then
            idInput:SetText(value and tostring(value) or "")
        end

        updateItemPreview(preview, value, nil)
        EditorUtils.MarkDirty(editorState)
    end

    if list and order then
        dropdown = Libs.AceGUI:Create("Dropdown")
        dropdown:SetLabel(L["selectConsumable"] or "Select")
        dropdown:SetList(list, order)
        dropdown:SetWidth(220)

        local current = consumablesConfig[definition.key]
        local dropdownValue = "0"
        if current and list[tostring(current)] then
            dropdownValue = tostring(current)
        end
        dropdown:SetValue(dropdownValue)
        dropdown:SetCallback("OnValueChanged", function(widget, event, key)
            local numeric = tonumber(key)
            applyConsumableValue(numeric, "dropdown")
        end)
        group:AddChild(dropdown)
    end

    idInput = Libs.AceGUI:Create("EditBox")
    idInput:SetLabel(L["customItemId"] or "Custom Item ID")
    idInput:SetWidth(180)
    if consumablesConfig[definition.key] then
        idInput:SetText(tostring(consumablesConfig[definition.key]))
    end
    idInput:SetCallback("OnEnterPressed", function(widget, event, text)
        local numeric = tonumber(text)
        if numeric and numeric > 0 then
            applyConsumableValue(numeric, "input")
        else
            applyConsumableValue(nil, "input")
        end
    end)
    group:AddChild(idInput)

    local clearButton = Libs.AceGUI:Create("Button")
    clearButton:SetText(L["clear"] or "Clear")
    clearButton:SetWidth(80)
    clearButton:SetCallback("OnClick", function()
        applyConsumableValue(nil)
    end)
    group:AddChild(clearButton)

    updateItemPreview(preview, consumablesConfig[definition.key], nil)
end

-- ~~~~~~~~~~ ROTATION STRING TAB ~~~~~~~~~~

--- Render the Rotation String tab
--- @param container table AceGUI container
--- @param editorState table The editor state for this instance
function TabRenderers:RenderRotationStringTab(container, editorState)
    NAG:Info("[TabRenderers] Rendering Rotation String tab")
    container:SetLayout("Flow")

    -- Create horizontal split container (GroupsVariablesEditor pattern)
    local mainContainer = Libs.AceGUI:Create("SimpleGroup")
    mainContainer:SetLayout("Flow")
    mainContainer:SetFullWidth(true)
    mainContainer:SetFullHeight(true)

    -- Initialize sidebar collapsed state
    if editorState.sidebarCollapsed == nil then
        editorState.sidebarCollapsed = false
    end

    -- Left sidebar (only add if not collapsed)
    local leftSidebar = nil
    if not editorState.sidebarCollapsed then
        leftSidebar = Libs.AceGUI:Create("SimpleGroup")
        leftSidebar:SetLayout("Fill")
        leftSidebar:SetRelativeWidth(0.28)
        leftSidebar:SetFullHeight(true)
        mainContainer:AddChild(leftSidebar)
    end

    -- Right panel (100% when sidebar collapsed, 72% when expanded)
    local rightPanel = Libs.AceGUI:Create("SimpleGroup")
    rightPanel:SetLayout("Fill")
    if editorState.sidebarCollapsed then
        rightPanel:SetFullWidth(true)
    else
        rightPanel:SetRelativeWidth(0.72)
    end
    rightPanel:SetFullHeight(true)
    mainContainer:AddChild(rightPanel)

    container:AddChild(mainContainer)

    -- Store references for toggle
    editorState.leftSidebar = leftSidebar
    editorState.rightPanel = rightPanel
    editorState.mainContainer = mainContainer

    -- Populate sidebar only if it exists
    if leftSidebar then
        self:PopulateLeftSidebar(leftSidebar, editorState)
    end

    -- Always render visual editor (text editor removed)
    self:RenderVisualRotationEditor(rightPanel, editorState)
end

--- Populate the left sidebar with controls and schema browser
--- @param leftPanel table AceGUI container for left sidebar
--- @param editorState table The editor state for this instance
function TabRenderers:PopulateLeftSidebar(leftPanel, editorState)
    local scroll = CreateScrollContainer(leftPanel, "List")
    scroll:SetLayout("List")
    scroll:SetFullWidth(true)
    scroll:SetFullHeight(true)
    leftPanel:AddChild(scroll)

    -- Advanced controls (devmode only)
    if NAG:IsDevModeEnabled() then
        local controlsHeader = Libs.AceGUI:Create("Heading")
        controlsHeader:SetText(L["editorControls"] or "Editor Controls")
        controlsHeader:SetFullWidth(true)
        scroll:AddChild(controlsHeader)

        -- Tree scale slider
        if not editorState.treeScale then
            editorState.treeScale = 1.0
        end

        local scaleSlider = Libs.AceGUI:Create("Slider")
        scaleSlider:SetLabel(L["treeScale"] or "Tree Scale")
        scaleSlider:SetFullWidth(true)
        scaleSlider:SetSliderValues(0.6, 1.5, 0.05)
        scaleSlider:SetValue(editorState.treeScale)
        scaleSlider:SetCallback("OnValueChanged", function(widget, event, value)
            editorState.treeScale = value
            -- Apply scale to tree buttons directly
            if editorState.visualEditor and editorState.visualEditor.treeGroup then
                local treeGroup = editorState.visualEditor.treeGroup
                if treeGroup.buttons then
                    for _, button in pairs(treeGroup.buttons) do
                        if button.icon then
                            button.icon:SetSize(14 * value, 14 * value)
                        end
                        if button.text then
                            local baseFontSize = button.level == 1 and 12 or 11
                            button.text:SetFont("Fonts\\FRIZQT__.TTF", baseFontSize * value)
                        end
                    end
                end
            end
        end)
        scroll:AddChild(scaleSlider)

        -- Spacer
        local spacer = Libs.AceGUI:Create("Label")
        spacer:SetText("\n")
        spacer:SetFullWidth(true)
        scroll:AddChild(spacer)
    end

    -- Schema Browser section
    self:CreateSchemaBrowser(scroll, editorState)
end

--- Create the schema browser with Actions/Values tabs
--- @param container table AceGUI container
--- @param editorState table The editor state for this instance
function TabRenderers:CreateSchemaBrowser(container, editorState)
    -- Initialize state if needed
    if not editorState.schemaBrowserState then
        editorState.schemaBrowserState = {
            selectedCategory = "actions", -- "actions" or "values"
            selectedItem = nil,
        }
    end

    local browserHeader = Libs.AceGUI:Create("Heading")
    browserHeader:SetText(L["schemaBrowser"] or "Schema Browser")
    browserHeader:SetFullWidth(true)
    container:AddChild(browserHeader)

    -- Category dropdown (Actions/Values)
    local categoryDropdown = Libs.AceGUI:Create("Dropdown")
    categoryDropdown:SetLabel(L["category"] or "Category")
    categoryDropdown:SetFullWidth(true)
    categoryDropdown:SetList({
        actions = L["Actions"] or "Actions",
        values = L["Values"] or "Values"
    })
    categoryDropdown:SetValue(editorState.schemaBrowserState.selectedCategory)
    categoryDropdown:SetCallback("OnValueChanged", function(widget, event, value)
        editorState.schemaBrowserState.selectedCategory = value
        editorState.schemaBrowserState.selectedItem = nil
        -- Rebuild content below
        self:RefreshSchemaBrowserContent(container, editorState)
    end)
    container:AddChild(categoryDropdown)

    -- Content container (will be populated lazily)
    local contentContainer = Libs.AceGUI:Create("SimpleGroup")
    contentContainer:SetLayout("Flow")
    contentContainer:SetFullWidth(true)
    container:AddChild(contentContainer)
    editorState.schemaBrowserState.contentContainer = contentContainer

    -- Initial render
    self:RefreshSchemaBrowserContent(container, editorState)
end

--- Refresh schema browser content based on selected category
--- @param container table AceGUI container (parent container)
--- @param editorState table The editor state for this instance
function TabRenderers:RefreshSchemaBrowserContent(container, editorState)
    local contentContainer = editorState.schemaBrowserState.contentContainer
    if not contentContainer then return end

    contentContainer:ReleaseChildren()

    local SchemaValidator = GetSchemaValidator()
    local SchemaAccessor = GetSchemaAccessor()
    local category = editorState.schemaBrowserState.selectedCategory
    local items = {}

    -- Get items based on category
    if category == "actions" then
        if SchemaAccessor and SchemaAccessor.GetAllActionsWithMetadata then
            items = SchemaAccessor:GetAllActionsWithMetadata()
        end
    else
        if SchemaAccessor and SchemaAccessor.GetAllValuesWithMetadata then
            items = SchemaAccessor:GetAllValuesWithMetadata()
        end
    end

    items = items or {}

    if #items == 0 then
        local noItemsLabel = Libs.AceGUI:Create("Label")
        noItemsLabel:SetText("|cFF888888No items available|r")
        noItemsLabel:SetFullWidth(true)
        contentContainer:AddChild(noItemsLabel)
        return
    end

    -- Item dropdown
    local itemDropdown = Libs.AceGUI:Create("Dropdown")
    itemDropdown:SetLabel(category == "actions" and (L["action"] or "Action") or (L["value"] or "Value"))
    itemDropdown:SetFullWidth(true)

    local itemList = {}
    local itemOrder = {}
    for _, item in ipairs(items) do
        -- GetAllActionsWithMetadata/GetAllValuesWithMetadata return both 'name' and 'actionType'/'valueType' fields
        local name = item.name
        if not name then
            local SchemaAccessor = GetSchemaAccessor()
            if SchemaAccessor then
                SchemaAccessor:Warn("RenderItemDropdown: Missing required field 'name' for item - schema may be incomplete")
            end
        end
        local label = item.ui_label
        if not label then
            label = item.nagName or name
            if not label and item.ui_label == nil then
                local SchemaAccessor = GetSchemaAccessor()
                if SchemaAccessor then
                    SchemaAccessor:Warn("RenderItemDropdown: Missing ui_label for item '%s' - schema may be incomplete", tostring(name or "unknown"))
                end
            end
        end
        if name then
            tinsert(itemOrder, name)
            itemList[name] = label
        end
    end

    itemDropdown:SetList(itemList, itemOrder)
    itemDropdown:SetValue(editorState.schemaBrowserState.selectedItem)
    itemDropdown:SetCallback("OnValueChanged", function(widget, event, value)
        editorState.schemaBrowserState.selectedItem = value
        self:DisplaySchemaBrowserItemDetails(contentContainer, editorState, items)
    end)
    contentContainer:AddChild(itemDropdown)

    -- Show details if item selected
    if editorState.schemaBrowserState.selectedItem then
        self:DisplaySchemaBrowserItemDetails(contentContainer, editorState, items)
    end
end

--- Display selected item details in schema browser
--- @param contentContainer table AceGUI content container
--- @param editorState table The editor state for this instance
--- @param items table Array of items with metadata
function TabRenderers:DisplaySchemaBrowserItemDetails(contentContainer, editorState, items)
    local selectedName = editorState.schemaBrowserState.selectedItem
    if not selectedName then return end

    -- Find the selected item
    local selectedItem = nil
    for _, item in ipairs(items) do
        if item.name == selectedName then
            selectedItem = item
            break
        end
    end

    if not selectedItem then return end

    -- Details group
    local detailsGroup = Libs.AceGUI:Create("InlineGroup")
    detailsGroup:SetTitle(selectedItem.label or selectedItem.name)
    detailsGroup:SetLayout("Flow")
    detailsGroup:SetFullWidth(true)
    contentContainer:AddChild(detailsGroup)

    -- Description
    if selectedItem.description and selectedItem.description ~= "" then
        local descLabel = Libs.AceGUI:Create("Label")
        descLabel:SetText("|cFFFFD100Description:|r\n" .. selectedItem.description)
        descLabel:SetFullWidth(true)
        detailsGroup:AddChild(descLabel)
    end

    -- Fields (if any)
    if selectedItem.fields and next(selectedItem.fields) then
        local fieldsLabel = Libs.AceGUI:Create("Label")
        local fieldsText = "|cFFFFD100Fields:|r\n"

        for _, fieldName in ipairs(selectedItem.field_order or {}) do
            local fieldInfo = selectedItem.fields[fieldName]
            if fieldInfo and fieldName ~= "field_order" then
                local fieldType = SchemaUtils:FormatFieldType(fieldInfo) or (fieldInfo.type or "unknown")
                fieldsText = fieldsText .. "  • " .. fieldName .. ": " .. fieldType .. "\n"
            end
        end

        fieldsLabel:SetText(fieldsText)
        fieldsLabel:SetFullWidth(true)
        detailsGroup:AddChild(fieldsLabel)
    end
end

--- Insert item into editor
--- @param item table Item data
--- @param category string Category ("actions" or "values")
--- @param editorState table The editor state for this instance
function TabRenderers:InsertItemIntoEditor(item, category, editorState)
    -- APL operators that should be lowercase Lua keywords, not NAG handlers
    local APL_OPERATORS = {
        ["not"] = true,
        ["and"] = true,
        ["or"] = true,
        ["cmp"] = true,
        ["math"] = true,
        ["max"] = true,
        ["min"] = true,
    }

    -- Convert schema field name to NAG handler format
    local nagHandler
    local isOperator = APL_OPERATORS[item.name]

    if isOperator then
        -- APL operators: keep as lowercase
        nagHandler = item.name
    else
        -- Regular handlers: convert to NAG:PascalCase
        local SchemaAccessor = GetSchemaAccessor()
        local pascalName = SchemaUtils and SchemaUtils:SnakeToPascal(item.name) or nil
        nagHandler = pascalName and ("NAG:" .. pascalName) or item.name

        -- Add empty parentheses for function calls
        if item.fields and next(item.fields) then
            nagHandler = nagHandler .. "(...)"
        else
            nagHandler = nagHandler .. "()"
        end
    end

    -- Store insertion data for future AST editor
    editorState.pendingInsertion = {
        type = category,
        name = item.name,
        handler = nagHandler,
        item = item
    }

    NAG:Info(format("|cFF00FF00Prepared for insertion: %s|r", nagHandler))
    NAG:Info("|cFF888888(Insertion will be handled by editor when implemented)|r")
end

-- ============================ SPELL EXTRACTION HELPERS ============================

--- Extract spells from rotation (prefers aplProto, falls back to string parsing)
--- @param editorState table Editor state with workingConfig.aplProto
--- @return table Array of {name=spellName, value=spellID, type="spell", displayText=formatted}
local function ExtractSpellsFromRotation(editorState)
    if not editorState then
        return {}
    end

    local SchemaAccessor = GetSchemaAccessor()
    if not SchemaAccessor then
        return {}
    end

    -- First try: Use aplProto if available (schema-driven extraction)
    local aplProto = editorState.workingConfig and editorState.workingConfig.aplProto
    if aplProto and aplProto.type then
        local ASTCore = ns.ASTCore
        if aplProto.type == ASTCore.NodeType.ROTATION then
            local actionIDs = SchemaAccessor:ExtractIDsFromRotationNode(aplProto)
            return SchemaAccessor:FormatSpellList(actionIDs)
        end
    end

    -- Fallback: String parsing (error recovery when AST parsing unavailable)
    NAG:Warn("[TabRenderers] FALLBACK TRACKING: Using string parsing fallback in BuildRotationClauses() (AST parsing unavailable or failed)")
    local rotationString = editorState.workingConfig and editorState.workingConfig.rotationString
    if not rotationString or rotationString == "" then
        return {}
    end

    local spells = {}
    local seenIDs = {}

    -- Pattern to match NAG action functions with spell IDs
    -- Matches: NAG:CastSpell(123), NAG:ChannelSpell(123, 456), etc.
    local actionPattern = "NAG:(%w+)%(([^%)]+)%)"

    -- Convert CamelCase to snake_case helper
    local function camelToSnake(str)
        if not str then return "" end
        return str:gsub("(%u)", "_%1"):lower():gsub("^_", "")
    end

    for actionName, args in rotationString:gmatch(actionPattern) do
        -- Check if it's an action via schema metadata (inline check, no separate function)
        local snakeIdentifier = camelToSnake(actionName)
        local isAction = false

        if SchemaAccessor.GetMetadataByIdentifier and snakeIdentifier:match("^[a-z][a-z0-9_]*$") then
            local metadata = SchemaAccessor:GetMetadataByIdentifier(snakeIdentifier, nil)
            if metadata then
                isAction = true
            end
        end

        -- Also check nagFunctionMappings
        if not isAction and SchemaAccessor.nagFunctionMappings then
            local protoName = SchemaAccessor.nagFunctionMappings[actionName]
            if not protoName and snakeIdentifier:match("^[a-z][a-z0-9_]*$") then
                local pascalCase = snakeIdentifier:gsub("^%l", function(c) return c:upper() end)
                protoName = SchemaAccessor.nagFunctionMappings[pascalCase]
            end
            if protoName and protoName:match("^APLAction") then
                isAction = true
            end
        end

        if isAction then
            -- Extract all numbers from arguments (spell IDs)
            for spellIDStr in args:gmatch("(%d+)") do
                local spellID = tonumber(spellIDStr)
                if spellID and not seenIDs[spellID] then
                    seenIDs[spellID] = true

                    -- Get spell info from WoW API (returns table in unified format)
                    local spellInfo = WoWAPI.GetSpellInfo(spellID)
                    if spellInfo and spellInfo.name then
                        local spellName = spellInfo.name
                        local iconID = spellInfo.iconID or spellInfo.icon

                        -- Create display text with icon
                        local displayText
                        if iconID and type(iconID) == "number" then
                            displayText = format("|T%d:20:20|t %s (%d)", iconID, spellName, spellID)
                        elseif iconID and type(iconID) == "string" then
                            displayText = format("|T%s:20:20|t %s (%d)", iconID, spellName, spellID)
                        else
                            -- No icon, just show name and ID
                            displayText = format("%s (%d)", spellName, spellID)
                        end

                        tinsert(spells, {
                            name = spellName,
                            value = spellID,
                            type = "spell",
                            displayText = displayText
                        })
                    else
                        -- Spell not found, use ID as name
                        tinsert(spells, {
                            name = "Spell ID: " .. spellID,
                            value = spellID,
                            type = "spell",
                            displayText = format("Spell ID: %d", spellID)
                        })
                    end
                end
            end
        end
    end

    -- Sort by spell name
    sort(spells, function(a, b)
        return (a.name or "") < (b.name or "")
    end)

    return spells
end

--- Find all positions where a spell ID appears in action clauses
--- @param rotationString string The rotation string
--- @param spellID number The spell ID to find
--- @return table Array of {startPos, endPos} for each match
local function FindSpellIDInActions(rotationString, spellID)
    if not rotationString or not spellID then
        return {}
    end

    local matches = {}
    local searchPattern = tostring(spellID)

    -- Pattern to match NAG action functions
    local actionPattern = "(NAG:%w+%([^%)]+%))"

    local pos = 1
    while pos <= #rotationString do
        local actionStart, actionEnd, actionText = rotationString:find(actionPattern, pos)
        if not actionStart then
            break
        end

        -- Check if this action contains our spell ID
        -- Look for spell ID as a standalone number (not part of a larger number)
        local idPattern = "(%D)" .. searchPattern .. "(%D)"
        local idPatternStart = "^" .. searchPattern .. "(%D)"
        local idPatternEnd = "(%D)" .. searchPattern .. "$"
        local idPatternAlone = "^" .. searchPattern .. "$"

        if actionText:match(idPattern) or actionText:match(idPatternStart) or
           actionText:match(idPatternEnd) or actionText:match(idPatternAlone) then

            -- Find the exact position of the spell ID within the action
            local idStart = actionText:find(searchPattern, 1, true)
            if idStart then
                local absoluteStart = actionStart + idStart - 1
                local absoluteEnd = absoluteStart + #searchPattern - 1

                tinsert(matches, {
                    startPos = absoluteStart,
                    endPos = absoluteEnd
                })
            end
        end

        pos = actionEnd + 1
    end

    return matches
end

--- Highlight a match in the editbox
--- @param editbox table AceGUI MultiLineEditBox widget
--- @param match table {startPos, endPos} match position (1-based Lua positions)
local function HighlightMatch(editbox, match)
    if not match or not editbox then
        return
    end

    -- Set focus first to ensure the editbox is active
    editbox:SetFocus()

    -- Convert from 1-based Lua positions to 0-based WoW API positions
    -- Lua: position 1 is first character
    -- WoW API: position 0 is first character
    local startPos0 = match.startPos - 1
    local endPos0 = match.endPos

    -- Set cursor to start of match (0-based)
    editbox.editBox:SetCursorPosition(startPos0)

    -- Highlight the match (0-based start, 0-based end)
    editbox:HighlightText(startPos0, endPos0)
end

-- ============================ CLAUSE VALIDATION HELPERS ============================

--- Split rotation string into clauses by 'or' keyword (at depth 0 only)
--- @param rotationString string The rotation string
--- @return table Array of {text, startLine, endLine, startPos, endPos}
local function SplitRotationIntoClauses(rotationString)
    if not rotationString or rotationString == "" then
        return {}
    end

    local normalized, sanitized = NormalizeRotationStringPayload(rotationString)
    if sanitized then
        rotationString = normalized
    end

    local clauses = {}
    local lines = {}

    -- Split into lines
    for line in rotationString:gmatch("[^\n]+") do
        tinsert(lines, line)
    end

    local currentClause = {}
    local clauseStartLine = 1
    local clauseStartPos = 1
    local currentPos = 1
    local parenDepth = 0 -- Track parenthesis depth across lines

    for lineNum, line in ipairs(lines) do
        -- Trim the line
        local trimmed = line:match("^%s*(.-)%s*$")

        -- Check if this line starts with 'or ' at the current paren depth
        local startsWithOrAtDepth0 = false
        if parenDepth == 0 and trimmed:match("^or%s+") and #currentClause > 0 then
            startsWithOrAtDepth0 = true
        end

        if startsWithOrAtDepth0 then
            -- End previous clause (we're at depth 0, so this is a top-level 'or')
            local clauseText = table.concat(currentClause, "\n")
            local clauseEndPos = currentPos - 1

            tinsert(clauses, {
                text = clauseText,
                startLine = clauseStartLine,
                endLine = lineNum - 1,
                startPos = clauseStartPos,
                endPos = clauseEndPos
            })

            -- Start new clause
            currentClause = {line}
            clauseStartLine = lineNum
            clauseStartPos = currentPos
        else
            -- Continue current clause
            tinsert(currentClause, line)
        end

        -- Update parenthesis depth for this line
        for i = 1, #line do
            local char = line:sub(i, i)
            if char == "(" then
                parenDepth = parenDepth + 1
            elseif char == ")" then
                parenDepth = parenDepth - 1
            end
        end

        currentPos = currentPos + #line + 1 -- +1 for newline
    end

    -- Add final clause
    if #currentClause > 0 then
        local clauseText = table.concat(currentClause, "\n")
        tinsert(clauses, {
            text = clauseText,
            startLine = clauseStartLine,
            endLine = #lines,
            startPos = clauseStartPos,
            endPos = #rotationString
        })
    end

    return clauses
end

--- Validate a single clause using RotationConversionService with schema checking
--- @param clauseText string The clause text to validate
--- @return boolean success True if valid
--- @return string|nil error Error message if invalid
local function ValidateClause(clauseText, editorState, clauseIdx)
    -- Trim the clause
    local trimmed = clauseText:match("^%s*(.-)%s*$")
    if trimmed == "" then
        return true, nil -- Empty clause is valid
    end

    -- Check for parenthesis balance
    local parenCount = 0
    for i = 1, #trimmed do
        local char = trimmed:sub(i, i)
        if char == "(" then
            parenCount = parenCount + 1
        elseif char == ")" then
            parenCount = parenCount - 1
        end
    end
    if parenCount ~= 0 then
        return false, format("Unbalanced parentheses (diff: %d)", parenCount)
    end

    local telemetryCache = nil
    if editorState then
        editorState.telemetry = editorState.telemetry or {}
        editorState.telemetry.genericFallbacks = editorState.telemetry.genericFallbacks or {}
        telemetryCache = editorState.telemetry.genericFallbacks
    end

    -- Remove leading 'or' keyword if present
    local cleanedClause = trimmed:gsub("^or%s+", "")

    local normalizedClause, wrapped = NormalizeRotationStringPayload(cleanedClause)
    if wrapped then
        cleanedClause = normalizedClause
        if editorState then
            NAG:Debug("[TabRenderers] Removed export wrapper from clause prior to validation (length=%d)", #cleanedClause)
        end
    end

    -- Try to parse as a full rotation string (single clause)
    local conversionService = GetRotationConversionService()
    local ast, diagnostics = conversionService:ParseToProtoAST(cleanedClause, {
        useCache = true,
        validate = false,
    })

    if not ast then
        local err = (diagnostics and diagnostics.errors and diagnostics.errors[1]) or "Unknown parse error"
        -- Return the parse error
        return false, err
    end

    -- Check if the parsed clause has a valid action (proto AST structure)
    local ASTCore = ns.ASTCore
    local ASTAction = ns.ASTAction

    if ast.priority_list and #ast.priority_list > 0 then
        local listItem = ast.priority_list[1]
        if listItem and listItem.action then
            local actionNode = listItem.action

            -- PHASE 1: Check for parse errors (enhanced diagnostic info)
            -- Proto AST nodes don't have parseError - errors are in diagnostics
            -- If we got here, parsing succeeded

            -- PHASE 1b: Check for empty action (intentional placeholder)
            if actionNode.type == ASTCore.NodeType.ACTION then
                local actionType = ASTAction.GetActionType(actionNode)
                if not actionType or actionType == "" then
                    -- This is an intentional empty action placeholder - allow it
                    return true, nil
                end
            else
                -- Not an ACTION node - this is an error
                NAG:Warn(format("[TabRenderers] ValidateClause: Expected ACTION node, got type='%s'", tostring(actionNode.type)))
                return false, "Invalid action node type"
            end

            -- PHASE 1c: Validate proto AST action type
            -- Proto AST should always have valid action types - nil indicates invalid structure
            local ASTAction = ns.ASTAction
            local actionType = ASTAction.GetActionType(actionNode)
            if not actionType then
                NAG:Warn(format("[TabRenderers] ValidateClause: Invalid action node: GetActionType returned nil (proto structure missing or invalid)"))
                -- Try to get action text for error message
                local ASTSchemaEmitter = ns.ASTSchemaEmitter
                local actionText = ASTSchemaEmitter and ASTSchemaEmitter.EmitActionNode(actionNode) or "unknown"

                -- Check for common malformed patterns
                if actionText:match("NAG:%w+%([^%)]*$") then
                    -- Incomplete NAG function call (missing closing paren)
                    return false, "Incomplete NAG function call: " .. actionText .. " | Fix: Add closing ')'"
                elseif actionText:match("^%($") or actionText:match("^%(%(") then
                    -- Just opening parentheses with no action
                    return false, "Invalid clause: only parentheses, no action | Fix: Add NAG function"
                elseif actionText:match("NAG:%w*$") then
                    -- Incomplete NAG function name
                    return false, "Incomplete NAG function: " .. actionText .. " | Fix: Add parentheses"
                end

                -- Invalid action structure - return error
                return false, "Invalid action node: proto structure missing or invalid"
            end
            if telemetryCache and clauseIdx then
                telemetryCache[clauseIdx] = nil
            end

            -- PHASE 2: Schema validation - check if NAG functions exist in schema
            -- Note: In proto AST, condition is on actionNode.condition, NOT listItem.condition
            local conditionNode = nil
            if ASTAction and ASTAction.GetCondition then
                conditionNode = ASTAction.GetCondition(actionNode)
            end

            -- Create a clause-like structure for Validation:ValidateClauseAST
            -- Use condition from actionNode (proto AST structure)
            local clause = {
                action = actionNode,
                condition = conditionNode  -- From actionNode.condition, not listItem.condition
            }
            local Validation = ns.RotationEditorValidation
            if Validation and Validation.ValidateClauseAST then
                local schemaValid, schemaErr = Validation:ValidateClauseAST(clause)
                if not schemaValid then
                    return false, schemaErr
                end
            end

            -- Valid parsed NAG action
            return true, nil
        else
            return false, "Clause has no action"
        end
    end

    return false, "Failed to parse clause structure"
end

-- ============================ VISUAL ROTATION EDITOR ============================

--- Render the visual rotation string editor
--- @param container table AceGUI container
--- @param editorState table The editor state for this instance
function TabRenderers:RenderVisualRotationEditor(container, editorState)
    -- Use aplProto directly from workingConfig
    local aplProto = editorState.workingConfig.aplProto
    if not aplProto then
        local errorMsg = "Editor state missing aplProto (should have been loaded)"
        NAG:Error("[TabRenderers] Visual rotation editor error: %s", errorMsg)
        local errorLabel = Libs.AceGUI:Create("Label")
        errorLabel:SetText("|cFFFF0000Error: " .. errorMsg .. "|r\n\nThe rotation editor requires aplProto to function. Please ensure the rotation has a valid aplProto.")
        errorLabel:SetFullWidth(true)
        container:AddChild(errorLabel)
        return
    end

    -- Use aplProto.priority_list directly - priority is the array index

    -- Take rotation-level snapshot for resetting clauses
    -- Note: This only snapshots rotation clauses, not properties/prepull/etc
    if not editorState.rotationSnapshot then
        editorState.rotationSnapshot = EditorUtils.CopyTable(aplProto)
    end

    -- Create split-pane layout
    local mainContent = Libs.AceGUI:Create("SimpleGroup")
    mainContent:SetFullWidth(true)
    mainContent:SetFullHeight(true)
    mainContent:SetLayout("Fill")
    container:AddChild(mainContent)

    -- Force layout after adding to parent so children get proper sizing
    if mainContent.DoLayout then
        mainContent:DoLayout()
    end

    -- Left panel: Tree of clauses
    local ASTEditor = ns.RotationEditorAST
    local leftPanel = ASTEditor:CreateClauseTree(mainContent, editorState)

    -- Store references
    editorState.visualEditor = {
        leftPanel = leftPanel,
        treeGroup = leftPanel
    }

    -- Select first clause by default
    if aplProto.priority_list and #aplProto.priority_list > 0 then
        leftPanel:SelectByValue("clause_1")
    else
        -- Select root to show "Add Clause" option
        leftPanel:SelectByValue("root")
    end

    -- Apply initial scale
    if editorState.treeScale then
        -- Try to apply scale immediately, retry once on next frame if buttons don't exist yet
        if leftPanel.buttons and next(leftPanel.buttons) then
            local scale = editorState.treeScale
            for _, button in pairs(leftPanel.buttons) do
                if button.icon then
                    button.icon:SetSize(14 * scale, 14 * scale)
                end
                if button.text then
                    local baseFontSize = button.level == 1 and 12 or 11
                    button.text:SetFont("Fonts\\FRIZQT__.TTF", baseFontSize * scale)
                end
            end
        else
            -- Buttons not ready yet, retry once on next frame
            C_Timer.After(0, function()
                if leftPanel.buttons and next(leftPanel.buttons) then
                    local scale = editorState.treeScale
                    for _, button in pairs(leftPanel.buttons) do
                        if button.icon then
                            button.icon:SetSize(14 * scale, 14 * scale)
                        end
                        if button.text then
                            local baseFontSize = button.level == 1 and 12 or 11
                            button.text:SetFont("Fonts\\FRIZQT__.TTF", baseFontSize * scale)
                        end
                    end
                end
            end)
        end
    end
end

-- ~~~~~~~~~~ PROPERTIES TAB ~~~~~~~~~~

--- Render the Core Properties tab
--- @param container table AceGUI container
--- @param editorState table The editor state for this instance
function TabRenderers:RenderPropertiesTab(container, editorState)
    NAG:Info("[TabRenderers] Rendering Properties tab")
    container:SetLayout("Flow")

    local SpecCompat = NAG:GetModule("SpecCompat")

    local scrollContainer = CreateScrollContainer(container, "Flow")

    -- Rotation Type dropdown
    local rotationTypeDropdown = Libs.AceGUI:Create("Dropdown")
    rotationTypeDropdown:SetLabel(L["rotationType"] or "Rotation Type")
    rotationTypeDropdown:SetFullWidth(true)
    rotationTypeDropdown:SetList({
        [ns.ROTATION_TYPES.UNKNOWN_TYPE] = "Unknown Type",
        [ns.ROTATION_TYPES.SINGLE_TARGET] = "Single Target",
        [ns.ROTATION_TYPES.CUSTOM] = "Custom",
        [ns.ROTATION_TYPES.AOE] = "Area of Effect (AOE)"
    })
    rotationTypeDropdown:SetValue(editorState.workingConfig.rotationType or ns.ROTATION_TYPES.UNKNOWN_TYPE)
    rotationTypeDropdown:SetCallback("OnValueChanged", function(widget, event, value)
        editorState.workingConfig.rotationType = value
        EditorUtils.MarkDirty(editorState)
    end)
    scrollContainer:AddChild(rotationTypeDropdown)

    -- Info about rotation type
    local rotationTypeNote = Libs.AceGUI:Create("Label")
    rotationTypeNote:SetText("|cFF888888Note: Rotation Type is for documentation only. It does NOT control rotation switching behavior. Use the Smart Switching tab to define actual switching conditions.|r")
    rotationTypeNote:SetFullWidth(true)
    scrollContainer:AddChild(rotationTypeNote)

    -- Enabled checkbox
    local enabledToggle = Libs.AceGUI:Create("CheckBox")
    enabledToggle:SetLabel(L["enabled"] or "Enabled")
    enabledToggle:SetFullWidth(true)
    enabledToggle:SetValue(editorState.workingConfig.enabled ~= false)
    enabledToggle:SetCallback("OnValueChanged", function(widget, event, value)
        local currentSpecIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
        if currentSpecIndex and editorState.specIndex ~= currentSpecIndex then
            -- Revert the change and warn
            enabledToggle:SetValue(editorState.workingConfig.enabled)
            NAG:Info("Cannot change enabled state for rotations from a different spec")
            return
        end
        editorState.workingConfig.enabled = value
        EditorUtils.MarkDirty(editorState)
    end)
    scrollContainer:AddChild(enabledToggle)

    -- Default checkbox
    local defaultToggle = Libs.AceGUI:Create("CheckBox")
    defaultToggle:SetLabel(L["default"] or "Default Rotation")
    defaultToggle:SetDescription(L["defaultRotationDesc"] or "Auto-select this rotation on spec change")
    defaultToggle:SetFullWidth(true)
    defaultToggle:SetValue(editorState.workingConfig.default == true)
    defaultToggle:SetCallback("OnValueChanged", function(widget, event, value)
        editorState.workingConfig.default = value
        EditorUtils.MarkDirty(editorState)
    end)
    scrollContainer:AddChild(defaultToggle)

    -- Experimental checkbox
    local experimentalToggle = Libs.AceGUI:Create("CheckBox")
    experimentalToggle:SetLabel("|cFFFF8000Experimental|r")
    experimentalToggle:SetDescription(L["experimentalDesc"] or "Mark as experimental/untested rotation")
    experimentalToggle:SetFullWidth(true)
    experimentalToggle:SetValue(editorState.workingConfig.experimental == true)
    experimentalToggle:SetCallback("OnValueChanged", function(widget, event, value)
        editorState.workingConfig.experimental = value
        EditorUtils.MarkDirty(editorState)
    end)
    scrollContainer:AddChild(experimentalToggle)

    -- Enable smart switching checkbox
    local enableSwitchingToggle = Libs.AceGUI:Create("CheckBox")
    enableSwitchingToggle:SetLabel(L["enableSmartSwitching"] or "Enable Smart Switching")
    enableSwitchingToggle:SetDescription(L["enableSmartSwitchingDesc"] or "Enable this rotation to participate in automatic rotation switching. Rotations with customConditions are prioritized when conditions match. Rotations without conditions can serve as fallbacks.")
    enableSwitchingToggle:SetFullWidth(true)
    enableSwitchingToggle:SetValue(editorState.workingConfig.enableSmartSwitching == true)
    enableSwitchingToggle:SetCallback("OnValueChanged", function(widget, event, value)
        editorState.workingConfig.enableSmartSwitching = value
        EditorUtils.MarkDirty(editorState)

        -- Rebuild tabs to show/hide Smart Switching tab
        self:RebuildTabs(editorState, not value and "switching" or nil)
    end)
    scrollContainer:AddChild(enableSwitchingToggle)

    -- Enable item swap toggle
    local enableItemSwapToggle = Libs.AceGUI:Create("CheckBox")
    enableItemSwapToggle:SetLabel(L["enableItemSwap"] or "Enable Item Swap")
    enableItemSwapToggle:SetDescription(L["enableItemSwapDesc"] or "Enable to configure optional item swap sets (trinkets, gloves, off-hand) for this rotation.")
    enableItemSwapToggle:SetFullWidth(true)
    enableItemSwapToggle:SetValue(editorState.workingConfig.enableItemSwap == true)
    enableItemSwapToggle:SetCallback("OnValueChanged", function(widget, event, value)
        editorState.workingConfig.enableItemSwap = value
        if value then
            ensureItemSwapConfig(editorState.workingConfig)
        end
        -- Update toggle widget to reflect the final state (only if it changed)
        local finalValue = editorState.workingConfig.enableItemSwap == true
        if enableItemSwapToggle:GetValue() ~= finalValue then
            enableItemSwapToggle:SetValue(finalValue)
        end
        EditorUtils.MarkDirty(editorState)

        self:RebuildTabs(editorState, not value and "itemswap" or nil)
    end)
    scrollContainer:AddChild(enableItemSwapToggle)

    -- Use rotation-specific spell locations toggle
    local useCustomSpellLocationsToggle = Libs.AceGUI:Create("CheckBox")
    useCustomSpellLocationsToggle:SetLabel(L["useCustomSpellLocations"] or "Use Rotation-Specific Spell Locations")
    useCustomSpellLocationsToggle:SetDescription(L["useCustomSpellLocationsDesc"] or "Enable to customize spell locations for this rotation only. When disabled, uses spec-wide defaults.")
    useCustomSpellLocationsToggle:SetFullWidth(true)
    useCustomSpellLocationsToggle:SetValue(editorState.workingConfig.useCustomSpellLocations == true)
    useCustomSpellLocationsToggle:SetCallback("OnValueChanged", function(widget, event, value)
        -- When enabling for first time, copy spec defaults if rotation has no locations yet
        if value and (not editorState.workingConfig.spellLocations or not next(editorState.workingConfig.spellLocations)) then
            local classModule = editorState.classModule
            if classModule and classModule.db and classModule.db.class.specSpellLocations and classModule.db.class.specSpellLocations[editorState.specIndex] then
                editorState.workingConfig.spellLocations = EditorUtils.CopyTable(classModule.db.class.specSpellLocations[editorState.specIndex])
                NAG:Info("|cFF00FF00Copied spec defaults to rotation spell locations|r")
            else
                editorState.workingConfig.spellLocations = {}
            end
        end

        editorState.workingConfig.useCustomSpellLocations = value
        EditorUtils.MarkDirty(editorState)

        -- Rebuild tabs to show/hide Spell Locations tab
        self:RebuildTabs(editorState, not value and "spelllocations" or nil)
    end)
    scrollContainer:AddChild(useCustomSpellLocationsToggle)

    -- Author input
    self:CreateTextInput(scrollContainer, L["author"] or "Author", "author", editorState)

    -- Talents string input
    self:CreateTextInput(scrollContainer, L["talentsString"] or "Talents String", "talentsString", editorState)

    local talentsHint = Libs.AceGUI:Create("Label")
    talentsHint:SetText("|cFF888888Format: e.g., '221111' for talent selections per tier|r")
    talentsHint:SetFullWidth(true)
    scrollContainer:AddChild(talentsHint)
end

-- ~~~~~~~~~~ TRACKING TAB ~~~~~~~~~~

--- Render the Tracking & Optimization tab
--- @param container table AceGUI container
function TabRenderers:RenderTrackingTab(container, editorState)
    NAG:Info("[TabRenderers] Rendering Tracking tab")
    container:SetLayout("Flow")

    local scrollContainer = CreateScrollContainer(container, "Flow")

    local header = Libs.AceGUI:Create("Heading")
    header:SetText(L["tracking"] or "Tracking & Optimization")
    header:SetFullWidth(true)
    scrollContainer:AddChild(header)

    -- Tracking Spells
    self:CreateIDListEditBox(scrollContainer, L["trackingSpells"] or "Tracking Spells (comma-separated IDs)", "spells", "trackingSpells", editorState)

    -- Tracking Items
    self:CreateIDListEditBox(scrollContainer, L["trackingItems"] or "Tracking Items (comma-separated IDs)", "items", "trackingItems", editorState)

    -- Tracking Auras
    self:CreateIDListEditBox(scrollContainer, L["trackingAuras"] or "Tracking Auras (comma-separated IDs)", "auras", "trackingAuras", editorState)

    -- Tracking Runes (DK/Evoker specific)
    self:CreateIDListEditBox(scrollContainer, L["trackingRunes"] or "Tracking Runes (comma-separated IDs, DK/Evoker)", "runes", nil, editorState)
end

--- Parse a comma-separated list of IDs
--- @param text string Comma-separated ID list
--- @return table Array of numbers
function TabRenderers:ParseIDList(text)
    local ids = {}
    if not text or text == "" then return ids end

    for idStr in text:gmatch("[^,]+") do
        local id = tonumber(idStr:match("%d+"))
        if id then
            tinsert(ids, id)
        end
    end
    return ids
end

-- ~~~~~~~~~~ ITEM SWAP TAB ~~~~~~~~~~

--- Render the Item Swap tab
--- @param container table AceGUI container
--- @param editorState table The editor state for this instance
function TabRenderers:RenderItemSwapTab(container, editorState)
    NAG:Info("[TabRenderers] Rendering Item Swap tab")
    container:ReleaseChildren()
    container:SetLayout("Fill")

    local scrollFrame = Libs.AceGUI:Create("ScrollFrame")
    scrollFrame:SetLayout("Flow")
    scrollFrame:SetFullWidth(true)
    scrollFrame:SetFullHeight(true)

    local infoLabel = Libs.AceGUI:Create("Label")
    infoLabel:SetFullWidth(true)
    infoLabel:SetText(L["itemSwapTabIntro"] or "Configure optional item swap sets used by WoWSims actions. Only item IDs are currently supported; enchants and gems will be preserved when present.")
    scrollFrame:AddChild(infoLabel)

    local workingConfig = editorState.workingConfig or {}
    local itemSwapConfig = ensureItemSwapConfig(workingConfig)

    local slotLabels = {
        [13] = L["itemSwapSlotTrinket1"] or "Trinket 1",
        [14] = L["itemSwapSlotTrinket2"] or "Trinket 2",
        [10] = L["itemSwapSlotHands"] or "Gloves",
        [17] = L["itemSwapSlotOffHand"] or "Off-hand",
    }

    local function ensureSet(setName)
        if setName == "Main" then
            itemSwapConfig.main = itemSwapConfig.main or {}
            return itemSwapConfig.main
        else
            itemSwapConfig.swaps[setName] = itemSwapConfig.swaps[setName] or {}
            return itemSwapConfig.swaps[setName]
        end
    end

    --- Render content for an item swap set tab
    --- @param tabContainer table AceGUI container for the tab
    --- @param setName string Name of the set ("Main", "Swap1", etc.)
    --- @param setLabel string Display label for the set
    local function renderSetContent(tabContainer, setName, setLabel)
        tabContainer:ReleaseChildren()
        tabContainer:SetLayout("Flow")
        tabContainer:SetFullWidth(true)
        tabContainer:SetFullHeight(true)

        local storage = ensureSet(setName)
        for slot, value in pairs(storage) do
            if type(value) == "table" then
                storage[slot] = value.id or value.itemId or value[1] or 0
            end
        end

        local buttonRow = Libs.AceGUI:Create("SimpleGroup")
        buttonRow:SetLayout("Flow")
        buttonRow:SetFullWidth(true)
        tabContainer:AddChild(buttonRow)

        local useEquippedSetButton = Libs.AceGUI:Create("Button")
        useEquippedSetButton:SetText(L["useEquippedSet"] or "Use Equipped for Set")
        useEquippedSetButton:SetWidth(180)
        useEquippedSetButton:SetCallback("OnClick", function()
            local anyApplied = false
            for _, slotConfig in ipairs(ITEM_SWAP_SLOT_CONFIG) do
                local inventorySlot = slotConfig.inventorySlot
                local equippedId = GetInventoryItemID("player", inventorySlot)
                if equippedId and equippedId > 0 then
                    storage[inventorySlot] = equippedId
                    anyApplied = true
                else
                    storage[inventorySlot] = nil
                end
            end
            if anyApplied then
                EditorUtils.MarkDirty(editorState)
                renderSetContent(tabContainer, setName, setLabel)
            else
                NAG:Info(L["noEquippedItemsForSet"] or "No matching items equipped for this set.")
            end
        end)
        buttonRow:AddChild(useEquippedSetButton)

        if setName ~= "Main" then
            local clearSetButton = Libs.AceGUI:Create("Button")
            clearSetButton:SetText(L["clearSet"] or "Clear Set")
            clearSetButton:SetWidth(120)
            clearSetButton:SetCallback("OnClick", function()
                for _, slotConfig in ipairs(ITEM_SWAP_SLOT_CONFIG) do
                    storage[slotConfig.inventorySlot] = nil
                end
                EditorUtils.MarkDirty(editorState)
                renderSetContent(tabContainer, setName, setLabel)
            end)
            buttonRow:AddChild(clearSetButton)
        end

        for _, slotConfig in ipairs(ITEM_SWAP_SLOT_CONFIG) do
            local inventorySlot = slotConfig.inventorySlot
            local slotTitle = slotLabels[inventorySlot] or ("Slot " .. tostring(inventorySlot))

            local group = Libs.AceGUI:Create("InlineGroup")
            group:SetTitle(slotTitle)
            group:SetLayout("Flow")
            group:SetFullWidth(true)
            tabContainer:AddChild(group)

            local nameLabel = Libs.AceGUI:Create("Label")
            nameLabel:SetFullWidth(true)
            group:AddChild(nameLabel)

            local iconWidget = Libs.AceGUI:Create("Icon")
            iconWidget:SetImageSize(32, 32)
            iconWidget:SetLabel("")

            local currentItemId = storage[inventorySlot]
            updateItemPreview(nameLabel, currentItemId, iconWidget)

            local idInput
            local function applyItemId(itemId)
                if itemId and itemId > 0 then
                    storage[inventorySlot] = itemId
                    if idInput then
                        idInput:SetText(tostring(itemId))
                    end
                else
                    storage[inventorySlot] = nil
                    if idInput then
                        idInput:SetText("")
                    end
                end
                updateItemPreview(nameLabel, storage[inventorySlot], iconWidget)
                EditorUtils.MarkDirty(editorState)
            end

            idInput = Libs.AceGUI:Create("EditBox")
            idInput:SetLabel(L["itemId"] or "Item ID")
            idInput:SetWidth(180)
            if currentItemId then
                idInput:SetText(tostring(currentItemId))
            end
            idInput:SetCallback("OnEnterPressed", function(widget, event, text)
                local numeric = tonumber(text)
                if numeric and numeric > 0 then
                    applyItemId(numeric)
                else
                    applyItemId(nil)
                end
            end)
            group:AddChild(idInput)

            local clearButton = Libs.AceGUI:Create("Button")
            clearButton:SetText(L["clear"] or "Clear")
            clearButton:SetWidth(80)
            clearButton:SetCallback("OnClick", function()
                applyItemId(nil)
            end)
            group:AddChild(clearButton)

            group:AddChild(iconWidget)
        end
    end

    --- Get the next available swap set name
    --- @return string Next available swap name (e.g., "Swap2", "Swap3")
    local function nextSwapName()
        local index = 1
        while true do
            index = index + 1
            local candidate = "Swap" .. index
            if not itemSwapConfig.swaps[candidate] then
                return candidate
            end
        end
    end

    local tabs = {
        { text = L["itemSwapMainSet"] or "Main Set", value = "Main" },
        { text = L["itemSwapSwap1"] or "Swap Set 1", value = "Swap1" },
    }

    local extraSwapNames = {}
    for name in pairs(itemSwapConfig.swaps) do
        if name ~= "Swap1" then
            table.insert(extraSwapNames, name)
        end
    end
    table.sort(extraSwapNames)
    for _, name in ipairs(extraSwapNames) do
        table.insert(tabs, { text = format(L["itemSwapCustomSet"] or "%s", name), value = name })
    end

    table.insert(tabs, { text = L["addSwapSet"] or "+", value = "__ADD" })

    local activeTab = editorState.itemSwapActiveTab or "Main"
    local tabGroup = Libs.AceGUI:Create("TabGroup")
    tabGroup:SetTabs(tabs)
    tabGroup:SetFullWidth(true)
    tabGroup:SetFullHeight(true)

    tabGroup:SetCallback("OnGroupSelected", function(widget, event, value)
        if value == "__ADD" then
            local newName = nextSwapName()
            itemSwapConfig.swaps[newName] = {}
            EditorUtils.MarkDirty(editorState)
            editorState.itemSwapActiveTab = newName
            self:RenderItemSwapTab(container, editorState)
            return
        end
        editorState.itemSwapActiveTab = value
        widget:ReleaseChildren()

        local tabContainer = Libs.AceGUI:Create("SimpleGroup")
        tabContainer:SetLayout("Flow")
        tabContainer:SetFullWidth(true)
        tabContainer:SetFullHeight(true)
        widget:AddChild(tabContainer)

        local label
        if value == "Main" then
            label = L["itemSwapMainSet"] or "Main Set"
        elseif value == "Swap1" then
            label = L["itemSwapSwap1"] or "Swap Set 1"
        else
            label = format(L["itemSwapCustomSet"] or "%s", value)
        end

        renderSetContent(tabContainer, value, label)
    end)

    container:AddChild(tabGroup)
    tabGroup:SelectTab(activeTab)
end

-- ~~~~~~~~~~ GUIDE TAB ~~~~~~~~~~

--- Render the Guide & Notes tab
--- @param container table AceGUI container
function TabRenderers:RenderGuideTab(container, editorState)
    NAG:Info("[TabRenderers] Rendering Guide tab")
    container:SetLayout("Flow")

    local scrollContainer = CreateScrollContainer(container, "Flow")

    -- Guide
    local guideBox = Libs.AceGUI:Create("MultiLineEditBox")
    guideBox:SetLabel(L["guide"] or "Guide")
    guideBox:SetFullWidth(true)
    guideBox:SetNumLines(10)
    guideBox:DisableButton(true)
    guideBox:SetText(editorState.workingConfig.guide or "")
    guideBox:SetCallback("OnTextChanged", function(widget, event, text)
        editorState.workingConfig.guide = text
        EditorUtils.MarkDirty(editorState)
    end)
    scrollContainer:AddChild(guideBox)

    -- Notes
    local notesBox = Libs.AceGUI:Create("MultiLineEditBox")
    notesBox:SetLabel(L["notes"] or "Notes")
    notesBox:SetFullWidth(true)
    notesBox:SetNumLines(10)
    notesBox:DisableButton(true)
    notesBox:SetText(editorState.workingConfig.notes or "")
    notesBox:SetCallback("OnTextChanged", function(widget, event, text)
        editorState.workingConfig.notes = text
        EditorUtils.MarkDirty(editorState)
    end)
    scrollContainer:AddChild(notesBox)

    -- Consumables section
    local consumablesHeader = Libs.AceGUI:Create("Heading")
    consumablesHeader:SetText(L["consumables"] or "Consumables")
    consumablesHeader:SetFullWidth(true)
    scrollContainer:AddChild(consumablesHeader)

    -- Initialize consumables if not present
    if not editorState.workingConfig.consumables then
        editorState.workingConfig.consumables = {}
    end
    local consumablesConfig = editorState.workingConfig.consumables

    if editorState.workingConfig.prePotItemId and not consumablesConfig.prepotId then
        consumablesConfig.prepotId = editorState.workingConfig.prePotItemId
        editorState.workingConfig.prePotItemId = nil
    end
    if editorState.workingConfig.combatPotItemId and not consumablesConfig.potId then
        consumablesConfig.potId = editorState.workingConfig.combatPotItemId
        editorState.workingConfig.combatPotItemId = nil
    end
    if editorState.workingConfig.flaskItemId and not consumablesConfig.flaskId then
        consumablesConfig.flaskId = editorState.workingConfig.flaskItemId
        editorState.workingConfig.flaskItemId = nil
    end
    if editorState.workingConfig.foodItemId and not consumablesConfig.foodId then
        consumablesConfig.foodId = editorState.workingConfig.foodItemId
        editorState.workingConfig.foodItemId = nil
    end

    local consumableDefinitions = {
        {
            key = "prepotId",
            label = L["prePotItemId"] or "Pre-potion",
            description = L["prePotDescription"] or "Item used before combat begins.",
            flags = { "potion" }
        },
        {
            key = "potId",
            label = L["combatPotItemId"] or "Combat Potion",
            description = L["combatPotDescription"] or "Potion used during combat.",
            flags = { "potion" }
        },
        {
            key = "flaskId",
            label = L["flaskItemId"] or "Flask Item",
            description = L["flaskDescription"] or "Flask or elixir buff item.",
            flags = { "flask", "elixir" }
        },
        {
            key = "foodId",
            label = L["foodItemId"] or "Food Item",
            description = L["foodDescription"] or "Food or feast item granting buffs.",
            flags = { "food" }
        },
    }

    for _, definition in ipairs(consumableDefinitions) do
        self:RenderConsumableField(scrollContainer, definition, consumablesConfig, editorState)
    end

    -- Metadata display
    local metadataHeader = Libs.AceGUI:Create("Heading")
    metadataHeader:SetText(L["metadata"] or "Metadata")
    metadataHeader:SetFullWidth(true)
    scrollContainer:AddChild(metadataHeader)

    local lastModified = editorState.workingConfig.lastModified
    local lastModifiedBy = editorState.workingConfig.lastModifiedBy
    local metadataText = format(
        "Last Modified: %s\nLast Modified By: %s",
        EditorUtils.FormatDate(lastModified),
        lastModifiedBy or "Unknown"
    )

    local metadataLabel = Libs.AceGUI:Create("Label")
    metadataLabel:SetText(metadataText)
    metadataLabel:SetFullWidth(true)
    scrollContainer:AddChild(metadataLabel)
end

-- ~~~~~~~~~~ TALENTS & GLYPHS TAB ~~~~~~~~~~

--- Render the Talents & Glyphs tab
--- @param container table AceGUI container
function TabRenderers:RenderTalentsGlyphsTab(container, editorState)
    NAG:Info("[TabRenderers] Rendering Talents & Glyphs tab")
    container:SetLayout("Flow")

    local scrollContainer = CreateScrollContainer(container, "Flow")

    -- Talents Section
    local talentsHeader = Libs.AceGUI:Create("Heading")
    talentsHeader:SetText(L["talents"] or "Talents")
    talentsHeader:SetFullWidth(true)
    scrollContainer:AddChild(talentsHeader)

    -- Talents string input
    self:CreateTextInput(scrollContainer, L["talentsString"] or "Talents String", "talentsString", editorState)

    -- Assign Current Talents button
    local assignTalentsBtn = Libs.AceGUI:Create("Button")
    assignTalentsBtn:SetText(L["assignCurrentTalents"] or "Assign Current Talents")
    assignTalentsBtn:SetWidth(200)
    assignTalentsBtn:SetCallback("OnClick", function()
        self:AssignCurrentTalents(editorState)
    end)
    scrollContainer:AddChild(assignTalentsBtn)

    -- talents array (legacy)
    self:CreateIDListEditBox(scrollContainer, L["talentsArray"] or "Talents Array (comma-separated IDs, legacy)", "talents", nil, editorState)

    -- Glyphs Section
    local glyphsHeader = Libs.AceGUI:Create("Heading")
    glyphsHeader:SetText(L["glyphs"] or "Glyphs")
    glyphsHeader:SetFullWidth(true)
    scrollContainer:AddChild(glyphsHeader)

    -- Initialize glyphs if not present
    if not editorState.workingConfig.glyphs then
        editorState.workingConfig.glyphs = {major = {}, minor = {}}
    elseif type(editorState.workingConfig.glyphs) ~= "table" then
        editorState.workingConfig.glyphs = {major = {}, minor = {}}
    end

    -- Assign Current Glyphs button
    local assignGlyphsBtn = Libs.AceGUI:Create("Button")
    assignGlyphsBtn:SetText(L["assignCurrentGlyphs"] or "Assign Current Glyphs")
    assignGlyphsBtn:SetWidth(200)
    assignGlyphsBtn:SetCallback("OnClick", function()
        self:AssignCurrentGlyphs(editorState)
    end)
    scrollContainer:AddChild(assignGlyphsBtn)

    -- Major Glyphs
    if not editorState.workingConfig.glyphs then
        editorState.workingConfig.glyphs = {major = {}, minor = {}}
    end
    local majorGlyphsBox = Libs.AceGUI:Create("MultiLineEditBox")
    majorGlyphsBox:SetLabel(L["majorGlyphs"] or "Major Glyphs (comma-separated IDs)")
    majorGlyphsBox:SetFullWidth(true)
    majorGlyphsBox:SetNumLines(5)
    majorGlyphsBox:DisableButton(true)
    local majorGlyphs = editorState.workingConfig.glyphs.major or {}
    local majorText = (#majorGlyphs > 0) and table.concat(majorGlyphs, ", ") or ""
    majorGlyphsBox:SetText(majorText)
    majorGlyphsBox:SetCallback("OnTextChanged", function(widget, event, text)
        if not editorState.workingConfig.glyphs then
            editorState.workingConfig.glyphs = {major = {}, minor = {}}
        end
        editorState.workingConfig.glyphs.major = self:ParseIDList(text)
        EditorUtils.MarkDirty(editorState)
    end)
    scrollContainer:AddChild(majorGlyphsBox)

    -- Minor Glyphs
    if not editorState.workingConfig.glyphs then
        editorState.workingConfig.glyphs = {major = {}, minor = {}}
    end
    local minorGlyphsBox = Libs.AceGUI:Create("MultiLineEditBox")
    minorGlyphsBox:SetLabel(L["minorGlyphs"] or "Minor Glyphs (comma-separated IDs)")
    minorGlyphsBox:SetFullWidth(true)
    minorGlyphsBox:SetNumLines(5)
    minorGlyphsBox:DisableButton(true)
    local minorGlyphs = editorState.workingConfig.glyphs.minor or {}
    local minorText = (#minorGlyphs > 0) and table.concat(minorGlyphs, ", ") or ""
    minorGlyphsBox:SetText(minorText)
    minorGlyphsBox:SetCallback("OnTextChanged", function(widget, event, text)
        if not editorState.workingConfig.glyphs then
            editorState.workingConfig.glyphs = {major = {}, minor = {}}
        end
        editorState.workingConfig.glyphs.minor = self:ParseIDList(text)
        EditorUtils.MarkDirty(editorState)
    end)
    scrollContainer:AddChild(minorGlyphsBox)
end

--- Assign current player talents to the rotation
function TabRenderers:AssignCurrentTalents(editorState)
    local talentData = self:GetCurrentPlayerTalents()
    if talentData and talentData.talentsString then
        editorState.workingConfig.talentsString = talentData.talentsString
        EditorUtils.MarkDirty(editorState)
        NAG:Info("|cFF00FF00Assigned current talents: " .. talentData.talentsString .. "|r")

        -- Refresh the tab to show the update
        EditorUtils.RefreshCurrentTab(TabRenderers, editorState)
    else
        -- No talents selected - clear the field
        editorState.workingConfig.talentsString = nil
        EditorUtils.MarkDirty(editorState)
        NAG:Info("|cFFFFD100No talents currently selected. Cleared talentsString from rotation.|r")
        NAG:Info("|cFF888888Select talents in your talent pane, then use this button to capture them.|r")

        -- Refresh the tab to show the update
        EditorUtils.RefreshCurrentTab(TabRenderers, editorState)
    end
end

--- Assign current player glyphs to the rotation
function TabRenderers:AssignCurrentGlyphs(editorState)
    local glyphData = self:GetCurrentPlayerGlyphs()
    if glyphData then
        if not editorState.workingConfig.glyphs then
            editorState.workingConfig.glyphs = {}
        end
        editorState.workingConfig.glyphs.major = glyphData.major or {}
        editorState.workingConfig.glyphs.minor = glyphData.minor or {}
        EditorUtils.MarkDirty(editorState)
        NAG:Info(format("|cFF00FF00Assigned current glyphs: %d major, %d minor|r", #glyphData.major, #glyphData.minor))

        -- Refresh the tab to show the update
        EditorUtils.RefreshCurrentTab(TabRenderers, editorState)
    else
        -- No glyphs socketed - clear the field
        if not editorState.workingConfig.glyphs then
            editorState.workingConfig.glyphs = {}
        end
        editorState.workingConfig.glyphs.major = {}
        editorState.workingConfig.glyphs.minor = {}
        EditorUtils.MarkDirty(editorState)
        NAG:Info("|cFFFFD100No glyphs currently socketed. Cleared glyphs from rotation.|r")
        NAG:Info("|cFF888888Socket glyphs in your glyph pane, then use this button to capture them.|r")

        -- Refresh the tab to show the update
        EditorUtils.RefreshCurrentTab(TabRenderers, editorState)
    end
end

--- Get current player talents
--- @return table|nil Talent data {talentsString, talents}
function TabRenderers:GetCurrentPlayerTalents()
    NAG:Debug("[TabRenderers] Starting talent detection")

    local SpecCompat = NAG:GetModule("SpecCompat")
    -- For MoP: Build talents string from current selections
    local talentsString = ""
    local numTiers = 6 -- MoP has 6 talent tiers

    for tier = 1, numTiers do
        local selectedColumn = 0

        for column = 1, 3 do
            -- Convert tier/column to linear index (MoP uses 1-18)
            local talentIndex = (tier - 1) * 3 + column

            -- Use SpecCompat API
            local talentInfo = SpecCompat:GetTalentInfo(nil, talentIndex, false, false, nil)

            if talentInfo then
                if talentInfo.rank and talentInfo.rank > 0 then
                    selectedColumn = column
                    break
                end
            end
        end

        talentsString = talentsString .. tostring(selectedColumn)
    end

    if talentsString ~= "" and talentsString ~= string.rep("0", numTiers) then
        NAG:Debug(format("[TabRenderers] Talent detection complete: '%s'", talentsString))
        return {
            talentsString = talentsString,
            talents = {}
        }
    end

    NAG:Debug("[TabRenderers] No talents selected")
    return nil
end

--- Get current player glyphs
--- @return table|nil Glyph data {major = {}, minor = {}}
function TabRenderers:GetCurrentPlayerGlyphs()
    NAG:Debug("[TabRenderers] Starting glyph detection")

    -- Check if glyph API is available
    if not GetGlyphSocketInfo then
        NAG:Warn("[TabRenderers] GetGlyphSocketInfo API not available")
        return nil
    end

    local major = {}
    local minor = {}

    -- MoP: Get glyphs from the glyph slots
    local numSlots = 6 -- MoP has 6 glyph slots (3 major, 3 minor)

    for i = 1, numSlots do
        local enabled, glyphType, glyphTooltipIndex, glyphSpellID, icon = GetGlyphSocketInfo(i)

        if enabled and glyphSpellID then
            if glyphType == 1 then -- Major glyph
                tinsert(major, glyphSpellID)
            elseif glyphType == 2 then -- Minor glyph
                tinsert(minor, glyphSpellID)
            end
        end
    end

    if #major > 0 or #minor > 0 then
        NAG:Debug(format("[TabRenderers] Glyph detection complete: %d major, %d minor", #major, #minor))
        return {major = major, minor = minor}
    end

    NAG:Debug("[TabRenderers] No glyphs socketed")
    return nil
end

return TabRenderers

