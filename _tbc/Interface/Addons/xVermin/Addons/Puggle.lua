local _, xVermin = ...

local f = CreateFrame('Frame')
f:SetScript(
	'OnEvent',
	function(self, event, isInitialLogin, isReloadingUi)
		if isInitialLogin or isReloadingUi then
			if (IsAddOnLoaded('Puggle')) then
				if not Puggle_ContainerFrame.SetBackdrop then
					Mixin(Puggle_ContainerFrame, BackdropTemplateMixin)
				end
				Puggle_ContainerFrame:CreateBeautyBorder(8)
				Puggle_ContainerFrame:SetBackdrop(
					{
						bgFile = xVermin.Config.background.white,
						edgeFile = '',
						tile = false,
						tileSize = 0,
						edgeSize = 0,
						insets = {left = 0, right = 0, top = 0, bottom = 0}
					}
				)
				Puggle_ContainerFrame:SetBackdropColor(0, 0, 0, 0.9)
			end
		end
	end
)
f:RegisterEvent('PLAYER_ENTERING_WORLD')
