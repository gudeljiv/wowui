local _, xVermin = ...

if C_AddOns.IsAddOnLoaded("SUI") then
	xVermin.CheckIfLoadedWithTimer("StatsFrame", function()
		StatsFrame:ClearAllPoints()
		StatsFrame:SetPoint("BOTTOM", MinimapCluster, "TOP", -40, -17)

		local isUpdating = false
		hooksecurefunc(StatsFrame, "SetPoint", function()
			if isUpdating then
				return
			end

			local currentPoint, currentRelativeTo, currentRelativePoint, currentX, currentY = StatsFrame:GetPoint()
			if currentX ~= -40 or currentY ~= -17 or currentPoint ~= "MinimapCluster" then
				isUpdating = true
				StatsFrame:SetPoint("BOTTOM", MinimapCluster, "TOP", -40, -17)
				isUpdating = false
			end
		end)
	end)

	-- for i = 1, NUM_CHAT_WINDOWS do
	-- 	local copyFrame = "ChatFrame" .. i .. ".Copy"
	-- 	local chatFrame = "ChatFrame" .. i

	-- 	ChatFrame1.Copy:ClearAllPoints()
	-- 	ChatFrame1.Copy:SetPoint("TOPRIGHT", ChatFrame1, "TOPRIGHT", 0, 1)
	-- end
end
