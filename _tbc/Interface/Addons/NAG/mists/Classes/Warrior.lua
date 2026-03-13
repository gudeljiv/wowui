local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
local UnitAffectingCombat = _G.UnitAffectingCombat
--- @type NAG|AceAddon
local NAG = ns.NAG
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
--- @type SpellTrackingManager|AceModule|CoreModule


--- NAG
local defaults = ns.InitializeClassDefaults()

-- Add spec-level spell locations to defaults
defaults.class.specSpellLocations = {
    [1] = { -- Arms
        -- ABOVE spells
        [845] = NAG.SPELL_POSITIONS.ABOVE,      -- Cleave
        [46924] = NAG.SPELL_POSITIONS.ABOVE,    -- Bladestorm
        [12328] = NAG.SPELL_POSITIONS.ABOVE,    -- Sweeping Strikes
        [1680] = NAG.SPELL_POSITIONS.ABOVE,     -- Whirlwind
        [6343] = NAG.SPELL_POSITIONS.ABOVE,     -- Thunder Clap
        [6552] = NAG.SPELL_POSITIONS.ABOVE,     -- Pummel
        [2457] = NAG.SPELL_POSITIONS.ABOVE, -- Battle Stance

        -- BELOW spells
        [6544] = NAG.SPELL_POSITIONS.BELOW,     -- Heroic Leap
        [78] = NAG.SPELL_POSITIONS.BELOW,       -- Heroic Strike
        [100] = NAG.SPELL_POSITIONS.BELOW,      -- Charge
        [1250619] = NAG.SPELL_POSITIONS.BELOW,  -- Charge

        -- RIGHT spells
        -- (empty)

        -- LEFT spells
        [1249459] = NAG.SPELL_POSITIONS.LEFT,  -- Shattering Throw
        [33697] = NAG.SPELL_POSITIONS.LEFT,     -- Blood Fury
        [6673] = NAG.SPELL_POSITIONS.LEFT,      -- Battle Shout
        [20572] = NAG.SPELL_POSITIONS.LEFT,     -- Blood Fury
        [18499] = NAG.SPELL_POSITIONS.LEFT,     -- Berserker Rage
        [1719] = NAG.SPELL_POSITIONS.LEFT,      -- Recklessness
        [126734] = NAG.SPELL_POSITIONS.LEFT,    -- Blood Fury
        [114207] = NAG.SPELL_POSITIONS.LEFT,    -- Blood Fury
        [114203] = NAG.SPELL_POSITIONS.LEFT,    -- Demoralizing Banner
        [114192] = NAG.SPELL_POSITIONS.LEFT,    -- Blood Fury
        [114206] = NAG.SPELL_POSITIONS.LEFT,    -- Skull Banner
        [12292] = NAG.SPELL_POSITIONS.LEFT,    -- Bloodbath

        -- AOE spells
        -- (empty)
    },
    [2] = { -- Fury
        -- ABOVE spells
        [845] = NAG.SPELL_POSITIONS.ABOVE,      -- Cleave
        [46924] = NAG.SPELL_POSITIONS.ABOVE,    -- Bladestorm
        [12328] = NAG.SPELL_POSITIONS.ABOVE,    -- Sweeping Strikes
        [1680] = NAG.SPELL_POSITIONS.ABOVE,     -- Whirlwind
        [6343] = NAG.SPELL_POSITIONS.ABOVE,     -- Thunder Clap

        -- BELOW spells
        [6544] = NAG.SPELL_POSITIONS.BELOW,     -- Heroic Leap
        [78] = NAG.SPELL_POSITIONS.BELOW,       -- Heroic Strike
        [100] = NAG.SPELL_POSITIONS.BELOW,      -- Charge
        [1250619] = NAG.SPELL_POSITIONS.BELOW,  -- Charge

        -- RIGHT spells
        -- (empty)

        -- LEFT spells
        [1249459] = NAG.SPELL_POSITIONS.LEFT,  -- Shattering Throw
        [33697] = NAG.SPELL_POSITIONS.LEFT,     -- Blood Fury
        [6673] = NAG.SPELL_POSITIONS.LEFT,      -- Battle Shout
        [20572] = NAG.SPELL_POSITIONS.LEFT,     -- Blood Fury
        [18499] = NAG.SPELL_POSITIONS.LEFT,     -- Berserker Rage
        [1719] = NAG.SPELL_POSITIONS.LEFT,      -- Recklessness
        [126734] = NAG.SPELL_POSITIONS.LEFT,    -- Blood Fury
        [114207] = NAG.SPELL_POSITIONS.LEFT,    -- Blood Fury
        [114203] = NAG.SPELL_POSITIONS.LEFT,    -- Demoralizing Banner
        [114192] = NAG.SPELL_POSITIONS.LEFT,    -- Blood Fury
        [114206] = NAG.SPELL_POSITIONS.LEFT,    -- Skull Banner

        -- AOE spells
        -- (empty)
    },
    [3] = { -- Protection
        -- ABOVE spells
        [6544] = NAG.SPELL_POSITIONS.ABOVE,     -- Heroic Leap
        [871] = NAG.SPELL_POSITIONS.ABOVE,      -- Shield Wall
        [114030] = NAG.SPELL_POSITIONS.ABOVE,   -- Vigilance
        [55694] = NAG.SPELL_POSITIONS.ABOVE,    -- Enraged Regeneration

        -- BELOW spells
        [46924] = NAG.SPELL_POSITIONS.BELOW,    -- Bladestorm
        [112048] = NAG.SPELL_POSITIONS.BELOW,   -- Shield Barrier

        -- RIGHT spells
        [845] = NAG.SPELL_POSITIONS.RIGHT,      -- Cleave
        [78] = NAG.SPELL_POSITIONS.RIGHT,       -- Heroic Strike
        [118000] = NAG.SPELL_POSITIONS.RIGHT,   -- Dragon Roar

        -- LEFT spells
        [6673] = NAG.SPELL_POSITIONS.LEFT,      -- Battle Shout
        [18499] = NAG.SPELL_POSITIONS.LEFT,     -- Berserker Rage
        [20572] = NAG.SPELL_POSITIONS.LEFT,     -- Blood Fury (Orc Racial)
        [114192] = NAG.SPELL_POSITIONS.LEFT,    -- Blood Fury (Pandaren)
        [114203] = NAG.SPELL_POSITIONS.LEFT,    -- Demoralizing Banner
        [114206] = NAG.SPELL_POSITIONS.LEFT,    -- Skull Banner
        [114207] = NAG.SPELL_POSITIONS.LEFT,    -- Blood Fury (Troll)
        [126734] = NAG.SPELL_POSITIONS.LEFT,    -- Blood Fury (variant)

        -- AOE spells
        -- (empty)
    }
}

-- Class assignments for raid coordination
defaults.class.classAssignments = {
    {
        id = "thunder_clap",
        name = "Thunder Clap",
        description = "Apply attack speed reduction debuff on targets",
        spellIds = {6343}, -- Thunder Clap
        category = "debuff",
    },
    {
        id = "demoralizing_banner",
        name = "Demoralizing Banner",
        description = "Place banner that reduces enemy attack power",
        spellIds = {114203}, -- Demoralizing Banner
        category = "debuff",
    },
}

-- Class-specific settings
defaults.class.enableSmartInterrupts = true
defaults.class.recommendPummel = true


--[[
arms changes
-- at the top

            NAG:AutocastOtherCooldowns()
    or ((NAG:SpellIsKnown(46924) and NAG:AuraIsActive(46924) and (NAG:AuraIsActive(46924) >= NAG:GCDTimeToReady()) and ((NAG:CurrentRage() <= 60) or NAG:AuraIsInactive(6673)))) and NAG:Cast(6673, nil, NAG.SPELL_POSITIONS.PRIMARY)
            or (NAG:AuraIsActive(46924) and NAG:NumberTargets() == 1 and (NAG:TimeToReady(12294)<=1 or NAG:TimeToReady(86346)<=1)) and NAG:CancelBladestorm()
            or (NAG:AuraIsActive(46924) and NAG:TimeToReady(12294) < NAG:TimeToReady(86346) and NAG:NumberTargets() == 1) and NAG:Cast(12294, 10)
            or (NAG:AuraIsActive(46924) and NAG:TimeToReady(12294) >= NAG:TimeToReady(86346) and NAG:NumberTargets() == 1) and NAG:Cast(86346, 10)

-- make all strict sequences have their first arcument be false
-- change all bladestorms to be NAG:Cast(46924) instead of
-- replace all NAG:SpellIsChanneling(46924) with NAG:AuraIsActive(46924)

--at the bottom

            or     ((NAG:TimeToReady(86346) < NAG:TimeToReady(12294)) and NAG:Cast(86346, 10))
            or     NAG:Cast(12294, 10)

            ]]

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
-- Leave below as is

if UnitClassBase('player') ~= "WARRIOR" then return end

-- Generic (0 spec / no spec selected): low-level abilities before choosing a spec
local genericRotation = {
    name = "Generic",
    specIndex = 0,
    class = "WARRIOR",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    rotationString = [[
    (not NAG:AuraIsActive(6673)) and NAG:SpellCanCast(6673) and NAG:Cast(6673)
    or (not NAG:InCombat("player")) and NAG:SpellCanCast(100) and NAG:Cast(100)
    or (NAG:SpellCanCast(772) and (not NAG:DotIsActive(772, "target"))) and NAG:Cast(772)
    or (NAG:SpellCanCast(78)) and NAG:Cast(78)
]],
}

-- Arms
local armsRotation = {
    -- Core identification
    name = "Arms",
    specIndex = 1,
    class = "WARRIOR",

    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    talents = {},
    experimental = false,
    prePull = {
        { time = -5.0, action = "NAG:Cast(2457)" },
        { time = -2.6, action = "NAG:Cast(6673)" },
        { time = -2.0, action = "NAG:GetBattlePotion()" },
        { time = -1.5, action = "NAG:Cast(100)" }
    },
    burstTrackers = {
        { spellId = 85730, auraId = { 85730 } }, -- Deadly Calm
        { spellId = 6673,  auraId = { 6673 } },  -- Battle Shout
        { spellId = 1719,  auraId = { 1719 } },  -- Recklessness
    },
    lastModified = "09/26/2025",
    rotationString = [[
NAG:AutocastOtherCooldowns()
or (NAG:SpellIsKnown(46924) and NAG:AuraIsActive(46924) and ((NAG:CurrentRage() <= 60) or NAG:AuraIsInactive(6673))) and NAG:Cast(6673, nil, NAG.SPELL_POSITIONS.PRIMARY)
or (NAG:AuraIsActive(46924) and NAG:NumberTargets() == 1 and (NAG:TimeToReady(12294)<=1 or NAG:TimeToReady(86346)<=1)) and NAG:CancelBladestorm()
or (NAG:AuraIsActive(46924) and NAG:TimeToReady(12294) < NAG:TimeToReady(86346) and NAG:NumberTargets() == 1) and NAG:Cast(12294, 10)
or (NAG:AuraIsActive(46924) and NAG:TimeToReady(12294) >= NAG:TimeToReady(86346) and NAG:NumberTargets() == 1) and NAG:Cast(86346, 10)
or ((not NAG:AuraIsActive(6673)) and (not UnitAffectingCombat("player"))) and NAG:Cast(6673)
or ((not NAG:AuraIsActive(2457)) and (not UnitAffectingCombat("player"))) and NAG:Cast(2457)
or ((not UnitAffectingCombat("player"))) and NAG:Cast(76095)
or ((not UnitAffectingCombat("player"))) and NAG:Cast(1249459)
or ((NAG:SpellIsKnown(46924) and NAG:AuraIsActive(46924) and (NAG:AuraRemainingTime(46924) >= NAG:GCDTimeToReady()) and ((NAG:CurrentRage() <= 60) or NAG:AuraIsInactive(6673)))) and NAG:Cast(6673)
or (NAG:GetClassSetting("recommendPummel", true) and NAG:GetClassSetting("enableSmartInterrupts", true) and (not NAG:WarriorShouldInterrupt()) and (NAG:GCDTimeToReady() >= 0.1) and (NAG:GCDTimeToReady() <= (NAG:GCDTimeValue() - 0.1)) and UnitAffectingCombat("player")) and NAG:Cast(6552)
or (NAG:GetClassSetting("recommendPummel", true) and NAG:GetClassSetting("enableSmartInterrupts", true) and NAG:WarriorShouldInterrupt() and NAG:IsTargetInterruptible()) and NAG:Cast(6552)
or (NAG:GetClassSetting("recommendPummel", true) and (not NAG:GetClassSetting("enableSmartInterrupts", true)) and NAG:IsTargetInterruptible()) and NAG:Cast(6552)
or NAG:Cast(1250619)
or ((NAG:IsExecutePhase(20) and ((NAG:AnyTrinketStatProcsActive(6) and (NAG:TrinketProcsMinRemainingTime(6) >= 10.0)) or (NAG:NumEquippedStatProcTrinkets(6) == 0)) and ((NAG:NumStatBuffCooldowns() <= 1) or ((NAG:TrinketProcsMaxRemainingICD(6) >= (NAG:RemainingTime() - 25.0)) and NAG:SpellIsReady(81268))) and NAG:SpellIsReady(1719) and NAG:SpellIsReady(12292)) or (NAG:RemainingTime() <= (NAG:GCDTimeToReady() + 25.0))) and NAG:Cast(76095)
or (((NAG:RemainingTime() > 130.0) and UnitAffectingCombat("player")) or (NAG:IsExecutePhase(20) and NAG:AuraIsActive(76095)) or (NAG:RemainingTime() <= (NAG:GCDTimeToReady() + 15.0))) and NAG:Cast(33697)
or ((NAG:CurrentTime() <= 1.5) and UnitAffectingCombat("player")) and NAG:Cast(1719)
or (((NAG:AuraRemainingTime(12880) <= 0.25) and (NAG:AuraIsActive(86346, "target") or NAG:SpellIsReady(118000) or ((NAG:CurrentTime() > 5.0) and NAG:SpellIsKnown(46924) and false) or ((not NAG:SpellCanCast(12294)) and NAG:SpellCanCast(46924) and (NAG:NumberTargets() == 1) and (not (NAG:AuraIsActive(86346, "target") and NAG:IsExecutePhase(20) and (NAG:CurrentRage() >= 30))) and (NAG:AuraIsActive(12292) or NAG:IsExecutePhase(20)) and ((not NAG:SpellIsReady(86346)) or (NAG:AuraRemainingTime(86346, "target") >= 3.0)) and NAG:GCDIsReady())) and UnitAffectingCombat("player")) or (NAG:RemainingTime() <= (NAG:GCDTimeToReady() + 6.0))) and NAG:Cast(18499)
or ((((NAG:RemainingTime() >= 185.0) or NAG:AuraIsActive(2825)) and NAG:AuraIsInactive(114206) and UnitAffectingCombat("player")) or (NAG:IsExecutePhase(20) and NAG:AuraIsActive(76095) and NAG:AuraIsInactive(114206)) or (NAG:RemainingTime() <= (NAG:GCDTimeToReady() + 10.0)) or ((NAG:CurrentTime() >= 10.0) and (NAG:CurrentTime() <= 11.0))) and NAG:Cast(114206)
or ((NAG:RemainingTime() > 125.0) or (NAG:IsExecutePhase(20) and NAG:AuraIsActive(76095)) or (NAG:RemainingTime() <= (NAG:GCDTimeToReady() + 20.0))) and NAG:CastAllStatBuffCooldowns('str')
or ((NAG:NumStatBuffCooldowns() >= 2) and (NAG:NumberTargets() == 1)) and NAG:Cast(126734)
-- Strictsequence filtered: only spellIds from NAG:Cast, removed none
or ((((NAG:RemainingTime() >= 72.0) or (NAG:IsExecutePhase(20) and (NAG:AuraIsActive(76095) or (NAG:RemainingTime() <= 15.0)))) and (NAG:NumStatBuffCooldowns() <= 1) and ((NAG:NumberTargets() == 1) or (NAG:CurrentTime() < 5.0) or (not NAG:SpellIsKnown(46924))))) and NAG:StrictSequence("someName170", false, 126734, 12292)
or (((NAG:RemainingTime() >= 72.0) or (NAG:IsExecutePhase(20) and (NAG:AuraIsActive(76095) or (NAG:RemainingTime() <= 15.0)))) and (NAG:NumStatBuffCooldowns() >= 2) and (NAG:NumberTargets() == 1)) and NAG:Cast(12292)
or ((((NAG:RemainingTime() >= 60.0) and (NAG:CurrentTime() >= 1.5)) or (NAG:IsExecutePhase(20) and (NAG:AuraIsActive(76095) or (NAG:RemainingTime() <= 15.0)))) and (NAG:AuraIsInactive(86346, "target") or (NAG:AuraIsActive(12292) and (NAG:AuraRemainingTime(12292) <= 1.5) and (not NAG:IsExecutePhase(20))) or ((NAG:RemainingTime() <= 1.5) and (not NAG:SpellCanCast(5308))))) and NAG:Cast(118000)
or (((NAG:RemainingTime() >= 95.0) and NAG:AuraIsKnown(123144) and UnitAffectingCombat("player")) or ((NAG:RemainingTime() >= 185.0) and UnitAffectingCombat("player")) or (NAG:IsExecutePhase(20) and NAG:AuraIsActive(76095) and UnitAffectingCombat("player")) or (NAG:RemainingTime() <= (NAG:GCDTimeToReady() + 12.0))) and NAG:Cast(1719)
or (NAG:NumberTargets() > 1) and NAG:Cast(1250616)
or (((NAG:CurrentRage() >= 100) or ((NAG:SpellTimeToReady(1250619) < 1.5) and (NAG:CurrentRage() > (NAG:MaxRage() - 35)) and (NAG:AutoTimeToNext() >= 1.5))) and (not ((NAG:SpellTimeToReady(86346) <= NAG:GCDTimeToReady()) and (NAG:SpellTimeToReady(12294) >= NAG:GCDTimeToReady()) and NAG:AuraIsInactive(86346, "target"))) and (NAG:NumberTargets() > 1) and NAG:AuraIsInactive(86346, "target")) and NAG:Cast(845)
or ((NAG:NumberTargets() > 1) and (((not NAG:DotIsActive(115768)) and (not NAG:DotIsActive(115768)) and (not NAG:DotIsActive(115768))) or ((NAG:NumberTargets() == 2) and NAG:SpellIsReady(46924) and (NAG:DotRemainingTime(115768) <= 2.0) and (NAG:DotRemainingTime(115768) <= 2.0)) or ((NAG:NumberTargets() == 3) and ((NAG:DotPercentIncrease(115768) > 0.1) or (NAG:DotPercentIncrease(115768) > 0.1) or (NAG:DotPercentIncrease(115768) > 0.1)) and (NAG:AuraIsKnown(58356) or ((NAG:DotPercentIncrease(115768) > 0.0) and (NAG:DotPercentIncrease(115768) > 0.0) and (NAG:DotPercentIncrease(115768) > 0.0)))) or ((NAG:NumberTargets() >= 4) and ((NAG:DotPercentIncrease(115768) > 0.1) or (NAG:DotPercentIncrease(115768) > 0.1) or (NAG:DotPercentIncrease(115768) > 0.1))))) and NAG:Cast(6343)
-- Strictsequence filtered: only spellIds from NAG:Cast, removed none
or (((NAG:NumberTargets() > 1) and NAG:IsExecutePhase(20) and NAG:AuraIsActive(76095))) and NAG:StrictSequence("someName986", false, 126734, 12292, 46924)
-- Strictsequence filtered: only spellIds from NAG:Cast, removed none
or (((NAG:NumberTargets() > 1) and ((not NAG:IsExecutePhase(20)) or (not NAG:SpellCanCast(76095))))) and NAG:StrictSequence("someName382", false, 126734, 12292, 46924)
-- Strictsequence filtered: only spellIds from NAG:Cast, removed none
or (((NAG:NumberTargets() > 1) and (NAG:CurrentTime() < 5.0))) and NAG:StrictSequence("someName565", false, 18499, 46924) -- TESTAR SE BLADESTORM VAI NO MEIO MANDATORIO
or (((NAG:CurrentRage() >= 100) or ((NAG:SpellTimeToReady(1250619) < 1.5) and (NAG:CurrentRage() > (NAG:MaxRage() - 35)) and (NAG:AutoTimeToNext() >= 1.5))) and (not ((NAG:SpellTimeToReady(86346) <= NAG:GCDTimeToReady()) and (NAG:SpellTimeToReady(12294) >= NAG:GCDTimeToReady()) and NAG:AuraIsInactive(86346, "target"))) and ((NAG:NumberTargets() == 1) or NAG:AuraIsActive(1250616))) and NAG:Cast(78)
or (NAG:AuraIsActive(1250616) and NAG:AuraIsActive(86346, "target") and (NAG:NumberTargets() >= 4) and ((NAG:AuraRemainingTime(86346, "target") > 1.5) or (not NAG:SpellCanCast(86346))) and ((not NAG:SpellCanCast(12294)) or (NAG:RemainingTime() <= 6.0))) and NAG:Cast(1464)
or ((NAG:AuraIsActive(86346, "target") and (not NAG:AuraIsKnown(123142))) or (NAG:RemainingTime() <= 3.0)) and NAG:Cast(5308)
or ((not NAG:AuraIsActive(86346, "target")) and NAG:IsExecutePhase(20) and ((NAG:RemainingTime() <= 26.5) or NAG:AuraIsActive(76095))) and NAG:Cast(86346)
or ((NAG:DotRemainingTime(115768) <= 3.0) and (NAG:NumberTargets() == 2)) and NAG:Cast(12294)
or NAG:Cast(12294)
-- Strictsequence filtered: only spellIds from NAG:Cast, removed none
or (((NAG:NumberTargets() == 1) and (not (NAG:AuraIsActive(86346, "target") and NAG:IsExecutePhase(20) and (NAG:CurrentRage() >= 30))) and (NAG:AuraIsActive(12292) or NAG:IsExecutePhase(20)) and ((not NAG:SpellIsReady(86346)) or (NAG:AuraRemainingTime(86346, "target") >= 3.0)) and (NAG:CurrentRage() >= 70))) and NAG:StrictSequence("someName735", false, 78, 46924)
or ((NAG:NumberTargets() == 1) and (not (NAG:AuraIsActive(86346, "target") and NAG:IsExecutePhase(20) and (NAG:CurrentRage() >= 30))) and (NAG:AuraIsActive(12292) or NAG:IsExecutePhase(20)) and ((not NAG:SpellIsReady(86346)) or (NAG:AuraRemainingTime(86346, "target") >= 3.0))) and NAG:Cast(46924)
or (NAG:AuraIsActive(86346, "target") and (not (NAG:SpellIsKnown(46924) and NAG:SpellIsReady(46924)))) and NAG:Cast(107570)
or ((NAG:AuraIsKnown(58356) or (NAG:NumberTargets() >= 7)) and (NAG:NumberTargets() >= 5) and (((NAG:DotPercentIncrease(115768) >= -0.2) and (NAG:DotPercentIncrease(115768) >= -0.2)) or ((NAG:DotPercentIncrease(115768) >= -0.2) and (NAG:DotPercentIncrease(115768) >= -0.2)) or ((NAG:DotPercentIncrease(115768) >= -0.2) and (NAG:DotPercentIncrease(115768) >= -0.2)))) and NAG:Cast(6343)
or (NAG:AuraIsActive(86346, "target") and NAG:AuraIsActive(1719)) and NAG:Cast(5308)
or (NAG:AuraIsActive(1250616) and NAG:AuraIsActive(86346, "target") and (not NAG:IsExecutePhase(20)) and ((NAG:AuraRemainingTime(86346, "target") > 1.5) or (not NAG:SpellCanCast(86346))) and (NAG:NumberTargets() >= 2)) and NAG:Cast(1464)
or (((NAG:NumberTargets() == 3) and NAG:AuraIsKnown(58356)) or (NAG:AuraIsKnown(58356) and (NAG:NumberTargets() >= 4) and (((NAG:DotPercentIncrease(115768) >= -0.2) and (NAG:DotPercentIncrease(115768) >= -0.2)) or ((NAG:DotPercentIncrease(115768) >= -0.2) and (NAG:DotPercentIncrease(115768) >= -0.2)) or ((NAG:DotPercentIncrease(115768) >= -0.2) and (NAG:DotPercentIncrease(115768) >= -0.2))))) and NAG:Cast(6343)
or ((NAG:AuraRemainingTime(86346, "target") <= 1.0) or ((NAG:AuraIsActive(1719) or (NAG:NumberTargets() >= 3)) and (NAG:AuraRemainingTime(86346, "target") <= 1.5))) and NAG:Cast(86346)
or ((NAG:NumberTargets() >= 4) and (not NAG:IsExecutePhase(20)) and (NAG:CurrentRage() >= 50)) and NAG:Cast(1464)
or (NAG:NumberTargets() >= 6) and NAG:Cast(6343)
or ((NAG:CurrentRage() >= 100) or NAG:AuraIsActive(86346, "target")) and NAG:Cast(5308)
or (NAG:AuraIsActive(86346, "target") or (NAG:RemainingTime() <= 1.5)) and NAG:Cast(6544)
or ((NAG:AuraIsActive(86346, "target") and ((NAG:AuraRemainingTime(86346, "target") <= 1.0) or (NAG:AuraIsActive(1719) and (NAG:AuraRemainingTime(86346, "target") <= 1.5))) and (not NAG:IsExecutePhase(20))) or (NAG:AuraIsActive(86346, "target") and (not NAG:IsExecutePhase(20)) and NAG:WarriorShouldSlamOverride()) or ((NAG:NumberTargets() >= 3) and NAG:AuraIsActive(1250616) and NAG:AuraIsActive(86346, "target"))) and NAG:Cast(1464)
or ((NAG:RemainingTime() <= 6.0) or (not NAG:AuraIsActive(139958))) and NAG:Cast(5308)
or ((not NAG:AuraIsActive(1719)) and NAG:AuraIsActive(60503)) and NAG:Cast(7384)
or ((NAG:AuraIsActive(86346, "target") or (NAG:CurrentRage() >= 100)) and (not NAG:IsExecutePhase(20))) and NAG:Cast(1464)
or NAG:Cast(5308)
or NAG:AuraIsActive(60503) and NAG:Cast(7384)
or (not NAG:IsExecutePhase(20)) and NAG:Cast(1464)
or ((NAG:CurrentRage() < 10)) and NAG:Cast(6673)
or (NAG:TimeToReady(86346) < NAG:TimeToReady(12294)) and NAG:Cast(86346, 10)
or NAG:Cast(12294, 10)
]],

    -- Tracked IDs for optimization
    spells = {78, 100, 2457, 5308, 6544, 6552, 6673, 7384, 845, 12294, 1249459, 1250616, 1250619, 126734, 12880, 1464, 1719, 18499, 33697, 46924, 5308, 58356, 60503, 6343, 76095, 81268, 86346, 114206, 115768, 118000, 12292, 123142, 123144, 139958, 1249459},
    items = {76095},
    author = "Diurdude"
}


local furyByCrumpslamRotation = {
    -- Core identification
    name = "Warrior Fury",
    specIndex = 2,
    class = "WARRIOR",

    -- Required parameters
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { time = -10.0, action = "NAG:Cast(2457)" },
        { time = -3.0, action = "NAG:Cast(6673)" },
        { time = -1.2, action = "NAG:Cast(76095)" },
        { time = -2.0, action = "NAG:Cast(64382)" },
        { time = -0.7, action = "NAG:Cast(100)" }
    },
    lastModified = "09/26/2025",
    rotationString = [[
NAG:AutocastOtherCooldowns()
or (not NAG:InCombat()) and NAG:Cast(1249459)
or (NAG:SpellIsKnown(46924) and NAG:AuraIsActive(46924) and ((NAG:CurrentRage() <= 60) or NAG:AuraIsInactive(6673))) and NAG:Cast(6673, nil, NAG.SPELL_POSITIONS.PRIMARY)
or (NAG:CurrentRage() <= (NAG:MaxRage() - 35)) and NAG:Cast(1250619)
or ((NAG:IsExecutePhase(20) and NAG:AnyTrinketStatProcsActive(1, 8, -1, 54)) or (NAG:RemainingTime() <= 25)) and NAG:Cast(76095)
or (not NAG:AuraIsActive(114206, "player", false)) and NAG:Cast(114206)
or ((NAG:RemainingTime() > 130.0) or (NAG:IsExecutePhase(20) and NAG:AuraIsActive(76095, "player", false)) or (NAG:RemainingTime() <= (NAG:GCDTimeToReady() + 15.0))) and NAG:Cast(33697)
or ((NAG:RemainingTime() > 65.0) or (NAG:IsExecutePhase(20) and NAG:AuraIsActive(76095, "player", false)) or (NAG:RemainingTime() <= (NAG:GCDTimeToReady() + 12.0))) and NAG:Cast(126734)
or (((not NAG:AuraIsActive(12880, "player", false)) or (NAG:AuraIsActive(86346, "target", true) and (NAG:AuraRemainingTime(86346, "target") <= 1.5) and (NAG:AuraNumStacks(131116, "player", true) == 0))) and (NAG:CurrentTime() > 1.0)) and NAG:Cast(18499)
or (NAG:AuraIsActive(86346, "target", false) and ((NAG:CurrentRage() >= 60) or ((NAG:CurrentRage() >= 40) and (not NAG:IsExecutePhase(20))))) and NAG:Cast(78)
or ((not NAG:IsExecutePhase(20)) and (NAG:CurrentRage() >= 90)) and NAG:Cast(78)
or NAG:Cast(1719)
or (NAG:AuraIsActive(86346, "target", true) or (NAG:SpellTimeToReady(86346) > 3.0)) and NAG:Cast(6544)
or ((NAG:AuraNumStacks(131116, "player", true) == 2) or ((NAG:AuraNumStacks(131116, "player", true) == 1) and NAG:AuraIsActive(1719, "player", false))) and NAG:Cast(86346)
or (NAG:SpellIsReady(23881) and (NAG:AuraNumStacks(131116, "player", true) == 2)) and NAG:Cast(85288)
or NAG:Cast(23881)
or NAG:Cast(86346)
or (NAG:CurrentTime() >= 3) and NAG:Cast(107570)
or ((not NAG:AnyTrinketStatProcsActive(1, -1, -1, 54)) and (not NAG:AuraIsActive(126734, "player", true)) and (not NAG:AuraIsActive(86346, "target", true)) and (not NAG:AuraIsActive(76095, "player", true)) and (not NAG:AuraIsActive(1719, "player", true)) and (not NAG:AuraIsActive(33697, "player", true)) and NAG:IsExecutePhase(20)) and NAG:Cast(85288)
or NAG:Cast(5308)
or (NAG:AuraIsActive(46916, "player", false) and (not NAG:AuraIsActive(86346, "target", true)) and (NAG:AuraNumStacks(131116, "player", true) <= 1)) and NAG:Cast(100130)
or NAG:Cast(85288)
or (NAG:NumberTargets() > 1) and NAG:Cast(1680)
or NAG:AuraIsActive(46916, "player", false) and NAG:Cast(100130)
or ((not NAG:SpellCanCast(1250619)) and (NAG:CurrentTime() >= 3.5)) and NAG:Cast(46924)
or (((NAG:CurrentRage() <= 80) and (not NAG:AuraIsActive(2825, "player", false)) and (not NAG:SpellIsKnown(46924))) or NAG:AuraIsActive(46924)) and NAG:Cast(6673)
or (not NAG:IsExecutePhase(20)) and NAG:Cast(100130)
-- Cast 23881 with 10 sec tolerance if its cooldown is shorter than 86346
or (NAG:SpellTimeToReady(23881) < NAG:SpellTimeToReady(86346)) and NAG:Cast(23881, 10)
-- Cast 86346 with 10 sec tolerance if its cooldown is shorter or equal to 23881
or NAG:Cast(86346, 10)
]],

    -- Tracked IDs for optimization
    spells = {78, 100, 1680, 5308, 6544, 6673, 12880, 18499, 23881, 46916, 46924, 64382, 85288, 86346, 100130, 107570, 114206, 1250619, 126734, 131116, 1719, 33697, 2825, 1249459},
    items = {76095},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {67482, 45792, 43399},
    author = "@Crumpslam"
}

-- Protection
local protectionByCrumpslamRotation = {
    -- Core identification
    name = "Warrior Protection",
    specIndex = 3,
    class = "WARRIOR",

    default = false,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    talents = {},
    prePull = {
        { time = -10.0, action = "NAG:Cast(71)" },
        { time = -3.0, action = "NAG:Cast(6673)" },
        { time = -1.5, action = "NAG:Cast(18499)" },
        { time = -1.0, action = "NAG:GetBattlePotion()" }
    },
    burstTrackers = {
        { spellId = 469, auraId = { 469 } }, -- Commanding Shout
    },
    lastModified = "09/26/2025",
    rotationString = [[
(NAG:AuraIsActive(12880) and (NAG:CurrentHealthPercent() <= 0.3)) and NAG:Cast(55694)
or ((not NAG:AuraIsActive(112048)) and (NAG:CurrentHealthPercent() <= 0.5) and (NAG:CurrentRage() >= 80)) and NAG:Cast(112048)
or ((NAG:AuraIsActive(122510) or (NAG:CurrentRage() >= 90)) and (NAG:NumberTargets() == 1)) and NAG:Cast(78)
or ((NAG:AuraIsActive(122510) or (NAG:CurrentRage() >= 90)) and (NAG:NumberTargets() >= 2)) and NAG:Cast(845)
or NAG:AutocastOtherCooldowns()
or (not NAG:IsActive(12880)) and NAG:Cast(18499)
or NAG:Cast(12292)
or NAG:Cast(6544)
or NAG:Cast(118000)
or (NAG:NumberTargets() > 3) and NAG:Cast(46924, nil, NAG.SPELL_POSITIONS.RIGHT)
or ((NAG:CurrentRage() >= 40) and (NAG:CurrentRage() < 60) and NAG:SpellIsReady(2565) and (not NAG:AuraIsActive(2565))) and NAG:Cast(6572)
or (not NAG:AuraIsActive(112048)) and (NAG:CurrentHealthPercent() <= 0.4) and NAG:Cast(112048)
or NAG:Cast(2565)
or NAG:AuraIsActive(2565) and NAG:Cast(23922)
or (NAG:CurrentHealthPercent() < 0.6) and NAG:Cast(34428)
or (NAG:CurrentHealthPercent() < 0.2) and NAG:Cast(5308)
or NAG:Cast(23922)
or NAG:AuraIsActive(84619) and NAG:Cast(6572)
or NAG:Cast(6572)
or (NAG:NumberTargets() > 3) and NAG:Cast(6343, nil, NAG.SPELL_POSITIONS.RIGHT)
or NAG:Cast(20243)
]],

    -- Tracked IDs for optimization
    spells = {71, 78, 469, 845, 20243, 23922, 2565, 34428, 5308, 55694, 6343, 6544, 6572, 6673, 112048, 118000, 12292, 122510, 12880, 18499, 46924, 84619},
    items = {},
    author = "@Crumpslam"
}
local protectionRotation =    {
    -- Core identification
    name = "Warrior Protection",
    specIndex = 3,
    class = "WARRIOR",

    -- Required parameters
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { time = -60.0, action = "NAG:Cast(6673)" }, -- Battle Shout
        { time = -10.0, action = "NAG:Cast(71)" }, -- Defensive Stance
        { time = -1.5, action = "NAG:GetBattlePotion()" },
        { time = -1.5, action = "NAG:Cast(1249459)" },
        { time = -0.5, action = "NAG:Cast(100)" } -- Charge
    },
    -- Per-rotation spellLocations override (same format as specSpellLocations)
    useCustomSpellLocations = true,
    spellLocations = {
        [6544] = NAG.SPELL_POSITIONS.ABOVE,      -- Heroic Leap
        [18499] = NAG.SPELL_POSITIONS.ABOVE,     -- Berserker Rage
        [126734] = NAG.SPELL_POSITIONS.ABOVE,    -- Blood Fury
        [6673] = NAG.SPELL_POSITIONS.LEFT,       -- Battle Shout
        [20572] = NAG.SPELL_POSITIONS.LEFT,      -- Blood Fury
        [6343] = NAG.SPELL_POSITIONS.LEFT,       -- Thunder Clap
        [46924] = NAG.SPELL_POSITIONS.BELOW,     -- Bladestorm
        [845] = NAG.SPELL_POSITIONS.RIGHT,       -- Cleave
        [78] = NAG.SPELL_POSITIONS.RIGHT,        -- Heroic Strike
        [20243] = NAG.SPELL_POSITIONS.PRIMARY,   -- Devastate
        [118000] = NAG.SPELL_POSITIONS.PRIMARY,  -- Dragon Roar
        [55694] = NAG.SPELL_POSITIONS.PRIMARY,   -- Enraged Regeneration
        [5308] = NAG.SPELL_POSITIONS.PRIMARY,    -- Execute
        [6572] = NAG.SPELL_POSITIONS.PRIMARY,    -- Revenge
        [2565] = NAG.SPELL_POSITIONS.PRIMARY,    -- Shield Block
        [23922] = NAG.SPELL_POSITIONS.PRIMARY,   -- Shield Slam
        [112048] = NAG.SPELL_POSITIONS.PRIMARY,  -- Shield Barrier
        [34428] = NAG.SPELL_POSITIONS.PRIMARY,   -- Victory Rush
    },
    lastModified = "11/18/2025",
    rotationString = [[
-- EMERGENCY DEFENSIVES (Priority 1) - Enraged Regeneration
(NAG:AuraIsActive(12880) and NAG:CurrentHealthPercent() <= 0.5 and NAG:SpellIsReady(55694)) and NAG:Cast(55694)

-- SHIELD BARRIER (Priority 2) - Emergency at <50% HP with >=80 rage
or ((not NAG:AuraIsActive(112048)) and (NAG:CurrentHealthPercent() <= 0.5) and (NAG:CurrentRage() >= 80) and NAG:SpellIsReady(112048)) and NAG:Cast(112048)

-- RAGE DUMP (Priority 3) - Prevent rage cap, only if target >20% HP
or ((NAG:AuraIsActive(122510) or NAG:AuraIsActive(122016) or (NAG:CurrentRage() >= 90)) and (NAG:NumberTargets() == 1) and (not NAG:IsExecutePhase(20)) and NAG:SpellIsReady(78)) and NAG:Cast(78) -- Heroic Strike
or ((NAG:AuraIsActive(122510) or NAG:AuraIsActive(122016) or (NAG:CurrentRage() >= 90)) and (NAG:NumberTargets() >= 2) and NAG:SpellIsReady(845)) and NAG:Cast(845) -- Cleave

-- SUNDER ARMOR STACKS (Priority 4) - Maintain 3 stacks (optimized from JSON)
or ((NAG:AuraNumStacks(113746, "target") < 3) or NAG:AuraShouldRefresh(113746, 2.0, 'target')) and NAG:SpellIsReady(20243) and NAG:Cast(20243)

-- COOLDOWNS (Priority 5)
or NAG:AutocastOtherCooldowns()
or (NAG:SpellIsReady(12292)) and NAG:Cast(12292) -- Shield Wall
or (NAG:SpellIsReady(6544)) and NAG:Cast(6544) -- Heroic Leap
or (NAG:SpellIsReady(118000)) and NAG:Cast(118000) -- Dragon Roar

-- BLADESTORM (Priority 6) - AOE cooldown (simplified from JSON, no item swap)
or (NAG:NumberTargets() > 3 and NAG:SpellIsKnown(46924) and NAG:SpellIsReady(46924) and not NAG:AuraIsActive(46924)) and NAG:Cast(46924)
or (NAG:AuraIsActive(46924) and NAG:SpellIsReady(6673)) and NAG:Cast(6673) -- Battle Shout during Bladestorm

-- SHIELD BLOCK OPTIMIZATION (Priority 7) - Revenge at 40-60 rage if Shield Block ready but not active
or ((NAG:CurrentRage() >= 40) and (NAG:CurrentRage() < 60) and NAG:SpellIsReady(2565) and (not NAG:AuraIsActive(2565)) and NAG:SpellIsReady(6572)) and NAG:Cast(6572)

-- SHIELD BARRIER (Priority 8) - Proactive at <80% HP if not active
or ((not NAG:AuraIsActive(112048)) and (NAG:CurrentHealthPercent() <= 0.8) and NAG:SpellIsReady(112048)) and NAG:Cast(112048)

-- SHIELD SLAM (Priority 9) - Prioritize when Shield Block is active for bonus damage
or (NAG:AuraIsActive(2565) and NAG:SpellIsReady(23922)) and NAG:Cast(23922)

-- MAIN ROTATION (Priority 10) - Rage generation
or (NAG:CurrentTime() == 0 and NAG:SpellIsReady(23922)) and NAG:Cast(23922) -- Shield Slam (opener)
or (NAG:SpellIsReady(23922)) and NAG:Cast(23922) -- Shield Slam

-- REVENGE (Priority 11) - When Shield Slam buff is active (Unshackled Fury)
or (NAG:AuraIsActive(84619) and NAG:SpellIsReady(6572)) and NAG:Cast(6572)

-- SHIELD BLOCK (Priority 12) - MoP active mitigation for physical damage (fallback, not priority)
or ((not NAG:AuraIsActive(2565)) and NAG:SpellIsReady(2565) and (NAG:CurrentRage() >= 60 or NAG:CurrentHealthPercent() <= 0.7)) and NAG:Cast(2565)

-- DEEP WOUNDS (Priority 13) - Apply Deep Wounds dot
or (not NAG:DotIsActive(115768) and NAG:SpellIsReady(20243)) and NAG:Cast(20243)

-- HEALING (Priority 14) - Self-healing at <60% HP
or (NAG:CurrentHealthPercent() < 0.6 and NAG:SpellIsReady(103840)) and NAG:Cast(103840) -- Impending Victory
or (NAG:CurrentHealthPercent() < 0.6 and NAG:SpellIsReady(34428)) and NAG:Cast(34428) -- Victory Rush

-- REVENGE (Priority 15) - Standard rotation
or (NAG:SpellIsReady(6572)) and NAG:Cast(6572)

-- AOE ROTATION (Priority 16)
or (NAG:AuraShouldRefresh(115798, 2.0, 'target') or (NAG:NumberTargets() > 2)) and NAG:SpellIsReady(6343) and NAG:Cast(6343) -- Thunder Clap

-- EXECUTE (Priority 17) - Execute phase (optimized from JSON)
or (NAG:IsExecutePhase(20) and NAG:SpellIsReady(5308)) and NAG:Cast(5308)

-- FILLER (Priority 18)
or (NAG:SpellIsReady(20243)) and NAG:Cast(20243) -- Devastate (filler)
]],

    -- New action-based format

    -- Tracked IDs for optimization
    spells = {78, 100, 845, 2565, 5308, 55694, 6343, 6544, 6572, 6673, 12292, 12880, 20243, 23922, 34428, 46924, 84619, 103840, 112048, 113746, 115768, 115798, 118000, 122016, 122510},
    items = {76090, 79329},
    auras = {},
    runes = {},

    -- Optional metadata
    guide = [[
Protection Warrior Rotation Guide (MoP)

Active Mitigation:
- Shield Block: Primary mitigation for physical damage. Prioritize rage spending here.
- Shield Barrier: Use for magic damage or as an emergency shield when <50% HP.

Rage Generation:
- Shield Slam: Top priority for rage generation. Use on cooldown.
- Revenge: Use on cooldown. Procs active mitigation bonuses.

Defensives:
- Enraged Regeneration: Emergency heal.
- Shield Wall: Major damage reduction cooldown.

AoE:
- Thunder Clap: Spread Deep Wounds and generate threat.
- Shockwave/Dragon Roar: Powerful AoE cooldowns.
- Cleave: Dump rage on multiple targets (3+).

Maintenance:
- Sunder Armor/Devastate: Maintain 3 stacks for armor reduction.
- Deep Wounds: Apply via Thunder Clap or Devastate.
]],
    glyphs = {83096, 43399, 43424},
    author = "Smufrik",

}

-- Warrior Fury Rotation
local furyRotationGroupVariables = {
    name = "Warrior Fury - NewFormat-test",
    specIndex = 2,
    class = "Warrior",
    default = false,
    enabled = false,
    experimental = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { time = -60.0, action = "NAG:Cast(6673)" },
            { time = -10.0, action = "NAG:Cast(2457)" },
            { time = -0.5, action = "NAG:Cast(76095)" },
            { time = -0.5, action = "NAG:Cast(1249459)" },
            { time = -0.5, action = "NAG:Cast(1250619)" }
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
or (NAG:CurrentRage() <= (NAG:MaxRage() - 35)) and NAG:Cast(1250619)
or ((NAG:IsExecutePhase(20) and NAG:AnyTrinketStatProcsActive(1, 8, -1, 54)) or (NAG:RemainingTime() <= 25.0)) and NAG:Cast(76095)
or (not NAG:AuraIsActive(114206, "player", false)) and NAG:Cast(114206)
or ((NAG:RemainingTime() > 125.0) or (NAG:IsExecutePhase(20) and NAG:AuraIsActive(76095, "player", false)) or (NAG:RemainingTime() <= (NAG:GCDTimeToReady() + 15.0))) and NAG:Cast(33697)
or (((NAG:RemainingTime() > 60.0) or (NAG:IsExecutePhase(20) and NAG:AuraIsActive(76095, "player", true)) or ((NAG:RemainingTime() <= (NAG:GCDTimeToReady() + 15.0)) or (NAG:SpellIsKnown(126734) and (NAG:RemainingTime() <= (NAG:GCDTimeToReady() + 25.0)))))) and NAG:CastAllStatBuffCooldowns(7)
or (((NAG:RemainingTime() > 65.0) or (NAG:IsExecutePhase(20) and NAG:AuraIsActive(76095, "player", true)) or (NAG:RemainingTime() <= (NAG:GCDTimeToReady() + 12.0))) and NAG:AuraIsInactive(93256, "player", true) and NAG:AuraIsInactive(93261, "player", true) and (NAG:SpellIsReady(86346) or (NAG:RemainingTime() <= (NAG:GCDTimeToReady() + 12.0)))) and NAG:Cast(126734)
or (((not NAG:AuraIsActive(12880, "player", false)) or (NAG:AuraIsActive(86346, "target", true) and (NAG:AuraNumStacks(131116, "player", true) == 0) and (not NAG:IsExecutePhase(20)))) and (NAG:CurrentTime() > 1.0)) and NAG:Cast(18499)
or NAG:Cast(1719)
or (NAG:AuraIsActive(86346, "target", true) or (NAG:SpellTimeToReady(86346) > 3.0)) and NAG:Cast(6544)
or ((NAG:AuraIsActive(86346, "target", false) and ((NAG:CurrentRage() >= 90) or ((NAG:CurrentRage() >= 60) and NAG:VariableRef("CS: Last HS GCDussy")) or ((NAG:CurrentRage() >= 40) and (not NAG:IsExecutePhase(20)) and ((NAG:AuraNumStacks(131116, "player", true) >= 1) or NAG:SpellIsReady(18499) or ((NAG:SpellTimeToReady(18499) > 29.0) and NAG:VariableRef("CS: Last HS GCDussy")))) or (NAG:VariableRef("CS: Last HS GCDussy") and NAG:SpellIsReady(107570)) or (NAG:AuraRemainingTime(86346, "target") < NAG:GCDTimeToReady()))) or ((not NAG:IsExecutePhase(20)) and (NAG:CurrentRage() >= 90) and (NAG:SpellTimeToReady(86346) > 3.0)) or (NAG:RemainingTime() < NAG:GCDTimeToReady()) or (NAG:VariableRef("Feather: Last HS GCDussy") and (not NAG:IsExecutePhase(20)))) and NAG:Cast(78)
or ((not NAG:AuraIsActive(86346, "target", true)) and (NAG:CurrentTime() >= 1.5)) and NAG:Cast(118000)
or (NAG:VariableRef("CS: Last GCDussy") or (NAG:RemainingTime() <= 3.0) or NAG:VariableRef("Feather: Last HS GCDussy")) and NAG:Cast(107570)
or (NAG:VariableRef("CS: Last GCDussy") or (NAG:RemainingTime() <= 3.0) or NAG:VariableRef("Feather: Last GCDussy")) and NAG:Cast(5308)
or (NAG:VariableRef("CS: Last GCDussy") or (NAG:RemainingTime() <= 3.0)) and NAG:Cast(85288)
or ((NAG:AuraNumStacks(131116, "player", true) == 2) or ((NAG:AuraNumStacks(131116, "player", true) == 1) and NAG:AuraIsActive(1719, "player", false)) or (NAG:RemainingTime() <= 7.5)) and NAG:Cast(86346)
or (NAG:VariableRef("CS: Last 2 GCDussies") and (NAG:IsExecutePhase(20) or NAG:SpellIsReady(18499) or (NAG:AuraNumStacks(131116, "player", true) >= 1))) and NAG:Cast(107570)
or NAG:VariableRef("CS: Last 2 GCDussies") and NAG:Cast(5308)
or ((NAG:SpellIsReady(23881) and (NAG:AuraNumStacks(131116, "player", true) == 2) and ((not NAG:IsExecutePhase(20)) or (not NAG:AuraIsActive(81099, "player", false)))) or (NAG:VariableRef("CS: Last 2 GCDussies") and ((NAG:AuraNumStacks(131116, "player", true) == 2) or (NAG:SpellIsReady(18499) and (NAG:AuraNumStacks(131116, "player", true) == 1))) and (not NAG:IsExecutePhase(20)))) and NAG:Cast(85288)
or NAG:Cast(23881)
or NAG:Cast(86346)
or (NAG:AuraIsActive(86346, "target", true) or (NAG:SpellTimeToReady(86346) > 1.5)) and NAG:Cast(107570)
or NAG:AuraIsActive(81099, "player", false) and NAG:Cast(5308)
or (NAG:NumberTargets() == 1) and NAG:GroupReference("Bladestussy: Cast")
or ((not NAG:AnyTrinketStatProcsActive(1, -1, -1, 54)) and (not NAG:AnyStatBuffCooldownsActive(1, 7, -1)) and (not NAG:AuraIsActive(86346, "target", true)) and (not NAG:AuraIsActive(76095, "player", true)) and (not NAG:AuraIsActive(1719, "player", true)) and (not NAG:AuraIsActive(33697, "player", true)) and NAG:IsExecutePhase(20)) and NAG:Cast(85288)
or NAG:Cast(5308)
or (NAG:AuraIsActive(46916, "player", false) and ((not NAG:AuraIsActive(86346, "target", true)) or (NAG:AuraIsActive(86346, "target", true) and ((NAG:SpellTimeToReady(23881) >= NAG:AuraRemainingTime(86346, "target")) or (NAG:AuraNumStacks(131116, "player", true) == 0)) and (not NAG:IsExecutePhase(20)))) and (NAG:AuraNumStacks(131116, "player", true) <= 1)) and NAG:Cast(100130)
or NAG:Cast(85288)
or (((not NAG:IsExecutePhase(20)) and (NAG:AuraIsActive(86346, "target", true) or (NAG:SpellTimeToReady(86346) > 3.0) or ((NAG:CurrentRage() >= 80) and (NAG:SpellTimeToReady(86346) > 1.5)))) or NAG:AuraIsActive(46916, "player", true)) and NAG:Cast(100130)
or (NAG:SpellTimeToReady(86346) > 1.0) and NAG:Cast(57755)
or (((NAG:CurrentRage() <= 80) and (not NAG:AuraIsActive(2825, "player", false)) and (not NAG:SpellIsKnown(46924))) or NAG:AuraIsActive(46924)) and NAG:Cast(6673)
or false and NAG:Cast(1249459)
]],

    -- Tracked IDs for optimization
    spells = {78, 1719, 2825, 5308, 6544, 6673, 12880, 18499, 23881, 33697, 46916, 46924, 57755, 81099, 85288, 86346, 100130, 107570, 114206, 118000, 126734, 131116, 138759, 1249459, 1250619},
    items = {76095, 93256, 93261},
    auras = {},
    runes = {},
    glyphs = {67482, 45792, 43399},
    consumables = { prepotId = 76095, potId = 76095, flaskId = 76088, foodId = 74646 },

    -- Groups and Variables from WoWSims APL
    groups = {
        {
            name = [[Bladestussy: Cast]],
            actions = {
                [[((NAG:VariableRef("Bladestussy: Should Cast") and NAG:SpellIsReady(46924))) and NAG:StrictSequence("someName572", nil, 78)]],
                [[NAG:VariableRef("Bladestussy: Should Cast") and NAG:ChannelSpell(46924, function() return ((NAG:SpellChanneledTicks(46924) == 3)) end, false)]]
            }
        }
        },
    variables = {
        {
            name = [[Feather: Last GCDussy]],
            value = [[(NAG:AuraIsKnown(138759) and (NAG:AuraNumStacks(138759, "player", true) >= 9))]]
        },
        {
            name = [[Feather: Last HS GCDussy]],
            value = [[(NAG:AuraIsKnown(138759) and (NAG:AuraNumStacks(138759, "player", false) == 10))]]
        },
        {
            name = [[CS: Last GCDussy]],
            value = [[(NAG:AuraIsActive(86346, "target", false) and (NAG:AuraRemainingTime(86346, "target") <= 1.0))]]
        },
        {
            name = [[CS: Last HS GCDussy]],
            value = [[(NAG:AuraIsActive(86346, "target", false) and (NAG:AuraRemainingTime(86346, "target") <= 1.5))]]
        },
        {
            name = [[CS: Last 2 GCDussies]],
            value = [[(NAG:AuraIsActive(86346, "target", false) and (NAG:AuraRemainingTime(86346, "target") <= 3.0))]]
        },
        {
            name = [[Bladestussy: Should Cast]],
            value = [[((not NAG:SpellCanCast(1250619)) and (not NAG:UnitIsMoving()) and (NAG:CurrentTime() >= 1.5) and (not (NAG:AuraIsActive(86346, "target", true) and (NAG:SpellCanCast(85288) or NAG:SpellCanCast(5308)))) and NAG:AuraIsInactive(46916, "player", true))]]
        }
        },

    -- Optional metadata
    talentsString = "133133",
    lastModified = "10/29/2025",
    author = "Diur"
}

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

--- @class Warrior : ClassBase
local Warrior = NAG:CreateClassModule("WARRIOR", defaults, {
    weakAuraName = "Warrior Next Action Guide",
})
if not Warrior then return end

function Warrior:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 0, genericRotation)  -- Generic (no spec)
    ns.AddRotationToDefaults(self.defaults, 3, protectionRotation)  -- Protection
    ns.AddRotationToDefaults(self.defaults, 3, protectionByCrumpslamRotation)  -- Protection
    ns.AddRotationToDefaults(self.defaults, 1, armsRotation)  -- Arms
    ns.AddRotationToDefaults(self.defaults, 2, furyByCrumpslamRotation)  -- Fury
    ns.AddRotationToDefaults(self.defaults, 2, furyRotationGroupVariables)  -- Fury
end

-- Override GetOptions to add class-specific settings
local BaseGetOptions = Warrior.GetOptions
function Warrior:GetOptions()
    -- Call base GetOptions (copied from ClassBase)
    local options = BaseGetOptions(self)

    -- Ensure options structure exists
    options.args = options.args or {}
    options.args.settings = options.args.settings or { type = "group", args = {} }
    options.args.settings.args = options.args.settings.args or {}

    -- Add Interrupt Settings
    options.args.settings.args.interrupts = {
        type = "group",
        name = "Interrupt Settings",
        order = 20,
        inline = true,
        args = {
            recommendPummel = {
                type = "toggle",
                name = "Recommend Pummel",
                desc = "Enable or disable Pummel suggestions in the rotation",
                get = function() return self:GetSetting("class", "recommendPummel", true) end,
                set = function(_, val) self:SetSetting("class", "recommendPummel", val) end,
                width = "full",
            },
            enableSmartInterrupts = {
                type = "toggle",
                name = "Enable Smart Interrupt Tracking",
                desc = "Track interrupt history to suggest Pummel when Glyph of Rude Interruption is active",
                get = function() return self:GetSetting("class", "enableSmartInterrupts", true) end,
                set = function(_, val) self:SetSetting("class", "enableSmartInterrupts", val) end,
                width = "full",
            },
        }
    }

    return options
end

NAG.Class = Warrior
