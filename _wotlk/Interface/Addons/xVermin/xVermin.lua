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
			-- Position of choco bars
			-------------------------------------------
			if (ChocolateBar1) then
				ChocolateBar1:ClearAllPoints()
				ChocolateBar1:SetPoint('LEFT', CustomContainer_1, 'LEFT', 5, 0)
				ChocolateBar1:SetWidth(145)
			end
			if (ChocolateBar2) then
				ChocolateBar2:ClearAllPoints()
				ChocolateBar2:SetPoint('LEFT', CustomContainer_2, 'LEFT', 5, 0)
				ChocolateBar2:SetWidth(145)
			end

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

			-------------------------------------------
			-- Reposition loot frame.
			-------------------------------------------
			LootFrame:HookScript(
				'OnShow',
				function(self)
					LootFrame:ClearAllPoints()
					LootFrame:SetPoint('BOTTOMLEFT', CustomContainer_Combat, 'TOPLEFT', 450, 500)
				end
			)

			-------------------------------------------
			-- Reposition quest timer frame.
			-------------------------------------------
			-- QuestTimerFrame:HookScript(
			-- 	'OnUpdate',
			-- 	function(self)
			-- 		QuestTimerFrame:ClearAllPoints()
			-- 		QuestTimerFrame:SetPoint('BOTTOMRIGHT', CustomContainer_2, 'BOTTOMLEFT', 0, -9)
			-- 	end
			-- )

			-------------------------------------------
			-- druability frame
			-------------------------------------------
			-- DurabilityFrame:ClearAllPoints()
			-- DurabilityFrame:SetPoint("TOPRIGHT", "EavesDropFrame", "BOTTOMRIGHT", -40, 0)
			-- DurabilityFrame.ClearAllPoints = function()
			-- end
			-- DurabilityFrame.SetPoint = function()
			-- end

			-------------------------------------------
			-- CastingBarFrame Text
			-------------------------------------------
			CastingBarFrame.Text:ClearAllPoints()
			CastingBarFrame.Text:SetPoint('CENTER', CastingBarFrame, 0, 2)

			-------------------------------------------
			-- Minimap
			-------------------------------------------
			C_Timer.NewTicker(
				1,
				function(self)
					if Minimap then
						Minimap:ClearAllPoints()
						Minimap:SetPoint('TOPRIGHT', UIParent, 'TOPRIGHT', -40, -40)

						Minimap:HookScript(
							'OnUpdate',
							function(self)
								if not Minimap.SetBackdrop then
									Mixin(Minimap, BackdropTemplateMixin)
								end
								if not GameTimeFrame.SetBackdrop then
									Mixin(GameTimeFrame, BackdropTemplateMixin)
								end

								MiniMapWorldMapButton:Hide()

								MiniMapLFGFrame:ClearAllPoints()
								MiniMapLFGFrame:SetPoint('BOTTOMRIGHT', Minimap, 'BOTTOMRIGHT', 0, 0)
								MiniMapBattlefieldFrame:ClearAllPoints()
								MiniMapBattlefieldFrame:SetPoint('BOTTOMRIGHT', Minimap, 'BOTTOMRIGHT', 0, 0)

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

						self:Cancel()
					end
				end
			)

			-------------------------------------------
			--- pet, player and target frame positioning
			-------------------------------------------
			PetFrame:HookScript(
				'OnUpdate',
				function(self)
					PetFrameHealthBarText:SetFont(xVermin.Config.font.atari, 10, 'THINOUTLINE')
					PetFrameHealthBarText:SetPoint('TOPRIGHT', PetFrameHealthBar, 'TOPRIGHT', 0, 2)
					PetFrameHealthBarText:SetPoint('TOPRIGHT', PetFrameHealthBar, 'TOPRIGHT', 2, -22)
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

			-- PlayerFrame:HookScript(
			-- 	"OnUpdate",
			-- 	function(self)
			-- 		if PlayerName then PlayerName:Hide() end
			-- 		if PlayerFrameHealthBarText then
			-- 			PlayerFrameHealthBarText:ClearAllPoints()
			-- 			PlayerFrameHealthBarText:SetPoint("CENTER", PlayerFrameHealthBar, "CENTER", 0, 0)
			-- 			PlayerFrameHealthBarText:SetScale(1.5)
			-- 			PlayerFrameHealthBarText:Show()
			-- 		end
			-- 		if PlayerFrameManaBarText then
			-- 			PlayerFrameManaBarText:ClearAllPoints()
			-- 			PlayerFrameManaBarText:SetPoint("CENTER", PlayerFrameManaBar, "CENTER", 0, -1)
			-- 			PlayerFrameManaBarText:SetScale(1.2)
			-- 			PlayerFrameManaBarText:Show()
			-- 		end
			-- 	end
			-- )--

			-- TargetFrame:HookScript(
			-- 	"OnUpdate",
			-- 	function(self)
			-- 		TargetFrameTextureFrame.HealthBarText:SetText("")

			-- 		if not UnitIsDeadOrGhost("target") then
			-- 			local hc = xVermin:FormatValue(UnitHealth("target"))
			-- 			local hm = xVermin:FormatValue(UnitHealthMax("target"))
			-- 			if (UnitHealth("target") < 10000) then hc = xVermin:FormatNumber(UnitHealth("target")) end
			-- 			if (UnitHealthMax("target") < 10000) then hm = xVermin:FormatNumber(UnitHealthMax("target")) end
			-- 			TargetFrameTextureFrame.HealthBarText:SetText(hc .. " / ".. hm)
			-- 		end

			-- 		if TargetFrameHealthBarText then TargetFrameHealthBarText:Hide() end
			-- 		if TargetFrameTextureFrameName then
			-- 			TargetFrameTextureFrameName:Show()
			-- 			TargetFrameTextureFrameName:ClearAllPoints()
			-- 			TargetFrameTextureFrameName:SetPoint("CENTER", TargetFrameHealthBar, "CENTER", 0, 6)
			-- 			TargetFrameTextureFrameName:SetScale(1.4)
			-- 		end
			-- 		if TargetFrameTextureFrame and TargetFrameTextureFrame.HealthBarText then
			-- 			TargetFrameTextureFrame.HealthBarText:ClearAllPoints()
			-- 			TargetFrameTextureFrame.HealthBarText:SetPoint("CENTER", TargetFrameHealthBar, "CENTER", 0, -5)
			-- 			TargetFrameTextureFrame.HealthBarText:SetScale(1.6)
			-- 			TargetFrameTextureFrame.HealthBarText:Show()
			-- 			TargetFrameTextureFrameDeadText:SetPoint("CENTER", TargetFrameHealthBar, "CENTER", 0, -5)
			-- 			TargetFrameTextureFrameDeadText:SetScale(1.6)
			-- 		end
			-- 		if TargetFrameTextureFrame and TargetFrameTextureFrame.ManaBarText then
			-- 			TargetFrameTextureFrame.ManaBarText:ClearAllPoints()
			-- 			TargetFrameTextureFrame.ManaBarText:SetPoint("CENTER", TargetFrameManaBar, "CENTER", 0, -1)
			-- 			TargetFrameTextureFrame.ManaBarText:SetScale(1.2)
			-- 			TargetFrameTextureFrame.ManaBarText:Show()
			-- 		end
			-- 		if TargetFrameTextureFrame then TargetFrameTextureFrame:SetScale(0.8) end

			-- 		if TargetFrameTextureFrameLevelText then
			-- 			TargetFrameTextureFrameLevelText:ClearAllPoints()
			-- 			TargetFrameTextureFrameLevelText:SetPoint("CENTER", TargetFrame, "CENTER", 78, -22)
			-- 		end
			-- 	end
			-- )

			-- FocusFrame:HookScript(
			-- 	"OnUpdate",
			-- 	function(self)
			-- 		FocusFrameTextureFrame.HealthBarText:SetText("")

			-- 		if not UnitIsDeadOrGhost("focus") then
			-- 			local hc = xVermin:FormatValue(UnitHealth("focus"))
			-- 			local hm = xVermin:FormatValue(UnitHealthMax("focus"))
			-- 			if (UnitHealth("focus") < 10000) then hc = xVermin:FormatNumber(UnitHealth("focus")) end
			-- 			if (UnitHealthMax("focus") < 10000) then hm = xVermin:FormatNumber(UnitHealthMax("focus")) end
			-- 			FocusFrameTextureFrame.HealthBarText:SetText(hc .. " / ".. hm)
			-- 		end

			-- 		if FocusFrameHealthBarText then FocusFrameHealthBarText:Hide() end
			-- 		if FocusFrameTextureFrameName then
			-- 			FocusFrameTextureFrameName:Show()
			-- 			FocusFrameTextureFrameName:ClearAllPoints()
			-- 			FocusFrameTextureFrameName:SetPoint("CENTER", FocusFrameHealthBar, "CENTER", 0, 6)
			-- 			FocusFrameTextureFrameName:SetScale(1.4)
			-- 		end
			-- 		if FocusFrameTextureFrame and FocusFrameTextureFrame.HealthBarText then
			-- 			FocusFrameTextureFrame.HealthBarText:ClearAllPoints()
			-- 			FocusFrameTextureFrame.HealthBarText:SetPoint("CENTER", FocusFrameHealthBar, "CENTER", 0, -5)
			-- 			FocusFrameTextureFrame.HealthBarText:SetScale(1.6)
			-- 			FocusFrameTextureFrame.HealthBarText:Show()
			-- 			FocusFrameTextureFrameDeadText:SetPoint("CENTER", FocusFrameHealthBar, "CENTER", 0, -5)
			-- 			FocusFrameTextureFrameDeadText:SetScale(1.6)
			-- 		end
			-- 		if FocusFrameTextureFrame and FocusFrameTextureFrame.ManaBarText then
			-- 			FocusFrameTextureFrame.ManaBarText:ClearAllPoints()
			-- 			FocusFrameTextureFrame.ManaBarText:SetPoint("CENTER", FocusFrameManaBar, "CENTER", 0, -1)
			-- 			FocusFrameTextureFrame.ManaBarText:SetScale(1.2)
			-- 			FocusFrameTextureFrame.ManaBarText:Show()
			-- 		end
			-- 		if FocusFrameTextureFrame then FocusFrameTextureFrame:SetScale(0.8) end
			-- 		if FocusFrameTextureFrameLevelText then
			-- 			FocusFrameTextureFrameLevelText:ClearAllPoints()
			-- 			FocusFrameTextureFrameLevelText:SetPoint("CENTER", FocusFrame, "CENTER", 78, -22)
			-- 		end
			-- 	end
			-- )

			PlayerFrame:ClearAllPoints()
			PlayerFrame:SetPoint('CENTER', UIParent, 'CENTER', -250, -96)
			PlayerFrame.ClearAllPoints = function()
			end
			PlayerFrame.SetPoint = function()
			end

			PlayerFrameAlternateManaBar:Hide()
			PlayerFrameAlternateManaBar:HookScript(
				'OnShow',
				function(self)
					self:Hide()
				end
			)

			TargetFrame:ClearAllPoints()
			TargetFrame:SetPoint('CENTER', UIParent, 'CENTER', 250, -96)
			TargetFrame.ClearAllPoints = function()
			end
			TargetFrame.SetPoint = function()
			end

			FocusFrame:ClearAllPoints()
			FocusFrame:SetPoint('CENTER', TargetFrame, 'CENTER', 200, 100)
			FocusFrame.ClearAllPoints = function()
			end
			FocusFrame.SetPoint = function()
			end

			PlayerFrameManaBarText:SetScale(0.8)
			TargetFrameTextureFrame.ManaBarText:SetScale(0.8)
			FocusFrameTextureFrame.ManaBarText:SetScale(0.8)
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

-- PlayerFrame:HookScript(
-- 	'OnUpdate',
-- 	function(self)
-- 		if ArenaEnemyFrame1 then
-- 			ArenaEnemyFrame1:HookScript(
-- 				'OnUpdate',
-- 				function(self)
-- 					self:Hide()
-- 				end
-- 			)
-- 		end

-- 		if ArenaEnemyFrame2 then
-- 			ArenaEnemyFrame2:HookScript(
-- 				'OnUpdate',
-- 				function(self)
-- 					self:Hide()
-- 				end
-- 			)
-- 		end
-- 	end
-- )
