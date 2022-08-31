local _, xVermin = ...

local delay = 0
local function FastLoot()
	if GetTime() - delay >= 0.3 then
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
