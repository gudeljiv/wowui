local _, xVermin = ...

local f = CreateFrame("Frame")
f:SetScript(
	"OnEvent",
	function(self, event, isInitialLogin, isReloadingUi)
		if isInitialLogin or isReloadingUi then
			if (IsAddOnLoaded("Details_TinyThreat")) then
				C_Timer.After(
					10,
					function()
						Details_TinyThreat:ClearAllPoints()
						Details_TinyThreat:SetPoint("TOPRIGHT", "ChatFrame3", "TOPLEFT", -2, 2)
					end
				)
			end
		end
	end
)
f:RegisterEvent("PLAYER_ENTERING_WORLD")
