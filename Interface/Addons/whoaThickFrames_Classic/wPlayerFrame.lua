--	Player frame.
local function playerFrame(self)
	if (cfg.whoaTexture == true) then
		self.healthbar:SetStatusBarTexture("Interface\\Addons\\whoaThickFrames_Classic\\media\\statusbar\\whoa");
	end
	PlayerStatusTexture:SetTexture("Interface\\Addons\\whoaThickFrames_Classic\\media\\UI-Player-Status");
	PlayerStatusTexture:ClearAllPoints();
	PlayerStatusTexture:SetPoint("CENTER", PlayerFrame, "CENTER",16, 8);
	PlayerFrameBackground:SetWidth(120);
	self.name:Hide();
	self.name:SetPoint("CENTER", PlayerFrame, "CENTER",50.5, 36);
	self.healthbar:SetPoint("TOPLEFT",108,-24);
	self.healthbar:SetHeight(28);
	self.healthbar.LeftText:SetPoint("LEFT",self.healthbar,"LEFT",5,0);	
	self.healthbar.RightText:SetPoint("RIGHT",self.healthbar,"RIGHT",-5,0);
	self.healthbar.TextString:SetPoint("CENTER", self.healthbar, "CENTER", 0, 0);
	self.manabar:SetPoint("TOPLEFT",108,-51);
	self.manabar.LeftText:SetPoint("LEFT",self.manabar,"LEFT",5,-1)		;
	self.manabar.RightText:SetPoint("RIGHT",self.manabar,"RIGHT",-4,-1);
	self.manabar.TextString:SetPoint("CENTER",self.manabar,"CENTER",0,-1);
	PlayerFrameGroupIndicatorText:SetPoint("BOTTOMLEFT", PlayerFrame,"TOP",0,-20);
	PlayerFrameGroupIndicatorLeft:Hide();
	PlayerFrameGroupIndicatorMiddle:Hide();
	PlayerFrameGroupIndicatorRight:Hide();
end
hooksecurefunc("PlayerFrame_ToPlayerArt", playerFrame)

local function playerFrameSelector(self)
	if (cfg.darkFrames == true) then
		PlayerFrameTexture:SetTexture("Interface\\Addons\\whoaThickFrames_Classic\\media\\dark\\UI-TargetingFrame");
		PlayerPVPIcon:SetTexture("Interface\\Addons\\whoaThickFrames_Classic\\media\\dark\\UI-PVP-FFA");
		if lortiUIaddon then
			PlayerPVPIcon:SetAlpha(1);
		end
	elseif (cfg.darkFrames == false) then
		PlayerFrameTexture:SetTexture("Interface\\Addons\\whoaThickFrames_Classic\\media\\light\\UI-TargetingFrame");
		PlayerPVPIcon:SetTexture("Interface\\TargetingFrame\\UI-PVP-FFA");
	end
end
hooksecurefunc("PlayerFrame_ToPlayerArt", playerFrameSelector)

function playerPvpIcon()
	local factionGroup, factionName = UnitFactionGroup("player");
	if ( factionGroup and factionGroup ~= "Neutral" and UnitIsPVP("player") ) then
		if cfg.darkFrames then
			PlayerPVPIcon:SetTexture("Interface\\Addons\\whoaThickFrames_Classic\\media\\dark\\UI-PVP-"..factionGroup);
		else
			PlayerPVPIcon:SetTexture("Interface\\TargetingFrame\\UI-PVP-"..factionGroup);
		end
	end
end
hooksecurefunc("PlayerFrame_UpdatePvPStatus", playerPvpIcon)

--	Player vehicle frame.
local function vehicleFrame(self, vehicleType)
		if ( vehicleType == "Natural" ) then
		PlayerFrameVehicleTexture:SetTexture("Interface\\Vehicles\\UI-Vehicle-Frame-Organic");
		PlayerFrameFlash:SetTexture("Interface\\Vehicles\\UI-Vehicle-Frame-Organic-Flash");
		PlayerFrameFlash:SetTexCoord(-0.02, 1, 0.07, 0.86);
		self.healthbar:SetSize(103,12);
		self.healthbar:SetPoint("TOPLEFT",116,-41);
		self.manabar:SetSize(103,12);
		self.manabar:SetPoint("TOPLEFT",116,-52);
	else
		PlayerFrameVehicleTexture:SetTexture("Interface\\Vehicles\\UI-Vehicle-Frame");
		PlayerFrameFlash:SetTexture("Interface\\Vehicles\\UI-Vehicle-Frame-Flash");
		PlayerFrameFlash:SetTexCoord(-0.02, 1, 0.07, 0.86);
		self.healthbar:SetSize(100,12);
		self.healthbar:SetPoint("TOPLEFT",119,-41);
		self.manabar:SetSize(100,12);
		self.manabar:SetPoint("TOPLEFT",119,-52);
	end
	PlayerName:SetPoint("CENTER",50,23);
	PlayerFrameBackground:SetWidth(114);
end
hooksecurefunc("PlayerFrame_ToVehicleArt", vehicleFrame)

-- Pet frame
local function petFrame()
	PetFrameHealthBarTextRight:SetPoint("RIGHT",PetFrameHealthBar,"RIGHT",2,0);
	PetFrameManaBarTextRight:SetPoint("RIGHT",PetFrameManaBar,"RIGHT",2,-5);
	if (cfg.styleFont) then
		PetFrameHealthBarTextLeft:SetPoint("LEFT",PetFrameHealthBar,"LEFT",0,0);
		PetFrameHealthBarTextRight:SetPoint("RIGHT",PetFrameHealthBar,"RIGHT",2,0);
		PetFrameManaBarText:SetPoint("CENTER",PetFrameManaBar,"CENTER",0,-3);
		PetFrameManaBarTextLeft:SetPoint("LEFT",PetFrameManaBar,"LEFT",0,-3);
		PetFrameManaBarTextRight:SetPoint("RIGHT",PetFrameManaBar,"RIGHT",2,-3);
		PetFrameHealthBarText:SetFontObject(SystemFont_Outline_Small);
		PetFrameHealthBarTextLeft:SetFontObject(SystemFont_Outline_Small);
		PetFrameHealthBarTextRight:SetFontObject(SystemFont_Outline_Small);
		PetFrameManaBarText:SetFontObject(SystemFont_Outline_Small);
		PetFrameManaBarTextLeft:SetFontObject(SystemFont_Outline_Small);
		PetFrameManaBarTextRight:SetFontObject(SystemFont_Outline_Small);
	end
end
hooksecurefunc("PlayerFrame_ToPlayerArt", petFrame)

local function petFrameSelector (self, override)
	if ( (not PlayerFrame.animating) or (override) ) then
		if ( UnitIsVisible(self.unit) and PetUsesPetFrame() and not PlayerFrame.vehicleHidesPet ) then
			if ( UnitPowerMax(self.unit) == 0 ) then
				if ( cfg.darkFrames == true ) then
					PetFrameTexture:SetTexture("Interface\\Addons\\whoaThickFrames_Classic\\media\\\dark\\UI-SmallTargetingFrame-NoMana");
				elseif ( cfg.darkFrames == false ) then
					PetFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-SmallTargetingFrame-NoMana");
				end
				PetFrameManaBarText:Hide();
			else
				if ( cfg.darkFrames == true ) then
					PetFrameTexture:SetTexture("Interface\\Addons\\whoaThickFrames_Classic\\media\\\dark\\UI-SmallTargetingFrame");
				elseif ( cfg.darkFrames == false ) then
					PetFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-SmallTargetingFrame");
				end
			end
		end
	end
end
hooksecurefunc("PetFrame_Update", petFrameSelector)

local function petFrameBg()
	local f = CreateFrame("Frame",nil,PetFrame)
	f:SetFrameStrata("BACKGROUND")
	f:SetSize(70,18);
	local t = f:CreateTexture(nil,"BACKGROUND")
	t:SetColorTexture(0, 0, 0, 0.5)
	t:SetAllPoints(f)
	f.texture = t
	f:SetPoint("CENTER",16,-5);
	f:Show()
end
petFrameBg();