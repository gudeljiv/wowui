local _, xVermin = ...
local count

Minimap:ClearAllPoints()
Minimap:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -40, -19)

UIWidgetBelowMinimapContainerFrame:HookScript("OnUpdate", function(self)
	UIWidgetBelowMinimapContainerFrame:ClearAllPoints()
	UIWidgetBelowMinimapContainerFrame:SetPoint("TOPRIGHT", "UIParent", "TOPRIGHT", -35, 4)

	if nHealthStatusBar and nHealthStatusBar:IsVisible() then
		UIWidgetTopCenterContainerFrame:ClearAllPoints()
		UIWidgetTopCenterContainerFrame:SetPoint("TOP", "UIParent", "TOP", 0, -70)
	end
end)

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function()
	if MiniMapWorldMapButton then
		MiniMapWorldMapButton:HookScript("OnShow", function(self)
			self:Hide()
		end)
	end
end)

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function()
	if not MiniMapLFGFrame then
		return
	end

	MiniMapLFGFrame:HookScript("OnUpdate", function(self)
		if MiniMapBattlefieldFrame and MiniMapBattlefieldFrame:IsVisible() then
			self:ClearAllPoints()
			self:SetPoint("BOTTOM", MiniMapBattlefieldFrame, "BOTTOM", -1, 30)
		elseif MinimapCluster then
			self:ClearAllPoints()
			self:SetPoint("BOTTOMRIGHT", MinimapCluster, "BOTTOMRIGHT", -40, -7)
		end
	end)
end)

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function()
	if not MiniMapBattlefieldFrame or not MinimapCluster then
		return
	end

	MiniMapBattlefieldFrame:HookScript("OnUpdate", function(self)
		self:ClearAllPoints()
		self:SetPoint("BOTTOMRIGHT", MinimapCluster, "BOTTOMRIGHT", -40, -7)
	end)
end)

if GameTimeFrame then
	GameTimeFrame:HookScript("OnUpdate", function(self)
		GameTimeFrame:ClearAllPoints()
		GameTimeFrame:SetPoint("BOTTOMLEFT", MinimapCluster, "BOTTOMLEFT", 17, -3)
		GameTimeFrame:SetSize(20, 20)

		for i, v in pairs({
			select(1, GameTimeFrame:GetRegions()),
		}) do
			if v then
				v:SetVertexColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)
			end
		end
	end)
end

MinimapCompassTexture:HookScript("OnShow", function(self)
	MinimapCompassTexture:Hide()
end)
