--[[
AdiBags - Wrath Of The Lich King
by Zottelchen
version: 1.0.7
Items from the Wrath Of The Lich King expansion.
]]

local addonName, addon = ...
local AdiBags = LibStub("AceAddon-3.0"):GetAddon("AdiBags")

local L = addon.L
local MatchIDs
local Result = {}

local function AddToSet(...)
  local Set = {}
  for _, l in ipairs({ ... }) do
    for _, v in ipairs(l) do
      Set[v] = true
    end
  end
  return Set
end

local database = {}

-- Bandages
database["Bandages"] = {
  34721, -- Frostweave Bandage
  34722, -- Heavy Frostweave Bandage
}

-- Consumables
database["Consumables"] = {
  37567, -- Healing Injector Kit
  40536, -- Explosive Decoy
  40769, -- Scrapbot Construction Kit
  40771, -- Cobalt Frag Bomb
  40772, -- Gnomish Army Knife
  40892, -- Hammer Pick
  40893, -- Bladed Pickaxe
  41119, -- Saronite Bomb
  42546, -- Mana Injector Kit
  42641, -- Global Thermal Sapper Charge
  44951, -- Box of Bombs
  47828, -- Goblin Beam Welder
  49040, -- Jeeves
}

-- Foods and Drinks
database["FoodsandDrinks"] = {
  33004, -- Clamlette Magnifique
  33312, -- Mana Sapphire
  33443, -- Sour Goat Cheese
  33444, -- Pungent Seal Whey
  33445, -- Honeymint Tea
  33449, -- Crusty Flatbread
  33451, -- Fillet of Icefin
  33452, -- Honey-Spiced Lichen
  33454, -- Salted Venison
  34125, -- Shoveltusk Soup
  34747, -- Northern Stew
  34748, -- Mammoth Meal
  34749, -- Shoveltusk Steak
  34750, -- Worm Delight
  34751, -- Roasted Worg
  34752, -- Rhino Dogs
  34753, -- Great Feast
  34754, -- Mega Mammoth Meal
  34755, -- Tender Shoveltusk Steak
  34756, -- Spiced Worm Burger
  34757, -- Very Burnt Worg
  34758, -- Mighty Rhino Dogs
  34759, -- Smoked Rockfin
  34760, -- Grilled Bonescale
  34761, -- Sauteed Goby
  34762, -- Grilled Sculpin
  34763, -- Smoked Salmon
  34764, -- Poached Nettlefish
  34765, -- Pickled Fangtooth
  34766, -- Poached Northern Sculpin
  34767, -- Firecracker Salmon
  34768, -- Spicy Blue Nettlefish
  34769, -- Imperial Manta Steak
  35947, -- Sparkling Frostcap
  35948, -- Savory Snowplum
  35949, -- Tundra Berries
  35950, -- Sweet Potato Bread
  35951, -- Poached Emperor Salmon
  35952, -- Briny Hardcheese
  35953, -- Mead Basted Caribou
  35954, -- Sweetened Goat's Milk
  37252, -- Frostberries
  37253, -- Frostberry Juice
  37452, -- Fatty Bluefin
  38350, -- Winterfin "Depth Charge"
  38698, -- Bitter Plasma
  38706, -- Bowels 'n' Brains
  39520, -- Kungaloosh
  39691, -- Succulent Orca Stew
  40035, -- Northrend Honey Mead
  40036, -- Snowplum Brandy
  40042, -- Caraway Burnwine
  40202, -- Sizzling Grizzly Flank
  40356, -- Grizzleberries
  40357, -- Grizzleberry Juice
  40358, -- Raw Tallhorn Chunk
  40359, -- Fresh Eagle Meat
  41729, -- Stewed Drakeflesh
  41731, -- Yeti Milk
  41751, -- Black Mushroom
  42428, -- Carrot Cupcake
  42429, -- Red Velvet Cupcake
  42430, -- Dalaran Doughnut
  42431, -- Dalaran Brownie
  42432, -- Berry Pie Slice
  42433, -- Chocolate Cake Slice
  42434, -- Lovely Cake Slice
  42777, -- Crusader's Waterskin
  42778, -- Crusader's Rations
  42779, -- Steaming Chicken Soup
  42942, -- Baked Manta Ray
  42993, -- Spicy Fried Herring
  42994, -- Rhinolicious Wormsteak
  42995, -- Hearty Rhino
  42996, -- Snapper Extreme
  42997, -- Blackened Worg Steak
  42998, -- Cuttlesteak
  42999, -- Blackened Dragonfin
  43000, -- Dragonfin Filet
  43001, -- Tracker Snacks
  43004, -- Critter Bites
  43005, -- Spiced Mammoth Treats
  43015, -- Fish Feast
  43086, -- Fresh Apple Juice
  43087, -- Crisp Dalaran Apple
  43236, -- Star's Sorrow
  43268, -- Dalaran Clam Chowder
  43478, -- Gigantic Feast
  43480, -- Small Feast
  43488, -- Last Week's Mammoth
  43490, -- Tasty Cupcake
  43491, -- Bad Clams
  43492, -- Haunted Herring
  43518, -- Conjured Mana Pie
  43523, -- Conjured Mana Strudel
  43695, -- Half Full Bottle of Prison Moonshine
  43696, -- Half Empty Bottle of Prison Moonshine
  44049, -- Freshly-Speared Emperor Salmon
  44071, -- Slow-Roasted Eel
  44072, -- Roasted Mystery Beast
  44114, -- Old Spices
  44228, -- Baby Spice
  44570, -- Glass of Eversong Wine
  44571, -- Bottle of Silvermoon Port
  44573, -- Cup of Frog Venom Brew
  44574, -- Skin of Mulgore Firewater
  44575, -- Flask of Bitter Cactus Cider
  44607, -- Aged Dalaran Sharp
  44608, -- Dalaran Swiss
  44609, -- Fresh Dalaran Bread Slice
  44616, -- Glass of Dalaran White
  44617, -- Glass of Dalaran Red
  44618, -- Glass of Aged Dalaran Red
  44619, -- Glass of Peaked Dalaran Red
  44698, -- Intravenous Healing Potion
  44716, -- Mysterious Fermented Liquid
  44722, -- Aged Yolk
  44749, -- Salted Yeti Cheese
  44750, -- Mountain Water
  44791, -- Noblegarden Chocolate
  44836, -- Pumpkin Pie
  44837, -- Spice Bread Stuffing
  44838, -- Slow-Roasted Turkey
  44839, -- Candied Sweet Potato
  44840, -- Cranberry Chutney
  44854, -- Tangy Wetland Cranberries
  44855, -- Teldrassil Sweet Potato
  44940, -- Corn-Breaded Sausage
  44941, -- Fresh-Squeezed Limeade
  44953, -- Worg Tartare
  45932, -- Black Jelly
  46399, -- Thunder's Plunder
  46400, -- Barleybrew Gold
  46401, -- Crimson Stripe
  46402, -- Promise of the Pandaren
  46403, -- Chuganpug's Delight
  46690, -- Candy Skull
  46691, -- Bread of the Dead
  46784, -- Ripe Elwynn Pumpkin
  46793, -- Tangy Southfury Cranberries
  46796, -- Ripe Tirisfal Pumpkin
  46797, -- Mulgore Sweet Potato
  46887, -- Bountiful Feast
}

-- Other Consumables
database["OtherConsumables"] = {
  33099, -- Intact Plague Container
  33457, -- Scroll of Agility VI
  33458, -- Scroll of Intellect VI
  33459, -- Scroll of Protection VI
  33460, -- Scroll of Versatility VI
  33461, -- Scroll of Stamina VI
  33462, -- Scroll of Strength VI
  33617, -- Balanced Concoction
  33619, -- Lysander's Strain
  34000, -- Blood Elf Female Mask
  34001, -- Draenei Female Mask
  34002, -- Blood Elf Male Mask
  34003, -- Draenei Male Mask
  34044, -- B-Ball
  34076, -- Fish Bladder
  35946, -- Fizzcrank Practice Parachute
  37091, -- Scroll of Intellect VII
  37092, -- Scroll of Intellect VIII
  37093, -- Scroll of Stamina VII
  37094, -- Scroll of Stamina VIII
  37097, -- Scroll of Versatility VII
  37098, -- Scroll of Versatility VIII
  37118, -- Scroll of Recall
  37198, -- Prototype Neural Needler
  37265, -- Tua'kea's Breathing Bladder
  37431, -- Fetch Ball
  37464, -- Winterfin Horn of Distress
  37488, -- Wild Winter Pilsner
  37489, -- Izzard's Ever Flavor
  37490, -- Aromatic Honey Brew
  37491, -- Metok's Bubble Bock
  37492, -- Springtime Stout
  37493, -- Blackrock Lager
  37494, -- Stranglethorn Brew
  37495, -- Draenic Pale Ale
  37498, -- Bartlett's Bitter Brew
  37499, -- Lord of Frost's Private Label
  37815, -- Emerald Essence
  37859, -- Amber Essence
  37860, -- Ruby Essence
  37898, -- Wild Winter Pilsner
  37899, -- Izzard's Ever Flavor
  37900, -- Aromatic Honey Brew
  37901, -- Metok's Bubble Bock
  37906, -- Binary Brew
  37907, -- Autumnal Acorn Ale
  37908, -- Bartlett's Bitter Brew
  37909, -- Lord of Frost's Private Label
  37925, -- Experimental Mixture
  38266, -- Rotund Relic
  39213, -- Massive Seaforium Charge
  39878, -- Mysterious Egg
  39883, -- Cracked Egg
  40110, -- Haunted Memento
  40390, -- Vic's Emergency Air Tank
  41367, -- Dark Jade Focusing Lens
  41426, -- Magically Wrapped Gift
  41427, -- Dalaran Firework
  41509, -- Frostweave Net
  42420, -- Shadow Crystal Focusing Lens
  42421, -- Shadow Jade Focusing Lens
  42436, -- Chocolate Celebration Cake
  42438, -- Lovely Cake
  42439, -- Big Berry Pie
  42986, -- The RP-GG
  43002, -- Inflatable Land Mines
  43088, -- Dalaran Apple Bowl
  43135, -- Fate Rune of Fleet Feet
  43352, -- Pet Grooming Kit
  43462, -- Airy Pale Ale
  43463, -- Scroll of Agility VII
  43464, -- Scroll of Agility VIII
  43465, -- Scroll of Strength VII
  43466, -- Scroll of Strength VIII
  43467, -- Scroll of Protection VII
  43470, -- Worg Tooth Oatmeal Stout
  43472, -- Snowfall Lager
  43473, -- Drakefire Chile Ale
  43626, -- Happy Pet Snack
  43850, -- Certificate of Ownership
  43853, -- Titanium Skeleton Key
  43854, -- Cobalt Skeleton Key
  43950, -- Kirin Tor Commendation Badge
  44064, -- Nepeta Leaf
  44065, -- Oracle Secret Solution
  44067, -- Inscription of Triumph
  44113, -- Small Spice Bag
  44129, -- Lesser Inscription of the Storm
  44130, -- Lesser Inscription of the Crag
  44131, -- Lesser Inscription of the Axe
  44132, -- Lesser Inscription of the Pinnacle
  44314, -- Scroll of Recall II
  44315, -- Scroll of Recall III
  44435, -- Windle's Lighter
  44481, -- Grindgear Toy Gorilla
  44482, -- Trusty Copper Racer
  44599, -- Zippy Copper Racer
  44601, -- Heavy Copper Racer
  44610, -- Fresh Dalaran Bread
  44612, -- Dalaran Swiss Wheel
  44613, -- Aged Dalaran Sharp Wheel
  44621, -- Bottle of Dalaran White
  44622, -- Cask of Dalaran White
  44623, -- Bottle of Dalaran Red
  44625, -- Bottle of Aged Dalaran Red
  44626, -- Cask of Aged Dalaran Red
  44627, -- Bottle of Peaked Dalaran Red
  44629, -- Cask of Peaked Dalaran Red
  44632, -- Cask of Dalaran Red
  44710, -- Wyrmrest Commendation Badge
  44711, -- Argent Crusade Commendation Badge
  44713, -- Ebon Blade Commendation Badge
  44717, -- Disgusting Jar
  44718, -- Ripe Disgusting Jar
  44751, -- Hyldnir Spoils
  44792, -- Blossoming Branch
  44806, -- Brightly Colored Shell Fragment
  44812, -- Turkey Shooter
  44817, -- The Mischief Maker
  44818, -- Noblegarden Egg
  44844, -- Turkey Caller
  44943, -- Icy Prism
  44957, -- Greater Inscription of the Gladiator
  45047, -- Sandbox Tiger
  45714, -- Darnassus Commendation Badge
  45715, -- Exodar Commendation Badge
  45716, -- Gnomeregan Commendation Badge
  45717, -- Ironforge Commendation Badge
  45718, -- Stormwind Commendation Badge
  45719, -- Orgrimmar Commendation Badge
  45720, -- Sen'jin Commendation Badge
  45721, -- Silvermoon Commendation Badge
  45722, -- Thunder Bluff Commendation Badge
  45723, -- Undercity Commendation Badge
  45784, -- Thorim's Sigil
  45786, -- Hodir's Sigil
  45787, -- Mimiron's Sigil
  45788, -- Freya's Sigil
  45791, -- Sigils of the Watchers
  45798, -- Heroic Celestial Planetarium Key
  45814, -- Freya's Sigil
  45815, -- Hodir's Sigil
  45816, -- Mimiron's Sigil
  45817, -- Thorim's Sigil
  45855, -- Sigils of the Watchers
  46029, -- Magnetic Core
  46711, -- Spirit Candle
  46718, -- Orange Marigold
  46725, -- Red Rider Air Rifle
  46765, -- Blue War Fuel
  46766, -- Red War Fuel
  46779, -- Path of Cenarius
  46783, -- Pink Gumball
  46847, -- Seaforium Bombs
  47030, -- Huge Seaforium Bombs
  47541, -- Argent Pony Bridle
  49631, -- Standard Apothecary Serving Kit
  49702, -- Sons of Hodir Commendation Badge
  49856, -- "VICTORY" Perfume
  49857, -- "Enchantress" Perfume
  49858, -- "Forever" Perfume
  49859, -- "Bravado" Cologne
  49860, -- "Wizardry" Cologne
  49861, -- "STALWART" Cologne
  49936, -- Lovely Stormwind Card
  49937, -- Lovely Undercity Card
  49938, -- Lovely Darnassus Card
  49939, -- Lovely Orgrimmar Card
  49940, -- Lovely Ironforge Card
  49941, -- Lovely Thunder Bluff Card
  49942, -- Lovely Exodar Card
  49943, -- Lovely Silvermoon City Card
  50163, -- Lovely Rose
  50307, -- Infernal Spear
  54455, -- Paint Bomb
}

-- Elixirs
database["Elixirs"] = {
  37449, -- Breath of Murloc
  39666, -- Elixir of Mighty Agility
  40068, -- Wrath Elixir
  40070, -- Spellpower Elixir
  40072, -- Elixir of Versatility
  40073, -- Elixir of Mighty Strength
  40076, -- Guru's Elixir
  40078, -- Elixir of Mighty Fortitude
  40097, -- Elixir of Protection
  40109, -- Elixir of Mighty Mageblood
  44012, -- Underbelly Elixir
  44325, -- Elixir of Accuracy
  44327, -- Elixir of Deadly Strikes
  44328, -- Elixir of Mighty Defense
  44329, -- Elixir of Expertise
  44330, -- Elixir of Armor Piercing
  44331, -- Elixir of Lightning Speed
  44332, -- Elixir of Mighty Thoughts
  45621, -- Elixir of Minor Accuracy
}

-- Flasks
database["Flasks"] = {
  40079, -- Lesser Flask of Toughness
  40082, -- Mixture of the Frost Wyrm
  40083, -- Mixture of Stoneblood
  40084, -- Mixture of Endless Rage
  40404, -- Mixture of Pure Mojo
  46376, -- Flask of the Frost Wyrm
  46377, -- Flask of Endless Rage
  46378, -- Flask of Pure Mojo
  46379, -- Flask of Stoneblood
}

-- Potions
database["Potions"] = {
  33447, -- Runic Healing Potion
  33448, -- Runic Mana Potion
  36770, -- Zort's Protective Elixir
  38351, -- Murliver Oil
  39327, -- Noth's Special Brew
  39671, -- Resurgent Healing Potion
  40067, -- Icy Mana Potion
  40077, -- Crazy Alchemist's Potion
  40081, -- Potion of Nightmares
  40087, -- Powerful Rejuvenation Potion
  40093, -- Indestructible Potion
  40211, -- Potion of Speed
  40212, -- Potion of Wild Magic
  40213, -- Mighty Arcane Protection Potion
  40214, -- Mighty Fire Protection Potion
  40215, -- Mighty Frost Protection Potion
  40216, -- Mighty Nature Protection Potion
  40217, -- Mighty Shadow Protection Potion
  41166, -- Runic Healing Injector
  42545, -- Runic Mana Injector
  43569, -- Endless Healing Potion
  43570, -- Endless Mana Potion
}

-- Alchemy Recipes
database["AlchemyRecipes"] = {
  44564, -- Recipe: Mighty Arcane Protection Potion
  44565, -- Recipe: Mighty Fire Protection Potion
  44566, -- Recipe: Mighty Frost Protection Potion
  44567, -- Recipe: Mighty Nature Protection Potion
  44568, -- Recipe: Mighty Shadow Protection Potion
}

-- Blacksmithing Recipes
database["BlacksmithingRecipes"] = {
  41120, -- Plans: Reinforced Cobalt Legplates
  41122, -- Plans: Reinforced Cobalt Chestpiece
  41123, -- Plans: Reinforced Cobalt Helm
  41124, -- Plans: Reinforced Cobalt Shoulders
  44937, -- Plans: Titanium Plating
  44938, -- Plans: Titanium Plating
  45088, -- Plans: Belt of the Titans
  45089, -- Plans: Battlelord's Plate Boots
  45090, -- Plans: Plate Girdle of Righteousness
  45091, -- Plans: Treads of Destiny
  45092, -- Plans: Indestructible Plate Girdle
  45093, -- Plans: Spiked Deathdealers
  47622, -- Plans: Breastplate of the White Knight
  47623, -- Plans: Saronite Swordbreakers
  47624, -- Plans: Titanium Razorplate
  47625, -- Plans: Titanium Spikeguards
  47626, -- Plans: Sunforged Breastplate
  47627, -- Plans: Sunforged Bracers
  47640, -- Plans: Breastplate of the White Knight
  47641, -- Plans: Saronite Swordbreakers
  47642, -- Plans: Sunforged Bracers
  47643, -- Plans: Sunforged Breastplate
  47644, -- Plans: Titanium Razorplate
  47645, -- Plans: Titanium Spikeguards
  49969, -- Plans: Puresteel Legplates
  49970, -- Plans: Protectors of Life
  49971, -- Plans: Legplates of Painful Death
  49972, -- Plans: Hellfrozen Bonegrinders
  49973, -- Plans: Pillars of Might
  49974, -- Plans: Boots of Kingly Upheaval
}

-- Cooking Recipes
database["CookingRecipes"] = {
  34126, -- Recipe: Shoveltusk Soup
  39644, -- Recipe: Kungaloosh
  39692, -- Recipe: Succulent Orca Stew
  43017, -- Recipe: Fish Feast
  43018, -- Recipe: Mega Mammoth Meal
  43019, -- Recipe: Tender Shoveltusk Steak
  43020, -- Recipe: Spiced Worm Burger
  43021, -- Recipe: Very Burnt Worg
  43022, -- Recipe: Mighty Rhino Dogs
  43023, -- Recipe: Poached Northern Sculpin
  43024, -- Recipe: Firecracker Salmon
  43025, -- Recipe: Spicy Blue Nettlefish
  43026, -- Recipe: Imperial Manta Steak
  43027, -- Recipe: Spicy Fried Herring
  43028, -- Recipe: Rhinolicious Wormsteak
  43029, -- Recipe: Critter Bites
  43030, -- Recipe: Hearty Rhino
  43031, -- Recipe: Snapper Extreme
  43032, -- Recipe: Blackened Worg Steak
  43033, -- Recipe: Cuttlesteak
  43034, -- Recipe: Spiced Mammoth Treats
  43035, -- Recipe: Blackened Dragonfin
  43036, -- Recipe: Dragonfin Filet
  43037, -- Recipe: Tracker Snacks
  43505, -- Recipe: Gigantic Feast
  43506, -- Recipe: Small Feast
  43507, -- Recipe: Tasty Cupcake
  43508, -- Recipe: Last Week's Mammoth
  43509, -- Recipe: Bad Clams
  43510, -- Recipe: Haunted Herring
  44858, -- Recipe: Cranberry Chutney
  44859, -- Recipe: Candied Sweet Potato
  44860, -- Recipe: Spice Bread Stuffing
  44861, -- Recipe: Slow-Roasted Turkey
  44862, -- Recipe: Pumpkin Pie
  44954, -- Recipe: Worg Tartare
  44977, -- Recipe: Dig Rat Stew
  46710, -- Recipe: Bread of the Dead
  46803, -- Recipe: Spice Bread Stuffing
  46804, -- Recipe: Pumpkin Pie
  46805, -- Recipe: Cranberry Chutney
  46806, -- Recipe: Candied Sweet Potato
  46807, -- Recipe: Slow-Roasted Turkey
  46809, -- Bountiful Cookbook
  46810, -- Bountiful Cookbook
}

-- Enchanting Recipes
database["EnchantingRecipes"] = {
  37329, -- Formula: Enchant Weapon - Exceptional Versatility
  37335, -- Formula: Enchant Cloak - Superior Agility
  37337, -- Formula: Enchant Bracer - Greater Stats
  37339, -- Formula: Enchant Weapon - Giant Slayer
  37340, -- Formula: Enchant Chest - Exceptional Resilience
  37343, -- Formula: Enchant Weapon - Exceptional Agility
  37344, -- Formula: Enchant Weapon - Icebreaker
  37346, -- Formula: Enchant Bracer - Expertise
  37347, -- Formula: Enchant Cloak - Superior Dodge
  37348, -- Formula: Enchant Cloak - Haste
  37349, -- Formula: Enchant Cloak - Shadow Armor
  44471, -- Formula: Enchant Cloak - Mighty Stamina
  44472, -- Formula: Enchant Cloak - Greater Speed
  44473, -- Formula: Enchant Weapon - Scourgebane
  44483, -- Formula: Enchant 2H Weapon - Massacre
  44484, -- Formula: Enchant Bracer - Greater Assault
  44485, -- Formula: Enchant Gloves - Armsman
  44486, -- Formula: Enchant Weapon - Superior Potency
  44487, -- Formula: Enchant Weapon - Mighty Spellpower
  44488, -- Formula: Enchant Cloak - Wisdom
  44489, -- Formula: Enchant Chest - Powerful Stats
  44490, -- Formula: Enchant Boots - Greater Assault
  44491, -- Formula: Enchant Boots - Tuskarr's Vitality
  44492, -- Formula: Enchant Weapon - Berserking
  44494, -- Formula: Enchant Weapon - Lifeward
  44495, -- Formula: Enchant Weapon - Black Magic
  44496, -- Formula: Enchant Weapon - Accuracy
  44498, -- Formula: Enchant Bracer - Superior Spellpower
  44944, -- Formula: Enchant Bracer - Major Stamina
  45050, -- Formula: Smoking Heart of the Mountain
  45059, -- Formula: Enchant Staff - Greater Spellpower
  46027, -- Formula: Enchant Weapon - Blade Ward
  46348, -- Formula: Enchant Weapon - Blood Draining
  50406, -- Formula: Enchant Gloves - Angler
}

-- Engineering Recipes
database["EngineeringRecipes"] = {
  23817, -- Schematic: Titanium Toolbox
  44502, -- Schematic: Mechano-Hog
  44503, -- Schematic: Mekgineer's Chopper
  44918, -- Schematic: Cluster Launcher
  44919, -- Schematic: Firework Launcher
  49050, -- Schematic: Jeeves
}

-- Inscription Recipes
database["InscriptionRecipes"] = {
  45912, -- Book of Glyph Mastery
  46108, -- Technique: Rituals of the New Moon
}

-- Jewelcrafting Recipes
database["JewelcraftingRecipes"] = {
  41559, -- Design: Mystic Sun Crystal
  41560, -- Design: Stormy Chalcedony
  41561, -- Design: Reckless Huge Citrine
  41562, -- Design: Deadly Huge Citrine
  41563, -- Design: Willful Huge Citrine
  41565, -- Design: Lucent Huge Citrine
  41566, -- Design: Resplendent Huge Citrine
  41567, -- Design: Nimble Dark Jade
  41568, -- Design: Purified Shadow Crystal
  41569, -- Design: Shattered Dark Jade
  41570, -- Design: Radiant Dark Jade
  41571, -- Design: Turbid Dark Jade
  41572, -- Design: Steady Dark Jade
  41574, -- Design: Defender's Shadow Crystal
  41575, -- Design: Mysterious Shadow Crystal
  41576, -- Design: Bold Scarlet Ruby
  41577, -- Design: Delicate Scarlet Ruby
  41578, -- Design: Flashing Scarlet Ruby
  41579, -- Design: Quick Autumn's Glow
  41580, -- Design: Rigid Sky Sapphire
  41581, -- Design: Sparkling Sky Sapphire
  41582, -- Design: Glinting Twilight Opal
  41686, -- Design: Potent Monarch Topaz
  41687, -- Design: Deft Monarch Topaz
  41688, -- Design: Veiled Twilight Opal
  41690, -- Design: Reckless Monarch Topaz
  41692, -- Design: Energized Forest Emerald
  41693, -- Design: Forceful Forest Emerald
  41696, -- Design: Lightning Forest Emerald
  41697, -- Design: Regal Forest Emerald
  41698, -- Design: Nimble Forest Emerald
  41702, -- Design: Jagged Forest Emerald
  41704, -- Design: Chaotic Skyflare Diamond
  41705, -- Design: Shielded Skyflare Diamond
  41706, -- Design: Ember Skyflare Diamond
  41707, -- Design: Revitalizing Skyflare Diamond
  41708, -- Design: Insightful Earthsiege Diamond
  41709, -- Design: Invigorating Earthsiege Diamond
  41710, -- Design: Relentless Earthsiege Diamond
  41711, -- Design: Trenchant Earthsiege Diamond
  41718, -- Design: Brilliant Scarlet Ruby
  41719, -- Design: Subtle Autumn's Glow
  41720, -- Design: Smooth Autumn's Glow
  41721, -- Design: Deadly Monarch Topaz
  41722, -- Design: Stalwart Monarch Topaz
  41723, -- Design: Jagged Forest Emerald
  41724, -- Design: Misty Forest Emerald
  41725, -- Design: Timeless Twilight Opal
  41726, -- Design: Guardian's Twilight Opal
  41727, -- Design: Mystic Autumn's Glow
  41728, -- Design: Stormy Sky Sapphire
  41730, -- Design: Willful Monarch Topaz
  41733, -- Design: Lucent Monarch Topaz
  41734, -- Design: Resplendent Monarch Topaz
  41735, -- Design: Shattered Forest Emerald
  41737, -- Design: Turbid Forest Emerald
  41738, -- Design: Steady Forest Emerald
  41740, -- Design: Mysterious Twilight Opal
  41742, -- Design: Enigmatic Skyflare Diamond
  41743, -- Design: Forlorn Skyflare Diamond
  41744, -- Design: Impassive Skyflare Diamond
  41747, -- Design: Shifting Twilight Opal
  41777, -- Design: Etched Twilight Opal
  41778, -- Design: Resolute Monarch Topaz
  41780, -- Design: Champion's Monarch Topaz
  41781, -- Design: Misty Forest Emerald
  41782, -- Design: Lightning Forest Emerald
  41783, -- Design: Purified Twilight Opal
  41784, -- Design: Sovereign Twilight Opal
  41786, -- Design: Destructive Skyflare Diamond
  41787, -- Design: Thundering Skyflare Diamond
  41788, -- Design: Beaming Earthsiege Diamond
  41789, -- Design: Inscribed Monarch Topaz
  41790, -- Design: Precise Scarlet Ruby
  41793, -- Design: Fierce Monarch Topaz
  41797, -- Design: Austere Earthsiege Diamond
  41798, -- Design: Bracing Earthsiege Diamond
  41799, -- Design: Eternal Earthsiege Diamond
  41818, -- Design: Accurate Twilight Opal
  41819, -- Design: Radiant Forest Emerald
  41820, -- Design: Defender's Twilight Opal
  42138, -- Design: Solid Sky Sapphire
  42298, -- Design: Bold Dragon's Eye
  42301, -- Design: Delicate Dragon's Eye
  42302, -- Design: Flashing Dragon's Eye
  42305, -- Design: Mystic Dragon's Eye
  42306, -- Design: Precise Dragon's Eye
  42307, -- Design: Quick Dragon's Eye
  42308, -- Design: Rigid Dragon's Eye
  42309, -- Design: Brilliant Dragon's Eye
  42310, -- Design: Smooth Dragon's Eye
  42311, -- Design: Solid Dragon's Eye
  42312, -- Design: Sparkling Dragon's Eye
  42313, -- Design: Stormy Dragon's Eye
  42314, -- Design: Subtle Dragon's Eye
  42648, -- Design: Titanium Impact Band
  42649, -- Design: Titanium Earthguard Ring
  42650, -- Design: Titanium Spellshock Ring
  42651, -- Design: Titanium Impact Choker
  42652, -- Design: Titanium Earthguard Chain
  42653, -- Design: Titanium Spellshock Necklace
  43317, -- Design: Ring of Earthen Might
  43318, -- Design: Ring of Scarlet Shadows
  43319, -- Design: Windfire Band
  43320, -- Design: Ring of Northern Tears
  43485, -- Design: Savage Titanium Ring
  43497, -- Design: Savage Titanium Band
  43597, -- Design: Titanium Frostguard Ring
  46897, -- Design: Regal Eye of Zul
  46898, -- Design: Steady Eye of Zul
  46899, -- Design: Nimble Eye of Zul
  46901, -- Design: Jagged Eye of Zul
  46902, -- Design: Timeless Dreadstone
  46904, -- Design: Forceful Eye of Zul
  46905, -- Design: Misty Eye of Zul
  46909, -- Design: Lightning Eye of Zul
  46911, -- Design: Radiant Eye of Zul
  46912, -- Design: Energized Eye of Zul
  46913, -- Design: Shattered Eye of Zul
  46915, -- Design: Turbid Eye of Zul
  46916, -- Design: Brilliant Cardinal Ruby
  46917, -- Design: Bold Cardinal Ruby
  46918, -- Design: Delicate Cardinal Ruby
  46920, -- Design: Precise Cardinal Ruby
  46922, -- Design: Subtle King's Amber
  46923, -- Design: Flashing Cardinal Ruby
  46924, -- Design: Solid Majestic Zircon
  46925, -- Design: Sparkling Majestic Zircon
  46926, -- Design: Stormy Majestic Zircon
  46928, -- Design: Rigid Majestic Zircon
  46929, -- Design: Smooth King's Amber
  46932, -- Design: Mystic King's Amber
  46933, -- Design: Quick King's Amber
  46935, -- Design: Sovereign Dreadstone
  46937, -- Design: Purified Dreadstone
  46938, -- Design: Shifting Dreadstone
  46940, -- Design: Regal Eye of Zul
  46941, -- Design: Defender's Dreadstone
  46942, -- Design: Guardian's Dreadstone
  46943, -- Design: Mysterious Dreadstone
  46944, -- Design: Jagged Eye of Zul
  46948, -- Design: Inscribed Ametrine
  46949, -- Design: Deadly Ametrine
  46950, -- Design: Potent Ametrine
  46951, -- Design: Veiled Dreadstone
  46952, -- Design: Willful Ametrine
  46953, -- Design: Etched Dreadstone
  46956, -- Design: Glinting Dreadstone
  47007, -- Design: Reckless Ametrine
  47010, -- Design: Accurate Dreadstone
  47015, -- Design: Champion's Ametrine
  47017, -- Design: Stalwart Ametrine
  47018, -- Design: Resplendent Ametrine
  47019, -- Design: Fierce Ametrine
  47020, -- Design: Deft Ametrine
  47021, -- Design: Lucent Ametrine
  47022, -- Design: Resolute Ametrine
  49112, -- Design: Nightmare Tear
}

-- Leatherworking Recipes
database["LeatherworkingRecipes"] = {
  44509, -- Pattern: Trapper's Traveling Pack
  44510, -- Pattern: Mammoth Mining Bag
  44513, -- Pattern: Eviscerator's Facemask
  44514, -- Pattern: Eviscerator's Shoulderpads
  44515, -- Pattern: Eviscerator's Chestguard
  44516, -- Pattern: Eviscerator's Bindings
  44517, -- Pattern: Eviscerator's Gauntlets
  44518, -- Pattern: Eviscerator's Waistguard
  44519, -- Pattern: Eviscerator's Legguards
  44520, -- Pattern: Eviscerator's Treads
  44521, -- Pattern: Overcast Headguard
  44522, -- Pattern: Overcast Spaulders
  44523, -- Pattern: Overcast Chestguard
  44524, -- Pattern: Overcast Bracers
  44525, -- Pattern: Overcast Handwraps
  44526, -- Pattern: Overcast Belt
  44527, -- Pattern: Overcast Leggings
  44528, -- Pattern: Overcast Boots
  44530, -- Pattern: Swiftarrow Helm
  44531, -- Pattern: Swiftarrow Shoulderguards
  44532, -- Pattern: Swiftarrow Hauberk
  44533, -- Pattern: Swiftarrow Bracers
  44534, -- Pattern: Swiftarrow Gauntlets
  44535, -- Pattern: Swiftarrow Belt
  44536, -- Pattern: Swiftarrow Leggings
  44537, -- Pattern: Swiftarrow Boots
  44538, -- Pattern: Stormhide Crown
  44539, -- Pattern: Stormhide Shoulders
  44540, -- Pattern: Stormhide Hauberk
  44541, -- Pattern: Stormhide Wristguards
  44542, -- Pattern: Stormhide Grips
  44543, -- Pattern: Stormhide Belt
  44544, -- Pattern: Stormhide Legguards
  44545, -- Pattern: Stormhide Stompers
  44546, -- Pattern: Giantmaim Legguards
  44547, -- Pattern: Giantmaim Bracers
  44548, -- Pattern: Revenant's Breastplate
  44549, -- Pattern: Revenant's Treads
  44550, -- Pattern: Trollwoven Spaulders
  44551, -- Pattern: Trollwoven Girdle
  44552, -- Pattern: Earthgiving Legguards
  44553, -- Pattern: Earthgiving Boots
  44584, -- Pattern: Polar Vest
  44585, -- Pattern: Polar Cord
  44586, -- Pattern: Polar Boots
  44587, -- Pattern: Icy Scale Chestguard
  44588, -- Pattern: Icy Scale Belt
  44589, -- Pattern: Icy Scale Boots
  44932, -- Pattern: Windripper Boots
  44933, -- Pattern: Windripper Leggings
  45094, -- Pattern: Belt of Dragons
  45095, -- Pattern: Boots of Living Scale
  45096, -- Pattern: Blue Belt of Chaos
  45097, -- Pattern: Lightning Grounded Boots
  45098, -- Pattern: Death-Warmed Belt
  45099, -- Pattern: Footpads of Silence
  45100, -- Pattern: Belt of Arctic Life
  45101, -- Pattern: Boots of Wintry Endurance
  47628, -- Pattern: Ensorcelled Nerubian Breastplate
  47629, -- Pattern: Black Chitin Bracers
  47630, -- Pattern: Crusader's Dragonscale Breastplate
  47631, -- Pattern: Crusader's Dragonscale Bracers
  47632, -- Pattern: Lunar Eclipse Robes
  47633, -- Pattern: Moonshadow Armguards
  47634, -- Pattern: Knightbane Carapace
  47635, -- Pattern: Bracers of Swift Death
  47646, -- Pattern: Black Chitin Bracers
  47647, -- Pattern: Bracers of Swift Death
  47648, -- Pattern: Crusader's Dragonscale Bracers
  47649, -- Pattern: Crusader's Dragonscale Breastplate
  47650, -- Pattern: Ensorcelled Nerubian Breastplate
  47651, -- Pattern: Knightbane Carapace
  47652, -- Pattern: Lunar Eclipse Robes
  47653, -- Pattern: Moonshadow Armguards
  49957, -- Pattern: Legwraps of Unleashed Nature
  49958, -- Pattern: Blessed Cenarion Boots
  49959, -- Pattern: Bladeborn Leggings
  49961, -- Pattern: Footpads of Impending Death
  49962, -- Pattern: Lightning-Infused Leggings
  49963, -- Pattern: Earthsoul Boots
  49965, -- Pattern: Draconic Bonesplinter Legguards
  49966, -- Pattern: Rock-Steady Treads
}

-- Mining Recipes
database["MiningRecipes"] = {
  44956, -- Goblin's Guide to Elementium
}

-- Tailoring Recipes
database["TailoringRecipes"] = {
  39152, -- Manual: Heavy Frostweave Bandage
  42172, -- Pattern: Red Lumberjack Shirt
  42173, -- Pattern: Blue Lumberjack Shirt
  42175, -- Pattern: Green Lumberjack Shirt
  42176, -- Pattern: Blue Workman's Shirt
  42177, -- Pattern: Red Workman's Shirt
  42178, -- Pattern: Rustic Workman's Shirt
  42183, -- Pattern: Abyssal Bag
  42184, -- Pattern: Glacial Bag
  42185, -- Pattern: Mysterious Bag
  42187, -- Pattern: Brilliant Spellthread
  42188, -- Pattern: Sapphire Spellthread
  43876, -- A Guide to Northern Cloth Scavenging
  44916, -- Pattern: Festival Dress
  44917, -- Pattern: Festival Suit
  45102, -- Pattern: Sash of Ancient Power
  45103, -- Pattern: Spellslinger's Slippers
  45104, -- Pattern: Cord of the White Dawn
  45105, -- Pattern: Savior's Slippers
  45774, -- Pattern: Emerald Bag
  47636, -- Pattern: Royal Moonshroud Robe
  47637, -- Pattern: Royal Moonshroud Bracers
  47638, -- Pattern: Merlin's Robe
  47639, -- Pattern: Bejeweled Wizard's Bracers
  47654, -- Pattern: Bejeweled Wizard's Bracers
  47655, -- Pattern: Merlin's Robe
  47656, -- Pattern: Royal Moonshroud Bracers
  47657, -- Pattern: Royal Moonshroud Robe
  49953, -- Pattern: Leggings of Woven Death
  49954, -- Pattern: Deathfrost Boots
  49955, -- Pattern: Lightweave Leggings
  49956, -- Pattern: Sandals of Consecration
  54798, -- Pattern: Frosty Flying Carpet
}

-- Gems
database["Gems"] = {
  36767, -- Solid Dragon's Eye
  38654, -- Corvus' Report
  39900, -- Bold Bloodstone
  39905, -- Delicate Bloodstone
  39907, -- Subtle Sun Crystal
  39908, -- Flashing Bloodstone
  39909, -- Smooth Sun Crystal
  39910, -- Precise Bloodstone
  39912, -- Brilliant Bloodstone
  39915, -- Rigid Chalcedony
  39917, -- Mystic Sun Crystal
  39918, -- Quick Sun Crystal
  39919, -- Solid Chalcedony
  39927, -- Sparkling Chalcedony
  39932, -- Stormy Chalcedony
  39933, -- Jagged Dark Jade
  39934, -- Sovereign Shadow Crystal
  39935, -- Shifting Shadow Crystal
  39939, -- Defender's Shadow Crystal
  39940, -- Guardian's Shadow Crystal
  39942, -- Glinting Shadow Crystal
  39945, -- Mysterious Shadow Crystal
  39947, -- Inscribed Huge Citrine
  39948, -- Etched Shadow Crystal
  39949, -- Champion's Huge Citrine
  39950, -- Resplendent Huge Citrine
  39951, -- Fierce Huge Citrine
  39952, -- Deadly Huge Citrine
  39954, -- Lucent Huge Citrine
  39955, -- Deft Huge Citrine
  39956, -- Potent Huge Citrine
  39957, -- Veiled Shadow Crystal
  39958, -- Willful Huge Citrine
  39959, -- Reckless Huge Citrine
  39965, -- Stalwart Huge Citrine
  39966, -- Accurate Shadow Crystal
  39967, -- Resolute Huge Citrine
  39968, -- Timeless Shadow Crystal
  39975, -- Nimble Dark Jade
  39976, -- Regal Dark Jade
  39977, -- Steady Dark Jade
  39978, -- Forceful Dark Jade
  39979, -- Purified Shadow Crystal
  39980, -- Misty Dark Jade
  39981, -- Lightning Dark Jade
  39982, -- Turbid Dark Jade
  39983, -- Energized Dark Jade
  39991, -- Radiant Dark Jade
  39992, -- Shattered Dark Jade
  39996, -- Bold Scarlet Ruby
  39997, -- Delicate Scarlet Ruby
  39998, -- Brilliant Scarlet Ruby
  40000, -- Subtle Autumn's Glow
  40001, -- Flashing Scarlet Ruby
  40003, -- Precise Scarlet Ruby
  40008, -- Solid Sky Sapphire
  40010, -- Sparkling Sky Sapphire
  40011, -- Stormy Sky Sapphire
  40013, -- Smooth Autumn's Glow
  40014, -- Rigid Sky Sapphire
  40016, -- Mystic Autumn's Glow
  40017, -- Quick Autumn's Glow
  40022, -- Sovereign Twilight Opal
  40023, -- Shifting Twilight Opal
  40025, -- Timeless Twilight Opal
  40026, -- Purified Twilight Opal
  40028, -- Mysterious Twilight Opal
  40032, -- Defender's Twilight Opal
  40034, -- Guardian's Twilight Opal
  40037, -- Inscribed Monarch Topaz
  40038, -- Etched Twilight Opal
  40039, -- Champion's Monarch Topaz
  40040, -- Resplendent Monarch Topaz
  40041, -- Fierce Monarch Topaz
  40044, -- Glinting Twilight Opal
  40045, -- Lucent Monarch Topaz
  40048, -- Potent Monarch Topaz
  40049, -- Veiled Twilight Opal
  40050, -- Willful Monarch Topaz
  40051, -- Reckless Monarch Topaz
  40052, -- Deadly Monarch Topaz
  40055, -- Deft Monarch Topaz
  40057, -- Stalwart Monarch Topaz
  40058, -- Accurate Twilight Opal
  40059, -- Resolute Monarch Topaz
  40086, -- Jagged Forest Emerald
  40088, -- Nimble Forest Emerald
  40089, -- Regal Forest Emerald
  40090, -- Steady Forest Emerald
  40091, -- Forceful Forest Emerald
  40095, -- Misty Forest Emerald
  40098, -- Radiant Forest Emerald
  40100, -- Lightning Forest Emerald
  40102, -- Turbid Forest Emerald
  40105, -- Energized Forest Emerald
  40106, -- Shattered Forest Emerald
  40111, -- Bold Cardinal Ruby
  40112, -- Delicate Cardinal Ruby
  40113, -- Brilliant Cardinal Ruby
  40115, -- Subtle King's Amber
  40116, -- Flashing Cardinal Ruby
  40118, -- Precise Cardinal Ruby
  40119, -- Solid Majestic Zircon
  40120, -- Sparkling Majestic Zircon
  40122, -- Stormy Majestic Zircon
  40124, -- Smooth King's Amber
  40125, -- Rigid Majestic Zircon
  40127, -- Mystic King's Amber
  40128, -- Quick King's Amber
  40129, -- Sovereign Dreadstone
  40130, -- Shifting Dreadstone
  40133, -- Purified Dreadstone
  40135, -- Mysterious Dreadstone
  40139, -- Defender's Dreadstone
  40141, -- Guardian's Dreadstone
  40142, -- Inscribed Ametrine
  40143, -- Etched Dreadstone
  40144, -- Champion's Ametrine
  40145, -- Resplendent Ametrine
  40146, -- Fierce Ametrine
  40147, -- Deadly Ametrine
  40149, -- Lucent Ametrine
  40150, -- Deft Ametrine
  40152, -- Potent Ametrine
  40153, -- Veiled Dreadstone
  40154, -- Willful Ametrine
  40155, -- Reckless Ametrine
  40157, -- Glinting Dreadstone
  40160, -- Stalwart Ametrine
  40162, -- Accurate Dreadstone
  40163, -- Resolute Ametrine
  40164, -- Timeless Dreadstone
  40165, -- Jagged Eye of Zul
  40166, -- Nimble Eye of Zul
  40167, -- Regal Eye of Zul
  40168, -- Steady Eye of Zul
  40169, -- Forceful Eye of Zul
  40171, -- Misty Eye of Zul
  40173, -- Turbid Eye of Zul
  40177, -- Lightning Eye of Zul
  40179, -- Energized Eye of Zul
  40180, -- Radiant Eye of Zul
  40182, -- Shattered Eye of Zul
  41285, -- Chaotic Skyflare Diamond
  41307, -- Destructive Skyflare Diamond
  41333, -- Ember Skyflare Diamond
  41335, -- Enigmatic Skyflare Diamond
  41339, -- Swift Skyflare Diamond
  41375, -- Tireless Skyflare Diamond
  41376, -- Revitalizing Skyflare Diamond
  41377, -- Shielded Skyflare Diamond
  41378, -- Forlorn Skyflare Diamond
  41379, -- Impassive Skyflare Diamond
  41380, -- Austere Earthsiege Diamond
  41381, -- Persistent Earthsiege Diamond
  41382, -- Trenchant Earthsiege Diamond
  41385, -- Invigorating Earthsiege Diamond
  41389, -- Beaming Earthsiege Diamond
  41395, -- Bracing Earthsiege Diamond
  41396, -- Eternal Earthsiege Diamond
  41397, -- Powerful Earthsiege Diamond
  41398, -- Relentless Earthsiege Diamond
  41400, -- Thundering Skyflare Diamond
  41401, -- Insightful Earthsiege Diamond
  41432, -- Perfect Bold Bloodstone
  41434, -- Perfect Delicate Bloodstone
  41435, -- Perfect Flashing Bloodstone
  41436, -- Perfect Smooth Sun Crystal
  41437, -- Perfect Precise Bloodstone
  41439, -- Perfect Subtle Sun Crystal
  41440, -- Perfect Sparkling Chalcedony
  41441, -- Perfect Solid Chalcedony
  41443, -- Perfect Stormy Chalcedony
  41444, -- Perfect Brilliant Bloodstone
  41445, -- Perfect Mystic Sun Crystal
  41446, -- Perfect Quick Sun Crystal
  41447, -- Perfect Rigid Chalcedony
  41450, -- Perfect Shifting Shadow Crystal
  41451, -- Perfect Defender's Shadow Crystal
  41452, -- Perfect Timeless Shadow Crystal
  41453, -- Perfect Guardian's Shadow Crystal
  41455, -- Perfect Mysterious Shadow Crystal
  41461, -- Perfect Sovereign Shadow Crystal
  41462, -- Perfect Glinting Shadow Crystal
  41464, -- Perfect Regal Dark Jade
  41466, -- Perfect Forceful Dark Jade
  41467, -- Perfect Energized Dark Jade
  41468, -- Perfect Jagged Dark Jade
  41470, -- Perfect Misty Dark Jade
  41473, -- Perfect Purified Shadow Crystal
  41474, -- Perfect Shattered Dark Jade
  41475, -- Perfect Lightning Dark Jade
  41476, -- Perfect Steady Dark Jade
  41478, -- Perfect Radiant Dark Jade
  41480, -- Perfect Turbid Dark Jade
  41481, -- Perfect Nimble Dark Jade
  41482, -- Perfect Accurate Shadow Crystal
  41483, -- Perfect Champion's Huge Citrine
  41484, -- Perfect Deadly Huge Citrine
  41485, -- Perfect Deft Huge Citrine
  41486, -- Perfect Willful Huge Citrine
  41488, -- Perfect Etched Shadow Crystal
  41489, -- Perfect Fierce Huge Citrine
  41490, -- Perfect Stalwart Huge Citrine
  41492, -- Perfect Inscribed Huge Citrine
  41493, -- Perfect Lucent Huge Citrine
  41495, -- Perfect Potent Huge Citrine
  41497, -- Perfect Reckless Huge Citrine
  41498, -- Perfect Resolute Huge Citrine
  41499, -- Perfect Resplendent Huge Citrine
  41502, -- Perfect Veiled Shadow Crystal
  42142, -- Bold Dragon's Eye
  42143, -- Delicate Dragon's Eye
  42144, -- Brilliant Dragon's Eye
  42145, -- Sparkling Dragon's Eye
  42149, -- Smooth Dragon's Eye
  42150, -- Quick Dragon's Eye
  42151, -- Subtle Dragon's Eye
  42152, -- Flashing Dragon's Eye
  42154, -- Precise Dragon's Eye
  42155, -- Stormy Dragon's Eye
  42156, -- Rigid Dragon's Eye
  42158, -- Mystic Dragon's Eye
  42701, -- Enchanted Pearl
  42702, -- Enchanted Tear
  44066, -- Kharmaa's Grace
  44076, -- Swift Starflare Diamond
  44078, -- Tireless Starflare Diamond
  44081, -- Enigmatic Starflare Diamond
  44082, -- Impassive Starflare Diamond
  44084, -- Forlorn Starflare Diamond
  44087, -- Persistent Earthshatter Diamond
  44088, -- Powerful Earthshatter Diamond
  44089, -- Trenchant Earthshatter Diamond
  45862, -- Bold Stormjewel
  45879, -- Delicate Stormjewel
  45880, -- Solid Stormjewel
  45881, -- Sparkling Stormjewel
  45882, -- Brilliant Stormjewel
  45883, -- Brilliant Stormjewel
  45987, -- Rigid Stormjewel
  49110, -- Nightmare Tear
}

-- Permanent Enhancements
database["PermanentEnhancements"] = {
  37603, -- Enchant Boots - Dexterity
  38371, -- Jormungar Leg Armor
  38372, -- Nerubian Leg Armor
  38373, -- Frosthide Leg Armor
  38374, -- Icescale Leg Armor
  38375, -- Borean Armor Kit
  38376, -- Heavy Borean Armor Kit
  38679, -- Enchant Bracer - Minor Health
  38766, -- Enchant Chest - Minor Health
  38767, -- Enchant Chest - Minor Absorption
  38768, -- Enchant Bracer - Minor Dodge
  38769, -- Enchant Chest - Minor Mana
  38771, -- Enchant Bracer - Minor Stamina
  38772, -- Enchant 2H Weapon - Minor Impact
  38773, -- Enchant Chest - Lesser Health
  38774, -- Enchant Bracer - Minor Versatility
  38775, -- Enchant Cloak - Minor Protection
  38776, -- Enchant Chest - Lesser Mana
  38777, -- Enchant Bracer - Minor Agility
  38778, -- Enchant Bracer - Minor Strength
  38779, -- Enchant Weapon - Minor Beastslayer
  38780, -- Enchant Weapon - Minor Striking
  38781, -- Enchant 2H Weapon - Lesser Intellect
  38782, -- Enchant Chest - Health
  38783, -- Enchant Bracer - Lesser Versatility
  38785, -- Enchant Boots - Minor Stamina
  38786, -- Enchant Boots - Minor Agility
  38787, -- Enchant Shield - Minor Stamina
  38788, -- Enchant 2H Weapon - Lesser Versatility
  38789, -- Enchant Cloak - Minor Agility
  38790, -- Enchant Cloak - Lesser Protection
  38791, -- Enchant Shield - Lesser Protection
  38792, -- Enchant Shield - Lesser Versatility
  38793, -- Enchant Bracer - Lesser Stamina
  38794, -- Enchant Weapon - Lesser Striking
  38796, -- Enchant 2H Weapon - Lesser Impact
  38797, -- Enchant Bracer - Lesser Strength
  38798, -- Enchant Chest - Lesser Absorption
  38799, -- Enchant Chest - Mana
  38800, -- Enchant Gloves - Mining
  38801, -- Enchant Gloves - Herbalism
  38802, -- Enchant Gloves - Fishing
  38803, -- Enchant Bracer - Lesser Intellect
  38804, -- Enchant Chest - Minor Stats
  38805, -- Enchant Shield - Lesser Stamina
  38806, -- Enchant Cloak - Defense
  38807, -- Enchant Boots - Lesser Agility
  38808, -- Enchant Chest - Greater Health
  38809, -- Enchant Bracer - Versatility
  38810, -- Enchant Boots - Lesser Stamina
  38811, -- Enchant Bracer - Lesser Dodge
  38812, -- Enchant Bracer - Stamina
  38813, -- Enchant Weapon - Lesser Beastslayer
  38814, -- Enchant Weapon - Lesser Elemental Slayer
  38816, -- Enchant Shield - Versatility
  38817, -- Enchant Bracer - Strength
  38818, -- Enchant Chest - Greater Mana
  38819, -- Enchant Boots - Lesser Versatility
  38820, -- Enchant Shield - Lesser Parry
  38821, -- Enchant Weapon - Striking
  38822, -- Enchant 2H Weapon - Impact
  38823, -- Enchant Gloves - Skinning
  38824, -- Enchant Chest - Lesser Stats
  38825, -- Enchant Cloak - Greater Defense
  38827, -- Enchant Gloves - Agility
  38828, -- Enchant Shield - Stamina
  38829, -- Enchant Bracer - Intellect
  38830, -- Enchant Boots - Stamina
  38831, -- Enchant Gloves - Advanced Mining
  38832, -- Enchant Bracer - Greater Versatility
  38833, -- Enchant Chest - Superior Health
  38834, -- Enchant Gloves - Advanced Herbalism
  38835, -- Enchant Cloak - Lesser Agility
  38836, -- Enchant Gloves - Strength
  38837, -- Enchant Boots - Minor Speed
  38838, -- Enchant Weapon - Fiery Weapon
  38839, -- Enchant Shield - Greater Versatility
  38840, -- Enchant Weapon - Demonslaying
  38841, -- Enchant Chest - Superior Mana
  38842, -- Enchant Bracer - Dodge
  38844, -- Enchant Boots - Agility
  38845, -- Enchant 2H Weapon - Greater Impact
  38846, -- Enchant Bracer - Greater Strength
  38847, -- Enchant Chest - Stats
  38848, -- Enchant Weapon - Greater Striking
  38849, -- Enchant Bracer - Greater Stamina
  38850, -- Enchant Gloves - Riding Skill
  38851, -- Enchant Gloves - Minor Haste
  38852, -- Enchant Bracer - Greater Intellect
  38853, -- Enchant Bracer - Superior Versatility
  38854, -- Enchant Bracer - Superior Strength
  38855, -- Enchant Bracer - Superior Stamina
  38856, -- Enchant Gloves - Greater Agility
  38857, -- Enchant Gloves - Greater Strength
  38859, -- Enchant Cloak - Superior Defense
  38860, -- Enchant Shield - Vitality
  38861, -- Enchant Shield - Greater Stamina
  38862, -- Enchant Boots - Greater Stamina
  38863, -- Enchant Boots - Greater Agility
  38864, -- Enchant Boots - Versatility
  38865, -- Enchant Chest - Greater Stats
  38866, -- Enchant Chest - Major Health
  38867, -- Enchant Chest - Major Mana
  38868, -- Enchant Weapon - Icy Chill
  38869, -- Enchant 2H Weapon - Superior Impact
  38870, -- Enchant Weapon - Superior Striking
  38871, -- Enchant Weapon - Lifestealing
  38872, -- Enchant Weapon - Unholy Weapon
  38873, -- Enchant Weapon - Crusader
  38874, -- Enchant 2H Weapon - Major Versatility
  38875, -- Enchant 2H Weapon - Major Intellect
  38876, -- Enchant Weapon - Winter's Might
  38877, -- Enchant Weapon - Spellpower
  38878, -- Enchant Weapon - Healing Power
  38879, -- Enchant Weapon - Strength
  38880, -- Enchant Weapon - Agility
  38881, -- Enchant Bracer - Argent Versatility
  38882, -- Enchant Bracer - Healing Power
  38883, -- Enchant Weapon - Mighty Versatility
  38884, -- Enchant Weapon - Mighty Intellect
  38885, -- Enchant Gloves - Threat
  38886, -- Enchant Gloves - Shadow Power
  38887, -- Enchant Gloves - Frost Power
  38888, -- Enchant Gloves - Fire Power
  38889, -- Enchant Gloves - Healing Power
  38890, -- Enchant Gloves - Superior Agility
  38893, -- Enchant Cloak - Stealth
  38894, -- Enchant Cloak - Subtlety
  38895, -- Enchant Cloak - Dodge
  38896, -- Enchant 2H Weapon - Agility
  38897, -- Enchant Bracer - Brawn
  38898, -- Enchant Bracer - Stats
  38899, -- Enchant Bracer - Greater Dodge
  38900, -- Enchant Bracer - Superior Healing
  38901, -- Enchant Bracer - Versatility Prime
  38902, -- Enchant Bracer - Fortitude
  38903, -- Enchant Bracer - Spellpower
  38904, -- Enchant Shield - Lesser Dodge
  38905, -- Enchant Shield - Intellect
  38906, -- Enchant Shield - Parry
  38908, -- Enchant Boots - Vitality
  38909, -- Enchant Boots - Fortitude
  38910, -- Enchant Boots - Surefooted
  38911, -- Enchant Chest - Exceptional Health
  38912, -- Enchant Chest - Exceptional Mana
  38913, -- Enchant Chest - Exceptional Stats
  38914, -- Enchant Cloak - Major Armor
  38917, -- Enchant Weapon - Major Striking
  38918, -- Enchant Weapon - Major Intellect
  38919, -- Enchant 2H Weapon - Savagery
  38920, -- Enchant Weapon - Potency
  38921, -- Enchant Weapon - Major Spellpower
  38922, -- Enchant 2H Weapon - Major Agility
  38923, -- Enchant Weapon - Sunfire
  38924, -- Enchant Weapon - Soulfrost
  38925, -- Enchant Weapon - Mongoose
  38926, -- Enchant Weapon - Spellsurge
  38927, -- Enchant Weapon - Battlemaster
  38928, -- Enchant Chest - Major Versatility
  38929, -- Enchant Chest - Versatility Prime
  38930, -- Enchant Chest - Major Armor
  38931, -- Enchant Gloves - Blasting
  38932, -- Enchant Gloves - Precise Strikes
  38933, -- Enchant Gloves - Major Strength
  38934, -- Enchant Gloves - Assault
  38935, -- Enchant Gloves - Major Spellpower
  38936, -- Enchant Gloves - Major Healing
  38937, -- Enchant Bracer - Major Intellect
  38938, -- Enchant Bracer - Lesser Assault
  38939, -- Enchant Cloak - Empowerment
  38940, -- Enchant Cloak - Greater Agility
  38943, -- Enchant Boots - Cat's Swiftness
  38944, -- Enchant Boots - Boar's Speed
  38945, -- Enchant Shield - Major Stamina
  38946, -- Enchant Weapon - Major Healing
  38947, -- Enchant Weapon - Greater Agility
  38948, -- Enchant Weapon - Executioner
  38949, -- Enchant Shield - Armor
  38951, -- Enchant Gloves - Haste
  38953, -- Enchant Gloves - Precision
  38954, -- Enchant Shield - Dodge
  38955, -- Enchant Chest - Mighty Health
  38959, -- Enchant Cloak - Superior Agility
  38960, -- Enchant Gloves - Gatherer
  38961, -- Enchant Boots - Greater Versatility
  38962, -- Enchant Chest - Greater Versatility
  38963, -- Enchant Weapon - Exceptional Versatility
  38964, -- Enchant Gloves - Greater Assault
  38965, -- Enchant Weapon - Icebreaker
  38966, -- Enchant Boots - Greater Fortitude
  38967, -- Enchant Gloves - Major Agility
  38968, -- Enchant Bracer - Exceptional Intellect
  38971, -- Enchant Bracer - Assault
  38972, -- Enchant Weapon - Lifeward
  38973, -- Enchant Cloak - Minor Power
  38974, -- Enchant Boots - Greater Vitality
  38975, -- Enchant Chest - Exceptional Armor
  38976, -- Enchant Boots - Superior Agility
  38978, -- Enchant Cloak - Superior Dodge
  38979, -- Enchant Gloves - Exceptional Spellpower
  38980, -- Enchant Bracer - Major Versatility
  38981, -- Enchant 2H Weapon - Scourgebane
  38984, -- Enchant Bracer - Haste
  38986, -- Enchant Boots - Icewalker
  38987, -- Enchant Bracer - Greater Stats
  38988, -- Enchant Weapon - Giant Slayer
  38989, -- Enchant Chest - Super Stats
  38990, -- Enchant Gloves - Armsman
  38991, -- Enchant Weapon - Exceptional Spellpower
  38992, -- Enchant 2H Weapon - Greater Savagery
  38993, -- Enchant Cloak - Shadow Armor
  38995, -- Enchant Weapon - Exceptional Agility
  38997, -- Enchant Bracer - Greater Spellpower
  38998, -- Enchant Weapon - Deathfrost
  38999, -- Enchant Chest - Dodge
  39000, -- Enchant Cloak - Greater Dodge
  39001, -- Enchant Cloak - Mighty Stamina
  39002, -- Enchant Chest - Greater Dodge
  39003, -- Enchant Cloak - Greater Speed
  39004, -- Enchant Cloak - Wisdom
  39005, -- Enchant Chest - Super Health
  39006, -- Enchant Boots - Tuskarr's Vitality
  41146, -- Sun Scope
  41167, -- Heartseeker Scope
  41601, -- Shining Spellthread
  41602, -- Brilliant Spellthread
  41603, -- Azure Spellthread
  41604, -- Sapphire Spellthread
  41976, -- Titanium Weapon Chain
  42500, -- Titanium Shield Spike
  43987, -- Enchant Weapon - Black Magic
  44068, -- Inscription of Dominance
  44449, -- Enchant Boots - Assault
  44453, -- Enchant Weapon - Greater Potency
  44455, -- Shield Enchant - Greater Intellect
  44456, -- Enchant Cloak - Speed
  44457, -- Enchant Cloak - Major Agility
  44458, -- Enchant Gloves - Crusher
  44463, -- Enchant 2H Weapon - Massacre
  44465, -- Enchant Chest - Powerful Stats
  44466, -- Enchant Weapon - Superior Potency
  44467, -- Enchant Weapon - Mighty Spellpower
  44469, -- Enchant Boots - Greater Assault
  44470, -- Enchant Bracer - Superior Spellpower
  44493, -- Enchant Weapon - Berserking
  44497, -- Enchant Weapon - Accuracy
  44739, -- Diamond-Cut Refractor Scope
  44815, -- Enchant Bracer - Greater Assault
  44936, -- Titanium Plating
  44947, -- Enchant Bracer - Major Stamina
  44963, -- Earthen Leg Armor
  45056, -- Enchant Staff - Greater Spellpower
  45060, -- Enchant Staff - Spellpower
  45628, -- Enchant Boots - Lesser Accuracy
  46026, -- Enchant Weapon - Blade Ward
  46098, -- Enchant Weapon - Blood Draining
  50816, -- Enchant Gloves - Angler
}

-- Temporary Enhancements
database["TemporaryEnhancements"] = {
  46006, -- Glow Worm
}

-- Cloth
database["Cloth"] = {
  33470, -- Frostweave Cloth
  38426, -- Eternium Thread
  41510, -- Bolt of Frostweave
  41511, -- Bolt of Imbued Frostweave
  41593, -- Ebonweave
  41594, -- Moonshroud
  41595, -- Spellweave
  42253, -- Iceweb Spider Silk
}

-- Elemental
database["Elemental"] = {
  35622, -- Eternal Water
  35623, -- Eternal Air
  35624, -- Eternal Earth
  35625, -- Eternal Life
  35627, -- Eternal Shadow
  36860, -- Eternal Fire
  37700, -- Crystallized Air
  37701, -- Crystallized Earth
  37702, -- Crystallized Fire
  37703, -- Crystallized Shadow
  37704, -- Crystallized Life
  37705, -- Crystallized Water
}

-- Enchanting
database["Enchanting"] = {
  34052, -- Dream Shard
  34053, -- Small Dream Shard
  34054, -- Infinite Dust
  34055, -- Greater Cosmic Essence
  34056, -- Lesser Cosmic Essence
  34057, -- Abyss Crystal
}

-- Herbs
database["Herbs"] = {
  36901, -- Goldclover
  36903, -- Adder's Tongue
  36904, -- Tiger Lily
  36905, -- Lichbloom
  36906, -- Icethorn
  36907, -- Talandra's Rose
  36908, -- Frost Lotus
  37921, -- Deadnettle
  39970, -- Fire Leaf
}

-- Inscription
database["Inscription"] = {
  37140, -- Ace of Rogues
  37143, -- Two of Rogues
  37145, -- Ace of Swords
  37147, -- Two of Swords
  37156, -- Three of Rogues
  37159, -- Three of Swords
  37160, -- Four of Swords
  39151, -- Alabaster Pigment
  39334, -- Dusky Pigment
  39338, -- Golden Pigment
  39339, -- Emerald Pigment
  39340, -- Violet Pigment
  39341, -- Silvery Pigment
  39342, -- Nether Pigment
  39343, -- Azure Pigment
  39469, -- Moonglow Ink
  39774, -- Midnight Ink
  43103, -- Verdant Pigment
  43104, -- Burnt Pigment
  43105, -- Indigo Pigment
  43106, -- Ruby Pigment
  43107, -- Sapphire Pigment
  43108, -- Ebon Pigment
  43109, -- Icy Pigment
  43115, -- Hunter's Ink
  43116, -- Lion's Ink
  43117, -- Dawnstar Ink
  43118, -- Jadefire Ink
  43119, -- Royal Ink
  43120, -- Celestial Ink
  43121, -- Fiery Ink
  43122, -- Shimmering Ink
  43123, -- Ink of the Sky
  43124, -- Ethereal Ink
  43125, -- Darkflame Ink
  43126, -- Ink of the Sea
  43127, -- Snowfall Ink
  44143, -- Ace of Demons
  44144, -- Two of Mages
  44145, -- Three of Mages
  44146, -- Four of Mages
  44147, -- Five of Mages
  44154, -- Two of Demons
  44155, -- Three of Demons
  44156, -- Four of Demons
  44157, -- Five of Demons
  44165, -- Ace of Mages
  44260, -- Ace of Prisms
  44261, -- Two of Prisms
  44262, -- Three of Prisms
  44263, -- Four of Prisms
  44264, -- Five of Prisms
  44265, -- Six of Prisms
  44266, -- Seven of Prisms
  44267, -- Eight of Prisms
  44268, -- Ace of Nobles
  44269, -- Two of Nobles
  44270, -- Three of Nobles
  44271, -- Four of Nobles
  44272, -- Five of Nobles
  44273, -- Six of Nobles
  44274, -- Seven of Nobles
  44275, -- Eight of Nobles
  44277, -- Ace of Chaos
  44278, -- Two of Chaos
  44279, -- Three of Chaos
  44280, -- Four of Chaos
  44281, -- Five of Chaos
  44282, -- Six of Chaos
  44284, -- Seven of Chaos
  44285, -- Eight of Chaos
  44286, -- Ace of Undeath
  44287, -- Two of Undeath
  44288, -- Three of Undeath
  44289, -- Four of Undeath
  44290, -- Five of Undeath
  44291, -- Six of Undeath
  44292, -- Seven of Undeath
  44293, -- Eight of Undeath
}

-- Jewelcrafting
database["Jewelcrafting"] = {
  36783, -- Northsea Pearl
  36784, -- Siren's Tear
  36917, -- Bloodstone
  36918, -- Scarlet Ruby
  36919, -- Cardinal Ruby
  36920, -- Sun Crystal
  36921, -- Autumn's Glow
  36922, -- King's Amber
  36923, -- Chalcedony
  36924, -- Sky Sapphire
  36925, -- Majestic Zircon
  36926, -- Shadow Crystal
  36927, -- Twilight Opal
  36928, -- Dreadstone
  36929, -- Huge Citrine
  36930, -- Monarch Topaz
  36931, -- Ametrine
  36932, -- Dark Jade
  36933, -- Forest Emerald
  36934, -- Eye of Zul
  41266, -- Skyflare Diamond
  41334, -- Earthsiege Diamond
  42225, -- Dragon's Eye
  45054, -- Prismatic Black Diamond
  46849, -- Titanium Powder
}

-- Leather
database["Leather"] = {
  33567, -- Borean Leather Scraps
  33568, -- Borean Leather
  38425, -- Heavy Borean Leather
  38557, -- Icy Dragonscale
  38558, -- Nerubian Chitin
  38561, -- Jormungar Scale
  44128, -- Arctic Fur
}

-- Meat & Fish
database["MeatFish"] = {
  34736, -- Chunk o' Mammoth
  35794, -- Silvercoat Stag Meat
  36782, -- Succulent Clam Meat
  41800, -- Deep Sea Monsterbelly
  41801, -- Moonglow Cuttlefish
  41802, -- Imperial Manta Ray
  41803, -- Rockfin Grouper
  41805, -- Borean Man O' War
  41806, -- Musselback Sculpin
  41807, -- Dragonfin Angelfish
  41808, -- Bonescale Snapper
  41809, -- Glacial Salmon
  41810, -- Fangtooth Herring
  41812, -- Barrelhead Goby
  41813, -- Nettlefish
  41814, -- Glassfin Minnow
  43009, -- Shoveltusk Flank
  43010, -- Worm Meat
  43011, -- Worg Haunch
  43012, -- Rhino Meat
  43013, -- Chilled Meat
  43501, -- Northern Egg
  43571, -- Sewer Carp
  43572, -- Magic Eater
  43646, -- Fountain Goldfish
  43647, -- Shimmering Minnow
  43652, -- Slippery Eel
  44834, -- Wild Turkey
}

-- Metal & Stone
database["MetalStone"] = {
  36909, -- Cobalt Ore
  36910, -- Titanium Ore
  36912, -- Saronite Ore
  36913, -- Saronite Bar
  36916, -- Cobalt Bar
  37663, -- Titansteel Bar
  41163, -- Titanium Bar
}

-- Other Tradegoods
database["OtherTradegoods"] = {
  36781, -- Darkwater Clam
  37168, -- Mysterious Tarot
  38682, -- Enchanting Vellum
  39354, -- Light Parchment
  39501, -- Heavy Parchment
  40195, -- Pygmy Oil
  40199, -- Pygmy Suckerfish
  40411, -- Shattered Vial
  43007, -- Northern Spices
  43102, -- Frozen Orb
  44142, -- Strange Tarot
  44161, -- Arcane Tarot
  44163, -- Shadowy Tarot
  44316, -- Darkmoon Card
  44317, -- Greater Darkmoon Card
  44318, -- Darkmoon Card of the North
  44475, -- Reinforced Crate
  44700, -- Brooding Darkwater Clam
  44835, -- Autumnal Herbs
  44853, -- Honey
  44958, -- Ethereal Oil
  45087, -- Runed Orb
  45909, -- Giant Darkwater Clam
  46888, -- Bountiful Basket
  47556, -- Crusader Orb
  49908, -- Primordial Saronite
}

-- Parts
database["Parts"] = {
  39681, -- Handful of Cobalt Bolts
  39682, -- Overcharged Capacitor
  39683, -- Froststeel Tube
  39684, -- Hair Trigger
  39685, -- Indestructible Frame
  39686, -- Neo-Dynamic Gear Assembly
  39690, -- Volatile Blasting Trigger
  40533, -- Walnut Stock
  44499, -- Salvaged Iron Golem Parts
  44500, -- Elementium-Plated Exhaust Pipe
  44501, -- Goblin-Machined Piston
}

local function converttohex(rgb)
  return string.format("%02x%02x%02x", rgb.r * 255, rgb.g * 255, rgb.b * 255)
end

local function converttorgb(hex, as_table)
  if as_table then
    return {
      r = tonumber("0x" .. strsub(hex, 1, 2)) / 255,
      g = tonumber("0x" .. strsub(hex, 3, 4)) / 255,
      b = tonumber("0x" .. strsub(hex, 5, 6)) / 255,
    }
  else
    -- as 3 values
    return tonumber("0x" .. hex:sub(1, 2)) / 255,
      tonumber("0x" .. hex:sub(3, 4)) / 255,
      tonumber("0x" .. hex:sub(5, 6)) / 255
  end
end


local function formatBagTitle(self, title, hex)
  local prefix = ""
  if self.db.profile.prefixCategories then
    if self.db.profile.prefixCategories == "!CUSTOM" then
      prefix = self.db.profile.customPrefix
    else
      prefix = self.db.profile.prefixCategories
    end
  end
  if self.db.profile.coloredPrefix then
    prefix = "|cff" .. converttohex(self.db.profile.color.prefix) .. prefix .. "|r"
    if self.db.profile.coloredCategories then
      return prefix .. "|cff" .. hex .. title .. "|r"
    else
      return prefix .. title
    end
  else
    if self.db.profile.coloredCategories then
      return prefix .. "|cff" .. hex .. title .. "|r"
    else
      return prefix .. title
    end
  end
end

local function MatchIDs_Init(self)
  wipe(Result)

  if self.db.profile.moveMergedConsumables then
    Result[formatBagTitle(self, L["Consumables"], converttohex(self.db.profile.color.mergedConsumables))] =
      AddToSet(database["Bandages"], database["Consumables"], database["FoodsandDrinks"], database["OtherConsumables"])
  else
    if self.db.profile.moveBandages then
      Result[formatBagTitle(self, L["Bandages"], converttohex(self.db.profile.color.Bandages))] =
        AddToSet(database["Bandages"])
    end
    if self.db.profile.moveConsumables then
      Result[formatBagTitle(self, L["Consumables"], converttohex(self.db.profile.color.Consumables))] =
        AddToSet(database["Consumables"])
    end
    if self.db.profile.moveFoodsandDrinks then
      Result[formatBagTitle(self, L["Foods and Drinks"], converttohex(self.db.profile.color.FoodsandDrinks))] =
        AddToSet(database["FoodsandDrinks"])
    end
    if self.db.profile.moveOtherConsumables then
      Result[formatBagTitle(self, L["Other Consumables"], converttohex(self.db.profile.color.OtherConsumables))] =
        AddToSet(database["OtherConsumables"])
    end
  end
  if self.db.profile.moveMergedFlasksElixirsPotions then
    Result[formatBagTitle(
      self,
      L["Flasks, Elixirs & Potions"],
      converttohex(self.db.profile.color.mergedFlasksElixirsPotions)
    )] =
      AddToSet(database["Elixirs"], database["Flasks"], database["Potions"])
  else
    if self.db.profile.moveElixirs then
      Result[formatBagTitle(self, L["Elixirs"], converttohex(self.db.profile.color.Elixirs))] =
        AddToSet(database["Elixirs"])
    end
    if self.db.profile.moveFlasks then
      Result[formatBagTitle(self, L["Flasks"], converttohex(self.db.profile.color.Flasks))] =
        AddToSet(database["Flasks"])
    end
    if self.db.profile.movePotions then
      Result[formatBagTitle(self, L["Potions"], converttohex(self.db.profile.color.Potions))] =
        AddToSet(database["Potions"])
    end
  end
  if self.db.profile.moveMergedRecipes then
    Result[formatBagTitle(self, L["Recipes"], converttohex(self.db.profile.color.mergedRecipes))] = AddToSet(
      database["AlchemyRecipes"],
      database["BlacksmithingRecipes"],
      database["CookingRecipes"],
      database["EnchantingRecipes"],
      database["EngineeringRecipes"],
      database["InscriptionRecipes"],
      database["JewelcraftingRecipes"],
      database["LeatherworkingRecipes"],
      database["MiningRecipes"],
      database["TailoringRecipes"]
    )
  else
    if self.db.profile.moveAlchemyRecipes then
      Result[formatBagTitle(self, L["Alchemy Recipes"], converttohex(self.db.profile.color.AlchemyRecipes))] =
        AddToSet(database["AlchemyRecipes"])
    end
    if self.db.profile.moveBlacksmithingRecipes then
      Result[formatBagTitle(self, L["Blacksmithing Recipes"], converttohex(self.db.profile.color.BlacksmithingRecipes))] =
        AddToSet(database["BlacksmithingRecipes"])
    end
    if self.db.profile.moveCookingRecipes then
      Result[formatBagTitle(self, L["Cooking Recipes"], converttohex(self.db.profile.color.CookingRecipes))] =
        AddToSet(database["CookingRecipes"])
    end
    if self.db.profile.moveEnchantingRecipes then
      Result[formatBagTitle(self, L["Enchanting Recipes"], converttohex(self.db.profile.color.EnchantingRecipes))] =
        AddToSet(database["EnchantingRecipes"])
    end
    if self.db.profile.moveEngineeringRecipes then
      Result[formatBagTitle(self, L["Engineering Recipes"], converttohex(self.db.profile.color.EngineeringRecipes))] =
        AddToSet(database["EngineeringRecipes"])
    end
    if self.db.profile.moveInscriptionRecipes then
      Result[formatBagTitle(self, L["Inscription Recipes"], converttohex(self.db.profile.color.InscriptionRecipes))] =
        AddToSet(database["InscriptionRecipes"])
    end
    if self.db.profile.moveJewelcraftingRecipes then
      Result[formatBagTitle(self, L["Jewelcrafting Recipes"], converttohex(self.db.profile.color.JewelcraftingRecipes))] =
        AddToSet(database["JewelcraftingRecipes"])
    end
    if self.db.profile.moveLeatherworkingRecipes then
      Result[formatBagTitle(
        self,
        L["Leatherworking Recipes"],
        converttohex(self.db.profile.color.LeatherworkingRecipes)
      )] =
        AddToSet(database["LeatherworkingRecipes"])
    end
    if self.db.profile.moveMiningRecipes then
      Result[formatBagTitle(self, L["Mining Recipes"], converttohex(self.db.profile.color.MiningRecipes))] =
        AddToSet(database["MiningRecipes"])
    end
    if self.db.profile.moveTailoringRecipes then
      Result[formatBagTitle(self, L["Tailoring Recipes"], converttohex(self.db.profile.color.TailoringRecipes))] =
        AddToSet(database["TailoringRecipes"])
    end
  end
  if self.db.profile.moveMergedTemporaryPermanentEnhancements then
    Result[formatBagTitle(
      self,
      L["Temporary & Permanent Enhancements"],
      converttohex(self.db.profile.color.mergedTemporaryPermanentEnhancements)
    )] =
      AddToSet(database["Gems"], database["PermanentEnhancements"], database["TemporaryEnhancements"])
  else
    if self.db.profile.moveGems then
      Result[formatBagTitle(self, L["Gems"], converttohex(self.db.profile.color.Gems))] = AddToSet(database["Gems"])
    end
    if self.db.profile.movePermanentEnhancements then
      Result[formatBagTitle(
        self,
        L["Permanent Enhancements"],
        converttohex(self.db.profile.color.PermanentEnhancements)
      )] =
        AddToSet(database["PermanentEnhancements"])
    end
    if self.db.profile.moveTemporaryEnhancements then
      Result[formatBagTitle(
        self,
        L["Temporary Enhancements"],
        converttohex(self.db.profile.color.TemporaryEnhancements)
      )] =
        AddToSet(database["TemporaryEnhancements"])
    end
  end
  if self.db.profile.moveMergedTradegoods then
    Result[formatBagTitle(self, L["Tradegoods"], converttohex(self.db.profile.color.mergedTradegoods))] = AddToSet(
      database["Cloth"],
      database["Elemental"],
      database["Enchanting"],
      database["Herbs"],
      database["Inscription"],
      database["Jewelcrafting"],
      database["Leather"],
      database["MeatFish"],
      database["MetalStone"],
      database["OtherTradegoods"],
      database["Parts"]
    )
  else
    if self.db.profile.moveCloth then
      Result[formatBagTitle(self, L["Cloth"], converttohex(self.db.profile.color.Cloth))] = AddToSet(database["Cloth"])
    end
    if self.db.profile.moveElemental then
      Result[formatBagTitle(self, L["Elemental"], converttohex(self.db.profile.color.Elemental))] =
        AddToSet(database["Elemental"])
    end
    if self.db.profile.moveEnchanting then
      Result[formatBagTitle(self, L["Enchanting"], converttohex(self.db.profile.color.Enchanting))] =
        AddToSet(database["Enchanting"])
    end
    if self.db.profile.moveHerbs then
      Result[formatBagTitle(self, L["Herbs"], converttohex(self.db.profile.color.Herbs))] = AddToSet(database["Herbs"])
    end
    if self.db.profile.moveInscription then
      Result[formatBagTitle(self, L["Inscription"], converttohex(self.db.profile.color.Inscription))] =
        AddToSet(database["Inscription"])
    end
    if self.db.profile.moveJewelcrafting then
      Result[formatBagTitle(self, L["Jewelcrafting"], converttohex(self.db.profile.color.Jewelcrafting))] =
        AddToSet(database["Jewelcrafting"])
    end
    if self.db.profile.moveLeather then
      Result[formatBagTitle(self, L["Leather"], converttohex(self.db.profile.color.Leather))] =
        AddToSet(database["Leather"])
    end
    if self.db.profile.moveMeatFish then
      Result[formatBagTitle(self, L["Meat & Fish"], converttohex(self.db.profile.color.MeatFish))] =
        AddToSet(database["MeatFish"])
    end
    if self.db.profile.moveMetalStone then
      Result[formatBagTitle(self, L["Metal & Stone"], converttohex(self.db.profile.color.MetalStone))] =
        AddToSet(database["MetalStone"])
    end
    if self.db.profile.moveOtherTradegoods then
      Result[formatBagTitle(self, L["Other Tradegoods"], converttohex(self.db.profile.color.OtherTradegoods))] =
        AddToSet(database["OtherTradegoods"])
    end
    if self.db.profile.moveParts then
      Result[formatBagTitle(self, L["Parts"], converttohex(self.db.profile.color.Parts))] = AddToSet(database["Parts"])
    end
  end

  return Result
end

local setFilter = AdiBags:RegisterFilter("Wrath Of The Lich King", 98, "ABEvent-1.0")
setFilter.uiName = string.format("|cff00bcba%s|r", L["Wrath Of The Lich King"])
setFilter.uiDesc = string.format(
  "%s\n|cffffd800%s: 1.0.7|r",
  L["Items from the Wrath Of The Lich King expansion."],
  L["Filter version"]
)

function setFilter:OnInitialize()
  self.db = AdiBags.db:RegisterNamespace("Wrath Of The Lich King", {
    profile = {
      coloredCategories = true,
      prefixCategories = "",
      customPrefix = "",
      coloredPrefix = true,
      moveMergedConsumables = false,
      moveBandages = true,
      moveConsumables = true,
      moveFoodsandDrinks = true,
      moveOtherConsumables = true,
      moveMergedFlasksElixirsPotions = true,
      moveElixirs = true,
      moveFlasks = true,
      movePotions = true,
      moveMergedRecipes = true,
      moveAlchemyRecipes = true,
      moveBlacksmithingRecipes = true,
      moveCookingRecipes = true,
      moveEnchantingRecipes = true,
      moveEngineeringRecipes = true,
      moveInscriptionRecipes = true,
      moveJewelcraftingRecipes = true,
      moveLeatherworkingRecipes = true,
      moveMiningRecipes = true,
      moveTailoringRecipes = true,
      moveMergedTemporaryPermanentEnhancements = true,
      moveGems = true,
      movePermanentEnhancements = true,
      moveTemporaryEnhancements = true,
      moveMergedTradegoods = true,
      moveCloth = true,
      moveElemental = true,
      moveEnchanting = true,
      moveHerbs = true,
      moveInscription = true,
      moveJewelcrafting = true,
      moveLeather = true,
      moveMeatFish = true,
      moveMetalStone = true,
      moveOtherTradegoods = true,
      moveParts = true,

      color = {
        prefix = converttorgb("00bcba", true),
        mergedConsumables = converttorgb("7aa36f", true),
        Bandages = converttorgb("fff600", true),
        Consumables = converttorgb("49678d", true),
        FoodsandDrinks = converttorgb("9b59b6", true),
        OtherConsumables = converttorgb("4e878c", true),
        mergedFlasksElixirsPotions = converttorgb("769fb6", true),
        Elixirs = converttorgb("689a8c", true),
        Flasks = converttorgb("b60f96", true),
        Potions = converttorgb("9dbbae", true),
        mergedRecipes = converttorgb("68d080", true),
        AlchemyRecipes = converttorgb("4e9a06", true),
        BlacksmithingRecipes = converttorgb("8f8f8f", true),
        CookingRecipes = converttorgb("e9b96e", true),
        EnchantingRecipes = converttorgb("5c3566", true),
        EngineeringRecipes = converttorgb("c4a000", true),
        InscriptionRecipes = converttorgb("855c33", true),
        JewelcraftingRecipes = converttorgb("ad7fa8", true),
        LeatherworkingRecipes = converttorgb("8b4513", true),
        MiningRecipes = converttorgb("7f7f7f", true),
        TailoringRecipes = converttorgb("d3d7cf", true),
        mergedTemporaryPermanentEnhancements = converttorgb("5a7684", true),
        Gems = converttorgb("ff00ea", true),
        PermanentEnhancements = converttorgb("92afd7", true),
        TemporaryEnhancements = converttorgb("c5d1eb", true),
        mergedTradegoods = converttorgb("786f52", true),
        Cloth = converttorgb("feb95f", true),
        Elemental = converttorgb("c2095a", true),
        Enchanting = converttorgb("540d6e", true),
        Herbs = converttorgb("0ead69", true),
        Inscription = converttorgb("ffd23f", true),
        Jewelcrafting = converttorgb("090446", true),
        Leather = converttorgb("563635", true),
        MeatFish = converttorgb("f71735", true),
        MetalStone = converttorgb("6e9075", true),
        OtherTradegoods = converttorgb("81f0e5", true),
        Parts = converttorgb("5b6057", true),
      },
    },
  })
end

function setFilter:Update()
  MatchIDs = nil
  self:SendMessage("AdiBags_FiltersChanged")
end

function setFilter:OnEnable()
  AdiBags:UpdateFilters()
end

function setFilter:OnDisable()
  AdiBags:UpdateFilters()
end

function setFilter:Filter(slotData)
  MatchIDs = MatchIDs or MatchIDs_Init(self)
  for i, name in pairs(MatchIDs) do
    -- Override Method
    if MatchIDs[i]["override"] then
      slotData["loc"] = ItemLocation:CreateFromBagAndSlot(slotData.bag, slotData.slot)
      if slotData["loc"] and slotData["loc"]:IsValid() then
        if MatchIDs[i]["override"](slotData.loc) then
          return i
        end
      end

      -- Bonus Condition (triggers when bonus condition is not fulfilled)
    elseif MatchIDs[i]["bonus_condition"] then
      if name[slotData.itemId] then
        slotData["loc"] = ItemLocation:CreateFromBagAndSlot(slotData.bag, slotData.slot)
        if slotData["loc"] and slotData["loc"]:IsValid() then
          if not MatchIDs[i]["bonus_condition"](slotData.loc) then
            -- THERE IS A NOT HERE!
            return i
          end
        end
      end

      -- Standard ID Matching
    elseif name[slotData.itemId] then
      return i
    end
  end
end

function setFilter:GetOptions()
  return {
    general_config = {
      type = "group",
      name = L["General Settings"],
      desc = L["Settings affecting all categories."],
      inline = true,
      order = 1,
      args = {
        description = {
          type = "description",
          name = string.format(
            "%s |cffffd800%s |cff529F00%s|r",
            L["These settings affect all categories of this filter."],
            L["If you overwrite prefix or categorie color, you either need to toggle the color setting twice or reload."],
            L["AdiBags never intended to use icons, so they are glitchy. Make sure to disable prefix color, if you use an icon."]
          ),
          order = 1,
        },
        coloredCategories = {
          name = string.format("|cffFDFD96%s|r", L["Colored Categories"]),
          desc = L["Should Categories be colored?"],
          width = "full",
          type = "toggle",
          order = 10,
        },
        prefixCategories = {
          name = L["Prefix Categories"],
          desc = L["Select a prefix for the categories, if you like."],
          type = "select",
          order = 20,
          values = {
            [""] = L["None"],
            ["!CUSTOM"] = L["Custom Prefix"],
            ["W"] = "W",
            ["W-"] = "W-",
            ["2."] = "2.",
            ["WOTLK"] = "WOTLK",
            ["|T630787:" .. AdiBags.HEADER_SIZE .. ":" .. AdiBags.HEADER_SIZE .. ":-2:-10|t"] = "|T630787:"
              .. AdiBags.HEADER_SIZE
              .. "|t",
            ["|T341221:" .. AdiBags.HEADER_SIZE .. ":" .. AdiBags.HEADER_SIZE .. ":-2:-10|t"] = "|T341221:"
              .. AdiBags.HEADER_SIZE
              .. "|t",
            ["|T3573823:" .. AdiBags.HEADER_SIZE .. ":" .. AdiBags.HEADER_SIZE .. ":-2:-10|t"] = "|T3573823:"
              .. AdiBags.HEADER_SIZE
              .. "|t",
            ["|T236690:" .. AdiBags.HEADER_SIZE .. ":" .. AdiBags.HEADER_SIZE .. ":-2:-10|t"] = "|T236690:"
              .. AdiBags.HEADER_SIZE
              .. "|t",
            ["|T135771:" .. AdiBags.HEADER_SIZE .. ":" .. AdiBags.HEADER_SIZE .. ":-2:-10|t"] = "|T135771:"
              .. AdiBags.HEADER_SIZE
              .. "|t",
            ["|T625998:" .. AdiBags.HEADER_SIZE .. ":" .. AdiBags.HEADER_SIZE .. ":-2:-10|t"] = "|T625998:"
              .. AdiBags.HEADER_SIZE
              .. "|t",
          },
        },
        customPrefix = {
          name = L["Custom Prefix"],
          desc = L["Enter a custom prefix for the categories."],
          type = "input",
          order = 30,
          width = "full",
          disabled = function()
            return self.db.profile.prefixCategories ~= "!CUSTOM"
          end,
        },
        coloredPrefix = {
          name = string.format("|cffB9FFB9%s|r", L["Colored Prefix"]),
          desc = L["Should the prefix be colored to the filter color? (Only works for text-prefixes, for obvious reasons.)"],
          type = "toggle",
          order = 40,
        },
        prefixColor = {
          name = L["Prefix Color"],
          desc = L["Select a color for the prefix."],
          type = "color",
          order = 50,
          hasAlpha = false,
          disabled = function()
            return not self.db.profile.coloredPrefix
          end,
          get = function()
            local color = self.db.profile.color.prefix
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.prefix
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
      },
    },
    Consumables_config = {
      type = "group",
      name = L["Consumables"],
      desc = "", -- doesnt work,
      inline = true,
      order = 52,
      args = {
        Legendaries_desc = {
          type = "description",
          name = L["Items you can eat or use to improve yourself"],
          order = 53,
        },
        moveMergedConsumables = {
          name = string.format(L["%sMerge %s%s"], "|cffffd800", L["Consumables"], "|r"),
          desc = string.format(L["Merge all %s into a single category."], L["Consumables"]),
          type = "toggle",
          width = 1.5,
          order = 54,
        },
        colorMergedConsumables = {
          name = L["Color"],
          desc = string.format(L["Select a color for the merged %s category."], L["Consumables"]),
          type = "color",
          order = 55,
          hasAlpha = false,
          disabled = function()
            return not self.db.profile.moveMergedConsumables
          end,
          get = function()
            local color = self.db.profile.color.mergedConsumables
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.mergedConsumables
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_1 = {
          type = "header",
          name = "",
          order = 56,
        },
        moveBandages = {
          name = L["Bandages"],
          desc = L["Bandages to heal yourself."],
          type = "toggle",
          width = 1.5,
          order = 57,
          disabled = function()
            return self.db.profile.moveMergedConsumables
          end,
        },
        colorBandages = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Bandages"]),
          type = "color",
          order = 58,
          disabled = function()
            return self.db.profile.moveMergedConsumables
          end,
          get = function()
            local color = self.db.profile.color.Bandages
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.Bandages
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_2 = {
          type = "header",
          name = "",
          order = 59,
        },
        moveConsumables = {
          name = L["Consumables"],
          desc = L["Consumables to consume."],
          type = "toggle",
          width = 1.5,
          order = 60,
          disabled = function()
            return self.db.profile.moveMergedConsumables
          end,
        },
        colorConsumables = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Consumables"]),
          type = "color",
          order = 61,
          disabled = function()
            return self.db.profile.moveMergedConsumables
          end,
          get = function()
            local color = self.db.profile.color.Consumables
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.Consumables
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_3 = {
          type = "header",
          name = "",
          order = 62,
        },
        moveFoodsandDrinks = {
          name = L["Foods and Drinks"],
          desc = L["Foods and Drinks to consume."],
          type = "toggle",
          width = 1.5,
          order = 63,
          disabled = function()
            return self.db.profile.moveMergedConsumables
          end,
        },
        colorFoodsandDrinks = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Foods and Drinks"]),
          type = "color",
          order = 64,
          disabled = function()
            return self.db.profile.moveMergedConsumables
          end,
          get = function()
            local color = self.db.profile.color.FoodsandDrinks
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.FoodsandDrinks
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_4 = {
          type = "header",
          name = "",
          order = 65,
        },
        moveOtherConsumables = {
          name = L["Other Consumables"],
          desc = L["Other Consumables to consume."],
          type = "toggle",
          width = 1.5,
          order = 66,
          disabled = function()
            return self.db.profile.moveMergedConsumables
          end,
        },
        colorOtherConsumables = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Other Consumables"]),
          type = "color",
          order = 67,
          disabled = function()
            return self.db.profile.moveMergedConsumables
          end,
          get = function()
            local color = self.db.profile.color.OtherConsumables
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.OtherConsumables
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
      },
    },
    FlasksElixirsPotions_config = {
      type = "group",
      name = L["Flasks, Elixirs & Potions"],
      desc = "", -- doesnt work,
      inline = true,
      order = 68,
      args = {
        Legendaries_desc = {
          type = "description",
          name = L["Drink this for a powerup!"],
          order = 69,
        },
        moveMergedFlasksElixirsPotions = {
          name = string.format(L["%sMerge %s%s"], "|cffffd800", L["Flasks, Elixirs & Potions"], "|r"),
          desc = string.format(L["Merge all %s into a single category."], L["Flasks, Elixirs & Potions"]),
          type = "toggle",
          width = 1.5,
          order = 70,
        },
        colorMergedFlasksElixirsPotions = {
          name = L["Color"],
          desc = string.format(L["Select a color for the merged %s category."], L["Flasks, Elixirs & Potions"]),
          type = "color",
          order = 71,
          hasAlpha = false,
          disabled = function()
            return not self.db.profile.moveMergedFlasksElixirsPotions
          end,
          get = function()
            local color = self.db.profile.color.mergedFlasksElixirsPotions
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.mergedFlasksElixirsPotions
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_5 = {
          type = "header",
          name = "",
          order = 72,
        },
        moveElixirs = {
          name = L["Elixirs"],
          desc = L["Elixirs to drink."],
          type = "toggle",
          width = 1.5,
          order = 73,
          disabled = function()
            return self.db.profile.moveMergedFlasksElixirsPotions
          end,
        },
        colorElixirs = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Elixirs"]),
          type = "color",
          order = 74,
          disabled = function()
            return self.db.profile.moveMergedFlasksElixirsPotions
          end,
          get = function()
            local color = self.db.profile.color.Elixirs
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.Elixirs
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_6 = {
          type = "header",
          name = "",
          order = 75,
        },
        moveFlasks = {
          name = L["Flasks"],
          desc = L["Flasks to drink."],
          type = "toggle",
          width = 1.5,
          order = 76,
          disabled = function()
            return self.db.profile.moveMergedFlasksElixirsPotions
          end,
        },
        colorFlasks = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Flasks"]),
          type = "color",
          order = 77,
          disabled = function()
            return self.db.profile.moveMergedFlasksElixirsPotions
          end,
          get = function()
            local color = self.db.profile.color.Flasks
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.Flasks
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_7 = {
          type = "header",
          name = "",
          order = 78,
        },
        movePotions = {
          name = L["Potions"],
          desc = L["Potions to drink."],
          type = "toggle",
          width = 1.5,
          order = 79,
          disabled = function()
            return self.db.profile.moveMergedFlasksElixirsPotions
          end,
        },
        colorPotions = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Potions"]),
          type = "color",
          order = 80,
          disabled = function()
            return self.db.profile.moveMergedFlasksElixirsPotions
          end,
          get = function()
            local color = self.db.profile.color.Potions
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.Potions
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
      },
    },
    Recipes_config = {
      type = "group",
      name = L["Recipes"],
      desc = "", -- doesnt work,
      inline = true,
      order = 81,
      args = {
        Legendaries_desc = {
          type = "description",
          name = L["Recipes for all professions."],
          order = 82,
        },
        moveMergedRecipes = {
          name = string.format(L["%sMerge %s%s"], "|cffffd800", L["Recipes"], "|r"),
          desc = string.format(L["Merge all %s into a single category."], L["Recipes"]),
          type = "toggle",
          width = 1.5,
          order = 83,
        },
        colorMergedRecipes = {
          name = L["Color"],
          desc = string.format(L["Select a color for the merged %s category."], L["Recipes"]),
          type = "color",
          order = 84,
          hasAlpha = false,
          disabled = function()
            return not self.db.profile.moveMergedRecipes
          end,
          get = function()
            local color = self.db.profile.color.mergedRecipes
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.mergedRecipes
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_8 = {
          type = "header",
          name = "",
          order = 85,
        },
        moveAlchemyRecipes = {
          name = L["Alchemy Recipes"],
          desc = L["Recipes for crafting potions, elixirs, and transmuting materials."],
          type = "toggle",
          width = 1.5,
          order = 86,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
        },
        colorAlchemyRecipes = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Alchemy Recipes"]),
          type = "color",
          order = 87,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
          get = function()
            local color = self.db.profile.color.AlchemyRecipes
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.AlchemyRecipes
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_9 = {
          type = "header",
          name = "",
          order = 88,
        },
        moveBlacksmithingRecipes = {
          name = L["Blacksmithing Recipes"],
          desc = L["Recipes for forging metal armor, weapons, and enhancements."],
          type = "toggle",
          width = 1.5,
          order = 89,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
        },
        colorBlacksmithingRecipes = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Blacksmithing Recipes"]),
          type = "color",
          order = 90,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
          get = function()
            local color = self.db.profile.color.BlacksmithingRecipes
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.BlacksmithingRecipes
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_10 = {
          type = "header",
          name = "",
          order = 91,
        },
        moveCookingRecipes = {
          name = L["Cooking Recipes"],
          desc = L["Recipes for preparing food that provides buffs."],
          type = "toggle",
          width = 1.5,
          order = 92,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
        },
        colorCookingRecipes = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Cooking Recipes"]),
          type = "color",
          order = 93,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
          get = function()
            local color = self.db.profile.color.CookingRecipes
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.CookingRecipes
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_11 = {
          type = "header",
          name = "",
          order = 94,
        },
        moveEnchantingRecipes = {
          name = L["Enchanting Recipes"],
          desc = L["Recipes for enchanting gear with magical properties."],
          type = "toggle",
          width = 1.5,
          order = 95,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
        },
        colorEnchantingRecipes = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Enchanting Recipes"]),
          type = "color",
          order = 96,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
          get = function()
            local color = self.db.profile.color.EnchantingRecipes
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.EnchantingRecipes
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_12 = {
          type = "header",
          name = "",
          order = 97,
        },
        moveEngineeringRecipes = {
          name = L["Engineering Recipes"],
          desc = L["Recipes for creating gadgets, explosives, and mechanical devices."],
          type = "toggle",
          width = 1.5,
          order = 98,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
        },
        colorEngineeringRecipes = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Engineering Recipes"]),
          type = "color",
          order = 99,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
          get = function()
            local color = self.db.profile.color.EngineeringRecipes
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.EngineeringRecipes
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_13 = {
          type = "header",
          name = "",
          order = 100,
        },
        moveInscriptionRecipes = {
          name = L["Inscription Recipes"],
          desc = L["Recipes for scribing glyphs and crafting scrolls and tomes."],
          type = "toggle",
          width = 1.5,
          order = 101,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
        },
        colorInscriptionRecipes = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Inscription Recipes"]),
          type = "color",
          order = 102,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
          get = function()
            local color = self.db.profile.color.InscriptionRecipes
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.InscriptionRecipes
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_14 = {
          type = "header",
          name = "",
          order = 103,
        },
        moveJewelcraftingRecipes = {
          name = L["Jewelcrafting Recipes"],
          desc = L["Recipes for cutting gems and crafting jewelry."],
          type = "toggle",
          width = 1.5,
          order = 104,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
        },
        colorJewelcraftingRecipes = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Jewelcrafting Recipes"]),
          type = "color",
          order = 105,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
          get = function()
            local color = self.db.profile.color.JewelcraftingRecipes
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.JewelcraftingRecipes
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_15 = {
          type = "header",
          name = "",
          order = 106,
        },
        moveLeatherworkingRecipes = {
          name = L["Leatherworking Recipes"],
          desc = L["Recipes for crafting leather and mail armor."],
          type = "toggle",
          width = 1.5,
          order = 107,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
        },
        colorLeatherworkingRecipes = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Leatherworking Recipes"]),
          type = "color",
          order = 108,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
          get = function()
            local color = self.db.profile.color.LeatherworkingRecipes
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.LeatherworkingRecipes
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_16 = {
          type = "header",
          name = "",
          order = 109,
        },
        moveMiningRecipes = {
          name = L["Mining Recipes"],
          desc = L["Recipes for extracting ores and stones."],
          type = "toggle",
          width = 1.5,
          order = 110,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
        },
        colorMiningRecipes = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Mining Recipes"]),
          type = "color",
          order = 111,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
          get = function()
            local color = self.db.profile.color.MiningRecipes
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.MiningRecipes
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_17 = {
          type = "header",
          name = "",
          order = 112,
        },
        moveTailoringRecipes = {
          name = L["Tailoring Recipes"],
          desc = L["Recipes for weaving cloth armor and other cloth items."],
          type = "toggle",
          width = 1.5,
          order = 113,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
        },
        colorTailoringRecipes = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Tailoring Recipes"]),
          type = "color",
          order = 114,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
          get = function()
            local color = self.db.profile.color.TailoringRecipes
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.TailoringRecipes
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
      },
    },
    TemporaryPermanentEnhancements_config = {
      type = "group",
      name = L["Temporary & Permanent Enhancements"],
      desc = "", -- doesnt work,
      inline = true,
      order = 115,
      args = {
        Legendaries_desc = {
          type = "description",
          name = L["Use these for a powerup!"],
          order = 116,
        },
        moveMergedTemporaryPermanentEnhancements = {
          name = string.format(L["%sMerge %s%s"], "|cffffd800", L["Temporary & Permanent Enhancements"], "|r"),
          desc = string.format(L["Merge all %s into a single category."], L["Temporary & Permanent Enhancements"]),
          type = "toggle",
          width = 1.5,
          order = 117,
        },
        colorMergedTemporaryPermanentEnhancements = {
          name = L["Color"],
          desc = string.format(
            L["Select a color for the merged %s category."],
            L["Temporary & Permanent Enhancements"]
          ),
          type = "color",
          order = 118,
          hasAlpha = false,
          disabled = function()
            return not self.db.profile.moveMergedTemporaryPermanentEnhancements
          end,
          get = function()
            local color = self.db.profile.color.mergedTemporaryPermanentEnhancements
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.mergedTemporaryPermanentEnhancements
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_18 = {
          type = "header",
          name = "",
          order = 119,
        },
        moveGems = {
          name = L["Gems"],
          desc = L["These are gems that you can typically apply to armor to improve it."],
          type = "toggle",
          width = 1.5,
          order = 120,
          disabled = function()
            return self.db.profile.moveMergedTemporaryPermanentEnhancements
          end,
        },
        colorGems = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Gems"]),
          type = "color",
          order = 121,
          disabled = function()
            return self.db.profile.moveMergedTemporaryPermanentEnhancements
          end,
          get = function()
            local color = self.db.profile.color.Gems
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.Gems
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_19 = {
          type = "header",
          name = "",
          order = 122,
        },
        movePermanentEnhancements = {
          name = L["Permanent Enhancements"],
          desc = L["These are permanent enhancements that you can typically apply to armor to improve it."],
          type = "toggle",
          width = 1.5,
          order = 123,
          disabled = function()
            return self.db.profile.moveMergedTemporaryPermanentEnhancements
          end,
        },
        colorPermanentEnhancements = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Permanent Enhancements"]),
          type = "color",
          order = 124,
          disabled = function()
            return self.db.profile.moveMergedTemporaryPermanentEnhancements
          end,
          get = function()
            local color = self.db.profile.color.PermanentEnhancements
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.PermanentEnhancements
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_20 = {
          type = "header",
          name = "",
          order = 125,
        },
        moveTemporaryEnhancements = {
          name = L["Temporary Enhancements"],
          desc = L["These are temporary enhancements that you can typically apply to armor to improve it."],
          type = "toggle",
          width = 1.5,
          order = 126,
          disabled = function()
            return self.db.profile.moveMergedTemporaryPermanentEnhancements
          end,
        },
        colorTemporaryEnhancements = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Temporary Enhancements"]),
          type = "color",
          order = 127,
          disabled = function()
            return self.db.profile.moveMergedTemporaryPermanentEnhancements
          end,
          get = function()
            local color = self.db.profile.color.TemporaryEnhancements
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.TemporaryEnhancements
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
      },
    },
    Tradegoods_config = {
      type = "group",
      name = L["Tradegoods"],
      desc = "", -- doesnt work,
      inline = true,
      order = 128,
      args = {
        Legendaries_desc = {
          type = "description",
          name = L["Trading tradegoods is good. Trade tradegoods for good goods."],
          order = 129,
        },
        moveMergedTradegoods = {
          name = string.format(L["%sMerge %s%s"], "|cffffd800", L["Tradegoods"], "|r"),
          desc = string.format(L["Merge all %s into a single category."], L["Tradegoods"]),
          type = "toggle",
          width = 1.5,
          order = 130,
        },
        colorMergedTradegoods = {
          name = L["Color"],
          desc = string.format(L["Select a color for the merged %s category."], L["Tradegoods"]),
          type = "color",
          order = 131,
          hasAlpha = false,
          disabled = function()
            return not self.db.profile.moveMergedTradegoods
          end,
          get = function()
            local color = self.db.profile.color.mergedTradegoods
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.mergedTradegoods
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_21 = {
          type = "header",
          name = "",
          order = 132,
        },
        moveCloth = {
          name = L["Cloth"],
          desc = L["Cloth used in Tailoring."],
          type = "toggle",
          width = 1.5,
          order = 133,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorCloth = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Cloth"]),
          type = "color",
          order = 134,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
          get = function()
            local color = self.db.profile.color.Cloth
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.Cloth
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_22 = {
          type = "header",
          name = "",
          order = 135,
        },
        moveElemental = {
          name = L["Elemental"],
          desc = L["Elementals used in all professions."],
          type = "toggle",
          width = 1.5,
          order = 136,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorElemental = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Elemental"]),
          type = "color",
          order = 137,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
          get = function()
            local color = self.db.profile.color.Elemental
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.Elemental
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_23 = {
          type = "header",
          name = "",
          order = 138,
        },
        moveEnchanting = {
          name = L["Enchanting"],
          desc = L["Enchanting materials for enchanting weapons & armor."],
          type = "toggle",
          width = 1.5,
          order = 139,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorEnchanting = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Enchanting"]),
          type = "color",
          order = 140,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
          get = function()
            local color = self.db.profile.color.Enchanting
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.Enchanting
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_24 = {
          type = "header",
          name = "",
          order = 141,
        },
        moveHerbs = {
          name = L["Herbs"],
          desc = L["Herbs used in Alchemy & Inscription."],
          type = "toggle",
          width = 1.5,
          order = 142,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorHerbs = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Herbs"]),
          type = "color",
          order = 143,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
          get = function()
            local color = self.db.profile.color.Herbs
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.Herbs
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_25 = {
          type = "header",
          name = "",
          order = 144,
        },
        moveInscription = {
          name = L["Inscription"],
          desc = L["Inscription materials for creating glyphs or other paper related goods."],
          type = "toggle",
          width = 1.5,
          order = 145,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorInscription = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Inscription"]),
          type = "color",
          order = 146,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
          get = function()
            local color = self.db.profile.color.Inscription
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.Inscription
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_26 = {
          type = "header",
          name = "",
          order = 147,
        },
        moveJewelcrafting = {
          name = L["Jewelcrafting"],
          desc = L["Jewelcrafting materials for creating rings, necklaces, gems, etc."],
          type = "toggle",
          width = 1.5,
          order = 148,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorJewelcrafting = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Jewelcrafting"]),
          type = "color",
          order = 149,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
          get = function()
            local color = self.db.profile.color.Jewelcrafting
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.Jewelcrafting
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_27 = {
          type = "header",
          name = "",
          order = 150,
        },
        moveLeather = {
          name = L["Leather"],
          desc = L["Leather used in Leatherworking."],
          type = "toggle",
          width = 1.5,
          order = 151,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorLeather = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Leather"]),
          type = "color",
          order = 152,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
          get = function()
            local color = self.db.profile.color.Leather
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.Leather
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_28 = {
          type = "header",
          name = "",
          order = 153,
        },
        moveMeatFish = {
          name = L["Meat & Fish"],
          desc = L["Meat & Fish used in Cooking."],
          type = "toggle",
          width = 1.5,
          order = 154,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorMeatFish = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Meat & Fish"]),
          type = "color",
          order = 155,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
          get = function()
            local color = self.db.profile.color.MeatFish
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.MeatFish
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_29 = {
          type = "header",
          name = "",
          order = 156,
        },
        moveMetalStone = {
          name = L["Metal & Stone"],
          desc = L["Metal & Stone used in Blacksmithing."],
          type = "toggle",
          width = 1.5,
          order = 157,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorMetalStone = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Metal & Stone"]),
          type = "color",
          order = 158,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
          get = function()
            local color = self.db.profile.color.MetalStone
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.MetalStone
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_30 = {
          type = "header",
          name = "",
          order = 159,
        },
        moveOtherTradegoods = {
          name = L["Other Tradegoods"],
          desc = L["Other items used in various professions."],
          type = "toggle",
          width = 1.5,
          order = 160,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorOtherTradegoods = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Other Tradegoods"]),
          type = "color",
          order = 161,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
          get = function()
            local color = self.db.profile.color.OtherTradegoods
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.OtherTradegoods
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_31 = {
          type = "header",
          name = "",
          order = 162,
        },
        moveParts = {
          name = L["Parts"],
          desc = L["Parts used in Engineering."],
          type = "toggle",
          width = 1.5,
          order = 163,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorParts = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Parts"]),
          type = "color",
          order = 164,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
          get = function()
            local color = self.db.profile.color.Parts
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.Parts
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
      },
    },
  },
    AdiBags:GetOptionHandler(self, false, function()
      return self:Update()
    end)
end
