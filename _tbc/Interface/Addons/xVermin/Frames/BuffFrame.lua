local _, xVermin = ...

local x = -35
local y = -24

xVermin.CheckIfLoadedWithTimer("BuffFrame", function()
	BuffFrame:ClearAllPoints()
	BuffFrame:SetPoint("TOPRIGHT", MinimapCluster, "TOPLEFT", x, y)

	local isUpdating = false
	hooksecurefunc(BuffFrame, "SetPoint", function()
		if isUpdating then
			return
		end

		local currentPoint, currentRelativeTo, currentRelativePoint, currentX, currentY = BuffFrame:GetPoint()
		if currentX ~= x or currentY ~= y or currentPoint ~= "MinimapCluster" then
			isUpdating = true
			BuffFrame:SetPoint("TOPRIGHT", MinimapCluster, "TOPLEFT", x, y)
			isUpdating = false
		end
	end)
end)
