--[[
AdiBags - Burning Crusade
by Zottelchen
version: 1.0.7
Items from the Burning Crusade expansion.
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
  21990, -- Netherweave Bandage
  21991, -- Heavy Netherweave Bandage
}

-- Consumables
database["Consumables"] = {
  22728, -- Steam Tonk Controller
  23736, -- Fel Iron Bomb
  23737, -- Adamantite Grenade
  23819, -- Elemental Seaforium Charge
  23821, -- Zapthrottle Mote Extractor
  23826, -- The Bigger One
  23827, -- Super Sapper Charge
  23841, -- Gnomish Flame Turret
  31666, -- Battered Steam Tonk Controller
  32413, -- Frost Grenade
  34113, -- Field Repair Bot 110G
}

-- Foods and Drinks
database["FoodsandDrinks"] = {
  20857, -- Honey Bread
  22018, -- Conjured Glacier Water
  22019, -- Conjured Croissant
  22044, -- Mana Emerald
  22645, -- Crunchy Spider Surprise
  23329, -- Enriched Lasher Root
  23354, -- Crystalized Mana Residue
  23386, -- Condensed Mana Powder
  23495, -- Springpaw Appetizer
  23585, -- Stouthammer Lite
  23756, -- Cookie's Jumbo Gumbo
  23848, -- Nethergarde Bitter
  24006, -- Grunt's Waterskin
  24007, -- Footman's Waterskin
  24008, -- Dried Mushroom Rations
  24009, -- Dried Fruit Rations
  24072, -- Sand Pear Pie
  24105, -- Roasted Moongraze Tenderloin
  24338, -- Hellfire Spineleaf
  24408, -- Edible Stalks
  24539, -- Marsh Lichen
  24540, -- Edible Fern
  27553, -- Crimson Steer Energy Drink
  27635, -- Lynx Steak
  27636, -- Bat Bites
  27651, -- Buzzard Bites
  27655, -- Ravager Dog
  27657, -- Blackened Basilisk
  27658, -- Roasted Clefthoof
  27659, -- Warp Burger
  27660, -- Talbuk Steak
  27661, -- Blackened Trout
  27662, -- Feltail Delight
  27663, -- Blackened Sporefish
  27664, -- Grilled Mudfish
  27665, -- Poached Bluefish
  27666, -- Golden Fish Sticks
  27667, -- Spicy Crawdad
  27854, -- Smoked Talbuk Venison
  27855, -- Mag'har Grainbread
  27856, -- Skethyl Berries
  27857, -- Garadar Sharp
  27858, -- Sunspring Carp
  27859, -- Zangar Caps
  27860, -- Purified Draenic Water
  28112, -- Underspore Pod
  28284, -- Don Carlos Tequila
  28399, -- Filtered Draenic Water
  28486, -- Moser's Magnificent Muffin
  28501, -- Ravager Egg Omelet
  29112, -- Cenarion Spirits
  29292, -- Helboar Bacon
  29393, -- Diamond Berries
  29394, -- Lyribread
  29395, -- Ethermead
  29401, -- Sparkling Southshore Cider
  29412, -- Jessen's Special Slop
  29448, -- Mag'har Mild Cheese
  29449, -- Bladespire Bagel
  29450, -- Telaari Grapes
  29451, -- Clefthoof Ribs
  29452, -- Zangar Trout
  29453, -- Sporeggar Mushroom
  29454, -- Silverwine
  29531, -- Drums of Restoration
  30155, -- Clam Bar
  30355, -- Grilled Shadowmoon Tuber
  30357, -- Oronok's Tuber of Healing
  30358, -- Oronok's Tuber of Agility
  30359, -- Oronok's Tuber of Strength
  30361, -- Oronok's Tuber of Spell Power
  30457, -- Gilneas Sparkling Water
  30458, -- Stromgarde Muenster
  30610, -- Smoked Black Bear Meat
  30703, -- Conjured Mountain Spring Water
  30816, -- Spice Bread
  31451, -- Pure Energy
  31672, -- Mok'Nathal Shortribs
  31673, -- Crunchy Serpent
  32453, -- Star's Tears
  32455, -- Star's Lament
  32667, -- Bash Ale
  32668, -- Dos Ogris
  32685, -- Ogri'la Chicken Fingers
  32686, -- Mingo's Fortune Giblets
  32721, -- Skyguard Rations
  32722, -- Enriched Terocone Juice
  33023, -- Savory Sausage
  33024, -- Pickled Sausage
  33025, -- Spicy Smoked Sausage
  33026, -- The Golden Link
  33028, -- Barleybrew Light
  33029, -- Barleybrew Dark
  33030, -- Barleybrew Clear
  33031, -- Thunder 45
  33032, -- Thunderbrew Ale
  33033, -- Thunderbrew Stout
  33034, -- Gordok Grog
  33035, -- Ogre Mead
  33036, -- Mudder's Milk
  33042, -- Black Coffee
  33043, -- The Essential Brewfest Pretzel
  33048, -- Stewed Trout
  33052, -- Fisherman's Feast
  33053, -- Hot Buttered Trout
  33234, -- Iced Berry Slush
  33236, -- Fizzy Faire Drink "Classic"
  33246, -- Funnel Cake
  33254, -- Forest Strider Drumstick
  33825, -- Skullfish Soup
  33866, -- Stormchops
  33867, -- Broiled Bloodfin
  33872, -- Spicy Hot Talbuk
  33874, -- Kibler's Bits
  33924, -- Delicious Chocolate Cake
  34017, -- Small Step Brew
  34018, -- Long Stride Brew
  34019, -- Path of Brew
  34020, -- Jungle River Water
  34021, -- Brewdoo Magic
  34022, -- Stout Shrunken Head
  34062, -- Conjured Mana Biscuit
  34063, -- Dried Sausage
  34064, -- Succulent Sausage
  34065, -- Spiced Onion Cheese
  34410, -- Honeyed Holiday Ham
  34411, -- Hot Apple Cider
  34412, -- Sparkling Apple Cider
  34780, -- Naaru Ration
  34832, -- Captain Rumsey's Lager
  35563, -- Charred Bear Kabobs
  35565, -- Juicy Bear Burger
  35720, -- Lord of Frost's Private Label
  36799, -- Mana Gem
  38427, -- Pickled Egg
  38428, -- Rock-Salted Pretzel
  38429, -- Blackrock Spring Water
  38430, -- Blackrock Mineral Water
  38431, -- Blackrock Fortified Water
  38432, -- Plugger's Blackrock Ale
  38466, -- Sulfuron Slammer
}

-- Other Consumables
database["OtherConsumables"] = {
  21038, -- Hardpacked Snowball
  22778, -- Scourgebane Infusion
  22779, -- Scourgebane Draught
  22795, -- Fel Blossom
  23215, -- Bag of Smorc Ingredients
  23334, -- Cracked Power Core
  23381, -- Chipped Power Core
  23492, -- Suntouched Special Reserve
  23584, -- Loch Modan Lager
  23586, -- Aerie Peak Pale Ale
  23768, -- White Smoke Flare
  23769, -- Red Smoke Flare
  23771, -- Green Smoke Flare
  23857, -- Legacy of the Mountain King
  23862, -- Redemption of the Fallen
  23864, -- Torment of the Worgen
  23865, -- Wrath of the Titans
  23985, -- Crystal of Vitality
  23986, -- Crystal of Insight
  23989, -- Crystal of Ferocity
  24268, -- Netherweave Net
  24289, -- Chrono-Beacon
  24330, -- Drain Schematics
  24407, -- Uncatalogued Species
  24421, -- Nagrand Cherry
  24429, -- Expedition Flare
  24494, -- Tears of the Goddess
  24520, -- Honor Hold Favor
  24522, -- Thrallmar Favor
  24538, -- Fire Bomb
  24579, -- Mark of Honor Hold
  24581, -- Mark of Thrallmar
  25498, -- Rough Stone Statue
  25548, -- Tallstalk Mushroom
  25550, -- Redcap Toadstool
  25880, -- Coarse Stone Statue
  25881, -- Heavy Stone Statue
  25882, -- Solid Stone Statue
  25883, -- Dense Stone Statue
  25886, -- Purple Smoke Flare
  27317, -- Elemental Sapta
  27388, -- Mr. Pinchy
  27498, -- Scroll of Agility V
  27499, -- Scroll of Intellect V
  27500, -- Scroll of Protection V
  27501, -- Scroll of Versatility V
  27502, -- Scroll of Stamina V
  27503, -- Scroll of Strength V
  28132, -- Area 52 Special
  28513, -- Demonic Rune Stone
  28554, -- Shredder Spare Parts
  28571, -- Blank Scroll
  28580, -- B'naar Console Transcription
  28635, -- Sunfury Arcanist Robes
  28636, -- Sunfury Researcher Gloves
  28637, -- Sunfury Guardsman Medallion
  28784, -- Unyielding Banner Scrap
  28878, -- Inscription of Faith
  28881, -- Inscription of Discipline
  28882, -- Inscription of Warding
  28885, -- Inscription of Vengeance
  28886, -- Greater Inscription of Discipline
  28887, -- Greater Inscription of Faith
  28888, -- Greater Inscription of Vengeance
  28889, -- Greater Inscription of Warding
  28903, -- Inscription of the Orb
  28904, -- Inscription of the Oracle
  28907, -- Inscription of the Blade
  28908, -- Inscription of the Knight
  28909, -- Greater Inscription of the Orb
  28910, -- Greater Inscription of the Blade
  28911, -- Greater Inscription of the Knight
  28912, -- Greater Inscription of the Oracle
  29162, -- Galaxis Soul Shard
  29187, -- Inscription of Endurance
  29443, -- Bloodmaul Brutebane Brew
  29528, -- Drums of War
  29529, -- Drums of Battle
  29530, -- Drums of Speed
  29532, -- Drums of Panic
  29624, -- First Half of Socrethar's Stone
  29625, -- Second Half of Socrethar's Stone
  29699, -- Socrethar's Teleportation Stone
  29735, -- Holy Dust
  29736, -- Arcane Rune
  29796, -- Socrethar's Teleportation Stone
  29905, -- Kael's Vial Remnant
  29906, -- Vashj's Vial Remnant
  30260, -- Voren'thal's Package
  30309, -- Stonebreaker Brew
  30499, -- Brightsong Wine
  30615, -- Halaani Whiskey
  30858, -- Peon Sleep Potion
  31121, -- Costume Scraps
  31122, -- Overseer Disguise
  31337, -- Orb of the Blackwhelp
  31437, -- Medicinal Drake Essence
  31449, -- Distilled Stalker Sight
  31450, -- Stealth of the Stalker
  31495, -- Grishnath Orb
  31517, -- Dire Pinfeather
  31518, -- Exorcism Feather
  31795, -- Draenei Prayer Beads
  32408, -- Naj'entus Spine
  32576, -- Depleted Crystal Focus
  32839, -- Cauldron of Major Arcane Protection
  32848, -- Explosives Package
  32849, -- Cauldron of Major Fire Protection
  32850, -- Cauldron of Major Frost Protection
  32851, -- Cauldron of Major Nature Protection
  32852, -- Cauldron of Major Shadow Protection
  32971, -- Water Bucket
  33081, -- Voodoo Skull
  33083, -- Orcish Grog
  33218, -- Goblin Gumbo
  33226, -- Tricky Treat
  33277, -- Tome of Thomas Thomson
  33797, -- Portable Brewfest Keg
  33865, -- Amani Hex Stick
  33926, -- Sealed Scroll Case
  33928, -- Hollowed Bone Decanter
  33929, -- Brewfest Brew
  33930, -- Amani Charm of the Bloodletter
  33931, -- Amani Charm of Mighty Mojo
  33932, -- Amani Charm of the Witch Doctor
  33933, -- Amani Charm of the Raging Defender
  33956, -- Echo Isles Pale Ale
  34068, -- Weighted Jack-o'-Lantern
  34077, -- Crudely Wrapped Gift
  34258, -- Love Rocket
  34583, -- Aldor Supplies Package
  34584, -- Scryer Supplies Package
  34585, -- Scryer Supplies Package
  34587, -- Aldor Supplies Package
  34592, -- Aldor Supplies Package
  34593, -- Scryer Supplies Package
  34594, -- Scryer Supplies Package
  34595, -- Aldor Supplies Package
  34599, -- Juggling Torch
  34850, -- Midsummer Ground Flower
  35223, -- Papa Hummel's Old-Fashioned Pet Biscuit
  35232, -- Shattered Sun Supplies
  35512, -- Pocket Full of Snow
  35945, -- Brilliant Glass
  36748, -- Dark Brewmaiden's Brew
  36877, -- Folded Letter
  37496, -- Binary Brew
  37497, -- Autumnal Acorn Ale
  37582, -- Pyroblast Cinnamon Ball
  37583, -- G.N.E.R.D.S.
  37584, -- Soothing Spearmint Candy
  37585, -- Chewy Fel Taffy
  37604, -- Tooth Pick
  37750, -- Fresh Brewfest Hops
  37863, -- Direbrew's Remote
  37902, -- Springtime Stout
  37903, -- Blackrock Lager
  37904, -- Stranglethorn Brew
  37905, -- Draenic Pale Ale
  38186, -- Ethereal Credit
  38233, -- Path of Illidan
  38291, -- Ethereal Mutagen
  38294, -- Ethereal Liqueur
  38300, -- Diluted Ethereum Essence
  38308, -- Ethereal Essence Sphere
  38320, -- Dire Brew
  38518, -- Cro's Apple
  38577, -- Party G.R.E.N.A.D.E.
  39476, -- Fresh Goblin Brewfest Hops
  39477, -- Fresh Dwarven Brewfest Hops
}

-- Elixirs
database["Elixirs"] = {
  22823, -- Elixir of Camouflage
  22824, -- Elixir of Major Strength
  22825, -- Elixir of Healing Power
  22827, -- Elixir of Major Frost Power
  22830, -- Elixir of the Searching Eye
  22831, -- Elixir of Major Agility
  22833, -- Elixir of Major Firepower
  22834, -- Elixir of Major Defense
  22835, -- Elixir of Major Shadow Power
  22840, -- Elixir of Major Mageblood
  22848, -- Elixir of Empowerment
  23444, -- Goldenmist Special Brew
  25539, -- Potion of Water Breathing
  28102, -- Onslaught Elixir
  28103, -- Adept's Elixir
  28104, -- Elixir of Mastery
  31679, -- Fel Strength Elixir
  32062, -- Elixir of Major Fortitude
  32063, -- Earthen Elixir
  32067, -- Elixir of Draenic Wisdom
  32068, -- Elixir of Ironskin
  34130, -- Recovery Diver's Potion
  34537, -- Bloodberry Elixir
}

-- Flasks
database["Flasks"] = {
  22851, -- Flask of Fortification
  22853, -- Flask of Mighty Versatility
  22854, -- Flask of Relentless Assault
  22861, -- Flask of Blinding Light
  22866, -- Flask of Pure Death
  32596, -- Unstable Flask of the Elder
  32597, -- Unstable Flask of the Soldier
  32598, -- Unstable Flask of the Beast
  32599, -- Unstable Flask of the Bandit
  32600, -- Unstable Flask of the Physician
  32601, -- Unstable Flask of the Sorcerer
  32898, -- Shattrath Flask of Fortification
  32899, -- Shattrath Flask of Mighty Restoration
  32900, -- Shattrath Flask of Supreme Power
  32901, -- Shattrath Flask of Relentless Assault
  35716, -- Shattrath Flask of Pure Death
  35717, -- Shattrath Flask of Blinding Light
}

-- Potions
database["Potions"] = {
  22826, -- Sneaking Potion
  22828, -- Insane Strength Potion
  22829, -- Super Healing Potion
  22832, -- Super Mana Potion
  22836, -- Major Dreamless Sleep Potion
  22837, -- Heroic Potion
  22838, -- Haste Potion
  22839, -- Destruction Potion
  22841, -- Major Fire Protection Potion
  22842, -- Major Frost Protection Potion
  22844, -- Major Nature Protection Potion
  22845, -- Major Arcane Protection Potion
  22846, -- Major Shadow Protection Potion
  22847, -- Major Holy Protection Potion
  22849, -- Ironshield Potion
  22850, -- Super Rejuvenation Potion
  22871, -- Shrouding Potion
  28100, -- Volatile Healing Potion
  28101, -- Unstable Mana Potion
  31676, -- Fel Regeneration Potion
  31677, -- Fel Mana Potion
  31853, -- Major Combat Healing Potion
  31855, -- Major Combat Mana Potion
  32783, -- Blue Ogre Brew
  32784, -- Red Ogre Brew
  32840, -- Major Arcane Protection Potion
  32844, -- Major Nature Protection Potion
  32845, -- Major Shadow Protection Potion
  32846, -- Major Fire Protection Potion
  32847, -- Major Frost Protection Potion
  32902, -- Bottled Nethergon Energy
  32903, -- Cenarion Mana Salve
  32904, -- Cenarion Healing Salve
  32905, -- Bottled Nethergon Vapor
  32909, -- Blue Ogre Brew Special
  32910, -- Red Ogre Brew Special
  32947, -- Auchenai Healing Potion
  32948, -- Auchenai Mana Potion
  33092, -- Healing Potion Injector
  33093, -- Mana Potion Injector
  33934, -- Crystal Healing Potion
  33935, -- Crystal Mana Potion
  34440, -- Mad Alchemist's Potion
  35287, -- Luminous Bluetail
}

-- Alchemy Recipes
database["AlchemyRecipes"] = {
  22900, -- Recipe: Elixir of Camouflage
  22901, -- Recipe: Sneaking Potion
  22902, -- Recipe: Elixir of Major Frost Power
  22903, -- Recipe: Insane Strength Potion
  22904, -- Recipe: Elixir of the Searching Eye
  22905, -- Recipe: Elixir of Major Agility
  22906, -- Recipe: Shrouding Potion
  22907, -- Recipe: Super Mana Potion
  22908, -- Recipe: Elixir of Major Firepower
  22909, -- Recipe: Elixir of Major Defense
  22910, -- Recipe: Elixir of Major Shadow Power
  22911, -- Recipe: Major Dreamless Sleep Potion
  22912, -- Recipe: Heroic Potion
  22913, -- Recipe: Haste Potion
  22914, -- Recipe: Destruction Potion
  22915, -- Recipe: Transmute Primal Air to Fire
  22916, -- Recipe: Transmute Primal Earth to Water
  22917, -- Recipe: Transmute Primal Fire to Earth
  22918, -- Recipe: Transmute Primal Water to Air
  22919, -- Recipe: Elixir of Major Mageblood
  22920, -- Recipe: Major Fire Protection Potion
  22921, -- Recipe: Major Frost Protection Potion
  22922, -- Recipe: Major Nature Protection Potion
  22923, -- Recipe: Major Arcane Protection Potion
  22924, -- Recipe: Major Shadow Protection Potion
  22925, -- Recipe: Major Holy Protection Potion
  22926, -- Recipe: Elixir of Empowerment
  22927, -- Recipe: Ironshield Potion
  23574, -- Recipe: Transmute Primal Might
  24001, -- Recipe: Elixir of Major Agility
  25869, -- Recipe: Transmute Earthstorm Diamond
  25870, -- Recipe: Transmute Skyfire Diamond
  29232, -- Recipe: Transmute Skyfire Diamond
  30443, -- Recipe: Transmute Primal Fire to Earth
  31354, -- Recipe: Flask of the Titans
  31355, -- Recipe: Flask of Supreme Power
  31356, -- Recipe: Flask of Distilled Wisdom
  31680, -- Recipe: Fel Strength Elixir
  31681, -- Recipe: Fel Regeneration Potion
  31682, -- Recipe: Fel Mana Potion
  32070, -- Recipe: Earthen Elixir
  32071, -- Recipe: Elixir of Ironskin
  35294, -- Recipe: Elixir of Empowerment
  35295, -- Recipe: Haste Potion
  35752, -- Recipe: Guardian's Alchemist Stone
  35753, -- Recipe: Sorcerer's Alchemist Stone
  35754, -- Recipe: Redeemer's Alchemist Stone
  35755, -- Recipe: Assassin's Alchemist Stone
}

-- Blacksmithing Recipes
database["BlacksmithingRecipes"] = {
  23590, -- Plans: Adamantite Maul
  23591, -- Plans: Adamantite Cleaver
  23592, -- Plans: Adamantite Dagger
  23593, -- Plans: Adamantite Rapier
  23594, -- Plans: Adamantite Plate Bracers
  23595, -- Plans: Adamantite Plate Gloves
  23596, -- Plans: Adamantite Breastplate
  23597, -- Plans: Enchanted Adamantite Belt
  23598, -- Plans: Enchanted Adamantite Boots
  23599, -- Plans: Enchanted Adamantite Breastplate
  23600, -- Plans: Enchanted Adamantite Leggings
  23601, -- Plans: Flamebane Bracers
  23602, -- Plans: Flamebane Helm
  23603, -- Plans: Flamebane Gloves
  23604, -- Plans: Flamebane Breastplate
  23605, -- Plans: Felsteel Gloves
  23606, -- Plans: Felsteel Leggings
  23607, -- Plans: Felsteel Helm
  23608, -- Plans: Khorium Belt
  23609, -- Plans: Khorium Pants
  23610, -- Plans: Khorium Boots
  23611, -- Plans: Ragesteel Gloves
  23612, -- Plans: Ragesteel Helm
  23613, -- Plans: Ragesteel Breastplate
  23615, -- Plans: Swiftsteel Gloves
  23617, -- Plans: Earthpeace Breastplate
  23618, -- Plans: Adamantite Sharpening Stone
  23619, -- Plans: Felsteel Shield Spike
  23620, -- Plans: Felfury Gauntlets
  23621, -- Plans: Gauntlets of the Iron Tower
  23622, -- Plans: Steelgrip Gauntlets
  23623, -- Plans: Storm Helm
  23624, -- Plans: Helm of the Stalwart Defender
  23625, -- Plans: Oathkeeper's Helm
  23626, -- Plans: Black Felsteel Bracers
  23627, -- Plans: Bracers of the Green Fortress
  23628, -- Plans: Blessed Bracers
  23629, -- Plans: Felsteel Longblade
  23630, -- Plans: Khorium Champion
  23631, -- Plans: Fel Edged Battleaxe
  23632, -- Plans: Felsteel Reaper
  23633, -- Plans: Runic Hammer
  23634, -- Plans: Fel Hardened Maul
  23635, -- Plans: Eternium Runed Blade
  23636, -- Plans: Dirge
  23637, -- Plans: Hand of Eternity
  23638, -- Plans: Lesser Ward of Shielding
  23639, -- Plans: Greater Ward of Shielding
  24002, -- Plans: Felsteel Shield Spike
  25526, -- Plans: Greater Rune of Warding
  28632, -- Plans: Adamantite Weightstone
  30321, -- Plans: Belt of the Guardian
  30322, -- Plans: Red Belt of Battle
  30323, -- Plans: Boots of the Protector
  30324, -- Plans: Red Havoc Boots
  31390, -- Plans: Wildguard Breastplate
  31391, -- Plans: Wildguard Leggings
  31392, -- Plans: Wildguard Helm
  31393, -- Plans: Iceguard Breastplate
  31394, -- Plans: Iceguard Leggings
  31395, -- Plans: Iceguard Helm
  32441, -- Plans: Shadesteel Sabots
  32442, -- Plans: Shadesteel Bracers
  32443, -- Plans: Shadesteel Greaves
  32444, -- Plans: Shadesteel Girdle
  32736, -- Plans: Swiftsteel Bracers
  32737, -- Plans: Swiftsteel Shoulders
  32738, -- Plans: Dawnsteel Bracers
  32739, -- Plans: Dawnsteel Shoulders
  33174, -- Plans: Ragesteel Shoulders
  33186, -- Plans: Adamantite Weapon Chain
  33792, -- Plans: Heavy Copper Longsword
  33954, -- Plans: Hammer of Righteous Might
  35208, -- Plans: Sunblessed Gauntlets
  35209, -- Plans: Hard Khorium Battlefists
  35210, -- Plans: Sunblessed Breastplate
  35211, -- Plans: Hard Khorium Battleplate
  35296, -- Plans: Adamantite Weapon Chain
}

-- Cooking Recipes
database["CookingRecipes"] = {
  22647, -- Recipe: Crunchy Spider Surprise
  27684, -- Recipe: Buzzard Bites
  27685, -- Recipe: Lynx Steak
  27686, -- Recipe: Roasted Moongraze Tenderloin
  27687, -- Recipe: Bat Bites
  27688, -- Recipe: Ravager Dog
  27690, -- Recipe: Blackened Basilisk
  27691, -- Recipe: Roasted Clefthoof
  27692, -- Recipe: Warp Burger
  27693, -- Recipe: Talbuk Steak
  27694, -- Recipe: Blackened Trout
  27695, -- Recipe: Feltail Delight
  27696, -- Recipe: Blackened Sporefish
  27697, -- Recipe: Grilled Mudfish
  27698, -- Recipe: Poached Bluefish
  27699, -- Recipe: Golden Fish Sticks
  27700, -- Recipe: Spicy Crawdad
  27736, -- Master Cookbook
  30156, -- Recipe: Clam Bar
  31674, -- Recipe: Crunchy Serpent
  31675, -- Recipe: Mok'Nathal Shortribs
  33869, -- Recipe: Broiled Bloodfin
  33870, -- Recipe: Skullfish Soup
  33871, -- Recipe: Stormchops
  33873, -- Recipe: Spicy Hot Talbuk
  33875, -- Recipe: Kibler's Bits
  33925, -- Recipe: Delicious Chocolate Cake
  34413, -- Recipe: Hot Apple Cider
  34834, -- Recipe: Captain Rumsey's Lager
  35564, -- Recipe: Charred Bear Kabobs
  35566, -- Recipe: Juicy Bear Burger
}

-- Enchanting Recipes
database["EnchantingRecipes"] = {
  22530, -- Formula: Enchant Bracer - Greater Dodge
  22531, -- Formula: Enchant Bracer - Superior Healing
  22532, -- Formula: Enchant Bracer - Versatility Prime
  22533, -- Formula: Enchant Bracer - Fortitude
  22534, -- Formula: Enchant Bracer - Spellpower
  22537, -- Formula: Enchant Ring - Healing Power
  22538, -- ERROR1
  22539, -- Formula: Enchant Shield - Intellect
  22540, -- Formula: Enchant Shield - Parry
  22542, -- Formula: Enchant Boots - Vitality
  22543, -- Formula: Enchant Boots - Fortitude
  22544, -- Formula: Enchant Boots - Dexterity
  22545, -- Formula: Enchant Boots - Surefooted
  22547, -- Formula: Enchant Chest - Exceptional Stats
  22551, -- Formula: Enchant Weapon - Major Intellect
  22552, -- Formula: Enchant Weapon - Major Striking
  22553, -- Formula: Enchant Weapon - Potency
  22554, -- Formula: Enchant 2H Weapon - Savagery
  22555, -- Formula: Enchant Weapon - Major Spellpower
  22556, -- Formula: Enchant 2H Weapon - Major Agility
  22557, -- Formula: Enchant Weapon - Battlemaster
  22558, -- Formula: Enchant Weapon - Spellsurge
  22559, -- Formula: Enchant Weapon - Mongoose
  22560, -- Formula: Enchant Weapon - Sunfire
  22561, -- Formula: Enchant Weapon - Soulfrost
  22562, -- Formula: Superior Mana Oil
  22563, -- Formula: Superior Wizard Oil
  22565, -- Formula: Large Prismatic Shard
  24000, -- Formula: Enchant Bracer - Superior Healing
  24003, -- Formula: Enchant Chest - Exceptional Stats
  28270, -- Formula: Enchant Chest - Major Resilience
  28271, -- Formula: Enchant Gloves - Precise Strikes
  28272, -- Formula: Enchant Gloves - Major Spellpower
  28273, -- Formula: Enchant Gloves - Major Healing
  28274, -- Formula: Enchant Cloak - PvP Power
  28279, -- Formula: Enchant Boots - Cat's Swiftness
  28280, -- Formula: Enchant Boots - Boar's Speed
  28281, -- Formula: Enchant Weapon - Major Healing
  28282, -- Formula: Enchant Shield - Major Stamina
  33148, -- Formula: Enchant Cloak - Dodge
  33149, -- Formula: Enchant Cloak - Stealth
  33150, -- Formula: Enchant Cloak - Subtlety
  33151, -- Formula: Enchant Cloak - Subtlety
  33152, -- Formula: Enchant Gloves - Superior Agility
  33153, -- Formula: Enchant Gloves - Threat
  33165, -- Formula: Enchant Weapon - Greater Agility
  33307, -- Formula: Enchant Weapon - Executioner
  34872, -- Formula: Void Shatter
  35297, -- Formula: Enchant Boots - Boar's Speed
  35298, -- Formula: Enchant Boots - Vitality
  35299, -- Formula: Enchant Boots - Cat's Swiftness
  35498, -- Formula: Enchant Weapon - Deathfrost
  35500, -- Formula: Enchant Chest - Dodge
  35756, -- Formula: Enchant Cloak - Greater Dodge
}

-- Engineering Recipes
database["EngineeringRecipes"] = {
  21724, -- Schematic: Small Blue Rocket
  21725, -- Schematic: Small Green Rocket
  21726, -- Schematic: Small Red Rocket
  21727, -- Schematic: Large Blue Rocket
  21730, -- Schematic: Blue Rocket Cluster
  21731, -- Schematic: Green Rocket Cluster
  21732, -- Schematic: Red Rocket Cluster
  22729, -- Schematic: Steam Tonk Controller
  23799, -- Schematic: Adamantite Rifle
  23800, -- Schematic: Felsteel Boomstick
  23802, -- Schematic: Ornate Khorium Rifle
  23803, -- Schematic: Cogspinner Goggles
  23804, -- Schematic: Power Amplification Goggles
  23805, -- Schematic: Ultra-Spectropic Detection Goggles
  23806, -- Schematic: Hyper-Vision Goggles
  23807, -- Schematic: Adamantite Scope
  23808, -- Schematic: Khorium Scope
  23809, -- Schematic: Stabilized Eternium Scope
  23810, -- Schematic: Crashin' Thrashin' Robot
  23811, -- Schematic: White Smoke Flare
  23814, -- Schematic: Green Smoke Flare
  23816, -- Schematic: Fel Iron Toolbox
  23874, -- Schematic: Elemental Seaforium Charge
  23883, -- Schematic: Healing Potion Injector
  23884, -- Schematic: Mana Potion Injector
  23887, -- Schematic: Rocket Boots Xtreme
  23888, -- Schematic: Zapthrottle Mote Extractor
  25887, -- Schematic: Purple Smoke Flare
  32381, -- Schematic: Fused Wiring
  34114, -- Schematic: Field Repair Bot 110G
  35186, -- Schematic: Annihilator Holo-Gogs
  35187, -- Schematic: Justicebringer 3000 Specs
  35189, -- Schematic: Powerheal 9000 Lens
  35190, -- Schematic: Hyper-Magnified Moon Specs
  35191, -- Schematic: Wonderheal XT68 Shades
  35192, -- Schematic: Primal-Attuned Goggles
  35193, -- Schematic: Lightning Etched Specs
  35194, -- Schematic: Surestrike Goggles v3.0
  35195, -- Schematic: Mayhem Projection Goggles
  35196, -- Schematic: Hard Khorium Goggles
  35197, -- Schematic: Quad Deathblow X44 Goggles
  35310, -- Schematic: Healing Potion Injector
  35311, -- Schematic: Mana Potion Injector
  35582, -- Schematic: Rocket Boots Xtreme Lite
}

-- Fishing Recipes
database["FishingRecipes"] = {
  27532, -- Master Fishing - The Art of Angling
  34109, -- Weather-Beaten Journal
}

-- Jewelcrafting Recipes
database["JewelcraftingRecipes"] = {
  20854, -- Design: Amulet of the Moon
  20855, -- Design: Wicked Moonstone Ring
  20856, -- Design: Heavy Golden Necklace of Battle
  20970, -- Design: Pendant of the Agate Shield
  20971, -- Design: Heavy Iron Knuckles
  20973, -- Design: Blazing Citrine Ring
  20974, -- Design: Jade Pendant of Blasting
  20975, -- Design: The Jade Eye
  20976, -- Design: Citrine Pendant of Golden Healing
  21940, -- Design: Golden Hare
  21941, -- Design: Black Pearl Panther
  21942, -- Design: Ruby Crown of Restoration
  21943, -- Design: Truesilver Crab
  21944, -- Design: Truesilver Boar
  21945, -- Design: The Aquamarine Ward
  21947, -- Design: Gem Studded Band
  21948, -- Design: Opal Necklace of Impact
  21949, -- Design: Ruby Serpent
  21952, -- Design: Emerald Crown of Destruction
  21953, -- Design: Emerald Owl
  21954, -- Design: Ring of Bitter Shadows
  21955, -- Design: Black Diamond Crab
  21956, -- Design: Dark Iron Scorpid
  21957, -- Design: Necklace of the Diamond Tower
  23131, -- Design: Bold Blood Garnet
  23133, -- Design: Brilliant Blood Garnet
  23134, -- Design: Delicate Blood Garnet
  23135, -- Design: Inscribed Flame Spessarite
  23136, -- Design: Reckless Flame Spessarite
  23137, -- Design: Glinting Shadow Draenite
  23138, -- Design: Potent Flame Spessarite
  23140, -- Design: Radiant Deep Peridot
  23141, -- Design: Jagged Deep Peridot
  23142, -- Design: Regal Deep Peridot
  23144, -- Design: Timeless Shadow Draenite
  23145, -- Design: Purified Shadow Draenite
  23146, -- Design: Shifting Shadow Draenite
  23149, -- Design: Smooth Golden Draenite
  23150, -- Design: Subtle Golden Draenite
  23152, -- Design: Solid Azure Moonstone
  23154, -- Design: Stormy Azure Moonstone
  23155, -- Design: Sparkling Azure Moonstone
  24158, -- Design: Khorium Band of Shadows
  24159, -- Design: Khorium Band of Frost
  24160, -- Design: Khorium Inferno Band
  24161, -- Design: Khorium Band of Leaves
  24162, -- Design: Arcane Khorium Band
  24163, -- Design: Heavy Felsteel Ring
  24164, -- Design: Delicate Eternium Ring
  24165, -- Design: Blazing Eternium Band
  24166, -- Design: Thick Felsteel Necklace
  24167, -- Design: Living Ruby Pendant
  24168, -- Design: Braided Eternium Chain
  24169, -- Design: Eye of the Night
  24170, -- Design: Embrace of the Dawn
  24171, -- Design: Chain of the Twilight Owl
  24172, -- Design: Coronet of Verdant Flame
  24173, -- Design: Circlet of Arcane Might
  24174, -- Design: Pendant of Frozen Flame
  24175, -- Design: Pendant of Thawing
  24176, -- Design: Pendant of Withering
  24177, -- Design: Pendant of Shadow's End
  24178, -- Design: Pendant of the Null Rune
  24179, -- Design: Felsteel Boar
  24180, -- Design: Dawnstone Crab
  24181, -- Design: Living Ruby Serpent
  24182, -- Design: Talasite Owl
  24183, -- Design: Nightseye Panther
  24192, -- Design: Delicate Living Ruby
  24193, -- Design: Bold Living Ruby
  24194, -- Design: Delicate Living Ruby
  24196, -- Design: Brilliant Living Ruby
  24197, -- Design: Subtle Dawnstone
  24198, -- Design: Flashing Living Ruby
  24199, -- Design: Solid Star of Elune
  24200, -- Design: Sparkling Star of Elune
  24201, -- Design: Sparkling Star of Elune
  24202, -- Design: Stormy Star of Elune
  24203, -- Design: Brilliant Living Ruby
  24204, -- Design: Smooth Dawnstone
  24205, -- Design: Rigid Star of Elune
  24206, -- Design: Smooth Dawnstone
  24208, -- Design: Mystic Dawnstone
  24209, -- Design: Sovereign Nightseye
  24210, -- Design: Shifting Nightseye
  24211, -- Design: Timeless Nightseye
  24212, -- Design: Purified Nightseye
  24213, -- Design: Inscribed Noble Topaz
  24214, -- Design: Potent Noble Topaz
  24215, -- Design: Reckless Noble Topaz
  24216, -- Design: Glinting Nightseye
  24217, -- Design: Regal Talasite
  24218, -- Design: Radiant Talasite
  24219, -- Design: Purified Nightseye
  24220, -- Design: Jagged Talasite
  25902, -- Design: Powerful Earthstorm Diamond
  25903, -- Design: Bracing Earthstorm Diamond
  25904, -- Design: Insightful Earthstorm Diamond
  25905, -- Design: Tenacious Earthstorm Diamond
  25906, -- Design: Brutal Earthstorm Diamond
  25907, -- Design: Destructive Skyfire Diamond
  25908, -- Design: Swift Skyfire Diamond
  25909, -- Design: Mystical Skyfire Diamond
  25910, -- Design: Enigmatic Skyfire Diamond
  30826, -- Design: Ring of Arcane Shielding
  31358, -- Design: Dawnstone Crab
  31359, -- Design: Regal Deep Peridot
  31401, -- Design: The Frozen Eye
  31402, -- Design: The Natural Ward
  31870, -- Design: Rigid Azure Moonstone
  31873, -- Design: Veiled Shadow Draenite
  31874, -- Design: Deadly Flame Spessarite
  31875, -- Design: Rigid Star of Elune
  31876, -- Design: Shifting Nightseye
  31877, -- Design: Glinting Nightseye
  31878, -- Design: Veiled Nightseye
  31879, -- Design: Deadly Noble Topaz
  32274, -- Design: Bold Crimson Spinel
  32277, -- Design: Delicate Crimson Spinel
  32282, -- Design: Brilliant Crimson Spinel
  32284, -- Design: Subtle Lionseye
  32285, -- Design: Flashing Crimson Spinel
  32286, -- Design: Solid Empyrean Sapphire
  32287, -- Design: Sparkling Empyrean Sapphire
  32289, -- Design: Stormy Empyrean Sapphire
  32291, -- Design: Smooth Lionseye
  32292, -- Design: Rigid Empyrean Sapphire
  32293, -- Design: Smooth Lionseye
  32294, -- Design: Subtle Lionseye
  32295, -- Design: Mystic Lionseye
  32296, -- Design: Rigid Empyrean Sapphire
  32297, -- Design: Sovereign Shadowsong Amethyst
  32298, -- Design: Shifting Shadowsong Amethyst
  32299, -- Design: Shifting Shadowsong Amethyst
  32300, -- Design: Glinting Shadowsong Amethyst
  32301, -- Design: Timeless Shadowsong Amethyst
  32303, -- Design: Inscribed Pyrestone
  32304, -- Design: Potent Pyrestone
  32305, -- Design: Reckless Pyrestone
  32306, -- Design: Glinting Shadowsong Amethyst
  32307, -- Design: Veiled Shadowsong Amethyst
  32308, -- Design: Deadly Pyrestone
  32309, -- Design: Regal Seaspray Emerald
  32310, -- Design: Radiant Seaspray Emerald
  32311, -- Design: Purified Shadowsong Amethyst
  32312, -- Design: Jagged Seaspray Emerald
  32411, -- Design: Thundering Skyfire Diamond
  33155, -- Design: Kailee's Rose
  33156, -- Design: Crimson Sun
  33157, -- Design: Falling Star
  33158, -- Design: Stone of Blades
  33159, -- Design: Blood of Amber
  33160, -- Design: Facet of Eternity
  33305, -- Design: Don Julio's Heart
  33622, -- Design: Relentless Earthstorm Diamond
  33783, -- Design: Steady Talasite
  34689, -- Design: Chaotic Skyfire Diamond
  35198, -- Design: Loop of Forged Power
  35199, -- Design: Ring of Flowing Life
  35200, -- Design: Hard Khorium Band
  35201, -- Design: Pendant of Sunfire
  35202, -- Design: Amulet of Flowing Life
  35203, -- Design: Hard Khorium Choker
  35239, -- Design: Timeless Shadowsong Amethyst
  35242, -- Design: Shifting Shadowsong Amethyst
  35243, -- Design: Sovereign Shadowsong Amethyst
  35244, -- Design: Bold Crimson Spinel
  35246, -- Design: Delicate Crimson Spinel
  35247, -- Design: Flashing Crimson Spinel
  35248, -- Design: Brilliant Crimson Spinel
  35249, -- Design: Subtle Lionseye
  35251, -- Design: Purified Shadowsong Amethyst
  35252, -- Design: Regal Seaspray Emerald
  35253, -- Design: Jagged Seaspray Emerald
  35254, -- Design: Radiant Seaspray Emerald
  35258, -- Design: Mystic Lionseye
  35259, -- Design: Rigid Empyrean Sapphire
  35260, -- Design: Smooth Lionseye
  35263, -- Design: Solid Empyrean Sapphire
  35264, -- Design: Sparkling Empyrean Sapphire
  35265, -- Design: Stormy Empyrean Sapphire
  35266, -- Design: Glinting Shadowsong Amethyst
  35267, -- Design: Inscribed Pyrestone
  35269, -- Design: Potent Pyrestone
  35270, -- Design: Veiled Shadowsong Amethyst
  35271, -- Design: Deadly Pyrestone
  35304, -- Design: Solid Star of Elune
  35305, -- Design: Brilliant Living Ruby
  35307, -- Design: Rigid Star of Elune
  35322, -- Design: Quick Dawnstone
  35323, -- Design: Reckless Noble Topaz
  35325, -- Design: Forceful Talasite
  35502, -- Design: Eternal Earthstorm Diamond
  35505, -- Design: Ember Skyfire Diamond
  35695, -- Design: Figurine - Empyrean Tortoise
  35696, -- Design: Figurine - Khorium Boar
  35697, -- Design: Figurine - Crimson Serpent
  35698, -- Design: Figurine - Shadowsong Panther
  35699, -- Design: Figurine - Seaspray Albatross
  35708, -- Design: Regal Talasite
  35762, -- Design: Reckless Pyrestone
  35763, -- Design: Quick Lionseye
  35764, -- Design: Steady Seaspray Emerald
  35765, -- Design: Forceful Seaspray Emerald
  35766, -- Design: Steady Seaspray Emerald
  35767, -- Design: Reckless Pyrestone
  35768, -- Design: Quick Lionseye
  35769, -- Design: Forceful Seaspray Emerald
}

-- Leatherworking  Recipes
database["LeatherworkingRecipes"] = {
  25720, -- Pattern: Heavy Knothide Leather
  25721, -- Pattern: Vindicator's Armor Kit
  25722, -- Pattern: Magister's Armor Kit
  25725, -- Pattern: Riding Crop
  25726, -- Pattern: Comfortable Insoles
  25728, -- Pattern: Stylin' Purple Hat
  25729, -- Pattern: Stylin' Adventure Hat
  25730, -- Pattern: Stylin' Jungle Hat
  25731, -- Pattern: Stylin' Crimson Hat
  25732, -- Pattern: Fel Leather Gloves
  25733, -- Pattern: Fel Leather Boots
  25734, -- Pattern: Fel Leather Leggings
  25735, -- Pattern: Heavy Clefthoof Vest
  25736, -- Pattern: Heavy Clefthoof Leggings
  25737, -- Pattern: Heavy Clefthoof Boots
  25738, -- Pattern: Felstalker Belt
  25739, -- Pattern: Felstalker Bracers
  25740, -- Pattern: Felstalker Breastplate
  25741, -- Pattern: Netherfury Belt
  25742, -- Pattern: Netherfury Leggings
  25743, -- Pattern: Netherfury Boots
  29213, -- Pattern: Felstalker Belt
  29214, -- Pattern: Felstalker Bracers
  29215, -- Pattern: Felstalker Breastplate
  29217, -- Pattern: Netherfury Belt
  29218, -- Pattern: Netherfury Boots
  29219, -- Pattern: Netherfury Leggings
  29664, -- Pattern: Reinforced Mining Bag
  29677, -- Pattern: Enchanted Felscale Leggings
  29682, -- Pattern: Enchanted Felscale Gloves
  29684, -- Pattern: Enchanted Felscale Boots
  29689, -- Pattern: Flamescale Leggings
  29691, -- Pattern: Flamescale Boots
  29693, -- Pattern: Flamescale Belt
  29698, -- Pattern: Enchanted Clefthoof Leggings
  29700, -- Pattern: Enchanted Clefthoof Gloves
  29701, -- Pattern: Enchanted Clefthoof Boots
  29702, -- Pattern: Blastguard Pants
  29703, -- Pattern: Blastguard Boots
  29704, -- Pattern: Blastguard Belt
  29713, -- Pattern: Drums of Panic
  29714, -- Pattern: Drums of Restoration
  29717, -- Pattern: Drums of Battle
  29718, -- Pattern: Drums of Speed
  29719, -- Pattern: Cobrahide Leg Armor
  29720, -- Pattern: Clefthide Leg Armor
  29721, -- Pattern: Nethercleft Leg Armor
  29722, -- Pattern: Nethercobra Leg Armor
  29723, -- Pattern: Cobrascale Hood
  29724, -- Pattern: Cobrascale Gloves
  29725, -- Pattern: Windscale Hood
  29726, -- Pattern: Hood of Primal Life
  29727, -- Pattern: Gloves of the Living Touch
  29728, -- Pattern: Windslayer Wraps
  29729, -- Pattern: Living Dragonscale Helm
  29730, -- Pattern: Earthen Netherscale Boots
  29731, -- Pattern: Windstrike Gloves
  29732, -- Pattern: Netherdrake Helm
  29733, -- Pattern: Netherdrake Gloves
  29734, -- Pattern: Thick Netherscale Breastplate
  30301, -- Pattern: Belt of Natural Power
  30302, -- Pattern: Belt of Deep Shadow
  30303, -- Pattern: Belt of the Black Eagle
  30304, -- Pattern: Monsoon Belt
  30305, -- Pattern: Boots of Natural Grace
  30306, -- Pattern: Boots of Utter Darkness
  30307, -- Pattern: Boots of the Crimson Hawk
  30308, -- Pattern: Hurricane Boots
  30444, -- Pattern: Reinforced Mining Bag
  31361, -- Pattern: Cobrahide Leg Armor
  31362, -- Pattern: Nethercobra Leg Armor
  32429, -- Pattern: Boots of Shackled Souls
  32430, -- Pattern: Bracers of Shackled Souls
  32431, -- Pattern: Greaves of Shackled Souls
  32432, -- Pattern: Waistguard of Shackled Souls
  32433, -- Pattern: Redeemed Soul Moccasins
  32434, -- Pattern: Redeemed Soul Wristguards
  32435, -- Pattern: Redeemed Soul Legguards
  32436, -- Pattern: Redeemed Soul Cinch
  32744, -- Pattern: Bracers of Renewed Life
  32745, -- Pattern: Shoulderpads of Renewed Life
  32746, -- Pattern: Swiftstrike Bracers
  32747, -- Pattern: Swiftstrike Shoulders
  32748, -- Pattern: Bindings of Lightning Reflexes
  32749, -- Pattern: Shoulders of Lightning Reflexes
  32750, -- Pattern: Living Earth Bindings
  32751, -- Pattern: Living Earth Shoulders
  33124, -- Pattern: Cloak of Darkness
  33205, -- Pattern: Shadowprowler's Chestguard
  34172, -- Pattern: Drums of Speed
  34173, -- Pattern: Drums of Speed
  34174, -- Pattern: Drums of Restoration
  34175, -- Pattern: Drums of Restoration
  34262, -- Pattern: Winter Boots
  34491, -- Pattern: Bag of Many Hides
  35212, -- Pattern: Leather Gauntlets of the Sun
  35213, -- Pattern: Fletcher's Gloves of the Phoenix
  35214, -- Pattern: Gloves of Immortal Dusk
  35215, -- Pattern: Sun-Drenched Scale Gloves
  35216, -- Pattern: Leather Chestguard of the Sun
  35217, -- Pattern: Embrace of the Phoenix
  35218, -- Pattern: Carapace of Sun and Shadow
  35219, -- Pattern: Sun-Drenched Scale Chestguard
  35300, -- Pattern: Windstrike Gloves
  35301, -- Pattern: Netherdrake Gloves
  35302, -- Pattern: Cobrascale Gloves
  35303, -- Pattern: Gloves of the Living Touch
}

-- Mining Recipes
database["MiningRecipes"] = {
  35273, -- Study of Advanced Smelting
}

-- Tailoring Recipes
database["TailoringRecipes"] = {
  21892, -- Pattern: Bolt of Imbued Netherweave
  21893, -- Pattern: Imbued Netherweave Bag
  21894, -- Pattern: Bolt of Soulcloth
  21895, -- Pattern: Primal Mooncloth
  21896, -- Pattern: Netherweave Robe
  21897, -- Pattern: Netherweave Tunic
  21898, -- Pattern: Imbued Netherweave Pants
  21899, -- Pattern: Imbued Netherweave Boots
  21900, -- Pattern: Imbued Netherweave Robe
  21901, -- Pattern: Imbued Netherweave Tunic
  21902, -- Pattern: Soulcloth Gloves
  21903, -- Pattern: Soulcloth Shoulders
  21904, -- Pattern: Soulcloth Vest
  21905, -- Pattern: Arcanoweave Bracers
  21906, -- Pattern: Arcanoweave Boots
  21907, -- Pattern: Arcanoweave Robe
  21908, -- Pattern: Spellfire Belt
  21909, -- Pattern: Spellfire Gloves
  21910, -- Pattern: Spellfire Robe
  21911, -- Pattern: Spellfire Bag
  21912, -- Pattern: Frozen Shadoweave Shoulders
  21913, -- Pattern: Frozen Shadoweave Robe
  21914, -- Pattern: Frozen Shadoweave Boots
  21915, -- Pattern: Ebon Shadowbag
  21916, -- Pattern: Primal Mooncloth Belt
  21917, -- Pattern: Primal Mooncloth Robe
  21918, -- Pattern: Primal Mooncloth Shoulders
  21919, -- Pattern: Primal Mooncloth Bag
  21992, -- Manual: Netherweave Bandage
  21993, -- Manual: Heavy Netherweave Bandage
  24292, -- Pattern: Mystic Spellthread
  24293, -- Pattern: Silver Spellthread
  24294, -- Pattern: Runic Spellthread
  24295, -- Pattern: Golden Spellthread
  24296, -- Pattern: Unyielding Bracers
  24297, -- Pattern: Bracers of Havok
  24298, -- Pattern: Blackstrike Bracers
  24299, -- Pattern: Cloak of the Black Void
  24300, -- Pattern: Cloak of Eternity
  24301, -- Pattern: White Remedy Cape
  24302, -- Pattern: Unyielding Girdle
  24303, -- Pattern: Girdle of Ruination
  24304, -- Pattern: Black Belt of Knowledge
  24305, -- Pattern: Resolute Cape
  24306, -- Pattern: Vengeance Wrap
  24307, -- Pattern: Manaweave Cloak
  24308, -- Pattern: Whitemend Pants
  24309, -- Pattern: Spellstrike Pants
  24310, -- Pattern: Battlecast Pants
  24311, -- Pattern: Whitemend Hood
  24312, -- Pattern: Spellstrike Hood
  24313, -- Pattern: Battlecast Hood
  24314, -- Pattern: Bag of Jewels
  24316, -- Pattern: Spellcloth
  30280, -- Pattern: Belt of Blasting
  30281, -- Pattern: Belt of the Long Road
  30282, -- Pattern: Boots of Blasting
  30283, -- Pattern: Boots of the Long Road
  30483, -- Pattern: Shadowcloth
  30833, -- Pattern: Cloak of Arcane Evasion
  30842, -- Pattern: Flameheart Bracers
  30843, -- Pattern: Flameheart Gloves
  30844, -- Pattern: Flameheart Vest
  32437, -- Pattern: Soulguard Slippers
  32438, -- Pattern: Soulguard Bracers
  32439, -- Pattern: Soulguard Leggings
  32440, -- Pattern: Soulguard Girdle
  32447, -- Pattern: Night's End
  32752, -- Pattern: Swiftheal Wraps
  32753, -- Pattern: Swiftheal Mantle
  32754, -- Pattern: Bracers of Nimble Thought
  32755, -- Pattern: Mantle of Nimble Thought
  34261, -- Pattern: Green Winter Clothes
  34319, -- Pattern: Red Winter Clothes
  35204, -- Pattern: Sunfire Handwraps
  35205, -- Pattern: Hands of Eternal Light
  35206, -- Pattern: Sunfire Robe
  35207, -- Pattern: Robe of Eternal Light
  35308, -- Pattern: Unyielding Bracers
  35309, -- Pattern: Unyielding Girdle
  37915, -- Pattern: Dress Shoes
  38229, -- Pattern: Mycah's Botanical Bag
  38327, -- Pattern: Haliscan Jacket
  38328, -- Pattern: Haliscan Pantaloons
}

-- Gems
database["Gems"] = {
  22459, -- Void Sphere
  22460, -- Prismatic Sphere
  23094, -- Brilliant Blood Garnet
  23095, -- Bold Blood Garnet
  23098, -- Inscribed Flame Spessarite
  23099, -- Reckless Flame Spessarite
  23100, -- Glinting Shadow Draenite
  23101, -- Potent Flame Spessarite
  23103, -- Radiant Deep Peridot
  23104, -- Jagged Deep Peridot
  23105, -- Regal Deep Peridot
  23108, -- Timeless Shadow Draenite
  23109, -- Purified Shadow Draenite
  23110, -- Shifting Shadow Draenite
  23111, -- Sovereign Shadow Draenite
  23114, -- Smooth Golden Draenite
  23115, -- Subtle Golden Draenite
  23116, -- Rigid Azure Moonstone
  23118, -- Solid Azure Moonstone
  23119, -- Sparkling Azure Moonstone
  23120, -- Stormy Azure Moonstone
  24027, -- Bold Living Ruby
  24028, -- Delicate Living Ruby
  24030, -- Brilliant Living Ruby
  24032, -- Subtle Dawnstone
  24033, -- Solid Star of Elune
  24035, -- Sparkling Star of Elune
  24036, -- Flashing Living Ruby
  24039, -- Stormy Star of Elune
  24048, -- Smooth Dawnstone
  24051, -- Rigid Star of Elune
  24053, -- Mystic Dawnstone
  24054, -- Sovereign Nightseye
  24055, -- Shifting Nightseye
  24056, -- Timeless Nightseye
  24058, -- Inscribed Noble Topaz
  24059, -- Potent Noble Topaz
  24060, -- Reckless Noble Topaz
  24061, -- Glinting Nightseye
  24065, -- Purified Nightseye
  24066, -- Radiant Talasite
  24067, -- Jagged Talasite
  25890, -- Destructive Skyfire Diamond
  25893, -- Mystical Skyfire Diamond
  25894, -- Swift Skyfire Diamond
  25895, -- Enigmatic Skyfire Diamond
  25896, -- Powerful Earthstorm Diamond
  25897, -- Bracing Earthstorm Diamond
  25898, -- Tenacious Earthstorm Diamond
  25899, -- Brutal Earthstorm Diamond
  25901, -- Insightful Earthstorm Diamond
  27679, -- Mystic Dawnstone
  27777, -- Brilliant Blood Garnet
  27786, -- Jagged Deep Peridot
  27809, -- Jagged Deep Peridot
  27812, -- Brilliant Blood Garnet
  28118, -- Brilliant Ornate Ruby
  28119, -- Smooth Ornate Dawnstone
  28123, -- Potent Ornate Topaz
  28290, -- Smooth Golden Draenite
  28360, -- Delicate Blood Garnet
  28361, -- Delicate Blood Garnet
  28362, -- Delicate Ornate Ruby
  28363, -- Deadly Ornate Topaz
  28458, -- Bold Tourmaline
  28459, -- Delicate Tourmaline
  28461, -- Brilliant Tourmaline
  28463, -- Solid Zircon
  28464, -- Sparkling Zircon
  28467, -- Smooth Amber
  28468, -- Rigid Zircon
  28470, -- Subtle Amber
  28556, -- Swift Windfire Diamond
  28557, -- Quickened Starfire Diamond
  28595, -- Delicate Blood Garnet
  30546, -- Sovereign Tanzanite
  30547, -- Reckless Fire Opal
  30548, -- Jagged Chrysoprase
  30549, -- Shifting Tanzanite
  30550, -- Misty Chrysoprase
  30551, -- Reckless Fire Opal
  30552, -- Timeless Tanzanite
  30553, -- Glinting Tanzanite
  30554, -- Stalwart Fire Opal
  30555, -- Timeless Tanzanite
  30556, -- Glinting Tanzanite
  30558, -- Stalwart Fire Opal
  30559, -- Etched Tanzanite
  30560, -- Misty Chrysoprase
  30563, -- Regal Chrysoprase
  30564, -- Veiled Tanzanite
  30565, -- Jagged Chrysoprase
  30566, -- Defender's Tanzanite
  30571, -- Don Rodrigo's Heart
  30572, -- Purified Tanzanite
  30573, -- Mysterious Tanzanite
  30574, -- Shifting Tanzanite
  30575, -- Nimble Chrysoprase
  30581, -- Willful Fire Opal
  30582, -- Deadly Fire Opal
  30583, -- Timeless Tanzanite
  30584, -- Inscribed Fire Opal
  30585, -- Polished Fire Opal
  30586, -- Purified Tanzanite
  30587, -- Champion's Fire Opal
  30588, -- Potent Fire Opal
  30589, -- Purified Tanzanite
  30590, -- Regal Chrysoprase
  30591, -- Lucent Fire Opal
  30592, -- Steady Chrysoprase
  30593, -- Potent Fire Opal
  30594, -- Regal Chrysoprase
  30598, -- Don Amancio's Heart
  30600, -- Purified Tanzanite
  30601, -- Steady Chrysoprase
  30602, -- Jagged Chrysoprase
  30603, -- Purified Tanzanite
  30604, -- Resplendent Fire Opal
  30605, -- Nimble Chrysoprase
  30606, -- Lightning Chrysoprase
  30607, -- Splendid Fire Opal
  30608, -- Radiant Chrysoprase
  31116, -- Timeless Amethyst
  31117, -- Tireless Soothing Amethyst
  31118, -- Sovereign Amethyst
  31866, -- Veiled Shadow Draenite
  31867, -- Veiled Nightseye
  31868, -- Deadly Noble Topaz
  31869, -- Deadly Flame Spessarite
  32193, -- Bold Crimson Spinel
  32194, -- Delicate Crimson Spinel
  32196, -- Brilliant Crimson Spinel
  32198, -- Subtle Lionseye
  32199, -- Flashing Crimson Spinel
  32200, -- Solid Empyrean Sapphire
  32201, -- Sparkling Empyrean Sapphire
  32203, -- Stormy Empyrean Sapphire
  32205, -- Smooth Lionseye
  32206, -- Rigid Empyrean Sapphire
  32209, -- Mystic Lionseye
  32211, -- Sovereign Shadowsong Amethyst
  32212, -- Shifting Shadowsong Amethyst
  32215, -- Timeless Shadowsong Amethyst
  32217, -- Inscribed Pyrestone
  32218, -- Potent Pyrestone
  32220, -- Glinting Shadowsong Amethyst
  32221, -- Veiled Shadowsong Amethyst
  32222, -- Deadly Pyrestone
  32223, -- Regal Seaspray Emerald
  32224, -- Radiant Seaspray Emerald
  32225, -- Purified Shadowsong Amethyst
  32226, -- Jagged Seaspray Emerald
  32409, -- Relentless Earthstorm Diamond
  32410, -- Thundering Skyfire Diamond
  32634, -- Shifting Amethyst
  32635, -- Timeless Amethyst
  32636, -- Purified Amethyst
  32637, -- Deadly Citrine
  32638, -- Reckless Citrine
  32639, -- Jagged Mossjewel
  32640, -- Tense Unstable Diamond
  32641, -- Imbued Unstable Diamond
  32833, -- Purified Jaggal Pearl
  32836, -- Purified Shadow Pearl
  33131, -- Crimson Sun
  33133, -- Don Julio's Heart
  33134, -- Kailee's Rose
  33135, -- Falling Star
  33140, -- Blood of Amber
  33143, -- Stone of Blades
  33144, -- Facet of Eternity
  33782, -- Steady Talasite
  34220, -- Chaotic Skyfire Diamond
  34831, -- Eye of the Sea
  35315, -- Quick Dawnstone
  35318, -- Forceful Talasite
  35487, -- Delicate Crimson Spinel
  35488, -- Brilliant Crimson Spinel
  35501, -- Eternal Earthstorm Diamond
  35503, -- Ember Skyfire Diamond
  35707, -- Regal Talasite
  35758, -- Steady Seaspray Emerald
  35759, -- Forceful Seaspray Emerald
  35760, -- Reckless Pyrestone
  35761, -- Quick Lionseye
}

-- Permanent Enhancements
database["PermanentEnhancements"] = {
  23530, -- Felsteel Shield Spike
  23764, -- Adamantite Scope
  23765, -- Khorium Scope
  23766, -- Stabilized Eternium Scope
  24273, -- Mystic Spellthread
  24274, -- Runic Spellthread
  24275, -- Silver Spellthread
  24276, -- Golden Spellthread
  25650, -- Knothide Armor Kit
  25651, -- Vindicator's Armor Kit
  25652, -- Magister's Armor Kit
  29533, -- Cobrahide Leg Armor
  29534, -- Clefthide Leg Armor
  29535, -- Nethercobra Leg Armor
  29536, -- Nethercleft Leg Armor
  33185, -- Adamantite Weapon Chain
  34207, -- Glove Reinforcements
  34330, -- Heavy Knothide Armor Kit
  34836, -- Spun Truesilver Fishing Line
}

-- Temporary Enhancements
database["TemporaryEnhancements"] = {
  22521, -- Superior Mana Oil
  22522, -- Superior Wizard Oil
  23528, -- Fel Sharpening Stone
  23529, -- Adamantite Sharpening Stone
  23559, -- Lesser Rune of Warding
  23575, -- Lesser Ward of Shielding
  23576, -- Greater Ward of Shielding
  25521, -- Greater Rune of Warding
  25679, -- Comfortable Insoles
  28420, -- Fel Weightstone
  28421, -- Adamantite Weightstone
  31535, -- Bloodboil Poison
  34538, -- Blessed Weapon Coating
  34539, -- Righteous Weapon Coating
  34861, -- Sharpened Fish Hook
}

-- Cloth
database["Cloth"] = {
  21840, -- Bolt of Netherweave
  21842, -- Bolt of Imbued Netherweave
  21844, -- Bolt of Soulcloth
  21845, -- Primal Mooncloth
  21877, -- Netherweave Cloth
  21881, -- Netherweb Spider Silk
  24271, -- Spellcloth
  24272, -- Shadowcloth
}

-- Elemental
database["Elemental"] = {
  21884, -- Primal Fire
  21885, -- Primal Water
  21886, -- Primal Life
  22451, -- Primal Air
  22452, -- Primal Earth
  22456, -- Primal Shadow
  22457, -- Primal Mana
  22572, -- Mote of Air
  22573, -- Mote of Earth
  22574, -- Mote of Fire
  22575, -- Mote of Life
  22576, -- Mote of Mana
  22577, -- Mote of Shadow
  22578, -- Mote of Water
  23571, -- Primal Might
  23572, -- Primal Nether
  30183, -- Nether Vortex
}

-- Enchanting
database["Enchanting"] = {
  22445, -- Arcane Dust
  22446, -- Greater Planar Essence
  22447, -- Lesser Planar Essence
  22448, -- Small Prismatic Shard
  22449, -- Large Prismatic Shard
  22450, -- Void Crystal
}

-- Herbs
database["Herbs"] = {
  22710, -- Bloodthistle
  22785, -- Felweed
  22786, -- Dreaming Glory
  22787, -- Ragveil
  22788, -- Flame Cap
  22789, -- Terocone
  22790, -- Ancient Lichen
  22791, -- Netherbloom
  22792, -- Nightmare Vine
  22793, -- Mana Thistle
  22794, -- Fel Lotus
  22797, -- Nightmare Seed
}

-- Inscription
database["Inscription"] = {
  31882, -- Ace of Blessings
  31883, -- Eight of Blessings
  31884, -- Five of Blessings
  31885, -- Four of Blessings
  31886, -- Seven of Blessings
  31887, -- Six of Blessings
  31888, -- Three of Blessings
  31889, -- Two of Blessings
  31892, -- Ace of Storms
  31893, -- Eight of Storms
  31894, -- Five of Storms
  31895, -- Four of Storms
  31896, -- Seven of Storms
  31898, -- Six of Storms
  31899, -- Three of Storms
  31900, -- Two of Storms
  31901, -- Ace of Furies
  31902, -- Eight of Furies
  31903, -- Five of Furies
  31904, -- Four of Furies
  31905, -- Seven of Furies
  31906, -- Six of Furies
  31908, -- Three of Furies
  31909, -- Two of Furies
  31910, -- Ace of Lunacy
  31911, -- Eight of Lunacy
  31912, -- Five of Lunacy
  31913, -- Four of Lunacy
  31915, -- Seven of Lunacy
  31916, -- Six of Lunacy
  31917, -- Three of Lunacy
  31918, -- Two of Lunacy
}

-- Jewelcrafting
database["Jewelcrafting"] = {
  20816, -- Delicate Copper Wire
  20817, -- Bronze Setting
  20963, -- Mithril Filigree
  21752, -- Thorium Setting
  21929, -- Flame Spessarite
  23077, -- Blood Garnet
  23079, -- Deep Peridot
  23107, -- Shadow Draenite
  23112, -- Golden Draenite
  23117, -- Azure Moonstone
  23436, -- Living Ruby
  23437, -- Talasite
  23438, -- Star of Elune
  23439, -- Noble Topaz
  23440, -- Dawnstone
  23441, -- Nightseye
  24243, -- Adamantite Powder
  24478, -- Jaggal Pearl
  24479, -- Shadow Pearl
  25867, -- Earthstorm Diamond
  25868, -- Skyfire Diamond
  31079, -- Mercurial Adamantite
  32227, -- Crimson Spinel
  32228, -- Empyrean Sapphire
  32229, -- Lionseye
  32230, -- Shadowsong Amethyst
  32231, -- Pyrestone
  32249, -- Seaspray Emerald
}

-- Leather
database["Leather"] = {
  21887, -- Knothide Leather
  23793, -- Heavy Knothide Leather
  25649, -- Knothide Leather Scraps
  25699, -- Crystal-Infused Leather
  25700, -- Fel Scales
  25707, -- Fel Hide
  25708, -- Thick Clefthoof Leather
  29539, -- Cobra Scales
  29547, -- Wind Scales
  29548, -- Nether Dragonscales
}

-- Meat & Fish
database["MeatFish"] = {
  22644, -- Crunchy Spider Leg
  23676, -- Moongraze Stag Tenderloin
  24477, -- Jaggal Clam Meat
  27422, -- Barbed Gill Trout
  27425, -- Spotted Feltail
  27429, -- Zangarian Sporefish
  27435, -- Figluster's Mudfish
  27437, -- Icefin Bluefish
  27438, -- Golden Darter
  27439, -- Furious Crawdad
  27668, -- Lynx Meat
  27669, -- Bat Flesh
  27671, -- Buzzard Meat
  27674, -- Ravager Flesh
  27677, -- Chunk o' Basilisk
  27678, -- Clefthoof Meat
  27681, -- Warped Flesh
  27682, -- Talbuk Venison
  31670, -- Raptor Ribs
  31671, -- Serpent Flesh
  33823, -- Bloodfin Catfish
  33824, -- Crescent-Tail Skullfish
  35285, -- Giant Sunfish
  35562, -- Bear Flank
  37588, -- Mostly Digested Fish
}

-- Metal & Stone
database["MetalStone"] = {
  23424, -- Fel Iron Ore
  23425, -- Adamantite Ore
  23426, -- Khorium Ore
  23427, -- Eternium Ore
  23445, -- Fel Iron Bar
  23446, -- Adamantite Bar
  23447, -- Eternium Bar
  23448, -- Felsteel Bar
  23449, -- Khorium Bar
  23573, -- Hardened Adamantite Bar
  35128, -- Hardened Khorium
}

-- Other Tradegoods
database["OtherTradegoods"] = {
  21882, -- Soul Essence
  24476, -- Jaggal Clam
  27511, -- Inscribed Scrollcase
  27513, -- Curious Crate
  30817, -- Simple Flour
  32428, -- Heart of Darkness
  34664, -- Sunmote
}

-- Parts
database["Parts"] = {
  23781, -- Elemental Blasting Powder
  23782, -- Fel Iron Casing
  23783, -- Handful of Fel Iron Bolts
  23784, -- Adamantite Frame
  23785, -- Hardened Adamantite Tube
  23786, -- Khorium Power Core
  23787, -- Felsteel Stabilizer
  32423, -- Icy Blasting Primers
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
      database["FishingRecipes"],
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
    if self.db.profile.moveFishingRecipes then
      Result[formatBagTitle(self, L["Fishing Recipes"], converttohex(self.db.profile.color.FishingRecipes))] =
        AddToSet(database["FishingRecipes"])
    end
    if self.db.profile.moveJewelcraftingRecipes then
      Result[formatBagTitle(self, L["Jewelcrafting Recipes"], converttohex(self.db.profile.color.JewelcraftingRecipes))] =
        AddToSet(database["JewelcraftingRecipes"])
    end
    if self.db.profile.moveLeatherworkingRecipes then
      Result[formatBagTitle(
        self,
        L["Leatherworking  Recipes"],
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

local setFilter = AdiBags:RegisterFilter("Burning Crusade", 98, "ABEvent-1.0")
setFilter.uiName = string.format("|cff00bc04%s|r", L["Burning Crusade"])
setFilter.uiDesc = string.format(
  "%s\n|cffffd800%s: 1.0.7|r",
  L["Items from the Burning Crusade expansion."],
  L["Filter version"]
)

function setFilter:OnInitialize()
  self.db = AdiBags.db:RegisterNamespace("Burning Crusade", {
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
      moveFishingRecipes = true,
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
        prefix = converttorgb("00bc04", true),
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
        FishingRecipes = converttorgb("3465a4", true),
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
            ["BC"] = "BC",
            ["BC-"] = "BC-",
            ["1."] = "1.",
            ["|T135891:" .. AdiBags.HEADER_SIZE .. ":" .. AdiBags.HEADER_SIZE .. ":-2:-10|t"] = "|T135891:"
              .. AdiBags.HEADER_SIZE
              .. "|t",
            ["|T1380867:" .. AdiBags.HEADER_SIZE .. ":" .. AdiBags.HEADER_SIZE .. ":-2:-10|t"] = "|T1380867:"
              .. AdiBags.HEADER_SIZE
              .. "|t",
            ["|T1546412:" .. AdiBags.HEADER_SIZE .. ":" .. AdiBags.HEADER_SIZE .. ":-2:-10|t"] = "|T1546412:"
              .. AdiBags.HEADER_SIZE
              .. "|t",
            ["|T236412:" .. AdiBags.HEADER_SIZE .. ":" .. AdiBags.HEADER_SIZE .. ":-2:-10|t"] = "|T236412:"
              .. AdiBags.HEADER_SIZE
              .. "|t",
            ["|T236418:" .. AdiBags.HEADER_SIZE .. ":" .. AdiBags.HEADER_SIZE .. ":-2:-10|t"] = "|T236418:"
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
        moveFishingRecipes = {
          name = L["Fishing Recipes"],
          desc = L["Recipes for catching fish and other underwater items."],
          type = "toggle",
          width = 1.5,
          order = 101,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
        },
        colorFishingRecipes = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Fishing Recipes"]),
          type = "color",
          order = 102,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
          get = function()
            local color = self.db.profile.color.FishingRecipes
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.FishingRecipes
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
          name = L["Leatherworking  Recipes"],
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
          desc = string.format(L["Select a color for %s."], L["Leatherworking  Recipes"]),
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
