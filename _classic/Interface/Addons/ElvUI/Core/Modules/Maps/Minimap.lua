local E, L, V, P, G = unpack(ElvUI)
local M = E:GetModule('Minimap')
local AB = E:GetModule('ActionBars')
local LSM = E.Libs.LSM

local _G = _G
local next = next
local sort = sort
local ipairs = ipairs
local unpack = unpack
local tinsert = tinsert
local hooksecurefunc = hooksecurefunc
local utf8sub = string.utf8sub

local CloseAllWindows = CloseAllWindows
local CloseMenus = CloseMenus
local CreateFrame = CreateFrame
local GetMinimapZoneText = GetMinimapZoneText
local GetZonePVPInfo = GetZonePVPInfo
local HideUIPanel = HideUIPanel
local InCombatLockdown = InCombatLockdown
local IsShiftKeyDown = IsShiftKeyDown
local PlaySound = PlaySound
local ShowUIPanel = ShowUIPanel
local ToggleFrame = ToggleFrame
local UIParent = UIParent
local UIParentLoadAddOn = UIParentLoadAddOn
local EasyMenu = EasyMenu

local MainMenuMicroButton = MainMenuMicroButton
local MainMenuMicroButton_SetNormal = MainMenuMicroButton_SetNormal
local UIDropDownMenu_RefreshAll = UIDropDownMenu_RefreshAll

local IsAddOnLoaded = (C_AddOns and C_AddOns.IsAddOnLoaded) or IsAddOnLoaded

local WorldMapFrame = _G.WorldMapFrame
local MinimapCluster = _G.MinimapCluster
local Minimap = _G.Minimap

local IndicatorLayout

-- GLOBALS: GetMinimapShape

local DifficultyIcons = { 'ChallengeMode', 'Guild', 'Instance' }
local IconParents = {}

--Create the minimap micro menu
local menuFrame = CreateFrame('Frame', 'MinimapRightClickMenu', E.UIParent, 'UIDropDownMenuTemplate')
local menuList = {
	{ text = _G.CHARACTER_BUTTON, microOffset = 'CharacterMicroButton', func = function() _G.ToggleCharacter('PaperDollFrame') end },
	{ text = _G.SPELLBOOK_ABILITIES_BUTTON, microOffset = 'SpellbookMicroButton', func = function() ToggleFrame(_G.SpellBookFrame) end },
	{ text = _G.TIMEMANAGER_TITLE, func = function() ToggleFrame(_G.TimeManagerFrame) end, icon = 134376, cropIcon = 1 }, -- Interface\ICONS\INV_Misc_PocketWatch_01
	{ text = _G.CHAT_CHANNELS, func = function() _G.ToggleChannelFrame() end, icon = 2056011, cropIcon = 1 }, -- Interface\ICONS\UI_Chat
	{ text = _G.SOCIAL_BUTTON, func =  function() _G.ToggleFriendsFrame() end, icon = 796351, cropIcon = 10 }, -- Interface\FriendsFrame\Battlenet-BattlenetIcon
	{ text = _G.TALENTS_BUTTON, microOffset = 'TalentMicroButton', func =  function() _G.ToggleTalentFrame() end },
	{ text = _G.GUILD, microOffset = 'GuildMicroButton', func = function() if E.Retail then _G.ToggleGuildFrame() else _G.ToggleFriendsFrame(3) end end },
}

if E.Wrath and E.mylevel >= _G.SHOW_PVP_LEVEL then
	tinsert(menuList, { text = _G.PLAYER_V_PLAYER, microOffset = 'PVPMicroButton', func = function() _G.TogglePVPFrame() end })
end

if E.Retail or E.Wrath then
	tinsert(menuList, { text = _G.COLLECTIONS, microOffset = 'CollectionsMicroButton', func = function() _G.ToggleCollectionsJournal() end, icon = E.Media.Textures.GoldCoins }) -- Interface\ICONS\INV_Misc_Coin_01
	tinsert(menuList, { text = _G.ACHIEVEMENT_BUTTON, microOffset = 'AchievementMicroButton', func = function() _G.ToggleAchievementFrame() end })
	tinsert(menuList, { text = _G.LFG_TITLE, microOffset = E.Retail and 'LFDMicroButton' or 'LFGMicroButton', func = function() if E.Retail then _G.ToggleLFDParentFrame() else _G.PVEFrame_ToggleFrame() end end })
	tinsert(menuList, { text = L["Calendar"], func = function() _G.GameTimeFrame:Click() end, icon = 235486, cropIcon = 1 }) -- Interface\Calendar\MeetingIcon
end

if E.Retail then
	tinsert(menuList, { text = _G.BLIZZARD_STORE, microOffset = 'StoreMicroButton', func = function() _G.StoreMicroButton:Click() end })
	tinsert(menuList, { text = _G.GARRISON_TYPE_8_0_LANDING_PAGE_TITLE, microOffset = 'QuestLogMicroButton', func = function() _G.ExpansionLandingPageMinimapButton:ToggleLandingPage() end })
	tinsert(menuList, { text = _G.ENCOUNTER_JOURNAL, microOffset = 'EJMicroButton', func = function() if not IsAddOnLoaded('Blizzard_EncounterJournal') then UIParentLoadAddOn('Blizzard_EncounterJournal') end ToggleFrame(_G.EncounterJournal) end })
else
	tinsert(menuList, { text = _G.QUEST_LOG, microOffset = 'QuestLogMicroButton', func = function() ToggleFrame(_G.QuestLogFrame) end })
end

sort(menuList, function(a, b) if a and b and a.text and b.text then return a.text < b.text end end)

-- want these two on the bottom
tinsert(menuList, {
	text = _G.MAINMENU_BUTTON,
	microOffset = 'MainMenuMicroButton',
	func = function()
		if not _G.GameMenuFrame:IsShown() then
			if not E.Retail then
				if _G.VideoOptionsFrame:IsShown() then
					_G.VideoOptionsFrameCancel:Click()
				elseif _G.AudioOptionsFrame:IsShown() then
					_G.AudioOptionsFrameCancel:Click()
				elseif _G.InterfaceOptionsFrame:IsShown() then
					_G.InterfaceOptionsFrameCancel:Click()
				end
			end

			CloseMenus()
			CloseAllWindows()
			PlaySound(850) --IG_MAINMENU_OPEN
			ShowUIPanel(_G.GameMenuFrame)
		else
			PlaySound(854) --IG_MAINMENU_QUIT
			HideUIPanel(_G.GameMenuFrame)

			if E.Retail then
				MainMenuMicroButton:SetButtonState('NORMAL')
			else
				MainMenuMicroButton_SetNormal()
			end
		end
	end
})

tinsert(menuList, { text = _G.HELP_BUTTON, microOffset = not E.Retail and 'HelpMicroButton' or nil, bottom = true, func = function() _G.ToggleHelpFrame() end, icon = 132088, cropIcon = 8 })

M.RightClickMenu = menuFrame
M.RightClickMenuList = menuList

function M:SetScale(frame, scale)
	frame:SetIgnoreParentScale(true)
	frame:SetScale(scale * E.uiscale)
end

function M:HandleExpansionButton()
	local garrison = _G.ExpansionLandingPageMinimapButton or _G.GarrisonLandingPageMinimapButton
	if not garrison then return end

	M:SaveIconParent(garrison)

	local hidden = not Minimap:IsShown()
	if hidden then
		garrison:SetParent(E.HiddenFrame)
	else
		local scale, position, xOffset, yOffset = M:GetIconSettings('classHall')
		garrison:ClearAllPoints()
		garrison:Point(position, Minimap, xOffset, yOffset)
		M:SetIconParent(garrison)
		M:SetScale(garrison, scale)

		local box = _G.GarrisonLandingPageTutorialBox
		if box then
			box:SetScale(1 / scale)
			box:SetClampedToScreen(true)
		end
	end
end

function M:HandleTrackingButton()
	local tracking = MinimapCluster.TrackingFrame or _G.MiniMapTrackingFrame or _G.MiniMapTracking
	if not tracking then return end

	M:SaveIconParent(tracking)

	tracking:ClearAllPoints()

	local hidden = not Minimap:IsShown()
	if hidden or E.private.general.minimap.hideTracking then
		tracking:SetParent(E.HiddenFrame)
	else
		local scale, position, xOffset, yOffset = M:GetIconSettings('tracking')

		tracking:Point(position, Minimap, xOffset, yOffset)
		M:SetIconParent(tracking)
		M:SetScale(tracking, scale)

		local button = E.Retail and tracking.Button
		if button and (button:GetScript('OnMouseDown') ~= M.TrackingButton_OnMouseDown) then
			button:SetScript('OnMouseDown', M.TrackingButton_OnMouseDown)
		end

		if _G.MiniMapTrackingButtonBorder then
			_G.MiniMapTrackingButtonBorder:Hide()
		end

		if _G.MiniMapTrackingBorder then
			_G.MiniMapTrackingBorder:Hide()
		end

		if _G.MiniMapTrackingBackground then
			_G.MiniMapTrackingBackground:Hide()
		end

		if _G.MiniMapTrackingIcon then
			_G.MiniMapTrackingIcon:SetDrawLayer('ARTWORK')
			_G.MiniMapTrackingIcon:SetTexCoord(unpack(E.TexCoords))
			_G.MiniMapTrackingIcon:SetInside()
		end
	end
end

function M:SetupHybridMinimap()
	local MapCanvas = _G.HybridMinimap.MapCanvas
	MapCanvas:SetScript('OnMouseWheel', M.Minimap_OnMouseWheel)
	MapCanvas:SetScript('OnMouseDown', M.MapCanvas_OnMouseDown)
	MapCanvas:SetScript('OnMouseUp', E.noop)
	MapCanvas:SetMaskTexture()

	_G.HybridMinimap.CircleMask:StripTextures()
end

function M:HideNonInstancePanels()
	if InCombatLockdown() or not WorldMapFrame:IsShown() then return end

	HideUIPanel(WorldMapFrame)
end

function M:ADDON_LOADED(_, addon)
	if addon == 'Blizzard_TimeManager' then
		_G.TimeManagerClockButton:Kill()
	elseif addon == 'Blizzard_HybridMinimap' then
		M:SetupHybridMinimap()
	elseif addon == 'Blizzard_EncounterJournal' then
		-- Since the default non-quest map is full screen, it overrides the showing of the encounter journal
		hooksecurefunc('EJ_HideNonInstancePanels', M.HideNonInstancePanels)
	end
end

function M:CreateMinimapTrackingDropdown()
	local dropdown = CreateFrame('Frame', 'ElvUIMiniMapTrackingDropDown', UIParent, 'UIDropDownMenuTemplate')
	dropdown:SetID(1)
	dropdown:SetClampedToScreen(true)
	dropdown:Hide()

	_G.UIDropDownMenu_Initialize(dropdown, _G.MiniMapTrackingDropDown_Initialize, 'MENU')
	dropdown.noResize = true

	return dropdown
end

function M:MinimapTracking_UpdateTracking()
	if _G.UIDROPDOWNMENU_OPEN_MENU == M.TrackingDropdown then
		UIDropDownMenu_RefreshAll(M.TrackingDropdown)
	end
end

function M:Minimap_OnShow()
	M:UpdateIcons()
end

function M:Minimap_OnHide()
	M:UpdateIcons()
end

function M:Minimap_OnEnter()
	M:Minimap_EnterLeave(self, true)
end

function M:Minimap_OnLeave()
	M:Minimap_EnterLeave(self)
end

function M:Minimap_EnterLeave(minimap, show)
	if E.db.general.minimap.locationText == 'MOUSEOVER' and (not E.Retail or E.db.general.minimap.clusterDisable) then
		minimap.location:SetShown(show)
	end
end

function M:Minimap_OnMouseDown(btn)
	menuFrame:Hide()

	if M.TrackingDropdown then
		_G.HideDropDownMenu(1, nil, M.TrackingDropdown)
	end

	local position = M.MapHolder.mover:GetPoint()
	if btn == 'MiddleButton' or (btn == 'RightButton' and IsShiftKeyDown()) then
		if not E:AlertCombat() then
			EasyMenu(menuList, menuFrame, 'cursor', position:match('LEFT') and 0 or -160, 0, 'MENU')
		end
	elseif btn == 'RightButton' and M.TrackingDropdown then
		_G.ToggleDropDownMenu(1, nil, M.TrackingDropdown, 'cursor')
	elseif E.Retail then
		Minimap.OnClick(self)
	else
		_G.Minimap_OnClick(self)
	end
end

function M:MapCanvas_OnMouseDown(btn)
	menuFrame:Hide()

	if M.TrackingDropdown then
		_G.HideDropDownMenu(1, nil, M.TrackingDropdown)
	end

	local position = M.MapHolder.mover:GetPoint()
	if btn == 'MiddleButton' or (btn == 'RightButton' and IsShiftKeyDown()) then
		if not E:AlertCombat() then
			EasyMenu(menuList, menuFrame, 'cursor', position:match('LEFT') and 0 or -160, 0, 'MENU')
		end
	elseif btn == 'RightButton' and M.TrackingDropdown then
		_G.ToggleDropDownMenu(1, nil, M.TrackingDropdown, 'cursor')
	end
end

function M:TrackingButton_OnMouseDown()
	if M.TrackingDropdown then
		_G.ToggleDropDownMenu(1, nil, M.TrackingDropdown, 'cursor')
	end
end

function M:Minimap_OnMouseWheel(d)
	local zoomIn = E.Retail and Minimap.ZoomIn or _G.MinimapZoomIn
	local zoomOut = E.Retail and Minimap.ZoomOut or _G.MinimapZoomOut

	if d > 0 then
		zoomIn:Click()
	elseif d < 0 then
		zoomOut:Click()
	end
end

function M:GetLocTextColor()
	local pvpType = GetZonePVPInfo()
	if pvpType == 'arena' then
		return 0.84, 0.03, 0.03
	elseif pvpType == 'friendly' then
		return 0.05, 0.85, 0.03
	elseif pvpType == 'contested' then
		return 0.9, 0.85, 0.05
	elseif pvpType == 'hostile' then
		return 0.84, 0.03, 0.03
	elseif pvpType == 'sanctuary' then
		return 0.035, 0.58, 0.84
	elseif pvpType == 'combat' then
		return 0.84, 0.03, 0.03
	else
		return 0.9, 0.85, 0.05
	end
end

function M:Update_ZoneText()
	if E.db.general.minimap.locationText == 'HIDE' then return end

	Minimap.location:SetText(utf8sub(GetMinimapZoneText(), 1, 46))
	Minimap.location:SetTextColor(M:GetLocTextColor())
end

do
	local isResetting
	local function ResetZoom()
		Minimap:SetZoom(0)

		local zoomIn = E.Retail and Minimap.ZoomIn or _G.MinimapZoomIn
		local zoomOut = E.Retail and Minimap.ZoomOut or _G.MinimapZoomOut

		zoomIn:Enable() -- Reset enabled state of buttons
		zoomOut:Disable()

		isResetting = false
	end

	local function SetupZoomReset()
		if E.db.general.minimap.resetZoom.enable and not isResetting then
			isResetting = true

			E:Delay(E.db.general.minimap.resetZoom.time, ResetZoom)
		end
	end

	hooksecurefunc(Minimap, 'SetZoom', SetupZoomReset)
end

function M:GetIconSettings(button)
	local defaults = P.general.minimap.icons[button]
	local profile = E.db.general.minimap.icons[button]

	return profile.scale or defaults.scale, profile.position or defaults.position, profile.xOffset or defaults.xOffset, profile.yOffset or defaults.yOffset
end

function M:SaveIconParent(frame)
	if not IconParents[frame] then -- only want the first one
		IconParents[frame] = frame:GetParent()
	end
end

function M:SetIconParent(frame)
	local parent = IconParents[frame]
	if parent then -- this is unlikely
		frame:SetParent(parent)
	end
end

function M:UpdateIcons()
	local gameTime = _G.GameTimeFrame
	local indicator = MinimapCluster.IndicatorFrame
	local craftingFrame = indicator and indicator.CraftingOrderFrame
	local mailFrame = (indicator and indicator.MailFrame) or _G.MiniMapMailFrame
	local difficulty = MinimapCluster.InstanceDifficulty or _G.MiniMapInstanceDifficulty
	local battlefieldFrame = _G.MiniMapBattlefieldFrame

	if not next(IconParents) then
		if gameTime then M:SaveIconParent(gameTime) end
		if indicator then M:SaveIconParent(indicator) end
		if craftingFrame then M:SaveIconParent(craftingFrame) end
		if mailFrame then M:SaveIconParent(mailFrame) end
		if battlefieldFrame then M:SaveIconParent(battlefieldFrame) end
		if difficulty then M:SaveIconParent(difficulty) end
	end

	if difficulty and E.Retail then
		local r, g, b = unpack(E.media.backdropcolor)
		local r2, g2, b2, a2 = unpack(E.media.backdropfadecolor)
		for _, name in next, DifficultyIcons do
			local frame = difficulty[name]
			if frame then
				if frame.Border then
					frame.Border:SetVertexColor(r, g, b)
				end
				if frame.Background then
					frame.Background:SetVertexColor(r2, g2, b2, a2)
				end
			end
		end
	end

	local noCluster = not E.Retail or E.db.general.minimap.clusterDisable
	if not noCluster then
		if M.ClusterHolder then
			E:EnableMover(M.ClusterHolder.mover.name)
		end

		if difficulty then
			difficulty:ClearAllPoints()
			difficulty:SetPoint('TOPRIGHT', MinimapCluster, 0, -25)
			M:SetIconParent(difficulty)
			M:SetScale(difficulty, 1)
		end

		if gameTime then M:SetIconParent(gameTime) end
		if craftingFrame then M:SetIconParent(craftingFrame) end
		if mailFrame then M:SetIconParent(mailFrame) end
		if battlefieldFrame then M:SetIconParent(battlefieldFrame) end
	else
		if M.ClusterHolder then
			E:DisableMover(M.ClusterHolder.mover.name)
		end

		M.HandleTrackingButton()
		M.HandleExpansionButton()

		local hidden = not Minimap:IsShown()
		if gameTime then
			if hidden or E.private.general.minimap.hideCalendar then
				gameTime:SetParent(E.HiddenFrame)
			else
				local scale, position, xOffset, yOffset = M:GetIconSettings('calendar')
				gameTime:ClearAllPoints()
				gameTime:Point(position, Minimap, xOffset, yOffset)
				gameTime:SetParent(Minimap)
				gameTime:SetFrameLevel(_G.MinimapBackdrop:GetFrameLevel() + 2)
				M:SetIconParent(gameTime)
				M:SetScale(gameTime, scale)
			end
		end

		if craftingFrame then
			if hidden then
				craftingFrame:SetParent(E.HiddenFrame)
			else
				local scale, position, xOffset, yOffset = M:GetIconSettings('crafting')
				craftingFrame:ClearAllPoints()
				craftingFrame:Point(position, Minimap, xOffset, yOffset)
				M:SetIconParent(craftingFrame)
				M:SetScale(craftingFrame, scale)
			end
		end

		if mailFrame then
			if hidden then
				mailFrame:SetParent(E.HiddenFrame)
			else
				local scale, position, xOffset, yOffset = M:GetIconSettings('mail')
				mailFrame:ClearAllPoints()
				mailFrame:Point(position, Minimap, xOffset, yOffset)
				M:SetIconParent(mailFrame)
				M:SetScale(mailFrame, scale)
			end
		end

		if battlefieldFrame then
			if hidden then
				battlefieldFrame:SetParent(E.HiddenFrame)
			else
				local scale, position, xOffset, yOffset = M:GetIconSettings('battlefield')
				battlefieldFrame:ClearAllPoints()
				battlefieldFrame:Point(position, Minimap, xOffset, yOffset)
				M:SetIconParent(battlefieldFrame)
				M:SetScale(battlefieldFrame, scale)
			end

			if _G.BattlegroundShine then _G.BattlegroundShine:Hide() end
			if _G.MiniMapBattlefieldBorder then _G.MiniMapBattlefieldBorder:Hide() end
			if _G.MiniMapBattlefieldIcon then _G.MiniMapBattlefieldIcon:SetTexCoord(unpack(E.TexCoords)) end
		end

		if difficulty then
			if hidden then
				difficulty:SetParent(E.HiddenFrame)
			else
				local scale, position, xOffset, yOffset = M:GetIconSettings('difficulty')
				difficulty:ClearAllPoints()
				difficulty:Point(position, Minimap, xOffset, yOffset)
				M:SetIconParent(difficulty)
				M:SetScale(difficulty, scale)
			end
		end
	end
end

function M:UpdateSettings()
	if not M.Initialized then return end

	local noCluster = not E.Retail or E.db.general.minimap.clusterDisable
	E.MinimapSize = E.db.general.minimap.size or Minimap:GetWidth()

	local indicator = MinimapCluster.IndicatorFrame
	if indicator then
		-- save original indicator layout function
		if not IndicatorLayout then
			IndicatorLayout = indicator.Layout
		end

		-- use this to prevent no cluster mode moving mail icon
		local layoutCall = (noCluster and E.noop) or IndicatorLayout
		if indicator.Layout ~= layoutCall then
			indicator.Layout = layoutCall

			-- let it update once because we changed the setting back to cluster
			if layoutCall == IndicatorLayout then
				layoutCall(indicator)
			end
		end
	end

	-- handle the icons placed around the minimap (also the cluster)
	M:UpdateIcons()

	-- silly little hack to get the canvas to update
	if E.MinimapSize ~= M.NeedsCanvasUpdate then
		local zoom = Minimap:GetZoom()
		Minimap:SetZoom(zoom > 0 and 0 or 1)
		Minimap:SetZoom(zoom)
		M.NeedsCanvasUpdate = E.MinimapSize
	end

	local panel, holder = _G.MinimapPanel, M.MapHolder
	panel:SetShown(E.db.datatexts.panels.MinimapPanel.enable)
	M:SetScale(panel, 1)

	local mmOffset = E.PixelMode and 1 or 3
	local mmScale = E.db.general.minimap.scale
	Minimap:ClearAllPoints()
	Minimap:Point('TOPRIGHT', holder, -mmOffset/mmScale, -mmOffset/mmScale)
	Minimap:Size(E.MinimapSize)

	local mWidth, mHeight = Minimap:GetSize()
	local bWidth, bHeight = E:Scale(E.PixelMode and 2 or 6), E:Scale(E.PixelMode and 2 or 8)
	local panelSize, joinPanel = (panel:IsShown() and panel:GetHeight()) or E:Scale(E.PixelMode and 1 or -1), E:Scale(1)
	local HEIGHT, WIDTH = (mHeight * mmScale) + (panelSize - joinPanel), mWidth * mmScale
	holder:SetSize(WIDTH + bWidth, HEIGHT + bHeight)

	local locationFont, locaitonSize, locationOutline = LSM:Fetch('font', E.db.general.minimap.locationFont), E.db.general.minimap.locationFontSize, E.db.general.minimap.locationFontOutline
	if Minimap.location then
		Minimap.location:Width(E.MinimapSize)
		Minimap.location:FontTemplate(locationFont, locaitonSize, locationOutline)
		Minimap.location:SetShown(E.db.general.minimap.locationText == 'SHOW' and noCluster)
	end

	_G.MiniMapMailIcon:SetTexture(E.Media.MailIcons[E.db.general.minimap.icons.mail.texture] or E.Media.MailIcons.Mail3)
	_G.MiniMapMailIcon:Size(20)

	if not E.Retail then
		Minimap:SetScale(mmScale)
	else
		MinimapCluster:SetScale(mmScale)

		local mcWidth = MinimapCluster:GetWidth()
		local height, width = 20 * mmScale, (mcWidth - 30) * mmScale
		M.ClusterHolder:SetSize(width, height)
		M.ClusterBackdrop:SetSize(width, height)
		M.ClusterBackdrop:SetShown(E.db.general.minimap.clusterBackdrop and not noCluster)

		_G.MinimapZoneText:FontTemplate(locationFont, locaitonSize, locationOutline)
		_G.TimeManagerClockTicker:FontTemplate(LSM:Fetch('font', E.db.general.minimap.timeFont), E.db.general.minimap.timeFontSize, E.db.general.minimap.timeFontOutline)

		if noCluster then
			MinimapCluster.ZoneTextButton:Kill()
			_G.TimeManagerClockButton:Kill()
		else
			MinimapCluster.ZoneTextButton.Show = nil
			MinimapCluster.ZoneTextButton:SetParent(MinimapCluster)
			MinimapCluster.ZoneTextButton:RegisterEvent('UPDATE_BINDINGS')
			MinimapCluster.ZoneTextButton:Show()

			_G.TimeManagerClockButton.Show = nil
			_G.TimeManagerClockButton:SetParent(MinimapCluster)
			_G.TimeManagerClockButton:Show()
		end
	end
end

function M:Minimap_PostDrag()
	_G.MinimapBackdrop:ClearAllPoints()
	_G.MinimapBackdrop:SetAllPoints(Minimap)
end

function M:GetMinimapShape()
	return 'SQUARE'
end

function M:SetGetMinimapShape()
	GetMinimapShape = M.GetMinimapShape

	Minimap:Size(E.db.general.minimap.size)
end

function M:ClusterSize(width, height)
	local holder = M.ClusterHolder
	if holder and (width ~= holder.savedWidth or height ~= holder.savedHeight) then
		self:SetSize(holder.savedWidth, holder.savedHeight)
	end
end

function M:ClusterPoint(_, anchor)
	local noCluster = not E.Retail or E.db.general.minimap.clusterDisable
	local frame = (noCluster and UIParent) or M.ClusterHolder

	if anchor ~= frame then
		MinimapCluster:ClearAllPoints()
		MinimapCluster:Point('TOPRIGHT', frame, 0, noCluster and 0 or 1)
	end
end

function M:Initialize()
	if E.private.general.minimap.enable then
		Minimap:SetMaskTexture(E.Retail and 130937 or [[interface\chatframe\chatframebackground]])
	else
		Minimap:SetMaskTexture(E.Retail and 186178 or [[textures\minimapmask]])

		return
	end

	for _, menu in ipairs(menuList) do
		menu.notCheckable = true

		if menu.cropIcon then
			local left = 0.02 * menu.cropIcon
			local right = 1 - left
			menu.tCoordLeft, menu.tCoordRight, menu.tCoordTop, menu.tCoordBottom = left, right, left, right
			menu.cropIcon = nil
		end

		if menu.microOffset then
			local left, right, top, bottom = AB:GetMicroCoords(menu.microOffset, true)
			menu.tCoordLeft, menu.tCoordRight, menu.tCoordTop, menu.tCoordBottom = left, right, top, bottom
			menu.icon = menu.microOffset == 'PVPMicroButton' and ((E.myfaction == 'Horde' and E.Media.Textures.PVPHorde) or E.Media.Textures.PVPAlliance) or E.Media.Textures.MicroBar
			menu.microOffset = nil
		end
	end

	M.Initialized = true

	menuFrame:SetTemplate('Transparent')

	local mapHolder = CreateFrame('Frame', 'ElvUI_MinimapHolder', Minimap)
	mapHolder:Point('TOPRIGHT', E.UIParent, -3, -3)
	mapHolder:Size(Minimap:GetSize())
	E:CreateMover(mapHolder, 'MinimapMover', L["Minimap"], nil, nil, M.Minimap_PostDrag, nil, nil, 'maps,minimap')
	M.MapHolder = mapHolder
	M:SetScale(mapHolder, 1)

	if E.Retail then
		MinimapCluster:KillEditMode()

		local clusterHolder = CreateFrame('Frame', 'ElvUI_MinimapClusterHolder', MinimapCluster)
		clusterHolder.savedWidth, clusterHolder.savedHeight = MinimapCluster:GetSize()
		clusterHolder:Point('TOPRIGHT', E.UIParent, -3, -3)
		clusterHolder:SetSize(clusterHolder.savedWidth, clusterHolder.savedHeight)
		clusterHolder:SetFrameLevel(10) -- over minimap mover
		E:CreateMover(clusterHolder, 'MinimapClusterMover', L["Minimap Cluster"], nil, nil, nil, nil, nil, 'maps,minimap')
		M.ClusterHolder = clusterHolder

		local clusterBackdrop = CreateFrame('Frame', 'ElvUI_MinimapClusterBackdrop', MinimapCluster)
		clusterBackdrop:Point('TOPRIGHT', 0, -1)
		clusterBackdrop:SetTemplate()
		M:SetScale(clusterBackdrop, 1)
		M.ClusterBackdrop = clusterBackdrop

		--Hide the BlopRing on Minimap
		Minimap:SetArchBlobRingAlpha(0)
		Minimap:SetArchBlobRingScalar(0)
		Minimap:SetQuestBlobRingAlpha(0)
		Minimap:SetQuestBlobRingScalar(0)
	end

	M:ClusterPoint()
	MinimapCluster:EnableMouse(false)
	MinimapCluster:SetFrameLevel(20) -- set before minimap itself
	hooksecurefunc(MinimapCluster, 'SetPoint', M.ClusterPoint)
	hooksecurefunc(MinimapCluster, 'SetSize', M.ClusterSize)

	Minimap:EnableMouseWheel(true)
	Minimap:SetFrameLevel(10)
	Minimap:SetFrameStrata('LOW')
	Minimap:CreateBackdrop()

	if Minimap.backdrop then -- level to hybrid maps fixed values
		Minimap.backdrop:SetFrameLevel(99)
		Minimap.backdrop:SetFrameStrata('BACKGROUND')
		M:SetScale(Minimap.backdrop, 1)
	end

	Minimap.location = Minimap:CreateFontString(nil, 'OVERLAY')
	Minimap.location:Point('TOP', Minimap, 0, -2)
	Minimap.location:SetJustifyH('CENTER')
	Minimap.location:SetJustifyV('MIDDLE')
	Minimap.location:Hide() -- Fixes blizzard's font rendering issue, keep after M:SetScale
	M:SetScale(Minimap.location, 1)

	M:RegisterEvent('PLAYER_ENTERING_WORLD', 'Update_ZoneText')
	M:RegisterEvent('ZONE_CHANGED_NEW_AREA', 'Update_ZoneText')
	M:RegisterEvent('ZONE_CHANGED_INDOORS', 'Update_ZoneText')
	M:RegisterEvent('ZONE_CHANGED', 'Update_ZoneText')

	Minimap:SetScript('OnMouseWheel', M.Minimap_OnMouseWheel)
	Minimap:SetScript('OnMouseDown', M.Minimap_OnMouseDown)
	Minimap:SetScript('OnMouseUp', E.noop)

	Minimap:HookScript('OnShow', M.Minimap_OnShow)
	Minimap:HookScript('OnHide', M.Minimap_OnHide)

	Minimap:HookScript('OnEnter', M.Minimap_OnEnter)
	Minimap:HookScript('OnLeave', M.Minimap_OnLeave)

	local killFrames = {
		_G.MinimapBorder,
		_G.MinimapBorderTop,
		_G.MinimapCompassTexture,
		_G.MiniMapMailBorder,
		_G.MinimapNorthTag,
		_G.MiniMapWorldMapButton,
		_G.MinimapZoneTextButton,
		_G.MinimapZoomIn,
		_G.MinimapZoomOut,
		E.Retail and _G.MiniMapTracking or _G.MinimapToggleButton
	}

	if E.Retail then
		tinsert(killFrames, Minimap.ZoomIn)
		tinsert(killFrames, Minimap.ZoomOut)

		MinimapCluster.BorderTop:StripTextures()
		MinimapCluster.TrackingFrame.Background:StripTextures()

		M:RegisterEvent('MINIMAP_UPDATE_TRACKING', M.MinimapTracking_UpdateTracking)

		if _G.GarrisonLandingPageMinimapButton_UpdateIcon then
			hooksecurefunc('GarrisonLandingPageMinimapButton_UpdateIcon', M.HandleExpansionButton)
		else
			hooksecurefunc(_G.ExpansionLandingPageMinimapButton, 'UpdateIcon', M.HandleExpansionButton)
		end

		if E.private.general.minimap.hideClassHallReport then
			local garrison = _G.ExpansionLandingPageMinimapButton or _G.GarrisonLandingPageMinimapButton
			garrison:Kill()
			garrison.IsShown = function() return true end
		end
	end

	if E.Classic then
		hooksecurefunc('SetLookingForGroupUIAvailable', M.HandleTrackingButton)
	else --Create the new minimap tracking dropdown frame and initialize it
		M.TrackingDropdown = M:CreateMinimapTrackingDropdown()
	end

	if _G.TimeManagerClockButton then
		tinsert(killFrames, _G.TimeManagerClockButton)
	end

	for _, frame in next, killFrames do
		frame:Kill()
	end

	if _G.HybridMinimap then
		M:SetupHybridMinimap()
	end

	if _G.MiniMapLFGFrame then
		(E.Wrath and _G.MiniMapLFGFrameBorder or _G.MiniMapLFGBorder):Hide()
	end

	M:RegisterEvent('ADDON_LOADED')
	M:UpdateSettings()
end

E:RegisterModule(M:GetName())
