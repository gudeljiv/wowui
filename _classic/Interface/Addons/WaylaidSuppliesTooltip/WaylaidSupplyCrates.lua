-- Waylaid Supplies Tooltip
-- Author: Shala - Wild Growth
-- Displays in tooltip if a specific Waylaid Shipment will grant you reputation or not and by how much.

local frame = CreateFrame("Frame")
frame:RegisterEvent("GET_ITEM_INFO_RECEIVED")

-- [itemName] = {filledRep, filledMoney, unfilledMoney, questXP, itemLevel, questLevel}
local reputationItems = {
    ["Waylaid Supplies: Brilliant Smallfish"] = 		{ 300, 600,  100, 80,  10, 9 },
    ["Waylaid Supplies: Copper Bars"] = 				{ 300, 600,  100, 80,  10, 9 },
    ["Waylaid Supplies: Heavy Linen Bandages"] = 		{ 300, 600,  100, 80,  10, 9 },
    ["Waylaid Supplies: Herb Baked Eggs"] = 			{ 300, 600,  100, 80,  10, 9 },
    ["Waylaid Supplies: Light Leather"] = 				{ 300, 600,  100, 80,  10, 9 },
    ["Waylaid Supplies: Peacebloom"] = 					{ 300, 600,  100, 80,  10, 9 },
    ["Waylaid Supplies: Rough Stone"] = 				{ 300, 600,  100, 80,  10, 9 },
    ["Waylaid Supplies: Silverleaf"] = 					{ 300, 600,  100, 80,  10, 9 },
    ["Waylaid Supplies: Spiced Wolf Meat"] = 			{ 300, 600,  100, 80,  10, 9 },
    ["Waylaid Supplies: Runed Copper Pants"] = 			{ 450, 1500, 100, 90,  10, 12 },
    ["Waylaid Supplies: Brown Linen Pants"] = 			{ 450, 1500, 100, 90,  10, 12 },
    ["Waylaid Supplies: Brown Linen Robes"] = 			{ 450, 1500, 100, 90,  10, 12 },
    ["Waylaid Supplies: Copper Shortswords"] = 			{ 450, 1500, 100, 90,  10, 12 },
    ["Waylaid Supplies: Embossed Leather Vests"] = 		{ 450, 1500, 100, 90,  10, 12 },
    ["Waylaid Supplies: Handstitched Leather Belts"] = 	{ 450, 1500, 100, 90,  10, 12 },
    ["Waylaid Supplies: Healing Potions"] = 			{ 450, 1500, 100, 90,  10, 12 },
    ["Waylaid Supplies: Lesser Magic Wands"] = 			{ 450, 1500, 100, 90,  10, 12 },
    ["Waylaid Supplies: Minor Healing Potions"] = 		{ 450, 1500, 100, 90,  10, 12 },
    ["Waylaid Supplies: Minor Wizard Oil"] = 			{ 450, 1500, 100, 90,  10, 12 },
    ["Waylaid Supplies: Rough Boomsticks"] = 			{ 450, 1500, 100, 90,  10, 12 },
    ["Waylaid Supplies: Rough Copper Bombs"] = 			{ 450, 1500, 100, 90,  10, 12 },
    ["Waylaid Supplies: Bronze Bars"] = 				{ 500, 1500, 500, 140, 25, 18 },
    ["Waylaid Supplies: Bruiseweed"] = 					{ 500, 1500, 500, 140, 25, 18 }, --L28 Human, 30xp, 15s, 550rep
    ["Waylaid Supplies: Goblin Deviled Clams"] = 		{ 500, 1500, 500, 140, 25, 18 },
    ["Waylaid Supplies: Heavy Wool Bandages"] = 		{ 500, 1500, 500, 140, 25, 18 }, --l25 Troll, 160xp, 500rep, 15s
    ["Waylaid Supplies: Medium Leather"] = 				{ 500, 1500, 500, 140, 25, 18 }, --L28 Human, 30xp, 15s, 550rep
    ["Waylaid Supplies: Silver Bars"] = 				{ 500, 1500, 500, 140, 25, 18 }, --L28 Human, 30xp, 15s, 550rep
    ["Waylaid Supplies: Smoked Bear Meat"] = 			{ 500, 1500, 500, 140, 25, 18 },
    ["Waylaid Supplies: Smoked Sagefish"] = 			{ 500, 1500, 500, 140, 25, 18 }, --L23 Troll, 2680 xp. 500rep, 15s.
    ["Waylaid Supplies: Swiftthistle"] = 				{ 500, 1500, 500, 140, 25, 18 },
    ["Waylaid Supplies: Dark Leather Cloaks"] = 		{ 650, 2000, 500, 180, 25, 22 },
    ["Waylaid Supplies: Gray Woolen Shirts"] = 			{ 650, 2000, 500, 180, 25, 22 },
    ["Waylaid Supplies: Lesser Mana Potions"] = 		{ 650, 2000, 500, 180, 25, 22 }, --L25 Troll, 360 xp, 650rep, 20s. L28 Human, 280xp, 20s, 715rep
    ["Waylaid Supplies: Minor Mana Oil"] = 				{ 650, 2000, 500, 180, 25, 22 },
    ["Waylaid Supplies: Rough Bronze Boots"] = 			{ 650, 2000, 500, 180, 25, 22 },
    ["Waylaid Supplies: Small Bronze Bombs"] = 			{ 650, 2000, 500, 180, 25, 22 },
    ["Waylaid Supplies: Elixir of Firepower"] = 		{ 800, 3000, 500, 200, 25, 25 },
    ["Waylaid Supplies: Hillman's Shoulders"] = 		{ 800, 3000, 500, 200, 25, 25 },
    ["Waylaid Supplies: Ornate Spyglasses"] = 			{ 800, 3000, 500, 200, 25, 25 },
    ["Waylaid Supplies: Pearl-clasped Cloaks"] = 		{ 800, 3000, 500, 200, 25, 25 }, --L23 Troll, 6800xp (200base x 100%), 30s, 800Rep. (XP = Base XP x 2(if disc buff) + (Base XP x 16)) + x 2 if Discover Buff?)
    ["Waylaid Supplies: Runed Silver Rods"] = 			{ 800, 3000, 500, 200, 25, 25 },
    ["Waylaid Supplies: Silver Skeleton Keys"] = 		{ 800, 3000, 500, 200, 25, 25 }, --L28 Human, 400p, 30s, 
--Phase 2 
	--700 Rep Crates			                   		{ Rep,  f$,    u$,  XP, iLvl, qLvl}	Turn in notes
	["Waylaid Supplies: Fadeleaf"] = 					{ 700, 20000, 2000, 800, 30, 28 },
	["Waylaid Supplies: Fire Oil"] =  					{ 700, 20000, 2000, 800, 30, 28 }, 	-- turned into Filled Crate 217337, 700rep, 853xp (level 32), 50 silver.  L28 Human: 50s 804xp, 770 rep
	["Waylaid Supplies: Formal White Shirts"] =  		{ 700, 20000, 2000, 800, 30, 28 }, 	--GOLD REWARD NEEDS VERIFIED, 3 to fill,810 exp.
	["Waylaid Supplies: Heavy Hide"] = 					{ 700, 20000, 2000, 800, 30, 28 },
    ["Waylaid Supplies: Heavy Silk Bandages"] =  		{ 700, 20000, 2000, 800, 35, 28 },
    ["Waylaid Supplies: Khadgar's Whisker"] = 			{ 700, 20000, 2000, 800, 35, 28 }, 	--GOLD REWARD NEEDS VERIFIED L28 Human: 853xp, 50s, 770 rep
    ["Waylaid Supplies: Mithril Bars"] = 				{ 700, 20000, 2000, 800, 35, 28 },	--GOLD REWARD NEEDS VERIFIED
    ["Waylaid Supplies: Purple Lotus"] = 				{ 700, 20000, 2000, 800, 35, 28 },
	["Waylaid Supplies: Rockscale Cod"] =  				{ 700, 20000, 2000, 800, 30, 28 }, 	--L34 Human: 812 xp, 770rep, 50s, L37Human: 828xp, 770rep, 50s
	["Waylaid Supplies: Solid Grinding Stones"] = 		{ 700, 20000, 2000, 800, 30, 28 },	--L29 Troll: 2512xp, 700rep, 2g.
    ["Waylaid Supplies: Soothing Turtle Bisque"] =  	{ 700, 20000, 2000, 800, 35, 28 },
    ["Waylaid Supplies: Spider Sausages"] =  			{ 700, 55000, 2000, 800, 35, 28 },
    ["Waylaid Supplies: Thick Leather"] = 				{ 700, 20000, 2000, 800, 35, 28 },
	["Waylaid Supplies: Wintersbite"] = 				{ 700, 20000, 2000, 800, 30, 28 }, --L28 Human: 1257xp
	--850 Rep Crates									
	["Waylaid Supplies: Barbaric Shoulders"] =  		{ 850, 55000, 2000, 1500, 35, 35 },
	["Waylaid Supplies: Big Iron Bombs"] =  			{ 850, 55000, 2000, 1500, 30, 35 },
    ["Waylaid Supplies: Compact Harvest Reaper Kits"] = { 850, 55000, 2000, 1500, 35, 35 },
    ["Waylaid Supplies: Crimson Silk Pantaloons"] =  	{ 850, 55000, 2000, 1500, 35, 35 },	--L35 Human: 1525xp, 935rep, 1.5g. L37Human:1591xp, 935rep, 1.5g
	["Waylaid Supplies: Elixirs of Agility"] = 			{ 850, 55000, 2000, 1500, 35, 35 },
	["Waylaid Supplies: Frost Leather Cloaks"] =  		{ 850, 55000, 2000, 1500, 30, 35 }, --L25 Troll, 8800XP, 850 rep. 5g50s
    ["Waylaid Supplies: Gold Bars"] = 					{ 850, 55000, 2000, 1500, 35, 35 }, --GOLD REWARD NEEDS VERIFIED
    ["Waylaid Supplies: Greater Healing Potions"] = 	{ 850, 55000, 2000, 1500, 35, 35 }, --GOLD REWARD NEEDS VERIFIED
	["Waylaid Supplies: Green Iron Bracers"] = 			{ 850, 55000, 2000, 1500, 30, 35 },	--GOLD REWARD NEEDS VERIFIED L30 Gnome: 1519xp @ level 30 gnome 
 	["Waylaid Supplies: Guardian Gloves"] =  			{ 850, 55000, 2000, 1500, 30, 35 },
    ["Waylaid Supplies: Heavy Mithril Gauntlets"] = 	{ 850, 55000, 2000, 1500, 35, 35 },
	-- 12g, 1000 Rep Crates
	["Waylaid Supplies: Deadly Scopes"] =  				{ 1000, 120000, 2000, 1500, 30, 40 },	--WOWHEAD UPDATE 10 MAR  	
	["Waylaid Supplies: Rich Purple Silk Shirts"] =  	{ 1000, 120000, 2000, 1500, 35, 40 },	--WOWHEAD UPDATE 10 MAR
	["Waylaid Supplies: Elixirs of Greater Defense"] =	{ 1000, 120000, 2000, 3450, 40, 40 },
    ["Waylaid Supplies: Massive Iron Axes"] = 			{ 1000, 120000, 2000, 3450, 40, 40 },
    ["Waylaid Supplies: Mithril Blunderbuss"] =  		{ 1000, 120000, 2000, 3450, 40, 40 },
    ["Waylaid Supplies: Turtle Scale Bracers"] =  		{ 1000, 120000, 2000, 3450, 40, 40 },	--L37 Troll: 8111xp, 1000rep, 12g.
    ["Waylaid Supplies: White Bandit Masks"] =  		{ 1000, 120000, 2000, 3450, 40, 40 },
	--Not in the game
    --["Waylaid Supplies: Dusky Belts"] =  				{ 850,  15000, 2000, 1500, 35, 35 },
	--["Waylaid Supplies: Shadowskin Gloves"] =  		{ 850,  15000, 2000, 1500, 35, 35 },
	--["Waylaid Supplies: Gnomish Rocket Boots"] = 		{ 1000, 25000, 2000, 2500, 40, 40 },
    --["Waylaid Supplies: Goblin Mortars"] = 			{ 1000, 25000, 2000, 2500, 40, 40 },
    --["Waylaid Supplies: Lesser Stoneshield Potions"] ={ 1000, 25000, 2000, 2500, 40, 40 },
--Phase 3
    ["Waylaid Supplies: Dreamfoil"] = 					{950,  690000, 6969, 1700, 50, 45},
    ["Waylaid Supplies: Heavy Mageweave Bandages"] = 	{950,  690000, 6969, 1700, 50, 45},
    ["Waylaid Supplies: Nightfin Soup"] = 				{950,  690000, 6969, 1700, 50, 45},
    ["Waylaid Supplies: Rugged Leather"] = 				{950,  690000, 6969, 1700, 50, 45},
    ["Waylaid Supplies: Sungrass"] = 					{950,  690000, 6969, 1700, 50, 45},
    ["Waylaid Supplies: Tender Wolf Steaks"] = 			{950,  690000, 6969, 1700, 50, 45},
    ["Waylaid Supplies: Thick Hide"] = 					{950,  690000, 6969, 1700, 50, 45},
    ["Waylaid Supplies: Thorium Bars"] = 				{950,  690000, 6969, 1700, 50, 45},
    ["Waylaid Supplies: Truesilver Bars"] = 			{950,  690000, 6969, 1700, 50, 45},
    ["Waylaid Supplies: Undermine Clam Chowder"] = 		{950,  690000, 6969, 1700, 50, 45},
    ["Waylaid Supplies: Black Mageweave Headbands"] = 	{1300, 690000, 6969, 2850, 50, 45},
    ["Waylaid Supplies: Enchanted Thorium Bars"] = 		{1300, 690000, 6969, 2850, 50, 45},
    ["Waylaid Supplies: Hi-Explosive Bombs"] = 			{1300, 690000, 6969, 2850, 50, 45},
    ["Waylaid Supplies: Major Healing Potions"] = 		{1300, 690000, 6969, 2850, 50, 45},
    ["Waylaid Supplies: Mithril Coifs"] = 				{1300, 690000, 6969, 2850, 50, 45},
    ["Waylaid Supplies: Rugged Armor Kits"] = 			{1300, 690000, 6969, 2850, 50, 45},
    ["Waylaid Supplies: Superior Mana Potions"] = 		{1300, 690000, 6969, 2850, 50, 45},
    ["Waylaid Supplies: Thorium Belts"] = 				{1300, 690000, 6969, 2850, 50, 45},
    ["Waylaid Supplies: Thorium Grenades"] = 			{1300, 690000, 6969, 2850, 50, 45},
    ["Waylaid Supplies: Tuxedo Shirts"] = 				{1300, 690000, 6969, 2850, 50, 45},
    ["Waylaid Supplies: Wicked Leather Bracers"] = 		{1300, 690000, 6969, 2850, 50, 45},
    ["Waylaid Supplies: Runecloth Belts"] = 			{1850, 690000, 6969, 4650, 50, 45},
    ["Waylaid Supplies: Runic Leather Bracers"] = 		{1850, 690000, 6969, 4650, 50, 45},
    ["Waylaid Supplies: Thorium Rifles"] = 				{1850, 690000, 6969, 4650, 50, 45},
    ["Waylaid Supplies: Truesilver Gauntlets"] = 		{1850, 690000, 6969, 4650, 50, 45},
}

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
				
				--Reputation allowance check and display		    green				red
                local colorCode = (itemLevel >= threshold) and "\124cFF00FF00" or "\124cFFFF0000"
                local reputationStatus = (itemLevel < threshold) and "\124cFFFF0000No longer grants rep with " or colorCode .. "Will grant reputation with "
                
				--Experience, Quest Level and Item Level
				local questXP = reputationAmounts[4]
				local itemLevel = reputationAmounts[5]
				local questLevel = reputationAmounts[6]
				
                -- Checks the player's faction to display the Supply Crate faction
                local factionName = (UnitFactionGroup("player") == "Horde") and "Durotar Supply and Logistics" or "Azeroth Commerce Authority"
				
				--Tooltip text
                if itemLevel <= threshold then
                    tooltip:AddDoubleLine(" ", " ")
                  	tooltip:AddLine(reputationStatus .. factionName)
					local copperRewardText = "Filled: " .. GetMoneyString(reputationAmounts[2]) 
					local copperRewardText2 = "Vendor: " .. GetMoneyString(reputationAmounts[3])
					tooltip:AddDoubleLine(copperRewardText,copperRewardText2)
					tooltip:AddDoubleLine("Item Level: " .. itemLevel .. "            " .. "Quest Level: " .. questLevel, "Base XP: " .. questXP)
                else
                    local reputationText1 = "Filled: " .. modifiedReputation1 .. " Rep and ".. GetMoneyString(copperReward)
                    local reputationText2 = "Vendor: " .. GetMoneyString(copperReward2)
                    tooltip:AddDoubleLine(" ", " ")
					tooltip:AddLine(reputationStatus .. factionName)
                    tooltip:AddDoubleLine(reputationText1, reputationText2)
					tooltip:AddDoubleLine("Item Level: " .. itemLevel .. "            " .. "Quest Level: " .. questLevel, "Base XP: " .. questXP)
                    return
                end
            end
        end
    end
end

function frame:OnEvent(event, itemID, success)
    if event == "GET_ITEM_INFO_RECEIVED" and success then
        local itemName = GetItemInfo(itemID)
        local reputationAmounts = reputationItems[itemName]

        if reputationAmounts then
            local reputationText = "Reputation: " .. reputationAmounts[1]
            GameTooltip:AddLine(reputationText)
        end
    end
end
print("WST: Welcome to Waylaid Supplies Tooltip v1.4.7")
print("WST: Known Issue: Phase 3 values are incomplete, update incoming")
print("WST: Coming Soon: Auction house addon integrations and localization")
frame:SetScript("OnEvent", frame.OnEvent)
GameTooltip:HookScript("OnTooltipSetItem", Add_Waylaid_Supplies_Tooltip)
ItemRefTooltip:HookScript("OnTooltipSetItem", Add_Waylaid_Supplies_Tooltip)