local Module = SUI:NewModule("CastBars.Target");

function Module:OnEnable()
    local db = SUI.db.profile.castbars

    if (db.style == 'Custom' and db.targetCastbar) then
        if (db.targetOnTop) then
            if TargetFrameSpellBar and TargetFrameSpellBar.HookScript and TargetFrame then
                TargetFrameSpellBar:HookScript("OnUpdate", function(self)
                    self:ClearAllPoints()
                    self:SetPoint("TOPLEFT", TargetFrame, "TOPLEFT", 45, 0)
                end)
            end
        end

        if not (TargetFrameSpellBar and TargetFrameSpellBar.HookScript) then
            return
        end

        TargetFrameSpellBar:HookScript("OnEvent", function(self)
            if self:IsForbidden() then return end
            if InCombatLockdown() then return end

            if db.targetSize then
                self:SetScale(db.targetSize)
            end

            if self.Icon then
                self.Icon:SetSize(16, 16)
                self.Icon:ClearAllPoints()
                self.Icon:SetPoint("TOPLEFT", self, "TOPLEFT", -20, 2)
            end
            if self.BorderShield and self.Icon then
                self.BorderShield:ClearAllPoints()
                self.BorderShield:SetPoint("CENTER", self.Icon, "CENTER", 0, -2.5)
            end
            self:SetSize(150, 12)
            if self.TextBorder then
                self.TextBorder:ClearAllPoints()
                self.TextBorder:SetAlpha(0)
            end
            if self.Text then
                self.Text:ClearAllPoints()
                self.Text:SetPoint("TOP", self, "TOP", 0, 2.5)
                self.Text:SetFont(STANDARD_TEXT_FONT, 11, "OUTLINE")
            end
            if SUI:Color() then
                if self.Border then
                    self.Border:SetVertexColor(unpack(SUI:Color(0.15)))
                end
                if self.Background then
                    self.Background:SetVertexColor(unpack(SUI:Color(0.15)))
                end
            end
            

            if not db.icon then
                if self.Icon then
                    self.Icon:Hide()
                end
            end

            if self.Text then
                local castText = self.Text:GetText()
                if castText ~= nil then
                    if (strlen(castText) > 19) then
                        local newCastText = strsub(castText, 0, 19)
                        self.Text:SetText(newCastText .. "...")
                    end
                end
            end
        end)
    end
end
