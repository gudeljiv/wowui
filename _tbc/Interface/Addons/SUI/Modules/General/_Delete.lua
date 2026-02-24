local Module = SUI:NewModule("General.Delete")

function Module:OnEnable()
	local db = SUI.db.profile.general.automation.delete
	if db then
		hooksecurefunc(StaticPopupDialogs["DELETE_GOOD_ITEM"], "OnShow", function(s)
			local editBox = _G[s:GetName() .. "EditBox"]
			if editBox then
				editBox:SetText(DELETE_ITEM_CONFIRM_STRING)
			end
		end)
	end
end
