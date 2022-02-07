cfg = {}

--	Target frame
function whoaTargetFrames (self, forceNormalTexture)
	local path = cfg.frameMode;
	local classification = UnitClassification(self.unit);
	self.highLevelTexture:SetPoint("CENTER", self.levelText, "CENTER", 0,0);
	self.deadText:SetPoint("CENTER", self.healthbar, "CENTER",0,0);
	self.unconsciousText:SetPoint("CENTER", self.healthbar, "CENTER",0,0);
	self.nameBackground:Hide();
	
	self.name:SetPoint("LEFT", self, 15, 36);
	self.healthbar:SetSize(119, 28);
	self.healthbar:SetPoint("TOPLEFT", 5, -24);
	self.healthbar.LeftText:SetPoint("LEFT", self.healthbar, "LEFT", 5, 0);
	self.healthbar.RightText:SetPoint("RIGHT", self.healthbar, "RIGHT", -3, 0);
	self.healthbar.TextString:SetPoint("CENTER", self.healthbar, "CENTER", 0, 0);
	self.manabar.LeftText:SetPoint("LEFT", self.manabar, "LEFT", 3, 0);
	self.manabar.RightText:SetPoint("RIGHT", self.manabar, "RIGHT", -3, 0);
	self.manabar.TextString:SetPoint("CENTER", self.manabar, "CENTER", 0, 0);
	-- if ( self.threatIndicator ) then
		-- self.threatIndicator:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Flash");
	-- elseif ( TargetFrame.threatNumericIndicator ) then
		-- TargetFrame.threatNumericIndicator:SetPoint("BOTTOM", PlayerFrame, "TOP", 72, -21);
	-- elseif ( FocusFrame.threatNumericIndicator ) then
		-- FocusFrame.threatNumericIndicator:SetAlpha(0);
	-- end

	if ( forceNormalTexture ) then
		self.borderTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame");
	elseif ( classification == "minus" ) then
		self.borderTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Minus");
		forceNormalTexture = true;
	elseif ( classification == "worldboss" or classification == "elite" ) then
		self.borderTexture:SetTexture("Interface\\Addons\\"..whoaAddon.."\\media\\"..path.."\\UI-TargetingFrame-Elite");
	elseif ( classification == "rareelite" ) then
		self.borderTexture:SetTexture("Interface\\Addons\\"..whoaAddon.."\\media\\"..path.."\\UI-TargetingFrame-Rare-Elite");
	elseif ( classification == "rare" ) then
		self.borderTexture:SetTexture("Interface\\Addons\\"..whoaAddon.."\\media\\"..path.."\\UI-TargetingFrame-Rare");
	else
		self.borderTexture:SetTexture("Interface\\Addons\\"..whoaAddon.."\\media\\"..path.."\\UI-TargetingFrame");
		forceNormalTexture = true;
	end
	if ( forceNormalTexture ) then
		self.haveElite = nil;
		if ( classification == "minus" ) then
			self.Background:SetSize(119,12);
			self.Background:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 7, 47);
			self.name:SetPoint("LEFT", self, 16, 19);
			self.healthbar:ClearAllPoints();
			self.healthbar:SetPoint("LEFT", 5, 3);
			self.healthbar:SetHeight(12);
			self.healthbar.LeftText:SetPoint("LEFT", self.healthbar, "LEFT", 3, 0);
			self.healthbar.RightText:SetPoint("RIGHT", self.healthbar, "RIGHT", -2, 0);
		else
			self.Background:SetSize(119,42);
			self.Background:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 7, 35);
		end
		if ( self.threatIndicator ) then
			if ( classification == "minus" ) then
				self.threatIndicator:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Minus-Flash");
				self.threatIndicator:SetTexCoord(0, 1, 0, 1);
				self.threatIndicator:SetWidth(256);
				self.threatIndicator:SetHeight(128);
				self.threatIndicator:SetPoint("TOPLEFT", self, "TOPLEFT", -24, 0);
			else
				self.threatIndicator:SetTexCoord(0, 0.9453125, 0, 0.181640625);
				self.threatIndicator:SetWidth(242);
				self.threatIndicator:SetHeight(93);
				self.threatIndicator:SetPoint("TOPLEFT", self, "TOPLEFT", -24, 0);
			end
		end
	else
		self.haveElite = true;
		self.Background:SetSize(119,42);
		if ( self.threatIndicator ) then
			self.threatIndicator:SetTexCoord(0, 0.9453125, 0.181640625, 0.400390625);
			self.threatIndicator:SetWidth(242);
			self.threatIndicator:SetHeight(112);
		end
	end
	-- if (self.questIcon) then
		-- if (UnitIsQuestBoss(self.unit)) then
			-- self.healthbar.RightText:SetPoint("RIGHT", self.healthbar, "RIGHT", -9, 0);
		-- else
			-- self.healthbar.RightText:SetPoint("RIGHT", self.healthbar, "RIGHT", -3, 0);
		-- end
	-- end
	if ( cfg.whoaTexture == true) then
		self.healthbar:SetStatusBarTexture("Interface\\Addons\\whoaThickFrames_BCC\\media\\statusbar\\"..cfg.SBTextureName);
	end
end
hooksecurefunc("TargetFrame_CheckClassification", whoaTargetFrames)

function whoaCheckFaction (self)
	local path = cfg.frameMode;

	if ( self.showPVP ) then
		local factionGroup = UnitFactionGroup(self.unit);
		if ( UnitIsPVPFreeForAll(self.unit) ) then
				self.pvpIcon:SetTexture("Interface\\Addons\\"..whoaAddon.."\\media\\"..path.."\\UI-PVP-FFA");
		elseif ( factionGroup and factionGroup ~= "Neutral" and UnitIsPVP(self.unit) ) then
				self.pvpIcon:SetTexture("Interface\\Addons\\"..whoaAddon.."\\media\\"..path.."\\UI-PVP-"..factionGroup);
		end
		if (UnitIsCivilian(self.unit)) then
			self.questIcon:SetTexture("Interface\\Addons\\"..whoaAddon.."\\media\\"..path.."\\PortraitWarningBadge");
			self.questIcon:Show();
		else
			self.questIcon:Hide();
		end
	end
end
hooksecurefunc("TargetFrame_CheckFaction", whoaCheckFaction)

-- Mana texture
function whoaManaBar (manaBar)
	local powerType, powerToken, altR, altG, altB = UnitPowerType(manaBar.unit);
	local info = PowerBarColor[powerToken];
	if ( info ) then
		if ( not manaBar.lockColor ) then
			if not ( info.atlas ) and ( cfg.whoaTexture == true) then
				manaBar:SetStatusBarTexture("Interface\\Addons\\"..whoaAddon.."\\media\\statusbar\\"..cfg.SBTextureName);
			end
		end
	end
end
hooksecurefunc("UnitFrameManaBar_UpdateType", whoaManaBar)

--	ToT & ToF
function whoaUnitTarget()
	local path = cfg.frameMode;
	TargetFrameToTTextureFrameTexture:SetTexture("Interface\\Addons\\"..whoaAddon.."\\media\\"..path.."\\UI-TargetofTargetFrame");
	TargetFrameToTTextureFrameDeadText:ClearAllPoints();
	TargetFrameToTTextureFrameDeadText:SetPoint("CENTER", "TargetFrameToTHealthBar","CENTER",1, 0);
	TargetFrameToTTextureFrameUnconsciousText:ClearAllPoints();
	TargetFrameToTTextureFrameUnconsciousText:SetPoint("CENTER", "TargetFrameToTHealthBar","CENTER",1, 0);
	TargetFrameToTTextureFrameName:SetSize(65,10);
	TargetFrameToTHealthBar:ClearAllPoints();
	TargetFrameToTHealthBar:SetPoint("TOPLEFT", 45, -15);
	TargetFrameToTHealthBar:SetHeight(10);
	TargetFrameToTManaBar:ClearAllPoints();
	TargetFrameToTManaBar:SetPoint("TOPLEFT", 45, -25);
	TargetFrameToTManaBar:SetHeight(5);
	TargetFrameToTBackground:SetSize(50,14);
	TargetFrameToTBackground:ClearAllPoints();
	TargetFrameToTBackground:SetPoint("CENTER", "TargetFrameToT","CENTER",20, 0);
	FocusFrameToTTextureFrameTexture:SetTexture("Interface\\Addons\\"..whoaAddon.."\\media\\"..path.."\\UI-TargetofTargetFrame");
	FocusFrameToTTextureFrameDeadText:ClearAllPoints();
	FocusFrameToTTextureFrameDeadText:SetPoint("CENTER", "FocusFrameToTHealthBar","CENTER",1, 0);
	FocusFrameToTTextureFrameUnconsciousText:ClearAllPoints();
	FocusFrameToTTextureFrameUnconsciousText:SetPoint("CENTER", "FocusFrameToTHealthBar","CENTER",1, 0);
	FocusFrameToTTextureFrameName:SetSize(65,10);
	FocusFrameToTHealthBar:ClearAllPoints();
	FocusFrameToTHealthBar:SetPoint("TOPLEFT", 45, -15);
	FocusFrameToTHealthBar:SetHeight(10);
	FocusFrameToTManaBar:ClearAllPoints();
	FocusFrameToTManaBar:SetPoint("TOPLEFT", 45, -25);
	FocusFrameToTManaBar:SetHeight(5);
	FocusFrameToTBackground:SetSize(50,14);
	FocusFrameToTBackground:ClearAllPoints();
	FocusFrameToTBackground:SetPoint("CENTER", "FocusFrameToT","CENTER",20, 0);
end

--	Party Frames.
function whoaPartyFrames()
	local path = cfg.frameMode;
	local useCompact = GetCVarBool("useCompactPartyFrames");
	if (cfg.usePartyFrames) and IsInGroup(player) and (not IsInRaid(player)) and (not useCompact) then
		for i = 1, 4 do
			if ( cfg.whoaTexture == true) then
				_G["PartyMemberFrame"..i.."HealthBar"]:SetStatusBarTexture("Interface\\Addons\\"..whoaAddon.."\\media\\statusbar\\"..cfg.SBTextureName);
				_G["PartyMemberFrame"..i.."HealthBar"]:SetStatusBarTexture("Interface\\Addons\\"..whoaAddon.."\\media\\statusbar\\"..cfg.SBTextureName);
			end
			_G["PartyMemberFrame"..i.."Name"]:SetSize(75,10);
			_G["PartyMemberFrame"..i.."Texture"]:SetTexture("Interface\\Addons\\"..whoaAddon.."\\media\\"..path.."\\UI-PartyFrame");
			_G["PartyMemberFrame"..i.."Flash"]:SetTexture("Interface\\Addons\\"..whoaAddon.."\\media\\UI-PARTYFRAME-FLASH");
			_G["PartyMemberFrame"..i.."HealthBar"]:ClearAllPoints();
			_G["PartyMemberFrame"..i.."HealthBar"]:SetPoint("TOPLEFT", 45, -13);
			_G["PartyMemberFrame"..i.."HealthBar"]:SetHeight(12);
			_G["PartyMemberFrame"..i.."ManaBar"]:ClearAllPoints();
			_G["PartyMemberFrame"..i.."ManaBar"]:SetPoint("TOPLEFT", 45, -26);
			_G["PartyMemberFrame"..i.."ManaBar"]:SetHeight(5);
			-- _G["PartyMemberFrame"..i.."HealthBarTextLeft"]:ClearAllPoints();
			-- _G["PartyMemberFrame"..i.."HealthBarTextLeft"]:SetPoint("LEFT", _G["PartyMemberFrame"..i.."HealthBar"], "LEFT", 0, 0);
			-- _G["PartyMemberFrame"..i.."HealthBarTextRight"]:ClearAllPoints();
			-- _G["PartyMemberFrame"..i.."HealthBarTextRight"]:SetPoint("RIGHT", _G["PartyMemberFrame"..i.."HealthBar"], "RIGHT", 0, 0);
			-- _G["PartyMemberFrame"..i.."ManaBarTextLeft"]:ClearAllPoints();
			-- _G["PartyMemberFrame"..i.."ManaBarTextLeft"]:SetPoint("LEFT", _G["PartyMemberFrame"..i.."ManaBar"], "LEFT", 0, 0);
			-- _G["PartyMemberFrame"..i.."ManaBarTextRight"]:ClearAllPoints();
			-- _G["PartyMemberFrame"..i.."ManaBarTextRight"]:SetPoint("RIGHT", _G["PartyMemberFrame"..i.."ManaBar"], "RIGHT", 0, 0);
			-- _G["PartyMemberFrame"..i.."HealthBarText"]:ClearAllPoints();
			-- _G["PartyMemberFrame"..i.."HealthBarText"]:SetPoint("CENTER", _G["PartyMemberFrame"..i.."HealthBar"], "CENTER", 0, 0);
			-- _G["PartyMemberFrame"..i.."ManaBarText"]:ClearAllPoints();
			-- _G["PartyMemberFrame"..i.."ManaBarText"]:SetPoint("CENTER", _G["PartyMemberFrame"..i.."ManaBar"], "CENTER", 0, 0);
		end
	end
end
hooksecurefunc("UnitFrame_Update", whoaPartyFrames)
hooksecurefunc("PartyMemberFrame_ToPlayerArt", whoaPartyFrames)

-- function whoaPartyText()
	-- if (cfg.usePartyFrames) then
		-- for i = 1, 4 do
			-- if i then
				-- _G["PartyMemberFrame"..i.."ManaBarText"]:SetText(" ");
				-- _G["PartyMemberFrame"..i.."ManaBarTextLeft"]:SetText(" ");
				-- _G["PartyMemberFrame"..i.."ManaBarTextRight"]:SetText(" ");
			-- end
		-- end
	-- end
-- end
-- hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", whoaPartyText)

	--	Boss target frames taints
-- local whoaBossFrame = CreateFrame("Frame", "whoaBossFrame")
-- whoaBossFrame:RegisterEvent("PLAYER_LOGIN")
-- whoaBossFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
-- whoaBossFrame:SetScript('OnUpdate', function(self)
	-- local path = cfg.frameMode;
	-- for i = 1, MAX_BOSS_FRAMES do
		-- if i then
			-- _G["Boss"..i.."TargetFrameTextureFrameDeadText"]:ClearAllPoints();
			-- _G["Boss"..i.."TargetFrameTextureFrameDeadText"]:SetPoint("CENTER",_G["Boss"..i.."TargetFrameHealthBar"],"CENTER",0,0);
			-- _G["Boss"..i.."TargetFrameTextureFrameUnconsciousText"]:ClearAllPoints();
			-- _G["Boss"..i.."TargetFrameTextureFrameUnconsciousText"]:SetPoint("CENTER", _G["Boss"..i.."TargetFrameHealthBar"], "CENTER",0,0);
			-- _G["Boss"..i.."TargetFrameTextureFrameName"]:ClearAllPoints();
			-- _G["Boss"..i.."TargetFrameTextureFrameName"]:SetPoint("CENTER",_G["Boss"..i.."TargetFrame"],"CENTER",-57,-23);
			-- _G["Boss"..i.."TargetFrameTextureFrameTexture"]:SetTexture("Interface\\Addons\\"..whoaAddon.."\\media\\"..path.."\\UI-UNITFRAME-BOSS");
			-- _G["Boss"..i.."TargetFrameNameBackground"]:SetAlpha(0);
			-- _G["Boss"..i.."TargetFrameHealthBar"]:SetSize(116,20);
			-- _G["Boss"..i.."TargetFrameHealthBar"]:ClearAllPoints();
			-- _G["Boss"..i.."TargetFrameHealthBar"]:SetPoint("CENTER",_G["Boss"..i.."TargetFrame"],"CENTER",-51,18);
			-- _G["Boss"..i.."TargetFrameManaBar"]:SetSize(116,18);
			-- _G["Boss"..i.."TargetFrameManaBar"]:ClearAllPoints();
			-- _G["Boss"..i.."TargetFrameManaBar"]:SetPoint("CENTER",_G["Boss"..i.."TargetFrame"],"CENTER",-51,-3);
			-- _G["Boss"..i.."TargetFrameTextureFrame.HealthBarTextLeft"]:ClearAllPoints();
			-- _G["Boss"..i.."TargetFrameTextureFrameHealthBarTextLeft"]:SetPoint("LEFT",_G["Boss"..i.."TargetFrameHealthBar"],"LEFT",0,0);
			-- _G["Boss"..i.."TargetFrameTextureFrameHealthBarTextRight"]:ClearAllPoints();
			-- _G["Boss"..i.."TargetFrameTextureFrameHealthBarTextRight"]:SetPoint("RIGHT",_G["Boss"..i.."TargetFrameHealthBar"],"RIGHT",0,0);
			-- _G["Boss"..i.."TargetFrameTextureFrameHealthBarText"]:ClearAllPoints();
			-- _G["Boss"..i.."TargetFrameTextureFrameHealthBarText"]:SetPoint("CENTER",_G["Boss"..i.."TargetFrameHealthBar"],"CENTER",0,0);
			-- _G["Boss"..i.."TargetFrameTextureFrameManaBarTextLeft"]:Hide();
			-- _G["Boss"..i.."TargetFrameTextureFrameManaBarTextLeft"]:SetPoint("LEFT",_G["Boss"..i.."TargetFrameManaBar"],"LEFT",0,0);
			-- _G["Boss"..i.."TargetFrameTextureFrameManaBarTextRight"]:Hide();
			-- _G["Boss"..i.."TargetFrameTextureFrameManaBarTextRight"]:SetPoint("RIGHT",_G["Boss"..i.."TargetFrameManaBar"],"RIGHT",0,0);
			-- _G["Boss"..i.."TargetFrameTextureFrameManaBarText"]:Hide();
			-- _G["Boss"..i.."TargetFrameTextureFrameManaBarText"]:SetPoint("CENTER",_G["Boss"..i.."TargetFrameManaBar"],"CENTER",0,0);
			-- _G["Boss"..i.."TargetFrameTextureFrameTexture"]:SetTexture("Interface\\Addons\\"..whoaAddon.."\\media\\UI-UNITFRAME-BOSS");
		-- end
	-- end
-- end)

-- function whoaBossFramesText()
		-- for i = 1, MAX_BOSS_FRAMES do
			-- _G["Boss"..i.."TargetFrameTextureFrameManaBarTextLeft"]:SetText(" ");
			-- _G["Boss"..i.."TargetFrameTextureFrameManaBarTextRight"]:SetText(" ");
			-- _G["Boss"..i.."TargetFrameTextureFrameManaBarText"]:SetText(" ");
		-- end
-- end
-- hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", whoaBossFramesText)

-- local whoaBossFrame = CreateFrame("Frame")
-- whoaBossFrame:SetScript('OnUpdate', function(self)
	-- for i = 1, MAX_BOSS_FRAMES do
		-- if UnitExists("boss"..i) then
			-- _G["Boss"..i.."TargetFrameTextureFrameManaBarTextLeft"]:SetText(" ");
			-- _G["Boss"..i.."TargetFrameTextureFrameManaBarTextRight"]:SetText(" ");
			-- _G["Boss"..i.."TargetFrameTextureFrameManaBarText"]:SetText(" ");
		-- end
	-- end
-- end)