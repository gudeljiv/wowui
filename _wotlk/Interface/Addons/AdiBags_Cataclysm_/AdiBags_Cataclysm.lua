--[[
AdiBags - Cataclysm
by Zottelchen
version: 1.0.7
Items from the Cataclysm expansion.
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
  53049, -- Embersilk Bandage
  53050, -- Heavy Embersilk Bandage
  53051, -- Dense Embersilk Bandage
  63391, -- Baradin's Wardens Bandage
  64995, -- Hellscream's Reach Bandage
}

-- Consumables
database["Consumables"] = {
  60223, -- High-Powered Bolt Gun
  60853, -- Volatile Seaforium Blastpack
  63396, -- Big Daddy
  67494, -- Electrostatic Condenser
}

-- Foods and Drinks
database["FoodsandDrinks"] = {
  49253, -- Slightly Worm-Eaten Hardtack
  49254, -- Tarp Collected Dew
  49397, -- Half-Eaten Rat
  49600, -- Goblin Shortbread
  49601, -- Volcanic Spring Water
  49602, -- Earl Black Tea
  57518, -- Mr. Bubble's Shockingly Delicious Ice Cream
  57519, -- Cookie's Special Ramlette
  57543, -- Stormhammer Stout
  57544, -- Leftover Boar Meat
  58256, -- Sparkling Oasis Water
  58257, -- Highland Spring Water
  58258, -- Smoked String Cheese
  58259, -- Highland Sheep Cheese
  58260, -- Pine Nut Bread
  58261, -- Buttery Wheat Roll
  58262, -- Sliced Raw Billfish
  58263, -- Grilled Shark
  58264, -- Sour Green Apple
  58265, -- Highland Pomegranate
  58266, -- Violet Morel
  58267, -- Scarlet Polypore
  58268, -- Roasted Beef
  58269, -- Massive Turkey Leg
  58274, -- Fresh Water
  58275, -- Hardtack
  58276, -- Gilnean White
  58277, -- Simmered Squid
  58278, -- Tropical Sunfruit
  58279, -- Tasty Puffball
  58280, -- Stewed Rabbit
  58933, -- Westfall Mud Pie
  59029, -- Greasy Whale Milk
  59227, -- Rock-Hard Biscuit
  59228, -- Vile Purple Fungus
  59229, -- Murky Water
  59230, -- Fungus Squeezings
  59231, -- Oily Giblets
  59232, -- Unidentifiable Meat Dish
  60267, -- Country Pumpkin
  60268, -- Hobo Surprise
  60269, -- Well Water
  60375, -- Cheery Cherry Pie
  60376, -- Very Berry Pie
  60377, -- Lots 'o Meat Pie
  60378, -- Plumpkin Pie
  60379, -- Mud Pie
  60858, -- Goblin Barbecue
  61381, -- Yance's Special Burger Patty
  61382, -- Garr's Limeade
  61383, -- Garr's Key Lime Pie
  61384, -- Doublerum
  61982, -- Fizzy Fruit Wine
  61983, -- Imported E.K. Ale
  61984, -- Potent Pineapple Punch
  61985, -- Banana Cocktail
  61986, -- Tol Barad Coconut Rum
  62289, -- Broiled Dragon Feast
  62290, -- Seafood Magnifique Feast
  62649, -- Fortune Cookie
  62651, -- Lightly Fried Lurker
  62652, -- Seasoned Crab
  62653, -- Salted Eye
  62654, -- Lavascale Fillet
  62655, -- Broiled Mountain Trout
  62656, -- Whitecrest Gumbo
  62657, -- Lurker Lunch
  62658, -- Tender Baked Turtle
  62659, -- Hearty Seafood Soup
  62660, -- Pickled Guppy
  62661, -- Baked Rockfish
  62662, -- Grilled Dragon
  62663, -- Lavascale Minestrone
  62664, -- Crocolisk Au Gratin
  62665, -- Basilisk Liverdog
  62666, -- Delicious Sagefish Tail
  62667, -- Mushroom Sauce Mudfish
  62668, -- Blackbelly Sushi
  62669, -- Skewered Eel
  62670, -- Beer-Basted Crocolisk
  62671, -- Severed Sagefish Head
  62672, -- South Island Iced Tea
  62674, -- Highland Spirits
  62675, -- Starfire Espresso
  62676, -- Blackened Surprise
  62677, -- Fish Fry
  62680, -- Chocolate Cookie
  62790, -- Darkbrew Lager
  62908, -- Hair of the Dog
  62909, -- "Bear" Steaks
  63023, -- Sweet Tea
  63251, -- Mei's Masterful Brew
  63275, -- Gilnean Fortified Brandy
  63291, -- Blood Red Ale
  63292, -- Disgusting Rotgut
  63293, -- Blackheart Grog
  63296, -- Embalming Fluid
  63299, -- Sunkissed Wine
  63530, -- Refreshing Pineapple Punch
  63691, -- Brivelthwerp's Crunchy Ice Cream Bar
  63692, -- Frozen "Cream" Custard
  63693, -- Ooey Gooey Gelato
  63694, -- Silithid-Free Sorbet
  64639, -- Silversnap Ice
  64641, -- "Delicious" Worm Steak
  65499, -- Conjured Mana Cake
  65500, -- Conjured Mana Cookie
  65515, -- Conjured Mana Brownie
  65516, -- Conjured Mana Cupcake
  65517, -- Conjured Mana Lollipop
  65730, -- Stagwich
  65731, -- Yetichoke Hearts
  67230, -- Venison Jerky
  67270, -- Ursius Flank
  67271, -- Hell-Hoot Barbecue
  67272, -- Shy-Rotam Steak
  67273, -- Chillwind Omelet
  68140, -- Invigorating Pineapple Punch
  68687, -- Scalding Murglesnout
  69243, -- Ice Cream Cake Slice
  69244, -- Ice Cream Bar
  69920, -- Thrice-Spiced Crunchy Stew
  70924, -- Eternal Eye of Elune
  70925, -- Eternal Lunar Pear
  70926, -- Eternal Moonberry
  70927, -- Eternal Sunfruit
  73260, -- Salty Sea Dog
  74822, -- Sasparilla Sinker
  74921, -- Darkmoon Doughnut
  75027, -- Teldrassil Tenderloin
  75028, -- Stormwind Surprise
  75029, -- Beer-Basted Short Ribs
  75030, -- Gnomeregan Gnuggets
  75031, -- Draenic Dumplings
  75032, -- Mulgore Meat Pie
  75033, -- Green Ham & Eggs
  75034, -- Forsaken Foie Gras
  75035, -- Troll Tartare
  75036, -- Silvermoon Steak
}

-- Other Consumables
database["OtherConsumables"] = {
  46692, -- Elune's Torch
  46696, -- Panther Figurine
  46819, -- Black Mandrake
  48601, -- Red Rider Air Rifle Ammo
  49210, -- Goblin Male Mask
  49212, -- Goblin Female Mask
  49215, -- Worgen Female Mask
  49216, -- Worgen Male Mask
  49279, -- Grandma's Good Clothes
  49281, -- Chance the Cat
  49337, -- Shipwright's Tools
  49338, -- Planks of Wood
  49339, -- Coal Tar
  49649, -- Impaling Spine
  49749, -- Forgotten Dwarven Artifact
  49753, -- Coldridge Trail Bag
  49921, -- Unearthed Memento
  50017, -- Moonleaf
  50086, -- Mysterious Artifact
  50236, -- High Viscosity Coconut Milk
  50238, -- Cracked Un'Goro Coconut
  50253, -- Un'Goro Lasher Seed
  50258, -- Tarblossom Blossom
  50371, -- Silithid Leg
  50407, -- Enormous Dinosaur Talon
  50409, -- Spark's Fossil Finding Kit
  50410, -- Durrin's Archaeological Findings
  50443, -- Discarded Supplies
  50770, -- Ithis' Findings
  51546, -- A-Me 01's Thumb Drive
  51780, -- Small Rock
  51794, -- Maximillian's Armor
  52050, -- Elreth's Hand Mirror
  52051, -- Trail-Worn Scroll
  52066, -- Xavren's Thorn
  52067, -- Marrowpetal
  52068, -- Briny Sea Cucumber
  52077, -- Urgent Scarlet Memorandum
  52079, -- A Scarlet Letter
  52270, -- Plagued Bruin Hide
  52304, -- Fire Prism
  52361, -- Permission Slip
  52482, -- Agamand Memento
  52490, -- Stardust
  52558, -- Kul Tiras Treasure
  52564, -- Burning Blade Spellscroll
  52574, -- Mageweave Tether
  52580, -- Fizzle's Orb
  52685, -- Twilight Recruitment Papers
  52693, -- Forged Recruitment Papers
  52974, -- Mack's Deep Sea Grog
  53106, -- Amulet of Binding
  54442, -- Embersilk Net
  54461, -- Charred Staff Fragment
  54610, -- Spiked Basilisk Hide
  54905, -- Tome of Flame
  54906, -- The Burning Litanies
  54907, -- Ascendant's Codex
  54959, -- Elemental Fire Shard
  54960, -- Elemental Earth Shard
  54961, -- Elemental Water Shard
  54962, -- Elemental Air Shard
  54973, -- Young Twilight Drake Skull
  55053, -- Obsidium Skeleton Key
  55178, -- Pure Twilight Egg
  55826, -- Snickerfang Hyena Blood
  55827, -- Redstone Basilisk Blood
  55828, -- Ashmane Steak
  55829, -- Loramus' Head
  55836, -- Loramus' Torso
  55989, -- Charred Granite Chips
  55991, -- Vile Demonic Blood
  56017, -- Nethergarde Mine Report
  56019, -- Discordant Rune
  56824, -- Terrapin Oil Sample
  56825, -- Remora Oil Sample
  56826, -- Hammerhead Oil Sample
  56909, -- Earthen Ring Unbinding Totem
  57190, -- Barricade
  58142, -- Deathblood Venom
  58292, -- Faded Journal
  60364, -- Magmadar's Head
  60574, -- The Upper World Pillar Fragment
  60749, -- Ruby Horn
  60760, -- Plague Lurker Sample
  60761, -- Venom Mist Lurker Sample
  60762, -- Hulking Plaguebear Sample
  60763, -- Diseased Wolf Sample
  60814, -- Twilight Research Notes
  60816, -- Maziel's Research
  61971, -- Stone of the Sun
  62238, -- Origami Rock
  62239, -- Origami Slime
  62288, -- Cauldron of Battle
  62321, -- Lesser Inscription of Unbreakable Quartz
  62333, -- Greater Inscription of Unbreakable Quartz
  62342, -- Lesser Inscription of Charged Lodestone
  62343, -- Greater Inscription of Charged Lodestone
  62344, -- Lesser Inscription of Jagged Stone
  62345, -- Greater Inscription of Jagged Stone
  62346, -- Greater Inscription of Shattered Crystal
  62347, -- Lesser Inscription of Shattered Crystal
  62533, -- Ancient Tol'vir Armaments
  62795, -- Silversnap Swim Tonic
  62821, -- Neferset Armor
  63122, -- Lifegiving Seed
  63246, -- Origami Beetle
  63256, -- Hardened Crocolisk Hide
  63303, -- Scroll of Agility IX
  63304, -- Scroll of Strength IX
  63305, -- Scroll of Intellect IX
  63306, -- Scroll of Stamina IX
  63307, -- Scroll of Versatility IX
  63308, -- Scroll of Protection IX
  63359, -- Banner of Cooperation
  63376, -- Hellscream's Reach Battle Standard
  63377, -- Baradin's Wardens Battle Standard
  63517, -- Baradin's Wardens Commendation
  64352, -- Neferset Insignia
  64398, -- Standard of Unity
  64399, -- Battle Standard of Coordination
  64400, -- Banner of Cooperation
  64401, -- Standard of Unity
  64402, -- Battle Standard of Coordination
  64491, -- Royal Reward
  64642, -- Atulhet's Record Fragment
  64649, -- The Cypher of Keset
  65460, -- Big Cauldron of Battle
  65660, -- Grand Vizier Ertan's Heart
  67413, -- War of the Satyr
  68772, -- Greater Inscription of Vicious Intellect
  68773, -- Greater Inscription of Vicious Strength
  68774, -- Greater Inscription of Vicious Agility
  68809, -- Veteran's Hearthstone
  69187, -- Murloc Female Mask
  69188, -- Murloc Male Mask
  69189, -- Naga Female Mask
  69190, -- Naga Male Mask
  69192, -- Ogre Female Mask
  69193, -- Ogre Male Mask
  69194, -- Vrykul Female Mask
  69195, -- Vrykul Male Mask
  69724, -- Temple Rat
  70145, -- Darnassus Writ of Commendation
  70146, -- Exodar Writ of Commendation
  70147, -- Gnomeregan Writ of Commendation
  70148, -- Ironforge Writ of Commendation
  70149, -- Orgrimmar Writ of Commendation
  70150, -- Sen'jin Writ of Commendation
  70151, -- Silvermoon Writ of Commendation
  70152, -- Stormwind Writ of Commendation
  70153, -- Thunder Bluff Writ of Commendation
  70154, -- Undercity Writ of Commendation
  70725, -- Hallowed Hunter Wand - Squashling
  71083, -- Darkmoon Game Token
  71087, -- Gilneas Writ of Commendation
  71088, -- Bilgewater Writ of Commendation
  71153, -- Magical Pet Biscuit
  71627, -- Throwing Starfish
  71970, -- Darkmoon Prize Ticket
  74142, -- Darkmoon Firework
  74616, -- The Gatewatcher's Talisman
  77158, -- Darkmoon "Tiger"
  77957, -- Urgent Twilight Missive
}

-- Elixirs
database["Elixirs"] = {
  58084, -- Ghost Elixir
  58089, -- Elixir of the Naga
  58092, -- Elixir of the Cobra
  58093, -- Elixir of Deep Earth
  58094, -- Elixir of Impossible Accuracy
  58143, -- Prismatic Elixir
  58144, -- Elixir of Mighty Speed
  58148, -- Elixir of the Master
  64640, -- Infectis Puffer Sashimi
  78883, -- Darkmoon Firewater
}

-- Flasks
database["Flasks"] = {
  58085, -- Flask of Steelskin
  58086, -- Flask of the Draconic Mind
  58087, -- Flask of the Winds
  58088, -- Flask of Titanic Strength
  65455, -- Flask of Battle
  67438, -- Flask of Flowing Water
}

-- Potions
database["Potions"] = {
  54213, -- Molotov Cocktail
  57099, -- Mysterious Potion
  57191, -- Mythical Healing Potion
  57192, -- Mythical Mana Potion
  57193, -- Mighty Rejuvenation Potion
  57194, -- Potion of Concentration
  58090, -- Earthen Potion
  58091, -- Volcanic Potion
  58145, -- Potion of the Tol'vir
  58146, -- Golemblood Potion
  58487, -- Potion of Deepholm
  58488, -- Potion of Treasure Finding
  58489, -- Potion of Illusion
  63144, -- Baradin's Wardens Healing Potion
  63145, -- Baradin's Wardens Mana Potion
  63300, -- Rogue's Draught
  64993, -- Hellscream's Reach Mana Potion
  64994, -- Hellscream's Reach Healing Potion
  67415, -- Draught of War
}

-- Fortune Card
database["FortuneCard"] = {
  60839, -- Fortune Card
  60840, -- Fortune Card
  60841, -- Fortune Card
  60842, -- Fortune Card
  60843, -- Fortune Card
  60844, -- Fortune Card
  60845, -- Fortune Card
  62246, -- Fortune Card
  62247, -- Fortune Card
  62552, -- Fortune Card
  62553, -- Fortune Card
  62554, -- Fortune Card
  62555, -- Fortune Card
  62556, -- Fortune Card
  62557, -- Fortune Card
  62558, -- Fortune Card
  62559, -- Fortune Card
  62560, -- Fortune Card
  62561, -- Fortune Card
  62562, -- Fortune Card
  62563, -- Fortune Card
  62564, -- Fortune Card
  62565, -- Fortune Card
  62566, -- Fortune Card
  62567, -- Fortune Card
  62568, -- Fortune Card
  62569, -- Fortune Card
  62570, -- Fortune Card
  62571, -- Fortune Card
  62572, -- Fortune Card
  62573, -- Fortune Card
  62574, -- Fortune Card
  62575, -- Fortune Card
  62576, -- Fortune Card
  62577, -- Fortune Card
  62578, -- Fortune Card
  62579, -- Fortune Card
  62580, -- Fortune Card
  62581, -- Fortune Card
  62582, -- Fortune Card
  62583, -- Fortune Card
  62584, -- Fortune Card
  62585, -- Fortune Card
  62586, -- Fortune Card
  62587, -- Fortune Card
  62588, -- Fortune Card
  62589, -- Fortune Card
  62590, -- Fortune Card
  62591, -- Fortune Card
  62598, -- Fortune Card
  62599, -- Fortune Card
  62600, -- Fortune Card
  62601, -- Fortune Card
  62602, -- Fortune Card
  62603, -- Fortune Card
  62604, -- Fortune Card
  62605, -- Fortune Card
  62606, -- Fortune Card
}

-- Mysterious Fortune Card
database["MysteriousFortuneCard"] = {
  60838, -- Mysterious Fortune Card
}

-- Alchemy Recipes
database["AlchemyRecipes"] = {
  65435, -- Recipe: Cauldron of Battle
  65498, -- Recipe: Big Cauldron of Battle
  67538, -- Recipe: Vial of the Sands
  71955, -- Recipe: Transmute Deepholm Iolite
  71956, -- Recipe: Transmute Elven Peridot
  71957, -- Recipe: Transmute Lightstone
  71958, -- Recipe: Transmute Lava Coral
  71959, -- Recipe: Transmute Shadow Spinel
  71960, -- Recipe: Transmute Queen's Garnet
}

-- Blacksmithing Recipes
database["BlacksmithingRecipes"] = {
  66100, -- Plans: Ebonsteel Belt Buckle
  66101, -- Plans: Pyrium Shield Spike
  66103, -- Plans: Pyrium Weapon Chain
  66104, -- Plans: Hardened Elementium Hauberk
  66105, -- Plans: Hardened Elementium Girdle
  66106, -- Plans: Elementium Deathplate
  66107, -- Plans: Elementium Girdle of Pain
  66108, -- Plans: Light Elementium Chestguard
  66109, -- Plans: Light Elementium Belt
  66110, -- Plans: Elementium Spellblade
  66111, -- Plans: Elementium Hammer
  66112, -- Plans: Elementium Poleaxe
  66113, -- Plans: Elementium Bonesplitter
  66114, -- Plans: Elementium Shank
  66115, -- Plans: Elementium Earthguard
  66116, -- Plans: Elementium Stormshield
  66117, -- Plans: Vicious Pyrium Bracers
  66118, -- Plans: Vicious Pyrium Gauntlets
  66119, -- Plans: Vicious Pyrium Belt
  66120, -- Plans: Vicious Pyrium Boots
  66121, -- Plans: Vicious Pyrium Shoulders
  66122, -- Plans: Vicious Pyrium Legguards
  66123, -- Plans: Vicious Pyrium Helm
  66124, -- Plans: Vicious Pyrium Breastplate
  66125, -- Plans: Vicious Ornate Pyrium Bracers
  66126, -- Plans: Vicious Ornate Pyrium Gauntlets
  66127, -- Plans: Vicious Ornate Pyrium Belt
  66128, -- Plans: Vicious Ornate Pyrium Boots
  66129, -- Plans: Vicious Ornate Pyrium Shoulders
  66130, -- Plans: Vicious Ornate Pyrium Legguards
  66131, -- Plans: Vicious Ornate Pyrium Helm
  66132, -- Plans: Vicious Ornate Pyrium Breastplate
  66134, -- Plans: Elementium Rod
  67603, -- Plans: Elementium Gutslicer
  67606, -- Plans: Forged Elementium Mindcrusher
  69957, -- Plans: Fists of Fury
  69958, -- Plans: Eternal Elementium Handguards
  69959, -- Plans: Holy Flame Gauntlets
  69968, -- Plans: Warboots of Mighty Lords
  69969, -- Plans: Mirrored Boots
  69970, -- Plans: Emberforged Elementium Boots
  70166, -- Plans: Brainsplinter
  70167, -- Plans: Masterwork Elementium Spellblade
  70168, -- Plans: Lightforged Elementium Hammer
  70169, -- Plans: Elementium-Edged Scalper
  70170, -- Plans: Pyrium Spellward
  70171, -- Plans: Unbreakable Guardian
  70172, -- Plans: Masterwork Elementium Deathblade
  70173, -- Plans: Witch-Hunter's Harvester
  72001, -- Plans: Pyrium Legplates of Purified Evil
  72012, -- Plans: Unstoppable Destroyer's Legplates
  72013, -- Plans: Foundations of Courage
  72014, -- Plans: Soul Redeemer Bracers
  72015, -- Plans: Bracers of Destructive Strength
  72016, -- Plans: Titanguard Wristplates
  74274, -- Plans: Phantom Blade
}

-- Cooking Recipes
database["CookingRecipes"] = {
  62799, -- Recipe: Broiled Dragon Feast
  62800, -- Recipe: Seafood Magnifique Feast
  65406, -- Recipe: Whitecrest Gumbo
  65407, -- Recipe: Lavascale Fillet
  65408, -- Recipe: Feathered Lure
  65409, -- Recipe: Lavascale Minestrone
  65410, -- Recipe: Salted Eye
  65411, -- Recipe: Broiled Mountain Trout
  65412, -- Recipe: Lightly Fried Lurker
  65413, -- Recipe: Seasoned Crab
  65414, -- Recipe: Starfire Espresso
  65415, -- Recipe: Highland Spirits
  65416, -- Recipe: Lurker Lunch
  65417, -- Recipe: Pickled Guppy
  65418, -- Recipe: Hearty Seafood Soup
  65419, -- Recipe: Tender Baked Turtle
  65420, -- Recipe: Mushroom Sauce Mudfish
  65421, -- Recipe: Severed Sagefish Head
  65422, -- Recipe: Delicious Sagefish Tail
  65423, -- Recipe: Fish Fry
  65424, -- Recipe: Blackbelly Sushi
  65425, -- Recipe: Skewered Eel
  65426, -- Recipe: Baked Rockfish
  65427, -- Recipe: Basilisk Liverdog
  65428, -- Recipe: Grilled Dragon
  65429, -- Recipe: Beer-Basted Crocolisk
  65430, -- Recipe: Crocolisk Au Gratin
  65431, -- Recipe: Chocolate Cookie
  65432, -- Recipe: Fortune Cookie
  65433, -- Recipe: South Island Iced Tea
  68688, -- Recipe: Scalding Murglesnout
  78342, -- Plump Dig Rat
}

-- Enchanting Recipes
database["EnchantingRecipes"] = {
  52733, -- Formula: Enchant Weapon - Power Torrent
  52735, -- Formula: Enchant Weapon - Windwalk
  52736, -- Formula: Enchant Weapon - Landslide
  52737, -- Formula: Enchant Cloak - Greater Critical Strike
  52738, -- Formula: Enchant Bracer - Greater Critical Strike
  52739, -- Formula: Enchant Chest - Peerless Stats
  52740, -- Formula: Enchant Chest - Greater Stamina
  64411, -- Formula: Enchant Boots - Assassin's Step
  64412, -- Formula: Enchant Boots - Lavawalker
  64413, -- Formula: Enchant Bracer - Greater Speed
  64414, -- Formula: Enchant Gloves - Greater Mastery
  64415, -- Formula: Enchant Gloves - Mighty Strength
  67308, -- Formula: Enchanted Lantern
  67312, -- Formula: Magic Lamp
  68787, -- Formula: Enchant Bracer - Agility
  68788, -- Formula: Enchant Bracer - Major Strength
  68789, -- Formula: Enchant Bracer - Mighty Intellect
  71714, -- Formula: Enchant Cloak - Lesser Agility
  78343, -- Formula: Enchant Gloves - Herbalism
  78348, -- Formula: Enchant Weapon - Executioner
}

-- Engineering Recipes
database["EngineeringRecipes"] = {
  70177, -- Schematic: Flintlocke's Woodchucker
  71078, -- Schematic: Extreme-Impact Hole Puncher
}

-- Inscription Recipes
database["InscriptionRecipes"] = {
  65649, -- Technique: Origami Slime
  65650, -- Technique: Origami Rock
  65651, -- Technique: Origami Beetle
}

-- Jewelcrafting Recipes
database["JewelcraftingRecipes"] = {
  52362, -- Design: Bold Inferno Ruby
  52363, -- Design: Flashing Carnelian
  52364, -- Design: Stormy Zephyrite
  52365, -- Design: Subtle Alicite
  52366, -- Design: Defender's Nightstone
  52367, -- Design: Guardian's Nightstone
  52368, -- Design: Purified Nightstone
  52369, -- Design: Retaliating Nightstone
  52370, -- Design: Polished Hessonite
  52371, -- Design: Inscribed Hessonite
  52372, -- Design: Deadly Hessonite
  52373, -- Design: Potent Hessonite
  52374, -- Design: Fierce Hessonite
  52375, -- Design: Deft Hessonite
  52376, -- Design: Fine Hessonite
  52377, -- Design: Keen Hessonite
  52378, -- Design: Regal Jasper
  52379, -- Design: Nimble Jasper
  52380, -- Design: Delicate Inferno Ruby
  52381, -- Design: Bold Chimera's Eye
  52382, -- Design: Piercing Jasper
  52383, -- Design: Steady Jasper
  52384, -- Design: Flashing Inferno Ruby
  52385, -- Design: Forceful Jasper
  52386, -- Design: Lightning Jasper
  52387, -- Design: Brilliant Inferno Ruby
  52388, -- Design: Zen Jasper
  52389, -- Design: Precise Inferno Ruby
  52390, -- Design: Solid Ocean Sapphire
  52391, -- Design: Sparkling Ocean Sapphire
  52392, -- Design: Stormy Ocean Sapphire
  52393, -- Design: Rigid Ocean Sapphire
  52394, -- Design: Subtle Amberjewel
  52395, -- Design: Smooth Amberjewel
  52396, -- Design: Mystic Amberjewel
  52397, -- Design: Quick Amberjewel
  52398, -- Design: Fractured Amberjewel
  52399, -- Design: Sovereign Demonseye
  52400, -- Design: Shifting Demonseye
  52401, -- Design: Defender's Demonseye
  52402, -- Design: Timeless Demonseye
  52403, -- Design: Guardian's Demonseye
  52404, -- Design: Purified Demonseye
  52405, -- Design: Etched Demonseye
  52406, -- Design: Glinting Demonseye
  52407, -- Design: Retaliating Demonseye
  52408, -- Design: Veiled Demonseye
  52409, -- Design: Accurate Demonseye
  52410, -- Design: Polished Ember Topaz
  52411, -- Design: Resolute Ember Topaz
  52412, -- Design: Inscribed Ember Topaz
  52413, -- Design: Deadly Ember Topaz
  52414, -- Design: Potent Ember Topaz
  52415, -- Design: Fierce Ember Topaz
  52416, -- Design: Deft Ember Topaz
  52417, -- Design: Reckless Ember Topaz
  52418, -- Design: Skillful Ember Topaz
  52419, -- Design: Adept Ember Topaz
  52420, -- Design: Fine Ember Topaz
  52421, -- Design: Artful Ember Topaz
  52422, -- Design: Keen Ember Topaz
  52423, -- Design: Regal Dream Emerald
  52424, -- Design: Nimble Dream Emerald
  52425, -- Design: Jagged Dream Emerald
  52426, -- Design: Piercing Dream Emerald
  52427, -- Design: Steady Dream Emerald
  52428, -- Design: Forceful Dream Emerald
  52429, -- Design: Lightning Dream Emerald
  52430, -- Design: Puissant Dream Emerald
  52431, -- Design: Zen Dream Emerald
  52432, -- Design: Sensei's Dream Emerald
  52433, -- Design: Fleet Shadowspirit Diamond
  52434, -- Design: Chaotic Shadowspirit Diamond
  52435, -- Design: Bracing Shadowspirit Diamond
  52436, -- Design: Eternal Shadowspirit Diamond
  52437, -- Design: Austere Shadowspirit Diamond
  52438, -- Design: Effulgent Shadowspirit Diamond
  52439, -- Design: Ember Shadowspirit Diamond
  52440, -- Design: Revitalizing Shadowspirit Diamond
  52441, -- Design: Destructive Shadowspirit Diamond
  52442, -- Design: Powerful Shadowspirit Diamond
  52443, -- Design: Enigmatic Shadowspirit Diamond
  52444, -- Design: Impassive Shadowspirit Diamond
  52445, -- Design: Forlorn Shadowspirit Diamond
  52447, -- Design: Delicate Chimera's Eye
  52448, -- Design: Flashing Chimera's Eye
  52449, -- Design: Brilliant Chimera's Eye
  52450, -- Design: Precise Chimera's Eye
  52451, -- Design: Solid Chimera's Eye
  52452, -- Design: Sparkling Chimera's Eye
  52453, -- Design: Stormy Chimera's Eye
  52454, -- Design: Rigid Chimera's Eye
  52455, -- Design: Subtle Chimera's Eye
  52456, -- Design: Smooth Chimera's Eye
  52457, -- Design: Mystic Chimera's Eye
  52458, -- Design: Quick Chimera's Eye
  52459, -- Design: Fractured Chimera's Eye
  52460, -- Design: Elementium Destroyer's Ring
  52461, -- Design: Band of Blades
  52462, -- Design: Ring of Warring Elements
  52463, -- Design: Elementium Moebius Band
  52464, -- Design: Brazen Elementium Medallion
  52465, -- Design: Entwined Elementium Choker
  52466, -- Design: Eye of Many Deaths
  52467, -- Design: Elementium Guardian
  52494, -- Design: Jeweler's Ruby Monocle
  52495, -- Design: Jeweler's Sapphire Monocle
  52496, -- Design: Jeweler's Amber Monocle
  68359, -- Design: Willful Ember Topaz
  68360, -- Design: Lucent Ember Topaz
  68361, -- Design: Resplendent Ember Topaz
  68742, -- Design: Vivid Dream Emerald
  68781, -- Design: Agile Shadowspirit Diamond
  68782, -- Design: Reverberating Shadowspirit Diamond
  68783, -- Design: Burning Shadowspirit Diamond
  69820, -- Design: Reckless Hessonite
  69853, -- Design: Punisher's Band
  71821, -- Design: Rigid Deepholm Iolite
  71884, -- Design: Stormy Deepholm Iolite
  71885, -- Design: Sparkling Deepholm Iolite
  71886, -- Design: Solid Deepholm Iolite
  71887, -- Design: Misty Elven Peridot
  71888, -- Design: Piercing Elven Peridot
  71889, -- Design: Lightning Elven Peridot
  71890, -- Design: Sensei's Elven Peridot
  71891, -- Design: Infused Elven Peridot
  71892, -- Design: Zen Elven Peridot
  71893, -- Design: Balanced Elven Peridot
  71894, -- Design: Vivid Elven Peridot
  71895, -- Design: Turbid Elven Peridot
  71896, -- Design: Radiant Elven Peridot
  71897, -- Design: Shattered Elven Peridot
  71898, -- Design: Energized Elven Peridot
  71899, -- Design: Jagged Elven Peridot
  71900, -- Design: Regal Elven Peridot
  71901, -- Design: Forceful Elven Peridot
  71902, -- Design: Nimble Elven Peridot
  71903, -- Design: Puissant Elven Peridot
  71904, -- Design: Steady Elven Peridot
  71905, -- Design: Deadly Lava Coral
  71906, -- Design: Crafty Lava Coral
  71907, -- Design: Potent Lava Coral
  71908, -- Design: Inscribed Lava Coral
  71909, -- Design: Polished Lava Coral
  71910, -- Design: Resolute Lava Coral
  71911, -- Design: Stalwart Lava Coral
  71912, -- Design: Champion's Lava Coral
  71913, -- Design: Deft Lava Coral
  71914, -- Design: Wicked Lava Coral
  71915, -- Design: Reckless Lava Coral
  71916, -- Design: Fierce Lava Coral
  71917, -- Design: Adept Lava Coral
  71918, -- Design: Keen Lava Coral
  71919, -- Design: Artful Lava Coral
  71920, -- Design: Fine Lava Coral
  71921, -- Design: Skillful Lava Coral
  71922, -- Design: Lucent Lava Coral
  71923, -- Design: Tenuous Lava Coral
  71924, -- Design: Willful Lava Coral
  71925, -- Design: Splendid Lava Coral
  71926, -- Design: Resplendent Lava Coral
  71927, -- Design: Glinting Shadow Spinel
  71928, -- Design: Accurate Shadow Spinel
  71929, -- Design: Veiled Shadow Spinel
  71930, -- Design: Retaliating Shadow Spinel
  71931, -- Design: Etched Shadow Spinel
  71932, -- Design: Mysterious Shadow Spinel
  71933, -- Design: Purified Shadow Spinel
  71934, -- Design: Shifting Shadow Spinel
  71935, -- Design: Guardian's Shadow Spinel
  71936, -- Design: Timeless Shadow Spinel
  71937, -- Design: Defender's Shadow Spinel
  71938, -- Design: Sovereign Shadow Spinel
  71939, -- Design: Delicate Queen's Garnet
  71940, -- Design: Precise Queen's Garnet
  71941, -- Design: Brilliant Queen's Garnet
  71942, -- Design: Flashing Queen's Garnet
  71943, -- Design: Bold Queen's Garnet
  71944, -- Design: Smooth Lightstone
  71945, -- Design: Subtle Lightstone
  71946, -- Design: Quick Lightstone
  71947, -- Design: Fractured Lightstone
  71948, -- Design: Mystic Lightstone
  71965, -- Design: Rhinestone Sunglasses
}

-- Leatherworking Recipes
database["LeatherworkingRecipes"] = {
  67042, -- Pattern: Vicious Wyrmhide Bracers
  67044, -- Pattern: Vicious Wyrmhide Belt
  67046, -- Pattern: Vicious Leather Bracers
  67048, -- Pattern: Vicious Leather Gloves
  67049, -- Pattern: Vicious Charscale Bracers
  67053, -- Pattern: Vicious Charscale Gloves
  67054, -- Pattern: Vicious Dragonscale Bracers
  67055, -- Pattern: Vicious Dragonscale Shoulders
  67056, -- Pattern: Vicious Wyrmhide Gloves
  67058, -- Pattern: Vicious Wyrmhide Boots
  67060, -- Pattern: Vicious Leather Boots
  67062, -- Pattern: Vicious Leather Shoulders
  67063, -- Pattern: Vicious Charscale Boots
  67064, -- Pattern: Vicious Charscale Belt
  67065, -- Pattern: Vicious Dragonscale Boots
  67066, -- Pattern: Vicious Dragonscale Gloves
  67068, -- Pattern: Lightning Lash
  67070, -- Pattern: Belt of Nefarious Whispers
  67072, -- Pattern: Stormleather Sash
  67073, -- Pattern: Corded Viper Belt
  67074, -- Pattern: Vicious Wyrmhide Shoulders
  67075, -- Pattern: Vicious Wyrmhide Chest
  67076, -- Pattern: Vicious Leather Belt
  67077, -- Pattern: Vicious Leather Helm
  67078, -- Pattern: Vicious Charscale Shoulders
  67079, -- Pattern: Vicious Charscale Legs
  67080, -- Pattern: Vicious Dragonscale Belt
  67081, -- Pattern: Vicious Dragonscale Helm
  67082, -- Pattern: Razor-Edged Cloak
  67083, -- Pattern: Twilight Dragonscale Cloak
  67084, -- Pattern: Charscale Leg Armor
  67085, -- Pattern: Vicious Wyrmhide Legs
  67086, -- Pattern: Vicious Wyrmhide Helm
  67087, -- Pattern: Vicious Leather Chest
  67089, -- Pattern: Vicious Leather Legs
  67090, -- Pattern: Vicious Charscale Chest
  67091, -- Pattern: Vicious Charscale Helm
  67092, -- Pattern: Vicious Dragonscale Legs
  67093, -- Pattern: Vicious Dragonscale Chest
  67094, -- Pattern: Chestguard of Nature's Fury
  67095, -- Pattern: Assassin's Chestplate
  67096, -- Pattern: Twilight Scale Chestguard
  67100, -- Pattern: Dragonkiller Tunic
  68193, -- Pattern: Dragonscale Leg Armor
  69960, -- Pattern: Dragonfire Gloves
  69961, -- Pattern: Gloves of Unforgiving Flame
  69962, -- Pattern: Clutches of Evil
  69963, -- Pattern: Heavenly Gloves of the Moon
  69971, -- Pattern: Earthen Scale Sabatons
  69972, -- Pattern: Footwraps of Quenched Fire
  69973, -- Pattern: Treads of the Craft
  69974, -- Pattern: Ethereal Footfalls
  70174, -- Pattern: Royal Scribe's Satchel
  70175, -- Pattern: Triple-Reinforced Mining Bag
  71721, -- Pattern: Drakehide Leg Armor
  71999, -- Pattern: Leggings of Nature's Champion
  72005, -- Pattern: Deathscale Leggings
  72006, -- Pattern: Bladeshadow Leggings
  72007, -- Pattern: Rended Earth Leggings
  72008, -- Pattern: Bracers of Flowing Serenity
  72009, -- Pattern: Thundering Deathscale Wristguards
  72010, -- Pattern: Bladeshadow Wristguards
  72011, -- Pattern: Bracers of the Hunter-Killer
  72025, -- Pattern: Tough Scorpid Gloves
  72026, -- Pattern: Tough Scorpid Bracers
  72027, -- Pattern: Tough Scorpid Shoulders
  72028, -- Pattern: Tough Scorpid Boots
  72029, -- Pattern: Tough Scorpid Breastplate
  72030, -- Pattern: Tough Scorpid Leggings
  72033, -- Pattern: Tough Scorpid Helm
  78345, -- Pattern: Green Dragonscale Leggings
  78346, -- Pattern: Green Dragonscale Breastplate
}

-- Tailoring Recipes
database["TailoringRecipes"] = {
  54593, -- Pattern: Vicious Embersilk Cowl
  54594, -- Pattern: Vicious Embersilk Pants
  54595, -- Pattern: Vicious Embersilk Robe
  54596, -- Pattern: Vicious Fireweave Cowl
  54597, -- Pattern: Vicious Fireweave Pants
  54598, -- Pattern: Vicious Fireweave Robe
  54599, -- Pattern: Powerful Enchanted Spellthread
  54600, -- Pattern: Powerful Ghostly Spellthread
  54601, -- Pattern: Belt of the Depths
  54602, -- Pattern: Dreamless Belt
  54603, -- Pattern: Breeches of Mended Nightmares
  54604, -- Pattern: Flame-Ascended Pantaloons
  54605, -- Pattern: Illusionary Bag
  67541, -- Pattern: High Society Top Hat
  68199, -- Pattern: Black Embersilk Gown
  69965, -- Pattern: Grips of Altered Reality
  69966, -- Pattern: Don Tayo's Inferno Mittens
  69975, -- Pattern: Endless Dream Walkers
  69976, -- Pattern: Boots of the Black Flame
  70176, -- Pattern: Luxurious Silk Gem Bag
  72000, -- Pattern: World Mender's Pants
  72002, -- Pattern: Lavaquake Legwraps
  72003, -- Pattern: Dreamwraps of the Light
  72004, -- Pattern: Bracers of Unconquered Power
}

-- Gems
database["Gems"] = {
  52081, -- Bold Carnelian
  52082, -- Delicate Carnelian
  52083, -- Flashing Carnelian
  52084, -- Brilliant Carnelian
  52085, -- Precise Carnelian
  52086, -- Solid Zephyrite
  52087, -- Sparkling Zephyrite
  52088, -- Stormy Zephyrite
  52089, -- Rigid Zephyrite
  52090, -- Subtle Alicite
  52091, -- Smooth Alicite
  52092, -- Mystic Alicite
  52093, -- Quick Alicite
  52094, -- Fractured Alicite
  52095, -- Sovereign Nightstone
  52096, -- Shifting Nightstone
  52097, -- Defender's Nightstone
  52098, -- Timeless Nightstone
  52099, -- Guardian's Nightstone
  52100, -- Purified Nightstone
  52101, -- Etched Nightstone
  52102, -- Glinting Nightstone
  52103, -- Retaliating Nightstone
  52104, -- Veiled Nightstone
  52105, -- Accurate Nightstone
  52106, -- Polished Hessonite
  52107, -- Resolute Hessonite
  52108, -- Inscribed Hessonite
  52109, -- Deadly Hessonite
  52110, -- Potent Hessonite
  52111, -- Fierce Hessonite
  52112, -- Deft Hessonite
  52113, -- Reckless Hessonite
  52114, -- Skillful Hessonite
  52115, -- Adept Hessonite
  52116, -- Fine Hessonite
  52117, -- Artful Hessonite
  52118, -- Keen Hessonite
  52119, -- Regal Jasper
  52120, -- Nimble Jasper
  52121, -- Jagged Jasper
  52122, -- Piercing Jasper
  52123, -- Steady Jasper
  52124, -- Forceful Jasper
  52125, -- Lightning Jasper
  52126, -- Puissant Jasper
  52127, -- Zen Jasper
  52128, -- Sensei's Jasper
  52129, -- Perfect Sensei's Jasper
  52130, -- Perfect Zen Jasper
  52131, -- Perfect Puissant Jasper
  52132, -- Perfect Lightning Jasper
  52133, -- Perfect Forceful Jasper
  52134, -- Perfect Steady Jasper
  52135, -- Perfect Piercing Jasper
  52136, -- Perfect Jagged Jasper
  52137, -- Perfect Nimble Jasper
  52138, -- Perfect Regal Jasper
  52139, -- Perfect Keen Hessonite
  52140, -- Perfect Artful Hessonite
  52141, -- Perfect Fine Hessonite
  52142, -- Perfect Adept Hessonite
  52143, -- Perfect Skillful Hessonite
  52144, -- Perfect Reckless Hessonite
  52145, -- Perfect Deft Hessonite
  52146, -- Perfect Fierce Hessonite
  52147, -- Perfect Potent Hessonite
  52148, -- Perfect Deadly Hessonite
  52149, -- Perfect Inscribed Hessonite
  52150, -- Perfect Resolute Hessonite
  52151, -- Perfect Polished Hessonite
  52152, -- Perfect Accurate Nightstone
  52153, -- Perfect Veiled Nightstone
  52154, -- Perfect Retaliating Nightstone
  52155, -- Perfect Glinting Nightstone
  52156, -- Perfect Etched Nightstone
  52157, -- Perfect Purified Nightstone
  52158, -- Perfect Guardian's Nightstone
  52159, -- Perfect Timeless Nightstone
  52160, -- Perfect Defender's Nightstone
  52161, -- Perfect Shifting Nightstone
  52162, -- Perfect Sovereign Nightstone
  52163, -- Perfect Fractured Alicite
  52164, -- Perfect Quick Alicite
  52165, -- Perfect Mystic Alicite
  52166, -- Perfect Smooth Alicite
  52167, -- Perfect Subtle Alicite
  52168, -- Perfect Rigid Zephyrite
  52169, -- Perfect Stormy Zephyrite
  52170, -- Perfect Sparkling Zephyrite
  52171, -- Perfect Solid Zephyrite
  52172, -- Perfect Precise Carnelian
  52173, -- Perfect Brilliant Carnelian
  52174, -- Perfect Flashing Carnelian
  52175, -- Perfect Delicate Carnelian
  52176, -- Perfect Bold Carnelian
  52203, -- Accurate Demonseye
  52204, -- Adept Ember Topaz
  52205, -- Artful Ember Topaz
  52206, -- Bold Inferno Ruby
  52207, -- Brilliant Inferno Ruby
  52208, -- Reckless Ember Topaz
  52209, -- Deadly Ember Topaz
  52210, -- Defender's Demonseye
  52211, -- Deft Ember Topaz
  52212, -- Delicate Inferno Ruby
  52213, -- Etched Demonseye
  52214, -- Fierce Ember Topaz
  52215, -- Fine Ember Topaz
  52216, -- Flashing Inferno Ruby
  52217, -- Veiled Demonseye
  52218, -- Forceful Dream Emerald
  52219, -- Fractured Amberjewel
  52220, -- Glinting Demonseye
  52221, -- Guardian's Demonseye
  52222, -- Inscribed Ember Topaz
  52223, -- Jagged Dream Emerald
  52224, -- Keen Ember Topaz
  52225, -- Lightning Dream Emerald
  52226, -- Mystic Amberjewel
  52227, -- Nimble Dream Emerald
  52228, -- Piercing Dream Emerald
  52229, -- Polished Ember Topaz
  52230, -- Precise Inferno Ruby
  52231, -- Puissant Dream Emerald
  52232, -- Quick Amberjewel
  52233, -- Regal Dream Emerald
  52234, -- Retaliating Demonseye
  52235, -- Rigid Ocean Sapphire
  52236, -- Purified Demonseye
  52237, -- Sensei's Dream Emerald
  52238, -- Shifting Demonseye
  52239, -- Potent Ember Topaz
  52240, -- Skillful Ember Topaz
  52241, -- Smooth Amberjewel
  52242, -- Solid Ocean Sapphire
  52243, -- Sovereign Demonseye
  52244, -- Sparkling Ocean Sapphire
  52245, -- Steady Dream Emerald
  52246, -- Stormy Ocean Sapphire
  52247, -- Subtle Amberjewel
  52248, -- Timeless Demonseye
  52249, -- Resolute Ember Topaz
  52250, -- Zen Dream Emerald
  52255, -- Bold Chimera's Eye
  52257, -- Brilliant Chimera's Eye
  52258, -- Delicate Chimera's Eye
  52259, -- Flashing Chimera's Eye
  52260, -- Precise Chimera's Eye
  52261, -- Solid Chimera's Eye
  52262, -- Sparkling Chimera's Eye
  52263, -- Stormy Chimera's Eye
  52264, -- Rigid Chimera's Eye
  52265, -- Subtle Chimera's Eye
  52266, -- Smooth Chimera's Eye
  52267, -- Mystic Chimera's Eye
  52268, -- Quick Chimera's Eye
  52269, -- Fractured Chimera's Eye
  52289, -- Fleet Shadowspirit Diamond
  52291, -- Chaotic Shadowspirit Diamond
  52292, -- Bracing Shadowspirit Diamond
  52293, -- Eternal Shadowspirit Diamond
  52294, -- Austere Shadowspirit Diamond
  52295, -- Effulgent Shadowspirit Diamond
  52296, -- Ember Shadowspirit Diamond
  52297, -- Revitalizing Shadowspirit Diamond
  52298, -- Destructive Shadowspirit Diamond
  52299, -- Powerful Shadowspirit Diamond
  52300, -- Enigmatic Shadowspirit Diamond
  52301, -- Impassive Shadowspirit Diamond
  52302, -- Forlorn Shadowspirit Diamond
  59477, -- Subtle Cogwheel
  59478, -- Smooth Cogwheel
  59479, -- Quick Cogwheel
  59480, -- Fractured Cogwheel
  59489, -- Precise Cogwheel
  59491, -- Flashing Cogwheel
  59493, -- Rigid Cogwheel
  59496, -- Sparkling Cogwheel
  68356, -- Willful Ember Topaz
  68357, -- Lucent Ember Topaz
  68358, -- Resplendent Ember Topaz
  68660, -- Mystic Cogwheel
  68741, -- Vivid Dream Emerald
  68778, -- Agile Shadowspirit Diamond
  68779, -- Reverberating Shadowspirit Diamond
  68780, -- Burning Shadowspirit Diamond
  71817, -- Rigid Deepholm Iolite
  71818, -- Stormy Deepholm Iolite
  71819, -- Sparkling Deepholm Iolite
  71820, -- Solid Deepholm Iolite
  71822, -- Misty Elven Peridot
  71823, -- Piercing Elven Peridot
  71824, -- Lightning Elven Peridot
  71825, -- Sensei's Elven Peridot
  71826, -- Infused Elven Peridot
  71827, -- Zen Elven Peridot
  71828, -- Balanced Elven Peridot
  71829, -- Vivid Elven Peridot
  71830, -- Turbid Elven Peridot
  71831, -- Radiant Elven Peridot
  71832, -- Shattered Elven Peridot
  71833, -- Energized Elven Peridot
  71834, -- Jagged Elven Peridot
  71835, -- Regal Elven Peridot
  71836, -- Forceful Elven Peridot
  71837, -- Nimble Elven Peridot
  71838, -- Puissant Elven Peridot
  71839, -- Steady Elven Peridot
  71840, -- Deadly Lava Coral
  71841, -- Crafty Lava Coral
  71842, -- Potent Lava Coral
  71843, -- Inscribed Lava Coral
  71844, -- Polished Lava Coral
  71845, -- Resolute Lava Coral
  71846, -- Stalwart Lava Coral
  71847, -- Champion's Lava Coral
  71848, -- Deft Lava Coral
  71849, -- Wicked Lava Coral
  71850, -- Reckless Lava Coral
  71851, -- Fierce Lava Coral
  71852, -- Adept Lava Coral
  71853, -- Keen Lava Coral
  71854, -- Artful Lava Coral
  71855, -- Fine Lava Coral
  71856, -- Skillful Lava Coral
  71857, -- Lucent Lava Coral
  71858, -- Tenuous Lava Coral
  71859, -- Willful Lava Coral
  71860, -- Splendid Lava Coral
  71861, -- Resplendent Lava Coral
  71862, -- Glinting Shadow Spinel
  71863, -- Accurate Shadow Spinel
  71864, -- Veiled Shadow Spinel
  71865, -- Retaliating Shadow Spinel
  71866, -- Etched Shadow Spinel
  71867, -- Mysterious Shadow Spinel
  71868, -- Purified Shadow Spinel
  71869, -- Shifting Shadow Spinel
  71870, -- Guardian's Shadow Spinel
  71871, -- Timeless Shadow Spinel
  71872, -- Defender's Shadow Spinel
  71873, -- Sovereign Shadow Spinel
  71874, -- Smooth Lightstone
  71875, -- Subtle Lightstone
  71876, -- Quick Lightstone
  71877, -- Fractured Lightstone
  71878, -- Mystic Lightstone
  71879, -- Delicate Queen's Garnet
  71880, -- Precise Queen's Garnet
  71881, -- Brilliant Queen's Garnet
  71882, -- Flashing Queen's Garnet
  71883, -- Bold Queen's Garnet
  77130, -- Balanced Elven Peridot
  77131, -- Infused Elven Peridot
  77132, -- Lucent Lava Coral
  77133, -- Mysterious Shadow Spinel
  77134, -- Mystic Lightstone
  77136, -- Resplendent Lava Coral
  77137, -- Shattered Elven Peridot
  77138, -- Splendid Lava Coral
  77139, -- Steady Elven Peridot
  77140, -- Stormy Deepholm Iolite
  77141, -- Tenuous Lava Coral
  77142, -- Turbid Elven Peridot
  77143, -- Vivid Elven Peridot
  77144, -- Willful Lava Coral
  77154, -- Radiant Elven Peridot
}

-- Permanent Enhancements
database["PermanentEnhancements"] = {
  52687, -- Enchant Gloves - Mastery
  52743, -- Enchant Boots - Earthen Vitality
  52744, -- Enchant Chest - Mighty Stats
  52745, -- Enchant Cloak - Lesser Power
  52746, -- Enchant Bracer - Speed
  52747, -- Enchant Weapon - Mending
  52748, -- Enchant Weapon - Avalanche
  52749, -- Enchant Gloves - Haste
  52750, -- Enchant Boots - Haste
  52751, -- Enchant Chest - Stamina
  52752, -- Enchant Bracer - Critical Strike
  52753, -- Enchant Cloak - Intellect
  52754, -- Enchant Shield - Protection
  52755, -- Enchant Weapon - Elemental Slayer
  52756, -- Enchant Gloves - Exceptional Strength
  52757, -- Enchant Boots - Major Agility
  52758, -- Enchant Chest - Mighty Armor
  52759, -- Enchant Gloves - Greater Haste
  52760, -- Enchant Weapon - Hurricane
  52761, -- Enchant Weapon - Heartsong
  52762, -- Enchant Shield - Mastery
  52763, -- Enchant Bracer - Superior Dodge
  52764, -- Enchant Cloak - Critical Strike
  52765, -- Enchant Chest - Exceptional Versatility
  52766, -- Enchant Bracer - Precision
  52767, -- Enchant Cloak - Protection
  52768, -- Enchant Off-Hand - Superior Intellect
  52769, -- Enchant Boots - Precision
  52770, -- Enchant Bracer - Exceptional Versatility
  52771, -- Enchant Boots - Mastery
  52772, -- Enchant Bracer - Greater Haste
  52773, -- Enchant Cloak - Greater Intellect
  52774, -- Enchant Weapon - Power Torrent
  52775, -- Enchant Weapon - Windwalk
  52776, -- Enchant Weapon - Landslide
  52777, -- Enchant Cloak - Greater Critical Strike
  52778, -- Enchant Bracer - Greater Critical Strike
  52779, -- Enchant Chest - Peerless Stats
  52780, -- Enchant Chest - Greater Stamina
  52781, -- Enchant Boots - Assassin's Step
  52782, -- Enchant Boots - Lavawalker
  52783, -- Enchant Gloves - Mighty Strength
  52784, -- Enchant Gloves - Greater Mastery
  52785, -- Enchant Bracer - Greater Speed
  54447, -- Enchanted Spellthread
  54448, -- Powerful Enchanted Spellthread
  54449, -- Ghostly Spellthread
  54450, -- Powerful Ghostly Spellthread
  55055, -- Elementium Shield Spike
  55056, -- Pyrium Shield Spike
  55057, -- Pyrium Weapon Chain
  56477, -- Savage Armor Kit
  56502, -- Scorched Leg Armor
  56503, -- Twilight Leg Armor
  56517, -- Heavy Savage Armor Kit
  56550, -- Dragonscale Leg Armor
  56551, -- Charscale Leg Armor
  59594, -- Gnomish X-Ray Scope
  59595, -- R19 Threatfinder
  59596, -- Safety Catch Removal Kit
  68134, -- Enchant 2H Weapon - Mighty Agility
  68784, -- Enchant Bracer - Agility
  68785, -- Enchant Bracer - Major Strength
  68786, -- Enchant Bracer - Mighty Intellect
  68796, -- Reinforced Fishing Line
  70139, -- Flintlocke's Woodchucker
  71720, -- Drakehide Leg Armor
  72070, -- Enchant Gloves - Assault
}

-- Temporary Enhancements
database["TemporaryEnhancements"] = {
  62673, -- Feathered Lure
  67404, -- Glass Fishing Bobber
  68049, -- Heat-Treated Spinning Lure
  69907, -- Corpse Worm
}

-- Archeology
database["Archeology"] = {
  52843, -- Dwarf Rune Stone
  63127, -- Highborne Scroll
  63128, -- Troll Tablet
  64392, -- Orc Blood Text
  64394, -- Draenei Tome
  64395, -- Vrykul Rune Stick
  64396, -- Nerubian Obelisk
  64397, -- Tol'vir Hieroglyphic
}

-- Cloth
database["Cloth"] = {
  53010, -- Embersilk Cloth
  53643, -- Bolt of Embersilk Cloth
  54440, -- Dreamcloth
}

-- Elemental
database["Elemental"] = {
  52325, -- Volatile Fire
  52326, -- Volatile Water
  52327, -- Volatile Earth
  52328, -- Volatile Air
  52329, -- Volatile Life
  54464, -- Random Volatile Element
}

-- Enchanting
database["Enchanting"] = {
  52555, -- Hypnotic Dust
  52718, -- Lesser Celestial Essence
  52719, -- Greater Celestial Essence
  52720, -- Small Heavenly Shard
  52721, -- Heavenly Shard
  52722, -- Maelstrom Crystal
}

-- Herbs
database["Herbs"] = {
  52983, -- Cinderbloom
  52984, -- Stormvine
  52985, -- Azshara's Veil
  52986, -- Heartblossom
  52987, -- Twilight Jasmine
  52988, -- Whiptail
}

-- Inscription
database["Inscription"] = {
  61978, -- Blackfallow Ink
  61979, -- Ashen Pigment
  61980, -- Burning Embers
  61988, -- Ace of Embers
  61989, -- Two of Embers
  61990, -- Three of Embers
  61991, -- Four of Embers
  61992, -- Five of Embers
  61993, -- Six of Embers
  61994, -- Seven of Embers
  61995, -- Eight of Embers
  61996, -- Ace of Stones
  61997, -- Two of Stones
  61998, -- Three of Stones
  61999, -- Four of Stones
  62000, -- Five of Stones
  62001, -- Six of Stones
  62002, -- Seven of Stones
  62003, -- Eight of Stones
  62004, -- Ace of the Winds
  62005, -- Two of the Winds
  62006, -- Three of the Winds
  62007, -- Four of the Winds
  62008, -- Five of the Winds
  62009, -- Six of the Winds
  62010, -- Seven of the Winds
  62011, -- Eight of the Winds
  62012, -- Ace of Waves
  62013, -- Two of Waves
  62014, -- Three of Waves
  62015, -- Four of Waves
  62016, -- Five of Waves
  62017, -- Six of Waves
  62018, -- Seven of Waves
  62019, -- Eight of Waves
  62322, -- Polished Horn
  62323, -- Deathwing Scale Fragment
  67319, -- Preserved Ogre Eye
  67335, -- Silver Charm Bracelet
  67348, -- Bleached Jawbone
  68047, -- Scavenged Dragon Horn
}

-- Jewelcrafting
database["Jewelcrafting"] = {
  52177, -- Carnelian
  52178, -- Zephyrite
  52179, -- Alicite
  52180, -- Nightstone
  52181, -- Hessonite
  52182, -- Jasper
  52190, -- Inferno Ruby
  52191, -- Ocean Sapphire
  52192, -- Dream Emerald
  52193, -- Ember Topaz
  52194, -- Demonseye
  52195, -- Amberjewel
  52196, -- Chimera's Eye
  52303, -- Shadowspirit Diamond
  52338, -- Darkfathom Pearl
  52339, -- Flawless Pearl
  71805, -- Queen's Garnet
  71806, -- Lightstone
  71807, -- Deepholm Iolite
  71808, -- Lava Coral
  71809, -- Shadow Spinel
  71810, -- Elven Peridot
  77951, -- Shadowy Gem
  77952, -- Elementium Gem Cluster
}

-- Leather
database["Leather"] = {
  52976, -- Savage Leather
  52977, -- Savage Leather Scraps
  52979, -- Blackened Dragonscale
  52980, -- Pristine Hide
  52982, -- Deepsea Scale
  56516, -- Heavy Savage Leather
}

-- Meat & Fish
database["MeatFish"] = {
  53062, -- Sharptooth
  53063, -- Mountain Trout
  53064, -- Highland Guppy
  53065, -- Albino Cavefish
  53066, -- Blackbelly Mudfish
  53067, -- Striped Lurker
  53068, -- Lavascale Catfish
  53069, -- Murglesnout
  53070, -- Fathom Eel
  53071, -- Algaefin Rockfish
  53072, -- Deepsea Sagefish
  62778, -- Toughened Flesh
  62779, -- Monstrous Claw
  62780, -- Snake Eye
  62781, -- Giant Turtle Tongue
  62782, -- Dragon Flank
  62783, -- Basilisk "Liver"
  62784, -- Crocolisk Tail
  62785, -- Delicate Wing
  62791, -- Blood Shrimp
  67229, -- Stag Flank
}

-- Metal & Stone
database["MetalStone"] = {
  51950, -- Pyrium Bar
  52183, -- Pyrite Ore
  52185, -- Elementium Ore
  52186, -- Elementium Bar
  53038, -- Obsidium Ore
  53039, -- Hardened Elementium Bar
  54849, -- Obsidium Bar
  58480, -- Truegold
  65365, -- Folded Obsidium
}

-- Other Tradegoods
database["OtherTradegoods"] = {
  52078, -- Chaos Orb
  52197, -- Figurine - Demon Panther
  52340, -- Abyssal Clam
  56850, -- Deepstone Oil
  61987, -- Darkmoon Card of Destruction
  62786, -- Cocoa Beans
  65513, -- Crate of Tasty Meat
  65892, -- Pyrium-Laced Crystalline Vial
  65893, -- Sands of Time
  65894, -- Figurine - Dream Owl
  65895, -- Figurine - King of Boars
  65896, -- Figurine - Jeweled Serpent
  65897, -- Figurine - Earthen Guardian
  68689, -- Imported Supplies
  69237, -- Living Ember
  71998, -- Essence of Destruction
}

-- Parts
database["Parts"] = {
  52188, -- Jeweler's Setting
  60224, -- Handful of Obsidium Bolts
  61981, -- Inferno Ink
  67749, -- Electrified Ether
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
  if self.db.profile.moveMergedFortunecards then
    Result[formatBagTitle(self, L["Fortune cards"], converttohex(self.db.profile.color.mergedFortunecards))] =
      AddToSet(database["FortuneCard"], database["MysteriousFortuneCard"])
  else
    if self.db.profile.moveFortuneCard then
      Result[formatBagTitle(self, L["Fortune Card"], converttohex(self.db.profile.color.FortuneCard))] =
        AddToSet(database["FortuneCard"])
    end
    if self.db.profile.moveMysteriousFortuneCard then
      Result[formatBagTitle(
        self,
        L["Mysterious Fortune Card"],
        converttohex(self.db.profile.color.MysteriousFortuneCard)
      )] =
        AddToSet(database["MysteriousFortuneCard"])
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
      database["Archeology"],
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
    if self.db.profile.moveArcheology then
      Result[formatBagTitle(self, L["Archeology"], converttohex(self.db.profile.color.Archeology))] =
        AddToSet(database["Archeology"])
    end
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

local setFilter = AdiBags:RegisterFilter("Cataclysm", 98, "ABEvent-1.0")
setFilter.uiName = string.format("|cffeb4d00%s|r", L["Cataclysm"])
setFilter.uiDesc =
  string.format("%s\n|cffffd800%s: 1.0.7|r", L["Items from the Cataclysm expansion."], L["Filter version"])

function setFilter:OnInitialize()
  self.db = AdiBags.db:RegisterNamespace("Cataclysm", {
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
      moveMergedFortunecards = true,
      moveFortuneCard = true,
      moveMysteriousFortuneCard = true,
      moveMergedRecipes = true,
      moveAlchemyRecipes = true,
      moveBlacksmithingRecipes = true,
      moveCookingRecipes = true,
      moveEnchantingRecipes = true,
      moveEngineeringRecipes = true,
      moveInscriptionRecipes = true,
      moveJewelcraftingRecipes = true,
      moveLeatherworkingRecipes = true,
      moveTailoringRecipes = true,
      moveMergedTemporaryPermanentEnhancements = true,
      moveGems = true,
      movePermanentEnhancements = true,
      moveTemporaryEnhancements = true,
      moveMergedTradegoods = true,
      moveArcheology = true,
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
        prefix = converttorgb("eb4d00", true),
        mergedConsumables = converttorgb("7aa36f", true),
        Bandages = converttorgb("fff600", true),
        Consumables = converttorgb("49678d", true),
        FoodsandDrinks = converttorgb("9b59b6", true),
        OtherConsumables = converttorgb("4e878c", true),
        mergedFlasksElixirsPotions = converttorgb("769fb6", true),
        Elixirs = converttorgb("689a8c", true),
        Flasks = converttorgb("b60f96", true),
        Potions = converttorgb("9dbbae", true),
        mergedFortunecards = converttorgb("93e5ab", true),
        FortuneCard = converttorgb("93e5ab", true),
        MysteriousFortuneCard = converttorgb("93e5ab", true),
        mergedRecipes = converttorgb("68d080", true),
        AlchemyRecipes = converttorgb("4e9a06", true),
        BlacksmithingRecipes = converttorgb("8f8f8f", true),
        CookingRecipes = converttorgb("e9b96e", true),
        EnchantingRecipes = converttorgb("5c3566", true),
        EngineeringRecipes = converttorgb("c4a000", true),
        InscriptionRecipes = converttorgb("855c33", true),
        JewelcraftingRecipes = converttorgb("ad7fa8", true),
        LeatherworkingRecipes = converttorgb("8b4513", true),
        TailoringRecipes = converttorgb("d3d7cf", true),
        mergedTemporaryPermanentEnhancements = converttorgb("5a7684", true),
        Gems = converttorgb("ff00ea", true),
        PermanentEnhancements = converttorgb("92afd7", true),
        TemporaryEnhancements = converttorgb("c5d1eb", true),
        mergedTradegoods = converttorgb("786f52", true),
        Archeology = converttorgb("864200", true),
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
            ["C"] = "C",
            ["C-"] = "C-",
            ["3."] = "3.",
            ["CATA"] = "CATA",
            ["|T409545:" .. AdiBags.HEADER_SIZE .. ":" .. AdiBags.HEADER_SIZE .. ":-2:-10|t"] = "|T409545:"
              .. AdiBags.HEADER_SIZE
              .. "|t",
            ["|T574788:" .. AdiBags.HEADER_SIZE .. ":" .. AdiBags.HEADER_SIZE .. ":-2:-10|t"] = "|T574788:"
              .. AdiBags.HEADER_SIZE
              .. "|t",
            ["|T575534:" .. AdiBags.HEADER_SIZE .. ":" .. AdiBags.HEADER_SIZE .. ":-2:-10|t"] = "|T575534:"
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
    Fortunecards_config = {
      type = "group",
      name = L["Fortune cards"],
      desc = "", -- doesnt work,
      inline = true,
      order = 81,
      args = {
        Legendaries_desc = {
          type = "description",
          name = L["Test your luck!"],
          order = 82,
        },
        moveMergedFortunecards = {
          name = string.format(L["%sMerge %s%s"], "|cffffd800", L["Fortune cards"], "|r"),
          desc = string.format(L["Merge all %s into a single category."], L["Fortune cards"]),
          type = "toggle",
          width = 1.5,
          order = 83,
        },
        colorMergedFortunecards = {
          name = L["Color"],
          desc = string.format(L["Select a color for the merged %s category."], L["Fortune cards"]),
          type = "color",
          order = 84,
          hasAlpha = false,
          disabled = function()
            return not self.db.profile.moveMergedFortunecards
          end,
          get = function()
            local color = self.db.profile.color.mergedFortunecards
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.mergedFortunecards
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_8 = {
          type = "header",
          name = "",
          order = 85,
        },
        moveFortuneCard = {
          name = L["Fortune Card"],
          desc = L["Your fortune has been revealed!"],
          type = "toggle",
          width = 1.5,
          order = 86,
          disabled = function()
            return self.db.profile.moveMergedFortunecards
          end,
        },
        colorFortuneCard = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Fortune Card"]),
          type = "color",
          order = 87,
          disabled = function()
            return self.db.profile.moveMergedFortunecards
          end,
          get = function()
            local color = self.db.profile.color.FortuneCard
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.FortuneCard
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_9 = {
          type = "header",
          name = "",
          order = 88,
        },
        moveMysteriousFortuneCard = {
          name = L["Mysterious Fortune Card"],
          desc = L["Flip a card to see your fortune."],
          type = "toggle",
          width = 1.5,
          order = 89,
          disabled = function()
            return self.db.profile.moveMergedFortunecards
          end,
        },
        colorMysteriousFortuneCard = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Mysterious Fortune Card"]),
          type = "color",
          order = 90,
          disabled = function()
            return self.db.profile.moveMergedFortunecards
          end,
          get = function()
            local color = self.db.profile.color.MysteriousFortuneCard
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.MysteriousFortuneCard
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
      order = 91,
      args = {
        Legendaries_desc = {
          type = "description",
          name = L["Recipes for all professions."],
          order = 92,
        },
        moveMergedRecipes = {
          name = string.format(L["%sMerge %s%s"], "|cffffd800", L["Recipes"], "|r"),
          desc = string.format(L["Merge all %s into a single category."], L["Recipes"]),
          type = "toggle",
          width = 1.5,
          order = 93,
        },
        colorMergedRecipes = {
          name = L["Color"],
          desc = string.format(L["Select a color for the merged %s category."], L["Recipes"]),
          type = "color",
          order = 94,
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
        seperator_10 = {
          type = "header",
          name = "",
          order = 95,
        },
        moveAlchemyRecipes = {
          name = L["Alchemy Recipes"],
          desc = L["Recipes for crafting potions, elixirs, and transmuting materials."],
          type = "toggle",
          width = 1.5,
          order = 96,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
        },
        colorAlchemyRecipes = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Alchemy Recipes"]),
          type = "color",
          order = 97,
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
        seperator_11 = {
          type = "header",
          name = "",
          order = 98,
        },
        moveBlacksmithingRecipes = {
          name = L["Blacksmithing Recipes"],
          desc = L["Recipes for forging metal armor, weapons, and enhancements."],
          type = "toggle",
          width = 1.5,
          order = 99,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
        },
        colorBlacksmithingRecipes = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Blacksmithing Recipes"]),
          type = "color",
          order = 100,
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
        seperator_12 = {
          type = "header",
          name = "",
          order = 101,
        },
        moveCookingRecipes = {
          name = L["Cooking Recipes"],
          desc = L["Recipes for preparing food that provides buffs."],
          type = "toggle",
          width = 1.5,
          order = 102,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
        },
        colorCookingRecipes = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Cooking Recipes"]),
          type = "color",
          order = 103,
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
        seperator_13 = {
          type = "header",
          name = "",
          order = 104,
        },
        moveEnchantingRecipes = {
          name = L["Enchanting Recipes"],
          desc = L["Recipes for enchanting gear with magical properties."],
          type = "toggle",
          width = 1.5,
          order = 105,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
        },
        colorEnchantingRecipes = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Enchanting Recipes"]),
          type = "color",
          order = 106,
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
        seperator_14 = {
          type = "header",
          name = "",
          order = 107,
        },
        moveEngineeringRecipes = {
          name = L["Engineering Recipes"],
          desc = L["Recipes for creating gadgets, explosives, and mechanical devices."],
          type = "toggle",
          width = 1.5,
          order = 108,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
        },
        colorEngineeringRecipes = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Engineering Recipes"]),
          type = "color",
          order = 109,
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
        seperator_15 = {
          type = "header",
          name = "",
          order = 110,
        },
        moveInscriptionRecipes = {
          name = L["Inscription Recipes"],
          desc = L["Recipes for scribing glyphs and crafting scrolls and tomes."],
          type = "toggle",
          width = 1.5,
          order = 111,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
        },
        colorInscriptionRecipes = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Inscription Recipes"]),
          type = "color",
          order = 112,
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
        seperator_16 = {
          type = "header",
          name = "",
          order = 113,
        },
        moveJewelcraftingRecipes = {
          name = L["Jewelcrafting Recipes"],
          desc = L["Recipes for cutting gems and crafting jewelry."],
          type = "toggle",
          width = 1.5,
          order = 114,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
        },
        colorJewelcraftingRecipes = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Jewelcrafting Recipes"]),
          type = "color",
          order = 115,
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
        seperator_17 = {
          type = "header",
          name = "",
          order = 116,
        },
        moveLeatherworkingRecipes = {
          name = L["Leatherworking Recipes"],
          desc = L["Recipes for crafting leather and mail armor."],
          type = "toggle",
          width = 1.5,
          order = 117,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
        },
        colorLeatherworkingRecipes = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Leatherworking Recipes"]),
          type = "color",
          order = 118,
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
        seperator_18 = {
          type = "header",
          name = "",
          order = 119,
        },
        moveTailoringRecipes = {
          name = L["Tailoring Recipes"],
          desc = L["Recipes for weaving cloth armor and other cloth items."],
          type = "toggle",
          width = 1.5,
          order = 120,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
        },
        colorTailoringRecipes = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Tailoring Recipes"]),
          type = "color",
          order = 121,
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
      order = 122,
      args = {
        Legendaries_desc = {
          type = "description",
          name = L["Use these for a powerup!"],
          order = 123,
        },
        moveMergedTemporaryPermanentEnhancements = {
          name = string.format(L["%sMerge %s%s"], "|cffffd800", L["Temporary & Permanent Enhancements"], "|r"),
          desc = string.format(L["Merge all %s into a single category."], L["Temporary & Permanent Enhancements"]),
          type = "toggle",
          width = 1.5,
          order = 124,
        },
        colorMergedTemporaryPermanentEnhancements = {
          name = L["Color"],
          desc = string.format(
            L["Select a color for the merged %s category."],
            L["Temporary & Permanent Enhancements"]
          ),
          type = "color",
          order = 125,
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
        seperator_19 = {
          type = "header",
          name = "",
          order = 126,
        },
        moveGems = {
          name = L["Gems"],
          desc = L["These are gems that you can typically apply to armor to improve it."],
          type = "toggle",
          width = 1.5,
          order = 127,
          disabled = function()
            return self.db.profile.moveMergedTemporaryPermanentEnhancements
          end,
        },
        colorGems = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Gems"]),
          type = "color",
          order = 128,
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
        seperator_20 = {
          type = "header",
          name = "",
          order = 129,
        },
        movePermanentEnhancements = {
          name = L["Permanent Enhancements"],
          desc = L["These are permanent enhancements that you can typically apply to armor to improve it."],
          type = "toggle",
          width = 1.5,
          order = 130,
          disabled = function()
            return self.db.profile.moveMergedTemporaryPermanentEnhancements
          end,
        },
        colorPermanentEnhancements = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Permanent Enhancements"]),
          type = "color",
          order = 131,
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
        seperator_21 = {
          type = "header",
          name = "",
          order = 132,
        },
        moveTemporaryEnhancements = {
          name = L["Temporary Enhancements"],
          desc = L["These are temporary enhancements that you can typically apply to armor to improve it."],
          type = "toggle",
          width = 1.5,
          order = 133,
          disabled = function()
            return self.db.profile.moveMergedTemporaryPermanentEnhancements
          end,
        },
        colorTemporaryEnhancements = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Temporary Enhancements"]),
          type = "color",
          order = 134,
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
      order = 135,
      args = {
        Legendaries_desc = {
          type = "description",
          name = L["Trading tradegoods is good. Trade tradegoods for good goods."],
          order = 136,
        },
        moveMergedTradegoods = {
          name = string.format(L["%sMerge %s%s"], "|cffffd800", L["Tradegoods"], "|r"),
          desc = string.format(L["Merge all %s into a single category."], L["Tradegoods"]),
          type = "toggle",
          width = 1.5,
          order = 137,
        },
        colorMergedTradegoods = {
          name = L["Color"],
          desc = string.format(L["Select a color for the merged %s category."], L["Tradegoods"]),
          type = "color",
          order = 138,
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
        seperator_22 = {
          type = "header",
          name = "",
          order = 139,
        },
        moveArcheology = {
          name = L["Archeology"],
          desc = L["Archeology items."],
          type = "toggle",
          width = 1.5,
          order = 140,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorArcheology = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Archeology"]),
          type = "color",
          order = 141,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
          get = function()
            local color = self.db.profile.color.Archeology
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.Archeology
            color.r, color.g, color.b = r, g, b
            AdiBags:UpdateFilters()
          end,
        },
        seperator_23 = {
          type = "header",
          name = "",
          order = 142,
        },
        moveCloth = {
          name = L["Cloth"],
          desc = L["Cloth used in Tailoring."],
          type = "toggle",
          width = 1.5,
          order = 143,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorCloth = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Cloth"]),
          type = "color",
          order = 144,
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
        seperator_24 = {
          type = "header",
          name = "",
          order = 145,
        },
        moveElemental = {
          name = L["Elemental"],
          desc = L["Elementals used in all professions."],
          type = "toggle",
          width = 1.5,
          order = 146,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorElemental = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Elemental"]),
          type = "color",
          order = 147,
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
        seperator_25 = {
          type = "header",
          name = "",
          order = 148,
        },
        moveEnchanting = {
          name = L["Enchanting"],
          desc = L["Enchanting materials for enchanting weapons & armor."],
          type = "toggle",
          width = 1.5,
          order = 149,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorEnchanting = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Enchanting"]),
          type = "color",
          order = 150,
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
        seperator_26 = {
          type = "header",
          name = "",
          order = 151,
        },
        moveHerbs = {
          name = L["Herbs"],
          desc = L["Herbs used in Alchemy & Inscription."],
          type = "toggle",
          width = 1.5,
          order = 152,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorHerbs = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Herbs"]),
          type = "color",
          order = 153,
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
        seperator_27 = {
          type = "header",
          name = "",
          order = 154,
        },
        moveInscription = {
          name = L["Inscription"],
          desc = L["Inscription materials for creating glyphs or other paper related goods."],
          type = "toggle",
          width = 1.5,
          order = 155,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorInscription = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Inscription"]),
          type = "color",
          order = 156,
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
        seperator_28 = {
          type = "header",
          name = "",
          order = 157,
        },
        moveJewelcrafting = {
          name = L["Jewelcrafting"],
          desc = L["Jewelcrafting materials for creating rings, necklaces, gems, etc."],
          type = "toggle",
          width = 1.5,
          order = 158,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorJewelcrafting = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Jewelcrafting"]),
          type = "color",
          order = 159,
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
        seperator_29 = {
          type = "header",
          name = "",
          order = 160,
        },
        moveLeather = {
          name = L["Leather"],
          desc = L["Leather used in Leatherworking."],
          type = "toggle",
          width = 1.5,
          order = 161,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorLeather = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Leather"]),
          type = "color",
          order = 162,
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
        seperator_30 = {
          type = "header",
          name = "",
          order = 163,
        },
        moveMeatFish = {
          name = L["Meat & Fish"],
          desc = L["Meat & Fish used in Cooking."],
          type = "toggle",
          width = 1.5,
          order = 164,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorMeatFish = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Meat & Fish"]),
          type = "color",
          order = 165,
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
        seperator_31 = {
          type = "header",
          name = "",
          order = 166,
        },
        moveMetalStone = {
          name = L["Metal & Stone"],
          desc = L["Metal & Stone used in Blacksmithing."],
          type = "toggle",
          width = 1.5,
          order = 167,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorMetalStone = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Metal & Stone"]),
          type = "color",
          order = 168,
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
        seperator_32 = {
          type = "header",
          name = "",
          order = 169,
        },
        moveOtherTradegoods = {
          name = L["Other Tradegoods"],
          desc = L["Other items used in various professions."],
          type = "toggle",
          width = 1.5,
          order = 170,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorOtherTradegoods = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Other Tradegoods"]),
          type = "color",
          order = 171,
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
        seperator_33 = {
          type = "header",
          name = "",
          order = 172,
        },
        moveParts = {
          name = L["Parts"],
          desc = L["Parts used in Engineering."],
          type = "toggle",
          width = 1.5,
          order = 173,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorParts = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Parts"]),
          type = "color",
          order = 174,
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
