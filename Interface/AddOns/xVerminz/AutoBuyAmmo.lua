local function BuyAmmo()
    local _, class, _ = UnitClass("player");
    local numItems = GetMerchantNumItems()
    local index

    if(class ~= "HUNTER") then
        return
    end

    for item = 1,numItems do
        local name, texture, price, quantity, numAvailable, isUsable, extendedCost = GetMerchantItemInfo(item)
        if not name then
            C_Timer.After(0.1,BuyAmmo)
            return
        elseif name.match(name, "Arrow") and isUsable then
            index = item
        end
    end

    if(index) then
        local maxammo = GetContainerNumSlots(1) * 200
        local ammoCount = GetInventoryItemCount("player", GetInventorySlotInfo("AmmoSlot"));
        local needtobuy = maxammo - ammoCount
        if(needtobuy > 0) then
            local remainder = needtobuy%200
            local buys = (needtobuy - remainder) / 200
            for i=1,buys do
                BuyMerchantItem(index,200);
            end
            if(remainder > 0) then
                BuyMerchantItem(index,remainder)
            end
        end
    end

end

local f = CreateFrame("Frame")
f:RegisterEvent("MERCHANT_SHOW");
f:SetScript("OnEvent", BuyAmmo);
