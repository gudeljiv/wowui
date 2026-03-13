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

-- MoP Shaman spec spell locations
defaults.class.specSpellLocations = {
    [1] = { -- Elemental
        -- ABOVE spells
        [2062] = NAG.SPELL_POSITIONS.ABOVE,     -- Earth Elemental Totem

        -- BELOW spells
        [8071] = NAG.SPELL_POSITIONS.BELOW,     -- (unknown spell)
        [3599] = NAG.SPELL_POSITIONS.BELOW,     -- Searing Totem
        [5394] = NAG.SPELL_POSITIONS.BELOW,     -- (unknown spell)
        [3738] = NAG.SPELL_POSITIONS.BELOW,     -- (unknown spell)
        [8190] = NAG.SPELL_POSITIONS.BELOW, -- Magma Totem
        [135825] = NAG.SPELL_POSITIONS.BELOW,   -- (unknown spell)

        -- RIGHT spells
        -- (empty)

        -- LEFT spells
        [51533] = NAG.SPELL_POSITIONS.LEFT,     -- Feral Spirit
        [16166] = NAG.SPELL_POSITIONS.LEFT,     -- Elemental Mastery
        [2894] = NAG.SPELL_POSITIONS.LEFT,      -- Fire Elemental Totem
        [33697] = NAG.SPELL_POSITIONS.LEFT,
        [79206] = NAG.SPELL_POSITIONS.LEFT,     -- Spiritwalker's Grace
        [2825] = NAG.SPELL_POSITIONS.LEFT,      -- Bloodlust
        [26297] = NAG.SPELL_POSITIONS.LEFT, -- Berserking
        [114049] = NAG.SPELL_POSITIONS.LEFT,    -- Ascendance
        [120668] = NAG.SPELL_POSITIONS.LEFT,    -- Stormlash Totem
        [30823] = NAG.SPELL_POSITIONS.LEFT,     -- Shamanistic Rage
        [126734] = NAG.SPELL_POSITIONS.LEFT,    -- (unknown spell)
        [82174] = NAG.SPELL_POSITIONS.LEFT,     -- (unknown spell)
        [54758] = NAG.SPELL_POSITIONS.LEFT,     -- Hyperspeed Acceleration

        -- AOE spells
        [421] = NAG.SPELL_POSITIONS.AOE,       -- Chain Lightning
        [61882] = NAG.SPELL_POSITIONS.AOE      -- Earthquake
    },
    [2] = { -- Enhancement
        -- ABOVE spells
        [8024] = NAG.SPELL_POSITIONS.ABOVE,   -- Flametongue Weapon
        [8232] = NAG.SPELL_POSITIONS.ABOVE,   -- (unknown spell)
        [120668] = NAG.SPELL_POSITIONS.ABOVE,   -- Stormlash Totem

        -- BELOW spells
        [0] = NAG.SPELL_POSITIONS.BELOW,   -- (unknown spell)
        [324] = NAG.SPELL_POSITIONS.BELOW,   -- (unknown spell)
        [3599] = NAG.SPELL_POSITIONS.BELOW,   -- Searing Totem
        [5394] = NAG.SPELL_POSITIONS.BELOW,   -- (unknown spell)
        [8075] = NAG.SPELL_POSITIONS.BELOW,   -- (unknown spell)
        [8512] = NAG.SPELL_POSITIONS.BELOW,   -- (unknown spell)
        [135825] = NAG.SPELL_POSITIONS.BELOW,   -- (unknown spell)

        -- LEFT spells
        [2062] = NAG.SPELL_POSITIONS.LEFT,   -- Earth Elemental Totem
        [2825] = NAG.SPELL_POSITIONS.LEFT,   -- Bloodlust
        [2894] = NAG.SPELL_POSITIONS.LEFT,   -- Fire Elemental Totem
        [16166] = NAG.SPELL_POSITIONS.LEFT,   -- Elemental Mastery
        [26297] = NAG.SPELL_POSITIONS.LEFT,   -- Berserking
        [30823] = NAG.SPELL_POSITIONS.LEFT,   -- Shamanistic Rage
        [33697] = NAG.SPELL_POSITIONS.LEFT,   -- Blood Fury
        [51533] = NAG.SPELL_POSITIONS.LEFT,   -- Feral Spirit
        [114049] = NAG.SPELL_POSITIONS.LEFT,   -- Ascendance

        -- AOE spells
        [1535] = NAG.SPELL_POSITIONS.AOE,   -- Fire Nova

    },
    [3] = { -- Restoration
        -- ABOVE spells
        -- (empty)

        -- BELOW spells
        [3599] = NAG.SPELL_POSITIONS.BELOW,     -- Searing Totem

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
        id = "bloodlust",
        name = "Bloodlust/Heroism",
        description = "Cast Bloodlust/Heroism for raid-wide haste (coordinate with other Shamans/Mages)",
        spellIds = {2825, 32182}, -- Bloodlust, Heroism
        category = "buff",
    },
    {
        id = "stormlash_totem",
        name = "Stormlash Totem",
        description = "Place totem that increases attack speed (coordinate with other Shamans)",
        spellIds = {120668}, -- Stormlash Totem
        category = "buff",
    },
}

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
-- Leave below as is

if UnitClassBase('player') ~= "SHAMAN" then return end

-- START OF GENERATED_ROTATIONS
--[[


            NAG:AutocastOtherCooldowns()
    or ((not NAG:DotIsActive(3599)) and (not NAG:AuraIsActive(2894))) and NAG:Cast(3599)
    or (NAG:CanWeave(117014)) and NAG:Cast(117014)
    or (NAG:CanWeave(403)) and NAG:Cast(403)
    or ((not NAG:DotIsActive(8050))) and NAG:Cast(73680)
    or ((not NAG:DotIsActive(8050)) and NAG:AuraIsActive(73683)) and NAG:Cast(8050)
    or ((NAG:SpellTimeToReady(17364) >= 4.0)) and NAG:Cast(114049)
    or NAG:Cast(115356)
    or NAG:Cast(17364)
    or NAG:Cast(60103)
    or ((not NAG:SpellIsReady(2894))) and NAG:Cast(2062)
    or NAG:Cast(73680)
    or ((NAG:DotRemainingTime(8050) <= 15.0) and NAG:AuraIsActive(73683)) and NAG:Cast(8050)
    or (NAG:CanWeave(421)) and NAG:Cast(421)
    or NAG:Cast(51533)
    or NAG:Cast(8042) --117014, 403, 421

    or (not(NAG:CanWeave(117014)) and NAG:AuraNumStacks(51530) < 5) and NAG:Cast(117014, nil, NAG.SPELL_POSITIONS.RIGHT)
    or (not(NAG:CanWeave(403)) and (NAG:AuraNumStacks(51530) < 5 and NAG:AuraNumStacks(51530) > 0)) and NAG:Cast(403, nil, NAG.SPELL_POSITIONS.RIGHT)
    or (not(NAG:CanWeave(421)) and NAG:AuraNumStacks(51530) < 5) and NAG:Cast(421, nil, NAG.SPELL_POSITIONS.RIGHT)



    or (NAG:SpellTimeToReady(17364) <= NAG:SpellTimeToReady(60103) and NAG:SpellTimeToReady(17364) <= NAG:SpellTimeToReady(73680) and NAG:SpellTimeToReady(17364) <= NAG:SpellTimeToReady(115356) and NAG:SpellTimeToReady(17364) <= NAG:SpellTimeToReady(8050)) and NAG:Cast(17364, 10)
    or (NAG:SpellTimeToReady(60103) <= NAG:SpellTimeToReady(73680) and NAG:SpellTimeToReady(60103) <= NAG:SpellTimeToReady(115356) and NAG:SpellTimeToReady(60103) <= NAG:SpellTimeToReady(8050)) and NAG:Cast(60103, 10)
    or (NAG:SpellTimeToReady(73680) <= NAG:SpellTimeToReady(115356) and NAG:SpellTimeToReady(73680) <= NAG:SpellTimeToReady(8050)) and NAG:Cast(73680, 10)
    or (NAG:SpellTimeToReady(115356) <= NAG:SpellTimeToReady(8050)) and NAG:Cast(115356, 10)
    or (NAG:DotRemainingTime(8050) <= NAG:SpellTimeToReady(8050)) and NAG:Cast(8050, 10)


]]
local enhancementRotation = {
    -- Core identification
    name = "Shaman Enhancement",
    specIndex = 2,
    class = "SHAMAN",

    -- Required parameters
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    rotationType = ns.ROTATION_TYPES.CUSTOM,  -- Handles both ST and AOE with auto-switching


    prePull = {
        { time = -1.6, action = "NAG:Cast(51533)" }
    },
    rotationString = [[
    NAG:AutocastOtherCooldowns()
    or NAG:Cast(2894)
    or ((not NAG:IsTotemActive(3599)) and (not NAG:IsTotemActive(2894)) and
        ((NAG:SpellTimeToReady(2894) > 0) or (not NAG:SpellIsKnown(2894)))) and NAG:Cast(3599)
    or NAG:Cast(114049)
    or NAG:Cast(51533)
    or NAG:Cast(16166)
    or NAG:Cast(33697)
    or NAG:Cast(26297)
    or NAG:Cast(120668)
    or ((NAG:CanWeave(117014) and NAG:AuraNumStacks(51530) <= 5) and NAG:AuraIsActive(73683) and (NAG:DotRemainingTime(8050)) >= 15.0) and NAG:Cast(117014)
    or ((NAG:CanWeave(117014) and NAG:AuraNumStacks(51530) <= 5) and (not NAG:AuraIsActive(73683))) and NAG:Cast(117014)
    or ((NAG:UnitDistance("target") >= 9)) and NAG:Cast(73680)
    or ((NAG:CountEnemiesInRange(10) >= 3.0) and (not NAG:DotIsActive(8050)) and NAG:IsActive(73683)) and NAG:Cast(8050)
    or (NAG:CountEnemiesInRange(10) >= 3.0) and NAG:Cast(73680)
    or ((NAG:CountEnemiesInRange(10) >= 3.0) and (not NAG:DotIsActive(8050))) and NAG:Cast(8050)
    or NAG:CanWeave(421) and (NAG:AuraNumStacks(51530) >= 1.0) and (NAG:CountEnemiesInRange(10) >= 2.0) and (NAG:CountEnemiesInRange(10) <= 3.0) and NAG:Cast(421)
    or ((NAG:CountEnemiesInRange(10) >= 3.0) and NAG:DotIsActive(8050) and (NAG:DotRemainingTime(8050) <= 15)) and NAG:Cast(8050)
    or ((NAG:CountEnemiesInRange(10) >= 4.0) and (NAG:DotRemainingTime(8050) >= 10)) and NAG:Cast(60103)
    or ((NAG:CountEnemiesInRange(10) > 3.0) and NAG:DotIsActive(8050)) and NAG:Cast(1535)
    or ((NAG:CountEnemiesInRange(10) > 3.0) and ((NAG:TimeToReady(1535) > 1) or (NAG:TimeToReady(60103) > 1))) and NAG:Cast(73680)
    or NAG:CanWeave(421) and (NAG:AuraNumStacks(51530) >= 1.0) and (NAG:CountEnemiesInRange(10) >= 2.0) and NAG:Cast(421)
    or ((NAG:CountEnemiesInRange(10) >= 4.0) and NAG:DotIsActive(8050) and (NAG:DotRemainingTime(8050) >= 10)) and NAG:Cast(60103)
    or ((NAG:CountEnemiesInRange(10) == 3.0) and NAG:DotIsActive(8050) and (NAG:DotRemainingTime(8050) >= 10)) and NAG:Cast(60103)
    or (NAG:CountEnemiesInRange(10) == 3.0) and NAG:DotIsActive(8050) and NAG:Cast(1535)
    or ((NAG:CountEnemiesInRange(10) >= 3.0) and ((NAG:TimeToReady(1535) > 1) or (NAG:TimeToReady(60103) > 1))) and NAG:Cast(73680)
    or ((NAG:AuraNumStacks(51530) == 5.0) and (NAG:CountEnemiesInRange(10) >= 2.0)) and NAG:Cast(421)
    or (NAG:CanWeave(403) and NAG:AuraNumStacks(51530) < 5) and NAG:Cast(403)
    or (NAG:AuraNumStacks(51530) == 5) and NAG:Cast(403)
    or ((not NAG:DotIsActive(8050)) and NAG:AuraIsActive(73683)) and NAG:Cast(8050)
    or NAG:Cast(115357)
    or ((NAG:SpellTimeToReady(17364) >= 4.0)) and NAG:Cast(114049)
    or NAG:Cast(17364)
    or ((NAG:DotRemainingTime(8050) <= 20.0) and NAG:AuraIsActive(73683)) and NAG:Cast(8050)
    or (NAG:CountEnemiesInRange(10) <= 2.0) and NAG:Cast(60103)
    or NAG:Cast(60103)
    or NAG:Cast(73680)
    or ((not NAG:IsTotemActive(2894))) and NAG:Cast(2062)
    or (NAG:DotRemainingTime(8050) >= 5.0) and NAG:Cast(8042)

    ]],

    -- New action-based format

    -- Tracked IDs for optimization
    spells = {403, 421, 2062, 2894, 3599, 8042, 8050, 17364, 51530, 51533, 60103, 73680, 73683, 115356, 117014},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {71155, 41533, 41530},
    author = "Jeb and Fonsas"
}


--[[               NAG:NumberTargets() > 3 and NAG:Cast(114074, nil, NAG.SPELL_POSITIONS.RIGHT)
        or NAG:NumberTargets() > 3 and NAG:Cast(421, nil, NAG.SPELL_POSITIONS.RIGHT)
            or ((NAG:NumberTargets() >= 2 and NAG:CurrentManaPercent() <= 0.7)) and NAG:Cast(30823, nil, NAG.SPELL_POSITIONS.LEFT)
    or (NAG:AuraIsKnown(117012) and NAG:AuraIsActive(77762)) and NAG:Cast(73680)
        or (NAG:NumberTargets() >= 2 and NAG:DotRemainingTime(8050) > NAG:SpellCastTime(51505)) and NAG:Cast(51505, nil, NAG.SPELL_POSITIONS.RIGHT)
        or NAG:NumberTargets() >= 2 and NAG:DotIsActive(8050) and NAG:ShouldMultidot(8050, 2, 2.0) and NAG:Cast(8050, nil, NAG.SPELL_POSITIONS.RIGHT)
        or (NAG:NumberTargets() >= 2 and NAG:AuraNumStacks(51530) == 7) and NAG:Cast(8042, nil, NAG.SPELL_POSITIONS.RIGHT)
        or NAG:NumberTargets() >= 2 and NAG:Cast(114074, nil, NAG.SPELL_POSITIONS.RIGHT)
        or NAG:NumberTargets() >= 2 and NAG:Cast(421, nil, NAG.SPELL_POSITIONS.RIGHT)
            or NAG:NumberTargets() >= 2 and NAG:Cast(421, nil, NAG.SPELL_POSITIONS.RIGHT)
    or NAG:Cast(120668, nil, NAG.SPELL_POSITIONS.LEFT)
    or (NAG:CurrentTime() < 5) and NAG:Cast(16166)
    or ((NAG:RemainingTime() <= 26) or (NAG:AuraIsActive(16166) and (NAG:RemainingTime() <= 105)) or (NAG:AuraIsActive(16166) and (NAG:SpellTimeToReady(114049) <= 10)) or (NAG:AuraIsActive(16166) and NAG:AuraIsActive(114049)) or NAG:AuraIsActive(114049)) and NAG:Cast(76093)
    or ((NAG:SpellTimeToReady(114049) >= 85.0) or (NAG:SpellTimeToReady(114049) <= 4)) and NAG:Cast(16166)
    or (NAG:DotRemainingTime(8050) > NAG:SpellCastTime(51505)) and NAG:Cast(51505)
    or (NAG:DotRemainingTime(8050) > 15) and NAG:Cast(114049)
    or (NAG:DotRemainingTime(8050) < 2) and NAG:Cast(8050)
    or NAG:SpellIsKnown(117014) and NAG:Cast(117014)
    or ((not NAG:AuraIsActive(2894)) and (not NAG:DotIsActive(3599))) and NAG:Cast(3599, nil, NAG.SPELL_POSITIONS.BELOW)
    or (NAG:AuraNumStacks(324) >= 7) and NAG:Cast(8042)
    or (((not NAG:AuraIsActive(2894)) and (NAG:RemainingTime() >= 5) and (NAG:SpellTimeToReady(114049) <= 20)) or (NAG:RemainingTime() <= 62)) and NAG:Cast(2062, nil, NAG.SPELL_POSITIONS.LEFT)
    or NAG:Cast(403)
    ]]

-- Generic (0 spec / no spec selected): low-level abilities before choosing a spec
local genericRotation = {
    name = "Generic",
    specIndex = 0,
    class = "SHAMAN",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    rotationString = [[
    (NAG:GetClassSetting('recommendSelfHeal', true) and (NAG:CurrentHealthPercent() < (NAG:GetClassSetting('selfHealThreshold', 0.35) or 0.35)) and NAG:SpellCanCast(331)) and NAG:Cast(331)
    or (not NAG:AuraIsActive(324)) and NAG:SpellCanCast(324) and NAG:Cast(324)
    or (not NAG:AuraIsActive(23575)) and NAG:SpellCanCast(23575) and NAG:Cast(23575)
    or (NAG:SpellCanCast(8050) and (not NAG:DotIsActive(8050, "target"))) and NAG:Cast(8050)
    or (NAG:SpellCanCast(403)) and NAG:Cast(403)
    or (NAG:SpellCanCast(331)) and NAG:Cast(331)
]],
}

local elementalSTRotation = {
    -- Core identification
    name = "Elemental ST",
    specIndex = 1,
    class = "SHAMAN",

    -- Required parameters
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    rotationType = ns.ROTATION_TYPES.SINGLE_TARGET,  -- Specifically designed for single target
    enableSmartSwitching = true,

    -- Custom conditions for smart switching
    customConditions = {
        {
            type = ns.CUSTOM_CONDITION_TYPES.TARGET_COUNT,
            value = { value = 1, operator = "eq" },  -- Optimal for 1 target
            range = 10  -- Use 10-yard range for elemental abilities
        }
    },

    prePull = {
        { time = -3.2, action = "NAG:Cast(2894)" },  -- Fire Elemental Totem
        { time = -1.7, action = "NAG:Cast(76093)" }, -- Potion
        { time = -1.7, action = "NAG:Cast(117014)" }, -- Elemental Blast (if talented)
        { time = -1.7, action = "NAG:Cast(403)" }  -- Lightning Bolt prepull
    },
    lastModified = "11/12/2025",
    rotationString = [[
-- Unleash Elements: cast if Unleashed Fury talent is known
NAG:AuraIsKnown(117012) and NAG:Cast(73680)

-- Stormlash Totem: cast if known and available
or NAG:AuraIsKnown(120668) and NAG:Cast(120668)

-- Stormlash Totem: ensure uptime if neither Stormlash nor Ascendance is active
or ((not NAG:AuraIsActive(120668, "player", false)) and (not NAG:AuraIsActive(114049, "player", false))) and NAG:Cast(120668)

-- Other big cooldowns (trinkets, racials, on-use)
or NAG:AutocastOtherCooldowns()

-- Pre-pull / early Elemental Mastery to frontload damage
or (NAG:CurrentTime() < 5) and NAG:Cast(16166)

-- Potion usage windows tied to Ascendance timings
or ((NAG:RemainingTime() <= 26) or (NAG:AuraIsActive(16166, "player", false) and (NAG:RemainingTime() <= 105)) or (NAG:AuraIsActive(16166, "player", false) and (NAG:SpellTimeToReady(114049) <= 10)) or (NAG:AuraIsActive(16166, "player", false) and NAG:AuraIsActive(114049, "player", false)) or NAG:AuraIsActive(114049, "player", false)) and NAG:Cast(76093)

-- Engineering Gloves (Synapse Springs variants): align with Ascendance/Bloodlust or when Ascendance soon
or ((NAG:AuraIsActive(114049, "player", false) or NAG:AuraIsActive(2825, "player", false) or (NAG:SpellTimeToReady(114049) <= 6.0))) and NAG:Cast(126734)
or ((NAG:AuraIsActive(114049, "player", false) or NAG:AuraIsActive(2825, "player", false) or (NAG:SpellTimeToReady(114049) <= 6.0))) and NAG:Cast(82174)
or ((NAG:AuraIsActive(114049, "player", false) or NAG:AuraIsActive(2825, "player", false) or (NAG:SpellTimeToReady(114049) <= 6.0))) and NAG:Cast(54758)

-- Elemental Mastery timing: either very soon or far away from Ascendance
or ((NAG:SpellTimeToReady(114049) >= 85.0) or (NAG:SpellTimeToReady(114049) <= 4)) and NAG:Cast(16166)

-- Lava Burst: cast when Flame Shock will be up long enough through the cast
or (NAG:DotRemainingTime(8050) > NAG:SpellCastTime(51505)) and NAG:Cast(51505)

-- Ascendance: use with long FS remaining to align damage
or (NAG:DotRemainingTime(8050) > 15) and NAG:Cast(114049)

-- Flame Shock: refresh if < 2s remaining
or (NAG:DotRemainingTime(8050) < 2) and NAG:Cast(8050)

-- Elemental Blast: high priority when talented
or NAG:SpellIsKnown(117014) and NAG:Cast(117014)

-- Earth Shock: Fulmination dump at 7+ LS stacks, but avoid colliding with soon Ascendance/FS refresh
or ((NAG:AuraNumStacks(324, "player", true) >= 7) and (not ((NAG:DotRemainingTime(8050) <= 6.0) and (NAG:SpellTimeToReady(114049) <= 6.0)))) and NAG:Cast(8042)

-- Searing Totem: ensure totem down if FE/SLT not covering
or ((not NAG:IsTotemActive(3599)) and (not NAG:IsTotemActive(2894))) and NAG:Cast(3599)

-- Fire Elemental: timing rules
or (((NAG:RemainingTime() <= 150) and (NAG:SpellTimeToReady(114049) <= 5)) or ((NAG:RemainingTime() > 180)) or (NAG:RemainingTime() < 35)) and NAG:Cast(2894)

-- Earth Elemental: fallback when Fire Elemental is no longer active
or ((not NAG:IsTotemActive(2894)) and
    (((NAG:RemainingTime() >= 5) and NAG:InEncounter() and (NAG:SpellTimeToReady(114049) <= 20)) or
        (NAG:RemainingTime() <= 62))) and NAG:Cast(2062)

-- Lightning Bolt filler
or NAG:Cast(403)
    ]],

    -- New action-based format

    -- Tracked IDs for optimization
    spells = {324, 403, 2894, 3599, 8042, 8050, 51505, 73680, 117014, 114049, 126734, 82174, 54758},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {41539},
    author = "Smufrik"
}

local elementalAOERotation = {
    -- Core identification
    name = "Elemental AOE Multi Targets",
    specIndex = 1,
    class = "SHAMAN",

    -- Required parameters
    default = false,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    rotationType = ns.ROTATION_TYPES.AOE,  -- Specifically designed for AOE
    enableSmartSwitching = true,

    -- Custom conditions for smart switching
    customConditions = {
        {
            type = ns.CUSTOM_CONDITION_TYPES.TARGET_COUNT,
            value = { value = 4, operator = "gte" },  -- Optimal for 3+ targets
            range = 10  -- Use 10-yard range for elemental AOE abilities
        }
    },

    prePull = {
        { time = -2.5, action = "NAG:Cast(76093)" }, -- Potion
        { time = -2.5, action = "NAG:Cast(2894)" },  -- Fire Elemental Totem
        { time = -1.0, action = "NAG:Cast(421)" }    -- Chain Lightning prepull
    },
    lastModified = "11/12/2025",
    rotationString = [[
-- Cooldowns first in AOE
NAG:AutocastOtherCooldowns()

-- Elemental Blast near top when talented
or NAG:SpellIsKnown(117014) and NAG:Cast(117014)

-- Potion usage windows aligned to Ascendance for AOE
or ((NAG:RemainingTime() <= 26) or (NAG:AuraIsKnown(16166) and NAG:AuraIsActive(16166, "player", false) and (NAG:RemainingTime() <= 105)) or (NAG:AuraIsKnown(16166) and NAG:AuraIsActive(16166, "player", false) and (NAG:SpellTimeToReady(114049) <= 10)) or (NAG:AuraIsKnown(16166) and NAG:AuraIsActive(16166, "player", false) and NAG:AuraIsActive(114049, "player", false)) or NAG:AuraIsActive(114049, "player", false)) and NAG:Cast(76093)

-- Ascendance for AOE burst (114049 = Ascendance; 114074 = Lava Beam, only during Ascendance)
or NAG:Cast(114049)

-- Lava Beam during Ascendance (replaces Chain Lightning; only castable when Ascendance buff active)
or (NAG:AuraIsActive(114049, "player", false) or NAG:AuraIsActive(114051, "player", false)) and NAG:Cast(114074)

-- Searing Totem: ensure totem down if Fire Elemental not covering
or ((not NAG:IsTotemActive(3599)) and (not NAG:IsTotemActive(2894)) and
    ((NAG:SpellTimeToReady(2894) > 0) or (not NAG:SpellIsKnown(2894)))) and NAG:Cast(3599)

-- Fire Elemental: timing rules (same as ST)
or (((NAG:RemainingTime() <= 150) and (NAG:SpellTimeToReady(114049) <= 5)) or ((NAG:RemainingTime() > 180)) or (NAG:RemainingTime() < 35)) and NAG:Cast(2894)

-- Earth Elemental: fallback when Fire Elemental is no longer active
or ((not NAG:IsTotemActive(2894)) and
    (((NAG:RemainingTime() >= 5) and NAG:InEncounter() and (NAG:SpellTimeToReady(114049) <= 20)) or
        (NAG:RemainingTime() <= 62))) and NAG:Cast(2062)

-- Chain Lightning spam baseline AOE (when not in Ascendance)
or NAG:Cast(421)
    ]],

    -- New action-based format

    -- Tracked IDs for optimization
    spells = {2894, 3599, 421, 117014, 114049, 114074, 16166, 2062, 76093},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {41539},
    author = "Smufrik"
}


local elementalCleaveRotation = {
    -- Core identification
    name = "Elemental Cleave",
    specIndex = 1,
    class = "SHAMAN",

    -- Required parameters
    default = false,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    rotationType = ns.ROTATION_TYPES.AOE,  -- Specifically designed for AOE
    enableSmartSwitching = true,

    -- Custom conditions for smart switching
    customConditions = {
        {
            type = ns.CUSTOM_CONDITION_TYPES.TARGET_COUNT,
            value = { min = 2,  max = 3, operator = "range" },  -- Optimal for 2+ targets
            range = 10  -- Use 10-yard range for elemental AOE abilities
        }
    },

    prePull = {
        { time = -3.2, action = "NAG:Cast(2894)" },  -- Fire Elemental Totem
        { time = -1.7, action = "NAG:Cast(76093)" }, -- Potion
        { time = -1.7, action = "NAG:Cast(117014)" }, -- Elemental Blast (if talented)
        { time = -1.7, action = "NAG:Cast(421)" }   -- Chain Lightning prepull
    },
    lastModified = "11/12/2025",
    rotationString = [[
-- Mana CD: Shamanistic Rage at low mana in cleave contexts
((NAG:CurrentManaPercent() <= 0.7)) and NAG:Cast(30823)

-- Unleash Elements: prefer when Unleash Flame (77762) is active
or (NAG:AuraIsKnown(117012) and NAG:AuraIsActive(77762, "player", true)) and NAG:Cast(73680)

-- Stormlash Totem on cooldown
or NAG:Cast(120668)

-- Other cooldowns
or NAG:AutocastOtherCooldowns()

-- Early Elemental Mastery usage
or (NAG:CurrentTime() < 5) and NAG:Cast(16166)

-- Potion usage rules for cleave
or ((NAG:RemainingTime() <= 26) or (NAG:AuraIsKnown(16166) and NAG:AuraIsActive(16166, "player", false) and (NAG:RemainingTime() <= 105)) or (NAG:AuraIsKnown(16166) and NAG:AuraIsActive(16166, "player", false) and (NAG:SpellTimeToReady(114049) <= 10)) or (NAG:AuraIsActive(16166, "player", false) and NAG:AuraIsActive(114049, "player", false)) or NAG:AuraIsActive(114049, "player", false)) and NAG:Cast(76093)

-- Engineering Gloves for cleave alignment
or ((NAG:AuraIsActive(114049, "player", false) or NAG:AuraIsActive(2825, "player", false) or (NAG:SpellTimeToReady(114049) <= 6.0))) and NAG:Cast(126734)
or ((NAG:AuraIsActive(114049, "player", false) or NAG:AuraIsActive(2825, "player", false) or (NAG:SpellTimeToReady(114049) <= 6.0))) and NAG:Cast(82174)
or ((NAG:AuraIsActive(114049, "player", false) or NAG:AuraIsActive(2825, "player", false) or (NAG:SpellTimeToReady(114049) <= 6.0))) and NAG:Cast(54758)

-- Elemental Mastery timing: either very soon or far away from Ascendance (optimized from wowsims)
or ((NAG:SpellTimeToReady(114049) >= 85.0) or ((NAG:SpellTimeToReady(114049) <= 4))) and NAG:Cast(16166)

-- Lava Burst when Unleash Flame buff is present (optimized from wowsims)
or NAG:AuraIsActive(77762, "player", true) and NAG:Cast(51505)

-- Searing Totem safety net
    or ((not NAG:IsTotemActive(3599)) and (not NAG:IsTotemActive(2894)) and
        ((NAG:SpellTimeToReady(2894) > 0) or (not NAG:SpellIsKnown(2894)))) and NAG:Cast(3599)

-- Flame Shock application and multidot handling (optimized from wowsims: max 2 dots, 2s overlap)
or (not NAG:DotIsActive(8050)) and NAG:Cast(8050)
or (NAG:DotIsActive(8050) and NAG:ShouldMultidot(8050, 2, 2.0)) and NAG:Cast(8050, nil, NAG.SPELL_POSITIONS.RIGHT)

-- Lava Burst if FS lasts through the cast
or (NAG:DotRemainingTime(8050) > NAG:SpellCastTime(51505)) and NAG:Cast(51505)

-- Elemental Blast if talented
or NAG:SpellIsKnown(117014) and NAG:Cast(117014)

-- Ascendance usage
or NAG:Cast(114049)

-- Earth Shock dump with 6+ LS stacks and safe FS duration (optimized from wowsims: 6 stacks for cleave)
or ((NAG:AuraNumStacks(324, "player", true) >= 6) and (NAG:DotRemainingTime(8050) >= 8) and (NAG:DotRemainingTime(8050) >= 8)) and NAG:Cast(8042)

-- Fire Elemental: timing rules (optimized from wowsims)
or (((NAG:RemainingTime() <= 150) and (NAG:SpellTimeToReady(114049) <= 5)) or ((NAG:RemainingTime() > 180)) or (NAG:RemainingTime() < 35)) and NAG:Cast(2894)

-- Earth Elemental: fallback when Fire Elemental is no longer active
or ((not NAG:IsTotemActive(2894)) and
    (((NAG:RemainingTime() >= 5) and NAG:InEncounter() and (NAG:SpellTimeToReady(114049) <= 20)) or
        (NAG:RemainingTime() <= 62))) and NAG:Cast(2062)

-- Thunderstorm for mana if very low
or (NAG:CurrentManaPercent() <= 0.15) and NAG:Cast(51490)

-- Chain Lightning / filler
or NAG:Cast(421)
or NAG:Cast(403)
    ]],

    -- New action-based format

    -- Tracked IDs for optimization
    spells = {324, 403, 2894, 3599, 8042, 8050, 51505, 73680, 117014, 114049, 16166, 2062, 30823, 51490, 120668, 77762, 126734, 82174, 54758},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {41539},
    author = "Smufrik"
}

-- Restoration (spec 3): mouseover-based healing; uses NAG.state.healing from HealingStateManager (MoP)
local restorationRotation = {
    name = "Restoration",
    description = "Mouseover healing: Riptide, Earth Shield, Chain Heal, Healing Wave.",
    enabled = true,
    default = true,
    devOnly = false,
    spells = { 331, 403, 61295, 974, 1064, 73680, 73920, 77472 },
    items = {},
    auras = {},
    runes = {},
    lastModified = "02/01/2026",
    rotationString = [[
 -- Riptide on low mouseover (or moving); prefer when not already buffed
(NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 90 and (not NAG:MouseoverHasBuff(61295)) and NAG:UnitIsMoving("player")) and NAG:Cast(61295)
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 85 and (not NAG:MouseoverHasBuff(61295))) and NAG:Cast(61295)
-- Earth Shield on mouseover tank/ low HP, never on self
or (NAG:MouseoverFriendlyExists() and (not NAG:MouseoverIsSelf()) and (NAG:MouseoverIsTank() or NAG:MouseoverHealthPercent() < 70) and (NAG:MouseoverBuffRemains(974) < 3 or not NAG:MouseoverHasBuff(974))) and NAG:Cast(974)
-- Unleash Elements (Unleash Life) before big heals when talented
or NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 60 and NAG:SpellIsKnown(73680) and NAG:Cast(73680)
-- Chain Heal when multiple need healing
or (NAG:LowHealthMemberCount(80) >= 2) and NAG:Cast(1064)
-- Healing Rain when 3+ need healing
or (NAG:LowHealthMemberCount(85) >= 3) and NAG:SpellIsKnown(73920) and NAG:Cast(73920)
-- Greater Healing Wave on critical mouseover
or NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 40 and NAG:Cast(77472)
-- Healing Wave filler on mouseover
or NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 90 and NAG:Cast(331)
-- Damage filler when nothing to heal (no mouseover or everyone full)
or NAG:Cast(403)

]],
    author = "Smufrik",
}

--- @class Shaman : ClassBase
local Shaman = NAG:CreateClassModule("SHAMAN", defaults)
if not Shaman then return end

function Shaman:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 0, genericRotation)  -- Generic (no spec)
    ns.AddRotationToDefaults(self.defaults, 2, enhancementRotation)  -- Enhancement
    ns.AddRotationToDefaults(self.defaults, 1, elementalSTRotation)  -- Elemental
    ns.AddRotationToDefaults(self.defaults, 1, elementalCleaveRotation)  -- Elemental
    ns.AddRotationToDefaults(self.defaults, 1, elementalAOERotation)  -- Elemental
    ns.AddRotationToDefaults(self.defaults, 3, restorationRotation)  -- Restoration
end


function Shaman:RegisterSpellTracking()
    local SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
    end

local BaseGetOptions = Shaman.GetOptions
function Shaman:GetOptions()
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

NAG.Class = Shaman
