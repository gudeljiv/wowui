local _, xVermin = ...

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("UI_SCALE_CHANGED")
f:SetScript("OnEvent", function(self, event)
	if not InCombatLockdown() then
		-- C_CVar.SetCVar("uiScale", tostring(xVermin.Config.UIscale))

		UIParent:SetScale(xVermin.Config.UIscale)
	else
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
	end

	if event == "PLAYER_REGEN_ENABLED" then
		self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	end
end)
