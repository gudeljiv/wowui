local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
if not Version:IsSoD() then return end

if UnitClassBase('player') ~= "WARLOCK" then return end

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
        id = "curse_of_elements",
        name = "Curse of the Elements",
        description = "Apply magic vulnerability debuff (coordinate with other Warlocks - only one curse per target)",
        spellIds = {1490, 11721, 11722}, -- All ranks
        category = "debuff",
    },
    {
        id = "curse_of_recklessness",
        name = "Curse of Recklessness",
        description = "Reduce target armor and remove fear effects (coordinate with other Warlocks)",
        spellIds = {704, 7658, 7659, 11717}, -- All ranks
        category = "debuff",
    },
    {
        id = "curse_of_shadow",
        name = "Curse of Shadow",
        description = "Increase shadow and arcane damage taken (coordinate with other Warlocks)",
        spellIds = {17862, 17937}, -- All ranks
        category = "debuff",
    },
}

-- Affliction 3Min Affliction Phase8 PreRaid rotation
local affliction3MinAfflictionPhase8PreRaid = {
    name = "Warlock Affliction - 3Min_Affliction_Phase8_PreRaid by APLParser",
    specIndex = 1,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25)) and NAG:Cast(12662)
    or NAG:AutocastOtherCooldowns()
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() > 10.0)) and NAG:Cast(11689)
    or NAG:Cast(18288)
    or (NAG:RemainingTime() >= 18.0) and NAG:Multidot(11713, 1, NAG:SpellCastTime(11713))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(427717, 1, NAG:SpellCastTime(427717))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or NAG:Cast(403501)
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 11700, 11713, 18288, 18871, 25307, 25311, 403501, 426320, 427717},
    items = {12662, 13444},
    auras = {},
    runes = {403668},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Destruction 3Min Fire Phase8 PreRaid rotation
local destruction3MinFirePhase8PreRaid = {
    name = "Warlock Destruction - 3Min_Destruction_DestructionFire_Fire_Phase8_PreRaid by APLParser",
    specIndex = 3,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:RemainingTime() <= 2.5) and NAG:Cast(17923)
    or (NAG:AuraRemainingTime(412758) < NAG:SpellCastTime(412758)) and NAG:Cast(412758)
    or (NAG:RemainingTime() >= 5.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or (NAG:AuraNumStacks(1214088) <= 1) and NAG:Cast(18932)
    or (not NAG:AuraIsActive(427714)) and NAG:Cast(18932)
    or NAG:Cast(403629)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(412758)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 17923, 18871, 18932, 403629, 412758, 426320, 427714, 1214088},
    items = {12662, 13444},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Demonology 3Min Phase8 PreRaid rotation
local demonology3MinPhase8PreRaid = {
    name = "Warlock Demonology - 3Min_Demonology_Phase8_PreRaid by APLParser",
    specIndex = 2,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() >= 10)) and NAG:Cast(11689)
    or (NAG:RemainingTime() >= 18.0) and NAG:Multidot(11713, 1, NAG:SpellCastTime(11713))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or (NAG:RemainingTime() >= 6.0) and NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(427717, 1, NAG:SpellCastTime(427717))
    or NAG:Cast(403501)
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 11700, 11713, 18871, 25307, 25311, 403501, 426320, 427717},
    items = {12662, 13444},
    auras = {},
    runes = {403668},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Destruction 3Min Shadow Phase8 PreRaid rotation
local destruction3MinShadowPhase8PreRaid = {
    name = "Warlock Destruction - 3Min_Destruction_DestructionShadow_Phase8_PreRaid by APLParser",
    specIndex = 3,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25)) and NAG:Cast(12662)
    or (NAG:AuraIsKnown(448686) and (not NAG:DotIsActive(11713))) and NAG:StrictSequence("foo", NAG:Cast(448686))
    or (NAG:AuraIsKnown(448686) and (not NAG:DotIsActive(11713))) and NAG:StrictSequence("foo", NAG:Cast(18288), NAG:Multidot(11713, 1, 0.0))
    or false and NAG:Cast(448686)
    or false and NAG:Cast(20572)
    or NAG:AutocastOtherCooldowns()
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() > 10.0)) and NAG:Cast(11689)
    or (NAG:AuraIsKnown(426311) and NAG:AuraIsActive(426311) and (not NAG:DotIsActive(11713))) and NAG:StrictSequence("foo", NAG:Cast(18288), NAG:Cast(11713))
    or (NAG:AuraIsKnown(426311) and NAG:AuraIsActive(426311) and (not NAG:DotIsActive(11713))) and NAG:Multidot(11713, 1, 0.0)
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(427717, 1, NAG:SpellCastTime(427717))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or NAG:Cast(403501)
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 11700, 11713, 18288, 18871, 20572, 25307, 25311, 403501, 426311, 426320, 427717, 448686},
    items = {12662, 13444},
    auras = {},
    runes = {403668},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Affliction 5Min Phase8 PreRaid rotation
local affliction5MinPhase8PreRaid = {
    name = "Warlock Affliction - 5Min_Affliction_Phase8_PreRaid by APLParser",
    specIndex = 1,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25)) and NAG:Cast(12662)
    or NAG:AutocastOtherCooldowns()
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() > 10.0)) and NAG:Cast(11689)
    or NAG:Cast(18288)
    or (NAG:RemainingTime() >= 18.0) and NAG:Multidot(11713, 1, NAG:SpellCastTime(11713))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(427717, 1, NAG:SpellCastTime(427717))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or NAG:Cast(403501)
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 11700, 11713, 18288, 18871, 25307, 25311, 403501, 426320, 427717},
    items = {12662, 13444},
    auras = {},
    runes = {403668},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Destruction 5Min Fire Phase8 PreRaid rotation
local destruction5MinFirePhase8PreRaid = {
    name = "Warlock Destruction - 5Min_Destruction_DestructionFire_Fire_Phase8_PreRaid by APLParser",
    specIndex = 3,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:RemainingTime() <= 2.5) and NAG:Cast(17923)
    or (NAG:AuraRemainingTime(412758) < NAG:SpellCastTime(412758)) and NAG:Cast(412758)
    or (NAG:RemainingTime() >= 5.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or (NAG:AuraNumStacks(1214088) <= 1) and NAG:Cast(18932)
    or (not NAG:AuraIsActive(427714)) and NAG:Cast(18932)
    or NAG:Cast(403629)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(412758)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 17923, 18871, 18932, 403629, 412758, 426320, 427714, 1214088},
    items = {12662, 13444},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Demonology 5Min Phase8 PreRaid rotation
local demonology5MinPhase8PreRaid = {
    name = "Warlock Demonology - 5Min_Demonology_Phase8_PreRaid by APLParser",
    specIndex = 2,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() >= 10)) and NAG:Cast(11689)
    or (NAG:RemainingTime() >= 18.0) and NAG:Multidot(11713, 1, NAG:SpellCastTime(11713))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or (NAG:RemainingTime() >= 6.0) and NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(427717, 1, NAG:SpellCastTime(427717))
    or NAG:Cast(403501)
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 11700, 11713, 18871, 25307, 25311, 403501, 426320, 427717},
    items = {12662, 13444},
    auras = {},
    runes = {403668},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Destruction 5Min Shadow Phase8 PreRaid rotation
local destruction5MinShadowPhase8PreRaid = {
    name = "Warlock Destruction - 5Min_Destruction_DestructionShadow_Phase8_PreRaid by APLParser",
    specIndex = 3,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25)) and NAG:Cast(12662)
    or (NAG:AuraIsKnown(448686) and (not NAG:DotIsActive(11713))) and NAG:StrictSequence("foo", NAG:Cast(448686))
    or (NAG:AuraIsKnown(448686) and (not NAG:DotIsActive(11713))) and NAG:StrictSequence("foo", NAG:Cast(18288), NAG:Multidot(11713, 1, 0.0))
    or false and NAG:Cast(448686)
    or false and NAG:Cast(20572)
    or NAG:AutocastOtherCooldowns()
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() > 10.0)) and NAG:Cast(11689)
    or (NAG:AuraIsKnown(426311) and NAG:AuraIsActive(426311) and (not NAG:DotIsActive(11713))) and NAG:StrictSequence("foo", NAG:Cast(18288), NAG:Cast(11713))
    or (NAG:AuraIsKnown(426311) and NAG:AuraIsActive(426311) and (not NAG:DotIsActive(11713))) and NAG:Multidot(11713, 1, 0.0)
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(427717, 1, NAG:SpellCastTime(427717))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or NAG:Cast(403501)
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 11700, 11713, 18288, 18871, 20572, 25307, 25311, 403501, 426311, 426320, 427717, 448686},
    items = {12662, 13444},
    auras = {},
    runes = {403668},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Destruction 1Target 1Min BiS Fire Phase8 ST rotation
local destruction1Target1MinBiSFirePhase8ST = {
    name = "Warlock Destruction - 1Target_1Min_BiS_Destruction_DestructionFire_Fire_Phase8_ST by APLParser",
    specIndex = 3,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:RemainingTime() <= 2.5) and NAG:Cast(17923)
    or (NAG:AuraNumStacks(1214088) <= 1) and NAG:Cast(18932)
    or (not NAG:AuraIsActive(427714)) and NAG:Cast(18932)
    or ((NAG:RemainingTime() >= 5.0) and (not NAG:RuneIsEquipped(426320))) and NAG:Multidot(25309, 1, NAG:SpellCastTime(25309))
    or NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or (NAG:AuraRemainingTime(412758) < NAG:SpellCastTime(412758)) and NAG:Cast(412758)
    or (NAG:IsExecutePhase(35) and (NAG:AuraRemainingTime(440873) < NAG:SpellCastTime(412758))) and NAG:Cast(412758)
    or NAG:Cast(403629)
    or (NAG:AuraIsActive(440873) and NAG:RuneIsEquipped(440870)) and NAG:Cast(17924)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(412758)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 17923, 17924, 18871, 18932, 25309, 25311, 403629, 412758, 427714, 440873, 1214088},
    items = {12662, 13444},
    auras = {},
    runes = {426320, 440870},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Affliction 1Target 1Min BiS Phase8 ST rotation
local affliction1Target1MinBiSPhase8ST = {
    name = "Warlock Affliction - 1Target_1Min_Affliction_BiS_Phase8_ST by APLParser",
    specIndex = 1,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25)) and NAG:Cast(12662)
    or NAG:AutocastOtherCooldowns()
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() > 10.0)) and NAG:Cast(11689)
    or NAG:Cast(18288)
    or (NAG:RemainingTime() >= 18.0) and NAG:Multidot(11713, 1, NAG:SpellCastTime(11713))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(427717, 1, NAG:SpellCastTime(427717))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or NAG:Cast(403501)
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 11700, 11713, 18288, 18871, 25307, 25311, 403501, 426320, 427717},
    items = {12662, 13444},
    auras = {},
    runes = {403668},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Demonology 1Target 1Min BiS Phase8 ST rotation
local demonology1Target1MinBiSPhase8ST = {
    name = "Warlock Demonology - 1Target_1Min_BiS_Demonology_Phase8_ST by APLParser",
    specIndex = 2,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() >= 10)) and NAG:Cast(11689)
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or (NAG:RemainingTime() >= 18.0) and NAG:Multidot(11713, 1, 0.0)
    or (NAG:RemainingTime() >= 6.0) and NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(427717, 1, NAG:SpellCastTime(427717))
    or NAG:Cast(403501)
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or (NAG:AuraIsKnown(17941) and NAG:AuraIsActive(17941)) and NAG:Cast(25307)
    or NAG:Cast(25307)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 11700, 11713, 17941, 18871, 25307, 25311, 403501, 426320, 427717},
    items = {12662, 13444},
    auras = {},
    runes = {403668},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Destruction 1Target 1Min BiS Shadow Phase8 ST rotation
local destruction1Target1MinBiSShadowPhase8ST = {
    name = "Warlock Destruction - 1Target_1Min_BiS_Destruction_DestructionShadow_Phase8_ST by APLParser",
    specIndex = 3,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:RemainingTime() <= 1.5) and NAG:Cast(17923)
    or (not NAG:AuraIsActive(427714)) and NAG:Cast(18932)
    or (NAG:RemainingTime() >= 5.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 17923, 18871, 18932, 25307, 25311, 426320, 427714},
    items = {12662, 13444},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Destruction 1Target 2Min BiS Fire Phase8 ST rotation
local destruction1Target2MinBiSFirePhase8ST = {
    name = "Warlock Destruction - 1Target_2Min_BiS_Destruction_DestructionFire_Fire_Phase8_ST by APLParser",
    specIndex = 3,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:RemainingTime() <= 2.5) and NAG:Cast(17923)
    or (NAG:AuraNumStacks(1214088) <= 1) and NAG:Cast(18932)
    or (not NAG:AuraIsActive(427714)) and NAG:Cast(18932)
    or ((NAG:RemainingTime() >= 5.0) and (not NAG:RuneIsEquipped(426320))) and NAG:Multidot(25309, 1, NAG:SpellCastTime(25309))
    or NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or (NAG:AuraRemainingTime(412758) < NAG:SpellCastTime(412758)) and NAG:Cast(412758)
    or (NAG:IsExecutePhase(35) and (NAG:AuraRemainingTime(440873) < NAG:SpellCastTime(412758))) and NAG:Cast(412758)
    or NAG:Cast(403629)
    or (NAG:AuraIsActive(440873) and NAG:RuneIsEquipped(440870)) and NAG:Cast(17924)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(412758)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 17923, 17924, 18871, 18932, 25309, 25311, 403629, 412758, 427714, 440873, 1214088},
    items = {12662, 13444},
    auras = {},
    runes = {426320, 440870},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Affliction 1Target 2Min BiS Phase8 ST rotation
local affliction1Target2MinBiSPhase8ST = {
    name = "Warlock Affliction - 1Target_2Min_Affliction_BiS_Phase8_ST by APLParser",
    specIndex = 1,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25)) and NAG:Cast(12662)
    or NAG:AutocastOtherCooldowns()
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() > 10.0)) and NAG:Cast(11689)
    or NAG:Cast(18288)
    or (NAG:RemainingTime() >= 18.0) and NAG:Multidot(11713, 1, NAG:SpellCastTime(11713))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(427717, 1, NAG:SpellCastTime(427717))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or NAG:Cast(403501)
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 11700, 11713, 18288, 18871, 25307, 25311, 403501, 426320, 427717},
    items = {12662, 13444},
    auras = {},
    runes = {403668},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Demonology 1Target 2Min BiS Phase8 ST rotation
local demonology1Target2MinBiSPhase8ST = {
    name = "Warlock Demonology - 1Target_2Min_BiS_Demonology_Phase8_ST by APLParser",
    specIndex = 2,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() >= 10)) and NAG:Cast(11689)
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or (NAG:RemainingTime() >= 18.0) and NAG:Multidot(11713, 1, 0.0)
    or (NAG:RemainingTime() >= 6.0) and NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(427717, 1, NAG:SpellCastTime(427717))
    or NAG:Cast(403501)
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or (NAG:AuraIsKnown(17941) and NAG:AuraIsActive(17941)) and NAG:Cast(25307)
    or NAG:Cast(25307)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 11700, 11713, 17941, 18871, 25307, 25311, 403501, 426320, 427717},
    items = {12662, 13444},
    auras = {},
    runes = {403668},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Destruction 1Target 2Min BiS Shadow Phase8 ST rotation
local destruction1Target2MinBiSShadowPhase8ST = {
    name = "Warlock Destruction - 1Target_2Min_BiS_Destruction_DestructionShadow_Phase8_ST by APLParser",
    specIndex = 3,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:RemainingTime() <= 1.5) and NAG:Cast(17923)
    or (not NAG:AuraIsActive(427714)) and NAG:Cast(18932)
    or (NAG:RemainingTime() >= 5.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 17923, 18871, 18932, 25307, 25311, 426320, 427714},
    items = {12662, 13444},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Destruction 1Target 3Min BiS Fire Phase8 ST rotation
local destruction1Target3MinBiSFirePhase8ST = {
    name = "Warlock Destruction - 1Target_3Min_BiS_Destruction_DestructionFire_Fire_Phase8_ST by APLParser",
    specIndex = 3,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:RemainingTime() <= 2.5) and NAG:Cast(17923)
    or (NAG:AuraNumStacks(1214088) <= 1) and NAG:Cast(18932)
    or (not NAG:AuraIsActive(427714)) and NAG:Cast(18932)
    or ((NAG:RemainingTime() >= 5.0) and (not NAG:RuneIsEquipped(426320))) and NAG:Multidot(25309, 1, NAG:SpellCastTime(25309))
    or NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or (NAG:AuraRemainingTime(412758) < NAG:SpellCastTime(412758)) and NAG:Cast(412758)
    or (NAG:IsExecutePhase(35) and (NAG:AuraRemainingTime(440873) < NAG:SpellCastTime(412758))) and NAG:Cast(412758)
    or NAG:Cast(403629)
    or (NAG:AuraIsActive(440873) and NAG:RuneIsEquipped(440870)) and NAG:Cast(17924)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(412758)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 17923, 17924, 18871, 18932, 25309, 25311, 403629, 412758, 427714, 440873, 1214088},
    items = {12662, 13444},
    auras = {},
    runes = {426320, 440870},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Affliction 1Target 3Min BiS Phase8 ST rotation
local affliction1Target3MinBiSPhase8ST = {
    name = "Warlock Affliction - 1Target_3Min_Affliction_BiS_Phase8_ST by APLParser",
    specIndex = 1,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25)) and NAG:Cast(12662)
    or NAG:AutocastOtherCooldowns()
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() > 10.0)) and NAG:Cast(11689)
    or NAG:Cast(18288)
    or (NAG:RemainingTime() >= 18.0) and NAG:Multidot(11713, 1, NAG:SpellCastTime(11713))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(427717, 1, NAG:SpellCastTime(427717))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or NAG:Cast(403501)
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 11700, 11713, 18288, 18871, 25307, 25311, 403501, 426320, 427717},
    items = {12662, 13444},
    auras = {},
    runes = {403668},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Demonology 1Target 3Min BiS Phase8 ST rotation
local demonology1Target3MinBiSPhase8ST = {
    name = "Warlock Demonology - 1Target_3Min_BiS_Demonology_Phase8_ST by APLParser",
    specIndex = 2,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() >= 10)) and NAG:Cast(11689)
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or (NAG:RemainingTime() >= 18.0) and NAG:Multidot(11713, 1, 0.0)
    or (NAG:RemainingTime() >= 6.0) and NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(427717, 1, NAG:SpellCastTime(427717))
    or NAG:Cast(403501)
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or (NAG:AuraIsKnown(17941) and NAG:AuraIsActive(17941)) and NAG:Cast(25307)
    or NAG:Cast(25307)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 11700, 11713, 17941, 18871, 25307, 25311, 403501, 426320, 427717},
    items = {12662, 13444},
    auras = {},
    runes = {403668},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Destruction 1Target 3Min BiS Shadow Phase8 ST rotation
local destruction1Target3MinBiSShadowPhase8ST = {
    name = "Warlock Destruction - 1Target_3Min_BiS_Destruction_DestructionShadow_Phase8_ST by APLParser",
    specIndex = 3,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:RemainingTime() <= 1.5) and NAG:Cast(17923)
    or (not NAG:AuraIsActive(427714)) and NAG:Cast(18932)
    or (NAG:RemainingTime() >= 5.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or NAG:Multidot(25311, 1, NAG:SpellCastTime(25311))
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 17923, 18871, 18932, 25307, 25311, 426320, 427714},
    items = {12662, 13444},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Affliction 2Target 1Min BiS Cleave Phase8 rotation
local affliction2Target1MinBiSCleavePhase8 = {
    name = "Warlock Affliction - 2Target_1Min_Affliction_BiS_Cleave_Phase8 by APLParser",
    specIndex = 1,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25)) and NAG:Cast(12662)
    or NAG:AutocastOtherCooldowns()
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() > 10.0)) and NAG:Cast(11689)
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(25311, 2, NAG:SpellCastTime(25311))
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 11700, 18871, 25307, 25311},
    items = {12662, 13444},
    auras = {},
    runes = {403668},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Demonology 2Target 1Min BiS Cleave Phase8 rotation
local demonology2Target1MinBiSCleavePhase8 = {
    name = "Warlock Demonology - 2Target_1Min_BiS_Cleave_Demonology_Phase8 by APLParser",
    specIndex = 2,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() >= 10)) and NAG:Cast(11689)
    or (NAG:RemainingTime() >= 6.0) and NAG:Multidot(25311, 2, NAG:SpellCastTime(25311))
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 11700, 18871, 25307, 25311},
    items = {12662, 13444},
    auras = {},
    runes = {403668},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Destruction 2Target 1Min BiS Cleave Shadow Phase8 rotation
local destruction2Target1MinBiSCleaveShadowPhase8 = {
    name = "Warlock Destruction - 2Target_1Min_BiS_Cleave_Destruction_DestructionShadow_Phase8 by APLParser",
    specIndex = 3,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (not NAG:AuraIsActive(427714)) and NAG:Cast(18932)
    or (NAG:RemainingTime() >= 5.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or NAG:Multidot(25311, 2, NAG:SpellCastTime(25311))
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 18871, 18932, 25307, 25311, 426320, 427714},
    items = {12662, 13444},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Destruction 2Target 1Min BiS Cleave Fire Phase8 rotation
local destruction2Target1MinBiSCleaveFirePhase8 = {
    name = "Warlock Destruction - 2Target_1Min_BiS_Cleave_Destruction_DestructionFire_Fire_Phase8 by APLParser",
    specIndex = 3,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (not NAG:AuraIsActive(427714)) and NAG:Cast(18932)
    or (NAG:RemainingTime() >= 5.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or NAG:Multidot(25311, 2, NAG:SpellCastTime(25311))
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 18871, 18932, 25307, 25311, 426320, 427714},
    items = {12662, 13444},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Affliction 3Target 1Min BiS Cleave Phase8 rotation
local affliction3Target1MinBiSCleavePhase8 = {
    name = "Warlock Affliction - 3Target_1Min_Affliction_BiS_Cleave_Phase8 by APLParser",
    specIndex = 1,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25)) and NAG:Cast(12662)
    or NAG:AutocastOtherCooldowns()
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() > 10.0)) and NAG:Cast(11689)
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(25311, 3, NAG:SpellCastTime(25311))
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 11700, 18871, 25307, 25311},
    items = {12662, 13444},
    auras = {},
    runes = {403668},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Demonology 3Target 1Min BiS Cleave Phase8 rotation
local demonology3Target1MinBiSCleavePhase8 = {
    name = "Warlock Demonology - 3Target_1Min_BiS_Cleave_Demonology_Phase8 by APLParser",
    specIndex = 2,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() >= 10)) and NAG:Cast(11689)
    or (NAG:RemainingTime() >= 6.0) and NAG:Multidot(25311, 3, NAG:SpellCastTime(25311))
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 11700, 18871, 25307, 25311},
    items = {12662, 13444},
    auras = {},
    runes = {403668},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Destruction 3Target 1Min BiS Cleave Shadow Phase8 rotation
local destruction3Target1MinBiSCleaveShadowPhase8 = {
    name = "Warlock Destruction - 3Target_1Min_BiS_Cleave_Destruction_DestructionShadow_Phase8 by APLParser",
    specIndex = 3,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (not NAG:AuraIsActive(427714)) and NAG:Cast(18932)
    or (NAG:RemainingTime() >= 5.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or NAG:Multidot(25311, 3, NAG:SpellCastTime(25311))
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 18871, 18932, 25307, 25311, 426320, 427714},
    items = {12662, 13444},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Destruction 3Target 1Min BiS Cleave Fire Phase8 rotation
local destruction3Target1MinBiSCleaveFirePhase8 = {
    name = "Warlock Destruction - 3Target_1Min_BiS_Cleave_Destruction_DestructionFire_Fire_Phase8 by APLParser",
    specIndex = 3,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (not NAG:AuraIsActive(427714)) and NAG:Cast(18932)
    or (NAG:RemainingTime() >= 5.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or NAG:Multidot(25311, 3, NAG:SpellCastTime(25311))
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 18871, 18932, 25307, 25311, 426320, 427714},
    items = {12662, 13444},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Affliction 4Target 1Min BiS Cleave Phase8 rotation
local affliction4Target1MinBiSCleavePhase8 = {
    name = "Warlock Affliction - 4Target_1Min_Affliction_BiS_Cleave_Phase8 by APLParser",
    specIndex = 1,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25)) and NAG:Cast(12662)
    or NAG:AutocastOtherCooldowns()
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() > 10.0)) and NAG:Cast(11689)
    or (NAG:RemainingTime() >= 4.0) and NAG:Multidot(25311, 4, NAG:SpellCastTime(25311))
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 11700, 18871, 25307, 25311},
    items = {12662, 13444},
    auras = {},
    runes = {403668},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Demonology 4Target 1Min BiS Cleave Phase8 rotation
local demonology4Target1MinBiSCleavePhase8 = {
    name = "Warlock Demonology - 4Target_1Min_BiS_Cleave_Demonology_Phase8 by APLParser",
    specIndex = 2,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (NAG:WarlockPetIsActive() and (NAG:WarlockCurrentPetMana() < 800) and (NAG:RemainingTime() >= 10)) and NAG:Cast(11689)
    or (NAG:RemainingTime() >= 6.0) and NAG:Multidot(25311, 4, NAG:SpellCastTime(25311))
    or ((NAG:RemainingTime() >= 10.0) and NAG:RuneIsEquipped(403668)) and NAG:Multidot(11700, 1, 0.0)
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 11700, 18871, 25307, 25311},
    items = {12662, 13444},
    auras = {},
    runes = {403668},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Destruction 4Target 1Min BiS Cleave Shadow Phase8 rotation
local destruction4Target1MinBiSCleaveShadowPhase8 = {
    name = "Warlock Destruction - 4Target_1Min_BiS_Cleave_Destruction_DestructionShadow_Phase8 by APLParser",
    specIndex = 3,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (not NAG:AuraIsActive(427714)) and NAG:Cast(18932)
    or (NAG:RemainingTime() >= 5.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or NAG:Multidot(25311, 4, NAG:SpellCastTime(25311))
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 18871, 18932, 25307, 25311, 426320, 427714},
    items = {12662, 13444},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Destruction 4Target 1Min BiS Cleave Fire Phase8 rotation
local destruction4Target1MinBiSCleaveFirePhase8 = {
    name = "Warlock Destruction - 4Target_1Min_BiS_Cleave_Destruction_DestructionFire_Fire_Phase8 by APLParser",
    specIndex = 3,
    class = "WARLOCK",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions for this rotation
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.5) and NAG:IsExecutePhase(35)) and NAG:Cast(13444)
    or ((NAG:RemainingTime() >= 15.0) and (NAG:CurrentManaPercent() <= 0.25) and NAG:IsExecutePhase(35)) and NAG:Cast(12662)
    or (NAG:RemainingTime() <= 1.0) and NAG:Cast(18871)
    or (not NAG:AuraIsActive(427714)) and NAG:Cast(18932)
    or (NAG:RemainingTime() >= 5.0) and NAG:Multidot(426320, 1, NAG:SpellCastTime(426320))
    or NAG:Multidot(25311, 4, NAG:SpellCastTime(25311))
    or (NAG:CurrentManaPercent() < 0.1) and NAG:Cast(11689)
    or NAG:Cast(25307)
        ]],

    -- Tracked IDs for optimization
    spells = {11689, 18871, 18932, 25307, 25311, 426320, 427714},
    items = {12662, 13444},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

--- @class WARLOCK : ClassBase
local WARLOCK = NAG:CreateClassModule("WARLOCK", defaults)

--- Setup class defaults with all rotations
function WARLOCK:SetupClassDefaults()
    -- Add all rotation definitions to defaults
    ns.AddRotationToDefaults(self.defaults, 1, affliction3MinAfflictionPhase8PreRaid)  -- affliction3MinAfflictionPhase8PreRaid)
    ns.AddRotationToDefaults(self.defaults, 3, destruction3MinFirePhase8PreRaid)  -- destruction3MinFirePhase8PreRaid)
    ns.AddRotationToDefaults(self.defaults, 2, demonology3MinPhase8PreRaid)  -- demonology3MinPhase8PreRaid)
    ns.AddRotationToDefaults(self.defaults, 3, destruction3MinShadowPhase8PreRaid)  -- destruction3MinShadowPhase8PreRaid)
    ns.AddRotationToDefaults(self.defaults, 1, affliction5MinPhase8PreRaid)  -- affliction5MinPhase8PreRaid)
    ns.AddRotationToDefaults(self.defaults, 3, destruction5MinFirePhase8PreRaid)  -- destruction5MinFirePhase8PreRaid)
    ns.AddRotationToDefaults(self.defaults, 2, demonology5MinPhase8PreRaid)  -- demonology5MinPhase8PreRaid)
    ns.AddRotationToDefaults(self.defaults, 3, destruction5MinShadowPhase8PreRaid)  -- destruction5MinShadowPhase8PreRaid)
    ns.AddRotationToDefaults(self.defaults, 3, destruction1Target1MinBiSFirePhase8ST)  -- destruction1Target1MinBiSFirePhase8ST)
    ns.AddRotationToDefaults(self.defaults, 1, affliction1Target1MinBiSPhase8ST)  -- affliction1Target1MinBiSPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 2, demonology1Target1MinBiSPhase8ST)  -- demonology1Target1MinBiSPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 3, destruction1Target1MinBiSShadowPhase8ST)  -- destruction1Target1MinBiSShadowPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 3, destruction1Target2MinBiSFirePhase8ST)  -- destruction1Target2MinBiSFirePhase8ST)
    ns.AddRotationToDefaults(self.defaults, 1, affliction1Target2MinBiSPhase8ST)  -- affliction1Target2MinBiSPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 2, demonology1Target2MinBiSPhase8ST)  -- demonology1Target2MinBiSPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 3, destruction1Target2MinBiSShadowPhase8ST)  -- destruction1Target2MinBiSShadowPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 3, destruction1Target3MinBiSFirePhase8ST)  -- destruction1Target3MinBiSFirePhase8ST)
    ns.AddRotationToDefaults(self.defaults, 1, affliction1Target3MinBiSPhase8ST)  -- affliction1Target3MinBiSPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 2, demonology1Target3MinBiSPhase8ST)  -- demonology1Target3MinBiSPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 3, destruction1Target3MinBiSShadowPhase8ST)  -- destruction1Target3MinBiSShadowPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 1, affliction2Target1MinBiSCleavePhase8)  -- affliction2Target1MinBiSCleavePhase8)
    ns.AddRotationToDefaults(self.defaults, 2, demonology2Target1MinBiSCleavePhase8)  -- demonology2Target1MinBiSCleavePhase8)
    ns.AddRotationToDefaults(self.defaults, 3, destruction2Target1MinBiSCleaveShadowPhase8)  -- destruction2Target1MinBiSCleaveShadowPhase8)
    ns.AddRotationToDefaults(self.defaults, 3, destruction2Target1MinBiSCleaveFirePhase8)  -- destruction2Target1MinBiSCleaveFirePhase8)
    ns.AddRotationToDefaults(self.defaults, 1, affliction3Target1MinBiSCleavePhase8)  -- affliction3Target1MinBiSCleavePhase8)
    ns.AddRotationToDefaults(self.defaults, 2, demonology3Target1MinBiSCleavePhase8)  -- demonology3Target1MinBiSCleavePhase8)
    ns.AddRotationToDefaults(self.defaults, 3, destruction3Target1MinBiSCleaveShadowPhase8)  -- destruction3Target1MinBiSCleaveShadowPhase8)
    ns.AddRotationToDefaults(self.defaults, 3, destruction3Target1MinBiSCleaveFirePhase8)  -- destruction3Target1MinBiSCleaveFirePhase8)
    ns.AddRotationToDefaults(self.defaults, 1, affliction4Target1MinBiSCleavePhase8)  -- affliction4Target1MinBiSCleavePhase8)
    ns.AddRotationToDefaults(self.defaults, 2, demonology4Target1MinBiSCleavePhase8)  -- demonology4Target1MinBiSCleavePhase8)
    ns.AddRotationToDefaults(self.defaults, 3, destruction4Target1MinBiSCleaveShadowPhase8)  -- destruction4Target1MinBiSCleaveShadowPhase8)
    ns.AddRotationToDefaults(self.defaults, 3, destruction4Target1MinBiSCleaveFirePhase8)  -- destruction4Target1MinBiSCleaveFirePhase8)
end

if not WARLOCK then return end
NAG.Class = WARLOCK
