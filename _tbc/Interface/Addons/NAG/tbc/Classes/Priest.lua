local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version

local defaults = ns.InitializeClassDefaults()

-- TBC Priest spec spell locations
defaults.class.specSpellLocations = {
    [1] = {
        [20572] = NAG.SPELL_POSITIONS.LEFT, -- Blood Fury (Orc Racial)
        [26297] = NAG.SPELL_POSITIONS.LEFT, -- Berserking (Troll Racial)
        [28734] = NAG.SPELL_POSITIONS.LEFT, -- Mana Tap (BE Racial)
        [25046] = NAG.SPELL_POSITIONS.LEFT, -- Arcane Torrent (BE Racial)
    },  -- Discipline (not supported)
    [2] = {
        [20572] = NAG.SPELL_POSITIONS.LEFT, -- Blood Fury (Orc Racial)
        [26297] = NAG.SPELL_POSITIONS.LEFT, -- Berserking (Troll Racial)
        [28734] = NAG.SPELL_POSITIONS.LEFT, -- Mana Tap (BE Racial)
        [25046] = NAG.SPELL_POSITIONS.LEFT, -- Arcane Torrent (BE Racial)
    },  -- Holy (not supported)
    [3] = { -- Shadow
        -- BELOW spells (Pets)

        -- LEFT spells (Cooldowns, racials)
        [14751] = NAG.SPELL_POSITIONS.LEFT,    -- Inner Focus
        [34433] = NAG.SPELL_POSITIONS.LEFT,   -- Shadowfiend (pet summon)
        [20572] = NAG.SPELL_POSITIONS.LEFT,    -- Blood Fury (Orc Racial)
        [26297] = NAG.SPELL_POSITIONS.LEFT,    -- Berserking (Troll Racial)
        [28734] = NAG.SPELL_POSITIONS.LEFT,    -- Mana Tap (BE Racial)
        [25046] = NAG.SPELL_POSITIONS.LEFT,    -- Arcane Torrent (BE Racial)

        -- PRIMARY spells (default, not explicitly set)
        -- Vampiric Touch (34914) - DoT debuff
        -- Shadow Word: Pain (589) - DoT debuff
        -- Mind Blast (8092) - main nuke
        -- Shadow Word: Death (32379) - execute phase
        -- Mind Flay (15407) - channeled filler
    },
}

-- Self-heal when low health (generic rotation)
defaults.class.recommendSelfHeal = true
defaults.class.selfHealThreshold = 0.35

-- Class assignments for raid coordination
defaults.class.classAssignments = {
    {
        id = "power_word_fortitude",
        name = "Power Word: Fortitude",
        description = "Provide stamina buff to raid (coordinate with other Priests)",
        spellIds = {1243, 1244, 1245, 2791, 10937, 10938, 25389}, -- All ranks
        category = "buff",
    },
    {
        id = "shadow_protection",
        name = "Shadow Protection / Prayer of Shadow Protection",
        description = "Provide shadow resistance buff to raid (coordinate with other Priests)",
        spellIds = {976, 10957, 10958, 25433, 27683}, -- All ranks
        category = "buff",
    },
}

if UnitClassBase('player') ~= "PRIEST" then return end

-- Discipline Healing Rotation (spec 1)
-- Mouseover-based healing: uses NAG.state.healing from TBC HealingStateManager
-- devOnly: visible only when Developer Mode is enabled
-- TBC Disc Priest key spells:
--   Power Word: Shield (17), Flash Heal (2061), Greater Heal (2060),
--   Heal (2054), Prayer of Healing (596), Prayer of Mending (33076),
--   Inner Focus (14751), Power Infusion (10060), Dispel Magic (527),
--   Cure Disease (528)
local disciplineRotation = {
    name = "Discipline",
    specIndex = 1,
    description = "Mouseover healing: PW:Shield, Flash Heal, Greater Heal, Prayer of Mending.",
    class = "PRIEST",
    default = true,
    enabled = true,
    devOnly = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    lastModified = "02/08/2026",
    rotationString = [[
-- Inner Fire upkeep
(not NAG:AuraIsActive(588) and NAG:SpellCanCast(588)) and NAG:Cast(588)

-- Dispel Magic on mouseover with dispellable debuff
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverNeedsDispel()
    and NAG:SpellCanCast(527)) and NAG:Cast(527)

-- Power Word: Shield on mouseover (not on Weakened Soul)
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 80
    and (not NAG:MouseoverHasBuff(17)) and (not NAG:MouseoverHasBuff(6788))
    and NAG:SpellCanCast(17)) and NAG:Cast(17)

-- Prayer of Mending (keep rolling, TBC has this)
or (NAG:MouseoverFriendlyExists() and (not NAG:MouseoverHasBuff(33076))
    and NAG:SpellCanCast(33076)) and NAG:Cast(33076)

-- Inner Focus before big heal
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 40
    and NAG:SpellCanCast(14751) and (not NAG:AuraIsActive(14751))) and NAG:Cast(14751)

-- Flash Heal on critical mouseover
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 35
    and NAG:SpellCanCast(2061)) and NAG:Cast(2061)

-- Prayer of Healing when 3+ need healing
or (NAG:LowHealthMemberCount(75) >= 3
    and NAG:SpellCanCast(596)) and NAG:Cast(596)

-- Greater Heal on low mouseover
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 55
    and NAG:SpellCanCast(2060)) and NAG:Cast(2060)

-- Heal (efficient) on moderate mouseover
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 85
    and NAG:SpellCanCast(2054)) and NAG:Cast(2054)

-- Damage filler: Smite
or NAG:SpellCanCast(585) and NAG:Cast(585)
    ]],

    spells = {17, 527, 528, 585, 588, 596, 2054, 2060, 2061, 6788, 14751, 33076},
    items = {},
    auras = {588, 14751},
    author = "Smufrik",
}

-- Holy Healing Rotation (spec 2)
-- Mouseover-based healing: uses NAG.state.healing from TBC HealingStateManager
-- devOnly: visible only when Developer Mode is enabled
-- TBC Holy Priest key spells:
--   Greater Heal (2060), Flash Heal (2061), Heal (2054),
--   Prayer of Healing (596), Prayer of Mending (33076),
--   Circle of Healing (34861), Renew (139), Lightwell (724),
--   Guardian Spirit (n/a in TBC), Inner Focus (14751),
--   Dispel Magic (527), Cure Disease (528)
local holyRotation = {
    name = "Holy",
    specIndex = 2,
    description = "Mouseover healing: Renew, Circle of Healing, Flash Heal, Greater Heal.",
    class = "PRIEST",
    default = true,
    enabled = true,
    devOnly = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    lastModified = "02/08/2026",
    rotationString = [[
-- Inner Fire upkeep
(not NAG:AuraIsActive(588) and NAG:SpellCanCast(588)) and NAG:Cast(588)

-- Dispel Magic on mouseover with dispellable debuff
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverNeedsDispel()
    and NAG:SpellCanCast(527)) and NAG:Cast(527)

-- Circle of Healing when 3+ need healing (if talented)
or (NAG:LowHealthMemberCount(80) >= 3
    and NAG:SpellIsKnown(34861) and NAG:SpellCanCast(34861)) and NAG:Cast(34861)

-- Prayer of Mending (keep rolling)
or (NAG:MouseoverFriendlyExists() and (not NAG:MouseoverHasBuff(33076))
    and NAG:SpellCanCast(33076)) and NAG:Cast(33076)

-- Renew on mouseover (keep up on injured)
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 85
    and (not NAG:MouseoverHasBuff(139))
    and NAG:SpellCanCast(139)) and NAG:Cast(139)

-- Inner Focus before big heal
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 40
    and NAG:SpellCanCast(14751) and (not NAG:AuraIsActive(14751))) and NAG:Cast(14751)

-- Flash Heal on critical mouseover
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 30
    and NAG:SpellCanCast(2061)) and NAG:Cast(2061)

-- Prayer of Healing when 3+ need healing
or (NAG:LowHealthMemberCount(75) >= 3
    and NAG:SpellCanCast(596)) and NAG:Cast(596)

-- Greater Heal on low mouseover
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 50
    and NAG:SpellCanCast(2060)) and NAG:Cast(2060)

-- Heal (efficient) on moderate mouseover
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 85
    and NAG:SpellCanCast(2054)) and NAG:Cast(2054)

-- Damage filler: Smite
or NAG:SpellCanCast(585) and NAG:Cast(585)
    ]],

    spells = {139, 527, 528, 585, 588, 596, 2054, 2060, 2061, 14751, 33076, 34861},
    items = {},
    auras = {139, 588, 14751},
    author = "Smufrik",
}

-- Shadow Rotation
local shadowRotation = {
    -- Core identification
    name = "Shadow",
    specIndex = 3,
    class = "PRIEST",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    lastModified = "12/17/2025",
    rotationString = [[
    -- NOTE: This APL intentionally uses LOWEST-RANK IDs (learned earliest) and relies on
    -- ResolveEffectiveSpellId / *Resolved helpers so the player still casts their best known rank.

    -- Shadowform (keep up)
    (NAG:SpellIsKnown(15473) and (not NAG:AuraIsActive(15473)) and NAG:SpellCanCast(15473))
        and NAG:Cast(15473)

    -- Mana cooldown: Shadowfiend (use when mana is meaningfully low, in combat)
    or (NAG:InCombat() and (NAG:CurrentManaPercent() <= 0.60) and NAG:SpellCanCast(34433))
        and NAG:Cast(34433, nil, NAG.SPELL_POSITIONS.BELOW)

    -- Multi-dot helper (TAB target) - only if targets live long enough for 3+ ticks (~9s)
    or ((NAG:NumberTargetsWithTTD(9, 30) >= 2)
        and NAG:ShouldMultidot(34914, NAG:NumberTargetsWithTTD(9, 30), (NAG:DotTickFrequency(34914) or 3), 30)
        and NAG:SpellCanCast(34914))
        and NAG:CastWithOverlay(34914, "TAB\nDOT", NAG.SPELL_POSITIONS.LEFT)
    or ((NAG:NumberTargetsWithTTD(9, 30) >= 2)
        and NAG:DotIsActive(34914)
        and NAG:ShouldMultidot(589, NAG:NumberTargetsWithTTD(9, 30), (NAG:DotTickFrequency(589) or 3), 30)
        and NAG:SpellCanCast(589))
        and NAG:CastWithOverlay(589, "TAB\nDOT", NAG.SPELL_POSITIONS.RIGHT)

    -- Maintain Vampiric Touch (34914 = VT rank 1) during encounter
    or NAG:InCombat() and ((not NAG:DotIsActive(34914)) or (NAG:DotRemainingTime(34914) <= NAG:SpellCastTime(34914)))
        and NAG:RemainingTime() >= 8 and NAG:Cast(34914)
    -- Precast Vampiric Touch while out of combat, show to the left with an arrow
    or (not NAG:InCombat()) and NAG:SpellCanCast(34914) and NAG:CastPlaceHolderWithArrow(34914, "left1", "RIGHT", 1.5)

    -- Maintain Vampiric Embrace (15286 = VE rank 1) during encounter
    -- Keep aura active when talented/known.
    or (NAG:InEncounter()
        and (not NAG:DotIsActive(15286))
        and NAG:SpellCanCast(15286))
        and NAG:RemainingTime() >= 20 and NAG:RemainingTime() <= 6666 and NAG:Cast(15286, nil, NAG.SPELL_POSITIONS.LEFT)

    -- Maintain Shadow Word: Pain (589 = SW:P rank 1)
    -- Refresh very late (avoid overwriting ticks): missing OR about to fall off.
    or (((not NAG:DotIsActive(589)) or (NAG:DotRemainingTime(589) <= (NAG:GCDTimeValue() + 0.10)))
        and NAG:SpellCanCast(589))
        and NAG:Cast(589)

    -- Inner Focus paired with Mind Blast (14751 = Inner Focus)
    or (NAG:SpellCanCast(14751) and (not NAG:AuraIsActive(14751)) and NAG:SpellCanCast(8092))
        and NAG:Cast(14751, nil, NAG.SPELL_POSITIONS.LEFT)

    -- Mind Blast (8092 = Mind Blast rank 1)
    or NAG:NotSpamCast(8092)

    -- Shadow Word: Death (32379 = SW:D rank 1) - situational due to backlash risk.
    or NAG:NotSpamCast(32379)

    -- Filler: Mind Flay (15407 = Mind Flay rank 1)
    or NAG:Cast(15407)
    ]],

    -- Tracked IDs for optimization
    spells = {589, 8092, 14751, 15286, 15407, 15473, 32379, 34433, 34914},
    items = {},
    auras = {14751, 15286, 15473}, -- Inner Focus, Vampiric Embrace, Shadowform

    -- Optional metadata
    guide = [[
Shadow Priest Rotation Guide (TBC)

Core Mechanics:
- Vampiric Touch is core for damage and group mana return; keep it up on the target.
- DoT management matters: aim for high uptime, but avoid overwriting DoTs too early (wastes ticks).
- Mind Blast is a priority nuke; Mind Flay is your filler and can be clipped for higher-priority spells.
- Shadow Word: Death has backlash if the target does not die; treat it as situational.

Rotation Priority (Single Target):
1. If Mana is low and Shadowfiend is ready, cast Shadowfiend.
2. If Vampiric Touch is missing OR will expire before your next VT cast would finish (remaining <= cast time), cast Vampiric Touch.
3. If Shadow Word: Pain is missing OR about to expire, cast Shadow Word: Pain.
4. If Mind Blast is ready soon/now and Inner Focus is ready and not active, cast Inner Focus.
5. If Mind Blast is ready, cast Mind Blast.
6. If you are moving AND Shadow Word: Death is safe for you (you can afford the backlash), cast Shadow Word: Death.
7. Otherwise, channel Mind Flay (clip/interrupt it if a higher-priority spell becomes ready).

AoE Rotation:
1. If there are multiple targets with TTD >= 9s, tab-dot VT/SW:P (use "TAB DOT" overlay).
2. Proceed with single target rotation on primary target.

DoT Management:
- Vampiric Touch: 15 second duration, 3 second tick interval
- Shadow Word: Pain: 18 second duration, 3 second tick interval
- Avoid refreshing very early (it wastes remaining ticks).
- Refresh as late as practical while maintaining strong uptime (near expiration).

Cooldowns:
- Shadowfiend: 5min CD. Summons pet that attacks and restores mana.
- Inner Focus: 3min CD. Makes next spell free and increases crit chance by 25%.

Mana Management:
- Shadowfiend: Use when mana is low (and a valid target will live long enough for it to connect).
- Inner Focus: Use with Mind Blast for free cast and crit bonus
- Vampiric Touch: Provides mana return to your party/raid while it is active on the target.
- Consider using mana potions during long fights

Raid Utility:
- Vampiric Touch: Mana return utility (commonly 1 Shadow Priest per raid for this).
- Vampiric Embrace: Healing utility.
- Coordinate buffs with other Priests (Power Word: Fortitude, Shadow Protection)

Talents:
- Standard build focuses on Shadow tree with some Discipline points
- Adjust Shadow Focus points if over spell hit cap (16%)
- Shadow Power and Shadow Weaving are key damage talents
    ]],
    author = "Rakizi",
}

-- Generic (0 talent points): low-level abilities before choosing a spec
local genericRotation = {
    name = "Generic",
    specIndex = 0,
    class = "PRIEST",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    rotationString = [[
    (NAG:GetClassSetting('recommendSelfHeal', true) and (NAG:CurrentHealthPercent() < (NAG:GetClassSetting('selfHealThreshold', 0.35) or 0.35)) and NAG:SpellCanCast(2061)) and NAG:Cast(2061)
    or (NAG:GetClassSetting('recommendSelfHeal', true) and (NAG:CurrentHealthPercent() < (NAG:GetClassSetting('selfHealThreshold', 0.35) or 0.35)) and NAG:SpellCanCast(2050)) and NAG:Cast(2050)
    or (not NAG:AuraIsActive(1243)) and NAG:SpellCanCast(1243) and NAG:Cast(1243)
    or (NAG:SpellCanCast(589) and (not NAG:DotIsActive(589, "target"))) and NAG:Cast(589)
    or (NAG:SpellCanCast(8092)) and NAG:Cast(8092)
    or (NAG:SpellCanCast(585)) and NAG:Cast(585)
]],
}

--- @class Priest : ClassBase
local Priest = NAG:CreateClassModule("PRIEST", defaults)
if not Priest then return end

function Priest:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 0, genericRotation)  -- Generic (no talents)
    ns.AddRotationToDefaults(self.defaults, 1, disciplineRotation)  -- Discipline
    ns.AddRotationToDefaults(self.defaults, 2, holyRotation)  -- Holy
    ns.AddRotationToDefaults(self.defaults, 3, shadowRotation)  -- Shadow
end

function Priest:RegisterSpellTracking()
    local SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
    -- Register periodic damage DoTs for Shadow Priest
    SpellTrackingManager:RegisterPeriodicDamage({ 34914 }, { tickTime = 3, lastTickTime = nil }) -- Vampiric Touch
    SpellTrackingManager:RegisterPeriodicDamage({ 589 }, { tickTime = 3, lastTickTime = nil })   -- Shadow Word: Pain
end

local BaseGetOptions = Priest.GetOptions
function Priest:GetOptions()
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

NAG.Class = Priest

