local Module = SUI:NewModule("Skins.Merchant");

function Module:OnEnable()
    if (SUI:Color()) then
        local function SafeSkin(frame)
            if frame then
                SUI:Skin(frame, true)
            end
        end

        SafeSkin(MerchantFrame)
        SafeSkin(MerchantFrame and MerchantFrame.NineSlice)
        SafeSkin(MerchantFrameInset)
        SafeSkin(MerchantFrameInset and MerchantFrameInset.NineSlice)
        SafeSkin(StackSplitFrame)
        SafeSkin(MerchantMoneyBg)
        SafeSkin(MerchantMoneyInset)
        SafeSkin(MerchantMoneyInset and MerchantMoneyInset.NineSlice)

        if MerchantBuyBackItemSlotTexture then
            SUI:Skin({ MerchantBuyBackItemSlotTexture }, true, true)
        end

        -- Merchant Buttons
        local function SetButtonVertexColor(button)
            if not (button and button.GetRegions) then
                return
            end
            local region = select(1, button:GetRegions())
            if region and region.SetVertexColor then
                region:SetVertexColor(.15, .15, .15)
            end
        end

        SetButtonVertexColor(MerchantRepairItemButton)
        SetButtonVertexColor(MerchantRepairAllButton)
        SetButtonVertexColor(MerchantGuildBankRepairButton)
        SetButtonVertexColor(MerchantSellAllJunkButton)

        -- Tabs
        SafeSkin(MerchantFrameTab1)
        SafeSkin(MerchantFrameTab2)
    end
end
