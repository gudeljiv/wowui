local _, xVermin = ...

local function Skin()
	for item = 1, GetMerchantNumItems() do
		local name, texture, price, quantity, numAvailable, isUsable, extendedCost = GetMerchantItemInfo(item)

		if not name then
			C_Timer.After(0.1, Skin)
			return
		end

		local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemIcon, itemSellPrice, itemClassID, itemSubClassID, bindType, expacID, itemSetID, isCraftingReagent = GetItemInfo(GetMerchantItemLink(item))
		local itemButton = _G['MerchantItem' .. item .. 'ItemButton']
		local merchantButton = _G['MerchantItem' .. item]
		local merchantMoney = _G['MerchantItem' .. item .. 'MoneyFrame']
		local merchantAltCurrency = _G['MerchantItem' .. item .. 'AltCurrencyFrame']
		local slotTexture = _G['MerchantItem' .. item .. 'SlotTexture']

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
end

local MerchantFrameHooked = false
local addonLoadedFrame = CreateFrame('Frame')
addonLoadedFrame:RegisterEvent('ADDON_LOADED')
addonLoadedFrame:SetScript(
	'OnEvent',
	function(self, event, arg1, ...)
		if not MerchantFrameHooked then
			hooksecurefunc(MerchantFrame, 'Show', Skin)
			MerchantFrameHooked = true
		end
	end
)

-- /run print(GetItemInfo(_G["MerchantItem1ItemButton"]))
