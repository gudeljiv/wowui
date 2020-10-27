local _, xVermin = ...

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript(
	"OnEvent",
	function(self, event, isInitialLogin, isReloadingUi)
		if isInitialLogin or isReloadingUi then
			SHOW_MULTI_ACTIONBAR_1 = 1
			SHOW_MULTI_ACTIONBAR_2 = 1
			SHOW_MULTI_ACTIONBAR_3 = 1
			SHOW_MULTI_ACTIONBAR_4 = 1
			ALWAYS_SHOW_MULTIBARS = 1
			LOCK_ACTIONBAR = 1
			InterfaceOptions_UpdateMultiActionBars()

			-------------------------------------------
			-- Position of choco bars
			-------------------------------------------
			ChocolateBar1:ClearAllPoints()
			ChocolateBar1:SetPoint("LEFT", CustomContainer_1, "LEFT", 5, 0)
			ChocolateBar1:SetWidth(145)
			ChocolateBar2:ClearAllPoints()
			ChocolateBar2:SetPoint("LEFT", CustomContainer_2, "LEFT", 5, 0)
			ChocolateBar2:SetWidth(145)

			-------------------------------------------
			-- Reposition toast frame.
			-------------------------------------------
			BNToastFrame:ClearAllPoints()
			BNToastFrame:SetPoint("BOTTOMLEFT", ChatFrame4, "TOPLEFT", 0, 35)
			BNToastFrame.CloseButton:Hide()
			BNToastFrame:SetBackdrop(
				{
					bgFile = "Interface\\Buttons\\WHITE8x8",
					edgeFile = "",
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
				"OnShow",
				function(self)
					LootFrame:ClearAllPoints()
					LootFrame:SetPoint("BOTTOMLEFT", CustomContainer_Combat, "TOPLEFT", 450, 250)
				end
			)

			-------------------------------------------
			-- Reposition quest timer frame.
			-------------------------------------------
			QuestTimerFrame:HookScript(
				"OnShow",
				function(self)
					QuestTimerFrame:ClearAllPoints()
					QuestTimerFrame:SetPoint("BOTTOMRIGHT", CustomContainer_1, "BOTTOMLEFT", 0, -9)
				end
			)

			QuestTimerFrame:HookScript(
				"OnUpdate",
				function(self)
					QuestTimerFrame:ClearAllPoints()
					QuestTimerFrame:SetPoint("BOTTOMRIGHT", CustomContainer_1, "BOTTOMLEFT", 0, -9)
				end
			)

			-------------------------------------------
			-- druability frame
			-------------------------------------------
			DurabilityFrame:ClearAllPoints()
			DurabilityFrame:SetPoint("TOPRIGHT", "EavesDropFrame", "BOTTOMRIGHT", -40, 0)
			DurabilityFrame.ClearAllPoints = function()
			end
			DurabilityFrame.SetPoint = function()
			end

			-------------------------------------------
			-- adjust position of PetActionButtons
			-------------------------------------------
			PetActionButton1:Show()
			PetActionButton1:ClearAllPoints()
			PetActionButton1:SetMovable(true)
			PetActionButton1:SetUserPlaced(true)
			PetActionButton1:SetPoint("BOTTOM", MultiBarBottomRightButton2, "TOP", 20, 7)
			PetActionButton1.ClearAllPoints = function()
			end
			PetActionButton1.SetPoint = function()
			end

			-------------------------------------------
			-- CastingBarFrame Text
			-------------------------------------------
			CastingBarFrame.Text:ClearAllPoints()
			CastingBarFrame.Text:SetPoint("CENTER", CastingBarFrame, 0, 2)

			-------------------------------------------
			-- action bars
			-------------------------------------------
			MainMenuExpBar:Hide()
			MainMenuExpBar:HookScript(
				"OnShow",
				function(self)
					self:Hide()
				end
			)
			ReputationWatchBar:Hide()
			ReputationWatchBar:HookScript(
				"OnShow",
				function(self)
					self:Hide()
				end
			)

			Minimap:ClearAllPoints()
			Minimap:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -40, -40)
			Minimap.SetPoint = function()
			end

			MultiBarBottomLeft:ClearAllPoints()
			MultiBarBottomLeft:SetPoint("BOTTOM", MainMenuBar, "TOP", 0, -5)
			MultiBarBottomLeft.ClearAllPoints = function()
			end
			MultiBarBottomLeft.SetPoint = function()
			end

			MultiBarRightButton1:ClearAllPoints()
			MultiBarRightButton1:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -9, -25)
			MultiBarRightButton1.ClearAllPoints = function()
			end
			MultiBarRightButton1.SetPoint = function()
			end

			MultiBarLeftButton1:ClearAllPoints()
			MultiBarLeftButton1:SetPoint("TOP", MultiBarRightButton12, "BOTTOM", 0, -20)
			MultiBarLeftButton1.ClearAllPoints = function()
			end
			MultiBarLeftButton1.SetPoint = function()
			end

			MultiBarRight:SetScale(0.8)
			MultiBarLeft:SetScale(0.8)
			MultiBarRight.SetScale = function()
			end
			MultiBarLeft.SetScale = function()
			end

			MainMenuBarExpText:SetPoint("RIGHT", MainMenuExpBar, "RIGHT", -10, 2)

			-------------------------------------------
			--- pet, player and target frame positioning
			-------------------------------------------
			PetFrame:HookScript(
				"OnUpdate",
				function(self)
					PetFrameHealthBarText:SetFont(xVermin.Config.font.atari, 10, "THINOUTLINE")
					PetFrameHealthBarText:SetPoint("TOPRIGHT", PetFrameHealthBar, "TOPRIGHT", 0, 2)
					PetFrameHealthBarText.SetPoint = function()
					end
					PetFrameManaBarText:SetFont(xVermin.Config.font.atari, 10, "THINOUTLINE")
					PetFrameManaBarText:SetPoint("TOPRIGHT", PetFrameManaBar, "TOPRIGHT", 0, 0)
					PetFrameManaBarText.SetPoint = function()
					end

					PetFrameHealthBarText:Hide()
					PetFrameManaBarText:Hide()
					PetName:Hide()
				end
			)

			PlayerFrameManaBarText:SetScale(0.8)

			PlayerFrame:ClearAllPoints()
			PlayerFrame:SetPoint("CENTER", UIParent, "CENTER", -250, -96)
			PlayerFrame.ClearAllPoints = function()
			end
			PlayerFrame.SetPoint = function()
			end

			TargetFrame:ClearAllPoints()
			TargetFrame:SetPoint("CENTER", UIParent, "CENTER", 250, -96)
			TargetFrame.ClearAllPoints = function()
			end
			TargetFrame.SetPoint = function()
			end
		end
	end
)

local function TargetFrameTextAdjustment()
	TargetFrameHealthBarText:ClearAllPoints()
	TargetFrameHealthBarText:SetPoint("CENTER", TargetFrame, "CENTER", -50, 7)
	TargetFrameManaBarText:SetScale(0.8)
end
hooksecurefunc("TargetFrame_CheckClassification", TargetFrameTextAdjustment)
