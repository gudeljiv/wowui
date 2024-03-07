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

		if autoroll then 
			-- if itemId == 43102 then 
			-- 	ConfirmLootRoll(id, 1)
			-- end

			if quality == 2 then
				ConfirmLootRoll(id, canDE and 3 or 2)
			end
		end


	end
)

SlashCmdList['AUTOROLL'] = function()
	autoroll = not autoroll
	ChatFrame7:AddMessage('Autoroll ' .. (autoroll and 'on' or 'off'))
end
SLASH_AUTOROLL1 = '/ar'


local g = CreateFrame("Frame")
g:RegisterEvent("LOOT_BIND_CONFIRM")
g:SetScript("OnEvent", function(self, event, id)
	-- if GetNumRaidMembers() == 0 and GetNumPartyMembers() == 0 then
		local elapsed = 0
		self:SetScript("OnUpdate", function(self, elap)
			elapsed = elapsed + elap
			if elapsed < 0.2 then
				StaticPopup_Hide("LOOT_BIND")
				return
			end
			elapsed = 0
			ConfirmLootSlot(id)
		end)
	-- end
end)