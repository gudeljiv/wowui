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

	C_CVar.SetCVar('showArenaEnemyFrames', '1')
	C_CVar.SetCVar('showArenaEnemyCastbar', '1')
	C_CVar.SetCVar('showArenaEnemyPets', '1')

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

	ShowHelm(false)
	ShowCloak(false)

	-- SetActionBarToggles(1, 1, 1, 1, 1)
	-- local action_bars = {_G['InterfaceOptionsActionBarsPanelBottomLeft'], _G['InterfaceOptionsActionBarsPanelBottomRight'], _G['InterfaceOptionsActionBarsPanelRight'], _G['InterfaceOptionsActionBarsPanelRightTwo']}
	-- for i = 1, #action_bars do
	-- 	action_bars[i]:SetChecked(1)
	-- 	action_bars[i]:GetScript('OnClick')(action_bars[i])
	-- end

	-- local s, b = 'SHOW_MULTI_ACTIONBAR_'
	-- b = 1
	-- for i = 1, 4 do
	-- 	_G[s .. i] = b
	-- end
	-- InterfaceOptions_UpdateMultiActionBars()
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
		xInstallAddon()

		if not BNToastFrame.SetBackdrop then
			Mixin(BNToastFrame, BackdropTemplateMixin)
		end

		BNToastFrame:ClearAllPoints()
		BNToastFrame:SetPoint('BOTTOMLEFT', ChatFrame4, 'TOPLEFT', 0, 35)
		BNToastFrame.ClearAllPoints = function()
		end
		BNToastFrame.SetPoint = function()
		end
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

		LSToastAnchor1:ClearAllPoints()
		LSToastAnchor1:SetPoint('BOTTOMLEFT', ChatFrame4, 'TOPLEFT', 30, 45)

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
		PlayerFrame:SetMovable(true)
		PlayerFrame:ClearAllPoints()
		PlayerFrame:SetPoint('CENTER', UIParent, 'CENTER', -250, -96)
		PlayerFrame:SetUserPlaced(true)
		PlayerFrame:SetMovable(false)

		PlayerFrameHealthBarText:SetPoint('CENTER', PlayerFrameHealthBar, 'CENTER', 0, 0)
		PlayerFrameHealthBarText:SetScale(0.85)
		PlayerFrameHealthBarTextLeft:SetPoint('LEFT', PlayerFrameHealthBar, 'LEFT', 5, 0)
		PlayerFrameHealthBarTextLeft:SetScale(0.85)
		PlayerFrameHealthBarTextRight:SetPoint('RIGHT', PlayerFrameHealthBar, 'RIGHT', -1, 0)
		PlayerFrameHealthBarTextRight:SetScale(0.85)
		PlayerFrameManaBarText:SetPoint('CENTER', PlayerFrameManaBar, 'CENTER', 0, -1)
		PlayerFrameManaBarText:SetScale(0.75)
		PlayerFrameManaBarTextLeft:SetPoint('LEFT', PlayerFrameManaBar, 'LEFT', 7, -1)
		PlayerFrameManaBarTextLeft:SetScale(0.75)
		PlayerFrameManaBarTextRight:SetPoint('RIGHT', PlayerFrameManaBar, 'RIGHT', -2, -1)
		PlayerFrameManaBarTextRight:SetScale(0.75)
		PlayerName:SetPoint('CENTER', PlayerFrameBackground, 'CENTER', 0, 10)

		if PlayerFrameAlternateManaBar then
			PlayerFrameAlternateManaBar:Hide()
		end
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
					PlayerFrameHealthBarText:SetText(xVermin.FormatValue(UnitHealth('player')) .. ' / ' .. xVermin.FormatValue(UnitHealthMax('player')))
				else
					PlayerFrameHealthBarText:Hide()
					PlayerFrameManaBarText:Hide()
				end
			end
		)

		TargetFrame:SetMovable(true)
		TargetFrame:ClearAllPoints()
		TargetFrame:SetPoint('CENTER', UIParent, 'CENTER', 250, -96)
		TargetFrame:SetUserPlaced(true)
		TargetFrame:SetMovable(false)

		-- TargetFrameTextureFrame.HealthBarText:ClearAllPoints()
		TargetFrameTextureFrame.HealthBarText:SetPoint('CENTER', TargetFrameHealthBar, 'CENTER', 0, 0)
		TargetFrameTextureFrame.HealthBarText:SetScale(0.85)
		TargetFrameTextureFrame.HealthBarTextLeft:SetPoint('LEFT', TargetFrameHealthBar, 'LEFT', 1, 0)
		TargetFrameTextureFrame.HealthBarTextLeft:SetScale(0.85)
		TargetFrameTextureFrame.HealthBarTextRight:SetPoint('RIGHT', TargetFrameHealthBar, 'RIGHT', -5, 0)
		TargetFrameTextureFrame.HealthBarTextRight:SetScale(0.85)
		TargetFrameTextureFrame.ManaBarText:SetPoint('CENTER', TargetFrameManaBar, 'CENTER', 0, -1)
		TargetFrameTextureFrame.ManaBarText:SetScale(0.75)
		TargetFrameTextureFrame.ManaBarTextLeft:SetPoint('LEFT', TargetFrameManaBar, 'LEFT', 2, -1)
		TargetFrameTextureFrame.ManaBarTextLeft:SetScale(0.75)
		TargetFrameTextureFrame.ManaBarTextRight:SetPoint('RIGHT', TargetFrameManaBar, 'RIGHT', -7, -1)
		TargetFrameTextureFrame.ManaBarTextRight:SetScale(0.75)
		-- TargetFrameTextureFrameName:ClearAllPoints()
		TargetFrameTextureFrameName:SetPoint('CENTER', TargetFrameNameBackground, 'CENTER', 0, -1)
		TargetFrameNameBackground:SetVertexColor(0, 0, 0, 0.5)
		TargetFrameNameBackground.SetVertexColor = function()
		end
		TargetFrame:HookScript(
			'OnUpdate',
			function()
				if UnitHealth('target') > 0 then
					TargetFrameTextureFrame.HealthBarText:SetText(xVermin.FormatValue(UnitHealth('target')) .. ' / ' .. xVermin.FormatValue(UnitHealthMax('target')))
				else
					TargetFrameTextureFrame.HealthBarText:Hide()
					TargetFrameTextureFrame.ManaBarText:Hide()
				end
			end
		)

		FocusFrame:SetMovable(true)
		FocusFrame:ClearAllPoints()
		FocusFrame:SetPoint('CENTER', TargetFrame, 'CENTER', 200, 100)
		FocusFrame:SetUserPlaced(true)
		FocusFrame:SetMovable(false)

		FocusFrameTextureFrame.HealthBarText:SetPoint('CENTER', FocusFrameHealthBar, 'CENTER', 0, 0)
		FocusFrameTextureFrame.HealthBarText:SetScale(0.85)
		FocusFrameTextureFrame.HealthBarTextLeft:SetPoint('LEFT', FocusFrameHealthBar, 'LEFT', 1, 0)
		FocusFrameTextureFrame.HealthBarTextLeft:SetScale(0.85)
		FocusFrameTextureFrame.HealthBarTextRight:SetPoint('RIGHT', FocusFrameHealthBar, 'RIGHT', -5, 0)
		FocusFrameTextureFrame.HealthBarTextRight:SetScale(0.85)
		FocusFrameTextureFrame.ManaBarText:SetPoint('CENTER', FocusFrameManaBar, 'CENTER', 0, -1)
		FocusFrameTextureFrame.ManaBarText:SetScale(0.75)
		FocusFrameTextureFrame.ManaBarTextLeft:SetPoint('LEFT', FocusFrameManaBar, 'LEFT', 2, -1)
		FocusFrameTextureFrame.ManaBarTextLeft:SetScale(0.75)
		FocusFrameTextureFrame.ManaBarTextRight:SetPoint('RIGHT', FocusFrameManaBar, 'RIGHT', -7, -1)
		FocusFrameTextureFrame.ManaBarTextRight:SetScale(0.75)
		-- FocusFrameTextureFrameName:ClearAllPoints()
		FocusFrameTextureFrameName:SetPoint('CENTER', FocusFrameNameBackground, 'CENTER', 0, -1)
		FocusFrameNameBackground:SetVertexColor(0, 0, 0, 0.5)
		FocusFrameNameBackground.SetVertexColor = function()
		end
		FocusFrame:HookScript(
			'OnUpdate',
			function()
				if UnitHealth('focus') > 0 then
					FocusFrameTextureFrame.HealthBarText:SetText(xVermin.FormatValue(UnitHealth('focus')) .. ' / ' .. xVermin.FormatValue(UnitHealthMax('focus')))
				else
					FocusFrameTextureFrame.HealthBarText:Hide()
					FocusFrameTextureFrame.ManaBarText:Hide()
				end
			end
		)

		xVermin.CheckIfLoadedWithTimer(
			'PetFrame',
			function()
				PetFrameHealthBarText:Hide()
				PetFrameHealthBarTextLeft:Hide()
				PetFrameHealthBarTextRight:Hide()
				PetFrameHealthBarText.Show = function()
				end
				PetFrameHealthBarTextLeft.Show = function()
				end
				PetFrameHealthBarTextRight.Show = function()
				end
				PetFrameManaBarText:Hide()
				PetFrameManaBarTextLeft:Hide()
				PetFrameManaBarTextRight:Hide()
				PetFrameManaBarText.Show = function()
				end
				PetFrameManaBarTextLeft.Show = function()
				end
				PetFrameManaBarTextRight.Show = function()
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
)

-- local f = Test or CreateFrame('Frame', 'Test', UIParent)

-- local function TestPrint(self, key)
-- 	ChatFrame6:AddMessage(self:GetName() .. ': ' .. key)
-- end

-- f:SetScript('OnKeyDown', TestPrint)
-- f:SetPropagateKeyboardInput(true)

-- PlayerFrame:HookScript(
-- 	'OnUpdate',
-- 	function()
-- 		print(xVermin.R6_Occupied)
-- 	end
-- )

FixArenaFrames = function()
	ArenaEnemyFrame1:ClearAllPoints()
	ArenaEnemyFrame1:SetPoint('RIGHT', PlayerFrame, 'LEFT', -100, -50)
	ArenaEnemyFrame1HealthBarTextLeft:SetScale(0.7)
	ArenaEnemyFrame1HealthBarTextRight:SetScale(0.7)

	ArenaEnemyFrame2:ClearAllPoints()
	ArenaEnemyFrame2:SetPoint('RIGHT', PlayerFrame, 'LEFT', -100, -100)
	ArenaEnemyFrame2HealthBarTextLeft:SetScale(0.7)
	ArenaEnemyFrame2HealthBarTextRight:SetScale(0.7)

	ArenaEnemyFrame3:ClearAllPoints()
	ArenaEnemyFrame3:SetPoint('RIGHT', PlayerFrame, 'LEFT', -100, -150)
	ArenaEnemyFrame3HealthBarTextLeft:SetScale(0.7)
	ArenaEnemyFrame3HealthBarTextRight:SetScale(0.7)

	ArenaEnemyFrame1.SetPoint = function()
	end
	ArenaEnemyFrame2.SetPoint = function()
	end
	ArenaEnemyFrame3.SetPoint = function()
	end

	ArenaEnemyFrames:SetScale(1.2)
end

if IsAddOnLoaded('Blizzard_ArenaUI') then
	FixArenaFrames()
else
	local f = CreateFrame('Frame')
	f:RegisterEvent('ADDON_LOADED')
	f:SetScript(
		'OnEvent',
		function(self, event, addonName)
			if addonName ~= 'Blizzard_ArenaUI' then
				return
			end

			FixArenaFrames()

			self:UnregisterEvent('ADDON_LOADED')
			self:SetScript('OnEvent', nil)
		end
	)
end
