local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
--- @type SpellTrackingManager|AceModule|CoreModule

local IsInGroup = _G.IsInGroup

--- NAG
local defaults = ns.InitializeClassDefaults()

-- Add spec-level spell locations to defaults
defaults.class.specSpellLocations = {
    [1] = {  -- Assassination
        [57934] = NAG.SPELL_POSITIONS.ABOVE,
        [79140] = NAG.SPELL_POSITIONS.LEFT, [1856] = NAG.SPELL_POSITIONS.LEFT, [14177] = NAG.SPELL_POSITIONS.LEFT,
        [58426] = NAG.SPELL_POSITIONS.LEFT, [13877] = NAG.SPELL_POSITIONS.LEFT, [13750] = NAG.SPELL_POSITIONS.LEFT,
        [51690] = NAG.SPELL_POSITIONS.LEFT, [14185] = NAG.SPELL_POSITIONS.LEFT, [36554] = NAG.SPELL_POSITIONS.LEFT,
        [14183] = NAG.SPELL_POSITIONS.LEFT,
        [51723] = NAG.SPELL_POSITIONS.AOE
    },
    [2] = {  -- Combat
        [57934] = NAG.SPELL_POSITIONS.ABOVE,
        [79140] = NAG.SPELL_POSITIONS.LEFT, [1856] = NAG.SPELL_POSITIONS.LEFT, [14177] = NAG.SPELL_POSITIONS.LEFT,
        [58426] = NAG.SPELL_POSITIONS.LEFT, [13877] = NAG.SPELL_POSITIONS.LEFT, [13750] = NAG.SPELL_POSITIONS.LEFT,
        [51690] = NAG.SPELL_POSITIONS.LEFT, [14185] = NAG.SPELL_POSITIONS.LEFT, [36554] = NAG.SPELL_POSITIONS.LEFT,
        [14183] = NAG.SPELL_POSITIONS.LEFT,
        [51723] = NAG.SPELL_POSITIONS.AOE
    },
    [3] = {  -- Subtlety
        [57934] = NAG.SPELL_POSITIONS.ABOVE,
        [1856] = NAG.SPELL_POSITIONS.RIGHT,
        [14183] = NAG.SPELL_POSITIONS.LEFT, [51713] = NAG.SPELL_POSITIONS.LEFT
    }
}

-- Class assignments for raid coordination
defaults.class.classAssignments = {
    {
        id = "expose_armor",
        name = "Expose Armor",
        description = "Apply armor reduction debuff on targets (conflicts with Warrior Sunder Armor)",
        spellIds = {8647, 8649, 8650, 11197, 11198, 26866, 48669}, -- All ranks (Cata uses rank 7)
        category = "debuff",
    },
    {
        id = "tricks_of_trade",
        name = "Tricks of the Trade",
        description = "Use Tricks of the Trade on a target (coordinate with other Rogues to spread benefits)",
        spellIds = {57934}, -- Tricks of the Trade
        category = "utility",
    },
}

-- Assassination Rotation
local assassinationRotation = {
    name = "Cataclysm Assassination - by @Bicarbxd",
    specIndex = 1,
    class = "ROGUE",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = false,
    prePull = {
        { time = -4, action = "NAG:Cast(57934)" }
    },
    rotationString = [[
    (((not NAG:DotIsActive(703)) and (NAG:IsActive(1784) or NAG:IsActive(11327))) and NAG:Cast(703))
        or (((not NAG:DotIsActive(1943)) and (NAG:CurrentComboPoints() >= 1.0)) and NAG:Cast(1943))
        or (((NAG:CurrentComboPoints() > 0.0) and (NAG:CurrentTime() == 0.0) and (NAG:RemainingTime() >= 9)) and NAG:Cast(5171))
        or ((not NAG:IsActive(5171)) and (NAG:RemainingTime() >= 9) and NAG:Cast(5171))
        or IsInGroup() and (((NAG:DotIsActive(1943) and NAG:IsActive(5171) and NAG:IsReady(57934)) and NAG:Cast(57934)))
        or ((NAG:DotIsActive(1943) and NAG:IsActive(5171)) and NAG:Cast(79140))
        or (((NAG:AuraRemainingTime(5171) <= 1) and NAG:IsActive(5171)) and NAG:Cast(32645))
        or (((NAG:DotRemainingTime(1943) <= 2.0) and (NAG:RemainingTime() >= 2.0) and (NAG:CurrentComboPoints() >= 4.0)) and NAG:Cast(1943))
        or (((not NAG:IsActive(58427)) and (NAG:CurrentComboPoints() < 5.0) and (NAG:CurrentEnergy() >= 45.0)) and NAG:Cast(1856))
        or ((((NAG:CurrentComboPoints() == 5.0) or (NAG:RemainingTime() <= 5)) and NAG:DotIsActive(79140)) and NAG:Cast(14177))
        or (((NAG:CurrentComboPoints() >= 4.0) and (((not NAG:IsActive(32645)) and (NAG:CurrentEnergy() >= 55.0)) or (NAG:IsActive(32645) and (NAG:CurrentEnergy() >= 80.0))) and (not NAG:IsExecutePhase(35))) and NAG:Cast(32645))
        or (((NAG:CurrentComboPoints() >= 5.0) and ((NAG:IsActive(32645) and (NAG:CurrentEnergy() >= 65.0)) or (not NAG:IsActive(32645))) and NAG:IsExecutePhase(35)) and NAG:Cast(32645))
        or ((NAG:IsExecutePhase(35) and NAG:IsReady(NAG:GetBattlePotion())) and NAG:Cast(NAG:GetBattlePotion()))
        or ((NAG:IsExecutePhase(35) and (NAG:CurrentComboPoints() <= 4.0)) and NAG:Cast(53))
        or (((not NAG:IsExecutePhase(35)) and (NAG:CurrentComboPoints() <= 3.0)) and NAG:Cast(1329))
        or NAG:Pooling()
]]
}

-- Combat Rotation
local combatRotation = {
    name = "Combat Rotation from Bicarbxd and Darkfrog (CATA)",
    specIndex = 2,
    class = "ROGUE",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = false,
    prePull = {
        { time = -5, action = "NAG:Cast(57934)" },
        { time = -1, action = "NAG:Cast(NAG:GetBattlePotion())" }
    },
    rotationString = [[
    NAG:SpellCastSequence()
    or     NAG:AutocastOtherCooldowns()
    or     IsInGroup() and (((NAG:IsReady(57934) and NAG.isPooling) and NAG:Cast(57934)))
    or     (((NAG:DotRemainingTime(2818) <= 1.5) and NAG:DotIsActive(2818) and (NAG:DotNumStacks(2818) == 5.0)) and NAG:Cast(5938))
    or     (((not NAG:IsActive(5171)) and (NAG:CurrentComboPoints() == 0.0)) and NAG:Cast(1752))
    or     ((NAG:IsActive(109949) and ((not NAG:IsActive(5171)) or (NAG:AuraRemainingTime(5171) <= 8.0)) and (NAG:RemainingTime() >= 9)) and NAG:Cast(5171))
    or     (((NAG:AuraRemainingTime(5171) < 3.0) and (NAG:CurrentComboPoints() <= 3.0) and (NAG:RemainingTime() >= 9)) and NAG:Cast(5171))
    or     ((NAG:IsReady(NAG:GetBattlePotion()) and (NAG:IsReady(13750) or NAG:IsActive(13750)) and (NAG:IsActive(84746) or (NAG:AuraRemainingTime(84747) >= 12))) and NAG:Cast(NAG:GetBattlePotion()))
    or     (((NAG:CurrentEnergy() <= 40.0) and (((not NAG:IsActive(109949)) and NAG:IsActive(2825)) or (not NAG:IsActive(109949)) or (NAG:RemainingTime() <= 10.0)) and (NAG:IsActive(84745) or NAG:IsActive(84746) or NAG:IsActive(84747))) and NAG:Cast(82174))
    or     (((NAG:CurrentEnergy() <= 40.0) and (((not NAG:IsActive(109949)) and NAG:IsActive(2825)) or (not NAG:IsActive(109949)) or (NAG:RemainingTime() <= 10.0)) and (NAG:IsActive(84745) or NAG:IsActive(84746) or NAG:IsActive(84747))) and NAG:Cast(33697))
    or     ((NAG:TimeToReady(51690) > 30) and NAG:Cast(82174))
    or     (((NAG:CurrentEnergy() <= 40.0) and (((not NAG:IsActive(109949)) and NAG:IsActive(2825)) or (not NAG:IsActive(109949)) or (NAG:RemainingTime() <= 10.0)) and (NAG:IsActive(84745) or NAG:IsActive(84746) or NAG:IsActive(84747))) and NAG:Cast(51690))
    or     (((NAG:TimeToReady(51690) > 15.0) or (NAG:RemainingTime() <= 20.0)) and NAG:Cast(26297))
    or     ((NAG:TimeToReady(13750) > 30) and NAG:Cast(26297))
    or     ((NAG:TimeToReady(13750) > 30) and NAG:Cast(33697))
    or     (((NAG:TimeToReady(51690) > 15.0) or (NAG:RemainingTime() <= 20.0)) and NAG:Cast(13750))
    or     (((NAG:TimeToReady(51690) > 15.0) or (NAG:RemainingTime() <= 20.0)) and NAG:Cast(33697))
    or     (((NAG:CurrentComboPoints() >= 5.0) and (not NAG:DotIsActive(1943)) and (not NAG:IsActive(84747)) and (not NAG:IsActive(13877)) and (not NAG:IsActive(13750)) and (NAG:RemainingTime() >= 12.0) and (not NAG:IsActive(2825)) and (NAG:DotIsActive(33876) or NAG:DotIsActive(16511) or NAG:DotIsActive(57386) or NAG:DotIsActive(29859))) and NAG:Cast(1943))
    or     ((NAG:CurrentComboPoints() >= 5.0) and NAG:Cast(2098))
    or     (((NAG:CurrentComboPoints() <= 4.0) and (not NAG:DotIsActive(84617)) and (NAG:AuraRemainingTime(5171) > 6.0) and (not NAG:IsActive(13877))) and NAG:Cast(84617))
    or     (((NAG:CurrentComboPoints() <= 4.0) and (not NAG:DotIsActive(84617)) and (NAG:AuraRemainingTime(5171) >= 12.0) and NAG:IsActive(13877)) and NAG:Cast(84617))
    or     ((((NAG:CurrentComboPoints() == 2.0) or (NAG:CurrentComboPoints() == 4.0)) and (NAG:CurrentEnergy() <= 40.0) and (not NAG:IsActive(13750)) and NAG:DotIsActive(84617)) and NAG:Cast(1776))
    or     (((not NAG:IsActive(13750)) and (not NAG:IsReady(13750)) and (not NAG:IsReady(51690)) and (NAG:CurrentEnergy() <= 30.0) and (NAG:CurrentComboPoints() <= 3.0)) and NAG:Cast(7676))
    or     (((NAG:CurrentComboPoints() < 5.0)) and NAG:Cast(1752))
    or     NAG:Pooling()
]]
}

-- Subtlety Rotation
local subtletyRotation = {
    name = "Subtlety Rotation from Bicarbxd and Darkfrog (CATA)",
    specIndex = 3,
    class = "ROGUE",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = false,
    prePull = {
        { time = -7, action = "NAG:Cast(57934)" },
        { time = -4, action = "NAG:Cast(NAG:GetBattlePotion())" },
        { time = -3, action = "NAG:Cast(1784)" },
        { time = -2.5, action = "NAG:Cast(14183)" },
        { time = -2, action = "NAG:Cast(5171)" }
    },
    rotationString = [[
    NAG:SpellCastSequence()
    or     NAG:AutocastOtherCooldowns()
    or     (((not NAG:DotIsActive(1943)) and NAG:IsReady(82174)) and NAG:Cast(82174))
    or     (((not NAG:DotIsActive(1943)) and (NAG:CurrentComboPoints() >= 5.0) and (NAG:RemainingTime() >= 10.0)) and NAG:Cast(1943))
    or     (((NAG:CurrentComboPoints() >= 5.0) and (NAG:DotRemainingTime(1943) <= 8) and NAG:DotIsActive(1943)) and NAG:Cast(2098))
    or     (((NAG:AuraRemainingTime(5171) <= 5.0) and (NAG:CurrentComboPoints() >= 5.0) and (NAG:RemainingTime() >= 8) and ((NAG:AuraRemainingTime(5171) <= 3.0) or (NAG:CurrentEnergy() <= 30.0)) and (NAG:DotRemainingTime(1943) > 8)) and NAG:Cast(5171))
    or     (((NAG:AuraRemainingTime(73651) <= 6.0) and (NAG:CurrentComboPoints() >= 5.0) and (NAG:RemainingTime() >= 10.0) and (NAG:DotRemainingTime(1943) > 8)) and NAG:Cast(73651))
    or     ((NAG:IsActive(109949) and (NAG:AuraRemainingTime(51713) <= 1.0) and (NAG:IsActive(51713) or NAG:UnitIsStealthed())) and NAG:Cast(8676))
    or     ((NAG:CurrentComboPoints() >= 5.0) and NAG:Cast(2098))
    or     (((NAG:DotRemainingTime(89775) <= 3.0) and (not NAG:IsActive(51713)) and (not NAG:UnitIsStealthed()) and (NAG:RemainingTime() >= 10.0) and ((NAG:CurrentComboPoints() < 4.0) or ((NAG:CurrentComboPoints() < 5.0) and ((NAG:CurrentEnergy() >= 80.0) or (NAG:AuraInternalCooldown(51699) >= 1.0))))) and NAG:Cast(16511))
    or     (((NAG:DotIsActive(91023) and NAG:IsActive(51713)) or (NAG:UnitIsStealthed())) and NAG:Cast(36554))
    or     ((NAG:DotIsActive(91023) and NAG:IsActive(51713)) and NAG:Cast(82174))
    or     ((NAG:DotIsActive(91023) and NAG:IsActive(51713) and NAG:IsReady(NAG:GetBattlePotion())) and NAG:Cast(NAG:GetBattlePotion()))
    or     (((not NAG:UnitIsStealthed()) and (NAG:DotRemainingTime(91023) <= 2.0) and (NAG:CurrentComboPoints() <= 2.0)) and NAG:Cast(51713))
    or     (((NAG:DotRemainingTime(91023) <= 2.0) and (NAG:CurrentComboPoints() <= 2.0) and (not NAG:IsActive(51713)) and (not NAG:UnitIsStealthed())) and NAG:Cast(1856))
    or     (((NAG:DotRemainingTime(91023) <= 2.0) and (NAG:CurrentComboPoints() <= 2.0) and (NAG:CurrentEnergy() >= 60.0) and (not NAG:IsReady(51713)) and (not NAG:UnitIsStealthed())) and NAG:Cast(58984))
    or     (((NAG:CurrentComboPoints() < 2.0) and (NAG:CurrentTime() > 1.0) and (NAG:IsActive(51713) or NAG:UnitIsStealthed())) and NAG:Cast(14183))
    or     ((((NAG:CurrentComboPoints() < 4.0) or ((NAG:CurrentComboPoints() < 5.0) and (NAG:CurrentEnergy() >= 95.0)) or ((NAG:AuraInternalCooldown(51699) >= 1.0) and (NAG:CurrentEnergy() >= 60.0) and (NAG:CurrentComboPoints() < 5.0)) or (NAG:AuraRemainingTime(51713) <= 1.0)) and (NAG:IsActive(51713) or NAG:UnitIsStealthed())) and NAG:Cast(8676))
    or     (((NAG:CurrentComboPoints() < 4.0) or ((NAG:CurrentComboPoints() < 5.0) and (NAG:CurrentEnergy() >= 95.0)) or ((NAG:AuraInternalCooldown(51699) >= 1.0) and (NAG:CurrentEnergy() >= 60.0) and (NAG:CurrentComboPoints() < 5.0))) and NAG:Cast(53))
    or     IsInGroup() and (NAG:Cast(57934))
    or     ((not NAG:IsReady(1856)) and NAG:Cast(14185))
    or     NAG:RogueHaT()
]]
}
-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
-- Leave below as is

if UnitClassBase('player') ~= "ROGUE" then return end

--- @class Rogue : ClassBase
local Rogue = NAG:CreateClassModule("ROGUE", defaults, {
    weakAuraName = "Rogue Next Action Guide",
})
if not Rogue then return end

-- Setup class defaults during PreDatabaseRegistration
function Rogue:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 1, assassinationRotation)  -- Assassination
    ns.AddRotationToDefaults(self.defaults, 2, combatRotation)  -- Combat
    ns.AddRotationToDefaults(self.defaults, 3, subtletyRotation)  -- Subtlety
end

NAG.Class = Rogue
