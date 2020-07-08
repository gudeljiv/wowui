local function BuyAmmo()
    local index, TypeOfAmmo, BowEquipped, GunEquipped
    local _, class, _ = UnitClass("player");
    local numItems = GetMerchantNumItems()

    if class ~= ("HUNTER" or "WARRIOR") then
        return
    end
    BowEquipped = IsEquippedItemType("Bows") or IsEquippedItemType("Crossbows")
    GunEquipped = IsEquippedItemType("Guns")

    if BowEquipped then TypeOfAmmo = "Arrow" end
    if GunEquipped then TypeOfAmmo = "Bullet" end

    for item = 1,numItems do
        local name, texture, price, quantity, numAvailable, isUsable, extendedCost = GetMerchantItemInfo(item)

        if not name then
            C_Timer.After(0.1,BuyAmmo)
            return
        end

        local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemIcon, itemSellPrice, itemClassID, itemSubClassID, bindType, expacID, itemSetID, isCraftingReagent = GetItemInfo(GetMerchantItemLink(item))

        if itemSubType == TypeOfAmmo and isUsable then
            index = item
        end
    end

    if index then
        local maxammo = 200
        if class == "HUNTER" then maxammo = GetContainerNumSlots(1) * 200 end
        local ammoCount = GetInventoryItemCount("player", GetInventorySlotInfo("AmmoSlot"));
        local needtobuy = maxammo - ammoCount
        if needtobuy > 0 then
            local remainder = needtobuy % 200
            local buys = (needtobuy - remainder) / 200
            for _ = 1,buys do BuyMerchantItem(index,200) end
            if remainder > 0 then BuyMerchantItem(index,remainder) end
        end
    end

end

local f = CreateFrame("Frame")
f:RegisterEvent("MERCHANT_SHOW")
f:SetScript("OnEvent", BuyAmmo)
