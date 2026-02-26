local _, nMainbar = ...
local cfg = nMainbar.Config

    -- Experience Bar

if ExpBarMixin and ExpBarMixin.OnLoad then
	hooksecurefunc(ExpBarMixin, "OnLoad", function(self)
		if self.OverlayFrame and self.OverlayFrame.Text then
			self.OverlayFrame.Text:SetFont(cfg.button.watchbarFont, cfg.button.watchbarFontsize, "OUTLINE")
			self.OverlayFrame.Text:SetShadowOffset(0, 0)
		end
	end)
end

    -- Azerite Bar (Legacy - may not exist in Midnight)

if AzeriteBarMixin and AzeriteBarMixin.OnLoad then
	hooksecurefunc(AzeriteBarMixin, "OnLoad", function(self)
		if self.OverlayFrame and self.OverlayFrame.Text then
			self.OverlayFrame.Text:SetFont(cfg.button.watchbarFont, cfg.button.watchbarFontsize, "OUTLINE")
			self.OverlayFrame.Text:SetShadowOffset(0, 0)
		end
	end)
end

    -- Reputation Bar

if ReputationBarMixin and ReputationBarMixin.OnLoad then
	hooksecurefunc(ReputationBarMixin, "OnLoad", function(self)
		if self.OverlayFrame and self.OverlayFrame.Text then
			self.OverlayFrame.Text:SetFont(cfg.button.watchbarFont, cfg.button.watchbarFontsize, "OUTLINE")
			self.OverlayFrame.Text:SetShadowOffset(0, 0)

			self:SetScript("OnMouseDown", function(self, button)
				if not nMainbar:IsTaintable() and IsAltKeyDown() then
					ToggleCharacter("ReputationFrame")
				end
			end)
		end
	end)
end

    -- Honor Bar

if HonorBarMixin and HonorBarMixin.OnLoad then
	hooksecurefunc(HonorBarMixin, "OnLoad", function(self)
		if self.OverlayFrame and self.OverlayFrame.Text then
			self.OverlayFrame.Text:SetFont(cfg.button.watchbarFont, cfg.button.watchbarFontsize, "OUTLINE")
			self.OverlayFrame.Text:SetShadowOffset(0, 0)

			self:SetScript("OnMouseDown", function(self, button)
				if not nMainbar:IsTaintable() and IsAltKeyDown() then
					if ToggleTalentFrame then
						ToggleTalentFrame(PVP_TALENTS_TAB)
					end
				end
			end)
		end
	end)
end

    -- Legion Artifact Bar (Legacy - may not exist in Midnight)

if ArtifactBarMixin and ArtifactBarMixin.OnLoad then
	hooksecurefunc(ArtifactBarMixin, "OnLoad", function(self)
		if self.OverlayFrame and self.OverlayFrame.Text then
			self.OverlayFrame.Text:SetFont(cfg.button.watchbarFont, cfg.button.watchbarFontsize, "OUTLINE")
			self.OverlayFrame.Text:SetShadowOffset(0, 0)

			self:SetScript("OnMouseDown", function(self, button)
				if not nMainbar:IsTaintable() and IsAltKeyDown() then
					if not ArtifactFrame or not ArtifactFrame:IsShown() then
						ShowUIPanel(SocketInventoryItem(16))
					elseif ArtifactFrame and ArtifactFrame:IsShown() then
						HideUIPanel(ArtifactFrame)
					end
				end
			end)
		end
	end)
end
