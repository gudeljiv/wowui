local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
local UnitAffectingCombat = _G.UnitAffectingCombat
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
--- @type SpellTrackingManager|AceModule|CoreModule


local defaults = ns.InitializeClassDefaults()

-- MoP Mage spec spell locations
defaults.class.specSpellLocations = {
    [1] = { -- Arcane
        -- ABOVE spells
        [116011] = NAG.SPELL_POSITIONS.ABOVE,   -- Rune of Power (maintenance, avoid blocking rotation)
        [108839] = NAG.SPELL_POSITIONS.ABOVE,   -- Ice Floes

        -- BELOW spells
        -- (empty)

        -- RIGHT spells
        [2136] = NAG.SPELL_POSITIONS.RIGHT,     -- Fire Blast

        -- LEFT spells
        [55342] = NAG.SPELL_POSITIONS.LEFT,     -- Mirror Image
        --[12051] = NAG.SPELL_POSITIONS.LEFT,     -- Evocation
        [82731] = NAG.SPELL_POSITIONS.LEFT,     -- Flame Orb
        [12042] = NAG.SPELL_POSITIONS.LEFT,     -- Arcane Power
        [12043] = NAG.SPELL_POSITIONS.LEFT,     -- Presence of Mind
        [26297] = NAG.SPELL_POSITIONS.LEFT,     -- Berserking
        [33702] = NAG.SPELL_POSITIONS.LEFT,     -- Blood Fury

        -- AOE spells
        -- (empty)
    },
    [2] = { -- Fire
        -- ABOVE spells
        [116011] = NAG.SPELL_POSITIONS.ABOVE,   -- Rune of Power (maintenance, avoid blocking rotation)
        [11129] = NAG.SPELL_POSITIONS.ABOVE,    -- Combustion
        [108839] = NAG.SPELL_POSITIONS.ABOVE,   -- Ice Floes

        -- BELOW spells
        -- (empty)

        -- RIGHT spells
        [2136] = NAG.SPELL_POSITIONS.RIGHT,     -- Fire Blast

        -- LEFT spells
        [55342] = NAG.SPELL_POSITIONS.LEFT,     -- Mirror Image
        [12051] = NAG.SPELL_POSITIONS.LEFT,     -- Evocation
        [82731] = NAG.SPELL_POSITIONS.LEFT,     -- Flame Orb
        [12042] = NAG.SPELL_POSITIONS.LEFT,     -- Arcane Power
        [12043] = NAG.SPELL_POSITIONS.LEFT,     -- Presence of Mind
        [26297] = NAG.SPELL_POSITIONS.LEFT,     -- Berserking
        [33702] = NAG.SPELL_POSITIONS.LEFT,     -- Blood Fury

        -- AOE spells
        -- (empty)
    },
    [3] = { -- Frost
        -- ABOVE spells
        [116011] = NAG.SPELL_POSITIONS.ABOVE,   -- Rune of Power (maintenance, avoid blocking rotation)
        [108839] = NAG.SPELL_POSITIONS.ABOVE,   -- Ice Floes

        -- BELOW spells
        [2136] = NAG.SPELL_POSITIONS.BELOW,     -- Fire Blast

        -- RIGHT spells
        -- (empty)

        -- LEFT spells
        [84714] = NAG.SPELL_POSITIONS.LEFT,     -- Frozen Orb
        [12472] = NAG.SPELL_POSITIONS.LEFT,     -- Icy Veins
        [55342] = NAG.SPELL_POSITIONS.LEFT,     -- Mirror Image
        --[12051] = NAG.SPELL_POSITIONS.LEFT,     -- Evocation
        [82731] = NAG.SPELL_POSITIONS.LEFT,     -- Flame Orb
        [12042] = NAG.SPELL_POSITIONS.LEFT,     -- Arcane Power
        [12043] = NAG.SPELL_POSITIONS.LEFT,     -- Presence of Mind
        [26297] = NAG.SPELL_POSITIONS.LEFT,     -- Berserking
        [33702] = NAG.SPELL_POSITIONS.LEFT,     -- Blood Fury

        -- AOE spells
        -- (empty)
    }
}

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
-- Leave below as is

if UnitClassBase('player') ~= "MAGE" then return end

-- Generic (0 spec / no spec selected): low-level abilities before choosing a spec
local genericRotation = {
    name = "Generic",
    specIndex = 0,
    class = "MAGE",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    rotationString = [[
    -- Maintain Frost Armor (7302) or Ice Armor (36881) if known
    (not NAG:AuraIsActive(7302) and not NAG:AuraIsActive(36881)) and NAG:SpellCanCast(7302) and NAG:Cast(7302)
    or (not NAG:AuraIsActive(36881) and not NAG:AuraIsActive(7302)) and NAG:SpellCanCast(36881) and NAG:Cast(36881)
    or (NAG:UnitIsMoving() and NAG:SpellCanCast(2136)) and NAG:Cast(2136)
    or (NAG:SpellCanCast(116)) and NAG:Cast(116)
    or (NAG:SpellCanCast(133)) and NAG:Cast(133)
]],
}

-- --[[
-- local arcaneAOERotation = {
--     -- Core identification
--     name = "Arcane AOE - by Fonsas",

--     -- Required parameters
--     default = false,
--     enabled = true,
--     experimental = false,
--     gameType = Version.GAME_TYPES.CLASSIC_MISTS,
--     prePull = {
--         { time = -15.0, action = "NAG:Cast(7302)" },
--         { time = -6.5, action = "NAG:Cast(55342)" },
--         { time = -5.0, action = "NAG:Cast(12051)" },
--         { time = -4.0, action = "NAG:Cast(116011)" },
--         { time = -1.9, action = "NAG:Cast(76093)" },
--         { time = -1.9, action = "NAG:Cast(30451)" }
--     },
-- or not(UnitAffectingCombat("player")) and not NAG:SpellIsKnown(116011) and NAG:StrictSequence("someName932", false, 55342, 44457)
-- or (NAG:SpellIsKnown(116011) and (NAG:AuraIsInactive(116011) or (NAG:AuraRemainingTime(116011) <= NAG:SpellCastTime(116011)))) and NAG:Cast(116011)
--     or ((not NAG:DotIsActive(44457)) and NAG:Cast(44457))
--     or ((((NAG:RemainingTime() >= (NAG:DotTickFrequency(44457) * 3)))) and ((NAG:DotIsActive(44457) and NAG:ShouldMultidot(44457, 3, NAG:DotTickFrequency(44457))) and NAG:Cast(44457, nil, NAG.SPELL_POSITIONS.RIGHT)))
--     or NAG:ShouldMultidot(114923, 5, 0.1) and NAG:Cast(114923)
--     or NAG:AuraIsInactive(112948, "target") and NAG:Cast(112948)
--     or ((NAG:AuraNumStacks(36032) == 4) and (NAG:AuraNumStacks(79683) >= 1)) and NAG:Cast(26297)
--     or ((NAG:AuraNumStacks(36032) == 4) and (NAG:AuraNumStacks(79683) >= 1)) and NAG:Cast(33697)
--     or ((NAG:AuraNumStacks(36032) == 4) and (NAG:AuraNumStacks(79683) >= 1)) and NAG:Cast(12042)
--     or ((NAG:AuraNumStacks(36032) == 4) and (NAG:AuraNumStacks(79683) >= 1) and NAG:AuraIsActive(12042)) and NAG:Cast(76093)
--     or ((NAG:AuraNumStacks(36032) == 4) and (NAG:AuraNumStacks(79683) >= 1)) and NAG:Cast(126734)
--     or NAG:AutocastOtherCooldowns()
--     or ((NAG:AuraNumStacks(36032) == 4) and (NAG:AuraNumStacks(79683) >= 1) and NAG:AuraIsActive(12042)) and NAG:Cast(108978)
--     or ((NAG:AuraNumStacks(36032) == 4) and (NAG:AuraNumStacks(79683) == 2)) and NAG:Cast(7268)
--     or ((NAG:RemainingTime() <= NAG:SpellCastTime(30451)) and (NAG:RemainingTime() > NAG:SpellTravelTime(44425))) and NAG:Cast(44425)
--     or ((NAG:RemainingTime() <= NAG:SpellCastTime(30451)) and (NAG:RemainingTime() <= NAG:SpellTravelTime(44425))) and NAG:Cast(2136)
--     or ((NAG:RemainingTime() <= 25.0) and NAG:AuraIsInactive(79683)) and NAG:Cast(30451)
--     or ((NAG:RemainingTime() <= 25.0) and NAG:AuraIsActive(79683)) and NAG:Cast(7268)
--     or ((NAG:AuraNumStacks(36032) == 4) and (NAG:AuraNumStacks(79683) == 1) and (NAG:CurrentManaPercent() >= 0.95)) and NAG:Cast(30451)
--     or ((NAG:AuraNumStacks(36032) == 4) and (NAG:AuraNumStacks(79683) == 1) and (NAG:CurrentManaPercent() < 0.95)) and NAG:Cast(7268)
--     or ((NAG:AuraNumStacks(36032) == 4) and (NAG:AuraNumStacks(79683) == 0) and (NAG:AuraRemainingTime(108978) > NAG:SpellCastTime(30451))) and NAG:Cast(30451)
--     or ((NAG:AuraRemainingTime(108978) <= NAG:SpellCastTime(30451)) and NAG:AuraIsActive(108978)) and NAG:Cast(44425)
--     or ((NAG:AuraNumStacks(36032) == 4) and (NAG:AuraNumStacks(79683) == 0) and (NAG:CurrentManaPercent() >= 0.95)) and NAG:Cast(30451)
--     or ((NAG:AuraNumStacks(36032) == 4) and (NAG:AuraNumStacks(79683) == 0) and (NAG:CurrentManaPercent() < 0.9)) and NAG:Cast(44425)
--     or ((NAG:AuraNumStacks(36032) <= 3) and (NAG:AuraNumStacks(79683) == 2)) and NAG:Cast(7268)
--     or NAG:Cast(30451)

--     ]],


--     -- Tracked IDs for optimization
--     spells = {2136, 7268, 12042, 12051, 26297, 30451, 33697, 36032, 44425, 44457, 79683, 108839, 108978, 112948, 114923, 116011, 116257, 126734},
--     items = {36799, 76093},
--     auras = {},
--     runes = {},

--     -- Optional metadata
--     glyphs = {44955, 42748, 42738, 42743, 63416, 45739},
--     lastModified = "07/25/2025",
--     author = "Fonsas",

-- }
-- --]]

local arcaneSTRotation = {
        -- Core identification
        name = "Single Target Arcane",
        specIndex = 1,
        class = "MAGE",

        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        prePull = {
            { time = -15.0, action = "NAG:Cast(7302)" },
            { time = -6.5, action = "NAG:Cast(55342)" },
            { time = -5.0, action = "NAG:Cast(12051)" },
            { time = -4.0, action = "NAG:Cast(116011)" },
            { time = -1.9, action = "NAG:Cast(76093)" },
            { time = -1.9, action = "NAG:Cast(30451)" }
        },
        lastModified = "08/17/2025",
        rotationString = [[
    not (NAG:AuraIsActive(61316) or NAG:AuraIsActive(1459)) and NAG:Cast(1459)
    or not NAG:AuraIsActive(7302) and NAG:Cast(7302)
    or not(UnitAffectingCombat("player")) and NAG:SpellIsKnown(116011) and not NAG:AuraIsActive(116014) and NAG:StrictSequence("prepullArcane", false, 55342, 116011, 30451, 44457)
    or NAG:UnitIsMoving() and UnitAffectingCombat("player") and NAG:Cast(108839)
    or (NAG:SpellIsKnown(116011) and UnitAffectingCombat("player") and ( not NAG:AuraIsActive(116014) and not NAG:UnitIsMoving())) and NAG:Cast(116011, nil, NAG.SPELL_POSITIONS.PRIMARY)
    or (NAG:SpellIsKnown(116011) and not NAG:AuraIsActive(116014)) and NAG:Cast(116011)
    or (NAG:SpellIsKnown(44457) and ((not NAG:DotIsActive(44457)) or (NAG:AuraRemainingTime(44457, "target") <= NAG:DotTickFrequency(44457)))) and NAG:AuraIsInactive(108978) and NAG:Cast(44457)
    or (NAG:SpellIsKnown(114923) and ((not NAG:DotIsActive(114923)) or (NAG:AuraRemainingTime(114923, "target") <= NAG:DotTickFrequency(114923)))) and NAG:AuraIsInactive(108978) and NAG:Cast(114923)
    or (NAG:SpellIsKnown(112948) and NAG:AuraIsInactive(112948, "target")) and NAG:Cast(112948)
    or ((NAG:AuraNumStacks(36032) == 4) and (NAG:AuraNumStacks(79683) >= 1) and NAG:SpellIsReady(26297)) and NAG:Cast(26297, nil, NAG.SPELL_POSITIONS.LEFT)
    or ((NAG:AuraNumStacks(36032) == 4) and (NAG:AuraNumStacks(79683) >= 1) and NAG:SpellIsReady(33697)) and NAG:Cast(33697, nil, NAG.SPELL_POSITIONS.LEFT)
    or ((NAG:AuraNumStacks(36032) == 4) and (NAG:AuraNumStacks(79683) >= 1) and NAG:SpellIsReady(126734)) and NAG:Cast(126734, nil, NAG.SPELL_POSITIONS.LEFT)
    or ((NAG:AuraNumStacks(36032) == 4) and (NAG:AuraNumStacks(79683) >= 1) and NAG:SpellIsReady(12042)) and NAG:Cast(12042, nil, NAG.SPELL_POSITIONS.LEFT)
    or ((NAG:AuraNumStacks(36032) == 4) and (NAG:AuraNumStacks(79683) >= 1) and NAG:AuraIsActive(12042) and NAG:SpellIsReady(108978)) and NAG:Cast(108978, nil, NAG.SPELL_POSITIONS.LEFT)
    or ((NAG:AuraNumStacks(36032) == 4) and (NAG:AuraNumStacks(79683) == 0) and (NAG:AuraRemainingTime(108978) > NAG:SpellCastTime(30451))) and NAG:Cast(30451)
    or ((NAG:AuraRemainingTime(108978) <= NAG:SpellCastTime(30451)) and NAG:AuraIsActive(108978)) and NAG:Cast(44425)
    or ((NAG:RemainingTime() <= 25.0) and NAG:AuraIsInactive(79683)) and NAG:Cast(30451)
    or ((NAG:RemainingTime() <= 25.0) and NAG:AuraIsActive(79683)) and NAG:Cast(5143)
    or ((NAG:AuraNumStacks(36032) == 3) and (NAG:SpellIsCasting(30451) or NAG:SpellIsCasting(5143)) and (NAG:AuraNumStacks(79683) == 1)) and NAG:Cast(5143)
    or ((NAG:AuraNumStacks(36032) == 3) and (NAG:SpellIsCasting(30451) or NAG:SpellIsCasting(5143)) and (NAG:AuraNumStacks(79683) == 0) and (NAG:CurrentManaPercent() > 95)) and NAG:Cast(30451)
    or ((NAG:AuraNumStacks(36032) == 3) and (NAG:SpellIsCasting(30451) or NAG:SpellIsCasting(5143)) and (NAG:AuraNumStacks(79683) == 0) and (NAG:CurrentManaPercent() <= 90)) and NAG:Cast(44425)
    or ((NAG:RemainingTime() <= NAG:SpellCastTime(30451)) and (NAG:RemainingTime() > NAG:SpellTravelTime(44425))) and NAG:Cast(44425)
    or ((NAG:AuraNumStacks(36032) == 4) and (NAG:AuraNumStacks(79683) == 2)) and NAG:Cast(5143)
    or ((NAG:AuraNumStacks(36032) == 4) and (NAG:AuraNumStacks(79683) == 1) and (NAG:CurrentManaPercent() > 90)) and NAG:Cast(30451)
    or ((NAG:AuraNumStacks(36032) == 4) and (NAG:AuraNumStacks(79683) == 1) and (NAG:CurrentManaPercent() <= 90)) and NAG:Cast(5143)
    or ((NAG:AuraNumStacks(36032) == 4) and (NAG:AuraNumStacks(79683) == 0) and (NAG:CurrentManaPercent() > 92)) and NAG:Cast(30451)
    or ((NAG:AuraNumStacks(36032) == 4) and (NAG:AuraNumStacks(79683) == 0) and (NAG:CurrentManaPercent() <= 92)) and NAG:Cast(44425)
    or ((NAG:RemainingTime() <= NAG:SpellCastTime(30451)) and (NAG:RemainingTime() > NAG:SpellTravelTime(44425))) and NAG:Cast(44425)
    or ((NAG:AuraNumStacks(36032) <= 3) and (NAG:AuraNumStacks(79683) == 2)) and NAG:Cast(5143)
    or NAG:Cast(30451)
        ]],


        -- Tracked IDs for optimization
        spells = {5143, 12042, 26297, 30451, 33697, 36032, 44425, 44457, 79683, 108839, 108978, 112948, 114923, 116011, 116014, 126734},
        items = {36799, 76093, 126734},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {44955, 42748, 42738, 42743, 63416, 45739},
        author = "Saji"

    }



    local fireSTRotation = {
        -- Core identification
        name = "Single Target Fire - by Saji",
        specIndex = 2,
        class = "MAGE",

        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        prePull = {
            { time = -15.0, action = "NAG:Cast(7302)" },
            { time = -6.5, action = "NAG:Cast(55342)" },
            { time = -5.0, action = "NAG:Cast(12051)" },
            { time = -4.0, action = "NAG:Cast(116011)" },
            { time = -1.9, action = "NAG:Cast(76093)" },
            { time = -1.9, action = "NAG:Cast(30451)" }
        },
        rotationString = [[
        not (NAG:AuraIsActive(61316) or NAG:AuraIsActive(1459)) and NAG:Cast(1459) -- Arcane Intellect (Cast 1459)
        or not NAG:AuraIsActive(30482) and NAG:Cast(30482) -- Molten Armor (Cast 30482)
        or NAG:UnitIsMoving() and UnitAffectingCombat("player") and NAG:Cast(2948, nil, NAG.SPELL_POSITIONS.ABOVE) -- Scorch (Cast 2948) (used while moving, ABOVE)
        or (not NAG:SpellIsKnown(116011) and not NAG:AuraIsActive(116257) and not NAG:UnitIsMoving()) and NAG:Cast(12051) -- Evocation (Cast 12051)
        or (not NAG:SpellIsKnown(116011) and UnitAffectingCombat("player") and (NAG:AuraRemainingTime(116257) <= NAG:SpellCastTime(133)) and not NAG:UnitIsMoving()) and NAG:Cast(12051) -- Evocation (Cast 12051)
        or (NAG:SpellIsKnown(116011) and ( not NAG:AuraIsActive(116011) and not NAG:UnitIsMoving())) and NAG:Cast(116011, nil, NAG.SPELL_POSITIONS.PRIMARY) -- Rune of Power (Cast 116011)
        or (NAG:SpellIsKnown(116011) and UnitAffectingCombat("player") and ( (NAG:TotemRemainingTime(1) or NAG:TotemRemainingTime(2)) <= NAG:SpellCastTime(133) and not NAG:UnitIsMoving())) and NAG:Cast(116011) -- Rune of Power (Cast 116011)
        or not UnitAffectingCombat("player") and NAG:Cast(11366) -- Pyroblast (Cast 11366) (precombat)
        or UnitAffectingCombat("player") and NAG:SpellIsReady(55342) and NAG:Cast(55342) -- Mirror Image (Cast 55342)
        or (NAG:SpellIsReady(108978) and NAG:AuraIsActive(48108) and NAG:AuraIsActive(48107)) and NAG:Cast(76093) -- Use item/ability 76093 (Cast 76093)
        or (NAG:SpellIsReady(11129) and NAG:MageCurrentCombustionDotEstimate() >= 200000) and NAG:Cast(11129) -- Combustion (Cast 11129)
        or (NAG:AuraIsActive(48108) and NAG:AuraIsActive(48107) and NAG:SpellIsReady(108978)) and NAG:StrictSequence("fireCooldowns", false, 26297, 12043, 126734, 108978, 11366) -- Cooldown sequence (26297,12043,126734,108978,11366)
        or (NAG:AuraIsActive(108978) and (NAG:AuraIsActive(48108) or NAG:AuraIsActive(12043))) and NAG:Cast(11366) -- Pyroblast (Cast 11366) (during Alter Time / procs)
        or NAG:AuraIsActive(12043) and NAG:Cast(11366) -- Pyroblast (Cast 11366) (Presence of Mind)
        or (NAG:AuraIsActive(108978) and not NAG:AuraIsActive(48108) and not NAG:AuraIsActive(12043)) and NAG:StrictSequence("alterTimeSeq", false, 108978, 11366, 11366) -- Alter Time sequence (108978 then 11366 x2)
        or (not NAG:AuraIsActive(108978) and (NAG:AuraIsActive(48108) or NAG:AuraIsActive(12043)) and NAG:SpellTimeToReady(108978) >= 172) and NAG:Cast(11366) -- Pyroblast (Cast 11366) (if Alter Time far off but procs active)
        or (NAG:SpellTimeToReady(108978) >= 55) and NAG:Cast(126734) -- Use item/trinket (Cast 126734)
        or (NAG:MageCurrentCombustionDotEstimate() >= 1500000 or (not NAG:AuraIsActive(108978) and not NAG:SpellIsReady(108978) and NAG:SpellTimeToReady(108978) >= 45 and NAG:SpellTimeToReady(108978) <= 173 and NAG:MageCurrentCombustionDotEstimate() >= 425000) or (NAG:RemainingTime() <= 25 and NAG:MageCurrentCombustionDotEstimate() >= 350000)) and NAG:Cast(11129) -- Combustion (Cast 11129)
        or (NAG:AuraIsActive(48107) and not NAG:AuraIsActive(48108) and not NAG:AuraIsActive(108978) and NAG:SpellIsReady(108853)) and NAG:Cast(108853) -- Cast 108853 (off-GCD / special)
        or (NAG:AuraIsActive(48108) and NAG:AuraRemainingTime(48108) <= 3.0) and NAG:Cast(11366) -- Pyroblast (Cast 11366) (buff about to expire)
        or (NAG:AuraIsActive(48108) and NAG:AuraIsActive(48107)) and NAG:Cast(11366, nil, NAG.SPELL_POSITIONS.RIGHT) -- Pyroblast (Cast 11366) (RIGHT, proc)
        or (NAG:AuraIsActive(48108) and NAG:AuraIsActive(48107)) and NAG:Cast(133) -- Fireball (Cast 133)
        or (NAG:SpellIsKnown(44457) and ((not NAG:DotIsActive(44457)) or (NAG:AuraRemainingTime(44457, "target") <= NAG:DotTickFrequency(44457)))) and NAG:AuraIsInactive(108978) and NAG:Cast(44457) -- Living Bomb (Cast 44457) (if Alter Time inactive)
        or (NAG:SpellIsKnown(114923) and ((not NAG:DotIsActive(114923)) or (NAG:AuraRemainingTime(114923, "target") <= NAG:DotTickFrequency(114923)))) and NAG:AuraIsInactive(108978) and NAG:Cast(114923) -- Nether Tempest (Cast 114923) (if Alter Time inactive)
        or (NAG:SpellIsKnown(112948) and NAG:AuraIsInactive(112948, "target")) and NAG:Cast(112948) -- Cast 112948 (offensive)
        or NAG:Cast(133) -- Fireball (Cast 133) (default)
        ]],


        -- Tracked IDs for optimization
        spells = {5143, 12042, 26297, 30451, 33697, 36032, 44425, 44457, 79683, 108839, 108978, 112948, 114923, 116011, 116014, 126734},
        items = {36799, 76093, 126734},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {44955, 42748, 42738, 42743, 63416, 45739},
        lastModified = "17/08/2025",
        author = "Saji"

    }

-- Mage Fire Mastery Rotation
local masteryFireRotation = {
    name = "Mastery Fire - by espi",
    class = "Mage",
    specIndex = 2,
    default = false,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { time = -8.0, action = "NAG:Cast(55342)" },
            { time = -5.0, action = "NAG:Cast(12051)" },
            { time = -5.0, action = "NAG:Cast(116011)" },
            { time = -2.1, action = "NAG:Cast(76093)" },
            { time = -2.0, action = "NAG:Cast(11366)" }
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or -- Strictsequence filtered: only spellIds from Cast, removed none
(((NAG:SpellTimeToReady(108978) > 88.0) and NAG:SpellIsReady(12043))) and NAG:StrictSequence("someName450", true, 12043, 11366)
    or ((NAG:SpellTimeToReady(108978) > 85.0) and (NAG:AuraIsActive(48108, "player", true) or NAG:AuraIsActive(12043, "player", true))) and NAG:CastSpell(11366)
    or ((NAG:SpellTimeToReady(108978) < 85.0) and (NAG:SpellTimeToReady(108978) > 83.0)) and NAG:CastSpell(11129)
    or (NAG:AuraIsInactive(76093, "player", true) and (not NAG:SpellIsReady(11129)) and NAG:AuraIsInactive(30482, "player", true)) and NAG:CastSpell(30482)
    or ((NAG:AuraRemainingTime(116257) <= NAG:SpellCastTime(12051)) and NAG:AuraIsKnown(116257)) and NAG:CastSpell(12051)
    or ((NAG:AuraRemainingTime(116011) <= NAG:SpellCastTime(116011)) and NAG:AuraIsKnown(116011)) and NAG:CastSpell(116011)
    or NAG:VariableRef("bomb check") and NAG:GroupReference("bomb")
    or (NAG:AuraIsInactive(138963, "player", true) and NAG:AuraIsActive(48107, "player", true) and NAG:AuraIsInactive(48108, "player", true) and NAG:AuraIsInactive(12043, "player", true) and (NAG:SpellTimeToReady(108978) <= 170.0)) and NAG:CastSpell(108853)
    or (NAG:AuraIsActive(108978, "player", true) and NAG:AuraIsInactive(48108, "player", true) and NAG:AuraIsInactive(12043, "player", true)) and NAG:CastSpell(108978)
    or ((NAG:SpellTimeToReady(108978) >= 165.0) and NAG:AuraIsInactive(108978, "player", true) and ((NAG:AuraRemainingTime(138963) < (NAG:SpellTravelTime(11366) + NAG:InputDelay())) or (NAG:AuraIsInactive(48108, "player", true) and NAG:AuraIsInactive(12043, "player", true) and (not NAG:SpellInFlight(11366))))) and NAG:CastSpell(11129)
    or ((NAG:SpellTimeToReady(108978) >= 165.0) and NAG:AuraIsInactive(108978, "player", true) and (NAG:AuraIsActive(48108, "player", true) or NAG:AuraIsActive(12043, "player", true)) and (NAG:AuraRemainingTime(138963) >= (NAG:SpellTravelTime(11366) * 2))) and NAG:CastSpell(11366)
    or -- Strictsequence filtered: only spellIds from Cast, removed groupReference
((NAG:AuraIsActive(138963, "player", true) and NAG:SpellIsReady(108978) and NAG:AuraIsInactive(48108, "player", true) and NAG:AuraIsActive(48107, "player", true))) and NAG:StrictSequence("someName254", true, 108853)
    or (NAG:AuraIsActive(138963, "player", true) and NAG:SpellIsReady(108978)) and NAG:GroupReference("alter macro")
    or ((NAG:AuraRemainingTime(138963) >= NAG:SpellGCDHastedDuration(11366)) and (NAG:AuraIsActive(48108, "player", true) or NAG:AuraIsActive(12043, "player", true)) and NAG:AuraIsInactive(108978, "player", true)) and NAG:CastSpell(11366)
    or ((NAG:AuraIsActive(48108, "player", true) or NAG:AuraIsActive(12043, "player", true)) and NAG:AuraIsActive(108978, "player", true) and NAG:AuraIsActive(138963, "player", true)) and NAG:CastSpell(11366)
    or (NAG:AuraIsInactive(138963, "player", true) and NAG:SpellIsReady(108978)) and NAG:CastSpell(2948)
    or (NAG:AuraIsInactive(138963, "player", true) and (NAG:AuraIsActive(48108, "player", true) or NAG:AuraIsActive(12043, "player", true)) and NAG:SpellInFlight(133) and (NAG:SpellTimeToReady(108978) < 165.0)) and NAG:CastSpell(11366)
    or (NAG:AuraIsInactive(138963, "player", true) and (NAG:SpellTimeToReady(108978) < 165.0)) and NAG:CastSpell(133)
    or ((not NAG:SpellIsReady(11129)) and (NAG:SpellTimeToReady(11129) >= 5.0) and NAG:AuraIsActive(48108, "player", true) and NAG:AuraIsActive(48107, "player", true) and NAG:SpellInFlight(133)) and NAG:CastSpell(11366)
    or ((not NAG:SpellIsReady(11129)) and (NAG:SpellTimeToReady(11129) >= 5.0)) and NAG:CastSpell(133)
    ]],

    -- Tracked IDs for optimization
    spells = {133, 2948, 11129, 11366, 12043, 12051, 30482, 44457, 48107, 48108, 108853, 108978, 112948, 114923, 116011, 116257, 132209, 138963},
    items = {76093},
    auras = {},
    runes = {},
    glyphs = {major, minor},
    consumables = { prepotId = 76093, potId = 76093, flaskId = 76085, foodId = 74650 },

    -- Groups and Variables from WoWSims APL
    groups = {
        {
            name = [[alter macro]],
            actions = {
                [[NAG:CastSpell(76093)]],
                [[-- Strictsequence filtered: only spellIds from Cast, removed none
NAG:StrictSequence("someName858", false, 26297, 126734, 12043, 108978)]]
            }
        },
        {
            name = [[bomb]],
            actions = {
                [[NAG:CastSpell(114923)]],
                [[NAG:CastSpell(44457)]],
                [[NAG:CastSpell(112948)]]
            }
        }
        },
    variables = {
        {
            name = [[bomb check]],
            value = [[(((NAG:SpellIsKnown(44457) and (NAG:DotRemainingTime(44457) <= NAG:DotTickFrequency(44457))) or (NAG:SpellIsKnown(114923) and NAG:AuraIsInactive(114923, "target", true)) or (NAG:SpellIsKnown(112948) and NAG:AuraIsInactive(112948, "target", true)) or NAG:AuraIsInactive(132209, "target", true)) and NAG:AuraIsInactive(138963, "player", true))]]
        }
        },

    -- Optional metadata
    talentsString = "111221",
    lastModified = "01/17/2026",
    author = "espi"
}

local frostRotation = {
        -- Core identification
        name = "Frost",
        specIndex = 3,
        class = "MAGE",

        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        prePull = {
            { time = -15.0, action = "NAG:Cast(31687)" },
            { time = -8.0, action = "NAG:Cast(7302)" },
            { time = -5.0, action = "NAG:Cast(12051)" },
            { time = -5.0, action = "NAG:Cast(116011)" },
            { time = -3.5, action = "NAG:Cast(55342)" },
            { time = -1.5, action = "NAG:Cast(116)" },
            { time = -1.5, action = "NAG:Cast(76093)" }
        },
        lastModified = "02/26/2026",
        rotationString = [[
    not NAG:PetIsActive() and NAG:Cast(31687)
    or not (NAG:AuraIsActive(61316) or NAG:AuraIsActive(1459)) and NAG:Cast(1459)
    or not NAG:AuraIsActive(7302) and NAG:Cast(7302)
    or not(UnitAffectingCombat("player")) and NAG:StrictSequence("frostPrepull", false, 55342, 116)
    or NAG:UnitIsMoving() and UnitAffectingCombat("player") and NAG:Cast(108839, nil, NAG.SPELL_POSITIONS.ABOVE)
    or (not NAG:SpellIsKnown(116011) and not NAG:AuraIsActive(116257) and not NAG:UnitIsMoving()) and NAG:Cast(12051)
    or (not NAG:SpellIsKnown(116011) and UnitAffectingCombat("player") and (NAG:AuraRemainingTime(116257) <= NAG:SpellCastTime(116)) and not NAG:UnitIsMoving()) and NAG:Cast(12051)
    or (NAG:SpellIsKnown(116011) and ( not NAG:AuraIsActive(116011) and not NAG:UnitIsMoving())) and NAG:Cast(116011, nil, NAG.SPELL_POSITIONS.PRIMARY)
    or (NAG:SpellIsKnown(116011) and UnitAffectingCombat("player") and ( (NAG:TotemRemainingTime(1) or NAG:TotemRemainingTime(2)) <= NAG:SpellCastTime(116) and not NAG:UnitIsMoving())) and NAG:Cast(116011)
    or NAG:AutocastOtherCooldowns()
    or (NAG:SpellIsKnown(131078) and (NAG:SpellIsReady(108978) or (NAG:SpellTimeToReady(108978) >= 75.0))) and NAG:Cast(131078, nil, NAG.SPELL_POSITIONS.LEFT)
    or ((not NAG:SpellIsKnown(131078)) and (NAG:SpellIsReady(108978) or (NAG:SpellTimeToReady(108978) >= 75.0))) and NAG:Cast(12472, nil, NAG.SPELL_POSITIONS.LEFT)
    or (NAG:SpellIsReady(108978) and (NAG:AuraNumStacks(112965) == 2) and (NAG:AuraIsActive(44549) or NAG:AuraIsActive(57761)) and (NAG:AuraIsActive(12472) or NAG:AuraIsActive(131078) or NAG:AnyTrinketStatProcsActive()) and (NAG:AuraIsActive(2825) or NAG:RemainingTime() >= 180.0)) and not NAG:AuraIsActive(108978) and NAG:Cast(108978, nil, NAG.SPELL_POSITIONS.LEFT)
    or NAG:SpellIsReady(55342) and NAG:Cast(55342)

    -- AoE branch (5+ targets)
    or (NAG:NumberTargets() >= 5) and NAG:SpellIsReady(84714) and NAG:Cast(84714)
    or (NAG:NumberTargets() >= 5 and (NAG:AuraNumStacks(112965) == 2)) and NAG:Cast(30455)
    or (NAG:NumberTargets() >= 5 and (NAG:AuraIsActive(44549) or NAG:AuraIsActive(57761))) and NAG:Cast(44614)
    or (NAG:NumberTargets() >= 5 and NAG:SpellIsKnown(44457) and (not NAG:DotIsActive(44457))) and NAG:Cast(44457)
    or (NAG:NumberTargets() >= 5 and NAG:SpellIsKnown(44457) and NAG:DotIsActive(44457) and NAG:RemainingTime() >= (NAG:DotTickFrequency(44457) * 3) and NAG:ShouldMultidot(44457, 3, (NAG:DotTickFrequency(44457) or 3.0))) and NAG:Cast(44457, nil, NAG.SPELL_POSITIONS.RIGHT)
    or (NAG:NumberTargets() >= 5 and NAG:SpellIsKnown(114923) and (not NAG:DotIsActive(114923))) and NAG:Cast(114923)
    or (NAG:NumberTargets() >= 5 and NAG:SpellIsKnown(114923) and NAG:DotIsActive(114923) and NAG:ShouldMultidot(114923, 5, 0.1)) and NAG:Cast(114923, nil, NAG.SPELL_POSITIONS.RIGHT)
    or (NAG:NumberTargets() >= 5 and NAG:SpellIsKnown(112948) and NAG:AuraIsInactive(112948, "target")) and NAG:Cast(112948)
    or (NAG:NumberTargets() >= 5 and NAG:AuraIsActive(112965)) and NAG:Cast(30455)
    or (NAG:NumberTargets() >= 5) and NAG:ChannelSpell(10, function() return (NAG:SpellIsReady(84714) or NAG:AuraIsActive(112965) or NAG:AuraIsActive(44549) or NAG:AuraIsActive(57761)) end)

    -- ST/Cleave branch (< 5 targets)
    or ((NAG:NumberTargets() < 5) and (NAG:AuraNumStacks(112965) == 2)) and NAG:Cast(30455)
    or ((NAG:NumberTargets() < 5) and (NAG:AuraIsActive(44549) or NAG:AuraIsActive(57761)) and (NAG:SpellTimeToReady(108978) >= 10.0)) and NAG:Cast(44614)
    or not UnitAffectingCombat("player") and NAG:Cast(116)
    or (NAG:NumberTargets() < 5 and NAG:SpellIsKnown(44457) and (not NAG:DotIsActive(44457))) and NAG:AuraIsInactive(108978) and NAG:Cast(44457)
    or (NAG:NumberTargets() < 5 and NAG:SpellIsKnown(44457) and NAG:DotIsActive(44457) and NAG:RemainingTime() >= (NAG:DotTickFrequency(44457) * 3) and NAG:ShouldMultidot(44457, 3, (NAG:DotTickFrequency(44457) or 3.0))) and NAG:AuraIsInactive(108978) and NAG:Cast(44457, nil, NAG.SPELL_POSITIONS.RIGHT)
    or (NAG:NumberTargets() < 5 and NAG:SpellIsKnown(114923) and (not NAG:DotIsActive(114923))) and NAG:AuraIsInactive(108978) and NAG:Cast(114923)
    or (NAG:NumberTargets() < 5 and NAG:SpellIsKnown(114923) and NAG:DotIsActive(114923) and NAG:ShouldMultidot(114923, 5, 0.1)) and NAG:AuraIsInactive(108978) and NAG:Cast(114923, nil, NAG.SPELL_POSITIONS.RIGHT)
    or (NAG:NumberTargets() < 5 and NAG:SpellIsKnown(112948) and NAG:AuraIsInactive(112948, "target")) and NAG:Cast(112948)
    or (NAG:NumberTargets() < 5 and NAG:SpellIsReady(84714)) and NAG:Cast(84714)
    or ((NAG:NumberTargets() < 5) and NAG:AuraIsActive(112965) and (NAG:SpellTimeToReady(108978) >= 10.0)) and NAG:Cast(30455)
    or NAG:Cast(116)
        ]],


        --Tracked IDs for optimization
        spells = {10, 116, 1459, 7302, 12051, 12472, 26297, 30455, 31687, 33697, 44457, 44544, 44549, 44614, 55342, 57761, 61316, 84714, 108839, 108978, 112948, 112965, 114923, 116011, 116257, 126734, 131078},
        items = {76093},
        auras = {},
        runes = {},

        --Optional metadata
        glyphs = {42745, 42753, 45736, 42743, 45739, 104104},
        author = "Saji"

    }


--- @class Mage : ClassBase
local Mage = NAG:CreateClassModule("MAGE", defaults)
if not Mage then return end

function Mage:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 0, genericRotation)  -- Generic (no spec)
    ns.AddRotationToDefaults(self.defaults, 1, arcaneSTRotation)  -- Arcane
    --ns.AddRotationToDefaults(self.defaults, 1, arcaneAOERotation)  -- Arcane
    ns.AddRotationToDefaults(self.defaults, 2, fireSTRotation)  -- Fire
    --ns.AddRotationToDefaults(self.defaults, 2, masteryFireRotation)  -- Fire
    ns.AddRotationToDefaults(self.defaults, 3, frostRotation)  -- Frost
end

function Mage:RegisterSpellTracking()
    --- @type SpellTrackingManager|AceModule|CoreModule
    local SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
        -- Add spells to periodic damage tracking
    -- Note: tickTime values are calculated dynamically from combat log events
    -- These are just for registration - the actual tick times will be calculated when DoTs tick
    SpellTrackingManager:RegisterPeriodicDamage({ 114923 }, { spellId = 114923, auraId = 114923 }) -- Nether Tempest
    SpellTrackingManager:RegisterPeriodicDamage({ 44457 }, { spellId = 44457, auraId = 44457 })   -- Living Bomb
    SpellTrackingManager:RegisterPeriodicDamage({ 348 }, { tickTime = nil, lastTickTime = nil })          -- Immolate
    SpellTrackingManager:RegisterPeriodicDamage({ 413843 },
        { tickTime = nil, lastTickTime = nil, spellId = 12846, auraId = 413841, tickDamage = 0 }) -- Ignite
    SpellTrackingManager:RegisterPeriodicDamage({ 11366, 92315 }, { tickTime = nil, lastTickTime = nil }) -- Pyroblast
    SpellTrackingManager:RegisterTravelTime({ 11366 }, { STT = 0, inFlight = nil })                       -- Pyroblast
    SpellTrackingManager:RegisterTravelTime({ 133 }, { STT = 0, inFlight = nil })                         -- Fireball
end

NAG.Class = Mage
