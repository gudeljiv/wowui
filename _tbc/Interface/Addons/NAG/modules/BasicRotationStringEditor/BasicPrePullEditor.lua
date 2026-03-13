--- @module "BasicRotationStringEditor.BasicPrePullEditor"
--- PrePull timeline editor for BasicRotationStringEditor
--- String-based, no aplProto dependencies
--- License: CC BY-NC 4.0
--- Authors: Rakizi, Fonsas

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- Localizations
local AceGUI = ns.AceGUI
local L = ns.AceLocale:GetLocale("NAG", true)
local WoWAPI = ns.WoWAPI

-- Lua APIs
local format = string.format
local tinsert = tinsert
local tremove = tremove
local tostring = tostring
local tonumber = tonumber
local type = type
local ipairs = ipairs
local sort = table.sort
local math = math

-- ~~~~~~~~~~ MODULE DEFINITION ~~~~~~~~~~

local BasicPrePullEditor = {}
ns.BasicRotationStringEditor = ns.BasicRotationStringEditor or {}
ns.BasicRotationStringEditor.BasicPrePullEditor = BasicPrePullEditor

-- ~~~~~~~~~~ PREPULL TAB ~~~~~~~~~~

--- Render the PrePull & Timeline tab
--- @param container table AceGUI container
--- @param editorState table Editor state with workingConfig
function BasicPrePullEditor:RenderPrePullTab(container, editorState)
    container:SetLayout("List")

    -- Ensure data exists and keep sorted
    if not editorState.workingConfig.prePull then
        editorState.workingConfig.prePull = {}
    end

    local function sortPrePull()
        sort(editorState.workingConfig.prePull, function(a, b)
            return (a.time or 0) < (b.time or 0)
        end)
    end
    sortPrePull()

    local function broadcastPreview()
        if not (NAG and NAG.SendMessage) then return end
        -- Create a shallow copy safe for transport
        local list = {}
        for i, v in ipairs(editorState.workingConfig.prePull) do
            list[i] = { time = v.time, action = v.action }
        end
        NAG:SendMessage("NAG_PREPULL_UPDATED", {
            specIndex = editorState.specIndex,
            rotationName = editorState.rotationName,
            prePull = list
        })
    end

    -- Build left tree data
    local function summarizeActionText(text)
        if not text or text == "" then return "" end
        local s = tostring(text):gsub("\n", " ")
        if #s > 28 then s = s:sub(1, 28) .. "…" end
        return s
    end

    local function buildTree()
        local nodes = {}
        -- Action nodes
        for i, entry in ipairs(editorState.workingConfig.prePull) do
            local timeStr = tostring(entry.time or -5)
            local displayName = nil
            local iconTex
            -- Try to extract ID from action string
            local act = entry.action or ""
            -- Support NAG:GetBattlePotion()
            local id
            if act:find("NAG:GetBattlePotion", 1, true) then
                local pot = NAG and NAG.GetBattlePotion and NAG:GetBattlePotion()
                id = tonumber(pot)
            end
            if not id then
                id = tonumber(act:match("NAG:%s*Cast%s*%(%s*(%d+)%s*%)"))
            end
            if not id then
                id = tonumber(act)
            end
            if id then
                -- Determine preference (item vs spell)
                local preferItem = false
                if editorState._prepullTypes and editorState._prepullTypes[entry] == "item" then
                    preferItem = true
                end
                local pot = NAG and NAG.GetBattlePotion and NAG:GetBattlePotion()
                if pot and id == pot then preferItem = true end

                -- Resolve name/icon with preference
                local SpellbookManager = NAG:GetModule("SpellbookManager")
                if preferItem then
                    local itemName, _, _, _, _, _, _, _, _, itemIcon = WoWAPI.GetItemInfo(id)
                    if itemName then
                        displayName = itemName
                        iconTex = itemIcon
                    else
                        local spellEntry = SpellbookManager and SpellbookManager:GetSpell(id)
                        if spellEntry and spellEntry.name then
                            displayName = spellEntry.name
                            iconTex = spellEntry.icon
                        end
                    end
                else
                    local spellEntry = SpellbookManager and SpellbookManager:GetSpell(id)
                    if spellEntry and spellEntry.name then
                        displayName = spellEntry.name
                        iconTex = spellEntry.icon
                    else
                        local itemName, _, _, _, _, _, _, _, _, itemIcon = WoWAPI.GetItemInfo(id)
                        displayName = itemName
                        iconTex = itemIcon
                    end
                end
            elseif act ~= "" then
                -- Treat remaining text as name
                displayName = act
            end
            local iconTag = iconTex and ("|T" .. tostring(iconTex) .. ":16:16:0:0|t ") or ""
            local label = iconTag .. format("#%d [%ss] %s", i, timeStr, summarizeActionText(displayName or act))
            tinsert(nodes, { value = "i:" .. i, text = label })
        end
        return nodes
    end

    local function indexFromValue(value)
        if type(value) ~= "string" then return nil end
        local idx = value:match("^i:(%d+)$")
        return idx and tonumber(idx) or nil
    end

    -- Resolve helper: returns normalized action string and metadata
    local function resolveInput(text, prefer)
        if not text then return nil end
        local raw = tostring(text)
        -- Special-case: NAG:GetBattlePotion()
        if raw:find("NAG:GetBattlePotion", 1, true) then
            local potId = NAG and NAG.GetBattlePotion and NAG:GetBattlePotion()
            if potId then
                local itemName, _, _, _, _, _, _, _, _, itemIcon = WoWAPI.GetItemInfo(potId)
                return format("NAG:CastSpell(%d)", potId), potId, itemName, itemIcon, true
            end
        end

        -- Extract numeric ID
        local id = tonumber(raw:match("NAG:%s*Cast%s*%(%s*(%d+)%s*%)")) or tonumber(raw)
        local isItem = false
        local name, icon

        if id then
            -- If matches battle potion, treat as item
            local potId = NAG and NAG.GetBattlePotion and NAG:GetBattlePotion()
            if potId and id == potId then prefer = "item" end

            if prefer == "item" then
                name, _, _, _, _, _, _, _, _, icon = WoWAPI.GetItemInfo(id)
                if name then isItem = true end
                if not name then
                    -- Fallback to spell
                    local spellInfo = WoWAPI.GetSpellInfo(id)
                    if spellInfo and spellInfo.name then
                        name = spellInfo.name
                        icon = spellInfo.iconID
                        isItem = false
                    end
                end
            else
                local spellInfo = WoWAPI.GetSpellInfo(id)
                if spellInfo and spellInfo.name then
                    name = spellInfo.name
                    icon = spellInfo.iconID
                    isItem = false
                else
                    name, _, _, _, _, _, _, _, _, icon = WoWAPI.GetItemInfo(id)
                    if name then isItem = true end
                end
            end

            return format("NAG:CastSpell(%d)", id), id, name, icon, isItem
        else
            -- Name input: try spell first unless item preferred
            if prefer == "item" then
                name, _, _, _, _, _, _, _, _, icon = WoWAPI.GetItemInfo(raw)
                if name then
                    return raw, nil, name, icon, true
                end
                local spellInfo = WoWAPI.GetSpellInfo(raw)
                if spellInfo and spellInfo.name and spellInfo.spellID then
                    return format("NAG:CastSpell(%d)", spellInfo.spellID), spellInfo.spellID, spellInfo.name, spellInfo.iconID, false
                end
            else
                local spellInfo = WoWAPI.GetSpellInfo(raw)
                if spellInfo and spellInfo.name and spellInfo.spellID then
                    return format("NAG:CastSpell(%d)", spellInfo.spellID), spellInfo.spellID, spellInfo.name, spellInfo.iconID, false
                end
                name, _, _, _, _, _, _, _, _, icon = WoWAPI.GetItemInfo(raw)
                if name then
                    return raw, nil, name, icon, true
                end
            end
        end
        return raw, nil, nil, nil, nil
    end

    -- Right-side detail renderer
    local function renderDetail(treeGroup, value)
        treeGroup:ReleaseChildren()
        local right = AceGUI:Create("SimpleGroup")
        right:SetLayout("Flow")
        right:SetFullWidth(true)
        right:SetFullHeight(true)
        treeGroup:AddChild(right)

        local idx = indexFromValue(value)
        if not idx then
            -- No selection: show info and add button
            local addBtn = AceGUI:Create("Button")
            addBtn:SetText(L["addAction"] or "+ Add Action")
            addBtn:SetWidth(200)
            addBtn:SetCallback("OnClick", function()
                local new = { time = -5, action = "" }
                tinsert(editorState.workingConfig.prePull, new)
                sortPrePull()
                broadcastPreview()
                local nodes = buildTree()
                treeGroup:SetTree(nodes)
                local newIndex
                for i, entry in ipairs(editorState.workingConfig.prePull) do
                    if entry == new then newIndex = i break end
                end
                local sel = newIndex and ("i:" .. newIndex) or nil
                editorState.prepullSelectedValue = sel
                if sel then treeGroup:SelectByValue(sel) end
            end)
            right:AddChild(addBtn)

            -- Tips block
            local infoHeader = AceGUI:Create("Heading")
            infoHeader:SetText(L["prePullTips"] or "Tips")
            infoHeader:SetFullWidth(true)
            right:AddChild(infoHeader)

            local tipsLabel = AceGUI:Create("Label")
            tipsLabel:SetText("|cFFFFD100• Actions are executed at the specified time before pull\n• Negative values = seconds before combat starts\n• Actions are automatically sorted from earliest to latest\n• Use NAG:GroupReference('name') to reference action groups (see Groups & Variables tab)|r")
            tipsLabel:SetFullWidth(true)
            right:AddChild(tipsLabel)
            return
        end

        local entry = editorState.workingConfig.prePull[idx]
        if not entry then return end

        -- Declare UI refs for closures
        local actionInput
        local previewIcon
        local nameLabel
        local idLabel
        local typeDropdown

        -- Temporary per-entry type preference (not persisted)
        editorState._prepullTypes = editorState._prepullTypes or {}
        local preferType = editorState._prepullTypes[entry] or "spell" -- "spell" | "item"

        -- Title with time
        local title = AceGUI:Create("Heading")
        title:SetText(format("%s #%d (%ss)", L["prePullAction"] or "PrePull Action", idx, tostring(entry.time or -5)))
        title:SetFullWidth(true)
        right:AddChild(title)

        -- Keep a reference to reselect after re-sort
        local selectedRef = entry

        -- Time slider
        local timeSlider = AceGUI:Create("Slider")
        timeSlider:SetLabel(L["time"] or "Time Before Pull (seconds)")
        timeSlider:SetRelativeWidth(0.95)
        timeSlider:SetSliderValues(-120, 0, 1)
        timeSlider:SetValue(entry.time or -5)
        timeSlider:SetCallback("OnValueChanged", function(_, _, value)
            entry.time = value
        end)
        timeSlider:SetCallback("OnMouseUp", function()
            local currentValue = timeSlider.GetValue and timeSlider:GetValue() or entry.time
            if currentValue ~= entry.time then
                entry.time = currentValue
            end
            sortPrePull()
            broadcastPreview()
            local nodes = buildTree()
            treeGroup:SetTree(nodes)
            -- reselect same entry by reference
            local newIndex
            for i, e in ipairs(editorState.workingConfig.prePull) do
                if e == selectedRef then newIndex = i break end
            end
            local sel = newIndex and ("i:" .. newIndex) or "add"
            editorState.prepullSelectedValue = sel
            treeGroup:SelectByValue(sel)
        end)
        right:AddChild(timeSlider)

        -- Type selector
        typeDropdown = AceGUI:Create("Dropdown")
        typeDropdown:SetLabel(L["actionType"] or "Action Type")
        typeDropdown:SetRelativeWidth(0.4)
        typeDropdown:SetList({ spell = (L["spell"] or "Spell"), item = (L["item"] or "Item") })
        typeDropdown:SetValue(preferType)
        typeDropdown:SetCallback("OnValueChanged", function(_, _, value)
            preferType = value
            editorState._prepullTypes[entry] = preferType
            -- Re-resolve current text to update preview
            if actionInput and actionInput.GetText then
                local normalized, rid, rname, ricon = resolveInput(actionInput:GetText(), preferType)
                if rname and nameLabel then nameLabel:SetText(rname) elseif nameLabel then nameLabel:SetText("|cFFFF0000Error: Spell/Item not found.|r") end
                if ricon and previewIcon then previewIcon:SetImage(ricon) elseif previewIcon then previewIcon:SetImage(nil) end
                if idLabel then idLabel:SetText(rid and ("ID: " .. tostring(rid)) or "") end
            end
        end)
        right:AddChild(typeDropdown)

        -- Preview row (icon + resolved name + ID)
        local previewRow = AceGUI:Create("SimpleGroup")
        previewRow:SetLayout("Flow")
        previewRow:SetFullWidth(true)

        previewIcon = AceGUI:Create("Icon")
        previewIcon:SetImageSize(20, 20)
        previewIcon:SetWidth(24)
        previewIcon:SetHeight(24)
        previewRow:AddChild(previewIcon)

        nameLabel = AceGUI:Create("Label")
        nameLabel:SetText("")
        nameLabel:SetRelativeWidth(0.7)
        previewRow:AddChild(nameLabel)

        idLabel = AceGUI:Create("Label")
        idLabel:SetText("")
        idLabel:SetRelativeWidth(0.25)
        previewRow:AddChild(idLabel)

        right:AddChild(previewRow)

        -- Action input
        actionInput = AceGUI:Create("EditBox")
        actionInput:SetLabel(L["action"] or "Action")
        actionInput:SetRelativeWidth(0.75)
        -- Initialize input with numeric ID if resolvable
        do
            local preset = entry.action or ""
            local presetId
            if preset:find("NAG:GetBattlePotion", 1, true) then
                local pot = NAG and NAG.GetBattlePotion and NAG:GetBattlePotion()
                presetId = tonumber(pot)
            end
            if not presetId then
                presetId = tonumber(preset:match("NAG:%s*Cast%s*%(%s*(%d+)%s*%)")) or tonumber(preset)
            end
            if presetId then
                actionInput:SetText(tostring(presetId))
                local pot = NAG and NAG.GetBattlePotion and NAG:GetBattlePotion()
                local preferItemInit = (preferType == "item") or (pot and presetId == pot)
                if preferItemInit then
                    local iname, _, _, _, _, _, _, _, _, iicon = WoWAPI.GetItemInfo(presetId)
                    if iname then
                        nameLabel:SetText(iname)
                        previewIcon:SetImage(iicon)
                        idLabel:SetText("ID: " .. tostring(presetId))
                    else
                        local spellInfo = WoWAPI.GetSpellInfo(presetId)
                        if spellInfo and spellInfo.name then
                            nameLabel:SetText(spellInfo.name)
                            previewIcon:SetImage(spellInfo.iconID)
                            idLabel:SetText("ID: " .. tostring(presetId))
                        end
                    end
                else
                    local spellInfo = WoWAPI.GetSpellInfo(presetId)
                    if spellInfo and spellInfo.name then
                        nameLabel:SetText(spellInfo.name)
                        previewIcon:SetImage(spellInfo.iconID)
                        idLabel:SetText("ID: " .. tostring(presetId))
                    else
                        local iname, _, _, _, _, _, _, _, _, iicon = WoWAPI.GetItemInfo(presetId)
                        if iname then
                            nameLabel:SetText(iname)
                            previewIcon:SetImage(iicon)
                            idLabel:SetText("ID: " .. tostring(presetId))
                        end
                    end
                end
            else
                actionInput:SetText(preset)
            end
        end
        actionInput:SetCallback("OnEnterPressed", function(_, _, text)
            local normalized, rid, rname, ricon, isItem = resolveInput(text, preferType)
            if rid then
                entry.action = normalized
                broadcastPreview()
                -- Update preview
                if rname then nameLabel:SetText(rname) end
                if ricon then previewIcon:SetImage(ricon) end
                if rid then idLabel:SetText("ID: " .. tostring(rid)) end
                -- Show only numeric ID to user
                actionInput:SetText(tostring(rid))
                -- Auto-adjust type selector if detection differs
                if isItem and preferType ~= "item" then
                    preferType = "item"
                    editorState._prepullTypes[entry] = preferType
                    if typeDropdown and typeDropdown.SetValue then typeDropdown:SetValue("item") end
                elseif (not isItem) and preferType ~= "spell" then
                    preferType = "spell"
                    editorState._prepullTypes[entry] = preferType
                    if typeDropdown and typeDropdown.SetValue then typeDropdown:SetValue("spell") end
                end
                -- Rebuild tree with resolved name
                sortPrePull()
                local nodes = buildTree()
                treeGroup:SetTree(nodes)
                -- Reselect this entry
                local newIndex
                for i, e in ipairs(editorState.workingConfig.prePull) do
                    if e == entry then newIndex = i break end
                end
                local sel = newIndex and ("i:" .. newIndex) or "add"
                editorState.prepullSelectedValue = sel
                if sel then treeGroup:SelectByValue(sel) end
            else
                -- Update preview even if unresolved
                if rname then nameLabel:SetText(rname) else nameLabel:SetText("|cFFFF0000Error: Spell/Item not found.|r") end
                if ricon then previewIcon:SetImage(ricon) else previewIcon:SetImage(nil) end
                idLabel:SetText("")
            end
        end)
        actionInput:SetCallback("OnTextChanged", function(_, _, text)
            local _, rid, rname, ricon, isItem = resolveInput(text, preferType)
            if rname then nameLabel:SetText(rname) else nameLabel:SetText("|cFFFF0000Error: Spell/Item not found.|r") end
            if ricon then previewIcon:SetImage(ricon) else previewIcon:SetImage(nil) end
            if rid then idLabel:SetText("ID: " .. tostring(rid)) else idLabel:SetText("") end
            -- Auto-adjust selector for battle potion or detected item/spell on the fly
            if isItem and preferType ~= "item" then
                preferType = "item"
                editorState._prepullTypes[entry] = preferType
                if typeDropdown and typeDropdown.SetValue then typeDropdown:SetValue("item") end
            elseif (not isItem) and rid and preferType ~= "spell" then
                preferType = "spell"
                editorState._prepullTypes[entry] = preferType
                if typeDropdown and typeDropdown.SetValue then typeDropdown:SetValue("spell") end
            end
        end)
        right:AddChild(actionInput)

        -- Buttons row
        local buttons = AceGUI:Create("SimpleGroup")
        buttons:SetLayout("Flow")
        buttons:SetFullWidth(true)

        local duplicateBtn = AceGUI:Create("Button")
        duplicateBtn:SetText(L["duplicate"] or "Duplicate")
        duplicateBtn:SetWidth(120)
        duplicateBtn:SetCallback("OnClick", function()
            local copy = { time = entry.time, action = entry.action }
            tinsert(editorState.workingConfig.prePull, idx + 1, copy)
            sortPrePull()
            broadcastPreview()
            local nodes = buildTree()
            treeGroup:SetTree(nodes)
            -- select duplicated entry (by reference)
            local newIndex
            for i, e in ipairs(editorState.workingConfig.prePull) do
                if e == copy then newIndex = i break end
            end
            local sel = newIndex and ("i:" .. newIndex) or "add"
            editorState.prepullSelectedValue = sel
            treeGroup:SelectByValue(sel)
        end)
        buttons:AddChild(duplicateBtn)

        local deleteBtn = AceGUI:Create("Button")
        deleteBtn:SetText(L["delete"] or "Delete")
        deleteBtn:SetWidth(120)
        deleteBtn:SetCallback("OnClick", function()
            tremove(editorState.workingConfig.prePull, idx)
            sortPrePull()
            broadcastPreview()
            local nodes = buildTree()
            treeGroup:SetTree(nodes)
            local nextIndex = math.min(idx, #editorState.workingConfig.prePull)
            local sel = nextIndex >= 1 and ("i:" .. nextIndex) or "add"
            editorState.prepullSelectedValue = sel
            treeGroup:SelectByValue(sel)
        end)
        buttons:AddChild(deleteBtn)

        right:AddChild(buttons)

        -- Tips block
        local infoHeader = AceGUI:Create("Heading")
        infoHeader:SetText(L["prePullTips"] or "Tips")
        infoHeader:SetFullWidth(true)
        right:AddChild(infoHeader)

        local tipsLabel = AceGUI:Create("Label")
        tipsLabel:SetText("|cFFFFD100• Actions are executed at the specified time before pull\n• Negative values = seconds before combat starts\n• Actions are automatically sorted from earliest to latest\n• Use NAG:GroupReference('name') to reference action groups (see Groups & Variables tab)|r")
        tipsLabel:SetFullWidth(true)
        right:AddChild(tipsLabel)
    end

    -- Create TreeGroup (left: list, right: detail) - create first so callbacks can reference it
    local treeGroup = ns.CreateTreeGroup()
    treeGroup:SetLayout("Fill")
    treeGroup:SetFullWidth(true)
    treeGroup:SetFullHeight(true)
    treeGroup.noAutoHeight = true -- Prevent auto-sizing - let parent container control height

    -- Set up status table for persisting tree state (BEFORE adding to parent)
    if not editorState.prepullTreeStatus then
        editorState.prepullTreeStatus = {
            groups = {},
            treewidth = 260,
            treesizable = true,
            scrollvalue = 0
        }
    end
    treeGroup:SetStatusTable(editorState.prepullTreeStatus)

    -- Enable resizable divider with persisted width (BEFORE setting tree)
    local persistedWidth = editorState.prepullTreeStatus.treewidth or 260
    if treeGroup.SetTreeWidth then treeGroup:SetTreeWidth(persistedWidth, true) end

    treeGroup:SetTree(buildTree())
    treeGroup:SetCallback("OnGroupSelected", function(widget, event, value)
        editorState.prepullSelectedValue = value
        renderDetail(widget, value)
    end)

    -- Controls bar (top) with Add button
    local controls = AceGUI:Create("SimpleGroup")
    controls:SetLayout("Flow")
    controls:SetFullWidth(true)
    local addTopBtn = AceGUI:Create("Button")
    addTopBtn:SetText(L["addAction"] or "+ Add Action")
    addTopBtn:SetWidth(160)
    addTopBtn:SetCallback("OnClick", function()
        local new = { time = -5, action = "" }
        tinsert(editorState.workingConfig.prePull, new)
        sortPrePull()
        local nodes = buildTree()
        treeGroup:SetTree(nodes)
        local newIndex
        for i, entry in ipairs(editorState.workingConfig.prePull) do
            if entry == new then newIndex = i break end
        end
        local sel = newIndex and ("i:" .. newIndex) or nil
        editorState.prepullSelectedValue = sel
        if sel then treeGroup:SelectByValue(sel) else renderDetail(treeGroup, nil) end
    end)
    controls:AddChild(addTopBtn)

    -- Test timeline controls (>=15s)
    editorState._prepullTestSeconds = editorState._prepullTestSeconds or 15
    local testSecsInput = AceGUI:Create("EditBox")
    testSecsInput:SetLabel(L["testSeconds"] or "Seconds")
    testSecsInput:SetText(tostring(editorState._prepullTestSeconds))
    testSecsInput:SetWidth(120)
    testSecsInput:SetCallback("OnEnterPressed", function(_, _, text)
        local v = tonumber(text) or 15
        if v < 15 then v = 15 end
        editorState._prepullTestSeconds = v
        testSecsInput:SetText(tostring(v))
    end)
    controls:AddChild(testSecsInput)

    local testBtn = AceGUI:Create("Button")
    testBtn:SetText(L["testTimeline"] or "Test Timeline")
    testBtn:SetWidth(140)
    testBtn:SetCallback("OnClick", function()
        local secs = tonumber(testSecsInput:GetText()) or editorState._prepullTestSeconds or 15
        if secs < 15 then secs = 15 end
        editorState._prepullTestSeconds = secs
        testSecsInput:SetText(tostring(secs))
        local PullTimerManager = NAG:GetModule("PullTimerManager")
        -- Ensure module is initialized/enabled for timers
        if not PullTimerManager.state or not PullTimerManager.StartPullTimer then
            if PullTimerManager.ModuleInitialize then pcall(function() PullTimerManager:ModuleInitialize() end) end
            if PullTimerManager.ModuleEnable then pcall(function() PullTimerManager:ModuleEnable() end) end
        end
        -- Start the countdown
        PullTimerManager:StartPullTimer(secs)
        -- Ensure timeline frame becomes visible
        local PrePullTimeline = NAG:GetModule("PrePullTimeline")
        if PrePullTimeline then
            if PrePullTimeline.ModuleInitialize then pcall(function() PrePullTimeline:ModuleInitialize() end) end
            if PrePullTimeline.ModuleEnable then pcall(function() PrePullTimeline:ModuleEnable() end) end
            if PrePullTimeline.UpdateVisibility then pcall(function() PrePullTimeline:UpdateVisibility() end) end
        end
    end)
    controls:AddChild(testBtn)
    container:AddChild(controls)

    -- Wrap TreeGroup in a Fill container to take remaining space
    local treeContainer = AceGUI:Create("SimpleGroup")
    treeContainer:SetLayout("Fill")
    treeContainer:SetFullWidth(true)
    treeContainer:SetFullHeight(true)
    treeContainer:AddChild(treeGroup)
    container:AddChild(treeContainer)

    -- Initial selection
    local initial = editorState.prepullSelectedValue
    if not initial then
        if #editorState.workingConfig.prePull > 0 then
            treeGroup:SelectByValue("i:1")
        else
            renderDetail(treeGroup, nil)
        end
    else
        treeGroup:SelectByValue(initial)
    end
end

return BasicPrePullEditor

