
local type = 8

local function srt()
	if(UnitInParty("player")) then
		if(UnitIsGroupLeader("player")) then
			SetRaidTarget("player", type)
			if TargetFrame:IsShown() then
				SetRaidTarget("target", type)
			end
		end
	else
		if TargetFrame:IsShown() then
			SetRaidTarget("target", type)
		else
			SetRaidTarget("player", type)
		end
	end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:SetScript("OnEvent", srt)