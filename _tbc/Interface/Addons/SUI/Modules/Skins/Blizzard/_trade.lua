local Module = SUI:NewModule("Skins.Trade");

function Module:OnEnable()
    if (SUI:Color()) then
        local function SafeSkin(frame)
            if frame then
                SUI:Skin(frame, true)
            end
        end

        SafeSkin(TradeFrame)
        SafeSkin(TradeFrame and TradeFrame.NineSlice)
        SafeSkin(TradeFrame and TradeFrame.RecipientOverlay)
        SafeSkin(TradeFrameInset and TradeFrameInset.NineSlice)
        SafeSkin(TradePlayerEnchantInset)
        SafeSkin(TradePlayerEnchantInset and TradePlayerEnchantInset.NineSlice)
        SafeSkin(TradePlayerItemsInset and TradePlayerItemsInset.NineSlice)
        SafeSkin(TradeRecipientItemsInset and TradeRecipientItemsInset.NineSlice)
        SafeSkin(TradeRecipientMoneyBg)
        SafeSkin(TradeRecipientMoneyInset and TradeRecipientMoneyInset.NineSlice)
        SafeSkin(TradeRecipientEnchantInset)
        SafeSkin(TradeRecipientEnchantInset and TradeRecipientEnchantInset.NineSlice)
    end
end
