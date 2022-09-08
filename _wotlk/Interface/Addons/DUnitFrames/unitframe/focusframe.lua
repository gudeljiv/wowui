-- #FocusFrame

local DUFFontSize = 12

if FocusFrame then
	function DUFFocusFrameSetup()
		hooksecurefunc(FocusFrameHealthBar, "SetStatusBarTexture", function(self, texture)
			if self.settexture then return end
			self.settexture = true
	
			if DUFTAB["bartexture"] and DUFTAB["bartexture"] > 0 then
				self:SetStatusBarTexture("Interface\\Addons\\DUnitFrames\\media\\bars\\bar_" .. DUFTAB["bartexture"])
			else
				self:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
			end
	
			self.settexture = false
		end)
		FocusFrameHealthBar:SetStatusBarTexture("")
	
		hooksecurefunc(FocusFrameManaBar, "SetStatusBarTexture", function(self, texture)
			if self.settexture then return end
			self.settexture = true
			
			if DUFTAB["bartexture"] and DUFTAB["bartexture"] > 0 then
				self:SetStatusBarTexture("Interface\\Addons\\DUnitFrames\\media\\bars\\bar_" .. DUFTAB["bartexture"])
			else
				self:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
			end
	
			self.settexture = false
		end)
		FocusFrameManaBar:SetStatusBarTexture("")
	
		if FocusFrameTextureFrame.HealthBarTextLeft then
			FocusFrameTextureFrameHealthBarText = FocusFrameTextureFrame.HealthBarText
			FocusFrameTextureFrameHealthBarTextLeft = FocusFrameTextureFrame.HealthBarTextLeft
			FocusFrameTextureFrameHealthBarTextRight = FocusFrameTextureFrame.HealthBarTextRight
	
			FocusFrameTextureFrameManaBarText = FocusFrameTextureFrame.ManaBarText
			FocusFrameTextureFrameManaBarTextLeft = FocusFrameTextureFrame.ManaBarTextLeft
			FocusFrameTextureFrameManaBarTextRight = FocusFrameTextureFrame.ManaBarTextRight
		end

		hooksecurefunc(FocusFrameHealthBar, "SetStatusBarColor", function(self, ...)
			if self.dufsetvertexcolor then return end
			self.dufsetvertexcolor = true
			local r, g, b = DUFGetBarColor("FOCUS")
			if r and g and b then
				self:SetStatusBarColor(r, g, b)
			end
			self.dufsetvertexcolor = false
		end)
		FocusFrameHealthBar.dr, FocusFrameHealthBar.dg, FocusFrameHealthBar.db = FocusFrameHealthBar:GetStatusBarColor()
		FocusFrameHealthBar:SetStatusBarColor(1, 1, 1)

		if FocusFrameHealthBarTextLeft ~= nil then
			if FocusFrameHealthBarTextLeft.hooked == nil then
				FocusFrameHealthBarTextLeft.hooked = true

				hooksecurefunc(FocusFrameHealthBarTextRight, "SetText", function(self, ...)
					if self.dufsettext then return end
					self.dufsettext = true
					local fontFamily, fontSize, fontFlags = self:GetFont()
					if fontSize ~= DUFFontSize then
						self:SetFont(fontFamily, DUFFontSize, fontFlags)
					end
					if DUFGetConfig("numbermode", "X.X Dynamic") ~= "Default" then
						self:SetText(DUFNN(UnitHealth("FOCUS")))
					end
					self.dufsettext = false
				end)
				FocusFrameHealthBarTextRight:SetText(FocusFrameHealthBarTextRight:GetText())

				hooksecurefunc(FocusFrameHealthBarTextLeft, "SetText", function(self, ...)
					if self.dufsettext then return end
					self.dufsettext = true
					local fontFamily, fontSize, fontFlags = self:GetFont()
					if fontSize ~= DUFFontSize then
						self:SetFont(fontFamily, DUFFontSize, fontFlags)
					end
					if DUFGetConfig("percentmode", "X.X%") ~= "Default" then
						self:SetText(DUFPN(UnitHealth("FOCUS"), UnitHealthMax("FOCUS")))
					end
					self.dufsettext = false
				end)
				FocusFrameHealthBarTextLeft:SetText(FocusFrameHealthBarTextLeft:GetText())

				hooksecurefunc(FocusFrameHealthBarText, "SetText", function(self, ...)
					if self.dufsettext then return end
					self.dufsettext = true
					local fontFamily, fontSize, fontFlags = self:GetFont()
					if fontSize ~= DUFFontSize then
						self:SetFont(fontFamily, DUFFontSize, fontFlags)
					end
					self.dufsettext = false
				end)
				FocusFrameHealthBarText:SetText(FocusFrameHealthBarText:GetText())

				hooksecurefunc(FocusFrameManaBarTextLeft, "SetText", function(self, ...)
					if self.dufsettext then return end
					self.dufsettext = true
					local fontFamily, fontSize, fontFlags = self:GetFont()
					if fontSize ~= DUFFontSize then
						self:SetFont(fontFamily, DUFFontSize, fontFlags)
					end
					if DUFGetConfig("percentmode", "X.X%") ~= "Default" then
						self:SetText(DUFPN(UnitPower("FOCUS"), UnitPowerMax("FOCUS")))
					end
					self.dufsettext = false
				end)
				FocusFrameManaBarTextLeft:SetText(FocusFrameManaBarTextLeft:GetText())
				
				hooksecurefunc(FocusFrameManaBarTextRight, "SetText", function(self, ...)
					if self.dufsettext then return end
					self.dufsettext = true
					local fontFamily, fontSize, fontFlags = self:GetFont()
					if fontSize ~= DUFFontSize then
						self:SetFont(fontFamily, DUFFontSize, fontFlags)
					end
					if DUFGetConfig("numbermode", "X.X Dynamic") ~= "Default" then
						self:SetText(DUFNN(UnitPower("FOCUS")))
					end
					self.dufsettext = false
				end)
				FocusFrameManaBarTextRight:SetText(FocusFrameManaBarTextRight:GetText())

				hooksecurefunc(FocusFrameManaBarText, "SetText", function(self, ...)
					if self.dufsettext then return end
					self.dufsettext = true
					local fontFamily, fontSize, fontFlags = self:GetFont()
					if fontSize ~= DUFFontSize then
						self:SetFont(fontFamily, DUFFontSize, fontFlags)
					end
					self.dufsettext = false
				end)
				FocusFrameManaBarText:SetText(FocusFrameManaBarText:GetText())
			end
		end

		if FocusFrameTextureFrameHealthBarTextLeft ~= nil then
			if FocusFrameTextureFrameHealthBarTextLeft.hooked == nil then
				FocusFrameTextureFrameHealthBarTextLeft.hooked = true

				FocusFrameTextureFrameHealthBarTextLeft.Hide = FocusFrameTextureFrameHealthBarTextLeft.Show
				hooksecurefunc(FocusFrameTextureFrameHealthBarTextLeft, "SetText", function(self, ...)
					if self.dufsettext then return end
					self.dufsettext = true
					local fontFamily, fontSize, fontFlags = self:GetFont()
					if fontSize ~= DUFFontSize then
						self:SetFont(fontFamily, DUFFontSize, fontFlags)
					end
					if DUFGetConfig("percentmode", "X.X%") ~= "Default" then
						self:SetText(DUFPN(UnitHealth("FOCUS"), UnitHealthMax("FOCUS")))
					end
					self.dufsettext = false
				end)
				FocusFrameTextureFrameHealthBarTextLeft:SetText(FocusFrameTextureFrameHealthBarTextLeft:GetText())
				
				FocusFrameTextureFrameHealthBarTextRight.Hide = FocusFrameTextureFrameHealthBarTextRight.Show
				hooksecurefunc(FocusFrameTextureFrameHealthBarTextRight, "SetText", function(self, ...)
					if self.dufsettext then return end
					self.dufsettext = true
					local fontFamily, fontSize, fontFlags = self:GetFont()
					if fontSize ~= DUFFontSize then
						self:SetFont(fontFamily, DUFFontSize, fontFlags)
					end
					if DUFGetConfig("numbermode", "X.X Dynamic") ~= "Default" then
						self:SetText(DUFNN(UnitHealth("FOCUS")))
					end
					self.dufsettext = false
				end)
				FocusFrameTextureFrameHealthBarTextRight:SetText(FocusFrameTextureFrameHealthBarTextRight:GetText())

				hooksecurefunc(FocusFrameTextureFrameHealthBarText, "SetText", function(self, ...)
					if self.dufsettext then return end
					self.dufsettext = true
					local fontFamily, fontSize, fontFlags = self:GetFont()
					if fontSize ~= DUFFontSize then
						self:SetFont(fontFamily, DUFFontSize, fontFlags)
					end
					self.dufsettext = false
				end)
				FocusFrameTextureFrameHealthBarText:SetText(FocusFrameTextureFrameHealthBarText:GetText())

				hooksecurefunc(FocusFrameTextureFrameManaBarTextLeft, "SetText", function(self, ...)
					if self.dufsettext then return end
					self.dufsettext = true
					local fontFamily, fontSize, fontFlags = self:GetFont()
					if fontSize ~= DUFFontSize then
						self:SetFont(fontFamily, DUFFontSize, fontFlags)
					end
					if DUFGetConfig("percentmode", "X.X%") ~= "Default" then
						self:SetText(DUFPN(UnitPower("FOCUS"), UnitPowerMax("FOCUS")))
					end
					self.dufsettext = false
				end)
				FocusFrameTextureFrameManaBarTextLeft:SetText(FocusFrameTextureFrameManaBarTextLeft:GetText())
				
				hooksecurefunc(FocusFrameTextureFrameManaBarTextRight, "SetText", function(self, ...)
					if self.dufsettext then return end
					self.dufsettext = true
					local fontFamily, fontSize, fontFlags = self:GetFont()
					if fontSize ~= DUFFontSize then
						self:SetFont(fontFamily, DUFFontSize, fontFlags)
					end
					if DUFGetConfig("numbermode", "X.X Dynamic") ~= "Default" then
						self:SetText(DUFNN(UnitPower("FOCUS")))
					end
					self.dufsettext = false
				end)
				FocusFrameTextureFrameManaBarTextRight:SetText(FocusFrameTextureFrameManaBarTextRight:GetText())

				hooksecurefunc(FocusFrameTextureFrameManaBarText, "SetText", function(self, ...)
					if self.dufsettext then return end
					self.dufsettext = true
					local fontFamily, fontSize, fontFlags = self:GetFont()
					if fontSize ~= DUFFontSize then
						self:SetFont(fontFamily, DUFFontSize, fontFlags)
					end
					self.dufsettext = false
				end)
				FocusFrameTextureFrameManaBarText:SetText(FocusFrameTextureFrameManaBarText:GetText())
			end
		end

		-- #FocusFrame
		hooksecurefunc(FocusFrameHealthBar, "SetHeight", function(self)
			if self.dufsetheight then return end
			self.dufsetheight = true

			self:SetHeight(DUFHPHeight())

			self.dufsetheight = false
		end)
		FocusFrameHealthBar:SetHeight(27)
		hooksecurefunc(FocusFrameHealthBar, "SetSize", function(self)
			if self.dufsetsize then return end
			self.dufsetsize = true

			self:SetHeight(DUFHPHeight())

			self.dufsetsize = false
		end)
		hooksecurefunc(FocusFrameHealthBar, "SetPoint", function(self)
			if self.dufsetpoint then return end
			self.dufsetpoint = true

			self:SetPoint("TOPLEFT", 6, -24)

			self.dufsetpoint = false
		end)
		FocusFrameHealthBar:SetPoint("TOPLEFT", 6, -24)

		hooksecurefunc(FocusFrameManaBar, "SetHeight", function(self)
			if self.dufsetheight then return end
			self.dufsetheight = true

			if 38 - DUFHPHeight() > 1 then
				self:SetHeight(38 - DUFHPHeight())
			else
				self:SetHeight(1)
			end	

			self.dufsetheight = false
		end)
		FocusFrameManaBar:SetHeight(27)
		hooksecurefunc(FocusFrameManaBar, "SetSize", function(self)
			if self.dufsetsize then return end
			self.dufsetsize = true

			if 38 - DUFHPHeight() > 1 then
				self:SetHeight(38 - DUFHPHeight())
			else
				self:SetHeight(1)
			end	

			self.dufsetsize = false
		end)
		hooksecurefunc(FocusFrameManaBar, "SetPoint", function(self)
			if self.dufsetpoint then return end
			self.dufsetpoint = true

			self:SetPoint("TOPLEFT", 6, -23 -DUFHPHeight() - 1)

			self.dufsetpoint = false
		end)
		FocusFrameManaBar:SetPoint("TOPLEFT", 6, -24)

		FocusFrameBackground:SetHeight(40)
		FocusFrameBackground:ClearAllPoints()
		FocusFrameBackground:SetPoint("TOPLEFT", 6, -24)

		FocusFrameNameBackground.Show = FocusFrameNameBackground.Hide
		FocusFrameNameBackground:Hide()

		function DUFUpdateFocusTexture()
			local texture = "Interface\\Addons\\DUnitFrames\\media\\UI-TargetingFrame"
			local class = UnitClassification("FOCUS")
			if class == "worldboss" or class == "elite" then
				texture = "Interface\\Addons\\DUnitFrames\\media\\UI-TargetingFrame-Elite"
			elseif class == "rareelite" then
				texture = "Interface\\Addons\\DUnitFrames\\media\\UI-TargetingFrame-Rare-Elite"
			elseif class == "rare" then
				texture = "Interface\\Addons\\DUnitFrames\\media\\UI-TargetingFrame-Rare"
			end
			FocusFrameTextureFrameTexture:SetTexture(texture);

			if class == "minus" then
				FocusFrameFlash:SetTexture("")
			end

			if FocusFrameTextureFrameTexture.spacer == nil then
				FocusFrameTextureFrameTexture.spacer = FocusFrameTextureFrame:CreateTexture(nil, "ARTWORK")
				FocusFrameTextureFrameTexture.spacer:SetDrawLayer("ARTWORK", 7)
				hooksecurefunc(FocusFrameTextureFrameTexture.spacer, "SetVertexColor", function(self, r, g, b, a)
					if self.dufsetvertexcolor then return end
					self.dufsetvertexcolor = true
					self:SetVertexColor(r, g, b, a)
					self.dufsetvertexcolor = false
				end)
				FocusFrameTextureFrameTexture.spacer:SetVertexColor(1, 1, 1)
			end
			FocusFrameTextureFrameTexture.spacer:SetSize(128, 16)
			FocusFrameTextureFrameTexture.spacer:SetPoint("LEFT", FocusFrameTextureFrameTexture, "LEFT", 5, 21 - DUFHPHeight())
			FocusFrameTextureFrameTexture.spacer:SetTexture("Interface\\Addons\\DUnitFrames\\media\\UI-TargetingFrame" .. "_Spacer")

			if DUFHPHeight() >= 32 then
				FocusFrameTextureFrameTexture.spacer:Hide()
			else
				FocusFrameTextureFrameTexture.spacer:Show()
			end

			FocusFrameTextureFrameTexture:SetVertexColor(0, 0, 0)

			FocusFrameTextureFrameDeadText:SetPoint("CENTER", FocusFrameHealthBar, "CENTER", 0, 0)


			if FocusFrameHealthBarTextLeft ~= nil then
				FocusFrameHealthBarTextLeft:SetPoint("LEFT", FocusFrameHealthBar, "LEFT", 2, 0)
				FocusFrameHealthBarTextRight:SetPoint("RIGHT", FocusFrameHealthBar, "RIGHT", -2, 0)
				FocusFrameHealthBarText:SetPoint("CENTER", FocusFrameHealthBar, "CENTER", 0, 0)

				if not FocusFrameManaBarTextLeft.hooked then
					FocusFrameManaBarTextLeft.hooked = true
					hooksecurefunc(FocusFrameManaBarTextLeft, "Show", function(self, ...)
						if DUFHPHeight() >= 32 then
							self:Hide()
						end
					end)
				end
				if not FocusFrameManaBarTextRight.hooked then
					FocusFrameManaBarTextRight.hooked = true
					hooksecurefunc(FocusFrameManaBarTextRight, "Show", function(self, ...)
						if DUFHPHeight() >= 32 then
							self:Hide()
						end
					end)
				end
				if not FocusFrameManaBarText.hooked then
					FocusFrameManaBarText.hooked = true
					hooksecurefunc(FocusFrameManaBarText, "Show", function(self, ...)
						if DUFHPHeight() >= 32 then
							self:Hide()
						end
					end)
				end

				FocusFrameManaBarTextLeft:SetPoint("LEFT", FocusFrameManaBar, "LEFT", 2, 0)
				FocusFrameManaBarTextRight:SetPoint("RIGHT", FocusFrameManaBar, "RIGHT", -2, 0)
				FocusFrameManaBarText:SetPoint("CENTER", FocusFrameManaBar, "CENTER", 0, 0)
				FocusFrameManaBarTextLeft:Show()
				FocusFrameManaBarTextRight:Show()
				FocusFrameManaBarText:Show()
			elseif FocusFrameTextureFrameHealthBarTextLeft ~= nil then
				FocusFrameTextureFrameHealthBarTextLeft:SetPoint("LEFT", FocusFrameHealthBar, "LEFT", 2, 0)
				FocusFrameTextureFrameHealthBarTextRight:SetPoint("RIGHT", FocusFrameHealthBar, "RIGHT", -2, 0)
				FocusFrameTextureFrameHealthBarText:SetPoint("CENTER", FocusFrameHealthBar, "CENTER", 0, 0)

				if not FocusFrameTextureFrameManaBarTextLeft.hooked then
					FocusFrameTextureFrameManaBarTextLeft.hooked = true
					hooksecurefunc(FocusFrameTextureFrameManaBarTextLeft, "Show", function(self, ...)
						if DUFHPHeight() >= 32 then
							self:Hide()
						end
					end)
				end
				if not FocusFrameTextureFrameManaBarTextRight.hooked then
					FocusFrameTextureFrameManaBarTextRight.hooked = true
					hooksecurefunc(FocusFrameTextureFrameManaBarTextRight, "Show", function(self, ...)
						if DUFHPHeight() >= 32 then
							self:Hide()
						end
					end)
				end
				if not FocusFrameTextureFrameManaBarText.hooked then
					FocusFrameTextureFrameManaBarText.hooked = true
					hooksecurefunc(FocusFrameTextureFrameManaBarText, "Show", function(self, ...)
						if DUFHPHeight() >= 32 then
							self:Hide()
						end
					end)
				end
			
				FocusFrameTextureFrameManaBarTextLeft:SetPoint("LEFT", FocusFrameManaBar, "LEFT", 2, -1)
				FocusFrameTextureFrameManaBarTextRight:SetPoint("RIGHT", FocusFrameManaBar, "RIGHT", -2, -1)
				FocusFrameTextureFrameManaBarText:SetPoint("CENTER", FocusFrameManaBar, "CENTER", 0, 0)
				FocusFrameTextureFrameManaBarTextLeft:Show()
				FocusFrameTextureFrameManaBarTextRight:Show()
				FocusFrameTextureFrameManaBarText:Show()
			end

			if InspectFocusSpec then
				InspectFocusSpec()
			end
		end

		local ThreatBorder = nil
		if FocusFrameNumericalThreat ~= nil then
			ThreatBorder = select(3, {FocusFrameNumericalThreat:GetRegions()})
		end
		function FocusFrame.Think()
			FocusFrameTextureFrameName:ClearAllPoints()
			if FocusFrame.buffsOnTop then
				local y = -4
				if DUFGetConfig("namemode", "Over Portrait") == "Over Health" then
					FocusFrameTextureFrameName:SetPoint("TOP", FocusFrameManaBar, "BOTTOM", 0, y)
				end
			else
				local y = 6
				if DUFGetConfig("namemode", "Over Portrait") == "Over Health" then
					FocusFrameTextureFrameName:SetPoint("BOTTOM", FocusFrameHealthBar, "TOP", 0, y)
				end
			end
			if DUFGetConfig("namemode", "Over Portrait") == "Over Portrait" then
				FocusFrameTextureFrameName:SetPoint("BOTTOM", FocusFramePortrait, "TOP", 0, 12)
			end

			if ThreatBorder and ThreatBorder:IsShown() then
				y = 24
				local r, g, b = DUFGetBorderColor("FOCUS")
				if ThreatBorder then
					ThreatBorder:SetVertexColor(r, g, b)
				end
			end

			C_Timer.After(0.5, FocusFrame.Think)
		end
		FocusFrame.Think()

		hooksecurefunc(FocusFrameTextureFrameName, "SetText", function(self, text, ...)
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
		FocusFrameTextureFrameName:SetText(FocusFrameTextureFrameName:GetText())

		hooksecurefunc(FocusFrameTextureFrameTexture, "SetVertexColor", function(self, ...)
			if self.dufsetvertexcolor then return end
			self.dufsetvertexcolor = true
			local r, g, b = DUFGetBorderColor("FOCUS")
			self:SetVertexColor(r, g, b, 1)
			if self.spacer then
				self.spacer:SetVertexColor(self:GetVertexColor())
			end
			self.dufsetvertexcolor = false
		end)
		FocusFrameTextureFrameTexture:SetVertexColor(1, 1, 1)



		if CanInspect and GetInspectSpecialization then
			local f = CreateFrame("Frame")
			function InspectFocusSpec()
				if FocusFramePortrait.spec ~= nil then
					FocusFramePortrait.spec:SetTexture(nil)
				end
				if UnitIsPlayer("FOCUS") then
					if CanInspect("FOCUS") and CheckInteractDistance("FOCUS", 1) then
						f:RegisterEvent("INSPECT_READY")
						NotifyInspect("FOCUS")
					end
				end
			end
			f:SetScript("OnEvent", function(self, event, ...)
				if GetInspectSpecialization ~= nil then
					local currentSpec = GetInspectSpecialization("FOCUS")
					f:UnregisterEvent("INSPECT_READY")
					ClearInspectPlayer()
					local id, name, _, icon, _, _ = GetSpecializationInfoByID(currentSpec)
					if id ~= nil and not InCombatLockdown() and DUFGetConfig("showspecs", true) then
						if FocusFramePortrait.spec == nil then
							FocusFramePortrait.spec = FocusFrame:CreateTexture(nil, "Artwork")
							FocusFramePortrait.spec:SetAllPoints(FocusFramePortrait)
						end
						FocusFramePortrait.spec:SetTexture(icon)
						FocusFramePortrait.spec:SetMask("Interface\\CharacterFrame\\TempPortraitAlphaMask")
					end
				end
			end)
		end
	end

	function DUFUpdateFocusFrame()
		if FocusFrame then
			FocusFrameHealthBar:SetHeight(1)
			FocusFrameManaBar:SetHeight(1)
			FocusFrameManaBar:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
		end
	end
end