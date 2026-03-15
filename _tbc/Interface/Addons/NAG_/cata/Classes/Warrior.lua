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

--- NAG
local defaults = ns.InitializeClassDefaults()

-- Add spec-level spell locations to defaults
defaults.class.specSpellLocations = {
    [1] = {  -- Arms
        [6544] = NAG.SPELL_POSITIONS.ABOVE, [6673] = NAG.SPELL_POSITIONS.ABOVE, [18499] = NAG.SPELL_POSITIONS.ABOVE,
        [2457] = NAG.SPELL_POSITIONS.BELOW, [2458] = NAG.SPELL_POSITIONS.BELOW,
        [1719] = NAG.SPELL_POSITIONS.LEFT, [85730] = NAG.SPELL_POSITIONS.LEFT,
        [1134] = NAG.SPELL_POSITIONS.LEFT, [20572] = NAG.SPELL_POSITIONS.LEFT,
        [6343] = NAG.SPELL_POSITIONS.AOE, [46924] = NAG.SPELL_POSITIONS.AOE,
        [1680] = NAG.SPELL_POSITIONS.AOE, [12328] = NAG.SPELL_POSITIONS.AOE
    },
    [2] = {  -- Fury
        [6544] = NAG.SPELL_POSITIONS.ABOVE, [6673] = NAG.SPELL_POSITIONS.ABOVE, [18499] = NAG.SPELL_POSITIONS.ABOVE,
        [2458] = NAG.SPELL_POSITIONS.BELOW, [2457] = NAG.SPELL_POSITIONS.BELOW,
        [1719] = NAG.SPELL_POSITIONS.LEFT, [12292] = NAG.SPELL_POSITIONS.LEFT, [1134] = NAG.SPELL_POSITIONS.LEFT,
        [1680] = NAG.SPELL_POSITIONS.AOE
    },
    [3] = {  -- Protection
        [6544] = NAG.SPELL_POSITIONS.ABOVE, [6673] = NAG.SPELL_POSITIONS.ABOVE, [18499] = NAG.SPELL_POSITIONS.ABOVE,
        [50720] = NAG.SPELL_POSITIONS.BELOW,
        [2565] = NAG.SPELL_POSITIONS.LEFT, [12809] = NAG.SPELL_POSITIONS.LEFT,
        [12975] = NAG.SPELL_POSITIONS.LEFT, [871] = NAG.SPELL_POSITIONS.LEFT
    }
}

-- Class assignments for raid coordination
defaults.class.classAssignments = {
    {
        id = "sunder_armor",
        name = "Sunder Armor",
        description = "Apply armor reduction debuff on targets (conflicts with Rogue Expose Armor)",
        spellIds = {7386, 7405, 8380, 11596, 11597, 25225, 47467}, -- All ranks (Cata uses rank 6)
        category = "debuff",
    },
    {
        id = "demoralizing_shout",
        name = "Demoralizing Shout",
        description = "Reduce enemy attack power (coordinate with other Warriors)",
        spellIds = {1160, 6190, 11554, 11555, 11556, 25202, 25203, 47437}, -- All ranks (Cata uses high rank)
        category = "debuff",
    },
    {
        id = "thunder_clap",
        name = "Thunder Clap",
        description = "Reduce enemy attack speed (coordinate with other Warriors)",
        spellIds = {6343, 8198, 8205, 11580, 11581, 25264, 47502}, -- All ranks (Cata uses rank 7)
        category = "debuff",
    },
}

-- Arms Rotation
local armsRotation = {
    name = "Cataclysm Arms - by @Fonsas",
    specIndex = 1,
    class = "WARRIOR",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = false,
    prePull = {
        { time = -5, action = "NAG:Cast(2457)" },
        { time = -2.6, action = "NAG:Cast(6673)" },
        { time = -2, action = "NAG:Cast(NAG:GetBattlePotion())" },
        { time = -1.5, action = "NAG:Cast(100)" }
    },
    burstTrackers = {
        { spellId = 85730, auraId = { 85730 } }, -- Deadly Calm
        { spellId = 6673,  auraId = { 6673 } },  -- Battle Shout
        { spellId = 1719,  auraId = { 1719 } },  -- Recklessness
    },
    rotationString = [[
 (((not UnitAffectingCombat("player"))) and NAG:Cast(100))
or UnitAffectingCombat("player") and (
        NAG:AutocastOtherCooldowns()
    or     (((NAG:IsExecutePhase(20) and (NAG:IsReady(69113) or NAG:IsReady(68972))) or (NAG:IsExecutePhase(20) and (not (NAG:SpellIsKnown(69113) or NAG:SpellIsKnown(68972))) and NAG:IsActive(57519)) or (NAG:RemainingTime() < 26.5)) and NAG:Cast(NAG:GetBattlePotion()))
    or     ((((NAG:AuraNumStacks(96923) == 5.0) and (NAG:IsReady(69113) or NAG:IsReady(68972)) and (NAG:DotIsActive(86346) or (NAG:TimeToReady(86346) > 6)) and ((NAG:RemainingTime() > 125) or NAG:IsExecutePhase(20))) or (NAG:RemainingTime() <= 16.5) or ((NAG:CurrentTime() >= 1.5) and NAG:IsReady(1719))) and NAG:Cast(33697))
    or     (((NAG:AuraNumStacks(96923) == 5.0) and (NAG:DotIsActive(86346) or (NAG:TimeToReady(86346) > 6) or (NAG:RemainingTime() <= 16.5)) and ((NAG:RemainingTime() > 125) or NAG:IsExecutePhase(20))) and NAG:Cast(69113))
    or     (((NAG:AuraNumStacks(96923) == 5.0) and (NAG:DotIsActive(86346) or (NAG:TimeToReady(86346) > 6) or (NAG:RemainingTime() <= 16.5)) and ((NAG:RemainingTime() > 125) or NAG:IsExecutePhase(20))) and NAG:Cast(68972))
    or     (((NAG:RemainingTime() > 120) or NAG:IsExecutePhase(20)) and NAG:Cast(59461))
    or     ((((NAG:RemainingTime() > 130) and (NAG:CurrentTime() >= 1.5)) or NAG:IsExecutePhase(20)) and NAG:Cast(62464))
    or     ((((NAG:RemainingTime() > 130) and (NAG:CurrentTime() >= 1.5)) or NAG:IsExecutePhase(20)) and NAG:Cast(62469))
    or     ((((NAG:CurrentTime() >= 1.5) and (NAG:RemainingTime() > 90)) or NAG:IsExecutePhase(20)) and NAG:Cast(77116))
    or     ((((NAG:CurrentTime() >= 1.5) and (NAG:RemainingTime() > 65)) or NAG:IsExecutePhase(20)) and NAG:Cast(69002))
    or     ((((NAG:CurrentTime() >= 1.5) and (not (NAG:SpellIsKnown(69113) or NAG:SpellIsKnown(68972)))) or (NAG:SpellIsKnown(69113) or NAG:SpellIsKnown(68972))) and NAG:Cast(82174))
    or     (((NAG:UnitDistance("target") >= 8.0)) and NAG:Cast(100))
    or     ((NAG:NumberTargets() > 1.0) and NAG:Cast(46924))
    or     ((NAG:NumberTargets() > 1.0) and NAG:Cast(12328))
    or     (false and NAG:Cast(64382))
    or     ((((NAG:RemainingTime() > 125) and (not (NAG:SpellIsKnown(69113) or NAG:SpellIsKnown(68972) or (NAG:NumEquippedStatProcTrinkets(6, -1, -1, 110) == 1.0)))) or ((NAG:RemainingTime() < 125) and NAG:IsExecutePhase(20) and (not (NAG:SpellIsKnown(69113) or NAG:SpellIsKnown(68972) or (NAG:NumEquippedStatProcTrinkets(6, -1, -1, 110) == 1.0)))) or NAG:AnyTrinketStatProcsActive(6, -1, -1, 110)) and NAG:Cast(33697))
    or     ((NAG:CurrentTime() >= 1.5) and NAG:Cast(1719))
    or     ((((NAG:CurrentTime() >= 1.5) and (NAG:RemainingTime() > 122) and (NAG:TimeToReady(78) < 1.5)) or ((NAG:RemainingTime() < 122) and NAG:IsExecutePhase(20) and ((NAG:TimeToReady(78) < 1.5) or (NAG:RemainingTime() < 11)))) and NAG:Cast(85730))
    or     NAG:Cast(1134)
    or     (((NAG:DotIsActive(86346) or ((NAG:TimeToReady(86346) > 5) and (NAG:RemainingTime() > 60))) and NAG:IsActive(2458)) and NAG:Cast(6544))
    or     (((not NAG:DotIsActive(772)) and (not NAG:IsActive(2457))) and NAG:Cast(2457))
    or     ((not NAG:DotIsActive(772)) and NAG:Cast(772))
    or     ((NAG:IsActive(60503) and (not NAG:IsExecutePhase(20)) and (NAG:AuraRemainingTime(60503) <= 5)) and NAG:Cast(2457))
    or     ((NAG:IsActive(60503) and (not NAG:IsExecutePhase(20)) and (NAG:AuraRemainingTime(60503) <= 5)) and NAG:Cast(7384))
    or     ((NAG:SpellCanCast(12294) or (NAG:SpellCanCast(86346) and (not NAG:DotIsActive(86346)))) and NAG:Cast(2458))
    or     ((NAG:IsActive(99234) and (NAG:RemainingTime() > 6)) and NAG:Cast(6673))
    or     (((NAG:RemainingTime() > 1.5) and (not (NAG:IsExecutePhase(20) and (NAG:DotIsActive(86346) or (NAG:IsActive(105907) and (NAG:DotRemainingTime(86346) >= 3))) and NAG:IsActive(57519)))) and NAG:Cast(12294))
    -- Hide: or (((NAG:CurrentRage() < 75.0) and (NAG:AutoTimeToNext() >= 2.5) and (not (NAG:IsActive(2825) or NAG:IsActive(85730) or NAG:IsActive(1719))) and NAG:IsReady(100)) and NAG:MoveToRange(9))
    or     (((not NAG:DotIsActive(86346)) and (NAG:RemainingTime() > 3)) and NAG:Cast(86346))
    or     ((((NAG:CurrentRage() > 75.0) or (NAG:IsActive(86627) and (NAG:CurrentRage() >= 65.0))) or NAG:IsActive(85730) or NAG:AuraIsActive(12964) or ((NAG:TimeToReady(85730) < 1) and (not (NAG:TimeToReady(1719) < 1)) and (NAG:CurrentRage() > 30.0) and (not (NAG:RemainingTime() < 123))) or ((NAG:CurrentRage() >= 50.0) and ((NAG:TimeToReady(12294) >= 1.5) or NAG:IsActive(86627)) and NAG:IsExecutePhase(20)) or ((NAG:RemainingTime() < 2) and (NAG:CurrentRage() >= 40.0)) or (NAG:SpellIsKnown(105860) and NAG:IsActive(1134) and ((NAG:CurrentRage() > 70.0) or (NAG:IsActive(86627) and (NAG:CurrentRage() >= 35.0))))) and NAG:Cast(78))
    or     ((NAG:IsActive(60503) and NAG:GCDIsReady() and (not NAG:SpellCanCast(12294)) and (not (NAG:SpellCanCast(86346) and (NAG:DotRemainingTime(86346) < 1))) and (NAG:CurrentRage() >= 5.0) and ((not NAG:IsExecutePhase(20)) or ((not NAG:SpellCanCast(86346)) and NAG:AuraIsInactive(85730) and NAG:AuraIsInactive(1719) and (NAG:CurrentRage() < 50.0))) and NAG:AuraIsInactive(85730)) and NAG:Cast(2457))
    or     (NAG:IsActive(60503) and NAG:Cast(7384))
    or     ((((not NAG:IsActive(60503)) or NAG:IsExecutePhase(20)) or {}) and NAG:Cast(2458))
    or     NAG:Cast(5308)
    or     NAG:Cast(6673)
    or     ((NAG:DotRemainingTime(86346) <= 1.5) and NAG:Cast(86346))
    or     NAG:Cast(1464)
    or     NAG:Cast(18499)
    or     ((NAG:TimeToReady(86346) < NAG:TimeToReady(12294)) and NAG:Cast(86346, 10))
    or     NAG:Cast(12294, 10)
)
]]
}

-- Fury Rotation
local furyRotation = {
    name = "Cataclysm Fury - by @Mysto",
    specIndex = 2,
    class = "WARRIOR",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = false,
    prePull = {
        { time = -2, action = "NAG:Cast(2457)" },
        { time = -1.5, action = "NAG:Cast(6673)" },
        { time = -0.1, action = "NAG:Cast(NAG:GetBattlePotion())" },
        { time = -0.1, action = "NAG:Cast(12292)" },
        { time = -0.1, action = "NAG:Cast(100)" },
        { time = -0.1, action = "NAG:Cast(2458)" }
    },
    burstTrackers = {
        { spellId = 12292, auraId = { 12292 } }, -- Death Wish
        { spellId = 6673,  auraId = { 6673 } },  -- Battle Shout
        { spellId = 1719,  auraId = { 1719 } },  -- Recklessness
    },
    rotationString = [[
        NAG:SpellCastSequence()
        or NAG:AutocastOtherCooldowns()
        or ((NAG:UnitDistance("target") >= 8) and (NAG:UnitDistance("target") <= 25) and (NAG:Cast(20252)))
        or ((NAG:IsExecutePhase(20) or (NAG:RemainingTime() >= 252) or (NAG:RemainingTime() <= 12)) and NAG:Cast(1719))
        or ((NAG:IsExecutePhase(20) or (NAG:RemainingTime() >= 174) or (NAG:RemainingTime() <= 30)) and NAG:Cast(12292))
        or ((NAG:IsExecutePhase(20) or (NAG:RemainingTime() >= 174) or (NAG:RemainingTime() <= 30)) and NAG:Cast(33697))
        or NAG:Cast(82174)
        or (NAG:IsExecutePhase(20) and NAG:Cast(NAG:GetBattlePotion()))
        or (((NAG:CurrentRage() >= 75.0)) and NAG:Cast(1134))
        or (((not NAG:IsActive(12292)) and (not NAG:IsActive(14202)) and NAG:IsReady(85288)) and NAG:Cast(18499))
        or ((not NAG:IsActive(108126)) and NAG:Cast(86346))
        --or (NAG:IsActive(108126) and NAG:Cast(6544))
        or ((((NAG:AuraNumStacks(90806) < 5.0) or (NAG:AuraRemainingTime(90806) <= 1.5)) and NAG:IsExecutePhase(20)) and NAG:Cast(5308))
        or ((NAG:NumberTargets() >= 4.0) and NAG:Cast(1680))
        or NAG:Cast(23881)
        --or (((NAG:NumberTargets() == 1.0) and (NAG:AuraIsActive(12964) or ((NAG:CurrentRage() >= 70.0) and NAG:IsExecutePhase(20)) or ((NAG:CurrentRage() >= 80.0) and (not NAG:IsExecutePhase(20))) or ((NAG:CurrentRage() >= 50.0) and NAG:AuraIsActive(108126)) or ((NAG:CurrentRage() >= 50.0) and NAG:AuraIsActive(86627)))) and NAG:Cast(78))
        --or (((NAG:NumberTargets() > 1.0) and (NAG:AuraIsActive(12964) or ((NAG:CurrentRage() >= 30.0) and NAG:IsExecutePhase(20)) or ((NAG:CurrentRage() >= 80.0) and (not NAG:IsExecutePhase(20))) or ((NAG:CurrentRage() >= 50.0) and NAG:AuraIsActive(108126)))) and NAG:Cast(845))
        or (((NAG:NumberTargets() < 4.0) and (NAG:IsActive(14202) or NAG:IsActive(12292) or NAG:IsActive(18499))) and NAG:Cast(85288))
        or (NAG:IsActive(46916) and NAG:Cast(1464))
        or (((NAG:NumberTargets() == 1.0) and NAG:IsExecutePhase(20)) and NAG:Cast(5308))
        or NAG:Cast(6673)
        or NAG:CastPlaceholder(23881)
]]
}

-- Protection Rotation
local protectionRotation = {
    name = "Cataclysm Protection - by @Mysto",
    specIndex = 3,
    class = "WARRIOR",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = true,
    prePull = {
        { time = -10, action = "NAG:Cast(71)" },
        { time = -3, action = "NAG:Cast(6673)" },
        { time = -1.5, action = "NAG:Cast(18499)" },
        { time = -1, action = "NAG:Cast(NAG:GetBattlePotion())" }
    },
    burstTrackers = {
        { spellId = 469, auraId = { 469 } }, -- Commanding Shout
    },
    rotationString = [[
        NAG:SpellCastSequence()
        or NAG:Schedule(60,function() NAG:Cast(NAG:GetBattlePotion()) end)
        or ((NAG:UnitDistance("target") >= 8) and (NAG:UnitDistance("target") <= 25) and (NAG:Cast(100)))
        or NAG:Cast(50720)
        or NAG:Cast(12975)
        or NAG:Cast(871)
        or NAG:Cast(89637)
        or NAG:Sequence('tinkers', 82174, 82176)
        or ((NAG:CurrentHealthPercent() <= 0.35) and NAG:Sequence('trinkets', 69109, 68915, 68996))
        or NAG:Cast(2565)
        or ((not NAG:IsActive(2565)) and NAG:Cast(65109))
        or ((NAG:CurrentHealthPercent() <= 0.40) and NAG:Cast(12975))
        or ((NAG:CurrentHealthPercent() <= 0.30) and NAG:Cast(871))
        or ((NAG:CurrentHealthPercent() <= 0.20) and NAG:Cast(5512))
        --or ((NAG:CurrentRage() >= 50.0) and NAG:Cast(78))
        or NAG:Cast(23922)
        or ((not NAG:IsActive(772)) and NAG:Cast(772))
        or (NAG:Cast(6572))
        or ((NAG:DotRemainingTime(772) <= 14) and NAG:Cast(6343))
        or ((NAG:AuraRemainingTime(6343, "target") <= 3) and NAG:Cast(6343))
        or ((NAG:AuraRemainingTime(1160, "target") <= 3) and NAG:Cast(1160))
        --or NAG:Cast(12809)
        or NAG:Cast(46968)
        or ((not NAG:IsActive(6673)) and NAG:Cast(6673))
        or NAG:Cast(20243)
        or ((not NAG:IsActive(71)) and NAG:Cast(71))
        or NAG:CastPlaceholder(20243)
]]
}

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
-- Leave below as is


if UnitClassBase('player') ~= "WARRIOR" then return end

--- @class Warrior : ClassBase
local Warrior = NAG:CreateClassModule("WARRIOR", defaults, {
    weakAuraName = "Warrior Next Action Guide",
})
if not Warrior then return end

-- Setup class defaults during PreDatabaseRegistration
function Warrior:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 1, armsRotation)  -- Arms
    ns.AddRotationToDefaults(self.defaults, 2, furyRotation)  -- Fury
    ns.AddRotationToDefaults(self.defaults, 3, protectionRotation)  -- Protection
end

NAG.Class = Warrior
