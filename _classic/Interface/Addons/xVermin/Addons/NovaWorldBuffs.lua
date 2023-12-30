local _, xVermin = ...
local text = ''

xVermin.CheckIfLoadedWithTimer(
	'MinimapLayerFrame',
	function()
		MinimapLayerFrame:SetScript(
			'OnUpdate',
			function(self)

				MinimapLayerFrame:ClearAllPoints()
				MinimapLayerFrame:SetPoint("TOP", Minimap, "TOP", 0, -5)
				MinimapLayerFrameFS:Show()
				MinimapLayerFrameLeft:Hide()
				MinimapLayerFrameMiddle:Hide()
				MinimapLayerFrameRight:Hide()


				-- text = MinimapLayerFrameFS:GetText()
				-- if (text == 'No Layer') then
				-- 	MinimapLayerFrameFS:SetText('NL')
				-- end

				-- MinimapLayerFrameFS:SetText(text:gsub('Layer ', 'L'))
				-- if (NWB.isLayered) then
				-- 	MinimapLayerFrame.tooltip:Show()
				-- 	if (NWB.db.global.minimapLayerHover) then
				-- 		MinimapLayerFrame:Show()
				-- 	end
				-- end
			end
		)
	end
)
