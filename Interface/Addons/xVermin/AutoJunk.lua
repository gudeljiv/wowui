local _, xVermin = ...

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

local function AutoSellJunk()
	for bag = 0, 4 do
		for slot = 1, GetContainerNumSlots(bag) do
			local name = GetContainerItemLink(bag, slot)

			if name then
				_, _, itemRarity, _, _, _, _, itemStackCount, _, _, itemSellPrice = GetItemInfo(name)
				if itemRarity == 0 then
					DEFAULT_CHAT_FRAME:AddMessage("Selling " .. name)
					UseContainerItem(bag, slot)
				end
			end
		end
	end
end

-- local f = CreateFrame("frame")
-- f:SetScript("OnEvent", AutoSellJunk)
-- f:RegisterEvent("MERCHANT_SHOW")
