local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
if not Version:IsSoD() then return end

if UnitClassBase('player') ~= "SHAMAN" then return end

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

-- Class assignments for raid coordination
defaults.class.classAssignments = {
    {
        id = "windfury_totem",
        name = "Windfury Totem",
        description = "Place totem that increases melee attack speed (coordinate with other Shamans)",
        spellIds = {8512, 10613, 10614}, -- All ranks
        category = "buff",
    },
    {
        id = "grace_of_air_totem",
        name = "Grace of Air Totem",
        description = "Place totem that increases agility (coordinate with other Shamans)",
        spellIds = {8835, 10627}, -- All ranks
        category = "buff",
    },
    {
        id = "strength_of_earth_totem",
        name = "Strength of Earth Totem",
        description = "Place totem that increases strength (coordinate with other Shamans)",
        spellIds = {8075, 8160, 8161, 10442}, -- All ranks
        category = "buff",
    },
}

-- Enhancement 3Min DW Phase8 PreRaid rotation
local enhancement3MinDWPhase8PreRaid = {
    name = "Shaman Enhancement - 3Min_DW_Phase8_PreRaid by APLParser",
    specIndex = 2,
    class = "SHAMAN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(10432)" },
        { time = -7.5, action = "NAG:Cast(25361)" },
        { time = -6.0, action = "NAG:Cast(25359)" },
        { time = -4.5, action = "NAG:Cast(10438)" },
        { time = -3.0, action = "NAG:Cast(20572)" },
        { time = -1.5, action = "NAG:Cast(440580)" }
    },
    rotationString = [[
NAG:Cast(440580)
    or NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or NAG:Cast(17364)
    or NAG:Cast(408507)
    or ((not NAG:AuraIsActive(10432)) and (NAG:RemainingTime() >= 3.0)) and NAG:Cast(10432)
    or ((NAG:AuraNumStacks(408505) >= 5)) and NAG:Cast(15208)
    or ((not NAG:DotIsActive(10438)) and (NAG:RemainingTime() >= 30.0)) and NAG:Cast(10438)
    or ((not NAG:AuraIsActive(25361)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25361)
    or ((not NAG:AuraIsActive(25359)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25359)
        ]],

    -- Tracked IDs for optimization
    spells = {10432, 10438, 15208, 17364, 25359, 25361, 408505, 408507, 425336, 440580},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Elemental 3Min Phase8 PreRaid rotation
local elemental3MinPhase8PreRaid = {
    name = "Shaman Elemental - 3Min_Phase8_PreRaid by APLParser",
    specIndex = 1,
    class = "SHAMAN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(10432)" },
        { time = -6.0, action = "NAG:Cast(25359)" },
        { time = -4.5, action = "NAG:Cast(25361)" },
        { time = -3.0, action = "NAG:Cast(10497)" },
        { time = -1.5, action = "NAG:Cast(10438)" }
    },
    rotationString = [[
(NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or NAG:Cast(440580)
    or ((not NAG:AuraIsKnown(1219370)) or (NAG:AuraNumStacks(1219370) >= 4)) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraNumStacks(10432) >= 8) and NAG:Cast(231281)
    or (NAG:DotIsActive(29228) and (not NAG:SpellIsReady(408490))) and NAG:Cast(16166)
    or (NAG:AuraIsKnown(231281) and NAG:AuraIsActive(231281) and (NAG:AuraRemainingTime(231281) <= 2.0)) and NAG:Cast(10414)
    or (NAG:DotRemainingTime(29228) < 3.0) and NAG:Cast(29228)
    or (NAG:NumberTargets() >= 5) and NAG:Cast(29228)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(10605)
    or (NAG:DotRemainingTime(29228) >= NAG:SpellCastTime(408490)) and NAG:Cast(408490)
    or (NAG:AuraNumStacks(10432) >= 8) and NAG:Cast(10414)
    or (NAG:NumberTargets() >= 5) and NAG:Cast(408427)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(29228)
    or (NAG:NumberTargets() >= 3) and NAG:Cast(408427)
    or ((not NAG:DotIsActive(10587)) and (NAG:RemainingTime() >= 10.0) and (NAG:NumberTargets() >= 3)) and NAG:Cast(10587)
    or ((not NAG:DotIsActive(10438)) and (NAG:RemainingTime() >= 30.0) and (NAG:NumberTargets() <= 2)) and NAG:Cast(10438)
    or NAG:Cast(15208)
    or false and NAG:Cast(20572)
        ]],

    -- Tracked IDs for optimization
    spells = {10414, 10432, 10438, 10587, 10605, 15208, 16166, 20572, 29228, 408427, 408490, 425336, 440580, 1219370},
    items = {231281},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Enhancement 2H 3Min Phase8 PreRaid rotation
local enhancement2H3MinPhase8PreRaid = {
    name = "Shaman Enhancement - 2H_3Min_Phase8_PreRaid by APLParser",
    specIndex = 2,
    class = "SHAMAN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(10432)" },
        { time = -9.0, action = "NAG:Cast(10497)" },
        { time = -7.5, action = "NAG:Cast(25359)" },
        { time = -6.0, action = "NAG:Cast(25361)" },
        { time = -4.5, action = "NAG:Cast(10438)" },
        { time = -3.0, action = "NAG:Cast(20572)" },
        { time = -1.5, action = "NAG:Cast(440580)" },
        { time = -1.0, action = "NAG:Cast(26297)" }
    },
    rotationString = [[
NAG:Cast(440580)
    or NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or (NAG:CurrentManaPercent() <= 0.55) and NAG:Cast(NAG:GetBattlePotion())
    or ((NAG:AuraNumStacks(408505) >= 5) and (NAG:NumberTargets() >= 2)) and NAG:Cast(10605)
    or ((NAG:AuraNumStacks(408505) >= 5) and NAG:DotIsActive(29228)) and NAG:Cast(408490)
    or ((NAG:AuraNumStacks(408505) >= 5)) and NAG:Cast(15208)
    or NAG:Cast(17364)
    or (not NAG:DotIsActive(29228)) and NAG:Cast(29228)
    or (NAG:AuraNumStacks(10432) <= 7) and NAG:Cast(10432)
    or NAG:Cast(10414)
    or ((not NAG:AuraIsActive(25361)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25361)
    or ((not NAG:AuraIsActive(25359)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25359)
    or ((not NAG:DotIsActive(10438)) and (NAG:RemainingTime() >= 30.0)) and NAG:Cast(10438)
        ]],

    -- Tracked IDs for optimization
    spells = {10414, 10432, 10438, 10605, 15208, 17364, 25359, 25361, 29228, 408490, 408505, 425336, 440580},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Enhancement 5Min DW Phase8 PreRaid rotation
local enhancement5MinDWPhase8PreRaid = {
    name = "Shaman Enhancement - 5Min_DW_Phase8_PreRaid by APLParser",
    specIndex = 2,
    class = "SHAMAN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(10432)" },
        { time = -7.5, action = "NAG:Cast(25361)" },
        { time = -6.0, action = "NAG:Cast(25359)" },
        { time = -4.5, action = "NAG:Cast(10438)" },
        { time = -3.0, action = "NAG:Cast(20572)" },
        { time = -1.5, action = "NAG:Cast(440580)" }
    },
    rotationString = [[
NAG:Cast(440580)
    or NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or NAG:Cast(17364)
    or NAG:Cast(408507)
    or ((not NAG:AuraIsActive(10432)) and (NAG:RemainingTime() >= 3.0)) and NAG:Cast(10432)
    or ((NAG:AuraNumStacks(408505) >= 5)) and NAG:Cast(15208)
    or ((not NAG:DotIsActive(10438)) and (NAG:RemainingTime() >= 30.0)) and NAG:Cast(10438)
    or ((not NAG:AuraIsActive(25361)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25361)
    or ((not NAG:AuraIsActive(25359)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25359)
        ]],

    -- Tracked IDs for optimization
    spells = {10432, 10438, 15208, 17364, 25359, 25361, 408505, 408507, 425336, 440580},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Elemental 5Min Phase8 PreRaid rotation
local elemental5MinPhase8PreRaid = {
    name = "Shaman Elemental - 5Min_Phase8_PreRaid by APLParser",
    specIndex = 1,
    class = "SHAMAN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(10432)" },
        { time = -6.0, action = "NAG:Cast(25359)" },
        { time = -4.5, action = "NAG:Cast(25361)" },
        { time = -3.0, action = "NAG:Cast(10497)" },
        { time = -1.5, action = "NAG:Cast(10438)" }
    },
    rotationString = [[
(NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or NAG:Cast(440580)
    or ((not NAG:AuraIsKnown(1219370)) or (NAG:AuraNumStacks(1219370) >= 4)) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraNumStacks(10432) >= 8) and NAG:Cast(231281)
    or (NAG:DotIsActive(29228) and (not NAG:SpellIsReady(408490))) and NAG:Cast(16166)
    or (NAG:AuraIsKnown(231281) and NAG:AuraIsActive(231281) and (NAG:AuraRemainingTime(231281) <= 2.0)) and NAG:Cast(10414)
    or (NAG:DotRemainingTime(29228) < 3.0) and NAG:Cast(29228)
    or (NAG:NumberTargets() >= 5) and NAG:Cast(29228)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(10605)
    or (NAG:DotRemainingTime(29228) >= NAG:SpellCastTime(408490)) and NAG:Cast(408490)
    or (NAG:AuraNumStacks(10432) >= 8) and NAG:Cast(10414)
    or (NAG:NumberTargets() >= 5) and NAG:Cast(408427)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(29228)
    or (NAG:NumberTargets() >= 3) and NAG:Cast(408427)
    or ((not NAG:DotIsActive(10587)) and (NAG:RemainingTime() >= 10.0) and (NAG:NumberTargets() >= 3)) and NAG:Cast(10587)
    or ((not NAG:DotIsActive(10438)) and (NAG:RemainingTime() >= 30.0) and (NAG:NumberTargets() <= 2)) and NAG:Cast(10438)
    or NAG:Cast(15208)
    or false and NAG:Cast(20572)
        ]],

    -- Tracked IDs for optimization
    spells = {10414, 10432, 10438, 10587, 10605, 15208, 16166, 20572, 29228, 408427, 408490, 425336, 440580, 1219370},
    items = {231281},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Enhancement 2H 5Min Phase8 PreRaid rotation
local enhancement2H5MinPhase8PreRaid = {
    name = "Shaman Enhancement - 2H_5Min_Phase8_PreRaid by APLParser",
    specIndex = 2,
    class = "SHAMAN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(10432)" },
        { time = -9.0, action = "NAG:Cast(10497)" },
        { time = -7.5, action = "NAG:Cast(25359)" },
        { time = -6.0, action = "NAG:Cast(25361)" },
        { time = -4.5, action = "NAG:Cast(10438)" },
        { time = -3.0, action = "NAG:Cast(20572)" },
        { time = -1.5, action = "NAG:Cast(440580)" },
        { time = -1.0, action = "NAG:Cast(26297)" }
    },
    rotationString = [[
NAG:Cast(440580)
    or NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or (NAG:CurrentManaPercent() <= 0.55) and NAG:Cast(NAG:GetBattlePotion())
    or ((NAG:AuraNumStacks(408505) >= 5) and (NAG:NumberTargets() >= 2)) and NAG:Cast(10605)
    or ((NAG:AuraNumStacks(408505) >= 5) and NAG:DotIsActive(29228)) and NAG:Cast(408490)
    or ((NAG:AuraNumStacks(408505) >= 5)) and NAG:Cast(15208)
    or NAG:Cast(17364)
    or (not NAG:DotIsActive(29228)) and NAG:Cast(29228)
    or (NAG:AuraNumStacks(10432) <= 7) and NAG:Cast(10432)
    or NAG:Cast(10414)
    or ((not NAG:AuraIsActive(25361)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25361)
    or ((not NAG:AuraIsActive(25359)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25359)
    or ((not NAG:DotIsActive(10438)) and (NAG:RemainingTime() >= 30.0)) and NAG:Cast(10438)
        ]],

    -- Tracked IDs for optimization
    spells = {10414, 10432, 10438, 10605, 15208, 17364, 25359, 25361, 29228, 408490, 408505, 425336, 440580},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Enhancement 1Target 1Min 2H BiS Phase8 ST rotation
local enhancement1Target1Min2HBiSPhase8ST = {
    name = "Shaman Enhancement - 1Target_1Min_2H_BiS_Phase8_ST by APLParser",
    specIndex = 2,
    class = "SHAMAN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(10432)" },
        { time = -7.5, action = "NAG:Cast(25359)" },
        { time = -6.0, action = "NAG:Cast(25361)" },
        { time = -4.5, action = "NAG:Cast(10438)" },
        { time = -3.0, action = "NAG:Cast(20572)" },
        { time = -1.5, action = "NAG:Cast(440580)" },
        { time = -1.0, action = "NAG:Cast(26297)" }
    },
    rotationString = [[
NAG:Cast(440580)
    or NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or ((NAG:AuraNumStacks(408505) >= 10) and (NAG:NumberTargets() >= 2)) and NAG:Cast(10605)
    or ((NAG:AuraNumStacks(408505) >= 10) and (NAG:DotRemainingTime(29228) >= (NAG:SpellCastTime(408490) + 0.1))) and NAG:Cast(408490)
    or ((NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(15208)
    or NAG:Cast(17364)
    or (not NAG:DotIsActive(29228)) and NAG:Cast(29228)
    or (NAG:AuraNumStacks(10432) <= 7) and NAG:Cast(10432)
    or NAG:Cast(11315)
    or NAG:Cast(10414)
    or (NAG:CurrentManaPercent() <= 0.55) and NAG:Cast(NAG:GetBattlePotion())
    or ((not NAG:AuraIsActive(25361)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25361)
    or ((not NAG:AuraIsActive(25359)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25359)
        ]],

    -- Tracked IDs for optimization
    spells = {10414, 10432, 10605, 11315, 15208, 17364, 25359, 25361, 29228, 408490, 408505, 425336, 440580},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Elemental 1Target 1Min BiS Phase8 ST rotation
local elemental1Target1MinBiSPhase8ST = {
    name = "Shaman Elemental - 1Target_1Min_BiS_Phase8_ST by APLParser",
    specIndex = 1,
    class = "SHAMAN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(10432)" },
        { time = -8.0, action = "NAG:Cast(25359)" },
        { time = -6.5, action = "NAG:Cast(25361)" },
        { time = -5.0, action = "NAG:Cast(10497)" },
        { time = -3.5, action = "NAG:Cast(10438)" }
    },
    rotationString = [[
NAG:Cast(425336)
    or NAG:AutocastOtherCooldowns()
    or (NAG:DotIsActive(29228) and (not NAG:SpellIsReady(408490))) and NAG:Cast(16166)
    or (NAG:DotRemainingTime(29228) < 3.0) and NAG:Cast(29228)
    or NAG:Multidot(29228, 1, 0.0)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(10605)
    or (NAG:DotRemainingTime(29228) >= NAG:SpellCastTime(408490)) and NAG:Cast(408490)
    or NAG:AuraIsKnown(1226978) and NAG:Cast(10605)
    or (NAG:AuraNumStacks(10432) >= 8) and NAG:Cast(10414)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(29228)
    or ((not NAG:DotIsActive(10438)) and (NAG:RemainingTime() >= 30.0) and (NAG:NumberTargets() <= 2)) and NAG:Cast(10438)
    or ((not NAG:DotIsActive(10587)) and (NAG:RemainingTime() >= 20) and (NAG:NumberTargets() >= 5)) and NAG:Cast(10587)
    or NAG:Cast(15208)
    or false and NAG:Cast(20572)
        ]],

    -- Tracked IDs for optimization
    spells = {10414, 10432, 10438, 10587, 10605, 15208, 16166, 20572, 29228, 408490, 425336, 1226978},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Enhancement 1Target 1Min BiS DW Phase8 ST rotation
local enhancement1Target1MinBiSDWPhase8ST = {
    name = "Shaman Enhancement - 1Target_1Min_BiS_DW_Phase8_ST by APLParser",
    specIndex = 2,
    class = "SHAMAN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(10432)" },
        { time = -7.5, action = "NAG:Cast(25361)" },
        { time = -6.0, action = "NAG:Cast(25359)" },
        { time = -4.5, action = "NAG:Cast(10438)" },
        { time = -3.0, action = "NAG:Cast(20572)" },
        { time = -1.5, action = "NAG:Cast(440580)" }
    },
    rotationString = [[
NAG:Cast(440580)
    or NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or (NAG:CurrentManaPercent() <= 0.55) and NAG:Cast(NAG:GetBattlePotion())
    or ((NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(408490)
    or ((NAG:NumberTargets() >= 2) and (NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(10605)
    or ((NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(15208)
    or NAG:Cast(17364)
    or ((not NAG:DotIsActive(29228)) and (NAG:RemainingTime() > 12)) and NAG:Cast(29228)
    or NAG:Cast(408507)
    or NAG:Cast(11315)
    or NAG:Cast(10414)
    or (NAG:AuraNumStacks(10432) <= 7) and NAG:Cast(10432)
    or ((not NAG:AuraIsActive(25361)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25361)
    or ((not NAG:AuraIsActive(25359)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25359)
        ]],

    -- Tracked IDs for optimization
    spells = {10414, 10432, 10605, 11315, 15208, 17364, 25359, 25361, 29228, 408490, 408505, 408507, 425336, 440580},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Elemental 1Target 2Min BiS Phase8 ST rotation
local elemental1Target2MinBiSPhase8ST = {
    name = "Shaman Elemental - 1Target_2Min_BiS_Phase8_ST by APLParser",
    specIndex = 1,
    class = "SHAMAN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(10432)" },
        { time = -8.0, action = "NAG:Cast(25359)" },
        { time = -6.5, action = "NAG:Cast(25361)" },
        { time = -5.0, action = "NAG:Cast(10497)" },
        { time = -3.5, action = "NAG:Cast(10438)" }
    },
    rotationString = [[
NAG:Cast(425336)
    or NAG:AutocastOtherCooldowns()
    or (NAG:DotIsActive(29228) and (not NAG:SpellIsReady(408490))) and NAG:Cast(16166)
    or (NAG:DotRemainingTime(29228) < 3.0) and NAG:Cast(29228)
    or NAG:Multidot(29228, 1, 0.0)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(10605)
    or (NAG:DotRemainingTime(29228) >= NAG:SpellCastTime(408490)) and NAG:Cast(408490)
    or NAG:AuraIsKnown(1226978) and NAG:Cast(10605)
    or (NAG:AuraNumStacks(10432) >= 8) and NAG:Cast(10414)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(29228)
    or ((not NAG:DotIsActive(10438)) and (NAG:RemainingTime() >= 30.0) and (NAG:NumberTargets() <= 2)) and NAG:Cast(10438)
    or ((not NAG:DotIsActive(10587)) and (NAG:RemainingTime() >= 20) and (NAG:NumberTargets() >= 5)) and NAG:Cast(10587)
    or NAG:Cast(15208)
    or false and NAG:Cast(20572)
        ]],

    -- Tracked IDs for optimization
    spells = {10414, 10432, 10438, 10587, 10605, 15208, 16166, 20572, 29228, 408490, 425336, 1226978},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Enhancement 1Target 2Min 2H BiS Phase8 ST rotation
local enhancement1Target2Min2HBiSPhase8ST = {
    name = "Shaman Enhancement - 1Target_2Min_2H_BiS_Phase8_ST by APLParser",
    specIndex = 2,
    class = "SHAMAN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(10432)" },
        { time = -7.5, action = "NAG:Cast(25359)" },
        { time = -6.0, action = "NAG:Cast(25361)" },
        { time = -4.5, action = "NAG:Cast(10438)" },
        { time = -3.0, action = "NAG:Cast(20572)" },
        { time = -1.5, action = "NAG:Cast(440580)" },
        { time = -1.0, action = "NAG:Cast(26297)" }
    },
    rotationString = [[
NAG:Cast(440580)
    or NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or ((NAG:AuraNumStacks(408505) >= 10) and (NAG:NumberTargets() >= 2)) and NAG:Cast(10605)
    or ((NAG:AuraNumStacks(408505) >= 10) and (NAG:DotRemainingTime(29228) >= (NAG:SpellCastTime(408490) + 0.1))) and NAG:Cast(408490)
    or ((NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(15208)
    or NAG:Cast(17364)
    or (not NAG:DotIsActive(29228)) and NAG:Cast(29228)
    or (NAG:AuraNumStacks(10432) <= 7) and NAG:Cast(10432)
    or NAG:Cast(11315)
    or NAG:Cast(10414)
    or (NAG:CurrentManaPercent() <= 0.55) and NAG:Cast(NAG:GetBattlePotion())
    or ((not NAG:AuraIsActive(25361)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25361)
    or ((not NAG:AuraIsActive(25359)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25359)
        ]],

    -- Tracked IDs for optimization
    spells = {10414, 10432, 10605, 11315, 15208, 17364, 25359, 25361, 29228, 408490, 408505, 425336, 440580},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Enhancement 1Target 2Min BiS DW Phase8 ST rotation
local enhancement1Target2MinBiSDWPhase8ST = {
    name = "Shaman Enhancement - 1Target_2Min_BiS_DW_Phase8_ST by APLParser",
    specIndex = 2,
    class = "SHAMAN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(10432)" },
        { time = -7.5, action = "NAG:Cast(25361)" },
        { time = -6.0, action = "NAG:Cast(25359)" },
        { time = -4.5, action = "NAG:Cast(10438)" },
        { time = -3.0, action = "NAG:Cast(20572)" },
        { time = -1.5, action = "NAG:Cast(440580)" }
    },
    rotationString = [[
NAG:Cast(440580)
    or NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or (NAG:CurrentManaPercent() <= 0.55) and NAG:Cast(NAG:GetBattlePotion())
    or ((NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(408490)
    or ((NAG:NumberTargets() >= 2) and (NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(10605)
    or ((NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(15208)
    or NAG:Cast(17364)
    or ((not NAG:DotIsActive(29228)) and (NAG:RemainingTime() > 12)) and NAG:Cast(29228)
    or NAG:Cast(408507)
    or NAG:Cast(11315)
    or NAG:Cast(10414)
    or (NAG:AuraNumStacks(10432) <= 7) and NAG:Cast(10432)
    or ((not NAG:AuraIsActive(25361)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25361)
    or ((not NAG:AuraIsActive(25359)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25359)
        ]],

    -- Tracked IDs for optimization
    spells = {10414, 10432, 10605, 11315, 15208, 17364, 25359, 25361, 29228, 408490, 408505, 408507, 425336, 440580},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Elemental 1Target 3Min BiS Phase8 ST rotation
local elemental1Target3MinBiSPhase8ST = {
    name = "Shaman Elemental - 1Target_3Min_BiS_Phase8_ST by APLParser",
    specIndex = 1,
    class = "SHAMAN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(10432)" },
        { time = -8.0, action = "NAG:Cast(25359)" },
        { time = -6.5, action = "NAG:Cast(25361)" },
        { time = -5.0, action = "NAG:Cast(10497)" },
        { time = -3.5, action = "NAG:Cast(10438)" }
    },
    rotationString = [[
NAG:Cast(425336)
    or NAG:AutocastOtherCooldowns()
    or (NAG:DotIsActive(29228) and (not NAG:SpellIsReady(408490))) and NAG:Cast(16166)
    or (NAG:DotRemainingTime(29228) < 3.0) and NAG:Cast(29228)
    or NAG:Multidot(29228, 1, 0.0)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(10605)
    or (NAG:DotRemainingTime(29228) >= NAG:SpellCastTime(408490)) and NAG:Cast(408490)
    or NAG:AuraIsKnown(1226978) and NAG:Cast(10605)
    or (NAG:AuraNumStacks(10432) >= 8) and NAG:Cast(10414)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(29228)
    or ((not NAG:DotIsActive(10438)) and (NAG:RemainingTime() >= 30.0) and (NAG:NumberTargets() <= 2)) and NAG:Cast(10438)
    or ((not NAG:DotIsActive(10587)) and (NAG:RemainingTime() >= 20) and (NAG:NumberTargets() >= 5)) and NAG:Cast(10587)
    or NAG:Cast(15208)
    or false and NAG:Cast(20572)
        ]],

    -- Tracked IDs for optimization
    spells = {10414, 10432, 10438, 10587, 10605, 15208, 16166, 20572, 29228, 408490, 425336, 1226978},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Enhancement 1Target 3Min 2H BiS Phase8 ST rotation
local enhancement1Target3Min2HBiSPhase8ST = {
    name = "Shaman Enhancement - 1Target_3Min_2H_BiS_Phase8_ST by APLParser",
    specIndex = 2,
    class = "SHAMAN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(10432)" },
        { time = -7.5, action = "NAG:Cast(25359)" },
        { time = -6.0, action = "NAG:Cast(25361)" },
        { time = -4.5, action = "NAG:Cast(10438)" },
        { time = -3.0, action = "NAG:Cast(20572)" },
        { time = -1.5, action = "NAG:Cast(440580)" },
        { time = -1.0, action = "NAG:Cast(26297)" }
    },
    rotationString = [[
NAG:Cast(440580)
    or NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or ((NAG:AuraNumStacks(408505) >= 10) and (NAG:NumberTargets() >= 2)) and NAG:Cast(10605)
    or ((NAG:AuraNumStacks(408505) >= 10) and (NAG:DotRemainingTime(29228) >= (NAG:SpellCastTime(408490) + 0.1))) and NAG:Cast(408490)
    or ((NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(15208)
    or NAG:Cast(17364)
    or (not NAG:DotIsActive(29228)) and NAG:Cast(29228)
    or (NAG:AuraNumStacks(10432) <= 7) and NAG:Cast(10432)
    or NAG:Cast(11315)
    or NAG:Cast(10414)
    or (NAG:CurrentManaPercent() <= 0.55) and NAG:Cast(NAG:GetBattlePotion())
    or ((not NAG:AuraIsActive(25361)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25361)
    or ((not NAG:AuraIsActive(25359)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25359)
        ]],

    -- Tracked IDs for optimization
    spells = {10414, 10432, 10605, 11315, 15208, 17364, 25359, 25361, 29228, 408490, 408505, 425336, 440580},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Enhancement 1Target 3Min BiS DW Phase8 ST rotation
local enhancement1Target3MinBiSDWPhase8ST = {
    name = "Shaman Enhancement - 1Target_3Min_BiS_DW_Phase8_ST by APLParser",
    specIndex = 2,
    class = "SHAMAN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(10432)" },
        { time = -7.5, action = "NAG:Cast(25361)" },
        { time = -6.0, action = "NAG:Cast(25359)" },
        { time = -4.5, action = "NAG:Cast(10438)" },
        { time = -3.0, action = "NAG:Cast(20572)" },
        { time = -1.5, action = "NAG:Cast(440580)" }
    },
    rotationString = [[
NAG:Cast(440580)
    or NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or (NAG:CurrentManaPercent() <= 0.55) and NAG:Cast(NAG:GetBattlePotion())
    or ((NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(408490)
    or ((NAG:NumberTargets() >= 2) and (NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(10605)
    or ((NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(15208)
    or NAG:Cast(17364)
    or ((not NAG:DotIsActive(29228)) and (NAG:RemainingTime() > 12)) and NAG:Cast(29228)
    or NAG:Cast(408507)
    or NAG:Cast(11315)
    or NAG:Cast(10414)
    or (NAG:AuraNumStacks(10432) <= 7) and NAG:Cast(10432)
    or ((not NAG:AuraIsActive(25361)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25361)
    or ((not NAG:AuraIsActive(25359)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25359)
        ]],

    -- Tracked IDs for optimization
    spells = {10414, 10432, 10605, 11315, 15208, 17364, 25359, 25361, 29228, 408490, 408505, 408507, 425336, 440580},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Elemental 2Target 1Min BiS Cleave Phase8 rotation
local elemental2Target1MinBiSCleavePhase8 = {
    name = "Shaman Elemental - 2Target_1Min_BiS_Cleave_Phase8 by APLParser",
    specIndex = 1,
    class = "SHAMAN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(10432)" },
        { time = -8.0, action = "NAG:Cast(25359)" },
        { time = -6.5, action = "NAG:Cast(25361)" },
        { time = -5.0, action = "NAG:Cast(10497)" },
        { time = -3.5, action = "NAG:Cast(10438)" }
    },
    rotationString = [[
NAG:Cast(425336)
    or NAG:AutocastOtherCooldowns()
    or (NAG:DotIsActive(29228) and (not NAG:SpellIsReady(408490))) and NAG:Cast(16166)
    or (NAG:DotRemainingTime(29228) < 3.0) and NAG:Cast(29228)
    or NAG:Multidot(29228, 1, 0.0)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(10605)
    or (NAG:DotRemainingTime(29228) >= NAG:SpellCastTime(408490)) and NAG:Cast(408490)
    or NAG:Cast(10605)
    or (NAG:AuraNumStacks(10432) >= 8) and NAG:Cast(10414)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(29228)
    or ((not NAG:DotIsActive(10438)) and (NAG:RemainingTime() >= 30.0) and (NAG:NumberTargets() <= 2)) and NAG:Cast(10438)
    or ((not NAG:DotIsActive(10587)) and (NAG:RemainingTime() >= 20) and (NAG:NumberTargets() >= 5)) and NAG:Cast(10587)
    or NAG:Cast(15208)
    or false and NAG:Cast(20572)
        ]],

    -- Tracked IDs for optimization
    spells = {10414, 10432, 10438, 10587, 10605, 15208, 16166, 20572, 29228, 408490, 425336},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Enhancement 2H 2Target 1Min BiS Cleave Phase8 rotation
local enhancement2H2Target1MinBiSCleavePhase8 = {
    name = "Shaman Enhancement - 2H_2Target_1Min_BiS_Cleave_Phase8 by APLParser",
    specIndex = 2,
    class = "SHAMAN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(10432)" },
        { time = -7.5, action = "NAG:Cast(25359)" },
        { time = -6.0, action = "NAG:Cast(25361)" },
        { time = -4.5, action = "NAG:Cast(10438)" },
        { time = -3.0, action = "NAG:Cast(20572)" },
        { time = -1.5, action = "NAG:Cast(440580)" },
        { time = -1.0, action = "NAG:Cast(26297)" }
    },
    rotationString = [[
NAG:Cast(440580)
    or NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or ((NAG:AuraNumStacks(408505) >= 10) and (NAG:NumberTargets() >= 2)) and NAG:Cast(10605)
    or ((NAG:AutoTimeToNext() >= (NAG:SpellCastTime(408490) + 0.1)) and (NAG:AuraNumStacks(408505) >= 10) and (NAG:DotRemainingTime(29228) >= (NAG:SpellCastTime(408490) + 0.1))) and NAG:Cast(408490)
    or ((NAG:AutoTimeToNext() >= (NAG:SpellCastTime(15208) + 0.1)) and (NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(15208)
    or NAG:Cast(17364)
    or (not NAG:DotIsActive(29228)) and NAG:Cast(29228)
    or (NAG:AuraNumStacks(10432) <= 7) and NAG:Cast(10432)
    or NAG:Cast(11315)
    or NAG:Cast(10414)
    or (NAG:CurrentManaPercent() <= 0.55) and NAG:Cast(NAG:GetBattlePotion())
    or ((not NAG:AuraIsActive(25361)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25361)
    or ((not NAG:AuraIsActive(25359)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25359)
        ]],

    -- Tracked IDs for optimization
    spells = {10414, 10432, 10605, 11315, 15208, 17364, 25359, 25361, 29228, 408490, 408505, 425336, 440580},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Enhancement 2Target 1Min BiS Cleave DW Phase8 rotation
local enhancement2Target1MinBiSCleaveDWPhase8 = {
    name = "Shaman Enhancement - 2Target_1Min_BiS_Cleave_DW_Phase8 by APLParser",
    specIndex = 2,
    class = "SHAMAN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(10432)" },
        { time = -7.5, action = "NAG:Cast(25361)" },
        { time = -6.0, action = "NAG:Cast(25359)" },
        { time = -4.5, action = "NAG:Cast(10438)" },
        { time = -3.0, action = "NAG:Cast(20572)" },
        { time = -1.5, action = "NAG:Cast(440580)" }
    },
    rotationString = [[
NAG:Cast(440580)
    or NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or (NAG:CurrentManaPercent() <= 0.55) and NAG:Cast(NAG:GetBattlePotion())
    or ((NAG:AuraNumStacks(408505) >= 10) and NAG:DotIsActive(29228)) and NAG:Cast(408490)
    or ((NAG:NumberTargets() >= 2) and (NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(10605)
    or ((NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(15208)
    or NAG:Cast(17364)
    or NAG:Cast(11315)
    or ((not NAG:DotIsActive(29228)) and (NAG:RemainingTime() > 12)) and NAG:Cast(29228)
    or NAG:Cast(10414)
    or (NAG:AuraNumStacks(10432) <= 7) and NAG:Cast(10432)
    or ((not NAG:AuraIsActive(25361)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25361)
    or ((not NAG:AuraIsActive(25359)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25359)
        ]],

    -- Tracked IDs for optimization
    spells = {10414, 10432, 10605, 11315, 15208, 17364, 25359, 25361, 29228, 408490, 408505, 425336, 440580},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Elemental 3Target 1Min BiS Cleave Phase8 rotation
local elemental3Target1MinBiSCleavePhase8 = {
    name = "Shaman Elemental - 3Target_1Min_BiS_Cleave_Phase8 by APLParser",
    specIndex = 1,
    class = "SHAMAN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(10432)" },
        { time = -8.0, action = "NAG:Cast(25359)" },
        { time = -6.5, action = "NAG:Cast(25361)" },
        { time = -5.0, action = "NAG:Cast(10497)" },
        { time = -3.5, action = "NAG:Cast(10438)" }
    },
    rotationString = [[
NAG:Cast(425336)
    or NAG:AutocastOtherCooldowns()
    or (NAG:DotIsActive(29228) and (not NAG:SpellIsReady(408490))) and NAG:Cast(16166)
    or (NAG:DotRemainingTime(29228) < 3.0) and NAG:Cast(29228)
    or NAG:Multidot(29228, 1, 0.0)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(10605)
    or (NAG:DotRemainingTime(29228) >= NAG:SpellCastTime(408490)) and NAG:Cast(408490)
    or NAG:Cast(10605)
    or (NAG:AuraNumStacks(10432) >= 8) and NAG:Cast(10414)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(29228)
    or ((not NAG:DotIsActive(10438)) and (NAG:RemainingTime() >= 30.0) and (NAG:NumberTargets() <= 2)) and NAG:Cast(10438)
    or ((not NAG:DotIsActive(10587)) and (NAG:RemainingTime() >= 20) and (NAG:NumberTargets() >= 5)) and NAG:Cast(10587)
    or NAG:Cast(15208)
    or false and NAG:Cast(20572)
        ]],

    -- Tracked IDs for optimization
    spells = {10414, 10432, 10438, 10587, 10605, 15208, 16166, 20572, 29228, 408490, 425336},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Enhancement 2H 3Target 1Min BiS Cleave Phase8 rotation
local enhancement2H3Target1MinBiSCleavePhase8 = {
    name = "Shaman Enhancement - 2H_3Target_1Min_BiS_Cleave_Phase8 by APLParser",
    specIndex = 2,
    class = "SHAMAN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(10432)" },
        { time = -7.5, action = "NAG:Cast(25359)" },
        { time = -6.0, action = "NAG:Cast(25361)" },
        { time = -4.5, action = "NAG:Cast(10438)" },
        { time = -3.0, action = "NAG:Cast(20572)" },
        { time = -1.5, action = "NAG:Cast(440580)" },
        { time = -1.0, action = "NAG:Cast(26297)" }
    },
    rotationString = [[
NAG:Cast(440580)
    or NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or ((NAG:AuraNumStacks(408505) >= 10) and (NAG:NumberTargets() >= 2)) and NAG:Cast(10605)
    or ((NAG:AutoTimeToNext() >= (NAG:SpellCastTime(408490) + 0.1)) and (NAG:AuraNumStacks(408505) >= 10) and (NAG:DotRemainingTime(29228) >= (NAG:SpellCastTime(408490) + 0.1))) and NAG:Cast(408490)
    or ((NAG:AutoTimeToNext() >= (NAG:SpellCastTime(15208) + 0.1)) and (NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(15208)
    or NAG:Cast(17364)
    or (not NAG:DotIsActive(29228)) and NAG:Cast(29228)
    or (NAG:AuraNumStacks(10432) <= 7) and NAG:Cast(10432)
    or NAG:Cast(11315)
    or NAG:Cast(10414)
    or (NAG:CurrentManaPercent() <= 0.55) and NAG:Cast(NAG:GetBattlePotion())
    or ((not NAG:AuraIsActive(25361)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25361)
    or ((not NAG:AuraIsActive(25359)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25359)
        ]],

    -- Tracked IDs for optimization
    spells = {10414, 10432, 10605, 11315, 15208, 17364, 25359, 25361, 29228, 408490, 408505, 425336, 440580},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Enhancement 3Target 1Min BiS Cleave DW Phase8 rotation
local enhancement3Target1MinBiSCleaveDWPhase8 = {
    name = "Shaman Enhancement - 3Target_1Min_BiS_Cleave_DW_Phase8 by APLParser",
    specIndex = 2,
    class = "SHAMAN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(10432)" },
        { time = -7.5, action = "NAG:Cast(25361)" },
        { time = -6.0, action = "NAG:Cast(25359)" },
        { time = -4.5, action = "NAG:Cast(10438)" },
        { time = -3.0, action = "NAG:Cast(20572)" },
        { time = -1.5, action = "NAG:Cast(440580)" }
    },
    rotationString = [[
NAG:Cast(440580)
    or NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or (NAG:CurrentManaPercent() <= 0.55) and NAG:Cast(NAG:GetBattlePotion())
    or ((NAG:NumberTargets() >= 2) and (NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(10605)
    or ((NAG:AuraNumStacks(408505) >= 10) and NAG:DotIsActive(29228)) and NAG:Cast(408490)
    or ((NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(15208)
    or NAG:Cast(17364)
    or NAG:Cast(11315)
    or ((not NAG:DotIsActive(29228)) and (NAG:RemainingTime() > 12)) and NAG:Cast(29228)
    or NAG:Cast(10414)
    or (NAG:AuraNumStacks(10432) <= 7) and NAG:Cast(10432)
    or ((not NAG:AuraIsActive(25361)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25361)
    or ((not NAG:AuraIsActive(25359)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25359)
        ]],

    -- Tracked IDs for optimization
    spells = {10414, 10432, 10605, 11315, 15208, 17364, 25359, 25361, 29228, 408490, 408505, 425336, 440580},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Elemental 4Target 1Min BiS Cleave Phase8 rotation
local elemental4Target1MinBiSCleavePhase8 = {
    name = "Shaman Elemental - 4Target_1Min_BiS_Cleave_Phase8 by APLParser",
    specIndex = 1,
    class = "SHAMAN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(10432)" },
        { time = -8.0, action = "NAG:Cast(25359)" },
        { time = -6.5, action = "NAG:Cast(25361)" },
        { time = -5.0, action = "NAG:Cast(10497)" },
        { time = -3.5, action = "NAG:Cast(10438)" }
    },
    rotationString = [[
NAG:Cast(425336)
    or NAG:AutocastOtherCooldowns()
    or (NAG:DotIsActive(29228) and (not NAG:SpellIsReady(408490))) and NAG:Cast(16166)
    or (NAG:DotRemainingTime(29228) < 3.0) and NAG:Cast(29228)
    or NAG:Multidot(29228, 1, 0.0)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(10605)
    or (NAG:DotRemainingTime(29228) >= NAG:SpellCastTime(408490)) and NAG:Cast(408490)
    or NAG:Cast(10605)
    or (NAG:AuraNumStacks(10432) >= 8) and NAG:Cast(10414)
    or (NAG:NumberTargets() >= 2) and NAG:Cast(29228)
    or ((not NAG:DotIsActive(10438)) and (NAG:RemainingTime() >= 30.0) and (NAG:NumberTargets() <= 2)) and NAG:Cast(10438)
    or ((not NAG:DotIsActive(10587)) and (NAG:RemainingTime() >= 20) and (NAG:NumberTargets() >= 5)) and NAG:Cast(10587)
    or NAG:Cast(15208)
    or false and NAG:Cast(20572)
        ]],

    -- Tracked IDs for optimization
    spells = {10414, 10432, 10438, 10587, 10605, 15208, 16166, 20572, 29228, 408490, 425336},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Enhancement 2H 4Target 1Min BiS Cleave Phase8 rotation
local enhancement2H4Target1MinBiSCleavePhase8 = {
    name = "Shaman Enhancement - 2H_4Target_1Min_BiS_Cleave_Phase8 by APLParser",
    specIndex = 2,
    class = "SHAMAN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(10432)" },
        { time = -7.5, action = "NAG:Cast(25359)" },
        { time = -6.0, action = "NAG:Cast(25361)" },
        { time = -4.5, action = "NAG:Cast(10438)" },
        { time = -3.0, action = "NAG:Cast(20572)" },
        { time = -1.5, action = "NAG:Cast(440580)" },
        { time = -1.0, action = "NAG:Cast(26297)" }
    },
    rotationString = [[
NAG:Cast(440580)
    or NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or ((NAG:AuraNumStacks(408505) >= 10) and (NAG:NumberTargets() >= 2)) and NAG:Cast(10605)
    or ((NAG:AutoTimeToNext() >= (NAG:SpellCastTime(408490) + 0.1)) and (NAG:AuraNumStacks(408505) >= 10) and (NAG:DotRemainingTime(29228) >= (NAG:SpellCastTime(408490) + 0.1))) and NAG:Cast(408490)
    or ((NAG:AutoTimeToNext() >= (NAG:SpellCastTime(15208) + 0.1)) and (NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(15208)
    or NAG:Cast(17364)
    or (not NAG:DotIsActive(29228)) and NAG:Cast(29228)
    or (NAG:AuraNumStacks(10432) <= 7) and NAG:Cast(10432)
    or NAG:Cast(11315)
    or NAG:Cast(10414)
    or (NAG:CurrentManaPercent() <= 0.55) and NAG:Cast(NAG:GetBattlePotion())
    or ((not NAG:AuraIsActive(25361)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25361)
    or ((not NAG:AuraIsActive(25359)) and (NAG:RemainingTime() > 12)) and NAG:Cast(25359)
        ]],

    -- Tracked IDs for optimization
    spells = {10414, 10432, 10605, 11315, 15208, 17364, 25359, 25361, 29228, 408490, 408505, 425336, 440580},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Enhancement 4Target 1Min BiS Cleave DW Phase8 rotation
local enhancement4Target1MinBiSCleaveDWPhase8 = {
    name = "Shaman Enhancement - 4Target_1Min_BiS_Cleave_DW_Phase8 by APLParser",
    specIndex = 2,
    class = "SHAMAN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(10432)" },
        { time = -7.5, action = "NAG:Cast(25361)" },
        { time = -6.0, action = "NAG:Cast(25359)" },
        { time = -4.5, action = "NAG:Cast(10438)" },
        { time = -3.0, action = "NAG:Cast(20572)" },
        { time = -1.5, action = "NAG:Cast(440580)" }
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(425336)
    or ((NAG:AuraNumStacks(408505) >= 10) and (NAG:NumberTargets() >= 2)) and NAG:Cast(10605)
    or ((NAG:AuraNumStacks(408505) >= 10)) and NAG:Cast(15208)
    or NAG:Cast(17364)
    or NAG:Cast(11315)
    or NAG:Cast(408507)
    or ((not NAG:AuraIsActive(10432)) and (NAG:RemainingTime() >= 3.0)) and NAG:Cast(10432)
    or ((not NAG:DotIsActive(29228)) and (NAG:RemainingTime() > 12)) and NAG:Cast(29228)
    or NAG:Cast(10414)
        ]],

    -- Tracked IDs for optimization
    spells = {10414, 10432, 10605, 11315, 15208, 17364, 29228, 408505, 408507, 425336},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

--- @class SHAMAN : ClassBase
local SHAMAN = NAG:CreateClassModule("SHAMAN", defaults)

--- Setup class defaults with all rotations
function SHAMAN:SetupClassDefaults()
    -- Add all rotation definitions to defaults
    ns.AddRotationToDefaults(self.defaults, 2, enhancement3MinDWPhase8PreRaid)  -- enhancement3MinDWPhase8PreRaid)
    ns.AddRotationToDefaults(self.defaults, 1, elemental3MinPhase8PreRaid)  -- elemental3MinPhase8PreRaid)
    ns.AddRotationToDefaults(self.defaults, 2, enhancement2H3MinPhase8PreRaid)  -- enhancement2H3MinPhase8PreRaid)
    ns.AddRotationToDefaults(self.defaults, 2, enhancement5MinDWPhase8PreRaid)  -- enhancement5MinDWPhase8PreRaid)
    ns.AddRotationToDefaults(self.defaults, 1, elemental5MinPhase8PreRaid)  -- elemental5MinPhase8PreRaid)
    ns.AddRotationToDefaults(self.defaults, 2, enhancement2H5MinPhase8PreRaid)  -- enhancement2H5MinPhase8PreRaid)
    ns.AddRotationToDefaults(self.defaults, 2, enhancement1Target1Min2HBiSPhase8ST)  -- enhancement1Target1Min2HBiSPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 1, elemental1Target1MinBiSPhase8ST)  -- elemental1Target1MinBiSPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 2, enhancement1Target1MinBiSDWPhase8ST)  -- enhancement1Target1MinBiSDWPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 1, elemental1Target2MinBiSPhase8ST)  -- elemental1Target2MinBiSPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 2, enhancement1Target2Min2HBiSPhase8ST)  -- enhancement1Target2Min2HBiSPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 2, enhancement1Target2MinBiSDWPhase8ST)  -- enhancement1Target2MinBiSDWPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 1, elemental1Target3MinBiSPhase8ST)  -- elemental1Target3MinBiSPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 2, enhancement1Target3Min2HBiSPhase8ST)  -- enhancement1Target3Min2HBiSPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 2, enhancement1Target3MinBiSDWPhase8ST)  -- enhancement1Target3MinBiSDWPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 1, elemental2Target1MinBiSCleavePhase8)  -- elemental2Target1MinBiSCleavePhase8)
    ns.AddRotationToDefaults(self.defaults, 2, enhancement2H2Target1MinBiSCleavePhase8)  -- enhancement2H2Target1MinBiSCleavePhase8)
    ns.AddRotationToDefaults(self.defaults, 2, enhancement2Target1MinBiSCleaveDWPhase8)  -- enhancement2Target1MinBiSCleaveDWPhase8)
    ns.AddRotationToDefaults(self.defaults, 1, elemental3Target1MinBiSCleavePhase8)  -- elemental3Target1MinBiSCleavePhase8)
    ns.AddRotationToDefaults(self.defaults, 2, enhancement2H3Target1MinBiSCleavePhase8)  -- enhancement2H3Target1MinBiSCleavePhase8)
    ns.AddRotationToDefaults(self.defaults, 2, enhancement3Target1MinBiSCleaveDWPhase8)  -- enhancement3Target1MinBiSCleaveDWPhase8)
    ns.AddRotationToDefaults(self.defaults, 1, elemental4Target1MinBiSCleavePhase8)  -- elemental4Target1MinBiSCleavePhase8)
    ns.AddRotationToDefaults(self.defaults, 2, enhancement2H4Target1MinBiSCleavePhase8)  -- enhancement2H4Target1MinBiSCleavePhase8)
    ns.AddRotationToDefaults(self.defaults, 2, enhancement4Target1MinBiSCleaveDWPhase8)  -- enhancement4Target1MinBiSCleaveDWPhase8)
end

if not SHAMAN then return end
NAG.Class = SHAMAN
