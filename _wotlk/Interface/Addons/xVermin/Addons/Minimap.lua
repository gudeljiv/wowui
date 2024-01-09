local _, xVermin = ...
local count

Minimap:ClearAllPoints()
Minimap:SetPoint('TOPRIGHT', UIParent, 'TOPRIGHT', -40, -40)

UIWidgetBelowMinimapContainerFrame:HookScript(
	'OnUpdate',
	function(self)
		UIWidgetBelowMinimapContainerFrame:ClearAllPoints()
		UIWidgetBelowMinimapContainerFrame:SetPoint('TOPRIGHT', 'UIParent', 'TOPRIGHT', -35, 4)

		if (nHealthStatusBar and nHealthStatusBar:IsVisible()) then
			UIWidgetTopCenterContainerFrame:ClearAllPoints()
			UIWidgetTopCenterContainerFrame:SetPoint('TOP', 'UIParent', 'TOP', 0, -70)
		end
	end
)

MiniMapWorldMapButton:HookScript(
	'OnShow',
	function(self)
		MiniMapWorldMapButton:Hide()
	end
)

MiniMapLFGFrame:HookScript(
	'OnUpdate',
	function(self)
		if MiniMapBattlefieldFrame and MiniMapBattlefieldFrame:IsVisible() then
			MiniMapLFGFrame:ClearAllPoints()
			MiniMapLFGFrame:SetPoint('BOTTOM', MiniMapBattlefieldFrame, 'BOTTOM', -1, 30)
		else
			MiniMapLFGFrame:ClearAllPoints()
			MiniMapLFGFrame:SetPoint('BOTTOMRIGHT', MinimapCluster, 'BOTTOMRIGHT', -40, -7)
		end
	end
)

MiniMapBattlefieldFrame:HookScript(
	'OnUpdate',
	function(self)
		MiniMapBattlefieldFrame:ClearAllPoints()
		MiniMapBattlefieldFrame:SetPoint('BOTTOMRIGHT', MinimapCluster, 'BOTTOMRIGHT', -40, -7)
	end
)

GameTimeFrame:HookScript(
	'OnUpdate',
	function(self)
		GameTimeFrame:ClearAllPoints()
		GameTimeFrame:SetPoint('BOTTOMLEFT', MinimapCluster, 'BOTTOMLEFT', 17, -3)
		GameTimeFrame:SetSize(20, 20)

		for i, v in pairs(
			{
				select(1, GameTimeFrame:GetRegions())
			}
		) do
			if v then
				v:SetVertexColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)
			end
		end
	end
)
