--- Add_Simple_Item_ID to the tooltip
local function Add_Item_Id(tooltip)
	local _, itemLink = tooltip:GetItem()
	if (itemLink ~= nil) then
		local itemId, _, _, _, _, _, _ = GetItemInfoInstant(itemLink)
		if itemId then
			tooltip:AddLine('Item ID: ' .. itemId)
		end
	end
end

--- Hook to Tooltip
GameTooltip:HookScript('OnTooltipSetItem', Add_Item_Id)
