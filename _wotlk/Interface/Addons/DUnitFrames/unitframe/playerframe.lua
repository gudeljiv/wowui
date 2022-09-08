-- #PlayerFrame

local DUFFontSize = 12

function DUFGetBorderColor(unit)
	local r = 1
	local g = 1
	local b = 1
	local mode = DUFGetConfig("bordermode")
	local PlayerClass, PlayerClassEng, PlayerClassIndex = UnitClass(unit)
	if mode then
		if mode == "Class+Status" then
			if PlayerClassEng ~= nil and UnitIsPlayer(unit) then
				r, g, b = GetClassColor(PlayerClassEng)
			else
				r, g, b = GameTooltip_UnitColor(unit);
			end
		elseif mode == "Class" then
			if PlayerClassEng ~= nil and UnitIsPlayer(unit) then
				r, g, b = GetClassColor(PlayerClassEng)
			end
		elseif mode == "Status" then
			r, g, b = GameTooltip_UnitColor(unit);
		elseif mode == "Dark" then
			r = 0.1
			g = 0.1
			b = 0.1
		elseif mode == "Black" then
			r = 0
			g = 0
			b = 0
		else
			if MAIGetUIColor then
				r, g, b = MAIGetUIColor()
			else
				r = 1
				g = 1
				b = 1
			end
		end
	end
	return r, g, b
end

function DUFGetBarColor(unit, frame)
	local r = nil
	local g = nil
	local b = nil
	if frame and frame.dr and frame.dg and frame.db then
		r = frame.dr
		g = frame.dg
		b = frame.db
	end
	local mode = DUFGetConfig("barmode")
	local PlayerClass, PlayerClassEng, PlayerClassIndex = UnitClass(unit)
	if mode then
		if mode == "Class+Status" then
			if PlayerClass ~= nil and UnitIsPlayer(unit) then
				r, g, b = GetClassColor(PlayerClassEng)
			else
				r, g, b = GameTooltip_UnitColor(unit);
			end
		elseif mode == "Class" then
			if PlayerClass ~= nil and UnitIsPlayer(unit) then
				r, g, b = GetClassColor(PlayerClassEng)
			end
		elseif mode == "Status" then
			r, g, b = GameTooltip_UnitColor(unit);
		elseif mode == "Dark" then
			r = 0.1
			g = 0.1
			b = 0.1
		elseif mode == "Black" then
			r = 0
			g = 0
			b = 0
		else
			-- Nothing
		end
	end
	if DUFGetConfig("bordermode") == "Default" then
		r = 0
		g = 0.6
		b = 0.1
	end
	return r, g, b
end

local pff = CreateFrame( "FRAME" )
pff:RegisterEvent("UNIT_ENTERING_VEHICLE")
pff:RegisterEvent("UNIT_EXITED_VEHICLE")
pff.currentEvent = "UNIT_EXITED_VEHICLE"
pff:SetScript( "OnEvent", function( event )
	pff.currentEvent = event
	C_Timer.After( 0.3, function()
		if pff.currentEvent == "UNIT_ENTERING_VEHICLE" then
			PlayerFrameHealthBar:SetHeight( 12 )
		else
			PlayerFrameHealthBar:SetHeight( DUFHPHeight() )
		end
	end )
	C_Timer.After( 1, function()
		if pff.currentEvent == "UNIT_ENTERING_VEHICLE" then
			PlayerFrameHealthBar:SetHeight( 12 )
		else
			PlayerFrameHealthBar:SetHeight( DUFHPHeight() )
		end
	end )
	C_Timer.After( 1, function()
		if pff.currentEvent == "UNIT_ENTERING_VEHICLE" then
			PlayerFrameHealthBar:SetHeight( 12 )
		else
			PlayerFrameHealthBar:SetHeight( DUFHPHeight() )
		end
	end )
end )

function DUFUpdatePlayerFrame()
	local texture = "Interface\\Addons\\DUnitFrames\\media\\UI-TargetingFrame"
	PlayerFrameTexture:SetTexture(texture)
	PlayerStatusTexture:SetTexture("Interface\\Addons\\DUnitFrames\\media\\UI-Player-Status")
	
	hooksecurefunc( PlayerFrameHealthBar, "SetHeight", function( self, height )
		if self.dufsetheight then return end
		self.dufsetheight = true

		local inVehicle = false
		if UnitInVehicle or pff.currentEvent == "UNIT_ENTERING_VEHICLE" then
			inVehicle = UnitInVehicle( "PLAYER" )
		end

		if inVehicle then
			PlayerFrameHealthBar:SetHeight( 12 )
			if PlayerFrameTexture.spacer ~= nil then
				PlayerFrameTexture.spacer:Hide()
			end
		else
			PlayerFrameHealthBar:SetHeight( DUFHPHeight() )
			if PlayerFrameTexture.spacer ~= nil then
				PlayerFrameTexture.spacer:Show()
			end
		end

		self.dufsetheight = false
	end )
	PlayerFrameHealthBar:SetHeight( DUFHPHeight() )
	PlayerFrameHealthBar:SetPoint("TOPLEFT", 107, -24)

	if PlayerFrameTexture.spacer == nil then
		PlayerFrameTexture.spacer = PlayerFrameTexture:GetParent():CreateTexture(nil, "ARTWORK")
		PlayerFrameTexture.spacer:SetDrawLayer("ARTWORK", 7)

		hooksecurefunc(PlayerFrameTexture.spacer, "SetVertexColor", function(self, r, g, b, a)
			if self.dufsetvertexcolor then return end
			self.dufsetvertexcolor = true
			self:SetVertexColor(r, g, b, a)
			self.dufsetvertexcolor = false
		end)
		PlayerFrameTexture.spacer:SetVertexColor(1, 1, 1)
	end
	PlayerFrameTexture.spacer:SetTexCoord(0, 1, 1, 0);
	PlayerFrameTexture.spacer:SetSize(128, 16)
	PlayerFrameTexture.spacer:SetPoint("RIGHT", PlayerFrameTexture, "RIGHT", 1, 30 - DUFHPHeight())
	PlayerFrameTexture.spacer:SetTexture(texture .. "_Spacer")

	if DUFHPHeight() >= 32 then
		PlayerFrameTexture.spacer:Hide()
	else
		PlayerFrameTexture.spacer:Show()
	end

	PlayerFrameTexture:SetVertexColor(1, 1, 1)

	PlayerFrameManaBar:SetHeight(38 - DUFHPHeight())
	PlayerFrameManaBar:SetPoint("TOPLEFT", 107, -24 -DUFHPHeight() - 1)

	PlayerFrameManaBarTextLeft:Show()
	PlayerFrameManaBarTextRight:Show()
	PlayerFrameManaBarText:Show()

	PlayerFrameHealthBarTextLeft:SetPoint("LEFT", PlayerFrameHealthBar, "LEFT", 2, 0)
	PlayerFrameHealthBarTextRight:SetPoint("RIGHT", PlayerFrameHealthBar, "RIGHT", 0, 0)
	PlayerFrameHealthBarText:SetPoint("CENTER", PlayerFrameHealthBar, "CENTER", 0, 0)

	PlayerFrameManaBarTextLeft:SetPoint("LEFT", PlayerFrameManaBar, "LEFT", 2, 0)
	PlayerFrameManaBarTextRight:SetPoint("RIGHT", PlayerFrameManaBar, "RIGHT", 0, 0)
	PlayerFrameManaBarText:SetPoint("CENTER", PlayerFrameManaBar, "CENTER", 0, 0)
end

function DUFPlayerFrameSetup()
	hooksecurefunc(PlayerFrameHealthBar, "SetStatusBarTexture", function(self, texture)
		if self.settexture then return end
		self.settexture = true

		if DUFTAB["bartexture"] and DUFTAB["bartexture"] > 0 then
			self:SetStatusBarTexture("Interface\\Addons\\DUnitFrames\\media\\bars\\bar_" .. DUFTAB["bartexture"])
		else
			self:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
		end

		self.settexture = false
	end)
	PlayerFrameHealthBar:SetStatusBarTexture("")

	hooksecurefunc(PlayerFrameManaBar, "SetStatusBarTexture", function(self, texture)
		if self.settexture then return end
		self.settexture = true
		
		if DUFTAB["bartexture"] and DUFTAB["bartexture"] > 0 then
			self:SetStatusBarTexture("Interface\\Addons\\DUnitFrames\\media\\bars\\bar_" .. DUFTAB["bartexture"])
		else
			self:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
		end

		self.settexture = false
	end)
	PlayerFrameManaBar:SetStatusBarTexture("")

	if PlayerFrame.HealthBarTextLeft then
		PlayerFrameHealthBarText = PlayerFrame.HealthBarText
		PlayerFrameHealthBarTextLeft = PlayerFrame.HealthBarTextLeft
		PlayerFrameHealthBarTextRight = PlayerFrame.HealthBarTextRight

		PlayerFrameManaBarText = PlayerFrame.ManaBarText
		PlayerFrameManaBarTextLeft = PlayerFrame.ManaBarTextLeft
		PlayerFrameManaBarTextRight = PlayerFrame.ManaBarTextRight
	end

	hooksecurefunc(PlayerFrameHealthBar, "SetStatusBarColor", function(self, ...)
		if self.dufsetvertexcolor then return end
		self.dufsetvertexcolor = true
		local r, g, b = DUFGetBarColor("PLAYER", self)
		if r and g and b then
			self:SetStatusBarColor(r, g, b)
		end
		self.dufsetvertexcolor = false
	end)
	PlayerFrameHealthBar.dr, PlayerFrameHealthBar.dg, PlayerFrameHealthBar.db = PlayerFrameHealthBar:GetStatusBarColor()
	PlayerFrameHealthBar:SetStatusBarColor(1, 1, 1)

	hooksecurefunc(PlayerFrameHealthBarTextRight, "SetText", function(self, ...)
		if self.dufsettext then return end
		self.dufsettext = true
		local fontFamily, fontSize, fontFlags = self:GetFont()
		if fontSize ~= DUFFontSize then
			self:SetFont(fontFamily, DUFFontSize, fontFlags)
		end
		if DUFGetConfig("numbermode", "X.X Dynamic") ~= "Default" then
			self:SetText(DUFNN(UnitHealth("PLAYER")))
		end
		self.dufsettext = false
	end)
	PlayerFrameHealthBarTextRight:SetText(PlayerFrameHealthBarTextRight:GetText())
	
	hooksecurefunc(PlayerFrameHealthBarTextLeft, "SetText", function(self, ...)
		if self.dufsettext then return end
		self.dufsettext = true
		local fontFamily, fontSize, fontFlags = self:GetFont()
		if fontSize ~= DUFFontSize then
			self:SetFont(fontFamily, DUFFontSize, fontFlags)
		end
		if DUFGetConfig("percentmode", "X.X%") ~= "Default" then
			self:SetText(DUFPN(UnitHealth("PLAYER"), UnitHealthMax("PLAYER")))
		end
		self.dufsettext = false
	end)
	PlayerFrameHealthBarTextLeft:SetText(PlayerFrameHealthBarTextRight:GetText())

	hooksecurefunc(PlayerFrameHealthBarText, "SetText", function(self, ...)
		if self.dufsettext then return end
		self.dufsettext = true
		local fontFamily, fontSize, fontFlags = self:GetFont()
		if fontSize ~= DUFFontSize then
			self:SetFont(fontFamily, DUFFontSize, fontFlags)
		end
		self.dufsettext = false
	end)
	PlayerFrameHealthBarText:SetText(PlayerFrameHealthBarText:GetText())
	
	hooksecurefunc(PlayerFrameManaBarTextLeft, "SetText", function(self, ...)
		if self.dufsettext then return end
		self.dufsettext = true
		local fontFamily, fontSize, fontFlags = self:GetFont()
		if fontSize ~= DUFFontSize then
			self:SetFont(fontFamily, DUFFontSize, fontFlags)
		end
		if DUFGetConfig("percentmode", "X.X%") ~= "Default" then
			self:SetText(DUFPN(UnitPower("PLAYER"), UnitPowerMax("PLAYER")))
		end
		self.dufsettext = false
	end)
	PlayerFrameManaBarTextLeft:SetText(PlayerFrameManaBarTextLeft:GetText())
	
	hooksecurefunc(PlayerFrameManaBarTextRight, "SetText", function(self, ...)
		if self.dufsettext then return end
		self.dufsettext = true
		local fontFamily, fontSize, fontFlags = self:GetFont()
		if fontSize ~= DUFFontSize then
			self:SetFont(fontFamily, DUFFontSize, fontFlags)
		end
		if DUFGetConfig("numbermode", "X.X Dynamic") ~= "Default" then
			self:SetText(DUFNN(UnitPower("PLAYER")))
		end
		self.dufsettext = false
	end)
	PlayerFrameManaBarTextRight:SetText(PlayerFrameManaBarTextRight:GetText())
	
	hooksecurefunc(PlayerFrameManaBarText, "SetText", function(self, ...)
		if self.dufsettext then return end
		self.dufsettext = true
		local fontFamily, fontSize, fontFlags = self:GetFont()
		if fontSize ~= DUFFontSize then
			self:SetFont(fontFamily, DUFFontSize, fontFlags)
		end
		self.dufsettext = false
	end)
	PlayerFrameManaBarText:SetText(PlayerFrameManaBarText:GetText())
	
	PlayerName.Show = PlayerName.Hide
	PlayerName:Hide()
		
	hooksecurefunc(PlayerFrameTexture, "SetVertexColor", function(self, ...)
		if self.dufsetvertexcolor then return end
		self.dufsetvertexcolor = true
		local r, g, b = DUFGetBorderColor("PLAYER")
		self:SetVertexColor(r, g, b, 1)
		if self.spacer then
			self.spacer:SetVertexColor(self:GetVertexColor())
		end
		self.dufsetvertexcolor = false
	end)
	PlayerFrameTexture:SetVertexColor(1, 1, 1)
	
	if not PlayerFrameManaBarTextLeft.hooked then
		PlayerFrameManaBarTextLeft.hooked = true
		hooksecurefunc(PlayerFrameManaBarTextLeft, "Show", function(self, ...)
			if DUFHPHeight() >= 32 then
				self:Hide()
			end
		end)
	end
	if not PlayerFrameManaBarTextRight.hooked then
		PlayerFrameManaBarTextRight.hooked = true
		hooksecurefunc(PlayerFrameManaBarTextRight, "Show", function(self, ...)
			if DUFHPHeight() >= 32 then
				self:Hide()
			end
		end)
	end
	if not PlayerFrameManaBarText.hooked then
		PlayerFrameManaBarText.hooked = true
		hooksecurefunc(PlayerFrameManaBarText, "Show", function(self, ...)
			if DUFHPHeight() >= 32 then
				self:Hide()
			end
		end)
	end

	hooksecurefunc(PlayerFrameManaBar, "SetHeight", function(self)
		if self.dufsetheight then return end
		self.dufsetheight = true

		if 38 - DUFHPHeight() > 1 then
			self:SetHeight(38 - DUFHPHeight())
		else
			self:SetHeight(1)
		end	

		self.dufsetheight = false
	end)
	PlayerFrameManaBar:SetHeight(27)
	hooksecurefunc(PlayerFrameManaBar, "SetSize", function(self)
		if self.dufsetsize then return end
		self.dufsetsize = true

		if 38 - DUFHPHeight() > 1 then
			self:SetHeight(38 - DUFHPHeight())
		else
			self:SetHeight(1)
		end	

		self.dufsetsize = false
	end)

	-- EXTRAS
	ALT_MANA_BAR_PAIR_DISPLAY_INFO = {
		DRUID = {
			[Enum.PowerType.LunarPower] = true,
			[Enum.PowerType.Energy] = true,
			[Enum.PowerType.Rage] = true,
		},
		PRIEST = {
			[Enum.PowerType.Insanity] = true,
		},
		SHAMAN = {
			[Enum.PowerType.Maelstrom] = true,
		},
	};
	
	if PlayerFrameAlternateManaBar == nil then
		local sw = PlayerFrameManaBar:GetWidth() + 4
		local sh = 16
		PlayerFrameAlternateManaBar = CreateFrame("Frame", "PlayerFrameAlternateManaBar")
		PlayerFrameAlternateManaBar:SetParent(PlayerFrame)
		PlayerFrameAlternateManaBar:SetSize(sw, sh)
		PlayerFrameAlternateManaBar:SetPoint("TOP", PlayerFrameManaBar, "BOTTOM")

		PlayerFrameAlternateManaBar.texture = PlayerFrameAlternateManaBar:CreateTexture(nil, "BACKGROUND")
		PlayerFrameAlternateManaBar.texture:SetTexture("Interface\\TargetingFrame\\UI-StatusBar")
		PlayerFrameAlternateManaBar.texture:SetSize(10, sh - 4)
		PlayerFrameAlternateManaBar.texture:SetPoint("LEFT", PlayerFrameAlternateManaBar, "LEFT", 2, 0)
		PlayerFrameAlternateManaBar.texture:SetColorTexture(0, 0, 1, 1)

		PlayerFrameAlternateManaBar.texture2 = PlayerFrameAlternateManaBar:CreateTexture(nil, "BORDER")
		PlayerFrameAlternateManaBar.texture2:SetTexture("Interface\\Tooltips\\UI-StatusBar-Border")
		PlayerFrameAlternateManaBar.texture2:SetTexCoord(0, 1, 1, 0)
		PlayerFrameAlternateManaBar.texture2:SetSize(sw + 3, sh + 4)
		PlayerFrameAlternateManaBar.texture2:SetPoint("BOTTOM", PlayerFrameAlternateManaBar, "BOTTOM", 0, -2)

		PlayerFrameAlternateManaBar.textl = PlayerFrameAlternateManaBar:CreateFontString(nil, "ARTWORK", "TextStatusBarText") 
		PlayerFrameAlternateManaBar.textl:SetFont(STANDARD_TEXT_FONT, 9, "")
		PlayerFrameAlternateManaBar.textl:SetShadowOffset(1, -1)
		PlayerFrameAlternateManaBar.textl:SetPoint("LEFT", PlayerFrameAlternateManaBar, "LEFT", 5, 0)

		PlayerFrameAlternateManaBar.textr = PlayerFrameAlternateManaBar:CreateFontString(nil, "ARTWORK", "TextStatusBarText") 
		PlayerFrameAlternateManaBar.textr:SetFont(STANDARD_TEXT_FONT, 9, "")
		PlayerFrameAlternateManaBar.textr:SetShadowOffset(1, -1)
		PlayerFrameAlternateManaBar.textr:SetPoint("RIGHT", PlayerFrameAlternateManaBar, "RIGHT", -5, 0)

		function PlayerFrameAlternateManaBar.think()
			if UnitPowerType("PLAYER") == Enum.PowerType.Mana or UnitPowerMax("PLAYER", Enum.PowerType.Mana) <= 0 then -- when current power is mana or the maxmana is <= 0
				PlayerFrameAlternateManaBar:Hide() -- hide when warrior, rogue, ... or when current power is mana
			else
				PlayerFrameAlternateManaBar:Show()
				local per = UnitPower("PLAYER", Enum.PowerType.Mana) / UnitPowerMax("PLAYER", Enum.PowerType.Mana)
				PlayerFrameAlternateManaBar.texture:SetWidth(per * PlayerFrameAlternateManaBar:GetWidth() - 4)

				PlayerFrameAlternateManaBar.textl:SetText(DUFPN(UnitPower("PLAYER", Enum.PowerType.Mana), UnitPowerMax("PLAYER", Enum.PowerType.Mana)))
				PlayerFrameAlternateManaBar.textr:SetText(DUFNN(UnitPower("PLAYER", Enum.PowerType.Mana)))
			end
			C_Timer.After(0.1, PlayerFrameAlternateManaBar.think)
		end
		PlayerFrameAlternateManaBar.think()
	end

	if ComboPointPlayerFrame ~= nil then
		hooksecurefunc(ComboPointPlayerFrame, "SetPoint", function(self, ...)
			local _, class = UnitClass("PLAYER");
			if class == "DRUID" then
				if self.dufsetpoint then return end
				self.dufsetpoint = true
				self:SetScale(0.82)
				self:SetPoint("TOP", PlayerFrameAlternateManaBar, "BOTTOM", 0, 0)
				self.dufsetpoint = false
			end
		end)
	end

	DUFUpdatePlayerFrame()
end
