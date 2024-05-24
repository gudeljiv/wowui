local _, xVermin = ...

xVermin.CheckIfLoadedWithTimer(
	'SpellActivationOverlayContainerFrame',
	function()
		SpellActivationOverlayContainerFrame:ClearAllPoints()
		SpellActivationOverlayContainerFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 100)
	end
)
