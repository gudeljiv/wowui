local GOLD = '|cFFE6BF42'
local SILVER = '|cFF939193'
local COPPER = '|cFFAD6C4C'
local WHITE = '|cFFFFFFFF'

local function AddItemID(tooltip)
	local _, itemLink = tooltip:GetItem()
	if (itemLink ~= nil) then
		local itemId, _, _, _, _, _, _ = GetItemInfoInstant(itemLink)
		local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expacID, setID, isCraftingReagent = GetItemInfo(itemLink)
		-- local itemprice = select(11, GetItemInfo(itemLink))
		local itemcount
		if itemId then
			tooltip:AddLine(' ')
			tooltip:AddDoubleLine(_G.ORANGE_FONT_COLOR_CODE .. 'Item ID:|r ' .. _G.NORMAL_FONT_COLOR_CODE .. itemId .. '|r', _G.ORANGE_FONT_COLOR_CODE .. 'Item Level:|r ' .. _G.NORMAL_FONT_COLOR_CODE .. itemLevel .. '|r')
			if sellPrice and sellPrice > 0 then
				itemcount = GetItemCount(itemId)
				itempriceTotal = sellPrice * itemcount

				-- g = floor(itemprice / 1e4)
				-- s = floor(itemprice / 100 % 100)
				-- c = itemprice % 100

				-- gt = floor(itempriceTotal / 1e4)
				-- st = floor(itempriceTotal / 100 % 100)
				-- ct = itempriceTotal % 100

				-- itempriceFormatted = WHITE .. g .. GOLD .. 'g|r ' .. WHITE .. s .. SILVER .. 's|r ' .. WHITE .. c .. COPPER .. 'c|r'
				-- itempriceTotalFormatted = WHITE .. gt .. GOLD .. 'g|r ' .. WHITE .. st .. SILVER .. 's |r' .. WHITE .. ct .. COPPER .. 'c|r'
				-- tooltip:AddLine(_G.ORANGE_FONT_COLOR_CODE .. 'Vendor price:|r ' .. itempriceFormatted .. ' ' .. _G.ORANGE_FONT_COLOR_CODE .. '(|r' .. itempriceTotalFormatted .. _G.ORANGE_FONT_COLOR_CODE .. ')|r')
				tooltip:AddDoubleLine(_G.ORANGE_FONT_COLOR_CODE .. 'Vendor price (1x):|r ' .. WHITE .. GetMoneyString(sellPrice) .. '|r', _G.ORANGE_FONT_COLOR_CODE .. '(' .. itemcount .. 'x):|r ' .. WHITE .. GetMoneyString(itempriceTotal) .. '|r')
				tooltip:AddLine(' ')
			else
				tooltip:AddLine(' ')
			end
		end
	end
end

--- Hook to Tooltip
GameTooltip:HookScript('OnTooltipSetItem', AddItemID)
