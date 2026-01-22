local Module = SUI:NewModule("CastBars.Player");

function Module:OnEnable()
    local db = SUI.db.profile.castbars

    if (db.style == 'Custom') then
        if PlayerCastingBarFrame and PlayerCastingBarFrame.HookScript then
            PlayerCastingBarFrame:HookScript("OnEvent", function()
                local castBar = PlayerCastingBarFrame
                if not castBar then
                    return
                end

                if castBar.StandardGlow then
                    castBar.StandardGlow:Hide()
                end
                if castBar.TextBorder then
                    castBar.TextBorder:Hide()
                    castBar.TextBorder:ClearAllPoints()
                    castBar.TextBorder:SetAlpha(0)
                end
                if castBar.Border then
                    castBar.Border:ClearAllPoints()
                    castBar.Border:SetAlpha(0)
                end
                if castBar.Text then
                    castBar.Text:ClearAllPoints()
                    castBar.Text:SetPoint("TOP", castBar, "TOP", 0, -1)
                    castBar.Text:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
                end
                castBar:SetSize(209, 18)

                if SUI:Color() and castBar.Background then
                    castBar.Background:SetVertexColor(unpack(SUI:Color(0.15)))
                end

                if db.icon and castBar.Icon then
                    castBar.Icon:Show()
                    castBar.Icon:SetSize(20, 20)
                end
            end)
        end
    end
end
