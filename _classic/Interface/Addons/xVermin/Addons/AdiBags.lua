local _, xVermin = ...

function LBI()
	for bagID = 0, NUM_BAG_SLOTS do
		for slot = 1, GetContainerNumSlots(bagID) do
			texture, itemCount, locked, quality, readable, lootable, itemLink = GetContainerItemInfo(bagID, slot)
			if itemLink then
				itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(itemLink)
				itemID = GetItemInfoInstant(itemName)

				print(itemCount, itemID, itemName, itemLevel, itemType, itemSubType)
			end
			-- if GetContainerItemID(i, z) == itemID then
			-- 	local _, duration = GetContainerItemCooldown(i, z)
			-- 	if duration == 0 then
			-- 		print('Item is ready!')
			-- 	else
			-- 		print('Cooldown is ' .. duration)
			-- 	end
			-- 	break
			-- end
		end
	end
end

local f = CreateFrame('frame')
f:RegisterEvent('BAG_OPEN')
f:RegisterEvent('BAG_UPDATE')
f:SetScript(
	'OnEvent',
	function(self, event, isInitialLogin, isReloadingUi)
		-- xVermin.CheckIfLoadedWithTimer(
		-- 	'AdiBagsContainer1',
		-- 	function()
		-- AdiBagsContainer1SearchBox.Left:Hide()
		-- AdiBagsContainer1SearchBox.Right:Hide()
		-- AdiBagsContainer1SearchBox.Middle:Hide()
		-- AdiBagsContainer1SearchBoxSearchIcon:Hide()
		-- AdiBagsContainer1SearchBox:CreateBeautyBorder(8)
		-- AdiBagsContainer1SearchBox:Hide()
		-- 	end,
		-- 	0.1
		-- )

		for i = 1, 1000 do
			if _G['AdiBagsItemButton' .. i .. 'Count'] then
				_G['AdiBagsItemButton' .. i .. 'Count']:SetScale(0.8)
				_G['AdiBagsItemButton' .. i .. 'Count']:ClearAllPoints()
				_G['AdiBagsItemButton' .. i .. 'Count']:SetPoint("BOTTOMRIGHT", _G['AdiBagsItemButton' .. i], "BOTTOMRIGHT", -1, 2)
			end
		end
	end
)




