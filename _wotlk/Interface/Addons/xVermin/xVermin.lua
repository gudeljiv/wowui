local _, xVermin = ...

local function xInstallAddon()
	SetCVar('autoQuestWatch', 1)
	SetCVar('autoQuestProgress', 1)
	SetCVar('instantQuestText', 1)
	SetCVar('nameplateMaxDistance', 80)
	SetCVar('ffxGlow', 1)
	SetCVar('ffxDeath', 0)
	SetCVar('ffxNether', 0)
	SetCVar('violenceLevel', 5)
	SetCVar('cameraDistanceMax', 50)
	SetCVar('cameraDistanceMaxFactor', 4.0)
	SetCVar('cameraDistanceMaxZoomFactor', 4.0)
	SetCVar('chatClassColorOverride', 0)
	SetCVar('ShowClassColorInFriendlyNameplate', 1)
	SetCVar('scriptErrors', 1)
	SetCVar('alwaysShowActionBars', 1)
	SetCVar('AutoInteract', 0)
	SetCVar('cursorsizepreferred', 0)

	SetActionBarToggles(1, 1, 1, 1, 1)
	MultiActionBar_Update()

	ShowHelm(false)
	ShowCloak(false)

	-- SHOW_MULTI_ACTIONBAR_1 = 1
	-- SHOW_MULTI_ACTIONBAR_2 = 1
	-- SHOW_MULTI_ACTIONBAR_3 = 1
	-- SHOW_MULTI_ACTIONBAR_4 = 1
	-- ALWAYS_SHOW_MULTIBARS = 1
	-- LOCK_ACTIONBAR = 1
	-- InterfaceOptions_UpdateMultiActionBars()

	if not BNToastFrame.SetBackdrop then
		Mixin(BNToastFrame, BackdropTemplateMixin)
	end
	BNToastFrame:ClearAllPoints()
	BNToastFrame:SetPoint('BOTTOMLEFT', ChatFrame4, 'TOPLEFT', 0, 35)
	BNToastFrame.CloseButton:Hide()
	BNToastFrame:SetBackdrop(
		{
			bgFile = 'Interface\\Buttons\\WHITE8x8',
			edgeFile = '',
			tile = false,
			tileSize = 0,
			edgeSize = 0,
			insets = {left = 0, right = 0, top = 0, bottom = 0}
		}
	)
	BNToastFrame:SetBackdropColor(0, 0, 0, 0.75)
	BNToastFrame:SetWidth(250)
	BNToastFrame:CreateBeautyBorder(8)
	BNToastFrame.ClearAllPoints = function()
	end
	BNToastFrame.SetPoint = function()
	end

	CastingBarFrame.Text:ClearAllPoints()
	CastingBarFrame.Text:SetPoint('CENTER', CastingBarFrame, 0, 2)

	Grid:SetProfile('Default')
	Details:ApplyProfile('Default')
	Plater.db:SetProfile('Default')

	ReloadUI()
end

SLASH_XINSTALL1 = '/xinstall'
SlashCmdList['XINSTALL'] = function(msg)
	xInstallAddon()
end

local f = CreateFrame('Frame')
f:RegisterEvent('PLAYER_ENTERING_WORLD')
f:SetScript(
	'OnEvent',
	function(self, event, isInitialLogin, isReloadingUi)
		if isInitialLogin or isReloadingUi then
			LootFrame:HookScript(
				'OnShow',
				function(self)
					LootFrame:ClearAllPoints()
					LootFrame:SetPoint('BOTTOMLEFT', CustomContainer_Combat, 'TOPLEFT', 450, 500)
				end
			)

			--------------------------------------------------------------------------------------------------------------------------
			--------------------------------------------------------------------------------------------------------------------------
			-- UNITFRAMES ------------------------------------------------------------------------------------------------------------
			--------------------------------------------------------------------------------------------------------------------------
			PlayerFrame:ClearAllPoints()
			PlayerFrame:SetPoint('CENTER', UIParent, 'CENTER', -250, -96)
			PlayerFrame.ClearAllPoints = function()
			end
			PlayerFrame.SetPoint = function()
			end
			PlayerFrameManaBarText:SetPoint('CENTER', PlayerFrameManaBar, 'CENTER', 0, -1)
			PlayerFrameManaBarText:SetScale(0.75)
			PlayerFrameHealthBarText:ClearAllPoints()
			PlayerFrameHealthBarText:SetPoint('CENTER', PlayerFrameHealthBar, 'CENTER', 0, 0)
			PlayerFrameHealthBarText:SetScale(0.85)

			PlayerFrameAlternateManaBar:RegisterEvent('PLAYER_ENTERING_WORLD')
			PlayerFrameAlternateManaBar:SetScript(
				'OnEvent',
				function(self, event)
					self:Hide()
					self:UnregisterEvent('PLAYER_ENTERING_WORLD')
				end
			)
			PlayerFrameAlternateManaBar:HookScript(
				'OnShow',
				function(self)
					self:Hide()
				end
			)
			PlayerFrame:HookScript(
				'OnUpdate',
				function()
					PlayerFrameHealthBarText:SetText(xVermin:FormatValue(UnitHealth('player')) .. ' / ' .. xVermin:FormatValue(UnitHealthMax('player')))
				end
			)

			TargetFrame:ClearAllPoints()
			TargetFrame:SetPoint('CENTER', UIParent, 'CENTER', 250, -96)
			TargetFrame.ClearAllPoints = function()
			end
			TargetFrame.SetPoint = function()
			end
			TargetFrameTextureFrame.ManaBarText:SetPoint('CENTER', TargetFrameManaBar, 'CENTER', 0, -1)
			TargetFrameTextureFrame.ManaBarText:SetScale(0.75)
			TargetFrameTextureFrame.HealthBarText:ClearAllPoints()
			TargetFrameTextureFrame.HealthBarText:SetPoint('CENTER', TargetFrameHealthBar, 'CENTER', 0, 0)
			TargetFrameTextureFrame.HealthBarText:SetScale(0.85)
			TargetFrameNameBackground:SetVertexColor(0, 0, 0, 0.5)
			TargetFrameNameBackground.SetVertexColor = function()
			end
			TargetFrame:HookScript(
				'OnUpdate',
				function()
					TargetFrameTextureFrame.HealthBarText:SetText(xVermin:FormatValue(UnitHealth('target')) .. ' / ' .. xVermin:FormatValue(UnitHealthMax('target')))
				end
			)

			FocusFrame:ClearAllPoints()
			FocusFrame:SetPoint('CENTER', TargetFrame, 'CENTER', 200, 100)
			FocusFrame.ClearAllPoints = function()
			end
			FocusFrame.SetPoint = function()
			end
			FocusFrameTextureFrame.ManaBarText:SetPoint('CENTER', FocusFrameManaBar, 'CENTER', 0, -1)
			FocusFrameTextureFrame.ManaBarText:SetScale(0.75)
			FocusFrameTextureFrame.HealthBarText:ClearAllPoints()
			FocusFrameTextureFrame.HealthBarText:SetPoint('CENTER', FocusFrameHealthBar, 'CENTER', 0, 0)
			FocusFrameTextureFrame.HealthBarText:SetScale(0.85)
			FocusFrameNameBackground:SetVertexColor(0, 0, 0, 0.5)
			FocusFrameNameBackground.SetVertexColor = function()
			end
			FocusFrame:HookScript(
				'OnUpdate',
				function()
					FocusFrameTextureFrame.HealthBarText:SetText(xVermin:FormatValue(UnitHealth('focus')) .. ' / ' .. xVermin:FormatValue(UnitHealthMax('focus')))
				end
			)

			xVermin:CheckIfLoadedWithTimer(
				'PetFrame',
				function()
					PetFrameHealthBarText:Hide()
					PetFrameHealthBarText.Show = function()
					end
					PetFrameManaBarText:Hide()
					PetFrameManaBarText.Show = function()
					end
				end
			)

			PetFrame:HookScript(
				'OnEnter',
				function(self)
					print('mouseover')
					self.OnEnter = function()
					end
				end
			)
		end

		UIWidgetBelowMinimapContainerFrame:ClearAllPoints()
		UIWidgetBelowMinimapContainerFrame:SetPoint('TOPRIGHT', 'UIParent', 'TOPRIGHT', -35, 4)
		UIWidgetBelowMinimapContainerFrame.ClearAllPoints = function()
		end
		UIWidgetBelowMinimapContainerFrame.SetPoint = function()
		end

		if (nHealthStatusBar and nHealthStatusBar:IsVisible()) then
			UIWidgetTopCenterContainerFrame:ClearAllPoints()
			UIWidgetTopCenterContainerFrame:SetPoint('TOP', 'UIParent', 'TOP', 0, -70)
			UIWidgetTopCenterContainerFrame.ClearAllPoints = function()
			end
			UIWidgetTopCenterContainerFrame.SetPoint = function()
			end
		end
	end
)
