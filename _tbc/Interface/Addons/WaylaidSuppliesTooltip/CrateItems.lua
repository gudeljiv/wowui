-- Waylaid Supplies Tooltip
-- Author: Shala - Wild Growth
-- Displays a tooltip for items that fill Waylaid Shipments

local addonName, addon = ...

-- List of items and their corresponding amounts needed to fill a waylaid supply crate.
-- [itemID] = {numberReq, moneyReward, itemName, pluralizedName}
local waylaidItems = {
--Phase 1
    [6290]  =  {20, 600,    "Brilliant Smallfish", "Brilliant Smallfish"},
    [2840]  =  {20, 600,    "Copper Bar", "Copper Bars"},
    [2581]  =  {10, 600,    "Heavy Linen Bandage", "Heavy Linen Bandages"},
    [6888]  =  {20, 600,    "Herb Baked Egg", "Herb Baked Eggs"},
    [2318]  =  {14, 600,    "Light Leather", "Light Leather"},
    [2447]  =  {20, 600,    "Peacebloom", "Peacebloom"},
    [2835]  =  {10, 600,    "Rough Stone", "Rough Stone"},
    [765]   =  {20, 600,    "Silverleaf", "Silverleaf"},
    [2680]  =  {20, 600,    "Spiced Wolf Meat", "Spiced Wolf Meat"},
    [3473]  =  {3,  1500,   "Runed Copper Pant", "Runed Copper Pants"},
    [4343]  =  {6,  1500,   "Brown Linen Pant", "Brown Linen Pants"},
    [6238]  =  {4,  1500,   "Brown Linen Robe", "Brown Linen Robes"},
    [2847]  =  {6,  1500,   "Copper Shortsword", "Copper Shortswords"},
    [2300]  =  {3,  1500,   "Embossed Leather Vest", "Embossed Leather Vests"},
    [4237]  =  {5,  1500,   "Handstitched Leather Belt", "Handstitched Leather Belts"},
    [929]   =  {10, 1500,   "Healing Potion", "Healing Potions"},
    [11287] =  {2,  1500,   "Lesser Magic Wand", "Lesser Magic Wands"},
    [118]   =  {20, 1500,   "Minor Healing Potion", "Minor Healing Potions"},
    [20744] =  {2,  1500,   "Minor Wizard Oil", "Minor Wizard Oil"},
    [4362]  =  {3,  1500,   "Rough Boomstick", "Rough Boomsticks"},
    [4360]  =  {12, 1500,   "Rough Copper Bomb", "Rough Copper Bombs"},
    [2841]  =  {12, 1500,   "Bronze Bar", "Bronze Bars"},
    [2453]  =  {20, 1500,   "Bruiseweed", "Bruiseweed"},
    [5527]  =  {8,  1500,   "Goblin Deviled Clam", "Goblin Deviled Clams"},
    [3531]  =  {15, 1500,   "Heavy Wool Bandage", "Heavy Wool Bandages"},
    [2319]  =  {12, 1500,   "Medium Leather", "Medium Leather"},
    [2842]  =  {6,  1500,   "Silver Bar", "Silver Bars"},
    [6890]  =  {20, 1500,   "Smoked Bear Meat", "Smoked Bear Meat"},
    [21072] =  {15, 1500,   "Smoked Sagefish", "Smoked Sagefish"},
    [2452]  =  {20, 1500,   "Swiftthistle", "Swiftthistle"},
    [2316]  =  {2,  2000,   "Dark Leather Cloak", "Dark Leather Cloaks"},
    [2587]  =  {4,  2000,   "Gray Woolen Shirt", "Gray Woolen Shirts"},
    [3385]  =  {20, 2000,   "Lesser Mana Potion", "Lesser Mana Potions"},
    [20745] =  {2,  2000,   "Minor Mana Oil", "Minor Mana Oil"},
    [6350]  =  {3,  2000,   "Rough Bronze Boot", "Rough Bronze Boots"},
    [4374]  =  {12, 2000,   "Small Bronze Bomb", "Small Bronze Bombs"},
    [6373]  =  {15, 3000,   "Elixir of Firepower", "Elixir of Firepower"},
    [4251]  =  {2,  3000,   "Hillman's Shoulder", "Hillman's Shoulders"},
    [5507]  =  {2,  3000,   "Ornate Spyglasse", "Ornate Spyglasses"},
    [5542]  =  {3,  3000,   "Pearl-clasped Cloak", "Pearl-clasped Cloaks"},
    [6339]  =  {1,  3000,   "Runed Silver Rod", "Runed Silver Rods"},
    [15869] =  {14, 3000,   "Silver Skeleton Key", "Silver Skeleton Keys"},
--Phase 2
    [3818]  =  {16, 20000,  "Fadeleaf", "Fadeleaf"},
    [6371]  =  {7,  20000,  "Fire Oil", "Fire Oil"},
    [4334]  =  {3,  20000,  "Formal White Shirt", "Formal White Shirts"},
    [4235]  =  {5,  20000,  "Heavy Hide", "Heavy Hide"},
    [6451]  =  {10, 55000,  "Heavy Silk Bandage", "Heavy Silk Bandages"},
    [3358]  =  {10, 55000,  "Khadgar's Whisker", "Khadgar's Whisker"},
    [3860]  =  {6,  55000,  "Mithril Bar", "Mithril Bars"},
    [8831]  =  {8,  55000,  "Purple Lotu", "Purple Lotus"},
    [4594]  =  {40, 20000,  "Rockscale Cod", "Rockscale Cod"},
    [7966]  =  {5,  20000,  "Solid Grinding Stone", "Solid Grinding Stones"},
    [3729]  =  {10, 55000,  "Soothing Turtle Bisque", "Soothing Turtle Bisque"},
    [17222] =  {5,  55000,  "Spider Sausage", "Spider Sausages"},
    [4304]  =  {10, 55000,  "Thick Leather", "Thick Leather"},
    [3819]  =  {8,  20000,  "Wintersbite", "Wintersbite"},
    [5964]  =  {4,  55000,  "Barbaric Shoulder", "Barbaric Shoulders"},
    [4394]  =  {8,  55000,  "Big Iron Bomb", "Big Iron Bombs"},
    [4391]  =  {2,  55000,  "Compact Harvest Reaper Kit", "Compact Harvest Reaper Kits"},
    [7062]  =  {4,  55000,  "Crimson Silk Pantaloon", "Crimson Silk Pantaloons"},
    [8949]  =  {6,  55000,  "Elixirs of Agility", "Elixirs of Agility"},
    [7377]  =  {2,  20000,  "Frost Leather Cloak", "Frost Leather Cloaks"},
    [3577]  =  {4,  55000,  "Gold Bar", "Gold Bars"},
    [1710]  =  {16, 55000,  "Greater Healing Potion", "Greater Healing Potions"},
    [3835]  =  {5,  20000,  "Green Iron Bracer", "Green Iron Bracers"},
    [5966]  =  {5,  20000,  "Guardian Glove", "Guardian Gloves"},
    [7919]  =  {3,  55000,  "Heavy Mithril Gauntlet", "Heavy Mithril Gauntlets"},
    [10546] =  {2,  120000, "Deadly Scope", "Deadly Scopes"},
    [4335]  =  {5,  120000, "Rich Purple Silk Shirt", "Rich Purple Silk Shirts"},
    [8951]  =  {14, 120000, "Elixirs of Greater Defense", "Elixirs of Greater Defense"},
    [3855]  =  {2,  120000, "Massive Iron Axe", "Massive Iron Axes"},
    [10508] =  {2,  120000, "Mithril Blunderbus", "Mithril Blunderbuss"},
    [8198]  =  {2,  120000, "Turtle Scale Bracer", "Turtle Scale Bracers"},
    [10008] =  {3,  120000, "White Bandit Mask", "White Bandit Masks"},
--Phase 3
    [13463] = {6,  38500, "Dreamfoil", "Dreamfoil"},
    [8545]  = {14, 38500, "Heavy Mageweave Bandage", "Heavy Mageweave Bandages"},
    [13931] = {8,  38500, "Nightfin Soup", "Nightfin Soup"},
    [8170]  = {14, 38500, "Rugged Leather", "Rugged Leather"},
    [8838]  = {15, 38500, "Sungrass", "Sungrass"},
    [18045] = {12, 38500, "Tender Wolf Steak", "Tender Wolf Steaks"},
    [8169]  = {8,  38500, "Thick Hide", "Thick Hide"},
    [12359] = {16, 38500, "Thorium Bar", "Thorium Bars"},
    [6037]  = {12, 38500, "Truesilver Bar", "Truesilver Bars"},
    [16766] = {16, 38500, "Undermine Clam Chowder", "Undermine Clam Chowder"},
    [10024] = {5,  84500, "Black Mageweave Headband", "Black Mageweave Headbands"},
    [12655] = {4,  84500, "Enchanted Thorium Bar", "Enchanted Thorium Bars"},
    [10562] = {16, 84500, "Hi-Explosive Bomb", "Hi-Explosive Bombs"},
    [13446] = {8,  84500, "Major Healing Potion", "Major Healing Potions"},
    [7931]  = {3,  84500, "Mithril Coif", "Mithril Coifs"},
    [15564] = {12, 84500, "Rugged Armor Kit", "Rugged Armor Kits"},
    [13443] = {6,  84500, "Superior Mana Potion", "Superior Mana Potions"},
    [12406] = {5,  84500, "Thorium Belt", "Thorium Belts"},
    [15993] = {3,  84500, "Thorium Grenade", "Thorium Grenades"},
    [10034] = {4,  84500, "Tuxedo Shirt", "Tuxedo Shirts"},
    [15084] = {6,  84500, "Wicked Leather Bracer", "Wicked Leather Bracers"},
    [13856] = {6,  154000, "Runecloth Belt", "Runecloth Belts"},
    [15092] = {5,  154000, "Runic Leather Bracer", "Runic Leather Bracers"},
    [15995] = {2,  154000, "Thorium Rifle", "Thorium Rifles"},
    [7938]  = {2,  154000, "Truesilver Gauntlet", "Truesilver Gauntlets"},
}

local function AddTooltipInfo(tooltip, itemID)
    local itemsData = waylaidItems[itemID]
    if itemsData then
        local numberReq, moneyReward, itemName, pluralizedName = unpack(itemsData)
        tooltip:AddDoubleLine(" ", " ")
        tooltip:AddLine("|cFF00FF00Requires " ..numberReq.. " to fill Waylaid Supplies: " ..pluralizedName.. " for " ..GetMoneyString(moneyReward).. "|r")
        tooltip:Show()
    else
        --print("No shipment data found for itemID:", itemID)
    end
end

local function OnTooltipSetItem(tooltip)
    local itemName, itemLink = tooltip:GetItem()
    --print("Item Name:", itemName)
    --print("Item Link:", itemLink)
    if itemLink then
        local itemID = tonumber(string.match(itemLink, "item:(%d+):"))
        --print("Item ID:", itemID)
        if itemID then
            AddTooltipInfo(tooltip, itemID)
        end
    end
end

local frame = CreateFrame("Frame")
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" and ... == addonName then
        self:UnregisterEvent("ADDON_LOADED")
        GameTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
		ItemRefTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
		--print("OnTooltipSetItem registered successfully.")
    end
end)
frame:RegisterEvent("ADDON_LOADED")