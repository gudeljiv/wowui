local _, xVermin = ...

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
		if quality == 2 then
			ConfirmLootRoll(id, canDE and 3 or 2)
		-- print("You rolled on the item with name: " .. name )
		end
	end
)
