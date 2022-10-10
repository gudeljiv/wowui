--- Add_Simple_Item_ID to the tooltip
local function Add_Item_Id(tooltip)
	local _, itemLink = tooltip:GetItem()
	if (itemLink ~= nil) then
		local itemId, _, _, _, _, _, _ = GetItemInfoInstant(itemLink)
		if itemId then
			tooltip:AddLine(' ')
			tooltip:AddLine(_G.ORANGE_FONT_COLOR_CODE .. 'Item ID: ' .. _G.WHITE_FONT_COLOR_CODE .. itemId)
		end
	end
end

--- Hook to Tooltip
GameTooltip:HookScript('OnTooltipSetItem', Add_Item_Id)
