local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
--- @type SpellTrackingManager|AceModule|CoreModule

--- NAG
local defaults = ns.InitializeClassDefaults()

-- Add spec-level spell locations to defaults
-- Class assignments for raid coordination
defaults.class.classAssignments = {
    {
        id = "faerie_fire",
        name = "Faerie Fire",
        description = "Apply armor reduction debuff on targets (conflicts with Sunder Armor/Expose Armor)",
        spellIds = {770, 778, 9749, 9907, 26993, 33602}, -- All ranks (includes Feral version)
        category = "debuff",
    },
    {
        id = "mark_of_the_wild",
        name = "Mark of the Wild",
        description = "Provide stats buff to raid (coordinate with other Druids)",
        spellIds = {1126, 5232, 6756, 5234, 8907, 9884, 9885, 26990, 48469}, -- All ranks (Cata uses rank 9)
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

defaults.class.specSpellLocations = {
    [1] = {  -- Balance
        [1126] = NAG.SPELL_POSITIONS.ABOVE, [24858] = NAG.SPELL_POSITIONS.ABOVE,
        [48505] = NAG.SPELL_POSITIONS.RIGHT, [88751] = NAG.SPELL_POSITIONS.RIGHT,
        [88747] = NAG.SPELL_POSITIONS.RIGHT, [16914] = NAG.SPELL_POSITIONS.RIGHT,
        [33831] = NAG.SPELL_POSITIONS.LEFT, [26297] = NAG.SPELL_POSITIONS.LEFT
    },
    [2] = {  -- Feral
        [49376] = NAG.SPELL_POSITIONS.ABOVE, [768] = NAG.SPELL_POSITIONS.ABOVE, [5487] = NAG.SPELL_POSITIONS.ABOVE,
        [62078] = NAG.SPELL_POSITIONS.RIGHT, [77758] = NAG.SPELL_POSITIONS.RIGHT, [779] = NAG.SPELL_POSITIONS.RIGHT,
        [5217] = NAG.SPELL_POSITIONS.LEFT, [50334] = NAG.SPELL_POSITIONS.LEFT,
        [5229] = NAG.SPELL_POSITIONS.LEFT, [26297] = NAG.SPELL_POSITIONS.LEFT
    },
    [4] = {  -- Restoration
    },
    [3] = {  -- Guardian
        [49376] = NAG.SPELL_POSITIONS.ABOVE, [768] = NAG.SPELL_POSITIONS.ABOVE, [5487] = NAG.SPELL_POSITIONS.ABOVE,
        [62078] = NAG.SPELL_POSITIONS.RIGHT, [77758] = NAG.SPELL_POSITIONS.RIGHT, [779] = NAG.SPELL_POSITIONS.RIGHT,
        [5217] = NAG.SPELL_POSITIONS.LEFT, [50334] = NAG.SPELL_POSITIONS.LEFT,
        [5229] = NAG.SPELL_POSITIONS.LEFT, [26297] = NAG.SPELL_POSITIONS.LEFT
    }
}



-- Balance Rotation
local balanceRotation = {
    name = "Cataclysm Balance",
    specIndex = 1,
    class = "DRUID",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = false,
    prePull = {
        { time = -10, action = "NAG:Cast(88747)" },
        { time = -9, action = "NAG:Cast(88747)" },
        { time = -8, action = "NAG:Cast(88747)" },
        { time = -2.5, action = "NAG:Cast(NAG:GetBattlePotion())" },
        { time = -2, action = "NAG:Cast(2912)" }
    },
    macros = {
        { name = "Cat Form",  body = "#showtooltip\n/dmh start\n/cast !Cat Form\n/dmh snake\n/dmh end" },
        { name = "Bear Form", body = "#showtooltip\n/dmh start\n/cast !Bear Form\n/dmh snake\n/dmh end" }
    },
    rotationString = [[
    NAG:Cast(2825)
        or (((NAG:DotRemainingTime(5570) > 6) and ((NAG:DotRemainingTime(8921) > 6) or (NAG:DotRemainingTime(93402) > 6)) and NAG:UnitIsMoving() and (not NAG:IsReady(33831))) and NAG:Cast(88747))
        or ((not NAG:IsActive(1126)) and NAG:Cast(1126))
        or ((not NAG:IsActive(24858)) and NAG:Cast(24858))
        or ((NAG:DruidCurrentEclipsePhase() == 'NeutralPhase' and (not NAG:IsActive(61345)) and (NAG:CurrentTime() < 2) and (not NAG:DotIsActive(8921))) and NAG:Cast(8921))
        or ((NAG:IsActive(48517)) and NAG:Cast(58091))
        or ((NAG:IsActive(48517)) and NAG:Cast(26297))
        or ((NAG:IsActive(48518) or NAG:IsActive(48517)) and NAG:Cast(82174))
        or ((NAG:IsActive(48518)) and NAG:Cast(48505))
        or (((NAG:AuraNumStacks(88747) < 3.0) and (NAG:UnitDistance("target") < 11.0) and (NAG:NumberTargets() > 1.0) and NAG:IsActive(48517) and (NAG:TimeToReady(88751) < 4)) and NAG:Cast(88747))
        or (((NAG:AuraNumStacks(88747) < 3.0) and (NAG:UnitDistance("target") < 11.0) and (NAG:NumberTargets() > 3.0) and (not NAG:IsActive(48517)) and (NAG:TimeToReady(88751) < 4)) and NAG:Cast(88747))
        or (((NAG:IsActive(48517) or ((NAG:NumberTargets() > 3.0) and (NAG:UnitDistance("target") < 11.0))) and (NAG:AuraNumStacks(88747) == 3.0)) and NAG:Cast(88751))
        or (((NAG:UnitDistance("target") < 11.0) and (NAG:NumberTargets() > 6.0) and NAG:IsActive(48517)) and NAG:Cast(16914))
        or ((NAG:IsActive(48517) and ((NAG:CurrentSolarEnergy() >= 80.0) or (NAG:CurrentSolarEnergy() <= 15.0)) and (NAG:DotRemainingTime(5570) < 8)) and NAG:Cast(5570))
        or ((NAG:IsActive(48517) and ((NAG:CurrentSolarEnergy() >= 80.0) or (NAG:CurrentSolarEnergy() <= 15.0)) and ((NAG:DotRemainingTime(93402) + NAG:DotRemainingTime(8921)) < 8)) and NAG:Cast(93402))
        or ((NAG:IsActive(48518) and ((NAG:CurrentLunarEnergy() >= 80.0) or (NAG:CurrentLunarEnergy() <= 20.0)) and (NAG:DotRemainingTime(5570) < 8)) and NAG:Cast(5570))
        or ((NAG:IsActive(48518) and ((NAG:CurrentLunarEnergy() >= 80.0) or (NAG:CurrentLunarEnergy() <= 20.0)) and ((NAG:DotRemainingTime(93402) + NAG:DotRemainingTime(8921)) < 8)) and NAG:Cast(8921))
        or (({} and (NAG:CurrentTime() > 10)) and NAG:Cast(33831))
        or ((NAG:DruidCurrentEclipsePhase() == 'SolarPhase' and (NAG:CurrentLunarEnergy() <= 60.0)) and NAG:Cast(78674))
        or (((NAG:CurrentSolarEnergy() > 85.0) or ((NAG:CurrentSolarEnergy() >= 5.0) and (NAG:CurrentSolarEnergy() < 20.0)) or ((NAG:CurrentSolarEnergy() >= 25.0) and (NAG:CurrentSolarEnergy() < 40.0)) or ((NAG:CurrentSolarEnergy() >= 45.0) and (NAG:CurrentSolarEnergy() < 60.0)) or ((NAG:CurrentSolarEnergy() >= 65.0) and (NAG:CurrentSolarEnergy() < 80.0))) and NAG:Cast(78674))
        or ((NAG:IsActive(48518) or NAG:IsActive(48517)) and NAG:Cast(78674))
        or ((NAG:DruidCurrentEclipsePhase() == 'SolarPhase') and NAG:Cast(5176))
        or ((NAG:DruidCurrentEclipsePhase() == 'LunarPhase') and NAG:Cast(2912))
        or NAG:Cast(2912)
]]
}

-- Feral Combat Rotation
local feralCombatRotation = {
    name = "Cataclysm Feral Combat",
    specIndex = 2,
    class = "DRUID",
    authors = { "@Darkfrog" },
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = false,
    prePull = {
        { time = -8, action = "NAG:Cast(467)" },
        { time = -6, action = "NAG:Cast(740)" },
        { time = -2, action = "NAG:Cast(768)" },
        { time = -1, action = "NAG:Cast(NAG:GetBattlePotion())" }
    },
    macros = {
        { name = "Cat Form",  body = "#showtooltip\n/dmh start\n/cast !Cat Form\n/dmh snake\n/dmh end" },
        { name = "Bear Form", body = "#showtooltip\n/dmh start\n/cast !Bear Form\n/dmh snake\n/dmh end" }
    },
    rotationString = [[
        (((not NAG:DotIsActive(770)) and (not NAG:DotIsActive(35387)) and (not NAG:DotIsActive(8647)) and (not NAG:DotIsActive(29859))) and NAG:Cast(16857))
        or     (((not NAG:DotIsActive(29859)) and (not NAG:DotIsActive(16511)) and (not NAG:DotIsActive(33876)) and (not NAG:DotIsActive(33878)) and (not NAG:DotIsActive(57386)) and (NAG:CurrentComboPoints() <= 4.0)) and NAG:Cast(33876))
        or     (((NAG:CurrentEnergy() < 50.0) and (not NAG:IsActive(16870)) and (not NAG:IsReady(5217)) and NAG:IsReady(49376) and (not NAG:IsActive(2825)) and NAG:IsActive(768)) and NAG:Cast(49376))
        or     (((NAG:IsActive(5217) or (NAG:RemainingTime() < 11)) and NAG:IsActive(768)) and NAG:Cast(82174))
        or     (((((NAG:AuraRemainingTime(5217) > 5) and (NAG:CurrentHealthPercent() <= 60.0) and (NAG:TimeToReady(50334) > (NAG:RemainingTime() - 20))) or (NAG:RemainingTime() <= 26)) and NAG:IsActive(768)) and NAG:Cast(58145))
        or     ((NAG:IsActive(5217) and NAG:IsActive(768)) and NAG:Cast(50334))
        or     ((((NAG:CurrentEnergy() < 50.0) or (NAG:RemainingTime() < 7) or (NAG:CurrentComboPoints() == 5.0)) and NAG:IsActive(768) and (not NAG:IsActive(50334))) and NAG:Cast(5217))
        or     ((NAG:IsActive(16870) and ((NAG:CurrentComboPoints() <= 4.0) and (NAG:CurrentComboPoints() >= 1.0)) and NAG:IsActive(52610) and NAG:IsActive(768)) and NAG:Cast(5221))
        or     ((((NAG:DotRemainingTime(1079) < 4) or (not NAG:DotIsActive(1079))) and (NAG:CurrentComboPoints() == 5.0) and (NAG:IsActive(5217) or (NAG:TimeToReady(5217) > 3)) and (NAG:CurrentHealthPercent() > 0.60) and NAG:IsActive(768) and NAG:TierSetEquipped(13, 2)) and NAG:Cast(1079))
        or     ((((NAG:DotRemainingTime(1079) < 4) or (not NAG:DotIsActive(1079))) and (NAG:CurrentComboPoints() == 5.0) and (NAG:IsActive(5217) or (NAG:TimeToReady(5217) > 3)) and (NAG:CurrentHealthPercent() > 0.25) and NAG:IsActive(768) and (not NAG:TierSetEquipped(13, 2))) and NAG:Cast(1079))
        or     (((NAG:CurrentComboPoints() == 5.0) and (not NAG:DotIsActive(1079)) and (NAG:CurrentHealthPercent() <= 0.60) and NAG:IsActive(768) and NAG:TierSetEquipped(13, 2)) and NAG:Cast(1079))
        or     (((NAG:CurrentComboPoints() == 5.0) and (not NAG:DotIsActive(1079)) and (NAG:CurrentHealthPercent() <= 0.25) and NAG:IsActive(768) and (not NAG:TierSetEquipped(13, 2))) and NAG:Cast(1079))
        or     (((((not NAG:IsActive(52610)) and (NAG:DotRemainingTime(1079) > 2) and (NAG:CurrentComboPoints() >= 1.0) and (NAG:CurrentComboPoints() <= 2.0)) or ((NAG:CurrentComboPoints() == 5.0) and (NAG:AuraRemainingTime(52610) < 3) and (NAG:DotRemainingTime(1079) > 4))) and (NAG:RemainingTime() > 5) and NAG:IsActive(768)) and NAG:Cast(52610))
        or     ((((NAG:DotRemainingTime(1822) < 3) or (NAG:IsActive(5217) and (NAG:DotRemainingTime(1822) < (NAG:AuraRemainingTime(5217) + 11.0)) and (NAG:AuraRemainingTime(5217) < 4))) and NAG:IsActive(768) and (NAG:CurrentComboPoints() <= 4.0)) and NAG:Cast(1822))
        or     ((NAG:IsActive(16870) and NAG:IsActive(768)) and NAG:Cast(5221))
        or     ((((NAG:DotRemainingTime(1079) > 7) and (NAG:AuraRemainingTime(52610) > 8) and (NAG:CurrentComboPoints() == 5.0) and NAG:IsActive(768)) or (NAG:IsActive(50334) and (NAG:CurrentComboPoints() == 5.0) and (NAG:CurrentEnergy() > 55.0) and NAG:IsActive(768)) or ((NAG:RemainingTime() < 2) and (NAG:CurrentComboPoints() >= 3.0) and NAG:IsActive(768))) and NAG:Cast(22568))
        or     (((NAG:CurrentHealth() <= 60.0) and NAG:DotIsActive(1079) and (NAG:CurrentComboPoints() == 5.0) and NAG:IsActive(768)) and NAG:Cast(22568))
        or     (((((NAG:CurrentEnergy() < 80.0) and (not ((NAG:CurrentComboPoints() == 5.0) and (NAG:DotRemainingTime(1079) < 6)))) or (NAG:AuraRemainingTime(5217) <= 2) or (NAG:RemainingTime() < 2) or NAG:IsActive(5217) or (NAG:AuraRemainingTime(81022) < 2)) and NAG:IsActive(81022) and NAG:IsActive(768)) and NAG:Cast(6785))
        or     (((NAG:CurrentComboPoints() < 5.0) and NAG:IsActive(768)) and NAG:Cast(5221))
        or     ((((NAG:CurrentEnergy() > 70.0) or NAG:IsActive(16870) or (NAG:DotRemainingTime(1079) <= 2)) and NAG:IsActive(5487)) and NAG:Cast(768))
        or     (((NAG:CurrentEnergy() < 25.0) and (NAG:DotRemainingTime(1822) > 6) and (NAG:DotRemainingTime(1079) > 5) and (NAG:TimeToReady(5217) > 6) and (NAG:TimeToReady(49376) > 1) and (not NAG:IsActive(50334)) and NAG:IsActive(768) and (not ((NAG:CurrentEnergy() >= 20.0) and (NAG:AuraRemainingTime(5217) > 2)))) and NAG:Cast(5487))
        or     (NAG:IsActive(5487) and NAG:Cast(5229))
        or     ((NAG:IsActive(5487) and (NAG:DotRemainingTime(33745) <= 1.5)) and NAG:Cast(33745))
        or     ((NAG:IsActive(5487) and NAG:AuraIsActive(93622)) and NAG:Cast(33878))
        or     ((NAG:IsActive(5487) and (NAG:CurrentRage() >= 15.0)) and NAG:Cast(33878))
        or     ((NAG:IsActive(5487) and (NAG:DotRemainingTime(770) < 60) and (NAG:DotRemainingTime(770) < NAG:RemainingTime())) and NAG:Cast(16857))
        or     (NAG:IsActive(5487) and NAG:Cast(33745))
        or     ((((NAG:CurrentRage() > 45.0)) and NAG:IsActive(5487)) and NAG:Cast(6807))
    ]]
}

-- Feral Guardian Rotation
local feralGuardianRotation = {
    name = "Cataclysm Feral Guardian",
    specIndex = 3,
    class = "DRUID",
    authors = { "@Darkfrog" },
    default = false,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = false,
    prePull = {
        { time = -10, action = "NAG:Cast(768)" },
        { time = -1.5, action = "NAG:Cast(NAG:GetBattlePotion())" },
        { time = 0, action = "NAG:Cast(49376)" }
    },
    macros = {
        { name = "Cat Form",  body = "#showtooltip\n/dmh start\n/cast !Cat Form\n/dmh snake\n/dmh end" },
        { name = "Bear Form", body = "#showtooltip\n/dmh start\n/cast !Bear Form\n/dmh snake\n/dmh end" }
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or     (((NAG:CurrentHealthPercent() < 0.30) and NAG:IsActive(5487)) and NAG:Cast(22842))
    or     (((NAG:CurrentHealthPercent() < 0.40) and NAG:IsActive(5487)) and NAG:Cast(61336))
    or     ((NAG:DotIsActive(33745) and (NAG:DotNumStacks(33745) == 3.0) and (NAG:DotRemainingTime(33745) <= 4) and NAG:IsActive(5487)) and NAG:Cast(80313))
    or     ((((not NAG:DotIsActive(770)) or (NAG:DotRemainingTime(770) <= 6)) and NAG:IsActive(5487)) and NAG:Cast(16857))
    or     (((NAG:DotRemainingTime(99) < 4.0) and NAG:IsActive(5487)) and NAG:Cast(99))
    or     (NAG:IsActive(5487) and NAG:Cast(50334))
    or     (NAG:IsActive(5487) and NAG:Cast(5229))
    or     NAG:Cast(82174)
    or     (((not NAG:DotIsActive(33745)) and (not NAG:IsActive(50334)) and (NAG:TimeToReady(50334) > 3) and NAG:IsActive(5487)) and NAG:Cast(33745))
    or     (NAG:IsActive(5487) and NAG:Cast(33878))
    or     (NAG:IsActive(5487) and NAG:Cast(77758))
    or     (NAG:IsActive(5487) and NAG:Cast(16857))
    or     ((NAG:DotIsActive(33745) and (NAG:DotNumStacks(33745) == 3.0) and ((not NAG:IsActive(80951)) or (NAG:AuraRemainingTime(80951) <= 4)) and NAG:IsActive(5487)) and NAG:Cast(80313))
    or     (((NAG:DotNumStacks(33745) < 3.0) and NAG:IsActive(5487)) and NAG:Cast(33745))
    or     (NAG:IsActive(5487) and NAG:Cast(6807))
    or     (((not NAG:DotIsActive(770)) and (not NAG:DotIsActive(35387)) and (not NAG:DotIsActive(8647)) and (not NAG:DotIsActive(29859))) and NAG:Cast(16857))
    or     (((not NAG:DotIsActive(29859)) and (not NAG:DotIsActive(16511)) and (not NAG:DotIsActive(33876)) and (not NAG:DotIsActive(33878)) and (not NAG:DotIsActive(57386)) and (NAG:CurrentComboPoints() <= 4.0) and NAG:IsActive(768)) and NAG:Cast(33876))
    or     (((NAG:CurrentEnergy() < 50.0) and (not NAG:IsActive(16870)) and (not NAG:IsReady(5217)) and NAG:IsReady(49376) and (not NAG:IsActive(2825)) and NAG:IsActive(768)) and NAG:Cast(49376))
    or     (((NAG:IsActive(5217) or (NAG:RemainingTime() < 11)) and NAG:IsActive(768)) and NAG:Cast(82174))
    or     (((((NAG:AuraRemainingTime(5217) > 5) and (NAG:TimeToReady(50334) > (NAG:RemainingTime() - 20))) or (NAG:RemainingTime() <= 26)) and NAG:IsActive(768)) and NAG:Cast(58145))
    or     ((NAG:IsActive(5217) and NAG:IsActive(768)) and NAG:Cast(50334))
    or     ((((NAG:CurrentEnergy() < 50.0) or (NAG:RemainingTime() < 7) or (NAG:CurrentComboPoints() == 5.0)) and NAG:IsActive(768) and (not NAG:IsActive(50334))) and NAG:Cast(5217))
    or     ((NAG:IsActive(16870) and ((NAG:CurrentComboPoints() <= 4.0) and (NAG:CurrentComboPoints() >= 1.0)) and NAG:IsActive(52610) and NAG:IsActive(768)) and NAG:Cast(5221))
    or     ((((NAG:DotRemainingTime(1079) < 4) or (not NAG:DotIsActive(1079))) and (NAG:CurrentComboPoints() == 5.0) and (NAG:IsActive(5217) or (NAG:TimeToReady(5217) > 3)) and (NAG:CurrentHealthPercent() > 0.60) and NAG:IsActive(768) and NAG:TierSetEquipped(13, 2)) and NAG:Cast(1079))
    or     ((((NAG:DotRemainingTime(1079) < 4) or (not NAG:DotIsActive(1079))) and (NAG:CurrentComboPoints() == 5.0) and (NAG:IsActive(5217) or (NAG:TimeToReady(5217) > 3)) and (NAG:CurrentHealthPercent() > 0.25) and NAG:IsActive(768) and (not NAG:TierSetEquipped(13, 2))) and NAG:Cast(1079))
    or     (((NAG:CurrentComboPoints() == 5.0) and (not NAG:DotIsActive(1079)) and (NAG:CurrentHealthPercent() <= 0.60) and NAG:IsActive(768) and NAG:TierSetEquipped(13, 2)) and NAG:Cast(1079))
    or     (((NAG:CurrentComboPoints() == 5.0) and (not NAG:DotIsActive(1079)) and (NAG:CurrentHealthPercent() <= 0.25) and NAG:IsActive(768) and (not NAG:TierSetEquipped(13, 2))) and NAG:Cast(1079))
    or     (((((not NAG:IsActive(52610)) and (NAG:DotRemainingTime(1079) > 2) and (NAG:CurrentComboPoints() >= 1.0) and (NAG:CurrentComboPoints() <= 2.0)) or ((NAG:CurrentComboPoints() == 5.0) and (NAG:AuraRemainingTime(52610) < 3) and (NAG:DotRemainingTime(1079) > 4))) and (NAG:RemainingTime() > 5) and NAG:IsActive(768)) and NAG:Cast(52610))
    or     ((((NAG:DotRemainingTime(1822) < 3) or (NAG:IsActive(5217) and (NAG:DotRemainingTime(1822) < (NAG:AuraRemainingTime(5217) + 11.0)) and (NAG:AuraRemainingTime(5217) < 4))) and NAG:IsActive(768) and (NAG:CurrentComboPoints() <= 4.0)) and NAG:Cast(1822))
    or     ((NAG:IsActive(16870) and NAG:IsActive(768)) and NAG:Cast(5221))
    or     ((((NAG:DotRemainingTime(1079) > 7) and (NAG:AuraRemainingTime(52610) > 8) and (NAG:CurrentComboPoints() == 5.0) and NAG:IsActive(768)) or (NAG:IsActive(50334) and (NAG:CurrentComboPoints() == 5.0) and (NAG:CurrentEnergy() > 55.0) and NAG:IsActive(768)) or ((NAG:RemainingTime() < 2) and (NAG:CurrentComboPoints() >= 3.0) and NAG:IsActive(768))) and NAG:Cast(22568))
    or     (((((NAG:CurrentEnergy() < 80.0) and (not ((NAG:CurrentComboPoints() == 5.0) and (NAG:DotRemainingTime(1079) < 6)))) or (NAG:AuraRemainingTime(5217) <= 2) or (NAG:RemainingTime() < 2) or NAG:IsActive(5217) or (NAG:AuraRemainingTime(81022) < 2)) and NAG:IsActive(81022) and NAG:IsActive(768)) and NAG:Cast(6785))
    or     (((NAG:CurrentComboPoints() < 5.0) and NAG:IsActive(768)) and NAG:Cast(5221))
]]
}

-- Feral Guardian (AoE) Rotation
local feralGuardianAoeRotation = {
    name = "Feral Guardian (AoE)",
    specIndex = 3,
    class = "DRUID",
    authors = { "@Darkfrog" },
    default = false,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = false,
    rotationString = [[
    ((NAG:DotIsActive(33745) and (NAG:AuraNumStacks(33745) == 3.0) and (NAG:DotRemainingTime(33745) <= 4)) and NAG:Cast(80313))
    or     (((not NAG:DotIsActive(770)) or (NAG:DotRemainingTime(770) <= 6)) and NAG:Cast(16857))
    or     (((NAG:DotRemainingTime(99) <= 4.0) or ((not NAG:DotIsActive(99)) and (not NAG:DotIsActive(702)) and (not NAG:DotIsActive(81132)) and (not NAG:DotIsActive(26016)) and (not NAG:DotIsActive(1160)))) and NAG:Cast(99))
    or     NAG:Cast(77758)
    or     NAG:Cast(779)
    or     NAG:Cast(50334)
    or     NAG:Cast(5229)
    or     NAG:Cast(82174)
    or     (((not NAG:DotIsActive(33745)) and (not NAG:IsActive(50334))) and NAG:Cast(33745))
    or     NAG:Cast(33878)
    or     NAG:Cast(16857)
    or     ((NAG:DotIsActive(33745) and (NAG:AuraNumStacks(33745) == 3.0) and ((not NAG:IsActive(80951)) or (NAG:AuraRemainingTime(80951) <= 4))) and NAG:Cast(80313))
    or     ((NAG:AuraNumStacks(33745) < 3.0) and NAG:Cast(33745))
    or     NAG:Cast(6807)
    ]]
}

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
-- Leave below as is

if UnitClassBase('player') ~= "DRUID" then return end

--- @class Druid : ClassBase
local Druid = NAG:CreateClassModule("DRUID", defaults)
if not Druid then return end

-- Setup class defaults during PreDatabaseRegistration
function Druid:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 1, balanceRotation)  -- Balance
    ns.AddRotationToDefaults(self.defaults, 2, feralCombatRotation)  -- Feral
    ns.AddRotationToDefaults(self.defaults, 3, feralGuardianRotation)  -- Guardian
    ns.AddRotationToDefaults(self.defaults, 3, feralGuardianAoeRotation)  -- Guardian
end

function Druid:RegisterSpellTracking()
    --- @type SpellTrackingManager|AceModule|CoreModule
    local SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
        SpellTrackingManager:RegisterPeriodicDamage({ 5570 }, { tickTime = nil, lastTickTime = nil }) -- Insect Swarm
end

NAG.Class = Druid
