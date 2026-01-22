local Module = SUI:NewModule("Skins.UnitFrames");

function Module:OnEnable()
    if (SUI:Color()) then
        -- Alternate Power Bar
        for _, v in pairs({
            PlayerFrameAlternateManaBarBorder,
            PlayerFrameAlternateManaBarLeftBorder,
            PlayerFrameAlternateManaBarRightBorder,
            PetFrameTexture
        }) do
            if v then
                v:SetDesaturated(true)
                v:SetVertexColor(unpack(SUI:Color(0.15)))
            end
        end

        -- Player Frame
        local playerFrame = _G.PlayerFrame
        if playerFrame and playerFrame.HookScript then
            playerFrame:HookScript("OnUpdate", function()
          
                PlayerFrameTexture:SetVertexColor(unpack(SUI:Color(0.15)))

                local content = playerFrame and playerFrame.PlayerFrameContent
                local cornerIcon = content
                    and content.PlayerFrameContentContextual
                    and content.PlayerFrameContentContextual.PlayerPortraitCornerIcon
                if cornerIcon then
                    cornerIcon:SetVertexColor(unpack(SUI:Color(0.15)))
                end
                if container and container.AlternatePowerFrameTexture then
                    container.AlternatePowerFrameTexture:SetVertexColor(unpack(SUI:Color(0.15)))
                end
            end)
        end

        -- Pet Frame
        if PetFrame and PetFrame.HookScript then
            PetFrame:HookScript("OnUpdate", function()
                if PetFrameTexture then
                    PetFrameTexture:SetVertexColor(unpack(SUI:Color(0.15)))
                end
            end)
        end

        -- Target Frame
        if TargetFrame and TargetFrame.HookScript then
            TargetFrame:HookScript("OnUpdate", function()
                if TargetFrameTextureFrame then
                    TargetFrameTextureFrame.texture:SetVertexColor(unpack(SUI:Color(0.15)))
                end
                if TargetFrameToTTextureFrameTexture then
                    TargetFrameToTTextureFrameTexture:SetVertexColor(unpack(SUI:Color(0.15)))
                end
            end)
        end

        -- Focus Frame
        if FocusFrame and FocusFrame.HookScript then
            FocusFrame:HookScript("OnUpdate", function()
                if FocusFrame.TargetFrameContainer and FocusFrame.TargetFrameContainer.FrameTexture then
                    FocusFrame.TargetFrameContainer.FrameTexture:SetVertexColor(unpack(SUI:Color(0.15)))
                end
                if FocusFrameToT and FocusFrameToT.FrameTexture then
                    FocusFrameToT.FrameTexture:SetVertexColor(unpack(SUI:Color(0.15)))
                end
            end)
        end

        local bossContainer = _G.BossTargetFrameContainer
        if bossContainer and bossContainer.HookScript then
            bossContainer:HookScript("OnUpdate", function()
                if Boss1TargetFrame and Boss1TargetFrame.TargetFrameContainer and Boss1TargetFrame.TargetFrameContainer.FrameTexture then
                    Boss1TargetFrame.TargetFrameContainer.FrameTexture:SetVertexColor(unpack(SUI:Color(0.15)))
                end
                if Boss2TargetFrame and Boss2TargetFrame.TargetFrameContainer and Boss2TargetFrame.TargetFrameContainer.FrameTexture then
                    Boss2TargetFrame.TargetFrameContainer.FrameTexture:SetVertexColor(unpack(SUI:Color(0.15)))
                end
                if Boss3TargetFrame and Boss3TargetFrame.TargetFrameContainer and Boss3TargetFrame.TargetFrameContainer.FrameTexture then
                    Boss3TargetFrame.TargetFrameContainer.FrameTexture:SetVertexColor(unpack(SUI:Color(0.15)))
                end
                if Boss4TargetFrame and Boss4TargetFrame.TargetFrameContainer and Boss4TargetFrame.TargetFrameContainer.FrameTexture then
                    Boss4TargetFrame.TargetFrameContainer.FrameTexture:SetVertexColor(unpack(SUI:Color(0.15)))
                end
            end)
        end

        -- Totem Bar
        if TotemFrame and TotemFrame.HookScript then
            TotemFrame:HookScript("OnEvent", function(self)
                if self.totemPool and self.totemPool.EnumerateActive then
                    for totem, _ in self.totemPool:EnumerateActive() do
                        if totem.Border then
                            totem.Border:SetVertexColor(unpack(SUI:Color(0.15)))
                        end
                    end
                end
            end)
        end

        -- Class Resource Bars
        local _, playerClass = UnitClass("player")

        if (playerClass == 'ROGUE') then
            -- Rogue
            if RogueComboPointBarFrame and RogueComboPointBarFrame.UpdatePower then
                hooksecurefunc(RogueComboPointBarFrame, "UpdatePower", function()
                    if RogueComboPointBarFrame.classResourceButtonPool then
                        for bar, _ in RogueComboPointBarFrame.classResourceButtonPool:EnumerateActive() do
                            bar.BGActive:SetVertexColor(unpack(SUI:Color(0.15)))
                            bar.BGInactive:SetVertexColor(unpack(SUI:Color(0.15)))
                            bar.BGShadow:SetVertexColor(unpack(SUI:Color(0.15)))
                            if (bar.isCharged) then
                                bar.ChargedFrameActive:SetVertexColor(unpack(SUI:Color(0.15)))
                            end
                        end
                    end

                    if ClassNameplateBarRogueFrame and ClassNameplateBarRogueFrame.classResourceButtonPool then
                        for bar, _ in ClassNameplateBarRogueFrame.classResourceButtonPool:EnumerateActive() do
                            bar.BGActive:SetVertexColor(unpack(SUI:Color(0.15)))
                            bar.BGInactive:SetVertexColor(unpack(SUI:Color(0.15)))
                            bar.BGShadow:SetVertexColor(unpack(SUI:Color(0.15)))
                            if (bar.isCharged) then
                                bar.ChargedFrameActive:SetVertexColor(unpack(SUI:Color(0.15)))
                            end
                        end
                    end
                end)
            end
        elseif (playerClass == 'MAGE') then
            -- Mage
            if MagePowerBar and MagePowerBar.UpdatePower then
                hooksecurefunc(MagePowerBar, "UpdatePower", function()
                    if MageArcaneChargesFrame and MageArcaneChargesFrame.classResourceButtonPool then
                        for bar, _ in MageArcaneChargesFrame.classResourceButtonPool:EnumerateActive() do
                            bar.ArcaneBG:SetVertexColor(unpack(SUI:Color(0.15)))
                            bar.ArcaneBGShadow:SetVertexColor(unpack(SUI:Color(0.15)))
                        end
                    end

                    if ClassNameplateBarMageFrame and ClassNameplateBarMageFrame.classResourceButtonPool then
                        for bar, _ in ClassNameplateBarMageFrame.classResourceButtonPool:EnumerateActive() do
                            bar.ArcaneBG:SetVertexColor(unpack(SUI:Color(0.15)))
                            bar.ArcaneBGShadow:SetVertexColor(unpack(SUI:Color(0.15)))
                        end
                    end
                end)
            end
        elseif (playerClass == 'WARLOCK') then
            -- Warlock
            if WarlockPowerFrame and WarlockPowerFrame.UpdatePower then
                hooksecurefunc(WarlockPowerFrame, "UpdatePower", function()
                    if WarlockPowerFrame.classResourceButtonPool then
                        for bar, _ in WarlockPowerFrame.classResourceButtonPool:EnumerateActive() do
                            bar.Background:SetVertexColor(unpack(SUI:Color(0.15)))
                        end
                    end

                    if ClassNameplateBarWarlockFrame and ClassNameplateBarWarlockFrame.classResourceButtonPool then
                        for bar, _ in ClassNameplateBarWarlockFrame.classResourceButtonPool:EnumerateActive() do
                            bar.Background:SetVertexColor(unpack(SUI:Color(0.15)))
                        end
                    end
                end)
            end
        elseif (playerClass == 'DRUID') then
            -- Druid
            if DruidComboPointBarFrame and DruidComboPointBarFrame.UpdatePower then
                hooksecurefunc(DruidComboPointBarFrame, "UpdatePower", function()
                    if DruidComboPointBarFrame.classResourceButtonPool then
                        for bar, _ in DruidComboPointBarFrame.classResourceButtonPool:EnumerateActive() do
                            bar.BG_Active:SetVertexColor(unpack(SUI:Color(0.15)))
                            bar.BG_Inactive:SetVertexColor(unpack(SUI:Color(0.15)))
                            bar.BG_Shadow:SetVertexColor(unpack(SUI:Color(0.15)))
                        end
                    end

                    if ClassNameplateBarFeralDruidFrame and ClassNameplateBarFeralDruidFrame.classResourceButtonPool then
                        for bar, _ in ClassNameplateBarFeralDruidFrame.classResourceButtonPool:EnumerateActive() do
                            bar.BG_Active:SetVertexColor(unpack(SUI:Color(0.15)))
                            bar.BG_Inactive:SetVertexColor(unpack(SUI:Color(0.15)))
                            bar.BG_Shadow:SetVertexColor(unpack(SUI:Color(0.15)))
                        end
                    end
                end)
            end
        elseif (playerClass == 'MONK') then
            -- Monk
            if MonkHarmonyBarFrame and MonkHarmonyBarFrame.UpdatePower then
                hooksecurefunc(MonkHarmonyBarFrame, "UpdatePower", function()
                    if MonkHarmonyBarFrame.classResourceButtonPool then
                        for bar, _ in MonkHarmonyBarFrame.classResourceButtonPool:EnumerateActive() do
                            bar.Chi_BG:SetVertexColor(unpack(SUI:Color(0.15)))
                            bar.Chi_BG_Active:SetVertexColor(unpack(SUI:Color(0.15)))
                        end
                    end

                    if ClassNameplateBarWindwalkerMonkFrame and ClassNameplateBarWindwalkerMonkFrame.classResourceButtonPool then
                        for bar, _ in ClassNameplateBarWindwalkerMonkFrame.classResourceButtonPool:EnumerateActive() do
                            bar.Chi_BG:SetVertexColor(unpack(SUI:Color(0.15)))
                            bar.Chi_BG_Active:SetVertexColor(unpack(SUI:Color(0.15)))
                        end
                    end
                end)
            end
        elseif (playerClass == 'DEATHKNIGHT') then
            -- Death Knight
            if RuneFrame and RuneFrame.UpdateRunes then
                hooksecurefunc(RuneFrame, "UpdateRunes", function()
                    if RuneFrame and DeathKnightResourceOverlayFrame then
                        SUI:Skin({
                            RuneFrame.Rune1.BG_Active,
                            RuneFrame.Rune1.BG_Inactive,
                            RuneFrame.Rune1.BG_Shadow,
                            RuneFrame.Rune2.BG_Active,
                            RuneFrame.Rune2.BG_Inactive,
                            RuneFrame.Rune2.BG_Shadow,
                            RuneFrame.Rune3.BG_Active,
                            RuneFrame.Rune3.BG_Inactive,
                            RuneFrame.Rune3.BG_Shadow,
                            RuneFrame.Rune4.BG_Active,
                            RuneFrame.Rune4.BG_Inactive,
                            RuneFrame.Rune4.BG_Shadow,
                            RuneFrame.Rune5.BG_Active,
                            RuneFrame.Rune5.BG_Inactive,
                            RuneFrame.Rune5.BG_Shadow,
                            RuneFrame.Rune6.BG_Active,
                            RuneFrame.Rune6.BG_Inactive,
                            RuneFrame.Rune6.BG_Shadow,
                            DeathKnightResourceOverlayFrame.Rune1.BG_Active,
                            DeathKnightResourceOverlayFrame.Rune1.BG_Inactive,
                            DeathKnightResourceOverlayFrame.Rune1.BG_Shadow,
                            DeathKnightResourceOverlayFrame.Rune2.BG_Active,
                            DeathKnightResourceOverlayFrame.Rune2.BG_Inactive,
                            DeathKnightResourceOverlayFrame.Rune2.BG_Shadow,
                            DeathKnightResourceOverlayFrame.Rune3.BG_Active,
                            DeathKnightResourceOverlayFrame.Rune3.BG_Inactive,
                            DeathKnightResourceOverlayFrame.Rune3.BG_Shadow,
                            DeathKnightResourceOverlayFrame.Rune4.BG_Active,
                            DeathKnightResourceOverlayFrame.Rune4.BG_Inactive,
                            DeathKnightResourceOverlayFrame.Rune4.BG_Shadow,
                            DeathKnightResourceOverlayFrame.Rune5.BG_Active,
                            DeathKnightResourceOverlayFrame.Rune5.BG_Inactive,
                            DeathKnightResourceOverlayFrame.Rune5.BG_Shadow,
                            DeathKnightResourceOverlayFrame.Rune6.BG_Active,
                            DeathKnightResourceOverlayFrame.Rune6.BG_Inactive,
                            DeathKnightResourceOverlayFrame.Rune6.BG_Shadow
                        }, true, true)
                    end
                end)
            end
        elseif (playerClass == 'EVOKER') then
            -- Evoker
            if EssencePlayerFrame and EssencePlayerFrame.UpdatePower then
                hooksecurefunc(EssencePlayerFrame, "UpdatePower", function()
                    if EssencePlayerFrame.classResourceButtonPool then
                        for bar, _ in EssencePlayerFrame.classResourceButtonPool:EnumerateActive() do
                            bar.EssenceFillDone.CircBG:SetVertexColor(unpack(SUI:Color(0.15)))
                            bar.EssenceFillDone.CircBGActive:SetVertexColor(unpack(SUI:Color(0.15)))
                        end
                    end

                    if ClassNameplateBarDracthyrFrame and ClassNameplateBarDracthyrFrame.classResourceButtonPool then
                        for bar, _ in ClassNameplateBarDracthyrFrame.classResourceButtonPool:EnumerateActive() do
                            bar.EssenceFillDone.CircBG:SetVertexColor(unpack(SUI:Color(0.15)))
                            bar.EssenceFillDone.CircBGActive:SetVertexColor(unpack(SUI:Color(0.15)))
                        end
                    end
                end)
            end
        elseif (playerClass == 'PALADIN') then
            -- Paladin
            if PaladinPowerBar and PaladinPowerBar.UpdatePower then
                hooksecurefunc(PaladinPowerBar, "UpdatePower", function()
                    if PaladinPowerBarFrame and PaladinPowerBarFrame.Background then
                        PaladinPowerBarFrame.Background:SetVertexColor(unpack(SUI:Color(0.15)))
                    end
                    if PaladinPowerBarFrame and PaladinPowerBarFrame.ActiveTexture then
                        PaladinPowerBarFrame.ActiveTexture:Hide()
                    end
                    if ClassNameplateBarPaladinFrame and ClassNameplateBarPaladinFrame.Background then
                        ClassNameplateBarPaladinFrame.Background:SetVertexColor(unpack(SUI:Color(0.15)))
                    end
                    if ClassNameplateBarPaladinFrame and ClassNameplateBarPaladinFrame.ActiveTexture then
                        ClassNameplateBarPaladinFrame.ActiveTexture:Hide()
                    end
                end)
            end
        end
    end
end
