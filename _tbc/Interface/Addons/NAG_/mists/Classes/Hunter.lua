local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version

local defaults = ns.InitializeClassDefaults()

defaults.class.specSpellLocations = {
    [1] = { -- Beast Mastery
        -- ABOVE spells
        [3674] = NAG.SPELL_POSITIONS.ABOVE,   -- Black Arrow
        [82726] = NAG.SPELL_POSITIONS.ABOVE,   -- Fervor
        [13159] = NAG.SPELL_POSITIONS.ABOVE,   -- Aspect of the Pack
        [5118] = NAG.SPELL_POSITIONS.ABOVE,    -- Aspect of the Cheetah
        [109260] = NAG.SPELL_POSITIONS.ABOVE,  -- Aspect of the Iron Hawk
        [13165] = NAG.SPELL_POSITIONS.ABOVE,   -- Aspect of the Hawk

        -- RIGHT spells
        [13813] = NAG.SPELL_POSITIONS.RIGHT,   -- (unknown spell)
        [77769] = NAG.SPELL_POSITIONS.RIGHT,   -- (unknown spell)
        [120360] = NAG.SPELL_POSITIONS.RIGHT,   -- Barrage

        -- LEFT spells
        [3045] = NAG.SPELL_POSITIONS.LEFT,   -- Rapid Fire
        [96228] = NAG.SPELL_POSITIONS.LEFT,   -- (unknown spell)
        [121818] = NAG.SPELL_POSITIONS.LEFT,   -- Stampede
        [131894] = NAG.SPELL_POSITIONS.LEFT,   -- A Murder of Crows

        -- AOE spells
        [2643] = NAG.SPELL_POSITIONS.AOE,   -- Multi-Shot

    },
    [2] = { -- Marksmanship
        -- ABOVE spells
        [3674] = NAG.SPELL_POSITIONS.ABOVE,   -- Black Arrow
        [82726] = NAG.SPELL_POSITIONS.ABOVE,   -- Fervor
        [13159] = NAG.SPELL_POSITIONS.ABOVE,   -- Aspect of the Pack
        [5118] = NAG.SPELL_POSITIONS.ABOVE,    -- Aspect of the Cheetah
        [109260] = NAG.SPELL_POSITIONS.ABOVE,  -- Aspect of the Iron Hawk
        [13165] = NAG.SPELL_POSITIONS.ABOVE,   -- Aspect of the Hawk

        -- RIGHT spells
        [13813] = NAG.SPELL_POSITIONS.RIGHT,   -- EXPLOSIVE TRAP
        [77769] = NAG.SPELL_POSITIONS.RIGHT,   -- (unknown spell)
        [117050] = NAG.SPELL_POSITIONS.RIGHT,  -- Glaive Toss

        -- LEFT spells
        [3045] = NAG.SPELL_POSITIONS.LEFT,   -- Rapid Fire
        [96228] = NAG.SPELL_POSITIONS.LEFT,   -- (unknown spell)
        [121818] = NAG.SPELL_POSITIONS.LEFT,   -- Stampede
        [131894] = NAG.SPELL_POSITIONS.LEFT,   -- A Murder of Crows

        -- AOE spells
        [2643] = NAG.SPELL_POSITIONS.AOE,   -- Multi-Shot

    },
    [3] = { -- Survival
        -- ABOVE spells
        [82726] = NAG.SPELL_POSITIONS.ABOVE,    -- Fervor
        [3674] = NAG.SPELL_POSITIONS.ABOVE,     -- Black Arrow
        [13159] = NAG.SPELL_POSITIONS.ABOVE,   -- Aspect of the Pack
        [5118] = NAG.SPELL_POSITIONS.ABOVE,    -- Aspect of the Cheetah
        [109260] = NAG.SPELL_POSITIONS.ABOVE,  -- Aspect of the Iron Hawk
        [13165] = NAG.SPELL_POSITIONS.ABOVE,   -- Aspect of the Hawk

        -- BELOW spells
        -- (empty)

        -- RIGHT spells
        -- (empty)

        -- LEFT spells
        [3045] = NAG.SPELL_POSITIONS.LEFT,      -- Rapid Fire
        [131894] = NAG.SPELL_POSITIONS.LEFT,    -- A Murder of Crows
        [121818] = NAG.SPELL_POSITIONS.LEFT,    -- Stampede
        [96228] = NAG.SPELL_POSITIONS.LEFT,     -- (unknown spell)
        -- Note: NAG:GetBattlePotion() is a function call, not a spell ID
        -- This should be handled differently in the new format

        -- AOE spells
        [2643] = NAG.SPELL_POSITIONS.AOE        -- Multi-Shot
    },
}

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
-- Leave below as is

if UnitClassBase('player') ~= "HUNTER" then return end

-- Generic (0 spec / no spec selected): low-level abilities before choosing a spec
local genericRotation = {
    name = "Generic",
    specIndex = 0,
    class = "HUNTER",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    rotationString = [[
    (not NAG:AuraIsActive(13165)) and NAG:SpellCanCast(13165) and NAG:Cast(13165)
    or (NAG:SpellCanCast(1978) and (not NAG:DotIsActive(1978, "target"))) and NAG:Cast(1978)
    or (NAG:SpellCanCast(3044)) and NAG:Cast(3044)
]],
}

-- START OF GENERATED_ROTATIONS
local beastmasteryRotation = {
    -- Core identification
    name = "Hunter AOE/ST Beastmastery",
    specIndex = 1,
    class = "HUNTER",

    -- Required parameters
    default = false,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { time = -1.0, action = "NAG:Cast(76089)" },  -- Potion
        { time = -2.0, action = "NAG:Cast(13165)" },  -- Aspect of the Hawk
        { time = -3.0, action = "NAG:Cast(1130)" },   -- Hunter's Mark
        { time = -1.0, action = "NAG:Cast(117050)" }, -- Glaive Toss
        { time = -24.0, action = "NAG:Cast(13812)" }  -- Explosive Trap
    },
    lastModified = "11/20/2025",
    rotationString = [[
-- Aspects - Priority 0
(NAG:GetClassSetting('recommendAspects', true) and ((NAG:UnitIsMoving() and (not NAG:InCombat())) and ((NAG:GetNumGroupMembers() > 0 and NAG:SpellIsKnown(13159) and not NAG:AuraIsActive(13159) and NAG:Cast(13159, nil, NAG.SPELL_POSITIONS.ABOVE)) or (NAG:GetNumGroupMembers() == 0 and NAG:SpellIsKnown(5118) and not NAG:AuraIsActive(5118) and NAG:Cast(5118, nil, NAG.SPELL_POSITIONS.ABOVE))) or (not NAG:UnitIsMoving() or NAG:InCombat()) and ((NAG:SpellIsKnown(109260) and not NAG:AuraIsActive(109260) and not NAG:AuraIsActive(13165) and NAG:Cast(109260, nil, NAG.SPELL_POSITIONS.ABOVE)) or (not NAG:SpellIsKnown(109260) and NAG:SpellIsKnown(13165) and not NAG:AuraIsActive(13165) and not NAG:AuraIsActive(109260) and NAG:Cast(13165, nil, NAG.SPELL_POSITIONS.ABOVE)))))

-- AOE ROTATION (2+ targets) - Optimized based on wowsims
or (NAG:NumberTargets() > 1 and NAG:SpellIsReady(13812) and not(NAG:AuraIsActive(77769))) and NAG:Cast(77769) -- Explosive Trap debuff check
or (NAG:NumberTargets() > 1 and NAG:AuraIsActive(77769) and NAG:SpellIsReady(13812)) and NAG:Cast(13812)-- Explosive Trap
or (NAG:NumberTargets() > 1) and NAG:Cast(117050) -- Glaive Toss
or (NAG:NumberTargets() > 1) and NAG:Cast(120360) -- Barrage
or (NAG:NumberTargets() > 1) and NAG:Cast(109259) -- Powershot
or (NAG:NumberTargets() > 1) and NAG:Cast(2643) -- Multi-Shot

-- COOLDOWNS GROUP - Optimized sequencing from wowsims
or (NAG:CurrentTime() >= 1) and NAG:AutocastOtherCooldowns()

-- Bestial Wrath sequencing - Optimized from wowsims strictSequence logic
or ((NAG:AuraNumStacks(19623, "pet") == 5) and (NAG:AuraRemainingTime(82692) <= 4.0) and (not NAG:AuraIsActive(19574)) and (not (NAG:SpellTimeToReady(19574) <= 5))) and NAG:Cast(82692) -- Thrill of the Hunt at 5 stacks
or NAG:Cast(19574) -- Bestial Wrath
or (NAG:AuraIsActive(19574) and NAG:SpellIsReady(126734)) and NAG:Cast(126734) -- Stampede during Bestial Wrath
or (NAG:AuraIsActive(19574) and NAG:SpellIsReady(53401)) and NAG:Cast(53401) -- Readiness during Bestial Wrath
or (NAG:AuraIsActive(19574) and NAG:SpellIsReady(33697)) and NAG:Cast(33697) -- Bestial Wrath (pet) during Bestial Wrath

-- MAIN ROTATION
or NAG:Cast(53351) -- Kill Shot (execute phase)
or NAG:Cast(3045) -- Rapid Fire
or NAG:Cast(34026) -- Kill Command
or NAG:Cast(131894) -- A Murder of Crows
or (NAG:CurrentFocus() <= 37) and NAG:Cast(82726) -- Fervor (optimized threshold from wowsims)
or NAG:Cast(120697) -- Dire Beast
or NAG:Cast(109259) -- Powershot
or NAG:Cast(120679) -- Dire Beast (alternative)
or (NAG:SpellIsReady(1978) and NAG:AuraIsInactive(1978, "target")) and NAG:Cast(1978) -- Serpent Sting
or (NAG:AuraRemainingTime(1978, "target") <= 6.0) and (NAG:SpellIsKnown(77767) and NAG:Cast(77767) or NAG:Cast(56641)) -- Cobra Shot or Steady Shot (refresh Serpent Sting)
or NAG:Cast(117050) -- Glaive Toss
or (NAG:AuraIsActive(19574) and (NAG:CurrentFocus() >= 35)) and NAG:Cast(3044) -- Arcane Shot during Bestial Wrath
or ((NAG:CurrentFocus() >= 79)) and NAG:Cast(3044) -- Arcane Shot focus dump (optimized threshold from wowsims)
or NAG:Cast(13812) -- Explosive Trap (filler)
or (NAG:SpellIsKnown(77767) and NAG:Cast(77767) or NAG:Cast(56641)) -- Cobra Shot or Steady Shot (focus generation filler)
    ]],


    -- Tracked IDs for optimization
    spells = {1978, 3044, 3045, 13812, 19574, 19623, 33697, 34026, 53351, 53401, 56641, 77767, 77769, 82692, 82726, 109259, 117050, 120360, 120679, 120697, 126734, 131894, 13165, 109260, 5118, 13159},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    guide = [[
Beast Mastery Hunter Rotation Guide (MoP)

Core Mechanics:
- Focus Management: Generate with Cobra Shot, spend on Kill Command and Arcane Shot.
- Pet Synergy: Your pet is your primary damage source. Keep it alive and on target.

Rotation Priority:
1. Kill Command: Use on cooldown. Highest priority focus spender.
2. Kill Shot: Execute range (<20%).
3. Focus Fire: Use at 5 stacks of Frenzy (unless saving for burst).
4. Arcane Shot: Focus dump. Avoid capping focus.
5. Cobra Shot: Generator filler. Refreshes Serpent Sting.

Cooldowns:
- Bestial Wrath: Major burst. Pool focus slightly before using.
- Stampede: Huge burst. Sync with Rapid Fire/Bloodlust if possible.
- Rapid Fire: Haste buff.

AoE:
- Multi-Shot: Triggers Beast Cleave on your pet. Keep this buff up on 2+ targets!
- Explosive Trap: Use on CD for 3+ targets.
]],
    glyphs = {42909, 42903, 42911},
    author = "fonsas",

}


local marksmanshipRotation = {
    -- Core identification
    name = "MM Hunter",
    specIndex = 2,
    class = "HUNTER",

    -- Required parameters
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,

    -- Convert prepull actions from APL
    prePull = {
        { time = -11.0, action = "NAG:Cast(13165)" },  -- Aspect of the Hawk
        { time = -10.0, action = "NAG:Cast(1130)" },   -- Hunter's Mark
        { time = -5.0, action = "NAG:Cast(13812)" },   -- Explosive Trap
        { time = -2.3, action = "NAG:Cast(19434)" },   -- Aimed Shot
        { time = -1.0, action = "NAG:Cast(76089)" }    -- Potion (hidden)
    },

    lastModified = "12/06/2025",
    rotationString = [[
-- MARKSMANSHIP HUNTER - MoP Classic (WoWSims APL)

-- Aspects - Priority 0
(NAG:GetClassSetting('recommendAspects', true) and ((NAG:UnitIsMoving() and (not NAG:InCombat())) and ((NAG:GetNumGroupMembers() > 0 and NAG:SpellIsKnown(13159) and not NAG:AuraIsActive(13159) and NAG:Cast(13159, nil, NAG.SPELL_POSITIONS.ABOVE)) or (NAG:GetNumGroupMembers() == 0 and NAG:SpellIsKnown(5118) and not NAG:AuraIsActive(5118) and NAG:Cast(5118, nil, NAG.SPELL_POSITIONS.ABOVE))) or (not NAG:UnitIsMoving() or NAG:InCombat()) and ((NAG:SpellIsKnown(109260) and not NAG:AuraIsActive(109260) and not NAG:AuraIsActive(13165) and NAG:Cast(109260, nil, NAG.SPELL_POSITIONS.ABOVE)) or (not NAG:SpellIsKnown(109260) and NAG:SpellIsKnown(13165) and not NAG:AuraIsActive(13165) and not NAG:AuraIsActive(109260) and NAG:Cast(13165, nil, NAG.SPELL_POSITIONS.ABOVE)))))

-- OPENER SEQUENCE (First 10 seconds) - Optimized based on wowsims
or (NAG:CurrentTime() <= 10) and NAG:Cast(121818, nil, NAG.SPELL_POSITIONS.LEFT) -- Stampede (major burst)
or (NAG:CurrentTime() <= 10) and NAG:SpellIsKnown(26297) and NAG:Cast(26297) -- Berserking (Troll racial)
or (NAG:CurrentTime() <= 10) and NAG:SpellIsKnown(33697) and NAG:Cast(33697) -- Blood Fury (Orc racial)
or (NAG:CurrentTime() <= 10) and NAG:Cast(131894, nil, NAG.SPELL_POSITIONS.LEFT) -- A Murder of Crows
or (NAG:CurrentTime() <= 10) and (NAG:CurrentFocus() <= 60) and NAG:SpellIsReady(82726) and NAG:Cast(82726, nil, NAG.SPELL_POSITIONS.ABOVE) -- Fervor if low focus
or (NAG:CurrentTime() <= 10) and NAG:AutocastOtherCooldowns() -- Cooldowns bundle
or (NAG:CurrentTime() <= 10) and (NAG:AuraIsActive(82926)) and NAG:Cast(82928) -- Fire! proc Aimed Shot
or (NAG:CurrentTime() <= 10) and NAG:Cast(53209) -- Chimera Shot
or (NAG:CurrentTime() <= 10) and NAG:Cast(117050, nil, NAG.SPELL_POSITIONS.RIGHT) -- Glaive Toss
or (NAG:CurrentTime() <= 10) and NAG:Cast(120360, nil, NAG.SPELL_POSITIONS.RIGHT) -- Barrage

-- AOE ROTATION (3+ targets)
or (NAG:NumberTargets() >= 3) and (NAG:AuraIsInactive(1978, "target")) and NAG:Cast(1978) -- Serpent Sting (apply first)
or (NAG:NumberTargets() >= 3) and NAG:Cast(2643, nil, NAG.SPELL_POSITIONS.AOE) -- Multi-Shot
or (NAG:NumberTargets() >= 3) and NAG:Cast(117050, nil, NAG.SPELL_POSITIONS.RIGHT) -- Glaive Toss
or (NAG:NumberTargets() >= 3) and NAG:Cast(120360, nil, NAG.SPELL_POSITIONS.RIGHT) -- Barrage
or (NAG:NumberTargets() >= 3) and NAG:IsExecutePhase(20) and NAG:Cast(53351) -- Kill Shot (execute)
or (NAG:NumberTargets() >= 3) and NAG:Cast(53209) -- Chimera Shot
or (NAG:NumberTargets() >= 3) and (NAG:SpellIsReady(13812) and not NAG:AuraIsActive(77769)) and NAG:Cast(13812, nil, NAG.SPELL_POSITIONS.RIGHT) -- Explosive Trap

-- COOLDOWNS GROUP
or NAG:AutocastOtherCooldowns()
or NAG:SpellIsKnown(121818) and NAG:SpellIsReady(121818) and NAG:Cast(121818, nil, NAG.SPELL_POSITIONS.LEFT) -- Stampede
or NAG:SpellIsKnown(26297) and NAG:SpellIsReady(26297) and NAG:Cast(26297) -- Berserking (Troll racial)
or NAG:SpellIsKnown(33697) and NAG:SpellIsReady(33697) and NAG:Cast(33697) -- Blood Fury (Orc racial)
or NAG:SpellIsKnown(20572) and NAG:SpellIsReady(20572) and NAG:Cast(20572) -- Blood Fury (Orc - alternate ID)

-- FERVOR - Use more aggressively for focus management
or (NAG:CurrentFocus() <= 40 and NAG:SpellIsKnown(82726) and NAG:SpellIsReady(82726)) and NAG:Cast(82726, nil, NAG.SPELL_POSITIONS.ABOVE) -- Fervor (aggressive threshold)

-- RAPID FIRE BURST PHASE
or (NAG:AuraIsActive(3045) and NAG:AuraIsActive(82926)) and NAG:Cast(82928) -- Fire! proc during Rapid Fire (highest priority)
or (NAG:AuraIsActive(3045)) and NAG:Cast(19434) -- Aimed Shot spam during Rapid Fire
or NAG:Cast(3045, nil, NAG.SPELL_POSITIONS.LEFT) -- Rapid Fire

-- MAIN ROTATION
or (NAG:AuraIsActive(82926)) and NAG:Cast(82928) -- Fire! Proc - instant Aimed Shot
or (NAG:AuraIsInactive(1978, "target")) and NAG:Cast(1978) -- Serpent Sting (if not active)
or NAG:Cast(53209) -- Chimera Shot (on cooldown)
or (NAG:CurrentFocus() <= 30 and NAG:SpellIsKnown(82726) and NAG:SpellIsReady(82726)) and NAG:Cast(82726, nil, NAG.SPELL_POSITIONS.ABOVE) -- Fervor when very low focus
or (NAG:SpellIsKnown(131894)) and NAG:Cast(131894, nil, NAG.SPELL_POSITIONS.LEFT) -- A Murder of Crows
or (NAG:AuraNumStacks(53224) == 2 and NAG:AuraRemainingTime(53224) <= 4.0) and NAG:Cast(56641) -- Steady Focus maintenance
or NAG:IsExecutePhase(20) and NAG:Cast(53351) -- Kill Shot (execute phase)
or NAG:Cast(117050, nil, NAG.SPELL_POSITIONS.RIGHT) -- Glaive Toss
or NAG:Cast(120360, nil, NAG.SPELL_POSITIONS.RIGHT) -- Barrage
or (NAG:CurrentFocus() >= 60) and NAG:Cast(3044) -- Arcane Shot (focus >= 60)
or (NAG:CurrentFocus() >= 50) and NAG:Cast(19434) -- Aimed Shot (focus dump)
or NAG:Cast(13812, nil, NAG.SPELL_POSITIONS.RIGHT) -- Explosive Trap (filler)
or NAG:Cast(56641) -- Steady Shot (filler)
    ]],

    -- Tracked IDs for optimization
    spells = {
        1130,   -- Hunter's Mark
        1978,   -- Serpent Sting
        2643,   -- Multi-Shot
        3044,   -- Arcane Shot
        3045,   -- Rapid Fire
        13812,  -- Explosive Trap
        13165,  -- Aspect of the Hawk
        19434,  -- Aimed Shot
        53209,  -- Chimera Shot
        53351,  -- Kill Shot
        56641,  -- Steady Shot
        82726,  -- Fervor
        82928,  -- Aimed Shot (proc)
        109259, -- Powershot
        117050, -- Glaive Toss
        120360, -- Barrage
        120679, -- Dire Beast
        120697, -- Dire Beast
        121818, -- Stampede
        126734, -- Stampede (alt)
        131894, -- A Murder of Crows
        53401,  -- Readiness
        33697,  -- Blood Fury (Orc)
        26297,  -- Berserking (Troll)
        20572,  -- Blood Fury (Orc - alternate)
        114206, -- Glaive Toss (trinket)
        2825,   -- Bloodlust/Heroism
        120668, -- Bloodlust/Heroism (other)
        53224,  -- Steady Focus buff
        13159,  -- Aspect of the Pack
        5118,   -- Aspect of the Cheetah
        109260  -- Aspect of the Iron Hawk
    },
    items = {76089}, -- Potion
    auras = {82926, 77769, 53224}, -- Fire! proc, Explosive Trap debuff, Steady Focus
    runes = {},

    -- Optional metadata
    guide = [[
Marksmanship Hunter Rotation Guide (MoP)

Core Mechanics:
- Steady Focus: Cast Steady Shot in pairs to maintain this haste buff.
- Master Marksman: Stack proc for instant Aimed Shots.

Rotation Priority:
1. Chimera Shot: Use on cooldown. Refreshes Serpent Sting and heals.
2. Kill Shot: Execute range (<20%).
3. Aimed Shot: Use on Master Marksman procs (Instant) or as focus dump >80%.
4. Arcane Shot: Focus dump if no Aimed Shot proc and movement is required.
5. Steady Shot: Generator. ALWAYS cast in pairs for Steady Focus!

Cooldowns:
- Rapid Fire: Major haste cooldown. Stack with other buffs.
- Stampede: Burst damage.

AoE:
- Multi-Shot: Main AoE spender.
- Explosive Trap: Use on CD for AoE.
]],
    glyphs = {42909, 42903, 42914},
    author = "Smufrik"
}


local survivalRotation = {
        -- Core identification
        name = "Hunter Survival",
        specIndex = 3,
        class = "HUNTER",

        -- Required parameters
        default = true,
        enabled = true,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        prePull = {
            { time = -10.0, action = "NAG:Cast(13165)" },  -- Aspect of the Hawk
            { time = -5.0, action = "NAG:Cast(13812)" },   -- Explosive Trap
            { time = -1.0, action = "NAG:Cast(NAG:GetBattlePotion())" },  -- Potion
            { time = -0.3, action = "NAG:Cast(77767)" }    -- Pre-pull Cobra Shot for focus
        },
        lastModified = "11/20/2025",
        rotationString = [[
-- Aspects - Priority 0
(NAG:GetClassSetting('recommendAspects', true) and ((NAG:UnitIsMoving() and (not NAG:InCombat())) and ((NAG:GetNumGroupMembers() > 0 and NAG:SpellIsKnown(13159) and not NAG:AuraIsActive(13159) and NAG:Cast(13159, nil, NAG.SPELL_POSITIONS.ABOVE)) or (NAG:GetNumGroupMembers() == 0 and NAG:SpellIsKnown(5118) and not NAG:AuraIsActive(5118) and NAG:Cast(5118, nil, NAG.SPELL_POSITIONS.ABOVE))) or (not NAG:UnitIsMoving() or NAG:InCombat()) and ((NAG:SpellIsKnown(109260) and not NAG:AuraIsActive(109260) and not NAG:AuraIsActive(13165) and NAG:Cast(109260, nil, NAG.SPELL_POSITIONS.ABOVE)) or (not NAG:SpellIsKnown(109260) and NAG:SpellIsKnown(13165) and not NAG:AuraIsActive(13165) and not NAG:AuraIsActive(109260) and NAG:Cast(13165, nil, NAG.SPELL_POSITIONS.ABOVE)))))

-- OPENER SEQUENCE (First 10 seconds) - Optimized based on wowsims
or (NAG:CurrentTime() <= 10) and NAG:Cast(3674) -- Black Arrow (precast)
or (NAG:CurrentTime() <= 10) and NAG:Cast(131894) -- A Murder of Crows
or (NAG:CurrentTime() <= 10) and (NAG:CurrentFocus() <= 50) and NAG:Cast(82726) -- Fervor if low focus
or (NAG:CurrentTime() <= 10) and (not NAG:AuraIsActive(56343)) and NAG:Cast(53301) -- Explosive Shot (if no Lock and Load)
or (NAG:CurrentTime() <= 10) and NAG:AutocastOtherCooldowns() -- Cooldowns bundle
or (NAG:CurrentTime() <= 10) and NAG:Cast(53301) -- Explosive Shot
or (NAG:CurrentTime() <= 10) and (not NAG:AuraIsActive(1978)) and NAG:Cast(2643) -- Multi-Shot for Improved Serpent Sting if missing
or (NAG:CurrentTime() <= 10) and NAG:Cast(117050) -- Glaive Toss
or (NAG:CurrentTime() <= 10) and NAG:Cast(120360) -- Barrage

-- COOLDOWNS GROUP
or NAG:AutocastOtherCooldowns()
or (NAG:CurrentFocus() <= 50) and NAG:Cast(82726) -- Fervor

-- LOCK AND LOAD BURST PHASE (HIGHEST PRIORITY when active - even above AOE)
or NAG:AuraIsActive(56343) and NAG:Cast(53301) -- Explosive Shot during Lock and Load (highest priority)
or NAG:AuraIsActive(56343) and NAG:IsExecutePhase(20) and NAG:Cast(53351) -- Kill Shot even during Lock and Load
or NAG:AuraIsActive(56343) and (NAG:CurrentFocus() >= 80) and NAG:Cast(3044) -- Arcane Shot to prevent focus cap during Lock and Load

-- AOE ROTATION (3+ targets) - Only when NOT in Lock and Load
or (NAG:NumberTargets() >= 3) and (not NAG:AuraIsActive(56343)) and (NAG:CurrentFocus() >= 50) and NAG:Cast(2643) -- Multi-Shot
or (NAG:NumberTargets() >= 3) and (not NAG:AuraIsActive(56343)) and NAG:IsExecutePhase(20) and NAG:Cast(53351) -- Kill Shot
or (NAG:NumberTargets() >= 4) and (not NAG:AuraIsActive(56343)) and (NAG:CurrentFocus() >= 50) and NAG:Cast(2643) -- Multi-Shot spam for 4+ targets
or (NAG:NumberTargets() >= 4) and (not NAG:AuraIsActive(56343)) and (NAG:RemainingTime() >= 20.0) and (not NAG:AuraIsActive(77769)) and NAG:Cast(13812) -- Explosive Trap
or (NAG:NumberTargets() >= 3) and (not NAG:AuraIsActive(56343)) and (not NAG:AuraIsActive(3674)) and (NAG:CurrentFocus() >= 35) and (NAG:RemainingTime() >= 8.0) and NAG:Cast(3674) -- Black Arrow

-- MAIN ROTATION
or NAG:Cast(53301) -- Explosive Shot (on cooldown, Lock and Load handled above)
or (NAG:AuraIsActive(120668) and NAG:AuraRemainingTime(120668) >= 0.1) and NAG:Cast(120360) -- Barrage during Bloodlust
or NAG:IsExecutePhase(20) and NAG:Cast(53351) -- Kill Shot (execute phase)
or NAG:Cast(131894) -- A Murder of Crows (on cooldown)
or NAG:Cast(120697) -- Dire Beast (on cooldown)
or (not NAG:AuraIsActive(3674)) and (NAG:CurrentFocus() >= 35) and (NAG:RemainingTime() >= 8.0) and NAG:Cast(3674) -- Black Arrow (on cooldown, if target will live for full duration)
or (not NAG:AuraIsActive(1978)) and NAG:Cast(1978) -- Serpent Sting (apply if missing)
or (NAG:AuraRemainingTime(1978, "target") <= 6.0) and NAG:Cast(77767) -- Cobra Shot (refresh Serpent Sting if <= 6s remaining)
or NAG:Cast(117050) -- Glaive Toss (on cooldown)
or NAG:Cast(109259) -- Powershot (on cooldown)
or (not NAG:IsExecutePhase(20)) and NAG:Cast(120360) -- Barrage (on cooldown, avoid during execute)
or (((NAG:CurrentFocus() >= 50) and (NAG:SpellTimeToReady(3674) >= 4.0)) or (NAG:CurrentFocus() >= 70)) and NAG:Cast(3044) -- Arcane Shot (focus dump - ShouldAS logic: focus>=50 & BA CD>=4s OR focus>=70)
or (NAG:CurrentFocus() >= 50) and (NAG:NumberTargets() >= 2) and NAG:Cast(2643) -- Multi-Shot (focus dump for 2+ targets)
or NAG:Cast(13812) -- Explosive Trap (filler)
or NAG:Cast(77767) -- Cobra Shot (focus generation filler)
        ]],


        -- Tracked IDs for optimization
        spells = {
            1978,   -- Serpent Sting
            2643,   -- Multi-Shot
            3044,   -- Arcane Shot
            3674,   -- Black Arrow
            53301,  -- Explosive Shot
            53351,  -- Kill Shot
            77767,  -- Cobra Shot
            82726,  -- Fervor
            109259, -- Powershot
            117050, -- Glaive Toss
            120360, -- Barrage
            120679, -- Dire Beast
            120697, -- Dire Beast
            121818, -- Stampede
            131894, -- A Murder of Crows
            13812,  -- Explosive Trap
            56343,  -- Lock and Load buff
            77769,  -- Explosive Trap debuff
            13165,  -- Aspect of the Hawk
            109260, -- Aspect of the Iron Hawk
            5118,   -- Aspect of the Cheetah
            13159   -- Aspect of the Pack
        },
        items = {76089}, -- Potion
        auras = {56343, 77769}, -- Lock and Load, Explosive Trap debuff
        runes = {},

        -- Optional metadata
        guide = [[
Survival Hunter Rotation Guide (MoP)

Core Mechanics:
- Lock and Load: Procs free Explosive Shots. High priority!
- Serpent Sting: Maintain 100% uptime (refreshed by Cobra Shot).
- Viper's Venom: Procs from Cobra Shot.

Rotation Priority:
1. Explosive Shot: Use on cooldown. Don't clip ticks!
2. Kill Shot: Execute range (<20%).
3. Black Arrow: Use on cooldown. Triggers Lock and Load.
4. Serpent Sting: Apply if missing.
5. Arcane Shot: Focus dump.
6. Cobra Shot: Generator. Refreshes Serpent Sting.

Lock and Load Proc:
- Pool focus slightly if possible.
- Fire Explosive Shot -> Wait/Filler (GCD) -> Explosive Shot -> Wait/Filler -> Explosive Shot.
- Avoid overwriting the DoT tick if possible (wait ~0.5s between shots if high haste).

AoE:
- Multi-Shot: Applies Serpent Sting to all targets!
- Explosive Trap: Use on CD (triggers Lock and Load with talent?).
]],
        glyphs = {42909, 42903, 42899},
        author = "Smufrik"
    }


--- @class Hunter : ClassBase
local Hunter = NAG:CreateClassModule("HUNTER", defaults)
if not Hunter then return end

function Hunter:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 0, genericRotation)  -- Generic (no spec)
    ns.AddRotationToDefaults(self.defaults, 1, beastmasteryRotation)  -- Beast Mastery
    ns.AddRotationToDefaults(self.defaults, 2, marksmanshipRotation)  -- Marksmanship
    ns.AddRotationToDefaults(self.defaults, 3, survivalRotation)  -- Survival
end

function Hunter:RegisterSpellTracking()
    --- @type SpellTrackingManager|AceModule|CoreModule
    local SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
    if not SpellTrackingManager then
        return
    end

    -- Add spells to periodic damage tracking
    SpellTrackingManager:RegisterTravelTime({ 53301 }, { STT = 0, inFlight = nil }) -- Explosive Shot
end

-- Override GetOptions to add class-specific settings
local BaseGetOptions = Hunter.GetOptions
function Hunter:GetOptions()
    -- Call base GetOptions (copied from ClassBase)
    local options = BaseGetOptions(self)

    -- Ensure options structure exists
    options.args = options.args or {}
    options.args.settings = options.args.settings or { type = "group", args = {} }
    options.args.settings.args = options.args.settings.args or {}

    -- Add Aspect Settings
    options.args.settings.args.aspects = {
        type = "group",
        name = "Aspect Settings",
        order = 20,
        inline = true,
        args = {
            recommendAspects = {
                type = "toggle",
                name = "Recommend Aspects",
                desc = "Enable or disable aspect recommendations in rotation",
                get = function() return self:GetSetting("class", "recommendAspects", true) end,
                set = function(_, val) self:SetSetting("class", "recommendAspects", val) end,
                width = "full",
            }
        }
    }

    return options
end

NAG.Class = Hunter
