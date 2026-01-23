local _, xVermin = ...

if C_AddOns.IsAddOnLoaded("SUI") then
	xVermin.CheckIfLoadedWithTimer("StatsFrame", function()
		local function AnchorStatsFrame()
			if not StatsFrame or not MinimapCluster then
				return
			end

			StatsFrame:ClearAllPoints()
			StatsFrame:SetPoint("BOTTOM", MinimapCluster, "TOP", -40, -17)
		end

		-- initial
		AnchorStatsFrame()

		-- re-apply on common “UI/layout got rebuilt” moments
		local f = CreateFrame("Frame")
		f:RegisterEvent("PLAYER_ENTERING_WORLD") -- fires on login, /reload, zone/instance transitions
		f:RegisterEvent("ZONE_CHANGED_NEW_AREA") -- continent/instance switch
		f:RegisterEvent("UI_SCALE_CHANGED") -- sometimes triggers relayout
		f:RegisterEvent("DISPLAY_SIZE_CHANGED") -- resolution / window mode changes

		f:SetScript("OnEvent", function()
			-- do it now
			AnchorStatsFrame()

			-- and again shortly after, to win vs late layout passes/addons
			C_Timer.After(0.1, AnchorStatsFrame)
			C_Timer.After(0.5, AnchorStatsFrame)
		end)
	end)
end
