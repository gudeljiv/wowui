local _, xVermin = ...

xVermin.CheckIfLoadedWithTimer("LibDBIcon10_PoisonCharges", function()
	LibDBIcon10_PoisonCharges:Hide()
end)

if IsAddOnLoaded("Bistooltip") then
	SLASH_BISTOOLTIP1 = "/bt"
	SlashCmdList["BISTOOLTIP"] = function()
		BistooltipAddon:createMainFrame()
	end
end
