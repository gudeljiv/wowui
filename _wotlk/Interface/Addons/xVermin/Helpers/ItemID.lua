local GOLD = '|cFFE6BF42'
local SILVER = '|cFF939193'
local COPPER = '|cFFAD6C4C'
local WHITE = '|cFFFFFFFF'

local function AddItemID(tooltip)
	local _, itemLink = tooltip:GetItem()
	if (itemLink ~= nil) then
		local itemId, _, _, _, _, _, _ = GetItemInfoInstant(itemLink)
		local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expacID, setID, isCraftingReagent = GetItemInfo(itemLink)
		local itemcount
		if itemId then
			tooltip:AddLine(' ')
			if itemLevel then
				tooltip:AddDoubleLine(_G.ORANGE_FONT_COLOR_CODE .. 'Item ID:|r ' .. _G.NORMAL_FONT_COLOR_CODE .. itemId .. '|r', _G.ORANGE_FONT_COLOR_CODE .. 'Item Level:|r ' .. _G.NORMAL_FONT_COLOR_CODE .. itemLevel .. '|r')
			else
				tooltip:AddDoubleLine(_G.ORANGE_FONT_COLOR_CODE .. 'Item ID:|r ' .. _G.NORMAL_FONT_COLOR_CODE .. itemId .. '|r', _G.ORANGE_FONT_COLOR_CODE .. 'Item Level:|r ' .. _G.NORMAL_FONT_COLOR_CODE .. '-' .. '|r')
			end
			if sellPrice and sellPrice > 0 then
				itemcount = GetItemCount(itemId)
				if itemcount > 0 then
					itempriceTotal = sellPrice * itemcount
					tooltip:AddDoubleLine(_G.ORANGE_FONT_COLOR_CODE .. 'Vendor price:|r ' .. WHITE .. GetMoneyString(sellPrice) .. '|r', _G.ORANGE_FONT_COLOR_CODE .. itemcount .. 'x:|r ' .. WHITE .. GetMoneyString(itempriceTotal) .. '|r')
				else
					tooltip:AddLine(_G.ORANGE_FONT_COLOR_CODE .. 'Vendor price:|r ' .. WHITE .. GetMoneyString(sellPrice) .. '|r')
				end
				tooltip:AddLine(' ')
			else
				tooltip:AddLine(' ')
			end
		end
	end
end

--- Hook to Tooltip
GameTooltip:HookScript('OnTooltipSetItem', AddItemID)
