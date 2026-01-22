local _, xVermin = ...

xVermin.CheckIfLoadedWithTimer("LibDBIcon10_Selly", function()
	LibDBIcon10_Selly:Hide()
end)

xVermin.CheckIfLoadedWithTimer("LibDBIcon10_Open-Sesame", function()
	local icon = _G["LibDBIcon10_Open-Sesame"]
	if icon then
		icon:Hide()
	end
end)
