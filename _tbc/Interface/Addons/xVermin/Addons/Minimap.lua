local _, xVermin = ...
local count

Minimap:ClearAllPoints()
Minimap:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -40, -20)

UIWidgetBelowMinimapContainerFrame:HookScript("OnUpdate", function(self)
	UIWidgetBelowMinimapContainerFrame:ClearAllPoints()
	UIWidgetBelowMinimapContainerFrame:SetPoint("TOPRIGHT", "UIParent", "TOPRIGHT", -35, 4)

	if nHealthStatusBar and nHealthStatusBar:IsVisible() then
		UIWidgetTopCenterContainerFrame:ClearAllPoints()
		UIWidgetTopCenterContainerFrame:SetPoint("TOP", "UIParent", "TOP", 0, -70)
	end
end)

xVermin.CheckIfLoadedWithTimer("LFGMinimapFrame", function()
	LFGMinimapFrame:Hide()
	LFGMinimapFrame:ClearAllPoints()
	LFGMinimapFrame:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 0, 20)
	LFGMinimapFrame:HookScript("OnShow", function()
		LFGMinimapFrame:Hide()
	end)
end)

xVermin.CheckIfLoadedWithTimer("MiniMapTracking", function()
	MiniMapTracking:Hide()
	MiniMapTracking:ClearAllPoints()
	MiniMapTracking:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", -27, 20)
	MiniMapTracking:HookScript("OnShow", function()
		MiniMapTracking:Hide()
	end)
end)

MiniMapBattlefieldFrame:HookScript("OnUpdate", function(self)
	MiniMapBattlefieldFrame:ClearAllPoints()
	MiniMapBattlefieldFrame:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", -40, -7)
end)

GameTimeFrame:HookScript("OnUpdate", function(self)
	GameTimeFrame:ClearAllPoints()
	GameTimeFrame:SetPoint("BOTTOMLEFT", Minimap, "BOTTOMLEFT", 17, -3)
	GameTimeFrame:SetSize(20, 20)

	for i, v in pairs({
		select(1, GameTimeFrame:GetRegions()),
	}) do
		if v then
			v:SetVertexColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)
		end
	end
end)
