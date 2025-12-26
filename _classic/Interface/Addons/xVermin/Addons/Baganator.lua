local _, xVermin = ...

function LBI()
	for bagID = 0, NUM_BAG_SLOTS do
		for slot = 1, GetContainerNumSlots(bagID) do
			texture, itemCount, locked, quality, readable, lootable, itemLink = GetContainerItemInfo(bagID, slot)
			if itemLink then
				itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice =
					GetItemInfo(itemLink)
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

-- local f = CreateFrame('frame')
-- f:RegisterEvent('BAG_OPEN')
-- f:RegisterEvent('BAG_UPDATE')
-- f:RegisterEvent('BAG_UPDATE_DELAYED')
-- f:RegisterEvent('BANKFRAME_OPENED')
-- f:SetScript(
-- 	'OnEvent',
-- 	function(self, event, isInitialLogin, isReloadingUi)
-- 		-- xVermin.CheckIfLoadedWithTimer(
-- 		-- 	'AdiBagsContainer1',
-- 		-- 	function()
-- 		-- AdiBagsContainer1SearchBox.Left:Hide()
-- 		-- AdiBagsContainer1SearchBox.Right:Hide()
-- 		-- AdiBagsContainer1SearchBox.Middle:Hide()
-- 		-- AdiBagsContainer1SearchBoxSearchIcon:Hide()
-- 		-- AdiBagsContainer1SearchBox:CreateBeautyBorder(8)
-- 		-- AdiBagsContainer1SearchBox:Hide()
-- 		-- 	end,
-- 		-- 	0.1
-- 		-- )

-- 		for i = 1, 2000 do
-- 			local frame_live = 'BGRLiveItemButton' .. i
-- 			local frame_cached = 'BGRLiveItemButton' .. i
-- 			-- print(frame)
-- 			if _G[frame_live] then
-- 				_G[frame_live]:CreateBeautyBorder(8)
-- 			end
-- 			if _G[frame_cached] then
-- 				_G[frame_cached]:CreateBeautyBorder(8)
-- 			end
-- 		end
-- 	end
-- )

-- local function update()
-- 	for i = 1, 2000 do
-- 		local frame_live = 'BGRLiveItemButton' .. i
-- 		local frame_cached = 'BGRCachedItemButton' .. i
-- 		if _G[frame_live] then
-- 			_G[frame_live]:CreateBeautyBorder(8)
-- 		end
-- 		if _G[frame_cached] then
-- 			_G[frame_cached]:CreateBeautyBorder(8)
-- 		end
-- 	end
-- end

xVermin.CheckIfLoadedWithTimer("Baganator_CategoryViewBackpackViewFrame", function()
	Baganator_CategoryViewBackpackViewFrame:CreateBeautyBorder(8)
end)

xVermin.CheckIfLoadedWithTimer("Baganator_CategoryViewBankViewFrame", function()
	Baganator_CategoryViewBankViewFrame:CreateBeautyBorder(8)
end)

-- Baganator_CategoryViewBackpackViewFrame:HookScript(
-- 	'OnShow',
-- 	function(self)
-- 		update()
-- 	end
-- )

-- Baganator_CategoryViewBackpackViewFrame:HookScript(
-- 	'OnUpdate',
-- 	function(self)
-- 		update()
-- 	end
-- )

-- Baganator_CategoryViewBankViewFrame:HookScript(
-- 	'OnShow',
-- 	function(self)
-- 		update()
-- 	end
-- )

-- Baganator_CategoryViewBankViewFrame:HookScript(
-- 	'OnUpdate',
-- 	function(self)
-- 		update()
-- 	end
-- )
