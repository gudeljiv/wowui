local _, Addon = ...
local Main = Addon.Main
local Core = Addon.Core
local UI = Addon.UI
local Functions = Addon.Functions
local ProfileManager = Addon.ProfileManager
local Events = Addon.Events1
local Colors = Addon.Colors

--------------------------------------------
-- VARS
--------------------------------------------

Main.CurrentLoadedProfile = nil
Main.IsVendorOpen = false
Main.TotalEarned = 0
Main.TotalItemsInSale = 0
Main.TotalTimerDone = 0
Main.TotalItemsSold = 0
Main.TotalRepairCosts = 0

--------------------------------------------
-- EVENTS
--------------------------------------------

function Events:MERCHANT_SHOW()
    Main.IsVendorOpen = true
    Main:PrepareSellButton()

    if (not ProfileManager:IsProfileLoaded()) then return end
    
    Main.CurrentLoadedProfile = SellyLocalDB.Profiles[SellyLocalDB.Settings.LoadedProfile]
    if (Main.CurrentLoadedProfile.OptionAutoSell) then
        C_Timer.After(0.2, function() Main:SellItems() end)
    end
end

function Events:MERCHANT_CLOSED()
    Main.IsVendorOpen = false
end

function Main:PrepareSellButton()
    UI:CreateVendorOptions()

    local SellButton = UI:GetFrame("SellButton")
    local IsProfileLoaded = ProfileManager:IsProfileLoaded()

    UI:SetEnabled(SellButton, (IsProfileLoaded and SellyLocalDB.Settings.IsAddonEnabled))
end

--------------------------------------------
-- REPAIR
--------------------------------------------

function Main:Repair()
    local RepairCost, CanRepair = GetRepairAllCost()
    if (not CanRepair or GetMoney() < RepairCost) then return end

    RepairAllItems()
    PlaySound(SOUNDKIT.ITEM_REPAIR)

    Main.TotalRepairCosts = RepairCost
end

--------------------------------------------
-- SELL
--------------------------------------------

function Main:SellItems()
    if (not SellyLocalDB.Settings.IsAddonEnabled) then return end
    if (not ProfileManager:IsProfileLoaded()) then return end

    UI:SetEnabled("SellButton", false)

    Main.TotalEarned = 0
    Main.TotalItemsInSale = 0
    Main.TotalTimerDone = 0
    Main.TotalItemsSold = 0
    Main.TotalRepairCosts = 0

    if (Main.CurrentLoadedProfile.OptionAutoRepair) then
        Main:Repair()
    end

    local SellTimer = 0

    for BagNumber = 0, NUM_BAG_SLOTS do
        for BagSlot = 1, C_Container.GetContainerNumSlots(BagNumber) do

            if (not Main.IsVendorOpen) then return end

            local ContainerInfo = C_Container.GetContainerItemInfo(BagNumber, BagSlot)
            if (ContainerInfo) then

                local ItemID = ContainerInfo.itemID
                if (ItemID) then

                    local ItemName, ItemLink, ItemQuality, ItemLevel, ItemMinLevel, ItemType, ItemSubType,
                    ItemStackCount, ItemEquipLoc, ItemTexture, ItemSellPrice, ItemClassID, ItemSubclassID, ItemBindType,
                    ItemExpansionID, ItemSetID, IsCraftingReagent = C_Item.GetItemInfo(ItemID)

                    if (ItemName and ItemQuality and ItemBindType and ItemSellPrice and ItemSellPrice > 0) then
                        if (Main:IsItemSellable(ItemName, ItemQuality, ItemBindType)) then

                            local SellPrice = ItemSellPrice
                            local DisplayName = Functions:Condition(ItemLink, ItemLink, ItemName)
                            local DisplayIcon = Functions:Condition(ItemTexture, ItemTexture, 134400)

                            Main.TotalItemsInSale = Main.TotalItemsInSale + 1
                            C_Timer.After(SellTimer, function() Main:SellItem(BagNumber, BagSlot, SellPrice, DisplayName, DisplayIcon) end)
                            SellTimer = SellTimer + 0.05

                        end
                    end
                end
            end
        end
    end

    if (Main.TotalItemsInSale == 0) then
        Main:CheckFinishSelling()
    end
end

function Main:IsItemSellable(ItemName, ItemQuality, ItemBindType)
    if (Main:IsItemOnWhitelist(ItemName)) then return false end

    -- Classic  : # White: Standard | # Green: Good     | # Blue: Superior
    -- Retail   : # White: Common   | # Green: Uncommon | # Blue: Rare

    local EnumQualityPoor = Enum.ItemQuality.Poor -- Gray
    local EnumQualityCommon = Functions:Condition(Enum.ItemQuality.Common, Enum.ItemQuality.Common, Enum.ItemQuality.Standard) -- White
    local EnumQualityUncommon = Functions:Condition(Enum.ItemQuality.Uncommon, Enum.ItemQuality.Uncommon, Enum.ItemQuality.Good) -- Green
    local EnumQualityRare = Functions:Condition(Enum.ItemQuality.Rare, Enum.ItemQuality.Rare, Enum.ItemQuality.Superior) -- Blue
    local EnumQualityEpic = Enum.ItemQuality.Epic -- Purple

    local IsBoE = ItemBindType == Enum.ItemBind.OnEquip

    if (ItemQuality == EnumQualityPoor) then
        return Main.CurrentLoadedProfile.SellGray
    end

    if (EnumQualityCommon and ItemQuality == EnumQualityCommon) then
        return Main.CurrentLoadedProfile.SellWhite
    end

    if (EnumQualityUncommon and ItemQuality == EnumQualityUncommon) then
        if (not Main.CurrentLoadedProfile.SellGreen) then return false end
        if (IsBoE and not Main.CurrentLoadedProfile.SellGreenBoE) then return false end
        return true
    end

    if (EnumQualityRare and ItemQuality == EnumQualityRare) then
        if (not Main.CurrentLoadedProfile.SellBlue) then return false end
        if (IsBoE and not Main.CurrentLoadedProfile.SellBlueBoE) then return false end
        return true
    end

    if (EnumQualityEpic and ItemQuality == EnumQualityEpic) then
        if (not Main.CurrentLoadedProfile.SellPurple) then return false end
        if (IsBoE and not Main.CurrentLoadedProfile.SellPurpleBoE) then return false end
        return true
    end

    return false
end

function Main:IsItemOnWhitelist(ItemName)
    ItemName = string.lower(ItemName)

    for Key, WhitelistItem in next, Main.CurrentLoadedProfile.WhitelistItems, nil do
        
        WhitelistItem = string.lower(WhitelistItem)

        -- Wildcard
        if (Functions:StringContains(WhitelistItem, "*")) then
            local Wildcard = Functions:Trim(Functions:StringReplace(WhitelistItem, "*"))
            if (Functions:StringContains(ItemName, Wildcard)) then
                return true
            end

        -- Default
        elseif (ItemName == WhitelistItem) then
            return true
        end

    end
end

function Main:SellItem(BagNumber, BagSlot, SellPrice, DisplayName, DisplayIcon)

    local function WatchSoldItem(Counter)

        -- Not sold

        if (Counter == 10) then

            Main.TotalTimerDone = Main.TotalTimerDone + 1
            Functions:PrintAddon("Couldn't sell "..Functions:PrintIcon(DisplayIcon).." "..DisplayName..": "..Functions:PrintGold(SellPrice), "Error")
            Main:CheckFinishSelling()

            return

        end

        -- Sold

        local ContainerInfo = C_Container.GetContainerItemInfo(BagNumber, BagSlot)
        if (not ContainerInfo) then

            Main.TotalEarned = Main.TotalEarned + SellPrice
            Main.TotalTimerDone = Main.TotalTimerDone + 1
            Main.TotalItemsSold = Main.TotalItemsSold + 1
            Functions:PrintAddon(Functions:PrintIcon(DisplayIcon).." "..DisplayName..": "..Functions:PrintGold(SellPrice))
            Main:CheckFinishSelling()

            return

        end

        C_Container.UseContainerItem(BagNumber, BagSlot)
        C_Timer.After(0.5, function() WatchSoldItem((Counter + 1)) end)
    end

    C_Container.UseContainerItem(BagNumber, BagSlot)
    C_Timer.After(1, function() WatchSoldItem(1) end)
end

function Main:CheckFinishSelling()
    if (Main.TotalTimerDone < Main.TotalItemsInSale) then return end

    local Result = {}

    if (Main.TotalRepairCosts > 0) then
        tinsert(Result, "Repair costs: "..Functions:PrintGold(Main.TotalRepairCosts))
    end

    if (Main.TotalEarned > 0) then

        local Plural = Functions:Condition(Main.TotalItemsSold > 1, "s", "")

        if (Main.TotalRepairCosts > 0) then
            tinsert(Result, "Earned: "..Functions:PrintGold(Main.TotalEarned).." ("..Main.TotalItemsSold.." item"..Plural.." sold)")

            local TotalEarned = Main.TotalEarned - Main.TotalRepairCosts
            TotalEarned = Functions:Condition(TotalEarned < 0, 0, TotalEarned)
            
            tinsert(Result, "Total earned: "..Functions:PrintGold(TotalEarned).." (less repair costs)")
        else
            tinsert(Result, "Total earned: "..Functions:PrintGold(Main.TotalEarned).." ("..Main.TotalItemsSold.." item"..Plural.." sold)")
        end

    end

    if (Functions:CountTable(Result) > 0) then

        Functions:PrintAddon("——————————————————————————")
        for Key, Line in next, Result, nil do Functions:PrintAddon(Line) end
        Functions:PrintAddon("——————————————————————————")

        if (Main.CurrentLoadedProfile) then
            Main.CurrentLoadedProfile.TotalEarnedCopper = Main.CurrentLoadedProfile.TotalEarnedCopper + Main.TotalEarned
            ProfileManager:UpdateProfileList()
        end

    end

    UI:SetEnabled("SellButton", true)
end
