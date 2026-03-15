--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)

    This software is provided 'as-is', without any express or implied warranty. In no event will the authors be held
        liable for any damages arising from the use of this software.

    You are free to:
    - Share — copy and redistribute the material in any medium or format
    - Adapt — remix, transform, and build upon the material

    Under the following terms:
    - Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were
        made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or
        your use.
    - NonCommercial — You may not use the material for commercial purposes.

    Full license text: https://creativecommons.org/licenses/by-nc/4.0/legalcode

    Author: Rakizi: farendil2020@gmail.com @rakizi http://discord.gg/ebonhold
    Date: 06/01/2024

    STATUS: Initial implementation
    NOTES: Constants for vanilla WoW consumables, sourced from WoWSims
]]
-- ======= LOCALIZE =======
--Addon
local _, ns = ...
local Version = ns.Version
local AceEvent = ns.AceEvent

if not Version:IsVanilla() then return end

-- Flasks
ns.flasks = {
    13512, -- Flask of Supreme Power
    13510, -- Flask of the Titans
    13511, -- Flask of Distilled Wisdom
    13513, -- Flask of Chromatic Resistance
    2593   -- Flask of Fortification
}

-- Battle Elixirs
ns.battleElixirs = {
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
    6373    -- Elixir of Firepower
}

-- Guardian Elixirs
ns.guardianElixirs = {
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
    20080  -- Sheen of Zanza
}

-- Combine both elixir types for consistency with Cata
ns.elixirs = {}
for _, id in ipairs(ns.battleElixirs) do table.insert(ns.elixirs, id) end
for _, id in ipairs(ns.guardianElixirs) do table.insert(ns.elixirs, id) end

-- Combat Potions
ns.potions = {
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
    215162 -- Mildly Irradiated Rejuvenation Potion (SoD specific)
}

-- Temporary Item Enhancements
ns.temporaryEnhancements = {
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
}

-- Permanent Item Enhancements
ns.permanentEnhancements = {
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
}

-- Combine both enhancement types for consistency with Cata
ns.itemEnhancements = {}
for _, id in ipairs(ns.temporaryEnhancements) do table.insert(ns.itemEnhancements, id) end
for _, id in ipairs(ns.permanentEnhancements) do table.insert(ns.itemEnhancements, id) end

-- Food and Drink
ns.food = {
    13932, -- Smoked Desert Dumplings
    13928, -- Grilled Squid
    13927, -- Cooked Glossy Mightfish
    13934, -- Mightfish Steak
    18254, -- Runn Tum Tuber Surprise
    20452, -- Smoked Desert Dumplings
    20074, -- Heavy Crocolisk Steak
    20031, -- Dirge's Kickin' Chimaerok Chops
    21023  -- Dirge's Kickin' Chimaerok Chops
}

ns.drink = {
    8766, -- Morning Glory Dew
    8078, -- Conjured Crystal Water
    8079, -- Conjured Sparkling Water
    8077, -- Conjured Mineral Water
    8076, -- Conjured Fresh Water
    8075, -- Conjured Water
    19318 -- Blessed Sunfruit Juice
}

-- Scrolls
ns.scrolls = {
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
}

-- Runes
ns.runes = {
    204703, -- Rune of Alacrity
    203991, -- Rune of Arcane Cunning
    204441, -- Rune of Arcane Devastation
    205022, -- Rune of Arcane Finesse
    206032, -- Rune of Arcane Instinct
    204809, -- Rune of Arcane Mastery
    203990, -- Rune of Arcane Might
    204912, -- Rune of Arcane Power
    206169, -- Rune of Arcane Precision
    205683, -- Rune of Arcane Prowess
    204716, -- Rune of Arcane Skill
    205685, -- Rune of Arcane Strength
    205228, -- Rune of Arcane Swiftness
    205979, -- Rune of Arcane Technique
    205897, -- Rune of Arcane Velocity
    204806  -- Rune of Arcane Wisdom
}

-- Register consumables and runes with DataManager after expansion data is ready
local registrar = {}
AceEvent:Embed(registrar)

registrar:RegisterMessage("NAG_EXPANSION_DATA_LOADED", function()
    local DataManager = NAG:GetModule("DataManager")
    NAG:Debug("VanillaConstants: Registering consumables with DataManager")

    -- Flasks
    for _, id in ipairs(ns.flasks) do
        DataManager:AddItem(id, { "Consumable", "Flask" })
    end
    -- Battle Elixirs
    for _, id in ipairs(ns.battleElixirs) do
        DataManager:AddItem(id, { "Consumable", "BattleElixir" })
    end
    -- Guardian Elixirs
    for _, id in ipairs(ns.guardianElixirs) do
        DataManager:AddItem(id, { "Consumable", "GuardianElixir" })
    end
    -- Elixirs (combined)
    for _, id in ipairs(ns.elixirs) do
        DataManager:AddItem(id, { "Consumable", "Elixir" })
    end
    -- Potions
    for _, id in ipairs(ns.potions) do
        DataManager:AddItem(id, { "Consumable", "Potion" })
    end
    -- Temporary Enhancements
    for _, id in ipairs(ns.temporaryEnhancements) do
        DataManager:AddItem(id, { "Consumable", "TempEnhancement" })
    end
    -- Permanent Enhancements
    for _, id in ipairs(ns.permanentEnhancements) do
        DataManager:AddItem(id, { "Consumable", "PermEnhancement" })
    end
    -- Item Enhancements (combined)
    for _, id in ipairs(ns.itemEnhancements) do
        DataManager:AddItem(id, { "Consumable", "Enhancement" })
    end
    -- Food
    for _, id in ipairs(ns.food) do
        DataManager:AddItem(id, { "Consumable", "Food" })
    end
    -- Drink
    for _, id in ipairs(ns.drink) do
        DataManager:AddItem(id, { "Consumable", "Drink" })
    end
    -- Scrolls
    for _, id in ipairs(ns.scrolls) do
        DataManager:AddItem(id, { "Consumable", "Scroll" })
    end
    -- Runes (spells)
    for _, id in ipairs(ns.runes) do
        DataManager:AddSpell(id, { "Consumable", "Rune" })
    end

    registrar:UnregisterMessage("NAG_EXPANSION_DATA_LOADED")
end)
