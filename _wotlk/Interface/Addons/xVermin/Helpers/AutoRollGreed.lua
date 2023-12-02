local _, xVermin = ...
local autoroll = true
local fr = CreateFrame('Frame', nil, UIParent)
fr:RegisterEvent('START_LOOT_ROLL')
fr:RegisterEvent('CONFIRM_LOOT_ROLL')
-- fr:RegisterEvent('CONFIRM_DISENCHANT_ROLL')
fr:SetScript(
	'OnEvent',
	function(self, event, id)
		if not id then
			return
		end
		local _, name, _, quality, bop, _, _, canDE = GetLootRollItemInfo(id)
		local itemLink = GetLootRollItemLink(id)
		local _, _, _, itemLevel = GetItemInfo(itemLink)
		local itemId = GetItemInfoInstant(itemLink)

		if autoroll then
			if itemId == 43102 then 
				ConfirmLootRoll(id, 1)
			end
			-- if itemLevel <= 200 then 
			-- 	ConfirmLootRoll(id, canDE and 3 or 2)
			-- end
			if quality == 2 then
				ConfirmLootRoll(id, canDE and 3 or 2)
			end
		end
	end
)

SlashCmdList['AUTOROLL'] = function()
	autoroll = not autoroll
	ChatFrame7:AddMessage('Autoroll: ' .. (autoroll and _G.GREEN_FONT_COLOR_CODE .. 'on|r' or _G.RED_FONT_COLOR_CODE .. 'off|r'))
end
SLASH_AUTOROLL1 = '/ar'

