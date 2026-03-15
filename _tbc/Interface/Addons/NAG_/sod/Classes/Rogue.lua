local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
if not Version:IsSoD() then return end

if UnitClassBase('player') ~= "ROGUE" then return end

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
        id = "expose_armor",
        name = "Expose Armor",
        description = "Apply armor reduction debuff on targets (conflicts with Warrior Sunder Armor)",
        spellIds = {8647, 8649, 8650, 11197, 11198}, -- All ranks
        category = "debuff",
    },
}

-- Assassination 3Min Phase8 PreRaid SaberSlash rotation
local assassination3MinPhase8PreRaidSaberSlash = {
    name = "Rogue Assassination - 3Min_Phase8_PreRaid_SaberSlash by APLParser",
    specIndex = 1,
    class = "ROGUE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -2.0, action = "NAG:Cast(6774)" },
        { time = -1.0, action = "NAG:Cast(13877)" }
    },
    rotationString = [[
((NAG:CurrentEnergy() <= 10) or ((NAG:RemainingTime() <= 15) and (NAG:CurrentEnergy() <= 40))) and NAG:Cast(7676)
    or NAG:AutocastOtherCooldowns()
    or (((not NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(1787))) or (NAG:RuneIsEquipped(432276) and (not NAG:AuraIsActive(1787)) and NAG:AuraIsActive(432276, "target"))) and NAG:Cast(233985)
    or (NAG:AuraIsKnown(1226843) and (not NAG:AuraIsActive(424785, "target")) and (not NAG:AuraIsActive(11275, "target")) and (not NAG:AuraIsActive(436611, "target")) and (NAG:CurrentComboPoints() <= 4)) and NAG:Cast(425012)
    or (NAG:AuraIsKnown(1226843) and (not NAG:AuraIsActive(424785, "target")) and (not NAG:AuraIsActive(11275, "target")) and (not NAG:AuraIsActive(436611, "target")) and (NAG:CurrentComboPoints() >= 1)) and NAG:Cast(412096)
    or ((NAG:CurrentComboPoints() <= 4) and ((NAG:AuraNumStacks(424785, "target") < 3) or (NAG:AuraRemainingTime(424785, "target") < 2)) and (NAG:AuraRemainingTime(424785, "target") < (NAG:RemainingTime() + 2))) and NAG:Cast(424785)
    or (((not NAG:RuneIsEquipped(432276)) and NAG:AuraIsActive(6774) and NAG:AuraIsActive(399963)) or (NAG:RuneIsEquipped(432276) and NAG:AuraIsActive(432276, "target") and NAG:AuraIsActive(6774) and NAG:AuraIsActive(399963))) and NAG:Cast(13877)
    or ((NAG:AuraNumStacks(1214170, "target") >= 4) and (NAG:CurrentComboPoints() < 5) and (NAG:CurrentEnergy() <= 75)) and NAG:Cast(425012)
    or (((not NAG:RuneIsEquipped(432271)) and (NAG:AuraRemainingTime(6774) <= 1) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 19)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 19) and (NAG:RemainingTime() >= 13)))) or (NAG:RuneIsEquipped(432271) and (not NAG:AuraIsActive(6774)) and (NAG:CurrentComboPoints() >= 1) and (NAG:RemainingTime() >= 10))) and NAG:Cast(6774)
    or ((NAG:AuraIsKnown(1226843) and NAG:AuraIsKnown(1232181) and (not NAG:RuneIsEquipped(432271)) and (not NAG:AuraIsActive(436611, "target")) and (NAG:CurrentComboPoints() >= 1) and (NAG:RemainingTime() >= 5)) or (NAG:AuraIsKnown(1226843) and (not NAG:RuneIsEquipped(432271)) and (not NAG:AuraIsActive(436611, "target")) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 11)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 11) and (NAG:RemainingTime() >= 7))))) and NAG:Cast(412096)
    or ((not NAG:AuraIsActive(425096)) and (NAG:CurrentEnergy() >= 35) and (NAG:CurrentComboPoints() >= 5) and NAG:GCDIsReady() and (NAG:AuraNumStacks(1214170, "target") >= 5)) and NAG:StrictSequence("foo", NAG:Cast(14177), NAG:Cast(1856), NAG:Cast(399963))
    or ((NAG:CurrentComboPoints() >= 4) or ((NAG:CurrentComboPoints() >= 3) and (NAG:RemainingTime() <= 4))) and NAG:Cast(399963)
    or ((NAG:AuraIsKnown(1226843) and (NAG:CurrentComboPoints() <= 4) and (NAG:CurrentEnergy() >= 75) and (NAG:AuraRemainingTime(424785, "target") >= 8) and (NAG:AuraNumStacks(424785, "target") >= 3)) or (NAG:AuraIsKnown(1226843) and (NAG:CurrentComboPoints() <= 2) and (NAG:AuraRemainingTime(424785, "target") >= 8) and (NAG:AuraNumStacks(424785, "target") >= 3)) or (NAG:AuraIsKnown(1226843) and (NAG:CurrentComboPoints() <= 2) and (NAG:RemainingTime() <= 4) and (NAG:AuraNumStacks(424785, "target") >= 3))) and NAG:Cast(11294)
    or ((NAG:CurrentComboPoints() <= 2) or ((NAG:CurrentComboPoints() <= 4) and (NAG:CurrentEnergy() >= 75))) and NAG:Cast(424785)
        ]],

    -- Tracked IDs for optimization
    spells = {1787, 1856, 6774, 11275, 11294, 13877, 14177, 399963, 412096, 424785, 425012, 425096, 432276, 436611, 1214170, 1226843, 1232181},
    items = {7676, 233985},
    auras = {},
    runes = {432271, 432276},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Assassination 3Min Mutilate Phase8 PreRaid rotation
local assassination3MinMutilatePhase8PreRaid = {
    name = "Rogue Assassination - 3Min_Mutilate_Phase8_PreRaid by APLParser",
    specIndex = 1,
    class = "ROGUE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -2.0, action = "NAG:Cast(6774)" },
        { time = -1.0, action = "NAG:Cast(13877)" }
    },
    rotationString = [[
((NAG:CurrentEnergy() <= 10) or ((NAG:RemainingTime() <= 20) and (NAG:CurrentEnergy() <= 40))) and NAG:Cast(7676)
    or NAG:AutocastOtherCooldowns()
    or (((not NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(1787))) or (NAG:RuneIsEquipped(432276) and NAG:AuraIsActive(432276, "target") and (not NAG:AuraIsActive(1787)))) and NAG:Cast(233985)
    or (((not NAG:RuneIsEquipped(432276)) and NAG:AuraIsActive(6774) and NAG:AuraIsActive(399963)) or (NAG:RuneIsEquipped(432276) and NAG:AuraIsActive(432276, "target") and NAG:AuraIsActive(6774) and NAG:AuraIsActive(399963))) and NAG:Cast(13877)
    or ((NAG:AuraIsKnown(1226843) and NAG:AuraIsKnown(1232181) and (not NAG:AuraIsActive(11275, "target")) and (NAG:CurrentComboPoints() >= 3) and (NAG:RemainingTime() >= 9)) or (NAG:AuraIsKnown(1226843) and (not NAG:AuraIsActive(11275, "target")) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 15)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 15) and (NAG:RemainingTime() >= 9))))) and NAG:Cast(11275)
    or (((not NAG:RuneIsEquipped(432271)) and (NAG:AuraRemainingTime(6774) <= 1) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 19)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 19) and (NAG:RemainingTime() >= 13)))) or (NAG:RuneIsEquipped(432271) and (not NAG:AuraIsActive(6774)) and (NAG:CurrentComboPoints() >= 1) and (NAG:RemainingTime() >= 10))) and NAG:Cast(6774)
    or ((NAG:AuraIsKnown(1232181) and (NAG:AuraIsKnown(1226843) or NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(436611, "target")) and (NAG:CurrentComboPoints() >= 1) and (NAG:RemainingTime() >= 5)) or ((NAG:AuraIsKnown(1226843) or NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(436611, "target")) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 11)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 11) and (NAG:RemainingTime() >= 7))))) and NAG:Cast(412096)
    or ((not NAG:AuraIsActive(425096)) and (NAG:CurrentEnergy() >= 35) and (NAG:CurrentComboPoints() >= 5) and NAG:GCDIsReady() and (NAG:AuraNumStacks(1214170, "target") >= 5)) and NAG:StrictSequence("foo", NAG:Cast(14177), NAG:Cast(1856), NAG:Cast(399963))
    or ((NAG:CurrentComboPoints() >= 4) or ((NAG:CurrentComboPoints() >= 3) and (NAG:RemainingTime() <= 4))) and NAG:Cast(399963)
    or (NAG:CurrentComboPoints() <= 3) and NAG:Cast(399956)
    or (((NAG:AuraNumStacks(1214170, "target") >= 4) and (NAG:CurrentComboPoints() < 5)) or (NAG:AuraRemainingTime(1214170, "target") <= 1)) and NAG:Cast(425012)
        ]],

    -- Tracked IDs for optimization
    spells = {1787, 1856, 6774, 11275, 13877, 14177, 399956, 399963, 412096, 425012, 425096, 432276, 436611, 1214170, 1226843, 1232181},
    items = {7676, 233985},
    auras = {},
    runes = {432271, 432276},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Subtlety 3Min Backstab Phase8 PreRaid rotation
local subtlety3MinBackstabPhase8PreRaid = {
    name = "Rogue Subtlety - 3Min_Backstab_Phase8_PreRaid by APLParser",
    specIndex = 3,
    class = "ROGUE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -1.0, action = "NAG:Cast(6774)" }
    },
    rotationString = [[
(((NAG:CurrentEnergy() <= 10) and (NAG:CurrentComboPoints() <= 4) and (NAG:TimeToEnergyTick() > 1)) or ((NAG:RemainingTime() <= 15) and (NAG:CurrentEnergy() <= 40) and (NAG:TimeToEnergyTick() > 1))) and NAG:Cast(7676)
    or (((NAG:CurrentEnergy() < 25) and (NAG:CurrentComboPoints() <= 4) and (NAG:TimeToEnergyTick() > 1) and (not NAG:AuraIsActive(467735)) and (not NAG:AuraIsActive(462707))) or ((NAG:RemainingTime() <= 15) and (NAG:CurrentEnergy() < 35) and (NAG:TimeToEnergyTick() > 1) and (not NAG:AuraIsActive(467735)) and (not NAG:AuraIsActive(462707)))) and NAG:Cast(231287)
    or NAG:AutocastOtherCooldowns()
    or (((not NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(1787))) or (NAG:RuneIsEquipped(432276) and NAG:AuraIsActive(432276, "target") and (not NAG:AuraIsActive(1787)))) and NAG:Cast(233985)
    or ((NAG:CurrentEnergy() >= 60) and NAG:AuraIsKnown(467735) and NAG:AuraIsActive(467735)) and NAG:Cast(25300)
    or ((NAG:AuraIsKnown(1232181) and NAG:AuraIsKnown(1226843) and (not NAG:AuraIsActive(11275, "target")) and (NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() > 9)) or (NAG:AuraIsKnown(1226843) and (not NAG:AuraIsActive(11275, "target")) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 15)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 15) and (NAG:RemainingTime() >= 9))))) and NAG:Cast(11275)
    or (((not NAG:RuneIsEquipped(432271)) and (NAG:AuraRemainingTime(6774) <= 1) and (not NAG:AuraIsActive(467735)) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 19)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 19) and (NAG:RemainingTime() >= 13)))) or (NAG:RuneIsEquipped(432271) and (not NAG:AuraIsActive(6774)) and (NAG:CurrentComboPoints() >= 1) and (not NAG:AuraIsActive(467735)) and (NAG:RemainingTime() >= 10))) and NAG:Cast(6774)
    or ((NAG:AuraIsKnown(1232181) and (not NAG:AuraIsActive(436611, "target")) and (NAG:CurrentComboPoints() >= 1) and (NAG:RemainingTime() > 5)) or ((NAG:AuraIsKnown(1226843) or NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(436611, "target")) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 11)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 11) and (NAG:RemainingTime() >= 7))))) and NAG:Cast(412096)
    or (((NAG:CurrentComboPoints() >= 5) or ((NAG:RemainingTime() <= 4) and (NAG:CurrentComboPoints() >= 4)))) and NAG:Cast(399963)
    or ((not NAG:AuraIsActive(462707)) and (not NAG:AuraIsActive(425096)) and (NAG:CurrentEnergy() >= 35) and (NAG:CurrentComboPoints() <= 2)) and NAG:Cast(1856)
    or NAG:Cast(11269)
    or NAG:Cast(25300)
    or (((NAG:AuraNumStacks(1214170, "target") >= 4) and (NAG:CurrentComboPoints() < 5))) and NAG:Cast(425012)
        ]],

    -- Tracked IDs for optimization
    spells = {1787, 1856, 6774, 11269, 11275, 25300, 399963, 412096, 425012, 425096, 432276, 436611, 462707, 467735, 1214170, 1226843, 1232181},
    items = {7676, 231287, 233985},
    auras = {},
    runes = {432271, 432276},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Assassination 5Min Phase8 PreRaid SaberSlash rotation
local assassination5MinPhase8PreRaidSaberSlash = {
    name = "Rogue Assassination - 5Min_Phase8_PreRaid_SaberSlash by APLParser",
    specIndex = 1,
    class = "ROGUE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -2.0, action = "NAG:Cast(6774)" },
        { time = -1.0, action = "NAG:Cast(13877)" }
    },
    rotationString = [[
((NAG:CurrentEnergy() <= 10) or ((NAG:RemainingTime() <= 15) and (NAG:CurrentEnergy() <= 40))) and NAG:Cast(7676)
    or NAG:AutocastOtherCooldowns()
    or (((not NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(1787))) or (NAG:RuneIsEquipped(432276) and (not NAG:AuraIsActive(1787)) and NAG:AuraIsActive(432276, "target"))) and NAG:Cast(233985)
    or (NAG:AuraIsKnown(1226843) and (not NAG:AuraIsActive(424785, "target")) and (not NAG:AuraIsActive(11275, "target")) and (not NAG:AuraIsActive(436611, "target")) and (NAG:CurrentComboPoints() <= 4)) and NAG:Cast(425012)
    or (NAG:AuraIsKnown(1226843) and (not NAG:AuraIsActive(424785, "target")) and (not NAG:AuraIsActive(11275, "target")) and (not NAG:AuraIsActive(436611, "target")) and (NAG:CurrentComboPoints() >= 1)) and NAG:Cast(412096)
    or ((NAG:CurrentComboPoints() <= 4) and ((NAG:AuraNumStacks(424785, "target") < 3) or (NAG:AuraRemainingTime(424785, "target") < 2)) and (NAG:AuraRemainingTime(424785, "target") < (NAG:RemainingTime() + 2))) and NAG:Cast(424785)
    or (((not NAG:RuneIsEquipped(432276)) and NAG:AuraIsActive(6774) and NAG:AuraIsActive(399963)) or (NAG:RuneIsEquipped(432276) and NAG:AuraIsActive(432276, "target") and NAG:AuraIsActive(6774) and NAG:AuraIsActive(399963))) and NAG:Cast(13877)
    or ((NAG:AuraNumStacks(1214170, "target") >= 4) and (NAG:CurrentComboPoints() < 5) and (NAG:CurrentEnergy() <= 75)) and NAG:Cast(425012)
    or (((not NAG:RuneIsEquipped(432271)) and (NAG:AuraRemainingTime(6774) <= 1) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 19)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 19) and (NAG:RemainingTime() >= 13)))) or (NAG:RuneIsEquipped(432271) and (not NAG:AuraIsActive(6774)) and (NAG:CurrentComboPoints() >= 1) and (NAG:RemainingTime() >= 10))) and NAG:Cast(6774)
    or ((NAG:AuraIsKnown(1226843) and NAG:AuraIsKnown(1232181) and (not NAG:RuneIsEquipped(432271)) and (not NAG:AuraIsActive(436611, "target")) and (NAG:CurrentComboPoints() >= 1) and (NAG:RemainingTime() >= 5)) or (NAG:AuraIsKnown(1226843) and (not NAG:RuneIsEquipped(432271)) and (not NAG:AuraIsActive(436611, "target")) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 11)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 11) and (NAG:RemainingTime() >= 7))))) and NAG:Cast(412096)
    or ((not NAG:AuraIsActive(425096)) and (NAG:CurrentEnergy() >= 35) and (NAG:CurrentComboPoints() >= 5) and NAG:GCDIsReady() and (NAG:AuraNumStacks(1214170, "target") >= 5)) and NAG:StrictSequence("foo", NAG:Cast(14177), NAG:Cast(1856), NAG:Cast(399963))
    or ((NAG:CurrentComboPoints() >= 4) or ((NAG:CurrentComboPoints() >= 3) and (NAG:RemainingTime() <= 4))) and NAG:Cast(399963)
    or ((NAG:AuraIsKnown(1226843) and (NAG:CurrentComboPoints() <= 4) and (NAG:CurrentEnergy() >= 75) and (NAG:AuraRemainingTime(424785, "target") >= 8) and (NAG:AuraNumStacks(424785, "target") >= 3)) or (NAG:AuraIsKnown(1226843) and (NAG:CurrentComboPoints() <= 2) and (NAG:AuraRemainingTime(424785, "target") >= 8) and (NAG:AuraNumStacks(424785, "target") >= 3)) or (NAG:AuraIsKnown(1226843) and (NAG:CurrentComboPoints() <= 2) and (NAG:RemainingTime() <= 4) and (NAG:AuraNumStacks(424785, "target") >= 3))) and NAG:Cast(11294)
    or ((NAG:CurrentComboPoints() <= 2) or ((NAG:CurrentComboPoints() <= 4) and (NAG:CurrentEnergy() >= 75))) and NAG:Cast(424785)
        ]],

    -- Tracked IDs for optimization
    spells = {1787, 1856, 6774, 11275, 11294, 13877, 14177, 399963, 412096, 424785, 425012, 425096, 432276, 436611, 1214170, 1226843, 1232181},
    items = {7676, 233985},
    auras = {},
    runes = {432271, 432276},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Subtlety 5Min Phase8 PreRaid SaberSlash rotation
local subtlety5MinPhase8PreRaidSaberSlash = {
    name = "Rogue Subtlety - 5Min_Phase8_PreRaid_SaberSlash by APLParser",
    specIndex = 3,
    class = "ROGUE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -2.0, action = "NAG:Cast(6774)" },
        { time = -1.0, action = "NAG:Cast(13877)" }
    },
    rotationString = [[
((NAG:CurrentEnergy() <= 10) or ((NAG:RemainingTime() <= 15) and (NAG:CurrentEnergy() <= 40))) and NAG:Cast(7676)
    or NAG:AutocastOtherCooldowns()
    or (((not NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(1787))) or (NAG:RuneIsEquipped(432276) and (not NAG:AuraIsActive(1787)) and NAG:AuraIsActive(432276, "target"))) and NAG:Cast(233985)
    or (NAG:AuraIsKnown(1226843) and (not NAG:AuraIsActive(424785, "target")) and (not NAG:AuraIsActive(11275, "target")) and (not NAG:AuraIsActive(436611, "target")) and (NAG:CurrentComboPoints() <= 4)) and NAG:Cast(425012)
    or (NAG:AuraIsKnown(1226843) and (not NAG:AuraIsActive(424785, "target")) and (not NAG:AuraIsActive(11275, "target")) and (not NAG:AuraIsActive(436611, "target")) and (NAG:CurrentComboPoints() >= 1)) and NAG:Cast(412096)
    or ((NAG:CurrentComboPoints() <= 4) and ((NAG:AuraNumStacks(424785, "target") < 3) or (NAG:AuraRemainingTime(424785, "target") < 2)) and (NAG:AuraRemainingTime(424785, "target") < (NAG:RemainingTime() + 2))) and NAG:Cast(424785)
    or (((not NAG:RuneIsEquipped(432276)) and NAG:AuraIsActive(6774) and NAG:AuraIsActive(399963)) or (NAG:RuneIsEquipped(432276) and NAG:AuraIsActive(432276, "target") and NAG:AuraIsActive(6774) and NAG:AuraIsActive(399963))) and NAG:Cast(13877)
    or ((NAG:AuraNumStacks(1214170, "target") >= 4) and (NAG:CurrentComboPoints() < 5) and (NAG:CurrentEnergy() <= 75)) and NAG:Cast(425012)
    or (((not NAG:RuneIsEquipped(432271)) and (NAG:AuraRemainingTime(6774) <= 1) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 19)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 19) and (NAG:RemainingTime() >= 13)))) or (NAG:RuneIsEquipped(432271) and (not NAG:AuraIsActive(6774)) and (NAG:CurrentComboPoints() >= 1) and (NAG:RemainingTime() >= 10))) and NAG:Cast(6774)
    or ((NAG:AuraIsKnown(1226843) and NAG:AuraIsKnown(1232181) and (not NAG:RuneIsEquipped(432271)) and (not NAG:AuraIsActive(436611, "target")) and (NAG:CurrentComboPoints() >= 1) and (NAG:RemainingTime() >= 5)) or (NAG:AuraIsKnown(1226843) and (not NAG:RuneIsEquipped(432271)) and (not NAG:AuraIsActive(436611, "target")) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 11)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 11) and (NAG:RemainingTime() >= 7))))) and NAG:Cast(412096)
    or ((not NAG:AuraIsActive(425096)) and (NAG:CurrentEnergy() >= 35) and (NAG:CurrentComboPoints() >= 5) and NAG:GCDIsReady() and (NAG:AuraNumStacks(1214170, "target") >= 5)) and NAG:StrictSequence("foo", NAG:Cast(14177), NAG:Cast(1856), NAG:Cast(399963))
    or ((NAG:CurrentComboPoints() >= 4) or ((NAG:CurrentComboPoints() >= 3) and (NAG:RemainingTime() <= 4))) and NAG:Cast(399963)
    or ((NAG:AuraIsKnown(1226843) and (NAG:CurrentComboPoints() <= 4) and (NAG:CurrentEnergy() >= 75) and (NAG:AuraRemainingTime(424785, "target") >= 8) and (NAG:AuraNumStacks(424785, "target") >= 3)) or (NAG:AuraIsKnown(1226843) and (NAG:CurrentComboPoints() <= 2) and (NAG:AuraRemainingTime(424785, "target") >= 8) and (NAG:AuraNumStacks(424785, "target") >= 3)) or (NAG:AuraIsKnown(1226843) and (NAG:CurrentComboPoints() <= 2) and (NAG:RemainingTime() <= 4) and (NAG:AuraNumStacks(424785, "target") >= 3))) and NAG:Cast(11294)
    or ((NAG:CurrentComboPoints() <= 2) or ((NAG:CurrentComboPoints() <= 4) and (NAG:CurrentEnergy() >= 75))) and NAG:Cast(424785)
        ]],

    -- Tracked IDs for optimization
    spells = {1787, 1856, 6774, 11275, 11294, 13877, 14177, 399963, 412096, 424785, 425012, 425096, 432276, 436611, 1214170, 1226843, 1232181},
    items = {7676, 233985},
    auras = {},
    runes = {432271, 432276},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Assassination 5Min Mutilate Phase8 PreRaid rotation
local assassination5MinMutilatePhase8PreRaid = {
    name = "Rogue Assassination - 5Min_Mutilate_Phase8_PreRaid by APLParser",
    specIndex = 1,
    class = "ROGUE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -2.0, action = "NAG:Cast(6774)" },
        { time = -1.0, action = "NAG:Cast(13877)" }
    },
    rotationString = [[
((NAG:CurrentEnergy() <= 10) or ((NAG:RemainingTime() <= 20) and (NAG:CurrentEnergy() <= 40))) and NAG:Cast(7676)
    or NAG:AutocastOtherCooldowns()
    or (((not NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(1787))) or (NAG:RuneIsEquipped(432276) and NAG:AuraIsActive(432276, "target") and (not NAG:AuraIsActive(1787)))) and NAG:Cast(233985)
    or (((not NAG:RuneIsEquipped(432276)) and NAG:AuraIsActive(6774) and NAG:AuraIsActive(399963)) or (NAG:RuneIsEquipped(432276) and NAG:AuraIsActive(432276, "target") and NAG:AuraIsActive(6774) and NAG:AuraIsActive(399963))) and NAG:Cast(13877)
    or ((NAG:AuraIsKnown(1226843) and NAG:AuraIsKnown(1232181) and (not NAG:AuraIsActive(11275, "target")) and (NAG:CurrentComboPoints() >= 3) and (NAG:RemainingTime() >= 9)) or (NAG:AuraIsKnown(1226843) and (not NAG:AuraIsActive(11275, "target")) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 15)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 15) and (NAG:RemainingTime() >= 9))))) and NAG:Cast(11275)
    or (((not NAG:RuneIsEquipped(432271)) and (NAG:AuraRemainingTime(6774) <= 1) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 19)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 19) and (NAG:RemainingTime() >= 13)))) or (NAG:RuneIsEquipped(432271) and (not NAG:AuraIsActive(6774)) and (NAG:CurrentComboPoints() >= 1) and (NAG:RemainingTime() >= 10))) and NAG:Cast(6774)
    or ((NAG:AuraIsKnown(1232181) and (NAG:AuraIsKnown(1226843) or NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(436611, "target")) and (NAG:CurrentComboPoints() >= 1) and (NAG:RemainingTime() >= 5)) or ((NAG:AuraIsKnown(1226843) or NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(436611, "target")) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 11)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 11) and (NAG:RemainingTime() >= 7))))) and NAG:Cast(412096)
    or ((not NAG:AuraIsActive(425096)) and (NAG:CurrentEnergy() >= 35) and (NAG:CurrentComboPoints() >= 5) and NAG:GCDIsReady() and (NAG:AuraNumStacks(1214170, "target") >= 5)) and NAG:StrictSequence("foo", NAG:Cast(14177), NAG:Cast(1856), NAG:Cast(399963))
    or ((NAG:CurrentComboPoints() >= 4) or ((NAG:CurrentComboPoints() >= 3) and (NAG:RemainingTime() <= 4))) and NAG:Cast(399963)
    or (NAG:CurrentComboPoints() <= 3) and NAG:Cast(399956)
    or (((NAG:AuraNumStacks(1214170, "target") >= 4) and (NAG:CurrentComboPoints() < 5)) or (NAG:AuraRemainingTime(1214170, "target") <= 1)) and NAG:Cast(425012)
        ]],

    -- Tracked IDs for optimization
    spells = {1787, 1856, 6774, 11275, 13877, 14177, 399956, 399963, 412096, 425012, 425096, 432276, 436611, 1214170, 1226843, 1232181},
    items = {7676, 233985},
    auras = {},
    runes = {432271, 432276},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Subtlety 5Min Backstab Phase8 PreRaid rotation
local subtlety5MinBackstabPhase8PreRaid = {
    name = "Rogue Subtlety - 5Min_Backstab_Phase8_PreRaid by APLParser",
    specIndex = 3,
    class = "ROGUE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -1.0, action = "NAG:Cast(6774)" }
    },
    rotationString = [[
(((NAG:CurrentEnergy() <= 10) and (NAG:CurrentComboPoints() <= 4) and (NAG:TimeToEnergyTick() > 1)) or ((NAG:RemainingTime() <= 15) and (NAG:CurrentEnergy() <= 40) and (NAG:TimeToEnergyTick() > 1))) and NAG:Cast(7676)
    or (((NAG:CurrentEnergy() < 25) and (NAG:CurrentComboPoints() <= 4) and (NAG:TimeToEnergyTick() > 1) and (not NAG:AuraIsActive(467735)) and (not NAG:AuraIsActive(462707))) or ((NAG:RemainingTime() <= 15) and (NAG:CurrentEnergy() < 35) and (NAG:TimeToEnergyTick() > 1) and (not NAG:AuraIsActive(467735)) and (not NAG:AuraIsActive(462707)))) and NAG:Cast(231287)
    or NAG:AutocastOtherCooldowns()
    or (((not NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(1787))) or (NAG:RuneIsEquipped(432276) and NAG:AuraIsActive(432276, "target") and (not NAG:AuraIsActive(1787)))) and NAG:Cast(233985)
    or ((NAG:CurrentEnergy() >= 60) and NAG:AuraIsKnown(467735) and NAG:AuraIsActive(467735)) and NAG:Cast(25300)
    or ((NAG:AuraIsKnown(1232181) and NAG:AuraIsKnown(1226843) and (not NAG:AuraIsActive(11275, "target")) and (NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() > 9)) or (NAG:AuraIsKnown(1226843) and (not NAG:AuraIsActive(11275, "target")) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 15)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 15) and (NAG:RemainingTime() >= 9))))) and NAG:Cast(11275)
    or (((not NAG:RuneIsEquipped(432271)) and (NAG:AuraRemainingTime(6774) <= 1) and (not NAG:AuraIsActive(467735)) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 19)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 19) and (NAG:RemainingTime() >= 13)))) or (NAG:RuneIsEquipped(432271) and (not NAG:AuraIsActive(6774)) and (NAG:CurrentComboPoints() >= 1) and (not NAG:AuraIsActive(467735)) and (NAG:RemainingTime() >= 10))) and NAG:Cast(6774)
    or ((NAG:AuraIsKnown(1232181) and (not NAG:AuraIsActive(436611, "target")) and (NAG:CurrentComboPoints() >= 1) and (NAG:RemainingTime() > 5)) or ((NAG:AuraIsKnown(1226843) or NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(436611, "target")) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 11)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 11) and (NAG:RemainingTime() >= 7))))) and NAG:Cast(412096)
    or (((NAG:CurrentComboPoints() >= 5) or ((NAG:RemainingTime() <= 4) and (NAG:CurrentComboPoints() >= 4)))) and NAG:Cast(399963)
    or ((not NAG:AuraIsActive(462707)) and (not NAG:AuraIsActive(425096)) and (NAG:CurrentEnergy() >= 35) and (NAG:CurrentComboPoints() <= 2)) and NAG:Cast(1856)
    or NAG:Cast(11269)
    or NAG:Cast(25300)
    or (((NAG:AuraNumStacks(1214170, "target") >= 4) and (NAG:CurrentComboPoints() < 5))) and NAG:Cast(425012)
        ]],

    -- Tracked IDs for optimization
    spells = {1787, 1856, 6774, 11269, 11275, 25300, 399963, 412096, 425012, 425096, 432276, 436611, 462707, 467735, 1214170, 1226843, 1232181},
    items = {7676, 231287, 233985},
    auras = {},
    runes = {432271, 432276},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Assassination 1Target 1Min BiS Phase8 ST SaberSlash rotation
local assassination1Target1MinBiSPhase8STSaberSlash = {
    name = "Rogue Assassination - 1Target_1Min_BiS_Phase8_ST_SaberSlash by APLParser",
    specIndex = 1,
    class = "ROGUE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -2.0, action = "NAG:Cast(6774)" },
        { time = -1.0, action = "NAG:Cast(13877)" }
    },
    rotationString = [[
((NAG:CurrentEnergy() <= 10) or ((NAG:RemainingTime() <= 15) and (NAG:CurrentEnergy() <= 40))) and NAG:Cast(7676)
    or NAG:AutocastOtherCooldowns()
    or (((not NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(1787))) or (NAG:RuneIsEquipped(432276) and (not NAG:AuraIsActive(1787)) and NAG:AuraIsActive(432276, "target"))) and NAG:Cast(233985)
    or (NAG:AuraIsKnown(1226843) and (not NAG:AuraIsActive(424785, "target")) and (not NAG:AuraIsActive(11275, "target")) and (not NAG:AuraIsActive(436611, "target")) and (NAG:CurrentComboPoints() <= 4)) and NAG:Cast(425012)
    or (NAG:AuraIsKnown(1226843) and (not NAG:AuraIsActive(424785, "target")) and (not NAG:AuraIsActive(11275, "target")) and (not NAG:AuraIsActive(436611, "target")) and (NAG:CurrentComboPoints() >= 1)) and NAG:Cast(412096)
    or ((NAG:CurrentComboPoints() <= 4) and ((NAG:AuraNumStacks(424785, "target") < 3) or (NAG:AuraRemainingTime(424785, "target") < 2)) and (NAG:AuraRemainingTime(424785, "target") < (NAG:RemainingTime() + 2))) and NAG:Cast(424785)
    or (((not NAG:RuneIsEquipped(432276)) and NAG:AuraIsActive(6774) and NAG:AuraIsActive(399963)) or (NAG:RuneIsEquipped(432276) and NAG:AuraIsActive(432276, "target") and NAG:AuraIsActive(6774) and NAG:AuraIsActive(399963))) and NAG:Cast(13877)
    or ((NAG:AuraNumStacks(1214170, "target") >= 4) and (NAG:CurrentComboPoints() < 5) and (NAG:CurrentEnergy() <= 75)) and NAG:Cast(425012)
    or (((not NAG:RuneIsEquipped(432271)) and (NAG:AuraRemainingTime(6774) <= 1) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 19)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 19) and (NAG:RemainingTime() >= 13)))) or (NAG:RuneIsEquipped(432271) and (not NAG:AuraIsActive(6774)) and (NAG:CurrentComboPoints() >= 1) and (NAG:RemainingTime() >= 10))) and NAG:Cast(6774)
    or ((NAG:AuraIsKnown(1226843) and NAG:AuraIsKnown(1232181) and (not NAG:RuneIsEquipped(432271)) and (not NAG:AuraIsActive(436611, "target")) and (NAG:CurrentComboPoints() >= 1) and (NAG:RemainingTime() >= 5)) or (NAG:AuraIsKnown(1226843) and (not NAG:RuneIsEquipped(432271)) and (not NAG:AuraIsActive(436611, "target")) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 11)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 11) and (NAG:RemainingTime() >= 7))))) and NAG:Cast(412096)
    or ((not NAG:AuraIsActive(425096)) and (NAG:CurrentEnergy() >= 35) and (NAG:CurrentComboPoints() >= 5) and NAG:GCDIsReady() and (NAG:AuraNumStacks(1214170, "target") >= 5)) and NAG:StrictSequence("foo", NAG:Cast(14177), NAG:Cast(1856), NAG:Cast(399963))
    or ((NAG:CurrentComboPoints() >= 4) or ((NAG:CurrentComboPoints() >= 3) and (NAG:RemainingTime() <= 4))) and NAG:Cast(399963)
    or ((NAG:AuraIsKnown(1226843) and (NAG:CurrentComboPoints() <= 4) and (NAG:CurrentEnergy() >= 75) and (NAG:AuraRemainingTime(424785, "target") >= 8) and (NAG:AuraNumStacks(424785, "target") >= 3)) or (NAG:AuraIsKnown(1226843) and (NAG:CurrentComboPoints() <= 2) and (NAG:AuraRemainingTime(424785, "target") >= 8) and (NAG:AuraNumStacks(424785, "target") >= 3)) or (NAG:AuraIsKnown(1226843) and (NAG:CurrentComboPoints() <= 2) and (NAG:RemainingTime() <= 4) and (NAG:AuraNumStacks(424785, "target") >= 3))) and NAG:Cast(11294)
    or ((NAG:CurrentComboPoints() <= 2) or ((NAG:CurrentComboPoints() <= 4) and (NAG:CurrentEnergy() >= 75))) and NAG:Cast(424785)
        ]],

    -- Tracked IDs for optimization
    spells = {1787, 1856, 6774, 11275, 11294, 13877, 14177, 399963, 412096, 424785, 425012, 425096, 432276, 436611, 1214170, 1226843, 1232181},
    items = {7676, 233985},
    auras = {},
    runes = {432271, 432276},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Assassination 1Target 1Min BiS Mutilate Phase8 ST rotation
local assassination1Target1MinBiSMutilatePhase8ST = {
    name = "Rogue Assassination - 1Target_1Min_BiS_Mutilate_Phase8_ST by APLParser",
    specIndex = 1,
    class = "ROGUE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -2.0, action = "NAG:Cast(6774)" },
        { time = -1.0, action = "NAG:Cast(13877)" }
    },
    rotationString = [[
((NAG:CurrentEnergy() <= 10) or ((NAG:RemainingTime() <= 20) and (NAG:CurrentEnergy() <= 40))) and NAG:Cast(7676)
    or NAG:AutocastOtherCooldowns()
    or (((not NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(1787))) or (NAG:RuneIsEquipped(432276) and NAG:AuraIsActive(432276, "target") and (not NAG:AuraIsActive(1787)))) and NAG:Cast(233985)
    or (((not NAG:RuneIsEquipped(432276)) and NAG:AuraIsActive(6774) and NAG:AuraIsActive(399963)) or (NAG:RuneIsEquipped(432276) and NAG:AuraIsActive(432276, "target") and NAG:AuraIsActive(6774) and NAG:AuraIsActive(399963))) and NAG:Cast(13877)
    or ((NAG:AuraIsKnown(1226843) and NAG:AuraIsKnown(1232181) and (not NAG:AuraIsActive(11275, "target")) and (NAG:CurrentComboPoints() >= 3) and (NAG:RemainingTime() >= 9)) or (NAG:AuraIsKnown(1226843) and (not NAG:AuraIsActive(11275, "target")) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 15)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 15) and (NAG:RemainingTime() >= 9))))) and NAG:Cast(11275)
    or (((not NAG:RuneIsEquipped(432271)) and (NAG:AuraRemainingTime(6774) <= 1) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 19)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 19) and (NAG:RemainingTime() >= 13)))) or (NAG:RuneIsEquipped(432271) and (not NAG:AuraIsActive(6774)) and (NAG:CurrentComboPoints() >= 1) and (NAG:RemainingTime() >= 10))) and NAG:Cast(6774)
    or ((NAG:AuraIsKnown(1232181) and (NAG:AuraIsKnown(1226843) or NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(436611, "target")) and (NAG:CurrentComboPoints() >= 1) and (NAG:RemainingTime() >= 5)) or ((NAG:AuraIsKnown(1226843) or NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(436611, "target")) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 11)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 11) and (NAG:RemainingTime() >= 7))))) and NAG:Cast(412096)
    or ((not NAG:AuraIsActive(425096)) and (NAG:CurrentEnergy() >= 35) and (NAG:CurrentComboPoints() >= 5) and NAG:GCDIsReady() and (NAG:AuraNumStacks(1214170, "target") >= 5)) and NAG:StrictSequence("foo", NAG:Cast(14177), NAG:Cast(1856), NAG:Cast(399963))
    or ((NAG:CurrentComboPoints() >= 4) or ((NAG:CurrentComboPoints() >= 3) and (NAG:RemainingTime() <= 4))) and NAG:Cast(399963)
    or (NAG:CurrentComboPoints() <= 3) and NAG:Cast(399956)
    or (((NAG:AuraNumStacks(1214170, "target") >= 4) and (NAG:CurrentComboPoints() < 5)) or (NAG:AuraRemainingTime(1214170, "target") <= 1)) and NAG:Cast(425012)
        ]],

    -- Tracked IDs for optimization
    spells = {1787, 1856, 6774, 11275, 13877, 14177, 399956, 399963, 412096, 425012, 425096, 432276, 436611, 1214170, 1226843, 1232181},
    items = {7676, 233985},
    auras = {},
    runes = {432271, 432276},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Subtlety 1Target 1Min Backstab BiS Phase8 ST rotation
local subtlety1Target1MinBackstabBiSPhase8ST = {
    name = "Rogue Subtlety - 1Target_1Min_Backstab_BiS_Phase8_ST by APLParser",
    specIndex = 3,
    class = "ROGUE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -1.0, action = "NAG:Cast(6774)" }
    },
    rotationString = [[
(((NAG:CurrentEnergy() <= 10) and (NAG:CurrentComboPoints() <= 4) and (NAG:TimeToEnergyTick() > 1)) or ((NAG:RemainingTime() <= 15) and (NAG:CurrentEnergy() <= 40) and (NAG:TimeToEnergyTick() > 1))) and NAG:Cast(7676)
    or (((NAG:CurrentEnergy() < 25) and (NAG:CurrentComboPoints() <= 4) and (NAG:TimeToEnergyTick() > 1) and (not NAG:AuraIsActive(467735)) and (not NAG:AuraIsActive(462707))) or ((NAG:RemainingTime() <= 15) and (NAG:CurrentEnergy() < 35) and (NAG:TimeToEnergyTick() > 1) and (not NAG:AuraIsActive(467735)) and (not NAG:AuraIsActive(462707)))) and NAG:Cast(231287)
    or NAG:AutocastOtherCooldowns()
    or (((not NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(1787))) or (NAG:RuneIsEquipped(432276) and NAG:AuraIsActive(432276, "target") and (not NAG:AuraIsActive(1787)))) and NAG:Cast(233985)
    or ((NAG:CurrentEnergy() >= 60) and NAG:AuraIsKnown(467735) and NAG:AuraIsActive(467735)) and NAG:Cast(25300)
    or ((NAG:AuraIsKnown(1232181) and NAG:AuraIsKnown(1226843) and (not NAG:AuraIsActive(11275, "target")) and (NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() > 9)) or (NAG:AuraIsKnown(1226843) and (not NAG:AuraIsActive(11275, "target")) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 15)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 15) and (NAG:RemainingTime() >= 9))))) and NAG:Cast(11275)
    or (((not NAG:RuneIsEquipped(432271)) and (NAG:AuraRemainingTime(6774) <= 1) and (not NAG:AuraIsActive(467735)) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 19)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 19) and (NAG:RemainingTime() >= 13)))) or (NAG:RuneIsEquipped(432271) and (not NAG:AuraIsActive(6774)) and (NAG:CurrentComboPoints() >= 1) and (not NAG:AuraIsActive(467735)) and (NAG:RemainingTime() >= 10))) and NAG:Cast(6774)
    or ((NAG:AuraIsKnown(1232181) and (not NAG:AuraIsActive(436611, "target")) and (NAG:CurrentComboPoints() >= 1) and (NAG:RemainingTime() > 5)) or ((NAG:AuraIsKnown(1226843) or NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(436611, "target")) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 11)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 11) and (NAG:RemainingTime() >= 7))))) and NAG:Cast(412096)
    or (((NAG:CurrentComboPoints() >= 5) or ((NAG:RemainingTime() <= 4) and (NAG:CurrentComboPoints() >= 4)))) and NAG:Cast(399963)
    or ((not NAG:AuraIsActive(462707)) and (not NAG:AuraIsActive(425096)) and (NAG:CurrentEnergy() >= 35) and (NAG:CurrentComboPoints() <= 2)) and NAG:Cast(1856)
    or NAG:Cast(11269)
    or NAG:Cast(25300)
    or (((NAG:AuraNumStacks(1214170, "target") >= 4) and (NAG:CurrentComboPoints() < 5))) and NAG:Cast(425012)
        ]],

    -- Tracked IDs for optimization
    spells = {1787, 1856, 6774, 11269, 11275, 25300, 399963, 412096, 425012, 425096, 432276, 436611, 462707, 467735, 1214170, 1226843, 1232181},
    items = {7676, 231287, 233985},
    auras = {},
    runes = {432271, 432276},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Assassination 1Target 2Min BiS Phase8 ST SaberSlash rotation
local assassination1Target2MinBiSPhase8STSaberSlash = {
    name = "Rogue Assassination - 1Target_2Min_BiS_Phase8_ST_SaberSlash by APLParser",
    specIndex = 1,
    class = "ROGUE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -2.0, action = "NAG:Cast(6774)" },
        { time = -1.0, action = "NAG:Cast(13877)" }
    },
    rotationString = [[
((NAG:CurrentEnergy() <= 10) or ((NAG:RemainingTime() <= 15) and (NAG:CurrentEnergy() <= 40))) and NAG:Cast(7676)
    or NAG:AutocastOtherCooldowns()
    or (((not NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(1787))) or (NAG:RuneIsEquipped(432276) and (not NAG:AuraIsActive(1787)) and NAG:AuraIsActive(432276, "target"))) and NAG:Cast(233985)
    or (NAG:AuraIsKnown(1226843) and (not NAG:AuraIsActive(424785, "target")) and (not NAG:AuraIsActive(11275, "target")) and (not NAG:AuraIsActive(436611, "target")) and (NAG:CurrentComboPoints() <= 4)) and NAG:Cast(425012)
    or (NAG:AuraIsKnown(1226843) and (not NAG:AuraIsActive(424785, "target")) and (not NAG:AuraIsActive(11275, "target")) and (not NAG:AuraIsActive(436611, "target")) and (NAG:CurrentComboPoints() >= 1)) and NAG:Cast(412096)
    or ((NAG:CurrentComboPoints() <= 4) and ((NAG:AuraNumStacks(424785, "target") < 3) or (NAG:AuraRemainingTime(424785, "target") < 2)) and (NAG:AuraRemainingTime(424785, "target") < (NAG:RemainingTime() + 2))) and NAG:Cast(424785)
    or (((not NAG:RuneIsEquipped(432276)) and NAG:AuraIsActive(6774) and NAG:AuraIsActive(399963)) or (NAG:RuneIsEquipped(432276) and NAG:AuraIsActive(432276, "target") and NAG:AuraIsActive(6774) and NAG:AuraIsActive(399963))) and NAG:Cast(13877)
    or ((NAG:AuraNumStacks(1214170, "target") >= 4) and (NAG:CurrentComboPoints() < 5) and (NAG:CurrentEnergy() <= 75)) and NAG:Cast(425012)
    or (((not NAG:RuneIsEquipped(432271)) and (NAG:AuraRemainingTime(6774) <= 1) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 19)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 19) and (NAG:RemainingTime() >= 13)))) or (NAG:RuneIsEquipped(432271) and (not NAG:AuraIsActive(6774)) and (NAG:CurrentComboPoints() >= 1) and (NAG:RemainingTime() >= 10))) and NAG:Cast(6774)
    or ((NAG:AuraIsKnown(1226843) and NAG:AuraIsKnown(1232181) and (not NAG:RuneIsEquipped(432271)) and (not NAG:AuraIsActive(436611, "target")) and (NAG:CurrentComboPoints() >= 1) and (NAG:RemainingTime() >= 5)) or (NAG:AuraIsKnown(1226843) and (not NAG:RuneIsEquipped(432271)) and (not NAG:AuraIsActive(436611, "target")) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 11)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 11) and (NAG:RemainingTime() >= 7))))) and NAG:Cast(412096)
    or ((not NAG:AuraIsActive(425096)) and (NAG:CurrentEnergy() >= 35) and (NAG:CurrentComboPoints() >= 5) and NAG:GCDIsReady() and (NAG:AuraNumStacks(1214170, "target") >= 5)) and NAG:StrictSequence("foo", NAG:Cast(14177), NAG:Cast(1856), NAG:Cast(399963))
    or ((NAG:CurrentComboPoints() >= 4) or ((NAG:CurrentComboPoints() >= 3) and (NAG:RemainingTime() <= 4))) and NAG:Cast(399963)
    or ((NAG:AuraIsKnown(1226843) and (NAG:CurrentComboPoints() <= 4) and (NAG:CurrentEnergy() >= 75) and (NAG:AuraRemainingTime(424785, "target") >= 8) and (NAG:AuraNumStacks(424785, "target") >= 3)) or (NAG:AuraIsKnown(1226843) and (NAG:CurrentComboPoints() <= 2) and (NAG:AuraRemainingTime(424785, "target") >= 8) and (NAG:AuraNumStacks(424785, "target") >= 3)) or (NAG:AuraIsKnown(1226843) and (NAG:CurrentComboPoints() <= 2) and (NAG:RemainingTime() <= 4) and (NAG:AuraNumStacks(424785, "target") >= 3))) and NAG:Cast(11294)
    or ((NAG:CurrentComboPoints() <= 2) or ((NAG:CurrentComboPoints() <= 4) and (NAG:CurrentEnergy() >= 75))) and NAG:Cast(424785)
        ]],

    -- Tracked IDs for optimization
    spells = {1787, 1856, 6774, 11275, 11294, 13877, 14177, 399963, 412096, 424785, 425012, 425096, 432276, 436611, 1214170, 1226843, 1232181},
    items = {7676, 233985},
    auras = {},
    runes = {432271, 432276},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Subtlety 1Target 2Min Backstab BiS Phase8 ST rotation
local subtlety1Target2MinBackstabBiSPhase8ST = {
    name = "Rogue Subtlety - 1Target_2Min_Backstab_BiS_Phase8_ST by APLParser",
    specIndex = 3,
    class = "ROGUE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -1.0, action = "NAG:Cast(6774)" }
    },
    rotationString = [[
(((NAG:CurrentEnergy() <= 10) and (NAG:CurrentComboPoints() <= 4) and (NAG:TimeToEnergyTick() > 1)) or ((NAG:RemainingTime() <= 15) and (NAG:CurrentEnergy() <= 40) and (NAG:TimeToEnergyTick() > 1))) and NAG:Cast(7676)
    or (((NAG:CurrentEnergy() < 25) and (NAG:CurrentComboPoints() <= 4) and (NAG:TimeToEnergyTick() > 1) and (not NAG:AuraIsActive(467735)) and (not NAG:AuraIsActive(462707))) or ((NAG:RemainingTime() <= 15) and (NAG:CurrentEnergy() < 35) and (NAG:TimeToEnergyTick() > 1) and (not NAG:AuraIsActive(467735)) and (not NAG:AuraIsActive(462707)))) and NAG:Cast(231287)
    or NAG:AutocastOtherCooldowns()
    or (((not NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(1787))) or (NAG:RuneIsEquipped(432276) and NAG:AuraIsActive(432276, "target") and (not NAG:AuraIsActive(1787)))) and NAG:Cast(233985)
    or ((NAG:CurrentEnergy() >= 60) and NAG:AuraIsKnown(467735) and NAG:AuraIsActive(467735)) and NAG:Cast(25300)
    or ((NAG:AuraIsKnown(1232181) and NAG:AuraIsKnown(1226843) and (not NAG:AuraIsActive(11275, "target")) and (NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() > 9)) or (NAG:AuraIsKnown(1226843) and (not NAG:AuraIsActive(11275, "target")) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 15)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 15) and (NAG:RemainingTime() >= 9))))) and NAG:Cast(11275)
    or (((not NAG:RuneIsEquipped(432271)) and (NAG:AuraRemainingTime(6774) <= 1) and (not NAG:AuraIsActive(467735)) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 19)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 19) and (NAG:RemainingTime() >= 13)))) or (NAG:RuneIsEquipped(432271) and (not NAG:AuraIsActive(6774)) and (NAG:CurrentComboPoints() >= 1) and (not NAG:AuraIsActive(467735)) and (NAG:RemainingTime() >= 10))) and NAG:Cast(6774)
    or ((NAG:AuraIsKnown(1232181) and (not NAG:AuraIsActive(436611, "target")) and (NAG:CurrentComboPoints() >= 1) and (NAG:RemainingTime() > 5)) or ((NAG:AuraIsKnown(1226843) or NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(436611, "target")) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 11)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 11) and (NAG:RemainingTime() >= 7))))) and NAG:Cast(412096)
    or (((NAG:CurrentComboPoints() >= 5) or ((NAG:RemainingTime() <= 4) and (NAG:CurrentComboPoints() >= 4)))) and NAG:Cast(399963)
    or ((not NAG:AuraIsActive(462707)) and (not NAG:AuraIsActive(425096)) and (NAG:CurrentEnergy() >= 35) and (NAG:CurrentComboPoints() <= 2)) and NAG:Cast(1856)
    or NAG:Cast(11269)
    or NAG:Cast(25300)
    or (((NAG:AuraNumStacks(1214170, "target") >= 4) and (NAG:CurrentComboPoints() < 5))) and NAG:Cast(425012)
        ]],

    -- Tracked IDs for optimization
    spells = {1787, 1856, 6774, 11269, 11275, 25300, 399963, 412096, 425012, 425096, 432276, 436611, 462707, 467735, 1214170, 1226843, 1232181},
    items = {7676, 231287, 233985},
    auras = {},
    runes = {432271, 432276},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Assassination 1Target 2Min BiS Mutilate Phase8 ST rotation
local assassination1Target2MinBiSMutilatePhase8ST = {
    name = "Rogue Assassination - 1Target_2Min_BiS_Mutilate_Phase8_ST by APLParser",
    specIndex = 1,
    class = "ROGUE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -2.0, action = "NAG:Cast(6774)" },
        { time = -1.0, action = "NAG:Cast(13877)" }
    },
    rotationString = [[
((NAG:CurrentEnergy() <= 10) or ((NAG:RemainingTime() <= 20) and (NAG:CurrentEnergy() <= 40))) and NAG:Cast(7676)
    or NAG:AutocastOtherCooldowns()
    or (((not NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(1787))) or (NAG:RuneIsEquipped(432276) and NAG:AuraIsActive(432276, "target") and (not NAG:AuraIsActive(1787)))) and NAG:Cast(233985)
    or (((not NAG:RuneIsEquipped(432276)) and NAG:AuraIsActive(6774) and NAG:AuraIsActive(399963)) or (NAG:RuneIsEquipped(432276) and NAG:AuraIsActive(432276, "target") and NAG:AuraIsActive(6774) and NAG:AuraIsActive(399963))) and NAG:Cast(13877)
    or ((NAG:AuraIsKnown(1226843) and NAG:AuraIsKnown(1232181) and (not NAG:AuraIsActive(11275, "target")) and (NAG:CurrentComboPoints() >= 3) and (NAG:RemainingTime() >= 9)) or (NAG:AuraIsKnown(1226843) and (not NAG:AuraIsActive(11275, "target")) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 15)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 15) and (NAG:RemainingTime() >= 9))))) and NAG:Cast(11275)
    or (((not NAG:RuneIsEquipped(432271)) and (NAG:AuraRemainingTime(6774) <= 1) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 19)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 19) and (NAG:RemainingTime() >= 13)))) or (NAG:RuneIsEquipped(432271) and (not NAG:AuraIsActive(6774)) and (NAG:CurrentComboPoints() >= 1) and (NAG:RemainingTime() >= 10))) and NAG:Cast(6774)
    or ((NAG:AuraIsKnown(1232181) and (NAG:AuraIsKnown(1226843) or NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(436611, "target")) and (NAG:CurrentComboPoints() >= 1) and (NAG:RemainingTime() >= 5)) or ((NAG:AuraIsKnown(1226843) or NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(436611, "target")) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 11)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 11) and (NAG:RemainingTime() >= 7))))) and NAG:Cast(412096)
    or ((not NAG:AuraIsActive(425096)) and (NAG:CurrentEnergy() >= 35) and (NAG:CurrentComboPoints() >= 5) and NAG:GCDIsReady() and (NAG:AuraNumStacks(1214170, "target") >= 5)) and NAG:StrictSequence("foo", NAG:Cast(14177), NAG:Cast(1856), NAG:Cast(399963))
    or ((NAG:CurrentComboPoints() >= 4) or ((NAG:CurrentComboPoints() >= 3) and (NAG:RemainingTime() <= 4))) and NAG:Cast(399963)
    or (NAG:CurrentComboPoints() <= 3) and NAG:Cast(399956)
    or (((NAG:AuraNumStacks(1214170, "target") >= 4) and (NAG:CurrentComboPoints() < 5)) or (NAG:AuraRemainingTime(1214170, "target") <= 1)) and NAG:Cast(425012)
        ]],

    -- Tracked IDs for optimization
    spells = {1787, 1856, 6774, 11275, 13877, 14177, 399956, 399963, 412096, 425012, 425096, 432276, 436611, 1214170, 1226843, 1232181},
    items = {7676, 233985},
    auras = {},
    runes = {432271, 432276},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Assassination 1Target 3Min BiS Phase8 ST SaberSlash rotation
local assassination1Target3MinBiSPhase8STSaberSlash = {
    name = "Rogue Assassination - 1Target_3Min_BiS_Phase8_ST_SaberSlash by APLParser",
    specIndex = 1,
    class = "ROGUE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -2.0, action = "NAG:Cast(6774)" },
        { time = -1.0, action = "NAG:Cast(13877)" }
    },
    rotationString = [[
((NAG:CurrentEnergy() <= 10) or ((NAG:RemainingTime() <= 15) and (NAG:CurrentEnergy() <= 40))) and NAG:Cast(7676)
    or NAG:AutocastOtherCooldowns()
    or (((not NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(1787))) or (NAG:RuneIsEquipped(432276) and (not NAG:AuraIsActive(1787)) and NAG:AuraIsActive(432276, "target"))) and NAG:Cast(233985)
    or (NAG:AuraIsKnown(1226843) and (not NAG:AuraIsActive(424785, "target")) and (not NAG:AuraIsActive(11275, "target")) and (not NAG:AuraIsActive(436611, "target")) and (NAG:CurrentComboPoints() <= 4)) and NAG:Cast(425012)
    or (NAG:AuraIsKnown(1226843) and (not NAG:AuraIsActive(424785, "target")) and (not NAG:AuraIsActive(11275, "target")) and (not NAG:AuraIsActive(436611, "target")) and (NAG:CurrentComboPoints() >= 1)) and NAG:Cast(412096)
    or ((NAG:CurrentComboPoints() <= 4) and ((NAG:AuraNumStacks(424785, "target") < 3) or (NAG:AuraRemainingTime(424785, "target") < 2)) and (NAG:AuraRemainingTime(424785, "target") < (NAG:RemainingTime() + 2))) and NAG:Cast(424785)
    or (((not NAG:RuneIsEquipped(432276)) and NAG:AuraIsActive(6774) and NAG:AuraIsActive(399963)) or (NAG:RuneIsEquipped(432276) and NAG:AuraIsActive(432276, "target") and NAG:AuraIsActive(6774) and NAG:AuraIsActive(399963))) and NAG:Cast(13877)
    or ((NAG:AuraNumStacks(1214170, "target") >= 4) and (NAG:CurrentComboPoints() < 5) and (NAG:CurrentEnergy() <= 75)) and NAG:Cast(425012)
    or (((not NAG:RuneIsEquipped(432271)) and (NAG:AuraRemainingTime(6774) <= 1) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 19)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 19) and (NAG:RemainingTime() >= 13)))) or (NAG:RuneIsEquipped(432271) and (not NAG:AuraIsActive(6774)) and (NAG:CurrentComboPoints() >= 1) and (NAG:RemainingTime() >= 10))) and NAG:Cast(6774)
    or ((NAG:AuraIsKnown(1226843) and NAG:AuraIsKnown(1232181) and (not NAG:RuneIsEquipped(432271)) and (not NAG:AuraIsActive(436611, "target")) and (NAG:CurrentComboPoints() >= 1) and (NAG:RemainingTime() >= 5)) or (NAG:AuraIsKnown(1226843) and (not NAG:RuneIsEquipped(432271)) and (not NAG:AuraIsActive(436611, "target")) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 11)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 11) and (NAG:RemainingTime() >= 7))))) and NAG:Cast(412096)
    or ((not NAG:AuraIsActive(425096)) and (NAG:CurrentEnergy() >= 35) and (NAG:CurrentComboPoints() >= 5) and NAG:GCDIsReady() and (NAG:AuraNumStacks(1214170, "target") >= 5)) and NAG:StrictSequence("foo", NAG:Cast(14177), NAG:Cast(1856), NAG:Cast(399963))
    or ((NAG:CurrentComboPoints() >= 4) or ((NAG:CurrentComboPoints() >= 3) and (NAG:RemainingTime() <= 4))) and NAG:Cast(399963)
    or ((NAG:AuraIsKnown(1226843) and (NAG:CurrentComboPoints() <= 4) and (NAG:CurrentEnergy() >= 75) and (NAG:AuraRemainingTime(424785, "target") >= 8) and (NAG:AuraNumStacks(424785, "target") >= 3)) or (NAG:AuraIsKnown(1226843) and (NAG:CurrentComboPoints() <= 2) and (NAG:AuraRemainingTime(424785, "target") >= 8) and (NAG:AuraNumStacks(424785, "target") >= 3)) or (NAG:AuraIsKnown(1226843) and (NAG:CurrentComboPoints() <= 2) and (NAG:RemainingTime() <= 4) and (NAG:AuraNumStacks(424785, "target") >= 3))) and NAG:Cast(11294)
    or ((NAG:CurrentComboPoints() <= 2) or ((NAG:CurrentComboPoints() <= 4) and (NAG:CurrentEnergy() >= 75))) and NAG:Cast(424785)
        ]],

    -- Tracked IDs for optimization
    spells = {1787, 1856, 6774, 11275, 11294, 13877, 14177, 399963, 412096, 424785, 425012, 425096, 432276, 436611, 1214170, 1226843, 1232181},
    items = {7676, 233985},
    auras = {},
    runes = {432271, 432276},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Assassination 1Target 3Min BiS Mutilate Phase8 ST rotation
local assassination1Target3MinBiSMutilatePhase8ST = {
    name = "Rogue Assassination - 1Target_3Min_BiS_Mutilate_Phase8_ST by APLParser",
    specIndex = 1,
    class = "ROGUE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -2.0, action = "NAG:Cast(6774)" },
        { time = -1.0, action = "NAG:Cast(13877)" }
    },
    rotationString = [[
((NAG:CurrentEnergy() <= 10) or ((NAG:RemainingTime() <= 20) and (NAG:CurrentEnergy() <= 40))) and NAG:Cast(7676)
    or NAG:AutocastOtherCooldowns()
    or (((not NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(1787))) or (NAG:RuneIsEquipped(432276) and NAG:AuraIsActive(432276, "target") and (not NAG:AuraIsActive(1787)))) and NAG:Cast(233985)
    or (((not NAG:RuneIsEquipped(432276)) and NAG:AuraIsActive(6774) and NAG:AuraIsActive(399963)) or (NAG:RuneIsEquipped(432276) and NAG:AuraIsActive(432276, "target") and NAG:AuraIsActive(6774) and NAG:AuraIsActive(399963))) and NAG:Cast(13877)
    or ((NAG:AuraIsKnown(1226843) and NAG:AuraIsKnown(1232181) and (not NAG:AuraIsActive(11275, "target")) and (NAG:CurrentComboPoints() >= 3) and (NAG:RemainingTime() >= 9)) or (NAG:AuraIsKnown(1226843) and (not NAG:AuraIsActive(11275, "target")) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 15)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 15) and (NAG:RemainingTime() >= 9))))) and NAG:Cast(11275)
    or (((not NAG:RuneIsEquipped(432271)) and (NAG:AuraRemainingTime(6774) <= 1) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 19)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 19) and (NAG:RemainingTime() >= 13)))) or (NAG:RuneIsEquipped(432271) and (not NAG:AuraIsActive(6774)) and (NAG:CurrentComboPoints() >= 1) and (NAG:RemainingTime() >= 10))) and NAG:Cast(6774)
    or ((NAG:AuraIsKnown(1232181) and (NAG:AuraIsKnown(1226843) or NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(436611, "target")) and (NAG:CurrentComboPoints() >= 1) and (NAG:RemainingTime() >= 5)) or ((NAG:AuraIsKnown(1226843) or NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(436611, "target")) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 11)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 11) and (NAG:RemainingTime() >= 7))))) and NAG:Cast(412096)
    or ((not NAG:AuraIsActive(425096)) and (NAG:CurrentEnergy() >= 35) and (NAG:CurrentComboPoints() >= 5) and NAG:GCDIsReady() and (NAG:AuraNumStacks(1214170, "target") >= 5)) and NAG:StrictSequence("foo", NAG:Cast(14177), NAG:Cast(1856), NAG:Cast(399963))
    or ((NAG:CurrentComboPoints() >= 4) or ((NAG:CurrentComboPoints() >= 3) and (NAG:RemainingTime() <= 4))) and NAG:Cast(399963)
    or (NAG:CurrentComboPoints() <= 3) and NAG:Cast(399956)
    or (((NAG:AuraNumStacks(1214170, "target") >= 4) and (NAG:CurrentComboPoints() < 5)) or (NAG:AuraRemainingTime(1214170, "target") <= 1)) and NAG:Cast(425012)
        ]],

    -- Tracked IDs for optimization
    spells = {1787, 1856, 6774, 11275, 13877, 14177, 399956, 399963, 412096, 425012, 425096, 432276, 436611, 1214170, 1226843, 1232181},
    items = {7676, 233985},
    auras = {},
    runes = {432271, 432276},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Subtlety 1Target 3Min Backstab BiS Phase8 ST rotation
local subtlety1Target3MinBackstabBiSPhase8ST = {
    name = "Rogue Subtlety - 1Target_3Min_Backstab_BiS_Phase8_ST by APLParser",
    specIndex = 3,
    class = "ROGUE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -1.0, action = "NAG:Cast(6774)" }
    },
    rotationString = [[
(((NAG:CurrentEnergy() <= 10) and (NAG:CurrentComboPoints() <= 4) and (NAG:TimeToEnergyTick() > 1)) or ((NAG:RemainingTime() <= 15) and (NAG:CurrentEnergy() <= 40) and (NAG:TimeToEnergyTick() > 1))) and NAG:Cast(7676)
    or (((NAG:CurrentEnergy() < 25) and (NAG:CurrentComboPoints() <= 4) and (NAG:TimeToEnergyTick() > 1) and (not NAG:AuraIsActive(467735)) and (not NAG:AuraIsActive(462707))) or ((NAG:RemainingTime() <= 15) and (NAG:CurrentEnergy() < 35) and (NAG:TimeToEnergyTick() > 1) and (not NAG:AuraIsActive(467735)) and (not NAG:AuraIsActive(462707)))) and NAG:Cast(231287)
    or NAG:AutocastOtherCooldowns()
    or (((not NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(1787))) or (NAG:RuneIsEquipped(432276) and NAG:AuraIsActive(432276, "target") and (not NAG:AuraIsActive(1787)))) and NAG:Cast(233985)
    or ((NAG:CurrentEnergy() >= 60) and NAG:AuraIsKnown(467735) and NAG:AuraIsActive(467735)) and NAG:Cast(25300)
    or ((NAG:AuraIsKnown(1232181) and NAG:AuraIsKnown(1226843) and (not NAG:AuraIsActive(11275, "target")) and (NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() > 9)) or (NAG:AuraIsKnown(1226843) and (not NAG:AuraIsActive(11275, "target")) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 15)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 15) and (NAG:RemainingTime() >= 9))))) and NAG:Cast(11275)
    or (((not NAG:RuneIsEquipped(432271)) and (NAG:AuraRemainingTime(6774) <= 1) and (not NAG:AuraIsActive(467735)) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 19)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 19) and (NAG:RemainingTime() >= 13)))) or (NAG:RuneIsEquipped(432271) and (not NAG:AuraIsActive(6774)) and (NAG:CurrentComboPoints() >= 1) and (not NAG:AuraIsActive(467735)) and (NAG:RemainingTime() >= 10))) and NAG:Cast(6774)
    or ((NAG:AuraIsKnown(1232181) and (not NAG:AuraIsActive(436611, "target")) and (NAG:CurrentComboPoints() >= 1) and (NAG:RemainingTime() > 5)) or ((NAG:AuraIsKnown(1226843) or NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(436611, "target")) and (((NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 11)) or ((NAG:CurrentComboPoints() >= 2) and (NAG:RemainingTime() < 11) and (NAG:RemainingTime() >= 7))))) and NAG:Cast(412096)
    or (((NAG:CurrentComboPoints() >= 5) or ((NAG:RemainingTime() <= 4) and (NAG:CurrentComboPoints() >= 4)))) and NAG:Cast(399963)
    or ((not NAG:AuraIsActive(462707)) and (not NAG:AuraIsActive(425096)) and (NAG:CurrentEnergy() >= 35) and (NAG:CurrentComboPoints() <= 2)) and NAG:Cast(1856)
    or NAG:Cast(11269)
    or NAG:Cast(25300)
    or (((NAG:AuraNumStacks(1214170, "target") >= 4) and (NAG:CurrentComboPoints() < 5))) and NAG:Cast(425012)
        ]],

    -- Tracked IDs for optimization
    spells = {1787, 1856, 6774, 11269, 11275, 25300, 399963, 412096, 425012, 425096, 432276, 436611, 462707, 467735, 1214170, 1226843, 1232181},
    items = {7676, 231287, 233985},
    auras = {},
    runes = {432271, 432276},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Assassination 2Target 1Min BiS Cleave Phase8 SaberSlash rotation
local assassination2Target1MinBiSCleavePhase8SaberSlash = {
    name = "Rogue Assassination - 2Target_1Min_BiS_Cleave_Phase8_SaberSlash by APLParser",
    specIndex = 1,
    class = "ROGUE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -2.0, action = "NAG:Cast(6774)" },
        { time = -1.0, action = "NAG:Cast(13877)" }
    },
    rotationString = [[
((NAG:CurrentEnergy() <= 10) or ((NAG:RemainingTime() <= 15) and (NAG:CurrentEnergy() <= 40))) and NAG:Cast(7676)
    or NAG:AutocastOtherCooldowns()
    or (((not NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(1787))) or (NAG:RuneIsEquipped(432276) and (not NAG:AuraIsActive(1787)) and NAG:AuraIsActive(432276, "target"))) and NAG:Cast(233985)
    or ((NAG:CurrentComboPoints() <= 4) and ((NAG:AuraNumStacks(424785, "target") < 3) or (NAG:AuraRemainingTime(424785, "target") < 2)) and (NAG:AuraRemainingTime(424785, "target") < (NAG:RemainingTime() + 2))) and NAG:Cast(424785)
    or (((not NAG:RuneIsEquipped(432276)) and NAG:AuraIsActive(6774) and NAG:AuraIsActive(399963)) or (NAG:RuneIsEquipped(432276) and NAG:AuraIsActive(432276, "target") and NAG:AuraIsActive(6774) and NAG:AuraIsActive(399963))) and NAG:Cast(13877)
    or ((NAG:AuraNumStacks(1214170, "target") >= 4) and (NAG:CurrentComboPoints() < 5) and (NAG:CurrentEnergy() <= 75)) and NAG:Cast(425012)
    or (((not NAG:RuneIsEquipped(432271)) and (NAG:AuraRemainingTime(6774) <= 1) and (NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 10)) or (NAG:RuneIsEquipped(432271) and (not NAG:AuraIsActive(6774)) and (NAG:CurrentComboPoints() >= 1))) and NAG:Cast(6774)
    or ((not NAG:AuraIsActive(425096)) and (NAG:CurrentEnergy() >= 35) and (NAG:CurrentComboPoints() == 5) and NAG:GCDIsReady() and (NAG:AuraNumStacks(1214170, "target") == 5)) and NAG:StrictSequence("foo", NAG:Cast(14177), NAG:Cast(1856), NAG:Cast(399963))
    or ((NAG:CurrentComboPoints() == 5) or ((NAG:CurrentComboPoints() >= 4) and (NAG:CurrentEnergy() >= 25)) or ((NAG:CurrentComboPoints() >= 3) and (NAG:RemainingTime() <= 4))) and NAG:Cast(399963)
    or ((NAG:CurrentComboPoints() <= 2) or ((NAG:CurrentComboPoints() <= 4) and (NAG:CurrentEnergy() >= 75))) and NAG:Cast(424785)
        ]],

    -- Tracked IDs for optimization
    spells = {1787, 1856, 6774, 13877, 14177, 399963, 424785, 425012, 425096, 432276, 1214170},
    items = {7676, 233985},
    auras = {},
    runes = {432271, 432276},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Assassination 2Target 1Min BiS Cleave Mutilate Phase8 rotation
local assassination2Target1MinBiSCleaveMutilatePhase8 = {
    name = "Rogue Assassination - 2Target_1Min_BiS_Cleave_Mutilate_Phase8 by APLParser",
    specIndex = 1,
    class = "ROGUE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -2.0, action = "NAG:Cast(6774)" },
        { time = -1.0, action = "NAG:Cast(13877)" }
    },
    rotationString = [[
((NAG:CurrentEnergy() <= 10) or ((NAG:RemainingTime() <= 20) and (NAG:CurrentEnergy() <= 40))) and NAG:Cast(7676)
    or NAG:AutocastOtherCooldowns()
    or (((not NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(1787))) or (NAG:RuneIsEquipped(432276) and NAG:AuraIsActive(432276, "target") and (not NAG:AuraIsActive(1787)))) and NAG:Cast(233985)
    or (((not NAG:RuneIsEquipped(432276)) and NAG:AuraIsActive(6774) and NAG:AuraIsActive(399963)) or (NAG:RuneIsEquipped(432276) and NAG:AuraIsActive(432276, "target") and NAG:AuraIsActive(6774) and NAG:AuraIsActive(399963))) and NAG:Cast(13877)
    or (((not NAG:RuneIsEquipped(432271)) and (NAG:AuraRemainingTime(6774) <= 1) and (NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 10)) or (NAG:RuneIsEquipped(432271) and (not NAG:AuraIsActive(6774)) and (NAG:CurrentComboPoints() >= 1))) and NAG:Cast(6774)
    or (NAG:RuneIsEquipped(432276) and (not NAG:AuraIsActive(432276, "target")) and (NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 5)) and NAG:Cast(412096)
    or ((not NAG:AuraIsActive(425096)) and (NAG:CurrentEnergy() >= 35) and (NAG:CurrentComboPoints() == 5) and NAG:GCDIsReady() and (NAG:AuraNumStacks(1214170, "target") == 5)) and NAG:StrictSequence("foo", NAG:Cast(14177), NAG:Cast(1856), NAG:Cast(399963))
    or ((NAG:CurrentComboPoints() >= 5) or ((NAG:CurrentComboPoints() >= 4) and (NAG:CurrentEnergy() >= 25)) or ((NAG:CurrentComboPoints() >= 3) and (NAG:RemainingTime() <= 4))) and NAG:Cast(399963)
    or (NAG:CurrentComboPoints() <= 3) and NAG:Cast(399956)
    or (((NAG:AuraNumStacks(1214170, "target") >= 4) and (NAG:CurrentComboPoints() < 5)) or (NAG:AuraRemainingTime(1214170, "target") <= 1)) and NAG:Cast(425012)
        ]],

    -- Tracked IDs for optimization
    spells = {1787, 1856, 6774, 13877, 14177, 399956, 399963, 412096, 425012, 425096, 432276, 1214170},
    items = {7676, 233985},
    auras = {},
    runes = {432271, 432276},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Subtlety 2Target 1Min Backstab BiS Cleave Phase8 rotation
local subtlety2Target1MinBackstabBiSCleavePhase8 = {
    name = "Rogue Subtlety - 2Target_1Min_Backstab_BiS_Cleave_Phase8 by APLParser",
    specIndex = 3,
    class = "ROGUE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -1.0, action = "NAG:Cast(6774)" }
    },
    rotationString = [[
(((NAG:CurrentEnergy() <= 10) and (NAG:CurrentComboPoints() <= 4) and (NAG:TimeToEnergyTick() > 1)) or ((NAG:RemainingTime() <= 15) and (NAG:CurrentEnergy() <= 40) and (NAG:TimeToEnergyTick() > 1))) and NAG:Cast(7676)
    or (((NAG:CurrentEnergy() < 25) and (NAG:CurrentComboPoints() <= 4) and (NAG:TimeToEnergyTick() > 1) and (not NAG:AuraIsActive(467735)) and (not NAG:AuraIsActive(462707))) or ((NAG:RemainingTime() <= 15) and (NAG:CurrentEnergy() < 35) and (NAG:TimeToEnergyTick() > 1) and (not NAG:AuraIsActive(467735)) and (not NAG:AuraIsActive(462707)))) and NAG:Cast(231287)
    or NAG:AutocastOtherCooldowns()
    or (((not NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(1787))) or (NAG:RuneIsEquipped(432276) and NAG:AuraIsActive(432276, "target") and (not NAG:AuraIsActive(1787)))) and NAG:Cast(233985)
    or ((NAG:CurrentEnergy() >= 60) and NAG:AuraIsActive(467735)) and NAG:Cast(25300)
    or (((NAG:CurrentComboPoints() >= 5) and (NAG:RemainingTime() > 12) and (not NAG:AuraIsActive(436611, "target"))) or ((NAG:CurrentComboPoints() >= 3) and (NAG:RemainingTime() >= 6) and (NAG:RemainingTime() <= 12) and (not NAG:AuraIsActive(432276, "target")))) and NAG:Cast(412096)
    or (((not NAG:RuneIsEquipped(432271)) and (NAG:AuraRemainingTime(6774) <= 1) and (NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 10) and (not NAG:AuraIsActive(467735))) or (NAG:RuneIsEquipped(432271) and (not NAG:AuraIsActive(6774)) and (NAG:CurrentComboPoints() >= 1) and (not NAG:AuraIsActive(467735)))) and NAG:Cast(6774)
    or (((NAG:CurrentComboPoints() >= 5) and (NAG:RemainingTime() > 16) and (not NAG:AuraIsActive(11275, "target"))) or ((NAG:CurrentComboPoints() >= 3) and (NAG:RemainingTime() >= 10) and (NAG:RemainingTime() <= 16) and (not NAG:AuraIsActive(11275, "target")))) and NAG:Cast(11275)
    or ((NAG:AuraNumStacks(1214170, "target") >= 4) and ((NAG:CurrentComboPoints() >= 5) or ((NAG:RemainingTime() <= 4) and (NAG:CurrentComboPoints() >= 4)))) and NAG:Cast(399963)
    or ((not NAG:AuraIsActive(462707)) and (not NAG:AuraIsActive(425096)) and (NAG:CurrentEnergy() >= 35) and (NAG:CurrentComboPoints() <= 2)) and NAG:Cast(1856)
    or NAG:Cast(11269)
    or NAG:Cast(25300)
    or (not NAG:SpellIsReady(1856)) and NAG:Cast(14185)
    or (((NAG:AuraNumStacks(1214170, "target") >= 4) and (NAG:CurrentComboPoints() < 5)) or (NAG:AuraRemainingTime(1214170, "target") <= 1)) and NAG:Cast(425012)
        ]],

    -- Tracked IDs for optimization
    spells = {1787, 1856, 6774, 11269, 11275, 14185, 25300, 399963, 412096, 425012, 425096, 432276, 436611, 462707, 467735, 1214170},
    items = {7676, 231287, 233985},
    auras = {},
    runes = {432271, 432276},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Assassination 3Target 1Min BiS Cleave Phase8 SaberSlash rotation
local assassination3Target1MinBiSCleavePhase8SaberSlash = {
    name = "Rogue Assassination - 3Target_1Min_BiS_Cleave_Phase8_SaberSlash by APLParser",
    specIndex = 1,
    class = "ROGUE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -2.0, action = "NAG:Cast(6774)" },
        { time = -1.0, action = "NAG:Cast(13877)" }
    },
    rotationString = [[
((NAG:CurrentEnergy() <= 10) or ((NAG:RemainingTime() <= 15) and (NAG:CurrentEnergy() <= 40))) and NAG:Cast(7676)
    or NAG:AutocastOtherCooldowns()
    or (((not NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(1787))) or (NAG:RuneIsEquipped(432276) and (not NAG:AuraIsActive(1787)) and NAG:AuraIsActive(432276, "target"))) and NAG:Cast(233985)
    or ((NAG:CurrentComboPoints() <= 4) and ((NAG:AuraNumStacks(424785, "target") < 3) or (NAG:AuraRemainingTime(424785, "target") < 2)) and (NAG:AuraRemainingTime(424785, "target") < (NAG:RemainingTime() + 2))) and NAG:Cast(424785)
    or (((not NAG:RuneIsEquipped(432276)) and NAG:AuraIsActive(6774) and NAG:AuraIsActive(399963)) or (NAG:RuneIsEquipped(432276) and NAG:AuraIsActive(432276, "target") and NAG:AuraIsActive(6774) and NAG:AuraIsActive(399963))) and NAG:Cast(13877)
    or ((NAG:AuraNumStacks(1214170, "target") >= 4) and (NAG:CurrentComboPoints() < 5) and (NAG:CurrentEnergy() <= 75)) and NAG:Cast(425012)
    or (((not NAG:RuneIsEquipped(432271)) and (NAG:AuraRemainingTime(6774) <= 1) and (NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 10)) or (NAG:RuneIsEquipped(432271) and (not NAG:AuraIsActive(6774)) and (NAG:CurrentComboPoints() >= 1))) and NAG:Cast(6774)
    or ((not NAG:AuraIsActive(425096)) and (NAG:CurrentEnergy() >= 35) and (NAG:CurrentComboPoints() == 5) and NAG:GCDIsReady() and (NAG:AuraNumStacks(1214170, "target") == 5)) and NAG:StrictSequence("foo", NAG:Cast(14177), NAG:Cast(1856), NAG:Cast(399963))
    or ((NAG:CurrentComboPoints() == 5) or ((NAG:CurrentComboPoints() >= 4) and (NAG:CurrentEnergy() >= 25)) or ((NAG:CurrentComboPoints() >= 3) and (NAG:RemainingTime() <= 4))) and NAG:Cast(399963)
    or ((NAG:CurrentComboPoints() <= 2) or ((NAG:CurrentComboPoints() <= 4) and (NAG:CurrentEnergy() >= 75))) and NAG:Cast(424785)
        ]],

    -- Tracked IDs for optimization
    spells = {1787, 1856, 6774, 13877, 14177, 399963, 424785, 425012, 425096, 432276, 1214170},
    items = {7676, 233985},
    auras = {},
    runes = {432271, 432276},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Assassination 3Target 1Min BiS Cleave Mutilate Phase8 rotation
local assassination3Target1MinBiSCleaveMutilatePhase8 = {
    name = "Rogue Assassination - 3Target_1Min_BiS_Cleave_Mutilate_Phase8 by APLParser",
    specIndex = 1,
    class = "ROGUE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -2.0, action = "NAG:Cast(6774)" },
        { time = -1.0, action = "NAG:Cast(13877)" }
    },
    rotationString = [[
((NAG:CurrentEnergy() <= 10) or ((NAG:RemainingTime() <= 20) and (NAG:CurrentEnergy() <= 40))) and NAG:Cast(7676)
    or NAG:AutocastOtherCooldowns()
    or (((not NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(1787))) or (NAG:RuneIsEquipped(432276) and NAG:AuraIsActive(432276, "target") and (not NAG:AuraIsActive(1787)))) and NAG:Cast(233985)
    or (((not NAG:RuneIsEquipped(432276)) and NAG:AuraIsActive(6774) and NAG:AuraIsActive(399963)) or (NAG:RuneIsEquipped(432276) and NAG:AuraIsActive(432276, "target") and NAG:AuraIsActive(6774) and NAG:AuraIsActive(399963))) and NAG:Cast(13877)
    or (((not NAG:RuneIsEquipped(432271)) and (NAG:AuraRemainingTime(6774) <= 1) and (NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 10)) or (NAG:RuneIsEquipped(432271) and (not NAG:AuraIsActive(6774)) and (NAG:CurrentComboPoints() >= 1))) and NAG:Cast(6774)
    or (NAG:RuneIsEquipped(432276) and (not NAG:AuraIsActive(432276, "target")) and (NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 5)) and NAG:Cast(412096)
    or ((not NAG:AuraIsActive(425096)) and (NAG:CurrentEnergy() >= 35) and (NAG:CurrentComboPoints() == 5) and NAG:GCDIsReady() and (NAG:AuraNumStacks(1214170, "target") == 5)) and NAG:StrictSequence("foo", NAG:Cast(14177), NAG:Cast(1856), NAG:Cast(399963))
    or ((NAG:CurrentComboPoints() >= 5) or ((NAG:CurrentComboPoints() >= 4) and (NAG:CurrentEnergy() >= 25)) or ((NAG:CurrentComboPoints() >= 3) and (NAG:RemainingTime() <= 4))) and NAG:Cast(399963)
    or (NAG:CurrentComboPoints() <= 3) and NAG:Cast(399956)
    or (((NAG:AuraNumStacks(1214170, "target") >= 4) and (NAG:CurrentComboPoints() < 5)) or (NAG:AuraRemainingTime(1214170, "target") <= 1)) and NAG:Cast(425012)
        ]],

    -- Tracked IDs for optimization
    spells = {1787, 1856, 6774, 13877, 14177, 399956, 399963, 412096, 425012, 425096, 432276, 1214170},
    items = {7676, 233985},
    auras = {},
    runes = {432271, 432276},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Subtlety 3Target 1Min Backstab BiS Cleave Phase8 rotation
local subtlety3Target1MinBackstabBiSCleavePhase8 = {
    name = "Rogue Subtlety - 3Target_1Min_Backstab_BiS_Cleave_Phase8 by APLParser",
    specIndex = 3,
    class = "ROGUE",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -1.0, action = "NAG:Cast(6774)" }
    },
    rotationString = [[
(((NAG:CurrentEnergy() <= 10) and (NAG:CurrentComboPoints() <= 4) and (NAG:TimeToEnergyTick() > 1)) or ((NAG:RemainingTime() <= 15) and (NAG:CurrentEnergy() <= 40) and (NAG:TimeToEnergyTick() > 1))) and NAG:Cast(7676)
    or (((NAG:CurrentEnergy() < 25) and (NAG:CurrentComboPoints() <= 4) and (NAG:TimeToEnergyTick() > 1) and (not NAG:AuraIsActive(467735)) and (not NAG:AuraIsActive(462707))) or ((NAG:RemainingTime() <= 15) and (NAG:CurrentEnergy() < 35) and (NAG:TimeToEnergyTick() > 1) and (not NAG:AuraIsActive(467735)) and (not NAG:AuraIsActive(462707)))) and NAG:Cast(231287)
    or NAG:AutocastOtherCooldowns()
    or (((not NAG:RuneIsEquipped(432276)) and (not NAG:AuraIsActive(1787))) or (NAG:RuneIsEquipped(432276) and NAG:AuraIsActive(432276, "target") and (not NAG:AuraIsActive(1787)))) and NAG:Cast(233985)
    or ((NAG:CurrentEnergy() >= 60) and NAG:AuraIsActive(467735)) and NAG:Cast(25300)
    or (((NAG:CurrentComboPoints() >= 5) and (NAG:RemainingTime() > 12) and (not NAG:AuraIsActive(436611, "target"))) or ((NAG:CurrentComboPoints() >= 3) and (NAG:RemainingTime() >= 6) and (NAG:RemainingTime() <= 12) and (not NAG:AuraIsActive(432276, "target")))) and NAG:Cast(412096)
    or (((not NAG:RuneIsEquipped(432271)) and (NAG:AuraRemainingTime(6774) <= 1) and (NAG:CurrentComboPoints() >= 4) and (NAG:RemainingTime() >= 10) and (not NAG:AuraIsActive(467735))) or (NAG:RuneIsEquipped(432271) and (not NAG:AuraIsActive(6774)) and (NAG:CurrentComboPoints() >= 1) and (not NAG:AuraIsActive(467735)))) and NAG:Cast(6774)
    or (((NAG:CurrentComboPoints() >= 5) and (NAG:RemainingTime() > 16) and (not NAG:AuraIsActive(11275, "target"))) or ((NAG:CurrentComboPoints() >= 3) and (NAG:RemainingTime() >= 10) and (NAG:RemainingTime() <= 16) and (not NAG:AuraIsActive(11275, "target")))) and NAG:Cast(11275)
    or ((NAG:AuraNumStacks(1214170, "target") >= 4) and ((NAG:CurrentComboPoints() >= 5) or ((NAG:RemainingTime() <= 4) and (NAG:CurrentComboPoints() >= 4)))) and NAG:Cast(399963)
    or ((not NAG:AuraIsActive(462707)) and (not NAG:AuraIsActive(425096)) and (NAG:CurrentEnergy() >= 35) and (NAG:CurrentComboPoints() <= 2)) and NAG:Cast(1856)
    or NAG:Cast(11269)
    or NAG:Cast(25300)
    or (not NAG:SpellIsReady(1856)) and NAG:Cast(14185)
    or (((NAG:AuraNumStacks(1214170, "target") >= 4) and (NAG:CurrentComboPoints() < 5)) or (NAG:AuraRemainingTime(1214170, "target") <= 1)) and NAG:Cast(425012)
        ]],

    -- Tracked IDs for optimization
    spells = {1787, 1856, 6774, 11269, 11275, 14185, 25300, 399963, 412096, 425012, 425096, 432276, 436611, 462707, 467735, 1214170},
    items = {7676, 231287, 233985},
    auras = {},
    runes = {432271, 432276},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

--- @class ROGUE : ClassBase
local ROGUE = NAG:CreateClassModule("ROGUE", defaults)

--- Setup class defaults with all rotations
function ROGUE:SetupClassDefaults()
    -- Add all rotation definitions to defaults
    ns.AddRotationToDefaults(self.defaults, 1, assassination3MinPhase8PreRaidSaberSlash)  -- assassination3MinPhase8PreRaidSaberSlash)
    ns.AddRotationToDefaults(self.defaults, 1, assassination3MinMutilatePhase8PreRaid)  -- assassination3MinMutilatePhase8PreRaid)
    ns.AddRotationToDefaults(self.defaults, 3, subtlety3MinBackstabPhase8PreRaid)  -- subtlety3MinBackstabPhase8PreRaid)
    ns.AddRotationToDefaults(self.defaults, 1, assassination5MinPhase8PreRaidSaberSlash)  -- assassination5MinPhase8PreRaidSaberSlash)
    ns.AddRotationToDefaults(self.defaults, 3, subtlety5MinPhase8PreRaidSaberSlash)  -- subtlety5MinPhase8PreRaidSaberSlash)
    ns.AddRotationToDefaults(self.defaults, 1, assassination5MinMutilatePhase8PreRaid)  -- assassination5MinMutilatePhase8PreRaid)
    ns.AddRotationToDefaults(self.defaults, 3, subtlety5MinBackstabPhase8PreRaid)  -- subtlety5MinBackstabPhase8PreRaid)
    ns.AddRotationToDefaults(self.defaults, 1, assassination1Target1MinBiSPhase8STSaberSlash)  -- assassination1Target1MinBiSPhase8STSaberSlash)
    ns.AddRotationToDefaults(self.defaults, 1, assassination1Target1MinBiSMutilatePhase8ST)  -- assassination1Target1MinBiSMutilatePhase8ST)
    ns.AddRotationToDefaults(self.defaults, 3, subtlety1Target1MinBackstabBiSPhase8ST)  -- subtlety1Target1MinBackstabBiSPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 1, assassination1Target2MinBiSPhase8STSaberSlash)  -- assassination1Target2MinBiSPhase8STSaberSlash)
    ns.AddRotationToDefaults(self.defaults, 3, subtlety1Target2MinBackstabBiSPhase8ST)  -- subtlety1Target2MinBackstabBiSPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 1, assassination1Target2MinBiSMutilatePhase8ST)  -- assassination1Target2MinBiSMutilatePhase8ST)
    ns.AddRotationToDefaults(self.defaults, 1, assassination1Target3MinBiSMutilatePhase8ST)  -- assassination1Target3MinBiSMutilatePhase8ST)
    ns.AddRotationToDefaults(self.defaults, 3, subtlety1Target3MinBackstabBiSPhase8ST)  -- subtlety1Target3MinBackstabBiSPhase8ST)
    ns.AddRotationToDefaults(self.defaults, 1, assassination2Target1MinBiSCleavePhase8SaberSlash)  -- assassination2Target1MinBiSCleavePhase8SaberSlash)
    ns.AddRotationToDefaults(self.defaults, 1, assassination2Target1MinBiSCleaveMutilatePhase8)  -- assassination2Target1MinBiSCleaveMutilatePhase8)
    ns.AddRotationToDefaults(self.defaults, 3, subtlety2Target1MinBackstabBiSCleavePhase8)  -- subtlety2Target1MinBackstabBiSCleavePhase8)
    ns.AddRotationToDefaults(self.defaults, 1, assassination3Target1MinBiSCleavePhase8SaberSlash)  -- assassination3Target1MinBiSCleavePhase8SaberSlash)
    ns.AddRotationToDefaults(self.defaults, 1, assassination3Target1MinBiSCleaveMutilatePhase8)  -- assassination3Target1MinBiSCleaveMutilatePhase8)
    ns.AddRotationToDefaults(self.defaults, 3, subtlety3Target1MinBackstabBiSCleavePhase8)  -- subtlety3Target1MinBackstabBiSCleavePhase8)
end

if not ROGUE then return end
NAG.Class = ROGUE
