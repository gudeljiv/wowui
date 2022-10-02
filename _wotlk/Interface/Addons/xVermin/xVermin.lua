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
				end
			)
			xVermin:CheckIfLoadedWithTimer(
				'PetFrame',
				function()
					PetFrameManaBarText:Hide()
					PetFrameManaBarText.Show = function()
					end
				end
			)

			-- PetName:Hide()
			-- PetFrameHealthBarText:SetPoint('CENTER', PetFrameHealthBar, 'CENTER', 0, -1)
			-- PetFrameHealthBarText:SetScale(0.6)
			-- PetFrameManaBarText:SetPoint('CENTER', PetFrameManaBar, 'CENTER', 0, -1)
			-- PetFrameManaBarText:SetScale(0.6)
			PetFrame:HookScript(
				'OnEnter',
				function(self)
					print('mouseover')
					self.OnEnter = function()
					end
				end
			)
		--------------------------------------------------------------------------------------------------------------------------
		--------------------------------------------------------------------------------------------------------------------------
		--------------------------------------------------------------------------------------------------------------------------
		--------------------------------------------------------------------------------------------------------------------------
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

		-- EnableAddOn('Blizzard_CompactRaidFrames')
		-- EnableAddOn('Blizzard_CUFProfiles')
	end
)

-- local sr = LibStub('SpellRange-1.0')
-- local rc = LibStub('LibRangeCheck-2.0')
-- PlayerFrame:HookScript(
-- 	'OnUpdate',
-- 	function()
-- 		print('Pummel', sr.IsSpellInRange(25231, 'nameplate1'), IsSpellInRange("Pummel", 'nameplate1'), sr.IsSpellInRange(25231, 'target'), IsSpellInRange(25231, 'target'))
-- 		print('Cleave', sr.IsSpellInRange('Cleave', 'nameplate1'), IsSpellInRange('Cleave', 'nameplate1'), sr.IsSpellInRange('Cleave', 'target'), IsSpellInRange('Cleave', 'target'))
-- 		print('Heroic Strike', sr.IsSpellInRange('Heroic Strike', 'nameplate1'), IsSpellInRange('Heroic Strike', 'nameplate1'), sr.IsSpellInRange('Heroic Strike', 'target'), IsSpellInRange('Heroic Strike', 'target'))
-- 		print('Mortal Strike', sr.IsSpellInRange('Mortal Strike', 'nameplate1'), IsSpellInRange('Mortal Strike', 'nameplate1'), sr.IsSpellInRange('Mortal Strike', 'target'), IsSpellInRange('Mortal Strike', 'target'))
-- 		print('Bloodthirst', sr.IsSpellInRange('Bloodthirst', 'nameplate1'), IsSpellInRange('Bloodthirst', 'nameplate1'), sr.IsSpellInRange('Bloodthirst', 'target'), IsSpellInRange('Bloodthirst', 'target'))

-- 		local minRange, maxRange = rc:GetRange('nameplate1')
-- 		print(minRange, maxRange)

-- 	end
-- )
