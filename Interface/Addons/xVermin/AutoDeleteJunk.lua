-- local i, n = 0
-- for b = 0, 4 do
-- 	for s = 1, GetContainerNumSlots(b) do
-- 		ClearCursor()
-- 		i = {GetContainerItemInfo(b, s)}
-- 		n = i[7]
-- 		if n and string.find(n, "9d9d9d") then
-- 			PickupContainerItem(b, s)
-- 			DeleteCursorItem()
-- 		end
-- 	end
-- end

local function AutoDeleteJunk()
	for bag = 0, 4 do
		for slot = 1, GetContainerNumSlots(bag) do
			local name = GetContainerItemLink(bag, slot)
			ClearCursor()

			if name then
				_, _, itemRarity, _, _, _, _, itemStackCount, _, _, itemSellPrice = GetItemInfo(name)
				if itemRarity == 0 then
					PickupContainerItem(bag, slot)
					DeleteCursorItem()
				end
			end
		end
	end
end

-- local f = CreateFrame("frame")
-- f:SetScript("OnEvent", AutoDeleteJunk)
-- f:RegisterEvent("MERCHANT_SHOW")
