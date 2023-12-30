local _, xVermin = ...

local f = CreateFrame('Frame')
f:SetScript(
	'OnEvent',
	function(self, event, isInitialLogin, isReloadingUi)
		if isInitialLogin or isReloadingUi then
			if (IsAddOnLoaded('Recount')) then
				Recount_MainWindow:Show()
				Recount_MainWindow:ClearAllPoints()
				Recount_MainWindow:SetMovable(true)
				Recount_MainWindow:SetUserPlaced(true)
				Recount_MainWindow:SetWidth(300)
				Recount_MainWindow:SetHeight(110)
				Recount_MainWindow:SetPoint('TOPLEFT', UIParent, 'TOPLEFT', 5, 7)

				Recount_MainWindow.ClearAllPoints = function()
				end
				Recount_MainWindow.SetPoint = function()
				end
			end
		end
	end
)
f:RegisterEvent('PLAYER_ENTERING_WORLD')
