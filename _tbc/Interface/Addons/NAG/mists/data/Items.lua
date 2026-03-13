--[[
    Universal Items Data File
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
    https://creativecommons.org/licenses/by-nc/4.0/

    Consolidates: Consumables, Enchants, OtherItems, TierSets, and Trinkets
    Generated: 2025-01-08
]]

local _, ns = ...
ns.data = ns.data or {}
ns.data.mists = ns.data.mists or {}
ns.data.mists.Items = ns.data.mists.Items or {}

-- ============================ CONSUMABLES ============================
--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
    https://creativecommons.org/licenses/by-nc/4.0/

    Generated from WoWSims data
    Date: 2025-01-08

    Consumable data
]]
ns.data.mists.Items.Consumable = ns.data.mists.Items.Consumable or {}
ns.data.mists.Items.Consumable = {
    -- Potion
    potion = { 93351, 86569, 91803, 95054, 97157, 80040, 97156, 92979, 88416, 247802, 92943, 95055, 98063, 93742, 92942, 98061, 98062, 92954, 104277, 92941, 92964 },
    flask = { 76084, 76085, 76086, 76087, 76088, 103557 },
    -- Elixir
    elixir = {
        battle = { },
        guardian = { },
    },
    managem = { },

}

-- ============================ ENCHANTS ============================
-- This file contains detailed data for item enchantments.
-- It links enchants to their corresponding stats or trigger/proc spells.
ns.data.mists.Enchants = {


-- DEBUG: First 3 records for inspection:
-- DEBUG Record 1: ID=2, Name="Frostbrand", Flags=9
-- DEBUG Record 2: ID=5, Name="Flametongue", Flags=9
-- DEBUG Record 3: ID=13, Name="Sharpened (+$k1 Damage)", Flags=33

    [1891] = { name = "+$19988s1 All Stats", effects = { { effectType = 3, effectValue = 0, effectArg = 144768 } } }, -- +$19988s1 All Stats
    [2488] = { name = "+$18676s1 All Resistances", flags = 33, effects = { { effectType = 3, effectValue = 0, effectArg = 144757 } } }, -- +$18676s1 All Resistances
    [2661] = { name = "+$27959s1 All Stats", effects = { { effectType = 3, effectValue = 0, effectArg = 144845 } } }, -- +$27959s1 All Stats
    [2931] = { name = "+$19988s1 All Stats", flags = 33, effects = { { effectType = 3, effectValue = 4, effectArg = 357403 } } }, -- +$19988s1 All Stats
    [3209] = { name = "+$k1 Agility", flags = 32, effects = { { effectType = 3, effectValue = 0, effectArg = 354751 } } }, -- +$k1 Agility
    [3212] = { name = "+$k1 Stamina", flags = 33, effects = { { effectType = 3, effectValue = 0, effectArg = 354747 } } }, -- +$k1 Stamina
    [3214] = { name = "+$k1 Spirit", flags = 32, effects = { { effectType = 3, effectValue = 24, effectArg = 354755 } } }, -- +$k1 Spirit
    [3215] = { name = "+$k1 PvP Resilience", flags = 32, effects = { { effectType = 3, effectValue = 0, effectArg = 354724 } } }, -- +$k1 PvP Resilience
    [4045] = { name = "+$k1 Mastery and Minor Run Speed Increase", flags = 32, effects = { { effectType = 5, effectValue = 108, effectArg = 49 }, { effectType = 3, effectValue = 0, effectArg = 24090 } } }, -- +$k1 Mastery and Minor Run Speed Increase
    [4046] = { name = "+$k1 Critical Strike and $44797s1% Increased Critical Effect", flags = 32, effects = { { effectType = 5, effectValue = 108, effectArg = 32 }, { effectType = 3, effectValue = 0, effectArg = 44797 } } }, -- +$k1 Critical Strike and $44797s1% Increased Critical Effect
    [4047] = { name = "+$k1 Intellect and 2% Reduced Threat", flags = 32, effects = { { effectType = 5, effectValue = 54, effectArg = 5 }, { effectType = 3, effectValue = 0, effectArg = 32842 } } }, -- +$k1 Intellect and 2% Reduced Threat
    [4048] = { name = "+$k1 Stamina and +$55283s1% Shield Block Value", flags = 32, effects = { { effectType = 5, effectValue = 81, effectArg = 7 }, { effectType = 3, effectValue = 0, effectArg = 55283 } } }, -- +$k1 Stamina and +$55283s1% Shield Block Value
    [4049] = { name = "+$k1 Stamina and 2% Increased Armor Value from Items", flags = 32, effects = { { effectType = 5, effectValue = 81, effectArg = 7 }, { effectType = 3, effectValue = 0, effectArg = 55344 } } }, -- +$k1 Stamina and 2% Increased Armor Value from Items
    [4050] = { name = "+$k1 Stamina and Reduce Spell Damage Taken by 2%", flags = 32, effects = { { effectType = 5, effectValue = 81, effectArg = 7 }, { effectType = 3, effectValue = 0, effectArg = 55345 } } }, -- +$k1 Stamina and Reduce Spell Damage Taken by 2%
    [4051] = { name = "+$k1 Intellect and +$46600s1% Maximum Mana", flags = 32, effects = { { effectType = 5, effectValue = 54, effectArg = 5 }, { effectType = 3, effectValue = 0, effectArg = 46600 } } }, -- +$k1 Intellect and +$46600s1% Maximum Mana
    [4052] = { name = "+$k1 Spirit and 3% Increased Critical Effect", flags = 32, effects = { { effectType = 5, effectValue = 108, effectArg = 6 }, { effectType = 3, effectValue = 0, effectArg = 44797 } } }, -- +$k1 Spirit and 3% Increased Critical Effect
    [4053] = { name = "+$k1 Critical Strike and $11818s1% Spell Reflect", flags = 32, effects = { { effectType = 5, effectValue = 108, effectArg = 32 }, { effectType = 3, effectValue = 0, effectArg = 11818 } } }, -- +$k1 Critical Strike and $11818s1% Spell Reflect
    [4054] = { name = "+$k1 Stamina and Stun Duration Reduced by 10%", flags = 32, effects = { { effectType = 5, effectValue = 81, effectArg = 7 }, { effectType = 3, effectValue = 0, effectArg = 55358 } } }, -- +$k1 Stamina and Stun Duration Reduced by 10%
    [4055] = { name = "+$k1 Critical Strike and Reduces Snare/Root Duration by $55378s1%", flags = 32, effects = { { effectType = 5, effectValue = 108, effectArg = 32 }, { effectType = 3, effectValue = 0, effectArg = 55378 } } }, -- +$k1 Critical Strike and Reduces Snare/Root Duration by $55378s1%
    [4056] = { name = "+$k1 Critical Strike and Fear Duration Reduced by $55357s1%", flags = 32, effects = { { effectType = 5, effectValue = 108, effectArg = 32 }, { effectType = 3, effectValue = 0, effectArg = 55357 } } }, -- +$k1 Critical Strike and Fear Duration Reduced by $55357s1%
    [4057] = { name = "+$k1 Intellect and Silence Duration Reduced by 10%", flags = 32, effects = { { effectType = 5, effectValue = 54, effectArg = 5 }, { effectType = 3, effectValue = 0, effectArg = 55366 } } }, -- +$k1 Intellect and Silence Duration Reduced by 10%
    [4062] = { name = "+$k1 Stamina and Minor Movement Speed", flags = 32, effects = { { effectType = 5, effectValue = 30, effectArg = 7 }, { effectType = 3, effectValue = 0, effectArg = 24090 } } }, -- +$k1 Stamina and Minor Movement Speed
    [4063] = { name = "+$74190s1 All Stats", effects = { { effectType = 3, effectValue = 0, effectArg = 74190 } } }, -- +$74190s1 All Stats
    [4066] = { name = "Mending", effects = { { effectType = 1, effectValue = 0, effectArg = 74194 }, { effectType = 3, effectValue = 0, effectArg = 95709 } } }, -- Mending
    [4067] = { name = "Avalanche", effects = { { effectType = 1, effectValue = 0, effectArg = 74196 }, { effectType = 3, effectValue = 0, effectArg = 95472 } } }, -- Avalanche
    [4074] = { name = "Elemental Slayer", effects = { { effectType = 1, effectValue = 0, effectArg = 74208 } } }, -- Elemental Slayer
    [4083] = { name = "Hurricane", effects = { { effectType = 1, effectValue = 0, effectArg = 74221 }, { effectType = 3, effectValue = 0, effectArg = 94747 } } }, -- Hurricane
    [4084] = { name = "Heartsong", effects = { { effectType = 3, effectValue = 0, effectArg = 95653 } } }, -- Heartsong
    [4097] = { name = "Power Torrent", effects = { { effectType = 3, effectValue = 0, effectArg = 94746 } } }, -- Power Torrent
    [4098] = { name = "Windwalk", effects = { { effectType = 1, effectValue = 0, effectArg = 74243 } } }, -- Windwalk
    [4099] = { name = "Landslide", effects = { { effectType = 1, effectValue = 0, effectArg = 74245 } } }, -- Landslide
    [4102] = { name = "+$74249s1 All Stats", effects = { { effectType = 3, effectValue = 0, effectArg = 74249 } } }, -- +$74249s1 All Stats
    [4104] = { name = "+$k1 Mastery and Minor Movement Speed", flags = 32, effects = { { effectType = 5, effectValue = 35, effectArg = 49 }, { effectType = 3, effectValue = 0, effectArg = 24090 } } }, -- +$k1 Mastery and Minor Movement Speed
    [4105] = { name = "+$k1 Agility and Minor Movement Speed", flags = 32, effects = { { effectType = 5, effectValue = 25, effectArg = 3 }, { effectType = 3, effectValue = 0, effectArg = 24090 } } }, -- +$k1 Agility and Minor Movement Speed
    [4115] = { name = "Lightweave Embroidery", flags = 1, effects = { { effectType = 3, effectValue = 0, effectArg = 75171 } } }, -- Lightweave Embroidery
    [4117] = { name = "Swordguard Embroidery", flags = 1, effects = { { effectType = 3, effectValue = 0, effectArg = 55776 } } }, -- Swordguard Embroidery
    [4118] = { name = "Swordguard Embroidery", flags = 1, effects = { { effectType = 3, effectValue = 0, effectArg = 75177 } } }, -- Swordguard Embroidery
    [4179] = { name = "Synapse Springs", flags = 1, effects = { { effectType = 7, effectValue = 0, effectArg = 82174 }, { effectType = 3, effectValue = 1, effectArg = 1250229 } } }, -- Synapse Springs
    [4215] = { name = "Elementium Spike (90-133)", flags = 1, effects = { { effectType = 3, effectValue = 0, effectArg = 92432 } } }, -- Elementium Spike (90-133)
    [4216] = { name = "Pyrium Spike (210-350)", flags = 1, effects = { { effectType = 3, effectValue = 0, effectArg = 92436 } } }, -- Pyrium Spike (210-350)
    [4217] = { name = "Pyrium Weapon Chain", flags = 33, effects = { { effectType = 3, effectValue = 0, effectArg = 43588 }, { effectType = 5, effectValue = 40, effectArg = 31 } } }, -- Pyrium Weapon Chain
    [4225] = { name = "Fishing Lure (+$95243s1 Fishing Skill)", effects = { { effectType = 3, effectValue = 0, effectArg = 95243 } } }, -- Fishing Lure (+$95243s1 Fishing Skill)
    [4251] = { name = "+$k1 Agility and $44797s1% Increased Critical Effect", flags = 32, effects = { { effectType = 5, effectValue = 54, effectArg = 3 }, { effectType = 3, effectValue = 0, effectArg = 44797 } } }, -- +$k1 Agility and $44797s1% Increased Critical Effect
    [4252] = { name = "+$k1 Strength and 3% Increased Critical Effect", flags = 32, effects = { { effectType = 5, effectValue = 54, effectArg = 4 }, { effectType = 3, effectValue = 0, effectArg = 44797 } } }, -- +$k1 Strength and 3% Increased Critical Effect
    [4253] = { name = "+$k1 Intellect and 3% Increased Critical Effect", flags = 32, effects = { { effectType = 5, effectValue = 54, effectArg = 5 }, { effectType = 3, effectValue = 0, effectArg = 44797 } } }, -- +$k1 Intellect and 3% Increased Critical Effect
    [4259] = { name = "+$96285s1 Fishing", effects = { { effectType = 3, effectValue = 0, effectArg = 96285 } } }, -- +$96285s1 Fishing
    [4264] = { name = "Fishing Lure (+$7825s1 Fishing Skill)", effects = { { effectType = 3, effectValue = 0, effectArg = 7825 } } }, -- Fishing Lure (+$7825s1 Fishing Skill)
    [4267] = { name = "Flintlocke's Woodchucker", flags = 1, effects = { { effectType = 3, effectValue = 0, effectArg = 99622 } } }, -- Flintlocke's Woodchucker
    [4419] = { name = "+$k1 All Stats", flags = 32, effects = { { effectType = 3, effectValue = 80, effectArg = 104335 } } }, -- +$k1 All Stats
    [4428] = { name = "+$k1 Agility & Minor Speed Increase", flags = 32, effects = { { effectType = 5, effectValue = 140, effectArg = 3 }, { effectType = 3, effectValue = 0, effectArg = 24090 } } }, -- +$k1 Agility & Minor Speed Increase
    [4429] = { name = "+$k1 Mastery & Minor Speed Increase", flags = 32, effects = { { effectType = 5, effectValue = 140, effectArg = 49 }, { effectType = 3, effectValue = 0, effectArg = 24090 } } }, -- +$k1 Mastery & Minor Speed Increase
    [4441] = { name = "Windsong", effects = { { effectType = 3, effectValue = 0, effectArg = 104561 } } }, -- Windsong
    [4442] = { name = "Jade Spirit", effects = { { effectType = 3, effectValue = 0, effectArg = 120033 } } }, -- Jade Spirit
    [4443] = { name = "Elemental Force", effects = { { effectType = 3, effectValue = 0, effectArg = 104428 } } }, -- Elemental Force
    [4444] = { name = "Dancing Steel", effects = { { effectType = 3, effectValue = 0, effectArg = 118333 } } }, -- Dancing Steel
    [4445] = { name = "Colossus", effects = { { effectType = 3, effectValue = 0, effectArg = 118314 } } }, -- Colossus
    [4446] = { name = "River's Song", effects = { { effectType = 3, effectValue = 0, effectArg = 104441 } } }, -- River's Song
    [4655] = { name = "+$k1 Intellect and +$55275s1% Maximum Mana", flags = 32, effects = { { effectType = 5, effectValue = 216, effectArg = 5 }, { effectType = 3, effectValue = 0, effectArg = 55275 } } }, -- +$k1 Intellect and +$55275s1% Maximum Mana
    [4656] = { name = "+$k1 Agility and $44797s1% Increased Critical Effect", flags = 32, effects = { { effectType = 5, effectValue = 216, effectArg = 3 }, { effectType = 3, effectValue = 0, effectArg = 44797 } } }, -- +$k1 Agility and $44797s1% Increased Critical Effect
    [4657] = { name = "+$k1 Strength and $44797s1% Increased Critical Effect", flags = 32, effects = { { effectType = 5, effectValue = 216, effectArg = 4 }, { effectType = 3, effectValue = 0, effectArg = 44797 } } }, -- +$k1 Strength and $44797s1% Increased Critical Effect
    [4658] = { name = "+$k1 Intellect and $44797s1% Increased Critical Effect", flags = 32, effects = { { effectType = 5, effectValue = 216, effectArg = 5 }, { effectType = 3, effectValue = 0, effectArg = 44797 } } }, -- +$k1 Intellect and $44797s1% Increased Critical Effect
    [4659] = { name = "+$k1 Mastery and Minor Run Speed Increase", flags = 32, effects = { { effectType = 5, effectValue = 432, effectArg = 49 }, { effectType = 3, effectValue = 0, effectArg = 23990 } } }, -- +$k1 Mastery and Minor Run Speed Increase
    [4660] = { name = "+$k1 Spirit and 3% Increased Critical Effect", flags = 32, effects = { { effectType = 5, effectValue = 432, effectArg = 6 }, { effectType = 3, effectValue = 0, effectArg = 44797 } } }, -- +$k1 Spirit and 3% Increased Critical Effect
    [4661] = { name = "+$k1 Critical Strike and $11818s1% Spell Reflect", flags = 32, effects = { { effectType = 5, effectValue = 432, effectArg = 32 }, { effectType = 3, effectValue = 0, effectArg = 11818 } } }, -- +$k1 Critical Strike and $11818s1% Spell Reflect
    [4662] = { name = "+$k1 Stamina and Stun Duration Reduced by $55358s1%", flags = 32, effects = { { effectType = 5, effectValue = 324, effectArg = 7 }, { effectType = 3, effectValue = 0, effectArg = 55358 } } }, -- +$k1 Stamina and Stun Duration Reduced by $55358s1%
    [4664] = { name = "+$k1 Critical Strike and Reduces Snare/Root Duration by $55378s1%", flags = 32, effects = { { effectType = 5, effectValue = 432, effectArg = 32 }, { effectType = 3, effectValue = 0, effectArg = 55378 } } }, -- +$k1 Critical Strike and Reduces Snare/Root Duration by $55378s1%
    [4665] = { name = "+$k1 Critical Strike and Fear Duration Reduced by $55357s1%", flags = 32, effects = { { effectType = 5, effectValue = 432, effectArg = 32 }, { effectType = 3, effectValue = 0, effectArg = 55357 } } }, -- +$k1 Critical Strike and Fear Duration Reduced by $55357s1%
    [4666] = { name = "+$k1 Intellect and Silence Duration Reduced by $55366s1%", flags = 32, effects = { { effectType = 5, effectValue = 216, effectArg = 5 }, { effectType = 3, effectValue = 0, effectArg = 55366 } } }, -- +$k1 Intellect and Silence Duration Reduced by $55366s1%
    [4667] = { name = "+$k1 Stamina and $55344s1% Increased Armor Value from Items", flags = 32, effects = { { effectType = 5, effectValue = 324, effectArg = 7 }, { effectType = 3, effectValue = 0, effectArg = 55344 } } }, -- +$k1 Stamina and $55344s1% Increased Armor Value from Items
    [4668] = { name = "+$k1 Dodge and +$55283s1% Shield Block Value", flags = 32, effects = { { effectType = 5, effectValue = 432, effectArg = 13 }, { effectType = 3, effectValue = 0, effectArg = 55283 } } }, -- +$k1 Dodge and +$55283s1% Shield Block Value
    [4669] = { name = "+$k1 Stamina and Reduce Spell Damage Taken by $55345s1%", flags = 32, effects = { { effectType = 5, effectValue = 324, effectArg = 7 }, { effectType = 3, effectValue = 0, effectArg = 55345 } } }, -- +$k1 Stamina and Reduce Spell Damage Taken by $55345s1%
    [4671] = { name = "+$k1 Strength +$k2 Parry +$13839s1 Critical Strike", effects = { { effectType = 1, effectValue = 10, effectArg = 74221 }, { effectType = 5, effectValue = 5, effectArg = 14 }, { effectType = 5, effectValue = 16, effectArg = 32 } } }, -- +$k1 Strength +$k2 Parry +$13839s1 Critical Strike
    [4687] = { name = "+$k2 Agility", effects = { { effectType = 1, effectValue = 0, effectArg = 74221 }, { effectType = 5, effectValue = 160, effectArg = 3 } } }, -- +$k2 Agility
    [4688] = { name = "Samurai", effects = { { effectType = 1, effectValue = 0, effectArg = 74221 } } }, -- Samurai
    [4699] = { name = "Lord Blastington's Scope of Doom", flags = 1, effects = { { effectType = 1, effectValue = 0, effectArg = 109085 } } }, -- Lord Blastington's Scope of Doom
    [4700] = { name = "Mirror Scope", flags = 1, effects = { { effectType = 1, effectValue = 0, effectArg = 109092 } } }, -- Mirror Scope
    [4717] = { name = "Pandamonium", flags = 1, effects = { { effectType = 1, effectValue = 0, effectArg = 110761 } } }, -- Pandamonium
    [4732] = { name = "+$71691s1 Fishing", effects = { { effectType = 3, effectValue = 0, effectArg = 71691 } } }, -- +$71691s1 Fishing
    [4753] = { name = "+$13624s1 All Stats", effects = { { effectType = 3, effectValue = 0, effectArg = 13624 } } }, -- +$13624s1 All Stats
    [4755] = { name = "+$13824s1 All Stats", effects = { { effectType = 3, effectValue = 0, effectArg = 13824 } } }, -- +$13824s1 All Stats
    [4757] = { name = "+$114519s1 All Stats", effects = { { effectType = 3, effectValue = 0, effectArg = 114519 } } }, -- +$114519s1 All Stats
    [4759] = { name = "+$114520s1 All Stats", effects = { { effectType = 3, effectValue = 0, effectArg = 114520 } } }, -- +$114520s1 All Stats
    [4760] = { name = "+$114524s1 All Stats", effects = { { effectType = 3, effectValue = 0, effectArg = 114524 } } }, -- +$114524s1 All Stats
    [4761] = { name = "+$13824s1 All Stats", effects = { { effectType = 3, effectValue = 0, effectArg = 13824 } } }, -- +$13824s1 All Stats
    [4762] = { name = "+$114519s1 All Stats", effects = { { effectType = 3, effectValue = 0, effectArg = 114519 } } }, -- +$114519s1 All Stats
    [4808] = { name = "Magic Weapon", flags = 1, effects = { { effectType = 3, effectValue = 0, effectArg = 121992 } } }, -- Magic Weapon
    [4891] = { name = "Pandaren Fishing Lure", flags = 1, effects = { { effectType = 3, effectValue = 0, effectArg = 125167 } } }, -- Pandaren Fishing Lure
    [4892] = { name = "Lightweave Embroidery", flags = 1, effects = { { effectType = 3, effectValue = 0, effectArg = 125484 } } }, -- Lightweave Embroidery
    [4894] = { name = "Swordguard Embroidery", flags = 1, effects = { { effectType = 3, effectValue = 0, effectArg = 125486 } } }, -- Swordguard Embroidery
    [4898] = { name = "Synapse Springs", flags = 1, effects = { { effectType = 7, effectValue = 0, effectArg = 126734 }, { effectType = 3, effectValue = 1, effectArg = 1250229 } } }, -- Synapse Springs
    [4918] = { name = "Living Steel Weapon Chain", flags = 33, effects = { { effectType = 3, effectValue = 0, effectArg = 43588 }, { effectType = 5, effectValue = 200, effectArg = 37 } } }, -- Living Steel Weapon Chain
    [4919] = { name = "Fishing Lure (+$128586s1 Fishing Skill)", effects = { { effectType = 3, effectValue = 0, effectArg = 128586 } } }, -- Fishing Lure (+$128586s1 Fishing Skill)
    [4996] = { name = "+$k1 Agility", flags = 32, effects = { { effectType = 3, effectValue = 500, effectArg = 132349 } } }, -- +$k1 Agility
    [4997] = { name = "+$k1 Strength", flags = 32, effects = { { effectType = 3, effectValue = 500, effectArg = 132348 } } }, -- +$k1 Strength
    [4998] = { name = "+$k1 Intellect", flags = 32, effects = { { effectType = 3, effectValue = 500, effectArg = 132346 } } }, -- +$k1 Intellect
    [5001] = { name = "Ghost Iron Spike (600-1000)", flags = 1, effects = { { effectType = 3, effectValue = 0, effectArg = 131465 } } }, -- Ghost Iron Spike (600-1000)
    [5011] = { name = "+$k1 Agility", flags = 32, effects = { { effectType = 3, effectValue = 550, effectArg = 136003 } } }, -- +$k1 Agility
    [5012] = { name = "+$k1 Intellect", flags = 32, effects = { { effectType = 3, effectValue = 550, effectArg = 136002 } } }, -- +$k1 Intellect
    [5013] = { name = "+$k1 Strength", flags = 32, effects = { { effectType = 3, effectValue = 550, effectArg = 136004 } } }, -- +$k1 Strength
    [5030] = { name = "+$k1 Stamina and chance on being hit to gain $137593s1% reduction to damage taken", flags = 33, effects = { { effectType = 5, effectValue = 324, effectArg = 7 }, { effectType = 3, effectValue = 0, effectArg = 137594 } } }, -- +$k1 Stamina and chance on being hit to gain $137593s1% reduction to damage taken
    [5031] = { name = "+$k1 Intellect and chance on beneficial spell to make your spells cost no mana for 4 sec.", flags = 33, effects = { { effectType = 5, effectValue = 324, effectArg = 5 }, { effectType = 3, effectValue = 0, effectArg = 137248 } } }, -- +$k1 Intellect and chance on beneficial spell to make your spells cost no mana for 4 sec.
    [5032] = { name = "+$k1 Crit, and chance on melee or ranged hit to gain Capacitance", flags = 33, effects = { { effectType = 5, effectValue = 324, effectArg = 32 }, { effectType = 3, effectValue = 0, effectArg = 137595 } } }, -- +$k1 Crit, and chance on melee or ranged hit to gain Capacitance
    [5033] = { name = "+$k1 Crit, and chance on spell damage to gain $137590s1% spell haste", flags = 33, effects = { { effectType = 5, effectValue = 324, effectArg = 32 }, { effectType = 3, effectValue = 0, effectArg = 137592 } } }, -- +$k1 Crit, and chance on spell damage to gain $137590s1% spell haste
    [5035] = { name = "+$k1 PvP Power, Disarm Duration Reduction", flags = 33, effects = { { effectType = 5, effectValue = 600, effectArg = 57 }, { effectType = 3, effectValue = 0, effectArg = 43588 } } }, -- +$k1 PvP Power, Disarm Duration Reduction
    [5047] = { name = "+$k1 Spirit and 3% Increased Critical Effect", effects = { { effectType = 5, effectValue = 30, effectArg = 6 }, { effectType = 3, effectValue = 0, effectArg = 44797 } } }, -- +$k1 Spirit and 3% Increased Critical Effect
    [5050] = { name = "+$k1 Intellect", effects = { { effectType = 3, effectValue = 34, effectArg = 141181 } } }, -- +$k1 Intellect
    [5060] = { name = "+$k1 Mastery & Minor Speed Increase", effects = { { effectType = 5, effectValue = 10, effectArg = 49 }, { effectType = 3, effectValue = 0, effectArg = 24090 } } }, -- +$k1 Mastery & Minor Speed Increase
    [5062] = { name = "Jade Spirit", effects = { { effectType = 3, effectValue = 0, effectArg = 141178 } } }, -- Jade Spirit
    [5070] = { name = "+$k1 Intellect and $44797s1% Increased Critical Effect", effects = { { effectType = 5, effectValue = 15, effectArg = 5 }, { effectType = 3, effectValue = 0, effectArg = 44797 } } }, -- +$k1 Intellect and $44797s1% Increased Critical Effect
    [5085] = { name = "+$k1 Intellect and $44797s1% Increased Critical Effect", effects = { { effectType = 5, effectValue = 12, effectArg = 5 }, { effectType = 3, effectValue = 0, effectArg = 44797 } } }, -- +$k1 Intellect and $44797s1% Increased Critical Effect
    [5096] = { name = "+$k1 Mastery & Minor Speed Increase", effects = { { effectType = 5, effectValue = 6, effectArg = 49 }, { effectType = 3, effectValue = 0, effectArg = 24090 } } }, -- +$k1 Mastery & Minor Speed Increase
    [5098] = { name = "Jade Spirit", effects = { { effectType = 3, effectValue = 0, effectArg = 141980 } } }, -- Jade Spirit
    [5110] = { name = "Lightweave Embroidery", flags = 1, effects = { { effectType = 3, effectValue = 0, effectArg = 142172 } } }, -- Lightweave Embroidery
    [5111] = { name = "+$k1 All Stats", effects = { { effectType = 3, effectValue = 3, effectArg = 104335 } } }, -- +$k1 All Stats
    [5115] = { name = "+$k1 Intellect", effects = { { effectType = 3, effectValue = 20, effectArg = 132346 } } }, -- +$k1 Intellect
    [5124] = { name = "Spirit of Conquest", flags = 1, effects = { { effectType = 3, effectValue = 0, effectArg = 142536 } } }, -- Spirit of Conquest
    [5125] = { name = "Bloody Dancing Steel", flags = 1, effects = { { effectType = 3, effectValue = 0, effectArg = 142531 } } }, -- Bloody Dancing Steel
    [8550] = { name = "+$k1 PvP Power, Disarm Duration Reduction", flags = 32, effects = { { effectType = 5, effectValue = 600, effectArg = 57 }, { effectType = 3, effectValue = 0, effectArg = 43588 } } }, -- +$k1 PvP Power, Disarm Duration Reduction

}

-- ============================ OTHER ITEMS ============================
--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
    https://creativecommons.org/licenses/by-nc/4.0/

    Author: Rakizi
    Date: 2024

    Mists of Pandaria item data
]]
ns.data.mists.Items.OtherItems = ns.data.mists.Items.OtherItems or {}
ns.data.mists.Items.OtherItems = {
    -- Trinkets
    Trinket = {
    },
    -- Consumables (MoP only - item ID >= 80000)
    Consumable = { 36799 },
    -- Weapons
    Weapon = {},

    -- Engineering items (Mists specific)
    Engineering = {
        -- Tinkers (MoP spell IDs >= 100000)
        tinker = {
            Spells = { 126734 },
        },
        -- Gadgets
        gadget = {
        },
    },
}

-- ============================ TIER SETS ============================
-- Generated by NextActionGuide Data Generator
-- Product: Classic
-- Build: 5.5.3.64857
-- Generated: 2025-12-10 03:59:06
ns.data.mists.TierSets = {
    [580] = {
        name = "Gladiator's Thunderfist",
        bonuses = {            [2] = { spellId = 40042 },            [4] = { spellId = 100956 },        }
    },
    [1087] = {
        name = "Fangs of the Father",
        bonuses = {            [2] = { spellId = 109939 },        }
    },
    [1088] = {
        name = "Maw of Oblivion",
        bonuses = {            [2] = { spellId = 109956 },        }
    },
    [1089] = {
        name = "Jaws of Retribution",
        bonuses = {            [2] = { spellId = 109960 },        }
    },
    [1121] = {
        name = "Contender's Defense",
        bonuses = {            [2] = { spellId = 128411 },            [4] = { spellId = 128410 },        }
    },
    [1123] = {
        name = "Battlegear of the Lost Catacomb",
        tier = "14",
        bonuses = {            [2] = { spellId = 123077 },            [4] = { spellId = 123078 },        }
    },
    [1124] = {
        name = "Plate of the Lost Catacomb",
        tier = "14",
        bonuses = {            [2] = { spellId = 123079 },            [4] = { spellId = 123080 },        }
    },
    [1125] = {
        name = "Vestments of the Eternal Blossom",
        tier = "14",
        bonuses = {            [2] = { spellId = 123088 },            [4] = { spellId = 123089 },        }
    },
    [1126] = {
        name = "Regalia of the Eternal Blossom",
        tier = "14",
        bonuses = {            [2] = { spellId = 123082 },            [4] = { spellId = 123083 },        }
    },
    [1127] = {
        name = "Battlegear of the Eternal Blossom",
        tier = "14",
        bonuses = {            [2] = { spellId = 123084 },            [4] = { spellId = 123085 },        }
    },
    [1128] = {
        name = "Armor of the Eternal Blossom",
        tier = "14",
        bonuses = {            [2] = { spellId = 123086 },            [4] = { spellId = 123087 },        }
    },
    [1129] = {
        name = "Yaungol Slayer Battlegear",
        tier = "14",
        bonuses = {            [2] = { spellId = 123090 },            [4] = { spellId = 123091 },        }
    },
    [1130] = {
        name = "Regalia of the Burning Scroll",
        tier = "14",
        bonuses = {            [2] = { spellId = 123097 },            [4] = { spellId = 123101 },        }
    },
    [1131] = {
        name = "Vestments of the Red Crane",
        tier = "14",
        bonuses = {            [2] = { spellId = 123152 },            [4] = { spellId = 123153 },        }
    },
    [1132] = {
        name = "Battlegear of the Red Crane",
        tier = "14",
        bonuses = {            [2] = { spellId = 123149 },            [4] = { spellId = 123150 },        }
    },
    [1133] = {
        name = "Armor of the Red Crane",
        tier = "14",
        bonuses = {            [2] = { spellId = 123157 },            [4] = { spellId = 123159 },        }
    },
    [1134] = {
        name = "White Tiger Vestments",
        tier = "14",
        bonuses = {            [2] = { spellId = 123102 },            [4] = { spellId = 123103 },        }
    },
    [1135] = {
        name = "White Tiger Battlegear",
        tier = "14",
        bonuses = {            [2] = { spellId = 123108 },            [4] = { spellId = 70762 },        }
    },
    [1136] = {
        name = "White Tiger Plate",
        tier = "14",
        bonuses = {            [2] = { spellId = 123104 },            [4] = { spellId = 123107 },        }
    },
    [1137] = {
        name = "Vestments of the Guardian Serpent",
        tier = "14",
        bonuses = {            [2] = { spellId = 123111 },            [4] = { spellId = 123113 },        }
    },
    [1138] = {
        name = "Regalia of the Guardian Serpent",
        tier = "14",
        bonuses = {            [2] = { spellId = 123114 },            [4] = { spellId = 123115 },        }
    },
    [1139] = {
        name = "Battlegear of the Thousandfold Blades",
        tier = "14",
        bonuses = {            [2] = { spellId = 123116 },            [4] = { spellId = 123122 },        }
    },
    [1140] = {
        name = "Vestments of the Firebird",
        tier = "14",
        bonuses = {            [2] = { spellId = 123134 },            [4] = { spellId = 123135 },        }
    },
    [1141] = {
        name = "Regalia of the Firebird",
        tier = "14",
        bonuses = {            [2] = { spellId = 123123 },            [4] = { spellId = 123124 },        }
    },
    [1142] = {
        name = "Battlegear of the Firebird",
        tier = "14",
        bonuses = {            [2] = { spellId = 123132 },            [4] = { spellId = 123133 },        }
    },
    [1143] = {
        name = "Sha-Skin Regalia",
        tier = "14",
        bonuses = {            [2] = { spellId = 123136 },            [4] = { spellId = 123141 },        }
    },
    [1144] = {
        name = "Battleplate of Resounding Rings",
        tier = "14",
        bonuses = {            [2] = { spellId = 123142 },            [4] = { spellId = 123144 },        }
    },
    [1145] = {
        name = "Plate of Resounding Rings",
        tier = "14",
        bonuses = {            [2] = { spellId = 123146 },            [4] = { spellId = 123147 },        }
    },
    [1147] = {
        name = "Tradition of Cooking",
        bonuses = {            [3] = { spellId = 130704 },        }
    },
    [1151] = {
        name = "Plate of the All-Consuming Maw",
        tier = "15",
        bonuses = {            [2] = { spellId = 138195 },            [4] = { spellId = 138197 },        }
    },
    [1152] = {
        name = "Battleplate of the All-Consuming Maw",
        tier = "15",
        bonuses = {            [2] = { spellId = 138343 },            [4] = { spellId = 138347 },        }
    },
    [1153] = {
        name = "Battlegear of the Haunted Forest",
        tier = "15",
        bonuses = {            [2] = { spellId = 138352 },            [4] = { spellId = 138357 },        }
    },
    [1154] = {
        name = "Vestments of the Haunted Forest",
        tier = "15",
        bonuses = {            [2] = { spellId = 138284 },            [4] = { spellId = 138286 },        }
    },
    [1155] = {
        name = "Regalia of the Haunted Forest",
        tier = "15",
        bonuses = {            [2] = { spellId = 138348 },            [4] = { spellId = 138350 },        }
    },
    [1156] = {
        name = "Armor of the Haunted Forest",
        tier = "15",
        bonuses = {            [2] = { spellId = 138216 },            [4] = { spellId = 138222 },        }
    },
    [1157] = {
        name = "Battlegear of the Saurok Stalker",
        tier = "15",
        bonuses = {            [2] = { spellId = 138365 },            [4] = { spellId = 138367 },        }
    },
    [1158] = {
        name = "Regalia of the Chromatic Hydra",
        tier = "15",
        bonuses = {            [2] = { spellId = 138316 },            [4] = { spellId = 138376 },        }
    },
    [1159] = {
        name = "Fire-Charm Battlegear",
        tier = "15",
        bonuses = {            [2] = { spellId = 138177 },            [4] = { spellId = 138315 },        }
    },
    [1160] = {
        name = "Fire-Charm Vestments",
        tier = "15",
        bonuses = {            [2] = { spellId = 138290 },            [4] = { spellId = 138289 },        }
    },
    [1161] = {
        name = "Fire-Charm Armor",
        tier = "15",
        bonuses = {            [2] = { spellId = 138231 },            [4] = { spellId = 138236 },        }
    },
    [1162] = {
        name = "Battlegear of the Lightning Emperor",
        tier = "15",
        bonuses = {            [2] = { spellId = 138159 },            [4] = { spellId = 138164 },        }
    },
    [1163] = {
        name = "Vestments of the Lightning Emperor",
        tier = "15",
        bonuses = {            [2] = { spellId = 138291 },            [4] = { spellId = 138292 },        }
    },
    [1164] = {
        name = "Plate of the Lightning Emperor",
        tier = "15",
        bonuses = {            [2] = { spellId = 138238 },            [4] = { spellId = 138244 },        }
    },
    [1165] = {
        name = "Vestments of the Exorcist",
        tier = "15",
        bonuses = {            [2] = { spellId = 138293 },            [4] = { spellId = 138301 },        }
    },
    [1166] = {
        name = "Regalia of the Exorcist",
        tier = "15",
        bonuses = {            [2] = { spellId = 138156 },            [4] = { spellId = 138158 },        }
    },
    [1167] = {
        name = "Nine-Tail Battlegear",
        tier = "15",
        bonuses = {            [2] = { spellId = 138148 },            [4] = { spellId = 138150 },        }
    },
    [1168] = {
        name = "Vestments of the Witch Doctor",
        tier = "15",
        bonuses = {            [2] = { spellId = 138303 },            [4] = { spellId = 138305 },        }
    },
    [1169] = {
        name = "Battlegear of the Witch Doctor",
        tier = "15",
        bonuses = {            [2] = { spellId = 138136 },            [4] = { spellId = 138141 },        }
    },
    [1170] = {
        name = "Regalia of the Witch Doctor",
        tier = "15",
        bonuses = {            [2] = { spellId = 138145 },            [4] = { spellId = 138144 },        }
    },
    [1171] = {
        name = "Regalia of the Thousandfold Hells",
        tier = "15",
        bonuses = {            [2] = { spellId = 138129 },            [4] = { spellId = 138134 },        }
    },
    [1172] = {
        name = "Battleplate of the Last Mogu",
        tier = "15",
        bonuses = {            [2] = { spellId = 138120 },            [4] = { spellId = 138126 },        }
    },
    [1173] = {
        name = "Plate of the Last Mogu",
        tier = "15",
        bonuses = {            [2] = { spellId = 138280 },            [4] = { spellId = 138281 },        }
    },
    [1179] = {
        name = "Plate of the Prehistoric Marauder",
        tier = "16",
        bonuses = {            [2] = { spellId = 144503 },            [4] = { spellId = 144502 },        }
    },
    [1180] = {
        name = "Battleplate of the Prehistoric Marauder",
        tier = "16",
        bonuses = {            [2] = { spellId = 144436 },            [4] = { spellId = 144441 },        }
    },
    [1181] = {
        name = "Regalia of the Horned Nightmare",
        tier = "16",
        bonuses = {            [2] = { spellId = 145072 },            [4] = { spellId = 145091 },        }
    },
    [1182] = {
        name = "Celestial Harmony Regalia",
        tier = "16",
        bonuses = {            [2] = { spellId = 144998 },            [4] = { spellId = 145003 },        }
    },
    [1183] = {
        name = "Celestial Harmony Battlegear",
        tier = "16",
        bonuses = {            [2] = { spellId = 144962 },            [4] = { spellId = 144966 },        }
    },
    [1184] = {
        name = "Celestial Harmony Vestment",
        tier = "16",
        bonuses = {            [2] = { spellId = 145378 },            [4] = { spellId = 145380 },        }
    },
    [1185] = {
        name = "Barbed Assassin Battlegear",
        tier = "16",
        bonuses = {            [2] = { spellId = 145185 },            [4] = { spellId = 145210 },        }
    },
    [1186] = {
        name = "Regalia of Ternion Glory",
        tier = "16",
        bonuses = {            [2] = { spellId = 145174 },            [4] = { spellId = 145179 },        }
    },
    [1187] = {
        name = "Vestments of Ternion Glory",
        tier = "16",
        bonuses = {            [2] = { spellId = 145306 },            [4] = { spellId = 145334 },        }
    },
    [1188] = {
        name = "Plate of Winged Triumph",
        tier = "16",
        bonuses = {            [2] = { spellId = 144580 },            [4] = { spellId = 144566 },        }
    },
    [1189] = {
        name = "Vestments of Winged Triumph",
        tier = "16",
        bonuses = {            [2] = { spellId = 144625 },            [4] = { spellId = 144613 },        }
    },
    [1190] = {
        name = "Battlegear of Winged Triumph",
        tier = "16",
        bonuses = {            [2] = { spellId = 144586 },            [4] = { spellId = 144593 },        }
    },
    [1191] = {
        name = "Armor of Seven Sacred Seals",
        tier = "16",
        bonuses = {            [2] = { spellId = 145049 },            [4] = { spellId = 145055 },        }
    },
    [1192] = {
        name = "Vestments of Seven Sacred Seals",
        tier = "16",
        bonuses = {            [2] = { spellId = 145439 },            [4] = { spellId = 145449 },        }
    },
    [1193] = {
        name = "Battlegear of Seven Sacred Seals",
        tier = "16",
        bonuses = {            [2] = { spellId = 145004 },            [4] = { spellId = 145022 },        }
    },
    [1194] = {
        name = "Chronomancer Regalia",
        tier = "16",
        bonuses = {            [2] = { spellId = 145251 },            [4] = { spellId = 145257 },        }
    },
    [1195] = {
        name = "Battlegear of the Unblinking Vigil",
        tier = "16",
        bonuses = {            [2] = { spellId = 144637 },            [4] = { spellId = 144641 },        }
    },
    [1196] = {
        name = "Armor of the Shattered Vale",
        tier = "16",
        bonuses = {            [2] = { spellId = 144879 },            [4] = { spellId = 144887 },        }
    },
    [1197] = {
        name = "Regalia of the Shattered Vale",
        tier = "16",
        bonuses = {            [2] = { spellId = 144767 },            [4] = { spellId = 144756 },        }
    },
    [1198] = {
        name = "Vestments of the Shattered Vale",
        tier = "16",
        bonuses = {            [2] = { spellId = 144869 },            [4] = { spellId = 144875 },        }
    },
    [1199] = {
        name = "Battlegear of the Shattered Vale",
        tier = "16",
        bonuses = {            [2] = { spellId = 144864 },            [4] = { spellId = 144841 },        }
    },
    [1200] = {
        name = "Battleplate of Cyclopean Dread",
        tier = "16",
        bonuses = {            [2] = { spellId = 144899 },            [4] = { spellId = 144907 },        }
    },
    [1201] = {
        name = "Plate of Cyclopean Dread",
        tier = "16",
        bonuses = {            [2] = { spellId = 144934 },            [4] = { spellId = 144950 },        }
    },
    [1203] = {
        name = "Gladiator's Distinction",
        bonuses = {            [2] = { spellId = 146512 },        }
    },
}

-- ============================ TRINKETS ============================
-- Generated by NextActionGuide Data Generator
-- Product: Classic
-- Build: 5.5.3.64857
-- Generated: 2025-12-10 03:59:06
ns.data.mists.Trinkets = {
    [75274] = {
        itemId = 75274,
        itemLevel = 458,
        useEffects = {  },
        procEffects = {             { spellId = 105574, effect = 6, aura = 42, target = 1 },            { spellId = 17619, effect = 6, aura = 4, basePoints = 1, bonusCoeff = 1.0, target = 1 } }
    }, -- Zen Alchemist Stone
    [79327] = {
        itemId = 79327,
        itemLevel = 476,
        useEffects = {  },
        procEffects = {             { spellId = 128989, procId = 128986, effect = 6, aura = 42, target = 1 } }
    }, -- Relic of Xuen
    [79328] = {
        itemId = 79328,
        itemLevel = 476,
        useEffects = {  },
        procEffects = {             { spellId = 128445, procId = 128984, effect = 6, aura = 42, target = 1 } }
    }, -- Relic of Xuen
    [79329] = {
        itemId = 79329,
        itemLevel = 476,
        useEffects = {             { spellId = 128988, ICD = 60, effect = 6, aura = 189, basePoints = 8871, bonusCoeff = 1.0, miscValue = 4, target = 1 } },
        procEffects = {  }
    }, -- Relic of Niuzao
    [79330] = {
        itemId = 79330,
        itemLevel = 476,
        useEffects = {  },
        procEffects = {             { spellId = 128991, procId = 128987, effect = 6, aura = 42, target = 1 } }
    }, -- Relic of Chi-Ji
    [79331] = {
        itemId = 79331,
        itemLevel = 476,
        useEffects = {  },
        procEffects = {             { spellId = 128990, procId = 128985, effect = 6, aura = 42, target = 1 } }
    }, -- Relic of Yu'lon
    [81125] = {
        itemId = 81125,
        itemLevel = 463,
        useEffects = {  },
        procEffects = {             { spellId = 126482, procId = 126483, effect = 6, aura = 42, target = 1 } }
    }, -- Windswept Pages
    [81133] = {
        itemId = 81133,
        itemLevel = 463,
        useEffects = {  },
        procEffects = {             { spellId = 126268, procId = 126266, effect = 6, aura = 42, basePoints = 100, target = 1 } }
    }, -- Empty Fruit Barrel
    [81138] = {
        itemId = 81138,
        itemLevel = 463,
        useEffects = {  },
        procEffects = {             { spellId = 126516, procId = 126513, effect = 6, aura = 42, target = 1 } }
    }, -- Carbonic Carbuncle
    [81181] = {
        itemId = 81181,
        itemLevel = 463,
        useEffects = {             { spellId = 126260, ICD = 120, effect = 6, aura = 189, basePoints = 432, miscValue = 4, target = 1 } },
        procEffects = {  }
    }, -- Heart of Fire
    [81192] = {
        itemId = 81192,
        itemLevel = 463,
        useEffects = {  },
        procEffects = {             { spellId = 126473, procId = 126476, effect = 6, aura = 42, target = 1 } }
    }, -- Vision of the Predator
    [81243] = {
        itemId = 81243,
        itemLevel = 463,
        useEffects = {  },
        procEffects = {             { spellId = 126237, procId = 126236, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Iron Protector Talisman
    [81263] = {
        itemId = 81263,
        itemLevel = 463,
        useEffects = {             { spellId = 126478, ICD = 150, effect = 6, aura = 29, basePoints = 1149, miscValue = 3, target = 1 } },
        procEffects = {  }
    }, -- Flashfrozen Resin Globule
    [81264] = {
        itemId = 81264,
        itemLevel = 463,
        useEffects = {             { spellId = 126270, ICD = 120, effect = 6, aura = 29, basePoints = 1926, miscValue = 4, target = 1 } },
        procEffects = {  }
    }, -- Vial of Ichorous Blood
    [81265] = {
        itemId = 81265,
        itemLevel = 463,
        useEffects = {             { spellId = 126484, ICD = 90, effect = 6, aura = 29, basePoints = 1149, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Flashing Steel Talisman
    [81266] = {
        itemId = 81266,
        itemLevel = 463,
        useEffects = {  },
        procEffects = {             { spellId = 126468, procId = 126467, effect = 6, aura = 42, basePoints = 100, target = 1 } }
    }, -- Price of Progress
    [81267] = {
        itemId = 81267,
        itemLevel = 463,
        useEffects = {  },
        procEffects = {             { spellId = 126490, procId = 126489, effect = 6, aura = 42, target = 1 } }
    }, -- Searing Words
    [81268] = {
        itemId = 81268,
        itemLevel = 463,
        useEffects = {             { spellId = 126519, ICD = 120, effect = 6, aura = 29, basePoints = 1149, target = 1 } },
        procEffects = {  }
    }, -- Lessons of the Darkmaster
    [84344] = {
        itemId = 84344,
        itemLevel = 458,
        useEffects = {             { spellId = 126690, ICD = 60, effect = 6, aura = 29, basePoints = 2144, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Dreadful Gladiator's Badge of Conquest
    [84349] = {
        itemId = 84349,
        itemLevel = 458,
        useEffects = {  },
        procEffects = {             { spellId = 126708, procId = 126707, effect = 6, aura = 42, target = 1 } }
    }, -- Dreadful Gladiator's Insignia of Conquest
    [84399] = {
        itemId = 84399,
        itemLevel = 458,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Dreadful Gladiator's Emblem of Cruelty
    [84400] = {
        itemId = 84400,
        itemLevel = 458,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Dreadful Gladiator's Emblem of Tenacity
    [84401] = {
        itemId = 84401,
        itemLevel = 458,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Dreadful Gladiator's Emblem of Meditation
    [84450] = {
        itemId = 84450,
        itemLevel = 458,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Dreadful Gladiator's Medallion of Cruelty
    [84451] = {
        itemId = 84451,
        itemLevel = 458,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Dreadful Gladiator's Medallion of Cruelty
    [84452] = {
        itemId = 84452,
        itemLevel = 458,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Dreadful Gladiator's Medallion of Tenacity
    [84453] = {
        itemId = 84453,
        itemLevel = 458,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Dreadful Gladiator's Medallion of Tenacity
    [84454] = {
        itemId = 84454,
        itemLevel = 458,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Dreadful Gladiator's Medallion of Meditation
    [84455] = {
        itemId = 84455,
        itemLevel = 458,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Dreadful Gladiator's Medallion of Meditation
    [84488] = {
        itemId = 84488,
        itemLevel = 458,
        useEffects = {             { spellId = 126683, ICD = 60, effect = 6, aura = 29, basePoints = 2144, miscValue = 3, target = 1 } },
        procEffects = {  }
    }, -- Dreadful Gladiator's Badge of Dominance
    [84489] = {
        itemId = 84489,
        itemLevel = 458,
        useEffects = {  },
        procEffects = {             { spellId = 126706, procId = 126705, effect = 6, aura = 42, target = 1 } }
    }, -- Dreadful Gladiator's Insignia of Dominance
    [84490] = {
        itemId = 84490,
        itemLevel = 458,
        useEffects = {             { spellId = 126679, ICD = 60, effect = 6, aura = 29, basePoints = 2144, target = 1 } },
        procEffects = {  }
    }, -- Dreadful Gladiator's Badge of Victory
    [84495] = {
        itemId = 84495,
        itemLevel = 458,
        useEffects = {  },
        procEffects = {             { spellId = 126702, procId = 126700, effect = 6, aura = 42, target = 1 } }
    }, -- Dreadful Gladiator's Insignia of Victory
    [84931] = {
        itemId = 84931,
        itemLevel = 483,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Malevolent Gladiator's Medallion of Tenacity
    [84932] = {
        itemId = 84932,
        itemLevel = 483,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Malevolent Gladiator's Medallion of Meditation
    [84933] = {
        itemId = 84933,
        itemLevel = 483,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Malevolent Gladiator's Medallion of Meditation
    [84934] = {
        itemId = 84934,
        itemLevel = 483,
        useEffects = {             { spellId = 126690, ICD = 60, effect = 6, aura = 29, basePoints = 2144, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Malevolent Gladiator's Badge of Conquest
    [84935] = {
        itemId = 84935,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126708, procId = 126707, effect = 6, aura = 42, target = 1 } }
    }, -- Malevolent Gladiator's Insignia of Conquest
    [84936] = {
        itemId = 84936,
        itemLevel = 483,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Malevolent Gladiator's Emblem of Cruelty
    [84937] = {
        itemId = 84937,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126702, procId = 126700, effect = 6, aura = 42, target = 1 } }
    }, -- Malevolent Gladiator's Insignia of Victory
    [84938] = {
        itemId = 84938,
        itemLevel = 483,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Malevolent Gladiator's Emblem of Tenacity
    [84939] = {
        itemId = 84939,
        itemLevel = 483,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Malevolent Gladiator's Emblem of Meditation
    [84940] = {
        itemId = 84940,
        itemLevel = 483,
        useEffects = {             { spellId = 126683, ICD = 60, effect = 6, aura = 29, basePoints = 2144, miscValue = 3, target = 1 } },
        procEffects = {  }
    }, -- Malevolent Gladiator's Badge of Dominance
    [84941] = {
        itemId = 84941,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126706, procId = 126705, effect = 6, aura = 42, target = 1 } }
    }, -- Malevolent Gladiator's Insignia of Dominance
    [84942] = {
        itemId = 84942,
        itemLevel = 483,
        useEffects = {             { spellId = 126679, ICD = 60, effect = 6, aura = 29, basePoints = 2144, target = 1 } },
        procEffects = {  }
    }, -- Malevolent Gladiator's Badge of Victory
    [84943] = {
        itemId = 84943,
        itemLevel = 483,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Malevolent Gladiator's Medallion of Cruelty
    [84944] = {
        itemId = 84944,
        itemLevel = 483,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Malevolent Gladiator's Medallion of Cruelty
    [84945] = {
        itemId = 84945,
        itemLevel = 483,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Malevolent Gladiator's Medallion of Tenacity
    [86042] = {
        itemId = 86042,
        itemLevel = 489,
        useEffects = {             { spellId = 126599, ICD = 60, effect = 6, aura = 189, basePoints = 1149, miscValue = 917504, target = 1 } },
        procEffects = {  }
    }, -- Jade Charioteer Figurine
    [86043] = {
        itemId = 86043,
        itemLevel = 489,
        useEffects = {             { spellId = 126599, ICD = 60, effect = 6, aura = 189, basePoints = 1149, miscValue = 917504, target = 1 } },
        procEffects = {  }
    }, -- Jade Bandit Figurine
    [86044] = {
        itemId = 86044,
        itemLevel = 489,
        useEffects = {             { spellId = 126605, ICD = 60, effect = 6, aura = 189, basePoints = 1149, miscValue = 1792, target = 1 } },
        procEffects = {  }
    }, -- Jade Magistrate Figurine
    [86045] = {
        itemId = 86045,
        itemLevel = 489,
        useEffects = {             { spellId = 126606, ICD = 60, effect = 6, aura = 29, basePoints = 1149, miscValue = 4, target = 1 } },
        procEffects = {  }
    }, -- Jade Courtesan Figurine
    [86046] = {
        itemId = 86046,
        itemLevel = 489,
        useEffects = {             { spellId = 126597, ICD = 60, effect = 6, aura = 189, basePoints = 1149, miscValue = 33554432, target = 1 } },
        procEffects = {  }
    }, -- Jade Warlord Figurine
    [86131] = {
        itemId = 86131,
        itemLevel = 489,
        useEffects = {  },
        procEffects = {             { spellId = 126534, procId = 126533, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Vial of Dragon's Blood
    [86132] = {
        itemId = 86132,
        itemLevel = 489,
        useEffects = {  },
        procEffects = {             { spellId = 126552, procId = 126554, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Bottle of Infinite Stars
    [86133] = {
        itemId = 86133,
        itemLevel = 489,
        useEffects = {  },
        procEffects = {             { spellId = 126579, procId = 126577, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Light of the Cosmos
    [86144] = {
        itemId = 86144,
        itemLevel = 489,
        useEffects = {  },
        procEffects = {             { spellId = 126583, procId = 126582, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Lei Shen's Final Orders
    [86147] = {
        itemId = 86147,
        itemLevel = 489,
        useEffects = {  },
        procEffects = {             { spellId = 126590, procId = 126588, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Qin-xi's Polarizing Seal
    [86323] = {
        itemId = 86323,
        itemLevel = 496,
        useEffects = {  },
        procEffects = {             { spellId = 126647, procId = 126646, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Stuff of Nightmares
    [86327] = {
        itemId = 86327,
        itemLevel = 496,
        useEffects = {  },
        procEffects = {             { spellId = 126641, procId = 126640, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Spirits of the Sun
    [86332] = {
        itemId = 86332,
        itemLevel = 496,
        useEffects = {  },
        procEffects = {             { spellId = 126650, procId = 126649, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Terror in the Mists
    [86336] = {
        itemId = 86336,
        itemLevel = 496,
        useEffects = {  },
        procEffects = {             { spellId = 126658, procId = 126657, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Darkmist Vortex
    [86388] = {
        itemId = 86388,
        itemLevel = 496,
        useEffects = {  },
        procEffects = {             { spellId = 126660, procId = 126659, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Essence of Terror
    [86771] = {
        itemId = 86771,
        itemLevel = 476,
        useEffects = {             { spellId = 126599, ICD = 60, effect = 6, aura = 189, basePoints = 1149, miscValue = 917504, target = 1 } },
        procEffects = {  }
    }, -- Jade Charioteer Figurine
    [86772] = {
        itemId = 86772,
        itemLevel = 476,
        useEffects = {             { spellId = 126599, ICD = 60, effect = 6, aura = 189, basePoints = 1149, miscValue = 917504, target = 1 } },
        procEffects = {  }
    }, -- Jade Bandit Figurine
    [86773] = {
        itemId = 86773,
        itemLevel = 476,
        useEffects = {             { spellId = 126605, ICD = 60, effect = 6, aura = 189, basePoints = 1149, miscValue = 1792, target = 1 } },
        procEffects = {  }
    }, -- Jade Magistrate Figurine
    [86774] = {
        itemId = 86774,
        itemLevel = 476,
        useEffects = {             { spellId = 126606, ICD = 60, effect = 6, aura = 29, basePoints = 1149, miscValue = 4, target = 1 } },
        procEffects = {  }
    }, -- Jade Courtesan Figurine
    [86775] = {
        itemId = 86775,
        itemLevel = 476,
        useEffects = {             { spellId = 126597, ICD = 60, effect = 6, aura = 189, basePoints = 1149, miscValue = 33554432, target = 1 } },
        procEffects = {  }
    }, -- Jade Warlord Figurine
    [86790] = {
        itemId = 86790,
        itemLevel = 476,
        useEffects = {  },
        procEffects = {             { spellId = 126534, procId = 126533, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Vial of Dragon's Blood
    [86791] = {
        itemId = 86791,
        itemLevel = 476,
        useEffects = {  },
        procEffects = {             { spellId = 126552, procId = 126554, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Bottle of Infinite Stars
    [86792] = {
        itemId = 86792,
        itemLevel = 476,
        useEffects = {  },
        procEffects = {             { spellId = 126579, procId = 126577, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Light of the Cosmos
    [86802] = {
        itemId = 86802,
        itemLevel = 476,
        useEffects = {  },
        procEffects = {             { spellId = 126583, procId = 126582, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Lei Shen's Final Orders
    [86805] = {
        itemId = 86805,
        itemLevel = 476,
        useEffects = {  },
        procEffects = {             { spellId = 126590, procId = 126588, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Qin-xi's Polarizing Seal
    [86881] = {
        itemId = 86881,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126647, procId = 126646, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Stuff of Nightmares
    [86885] = {
        itemId = 86885,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126641, procId = 126640, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Spirits of the Sun
    [86890] = {
        itemId = 86890,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126650, procId = 126649, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Terror in the Mists
    [86894] = {
        itemId = 86894,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126658, procId = 126657, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Darkmist Vortex
    [86907] = {
        itemId = 86907,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126660, procId = 126659, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Essence of Terror
    [87057] = {
        itemId = 87057,
        itemLevel = 502,
        useEffects = {  },
        procEffects = {             { spellId = 126552, procId = 126554, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Bottle of Infinite Stars
    [87063] = {
        itemId = 87063,
        itemLevel = 502,
        useEffects = {  },
        procEffects = {             { spellId = 126534, procId = 126533, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Vial of Dragon's Blood
    [87065] = {
        itemId = 87065,
        itemLevel = 502,
        useEffects = {  },
        procEffects = {             { spellId = 126579, procId = 126577, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Light of the Cosmos
    [87072] = {
        itemId = 87072,
        itemLevel = 502,
        useEffects = {  },
        procEffects = {             { spellId = 126583, procId = 126582, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Lei Shen's Final Orders
    [87075] = {
        itemId = 87075,
        itemLevel = 502,
        useEffects = {  },
        procEffects = {             { spellId = 126590, procId = 126588, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Qin-xi's Polarizing Seal
    [87079] = {
        itemId = 87079,
        itemLevel = 502,
        useEffects = {             { spellId = 126599, ICD = 60, effect = 6, aura = 189, basePoints = 1149, miscValue = 917504, target = 1 } },
        procEffects = {  }
    }, -- Jade Bandit Figurine
    [87080] = {
        itemId = 87080,
        itemLevel = 502,
        useEffects = {             { spellId = 126605, ICD = 60, effect = 6, aura = 189, basePoints = 1149, miscValue = 1792, target = 1 } },
        procEffects = {  }
    }, -- Jade Magistrate Figurine
    [87081] = {
        itemId = 87081,
        itemLevel = 502,
        useEffects = {             { spellId = 126606, ICD = 60, effect = 6, aura = 29, basePoints = 1149, miscValue = 4, target = 1 } },
        procEffects = {  }
    }, -- Jade Courtesan Figurine
    [87082] = {
        itemId = 87082,
        itemLevel = 502,
        useEffects = {             { spellId = 126599, ICD = 60, effect = 6, aura = 189, basePoints = 1149, miscValue = 917504, target = 1 } },
        procEffects = {  }
    }, -- Jade Charioteer Figurine
    [87083] = {
        itemId = 87083,
        itemLevel = 502,
        useEffects = {             { spellId = 126597, ICD = 60, effect = 6, aura = 189, basePoints = 1149, miscValue = 33554432, target = 1 } },
        procEffects = {  }
    }, -- Jade Warlord Figurine
    [87160] = {
        itemId = 87160,
        itemLevel = 509,
        useEffects = {  },
        procEffects = {             { spellId = 126647, procId = 126646, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Stuff of Nightmares
    [87163] = {
        itemId = 87163,
        itemLevel = 509,
        useEffects = {  },
        procEffects = {             { spellId = 126641, procId = 126640, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Spirits of the Sun
    [87167] = {
        itemId = 87167,
        itemLevel = 509,
        useEffects = {  },
        procEffects = {             { spellId = 126650, procId = 126649, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Terror in the Mists
    [87172] = {
        itemId = 87172,
        itemLevel = 509,
        useEffects = {  },
        procEffects = {             { spellId = 126658, procId = 126657, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Darkmist Vortex
    [87175] = {
        itemId = 87175,
        itemLevel = 509,
        useEffects = {  },
        procEffects = {             { spellId = 126660, procId = 126659, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Essence of Terror
    [87571] = {
        itemId = 87571,
        itemLevel = 470,
        useEffects = {             { spellId = 127967, ICD = 120, effect = 6, aura = 189, basePoints = 1700, miscValue = 4, target = 1 } },
        procEffects = {  }
    }, -- Brawler's Statue
    [87572] = {
        itemId = 87572,
        itemLevel = 470,
        useEffects = {  },
        procEffects = {             { spellId = 127924, procId = 127923, effect = 6, aura = 42, basePoints = 1, bonusCoeff = 1.0, target = 1 } }
    }, -- Mithril Wristwatch
    [87573] = {
        itemId = 87573,
        itemLevel = 470,
        useEffects = {  },
        procEffects = {             { spellId = 127914, procId = 127915, effect = 6, aura = 42, basePoints = 1, bonusCoeff = 1.0, target = 1 } }
    }, -- Thousand-Year Pickled Egg
    [87574] = {
        itemId = 87574,
        itemLevel = 470,
        useEffects = {  },
        procEffects = {             { spellId = 127926, procId = 127928, effect = 6, aura = 42, target = 1 } }
    }, -- Coren's Cold Chromium Coaster
    [87575] = {
        itemId = 87575,
        itemLevel = 470,
        useEffects = {             { spellId = 101286, ICD = 600, effect = 28, basePoints = 85, miscValue = 54337, target = 47 } },
        procEffects = {  }
    }, -- Bubbliest Brightbrew Charm
    [87576] = {
        itemId = 87576,
        itemLevel = 470,
        useEffects = {             { spellId = 101285, ICD = 600, effect = 28, basePoints = 90, miscValue = 54336, target = 47 } },
        procEffects = {  }
    }, -- Bitterest Balebrew Charm
    [88995] = {
        itemId = 88995,
        itemLevel = 458,
        useEffects = {             { spellId = 129115, ICD = 60, effect = 6, aura = 33, basePoints = 60, target = 1 } },
        procEffects = {  }
    }, -- Shado-Pan Dragon Gun
    [89079] = {
        itemId = 89079,
        itemLevel = 489,
        useEffects = {             { spellId = 126597, ICD = 60, effect = 6, aura = 189, basePoints = 1149, miscValue = 33554432, target = 1 } },
        procEffects = {  }
    }, -- Lao-Chin's Liquid Courage
    [89080] = {
        itemId = 89080,
        itemLevel = 489,
        useEffects = {             { spellId = 126606, ICD = 60, effect = 6, aura = 29, basePoints = 1149, miscValue = 4, target = 1 } },
        procEffects = {  }
    }, -- Scroll of Revered Ancestors
    [89081] = {
        itemId = 89081,
        itemLevel = 489,
        useEffects = {             { spellId = 126605, ICD = 60, effect = 6, aura = 189, basePoints = 1149, miscValue = 1792, target = 1 } },
        procEffects = {  }
    }, -- Blossom of Pure Snow
    [89082] = {
        itemId = 89082,
        itemLevel = 489,
        useEffects = {             { spellId = 126599, ICD = 60, effect = 6, aura = 189, basePoints = 1149, miscValue = 917504, target = 1 } },
        procEffects = {  }
    }, -- Hawkmaster's Talon
    [89083] = {
        itemId = 89083,
        itemLevel = 489,
        useEffects = {             { spellId = 129812, ICD = 60, effect = 6, aura = 189, basePoints = 1149, miscValue = 917504, target = 1 } },
        procEffects = {  }
    }, -- Iron Belly Wok
    [89232] = {
        itemId = 89232,
        itemLevel = 458,
        useEffects = {             { spellId = 129554, ICD = 60, effect = 179, basePoints = 2, miscValue = 439, target = 87 } },
        procEffects = {  }
    }, -- Mogu Rune of Paralysis
    [89611] = {
        itemId = 89611,
        itemLevel = 463,
        useEffects = {             { spellId = 130486, ICD = 600, effect = 28, basePoints = 90, miscValue = 66362, target = 32 } },
        procEffects = {             { spellId = 130484, effect = 6, aura = 4, basePoints = 130485, target = 1 } }
    }, -- Quilen Statuette
    [91099] = {
        itemId = 91099,
        itemLevel = 496,
        useEffects = {             { spellId = 126690, ICD = 60, effect = 6, aura = 29, basePoints = 2144, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Badge of Conquest
    [91104] = {
        itemId = 91104,
        itemLevel = 496,
        useEffects = {  },
        procEffects = {             { spellId = 126708, procId = 126707, effect = 6, aura = 42, target = 1 } }
    }, -- Tyrannical Gladiator's Insignia of Conquest
    [91209] = {
        itemId = 91209,
        itemLevel = 496,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Emblem of Cruelty
    [91210] = {
        itemId = 91210,
        itemLevel = 496,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Emblem of Tenacity
    [91211] = {
        itemId = 91211,
        itemLevel = 496,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Emblem of Meditation
    [91400] = {
        itemId = 91400,
        itemLevel = 496,
        useEffects = {             { spellId = 126683, ICD = 60, effect = 6, aura = 29, basePoints = 2144, miscValue = 3, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Badge of Dominance
    [91401] = {
        itemId = 91401,
        itemLevel = 496,
        useEffects = {  },
        procEffects = {             { spellId = 126706, procId = 126705, effect = 6, aura = 42, target = 1 } }
    }, -- Tyrannical Gladiator's Insignia of Dominance
    [91410] = {
        itemId = 91410,
        itemLevel = 496,
        useEffects = {             { spellId = 126679, ICD = 60, effect = 6, aura = 29, basePoints = 2144, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Badge of Victory
    [91415] = {
        itemId = 91415,
        itemLevel = 496,
        useEffects = {  },
        procEffects = {             { spellId = 126702, procId = 126700, effect = 6, aura = 42, target = 1 } }
    }, -- Tyrannical Gladiator's Insignia of Victory
    [91452] = {
        itemId = 91452,
        itemLevel = 476,
        useEffects = {             { spellId = 126690, ICD = 60, effect = 6, aura = 29, basePoints = 2144, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Malevolent Gladiator's Badge of Conquest
    [91457] = {
        itemId = 91457,
        itemLevel = 476,
        useEffects = {  },
        procEffects = {             { spellId = 126708, procId = 126707, effect = 6, aura = 42, target = 1 } }
    }, -- Malevolent Gladiator's Insignia of Conquest
    [91562] = {
        itemId = 91562,
        itemLevel = 476,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Malevolent Gladiator's Emblem of Cruelty
    [91563] = {
        itemId = 91563,
        itemLevel = 476,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Malevolent Gladiator's Emblem of Tenacity
    [91564] = {
        itemId = 91564,
        itemLevel = 476,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Malevolent Gladiator's Emblem of Meditation
    [91682] = {
        itemId = 91682,
        itemLevel = 476,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Malevolent Gladiator's Medallion of Cruelty
    [91683] = {
        itemId = 91683,
        itemLevel = 476,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Malevolent Gladiator's Medallion of Cruelty
    [91684] = {
        itemId = 91684,
        itemLevel = 476,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Malevolent Gladiator's Medallion of Tenacity
    [91685] = {
        itemId = 91685,
        itemLevel = 476,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Malevolent Gladiator's Medallion of Tenacity
    [91686] = {
        itemId = 91686,
        itemLevel = 476,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Malevolent Gladiator's Medallion of Meditation
    [91687] = {
        itemId = 91687,
        itemLevel = 476,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Malevolent Gladiator's Medallion of Meditation
    [91753] = {
        itemId = 91753,
        itemLevel = 476,
        useEffects = {             { spellId = 126683, ICD = 60, effect = 6, aura = 29, basePoints = 2144, miscValue = 3, target = 1 } },
        procEffects = {  }
    }, -- Malevolent Gladiator's Badge of Dominance
    [91754] = {
        itemId = 91754,
        itemLevel = 476,
        useEffects = {  },
        procEffects = {             { spellId = 126706, procId = 126705, effect = 6, aura = 42, target = 1 } }
    }, -- Malevolent Gladiator's Insignia of Dominance
    [91763] = {
        itemId = 91763,
        itemLevel = 476,
        useEffects = {             { spellId = 126679, ICD = 60, effect = 6, aura = 29, basePoints = 2144, target = 1 } },
        procEffects = {  }
    }, -- Malevolent Gladiator's Badge of Victory
    [91768] = {
        itemId = 91768,
        itemLevel = 476,
        useEffects = {  },
        procEffects = {             { spellId = 126702, procId = 126700, effect = 6, aura = 42, target = 1 } }
    }, -- Malevolent Gladiator's Insignia of Victory
    [92782] = {
        itemId = 92782,
        itemLevel = 483,
        useEffects = {             { spellId = 134944, ICD = 60, effect = 6, aura = 189, basePoints = 10000, miscValue = 32768, target = 1 } },
        procEffects = {  }
    }, -- Steadfast Footman's Medallion
    [92783] = {
        itemId = 92783,
        itemLevel = 483,
        useEffects = {             { spellId = 134953, ICD = 60, effect = 6, aura = 189, basePoints = 10000, miscValue = 32768, target = 1 } },
        procEffects = {  }
    }, -- Mark of the Hardened Grunt
    [92784] = {
        itemId = 92784,
        itemLevel = 483,
        useEffects = {             { spellId = 134945, ICD = 60, effect = 6, aura = 189, basePoints = 5000, miscValue = 67108864, target = 1 } },
        procEffects = {  }
    }, -- SI:7 Operative's Manual
    [92785] = {
        itemId = 92785,
        itemLevel = 483,
        useEffects = {             { spellId = 134954, ICD = 60, effect = 6, aura = 189, basePoints = 5000, miscValue = 67108864, target = 1 } },
        procEffects = {  }
    }, -- Kor'kron Book of Hurting
    [92786] = {
        itemId = 92786,
        itemLevel = 483,
        useEffects = {             { spellId = 134946, ICD = 60, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Alliance Insignia of Conquering
    [92787] = {
        itemId = 92787,
        itemLevel = 483,
        useEffects = {             { spellId = 134956, ICD = 60, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Horde Insignia of Conquering
    [93253] = {
        itemId = 93253,
        itemLevel = 496,
        useEffects = {             { spellId = 136086, ICD = 60, effect = 6, aura = 189, basePoints = 1149, miscValue = 1792, target = 1 } },
        procEffects = {  }
    }, -- Woundripper Medallion
    [93254] = {
        itemId = 93254,
        itemLevel = 496,
        useEffects = {             { spellId = 136082, ICD = 60, effect = 6, aura = 29, basePoints = 1149, miscValue = 3, target = 1 } },
        procEffects = {  }
    }, -- Static-Caster's Medallion
    [93255] = {
        itemId = 93255,
        itemLevel = 496,
        useEffects = {             { spellId = 136083, ICD = 60, effect = 6, aura = 29, basePoints = 1149, miscValue = 4, target = 1 } },
        procEffects = {  }
    }, -- Cutstitcher Medallion
    [93256] = {
        itemId = 93256,
        itemLevel = 496,
        useEffects = {             { spellId = 136084, ICD = 60, effect = 6, aura = 189, basePoints = 1149, miscValue = 1792, target = 1 } },
        procEffects = {  }
    }, -- Skullrender Medallion
    [93257] = {
        itemId = 93257,
        itemLevel = 496,
        useEffects = {             { spellId = 136085, ICD = 60, effect = 6, aura = 189, basePoints = 1149, miscValue = 33554432, target = 1 } },
        procEffects = {  }
    }, -- Medallion of Mystifying Vapors
    [93258] = {
        itemId = 93258,
        itemLevel = 496,
        useEffects = {             { spellId = 136086, ICD = 60, effect = 6, aura = 189, basePoints = 1149, miscValue = 1792, target = 1 } },
        procEffects = {  }
    }, -- Arrowflight Medallion
    [93259] = {
        itemId = 93259,
        itemLevel = 496,
        useEffects = {             { spellId = 136082, ICD = 60, effect = 6, aura = 29, basePoints = 1149, miscValue = 3, target = 1 } },
        procEffects = {  }
    }, -- Shock-Charger Medallion
    [93260] = {
        itemId = 93260,
        itemLevel = 496,
        useEffects = {             { spellId = 136087, ICD = 60, effect = 6, aura = 29, basePoints = 1149, miscValue = 4, target = 1 } },
        procEffects = {  }
    }, -- Heartwarmer Medallion
    [93261] = {
        itemId = 93261,
        itemLevel = 496,
        useEffects = {             { spellId = 136084, ICD = 60, effect = 6, aura = 189, basePoints = 1149, miscValue = 1792, target = 1 } },
        procEffects = {  }
    }, -- Helmbreaker Medallion
    [93262] = {
        itemId = 93262,
        itemLevel = 496,
        useEffects = {             { spellId = 136085, ICD = 60, effect = 6, aura = 189, basePoints = 1149, miscValue = 33554432, target = 1 } },
        procEffects = {  }
    }, -- Vaporshield Medallion
    [93341] = {
        itemId = 93341,
        itemLevel = 458,
        useEffects = {             { spellId = 136088, ICD = 60, effect = 6, aura = 189, basePoints = 1149, miscValue = 33554432, target = 1 } },
        procEffects = {  }
    }, -- Dominator's Deadeye Badge
    [93342] = {
        itemId = 93342,
        itemLevel = 458,
        useEffects = {             { spellId = 136089, ICD = 60, effect = 6, aura = 189, basePoints = 1149, miscValue = 917504, target = 1 } },
        procEffects = {  }
    }, -- Dominator's Arcane Badge
    [93343] = {
        itemId = 93343,
        itemLevel = 458,
        useEffects = {             { spellId = 136090, ICD = 60, effect = 6, aura = 29, basePoints = 1149, miscValue = 4, target = 1 } },
        procEffects = {  }
    }, -- Dominator's Mending Badge
    [93344] = {
        itemId = 93344,
        itemLevel = 458,
        useEffects = {             { spellId = 136091, ICD = 60, effect = 6, aura = 189, basePoints = 1149, miscValue = 33554432, target = 1 } },
        procEffects = {  }
    }, -- Dominator's Knightly Badge
    [93345] = {
        itemId = 93345,
        itemLevel = 458,
        useEffects = {             { spellId = 136092, ICD = 60, effect = 6, aura = 189, basePoints = 1149, miscValue = 33554432, target = 1 } },
        procEffects = {  }
    }, -- Dominator's Durable Badge
    [93346] = {
        itemId = 93346,
        itemLevel = 458,
        useEffects = {             { spellId = 136088, ICD = 60, effect = 6, aura = 189, basePoints = 1149, miscValue = 33554432, target = 1 } },
        procEffects = {  }
    }, -- Deadeye Badge of the Shieldwall
    [93347] = {
        itemId = 93347,
        itemLevel = 458,
        useEffects = {             { spellId = 136089, ICD = 60, effect = 6, aura = 189, basePoints = 1149, miscValue = 917504, target = 1 } },
        procEffects = {  }
    }, -- Arcane Badge of the Shieldwall
    [93348] = {
        itemId = 93348,
        itemLevel = 458,
        useEffects = {             { spellId = 136090, ICD = 60, effect = 6, aura = 29, basePoints = 1149, miscValue = 4, target = 1 } },
        procEffects = {  }
    }, -- Mending Badge of the Shieldwall
    [93349] = {
        itemId = 93349,
        itemLevel = 458,
        useEffects = {             { spellId = 136091, ICD = 60, effect = 6, aura = 189, basePoints = 1149, miscValue = 33554432, target = 1 } },
        procEffects = {  }
    }, -- Knightly Badge of the Shieldwall
    [93350] = {
        itemId = 93350,
        itemLevel = 458,
        useEffects = {             { spellId = 136092, ICD = 60, effect = 6, aura = 189, basePoints = 1149, miscValue = 33554432, target = 1 } },
        procEffects = {  }
    }, -- Durable Badge of the Shieldwall
    [93419] = {
        itemId = 93419,
        itemLevel = 458,
        useEffects = {             { spellId = 126690, ICD = 60, effect = 6, aura = 29, basePoints = 2144, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Crafted Dreadful Gladiator's Badge of Conquest
    [93424] = {
        itemId = 93424,
        itemLevel = 458,
        useEffects = {  },
        procEffects = {             { spellId = 126708, procId = 126707, effect = 6, aura = 42, target = 1 } }
    }, -- Crafted Dreadful Gladiator's Insignia of Conquest
    [93485] = {
        itemId = 93485,
        itemLevel = 458,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Crafted Dreadful Gladiator's Emblem of Cruelty
    [93486] = {
        itemId = 93486,
        itemLevel = 458,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Crafted Dreadful Gladiator's Emblem of Tenacity
    [93487] = {
        itemId = 93487,
        itemLevel = 458,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Crafted Dreadful Gladiator's Emblem of Meditation
    [93560] = {
        itemId = 93560,
        itemLevel = 458,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Crafted Dreadful Gladiator's Medallion of Cruelty
    [93561] = {
        itemId = 93561,
        itemLevel = 458,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Crafted Dreadful Gladiator's Medallion of Cruelty
    [93562] = {
        itemId = 93562,
        itemLevel = 458,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Crafted Dreadful Gladiator's Medallion of Tenacity
    [93563] = {
        itemId = 93563,
        itemLevel = 458,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Crafted Dreadful Gladiator's Medallion of Tenacity
    [93564] = {
        itemId = 93564,
        itemLevel = 458,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Crafted Dreadful Gladiator's Medallion of Meditation
    [93565] = {
        itemId = 93565,
        itemLevel = 458,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Crafted Dreadful Gladiator's Medallion of Meditation
    [93600] = {
        itemId = 93600,
        itemLevel = 458,
        useEffects = {             { spellId = 126683, ICD = 60, effect = 6, aura = 29, basePoints = 2144, miscValue = 3, target = 1 } },
        procEffects = {  }
    }, -- Crafted Dreadful Gladiator's Badge of Dominance
    [93601] = {
        itemId = 93601,
        itemLevel = 458,
        useEffects = {  },
        procEffects = {             { spellId = 126706, procId = 126705, effect = 6, aura = 42, target = 1 } }
    }, -- Crafted Dreadful Gladiator's Insignia of Dominance
    [93606] = {
        itemId = 93606,
        itemLevel = 458,
        useEffects = {             { spellId = 126679, ICD = 60, effect = 6, aura = 29, basePoints = 2144, target = 1 } },
        procEffects = {  }
    }, -- Crafted Dreadful Gladiator's Badge of Victory
    [93611] = {
        itemId = 93611,
        itemLevel = 458,
        useEffects = {  },
        procEffects = {             { spellId = 126702, procId = 126700, effect = 6, aura = 42, target = 1 } }
    }, -- Crafted Dreadful Gladiator's Insignia of Victory
    [94329] = {
        itemId = 94329,
        itemLevel = 496,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Emblem of Meditation
    [94338] = {
        itemId = 94338,
        itemLevel = 496,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Medallion of Meditation
    [94346] = {
        itemId = 94346,
        itemLevel = 496,
        useEffects = {             { spellId = 126683, ICD = 60, effect = 6, aura = 29, basePoints = 2144, miscValue = 3, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Badge of Dominance
    [94349] = {
        itemId = 94349,
        itemLevel = 496,
        useEffects = {             { spellId = 126679, ICD = 60, effect = 6, aura = 29, basePoints = 2144, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Badge of Victory
    [94356] = {
        itemId = 94356,
        itemLevel = 496,
        useEffects = {  },
        procEffects = {             { spellId = 126708, procId = 126707, effect = 6, aura = 42, target = 1 } }
    }, -- Tyrannical Gladiator's Insignia of Conquest
    [94361] = {
        itemId = 94361,
        itemLevel = 496,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Medallion of Tenacity
    [94373] = {
        itemId = 94373,
        itemLevel = 496,
        useEffects = {             { spellId = 126690, ICD = 60, effect = 6, aura = 29, basePoints = 2144, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Badge of Conquest
    [94386] = {
        itemId = 94386,
        itemLevel = 496,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Medallion of Cruelty
    [94387] = {
        itemId = 94387,
        itemLevel = 496,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Medallion of Tenacity
    [94388] = {
        itemId = 94388,
        itemLevel = 496,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Medallion of Meditation
    [94396] = {
        itemId = 94396,
        itemLevel = 496,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Emblem of Cruelty
    [94415] = {
        itemId = 94415,
        itemLevel = 496,
        useEffects = {  },
        procEffects = {             { spellId = 126702, procId = 126700, effect = 6, aura = 42, target = 1 } }
    }, -- Tyrannical Gladiator's Insignia of Victory
    [94422] = {
        itemId = 94422,
        itemLevel = 496,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Emblem of Tenacity
    [94454] = {
        itemId = 94454,
        itemLevel = 496,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Medallion of Cruelty
    [94482] = {
        itemId = 94482,
        itemLevel = 496,
        useEffects = {  },
        procEffects = {             { spellId = 126706, procId = 126705, effect = 6, aura = 42, target = 1 } }
    }, -- Tyrannical Gladiator's Insignia of Dominance
    [94507] = {
        itemId = 94507,
        itemLevel = 522,
        useEffects = {             { spellId = 138728, ICD = 120, effect = 6, aura = 189, basePoints = 1700, miscValue = 4, target = 1 } },
        procEffects = {  }
    }, -- Steadfast Talisman of the Shado-Pan Assault
    [94508] = {
        itemId = 94508,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 138701, procId = 138702, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Brutal Talisman of the Shado-Pan Assault
    [94509] = {
        itemId = 94509,
        itemLevel = 522,
        useEffects = {             { spellId = 138724, ICD = 180, effect = 30, basePoints = 9935, target = 1 } },
        procEffects = {  }
    }, -- Soothing Talisman of the Shado-Pan Assault
    [94510] = {
        itemId = 94510,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 138704, procId = 138703, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Volatile Talisman of the Shado-Pan Assault
    [94511] = {
        itemId = 94511,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 138700, procId = 138699, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Vicious Talisman of the Shado-Pan Assault
    [94512] = {
        itemId = 94512,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 138757, procId = 138756, effect = 6, aura = 42, target = 1 } }
    }, -- Renataki's Soul Charm
    [94513] = {
        itemId = 94513,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 138790, procId = 138786, effect = 6, aura = 42, target = 1 } }
    }, -- Wushoolay's Final Choice
    [94514] = {
        itemId = 94514,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 138849, procId = 138856, effect = 6, aura = 42, basePoints = 100, target = 1 } }
    }, -- Horridon's Last Gasp
    [94515] = {
        itemId = 94515,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 138758, procId = 138759, effect = 6, aura = 42, target = 1 } }
    }, -- Fabled Feather of Ji-Kun
    [94516] = {
        itemId = 94516,
        itemLevel = 522,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Fortitude of the Zandalari
    [94518] = {
        itemId = 94518,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 138865, procId = 138864, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Delicate Vial of the Sanguinaire
    [94519] = {
        itemId = 94519,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 138871, procId = 138870, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Primordius' Talisman of Rage
    [94520] = {
        itemId = 94520,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 138924, procId = 140380, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Inscribed Bag of Hydra-Spawn
    [94521] = {
        itemId = 94521,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 138896, procId = 138898, effect = 6, aura = 42, basePoints = 100, target = 1 } }
    }, -- Breath of the Hydra
    [94522] = {
        itemId = 94522,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 138894, procId = 138895, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Talisman of Bloodlust
    [94523] = {
        itemId = 94523,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 138939, procId = 138938, effect = 6, aura = 42, basePoints = 3, target = 1 } }
    }, -- Bad Juju
    [94524] = {
        itemId = 94524,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 138964, procId = 138963, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Unerring Vision of Lei Shen
    [94525] = {
        itemId = 94525,
        itemLevel = 522,
        useEffects = {             { spellId = 138925, ICD = 20, effect = 6, aura = 69, basePoints = 1000, miscValue = 127, target = 21 } },
        procEffects = {             { spellId = 138968, procId = 138967, effect = 6, aura = 42, target = 1 } }
    }, -- Stolen Relic of Zuldazar
    [94526] = {
        itemId = 94526,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 138957, effect = 6, aura = 4, target = 1 } }
    }, -- Spark of Zandalar
    [94527] = {
        itemId = 94527,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 138972, procId = 138973, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Ji-Kun's Rising Winds
    [94528] = {
        itemId = 94528,
        itemLevel = 522,
        useEffects = {             { spellId = 138979, ICD = 120, effect = 6, aura = 69, basePoints = 1000, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Soul Barrier
    [94529] = {
        itemId = 94529,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 139171, procId = 139170, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Gaze of the Twins
    [94530] = {
        itemId = 94530,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 139190, effect = 6, aura = 4, target = 1 } }
    }, -- Lightning-Imbued Chalice
    [94531] = {
        itemId = 94531,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 139134, procId = 139133, effect = 6, aura = 42, basePoints = 100, target = 1 } }
    }, -- Cha-Ye's Essence of Brilliance
    [94532] = {
        itemId = 94532,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 139116, ICD = 60, effect = 6, aura = 4, target = 1 } }
    }, -- Rune of Re-Origination
    [95625] = {
        itemId = 95625,
        itemLevel = 502,
        useEffects = {  },
        procEffects = {             { spellId = 138757, procId = 138756, effect = 6, aura = 42, target = 1 } }
    }, -- Renataki's Soul Charm
    [95641] = {
        itemId = 95641,
        itemLevel = 502,
        useEffects = {  },
        procEffects = {             { spellId = 138849, procId = 138856, effect = 6, aura = 42, basePoints = 100, target = 1 } }
    }, -- Horridon's Last Gasp
    [95654] = {
        itemId = 95654,
        itemLevel = 502,
        useEffects = {  },
        procEffects = {             { spellId = 138957, effect = 6, aura = 4, target = 1 } }
    }, -- Spark of Zandalar
    [95665] = {
        itemId = 95665,
        itemLevel = 502,
        useEffects = {  },
        procEffects = {             { spellId = 138939, procId = 138938, effect = 6, aura = 42, basePoints = 3, target = 1 } }
    }, -- Bad Juju
    [95669] = {
        itemId = 95669,
        itemLevel = 502,
        useEffects = {  },
        procEffects = {             { spellId = 138790, procId = 138786, effect = 6, aura = 42, target = 1 } }
    }, -- Wushoolay's Final Choice
    [95677] = {
        itemId = 95677,
        itemLevel = 502,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Fortitude of the Zandalari
    [95711] = {
        itemId = 95711,
        itemLevel = 502,
        useEffects = {  },
        procEffects = {             { spellId = 138896, procId = 138898, effect = 6, aura = 42, basePoints = 100, target = 1 } }
    }, -- Breath of the Hydra
    [95712] = {
        itemId = 95712,
        itemLevel = 502,
        useEffects = {  },
        procEffects = {             { spellId = 138924, procId = 140380, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Inscribed Bag of Hydra-Spawn
    [95726] = {
        itemId = 95726,
        itemLevel = 502,
        useEffects = {  },
        procEffects = {             { spellId = 138758, procId = 138759, effect = 6, aura = 42, target = 1 } }
    }, -- Fabled Feather of Ji-Kun
    [95727] = {
        itemId = 95727,
        itemLevel = 502,
        useEffects = {  },
        procEffects = {             { spellId = 138972, procId = 138973, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Ji-Kun's Rising Winds
    [95748] = {
        itemId = 95748,
        itemLevel = 502,
        useEffects = {  },
        procEffects = {             { spellId = 138894, procId = 138895, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Talisman of Bloodlust
    [95757] = {
        itemId = 95757,
        itemLevel = 502,
        useEffects = {  },
        procEffects = {             { spellId = 138871, procId = 138870, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Primordius' Talisman of Rage
    [95763] = {
        itemId = 95763,
        itemLevel = 502,
        useEffects = {             { spellId = 138925, ICD = 20, effect = 6, aura = 69, basePoints = 1000, miscValue = 127, target = 21 } },
        procEffects = {             { spellId = 138968, procId = 138967, effect = 6, aura = 42, target = 1 } }
    }, -- Stolen Relic of Zuldazar
    [95772] = {
        itemId = 95772,
        itemLevel = 502,
        useEffects = {  },
        procEffects = {             { spellId = 139134, procId = 139133, effect = 6, aura = 42, basePoints = 100, target = 1 } }
    }, -- Cha-Ye's Essence of Brilliance
    [95779] = {
        itemId = 95779,
        itemLevel = 502,
        useEffects = {  },
        procEffects = {             { spellId = 138865, procId = 138864, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Delicate Vial of the Sanguinaire
    [95799] = {
        itemId = 95799,
        itemLevel = 502,
        useEffects = {  },
        procEffects = {             { spellId = 139171, procId = 139170, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Gaze of the Twins
    [95802] = {
        itemId = 95802,
        itemLevel = 502,
        useEffects = {  },
        procEffects = {             { spellId = 139116, ICD = 60, effect = 6, aura = 4, target = 1 } }
    }, -- Rune of Re-Origination
    [95811] = {
        itemId = 95811,
        itemLevel = 502,
        useEffects = {             { spellId = 138979, ICD = 120, effect = 6, aura = 69, basePoints = 1000, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Soul Barrier
    [95814] = {
        itemId = 95814,
        itemLevel = 502,
        useEffects = {  },
        procEffects = {             { spellId = 138964, procId = 138963, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Unerring Vision of Lei Shen
    [95817] = {
        itemId = 95817,
        itemLevel = 502,
        useEffects = {  },
        procEffects = {             { spellId = 139190, effect = 6, aura = 4, target = 1 } }
    }, -- Lightning-Imbued Chalice
    [95997] = {
        itemId = 95997,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 138757, procId = 138756, effect = 6, aura = 42, target = 1 } }
    }, -- Renataki's Soul Charm
    [96013] = {
        itemId = 96013,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 138849, procId = 138856, effect = 6, aura = 42, basePoints = 100, target = 1 } }
    }, -- Horridon's Last Gasp
    [96026] = {
        itemId = 96026,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 138957, effect = 6, aura = 4, target = 1 } }
    }, -- Spark of Zandalar
    [96037] = {
        itemId = 96037,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 138939, procId = 138938, effect = 6, aura = 42, basePoints = 3, target = 1 } }
    }, -- Bad Juju
    [96041] = {
        itemId = 96041,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 138790, procId = 138786, effect = 6, aura = 42, target = 1 } }
    }, -- Wushoolay's Final Choice
    [96049] = {
        itemId = 96049,
        itemLevel = 528,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Fortitude of the Zandalari
    [96083] = {
        itemId = 96083,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 138896, procId = 138898, effect = 6, aura = 42, basePoints = 100, target = 1 } }
    }, -- Breath of the Hydra
    [96084] = {
        itemId = 96084,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 138924, procId = 140380, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Inscribed Bag of Hydra-Spawn
    [96098] = {
        itemId = 96098,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 138758, procId = 138759, effect = 6, aura = 42, target = 1 } }
    }, -- Fabled Feather of Ji-Kun
    [96099] = {
        itemId = 96099,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 138972, procId = 138973, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Ji-Kun's Rising Winds
    [96120] = {
        itemId = 96120,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 138894, procId = 138895, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Talisman of Bloodlust
    [96129] = {
        itemId = 96129,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 138871, procId = 138870, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Primordius' Talisman of Rage
    [96135] = {
        itemId = 96135,
        itemLevel = 528,
        useEffects = {             { spellId = 138925, ICD = 20, effect = 6, aura = 69, basePoints = 1000, miscValue = 127, target = 21 } },
        procEffects = {             { spellId = 138968, procId = 138967, effect = 6, aura = 42, target = 1 } }
    }, -- Stolen Relic of Zuldazar
    [96144] = {
        itemId = 96144,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 139134, procId = 139133, effect = 6, aura = 42, basePoints = 100, target = 1 } }
    }, -- Cha-Ye's Essence of Brilliance
    [96151] = {
        itemId = 96151,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 138865, procId = 138864, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Delicate Vial of the Sanguinaire
    [96171] = {
        itemId = 96171,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 139171, procId = 139170, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Gaze of the Twins
    [96174] = {
        itemId = 96174,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 139116, ICD = 60, effect = 6, aura = 4, target = 1 } }
    }, -- Rune of Re-Origination
    [96183] = {
        itemId = 96183,
        itemLevel = 528,
        useEffects = {             { spellId = 138979, ICD = 120, effect = 6, aura = 69, basePoints = 1000, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Soul Barrier
    [96186] = {
        itemId = 96186,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 138964, procId = 138963, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Unerring Vision of Lei Shen
    [96189] = {
        itemId = 96189,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 139190, effect = 6, aura = 4, target = 1 } }
    }, -- Lightning-Imbued Chalice
    [96369] = {
        itemId = 96369,
        itemLevel = 535,
        useEffects = {  },
        procEffects = {             { spellId = 138757, procId = 138756, effect = 6, aura = 42, target = 1 } }
    }, -- Renataki's Soul Charm
    [96385] = {
        itemId = 96385,
        itemLevel = 535,
        useEffects = {  },
        procEffects = {             { spellId = 138849, procId = 138856, effect = 6, aura = 42, basePoints = 100, target = 1 } }
    }, -- Horridon's Last Gasp
    [96398] = {
        itemId = 96398,
        itemLevel = 535,
        useEffects = {  },
        procEffects = {             { spellId = 138957, effect = 6, aura = 4, target = 1 } }
    }, -- Spark of Zandalar
    [96409] = {
        itemId = 96409,
        itemLevel = 535,
        useEffects = {  },
        procEffects = {             { spellId = 138939, procId = 138938, effect = 6, aura = 42, basePoints = 3, target = 1 } }
    }, -- Bad Juju
    [96413] = {
        itemId = 96413,
        itemLevel = 535,
        useEffects = {  },
        procEffects = {             { spellId = 138790, procId = 138786, effect = 6, aura = 42, target = 1 } }
    }, -- Wushoolay's Final Choice
    [96421] = {
        itemId = 96421,
        itemLevel = 535,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Fortitude of the Zandalari
    [96455] = {
        itemId = 96455,
        itemLevel = 535,
        useEffects = {  },
        procEffects = {             { spellId = 138896, procId = 138898, effect = 6, aura = 42, basePoints = 100, target = 1 } }
    }, -- Breath of the Hydra
    [96456] = {
        itemId = 96456,
        itemLevel = 535,
        useEffects = {  },
        procEffects = {             { spellId = 138924, procId = 140380, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Inscribed Bag of Hydra-Spawn
    [96470] = {
        itemId = 96470,
        itemLevel = 535,
        useEffects = {  },
        procEffects = {             { spellId = 138758, procId = 138759, effect = 6, aura = 42, target = 1 } }
    }, -- Fabled Feather of Ji-Kun
    [96471] = {
        itemId = 96471,
        itemLevel = 535,
        useEffects = {  },
        procEffects = {             { spellId = 138972, procId = 138973, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Ji-Kun's Rising Winds
    [96492] = {
        itemId = 96492,
        itemLevel = 535,
        useEffects = {  },
        procEffects = {             { spellId = 138894, procId = 138895, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Talisman of Bloodlust
    [96501] = {
        itemId = 96501,
        itemLevel = 535,
        useEffects = {  },
        procEffects = {             { spellId = 138871, procId = 138870, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Primordius' Talisman of Rage
    [96507] = {
        itemId = 96507,
        itemLevel = 535,
        useEffects = {             { spellId = 138925, ICD = 20, effect = 6, aura = 69, basePoints = 1000, miscValue = 127, target = 21 } },
        procEffects = {             { spellId = 138968, procId = 138967, effect = 6, aura = 42, target = 1 } }
    }, -- Stolen Relic of Zuldazar
    [96516] = {
        itemId = 96516,
        itemLevel = 535,
        useEffects = {  },
        procEffects = {             { spellId = 139134, procId = 139133, effect = 6, aura = 42, basePoints = 100, target = 1 } }
    }, -- Cha-Ye's Essence of Brilliance
    [96523] = {
        itemId = 96523,
        itemLevel = 535,
        useEffects = {  },
        procEffects = {             { spellId = 138865, procId = 138864, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Delicate Vial of the Sanguinaire
    [96543] = {
        itemId = 96543,
        itemLevel = 535,
        useEffects = {  },
        procEffects = {             { spellId = 139171, procId = 139170, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Gaze of the Twins
    [96546] = {
        itemId = 96546,
        itemLevel = 535,
        useEffects = {  },
        procEffects = {             { spellId = 139116, ICD = 60, effect = 6, aura = 4, target = 1 } }
    }, -- Rune of Re-Origination
    [96555] = {
        itemId = 96555,
        itemLevel = 535,
        useEffects = {             { spellId = 138979, ICD = 120, effect = 6, aura = 69, basePoints = 1000, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Soul Barrier
    [96558] = {
        itemId = 96558,
        itemLevel = 535,
        useEffects = {  },
        procEffects = {             { spellId = 138964, procId = 138963, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Unerring Vision of Lei Shen
    [96561] = {
        itemId = 96561,
        itemLevel = 535,
        useEffects = {  },
        procEffects = {             { spellId = 139190, effect = 6, aura = 4, target = 1 } }
    }, -- Lightning-Imbued Chalice
    [97304] = {
        itemId = 97304,
        itemLevel = 463,
        useEffects = {  },
        procEffects = {             { spellId = 141159, procId = 141158, effect = 6, aura = 42, basePoints = 100, target = 1 } }
    }, -- Empty Fruit Barrel
    [97305] = {
        itemId = 97305,
        itemLevel = 489,
        useEffects = {             { spellId = 141162, ICD = 60, effect = 6, aura = 29, basePoints = 1149, miscValue = 4, target = 1 } },
        procEffects = {  }
    }, -- Jade Courtesan Figurine
    [97531] = {
        itemId = 97531,
        itemLevel = 483,
        useEffects = {             { spellId = 141376, ICD = 60, effect = 6, aura = 13, basePoints = 2144, miscValue = 126, target = 1 } },
        procEffects = {  }
    }, -- Malevolent Gladiator's Badge of Dominance
    [97532] = {
        itemId = 97532,
        itemLevel = 491,
        useEffects = {             { spellId = 141377, ICD = 60, effect = 6, aura = 13, basePoints = 2144, miscValue = 126, target = 1 } },
        procEffects = {  }
    }, -- Malevolent Gladiator's Badge of Dominance
    [97533] = {
        itemId = 97533,
        itemLevel = 483,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Malevolent Gladiator's Medallion of Cruelty
    [97845] = {
        itemId = 97845,
        itemLevel = 483,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Malevolent Gladiator's Medallion of Tenacity
    [97935] = {
        itemId = 97935,
        itemLevel = 483,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Malevolent Gladiator's Medallion of Tenacity
    [97936] = {
        itemId = 97936,
        itemLevel = 491,
        useEffects = {             { spellId = 141969, ICD = 60, effect = 6, aura = 13, basePoints = 2144, miscValue = 126, target = 1 } },
        procEffects = {  }
    }, -- Malevolent Gladiator's Badge of Dominance
    [98019] = {
        itemId = 98019,
        itemLevel = 510,
        useEffects = {  },
        procEffects = {             { spellId = 142158, procId = 142157, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Light of the Cosmos
    [98020] = {
        itemId = 98020,
        itemLevel = 504,
        useEffects = {  },
        procEffects = {             { spellId = 142160, procId = 142159, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Essence of Terror
    [98049] = {
        itemId = 98049,
        itemLevel = 476,
        useEffects = {  },
        procEffects = {             { spellId = 142195, procId = 142194, effect = 6, aura = 42, target = 1 } }
    }, -- Relic of Yu'lon
    [98050] = {
        itemId = 98050,
        itemLevel = 489,
        useEffects = {  },
        procEffects = {             { spellId = 142158, procId = 142157, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Light of the Cosmos
    [98075] = {
        itemId = 98075,
        itemLevel = 484,
        useEffects = {  },
        procEffects = {             { spellId = 142195, procId = 142194, effect = 6, aura = 42, target = 1 } }
    }, -- Relic of Yu'lon
    [98076] = {
        itemId = 98076,
        itemLevel = 496,
        useEffects = {  },
        procEffects = {             { spellId = 142160, procId = 142159, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Essence of Terror
    [98755] = {
        itemId = 98755,
        itemLevel = 476,
        useEffects = {             { spellId = 126690, ICD = 60, effect = 6, aura = 29, basePoints = 2144, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Crafted Malevolent Gladiator's Badge of Conquest
    [98760] = {
        itemId = 98760,
        itemLevel = 476,
        useEffects = {  },
        procEffects = {             { spellId = 126708, procId = 126707, effect = 6, aura = 42, target = 1 } }
    }, -- Crafted Malevolent Gladiator's Insignia of Conquest
    [98811] = {
        itemId = 98811,
        itemLevel = 476,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Crafted Malevolent Gladiator's Emblem of Cruelty
    [98812] = {
        itemId = 98812,
        itemLevel = 476,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Crafted Malevolent Gladiator's Emblem of Tenacity
    [98813] = {
        itemId = 98813,
        itemLevel = 476,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Crafted Malevolent Gladiator's Emblem of Meditation
    [98875] = {
        itemId = 98875,
        itemLevel = 476,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Crafted Malevolent Gladiator's Medallion of Cruelty
    [98876] = {
        itemId = 98876,
        itemLevel = 476,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Crafted Malevolent Gladiator's Medallion of Cruelty
    [98877] = {
        itemId = 98877,
        itemLevel = 476,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Crafted Malevolent Gladiator's Medallion of Tenacity
    [98878] = {
        itemId = 98878,
        itemLevel = 476,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Crafted Malevolent Gladiator's Medallion of Tenacity
    [98879] = {
        itemId = 98879,
        itemLevel = 476,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Crafted Malevolent Gladiator's Medallion of Meditation
    [98880] = {
        itemId = 98880,
        itemLevel = 476,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Crafted Malevolent Gladiator's Medallion of Meditation
    [98910] = {
        itemId = 98910,
        itemLevel = 476,
        useEffects = {             { spellId = 126683, ICD = 60, effect = 6, aura = 29, basePoints = 2144, miscValue = 3, target = 1 } },
        procEffects = {  }
    }, -- Crafted Malevolent Gladiator's Badge of Dominance
    [98911] = {
        itemId = 98911,
        itemLevel = 476,
        useEffects = {  },
        procEffects = {             { spellId = 126706, procId = 126705, effect = 6, aura = 42, target = 1 } }
    }, -- Crafted Malevolent Gladiator's Insignia of Dominance
    [98912] = {
        itemId = 98912,
        itemLevel = 476,
        useEffects = {             { spellId = 126679, ICD = 60, effect = 6, aura = 29, basePoints = 2144, target = 1 } },
        procEffects = {  }
    }, -- Crafted Malevolent Gladiator's Badge of Victory
    [98917] = {
        itemId = 98917,
        itemLevel = 476,
        useEffects = {  },
        procEffects = {             { spellId = 126702, procId = 126700, effect = 6, aura = 42, target = 1 } }
    }, -- Crafted Malevolent Gladiator's Insignia of Victory
    [99772] = {
        itemId = 99772,
        itemLevel = 496,
        useEffects = {             { spellId = 126690, ICD = 60, effect = 6, aura = 29, basePoints = 2144, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Badge of Conquest
    [99777] = {
        itemId = 99777,
        itemLevel = 496,
        useEffects = {  },
        procEffects = {             { spellId = 126708, procId = 126707, effect = 6, aura = 42, target = 1 } }
    }, -- Tyrannical Gladiator's Insignia of Conquest
    [99838] = {
        itemId = 99838,
        itemLevel = 496,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Emblem of Cruelty
    [99839] = {
        itemId = 99839,
        itemLevel = 496,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Emblem of Tenacity
    [99840] = {
        itemId = 99840,
        itemLevel = 496,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Emblem of Meditation
    [99937] = {
        itemId = 99937,
        itemLevel = 496,
        useEffects = {             { spellId = 126683, ICD = 60, effect = 6, aura = 29, basePoints = 2144, miscValue = 3, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Badge of Dominance
    [99938] = {
        itemId = 99938,
        itemLevel = 496,
        useEffects = {  },
        procEffects = {             { spellId = 126706, procId = 126705, effect = 6, aura = 42, target = 1 } }
    }, -- Tyrannical Gladiator's Insignia of Dominance
    [99943] = {
        itemId = 99943,
        itemLevel = 496,
        useEffects = {             { spellId = 126679, ICD = 60, effect = 6, aura = 29, basePoints = 2144, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Badge of Victory
    [99948] = {
        itemId = 99948,
        itemLevel = 496,
        useEffects = {  },
        procEffects = {             { spellId = 126702, procId = 126700, effect = 6, aura = 42, target = 1 } }
    }, -- Tyrannical Gladiator's Insignia of Victory
    [99990] = {
        itemId = 99990,
        itemLevel = 496,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Emblem of Meditation
    [100006] = {
        itemId = 100006,
        itemLevel = 496,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Medallion of Meditation
    [100016] = {
        itemId = 100016,
        itemLevel = 496,
        useEffects = {             { spellId = 126683, ICD = 60, effect = 6, aura = 29, basePoints = 2144, miscValue = 3, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Badge of Dominance
    [100019] = {
        itemId = 100019,
        itemLevel = 496,
        useEffects = {             { spellId = 126679, ICD = 60, effect = 6, aura = 29, basePoints = 2144, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Badge of Victory
    [100026] = {
        itemId = 100026,
        itemLevel = 496,
        useEffects = {  },
        procEffects = {             { spellId = 126708, procId = 126707, effect = 6, aura = 42, target = 1 } }
    }, -- Tyrannical Gladiator's Insignia of Conquest
    [100031] = {
        itemId = 100031,
        itemLevel = 496,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Medallion of Tenacity
    [100043] = {
        itemId = 100043,
        itemLevel = 496,
        useEffects = {             { spellId = 126690, ICD = 60, effect = 6, aura = 29, basePoints = 2144, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Badge of Conquest
    [100056] = {
        itemId = 100056,
        itemLevel = 496,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Medallion of Cruelty
    [100057] = {
        itemId = 100057,
        itemLevel = 496,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Medallion of Tenacity
    [100058] = {
        itemId = 100058,
        itemLevel = 496,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Medallion of Meditation
    [100066] = {
        itemId = 100066,
        itemLevel = 496,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Emblem of Cruelty
    [100085] = {
        itemId = 100085,
        itemLevel = 496,
        useEffects = {  },
        procEffects = {             { spellId = 126702, procId = 126700, effect = 6, aura = 42, target = 1 } }
    }, -- Tyrannical Gladiator's Insignia of Victory
    [100092] = {
        itemId = 100092,
        itemLevel = 496,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Emblem of Tenacity
    [100124] = {
        itemId = 100124,
        itemLevel = 496,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Tyrannical Gladiator's Medallion of Cruelty
    [100152] = {
        itemId = 100152,
        itemLevel = 496,
        useEffects = {  },
        procEffects = {             { spellId = 126706, procId = 126705, effect = 6, aura = 42, target = 1 } }
    }, -- Tyrannical Gladiator's Insignia of Dominance
    [100195] = {
        itemId = 100195,
        itemLevel = 522,
        useEffects = {             { spellId = 126690, ICD = 60, effect = 6, aura = 29, basePoints = 2144, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Badge of Conquest
    [100200] = {
        itemId = 100200,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 126708, procId = 126707, effect = 6, aura = 42, target = 1 } }
    }, -- Grievous Gladiator's Insignia of Conquest
    [100305] = {
        itemId = 100305,
        itemLevel = 522,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Emblem of Cruelty
    [100306] = {
        itemId = 100306,
        itemLevel = 522,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Emblem of Tenacity
    [100307] = {
        itemId = 100307,
        itemLevel = 522,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Emblem of Meditation
    [100490] = {
        itemId = 100490,
        itemLevel = 522,
        useEffects = {             { spellId = 126683, ICD = 60, effect = 6, aura = 29, basePoints = 2144, miscValue = 3, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Badge of Dominance
    [100491] = {
        itemId = 100491,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 126706, procId = 126705, effect = 6, aura = 42, target = 1 } }
    }, -- Grievous Gladiator's Insignia of Dominance
    [100500] = {
        itemId = 100500,
        itemLevel = 522,
        useEffects = {             { spellId = 126679, ICD = 60, effect = 6, aura = 29, basePoints = 2144, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Badge of Victory
    [100505] = {
        itemId = 100505,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 126702, procId = 126700, effect = 6, aura = 42, target = 1 } }
    }, -- Grievous Gladiator's Insignia of Victory
    [100559] = {
        itemId = 100559,
        itemLevel = 522,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Emblem of Meditation
    [100568] = {
        itemId = 100568,
        itemLevel = 522,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Medallion of Meditation
    [100576] = {
        itemId = 100576,
        itemLevel = 522,
        useEffects = {             { spellId = 126683, ICD = 60, effect = 6, aura = 29, basePoints = 2144, miscValue = 3, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Badge of Dominance
    [100579] = {
        itemId = 100579,
        itemLevel = 522,
        useEffects = {             { spellId = 126679, ICD = 60, effect = 6, aura = 29, basePoints = 2144, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Badge of Victory
    [100586] = {
        itemId = 100586,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 126708, procId = 126707, effect = 6, aura = 42, target = 1 } }
    }, -- Grievous Gladiator's Insignia of Conquest
    [100591] = {
        itemId = 100591,
        itemLevel = 522,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Medallion of Tenacity
    [100603] = {
        itemId = 100603,
        itemLevel = 522,
        useEffects = {             { spellId = 126690, ICD = 60, effect = 6, aura = 29, basePoints = 2144, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Badge of Conquest
    [100616] = {
        itemId = 100616,
        itemLevel = 522,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Medallion of Cruelty
    [100617] = {
        itemId = 100617,
        itemLevel = 522,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Medallion of Tenacity
    [100618] = {
        itemId = 100618,
        itemLevel = 522,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Medallion of Meditation
    [100626] = {
        itemId = 100626,
        itemLevel = 522,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Emblem of Cruelty
    [100645] = {
        itemId = 100645,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 126702, procId = 126700, effect = 6, aura = 42, target = 1 } }
    }, -- Grievous Gladiator's Insignia of Victory
    [100652] = {
        itemId = 100652,
        itemLevel = 522,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Emblem of Tenacity
    [100684] = {
        itemId = 100684,
        itemLevel = 522,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Medallion of Cruelty
    [100712] = {
        itemId = 100712,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 126706, procId = 126705, effect = 6, aura = 42, target = 1 } }
    }, -- Grievous Gladiator's Insignia of Dominance
    [100990] = {
        itemId = 100990,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 133631, procId = 133630, effect = 6, aura = 42, target = 1 } }
    }, -- Heart-Lesion Stone of Battle
    [100991] = {
        itemId = 100991,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126583, procId = 126582, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Heart-Lesion Idol of Battle
    [100999] = {
        itemId = 100999,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126237, procId = 126236, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Heart-Lesion Defender Idol
    [101002] = {
        itemId = 101002,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 133631, procId = 133630, effect = 6, aura = 42, target = 1 } }
    }, -- Heart-Lesion Defender Stone
    [101009] = {
        itemId = 101009,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126552, procId = 126554, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Springrain Idol of Rage
    [101012] = {
        itemId = 101012,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 133631, procId = 133630, effect = 6, aura = 42, target = 1 } }
    }, -- Springrain Stone of Rage
    [101023] = {
        itemId = 101023,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126660, procId = 126659, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Springrain Idol of Destruction
    [101026] = {
        itemId = 101026,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 133631, procId = 133630, effect = 6, aura = 42, target = 1 } }
    }, -- Springrain Stone of Destruction
    [101038] = {
        itemId = 101038,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126468, procId = 126467, effect = 6, aura = 42, basePoints = 100, target = 1 } }
    }, -- Springrain Idol of Wisdom
    [101041] = {
        itemId = 101041,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126268, procId = 126266, effect = 6, aura = 42, basePoints = 100, target = 1 } }
    }, -- Springrain Stone of Wisdom
    [101054] = {
        itemId = 101054,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126552, procId = 126554, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Trailseeker Idol of Rage
    [101057] = {
        itemId = 101057,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 133631, procId = 133630, effect = 6, aura = 42, target = 1 } }
    }, -- Trailseeker Stone of Rage
    [101069] = {
        itemId = 101069,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126660, procId = 126659, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Mountainsage Idol of Destruction
    [101072] = {
        itemId = 101072,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 133631, procId = 133630, effect = 6, aura = 42, target = 1 } }
    }, -- Mountainsage Stone of Destruction
    [101087] = {
        itemId = 101087,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 133631, procId = 133630, effect = 6, aura = 42, target = 1 } }
    }, -- Mistdancer Defender Stone
    [101089] = {
        itemId = 101089,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126237, procId = 126236, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Mistdancer Defender Idol
    [101102] = {
        itemId = 101102,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126468, procId = 126467, effect = 6, aura = 42, basePoints = 100, target = 1 } }
    }, -- Mistdancer Idol of Wisdom
    [101107] = {
        itemId = 101107,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126268, procId = 126266, effect = 6, aura = 42, basePoints = 100, target = 1 } }
    }, -- Mistdancer Stone of Wisdom
    [101113] = {
        itemId = 101113,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126552, procId = 126554, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Mistdancer Idol of Rage
    [101117] = {
        itemId = 101117,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 133631, procId = 133630, effect = 6, aura = 42, target = 1 } }
    }, -- Mistdancer Stone of Rage
    [101135] = {
        itemId = 101135,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126468, procId = 126467, effect = 6, aura = 42, basePoints = 100, target = 1 } }
    }, -- Sunsoul Idol of Wisdom
    [101138] = {
        itemId = 101138,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126268, procId = 126266, effect = 6, aura = 42, basePoints = 100, target = 1 } }
    }, -- Sunsoul Stone of Wisdom
    [101151] = {
        itemId = 101151,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 133631, procId = 133630, effect = 6, aura = 42, target = 1 } }
    }, -- Sunsoul Stone of Battle
    [101152] = {
        itemId = 101152,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126583, procId = 126582, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Sunsoul Idol of Battle
    [101160] = {
        itemId = 101160,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126237, procId = 126236, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Sunsoul Defender Idol
    [101163] = {
        itemId = 101163,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 133631, procId = 133630, effect = 6, aura = 42, target = 1 } }
    }, -- Sunsoul Defender Stone
    [101168] = {
        itemId = 101168,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126660, procId = 126659, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Communal Idol of Destruction
    [101171] = {
        itemId = 101171,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 133631, procId = 133630, effect = 6, aura = 42, target = 1 } }
    }, -- Communal Stone of Destruction
    [101179] = {
        itemId = 101179,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126468, procId = 126467, effect = 6, aura = 42, basePoints = 100, target = 1 } }
    }, -- Communal Idol of Wisdom
    [101183] = {
        itemId = 101183,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126268, procId = 126266, effect = 6, aura = 42, basePoints = 100, target = 1 } }
    }, -- Communal Stone of Wisdom
    [101200] = {
        itemId = 101200,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126552, procId = 126554, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Lightdrinker Idol of Rage
    [101203] = {
        itemId = 101203,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 133631, procId = 133630, effect = 6, aura = 42, target = 1 } }
    }, -- Lightdrinker Stone of Rage
    [101217] = {
        itemId = 101217,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126552, procId = 126554, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Streamtalker Idol of Rage
    [101220] = {
        itemId = 101220,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 133631, procId = 133630, effect = 6, aura = 42, target = 1 } }
    }, -- Streamtalker Stone of Rage
    [101222] = {
        itemId = 101222,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126660, procId = 126659, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Streamtalker Idol of Destruction
    [101225] = {
        itemId = 101225,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 133631, procId = 133630, effect = 6, aura = 42, target = 1 } }
    }, -- Streamtalker Stone of Destruction
    [101247] = {
        itemId = 101247,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126468, procId = 126467, effect = 6, aura = 42, basePoints = 100, target = 1 } }
    }, -- Streamtalker Idol of Wisdom
    [101250] = {
        itemId = 101250,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126268, procId = 126266, effect = 6, aura = 42, basePoints = 100, target = 1 } }
    }, -- Streamtalker Stone of Wisdom
    [101263] = {
        itemId = 101263,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126660, procId = 126659, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Felsoul Idol of Destruction
    [101266] = {
        itemId = 101266,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 133631, procId = 133630, effect = 6, aura = 42, target = 1 } }
    }, -- Felsoul Stone of Destruction
    [101294] = {
        itemId = 101294,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 133631, procId = 133630, effect = 6, aura = 42, target = 1 } }
    }, -- Oathsworn Stone of Battle
    [101295] = {
        itemId = 101295,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126583, procId = 126582, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Oathsworn Idol of Battle
    [101303] = {
        itemId = 101303,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 126237, procId = 126236, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Oathsworn Defender Idol
    [101306] = {
        itemId = 101306,
        itemLevel = 483,
        useEffects = {  },
        procEffects = {             { spellId = 133631, procId = 133630, effect = 6, aura = 42, target = 1 } }
    }, -- Oathsworn Defender Stone
    [102480] = {
        itemId = 102480,
        itemLevel = 522,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Gladiator's Medallion
    [102481] = {
        itemId = 102481,
        itemLevel = 522,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Gladiator's Emblem
    [102483] = {
        itemId = 102483,
        itemLevel = 476,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Crafted Malevolent Gladiator's Medallion of Tenacity
    [102813] = {
        itemId = 102813,
        itemLevel = 522,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Emblem of Meditation
    [102822] = {
        itemId = 102822,
        itemLevel = 522,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Medallion of Meditation
    [102830] = {
        itemId = 102830,
        itemLevel = 522,
        useEffects = {             { spellId = 126683, ICD = 60, effect = 6, aura = 29, basePoints = 2144, miscValue = 3, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Badge of Dominance
    [102833] = {
        itemId = 102833,
        itemLevel = 522,
        useEffects = {             { spellId = 126679, ICD = 60, effect = 6, aura = 29, basePoints = 2144, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Badge of Victory
    [102840] = {
        itemId = 102840,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 126708, procId = 126707, effect = 6, aura = 42, target = 1 } }
    }, -- Grievous Gladiator's Insignia of Conquest
    [102856] = {
        itemId = 102856,
        itemLevel = 522,
        useEffects = {             { spellId = 126690, ICD = 60, effect = 6, aura = 29, basePoints = 2144, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Badge of Conquest
    [102869] = {
        itemId = 102869,
        itemLevel = 522,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Medallion of Tenacity
    [102877] = {
        itemId = 102877,
        itemLevel = 522,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Emblem of Cruelty
    [102896] = {
        itemId = 102896,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 126702, procId = 126700, effect = 6, aura = 42, target = 1 } }
    }, -- Grievous Gladiator's Insignia of Victory
    [102903] = {
        itemId = 102903,
        itemLevel = 522,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Emblem of Tenacity
    [102935] = {
        itemId = 102935,
        itemLevel = 522,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Medallion of Cruelty
    [102963] = {
        itemId = 102963,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 126706, procId = 126705, effect = 6, aura = 42, target = 1 } }
    }, -- Grievous Gladiator's Insignia of Dominance
    [103145] = {
        itemId = 103145,
        itemLevel = 522,
        useEffects = {             { spellId = 126690, ICD = 60, effect = 6, aura = 29, basePoints = 2144, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Badge of Conquest
    [103150] = {
        itemId = 103150,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 126708, procId = 126707, effect = 6, aura = 42, target = 1 } }
    }, -- Grievous Gladiator's Insignia of Conquest
    [103210] = {
        itemId = 103210,
        itemLevel = 522,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Emblem of Cruelty
    [103211] = {
        itemId = 103211,
        itemLevel = 522,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Emblem of Tenacity
    [103212] = {
        itemId = 103212,
        itemLevel = 522,
        useEffects = {             { spellId = 126697, ICD = 120, effect = 6, aura = 250, basePoints = 21608, bonusCoeff = 1.0, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Emblem of Meditation
    [103308] = {
        itemId = 103308,
        itemLevel = 522,
        useEffects = {             { spellId = 126683, ICD = 60, effect = 6, aura = 29, basePoints = 2144, miscValue = 3, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Badge of Dominance
    [103309] = {
        itemId = 103309,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 126706, procId = 126705, effect = 6, aura = 42, target = 1 } }
    }, -- Grievous Gladiator's Insignia of Dominance
    [103314] = {
        itemId = 103314,
        itemLevel = 522,
        useEffects = {             { spellId = 126679, ICD = 60, effect = 6, aura = 29, basePoints = 2144, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Badge of Victory
    [103319] = {
        itemId = 103319,
        itemLevel = 522,
        useEffects = {  },
        procEffects = {             { spellId = 126702, procId = 126700, effect = 6, aura = 42, target = 1 } }
    }, -- Grievous Gladiator's Insignia of Victory
    [103333] = {
        itemId = 103333,
        itemLevel = 522,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Medallion of Tenacity
    [103334] = {
        itemId = 103334,
        itemLevel = 522,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Medallion of Cruelty
    [103335] = {
        itemId = 103335,
        itemLevel = 522,
        useEffects = {             { spellId = 42292, ICD = 120, effect = 6, aura = 77, miscValue = 1, target = 1 } },
        procEffects = {  }
    }, -- Grievous Gladiator's Medallion of Meditation
    [103639] = {
        itemId = 103639,
        itemLevel = 496,
        useEffects = {             { spellId = 148388, ICD = 60, effect = 6, aura = 189, basePoints = 5000, miscValue = 67141632, target = 1 } },
        procEffects = {  }
    }, -- Pouch of White Ash
    [103678] = {
        itemId = 103678,
        itemLevel = 496,
        useEffects = {             { spellId = 145430, ICD = 60, effect = 252, target = 1 } },
        procEffects = {             { spellId = 148446, procId = 148447, effect = 6, aura = 42, basePoints = 100, bonusCoeff = 1.0, target = 1 } }
    }, -- Time-Lost Artifact
    [103686] = {
        itemId = 103686,
        itemLevel = 496,
        useEffects = {  },
        procEffects = {             { spellId = 146313, procId = 146312, effect = 6, aura = 42, target = 1 } }
    }, -- Discipline of Xuen
    [103687] = {
        itemId = 103687,
        itemLevel = 496,
        useEffects = {  },
        procEffects = {             { spellId = 146219, procId = 146218, effect = 6, aura = 42, target = 1 } }
    }, -- Yu'lon's Bite
    [103688] = {
        itemId = 103688,
        itemLevel = 496,
        useEffects = {             { spellId = 146323, ICD = 90, effect = 6, aura = 29, basePoints = 1149, miscValue = 4, target = 1 } },
        procEffects = {  }
    }, -- Contemplation of Chi-Ji
    [103689] = {
        itemId = 103689,
        itemLevel = 496,
        useEffects = {  },
        procEffects = {             { spellId = 146295, procId = 146296, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Alacrity of Xuen
    [103690] = {
        itemId = 103690,
        itemLevel = 496,
        useEffects = {             { spellId = 146344, ICD = 120, effect = 6, aura = 189, basePoints = 1700, miscValue = 4, target = 1 } },
        procEffects = {  }
    }, -- Resolve of Niuzao
    [103986] = {
        itemId = 103986,
        itemLevel = 535,
        useEffects = {  },
        procEffects = {             { spellId = 146313, procId = 146312, effect = 6, aura = 42, target = 1 } }
    }, -- Discipline of Xuen
    [103987] = {
        itemId = 103987,
        itemLevel = 535,
        useEffects = {  },
        procEffects = {             { spellId = 146219, procId = 146218, effect = 6, aura = 42, target = 1 } }
    }, -- Yu'lon's Bite
    [103988] = {
        itemId = 103988,
        itemLevel = 535,
        useEffects = {             { spellId = 146323, ICD = 90, effect = 6, aura = 29, basePoints = 1149, miscValue = 4, target = 1 } },
        procEffects = {  }
    }, -- Contemplation of Chi-Ji
    [103989] = {
        itemId = 103989,
        itemLevel = 535,
        useEffects = {  },
        procEffects = {             { spellId = 146295, procId = 146296, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Alacrity of Xuen
    [103990] = {
        itemId = 103990,
        itemLevel = 535,
        useEffects = {             { spellId = 146344, ICD = 120, effect = 6, aura = 189, basePoints = 1700, miscValue = 4, target = 1 } },
        procEffects = {  }
    }, -- Resolve of Niuzao
    [104298] = {
        itemId = 104298,
        itemLevel = 496,
        useEffects = {             { spellId = 148534, ICD = 120, procId = 148535, effect = 96, target = 6 } },
        procEffects = {  }
    }, -- Ordon Death Chime
    [104313] = {
        itemId = 104313,
        itemLevel = 496,
        useEffects = {  },
        procEffects = {             { spellId = 148558, procId = 148557, effect = 6, aura = 42, target = 1 } }
    }, -- Golden Moss
    [104321] = {
        itemId = 104321,
        itemLevel = 496,
        useEffects = {             { spellId = 148597, ICD = 3600, effect = 28, basePoints = 90, miscValue = 73760, target = 47 } },
        procEffects = {             { spellId = 148596, effect = 6, aura = 4, basePoints = 148599, target = 1 } }
    }, -- Captain Zvezdan's Lost Leg
    [104675] = {
        itemId = 104675,
        itemLevel = 540,
        useEffects = {  },
        procEffects = {             { spellId = 146047, procId = 146046, effect = 6, aura = 42, target = 1 },            { spellId = 146051, effect = 6, aura = 163, basePoints = 1, miscValue = 127, target = 1 } }
    }, -- Purified Bindings of Immerseus
    [104691] = {
        itemId = 104691,
        itemLevel = 540,
        useEffects = {             { spellId = 146343, ICD = 90, effect = 6, aura = 310, basePoints = 2585, miscValue = 4, target = 1 } },
        procEffects = {  }
    }, -- Rook's Unlucky Talisman
    [104712] = {
        itemId = 104712,
        itemLevel = 540,
        useEffects = {  },
        procEffects = {             { spellId = 146136, effect = 6, aura = 4, basePoints = 1, miscValue = 1, target = 1 },            { spellId = 148901, procId = 148899, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Fusion-Fire Core
    [104725] = {
        itemId = 104725,
        itemLevel = 540,
        useEffects = {  },
        procEffects = {             { spellId = 146019, effect = 6, aura = 4, basePoints = 1, miscValue = 1, target = 1 },            { spellId = 146309, procId = 146308, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Assurance of Consequence
    [104727] = {
        itemId = 104727,
        itemLevel = 540,
        useEffects = {  },
        procEffects = {             { spellId = 146315, procId = 146314, effect = 6, aura = 42, basePoints = 35, target = 1 },            { spellId = 146051, effect = 6, aura = 163, basePoints = 1, miscValue = 127, target = 1 } }
    }, -- Prismatic Prison of Pride
    [104744] = {
        itemId = 104744,
        itemLevel = 540,
        useEffects = {  },
        procEffects = {             { spellId = 146247, procId = 146245, effect = 6, aura = 42, basePoints = 35, target = 1 },            { spellId = 145955, effect = 6, aura = 4, basePoints = 1, miscValue = 1, target = 1 } }
    }, -- Evil Eye of Galakras
    [104767] = {
        itemId = 104767,
        itemLevel = 540,
        useEffects = {  },
        procEffects = {             { spellId = 146346, effect = 6, aura = 4, target = 1 } }
    }, -- Juggernaut's Focusing Crystal
    [104780] = {
        itemId = 104780,
        itemLevel = 540,
        useEffects = {  },
        procEffects = {             { spellId = 146059, effect = 6, aura = 4, basePoints = 1, miscValue = 1, target = 1 },            { spellId = 148904, procId = 148903, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Haromm's Talisman
    [104793] = {
        itemId = 104793,
        itemLevel = 540,
        useEffects = {  },
        procEffects = {             { spellId = 146059, effect = 6, aura = 4, basePoints = 1, miscValue = 1, target = 1 },            { spellId = 148907, procId = 148906, effect = 6, aura = 42, target = 1 } }
    }, -- Kardris' Toxic Totem
    [104802] = {
        itemId = 104802,
        itemLevel = 540,
        useEffects = {  },
        procEffects = {             { spellId = 146176, effect = 6, aura = 4, basePoints = 1, miscValue = 1, target = 1 },            { spellId = 148909, procId = 148908, effect = 6, aura = 42, target = 1 } }
    }, -- Nazgrim's Burnished Insignia
    [104821] = {
        itemId = 104821,
        itemLevel = 540,
        useEffects = {  },
        procEffects = {             { spellId = 146025, effect = 6, aura = 4, basePoints = 1, miscValue = 1, target = 1 } }
    }, -- Vial of Living Corruption
    [104825] = {
        itemId = 104825,
        itemLevel = 540,
        useEffects = {  },
        procEffects = {             { spellId = 146136, effect = 6, aura = 4, basePoints = 1, miscValue = 1, target = 1 },            { spellId = 148898, procId = 148897, effect = 6, aura = 42, target = 1 } }
    }, -- Frenzied Crystal of Rage
    [104833] = {
        itemId = 104833,
        itemLevel = 540,
        useEffects = {  },
        procEffects = {             { spellId = 146136, effect = 6, aura = 4, basePoints = 1, miscValue = 1, target = 1 },            { spellId = 148895, procId = 148896, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Sigil of Rampage
    [104860] = {
        itemId = 104860,
        itemLevel = 540,
        useEffects = {  },
        procEffects = {             { spellId = 148233, effect = 6, aura = 4, basePoints = 1, miscValue = 1, target = 1 },            { spellId = 148912, procId = 148911, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Thok's Acid-Grooved Tooth
    [104862] = {
        itemId = 104862,
        itemLevel = 540,
        useEffects = {  },
        procEffects = {             { spellId = 146251, procId = 146250, effect = 6, aura = 42, basePoints = 35, target = 1 },            { spellId = 146051, effect = 6, aura = 163, basePoints = 1, miscValue = 127, target = 1 } }
    }, -- Thok's Tail Tip
    [104865] = {
        itemId = 104865,
        itemLevel = 540,
        useEffects = {  },
        procEffects = {             { spellId = 146311, procId = 146310, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Ticking Ebon Detonator
    [104868] = {
        itemId = 104868,
        itemLevel = 540,
        useEffects = {  },
        procEffects = {             { spellId = 146316, procId = 146317, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Dysmorphic Samophlange of Discontinuity
    [104885] = {
        itemId = 104885,
        itemLevel = 540,
        useEffects = {  },
        procEffects = {             { spellId = 146286, procId = 146285, effect = 6, aura = 42, basePoints = 6, target = 1 } }
    }, -- Skeer's Bloodsoaked Talisman
    [104898] = {
        itemId = 104898,
        itemLevel = 540,
        useEffects = {             { spellId = 146395, ICD = 90, effect = 6, aura = 189, basePoints = 1149, miscValue = 1792, target = 1 } },
        procEffects = {  }
    }, -- Curse of Hubris
    [104901] = {
        itemId = 104901,
        itemLevel = 540,
        useEffects = {  },
        procEffects = {             { spellId = 146183, procId = 146184, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Black Blood of Y'Shaarj
    [104924] = {
        itemId = 104924,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 146047, procId = 146046, effect = 6, aura = 42, target = 1 },            { spellId = 146051, effect = 6, aura = 163, basePoints = 1, miscValue = 127, target = 1 } }
    }, -- Purified Bindings of Immerseus
    [104940] = {
        itemId = 104940,
        itemLevel = 528,
        useEffects = {             { spellId = 146343, ICD = 90, effect = 6, aura = 310, basePoints = 2585, miscValue = 4, target = 1 } },
        procEffects = {  }
    }, -- Rook's Unlucky Talisman
    [104961] = {
        itemId = 104961,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 146136, effect = 6, aura = 4, basePoints = 1, miscValue = 1, target = 1 },            { spellId = 148901, procId = 148899, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Fusion-Fire Core
    [104974] = {
        itemId = 104974,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 146019, effect = 6, aura = 4, basePoints = 1, miscValue = 1, target = 1 },            { spellId = 146309, procId = 146308, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Assurance of Consequence
    [104976] = {
        itemId = 104976,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 146315, procId = 146314, effect = 6, aura = 42, basePoints = 35, target = 1 },            { spellId = 146051, effect = 6, aura = 163, basePoints = 1, miscValue = 127, target = 1 } }
    }, -- Prismatic Prison of Pride
    [104993] = {
        itemId = 104993,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 146247, procId = 146245, effect = 6, aura = 42, basePoints = 35, target = 1 },            { spellId = 145955, effect = 6, aura = 4, basePoints = 1, miscValue = 1, target = 1 } }
    }, -- Evil Eye of Galakras
    [105016] = {
        itemId = 105016,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 146346, effect = 6, aura = 4, target = 1 } }
    }, -- Juggernaut's Focusing Crystal
    [105029] = {
        itemId = 105029,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 146059, effect = 6, aura = 4, basePoints = 1, miscValue = 1, target = 1 },            { spellId = 148904, procId = 148903, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Haromm's Talisman
    [105042] = {
        itemId = 105042,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 146059, effect = 6, aura = 4, basePoints = 1, miscValue = 1, target = 1 },            { spellId = 148907, procId = 148906, effect = 6, aura = 42, target = 1 } }
    }, -- Kardris' Toxic Totem
    [105051] = {
        itemId = 105051,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 146176, effect = 6, aura = 4, basePoints = 1, miscValue = 1, target = 1 },            { spellId = 148909, procId = 148908, effect = 6, aura = 42, target = 1 } }
    }, -- Nazgrim's Burnished Insignia
    [105070] = {
        itemId = 105070,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 146025, effect = 6, aura = 4, basePoints = 1, miscValue = 1, target = 1 } }
    }, -- Vial of Living Corruption
    [105074] = {
        itemId = 105074,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 146136, effect = 6, aura = 4, basePoints = 1, miscValue = 1, target = 1 },            { spellId = 148898, procId = 148897, effect = 6, aura = 42, target = 1 } }
    }, -- Frenzied Crystal of Rage
    [105082] = {
        itemId = 105082,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 146136, effect = 6, aura = 4, basePoints = 1, miscValue = 1, target = 1 },            { spellId = 148895, procId = 148896, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Sigil of Rampage
    [105109] = {
        itemId = 105109,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 148233, effect = 6, aura = 4, basePoints = 1, miscValue = 1, target = 1 },            { spellId = 148912, procId = 148911, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Thok's Acid-Grooved Tooth
    [105111] = {
        itemId = 105111,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 146251, procId = 146250, effect = 6, aura = 42, basePoints = 35, target = 1 },            { spellId = 146051, effect = 6, aura = 163, basePoints = 1, miscValue = 127, target = 1 } }
    }, -- Thok's Tail Tip
    [105114] = {
        itemId = 105114,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 146311, procId = 146310, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Ticking Ebon Detonator
    [105117] = {
        itemId = 105117,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 146316, procId = 146317, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Dysmorphic Samophlange of Discontinuity
    [105134] = {
        itemId = 105134,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 146286, procId = 146285, effect = 6, aura = 42, basePoints = 6, target = 1 } }
    }, -- Skeer's Bloodsoaked Talisman
    [105147] = {
        itemId = 105147,
        itemLevel = 528,
        useEffects = {             { spellId = 146395, ICD = 90, effect = 6, aura = 189, basePoints = 1149, miscValue = 1792, target = 1 } },
        procEffects = {  }
    }, -- Curse of Hubris
    [105150] = {
        itemId = 105150,
        itemLevel = 528,
        useEffects = {  },
        procEffects = {             { spellId = 146183, procId = 146184, effect = 6, aura = 42, basePoints = 35, target = 1 } }
    }, -- Black Blood of Y'Shaarj

}
