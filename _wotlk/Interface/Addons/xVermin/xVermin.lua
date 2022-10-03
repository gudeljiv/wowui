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

	ShowHelm(false)
	ShowCloak(false)

	if Grid2 then
		Grid2.db:SetProfile('xVermin')
	end
	if Details then
		Details:ApplyProfile('xVermin')
	end
	if Plater then
		Plater.db:SetProfile('xVermin')
	end
	if TMW then
		TMW.db:SetProfile(xVermin.Class)
		if not TMW.db.profile.Locked then
			TMW:LockToggle()
		end
	end

	-- SetActionBarToggles(1, 1, 1, 1, 1)
	-- local action_bars = {_G['InterfaceOptionsActionBarsPanelBottomLeft'], _G['InterfaceOptionsActionBarsPanelBottomRight'], _G['InterfaceOptionsActionBarsPanelRight'], _G['InterfaceOptionsActionBarsPanelRightTwo']}
	-- for i = 1, #action_bars do
	-- 	action_bars[i]:SetChecked(1)
	-- 	action_bars[i]:GetScript('OnClick')(action_bars[i])
	-- end
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
			xInstallAddon()

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
			PlayerName:ClearAllPoints()
			PlayerName:SetPoint('CENTER', PlayerFrameBackground, 'CENTER', 0, 10)

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
					if UnitHealth('player') > 0 then
						PlayerFrameHealthBarText:SetText(xVermin:FormatValue(UnitHealth('player')) .. ' / ' .. xVermin:FormatValue(UnitHealthMax('player')))
					else
						PlayerFrameHealthBarText:Hide()
						PlayerFrameManaBarText:Hide()
					end
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
			TargetFrameTextureFrameName:ClearAllPoints()
			TargetFrameTextureFrameName:SetPoint('CENTER', TargetFrameNameBackground, 'CENTER', 0, -1)
			TargetFrameNameBackground:SetVertexColor(0, 0, 0, 0.5)
			TargetFrameNameBackground.SetVertexColor = function()
			end
			TargetFrame:HookScript(
				'OnUpdate',
				function()
					if UnitHealth('target') > 0 then
						TargetFrameTextureFrame.HealthBarText:SetText(xVermin:FormatValue(UnitHealth('target')) .. ' / ' .. xVermin:FormatValue(UnitHealthMax('target')))
					else
						TargetFrameTextureFrame.HealthBarText:Hide()
						TargetFrameTextureFrame.ManaBarText:Hide()
					end
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
			FocusFrameTextureFrameName:ClearAllPoints()
			FocusFrameTextureFrameName:SetPoint('CENTER', FocusFrameNameBackground, 'CENTER', 0, -1)
			FocusFrameNameBackground:SetVertexColor(0, 0, 0, 0.5)
			FocusFrameNameBackground.SetVertexColor = function()
			end
			FocusFrame:HookScript(
				'OnUpdate',
				function()
					if UnitHealth('focus') > 0 then
						FocusFrameTextureFrame.HealthBarText:SetText(xVermin:FormatValue(UnitHealth('focus')) .. ' / ' .. xVermin:FormatValue(UnitHealthMax('focus')))
					else
						FocusFrameTextureFrame.HealthBarText:Hide()
						FocusFrameTextureFrame.ManaBarText:Hide()
					end
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
