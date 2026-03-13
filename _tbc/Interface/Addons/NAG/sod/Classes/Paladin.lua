-- ============================ LOCALIZE ============================

local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
if not Version:IsSoD() then return end

if UnitClassBase('player') ~= "PALADIN" then return end

-- ============================ CONSTANTS ============================

-- ============================ MODULE DEFAULTS ============================

-- Initialize class defaults with standard structure
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
        id = "blessings",
        name = "Blessings (Kings/Might/Wisdom)",
        description = "Cast blessings on raid members (coordinate with other Paladins to cover all groups)",
        spellIds = {20217, 19740, 19742, 19834, 19835, 19836, 19837, 19838}, -- Kings, Might, Wisdom ranks
        category = "buff",
    },
}

-- Retribution 3Min Phase8 PreRaid Twisting rotation
local retribution3MinPhase8PreRaidTwisting = {
    name = "Paladin Retribution - 3Min_Phase8_PreRaid_Twisting by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions
    },
    rotationString = [[
((NAG:AutoTimeToNext() == NAG:AutoSwingTime()) and (NAG:AutoSwingTime() >= 1.99)) and NAG:Wait(0.2)
    or (NAG:CurrentTime() >= 2.4) and NAG:AutocastOtherCooldowns()
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() >= (NAG:AutoSwingTime() - 0.2)) and (NAG:AuraIsActive(20920) and NAG:AuraIsActive(407798))) and NAG:Cast(20271)
    or (NAG:AuraIsActive(407798) and (NAG:AutoSwingTime() < 1.99)) and NAG:PaladinCastWithMacro(20271, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (not NAG:AuraIsActive(407798)) and (NAG:RemainingTimePercent() < 0.1)) and NAG:PaladinCastWithMacro(407798, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (NAG:RemainingTimePercent() < 0.1)) and NAG:Cast(24239)
    or (((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(20920)) or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraRemainingTime(407798) < 2.0))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407798, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(407798) and ((not NAG:RuneIsEquipped(429152)) or (NAG:RemainingTimePercent() >= 0.1))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(20920, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:Cast(407778), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:Cast(415073), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(407676), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407778, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(415073, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49)) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407676, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:PaladinCastWithMacro(407778, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:PaladinCastWithMacro(415073, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(407676, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead))) and NAG:PaladinCastWithMacro(10318, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(20924, "target", 1)
        ]],

    -- Tracked IDs for optimization
    spells = {10318, 20271, 20920, 20924, 24239, 407676, 407778, 407798, 415073, 1219193},
    items = {},
    auras = {},
    runes = {429152},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 3Min Phase8 PreRaid SealStacking rotation
local retribution3MinPhase8PreRaidSealStacking = {
    name = "Paladin Retribution - 3Min_Phase8_PreRaid_SealStacking by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -3.0, action = "NAG:Cast(20920)" },
        { time = -1.5, action = "NAG:Cast(407798)" }
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(20920) <= 1.0) and NAG:Cast(20920)
    or (NAG:AuraRemainingTime(407798) <= 1.0) and NAG:Cast(407798)
    or (NAG:AuraIsActive(407798) and NAG:AuraIsActive(20920)) and NAG:Cast(20271)
    or NAG:Cast(407676)
    or NAG:Cast(407778)
    or NAG:Cast(415073)
    or (NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) and NAG:Cast(10318)
    or NAG:Cast(20924)
        ]],

    -- Tracked IDs for optimization
    spells = {10318, 20271, 20920, 20924, 407676, 407778, 407798, 415073, 1219193},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 3Min Exodin Phase8 PreRaid rotation
local retribution3MinExodinPhase8PreRaid = {
    name = "Paladin Retribution - 3Min_Exodin_Phase8_PreRaid by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:CurrentSealRemainingTime() <= 1.5) and NAG:GCDIsReady()) and NAG:StrictSequence("foo", NAG:Cast(20271), NAG:CastPaladinPrimarySeal())
    or NAG:AuraIsActive(426157) and NAG:Wait(NAG:AuraRemainingTime(426157))
    or NAG:Cast(415073)
    or NAG:Cast(407676)
    or NAG:Cast(407778)
    or (NAG:AuraIsKnown(1219191) and (NAG:SpellTimeToReady(415073) > 1.5)) and NAG:Cast(10318)
    or ((NAG:SpellTimeToReady(415073) > 1.5) and (NAG:SpellTimeToReady(407676) > 1.5)) and NAG:Cast(20924)
        ]],

    -- Tracked IDs for optimization
    spells = {10318, 20271, 20924, 407676, 407778, 415073, 426157, 1219191},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 3Min Phase8 PreRaid Wrath rotation
local retribution3MinPhase8PreRaidWrath = {
    name = "Paladin Retribution - 3Min_Phase8_PreRaid_Wrath by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or (NAG:CurrentSealRemainingTime() <= 1.0) and NAG:StrictSequence("foo", NAG:Cast(20271), NAG:CastPaladinPrimarySeal())
    or NAG:Cast(407778)
    or NAG:Cast(407676)
    or NAG:Cast(415073)
    or NAG:StrictSequence("foo", NAG:Cast(20271), NAG:CastPaladinPrimarySeal())
    or NAG:AuraIsKnown(1219191) and NAG:Cast(10318)
    or NAG:Cast(20924)
        ]],

    -- Tracked IDs for optimization
    spells = {10318, 20271, 20924, 407676, 407778, 415073, 1219191},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 5Min Phase8 PreRaid Twisting rotation
local retribution5MinPhase8PreRaidTwisting = {
    name = "Paladin Retribution - 5Min_Phase8_PreRaid_Twisting by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions
    },
    rotationString = [[
((NAG:AutoTimeToNext() == NAG:AutoSwingTime()) and (NAG:AutoSwingTime() >= 1.99)) and NAG:Wait(0.2)
    or (NAG:CurrentTime() >= 2.4) and NAG:AutocastOtherCooldowns()
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() >= (NAG:AutoSwingTime() - 0.2)) and (NAG:AuraIsActive(20920) and NAG:AuraIsActive(407798))) and NAG:Cast(20271)
    or (NAG:AuraIsActive(407798) and (NAG:AutoSwingTime() < 1.99)) and NAG:PaladinCastWithMacro(20271, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (not NAG:AuraIsActive(407798)) and (NAG:RemainingTimePercent() < 0.1)) and NAG:PaladinCastWithMacro(407798, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (NAG:RemainingTimePercent() < 0.1)) and NAG:Cast(24239)
    or (((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(20920)) or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraRemainingTime(407798) < 2.0))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407798, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(407798) and ((not NAG:RuneIsEquipped(429152)) or (NAG:RemainingTimePercent() >= 0.1))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(20920, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:Cast(407778), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:Cast(415073), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(407676), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407778, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(415073, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49)) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407676, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:PaladinCastWithMacro(407778, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:PaladinCastWithMacro(415073, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(407676, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead))) and NAG:PaladinCastWithMacro(10318, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(20924, "target", 1)
        ]],

    -- Tracked IDs for optimization
    spells = {10318, 20271, 20920, 20924, 24239, 407676, 407778, 407798, 415073, 1219193},
    items = {},
    auras = {},
    runes = {429152},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 5Min Phase8 PreRaid SealStacking rotation
local retribution5MinPhase8PreRaidSealStacking = {
    name = "Paladin Retribution - 5Min_Phase8_PreRaid_SealStacking by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -3.0, action = "NAG:Cast(20920)" },
        { time = -1.5, action = "NAG:Cast(407798)" }
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(20920) <= 1.0) and NAG:Cast(20920)
    or (NAG:AuraRemainingTime(407798) <= 1.0) and NAG:Cast(407798)
    or (NAG:AuraIsActive(407798) and NAG:AuraIsActive(20920)) and NAG:Cast(20271)
    or NAG:Cast(407676)
    or NAG:Cast(407778)
    or NAG:Cast(415073)
    or (NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) and NAG:Cast(10318)
    or NAG:Cast(20924)
        ]],

    -- Tracked IDs for optimization
    spells = {10318, 20271, 20920, 20924, 407676, 407778, 407798, 415073, 1219193},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 5Min Exodin Phase8 PreRaid rotation
local retribution5MinExodinPhase8PreRaid = {
    name = "Paladin Retribution - 5Min_Exodin_Phase8_PreRaid by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:CurrentSealRemainingTime() <= 1.5) and NAG:GCDIsReady()) and NAG:StrictSequence("foo", NAG:Cast(20271), NAG:CastPaladinPrimarySeal())
    or NAG:AuraIsActive(426157) and NAG:Wait(NAG:AuraRemainingTime(426157))
    or NAG:Cast(415073)
    or NAG:Cast(407676)
    or NAG:Cast(407778)
    or (NAG:AuraIsKnown(1219191) and (NAG:SpellTimeToReady(415073) > 1.5)) and NAG:Cast(10318)
    or ((NAG:SpellTimeToReady(415073) > 1.5) and (NAG:SpellTimeToReady(407676) > 1.5)) and NAG:Cast(20924)
        ]],

    -- Tracked IDs for optimization
    spells = {10318, 20271, 20924, 407676, 407778, 415073, 426157, 1219191},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 5Min Phase8 PreRaid Wrath rotation
local retribution5MinPhase8PreRaidWrath = {
    name = "Paladin Retribution - 5Min_Phase8_PreRaid_Wrath by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or (NAG:CurrentSealRemainingTime() <= 1.0) and NAG:StrictSequence("foo", NAG:Cast(20271), NAG:CastPaladinPrimarySeal())
    or NAG:Cast(407778)
    or NAG:Cast(415073)
    or NAG:Cast(407676)
    or NAG:StrictSequence("foo", NAG:Cast(20271), NAG:CastPaladinPrimarySeal())
    or NAG:AuraIsKnown(1219191) and NAG:Cast(10318)
    or NAG:Cast(20924)
        ]],

    -- Tracked IDs for optimization
    spells = {10318, 20271, 20924, 407676, 407778, 415073, 1219191},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 1Target 1Min BiS Phase8 ST rotation
local retribution1Target1MinBiSPhase8ST = {
    name = "Paladin Retribution - 1Target_1Min_BiS_Phase8_ST by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions
    },
    rotationString = [[
NAG:Cast(241037)
    or NAG:Cast(16322)
    or (NAG:CurrentTime() >= 5.0) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentSealRemainingTime() <= 1.5) and NAG:GCDIsReady()) and NAG:Cast(20271)
    or (NAG:CurrentSealRemainingTime() <= 1.5) and NAG:CastPaladinPrimarySeal()
    or (NAG:AuraIsKnown(1214298) and NAG:SpellCanCast(20930) and ((NAG:AuraRemainingTime(1239543) <= 1.5) or ((NAG:AuraNumStacks(1226461) == 3) and (NAG:AuraRemainingTime(1240574) <= 1.5)))) and NAG:Cast(407624)
    or ((NAG:AuraRemainingTime(1239543) <= 1.5) or ((NAG:AuraNumStacks(1226461) == 3) and (NAG:AuraRemainingTime(1240574) <= 1.5))) and NAG:Cast(20930)
    or NAG:Cast(415073)
    or (NAG:AuraIsKnown(1214298) and NAG:SpellCanCast(20930) and (NAG:AuraNumStacks(1226461) == 3)) and NAG:Cast(407624)
    or (NAG:AuraNumStacks(1226461) == 3) and NAG:Cast(20930)
    or NAG:Cast(407676)
        ]],

    -- Tracked IDs for optimization
    spells = {16322, 20271, 20930, 407624, 407676, 415073, 1214298, 1226461, 1239543, 1240574},
    items = {241037, 241241},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 1Target 1Min 2H BiS Phase8 ST rotation
local retribution1Target1Min2HBiSPhase8ST = {
    name = "Paladin Retribution - 1Target_1Min_2H_BiS_Phase8_ST by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions
    },
    rotationString = [[
NAG:Cast(241037)
    or NAG:Cast(16322)
    or (NAG:CurrentTime() >= 5.0) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentSealRemainingTime() <= 1.5) and NAG:GCDIsReady()) and NAG:Cast(20271)
    or (NAG:CurrentSealRemainingTime() <= 1.5) and NAG:CastPaladinPrimarySeal()
    or (NAG:AuraIsKnown(1214298) and NAG:SpellCanCast(20930) and ((NAG:AuraRemainingTime(1239543) <= 1.5) or ((NAG:AuraNumStacks(1226461) == 3) and (NAG:AuraRemainingTime(1240574) <= 1.5)))) and NAG:Cast(407624)
    or ((NAG:AuraRemainingTime(1239543) <= 1.5) or ((NAG:AuraNumStacks(1226461) == 3) and (NAG:AuraRemainingTime(1240574) <= 1.5))) and NAG:Cast(20930)
    or NAG:Cast(415073)
    or (NAG:AuraIsKnown(1214298) and NAG:SpellCanCast(20930) and (NAG:AuraNumStacks(1226461) == 3)) and NAG:Cast(407624)
    or (NAG:AuraNumStacks(1226461) == 3) and NAG:Cast(20930)
    or NAG:Cast(407676)
        ]],

    -- Tracked IDs for optimization
    spells = {16322, 20271, 20930, 407624, 407676, 415073, 1214298, 1226461, 1239543, 1240574},
    items = {241037, 241241},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 1Target 1Min BiS Phase8 ST Twisting rotation
local retribution1Target1MinBiSPhase8STTwisting = {
    name = "Paladin Retribution - 1Target_1Min_BiS_Phase8_ST_Twisting by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions
    },
    rotationString = [[
((NAG:AutoTimeToNext() == NAG:AutoSwingTime()) and (NAG:AutoSwingTime() >= 1.99)) and NAG:Wait(0.2)
    or NAG:AuraIsActive(1231886) and NAG:CancelAura(1231886)
    or (((not NAG:AuraIsKnown(1226460)) and (NAG:CurrentTime() >= 2.4)) or (NAG:AuraNumStacks(1226461) == 3)) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() >= (NAG:AutoSwingTime() - 0.2)) and (NAG:AuraIsActive(20920) and NAG:AuraIsActive(407798))) and NAG:Cast(20271)
    or (NAG:AuraIsActive(407798) and (NAG:AutoSwingTime() < 1.99)) and NAG:PaladinCastWithMacro(20271, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (not NAG:AuraIsActive(407798)) and (NAG:RemainingTimePercent() < 0.1)) and NAG:PaladinCastWithMacro(407798, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (NAG:RemainingTimePercent() < 0.1)) and NAG:Cast(24239)
    or (((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(20920)) or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraRemainingTime(407798) < 2.0))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407798, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(407798) and ((not NAG:RuneIsEquipped(429152)) or (NAG:RemainingTimePercent() >= 0.1))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(20920, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or ((not NAG:SpellCanCast(407676)) or (NAG:AuraNumStacks(1226461) == 3))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:StrictSequence("foo", NAG:Cast(407778), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:Cast(415073), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(407676), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or ((not NAG:SpellCanCast(407676)) or (NAG:AuraNumStacks(1226461) == 3))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407778, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(415073, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49)) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407676, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or ((not NAG:SpellCanCast(407676)) or (NAG:AuraNumStacks(1226461) == 3))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:PaladinCastWithMacro(407778, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:PaladinCastWithMacro(415073, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(407676, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead))) and NAG:PaladinCastWithMacro(10318, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(20924, "target", 1)
        ]],

    -- Tracked IDs for optimization
    spells = {10318, 20271, 20920, 20924, 24239, 407676, 407778, 407798, 415073, 1219193, 1226460, 1226461, 1231886},
    items = {241241},
    auras = {},
    runes = {429152},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 1Target 1Min BiS Phase8 ST Wrath rotation
local retribution1Target1MinBiSPhase8STWrath = {
    name = "Paladin Retribution - 1Target_1Min_BiS_Phase8_ST_Wrath by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions
    },
    rotationString = [[
(NAG:AuraNumStacks(1226461) == 3) and NAG:AutocastOtherCooldowns()
    or NAG:Cast(241037)
    or NAG:Cast(16322)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or NAG:AuraIsKnown(467518) and NAG:Cast(20271)
    or (NAG:CurrentSealRemainingTime() <= 0.5) and NAG:CastPaladinPrimarySeal()
    or (NAG:AuraIsActive(1226464) and (NAG:AuraRemainingTime(1226464) <= 1.0) and (NAG:AuraNumStacks(1226461) == 3)) and NAG:Wait(NAG:SpellTimeToReady(407778))
    or (NAG:AuraNumStacks(1226461) == 3) and NAG:Cast(407778)
    or NAG:Cast(407676)
    or NAG:Cast(415073)
    or NAG:Cast(407778)
    or NAG:GCDIsReady() and NAG:Cast(20271)
    or ((NAG:SpellTimeToReady(415073) > 1.5) and (NAG:SpellTimeToReady(407676) > 1.5) and ((NAG:SpellTimeToReady(407778) > 1.5) or (NAG:AuraNumStacks(1226461) < 3))) and NAG:Cast(20924)
        ]],

    -- Tracked IDs for optimization
    spells = {16322, 20271, 20924, 407676, 407778, 415073, 467518, 1226461, 1226464},
    items = {241037, 241241},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 1Target 1Min BiS Exodin Phase8 ST rotation
local retribution1Target1MinBiSExodinPhase8ST = {
    name = "Paladin Retribution - 1Target_1Min_BiS_Exodin_Phase8_ST by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentSealRemainingTime() <= 1.0) and NAG:GCDIsReady()) and NAG:Cast(20271)
    or (NAG:CurrentSealRemainingTime() < 1.0) and NAG:CastPaladinPrimarySeal()
    or ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3)) and NAG:Cast(407778)
    or NAG:AuraIsActive(426157) and NAG:Wait(NAG:AuraRemainingTime(426157))
    or NAG:Cast(415073)
    or NAG:Cast(407676)
        ]],

    -- Tracked IDs for optimization
    spells = {20271, 407676, 407778, 415073, 426157, 1226460, 1226461},
    items = {241241},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 1Target 1Min BiS Phase8 ST SealStacking rotation
local retribution1Target1MinBiSPhase8STSealStacking = {
    name = "Paladin Retribution - 1Target_1Min_BiS_Phase8_ST_SealStacking by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -3.0, action = "NAG:Cast(20920)" },
        { time = -1.5, action = "NAG:Cast(407798)" }
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or (NAG:AuraRemainingTime(20920) <= 1.0) and NAG:Cast(20920)
    or (NAG:AuraRemainingTime(407798) <= 1.0) and NAG:Cast(407798)
    or ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3)) and NAG:Cast(407778)
    or NAG:Cast(407676)
    or NAG:Cast(415073)
    or (NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) and NAG:Cast(10318)
    or NAG:Cast(20924)
    or (NAG:AuraIsActive(407798) and NAG:AuraIsActive(20920)) and NAG:Cast(20271)
        ]],

    -- Tracked IDs for optimization
    spells = {10318, 20271, 20920, 20924, 407676, 407778, 407798, 415073, 1219193, 1226460, 1226461},
    items = {241241},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 1Target 2Min BiS Phase8 ST rotation
local retribution1Target2MinBiSPhase8ST = {
    name = "Paladin Retribution - 1Target_2Min_BiS_Phase8_ST by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions
    },
    rotationString = [[
NAG:Cast(241037)
    or NAG:Cast(16322)
    or (NAG:CurrentTime() >= 5.0) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentSealRemainingTime() <= 1.5) and NAG:GCDIsReady()) and NAG:Cast(20271)
    or (NAG:CurrentSealRemainingTime() <= 1.5) and NAG:CastPaladinPrimarySeal()
    or (NAG:AuraIsKnown(1214298) and NAG:SpellCanCast(20930) and ((NAG:AuraRemainingTime(1239543) <= 1.5) or ((NAG:AuraNumStacks(1226461) == 3) and (NAG:AuraRemainingTime(1240574) <= 1.5)))) and NAG:Cast(407624)
    or ((NAG:AuraRemainingTime(1239543) <= 1.5) or ((NAG:AuraNumStacks(1226461) == 3) and (NAG:AuraRemainingTime(1240574) <= 1.5))) and NAG:Cast(20930)
    or NAG:Cast(415073)
    or (NAG:AuraIsKnown(1214298) and NAG:SpellCanCast(20930) and (NAG:AuraNumStacks(1226461) == 3)) and NAG:Cast(407624)
    or (NAG:AuraNumStacks(1226461) == 3) and NAG:Cast(20930)
    or NAG:Cast(407676)
        ]],

    -- Tracked IDs for optimization
    spells = {16322, 20271, 20930, 407624, 407676, 415073, 1214298, 1226461, 1239543, 1240574},
    items = {241037, 241241},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 1Target 2Min 2H BiS Phase8 ST rotation
local retribution1Target2Min2HBiSPhase8ST = {
    name = "Paladin Retribution - 1Target_2Min_2H_BiS_Phase8_ST by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions
    },
    rotationString = [[
NAG:Cast(241037)
    or NAG:Cast(16322)
    or (NAG:CurrentTime() >= 5.0) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentSealRemainingTime() <= 1.5) and NAG:GCDIsReady()) and NAG:Cast(20271)
    or (NAG:CurrentSealRemainingTime() <= 1.5) and NAG:CastPaladinPrimarySeal()
    or (NAG:AuraIsKnown(1214298) and NAG:SpellCanCast(20930) and ((NAG:AuraRemainingTime(1239543) <= 1.5) or ((NAG:AuraNumStacks(1226461) == 3) and (NAG:AuraRemainingTime(1240574) <= 1.5)))) and NAG:Cast(407624)
    or ((NAG:AuraRemainingTime(1239543) <= 1.5) or ((NAG:AuraNumStacks(1226461) == 3) and (NAG:AuraRemainingTime(1240574) <= 1.5))) and NAG:Cast(20930)
    or NAG:Cast(415073)
    or (NAG:AuraIsKnown(1214298) and NAG:SpellCanCast(20930) and (NAG:AuraNumStacks(1226461) == 3)) and NAG:Cast(407624)
    or (NAG:AuraNumStacks(1226461) == 3) and NAG:Cast(20930)
    or NAG:Cast(407676)
        ]],

    -- Tracked IDs for optimization
    spells = {16322, 20271, 20930, 407624, 407676, 415073, 1214298, 1226461, 1239543, 1240574},
    items = {241037, 241241},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 1Target 2Min BiS Phase8 ST Twisting rotation
local retribution1Target2MinBiSPhase8STTwisting = {
    name = "Paladin Retribution - 1Target_2Min_BiS_Phase8_ST_Twisting by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions
    },
    rotationString = [[
((NAG:AutoTimeToNext() == NAG:AutoSwingTime()) and (NAG:AutoSwingTime() >= 1.99)) and NAG:Wait(0.2)
    or NAG:AuraIsActive(1231886) and NAG:CancelAura(1231886)
    or (((not NAG:AuraIsKnown(1226460)) and (NAG:CurrentTime() >= 2.4)) or (NAG:AuraNumStacks(1226461) == 3)) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() >= (NAG:AutoSwingTime() - 0.2)) and (NAG:AuraIsActive(20920) and NAG:AuraIsActive(407798))) and NAG:Cast(20271)
    or (NAG:AuraIsActive(407798) and (NAG:AutoSwingTime() < 1.99)) and NAG:PaladinCastWithMacro(20271, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (not NAG:AuraIsActive(407798)) and (NAG:RemainingTimePercent() < 0.1)) and NAG:PaladinCastWithMacro(407798, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (NAG:RemainingTimePercent() < 0.1)) and NAG:Cast(24239)
    or (((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(20920)) or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraRemainingTime(407798) < 2.0))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407798, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(407798) and ((not NAG:RuneIsEquipped(429152)) or (NAG:RemainingTimePercent() >= 0.1))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(20920, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or ((not NAG:SpellCanCast(407676)) or (NAG:AuraNumStacks(1226461) == 3))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:StrictSequence("foo", NAG:Cast(407778), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:Cast(415073), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(407676), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or ((not NAG:SpellCanCast(407676)) or (NAG:AuraNumStacks(1226461) == 3))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407778, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(415073, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49)) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407676, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or ((not NAG:SpellCanCast(407676)) or (NAG:AuraNumStacks(1226461) == 3))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:PaladinCastWithMacro(407778, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:PaladinCastWithMacro(415073, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(407676, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead))) and NAG:PaladinCastWithMacro(10318, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(20924, "target", 1)
        ]],

    -- Tracked IDs for optimization
    spells = {10318, 20271, 20920, 20924, 24239, 407676, 407778, 407798, 415073, 1219193, 1226460, 1226461, 1231886},
    items = {241241},
    auras = {},
    runes = {429152},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 1Target 2Min BiS Phase8 ST Wrath rotation
local retribution1Target2MinBiSPhase8STWrath = {
    name = "Paladin Retribution - 1Target_2Min_BiS_Phase8_ST_Wrath by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions
    },
    rotationString = [[
(NAG:AuraNumStacks(1226461) == 3) and NAG:AutocastOtherCooldowns()
    or NAG:Cast(241037)
    or NAG:Cast(16322)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or NAG:AuraIsKnown(467518) and NAG:Cast(20271)
    or (NAG:CurrentSealRemainingTime() <= 0.5) and NAG:CastPaladinPrimarySeal()
    or (NAG:AuraIsActive(1226464) and (NAG:AuraRemainingTime(1226464) <= 1.0) and (NAG:AuraNumStacks(1226461) == 3)) and NAG:Wait(NAG:SpellTimeToReady(407778))
    or (NAG:AuraNumStacks(1226461) == 3) and NAG:Cast(407778)
    or NAG:Cast(407676)
    or NAG:Cast(415073)
    or NAG:Cast(407778)
    or NAG:GCDIsReady() and NAG:Cast(20271)
    or ((NAG:SpellTimeToReady(415073) > 1.5) and (NAG:SpellTimeToReady(407676) > 1.5) and ((NAG:SpellTimeToReady(407778) > 1.5) or (NAG:AuraNumStacks(1226461) < 3))) and NAG:Cast(20924)
        ]],

    -- Tracked IDs for optimization
    spells = {16322, 20271, 20924, 407676, 407778, 415073, 467518, 1226461, 1226464},
    items = {241037, 241241},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 1Target 2Min BiS Phase8 ST SealStacking rotation
local retribution1Target2MinBiSPhase8STSealStacking = {
    name = "Paladin Retribution - 1Target_2Min_BiS_Phase8_ST_SealStacking by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -3.0, action = "NAG:Cast(20920)" },
        { time = -1.5, action = "NAG:Cast(407798)" }
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or (NAG:AuraRemainingTime(20920) <= 1.0) and NAG:Cast(20920)
    or (NAG:AuraRemainingTime(407798) <= 1.0) and NAG:Cast(407798)
    or ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3)) and NAG:Cast(407778)
    or NAG:Cast(407676)
    or NAG:Cast(415073)
    or (NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) and NAG:Cast(10318)
    or NAG:Cast(20924)
    or (NAG:AuraIsActive(407798) and NAG:AuraIsActive(20920)) and NAG:Cast(20271)
        ]],

    -- Tracked IDs for optimization
    spells = {10318, 20271, 20920, 20924, 407676, 407778, 407798, 415073, 1219193, 1226460, 1226461},
    items = {241241},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 1Target 2Min BiS Exodin Phase8 ST rotation
local retribution1Target2MinBiSExodinPhase8ST = {
    name = "Paladin Retribution - 1Target_2Min_BiS_Exodin_Phase8_ST by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentSealRemainingTime() <= 1.0) and NAG:GCDIsReady()) and NAG:Cast(20271)
    or (NAG:CurrentSealRemainingTime() < 1.0) and NAG:CastPaladinPrimarySeal()
    or ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3)) and NAG:Cast(407778)
    or NAG:AuraIsActive(426157) and NAG:Wait(NAG:AuraRemainingTime(426157))
    or NAG:Cast(415073)
    or NAG:Cast(407676)
        ]],

    -- Tracked IDs for optimization
    spells = {20271, 407676, 407778, 415073, 426157, 1226460, 1226461},
    items = {241241},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 1Target 3Min BiS Phase8 ST rotation
local retribution1Target3MinBiSPhase8ST = {
    name = "Paladin Retribution - 1Target_3Min_BiS_Phase8_ST by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions
    },
    rotationString = [[
NAG:Cast(241037)
    or NAG:Cast(16322)
    or (NAG:CurrentTime() >= 5.0) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentSealRemainingTime() <= 1.5) and NAG:GCDIsReady()) and NAG:Cast(20271)
    or (NAG:CurrentSealRemainingTime() <= 1.5) and NAG:CastPaladinPrimarySeal()
    or (NAG:AuraIsKnown(1214298) and NAG:SpellCanCast(20930) and ((NAG:AuraRemainingTime(1239543) <= 1.5) or ((NAG:AuraNumStacks(1226461) == 3) and (NAG:AuraRemainingTime(1240574) <= 1.5)))) and NAG:Cast(407624)
    or ((NAG:AuraRemainingTime(1239543) <= 1.5) or ((NAG:AuraNumStacks(1226461) == 3) and (NAG:AuraRemainingTime(1240574) <= 1.5))) and NAG:Cast(20930)
    or NAG:Cast(415073)
    or (NAG:AuraIsKnown(1214298) and NAG:SpellCanCast(20930) and (NAG:AuraNumStacks(1226461) == 3)) and NAG:Cast(407624)
    or (NAG:AuraNumStacks(1226461) == 3) and NAG:Cast(20930)
    or NAG:Cast(407676)
        ]],

    -- Tracked IDs for optimization
    spells = {16322, 20271, 20930, 407624, 407676, 415073, 1214298, 1226461, 1239543, 1240574},
    items = {241037, 241241},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 1Target 3Min 2H BiS Phase8 ST rotation
local retribution1Target3Min2HBiSPhase8ST = {
    name = "Paladin Retribution - 1Target_3Min_2H_BiS_Phase8_ST by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions
    },
    rotationString = [[
NAG:Cast(241037)
    or NAG:Cast(16322)
    or (NAG:CurrentTime() >= 5.0) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentSealRemainingTime() <= 1.5) and NAG:GCDIsReady()) and NAG:Cast(20271)
    or (NAG:CurrentSealRemainingTime() <= 1.5) and NAG:CastPaladinPrimarySeal()
    or (NAG:AuraIsKnown(1214298) and NAG:SpellCanCast(20930) and ((NAG:AuraRemainingTime(1239543) <= 1.5) or ((NAG:AuraNumStacks(1226461) == 3) and (NAG:AuraRemainingTime(1240574) <= 1.5)))) and NAG:Cast(407624)
    or ((NAG:AuraRemainingTime(1239543) <= 1.5) or ((NAG:AuraNumStacks(1226461) == 3) and (NAG:AuraRemainingTime(1240574) <= 1.5))) and NAG:Cast(20930)
    or NAG:Cast(415073)
    or (NAG:AuraIsKnown(1214298) and NAG:SpellCanCast(20930) and (NAG:AuraNumStacks(1226461) == 3)) and NAG:Cast(407624)
    or (NAG:AuraNumStacks(1226461) == 3) and NAG:Cast(20930)
    or NAG:Cast(407676)
        ]],

    -- Tracked IDs for optimization
    spells = {16322, 20271, 20930, 407624, 407676, 415073, 1214298, 1226461, 1239543, 1240574},
    items = {241037, 241241},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 1Target 3Min BiS Phase8 ST Twisting rotation
local retribution1Target3MinBiSPhase8STTwisting = {
    name = "Paladin Retribution - 1Target_3Min_BiS_Phase8_ST_Twisting by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions
    },
    rotationString = [[
((NAG:AutoTimeToNext() == NAG:AutoSwingTime()) and (NAG:AutoSwingTime() >= 1.99)) and NAG:Wait(0.2)
    or NAG:AuraIsActive(1231886) and NAG:CancelAura(1231886)
    or (((not NAG:AuraIsKnown(1226460)) and (NAG:CurrentTime() >= 2.4)) or (NAG:AuraNumStacks(1226461) == 3)) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() >= (NAG:AutoSwingTime() - 0.2)) and (NAG:AuraIsActive(20920) and NAG:AuraIsActive(407798))) and NAG:Cast(20271)
    or (NAG:AuraIsActive(407798) and (NAG:AutoSwingTime() < 1.99)) and NAG:PaladinCastWithMacro(20271, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (not NAG:AuraIsActive(407798)) and (NAG:RemainingTimePercent() < 0.1)) and NAG:PaladinCastWithMacro(407798, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (NAG:RemainingTimePercent() < 0.1)) and NAG:Cast(24239)
    or (((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(20920)) or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraRemainingTime(407798) < 2.0))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407798, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(407798) and ((not NAG:RuneIsEquipped(429152)) or (NAG:RemainingTimePercent() >= 0.1))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(20920, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or ((not NAG:SpellCanCast(407676)) or (NAG:AuraNumStacks(1226461) == 3))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:StrictSequence("foo", NAG:Cast(407778), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:Cast(415073), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(407676), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or ((not NAG:SpellCanCast(407676)) or (NAG:AuraNumStacks(1226461) == 3))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407778, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(415073, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49)) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407676, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or ((not NAG:SpellCanCast(407676)) or (NAG:AuraNumStacks(1226461) == 3))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:PaladinCastWithMacro(407778, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:PaladinCastWithMacro(415073, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(407676, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead))) and NAG:PaladinCastWithMacro(10318, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(20924, "target", 1)
        ]],

    -- Tracked IDs for optimization
    spells = {10318, 20271, 20920, 20924, 24239, 407676, 407778, 407798, 415073, 1219193, 1226460, 1226461, 1231886},
    items = {241241},
    auras = {},
    runes = {429152},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 1Target 3Min BiS Phase8 ST Wrath rotation
local retribution1Target3MinBiSPhase8STWrath = {
    name = "Paladin Retribution - 1Target_3Min_BiS_Phase8_ST_Wrath by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions
    },
    rotationString = [[
(NAG:AuraNumStacks(1226461) == 3) and NAG:AutocastOtherCooldowns()
    or NAG:Cast(241037)
    or NAG:Cast(16322)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or NAG:AuraIsKnown(467518) and NAG:Cast(20271)
    or (NAG:CurrentSealRemainingTime() <= 0.5) and NAG:CastPaladinPrimarySeal()
    or (NAG:AuraIsActive(1226464) and (NAG:AuraRemainingTime(1226464) <= 1.0) and (NAG:AuraNumStacks(1226461) == 3)) and NAG:Wait(NAG:SpellTimeToReady(407778))
    or (NAG:AuraNumStacks(1226461) == 3) and NAG:Cast(407778)
    or NAG:Cast(407676)
    or NAG:Cast(415073)
    or NAG:Cast(407778)
    or NAG:GCDIsReady() and NAG:Cast(20271)
    or ((NAG:SpellTimeToReady(415073) > 1.5) and (NAG:SpellTimeToReady(407676) > 1.5) and ((NAG:SpellTimeToReady(407778) > 1.5) or (NAG:AuraNumStacks(1226461) < 3))) and NAG:Cast(20924)
        ]],

    -- Tracked IDs for optimization
    spells = {16322, 20271, 20924, 407676, 407778, 415073, 467518, 1226461, 1226464},
    items = {241037, 241241},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 1Target 3Min BiS Phase8 ST SealStacking rotation
local retribution1Target3MinBiSPhase8STSealStacking = {
    name = "Paladin Retribution - 1Target_3Min_BiS_Phase8_ST_SealStacking by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -3.0, action = "NAG:Cast(20920)" },
        { time = -1.5, action = "NAG:Cast(407798)" }
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or (NAG:AuraRemainingTime(20920) <= 1.0) and NAG:Cast(20920)
    or (NAG:AuraRemainingTime(407798) <= 1.0) and NAG:Cast(407798)
    or ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3)) and NAG:Cast(407778)
    or NAG:Cast(407676)
    or NAG:Cast(415073)
    or (NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) and NAG:Cast(10318)
    or NAG:Cast(20924)
    or (NAG:AuraIsActive(407798) and NAG:AuraIsActive(20920)) and NAG:Cast(20271)
        ]],

    -- Tracked IDs for optimization
    spells = {10318, 20271, 20920, 20924, 407676, 407778, 407798, 415073, 1219193, 1226460, 1226461},
    items = {241241},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 1Target 3Min BiS Exodin Phase8 ST rotation
local retribution1Target3MinBiSExodinPhase8ST = {
    name = "Paladin Retribution - 1Target_3Min_BiS_Exodin_Phase8_ST by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentSealRemainingTime() <= 1.0) and NAG:GCDIsReady()) and NAG:Cast(20271)
    or (NAG:CurrentSealRemainingTime() < 1.0) and NAG:CastPaladinPrimarySeal()
    or ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3)) and NAG:Cast(407778)
    or NAG:AuraIsActive(426157) and NAG:Wait(NAG:AuraRemainingTime(426157))
    or NAG:Cast(415073)
    or NAG:Cast(407676)
        ]],

    -- Tracked IDs for optimization
    spells = {20271, 407676, 407778, 415073, 426157, 1226460, 1226461},
    items = {241241},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 2Target 1Min BiS Cleave Phase8 Twisting rotation
local retribution2Target1MinBiSCleavePhase8Twisting = {
    name = "Paladin Retribution - 2Target_1Min_BiS_Cleave_Phase8_Twisting by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions
    },
    rotationString = [[
((NAG:AutoTimeToNext() == NAG:AutoSwingTime()) and (NAG:AutoSwingTime() >= 1.99)) and NAG:Wait(0.2)
    or NAG:AuraIsActive(1231886) and NAG:CancelAura(1231886)
    or (NAG:CurrentTime() >= 2.4) and NAG:AutocastOtherCooldowns()
    or ((NAG:AuraNumStacks(241241) < 5) and (NAG:AuraRemainingTime(241241) <= 3.0)) and NAG:Cast(241241)
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() >= (NAG:AutoSwingTime() - 0.2)) and (NAG:AuraIsActive(20920) and NAG:AuraIsActive(407798))) and NAG:Cast(20271)
    or (NAG:AuraIsActive(407798) and (NAG:AutoSwingTime() < 1.99)) and NAG:PaladinCastWithMacro(20271, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (not NAG:AuraIsActive(407798)) and (NAG:RemainingTimePercent() < 0.1)) and NAG:PaladinCastWithMacro(407798, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (NAG:RemainingTimePercent() < 0.1)) and NAG:Cast(24239)
    or (((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(20920)) or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraRemainingTime(407798) < 2.0))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407798, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(407798) and ((not NAG:RuneIsEquipped(429152)) or (NAG:RemainingTimePercent() >= 0.1))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(20920, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:StrictSequence("foo", NAG:Cast(407778), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:Cast(415073), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(407676), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407778, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(415073, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49)) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407676, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:PaladinCastWithMacro(407778, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:PaladinCastWithMacro(415073, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(407676, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead))) and NAG:PaladinCastWithMacro(10318, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(20924, "target", 1)
        ]],

    -- Tracked IDs for optimization
    spells = {10318, 20271, 20920, 20924, 24239, 407676, 407778, 407798, 415073, 1219193, 1226460, 1226461, 1231886},
    items = {241241},
    auras = {},
    runes = {429152},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 2H 2Target 1Min BiS Cleave Phase8 rotation
local retribution2H2Target1MinBiSCleavePhase8 = {
    name = "Paladin Retribution - 2H_2Target_1Min_BiS_Cleave_Phase8 by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -4.0, action = "NAG:Cast(20930)" }
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or NAG:Cast(20271)
    or (NAG:CurrentSealRemainingTime() <= 1.0) and NAG:CastPaladinPrimarySeal()
    or NAG:Cast(415073)
    or (NAG:AuraIsKnown(1226461) and (NAG:AuraNumStacks(1226461) == 3) and (NAG:AuraNumStacks(470246) == 5) and (NAG:AuraIsActive(20218) or (not NAG:SpellCanCast(20930)))) and NAG:Cast(10318)
    or ((not NAG:AuraIsKnown(1226461)) or (NAG:AuraNumStacks(1226461) == 3)) and NAG:Cast(20930)
    or NAG:Cast(407676)
        ]],

    -- Tracked IDs for optimization
    spells = {10318, 20218, 20271, 20930, 407676, 415073, 470246, 1226461},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 2Target 1Min BiS Cleave Phase8 SealStacking rotation
local retribution2Target1MinBiSCleavePhase8SealStacking = {
    name = "Paladin Retribution - 2Target_1Min_BiS_Cleave_Phase8_SealStacking by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -3.0, action = "NAG:Cast(20920)" },
        { time = -1.5, action = "NAG:Cast(407798)" }
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:AuraNumStacks(241241) < 5) and (NAG:AuraRemainingTime(241241) <= 3.0)) and NAG:Cast(241241)
    or (NAG:AuraRemainingTime(20920) <= 1.0) and NAG:Cast(20920)
    or (NAG:AuraRemainingTime(407798) <= 1.0) and NAG:Cast(407798)
    or ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3)) and NAG:Cast(407778)
    or NAG:Cast(407676)
    or NAG:Cast(415073)
    or NAG:Cast(407778)
    or (NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) and NAG:Cast(10318)
    or NAG:Cast(20924)
    or (NAG:AuraIsActive(407798) and NAG:AuraIsActive(20920)) and NAG:Cast(20271)
        ]],

    -- Tracked IDs for optimization
    spells = {10318, 20271, 20920, 20924, 407676, 407778, 407798, 415073, 1219193, 1226460, 1226461},
    items = {241241},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 2Target 1Min BiS Cleave Exodin Phase8 rotation
local retribution2Target1MinBiSCleaveExodinPhase8 = {
    name = "Paladin Retribution - 2Target_1Min_BiS_Cleave_Exodin_Phase8 by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or NAG:AuraIsActive(426157) and NAG:Wait(NAG:AuraRemainingTime(426157))
    or ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3)) and NAG:Cast(407778)
    or NAG:Cast(415073)
    or NAG:Cast(407676)
    or (NAG:CurrentSealRemainingTime() < 0.6) and NAG:Cast(20271)
    or (NAG:CurrentSealRemainingTime() < 0.6) and NAG:CastPaladinPrimarySeal()
        ]],

    -- Tracked IDs for optimization
    spells = {20271, 407676, 407778, 415073, 426157, 1226460, 1226461},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 3Target 1Min BiS Cleave Phase8 Twisting rotation
local retribution3Target1MinBiSCleavePhase8Twisting = {
    name = "Paladin Retribution - 3Target_1Min_BiS_Cleave_Phase8_Twisting by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions
    },
    rotationString = [[
((NAG:AutoTimeToNext() == NAG:AutoSwingTime()) and (NAG:AutoSwingTime() >= 1.99)) and NAG:Wait(0.2)
    or NAG:AuraIsActive(1231886) and NAG:CancelAura(1231886)
    or (NAG:CurrentTime() >= 2.4) and NAG:AutocastOtherCooldowns()
    or ((NAG:AuraNumStacks(241241) < 5) and (NAG:AuraRemainingTime(241241) <= 3.0)) and NAG:Cast(241241)
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() >= (NAG:AutoSwingTime() - 0.2)) and (NAG:AuraIsActive(20920) and NAG:AuraIsActive(407798))) and NAG:Cast(20271)
    or (NAG:AuraIsActive(407798) and (NAG:AutoSwingTime() < 1.99)) and NAG:PaladinCastWithMacro(20271, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (not NAG:AuraIsActive(407798)) and (NAG:RemainingTimePercent() < 0.1)) and NAG:PaladinCastWithMacro(407798, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (NAG:RemainingTimePercent() < 0.1)) and NAG:Cast(24239)
    or (((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(20920)) or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraRemainingTime(407798) < 2.0))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407798, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(407798) and ((not NAG:RuneIsEquipped(429152)) or (NAG:RemainingTimePercent() >= 0.1))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(20920, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:StrictSequence("foo", NAG:Cast(407778), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:Cast(415073), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(407676), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407778, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(415073, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49)) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407676, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:PaladinCastWithMacro(407778, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:PaladinCastWithMacro(415073, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(407676, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead))) and NAG:PaladinCastWithMacro(10318, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(20924, "target", 1)
        ]],

    -- Tracked IDs for optimization
    spells = {10318, 20271, 20920, 20924, 24239, 407676, 407778, 407798, 415073, 1219193, 1226460, 1226461, 1231886},
    items = {241241},
    auras = {},
    runes = {429152},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 3Target 1Min BiS Cleave Phase8 rotation
local retribution3Target1MinBiSCleavePhase8 = {
    name = "Paladin Retribution - 3Target_1Min_BiS_Cleave_Phase8 by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -2.5, action = "NAG:Cast(407798)" },
        { time = -4.0, action = "NAG:Cast(20930)" }
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or NAG:Cast(415073)
    or (NAG:AuraRemainingTime(462834) < 5.0) and NAG:Cast(20930)
    or (NAG:CurrentSealRemainingTime() < 0.6) and NAG:Cast(20271)
    or (NAG:CurrentSealRemainingTime() < 0.5) and NAG:CastPaladinPrimarySeal()
    or (NAG:SpellTimeToReady(415073) >= 2) and NAG:Cast(10318)
        ]],

    -- Tracked IDs for optimization
    spells = {10318, 20271, 20930, 415073, 462834},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 3Target 1Min BiS Cleave Exodin Phase8 rotation
local retribution3Target1MinBiSCleaveExodinPhase8 = {
    name = "Paladin Retribution - 3Target_1Min_BiS_Cleave_Exodin_Phase8 by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or (NAG:CurrentSealRemainingTime() < 0.5) and NAG:CastPaladinPrimarySeal()
    or (NAG:CurrentSealRemainingTime() < 0.6) and NAG:Cast(20271)
    or NAG:Cast(415073)
    or NAG:Cast(407676)
    or NAG:Cast(407778)
    or NAG:Cast(10318)
    or NAG:Cast(20924)
        ]],

    -- Tracked IDs for optimization
    spells = {10318, 20271, 20924, 407676, 407778, 415073},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 3Target 1Min BiS Cleave Phase8 SealStacking rotation
local retribution3Target1MinBiSCleavePhase8SealStacking = {
    name = "Paladin Retribution - 3Target_1Min_BiS_Cleave_Phase8_SealStacking by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -3.0, action = "NAG:Cast(20920)" },
        { time = -1.5, action = "NAG:Cast(407798)" }
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or (NAG:AuraRemainingTime(20920) <= 1) and NAG:Cast(20920)
    or (NAG:AuraRemainingTime(407798) <= 1) and NAG:Cast(407798)
    or (NAG:AuraIsActive(407798) and NAG:AuraIsActive(20920)) and NAG:Cast(20271)
    or (NAG:SpellTimeToReady(407676) >= 1) and NAG:Cast(407778)
    or NAG:Cast(407676)
    or (NAG:SpellTimeToReady(407778) >= 1) and NAG:Cast(415073)
    or NAG:Cast(20924)
        ]],

    -- Tracked IDs for optimization
    spells = {20271, 20920, 20924, 407676, 407778, 407798, 415073},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Retribution 4Target 1Min BiS Cleave Phase8 Twisting rotation
local retribution4Target1MinBiSCleavePhase8Twisting = {
    name = "Paladin Retribution - 4Target_1Min_BiS_Cleave_Phase8_Twisting by APLParser",
    specIndex = 3,
    class = "PALADIN",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        -- No pre-pull actions
    },
    rotationString = [[
((NAG:AutoTimeToNext() == NAG:AutoSwingTime()) and (NAG:AutoSwingTime() >= 1.99)) and NAG:Wait(0.2)
    or NAG:AuraIsActive(1231886) and NAG:CancelAura(1231886)
    or (NAG:CurrentTime() >= 2.4) and NAG:AutocastOtherCooldowns()
    or ((NAG:AuraNumStacks(241241) < 5) and (NAG:AuraRemainingTime(241241) <= 3.0)) and NAG:Cast(241241)
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() >= (NAG:AutoSwingTime() - 0.2)) and (NAG:AuraIsActive(20920) and NAG:AuraIsActive(407798))) and NAG:Cast(20271)
    or (NAG:AuraIsActive(407798) and (NAG:AutoSwingTime() < 1.99)) and NAG:PaladinCastWithMacro(20271, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (not NAG:AuraIsActive(407798)) and (NAG:RemainingTimePercent() < 0.1)) and NAG:PaladinCastWithMacro(407798, "target", 1)
    or (NAG:RuneIsEquipped(429152) and (NAG:RemainingTimePercent() < 0.1)) and NAG:Cast(24239)
    or (((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(20920)) or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraRemainingTime(407798) < 2.0))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407798, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoTimeToNext() <= 0.2) and NAG:AuraIsActive(407798) and ((not NAG:RuneIsEquipped(429152)) or (NAG:RemainingTimePercent() >= 0.1))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(20920, "target", 1), NAG:Wait((NAG:AutoTimeToNext() + 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:StrictSequence("foo", NAG:Cast(407778), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:Cast(415073), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 3.0) and (NAG:AutoTimeToNext() >= 1.5)) and NAG:StrictSequence("foo", NAG:Cast(407676), NAG:Wait((NAG:AutoTimeToNext() - 0.2)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407778, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(415073, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() >= 1.99) and (NAG:AutoSwingTime() < 3.0) and (NAG:AutoTimeToNext() >= 0.49)) and NAG:StrictSequence("foo", NAG:PaladinCastWithMacro(407676, "target", 2), NAG:Wait((NAG:GCDTimeToReady() + 0.1)))
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676))) and ((not NAG:AuraIsKnown(1226460)) or (NAG:AuraNumStacks(1226461) == 3))) and NAG:PaladinCastWithMacro(407778, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and ((NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead)) or (not NAG:SpellCanCast(407676)))) and NAG:PaladinCastWithMacro(415073, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(407676, "target", 1)
    or ((NAG:AutoSwingTime() < 1.99) and (NAG:AuraIsKnown(1219193) and NAG:TargetMobType(NAG.Types.MobType.Undead))) and NAG:PaladinCastWithMacro(10318, "target", 1)
    or (NAG:AutoSwingTime() < 1.99) and NAG:PaladinCastWithMacro(20924, "target", 1)
        ]],

    -- Tracked IDs for optimization
    spells = {10318, 20271, 20920, 20924, 24239, 407676, 407778, 407798, 415073, 1219193, 1226460, 1226461, 1231886},
    items = {241241},
    auras = {},
    runes = {429152},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

--- @class PALADIN : ClassBase
local PALADIN = NAG:CreateClassModule("PALADIN", defaults)

--- Setup class defaults with all rotations
function PALADIN:SetupClassDefaults()
    -- Add all rotation definitions to defaults
    ns.AddRotationToDefaults(self.defaults, 3, retribution3MinPhase8PreRaidTwisting)  -- Retribution
    ns.AddRotationToDefaults(self.defaults, 3, retribution3MinPhase8PreRaidSealStacking)  -- Retribution retribution3MinPhase8PreRaidSealStacking)
    ns.AddRotationToDefaults(self.defaults, 3, retribution3MinExodinPhase8PreRaid)  -- Retribution retribution3MinExodinPhase8PreRaid)
    ns.AddRotationToDefaults(self.defaults, 3, retribution3MinPhase8PreRaidWrath)  -- Retribution retribution3MinPhase8PreRaidWrath)
    ns.AddRotationToDefaults(self.defaults, 3, retribution5MinPhase8PreRaidTwisting)  -- Retribution retribution5MinPhase8PreRaidTwisting)
    ns.AddRotationToDefaults(self.defaults, 3, retribution5MinPhase8PreRaidSealStacking)  -- Retribution retribution5MinPhase8PreRaidSealStacking)
    ns.AddRotationToDefaults(self.defaults, 3, retribution5MinExodinPhase8PreRaid)  -- Retribution retribution5MinExodinPhase8PreRaid)
    ns.AddRotationToDefaults(self.defaults, 3, retribution5MinPhase8PreRaidWrath)  -- Retribution retribution5MinPhase8PreRaidWrath)
    ns.AddRotationToDefaults(self.defaults, 3, retribution1Target1MinBiSPhase8ST)  -- Retribution retribution1Target1MinBiSPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 3, retribution1Target1Min2HBiSPhase8ST)  -- Retribution retribution1Target1Min2HBiSPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 3, retribution1Target1MinBiSPhase8STTwisting)  -- Retribution retribution1Target1MinBiSPhase8STTwisting)
    ns.AddRotationToDefaults(self.defaults, 3, retribution1Target1MinBiSPhase8STWrath)  -- Retribution retribution1Target1MinBiSPhase8STWrath)
    ns.AddRotationToDefaults(self.defaults, 3, retribution1Target1MinBiSExodinPhase8ST)  -- Retribution retribution1Target1MinBiSExodinPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 3, retribution1Target1MinBiSPhase8STSealStacking)  -- Retribution retribution1Target1MinBiSPhase8STSealStacking)
    ns.AddRotationToDefaults(self.defaults, 3, retribution1Target2MinBiSPhase8ST)  -- Retribution retribution1Target2MinBiSPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 3, retribution1Target2Min2HBiSPhase8ST)  -- Retribution retribution1Target2Min2HBiSPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 3, retribution1Target2MinBiSPhase8STTwisting)  -- Retribution retribution1Target2MinBiSPhase8STTwisting)
    ns.AddRotationToDefaults(self.defaults, 3, retribution1Target2MinBiSPhase8STWrath)  -- Retribution retribution1Target2MinBiSPhase8STWrath)
    ns.AddRotationToDefaults(self.defaults, 3, retribution1Target2MinBiSPhase8STSealStacking)  -- Retribution retribution1Target2MinBiSPhase8STSealStacking)
    ns.AddRotationToDefaults(self.defaults, 3, retribution1Target2MinBiSExodinPhase8ST)  -- Retribution retribution1Target2MinBiSExodinPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 3, retribution1Target3MinBiSPhase8ST)  -- Retribution retribution1Target3MinBiSPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 3, retribution1Target3Min2HBiSPhase8ST)  -- Retribution retribution1Target3Min2HBiSPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 3, retribution1Target3MinBiSPhase8STTwisting)  -- Retribution retribution1Target3MinBiSPhase8STTwisting)
    ns.AddRotationToDefaults(self.defaults, 3, retribution1Target3MinBiSPhase8STWrath)  -- Retribution retribution1Target3MinBiSPhase8STWrath)
    ns.AddRotationToDefaults(self.defaults, 3, retribution1Target3MinBiSPhase8STSealStacking)  -- Retribution retribution1Target3MinBiSPhase8STSealStacking)
    ns.AddRotationToDefaults(self.defaults, 3, retribution1Target3MinBiSExodinPhase8ST)  -- Retribution retribution1Target3MinBiSExodinPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 3, retribution2Target1MinBiSCleavePhase8Twisting)  -- Retribution retribution2Target1MinBiSCleavePhase8Twisting)
    ns.AddRotationToDefaults(self.defaults, 3, retribution2H2Target1MinBiSCleavePhase8)  -- Retribution retribution2H2Target1MinBiSCleavePhase8)
    ns.AddRotationToDefaults(self.defaults, 3, retribution2Target1MinBiSCleavePhase8SealStacking)  -- Retribution retribution2Target1MinBiSCleavePhase8SealStacking)
    ns.AddRotationToDefaults(self.defaults, 3, retribution2Target1MinBiSCleaveExodinPhase8)  -- Retribution retribution2Target1MinBiSCleaveExodinPhase8)
    ns.AddRotationToDefaults(self.defaults, 3, retribution3Target1MinBiSCleavePhase8Twisting)  -- Retribution retribution3Target1MinBiSCleavePhase8Twisting)
    ns.AddRotationToDefaults(self.defaults, 3, retribution3Target1MinBiSCleavePhase8)  -- Retribution retribution3Target1MinBiSCleavePhase8)
    ns.AddRotationToDefaults(self.defaults, 3, retribution3Target1MinBiSCleaveExodinPhase8)  -- Retribution retribution3Target1MinBiSCleaveExodinPhase8)
    ns.AddRotationToDefaults(self.defaults, 3, retribution3Target1MinBiSCleavePhase8SealStacking)  -- Retribution retribution3Target1MinBiSCleavePhase8SealStacking)
    ns.AddRotationToDefaults(self.defaults, 3, retribution4Target1MinBiSCleavePhase8Twisting)  -- Retribution retribution4Target1MinBiSCleavePhase8Twisting)
end

if not PALADIN then return end
NAG.Class = PALADIN
