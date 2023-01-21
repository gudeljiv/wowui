local _, xVermin = ...

local GOLD = '|cFFE6BF42'
local SILVER = '|cFF939193'
local COPPER = '|cFFAD6C4C'
local WHITE = '|cFFFFFFFF'

local function AddItemID(self, ...)
	local name, itemLink = self:GetItem()
	if (itemLink ~= nil) then
		local itemId, _, _, _, _, _, _ = GetItemInfoInstant(itemLink)
		local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expacID, setID, isCraftingReagent = GetItemInfo(itemLink)
		local itemcount
		if itemId then
			self:AddLine(' ')
			if itemLevel then
				-- self:AddDoubleLine(_G.ORANGE_FONT_COLOR_CODE .. 'Item ID:|r ' .. _G.NORMAL_FONT_COLOR_CODE .. itemId .. '|r', _G.ORANGE_FONT_COLOR_CODE .. 'Item Level:|r ' .. _G.NORMAL_FONT_COLOR_CODE .. itemLevel .. '|r')
				local line = _G[self:GetName() .. 'TextLeft1'] --name
				local text = line:GetText()
				line:SetText(text .. ' (|r' .. _G.NORMAL_FONT_COLOR_CODE .. itemLevel .. '|r)')
			else
				-- self:AddDoubleLine(_G.ORANGE_FONT_COLOR_CODE .. 'Item ID:|r ' .. _G.NORMAL_FONT_COLOR_CODE .. itemId .. '|r', _G.ORANGE_FONT_COLOR_CODE .. 'Item Level:|r ' .. _G.NORMAL_FONT_COLOR_CODE .. '-' .. '|r')
				self:AddLine(_G.ORANGE_FONT_COLOR_CODE .. 'Item ID:|r ' .. _G.NORMAL_FONT_COLOR_CODE .. itemId .. '|r')
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

-- --- Hook to Tooltip
-- GameTooltip:HookScript('OnTooltipSetItem', AddItemID_Tooltip)
-- GameTooltip:HookScript('OnTooltipSetItem', AddItemID_Tooltip)
-- hooksecurefunc('ItemRefTooltip.UpdateTooltip', AddItemID_ItemRefTooltip)
-- -- TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, AddItemID)

xVermin.CheckIfLoadedWithTimer(
	'GameTooltip',
	function()
		GameTooltip:HookScript('OnTooltipSetItem', AddItemID)
	end
)

xVermin.CheckIfLoadedWithTimer(
	'ShoppingTooltip1',
	function()
		ShoppingTooltip1:HookScript('OnTooltipSetItem', AddItemID)
	end
)

xVermin.CheckIfLoadedWithTimer(
	'ShoppingTooltip2',
	function()
		ShoppingTooltip2:HookScript('OnTooltipSetItem', AddItemID)
	end
)

xVermin.CheckIfLoadedWithTimer(
	'ShoppingTooltip3',
	function()
		ShoppingTooltip3:HookScript('OnTooltipSetItem', AddItemID)
	end
)

xVermin.CheckIfLoadedWithTimer(
	'ItemRefTooltip',
	function()
		ItemRefTooltip:HookScript('OnTooltipSetItem', AddItemID)
	end
)
