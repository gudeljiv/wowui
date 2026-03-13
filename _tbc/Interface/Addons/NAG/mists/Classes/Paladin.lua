local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
--- @type SpellTrackingManager|AceModule|CoreModule

local defaults = ns.InitializeClassDefaults()

-- MoP Paladin spec spell locations
defaults.class.specSpellLocations = {
    [1] = { -- Holy
        -- ABOVE spells
        -- (empty)

        -- BELOW spells
        -- (empty)

        -- RIGHT spells
        -- (empty)

        -- LEFT spells
        -- (empty)

        -- AOE spells
        -- (empty)
    },
    [2] = { -- Protection
        -- ABOVE spells
        [20925] = NAG.SPELL_POSITIONS.ABOVE,   -- Sacred Shield
        [25780] = NAG.SPELL_POSITIONS.ABOVE,   -- Righteous Fury

        -- RIGHT spells
        [114158] = NAG.SPELL_POSITIONS.RIGHT,   -- Light's Hammer
        [114916] = NAG.SPELL_POSITIONS.RIGHT,   -- (unknown spell)

        -- LEFT spells
        [498] = NAG.SPELL_POSITIONS.LEFT,   -- Divine Protection
        [633] = NAG.SPELL_POSITIONS.LEFT,   -- Lay on Hands
        [642] = NAG.SPELL_POSITIONS.LEFT,   -- (unknown spell)
        [853] = NAG.SPELL_POSITIONS.LEFT,   -- (unknown spell)
        [1022] = NAG.SPELL_POSITIONS.LEFT,   -- (unknown spell)
        [1038] = NAG.SPELL_POSITIONS.LEFT,   -- (unknown spell)
        [1044] = NAG.SPELL_POSITIONS.LEFT,   -- (unknown spell)
        [6940] = NAG.SPELL_POSITIONS.LEFT,   -- (unknown spell)
        [20154] = NAG.SPELL_POSITIONS.LEFT,   -- Seal of Righteousness
        [28730] = NAG.SPELL_POSITIONS.LEFT,   -- Arcane Torrent
        [31801] = NAG.SPELL_POSITIONS.LEFT,   -- Seal of Truth
        [31821] = NAG.SPELL_POSITIONS.LEFT,   -- Devotion Aura
        [31842] = NAG.SPELL_POSITIONS.LEFT,   -- (unknown spell)
        [31850] = NAG.SPELL_POSITIONS.LEFT,   -- Ardent Defender
        [31884] = NAG.SPELL_POSITIONS.LEFT,   -- Avenging Wrath
        [54428] = NAG.SPELL_POSITIONS.LEFT,   -- (unknown spell)
        [82174] = NAG.SPELL_POSITIONS.LEFT,   -- (unknown spell)
        [105809] = NAG.SPELL_POSITIONS.LEFT,   -- Holy Avenger
        [126734] = NAG.SPELL_POSITIONS.LEFT,   -- (unknown spell)

    },
    [3] = { -- Retribution
        -- ABOVE spells
        -- (empty)

        -- BELOW spells
        -- (empty)

        -- RIGHT spells
        [114158] = NAG.SPELL_POSITIONS.RIGHT,   -- Light's Hammer
        [114916] = NAG.SPELL_POSITIONS.RIGHT,   -- (unknown spell)

        -- LEFT spells
        [633] = NAG.SPELL_POSITIONS.LEFT,       -- Lay on Hands
        [86698] = NAG.SPELL_POSITIONS.LEFT,     -- Guardian of Ancient Kings
        [1022] = NAG.SPELL_POSITIONS.LEFT,      -- (unknown spell)
        [853] = NAG.SPELL_POSITIONS.LEFT,       -- (unknown spell)
        [6940] = NAG.SPELL_POSITIONS.LEFT,      -- (unknown spell)
        [31884] = NAG.SPELL_POSITIONS.LEFT,     -- Avenging Wrath
        [498] = NAG.SPELL_POSITIONS.LEFT,       -- Divine Protection
        [31801] = NAG.SPELL_POSITIONS.LEFT,     -- Seal of Truth
        [31821] = NAG.SPELL_POSITIONS.LEFT,     -- Devotion Aura
        [31842] = NAG.SPELL_POSITIONS.LEFT,     -- (unknown spell)
        [1044] = NAG.SPELL_POSITIONS.LEFT,      -- (unknown spell)
        [1038] = NAG.SPELL_POSITIONS.LEFT,      -- (unknown spell)
        [31850] = NAG.SPELL_POSITIONS.LEFT,     -- Ardent Defender
        [642] = NAG.SPELL_POSITIONS.LEFT,       -- (unknown spell)
        [20154] = NAG.SPELL_POSITIONS.LEFT,     -- Seal of Righteousness
        [54428] = NAG.SPELL_POSITIONS.LEFT,     -- (unknown spell)
        [105809] = NAG.SPELL_POSITIONS.LEFT,    -- Holy Avenger
        [28730] = NAG.SPELL_POSITIONS.LEFT,     -- Arcane Torrent
        [82174] = NAG.SPELL_POSITIONS.LEFT,     -- (unknown spell)
        [126734] = NAG.SPELL_POSITIONS.LEFT,     -- (unknown spell)
        [54758] = NAG.SPELL_POSITIONS.LEFT,     -- Hyperspeed Acceleration

        -- AOE spells
        -- (empty)
    }
}

-- Self-heal when low health (generic rotation)
defaults.class.recommendSelfHeal = true
defaults.class.selfHealThreshold = 0.35

-- Class assignments for raid coordination
defaults.class.classAssignments = {
    {
        id = "devotion_aura",
        name = "Devotion Aura",
        description = "Provide armor buff aura (coordinate with other Paladins)",
        spellIds = {31821, 465}, -- Devotion Aura
        category = "buff",
    },
}

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
-- Leave below as is

if UnitClassBase('player') ~= "PALADIN" then return end

-- Generic (0 spec / no spec selected): low-level abilities before choosing a spec
local genericRotation = {
    name = "Generic",
    specIndex = 0,
    class = "PALADIN",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    rotationString = [[
    (NAG:GetClassSetting('recommendSelfHeal', true) and (NAG:CurrentHealthPercent() < (NAG:GetClassSetting('selfHealThreshold', 0.35) or 0.35)) and NAG:SpellCanCast(635)) and NAG:Cast(635)
    or (NAG:GetClassSetting('recommendSelfHeal', true) and (NAG:CurrentHealthPercent() < (NAG:GetClassSetting('selfHealThreshold', 0.35) or 0.35)) and NAG:SpellCanCast(19750)) and NAG:Cast(19750)
    or (not NAG:AuraIsActive(19740)) and NAG:SpellCanCast(19740) and NAG:Cast(19740)
    or (not NAG:AuraIsActive(20154)) and NAG:SpellCanCast(20154) and NAG:Cast(20154)
    or NAG:SpellCanCast(20271) and NAG:Cast(20271)
]],
}

-- START OF GENERATED_ROTATIONS

-- Holy Healing Rotation (spec 1)
-- Mouseover-based healing: uses NAG.state.healing from HealingStateManager (MoP)
-- devOnly: visible only when Developer Mode is enabled
-- MoP Holy Paladin key spells:
--   Holy Shock (20473), Holy Light (635), Divine Light (82326), Flash of Light (19750),
--   Holy Radiance (82327), Beacon of Light (53563), Word of Glory (85673),
--   Light of Dawn (85222), Avenging Wrath (31884), Divine Favor (31842),
--   Lay on Hands (633), Cleanse (4987)
local holyRotation = {
    name = "Holy",
    specIndex = 1,
    description = "Mouseover healing: Holy Shock, Holy Light, Divine Light, Holy Radiance.",
    class = "PALADIN",
    default = true,
    enabled = true,
    devOnly = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    lastModified = "02/08/2026",
    rotationString = [[
-- Seal of Insight upkeep (20165)
(not NAG:AuraIsActive(20165)) and NAG:Cast(20165)

-- Cleanse on mouseover with dispellable debuff
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverNeedsDispel()) and NAG:Cast(4987)

-- Beacon of Light on mouseover tank (keep up)
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverIsTank()
    and (not NAG:MouseoverHasBuff(53563))) and NAG:Cast(53563)

-- Holy Shock on mouseover (instant, builds Holy Power)
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 90
    and NAG:SpellIsReady(20473)) and NAG:Cast(20473)

-- Word of Glory at 3+ Holy Power on low mouseover
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 50
    and NAG:CurrentGenericResource() >= 3) and NAG:Cast(85673)

-- Light of Dawn at 3+ Holy Power when 3+ need healing
or (NAG:LowHealthMemberCount(85) >= 3
    and NAG:CurrentGenericResource() >= 3) and NAG:Cast(85222)

-- Holy Radiance when 3+ need healing (AoE, builds HP)
or (NAG:LowHealthMemberCount(80) >= 3) and NAG:Cast(82327)

-- Flash of Light on critical mouseover
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 35) and NAG:Cast(19750)

-- Divine Light on low mouseover
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 55) and NAG:Cast(82326)

-- Holy Light (efficient filler) on moderate mouseover
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 90) and NAG:Cast(635)

-- Judgment for mana return (Seal of Insight)
or NAG:SpellIsReady(20271) and NAG:Cast(20271)

-- Damage filler: Holy Shock (offensive) or Denounce
or NAG:Cast(2812)
    ]],

    spells = {635, 2812, 4987, 19750, 20165, 20271, 20473, 53563, 82326, 82327, 85222, 85673},
    items = {},
    auras = {},
    runes = {},
    author = "Smufrik",
}

local protectionRotation = {
    -- Core identification
    name = "Protection",
    specIndex = 2,
    class = "PALADIN",

    -- Required parameters
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { time = -1.5, action = "NAG:GetBattlePotion()" }
    },
    lastModified = "12/08/2025",
    rotationString = [[
-- OPENER SEQUENCE
NAG:AutocastOtherCooldowns()
or (NAG:UnitDistance("target") > 10 and NAG:NumberTargets() > 1 and NAG:CurrentTime() < 1 and NAG:SpellIsReady(20925) and NAG:SpellIsReady(31935) and NAG:SpellIsReady(20271)) and NAG:StrictSequence("opener", nil, 20925, 31935, 20271)
or (NAG:CurrentTime() < 1 and not NAG:AuraIsActive(25780) and NAG:SpellIsReady(25780)) and NAG:Cast(25780) -- Righteous Fury
or (NAG:CurrentTime() < 1 and not NAG:AuraIsActive(20925) and NAG:SpellIsReady(20925)) and NAG:Cast(20925) -- Sacred Shield (only if not active)
or (NAG:UnitDistance("target") > 10 and NAG:NumberTargets() == 1 and NAG:SpellIsReady(20271)) and NAG:Cast(20271) -- Judgment (range)

-- COOLDOWNS - Always check first

-- EMERGENCY DEFENSIVES (Priority 1) - High damage situations
or (NAG:CurrentHealthPercent() <= 0.2 and NAG:SpellIsReady(86698)) and NAG:Cast(86698) -- Guardian of Ancient Kings (panic button)
or ((NAG:CurrentHealthPercent() <= 0.35) and (NAG:ProtectionPaladinDamageTakenLastGlobal() >= (NAG:MaxHealth() * 0.35)) and NAG:SpellIsReady(86698)) and NAG:Cast(86698) -- GoAK on very large recent hit (controlled, not time-based)
or ((NAG:CurrentHealthPercent() <= 0.45) and (NAG:ProtectionPaladinDamageTakenLastGlobal() >= (NAG:MaxHealth() * 0.25)) and not NAG:AuraIsActive(86698) and NAG:SpellIsReady(31850)) and NAG:Cast(31850) -- Ardent Defender when heavy hit and GoAK not covering
or ((not NAG:SpellIsReady(86698)) and (NAG:CurrentHealthPercent() <= 0.4) and NAG:SpellIsReady(31850)) and NAG:Cast(31850) -- AD fallback when GoAK is on cooldown and HP is low
or (NAG:CurrentHealthPercent() <= 0.3 and NAG:ProtectionPaladinDamageTakenLastGlobal() >= (NAG:MaxHealth() * 0.25) and NAG:SpellIsReady(498) and not NAG:AuraIsActive(498)) and NAG:Cast(498) -- Divine Protection (reactive)
or (NAG:CurrentHealthPercent() <= 0.3 and NAG:ProtectionPaladinDamageTakenLastGlobal() >= (NAG:MaxHealth() * 0.25) and not NAG:AuraIsActive(132403) and NAG:SpellIsReady(33206)) and NAG:Cast(33206) -- Lay on Hands
or (NAG:CurrentHealthPercent() <= 0.3 and NAG:ProtectionPaladinDamageTakenLastGlobal() >= (NAG:MaxHealth() * 0.25) and NAG:SpellIsReady(76090)) and NAG:Cast(76090) -- Health Potion
or (NAG:CurrentHealthPercent() <= 0.3 and NAG:ProtectionPaladinDamageTakenLastGlobal() >= (NAG:MaxHealth() * 0.25) and NAG:SpellIsReady(5512)) and NAG:Cast(5512) -- Healthstone
-- Short-CD baseline: keep Divine Protection rolling when not active and some risk
or (not NAG:AuraIsActive(498) and NAG:SpellIsReady(498) and (NAG:CurrentHealthPercent() <= 0.85 or NAG:ProtectionPaladinDamageTakenLastGlobal() >= (NAG:MaxHealth() * 0.15))) and NAG:Cast(498) -- Divine Protection frequent but situational

-- SHIELD OF THE RIGHTEOUS (Priority 2) - Emergency: buff expired/expiring OR taking heavy damage OR low HP
or ((NAG:AuraRemainingTime(132403) <= 2.2) and (NAG:CurrentGenericResource() >= 3) and NAG:SpellIsReady(53600)) and NAG:Cast(53600) -- Buff about to expire
or ((not NAG:AuraIsActive(132403)) and (NAG:CurrentGenericResource() >= 3) and NAG:SpellIsReady(53600)) and NAG:Cast(53600) -- No active SotR buff
or ((NAG:CurrentHealthPercent() <= 0.4) and (NAG:CurrentGenericResource() >= 3) and NAG:SpellIsReady(53600)) and NAG:Cast(53600) -- Low HP emergency
or ((NAG:ProtectionPaladinDamageTakenLastGlobal() >= (NAG:MaxHealth() * 0.3)) and (NAG:CurrentGenericResource() >= 3) and NAG:SpellIsReady(53600)) and NAG:Cast(53600) -- Heavy damage

-- SHIELD OF THE RIGHTEOUS (Priority 3) - Pool to max HP when buff is still active, use at max HP
or ((NAG:CurrentGenericResource() >= (NAG:AuraIsKnown(115675) and 5 or 3)) and NAG:SpellIsReady(53600)) and NAG:Cast(53600) -- At max HP, always use (avoid overcap)

-- WORD OF GLORY (Priority 4) - MoP Bastion of Glory healing
or ((NAG:AuraNumStacks(114637) >= 3) and ((NAG:CurrentHealthPercent() <= 0.85) or (not NAG:AuraIsActive(132403))) and NAG:CurrentGenericResource() >= 3) and NAG:SpellIsReady(85673) and NAG:Cast(85673)

-- INQUISITION (Priority 5) - Maintain buff, but not at cost of mitigation
or (((NAG:AuraRemainingTime(114163) < 2.0)
    and (NAG:AuraNumStacks(114637) > 2)
    and (NAG:CurrentGenericResource() >= 3)
    and NAG:AuraIsActive(132403)
    and NAG:CurrentHealthPercent() > 0.5) -- do not refresh Inquisition if SotR is down or HP ≤50%
    or (NAG:AuraIsKnown(144566) and NAG:AuraIsActiveWithReactionTime(144569) and (NAG:AuraNumStacks(114637) >= 5) and NAG:AuraIsActive(132403) and NAG:CurrentHealthPercent() > 0.5)) -- talent proc path
    and NAG:SpellIsReady(114163) and NAG:Cast(114163)

-- JUDGMENT (Priority 6) - During Avenging Wrath (optimized from JSON)
or (NAG:AuraIsKnown(114232) and NAG:AuraIsActive(31884) and NAG:SpellIsReady(20271)) and NAG:Cast(20271)

-- JUDGMENT WAIT LOGIC (Priority 7) - Wait if ready within 0.5s (optimized from JSON)
or (NAG:AuraIsKnown(114232) and NAG:SpellTimeToReady(20271) > 0 and NAG:SpellTimeToReady(20271) <= 0.5) and NAG:Cast(20271, 0.5)

-- AOE ROTATION (Priority 8) - 3+ targets
or (NAG:NumberTargets() >= 3 and NAG:SpellIsReady(53595)) and NAG:Cast(53595) -- Hammer of the Righteous
or (NAG:NumberTargets() >= 3 and NAG:SpellIsReady(26573)) and NAG:Cast(26573) -- Consecration
or (NAG:NumberTargets() >= 3 and NAG:SpellIsReady(31935)) and NAG:Cast(31935) -- Avenger's Shield
or (NAG:NumberTargets() >= 3 and NAG:SpellIsReady(119072)) and NAG:Cast(119072) -- Holy Wrath

-- SINGLE TARGET ROTATION (Priority 9) - Holy Power Generators
or ((NAG:AuraRemainingTime(115798) < 4.0 or not NAG:AuraIsActive(115798)) and NAG:SpellIsReady(35395)) and NAG:Cast(35395) -- Refresh Weakened Blows via Crusader Strike
or ((NAG:AuraRemainingTime(115798) < 4.0 or not NAG:AuraIsActive(115798)) and NAG:SpellIsReady(53595)) and NAG:Cast(53595) -- Refresh Weakened Blows via Hammer of the Righteous (AoE)
or NAG:SpellIsReady(35395) and NAG:Cast(35395) -- Crusader Strike (main HP generator)
or NAG:SpellIsReady(20271) and NAG:Cast(20271) -- Judgment (HP generator)

-- AVENGER'S SHIELD (Priority 10) - Grand Crusader procs or on cooldown
or NAG:SpellIsReady(31935) and NAG:Cast(31935) -- Avenger's Shield

-- COOLDOWNS (Priority 11)
or NAG:SpellIsReady(105809) and NAG:Cast(105809) -- Holy Avenger
or (NAG:SpellIsReady(54428) and NAG:CurrentGenericResource() <= 2) and NAG:Cast(54428) -- Divine Plea for HP sustain

-- EXECUTE (Priority 12)
or (NAG:IsExecutePhase(20) and NAG:SpellIsReady(24275)) and NAG:Cast(24275) -- Hammer of Wrath

-- FILLERS (Priority 13) - Use when HP generators are on cooldown
or NAG:SpellIsReady(119072) and NAG:Cast(119072) -- Holy Wrath (filler)
or NAG:SpellIsReady(26573) and NAG:Cast(26573) -- Consecration (filler)
or NAG:SpellIsReady(114916) and NAG:Cast(114916) -- Execution Sentence (talent)
or NAG:SpellIsReady(114158) and NAG:Cast(114158) -- Light's Hammer (talent)

-- SACRED SHIELD MAINTENANCE (Priority 14) - Only refresh when NOT active or about to expire
or ((not NAG:AuraIsActive(20925)) or (NAG:AuraIsActive(20925) and NAG:AuraRemainingTime(20925) < 3.0)) and NAG:SpellIsReady(20925) and NAG:Cast(20925) -- Sacred Shield refresh

-- WAIT LOGIC (Priority 15) - Only wait if CS is coming up very soon
or (NAG:SpellTimeToReady(35395) > 0 and NAG:SpellTimeToReady(35395) <= 0.5) and NAG:Cast(35395, 0.5) -- Wait for Crusader Strike
or (NAG:SpellTimeToReady(20271) > 0 and NAG:SpellTimeToReady(20271) <= 0.5) and NAG:Cast(20271, 0.5) -- Wait for Judgment
    ]],

    -- Tracked IDs for optimization
    spells = {20271, 20925, 24275, 26573, 31850, 31884, 31935, 33206, 35395, 498, 53595, 53600, 54428, 85673, 105809, 114158, 114163, 114232, 114637, 114852, 114916, 119072, 132403, 144566, 144569, 126734, 86698},
    items = {5512, 76090},
    auras = {132403, 20925, 25780, 114637}, -- Shield of the Righteous buff, Sacred Shield, Righteous Fury, Bastion of Glory
    runes = {},

    -- Optional metadata
    guide = [[
Protection Paladin Rotation Guide (MoP)

Active Mitigation:
- Shield of the Righteous: Main mitigation. Use with 3-5 Holy Power. Priority when high damage intake or high HP.
- Word of Glory: Self-healing. Use with 3-5 Holy Power when health is low (<70%) and you have Bastion of Glory stacks.

Holy Power Generation (Priority):
1. Crusader Strike / Hammer of the Righteous (AoE): Main generator.
2. Judgment: Ranged generator.
3. Avenger's Shield: Grand Crusader procs reset cooldown. Also interrupts.
4. Hammer of Wrath: Execute phase generator (<20% HP).

Defensives:
- Guardian of Ancient Kings: Major damage reduction (50%).
- Ardent Defender: Cheat death mechanic and damage reduction (20%).
- Divine Protection: Frequent minor magical/physical reduction.
- Lay on Hands: Emergency full heal.

Maintenance:
- Sacred Shield: Keep active at all times for absorb.
- Inquisition: Maintain for threat/damage boost (optional for pure survival).
- Consecration: Threat maintenance and AoE.
]],
    glyphs = {41101, 45744, 41096, 80581},
    author = "Smufrik",
}


local retributionSurveillantRotation = {
    -- Core identification
    name = "MoP Retribution",
    specIndex = 3,
    class = "PALADIN",

    -- Required parameters
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { time = -0.1, action = "NAG:Cast(76095)" }
    },
    lastModified = "07/21/2025",
    rotationString = [[

        ((not NAG:AuraIsActive(31801)) and (NAG:NumberTargets() <= 3)) and NAG:Cast(31801)
        or ((not NAG:AuraIsActive(20154)) and (NAG:NumberTargets() >= 4)) and NAG:Cast(20154)
        or ((not NAG:AuraIsActive(20154)) and (not NAG:AuraIsActive(31801))) and NAG:Cast(31801)
        or (NAG:AuraIsActive(2825) or (NAG:RemainingTime() <= 40.0) or (NAG:AuraIsActive(86700) and NAG:AuraIsActive(31884))) and NAG:Cast(76095)
        or (((not NAG:AuraIsActive(84963)) or (NAG:AuraRemainingTime(84963) <= 2.0)) and ((NAG:CurrentGenericResource() >= 3) or (NAG:RemainingTime() < (NAG:CurrentGenericResource() * 20)))) and NAG:Cast(84963)
        or NAG:AuraIsActive(84963) and NAG:Cast(31884)
        or NAG:AuraIsActive(31884) and NAG:Cast(86698)
        or (NAG:AuraIsActive(84963) and (NAG:CurrentGenericResource() <= 2) and NAG:SpellIsKnown(105809)) and NAG:Cast(105809)
        or (NAG:AuraIsActive(84963) and ((not NAG:AuraIsActive(86700)) or (NAG:AuraNumStacks(86700) == 12))) and NAG:Cast(126734)
        or (NAG:AuraIsActive(84963) and ((not NAG:AuraIsActive(86700)) or (NAG:AuraNumStacks(86700) == 12))) and NAG:Cast(82174)
        or (NAG:AuraIsActive(84963) and ((not NAG:AuraIsActive(86700)) or (NAG:AuraNumStacks(86700) == 12))) and NAG:Cast(54758)
        or NAG:AutocastOtherCooldowns()
        or (NAG:SpellIsKnown(28730) and (NAG:CurrentManaPercent() < 0.9)) and NAG:Cast(28730)
        or (NAG:AuraIsActive(84963) and ((not NAG:AuraIsActive(86700)) or (NAG:AuraNumStacks(86700) == 12)) and NAG:SpellIsKnown(114916)) and NAG:RemainingTime() > 8 and NAG:Cast(114916)
        or (NAG:AuraIsActive(84963) and ((not NAG:AuraIsActive(86700)) or (NAG:AuraNumStacks(86700) == 12)) and NAG:SpellIsKnown(114158)) and NAG:Cast(114158)
        or (NAG:NumberTargets() >= 2) and (NAG:CurrentGenericResource() == (NAG:AuraIsKnown(115675) and 5 or 3)) and NAG:Cast(53385)
        or (NAG:CurrentGenericResource() == (NAG:AuraIsKnown(115675) and 5 or 3)) and NAG:Cast(85256)
        or (NAG:IsExecutePhase(20) or NAG:AuraIsActive(31884)) and NAG:Cast(24275, 0.2)
        or (((NAG:NumberTargets() >= 2) and ((NAG:AuraIsActive(105809) and NAG:CurrentGenericResource() >= 3) or (NAG:AuraIsActive(31884) and NAG:CurrentGenericResource() >= 3))) or (NAG:AuraIsKnown(144593) and NAG:AuraIsActive(144595) and (NAG:CurrentGenericResource() == (NAG:AuraIsKnown(115675) and 5 or 3)))) and NAG:Cast(53385)
        or ((NAG:AuraIsKnown(105809) and NAG:AuraIsActive(105809) and (NAG:CurrentGenericResource() >= 3)) or (NAG:AuraIsKnown(90174) and NAG:AuraIsActive(90174) and (NAG:AuraRemainingTime(90174) < 4.0))) and NAG:Cast(85256)
        or (NAG:AuraIsKnown(144593) and NAG:AuraIsActive(31884) and NAG:AuraIsActive(144595)) and NAG:Cast(53385)
        or NAG:AuraIsActive(31884) and NAG:Cast(85256)
        or (NAG:NumberTargets() >= 4) and NAG:Cast(53595)
        or NAG:AuraIsActive(31884) and NAG:TierSetEquipped(15, 4) and NAG:Cast(35395)
        or NAG:AuraIsActive(31884) and NAG:Cast(20271)
        or (NAG:NumberTargets() < 4) and NAG:Cast(35395, 0.2)
        or (NAG:AuraIsKnown(138159) and NAG:AuraIsKnown(122028) and (NAG:NumberTargets() >= 2) and (NAG:NumberTargets() <= 4)) and NAG:Cast(879)
        or (NAG:AuraIsActive(31801) or NAG:AuraIsActive(20154)) and NAG:Cast(20271)
        or (NAG:AuraIsKnown(144593) and NAG:AuraIsActive(144595)) and NAG:Cast(53385)
        or (NAG:AuraIsKnown(90174) and NAG:AuraIsActive(90174)) and NAG:Cast(85256)
        or NAG:Cast(879, 0.2)
        or (NAG:AuraIsKnown(138164) and NAG:AuraIsActive(138169) and (NAG:NumberTargets() >= 2)) and NAG:Cast(85256)
        or ((NAG:NumberTargets() >= 2) and (NAG:AuraRemainingTime(84963) > 4.0)) and NAG:Cast(53385)
        or (NAG:AuraRemainingTime(84963) > 4.0) and NAG:Cast(85256)
        or NAG:SpellIsKnown(114852) and NAG:Cast(114852)
        or ((NAG:SpellTimeToReady(24275) < NAG:SpellTimeToReady(35395) and NAG:SpellTimeToReady(20271)) and NAG:CurrentGenericResource() < (NAG:AuraIsKnown(115675) and 5 or 3)) and NAG:Cast(24275, 6)
        or (((NAG:NumberTargets() >= 4) and (NAG:SpellTimeToReady(53595) <= NAG:SpellTimeToReady(20271) and NAG:SpellTimeToReady(879))) and NAG:CurrentGenericResource() < (NAG:AuraIsKnown(115675) and 5 or 3)) and NAG:Cast(53595, 4.5)
        or (((NAG:SpellTimeToReady(35395) <= NAG:SpellTimeToReady(20271) and NAG:SpellTimeToReady(879)) and (NAG:NumberTargets() <= 3)) and NAG:CurrentGenericResource() < (NAG:AuraIsKnown(115675) and 5 or 3)) and NAG:Cast(35395, 4.5)
        or ((NAG:SpellTimeToReady(20271) < NAG:SpellTimeToReady(35395) and NAG:SpellTimeToReady(879)) and NAG:CurrentGenericResource() < 3) and NAG:Cast(20271, 4.49)
        or ((NAG:SpellTimeToReady(879) < NAG:SpellTimeToReady(35395) and NAG:SpellTimeToReady(20271)) and NAG:CurrentGenericResource() < 3) and NAG:Cast(879, 4.5)
        or ((NAG:AuraRemainingTime(84963) <= NAG:SpellTimeToReady(35395) and NAG:SpellTimeToReady(20271)) and NAG:CurrentGenericResource() < 3) and NAG:Cast(84963, 4.5)

    ]],

    -- Tracked IDs for optimization
    spells = {879, 2825, 20271, 24275, 31884, 35395, 53385, 53595, 82174, 84963, 85256, 86698, 86700, 90174, 105809, 114158, 114852, 114916, 122028, 138159, 138164, 138169, 144593, 144595, 126734 },
    items = {76095},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {41097, 41092, 83107},
    author = "@Surveillant"
}


-- END OF GENERATED_ROTATIONS

--- @class Paladin : ClassBase
local Paladin = NAG:CreateClassModule("PALADIN", defaults)
if not Paladin then return end

function Paladin:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 0, genericRotation)  -- Generic (no spec)
    --ns.AddRotationToDefaults(self.defaults, 1, holyRotation)  -- Holy
    ns.AddRotationToDefaults(self.defaults, 2, protectionRotation)  -- Protection
    ns.AddRotationToDefaults(self.defaults, 3, retributionSurveillantRotation)  -- Retribution
end


function Paladin:RegisterSpellTracking()
    local SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
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
