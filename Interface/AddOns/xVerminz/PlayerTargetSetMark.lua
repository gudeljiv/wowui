
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:SetScript("OnEvent", function(self, event, ...)
	SetRaidTarget("player", 6)
	SetRaidTarget("player", 0)
	if TargetFrame:IsShown() then SetRaidTarget("target", 6) end
end)

