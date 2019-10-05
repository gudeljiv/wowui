
local type = 2

local function srt()
	SetRaidTarget("player", type)
	SetRaidTarget("player", 0)
	if(UnitInParty("player")) then
		if(UnitIsGroupLeader("player")) then
			if TargetFrame:IsShown() then SetRaidTarget("target", type) end
		end
	else
		if TargetFrame:IsShown() then SetRaidTarget("target", type) end
	end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:SetScript("OnEvent", srt)