local _, xVermin = ...

xVermin.CheckIfLoadedWithTimer(
	'scanner_button',
	function()
		scanner_button:ClearAllPoints()
		scanner_button:SetPoint('TOP', UIParent, 'TOP', 0, -20)
	end
)

