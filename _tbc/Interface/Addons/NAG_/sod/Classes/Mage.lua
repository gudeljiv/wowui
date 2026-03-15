local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
if not Version:IsSoD() then return end

---@class ClassBase : CoreModule
---Base class for all WoW class modules, defined in NAG/modules/Prototypes/ClassBase.lua

if UnitClassBase('player') ~= "MAGE" then return end

-- ============================ CONSTANTS ============================

-- Initialize defaults
local defaults = ns.InitializeClassDefaults()

-- Add spec-level spell locations to defaults
defaults.class.specSpellLocations = {
    ['*'] = {
        ABOVE = {},
        BELOW = {},
        RIGHT = {},
        LEFT = {},
        AOE = {}
    },
}

-- Fire 3Min Fire Phase8 PreRaid rotation
local fire3MinFirePhase8PreRaid = {
    name = "Mage Fire - 3Min_Fire_Phase8_PreRaid by APLParser",
    specIndex = 2,
    class = "MAGE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -8.0, action = "NAG:Cast(12051)" }
    },
    rotationString = [[
NAG:Cast(12051)
    or NAG:Cast(236331)
    or (not NAG:SpellIsReady(425121)) and NAG:Cast(12472)
    or ((NAG:RuneIsEquipped(400624) and (not NAG:RuneIsEquipped(400615)) and NAG:AuraIsActive(48108)) or NAG:RuneIsEquipped(400615)) and NAG:Cast(10199)
    or (NAG:AuraIsKnown(469237) and (NAG:AuraNumStacks(12873, "target") < 1)) and NAG:StrictSequence("foo", NAG:MoveToRange(15), NAG:Cast(13021))
    or ((not NAG:DotIsActive(400613)) and ((NAG:AuraNumStacks(12873, "target") < 2))) and NAG:Cast(400613)
    or ((not NAG:AuraIsActive(425121)) and ((not NAG:SpellIsReady(26297)) or (not NAG:SpellIsReady(230243)))) and NAG:Cast(425121)
    or ((NAG:AuraNumStacks(12873, "target") < 2) or (NAG:AuraRemainingTime(12873, "target") <= 6.0)) and NAG:Cast(10207)
    or (NAG:RuneIsEquipped(400624) and NAG:AuraIsActive(48108) and (not NAG:AuraIsActive(11129))) and NAG:Cast(18809)
    or ((NAG:AuraNumStacks(12873, "target") == 5) and ((not NAG:RuneIsEquipped(428878)) or (NAG:AuraNumStacks(428878) >= 1))) and NAG:Cast(11129)
    or NAG:Cast(401556)
    or ((not NAG:SpellIsReady(12472)) and (not NAG:AuraIsActive(26297))) and NAG:Cast(230243)
    or NAG:AutocastOtherCooldowns()
    or ((NAG:AuraNumStacks(12873, "target") == 5) and ((NAG:AuraNumStacks(428878) < 4) or (NAG:AuraRemainingTime(428878) <= NAG:SpellCastTime(428878)))) and NAG:Cast(428878)
    or (NAG:AuraIsKnown(467399) and (not NAG:DotIsActive(25306)) and (not NAG:SpellInFlight())) and NAG:Cast(25306)
    or NAG:Cast(401502)
    or NAG:Cast(25306)
    or NAG:Cast(10207)
        ]],

    -- Tracked IDs for optimization
    spells = {10199, 10207, 11129, 12051, 12472, 12873, 13021, 18809, 25306, 26297, 48108, 400613, 401502, 401556, 425121, 428878, 467399, 469237},
    items = {230243, 236331},
    auras = {},
    runes = {400615, 400624, 428878},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Frost 3Min Frost Phase8 PreRaid rotation
local frost3MinFrostPhase8PreRaid = {
    name = "Mage Frost - 3Min_Frost_Phase8_PreRaid by APLParser",
    specIndex = 3,
    class = "MAGE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -8.0, action = "NAG:Cast(12051)" }
    },
    rotationString = [[
(not NAG:AuraIsActive(425121)) and NAG:Cast(425121)
    or (not NAG:AuraIsActive(425121)) and NAG:Cast(230243)
    or NAG:SpellIsReady(428739) and NAG:Cast(428739)
    or NAG:SpellIsReady(440802) and NAG:Cast(440802)
    or NAG:AutocastOtherCooldowns()
    or ((NAG:AuraNumStacks(1218345, "target") > 2) and NAG:AuraIsActive(400647)) and NAG:Cast(400640)
    or NAG:Cast(412532)
        ]],

    -- Tracked IDs for optimization
    spells = {400640, 400647, 412532, 425121, 428739, 440802, 1218345},
    items = {230243},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Fire 5Min Fire Phase8 PreRaid rotation
local fire5MinFirePhase8PreRaid = {
    name = "Mage Fire - 5Min_Fire_Phase8_PreRaid by APLParser",
    specIndex = 2,
    class = "MAGE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -8.0, action = "NAG:Cast(12051)" }
    },
    rotationString = [[
NAG:Cast(12051)
    or NAG:Cast(236331)
    or (not NAG:SpellIsReady(425121)) and NAG:Cast(12472)
    or ((NAG:RuneIsEquipped(400624) and (not NAG:RuneIsEquipped(400615)) and NAG:AuraIsActive(48108)) or NAG:RuneIsEquipped(400615)) and NAG:Cast(10199)
    or (NAG:AuraIsKnown(469237) and (NAG:AuraNumStacks(12873, "target") < 1)) and NAG:StrictSequence("foo", NAG:MoveToRange(15), NAG:Cast(13021))
    or ((not NAG:DotIsActive(400613)) and ((NAG:AuraNumStacks(12873, "target") < 2))) and NAG:Cast(400613)
    or ((not NAG:AuraIsActive(425121)) and ((not NAG:SpellIsReady(26297)) or (not NAG:SpellIsReady(230243)))) and NAG:Cast(425121)
    or ((NAG:AuraNumStacks(12873, "target") < 2) or (NAG:AuraRemainingTime(12873, "target") <= 6.0)) and NAG:Cast(10207)
    or (NAG:RuneIsEquipped(400624) and NAG:AuraIsActive(48108) and (not NAG:AuraIsActive(11129))) and NAG:Cast(18809)
    or ((NAG:AuraNumStacks(12873, "target") == 5) and ((not NAG:RuneIsEquipped(428878)) or (NAG:AuraNumStacks(428878) >= 1))) and NAG:Cast(11129)
    or NAG:Cast(401556)
    or ((not NAG:SpellIsReady(12472)) and (not NAG:AuraIsActive(26297))) and NAG:Cast(230243)
    or NAG:AutocastOtherCooldowns()
    or ((NAG:AuraNumStacks(12873, "target") == 5) and ((NAG:AuraNumStacks(428878) < 4) or (NAG:AuraRemainingTime(428878) <= NAG:SpellCastTime(428878)))) and NAG:Cast(428878)
    or (NAG:AuraIsKnown(467399) and (not NAG:DotIsActive(25306)) and (not NAG:SpellInFlight())) and NAG:Cast(25306)
    or NAG:Cast(401502)
    or NAG:Cast(25306)
    or NAG:Cast(10207)
        ]],

    -- Tracked IDs for optimization
    spells = {10199, 10207, 11129, 12051, 12472, 12873, 13021, 18809, 25306, 26297, 48108, 400613, 401502, 401556, 425121, 428878, 467399, 469237},
    items = {230243, 236331},
    auras = {},
    runes = {400615, 400624, 428878},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Frost 5Min Frost Phase8 PreRaid rotation
local frost5MinFrostPhase8PreRaid = {
    name = "Mage Frost - 5Min_Frost_Phase8_PreRaid by APLParser",
    specIndex = 3,
    class = "MAGE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -8.0, action = "NAG:Cast(12051)" }
    },
    rotationString = [[
(not NAG:AuraIsActive(425121)) and NAG:Cast(425121)
    or (not NAG:AuraIsActive(425121)) and NAG:Cast(230243)
    or NAG:SpellIsReady(428739) and NAG:Cast(428739)
    or NAG:SpellIsReady(440802) and NAG:Cast(440802)
    or NAG:AutocastOtherCooldowns()
    or ((NAG:AuraNumStacks(1218345, "target") > 2) and NAG:AuraIsActive(400647)) and NAG:Cast(400640)
    or NAG:Cast(412532)
        ]],

    -- Tracked IDs for optimization
    spells = {400640, 400647, 412532, 425121, 428739, 440802, 1218345},
    items = {230243},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Fire 1Target 1Min BiS Fire Phase8 ST rotation
local fire1Target1MinBiSFirePhase8ST = {
    name = "Mage Fire - 1Target_1Min_BiS_Fire_Phase8_ST by APLParser",
    specIndex = 2,
    class = "MAGE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -3.0, action = "NAG:Cast(401502)" }
    },
    rotationString = [[
NAG:Cast(215162)
    or (not NAG:SpellIsReady(425121)) and NAG:Cast(12472)
    or NAG:Cast(10199)
    or ((not NAG:DotIsActive(400613))) and NAG:Cast(400613)
    or (((NAG:AuraNumStacks(12873, "target") == 5) or NAG:AuraIsActive(408258, "target")) and (NAG:AuraNumStacks(428878) == 3)) and NAG:Cast(11129)
    or ((not NAG:AuraIsActive(425121)) and ((not NAG:SpellIsReady(26297)) or (not NAG:SpellIsReady(230243)))) and NAG:Cast(425121)
    or NAG:AutocastOtherCooldowns()
    or (NAG:AuraNumStacks(428878) < 4) and NAG:Cast(428878)
    or (((NAG:AuraNumStacks(12873, "target") == 5) or NAG:AuraIsActive(408258, "target")) and ((NAG:AuraNumStacks(428878) == 4)) and NAG:AuraIsActive(48108)) and NAG:StrictSequence("foo", NAG:Cast(428878), NAG:Cast(18809))
    or NAG:Cast(401502)
        ]],

    -- Tracked IDs for optimization
    spells = {10199, 11129, 12472, 12873, 18809, 26297, 48108, 400613, 401502, 408258, 425121, 428878},
    items = {215162, 230243},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Frost 1Target 1Min BiS Frost Phase8 ST rotation
local frost1Target1MinBiSFrostPhase8ST = {
    name = "Mage Frost - 1Target_1Min_BiS_Frost_Phase8_ST by APLParser",
    specIndex = 3,
    class = "MAGE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -12.0, action = "NAG:Cast(13033)" }
    },
    rotationString = [[
(NAG:AuraIsKnown(469238) and (not NAG:AuraIsActive(13033)) and (NAG:RemainingTime() >= 15.0)) and NAG:Cast(13033)
    or (NAG:AuraIsKnown(1218700) or (NAG:CurrentManaPercent() <= 0.1)) and NAG:Cast(12051)
    or NAG:Cast(231282)
    or ((not NAG:AuraIsActive(26297)) and (not NAG:AuraIsActive(425121))) and NAG:Cast(230243)
    or (not NAG:AuraIsActive(425121)) and NAG:Cast(425121)
    or (NAG:AuraNumStacks(400647) <= 1) and NAG:Cast(440802)
    or NAG:AutocastOtherCooldowns()
    or (NAG:AuraIsKnown(456398) and (NAG:AuraNumStacks(428878) == 4) and (NAG:AuraRemainingTime(456398) <= 1.5)) and NAG:Cast(2139)
    or NAG:RuneIsEquipped(400615) and NAG:Cast(10199)
    or ((not NAG:SpellIsReady(425121)) and (not NAG:SpellIsReady(428739)) and ((not NAG:RuneIsEquipped(440802)) or (not NAG:SpellIsReady(440802)))) and NAG:Cast(12472)
    or (NAG:AuraNumStacks(400647) == 2) and NAG:Cast(428739)
    or (NAG:AuraIsActive(400647) and (NAG:AuraNumStacks(1218345, "target") >= 5)) and NAG:Cast(400640)
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(412532) and NAG:RuneIsEquipped(428739) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(412532) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(412532), NAG:Cast(428739))
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(401502) and NAG:RuneIsEquipped(400640) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(401502) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(401502), NAG:Cast(400640))
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(412532) and NAG:RuneIsEquipped(400640) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(412532) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(412532), NAG:Cast(400640))
    or NAG:Cast(401556)
    or ((NAG:AuraNumStacks(428878) < 4) or (NAG:AuraRemainingTime(428878) < NAG:SpellCastTime(428878))) and NAG:Cast(428878)
    or NAG:Cast(412532)
    or NAG:Cast(401502)
    or NAG:Cast(10181)
        ]],

    -- Tracked IDs for optimization
    spells = {2139, 10181, 10199, 12051, 12472, 13033, 26297, 400640, 400647, 401502, 401556, 412532, 425121, 428739, 428878, 440802, 456398, 469238, 1218345, 1218700},
    items = {230243, 231282},
    auras = {},
    runes = {400615, 400640, 400647, 401502, 412532, 428739, 440802},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Frost 1Target 2Min BiS Frost Phase8 ST rotation
local frost1Target2MinBiSFrostPhase8ST = {
    name = "Mage Frost - 1Target_2Min_BiS_Frost_Phase8_ST by APLParser",
    specIndex = 3,
    class = "MAGE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -12.0, action = "NAG:Cast(13033)" }
    },
    rotationString = [[
(NAG:AuraIsKnown(469238) and (not NAG:AuraIsActive(13033)) and (NAG:RemainingTime() >= 15.0)) and NAG:Cast(13033)
    or (NAG:AuraIsKnown(1218700) or (NAG:CurrentManaPercent() <= 0.1)) and NAG:Cast(12051)
    or NAG:Cast(231282)
    or ((not NAG:AuraIsActive(26297)) and (not NAG:AuraIsActive(425121))) and NAG:Cast(230243)
    or (not NAG:AuraIsActive(425121)) and NAG:Cast(425121)
    or (NAG:AuraNumStacks(400647) <= 1) and NAG:Cast(440802)
    or NAG:AutocastOtherCooldowns()
    or (NAG:AuraIsKnown(456398) and (NAG:AuraNumStacks(428878) == 4) and (NAG:AuraRemainingTime(456398) <= 1.5)) and NAG:Cast(2139)
    or NAG:RuneIsEquipped(400615) and NAG:Cast(10199)
    or ((not NAG:SpellIsReady(425121)) and (not NAG:SpellIsReady(428739)) and ((not NAG:RuneIsEquipped(440802)) or (not NAG:SpellIsReady(440802)))) and NAG:Cast(12472)
    or (NAG:AuraNumStacks(400647) == 2) and NAG:Cast(428739)
    or (NAG:AuraIsActive(400647) and (NAG:AuraNumStacks(1218345, "target") >= 5)) and NAG:Cast(400640)
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(412532) and NAG:RuneIsEquipped(428739) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(412532) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(412532), NAG:Cast(428739))
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(401502) and NAG:RuneIsEquipped(400640) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(401502) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(401502), NAG:Cast(400640))
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(412532) and NAG:RuneIsEquipped(400640) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(412532) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(412532), NAG:Cast(400640))
    or NAG:Cast(401556)
    or ((NAG:AuraNumStacks(428878) < 4) or (NAG:AuraRemainingTime(428878) < NAG:SpellCastTime(428878))) and NAG:Cast(428878)
    or NAG:Cast(412532)
    or NAG:Cast(401502)
    or NAG:Cast(10181)
        ]],

    -- Tracked IDs for optimization
    spells = {2139, 10181, 10199, 12051, 12472, 13033, 26297, 400640, 400647, 401502, 401556, 412532, 425121, 428739, 428878, 440802, 456398, 469238, 1218345, 1218700},
    items = {230243, 231282},
    auras = {},
    runes = {400615, 400640, 400647, 401502, 412532, 428739, 440802},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Fire 1Target 2Min BiS Fire Phase8 ST rotation
local fire1Target2MinBiSFirePhase8ST = {
    name = "Mage Fire - 1Target_2Min_BiS_Fire_Phase8_ST by APLParser",
    specIndex = 2,
    class = "MAGE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -3.0, action = "NAG:Cast(401502)" }
    },
    rotationString = [[
NAG:Cast(215162)
    or (not NAG:SpellIsReady(425121)) and NAG:Cast(12472)
    or NAG:Cast(10199)
    or ((not NAG:DotIsActive(400613))) and NAG:Cast(400613)
    or (((NAG:AuraNumStacks(12873, "target") == 5) or NAG:AuraIsActive(408258, "target")) and (NAG:AuraNumStacks(428878) == 3)) and NAG:Cast(11129)
    or ((not NAG:AuraIsActive(425121)) and ((not NAG:SpellIsReady(26297)) or (not NAG:SpellIsReady(230243)))) and NAG:Cast(425121)
    or NAG:AutocastOtherCooldowns()
    or (NAG:AuraNumStacks(428878) < 4) and NAG:Cast(428878)
    or (((NAG:AuraNumStacks(12873, "target") == 5) or NAG:AuraIsActive(408258, "target")) and ((NAG:AuraNumStacks(428878) == 4)) and NAG:AuraIsActive(48108)) and NAG:StrictSequence("foo", NAG:Cast(428878), NAG:Cast(18809))
    or NAG:Cast(401502)
        ]],

    -- Tracked IDs for optimization
    spells = {10199, 11129, 12472, 12873, 18809, 26297, 48108, 400613, 401502, 408258, 425121, 428878},
    items = {215162, 230243},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Fire 1Target 3Min BiS Fire Phase8 ST rotation
local fire1Target3MinBiSFirePhase8ST = {
    name = "Mage Fire - 1Target_3Min_BiS_Fire_Phase8_ST by APLParser",
    specIndex = 2,
    class = "MAGE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -3.0, action = "NAG:Cast(401502)" }
    },
    rotationString = [[
NAG:Cast(215162)
    or (not NAG:SpellIsReady(425121)) and NAG:Cast(12472)
    or NAG:Cast(10199)
    or ((not NAG:DotIsActive(400613))) and NAG:Cast(400613)
    or (((NAG:AuraNumStacks(12873, "target") == 5) or NAG:AuraIsActive(408258, "target")) and (NAG:AuraNumStacks(428878) == 3)) and NAG:Cast(11129)
    or ((not NAG:AuraIsActive(425121)) and ((not NAG:SpellIsReady(26297)) or (not NAG:SpellIsReady(230243)))) and NAG:Cast(425121)
    or NAG:AutocastOtherCooldowns()
    or (NAG:AuraNumStacks(428878) < 4) and NAG:Cast(428878)
    or (((NAG:AuraNumStacks(12873, "target") == 5) or NAG:AuraIsActive(408258, "target")) and ((NAG:AuraNumStacks(428878) == 4)) and NAG:AuraIsActive(48108)) and NAG:StrictSequence("foo", NAG:Cast(428878), NAG:Cast(18809))
    or NAG:Cast(401502)
        ]],

    -- Tracked IDs for optimization
    spells = {10199, 11129, 12472, 12873, 18809, 26297, 48108, 400613, 401502, 408258, 425121, 428878},
    items = {215162, 230243},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Frost 1Target 3Min BiS Frost Phase8 ST rotation
local frost1Target3MinBiSFrostPhase8ST = {
    name = "Mage Frost - 1Target_3Min_BiS_Frost_Phase8_ST by APLParser",
    specIndex = 3,
    class = "MAGE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -12.0, action = "NAG:Cast(13033)" }
    },
    rotationString = [[
(NAG:AuraIsKnown(469238) and (not NAG:AuraIsActive(13033)) and (NAG:RemainingTime() >= 15.0)) and NAG:Cast(13033)
    or (NAG:AuraIsKnown(1218700) or (NAG:CurrentManaPercent() <= 0.1)) and NAG:Cast(12051)
    or NAG:Cast(231282)
    or ((not NAG:AuraIsActive(26297)) and (not NAG:AuraIsActive(425121))) and NAG:Cast(230243)
    or (not NAG:AuraIsActive(425121)) and NAG:Cast(425121)
    or (NAG:AuraNumStacks(400647) <= 1) and NAG:Cast(440802)
    or NAG:AutocastOtherCooldowns()
    or (NAG:AuraIsKnown(456398) and (NAG:AuraNumStacks(428878) == 4) and (NAG:AuraRemainingTime(456398) <= 1.5)) and NAG:Cast(2139)
    or NAG:RuneIsEquipped(400615) and NAG:Cast(10199)
    or ((not NAG:SpellIsReady(425121)) and (not NAG:SpellIsReady(428739)) and ((not NAG:RuneIsEquipped(440802)) or (not NAG:SpellIsReady(440802)))) and NAG:Cast(12472)
    or (NAG:AuraNumStacks(400647) == 2) and NAG:Cast(428739)
    or (NAG:AuraIsActive(400647) and (NAG:AuraNumStacks(1218345, "target") >= 5)) and NAG:Cast(400640)
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(412532) and NAG:RuneIsEquipped(428739) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(412532) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(412532), NAG:Cast(428739))
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(401502) and NAG:RuneIsEquipped(400640) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(401502) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(401502), NAG:Cast(400640))
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(412532) and NAG:RuneIsEquipped(400640) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(412532) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(412532), NAG:Cast(400640))
    or NAG:Cast(401556)
    or ((NAG:AuraNumStacks(428878) < 4) or (NAG:AuraRemainingTime(428878) < NAG:SpellCastTime(428878))) and NAG:Cast(428878)
    or NAG:Cast(412532)
    or NAG:Cast(401502)
    or NAG:Cast(10181)
        ]],

    -- Tracked IDs for optimization
    spells = {2139, 10181, 10199, 12051, 12472, 13033, 26297, 400640, 400647, 401502, 401556, 412532, 425121, 428739, 428878, 440802, 456398, 469238, 1218345, 1218700},
    items = {230243, 231282},
    auras = {},
    runes = {400615, 400640, 400647, 401502, 412532, 428739, 440802},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Frost 2Target 1Min BiS Cleave Frost Phase8 rotation
local frost2Target1MinBiSCleaveFrostPhase8 = {
    name = "Mage Frost - 2Target_1Min_BiS_Cleave_Frost_Phase8 by APLParser",
    specIndex = 3,
    class = "MAGE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -12.0, action = "NAG:Cast(13033)" }
    },
    rotationString = [[
(NAG:AuraIsKnown(469238) and (not NAG:AuraIsActive(13033)) and (NAG:RemainingTime() >= 15.0)) and NAG:Cast(13033)
    or (NAG:AuraIsKnown(1218700) or (NAG:CurrentManaPercent() <= 0.1)) and NAG:Cast(12051)
    or NAG:Cast(231282)
    or ((not NAG:AuraIsActive(26297)) and (not NAG:AuraIsActive(425121))) and NAG:Cast(230243)
    or (not NAG:AuraIsActive(425121)) and NAG:Cast(425121)
    or (NAG:AuraNumStacks(400647) <= 1) and NAG:Cast(440802)
    or NAG:AutocastOtherCooldowns()
    or (NAG:AuraIsKnown(456398) and (NAG:AuraNumStacks(428878) == 4) and (NAG:AuraRemainingTime(456398) <= 1.5)) and NAG:Cast(2139)
    or NAG:RuneIsEquipped(400615) and NAG:Cast(10199)
    or ((not NAG:SpellIsReady(425121)) and (not NAG:SpellIsReady(428739)) and ((not NAG:RuneIsEquipped(440802)) or (not NAG:SpellIsReady(440802)))) and NAG:Cast(12472)
    or (NAG:AuraNumStacks(400647) == 2) and NAG:Cast(428739)
    or (NAG:AuraIsActive(400647) and (NAG:AuraNumStacks(1218345, "target") >= 5)) and NAG:Cast(400640)
    or (NAG:AuraIsActive(400647) and (NAG:AuraNumStacks(1218345, "target") >= 5)) and NAG:Cast(400640)
    or (NAG:AuraIsActive(400647) and (NAG:AuraNumStacks(1218345, "target") >= 5)) and NAG:Cast(400640)
    or (NAG:AuraIsActive(400647) and (NAG:AuraNumStacks(1218345, "target") >= 5)) and NAG:Cast(400640)
    or ((not NAG:AuraIsActive(400647)) and (NAG:NumberTargets() >= 3)) and NAG:Cast(10161)
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(412532) and NAG:RuneIsEquipped(428739) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(412532) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(412532), NAG:Cast(428739))
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(401502) and NAG:RuneIsEquipped(400640) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(401502) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(401502), NAG:Cast(400640))
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(412532) and NAG:RuneIsEquipped(400640) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(412532) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(412532), NAG:Cast(400640))
    or NAG:Cast(401556)
    or ((NAG:AuraNumStacks(428878) < 4) or (NAG:AuraRemainingTime(428878) < NAG:SpellCastTime(428878))) and NAG:Cast(428878)
    or NAG:Cast(412532)
    or NAG:Cast(401502)
    or NAG:Cast(10181)
        ]],

    -- Tracked IDs for optimization
    spells = {2139, 10161, 10181, 10199, 12051, 12472, 13033, 26297, 400640, 400647, 401502, 401556, 412532, 425121, 428739, 428878, 440802, 456398, 469238, 1218345, 1218700},
    items = {230243, 231282},
    auras = {},
    runes = {400615, 400640, 400647, 401502, 412532, 428739, 440802},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Fire 2Target 1Min BiS Cleave Fire Phase8 rotation
local fire2Target1MinBiSCleaveFirePhase8 = {
    name = "Mage Fire - 2Target_1Min_BiS_Cleave_Fire_Phase8 by APLParser",
    specIndex = 2,
    class = "MAGE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {},
    rotationString = [[
(NAG:AuraIsKnown(1218700) or (NAG:CurrentManaPercent() <= 0.1)) and NAG:Cast(12051)
    or (not NAG:SpellIsReady(425121)) and NAG:Cast(12472)
    or (NAG:AuraIsKnown(456398) and (NAG:AuraNumStacks(428878) == 4) and (NAG:AuraRemainingTime(456398) <= 1.5)) and NAG:Cast(2139)
    or ((NAG:RuneIsEquipped(400624) and (not NAG:RuneIsEquipped(400615)) and NAG:AuraIsActive(48108)) or (NAG:RuneIsEquipped(400615))) and NAG:Cast(10199)
    or (NAG:AuraIsKnown(469237) and (NAG:AuraNumStacks(12873, "target") < 1)) and NAG:StrictSequence("foo", NAG:MoveToRange(15), NAG:Cast(13021))
    or ((not NAG:DotIsActive(400613)) and ((NAG:AuraNumStacks(12873, "target") < 2) or (NAG:AuraRemainingTime(12873, "target") <= 6.0))) and NAG:Cast(400613)
    or ((NAG:NumberTargets() >= 3) and (not NAG:DotIsActive(400613)) and (not NAG:DotIsActive(400613))) and NAG:Cast(400613)
    or ((not NAG:AuraIsKnown(1226423)) and ((NAG:AuraNumStacks(12873, "target") < 2) or (NAG:AuraRemainingTime(12873, "target") <= 6.0))) and NAG:Cast(10207)
    or (NAG:RuneIsEquipped(400624) and NAG:AuraIsActive(48108) and (NAG:AuraNumStacks(428878) >= 5)) and NAG:Cast(18809)
    or (((NAG:AuraNumStacks(12873, "target") == 5) or NAG:AuraIsActive(408258, "target")) and ((not NAG:RuneIsEquipped(428878)) or (NAG:AuraNumStacks(428878) >= 2))) and NAG:Cast(11129)
    or NAG:Cast(401556)
    or ((not NAG:AuraIsActive(425121)) and ((not NAG:SpellIsReady(26297)) or (not NAG:SpellIsReady(230243)))) and NAG:Cast(425121)
    or NAG:AutocastOtherCooldowns()
    or (((NAG:AuraNumStacks(12873, "target") == 5) or NAG:AuraIsActive(408258, "target")) and (((NAG:AuraNumStacks(428878) < 4) or NAG:AuraIsActive(48108)) or (NAG:AuraRemainingTime(428878) <= NAG:SpellCastTime(428878)))) and NAG:Cast(428878)
    or NAG:Cast(401502)
    or NAG:Cast(25306)
    or NAG:Cast(10207)
        ]],

    -- Tracked IDs for optimization
    spells = {2139, 10199, 10207, 11129, 12051, 12472, 12873, 13021, 18809, 25306, 26297, 48108, 400613, 401502, 401556, 408258, 425121, 428878, 456398, 469237, 1218700, 1226423},
    items = {230243},
    auras = {},
    runes = {400615, 400624, 428878},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Frost 3Target 1Min BiS Cleave Frost Phase8 rotation
local frost3Target1MinBiSCleaveFrostPhase8 = {
    name = "Mage Frost - 3Target_1Min_BiS_Cleave_Frost_Phase8 by APLParser",
    specIndex = 3,
    class = "MAGE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -12.0, action = "NAG:Cast(13033)" }
    },
    rotationString = [[
(NAG:AuraIsKnown(469238) and (not NAG:AuraIsActive(13033)) and (NAG:RemainingTime() >= 15.0)) and NAG:Cast(13033)
    or (NAG:AuraIsKnown(1218700) or (NAG:CurrentManaPercent() <= 0.1)) and NAG:Cast(12051)
    or NAG:Cast(231282)
    or ((not NAG:AuraIsActive(26297)) and (not NAG:AuraIsActive(425121))) and NAG:Cast(230243)
    or (not NAG:AuraIsActive(425121)) and NAG:Cast(425121)
    or (NAG:AuraNumStacks(400647) <= 1) and NAG:Cast(440802)
    or NAG:AutocastOtherCooldowns()
    or (NAG:AuraIsKnown(456398) and (NAG:AuraNumStacks(428878) == 4) and (NAG:AuraRemainingTime(456398) <= 1.5)) and NAG:Cast(2139)
    or NAG:RuneIsEquipped(400615) and NAG:Cast(10199)
    or ((not NAG:SpellIsReady(425121)) and (not NAG:SpellIsReady(428739)) and ((not NAG:RuneIsEquipped(440802)) or (not NAG:SpellIsReady(440802)))) and NAG:Cast(12472)
    or (NAG:AuraNumStacks(400647) == 2) and NAG:Cast(428739)
    or (NAG:AuraIsActive(400647) and (NAG:AuraNumStacks(1218345, "target") >= 5)) and NAG:Cast(400640)
    or (NAG:AuraIsActive(400647) and (NAG:AuraNumStacks(1218345, "target") >= 5)) and NAG:Cast(400640)
    or (NAG:AuraIsActive(400647) and (NAG:AuraNumStacks(1218345, "target") >= 5)) and NAG:Cast(400640)
    or (NAG:AuraIsActive(400647) and (NAG:AuraNumStacks(1218345, "target") >= 5)) and NAG:Cast(400640)
    or ((not NAG:AuraIsActive(400647)) and (NAG:NumberTargets() >= 3)) and NAG:Cast(10161)
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(412532) and NAG:RuneIsEquipped(428739) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(412532) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(412532), NAG:Cast(428739))
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(401502) and NAG:RuneIsEquipped(400640) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(401502) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(401502), NAG:Cast(400640))
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(412532) and NAG:RuneIsEquipped(400640) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(412532) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(412532), NAG:Cast(400640))
    or NAG:Cast(401556)
    or ((NAG:AuraNumStacks(428878) < 4) or (NAG:AuraRemainingTime(428878) < NAG:SpellCastTime(428878))) and NAG:Cast(428878)
    or NAG:Cast(412532)
    or NAG:Cast(401502)
    or NAG:Cast(10181)
        ]],

    -- Tracked IDs for optimization
    spells = {2139, 10161, 10181, 10199, 12051, 12472, 13033, 26297, 400640, 400647, 401502, 401556, 412532, 425121, 428739, 428878, 440802, 456398, 469238, 1218345, 1218700},
    items = {230243, 231282},
    auras = {},
    runes = {400615, 400640, 400647, 401502, 412532, 428739, 440802},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Fire 3Target 1Min BiS Cleave Fire Phase8 rotation
local fire3Target1MinBiSCleaveFirePhase8 = {
    name = "Mage Fire - 3Target_1Min_BiS_Cleave_Fire_Phase8 by APLParser",
    specIndex = 2,
    class = "MAGE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {},
    rotationString = [[
(NAG:AuraIsKnown(1218700) or (NAG:CurrentManaPercent() <= 0.1)) and NAG:Cast(12051)
    or (not NAG:SpellIsReady(425121)) and NAG:Cast(12472)
    or (NAG:AuraIsKnown(456398) and (NAG:AuraNumStacks(428878) == 4) and (NAG:AuraRemainingTime(456398) <= 1.5)) and NAG:Cast(2139)
    or ((NAG:RuneIsEquipped(400624) and (not NAG:RuneIsEquipped(400615)) and NAG:AuraIsActive(48108)) or (NAG:RuneIsEquipped(400615))) and NAG:Cast(10199)
    or (NAG:AuraIsKnown(469237) and (NAG:AuraNumStacks(12873, "target") < 1)) and NAG:StrictSequence("foo", NAG:MoveToRange(15), NAG:Cast(13021))
    or ((not NAG:DotIsActive(400613)) and ((NAG:AuraNumStacks(12873, "target") < 2) or (NAG:AuraRemainingTime(12873, "target") <= 6.0))) and NAG:Cast(400613)
    or ((NAG:NumberTargets() >= 3) and (not NAG:DotIsActive(400613)) and (not NAG:DotIsActive(400613))) and NAG:Cast(400613)
    or ((not NAG:AuraIsKnown(1226423)) and ((NAG:AuraNumStacks(12873, "target") < 2) or (NAG:AuraRemainingTime(12873, "target") <= 6.0))) and NAG:Cast(10207)
    or (NAG:RuneIsEquipped(400624) and NAG:AuraIsActive(48108) and (NAG:AuraNumStacks(428878) >= 5)) and NAG:Cast(18809)
    or (((NAG:AuraNumStacks(12873, "target") == 5) or NAG:AuraIsActive(408258, "target")) and ((not NAG:RuneIsEquipped(428878)) or (NAG:AuraNumStacks(428878) >= 2))) and NAG:Cast(11129)
    or NAG:Cast(401556)
    or ((not NAG:AuraIsActive(425121)) and ((not NAG:SpellIsReady(26297)) or (not NAG:SpellIsReady(230243)))) and NAG:Cast(425121)
    or NAG:AutocastOtherCooldowns()
    or (((NAG:AuraNumStacks(12873, "target") == 5) or NAG:AuraIsActive(408258, "target")) and (((NAG:AuraNumStacks(428878) < 4) or NAG:AuraIsActive(48108)) or (NAG:AuraRemainingTime(428878) <= NAG:SpellCastTime(428878)))) and NAG:Cast(428878)
    or NAG:Cast(401502)
    or NAG:Cast(25306)
    or NAG:Cast(10207)
        ]],

    -- Tracked IDs for optimization
    spells = {2139, 10199, 10207, 11129, 12051, 12472, 12873, 13021, 18809, 25306, 26297, 48108, 400613, 401502, 401556, 408258, 425121, 428878, 456398, 469237, 1218700, 1226423},
    items = {230243},
    auras = {},
    runes = {400615, 400624, 428878},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Frost 4Target 1Min BiS Cleave Frost Phase8 rotation
local frost4Target1MinBiSCleaveFrostPhase8 = {
    name = "Mage Frost - 4Target_1Min_BiS_Cleave_Frost_Phase8 by APLParser",
    specIndex = 3,
    class = "MAGE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -12.0, action = "NAG:Cast(13033)" }
    },
    rotationString = [[
(NAG:AuraIsKnown(469238) and (not NAG:AuraIsActive(13033)) and (NAG:RemainingTime() >= 15.0)) and NAG:Cast(13033)
    or (NAG:AuraIsKnown(1218700) or (NAG:CurrentManaPercent() <= 0.1)) and NAG:Cast(12051)
    or NAG:Cast(231282)
    or ((not NAG:AuraIsActive(26297)) and (not NAG:AuraIsActive(425121))) and NAG:Cast(230243)
    or (not NAG:AuraIsActive(425121)) and NAG:Cast(425121)
    or (NAG:AuraNumStacks(400647) <= 1) and NAG:Cast(440802)
    or NAG:AutocastOtherCooldowns()
    or (NAG:AuraIsKnown(456398) and (NAG:AuraNumStacks(428878) == 4) and (NAG:AuraRemainingTime(456398) <= 1.5)) and NAG:Cast(2139)
    or NAG:RuneIsEquipped(400615) and NAG:Cast(10199)
    or ((not NAG:SpellIsReady(425121)) and (not NAG:SpellIsReady(428739)) and ((not NAG:RuneIsEquipped(440802)) or (not NAG:SpellIsReady(440802)))) and NAG:Cast(12472)
    or (NAG:AuraNumStacks(400647) == 2) and NAG:Cast(428739)
    or (NAG:AuraIsActive(400647) and (NAG:AuraNumStacks(1218345, "target") >= 5)) and NAG:Cast(400640)
    or (NAG:AuraIsActive(400647) and (NAG:AuraNumStacks(1218345, "target") >= 5)) and NAG:Cast(400640)
    or (NAG:AuraIsActive(400647) and (NAG:AuraNumStacks(1218345, "target") >= 5)) and NAG:Cast(400640)
    or (NAG:AuraIsActive(400647) and (NAG:AuraNumStacks(1218345, "target") >= 5)) and NAG:Cast(400640)
    or ((not NAG:AuraIsActive(400647)) and (NAG:NumberTargets() >= 3)) and NAG:Cast(10161)
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(412532) and NAG:RuneIsEquipped(428739) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(412532) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(412532), NAG:Cast(428739))
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(401502) and NAG:RuneIsEquipped(400640) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(401502) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(401502), NAG:Cast(400640))
    or (NAG:RuneIsEquipped(400647) and NAG:RuneIsEquipped(412532) and NAG:RuneIsEquipped(400640) and (NAG:AuraNumStacks(400647) == 1) and (NAG:SpellCastTime(412532) >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(412532), NAG:Cast(400640))
    or NAG:Cast(401556)
    or ((NAG:AuraNumStacks(428878) < 4) or (NAG:AuraRemainingTime(428878) < NAG:SpellCastTime(428878))) and NAG:Cast(428878)
    or NAG:Cast(412532)
    or NAG:Cast(401502)
    or NAG:Cast(10181)
        ]],

    -- Tracked IDs for optimization
    spells = {2139, 10161, 10181, 10199, 12051, 12472, 13033, 26297, 400640, 400647, 401502, 401556, 412532, 425121, 428739, 428878, 440802, 456398, 469238, 1218345, 1218700},
    items = {230243, 231282},
    auras = {},
    runes = {400615, 400640, 400647, 401502, 412532, 428739, 440802},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Fire 4Target 1Min BiS Cleave Fire Phase8 rotation
local fire4Target1MinBiSCleaveFirePhase8 = {
    name = "Mage Fire - 4Target_1Min_BiS_Cleave_Fire_Phase8 by APLParser",
    specIndex = 2,
    class = "MAGE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {},
    rotationString = [[
(NAG:AuraIsKnown(1218700) or (NAG:CurrentManaPercent() <= 0.1)) and NAG:Cast(12051)
    or (not NAG:SpellIsReady(425121)) and NAG:Cast(12472)
    or (NAG:AuraIsKnown(456398) and (NAG:AuraNumStacks(428878) == 4) and (NAG:AuraRemainingTime(456398) <= 1.5)) and NAG:Cast(2139)
    or ((NAG:RuneIsEquipped(400624) and (not NAG:RuneIsEquipped(400615)) and NAG:AuraIsActive(48108)) or (NAG:RuneIsEquipped(400615))) and NAG:Cast(10199)
    or (NAG:AuraIsKnown(469237) and (NAG:AuraNumStacks(12873, "target") < 1)) and NAG:StrictSequence("foo", NAG:MoveToRange(15), NAG:Cast(13021))
    or ((not NAG:DotIsActive(400613)) and ((NAG:AuraNumStacks(12873, "target") < 2) or (NAG:AuraRemainingTime(12873, "target") <= 6.0))) and NAG:Cast(400613)
    or ((NAG:NumberTargets() >= 3) and (not NAG:DotIsActive(400613)) and (not NAG:DotIsActive(400613))) and NAG:Cast(400613)
    or ((not NAG:AuraIsKnown(1226423)) and ((NAG:AuraNumStacks(12873, "target") < 2) or (NAG:AuraRemainingTime(12873, "target") <= 6.0))) and NAG:Cast(10207)
    or (NAG:RuneIsEquipped(400624) and NAG:AuraIsActive(48108) and (NAG:AuraNumStacks(428878) >= 5)) and NAG:Cast(18809)
    or (((NAG:AuraNumStacks(12873, "target") == 5) or NAG:AuraIsActive(408258, "target")) and ((not NAG:RuneIsEquipped(428878)) or (NAG:AuraNumStacks(428878) >= 2))) and NAG:Cast(11129)
    or NAG:Cast(401556)
    or ((not NAG:AuraIsActive(425121)) and ((not NAG:SpellIsReady(26297)) or (not NAG:SpellIsReady(230243)))) and NAG:Cast(425121)
    or NAG:AutocastOtherCooldowns()
    or (((NAG:AuraNumStacks(12873, "target") == 5) or NAG:AuraIsActive(408258, "target")) and (((NAG:AuraNumStacks(428878) < 4) or NAG:AuraIsActive(48108)) or (NAG:AuraRemainingTime(428878) <= NAG:SpellCastTime(428878)))) and NAG:Cast(428878)
    or NAG:Cast(401502)
    or NAG:Cast(25306)
    or NAG:Cast(10207)
        ]],

    -- Tracked IDs for optimization
    spells = {2139, 10199, 10207, 11129, 12051, 12472, 12873, 13021, 18809, 25306, 26297, 48108, 400613, 401502, 401556, 408258, 425121, 428878, 456398, 469237, 1218700, 1226423},
    items = {230243},
    auras = {},
    runes = {400615, 400624, 428878},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

--- @class MAGE : ClassBase
local MAGE = NAG:CreateClassModule("MAGE", defaults)

--- Setup class defaults with all rotations
function MAGE:SetupClassDefaults()
    -- Add all rotation definitions to defaults
    ns.AddRotationToDefaults(self.defaults, 2, fire3MinFirePhase8PreRaid)  -- Fire
    ns.AddRotationToDefaults(self.defaults, 3, frost3MinFrostPhase8PreRaid)  -- Frost
    ns.AddRotationToDefaults(self.defaults, 2, fire5MinFirePhase8PreRaid)  -- Fire
    ns.AddRotationToDefaults(self.defaults, 3, frost5MinFrostPhase8PreRaid)  -- Frost
    ns.AddRotationToDefaults(self.defaults, 2, fire1Target1MinBiSFirePhase8ST)  -- Fire
    ns.AddRotationToDefaults(self.defaults, 3, frost1Target1MinBiSFrostPhase8ST)  -- Frost
    ns.AddRotationToDefaults(self.defaults, 3, frost1Target2MinBiSFrostPhase8ST)  -- Frost
    ns.AddRotationToDefaults(self.defaults, 2, fire1Target2MinBiSFirePhase8ST)  -- Fire
    ns.AddRotationToDefaults(self.defaults, 2, fire1Target3MinBiSFirePhase8ST)  -- Fire
    ns.AddRotationToDefaults(self.defaults, 3, frost1Target3MinBiSFrostPhase8ST)  -- Frost
    ns.AddRotationToDefaults(self.defaults, 3, frost2Target1MinBiSCleaveFrostPhase8)  -- Frost
    ns.AddRotationToDefaults(self.defaults, 2, fire2Target1MinBiSCleaveFirePhase8)  -- Fire
    ns.AddRotationToDefaults(self.defaults, 3, frost3Target1MinBiSCleaveFrostPhase8)  -- Frost
    ns.AddRotationToDefaults(self.defaults, 2, fire3Target1MinBiSCleaveFirePhase8)  -- Fire
    ns.AddRotationToDefaults(self.defaults, 3, frost4Target1MinBiSCleaveFrostPhase8)  -- Frost
    ns.AddRotationToDefaults(self.defaults, 2, fire4Target1MinBiSCleaveFirePhase8)  -- Fire
end

if not MAGE then return end
NAG.Class = MAGE
