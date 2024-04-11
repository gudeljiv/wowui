-- Waylaid Supplies Tooltip
-- Author: Shala - Wild Growth
-- Displays in tooltip if a specific Waylaid Shipment will grant you reputation or not and by how much.

local frame = CreateFrame("Frame")
frame:RegisterEvent("GET_ITEM_INFO_RECEIVED")

-- [itemName] = {filledRep, filledMoney, unfilledMoney, questXP, itemLevel, questLevel}
local reputationItems = {
--Phase 1
    ["Waylaid Supplies: Brilliant Smallfish"] = {300, 600, 100, 80, 10, 9, 6290, 20},
    ["Waylaid Supplies: Copper Bars"] = {300, 600, 100, 80, 10, 9, 2840, 20},
    ["Waylaid Supplies: Heavy Linen Bandages"] = {300, 600, 100, 80, 10, 9, 2581, 10},
    ["Waylaid Supplies: Herb Baked Eggs"] = {300, 600, 100, 80, 10, 9, 6888, 20},
    ["Waylaid Supplies: Light Leather"] = {300, 600, 100, 80, 10, 9, 2318, 14},
    ["Waylaid Supplies: Peacebloom"] = {300, 600, 100, 80, 10, 9, 2447, 20},
    ["Waylaid Supplies: Rough Stone"] = {300, 600, 100, 80, 10, 9, 2835, 10},
    ["Waylaid Supplies: Silverleaf"] = {300, 600, 100, 80, 10, 9, 765, 20},
    ["Waylaid Supplies: Spiced Wolf Meat"] = {300, 600, 100, 80, 10, 9, 2680, 20},
    ["Waylaid Supplies: Runed Copper Pants"] = {450, 1500, 100, 90, 10, 12, 3473, 3},
    ["Waylaid Supplies: Brown Linen Pants"] = {450, 1500, 100, 90, 10, 12, 4343, 6},
    ["Waylaid Supplies: Brown Linen Robes"] = {450, 1500, 100, 90, 10, 12, 6238, 4},
    ["Waylaid Supplies: Copper Shortswords"] = {450, 1500, 100, 90, 10, 12, 2847, 6},
    ["Waylaid Supplies: Embossed Leather Vests"] = {450, 1500, 100, 90, 10, 12, 2300, 3},
    ["Waylaid Supplies: Handstitched Leather Belts"] = {450, 1500, 100, 90, 10, 12, 4237, 5},
    ["Waylaid Supplies: Healing Potions"] = {450, 1500, 100, 90, 10, 12, 929, 10},
    ["Waylaid Supplies: Lesser Magic Wands"] = {450, 1500, 100, 90, 10, 12, 11287, 2},
    ["Waylaid Supplies: Minor Healing Potions"] = {450, 1500, 100, 90, 10, 12, 118, 20},
    ["Waylaid Supplies: Minor Wizard Oil"] = {450, 1500, 100, 90, 10, 12, 20744, 2},
    ["Waylaid Supplies: Rough Boomsticks"] = {450, 1500, 100, 90, 10, 12, 4362, 3},
    ["Waylaid Supplies: Rough Copper Bombs"] = {450, 1500, 100, 90, 10, 12, 4360, 12},
    ["Waylaid Supplies: Bronze Bars"] = {500, 1500, 500, 140, 25, 18, 2841, 12},
    ["Waylaid Supplies: Bruiseweed"] = {500, 1500, 500, 140, 25, 18, 2453, 20},
    ["Waylaid Supplies: Goblin Deviled Clams"] = {500, 1500, 500, 140, 25, 18, 5527, 8},
    ["Waylaid Supplies: Heavy Wool Bandages"] = {500, 1500, 500, 140, 25, 18, 3531, 15},
    ["Waylaid Supplies: Medium Leather"] = {500, 1500, 500, 140, 25, 18, 2319, 12},
    ["Waylaid Supplies: Silver Bars"] = {500, 1500, 500, 140, 25, 18, 2842, 6},
    ["Waylaid Supplies: Smoked Bear Meat"] = {500, 1500, 500, 140, 25, 18, 6890, 20},
    ["Waylaid Supplies: Smoked Sagefish"] = {500, 1500, 500, 140, 25, 18, 21072, 15},
    ["Waylaid Supplies: Swiftthistle"] = {500, 1500, 500, 140, 25, 18, 2452, 20},
    ["Waylaid Supplies: Dark Leather Cloaks"] = {650, 2000, 500, 180, 25, 22, 2316, 2},
    ["Waylaid Supplies: Gray Woolen Shirts"] = {650, 2000, 500, 180, 25, 22, 2587, 4},
    ["Waylaid Supplies: Lesser Mana Potions"] = {650, 2000, 500, 180, 25, 22, 3385, 20},
    ["Waylaid Supplies: Minor Mana Oil"] = {650, 2000, 500, 180, 25, 22, 20745, 2},
    ["Waylaid Supplies: Rough Bronze Boots"] = {650, 2000, 500, 180, 25, 22, 6350, 3},
    ["Waylaid Supplies: Small Bronze Bombs"] = {650, 2000, 500, 180, 25, 22, 4374, 12},
    ["Waylaid Supplies: Elixir of Firepower"] = {800, 3000, 500, 200, 25, 25, 6373, 15},
    ["Waylaid Supplies: Hillman's Shoulders"] = {800, 3000, 500, 200, 25, 25, 4251, 2},
    ["Waylaid Supplies: Ornate Spyglasses"] = {800, 3000, 500, 200, 25, 25, 5507, 2},
    ["Waylaid Supplies: Pearl-clasped Cloaks"] = {800, 3000, 500, 200, 25, 25, 5542, 3},
    ["Waylaid Supplies: Runed Silver Rods"] = {800, 3000, 500, 200, 25, 25, 6339, 1},
    ["Waylaid Supplies: Silver Skeleton Keys"] = {800, 3000, 500, 200, 25, 25, 15869, 14},
--Phase 2
    ["Waylaid Supplies: Fadeleaf"] = {700, 20000, 2000, 800, 30, 28, 3818, 16},
    ["Waylaid Supplies: Fire Oil"] = {700, 20000, 2000, 800, 30, 28, 6371, 7},
    ["Waylaid Supplies: Formal White Shirts"] = {700, 20000, 2000, 800, 30, 28, 4334, 3},
    ["Waylaid Supplies: Heavy Hide"] = {700, 20000, 2000, 800, 30, 28, 4235, 5},
    ["Waylaid Supplies: Heavy Silk Bandages"] = {700, 20000, 2000, 800, 35, 28, 6451, 10},
    ["Waylaid Supplies: Khadgar's Whisker"] = {700, 20000, 2000, 800, 35, 28, 3358, 10},
    ["Waylaid Supplies: Mithril Bars"] = {700, 20000, 2000, 800, 35, 28, 3860, 6},
    ["Waylaid Supplies: Purple Lotus"] = {700, 20000, 2000, 800, 35, 28, 8831, 8},
    ["Waylaid Supplies: Rockscale Cod"] = {700, 20000, 2000, 800, 30, 28, 4594, 40},
    ["Waylaid Supplies: Solid Grinding Stones"] = {700, 20000, 2000, 800, 30, 28, 7966, 5},
    ["Waylaid Supplies: Soothing Turtle Bisque"] = {700, 20000, 2000, 800, 35, 28, 3729, 10},
    ["Waylaid Supplies: Spider Sausages"] = {700, 55000, 2000, 800, 35, 28, 17222, 5},
    ["Waylaid Supplies: Thick Leather"] = {700, 20000, 2000, 800, 35, 28, 4304, 10},
    ["Waylaid Supplies: Wintersbite"] = {700, 20000, 2000, 800, 30, 28, 3819, 8},
    ["Waylaid Supplies: Barbaric Shoulders"] = {850, 55000, 2000, 1500, 35, 35, 5964, 4},
    ["Waylaid Supplies: Big Iron Bombs"] = {850, 55000, 2000, 1500, 30, 35, 4394, 8},
    ["Waylaid Supplies: Compact Harvest Reaper Kits"] = {850, 55000, 2000, 1500, 35, 35, 4391, 2},
    ["Waylaid Supplies: Crimson Silk Pantaloons"] = {850, 55000, 2000, 1500, 35, 35, 7062, 4},
    ["Waylaid Supplies: Elixirs of Agility"] = {850, 55000, 2000, 1500, 35, 35, 8949, 6},
    ["Waylaid Supplies: Frost Leather Cloaks"] = {850, 55000, 2000, 1500, 30, 35, 7377, 2},
    ["Waylaid Supplies: Gold Bars"] = {850, 55000, 2000, 1500, 35, 35, 3577, 4},
    ["Waylaid Supplies: Greater Healing Potions"] = {850, 55000, 2000, 1500, 35, 35, 1710, 16},
    ["Waylaid Supplies: Green Iron Bracers"] = {850, 55000, 2000, 1500, 30, 35, 3835, 5},
    ["Waylaid Supplies: Guardian Gloves"] = {850, 55000, 2000, 1500, 30, 35, 5966, 5},
    ["Waylaid Supplies: Heavy Mithril Gauntlets"] = {850, 55000, 2000, 1500, 35, 35, 7919, 3},
    ["Waylaid Supplies: Deadly Scopes"] = {1000, 120000, 2000, 1500, 30, 40, 10546, 2},
    ["Waylaid Supplies: Rich Purple Silk Shirts"] = {1000, 120000, 2000, 1500, 35, 40, 4335, 5},
    ["Waylaid Supplies: Elixirs of Greater Defense"] = {1000, 120000, 2000, 3450, 40, 40, 8951, 14},
    ["Waylaid Supplies: Massive Iron Axes"] = {1000, 120000, 2000, 3450, 40, 40, 3855, 2},
    ["Waylaid Supplies: Mithril Blunderbuss"] = {1000, 120000, 2000, 3450, 40, 40, 10508, 2},
    ["Waylaid Supplies: Turtle Scale Bracers"] = {1000, 120000, 2000, 3450, 40, 40, 8198, 2},
    ["Waylaid Supplies: White Bandit Masks"] = {1000, 120000, 2000, 3450, 40, 40, 10008, 3},
--Phase 3
    ["Waylaid Supplies: Dreamfoil"] = {950, 38500, 5000, 1700, 45, 42, 13463, 6},
    ["Waylaid Supplies: Heavy Mageweave Bandages"] = {950, 38500, 5000, 1700, 45, 42, 8545, 14},
    ["Waylaid Supplies: Nightfin Soup"] = {950, 38500, 5000, 1700, 45, 42, 13931, 8},
    ["Waylaid Supplies: Rugged Leather"] = {950, 38500, 5000, 1700, 45, 42, 8170, 14},
    ["Waylaid Supplies: Sungrass"] = {950, 38500, 5000, 1700, 45, 42, 8838, 15},
    ["Waylaid Supplies: Tender Wolf Steaks"] = {950, 38500, 5000, 1700, 45, 42, 18045, 12},
    ["Waylaid Supplies: Thick Hide"] = {950, 38500, 5000, 1700, 45, 42, 8169, 8},
    ["Waylaid Supplies: Thorium Bars"] = {950, 38500, 5000, 1700, 45, 42, 12359, 16},
    ["Waylaid Supplies: Truesilver Bars"] = {950, 38500, 5000, 1700, 45, 42, 6037, 12},
    ["Waylaid Supplies: Undermine Clam Chowder"] = {950, 38500, 5000, 1700, 45, 42, 16766, 16},
    ["Waylaid Supplies: Black Mageweave Headbands"] = {1300, 84500, 5000, 2850, 45, 45, 10024, 5},
    ["Waylaid Supplies: Enchanted Thorium Bars"] = {1300, 84500, 5000, 2850, 45, 45, 12655, 4},
    ["Waylaid Supplies: Hi-Explosive Bombs"] = {1300, 84500, 5000, 2850, 45, 45, 10562, 16},
    ["Waylaid Supplies: Major Healing Potions"] = {1300, 84500, 5000, 2850, 45, 45, 13446, 8},
    ["Waylaid Supplies: Mithril Coifs"] = {1300, 84500, 5000, 2850, 45, 45, 7931, 3},
    ["Waylaid Supplies: Rugged Armor Kits"] = {1300, 84500, 5000, 2850, 45, 45, 15564, 12},
    ["Waylaid Supplies: Superior Mana Potions"] = {1300, 84500, 5000, 2850, 45, 45, 13443, 6},
    ["Waylaid Supplies: Thorium Belts"] = {1300, 84500, 5000, 2850, 45, 45, 12406, 5},
    ["Waylaid Supplies: Thorium Grenades"] = {1300, 84500, 5000, 2850, 45, 45, 15993, 3},
    ["Waylaid Supplies: Tuxedo Shirts"] = {1300, 84500, 5000, 2850, 45, 45, 10034, 4},
    ["Waylaid Supplies: Wicked Leather Bracers"] = {1300, 84500, 5000, 2850, 45, 45, 15084, 6},
    ["Waylaid Supplies: Runecloth Belts"] = {1850, 154000, 5000, 4650, 45, 50, 13856, 6},
    ["Waylaid Supplies: Runic Leather Bracers"] = {1850, 154000, 5000, 4650, 45, 50, 15092, 5},
    ["Waylaid Supplies: Thorium Rifles"] = {1850, 154000, 5000, 4650, 45, 50, 15995, 2},
    ["Waylaid Supplies: Truesilver Gauntlets"] = {1850, 154000, 5000, 4650, 45, 50, 7938, 2},
}

-- Function to get market value for an item
local function GetMarketValue(itemLink)
    -- Extract itemID from itemLink
    local itemID = tonumber(string.match(itemLink, "item:(%d+)"))
    if not itemID then
        return "N/A"
    end

    -- Construct a valid TSM item string
    local tsmItemString = "i:" .. itemID

    -- Get the market value for the item using the TSM API
    local marketValue = TSM_API.GetCustomPriceValue("DBMarket", tsmItemString)
    if marketValue then
        marketValue = tonumber(marketValue)
		return marketValue or 0
    else
        return 0 --"N/A"
    end
end

-- Function to get minimum buyout for an item
local function GetMinBuyout(itemLink)
    -- Extract itemID from itemLink
    local itemID = tonumber(string.match(itemLink, "item:(%d+)"))
    if not itemID then
        return 0 --"N/A"
    end

    -- Construct a valid TSM item string
    local tsmItemString = "i:" .. itemID

    -- Get the minimum buyout for the item using the TSM API
    local minBuyout = TSM_API.GetCustomPriceValue("DBMinBuyout", tsmItemString)
    if minBuyout then
		minBuyout = tonumber(minBuyout)
        return minBuyout or 0
    else
        return 0 --"N/A"
    end
end

local function Add_Waylaid_Supplies_Tooltip(tooltip)
    local _, itemLink = tooltip:GetItem()
    if (itemLink ~= nil) then
        local itemName, _, _, itemLevel = GetItemInfo(itemLink)
        if itemName and string.sub(itemName, 1,  16) == "Waylaid Supplies" then
            local supplyFactionID = (UnitFactionGroup("player") == "Horde") and 2587 or 2586
            local _, _, standingID = GetFactionInfoByID(supplyFactionID)
            
            -- Updated threshold logic starts here
            local threshold
            if standingID < 5 then
                threshold = 9
            elseif standingID == 5 then
                threshold = 24
            elseif standingID < 7 then
                threshold = 29
            elseif standingID < 8 then
                threshold = 41
            end
            
            local reputationAmounts = reputationItems[itemName]
            if reputationAmounts then
                -- Apply a 10% reputation bonus for humans
                local isHuman = (UnitRace("player") == "Human")
                local reputationBonus = isHuman and 0.1 or 0
                local modifiedReputation1 = reputationAmounts[1] + (reputationAmounts[1] * reputationBonus)
                
                --Money Reward
                local copperReward = reputationAmounts[2]
                local copperReward2 = reputationAmounts[3]
                
                --Reputation allowance check and display            green                red
                local colorCode = (itemLevel >= threshold) and "\124cFF00FF00" or "\124cFFFF0000"
                local reputationStatus = (itemLevel < threshold) and "\124cFFFF0000No longer grants rep with " or colorCode .. "Will grant reputation with "
                
                --Experience, Quest Level and Item Level
                local questXP = reputationAmounts[4]
                local itemLevel = reputationAmounts[5]
                local questLevel = reputationAmounts[6]
                
                -- Checks the player's faction to display the Supply Crate faction
                local factionName = (UnitFactionGroup("player") == "Horde") and "Durotar Supply and Logistics" or "Azeroth Commerce Authority"
                
                --Tooltip text
                if itemLevel <= threshold then --Tooltip if the item doesn't give rep
                    local reputationText1 =	"REP: " .. modifiedReputation1 .. "                " .. "Base XP: " .. questXP
                    local reputationText2 =	"Filled: " .. GetMoneyString(copperReward)
					local reputationText3 =	("ILVl:  " .. itemLevel .. " " .. "                 " .. "Quest Level: " .. questLevel)
					local reputationText4 = "Vendor: " .. GetMoneyString(copperReward2)
					tooltip:AddDoubleLine(" ", " ")
                    tooltip:AddLine(reputationStatus .. factionName)
					tooltip:AddDoubleLine(reputationText1, reputationText2)
                    tooltip:AddDoubleLine(reputationText3, reputationText4)
                    --local copperRewardText = "Filled: " .. GetMoneyString(reputationAmounts[2]) 
                    --local copperRewardText2 = "Vendor: " .. GetMoneyString(reputationAmounts[3])
                    --tooltip:AddDoubleLine(copperRewardText,copperRewardText2)
                    --tooltip:AddDoubleLine("ILVl:  " .. itemLevel .. "          " .. "|Quest Level: " .. questLevel, "Base XP: " .. questXP)
                else --Tooltip if the item does give rep
                    --local reputationText1 = "Rep: " .. modifiedReputation1 .. "                   " .. "Filled: " .. GetMoneyString(copperReward)  
                    --local reputationText2 = "Vendor: " .. GetMoneyString(copperReward2)
					--local reputationText3 = ("Item Level: " .. itemLevel .. "            " .. "Quest Level: " .. questLevel, "Base XP: " .. questXP)
					--local reputationText4 = 
                    local reputationText1 =	"REP: " .. modifiedReputation1 .. "                " .. "Base XP: " .. questXP
                    local reputationText2 =	"Filled: " .. GetMoneyString(copperReward)
					local reputationText3 =	("ILVl:  " .. itemLevel .. " " .. "                 " .. "Quest Level: " .. questLevel)
					local reputationText4 = "Vendor: " .. GetMoneyString(copperReward2)
					tooltip:AddDoubleLine(" ", " ")
                    tooltip:AddLine(reputationStatus .. factionName)
                    tooltip:AddDoubleLine(reputationText1, reputationText2)
                    tooltip:AddDoubleLine(reputationText3, reputationText4)
                    return
                end
            end
        end
    end
end

-- Function to display tooltip information for associated item
local function DisplayAssociatedItemTooltip(tooltip, itemID, reputationItem)
    local itemLink = select(2, GetItemInfo(itemID))
    if itemLink then
        local marketValue = GetMarketValue(itemLink)
        local minBuyout = GetMinBuyout(itemLink)
        local itemName = GetItemInfo(itemLink)
        local filledItemNumber = reputationItem[8]
		local filledMarketValue = marketValue * filledItemNumber
		local filledMinBuyout = minBuyout * filledItemNumber

        tooltip:AddLine("\124cFF00FF00TSM prices for " .. itemName)
		tooltip:AddDoubleLine("\124cFFADD8E6Min Buyout: " .. GetMoneyString(minBuyout) .. " each.", "\124cFFADD8E6" .. GetMoneyString(filledMinBuyout) .. " filled.")
		tooltip:AddDoubleLine("\124cFFADD8E6Market Value: " .. GetMoneyString(marketValue) .. " each.", "\124cFFADD8E6" .. GetMoneyString(filledMarketValue) .. " filled.")
    end
end

-- Hook into tooltip events to capture item being moused over
local function OnTooltipSetItem(tooltip)
    local itemLink = select(2, tooltip:GetItem())
    if itemLink then
        local itemName = GetItemInfo(itemLink)
        local reputationItem = reputationItems[itemName]
        if reputationItem then
            local associatedItemID = reputationItem[7]  -- Get the item ID of the associated item
            DisplayAssociatedItemTooltip(tooltip, associatedItemID, reputationItem)
            tooltip:Show()  -- Show the tooltip after adding TSM lines
        end
    end
end

print("WST: Welcome to Waylaid Supplies Tooltip v1.5")
print("WST: Added: New Feature - TSM pricing integration")
print("WST: Coming Soon: Auctionator integration and localization")

-- Hook the function to tooltip events
GameTooltip:HookScript("OnTooltipSetItem", Add_Waylaid_Supplies_Tooltip)
ItemRefTooltip:HookScript("OnTooltipSetItem", Add_Waylaid_Supplies_Tooltip)
GameTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
ItemRefTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
