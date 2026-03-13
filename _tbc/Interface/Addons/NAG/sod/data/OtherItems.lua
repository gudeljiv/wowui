--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
    https://creativecommons.org/licenses/by-nc/4.0/

    Author: Rakizi
    Date: 2024

    Cataclysm item data
]]

local _, ns = ...

ns.data = ns.data or {}
ns.data.sod = ns.data.sod or {}
ns.data.sod.Items = ns.data.sod.Items or {}

-- Initialize Cataclysm item data
ns.data.sod.Items.OtherItems = {
    -- Trinkets
    Trinket = {
        236344,
        24427, -- diamond flask

    },
    -- Consumables
    Consumable = {
        -- Flasks
        flask = {
            13512, -- Flask of Supreme Power
            13510, -- Flask of the Titans
            13511, -- Flask of Distilled Wisdom
            13513, -- Flask of Chromatic Resistance
            2593,  -- Flask of Fortification
        },
        -- Battle Elixirs
        battleElixir = {
            9224,   -- Elixir of Demonslaying
            17708,  -- Elixir of Frost Power
            9264,   -- Elixir of Greater Agility
            21546,  -- Elixir of Greater Firepower
            9187,   -- Elixir of Greater Agility
            8949,   -- Elixir of Agility
            13452,  -- Elixir of the Mongoose
            13454,  -- Greater Arcane Elixir
            8410,   -- R.O.I.D.S
            3391,   -- Elixir of Ogre's Strength
            2457,   -- Elixir of Minor Agility
            9155,   -- Arcane Elixir
            8411,   -- Elixir of Giant Growth
            2454,   -- Elixir of Lion's Strength
            17538,  -- Elixir of the Mongoose
            217398, -- Lesser Arcane Elixir (SoD specific)
            233968, -- Elixir of the Mage Lord (SoD specific)
            6373,   -- Elixir of Firepower
        },
        -- Guardian Elixirs
        guardianElixir = {
            3826,  -- Mighty Troll's Blood Elixir
            3388,  -- Strong Troll's Blood Potion
            3825,  -- Elixir of Fortitude
            3223,  -- Elixir of Giant Growth
            2458,  -- Elixir of Minor Fortitude
            3382,  -- Weak Troll's Blood Elixir
            3389,  -- Elixir of Defense
            8412,  -- Ground Scorpok Assay
            8423,  -- Elixir of Detect Lesser Invisibility
            5997,  -- Elixir of Minor Defense
            20079, -- Spirit of Zanza
            20081, -- Swiftness of Zanza
            20080, -- Sheen of Zanza
        },
        -- Potions
        potions = {
            13442, -- Mighty Rage Potion
            13443, -- Superior Mana Potion
            13444, -- Major Mana Potion
            13446, -- Major Healing Potion
            13453, -- Elixir of Brute Force
            13455, -- Greater Stoneshield Potion
            13456, -- Greater Frost Protection Potion
            13457, -- Greater Fire Protection Potion
            13458, -- Greater Nature Protection Potion
            13459, -- Greater Shadow Protection Potion
            13460, -- Greater Holy Protection Potion
            13461, -- Greater Arcane Protection Potion
            13462, -- Purification Potion
            6049,  -- Greater Fire Protection Potion
            6050,  -- Greater Nature Protection Potion
            6051,  -- Holy Protection Potion
            6052,  -- Nature Protection Potion
            6048,  -- Shadow Protection Potion
            3387,  -- Limited Invulnerability Potion
            3928,  -- Superior Healing Potion
            5633,  -- Great Rage Potion
            5634,  -- Free Action Potion
            5631,  -- Rage Potion
            3823,  -- Lesser Invisibility Potion
            6372,  -- Swim Speed Potion
            2459,  -- Swiftness Potion
            2456,  -- Minor Rejuvenation Potion
            2455,  -- Minor Mana Potion
            118,   -- Minor Healing Potion
            858,   -- Lesser Healing Potion
            929,   -- Healing Potion
            1710,  -- Greater Healing Potion
            3385,  -- Lesser Mana Potion
            3386,  -- Mana Potion
            6149,  -- Greater Mana Potion
            4623,  -- Lesser Stoneshield Potion
            9036,  -- Magic Resistance Potion
            215162, -- Mildly Irradiated Rejuvenation Potion (SoD specific)
            213407, -- catnip - druid
        },
        -- Temporary Item Enhancements
        temporaryEnhancement = {
            12450, -- Juju Power
            12451, -- Juju Might
            12455, -- Juju Escape
            12457, -- Juju Chill
            12458, -- Juju Ember
            12459, -- Juju Flurry
            12460, -- Juju Guile
            20081, -- Swiftness of Zanza
            20079, -- Spirit of Zanza
            20080, -- Sheen of Zanza
            12820, -- Winterfall Firewater
            9088,  -- Gift of Arthas
            12849, -- Gurubashi Mojo Madness
            9224,  -- Elixir of Demonslaying
            9264,  -- Elixir of Greater Agility
            12846  -- Gurubashi Mojo Madness
        },
        -- Permanent Item Enhancements
        permanentEnhancement = {
            18262, -- Elemental Sharpening Stone
            12404, -- Dense Sharpening Stone
            7964,  -- Solid Sharpening Stone
            2863,  -- Coarse Sharpening Stone
            2862,  -- Rough Sharpening Stone
            23122, -- Consecrated Sharpening Stone
            12643, -- Dense Weightstone
            3241,  -- Heavy Weightstone
            3240,  -- Coarse Weightstone
            3239,  -- Rough Weightstone
            23123  -- Blessed Weightstone
        },
        -- Food and Drink
        food = {
            13932, -- Smoked Desert Dumplings
            13928, -- Grilled Squid
            13927, -- Cooked Glossy Mightfish
            13934, -- Mightfish Steak
            18254, -- Runn Tum Tuber Surprise
            20452, -- Smoked Desert Dumplings
            20074, -- Heavy Crocolisk Steak
            20031, -- Dirge's Kickin' Chimaerok Chops
            21023  -- Dirge's Kickin' Chimaerok Chops
        },
        drink = {
            8766, -- Morning Glory Dew
            8078, -- Conjured Crystal Water
            8079, -- Conjured Sparkling Water
            8077, -- Conjured Mineral Water
            8076, -- Conjured Fresh Water
            8075, -- Conjured Water
            19318 -- Blessed Sunfruit Juice
        },
        -- Scrolls
        scroll = {
            10309, -- Scroll of Protection IV
            10310, -- Scroll of Protection V
            4426,  -- Scroll of Protection III
            4421,  -- Scroll of Protection II
            3013,  -- Scroll of Protection
            10305, -- Scroll of Stamina IV
            10306, -- Scroll of Stamina V
            4422,  -- Scroll of Stamina III
            4419,  -- Scroll of Stamina II
            3012,  -- Scroll of Stamina
            10307, -- Scroll of Spirit IV
            10308, -- Scroll of Spirit V
            4424,  -- Scroll of Spirit III
            4420,  -- Scroll of Spirit II
            1712,  -- Scroll of Spirit
            10302, -- Scroll of Strength IV
            10303, -- Scroll of Strength V
            4425,  -- Scroll of Strength III
            2289,  -- Scroll of Strength II
            954,   -- Scroll of Strength
            10298, -- Scroll of Intellect IV
            10299, -- Scroll of Intellect V
            4419,  -- Scroll of Intellect III
            2290,  -- Scroll of Intellect II
            955,   -- Scroll of Intellect
            10300, -- Scroll of Agility IV
            10301, -- Scroll of Agility V
            4423,  -- Scroll of Agility III
            2288,  -- Scroll of Agility II
            3012   -- Scroll of Agility
        },
    },
    -- Weapons
    Weapon = { 229910 },
    -- Engineering items (SoD specific)
    Engineering = {
        -- Explosives
        explosive = {
            236344,
            233986,
            233985,
            10646, 15993, 10562, 4390, 4398, 18641, 10586, 10507, 233985, 18594, 4394, 4384, 16040, 4852, 18588, 6714, 4360, 4367, 4380, 16005, 10514, 4374, 4395, 4358, 4365, 4378, 4370, 233986, 215127, 233984, 10580, 215168, 221325

        },
        -- Tinkers
        tinker = {
        },
        -- Gadgets
        gadget = {
        },
    },
}
