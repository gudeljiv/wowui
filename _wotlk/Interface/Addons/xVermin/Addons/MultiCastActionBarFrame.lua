local _, xVermin = ...

xVermin.CheckIfLoadedWithTimer(
	'MultiCastActionBarFrame',
	function()
		MultiCastActionBarFrame:ClearAllPoints()
		MultiCastActionBarFrame:SetPoint('BOTTOMLEFT', MultiBarBottomRightButton1, 'TOPLEFT', 0, 5)
	end
)
