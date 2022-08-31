cfg = {}

--	Player frame.
function wPlayerFrame(self)
	PlayerStatusTexture:ClearAllPoints()
	PlayerStatusTexture:SetPoint('CENTER', PlayerFrame, 'CENTER', 16, 8)
	PlayerStatusTexture:SetTexture('Interface\\Addons\\' .. whoaAddon .. '\\media\\UI-Player-Status')
	self.name:ClearAllPoints()
	self.name:SetPoint('CENTER', PlayerFrame, 'CENTER', 50, 36)
	self.healthbar:SetPoint('TOPLEFT', 108, -24) --
	self.healthbar:SetSize(118, 28)
	self.healthbar.LeftText:ClearAllPoints()
	self.healthbar.LeftText:SetPoint('LEFT', self.healthbar, 'LEFT', 5, 0)
	self.healthbar.RightText:ClearAllPoints()
	self.healthbar.RightText:SetPoint('RIGHT', self.healthbar, 'RIGHT', -5, 0)
	self.healthbar.TextString:SetPoint('CENTER', self.healthbar, 'CENTER', 0, 0)
	self.manabar:SetSize(118, 8)
	self.manabar:ClearAllPoints()
	self.manabar:SetPoint('TOPLEFT', 108, -54)
	self.manabar.LeftText:ClearAllPoints()
	self.manabar.LeftText:SetPoint('LEFT', self.manabar, 'LEFT', 5, 0)
	self.manabar.RightText:ClearAllPoints()
	self.manabar.RightText:SetPoint('RIGHT', self.manabar, 'RIGHT', -5, 0)
	self.manabar.TextString:SetPoint('CENTER', self.manabar, 'CENTER', 0, 0)
	PlayerFrameGroupIndicatorText:ClearAllPoints()
	PlayerFrameGroupIndicatorText:SetPoint('CENTER', PlayerFrame, 'TOP', -41, -7)
	PlayerFrameGroupIndicatorLeft:ClearAllPoints()
	PlayerFrameGroupIndicatorLeft:SetPoint('BOTTOMLEFT', PlayerFrame, 'TOP', -65, -13)
	PlayerFrameGroupIndicatorRight:ClearAllPoints()
	PlayerFrameGroupIndicatorRight:SetPoint('BOTTOMLEFT', PlayerFrame, 'TOP', -41, -13)
end
hooksecurefunc('PlayerFrame_ToPlayerArt', wPlayerFrame)

function whoaUpdatePvPStatus()
	local path = cfg.frameMode
	if not path then
		path = 'light'
	end
	local factionGroup, factionName = UnitFactionGroup('player')
	if (UnitIsPVPFreeForAll('player')) then
		PlayerPVPIcon:SetTexture('Interface\\Addons\\' .. whoaAddon .. '\\media\\' .. path .. '\\UI-PVP-FFA')
	elseif (factionGroup and factionGroup ~= 'Neutral' and UnitIsPVP('player')) then
		PlayerPVPIcon:SetTexture('Interface\\Addons\\' .. whoaAddon .. '\\media\\' .. path .. '\\UI-PVP-' .. factionGroup)
	end
end
hooksecurefunc('PlayerFrame_UpdatePvPStatus', whoaUpdatePvPStatus)

function playerNameHide()
	if cfg.playerNameHide then
		PlayerName:Hide()
	else
		PlayerName:Show()
	end
end

--	Player vehicle frame.
function whoaVehicleFrame(self, vehicleType)
	if (vehicleType == 'Natural') then
		PlayerFrameVehicleTexture:SetTexture('Interface\\Vehicles\\UI-Vehicle-Frame-Organic')
		PlayerFrameFlash:SetTexture('Interface\\Vehicles\\UI-Vehicle-Frame-Organic-Flash')
		PlayerFrameFlash:SetTexCoord(-0.02, 1, 0.07, 0.86)
		self.healthbar:SetSize(103, 12)
		self.healthbar:SetPoint('TOPLEFT', 116, -41)
		self.manabar:SetSize(103, 12)
		self.manabar:SetPoint('TOPLEFT', 116, -52)
	else
		PlayerFrameVehicleTexture:SetTexture('Interface\\Vehicles\\UI-Vehicle-Frame')
		PlayerFrameFlash:SetTexture('Interface\\Vehicles\\UI-Vehicle-Frame-Flash')
		PlayerFrameFlash:SetTexCoord(-0.02, 1, 0.07, 0.86)
		self.healthbar:SetSize(100, 12)
		self.healthbar:SetPoint('TOPLEFT', 119, -41)
		self.manabar:SetSize(100, 12)
		self.manabar:SetPoint('TOPLEFT', 119, -52)
	end
	PlayerName:SetPoint('CENTER', 50, 23)
	PlayerFrameBackground:SetWidth(114)
end
-- hooksecurefunc("PlayerFrame_ToVehicleArt", whoaVehicleFrame)

-- vehicle switch
local whoaStatusFrame = CreateFrame('Frame', 'whoaStatusFrame')
whoaStatusFrame:SetScript(
	'OnEvent',
	function(self, event, ...)
		local arg1, arg2 = ...
		if (event == 'UNIT_ENTERED_VEHICLE') then
			if (arg1 == 'player') then
				if (arg2) then
					cfg.doVehicleFrame = true
				end
			end
		elseif (event == 'UNIT_EXITED_VEHICLE') then
			cfg.doVehicleFrame = false
		end
		return cfg.doVehicleFrame
	end
)

-- Vehicle color.
whoaStatusFrame:RegisterUnitEvent('PLAYER_ENTERING_WORLD')
whoaStatusFrame:RegisterUnitEvent('UNIT_ENTERED_VEHICLE')
whoaStatusFrame:RegisterUnitEvent('UNIT_EXITED_VEHICLE')
whoaStatusFrame:SetScript(
	'OnUpdate',
	function(self)
		if (cfg.doVehicleFrame) then
			PlayerFrameHealthBar:SetStatusBarColor(whoaUnitColor('pet'))
			PetFrameHealthBar:SetStatusBarColor(whoaUnitColor('player'))
		else
			PlayerFrameHealthBar:SetStatusBarColor(whoaUnitColor('player'))
			if UnitExists('pet') then
				PetFrameHealthBar:SetStatusBarColor(whoaUnitColor('pet'))
			end
		end
		TargetFrameHealthBar:SetStatusBarColor(whoaUnitColor('target'))
		FocusFrameHealthBar:SetStatusBarColor(whoaUnitColor('focus'))
		TargetFrameToTHealthBar:SetStatusBarColor(whoaUnitColor('targettarget'))
		FocusFrameToTHealthBar:SetStatusBarColor(whoaUnitColor('focustarget'))
		--	party statusbar
		for i = 1, 4 do
			if i then
				_G['PartyMemberFrame' .. i .. 'HealthBar']:SetStatusBarColor(whoaUnitColor('party' .. i))
			end
		end
		--	boss statusbar
		for i = 1, MAX_BOSS_FRAMES do
			if i then
				_G['Boss' .. i .. 'TargetFrameHealthBar']:SetStatusBarColor(whoaUnitColor('boss' .. i))
			end
		end
	end
)

-- -- Pet frame
function whoaPetFrame(self, override)
	self.healthbar:SetSize(68, 6)
	self.healthbar:ClearAllPoints()
	self.healthbar:SetPoint('CENTER', self, 'CENTER', 16, 0)
	-- self.healthbar.LeftText:ClearAllPoints();
	-- self.healthbar.LeftText:SetPoint("LEFT",self.healthbar,"BOTTOM",66,5);
	self.healthbar.RightText:ClearAllPoints()
	self.healthbar.RightText:SetPoint('CENTER', self.healthbar, 'BOTTOM', 0, 5)
	self.healthbar.TextString:ClearAllPoints()
	self.healthbar.TextString:SetPoint('CENTER', self.healthbar, 'BOTTOM', 0, 4)
	self.manabar:SetSize(68, 6)
	self.manabar:ClearAllPoints()
	self.manabar:SetPoint('CENTER', self, 'CENTER', 16, -8)
	self.manabar.LeftText:SetAlpha(0)
	self.manabar.RightText:ClearAllPoints()
	self.manabar.RightText:SetPoint('CENTER', self.manabar, 'TOP', 0, -4)
	self.manabar.TextString:ClearAllPoints()
	self.manabar.TextString:SetPoint('CENTER', self.manabar, 'TOP', 0, -4)
end
hooksecurefunc('PetFrame_Update', whoaPetFrame)

function petFramePercent()
	local happiness, damagePercentage, loyaltyRate = GetPetHappiness()
	local hasPetUI, isHunterPet = HasPetUI()
	if (happiness) then
		PetFrameHealthBarTextLeft:SetPoint('LEFT', PetFrameHealthBar, 'BOTTOM', 66, 5)
	else
		PetFrameHealthBarTextLeft:SetPoint('LEFT', PetFrameHealthBar, 'BOTTOM', 40, 5)
	end
end
hooksecurefunc('PetFrame_SetHappiness', petFramePercent)

function whoaPetFrameSelector(self, override)
	local path = cfg.frameMode
	if ((not PlayerFrame.animating) or (override)) then
		if (UnitIsVisible(self.unit) and PetUsesPetFrame() and not PlayerFrame.vehicleHidesPet) then
			if (UnitPowerMax(self.unit) == 0) then
				PetFrameTexture:SetTexture('Interface\\Addons\\' .. whoaAddon .. '\\media\\' .. path .. '\\UI-SmallTargetingFrame-NoMana')
			else
				PetFrameTexture:SetTexture('Interface\\Addons\\' .. whoaAddon .. '\\media\\' .. path .. '\\UI-SmallTargetingFrame')
			end
		end
	end
end
hooksecurefunc('PetFrame_Update', whoaPetFrameSelector)

local function petFrameBg()
	local background = CreateFrame('Frame', nil, PetFrame)
	background:SetFrameStrata('BACKGROUND')
	background:SetSize(70, 18)
	local texture = background:CreateTexture(nil, 'BACKGROUND', PetFrame)
	texture:SetColorTexture(0, 0, 0, 0.5)
	texture:SetAllPoints(background)
	background.texture = texture
	background:SetPoint('CENTER', 16, -5)
end
petFrameBg()
