local _, xVermin = ...

local delay = 0
local fastloot = false
local function FastLoot()
	if fastloot and GetTime() - delay >= 0.3 then
		delay = GetTime()
		if GetCVarBool('autoLootDefault') ~= IsModifiedClick('AUTOLOOTTOGGLE') then
			for i = GetNumLootItems(), 1, -1 do
				LootSlot(i)
			end
			delay = GetTime()
		end
	end
end

local f = CreateFrame('Frame')
f:RegisterEvent('LOOT_READY')
f:SetScript('OnEvent', FastLoot)

SLASH_FASTLOOT1 = '/fl'
SlashCmdList['FASTLOOT'] = function()
	fastloot = not fastloot
	ChatFrame7:AddMessage('FastLoot ' .. (fastloot and '|cff00ff00enabled|r' or '|cffff0000disabled|r'))
end
