local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version

local defaults = ns.InitializeClassDefaults()

-- TBC Paladin spec spell locations
defaults.class.specSpellLocations = {
    [1] = {
        [20572] = NAG.SPELL_POSITIONS.LEFT, -- Blood Fury (Orc Racial)
        [26297] = NAG.SPELL_POSITIONS.LEFT, -- Berserking (Troll Racial)
        [28734] = NAG.SPELL_POSITIONS.LEFT, -- Mana Tap (BE Racial)
        [25046] = NAG.SPELL_POSITIONS.LEFT, -- Arcane Torrent (BE Racial)
    },  -- Holy
    [2] = {
        [20166] = NAG.SPELL_POSITIONS.LEFT, -- Seal of Wisdom
        [2812] = NAG.SPELL_POSITIONS.RIGHT, -- Holy Wrath
        [20572] = NAG.SPELL_POSITIONS.LEFT, -- Blood Fury (Orc Racial)
        [26297] = NAG.SPELL_POSITIONS.LEFT, -- Berserking (Troll Racial)
        [28734] = NAG.SPELL_POSITIONS.LEFT, -- Mana Tap (BE Racial)
        [25046] = NAG.SPELL_POSITIONS.LEFT, -- Arcane Torrent (BE Racial)
    },  -- Protection
    [3] = {
        [20218] = NAG.SPELL_POSITIONS.BELOW,
        [19740] = NAG.SPELL_POSITIONS.BELOW,
        [20572] = NAG.SPELL_POSITIONS.LEFT, -- Blood Fury (Orc Racial)
        [26297] = NAG.SPELL_POSITIONS.LEFT, -- Berserking (Troll Racial)
        [28734] = NAG.SPELL_POSITIONS.LEFT, -- Mana Tap (BE Racial)
        [25046] = NAG.SPELL_POSITIONS.LEFT, -- Arcane Torrent (BE Racial)
   },  -- Retribution
}

-- Self-heal when low health (generic rotation)
defaults.class.recommendSelfHeal = true
defaults.class.selfHealThreshold = 0.35

-- Class assignments for raid coordination (Protection: judgement selection overrides)
defaults.class.classAssignments = {
    {
        id = "judge_wisdom",
        name = "Judge Wisdom",
        description = "Maintain Judgement of Wisdom on the target (overrides default Prot judgement selection).",
        spellIds = {20355, 20354}, -- Judgement of Wisdom (TBC ranks)
        category = "debuff",
    },
    {
        id = "judge_crusader",
        name = "Judge Crusader",
        description = "Maintain Judgement of the Crusader on the target (overrides default Prot judgement selection).",
        spellIds = {21183}, -- Judgement of the Crusader (debuff id)
        category = "debuff",
    },
}

defaults.char.assignmentToggles = defaults.char.assignmentToggles or {}
if defaults.char.assignmentToggles.judge_wisdom == nil then
    defaults.char.assignmentToggles.judge_wisdom = false
end
if defaults.char.assignmentToggles.judge_crusader == nil then
    defaults.char.assignmentToggles.judge_crusader = false
end

-- Prot-only toggle (UI): never switch into seal twisting rotation
if defaults.char.protNeverSealTwist == nil then
    -- Default: twisting OFF (user can opt-in via Floating Selector)
    defaults.char.protNeverSealTwist = true
end

if UnitClassBase('player') ~= "PALADIN" then return end

-- Generic (0 talent points): low-level abilities before choosing a spec
local genericRotation = {
    name = "Generic",
    specIndex = 0,
    class = "PALADIN",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    rotationString = [[
    (NAG:GetClassSetting('recommendSelfHeal', true) and (NAG:CurrentHealthPercent() < (NAG:GetClassSetting('selfHealThreshold', 0.35) or 0.35)) and NAG:SpellCanCast(635)) and NAG:Cast(635)
    or (NAG:GetClassSetting('recommendSelfHeal', true) and (NAG:CurrentHealthPercent() < (NAG:GetClassSetting('selfHealThreshold', 0.35) or 0.35)) and NAG:SpellCanCast(19750)) and NAG:Cast(19750)
    or (not NAG:AuraIsActive(19740)) and NAG:SpellCanCast(19740) and NAG:Cast(19740)
    or (not NAG:AuraIsActive(20154)) and NAG:SpellCanCast(20154) and NAG:Cast(20154)
    or NAG:SpellCanCast(20271) and NAG:Cast(20271)
]],
}

-- Holy Rotation (spec 1)
-- Mouseover-based healing: uses NAG.state.healing from TBC HealingStateManager
local holyRotation = {
    name = "Holy",
    specIndex = 1,
    description = "Mouseover healing: Flash of Light, Holy Light, Cleanse.",
    class = "PALADIN",
    default = true,
    enabled = true,
    devOnly = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    lastModified = "02/08/2026",
    rotationString = [[
-- Cleanse on mouseover with dispellable debuff (Magic, Disease, Poison)
(NAG:MouseoverFriendlyExists() and NAG:MouseoverNeedsDispel() and NAG:SpellCanCast(4987)) and NAG:Cast(4987)

-- Divine Favor before big heal (instant, next spell guaranteed crit)
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 30
    and NAG:SpellCanCast(20216) and (not NAG:AuraIsActive(20216))) and NAG:Cast(20216)

-- Holy Light on critical mouseover (big heal)
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 40
    and NAG:SpellCanCast(635)) and NAG:Cast(635)

-- Flash of Light on low mouseover (fast, mana efficient)
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 75
    and NAG:SpellCanCast(19750)) and NAG:Cast(19750)

-- Flash of Light filler on moderate mouseover
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 90
    and NAG:SpellCanCast(19750)) and NAG:Cast(19750)

-- Seal of Wisdom for mana regeneration when low
or (NAG:CurrentManaPercent() <= 0.40 and (not NAG:AuraIsActive(20166))
    and NAG:SpellCanCast(20166)) and NAG:Cast(20166)

-- Damage filler: Judgement
or NAG:SpellCanCast(20271) and NAG:Cast(20271)
    ]],

    spells = {635, 4987, 19750, 20166, 20216, 20271},
    items = {},
    auras = {20166, 20216},
    author = "Smufrik",
}




-- Retribution Rotation
local protectionRotationSealTwisting = {
    -- Core identification
    name = "Prot Seal Twisting",
    specIndex = 2,
    class = "PALADIN",
    default = true,
    enabled = true,
    prePull = {
--        { time = -31.0, action = "NAG:Cast(48263)" },
--        { time = -30.0, action = "NAG:Cast(49222)" },
--        { time = -7.0, action = "NAG:Cast(42650)" },
--        { time = -1.5, action = "NAG:Cast(57330)" },
--        { time = -1.0, action = "NAG:Cast(76095)" }
    },

    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    rotationString = [[
NAG:EnableAssignmentsGate()
or
-- Rotation switching (anti ping-pong): this fallback guard is mirrored by the Prot->Twist entry guard in the
-- Protection rotation (combat/mana/RF/targets are symmetric). Additional Prot->Twist gates exist (toggle + SoC known).
(not(NAG:InCombat()) or NAG:CurrentManaPercent("player") <= 0.1 or (not NAG:AuraIsActive(25780)) or (not NAG:ProtSealTwistEnabled()) or (not NAG:SpellIsKnown(NAG:RetTwistGetSoCSealId()))) and NAG:SelectRotation("Protection")
or NAG:EnableTBCRetBars()
or ((not NAG:InCombat()) and (not NAG:TargetInMeleeRange(5)) and NAG:SpellCanCast(31935)) and NAG:Cast(31935, nil, NAG.SPELL_POSITIONS.LEFT) -- Avenger's Shield pull at range (OOC only)
or (not NAG:AuraIsActive(20925)) and NAG:SpellCanCast(20925) and NAG:Cast(20925, nil, NAG.SPELL_POSITIONS.LEFT)
or (NAG:InCombat() and NAG:ProtIsRangedPack(2, 7, 5) and (NAG:TargetMobType(NAG.Types.MobType.Undead) or NAG:TargetMobType(NAG.Types.MobType.Demon)) and NAG:SpellCanCast(2812)) and NAG:Cast(2812, nil, NAG.SPELL_POSITIONS.RIGHT) -- Holy Wrath (Undead/Demon)
or not(NAG:IsActive(20218)) and not(IsMounted()) and NAG:Cast(20218)
or not(NAG:IsActive(19740) or NAG:IsActive(25782) or NAG:IsActive(19977) or NAG:IsActive(19742) or NAG:IsActive(25894) or NAG:IsActive(20217) or NAG:IsActive(25898) or NAG:IsActive(27168) or NAG:IsActive(25899)) and NAG:Cast(19740, nil, NAG.SPELL_POSITIONS.LEFT)


or (NAG:InCombat() and not(NAG:IsAttacking()) and (not NAG:RetTwistIsSoCActive()) and NAG:Cast(NAG:RetTwistGetSoCSealId()))
or (NAG:InCombat() and not(NAG:IsAttacking()) and NAG:RetTwistIsSoCActive() and NAG:RetTwistNowWithOverlay("Startattack\nmacro"))

or ((not NAG:RetTwistIsSoCActive()) and NAG:Cast(NAG:RetTwistGetSoCSealId()))

-- 2) TWIST NOW (in-window): SoC active -> twist to SoB/SoM with overlay "NOW"
or (NAG:CanTwist(0.4, 0.1) and NAG:RetTwistIsSoCActive() and NAG:RetTwistNow())

-- 3) HOLD (div boundary): inside the sensitive region where a new GCD would push past twist window.
-- Show HOLD + show the upcoming twist seal to press.
or (
    -- Compute hold region once to avoid 1-tick flicker from multiple AutoTimeToNextAfterGCD() calls.
    NAG:RetTwistIsInHoldRegion(0.4)
    and NAG:RetTwistHold()
)

or (
    (NAG:AutoSwingTime() > 2.2)
    and (NAG:NumberTargets(5, false) >= 2)
    and NAG:TargetInMeleeRange(5)
    and (NAG:CurrentManaPercent() >= 0.4)
    and (NAG:RemainingTime() >= 5)
    and NAG:Cast(26573)
)
or (
     NAG:RetTwistIsSoCActive()
    and (NAG:AutoSwingTime() > 2.2)
    and (NAG:TargetMobType(NAG.Types.MobType.Undead) or NAG:TargetMobType(NAG.Types.MobType.Demon))
    and NAG:Cast(879)
)
or (
     NAG:TargetInMeleeRange(5)
    and (NAG:AutoSwingTime() > 2.2)
    and (NAG:CurrentManaPercent() >= 0.3)
    and (NAG:RemainingTime() >= 5)
    and NAG:Cast(26573)
)

-- Wait for AoE Consecration (same conditions as AoE Cons, but CD look-ahead before div)
or (
    (NAG:AutoSwingTime() > 2.2)
    and (NAG:NumberTargets(5, false) >= 2)
    and NAG:TargetInMeleeRange(5)
    and (NAG:CurrentManaPercent() >= 0.4)
    and (NAG:RemainingTime() >= 5)
    and (NAG:RetTwistWaitToleranceBeforeDiv(3, 0.4, 0.05) > 0)
    and (NAG:SpellTimeToReady(26573) > 0)
    and (NAG:SpellTimeToReady(26573) <= NAG:RetTwistWaitToleranceBeforeDiv(3, 0.4, 0.05))
    and NAG:Cast(26573, 3)
)

-- Wait for Exorcism (same conditions as Exo, but CD look-ahead before div)
or (
     NAG:RetTwistIsSoCActive()
    and (NAG:AutoSwingTime() > 2.2)
    and (NAG:RetTwistWaitToleranceBeforeDiv(3, 0.4, 0.05) > 0)
    and (NAG:TargetMobType(NAG.Types.MobType.Undead) or NAG:TargetMobType(NAG.Types.MobType.Demon))
    and (NAG:SpellTimeToReady(879) > 0)
    and (NAG:SpellTimeToReady(879) <= NAG:RetTwistWaitToleranceBeforeDiv(3, 0.4, 0.05))
    and NAG:Cast(879, 3)
)

-- Wait for ST Consecration (same conditions as ST Cons, but CD look-ahead before div)
or (
     NAG:TargetInMeleeRange(5)
    and (NAG:AutoSwingTime() > 2.2)
    and (NAG:CurrentManaPercent() >= 0.3)
    and (NAG:RemainingTime() >= 5)
    and (NAG:RetTwistWaitToleranceBeforeDiv(3, 0.4, 0.05) > 0)
    and (NAG:SpellTimeToReady(26573) > 0)
    and (NAG:SpellTimeToReady(26573) <= NAG:RetTwistWaitToleranceBeforeDiv(3, 0.4, 0.05))
    and NAG:Cast(26573, 3)
)

-- Otherwise, if we're before div and none of the above will happen in time, start HOLD early for twist (uses the existing HOLD swipe UX on the twist seal).
or (
    NAG:RetTwistIsSoCActive()
    and NAG:RetTwistHold()
)

or ((NAG:TargetMobType(NAG.Types.MobType.Undead) or NAG:TargetMobType(NAG.Types.MobType.Demon)) and NAG:Cast(879))
or NAG:TargetInMeleeRange(5)  and (NAG:RemainingTime() >= 5) and NAG:Cast(26573)
or NAG:Cast(20271, 2, nil, nil, "Judge\n+\nSoC")

]],
}




-- Protection Rotation
local protectionRotation = {
    -- Core identification
    name = "Protection",
    specIndex = 2,
    class = "PALADIN",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    rotationString = [[
NAG:EnableAssignmentsGate()
or
-- Maintain Righteous Fury (always)
(not NAG:AuraIsActive(25780)) and NAG:SpellCanCast(25780) and NAG:Cast(25780)
or
-- Aura management (out of combat)
((not NAG:InCombat()) and NAG:SpellIsKnown(20218) and (not NAG:IsActive(20218)) and (not IsMounted())) and NAG:Cast(20218, nil, NAG.SPELL_POSITIONS.BELOW) -- Sanctity Aura
or
((not NAG:InCombat()) and (not IsMounted()) and (not NAG:ProtHasNonCrusaderAuraActive()) and (NAG:ProtGetFallbackAuraSpellId() ~= nil)) and NAG:Cast(NAG:ProtGetFallbackAuraSpellId(), nil, NAG.SPELL_POSITIONS.BELOW) -- Any non-Crusader aura is fine
or
-- Blessings (out of combat): Sanctuary > Kings > Wisdom
-- If ANY blessing is already active, do not prompt for another blessing.
((not NAG:InCombat()) and (not NAG:ProtHasAnyBlessing()) and (not NAG:ProtHasBlessingSanctuary()) and NAG:SpellCanCast(20911)) and NAG:Cast(20911, nil, NAG.SPELL_POSITIONS.LEFT) -- Blessing of Sanctuary
or
((not NAG:InCombat()) and (not NAG:ProtHasAnyBlessing()) and (not NAG:ProtHasBlessingKings()) and (not NAG:SpellIsKnown(20911)) and NAG:SpellCanCast(20217)) and NAG:Cast(20217, nil, NAG.SPELL_POSITIONS.LEFT) -- Blessing of Kings
or
((not NAG:InCombat()) and (not NAG:ProtHasAnyBlessing()) and (not NAG:ProtHasBlessingWisdom()) and (not NAG:SpellIsKnown(20911)) and (not NAG:SpellIsKnown(20217)) and NAG:SpellCanCast(19742)) and NAG:Cast(19742, nil, NAG.SPELL_POSITIONS.LEFT) -- Blessing of Wisdom
or
-- Maintain assigned seal (Wisdom or Crusader)
-- We only need the matching seal up when we intend to (re)apply its judgement debuff,
-- and only if the target's TTD is confidently > 10s (avoid wasting GCDs on short-lived targets).
((NAG:ProtChooseJudgement() == "crusader") and (not NAG:ProtHasJudgementOfCrusader()) and (not NAG:RetTwistIsSoCrusaderActive()) and ((NAG:RemainingTime() > 10 and NAG:RemainingTime() < 7777) or (NAG:RemainingTime() >= 7777)) and NAG:SpellCanCast(NAG:RetTwistGetSoCrusaderSealId())) and NAG:Cast(NAG:RetTwistGetSoCrusaderSealId(), nil, NAG.SPELL_POSITIONS.LEFT) -- Seal of the Crusader
or
((NAG:ProtChooseJudgement() == "wisdom") and (not NAG:ProtHasJudgementOfWisdom("target")) and (not NAG:AuraIsActive(20166)) and ((NAG:RemainingTime() > 10 and NAG:RemainingTime() < 7777) or (NAG:RemainingTime() >= 7777)) and NAG:SpellCanCast(20166)) and NAG:Cast(20166, nil, NAG.SPELL_POSITIONS.LEFT) -- Seal of Wisdom
or
-- Maintain Holy Shield (always keep up; also pre-pull)
(not NAG:AuraIsActive(20925)) and NAG:SpellCanCast(20925) and NAG:Cast(20925)
or
-- Pre-pull opener: Avenger's Shield after Holy Shield is up (at range)
((not NAG:InCombat()) and NAG:AuraIsActive(20925) and (not NAG:TargetInMeleeRange(5)) and NAG:SpellCanCast(31935)) and NAG:Cast(31935, nil, NAG.SPELL_POSITIONS.LEFT) -- Avenger's Shield
or
-- Out of combat only: Avenger's Shield pull at range (avoid suggesting it in combat)
((not NAG:InCombat()) and (not NAG:TargetInMeleeRange(8)) and NAG:SpellCanCast(31935)) and NAG:Cast(31935, nil, NAG.SPELL_POSITIONS.LEFT) -- Avenger's Shield
or
-- In combat AoE (melee): Consecration on the pack
(NAG:InCombat() and (NAG:NumberTargets(5, false) >= 2) and NAG:TargetInMeleeRange(5) and NAG:SpellCanCast(20116)) and NAG:Cast(20116) -- Consecration
or
-- In combat AoE (ranged pack): Holy Wrath vs Undead/Demon (always RIGHT)
(NAG:InCombat() and NAG:ProtIsRangedPack(2, 7, 5) and (NAG:TargetMobType(NAG.Types.MobType.Undead) or NAG:TargetMobType(NAG.Types.MobType.Demon)) and NAG:SpellCanCast(2812)) and NAG:Cast(2812, nil, NAG.SPELL_POSITIONS.RIGHT) -- Holy Wrath
or
-- In combat: Judge chosen seal if the assigned judgement debuff is missing (only when the matching seal is up)
((NAG:ProtChooseJudgement() == "crusader") and (not NAG:ProtHasJudgementOfCrusader()) and NAG:RetTwistIsSoCrusaderActive() and NAG:SpellIsReady(20271)) and NAG:Cast(20271) -- Judgement (Crusader)
or
((NAG:ProtChooseJudgement() == "wisdom") and (not NAG:ProtHasJudgementOfWisdom("target")) and NAG:AuraIsActive(20166) and NAG:SpellIsReady(20271)) and NAG:Cast(20271) -- Judgement (Wisdom)
or
-- Exorcism vs Undead/Demon
((NAG:TargetMobType(NAG.Types.MobType.Undead) or NAG:TargetMobType(NAG.Types.MobType.Demon)) and NAG:SpellCanCast(879)) and NAG:Cast(879) -- Exorcism
or
-- Single-target Consecration (melee range)
(NAG:InCombat() and NAG:TargetInMeleeRange(5) and NAG:SpellCanCast(20116)) and NAG:Cast(20116) -- Consecration
-- If a judgeable seal is active on the player, cast Judgement (subject to assignment guards).
or (
    NAG:RetTwistIsSoCActive()
    or NAG:RetTwistIsSoBActive()
    or NAG:AuraIsActive(20166) -- Seal of Wisdom
    or NAG:AuraIsActive(20154) -- Seal of Righteousness (rank-aware)
    or (NAG:ProtGetVengeanceSealId() and NAG:AuraIsActive(NAG:ProtGetVengeanceSealId())) -- SoV / SoCorruption
)
    -- If we're currently in Seal of Wisdom and JoW is already on the target, do not re-judge it.
    and (not (NAG:AuraIsActive(20166) and NAG:ProtHasJudgementOfWisdom("target")))
    and ((NAG:ProtChooseJudgement() ~= "wisdom") or NAG:ProtHasJudgementOfWisdom("target") or (NAG:RemainingTime() <= 10))
    and ((NAG:ProtChooseJudgement() ~= "crusader") or NAG:ProtHasJudgementOfCrusader() or (NAG:RemainingTime() <= 10))
    and NAG:SpellIsReady(20271)
    and NAG:Cast(20271)
-- if mana is below 20% cast Seal of Wisdom
or (NAG:CurrentManaPercent("player") <= 0.2) and NAG:Cast(20166)
or
-- Seal management (no twisting): maintain SoV/SoCorruption stacks on target.
-- Rule: build/refresh with SoV/SoCorruption until 5 stacks; at 5 stacks swap to SoR (or SoC if known);
-- swap back when stacks drop below 5 or the debuff is about to expire (<8s).
(
    NAG:InCombat()
    and NAG:ProtGetVengeanceSealId()
    and ((not NAG:AuraIsActive(20166)) or (NAG:CurrentManaPercent("player") > 0.2))
    and ((NAG:ProtVengeanceStacks() < 5) or (NAG:ProtVengeanceRemaining() < 8))
    and (not NAG:AuraIsActive(NAG:ProtGetVengeanceSealId()))
    and ((NAG:ProtChooseJudgement() ~= "wisdom") or NAG:ProtHasJudgementOfWisdom("target") or (NAG:RemainingTime() <= 10))
    and ((NAG:ProtChooseJudgement() ~= "crusader") or NAG:ProtHasJudgementOfCrusader() or (NAG:RemainingTime() <= 10))
)
and NAG:Cast(NAG:ProtGetVengeanceSealId())
or (
    NAG:InCombat()
    and NAG:ProtGetVengeanceSealId()
    and ((not NAG:AuraIsActive(20166)) or (NAG:CurrentManaPercent("player") > 0.2))
    and (NAG:ProtVengeanceStacks() >= 5)
    and (NAG:ProtVengeanceRemaining() >= 8)
    and NAG:ProtGetFiveStackSwapSealId()
    and (not NAG:AuraIsActive(NAG:ProtGetFiveStackSwapSealId()))
    and ((NAG:ProtChooseJudgement() ~= "wisdom") or NAG:ProtHasJudgementOfWisdom("target") or (NAG:RemainingTime() <= 10))
    and ((NAG:ProtChooseJudgement() ~= "crusader") or NAG:ProtHasJudgementOfCrusader() or (NAG:RemainingTime() <= 10))
) and NAG:Cast(NAG:ProtGetFiveStackSwapSealId())
-- Fallback: if SoV/SoCorruption is not available at all, keep the legacy SoC/SoB seal behavior.
or (NAG:ProtGetVengeanceSealId() == nil
    and NAG:SpellIsKnown(NAG:RetTwistGetSoCSealId())
    and (not NAG:RetTwistIsSoCActive())
    and ((not NAG:AuraIsActive(20166)) or (NAG:CurrentManaPercent("player") > 0.2))
    and ((NAG:ProtChooseJudgement() ~= "wisdom") or NAG:ProtHasJudgementOfWisdom("target") or (NAG:RemainingTime() <= 10))
) and NAG:Cast(NAG:RetTwistGetSoCSealId())
or (NAG:ProtGetVengeanceSealId() == nil
    and NAG:SpellIsKnown(NAG:RetTwistGetTwistSealId())
    and (not NAG:RetTwistIsSoBActive())
    and (not NAG:RetTwistIsSoCActive())
    and ((not NAG:AuraIsActive(20166)) or (NAG:CurrentManaPercent("player") > 0.2))
    and ((NAG:ProtChooseJudgement() ~= "wisdom") or NAG:ProtHasJudgementOfWisdom("target") or (NAG:RemainingTime() <= 10))
) and NAG:Cast(NAG:RetTwistGetTwistSealId())

or
-- Swap to Prot seal twisting when available (explicit action, after core maintenance)
-- Use same guards as Prot Seal Twisting fallback to avoid ping-pong between rotations.
-- Symmetric gates: in-combat, mana > 10%, Righteous Fury active.
(
    NAG:InCombat()
    and NAG:ProtSealTwistEnabled()
    and NAG:SpellIsKnown(NAG:RetTwistGetSoCSealId())
    and (NAG:CurrentManaPercent("player") > 0.1)
    and NAG:AuraIsActive(25780)
    and NAG:SelectRotation("Prot Seal Twisting")
)
-- Lookahead (tolerance): Holy Shield, Consecration, Judgement - show whichever will be ready first (within 4s)
-- Judgement only when a judgeable seal is up (SoC/SoB/SoW, or SoW/SoCrusader up but not judged on target)
-- Not in melee: Holy Shield vs Judgement (if seal up)
or ((not NAG:TargetInMeleeRange(5)) and NAG:SpellTimeToReady(20925) >= 0 and NAG:SpellTimeToReady(20925) <= 4 and NAG:SpellTimeToReady(20925) <= (((NAG:RetTwistIsSoCActive() or NAG:RetTwistIsSoBActive() or (NAG:AuraIsActive(20166) and (not NAG:ProtHasJudgementOfWisdom("target"))) or (NAG:RetTwistIsSoCrusaderActive() and (not NAG:ProtHasJudgementOfCrusader())) or (NAG:AuraIsActive(20166) and (not NAG:ProtHasJudgementOfWisdom("target")))) and NAG:SpellTimeToReady(20271) >= 0 and NAG:SpellTimeToReady(20271)) or 999)) and NAG:Cast(20925, 4)
or ((not NAG:TargetInMeleeRange(5)) and (NAG:RetTwistIsSoCActive() or NAG:RetTwistIsSoBActive() or (NAG:AuraIsActive(20166) and (not NAG:ProtHasJudgementOfWisdom("target"))) or (NAG:RetTwistIsSoCrusaderActive() and (not NAG:ProtHasJudgementOfCrusader())) or (NAG:AuraIsActive(20166) and (not NAG:ProtHasJudgementOfWisdom("target")))) and NAG:SpellTimeToReady(20271) >= 0 and NAG:SpellTimeToReady(20271) <= 4 and NAG:SpellTimeToReady(20271) <= (NAG:SpellTimeToReady(20925) >= 0 and NAG:SpellTimeToReady(20925) or 999)) and NAG:Cast(20271, 4)
-- In melee: Holy Shield vs Consecration vs Judgement (if seal up)
or (NAG:TargetInMeleeRange(5) and NAG:SpellTimeToReady(20925) >= 0 and NAG:SpellTimeToReady(20925) <= 4 and NAG:SpellTimeToReady(20925) <= (NAG:SpellTimeToReady(20116) >= 0 and NAG:SpellTimeToReady(20116) or 999) and NAG:SpellTimeToReady(20925) <= (((NAG:RetTwistIsSoCActive() or NAG:RetTwistIsSoBActive() or (NAG:AuraIsActive(20166) and (not NAG:ProtHasJudgementOfWisdom("target"))) or (NAG:RetTwistIsSoCrusaderActive() and (not NAG:ProtHasJudgementOfCrusader())) or (NAG:AuraIsActive(20166) and (not NAG:ProtHasJudgementOfWisdom("target")))) and NAG:SpellTimeToReady(20271) >= 0 and NAG:SpellTimeToReady(20271)) or 999)) and NAG:Cast(20925, 4)
or (NAG:TargetInMeleeRange(5) and NAG:SpellTimeToReady(20116) >= 0 and NAG:SpellTimeToReady(20116) <= 4 and NAG:SpellTimeToReady(20116) <= (NAG:SpellTimeToReady(20925) >= 0 and NAG:SpellTimeToReady(20925) or 999) and NAG:SpellTimeToReady(20116) <= (((NAG:RetTwistIsSoCActive() or NAG:RetTwistIsSoBActive() or (NAG:AuraIsActive(20166) and (not NAG:ProtHasJudgementOfWisdom("target"))) or (NAG:RetTwistIsSoCrusaderActive() and (not NAG:ProtHasJudgementOfCrusader())) or (NAG:AuraIsActive(20166) and (not NAG:ProtHasJudgementOfWisdom("target")))) and NAG:SpellTimeToReady(20271) >= 0 and NAG:SpellTimeToReady(20271)) or 999)) and NAG:Cast(20116, 4)
or (NAG:TargetInMeleeRange(5) and (NAG:RetTwistIsSoCActive() or NAG:RetTwistIsSoBActive() or (NAG:AuraIsActive(20166) and (not NAG:ProtHasJudgementOfWisdom("target"))) or (NAG:RetTwistIsSoCrusaderActive() and (not NAG:ProtHasJudgementOfCrusader())) or (NAG:AuraIsActive(20166) and (not NAG:ProtHasJudgementOfWisdom("target")))) and NAG:SpellTimeToReady(20271) >= 0 and NAG:SpellTimeToReady(20271) <= 4 and NAG:SpellTimeToReady(20271) <= (NAG:SpellTimeToReady(20925) >= 0 and NAG:SpellTimeToReady(20925) or 999) and NAG:SpellTimeToReady(20271) <= (NAG:SpellTimeToReady(20116) >= 0 and NAG:SpellTimeToReady(20116) or 999)) and NAG:Cast(20271, 4)

    ]],
    guide = [[
Protection Paladin Rotation Guide (TBC)

Core Mechanics:
- Righteous Fury must be active to generate tank threat.
- Holy Shield is your core mitigation/threat tool; keep it up.
- Consecration is your main AoE threat tool but is mana intensive.
- Seals are situational: Righteousness for short fights, Vengeance for long fights, Wisdom for mana sustain.

Rotation Priority (Single Target):
1. Maintain Righteous Fury (always on while tanking).
2. Maintain Holy Shield (refresh on cooldown).
3. Use Avenger's Shield on pull or when safe to cast for burst threat.
4. Judgement on cooldown with your chosen seal.
5. Consecration when you have mana, can stand still, and mobs are in melee range.
6. Auto-attack with Seal active (Righteousness or Vengeance).
7. Swap to Seal of Wisdom if mana is becoming a limiting factor.

AoE Rotation:
1. Holy Shield on cooldown (more blocks = more threat).
2. Consecration under the pack (primary AoE threat; requires melee range).
3. Avenger's Shield for ranged pulls or extra snap threat.
4. Holy Wrath on Undead/Demon packs.
5. Judgement on the primary target to stabilize threat.

Mana Management:
- Consecration is expensive; skip or down-rank if mana is tight.
- Seal/Judgement of Wisdom is the primary tool for sustained mana.
- Blessing of Sanctuary reduces damage and provides extra threat on blocks.

Cooldowns and Defensive Tools:
- Ardent Defender is passive in TBC (no button to press).
- Divine Protection is an emergency physical immunity with Forbearance.
- Lay on Hands and potions are emergency options; coordinate with healers.

Raid Utility:
- Blessings and Auras are raid responsibilities; coordinate assignments.
- Righteous Fury + Holy Shield + Consecration make you the premier AoE tank.
    ]],
}

-- Retribution Rotation
local retributionRotation = {
    -- Core identification
    name = "Retribution",
    specIndex = 3,
    class = "PALADIN",
    default = true,
    enabled = true,
    prePull = {
--        { time = -31.0, action = "NAG:Cast(48263)" },
--        { time = -30.0, action = "NAG:Cast(49222)" },
--        { time = -7.0, action = "NAG:Cast(42650)" },
--        { time = -1.5, action = "NAG:Cast(57330)" },
--        { time = -1.0, action = "NAG:Cast(76095)" }
    },

    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    rotationString = [[
NAG:EnableTBCRetBars()
or not(NAG:IsActive(20218)) and not(IsMounted()) and NAG:Cast(20218)
or not(NAG:IsActive(19740) or NAG:IsActive(25782) or NAG:IsActive(19977) or NAG:IsActive(19742) or NAG:IsActive(25894) or NAG:IsActive(20217) or NAG:IsActive(25898) or NAG:IsActive(27168) or NAG:IsActive(25899)) and NAG:Cast(19740)
-- if in combat and target is bellow 20% health and target is not within melee range range > 5 then cast 24275
--or NAG:InCombat() and NAG:CurrentHealthPercent("target") < 0.2 and not(NAG:TargetInMeleeRange(5)) and NAG:Cast(24275, nil, NAG.SPELL_POSITIONS.LEFT)

-- ============================ SELF-APPLY JUDGEMENT OF THE CRUSADER ============================
-- Only active when: setting enabled AND grouped AND (≤2 paladins in group OR assignment forced).
-- Only applies when target level is higher than player level.
-- Only triggers at range (early pull phase). After judging, existing rotation handles stop attack -> SoC -> start.

-- Step 1: At range, apply Seal of Crusader (if debuff not on target and seal not active)
or (
    NAG:RetTwistShouldSelfApplyImpSoC()
    and not(NAG:InCombat())
    and (((UnitLevel("target") or 0) < 0) or ((UnitLevel("target") or 0) > (UnitLevel("player") or 0)))
    and (not NAG:TargetInMeleeRange(1))
    and (not NAG:RetTwistHasJudgementOfCrusaderDebuff())
    and (not NAG:RetTwistIsSoCrusaderActive())
    and NAG:SpellCanCast(NAG:RetTwistGetSoCrusaderSealId())
    and NAG:Cast(NAG:RetTwistGetSoCrusaderSealId(), nil, NAG.SPELL_POSITIONS.LEFT)
)

-- Step 2: At range, Judge Seal of Crusader (if seal active and debuff not on target)
or (
    NAG:RetTwistShouldSelfApplyImpSoC()
    and not(NAG:InCombat())
    and (((UnitLevel("target") or 0) < 0) or ((UnitLevel("target") or 0) > (UnitLevel("player") or 0)))
    and (not NAG:TargetInMeleeRange(1))
    and (not NAG:RetTwistHasJudgementOfCrusaderDebuff())
    and NAG:RetTwistIsSoCrusaderActive()
    and NAG:SpellIsReady(20271)
    and (NAG:Cast(NAG:RetTwistGetSoCSealId(), nil, NAG.SPELL_POSITIONS.AOE) or true)
    and NAG:Cast(20271, nil, nil, nil, "Judge + SoC\n and STOP Attack")
)
-- After judging, the existing rotation handles: don't attack from distance -> apply SoC -> start attack

-- ============================ PRE-COMBAT SEAL SETUP (DEFAULT) ============================
or (
    (not NAG:InCombat())
    and (not NAG:RetTwistIsSoCActive())
    --and (not NAG:RetTwistShouldPreferSoBForSwing(0.4, 3, 0.05, 0.2, 0.3))
    and NAG:Cast(NAG:RetTwistGetSoCSealId())
)
or (not NAG:InCombat()) and NAG:IsAttacking() and not(NAG:TargetInMeleeRange(1)) and NAG:CastWithOverlay(6603, "Don't start attacking\nfrom distance")
or ((not NAG:InCombat()) and NAG:RetTwistIsSoCActive() and NAG:RetTwistNowWithOverlay("Startattack\nmacro"))
--or UnitName("target") ~= "Dummy" and NAG:Cast(27173, 10)
-- Debug: print current swing state + projected state at GCD end (spam-friendly for slow-mo review).
-- Returns false so it does not affect the chosen recommendation.
--or (NAG:InCombat() and NAG:RetTwistDebugTick())

or (
    NAG:InCombat()
    and not(NAG:IsAttacking())
    and (not NAG:RetTwistIsSoCActive())
    and (not NAG:RetTwistShouldPreferSoBForSwing(0.4, 3, 0.05, 0.2, 0.3))
    and (
        (NAG:RetTwistShouldSetupSoCInCurrentPreDiv(0.4) and (not NAG:RetTwistShouldBlockSoCSetupForCS(0.4, "current_pre_div")))
        or ((not NAG:RetTwistShouldSetupSoCInCurrentPreDiv(0.4)) and (not NAG:RetTwistShouldBlockSoCSetupForCS(0.4, "next_swing_pre_div")))
    )
    and NAG:Cast(NAG:RetTwistGetSoCSealId())
)
or (NAG:InCombat() and not(NAG:IsAttacking()) and NAG:RetTwistIsSoCActive() and NAG:RetTwistNowWithOverlay("Startattack\nmacro"))

-- 1) CS OVERRIDE (WA "CS delay analyzer"): If holding/twisting would delay CS beyond the configured max, force CS as the main recommendation.
or (
    NAG:RetTwistShouldForceCrusaderStrike(1.9, 0.1, 0.4)
    and NAG:Cast(35395, 4)
    and (NAG:RetTwistDebugBranchWinner("cs_fallback", "cs_override") or true)
)
-- If both twist seals are missing and we are at/after div boundary (<= 1.9s to swing),
-- restore SoB/SoM immediately so we do not drift into an unsealed swing.
or (
    NAG:InCombat()
    and (not NAG:RetTwistIsSoBActive())
    and (not NAG:RetTwistIsSoCActive())
    and ((NAG:AutoTimeToNextAfterGCD() or 999) <= 1.8)
    and NAG:Cast(NAG:RetTwistGetTwistSealId())
)
-- If both twist seals are missing and we are before div boundary,
-- restore SoC immediately and prepare for a twist
or (
    NAG:InCombat()
    and (not NAG:RetTwistIsSoBActive())
    and (not NAG:RetTwistIsSoCActive())
    and ((NAG:AutoTimeToNextAfterGCD() or 999) > 1.8)
    and NAG:Cast(NAG:RetTwistGetSoCSealId())
)
-- 2) TWIST NOW (in-window): SoC active -> recommend SoB/SoM with overlay "NOW"
or NAG:CanTwist(0.4, 0.1) and NAG:RetTwistIsSoCActive() and(NAG:AuraNumStacks(20055) >= 3 and (NAG:RemainingTime() >= 15 or (NAG:InEncounter() and NAG:RemainingTime() >= 5))) and NAG:RetTwistNowBURST()
or (NAG:CanTwist(0.4, 0.1) and NAG:RetTwistIsSoCActive() and NAG:RetTwistNow())

-- 3) HOLD (div boundary): inside the sensitive region where a new GCD would push past twist window.
-- Show HOLD + show the upcoming twist seal to press.
or NAG:RetTwistIsInHoldRegion(0.4) and (NAG:AuraNumStacks(20055) >= 3 and (NAG:RemainingTime() >= 15 or (NAG:InEncounter() and NAG:RemainingTime() >= 5))) and NAG:RetTwistHoldBURST()
or (
    -- Compute hold region once to avoid 1-tick flicker from multiple AutoTimeToNextAfterGCD() calls.
    NAG:RetTwistIsInHoldRegion(0.4)
    and NAG:RetTwistHold()
)

-- Prevent CS fallbacks from stealing priority from a valid Judge+SoC HOLD plan.
or (
(not NAG:RetTwistIsSoCActive())
    and NAG:Cast(35395, NAG:GCDTimeValue() + 0.05)
)


-- FILLERS (gated): if SoC is not urgent (>= 1 GCD + 100ms budget) OR there is no active SoC path,
-- evaluate fillers before showing SoC alternatives.
or (
    (
        (NAG:TimeUntilSoC(0.4) == -1)
        or NAG:RetTwistCanCheckFillersBeforeSoC(0.4)
    )
    and (not NAG:RetTwistShouldBlockFillersInSoBPreDiv(0.4, 1.5))
    and (NAG:AutoSwingTime() > (1.75 * (NAG:GCDTimeValue() or 1.5)))
    and (NAG:NumberTargets(5, false) >= 2)
    and NAG:TargetInMeleeRange(5)
    and ((not (NAG:TargetMobType(NAG.Types.MobType.Undead) or NAG:TargetMobType(NAG.Types.MobType.Demon))) or not(NAG:SpellIsReady(879)))
    and (NAG:CurrentManaPercent() >= 0.3)
    and (NAG:RemainingTime() >= 5)
    and NAG:SpellCanCast(26573)
    and NAG:RetTwistCanCastFillerBeforeTwist(26573, 0.4, 0.1)
    and NAG:RetTwistCanCastFillerBeforeCS(26573, 35395, 0.1)
    and NAG:CastPlaceHolderWithArrow(26573, NAG:RetTwistGetFillerSourcePosition(), NAG:RetTwistGetFillerArrowOrientation(), 1.5)
)
or (
    (not NAG:RetTwistShouldBlockFillersInSoBPreDiv(0.4, 1.5))
    and (NAG:AutoSwingTime() > (1.75 * (NAG:GCDTimeValue() or 1.5)))
    and (NAG:TargetMobType(NAG.Types.MobType.Undead) or NAG:TargetMobType(NAG.Types.MobType.Demon))
    and NAG:SpellCanCast(879)
    and NAG:RetTwistCanCastFillerBeforeTwist(879, 0.4, 0.1)
    and NAG:RetTwistCanCastFillerBeforeCS(879, 35395, 0.1)
    and NAG:CastPlaceHolderWithArrow(879, NAG:RetTwistGetFillerSourcePosition(), NAG:RetTwistGetFillerArrowOrientation(), 1.5)
)
or (
     NAG:TargetInMeleeRange(5)
    and (not NAG:RetTwistShouldBlockFillersInSoBPreDiv(0.4, 1.5))
    and (NAG:AutoSwingTime() > (1.75 * (NAG:GCDTimeValue() or 1.5)))
    and ((not (NAG:TargetMobType(NAG.Types.MobType.Undead) or NAG:TargetMobType(NAG.Types.MobType.Demon))) or not(NAG:SpellIsReady(879)))
    and (NAG:CurrentManaPercent() >= 0.3)
    and (NAG:RemainingTime() >= 5)
    and NAG:SpellCanCast(26573)
    and NAG:RetTwistCanCastFillerBeforeTwist(26573, 0.4, 0.1)
    and NAG:RetTwistCanCastFillerBeforeCS(26573, 35395, 0.1)
    and NAG:CastPlaceHolderWithArrow(26573, NAG:RetTwistGetFillerSourcePosition(), NAG:RetTwistGetFillerArrowOrientation(), 1.5)
)

-- Planned Judge -> SoC setup path.
or ((not NAG:RetTwistIsSoCActive()) and NAG:RetTwistIsSoBActive() and NAG:RetTwistJudgeSetupCanDisplay(3, 0.4, 0.05, 0.2, 0.3)
    and (not NAG:RetTwistShouldDeferJudgeSetupToFillers(0.4, 3, 0.05, 0.2, 0.3))
    and (
        (NAG:RetTwistShouldSetupSoCInCurrentPreDiv(0.4) and (not NAG:RetTwistShouldBlockSoCSetupForCS(0.4, "current_pre_div")))
        or (
            ((not NAG:RetTwistShouldSetupSoCInCurrentPreDiv(0.4)) or NAG:RetTwistShouldBlockSoCSetupForCS(0.4, "current_pre_div"))
            and (not NAG:RetTwistShouldBlockSoCSetupForCS(0.4, "next_swing_pre_div"))
        )
    )
    and (NAG._retTwistJudgeHoldSeconds == -1)
    and (NAG:Cast(NAG:RetTwistGetSoCSealId(), nil, NAG.SPELL_POSITIONS.AOE) or true)
    and NAG:CastPlaceHolder(20271, nil, nil, nil, "Judge\n+\nSoC")
    and (NAG:RetTwistDebugBranchWinner("judge_hold", "judge_soc_immediate") or true)
)
or (
    (not NAG:RetTwistIsSoCActive())
    and NAG:RetTwistIsSoBActive()
    and NAG:RetTwistJudgeSetupCanDisplay(3, 0.4, 0.05, 0.2, 0.3)
    and (not NAG:RetTwistShouldDeferJudgeSetupToFillers(0.4, 3, 0.05, 0.2, 0.3))
    and (NAG._retTwistJudgeHoldSeconds and NAG._retTwistJudgeHoldSeconds > 0)
    and (
        (NAG:RetTwistShouldSetupSoCInCurrentPreDiv(0.4) and (not NAG:RetTwistShouldBlockSoCSetupForCS(0.4, "current_pre_div")))
        or (
            ((not NAG:RetTwistShouldSetupSoCInCurrentPreDiv(0.4)) or NAG:RetTwistShouldBlockSoCSetupForCS(0.4, "current_pre_div"))
            and (not NAG:RetTwistShouldBlockSoCSetupForCS(0.4, "next_swing_pre_div"))
        )
    )
    and (NAG:Cast(NAG:RetTwistGetSoCSealId(), nil, NAG.SPELL_POSITIONS.AOE) or true)
    and NAG:RetTwistJudgeHold(NAG._retTwistJudgeHoldSeconds)
    and (NAG:RetTwistDebugBranchWinner("judge_hold", "judge_soc_hold") or true)
)
or (
    (not NAG:RetTwistIsSoCActive())
    and NAG:RetTwistIsSoBActive()
    and (not NAG:RetTwistShouldDeferJudgeSetupToFillers(0.4, 3, 0.05, 0.2, 0.3))
    and (not (
        NAG:RetTwistIsSoBActive()
        and (
            NAG:RetTwistJudgeSetupIsPlanned(3, 0.4, 0.05, 0.2)
            or NAG:RetTwistJudgeSetupRecentlyDisplayable(0.15)
        )
    ))
    and NAG:SpellIsReady(20271)
    and (not NAG:RetTwistShouldBlockSoCSetupForCS(0.4, "current_pre_div"))
    and (NAG:Cast(NAG:RetTwistGetSoCSealId(), nil, NAG.SPELL_POSITIONS.AOE) or true)
    and NAG:CastPlaceHolder(20271, nil, nil, nil, "Judge\n+\nSoC")
)
or (
    (not NAG:RetTwistIsSoCActive())
    and (not NAG:RetTwistShouldPreferSoBForSwing(0.4, 3, 0.05, 0.2, 0.3))
    and (not (
        NAG:RetTwistIsSoBActive()
        and (
            NAG:RetTwistJudgeSetupIsPlanned(3, 0.4, 0.05, 0.2)
            or NAG:RetTwistJudgeSetupRecentlyDisplayable(0.15)
        )
    ))
    and (not NAG:SpellIsReady(20271))
    and (
        (NAG:RetTwistShouldSetupSoCInCurrentPreDiv(0.4) and (not NAG:RetTwistShouldBlockSoCSetupForCS(0.4, "current_pre_div")) and (NAG:RetTwistClearSoCHoldVisuals() or true) and NAG:Cast(NAG:RetTwistGetSoCSealId()) and (NAG:RetTwistDebugBranchWinner("soc_hold", "soc_setup_now_prediv") or true))
        or (
            ((not NAG:RetTwistShouldSetupSoCInCurrentPreDiv(0.4)) or NAG:RetTwistShouldBlockSoCSetupForCS(0.4, "current_pre_div"))
            and (not NAG:RetTwistShouldBlockSoCSetupForCS(0.4, "next_swing_pre_div"))
            and NAG:RetTwistSoCSetupHold(0.4)
            and (NAG:RetTwistDebugBranchWinner("soc_hold", "soc_setup_hold") or true)
        )
    )
)
or (NAG:RetTwistDebugSoCPrimaryGate(0.4, 3, 0.05, 0.2, 0.3))

-- Otherwise, if we're before div and none of the above will happen in time, start HOLD early for twist (uses the existing HOLD swipe UX on the twist seal). AND 31884 is known
or NAG:RetTwistIsSoCActive() and NAG:SpellIsKnown(31884) and (NAG:AuraNumStacks(20055) >= 3 and (NAG:RemainingTime() >= 15 or (NAG:InEncounter() and NAG:RemainingTime() >= 5))) and NAG:RetTwistHoldBURST()
or (
    NAG:RetTwistIsSoCActive()
    and NAG:RetTwistHold()
)

or (
    (not NAG:RetTwistIsSoCActive())
    and NAG:RetTwistIsSoBActive()
    and NAG:SpellIsReady(20271)
    and NAG:RetTwistShouldSetupSoCInCurrentPreDiv(0.4)
    and (not NAG:RetTwistShouldBlockSoCSetupForCS(0.4, "current_pre_div"))
    and (NAG:Cast(NAG:RetTwistGetSoCSealId(), nil, NAG.SPELL_POSITIONS.AOE) or true)
    and NAG:Cast(20271)
)
or (
    (not NAG:RetTwistIsSoCActive())
    and NAG:RetTwistIsSoBActive()
    and NAG:SpellIsReady(20271)
    and (not NAG:RetTwistShouldSetupSoCInCurrentPreDiv(0.4))
    and (not NAG:RetTwistShouldBlockSoCSetupForCS(0.4, "next_swing_pre_div"))
    and (NAG:Cast(NAG:RetTwistGetSoCSealId(), nil, NAG.SPELL_POSITIONS.AOE) or true)
    and NAG:RetTwistJudgeHold(NAG:RetTwistBackupJudgeHoldSeconds(0.4))
    and (NAG:RetTwistDebugBranchWinner("judge_hold", "backup_judge_hold") or true)
)
or (
    -- Flexible backup: if Judge+SoC is not viable here, allow plain SoC.
    (not NAG:RetTwistIsSoCActive())
    and (not (
        NAG:RetTwistIsSoBActive()
        and (
            NAG:RetTwistJudgeSetupIsPlanned(3, 0.4, 0.05, 0.2)
            or NAG:RetTwistJudgeSetupRecentlyDisplayable(0.15)
        )
    ))
    and (
        (not NAG:RetTwistIsSoBActive())
        or (not NAG:SpellIsReady(20271))
        or (not NAG:SpellCanCast(20271))
    )
    and (not NAG:RetTwistShouldPreferSoBForSwing(0.4, 3, 0.05, 0.2, 0.3))
    and (
        (NAG:RetTwistShouldSetupSoCInCurrentPreDiv(0.4) and (not NAG:RetTwistShouldBlockSoCSetupForCS(0.4, "current_pre_div")) and (NAG:RetTwistClearSoCHoldVisuals() or true) and NAG:Cast(NAG:RetTwistGetSoCSealId()) and (NAG:RetTwistDebugBranchWinner("soc_hold", "soc_fallback_now_prediv") or true))
        or (
            ((not NAG:RetTwistShouldSetupSoCInCurrentPreDiv(0.4)) or NAG:RetTwistShouldBlockSoCSetupForCS(0.4, "current_pre_div"))
            and (not NAG:RetTwistShouldBlockSoCSetupForCS(0.4, "next_swing_pre_div"))
            and NAG:RetTwistSoCSetupHold(0.4)
            and (NAG:RetTwistDebugBranchWinner("soc_hold", "soc_fallback_hold") or true)
        )
    )
)
-- If mana is below 20%, show Seal of Wisdom on PRIMARY and Snowball item icon on AOE.
-- Use AddSecondarySpell with itemId hint so DisplayManager resolves this ID as ITEM (not spell).
or (NAG:CurrentManaPercent("player") <= 0.1) and (NAG:AddSecondarySpell(17202, NAG.SPELL_POSITIONS.AOE, 17202) or true) and NAG:CastPlaceHolder(20166, nil, nil, nil, "MANA")
--fallback to cast CS
or NAG:Cast(35395, 6)
]],
}

--- @class Paladin : ClassBase
local Paladin = NAG:CreateClassModule("PALADIN", defaults)
if not Paladin then return end

function Paladin:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 0, genericRotation)  -- Generic (no talents)
    ns.AddRotationToDefaults(self.defaults, 1, holyRotation)  -- Holy
    ns.AddRotationToDefaults(self.defaults, 2, protectionRotation)  -- Protection
    ns.AddRotationToDefaults(self.defaults, 2, protectionRotationSealTwisting)  -- Protection
    ns.AddRotationToDefaults(self.defaults, 3, retributionRotation)  -- Retribution
end

local BaseGetOptions = Paladin.GetOptions
function Paladin:GetOptions()
    local options = BaseGetOptions(self)
    options.args = options.args or {}
    options.args.settings = options.args.settings or { type = "group", args = {} }
    options.args.settings.args = options.args.settings.args or {}
    options.args.settings.args.selfHeal = {
        type = "group",
        name = "Self-heal when low",
        order = 20,
        inline = true,
        args = {
            selfHealDesc = {
                type = "description",
                name = "The threshold is only used when the active rotation includes the self-heal suggestion (e.g. Generic rotation). Other rotations ignore these settings.",
                order = 0,
                fontSize = "medium",
            },
            recommendSelfHeal = {
                type = "toggle",
                name = "Recommend self-heal when low health",
                desc = "When the rotation includes self-heal (e.g. Generic), suggest a heal when your health is below the threshold.",
                order = 1,
                get = function() return self:GetSetting("class", "recommendSelfHeal", true) end,
                set = function(_, val) self:SetSetting("class", "recommendSelfHeal", val) end,
                width = "full",
            },
            selfHealThreshold = {
                type = "range",
                name = "Self-heal threshold (health %)",
                desc = "When the rotation includes self-heal, suggest it when health is below this percentage (10-60%).",
                order = 2,
                min = 0.1,
                max = 0.6,
                step = 0.05,
                get = function() return self:GetSetting("class", "selfHealThreshold", 0.35) end,
                set = function(_, val) self:SetSetting("class", "selfHealThreshold", val) end,
                width = "full",
            },
        }
    }
    return options
end

NAG.Class = Paladin

