local _, xVermin = ...

local f = CreateFrame('frame')
f:RegisterEvent('BAG_OPEN')
f:RegisterEvent('BAG_UPDATE')
f:SetScript(
	'OnEvent',
	function(self, event, isInitialLogin, isReloadingUi)
		for i = 1, 1000 do
			if _G['AdiBagsItemButton' .. i .. 'Count'] then
				_G['AdiBagsItemButton' .. i .. 'Count']:SetScale(0.8)
			end
		end
	end
)
