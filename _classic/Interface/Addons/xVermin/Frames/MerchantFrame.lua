local _, xVermin = ...

local function SkinItem(item, itemLink)
	if not item or not itemLink then
		return
	end

	local itemButton = _G['MerchantItem' .. item .. 'ItemButton']
	local itemButtonCount = _G['MerchantItem' .. item .. 'ItemButtonCount']
	local merchantButton = _G['MerchantItem' .. item]
	local merchantMoney = _G['MerchantItem' .. item .. 'MoneyFrame']
	local merchantAltCurrency = _G['MerchantItem' .. item .. 'AltCurrencyFrame']
	local slotTexture = _G['MerchantItem' .. item .. 'SlotTexture']
	local r, g, b

	local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemIcon, itemSellPrice, itemClassID, itemSubClassID, bindType, expacID, itemSetID, isCraftingReagent = GetItemInfo(itemLink)

	if itemButton then
		itemButtonCount:SetScale(0.8)
		slotTexture:Hide()

		itemButton:CreateBeautyBorder(8)
		itemButton:SetBeautyBorderTexture('default')
		itemButton:SetBeautyBorderColor(1, 1, 1, 1)

		if itemQuality and itemQuality > 1 then
			r, g, b = GetItemQualityColor(itemQuality)
			itemButton:SetBeautyBorderTexture('white')
			itemButton:SetBeautyBorderColor(r, g, b)
		end
	end
end

local function HandleItems()
	if MerchantFrame.selectedTab == 1 then
		local numMerchantItems = GetMerchantNumItems()
		for i = 1, MERCHANT_ITEMS_PER_PAGE do
			local index = (((MerchantFrame.page - 1) * MERCHANT_ITEMS_PER_PAGE) + i)
			if (index <= numMerchantItems) then
				local itemLink = GetMerchantItemLink(index)
				SkinItem(i, itemLink)
			end
		end
	else
		local numBuybackItems = GetNumBuybackItems()
		for index = 1, BUYBACK_ITEMS_PER_PAGE do
			if (index <= numBuybackItems) then
				local itemLink = GetBuybackItemLink(index)
				SkinItem(index, itemLink)
			end
		end
	end
end

MerchantFrame:HookScript('OnShow', HandleItems)
MerchantFrame:HookScript('OnUpdate', HandleItems)

xSellGems = function()
	for bag = 0, 4, 1 do
		for slot = 1, C_Container.GetContainerNumSlots(bag), 1 do
			local name = C_Container.GetContainerItemLink(bag, slot)
			if name and (string.find(name, 'Balanced Shadow Crystal') or string.find(name, 'Perfect Balanced Shadow Crystal') or string.find(name, 'Dazzling Dark Jade') or string.find(name, 'Perfect Dazzling Dark Jade')) then
				C_Timer.After(
					0.1,
					function()
						C_Container.UseContainerItem(bag, slot)
					end
				)
			end
		end
	end
end
