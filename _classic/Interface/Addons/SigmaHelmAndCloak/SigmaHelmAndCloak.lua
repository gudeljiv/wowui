local _, SHC = ...;

-- Event Frame
SHC.EventFrame = CreateFrame("Frame");

function SHC.EventFrame:OnLoad()
	SHC.EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
	SHC.EventFrame:RegisterEvent("UNIT_INVENTORY_CHANGED");
	SHC.EventFrame:SetScript("OnEvent", SHC.OnEvent);
end

function SHC:OnEvent(event, arg1)
	if event == "PLAYER_ENTERING_WORLD" then
		SHC:Update();
	end
	if event == "UNIT_INVENTORY_CHANGED" and arg1 == "player" then
		SHC:Update();
	end
end

SHC.EventFrame:OnLoad();
