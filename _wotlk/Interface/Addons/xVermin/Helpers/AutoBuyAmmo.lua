local _, xVermin = ...

local function BuyAmmo()
	local index, TypeOfAmmo, BowEquipped, GunEquipped, MaxAmmoInInventory, MaxStackSize
	local numItems = GetMerchantNumItems()
	local playerLevel = UnitLevel('player')

	ammoLevel = 0

	-- if playerLevel >= 1 then
	-- 	ammoLevel = 1
	-- end
	-- if playerLevel > 9 then
	-- 	ammoLevel = 10
	-- end
	-- if playerLevel > 24 then
	-- 	ammoLevel = 25
	-- end
	-- if playerLevel > 39 then
	-- 	ammoLevel = 40
	-- end
	-- if playerLevel > 54 then
	-- 	ammoLevel = 55
	-- end

	if xVermin.Class ~= ('HUNTER' or 'WARRIOR') then
		return
	end
	BowEquipped = IsEquippedItemType('Bows') or IsEquippedItemType('Crossbows')
	GunEquipped = IsEquippedItemType('Guns')

	if BowEquipped then
		TypeOfAmmo = 'Arrow'
	end
	if GunEquipped then
		TypeOfAmmo = 'Bullet'
	end

	-- for item = 1, numItems do
	-- 	local name, texture, price, quantity, numAvailable, isUsable, extendedCost = GetMerchantItemInfo(item)
	-- 	if not name then
	-- 		C_Timer.After(0.1, BuyAmmo)
	-- 		return
	-- 	end
	-- 	local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemIcon, itemSellPrice, itemClassID, itemSubClassID, bindType, expacID, itemSetID, isCraftingReagent = GetItemInfo(GetMerchantItemLink(item))
	-- 	ammoLevel = ammoLevel < itemMinLevel and itemMinLevel or ammoLevel
	-- end

	for item = 1, numItems do
		local name, texture, price, quantity, numAvailable, isUsable, extendedCost = GetMerchantItemInfo(item)

		if not name then
			C_Timer.After(0.1, BuyAmmo)
			return
		end

		local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemIcon, itemSellPrice, itemClassID, itemSubClassID, bindType, expacID, itemSetID, isCraftingReagent = GetItemInfo(GetMerchantItemLink(item))

		if itemSubType == TypeOfAmmo and isUsable and itemMinLevel <= playerLevel then
			index = item
			MaxStackSize = itemStackCount
		end
	end

	local buy = true
	if index and buy then
		MaxAmmoInInventory = MaxStackSize
		if xVermin.Class == 'HUNTER' then
			-- MaxAmmoInInventory = GetContainerNumSlots(1) * MaxStackSize
			MaxAmmoInInventory = 8000
		end
		local ammoCount = GetInventoryItemCount('player', GetInventorySlotInfo('AmmoSlot'))
		local needtobuy = MaxAmmoInInventory - ammoCount

		if needtobuy > 0 then
			local remainder = needtobuy % 255
			local buys = (needtobuy - remainder) / 255

			if remainder > 0 then
				BuyMerchantItem(index, remainder)
			end

			if buys > 0 then
				for _ = 1, buys do
					BuyMerchantItem(index, 255)
				end
			end
		end
	end
end

-- local f = CreateFrame('Frame')
-- f:RegisterEvent('MERCHANT_SHOW')
-- f:SetScript('OnEvent', BuyAmmo)
