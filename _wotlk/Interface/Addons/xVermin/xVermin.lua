local _, xVermin = ...

local f = CreateFrame('Frame')
f:RegisterEvent('PLAYER_ENTERING_WORLD')
f:SetScript(
	'OnEvent',
	function(self, event, isInitialLogin, isReloadingUi)
		if isInitialLogin or isReloadingUi then
			-- SHOW_MULTI_ACTIONBAR_1 = 1
			-- SHOW_MULTI_ACTIONBAR_2 = 1
			-- SHOW_MULTI_ACTIONBAR_3 = 1
			-- SHOW_MULTI_ACTIONBAR_4 = 1
			-- ALWAYS_SHOW_MULTIBARS = 1
			-- LOCK_ACTIONBAR = 1
			-- InterfaceOptions_UpdateMultiActionBars()

			-------------------------------------------
			-- Reposition toast frame.
			-------------------------------------------
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

			LootFrame:HookScript(
				'OnShow',
				function(self)
					LootFrame:ClearAllPoints()
					LootFrame:SetPoint('BOTTOMLEFT', CustomContainer_Combat, 'TOPLEFT', 450, 500)
				end
			)

			CastingBarFrame.Text:ClearAllPoints()
			CastingBarFrame.Text:SetPoint('CENTER', CastingBarFrame, 0, 2)

			PlayerFrame:ClearAllPoints()
			PlayerFrame:SetPoint('CENTER', UIParent, 'CENTER', -250, -96)
			PlayerFrame.ClearAllPoints = function()
			end
			PlayerFrame.SetPoint = function()
			end

			PlayerFrameManaBarText:SetScale(0.8)

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

			TargetFrame:HookScript(
				'OnShow',
				function(self)
					TargetFrame:ClearAllPoints()
					TargetFrame:SetPoint('CENTER', UIParent, 'CENTER', 250, -96)
					TargetFrame.ClearAllPoints = function()
					end
					TargetFrame.SetPoint = function()
					end
					TargetFrameTextureFrame.ManaBarText:SetScale(0.8)
				end
			)

			FocusFrame:HookScript(
				'OnShow',
				function(self)
					FocusFrame:ClearAllPoints()
					FocusFrame:SetPoint('CENTER', TargetFrame, 'CENTER', 200, 100)
					FocusFrame.ClearAllPoints = function()
					end
					FocusFrame.SetPoint = function()
					end
					FocusFrameTextureFrame.ManaBarText:SetScale(0.8)
				end
			)

			PetFrame:HookScript(
				'OnShow',
				function(self)
					PetFrameHealthBarText:SetFont(xVermin.Config.font.atari, 10, 'THINOUTLINE')
					PetFrameHealthBarText:SetPoint('TOPRIGHT', PetFrameHealthBar, 'TOPRIGHT', 0, 2)
					-- PetFrameHealthBarText:SetPoint('TOPRIGHT', PetFrameHealthBar, 'TOPRIGHT', 2, -22)
					PetFrameHealthBarText.SetPoint = function()
					end
					PetFrameManaBarText:SetFont(xVermin.Config.font.atari, 10, 'THINOUTLINE')
					PetFrameManaBarText:SetPoint('TOPRIGHT', PetFrameManaBar, 'TOPRIGHT', 0, 0)
					PetFrameManaBarText.SetPoint = function()
					end
					PetFrameHealthBarText:Hide()
					PetFrameManaBarText:Hide()
					PetName:Hide()
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

		EnableAddOn('Blizzard_CompactRaidFrames')
		EnableAddOn('Blizzard_CUFProfiles')
	end
)
