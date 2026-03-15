local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version

local defaults = ns.InitializeClassDefaults()

-- Wrath Mage spec spell locations
defaults.class.specSpellLocations = {
    [1] = {},  -- Arcane
    [2] = {},  -- Fire
    [3] = {},  -- Frost
}

if UnitClassBase('player') ~= "MAGE" then return end
-- Generic (0 talent points): low-level abilities before choosing a spec
local genericRotation = {
    name = "Generic",
    specIndex = 0,
    class = "MAGE",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[
    -- Maintain Frost Armor (level 1) or Ice Armor if known
    (not NAG:AuraIsActive(168) and not NAG:AuraIsActive(7302)) and NAG:SpellCanCast(168) and NAG:Cast(168)
    or (not NAG:AuraIsActive(7302) and not NAG:AuraIsActive(168)) and NAG:SpellCanCast(7302) and NAG:Cast(7302)
    or (NAG:UnitIsMoving() and NAG:SpellCanCast(2136)) and NAG:Cast(2136)
    or (NAG:SpellCanCast(116)) and NAG:Cast(116)
    or (NAG:SpellCanCast(133)) and NAG:Cast(133)
]],
}

-- Arcane Rotation
local arcaneRotation = {
    -- Core identification
    name = "Arcane",
    specIndex = 1,
    class = "MAGE",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[NAG:Cast(6603)]],
}

-- Fire Rotation
local fireRotation = {
    -- Core identification
    name = "Fire",
    specIndex = 2,
    class = "MAGE",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    -- maybe start with aoe rotation on side
    -- fill aoe in after

    -- maintenance
    -- molten Armor
    -- focus magic
    -- mana gem

    -- autouse cds
    -- crit debuff falling or not active -> scorch
    -- hotstreak > pyro
    -- time remaining > 12s multidot lb x10 no overlap
    -- time remaining < 2s fire blast
    -- time remaining < 5s scorch
    -- cast fireball

    -- Pre-pull actions
    prePull = {
        { time = -15.0, action = "NAG:Cast(30482)" }, -- Molten Armor
        { time = -4.0, action = "NAG:Cast(55342)" }, -- Mirror Image
        { time = -2.5, action = "NAG:Cast(40211)" }, -- potion
        { time = -2.0, action = "NAG:Cast(133)" }, -- Fireball
    },

    lastModified = "12/02/2026",

    -- Rotation Logic
    rotationString = [[

    -- AOE (shown on right)
    --multidot lb
    (NAG:NumberTargetsWithTTD(15, 36) > 1)
        and NAG:Multidot(44457, 10, 0, NAG.SPELL_POSITIONS.RIGHT)
    --max rank flamestrike with firestarter
    or (NAG:NumberTargetsWithTTD(5, 36) > 1 and NAG:AuraIsActive(54741) and NAG:DotLowestRemainingTime(42926) < 1)
        and NAG:CastWithOverlay(42926, "MAX", NAG.SPELL_POSITIONS.RIGHT)
    --MAXRANK-1 FLAMESTRIKE WITH FIRESTARTER
    or (NAG:NumberTargetsWithTTD(5, 36) > 1 and NAG:AuraIsActive(54741) and NAG:DotLowestRemainingTime(42925) < 1)
        and NAG:CastWithOverlay(42925, "-1", NAG.SPELL_POSITIONS.RIGHT)
    --either max or -1 ranks of flamestrike not active > db
    or (NAG:NumberTargetsWithTTD(5, 36) > 1 and (NAG:DotLowestRemainingTime(42926) < 1 or NAG:DotLowestRemainingTime(42925) < 1))
        and NAG:Cast(31661, nil, NAG.SPELL_POSITIONS.RIGHT)
    --either max or -1 ranks of flamestrike not active > bw
    or (NAG:NumberTargetsWithTTD(5, 36) > 1 and (NAG:DotLowestRemainingTime(42926) < 1 or NAG:DotLowestRemainingTime(42925) < 1))
        and NAG:Cast(11113, nil, NAG.SPELL_POSITIONS.RIGHT)
    --not max rank fs active > max rank fs
    or (NAG:NumberTargetsWithTTD(5, 36) > 1 and NAG:DotLowestRemainingTime(42926) < 1)
        and NAG:CastWithOverlay(42926, "MAX", NAG.SPELL_POSITIONS.RIGHT)
    --not fs-1 active > fs-1
    or (NAG:NumberTargetsWithTTD(5, 36) > 1 and NAG:DotLowestRemainingTime(42925) < 1)
        and NAG:CastWithOverlay(42925, "-1", NAG.SPELL_POSITIONS.RIGHT)
    or NAG:NumberTargetsWithTTD(2, 8) > 1
        and NAG:Cast(1449, nil, NAG.SPELL_POSITIONS.RIGHT)


    -- SINGLE TARGET
    -- Maintenance: Molten Armor
    or not NAG:AuraIsActive(30482)
        and NAG:Cast(30482, nil, NAG.SPELL_POSITIONS.ABOVE)

    -- Maintenance: Focus Magic
    or (not NAG:RaidUnitBuffPlayer(54646))
        and NAG:Cast(54646, nil, NAG.SPELL_POSITIONS.ABOVE)

    -- Mana Gem (Use if mana < 80%)
    or (NAG:CurrentManaPercent() < 0.80 and NAG:IsReady(33312))
        and NAG:Cast(33312, nil, NAG.SPELL_POSITIONS.ABOVE)

    -- Auto use CDs (Mirror Image, Combustion, Icy Veins, Trinkets)
    or NAG:SpellCanCast(54758) and NAG:Cast(54758, nil, NAG.SPELL_POSITIONS.LEFT) -- gloves
    or NAG:SpellCanCast(40211) and NAG:Cast(40211, nil, NAG.SPELL_POSITIONS.LEFT) -- potion
    or NAG:SpellCanCast(55342) and NAG:Cast(55342, nil, NAG.SPELL_POSITIONS.LEFT) -- Mirror Image
    or NAG:SpellCanCast(11129) and NAG:Cast(11129, nil, NAG.SPELL_POSITIONS.LEFT) -- Combustion
    or NAG:SpellCanCast(12472) and NAG:Cast(12472, nil, NAG.SPELL_POSITIONS.LEFT) -- Icy Veins
    or NAG:SpellCanCast(20599) and NAG:Cast(20599, nil, NAG.SPELL_POSITIONS.LEFT) -- lionheart

    -- Crit Debuff Maintenance (Improved Scorch / ISB)
    or ((not NAG:DotIsActiveGlobal(22959)) and (not NAG:DotIsActiveGlobal(17800))
        and (NAG:RemainingTime() > 5)
        and NAG:SpellCanCast(2948))
        and NAG:Cast(2948)

    -- Hot Streak -> Pyroblast
    or (NAG:AuraIsActive(48108))
        and NAG:Cast(11366)

    -- Living Bomb
    or (NAG:RemainingTime() > 12
        and NAG:SpellCanCast(44457)
        and not NAG:DotIsActive(44457))
        and NAG:Cast(44457)

    -- End of Fight: Fire Blast (< 2s remaining)
    or (NAG:RemainingTime() < 2 and NAG:SpellCanCast(2136))
        and NAG:Cast(2136)

    -- End of Fight: Scorch (< 5s remaining - faster cast than Fireball)
    or (NAG:RemainingTime() < 5 and NAG:SpellCanCast(2948))
        and NAG:Cast(2948)

    -- Filler: Fireball
    or NAG:Cast(133)
    ]],

    -- Tracked IDs
    spells = {
        30482, -- Molten Armor
        55342, -- Mirror Image
        11129, -- Combustion
        12472, -- Icy Veins
        2948,  -- Scorch
        11366, -- Pyroblast
        44457, -- Living Bomb
        2136,  -- Fire Blast
        133,   -- Fireball
    },
    items = {
        33312, -- Mana Gem (Sapphire)
        40211 -- haste potion
    },
    auras = {
        48108, -- Hot Streak
        22959, -- Imp Scorch Debuff
        17800, -- ISB Debuff
    },
    author = "espi",
}

-- Frostfire Rotation
local frostfireRotation = {
    -- Core identification
    name = "Frostfire",
    specIndex = 2,
    class = "MAGE",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,

    -- Pre-pull actions
    prePull = {
        { time = -15.0, action = "NAG:Cast(30482)" }, -- Molten Armor
        { time = -4.0, action = "NAG:Cast(55342)" }, -- Mirror Image
        { time = -2.5, action = "NAG:Cast(40211)" }, -- potion
        { time = -2.0, action = "NAG:Cast(44614)" }, -- ffb
    },

    lastModified = "12/02/2026",

    -- Rotation Logic
    rotationString = [[

    -- AOE (shown on right)
    --multidot lb
    (NAG:NumberTargetsWithTTD(15, 36) > 1)
        and NAG:Multidot(44457, 10, 0, NAG.SPELL_POSITIONS.RIGHT)
    --max rank flamestrike with firestarter
    or (NAG:NumberTargetsWithTTD(5, 36) > 1 and NAG:AuraIsActive(54741) and NAG:DotLowestRemainingTime(42926) < 1)
        and NAG:CastWithOverlay(42926, "MAX", NAG.SPELL_POSITIONS.RIGHT)
    --MAXRANK-1 FLAMESTRIKE WITH FIRESTARTER
    or (NAG:NumberTargetsWithTTD(5, 36) > 1 and NAG:AuraIsActive(54741) and NAG:DotLowestRemainingTime(42925) < 1)
        and NAG:CastWithOverlay(42925, "-1", NAG.SPELL_POSITIONS.RIGHT)
    --either max or -1 ranks of flamestrike not active > db
    or (NAG:NumberTargetsWithTTD(5, 36) > 1 and (NAG:DotLowestRemainingTime(42926) < 1 or NAG:DotLowestRemainingTime(42925) < 1))
        and NAG:Cast(31661, nil, NAG.SPELL_POSITIONS.RIGHT)
    --either max or -1 ranks of flamestrike not active > bw
    or (NAG:NumberTargetsWithTTD(5, 36) > 1 and (NAG:DotLowestRemainingTime(42926) < 1 or NAG:DotLowestRemainingTime(42925) < 1))
        and NAG:Cast(11113, nil, NAG.SPELL_POSITIONS.RIGHT)
    --not max rank fs active > max rank fs
    or (NAG:NumberTargetsWithTTD(5, 36) > 1 and NAG:DotLowestRemainingTime(42926) < 1)
        and NAG:CastWithOverlay(42926, "MAX", NAG.SPELL_POSITIONS.RIGHT)
    --not fs-1 active > fs-1
    or (NAG:NumberTargetsWithTTD(5, 36) > 1 and NAG:DotLowestRemainingTime(42925) < 1)
        and NAG:CastWithOverlay(42925, "-1", NAG.SPELL_POSITIONS.RIGHT)
    or NAG:NumberTargetsWithTTD(2, 8) > 1
        and NAG:Cast(1449, nil, NAG.SPELL_POSITIONS.RIGHT)


    -- SINGLE TARGET
    -- Maintenance: Molten Armor
    or not NAG:AuraIsActive(30482)
        and NAG:Cast(30482, nil, NAG.SPELL_POSITIONS.ABOVE)

    -- Maintenance: Focus Magic
    or (not NAG:RaidUnitBuffPlayer(54646))
        and NAG:Cast(54646, nil, NAG.SPELL_POSITIONS.ABOVE)

    -- Mana Gem (Use if mana < 80%)
    or (NAG:CurrentManaPercent() < 0.80 and NAG:IsReady(33312))
        and NAG:Cast(33312, nil, NAG.SPELL_POSITIONS.ABOVE)

    -- Auto use CDs (Mirror Image, Combustion, Icy Veins, Trinkets)
    or NAG:SpellCanCast(54758) and NAG:Cast(54758, nil, NAG.SPELL_POSITIONS.LEFT) -- gloves
    or NAG:SpellCanCast(40211) and NAG:Cast(40211, nil, NAG.SPELL_POSITIONS.LEFT) -- potion
    or NAG:SpellCanCast(55342) and NAG:Cast(55342, nil, NAG.SPELL_POSITIONS.LEFT) -- Mirror Image
    or NAG:SpellCanCast(11129) and NAG:Cast(11129, nil, NAG.SPELL_POSITIONS.LEFT) -- Combustion
    or NAG:SpellCanCast(12472) and NAG:Cast(12472, nil, NAG.SPELL_POSITIONS.LEFT) -- Icy Veins
    or NAG:SpellCanCast(20599) and NAG:Cast(20599, nil, NAG.SPELL_POSITIONS.LEFT) -- lionheart

    -- Crit Debuff Maintenance (Improved Scorch / ISB)
    or ((not NAG:DotIsActiveGlobal(22959)) and (not NAG:DotIsActiveGlobal(17800))
        and (NAG:RemainingTime() > 5)
        and NAG:SpellCanCast(2948))
        and NAG:Cast(2948)

    -- Hot Streak -> Pyroblast
    or (NAG:AuraIsActive(48108))
        and NAG:Cast(11366)

    -- Living Bomb
    or (NAG:RemainingTime() > 12
        and NAG:SpellCanCast(44457)
        and not NAG:DotIsActive(44457))
        and NAG:Cast(44457)

    -- End of Fight: Fire Blast (< 2s remaining)
    or (NAG:RemainingTime() < 2 and NAG:SpellCanCast(2136))
        and NAG:Cast(2136)

    -- End of Fight: Scorch (< 5s remaining - faster cast than Fireball)
    or (NAG:RemainingTime() < 5 and NAG:SpellCanCast(2948))
        and NAG:Cast(2948)

    -- Filler: ffb
    or NAG:Cast(44614)
    ]],

    -- Tracked IDs
    spells = {
        30482, -- Molten Armor
        55342, -- Mirror Image
        11129, -- Combustion
        12472, -- Icy Veins
        2948,  -- Scorch
        11366, -- Pyroblast
        44457, -- Living Bomb
        2136,  -- Fire Blast
        44614,   -- ffb
    },
    items = {
        33312, -- Mana Gem (Sapphire)
        40211 -- haste potion
    },
    auras = {
        48108, -- Hot Streak
        22959, -- Imp Scorch Debuff
        17800, -- Shadow and Flame Debuff
    },
    author = "espi",
}

-- Frost Rotation - Frostbolt spec
local frostRotationFrostbolt = {
    -- Core identification
    name = "Frost Mage - Frostbolt",
    specIndex = 3,
    class = "MAGE",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    -- maintenance
    -- molten Armor
    -- pet
    -- focus magic
    -- mana gem

    -- autouse cds
    -- if no veins use berserking
    -- if veins and deep on cd use snap
    -- if 2xfof and brain freeze -> ffb
    -- if 2xfof ->deep
    -- if 2xfof -> frostbolt
    -- if 1xfof and brain freeze -> fb>ffb
    -- if 1xfof and deep freeze rdy -> fb>deep
    -- if 1xfof -> fb>lance
    -- if brainfreeze -> ffb
    -- if mana < 25% -> evo
    -- frostbolt

    -- Pre-pull actions
    prePull = {
        { time = -15.0, action = "NAG:Cast(30482)" }, -- Molten Armor
        { time = -4.0, action = "NAG:Cast(55342)" }, -- Mirror Image
        { time = -2.5, action = "NAG:Cast(40212)" }, -- potion
        { time = -2.0, action = "NAG:Cast(116)" }, -- fb
    },

    lastModified = "12/02/2026",

    -- Rotation Logic
    rotationString = [[

    -- AOE (shown on right)
    -- blizzard
    (NAG:NumberTargetsWithTTD(5, 30) > 2)
        and NAG:Cast(10, nil, NAG.SPELL_POSITIONS.RIGHT)


    -- SINGLE TARGET
    -- Maintenance: Molten Armor
    or not NAG:AuraIsActive(30482)
        and NAG:Cast(30482, nil, NAG.SPELL_POSITIONS.ABOVE)

    -- Maintenance: Focus Magic
    or (not NAG:RaidUnitBuffPlayer(54646))
        and NAG:Cast(54646, nil, NAG.SPELL_POSITIONS.ABOVE)

    -- Mana Gem (Use if mana < 80%)
    or (NAG:CurrentManaPercent() < 0.80 and NAG:IsReady(33312))
        and NAG:Cast(33312, nil, NAG.SPELL_POSITIONS.ABOVE)

    -- Auto use CDs (Mirror Image, Combustion, Icy Veins, Trinkets)
    or NAG:SpellCanCast(54758) and NAG:Cast(54758, nil, NAG.SPELL_POSITIONS.LEFT) -- gloves
    or NAG:SpellCanCast(40211) and NAG:Cast(40211, nil, NAG.SPELL_POSITIONS.LEFT) -- potion
    or NAG:SpellCanCast(55342) and NAG:Cast(55342, nil, NAG.SPELL_POSITIONS.LEFT) -- Mirror Image
    or NAG:SpellCanCast(12472) and NAG:Cast(12472, nil, NAG.SPELL_POSITIONS.LEFT) -- Icy Veins
    or (NAG:SpellCanCast(26297) and NAG:AuraIsInactive(12472)) and NAG:Cast(26297, nil, NAG.SPELL_POSITIONS.LEFT) -- berserking
    or NAG:SpellCanCast(20599) and NAG:Cast(20599, nil, NAG.SPELL_POSITIONS.LEFT) -- lionheart
    or (NAG:SpellCanCast(11958) and (not NAG:SpellCanCast(12472) and not NAG:SpellCanCast(44572))) and NAG:Cast(11958, nil, NAG.SPELL_POSITIONS.LEFT) -- berserking


    -- if 2xfof and brain freeze -> ffb
    or (NAG:AuraIsActive(44544) and NAG:AuraNumStacks(44544) == 2 and NAG:AuraIsActive(57761))
        and NAG:Cast(44614)
    -- if 2xfof ->deep
    or (NAG:AuraIsActive(44544) and NAG:AuraNumStacks(44544) == 2)
        and NAG:Cast(44572)
    -- if 2xfof -> frostbolt
    or (NAG:AuraIsActive(44544) and NAG:AuraNumStacks(44544) == 2)
        and NAG:Cast(116)
    -- if 1xfof and brain freeze -> fb>ffb
    or (NAG:AuraIsActive(44544) and NAG:AuraNumStacks(44544) == 1)
        and NAG:StrictSequence("fb>ffb", 116, 44614)
    -- if 1xfof and deep freeze rdy -> fb>deep
    or (NAG:AuraIsActive(44544) and NAG:AuraNumStacks(44544) == 1 and NAG:SpellCanCast(44572))
        and NAG:StrictSequence("fb>df", 116, 44572)
    -- if 1xfof -> fb>lance
    or (NAG:AuraIsActive(44544) and NAG:AuraNumStacks(44544) == 1)
        and NAG:StrictSequence("fb>lance", 116, 30455)
    -- if brainfreeze -> ffb
    or (NAG:AuraIsActive(57761))
        and NAG:Cast(44614)
    -- if mana < 25% -> evo
    or (NAG:CurrentManaPercent() < 0.25 and NAG:IsReady(12051))
        and NAG:Cast(12051, nil, NAG.SPELL_POSITIONS.ABOVE)
    -- frostbolt filler
    or NAG:Cast(116)
    ]],

    author = "espi",


}

-- Frost Rotation - Frozen orb spec
local frostRotationFrozenOrb = {
    -- Core identification
    name = "Frost Mage - Frozen Orb",
    specIndex = 3,
    class = "MAGE",
    default = false,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    -- maintenance
    -- molten Armor
    -- pet
    -- focus magic
    -- mana gem

    -- autouse cds
    -- if no veins use berserking
    -- if fof active -> deep
    -- cast nova
    -- cast coc
    -- cast frozen orb
    -- if mana < 25% evo

    prePull = {
        { time = -15.0, action = "NAG:Cast(30482)" }, -- Molten Armor
        { time = -4.0, action = "NAG:Cast(55342)" }, -- Mirror Image
        { time = -1, action = "NAG:Cast(40212)" }, -- potion
    },

    lastModified = "12/02/2026",

    -- Rotation Logic
    rotationString = [[

    -- SINGLE TARGET
    -- Maintenance: Molten Armor
    not NAG:AuraIsActive(30482)
        and NAG:Cast(30482, nil, NAG.SPELL_POSITIONS.ABOVE)

    -- Maintenance: Focus Magic
    or (not NAG:RaidUnitBuffPlayer(54646))
        and NAG:Cast(54646, nil, NAG.SPELL_POSITIONS.ABOVE)

    -- Mana Gem (Use if mana < 80%)
    or (NAG:CurrentManaPercent() < 0.80 and NAG:IsReady(33312))
        and NAG:Cast(33312, nil, NAG.SPELL_POSITIONS.ABOVE)

    -- Auto use CDs (Mirror Image, Combustion, Icy Veins, Trinkets)
    or NAG:SpellCanCast(54758) and NAG:Cast(54758, nil, NAG.SPELL_POSITIONS.LEFT) -- gloves
    or NAG:SpellCanCast(40211) and NAG:Cast(40211, nil, NAG.SPELL_POSITIONS.LEFT) -- potion
    or NAG:SpellCanCast(55342) and NAG:Cast(55342, nil, NAG.SPELL_POSITIONS.LEFT) -- Mirror Image
    or NAG:SpellCanCast(12472) and NAG:Cast(12472, nil, NAG.SPELL_POSITIONS.LEFT) -- Icy Veins
    or (NAG:SpellCanCast(26297) and NAG:AuraIsInactive(12472)) and NAG:Cast(26297, nil, NAG.SPELL_POSITIONS.LEFT) -- berserking
    or NAG:SpellCanCast(20599) and NAG:Cast(20599, nil, NAG.SPELL_POSITIONS.LEFT) -- lionheart
    or (NAG:SpellCanCast(11958) and (not NAG:SpellCanCast(12472) and not NAG:SpellCanCast(44572))) and NAG:Cast(11958, nil, NAG.SPELL_POSITIONS.LEFT) -- berserking

    -- if fof active -> deep
    or (NAG:AuraIsActive(44544))
        and NAG:Cast(44572)
    -- cast nova
    or NAG:Cast(122)
    -- cast coc
    or NAG:Cast(120)
    -- cast frozen orb
    or NAG:Cast(1284421)
    -- if mana < 25% evo
    or NAG:Cast(12051)

    ]],

    author = "espi",


}

--- @class Mage : ClassBase
local Mage = NAG:CreateClassModule("MAGE", defaults)
if not Mage then return end

function Mage:SetupClassDefaults()

    ns.AddRotationToDefaults(self.defaults, 0, genericRotation)  -- Generic (no spec)
    ns.AddRotationToDefaults(self.defaults, 1, arcaneRotation)  -- Arcane
    ns.AddRotationToDefaults(self.defaults, 2, fireRotation)  -- Fire
    ns.AddRotationToDefaults(self.defaults, 2, frostfireRotation)  -- Frostfire
    ns.AddRotationToDefaults(self.defaults, 3, frostRotationFrostbolt)  -- Frost
    ns.AddRotationToDefaults(self.defaults, 3, frostRotationFrozenOrb)  -- Frost
end

NAG.Class = Mage
