local _, ns = ...
local UnitExists = _G.UnitExists
local UnitCanAttack = _G.UnitCanAttack
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version

local defaults = ns.InitializeClassDefaults()

-- MoP Druid spec spell locations
defaults.class.specSpellLocations = {
    [1] = { -- Balance
        -- ABOVE spells
        [24858] = NAG.SPELL_POSITIONS.ABOVE,    -- Moonkin Form
        [22812] = NAG.SPELL_POSITIONS.ABOVE,    -- (unknown spell)

        -- BELOW spells
        [48505] = NAG.SPELL_POSITIONS.LEFT,    -- Starfall
        [88751] = NAG.SPELL_POSITIONS.BELOW,    -- Wild Mushroom: Detonate

        -- RIGHT spells
        -- (empty)

        -- LEFT spells
        [26297] = NAG.SPELL_POSITIONS.LEFT,     -- Berserking
        [112071] = NAG.SPELL_POSITIONS.LEFT,    -- Celestial Alignment
        [102560] = NAG.SPELL_POSITIONS.LEFT,    -- Incarnation: Chosen of Elune
        [106737] = NAG.SPELL_POSITIONS.LEFT,    -- Force of Nature
        [126734] = NAG.SPELL_POSITIONS.LEFT,    -- Synapse Springs
        [132158] = NAG.SPELL_POSITIONS.LEFT,    -- Nature's Swiftness
        [37846] = NAG.SPELL_POSITIONS.LEFT,     -- (unknown spell)
        [108288] = NAG.SPELL_POSITIONS.LEFT,    -- Heart of the Wild
        [61336] = NAG.SPELL_POSITIONS.LEFT,     -- (unknown spell)
        [106922] = NAG.SPELL_POSITIONS.LEFT,    -- (unknown spell)
        [124974] = NAG.SPELL_POSITIONS.LEFT,    -- Nature's Vigil

        -- AOE spells
        [16914] = NAG.SPELL_POSITIONS.AOE       -- Hurricane
    },
    [2] = { -- Feral
        -- ABOVE spells
        [49376] = NAG.SPELL_POSITIONS.ABOVE,   -- (unknown spell)
        [768] = NAG.SPELL_POSITIONS.ABOVE,      -- Cat Form
        [5487] = NAG.SPELL_POSITIONS.ABOVE,     -- Bear Form
        [106737] = NAG.SPELL_POSITIONS.ABOVE,   -- Force of Nature
        [37846] = NAG.SPELL_POSITIONS.ABOVE,    -- (unknown spell)
        [22812] = NAG.SPELL_POSITIONS.ABOVE,    -- (unknown spell)

        -- BELOW spells
        -- (empty)

        -- RIGHT spells
        [62078] = NAG.SPELL_POSITIONS.RIGHT,    -- Swipe
        [77758] = NAG.SPELL_POSITIONS.RIGHT,    -- Thrash
        [779] = NAG.SPELL_POSITIONS.RIGHT,      -- Swipe

        -- LEFT spells
        [5217] = NAG.SPELL_POSITIONS.LEFT,      -- Tiger's Fury
        [50334] = NAG.SPELL_POSITIONS.LEFT,     -- Berserk
        [5229] = NAG.SPELL_POSITIONS.LEFT,      -- (unknown spell)
        [26297] = NAG.SPELL_POSITIONS.LEFT,     -- Berserking
        [106731] = NAG.SPELL_POSITIONS.LEFT,    -- Incarnation
        [102543] = NAG.SPELL_POSITIONS.LEFT,    -- (unknown spell)
        [108288] = NAG.SPELL_POSITIONS.LEFT,    -- Heart of the Wild
        [61336] = NAG.SPELL_POSITIONS.LEFT,     -- (unknown spell)
        [106922] = NAG.SPELL_POSITIONS.LEFT,    -- (unknown spell)

        -- AOE spells
        -- (empty)
    },
    [3] = { -- Guardian
        -- ABOVE spells
        [49376] = NAG.SPELL_POSITIONS.ABOVE,   -- (unknown spell)
        [768] = NAG.SPELL_POSITIONS.ABOVE,      -- Cat Form
        [5487] = NAG.SPELL_POSITIONS.ABOVE,     -- Bear Form
        [106737] = NAG.SPELL_POSITIONS.ABOVE,   -- Force of Nature
        [37846] = NAG.SPELL_POSITIONS.ABOVE,    -- (unknown spell)
        [22812] = NAG.SPELL_POSITIONS.ABOVE,    -- (unknown spell)

        -- BELOW spells
        -- (empty)

        -- RIGHT spells
        [62078] = NAG.SPELL_POSITIONS.RIGHT,    -- Swipe
        [77758] = NAG.SPELL_POSITIONS.RIGHT,    -- Thrash
        [779] = NAG.SPELL_POSITIONS.RIGHT,      -- Swipe

        -- LEFT spells
        [5217] = NAG.SPELL_POSITIONS.LEFT,      -- Tiger's Fury
        [50334] = NAG.SPELL_POSITIONS.LEFT,     -- Berserk
        [5229] = NAG.SPELL_POSITIONS.LEFT,      -- (unknown spell)
        [26297] = NAG.SPELL_POSITIONS.LEFT,     -- Berserking
        [106731] = NAG.SPELL_POSITIONS.LEFT,    -- Incarnation
        [102543] = NAG.SPELL_POSITIONS.LEFT,    -- (unknown spell)
        [102558] = NAG.SPELL_POSITIONS.LEFT,    -- (unknown spell)
        [108288] = NAG.SPELL_POSITIONS.LEFT,    -- Heart of the Wild
        [61336] = NAG.SPELL_POSITIONS.LEFT,     -- (unknown spell)
        [106922] = NAG.SPELL_POSITIONS.LEFT,    -- (unknown spell)

        -- AOE spells
        -- (empty)
    },
    [4] = { -- Restoration
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
    }
}

-- Self-heal when low health (generic rotation)
defaults.class.recommendSelfHeal = true
defaults.class.selfHealThreshold = 0.35

-- Class assignments for raid coordination
defaults.class.classAssignments = {
    {
        id = "faerie_fire",
        name = "Faerie Fire",
        description = "Apply armor reduction debuff on targets (coordinate with Warriors using Sunder in older expansions)",
        spellIds = {770, 102355}, -- Faerie Fire, Faerie Swarm
        category = "debuff",
    },
    {
        id = "mark_of_the_wild",
        name = "Mark of the Wild",
        description = "Provide raid-wide stats buff (coordinate with other Druids)",
        spellIds = {1126}, -- Mark of the Wild
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

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
-- Leave below as is

if UnitClassBase('player') ~= "DRUID" then return end

-- Generic (0 spec / no spec selected): low-level abilities before choosing a spec
local genericRotation = {
    name = "Generic",
    specIndex = 0,
    class = "DRUID",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    rotationString = [[
    (NAG:GetClassSetting('recommendSelfHeal', true) and (NAG:CurrentHealthPercent() < (NAG:GetClassSetting('selfHealThreshold', 0.35) or 0.35)) and NAG:SpellCanCast(5185)) and NAG:Cast(5185)
    or (not NAG:AuraIsActive(1126)) and NAG:SpellCanCast(1126) and NAG:Cast(1126)
    or (not NAG:AuraIsActive(467)) and NAG:SpellCanCast(467) and NAG:Cast(467)
    or (NAG:SpellCanCast(8921) and (not NAG:DotIsActive(8921, "target"))) and NAG:Cast(8921)
    or (NAG:SpellCanCast(5176)) and NAG:Cast(5176)
]],
}

-- START OF GENERATED_ROTATIONS

local balanceJIWRotation = {
    -- Core identification
    name = "Druid Balance",
    specIndex = 1,
    class = "DRUID",

    -- Required parameters
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { time = -10, action = "NAG:Cast(88747)" },
        { time = -8.5, action = "NAG:Cast(88747)" },
        { time = -7.0, action = "NAG:Cast(88747)" },
        { time = -6.0, condition = "NAG:SpellIsKnown(145152)", action = "NAG:Cast(5185)" },
        { time = -4.5, condition = "NAG:SpellIsKnown(145152)", action = "NAG:Cast(132158)" },
        { time = -2.6, action = "NAG:Cast(76093)" },
        { time = -1.9, action = "NAG:Cast(5176)" },
        { time = -1, action = "NAG:Cast(48505)" }
    },
    rotationString = [[
    -- OUT OF COMBAT PREPARATION: Cancel Astral Communion if in target range (-40 to -60) with moon direction
    ( (not NAG:InCombat()) and (NAG:CurrentGenericResource() >= -60 and NAG:CurrentGenericResource() <= -40) and (NAG:DruidGetEclipseDirection() ~= "sun") and NAG:AuraIsActive(127663) ) and NAG:CancelAstralCommunion()

    -- OUT OF COMBAT PREPARATION: Astral Communion (position at -40 to -60 energy, heading toward moon)
    or ((not NAG:InCombat()) and ( ((NAG:CurrentGenericResource() < -60 or NAG:CurrentGenericResource() > -40) or (NAG:DruidGetEclipseDirection() == "sun")))) and NAG:GuideAstralCommunion()

    or ((not NAG:InCombat()) and ( ((NAG:CurrentGenericResource() < -60 or NAG:CurrentGenericResource() > -40) or (NAG:DruidGetEclipseDirection() == "sun"))))  and NAG:Cast(127663)

    -- OUT OF COMBAT: Wild Mushroom (show while OOC and target is attackable OR prepull active, only if mushrooms not already active)
    or ( (not NAG:InCombat()) and ( (NAG:UnitExists("target") and NAG:UnitCanAttack("player", "target")) or NAG:PrepullActive() ) and (NAG:TotemRemainingTime(3) <= 180) ) and NAG:Cast(88747)

    -- Moonkin Form (show if buff not active, any time OOC or in combat)
    or (not NAG:AuraIsActive(24858)) and NAG:Cast(24858, nil, NAG.SPELL_POSITIONS.BELOW)

    -- OUT OF COMBAT: Dream of Cenarius preparation - cast Healing Touch to get DoC proc
    or ( (not NAG:InCombat()) and NAG:SpellIsKnown(145152) and (not NAG:AuraIsActive(145151)) and (not NAG:AuraIsActive(132158)) ) and NAG:Cast(5185)

    -- OUT OF COMBAT: Dream of Cenarius preparation - cast Nature's Swiftness after DoC proc
    or ( (not NAG:InCombat()) and NAG:SpellIsKnown(145152) and NAG:AuraIsActive(145151) and (not NAG:AuraIsActive(132158)) ) and NAG:Cast(132158, nil, NAG.SPELL_POSITIONS.PRIMARY)

    -- OUT OF COMBAT: cast sequence - Wrath then Starfall
    or ((not NAG:InCombat())) and NAG:StrictSequence('Wrath_Starfall', nil, 5176, 48505)

    or (NAG:CurrentLunarEnergy() == 100) and NAG:AutocastOtherCooldowns()

    or (NAG:AuraIsActive(112071) or (not NAG:SpellIsReady(112071))) and NAG:Cast(126734)

    or (NAG:AuraIsActive(112071)) and NAG:Cast(26297)

    or (NAG:AuraIsActive(102560) or NAG:AuraIsActive(112071)) and NAG:Cast(76093)
    or ((NAG:SpellTimeToReady(102560) >= 55) or NAG:AuraIsActive(102560)) and NAG:SpellIsKnown(145152) and NAG:Cast(132158, nil, NAG.SPELL_POSITIONS.LEFT)

    or (NAG:SpellIsKnown(145152) and ((NAG:AuraIsKnown(145151) and (not NAG:AuraIsActive(145151)) and (not NAG:AuraIsActive(112071)) and (not NAG:SpellIsReady(78674)) and (NAG:DotLowestRemainingTime(8921) > 3) and (NAG:DotLowestRemainingTime(93402) > 3)) or ((NAG:NumberTargets() >= 4) and (NAG:AuraRemainingTime(102560) <= 18) and NAG:AuraIsActive(102560) and (not NAG:AuraIsActive(145151)) and (not NAG:AuraIsActive(112071))))) and NAG:Cast(5185)

    or NAG:SpellIsKnown(102560) and NAG:InEncounter() and (NAG:CurrentTime() < 10.0) and (NAG:CurrentEncounterId() ~= 1498) and ((NAG:CurrentLunarEnergy() >= 100) and NAG:AuraIsActive(48518)) and NAG:Cast(102560, nil, NAG.SPELL_POSITIONS.PRIMARY)
    or NAG:SpellIsKnown(102560) and ((NAG:CurrentLunarEnergy() >= 100) and NAG:AuraIsActive(48518)) and NAG:Cast(102560)

        -- CA: open when Nature's Grace (112071) isnt up AND either:

        -- (a) we know Incarnation and are near an eclipse end, or

        -- (b) we don't have Incarnation and we're neutral

        or ( (not NAG:AuraIsActive(112071)) and

          (

            ( NAG:SpellIsKnown(102560) and NAG:AuraIsActive(102560) and (NAG:CurrentGenericResource() >= 0) ) or

            ( not NAG:SpellIsKnown(102560) and (NAG:DruidCurrentEclipsePhase() == "NeutralPhase") )

          )

        ) and NAG:Cast(112071)
    or (NAG:SpellIsKnown(106737) and (NAG:AuraRemainingTime(16886) >= 10.0)) and NAG:Cast(106737)
    or ( NAG:SpellIsKnown(124974) and ( NAG:AuraIsActive(106731) or (NAG:SpellTimeToReady(106731) >= 60) or (not NAG:SpellIsKnown(106731)) )) and NAG:Cast(124974)
    or ((not NAG:AuraIsActive(48518, "player", false)) and (not NAG:AuraIsActive(48517, "player", false)) and NAG:AuraIsActive(145138, "player", true) and (NAG:CurrentSolarEnergy() < 40) and (NAG:CurrentLunarEnergy() < 50) and NAG:AuraIsKnown(145138)) and NAG:Cast(127663)
    or (NAG:SpellIsReady(78674) and NAG:NumberTargets() > 1) and NAG:Cast(78674)

    or ((NAG:DotIsActive(8921) and (NAG:DotRemainingTime(8921) > 6) and (NAG:DotPercentIncrease(8921) >= 0.75)) or (NAG:DotIsActive(8921) and (NAG:DotRemainingTime(8921) <= 6) and (NAG:DotPercentIncrease(8921) >= 0.5))) and NAG:Cast(8921)
    or ((NAG:DotIsActive(93402) and (NAG:DotRemainingTime(93402) > 6) and (NAG:DotPercentIncrease(93402) >= 0.75)) or (NAG:DotIsActive(93402) and (NAG:DotRemainingTime(93402) <= 6) and (NAG:DotPercentIncrease(93402) >= 0.5))) and NAG:Cast(93402)

    or ((((not NAG:DotIsActive(8921)) or (NAG:DotIsActive(8921) and (NAG:DotRemainingTime(8921) < NAG:DotTickFrequency(8921)))) and (NAG:AuraIsActive(48518, "player", false) or NAG:AuraIsActive(16886, "player", false) or ((not NAG:AuraIsActive(48518, "player", false)) and (not NAG:AuraIsActive(48517, "player", false)) and (NAG:CurrentSolarEnergy() < 60) and (NAG:CurrentLunarEnergy() < 70)))) or ((((NAG:AuraRemainingTime(112071) >= 13.0) and (NAG:DotLowestRemainingTime(8921) <= 12)) or ((NAG:AuraRemainingTime(112071) <= 1.0) and (NAG:DotRemainingTime(8921) < 6))) and NAG:AuraIsActive(112071, "player", false)) or ((NAG:AuraRemainingTime(16886) < 1.5) and NAG:AuraIsActive(48518, "player", false) and (NAG:DotRemainingTime(8921) < 6) and ((NAG:SpellIsKnown(102560) and (not NAG:AuraIsActive(102560, "player", false))) or ((not NAG:SpellIsKnown(102560)) and (not NAG:SpellIsReady(112071))))) or (NAG:AuraIsActive(48518, "player", false) and (NAG:CurrentLunarEnergy() == 20) and (NAG:DotRemainingTime(8921) < 6))) and NAG:Cast(8921)
    or ((((not NAG:DotIsActiveOnAllTargets(8921)) or (NAG:DotIsActiveOnAllTargets(8921) and (NAG:DotLowestRemainingTime(8921) < NAG:DotTickFrequency(8921)))) and (NAG:AuraIsActive(48518, "player", false) or NAG:AuraIsActive(16886, "player", false) or ((not NAG:AuraIsActive(48518, "player", false)) and (not NAG:AuraIsActive(48517, "player", false)) and (NAG:CurrentSolarEnergy() < 60) and (NAG:CurrentLunarEnergy() < 70)))) or ((((NAG:AuraRemainingTime(112071) >= 13.0) and (NAG:DotLowestRemainingTime(8921) <= 12)) or ((NAG:AuraRemainingTime(112071) <= 1.0) and (NAG:DotLowestRemainingTime(8921) < 6))) and NAG:AuraIsActive(112071, "player", false)) or ((NAG:AuraRemainingTime(16886) < 1.5) and NAG:AuraIsActive(48518, "player", false) and (NAG:DotLowestRemainingTime(8921) < 6) and ((NAG:SpellIsKnown(102560) and (not NAG:AuraIsActive(102560, "player", false))) or ((not NAG:SpellIsKnown(102560)) and (not NAG:SpellIsReady(112071))))) or (NAG:AuraIsActive(48518, "player", false) and (NAG:CurrentLunarEnergy() == 20) and (NAG:DotLowestRemainingTime(8921) < 6))) and NAG:DotIsActive(8921) and NAG:ShouldMultidot(8921, 6, 6.0) and NAG:Cast(8921, nil, NAG.SPELL_POSITIONS.RIGHT)
    or ((((not NAG:DotIsActive(93402)) or (NAG:DotIsActive(93402) and (NAG:DotRemainingTime(93402) < NAG:DotTickFrequency(93402)))) and (NAG:AuraIsActive(48517, "player", false) or NAG:AuraIsActive(16886, "player", false) or ((not NAG:AuraIsActive(48518, "player", false)) and (not NAG:AuraIsActive(48517, "player", false)) and (NAG:CurrentSolarEnergy() <= 59) and (NAG:CurrentLunarEnergy() <= 69)))) or ((NAG:AuraRemainingTime(16886) < 1.5) and NAG:AuraIsActive(48517, "player", false) and (NAG:DotRemainingTime(93402) < 6)) or (NAG:AuraIsActive(48517, "player", false) and (NAG:CurrentSolarEnergy() <= 15) and (NAG:DotRemainingTime(93402) < 6))) and NAG:Cast(93402)
    or ((((not NAG:DotIsActiveOnAllTargets(93402)) or (NAG:DotIsActiveOnAllTargets(93402) and (NAG:DotLowestRemainingTime(93402) < NAG:DotTickFrequency(93402)))) and (NAG:AuraIsActive(48517, "player", false) or NAG:AuraIsActive(16886, "player", false) or ((not NAG:AuraIsActive(48518, "player", false)) and (not NAG:AuraIsActive(48517, "player", false)) and (NAG:CurrentSolarEnergy() <= 59) and (NAG:CurrentLunarEnergy() <= 69)))) or ((NAG:AuraRemainingTime(16886) < 1.5) and NAG:AuraIsActive(48517, "player", false) and (NAG:DotLowestRemainingTime(93402) < 6)) or (NAG:AuraIsActive(48517, "player", false) and (NAG:CurrentSolarEnergy() <= 15) and (NAG:DotLowestRemainingTime(93402) < 6))) and NAG:DotIsActive(93402) and NAG:ShouldMultidot(93402, 6, 6.0) and NAG:Cast(93402, nil, NAG.SPELL_POSITIONS.RIGHT)


    or  (not(NAG:AuraIsActive(48505)) and NAG:SpellIsReady(48505)) and (((NAG:CurrentLunarEnergy() >= 60) or NAG:AuraIsActive(48518, "player", false)) and ((NAG:AuraIsKnown(102560) and ((NAG:SpellTimeToReady(102560) >= 35) or (NAG:SpellTimeToReady(102560) <= 1))) or (not NAG:AuraIsKnown(102560)))) and NAG:Cast(48505)
    or (NAG:AuraIsActive(48517, "player", false) and (NAG:TotemRemainingTime(1) >= 10)) and NAG:Cast(88751)
    or ((NAG:AuraIsActive(48518, "player", false) or (NAG:AuraIsActive(48517, "player", false) and (NAG:CurrentSolarEnergy() ~= 20)) or ((not NAG:AuraIsActive(48518, "player", false)) and (not NAG:AuraIsActive(48517, "player", false)) and (NAG:CurrentSolarEnergy() < 60) and (NAG:CurrentLunarEnergy() < 70))) and (not NAG:AuraIsActive(93400, "player", false))) and NAG:Cast(78674)
    or ((NAG:AuraIsActive(48518, "player", false) or (NAG:AuraIsActive(48517, "player", false) and (NAG:CurrentSolarEnergy() ~= 20)) or ((not NAG:AuraIsActive(48518, "player", false)) and (not NAG:AuraIsActive(48517, "player", false)) and (NAG:CurrentSolarEnergy() < 60) and (NAG:CurrentLunarEnergy() < 70))) and NAG:AuraIsActive(93400, "player", true)) and NAG:Cast(78674)
    --if (Starfall not active) and (Starfall isn't on CD) then Starfall
    or (not(NAG:AuraIsActive(48505)) and NAG:SpellIsReady(48505)) and NAG:Cast(48505)
    or ( NAG:DruidCurrentEclipsePhase() == "SolarPhase" ) and NAG:Cast(2912)
    or NAG:Cast(5176)
    ]],

    -- New action-based format

    -- Tracked IDs for optimization
    spells = {2912, 5176, 5185, 8921, 16886, 16914, 24858, 26297, 48505, 48517, 48518, 76093, 78674, 88747, 88751, 93400, 93402, 102560, 106737, 112071, 124974, 126734, 127663, 132158, 145138, 145151, 145152},
    items = {76093},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {40914, 40906, 40909},
    lastModified = "11/05/2025",
    author = "Fonsas and Alataria",

}

local feralMilkshakeRotation = {
    -- Core identification
    name = "Feral",
    specIndex = 2,
    class = "DRUID",

    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { time = -1.5, action = "NAG:Cast(NAG:GetBattlePotion())" }
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
or NAG:CurrentEnergy() < 30 and NAG:DotRemainingTime(1822) >= 4.0 and NAG:DotRemainingTime(77758) <= 3.0 and NAG:AuraRemainingTime(127538) > 10 and (not NAG:AuraIsActive(5217)) and(not NAG:AuraIsActive(106951)) and (not NAG:SpellIsReady(5217)) and NAG:Cast(5487) -- Bearweawing
or ((not NAG:AuraIsActive(5487) or (NAG:CurrentEnergy() >= 75 or (NAG:CurrentEnergy() >= 35 and NAG:CurrentComboPoints() == 5 and (not NAG:DotIsActive(1079) )))) and (not NAG:AuraIsActive(768)) and (not NAG:AuraIsActive(108292))) and NAG:Cast(768) -- Cat Form
or NAG:AuraIsActive(5487) and NAG:Cast(77758, nil,NAG.SPELL_POSITIONS.PRIMARY) -- Trash
or NAG:AuraIsActive(5487) and NAG:AuraIsActive(135700) and NAG:DotIsActive(77758) and NAG:Cast(768) -- Cat from when CC proc in Bearweawing
or (NAG:AuraIsActive(5487) and (not NAG:AuraIsActive(135700))) and NAG:Cast(6807) -- Maul
or NAG:AuraIsActive(5487) and NAG:Cast(33878) -- mangle
or NAG:Cast(124974) -- Nature Vigils
or (NAG:CurrentTime() == 0 or NAG:DotRemainingTime(113746) <= 3.0 ) and NAG:Cast(770) -- Faerie Fire
or NAG:AuraIsKnown(108373) and NAG:CurrentComboPoints() == 5 and NAG:AuraIsActive(69369) and NAG:Cast(5185) -- healing touch to prevent wasting Predatory strikes
or NAG:AuraRemainingTime(127538) < 3 and NAG:Cast(127538) -- Savage Roar
or NAG:SpellTimeToCharge(102703) == 0  and NAG:TimeToReady(5217) > 16 and NAG:CastWithOverlay(106737,"Cast 1 Charge") -- Force of Nature
or NAG:AuraIsActive(5217) and NAG:CastWithOverlay(106737,"Spam All Charges") -- Force of Nature
or (((NAG:CurrentEnergy() < 35) and (NAG:CurrentTime() < 10.0)) or ((NAG:CurrentTime() < 10.0) and (NAG:CurrentComboPoints() == 5) and NAG:AuraIsActive(145152))) and NAG:Cast(5217) -- Openers Tigers Furry
or NAG:CurrentEnergy() < 35 and NAG:AuraIsActive(768) and (NAG:CurrentComboPoints() >= 3 or NAG:DotRemainingTime(1079) >= 3.0 )and NAG:Cast(5217) -- Tigers Furry
or NAG:AuraIsActive(5217) and NAG:Cast(126734) -- Synapse Springs
or NAG:AuraIsActive(5217) and NAG:Cast(106951, nil,NAG.SPELL_POSITIONS.LEFT) -- Berserk
or NAG:AuraIsActive(106951) and NAG:Cast(106731) -- Incarnation
or (NAG:AuraIsActive(69369) and NAG:AuraRemainingTime(69369) <= 2) and NAG:Cast(5185) -- Last 2 Second Healing Touch
or NAG:AuraIsActive(135700) and NAG:DotRemainingTime(106830) <= 3.0 and NAG:DotIsActive(106830) and NAG:Cast(106830) -- Trash while CC
or NAG:AuraIsActive(132158) and NAG:Cast(5185) -- nature swiftness  to healing touch
or NAG:NumberTargets(5) > 3 and NAG:AuraRemainingTime(127538) > 3 and NAG:DotPercentIncrease(106830) >= 0.00 and (NAG:DotRemainingTime(106830) <= 3.0 or NAG:DotPercentIncrease(106830) >= 0.15 )and NAG:Cast(106830, nil,NAG.SPELL_POSITIONS.RIGHT) --Trash AOE
or NAG:CurrentComboPoints() < 5 and (NAG:NumberTargets(5) > 3) and NAG:DotIsActive(106830) and NAG:Cast(62078, nil,NAG.SPELL_POSITIONS.RIGHT) -- Swipe AOE
or NAG:AuraIsKnown(108373) and (not NAG:AuraIsActive(132158)) and (not NAG:AuraIsActive(145152)) and NAG:DotPercentIncrease(1079) > -0.28 and NAG:CurrentComboPoints() == 5 and NAG:DotRemainingTime(1079) <= 4.0 and NAG:AuraRemainingTime(127538) > 3 and NAG:Cast(132158)
or NAG:AuraIsKnown(108373) and (not NAG:AuraIsActive(145152)) and NAG:AuraIsActive(69369) and NAG:DotPercentIncrease(1079) > -0.28 and NAG:CurrentComboPoints() >= 4 and (NAG:DotRemainingTime(1079) <= 2.0 or NAG:DotPercentIncrease(1079) >= -0.26 ) and NAG:AuraRemainingTime(127538) > 3 and NAG:CastWithOverlay(5185, string.format("+%d%%", NAG:DotPercentIncrease(1079) * 100 + 30)) -- healing touch to amp Rip
or NAG:CurrentComboPoints() == 5 and (NAG:DotRemainingTime(1079) <= 2.0 or NAG:DotPercentIncrease(1079) >= 0.04 ) and NAG:DotPercentIncrease(1079) >= 0.00 and NAG:AuraRemainingTime(127538) > 3 and NAG:CastWithOverlay(1079, string.format("+%d%%", NAG:DotPercentIncrease(1079) * 100 )) -- Rip
or NAG:AuraIsKnown(108373) and (not NAG:AuraIsActive(145152)) and NAG:AuraIsActive(69369) and NAG:DotPercentIncrease(106830) > -0.28 and NAG:DotRemainingTime(106830) <= 3.0 and NAG:AuraRemainingTime(127538) > 3 and NAG:DotRemainingTime(1079) >= 4.0 and NAG:CurrentComboPoints() == 5 and NAG:DotRemainingTime(1822) >= 4.0 and NAG:Cast(5185) -- healing touch to amp Trash
or NAG:DotRemainingTime(106830) <= 3.0 and NAG:DotRemainingTime(1079) >= 4.0 and NAG:DotPercentIncrease(106830) >= 0.00 and NAG:DotRemainingTime(1822) >= 4.0 and NAG:AuraRemainingTime(127538) > 3 and NAG:CurrentComboPoints() == 5 and NAG:Cast(106830) -- Trash
or ((NAG:CurrentComboPoints() == 5 and NAG:DotRemainingTime(1079) >= 6.0 ) or (NAG:DotIsActive(1079) and NAG:IsExecutePhase(25) and ((NAG:DotRemainingTime(1079) <= 1.5) or NAG:CurrentComboPoints() == 5))) and NAG:AuraRemainingTime(127538) >= 6  and NAG:Cast(22568) -- Ferocious Bite
or NAG:AuraIsKnown(108373) and (not NAG:AuraIsActive(145152)) and NAG:AuraIsActive(69369) and NAG:DotPercentIncrease(1822) > -0.28 and NAG:CurrentComboPoints() < 5 and (NAG:DotRemainingTime(1822) <= 3.0 or NAG:DotPercentIncrease(1822) >= -0.26 ) and NAG:AuraRemainingTime(127538) > 3 and NAG:CastWithOverlay(5185, string.format("+%d%%", NAG:DotPercentIncrease(1822) * 100 + 30)) -- healing touch to amp Rake
or NAG:CurrentComboPoints() < 5 and (NAG:DotRemainingTime(1822) <= 3.0 or NAG:DotPercentIncrease(1822) >= 0.04 ) and NAG:DotPercentIncrease(1822) >= 0.00 and NAG:AuraRemainingTime(127538) > 3 and NAG:CastWithOverlay(1822, string.format("+%d%%", NAG:DotPercentIncrease(1822) * 100 )) -- Rake
or (not NAG:AuraIsActive(5487)) and NAG:CurrentComboPoints() < 5 and (NAG:AuraIsActive(106951) or NAG:AuraIsActive(135700)) and NAG:Cast(5221) -- Shred
or (not NAG:AuraIsActive(5487)) and (NAG:CurrentComboPoints() < 5 or NAG:CurrentEnergy() >= 95 ) and NAG:Cast(33876) -- Mangle with emergency spender

-- TODO:
-- Add Opener
-- Tune UP AOE

    ]],

    -- Tracked IDs for optimization
    spells = {768, 770, 1079, 1822, 33745, 33876, 33878, 5176, 5185, 5217, 52610, 5487, 6807, 69369, 106830, 106737, 106951, 106952, 108292, 127538, 132158, 135700, 145152, 145211},
    items = {},
    author = "Horalius",
}



local guardianRotation = {
        -- Core identification
        name = "Guardian",
        specIndex = 3,
        class = "DRUID",

        -- Required parameters
        default = true,
        enabled = true,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        prePull = {
            { time = -1.5, action = "NAG:Cast(NAG:GetBattlePotion())" }
        },
        rotationString = [[
-- Barkskin: when HP < 30%
(NAG:CurrentHealthPercent() < 0.3
    and NAG:SpellTimeToReady(22812) <= 0
    and NAG:AuraIsActive(5487)) and
    NAG:Cast(22812)

-- Heart of the Wild: cast Wrath
or (NAG:AuraIsActive(108291))
and NAG:Cast(5176)

-- Heart of the Wild ended: switch back to Bear Form
or (not NAG:AuraIsActive(108291)
    and not NAG:AuraIsActive(5487))
and NAG:Cast(5487)

-- Healing Touch: if Dream of Cenarius Buff active and HP < 90%
or (NAG:AuraIsActive(145151)
    and NAG:CurrentHealthPercent() < 0.9
    and NAG:AuraIsActive(5487))
and NAG:Cast(5185)

-- Synapse Springs (Gloves): use if fight will last > 10s
or (NAG:SpellTimeToReady(82170) <= 0
    and NAG:RemainingTime() > 10
    and NAG:AuraIsActive(5487))
and NAG:Cast(82170)

-- Survival Instincts: when HP <= 15%
or (NAG:CurrentHealthPercent() <= 0.15
    and NAG:SpellTimeToReady(61336) <= 0
    and NAG:AuraIsActive(5487)) and
    NAG:Cast(61336)

-- Ursocs Might: when HP <= 10%
or (NAG:CurrentHealthPercent() <= 0.1
    and NAG:SpellTimeToReady(106922) <= 0
    and NAG:AuraIsActive(5487)) and
    NAG:Cast(106922)

-- Enrage: if Rage < 50
or (NAG:SpellTimeToReady(5229) <= 0
    and NAG:CurrentRage() < 50
    and NAG:AuraIsActive(5487)) and
    NAG:Cast(5229)

-- Savage Defense: if HP <= 90% and not active
or (NAG:AuraIsActive(5487)
    and NAG:CurrentHealthPercent() <= 0.9
    and not NAG:AuraIsActive(132402)) and
    NAG:Cast(62606)

-- Maul: < 2 targets (rage 80+ OR clearcast OR rage 60+ and Tooth and Claw)
or ((NAG:NumberTargets() < 2)
    and (
        NAG:CurrentRage() >= 80
        or NAG:AuraIsActive(16870)
        or (NAG:CurrentRage() >= 60 and NAG:AuraIsActive(135286))
    )
    and NAG:AuraIsActive(5487)) and
    NAG:Cast(6807)

-- Maul: >= 2 targets (clearcast OR rage 60+ and Tooth and Claw)
or ((NAG:NumberTargets() >= 2)
    and (
        NAG:AuraIsActive(16870)
        or (NAG:CurrentRage() >= 60 and NAG:AuraIsActive(135286))
    )
    and NAG:AuraIsActive(5487)) and
    NAG:Cast(6807)

-- Swipe: > 2 targets OR fallback if other abilities unavailable
or (
    (NAG:NumberTargets() > 2
        and NAG:SpellTimeToReady(779) <= 0
        and NAG:AuraIsActive(5487))
    or (
        NAG:NumberTargets() <= 2
        and NAG:SpellTimeToReady(33878) > 1
        and NAG:DotRemainingTime(33745) >= 3
        and NAG:DotRemainingTime(77758) >= 3
        and NAG:AuraIsActive(5487))
)
and NAG:Cast(779)

-- Thrash: >= 2 targets if debuff not active
or ((NAG:NumberTargets() >= 2)
    and NAG:AuraIsActive(5487)
    and not NAG:AuraIsActive(54758)) and
    NAG:Cast(77758)

-- Thrash: < 2 targets if debuff not active
or ((NAG:NumberTargets() < 2)
    and not NAG:DotIsActive(77758)
    and NAG:AuraIsActive(5487)) and
    NAG:Cast(77758)

-- Mangle: only if no cooldown
or (NAG:SpellTimeToReady(33878) <= 0
    and NAG:AuraIsActive(5487)) and
    NAG:Cast(33878)

-- Berserk: use on cooldown
or (NAG:SpellTimeToReady(50334) <= 0
    and NAG:AuraIsActive(5487)) and
    NAG:Cast(50334)

-- Lacerate: keep 3 stacks if < 3 targets
or (((NAG:DotNumStacks(33745) < 3)
     or (NAG:DotNumStacks(33745) == 3 and NAG:DotRemainingTime(33745) < 2.0))
    and NAG:NumberTargets() < 3
    and NAG:AuraIsActive(5487)) and
    NAG:Cast(33745)

-- Faerie Fire
or (
    NAG:AuraIsActive(5487)
    and NAG:NumberTargets() < 3
    and NAG:SpellTimeToReady(770) <= 0
) and
NAG:Cast(770)

        ]],


        -- Tracked IDs for optimization
        spells = {770, 774, 5185, 5229, 6807, 22812, 22842, 31821, 33745, 33878, 61336, 62606, 77758, 102351, 102558, 106952, 108293, 113746, 114030, 115798, 132402, 145162},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {45603, 40897},
        lastModified = "08/18/2025",
        author = "@Milkshake",

    }


-- Restoration Healing Rotation (spec 4)
-- Mouseover-based healing: uses NAG.state.healing from HealingStateManager (MoP)
-- devOnly: visible only when Developer Mode is enabled
-- MoP Resto Druid key spells:
--   Rejuvenation (774), Lifebloom (33763), Wild Growth (48438), Swiftmend (18562),
--   Healing Touch (5185), Nourish (50464), Regrowth (8936), Wild Mushroom: Bloom (102791),
--   Tranquility (740), Nature's Swiftness (132158), Ironbark (102342), Remove Corruption (2782)
local restorationRotation = {
    name = "Restoration",
    specIndex = 4,
    description = "Mouseover healing: Rejuvenation, Lifebloom, Wild Growth, Swiftmend, Healing Touch.",
    class = "DRUID",
    default = true,
    enabled = true,
    devOnly = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    lastModified = "02/08/2026",
    rotationString = [[
-- Dispel: Remove Corruption on mouseover with dispellable debuff (Nature's Cure for Resto)
(NAG:MouseoverFriendlyExists() and NAG:MouseoverNeedsDispel()) and NAG:Cast(2782)

-- Lifebloom: maintain 3 stacks on tank (or mouseover tank)
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverIsTank()
    and (NAG:MouseoverBuffRemains(33763) < 3 or not NAG:MouseoverHasBuff(33763))) and NAG:Cast(33763)

-- Swiftmend on low mouseover (instant, strong)
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 60
    and NAG:SpellIsReady(18562)
    and (NAG:MouseoverHasBuff(774) or NAG:MouseoverHasBuff(8936))) and NAG:Cast(18562)

-- Nature's Swiftness + Healing Touch on critical target
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 30
    and NAG:SpellIsReady(132158)) and NAG:Cast(132158)

-- Wild Growth when 3+ need healing
or (NAG:LowHealthMemberCount(85) >= 3 and NAG:SpellIsReady(48438)) and NAG:Cast(48438)

-- Rejuvenation on mouseover (keep on tank, apply to injured)
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 90
    and (not NAG:MouseoverHasBuff(774))
    and (NAG:MouseoverIsTank() or NAG:MouseoverHealthPercent() < 80)) and NAG:Cast(774)

-- Regrowth on low mouseover (for Omen of Clarity procs or emergency)
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 50
    and (NAG:AuraIsActive(16870) or NAG:MouseoverHealthPercent() < 35)) and NAG:Cast(8936)

-- Healing Touch (efficient filler) on moderate mouseover
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 85) and NAG:Cast(5185)

-- Damage filler when nothing to heal: Wrath
or NAG:Cast(5176)
    ]],

    spells = {774, 2782, 5176, 5185, 8936, 16870, 18562, 33763, 48438, 102342, 132158},
    items = {},
    auras = {},
    runes = {},
    author = "Smufrik",
}

--- @class Druid : ClassBase
local Druid = NAG:CreateClassModule("DRUID", defaults)
if not Druid then return end

function Druid:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 0, genericRotation)  -- Generic (no spec)
    ns.AddRotationToDefaults(self.defaults, 1, balanceJIWRotation)  -- Balance
    ns.AddRotationToDefaults(self.defaults, 2, feralMilkshakeRotation)  -- Feral
    ns.AddRotationToDefaults(self.defaults, 3, guardianRotation)  -- Guardian
    ns.AddRotationToDefaults(self.defaults, 4, restorationRotation)  -- Restoration
end

function Druid:RegisterSpellTracking()
    --- @type SpellTrackingManager|AceModule|CoreModule
    local SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
        SpellTrackingManager:RegisterPeriodicDamage({ 5570 }, { tickTime = nil, lastTickTime = nil }) -- Insect Swarm
end

local BaseGetOptions = Druid.GetOptions
function Druid:GetOptions()
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

NAG.Class = Druid
