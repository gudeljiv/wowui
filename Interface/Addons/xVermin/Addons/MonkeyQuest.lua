local _, xVermin = ...

local f = CreateFrame("Frame")
f:SetScript(
	"OnEvent",
	function(self, event, isInitialLogin, isReloadingUi)
		if isInitialLogin or isReloadingUi then
			if (IsAddOnLoaded("MonkeyQuest")) then
				MonkeyQuestFrame:ClearAllPoints()
				MonkeyQuestFrame:SetPoint("TOPRIGHT", "CustomContainer_2", "TOPLEFT", -10, 0)
				MonkeyQuestFrame:CreateBeautyBorder(8)
				MonkeyQuestFrame.ClearAllPoints = function()
				end
				MonkeyQuestFrame.SetPoint = function()
				end
			end
		end
	end
)
f:RegisterEvent("PLAYER_ENTERING_WORLD")
