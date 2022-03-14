local _, xVermin = ...

local AutoCarrot = {
	TrinketID = nil,
	Enabled = true
}

local function AC()
	if not AutoCarrot.Enabled then
		return
	end

	local itemId = GetInventoryItemID('player', 13)

	if IsMounted() then
		if itemId and itemId ~= 11122 then
			AutoCarrot.TrinketID = itemId
			EquipItemByName(11122, 13)
		else
			AutoCarrot.TrinketID = nil
			EquipItemByName(11122, 13)
		end
	else
		if itemId then
			if itemId ~= 11122 then
				AutoCarrot.TrinketID = itemId
			elseif AutoCarrot.TrinketID then
				EquipItemByName(AutoCarrot.TrinketID, 13)
			end
		else
			AutoCarrot.TrinketID = nil
		end
	end
end

local f = CreateFrame('Frame')
f:SetScript('OnUpdate', AC)

SLASH_AUTOCARROT1 = '/ac'
SlashCmdList['AUTOCARROT'] = function(msg)
	AutoCarrot.Enabled = not AutoCarrot.Enabled
	print('|cffed9121AutoCarrot: |cff' .. (AutoCarrot.Enabled and 'ff0000disabled' or '1eff00enabled'))
end
