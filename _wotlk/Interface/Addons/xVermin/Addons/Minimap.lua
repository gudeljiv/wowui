local _, xVermin = ...
local count

Minimap:ClearAllPoints()
Minimap:SetPoint('TOPRIGHT', UIParent, 'TOPRIGHT', -40, -40)

-- Minimap:HookScript(
-- 	'OnLoad',
-- 	function(self)
-- 		if not Minimap.SetBackdrop then
-- 			Mixin(Minimap, BackdropTemplateMixin)
-- 		end
-- 	end
-- )

MiniMapWorldMapButton:HookScript(
	'OnShow',
	function(self)
		MiniMapWorldMapButton:Hide()
	end
)

MiniMapLFGFrame:HookScript(
	'OnShow',
	function(self)
		MiniMapLFGFrame:ClearAllPoints()
		MiniMapLFGFrame:SetPoint('BOTTOMRIGHT', Minimap, 'BOTTOMRIGHT', 0, 0)
	end
)

MiniMapBattlefieldFrame:HookScript(
	'OnShow',
	function(self)
		MiniMapBattlefieldFrame:ClearAllPoints()
		MiniMapBattlefieldFrame:SetPoint('BOTTOMRIGHT', Minimap, 'BOTTOMRIGHT', 0, 0)
	end
)

GameTimeFrame:HookScript(
	'OnShow',
	function(self)
		if not GameTimeFrame.SetBackdrop then
			Mixin(GameTimeFrame, BackdropTemplateMixin)
		end
		GameTimeFrame:CreateBeautyBorder(8)
		GameTimeFrame:SetBackdrop(
			{
				bgFile = 'Interface\\Buttons\\WHITE8x8',
				edgeFile = '',
				tile = false,
				tileSize = 0,
				edgeSize = 0,
				insets = {left = 0, right = 0, top = 0, bottom = 0}
			}
		)
		GameTimeFrame:SetBackdropColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 0.2)
		GameTimeFrame:ClearAllPoints()
		GameTimeFrame:SetPoint('TOPLEFT', Minimap, 'TOPLEFT', 5, -5)
		GameTimeFrame:SetSize(20, 20)
	end
)
