local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
if not Version:IsSoD() then return end

if UnitClassBase('player') ~= "HUNTER" then return end

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

-- Survival 2H 3Min Melee Melee2H Pet Phase8 PreRaid rotation
local survival2H3MinMeleeMelee2HPetPhase8PreRaid = {
    name = "Hunter Survival - 2H_3Min_Melee_Melee2H_Pet_Phase8_PreRaid by APLParser",
    specIndex = 3,
    class = "HUNTER",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(469145)" },
        { time = -1.5, action = "NAG:Cast(20572)" },
        { time = -0.1, action = "NAG:Cast(1213366)" }
    },
    rotationString = [[
((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() >= 10)) and NAG:AutocastOtherCooldowns()
    or ((not NAG:AuraIsActive(415358)) and (NAG:AuraNumStacks(415320) < 3)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) < 2.0) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or ((NAG:AuraNumStacks(415358) >= 4) and NAG:AuraIsActive(467331)) and NAG:Cast(14271)
    or NAG:AuraIsActive(467331) and NAG:Cast(458482)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(458482)
    or NAG:Cast(415320)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(1219176)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409530)
        ]],

    -- Tracked IDs for optimization
    spells = {14271, 409530, 415320, 415343, 415358, 415423, 458482, 467331, 469145, 1219176},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Survival 3Min DW Melee MeleeDW Pet Phase8 PreRaid rotation
local survival3MinDWMeleeMeleeDWPetPhase8PreRaid = {
    name = "Hunter Survival - 3Min_DW_Melee_MeleeDW_Pet_Phase8_PreRaid by APLParser",
    specIndex = 3,
    class = "HUNTER",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(469145)" },
        { time = -1.5, action = "NAG:Cast(20572)" },
        { time = -0.1, action = "NAG:Cast(1213366)" }
    },
    rotationString = [[
((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() >= 10)) and NAG:AutocastOtherCooldowns()
    or ((not NAG:AuraIsActive(415358)) and (NAG:AuraNumStacks(415320) < 3)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) < 2.0) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or ((NAG:AuraNumStacks(415358) >= 5) and NAG:AuraIsActive(467331)) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(1219176)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409530)
        ]],

    -- Tracked IDs for optimization
    spells = {14271, 409530, 415320, 415343, 415358, 415423, 467331, 469145, 1219176},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Marksmanship 3Min Phase8 PreRaid Ranged rotation
local marksmanship3MinPhase8PreRaidRanged = {
    name = "Hunter Marksmanship - 3Min_Phase8_PreRaid_Ranged by APLParser",
    specIndex = 2,
    class = "HUNTER",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(25296)" },
        { time = -2.0, action = "NAG:Cast(20572)" },
        { time = -0.45, action = "NAG:Cast(26297)" },
        { time = -0.45, action = "NAG:Cast(25295)" }
    },
    rotationString = [[
((NAG:CurrentManaPercent() < 0.8) and NAG:AuraIsKnown(1233451) and NAG:RuneIsEquipped(428717)) and NAG:Cast(13444)
    or ((NAG:CurrentManaPercent() < 0.45) and ((not NAG:AuraIsKnown(1233451)) or NAG:RuneIsEquipped(428726))) and NAG:Cast(13444)
    or ((NAG:CurrentManaPercent() < 0.8) and NAG:AuraIsKnown(1233451) and NAG:RuneIsEquipped(428717)) and NAG:Cast(12662)
    or ((NAG:CurrentManaPercent() < 0.6) and ((not NAG:AuraIsKnown(1233451)) or NAG:RuneIsEquipped(428726))) and NAG:Cast(12662)
    or (not NAG:DotIsActive(25295)) and NAG:Cast(25295)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentTime() > 6.0) and (NAG:AutoTimeToNext() > 1.0) and (NAG:GCDTimeToReady() > 1.0)) and NAG:Cast(233986)
    or ((NAG:SpellTimeToReady(409433) > 2.0) and (NAG:SpellTimeToReady(3045) < 0.5) and (NAG:SpellTimeToReady(409593) < 0.5)) and NAG:WaitUntil(NAG:SpellIsReady(3045))
    or ((NAG:RemainingTime() <= 30.0) or (((NAG:CurrentTime() + NAG:RemainingTime()) > 150.0) and ((NAG:CurrentTime() + NAG:RemainingTime()) < 210.0))) and NAG:AutocastOtherCooldowns()
    or NAG:AuraIsActive(3045) and NAG:AutocastOtherCooldowns()
    or ((NAG:CurrentManaPercent() >= 0.5) or NAG:SpellIsReady(3045)) and NAG:CancelAura(415423)
    or ((NAG:AuraNumStacks(428728) >= 5) and (NAG:AuraRemainingTime(428726) <= 1)) and NAG:Cast(428726)
    or (NAG:SpellCanCast(409593) and ((not NAG:AuraIsKnown(428726)) or (NAG:AuraNumStacks(428726) == 5)) and (not NAG:SpellIsReady(409433))) and NAG:Cast(3045)
    or ((NAG:DotRemainingTime(25295) < 6.0) and ((not NAG:AuraIsKnown(1233451)) or (NAG:SpellTimeToReady(25294) < 4.0))) and NAG:Cast(409433)
    or ((NAG:AuraNumStacks(1233451) == 4) and NAG:AuraIsKnown(1233451)) and NAG:Cast(25294)
    or NAG:Sequence("Opener", NAG:Cast(409433))
    or (NAG:AuraIsKnown(428726) and (not NAG:AuraIsActive(428726))) and NAG:Cast(409433)
    or (NAG:AuraIsKnown(428726) and (not NAG:AuraIsActive(428726))) and NAG:Cast(409593)
    or NAG:AuraIsActive(3045) and NAG:Cast(409593)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:IsExecutePhase(20) and NAG:SpellIsReady(409593) and ((NAG:SpellTimeToReady(25294) > 0.5) or (not NAG:AuraIsKnown(1233451)))) and NAG:Cast(409433)
    or (NAG:SpellIsReady(409433) and NAG:SpellIsReady(409593) and (NAG:SpellTimeToReady(25294) > 3.0) and (NAG:SpellTimeToReady(25294) < 5.0) and NAG:AuraIsKnown(1233451)) and NAG:Cast(409593)
    or ((NAG:AuraNumStacks(1233451) < 3) or (NAG:SpellTimeToReady(25294) > 0.5) or (not NAG:AuraIsKnown(1233451))) and NAG:Cast(409433)
    or (((NAG:AuraNumStacks(1233451) < 4) and NAG:AuraIsKnown(1233451)) or ((NAG:SpellTimeToReady(25294) > 0.5) and NAG:AuraIsKnown(1233451))) and NAG:Cast(409593)
    or (not NAG:AuraIsKnown(1233451)) and NAG:Cast(409593)
    or (NAG:AuraIsKnown(1233451) or (not NAG:RuneIsEquipped(428717))) and NAG:Cast(25294)
    or (((NAG:SpellTimeToReady(25294) > 2.0) or (not NAG:AuraIsKnown(1233451))) and (not NAG:RuneIsEquipped(428717))) and NAG:Cast(14287)
    or (((NAG:SpellTimeToReady(25294) > 1.5) or (not NAG:AuraIsKnown(1233451))) and NAG:RuneIsEquipped(428717)) and NAG:Cast(409535)
    or ((NAG:CurrentManaPercent() < 0.4) and (NAG:RemainingTime() >= 15.0) and NAG:AuraIsKnown(1233451)) and NAG:Cast(415423)
    or NAG:Cast(25294)
    or (not NAG:AuraIsActive(25296)) and NAG:Cast(25296)
    or False and NAG:Cast(20572)
        ]],

    -- Tracked IDs for optimization
    spells = {3045, 14287, 20572, 25294, 25295, 25296, 409433, 409535, 409593, 415423, 428726, 428728, 1233451},
    items = {12662, 13444, 233986, 241241},
    auras = {},
    runes = {428717, 428726},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Survival 2H 5Min Melee Melee2H Pet Phase8 PreRaid rotation
local survival2H5MinMeleeMelee2HPetPhase8PreRaid = {
    name = "Hunter Survival - 2H_5Min_Melee_Melee2H_Pet_Phase8_PreRaid by APLParser",
    specIndex = 3,
    class = "HUNTER",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(469145)" },
        { time = -1.5, action = "NAG:Cast(20572)" },
        { time = -0.1, action = "NAG:Cast(1213366)" }
    },
    rotationString = [[
((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() >= 10)) and NAG:AutocastOtherCooldowns()
    or ((not NAG:AuraIsActive(415358)) and (NAG:AuraNumStacks(415320) < 3)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) < 2.0) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or ((NAG:AuraNumStacks(415358) >= 4) and NAG:AuraIsActive(467331)) and NAG:Cast(14271)
    or NAG:AuraIsActive(467331) and NAG:Cast(458482)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(458482)
    or NAG:Cast(415320)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(1219176)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409530)
        ]],

    -- Tracked IDs for optimization
    spells = {14271, 409530, 415320, 415343, 415358, 415423, 458482, 467331, 469145, 1219176},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Survival 5Min DW Melee MeleeDW Pet Phase8 PreRaid rotation
local survival5MinDWMeleeMeleeDWPetPhase8PreRaid = {
    name = "Hunter Survival - 5Min_DW_Melee_MeleeDW_Pet_Phase8_PreRaid by APLParser",
    specIndex = 3,
    class = "HUNTER",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(469145)" },
        { time = -1.5, action = "NAG:Cast(20572)" },
        { time = -0.1, action = "NAG:Cast(1213366)" }
    },
    rotationString = [[
((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() >= 10)) and NAG:AutocastOtherCooldowns()
    or ((not NAG:AuraIsActive(415358)) and (NAG:AuraNumStacks(415320) < 3)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) < 2.0) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or ((NAG:AuraNumStacks(415358) >= 5) and NAG:AuraIsActive(467331)) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(1219176)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409530)
        ]],

    -- Tracked IDs for optimization
    spells = {14271, 409530, 415320, 415343, 415358, 415423, 467331, 469145, 1219176},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Marksmanship 5Min Phase8 PreRaid Ranged rotation
local marksmanship5MinPhase8PreRaidRanged = {
    name = "Hunter Marksmanship - 5Min_Phase8_PreRaid_Ranged by APLParser",
    specIndex = 2,
    class = "HUNTER",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(25296)" },
        { time = -0.45, action = "NAG:Cast(1213366)" },
        { time = -0.45, action = "NAG:Cast(25295)" }
    },
    rotationString = [[
(NAG:CurrentMana() < 0.8) and NAG:Cast(12662)
    or (NAG:CurrentMana() < 0.8) and NAG:Cast(13444)
    or ((NAG:CurrentTime() > 20.0) and (NAG:AutoTimeToNext() > 1.0) and (NAG:GCDTimeToReady() > 1.0)) and NAG:Cast(233986)
    or (NAG:SpellCanCast(409593) and NAG:SpellCanCast(3045) and (not NAG:SpellIsReady(409433))) and NAG:Cast(26297)
    or (NAG:SpellCanCast(409593) and NAG:SpellCanCast(3045) and (not NAG:SpellIsReady(409433))) and NAG:AutocastOtherCooldowns()
    or (NAG:SpellCanCast(409593) and (not NAG:SpellIsReady(409433))) and NAG:Cast(3045)
    or ((NAG:DotRemainingTime(25295) < 6.0) and (not NAG:IsExecutePhase(20))) and NAG:Cast(409433)
    or NAG:AuraIsActive(3045) and NAG:Cast(409593)
    or NAG:IsExecutePhase(20) and NAG:Cast(409433)
    or NAG:IsExecutePhase(20) and NAG:Cast(409593)
    or (not NAG:DotIsActive(25295)) and NAG:Cast(25295)
    or (NAG:SpellTimeToReady(3045) > 20) and NAG:Cast(236268)
    or (NAG:AuraIsKnown(468388) and NAG:AuraIsActive(468388)) and NAG:Cast(409433)
    or (NAG:CurrentTime() > 5.0) and NAG:Cast(409593)
    or ((not NAG:SpellIsReady(3045)) and (not NAG:AuraIsActive(3045)) and NAG:SpellIsReady(409433)) and NAG:Cast(468388)
    or NAG:Cast(409433)
    or NAG:Cast(409535)
    or NAG:Cast(25294)
    or NAG:Cast(14287)
    or False and NAG:Cast(20572)
        ]],

    -- Tracked IDs for optimization
    spells = {3045, 14287, 20572, 25294, 25295, 26297, 409433, 409535, 409593, 468388},
    items = {12662, 13444, 233986, 236268},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Unknown 5Min Phase8 PreRaid Ranged rotation
local unknown5MinPhase8PreRaidRanged = {
    name = "Hunter Unknown - 5Min_Phase8_PreRaid_Ranged by APLParser",
    specIndex = 4,
    class = "HUNTER",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(25296)" },
        { time = -2.0, action = "NAG:Cast(20572)" },
        { time = -0.45, action = "NAG:Cast(26297)" },
        { time = -0.45, action = "NAG:Cast(25295)" }
    },
        rotationString = [[
((NAG:CurrentManaPercent() < 0.8) and NAG:AuraIsKnown(1233451) and NAG:RuneIsEquipped(428717)) and NAG:Cast(13444)
    or ((NAG:CurrentManaPercent() < 0.45) and ((not NAG:AuraIsKnown(1233451)) or NAG:RuneIsEquipped(428726))) and NAG:Cast(13444)
    or ((NAG:CurrentManaPercent() < 0.8) and NAG:AuraIsKnown(1233451) and NAG:RuneIsEquipped(428717)) and NAG:Cast(12662)
    or ((NAG:CurrentManaPercent() < 0.6) and ((not NAG:AuraIsKnown(1233451)) or NAG:RuneIsEquipped(428726))) and NAG:Cast(12662)
    or (not NAG:DotIsActive(25295)) and NAG:Cast(25295)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentTime() > 6.0) and (NAG:AutoTimeToNext() > 1.0) and (NAG:GCDTimeToReady() > 1.0)) and NAG:Cast(233986)
    or ((NAG:SpellTimeToReady(409433) > 2.0) and (NAG:SpellTimeToReady(3045) < 0.5) and (NAG:SpellTimeToReady(409593) < 0.5)) and NAG:WaitUntil(NAG:SpellIsReady(3045))
    or ((NAG:RemainingTime() <= 30.0) or (((NAG:CurrentTime() + NAG:RemainingTime()) > 150.0) and ((NAG:CurrentTime() + NAG:RemainingTime()) < 210.0))) and NAG:AutocastOtherCooldowns()
    or NAG:AuraIsActive(3045) and NAG:AutocastOtherCooldowns()
    or ((NAG:CurrentManaPercent() >= 0.5) or NAG:SpellIsReady(3045)) and NAG:CancelAura(415423)
    or ((NAG:AuraNumStacks(428728) >= 5) and (NAG:AuraRemainingTime(428726) <= 1)) and NAG:Cast(428726)
    or (NAG:SpellCanCast(409593) and ((not NAG:AuraIsKnown(428726)) or (NAG:AuraNumStacks(428726) == 5)) and (not NAG:SpellIsReady(409433))) and NAG:Cast(3045)
    or ((NAG:DotRemainingTime(25295) < 6.0) and ((not NAG:AuraIsKnown(1233451)) or (NAG:SpellTimeToReady(25294) < 4.0))) and NAG:Cast(409433)
    or ((NAG:AuraNumStacks(1233451) == 4) and NAG:AuraIsKnown(1233451)) and NAG:Cast(25294)
    or NAG:Sequence("Opener", NAG:Cast(409433))
    or (NAG:AuraIsKnown(428726) and (not NAG:AuraIsActive(428726))) and NAG:Cast(409433)
    or (NAG:AuraIsKnown(428726) and (not NAG:AuraIsActive(428726))) and NAG:Cast(409593)
    or NAG:AuraIsActive(3045) and NAG:Cast(409593)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:IsExecutePhase(20) and NAG:SpellIsReady(409593) and ((NAG:SpellTimeToReady(25294) > 0.5) or (not NAG:AuraIsKnown(1233451)))) and NAG:Cast(409433)
    or (NAG:SpellIsReady(409433) and NAG:SpellIsReady(409593) and (NAG:SpellTimeToReady(25294) > 3.0) and (NAG:SpellTimeToReady(25294) < 5.0) and NAG:AuraIsKnown(1233451)) and NAG:Cast(409593)
    or ((NAG:AuraNumStacks(1233451) < 3) or (NAG:SpellTimeToReady(25294) > 0.5) or (not NAG:AuraIsKnown(1233451))) and NAG:Cast(409433)
    or (((NAG:AuraNumStacks(1233451) < 4) and NAG:AuraIsKnown(1233451)) or ((NAG:SpellTimeToReady(25294) > 0.5) and NAG:AuraIsKnown(1233451))) and NAG:Cast(409593)
    or (not NAG:AuraIsKnown(1233451)) and NAG:Cast(409593)
    or (NAG:AuraIsKnown(1233451) or (not NAG:RuneIsEquipped(428717))) and NAG:Cast(25294)
    or (((NAG:SpellTimeToReady(25294) > 2.0) or (not NAG:AuraIsKnown(1233451))) and (not NAG:RuneIsEquipped(428717))) and NAG:Cast(14287)
    or (((NAG:SpellTimeToReady(25294) > 1.5) or (not NAG:AuraIsKnown(1233451))) and NAG:RuneIsEquipped(428717)) and NAG:Cast(409535)
    or ((NAG:CurrentManaPercent() < 0.4) and (NAG:RemainingTime() >= 15.0) and NAG:AuraIsKnown(1233451)) and NAG:Cast(415423)
    or NAG:Cast(25294)
    or (not NAG:AuraIsActive(25296)) and NAG:Cast(25296)
    or False and NAG:Cast(20572)
        ]],

        -- New action-based format

        -- Tracked IDs for optimization
        spells = {3045, 14287, 20572, 25294, 25295, 25296, 409433, 409535, 409593, 415423, 428726, 428728, 1233451},
        items = {12662, 13444, 233986, 241241},
        auras = {},
        runes = {428717, 428726},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }

-- Unknown 1Target 1Min BiS Phase8 Ranged ST rotation
local unknown1Target1MinBiSPhase8RangedST = {
    name = "Hunter Unknown - 1Target_1Min_BiS_Phase8_Ranged_ST by APLParser",
    specIndex = 4,
    class = "HUNTER",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(25296)" },
        { time = -2.0, action = "NAG:Cast(20572)" },
        { time = -0.45, action = "NAG:Cast(25295)" }
    },
    rotationString = [[
(NAG:CurrentManaPercent() < 0.8) and NAG:Cast(12662)
    or (NAG:CurrentManaPercent() < 0.8) and NAG:Cast(13444)
    or (not NAG:DotIsActive(25295)) and NAG:Cast(25295)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:AutoTimeToNext() > 1.5) and (NAG:GCDTimeToReady() > 1.0) and (NAG:RemainingTime() < 30.0)) and NAG:Cast(233986)
    or ((NAG:AuraNumStacks(1231591) < 5) and (NAG:AuraNumStacks(428728) == 5)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(1231591) == 5) and (NAG:AuraNumStacks(428728) == 5) and (NAG:AuraRemainingTime(1231591) < 1.0)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(1231591) == 5) and NAG:GCDIsReady()) and NAG:Cast(26297)
    or ((NAG:AuraNumStacks(1231591) == 5) and NAG:GCDIsReady()) and NAG:AutocastOtherCooldowns()
    or ((NAG:AutoTimeToNext() > 0.4) and (NAG:GCDTimeToReady() > 1.0)) and NAG:MoveToRange(12)
    or ((NAG:AutoTimeToNext() > 0.4) and (NAG:SpellTimeToReady(409433) >= 1.5) and (NAG:SpellTimeToReady(25294) >= 3.0)) and NAG:CancelAura(215162)
    or ((NAG:AutoTimeToNext() > 0.4) and (NAG:SpellTimeToReady(409433) >= 1.5) and (NAG:SpellTimeToReady(25294) >= 3.0)) and NAG:MoveToRange(5)
    or NAG:Cast(14266)
    or NAG:SpellCanCast(14268) and NAG:Cast(415320)
    or ((not NAG:AuraIsActive(415413)) and (NAG:SpellTimeToReady(25294) > 3) and NAG:AuraIsActive(409535) and NAG:SpellIsReady(409433)) and NAG:Cast(409530)
    or ((not NAG:AuraIsActive(415413)) and (NAG:SpellTimeToReady(25294) > 3) and NAG:SpellIsReady(409433)) and NAG:Cast(409535)
    or ((not NAG:AuraIsActive(415413)) and (NAG:SpellTimeToReady(25294) > 3) and NAG:SpellIsReady(409433)) and NAG:Cast(409510)
    or NAG:Cast(409433)
    or NAG:Cast(25294)
    or False and NAG:Cast(20572)
        ]],

    -- Tracked IDs for optimization
    spells = {14266, 14268, 20572, 25294, 25295, 26297, 409433, 409510, 409530, 409535, 415320, 415413, 428726, 428728, 1231591},
    items = {12662, 13444, 215162, 233986, 241241},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Survival 1Target 1Min 2H BiS Melee Melee2H Phase8 ST rotation
local survival1Target1Min2HBiSMeleeMelee2HPhase8ST = {
    name = "Hunter Survival - 1Target_1Min_2H_BiS_Melee_Melee2H_Phase8_ST by APLParser",
    specIndex = 3,
    class = "HUNTER",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(469145)" },
        { time = -1.6, action = "NAG:Cast(20572)" },
        { time = -0.1, action = "NAG:Cast(25295)" }
    },
    rotationString = [[
(NAG:SpellInFlight() or NAG:DotIsActive(25295)) and NAG:MoveToRange(5)
    or ((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() > 10.0)) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraNumStacks(1232946) > 3) and NAG:Cast(1231604)
    or ((not NAG:DotIsActive(458482)) and (not NAG:DotIsActive(25295)) and (not NAG:DotIsActive(1232979)) and (not NAG:DotIsActive(1232980)) and (not NAG:DotIsActive(1232981)) and (not NAG:DotIsActive(1232982))) and NAG:Cast(458482)
    or (((not NAG:SpellIsReady(458482)) or NAG:DotIsActive(458482)) and (not NAG:SpellIsReady(415343)) and NAG:GCDIsReady() and NAG:SpellCanCast(415320)) and NAG:Cast(468388)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:CancelAura(415423)
    or ((NAG:AuraNumStacks(415320) < 3) and NAG:AuraIsActive(468388)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) <= 1.5) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or ((NAG:AuraNumStacks(415358) >= 4)) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(458482)
    or ((not NAG:AuraIsActive(415320))) and NAG:Cast(415320)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409530)
    or ((NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(14268)
    or NAG:Cast(10646)
        ]],

    -- Tracked IDs for optimization
    spells = {14268, 14271, 25295, 409530, 415320, 415343, 415358, 415423, 458482, 468388, 469145, 1231604, 1232946, 1232979, 1232980, 1232981, 1232982},
    items = {10646},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Survival 1Target 1Min 2H BiS Melee Melee2H Pet Phase8 ST rotation
local survival1Target1Min2HBiSMeleeMelee2HPetPhase8ST = {
    name = "Hunter Survival - 1Target_1Min_2H_BiS_Melee_Melee2H_Pet_Phase8_ST by APLParser",
    specIndex = 3,
    class = "HUNTER",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(469145)" },
        { time = -1.6, action = "NAG:Cast(20572)" },
        { time = -0.1, action = "NAG:Cast(25295)" }
    },
    rotationString = [[
(NAG:SpellInFlight() or NAG:DotIsActive(25295)) and NAG:MoveToRange(5)
    or (NAG:AuraNumStacks(1232946) > 3) and NAG:Cast(1231604)
    or ((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() >= 10)) and NAG:AutocastOtherCooldowns()
    or ((not NAG:DotIsActive(25295)) and (not NAG:DotIsActive(1232979)) and (not NAG:DotIsActive(1232980)) and (not NAG:DotIsActive(1232981)) and (not NAG:DotIsActive(1232982)) and (not NAG:DotIsActive(458482))) and NAG:Cast(458482)
    or ((not NAG:AuraIsActive(415358)) and (NAG:AuraNumStacks(415320) < 3)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) < 2.0) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or ((NAG:AuraNumStacks(415358) >= 4)) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(458482)
    or NAG:Cast(415320)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(1219176)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409530)
        ]],

    -- Tracked IDs for optimization
    spells = {14271, 25295, 409530, 415320, 415343, 415358, 415423, 458482, 469145, 1219176, 1231604, 1232946, 1232979, 1232980, 1232981, 1232982},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

local marksmanship1Target1MinBiSPetPhase8RangedST = {
    name = "Hunter Marksmanship - 1Target_1Min_BiS_Pet_Phase8_Ranged_ST by APLParser",
    specIndex = 2,
    class = "HUNTER",
    rotationType = "ST",
    -- Required parameters
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(25296)" },
        { time = -2.0, action = "NAG:Cast(20572)" },
        { time = -0.45, action = "NAG:Cast(26297)" },
        { time = -0.45, action = "NAG:Cast(25295)" }
    },
    rotationString = [[
((NAG:CurrentManaPercent() < 0.8) and NAG:AuraIsKnown(1233451) and NAG:RuneIsEquipped(428717)) and NAG:Cast(13444)
    or ((NAG:CurrentManaPercent() < 0.45) and ((not NAG:AuraIsKnown(1233451)) or NAG:RuneIsEquipped(428726))) and NAG:Cast(13444)
    or ((NAG:CurrentManaPercent() < 0.8) and NAG:AuraIsKnown(1233451) and NAG:RuneIsEquipped(428717)) and NAG:Cast(12662)
    or ((NAG:CurrentManaPercent() < 0.6) and ((not NAG:AuraIsKnown(1233451)) or NAG:RuneIsEquipped(428726))) and NAG:Cast(12662)
    or (not NAG:DotIsActive(25295)) and NAG:Cast(25295)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentTime() > 6.0) and (NAG:AutoTimeToNext() > 1.0) and (NAG:GCDTimeToReady() > 1.0)) and NAG:Cast(233986)
    or ((NAG:SpellTimeToReady(409433) > 2.0) and (NAG:SpellTimeToReady(3045) < 0.5) and (NAG:SpellTimeToReady(409593) < 0.5)) and NAG:WaitUntil(NAG:SpellIsReady(3045))
    or ((NAG:RemainingTime() <= 30.0) or (((NAG:CurrentTime() + NAG:RemainingTime()) > 150.0) and ((NAG:CurrentTime() + NAG:RemainingTime()) < 210.0))) and NAG:AutocastOtherCooldowns()
    or NAG:AuraIsActive(3045) and NAG:AutocastOtherCooldowns()
    or ((NAG:CurrentManaPercent() >= 0.5) or NAG:SpellIsReady(3045)) and NAG:CancelAura(415423)
    or ((NAG:AuraNumStacks(428728) >= 5) and (NAG:AuraRemainingTime(428726) <= 1) and (NAG:CurrentTime() <= 10.0)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(428728) >= 5) and (NAG:AuraRemainingTime(428726) <= 1) and (NAG:CurrentTime() >= 10.0) and NAG:AuraIsKnown(428726)) and NAG:Cast(428726)
    or ((NAG:CurrentTime() >= 6.0) and (NAG:AuraRemainingTime(428726) <= 1) and (NAG:AuraNumStacks(428728) <= 3)) and NAG:Cast(428726)
    or ((NAG:CurrentTime() >= 2.5) and (NAG:CurrentTime() <= 4.0) and 0) and NAG:Sequence("Exotic", NAG:Cast(428726))
    or (NAG:SpellCanCast(409593) and (NAG:SpellTimeToReady(409433) >= NAG:SpellTimeToReady(3045)) and (NAG:RemainingTime() <= 75) and (NAG:AuraNumStacks(428728) == 4) and (NAG:AuraNumStacks(428726) ~= 5) and NAG:AuraIsKnown(428726) and NAG:SpellCanCast(3045)) and NAG:WaitUntil(((NAG:AuraNumStacks(428728) == 5) or NAG:SpellIsReady(409433)))
    or (NAG:SpellCanCast(409593) and ((not NAG:AuraIsKnown(428726)) or NAG:AuraIsActive(428726) or (NAG:AuraNumStacks(428728) >= 4) or (NAG:CurrentTime() >= 6.0)) and (not NAG:SpellIsReady(409433)) and ((not NAG:AuraIsKnown(1233451)) or (NAG:CurrentTime() >= 6.0))) and NAG:Cast(3045)
    or ((NAG:DotRemainingTime(25295) < 6.0) and ((not NAG:AuraIsKnown(1233451)) or (NAG:SpellTimeToReady(25294) < 4.0))) and NAG:Cast(409433)
    or ((NAG:AuraNumStacks(1233451) == 4) and NAG:AuraIsKnown(1233451)) and NAG:Cast(25294)
    or NAG:Sequence("Opener", NAG:Cast(409433))
    or (NAG:AuraIsKnown(428726) and ((not NAG:AuraIsActive(428726)) or NAG:SpellCanCast(3045))) and NAG:Cast(409433)
    or NAG:AuraIsActive(3045) and NAG:Cast(409593)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:IsExecutePhase(20) and NAG:SpellIsReady(409593) and ((NAG:SpellTimeToReady(25294) > 0.5) or (not NAG:AuraIsKnown(1233451)))) and NAG:Cast(409433)
    or (NAG:SpellIsReady(409433) and NAG:SpellIsReady(409593) and (NAG:SpellTimeToReady(25294) > 3.0) and (NAG:SpellTimeToReady(25294) < 5.0) and NAG:AuraIsKnown(1233451) and (not NAG:SpellIsReady(3045))) and NAG:Cast(409593)
    or ((NAG:AuraNumStacks(1233451) < 3) or (NAG:SpellTimeToReady(25294) > 0.5) or (not NAG:AuraIsKnown(1233451))) and NAG:Cast(409433)
    or (((NAG:AuraNumStacks(1233451) < 4) and NAG:AuraIsKnown(1233451)) or ((NAG:SpellTimeToReady(25294) > 0.5) and NAG:AuraIsKnown(1233451))) and NAG:Cast(409593)
    or (not NAG:AuraIsKnown(1233451)) and NAG:Cast(409593)
    or (NAG:AuraIsKnown(1233451) or (not NAG:RuneIsEquipped(428717))) and NAG:Cast(25294)
    or (((NAG:SpellTimeToReady(25294) > 2.0) or (not NAG:AuraIsKnown(1233451))) and (not NAG:RuneIsEquipped(428717))) and NAG:Cast(14287)
    or (((NAG:SpellTimeToReady(25294) > 1.5) or (not NAG:AuraIsKnown(1233451))) and NAG:RuneIsEquipped(428717)) and NAG:Cast(409535)
    or ((NAG:CurrentManaPercent() < 0.4) and (NAG:RemainingTime() >= 15.0) and NAG:AuraIsKnown(1233451)) and NAG:Cast(415423)
    or NAG:Cast(25294)
    or (not NAG:AuraIsActive(25296)) and NAG:Cast(25296)
    or False and NAG:Cast(20572)
        ]],

    -- New action-based format

    -- Tracked IDs for optimization
    spells = {3045, 14287, 20572, 25294, 25295, 25296, 409433, 409535, 409593, 415423, 428726, 428728, 1233451},
    items = {12662, 13444, 233986, 241241},
    auras = {},
    runes = {428717, 428726},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

local survival1Target1MinBiSDWMeleeMeleeDWPetPhase8ST = {
    name = "Hunter Survival - 1Target_1Min_BiS_DW_Melee_MeleeDW_Pet_Phase8_ST by APLParser",
    specIndex = 3,
    class = "HUNTER",
    rotationType = "ST",
    -- Required parameters
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(469145)" },
        { time = -1.6, action = "NAG:Cast(20572)" },
        { time = -0.1, action = "NAG:Cast(25295)" },
        { time = -0.1, action = "NAG:Cast(19574)" }
    },
    rotationString = [[
(NAG:DotIsActive(25295) or NAG:SpellInFlight()) and NAG:MoveToRange(5)
    or (NAG:AuraRemainingTime(241241) <= 1.5) and NAG:Cast(241241)
    or ((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() >= 10)) and NAG:AutocastOtherCooldowns()
    or ((NAG:AuraNumStacks(415320) < 3) and (not NAG:AuraIsActive(415358))) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) < 2.0) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or (NAG:AuraNumStacks(1232946) == 4) and NAG:Cast(1231604)
    or (NAG:AuraNumStacks(415358) >= 5) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(1219176)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409530)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(14268)
        ]],

    -- New action-based format

    -- Tracked IDs for optimization
    spells = {14268, 14271, 25295, 409530, 415320, 415343, 415358, 415423, 469145, 1219176, 1231604, 1232946},
    items = {241241},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

local survival1Target1MinBiSDWMeleeMeleeDWPhase8ST = {
    name = "Hunter Survival - 1Target_1Min_BiS_DW_Melee_MeleeDW_Phase8_ST by APLParser",
    specIndex = 3,
    class = "HUNTER",
    rotationType = "ST",
    -- Required parameters
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(469145)" },
        { time = -1.6, action = "NAG:Cast(20572)" },
        { time = -0.1, action = "NAG:Cast(25295)" }
    },
    rotationString = [[
(NAG:DotIsActive(25295) or NAG:SpellInFlight()) and NAG:MoveToRange(5)
    or NAG:AutocastOtherCooldowns()
    or (NAG:AuraNumStacks(1232946) == 4) and NAG:Cast(1231604)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:CancelAura(415423)
    or ((NAG:AuraNumStacks(415358) >= 5)) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(409593)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5) and (NAG:SpellTimeToReady(409593) >= 1.5)) and NAG:Cast(409530)
    or ((NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5) and (NAG:SpellTimeToReady(409593) >= 1.5)) and NAG:Cast(14268)
        ]],

    -- New action-based format

    -- Tracked IDs for optimization
    spells = {14268, 14271, 25295, 409530, 409593, 415343, 415358, 415423, 469145, 1231604, 1232946},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

local marksmanship1Target1MinBiSPhase8RangedST = {
    name = "Hunter Marksmanship - 1Target_1Min_BiS_Phase8_Ranged_ST by APLParser",
    specIndex = 2,
    class = "HUNTER",
    rotationType = "ST",
    -- Required parameters
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(25296)" },
        { time = -2.0, action = "NAG:Cast(20572)" },
        { time = -0.45, action = "NAG:Cast(26297)" },
        { time = -0.45, action = "NAG:Cast(25295)" }
    },
    rotationString = [[
((NAG:CurrentManaPercent() < 0.8) and NAG:AuraIsKnown(1233451) and NAG:RuneIsEquipped(428717)) and NAG:Cast(13444)
    or ((NAG:CurrentManaPercent() < 0.45) and ((not NAG:AuraIsKnown(1233451)) or NAG:RuneIsEquipped(428726))) and NAG:Cast(13444)
    or ((NAG:CurrentManaPercent() < 0.8) and NAG:AuraIsKnown(1233451) and NAG:RuneIsEquipped(428717)) and NAG:Cast(12662)
    or ((NAG:CurrentManaPercent() < 0.6) and ((not NAG:AuraIsKnown(1233451)) or NAG:RuneIsEquipped(428726))) and NAG:Cast(12662)
    or (not NAG:DotIsActive(25295)) and NAG:Cast(25295)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentTime() > 6.0) and (NAG:AutoTimeToNext() > 1.0) and (NAG:GCDTimeToReady() > 1.0)) and NAG:Cast(233986)
    or ((NAG:SpellTimeToReady(409433) > 2.0) and (NAG:SpellTimeToReady(3045) < 0.5) and (NAG:SpellTimeToReady(409593) < 0.5)) and NAG:WaitUntil(NAG:SpellIsReady(3045))
    or ((NAG:RemainingTime() <= 30.0) or (((NAG:CurrentTime() + NAG:RemainingTime()) > 150.0) and ((NAG:CurrentTime() + NAG:RemainingTime()) < 210.0))) and NAG:AutocastOtherCooldowns()
    or NAG:AuraIsActive(3045) and NAG:AutocastOtherCooldowns()
    or ((NAG:CurrentManaPercent() >= 0.5) or NAG:SpellIsReady(3045)) and NAG:CancelAura(415423)
    or ((NAG:AuraNumStacks(428728) >= 5) and (NAG:AuraRemainingTime(428726) <= 1)) and NAG:Cast(428726)
    or (NAG:SpellCanCast(409593) and ((not NAG:AuraIsKnown(428726)) or (NAG:AuraNumStacks(428726) == 5)) and (not NAG:SpellIsReady(409433))) and NAG:Cast(3045)
    or ((NAG:DotRemainingTime(25295) < 6.0) and ((not NAG:AuraIsKnown(1233451)) or (NAG:SpellTimeToReady(25294) < 4.0))) and NAG:Cast(409433)
    or ((NAG:AuraNumStacks(1233451) == 4) and NAG:AuraIsKnown(1233451)) and NAG:Cast(25294)
    or NAG:Sequence("Opener", NAG:Cast(409433))
    or (NAG:AuraIsKnown(428726) and (not NAG:AuraIsActive(428726))) and NAG:Cast(409433)
    or (NAG:AuraIsKnown(428726) and (not NAG:AuraIsActive(428726))) and NAG:Cast(409593)
    or NAG:AuraIsActive(3045) and NAG:Cast(409593)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:IsExecutePhase(20) and NAG:SpellIsReady(409593) and ((NAG:SpellTimeToReady(25294) > 0.5) or (not NAG:AuraIsKnown(1233451)))) and NAG:Cast(409433)
    or (NAG:SpellIsReady(409433) and NAG:SpellIsReady(409593) and (NAG:SpellTimeToReady(25294) > 3.0) and (NAG:SpellTimeToReady(25294) < 5.0) and NAG:AuraIsKnown(1233451)) and NAG:Cast(409593)
    or ((NAG:AuraNumStacks(1233451) < 3) or (NAG:SpellTimeToReady(25294) > 0.5) or (not NAG:AuraIsKnown(1233451))) and NAG:Cast(409433)
    or (((NAG:AuraNumStacks(1233451) < 4) and NAG:AuraIsKnown(1233451)) or ((NAG:SpellTimeToReady(25294) > 0.5) and NAG:AuraIsKnown(1233451))) and NAG:Cast(409593)
    or (not NAG:AuraIsKnown(1233451)) and NAG:Cast(409593)
    or (NAG:AuraIsKnown(1233451) or (not NAG:RuneIsEquipped(428717))) and NAG:Cast(25294)
    or (((NAG:SpellTimeToReady(25294) > 2.0) or (not NAG:AuraIsKnown(1233451))) and (not NAG:RuneIsEquipped(428717))) and NAG:Cast(14287)
    or (((NAG:SpellTimeToReady(25294) > 1.5) or (not NAG:AuraIsKnown(1233451))) and NAG:RuneIsEquipped(428717)) and NAG:Cast(409535)
    or ((NAG:CurrentManaPercent() < 0.4) and (NAG:RemainingTime() >= 15.0) and NAG:AuraIsKnown(1233451)) and NAG:Cast(415423)
    or NAG:Cast(25294)
    or (not NAG:AuraIsActive(25296)) and NAG:Cast(25296)
    or False and NAG:Cast(20572)
        ]],

    -- New action-based format

    -- Tracked IDs for optimization
    spells = {3045, 14287, 20572, 25294, 25295, 25296, 409433, 409535, 409593, 415423, 428726, 428728, 1233451},
    items = {12662, 13444, 233986, 241241},
    auras = {},
    runes = {428717, 428726},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

local unknown1Target2MinBiSPhase8RangedST = {
    name = "Hunter Unknown - 1Target_2Min_BiS_Phase8_Ranged_ST by APLParser",
    class = "HUNTER",
    rotationType = "ST",
    -- Required parameters
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(25296)" },
        { time = -2.0, action = "NAG:Cast(20572)" },
        { time = -0.45, action = "NAG:Cast(25295)" }
    },
    rotationString = [[
(NAG:CurrentManaPercent() < 0.8) and NAG:Cast(12662)
    or (NAG:CurrentManaPercent() < 0.8) and NAG:Cast(13444)
    or (not NAG:DotIsActive(25295)) and NAG:Cast(25295)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:AutoTimeToNext() > 1.5) and (NAG:GCDTimeToReady() > 1.0) and (NAG:RemainingTime() < 30.0)) and NAG:Cast(233986)
    or ((NAG:AuraNumStacks(1231591) < 5) and (NAG:AuraNumStacks(428728) == 5)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(1231591) == 5) and (NAG:AuraNumStacks(428728) == 5) and (NAG:AuraRemainingTime(1231591) < 1.0)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(1231591) == 5) and NAG:GCDIsReady()) and NAG:Cast(26297)
    or ((NAG:AuraNumStacks(1231591) == 5) and NAG:GCDIsReady()) and NAG:AutocastOtherCooldowns()
    or ((NAG:AutoTimeToNext() > 0.4) and (NAG:GCDTimeToReady() > 1.0)) and NAG:MoveToRange(12)
    or ((NAG:AutoTimeToNext() > 0.4) and (NAG:SpellTimeToReady(409433) >= 1.5) and (NAG:SpellTimeToReady(25294) >= 3.0)) and NAG:CancelAura(215162)
    or ((NAG:AutoTimeToNext() > 0.4) and (NAG:SpellTimeToReady(409433) >= 1.5) and (NAG:SpellTimeToReady(25294) >= 3.0)) and NAG:MoveToRange(5)
    or NAG:Cast(14266)
    or NAG:SpellCanCast(14268) and NAG:Cast(415320)
    or ((not NAG:AuraIsActive(415413)) and (NAG:SpellTimeToReady(25294) > 3) and NAG:AuraIsActive(409535) and NAG:SpellIsReady(409433)) and NAG:Cast(409530)
    or ((not NAG:AuraIsActive(415413)) and (NAG:SpellTimeToReady(25294) > 3) and NAG:SpellIsReady(409433)) and NAG:Cast(409535)
    or ((not NAG:AuraIsActive(415413)) and (NAG:SpellTimeToReady(25294) > 3) and NAG:SpellIsReady(409433)) and NAG:Cast(409510)
    or NAG:Cast(409433)
    or NAG:Cast(25294)
    or False and NAG:Cast(20572)
        ]],

    -- New action-based format

    -- Tracked IDs for optimization
    spells = {14266, 14268, 20572, 25294, 25295, 26297, 409433, 409510, 409530, 409535, 415320, 415413, 428726, 428728, 1231591},
    items = {12662, 13444, 215162, 233986, 241241},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

local survival1Target2Min2HBiSMeleeMelee2HPetPhase8ST = {
    name = "Hunter Survival - 1Target_2Min_2H_BiS_Melee_Melee2H_Pet_Phase8_ST by APLParser",
    class = "HUNTER",
    rotationType = "ST",
    -- Required parameters
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(469145)" },
        { time = -1.6, action = "NAG:Cast(20572)" },
        { time = -0.1, action = "NAG:Cast(25295)" }
    },
    rotationString = [[
(NAG:SpellInFlight() or NAG:DotIsActive(25295)) and NAG:MoveToRange(5)
    or (NAG:AuraNumStacks(1232946) > 3) and NAG:Cast(1231604)
    or ((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() >= 10)) and NAG:AutocastOtherCooldowns()
    or ((not NAG:DotIsActive(25295)) and (not NAG:DotIsActive(1232979)) and (not NAG:DotIsActive(1232980)) and (not NAG:DotIsActive(1232981)) and (not NAG:DotIsActive(1232982)) and (not NAG:DotIsActive(458482))) and NAG:Cast(458482)
    or ((not NAG:AuraIsActive(415358)) and (NAG:AuraNumStacks(415320) < 3)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) < 2.0) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or ((NAG:AuraNumStacks(415358) >= 4)) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(458482)
    or NAG:Cast(415320)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(1219176)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409530)
        ]],

    -- New action-based format

    -- Tracked IDs for optimization
    spells = {14271, 25295, 409530, 415320, 415343, 415358, 415423, 458482, 469145, 1219176, 1231604, 1232946, 1232979, 1232980, 1232981, 1232982},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Marksmanship 1Target 2Min BiS Pet Phase8 Ranged ST rotation
local marksmanship1Target2MinBiSPetPhase8RangedST = {
    name = "Hunter Marksmanship - 1Target_2Min_BiS_Pet_Phase8_Ranged_ST by APLParser",
    specIndex = 2,
    class = "HUNTER",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(25296)" },
        { time = -2.0, action = "NAG:Cast(20572)" },
        { time = -0.45, action = "NAG:Cast(26297)" },
        { time = -0.45, action = "NAG:Cast(25295)" }
    },
    rotationString = [[
((NAG:CurrentManaPercent() < 0.8) and NAG:AuraIsKnown(1233451) and NAG:RuneIsEquipped(428717)) and NAG:Cast(13444)
    or ((NAG:CurrentManaPercent() < 0.45) and ((not NAG:AuraIsKnown(1233451)) or NAG:RuneIsEquipped(428726))) and NAG:Cast(13444)
    or ((NAG:CurrentManaPercent() < 0.8) and NAG:AuraIsKnown(1233451) and NAG:RuneIsEquipped(428717)) and NAG:Cast(12662)
    or ((NAG:CurrentManaPercent() < 0.6) and ((not NAG:AuraIsKnown(1233451)) or NAG:RuneIsEquipped(428726))) and NAG:Cast(12662)
    or (not NAG:DotIsActive(25295)) and NAG:Cast(25295)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentTime() > 6.0) and (NAG:AutoTimeToNext() > 1.0) and (NAG:GCDTimeToReady() > 1.0)) and NAG:Cast(233986)
    or ((NAG:SpellTimeToReady(409433) > 2.0) and (NAG:SpellTimeToReady(3045) < 0.5) and (NAG:SpellTimeToReady(409593) < 0.5)) and NAG:WaitUntil(NAG:SpellIsReady(3045))
    or ((NAG:RemainingTime() <= 30.0) or (((NAG:CurrentTime() + NAG:RemainingTime()) > 150.0) and ((NAG:CurrentTime() + NAG:RemainingTime()) < 210.0))) and NAG:AutocastOtherCooldowns()
    or NAG:AuraIsActive(3045) and NAG:AutocastOtherCooldowns()
    or ((NAG:CurrentManaPercent() >= 0.5) or NAG:SpellIsReady(3045)) and NAG:CancelAura(415423)
    or ((NAG:AuraNumStacks(428728) >= 5) and (NAG:AuraRemainingTime(428726) <= 1) and (NAG:CurrentTime() <= 10.0)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(428728) >= 5) and (NAG:AuraRemainingTime(428726) <= 1) and (NAG:CurrentTime() >= 10.0) and NAG:AuraIsKnown(428726)) and NAG:Cast(428726)
    or ((NAG:CurrentTime() >= 6.0) and (NAG:AuraRemainingTime(428726) <= 1) and (NAG:AuraNumStacks(428728) <= 3)) and NAG:Cast(428726)
    or ((NAG:CurrentTime() >= 2.5) and (NAG:CurrentTime() <= 4.0) and 0) and NAG:Sequence("Exotic", NAG:Cast(428726))
    or (NAG:SpellCanCast(409593) and (NAG:SpellTimeToReady(409433) >= NAG:SpellTimeToReady(3045)) and (NAG:RemainingTime() <= 75) and (NAG:AuraNumStacks(428728) == 4) and (NAG:AuraNumStacks(428726) ~= 5) and NAG:AuraIsKnown(428726) and NAG:SpellCanCast(3045)) and NAG:WaitUntil(((NAG:AuraNumStacks(428728) == 5) or NAG:SpellIsReady(409433)))
    or (NAG:SpellCanCast(409593) and ((not NAG:AuraIsKnown(428726)) or NAG:AuraIsActive(428726) or (NAG:AuraNumStacks(428728) >= 4) or (NAG:CurrentTime() >= 6.0)) and (not NAG:SpellIsReady(409433)) and ((not NAG:AuraIsKnown(1233451)) or (NAG:CurrentTime() >= 6.0))) and NAG:Cast(3045)
    or ((NAG:DotRemainingTime(25295) < 6.0) and ((not NAG:AuraIsKnown(1233451)) or (NAG:SpellTimeToReady(25294) < 4.0))) and NAG:Cast(409433)
    or ((NAG:AuraNumStacks(1233451) == 4) and NAG:AuraIsKnown(1233451)) and NAG:Cast(25294)
    or NAG:Sequence("Opener", NAG:Cast(409433))
    or (NAG:AuraIsKnown(428726) and ((not NAG:AuraIsActive(428726)) or NAG:SpellCanCast(3045))) and NAG:Cast(409433)
    or NAG:AuraIsActive(3045) and NAG:Cast(409593)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:IsExecutePhase(20) and NAG:SpellIsReady(409593) and ((NAG:SpellTimeToReady(25294) > 0.5) or (not NAG:AuraIsKnown(1233451)))) and NAG:Cast(409433)
    or (NAG:SpellIsReady(409433) and NAG:SpellIsReady(409593) and (NAG:SpellTimeToReady(25294) > 3.0) and (NAG:SpellTimeToReady(25294) < 5.0) and NAG:AuraIsKnown(1233451) and (not NAG:SpellIsReady(3045))) and NAG:Cast(409593)
    or ((NAG:AuraNumStacks(1233451) < 3) or (NAG:SpellTimeToReady(25294) > 0.5) or (not NAG:AuraIsKnown(1233451))) and NAG:Cast(409433)
    or (((NAG:AuraNumStacks(1233451) < 4) and NAG:AuraIsKnown(1233451)) or ((NAG:SpellTimeToReady(25294) > 0.5) and NAG:AuraIsKnown(1233451))) and NAG:Cast(409593)
    or (not NAG:AuraIsKnown(1233451)) and NAG:Cast(409593)
    or (NAG:AuraIsKnown(1233451) or (not NAG:RuneIsEquipped(428717))) and NAG:Cast(25294)
    or (((NAG:SpellTimeToReady(25294) > 2.0) or (not NAG:AuraIsKnown(1233451))) and (not NAG:RuneIsEquipped(428717))) and NAG:Cast(14287)
    or (((NAG:SpellTimeToReady(25294) > 1.5) or (not NAG:AuraIsKnown(1233451))) and NAG:RuneIsEquipped(428717)) and NAG:Cast(409535)
    or ((NAG:CurrentManaPercent() < 0.4) and (NAG:RemainingTime() >= 15.0) and NAG:AuraIsKnown(1233451)) and NAG:Cast(415423)
    or NAG:Cast(25294)
    or (not NAG:AuraIsActive(25296)) and NAG:Cast(25296)
    or False and NAG:Cast(20572)
        ]],

    -- Tracked IDs for optimization
    spells = {3045, 14287, 20572, 25294, 25295, 25296, 409433, 409535, 409593, 415423, 428726, 428728, 1233451},
    items = {12662, 13444, 233986, 241241},
    auras = {},
    runes = {428717, 428726},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Survival 1Target 2Min 2H BiS Melee Melee2H Phase8 ST rotation
local survival1Target2Min2HBiSMeleeMelee2HPhase8ST = {
    name = "Hunter Survival - 1Target_2Min_2H_BiS_Melee_Melee2H_Phase8_ST by APLParser",
    specIndex = 3,
    class = "HUNTER",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(469145)" },
        { time = -1.6, action = "NAG:Cast(20572)" },
        { time = -0.1, action = "NAG:Cast(25295)" }
    },
    rotationString = [[
(NAG:SpellInFlight() or NAG:DotIsActive(25295)) and NAG:MoveToRange(5)
    or ((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() > 10.0)) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraNumStacks(1232946) > 3) and NAG:Cast(1231604)
    or ((not NAG:DotIsActive(458482)) and (not NAG:DotIsActive(25295)) and (not NAG:DotIsActive(1232979)) and (not NAG:DotIsActive(1232980)) and (not NAG:DotIsActive(1232981)) and (not NAG:DotIsActive(1232982))) and NAG:Cast(458482)
    or (((not NAG:SpellIsReady(458482)) or NAG:DotIsActive(458482)) and (not NAG:SpellIsReady(415343)) and NAG:GCDIsReady() and NAG:SpellCanCast(415320)) and NAG:Cast(468388)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:CancelAura(415423)
    or ((NAG:AuraNumStacks(415320) < 3) and NAG:AuraIsActive(468388)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) <= 1.5) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or ((NAG:AuraNumStacks(415358) >= 4)) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(458482)
    or ((not NAG:AuraIsActive(415320))) and NAG:Cast(415320)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409530)
    or ((NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(14268)
    or NAG:Cast(10646)
        ]],

    -- Tracked IDs for optimization
    spells = {14268, 14271, 25295, 409530, 415320, 415343, 415358, 415423, 458482, 468388, 469145, 1231604, 1232946, 1232979, 1232980, 1232981, 1232982},
    items = {10646},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Survival 1Target 2Min BiS DW Melee MeleeDW Phase8 ST rotation
local survival1Target2MinBiSDWMeleeMeleeDWPhase8ST = {
    name = "Hunter Survival - 1Target_2Min_BiS_DW_Melee_MeleeDW_Phase8_ST by APLParser",
    specIndex = 3,
    class = "HUNTER",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(469145)" },
        { time = -1.6, action = "NAG:Cast(20572)" },
        { time = -0.1, action = "NAG:Cast(25295)" }
    },
    rotationString = [[
(NAG:DotIsActive(25295) or NAG:SpellInFlight()) and NAG:MoveToRange(5)
    or NAG:AutocastOtherCooldowns()
    or (NAG:AuraNumStacks(1232946) == 4) and NAG:Cast(1231604)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:CancelAura(415423)
    or ((NAG:AuraNumStacks(415358) >= 5)) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(409593)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5) and (NAG:SpellTimeToReady(409593) >= 1.5)) and NAG:Cast(409530)
    or ((NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5) and (NAG:SpellTimeToReady(409593) >= 1.5)) and NAG:Cast(14268)
        ]],

    -- Tracked IDs for optimization
    spells = {14268, 14271, 25295, 409530, 409593, 415343, 415358, 415423, 469145, 1231604, 1232946},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Survival 1Target 2Min BiS DW Melee MeleeDW Pet Phase8 ST rotation
local survival1Target2MinBiSDWMeleeMeleeDWPetPhase8ST = {
    name = "Hunter Survival - 1Target_2Min_BiS_DW_Melee_MeleeDW_Pet_Phase8_ST by APLParser",
    specIndex = 3,
    class = "HUNTER",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(469145)" },
        { time = -1.6, action = "NAG:Cast(20572)" },
        { time = -0.1, action = "NAG:Cast(25295)" },
        { time = -0.1, action = "NAG:Cast(19574)" }
    },
    rotationString = [[
(NAG:DotIsActive(25295) or NAG:SpellInFlight()) and NAG:MoveToRange(5)
    or (NAG:AuraRemainingTime(241241) <= 1.5) and NAG:Cast(241241)
    or ((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() >= 10)) and NAG:AutocastOtherCooldowns()
    or ((NAG:AuraNumStacks(415320) < 3) and (not NAG:AuraIsActive(415358))) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) < 2.0) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or (NAG:AuraNumStacks(1232946) == 4) and NAG:Cast(1231604)
    or (NAG:AuraNumStacks(415358) >= 5) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(1219176)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409530)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(14268)
        ]],

    -- Tracked IDs for optimization
    spells = {14268, 14271, 25295, 409530, 415320, 415343, 415358, 415423, 469145, 1219176, 1231604, 1232946},
    items = {241241},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Marksmanship 1Target 2Min BiS Phase8 Ranged ST rotation
local marksmanship1Target2MinBiSPhase8RangedST = {
    name = "Hunter Marksmanship - 1Target_2Min_BiS_Phase8_Ranged_ST by APLParser",
    specIndex = 2,
    class = "HUNTER",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(25296)" },
        { time = -2.0, action = "NAG:Cast(20572)" },
        { time = -0.45, action = "NAG:Cast(26297)" },
        { time = -0.45, action = "NAG:Cast(25295)" }
    },
    rotationString = [[
((NAG:CurrentManaPercent() < 0.8) and NAG:AuraIsKnown(1233451) and NAG:RuneIsEquipped(428717)) and NAG:Cast(13444)
    or ((NAG:CurrentManaPercent() < 0.45) and ((not NAG:AuraIsKnown(1233451)) or NAG:RuneIsEquipped(428726))) and NAG:Cast(13444)
    or ((NAG:CurrentManaPercent() < 0.8) and NAG:AuraIsKnown(1233451) and NAG:RuneIsEquipped(428717)) and NAG:Cast(12662)
    or ((NAG:CurrentManaPercent() < 0.6) and ((not NAG:AuraIsKnown(1233451)) or NAG:RuneIsEquipped(428726))) and NAG:Cast(12662)
    or (not NAG:DotIsActive(25295)) and NAG:Cast(25295)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentTime() > 6.0) and (NAG:AutoTimeToNext() > 1.0) and (NAG:GCDTimeToReady() > 1.0)) and NAG:Cast(233986)
    or ((NAG:SpellTimeToReady(409433) > 2.0) and (NAG:SpellTimeToReady(3045) < 0.5) and (NAG:SpellTimeToReady(409593) < 0.5)) and NAG:WaitUntil(NAG:SpellIsReady(3045))
    or ((NAG:RemainingTime() <= 30.0) or (((NAG:CurrentTime() + NAG:RemainingTime()) > 150.0) and ((NAG:CurrentTime() + NAG:RemainingTime()) < 210.0))) and NAG:AutocastOtherCooldowns()
    or NAG:AuraIsActive(3045) and NAG:AutocastOtherCooldowns()
    or ((NAG:CurrentManaPercent() >= 0.5) or NAG:SpellIsReady(3045)) and NAG:CancelAura(415423)
    or ((NAG:AuraNumStacks(428728) >= 5) and (NAG:AuraRemainingTime(428726) <= 1)) and NAG:Cast(428726)
    or (NAG:SpellCanCast(409593) and ((not NAG:AuraIsKnown(428726)) or (NAG:AuraNumStacks(428726) == 5)) and (not NAG:SpellIsReady(409433))) and NAG:Cast(3045)
    or ((NAG:DotRemainingTime(25295) < 6.0) and ((not NAG:AuraIsKnown(1233451)) or (NAG:SpellTimeToReady(25294) < 4.0))) and NAG:Cast(409433)
    or ((NAG:AuraNumStacks(1233451) == 4) and NAG:AuraIsKnown(1233451)) and NAG:Cast(25294)
    or NAG:Sequence("Opener", NAG:Cast(409433))
    or (NAG:AuraIsKnown(428726) and (not NAG:AuraIsActive(428726))) and NAG:Cast(409433)
    or (NAG:AuraIsKnown(428726) and (not NAG:AuraIsActive(428726))) and NAG:Cast(409593)
    or NAG:AuraIsActive(3045) and NAG:Cast(409593)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:IsExecutePhase(20) and NAG:SpellIsReady(409593) and ((NAG:SpellTimeToReady(25294) > 0.5) or (not NAG:AuraIsKnown(1233451)))) and NAG:Cast(409433)
    or (NAG:SpellIsReady(409433) and NAG:SpellIsReady(409593) and (NAG:SpellTimeToReady(25294) > 3.0) and (NAG:SpellTimeToReady(25294) < 5.0) and NAG:AuraIsKnown(1233451)) and NAG:Cast(409593)
    or ((NAG:AuraNumStacks(1233451) < 3) or (NAG:SpellTimeToReady(25294) > 0.5) or (not NAG:AuraIsKnown(1233451))) and NAG:Cast(409433)
    or (((NAG:AuraNumStacks(1233451) < 4) and NAG:AuraIsKnown(1233451)) or ((NAG:SpellTimeToReady(25294) > 0.5) and NAG:AuraIsKnown(1233451))) and NAG:Cast(409593)
    or (not NAG:AuraIsKnown(1233451)) and NAG:Cast(409593)
    or (NAG:AuraIsKnown(1233451) or (not NAG:RuneIsEquipped(428717))) and NAG:Cast(25294)
    or (((NAG:SpellTimeToReady(25294) > 2.0) or (not NAG:AuraIsKnown(1233451))) and (not NAG:RuneIsEquipped(428717))) and NAG:Cast(14287)
    or (((NAG:SpellTimeToReady(25294) > 1.5) or (not NAG:AuraIsKnown(1233451))) and NAG:RuneIsEquipped(428717)) and NAG:Cast(409535)
    or ((NAG:CurrentManaPercent() < 0.4) and (NAG:RemainingTime() >= 15.0) and NAG:AuraIsKnown(1233451)) and NAG:Cast(415423)
    or NAG:Cast(25294)
    or (not NAG:AuraIsActive(25296)) and NAG:Cast(25296)
    or False and NAG:Cast(20572)
        ]],

    -- Tracked IDs for optimization
    spells = {3045, 14287, 20572, 25294, 25295, 25296, 409433, 409535, 409593, 415423, 428726, 428728, 1233451},
    items = {12662, 13444, 233986, 241241},
    auras = {},
    runes = {428717, 428726},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Unknown 1Target 3Min BiS Phase8 Ranged ST rotation
local unknown1Target3MinBiSPhase8RangedST = {
    name = "Hunter Unknown - 1Target_3Min_BiS_Phase8_Ranged_ST by APLParser",
    specIndex = 4,
    class = "HUNTER",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(25296)" },
        { time = -2.0, action = "NAG:Cast(20572)" },
        { time = -0.45, action = "NAG:Cast(25295)" }
    },
    rotationString = [[
(NAG:CurrentManaPercent() < 0.8) and NAG:Cast(12662)
    or (NAG:CurrentManaPercent() < 0.8) and NAG:Cast(13444)
    or (not NAG:DotIsActive(25295)) and NAG:Cast(25295)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:AutoTimeToNext() > 1.5) and (NAG:GCDTimeToReady() > 1.0) and (NAG:RemainingTime() < 30.0)) and NAG:Cast(233986)
    or ((NAG:AuraNumStacks(1231591) < 5) and (NAG:AuraNumStacks(428728) == 5)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(1231591) == 5) and (NAG:AuraNumStacks(428728) == 5) and (NAG:AuraRemainingTime(1231591) < 1.0)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(1231591) == 5) and NAG:GCDIsReady()) and NAG:Cast(26297)
    or ((NAG:AuraNumStacks(1231591) == 5) and NAG:GCDIsReady()) and NAG:AutocastOtherCooldowns()
    or ((NAG:AutoTimeToNext() > 0.4) and (NAG:GCDTimeToReady() > 1.0)) and NAG:MoveToRange(12)
    or ((NAG:AutoTimeToNext() > 0.4) and (NAG:SpellTimeToReady(409433) >= 1.5) and (NAG:SpellTimeToReady(25294) >= 3.0)) and NAG:CancelAura(215162)
    or ((NAG:AutoTimeToNext() > 0.4) and (NAG:SpellTimeToReady(409433) >= 1.5) and (NAG:SpellTimeToReady(25294) >= 3.0)) and NAG:MoveToRange(5)
    or NAG:Cast(14266)
    or NAG:SpellCanCast(14268) and NAG:Cast(415320)
    or ((not NAG:AuraIsActive(415413)) and (NAG:SpellTimeToReady(25294) > 3) and NAG:AuraIsActive(409535) and NAG:SpellIsReady(409433)) and NAG:Cast(409530)
    or ((not NAG:AuraIsActive(415413)) and (NAG:SpellTimeToReady(25294) > 3) and NAG:SpellIsReady(409433)) and NAG:Cast(409535)
    or ((not NAG:AuraIsActive(415413)) and (NAG:SpellTimeToReady(25294) > 3) and NAG:SpellIsReady(409433)) and NAG:Cast(409510)
    or NAG:Cast(409433)
    or NAG:Cast(25294)
    or False and NAG:Cast(20572)
        ]],

    -- Tracked IDs for optimization
    spells = {14266, 14268, 20572, 25294, 25295, 26297, 409433, 409510, 409530, 409535, 415320, 415413, 428726, 428728, 1231591},
    items = {12662, 13444, 215162, 233986, 241241},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Survival 1Target 3Min 2H BiS Melee Melee2H Pet Phase8 ST rotation
local survival1Target3Min2HBiSMeleeMelee2HPetPhase8ST = {
    name = "Hunter Survival - 1Target_3Min_2H_BiS_Melee_Melee2H_Pet_Phase8_ST by APLParser",
    specIndex = 3,
    class = "HUNTER",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(469145)" },
        { time = -1.6, action = "NAG:Cast(20572)" },
        { time = -0.1, action = "NAG:Cast(25295)" }
    },
    rotationString = [[
(NAG:SpellInFlight() or NAG:DotIsActive(25295)) and NAG:MoveToRange(5)
    or (NAG:AuraNumStacks(1232946) > 3) and NAG:Cast(1231604)
    or ((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() >= 10)) and NAG:AutocastOtherCooldowns()
    or ((not NAG:DotIsActive(25295)) and (not NAG:DotIsActive(1232979)) and (not NAG:DotIsActive(1232980)) and (not NAG:DotIsActive(1232981)) and (not NAG:DotIsActive(1232982)) and (not NAG:DotIsActive(458482))) and NAG:Cast(458482)
    or ((not NAG:AuraIsActive(415358)) and (NAG:AuraNumStacks(415320) < 3)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) < 2.0) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or ((NAG:AuraNumStacks(415358) >= 4)) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(458482)
    or NAG:Cast(415320)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(1219176)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409530)
        ]],

    -- Tracked IDs for optimization
    spells = {14271, 25295, 409530, 415320, 415343, 415358, 415423, 458482, 469145, 1219176, 1231604, 1232946, 1232979, 1232980, 1232981, 1232982},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Survival 1Target 3Min 2H BiS Melee Melee2H Phase8 ST rotation
local survival1Target3Min2HBiSMeleeMelee2HPhase8ST = {
    name = "Hunter Survival - 1Target_3Min_2H_BiS_Melee_Melee2H_Phase8_ST by APLParser",
    specIndex = 3,
    class = "HUNTER",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(469145)" },
        { time = -1.6, action = "NAG:Cast(20572)" },
        { time = -0.1, action = "NAG:Cast(25295)" }
    },
    rotationString = [[
(NAG:SpellInFlight() or NAG:DotIsActive(25295)) and NAG:MoveToRange(5)
    or ((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() > 10.0)) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraNumStacks(1232946) > 3) and NAG:Cast(1231604)
    or ((not NAG:DotIsActive(458482)) and (not NAG:DotIsActive(25295)) and (not NAG:DotIsActive(1232979)) and (not NAG:DotIsActive(1232980)) and (not NAG:DotIsActive(1232981)) and (not NAG:DotIsActive(1232982))) and NAG:Cast(458482)
    or (((not NAG:SpellIsReady(458482)) or NAG:DotIsActive(458482)) and (not NAG:SpellIsReady(415343)) and NAG:GCDIsReady() and NAG:SpellCanCast(415320)) and NAG:Cast(468388)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:CancelAura(415423)
    or ((NAG:AuraNumStacks(415320) < 3) and NAG:AuraIsActive(468388)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) <= 1.5) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or ((NAG:AuraNumStacks(415358) >= 4)) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(458482)
    or ((not NAG:AuraIsActive(415320))) and NAG:Cast(415320)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409530)
    or ((NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(14268)
    or NAG:Cast(10646)
        ]],

    -- Tracked IDs for optimization
    spells = {14268, 14271, 25295, 409530, 415320, 415343, 415358, 415423, 458482, 468388, 469145, 1231604, 1232946, 1232979, 1232980, 1232981, 1232982},
    items = {10646},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Marksmanship 1Target 3Min BiS Pet Phase8 Ranged ST rotation
local marksmanship1Target3MinBiSPetPhase8RangedST = {
    name = "Hunter Marksmanship - 1Target_3Min_BiS_Pet_Phase8_Ranged_ST by APLParser",
    specIndex = 2,
    class = "HUNTER",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(25296)" },
        { time = -2.0, action = "NAG:Cast(20572)" },
        { time = -0.45, action = "NAG:Cast(26297)" },
        { time = -0.45, action = "NAG:Cast(25295)" }
    },
    rotationString = [[
((NAG:CurrentManaPercent() < 0.8) and NAG:AuraIsKnown(1233451) and NAG:RuneIsEquipped(428717)) and NAG:Cast(13444)
    or ((NAG:CurrentManaPercent() < 0.45) and ((not NAG:AuraIsKnown(1233451)) or NAG:RuneIsEquipped(428726))) and NAG:Cast(13444)
    or ((NAG:CurrentManaPercent() < 0.8) and NAG:AuraIsKnown(1233451) and NAG:RuneIsEquipped(428717)) and NAG:Cast(12662)
    or ((NAG:CurrentManaPercent() < 0.6) and ((not NAG:AuraIsKnown(1233451)) or NAG:RuneIsEquipped(428726))) and NAG:Cast(12662)
    or (not NAG:DotIsActive(25295)) and NAG:Cast(25295)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:CurrentTime() > 6.0) and (NAG:AutoTimeToNext() > 1.0) and (NAG:GCDTimeToReady() > 1.0)) and NAG:Cast(233986)
    or ((NAG:SpellTimeToReady(409433) > 2.0) and (NAG:SpellTimeToReady(3045) < 0.5) and (NAG:SpellTimeToReady(409593) < 0.5)) and NAG:WaitUntil(NAG:SpellIsReady(3045))
    or ((NAG:RemainingTime() <= 30.0) or (((NAG:CurrentTime() + NAG:RemainingTime()) > 150.0) and ((NAG:CurrentTime() + NAG:RemainingTime()) < 210.0))) and NAG:AutocastOtherCooldowns()
    or NAG:AuraIsActive(3045) and NAG:AutocastOtherCooldowns()
    or ((NAG:CurrentManaPercent() >= 0.5) or NAG:SpellIsReady(3045)) and NAG:CancelAura(415423)
    or ((NAG:AuraNumStacks(428728) >= 5) and (NAG:AuraRemainingTime(428726) <= 1) and (NAG:CurrentTime() <= 10.0)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(428728) >= 5) and (NAG:AuraRemainingTime(428726) <= 1) and (NAG:CurrentTime() >= 10.0) and NAG:AuraIsKnown(428726)) and NAG:Cast(428726)
    or ((NAG:CurrentTime() >= 6.0) and (NAG:AuraRemainingTime(428726) <= 1) and (NAG:AuraNumStacks(428728) <= 3)) and NAG:Cast(428726)
    or ((NAG:CurrentTime() >= 2.5) and (NAG:CurrentTime() <= 4.0) and 0) and NAG:Sequence("Exotic", NAG:Cast(428726))
    or (NAG:SpellCanCast(409593) and (NAG:SpellTimeToReady(409433) >= NAG:SpellTimeToReady(3045)) and (NAG:RemainingTime() <= 75) and (NAG:AuraNumStacks(428728) == 4) and (NAG:AuraNumStacks(428726) ~= 5) and NAG:AuraIsKnown(428726) and NAG:SpellCanCast(3045)) and NAG:WaitUntil(((NAG:AuraNumStacks(428728) == 5) or NAG:SpellIsReady(409433)))
    or (NAG:SpellCanCast(409593) and ((not NAG:AuraIsKnown(428726)) or NAG:AuraIsActive(428726) or (NAG:AuraNumStacks(428728) >= 4) or (NAG:CurrentTime() >= 6.0)) and (not NAG:SpellIsReady(409433)) and ((not NAG:AuraIsKnown(1233451)) or (NAG:CurrentTime() >= 6.0))) and NAG:Cast(3045)
    or ((NAG:DotRemainingTime(25295) < 6.0) and ((not NAG:AuraIsKnown(1233451)) or (NAG:SpellTimeToReady(25294) < 4.0))) and NAG:Cast(409433)
    or ((NAG:AuraNumStacks(1233451) == 4) and NAG:AuraIsKnown(1233451)) and NAG:Cast(25294)
    or NAG:Sequence("Opener", NAG:Cast(409433))
    or (NAG:AuraIsKnown(428726) and ((not NAG:AuraIsActive(428726)) or NAG:SpellCanCast(3045))) and NAG:Cast(409433)
    or NAG:AuraIsActive(3045) and NAG:Cast(409593)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:IsExecutePhase(20) and NAG:SpellIsReady(409593) and ((NAG:SpellTimeToReady(25294) > 0.5) or (not NAG:AuraIsKnown(1233451)))) and NAG:Cast(409433)
    or (NAG:SpellIsReady(409433) and NAG:SpellIsReady(409593) and (NAG:SpellTimeToReady(25294) > 3.0) and (NAG:SpellTimeToReady(25294) < 5.0) and NAG:AuraIsKnown(1233451) and (not NAG:SpellIsReady(3045))) and NAG:Cast(409593)
    or ((NAG:AuraNumStacks(1233451) < 3) or (NAG:SpellTimeToReady(25294) > 0.5) or (not NAG:AuraIsKnown(1233451))) and NAG:Cast(409433)
    or (((NAG:AuraNumStacks(1233451) < 4) and NAG:AuraIsKnown(1233451)) or ((NAG:SpellTimeToReady(25294) > 0.5) and NAG:AuraIsKnown(1233451))) and NAG:Cast(409593)
    or (not NAG:AuraIsKnown(1233451)) and NAG:Cast(409593)
    or (NAG:AuraIsKnown(1233451) or (not NAG:RuneIsEquipped(428717))) and NAG:Cast(25294)
    or (((NAG:SpellTimeToReady(25294) > 2.0) or (not NAG:AuraIsKnown(1233451))) and (not NAG:RuneIsEquipped(428717))) and NAG:Cast(14287)
    or (((NAG:SpellTimeToReady(25294) > 1.5) or (not NAG:AuraIsKnown(1233451))) and NAG:RuneIsEquipped(428717)) and NAG:Cast(409535)
    or ((NAG:CurrentManaPercent() < 0.4) and (NAG:RemainingTime() >= 15.0) and NAG:AuraIsKnown(1233451)) and NAG:Cast(415423)
    or NAG:Cast(25294)
    or (not NAG:AuraIsActive(25296)) and NAG:Cast(25296)
    or False and NAG:Cast(20572)
        ]],

    -- Tracked IDs for optimization
    spells = {3045, 14287, 20572, 25294, 25295, 25296, 409433, 409535, 409593, 415423, 428726, 428728, 1233451},
    items = {12662, 13444, 233986, 241241},
    auras = {},
    runes = {428717, 428726},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Survival 1Target 3Min BiS DW Melee MeleeDW Pet Phase8 ST rotation
local survival1Target3MinBiSDWMeleeMeleeDWPetPhase8ST = {
    name = "Hunter Survival - 1Target_3Min_BiS_DW_Melee_MeleeDW_Pet_Phase8_ST by APLParser",
    specIndex = 3,
    class = "HUNTER",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(469145)" },
        { time = -1.6, action = "NAG:Cast(20572)" },
        { time = -0.1, action = "NAG:Cast(25295)" },
        { time = -0.1, action = "NAG:Cast(19574)" }
    },
    rotationString = [[
(NAG:DotIsActive(25295) or NAG:SpellInFlight()) and NAG:MoveToRange(5)
    or (NAG:AuraRemainingTime(241241) <= 1.5) and NAG:Cast(241241)
    or ((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() >= 10)) and NAG:AutocastOtherCooldowns()
    or ((NAG:AuraNumStacks(415320) < 3) and (not NAG:AuraIsActive(415358))) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) < 2.0) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or (NAG:AuraNumStacks(1232946) == 4) and NAG:Cast(1231604)
    or (NAG:AuraNumStacks(415358) >= 5) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(1219176)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409530)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(14268)
        ]],

    -- Tracked IDs for optimization
    spells = {14268, 14271, 25295, 409530, 415320, 415343, 415358, 415423, 469145, 1219176, 1231604, 1232946},
    items = {241241},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Survival 1Target 3Min BiS DW Melee MeleeDW Phase8 ST rotation
local survival1Target3MinBiSDWMeleeMeleeDWPhase8ST = {
    name = "Hunter Survival - 1Target_3Min_BiS_DW_Melee_MeleeDW_Phase8_ST by APLParser",
    specIndex = 3,
    class = "HUNTER",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(469145)" },
        { time = -1.6, action = "NAG:Cast(20572)" },
        { time = -0.1, action = "NAG:Cast(25295)" }
    },
    rotationString = [[
(NAG:DotIsActive(25295) or NAG:SpellInFlight()) and NAG:MoveToRange(5)
    or NAG:AutocastOtherCooldowns()
    or (NAG:AuraNumStacks(1232946) == 4) and NAG:Cast(1231604)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:CancelAura(415423)
    or ((NAG:AuraNumStacks(415358) >= 5)) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(409593)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5) and (NAG:SpellTimeToReady(409593) >= 1.5)) and NAG:Cast(409530)
    or ((NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5) and (NAG:SpellTimeToReady(409593) >= 1.5)) and NAG:Cast(14268)
        ]],

    -- Tracked IDs for optimization
    spells = {14268, 14271, 25295, 409530, 409593, 415343, 415358, 415423, 469145, 1231604, 1232946},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Marksmanship 2Target 1Min BiS Cleave Phase8 Ranged rotation
local marksmanship2Target1MinBiSCleavePhase8Ranged = {
    name = "Hunter Marksmanship - 2Target_1Min_BiS_Cleave_Phase8_Ranged by APLParser",
    specIndex = 2,
    class = "HUNTER",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(25296)" },
        { time = -2.0, action = "NAG:Cast(20572)" },
        { time = -0.45, action = "NAG:Cast(26297)" },
        { time = -0.45, action = "NAG:Cast(25295)" }
    },
    rotationString = [[
(NAG:CurrentManaPercent() < 0.8) and NAG:Cast(12662)
    or (NAG:CurrentManaPercent() < 0.8) and NAG:Cast(13444)
    or (not NAG:DotIsActive(25295)) and NAG:Cast(25295)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:AutoTimeToNext() > 1.5) and (NAG:GCDTimeToReady() > 1.0) and (NAG:RemainingTime() < 30.0)) and NAG:Cast(233986)
    or ((NAG:AuraNumStacks(1231591) < 5) and (NAG:AuraNumStacks(428728) == 5)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(1231591) == 5) and (NAG:AuraNumStacks(428728) == 5) and (NAG:AuraRemainingTime(1231591) < 1.0)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(1231591) == 5) and NAG:GCDIsReady()) and NAG:Cast(26297)
    or (NAG:GCDIsReady()) and NAG:AutocastOtherCooldowns()
    or ((not NAG:AuraIsActive(415413)) and (NAG:SpellTimeToReady(25294) > 5) and NAG:AuraIsActive(409535)) and NAG:Cast(409530)
    or ((not NAG:AuraIsActive(415413)) and (NAG:SpellTimeToReady(25294) > 5)) and NAG:Cast(409535)
    or ((not NAG:AuraIsActive(415413)) and (NAG:SpellTimeToReady(25294) > 5)) and NAG:Cast(409510)
    or NAG:Cast(409433)
    or NAG:Cast(25294)
    or NAG:Cast(20904)
        ]],

    -- Tracked IDs for optimization
    spells = {20904, 25294, 25295, 26297, 409433, 409510, 409530, 409535, 415413, 428726, 428728, 1231591},
    items = {12662, 13444, 233986, 241241},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Survival 2H 2Target 1Min BiS Cleave Melee Melee2H Phase8 WithCoR rotation
local survival2H2Target1MinBiSCleaveMeleeMelee2HPhase8WithCoR = {
    name = "Hunter Survival - 2H_2Target_1Min_BiS_Cleave_Melee_Melee2H_Phase8_WithCoR by APLParser",
    specIndex = 3,
    class = "HUNTER",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(469145)" },
        { time = -1.6, action = "NAG:Cast(20572)" },
        { time = -0.1, action = "NAG:Cast(25295)" }
    },
    rotationString = [[
(NAG:SpellInFlight() or NAG:DotIsActive(25295)) and NAG:MoveToRange(5)
    or ((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() > 10.0)) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraNumStacks(1232946) > 3) and NAG:Cast(1231604)
    or ((not NAG:DotIsActive(458482)) and (not NAG:DotIsActive(25295)) and (not NAG:DotIsActive(1232979)) and (not NAG:DotIsActive(1232980)) and (not NAG:DotIsActive(1232981)) and (not NAG:DotIsActive(1232982))) and NAG:Cast(458482)
    or (((not NAG:SpellIsReady(458482)) or NAG:DotIsActive(458482)) and (not NAG:SpellIsReady(415343)) and NAG:GCDIsReady() and NAG:SpellCanCast(415320)) and NAG:Cast(468388)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:CancelAura(415423)
    or ((NAG:AuraNumStacks(415320) < 3) and NAG:AuraIsActive(468388)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) <= 1.5) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or ((NAG:AuraNumStacks(415358) >= 4)) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(458482)
    or ((not NAG:AuraIsActive(415320))) and NAG:Cast(415320)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409535)
    or ((NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(14268)
    or NAG:Cast(233985)
        ]],

    -- Tracked IDs for optimization
    spells = {14268, 14271, 25295, 409535, 415320, 415343, 415358, 415423, 458482, 468388, 469145, 1231604, 1232946, 1232979, 1232980, 1232981, 1232982},
    items = {233985},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Survival 2Target 1Min BiS Cleave Melee Phase8 WithCoR rotation
local survival2Target1MinBiSCleaveMeleePhase8WithCoR = {
    name = "Hunter Survival - 2Target_1Min_BiS_Cleave_Melee_Phase8_WithCoR by APLParser",
    specIndex = 3,
    class = "HUNTER",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(469145)" },
        { time = -1.6, action = "NAG:Cast(20572)" },
        { time = -0.1, action = "NAG:Cast(25295)" },
        { time = -0.1, action = "NAG:Cast(19574)" }
    },
    rotationString = [[
(NAG:DotIsActive(25295) or NAG:SpellInFlight()) and NAG:MoveToRange(5)
    or ((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() >= 10)) and NAG:AutocastOtherCooldowns()
    or ((NAG:AuraNumStacks(415320) < 3)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) < 2.0) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or (NAG:AuraNumStacks(1232946) == 4) and NAG:Cast(1231604)
    or (NAG:AuraNumStacks(415358) >= 4) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(1219176)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409535)
        ]],

    -- Tracked IDs for optimization
    spells = {14271, 25295, 409535, 415320, 415343, 415358, 415423, 469145, 1219176, 1231604, 1232946},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Marksmanship 3Target 1Min BiS Cleave Phase8 Ranged rotation
local marksmanship3Target1MinBiSCleavePhase8Ranged = {
    name = "Hunter Marksmanship - 3Target_1Min_BiS_Cleave_Phase8_Ranged by APLParser",
    specIndex = 2,
    class = "HUNTER",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(25296)" },
        { time = -2.0, action = "NAG:Cast(20572)" },
        { time = -0.45, action = "NAG:Cast(26297)" },
        { time = -0.45, action = "NAG:Cast(25294)" }
    },
    rotationString = [[
(NAG:CurrentManaPercent() < 0.8) and NAG:Cast(12662)
    or (NAG:CurrentManaPercent() < 0.8) and NAG:Cast(13444)
    or (not NAG:DotIsActive(25295)) and NAG:Cast(25295)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:AutoTimeToNext() > 1.5) and (NAG:GCDTimeToReady() > 1.0) and (NAG:RemainingTime() < 30.0)) and NAG:Cast(233986)
    or ((NAG:AuraNumStacks(1231591) < 5) and (NAG:AuraNumStacks(428728) == 5)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(1231591) == 5) and (NAG:AuraNumStacks(428728) == 5) and (NAG:AuraRemainingTime(1231591) < 1.0)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(1231591) == 5) and NAG:GCDIsReady()) and NAG:Cast(26297)
    or (NAG:GCDIsReady()) and NAG:AutocastOtherCooldowns()
    or ((not NAG:AuraIsActive(415413))) and NAG:Cast(409535)
    or ((not NAG:AuraIsActive(415413)) and (not NAG:SpellIsReady(25294))) and NAG:Cast(409510)
    or NAG:Cast(409433)
    or NAG:Cast(25294)
        ]],

    -- Tracked IDs for optimization
    spells = {25294, 25295, 26297, 409433, 409510, 409535, 415413, 428726, 428728, 1231591},
    items = {12662, 13444, 233986, 241241},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Survival 2H 3Target 1Min BiS Cleave Melee Melee2H Phase8 WithCoR rotation
local survival2H3Target1MinBiSCleaveMeleeMelee2HPhase8WithCoR = {
    name = "Hunter Survival - 2H_3Target_1Min_BiS_Cleave_Melee_Melee2H_Phase8_WithCoR by APLParser",
    specIndex = 3,
    class = "HUNTER",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(469145)" },
        { time = -1.6, action = "NAG:Cast(20572)" },
        { time = -0.1, action = "NAG:Cast(25295)" }
    },
    rotationString = [[
(NAG:SpellInFlight() or NAG:DotIsActive(25295)) and NAG:MoveToRange(5)
    or (NAG:AuraNumStacks(1232946) > 3) and NAG:Cast(1231604)
    or ((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() >= 10)) and NAG:AutocastOtherCooldowns()
    or ((not NAG:DotIsActive(25295)) and (not NAG:DotIsActive(1232979)) and (not NAG:DotIsActive(1232980)) and (not NAG:DotIsActive(1232981)) and (not NAG:DotIsActive(1232982)) and (not NAG:DotIsActive(458482))) and NAG:Cast(458482)
    or ((not NAG:AuraIsActive(415358)) and (NAG:AuraNumStacks(415320) < 3)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) < 2.0) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or ((NAG:AuraNumStacks(415358) >= 4)) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(458482)
    or NAG:Cast(415320)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(1219176)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409535)
        ]],

    -- Tracked IDs for optimization
    spells = {14271, 25295, 409535, 415320, 415343, 415358, 415423, 458482, 469145, 1219176, 1231604, 1232946, 1232979, 1232980, 1232981, 1232982},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Survival 3Target 1Min BiS Cleave Melee Phase8 WithCoR rotation
local survival3Target1MinBiSCleaveMeleePhase8WithCoR = {
    name = "Hunter Survival - 3Target_1Min_BiS_Cleave_Melee_Phase8_WithCoR by APLParser",
    specIndex = 3,
    class = "HUNTER",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(469145)" },
        { time = -1.6, action = "NAG:Cast(20572)" },
        { time = -0.1, action = "NAG:Cast(25295)" },
        { time = -0.1, action = "NAG:Cast(19574)" }
    },
    rotationString = [[
(NAG:DotIsActive(25295) or NAG:SpellInFlight()) and NAG:MoveToRange(5)
    or ((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() >= 10)) and NAG:AutocastOtherCooldowns()
    or ((NAG:AuraNumStacks(415320) < 3)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) < 2.0) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or (NAG:AuraNumStacks(1232946) == 4) and NAG:Cast(1231604)
    or (NAG:AuraNumStacks(415358) >= 4) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(1219176)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409535)
        ]],

    -- Tracked IDs for optimization
    spells = {14271, 25295, 409535, 415320, 415343, 415358, 415423, 469145, 1219176, 1231604, 1232946},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Marksmanship 4Target 1Min BiS Cleave Phase8 Ranged rotation
local marksmanship4Target1MinBiSCleavePhase8Ranged = {
    name = "Hunter Marksmanship - 4Target_1Min_BiS_Cleave_Phase8_Ranged by APLParser",
    specIndex = 2,
    class = "HUNTER",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(25296)" },
        { time = -2.0, action = "NAG:Cast(20572)" },
        { time = -0.45, action = "NAG:Cast(26297)" },
        { time = -0.45, action = "NAG:Cast(25294)" }
    },
    rotationString = [[
(NAG:CurrentManaPercent() < 0.8) and NAG:Cast(12662)
    or (NAG:CurrentManaPercent() < 0.8) and NAG:Cast(13444)
    or (not NAG:DotIsActive(25295)) and NAG:Cast(25295)
    or (NAG:AuraRemainingTime(241241) < 1.5) and NAG:Cast(241241)
    or ((NAG:AutoTimeToNext() > 1.5) and (NAG:GCDTimeToReady() > 1.0) and (NAG:RemainingTime() < 30.0)) and NAG:Cast(233986)
    or ((NAG:AuraNumStacks(1231591) < 5) and (NAG:AuraNumStacks(428728) == 5)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(1231591) == 5) and (NAG:AuraNumStacks(428728) == 5) and (NAG:AuraRemainingTime(1231591) < 1.0)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(1231591) == 5) and NAG:GCDIsReady()) and NAG:Cast(26297)
    or (NAG:GCDIsReady()) and NAG:AutocastOtherCooldowns()
    or ((not NAG:AuraIsActive(415413))) and NAG:Cast(409535)
    or ((not NAG:AuraIsActive(415413)) and (not NAG:SpellIsReady(25294))) and NAG:Cast(409510)
    or NAG:Cast(409433)
    or NAG:Cast(25294)
        ]],

    -- Tracked IDs for optimization
    spells = {25294, 25295, 26297, 409433, 409510, 409535, 415413, 428726, 428728, 1231591},
    items = {12662, 13444, 233986, 241241},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Unknown 4Target 1Min BeastMastery BiS Cleave Pet Phase8 Ranged RangedBM rotation
local unknown4Target1MinBeastMasteryBiSCleavePetPhase8RangedRangedBM = {
    name = "Hunter Unknown - 4Target_1Min_BeastMastery_BiS_Cleave_Pet_Phase8_Ranged_RangedBM by APLParser",
    specIndex = 4,
    class = "HUNTER",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(25296)" },
        { time = -0.45, action = "NAG:Cast(26297)" },
        { time = -0.45, action = "NAG:Cast(25295)" }
    },
    rotationString = [[
((NAG:CurrentTime() > 20.0) and (NAG:AutoTimeToNext() > 1.0) and (NAG:GCDTimeToReady() > 1.0)) and NAG:Cast(233986)
    or (not NAG:DotIsActive(25295)) and NAG:Cast(25295)
    or ((NAG:CurrentManaPercent() >= 0.5)) and NAG:CancelAura(415423)
    or (NAG:CurrentManaPercent() <= 0.55) and NAG:Cast(13444)
    or (NAG:CurrentManaPercent() <= 0.65) and NAG:Cast(12662)
    or ((NAG:AuraNumStacks(1231591) < 5) and (NAG:AuraNumStacks(428728) == 5)) and NAG:Cast(428726)
    or ((NAG:AuraNumStacks(1231591) == 5) and (NAG:AuraNumStacks(428728) == 5) and (NAG:AuraRemainingTime(1231591) < 1.0)) and NAG:Cast(428726)
    or (NAG:SpellCanCast(409593) and NAG:GCDIsReady()) and NAG:Cast(3045)
    or NAG:Cast(241037)
    or (NAG:AuraNumStacks(1231591) == 5) and NAG:Cast(26297)
    or NAG:AuraIsActive(3045) and NAG:AutocastOtherCooldowns()
    or (NAG:AuraIsActive(3045) and (NAG:AuraNumStacks(1233451) == 4)) and NAG:Cast(25294)
    or ((NAG:DotRemainingTime(25295) <= 6.0) and NAG:AuraIsActive(3045)) and NAG:Cast(409433)
    or NAG:AuraIsActive(3045) and NAG:Cast(409593)
    or (NAG:IsExecutePhase(20) and (NAG:AuraNumStacks(1233451) == 4)) and NAG:Cast(25294)
    or NAG:IsExecutePhase(20) and NAG:Cast(409433)
    or NAG:IsExecutePhase(20) and NAG:Cast(409593)
    or NAG:Cast(409593)
    or NAG:Cast(25294)
    or NAG:Cast(409433)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or ((not NAG:AuraIsActive(415423)) and (not NAG:AuraIsActive(25296)) and (NAG:SpellTimeToReady(409433) > 1.45)) and NAG:Cast(25296)
    or false and NAG:Cast(20572)
        ]],

    -- Tracked IDs for optimization
    spells = {3045, 20572, 25294, 25295, 25296, 26297, 409433, 409593, 415423, 428726, 428728, 1231591, 1233451},
    items = {12662, 13444, 233986, 241037},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Survival 2H 4Target 1Min BiS Cleave Melee Melee2H Phase8 WithCoR rotation
local survival2H4Target1MinBiSCleaveMeleeMelee2HPhase8WithCoR = {
    name = "Hunter Survival - 2H_4Target_1Min_BiS_Cleave_Melee_Melee2H_Phase8_WithCoR by APLParser",
    specIndex = 3,
    class = "HUNTER",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(469145)" },
        { time = -1.6, action = "NAG:Cast(20572)" },
        { time = -0.1, action = "NAG:Cast(25295)" }
    },
    rotationString = [[
(NAG:SpellInFlight() or NAG:DotIsActive(25295)) and NAG:MoveToRange(5)
    or (NAG:AuraNumStacks(1232946) > 3) and NAG:Cast(1231604)
    or ((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() >= 10)) and NAG:AutocastOtherCooldowns()
    or ((not NAG:DotIsActive(25295)) and (not NAG:DotIsActive(1232979)) and (not NAG:DotIsActive(1232980)) and (not NAG:DotIsActive(1232981)) and (not NAG:DotIsActive(1232982)) and (not NAG:DotIsActive(458482))) and NAG:Cast(458482)
    or ((not NAG:AuraIsActive(415358)) and (NAG:AuraNumStacks(415320) < 3)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) < 2.0) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or ((NAG:AuraNumStacks(415358) >= 4)) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(458482)
    or NAG:Cast(415320)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(1219176)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(458482) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409535)
        ]],

    -- Tracked IDs for optimization
    spells = {14271, 25295, 409535, 415320, 415343, 415358, 415423, 458482, 469145, 1219176, 1231604, 1232946, 1232979, 1232980, 1232981, 1232982},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Survival 4Target 1Min BiS Cleave Melee Phase8 WithCoR rotation
local survival4Target1MinBiSCleaveMeleePhase8WithCoR = {
    name = "Hunter Survival - 4Target_1Min_BiS_Cleave_Melee_Phase8_WithCoR by APLParser",
    specIndex = 3,
    class = "HUNTER",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(469145)" },
        { time = -1.6, action = "NAG:Cast(20572)" },
        { time = -0.1, action = "NAG:Cast(25295)" },
        { time = -0.1, action = "NAG:Cast(19574)" }
    },
    rotationString = [[
(NAG:DotIsActive(25295) or NAG:SpellInFlight()) and NAG:MoveToRange(5)
    or ((NAG:AuraNumStacks(415320) >= 2) or (NAG:CurrentTime() >= 10)) and NAG:AutocastOtherCooldowns()
    or ((NAG:AuraNumStacks(415320) < 3)) and NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) < 2.0) and (NAG:AuraNumStacks(415320) >= 1)) and NAG:Cast(415320)
    or (NAG:AuraNumStacks(1232946) == 4) and NAG:Cast(1231604)
    or (NAG:AuraNumStacks(415358) >= 4) and NAG:Cast(14271)
    or NAG:Cast(415343)
    or NAG:Cast(14271)
    or NAG:Cast(415320)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(1219176)
    or ((NAG:CurrentManaPercent() < 0.05) and (NAG:RemainingTime() >= 4.0)) and NAG:Cast(415423)
    or (NAG:CurrentManaPercent() >= 0.5) and NAG:Cast(469145)
    or ((NAG:AuraRemainingTime(415320) > 1.5) and (NAG:SpellTimeToReady(415343) >= 1.5) and (NAG:SpellTimeToReady(14271) >= 1.5)) and NAG:Cast(409535)
        ]],

    -- Tracked IDs for optimization
    spells = {14271, 25295, 409535, 415320, 415343, 415358, 415423, 469145, 1219176, 1231604, 1232946},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

--- @class HUNTER : ClassBase
local HUNTER = NAG:CreateClassModule("HUNTER", defaults)

--- Setup class defaults with all rotations
function HUNTER:SetupClassDefaults()
    -- Add all rotation definitions to defaults
    ns.AddRotationToDefaults(self.defaults, 3, survival2H3MinMeleeMelee2HPetPhase8PreRaid)  -- survival2H3MinMeleeMelee2HPetPhase8PreRaid)
    ns.AddRotationToDefaults(self.defaults, 3, survival3MinDWMeleeMeleeDWPetPhase8PreRaid)  -- survival3MinDWMeleeMeleeDWPetPhase8PreRaid)
    ns.AddRotationToDefaults(self.defaults, 2, marksmanship3MinPhase8PreRaidRanged)  -- marksmanship3MinPhase8PreRaidRanged)
    ns.AddRotationToDefaults(self.defaults, 3, survival2H5MinMeleeMelee2HPetPhase8PreRaid)  -- survival2H5MinMeleeMelee2HPetPhase8PreRaid)
    ns.AddRotationToDefaults(self.defaults, 3, survival5MinDWMeleeMeleeDWPetPhase8PreRaid)  -- survival5MinDWMeleeMeleeDWPetPhase8PreRaid)
    ns.AddRotationToDefaults(self.defaults, 2, marksmanship5MinPhase8PreRaidRanged)  -- marksmanship5MinPhase8PreRaidRanged)
    ns.AddRotationToDefaults(self.defaults, 4, unknown5MinPhase8PreRaidRanged)  -- unknown5MinPhase8PreRaidRanged)
    ns.AddRotationToDefaults(self.defaults, 4, unknown1Target1MinBiSPhase8RangedST)  -- unknown1Target1MinBiSPhase8RangedST)
    ns.AddRotationToDefaults(self.defaults, 3, survival1Target1Min2HBiSMeleeMelee2HPhase8ST)  -- survival1Target1Min2HBiSMeleeMelee2HPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 3, survival1Target1Min2HBiSMeleeMelee2HPetPhase8ST)  -- survival1Target1Min2HBiSMeleeMelee2HPetPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 2, marksmanship1Target1MinBiSPetPhase8RangedST)  -- marksmanship1Target1MinBiSPetPhase8RangedST)
    ns.AddRotationToDefaults(self.defaults, 3, survival1Target1MinBiSDWMeleeMeleeDWPetPhase8ST)  -- survival1Target1MinBiSDWMeleeMeleeDWPetPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 3, survival1Target1MinBiSDWMeleeMeleeDWPhase8ST)  -- survival1Target1MinBiSDWMeleeMeleeDWPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 2, marksmanship1Target1MinBiSPhase8RangedST)  -- marksmanship1Target1MinBiSPhase8RangedST)
    ns.AddRotationToDefaults(self.defaults, 4, unknown1Target2MinBiSPhase8RangedST)  -- unknown1Target2MinBiSPhase8RangedST)
    ns.AddRotationToDefaults(self.defaults, 3, survival1Target2Min2HBiSMeleeMelee2HPetPhase8ST)  -- survival1Target2Min2HBiSMeleeMelee2HPetPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 2, marksmanship1Target2MinBiSPetPhase8RangedST)  -- marksmanship1Target2MinBiSPetPhase8RangedST)
    ns.AddRotationToDefaults(self.defaults, 3, survival1Target2Min2HBiSMeleeMelee2HPhase8ST)  -- survival1Target2Min2HBiSMeleeMelee2HPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 3, survival1Target2MinBiSDWMeleeMeleeDWPhase8ST)  -- survival1Target2MinBiSDWMeleeMeleeDWPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 3, survival1Target2MinBiSDWMeleeMeleeDWPetPhase8ST)  -- survival1Target2MinBiSDWMeleeMeleeDWPetPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 2, marksmanship1Target2MinBiSPhase8RangedST)  -- marksmanship1Target2MinBiSPhase8RangedST)
    ns.AddRotationToDefaults(self.defaults, 4, unknown1Target3MinBiSPhase8RangedST)  -- unknown1Target3MinBiSPhase8RangedST)

    -- Add newly converted rotations
    ns.AddRotationToDefaults(self.defaults, 3, survival1Target3Min2HBiSMeleeMelee2HPetPhase8ST)  -- survival1Target3Min2HBiSMeleeMelee2HPetPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 3, survival1Target3Min2HBiSMeleeMelee2HPhase8ST)  -- survival1Target3Min2HBiSMeleeMelee2HPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 2, marksmanship1Target3MinBiSPetPhase8RangedST)  -- marksmanship1Target3MinBiSPetPhase8RangedST)
    ns.AddRotationToDefaults(self.defaults, 3, survival1Target3MinBiSDWMeleeMeleeDWPetPhase8ST)  -- survival1Target3MinBiSDWMeleeMeleeDWPetPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 3, survival1Target3MinBiSDWMeleeMeleeDWPhase8ST)  -- survival1Target3MinBiSDWMeleeMeleeDWPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 2, marksmanship2Target1MinBiSCleavePhase8Ranged)  -- marksmanship2Target1MinBiSCleavePhase8Ranged)
    ns.AddRotationToDefaults(self.defaults, 3, survival2H2Target1MinBiSCleaveMeleeMelee2HPhase8WithCoR)  -- survival2H2Target1MinBiSCleaveMeleeMelee2HPhase8WithCoR)
    ns.AddRotationToDefaults(self.defaults, 3, survival2Target1MinBiSCleaveMeleePhase8WithCoR)  -- survival2Target1MinBiSCleaveMeleePhase8WithCoR)
    ns.AddRotationToDefaults(self.defaults, 2, marksmanship3Target1MinBiSCleavePhase8Ranged)  -- marksmanship3Target1MinBiSCleavePhase8Ranged)
    ns.AddRotationToDefaults(self.defaults, 3, survival2H3Target1MinBiSCleaveMeleeMelee2HPhase8WithCoR)  -- survival2H3Target1MinBiSCleaveMeleeMelee2HPhase8WithCoR)
    ns.AddRotationToDefaults(self.defaults, 3, survival3Target1MinBiSCleaveMeleePhase8WithCoR)  -- survival3Target1MinBiSCleaveMeleePhase8WithCoR)
    ns.AddRotationToDefaults(self.defaults, 2, marksmanship4Target1MinBiSCleavePhase8Ranged)  -- marksmanship4Target1MinBiSCleavePhase8Ranged)
    ns.AddRotationToDefaults(self.defaults, 4, unknown4Target1MinBeastMasteryBiSCleavePetPhase8RangedRangedBM)  -- unknown4Target1MinBeastMasteryBiSCleavePetPhase8RangedRangedBM)
    ns.AddRotationToDefaults(self.defaults, 3, survival2H4Target1MinBiSCleaveMeleeMelee2HPhase8WithCoR)  -- survival2H4Target1MinBiSCleaveMeleeMelee2HPhase8WithCoR)
    ns.AddRotationToDefaults(self.defaults, 3, survival4Target1MinBiSCleaveMeleePhase8WithCoR)  -- survival4Target1MinBiSCleaveMeleePhase8WithCoR)
end

if not HUNTER then return end
NAG.Class = HUNTER
