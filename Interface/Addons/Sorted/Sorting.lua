local draggingIndex = nil

local function GetSortArrow(ascending)
    local s = "|TInterface\\Addons\\Sorted\\Textures\\Sort-Arrow"
    if Sorted_GetSetting("fontOutline") > 0 then
        s = s.."-Outline"
        if Sorted_GetSetting("fontOutline") > 1 then
            s = s..":0:0:-5"
        else
            s = s..":0:0:-2"
        end
    else
        s = s..":0:0:-1"
    end
    if ascending then
        s = s..":-1:16:16:0:16:0:16|t"
    else
        s = s..":0:16:16:0:16:16:0|t"
    end
    return s
end

-- Sort functions
local function SortByName(slot1, slot2) return slot1.name < slot2.name end
local function SortByQuantity(slot1, slot2) return slot1.count < slot2.count end
local function SortByLevel(slot1, slot2) if not slot1.effectiveILvl then return false elseif not slot2.effectiveILvl then return true end return slot1.effectiveILvl > slot2.effectiveILvl end
local function SortByValue(slot1, slot2) return slot1.value * slot1.count < slot2.value * slot2.count end
local function SortByRarity(slot1, slot2) return slot1.quality > slot2.quality end
local function SortByNameThenQuantity(slot1, slot2)
    if slot1.name == slot2.name then
        if slot1.count == slot2.count then
            return slot1.bag * 36 + slot1.slot < slot2.bag * 36 + slot2.slot
        end
        return SortByQuantity(slot2, slot1)
    end
    return SortByName(slot1, slot2)
end
local function SortByRarityThenLevel(slot1, slot2)
    if slot1.quality == slot2.quality then
        if slot1.effectiveILvl == slot2.effectiveILvl then
            return SortByNameThenQuantity(slot1, slot2)
        end
        return SortByLevel(slot1, slot2)
    else
        return SortByRarity(slot1, slot2)
    end
end
local function SortByLevelThenRarity(slot1, slot2)
    if slot1.effectiveILvl == slot2.effectiveILvl then
        if slot1.quality == slot2.quality then
            return SortByNameThenQuantity(slot1, slot2)
        end
        return SortByRarity(slot1, slot2)
    else
        return SortByLevel(slot1, slot2)
    end
end

local function Sorted_SlotSort(slot1, slot2)
    if not slot1 then return false
    elseif not slot2 then return true end
    if slot1.empty then return false
    elseif slot2.empty then return true end
    if slot1.filtered and not slot2.filtered then return false
    elseif slot2.filtered and not slot1.filtered then return true end
    if not slot1.itemID then return false
    elseif not slot2.itemID then return true end

    if Sorted_GetSetting("favoritesOnTop") == 2 then
        local slot1Fav, slot2Fav = Sorted_GetFavorited(slot1), Sorted_GetFavorited(slot2)
        if slot1Fav ~= slot2Fav then
            if slot1Fav == nil then return false
            elseif slot2Fav == nil then return true
            else return slot1Fav < slot2Fav end
        end
    end

    local sortButton = Sorted_GetSortButton(Sorted_selectedSort)

    if Sorted_sortVariant < 3 or #sortButton.sortMethods == 1 then
        if Sorted_sortVariant % 2 == 1 then
            return sortButton.sortMethods[1].func(slot1, slot2)
        else
            return sortButton.sortMethods[1].func(slot2, slot1)
        end
    else
        if Sorted_sortVariant % 2 == 1 then
            return sortButton.sortMethods[2].func(slot1, slot2)
        else
            return sortButton.sortMethods[2].func(slot2, slot1)
        end
    end
end

function SortedItemList_SortItems(self)
    table.sort(self.itemButtons, Sorted_SlotSort)
end


-- SORT BUTTONS

-- These refer to the uniqueID of the sort buttons in Sorted_sortButtons
SORTED_SORTBUTTON_FAVORITES = 1
SORTED_SORTBUTTON_QUANTITY = 2
SORTED_SORTBUTTON_NAME = 3
SORTED_SORTBUTTON_REQUIRED_LEVEL = 8
SORTED_SORTBUTTON_LEVEL = 4
SORTED_SORTBUTTON_ADDED = 6
SORTED_SORTBUTTON_TYPE = 9
SORTED_SORTBUTTON_EXPANSION = 10
SORTED_SORTBUTTON_BIND = 7
SORTED_SORTBUTTON_VALUE = 5
SORTED_SORTBUTTON_TRANSMOG = 11
SORTED_SORTBUTTON_ICON = 12

-- Saved between sessions. Uses unique IDs
Sorted_enabledColumns = {
    [SORTED_SORTBUTTON_FAVORITES] = true,
    [SORTED_SORTBUTTON_QUANTITY] = true,
    [SORTED_SORTBUTTON_ICON] = true,
    [SORTED_SORTBUTTON_NAME] = true,
    [SORTED_SORTBUTTON_REQUIRED_LEVEL] = false,
    [SORTED_SORTBUTTON_LEVEL] = true,
    [SORTED_SORTBUTTON_ADDED] = false,
    [SORTED_SORTBUTTON_TYPE] = false,
    [SORTED_SORTBUTTON_EXPANSION] = false,
    [SORTED_SORTBUTTON_BIND] = false,
    [SORTED_SORTBUTTON_VALUE] = true,
    [SORTED_SORTBUTTON_TRANSMOG] = false,
}

Sorted_sortButtonOrder = {
    [SORTED_SORTBUTTON_FAVORITES] = 1,
    [SORTED_SORTBUTTON_QUANTITY] = 2,
    [SORTED_SORTBUTTON_ICON] = 3,
    [SORTED_SORTBUTTON_NAME] = 4,
    [SORTED_SORTBUTTON_REQUIRED_LEVEL] = 5,
    [SORTED_SORTBUTTON_LEVEL] = 6,
    [SORTED_SORTBUTTON_ADDED] = 7,
    [SORTED_SORTBUTTON_TYPE] = 8,
    [SORTED_SORTBUTTON_EXPANSION] = 9,
    [SORTED_SORTBUTTON_BIND] = 10,
    [SORTED_SORTBUTTON_VALUE] = 11,
    [SORTED_SORTBUTTON_TRANSMOG] = 12,
}

-- Ordered left to right
Sorted_sortButtons = {
    {
        ["name"] = Sorted.Localize("COLUMN_FAVORITES"),
        ["Enabled"] = function(self) return true end,
        ["button"] = SortedFrameFavoritesSortButton,
        ["width"] = 20,
        ["itemButtonKeys"] = {"favoriteButton"},
        ["align"] = "CENTER",
        ["uniqueID"] = SORTED_SORTBUTTON_FAVORITES -- This will never change in the future, even if other sortButtons are added.
    },
    {
        ["name"] = Sorted.Localize("COLUMN_QUANTITY"),
        ["Enabled"] = function(self) return true end,
        ["button"] = SortedFrameQuantitySortButton,
        ["width"] = 42,
        ["sortMethods"] = {
            {
                ["title"] = "#",
                ["func"] = function(slot1, slot2)
                    if slot1.count == slot2.count then
                        return SortByRarityThenLevel(slot1, slot2)
                    end
                    return SortByQuantity(slot2, slot1)
                end
            }
        },
        ["align"] = "RIGHT",
        ["itemButtonKeys"] = {"quantityString"},
        ["uniqueID"] = SORTED_SORTBUTTON_QUANTITY
    },
    {
        ["name"] = Sorted.Localize("COLUMN_ICON"),
        ["dontDrawColumnSeparators"] = true,
        ["Enabled"] = function(self) return true end,
        ["button"] = SortedFrameNameSortButton,
        ["width"] = 24,
        ["sortMethods"] = {
            {
                ["title"] = "",
                ["func"] = function(slot1, slot2) 
                    return SortByRarityThenLevel(slot1, slot2)
                end
            }
        },
        ["align"] = "CENTER",
        ["itemButtonKeys"] = {"iconFrame"},
        ["uniqueID"] = SORTED_SORTBUTTON_ICON
    },
    {
        ["name"] = Sorted.Localize("COLUMN_NAME"),
        ["Enabled"] = function(self) return true end,
        ["button"] = SortedFrameNameSortButton,
        ["width"] = 128,
        ["sortMethods"] = {
            {
                ["title"] = Sorted.Localize("COLUMN_RARITY_SHORT"),
                ["func"] = function(slot1, slot2) 
                    return SortByRarityThenLevel(slot1, slot2)
                end
            },
            {
                ["title"] = Sorted.Localize("COLUMN_NAME_SHORT"),
                ["func"] = function(slot1, slot2) 
                    return SortByNameThenQuantity(slot1, slot2)
                end,
                ["inverse"] = true
            }
        },
        ["align"] = "LEFT",
        ["itemButtonKeys"] = {"nameString"},
        ["uniqueID"] = SORTED_SORTBUTTON_NAME
    },
    {
        ["name"] = Sorted.Localize("COLUMN_REQUIRED_LEVEL"),
        ["Enabled"] = function(self) return true end,
        ["button"] = SortedFrameReqLevelSortButton,
        ["width"] = 46,
        ["sortMethods"] = {
            {
                ["title"] = Sorted.Localize("COLUMN_REQUIRED_LEVEL_SHORT"),
                ["func"] = function(slot1, slot2)
                    if slot1.minLevel == slot2.minLevel or (slot1.minLevel < 2 and slot2.minLevel < 2) then
                        return SortByRarityThenLevel(slot1, slot2)
                    end
                    return slot1.minLevel > slot2.minLevel
                end
            }
        },
        ["align"] = "LEFT",
        ["itemButtonKeys"] = {"minLevelString"},
        ["uniqueID"] = SORTED_SORTBUTTON_REQUIRED_LEVEL
    },
    {
        ["name"] = Sorted.Localize("COLUMN_ITEM_LEVEL"),
        ["Enabled"] = function(self) return true end,
        ["button"] = SortedFrameLevelSortButton,
        ["width"] = 46,
        ["sortMethods"] = {
            {
                ["title"] = Sorted.Localize("COLUMN_ITEM_LEVEL_SHORT"),
                ["func"] = function(slot1, slot2) 
                    return SortByLevelThenRarity(slot1, slot2)
                end
            }
        },
        ["align"] = "LEFT",
        ["itemButtonKeys"] = {"levelString"},
        ["uniqueID"] = SORTED_SORTBUTTON_LEVEL
    },
    {
        ["name"] = Sorted.Localize("COLUMN_TIME_ADDED"),
        ["Enabled"] = function(self) return true end,
        ["button"] = SortedFrameAddedSortButton,
        ["width"] = 64,
        ["sortMethods"] = {
            {
                ["title"] = Sorted.Localize("COLUMN_TIME_ADDED_SHORT"),
                ["func"] = function(slot1, slot2)
                    if not slot1.timeAdded then return false end
                    if not slot2.timeAdded then return true end
                    if slot1.timeAdded == slot2.timeAdded then
                        return SortByNameThenQuantity(slot1, slot2)
                    end
                    return slot1.timeAdded > slot2.timeAdded
                end
            }
        },
        ["align"] = "RIGHT",
        ["itemButtonKeys"] = {"timeAddedString"},
        ["uniqueID"] = SORTED_SORTBUTTON_ADDED
    },
    {
        ["name"] = Sorted.Localize("COLUMN_TYPE"),
        ["Enabled"] = function(self) return true end,
        ["button"] = SortedFrameTypeSortButton,
        ["width"] = 80,
        ["sortMethods"] = {
            {
                ["title"] = Sorted.Localize("COLUMN_TYPE_SHORT"),
                ["func"] = function(slot1, slot2)
                    if slot1.classID == slot2.classID then
                        return SortByRarityThenLevel(slot1, slot2)
                    end
                    if not slot1.classID then return false end
                    if not slot2.classID then return true end
                    return GetItemClassInfo(slot1.classID) < GetItemClassInfo(slot2.classID)
                end
            }
        },
        ["align"] = "LEFT",
        ["itemButtonKeys"] = {"typeString"},
        ["uniqueID"] = SORTED_SORTBUTTON_TYPE
    },
    {
        ["name"] = Sorted.Localize("COLUMN_EXPANSION"),
        ["Enabled"] = function(self) return not Sorted_IsClassic() end,
        ["button"] = SortedFrameExpacSortButton,
        ["width"] = 64,
        ["sortMethods"] = {
            {
                ["title"] = Sorted.Localize("COLUMN_EXPANSION_SHORT"),
                ["func"] = function(slot1, slot2)
                    if slot1.expacID == slot2.expacID then
                        return SortByRarityThenLevel(slot1, slot2)
                    end
                    if not slot1.expacID then return false end
                    if not slot2.expacID then return true end
                    return slot1.expacID > slot2.expacID
                end
            }
        },
        ["align"] = "CENTER",
        ["itemButtonKeys"] = {"expacString"},
        ["uniqueID"] = SORTED_SORTBUTTON_EXPANSION
    },
    {
        ["name"] = Sorted.Localize("COLUMN_BINDING"),
        ["Enabled"] = function(self) return true end,
        ["button"] = SortedFrameBindSortButton,
        ["width"] = 56,
        ["sortMethods"] = {
            {
                ["title"] = Sorted.Localize("COLUMN_BINDING_SHORT"),
                ["func"] = function(slot1, slot2)
                    if slot1.bindType == slot2.bindType and slot1.bound == slot2.bound then
                        return SortByRarityThenLevel(slot1, slot2)
                    end
                    if slot1.bindType == 0 then return false end
                    if slot2.bindType == 0 then return true end
                    if slot2.bound and not slot1.bound then return true end
                    if slot1.bound and not slot2.bound then return false end
                    return slot1.bindType > slot2.bindType
                end
            }
        },
        ["align"] = "RIGHT",
        ["itemButtonKeys"] = {"bindString"},
        ["uniqueID"] = SORTED_SORTBUTTON_BIND
    },
    {
        ["name"] = Sorted.Localize("COLUMN_SELL_PRICE"),
        ["Enabled"] = function(self) return true end,
        ["button"] = SortedFrameValueSortButton,
        ["width"] = 56,
        ["sortMethods"] = {
            {
                ["title"] = Sorted.Localize("COLUMN_SELL_PRICE_SHORT"),
                ["func"] = function(slot1, slot2) 
                    if slot1.hasNoValue and slot2.hasNoValue then
                        return SortByRarityThenLevel(slot1, slot2)
                    end
                    if slot1.hasNoValue then return false end
                    if slot2.hasNoValue then return true end
                    if slot1.value * slot1.count == slot2.value * slot2.count then
                        return SortByNameThenQuantity(slot1, slot2)
                    end
                    return slot1.value * slot1.count > slot2.value * slot2.count
                end
            }
        },
        ["align"] = "RIGHT",
        ["itemButtonKeys"] = {"valueString"},
        ["uniqueID"] = SORTED_SORTBUTTON_VALUE
    },
    {
        ["name"] = "Can I Mog It?",
        ["Enabled"] = function(self) return CanIMogIt end,
        ["button"] = SortedFrameTransmogSortButton,
        ["width"] = 28,
        ["sortMethods"] = {
            {
                ["title"] = "|TInterface\\MINIMAP\\TRACKING\\Transmogrifier:0:0|t",
                ["func"] = function(slot1, slot2)
                    if slot1.transmogValue == slot2.transmogValue then
                        return SortByRarityThenLevel(slot1, slot2)
                    end
                    if not slot1.transmogValue or slot1.transmogValue == "" then 
                        return false
                    elseif not slot2.transmogValue or slot2.transmogValue == "" then 
                        return true
                    else
                        return slot1.transmogValue < slot2.transmogValue
                    end
                end
            }
        },
        ["align"] = "CENTER",
        ["itemButtonKeys"] = {"transmogString"},
        ["uniqueID"] = SORTED_SORTBUTTON_TRANSMOG
    }
}
SORTED_DEFAULT_SORT = 3

function Sorted_GetSortButton(uniqueID)
    for k,v in pairs(Sorted_sortButtons) do
        if v.uniqueID == uniqueID then
            return v
        end
    end
end

function SortedSortButtons_GetTotalWidth()
    local width = 0
    for k,v in pairs(Sorted_sortButtons) do
        if v:Enabled() and Sorted_enabledColumns[v.uniqueID] then
            width = width + v.width
        end
    end
    return width
end

function Sorted_UpdateSortButtons()
    -- Left sortButtons
    local leftPosX, rightPosX = 0, 0
    local nameColumnIndex = 0
    local lastButtonIndex = 0
    for i, v in ipairs(Sorted_sortButtons) do
        nameColumnIndex = i
        if v:Enabled() then
            if Sorted_enabledColumns[v.uniqueID] then
                if v.uniqueID == SORTED_SORTBUTTON_NAME then
                    break -- Stop at item name column
                end
                if v.uniqueID == SORTED_SORTBUTTON_ICON and lastButtonIndex == 0 then
                    leftPosX = 6 -- Provide space to the left if the first column is icon
                end
                if v.dontDrawColumnSeparators then
                    if lastButtonIndex > 0 and Sorted_sortButtons[lastButtonIndex].columnSeparators then
                        for k,colSep in pairs(Sorted_sortButtons[lastButtonIndex].columnSeparators) do   
                            colSep:SetPoint("LEFT", -100, 0)
                        end
                    end
                end
                if i > lastButtonIndex then lastButtonIndex = i end
                v.button:SetPoint("LEFT", leftPosX, 0)
                v.button:SetPoint("RIGHT", v.button:GetParent(), "LEFT", leftPosX + v.width, 0)
                if v.itemButtonKeys then
                    for _,itemList in pairs(Sorted_itemLists) do
                        for _,slot in pairs(itemList.itemButtons) do
                            for _,itemButtonKey in pairs(v.itemButtonKeys) do
                                if v.align == "LEFT" then
                                    slot[itemButtonKey]:SetPoint("LEFT", slot, "LEFT", 4 + leftPosX, 0)
                                    slot[itemButtonKey]:SetWidth(v.width - 4)
                                elseif v.align == "RIGHT" then
                                    slot[itemButtonKey]:SetPoint("RIGHT", slot, "LEFT", -6 + leftPosX + v.width, 0)
                                    slot[itemButtonKey]:SetWidth(v.width - 4)
                                elseif v.align == "CENTER" then
                                    slot[itemButtonKey]:SetPoint("CENTER", slot, "LEFT", leftPosX + v.width / 2, 0)
                                end
                                if slot[itemButtonKey].SetFrameLevel then
                                    slot[itemButtonKey]:SetFrameLevel(580)
                                end
                            end
                        end
                    end
                end
                leftPosX = leftPosX + v.width
                if v.columnSeparators then
                    for k,colSep in pairs(v.columnSeparators) do   
                        colSep:SetPoint("LEFT", leftPosX - 2, 0)
                    end
                end
            end
        end
    end
    -- Right sortButtons
    local dontDrawColumnSeparators = false
    for i = #Sorted_sortButtons, nameColumnIndex + 1, -1 do
        local v = Sorted_sortButtons[i]
        if v:Enabled() then
            if Sorted_enabledColumns[v.uniqueID] then
                if i > lastButtonIndex then lastButtonIndex = i end
                v.button:SetPoint("LEFT", v.button:GetParent(), "RIGHT", rightPosX - 4 - v.width, 0)
                v.button:SetPoint("RIGHT", rightPosX - 4, 0)
                if v.itemButtonKeys then
                    for _,itemList in pairs(Sorted_itemLists) do
                        for _,slot in pairs(itemList.itemButtons) do
                            for _,itemButtonKey in pairs(v.itemButtonKeys) do
                                if v.align == "LEFT" then
                                    slot[itemButtonKey]:SetPoint("LEFT", slot, "RIGHT", 4 + rightPosX - v.width, 0)
                                    slot[itemButtonKey]:SetWidth(v.width - 4)
                                elseif v.align == "RIGHT" then
                                    slot[itemButtonKey]:SetPoint("RIGHT", slot, "RIGHT", -6 + rightPosX, 0)
                                    slot[itemButtonKey]:SetWidth(v.width - 4)
                                elseif v.align == "CENTER" then
                                    slot[itemButtonKey]:SetPoint("CENTER", slot, "RIGHT", rightPosX - v.width / 2, 0)
                                end
                                if slot[itemButtonKey].SetFrameLevel then
                                    slot[itemButtonKey]:SetFrameLevel(580)
                                end
                            end
                        end
                    end
                end
                if v.columnSeparators then
                    if dontDrawColumnSeparators then
                        for k,colSep in pairs(v.columnSeparators) do
                            colSep:SetPoint("LEFT", -100, 0)
                        end
                    else
                        for k,colSep in pairs(v.columnSeparators) do
                            if rightPosX == 0 then
                                colSep:SetPoint("LEFT", colSep.relScrollBar, "LEFT", rightPosX - 5, 0)
                            else
                                colSep:SetPoint("LEFT", colSep.relScrollBar, "LEFT", rightPosX - 4, 0)
                            end
                        end
                    end
                end
                if v.dontDrawColumnSeparators then
                    dontDrawColumnSeparators = true
                else
                    dontDrawColumnSeparators = false
                end
                rightPosX = rightPosX - v.width
            end
        end
    end
    -- Fill remaining space with the last button
    if Sorted_enabledColumns[SORTED_SORTBUTTON_NAME] then
        local sortButton = Sorted_GetSortButton(SORTED_SORTBUTTON_NAME)
        sortButton.button:SetPoint("LEFT", leftPosX, 0)
        sortButton.button:SetPoint("RIGHT", rightPosX - 4, 0)
        for k,itemList in pairs(Sorted_itemLists) do
            for l,slot in pairs(itemList.itemButtons) do
                --[[if leftPosX == 0 then
                    slot.iconFrame:SetPoint("LEFT", slot, "LEFT", 6, 0)
                else
                    slot.iconFrame:SetPoint("LEFT", slot, "LEFT", 2 + leftPosX, 0)
                end]]
                slot.nameFrame:SetPoint("LEFT", leftPosX + 4, 0)
                slot.nameFrame.leftX = leftPosX + 4
                slot.nameFrame:SetPoint("RIGHT", rightPosX - 9, 0)
                slot.nameFrame.rightX = rightPosX - 9
            end
        end
        if sortButton.columnSeparators then
            if dontDrawColumnSeparators then
                for k,colSep in pairs(sortButton.columnSeparators) do
                    colSep:SetPoint("LEFT", -100, 0)
                end
            else
                for k,colSep in pairs(sortButton.columnSeparators) do
                    colSep:SetPoint("LEFT", colSep.relScrollBar, "LEFT", rightPosX - 4, 0)
                end
            end
        end
    else
        local v = Sorted_sortButtons[lastButtonIndex]
        v.button:SetPoint("RIGHT")
        if v.itemButtonKeys then
            for _,itemList in pairs(Sorted_itemLists) do
                for _,slot in pairs(itemList.itemButtons) do
                    for _,itemButtonKey in pairs(v.itemButtonKeys) do
                        if v.align == "LEFT" then
                            slot[itemButtonKey]:SetWidth(200)
                        elseif v.align == "RIGHT" then
                            slot[itemButtonKey]:SetPoint("RIGHT", -4, 0)
                        end
                    end
                end
            end
        end
        if v.columnSeparators then
            for k,colSep in pairs(v.columnSeparators) do   
                colSep:SetPoint("LEFT", colSep:GetParent(), "RIGHT", - 2, 0)
            end
        end
    end

    SortedFrame_UpdateMinSize()
end

function Sorted_EnableSortButton(id)
    local button = Sorted_GetSortButton(id)
    button.button:Show()
    if button.columnSeparators then
        for k,v in pairs(button.columnSeparators) do   
            v:Show()
        end
    end
    if button.itemButtonKeys then
        for _,itemList in pairs(Sorted_itemLists) do
            for _,slot in pairs(itemList.itemButtons) do
                for _,itemButtonKey in pairs(button.itemButtonKeys) do
                    slot[itemButtonKey]:Show()
                    if slot[itemButtonKey].SetFrameLevel then
                        slot[itemButtonKey]:SetFrameLevel(580)
                    end
                end
            end
        end
    end
    Sorted_enabledColumns[id] = true
    Sorted_UpdateSortButtons()
    Sorted_UpdateTimeItemsAdded()
    Sorted_UpdateItemButtons()
    Sorted_FilterItems()
end
function Sorted_DisableSortButton(id)
    if Sorted_selectedSort == id then
        Sorted_selectedSort = SORTED_DEFAULT_SORT
        Sorted_sortVariant = 1
        Sorted_GetSortButton(SORTED_DEFAULT_SORT).button.text:SetText("Rarity")
        Sorted_SortItems()
    end
    local button = Sorted_GetSortButton(id)
    if button.columnSeparators then
        for k,v in pairs(button.columnSeparators) do
            v:Hide()
        end
    end
    if button.itemButtonKeys then
        for _,itemList in pairs(Sorted_itemLists) do
            for _,slot in pairs(itemList.itemButtons) do
                for _,itemButtonKey in pairs(button.itemButtonKeys) do
                    slot[itemButtonKey]:Hide()
                end
            end
        end
    end
    if button.uniqueID == SORTED_SORTBUTTON_LEVEL then
        for _,itemList in pairs(Sorted_itemLists) do
            for _,slot in pairs(itemList.itemButtons) do
                if slot.UpgradeIcon then
                    slot.UpgradeIcon:Hide()
                end
            end
        end
    end
    button.button:Hide()
    Sorted_enabledColumns[id] = false
    Sorted_UpdateSortButtons()
    Sorted_UpdateItemButtons()
    Sorted_FilterItems()
end
function Sorted_ToggleSortButton(id)
    if Sorted_enabledColumns[id] then
        Sorted_DisableSortButton(id)
    else
        Sorted_EnableSortButton(id)
    end
end

function SortedSortButton_OnClick(self, button)
    PlaySound(SOUNDKIT.IG_CHAT_SCROLL_UP)
    if SortedFrameTabsMenu:IsShown() then
        SortedFrameTabsMenu:Hide()
    else
        if button == "LeftButton" then
            local sortButton = Sorted_GetSortButton(self:GetID())
            if sortButton.sortMethods then
                if Sorted_selectedSort == self:GetID() then
                    Sorted_sortVariant = Sorted_sortVariant + 1
                    if Sorted_sortVariant > #sortButton.sortMethods * 2 then 
                        Sorted_sortVariant = 1 
                    end
                else
                    Sorted_selectedSort = self:GetID()
                    Sorted_sortVariant = 1
                end
                Sorted_GetSortButton(SORTED_SORTBUTTON_NAME).button.text:SetText("Name") 
                SortedSortButtons_Update()
                Sorted_SortItems()
                Sorted_ScrollToTop()
            elseif sortButton.uniqueID == SORTED_SORTBUTTON_ICON then
                Sorted_GetSortButton(SORTED_SORTBUTTON_NAME).button:Click()
            end
        else
            local x,y = GetCursorPosition()
            x,y = x/UIParent:GetEffectiveScale(), y/UIParent:GetEffectiveScale()
            SortedFrameTabsMenu:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x * (1 / SortedFrameTabsMenu:GetScale()), y * (1 / SortedFrameTabsMenu:GetScale()))
            SortedFrameTabsMenu:Show()
        end
    end
end

function SortedSortButton_OnMouseDown(self)
    for i, button in ipairs(Sorted_sortButtons) do
        if button.uniqueID == self:GetID() then
            draggingIndex = i
        end
    end
end

function SortedSortButton_OnMouseUp(self)
    draggingIndex = nil
end

function SortedSortButton_OnEnter(self)
    if draggingIndex then
        for i, button in ipairs(Sorted_sortButtons) do
            if i ~= draggingIndex and button.uniqueID == self:GetID() then
                local temp = Sorted_sortButtons[draggingIndex]
                table.remove(Sorted_sortButtons, draggingIndex)
                table.insert(Sorted_sortButtons, i, temp)
                for i2, v in ipairs(Sorted_sortButtons) do
                    Sorted_sortButtonOrder[v.uniqueID] = i2
                end
                Sorted_UpdateSortButtons()
                draggingIndex = i
                return
            end
        end
    end
end

function SortedSortButtons_Update()
    for i, button in ipairs(Sorted_sortButtons) do
        if button.uniqueID ~= SORTED_SORTBUTTON_FAVORITES then
            local s
            if button.sortMethods then
                if button.uniqueID == Sorted_selectedSort then
                    s = button.sortMethods[math.ceil(Sorted_sortVariant / 2)].title
                else
                    s = button.sortMethods[#button.sortMethods].title
                end
            end
            if button.uniqueID == Sorted_selectedSort then
                local ascending
                if button.sortMethods[math.ceil(Sorted_sortVariant / 2)].inverse then
                    ascending = ((Sorted_sortVariant % 2) == 0)
                else
                    ascending = ((Sorted_sortVariant % 2) == 1)
                end
                s = s..GetSortArrow(ascending)
            end
            button.button.text:SetText(s)
        end
    end
end

function SortedSortButtons_OnLoad(self)
    Sorted_selectedSort = SORTED_DEFAULT_SORT
    Sorted_sortVariant = 1
    for i,v in ipairs(Sorted_sortButtons) do
        local b
        if v.uniqueID ~= SORTED_SORTBUTTON_FAVORITES then -- Ignore favorites tab
            b = CreateFrame("Button", self:GetName()..v.name, self, "SortedColumnHeaderTemplate")
            b:SetScript("OnClick", SortedSortButton_OnClick)
        else
            b = SortedFrameFavoritesSortButton
        end
        b:SetScript("OnMouseDown", SortedSortButton_OnMouseDown)
        b:SetScript("OnMouseUp", SortedSortButton_OnMouseUp)
        b:SetScript("OnDragStop", SortedSortButton_OnMouseUp)
        b:SetScript("OnEnter", SortedSortButton_OnEnter)
        b:SetID(v.uniqueID)
        b:RegisterForClicks("LeftButtonUp", "RightButtonDown")
        b:RegisterForDrag("LeftButton")

        v.button = b

        if v.sortMethods then
            b.text:SetText(v.sortMethods[1].title) 
        end
    end
    SortedSortButtons_Update()
    
    -- Tab dropdown menu
    local tabMenu = CreateFrame("Frame", "SortedFrameTabsMenu", UIParent, "TooltipBorderedFrameTemplate")
    if Sorted_IsDemo() then
        tabMenu:SetFrameStrata("FULLSCREEN_DIALOG")
    else
        tabMenu:SetFrameStrata("DIALOG")
    end
    tabMenu.checkButtons = {}
    function tabMenu.UpdateWidth(self)
        local width = 0
        for k,v in pairs(self.checkButtons) do
            if v.text:GetWidth() > width then
                width = v.text:GetWidth()
            end
        end
        self:SetWidth(36 + width)
    end
    local y = 0
    for i,v in ipairs(Sorted_sortButtons) do
        if --[[v.uniqueID ~= SORTED_SORTBUTTON_NAME and]] Sorted_sortButtons[i]:Enabled() then
            local cb = CreateFrame("CheckButton", "SortedFrameTabsMenu"..v.name, tabMenu, "SortedCheckButtonTemplate")
            cb.text:ClearAllPoints()
            cb.text:SetPoint("LEFT", cb, "RIGHT")
            cb.text:SetText(v.name)
            cb:SetPoint("TOPLEFT", 3, -4 - y)
            cb.clickable:SetPoint("RIGHT", tabMenu)
            cb:SetID(v.uniqueID)
            cb:SetScript("OnClick", function(self, button)
                if button == "LeftButton" then
                    if Sorted_enabledColumns[self:GetID()] then
                        local foundOther = false
                        for k,v in pairs(Sorted_enabledColumns) do
                            if k ~= self:GetID() and v then
                                foundOther = true
                            end
                        end
                        if not foundOther then 
                            self:SetChecked(true)
                            return false 
                        end           
                    end     
                    Sorted_ToggleSortButton(self:GetID())
                    self:SetChecked(Sorted_enabledColumns[self:GetID()])
                end
            end)
            tabMenu.checkButtons[i] = cb
            y = y + cb.clickable:GetHeight()
            cb:HookScript("OnShow", function(self, event)
                self:SetChecked(Sorted_enabledColumns[self:GetID()])
            end)
        end
    end
    tabMenu:SetHeight(y + 11)
    tabMenu:UpdateWidth()
    tabMenu:Hide()
    if not Sorted_IsClassic() then
        tabMenu:RegisterEvent("GLOBAL_MOUSE_DOWN")
    end
    tabMenu:SetScript("OnEvent", function(self)
        if self:IsShown() and not self:IsMouseOver() then 
            self:Hide() 
        end
    end)
    tabMenu:SetScript("OnShow", function(self)
        table.sort(self.checkButtons, function(a,b)
            return Sorted_sortButtonOrder[a:GetID()] < Sorted_sortButtonOrder[b:GetID()]
        end)
        for i, cb in ipairs(self.checkButtons) do
            cb:SetPoint("TOPLEFT", 3, -4 - (i - 1) * cb.clickable:GetHeight())
        end
        self:UpdateWidth()
    end)
end