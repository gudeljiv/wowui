local _, xVermin = ...

xVermin.CheckIfLoadedWithTimer("LibDBIcon10_Open-Sesame", function()
	local frame = _G["LibDBIcon10_Open-Sesame"]
	frame:Hide()

	frame:HookScript("OnShow", function(self)
		self:Hide()
	end)
end)
