local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
local GetTime = _G.GetTime
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version

local defaults = ns.InitializeClassDefaults()

-- MoP Warlock spec spell locations
defaults.class.specSpellLocations = {
    [1] = { -- Affliction
        -- ABOVE spells
        [1454] = NAG.SPELL_POSITIONS.ABOVE,   -- Life Tap
        [28176] = NAG.SPELL_POSITIONS.ABOVE,   -- (unknown spell)
        [80398] = NAG.SPELL_POSITIONS.ABOVE,   -- (unknown spell)
        [114790] = NAG.SPELL_POSITIONS.ABOVE,   -- (unknown spell)

        -- BELOW spells
        [691] = NAG.SPELL_POSITIONS.BELOW,   -- (unknown spell)

        -- RIGHT spells
        [1122] = NAG.SPELL_POSITIONS.RIGHT,   -- Summon Infernal
        [27243] = NAG.SPELL_POSITIONS.RIGHT,   -- Seed of Corruption
        [47897] = NAG.SPELL_POSITIONS.RIGHT,   -- Demonic Breath
        [74434] = NAG.SPELL_POSITIONS.RIGHT,   -- Soulburn
        [113860] = NAG.SPELL_POSITIONS.RIGHT,   -- Dark Soul: Misery

        -- LEFT spells
        [1490] = NAG.SPELL_POSITIONS.LEFT,   -- Curse of the Elements
        [18540] = NAG.SPELL_POSITIONS.LEFT,   -- Summon Doomguard
        [26297] = NAG.SPELL_POSITIONS.LEFT,   -- Berserking
        [33702] = NAG.SPELL_POSITIONS.LEFT,   -- Blood Fury
        [77799] = NAG.SPELL_POSITIONS.LEFT,   -- Fel Flame
        [77801] = NAG.SPELL_POSITIONS.LEFT,   -- (unknown spell)
        [86121] = NAG.SPELL_POSITIONS.LEFT,   -- Soul Swap

    },
    [2] = { -- Demonology
        -- ABOVE spells
        [1454] = NAG.SPELL_POSITIONS.ABOVE,     -- Life Tap
        [28176] = NAG.SPELL_POSITIONS.ABOVE,    -- (unknown spell)
        [80398] = NAG.SPELL_POSITIONS.ABOVE,    -- (unknown spell)

        -- BELOW spells
        [30146] = NAG.SPELL_POSITIONS.BELOW,    -- (unknown spell)
        [691] = NAG.SPELL_POSITIONS.BELOW,      -- (unknown spell)

        -- RIGHT spells
        [47897] = NAG.SPELL_POSITIONS.RIGHT,    -- Demonic Breath
        [50589] = NAG.SPELL_POSITIONS.RIGHT,    -- (unknown spell)
        [1122] = NAG.SPELL_POSITIONS.RIGHT,     -- Summon Infernal
        [89751] = NAG.SPELL_POSITIONS.RIGHT,    -- Felstorm
        [1949] = NAG.SPELL_POSITIONS.RIGHT,     -- Hellfire

        -- LEFT spells
        [77801] = NAG.SPELL_POSITIONS.LEFT,     -- (unknown spell)
        [47241] = NAG.SPELL_POSITIONS.LEFT,     -- (unknown spell)
        [74434] = NAG.SPELL_POSITIONS.LEFT,     -- Soulburn
        [18540] = NAG.SPELL_POSITIONS.LEFT,     -- Summon Doomguard
        [33702] = NAG.SPELL_POSITIONS.LEFT,     -- Blood Fury
        [26297] = NAG.SPELL_POSITIONS.LEFT,     -- Berserking
        --[103958] = NAG.SPELL_POSITIONS.LEFT,    -- Metamorphosis

        -- AOE spells
        -- (empty)
    },
    [3] = { -- Destruction
        -- ABOVE spells
        [1454] = NAG.SPELL_POSITIONS.ABOVE,   -- Life Tap
        [28176] = NAG.SPELL_POSITIONS.ABOVE,   -- (unknown spell)
        [80240] = NAG.SPELL_POSITIONS.ABOVE,   -- Havoc
        [80398] = NAG.SPELL_POSITIONS.ABOVE,   -- (unknown spell)

        -- BELOW spells
        [688] = NAG.SPELL_POSITIONS.BELOW,   -- (unknown spell)

        -- RIGHT spells
        [1122] = NAG.SPELL_POSITIONS.RIGHT,   -- Summon Infernal
        [5740] = NAG.SPELL_POSITIONS.RIGHT,   -- (unknown spell)
        [47897] = NAG.SPELL_POSITIONS.RIGHT,   -- Demonic Breath

        -- LEFT spells
        [18540] = NAG.SPELL_POSITIONS.LEFT,   -- Summon Doomguard
        [26297] = NAG.SPELL_POSITIONS.LEFT,   -- Berserking
        [33702] = NAG.SPELL_POSITIONS.LEFT,   -- Blood Fury
        [36831] = NAG.SPELL_POSITIONS.LEFT,   -- (unknown spell)
        [74434] = NAG.SPELL_POSITIONS.LEFT,   -- Soulburn
        [77799] = NAG.SPELL_POSITIONS.LEFT,   -- Fel Flame
        [77801] = NAG.SPELL_POSITIONS.LEFT,   -- (unknown spell)

    }
}

-- Class assignments for raid coordination
defaults.class.classAssignments = {
    {
        id = "curse_of_elements",
        name = "Curse of the Elements",
        description = "Apply magic vulnerability debuff (coordinate with other Warlocks - only one curse per target)",
        spellIds = {104225}, -- Curse of the Elements (MoP version)
        category = "debuff",
    },
    {
        id = "curse_of_enfeeblement",
        name = "Curse of Enfeeblement",
        description = "Reduce target's physical damage and casting speed (coordinate with other Warlocks - only one curse per target)",
        spellIds = {109466, 109468}, -- Curse of Enfeeblement
        category = "debuff",
    },
}

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
-- Leave below as is

if UnitClassBase('player') ~= "WARLOCK" then return end

-- START OF GENERATED_ROTATIONS

-- replace 1490 with 36831 whenwever a new APL comes in
local destructionByFerusRotation =  {
    -- Core identification
    name = "Warlock Destruction - Base",
    specIndex = 3,
    class = "WARLOCK",

    -- Required parameters
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { time = -2.1, action = "NAG:Cast(76093)" },
        { time = -0.8, action = "NAG:Cast(29722)" }
    },
    lastModified = "11/13/2025",
    rotationString = [[

NAG:AutocastOtherCooldowns()

or (
(
    not (
        NAG:UnitDebuffGlobal("target", 36831)
        or NAG:UnitDebuffGlobal("target", 58410)
        or NAG:UnitDebuffGlobal("target", 24844)
        or NAG:UnitDebuffGlobal("target", 34889)
        or NAG:UnitDebuffGlobal("target", 1490)
    )
    and not (NAG:AuraIsActive(108683))
)
)
and NAG:Cast(1490, nil, NAG.SPELL_POSITIONS.LEFT)
-- Apply Curse of Elements if no equivalent raid debuff is present;


or (
NAG:AuraIsActive(108683)
) and NAG:SelectRotation("Warlock Destruction - FNB")
-- Use FNB rotation if Fire and Brimstone is active

or (
    (NAG:CurrentTime() < 0.01)
    and (not (NAG:SpellInFlight(29722)))
)
and NAG:Cast(29722)
-- Cast Incinerate pre-pull

or (
NAG:UnitIsMoving()
and not NAG:DotIsActive(104232)
)
and NAG:Cast(104232, nil, NAG.SPELL_POSITIONS.LEFT)
-- While moving, keep Rain of Fire applied

or (
NAG:UnitIsMoving()
)
and NAG:Cast(77799, nil, NAG.SPELL_POSITIONS.LEFT)
-- While moving with nothing else to do, cast Fel Flame

    or (
NAG:SpellIsReady(18540)
and (
    NAG:RemainingTime() <= 80
    or NAG:IsExecutePhase(20)
    or (
        NAG:IsExecutePhase(25)
        and (
            NAG:AllTrinketStatProcsActive()
            or NAG:AuraIsActive(76093) -- Jade Serpent potion
        )
    )
)
    )
    and NAG:Cast(18540, nil, NAG.SPELL_POSITIONS.RIGHT)
    -- Cast Summon Doomguard in execute or near end with strong procs/potion

    or (
NAG:SpellIsReady(76093)
and (
    NAG:IsExecutePhase(20)
    and (
        NAG:AuraRemainingTime(113858) > 5
        or NAG:AllTrinketStatProcsActive(3)
        or (
            (NAG:RemainingTime() < 55)
            and NAG:AuraIsActive(126577)
            and (
                NAG:AnyTrinketStatProcsActive(3)
            )
        )
    )
    or (NAG:RemainingTime() < 27)
)
    )
    and NAG:Cast(76093)
    -- Use Potion of the Jade Serpent in execute or near end with strong procs

    or (
        NAG:RemainingTime() <= 22.0
        or NAG:SpellTimeToCharge(113858) == 0.0
        or (
            (NAG:SpellNumCharges(113858) >= 1)
            and (NAG:SpellTimeToCharge(113858) <= 57.0)
            and (NAG:RemainingTime() <= 77.0)
        )
        or (NAG:AuraRemainingTime(76093) >= 20.0)
    )
    and NAG:Cast(113858, nil, NAG.SPELL_POSITIONS.RIGHT)
    -- Use Dark Soul: Instability when fight is ending, recharge imminent, or Jade Serpent potion active

    or (
        (NAG:AuraIsActive(113858)
        or NAG:AuraIsActive(76093)
        or NAG:AnyTrinketStatProcsActive())
    )
    and NAG:Cast(33697, nil, NAG.SPELL_POSITIONS.RIGHT)
    -- Use Blood Fury if major buffs are active

    or (
        NAG:AuraIsActive(113858)
        or NAG:AuraIsActive(76093)
    )
    and NAG:Cast(26297, nil, NAG.SPELL_POSITIONS.RIGHT)
    -- Use Berserking if major buffs are active

    or (
        (NAG:RemainingTime() > 66.0)
        or NAG:AuraIsActive(113858)
        or NAG:AuraIsActive(76093)
    )
    and NAG:Cast(96230, nil, NAG.SPELL_POSITIONS.RIGHT)
    -- Use Synapse Springs if major buffs are active or early in fight

    or (
        NAG:NumberTargets() > 5
        and (NAG:CurrentGenericResource() >= 10)
        and not NAG:AuraIsActive(108683)
    )
    and NAG:Cast(108683, nil, NAG.SPELL_POSITIONS.ABOVE)
    -- Enable Fire and Brimstone for heavy AoE (6+ targets)

    or (
        NAG:NumberTargets() >= 2
        and NAG:NumberTargets() <= 5
        and not NAG:AuraIsActive(80240)
    )
    and NAG:Cast(80240, nil, NAG.SPELL_POSITIONS.ABOVE)
    -- Apply Havoc in 2-5 target cleave windows

    or (
        NAG:NumberTargets() >= 4
        and not NAG:DotIsActive(104232)
    )
    and NAG:Cast(104232, nil, NAG.SPELL_POSITIONS.ABOVE)
    -- Maintain Rain of Fire in sustained AoE (4+ targets)

    or (
        NAG:AuraIsActive(80240)
        and NAG:IsExecutePhase(3)
        and NAG:CurrentGenericResource() >= 10
    )
    and NAG:Cast(17877)
    -- Shadowburn during Havoc in execute with enough embers

    or (
        NAG:IsExecutePhase(20)
        and (
            NAG:AuraIsActive(113858)
            or NAG:AuraIsActive(76093)
            or NAG:AnyTrinketStatProcsActive()
        )
        and (NAG:CurrentGenericResource() >= 10)
    )
    and NAG:Cast(17877)
    -- Shadowburn in execute when major buffs are active

    or (
        (NAG:RemainingTime() < 10)
        and (NAG:CurrentGenericResource() >= 10)
        and NAG:IsExecutePhase(20)
    )
    and NAG:Cast(17877)
    -- Shadowburn to dump embers at end of fight

    or (
        NAG:IsExecutePhase(20)
        and (NAG:CurrentGenericResource() > 35)
    )
    and NAG:Cast(17877)
    -- Shadowburn if embers are overflowing during execute

    or (
        (not NAG:IsExecutePhase(20))
        and (NAG:CurrentGenericResource() > 35)
        and (NAG:TrinketProcsMinRemainingTime() >= 5)
        and (NAG:AuraNumStacks(117828) < 3)
    )
    and NAG:Cast(116858)
    -- Chaos Bolt dump outside execute with procs and low Backdraft stacks

    or (
        (
            NAG:AuraIsActive(113858)
            or NAG:AuraIsActive(76093)
            or NAG:AnyTrinketStatProcsActive()
        )
        and (NAG:CurrentGenericResource() >= 10)
        and (
            (NAG:AuraNumStacks(117828) < 3)
            or (NAG:CurrentGenericResource() == 40)
        )
    )
    and NAG:Cast(116858)
    -- Chaos Bolt during major buffs

    or (
        not (
            NAG:DotIsActive(348)
            or NAG:DotIsActive(108686)
        )
    )
    and NAG:Cast(348)
    -- Apply Immolate if missing (single target or F&B DoT)

    or (
        (
            (NAG:DotRemainingTime(348) <= 5)
            or (NAG:DotRemainingTime(108686) <= 5)
        )
        and NAG:TrinketProcsMinRemainingTime() > 0
    )
    and NAG:Cast(348, nil, NAG.SPELL_POSITIONS.BELOW)
    -- Refresh Immolate when about to expire and procs are running

    or (
        (
            NAG:DotIsActive(348)
            and (
                NAG:ShouldMultidot(348, 4, (NAG:DotTickFrequency(348) + NAG:SpellCastTime(348)))
            )
            and NAG:NumberTargets() <= 4
        )
    )
    and NAG:Cast(348, nil, NAG.SPELL_POSITIONS.ABOVE)
    -- Multidot Immolate if effective on up to 4 targets

    or NAG:Cast(17962)
    -- Use Conflagrate on cooldown

    or NAG:Cast(29722)
    -- Filler: Incinerate

    --- MOP Destro
    --- Spell list
    --- 348 - Immolate
    --- 1490 - Curse of Elements
    --- 17877 - Shadowburn
    --- 17962 - Conflagrate
    --- 18540 - Summon Doomguard
    --- 26297 - Berserking
    --- 29722 - Incinerate
    --- 33697 - Blood Fury
    --- 76093 - Potion of the Jade Serpent
    --- 77799 - Fel Flame
    --- 80240 - Havoc
    --- 96230 - Synapse Springs
    --- 104232 - Rain of Fire
    --- 108683 - Fire and Brimstone
    --- 108686 - Immolate (FNB DoT)
    --- 113858 - Dark Soul: Instability
    --- 116858 - Chaos Bolt
    --- 117828 - Backdraft
    --- 126734 - Lifeblood
    ]],


    -- Tracked IDs for optimization
    spells = {348, 17877, 17962, 18540, 26297, 29722, 33697, 104232, 104993, 111897, 113858, 114206, 114207, 116858, 117828, 125487, 126577, 126734},
    items = {76093},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    author = "Ferus",

}

-- replace 1490 with 36831 whenwever a new APL comes in
local destructionByFerusRotation2 =  {
    -- Core identification
    name = "Warlock Destruction - FNB",
    specIndex = 3,
    class = "WARLOCK",

    -- Required parameters
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { time = -2.1, action = "NAG:Cast(76093)" },
        { time = -0.8, action = "NAG:Cast(29722)" }
    },
    lastModified = "11/13/2025",
    rotationString = [[


    (
        not NAG:AuraIsActive(108683)
    ) and NAG:SelectRotation("Warlock Destruction - Base")
    -- Switch back to regular rotation if FNB is not active

    or (
        NAG:NumberTargets() > 5
        and NAG:AuraIsActive(108683)
        and NAG:CurrentGenericResource() > 20
    )
    and NAG:Cast(108686)
    -- With Fire and Brimstone active and enough embers, spread Immolate

    or (
        NAG:NumberTargets() > 5
        and NAG:AuraIsActive(108683)
        and NAG:SpellIsReady(108685)
    )
    and NAG:Cast(108685)
    -- Fire and Brimstone: Conflagrate cleave if available

    or (
        NAG:NumberTargets() > 5
        and NAG:AuraIsActive(108683)
    )
    and NAG:Cast(114654)
    -- Fire and Brimstone: Incinerate cleave filler

    or (
        NAG:NumberTargets() <= 5
        and NAG:AuraIsActive(108683)
    )
    and NAG:Cast(108683, nil, NAG.SPELL_POSITIONS.PRIMARY)
    -- Disable Fire and Brimstone when target count drops

    --- MOP Destro
    --- Spell list
    --- 348 - Immolate
    --- 1490 - Curse of Elements
    --- 17877 - Shadowburn
    --- 17962 - Conflagrate
    --- 18540 - Summon Doomguard
    --- 26297 - Berserking
    --- 29722 - Incinerate
    --- 33697 - Blood Fury
    --- 76093 - Potion of the Jade Serpent
    --- 77799 - Fel Flame
    --- 80240 - Havoc
    --- 96230 - Synapse Springs
    --- 104232 - Rain of Fire
    --- 108683 - Fire and Brimstone
    --- 108686 - Immolate (FNB DoT)
    --- 113858 - Dark Soul: Instability
    --- 116858 - Chaos Bolt
    --- 117828 - Backdraft
    --- 126734 - Lifeblood
    ]],


    -- Tracked IDs for optimization
    spells = {348, 17877, 17962, 18540, 26297, 29722, 33697, 104232, 104993, 111897, 113858, 114206, 114207, 116858, 117828, 125487, 126577, 126734},
    items = {76093},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    author = "Ferus",

}

-- Generic (0 spec / no spec selected): low-level abilities before choosing a spec
local genericRotation = {
    name = "Generic",
    specIndex = 0,
    class = "WARLOCK",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    rotationString = [[
    (not NAG:AuraIsActive(706) and not NAG:AuraIsActive(687) and not NAG:AuraIsActive(28176)) and NAG:SpellCanCast(706) and NAG:Cast(706)
    or (not NAG:AuraIsActive(687) and not NAG:AuraIsActive(706) and not NAG:AuraIsActive(28176)) and NAG:SpellCanCast(687) and NAG:Cast(687)
    or (not NAG:AuraIsActive(28176) and not NAG:AuraIsActive(706) and not NAG:AuraIsActive(687)) and NAG:SpellCanCast(28176) and NAG:Cast(28176)
    or (NAG:SpellCanCast(348) and (not NAG:DotIsActive(348, "target"))) and NAG:Cast(348)
    or (NAG:SpellCanCast(686)) and NAG:Cast(686)
]],
}

local demonologyRotation = {
    -- Core identification
    name = "MOP - Demonology",
    specIndex = 2,
    class = "WARLOCK",

    -- Required parameters
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { time = -1.6, action = "NAG:Cast(76093)" },
        { time = -1.0, action = "NAG:Cast(6353)" },
        { time = -0.5, action = "NAG:Cast(105174)" }
    },
    lastModified = "10/28/2025",
    rotationString = [[

NAG:AutocastOtherCooldowns()
--- Reminder to cast Curse of Elements if it's not currently active
or (
        not(
                NAG:UnitDebuffGlobal("target", 36831)
                or NAG:UnitDebuffGlobal("target", 58410)
                or NAG:UnitDebuffGlobal("target", 24844)
                or NAG:UnitDebuffGlobal("target", 34889)
                or NAG:UnitDebuffGlobal("target", 1490)
        )
        and not(NAG:AuraIsActive(74434))
)
and NAG:Cast(1490, nil, NAG.SPELL_POSITIONS.LEFT)

-- Cast HOG pre-pull
or (
        (NAG:CurrentTime() < 0.01)
        and not (
            NAG:SpellInFlight(105174)
            or NAG:SpellInFlight(123194)
        )
)
and NAG:Cast(105174)

-- Use Meta rotation if Metamorphosis is active
or (
    NAG:AuraIsActive(103958)
) and NAG:SelectRotation("MOP - Demonology - Meta")

--- Apply Corruption if not currently active
or (
    not NAG:DotIsActive(172)
)
and NAG:Cast(172)

--- Use Felstorm
or NAG:Cast(119914)

--- Use Grimore: Felguard if if able
or NAG:Cast(111898)

--- Use Doomguard with bloodlust active
or (
    NAG:RemainingTime() <= 61.0
    or NAG:IsExecutePhase(20)
) and NAG:Cast(18540)

--- Use Synapse Springs if able
or NAG:Cast(96230)

--- Use Potion of the Jade Serpent if Dark Soul: Knowledge is active
or NAG:AuraIsActive(113861) and NAG:Cast(76093)

--- Use Blood Fury if Dark Soul: Knowledge is active
or NAG:AuraIsActive(113861) and NAG:Cast(33697)

-- Use Berserking if Dark Soul: Knowledge is active
or NAG:AuraIsActive(113861) and NAG:Cast(26297)

--- Use Dark Soul: Knowledge if you are about to cap on stacks, Imp swarm is ready, fight is about to end, or you have bloodlust or trinket active
or (
    not NAG:AuraIsActive(113861)
    and (
        (
            (NAG:SpellTimeToCharge(113861) <= 10.0)
            and (NAG:SpellNumCharges(113861) >= 1)
        )
        or (
            (NAG:SpellNumCharges(113861) == 1)
            and (NAG:SpellTimeToReady(104316) <= 1.0)
        )
        or (NAG:RemainingTime() <= 22.0)
        or (NAG:AuraRemainingTime(2825) >= 15.0)
        or NAG:AnyTrinketStatProcsActive()
    )
)
and NAG:Cast(113861)

--- Use Imp Swarm if Dark Soul: Knowledge is active or fight just started
or (
    (NAG:AuraRemainingTime(113861) >= 18.0)
    or (NAG:AuraRemainingTime(76093) >= 18.0)
    or (NAG:CurrentTime() <= 30.0)
)
and NAG:Cast(104316)



--- Use Metamorphosis if Shadowflame is active and Hand of Gul'dan is in flight
or (
    NAG:DotIsActive(47960)
    and (
        NAG:SpellInFlight(105174)
        or NAG:SpellInFlight(123194)
    )
)
and NAG:Cast(103958, nil, NAG.SPELL_POSITIONS.LEFT)

--- Use Hand of Gul'dan if your Shadowflame dot is about to expire and you have enough time to cast shadowbolt
or (
    (NAG:DotRemainingTime(47960) <= (1.3 + (NAG:GCDTimeToReady() + NAG:SpellCastTime(686))))
    and NAG:DotIsActive(47960)
)
and NAG:Cast(105174)

--- Cast Metamorphosis if Dark Soul: Knowledge is active and will last, or you have enough resource and fight is in the right window
or (
    (
        NAG:AuraIsActive(113861, "player", false)
        and (NAG:AuraRemainingTime(113861) > 10.0)
        and (NAG:CurrentTime() > 5.0)
    )
    or (
        (NAG:CurrentGenericResource() > 200)
        and (NAG:CurrentTime() > 5.0)
        and (NAG:CurrentTime() < 20.0)
    )
    or (
        (NAG:RemainingTime() <= 30.0)
        and (NAG:CurrentGenericResource() >= 500)
    )
)
and NAG:Cast(103958, nil, NAG.SPELL_POSITIONS.LEFT)

--- Cast Hand of Gul'dan if you have 2 charges, or 1 charge and next charge is soon
or (
    (NAG:SpellNumCharges(105174) >= 2)
    or (
        (NAG:SpellNumCharges(105174) >= 1)
        and (NAG:SpellTimeToCharge(105174) <= 2.5)
    )
)
and NAG:Cast(105174)

--- Multidot Corruption on additional targets if fight will last long enough
or (
    (NAG:RemainingTime() > 6.0)
    and NAG:DotIsActive(172)
    and NAG:ShouldMultidot(172, 4, NAG:DotTickFrequency(172))
)
and NAG:Cast(172, nil, NAG.SPELL_POSITIONS.RIGHT)

--- Cast Soul Fire if you have multiple Molten Core stacks or target is in execute phase
or (
    (NAG:AuraNumStacks(122355, "player", false) > 1)
    or NAG:IsExecutePhase(25)
)
and NAG:Cast(6353)

--- Cast Touch of Chaos if Metamorphosis is active
or (
    NAG:AuraIsActive(103958, "player", false)
)
and NAG:Cast(103964)



--- Cast Life Tap if mana is low and Metamorphosis is not active
or (
    (NAG:CurrentManaPercent() < 0.3)
    and NAG:AuraIsInactive(103958)
)
and NAG:Cast(1454)

--- Cast Shadow Bolt as a filler
or NAG:Cast(686)

--- Cast Life Tap as a filler if nothing else is available
or NAG:Cast(1454)
    ]],


    -- Tracked IDs for optimization
    spells = {172, 603, 686, 1454, 2825, 6353, 18540, 47960, 103958, 103964, 104316, 105174, 111898, 113858, 113861, 114925, 122355, 126734},
    items = {76093},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {42470, 45785, 42465, 43389},
    author = "Ferus",

}


local demonologyRotationMeta = {
    -- Core identification
    name = "MOP - Demonology - Meta",
    specIndex = 2,
    class = "WARLOCK",

    -- Required parameters
    default = false,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { time = -2.0, action = "NAG:Cast(76093)" },
        { time = -1.2, action = "NAG:Cast(6353)" },
        { time = -0.5, action = "NAG:Cast(105174)" }
    },
    lastModified = "10/28/2025",
    rotationString = [[

    -- Switch back to regular rotation if Metamorphosis is not active
    (
        not NAG:AuraIsActive(103958)
    ) and NAG:SelectRotation("MOP - Demonology")

    -- Apply Doom if not active or significant buff is active
    or (
        (NAG:DotPercentIncrease(603) >= 0.25)
        or (
            (NAG:DotPercentIncrease(603) >= 0)
            and (NAG:DotRemainingTime(603) <= 62.0)
            and (NAG:AuraIsActive(2825))
        )
        or (NAG:DotIsActive(603) == false)
    )
    and (NAG:CurrentGenericResource() >= 60) and NAG:Cast(603)

    -- Multidot with Doom
    or (
        NAG:ShouldMultidot(603, 3, NAG:DotTickFrequency(603))
    ) and (NAG:CurrentGenericResource() >= 60)
    and NAG:Cast(603, nil, NAG.SPELL_POSITIONS.RIGHT)

    -- Use Touch of Chaos if Corruption less that 4 seconds remaining or DotPercentIncrease of corruption is greater than 0 (I left this out for now, percent increase not working for toc yet)
    or (
        (NAG:DotIsActive(172) == true)
        and (
            (NAG:DotRemainingTime(172) <= 4.0)
        )
    )
    and NAG:Cast(103964)

    -- Cast Soul Fire
    or (
        NAG:AuraIsActive(122351)
        and (
            NAG:AuraRemainingTime(113861) > NAG:SpellCastTime(6353)
            or NAG:IsExecutePhase(25)
        )
        and NAG:CurrentGenericResource() >= 104
    )
    and NAG:Cast(6353)

    --- Cancel Metamorphosis if Dark Soul: Knowledge is not active, resource is low, and fight is not ending soon
    --- ( NAG:AuraIsActive(103958) and not NAG:AuraIsActive(113861) and (NAG:CurrentGenericResource() <= 600) and (NAG:RemainingTime() > 30.0) and ((NAG:SpellTimeToReady(103958) <= 2.0) or (NAG:CurrentGenericResource() <= 400)))
    or (
        NAG:AuraIsActive(103958)
        and not NAG:AuraIsActive(113861)
        and (NAG:CurrentGenericResource() <= 600)
        and (NAG:RemainingTime() > 30.0)
        and (
            (NAG:SpellTimeToReady(103958) <= 2.0)
            or (NAG:CurrentGenericResource() <= 400)
        )
    ) and (NAG:CancelMeta() or NAG:CastPlaceholder(103958, NAG.SPELL_POSITIONS.PRIMARY))

    -- Touch of Chaos Filler
    or (NAG:CurrentGenericResource() > 40) and NAG:Cast(103964)

    ]],


    -- Tracked IDs for optimization
    spells = {172, 603, 686, 1454, 2825, 6353, 18540, 47960, 103958, 103964, 104316, 105174, 111898, 113858, 113861, 114925, 122355, 126734},
    items = {76093},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {42470, 45785, 42465, 43389},
    author = "Ferus",

}


local afflictionRotation = {
    -- Core identification
    name = "Warlock Affliction",
    specIndex = 1,
    class = "WARLOCK",

    -- Required parameters
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { time = -20.0, action = "NAG:Cast(74434)" },
        { time = -1.8, action = "NAG:Cast(76093)" },
        { time = -1.2, action = "NAG:Cast(48181)" }
    },
    lastModified = "10/28/2025",
    rotationString = [[

    NAG:AutocastOtherCooldowns()
    --- Reminder to cast Curse of Elements if it's not currently active
    or (
            not(
                    NAG:UnitDebuffGlobal("target", 36831)
                    or NAG:UnitDebuffGlobal("target", 58410)
                    or NAG:UnitDebuffGlobal("target", 24844)
                    or NAG:UnitDebuffGlobal("target", 34889)
                    or NAG:UnitDebuffGlobal("target", 1490)
            )
            and not(NAG:AuraIsActive(74434))
    )
    and NAG:Cast(1490, nil, NAG.SPELL_POSITIONS.LEFT)

    -- Opener sequence: Cast major cooldowns at the start of combat
    or (
            (NAG:CurrentTime() < 1.0)
    )
    and NAG:StrictSequence("opener", false, 113860, 74434, 86121, 103103)

    -- Cast Haunt pre-pull
    or (
            (NAG:CurrentTime() < 0.01)
            and (not (NAG:SpellInFlight(48181)))
    )
    and NAG:Cast(48181)

    -- After opener: Start proc-fishing sequence if opener is complete
    or (
            NAG:SequenceIsComplete("opener")
            and (NAG:CurrentTime() <= 5.0)
            and (not NAG:AllTrinketStatProcsActive(4, 8, 12))
    )
    and NAG:Cast(103103)

    -- Cast Summon Doomguard in execute phase or near it with procs
    or (
            (NAG:RemainingTime() <= 70.0)
            or NAG:IsExecutePhase(20)
            or (
                    (
                            NAG:AllTrinketStatProcsActive(4, 15, 7)
                            or NAG:AuraIsActive(76093, "player", false)
                    )
                    and NAG:IsExecutePhase(25)
            )
    )
    and NAG:Cast(18540)

    -- Use Jade Serpent Potion in execute phase or near end of fight
    or (
            (
                    NAG:IsExecutePhase(20)
                    and (
                            (NAG:AuraRemainingTime(113860) > 5.0)
                            or NAG:AllTrinketStatProcsActive(4, -1, -1)
                            or (
                                    (NAG:RemainingTime() < 55.0)
                                    and NAG:AnyTrinketStatProcsActive(4, 15, -1, 45)
                            )
                    )
            )
            or (NAG:RemainingTime() < 27.0)
    )
    and NAG:Cast(76093)

    -- Cast Berserking when major cooldowns or potion are active
    or (
            NAG:AuraIsActive(113860)
            or NAG:AuraIsActive(76093)
    )
    and NAG:Cast(26297)

    -- Cast Lifeblood when cooldowns or potion are active, or early in fight
    or (
            (NAG:RemainingTime() > 66.0)
            or (
                    NAG:AuraIsActive(113860)
                    or NAG:AuraIsActive(76093)
            )
    )
    and NAG:Cast(126734)

    -- Cast Synapse Springs when cooldowns are active or early in fight
    or (
            (NAG:RemainingTime() > 126.0)
            or (
                    NAG:AuraIsActive(113860)
                    or NAG:AuraIsActive(76093)
                    or NAG:AuraIsActive(26297)
            )
    )
    and NAG:Cast(96230)

    -- Strict sequence: Use Soul Swap when CDs are about to expire
    or (
            ((NAG:DotPercentIncrease(30108) + NAG:DotPercentIncrease(172) + NAG:DotPercentIncrease(980)) >= 0.0)
            and (
                    (
                            NAG:AuraRemainingTime(113860) <= 3.0
                            and NAG:AuraIsActive(113860)
                    )
                    or (
                            NAG:AuraRemainingTime(26297) <= 3.0
                            and NAG:AuraIsActive(26297)
                    )
                    or (
                            NAG:AuraRemainingTime(104993) <= 3.0
                            and NAG:AuraIsActive(104993)
                    )
                    or (
                            NAG:AuraRemainingTime(33697) <= 3.0
                            and NAG:AuraIsActive(33697)
                    )
                    or (
                            NAG:AuraRemainingTime(126734) <= 3.0
                            and NAG:AuraIsActive(126734)
                    )
                    or (
                            NAG:AuraRemainingTime(2825) <= 3.0
                            and NAG:AuraIsActive(2825)
                    )
                    or NAG:TrinketProcsMinRemainingTime() <= 3.0
            )
            and (
                    (NAG:DotRemainingTime(980) < 30.0)
            )
            and (NAG:CurrentGenericResource() >= 0)
    )
    and NAG:Sequence("someName97", true, 74434, 119678)

    -- Cast Grimoire: Felhunter
    or NAG:Cast(111897)

    -- Strict sequence: Apply all dots if none are active
    or (
            (not NAG:DotIsActive(172))
            and (not NAG:DotIsActive(980))
            and (not NAG:DotIsActive(30108))
            and (NAG:CurrentGenericResource() >= 0)
    )
    and NAG:Sequence("someName426", true, 74434, 119678)

    -- Refresh Agony if about to expire or not active
    or (
            (NAG:DotRemainingTime(980) <= 2.0)
            or (
                    (NAG:DotRemainingTime(980) <= 1.5)
                    and NAG:GCDIsReady()
            )
            or (not NAG:DotIsActive(980))
    )
    and NAG:Cast(980)

    -- Refresh Corruption if about to expire or not active
    or (
            (NAG:DotRemainingTime(172) <= 2)
            or (not NAG:DotIsActive(172))
    )
    and NAG:Cast(172)

    -- Refresh Unstable Affliction if about to expire or not active
    or (
            (NAG:DotRemainingTime(30108) <= (NAG:SpellCastTime(30108) + 2))
            or (not NAG:DotIsActive(30108))
    )
    and NAG:Cast(30108)

    -- Use Dark Soul: Misery if dot percent increase is high and not already active
    or (
            ((NAG:DotPercentIncrease(30108) + NAG:DotPercentIncrease(172) + NAG:DotPercentIncrease(980)) >= 0.3)
            and not(NAG:AuraIsActive(113860))
    )
    and NAG:Cast(113860)

    -- Strict sequence: Use Soul Swap if dot percent increase is high
    or (
            ((NAG:DotPercentIncrease(30108) + NAG:DotPercentIncrease(172) + NAG:DotPercentIncrease(980)) >= 0.3)
            and (NAG:CurrentGenericResource() >= 0)
    )
    and NAG:Sequence("someName236", true, 74434, 119678)

    -- Channel Drain Soul if Haunt is not active and shards are low
    or (
            (not NAG:AuraIsActive(48181, "target", false))
            and (
                    not (NAG:SpellInFlight(48181))
            )
            and (NAG:CurrentGenericResource() <= 0)
    )
    and NAG:Cast(1120)

    -- Cast Haunt if about to expire and all dots are active

    or (
            (NAG:AuraRemainingTime(48181, "target") < (NAG:SpellCastTime(48181) + NAG:SpellTravelTime(48181)))
            and (
                    not (NAG:SpellInFlight(48181))
            )
            and (
                    NAG:DotIsActive(980)
                    and NAG:DotIsActive(172)
                    and NAG:DotIsActive(30108)
            )
            and (
                    (NAG:CurrentGenericResource() > 1)
                    or ((NAG:DotPercentIncrease(30108) + NAG:DotPercentIncrease(172) + NAG:DotPercentIncrease(980)) < 0.15))
    )
    and NAG:Cast(48181)

    -- Reapply Agony if dot percent increase is significant
    or (
            (NAG:DotPercentIncrease(980) >= 0.15)
            or (
                    (NAG:DotRemainingTime(980) <= 12.0)
                    and (NAG:DotPercentIncrease(980) >= 0.05)
            )
    )
    and NAG:Cast(980)

    -- Reapply Unstable Affliction if dot percent increase is significant
    or (
            (NAG:DotPercentIncrease(30108) >= 0.15)
            or (
                    (NAG:DotRemainingTime(30108) <= 7.0)
                    and (NAG:DotPercentIncrease(30108) >= 0.05)
            )
    )
    and NAG:Cast(30108)

    -- Reapply Corruption if dot percent increase is significant
    or (
            (NAG:DotPercentIncrease(172) >= 0.15)
            or (
                    (NAG:DotRemainingTime(172) <= 9.0)
                    and (NAG:DotPercentIncrease(172) >= 0.05)
            )
    )
    and NAG:Cast(172)

    -- Cast Life Tap if mana is low
    or (NAG:CurrentManaPercent("player") <= 0.15)
    and NAG:Cast(1454)

    -- Channel Drain Soul in execute phase unless resources are full
    -- channel doesn't seem to be working, using cast for now
    or (
            NAG:IsExecutePhase(20)
            and (NAG:CurrentGenericResource() < 4)
    )
    and NAG:Cast(1120)

    -- Channel Malefic Grasp if GCD is ready
    -- channel doesn't seem to be working, using cast for now.. not sure channel is really needed here anyway, NAG will display literally anything else it can before this.
    or NAG:Cast(103103)

    -- Cast Life Tap as fallback
    or NAG:Cast(1454)
    ]],


    -- Tracked IDs for optimization
    spells = {172, 980, 1120, 1454, 18540, 26297, 30108, 48181, 74434, 86121, 103103, 113860, 126577, 126659, 126734},
    items = {76093},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {42472, 43389},
    author = "Ferus",

}


-- Warlock Affliction Rotation
local afflictionRotationEspionn = {
    name = "Warlock Affliction - espionn",
    specIndex = 1,
    class = "Warlock",
    default = false,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { time = -1.6, action = "NAG:Cast(76093)" },
            { time = -1.6, action = "NAG:Cast(48181)" }
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or (((NAG:AuraRemainingTime(126734) < 6.0) and NAG:AuraIsActive(126734, "player", false) and (not NAG:AuraIsKnown(138963))) or NAG:AuraIsActive(138963, "player", false)) and NAG:Cast(57933)
    or NAG:VariableRef("should-dark-soul") and NAG:Cast(113860)
    or ((NAG:RemainingTime() <= 63.0) or NAG:IsExecutePhase(20) or ((NAG:AllTrinketStatProcsActive(4, 15, 7) or NAG:AuraIsActive(76093, "player", false)) and NAG:IsExecutePhase(25))) and NAG:Cast(18540)
    or NAG:VariableRef("should-potion") and NAG:Cast(76093)
    or ((NAG:RemainingTime() <= 12.0) or (NAG:AuraIsActive(113860, "player", false) and ((not NAG:VariableRef("can-proc-more")) or (NAG:AuraRemainingTime(113860) <= 13.0)))) and NAG:Cast(26297)
    or (((NAG:SpellTimeToCharge(113860) >= 55.0) and (not NAG:AuraIsActive(113860, "player", false))) or (NAG:RemainingTime() <= 12.0) or (NAG:AuraIsActive(113860, "player", false) and ((not NAG:VariableRef("can-proc-more")) or (NAG:AuraRemainingTime(113860) <= 13.0)))) and NAG:Cast(126734)
    or ((NAG:SpellTimeToCharge(113860) >= 115.0) or NAG:AuraIsActive(113860, "player", false) or (NAG:RemainingTime() <= 22.0) or NAG:AuraIsActive(76093, "player", false)) and NAG:Cast(74497)
    or NAG:Cast(111897)
-- Strictsequence filtered: only spellIds from NAG:Cast, removed none
    or (NAG:VariableRef("should-sbss")) and NAG:StrictSequence("someName88", nil, 74434, 86121)
    or ((NAG:VariableRef("should-sbss") or NAG:VariableRef("should-not-haunt")) and (NAG:CurrentGenericResource() == 0) and (((2 * (NAG:DotTickFrequency(1120) or 0)) < ((NAG:VariableRef("time-until-buffs-end") or 999) - (NAG:ChannelClipDelay() or 0)))) and NAG:VariableRef("all-dots-active")) and NAG:ChannelSpell(1120, function() return (NAG:GCDIsReady() and (NAG:SpellChanneledTicks(1120) >= 2)) end, false)
    or ((NAG:CurrentGenericResource() < 3) and (((2 * (NAG:DotTickFrequency(1120) or 0)) + (NAG:ChannelClipDelay() or 0)) < (NAG:VariableRef("dots-min-time") or 0)) and (((2 * (NAG:DotTickFrequency(1120) or 0)) + (NAG:ChannelClipDelay() or 0)) < (NAG:VariableRef("time-until-buffs-end") or 999)) and NAG:VariableRef("all-dots-active") and (NAG:DotPercentIncrease(980, "sp") < 0.45) and (NAG:DotPercentIncrease(86121) < 0.3) and (not NAG:IsExecutePhase(25)) and (NAG:CurrentManaPercent() > 0.15)) and NAG:ChannelSpell(1120, function() return (NAG:GCDIsReady() and (NAG:SpellChanneledTicks(1120) >= 2)) end, true)
    or ((not NAG:DotIsActive(980)) or (NAG:DotRemainingTime(980) <= NAG:VariableRef("GCD-duration"))) and NAG:Cast(980)
    or (not NAG:DotIsActive(172)) and NAG:Cast(172)
    or ((NAG:DotRemainingTime(30108) <= NAG:SpellCastTime(30108)) or (not NAG:DotIsActive(30108)) or ((NAG:DotRemainingTime(980) <= (NAG:VariableRef("GCD-duration") * 2)) and (NAG:DotRemainingTime(30108) <= (NAG:VariableRef("GCD-duration") * 2)))) and NAG:Cast(30108)
    or ((NAG:AuraRemainingTime(48181, "target") < 1.0) and (NAG:CurrentGenericResource() == 0) and (not NAG:SpellInFlight(48181))) and NAG:ChannelSpell(1120, function() return ((NAG:CurrentGenericResource() > 1) or (NAG:SpellChanneledTicks(1120) >= 2)) end, false)
    or ((NAG:AuraRemainingTime(48181, "target") < (NAG:SpellCastTime(48181) + (NAG:SpellTravelTime(48181) + 2.0))) and (not NAG:SpellInFlight(48181)) and (NAG:RemainingTime() > 3.0) and (not NAG:VariableRef("should-not-haunt"))) and NAG:Cast(48181)
    or ((not NAG:IsExecutePhase(20)) and ((NAG:AuraIsKnown(126659) and NAG:AuraIsInactive(126659, "player", true)) or (NAG:AuraIsKnown(138703) and NAG:AuraIsInactive(138703, "player", true)))) and NAG:ChannelSpell(103103, function() return NAG:GCDIsReady() end, true)
    or ((NAG:CurrentManaPercent() <= 0.15) and (NAG:RemainingTime() >= 10.0)) and NAG:Cast(1454)
    or NAG:IsExecutePhase(20) and NAG:ChannelSpell(1120, function() return (NAG:GCDIsReady()) end, false)
    or NAG:ChannelSpell(103103, function() return (NAG:GCDIsReady()) end, false)
    or NAG:Cast(1454)
    ]],

    -- Tracked IDs for optimization
    spells = {172, 980, 1120, 1454, 18540, 26297, 30108, 48181, 57933, 74497, 86121, 103103, 111897, 113860, 126659, 126734, 138703, 138786, 138790, 138898, 138963, 139133},
    items = {76093},
    auras = {},
    runes = {},
    glyphs = {42472, 42455, 45779, 43394, 43391},
    consumables = { prepotId = 76093, potId = 76093, flaskId = 76085, foodId = 74650 },

    -- Groups and Variables from WoWSims APL
    groups = {},
    variables = {
        {
            name = [[all-dots-active]],
            value = [[(NAG:DotIsActive(980) and NAG:DotIsActive(172) and NAG:DotIsActive(30108))]]
        },
        {
            name = [[no-dots-active]],
            value = [[(not NAG:DotIsActive(980) and not NAG:DotIsActive(172) and not NAG:DotIsActive(30108))]]
        },
        {
            name = [[should-potion]],
            value = [[((NAG:AuraIsActive(113860, "player", false) and (NAG:RemainingTime() <= NAG:SpellTimeToCharge(113860))) or (NAG:RemainingTime() <= 27.0))]]
        },
        {
            name = [[should-dark-soul]],
            value = [[((NAG:AnyTrinketStatProcsActive(4, 8, 7, 50) and (NAG:CurrentTime() > 40.0) and (NAG:NumEquippedStatProcTrinkets(4, 8, 7, 50) > 0)) or (NAG:RemainingTime() <= 23.0) or (NAG:SpellNumCharges(113860) == 2) or ((NAG:VariableRef("should-sbss") or (NAG:DotPercentIncrease(86121) > -0.25)) and NAG:AuraIsKnown(138786) and NAG:AuraIsActive(138786, "player", true)) or ((NAG:VariableRef("should-sbss") or (NAG:DotPercentIncrease(86121) > -0.25)) and NAG:AuraIsKnown(138898) and NAG:AuraIsActive(138898, "player", true)) or ((NAG:VariableRef("should-sbss") or (NAG:DotPercentIncrease(86121) > -0.25)) and NAG:AuraIsKnown(139133) and NAG:AuraIsActive(139133, "player", true)) or (NAG:AuraIsKnown(138963) and NAG:AuraIsActive(138963, "player", true) and (NAG:DotPercentIncrease(86121) > -0.25) and ((NAG:CurrentGenericResource() > 0.0) or (NAG:AuraRemainingTime(138963) > ((2 * (NAG:DotTickFrequency(1120) or 0)) + (NAG:ChannelClipDelay() or 0))))))]]
        },
        {
            name = [[GCD-duration]],
            value = [[NAG:GCDTimeValue()]]
        },
        {
            name = [[can-proc-more]],
            value = [[true]]
        },
        {
            name = [[should-sbss]],
            value = [[(NAG:VariableRef("no-dots-active") or (NAG:DotPercentIncrease(86121) >= 0.4) or ((NAG:DotPercentIncrease(86121) >= 0.2) and (not NAG:VariableRef("can-proc-more")) and (NAG:RemainingTime() > NAG:VariableRef("dots-min-time")) and (NAG:AuraIsInactive(138790, "player", false) or (NAG:AuraNumStacks(138786, "player", false) == 10))) or ((NAG:DotPercentIncrease(86121) >= -0.02) and (NAG:VariableRef("time-until-buffs-end") <= NAG:VariableRef("GCD-duration")) and (NAG:RemainingTime() > NAG:VariableRef("dots-min-time")) and (NAG:DotRemainingTime(980) < 31.0)) or ((NAG:DotPercentIncrease(86121) > 0.0) and (NAG:VariableRef("time-until-buffs-end") <= NAG:VariableRef("GCD-duration")) and (NAG:RemainingTime() > NAG:VariableRef("dots-min-time"))))]]
        },
        {
            name = [[time-until-buffs-end]],
            value = [[(function() local t = NAG:TrinketProcsMinRemainingTime(4, 7, 8); return (type(t) == "number" and t) or 999 end)()]]
        },
        {
            name = [[should-not-haunt]],
            value = [[((NAG:DotPercentIncrease(86121) >= -0.02) and ((((2 * (NAG:DotTickFrequency(1120) or 0)) + (NAG:ChannelClipDelay() or 0)) + 2.0) > NAG:VariableRef("time-until-buffs-end")) and (NAG:CurrentGenericResource() <= 1))]]
        },
        {
            name = [[dots-min-time]],
            value = [[(function() local t1 = NAG:DotRemainingTime(980) or 0; local t2 = NAG:DotRemainingTime(30108) or 0; local t3 = NAG:DotRemainingTime(172) or 0; return math.min(t1, t2, t3) end)()]]
        }
        },

    -- Optional metadata
    talentsString = "231211",
    lastModified = "11/20/2025",
    author = "espionn @ Ebon Hold"
}

local afflictionByFerusRotation = {
        -- Core identification
        name = "Warlock Affliction - backup",
        specIndex = 1,
        class = "WARLOCK",

        -- Required parameters
        default = false,
        enabled = true,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        prePull = {
            { time = -20.0, action = "NAG:Cast(74434)" },
            { time = -1.6, action = "NAG:Cast(76093)" },
            { time = -1, action = "NAG:Cast(48181)" }
        },
        lastModified = "07/03/2025",
        rotationString = [[
-- Warlock - Affliction
-- Optimized for level 90
-- Movement abilities and Curse of Elements application
(not(NAG:UnitDebuffGlobal("target", 36831) or NAG:UnitDebuffGlobal("target", 58410) or NAG:UnitDebuffGlobal("target", 24844) or NAG:UnitDebuffGlobal("target", 34889) or NAG:UnitDebuffGlobal("target", 1490)) and not(NAG:AuraIsActive(74434))) and NAG:Cast(1490)
or (NAG:UnitIsMoving() and NAG:CurrentManaPercent() < 50) and NAG:Cast(1454, nil, NAG.SPELL_POSITIONS.LEFT)
or (NAG:UnitIsMoving()) and NAG:Cast(77799)
-- Suggest Mana Tap if OOM
or (NAG:CurrentMana() < 10000) and NAG:Cast(1454, nil, NAG.SPELL_POSITIONS.LEFT)
-- AOE Section (6+)
-- 146739 is the dot id for the corruption from a soulburned seed of corruption. Not sure it can handle checking for both ids at the same time. This will do for now.
or (NAG:NumberTargets() >= 5
    and NAG:ShouldMultidot(146739, 5, (NAG:DotTickFrequency(146739) + NAG:SpellCastTime(27243)))
    and not NAG:AuraIsActive(74434)
    and not NAG:DotIsActive(114790))
    and NAG:Cast(74434, nil, NAG.SPELL_POSITIONS.ABOVE)
or (NAG:NumberTargets() >= 5
    and NAG:ShouldMultidot(146739, 5, (NAG:DotTickFrequency(146739) + NAG:SpellCastTime(27243)))
    and NAG:AuraIsActive(74434))
    and NAG:Cast(114790)
or (NAG:NumberTargets() >= 5 and (NAG:AnyTrinketStatProcsActive() or NAG:AuraIsActive(113860)) and NAG:SpellIsReady(18540)) and NAG:Cast(1122)
or (NAG:NumberTargets() >= 5 and NAG:RemainingTime() <= 61) and NAG:Cast(1122)
-- Cleave Section (2-5) I'm not putting in the logic to cap at 5 because you likely want to do some soul swapping in the AOE 6+ situation as well.
or (NAG:NumberTargets() >= 2 and NAG:CurrentGenericResource() >= 1
    and (not NAG:DotIsActive(980) or not NAG:DotIsActive(172) or not NAG:DotIsActive(30108)))
    and NAG:Cast(74434, nil, NAG.SPELL_POSITIONS.ABOVE)
or (NAG:NumberTargets() >= 2
    and not NAG:AuraIsActive(86211)
    and NAG:DotIsActive(980)
    and NAG:DotIsActive(172)
    and NAG:DotIsActive(30108))
    and NAG:Cast(86121, nil, NAG.SPELL_POSITIONS.ABOVE)
-- You only have 3 seconds to apply soul swap to next target... it's possible to get a seed of corruption off.. but extremely tight.
-- Will recommend seed as a possible cast by placing it up, but will leave main recommendation as soul swap.
or (NAG:NumberTargets() >= 2 and NAG:AuraIsActive(86211)) and NAG:Cast(27243, nil, NAG.SPELL_POSITIONS.ABOVE)
or (NAG:NumberTargets() >= 2 and NAG:AuraIsActive(86211)) and NAG:Cast(86213)
-- Main single target rotation
-- Suggest Doomguard if in amp window or fight is over soon.
or ((NAG:AnyTrinketStatProcsActive() or NAG:AuraIsActive(113860)) and NAG:SpellIsReady(18540)) and NAG:Cast(18540, nil, NAG.SPELL_POSITIONS.RIGHT)
or (NAG:RemainingTime() <= 61) and NAG:Cast(18540, nil, NAG.SPELL_POSITIONS.RIGHT)
-- Cast Dark Soul: Misery based on number of charges, proc status, and remaining time
or (NAG:SpellNumCharges(113860) == 0 and NAG:TrinketProcsMinRemainingTime() > 15 and NAG:CurrentGenericResource() >= 1) and NAG:Cast(113860)
or ((NAG:SpellNumCharges(113860) >= 1) and not NAG:AuraIsActive(113860) and NAG:AnyTrinketStatProcsActive()) and NAG:Cast(113860)
or ((NAG:SpellNumCharges(113860) == 2) and not NAG:AuraIsActive(113860) and NAG:TrinketProcsMinRemainingTime() > 15) and NAG:Cast(113860)
or ((NAG:SpellNumCharges(113860) >= 1) and not NAG:AuraIsActive(113860) and NAG:RemainingTime() < 22) and NAG:Cast(113860)
or ((NAG:SpellNumCharges(113860) >= 1) and not NAG:AuraIsActive(113860) and NAG:SpellTimeToCharge(113860) < 20 and NAG:TrinketProcsMinRemainingTime() > 15) and NAG:Cast(113860)
-- Cast Soulburn based on number of charges, proc status, and remaining dot time
or ((NAG:AnyTrinketStatProcsActive()
    or NAG:AuraIsActive(113860)         -- Dark Soul: Misery
    or NAG:AuraIsActive(105702)         -- Potion of the Jade Serpent
    or NAG:AuraIsActive(26297)          -- Berserking (Troll racial)
    or NAG:AuraIsActive(20572))         -- Blood Fury (Orc racial)
    and NAG:CurrentGenericResource() >= 1
    and (NAG:DotShouldRefresh(980, 12) or NAG:DotShouldRefresh(172, 8) or NAG:DotShouldRefresh(30108, 6)))
    and NAG:Cast(74434)
-- If Soulburn is active, cast Soul Swap to apply Big Dots.. Soul swap id changes from 86121 to 119678 in soulburn
or (NAG:AuraIsActive(74434) and NAG:SpellIsReady(119678)) and NAG:Cast(119678)
-- Maintain Dots
or (not NAG:DotIsActive(980)) and NAG:Cast(980)
or (NAG:DotShouldRefresh(980, 12) and NAG:TrinketProcsMinRemainingTime() > 0) and NAG:Cast(980, nil, NAG.SPELL_POSITIONS.BELOW)
or (not NAG:DotIsActive(172)) and NAG:Cast(172)
or (NAG:DotShouldRefresh(172, 8) and NAG:TrinketProcsMinRemainingTime() > 0) and NAG:Cast(172, nil, NAG.SPELL_POSITIONS.BELOW)
or (not NAG:DotIsActive(30108)) and NAG:Cast(30108)
or (NAG:DotShouldRefresh(30108, 6) and NAG:TrinketProcsMinRemainingTime() > 0) and NAG:Cast(30108, nil, NAG.SPELL_POSITIONS.BELOW)
-- Use Haunt if in amp window
or ((NAG:AuraIsActive(113860) or NAG:AnyTrinketStatProcsActive() or NAG:CurrentGenericResource() >= 3) and not NAG:DotIsActive(48181)) and NAG:Cast(48181, nil, NAG.SPELL_POSITIONS.LEFT)
-- Generating lots of Soul Shards in execute phase due to souldrain. Prioritize drain uptime by spending shards on Soulburn to refresh dots and using Haunt.
or (NAG:IsExecutePhase(20) and NAG:CurrentGenericResource() >= 2 and (
    NAG:DotShouldRefresh(980, 12) or
    NAG:DotShouldRefresh(172, 8) or
    NAG:DotShouldRefresh(30108, 6)))
    and NAG:Cast(74434 , nil, NAG.SPELL_POSITIONS.LEFT)
or (NAG:IsExecutePhase(20) and (NAG:DotRemainingTime(48181) <= (NAG:SpellCastTime(48181) + 1)) and NAG:CurrentGenericResource() >= 1) and NAG:Cast(48181, nil, NAG.SPELL_POSITIONS.LEFT)
-- Fillers
or (NAG:IsExecutePhase(20)) and NAG:Cast(1120)
or NAG:Cast(103103)
or NAG:Cast(1454)
        ]],


        -- Tracked IDs for optimization
        spells = {172, 980, 1120, 1454, 18540, 26297, 30108, 48181, 74434, 86121, 103103, 113860, 126577, 126659, 126734},
        items = {76093},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {42472, 43389},
        author = "Ferus",

}


local afflictionRotationEspiNew = {
    name = "Warlock Affliction - by espi",
    specIndex = 1,
    class = "WARLOCK",
    default = false,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { time = -2, action = "NAG:Cast(76093)" },
            { time = -1.6, action = "NAG:Cast(48181)" }
    },
    rotationString = [[
	-- CoE
    (
            not(
                    NAG:UnitDebuffGlobal("target", 36831)
                    or NAG:UnitDebuffGlobal("target", 58410)
                    or NAG:UnitDebuffGlobal("target", 24844)
                    or NAG:UnitDebuffGlobal("target", 34889)
                    or NAG:UnitDebuffGlobal("target", 1490)
            )
            and not(NAG:AuraIsActive(74434))
    )
    and NAG:Cast(1490, nil, NAG.SPELL_POSITIONS.LEFT)
	-- movement (tap / fel flame)
	or (NAG:UnitIsMoving() and NAG:CurrentManaPercent() < 50) and NAG:Cast(1454, nil, NAG.SPELL_POSITIONS.LEFT)
	or (NAG:UnitIsMoving()) and NAG:Cast(77799)
	-- dark soul
    or NAG:VariableRef("should-dark-soul") and NAG:Cast(113860, nil, NAG.SPELL_POSITIONS.RIGHT)
	-- doomguard
    or ((NAG:RemainingTime() <= 70.0) or NAG:IsExecutePhase(20)) and NAG:Cast(18540, nil, NAG.SPELL_POSITIONS.RIGHT)
	-- potion
    or NAG:VariableRef("should-potion") and NAG:Cast(105702, nil, NAG.SPELL_POSITIONS.RIGHT)
	-- berserking
    or ((NAG:RemainingTime() <= 15.0) or (NAG:AuraIsActive(113860, "player", false) and ((not NAG:VariableRef("can-proc-more")) or (NAG:AuraRemainingTime(113860) <= 13.0)))) and NAG:Cast(26297, nil, NAG.SPELL_POSITIONS.RIGHT)
	-- synapse springs
    or (((NAG:SpellTimeToCharge(113860) >= 55.0) and (not NAG:AuraIsActive(113860, "player", false))) or (NAG:RemainingTime() <= 12.0) or (NAG:AuraIsActive(113860, "player", false) and ((not NAG:VariableRef("can-proc-more")) or (NAG:AuraRemainingTime(113860) <= 13.0)))) and NAG:Cast(126734, nil, NAG.SPELL_POSITIONS.RIGHT)
    -- lifeblood
	or ((NAG:SpellTimeToCharge(113860) >= 115.0) or NAG:AuraIsActive(113860, "player", false) or (NAG:RemainingTime() <= 22.0) or NAG:AuraIsActive(76093, "player", false)) and NAG:Cast(74497, nil, NAG.SPELL_POSITIONS.RIGHT)
	-- SBSS sequence: need to refactor using new api
    or (NAG:VariableRef("should-sbss") and  NAG:AuraIsActive(74434)) and NAG:CastWithOverlay(86121, "SBSS", NAG.SPELL_POSITIONS.PRIMARY)
    or (NAG:VariableRef("should-sbss") and (NAG:CurrentGenericResource() > 0.0) and not(NAG:AuraIsActive(74434))) and NAG:CastWithOverlay(74434, "SBSS", NAG.SPELL_POSITIONS.PRIMARY)
	-- 2 tick ds for shards
    --or ((NAG:VariableRef("should-sbss") or NAG:VariableRef("should-not-haunt")) and (NAG:CurrentGenericResource() == 0) and ((2 * NAG:DotTickFrequency(1120)) < (NAG:VariableRef("time-until-buffs-end") - NAG:ChannelClipDelay())) and NAG:VariableRef("all-dots-active")) and NAG:Channel(1120, function() return (NAG:GCDIsReady() and (NAG:SpellChanneledTicks(1120) >= 2)) end, false)
    or ((NAG:VariableRef("should-sbss") or NAG:VariableRef("should-not-haunt")) and (NAG:CurrentGenericResource() == 0) and ((2 * NAG:DotTickFrequency(1120)) < (NAG:VariableRef("time-until-buffs-end") - NAG:ChannelClipDelay())) and NAG:VariableRef("all-dots-active")) and NAG:Channel(1120)
    -- agony
	or ((not NAG:DotIsActive(980)) or (NAG:DotRemainingTime(980) <= NAG:VariableRef("GCD-duration"))) and NAG:Cast(980)
	-- corruption
    or (not NAG:DotIsActive(172)) and NAG:Cast(172)
	-- UA
    or ((NAG:DotRemainingTime(30108) <= NAG:SpellCastTime(30108)) or (not NAG:DotIsActive(30108)) or ((NAG:DotRemainingTime(980) <= (NAG:VariableRef("GCD-duration") * 2)) and (NAG:DotRemainingTime(30108) <= (NAG:VariableRef("GCD-duration") * 2)))) and NAG:Cast(30108)
    -- ds for haunt
	or ((NAG:AuraRemainingTime(48181, "target") < 1.0) and (NAG:CurrentGenericResource() == 0) and (not NAG:SpellInFlight(48181))) and NAG:Channel(1120, function() return ((NAG:CurrentGenericResource() > 1) or (NAG:SpellChanneledTicks(1120) >= 2)) end, false)
    -- haunt
	or ((NAG:AuraRemainingTime(48181, "target") < (NAG:SpellCastTime(48181) + (NAG:SpellTravelTime(48181) + 2.0))) and (not NAG:SpellInFlight(48181)) and (NAG:RemainingTime() > 3.0) and (not NAG:VariableRef("should-not-haunt"))) and NAG:Cast(48181, 0, nil, true)
    -- mg to fish for trinkets
	-- or ((not NAG:IsExecutePhase(20)) and ((NAG:AuraIsKnown(126659) and NAG:AuraIsInactive(126659, "player", true)) or (NAG:AuraIsKnown(138703) and NAG:AuraIsInactive(138703, "player", true)))) and NAG:Channel(103103, function() return NAG:GCDIsReady() end, true)
	or ((not NAG:IsExecutePhase(20)) and ((NAG:AuraIsKnown(126659) and NAG:AuraIsInactive(126659, "player", true)) or (NAG:AuraIsKnown(138703) and NAG:AuraIsInactive(138703, "player", true)))) and NAG:Channel(103103)
    -- life tap
	or ((NAG:CurrentManaPercent() <= 0.15) and (NAG:RemainingTime() >= 10.0)) and NAG:Cast(1454, nil, NAG.SPELL_POSITIONS.LEFT)
    -- execute ds
	--or NAG:IsExecutePhase(20) and NAG:Channel(1120, function() return (NAG:GCDIsReady()) end, false)
	or NAG:IsExecutePhase(20) and NAG:Channel(1120)
    -- malefic grasp
	--or NAG:Channel(103103, function() return (NAG:GCDIsReady()) end, false)
	or NAG:Channel(103103)
    -- backup tap
	or NAG:Cast(1454, nil, NAG.SPELL_POSITIONS.LEFT)
    ]],

    -- Tracked IDs for optimization
    spells = {172, 980, 1120, 1454, 18540, 26297, 30108, 48181, 74497, 86121, 103103, 111897, 113860, 126659, 126734, 138703, 138786, 138790, 138898, 138963, 139133},
    items = {76093},
    auras = {},
    runes = {},
    glyphs = {42472, 42455, 43389},
    consumables = { prepotId = 76093, potId = 76093, flaskId = 76085, foodId = 74650 },

    -- Groups and Variables from WoWSims APL
    groups = {},
    variables = {
        {
            name = [[all-dots-active]],
            value = [[(NAG:DotIsActive(980) and NAG:DotIsActive(172) and NAG:DotIsActive(30108))]]
        },
        {
            name = [[no-dots-active]],
            value = [[(not NAG:DotIsActive(980) and not NAG:DotIsActive(172) and not NAG:DotIsActive(30108))]]
        },
        {
            name = [[should-potion]],
            value = [[((NAG:AuraIsActive(113860, "player", false) and (NAG:RemainingTime() <= NAG:SpellTimeToCharge(113860))) or (NAG:RemainingTime() <= 27.0))]]
        },
        {
            name = [[should-dark-soul]],
            -- IMPORTANT: This expression must be valid Lua because we precompile variables (RotationManager:PrecompileRotationVariables).
            -- The original string had a stray trailing ']' which prevented precompilation and forced per-tick loadstring() compilation.
            value = [[(
                (NAG:AnyTrinketStatProcsActive(4, 8, 7, 50) and (NAG:CurrentTime() > 40.0) and (NAG:NumEquippedStatProcTrinkets(4, 8, 7, 50) > 0))
                or (NAG:RemainingTime() <= 25.0)
                or (NAG:SpellNumCharges(113860) == 2)
                or ((NAG:VariableRef("should-sbss") or (NAG:DotPercentIncrease(86121) > -0.25)) and NAG:AuraIsKnown(138786) and NAG:AuraIsActive(138786, "player", true))
                or ((NAG:VariableRef("should-sbss") or (NAG:DotPercentIncrease(86121) > -0.25)) and NAG:AuraIsKnown(138898) and NAG:AuraIsActive(138898, "player", true))
                or ((NAG:VariableRef("should-sbss") or (NAG:DotPercentIncrease(86121) > -0.25)) and NAG:AuraIsKnown(139133) and NAG:AuraIsActive(139133, "player", true))
                or (
                    NAG:AuraIsKnown(138963)
                    and NAG:AuraIsActive(138963, "player", true)
                    and (NAG:DotPercentIncrease(86121) > -0.25)
                    and (
                        (NAG:CurrentGenericResource() > 0.0)
                        or (NAG:AuraRemainingTime(138963) > ((2 * (NAG:DotTickFrequency(1120) or 0)) + (NAG:ChannelClipDelay() or 0)))
                    )
                )
            )]]
        },
        {
            name = [[GCD-duration]],
            value = [[(NAG:GCDTimeValue())]]
        },
        {
            name = [[can-proc-more]],
            value = [[(NAG:AnyTrinketStatProcsAvailable(4, 7, 8,0))]]
        },
        {
            name = [[should-sbss]],
            -- IMPORTANT: This expression must be valid Lua; remove stray trailing ']' to keep variable precompilation enabled.
            value = [[(
                NAG:VariableRef("no-dots-active")
                or (NAG:DotPercentIncrease(86121) >= 0.4)
                or (
                    (NAG:DotPercentIncrease(86121) >= 0.2)
                    and (not NAG:VariableRef("can-proc-more"))
                    and (NAG:RemainingTime() > (NAG:VariableRef("dots-min-time") or 0))
                    and (NAG:AuraIsInactive(138790, "player", false) or (NAG:AuraNumStacks(138786, "player", false) == 10))
                )
                or (
                    (NAG:DotPercentIncrease(86121) >= -0.02)
                    and ((NAG:VariableRef("time-until-buffs-end") or 999) <= (NAG:VariableRef("GCD-duration") or 0))
                    and (NAG:RemainingTime() > (NAG:VariableRef("dots-min-time") or 0))
                    and ((NAG:DotRemainingTime(980) or 999) < 31.0)
                )
            )]]
        },
        {
            name = [[time-until-buffs-end]],
            -- Ensure math.min never sees nil (some helpers can return nil in edge cases)
            value = [[math.min(
                (NAG:TrinketProcsMinRemainingTime(4, 7, 8, 0) or 999),
                (NAG:IsActive(96230) and (NAG:AuraRemainingTime(96230) or 999) or 999),
                (NAG:IsActive(26297) and (NAG:AuraRemainingTime(26297) or 999) or 999),
                (NAG:IsActive(113860) and (NAG:AuraRemainingTime(113860) or 999) or 999),
                (NAG:IsActive(33697) and (NAG:AuraRemainingTime(33697) or 999) or 999),
                (NAG:IsActive(74497) and (NAG:AuraRemainingTime(74497) or 999) or 999),
                (NAG:IsActive(105702) and (NAG:AuraRemainingTime(105702) or 999) or 999)
            )]]
		},
        {
            name = [[should-not-haunt]],
            value = [[(
                (NAG:DotPercentIncrease(86121) >= -0.02)
                and (
                    ((((2 * (NAG:DotTickFrequency(1120) or 0)) + (NAG:ChannelClipDelay() or 0)) + 2.0) > (NAG:VariableRef("time-until-buffs-end") or 999))
                    and (NAG:CurrentGenericResource() <= 1)
                )
            )]]
        },
        {
            name = [[dots-min-time]],
            value = [[math.min(
                (NAG:DotRemainingTime(980) or 999),
                (NAG:DotRemainingTime(30108) or 999),
                (NAG:DotRemainingTime(172) or 999)
            )]]
        }
    },

    -- Optional metadata
    talentsString = "231211",
    lastModified = "11/24/2025",
    author = "espi"

}

-- END OF GENERATED_ROTATIONS

--- @class Warlock : ClassBase
local Warlock = NAG:CreateClassModule("WARLOCK", defaults)
if not Warlock then return end

function Warlock:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 0, genericRotation)  -- Generic (no spec)
    ns.AddRotationToDefaults(self.defaults, 3, destructionByFerusRotation)  -- Destruction
    ns.AddRotationToDefaults(self.defaults, 3, destructionByFerusRotation2)  -- Destruction
    ns.AddRotationToDefaults(self.defaults, 2, demonologyRotationMeta)  -- Demonology
    ns.AddRotationToDefaults(self.defaults, 2, demonologyRotation)  -- Demonology
    -- ns.AddRotationToDefaults(self.defaults, 1, afflictionRotation)  -- Affliction
    -- ns.AddRotationToDefaults(self.defaults, 1, afflictionByFerusRotation)  -- Affliction
    --ns.AddRotationToDefaults(self.defaults, 1, afflictionRotationEspionn)  -- Affliction
    ns.AddRotationToDefaults(self.defaults, 1, afflictionRotationEspiNew)  -- Affliction
end


function Warlock:RegisterSpellTracking()
    --- @type SpellTrackingManager|AceModule|CoreModule
    local SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
        -- Add spells to periodic damage tracking
    -- Add spells to cast tracking
    SpellTrackingManager:RegisterCastTracking({ 30146 }, { count = 0, startTime = GetTime() })     -- Summon Felguard
    SpellTrackingManager:RegisterPeriodicDamage({ 172 }, { tickTime = nil, lastTickTime = nil })   -- Corruption
    SpellTrackingManager:RegisterPeriodicDamage({ 30108 }, { tickTime = nil, lastTickTime = nil }) -- Unstable Affliction
    SpellTrackingManager:RegisterPeriodicDamage({ 603 }, { tickTime = nil, lastTickTime = nil })   -- Bane of Doom
    SpellTrackingManager:RegisterPeriodicDamage({ 348 }, { tickTime = nil, lastTickTime = nil })   -- Immolate
end

NAG.Class = Warlock
