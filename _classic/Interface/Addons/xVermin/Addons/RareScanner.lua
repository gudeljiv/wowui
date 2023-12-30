local _, xVermin = ...

xVermin.CheckIfLoadedWithTimer(
	'scanner_button',
	function()
		scanner_button:ClearAllPoints()
		scanner_button:SetPoint('TOP', UIParent, 'TOP', 400, -300)
		scanner_button:CreateBeautyBorder(8)
	end
)

