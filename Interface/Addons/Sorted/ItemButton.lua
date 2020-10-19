local Sorted_maxILvl = 0 -- ilvl opacity is set against this

function SortedItemButton_Update(self)
    local slotData = Sorted_GetContainerItemInfo(self.bag, self.slot)
    self.empty = true
    if slotData.itemID then
        if not slotData.level then
            SortedContainerItemInfo_Update(self.bag, self.slot, Sorted_SelectedPlayerGUID)
        end
        self.empty = false
        self.texture, self.count, self.quality = slotData.texture, slotData.count, slotData.quality
        self.link, self.hasNoValue, self.itemID = slotData.link, slotData.hasNoValue, slotData.itemID
        self.name, self.level = slotData.name, slotData.level
        self.minLevel = slotData.minLevel
        self.equipLoc, self.value, self.classID = slotData.equipLoc, slotData.value, slotData.classID
        self.subClassID, self.bindType, self.expacID = slotData.subClassID, slotData.bindType, slotData.expacID
        self.effectiveILvl, self.isPreview = slotData.effectiveILvl, slotData.isPreview
        self.speciesID, self.bound = slotData.speciesID, slotData.bound

        if self.name then
            if Sorted_IsDemo() then
                if self.itemID == 36942 then
                    self.quality = 7
                    self.effectiveILvl = 425
                    self.texture = 1373362
                elseif self.itemID == 1 then
                    self.texture = 341221
                    self.effectiveILvl = 310
                    self.name = "Helm of Domination"
                end
            end

            --self.statTable = GetItemStats(self.link)
            --Sorted_PrintTable(self.statTable, 0)

            if not Sorted_IsClassic() and CanIMogIt then
                self.transmogValue = CanIMogIt:GetIconText(self.link)
                self.transmogString:SetText(self.transmogValue)

                --[[self.transmogValue = Sorted_TransmogCollected(self.itemID, self.link)
                
                if self.transmogValue >= 3 then
                    self.transmogString:SetText("Learnt")
                elseif self.transmogValue >= 1 then
                    self.transmogString:SetText("Unlearnt")
                else
                    self.transmogString:SetText("")
                end

                if self.transmogValue == 4 then
                    local r,g,b = Sorted_GetItemQualityColor(2)
                    self.transmogString:SetTextColor(r,g,b)
                elseif self.transmogValue == 3 then
                    local r,g,b = Sorted_GetItemQualityColor(6)
                    self.transmogString:SetTextColor(r,g,b)
                elseif self.transmogValue == 2 then
                    local r,g,b = Sorted_GetItemQualityColor(6)
                    self.transmogString:SetTextColor(r,g,b)
                elseif self.transmogValue == 1 then
                    local r,g,b = Sorted_GetItemQualityColor(6)
                    self.transmogString:SetTextColor(r,g,b)
                else
                    local r,g,b = Sorted_GetItemQualityColor(5)
                    self.transmogString:SetTextColor(r,g,b)
                end
    
                --self.transmogString:SetText(self.transmogValue)]]
            end

            if Sorted_CurrentPlayerSelected() and self.effectiveILvl and self.effectiveILvl > Sorted_maxILvl then 
                Sorted_maxILvl = self.effectiveILvl 
            end
            
            self.isNewItem = C_NewItems.IsNewItem(self.bag, self.slot)
            if self.isNewItem and Sorted_currentPlayerSelected then
                self.newItemTexture:SetAllPoints()
                self.newItemTexture:Show()
            else
                self.newItemTexture:Hide()
                self.newItemTexture:ClearAllPoints()
            end

            if self.count > 1 then
                self.quantityString:SetText(self.count)
            else
                self.quantityString:SetText("")
            end

            self.itemIcon:SetTexture(self.texture)
            -- Battle pets
            if self.cageName then
                self.name = "Caged ".. self.cageName
                self.nameString:SetText(self.name)
                self.levelString:SetTextColor(1, 0.92, 0.8, (self.petLevel / 25.0 * 0.65) + 0.35)
                self.levelString:SetText(self.petLevel)
                self.effectiveILvl = tonumber(self.petLevel)

            -- Everything else
            else
                self.nameString:SetText(self.name)
                if (self.effectiveILvl and self.effectiveILvl > 1) then
                    self.levelString:SetText(self.effectiveILvl)
                    local alpha = self.effectiveILvl / Sorted_maxILvl
                    alpha = alpha * alpha * 0.65 + 0.35
                    if alpha > 1 then alpha = 1 end
                    self.levelString:SetTextColor(1, 0.92, 0.8, alpha)
                else
                    self.levelString:SetText("")
                    self.effectiveILvl = 0
                end
            end
            local r,g,b = Sorted_GetItemQualityColor(self.quality)
            self.nameString:SetTextColor(r,g,b,1)


            if self.minLevel > UnitLevel("player") then
                self.minLevelString:SetTextColor(1, 0.3, 0.2, 0.8)
                self.minLevelString:SetText(self.minLevel)
            elseif (self.minLevel > 1) then
                self.minLevelString:SetText(self.minLevel)
                local alpha = self.minLevel / UnitLevel("player")
                alpha = alpha * alpha * 0.65 + 0.35
                if alpha > 1 then alpha = 1 end
                self.minLevelString:SetTextColor(1, 0.92, 0.8, alpha)
            else
                self.minLevelString:SetText("")
            end

            if (self.value > 0 and not self.hasNoValue) then
                self.valueString:SetText(Sorted_FormatValueString(self.value * self.count))
                local color = Sorted_GetValueColor(self.value * self.count)
                self.valueString:SetTextColor(color.r, color.g, color.b)
            else
                self.valueString:SetText("")
            end

            if self.bindType == 4 then self.bindType = 1 end -- Treat quest items as BoP
            self.bindString:SetText(Sorted_FormatBindType(self.bindType, self.bound))

            if self.classID then
                self.typeString:SetText(GetItemClassInfo(self.classID))
            else
                self.typeString:SetText("")
            end

            self.expacString:SetText(Sorted_FormatExpac(self.expacID))

            local size = Sorted_GetSetting("iconSize")
            self.favoriteButton:SetWidth(size)
            self.favoriteButton:SetHeight(size + Sorted_GetSetting("padding"))
            size = 8 + size * 0.4
            self.favoriteButton:GetNormalTexture():SetSize(size, size)
            self.favoriteButton:GetHighlightTexture():SetSize(size, size)
            self.favoriteButton:GetPushedTexture():SetSize(size, size)
            if Sorted_GetFavorited(self) then
                -- Only animate if icon has changed
                if not self.previousFavorited or self.previousFavorited ~= Sorted_GetFavorited(self) then 
                    self.favoriteButton:GetNormalTexture():SetTexCoord(
                        (math.fmod(Sorted_GetFavorited(self) - 1, 4)) * 0.21875, 
                        (math.fmod(Sorted_GetFavorited(self) - 1, 4) + 1) * 0.21875, 
                        (math.floor((Sorted_GetFavorited(self) - 1) / 4)) * 0.21875, 
                        (math.floor((Sorted_GetFavorited(self) - 1) / 4) + 1) * 0.21875
                    )
                    self.favoriteButton:GetHighlightTexture():SetTexCoord(
                        (math.fmod(Sorted_GetFavorited(self) - 1, 4)) * 0.21875, 
                        (math.fmod(Sorted_GetFavorited(self) - 1, 4) + 1) * 0.21875, 
                        (math.floor((Sorted_GetFavorited(self) - 1) / 4)) * 0.21875, 
                        (math.floor((Sorted_GetFavorited(self) - 1) / 4) + 1) * 0.21875
                    )
                    self.favoriteButton:GetPushedTexture():SetTexCoord(
                        (math.fmod(Sorted_GetFavorited(self) - 1, 4)) * 0.21875, 
                        (math.fmod(Sorted_GetFavorited(self) - 1, 4) + 1) * 0.21875, 
                        (math.floor((Sorted_GetFavorited(self) - 1) / 4)) * 0.21875, 
                        (math.floor((Sorted_GetFavorited(self) - 1) / 4) + 1) * 0.21875
                    )
                    self.favoriteButtonEnabled = true
                    self.favoriteButton.fade:Stop()
                    self.favoriteButton.pulse:Play()
                    self.previousFavorited = Sorted_GetFavorited(self)
                end
            -- Restore to default grey star
            elseif self.previousFavorited then
                self.favoriteButton:GetHighlightTexture():SetTexCoord(
                    0, 
                    0.21875, 
                    0, 
                    0.21875
                )
                self.favoriteButton.pulse:Stop()
                --self.favoriteButton.fade:Play()
                self.favoriteButton:GetNormalTexture():SetTexCoord(1,1,1,1)
                self.favoriteButton:GetPushedTexture():SetTexCoord(1,1,1,1)
                self.previousFavorited = 0
            end

            if (self.isBankSlot and not Sorted_bankIsOpened) or (not Sorted_currentPlayerSelected) then
                local r,g,b = Sorted_GetItemQualityHighlightColor(self.quality)
                self.button.iconGlow:SetVertexColor(r, g, b, 1)
                self.button.highlight:SetVertexColor(0.3, 0.3, 0.3, 1)
                self.button.pushed:SetVertexColor(0, 0, 0, 0)
                self:SetAlpha(0.9)
                self.button:Disable()
            else
                local r,g,b = Sorted_GetItemQualityHighlightColor(self.quality)
                self.button.iconGlow:SetVertexColor(r, g, b, 1)
                self.button.highlight:SetVertexColor(r, g, b, 1)
                r,g,b = Sorted_GetItemQualityHighlightTextColor(self.quality)
                self.button.pushed:SetVertexColor(r, g, b, 0.6)
                self:SetAlpha(1)
                self.button:Enable()
            end
            if self.UpgradeIcon then
                if Sorted_currentPlayerSelected and Sorted_enabledColumns[SORTED_SORTBUTTON_LEVEL] and not Sorted_IsClassic() then
                    ContainerFrameItemButton_UpdateItemUpgradeIcon(self.button)
                    if self.UpgradeIcon:IsShown() then
                        self.UpgradeIcon:ClearAllPoints()
                        self.UpgradeIcon:SetPoint("RIGHT", self.levelString, "RIGHT", -6, 0)
                        self.UpgradeIcon:SetSize(14, 14)
                    end
                else
                    self.UpgradeIcon:Hide()
                end
            end
        else
            self.empty = true
        end
    end
    if self.empty then 
        self:Hide()
    else
        self:Show()
    end
end



-- TOOLTIPS
function SortedItemButton_CalculateItemTooltipAnchors(self, mainTooltip)
	local x = self:GetRight();
	local anchorFromLeft = x < GetScreenWidth() / 2;
	--[[if ( anchorFromLeft ) then
		mainTooltip:SetAnchorType("ANCHOR_CURSOR", 0, 0);
		mainTooltip:SetPoint("LEFT", self, "RIGHT");
	else
		mainTooltip:SetAnchorType("ANCHOR_CURSOR", 0, 0);
		mainTooltip:SetPoint("RIGHT", self, "LEFT");
	end]]
	if ( anchorFromLeft ) then
		mainTooltip:SetAnchorType("ANCHOR_RIGHT", 0, 0);
		mainTooltip:SetPoint("BOTTOMLEFT", self, "TOPRIGHT");
	else
		mainTooltip:SetAnchorType("ANCHOR_LEFT", 0, 0);
		mainTooltip:SetPoint("BOTTOMRIGHT", self, "TOPLEFT");
	end
end

function SortedItemButton_OnEnter(self)
    local showSell = nil;
	if ( MerchantFrame:IsShown() and MerchantFrame.selectedTab == 1 ) then
		showSell = 1;
	end

	if ( IsModifiedClick("DRESSUP") and self.hasItem ) then
		ShowInspectCursor();
	elseif ( showSell ) then
		ShowContainerSellCursor(self:GetParent():GetID(),self:GetID());
	elseif ( self.readable ) then
		ShowInspectCursor();
	else
		ResetCursor();
	end

	if ArtifactFrame and self.hasItem then
		ArtifactFrame:OnInventoryItemMouseEnter(self:GetParent():GetID(), self:GetID());
    end
    
    SortedTooltip.Schedule(function()
        SortedItemButton_DelayedOnEnter(self)
    end)
end

function SortedItemButton_DelayedOnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_NONE");

	-- Keyring specific code
	if ( self:GetParent():GetID() == KEYRING_CONTAINER ) then
		SortedItemButton_CalculateItemTooltipAnchors(self, GameTooltip);
		GameTooltip:SetInventoryItem("player", KeyRingButtonIDToInvSlotID(self:GetID()));
		CursorUpdate(self);
		return;
	end

	C_NewItems.RemoveNewItem(self:GetParent():GetID(), self:GetID());

	local newItemTexture = self.NewItemTexture;
	local battlepayItemTexture = self.BattlepayItemTexture;
	local flash = self.flashAnim;
	local newItemGlowAnim = self.newitemglowAnim;
    
    if newItemTexture then newItemTexture:Hide() end
    if battlepayItemTexture then battlepayItemTexture:Hide() end
	if flash and newItemGlowAnim and (flash:IsPlaying() or newItemGlowAnim:IsPlaying()) then
		flash:Stop();
		newItemGlowAnim:Stop();
	end
	
    local hasItem, hasCooldown, repairCost, speciesID, level, breedQuality, maxHealth, power, speed, name
    if self:GetParent():GetID() == BANK_CONTAINER or (not Sorted_IsClassic() and self:GetParent():GetID() == REAGENTBANK_CONTAINER) then
        hasItem, hasCooldown, repairCost, speciesID, level, breedQuality, maxHealth, power, speed, name = GameTooltip:SetInventoryItem("player", self:GetInventorySlot())
    else
        hasCooldown, repairCost, speciesID, level, breedQuality, maxHealth, power, speed, name = GameTooltip:SetBagItem(self:GetParent():GetID(), self:GetID());
    end
	if(speciesID and speciesID > 0) then
		SortedItemButton_CalculateItemTooltipAnchors(self, GameTooltip); -- Battle pet tooltip uses the GameTooltip's anchor
		BattlePetToolTip_Show(speciesID, level, breedQuality, maxHealth, power, speed, name);
		return;
	else
		if (BattlePetTooltip) then
			BattlePetTooltip:Hide();
		end
	end

	SortedItemButton_CalculateItemTooltipAnchors(self, GameTooltip);

	if ( IsModifiedClick("COMPAREITEMS") or GetCVarBool("alwaysCompareItems") ) then
		GameTooltip_ShowCompareItem(GameTooltip);
	end

	if ( InRepairMode() and (repairCost and repairCost > 0) ) then
		GameTooltip:AddLine(REPAIR_COST, nil, nil, nil, true);
		SetTooltipMoney(GameTooltip, repairCost);
		GameTooltip:Show();
	end

    if not Sorted_IsClassic() then
        if not GetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_MOUNT_EQUIPMENT_SLOT_FRAME) then
            local itemLocation = ItemLocation:CreateFromBagAndSlot(self:GetParent():GetID(), self:GetID());
            if itemLocation and itemLocation:IsValid() then
                if C_MountJournal.IsMountEquipmentUnlocked() and (not CollectionsJournal or not CollectionsJournal:IsShown()) then
                    local tabIndex = 1;
                    CollectionsMicroButton_SetAlertShown(tabIndex);
                end
            end
        end
    end
end

function Sorted_CreateItemButton(self, bag, slot)
    local frameName = "SortedSlot_Bag"..bag.."Item"..slot

    local parent = CreateFrame("Frame", frameName, self)
    parent:SetHeight(20)
    parent:SetID(bag)

    parent.itemList = self:GetParent()

    parent.favoriteButton = CreateFrame("Button", parent:GetName().."FavoriteButton", parent)
    parent.favoriteButton:SetSize(19,19)
    parent.favoriteButton:SetNormalTexture("Interface\\Addons\\Sorted\\Textures\\Favorite-Icons")
    parent.favoriteButton:GetNormalTexture():SetTexCoord(1, 1, 1, 1)
    parent.favoriteButton:GetNormalTexture():ClearAllPoints()
    parent.favoriteButton:GetNormalTexture():SetPoint("CENTER")
    parent.favoriteButton:SetHighlightTexture("Interface\\Addons\\Sorted\\Textures\\Favorite-Icons")
    parent.favoriteButton:GetHighlightTexture():SetTexCoord(0, 0.21875, 0, 0.21875)
    parent.favoriteButton:GetHighlightTexture():ClearAllPoints()
    parent.favoriteButton:GetHighlightTexture():SetPoint("CENTER")
    parent.favoriteButton:GetHighlightTexture():SetAlpha(0.5)
    parent.favoriteButton:GetHighlightTexture():SetBlendMode("ADD")
    parent.favoriteButton:SetPushedTexture("Interface\\Addons\\Sorted\\Textures\\Favorite-Icons")
    parent.favoriteButton:GetPushedTexture():SetTexCoord(1, 1, 1, 1)
    parent.favoriteButton:GetPushedTexture():ClearAllPoints()
    parent.favoriteButton:GetPushedTexture():SetPoint("CENTER")
    parent.favoriteButton:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    parent.favoriteButton.pulse = parent.favoriteButton:CreateAnimationGroup()
    local anim = parent.favoriteButton.pulse:CreateAnimation("Scale")
    anim:SetOrder(1)
    anim:SetFromScale(1, 1)
    anim:SetToScale(1.2, 1.2)
    anim:SetDuration(0.2)
    anim:SetSmoothing("OUT")
    anim = parent.favoriteButton.pulse:CreateAnimation("Scale")
    anim:SetOrder(2)
    anim:SetFromScale(1, 1)
    anim:SetToScale(0.833333, 0.833333)
    anim:SetDuration(0.2)
    anim:SetSmoothing("IN")
    parent.favoriteButton.fade = parent.favoriteButton:CreateAnimationGroup()
    anim = parent.favoriteButton.fade:CreateAnimation("Alpha")
    anim:SetFromAlpha(1)
    anim:SetToAlpha(0.2)
    anim:SetDuration(0.2)
    parent.favoriteButton.fade:HookScript("OnFinished", function(self)
        self:GetParent():GetNormalTexture():SetTexCoord(1, 1, 1, 1)
    end)

    parent.quantityString = parent:CreateFontString(parent:GetName().."QuantityString", "OVERLAY", "Sorted11Font")
    --parent.quantityString:SetPoint("RIGHT", parent, "LEFT", 50, 0)
    parent.quantityString:SetPoint("TOP")
    parent.quantityString:SetPoint("BOTTOM")
    parent.quantityString:SetJustifyH("RIGHT")
    parent.quantityString:SetJustifyV("MIDDLE")
    parent.quantityString:SetTextColor(0.96, 0.9, 0.82, 1)
    --parent.quantityString:SetWidth(Sorted_GetSortButton(SORTED_SORTBUTTON_QUANTITY).width)

    parent.nameFrame = CreateFrame("Frame", parent:GetName().."NameFrame", parent)
    parent.nameFrame:SetPoint("TOP", 0, -2)
    parent.nameFrame:SetPoint("BOTTOM", 0, 2)
    parent.nameFrame.leftX = 0
    parent.nameFrame.rightX = 0
    parent.nameString = parent.nameFrame:CreateFontString(parent:GetName().."NameString", "OVERLAY", "Sorted11Font")
    --parent.nameString:SetPoint("LEFT", 78, 0)
    --parent.nameString:SetPoint("RIGHT", -92, 0)
    parent.nameString:SetAllPoints()
    parent.nameString:SetJustifyH("LEFT")
    parent.nameString:SetJustifyV("MIDDLE")

    parent.levelString = parent:CreateFontString(parent:GetName().."LevelString", "OVERLAY", "Sorted11Font")
    --parent.levelString:SetPoint("LEFT", parent, "RIGHT", -88, 0)
    parent.levelString:SetPoint("TOP")
    parent.levelString:SetPoint("BOTTOM")
    parent.levelString:SetJustifyH("LEFT")
    parent.levelString:SetJustifyV("MIDDLE")
    parent.levelString:SetTextColor(1, 0.92, 0.8)
    --parent.levelString:SetWidth(Sorted_sortButtons[SORTED_SORTBUTTON_LEVEL].width)

    parent.minLevelString = parent:CreateFontString(parent:GetName().."MinLevelString", "OVERLAY", "Sorted11Font")
    parent.minLevelString:SetPoint("TOP")
    parent.minLevelString:SetPoint("BOTTOM")
    parent.minLevelString:SetJustifyH("LEFT")
    parent.minLevelString:SetJustifyV("MIDDLE")
    parent.minLevelString:SetTextColor(1, 0.92, 0.8)
    --parent.minLevelString:SetWidth(Sorted_sortButtons[SORTED_SORTBUTTON_REQUIRED_LEVEL].width)

    parent.valueString = parent:CreateFontString(parent:GetName().."ValueString", "OVERLAY", "Sorted11Font")
    --parent.valueString:SetPoint("RIGHT", -4, 0)
    parent.valueString:SetPoint("TOP")
    parent.valueString:SetPoint("BOTTOM")
    parent.valueString:SetJustifyH("RIGHT")
    parent.valueString:SetJustifyV("MIDDLE")
    --parent.valueString:SetWidth(Sorted_sortButtons[SORTED_SORTBUTTON_VALUE].width)

    parent.bindString = parent:CreateFontString(parent:GetName().."BindString", "OVERLAY", "Sorted11Font")
    parent.bindString:SetJustifyH("CENTER")
    parent.bindString:SetJustifyV("MIDDLE")
    parent.bindString:SetTextColor(1, 0.92, 0.8)
    --parent.bindString:SetWidth(Sorted_sortButtons[SORTED_SORTBUTTON_BIND].width)

    parent.transmogString = parent:CreateFontString(parent:GetName().."TransmogString", "OVERLAY", "Sorted11Font")
    parent.transmogString:SetJustifyH("CENTER")
    parent.transmogString:SetJustifyV("MIDDLE")
    parent.transmogString:SetTextColor(1, 0.92, 0.8)
    --parent.transmogString:SetWidth(Sorted_sortButtons[SORTED_SORTBUTTON_TRANSMOG].width)

    parent.typeString = parent:CreateFontString(parent:GetName().."TypeString", "OVERLAY", "Sorted11Font")
    parent.typeString:SetPoint("TOP")
    parent.typeString:SetPoint("BOTTOM")
    parent.typeString:SetJustifyH("LEFT")
    parent.typeString:SetJustifyV("MIDDLE")
    parent.typeString:SetTextColor(1, 0.92, 0.8)
    --parent.typeString:SetWidth(Sorted_sortButtons[SORTED_SORTBUTTON_TYPE].width - 8)

    parent.expacString = parent:CreateFontString(parent:GetName().."ExpacString", "OVERLAY", "Sorted11Font")
    parent.expacString:SetJustifyH("CENTER")
    parent.expacString:SetJustifyV("MIDDLE")
    parent.expacString:SetTextColor(1, 0.92, 0.8)
    --parent.expacString:SetWidth(Sorted_sortButtons[SORTED_SORTBUTTON_EXPANSION].width - 8)

    parent.timeAddedString = parent:CreateFontString(parent:GetName().."TimeAddedString", "OVERLAY", "Sorted11Font")
    parent.timeAddedString:SetPoint("TOP")
    parent.timeAddedString:SetPoint("BOTTOM")
    parent.timeAddedString:SetJustifyH("RIGHT")
    parent.timeAddedString:SetJustifyV("MIDDLE")
    parent.timeAddedString:SetTextColor(1, 0.92, 0.8)
    --parent.timeAddedString:SetWidth(Sorted_sortButtons[SORTED_SORTBUTTON_ADDED].width)

    parent.bgTex = parent:CreateTexture("", "BACKGROUND")
    parent.bgTex:SetAllPoints()
    parent.bgTex:SetColorTexture(1, 1, 1, 1)
    parent.bgTex:SetGradientAlpha("VERTICAL", 0.3, 0.26, 0.2, 0.02, 0, 0, 0, 0.15)

    parent.newItemTexture = parent:CreateTexture(parent:GetName().."HighlightTexture", "ARTWORK")
    parent.newItemTexture:SetTexture("Interface\\Addons\\Sorted\\Textures\\UI-Highlight")
    parent.newItemTexture:SetVertexColor(1, 0.9, 0.6, 0.6)
    parent.newItemTexture:SetBlendMode("ADD")
    parent.newItemTexture:Hide()

    parent.cooldownBar = CreateFrame("StatusBar", parent:GetName().."CooldownBar", parent)
    parent.cooldownBar:SetAllPoints()
    parent.cooldownBar:SetStatusBarTexture("Interface\\Addons\\Sorted\\Textures\\StatusBar")
    parent.cooldownBar:SetStatusBarColor(1, 0.92, 0.75, 0.2)
    parent.cooldownBar:SetOrientation("HORIZONTAL")
    parent.cooldownBar:SetFrameLevel(parent:GetFrameLevel() + 100)
    parent.cooldownBg = parent.cooldownBar:CreateTexture(parent:GetName().."CooldownBg", "ARTWORK")
    parent.cooldownBg:SetColorTexture(0, 0, 0, 0.3)
    parent.cooldownBg:SetAllPoints()
    parent.cooldownBg.fadeIn = parent.cooldownBg:CreateAnimationGroup()
    anim = parent.cooldownBg.fadeIn:CreateAnimation("Alpha", nil)
    anim:SetDuration(0.4)
    anim:SetFromAlpha(0)
    anim:SetToAlpha(1)
    parent.cooldownFlash = parent:CreateTexture(parent:GetName().."CooldownFlash", "OVERLAY")
    parent.cooldownFlash:SetTexture("Interface\\Addons\\Sorted\\Textures\\UI-Higherlight")
    parent.cooldownFlash:SetVertexColor(1,0.9,0.66)
    parent.cooldownFlash:SetAllPoints()
    parent.cooldownFlash:SetBlendMode("ADD")
    parent.cooldownFlash:Hide()
    parent.cooldownFlash.anim = parent.cooldownFlash:CreateAnimationGroup()
    anim = parent.cooldownFlash.anim:CreateAnimation("Alpha", nil)
    anim:SetDuration(0.25)
    anim:SetFromAlpha(0)
    anim:SetToAlpha(1)
    anim:SetOrder(1)
    anim:SetSmoothing("IN")
    anim = parent.cooldownFlash.anim:CreateAnimation("Alpha", nil)
    anim:SetDuration(1)
    anim:SetFromAlpha(1)
    anim:SetToAlpha(0)
    anim:SetOrder(2)
    anim:SetSmoothing("OUT")
    parent.cooldownFlash.anim:HookScript("OnFinished", function(self)
        self:GetParent():Hide()
    end)

    parent.timeSinceLastUpdate = 0
    parent.timeBetweenUpdates = math.random() * 0.05 + 0.05
    parent.isCooldown = false
    parent.cooldownBg:Hide()
    parent.cooldownBar:Hide()
    
    parent:HookScript("OnUpdate", function(self, elapsed)
        if self.mouseOver then
            self.button.highlight:ClearAllPoints()
            local x,y = GetCursorPosition()
            x = x / self.button:GetEffectiveScale()
            y = y / self.button:GetEffectiveScale()
            local x2,y2 = self:GetCenter()
            self.button.highlight:SetWidth(self.button:GetWidth() * 3)
            self.button.highlight:SetPoint("LEFT", UIParent, "BOTTOMLEFT", x - self.button.highlight:GetWidth() / 2, y)
            self.button.highlight:SetPoint("TOP", UIParent, "BOTTOMLEFT", 0, y2 + self:GetHeight() / 2)
            self.button.highlight:SetPoint("BOTTOM", UIParent, "BOTTOMLEFT", 0, y2 - self:GetHeight() / 2)
            self.button.highlight:Show()
        end


        if not self.isCooldown then
            self.timeSinceLastUpdate = self.timeSinceLastUpdate + elapsed
            if self.timeSinceLastUpdate < self.timeBetweenUpdates then
                return
            else
                self.timeSinceLastUpdate = 0
            end
        end
        
        if self.itemID then
            local startTime, duration, enable = GetItemCooldown(self.itemID)
            if startTime == 0 then
                if self.isCooldown then
                    self.isCooldown = false
                    self.cooldownBg:Hide()
                    self.cooldownBg.fadeIn:Stop()
                    self.cooldownBar:Hide()
                end
                return
            end
            if (not self.isCooldown) or (self.startTime ~= startTime) then
                self.isCooldown = true
                self.startTime = startTime
                self.endTime = startTime + duration
                self.duration = duration
                self.cooldownBg:Show()
                self.cooldownBg.fadeIn:Play()
                self.cooldownBar:SetMinMaxValues(startTime, self.endTime)
                self.cooldownBar:SetValue(startTime)
                self.cooldownBar:SetAlpha(0) -- Give it one frame before showing the bar, else the previous value flashes briefly
                self.cooldownBar:Show()
            else
                self.cooldownBar:SetAlpha(1)
                self.cooldownBar:SetValue(GetTime())
                -- Flash
                if GetTime() > self.endTime - 0.25 and not self.cooldownFlash.anim:IsPlaying() then
                    if self.duration <= 1 then
                        return
                    elseif self.duration < 5 then
                        parent.cooldownFlash:SetVertexColor(1*0.2,0.9*0.2,0.66*0.2)
                    else
                        parent.cooldownFlash:SetVertexColor(1,0.9,0.66)
                    end
                    self.cooldownFlash:Show()
                    self.cooldownFlash.anim:Play()
                end
            end
        end
    end)

    --[[elseif bag == REAGENTBANK_CONTAINER then
        parent.button = _G["ReagentBankFrameItem"..slot]]

    local buttonType
    if Sorted_IsClassic() then
        buttonType = "Button"
    else
        buttonType = "ItemButton"
    end

    if bag == BANK_CONTAINER then
        parent.button = CreateFrame(buttonType, frameName.."Button", parent, "BankItemButtonGenericTemplate")
    elseif bag == REAGENTBANK_CONTAINER then
        parent.button = CreateFrame(buttonType, frameName.."Button", parent, "ReagentBankItemButtonGenericTemplate")
    else
        parent.button = CreateFrame(buttonType, frameName.."Button", parent, "ContainerFrameItemButtonTemplate")
    end
    parent.button:SetScript("OnEnter", SortedItemButton_OnEnter)
    parent.button:HookScript("OnLeave", SortedTooltip.Cancel)
    parent.button.UpdateTooltip = SortedItemButton_DelayedOnEnter --SortedItemButton_OnEnter
    
    local button = parent.button
    button:SetAllPoints()
    button:SetID(slot)
    button:SetNormalTexture("")
    button:GetNormalTexture():ClearAllPoints()
    if button.NewItemTexture then
        button.BattlepayItemTexture:Hide()
        button.BattlepayItemTexture:ClearAllPoints()
        button.NewItemTexture:Hide()
        button.NewItemTexture:ClearAllPoints()
        _G[button:GetName().."IconQuestTexture"]:ClearAllPoints()
        _G[button:GetName().."IconQuestTexture"]:Hide()
    end
    if button.UpgradeIcon then
        button.UpgradeIcon = button:CreateTexture(frameName.."ButtonUpdateIcon", "ARTWORK")
        button.UpgradeIcon:SetTexture("Interface\\ContainerFrame\\Bags")
        button.UpgradeIcon:SetAtlas("bags-greenarrow", true)
    end
    --button.UpgradeIcon:SetPoint("TOP", parent, 0, -2)
    --button.UpgradeIcon:SetSize(14, 14)
    parent.UpgradeIcon = button.UpgradeIcon

    button:SetHighlightTexture("")
    button:GetHighlightTexture():ClearAllPoints()
    button:SetPushedTexture("")
    button:GetPushedTexture():ClearAllPoints()
    button:Show()
    
    if not Sorted_IsClassic() then
        button.LevelLinkLockTexture:ClearAllPoints()
        button.LevelLinkLockTexture:Hide()
    end
    _G[button:GetName().."IconTexture"]:ClearAllPoints()
    _G[button:GetName().."IconTexture"]:Hide()

    button.pushed = button:CreateTexture("")
    button.pushed:SetTexture("Interface\\Addons\\Sorted\\Textures\\UI-Highlight")
    button.pushed:SetTexCoord(0.4, 0.7, 0, 1)
    button.pushed:SetBlendMode("ADD")
    button.pushed:SetAlpha(0)
    button.pushed:SetAllPoints()
    button.pushed:Hide()

    -- Mouseover highlight animations
    button.highlight = button:CreateTexture("")
    button.highlight:SetTexture("Interface\\Addons\\Sorted\\Textures\\UI-Highlight")
    --button.highlight:SetTexCoord(0.4, 1, 0, 1)
    button.highlight:SetBlendMode("ADD")
    button.highlight:SetAlpha(0)
    button.highlight:ClearAllPoints()
    button.highlight:SetWidth(2000)
    button.highlight:Hide()

    button.fadeIn = button:CreateAnimationGroup()
    anim = button.fadeIn:CreateAnimation("Alpha", nil)
    anim:SetDuration(0.1)
    anim:SetFromAlpha(0.5)
    anim:SetToAlpha(1)
    anim:SetOrder(1)
    anim:SetChildKey("highlight")
    anim = button.fadeIn:CreateAnimation("Alpha", nil)
    anim:SetDuration(0.2)
    anim:SetFromAlpha(1)
    anim:SetToAlpha(0.7)
    anim:SetOrder(2)
    anim:SetChildKey("highlight")
    button.fadeIn:HookScript("OnFinished", function(self) self:GetParent().highlight:SetAlpha(0.7) end)

    button.fadeOut = button:CreateAnimationGroup()
    anim = button.fadeOut:CreateAnimation("Alpha", nil)
    anim:SetDuration(0)
    anim:SetFromAlpha(0)
    anim:SetToAlpha(0)
    anim:SetChildKey("highlight")
    button.fadeOut:HookScript("OnFinished", function(self) 
        self:GetParent().highlight:Hide() 
        --self:GetParent().wobble:Pause() 
        self:GetParent().highlight:ClearAllPoints()
    end)
    button.fadeOutAnim = anim

    --[[button.wobble = button:CreateAnimationGroup()
    button.wobble:SetLooping("REPEAT")
    anim = button.wobble:CreateAnimation("Translation", nil)
    anim:SetDuration(2)
    anim:SetOffset(-50, 0)
    anim:SetOrder(1)
    anim:SetSmoothing("OUT")
    anim:SetChildKey("highlight")
    anim = button.wobble:CreateAnimation("Translation", nil)
    anim:SetDuration(4)
    anim:SetOffset(100, 0)
    anim:SetOrder(2)
    anim:SetSmoothing("IN_OUT")
    anim:SetChildKey("highlight")
    anim = button.wobble:CreateAnimation("Translation", nil)
    anim:SetDuration(2)
    anim:SetOffset(-50, 0)
    anim:SetOrder(3)
    anim:SetSmoothing("IN")
    anim:SetChildKey("highlight")]]

    function button:ShowHighlight()
        if Sorted_GetSetting("animations") == 2 then
            --self.fadeOut:Stop()
            --self.wobble:Play() 
            self.fadeIn:Play() 
        end
        --self.highlight:Show()
    end
    function button:HideHighlight()
        self.fadeIn:Stop() 
        if Sorted_GetSetting("animations") == 2 then
            self.fadeOut:Play()
        else
            self.highlight:ClearAllPoints()
            self.highlight:Hide()
        end
    end

    parent.iconFrame = CreateFrame("Frame", parent:GetName().."IconFrame", parent)
    parent.itemIcon = parent.iconFrame:CreateTexture(parent:GetName().."IconTexture", "OVERLAY")
    parent.itemIcon:SetAllPoints()
    parent.itemIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
    --parent.itemIcon:SetMask("Interface\\Buttons\\UI-RotationLeft-Button-Up")
    --parent.itemIcon:SetBlendMode("ADD")
    button.iconFrame = parent.iconFrame
    button.itemIcon = parent.itemIcon

    parent.iconGlow = parent.iconFrame:CreateTexture(parent:GetName().."IconGlowTexture", "ARTWORK")
    parent.iconGlow:SetTexture("Interface\\Addons\\Sorted\\Textures\\Item_Glow")
    parent.iconGlow:SetPoint("CENTER")
    parent.iconGlow:SetBlendMode("ADD")
    parent.iconGlow:Hide()
    button.iconGlow = parent.iconGlow

    parent.iconShadow = parent.iconFrame:CreateTexture(parent:GetName().."IconShadowTexture", "BORDER")
    parent.iconShadow:SetTexture("Interface\\Addons\\Sorted\\Textures\\Item_Shadow")
    parent.iconShadow:SetPoint("TOPLEFT", -12, 12)
    parent.iconShadow:SetPoint("BOTTOMRIGHT", 12, -12)
    parent.iconShadow:Hide()
    button.iconShadow = parent.iconShadow

    button.text = parent.nameString

    parent.iconFrame.zoomIn = parent.iconFrame:CreateAnimationGroup()
    anim = parent.iconFrame.zoomIn:CreateAnimation("Scale", nil)
    anim:SetDuration(0.1)
    anim:SetFromScale(1,1)
    anim:SetToScale(1.4, 1.4)
    anim:SetOrder(1)
    anim:SetSmoothing("IN_OUT")
    parent.iconFrame.zoomIn:HookScript("OnFinished", function(self) 
        self:GetParent().zoomLoop:Play()
    end)

    parent.iconFrame.zoomLoop = parent.iconFrame:CreateAnimationGroup()
    parent.iconFrame.zoomLoop:SetLooping("REPEAT")
    anim = parent.iconFrame.zoomLoop:CreateAnimation("Scale", nil)
    anim:SetDuration(0)
    anim:SetFromScale(1.4, 1.4)
    anim:SetToScale(1.4, 1.4)
    anim:SetOrder(1)

    parent.iconFrame.zoomOut = parent.iconFrame:CreateAnimationGroup()
    anim = parent.iconFrame.zoomOut:CreateAnimation("Scale", nil)
    anim:SetDuration(0)
    anim:SetFromScale(1.4, 1.4)
    anim:SetToScale(1, 1)
    anim:SetOrder(1)
    anim:SetSmoothing("IN_OUT")

    button.zoomIn = parent.iconFrame.zoomIn
    button.zoomLoop = parent.iconFrame.zoomLoop
    button.zoomOut = parent.iconFrame.zoomOut

    local nameFrame = parent.nameFrame
    button.nameFrame = nameFrame
    button.indentText = nameFrame:CreateAnimationGroup()
    anim = button.indentText:CreateAnimation("Translation", nil)
    anim:SetDuration(0.1)
    anim:SetOffset(5, 0)
    anim:SetSmoothing("IN_OUT")
    button.indentText:HookScript("OnFinished", function(self)
        self:GetParent():SetPoint("LEFT", self:GetParent().leftX + 5, 0)
        self:GetParent():SetPoint("RIGHT", self:GetParent().rightX + 5, 0)
    end)

    button:HookScript("OnEnter", function(self)
        self:GetParent().mouseOver = true
        self:ShowHighlight()
        self.zoomOut:Stop()
        if not self:GetParent().filtered then
            if Sorted_GetSetting("animations") == 2 then
                self.zoomIn:Play()
                if self:GetParent().itemList.isScrolling then
                    self.nameFrame:SetPoint("LEFT", self.nameFrame.leftX + 5, 0)
                    self.nameFrame:SetPoint("RIGHT", self.nameFrame.rightX + 5, 0)
                else
                    self.indentText:Play()
                end
            else
                self.zoomLoop:Play()
                self.nameFrame:SetPoint("LEFT", self.nameFrame.leftX + 5, 0)
                self.nameFrame:SetPoint("RIGHT", self.nameFrame.rightX + 5, 0)
            end
            self.iconFrame:SetParent(self:GetParent():GetParent():GetParent())
            --self:GetParent().nameString:SetFontObject("Sorted12Font")
            self.iconGlow:Show()
            self.iconShadow:Show()
        end
        --self.itemIcon:SetBlendMode("BLEND")
        self.nameFrame:SetFrameLevel(self:GetParent():GetFrameLevel() + 11)
        self.iconFrame:SetFrameLevel(self:GetParent():GetFrameLevel() + 10)
        local r,g,b = Sorted_GetItemQualityHighlightTextColor(self:GetParent().quality)
        self:GetParent().nameString:SetTextColor(r,g,b)
    end)
    button:HookScript("OnLeave", function(self)
        self:GetParent().mouseOver = false
        self:HideHighlight()
        self.zoomIn:Stop()
        self.zoomLoop:Stop()
        if Sorted_GetSetting("animations") == 2 then
            self.zoomOut:Play()
        end
        self.indentText:Stop()
        self.nameFrame:SetPoint("LEFT", self.nameFrame.leftX, 0)
        self.nameFrame:SetPoint("RIGHT", self.nameFrame.rightX, 0)
        --self.itemIcon:SetBlendMode("ADD")
        if Sorted_GetSetting("iconBorders") == 1 or self:GetParent().filtered then
            self.iconGlow:Hide()
        end
        self.iconShadow:Hide()
        self.nameFrame:SetFrameLevel(self:GetParent():GetFrameLevel() + 1)
        self.iconFrame:SetParent(self)
        self.iconFrame:SetFrameLevel(self:GetParent():GetFrameLevel() + 1)
        local r,g,b = Sorted_GetItemQualityColor(self:GetParent().quality)
        self:GetParent().nameString:SetTextColor(r,g,b)
        --self:GetParent().nameString:SetFontObject("Sorted11Font")
        r,g,b = Sorted_GetItemQualityHighlightColor(self:GetParent().quality)
        self.iconGlow:SetVertexColor(r, g, b, 1)
    end)

    button:HookScript("OnMouseDown", function(self)
        if self:IsEnabled() then
            self.pushed:Show()
            local r,g,b = Sorted_GetItemQualityHighlightTextColor(self:GetParent().quality)
            self.iconGlow:SetVertexColor(r, g, b, 1)
            r,g,b = r^0.3,g^0.3,b^0.3
            self:GetParent().nameString:SetTextColor(r,g,b)
        end
    end)
    button:HookScript("OnMouseUp", function(self)
        if self:IsEnabled() then
            self.pushed:Hide()
            local r,g,b = Sorted_GetItemQualityHighlightTextColor(self:GetParent().quality)
            self:GetParent().nameString:SetTextColor(r,g,b)
            r,g,b = Sorted_GetItemQualityHighlightColor(self:GetParent().quality)
            self.iconGlow:SetVertexColor(r, g, b, 1)
        end
    end)
    button:HookScript("OnDragStop", function(self)
        self.pushed:Hide()
    end)

    return parent
end