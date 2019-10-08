local type = 8

local function clear_mark()
    for i=1,9 do SetRaidTarget("player",i) end
end

local function set_mark()
    clear_mark()

	local faction = "nil"
	if TargetFrame:IsShown() then
		faction, _ = UnitFactionGroup("target")

		if faction ~= "Alliance" then
			if(UnitInParty("player") and UnitIsGroupLeader("player")) then
				SetRaidTarget("target", type)
			elseif(not UnitInParty("player")) then
				SetRaidTarget("target", type)
			end
		end
	end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:SetScript("OnEvent", set_mark)

clear_mark()