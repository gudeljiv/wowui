local _, xVermin = ...

local scaler = CreateFrame("Frame")
scaler:RegisterEvent("VARIABLES_LOADED")
scaler:RegisterEvent("UI_SCALE_CHANGED")
scaler:SetScript(
	"OnEvent",
	function(self, event)
		if not InCombatLockdown() then
			-- -- pixel perfect ???!??!
			-- local scale = 768 / string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)")

			-- -- override that works for me
			-- scale = 0.6
			-- if scale < .64 then
			-- 	UIParent:SetScale(scale)
			-- else
			-- 	self:UnregisterEvent("UI_SCALE_CHANGED")
			-- 	SetCVar("uiScale", scale)
			-- end
			UIParent:SetScale(xVermin.Config.UIscale)
		else
			self:RegisterEvent("PLAYER_REGEN_ENABLED")
		end

		if event == "PLAYER_REGEN_ENABLED" then
			self:UnregisterEvent("PLAYER_REGEN_ENABLED")
		end
	end
)
