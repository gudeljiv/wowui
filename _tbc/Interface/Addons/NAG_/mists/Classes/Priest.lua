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

-- MoP Priest spec spell locations
defaults.class.specSpellLocations = {
    [1] = { -- Discipline
        -- ABOVE spells
        -- (empty)

        -- BELOW spells
        [34433] = NAG.SPELL_POSITIONS.BELOW,    -- Shadowfiend

        -- RIGHT spells
        -- (empty)

        -- LEFT spells
        [26297] = NAG.SPELL_POSITIONS.LEFT,     -- Berserking
        [87151] = NAG.SPELL_POSITIONS.LEFT,     -- (unknown spell)
        [82174] = NAG.SPELL_POSITIONS.LEFT,     -- (unknown spell)

        -- AOE spells
        -- (empty)
    },
    [2] = { -- Holy
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
    [3] = { -- Shadow
        -- ABOVE spells
        -- (empty)

        -- BELOW spells
        [34433] = NAG.SPELL_POSITIONS.BELOW,    -- Shadowfiend

        -- RIGHT spells
        -- (empty)

        -- LEFT spells
        [26297] = NAG.SPELL_POSITIONS.LEFT,     -- Berserking
        [87151] = NAG.SPELL_POSITIONS.LEFT,     -- (unknown spell)
        [82174] = NAG.SPELL_POSITIONS.LEFT,     -- (unknown spell)

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
        id = "power_word_fortitude",
        name = "Power Word: Fortitude",
        description = "Provide stamina buff to raid (coordinate with other Priests)",
        spellIds = {21562, 469}, -- Power Word: Fortitude
        category = "buff",
    },
}

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
-- Leave below as is

if UnitClassBase('player') ~= "PRIEST" then return end

-- START OF GENERATED_ROTATIONS

-- Generic (0 spec / no spec selected): low-level abilities before choosing a spec
local genericRotation = {
    name = "Generic",
    specIndex = 0,
    class = "PRIEST",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    rotationString = [[
    (NAG:GetClassSetting('recommendSelfHeal', true) and (NAG:CurrentHealthPercent() < (NAG:GetClassSetting('selfHealThreshold', 0.35) or 0.35)) and NAG:SpellCanCast(2061)) and NAG:Cast(2061)
    or (NAG:GetClassSetting('recommendSelfHeal', true) and (NAG:CurrentHealthPercent() < (NAG:GetClassSetting('selfHealThreshold', 0.35) or 0.35)) and NAG:SpellCanCast(2050)) and NAG:Cast(2050)
    or (not NAG:AuraIsActive(1243)) and NAG:SpellCanCast(1243) and NAG:Cast(1243)
    or (NAG:SpellCanCast(589) and (not NAG:DotIsActive(589, "target"))) and NAG:Cast(589)
    or (NAG:SpellCanCast(8092)) and NAG:Cast(8092)
    or (NAG:SpellCanCast(585)) and NAG:Cast(585)
]],
}

local disciplineRotation = {
    name = "Discipline",
    specIndex = 1,
    description = "Mouseover healing: PW:Shield, Penance, Heal, Flash Heal, Prayer of Healing.",
    class = "PRIEST",
    default = true,
    enabled = true,
    devOnly = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    lastModified = "02/08/2026",
    rotationString = [[
-- Inner Fire upkeep
(not NAG:AuraIsActive(588)) and NAG:Cast(588)

-- Dispel: Purify on mouseover with dispellable debuff
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverNeedsDispel()) and NAG:Cast(527)

-- Power Word: Shield on mouseover (tank priority, not on Weakened Soul)
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverIsTank() and NAG:MouseoverHealthPercent() < 90
    and (not NAG:MouseoverHasBuff(17)) and (not NAG:MouseoverHasBuff(6788))) and NAG:Cast(17)
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 70
    and (not NAG:MouseoverHasBuff(17)) and (not NAG:MouseoverHasBuff(6788))) and NAG:Cast(17)

-- Penance on mouseover (healing, 2s channel)
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 75) and NAG:Cast(47540)

-- Prayer of Mending on tank
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverIsTank()
    and (not NAG:MouseoverHasBuff(33076)) and NAG:SpellIsReady(33076)) and NAG:Cast(33076)

-- Shadowfiend for mana regen
or (NAG:CurrentManaPercent() <= 0.70 and NAG:SpellIsReady(34433)) and NAG:Cast(34433)

-- Prayer of Healing when 3+ need healing
or (NAG:LowHealthMemberCount(80) >= 3) and NAG:Cast(596)

-- Flash Heal on critical mouseover
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 40) and NAG:Cast(2061)

-- Greater Heal on low mouseover
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 55) and NAG:Cast(2060)

-- Heal (efficient) on moderate mouseover
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 85) and NAG:Cast(2050)

-- Damage filler when nothing to heal: Smite
or NAG:Cast(585)
    ]],

    spells = {17, 527, 585, 588, 596, 2050, 2060, 2061, 6788, 33076, 34433, 47540},
    items = {},
    auras = {},
    runes = {},
    author = "Smufrik",
}

-- Holy Healing Rotation (spec 2)
-- Mouseover-based healing: uses NAG.state.healing from HealingStateManager (MoP)
-- devOnly: visible only when Developer Mode is enabled
local holyRotation = {
    name = "Holy",
    specIndex = 2,
    description = "Mouseover healing: Renew, Holy Word: Serenity, Heal, Flash Heal, Circle of Healing.",
    class = "PRIEST",
    default = true,
    enabled = true,
    devOnly = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    lastModified = "02/08/2026",
    rotationString = [[
-- Inner Fire upkeep
(not NAG:AuraIsActive(588)) and NAG:Cast(588)

-- Dispel: Purify on mouseover with dispellable debuff
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverNeedsDispel()) and NAG:Cast(527)

-- Circle of Healing when 3+ need healing
or (NAG:LowHealthMemberCount(85) >= 3 and NAG:SpellIsReady(34861)) and NAG:Cast(34861)

-- Prayer of Mending on tank (keep rolling)
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverIsTank()
    and (not NAG:MouseoverHasBuff(33076)) and NAG:SpellIsReady(33076)) and NAG:Cast(33076)

-- Renew on mouseover (keep up on tank, apply to injured)
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 90
    and (not NAG:MouseoverHasBuff(139)) and (NAG:MouseoverIsTank() or NAG:MouseoverHealthPercent() < 80)) and NAG:Cast(139)

-- Holy Word: Serenity on low mouseover (instant, strong single-target)
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 65
    and NAG:SpellIsReady(88684)) and NAG:Cast(88684)

-- Shadowfiend for mana regen
or (NAG:CurrentManaPercent() <= 0.70 and NAG:SpellIsReady(34433)) and NAG:Cast(34433)

-- Prayer of Healing when 3+ need healing (after CoH on CD)
or (NAG:LowHealthMemberCount(80) >= 3) and NAG:Cast(596)

-- Flash Heal on critical mouseover
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 35) and NAG:Cast(2061)

-- Greater Heal on low mouseover
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 50) and NAG:Cast(2060)

-- Heal (efficient filler) on moderate mouseover
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 90) and NAG:Cast(2050)

-- Damage filler when nothing to heal: Smite
or NAG:Cast(585)
    ]],

    spells = {139, 527, 585, 588, 596, 2050, 2060, 2061, 33076, 34433, 34861, 88684},
    items = {},
    auras = {},
    runes = {},
    author = "Smufrik",
}

local shadowRotation = {
    -- Core identification
    name = "Priest Shadow",
    specIndex = 3,
    class = "PRIEST",

    -- Required parameters
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { time = -2.5, action = "NAG:Cast(120696)" },
        { time = -1.0, action = "NAG:Cast(76093)" },
        { time = -1.0, action = "NAG:Cast(73510)" }
    },
    lastModified = "08/18/2025",
    rotationString = [[
            (not NAG:AuraIsActive(588)) and NAG:Cast(588)
    or (not NAG:AuraIsActive(15473)) and NAG:Cast(15473)
    or NAG:SpellCanCast(26297) and NAG:Cast(26297)
    or NAG:SpellCanCast(126734) and NAG:Cast(126734)
    or NAG:SpellCanCast(76093) and NAG:Cast(76093)
    or NAG:SpellCanCast(34433) and NAG:Cast(34433)
    or (NAG:UnitIsMoving() and NAG:SpellCanCast(120644)) and NAG:Cast(120644)
    or (NAG:UnitIsMoving() and (NAG:DotRemainingTime(589) <= 6)) and NAG:Cast(589)
    or (NAG:NumberTargets() >= 5) and NAG:Cast(48045)
    or (NAG:SpellCanCast(8092) and (NAG:CurrentGenericResource() <= 2)) and NAG:NotSpamCast(8092)
    or (((not NAG:DotIsActive(34914)) or (NAG:DotRemainingTime(34914) <= 2)) and (NAG:RemainingTime() >= 9)) and NAG:Cast(34914)
    or (((not NAG:DotIsActive(589)) or (NAG:DotRemainingTime(589) <= 1)) and (NAG:RemainingTime() >= 12)) and NAG:Cast(589)
    or (NAG:CurrentGenericResource() >= 3) and NAG:Cast(2944)
    or (NAG:SpellCanCast(32379) and NAG:IsExecutePhase(20)) and NAG:Cast(32379)
    or (NAG:NumberTargets() >= 3) and NAG:ChannelSpell(48045, function() return (NAG:GCDTimeToReady() <= NAG:ChannelClipDelay()) end)
    or NAG:ChannelSpell(15407, function() return (NAG:GCDTimeToReady() <= NAG:ChannelClipDelay()) end)
    or ((((NAG:CurrentManaPercent() <= 20) and (NAG:RemainingTimePercent() >= 50)) or ((NAG:CurrentManaPercent() <= 10) and (NAG:RemainingTimePercent() >= 25))) and NAG:SpellCanCast(47585)) and NAG:Cast(47585)

    ]],

    -- Tracked IDs for optimization
    spells = {589, 2944, 8092, 10060, 15407, 32379, 34433, 34914, 73510, 87160, 120696, 122128, 123040, 127632},
    items = {76093},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    author = "Jiw"
}



--- @class Priest : ClassBase
local Priest = NAG:CreateClassModule("PRIEST", defaults)
if not Priest then return end

function Priest:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 0, genericRotation)  -- Generic (no spec)
    ns.AddRotationToDefaults(self.defaults, 1, disciplineRotation)  -- Discipline
    ns.AddRotationToDefaults(self.defaults, 2, holyRotation)  -- Holy
    ns.AddRotationToDefaults(self.defaults, 3, shadowRotation)  -- Shadow
end


function Priest:RegisterSpellTracking()
    local SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
        SpellTrackingManager:RegisterPeriodicDamage({ 34914 }, { tickTime = 3, lastTickTime = nil })
    SpellTrackingManager:RegisterPeriodicDamage({ 589 }, { tickTime = 3, lastTickTime = nil })
    SpellTrackingManager:RegisterPeriodicDamage({ 2944 }, { tickTime = 1, lastTickTime = nil })
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
