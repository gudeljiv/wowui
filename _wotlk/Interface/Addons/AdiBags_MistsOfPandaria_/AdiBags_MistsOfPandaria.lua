--[[
AdiBags - Mists Of Pandaria
by Zottelchen
version: 1.0.7
Items from the Mists Of Pandaria expansion.
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
  72985, -- Windwool Bandage
  72986, -- Heavy Windwool Bandage
}

-- Consumables
database["Consumables"] = {
  77532, -- Locksmith's Powderkeg
  77589, -- G91 Landshark
  87216, -- Thermal Anvil
}

-- Foods and Drinks
database["FoodsandDrinks"] = {
  74636, -- Golden Carp Consomme
  74641, -- Fish Cake
  74642, -- Charbroiled Tiger Steak
  74643, -- Sauteed Carrots
  74644, -- Swirling Mist Soup
  74645, -- Eternal Blossom Fish
  74646, -- Black Pepper Ribs and Shrimp
  74647, -- Valley Stir Fry
  74648, -- Sea Mist Rice Noodles
  74649, -- Braised Turtle
  74650, -- Mogu Fish Stew
  74651, -- Shrimp Dumplings
  74652, -- Fire Spirit Salmon
  74653, -- Steamed Crab Surprise
  74654, -- Wildfowl Roast
  74655, -- Twin Fish Platter
  74656, -- Chun Tian Spring Rolls
  74919, -- Pandaren Banquet
  75016, -- Great Pandaren Banquet
  75026, -- Ginseng Tea
  75037, -- Jade Witch Brew
  75038, -- Mad Brewer's Breakfast
  77264, -- Small Bamboo Shoot
  77272, -- Small Sugarcane Stalk
  77273, -- Small Rice Cake
  79320, -- Half a Lovely Apple
  80313, -- Ling-Ting's Favorite Tea
  80610, -- Conjured Mana Pudding
  80618, -- Conjured Mana Fritter
  81175, -- Crispy Dojani Eel
  81400, -- Pounded Rice Cake
  81401, -- Yak Cheese Curds
  81402, -- Toasted Fish Jerky
  81403, -- Dried Peaches
  81404, -- Dried Needle Mushrooms
  81405, -- Boiled Silkworm Pupa
  81406, -- Roasted Barley Tea
  81407, -- Four Wind Soju
  81408, -- Red Bean Bun
  81409, -- Tangy Yogurt
  81410, -- Green Curry Fish
  81411, -- Peach Pie
  81412, -- Blanched Needle Mushrooms
  81413, -- Skewered Peanut Chicken
  81414, -- Pearl Milk Tea
  81415, -- Pandaren Plum Wine
  81889, -- Peppered Puffball
  81916, -- Humongous Fungus
  81917, -- Mutton Stew
  81918, -- Pickled Pig's Snout
  81919, -- Red Raspberry
  81920, -- Plump Fig
  81921, -- Chilton Stilton
  81922, -- Redridge Roquefort
  81923, -- Cobo Cola
  81924, -- Carbonated Water
  82343, -- Lordaeron Lambic
  82344, -- Hearthglen Ambrosia
  82448, -- Smoked Squid Belly
  82449, -- Barnacle Bouillabaisse
  82450, -- Cornmeal Biscuit
  82451, -- Frybread
  83094, -- Foote Tripel
  83095, -- Lagrave Stout
  83097, -- Tortoise Jerky
  85501, -- Viseclaw Soup
  85504, -- Krasarang Fritters
  86026, -- Perfectly Cooked Instant Noodles
  86057, -- Sliced Peaches
  86069, -- Rice Pudding
  86070, -- Wildfowl Ginseng Soup
  86073, -- Spicy Salmon
  86074, -- Spicy Vegetable Chips
  86432, -- Banana Infused Rum
  86508, -- Fresh Bread
  87226, -- Banquet of the Grill
  87228, -- Great Banquet of the Grill
  87230, -- Banquet of the Wok
  87232, -- Great Banquet of the Wok
  87234, -- Banquet of the Pot
  87236, -- Great Banquet of the Pot
  87238, -- Banquet of the Steamer
  87240, -- Great Banquet of the Steamer
  87242, -- Banquet of the Oven
  87244, -- Great Banquet of the Oven
  87246, -- Banquet of the Brew
  87248, -- Great Banquet of the Brew
  87253, -- Perpetual Leftovers
  87264, -- Four Senses Brew
  88379, -- Grummlecake
  88382, -- Keenbean Kafa
  88388, -- Squirmy Delight
  88398, -- Root Veggie Stew
  88490, -- Triple-Distilled Brew
  88492, -- Wicked Wikket
  88529, -- Sparkling Water
  88530, -- Bubbling Beverage
  88532, -- Lotus Water
  88578, -- Cup of Kafa
  88586, -- Chao Cookies
  89588, -- Novice's Serpent Brew
  89589, -- Initiate's Serpent Brew
  89590, -- Serpent Brew of Adversity
  89591, -- Serpent Brew of Pilgrimage
  89592, -- Serpent Brew of Meditation
  89593, -- Serpent Brew of Fallen Blossoms
  89594, -- Serpent Brew of Serenity
  89595, -- Novice's Tiger Brew
  89596, -- Initiate's Tiger Brew
  89597, -- Tiger Brew of Adversity
  89598, -- Tiger Brew of Pilgrimage
  89599, -- Tiger Brew of Meditation
  89600, -- Tiger Brew of Fallen Blossoms
  89601, -- Tiger Brew of Serenity
  89683, -- Hozen Cuervo
  90135, -- Thick-Cut Bacon
  90457, -- Mah's Warm Yak-Tail Stew
  90659, -- Jasmine Tea
  90660, -- Black Tea
  93208, -- Darkmoon P.I.E.
  94535, -- Grilled Dinosaur Haunch
  98111, -- K.R.E.
  98116, -- Freeze-Dried Hyena Jerky
  98118, -- Scorpion Crunchies
  98121, -- Amberseed Bun
  98122, -- Camembert du Clefthoof
  98123, -- Whale Shark Caviar
  98124, -- Bloodberry Tart
  98125, -- Shaved Zangar Truffles
  98126, -- Mechanopeep Foie Gras
  98127, -- Dented Can of Kaja'Cola
  98157, -- Big Blossom Brew
  101616, -- Noodle Soup
  101617, -- Deluxe Noodle Soup
  101618, -- Pandaren Treasure Noodle Soup
  101630, -- Noodle Cart Kit
  101661, -- Deluxe Noodle Cart Kit
  101662, -- Pandaren Treasure Noodle Cart Kit
  101745, -- Mango Ice
  101746, -- Seasoned Pomfruit Slices
  101747, -- Farmer's Delight
  101748, -- Spiced Blossom Soup
  101749, -- Stuffed Lushrooms
  101750, -- Fluffy Silkfeather Omelet
  103641, -- Singing Crystal
  103642, -- Book of the Ages
  103643, -- Dew of Eternal Morning
  104312, -- Strange Glowing Mushroom
  104314, -- Dragon P.I.E.
  104316, -- Spectral Grog
  104339, -- Harmonious River Noodles
  104340, -- Crazy Snake Noodles
  104341, -- Steaming Goat Noodles
  104342, -- Spicy Mushan Noodles
  104343, -- Golden Dragon Noodles
  104344, -- Lucky Mushroom Noodles
  104348, -- Timeless Tea
  105700, -- Kun-Lai Kicker
  105701, -- Greenstone Brew
  105702, -- Boomer Brew
  105703, -- Stormstout Brew
  105704, -- Yan-Zhu's Blazing Brew
  105705, -- Chani's Bitter Brew
  105706, -- Shado-Pan Brew
  105707, -- Unga Brew
  105708, -- Shimmering Amber-Brew
  105711, -- Funky Monkey Brew
  105717, -- Rice-Wine Mushrooms
  105719, -- Brew-Curried Whitefish
  105720, -- Candied Apple
  105721, -- Hot Papaya Milk
  105722, -- Nutty Brew-Bun
  105723, -- Peanut Pork Chops
  105724, -- Fried Cheese Dumplings
  108920, -- Lemon Flower Pudding
}

-- Other Consumables
database["OtherConsumables"] = {
  74812, -- Diluted Lime Sulfur
  74813, -- Dogwood Extract
  74815, -- Soothing Shampoo
  75256, -- Pang's Extra-Spicy Tofu
  75258, -- Ang's Summer Watermelon
  75259, -- Ang's Giant Pink Turnip
  75271, -- Jian
  75272, -- Ling
  75273, -- Smelly
  75275, -- Mushan Shoulder Steak
  75276, -- Turtle Meat Scrap
  76100, -- Wayward Lamb
  76110, -- Crate of Fresh Produce
  76297, -- Stolen Turnip
  76298, -- Stolen Watermelon
  76334, -- Meadow Marigold
  76335, -- Vial of Animal Blood
  76337, -- Stolen Sack of Hops
  76356, -- Stoppered Vial of Muddy Water
  76499, -- Jademoon Leaf
  79048, -- Whimsical Skull Mask
  79102, -- Green Cabbage Seeds
  79338, -- Bucket of Meaty Dog Food
  80590, -- Juicycrunch Carrot Seeds
  80591, -- Scallion Seeds
  80592, -- Mogu Pumpkin Seeds
  80593, -- Red Blossom Leek Seeds
  80594, -- Pink Turnip Seeds
  80595, -- White Turnip Seeds
  80809, -- Bag of Green Cabbage Seeds
  81054, -- Kafa'kota Berry
  81901, -- Brilliant Mana Gem
  82392, -- Gumweed
  82605, -- Corrupted Insignia
  82960, -- Ghostly Skeleton Key
  83137, -- Hozen Remedy Pouch
  83795, -- Scrying Roguestone
  84686, -- Mug of Dreadbrew
  84782, -- Bag of Juicycrunch Carrot Seeds
  84783, -- Bag of Scallion Seeds
  85153, -- Bag of Mogu Pumpkin Seeds
  85158, -- Bag of Red Blossom Leek Seeds
  85162, -- Bag of Pink Turnip Seeds
  85163, -- Bag of White Turnip Seeds
  85164, -- Elegant Scroll
  85215, -- Snakeroot Seed
  85216, -- Enigma Seed
  85217, -- Magebulb Seed
  85219, -- Ominous Seed
  85264, -- Autumn Blossom Tree
  85265, -- Spring Blossom Tree
  85266, -- Winter Blossom Tree
  85267, -- Autumn Blossom Sapling
  85268, -- Spring Blossom Sapling
  85269, -- Winter Blossom Sapling
  85580, -- Empty Polyformic Acid Vial
  85589, -- Nearly Full Vial of Polyformic Acid
  85592, -- Half Full Vial of Polyformic Acid
  85593, -- Nearly Empty Vial of Polyformic Acid
  86143, -- Battle Pet Bandage
  86534, -- Shiny Shado-Pan Coin
  86536, -- Wu Kao Dart of Lethargy
  86592, -- Hozen Peace Pipe
  86607, -- Goblin Dragon Gun, Mark II
  87257, -- Arcane Familiar Stone
  87258, -- Fiery Familiar Stone
  87259, -- Icy Familiar Stone
  87647, -- Origami Crane
  87648, -- Origami Frog
  87764, -- Serpent's Heart Firework
  87872, -- Desecrated Oil
  88384, -- Burlap Ritual Bag
  88487, -- Volatile Orb
  88491, -- Grand Celebration Firework
  88493, -- Celestial Firework
  89124, -- Celestial Offering
  89125, -- Sack of Pet Supplies
  89197, -- Windshear Cactus Seed
  89202, -- Raptorleaf Seed
  89223, -- Racing Flag
  89224, -- Floating Racing Flag
  89225, -- Finish Line
  89227, -- Floating Finish Line
  89230, -- Restorative Amber
  89233, -- Songbell Seed
  89301, -- Stack of Wooden Boards
  89302, -- Stack of Bamboo
  89303, -- Stack of Stone Blocks
  89326, -- Witchberry Seeds
  89328, -- Jade Squash Seeds
  89329, -- Striped Melon Seeds
  89847, -- Bag of Witchberry Seeds
  89848, -- Bag of Jade Squash Seeds
  89849, -- Bag of Striped Melon Seeds
  89888, -- Jade Blossom Firework
  89893, -- Autumn Flower Firework
  89906, -- Magical Mini-Treat
  90006, -- Wu Kao Smoke Bomb
  90174, -- Troubles From Without
  90395, -- Facets of Research
  90397, -- Facets of Research
  90398, -- Facets of Research
  90399, -- Facets of Research
  90400, -- Facets of Research
  90401, -- Facets of Research
  90406, -- Facets of Research
  90426, -- Brewhelm
  90428, -- Pandaren Brew
  90815, -- Relic of Guo-Lai
  90816, -- Relic of the Thunder King
  90918, -- Celebration Package
  91086, -- Darkmoon Pet Supplies
  91806, -- Unstable Portal Shard
  91850, -- Orgrimmar Portal Shard
  91860, -- Stormwind Portal Shard
  91861, -- Thunder Bluff Portal Shard
  91862, -- Undercity Portal Shard
  91863, -- Silvermoon Portal Shard
  91864, -- Ironforge Portal Shard
  91865, -- Darnassus Portal Shard
  91866, -- Exodar Portal Shard
  92049, -- Mercenary Contract: Mage
  92050, -- Mercenary Contract: Paladin
  92051, -- Mercenary Contract: Priest
  92052, -- Mercenary Contract: Druid
  92053, -- Mercenary Contract: Warrior
  92054, -- Mercenary Contract: Rogue
  92055, -- Mercenary Contract: Shaman
  92056, -- Portal Fuel: Sparkrocket Outpost
  92057, -- Portal Fuel: Orgrimmar
  92058, -- Portal Fuel: Shrine of Two Moons
  92059, -- Domination Point Banquet
  92421, -- Guard Contract: Graveyard
  92422, -- Guard Contract: Tower
  92427, -- Guard Contract: Tower
  92428, -- Guard Contract: Graveyard
  92429, -- Lion's Landing Banquet
  92430, -- Portal Reagents: Shrine of Seven Stars
  92431, -- Portal Reagents: Stormwind
  92432, -- Portal Reagents: Skyfire
  92433, -- Mercenary Contract: Shaman
  92434, -- Mercenary Contract: Rogue
  92435, -- Mercenary Contract: Warrior
  92436, -- Mercenary Contract: Druid
  92437, -- Mercenary Contract: Priest
  92438, -- Mercenary Contract: Paladin
  92439, -- Mercenary Contract: Mage
  92442, -- Horde Banner
  92443, -- Alliance Banner
  92525, -- Overridden Excavationbot
  92526, -- Crate of Horde Banners
  92527, -- Rodent Crate
  92528, -- Obelisk of Deception
  92529, -- Mind Vision Altar
  92530, -- Box of Overridden Excavationbots
  92531, -- Crate of Alliance Banners
  92532, -- Rodent Crate
  92533, -- Obelisk of Deception
  92534, -- Mind Vision Altar
  92535, -- Box of Overridden Excavationbots
  92663, -- Guard Contract: Outpost
  92664, -- Guard Contract: Outpost
  92665, -- Flawless Elemental Battle-Stone
  92675, -- Flawless Beast Battle-Stone
  92676, -- Flawless Critter Battle-Stone
  92677, -- Flawless Flying Battle-Stone
  92678, -- Flawless Magic Battle-Stone
  92679, -- Flawless Aquatic Battle-Stone
  92680, -- Flawless Mechanical Battle-Stone
  92681, -- Flawless Undead Battle-Stone
  92682, -- Flawless Humanoid Battle-Stone
  92683, -- Flawless Dragonkin Battle-Stone
  92718, -- Brawler's Purse
  92741, -- Flawless Battle-Stone
  92742, -- Polished Battle-Stone
  92956, -- Darkmoon "Snow Leopard"
  92958, -- Darkmoon "Nightsaber"
  92959, -- Darkmoon "Cougar"
  92966, -- Darkmoon "Dragon"
  92967, -- Darkmoon "Gryphon"
  92968, -- Darkmoon "Murloc"
  92969, -- Darkmoon "Rocket"
  92970, -- Darkmoon "Wyvern"
  93043, -- Rotten Apple
  93044, -- Rotten Banana
  93045, -- Rotten Watermelon
  93146, -- Pandaren Spirit Pet Supplies
  93147, -- Pandaren Spirit Pet Supplies
  93148, -- Pandaren Spirit Pet Supplies
  93149, -- Pandaren Spirit Pet Supplies
  93158, -- Expired Blackout Brew
  93314, -- Magic Bamboo Shoot
  93724, -- Darkmoon Game Prize
  93730, -- Darkmoon Top Hat
  93823, -- Challenge Card: Bruce
  93824, -- Challenge Card: Vian
  94160, -- Challenge Card: Goredome
  94161, -- Challenge Card: Vishas
  94162, -- Challenge Card: Dippy
  94163, -- Challenge Card: Kirrawk
  94164, -- Challenge Card: Fran & Riddoh
  94165, -- Challenge Card: King Kulaka
  94166, -- Challenge Card: Blat
  94167, -- Challenge Card: Sanoriak
  94168, -- Challenge Card: Ixx
  94169, -- Challenge Card: Mazhareen
  94170, -- Challenge Card: Crush
  94171, -- Challenge Card: Leona
  94172, -- Challenge Card: Dominika
  94173, -- Challenge Card: Deeken
  94174, -- Challenge Card: Millie Watt
  94175, -- Challenge Card: Fjoll
  94176, -- Challenge Card: Proboskus
  94177, -- Challenge Card: Leper Gnomes
  94178, -- Challenge Card: G.G. Engineering
  94179, -- Challenge Card: Dark Summoner
  94180, -- Challenge Card: Battletron
  94181, -- Challenge Card: Meatball
  94182, -- Challenge Card: Epicus Maximus
  94183, -- Challenge Card: Yikkan Izu
  94184, -- Challenge Card: Akama
  94185, -- Challenge Card: Smash Hoofstomp
  94186, -- Challenge Card: Unguloxx
  94187, -- Challenge Card: Disruptron
  94188, -- Challenge Card: Millhouse Manastorm
  94189, -- Challenge Card: Zen'shar
  94207, -- Fabled Pandaren Pet Supplies
  94223, -- Stolen Shado-Pan Insignia
  94225, -- Stolen Celestial Insignia
  94226, -- Stolen Klaxxi Insignia
  94227, -- Stolen Golden Lotus Insignia
  94295, -- Primal Egg
  94296, -- Cracked Primal Egg
  94604, -- Burning Seed
  95052, -- Arcane Propellant
  95053, -- A Common Rock
  95056, -- Polymorphic Key
  95093, -- Sleep Dust
  95408, -- Waterlogged Zandalari Journal
  95409, -- Iron-Bound Zandalari Journal
  95410, -- Blood-Spattered Zandalari Journal
  95411, -- Torn Zandalari Journal
  95412, -- Frayed Zandalari Journal
  95434, -- Bag of Green Cabbage Seeds
  95436, -- Bag of Juicycrunch Carrot Seeds
  95437, -- Bag of Jade Squash Seeds
  95438, -- Bag of Mogu Pumpkin Seeds
  95439, -- Bag of Pink Turnip Seeds
  95440, -- Bag of Red Blossom Leek Seeds
  95441, -- Bag of Scallion Seeds
  95442, -- Bag of Striped Melon Seeds
  95443, -- Bag of White Turnip Seeds
  95444, -- Bag of Witchberry Seeds
  95445, -- Bag of Songbell Seeds
  95446, -- Bag of Songbell Seeds
  95447, -- Bag of Snakeroot Seeds
  95448, -- Bag of Snakeroot Seeds
  95449, -- Bag of Enigma Seeds
  95450, -- Bag of Enigma Seeds
  95451, -- Bag of Magebulb Seeds
  95452, -- Bag of Magebulb Seeds
  95454, -- Bag of Windshear Cactus Seeds
  95456, -- Bag of Windshear Cactus Seeds
  95457, -- Bag of Raptorleaf Seeds
  95458, -- Bag of Raptorleaf Seeds
  95481, -- Blue War Fuel
  95482, -- Red War Fuel
  95487, -- Sunreaver Onslaught Insignia
  95488, -- Greater Sunreaver Onslaught Insignia
  95489, -- Kirin Tor Offensive Insignia
  95490, -- Greater Kirin Tor Offensive Insignia
  95496, -- Shado-Pan Assault Insignia
  97154, -- Sleep Dust
  97155, -- Polymorphic Key
  97158, -- A Common Rock
  97159, -- Arcane Propellant
  97278, -- Challenge Card: Ahoo'ru
  97279, -- Challenge Card: Mingus Diggs
  97280, -- Challenge Card: Dippy & Doopy
  97281, -- Challenge Card: Hexos
  97282, -- Challenge Card: Ty'thar
  97283, -- Challenge Card: Nibbleh
  97284, -- Challenge Card: Master Boom Boom
  97285, -- Challenge Card: Grandpa Grumplefloot
  97286, -- Challenge Card: Big Badda Boom
  97287, -- Challenge Card: The Bear and the Lady Fair
  97288, -- Challenge Card: Doctor FIST
  97289, -- Challenge Card: Splat
  97321, -- Challenge Card: Blind Hero
  97445, -- Challenge Card: Blingtron 3000
  97450, -- Challenge Card: Tyson Sanders
  97559, -- Challenge Card: T440 Dual-Mode Robot
  97560, -- Challenge Card: Ro-Shambo
  97563, -- Challenge Card: Mecha-Bruce
  97566, -- Challenge Card: Razorgrin
  97972, -- Challenge Card: Anthracite
  98095, -- Brawler's Pet Supplies
  98112, -- Lesser Pet Treat
  98114, -- Pet Treat
  98117, -- Moneybrau
  98549, -- Iron Hitching Post (UNUSED)
  98558, -- Empty Supply Crate
  98559, -- Empty Supply Crate
  98715, -- Marked Flawless Battle-Stone
  102351, -- Drums of Rage
  103631, -- Lucky Path of Cenarius
  104112, -- Curious Ticking Parcel
  104114, -- Curious Ticking Parcel
  104140, -- Horde Firework
  104141, -- Alliance Firework
  104142, -- Autumn Flower Firework
  104143, -- Jade Blossom Firework
  104144, -- Celestial Firework
  104145, -- Grand Celebration Firework
  104146, -- Serpent's Heart Firework
  104148, -- Snake Burst Firework
  104149, -- Red Firework
  104150, -- Red, White and Blue Firework
  104151, -- Yellow Rose Firework
  104152, -- Red Streaks Firework
  104153, -- Green Firework
  104154, -- Blue Firework
  104155, -- Red Fireworks Rocket
  104287, -- Windfeather Plume
  104288, -- Condensed Jademist
  104289, -- Faintly-Glowing Herb
  104290, -- Sticky Silkworm Goo
  107499, -- Mulled Alterac Brandy
}

-- Elixirs
database["Elixirs"] = {
  76075, -- Mantid Elixir
  76076, -- Mad Hozen Elixir
  76077, -- Elixir of Weaponry
  76078, -- Elixir of the Rapids
  76079, -- Elixir of Peace
  76080, -- Elixir of Perfection
  76081, -- Elixir of Mirrors
  76083, -- Monk's Elixir
  104111, -- Elixir of Wandering Spirits
}

-- Flasks
database["Flasks"] = {
  75525, -- Alchemist's Flask
  76084, -- Flask of Spring Blossoms
  76085, -- Flask of the Warm Sun
  76086, -- Flask of Falling Leaves
  76087, -- Flask of the Earth
  76088, -- Flask of Winter's Bite
  103557, -- Enduring Elixir of Wisdom
}

-- Potions
database["Potions"] = {
  76089, -- Virmen's Bite
  76090, -- Potion of the Mountains
  76092, -- Potion of Focus
  76093, -- Potion of the Jade Serpent
  76094, -- Alchemist's Rejuvenation
  76095, -- Potion of Mogu Power
  76096, -- Darkwater Potion
  76097, -- Master Healing Potion
  76098, -- Master Mana Potion
  86569, -- Crystal of Insanity
  93742, -- Healing Potion
  95054, -- Potion of Light Steps
  95055, -- Frost Rune Trap
  97156, -- Frost Rune Trap
  97157, -- Potion of Light Steps
}

-- Blacksmithing Recipes
database["BlacksmithingRecipes"] = {
  83787, -- Plans: Ghost Reaver's Breastplate
  83788, -- Plans: Ghost Reaver's Gauntlets
  83789, -- Plans: Living Steel Breastplate
  83790, -- Plans: Living Steel Gauntlets
  83791, -- Plans: Breastplate of Ancient Steel
  83792, -- Plans: Gauntlets of Ancient Steel
  84158, -- Plans: Contender's Revenant Belt
  84159, -- Plans: Contender's Revenant Boots
  84160, -- Plans: Contender's Revenant Bracers
  84161, -- Plans: Contender's Revenant Breastplate
  84162, -- Plans: Contender's Revenant Gauntlets
  84163, -- Plans: Contender's Revenant Helm
  84164, -- Plans: Contender's Revenant Legplates
  84165, -- Plans: Contender's Revenant Shoulders
  84166, -- Plans: Contender's Spirit Belt
  84167, -- Plans: Contender's Spirit Boots
  84168, -- Plans: Contender's Spirit Bracers
  84169, -- Plans: Contender's Spirit Breastplate
  84170, -- Plans: Contender's Spirit Gauntlets
  84171, -- Plans: Contender's Spirit Helm
  84172, -- Plans: Contender's Spirit Legplates
  84173, -- Plans: Contender's Spirit Shoulders
  84196, -- Plans: Living Steel Belt Buckle
  84197, -- Plans: Masterwork Forgewire Axe
  84198, -- Plans: Masterwork Ghost Shard
  84208, -- Plans: Masterwork Lightsteel Shield
  84217, -- Plans: Masterwork Phantasmal Hammer
  84218, -- Plans: Masterwork Spiritblade Decimator
  84219, -- Plans: Masterwork Spiritguard Belt
  84220, -- Plans: Masterwork Spiritguard Boots
  84221, -- Plans: Masterwork Spiritguard Bracers
  84222, -- Plans: Masterwork Spiritguard Breastplate
  84223, -- Plans: Masterwork Spiritguard Gauntlets
  84224, -- Plans: Masterwork Spiritguard Helm
  84225, -- Plans: Masterwork Spiritguard Legplates
  84226, -- Plans: Masterwork Spiritguard Shield
  84227, -- Plans: Masterwork Spiritguard Shoulders
  87408, -- Plans: Unyielding Bloodplate
  87409, -- Plans: Gauntlets of Battle Command
  87410, -- Plans: Ornate Battleplate of the Master
  87411, -- Plans: Bloodforged Warfists
  87412, -- Plans: Chestplate of Limitless Faith
  87413, -- Plans: Gauntlets of Unbound Devotion
  90531, -- Plans: Ghost Iron Shield Spike
  90532, -- Plans: Living Steel Weapon Chain
  94552, -- Plans: Lightning Steel Ingot
  94567, -- Plans: Thunder, Reborn
  94568, -- Plans: Drakefist Hammer, Reborn
  94569, -- Plans: Lunar Crescent, Reborn
  94570, -- Plans: Planar Edge, Reborn
  94571, -- Plans: Lionheart Blade, Reborn
  94572, -- Plans: Fireguard, Reborn
  100865, -- Plans: Balanced Trillium Ingot and Its Uses
}

-- Cooking Recipes
database["CookingRecipes"] = {
  74657, -- Recipe: Spicy Salmon
  74658, -- Recipe: Spicy Vegetable Chips
  75013, -- Recipe: Pandaren Banquet
  75017, -- Recipe: Great Pandaren Banquet
  85502, -- Recipe: Viseclaw Soup
  85505, -- Recipe: Krasarang Fritters
  86393, -- Tablet of Ren Yun
  87266, -- Recipe: Banana-Infused Rum
  101765, -- Recipe: Seasoned Pomfruit Slices
  101766, -- Recipe: Spiced Blossom Soup
  101767, -- Recipe: Mango Ice
  101768, -- Recipe: Farmer's Delight
  101769, -- Recipe: Stuffed Lushrooms
  101770, -- Recipe: Fluffy Silkfeather Omelet
}

-- Enchanting Recipes
database["EnchantingRecipes"] = {
  84557, -- Formula: Enchant Bracer - Greater Agility
  84559, -- Formula: Enchant Bracer - Super Intellect
  84561, -- Formula: Enchant Bracer - Exceptional Strength
  84580, -- Formula: Enchant Weapon - River's Song
  84583, -- Formula: Enchant Weapon - Jade Spirit
  84584, -- Formula: Enchant Weapon - Dancing Steel
}

-- Engineering Recipes
database["EngineeringRecipes"] = {
  89992, -- Schematic: Serpent's Heart Firework
  89993, -- Schematic: Grand Celebration Firework
  89994, -- Schematic: Celestial Firework
  89996, -- Schematic: Autumn Flower Firework
  89997, -- Schematic: Jade Blossom Firework
  100910, -- Schematic: Chief Engineer Jard's Journal
}

-- Inscription Recipes
database["InscriptionRecipes"] = {
  102534, -- Technique: Crafted Malevolent Gladiator's Medallion of Tenacity
  104209, -- Charred Recipe
  104215, -- Charred Recipe
  104217, -- Charred Recipe
  104219, -- Technique: Glyph of Skeleton
  104220, -- Charred Recipe
  104223, -- Technique: Glyph of the Unbound Elemental
  104224, -- Technique: Glyph of Evaporation
  104226, -- Charred Recipe
  104227, -- Technique: Glyph of Pillar of Light
  104228, -- Technique: Glyph of Angels
  104229, -- Technique: Glyph of the Sha
  104230, -- Charred Recipe
  104231, -- Technique: Glyph of Inspired Hymns
  104234, -- Technique: Glyph of Spirit Raptors
  104235, -- Technique: Glyph of Lingering Ancestors
  104245, -- Technique: Glyph of the Weaponmaster
}

-- Jewelcrafting Recipes
database["JewelcraftingRecipes"] = {
  83811, -- Design: Agile Primal Diamond
  83815, -- Design: Austere Primal Diamond
  83825, -- Design: Burning Primal Diamond
  83830, -- Design: Sunstone Panther
  83840, -- Design: Destructive Primal Diamond
  83842, -- Design: Effulgent Primal Diamond
  83844, -- Design: Ember Primal Diamond
  83845, -- Design: Jade Panther
  83848, -- Design: Enigmatic Primal Diamond
  83851, -- Design: Eternal Primal Diamond
  83859, -- Design: Fleet Primal Diamond
  83862, -- Design: Forlorn Primal Diamond
  83872, -- Design: Impassive Primal Diamond
  83877, -- Design: Jeweled Onyx Panther
  83901, -- Design: Powerful Primal Diamond
  83925, -- Design: Reverberating Primal Diamond
  83926, -- Design: Revitalizing Primal Diamond
  83931, -- Design: Ruby Panther
  83932, -- Design: Sapphire Panther
  90470, -- Design: Jade Owl
  90471, -- Design: Sapphire Cub
  95470, -- Design: Serpent's Heart
  95471, -- Design: Primal Diamond
}

-- Leatherworking Recipes
database["LeatherworkingRecipes"] = {
  86235, -- Pattern: Angerhide Leg Armor
  86237, -- Pattern: Chestguard of Earthen Harmony
  86238, -- Pattern: Chestguard of Nemeses
  86240, -- Pattern: Contender's Dragonscale Belt
  86241, -- Pattern: Contender's Dragonscale Boots
  86242, -- Pattern: Contender's Dragonscale Bracers
  86243, -- Pattern: Contender's Dragonscale Chestguard
  86244, -- Pattern: Contender's Dragonscale Gloves
  86245, -- Pattern: Contender's Dragonscale Helm
  86246, -- Pattern: Contender's Dragonscale Leggings
  86247, -- Pattern: Contender's Dragonscale Shoulders
  86248, -- Pattern: Contender's Leather Belt
  86249, -- Pattern: Contender's Leather Boots
  86250, -- Pattern: Contender's Leather Bracers
  86251, -- Pattern: Contender's Leather Chestguard
  86252, -- Pattern: Contender's Leather Gloves
  86253, -- Pattern: Contender's Leather Helm
  86254, -- Pattern: Contender's Leather Leggings
  86255, -- Pattern: Contender's Leather Shoulders
  86256, -- Pattern: Contender's Scale Belt
  86257, -- Pattern: Contender's Scale Boots
  86258, -- Pattern: Contender's Scale Bracers
  86259, -- Pattern: Contender's Scale Chestguard
  86260, -- Pattern: Contender's Scale Gloves
  86261, -- Pattern: Contender's Scale Helm
  86262, -- Pattern: Contender's Scale Leggings
  86263, -- Pattern: Contender's Scale Shoulders
  86264, -- Pattern: Contender's Wyrmhide Belt
  86265, -- Pattern: Contender's Wyrmhide Boots
  86266, -- Pattern: Contender's Wyrmhide Bracers
  86267, -- Pattern: Contender's Wyrmhide Chestguard
  86268, -- Pattern: Contender's Wyrmhide Gloves
  86269, -- Pattern: Contender's Wyrmhide Helm
  86270, -- Pattern: Contender's Wyrmhide Leggings
  86271, -- Pattern: Contender's Wyrmhide Shoulders
  86272, -- Pattern: Fists of Lightning
  86273, -- Pattern: Gloves of Earthen Harmony
  86274, -- Pattern: Greyshadow Chestguard
  86275, -- Pattern: Greyshadow Gloves
  86276, -- Pattern: Ironscale Leg Armor
  86277, -- Pattern: Lifekeeper's Gloves
  86278, -- Pattern: Lifekeeper's Robe
  86279, -- Pattern: Liferuned Leather Gloves
  86280, -- Pattern: Murderer's Gloves
  86281, -- Pattern: Nightfire Robe
  86283, -- Pattern: Raiment of Blood and Bone
  86284, -- Pattern: Raven Lord's Gloves
  86295, -- Pattern: Shadowleather Leg Armor
  86297, -- Pattern: Stormbreaker Chestguard
  86308, -- Pattern: Wildblood Gloves
  86309, -- Pattern: Wildblood Vest
  95467, -- Pattern: Magnificence of Leather
  95468, -- Pattern: Magnificence of Scales
  100864, -- Pattern: Hardened Magnificent Hide and Its Uses
  102513, -- Pattern: Drums of Rage
}

-- Tailoring Recipes
database["TailoringRecipes"] = {
  86352, -- Pattern: Contender's Silk Cowl
  86353, -- Pattern: Contender's Silk Amice
  86354, -- Pattern: Contender's Silk Raiment
  86355, -- Pattern: Contender's Silk Handwraps
  86356, -- Pattern: Contender's Silk Pants
  86357, -- Pattern: Contender's Silk Cuffs
  86358, -- Pattern: Contender's Silk Footwraps
  86359, -- Pattern: Contender's Silk Belt
  86360, -- Pattern: Contender's Satin Cowl
  86361, -- Pattern: Contender's Satin Amice
  86362, -- Pattern: Contender's Satin Raiment
  86363, -- Pattern: Contender's Satin Handwraps
  86364, -- Pattern: Contender's Satin Pants
  86365, -- Pattern: Contender's Satin Cuffs
  86366, -- Pattern: Contender's Satin Footwraps
  86367, -- Pattern: Contender's Satin Belt
  86368, -- Pattern: Spelltwister's Grand Robe
  86369, -- Pattern: Spelltwister's Gloves
  86370, -- Pattern: Robes of Creation
  86371, -- Pattern: Gloves of Creation
  86375, -- Pattern: Greater Pearlescent Spellthread
  86376, -- Pattern: Greater Cerulean Spellthread
  86377, -- Pattern: Royal Satchel
  86379, -- Pattern: Robe of Eternal Rule
  86380, -- Pattern: Imperial Silk Gloves
  86381, -- Pattern: Legacy of the Emperor
  86382, -- Pattern: Touch of the Light
  100863, -- Pattern: Celestial Cloth and Its Uses
}

-- Gems
database["Gems"] = {
  76502, -- Rigid Lapis Lazuli
  76504, -- Stormy Lapis Lazuli
  76505, -- Sparkling Lapis Lazuli
  76506, -- Solid Lapis Lazuli
  76507, -- Misty Alexandrite
  76508, -- Piercing Alexandrite
  76509, -- Lightning Alexandrite
  76510, -- Sensei's Alexandrite
  76511, -- Effulgent Alexandrite
  76512, -- Zen Alexandrite
  76513, -- Balanced Alexandrite
  76514, -- Vivid Alexandrite
  76515, -- Turbid Alexandrite
  76517, -- Radiant Alexandrite
  76518, -- Shattered Alexandrite
  76519, -- Energized Alexandrite
  76520, -- Jagged Alexandrite
  76521, -- Regal Alexandrite
  76522, -- Forceful Alexandrite
  76524, -- Puissant Alexandrite
  76525, -- Steady Alexandrite
  76526, -- Deadly Tiger Opal
  76527, -- Crafty Tiger Opal
  76528, -- Potent Tiger Opal
  76529, -- Inscribed Tiger Opal
  76530, -- Polished Tiger Opal
  76531, -- Resolute Tiger Opal
  76532, -- Stalwart Tiger Opal
  76533, -- Champion's Tiger Opal
  76534, -- Deft Tiger Opal
  76535, -- Wicked Tiger Opal
  76536, -- Reckless Tiger Opal
  76537, -- Fierce Tiger Opal
  76538, -- Adept Tiger Opal
  76539, -- Keen Tiger Opal
  76540, -- Artful Tiger Opal
  76541, -- Fine Tiger Opal
  76542, -- Skillful Tiger Opal
  76543, -- Lucent Tiger Opal
  76544, -- Tenuous Tiger Opal
  76545, -- Willful Tiger Opal
  76546, -- Splendid Tiger Opal
  76547, -- Resplendent Tiger Opal
  76548, -- Glinting Roguestone
  76549, -- Accurate Roguestone
  76550, -- Veiled Roguestone
  76551, -- Retaliating Roguestone
  76552, -- Etched Roguestone
  76553, -- Mysterious Roguestone
  76554, -- Purified Roguestone
  76555, -- Shifting Roguestone
  76556, -- Guardian's Roguestone
  76557, -- Timeless Roguestone
  76558, -- Defender's Roguestone
  76559, -- Sovereign Roguestone
  76560, -- Delicate Pandarian Garnet
  76561, -- Precise Pandarian Garnet
  76562, -- Brilliant Pandarian Garnet
  76563, -- Flashing Pandarian Garnet
  76564, -- Bold Pandarian Garnet
  76565, -- Smooth Sunstone
  76566, -- Subtle Sunstone
  76567, -- Quick Sunstone
  76568, -- Fractured Sunstone
  76569, -- Mystic Sunstone
  76570, -- Perfect Rigid Lapis Lazuli
  76571, -- Perfect Stormy Lapis Lazuli
  76572, -- Perfect Sparkling Lapis Lazuli
  76573, -- Perfect Solid Lapis Lazuli
  76574, -- Perfect Misty Alexandrite
  76575, -- Perfect Piercing Alexandrite
  76576, -- Perfect Lightning Alexandrite
  76577, -- Perfect Sensei's Alexandrite
  76578, -- Perfect Effulgent Alexandrite
  76579, -- Perfect Zen Alexandrite
  76580, -- Perfect Balanced Alexandrite
  76581, -- Perfect Vivid Alexandrite
  76582, -- Perfect Turbid Alexandrite
  76583, -- Perfect Radiant Alexandrite
  76584, -- Perfect Shattered Alexandrite
  76585, -- Perfect Energized Alexandrite
  76586, -- Perfect Jagged Alexandrite
  76587, -- Perfect Regal Alexandrite
  76588, -- Perfect Forceful Alexandrite
  76589, -- Perfect Confounded Alexandrite
  76590, -- Perfect Puissant Alexandrite
  76591, -- Perfect Steady Alexandrite
  76592, -- Perfect Deadly Tiger Opal
  76593, -- Perfect Crafty Tiger Opal
  76594, -- Perfect Potent Tiger Opal
  76595, -- Perfect Inscribed Tiger Opal
  76596, -- Perfect Polished Tiger Opal
  76597, -- Perfect Resolute Tiger Opal
  76598, -- Perfect Stalwart Tiger Opal
  76599, -- Perfect Champion's Tiger Opal
  76600, -- Perfect Deft Tiger Opal
  76601, -- Perfect Wicked Tiger Opal
  76602, -- Perfect Reckless Tiger Opal
  76603, -- Perfect Fierce Tiger Opal
  76604, -- Perfect Adept Tiger Opal
  76605, -- Perfect Keen Tiger Opal
  76606, -- Perfect Artful Tiger Opal
  76607, -- Perfect Fine Tiger Opal
  76608, -- Perfect Skillful Tiger Opal
  76609, -- Perfect Lucent Tiger Opal
  76610, -- Perfect Tenuous Tiger Opal
  76611, -- Perfect Willful Tiger Opal
  76612, -- Perfect Splendid Tiger Opal
  76613, -- Perfect Resplendent Tiger Opal
  76614, -- Perfect Glinting Roguestone
  76615, -- Perfect Accurate Roguestone
  76616, -- Perfect Veiled Roguestone
  76617, -- Perfect Retaliating Roguestone
  76618, -- Perfect Etched Roguestone
  76619, -- Perfect Mysterious Roguestone
  76620, -- Perfect Purified Roguestone
  76621, -- Perfect Shifting Roguestone
  76622, -- Perfect Guardian's Roguestone
  76623, -- Perfect Timeless Roguestone
  76624, -- Perfect Defender's Roguestone
  76625, -- Perfect Sovereign Roguestone
  76626, -- Perfect Delicate Pandarian Garnet
  76627, -- Perfect Precise Pandarian Garnet
  76628, -- Perfect Brilliant Pandarian Garnet
  76629, -- Perfect Flashing Pandarian Garnet
  76630, -- Perfect Bold Pandarian Garnet
  76631, -- Perfect Smooth Sunstone
  76632, -- Perfect Subtle Sunstone
  76633, -- Perfect Quick Sunstone
  76634, -- Perfect Fractured Sunstone
  76635, -- Perfect Mystic Sunstone
  76636, -- Rigid River's Heart
  76637, -- Stormy River's Heart
  76638, -- Sparkling River's Heart
  76639, -- Solid River's Heart
  76640, -- Misty Wild Jade
  76641, -- Piercing Wild Jade
  76642, -- Lightning Wild Jade
  76643, -- Sensei's Wild Jade
  76644, -- Effulgent Wild Jade
  76645, -- Zen Wild Jade
  76646, -- Balanced Wild Jade
  76647, -- Vivid Wild Jade
  76648, -- Turbid Wild Jade
  76649, -- Radiant Wild Jade
  76650, -- Shattered Wild Jade
  76651, -- Energized Wild Jade
  76652, -- Jagged Wild Jade
  76653, -- Regal Wild Jade
  76654, -- Forceful Wild Jade
  76655, -- Confounded Wild Jade
  76656, -- Puissant Wild Jade
  76657, -- Steady Wild Jade
  76658, -- Deadly Vermilion Onyx
  76659, -- Crafty Vermilion Onyx
  76660, -- Potent Vermilion Onyx
  76661, -- Inscribed Vermilion Onyx
  76662, -- Polished Vermilion Onyx
  76663, -- Resolute Vermilion Onyx
  76664, -- Stalwart Vermilion Onyx
  76665, -- Champion's Vermilion Onyx
  76666, -- Deft Vermilion Onyx
  76667, -- Wicked Vermilion Onyx
  76668, -- Reckless Vermilion Onyx
  76669, -- Fierce Vermilion Onyx
  76670, -- Adept Vermilion Onyx
  76671, -- Keen Vermilion Onyx
  76672, -- Artful Vermilion Onyx
  76673, -- Fine Vermilion Onyx
  76674, -- Skillful Vermilion Onyx
  76675, -- Lucent Vermilion Onyx
  76676, -- Tenuous Vermilion Onyx
  76677, -- Willful Vermilion Onyx
  76678, -- Splendid Vermilion Onyx
  76679, -- Resplendent Vermilion Onyx
  76680, -- Glinting Imperial Amethyst
  76681, -- Accurate Imperial Amethyst
  76682, -- Veiled Imperial Amethyst
  76683, -- Retaliating Imperial Amethyst
  76684, -- Etched Imperial Amethyst
  76685, -- Mysterious Imperial Amethyst
  76686, -- Purified Imperial Amethyst
  76687, -- Shifting Imperial Amethyst
  76688, -- Guardian's Imperial Amethyst
  76689, -- Timeless Imperial Amethyst
  76690, -- Defender's Imperial Amethyst
  76691, -- Sovereign Imperial Amethyst
  76692, -- Delicate Primordial Ruby
  76693, -- Precise Primordial Ruby
  76694, -- Brilliant Primordial Ruby
  76695, -- Flashing Primordial Ruby
  76696, -- Bold Primordial Ruby
  76697, -- Smooth Sun's Radiance
  76698, -- Subtle Sun's Radiance
  76699, -- Quick Sun's Radiance
  76700, -- Fractured Sun's Radiance
  76701, -- Mystic Sun's Radiance
  76879, -- Ember Primal Diamond
  76884, -- Agile Primal Diamond
  76885, -- Burning Primal Diamond
  76886, -- Reverberating Primal Diamond
  76887, -- Fleet Primal Diamond
  76888, -- Revitalizing Primal Diamond
  76890, -- Destructive Primal Diamond
  76891, -- Powerful Primal Diamond
  76892, -- Enigmatic Primal Diamond
  76893, -- Impassive Primal Diamond
  76894, -- Forlorn Primal Diamond
  76895, -- Austere Primal Diamond
  76896, -- Eternal Primal Diamond
  76897, -- Effulgent Primal Diamond
  77540, -- Subtle Tinker's Gear
  77541, -- Smooth Tinker's Gear
  77542, -- Quick Tinker's Gear
  77543, -- Precise Tinker's Gear
  77544, -- Flashing Tinker's Gear
  77545, -- Rigid Tinker's Gear
  77546, -- Sparkling Tinker's Gear
  77547, -- Fractured Tinker's Gear
  83141, -- Bold Serpent's Eye
  83142, -- Quick Serpent's Eye
  83143, -- Fractured Serpent's Eye
  83144, -- Rigid Serpent's Eye
  83145, -- Subtle Serpent's Eye
  83146, -- Smooth Serpent's Eye
  83147, -- Precise Serpent's Eye
  83148, -- Solid Serpent's Eye
  83149, -- Sparkling Serpent's Eye
  83150, -- Brilliant Serpent's Eye
  83151, -- Delicate Serpent's Eye
  83152, -- Flashing Serpent's Eye
  89674, -- Tense Imperial Amethyst
  89675, -- Tense Roguestone
  89676, -- Perfect Tense Roguestone
  89678, -- Assassin's Roguestone
  89679, -- Perfect Assassin's Roguestone
  89680, -- Assassin's Imperial Amethyst
  93404, -- Resplendent Serpent's Eye
  93405, -- Lucent Serpent's Eye
  93406, -- Willful Serpent's Eye
  93408, -- Tense Serpent's Eye
  93409, -- Assassin's Serpent's Eye
  93410, -- Mysterious Serpent's Eye
  93705, -- Nimble Wild Jade
  93706, -- Nimble Alexandrite
  93707, -- Perfect Nimble Alexandrite
  95348, -- Tyrannical Primal Diamond
}

-- Permanent Enhancements
database["PermanentEnhancements"] = {
  74700, -- Enchant Bracer - Mastery
  74701, -- Enchant Bracer - Major Dodge
  74703, -- Enchant Bracer - Super Intellect
  74704, -- Enchant Bracer - Exceptional Strength
  74705, -- Enchant Bracer - Greater Agility
  74706, -- Enchant Chest - Super Armor
  74707, -- Enchant Chest - Mighty Versatility
  74708, -- Enchant Chest - Glorious Stats
  74709, -- Enchant Chest - Superior Stamina
  74710, -- Enchant Cloak - Accuracy
  74711, -- Enchant Cloak - Greater Protection
  74712, -- Enchant Cloak - Superior Intellect
  74713, -- Enchant Cloak - Superior Critical Strike
  74715, -- Enchant Boots - Greater Haste
  74716, -- Enchant Boots - Greater Precision
  74717, -- Enchant Boots - Blurred Speed
  74718, -- Enchant Boots - Pandaren's Step
  74719, -- Enchant Gloves - Greater Haste
  74720, -- Enchant Gloves - Superior Haste
  74721, -- Enchant Gloves - Super Strength
  74722, -- Enchant Gloves - Superior Mastery
  74723, -- Enchant Weapon - Windsong
  74724, -- Enchant Weapon - Jade Spirit
  74725, -- Enchant Weapon - Elemental Force
  74726, -- Enchant Weapon - Dancing Steel
  74727, -- Enchant Weapon - Colossus
  74728, -- Enchant Weapon - River's Song
  74729, -- Enchant Off-Hand - Major Intellect
  77529, -- Lord Blastington's Scope of Doom
  77531, -- Mirror Scope
  82442, -- Pearlescent Spellthread
  82443, -- Cerulean Spellthread
  82444, -- Greater Pearlescent Spellthread
  82445, -- Greater Cerulean Spellthread
  83006, -- Greater Tiger Fang Inscription
  83007, -- Greater Tiger Claw Inscription
  83763, -- Ironscale Leg Armor
  83764, -- Shadowleather Leg Armor
  83765, -- Angerhide Leg Armor
  85559, -- Sha Armor Kit
  85568, -- Brutal Leg Armor
  85569, -- Sha-Touched Leg Armor
  85570, -- Toughened Leg Armor
  86597, -- Living Steel Weapon Chain
  86599, -- Ghost Iron Shield Spike
  87559, -- Greater Crane Wing Inscription
  87560, -- Greater Ox Horn Inscription
  87577, -- Ox Horn Inscription
  87578, -- Crane Wing Inscription
  87579, -- Tiger Claw Inscription
  87580, -- Tiger Fang Inscription
  87581, -- Secret Ox Horn Inscription
  87582, -- Secret Crane Wing Inscription
  87584, -- Secret Tiger Claw Inscription
  87585, -- Secret Tiger Fang Inscription
  89737, -- Enchant Shield - Greater Parry
  95349, -- Enchant Weapon - Glorious Tyranny
  98163, -- Enchant Weapon - Bloody Dancing Steel
  98164, -- Enchant Weapon - Spirit of Conquest
}

-- Archeology
database["Archeology"] = {
  79868, -- Pandaren Pottery Shard
  79869, -- Mogu Statue Piece
  95373, -- Mantid Amber Sliver
}

-- Cloth
database["Cloth"] = {
  72988, -- Windwool Cloth
  82441, -- Bolt of Windwool Cloth
  82447, -- Imperial Silk
  92960, -- Silkworm Cocoon
  98619, -- Celestial Cloth
}

-- Enchanting
database["Enchanting"] = {
  74247, -- Ethereal Shard
  74248, -- Sha Crystal
  74249, -- Spirit Dust
  74250, -- Mysterious Essence
  74252, -- Small Ethereal Shard
  80433, -- Blood Spirit
  89738, -- Essence or Dust
  94289, -- Haunting Spirit
  102218, -- Spirit of War
  105718, -- Sha Crystal Fragment
}

-- Herbs
database["Herbs"] = {
  72234, -- Green Tea Leaf
  72235, -- Silkweed
  72237, -- Rain Poppy
  72238, -- Golden Lotus
  79010, -- Snow Lily
  79011, -- Fool's Cap
  97619, -- Torn Green Tea Leaf
  97620, -- Rain Poppy Petal
  97621, -- Silkweed Stem
  97622, -- Snow Lily Petal
  97623, -- Fool's Cap Spores
  97624, -- Desecrated Herb Pod
}

-- Inscription
database["Inscription"] = {
  79251, -- Shadow Pigment
  79253, -- Misty Pigment
  79254, -- Ink of Dreams
  79255, -- Starlight Ink
  79283, -- Ace of Tigers
  79284, -- Two of Tigers
  79285, -- Three of Tigers
  79286, -- Four of Tigers
  79287, -- Five of Tigers
  79288, -- Six of Tigers
  79289, -- Seven of Tigers
  79290, -- Eight of Tigers
  79291, -- Ace of Oxen
  79292, -- Two of Oxen
  79293, -- Three of Oxen
  79294, -- Four of Oxen
  79295, -- Five of Oxen
  79296, -- Six of Oxen
  79297, -- Seven of Oxen
  79298, -- Eight of Oxen
  79299, -- Ace of Cranes
  79300, -- Two of Cranes
  79301, -- Three of Cranes
  79302, -- Four of Cranes
  79303, -- Five of Cranes
  79304, -- Six of Cranes
  79305, -- Seven of Cranes
  79306, -- Eight of Cranes
  79307, -- Ace of Serpents
  79308, -- Two of Serpents
  79309, -- Three of Serpents
  79310, -- Four of Serpents
  79311, -- Five of Serpents
  79312, -- Six of Serpents
  79313, -- Seven of Serpents
  79314, -- Eight of Serpents
  79731, -- Scroll of Wisdom
}

-- Jewelcrafting
database["Jewelcrafting"] = {
  76130, -- Tiger Opal
  76131, -- Primordial Ruby
  76132, -- Primal Diamond
  76133, -- Lapis Lazuli
  76134, -- Sunstone
  76135, -- Roguestone
  76136, -- Pandarian Garnet
  76137, -- Alexandrite
  76138, -- River's Heart
  76139, -- Wild Jade
  76140, -- Vermilion Onyx
  76141, -- Imperial Amethyst
  76142, -- Sun's Radiance
  76734, -- Serpent's Eye
}

-- Leather
database["Leather"] = {
  72120, -- Exotic Leather
  72162, -- Sha-Touched Leather
  72163, -- Magnificent Hide
  79101, -- Prismatic Scale
  98617, -- Hardened Magnificent Hide
}

-- Meat & Fish
database["MeatFish"] = {
  74659, -- Farm Chicken
  74660, -- Pandaren Peach
  74661, -- Black Pepper
  74662, -- Rice Flour
  74832, -- Barley
  74833, -- Raw Tiger Steak
  74834, -- Mushan Ribs
  74837, -- Raw Turtle Meat
  74838, -- Raw Crab Meat
  74839, -- Wildfowl Breast
  74840, -- Green Cabbage
  74841, -- Juicycrunch Carrot
  74842, -- Mogu Pumpkin
  74843, -- Scallions
  74844, -- Red Blossom Leek
  74845, -- Ginseng
  74846, -- Witchberries
  74847, -- Jade Squash
  74848, -- Striped Melon
  74849, -- Pink Turnip
  74850, -- White Turnip
  74851, -- Rice
  74852, -- Yak Milk
  74853, -- 100 Year Soy Sauce
  74854, -- Instant Noodles
  74856, -- Jade Lungfish
  74857, -- Giant Mantis Shrimp
  74859, -- Emperor Salmon
  74860, -- Redbelly Mandarin
  74861, -- Tiger Gourami
  74863, -- Jewel Danio
  74864, -- Reef Octopus
  74865, -- Krasarang Paddlefish
  74866, -- Golden Carp
  75014, -- Raw Crocolisk Belly
  79246, -- Delicate Blossom Petals
  79250, -- Fresh Pomfruit
  85506, -- Viseclaw Meat
  85583, -- Needle Mushrooms
  85584, -- Silkworm Pupa
  85585, -- Red Beans
  102536, -- Fresh Lushroom
  102537, -- Fresh Silkfeather Hawk Eggs
  102538, -- Fresh Shao-Tien Rice
  102539, -- Fresh Strawberries
  102540, -- Fresh Mangos
  102541, -- Aged Balsamic Vinegar
  102542, -- Ancient Pandaren Spices
  102543, -- Aged Mogu'shan Cheese
}

-- Metal & Stone
database["MetalStone"] = {
  72092, -- Ghost Iron Ore
  72093, -- Kyparite
  72094, -- Black Trillium Ore
  72095, -- Trillium Bar
  72096, -- Ghost Iron Bar
  72103, -- White Trillium Ore
  72104, -- Living Steel
  97512, -- Ghost Iron Nugget
  97546, -- Kyparite Fragment
}

-- Other Tradegoods
database["OtherTradegoods"] = {
  78912, -- Silver Filigree Flask
  79318, -- Darkmoon Card of Mists
  79868, -- Pandaren Pottery Shard
  79869, -- Mogu Statue Piece
  80240, -- Strange Spherical Stone
  83064, -- Spinefish
  83092, -- Orb of Mystery
  87658, -- Empty Raw Tiger Steak Container
  87659, -- Empty Mushan Ribs Container
  87660, -- Empty Raw Turtle Meat Container
  87661, -- Empty Raw Crab Meat Container
  87662, -- Empty Wildfowl Breast Container
  87663, -- Empty Green Cabbage Container
  87664, -- Empty Juicycrunch Carrot Container
  87665, -- Empty Mogu Pumpkin Container
  87666, -- Empty Scallions Container
  87667, -- Empty Red Blossom Leek Container
  87669, -- Empty Witchberries Container
  87670, -- Empty Jade Squash Container
  87671, -- Empty Striped Melon Container
  87672, -- Empty Pink Turnip Container
  87673, -- Empty White Turnip Container
  87678, -- Empty Jade Lungfish Container
  87679, -- Empty Giant Mantis Shrimp Container
  87680, -- Empty Emperor Salmon Container
  87681, -- Empty Redbelly Mandarin Container
  87682, -- Empty Tiger Gourami Container
  87683, -- Empty Jewel Danio Container
  87684, -- Empty Reef Octopus Container
  87685, -- Empty Krasarang Paddlefish Container
  87686, -- Empty Golden Carp Container
  87687, -- Empty Crocolisk Belly Container
  90407, -- Sparkling Shard
  95373, -- Mantid Amber Sliver
}

-- Parts
database["Parts"] = {
  77467, -- Ghost Iron Bolts
  77468, -- High-Explosive Gunpowder
  77469, -- Salvaged Parts
  90146, -- Tinker's Kit
  94111, -- Lightning Steel Ingot
  94113, -- Jard's Peculiar Energy Source
  98717, -- Balanced Trillium Ingot
}

-- Spirit of Harmony
database["SpiritofHarmony"] = {
  76061, -- Spirit of Harmony
  89112, -- Mote of Harmony
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
      AddToSet(database["Gems"], database["PermanentEnhancements"])
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
  end
  if self.db.profile.moveMergedTradegoods then
    Result[formatBagTitle(self, L["Tradegoods"], converttohex(self.db.profile.color.mergedTradegoods))] = AddToSet(
      database["Archeology"],
      database["Cloth"],
      database["Enchanting"],
      database["Herbs"],
      database["Inscription"],
      database["Jewelcrafting"],
      database["Leather"],
      database["MeatFish"],
      database["MetalStone"],
      database["OtherTradegoods"],
      database["Parts"],
      database["SpiritofHarmony"]
    )
  else
    if self.db.profile.moveArcheology then
      Result[formatBagTitle(self, L["Archeology"], converttohex(self.db.profile.color.Archeology))] =
        AddToSet(database["Archeology"])
    end
    if self.db.profile.moveCloth then
      Result[formatBagTitle(self, L["Cloth"], converttohex(self.db.profile.color.Cloth))] = AddToSet(database["Cloth"])
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
    if self.db.profile.moveSpiritofHarmony then
      Result[formatBagTitle(self, L["Spirit of Harmony"], converttohex(self.db.profile.color.SpiritofHarmony))] =
        AddToSet(database["SpiritofHarmony"])
    end
  end

  return Result
end

local setFilter = AdiBags:RegisterFilter("Mists Of Pandaria", 98, "ABEvent-1.0")
setFilter.uiName = string.format("|cff00eb42%s|r", L["Mists Of Pandaria"])
setFilter.uiDesc = string.format(
  "%s\n|cffffd800%s: 1.0.7|r",
  L["Items from the Mists Of Pandaria expansion."],
  L["Filter version"]
)

function setFilter:OnInitialize()
  self.db = AdiBags.db:RegisterNamespace("Mists Of Pandaria", {
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
      moveMergedTradegoods = true,
      moveArcheology = true,
      moveCloth = true,
      moveEnchanting = true,
      moveHerbs = true,
      moveInscription = true,
      moveJewelcrafting = true,
      moveLeather = true,
      moveMeatFish = true,
      moveMetalStone = true,
      moveOtherTradegoods = true,
      moveParts = true,
      moveSpiritofHarmony = true,

      color = {
        prefix = converttorgb("00eb42", true),
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
        mergedTradegoods = converttorgb("786f52", true),
        Archeology = converttorgb("864200", true),
        Cloth = converttorgb("feb95f", true),
        Enchanting = converttorgb("540d6e", true),
        Herbs = converttorgb("0ead69", true),
        Inscription = converttorgb("ffd23f", true),
        Jewelcrafting = converttorgb("090446", true),
        Leather = converttorgb("563635", true),
        MeatFish = converttorgb("f71735", true),
        MetalStone = converttorgb("6e9075", true),
        OtherTradegoods = converttorgb("81f0e5", true),
        Parts = converttorgb("5b6057", true),
        SpiritofHarmony = converttorgb("c2095a", true),
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
            ["M"] = "M",
            ["M-"] = "M-",
            ["4."] = "4.",
            ["MOP"] = "MOP",
            ["|T626002:" .. AdiBags.HEADER_SIZE .. ":" .. AdiBags.HEADER_SIZE .. ":-2:-10|t"] = "|T626002:"
              .. AdiBags.HEADER_SIZE
              .. "|t",
            ["|T629482:" .. AdiBags.HEADER_SIZE .. ":" .. AdiBags.HEADER_SIZE .. ":-2:-10|t"] = "|T629482:"
              .. AdiBags.HEADER_SIZE
              .. "|t",
            ["|T606550:" .. AdiBags.HEADER_SIZE .. ":" .. AdiBags.HEADER_SIZE .. ":-2:-10|t"] = "|T606550:"
              .. AdiBags.HEADER_SIZE
              .. "|t",
            ["|T630786:" .. AdiBags.HEADER_SIZE .. ":" .. AdiBags.HEADER_SIZE .. ":-2:-10|t"] = "|T630786:"
              .. AdiBags.HEADER_SIZE
              .. "|t",
            ["|T626190:" .. AdiBags.HEADER_SIZE .. ":" .. AdiBags.HEADER_SIZE .. ":-2:-10|t"] = "|T626190:"
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
        moveBlacksmithingRecipes = {
          name = L["Blacksmithing Recipes"],
          desc = L["Recipes for forging metal armor, weapons, and enhancements."],
          type = "toggle",
          width = 1.5,
          order = 86,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
        },
        colorBlacksmithingRecipes = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Blacksmithing Recipes"]),
          type = "color",
          order = 87,
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
        seperator_9 = {
          type = "header",
          name = "",
          order = 88,
        },
        moveCookingRecipes = {
          name = L["Cooking Recipes"],
          desc = L["Recipes for preparing food that provides buffs."],
          type = "toggle",
          width = 1.5,
          order = 89,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
        },
        colorCookingRecipes = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Cooking Recipes"]),
          type = "color",
          order = 90,
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
        seperator_10 = {
          type = "header",
          name = "",
          order = 91,
        },
        moveEnchantingRecipes = {
          name = L["Enchanting Recipes"],
          desc = L["Recipes for enchanting gear with magical properties."],
          type = "toggle",
          width = 1.5,
          order = 92,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
        },
        colorEnchantingRecipes = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Enchanting Recipes"]),
          type = "color",
          order = 93,
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
        seperator_11 = {
          type = "header",
          name = "",
          order = 94,
        },
        moveEngineeringRecipes = {
          name = L["Engineering Recipes"],
          desc = L["Recipes for creating gadgets, explosives, and mechanical devices."],
          type = "toggle",
          width = 1.5,
          order = 95,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
        },
        colorEngineeringRecipes = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Engineering Recipes"]),
          type = "color",
          order = 96,
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
        seperator_12 = {
          type = "header",
          name = "",
          order = 97,
        },
        moveInscriptionRecipes = {
          name = L["Inscription Recipes"],
          desc = L["Recipes for scribing glyphs and crafting scrolls and tomes."],
          type = "toggle",
          width = 1.5,
          order = 98,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
        },
        colorInscriptionRecipes = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Inscription Recipes"]),
          type = "color",
          order = 99,
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
        seperator_13 = {
          type = "header",
          name = "",
          order = 100,
        },
        moveJewelcraftingRecipes = {
          name = L["Jewelcrafting Recipes"],
          desc = L["Recipes for cutting gems and crafting jewelry."],
          type = "toggle",
          width = 1.5,
          order = 101,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
        },
        colorJewelcraftingRecipes = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Jewelcrafting Recipes"]),
          type = "color",
          order = 102,
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
        seperator_14 = {
          type = "header",
          name = "",
          order = 103,
        },
        moveLeatherworkingRecipes = {
          name = L["Leatherworking Recipes"],
          desc = L["Recipes for crafting leather and mail armor."],
          type = "toggle",
          width = 1.5,
          order = 104,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
        },
        colorLeatherworkingRecipes = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Leatherworking Recipes"]),
          type = "color",
          order = 105,
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
        seperator_15 = {
          type = "header",
          name = "",
          order = 106,
        },
        moveTailoringRecipes = {
          name = L["Tailoring Recipes"],
          desc = L["Recipes for weaving cloth armor and other cloth items."],
          type = "toggle",
          width = 1.5,
          order = 107,
          disabled = function()
            return self.db.profile.moveMergedRecipes
          end,
        },
        colorTailoringRecipes = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Tailoring Recipes"]),
          type = "color",
          order = 108,
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
      order = 109,
      args = {
        Legendaries_desc = {
          type = "description",
          name = L["Use these for a powerup!"],
          order = 110,
        },
        moveMergedTemporaryPermanentEnhancements = {
          name = string.format(L["%sMerge %s%s"], "|cffffd800", L["Temporary & Permanent Enhancements"], "|r"),
          desc = string.format(L["Merge all %s into a single category."], L["Temporary & Permanent Enhancements"]),
          type = "toggle",
          width = 1.5,
          order = 111,
        },
        colorMergedTemporaryPermanentEnhancements = {
          name = L["Color"],
          desc = string.format(
            L["Select a color for the merged %s category."],
            L["Temporary & Permanent Enhancements"]
          ),
          type = "color",
          order = 112,
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
        seperator_16 = {
          type = "header",
          name = "",
          order = 113,
        },
        moveGems = {
          name = L["Gems"],
          desc = L["These are gems that you can typically apply to armor to improve it."],
          type = "toggle",
          width = 1.5,
          order = 114,
          disabled = function()
            return self.db.profile.moveMergedTemporaryPermanentEnhancements
          end,
        },
        colorGems = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Gems"]),
          type = "color",
          order = 115,
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
        seperator_17 = {
          type = "header",
          name = "",
          order = 116,
        },
        movePermanentEnhancements = {
          name = L["Permanent Enhancements"],
          desc = L["These are permanent enhancements that you can typically apply to armor to improve it."],
          type = "toggle",
          width = 1.5,
          order = 117,
          disabled = function()
            return self.db.profile.moveMergedTemporaryPermanentEnhancements
          end,
        },
        colorPermanentEnhancements = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Permanent Enhancements"]),
          type = "color",
          order = 118,
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
      },
    },
    Tradegoods_config = {
      type = "group",
      name = L["Tradegoods"],
      desc = "", -- doesnt work,
      inline = true,
      order = 119,
      args = {
        Legendaries_desc = {
          type = "description",
          name = L["Trading tradegoods is good. Trade tradegoods for good goods."],
          order = 120,
        },
        moveMergedTradegoods = {
          name = string.format(L["%sMerge %s%s"], "|cffffd800", L["Tradegoods"], "|r"),
          desc = string.format(L["Merge all %s into a single category."], L["Tradegoods"]),
          type = "toggle",
          width = 1.5,
          order = 121,
        },
        colorMergedTradegoods = {
          name = L["Color"],
          desc = string.format(L["Select a color for the merged %s category."], L["Tradegoods"]),
          type = "color",
          order = 122,
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
        seperator_18 = {
          type = "header",
          name = "",
          order = 123,
        },
        moveArcheology = {
          name = L["Archeology"],
          desc = L["Archeology items."],
          type = "toggle",
          width = 1.5,
          order = 124,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorArcheology = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Archeology"]),
          type = "color",
          order = 125,
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
        seperator_19 = {
          type = "header",
          name = "",
          order = 126,
        },
        moveCloth = {
          name = L["Cloth"],
          desc = L["Cloth used in Tailoring."],
          type = "toggle",
          width = 1.5,
          order = 127,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorCloth = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Cloth"]),
          type = "color",
          order = 128,
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
        seperator_20 = {
          type = "header",
          name = "",
          order = 129,
        },
        moveEnchanting = {
          name = L["Enchanting"],
          desc = L["Enchanting materials for enchanting weapons & armor."],
          type = "toggle",
          width = 1.5,
          order = 130,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorEnchanting = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Enchanting"]),
          type = "color",
          order = 131,
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
        seperator_21 = {
          type = "header",
          name = "",
          order = 132,
        },
        moveHerbs = {
          name = L["Herbs"],
          desc = L["Herbs used in Alchemy & Inscription."],
          type = "toggle",
          width = 1.5,
          order = 133,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorHerbs = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Herbs"]),
          type = "color",
          order = 134,
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
        seperator_22 = {
          type = "header",
          name = "",
          order = 135,
        },
        moveInscription = {
          name = L["Inscription"],
          desc = L["Inscription materials for creating glyphs or other paper related goods."],
          type = "toggle",
          width = 1.5,
          order = 136,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorInscription = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Inscription"]),
          type = "color",
          order = 137,
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
        seperator_23 = {
          type = "header",
          name = "",
          order = 138,
        },
        moveJewelcrafting = {
          name = L["Jewelcrafting"],
          desc = L["Jewelcrafting materials for creating rings, necklaces, gems, etc."],
          type = "toggle",
          width = 1.5,
          order = 139,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorJewelcrafting = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Jewelcrafting"]),
          type = "color",
          order = 140,
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
        seperator_24 = {
          type = "header",
          name = "",
          order = 141,
        },
        moveLeather = {
          name = L["Leather"],
          desc = L["Leather used in Leatherworking."],
          type = "toggle",
          width = 1.5,
          order = 142,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorLeather = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Leather"]),
          type = "color",
          order = 143,
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
        seperator_25 = {
          type = "header",
          name = "",
          order = 144,
        },
        moveMeatFish = {
          name = L["Meat & Fish"],
          desc = L["Meat & Fish used in Cooking."],
          type = "toggle",
          width = 1.5,
          order = 145,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorMeatFish = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Meat & Fish"]),
          type = "color",
          order = 146,
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
        seperator_26 = {
          type = "header",
          name = "",
          order = 147,
        },
        moveMetalStone = {
          name = L["Metal & Stone"],
          desc = L["Metal & Stone used in Blacksmithing."],
          type = "toggle",
          width = 1.5,
          order = 148,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorMetalStone = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Metal & Stone"]),
          type = "color",
          order = 149,
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
        seperator_27 = {
          type = "header",
          name = "",
          order = 150,
        },
        moveOtherTradegoods = {
          name = L["Other Tradegoods"],
          desc = L["Other items used in various professions."],
          type = "toggle",
          width = 1.5,
          order = 151,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorOtherTradegoods = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Other Tradegoods"]),
          type = "color",
          order = 152,
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
        seperator_28 = {
          type = "header",
          name = "",
          order = 153,
        },
        moveParts = {
          name = L["Parts"],
          desc = L["Parts used in Engineering."],
          type = "toggle",
          width = 1.5,
          order = 154,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorParts = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Parts"]),
          type = "color",
          order = 155,
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
        seperator_29 = {
          type = "header",
          name = "",
          order = 156,
        },
        moveSpiritofHarmony = {
          name = L["Spirit of Harmony"],
          desc = L["Spirits are used in all professions."],
          type = "toggle",
          width = 1.5,
          order = 157,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
        },
        colorSpiritofHarmony = {
          name = L["Color"],
          desc = string.format(L["Select a color for %s."], L["Spirit of Harmony"]),
          type = "color",
          order = 158,
          disabled = function()
            return self.db.profile.moveMergedTradegoods
          end,
          get = function()
            local color = self.db.profile.color.SpiritofHarmony
            AdiBags:UpdateFilters()
            return color.r, color.g, color.b
          end,
          set = function(_, r, g, b)
            local color = self.db.profile.color.SpiritofHarmony
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
