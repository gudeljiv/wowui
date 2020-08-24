local _, xVermin = ...

local tDelay = 0
local function FastLoot()
	if GetTime() - tDelay >= 0.3 then
		tDelay = GetTime()
		if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
			for i = GetNumLootItems(), 1, -1 do
				LootSlot(i)
			end
			tDelay = GetTime()
		end
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("LOOT_READY")
f:SetScript("OnEvent", FastLoot)
