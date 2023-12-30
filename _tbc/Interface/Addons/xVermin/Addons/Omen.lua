local _, xVermin = ...

local f = CreateFrame('Frame')
f:SetScript(
	'OnEvent',
	function(self, event, isInitialLogin, isReloadingUi)
		if isInitialLogin or isReloadingUi then
			if (IsAddOnLoaded('Omen')) then
				local OriginalSetPointOmen = getmetatable(OmenAnchor).__index.SetPoint
				local function MoveOmen(self)
					self:ClearAllPoints()
					OriginalSetPointOmen(self, 'CENTER', 0, -237)
				end
				hooksecurefunc(OmenAnchor, 'SetPoint', MoveOmen)
				MoveOmen(OmenAnchor)
			end
		end
	end
)
f:RegisterEvent('PLAYER_ENTERING_WORLD')
