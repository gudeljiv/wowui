local Module = SUI:NewModule("UnitFrames.Player");

function Module:OnEnable()
    local db = {
        unitframes = SUI.db.profile.unitframes,
        texture = SUI.db.profile.general.texture,
        classbar = SUI.db.profile.unitframes.classbar
    }

    if not db.unitframes.totemicons then
        hooksecurefunc(TotemFrame, "Update", function()
            TotemFrame:Hide()
        end)
    end

    if db.texture ~= [[Interface\Default]] then
        local function healthTexture(self, event)
            if event == "PLAYER_ENTERING_WORLD" then
                local healthbar = self.healthbar or _G.PlayerFrameHealthBar
                if not healthbar then
                    return
                end
                healthbar:SetStatusBarTexture(db.texture)
                local healthTexture = healthbar.GetStatusBarTexture and healthbar:GetStatusBarTexture()
                if healthTexture then
                    healthTexture:SetDrawLayer("BORDER")
                end

                local lossBar = healthbar.AnimatedLossBar
                if lossBar then
                    lossBar:SetStatusBarTexture(db.texture)
                    local lossTexture = lossBar.GetStatusBarTexture and lossBar:GetStatusBarTexture()
                    if lossTexture then
                        lossTexture:SetDrawLayer("BORDER")
                    end
                end
            end
        end

        local function manaTexture(self)
            if self and (self.manabar or _G.PlayerFrameManaBar) then
                local manabar = self.manabar or _G.PlayerFrameManaBar
                -- Get Power Color
                local powerColor = PowerBarColor[manabar.powerType]

                -- Set Texture
                if manabar.SetStatusBarTexture then
                    manabar:SetStatusBarTexture(db.texture)
                elseif manabar.texture then
                    manabar.texture:SetTexture(db.texture)
                end

                -- Set Power Color
                if manabar.powerType == 0 then
                    manabar:SetStatusBarColor(0, 0.5, 1)
                else
                    if powerColor then
                        manabar:SetStatusBarColor(powerColor.r, powerColor.g, powerColor.b)
                    end
                end
            end
        end

        if PlayerFrame and PlayerFrame.HookScript then
            PlayerFrame:HookScript("OnEvent", function(self, event)
                healthTexture(self, event)
                manaTexture(self, event)

                if not db.unitframes.cornericon then
                    local cornerIcon = PlayerFrame.PlayerFrameContent
                        and PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual
                        and PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PlayerPortraitCornerIcon
                    if cornerIcon then
                        cornerIcon:Hide()
                    end
                end
            end)
        end

        if PetFrame and PetFrame.HookScript then
            PetFrame:HookScript("OnEvent", function(self, event)
                if event == "PLAYER_ENTERING_WORLD" then
                    local healthbar = self.healthbar or _G.PetFrameHealthBar
                    if healthbar then
                        healthbar:SetStatusBarTexture(db.texture)
                        local healthTexture = healthbar.GetStatusBarTexture and healthbar:GetStatusBarTexture()
                        if healthTexture then
                            healthTexture:SetDrawLayer("BORDER")
                        end
                    end
                end
            end)
        end
    end

    if not db.classbar then
        if RogueComboPointBarFrame then
            RogueComboPointBarFrame:HookScript("OnEvent", function()
                RogueComboPointBarFrame:Hide()
                RogueComboPointBarFrame.Show = function() end
            end)
        end

        if MageArcaneChargesFrame then
            MageArcaneChargesFrame:HookScript("OnEvent", function()
                MageArcaneChargesFrame:Hide()
                MageArcaneChargesFrame.Show = function() end
            end)
        end

        if WarlockPowerFrame then
            WarlockPowerFrame:HookScript("OnEvent", function()
                WarlockPowerFrame:Hide()
                WarlockPowerFrame.Show = function() end
            end)
        end

        if DruidComboPointBarFrame then
            DruidComboPointBarFrame:HookScript("OnEvent", function()
                DruidComboPointBarFrame:Hide()
                DruidComboPointBarFrame.Show = function() end
            end)
        end

        if MonkHarmonyBarFrame then
            MonkHarmonyBarFrame:HookScript("OnEvent", function()
                MonkHarmonyBarFrame:Hide()
                MonkHarmonyBarFrame.Show = function() end
            end)
        end

        if EssencePlayerFrame then
            EssencePlayerFrame:HookScript("OnEvent", function()
                EssencePlayerFrame:Hide()
                EssencePlayerFrame.Show = function() end
            end)
        end

        if RuneFrame then
            RuneFrame:HookScript("OnEvent", function()
                RuneFrame:Hide()
                RuneFrame.Show = function() end
            end)
        end

        if PaladinPowerBarFrame then
            PaladinPowerBarFrame:HookScript("OnEvent", function()
                PaladinPowerBarFrame:Hide()
                PaladinPowerBarFrame.Show = function() end
            end)
        end
    end

    local statusTexture = PlayerFrame.PlayerFrameContent
        and PlayerFrame.PlayerFrameContent.PlayerFrameContentMain
        and PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture
        or _G.PlayerStatusTexture
    local statusAnimation = PlayerFrame.PlayerFrameContent
        and PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual
        and PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PlayerRestLoop
        or _G.PlayerRestLoop
        or _G.PlayerRestGlow

    hooksecurefunc("PlayerFrame_UpdateStatus", function(self)
        if (IsResting()) then
            if statusTexture then
                statusTexture:Hide()
            end
            if statusAnimation then
                statusAnimation:Hide()
            end
        end
    end)
end
