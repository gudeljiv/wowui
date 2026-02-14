local _, xVermin = ...

local al_frame = CreateFrame("Frame")
al_frame:RegisterEvent("ADDON_LOADED")
al_frame:SetScript("OnEvent", function(event, arg1)
	if event == "ADDON_LOADED" then
		if not xVerminSavedData or xVerminSavedData == nil or type(xVerminSavedData) ~= "table" then
			xVerminSavedData = {}
		end
	end
end)

local function xInstallAddon()
	C_CVar.SetCVar("autoQuestWatch", 1)
	C_CVar.SetCVar("autoQuestProgress", 1)
	C_CVar.SetCVar("instantQuestText", 1)
	C_CVar.SetCVar("nameplateMaxDistance", 80)
	C_CVar.SetCVar("ffxGlow", 1)
	C_CVar.SetCVar("ffxDeath", 0)
	C_CVar.SetCVar("ffxNether", 0)
	C_CVar.SetCVar("violenceLevel", 5)
	C_CVar.SetCVar("cameraDistanceMax", 50)
	C_CVar.SetCVar("cameraDistanceMaxFactor", 4.0)
	C_CVar.SetCVar("cameraDistanceMaxZoomFactor", 4.0)
	C_CVar.SetCVar("chatClassColorOverride", 0)
	C_CVar.SetCVar("ShowClassColorInFriendlyNameplate", 1)
	C_CVar.SetCVar("scriptErrors", 1)
	C_CVar.SetCVar("alwaysShowActionBars", 1)
	C_CVar.SetCVar("AutoInteract", 0)
	C_CVar.SetCVar("cursorsizepreferred", 0)
	C_CVar.SetCVar("autoLootDefault", "1")
	C_CVar.SetCVar("floatingCombatTextCombatHealing", 1)

	C_CVar.SetCVar("showArenaEnemyFrames", "0")
	C_CVar.SetCVar("showArenaEnemyCastbar", "0")
	C_CVar.SetCVar("showArenaEnemyPets", "0")

	if not SHOW_INSCRIPTION_LEVEL then
		SHOW_INSCRIPTION_LEVEL = 15
	end

	if Grid2 then
		Grid2.db:SetProfile("xVermin")
	end
	if Details then
		Details:ApplyProfile("xVermin")
	end
	if Plater then
		Plater.db:SetProfile("xVermin")
	end
	if TMW then
		TMW.db:SetProfile(xVermin.Class)
		if not TMW.db.profile.Locked then
			TMW:LockToggle()
		end
	end
	if ShadowUF then
		ShadowUF.db:SetProfile(xVermin.Class)
	end

	ShowHelm(false)
	ShowCloak(false)
end

SLASH_XINSTALL1 = "/xinstall"
SlashCmdList["XINSTALL"] = function(msg)
	xInstallAddon()
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self, event, isInitialLogin, isReloadingUi)
	xInstallAddon()

	if not BNToastFrame.SetBackdrop then
		Mixin(BNToastFrame, BackdropTemplateMixin)
	end

	BNToastFrame:ClearAllPoints()
	BNToastFrame:SetPoint("BOTTOMLEFT", ChatFrame4, "TOPLEFT", 0, 35)
	BNToastFrame.ClearAllPoints = function() end
	BNToastFrame.SetPoint = function() end
	BNToastFrame.CloseButton:Hide()
	BNToastFrame:SetBackdrop({
		bgFile = "Interface\\Buttons\\WHITE8x8",
		edgeFile = "",
		tile = false,
		tileSize = 0,
		edgeSize = 0,
		insets = { left = 0, right = 0, top = 0, bottom = 0 },
	})
	BNToastFrame:SetBackdropColor(0, 0, 0, 0.75)
	BNToastFrame:SetWidth(250)
	BNToastFrame:CreateBeautyBorder(8)

	if LSToastAnchor1 then
		LSToastAnchor1:ClearAllPoints()
		LSToastAnchor1:SetPoint("BOTTOMLEFT", ChatFrame4, "TOPLEFT", 30, 45)
	end

	PlayerCastingBarFrame.Text:ClearAllPoints()
	PlayerCastingBarFrame.Text:SetPoint("CENTER", PlayerCastingBarFrame, 0, 2)

	LootFrame:HookScript("OnShow", function(self)
		LootFrame:ClearAllPoints()
		LootFrame:SetPoint("BOTTOMLEFT", CustomContainer_Combat, "TOPLEFT", 450, 500)
	end)

	-- --------------------------------------------------------------------------------------------------------------------------
	-- --------------------------------------------------------------------------------------------------------------------------
	-- -- UNITFRAMES ------------------------------------------------------------------------------------------------------------
	-- --------------------------------------------------------------------------------------------------------------------------
	-- if PlayerFrame and PlayerFrame:IsVisible() then

	-- 	PlayerFrame:SetMovable(true)
	-- 	PlayerFrame:ClearAllPoints()
	-- 	PlayerFrame:SetPoint('CENTER', UIParent, 'CENTER', -250, -96)
	-- 	PlayerFrame:SetUserPlaced(true)
	-- 	PlayerFrame:SetMovable(false)

	-- 	PlayerFrameHealthBarText:SetPoint('CENTER', PlayerFrameHealthBar, 'CENTER', 0, 0)
	-- 	PlayerFrameHealthBarText:SetScale(0.85)
	-- 	PlayerFrameHealthBarTextLeft:SetPoint('LEFT', PlayerFrameHealthBar, 'LEFT', 5, 0)
	-- 	PlayerFrameHealthBarTextLeft:SetScale(0.85)
	-- 	PlayerFrameHealthBarTextRight:SetPoint('RIGHT', PlayerFrameHealthBar, 'RIGHT', -1, 0)
	-- 	PlayerFrameHealthBarTextRight:SetScale(0.85)
	-- 	PlayerFrameManaBarText:SetPoint('CENTER', PlayerFrameManaBar, 'CENTER', 0, -1)
	-- 	PlayerFrameManaBarText:SetScale(0.75)
	-- 	PlayerFrameManaBarTextLeft:SetPoint('LEFT', PlayerFrameManaBar, 'LEFT', 7, -1)
	-- 	PlayerFrameManaBarTextLeft:SetScale(0.75)
	-- 	PlayerFrameManaBarTextRight:SetPoint('RIGHT', PlayerFrameManaBar, 'RIGHT', -2, -1)
	-- 	PlayerFrameManaBarTextRight:SetScale(0.75)
	-- 	PlayerName:SetPoint('CENTER', PlayerFrameBackground, 'CENTER', 0, 10)

	-- 	if PlayerFrameAlternateManaBar then
	-- 		PlayerFrameAlternateManaBar:Hide()
	-- 	end
	-- 	-- PlayerFrameAlternateManaBar:HookScript(
	-- 	-- 	'OnShow',
	-- 	-- 	function(self)
	-- 	-- 		self:Hide()
	-- 	-- 	end
	-- 	-- )

	-- 	xVermin.CheckIfLoadedWithTimer(
	-- 		'PlayerFrame',
	-- 		function()
	-- 			PlayerFrame:HookScript(
	-- 				'OnUpdate',
	-- 				function()
	-- 					if UnitHealth('player') > 0 then
	-- 						PlayerFrameHealthBarText:SetText(xVermin.FormatValue(UnitHealth('player')) .. ' / ' .. xVermin.FormatValue(UnitHealthMax('player')))
	-- 					else
	-- 						PlayerFrameHealthBarText:Hide()
	-- 						PlayerFrameManaBarText:Hide()
	-- 					end
	-- 				end
	-- 			)
	-- 		end
	-- 	)
	-- end

	-- if TargetFrame and TargetFrame:IsVisible() then
	-- 	TargetFrame:SetMovable(true)
	-- 	TargetFrame:ClearAllPoints()
	-- 	TargetFrame:SetPoint('CENTER', UIParent, 'CENTER', 250, -96)
	-- 	TargetFrame:SetUserPlaced(true)
	-- 	TargetFrame:SetMovable(false)

	-- 	-- TargetFrameTextureFrame.HealthBarText:ClearAllPoints()
	-- 	TargetFrameTextureFrame.HealthBarText:SetPoint('CENTER', TargetFrameHealthBar, 'CENTER', 0, 0)
	-- 	TargetFrameTextureFrame.HealthBarText:SetScale(0.85)
	-- 	TargetFrameTextureFrame.HealthBarTextLeft:SetPoint('LEFT', TargetFrameHealthBar, 'LEFT', 1, 0)
	-- 	TargetFrameTextureFrame.HealthBarTextLeft:SetScale(0.85)
	-- 	TargetFrameTextureFrame.HealthBarTextRight:SetPoint('RIGHT', TargetFrameHealthBar, 'RIGHT', -5, 0)
	-- 	TargetFrameTextureFrame.HealthBarTextRight:SetScale(0.85)
	-- 	TargetFrameTextureFrame.ManaBarText:SetPoint('CENTER', TargetFrameManaBar, 'CENTER', 0, -1)
	-- 	TargetFrameTextureFrame.ManaBarText:SetScale(0.75)
	-- 	TargetFrameTextureFrame.ManaBarTextLeft:SetPoint('LEFT', TargetFrameManaBar, 'LEFT', 2, -1)
	-- 	TargetFrameTextureFrame.ManaBarTextLeft:SetScale(0.75)
	-- 	TargetFrameTextureFrame.ManaBarTextRight:SetPoint('RIGHT', TargetFrameManaBar, 'RIGHT', -7, -1)
	-- 	TargetFrameTextureFrame.ManaBarTextRight:SetScale(0.75)
	-- 	-- TargetFrameTextureFrameName:ClearAllPoints()
	-- 	TargetFrameTextureFrameName:SetPoint('CENTER', TargetFrameNameBackground, 'CENTER', 0, -1)
	-- 	TargetFrameNameBackground:SetVertexColor(0, 0, 0, 0.5)
	-- 	TargetFrameNameBackground.SetVertexColor = function() end

	-- 	xVermin.CheckIfLoadedWithTimer(
	-- 		'TargetFrame',
	-- 		function()
	-- 			TargetFrame:HookScript(
	-- 				'OnUpdate',
	-- 				function()
	-- 					if UnitHealth('target') > 0 then
	-- 						TargetFrameTextureFrame.HealthBarText:SetText(xVermin.FormatValue(UnitHealth('target')) .. ' / ' .. xVermin.FormatValue(UnitHealthMax('target')))
	-- 					else
	-- 						TargetFrameTextureFrame.HealthBarText:Hide()
	-- 						TargetFrameTextureFrame.ManaBarText:Hide()
	-- 					end
	-- 				end
	-- 			)
	-- 		end
	-- 	)
	-- end

	-- if FocusFrame and FocusFrame:IsVisible() then

	-- 	FocusFrame:SetMovable(true)
	-- 	FocusFrame:ClearAllPoints()
	-- 	FocusFrame:SetPoint('CENTER', TargetFrame, 'CENTER', 200, 100)
	-- 	FocusFrame:SetUserPlaced(true)
	-- 	FocusFrame:SetMovable(false)

	-- 	FocusFrameTextureFrame.HealthBarText:SetPoint('CENTER', FocusFrameHealthBar, 'CENTER', 0, 0)
	-- 	FocusFrameTextureFrame.HealthBarText:SetScale(0.85)
	-- 	FocusFrameTextureFrame.HealthBarTextLeft:SetPoint('LEFT', FocusFrameHealthBar, 'LEFT', 1, 0)
	-- 	FocusFrameTextureFrame.HealthBarTextLeft:SetScale(0.85)
	-- 	FocusFrameTextureFrame.HealthBarTextRight:SetPoint('RIGHT', FocusFrameHealthBar, 'RIGHT', -5, 0)
	-- 	FocusFrameTextureFrame.HealthBarTextRight:SetScale(0.85)
	-- 	FocusFrameTextureFrame.ManaBarText:SetPoint('CENTER', FocusFrameManaBar, 'CENTER', 0, -1)
	-- 	FocusFrameTextureFrame.ManaBarText:SetScale(0.75)
	-- 	FocusFrameTextureFrame.ManaBarTextLeft:SetPoint('LEFT', FocusFrameManaBar, 'LEFT', 2, -1)
	-- 	FocusFrameTextureFrame.ManaBarTextLeft:SetScale(0.75)
	-- 	FocusFrameTextureFrame.ManaBarTextRight:SetPoint('RIGHT', FocusFrameManaBar, 'RIGHT', -7, -1)
	-- 	FocusFrameTextureFrame.ManaBarTextRight:SetScale(0.75)
	-- 	-- FocusFrameTextureFrameName:ClearAllPoints()
	-- 	FocusFrameTextureFrameName:SetPoint('CENTER', FocusFrameNameBackground, 'CENTER', 0, -1)
	-- 	FocusFrameNameBackground:SetVertexColor(0, 0, 0, 0.5)
	-- 	FocusFrameNameBackground.SetVertexColor = function()
	-- 	end
	-- 	FocusFrame:HookScript(
	-- 		'OnUpdate',
	-- 		function()
	-- 			if UnitHealth('focus') > 0 then
	-- 				FocusFrameTextureFrame.HealthBarText:SetText(xVermin.FormatValue(UnitHealth('focus')) .. ' / ' .. xVermin.FormatValue(UnitHealthMax('focus')))
	-- 			else
	-- 				FocusFrameTextureFrame.HealthBarText:Hide()
	-- 				FocusFrameTextureFrame.ManaBarText:Hide()
	-- 			end
	-- 		end
	-- 	)
	-- end

	-- if PetFrame and PetFrame:IsVisible() then
	-- 	xVermin.CheckIfLoadedWithTimer(
	-- 		'PetFrame',
	-- 		function()
	-- 			PetFrameHealthBarText:Hide()
	-- 			PetFrameHealthBarTextLeft:Hide()
	-- 			PetFrameHealthBarTextRight:Hide()
	-- 			PetFrameHealthBarText.Show = function()
	-- 			end
	-- 			PetFrameHealthBarTextLeft.Show = function()
	-- 			end
	-- 			PetFrameHealthBarTextRight.Show = function()
	-- 			end
	-- 			PetFrameManaBarText:Hide()
	-- 			PetFrameManaBarTextLeft:Hide()
	-- 			PetFrameManaBarTextRight:Hide()
	-- 			PetFrameManaBarText.Show = function()
	-- 			end
	-- 			PetFrameManaBarTextLeft.Show = function()
	-- 			end
	-- 			PetFrameManaBarTextRight.Show = function()
	-- 			end
	-- 		end
	-- 	)

	-- 	-- PetFrame:HookScript(
	-- 	-- 	'OnEnter',
	-- 	-- 	function(self)
	-- 	-- 		print('mouseover')
	-- 	-- 		self.OnEnter = function()
	-- 	-- 		end
	-- 	-- 	end
	-- 	-- )
	-- end

	-- -- MiniMapInstanceDifficulty:ClearAllPoints()
	-- -- MiniMapInstanceDifficulty:SetPoint('TOPLEFT', Minimap, 'TOPLEFT', 0, 0)

	-- if RuneFrame and RuneFrame:IsVisible() then
	-- 	xVermin.CheckIfLoadedWithTimer(
	-- 		'RuneFrame',
	-- 		function()
	-- 			RuneFrame:SetScale(1.05)
	-- 			RuneFrame:ClearAllPoints()
	-- 			RuneFrame:SetPoint('TOPRIGHT', PlayerFrameManaBar, 'BOTTOMRIGHT', 10, -5)
	-- 		end
	-- 	)
	-- end
end)
