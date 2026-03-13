local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
if not Version:IsSoD() then return end

if UnitClassBase('player') ~= "DRUID" then return end
--- NAG

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
        id = "faerie_fire",
        name = "Faerie Fire",
        description = "Apply armor reduction debuff on targets (conflicts with Sunder Armor/Expose Armor)",
        spellIds = {770, 778, 9749, 9907}, -- All ranks (includes Feral version)
        category = "debuff",
    },
    {
        id = "mark_of_the_wild",
        name = "Mark of the Wild",
        description = "Provide stats buff to raid (coordinate with other Druids)",
        spellIds = {1126, 5232, 6756, 5234, 8907, 9884, 9885}, -- All ranks
        category = "buff",
    },
    {
        id = "innervate",
        name = "Innervate",
        description = "Provide mana regeneration (coordinate with other healers/Druids)",
        spellIds = {29166}, -- Innervate
        category = "utility",
    },
}

-- Balance Druid - 3Min_Balance_Phase8_PreRaid by APLParser
local balanceRotation = {
    name = "Druid Balance - 3Min_Balance_Phase8_PreRaid by APLParser",
    specIndex = 1,
    class = "DRUID",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -3.5, action = "NAG:Cast(417157)" },
        { time = -2.0, action = "NAG:Cast(9912)" }
    },
    rotationString = [[
NAG:AuraIsActive(417157) and NAG:AutocastOtherCooldowns()
    or (not NAG:AuraIsActive(417157)) and NAG:Cast(417157)
    or NAG:Multidot(9835, 2, 0.0)
    or NAG:Multidot(414684, 2, 0.0)
    or NAG:Cast(439748)
    or (NAG:SpellTimeToReady(417157) > 2.5) and NAG:Cast(9912)
    or (NAG:AuraIsActive(417157) or (NAG:AuraNumStacks(408255) >= 1)) and NAG:Cast(25298)
    or NAG:SpellCanCast(9912) and NAG:Cast(9912)
    ]],

    -- Tracked IDs for optimization
    spells = {9835, 9912, 25298, 408255, 414684, 417157, 439748},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Feral Druid - 3Min_Feral_Phase8_PreRaid by APLParser
local feralRotation = {
    name = "Druid Feral - 3Min_Feral_Phase8_PreRaid by APLParser",
    specIndex = 2,
    class = "DRUID",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(768)" },
        { time = -2.0, action = "NAG:Cast(1213366)" },
        { time = -1.5, action = "NAG:Cast(17392)" }
    },
    rotationString = [[
((NAG:AuraRemainingTime(17392, "target") <= 1.0) and (NAG:AuraRemainingTime(9907, "target") <= 1.0)) and NAG:Cast(17392)
    or (not NAG:AuraIsActive(407988)) and NAG:Cast(407988)
    or (not NAG:AuraIsActive(1213366)) and NAG:Cast(1213366)
    or ((NAG:CatEnergyAfterDuration(NAG:GCDTimeToReady()) + 60.0) <= NAG:MaxEnergy()) and NAG:Cast(417045)
    or ((not NAG:AuraIsActive(417045)) and ((NAG:CatEnergyAfterDuration(NAG:GCDTimeToReady()) <= (NAG:MaxEnergy() - 40.0)) or ((NAG:AuraIsKnown(1218476) or NAG:AuraIsKnown(1226116)) and (not NAG:DotIsActive(9904)) and NAG:AuraIsActive(407988)))) and NAG:Cast(417045)
    or ((not NAG:RuneIsEquipped(417046)) or NAG:AuraIsActive(417045)) and NAG:AutocastOtherCooldowns()
    or (not NAG:AuraIsActive(409828, "target")) and NAG:Cast(409828)
    or ((not NAG:DotIsActive(9896)) and (NAG:CurrentComboPoints() == 5) and (NAG:RemainingTime() >= 10) and ((NAG:AuraRemainingTime(407988) >= 6.0) or NAG:AuraIsKnown(455873))) and NAG:Cast(9896)
    or (NAG:AuraIsKnown(1226119) and NAG:AuraIsActive(417045) and (NAG:CurrentComboPoints() == 5.0) and (NAG:AuraRemainingTime(407988) <= 4.0)) and NAG:Cast(407988)
    or (NAG:AuraIsKnown(1226119) and NAG:AuraIsActive(417045) and (((NAG:AuraRemainingTime(417045) <= 1.0) and (NAG:CurrentComboPoints() >= 4.0)) or ((NAG:AuraRemainingTime(417045) < 2.0) and (NAG:CurrentComboPoints() == 5.0)))) and NAG:Cast(31018)
    or (NAG:AuraIsKnown(16870) and NAG:AuraIsActive(16870) and (NAG:NumberTargets() >= 4.0)) and NAG:Cast(411128)
    or (NAG:AuraIsKnown(16870) and NAG:AuraIsActive(16870)) and NAG:Cast(9830)
    or ((not NAG:DotIsActive(9904)) and ((NAG:AuraIsKnown(1218476) and (NAG:RemainingTime() >= 4.0)) or (NAG:RemainingTime() >= 9.0)) and (not (NAG:RuneIsEquipped(417046) and (not NAG:AuraIsActive(417045)) and NAG:AuraIsKnown(1218476) and (NAG:SpellTimeToReady(417045) < 3.0)))) and NAG:Cast(9904)
    or ((NAG:CurrentComboPoints() == 5.0) and (NAG:AuraRemainingTime(407988) >= 4.0) and ((NAG:AuraIsKnown(1231381) and NAG:AuraIsActive(1231381)) or (NAG:RemainingTime() <= 6.0) or (NAG:AuraRemainingTime(9896, "target") >= 10.0)) and (NAG:AuraIsKnown(470270) or (NAG:CurrentEnergy() <= (NAG:SpellCurrentCost(31018) + 10.0)))) and NAG:Cast(31018)
    or ((NAG:NumberTargets() >= 4.0)) and NAG:Cast(411128)
    or NAG:AuraIsActive(417141) and NAG:Cast(9830)
    or (NAG:CatEnergyAfterDuration(NAG:DotRemainingTime(9904)) >= (NAG:SpellCurrentCost(409828) + NAG:SpellCurrentCost(9904))) and NAG:Cast(409828)
    or ((NAG:AuraRemainingTime(17392, "target") <= 12.0) and (NAG:AuraRemainingTime(9907, "target") <= 12.0)) and NAG:Cast(17392)
    or (not NAG:AuraIsActive(768)) and NAG:Cast(768)
    ]],

    -- Tracked IDs for optimization
    spells = {768, 9830, 9896, 9904, 9907, 16870, 17392, 31018, 407988, 409828, 411128, 417045, 417141, 455873, 470270, 1213366, 1218476, 1226116, 1226119, 1231381},
    items = {},
    auras = {},
    runes = {417046},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Balance Druid - 5Min_Balance_Phase8_PreRaid by APLParser
local balanceRotation5Min = {
    name = "Druid Balance - 5Min_Balance_Phase8_PreRaid by APLParser",
    specIndex = 1,
    class = "DRUID",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -3.5, action = "NAG:Cast(417157)" },
        { time = -2.0, action = "NAG:Cast(9912)" }
    },
    rotationString = [[
NAG:AuraIsActive(417157) and NAG:AutocastOtherCooldowns()
    or (not NAG:AuraIsActive(417157)) and NAG:Cast(417157)
    or NAG:Multidot(9835, 2, 0.0)
    or NAG:Multidot(414684, 2, 0.0)
    or NAG:Cast(439748)
    or (NAG:SpellTimeToReady(417157) > 2.5) and NAG:Cast(9912)
    or (NAG:AuraIsActive(417157) or (NAG:AuraNumStacks(408255) >= 1)) and NAG:Cast(25298)
    or NAG:SpellCanCast(9912) and NAG:Cast(9912)
    ]],

    -- Tracked IDs for optimization
    spells = {9835, 9912, 25298, 408255, 414684, 417157, 439748},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Feral Druid - 5Min_Feral_Phase8_PreRaid by APLParser
local feralRotation5Min = {
    name = "Druid Feral - 5Min_Feral_Phase8_PreRaid by APLParser",
    specIndex = 2,
    class = "DRUID",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(768)" },
        { time = -2.0, action = "NAG:Cast(1213366)" },
        { time = -1.5, action = "NAG:Cast(17392)" }
    },
    rotationString = [[
((NAG:AuraRemainingTime(17392, "target") <= 1.0) and (NAG:AuraRemainingTime(9907, "target") <= 1.0)) and NAG:Cast(17392)
    or (not NAG:AuraIsActive(407988)) and NAG:Cast(407988)
    or (not NAG:AuraIsActive(1213366)) and NAG:Cast(1213366)
    or ((NAG:CatEnergyAfterDuration(NAG:GCDTimeToReady()) + 60.0) <= NAG:MaxEnergy()) and NAG:Cast(417045)
    or ((not NAG:AuraIsActive(417045)) and ((NAG:CatEnergyAfterDuration(NAG:GCDTimeToReady()) <= (NAG:MaxEnergy() - 40.0)) or ((NAG:AuraIsKnown(1218476) or NAG:AuraIsKnown(1226116)) and (not NAG:DotIsActive(9904)) and NAG:AuraIsActive(407988)))) and NAG:Cast(417045)
    or ((not NAG:RuneIsEquipped(417046)) or NAG:AuraIsActive(417045)) and NAG:AutocastOtherCooldowns()
    or (not NAG:AuraIsActive(409828, "target")) and NAG:Cast(409828)
    or ((not NAG:DotIsActive(9896)) and (NAG:CurrentComboPoints() == 5) and (NAG:RemainingTime() >= 10) and ((NAG:AuraRemainingTime(407988) >= 6.0) or NAG:AuraIsKnown(455873))) and NAG:Cast(9896)
    or (NAG:AuraIsKnown(1226119) and NAG:AuraIsActive(417045) and (NAG:CurrentComboPoints() == 5.0) and (NAG:AuraRemainingTime(407988) <= 4.0)) and NAG:Cast(407988)
    or (NAG:AuraIsKnown(1226119) and NAG:AuraIsActive(417045) and (((NAG:AuraRemainingTime(417045) <= 1.0) and (NAG:CurrentComboPoints() >= 4.0)) or ((NAG:AuraRemainingTime(417045) < 2.0) and (NAG:CurrentComboPoints() == 5.0)))) and NAG:Cast(31018)
    or (NAG:AuraIsKnown(16870) and NAG:AuraIsActive(16870) and (NAG:NumberTargets() >= 4.0)) and NAG:Cast(411128)
    or (NAG:AuraIsKnown(16870) and NAG:AuraIsActive(16870)) and NAG:Cast(9830)
    or ((not NAG:DotIsActive(9904)) and ((NAG:AuraIsKnown(1218476) and (NAG:RemainingTime() >= 4.0)) or (NAG:RemainingTime() >= 9.0)) and (not (NAG:RuneIsEquipped(417046) and (not NAG:AuraIsActive(417045)) and NAG:AuraIsKnown(1218476) and (NAG:SpellTimeToReady(417045) < 3.0)))) and NAG:Cast(9904)
    or ((NAG:CurrentComboPoints() == 5.0) and (NAG:AuraRemainingTime(407988) >= 4.0) and ((NAG:AuraIsKnown(1231381) and NAG:AuraIsActive(1231381)) or (NAG:RemainingTime() <= 6.0) or (NAG:AuraRemainingTime(9896, "target") >= 10.0)) and (NAG:AuraIsKnown(470270) or (NAG:CurrentEnergy() <= (NAG:SpellCurrentCost(31018) + 10.0)))) and NAG:Cast(31018)
    or ((NAG:NumberTargets() >= 4.0)) and NAG:Cast(411128)
    or NAG:AuraIsActive(417141) and NAG:Cast(9830)
    or (NAG:CatEnergyAfterDuration(NAG:DotRemainingTime(9904)) >= (NAG:SpellCurrentCost(409828) + NAG:SpellCurrentCost(9904))) and NAG:Cast(409828)
    or ((NAG:AuraRemainingTime(17392, "target") <= 12.0) and (NAG:AuraRemainingTime(9907, "target") <= 12.0)) and NAG:Cast(17392)
    or (not NAG:AuraIsActive(768)) and NAG:Cast(768)
    ]],

    -- Tracked IDs for optimization
    spells = {768, 9830, 9896, 9904, 9907, 16870, 17392, 31018, 407988, 409828, 411128, 417045, 417141, 455873, 470270, 1213366, 1218476, 1226116, 1226119, 1231381},
    items = {},
    auras = {},
    runes = {417046},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Feral Druid - 1Target_1Min_BiS_Feral_Phase8_ST by APLParser
local feralRotation1Target1Min = {
    name = "Druid Feral - 1Target_1Min_BiS_Feral_Phase8_ST by APLParser",
    specIndex = 2,
    class = "DRUID",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(768)" },
        { time = -2.0, action = "NAG:Cast(1213366)" },
        { time = -1.5, action = "NAG:Cast(17392)" }
    },
    rotationString = [[
((NAG:AuraRemainingTime(17392, "target") <= 1.0) and (NAG:AuraRemainingTime(9907, "target") <= 1.0)) and NAG:Cast(17392)
    or (not NAG:AuraIsActive(407988)) and NAG:Cast(407988)
    or (not NAG:AuraIsActive(1213366)) and NAG:Cast(1213366)
    or ((NAG:CatEnergyAfterDuration(NAG:GCDTimeToReady()) + 60.0) <= NAG:MaxEnergy()) and NAG:Cast(417045)
    or ((not NAG:AuraIsActive(417045)) and ((NAG:CatEnergyAfterDuration(NAG:GCDTimeToReady()) <= (NAG:MaxEnergy() - 40.0)) or ((NAG:AuraIsKnown(1218476) or NAG:AuraIsKnown(1226116)) and (not NAG:DotIsActive(9904)) and NAG:AuraIsActive(407988)))) and NAG:Cast(417045)
    or (NAG:AuraIsActive(417045) or (not NAG:RuneIsEquipped(417046))) and NAG:AutocastOtherCooldowns()
    or ((NAG:AuraIsActive(417045) or (not NAG:RuneIsEquipped(417046))) and (not NAG:AuraIsKnown(241037))) and NAG:Cast(213407)
    or (NAG:AuraIsActive(241037) or (NAG:RemainingTime() < 40.0)) and NAG:Cast(213407)
    or (not NAG:AuraIsActive(409828, "target")) and NAG:Cast(409828)
    or ((not NAG:DotIsActive(9896)) and (NAG:CurrentComboPoints() == 5) and (NAG:RemainingTime() >= 10) and ((NAG:AuraRemainingTime(407988) >= 6.0) or NAG:AuraIsKnown(455873))) and NAG:Cast(9896)
    or (NAG:AuraIsKnown(1226119) and NAG:AuraIsActive(417045) and (NAG:CurrentComboPoints() == 5.0) and (NAG:AuraRemainingTime(407988) <= 4.0)) and NAG:Cast(407988)
    or (NAG:AuraIsKnown(1226119) and NAG:AuraIsActive(417045) and (((NAG:AuraRemainingTime(417045) <= 1.0) and (NAG:CurrentComboPoints() >= 4.0)) or ((NAG:AuraRemainingTime(417045) < 2.0) and (NAG:CurrentComboPoints() == 5.0)))) and NAG:Cast(31018)
    or (NAG:AuraIsKnown(16870) and NAG:AuraIsActive(16870) and (NAG:NumberTargets() >= 4.0)) and NAG:Cast(411128)
    or (NAG:AuraIsKnown(16870) and NAG:AuraIsActive(16870)) and NAG:Cast(9830)
    or ((not NAG:DotIsActive(9904)) and ((NAG:AuraIsKnown(1218476) and (NAG:RemainingTime() >= 4.0)) or (NAG:RemainingTime() >= 9.0)) and (not (NAG:RuneIsEquipped(417046) and (not NAG:AuraIsActive(417045)) and NAG:AuraIsKnown(1218476) and (NAG:SpellTimeToReady(417045) < 3.0)))) and NAG:Cast(9904)
    or ((NAG:CurrentComboPoints() == 5.0) and (NAG:AuraRemainingTime(407988) >= 4.0) and ((NAG:AuraIsKnown(1231381) and NAG:AuraIsActive(1231381)) or (NAG:RemainingTime() <= 6.0) or (NAG:AuraRemainingTime(9896, "target") >= 10.0)) and (NAG:AuraIsKnown(470270) or (NAG:CurrentEnergy() <= (NAG:SpellCurrentCost(31018) + 10.0)))) and NAG:Cast(31018)
    or ((NAG:NumberTargets() >= 4.0)) and NAG:Cast(411128)
    or NAG:AuraIsActive(417141) and NAG:Cast(9830)
    or (NAG:CatEnergyAfterDuration(NAG:DotRemainingTime(9904)) >= (NAG:SpellCurrentCost(409828) + NAG:SpellCurrentCost(9904))) and NAG:Cast(409828)
    or ((NAG:AuraRemainingTime(17392, "target") <= 12.0) and (NAG:AuraRemainingTime(9907, "target") <= 12.0)) and NAG:Cast(17392)
    or (not NAG:AuraIsActive(768)) and NAG:Cast(768)
        ]],

        -- New action-based format

        -- Tracked IDs for optimization
        spells = {768, 9830, 9896, 9904, 9907, 16870, 17392, 31018, 407988, 409828, 411128, 417045, 417141, 455873, 470270, 1213366, 1218476, 1226116, 1226119, 1231381},
        items = {213407, 241037},
        auras = {},
        runes = {417046},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }

-- Balance Druid - 1Target_1Min_Balance_BiS_Phase8_ST by APLParser
local balanceRotation1Target1Min = {
    name = "Druid Balance - 1Target_1Min_Balance_BiS_Phase8_ST by APLParser",
    specIndex = 1,
    class = "DRUID",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -3.5, action = "NAG:Cast(417157)" },
        { time = -2.0, action = "NAG:Cast(9912)" }
    },
    rotationString = [[
((NAG:AuraRemainingTime(241241) < 2) or (not NAG:AuraIsActive(241241))) and NAG:Cast(241241)
    or NAG:AuraIsActive(417157) and NAG:AutocastOtherCooldowns()
    or (not NAG:AuraIsActive(417157)) and NAG:Cast(417157)
    or NAG:Multidot(9835, 2, 0.0)
    or NAG:Multidot(414684, 2, 0.0)
    or NAG:Cast(439748)
    or (NAG:SpellTimeToReady(417157) > 2.5) and NAG:Cast(9912)
    or ((NAG:AuraNumStacks(408255) >= 1)) and NAG:Cast(25298)
    or NAG:SpellCanCast(9912) and NAG:Cast(9912)
    ]],

    -- Tracked IDs for optimization
    spells = {9835, 9912, 25298, 408255, 414684, 417157, 439748},
    items = {241241},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Feral Druid - 1Target_2Min_BiS_Feral_Phase8_ST by APLParser
local feralRotation1Target2Min = {
    name = "Druid Feral - 1Target_2Min_BiS_Feral_Phase8_ST by APLParser",
    specIndex = 2,
    class = "DRUID",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(768)" },
        { time = -2.0, action = "NAG:Cast(1213366)" },
        { time = -1.5, action = "NAG:Cast(17392)" }
    },
    rotationString = [[
((NAG:AuraRemainingTime(17392, "target") <= 1.0) and (NAG:AuraRemainingTime(9907, "target") <= 1.0)) and NAG:Cast(17392)
    or (not NAG:AuraIsActive(407988)) and NAG:Cast(407988)
    or (not NAG:AuraIsActive(1213366)) and NAG:Cast(1213366)
    or ((NAG:CatEnergyAfterDuration(NAG:GCDTimeToReady()) + 60.0) <= NAG:MaxEnergy()) and NAG:Cast(417045)
    or ((not NAG:AuraIsActive(417045)) and ((NAG:CatEnergyAfterDuration(NAG:GCDTimeToReady()) <= (NAG:MaxEnergy() - 40.0)) or ((NAG:AuraIsKnown(1218476) or NAG:AuraIsKnown(1226116)) and (not NAG:DotIsActive(9904)) and NAG:AuraIsActive(407988)))) and NAG:Cast(417045)
    or (NAG:AuraIsActive(417045) or (not NAG:RuneIsEquipped(417046))) and NAG:AutocastOtherCooldowns()
    or ((NAG:AuraIsActive(417045) or (not NAG:RuneIsEquipped(417046))) and (not NAG:AuraIsKnown(241037))) and NAG:Cast(213407)
    or (NAG:AuraIsActive(241037) or (NAG:RemainingTime() < 40.0)) and NAG:Cast(213407)
    or (not NAG:AuraIsActive(409828, "target")) and NAG:Cast(409828)
    or ((not NAG:DotIsActive(9896)) and (NAG:CurrentComboPoints() == 5) and (NAG:RemainingTime() >= 10) and ((NAG:AuraRemainingTime(407988) >= 6.0) or NAG:AuraIsKnown(455873))) and NAG:Cast(9896)
    or (NAG:AuraIsKnown(1226119) and NAG:AuraIsActive(417045) and (NAG:CurrentComboPoints() == 5.0) and (NAG:AuraRemainingTime(407988) <= 4.0)) and NAG:Cast(407988)
    or (NAG:AuraIsKnown(1226119) and NAG:AuraIsActive(417045) and (((NAG:AuraRemainingTime(417045) <= 1.0) and (NAG:CurrentComboPoints() >= 4.0)) or ((NAG:AuraRemainingTime(417045) < 2.0) and (NAG:CurrentComboPoints() == 5.0)))) and NAG:Cast(31018)
    or (NAG:AuraIsKnown(16870) and NAG:AuraIsActive(16870) and (NAG:NumberTargets() >= 4.0)) and NAG:Cast(411128)
    or (NAG:AuraIsKnown(16870) and NAG:AuraIsActive(16870)) and NAG:Cast(9830)
    or ((not NAG:DotIsActive(9904)) and ((NAG:AuraIsKnown(1218476) and (NAG:RemainingTime() >= 4.0)) or (NAG:RemainingTime() >= 9.0)) and (not (NAG:RuneIsEquipped(417046) and (not NAG:AuraIsActive(417045)) and NAG:AuraIsKnown(1218476) and (NAG:SpellTimeToReady(417045) < 3.0)))) and NAG:Cast(9904)
    or ((NAG:CurrentComboPoints() == 5.0) and (NAG:AuraRemainingTime(407988) >= 4.0) and ((NAG:AuraIsKnown(1231381) and NAG:AuraIsActive(1231381)) or (NAG:RemainingTime() <= 6.0) or (NAG:AuraRemainingTime(9896, "target") >= 10.0)) and (NAG:AuraIsKnown(470270) or (NAG:CurrentEnergy() <= (NAG:SpellCurrentCost(31018) + 10.0)))) and NAG:Cast(31018)
    or ((NAG:NumberTargets() >= 4.0)) and NAG:Cast(411128)
    or NAG:AuraIsActive(417141) and NAG:Cast(9830)
    or (NAG:CatEnergyAfterDuration(NAG:DotRemainingTime(9904)) >= (NAG:SpellCurrentCost(409828) + NAG:SpellCurrentCost(9904))) and NAG:Cast(409828)
    or ((NAG:AuraRemainingTime(17392, "target") <= 12.0) and (NAG:AuraRemainingTime(9907, "target") <= 12.0)) and NAG:Cast(17392)
    or (not NAG:AuraIsActive(768)) and NAG:Cast(768)
        ]],

        -- New action-based format

        -- Tracked IDs for optimization
        spells = {768, 9830, 9896, 9904, 9907, 16870, 17392, 31018, 407988, 409828, 411128, 417045, 417141, 455873, 470270, 1213366, 1218476, 1226116, 1226119, 1231381},
        items = {213407, 241037},
        auras = {},
        runes = {417046},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }

-- Feral Druid - 1Target_3Min_BiS_Feral_Phase8_ST by APLParser
local feralRotation1Target3Min = {
    name = "Druid Feral - 1Target_3Min_BiS_Feral_Phase8_ST by APLParser",
    specIndex = 2,
    class = "DRUID",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(768)" },
        { time = -2.0, action = "NAG:Cast(1213366)" },
        { time = -1.5, action = "NAG:Cast(17392)" }
    },
    rotationString = [[
((NAG:AuraRemainingTime(17392, "target") <= 1.0) and (NAG:AuraRemainingTime(9907, "target") <= 1.0)) and NAG:Cast(17392)
    or (not NAG:AuraIsActive(407988)) and NAG:Cast(407988)
    or (not NAG:AuraIsActive(1213366)) and NAG:Cast(1213366)
    or ((NAG:CatEnergyAfterDuration(NAG:GCDTimeToReady()) + 60.0) <= NAG:MaxEnergy()) and NAG:Cast(417045)
    or ((not NAG:AuraIsActive(417045)) and ((NAG:CatEnergyAfterDuration(NAG:GCDTimeToReady()) <= (NAG:MaxEnergy() - 40.0)) or ((NAG:AuraIsKnown(1218476) or NAG:AuraIsKnown(1226116)) and (not NAG:DotIsActive(9904)) and NAG:AuraIsActive(407988)))) and NAG:Cast(417045)
    or (NAG:AuraIsActive(417045) or (not NAG:RuneIsEquipped(417046))) and NAG:AutocastOtherCooldowns()
    or ((NAG:AuraIsActive(417045) or (not NAG:RuneIsEquipped(417046))) and (not NAG:AuraIsKnown(241037))) and NAG:Cast(213407)
    or (NAG:AuraIsActive(241037) or (NAG:RemainingTime() < 40.0)) and NAG:Cast(213407)
    or (not NAG:AuraIsActive(409828, "target")) and NAG:Cast(409828)
    or ((not NAG:DotIsActive(9896)) and (NAG:CurrentComboPoints() == 5) and (NAG:RemainingTime() >= 10) and ((NAG:AuraRemainingTime(407988) >= 6.0) or NAG:AuraIsKnown(455873))) and NAG:Cast(9896)
    or (NAG:AuraIsKnown(1226119) and NAG:AuraIsActive(417045) and (NAG:CurrentComboPoints() == 5.0) and (NAG:AuraRemainingTime(407988) <= 4.0)) and NAG:Cast(407988)
    or (NAG:AuraIsKnown(1226119) and NAG:AuraIsActive(417045) and (((NAG:AuraRemainingTime(417045) <= 1.0) and (NAG:CurrentComboPoints() >= 4.0)) or ((NAG:AuraRemainingTime(417045) < 2.0) and (NAG:CurrentComboPoints() == 5.0)))) and NAG:Cast(31018)
    or (NAG:AuraIsKnown(16870) and NAG:AuraIsActive(16870) and (NAG:NumberTargets() >= 4.0)) and NAG:Cast(411128)
    or (NAG:AuraIsKnown(16870) and NAG:AuraIsActive(16870)) and NAG:Cast(9830)
    or ((not NAG:DotIsActive(9904)) and ((NAG:AuraIsKnown(1218476) and (NAG:RemainingTime() >= 4.0)) or (NAG:RemainingTime() >= 9.0)) and (not (NAG:RuneIsEquipped(417046) and (not NAG:AuraIsActive(417045)) and NAG:AuraIsKnown(1218476) and (NAG:SpellTimeToReady(417045) < 3.0)))) and NAG:Cast(9904)
    or ((NAG:CurrentComboPoints() == 5.0) and (NAG:AuraRemainingTime(407988) >= 4.0) and ((NAG:AuraIsKnown(1231381) and NAG:AuraIsActive(1231381)) or (NAG:RemainingTime() <= 6.0) or (NAG:AuraRemainingTime(9896, "target") >= 10.0)) and (NAG:AuraIsKnown(470270) or (NAG:CurrentEnergy() <= (NAG:SpellCurrentCost(31018) + 10.0)))) and NAG:Cast(31018)
    or ((NAG:NumberTargets() >= 4.0)) and NAG:Cast(411128)
    or NAG:AuraIsActive(417141) and NAG:Cast(9830)
    or (NAG:CatEnergyAfterDuration(NAG:DotRemainingTime(9904)) >= (NAG:SpellCurrentCost(409828) + NAG:SpellCurrentCost(9904))) and NAG:Cast(409828)
    or ((NAG:AuraRemainingTime(17392, "target") <= 12.0) and (NAG:AuraRemainingTime(9907, "target") <= 12.0)) and NAG:Cast(17392)
    or (not NAG:AuraIsActive(768)) and NAG:Cast(768)
        ]],

        -- New action-based format

        -- Tracked IDs for optimization
        spells = {768, 9830, 9896, 9904, 9907, 16870, 17392, 31018, 407988, 409828, 411128, 417045, 417141, 455873, 470270, 1213366, 1218476, 1226116, 1226119, 1231381},
        items = {213407, 241037},
        auras = {},
        runes = {417046},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }

-- Balance Druid - 2Target_1Min_Balance_BiS_Cleave_Phase8 by APLParser
local balanceRotation2Target1Min = {
    name = "Druid Balance - 2Target_1Min_Balance_BiS_Cleave_Phase8 by APLParser",
    specIndex = 1,
    class = "DRUID",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -3.5, action = "NAG:Cast(417157)" },
        { time = -2.0, action = "NAG:Cast(9912)" }
    },
    rotationString = [[
((NAG:AuraRemainingTime(241241) < 2) or (not NAG:AuraIsActive(241241))) and NAG:Cast(241241)
    or NAG:AutocastOtherCooldowns()
    or NAG:Multidot(9835, 2, 0.0)
    or NAG:Cast(439748)
    or NAG:SpellCanCast(417157) and NAG:Cast(417157)
    or NAG:AuraIsActive(417157) and NAG:Cast(25298)
    or NAG:Multidot(414684, 2, 0.0)
    or NAG:SpellCanCast(9912) and NAG:Cast(9912)
        ]],

        -- New action-based format

        -- Tracked IDs for optimization
        spells = {9835, 9912, 25298, 414684, 417157, 439748},
        items = {241241},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }

-- Feral Druid - 2Target_1Min_BiS_Cleave_Feral_Phase8 by APLParser
local feralRotation2Target1Min = {
    name = "Druid Feral - 2Target_1Min_BiS_Cleave_Feral_Phase8 by APLParser",
    specIndex = 2,
    class = "DRUID",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -2.0, action = "NAG:Cast(1213366)" },
        { time = -1.5, action = "NAG:Cast(17392)" }
    },
    rotationString = [[
((NAG:AuraRemainingTime(17392, "target") <= 1.0) and (NAG:AuraRemainingTime(9907, "target") <= 1.0)) and NAG:Cast(17392)
    or (not NAG:AuraIsActive(407988)) and NAG:Cast(407988)
    or (not NAG:AuraIsActive(1213366)) and NAG:Cast(1213366)
    or ((not NAG:EnergyThreshold(35)) or ((NAG:TimeToEnergyTick() > NAG:GCDTimeToReady()) and (not NAG:EnergyThreshold(35)))) and NAG:Cast(417045)
    or ((not NAG:AuraIsActive(417045)) and ((not NAG:EnergyThreshold(35)) or ((NAG:TimeToEnergyTick() > NAG:GCDTimeToReady()) and (not NAG:EnergyThreshold(35))))) and NAG:Cast(417045)
    or NAG:AuraIsActive(417045) and NAG:AutocastOtherCooldowns()
    or (not NAG:AuraIsActive(409828, "target")) and NAG:Cast(409828)
    or ((not NAG:DotIsActive(9896)) and (NAG:CurrentComboPoints() == 5) and (NAG:RemainingTime() >= 10) and ((NAG:AuraRemainingTime(407988) >= 6.0) or NAG:AuraIsKnown(455873))) and NAG:Cast(9896)
    or ((not NAG:DotIsActive(9904)) and (NAG:RemainingTime() >= 9.0) and ((not NAG:AuraIsKnown(1218476)) or NAG:AuraIsActive(417045) or (NAG:SpellTimeToReady(417045) >= 1.0))) and NAG:Cast(9904)
    or (NAG:AuraIsKnown(1218476) and NAG:AuraIsActive(417045) and (NAG:DotRemainingTime(9904) < 4.0) and (NAG:RemainingTime() >= 9.0)) and NAG:Cast(9904)
    or (NAG:AuraIsKnown(17061) and (NAG:CurrentMana() >= NAG:SpellCurrentCost(768)) and (NAG:TimeToEnergyTick() < 1.00) and (not NAG:AuraIsKnown(1213171)) and ((NAG:CurrentEnergy() + 20.2) >= (NAG:SpellCurrentCost(409828) + NAG:SpellCurrentCost(409828))) and ((NAG:CurrentEnergy() + 20.2) < (NAG:SpellCurrentCost(409828) + NAG:SpellCurrentCost(9830)))) and NAG:Cast(409828)
    or (NAG:NumberTargets() >= 4) and NAG:Cast(411128)
    or NAG:Cast(9830)
    or (NAG:AuraIsKnown(17061) and (NAG:CurrentMana() >= NAG:SpellCurrentCost(768)) and (NAG:TimeToEnergyTick() > 1.02) and (NAG:CurrentComboPoints() == 5.0) and (NAG:AuraRemainingTime(407988) >= 5.0) and (NAG:AuraRemainingTime(9896, "target") >= 3.0)) and NAG:Cast(31018)
    or (NAG:AuraIsKnown(17061) and (NAG:CurrentMana() >= NAG:SpellCurrentCost(768)) and (NAG:TimeToEnergyTick() > 1.02)) and NAG:Cast(409828)
    or (NAG:AuraIsKnown(17061) and NAG:GCDIsReady() and (NAG:CurrentMana() >= NAG:SpellCurrentCost(768)) and (((not NAG:AuraIsActive(417141)) and (NAG:CurrentEnergy() < (NAG:SpellCurrentCost(9830) - 20.2))) or (NAG:RuneIsEquipped(417141) and NAG:AuraIsActive(417141) and (NAG:CurrentEnergy() < NAG:SpellCurrentCost(9830))))) and NAG:CancelAura(768)
    or ((NAG:AuraRemainingTime(17392, "target") <= 8.0) and (NAG:AuraRemainingTime(9907, "target") <= 8.0)) and NAG:Cast(17392)
    or ((not NAG:AuraIsActive(768))) and NAG:Cast(233985)
    or ((not NAG:AuraIsActive(768))) and NAG:Cast(13180)
    or ((not NAG:AuraIsActive(768)) and ((NAG:CurrentMana() + 1500.0) <= (NAG:CurrentMana() / NAG:CurrentManaPercent()))) and NAG:Cast(12662)
    or ((not NAG:AuraIsActive(768)) and ((NAG:CurrentMana() + 2250.0) <= (NAG:CurrentMana() / NAG:CurrentManaPercent()))) and NAG:Cast(NAG:GetBattlePotion())
    or ((not NAG:AuraIsActive(768)) and (not NAG:AuraIsActive(417141)) and (NAG:CurrentManaPercent() <= 0.4) and (NAG:CurrentMana() > (NAG:SpellCurrentCost(29166) + NAG:SpellCurrentCost(768))) and (not ((NAG:SpellIsKnown(12662) and NAG:SpellIsReady(12662)) or (NAG:SpellIsKnown(NAG:GetBattlePotion()) and NAG:SpellIsReady(NAG:GetBattlePotion()))))) and NAG:Cast(29166)
    or (not NAG:AuraIsActive(768)) and NAG:Cast(768)
        ]],

        -- New action-based format

        -- Tracked IDs for optimization
        spells = {768, 9830, 9896, 9904, 9907, 17061, 17392, 29166, 31018, 407988, 409828, 411128, 417045, 417141, 455873, 1213171, 1213366, 1218476},
        items = {12662, 13180, 233985},
        auras = {},
        runes = {417141},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }

-- Feral Druid - 3Target_1Min_BiS_Cleave_Feral_Phase8 by APLParser
local feralRotation3Target1Min = {
    name = "Druid Feral - 3Target_1Min_BiS_Cleave_Feral_Phase8 by APLParser",
    specIndex = 2,
    class = "DRUID",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -2.0, action = "NAG:Cast(1213366)" },
        { time = -1.5, action = "NAG:Cast(17392)" }
    },
    rotationString = [[
((NAG:AuraRemainingTime(17392, "target") <= 1.0) and (NAG:AuraRemainingTime(9907, "target") <= 1.0)) and NAG:Cast(17392)
    or (not NAG:AuraIsActive(407988)) and NAG:Cast(407988)
    or (not NAG:AuraIsActive(1213366)) and NAG:Cast(1213366)
    or ((not NAG:EnergyThreshold(35)) or ((NAG:TimeToEnergyTick() > NAG:GCDTimeToReady()) and (not NAG:EnergyThreshold(35)))) and NAG:Cast(417045)
    or ((not NAG:AuraIsActive(417045)) and ((not NAG:EnergyThreshold(35)) or ((NAG:TimeToEnergyTick() > NAG:GCDTimeToReady()) and (not NAG:EnergyThreshold(35))))) and NAG:Cast(417045)
    or NAG:AuraIsActive(417045) and NAG:AutocastOtherCooldowns()
    or (not NAG:AuraIsActive(409828, "target")) and NAG:Cast(409828)
    or ((not NAG:DotIsActive(9896)) and (NAG:CurrentComboPoints() == 5) and (NAG:RemainingTime() >= 10) and ((NAG:AuraRemainingTime(407988) >= 6.0) or NAG:AuraIsKnown(455873))) and NAG:Cast(9896)
    or ((not NAG:DotIsActive(9904)) and (NAG:RemainingTime() >= 9.0) and ((not NAG:AuraIsKnown(1218476)) or NAG:AuraIsActive(417045) or (NAG:SpellTimeToReady(417045) >= 1.0))) and NAG:Cast(9904)
    or (NAG:AuraIsKnown(1218476) and NAG:AuraIsActive(417045) and (NAG:DotRemainingTime(9904) < 4.0) and (NAG:RemainingTime() >= 9.0)) and NAG:Cast(9904)
    or (NAG:AuraIsKnown(17061) and (NAG:CurrentMana() >= NAG:SpellCurrentCost(768)) and (NAG:TimeToEnergyTick() < 1.00) and (not NAG:AuraIsKnown(1213171)) and ((NAG:CurrentEnergy() + 20.2) >= (NAG:SpellCurrentCost(409828) + NAG:SpellCurrentCost(409828))) and ((NAG:CurrentEnergy() + 20.2) < (NAG:SpellCurrentCost(409828) + NAG:SpellCurrentCost(9830)))) and NAG:Cast(409828)
    or (NAG:NumberTargets() >= 4) and NAG:Cast(411128)
    or NAG:Cast(9830)
    or (NAG:AuraIsKnown(17061) and (NAG:CurrentMana() >= NAG:SpellCurrentCost(768)) and (NAG:TimeToEnergyTick() > 1.02) and (NAG:CurrentComboPoints() == 5.0) and (NAG:AuraRemainingTime(407988) >= 5.0) and (NAG:AuraRemainingTime(9896, "target") >= 3.0)) and NAG:Cast(31018)
    or (NAG:AuraIsKnown(17061) and (NAG:CurrentMana() >= NAG:SpellCurrentCost(768)) and (NAG:TimeToEnergyTick() > 1.02)) and NAG:Cast(409828)
    or (NAG:AuraIsKnown(17061) and NAG:GCDIsReady() and (NAG:CurrentMana() >= NAG:SpellCurrentCost(768)) and (((not NAG:AuraIsActive(417141)) and (NAG:CurrentEnergy() < (NAG:SpellCurrentCost(9830) - 20.2))) or (NAG:RuneIsEquipped(417141) and NAG:AuraIsActive(417141) and (NAG:CurrentEnergy() < NAG:SpellCurrentCost(9830))))) and NAG:CancelAura(768)
    or ((NAG:AuraRemainingTime(17392, "target") <= 8.0) and (NAG:AuraRemainingTime(9907, "target") <= 8.0)) and NAG:Cast(17392)
    or ((not NAG:AuraIsActive(768))) and NAG:Cast(233985)
    or ((not NAG:AuraIsActive(768))) and NAG:Cast(13180)
    or ((not NAG:AuraIsActive(768)) and ((NAG:CurrentMana() + 1500.0) <= (NAG:CurrentMana() / NAG:CurrentManaPercent()))) and NAG:Cast(12662)
    or ((not NAG:AuraIsActive(768)) and ((NAG:CurrentMana() + 2250.0) <= (NAG:CurrentMana() / NAG:CurrentManaPercent()))) and NAG:Cast(NAG:GetBattlePotion())
    or ((not NAG:AuraIsActive(768)) and (not NAG:AuraIsActive(417141)) and (NAG:CurrentManaPercent() <= 0.4) and (NAG:CurrentMana() > (NAG:SpellCurrentCost(29166) + NAG:SpellCurrentCost(768))) and (not ((NAG:SpellIsKnown(12662) and NAG:SpellIsReady(12662)) or (NAG:SpellIsKnown(NAG:GetBattlePotion()) and NAG:SpellIsReady(NAG:GetBattlePotion()))))) and NAG:Cast(29166)
    or (not NAG:AuraIsActive(768)) and NAG:Cast(768)
        ]],

        -- New action-based format

        -- Tracked IDs for optimization
        spells = {768, 9830, 9896, 9904, 9907, 17061, 17392, 29166, 31018, 407988, 409828, 411128, 417045, 417141, 455873, 1213171, 1213366, 1218476},
        items = {12662, 13180, 233985},
        auras = {},
        runes = {417141},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }

-- Balance Druid - 3Target_1Min_Balance_BiS_Cleave_Phase8 by APLParser
local balanceRotation3Target1Min = {
    name = "Druid Balance - 3Target_1Min_Balance_BiS_Cleave_Phase8 by APLParser",
    specIndex = 1,
    class = "DRUID",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -3.5, action = "NAG:Cast(417157)" },
        { time = -2.0, action = "NAG:Cast(9912)" }
    },
    rotationString = [[
((NAG:AuraRemainingTime(241241) < 2) or (not NAG:AuraIsActive(241241))) and NAG:Cast(241241)
    or NAG:AutocastOtherCooldowns()
    or NAG:Multidot(9835, 2, 0.0)
    or NAG:Cast(439748)
    or NAG:SpellCanCast(417157) and NAG:Cast(417157)
    or NAG:AuraIsActive(417157) and NAG:Cast(25298)
    or NAG:Multidot(414684, 2, 0.0)
    or NAG:SpellCanCast(9912) and NAG:Cast(9912)
        ]],

        -- New action-based format

        -- Tracked IDs for optimization
        spells = {9835, 9912, 25298, 414684, 417157, 439748},
        items = {241241},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }

-- Feral Druid - 4Target_1Min_BiS_Cleave_Feral_Phase8 by APLParser
local feralRotation4Target1Min = {
    name = "Druid Feral - 4Target_1Min_BiS_Cleave_Feral_Phase8 by APLParser",
    specIndex = 2,
    class = "DRUID",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -5.0, action = "NAG:Cast(768)" },
        { time = -2.0, action = "NAG:Cast(1213366)" },
        { time = -1.5, action = "NAG:Cast(17392)" }
    },
    rotationString = [[
((NAG:AuraRemainingTime(17392, "target") <= 1.0) and (NAG:AuraRemainingTime(9907, "target") <= 1.0)) and NAG:Cast(17392)
    or (not NAG:AuraIsActive(407988)) and NAG:Cast(407988)
    or (not NAG:AuraIsActive(1213366)) and NAG:Cast(1213366)
    or ((NAG:CatEnergyAfterDuration(NAG:GCDTimeToReady()) + 60.0) <= NAG:MaxEnergy()) and NAG:Cast(417045)
    or ((not NAG:AuraIsActive(417045)) and ((NAG:CatEnergyAfterDuration(NAG:GCDTimeToReady()) <= (NAG:MaxEnergy() - 40.0)) or ((NAG:AuraIsKnown(1218476) or NAG:AuraIsKnown(1226116)) and (not NAG:DotIsActive(9904)) and NAG:AuraIsActive(407988)))) and NAG:Cast(417045)
    or (NAG:AuraIsActive(417045) or (not NAG:RuneIsEquipped(417046))) and NAG:AutocastOtherCooldowns()
    or ((NAG:AuraIsActive(417045) or (not NAG:RuneIsEquipped(417046))) and (not NAG:AuraIsKnown(241037))) and NAG:Cast(213407)
    or (NAG:AuraIsActive(241037) or (NAG:RemainingTime() < 40.0)) and NAG:Cast(213407)
    or (not NAG:AuraIsActive(409828, "target")) and NAG:Cast(409828)
    or ((not NAG:AuraIsActive(409828, "target")) and NAG:AuraIsActive(9904, "target") and NAG:AuraIsActive(9904, "target") and NAG:AuraIsActive(9904, "target") and NAG:AuraIsActive(9904, "target")) and NAG:Cast(409828)
    or ((not NAG:AuraIsActive(409828, "target")) and NAG:AuraIsActive(9904, "target") and NAG:AuraIsActive(9904, "target") and NAG:AuraIsActive(9904, "target") and NAG:AuraIsActive(9904, "target")) and NAG:Cast(409828)
    or ((not NAG:AuraIsActive(409828, "target")) and NAG:AuraIsActive(9904, "target") and NAG:AuraIsActive(9904, "target") and NAG:AuraIsActive(9904, "target") and NAG:AuraIsActive(9904, "target")) and NAG:Cast(409828)
    or ((not NAG:AuraIsActive(409828, "target")) and NAG:AuraIsActive(9904, "target") and NAG:AuraIsActive(9904, "target") and NAG:AuraIsActive(9904, "target") and NAG:AuraIsActive(9904, "target")) and NAG:Cast(409828)
    or ((not NAG:DotIsActive(9896)) and (NAG:CurrentComboPoints() == 5) and (NAG:RemainingTime() >= 10) and ((NAG:AuraRemainingTime(407988) >= 6.0) or NAG:AuraIsKnown(455873))) and NAG:Cast(9896)
    or (NAG:AuraIsKnown(1226119) and NAG:AuraIsActive(417045) and (NAG:CurrentComboPoints() == 5.0) and (NAG:AuraRemainingTime(407988) <= 4.0)) and NAG:Cast(407988)
    or (NAG:AuraIsKnown(1226119) and NAG:AuraIsActive(417045) and (((NAG:AuraRemainingTime(417045) <= 1.0) and (NAG:CurrentComboPoints() >= 4.0)) or ((NAG:AuraRemainingTime(417045) < 2.0) and (NAG:CurrentComboPoints() == 5.0)))) and NAG:Cast(31018)
    or (NAG:AuraIsKnown(16870) and NAG:AuraIsActive(16870) and (NAG:NumberTargets() >= 4.0)) and NAG:Cast(411128)
    or (NAG:AuraIsKnown(16870) and NAG:AuraIsActive(16870)) and NAG:Cast(9830)
    or ((not NAG:DotIsActive(9904)) and ((NAG:AuraIsKnown(1218476) and (NAG:RemainingTime() >= 4.0)) or (NAG:RemainingTime() >= 9.0))) and NAG:Cast(9904)
    or ((not NAG:DotIsActive(9904)) and ((NAG:AuraIsKnown(1218476) and (NAG:RemainingTime() >= 4.0)) or (NAG:RemainingTime() >= 9.0))) and NAG:Cast(9904)
    or ((not NAG:DotIsActive(9904)) and ((NAG:AuraIsKnown(1218476) and (NAG:RemainingTime() >= 4.0)) or (NAG:RemainingTime() >= 9.0))) and NAG:Cast(9904)
    or ((not NAG:DotIsActive(9904)) and ((NAG:AuraIsKnown(1218476) and (NAG:RemainingTime() >= 4.0)) or (NAG:RemainingTime() >= 9.0))) and NAG:Cast(9904)
    or ((NAG:CurrentComboPoints() == 5.0) and (NAG:AuraRemainingTime(407988) >= 4.0) and ((NAG:AuraIsKnown(1231381) and NAG:AuraIsActive(1231381)) or (NAG:RemainingTime() <= 6.0) or (NAG:AuraRemainingTime(9896, "target") >= 10.0)) and (NAG:AuraIsKnown(470270) or (NAG:CurrentEnergy() <= (NAG:SpellCurrentCost(31018) + 10.0)))) and NAG:Cast(31018)
    or ((NAG:NumberTargets() >= 4.0)) and NAG:Cast(411128)
    or NAG:AuraIsActive(417141) and NAG:Cast(9830)
    or (NAG:CatEnergyAfterDuration(NAG:DotRemainingTime(9904)) >= (NAG:SpellCurrentCost(409828) + NAG:SpellCurrentCost(9904))) and NAG:Cast(409828)
    or ((NAG:AuraRemainingTime(17392, "target") <= 12.0) and (NAG:AuraRemainingTime(9907, "target") <= 12.0)) and NAG:Cast(17392)
    or (not NAG:AuraIsActive(768)) and NAG:Cast(768)
        ]],

        -- New action-based format

        -- Tracked IDs for optimization
        spells = {768, 9830, 9896, 9904, 9907, 16870, 17392, 31018, 407988, 409828, 411128, 417045, 417141, 455873, 470270, 1213366, 1218476, 1226116, 1226119, 1231381},
        items = {213407, 241037},
        auras = {},
        runes = {417046},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }

-- Balance Druid - 4Target_1Min_Balance_BiS_Cleave_Phase8 by APLParser
local balanceRotation4Target1Min = {
    name = "Druid Balance - 4Target_1Min_Balance_BiS_Cleave_Phase8 by APLParser",
    specIndex = 1,
    class = "DRUID",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -3.5, action = "NAG:Cast(417157)" },
        { time = -2.0, action = "NAG:Cast(9912)" }
    },
    rotationString = [[
((NAG:AuraRemainingTime(241241) < 2) or (not NAG:AuraIsActive(241241))) and NAG:Cast(241241)
    or NAG:AutocastOtherCooldowns()
    or NAG:Multidot(9835, 2, 0.0)
    or NAG:Cast(439748)
    or NAG:SpellCanCast(417157) and NAG:Cast(417157)
    or NAG:AuraIsActive(417157) and NAG:Cast(25298)
    or NAG:Multidot(414684, 2, 0.0)
    or NAG:SpellCanCast(9912) and NAG:Cast(9912)
        ]],

        -- New action-based format

        -- Tracked IDs for optimization
        spells = {9835, 9912, 25298, 414684, 417157, 439748},
        items = {241241},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }

--- @class DRUID : ClassBase
local DRUID = NAG:CreateClassModule("DRUID", defaults)

-- ============================ SETUP CLASS DEFAULTS ============================

-- Setup class defaults during PreDatabaseRegistration
function DRUID:SetupClassDefaults()
    -- ✅ Add rotations to defaults using the new system
    ns.AddRotationToDefaults(self.defaults, 1, balanceRotation)  -- Balance
    ns.AddRotationToDefaults(self.defaults, 2, feralRotation)  -- Feral
    ns.AddRotationToDefaults(self.defaults, 1, balanceRotation5Min)  -- Balance
    ns.AddRotationToDefaults(self.defaults, 2, feralRotation5Min)  -- Feral
    ns.AddRotationToDefaults(self.defaults, 2, feralRotation1Target1Min)  -- Feral
    ns.AddRotationToDefaults(self.defaults, 1, balanceRotation1Target1Min)  -- Balance
    ns.AddRotationToDefaults(self.defaults, 2, feralRotation1Target2Min)  -- Feral
    ns.AddRotationToDefaults(self.defaults, 2, feralRotation1Target3Min)  -- Feral
    ns.AddRotationToDefaults(self.defaults, 1, balanceRotation2Target1Min)  -- Balance
    ns.AddRotationToDefaults(self.defaults, 2, feralRotation2Target1Min)  -- Feral
    ns.AddRotationToDefaults(self.defaults, 2, feralRotation3Target1Min)  -- Feral
    ns.AddRotationToDefaults(self.defaults, 1, balanceRotation3Target1Min)  -- Balance
    ns.AddRotationToDefaults(self.defaults, 2, feralRotation4Target1Min)  -- Feral
    ns.AddRotationToDefaults(self.defaults, 1, balanceRotation4Target1Min)  -- Balance
end

if not DRUID then return end
NAG.Class = DRUID
