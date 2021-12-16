local _, xVermin = ...

local f = CreateFrame("Frame")
f:SetScript(
	"OnEvent",
	function(self, event, isInitialLogin, isReloadingUi)
		if isInitialLogin or isReloadingUi then
			if (IsAddOnLoaded("MonkeyQuest")) then
				if not MonkeyQuestFrame.SetBackdrop then
					Mixin(MonkeyQuestFrame, BackdropTemplateMixin)
				end
				MonkeyQuestFrame:ClearAllPoints()
				MonkeyQuestFrame:SetPoint("TOPRIGHT", "CustomContainer_2", "BOTTOMRIGHT", 0, -10)
				MonkeyQuestFrame:CreateBeautyBorder(8)
				MonkeyQuestFrame:SetBackdrop(
					{
						bgFile = "Interface\\Buttons\\WHITE8x8",
						edgeFile = "",
						tile = false,
						tileSize = 0,
						edgeSize = 0,
						insets = {left = 0, right = 0, top = 0, bottom = 0}
					}
				)
				MonkeyQuestFrame:SetBackdropColor(0, 0, 0, 0.6)
				MonkeyQuestFrame.ClearAllPoints = function()
				end
				MonkeyQuestFrame.SetPoint = function()
				end

				if not MkQL_Main_Frame.SetBackdrop then
					Mixin(MkQL_Main_Frame, BackdropTemplateMixin)
				end
				MkQL_Main_Frame:SetBackdrop(
					{
						bgFile = "Interface\\Buttons\\WHITE8x8",
						edgeFile = "",
						tile = false,
						tileSize = 0,
						edgeSize = 0,
						insets = {left = 0, right = 0, top = 0, bottom = 0}
					}
				)
				MkQL_Main_Frame:SetBackdropColor(0, 0, 0, 0.6)
				MkQL_Main_Frame:CreateBeautyBorder(8)
			end
		end
	end
)
f:RegisterEvent("PLAYER_ENTERING_WORLD")
