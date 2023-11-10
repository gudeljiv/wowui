local _, xVermin = ...

local autoroll = true

local fr = CreateFrame('Frame', nil, UIParent)
fr:RegisterEvent('START_LOOT_ROLL')
fr:RegisterEvent('CONFIRM_LOOT_ROLL')
fr:SetScript(
	'OnEvent',
	function(self, event, id)
		if not id then
			return
		end
		local _, name, _, quality, bop, _, _, canDE = GetLootRollItemInfo(id)
		-- local _, _, _, itemLevel = GetItemInfo(name)
		-- print(id, name, itemLevel)
		if quality == 2 and autoroll then
			ConfirmLootRoll(id, canDE and 3 or 2)
			ChatFrame1:AddMessage('Autoroll on item: ' .. (name))
		end
	end
)

SlashCmdList['AUTOROLL'] = function()
	autoroll = not autoroll
	ChatFrame7:AddMessage('Autoroll ' .. (autoroll and 'on' or 'off'))
end
SLASH_AUTOROLL1 = '/ar'
