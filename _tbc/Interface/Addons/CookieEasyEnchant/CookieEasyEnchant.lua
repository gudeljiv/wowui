-- CookieEasyEnchant: Spam enchants easily for leveling enchanting
-- Integrates with the Enchanting UI - drag an item, spam the button

local addonName, addon = ...

-- Saved variables (initialized on ADDON_LOADED)
CookieEasyEnchantDB = CookieEasyEnchantDB or {}

-- Local references
local easyEnchantFrame
local enchantButton
local itemButton
local toggleButton
local contentFrame
local selectedItem = nil  -- {bag, slot, name, link, icon, itemID}

-- Forward declarations
local UpdateEnchantButtonMacro
local UpdateMacroText

-- Skillet-Classic integration: detect if Skillet is managing the craft window
local function IsSkilletActive()
    return Skillet and SkilletFrame and SkilletFrame:IsShown()
end

local function GetCraftParentFrame()
    if IsSkilletActive() then
        return SkilletFrame
    end
    return CraftFrame
end

-- Create the secure button immediately at load time so keybindings work
-- It will be reparented and positioned when the CraftFrame opens
enchantButton = CreateFrame("Button", "CookieEasyEnchantButton", UIParent, "SecureActionButtonTemplate, UIPanelButtonTemplate")
enchantButton:SetSize(155, 24)
enchantButton:Hide()  -- Hidden until CraftFrame opens
enchantButton:SetText("Enchant")
enchantButton:SetAttribute("type", "macro")
enchantButton:SetAttribute("macrotext", "")
enchantButton:RegisterForClicks("AnyUp", "AnyDown")

--------------------------------------------------------------------------------
-- Utility Functions
--------------------------------------------------------------------------------

local function Print(msg)
    DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00CookieEasyEnchant:|r " .. msg)
end

--------------------------------------------------------------------------------
-- Item Selection
--------------------------------------------------------------------------------

local function ClearItemSelection()
    selectedItem = nil
    if itemButton then
        itemButton.icon:SetTexture(nil)  -- Empty slot, no icon
        itemButton.text:SetText("")
    end
    CookieEasyEnchantDB.selectedItemBag = nil
    CookieEasyEnchantDB.selectedItemSlot = nil
    CookieEasyEnchantDB.selectedItemID = nil
    CookieEasyEnchantDB.selectedItemEquipSlot = nil
    -- Update macros when selection cleared
    C_Timer.After(0, function()
        UpdateEnchantButtonMacro()
        if GetMacroInfo and GetMacroInfo("EasyEnchant") then
            UpdateMacroText()
        end
    end)
end

-- Select item from bag
local function SelectBagItem(bag, slot)
    local itemID = C_Container.GetContainerItemID(bag, slot)
    if not itemID then
        return false
    end

    local info = C_Container.GetContainerItemInfo(bag, slot)
    if not info then
        return false
    end

    -- Use the actual item link from the bag slot (includes random suffix)
    local itemLink = info.hyperlink
    local itemName = C_Item.GetItemInfo(itemLink) or "Item"
    local icon = info.iconFileID

    selectedItem = {
        bag = bag,
        slot = slot,
        equipSlot = nil,
        name = itemName,
        link = itemLink,
        icon = icon,
        itemID = itemID
    }

    -- Update item button appearance
    if itemButton then
        itemButton.icon:SetTexture(icon)
        itemButton.text:SetText(itemName)
    end

    -- Save selection
    CookieEasyEnchantDB.selectedItemBag = bag
    CookieEasyEnchantDB.selectedItemSlot = slot
    CookieEasyEnchantDB.selectedItemID = itemID
    CookieEasyEnchantDB.selectedItemEquipSlot = nil

    -- Update macros when item selected
    C_Timer.After(0, function()
        UpdateEnchantButtonMacro()
        if UpdateMacroText then UpdateMacroText() end
    end)
    return true
end

-- Select equipped item
local function SelectEquippedItem(equipSlot)
    local itemID = GetInventoryItemID("player", equipSlot)
    if not itemID then
        return false
    end

    -- Use the actual item link from the equipment slot (includes random suffix)
    local itemLink = GetInventoryItemLink("player", equipSlot)
    local itemName = C_Item.GetItemInfo(itemLink) or "Item"
    local icon = GetInventoryItemTexture("player", equipSlot)

    selectedItem = {
        bag = nil,
        slot = nil,
        equipSlot = equipSlot,
        name = itemName,
        link = itemLink,
        icon = icon,
        itemID = itemID
    }

    -- Update item button appearance
    if itemButton then
        itemButton.icon:SetTexture(icon)
        itemButton.text:SetText(itemName)
    end

    -- Save selection
    CookieEasyEnchantDB.selectedItemBag = nil
    CookieEasyEnchantDB.selectedItemSlot = nil
    CookieEasyEnchantDB.selectedItemID = itemID
    CookieEasyEnchantDB.selectedItemEquipSlot = equipSlot

    -- Update macros when item selected
    C_Timer.After(0, function()
        UpdateEnchantButtonMacro()
        if UpdateMacroText then UpdateMacroText() end
    end)
    return true
end

local function SelectItemFromCursor()
    local infoType, itemID, itemLink = GetCursorInfo()
    if infoType == "item" then
        -- First check equipped slots (1-19)
        for equipSlot = 1, 19 do
            local equippedItemID = GetInventoryItemID("player", equipSlot)
            if equippedItemID == itemID then
                ClearCursor()
                SelectEquippedItem(equipSlot)
                return true
            end
        end
        -- Then check bags
        for bag = 0, NUM_BAG_SLOTS do
            for slot = 1, C_Container.GetContainerNumSlots(bag) do
                local bagItemID = C_Container.GetContainerItemID(bag, slot)
                if bagItemID == itemID then
                    ClearCursor()
                    SelectBagItem(bag, slot)
                    return true
                end
            end
        end
        ClearCursor()
    end
    return false
end

--------------------------------------------------------------------------------
-- Get Currently Selected Enchant from Blizzard UI
--------------------------------------------------------------------------------

local function GetSelectedEnchantIndex()
    -- GetCraftSelectionIndex() returns the currently selected craft in the UI
    local index = GetCraftSelectionIndex and GetCraftSelectionIndex() or 0
    if index == 0 then
        return nil
    end
    return index
end

local function GetSelectedEnchantName()
    local index = GetSelectedEnchantIndex()
    if not index then return nil end
    local name = GetCraftInfo(index)
    return name
end

--------------------------------------------------------------------------------
-- Validation
--------------------------------------------------------------------------------

local function ValidateEnchantReady()
    local enchantIndex = GetSelectedEnchantIndex()
    if not enchantIndex then
        return false, nil
    end
    if not selectedItem then
        return false, nil
    end
    -- Check that the enchanting window is open (either Blizzard's or Skillet's)
    if IsSkilletActive() then
        if not Skillet.isCraft then
            return false, nil
        end
    elseif not CraftFrame or not CraftFrame:IsShown() then
        return false, nil
    end
    -- Check if item is still in the same location
    local currentItemID
    if selectedItem.equipSlot then
        currentItemID = GetInventoryItemID("player", selectedItem.equipSlot)
    else
        currentItemID = C_Container.GetContainerItemID(selectedItem.bag, selectedItem.slot)
    end
    if currentItemID ~= selectedItem.itemID then
        return false, nil
    end
    return true, enchantIndex
end

--------------------------------------------------------------------------------
-- Secure Button Macro Update
--------------------------------------------------------------------------------

UpdateEnchantButtonMacro = function()
    if not enchantButton then return end

    -- Can't update secure attributes during combat
    if InCombatLockdown() then return end

    local isReady, enchantIndex = ValidateEnchantReady()
    if not isReady then
        enchantButton:SetAttribute("macrotext", "")
        return
    end

    -- Build macro: click craft button, use item, confirm popup
    local useCommand
    if selectedItem.equipSlot then
        -- Equipped item: /use slot (inventory slot number)
        useCommand = string.format("/use %d", selectedItem.equipSlot)
    else
        -- Bag item: /use bag slot
        useCommand = string.format("/use %d %d", selectedItem.bag, selectedItem.slot)
    end

    local macroText = string.format(
        "/click CraftCreateButton\n%s\n/click StaticPopup1Button1",
        useCommand
    )
    enchantButton:SetAttribute("macrotext", macroText)

    -- Debug: print the macro
    -- Print("Macro: " .. macroText:gsub("\n", " | "))
end

--------------------------------------------------------------------------------
-- Collapse/Expand Functions
--------------------------------------------------------------------------------

local function SetPanelCollapsed(collapsed)
    CookieEasyEnchantDB.collapsed = collapsed
    if collapsed then
        if easyEnchantFrame then easyEnchantFrame:Hide() end
        if toggleButton and not IsSkilletActive() then toggleButton:SetText(">") end
    else
        if easyEnchantFrame then easyEnchantFrame:Show() end
        if toggleButton and not IsSkilletActive() then toggleButton:SetText("<") end
    end
end

local function TogglePanel()
    SetPanelCollapsed(not CookieEasyEnchantDB.collapsed)
end

--------------------------------------------------------------------------------
-- Panel Positioning (adapts to Skillet or default CraftFrame)
--------------------------------------------------------------------------------

local function PositionPanelForParent(parentFrame)
    if not toggleButton or not easyEnchantFrame then return end

    toggleButton:SetParent(parentFrame)
    toggleButton:ClearAllPoints()
    easyEnchantFrame:SetParent(parentFrame)
    easyEnchantFrame:ClearAllPoints()

    if parentFrame == SkilletFrame then
        -- Anchor toggle inside the Skillet button row, at the right edge
        toggleButton:SetSize(40, 20)
        toggleButton:SetText("CEE")
        toggleButton:SetPoint("RIGHT", parentFrame, "RIGHT", -10, 0)
        toggleButton:SetPoint("TOP", SkilletIgnoreListButton, "TOP", 0, 0)
        easyEnchantFrame:SetPoint("TOPLEFT", parentFrame, "TOPRIGHT", 0, -32)
    else
        toggleButton:SetSize(24, 22)
        -- Default CraftFrame positioning
        toggleButton:SetPoint("TOPRIGHT", parentFrame, "TOPRIGHT", -35, -50)
        easyEnchantFrame:SetPoint("TOPLEFT", parentFrame, "TOPRIGHT", -40, -32)
    end
end

--------------------------------------------------------------------------------
-- Create the Easy Enchant Panel (attached to craft window)
--------------------------------------------------------------------------------

local function CreateEasyEnchantPanel()
    local parentFrame = GetCraftParentFrame()

    -- If panel already exists, just reparent and reposition
    if easyEnchantFrame then
        PositionPanelForParent(parentFrame)
        return easyEnchantFrame
    end

    -- Toggle tab button
    toggleButton = CreateFrame("Button", "CookieEasyEnchantToggle", parentFrame, "UIPanelButtonTemplate")
    toggleButton:SetSize(24, 22)
    toggleButton:SetFrameStrata("HIGH")
    toggleButton:SetFrameLevel(100)
    toggleButton:SetText("<")
    toggleButton:SetScript("OnClick", TogglePanel)
    toggleButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Easy Enchant")
        GameTooltip:AddLine("Click to toggle panel", 1, 1, 1)
        GameTooltip:Show()
    end)
    toggleButton:SetScript("OnLeave", function() GameTooltip:Hide() end)

    -- Main panel frame
    easyEnchantFrame = CreateFrame("Frame", "CookieEasyEnchantFrame", parentFrame, "BackdropTemplate")
    easyEnchantFrame:SetSize(170, 110)
    easyEnchantFrame:SetFrameStrata("HIGH")

    -- Set initial position based on parent
    PositionPanelForParent(parentFrame)

    -- Dark background like the enchanting window
    easyEnchantFrame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })

    -- Content frame (holds all the UI elements)
    contentFrame = CreateFrame("Frame", nil, easyEnchantFrame)
    contentFrame:SetAllPoints()

    -- Title header
    local title = contentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOP", contentFrame, "TOP", 0, -8)
    title:SetText("Enchant Target")

    -- Item slot frame (the bordered slot area like AH)
    local itemSlotFrame = CreateFrame("Frame", nil, contentFrame, "BackdropTemplate")
    itemSlotFrame:SetSize(155, 46)
    itemSlotFrame:SetPoint("TOP", title, "BOTTOM", 0, -4)
    itemSlotFrame:SetBackdrop({
        bgFile = "Interface\\Buttons\\UI-SlotBackground",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 12,
        insets = { left = 2, right = 2, top = 2, bottom = 2 }
    })
    itemSlotFrame:SetBackdropColor(0.1, 0.1, 0.1, 0.8)

    -- Item button (clickable area inside the slot)
    itemButton = CreateFrame("Button", "CookieEasyEnchantItemButton", itemSlotFrame)
    itemButton:SetAllPoints()

    -- Empty slot background texture (like bag slots)
    itemButton.slotBg = itemButton:CreateTexture(nil, "BACKGROUND")
    itemButton.slotBg:SetSize(36, 36)
    itemButton.slotBg:SetPoint("LEFT", itemButton, "LEFT", 5, 0)
    itemButton.slotBg:SetTexture("Interface\\PaperDollInfoFrame\\UI-Backpack-EmptySlot")

    -- Item icon (overlays the slot background when item is selected)
    itemButton.icon = itemButton:CreateTexture(nil, "ARTWORK")
    itemButton.icon:SetSize(34, 34)
    itemButton.icon:SetPoint("CENTER", itemButton.slotBg, "CENTER", 0, 0)

    -- Item name text (to the right of icon)
    itemButton.text = itemButton:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    itemButton.text:SetPoint("LEFT", itemButton.slotBg, "RIGHT", 6, 0)
    itemButton.text:SetPoint("RIGHT", itemButton, "RIGHT", -4, 0)
    itemButton.text:SetJustifyH("LEFT")
    itemButton.text:SetText("")

    -- Highlight on hover
    itemButton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")

    -- Drag-and-drop and right-click
    itemButton:RegisterForClicks("LeftButtonUp", "RightButtonUp")

    itemButton:SetScript("OnClick", function(self, button)
        if button == "RightButton" then
            ClearItemSelection()
        elseif button == "LeftButton" then
            local cursorType = GetCursorInfo()
            if cursorType == "item" then
                SelectItemFromCursor()
            end
        end
    end)

    itemButton:SetScript("OnReceiveDrag", function(self)
        SelectItemFromCursor()
    end)

    itemButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        if selectedItem and selectedItem.link then
            GameTooltip:SetHyperlink(selectedItem.link)
        else
            GameTooltip:SetText("Drag an item here\nRight-click to clear")
        end
        GameTooltip:Show()
    end)

    itemButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- Enchant button - reparent the pre-created secure button
    -- Note: SecureActionButtons can only anchor to their parent frame, not child regions
    enchantButton:SetParent(contentFrame)
    enchantButton:ClearAllPoints()
    enchantButton:SetPoint("TOP", contentFrame, "TOP", 0, -74)
    enchantButton:Show()

    enchantButton:SetScript("PreClick", function(self, mouseButton)
        UpdateEnchantButtonMacro()
    end)

    -- Make the button available for WoW's click binding system
    -- Users can type: /run SetBindingClick("KEY", "CookieEasyEnchantButton")
    -- Or use: /run SetBindingClick("NUMPAD1", "CookieEasyEnchantButton"); SaveBindings(2)
    ClearOverrideBindings(enchantButton)

    -- Restore collapsed state
    if CookieEasyEnchantDB.collapsed then
        SetPanelCollapsed(true)
    end

    return easyEnchantFrame
end

--------------------------------------------------------------------------------
-- Auto-confirm "Replace Enchant" Popup
--------------------------------------------------------------------------------

local function SetupAutoConfirm()
    -- Note: We do NOT auto-confirm REPLACE_ENCHANT because ReplaceEnchant()
    -- is a protected function that requires a hardware click event.
    -- The user must manually click "Accept" on the replace enchant dialog.

    -- Hook SelectCraft to update macro when user selects a different enchant
    if SelectCraft then
        hooksecurefunc("SelectCraft", function(index)
            C_Timer.After(0, function()
                UpdateEnchantButtonMacro()
                if UpdateMacroText then UpdateMacroText() end
            end)
        end)
    end
end

--------------------------------------------------------------------------------
-- Event Handling
--------------------------------------------------------------------------------

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("CRAFT_SHOW")
eventFrame:RegisterEvent("CRAFT_CLOSE")
eventFrame:RegisterEvent("CRAFT_UPDATE")
eventFrame:RegisterEvent("BAG_UPDATE")
eventFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")

eventFrame:SetScript("OnEvent", function(self, event, arg1, ...)
    if event == "ADDON_LOADED" and arg1 == addonName then
        CookieEasyEnchantDB = CookieEasyEnchantDB or {}
        CookieEasyEnchantDB.deFilterUncommon = CookieEasyEnchantDB.deFilterUncommon ~= false  -- default true
        CookieEasyEnchantDB.deFilterRare = CookieEasyEnchantDB.deFilterRare ~= false          -- default true
        CookieEasyEnchantDB.deFilterEpic = CookieEasyEnchantDB.deFilterEpic ~= false          -- default true
        CookieEasyEnchantDB.ignoredItems = CookieEasyEnchantDB.ignoredItems or {}
        SetupAutoConfirm()
        Print("Loaded! Panel appears when you open Enchanting.")

    elseif event == "CRAFT_SHOW" then
        -- CraftFrame is now available, create our panel
        -- Skillet needs a longer delay to finish setting up SkilletFrame
        local delay = Skillet and 0.3 or 0.1
        C_Timer.After(delay, function()
            CreateEasyEnchantPanel()

            -- Restore item selection if valid
            local savedItemID = CookieEasyEnchantDB.selectedItemID
            if savedItemID then
                if CookieEasyEnchantDB.selectedItemEquipSlot then
                    -- Restore equipped item
                    local equipSlot = CookieEasyEnchantDB.selectedItemEquipSlot
                    local currentItemID = GetInventoryItemID("player", equipSlot)
                    if currentItemID == savedItemID then
                        SelectEquippedItem(equipSlot)
                    else
                        ClearItemSelection()
                    end
                elseif CookieEasyEnchantDB.selectedItemBag and CookieEasyEnchantDB.selectedItemSlot then
                    -- Restore bag item
                    local bag = CookieEasyEnchantDB.selectedItemBag
                    local slot = CookieEasyEnchantDB.selectedItemSlot
                    local currentItemID = C_Container.GetContainerItemID(bag, slot)
                    if currentItemID == savedItemID then
                        SelectBagItem(bag, slot)
                    else
                        ClearItemSelection()
                    end
                end
            end
        end)

    elseif event == "CRAFT_CLOSE" then
        -- Panel hides automatically since it's parented to CraftFrame

    elseif event == "CRAFT_UPDATE" then
        -- Update macros when craft selection might have changed
        UpdateEnchantButtonMacro()
        if UpdateMacroText then UpdateMacroText() end

    elseif event == "BAG_UPDATE" then
        -- Track bag items that move around or get equipped
        if selectedItem and selectedItem.bag then
            local currentItemID = C_Container.GetContainerItemID(selectedItem.bag, selectedItem.slot)
            if currentItemID ~= selectedItem.itemID then
                -- Item moved - first check if it was equipped
                local found = false
                for equipSlot = 1, 19 do
                    if GetInventoryItemID("player", equipSlot) == selectedItem.itemID then
                        SelectEquippedItem(equipSlot)
                        found = true
                        break
                    end
                end
                -- If not equipped, try to find it in a new bag location
                if not found then
                    for bag = 0, NUM_BAG_SLOTS do
                        for slot = 1, C_Container.GetContainerNumSlots(bag) do
                            if C_Container.GetContainerItemID(bag, slot) == selectedItem.itemID then
                                SelectBagItem(bag, slot)
                                found = true
                                break
                            end
                        end
                        if found then break end
                    end
                end
                if not found then
                    ClearItemSelection()
                end
            end
        end

    elseif event == "PLAYER_EQUIPMENT_CHANGED" then
        -- Track equipped items being unequipped
        local equipSlot = arg1
        if selectedItem and selectedItem.equipSlot == equipSlot then
            -- Our selected equipped item was changed
            local currentItemID = GetInventoryItemID("player", equipSlot)
            if currentItemID ~= selectedItem.itemID then
                -- Item was unequipped, try to find it in bags
                local found = false
                for bag = 0, NUM_BAG_SLOTS do
                    for slot = 1, C_Container.GetContainerNumSlots(bag) do
                        if C_Container.GetContainerItemID(bag, slot) == selectedItem.itemID then
                            SelectBagItem(bag, slot)
                            found = true
                            break
                        end
                    end
                    if found then break end
                end
                if not found then
                    ClearItemSelection()
                end
            end
        end
    end
end)

--------------------------------------------------------------------------------
-- Macro Creation (like TSM approach)
--------------------------------------------------------------------------------

local MACRO_NAME = "EasyEnchant"
local MACRO_ICON = "INV_Enchant_Disenchant"

-- Update the macro with current enchant/item selection
UpdateMacroText = function()
    -- Only update if macro exists
    if not GetMacroInfo(MACRO_NAME) then return end
    if InCombatLockdown() then return end

    local isReady, enchantIndex = ValidateEnchantReady()
    if not isReady or not selectedItem then
        -- Set macro to print warning when used
        EditMacro(MACRO_NAME, MACRO_NAME, MACRO_ICON, "/run print(\"|cffff0000CookieEasyEnchant:|r Select an enchant and item first!\")")
        return
    end

    -- Build the use command based on item location
    local useCommand
    if selectedItem.equipSlot then
        useCommand = string.format("/use %d", selectedItem.equipSlot)
    else
        useCommand = string.format("/use %d %d", selectedItem.bag, selectedItem.slot)
    end

    -- Macro: click craft button, use item, confirm popup
    local macroText = string.format(
        "/click CraftCreateButton\n%s\n/click StaticPopup1Button1",
        useCommand
    )

    EditMacro(MACRO_NAME, MACRO_NAME, MACRO_ICON, macroText)
end

local function CreateOrUpdateMacro()
    if InCombatLockdown() then
        Print("Cannot create macro while in combat.")
        return
    end

    if GetMacroInfo(MACRO_NAME) then
        -- Update existing macro
        UpdateMacroText()
        Print("Macro 'EasyEnchant' updated!")
    else
        -- Check if we have room for a new macro
        local numAccountMacros, numCharacterMacros = GetNumMacros()
        if numAccountMacros >= MAX_ACCOUNT_MACROS then
            Print("Cannot create macro - you have too many account macros. Delete one and try again.")
            return
        end
        -- Create new macro with placeholder that warns user
        CreateMacro(MACRO_NAME, MACRO_ICON, "/run print(\"|cffff0000CookieEasyEnchant:|r Select an enchant and item first!\")")
        Print("Macro 'EasyEnchant' created!")
        -- Update with current selection if any
        UpdateMacroText()
    end

    Print("Drag the macro to your action bar and bind a key to that slot.")
end

--------------------------------------------------------------------------------
-- Slash Commands
--------------------------------------------------------------------------------

SLASH_COOKIEENCHANT1 = "/cee"
SLASH_COOKIEENCHANT2 = "/cookieenchant"

SlashCmdList["COOKIEENCHANT"] = function(msg)
    local cmd = string.lower(msg or "")
    if cmd == "macro" then
        CreateOrUpdateMacro()
    elseif cmd == "de" or cmd == "disenchant" then
        CookieEasyEnchant_ToggleDisenchant()
    elseif cmd == "unignore" then
        CookieEasyEnchant_ClearIgnoreList()
    elseif cmd == "help" then
        Print("Open Enchanting to use Easy Enchant!")
        Print("  1. Select an enchant in the list")
        Print("  2. Drag an item to the Easy Enchant panel")
        Print("  3. Spam-click the Enchant button!")
        Print("Type /cee macro to create a keybindable macro.")
        Print("Type /cee de to open the Disenchant window.")
        Print("Type /cee unignore to clear permanently ignored items.")
    else
        -- Open enchanting window (Skillet will intercept if installed)
        CastSpellByName("Enchanting")
    end
end

function CookieEasyEnchant_Toggle()
    if IsSkilletActive() or (CraftFrame and CraftFrame:IsShown()) then
        TogglePanel()
    end
end
