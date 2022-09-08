
local DUFFontSize = 12

function DUFTargetFrameSetup()
	hooksecurefunc(TargetFrameHealthBar, "SetStatusBarTexture", function(self, texture)
		if self.settexture then return end
		self.settexture = true

		if DUFTAB["bartexture"] and DUFTAB["bartexture"] > 0 then
			self:SetStatusBarTexture("Interface\\Addons\\DUnitFrames\\media\\bars\\bar_" .. DUFTAB["bartexture"])
		else
			self:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
		end

		self.settexture = false
	end)
	TargetFrameHealthBar:SetStatusBarTexture("")

	hooksecurefunc(TargetFrameManaBar, "SetStatusBarTexture", function(self, texture)
		if self.settexture then return end
		self.settexture = true
		
		if DUFTAB["bartexture"] and DUFTAB["bartexture"] > 0 then
			self:SetStatusBarTexture("Interface\\Addons\\DUnitFrames\\media\\bars\\bar_" .. DUFTAB["bartexture"])
		else
			self:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
		end

		self.settexture = false
	end)
	TargetFrameManaBar:SetStatusBarTexture("")

	if TargetFrameTextureFrame.HealthBarTextLeft then
		TargetFrameTextureFrameHealthBarText = TargetFrameTextureFrame.HealthBarText
		TargetFrameTextureFrameHealthBarTextLeft = TargetFrameTextureFrame.HealthBarTextLeft
		TargetFrameTextureFrameHealthBarTextRight = TargetFrameTextureFrame.HealthBarTextRight

		TargetFrameTextureFrameManaBarText = TargetFrameTextureFrame.ManaBarText
		TargetFrameTextureFrameManaBarTextLeft = TargetFrameTextureFrame.ManaBarTextLeft
		TargetFrameTextureFrameManaBarTextRight = TargetFrameTextureFrame.ManaBarTextRight
	end

	hooksecurefunc(TargetFrameHealthBar, "SetStatusBarColor", function(self, ...)
		if self.dufsetvertexcolor then return end
		self.dufsetvertexcolor = true
		local r, g, b = DUFGetBarColor("TARGET")
		if r and g and b then
			self:SetStatusBarColor(r, g, b)
		end
		self.dufsetvertexcolor = false
	end)
	TargetFrameHealthBar.dr, TargetFrameHealthBar.dg, TargetFrameHealthBar.db = TargetFrameHealthBar:GetStatusBarColor()
	TargetFrameHealthBar:SetStatusBarColor(1, 1, 1)

	if TargetFrameHealthBarTextLeft ~= nil then
		if TargetFrameHealthBarTextLeft.hooked == nil then
			TargetFrameHealthBarTextLeft.hooked = true

			hooksecurefunc(TargetFrameHealthBarTextRight, "SetText", function(self, ...)
				if self.dufsettext then return end
				self.dufsettext = true
				local fontFamily, fontSize, fontFlags = self:GetFont()
				if fontSize ~= DUFFontSize then
					self:SetFont(fontFamily, DUFFontSize, fontFlags)
				end
				if DUFGetConfig("numbermode", "X.X Dynamic") ~= "Default" then
					self:SetText(DUFNN(UnitHealth("TARGET")))
				end
				self.dufsettext = false
			end)
			TargetFrameHealthBarTextRight:SetText(TargetFrameHealthBarTextRight:GetText())

			hooksecurefunc(TargetFrameHealthBarTextLeft, "SetText", function(self, ...)
				if self.dufsettext then return end
				self.dufsettext = true
				local fontFamily, fontSize, fontFlags = self:GetFont()
				if fontSize ~= DUFFontSize then
					self:SetFont(fontFamily, DUFFontSize, fontFlags)
				end
				if DUFGetConfig("percentmode", "X.X%") ~= "Default" then
					self:SetText(DUFPN(UnitHealth("TARGET"), UnitHealthMax("TARGET")))
				end
				self.dufsettext = false
			end)
			TargetFrameHealthBarTextLeft:SetText(TargetFrameHealthBarTextLeft:GetText())

			hooksecurefunc(TargetFrameHealthBarText, "SetText", function(self, ...)
				if self.dufsettext then return end
				self.dufsettext = true
				local fontFamily, fontSize, fontFlags = self:GetFont()
				if fontSize ~= DUFFontSize then
					self:SetFont(fontFamily, DUFFontSize, fontFlags)
				end
				self:SetText("")
				self.dufsettext = false
			end)
			TargetFrameHealthBarText:SetText(TargetFrameHealthBarText:GetText())

			hooksecurefunc(TargetFrameManaBarTextLeft, "SetText", function(self, ...)
				if self.dufsettext then return end
				self.dufsettext = true
				local fontFamily, fontSize, fontFlags = self:GetFont()
				if fontSize ~= DUFFontSize then
					self:SetFont(fontFamily, DUFFontSize, fontFlags)
				end
				if DUFGetConfig("percentmode", "X.X%") ~= "Default" then
					self:SetText(DUFPN(UnitPower("TARGET"), UnitPowerMax("TARGET")))
				end
				self.dufsettext = false
			end)
			TargetFrameManaBarTextLeft:SetText(TargetFrameManaBarTextLeft:GetText())
			
			hooksecurefunc(TargetFrameManaBarTextRight, "SetText", function(self, ...)
				if self.dufsettext then return end
				self.dufsettext = true
				local fontFamily, fontSize, fontFlags = self:GetFont()
				if fontSize ~= DUFFontSize then
					self:SetFont(fontFamily, DUFFontSize, fontFlags)
				end
				if DUFGetConfig("numbermode", "X.X Dynamic") ~= "Default" then
					self:SetText(DUFNN(UnitPower("TARGET")))
				end
				self.dufsettext = false
			end)
			TargetFrameManaBarTextRight:SetText(TargetFrameManaBarTextRight:GetText())

			hooksecurefunc(TargetFrameManaBarText, "SetText", function(self, ...)
				if self.dufsettext then return end
				self.dufsettext = true
				local fontFamily, fontSize, fontFlags = self:GetFont()
				if fontSize ~= DUFFontSize then
					self:SetFont(fontFamily, DUFFontSize, fontFlags)
				end
				self:SetText("")
				self.dufsettext = false
			end)
			TargetFrameManaBarText:SetText(TargetFrameManaBarText:GetText())
		end
	end
	
	if TargetFrameTextureFrameHealthBarTextLeft ~= nil then
		if TargetFrameTextureFrameHealthBarTextLeft.hooked == nil then
			TargetFrameTextureFrameHealthBarTextLeft.hooked = true

			TargetFrameTextureFrameHealthBarTextLeft.Hide = TargetFrameTextureFrameHealthBarTextLeft.Show
			hooksecurefunc(TargetFrameTextureFrameHealthBarTextLeft, "SetText", function(self, ...)
				if self.dufsettext then return end
				self.dufsettext = true
				local fontFamily, fontSize, fontFlags = self:GetFont()
				if fontSize ~= DUFFontSize then
					self:SetFont(fontFamily, DUFFontSize, fontFlags)
				end
				if DUFGetConfig("percentmode", "X.X%") ~= "Default" then
					self:SetText(DUFPN(UnitHealth("TARGET"), UnitHealthMax("TARGET")))
				end
				self.dufsettext = false
			end)
			TargetFrameTextureFrameHealthBarTextLeft:SetText(TargetFrameTextureFrameHealthBarTextLeft:GetText())
			
			TargetFrameTextureFrameHealthBarTextRight.Hide = TargetFrameTextureFrameHealthBarTextRight.Show
			hooksecurefunc(TargetFrameTextureFrameHealthBarTextRight, "SetText", function(self, ...)
				if self.dufsettext then return end
				self.dufsettext = true
				local fontFamily, fontSize, fontFlags = self:GetFont()
				if fontSize ~= DUFFontSize then
					self:SetFont(fontFamily, DUFFontSize, fontFlags)
				end
				if DUFGetConfig("numbermode", "X.X Dynamic") ~= "Default" then
					self:SetText(DUFNN(UnitHealth("TARGET")))
				end
				self.dufsettext = false
			end)
			TargetFrameTextureFrameHealthBarTextRight:SetText(TargetFrameTextureFrameHealthBarTextRight:GetText())

			hooksecurefunc(TargetFrameTextureFrameHealthBarText, "SetText", function(self, ...)
				if self.dufsettext then return end
				self.dufsettext = true
				local fontFamily, fontSize, fontFlags = self:GetFont()
				if fontSize ~= DUFFontSize then
					self:SetFont(fontFamily, DUFFontSize, fontFlags)
				end
				self:SetText("")
				self.dufsettext = false
			end)
			TargetFrameTextureFrameHealthBarText:SetText(TargetFrameTextureFrameHealthBarText:GetText())

			hooksecurefunc(TargetFrameTextureFrameManaBarTextLeft, "SetText", function(self, ...)
				if self.dufsettext then return end
				self.dufsettext = true
				local fontFamily, fontSize, fontFlags = self:GetFont()
				if fontSize ~= DUFFontSize then
					self:SetFont(fontFamily, DUFFontSize, fontFlags)
				end
				if DUFGetConfig("percentmode", "X.X%") ~= "Default" then
					self:SetText(DUFPN(UnitPower("TARGET"), UnitPowerMax("TARGET")))
				end
				self.dufsettext = false
			end)
			TargetFrameTextureFrameManaBarTextLeft:SetText(TargetFrameTextureFrameManaBarTextLeft:GetText())
			
			hooksecurefunc(TargetFrameTextureFrameManaBarTextRight, "SetText", function(self, ...)
				if self.dufsettext then return end
				self.dufsettext = true
				local fontFamily, fontSize, fontFlags = self:GetFont()
				if fontSize ~= DUFFontSize then
					self:SetFont(fontFamily, DUFFontSize, fontFlags)
				end
				if DUFGetConfig("numbermode", "X.X Dynamic") ~= "Default" then
					self:SetText(DUFNN(UnitPower("TARGET")))
				end
				self.dufsettext = false
			end)
			TargetFrameTextureFrameManaBarTextRight:SetText(TargetFrameTextureFrameManaBarTextRight:GetText())

			hooksecurefunc(TargetFrameTextureFrameManaBarText, "SetText", function(self, ...)
				if self.dufsettext then return end
				self.dufsettext = true
				local fontFamily, fontSize, fontFlags = self:GetFont()
				if fontSize ~= DUFFontSize then
					self:SetFont(fontFamily, DUFFontSize, fontFlags)
				end
				self:SetText("")
				self.dufsettext = false
			end)
			TargetFrameTextureFrameManaBarText:SetText(TargetFrameTextureFrameManaBarText:GetText())
		end
	end

	-- #TargetFrame
	hooksecurefunc(TargetFrameHealthBar, "SetHeight", function(self)
		if self.dufsetheight then return end
		self.dufsetheight = true

		self:SetHeight(DUFHPHeight())

		self.dufsetheight = false
	end)
	TargetFrameHealthBar:SetHeight(27)
	hooksecurefunc(TargetFrameHealthBar, "SetSize", function(self)
		if self.dufsetsize then return end
		self.dufsetsize = true

		self:SetHeight(DUFHPHeight())

		self.dufsetsize = false
	end)
	hooksecurefunc(TargetFrameHealthBar, "SetPoint", function(self)
		if self.dufsetpoint then return end
		self.dufsetpoint = true

		self:SetPoint("TOPLEFT", 6, -24)

		self.dufsetpoint = false
	end)
	TargetFrameHealthBar:SetPoint("TOPLEFT", 6, -24)

	hooksecurefunc(TargetFrameManaBar, "SetHeight", function(self)
		if self.dufsetheight then return end
		self.dufsetheight = true

		if 38 - DUFHPHeight() > 1 then
			self:SetHeight(38 - DUFHPHeight())
		else
			self:SetHeight(1)
		end

		self.dufsetheight = false
	end)
	TargetFrameManaBar:SetHeight(27)
	hooksecurefunc(TargetFrameManaBar, "SetSize", function(self)
		if self.dufsetsize then return end
		self.dufsetsize = true

		if 38 - DUFHPHeight() > 1 then
			self:SetHeight(38 - DUFHPHeight())
		else
			self:SetHeight(1)
		end

		self.dufsetsize = false
	end)
	hooksecurefunc(TargetFrameManaBar, "SetPoint", function(self)
		if self.dufsetpoint then return end
		self.dufsetpoint = true

		self:SetPoint("TOPLEFT", 6, -23 -DUFHPHeight() - 1)

		self.dufsetpoint = false
	end)
	TargetFrameManaBar:SetPoint("TOPLEFT", 6, -24)

	TargetFrameBackground:SetHeight(40)
	TargetFrameBackground:ClearAllPoints()
	TargetFrameBackground:SetPoint("TOPLEFT", 6, -24)

	TargetFrameNameBackground.Show = TargetFrameNameBackground.Hide
	TargetFrameNameBackground:Hide()

	function DUFUpdateTargetTexture()
		local texture = "Interface\\Addons\\DUnitFrames\\media\\UI-TargetingFrame"
		local class = UnitClassification("TARGET")
		if class == "worldboss" or class == "elite" then
			texture = "Interface\\Addons\\DUnitFrames\\media\\UI-TargetingFrame-Elite"
		elseif class == "rareelite" then
			texture = "Interface\\Addons\\DUnitFrames\\media\\UI-TargetingFrame-Rare-Elite"
		elseif class == "rare" then
			texture = "Interface\\Addons\\DUnitFrames\\media\\UI-TargetingFrame-Rare"
		end
		TargetFrameTextureFrameTexture:SetTexture(texture);

		if class == "minus" then
			TargetFrameFlash:SetTexture("")
		end

		if TargetFrameTextureFrameTexture.spacer == nil then
			TargetFrameTextureFrameTexture.spacer = TargetFrameTextureFrame:CreateTexture(nil, "ARTWORK")
			TargetFrameTextureFrameTexture.spacer:SetDrawLayer("ARTWORK", 7)
			hooksecurefunc(TargetFrameTextureFrameTexture.spacer, "SetVertexColor", function(self, r, g, b, a)
				if self.dufsetvertexcolor then return end
				self.dufsetvertexcolor = true
				self:SetVertexColor(r, g, b, a)
				self.dufsetvertexcolor = false
			end)
			TargetFrameTextureFrameTexture.spacer:SetVertexColor(1, 1, 1)
		end
		TargetFrameTextureFrameTexture.spacer:SetSize(128, 16)
		TargetFrameTextureFrameTexture.spacer:SetPoint("LEFT", TargetFrameTextureFrameTexture, "LEFT", 4, 21 - DUFHPHeight())
		TargetFrameTextureFrameTexture.spacer:SetTexture("Interface\\Addons\\DUnitFrames\\media\\UI-TargetingFrame" .. "_Spacer")

		if DUFHPHeight() >= 32 then
			TargetFrameTextureFrameTexture.spacer:Hide()
		else
			TargetFrameTextureFrameTexture.spacer:Show()
		end

		TargetFrameTextureFrameTexture:SetVertexColor(0, 0, 0)

		TargetFrameTextureFrameDeadText:SetPoint("CENTER", TargetFrameHealthBar, "CENTER", 0, 0)


		if TargetFrameHealthBarTextLeft ~= nil then
			TargetFrameHealthBarTextLeft:SetPoint("LEFT", TargetFrameHealthBar, "LEFT", 2, 0)
			TargetFrameHealthBarTextRight:SetPoint("RIGHT", TargetFrameHealthBar, "RIGHT", -2, 0)
			TargetFrameHealthBarText:SetPoint("CENTER", TargetFrameHealthBar, "CENTER", 0, 0)

			if not TargetFrameManaBarTextLeft.hooked then
				TargetFrameManaBarTextLeft.hooked = true
				hooksecurefunc(TargetFrameManaBarTextLeft, "Show", function(self, ...)
					if DUFHPHeight() >= 32 then
						self:Hide()
					end
				end)
			end
			if not TargetFrameManaBarTextRight.hooked then
				TargetFrameManaBarTextRight.hooked = true
				hooksecurefunc(TargetFrameManaBarTextRight, "Show", function(self, ...)
					if DUFHPHeight() >= 32 then
						self:Hide()
					end
				end)
			end
			if not TargetFrameManaBarText.hooked then
				TargetFrameManaBarText.hooked = true
				hooksecurefunc(TargetFrameManaBarText, "Show", function(self, ...)
					if DUFHPHeight() >= 32 then
						self:Hide()
					end
				end)
			end

			TargetFrameManaBarTextLeft:SetPoint("LEFT", TargetFrameManaBar, "LEFT", 2, 0)
			TargetFrameManaBarTextRight:SetPoint("RIGHT", TargetFrameManaBar, "RIGHT", -2, 0)
			TargetFrameManaBarText:SetPoint("CENTER", TargetFrameManaBar, "CENTER", 0, 0)
			TargetFrameManaBarTextLeft:Show()
			TargetFrameManaBarTextRight:Show()
			TargetFrameManaBarText:Show()
		elseif TargetFrameTextureFrameHealthBarTextLeft ~= nil then
			TargetFrameTextureFrameHealthBarTextLeft:SetPoint("LEFT", TargetFrameHealthBar, "LEFT", 2, 0)
			TargetFrameTextureFrameHealthBarTextRight:SetPoint("RIGHT", TargetFrameHealthBar, "RIGHT", -2, 0)
			TargetFrameTextureFrameHealthBarText:SetPoint("CENTER", TargetFrameHealthBar, "CENTER", 0, 0)

			if not TargetFrameTextureFrameManaBarTextLeft.hooked then
				TargetFrameTextureFrameManaBarTextLeft.hooked = true
				hooksecurefunc(TargetFrameTextureFrameManaBarTextLeft, "Show", function(self, ...)
					if DUFHPHeight() >= 32 then
						self:Hide()
					end
				end)
			end
			if not TargetFrameTextureFrameManaBarTextRight.hooked then
				TargetFrameTextureFrameManaBarTextRight.hooked = true
				hooksecurefunc(TargetFrameTextureFrameManaBarTextRight, "Show", function(self, ...)
					if DUFHPHeight() >= 32 then
						self:Hide()
					end
				end)
			end
			if not TargetFrameTextureFrameManaBarText.hooked then
				TargetFrameTextureFrameManaBarText.hooked = true
				hooksecurefunc(TargetFrameTextureFrameManaBarText, "Show", function(self, ...)
					if DUFHPHeight() >= 32 then
						self:Hide()
					end
				end)
			end
		
			TargetFrameTextureFrameManaBarTextLeft:SetPoint("LEFT", TargetFrameManaBar, "LEFT", 2, -1)
			TargetFrameTextureFrameManaBarTextRight:SetPoint("RIGHT", TargetFrameManaBar, "RIGHT", -2, -1)
			TargetFrameTextureFrameManaBarText:SetPoint("CENTER", TargetFrameManaBar, "CENTER", 0, 0)
			TargetFrameTextureFrameManaBarTextLeft:Show()
			TargetFrameTextureFrameManaBarTextRight:Show()
			TargetFrameTextureFrameManaBarText:Show()
		end

		if CanInspect and GetInspectSpecialization then
			InspectTargetSpec()
		end
	end

	local ThreatBorder = nil
	if TargetFrameNumericalThreat ~= nil then
		ThreatBorder = select(3, {TargetFrameNumericalThreat:GetRegions()})
	end
	function TargetFrame.Think()
		TargetFrameTextureFrameName:ClearAllPoints()
		if TargetFrame.buffsOnTop then
			local y = -4
			if DUFGetConfig("namemode", "Over Portrait") == "Over Health" then
				TargetFrameTextureFrameName:SetPoint("TOP", TargetFrameManaBar, "BOTTOM", 0, y)
			end
		else
			local y = 6
			if DUFGetConfig("namemode", "Over Portrait") == "Over Health" then
				TargetFrameTextureFrameName:SetPoint("BOTTOM", TargetFrameHealthBar, "TOP", 0, y)
			end
		end
		if DUFGetConfig("namemode", "Over Portrait") == "Over Portrait" then
			TargetFrameTextureFrameName:SetPoint("BOTTOM", TargetFramePortrait, "TOP", 0, 12)
		end
		
		if ThreatBorder and ThreatBorder:IsShown() then
			y = 24
			local r, g, b = DUFGetBorderColor("TARGET")
			if ThreatBorder then
				ThreatBorder:SetVertexColor(r, g, b)
			end
		else
			local isTanking, status, threatpct, rawthreatpct, threatvalue, percentOfLead = UnitDetailedThreatSituation("PLAYER", "TARGET");
			if TargetFrame.DUFThreat == nil then
				TargetFrame.DUFThreat = TargetFrame:CreateFontString(nil, "ARTWORK") 
			end
			TargetFrame.DUFThreat:SetFont(STANDARD_TEXT_FONT, 12, "")
			if DUFGetConfig("namemode") == "Over Health" then
				TargetFrame.DUFThreat:SetPoint("BOTTOM", TargetFrameHealthBar, "TOP", 0, 20)
			else
				TargetFrame.DUFThreat:SetPoint("BOTTOM", TargetFrameHealthBar, "TOP", 0, 6)
			end

			if threatpct == nil then
				threatpct = 0
			end
			if threatpct > 0 and DUFGetConfig("showthreat", true) then
				threatpct = string.format("%.0f", threatpct)
				TargetFrame.DUFThreat:SetText(threatpct .. "%")
			else
				TargetFrame.DUFThreat:SetText("")
			end
		end

		C_Timer.After(0.5, TargetFrame.Think)
	end
	TargetFrame.Think()

	hooksecurefunc(TargetFrameTextureFrameName, "SetText", function(self, text, ...)
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
	TargetFrameTextureFrameName:SetText(TargetFrameTextureFrameName:GetText())

	hooksecurefunc(TargetFrameTextureFrameTexture, "SetVertexColor", function(self, ...)
		if self.dufsetvertexcolor then return end
		self.dufsetvertexcolor = true
		local r, g, b = DUFGetBorderColor("TARGET")
		self:SetVertexColor(r, g, b, 1)
		if self.spacer then
			self.spacer:SetVertexColor(self:GetVertexColor())
		end
		self.dufsetvertexcolor = false
	end)
	TargetFrameTextureFrameTexture:SetVertexColor(1, 1, 1)

	hooksecurefunc(TargetFrameToTTextureFrameTexture, "SetVertexColor", function(self, ...)
		if self.dufsetvertexcolor then return end
		self.dufsetvertexcolor = true
		local r, g, b = DUFGetBorderColor("TARGETTARGET")
		self:SetVertexColor(r, g, b, 1)
		self.dufsetvertexcolor = false
	end)
	TargetFrameToTTextureFrameTexture:SetVertexColor(1, 1, 1)
	function TargetFrameToT.Think()
		TargetFrameToTTextureFrameTexture:SetVertexColor(1, 1, 1)
		C_Timer.After(0.1, TargetFrameToT.Think)
	end
	TargetFrameToT.Think()


	if CanInspect and GetInspectSpecialization then
		local f = CreateFrame("Frame")
		function InspectTargetSpec()
			if TargetFramePortrait.spec ~= nil then
				TargetFramePortrait.spec:SetTexture(nil)
			end
			if UnitIsPlayer("TARGET") then
				if CanInspect("TARGET") and CheckInteractDistance("TARGET", 1) then
					f:RegisterEvent("INSPECT_READY")
					NotifyInspect("TARGET")
				end
			end
		end
		f:SetScript("OnEvent", function(self, event, ...)
			if GetInspectSpecialization ~= nil then
				local currentSpec = GetInspectSpecialization("TARGET")
				f:UnregisterEvent("INSPECT_READY")
				ClearInspectPlayer()
				local id, name, _, icon, _, _ = GetSpecializationInfoByID(currentSpec)
				if id ~= nil and not InCombatLockdown() and DUFGetConfig("showspecs", true) then
					if TargetFramePortrait.spec == nil then
						TargetFramePortrait.spec = TargetFrame:CreateTexture(nil, "Artwork")
						TargetFramePortrait.spec:SetAllPoints(TargetFramePortrait)
					end
					TargetFramePortrait.spec:SetTexture(icon)
					TargetFramePortrait.spec:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMask")
				end
			end
		end)
	end
end

function DUFUpdateTargetFrame()
	TargetFrameManaBar:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	TargetFrameHealthBar:SetHeight(1)
	TargetFrameManaBar:SetHeight(1)
end