--- @module "NAG.UptimeEditor"
--- Standalone editor for uptime timeline clusters
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi, @Fonsas

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS ~~~~~~~~~~
--- @type UptimeTrackerManager
--- @type OptionsFactory
--- @type DataManager
local UptimeTrackerManager, OptionsFactory, DataManager

local WoWAPI = ns.WoWAPI
local AceGUI = ns.AceGUI
local AceLocale = ns.AceLocale
local L = AceLocale:GetLocale("NAG", true)

-- Lua helpers
local format = string.format
local tinsert = table.insert
local tremove = table.remove
local ipairs = ipairs
local CreateFrame = _G.CreateFrame
local GetItemIcon = C_Item and C_Item.GetItemIconByID or _G.GetItemIcon

-- ~~~~~~~~~~ STATE ~~~~~~~~~~
local editorState = {
    selectedClusterIndex = nil,
    frame = nil
}

-- ~~~~~~~~~~ DEFAULTS ~~~~~~~~~~
local defaults = {
    char = {
        framePosition = {
            point = "CENTER",
            x = 0,
            y = 0
        },
        frameSize = {
            width = 800,
            height = 600
        }
    }
}

--- @class UptimeEditor: CoreModule
local UptimeEditor = NAG:CreateModule("UptimeEditor", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,
    optionsCategory = ns.MODULE_CATEGORIES.UI,
    debugCategories = { ns.DEBUG_CATEGORIES.UI }
})
ns.UptimeEditor = UptimeEditor

-- ~~~~~~~~~~ LIFECYCLE ~~~~~~~~~~
function UptimeEditor:ModuleInitialize()
    UptimeTrackerManager = NAG:GetModule("UptimeTrackerManager")
    OptionsFactory = NAG:GetModule("OptionsFactory")
    DataManager = NAG:GetModule("DataManager")
end

function UptimeEditor:ModuleEnable()
    -- Editor created on demand
end

function UptimeEditor:ModuleDisable()
    if editorState.frame then
        editorState.frame:Hide()
    end
end

-- ~~~~~~~~~~ EDITOR UI ~~~~~~~~~~
function UptimeEditor:ShowEditor()
    if editorState.frame and editorState.frame:IsShown() then
        editorState.frame:Show() -- Bring to front
        return
    end

    self:CreateFrame()
end

function UptimeEditor:CreateFrame()
    if editorState.frame then
        editorState.frame:Show()
        return
    end

    local frame = AceGUI:Create("Frame")
    frame:SetTitle("Uptime Tracker Editor")
    frame:SetLayout("Flow")
    frame:SetWidth(self.db.char.frameSize.width)
    frame:SetHeight(self.db.char.frameSize.height)

    frame:SetCallback("OnClose", function(widget)
        self:SaveFramePosition(widget)
        widget:Hide()
    end)

    -- Enable resize
    frame:EnableResize(true)

    editorState.frame = frame

    -- Helper: Build tree nodes array (following PrePull pattern)
    local function buildTree()
        local clusters = UptimeTrackerManager:GetAllClusters()
        local nodes = {}

        for i, cluster in ipairs(clusters) do
            local name = cluster.name or format("Cluster %d", i)
            local count = #(cluster.trackingConfigs or cluster.trackedIds or {})
            local status = cluster.enabled and "✓" or "○"
            local label = format("%s [%d IDs] %s", status, count, name)
            tinsert(nodes, { value = "c:" .. i, text = label })
        end

        return nodes
    end

    -- Helper: Extract cluster index from tree value
    local function indexFromValue(value)
        if type(value) ~= "string" then return nil end
        local idx = value:match("^c:(%d+)$")
        return idx and tonumber(idx) or nil
    end

    -- Helper: Render detail panel (following PrePull pattern)
    local function renderDetail(treeGroup, value)
        treeGroup:ReleaseChildren()
        local right = AceGUI:Create("ScrollFrame")
        right:SetLayout("Flow")
        right:SetFullWidth(true)
        right:SetFullHeight(true)
        treeGroup:AddChild(right)

        local idx = indexFromValue(value)
        if not idx then
            -- No selection: show add button and info
            local addBtn = AceGUI:Create("Button")
            addBtn:SetText("+ Add Cluster")
            addBtn:SetWidth(200)
            addBtn:SetCallback("OnClick", function()
                local new = self:AddNewCluster()
                local nodes = buildTree()
                treeGroup:SetTree(nodes)
                local newIndex = #UptimeTrackerManager:GetAllClusters()
                if newIndex > 0 then
                    editorState.selectedValue = "c:" .. newIndex
                    treeGroup:SelectByValue(editorState.selectedValue)
                end
            end)
            right:AddChild(addBtn)

            -- Info
            local infoHeader = AceGUI:Create("Heading")
            infoHeader:SetText("Uptime Timeline Clusters")
            infoHeader:SetFullWidth(true)
            right:AddChild(infoHeader)

            local infoLabel = AceGUI:Create("Label")
            infoLabel:SetText("|cFFFFD100• Create clusters to track multiple buffs/debuffs together\n• Each cluster displays tracked items as timeline sparks\n• Position and configure each cluster independently\n• Sparks show countdown time remaining|r")
            infoLabel:SetFullWidth(true)
            right:AddChild(infoLabel)
            return
        end

        local cluster = UptimeTrackerManager:GetCluster(idx)
        if not cluster then return end

        -- Render cluster editor inline (following PrePull pattern)
        -- Title
        local title = AceGUI:Create("Heading")
        title:SetText(format("Cluster #%d: %s", idx, cluster.name or "Unnamed"))
        title:SetFullWidth(true)
        right:AddChild(title)

        -- Name editor
        local nameEdit = AceGUI:Create("EditBox")
        nameEdit:SetLabel("Cluster Name")
        nameEdit:SetText(cluster.name or format("Cluster %d", idx))
        nameEdit:SetRelativeWidth(0.95)
        nameEdit:SetCallback("OnEnterPressed", function(_, _, text)
            cluster.name = text
            UptimeTrackerManager:UpdateCluster(idx, { name = text })
            local nodes = buildTree()
            treeGroup:SetTree(nodes)
            treeGroup:SelectByValue("c:" .. idx)
        end)
        right:AddChild(nameEdit)

        -- Position group
        local posHeader = AceGUI:Create("Heading")
        posHeader:SetText("Position")
        posHeader:SetFullWidth(true)
        right:AddChild(posHeader)

        local posGroup = AceGUI:Create("SimpleGroup")
        posGroup:SetLayout("Flow")
        posGroup:SetFullWidth(true)

        self:AddNumberInput(posGroup, "X:", cluster.position.x or 0, function(_, _, text)
            local value = tonumber(text) or 0
            cluster.position.x = value
            UptimeTrackerManager:UpdateCluster(idx, { position = cluster.position })
            NAG:SendMessage("NAG_CLUSTER_CONFIG_CHANGED", { clusterIndex = idx })
        end)

        self:AddNumberInput(posGroup, "Y:", cluster.position.y or 0, function(_, _, text)
            local value = tonumber(text) or 0
            cluster.position.y = value
            UptimeTrackerManager:UpdateCluster(idx, { position = cluster.position })
            NAG:SendMessage("NAG_CLUSTER_CONFIG_CHANGED", { clusterIndex = idx })
        end)

        right:AddChild(posGroup)

        -- Size group
        local sizeHeader = AceGUI:Create("Heading")
        sizeHeader:SetText("Size")
        sizeHeader:SetFullWidth(true)
        right:AddChild(sizeHeader)

        local sizeGroup = AceGUI:Create("SimpleGroup")
        sizeGroup:SetLayout("Flow")
        sizeGroup:SetFullWidth(true)

        self:AddNumberInput(sizeGroup, "Width:", cluster.size.width or 200, function(_, _, text)
            local value = tonumber(text) or 200
            cluster.size.width = value
            UptimeTrackerManager:UpdateCluster(idx, { size = cluster.size })
            NAG:SendMessage("NAG_CLUSTER_CONFIG_CHANGED", { clusterIndex = idx })
        end)

        self:AddNumberInput(sizeGroup, "Height:", cluster.size.height or 2, function(_, _, text)
            local value = tonumber(text) or 2
            cluster.size.height = value
            UptimeTrackerManager:UpdateCluster(idx, { size = cluster.size })
            NAG:SendMessage("NAG_CLUSTER_CONFIG_CHANGED", { clusterIndex = idx })
        end)

        right:AddChild(sizeGroup)

        -- Tracking settings
        local trackHeader = AceGUI:Create("Heading")
        trackHeader:SetText("Tracking Settings")
        trackHeader:SetFullWidth(true)
        right:AddChild(trackHeader)

        self:AddNumberInput(right, "Max Time (seconds):", cluster.maxTrackingTime or 15, function(_, _, text)
            local value = tonumber(text) or 15
            cluster.maxTrackingTime = value
            UptimeTrackerManager:UpdateCluster(idx, { maxTrackingTime = value })
            NAG:SendMessage("NAG_CLUSTER_CONFIG_CHANGED", { clusterIndex = idx })
        end)

        -- Orientation
        local orientationDropdown = AceGUI:Create("Dropdown")
        orientationDropdown:SetLabel("Orientation")
        orientationDropdown:SetRelativeWidth(0.47)
        orientationDropdown:SetList({
            horizontal = "Horizontal",
            vertical = "Vertical"
        })
        orientationDropdown:SetValue(cluster.orientation or "horizontal")
        orientationDropdown:SetCallback("OnValueChanged", function(_, _, value)
            cluster.orientation = value
            UptimeTrackerManager:UpdateCluster(idx, { orientation = value })
            NAG:SendMessage("NAG_CLUSTER_CONFIG_CHANGED", { clusterIndex = idx })
        end)
        right:AddChild(orientationDropdown)

        -- Direction
        local directionDropdown = AceGUI:Create("Dropdown")
        directionDropdown:SetLabel("Direction")
        directionDropdown:SetRelativeWidth(0.47)
        directionDropdown:SetList({
            rightToLeft = "Right to Left",
            leftToRight = "Left to Right",
            topToBottom = "Top to Bottom",
            bottomToTop = "Bottom to Top"
        })
        directionDropdown:SetValue(cluster.direction or "rightToLeft")
        directionDropdown:SetCallback("OnValueChanged", function(_, _, value)
            cluster.direction = value
            UptimeTrackerManager:UpdateCluster(idx, { direction = value })
            NAG:SendMessage("NAG_CLUSTER_CONFIG_CHANGED", { clusterIndex = idx })
        end)
        right:AddChild(directionDropdown)

        -- Visibility section (moved before tracked IDs)
        local visHeader = AceGUI:Create("Heading")
        visHeader:SetText("Visibility Triggers")
        visHeader:SetFullWidth(true)
        right:AddChild(visHeader)

        -- Enable toggle
        local enabledToggle = AceGUI:Create("CheckBox")
        enabledToggle:SetLabel("Cluster Enabled")
        enabledToggle:SetValue(cluster.enabled ~= false)
        enabledToggle:SetFullWidth(true)
        enabledToggle:SetCallback("OnValueChanged", function(_, _, value)
            cluster.enabled = value
            UptimeTrackerManager:SetClusterEnabled(idx, value)
            local nodes = buildTree()
            treeGroup:SetTree(nodes)
            treeGroup:SelectByValue("c:" .. idx)
        end)
        right:AddChild(enabledToggle)

        local hideEmptyToggle = AceGUI:Create("CheckBox")
        hideEmptyToggle:SetLabel("Hide When Empty")
        hideEmptyToggle:SetValue(cluster.hideWhenEmpty == true)
        hideEmptyToggle:SetFullWidth(true)
        hideEmptyToggle:SetCallback("OnValueChanged", function(_, _, value)
            cluster.hideWhenEmpty = value
            UptimeTrackerManager:UpdateCluster(idx, { hideWhenEmpty = value })
            NAG:SendMessage("NAG_CLUSTER_CONFIG_CHANGED", { clusterIndex = idx })
        end)
        right:AddChild(hideEmptyToggle)

        local hideCombatToggle = AceGUI:Create("CheckBox")
        hideCombatToggle:SetLabel("Hide Out of Combat")
        hideCombatToggle:SetValue(cluster.hideOutOfCombat == true)
        hideCombatToggle:SetFullWidth(true)
        hideCombatToggle:SetCallback("OnValueChanged", function(_, _, value)
            cluster.hideOutOfCombat = value
            UptimeTrackerManager:UpdateCluster(idx, { hideOutOfCombat = value })
            NAG:SendMessage("NAG_CLUSTER_CONFIG_CHANGED", { clusterIndex = idx })
        end)
        right:AddChild(hideCombatToggle)

        -- Tracked IDs section
        local idsHeader = AceGUI:Create("Heading")
        idsHeader:SetText(format("Tracked IDs (%d)", #(cluster.trackingConfigs or cluster.trackedIds or {})))
        idsHeader:SetFullWidth(true)
        right:AddChild(idsHeader)

        -- Initialize trackingConfigs if not present
        if not cluster.trackingConfigs then
            cluster.trackingConfigs = {}
            -- Migrate old trackedIds to new format
            for _, spellId in ipairs(cluster.trackedIds or {}) do
                tinsert(cluster.trackingConfigs, {
                    id = spellId,
                    type = "buff",
                    unit = "player"
                })
            end
            cluster.trackedIds = nil -- Remove old format
        end

        for i, trackConfig in ipairs(cluster.trackingConfigs or {}) do
            local rowGroup = AceGUI:Create("InlineGroup")
            rowGroup:SetLayout("Flow")
            rowGroup:SetFullWidth(true)
            rowGroup:SetTitle(format("Track #%d", i))

            -- Spell icon/name
            local spellName = self:GetSpellName(trackConfig.id)
            local icon = self:GetSpellIcon(trackConfig.id)
            local iconTag = icon and format("|T%s:16:16:0:0|t", icon) or ""
            local nameLabel = AceGUI:Create("Label")
            nameLabel:SetText(format("%s %s (%d)", iconTag, spellName, trackConfig.id))
            nameLabel:SetRelativeWidth(0.95)
            rowGroup:AddChild(nameLabel)

            -- Type dropdown
            local typeDropdown = AceGUI:Create("Dropdown")
            typeDropdown:SetLabel("Track Type")
            typeDropdown:SetRelativeWidth(0.47)
            typeDropdown:SetList({
                buff = "Buff (Aura)",
                debuff = "Debuff",
                item = "Item Cooldown",
                spell = "Spell Cooldown"
            })
            typeDropdown:SetValue(trackConfig.type or "buff")
            typeDropdown:SetCallback("OnValueChanged", function(_, _, value)
                trackConfig.type = value
                UptimeTrackerManager:UpdateCluster(idx, { trackingConfigs = cluster.trackingConfigs })
            end)
            rowGroup:AddChild(typeDropdown)

            -- Unit dropdown (only for buff/debuff)
            if trackConfig.type == "buff" or trackConfig.type == "debuff" then
                local unitDropdown = AceGUI:Create("Dropdown")
                unitDropdown:SetLabel("Unit")
                unitDropdown:SetRelativeWidth(0.47)
                unitDropdown:SetList({
                    player = "Player",
                    target = "Target",
                    focus = "Focus",
                    pet = "Pet"
                })
                unitDropdown:SetValue(trackConfig.unit or "player")
                unitDropdown:SetCallback("OnValueChanged", function(_, _, value)
                    trackConfig.unit = value
                    UptimeTrackerManager:UpdateCluster(idx, { trackingConfigs = cluster.trackingConfigs })
                end)
                rowGroup:AddChild(unitDropdown)
            end

            -- Remove button
            local removeBtn = AceGUI:Create("Button")
            removeBtn:SetText("Remove")
            removeBtn:SetWidth(80)
            removeBtn:SetCallback("OnClick", function()
                tremove(cluster.trackingConfigs, i)
                UptimeTrackerManager:UpdateCluster(idx, { trackingConfigs = cluster.trackingConfigs })
                -- Refresh
                treeGroup:SelectByValue("c:" .. idx)
            end)
            rowGroup:AddChild(removeBtn)

            right:AddChild(rowGroup)
        end

        -- Add new tracked ID inline
        local addGroup = AceGUI:Create("InlineGroup")
        addGroup:SetLayout("Flow")
        addGroup:SetFullWidth(true)
        addGroup:SetTitle("Add New Tracked ID")

        local idInput = AceGUI:Create("EditBox")
        idInput:SetLabel("Spell/Item ID or Name")
        idInput:SetRelativeWidth(0.6)
        addGroup:AddChild(idInput)

        local addTypeDropdown = AceGUI:Create("Dropdown")
        addTypeDropdown:SetLabel("Type")
        addTypeDropdown:SetRelativeWidth(0.35)
        addTypeDropdown:SetList({
            buff = "Buff (Aura)",
            debuff = "Debuff",
            item = "Item Cooldown",
            spell = "Spell Cooldown"
        })
        addTypeDropdown:SetValue("buff")
        addGroup:AddChild(addTypeDropdown)

        local addUnitDropdown = AceGUI:Create("Dropdown")
        addUnitDropdown:SetLabel("Unit")
        addUnitDropdown:SetRelativeWidth(0.35)
        addUnitDropdown:SetList({
            player = "Player",
            target = "Target",
            focus = "Focus",
            pet = "Pet"
        })
        addUnitDropdown:SetValue("player")
        addGroup:AddChild(addUnitDropdown)

        local addBtn = AceGUI:Create("Button")
        addBtn:SetText("+ Add")
        addBtn:SetWidth(120)
        addBtn:SetCallback("OnClick", function()
            local val = idInput:GetText()
            local id = tonumber(val)

            if not id then
                -- Try spell name lookup
                local spellInfo = WoWAPI.GetSpellInfo(val)
                if spellInfo and spellInfo.spellID then
                    id = spellInfo.spellID
                end
            end

            if id then
                if not cluster.trackingConfigs then
                    cluster.trackingConfigs = {}
                end
                tinsert(cluster.trackingConfigs, {
                    id = id,
                    type = addTypeDropdown:GetValue() or "buff",
                    unit = addUnitDropdown:GetValue() or "player"
                })
                UptimeTrackerManager:UpdateCluster(idx, { trackingConfigs = cluster.trackingConfigs })
                idInput:SetText("")
                -- Refresh
                treeGroup:SelectByValue("c:" .. idx)
            else
                self:Error("Invalid ID or spell name: " .. tostring(val))
            end
        end)
        addGroup:AddChild(addBtn)

        right:AddChild(addGroup)

        -- Delete button
        local deleteBtn = AceGUI:Create("Button")
        deleteBtn:SetText("Delete Cluster")
        deleteBtn:SetWidth(150)
        deleteBtn:SetCallback("OnClick", function()
            if UptimeTrackerManager:DeleteCluster(idx) then
                editorState.selectedValue = nil
                local nodes = buildTree()
                treeGroup:SetTree(nodes)
                renderDetail(treeGroup, nil)
            end
        end)
        right:AddChild(deleteBtn)
    end

    -- Create TreeGroup (left: list, right: detail) FIRST
    local treeGroup = ns.CreateTreeGroup()
    treeGroup:SetLayout("Fill")
    treeGroup:SetFullWidth(true)
    treeGroup:SetFullHeight(true)

    -- Set up status table for persisting tree state
    if not editorState.treeStatus then
        editorState.treeStatus = {
            groups = {},
            treewidth = 260,
            treesizable = true,
            scrollvalue = 0
        }
    end
    treeGroup:SetStatusTable(editorState.treeStatus)

    -- Enable resizable divider
    local persistedWidth = editorState.treeStatus.treewidth or 260
    if treeGroup.SetTreeWidth then
        treeGroup:SetTreeWidth(persistedWidth, true)
    end

    treeGroup:SetTree(buildTree())
    treeGroup:SetCallback("OnGroupSelected", function(widget, event, value)
        editorState.selectedValue = value
        renderDetail(widget, value)
    end)

    editorState.tree = treeGroup

    -- Controls bar (top) with Add button - NOW treeGroup exists
    local controls = AceGUI:Create("SimpleGroup")
    controls:SetLayout("Flow")
    controls:SetFullWidth(true)

    local addTopBtn = AceGUI:Create("Button")
    addTopBtn:SetText("+ Add Cluster")
    addTopBtn:SetWidth(160)
    addTopBtn:SetCallback("OnClick", function()
        local new = self:AddNewCluster()
        local nodes = buildTree()
        treeGroup:SetTree(nodes)
        local newIndex = #UptimeTrackerManager:GetAllClusters()
        if newIndex > 0 then
            editorState.selectedValue = "c:" .. newIndex
            treeGroup:SelectByValue(editorState.selectedValue)
        end
    end)
    controls:AddChild(addTopBtn)

    frame:AddChild(controls)
    frame:AddChild(treeGroup)

    -- Initial selection
    local clusters = UptimeTrackerManager:GetAllClusters()
    if #clusters > 0 then
        treeGroup:SelectByValue("c:1")
    else
        renderDetail(treeGroup, nil)
    end

    self:RestoreFramePosition(frame)
end

function UptimeEditor:AddNewCluster()
    local success = UptimeTrackerManager:AddCluster({
        name = format("Cluster %d", #UptimeTrackerManager:GetAllClusters() + 1),
        trackingConfigs = {}
    })
    return success
end

-- ~~~~~~~~~~ HELPERS ~~~~~~~~~~
function UptimeEditor:AddLabel(container, text)
    local label = AceGUI:Create("Label")
    label:SetText(text)
    label:SetWidth(120)
    container:AddChild(label)
end

function UptimeEditor:AddNumberInput(container, label, value, callback)
    local numberLabel = AceGUI:Create("Label")
    numberLabel:SetText(label)
    numberLabel:SetWidth(60)
    container:AddChild(numberLabel)

    local edit = AceGUI:Create("EditBox")
    edit:SetText(tostring(value))
    edit:SetWidth(100)
    edit:SetCallback("OnEnterPressed", callback)
    container:AddChild(edit)

    return edit
end

function UptimeEditor:GetSpellName(spellId)
    if not spellId then return "Unknown" end

    local spellInfo = WoWAPI.GetSpellInfo(spellId)
    if spellInfo and spellInfo.name then
        return spellInfo.name
    end

    -- Try item
    local itemInfo = WoWAPI.GetItemInfo(spellId)
    if itemInfo then
        return itemInfo.name
    end

    return format("Unknown (%d)", spellId)
end

function UptimeEditor:GetSpellIcon(spellId)
    if not spellId then return nil end

    local spellInfo = WoWAPI.GetSpellInfo(spellId)
    if spellInfo and spellInfo.iconID then
        return spellInfo.icon
    end

    return GetItemIcon(spellId)
end

function UptimeEditor:SaveFramePosition(frame)
    local point, _, _, x, y = frame.frame:GetPoint()
    self.db.char.framePosition = { point = point, x = x, y = y }
end

function UptimeEditor:RestoreFramePosition(frame)
    if self.db.char.framePosition then
        frame:ClearAllPoints()
        frame:SetPoint(
            self.db.char.framePosition.point,
            UIParent,
            self.db.char.framePosition.x,
            self.db.char.framePosition.y
        )
    end
end

-- ~~~~~~~~~~ PUBLIC API ~~~~~~~~~~
function UptimeEditor:Show()
    self:ShowEditor()
end

