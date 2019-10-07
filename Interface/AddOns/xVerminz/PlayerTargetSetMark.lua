local type = 8

local function clear_mark()
    for i=1,9 do SetRaidTarget("player",i) end
end

local function set_mark()
    clear_mark()

	if(UnitInParty("player")) then
		if(UnitIsGroupLeader("player")) then
			if TargetFrame:IsShown() then
				SetRaidTarget("target", type)
			end
		end
	else
		if TargetFrame:IsShown() then
			SetRaidTarget("target", type)
		end
	end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:SetScript("OnEvent", set_mark)

clear_mark()