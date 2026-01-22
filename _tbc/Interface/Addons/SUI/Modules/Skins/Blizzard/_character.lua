local Module = SUI:NewModule("Skins.Character");

function Module:OnEnable()
    if (SUI:Color()) then
        local function SafeSkin(frame)
            if frame then
                SUI:Skin(frame, true)
            end
        end

        SafeSkin(CharacterFrame)
        SafeSkin(CharacterFrame and CharacterFrame.NineSlice)
        SafeSkin(CharacterFrameInset)
        SafeSkin(CharacterFrameInset and CharacterFrameInset.NineSlice)
        SafeSkin(CharacterFrameInsetRight)
        SafeSkin(CharacterFrameInsetRight and CharacterFrameInsetRight.NineSlice)
        SafeSkin(TokenFramePopup)
        SafeSkin(TokenFramePopup and TokenFramePopup.Border)
        SafeSkin(CharacterStatsPane)
        SafeSkin(ReputationFrame and ReputationFrame.ReputationDetailFrame)
        SafeSkin(ReputationFrame and ReputationFrame.ReputationDetailFrame and ReputationFrame.ReputationDetailFrame.Border)
        SafeSkin(CurrencyTransferLog)
        SafeSkin(CurrencyTransferLog and CurrencyTransferLog.TitleContainer)
        SafeSkin(CurrencyTransferLog and CurrencyTransferLog.NineSlice)
        SafeSkin(CurrencyTransferLogInset and CurrencyTransferLogInset.NineSlice)
        if CharacterMainHandSlot and CharacterSecondaryHandSlot then
            SUI:Skin({
                CharacterFeetSlotFrame,
                CharacterHandsSlotFrame,
                CharacterWaistSlotFrame,
                CharacterLegsSlotFrame,
                CharacterFinger0SlotFrame,
                CharacterFinger1SlotFrame,
                CharacterTrinket0SlotFrame,
                CharacterTrinket1SlotFrame,
                CharacterWristSlotFrame,
                CharacterTabardSlotFrame,
                CharacterShirtSlotFrame,
                CharacterChestSlotFrame,
                CharacterBackSlotFrame,
                CharacterShoulderSlotFrame,
                CharacterNeckSlotFrame,
                CharacterHeadSlotFrame,
                CharacterMainHandSlotFrame,
                CharacterSecondaryHandSlotFrame,
                _G.select(CharacterMainHandSlot:GetNumRegions(), CharacterMainHandSlot:GetRegions()),
                _G.select(CharacterSecondaryHandSlot:GetNumRegions(), CharacterSecondaryHandSlot:GetRegions()),
                PaperDollInnerBorderLeft,
                PaperDollInnerBorderRight,
                PaperDollInnerBorderTop,
                PaperDollInnerBorderTopLeft,
                PaperDollInnerBorderTopRight,
                PaperDollInnerBorderBottom,
                PaperDollInnerBorderBottomLeft,
                PaperDollInnerBorderBottomRight,
                PaperDollInnerBorderBottom2
            }, true, true)
        end

        -- Tabs
        SafeSkin(CharacterFrameTab1)
        SafeSkin(CharacterFrameTab2)
        SafeSkin(CharacterFrameTab3)

        local f = CreateFrame("Frame")
        f:RegisterEvent("ADDON_LOADED")
        f:SetScript("OnEvent", function(self, event, name)
            if name == "Blizzard_ItemSocketingUI" then
                SafeSkin(ItemSocketingFrame)
                SafeSkin(ItemSocketingFrame and ItemSocketingFrame.NineSlice)
            end
        end)
    end
end
