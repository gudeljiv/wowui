-- Waylaid Supplies Tooltip
-- Author: Shala - Wild Growth
-- Displays in tooltip if a specific Waylaid Shipment will grant you reputation or not and by how much.

local frame = CreateFrame("Frame")
frame:RegisterEvent("GET_ITEM_INFO_RECEIVED")

-- [itemID] = {filledRep, filledMoney, unfilledMoney, questXP, itemLevel, questLevel, fillItem, fillAmount, repThreshold}
local waylaidCrates = {
--Phase 1
    [211331] = {300, 600,  100, 80,  10, 9,  6290, 	20, "Friendly"},  --Brilliant Smallfish
    [210771] = {300, 600,  100, 80,  10, 9,  2840, 	20, "Friendly"},  --Copper Bars
    [211332] = {300, 600,  100, 80,  10, 9,  2581, 	10, "Friendly"},  --Heavy Linen Bandages
    [211329] = {300, 600,  100, 80,  10, 9,  6888, 	20, "Friendly"},  --Herb Baked Eggs
    [211315] = {300, 600,  100, 80,  10, 9,  2318, 	14, "Friendly"},  --Light Leather
    [211316] = {300, 600,  100, 80,  10, 9,  2447, 	20, "Friendly"},  --Peacebloom
    [211933] = {300, 600,  100, 80,  10, 9,  2835, 	10, "Friendly"},  --Rough Stone
    [211317] = {300, 600,  100, 80,  10, 9,  765,  	20, "Friendly"},  --Silverleaf
    [211330] = {300, 600,  100, 80,  10, 9,  2680, 	20, "Friendly"},  --Spiced Wolf Meat
    [211320] = {450, 1500, 100, 90,  10, 12, 3473,  3,  "Friendly"},  --Runed Copper Pants
    [211327] = {450, 1500, 100, 90,  10, 12, 4343,  6,  "Friendly"},  --Brown Linen Pants
    [211328] = {450, 1500, 100, 90,  10, 12, 6238, 	4,  "Friendly"},  --Brown Linen Robes
    [211319] = {450, 1500, 100, 90,  10, 12, 2847, 	6,  "Friendly"},  --Copper Shortswords
    [211326] = {450, 1500, 100, 90,  10, 12, 2300, 	3,  "Friendly"},  --Embossed Leather Vests
    [211325] = {450, 1500, 100, 90,  10, 12, 4237, 	5,  "Friendly"},  --Handstitched Leather Belts
    [211934] = {450, 1500, 100, 90,  10, 12, 929, 	10, "Friendly"},  --Healing Potions
    [211321] = {450, 1500, 100, 90,  10, 12, 11287, 2,  "Friendly"},  --Lesser Magic Wands
    [211318] = {450, 1500, 100, 90,  10, 12, 118, 	20, "Friendly"},  --Minor Healing Potions
    [211322] = {450, 1500, 100, 90,  10, 12, 20744,	2,  "Friendly"},  --Minor Wizard Oil
    [211324] = {450, 1500, 100, 90,  10, 12, 4362, 	3,  "Friendly"},  --Rough Boomsticks
    [211323] = {450, 1500, 100, 90,  10, 12, 4360, 	12, "Friendly"},  --Rough Copper Bombs
    [211819] = {500, 1500, 500, 140, 25, 18, 2841, 	12, "Honored" },  --Bronze Bars
    [211822] = {500, 1500, 500, 140, 25, 18, 2453, 	20, "Honored" },  --Bruiseweed
    [211837] = {500, 1500, 500, 140, 25, 18, 5527,   8, "Honored" },  --Goblin Deviled Clams
    [211838] = {500, 1500, 500, 140, 25, 18, 3531,  15, "Honored" },  --Heavy Wool Bandages
    [211821] = {500, 1500, 500, 140, 25, 18, 2319,  12, "Honored" },  --Medium Leather
    [211820] = {500, 1500, 500, 140, 25, 18, 2842,   6, "Honored" },  --Silver Bars
    [211836] = {500, 1500, 500, 140, 25, 18, 6890,  20, "Honored" },  --Smoked Bear Meat
    [211835] = {500, 1500, 500, 140, 25, 18, 21072, 15, "Honored" },  --Smoked Sagefish
    [211823] = {500, 1500, 500, 140, 25, 18, 2452, 	20, "Honored" },  --Swiftthistle
    [211831] = {650, 2000, 500, 180, 25, 22, 2316, 	2,  "Honored" },  --Dark Leather Cloaks
    [211833] = {650, 2000, 500, 180, 25, 22, 2587, 	4,  "Honored" },  --Gray Woolen Shirts
    [211824] = {650, 2000, 500, 180, 25, 22, 3385, 	20, "Honored" },  --Lesser Mana Potions
    [211828] = {650, 2000, 500, 180, 25, 22, 20745, 2,  "Honored" },  --Minor Mana Oil
    [211825] = {650, 2000, 500, 180, 25, 22, 6350, 	3,  "Honored" },  --Rough Bronze Boots
    [211829] = {650, 2000, 500, 180, 25, 22, 4374, 	12, "Honored" },  --Small Bronze Bombs
    [211935] = {800, 3000, 500, 200, 25, 25, 6373, 	15, "Honored" },  --Elixir of Firepower
    [211832] = {800, 3000, 500, 200, 25, 25, 4251, 	2,  "Honored" },  --Hillman's Shoulders
    [211830] = {800, 3000, 500, 200, 25, 25, 5507, 	2,  "Honored" },  --Ornate Spyglasses
    [211834] = {800, 3000, 500, 200, 25, 25, 5542, 	3,  "Honored" },  --Pearl-clasped Cloaks
    [211827] = {800, 3000, 500, 200, 25, 25, 6339, 	1,  "Honored" },  --Runed Silver Rods
    [211826] = {800, 3000, 500, 200, 25, 25, 15869, 14, "Honored" },  --Silver Skeleton Keys
--Phase 2    
	[215389] = {700,  20000,  2000, 800,  30, 28, 3818,  16, "Revered" },  --Fadeleaf
    [215421] = {700,  20000,  2000, 800,  30, 28, 6371,  7,  "Revered" },  --Fire Oil
    [215413] = {700,  20000,  2000, 800,  30, 28, 4334,  3,  "Revered" },  --Formal White Shirts
    [215387] = {700,  20000,  2000, 800,  30, 28, 4235,  5,  "Revered" },  --Heavy Hide
    [215419] = {700,  20000,  2000, 800,  35, 28, 6451,  10, "Revered" },  --Heavy Silk Bandages
    [215390] = {700,  20000,  2000, 800,  35, 28, 3358,  10, "Revered" },  --Khadgar's Whisker
    [215386] = {700,  20000,  2000, 800,  35, 28, 3860,  6,  "Revered" },  --Mithril Bars
    [215392] = {700,  20000,  2000, 800,  35, 28, 8831,  8,  "Revered" },  --Purple Lotus
    [215420] = {700,  20000,  2000, 800,  30, 28, 4594,  40, "Revered" },  --Rockscale Cod
    [215400] = {700,  20000,  2000, 800,  30, 28, 7966,  5,  "Revered" },  --Solid Grinding Stones
    [215417] = {700,  20000,  2000, 800,  35, 28, 3729,  10, "Revered" },  --Soothing Turtle Bisque
    [215418] = {700,  55000,  2000, 800,  35, 28, 17222, 5,  "Revered" },  --Spider Sausages
    [215388] = {700,  20000,  2000, 800,  35, 28, 4304,  10, "Revered" },  --Thick Leather
    [215391] = {700,  20000,  2000, 800,  30, 28, 3819,  8,  "Revered" },  --Wintersbite
    [215407] = {850,  55000,  2000, 1500, 35, 35, 5964,  4,  "Revered" },  --Barbaric Shoulders
    [215402] = {850,  55000,  2000, 1500, 30, 35, 4394,  8,  "Revered" },  --Big Iron Bombs
    [215401] = {850,  55000,  2000, 1500, 35, 35, 4391,  2,  "Revered" },  --Compact Harvest Reaper Kits
    [215414] = {850,  55000,  2000, 1500, 35, 35, 7062,  4,  "Revered" },  --Crimson Silk Pantaloons
    [215395] = {850,  55000,  2000, 1500, 35, 35, 8949,  6,  "Revered" },  --Elixirs of Agility
    [215411] = {850,  55000,  2000, 1500, 30, 35, 7377,  2,  "Revered" },  --Frost Leather Cloaks
    [215385] = {850,  55000,  2000, 1500, 35, 35, 3577,  4,  "Revered" },  --Gold Bars
    [215393] = {850,  55000,  2000, 1500, 35, 35, 1710,  16, "Revered" },  --Greater Healing Potions
    [215398] = {850,  55000,  2000, 1500, 30, 35, 3835,  5,  "Revered" },  --Green Iron Bracers
    [215408] = {850,  55000,  2000, 1500, 30, 35, 5966,  5,  "Revered" },  --Guardian Gloves
    [215399] = {850,  55000,  2000, 1500, 35, 35, 7919,  3,  "Revered" },  --Heavy Mithril Gauntlets
    [215403] = {1000, 120000, 2000, 1500, 30, 40, 10546, 2,  "Revered" },  --Deadly Scopes
    [215415] = {1000, 120000, 2000, 1500, 35, 40, 4335,  5,  "Revered" },  --Rich Purple Silk Shirts
    [215396] = {1000, 120000, 2000, 3450, 40, 40, 8951,  14, "Revered" },  --Elixirs of Greater Defense
    [215397] = {1000, 120000, 2000, 3450, 40, 40, 3855,  2,  "Revered" },  --Massive Iron Axes
    [215404] = {1000, 120000, 2000, 3450, 40, 40, 10508, 2,  "Revered" },  --Mithril Blunderbuss
    [215409] = {1000, 120000, 2000, 3450, 40, 40, 8198,  2,  "Revered" },  --Turtle Scale Bracers
    [215416] = {1000, 120000, 2000, 3450, 40, 40, 10008, 3,  "Revered" },  --White Bandit Masks
--Phase 3
    [220923] = {950,  38500,  5000, 1700, 45, 42, 13463, 6,  "Exalted" },  --Dreamfoil
    [220921] = {950,  38500,  5000, 1700, 45, 42, 8545,  14, "Exalted" },  --Heavy Mageweave Bandages
    [220919] = {950,  38500,  5000, 1700, 45, 42, 13931, 8,  "Exalted" },  --Nightfin Soup
    [220926] = {950,  38500,  5000, 1700, 45, 42, 8170,  14, "Exalted" },  --Rugged Leather
    [220922] = {950,  38500,  5000, 1700, 45, 42, 8838,  15, "Exalted" },  --Sungrass
    [220920] = {950,  38500,  5000, 1700, 45, 42, 18045, 12, "Exalted" },  --Tender Wolf Steaks
    [220927] = {950,  38500,  5000, 1700, 45, 42, 8169,  8,  "Exalted" },  --Thick Hide
    [220925] = {950,  38500,  5000, 1700, 45, 42, 12359, 16, "Exalted" },  --Thorium Bars
    [220924] = {950,  38500,  5000, 1700, 45, 42, 6037,  12, "Exalted" },  --Truesilver Bars
    [220918] = {950,  38500,  5000, 1700, 45, 42, 16766, 16, "Exalted" },  --Undermine Clam Chowder
    [220940] = {1300, 84500,  5000, 2850, 45, 45, 10024, 5,  "Exalted" },  --Black Mageweave Headbands
    [220928] = {1300, 84500,  5000, 2850, 45, 45, 12655, 4,  "Exalted" },  --Enchanted Thorium Bars
    [220931] = {1300, 84500,  5000, 2850, 45, 45, 10562, 16, "Exalted" },  --Hi-Explosive Bombs
    [220930] = {1300, 84500,  5000, 2850, 45, 45, 13446, 8,  "Exalted" },  --Major Healing Potions
    [220934] = {1300, 84500,  5000, 2850, 45, 45, 7931,  3,  "Exalted" },  --Mithril Coifs
    [220937] = {1300, 84500,  5000, 2850, 45, 45, 15564, 12, "Exalted" },  --Rugged Armor Kits
    [220929] = {1300, 84500,  5000, 2850, 45, 45, 13443, 6,  "Exalted" },  --Superior Mana Potions
    [220935] = {1300, 84500,  5000, 2850, 45, 45, 12406, 5,  "Exalted" },  --Thorium Belts
    [220932] = {1300, 84500,  5000, 2850, 45, 45, 15993, 3,  "Exalted" },  --Thorium Grenades
    [220942] = {1300, 84500,  5000, 2850, 45, 45, 10034, 4,  "Exalted" },  --Tuxedo Shirts
    [220938] = {1300, 84500,  5000, 2850, 45, 45, 15084, 6,  "Exalted" },  --Wicked Leather Bracers
    [220941] = {1850, 154000, 5000, 4650, 45, 50, 13856, 6,  "Exalted" },  --Runecloth Belts
    [220939] = {1850, 154000, 5000, 4650, 45, 50, 15092, 5,  "Exalted" },  --Runic Leather Bracers
    [220933] = {1850, 154000, 5000, 4650, 45, 50, 15995, 2,  "Exalted" },  --Thorium Rifles
    [220936] = {1850, 154000, 5000, 4650, 45, 50, 7938,  2,  "Exalted" },  --Truesilver Gauntlets
}

local function Add_Waylaid_Supplies_Tooltip(tooltip, itemID)
    local crateData = waylaidCrates[itemID]
	if crateData then
		local filledRep, filledRep, filledMoney, unfilledMoney, questXP, itemLevel, questLevel = unpack(crateData)
            
			
            -- Updated threshold logic starts here
            local supplyFactionID = (UnitFactionGroup("player") == "Horde") and 2587 or 2586
            local _, _, standingID = GetFactionInfoByID(supplyFactionID)
			local threshold
            if standingID < 5 then
                threshold = 9
            elseif standingID == 5 then
                threshold = 24
            elseif standingID < 7 then
                threshold = 29
			elseif standingID < 8 then
                threshold = 41
            elseif standingID == 8 then
                threshold = 999
            end

            local reputationAmounts = waylaidCrates[itemID]
            if reputationAmounts then
                -- Apply a 10% reputation bonus for humans
                local isHuman = (UnitRace("player") == "Human")
                local reputationBonus = isHuman and 0.1 or 0
                local modifiedReputation1 = reputationAmounts[1] + (reputationAmounts[1] * reputationBonus)
                
                --Money Reward, Experience, Quest Level and Item Level
                local copperReward = reputationAmounts[2]
                local copperReward2 = reputationAmounts[3]
                local questXP = reputationAmounts[4]
                local itemLevel = reputationAmounts[5]
                local questLevel = reputationAmounts[6]
				local repThreshold = reputationAmounts[9]

                --Reputation allowance check and display            green                red
                local colorCode = (itemLevel >= threshold) and "\124cFF00FF00" or "\124cFFFF0000"
                local reputationStatus = (itemLevel < threshold) and "\124cFFFF0000No longer grants rep with " or colorCode .. "Will grant reputation with "

                -- Checks the player's faction to display the Supply Crate faction
                local factionName = (UnitFactionGroup("player") == "Horde") and "Durotar Supply and Logistics" or "Azeroth Commerce Authority"
                
				-- Reputation line insertion
				local playerRep = GetText("FACTION_STANDING_LABEL" .. standingID, true)
				local repLine = "Current standing: " .. "|cFF00FF00" .. playerRep .. "|r" 
				
                --Tooltip text
                if itemLevel <= threshold then --Tooltip if the item doesn't give rep
                    local reputationText1 =	"REP: " .. modifiedReputation1 .. "                " .. "Base XP: " .. questXP
                    local reputationText2 =	"Filled: " .. GetMoneyString(copperReward)
					local reputationText3 =	("ILVl:  " .. itemLevel .. " " .. "                 " .. "Quest Level: " .. questLevel)
					local reputationText4 = "Vendor: " .. GetMoneyString(copperReward2)
					tooltip:AddDoubleLine(" ", " ")
                    tooltip:AddLine(reputationStatus .. factionName)
					tooltip:AddDoubleLine("Reputation cut off: " .. "|cFF00FF00" .. repThreshold .. "|r", repLine)
					tooltip:AddDoubleLine(reputationText1, reputationText2)
                    tooltip:AddDoubleLine(reputationText3, reputationText4)
                else --Tooltip if the item does give rep
                    local reputationText1 =	"REP: " .. modifiedReputation1 .. "                " .. "Base XP: " .. questXP
                    local reputationText2 =	"Filled: " .. GetMoneyString(copperReward)
					local reputationText3 =	("ILVl:  " .. itemLevel .. " " .. "                 " .. "Quest Level: " .. questLevel)
					local reputationText4 = "Vendor: " .. GetMoneyString(copperReward2)
					tooltip:AddDoubleLine(" ", " ")
                    tooltip:AddLine(reputationStatus .. factionName)
					tooltip:AddDoubleLine("Reputation cut off: " .. "|cFFFF0000" .. repThreshold .. "|r", repLine)
                    tooltip:AddDoubleLine(reputationText1, reputationText2)
                    tooltip:AddDoubleLine(reputationText3, reputationText4)
                    return
                end
            end
    end
end

local function GetAuctionatorMinBuyout(itemID)
    if not IsAddOnLoaded("Auctionator") then
        print("Auctionator addon is not loaded.")
        return 0  -- Auctionator addon is not loaded, return 0 or handle it accordingly
    end

    local callerID = "YourAddonName" -- Replace "YourAddonName" with the name of your addon

    -- Retrieve the min buyout price using the new API function
    local minBuyout = Auctionator.API.v1.GetAuctionPriceByItemID(callerID, itemID)
    if not minBuyout then
        --print("Min buyout not found for itemID:", itemID)
        return 0  -- Min buyout not found, return 0 or handle it accordingly
    end

    --print("Min buyout:", minBuyout)
    return minBuyout
end

-- Function to get market value for an item
local function GetMarketValue(itemLink)
    -- Check if TSM addon is loaded
    if TSM_API then
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
    else
        return 0 -- TSM addon not loaded, return 0 or handle it accordingly
    end
end

-- Function to get minimum buyout for an item
local function GetMinBuyout(itemLink)
    -- Check if TSM addon is loaded
    if TSM_API then
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
    else
        return 0 -- TSM addon not loaded, return 0 or handle it accordingly
    end
end

-- -- This function only works for the professions and recipes known to the character. It's a vanilla api thing, can't be easily changed/implemented.
-- -- Function to get crafting cost for an item
-- local function GetCraftingCost(itemLink)
    -- -- Check if TSM addon is loaded
    -- if TSM_API then
        -- -- Extract itemID from itemLink
        -- local itemID = tonumber(string.match(itemLink, "item:(%d+)"))
        -- if not itemID then
            -- return 0 --"N/A"
        -- end

        -- -- Construct a valid TSM item string
        -- local tsmItemString = "i:" .. itemID

        -- -- Get the crafting cost for the item using the TSM API
        -- local craftingCost = TSM_API.GetCustomPriceValue("Crafting", tsmItemString)
        -- if craftingCost then
            -- craftingCost = tonumber(craftingCost)
            -- return craftingCost or 0
        -- else
            -- return 0 --"N/A"
        -- end
    -- else
        -- return 0 -- TSM addon not loaded, return 0 or handle it accordingly
    -- end
-- end

-- Updated function to display tooltip information for associated item
local function DisplayAssociatedItemTooltip(tooltip, fillItem, waylaidCrates)
    -- Check if waylaidCrates is nil before accessing its values
    if not waylaidCrates then
        return  -- Exit the function early if waylaidCrates is nil
    end

    local itemID = waylaidCrates[7] -- Retrieve the itemID from the 7th value in your table
    local itemLink = select(2, GetItemInfo(itemID))
    if itemLink then
        local itemName = GetItemInfo(itemLink)
        local filledItemNumber = waylaidCrates[8]

        -- Conditionally add TSM tooltips only if TSM is loaded
        if TSM_API then
            local marketValue = GetMarketValue(itemLink)
            local minBuyout = GetMinBuyout(itemLink)
            --local craftingCost = GetCraftingCost(itemLink)
            local filledMarketValue = marketValue * filledItemNumber
            local filledMinBuyout = minBuyout * filledItemNumber

            tooltip:AddLine("\124cFF00FF00TSM prices for " .. itemName)
            tooltip:AddDoubleLine("\124cFFADD8E6Min Buyout: " .. GetMoneyString(minBuyout) .. " each.", "\124cFFADD8E6" .. GetMoneyString(filledMinBuyout) .. " filled.")
            tooltip:AddDoubleLine("\124cFFADD8E6Market Value: " .. GetMoneyString(marketValue) .. " each.", "\124cFFADD8E6" .. GetMoneyString(filledMarketValue) .. " filled.")
            --tooltip:AddDoubleLine("\124cFFADD8E6Crafting Cost: " .. GetMoneyString(craftingCost) .. " each.", "\124cFFADD8E6" .. GetMoneyString(craftingCost * filledItemNumber) .. " filled.")
        end

        -- Conditionally add Auctionator tooltips only if Auctionator is loaded
        if IsAddOnLoaded("Auctionator") then
            local auctionatorMinBuyout = GetAuctionatorMinBuyout(itemID)
            local filledAuctionatorMinBuyout = auctionatorMinBuyout * filledItemNumber

            if auctionatorMinBuyout > 0 then
                tooltip:AddLine("\124cFFFFA500Auctionator prices for " .. itemName)
                tooltip:AddDoubleLine("\124cFFFFD700Min Buyout: " .. GetMoneyString(auctionatorMinBuyout) .. " each.", "\124cFFFFD700" .. GetMoneyString(filledAuctionatorMinBuyout) .. " filled.")
            else
                tooltip:AddLine("\124cFFFFA500Auctionator prices for " .. itemName)
                tooltip:AddLine("\124cFFFFD700No auction data available. Please do a full scan.")
            end
        end
        tooltip:Show()
    end
end

-- Hook into tooltip events to capture item being moused over
local function OnTooltipSetItem(tooltip)
    local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expansionID, setID, isCraftingReagent = tooltip:GetItem()
    if itemLink then
        local itemID = tonumber(string.match(itemLink, "item:(%d+):"))
		local waylaidCrates = waylaidCrates[itemID]
		if itemID or waylaidCrates then
			Add_Waylaid_Supplies_Tooltip(tooltip, itemID)
			DisplayAssociatedItemTooltip(tooltip, associatedItemID, waylaidCrates)
            tooltip:Show()  -- Show the tooltip after adding TSM lines
		end
	end	
end

print("\124cFFFFA500WST: Welcome to Waylaid Supplies Tooltip v1.5.3")
print("\124cFFFFA500WST: Fixed: Exalted Rep")
print("\124cFFFFA500WST: Added: Rep cutoff and current standing line.")
--print("\124cFFFFA500WST: Coming Soon: Better language localization")

-- Hook the function to tooltip events
GameTooltip:HookScript("OnTooltipSetItem", Add_Waylaid_Supplies_Tooltip)
ItemRefTooltip:HookScript("OnTooltipSetItem", Add_Waylaid_Supplies_Tooltip)
GameTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
ItemRefTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)