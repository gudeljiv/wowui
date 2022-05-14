local _, xVermin = ...

local f = CreateFrame("Frame")
f:SetScript(
	"OnEvent",
	function(self, event, isInitialLogin, isReloadingUi)
		if isInitialLogin or isReloadingUi then
			if (IsAddOnLoaded("RangeDisplay")) then
				if _G["RangeDisplayMainFrame_playertarget"] ~= nil then
					RangeDisplayMainFrame_playertarget:SetPoint("CENTER", UIParent, "CENTER", 0, -20)
					RangeDisplayMainFrame_playertarget.ClearAllPoints = function()
					end
					RangeDisplayMainFrame_playertarget.SetPoint = function()
					end
				end
				if _G["RangeDisplayMainFrame_mouseover"] ~= nil then
					RangeDisplayMainFrame_mouseover:SetPoint("CENTER", UIParent, "CENTER", 0, -35)
					RangeDisplayMainFrame_mouseover.ClearAllPoints = function()
					end
					RangeDisplayMainFrame_mouseover.SetPoint = function()
					end
				end
			end
		end
	end
)
f:RegisterEvent("PLAYER_ENTERING_WORLD")
