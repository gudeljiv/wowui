local _, xVermin = ...

local GOLD = '|cFFE6BF42'
local SILVER = '|cFF939193'
local COPPER = '|cFFAD6C4C'
local WHITE = '|cFFFFFFFF'

local function HandleItem(self, ...)
	local _, itemLink = self:GetItem()
	if itemLink ~= nil then
		local itemId, _, _, _, _, _, _ = GetItemInfoInstant(itemLink)
		local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expacID, setID, isCraftingReagent = GetItemInfo(itemLink)
		local itemcount
		if itemId then
			self:AddLine(' ')
			self:AddLine(_G.ORANGE_FONT_COLOR_CODE .. 'Item ID:|r ' .. _G.NORMAL_FONT_COLOR_CODE .. itemId .. '|r')
			if itemLevel then
				-- self:AddDoubleLine(_G.ORANGE_FONT_COLOR_CODE .. 'Item ID:|r ' .. _G.NORMAL_FONT_COLOR_CODE .. itemId .. '|r', _G.ORANGE_FONT_COLOR_CODE .. 'Item Level:|r ' .. _G.NORMAL_FONT_COLOR_CODE .. itemLevel .. '|r')
				local line = _G[self:GetName() .. 'TextLeft1']
				if line:GetText() == 'Currently Equipped' then
					line = _G[self:GetName() .. 'TextLeft2']
				end
				local lineText = line:GetText()
				if not string.find(lineText, '%(') then
					line:SetText(lineText .. ' (|r' .. _G.NORMAL_FONT_COLOR_CODE .. itemLevel .. '|r)')
				end
				if string.find(lineText, 'Pattern: ') then
					for i = 1, GameTooltip:NumLines() do
						if _G['GameTooltipTextLeft' .. i] == string.gsub(lineText, 'Pattern: ', '') then
						end
					end
				end
			else
				-- self:AddDoubleLine(_G.ORANGE_FONT_COLOR_CODE .. 'Item ID:|r ' .. _G.NORMAL_FONT_COLOR_CODE .. itemId .. '|r', _G.ORANGE_FONT_COLOR_CODE .. 'Item Level:|r ' .. _G.NORMAL_FONT_COLOR_CODE .. '-' .. '|r')
				-- self:AddLine(_G.ORANGE_FONT_COLOR_CODE .. 'Item ID:|r ' .. _G.NORMAL_FONT_COLOR_CODE .. itemId .. '|r')
			end
			if sellPrice and sellPrice > 0 then
				itemcount = GetItemCount(itemId)
				if itemcount > 1 then
					itempriceTotal = sellPrice * itemcount
					self:AddDoubleLine(_G.ORANGE_FONT_COLOR_CODE .. 'Vendor price:|r ' .. WHITE .. GetMoneyString(sellPrice) .. '|r', _G.ORANGE_FONT_COLOR_CODE .. itemcount .. 'x:|r ' .. WHITE .. GetMoneyString(itempriceTotal) .. '|r')
				else
					self:AddLine(_G.ORANGE_FONT_COLOR_CODE .. 'Vendor price:|r ' .. WHITE .. GetMoneyString(sellPrice) .. '|r')
				end
				self:AddLine(' ')
			else
				self:AddLine(' ')
			end
		end
	end
end

for _, tooltip in pairs(
	{
		GameTooltip,
		ItemRefTooltip,
		ItemRefShoppingTooltip1,
		ItemRefShoppingTooltip2,
		ShoppingTooltip1,
		ShoppingTooltip2,
		ShoppingTooltip3,
		AtlasLootTooltip
	}
) do
	xVermin.CheckIfLoadedWithTimer(
		tooltip:GetName(),
		function()
			tooltip:HookScript('OnTooltipSetItem', HandleItem)
		end
	)
end
