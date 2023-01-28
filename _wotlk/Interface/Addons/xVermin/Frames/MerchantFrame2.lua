local _, xVermin = ...

local function SkinItem(item, itemLink)
	local itemButton = _G['MerchantItem' .. item .. 'ItemButton']
	local merchantButton = _G['MerchantItem' .. item]
	local merchantMoney = _G['MerchantItem' .. item .. 'MoneyFrame']
	local merchantAltCurrency = _G['MerchantItem' .. item .. 'AltCurrencyFrame']
	local slotTexture = _G['MerchantItem' .. item .. 'SlotTexture']

	local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemIcon, itemSellPrice, itemClassID, itemSubClassID, bindType, expacID, itemSetID, isCraftingReagent = GetItemInfo(itemLink)

	if (itemButton ~= nil) then
		itemButton:CreateBeautyBorder(8)
		slotTexture:Hide()

		if itemQuality and itemQuality > 1 then
			local r, g, b = GetItemQualityColor(itemQuality)
			itemButton:SetBeautyBorderTexture('white')
			itemButton:SetBeautyBorderColor(r, g, b)
		end
	end
end

local function HandleItems()
	if (MerchantFrame.selectedTab == 1) then
		local numMerchantItems = GetMerchantNumItems()
		for i = 1, MERCHANT_ITEMS_PER_PAGE do
			local index = (((MerchantFrame.page - 1) * MERCHANT_ITEMS_PER_PAGE) + i)
			local item = _G['MerchantItem' .. i]
			if (index <= numMerchantItems) then
				local itemLink = GetMerchantItemLink(index)
				SkinItem(item, itemLink)
			end
		end
	else
		local numBuybackItems = GetNumBuybackItems()
		for index = 1, BUYBACK_ITEMS_PER_PAGE do
			local item = _G['MerchantItem' .. index]
			if (index <= numBuybackItems) then
				local itemLink = GetBuybackItemLink(index)
				SkinItem(item, itemLink)
			end
		end
	end
end

local MerchantFrameHooked = false
local addonLoadedFrame = CreateFrame('Frame')
addonLoadedFrame:RegisterEvent('ADDON_LOADED')
addonLoadedFrame:SetScript(
	'OnEvent',
	function(self, event, arg1, ...)
		if not MerchantFrameHooked then
			hooksecurefunc(MerchantFrame, 'Show', HandleItems)
			hooksecurefunc(MerchantFrame, 'Update', HandleItems)
			MerchantFrameHooked = true
		end
	end
)
