function SortedItemList_StopScrolling(self)
    self.scrollElapsed = 0
    self.scrollStart = nil
    self.scrollTarget = nil
    self.isScrolling = false
end

function SortedItemList_UpdateScrollBar(self)
    local n = self.scrollChild:GetHeight() - self:GetHeight()
    if n < 1 then n = 1 end
    n = math.ceil(n)
    self.scrollBar:SetMinMaxValues(1, n)
    SortedItemList_StopScrolling(self)
end

-- Perform smooth scrolling
function SortedItemList_IsScrolling(self)
    return self.isScrolling
end

local function SortedItemList_OnUpdate(self, elapsed)
    if Sorted_IsDemo() or (((MouseIsOver(self) or MouseIsOver(self.itemDropButton)) and GetCursorInfo() == "item")
    and not ((self.itemDropButton.type == "BANK" or self.itemDropButton.type == "REAGENT") and not Sorted_bankIsOpened)) then
        self.itemDropButton:Show()
    else
        self.itemDropButton:Hide()
    end
    
    if SortedItemList_IsScrolling(self) then
        if Sorted_GetSetting("smoothingAmount") == 0 then
            self.scrollValue = self.scrollTarget
            SortedItemList_StopScrolling(self)
        else
            self.scrollElapsed = self.scrollElapsed + elapsed
            local distance = self.scrollTarget - self.scrollStart
            local smoothElapsed = 1 - (1 + math.cos((self.scrollElapsed / Sorted_GetSetting("smoothingAmount")) * math.pi)) / 2
            
            self.scrollValue = self.scrollStart + distance * smoothElapsed

            if self.scrollElapsed >= Sorted_GetSetting("smoothingAmount") then
                self.scrollValue = self.scrollTarget
                SortedItemList_StopScrolling(self)
            end
        end

        local min,max = self.scrollBar:GetMinMaxValues()
        if self.scrollValue < min then
            self.scrollValue = min
            SortedItemList_StopScrolling(self)
        elseif self.scrollValue > max then
            self.scrollValue = max
            SortedItemList_StopScrolling(self)
        end

        self.scrollBar:SetValue(self.scrollValue)
    end
end

function SortedItemList_UpdateItemButtons(self, itemID)
    for _, itemButton in ipairs(self.itemButtons) do
        if (not itemID or itemID == itemButton.itemID) then
            SortedItemButton_Update(itemButton)
        end
    end
    
    -- Combine stacks
    if Sorted_GetSetting("combineStacks") == 2 then
        local items = {}
        for i, v in ipairs(self.itemButtons) do
            if SortedItemList_ItemButtonShown(self, v) and (not itemID or itemID == v.itemID) then
                if items[v.link] then
                    if items[v.link].count < v.count then
                        items[v.link].count = v.count
                        items[v.link].bag = v.bag
                        items[v.link].slot = v.slot
                    end
                    items[v.link].totalCount = items[v.link].totalCount + v.count
                else
                    items[v.link] = {
                        ["count"] = v.count,
                        ["bag"] = v.bag,
                        ["slot"] = v.slot,
                        ["totalCount"] = v.count
                    }
                end
            end
        end
        for i, v in ipairs(self.itemButtons) do
            if SortedItemList_ItemButtonShown(self, v) and (not itemID or itemID == v.itemID) then
                SortedItemButton_Update(v)
                if not (v.bag == items[v.link].bag and v.slot == items[v.link].slot) then
                    v.empty = true
                else
                    v.count = items[v.link].totalCount
                    if v.count > 1 then
                        v.quantityString:SetText(v.count)
                        if v.value > 0 and not v.hasNoValue then
                            v.valueString:SetText(Sorted_FormatValueString(v.value * v.count))
                            local color = Sorted_GetValueColor(v.value * v.count)
                            v.valueString:SetTextColor(color.r, color.g, color.b)
                        end
                    end
                end
            end
        end
    end

end

function SortedItemList_SetBackdropAlpha(self, alpha)
    SortedShadowedFrame_SetAlpha(self, alpha)
    for _, itemButton in pairs(self.itemButtons) do
        itemButton.bgTex:SetGradientAlpha("VERTICAL", 0.3, 0.26, 0.2, 0.02 * alpha, 0, 0, 0, 0.15 * alpha)
    end
end

function SortedItemList_ItemButtonShown(self, itemButton)
    return not itemButton.empty
    and not ((itemButton.bag > 0 and itemButton.bag <= NUM_BAG_SLOTS) and self.type == "BAGS" and Sorted_GetBagFrameShown(itemButton.bag)) 
    and not ((itemButton.bag > NUM_BAG_SLOTS and itemButton.bag <= NUM_BAG_SLOTS + NUM_BANKBAGSLOTS) and self.type == "BANK" and Sorted_GetBagFrameShown(itemButton.bag))
end

function SortedItemList_PositionItemButtons(self)

    local count = 0
    for i, v in ipairs(self.itemButtons) do
        if (SortedItemList_ItemButtonShown(self, v)) then
            v:Show()
            v:SetPoint("LEFT")
            v:SetPoint("RIGHT", self.scrollBar, "LEFT", -2, 0)
            v:SetPoint("TOP", 0, -count * (Sorted_GetSetting("iconSize") + Sorted_GetSetting("padding")) - 2)
            v:SetHeight(Sorted_GetSetting("iconSize") + Sorted_GetSetting("padding"))
            v.iconFrame:SetSize(Sorted_GetSetting("iconSize"), Sorted_GetSetting("iconSize"))
            v.iconGlow:SetSize(Sorted_GetSetting("iconSize") * 1.4, Sorted_GetSetting("iconSize") * 1.4)
            count = count + 1
            if v.filtered then
                v:SetAlpha(0.2)
                v.iconGlow:SetAlpha(0)
            else
                if Sorted_currentPlayerSelected then
                    v:SetAlpha(1)
                else
                    v:SetAlpha(0.9)
                end
                v.iconGlow:SetAlpha(1)
            end
        else
            v:ClearAllPoints()
            v:Hide()
        end
    end
    self.scrollChild:SetHeight(count * (Sorted_GetSetting("iconSize") + Sorted_GetSetting("padding")) + 1)
    --[[if not (type=="BANK" or type=="REAGENT") or Sorted_bankIsOpened then
        self.itemDropButton:SetPoint("TOPLEFT", self.scrollChild, "BOTTOMLEFT", 0, 64)
        self.scrollChild:SetHeight(self.scrollChild:GetHeight() + 64)
    else
        self.itemDropButton:SetPoint("TOPLEFT", self.scrollChild, "BOTTOMLEFT", 0, 0)
    end]]
    if self.scrollChild:GetHeight() < self:GetHeight() then
        self.scrollChild:SetHeight(self:GetHeight())
    end
    Sorted_UpdateScrollBars()
    -- Set warning string
    local type = self.type
    if type == "BAGS" or type == "BANK" or type == "REAGENT" then
        --[[if count == 0 then
            if Sorted_SelectedFilter == 13 then
                self.warningString:SetText("No miscellaneous items found")
            elseif Sorted_SelectedFilter > 0 then
                self.warningString:SetText("No "..Sorted_FilterButtons[Sorted_SelectedFilter].text:GetText():lower().." found")
            else
                self.warningString:SetText("No items found")
            end
            if #SortedFrameSearchBox:GetText() > 0 then
                self.warningString:SetText(self.warningString:GetText().." containing\n\"".._G["SortedFrameSearchBox"]:GetText().."\"")
            end
        else
            self.warningString:SetText("")
        end]]
        if type=="BANK" and not Sorted_GetBankCached() then
            if Sorted_currentPlayerSelected then
                self.warningString:SetText(Sorted.Localize("WARNING_BANK_NOT_CACHED"))
            else
                self.warningString:SetText(Sorted.Localize("WARNING_BANK_NOT_CACHED_OTHER", Sorted_Data[Sorted_SelectedPlayerGUID].name))
            end
        elseif type=="REAGENT" and not Sorted_GetReagentUnlocked() then
            if not Sorted_currentPlayerSelected then
                self.warningString:SetText(Sorted.Localize("WARNING_REAGENTBANK_NOT_PURCHASED_OTHER", Sorted_Data[Sorted_SelectedPlayerGUID].name))
                self.PurchaseButton:Hide()
                self.CostMoneyFrame:Hide()
            else
                if not Sorted_bankIsOpened then
                    self.warningString:SetText(Sorted.Localize("WARNING_REAGENTBANK_NOT_PURCHASED"))
                    self.PurchaseButton:Hide()
                    self.CostMoneyFrame:Hide()
                else
                    self.warningString:SetText(Sorted.Localize("WARNING_REAGENTBANK_PURCHASE"))
                    self.PurchaseButton:Show()
                    self.CostMoneyFrame:Show()
                end
            end
        elseif count == 0 then
            self.warningString:SetText(Sorted.Localize("WARNING_NO_ITEMS_FOUND"))
        else
            self.warningString:SetText("")
        end
    end
end

function SortedItemList_OnLoad(self)
    local type = self:GetParent().type
    if type == "REAGENT" and Sorted_IsClassic() then
        return
    end
    self.type = type
    self.scrollBar = CreateFrame("Slider", self:GetName().."ScrollBar", self, "UIPanelScrollBarTrimTemplate")
    if type == "BANK" or type == "REAGENT" then
        self.scrollBar:SetPoint("TOPRIGHT", -3, -17)
        self.scrollBar:SetPoint("BOTTOM", 0, 13)
    elseif string.sub(type, 1, 9) == "CONTAINER" or type == "KEYRING" then
        self.scrollBar:SetPoint("TOPRIGHT", -1, -17)
        self.scrollBar:SetPoint("BOTTOM", 0, 15)
    else
        self.scrollBar:SetPoint("TOPRIGHT", 0, 8)
        self.scrollBar:SetPoint("BOTTOM", 0, 13)
    end
    self.scrollBar:SetMinMaxValues(1, 1000)
	self.scrollBar:SetValueStep(1)
	self.scrollBar.scrollStep = 32
    self.scrollBar:SetValue(0)
    local bg = self.scrollBar:CreateTexture(self:GetName().."ScrollBarBG", "BACKGROUND")
    bg:SetVertTile(true) bg:SetHorizTile(true)
    bg:SetAllPoints()
    bg:SetTexture("Interface\\Addons\\Sorted\\Textures\\UI-Background")
    
    self.scrollChild = CreateFrame("Frame", self:GetName().."ScrollChild", self)
    self.scrollChild:SetPoint("RIGHT", self.scrollBar, "LEFT", 0, 0)
    self.scrollChild:SetWidth(800)
    self:SetScrollChild(self.scrollChild)

    self.itemButtons = {}
    local index = 1
    local containers
    local maxSlots = 36
    if type == "REAGENT" then
        maxSlots = 98
    end
    if type == "BAGS" or type == "BANK" or type == "REAGENT" or type == "KEYRING" then
        containers = Sorted_ContainersOfType(type)
        if type == "KEYRING" then
            self.container = KEYRING_CONTAINER
        end
    elseif string.sub(type, 1, 9) == "CONTAINER" then
        self.container = tonumber(string.sub(type, 10))
        containers = { self.container }
    end
    for _, bag in pairs(containers) do
        for slot = 1, maxSlots do
            self.itemButtons[index] = Sorted_CreateItemButton(self.scrollChild, bag, slot)
            self.itemButtons[index].bag = bag
            self.itemButtons[index].slot = slot
            if type=="BANK" or type=="REAGENT" then
                self.itemButtons[index].isBankSlot = true
            end

            self.itemButtons[index].button:HookScript("OnEnter", function(self)
                self:GetParent().newItemTexture:Hide()
                if not Sorted_GetFavorited(self:GetParent()) then
                    self:GetParent().favoriteButton:GetNormalTexture():SetTexCoord(0, 0.21875, 0.21875 * 2, 0.21875 * 3)
                end
            end)

            self.itemButtons[index].button:HookScript("OnLeave", function(self)
                self:GetParent().newItemTexture:Hide()
                if not Sorted_GetFavorited(self:GetParent()) then
                    self:GetParent().favoriteButton:GetNormalTexture():SetTexCoord(1, 1, 1, 1)
                end
            end)

            --[[self.itemButtons[index].button:SetScript("OnClick", function(self, button)
                if IsModifiedClick() then
                    SortedItemButton_OnModifiedClick(self, button)
                else
                    ContainerFrameItemButton_OnClick(self, button)
                end
            end)]]
            --Sorted_Slots[index].button:SetScript("OnReceiveDrag", function(self) SortedItemButton_OnClick(self, "LeftButton") end)

            self.itemButtons[index].favoriteButton:HookScript("OnEnter", function(self)
                self:GetParent().mouseOver = true
            end)
            self.itemButtons[index].favoriteButton:HookScript("OnLeave", function(self)
                self:GetParent().button.highlight:Hide()
                self:GetParent().mouseOver = false
            end)

            self.itemButtons[index].favoriteButton:HookScript("OnClick", function(self, mouseButton)
                if SortedIconSelectionMenu:IsShown() then
                    SortedIconSelectionMenu:Hide()
                    return
                end
                if mouseButton == "LeftButton" then
                    Sorted_ToggleFavorite(self:GetParent())
                    Sorted_UpdateItemButtons()
                    Sorted_FilterItems()
                elseif mouseButton == "RightButton" then
                    SortedIconSelectionMenu.itemButton = self:GetParent()
                    local x,y = GetCursorPosition()
                    x,y = x/UIParent:GetEffectiveScale(), y/UIParent:GetEffectiveScale()
                    SortedIconSelectionMenu:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x * (1 / SortedIconSelectionMenu:GetScale()), y * (1 / SortedIconSelectionMenu:GetScale()))
                    SortedIconSelectionMenu:Show()
                end
            end)

            index = index + 1
        end
    end

    self.scrollChild:EnableMouse("LeftButton")
    self.scrollChild:SetScript("OnReceiveDrag", SortedItemList_OnClick)

    self.itemDropButton = CreateFrame("Button", self:GetName().."ItemDropButton", self)
    self.itemDropButton:SetFrameLevel(self:GetFrameLevel() + 2)
    self.itemDropButton:SetNormalTexture("Interface\\Addons\\Sorted\\Textures\\UI-ItemDrop-Slot")
    self.itemDropButton:SetHighlightTexture("Interface\\Addons\\Sorted\\Textures\\UI-ItemDrop-Slot-Highlight")
    self.itemDropButton.type = type
    if string.sub(type, 1, 9) == "CONTAINER" then
        self.itemDropButton:SetPoint("BOTTOMRIGHT", -21, 0)
        self.itemDropButton:SetSize(112, 54)
        self.itemDropButton:GetNormalTexture():SetTexCoord(0, 1, 0, 0.96875)
        self.itemDropButton:GetHighlightTexture():SetTexCoord(0, 1, 0, 0.96875)
    else
        self.itemDropButton:SetPoint("BOTTOMRIGHT", -21, -3)
        self.itemDropButton:SetSize(112, 56)
    end
    self.itemDropButton:GetHighlightTexture():SetAlpha(0.7)
    self.itemDropButton:SetScript("OnMouseDown", function(self) Sorted_PutItemInBags(self.type) end)
    self.itemDropButton:SetScript("OnReceiveDrag", function(self) Sorted_PutItemInBags(self.type) end)
    self.itemDropButton:SetScript("OnEnter", function(self)
        if GetCursorInfo() == "item" then
            SortedTooltip.Schedule(function()
                GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
                GameTooltip:ClearLines()
                if self.type == "REAGENT" then
                    GameTooltip:AddLine("Place item in your reagent bank")
                elseif string.sub(self.type, 1, 9) == "CONTAINER" then
                    GameTooltip:AddLine("Place item in this bag")
                else
                    GameTooltip:AddLine("Place item in your "..self.type:lower())
                end
                GameTooltip:Show()
            end)
        end
    end)
    self.itemDropButton:SetScript("OnLeave", SortedTooltip.Cancel)

    --[[local texL = self.itemDropButton:CreateTexture(self.itemDropButton:GetName().."TexL", "BACKGROUND")
    texL:SetPoint("TOPLEFT")
    texL:SetPoint("BOTTOMRIGHT", self.itemDropButton, "BOTTOMLEFT", 64, 0)
    texL:SetTexture("Interface\\Addons\\Sorted\\Textures\\UI-ItemDrop-Button-Mult")
    texL:SetTexCoord(0, 0.25, 0, 1)
    texL:SetBlendMode("MOD")
    local texR = self.itemDropButton:CreateTexture(self.itemDropButton:GetName().."TexR", "BACKGROUND")
    texR:SetPoint("TOPRIGHT")
    texR:SetPoint("BOTTOMLEFT", self.itemDropButton, "BOTTOMRIGHT", -160, 0)
    texR:SetTexture("Interface\\Addons\\Sorted\\Textures\\UI-ItemDrop-Button-Mult")
    texR:SetTexCoord(0.375, 1, 0, 1)
    texR:SetBlendMode("MOD")
    local texC = self.itemDropButton:CreateTexture(self.itemDropButton:GetName().."TexC", "BACKGROUND")
    texC:SetPoint("TOPRIGHT", texR, "TOPLEFT")
    texC:SetPoint("BOTTOMLEFT", texL, "BOTTOMRIGHT")
    texC:SetTexture("Interface\\Addons\\Sorted\\Textures\\UI-ItemDrop-Button-Mult", "BACKGROUND")
    texC:SetTexCoord(0.25, 0.375, 0, 1)
    texC:SetBlendMode("MOD")]]


    self.foregroundFrame = CreateFrame("Frame", self:GetName().."ForegroundFrame", self.scrollChild)
    self.foregroundFrame:SetAllPoints()
    if type=="REAGENT" then
        self.PurchaseButton:SetParent(self.foregroundFrame)
        self.CostMoneyFrame:SetParent(self.foregroundFrame)
    end
    self.warningString:SetParent(self.foregroundFrame)


    -- Create column separator lines, starting from the left
    local posX = 0
    local indexReached = 0
    for i, v in ipairs(Sorted_sortButtons) do
        if not v.dontDrawColumnSeparators then
            local columnSeparator = self.foregroundFrame:CreateTexture(self:GetName().."TexColSep"..i, "OVERLAY")
            columnSeparator:SetPoint("TOP")
            columnSeparator:SetPoint("BOTTOM")
            columnSeparator:SetTexture("Interface\\Addons\\Sorted\\Textures\\UI-Column-Seperator")
            columnSeparator:SetTexCoord(0, 0.9375, 0.1, 0.1)
            columnSeparator:SetWidth(3.5)
            columnSeparator.relScrollBar = self.scrollBar
            if not v.columnSeparators then v.columnSeparators = {} end
            table.insert(v.columnSeparators, columnSeparator)
        end
    end

    self:EnableMouseWheel(1)
    self:SetScript("OnMouseWheel", function(self, delta)
        if not SortedIconSelectionMenu:IsShown() then
            local mult = 1
            if IsAltKeyDown() then mult = mult * 3 end

            if Sorted_GetSetting("smoothScrolling") == 2 then
                if SortedItemList_IsScrolling(self) and ((delta < 0 and self.scrollTarget < self.scrollStart) or (delta > 0 and self.scrollTarget > self.scrollStart)) then
                    SortedItemList_StopScrolling(self)
                end

                if SortedItemList_IsScrolling(self) then
                    self.scrollStart = self.scrollBar:GetValue()
                    self.scrollTarget = self.scrollTarget - delta * Sorted_GetSetting("scrollSpeed") * mult * Sorted_GetSetting("iconSize")
                    self.scrollElapsed = 0
                else
                    self.isScrolling = true
                    self.scrollStart = self.scrollBar:GetValue()
                    self.scrollElapsed = 0
                    self.scrollTarget =  self.scrollStart - delta * Sorted_GetSetting("scrollSpeed") * mult * Sorted_GetSetting("iconSize")
                end
            else
                local scrollValue = self.scrollBar:GetValue() - delta * Sorted_GetSetting("scrollSpeed") * mult * Sorted_GetSetting("iconSize")
                local min,max = self.scrollBar:GetMinMaxValues()
                if scrollValue < min then
                    scrollValue = min
                elseif scrollValue > max then
                    scrollValue = max
                end
                self.scrollBar:SetValue(scrollValue)
            end
        end
     end)

     if type == "BAGS" then
        self.ShouldUpdate = function(self) 
            return true 
        end
    elseif type == "BANK" then
        self.ShouldUpdate = function(self)
            return SortedBankSidePanel:IsShown()
        end
    elseif type == "REAGENT" then
        self.ShouldUpdate = function(self)
            return SortedReagentSidePanel:IsShown()
        end
    else
        self.ShouldUpdate = function(self)
            return _G["SortedBag"..self.container.."Frame"]:IsShown()
        end
    end

     self:SetScript("OnUpdate", SortedItemList_OnUpdate)
     
     table.insert(Sorted_itemLists, self)
end
