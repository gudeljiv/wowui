
local DUFFontSize = 12

function DUFPartyMemberFramesSetup()
	for id = 1, 4 do
		local PartyMemberFrame = _G["PartyMemberFrame" .. id]

		if PartyMemberFrame then
			local func = _G["DUFUpdateParty" .. id .. "Texture"]
			func = function()
				local texture = "Interface\\Addons\\DUnitFrames\\media\\UI-PartyFrame"
				local PartyMemberTexture = _G["PartyMemberFrame" .. id .. "Texture"]
				PartyMemberTexture:SetTexture(texture);
				PartyMemberTexture:SetVertexColor(0, 0, 0)
			end
			func()

			hooksecurefunc(_G["PartyMemberFrame" .. id .. "HealthBar"], "SetStatusBarTexture", function(self, texture)
				if self.settexture then return end
				self.settexture = true
		
				if DUFTAB["bartexture"] and DUFTAB["bartexture"] > 0 then
					self:SetStatusBarTexture("Interface\\Addons\\DUnitFrames\\media\\bars\\bar_" .. DUFTAB["bartexture"])
				else
					self:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
				end
		
				self.settexture = false
			end)
			_G["PartyMemberFrame" .. id .. "HealthBar"]:SetStatusBarTexture("")
		
			hooksecurefunc(_G["PartyMemberFrame" .. id .. "ManaBar"], "SetStatusBarTexture", function(self, texture)
				if self.settexture then return end
				self.settexture = true
				
				if DUFTAB["bartexture"] and DUFTAB["bartexture"] > 0 then
					self:SetStatusBarTexture("Interface\\Addons\\DUnitFrames\\media\\bars\\bar_" .. DUFTAB["bartexture"])
				else
					self:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
				end
		
				self.settexture = false
			end)
			_G["PartyMemberFrame" .. id .. "ManaBar"]:SetStatusBarTexture("")
		
			hooksecurefunc(_G["PartyMemberFrame" .. id .. "HealthBar"], "SetStatusBarColor", function(self, ...)
				if self.dufsetvertexcolor then return end
				self.dufsetvertexcolor = true
				local r, g, b = DUFGetBarColor("PARTY" .. id)
				if r and g and b then
					self:SetStatusBarColor(r, g, b)
				end
				self.dufsetvertexcolor = false
			end)
			_G["PartyMemberFrame" .. id .. "HealthBar"].dr, _G["PartyMemberFrame" .. id .. "HealthBar"].dg, _G["PartyMemberFrame" .. id .. "HealthBar"].db = _G["PartyMemberFrame" .. id .. "HealthBar"]:GetStatusBarColor()
			_G["PartyMemberFrame" .. id .. "HealthBar"]:SetStatusBarColor(1, 1, 1)

			hooksecurefunc(_G["PartyMemberFrame" .. id .. "HealthBar"], "SetHeight", function(self)
				if self.dufsetheight then return end
				self.dufsetheight = true

				self:SetHeight(13)

				self.dufsetheight = false
			end)
			_G["PartyMemberFrame" .. id .. "HealthBar"]:SetHeight(13)

			hooksecurefunc(_G["PartyMemberFrame" .. id .. "HealthBar"], "SetPoint", function(self)
				if self.dufsetpoint then return end
				self.dufsetpoint = true

				self:SetPoint("TOPLEFT", 45, -16)

				self.dufsetpoint = false
			end)
			_G["PartyMemberFrame" .. id .. "HealthBar"]:SetPoint("TOPLEFT", 6, -24)

			hooksecurefunc(_G["PartyMemberFrame" .. id .. "ManaBar"], "SetPoint", function(self)
				if self.dufsetpoint then return end
				self.dufsetpoint = true

				self:ClearAllPoints()
				self:SetPoint("TOP", _G["PartyMemberFrame" .. id .. "HealthBar"], "BOTTOM", 0, -1)

				self.dufsetpoint = false
			end)
			_G["PartyMemberFrame" .. id .. "ManaBar"]:SetPoint("TOPLEFT", 6, -24)

			_G["PartyMemberFrame" .. id .. "Background"].Show = _G["PartyMemberFrame" .. id .. "Background"].Hide
			_G["PartyMemberFrame" .. id .. "Background"]:Hide()

			function PartyMemberFrame.Think()
				if UnitExists( "PARTY" .. id ) then
					_G["PartyMemberFrame" .. id .. "Name"]:ClearAllPoints()
					local y = 3
					if DUFGetConfig("namemode", "Over Portrait") == "Over Health" then
						_G["PartyMemberFrame" .. id .. "Name"]:SetPoint("BOTTOM", _G["PartyMemberFrame" .. id .. "HealthBar"], "TOP", 0, y)
					end
					if DUFGetConfig("namemode", "Over Portrait") == "Over Portrait" then
						_G["PartyMemberFrame" .. id .. "Name"]:SetPoint("BOTTOM", _G["PartyMemberFrame" .. id .. "Portrait"], "TOP", 0, 3)
					end

					if PartyMemberFrame.hptc == nil then
						PartyMemberFrame.hptc = _G["PartyMemberFrame" .. id .. "HealthBar"]:CreateFontString(nil, "OVERLAY") 
						PartyMemberFrame.hptc:SetFont(STANDARD_TEXT_FONT, 10, "THINOUTLINE")
						PartyMemberFrame.hptc:SetPoint("CENTER", _G["PartyMemberFrame" .. id .. "HealthBar"], "CENTER", 0, 0)

						PartyMemberFrame.hptl = _G["PartyMemberFrame" .. id .. "HealthBar"]:CreateFontString(nil, "OVERLAY") 
						PartyMemberFrame.hptl:SetFont(STANDARD_TEXT_FONT, 10, "THINOUTLINE")
						PartyMemberFrame.hptl:SetPoint("LEFT", _G["PartyMemberFrame" .. id .. "HealthBar"], "LEFT", 0, 0)

						PartyMemberFrame.hptr = _G["PartyMemberFrame" .. id .. "HealthBar"]:CreateFontString(nil, "OVERLAY") 
						PartyMemberFrame.hptr:SetFont(STANDARD_TEXT_FONT, 10, "THINOUTLINE")
						PartyMemberFrame.hptr:SetPoint("RIGHT", _G["PartyMemberFrame" .. id .. "HealthBar"], "RIGHT", 0, 0)
					end
					if GetCVar( "statusTextDisplay" ) == "PERCENT" then
						PartyMemberFrame.hptc:SetText( string.format("%.0f", UnitHealth( "PARTY" .. id ) / UnitHealthMax( "PARTY" .. id ) * 100 ) .. "%" )
						PartyMemberFrame.hptl:SetText( "" )
						PartyMemberFrame.hptr:SetText( "" )
					elseif GetCVar( "statusTextDisplay" ) == "NUMERIC" then
						PartyMemberFrame.hptc:SetText( string.format("%s/%s", DUFNN( UnitHealth( "PARTY" .. id ) ), DUFNN( UnitHealthMax( "PARTY" .. id ) ) ) )
						PartyMemberFrame.hptl:SetText( "" )
						PartyMemberFrame.hptr:SetText( "" )
					elseif GetCVar( "statusTextDisplay" ) == "BOTH" then
						PartyMemberFrame.hptc:SetText( "" )
						PartyMemberFrame.hptl:SetText( string.format("%.0f", UnitHealth( "PARTY" .. id ) / UnitHealthMax( "PARTY" .. id ) * 100 ) .. "%" )
						PartyMemberFrame.hptr:SetText( string.format("%s", DUFNN( UnitHealth( "PARTY" .. id ) ) ) )
					else
						PartyMemberFrame.hptc:SetText( "" )
						PartyMemberFrame.hptl:SetText( "" )
						PartyMemberFrame.hptr:SetText( "" )
					end

					if PartyMemberFrame.potc == nil then
						PartyMemberFrame.potc = _G["PartyMemberFrame" .. id .. "ManaBar"]:CreateFontString(nil, "OVERLAY") 
						PartyMemberFrame.potc:SetFont(STANDARD_TEXT_FONT, 9, "THINOUTLINE")
						PartyMemberFrame.potc:SetPoint("CENTER", _G["PartyMemberFrame" .. id .. "ManaBar"], "CENTER", 0, 0)

						PartyMemberFrame.potl = _G["PartyMemberFrame" .. id .. "ManaBar"]:CreateFontString(nil, "OVERLAY") 
						PartyMemberFrame.potl:SetFont(STANDARD_TEXT_FONT, 9, "THINOUTLINE")
						PartyMemberFrame.potl:SetPoint("LEFT", _G["PartyMemberFrame" .. id .. "ManaBar"], "LEFT", 0, 0)

						PartyMemberFrame.potr = _G["PartyMemberFrame" .. id .. "ManaBar"]:CreateFontString(nil, "OVERLAY") 
						PartyMemberFrame.potr:SetFont(STANDARD_TEXT_FONT, 9, "THINOUTLINE")
						PartyMemberFrame.potr:SetPoint("RIGHT", _G["PartyMemberFrame" .. id .. "ManaBar"], "RIGHT", 0, 0)
					end
					if GetCVar( "statusTextDisplay" ) == "PERCENT" then
						PartyMemberFrame.potc:SetText( string.format("%.0f", UnitPower( "PARTY" .. id ) / UnitPowerMax( "PARTY" .. id ) * 100 ) .. "%" )
						PartyMemberFrame.potl:SetText( "" )
						PartyMemberFrame.potr:SetText( "" )
					elseif GetCVar( "statusTextDisplay" ) == "NUMERIC" then
						PartyMemberFrame.potc:SetText( string.format("%s/%s", DUFNN( UnitPower( "PARTY" .. id ) ), DUFNN( UnitPowerMax( "PARTY" .. id ) ) ) )
						PartyMemberFrame.potl:SetText( "" )
						PartyMemberFrame.potr:SetText( "" )
					elseif GetCVar( "statusTextDisplay" ) == "BOTH" then
						PartyMemberFrame.potc:SetText( "" )
						PartyMemberFrame.potl:SetText( string.format("%.0f", UnitPower( "PARTY" .. id ) / UnitPowerMax( "PARTY" .. id ) * 100 ) .. "%" )
						PartyMemberFrame.potr:SetText( string.format("%s", DUFNN( UnitPower( "PARTY" .. id ) ) ) )
					else
						PartyMemberFrame.potc:SetText( "" )
						PartyMemberFrame.potl:SetText( "" )
						PartyMemberFrame.potr:SetText( "" )
					end
				end

				C_Timer.After(0.05, PartyMemberFrame.Think)
			end
			PartyMemberFrame.Think()

			hooksecurefunc(_G["PartyMemberFrame" .. id .. "Name"], "SetText", function(self, text, ...)
				if self.dufsettext then return end
				self.dufsettext = true
				local fontFamily, fontSize, fontFlags = self:GetFont()
				if fontSize ~= DUFGetConfig("namesize", 10) then
					self:SetFont(fontFamily, DUFGetConfig("namesize", 10), fontFlags)--, "OUTLINE")
					self:SetShadowOffset(1, -1)
				end
				if DUFGetConfig("namemode", "Over Portrait") == "Hide" then
					self:Hide()
				else
					self:Show()
				end
				self.dufsettext = false
			end)
			_G["PartyMemberFrame" .. id .. "Name"]:SetText(_G["PartyMemberFrame" .. id .. "Name"]:GetText())

			hooksecurefunc(_G["PartyMemberFrame" .. id .. "Texture"], "SetVertexColor", function(self, ...)
				if self.dufsetvertexcolor then return end
				self.dufsetvertexcolor = true
				local r, g, b = DUFGetBorderColor("PARTY" .. id)
				self:SetVertexColor(r, g, b, 1)
				self.dufsetvertexcolor = false
			end)
			_G["PartyMemberFrame" .. id .. "Texture"]:SetVertexColor(1, 1, 1)

			C_Timer.After( 2, function()
				if _G["PartyFrameXPBar" .. id] then
					hooksecurefunc(_G["PartyFrameXPBar" .. id].textureLvlBg, "SetVertexColor", function(self, ...)
						if self.dufsetvertexcolor then return end
						self.dufsetvertexcolor = true
						local r, g, b = DUFGetBorderColor("PARTY" .. id)
						self:SetVertexColor(r, g, b, 1)
						self.dufsetvertexcolor = false
					end)
					_G["PartyFrameXPBar" .. id].textureLvlBg:SetVertexColor(1, 1, 1)
				end
			end )
		end
	end
end

function DUFUpdatePartyMemberFrames()
	for id = 1, 4 do
		local PartyMemberFrame = _G["PartyMemberFrame" .. id]
		if PartyMemberFrame then
			_G["PartyMemberFrame" .. id .. "HealthBar"]:SetHeight(1)
			_G["PartyMemberFrame" .. id .. "ManaBar"]:SetHeight(1)
			_G["PartyMemberFrame" .. id .. "ManaBar"]:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
		end
	end
end