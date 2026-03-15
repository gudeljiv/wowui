local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
local UnitGUID = _G.UnitGUID
local GetTime = _G.GetTime
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version

local defaults = ns.InitializeClassDefaults()
local CURSE_OF_DOOM_BASE_SPELL_ID = 603
local CURSE_OF_DOOM_DURATION_SECONDS = 60

-- Soulshatter threat baseline (raw threat amount)
-- TODO: Set a real baseline after testing (e.g., via /dump NAG:UnitThreatValue()).
local SOULSHATTER_THREAT_VALUE_BASELINE = nil

-- TBC Warlock spec spell locations
defaults.class.specSpellLocations = {
    [1] = { -- Affliction
        -- ABOVE spells (Buffs, maintenance)
        [28176] = NAG.SPELL_POSITIONS.ABOVE,   -- Fel Armor
        [688] = NAG.SPELL_POSITIONS.ABOVE,     -- Summon Imp (pet)


        -- LEFT spells (Cooldowns, curses, racials)
        [18288] = NAG.SPELL_POSITIONS.LEFT,    -- Amplify Curse
        [980] = NAG.SPELL_POSITIONS.LEFT,      -- Curse of Agony
        [1490] = NAG.SPELL_POSITIONS.LEFT,     -- Curse of the Elements
        [704] = NAG.SPELL_POSITIONS.LEFT,      -- Curse of Recklessness
        [29858] = NAG.SPELL_POSITIONS.LEFT,    -- Soulshatter
        [20572] = NAG.SPELL_POSITIONS.LEFT,    -- Blood Fury (Orc Racial)
        [26297] = NAG.SPELL_POSITIONS.LEFT,    -- Berserking (Troll Racial)
        [28734] = NAG.SPELL_POSITIONS.LEFT,    -- Mana Tap (BE Racial)
        [25046] = NAG.SPELL_POSITIONS.LEFT,    -- Arcane Torrent (BE Racial)

        -- AOE spells
        [27243] = NAG.SPELL_POSITIONS.RIGHT,     -- Seed of Corruption

    },
    [2] = { -- Demonology
        -- ABOVE spells (Buffs, maintenance)
        [28176] = NAG.SPELL_POSITIONS.ABOVE,   -- Fel Armor
        -- BELOW spells (Pets)
        [712] = NAG.SPELL_POSITIONS.BELOW,     -- Summon Succubus (pet)
        [30146] = NAG.SPELL_POSITIONS.BELOW,   -- Summon Felguard (pet)


        -- LEFT spells (Cooldowns, curses, racials)
        [18288] = NAG.SPELL_POSITIONS.LEFT,    -- Amplify Curse
        [980] = NAG.SPELL_POSITIONS.LEFT,      -- Curse of Agony
        [1490] = NAG.SPELL_POSITIONS.LEFT,     -- Curse of the Elements
        [704] = NAG.SPELL_POSITIONS.LEFT,      -- Curse of Recklessness
        [29858] = NAG.SPELL_POSITIONS.LEFT,    -- Soulshatter
        [20572] = NAG.SPELL_POSITIONS.LEFT,    -- Blood Fury (Orc Racial)
        [26297] = NAG.SPELL_POSITIONS.LEFT,    -- Berserking (Troll Racial)
        [28734] = NAG.SPELL_POSITIONS.LEFT,    -- Mana Tap (BE Racial)
        [25046] = NAG.SPELL_POSITIONS.LEFT,    -- Arcane Torrent (BE Racial)

        -- AOE spells
        [27243] = NAG.SPELL_POSITIONS.RIGHT,     -- Seed of Corruption

    },
    [3] = { -- Destruction
        -- ABOVE spells (Buffs, maintenance)
        [28176] = NAG.SPELL_POSITIONS.ABOVE,   -- Fel Armor
        [18788] = NAG.SPELL_POSITIONS.ABOVE,   -- Demonic Sacrifice
        [712] = NAG.SPELL_POSITIONS.ABOVE,     -- Summon Succubus (pet)
        [688] = NAG.SPELL_POSITIONS.ABOVE,     -- Summon Imp (for Imp sacrifice - Burning Wish buff)

        -- LEFT spells (Cooldowns, curses, racials)
        [18288] = NAG.SPELL_POSITIONS.LEFT,    -- Amplify Curse
        [980] = NAG.SPELL_POSITIONS.LEFT,      -- Curse of Agony
        [1490] = NAG.SPELL_POSITIONS.LEFT,     -- Curse of the Elements
        [704] = NAG.SPELL_POSITIONS.LEFT,      -- Curse of Recklessness
        [29858] = NAG.SPELL_POSITIONS.LEFT,    -- Soulshatter
        [20572] = NAG.SPELL_POSITIONS.LEFT,    -- Blood Fury (Orc Racial)
        [26297] = NAG.SPELL_POSITIONS.LEFT,    -- Berserking (Troll Racial)
        [28734] = NAG.SPELL_POSITIONS.LEFT,    -- Mana Tap (BE Racial)
        [25046] = NAG.SPELL_POSITIONS.LEFT,    -- Arcane Torrent (BE Racial)

        -- AOE spells
        [27243] = NAG.SPELL_POSITIONS.RIGHT,     -- Seed of Corruption

    },
}

-- Class assignments for raid coordination (disabled by default)
defaults.class.classAssignments = {
    {
        id = "curse_of_recklessness",
        name = "Curse of Recklessness",
        description = "Reduce target armor and remove fear effects (coordinate with other Warlocks - only one curse per target)",
        spellIds = {704, 7658, 7659, 11717, 27226}, -- All ranks
        category = "debuff",
    },
    {
        id = "curse_of_elements",
        name = "Curse of the Elements",
        description = "Apply magic vulnerability debuff (coordinate with other Warlocks - only one curse per target)",
        spellIds = {1490, 11721, 11722, 27228}, -- All ranks
        category = "debuff",
    },
    {
        id = "curse_of_weakness",
        name = "Curse of Weakness",
        description = "Reduce target's physical damage output (coordinate with other Warlocks - only one curse per target)",
        spellIds = {702, 1108, 6205, 7646, 11707, 11708, 27224, 30909}, -- All ranks
        category = "debuff",
    },
    {
        id = "curse_of_tongues",
        name = "Curse of Tongues",
        description = "Increase enemy casting time (coordinate with other Warlocks - only one curse per target)",
        spellIds = {1714, 11719}, -- All ranks
        category = "debuff",
    },
}

defaults.char.assignmentToggles = defaults.char.assignmentToggles or {}
if defaults.char.assignmentToggles.curse_of_recklessness == nil then
    defaults.char.assignmentToggles.curse_of_recklessness = false
end
if defaults.char.assignmentToggles.curse_of_elements == nil then
    defaults.char.assignmentToggles.curse_of_elements = false
end
if defaults.char.assignmentToggles.curse_of_weakness == nil then
    defaults.char.assignmentToggles.curse_of_weakness = false
end
if defaults.char.assignmentToggles.curse_of_tongues == nil then
    defaults.char.assignmentToggles.curse_of_tongues = false
end

if UnitClassBase('player') ~= "WARLOCK" then return end

-- Generic (0 talent points): low-level abilities before choosing a spec
local genericRotation = {
    name = "Generic",
    specIndex = 0,
    class = "WARLOCK",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    rotationString = [[
    (not NAG:AuraIsActive(706) and not NAG:AuraIsActive(687) and not NAG:AuraIsActive(28176)) and NAG:SpellCanCast(706) and NAG:Cast(706)
    or (not NAG:AuraIsActive(687) and not NAG:AuraIsActive(706) and not NAG:AuraIsActive(28176)) and NAG:SpellCanCast(687) and NAG:Cast(687)
    or (not NAG:AuraIsActive(28176) and not NAG:AuraIsActive(706) and not NAG:AuraIsActive(687)) and NAG:SpellCanCast(28176) and NAG:Cast(28176)
    or (NAG:SpellCanCast(348) and (not NAG:DotIsActive(348, "target"))) and NAG:Cast(348)
    or (NAG:SpellCanCast(686)) and NAG:Cast(686)
]],
}

-- Affliction Rotation
local afflictionRotation = {
    -- Core identification
    name = "Affliction",
    specIndex = 1,
    class = "WARLOCK",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    lastModified = "12/30/2025",
    rotationString = [[
    -- NOTE: Use LOWEST-RANK IDs with ResolveEffectiveSpellId/*Resolved helpers.
    NAG:EnableAssignmentsGate()
    or

    -- Maintain Fel Armor
    (NAG:SpellCanCast(28176) and (not NAG:AuraIsActive(28176)))
        and NAG:Cast(28176)
    -- Maintain Summon Succubus
    or ((not NAG:PetIsActive()) and NAG:SpellCanCast(712))
        and NAG:Cast(712)
    -- Fall back to Imp in case no shards
    or ((not NAG:PetIsActive()) and NAG:SpellCanCast(688) and (not NAG:SpellCanCast(712)))
        and NAG:Cast(688)


        -- Execute: Shadowburn (shard spender)
        -- Only if a Shadow Bolt won't land in time
        or ((NAG:CurrentSoulShards() >= 1)
            and (NAG:RemainingTime() < (NAG:SpellCastTime(686) + NAG:SpellTravelTime(686))))
            and NAG:Cast(17877)

        -- Conflagrate: finisher (target about to die + Immolate active) or movement (instant cast)
        -- Consumes Immolate; only use when DoT would be wasted or when moving
        or ( (NAG:RemainingTime() < (0.5 + NAG:SpellCastTime(686) + NAG:SpellTravelTime(686))) or (NAG:UnitIsMoving() and NAG:DotRemainingTimeNow(348) <= 10))
        and NAG:DotIsActive(348, "target") and NAG:AuraIsActive(18789) and NAG:Cast(17962)


    -- Soulshatter when threat is high (group only, shards required)
    or (NAG:InCombat() and (NAG:GetNumGroupMembers() > 0) and (NAG:CurrentSoulShards() >= 1)
        and SOULSHATTER_THREAT_VALUE_BASELINE and (NAG:UnitThreatValue() >= SOULSHATTER_THREAT_VALUE_BASELINE)
        and (NAG:UnitThreatPercent() >= 90) and NAG:SpellCanCast(29858))
        and NAG:CastWithOverlay(29858, "SHATTER", NAG.SPELL_POSITIONS.LEFT)

    -- Movement: Death Coil (only when moving and in combat; otherwise filler is preferred)
    or (NAG:InCombat() and NAG:UnitIsMoving() and NAG:SpellCanCast(6789))
        and NAG:Cast(6789,  nil, NAG.SPELL_POSITIONS.AOE)

    -- Movement: Siphon Life (instant; only when moving, not a priority - SL/DL no longer snapshot debuffs)
    or NAG:UnitIsMoving()
        and ((not NAG:DotIsActive(18265)) or (NAG:DotRemainingTimeNow(18265) <= NAG:GCDTimeToReady()))
        and (NAG:RemainingTime() > 12)
        and NAG:Cast(18265)

    -- Mana: Life Tap when needed (health-safe, ideally while moving)
    or ((NAG:UnitIsMoving() or NAG:CurrentManaPercent() < 0.20)
        and (NAG:CurrentManaPercent() < 0.70)
        and (NAG:CurrentHealthPercent() >= 0.50)
        and NAG:SpellCanCast(1454))
        and NAG:Cast(1454, nil, NAG.SPELL_POSITIONS.RIGHT)

    -- Backlash proc: Incinerate if Immolate on target, else Shadow Bolt (highest known rank via Cast)
    or (NAG:AuraIsActive(34936, "player") and NAG:DotIsActive(348, "target") and NAG:SpellCanCast(32231))
        and NAG:Cast(32231)
    or (NAG:AuraIsActive(34936, "player") and (not NAG:DotIsActive(348, "target")) and NAG:SpellCanCast(686))
        and NAG:Cast(686)

    -- Out of combat: suggest pre-pull Curse of Doom with a right arrow (target level > player or boss/unknown level)
    or ((not NAG:InCombat()) and NAG:UnitExists("target") and NAG:SpellCanCast(603)
        and ((UnitLevel("target") or 0) > (UnitLevel("player") or 0) or (UnitLevel("target") or 0) < 0))
        and NAG:CastPlaceHolderWithArrow(603, "left1", "RIGHT", 1.5)

    -- AoE: Seed of Corruption on targets without it (TTD-gated)
    -- AoE: Seed of Corruption on targets without it (TTD-gated)
    or ((NAG:NumberTargetsWithTTD(9, 30) >= 2) and (not NAG:DotIsActive(27243)) and NAG:SpellCanCast(27243))
        and NAG:Cast(27243,  nil, NAG.SPELL_POSITIONS.PRIMARY)
    -- Utility curses (assignment opt-in only; priority Reck -> Elements -> Weak -> Tongues)
    or (NAG:IsAssignmentEnabled("curse_of_recklessness")
        and NAG:ShouldUseCurseOfRecklessness()
        and (not NAG:IsSpellBlacklisted(704)) and (not NAG:DotIsActiveGlobal(704))
        and NAG:SpellCanCast(704))
        and NAG:Cast(704)
    or ((not NAG:IsAssignmentEnabled("curse_of_recklessness"))
        and NAG:IsAssignmentEnabled("curse_of_elements")
        and (not NAG:IsSpellBlacklisted(1490)) and (not NAG:DotIsActiveGlobal(1490))
        and NAG:SpellCanCast(1490))
        and NAG:Cast(1490)
    or ((not NAG:IsAssignmentEnabled("curse_of_recklessness"))
        and (not NAG:IsAssignmentEnabled("curse_of_elements"))
        and NAG:IsAssignmentEnabled("curse_of_weakness")
        and (not NAG:IsSpellBlacklisted(702)) and (not NAG:DotIsActiveGlobal(702))
        and NAG:SpellCanCast(702))
        and NAG:Cast(702)
    or ((not NAG:IsAssignmentEnabled("curse_of_recklessness"))
        and (not NAG:IsAssignmentEnabled("curse_of_elements"))
        and (not NAG:IsAssignmentEnabled("curse_of_weakness"))
        and NAG:IsAssignmentEnabled("curse_of_tongues")
        and (not NAG:IsSpellBlacklisted(1714)) and (not NAG:DotIsActiveGlobal(1714))
        and NAG:SpellCanCast(1714))
        and NAG:Cast(1714)

    -- Curse of Agony (22-70s) - only if no utility assignment is enabled
    or ((not NAG:IsAssignmentEnabled("curse_of_recklessness"))
        and (not NAG:IsAssignmentEnabled("curse_of_elements"))
        and (not NAG:IsAssignmentEnabled("curse_of_weakness"))
        and (not NAG:IsAssignmentEnabled("curse_of_tongues"))
        and (NAG:RemainingTime() >= 22) and (NAG:RemainingTime() <= 70)
        and (NAG:RemainingTime() >= 7777 or NAG:RemainingTime() > 10)
        and (not (NAG:DotIsActive(603) or NAG:DotIsActive(980) or NAG:DotIsActive(1490) or NAG:DotIsActive(704) or NAG:DotIsActive(17862) or NAG:DotIsActive(702) or NAG:DotIsActive(1714)))
        and (not NAG:DotIsActiveGlobal(980))
        and ((not NAG:DotIsActive(980)) or (NAG:DotRemainingTime(980) <= (NAG:GCDTimeValue() + 0.10)))
        and NAG:SpellCanCast(980))
        and NAG:Cast(980)

    -- Curse of Doom with Amplify Curse (60-600s) - only if no utility assignment is enabled
    or ((not NAG:IsAssignmentEnabled("curse_of_recklessness"))
        and (not NAG:IsAssignmentEnabled("curse_of_elements"))
        and (not NAG:IsAssignmentEnabled("curse_of_weakness"))
        and (not NAG:IsAssignmentEnabled("curse_of_tongues"))
        and (NAG:RemainingTime() > 60) and (NAG:RemainingTime() < 600) and (NAG:CurrentTime() > 2)
        and (not (NAG:DotIsActive(603) or NAG:DotIsActive(980) or NAG:DotIsActive(1490) or NAG:DotIsActive(704) or NAG:DotIsActive(17862) or NAG:DotIsActive(702) or NAG:DotIsActive(1714)))
        and (not NAG:DotIsActiveGlobal(603))
        and ((not NAG:DotIsActive(603)) or (NAG:DotRemainingTime(603) <= (NAG:GCDTimeValue() + 0.10)))
        and NAG:SpellCanCast(603)
        and NAG:AuraIsActive(18288))
        and NAG:Cast(603)

    -- Amplify Curse before Curse of Doom (60-600s) - only if no utility assignment is enabled
    or ((not NAG:IsAssignmentEnabled("curse_of_recklessness"))
        and (not NAG:IsAssignmentEnabled("curse_of_elements"))
        and (not NAG:IsAssignmentEnabled("curse_of_weakness"))
        and (not NAG:IsAssignmentEnabled("curse_of_tongues"))
        and (NAG:RemainingTime() > 60) and (NAG:RemainingTime() < 600) and (NAG:CurrentTime() > 2)
        and (not (NAG:DotIsActive(603) or NAG:DotIsActive(980) or NAG:DotIsActive(1490) or NAG:DotIsActive(704) or NAG:DotIsActive(17862) or NAG:DotIsActive(702) or NAG:DotIsActive(1714)))
        and (not NAG:DotIsActiveGlobal(603))
        and ((not NAG:DotIsActive(603)) or (NAG:DotRemainingTime(603) <= (NAG:GCDTimeValue() + 0.10)))
        and NAG:SpellCanCast(603)
        and NAG:SpellCanCast(18288)
        and (not NAG:AuraIsActive(18288)))
        and NAG:Cast(18288)

    -- Curse of Doom without Amplify Curse (60-600s) - only if no utility assignment is enabled
    or ((not NAG:IsAssignmentEnabled("curse_of_recklessness"))
        and (not NAG:IsAssignmentEnabled("curse_of_elements"))
        and (not NAG:IsAssignmentEnabled("curse_of_weakness"))
        and (not NAG:IsAssignmentEnabled("curse_of_tongues"))
        and (NAG:RemainingTime() > 60) and (NAG:RemainingTime() < 600) and (NAG:CurrentTime() > 2)
        and (not (NAG:DotIsActive(603) or NAG:DotIsActive(980) or NAG:DotIsActive(1490) or NAG:DotIsActive(704) or NAG:DotIsActive(17862) or NAG:DotIsActive(702) or NAG:DotIsActive(1714)))
        and (not NAG:DotIsActiveGlobal(603))
        and ((not NAG:DotIsActive(603)) or (NAG:DotRemainingTime(603) <= (NAG:GCDTimeValue() + 0.10)))
        and NAG:SpellCanCast(603))
        and NAG:Cast(603)

    -- Maintain Unstable Affliction (Affliction talent - 18s duration, 1.5s cast)
    or (NAG:SpellIsKnown(30405)
        and (((not NAG:DotIsActive(30405))
            or (NAG:DotRemainingTimeNow(30405) <= ((NAG:UnitCastTimeRemaining("player") > 0)
                and NAG:UnitCastTimeRemaining("player")
                or (NAG:GCDTimeToReady() + NAG:SpellCastTime(30405)))))
        and (NAG:RemainingTime() >= 7777 or NAG:RemainingTime() > 15)
        and NAG:SpellCanCast(30405)))
        and NAG:NotSpamCast(30405)

    -- Maintain Corruption
    or ((((not NAG:DotIsActive(172))
        or (NAG:DotRemainingTimeNow(172) <= ((NAG:UnitCastTimeRemaining("player") > 0)
            and NAG:UnitCastTimeRemaining("player")
            or NAG:GCDTimeToReady())))
        and (NAG:RemainingTime() >= 7777 or NAG:RemainingTime() > 7)
        and NAG:SpellCanCast(172))
        and NAG:NotSpamCast(172))

    -- Maintain Immolate
    or ((((not NAG:DotIsActive(348))
        or (NAG:DotRemainingTimeNow(348) <= ((NAG:UnitCastTimeRemaining("player") > 0)
            and NAG:UnitCastTimeRemaining("player")
            or (NAG:GCDTimeToReady() + NAG:SpellCastTime(348)))))
        and (NAG:RemainingTime() >= 7777 or NAG:RemainingTime() > 7))
        and NAG:NotSpamCast(348))

    -- Cast Shadow Bolt (main filler)
    or NAG:NotSpamCast(686)
    -- If a DoT will drop before Shadow Bolt finishes, refresh it first (only if target lives long enough)
    or (NAG:SpellIsKnown(30405) and NAG:DotIsActive(30405)
        and (NAG:RemainingTime() >= 7777 or NAG:RemainingTime() > 14)
        and (NAG:DotRemainingTimeNow(30405) <= ((NAG:UnitCastTimeRemaining("player") > 0)
            and NAG:UnitCastTimeRemaining("player")
            or (NAG:GCDTimeToReady() + NAG:SpellCastTime(30405)))))
        and NAG:Cast(30405)
    or (NAG:DotIsActive(172)
        and (NAG:RemainingTime() >= 7777 or NAG:RemainingTime() > 7)
        and (NAG:DotRemainingTimeNow(172) <= ((NAG:UnitCastTimeRemaining("player") > 0)
            and NAG:UnitCastTimeRemaining("player")
            or NAG:GCDTimeToReady())))
        and NAG:Cast(172)
    or (NAG:DotIsActive(348)
        and (NAG:RemainingTime() >= 7777 or NAG:RemainingTime() > 7)
        and (NAG:DotRemainingTimeNow(348) <= ((NAG:UnitCastTimeRemaining("player") > 0)
            and NAG:UnitCastTimeRemaining("player")
            or (NAG:GCDTimeToReady() + NAG:SpellCastTime(348)))))
        and NAG:Cast(348)
    or (NAG:DotIsActive(980)
        and (NAG:RemainingTime() >= 7777 or NAG:RemainingTime() > 10)
        and (NAG:DotRemainingTimeNow(980) <= ((NAG:UnitCastTimeRemaining("player") > 0)
            and NAG:UnitCastTimeRemaining("player")
            or NAG:GCDTimeToReady())))
        and NAG:Cast(980)
    or (NAG:DotIsActive(603)
        and (NAG:RemainingTime() > 60) and (NAG:RemainingTime() < 600)
        and (NAG:DotRemainingTimeNow(603) <= ((NAG:UnitCastTimeRemaining("player") > 0)
            and NAG:UnitCastTimeRemaining("player")
            or NAG:GCDTimeToReady())))
        and NAG:Cast(603)
    or NAG:Cast(686)
    ]],

    -- Tracked IDs for optimization
    spells = {28176, 712, 688, 603, 980, 172, 18265, 348, 686, 32231, 17877, 6789, 1454, 27243, 18288, 1490, 704, 29858, 34936, 30405},
    items = {},
    auras = {28176, 18288, 172, 18265, 348, 603, 980, 34936, 30405}, -- Fel Armor, Amplify Curse, Corruption, Siphon Life, Immolate, Curse of Doom, Curse of Agony, Backlash, Unstable Affliction

    -- Optional metadata
    guide = [[
Affliction Warlock Rotation Guide (TBC)

Core Mechanics:
- Affliction Warlocks are DoT-based DPS casters focusing on shadow damage and sustained uptime.
- Reapply DoTs only after they fall off.
- Siphon Life: movement-only filler (instant cast); not a priority - SL/DL no longer snapshot debuffs.
- Curse choice is fight-length dependent: Doom for long fights, Agony for short fights.
- Coordinate curses: only one curse can be active on a target.
- Life Tap is part of your rotation; use it when mana is low and health is safe.

Rotation Priority (Single Target):
1. If Fel Armor is missing, cast Fel Armor.
2. If pet is missing, summon Succubus (fall back to Imp if no shards).
3. If execute phase and a Shadow Bolt won't land in time, cast Shadowburn.
4. Use Soulshatter in group when threat is high (shards required).
5. If moving and you need an instant, cast Death Coil.
6. If mana is low and health is safe, cast Life Tap (ideally while moving).
7. If target will live <60s and no other curse is active, cast Curse of Agony.
8. If target will live >=60s and no other curse is active, cast Amplify Curse then Curse of Doom.
9. Maintain Unstable Affliction (reapply after it falls off; Affliction talent only).
10. Maintain Corruption (reapply after it falls off).
11. Siphon Life: use only while moving as a filler (not a priority).
12. Maintain Immolate (reapply after it falls off).
13. Cast Shadow Bolt as filler.

AoE Rotation:
- Seed of Corruption for multi-target packs (TTD-gated).

Curse Priority:
- Curse of Doom: Primary curse for long fights (60 second duration)
- Curse of Agony: Use if boss will die in <60 seconds
- Curse of the Elements: Use if assigned by raid leader (magic vulnerability debuff)
- Curse of Recklessness: Use if assigned by raid leader (armor reduction, removes fear)
- Note: Only one curse can be active per target - coordinate with other Warlocks

DoT Management:
- Reapply DoTs only after they fall off.
- Unstable Affliction: 18 second duration (Affliction talent); highest priority when talented.
- Siphon Life: movement-only filler (instant); not a priority.
- Corruption: 12 second duration
- Siphon Life: 30s duration; movement-only filler (not a priority)
- Immolate: 15 second duration

Mana Management:
- Life Tap: Converts health to mana - use when low on mana
- Ideally use Life Tap while moving to avoid DPS loss
- Fel Armor: Provides passive mana regeneration
- Summon Imp: Provides passive mana regeneration (if talented)

Movement:
- Shadowburn: Instant cast shadow damage - use while moving
- Death Coil: Instant cast fear with damage - use while moving
- Life Tap: Can be used while moving without DPS loss

Pet:
- Summon Succubus: Preferred pet for Affliction Warlocks
- Fall back to Imp if Succubus is unavailable
- Keep pet alive and on target at all times

Raid Coordination:
- Coordinate curses with other Warlocks - only one curse per target
- May be assigned Curse of the Elements or Curse of Recklessness
- Usually 1-2 Affliction Warlocks per raid for curse coverage and DoT damage
    ]],
    author = "Rakizi",
}

-- Demonology Rotation
local demonologyRotation = {
    -- Core identification
    name = "Demonology",
    specIndex = 2,
    class = "WARLOCK",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    lastModified = "12/30/2025",
    rotationString = [[
    -- NOTE: Use LOWEST-RANK IDs with ResolveEffectiveSpellId/*Resolved helpers.
    NAG:EnableAssignmentsGate()

    -- Maintain Fel Armor
    or (NAG:SpellCanCast(28176) and (not NAG:AuraIsActive(28176)))
        and NAG:Cast(28176)
    -- Maintain Pet: Felguard if known, otherwise Succubus
    or ((not NAG:PetIsActive()) and NAG:SpellIsKnown(30146) and NAG:SpellCanCast(30146))
        and NAG:Cast(30146)
    or ((not NAG:PetIsActive()) and NAG:SpellCanCast(712))
        and NAG:Cast(712)
    -- Pet check: warn if pet is not attacking while in combat
    or (NAG:PetIsActive() and NAG:InCombat() and NAG:UnitExists("target")
        and ((not NAG:UnitExists("pettarget")) or (not NAG:InCombat("pet"))))
        and NAG:ShowCustomOverlay("Pet Not Attacking")

        -- Execute: Shadowburn (shard spender)
        -- Only if a Shadow Bolt won't land in time
        or ((NAG:CurrentSoulShards() >= 1)
            and (NAG:RemainingTime() < (NAG:SpellCastTime(686) + NAG:SpellTravelTime(686))))
            and NAG:Cast(17877)

        -- Conflagrate: finisher (target about to die + Immolate active) or movement (instant cast)
        -- Consumes Immolate; only use when DoT would be wasted or when moving
        or ( (NAG:RemainingTime() < (0.5 + NAG:SpellCastTime(686) + NAG:SpellTravelTime(686))) or (NAG:UnitIsMoving() and NAG:DotRemainingTimeNow(348) <= 10))
        and NAG:DotIsActive(348, "target") and NAG:AuraIsActive(18789) and NAG:Cast(17962)


    -- Soulshatter when threat is high (group only, shards required)
    or (NAG:InCombat() and (NAG:GetNumGroupMembers() > 0) and (NAG:CurrentSoulShards() >= 1)
        and SOULSHATTER_THREAT_VALUE_BASELINE and (NAG:UnitThreatValue() >= SOULSHATTER_THREAT_VALUE_BASELINE)
        and (NAG:UnitThreatPercent() >= 90) and NAG:SpellCanCast(29858))
        and NAG:CastWithOverlay(29858, "SHATTER", NAG.SPELL_POSITIONS.LEFT)

    -- Movement: Death Coil (only when moving and in combat; otherwise filler is preferred)
    or (NAG:InCombat() and NAG:UnitIsMoving() and NAG:SpellCanCast(6789))
        and NAG:Cast(6789, nil, NAG.SPELL_POSITIONS.AOE)

    -- Mana: Life Tap when needed (health-safe, ideally while moving)
    or ((NAG:UnitIsMoving() or NAG:CurrentManaPercent() < 0.20)
        and (NAG:CurrentManaPercent() < 0.70)
        and (NAG:CurrentHealthPercent() >= 0.50)
        and NAG:SpellCanCast(1454))
        and NAG:Cast(1454, nil, NAG.SPELL_POSITIONS.RIGHT)

    -- Backlash proc: Incinerate if Immolate on target, else Shadow Bolt (highest known rank via Cast)
    or (NAG:AuraIsActive(34936, "player") and NAG:DotIsActive(348, "target") and NAG:SpellCanCast(32231))
        and NAG:Cast(32231)
    or (NAG:AuraIsActive(34936, "player") and (not NAG:DotIsActive(348, "target")) and NAG:SpellCanCast(686))
        and NAG:Cast(686)

    -- Out of combat: suggest pre-pull Curse of Doom with a right arrow (target level > player or boss/unknown level)
    or ((not NAG:InCombat()) and NAG:UnitExists("target") and NAG:SpellCanCast(603)
        and ((UnitLevel("target") or 0) > (UnitLevel("player") or 0) or (UnitLevel("target") or 0) < 0))
        and NAG:CastPlaceHolderWithArrow(603, "left1", "RIGHT", 1.5)

    -- AoE: Seed of Corruption on packs that live long enough
    -- AoE: Seed of Corruption on packs that live long enough
    or ((NAG:NumberTargetsWithTTD(9, 30) >= 2) and (not NAG:DotIsActive(27243)) and NAG:SpellCanCast(27243))
        and NAG:Cast(27243,  nil, NAG.SPELL_POSITIONS.PRIMARY)
    -- Utility curses (assignment opt-in only; priority Reck -> Elements -> Weak -> Tongues)
    or (NAG:IsAssignmentEnabled("curse_of_recklessness")
        and NAG:ShouldUseCurseOfRecklessness()
        and (not NAG:IsSpellBlacklisted(704)) and (not NAG:DotIsActiveGlobal(704))
        and NAG:SpellCanCast(704))
        and NAG:Cast(704)
    or ((not NAG:IsAssignmentEnabled("curse_of_recklessness"))
        and NAG:IsAssignmentEnabled("curse_of_elements")
        and (not NAG:IsSpellBlacklisted(1490)) and (not NAG:DotIsActiveGlobal(1490))
        and NAG:SpellCanCast(1490))
        and NAG:Cast(1490)
    or ((not NAG:IsAssignmentEnabled("curse_of_recklessness"))
        and (not NAG:IsAssignmentEnabled("curse_of_elements"))
        and NAG:IsAssignmentEnabled("curse_of_weakness")
        and (not NAG:IsSpellBlacklisted(702)) and (not NAG:DotIsActiveGlobal(702))
        and NAG:SpellCanCast(702))
        and NAG:Cast(702)
    or ((not NAG:IsAssignmentEnabled("curse_of_recklessness"))
        and (not NAG:IsAssignmentEnabled("curse_of_elements"))
        and (not NAG:IsAssignmentEnabled("curse_of_weakness"))
        and NAG:IsAssignmentEnabled("curse_of_tongues")
        and (not NAG:IsSpellBlacklisted(1714)) and (not NAG:DotIsActiveGlobal(1714))
        and NAG:SpellCanCast(1714))
        and NAG:Cast(1714)

    -- Curse of Agony (22-70s) - only if no utility assignment is enabled
    or ((not NAG:IsAssignmentEnabled("curse_of_recklessness"))
        and (not NAG:IsAssignmentEnabled("curse_of_elements"))
        and (not NAG:IsAssignmentEnabled("curse_of_weakness"))
        and (not NAG:IsAssignmentEnabled("curse_of_tongues"))
        and (NAG:RemainingTime() >= 22) and (NAG:RemainingTime() <= 70)
        and (NAG:RemainingTime() >= 7777 or NAG:RemainingTime() > 10)
        and (not (NAG:DotIsActive(603) or NAG:DotIsActive(980) or NAG:DotIsActive(1490) or NAG:DotIsActive(704) or NAG:DotIsActive(17862) or NAG:DotIsActive(702) or NAG:DotIsActive(1714)))
        and (not NAG:DotIsActiveGlobal(980))
        and ((not NAG:DotIsActive(980)) or (NAG:DotRemainingTime(980) <= (NAG:GCDTimeValue() + 0.10)))
        and NAG:SpellCanCast(980))
        and NAG:Cast(980)

    -- Curse of Doom with Amplify Curse (60-600s) - only if no utility assignment is enabled
    or ((not NAG:IsAssignmentEnabled("curse_of_recklessness"))
        and (not NAG:IsAssignmentEnabled("curse_of_elements"))
        and (not NAG:IsAssignmentEnabled("curse_of_weakness"))
        and (not NAG:IsAssignmentEnabled("curse_of_tongues"))
        and (NAG:RemainingTime() > 60) and (NAG:RemainingTime() < 600)
        and (not (NAG:DotIsActive(603) or NAG:DotIsActive(980) or NAG:DotIsActive(1490) or NAG:DotIsActive(704) or NAG:DotIsActive(17862) or NAG:DotIsActive(702) or NAG:DotIsActive(1714)))
        and (not NAG:DotIsActiveGlobal(603))
        and ((not NAG:DotIsActive(603)) or (NAG:DotRemainingTime(603) <= (NAG:GCDTimeValue() + 0.10)))
        and NAG:SpellCanCast(603)
        and NAG:AuraIsActive(18288))
        and NAG:Cast(603)

    -- Amplify Curse before Curse of Doom (60-600s) - only if no utility assignment is enabled
    or ((not NAG:IsAssignmentEnabled("curse_of_recklessness"))
        and (not NAG:IsAssignmentEnabled("curse_of_elements"))
        and (not NAG:IsAssignmentEnabled("curse_of_weakness"))
        and (not NAG:IsAssignmentEnabled("curse_of_tongues"))
        and (NAG:RemainingTime() > 60) and (NAG:RemainingTime() < 600)
        and (not (NAG:DotIsActive(603) or NAG:DotIsActive(980) or NAG:DotIsActive(1490) or NAG:DotIsActive(704) or NAG:DotIsActive(17862) or NAG:DotIsActive(702) or NAG:DotIsActive(1714)))
        and (not NAG:DotIsActiveGlobal(603))
        and ((not NAG:DotIsActive(603)) or (NAG:DotRemainingTime(603) <= (NAG:GCDTimeValue() + 0.10)))
        and NAG:SpellCanCast(603)
        and NAG:SpellCanCast(18288)
        and (not NAG:AuraIsActive(18288)))
        and NAG:Cast(18288)

    -- Curse of Doom without Amplify Curse (60-600s) - only if no utility assignment is enabled
    or ((not NAG:IsAssignmentEnabled("curse_of_recklessness"))
        and (not NAG:IsAssignmentEnabled("curse_of_elements"))
        and (not NAG:IsAssignmentEnabled("curse_of_weakness"))
        and (not NAG:IsAssignmentEnabled("curse_of_tongues"))
        and (NAG:RemainingTime() > 60) and (NAG:RemainingTime() < 600)
        and (not (NAG:DotIsActive(603) or NAG:DotIsActive(980) or NAG:DotIsActive(1490) or NAG:DotIsActive(704) or NAG:DotIsActive(17862) or NAG:DotIsActive(702) or NAG:DotIsActive(1714)))
        and (not NAG:DotIsActiveGlobal(603))
        and ((not NAG:DotIsActive(603)) or (NAG:DotRemainingTime(603) <= (NAG:GCDTimeValue() + 0.10)))
        and NAG:SpellCanCast(603))
        and NAG:Cast(603)

    -- Maintain Corruption
    or ((((not NAG:DotIsActive(172))
        or (NAG:DotRemainingTimeNow(172) <= ((NAG:UnitCastTimeRemaining("player") > 0)
            and NAG:UnitCastTimeRemaining("player")
            or NAG:GCDTimeToReady())))
        and (NAG:RemainingTime() >= 7777 or NAG:RemainingTime() > 7)
        and NAG:SpellCanCast(172))
        and NAG:Cast(172))

    -- Maintain Immolate
    or ((((not NAG:DotIsActive(348))
        or (NAG:DotRemainingTimeNow(348) <= ((NAG:UnitCastTimeRemaining("player") > 0)
            and NAG:UnitCastTimeRemaining("player")
            or (NAG:GCDTimeToReady() + NAG:SpellCastTime(348)))))
        and (NAG:RemainingTime() >= 7777 or NAG:RemainingTime() > 7))
        and NAG:SpellCanCast(348))
        and NAG:Cast(348)

    -- Cast Shadow Bolt (main filler)
    or NAG:NotSpamCast(686)
    or (NAG:DotIsActive(172)
        and (NAG:RemainingTime() >= 7777 or NAG:RemainingTime() > 7)
        and (NAG:DotRemainingTimeNow(172) <= ((NAG:UnitCastTimeRemaining("player") > 0)
            and NAG:UnitCastTimeRemaining("player")
            or NAG:GCDTimeToReady())))
        and NAG:Cast(172)
    or (NAG:DotIsActive(348)
        and (NAG:RemainingTime() >= 7777 or NAG:RemainingTime() > 7)
        and (NAG:DotRemainingTimeNow(348) <= ((NAG:UnitCastTimeRemaining("player") > 0)
            and NAG:UnitCastTimeRemaining("player")
            or (NAG:GCDTimeToReady() + NAG:SpellCastTime(348)))))
        and NAG:Cast(348)
    or NAG:Cast(686)
    ]],

    -- Tracked IDs for optimization
    spells = {28176, 712, 30146, 603, 980, 172, 348, 686, 32231, 17877, 6789, 1454, 27243, 18288, 1490, 704, 29858, 34936},
    items = {},
    auras = {28176, 18288, 172, 348, 603, 980, 34936}, -- Fel Armor, Amplify Curse, Corruption, Immolate, Curse of Doom, Curse of Agony, Backlash

    -- Optional metadata
    guide = [[
Demonology Warlock Rotation Guide (TBC)

Core Mechanics:
- Demonology Warlocks are DoT-based DPS casters with strong pet contribution.
- Reapply DoTs only after they fall off.
- Curse choice is fight-length dependent: Doom for long fights, Agony for short fights.
- Coordinate curses: only one curse can be active on a target.
- Life Tap is part of your rotation; use it when mana is low and health is safe.

Rotation Priority (Single Target):
1. If Fel Armor is missing, cast Fel Armor.
2. If pet is missing, summon Felguard (if known) or Succubus.
3. If execute phase and a Shadow Bolt won't land in time, cast Shadowburn.
4. Use Soulshatter in group when threat is high (shards required).
5. If moving and you need an instant, cast Death Coil.
6. If mana is low and health is safe, cast Life Tap (ideally while moving).
7. If target will live <60s and no other curse is active, cast Curse of Agony.
8. If target will live >=60s and no other curse is active, cast Amplify Curse then Curse of Doom.
9. Maintain Corruption (reapply after it falls off).
10. Maintain Immolate (reapply after it falls off).
11. Cast Shadow Bolt as filler.

AoE Rotation:
- Seed of Corruption for multi-target packs (TTD-gated).

Curse Priority:
- Curse of Doom: Primary curse for long fights (60 second duration)
- Curse of Agony: Use if boss will die in <60 seconds
- Curse of the Elements: Use if assigned by raid leader (magic vulnerability debuff)
- Curse of Recklessness: Use if assigned by raid leader (armor reduction, removes fear)
- Note: Only one curse can be active per target - coordinate with other Warlocks

DoT Management:
- Reapply DoTs only after they fall off.
- Corruption: 12 second duration
- Immolate: 15 second duration

Mana Management:
- Life Tap: Converts health to mana - use when low on mana
- Ideally use Life Tap while moving to avoid DPS loss
- Fel Armor: Provides passive mana regeneration
- Demonology talents provide additional mana efficiency

Movement:
- Shadowburn: Instant cast shadow damage - use while moving
- Death Coil: Instant cast fear with damage - use while moving
- Life Tap: Can be used while moving without DPS loss

Pet:
- Summon Succubus: Best pet for Demonology Warlocks
- Provides passive damage boost
- Keep pet alive and on target at all times

Raid Coordination:
- Coordinate curses with other Warlocks - only one curse per target
- May be assigned Curse of the Elements or Curse of Recklessness
- Usually 1-2 Demonology Warlocks per raid for curse coverage and DoT damage
    ]],
    author = "Rakizi",
}

-- Destruction Rotation
local destructionRotation = {
    -- Core identification
    name = "Destruction",
    specIndex = 3,
    class = "WARLOCK",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    lastModified = "12/30/2025",
    rotationString = [[
    -- NOTE: Use LOWEST-RANK IDs with ResolveEffectiveSpellId/*Resolved helpers.
    NAG:EnableAssignmentsGate()

    -- Maintain Fel Armor
    or (NAG:SpellCanCast(28176) and (not NAG:AuraIsActive(28176)))
        and NAG:Cast(28176)

    -- Demonic Sacrifice (Touch of Shadow or Burning Wish)
    or ((not NAG:AuraIsActive(18791)) and (not NAG:AuraIsActive(18789)) and NAG:PetIsActive() and NAG:SpellCanCast(18788))
        and NAG:Cast(18788)

    -- Summon pet for Demonic Sacrifice (Succubus default)
    or ((not NAG:AuraIsActive(18791)) and (not NAG:AuraIsActive(18789)) and (not NAG:PetIsActive()) and NAG:SpellCanCast(712))
        and NAG:Cast(712)

        -- Execute: Shadowburn (shard spender)
        -- Only if a Shadow Bolt won't land in time
        or ((NAG:CurrentSoulShards() >= 1)
            and (NAG:RemainingTime() < (NAG:SpellCastTime(686) + NAG:SpellTravelTime(686))))
            and NAG:Cast(17877)

        -- Conflagrate: finisher (target about to die + Immolate active) or movement (instant cast)
        -- Consumes Immolate; only use when DoT would be wasted or when moving
        or ( (NAG:RemainingTime() < (0.5 + NAG:SpellCastTime(686) + NAG:SpellTravelTime(686))) or (NAG:UnitIsMoving() and NAG:DotRemainingTimeNow(348) <= 10))
        and NAG:DotIsActive(348, "target") and NAG:AuraIsActive(18789) and NAG:Cast(17962)

    -- Soulshatter when threat is high (group only, shards required)
    or (NAG:InCombat() and (NAG:GetNumGroupMembers() > 0) and (NAG:CurrentSoulShards() >= 1)
        and SOULSHATTER_THREAT_VALUE_BASELINE and (NAG:UnitThreatValue() >= SOULSHATTER_THREAT_VALUE_BASELINE)
        and (NAG:UnitThreatPercent() >= 90) and NAG:SpellCanCast(29858))
        and NAG:CastWithOverlay(29858, "SHATTER", NAG.SPELL_POSITIONS.LEFT)

    -- Movement: Death Coil (only when moving and in combat; otherwise filler is preferred)
    or (NAG:InCombat() and NAG:UnitIsMoving() and NAG:SpellCanCast(6789))
        and NAG:Cast(6789,  nil, NAG.SPELL_POSITIONS.AOE)

    -- Mana: Life Tap when needed (health-safe, ideally while moving)
    or ((NAG:UnitIsMoving() or NAG:CurrentManaPercent() < 0.20)
        and (NAG:CurrentManaPercent() < 0.70)
        and (NAG:CurrentHealthPercent() >= 0.50)
        and NAG:SpellCanCast(1454))
        and NAG:Cast(1454, nil, NAG.SPELL_POSITIONS.RIGHT)

    -- Backlash proc: Incinerate if Immolate on target, else Shadow Bolt (highest known rank via Cast)
    or (NAG:AuraIsActive(34936, "player") and NAG:DotIsActive(348, "target") and NAG:SpellCanCast(32231))
        and NAG:Cast(32231)
    or (NAG:AuraIsActive(34936, "player") and (not NAG:DotIsActive(348, "target")) and NAG:SpellCanCast(686))
        and NAG:Cast(686)

    -- Out of combat: suggest pre-pull Curse of Doom with a right arrow (target level > player or boss/unknown level)
    or ((not NAG:InCombat()) and NAG:UnitExists("target") and NAG:SpellCanCast(603)
        and ((UnitLevel("target") or 0) > (UnitLevel("player") or 0) or (UnitLevel("target") or 0) < 0))
        and NAG:CastPlaceHolderWithArrow(603, "left1", "RIGHT", 1.5)

    -- AoE: Seed of Corruption on packs that live long enough
    or ((NAG:NumberTargetsWithTTD(9, 30) >= 2) and (not NAG:DotIsActive(27243)) and NAG:SpellCanCast(27243))
        and NAG:Cast(27243,  nil, NAG.SPELL_POSITIONS.PRIMARY)

    -- Utility curses (assignment opt-in only; priority Reck -> Elements -> Weak -> Tongues)
    or (NAG:IsAssignmentEnabled("curse_of_recklessness")
        and NAG:ShouldUseCurseOfRecklessness()
        and (not NAG:IsSpellBlacklisted(704)) and (not NAG:DotIsActiveGlobal(704))
        and NAG:SpellCanCast(704))
        and NAG:Cast(704)
    or ((not NAG:IsAssignmentEnabled("curse_of_recklessness"))
        and NAG:IsAssignmentEnabled("curse_of_elements")
        and (not NAG:IsSpellBlacklisted(1490)) and (not NAG:DotIsActiveGlobal(1490))
        and NAG:SpellCanCast(1490))
        and NAG:Cast(1490)
    or ((not NAG:IsAssignmentEnabled("curse_of_recklessness"))
        and (not NAG:IsAssignmentEnabled("curse_of_elements"))
        and NAG:IsAssignmentEnabled("curse_of_weakness")
        and (not NAG:IsSpellBlacklisted(702)) and (not NAG:DotIsActiveGlobal(702))
        and NAG:SpellCanCast(702))
        and NAG:Cast(702)
    or ((not NAG:IsAssignmentEnabled("curse_of_recklessness"))
        and (not NAG:IsAssignmentEnabled("curse_of_elements"))
        and (not NAG:IsAssignmentEnabled("curse_of_weakness"))
        and NAG:IsAssignmentEnabled("curse_of_tongues")
        and (not NAG:IsSpellBlacklisted(1714)) and (not NAG:DotIsActiveGlobal(1714))
        and NAG:SpellCanCast(1714))
        and NAG:Cast(1714)

    -- Curse of Agony (22-70s) - only if no utility assignment is enabled
    or ((not NAG:IsAssignmentEnabled("curse_of_recklessness"))
        and (not NAG:IsAssignmentEnabled("curse_of_elements"))
        and (not NAG:IsAssignmentEnabled("curse_of_weakness"))
        and (not NAG:IsAssignmentEnabled("curse_of_tongues"))
        and (NAG:RemainingTime() >= 22) and (NAG:RemainingTime() <= 70)
        and (NAG:RemainingTime() >= 7777 or NAG:RemainingTime() > 10)
        and (not (NAG:DotIsActive(603) or NAG:DotIsActive(980) or NAG:DotIsActive(1490) or NAG:DotIsActive(704) or NAG:DotIsActive(17862) or NAG:DotIsActive(702) or NAG:DotIsActive(1714)))
        and (not NAG:DotIsActiveGlobal(980))
        and ((not NAG:DotIsActive(980)) or (NAG:DotRemainingTime(980) <= (NAG:GCDTimeValue() + 0.10)))
        and NAG:SpellCanCast(980))
        and NAG:Cast(980)

    -- Curse of Doom with Amplify Curse (60-600s) - only if no utility assignment is enabled
    or ((not NAG:IsAssignmentEnabled("curse_of_recklessness"))
        and (not NAG:IsAssignmentEnabled("curse_of_elements"))
        and (not NAG:IsAssignmentEnabled("curse_of_weakness"))
        and (not NAG:IsAssignmentEnabled("curse_of_tongues"))
        and (NAG:RemainingTime() > 60) and (NAG:RemainingTime() < 600)
        and (not (NAG:DotIsActive(603) or NAG:DotIsActive(980) or NAG:DotIsActive(1490) or NAG:DotIsActive(704) or NAG:DotIsActive(17862) or NAG:DotIsActive(702) or NAG:DotIsActive(1714)))
        and (not NAG:DotIsActiveGlobal(603))
        and ((not NAG:DotIsActive(603)) or (NAG:DotRemainingTime(603) <= (NAG:GCDTimeValue() + 0.10)))
        and NAG:SpellCanCast(603)
        and NAG:AuraIsActive(18288))
        and NAG:Cast(603)

    -- Amplify Curse before Curse of Doom (60-600s) - only if no utility assignment is enabled
    or ((not NAG:IsAssignmentEnabled("curse_of_recklessness"))
        and (not NAG:IsAssignmentEnabled("curse_of_elements"))
        and (not NAG:IsAssignmentEnabled("curse_of_weakness"))
        and (not NAG:IsAssignmentEnabled("curse_of_tongues"))
        and (NAG:RemainingTime() > 60) and (NAG:RemainingTime() < 600)
        and (not (NAG:DotIsActive(603) or NAG:DotIsActive(980) or NAG:DotIsActive(1490) or NAG:DotIsActive(704) or NAG:DotIsActive(17862) or NAG:DotIsActive(702) or NAG:DotIsActive(1714)))
        and (not NAG:DotIsActiveGlobal(603))
        and ((not NAG:DotIsActive(603)) or (NAG:DotRemainingTime(603) <= (NAG:GCDTimeValue() + 0.10)))
        and NAG:SpellCanCast(603)
        and NAG:SpellCanCast(18288)
        and (not NAG:AuraIsActive(18288)))
        and NAG:Cast(18288)

    -- Curse of Doom without Amplify Curse (60-600s) - only if no utility assignment is enabled
    or ((not NAG:IsAssignmentEnabled("curse_of_recklessness"))
        and (not NAG:IsAssignmentEnabled("curse_of_elements"))
        and (not NAG:IsAssignmentEnabled("curse_of_weakness"))
        and (not NAG:IsAssignmentEnabled("curse_of_tongues"))
        and (NAG:RemainingTime() > 60) and (NAG:RemainingTime() < 600)
        and (not (NAG:DotIsActive(603) or NAG:DotIsActive(980) or NAG:DotIsActive(1490) or NAG:DotIsActive(704) or NAG:DotIsActive(17862) or NAG:DotIsActive(702) or NAG:DotIsActive(1714)))
        and (not NAG:DotIsActiveGlobal(603))
        and ((not NAG:DotIsActive(603)) or (NAG:DotRemainingTime(603) <= (NAG:GCDTimeValue() + 0.10)))
        and NAG:SpellCanCast(603))
        and NAG:Cast(603)

    -- Maintain Immolate
    or ((((not NAG:DotIsActive(348))
        or (NAG:DotRemainingTimeNow(348) <= ((NAG:UnitCastTimeRemaining("player") > 0)
            and NAG:UnitCastTimeRemaining("player")
            or (NAG:GCDTimeToReady() + NAG:SpellCastTime(348)))))
        and (NAG:RemainingTime() >= 7777 or NAG:RemainingTime() > 7))
        and NAG:SpellCanCast(348))
        and NAG:Cast(348)

    -- Cast Incinerate if Burning Wish buff active (from Imp sacrifice)
    or (NAG:AuraIsActive(18789))
        and NAG:Cast(29722)

    -- Cast Shadow Bolt (main filler, or if Touch of Shadow buff active from Succubus sacrifice)
    or NAG:NotSpamCast(686)
    or (NAG:DotIsActive(348)
        and (NAG:RemainingTime() >= 7777 or NAG:RemainingTime() > 7)
        and (NAG:DotRemainingTimeNow(348) <= ((NAG:UnitCastTimeRemaining("player") > 0)
            and NAG:UnitCastTimeRemaining("player")
            or (NAG:GCDTimeToReady() + NAG:SpellCastTime(348)))))
        and NAG:Cast(348)
    or NAG:Cast(686)
    ]],

    -- Tracked IDs for optimization
    spells = {28176, 18788, 712, 688, 603, 980, 348, 686, 29722, 32231, 17877, 17962, 6789, 1454, 27243, 18288, 1490, 704, 29858, 34936},
    items = {},
    auras = {28176, 18288, 348, 603, 980, 18789, 18791, 34936}, -- Fel Armor, Amplify Curse, Immolate, Curse of Doom, Curse of Agony, Burning Wish (Imp sacrifice), Touch of Shadow (Succubus sacrifice), Backlash

    -- Optional metadata
    guide = [[
Destruction Warlock Rotation Guide (TBC)

Core Mechanics:
- Destruction Warlocks are burst DPS casters focusing on shadow or fire damage.
- Reapply Immolate only after it falls off.
- Curse choice is fight-length dependent: Doom for long fights, Agony for short fights.
- Main filler depends on which pet was sacrificed: Incinerate if Imp sacrificed (Burning Wish buff), Shadow Bolt if Succubus sacrificed (Touch of Shadow buff) or no sacrifice.
- Mana management is important - use Life Tap when needed, ideally while moving.

Rotation Priority (Single Target):
1. If Fel Armor is missing, cast Fel Armor.
2. If Demonic Sacrifice buffs are missing and pet is active, cast Demonic Sacrifice.
3. If Demonic Sacrifice buffs are missing and no pet is active, summon Succubus.
4. If execute phase and a Shadow Bolt won't land in time, cast Shadowburn.
5. If Immolate is active: use Conflagrate as finisher (target about to die) or when moving (instant cast).
6. Use Soulshatter in group when threat is high (shards required).
7. If moving and you need an instant, cast Death Coil.
8. If mana is low and health is safe, cast Life Tap (ideally while moving).
9. If target will live <60s and no other curse is active, cast Curse of Agony.
10. If target will live >=60s and no other curse is active, cast Amplify Curse then Curse of Doom.
11. Maintain Immolate (reapply after it falls off).
12. Cast Incinerate if Burning Wish buff active; otherwise Shadow Bolt.

AoE Rotation:
- Seed of Corruption for multi-target packs (TTD-gated).

Demonic Sacrifice:
- Sacrifice Summon Succubus for Touch of Shadow buff (shadow damage boost)
- Sacrifice Summon Imp for Burning Wish buff (fire damage boost)
- Provides significant damage buff for the cost of your pet
- Once sacrificed, you won't have a pet active
- Main filler spell depends on which buff you have: Incinerate for Burning Wish, Shadow Bolt for Touch of Shadow

Curse Priority:
- Curse of Doom: Primary curse for long fights (60 second duration)
- Curse of Agony: Use if boss will die in <60 seconds
- Curse of the Elements: Use if assigned by raid leader (magic vulnerability debuff)
- Curse of Recklessness: Use if assigned by raid leader (armor reduction, removes fear)
- Note: Only one curse can be active per target - coordinate with other Warlocks

DoT Management:
- Reapply Immolate only after it falls off.
- Immolate: 15 second duration
- Conflagrate: Consumes Immolate for instant damage; use as finisher (target about to die) or when moving

Mana Management:
- Life Tap: Converts health to mana - use when low on mana
- Ideally use Life Tap while moving to avoid DPS loss
- Fel Armor: Provides passive mana regeneration

Movement:
- Conflagrate: Instant cast (consumes Immolate) - use when moving and Immolate is active
- Shadowburn: Instant cast shadow damage - use while moving
- Death Coil: Instant cast fear with damage - use while moving
- Life Tap: Can be used while moving without DPS loss

Raid Coordination:
- Coordinate curses with other Warlocks - only one curse per target
- May be assigned Curse of the Elements or Curse of Recklessness
- Usually 1-2 Destruction Warlocks per raid for curse coverage and burst damage
    ]],
    author = "Rakizi",
}

--- @class Warlock : ClassBase
local Warlock = NAG:CreateClassModule("WARLOCK", defaults, {
    eventHandlers = {
        PLAYER_REGEN_ENABLED = "OnDoomTrackerLeaveCombat",
    },
    cleuHandlers = {
        SPELL_CAST_SUCCESS = "HandleDoomTrackerSpellCastSuccess",
        UNIT_DIED = "HandleDoomTrackerUnitDied",
    },
})
if not Warlock then return end

-- Affliction Macros
local afflictionMacros = {
    {
        name = "Amplify Curse + Curse of Doom",
        body = "#showtooltip Curse of Doom\n/cast Amplify Curse\n/cast Curse of Doom"
    },
}

-- Demonology Macros
local demonologyMacros = {
    {
        name = "Amplify Curse + Curse of Doom",
        body = "#showtooltip Curse of Doom\n/cast Amplify Curse\n/cast Curse of Doom"
    },
}

-- Destruction Macros
local destructionMacros = {
    {
        name = "Amplify Curse + Curse of Doom",
        body = "#showtooltip Curse of Doom\n/cast Amplify Curse\n/cast Curse of Doom"
    },
}

function Warlock:SetupClassDefaults()
    -- Attach macros to rotations
    afflictionRotation.macros = afflictionMacros
    demonologyRotation.macros = demonologyMacros
    destructionRotation.macros = destructionMacros
    ns.AddRotationToDefaults(self.defaults, 0, genericRotation)  -- Generic (no talents)
    ns.AddRotationToDefaults(self.defaults, 1, afflictionRotation)  -- Affliction
    ns.AddRotationToDefaults(self.defaults, 2, demonologyRotation)  -- Demonology
    ns.AddRotationToDefaults(self.defaults, 3, destructionRotation)  -- Destruction
end

-- ============================ DOOM TRACKER ============================
function Warlock:GetDoomTrackerState()
    local tracker = self.doomTracker
    if not tracker or not tracker.castTime then
        return nil
    end

    local elapsed = GetTime() - tracker.castTime
    local remaining = CURSE_OF_DOOM_DURATION_SECONDS - elapsed
    if remaining <= 0 then
        self.doomTracker = nil
        return nil
    end

    return {
        castTime = tracker.castTime,
        targetGUID = tracker.targetGUID,
        remainingSeconds = remaining,
    }
end

function Warlock:HandleDoomTrackerSpellCastSuccess(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
                                                   sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId)
    local playerGUID = UnitGUID("player")
    if sourceGUID ~= playerGUID then
        return
    end

    if not self._doomSpellName then
        local doomInfo = ns.WoWAPI.GetSpellInfo(CURSE_OF_DOOM_BASE_SPELL_ID)
        self._doomSpellName = doomInfo and doomInfo.name or nil
    end
    if not self._doomSpellName then
        return
    end

    local castInfo = ns.WoWAPI.GetSpellInfo(spellId)
    if not castInfo or castInfo.name ~= self._doomSpellName then
        return
    end

    self.doomTracker = {
        castTime = GetTime(),
        targetGUID = destGUID,
    }
end

function Warlock:HandleDoomTrackerUnitDied(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
                                           sourceRaidFlags, destGUID)
    if not destGUID or not self.doomTracker then
        return
    end

    if self.doomTracker.targetGUID == destGUID then
        self.doomTracker = nil
    end
end

function Warlock:OnDoomTrackerLeaveCombat()
    self.doomTracker = nil
end

NAG.Class = Warlock

