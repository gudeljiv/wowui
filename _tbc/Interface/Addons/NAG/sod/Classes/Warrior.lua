-- ============================ LOCALIZE ============================

local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
if not Version:IsSoD() then return end

if UnitClassBase('player') ~= "WARRIOR" then return end

-- ============================ CONSTANTS ============================

-- ============================ MODULE DEFAULTS ============================

-- Initialize class defaults with standard structure
local defaults = ns.InitializeClassDefaults()

-- Add spec-level spell locations to defaults
defaults.class.specSpellLocations = {
    ['*'] = {
        ABOVE = {},
        BELOW = {},
        RIGHT = {},
        LEFT = {},
        AOE = {}
    },
}

-- Class assignments for raid coordination
defaults.class.classAssignments = {
    {
        id = "sunder_armor",
        name = "Sunder Armor",
        description = "Apply armor reduction debuff on targets (conflicts with Rogue Expose Armor)",
        spellIds = {7386, 7405, 8380, 11596, 11597}, -- All ranks of Sunder Armor
        category = "debuff",
    },
    {
        id = "demoralizing_shout",
        name = "Demoralizing Shout",
        description = "Reduce enemy attack power (coordinate with other Warriors)",
        spellIds = {1160, 6190, 11554, 11555, 11556}, -- All ranks
        category = "debuff",
    },
    {
        id = "thunder_clap",
        name = "Thunder Clap",
        description = "Reduce enemy attack speed (coordinate with other Warriors)",
        spellIds = {6343, 8198, 8205, 11580, 11581}, -- All ranks
        category = "debuff",
    },
}

-- ============================ ROTATION DEFINITIONS ============================

-- Warrior Fury - 3Min_DW_Phase8_PreRaid by APLParser
local furyDWRotation3Min = {
    name = "Warrior Fury - 3Min_DW_Phase8_PreRaid by APLParser",
    specIndex = 2,
    class = "WARRIOR",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -1.0, action = "NAG:Cast(2458)" },
        { time = -1.0, action = "NAG:Cast(2457)" },
        { time = -1.0, action = "NAG:Cast(12328)" },
        { time = -1.0, action = "NAG:Cast(20572)" },
        { time = -1.0, action = "NAG:Cast(25286)" }
    },
    rotationString = [[
NAG:DotIsActive(11574) and NAG:Cast(2458)
    or (NAG:AuraRemainingTime(457816) <= 3.5) and NAG:StrictSequence("foo", NAG:Cast(23894), NAG:Cast(2457))
    or NAG:Cast(2687)
    or NAG:Cast(233985)
    or NAG:Cast(16322)
    or NAG:Cast(25286)
    or NAG:AuraIsActive(426940) and NAG:Cast(13442)
    or NAG:AuraIsActive(1719) and NAG:Cast(426940)
    or NAG:AuraIsActive(426940) and NAG:Cast(236268)
    or NAG:AuraIsActive(426940) and NAG:Cast(236334)
    or ((NAG:DotRemainingTime(11574) <= 0)) and NAG:Cast(11574)
    or (NAG:AuraIsActive(1719) and (not NAG:AuraIsActive(14201))) and NAG:Cast(23894)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and NAG:AuraIsActive(1719)) and NAG:Cast(11605)
    or NAG:Cast(1719)
    or (NAG:RemainingTime() <= 49.0) and NAG:Cast(12328)
    or (NAG:RemainingTime() <= 48.0) and NAG:Cast(20572)
    or (NAG:RemainingTime() <= 48.0) and NAG:Cast(426940)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399)) and NAG:Cast(11605)
    or NAG:Cast(23894)
    or NAG:Cast(1680)
    or (NAG:AuraIsKnown(426969) and NAG:AuraIsActive(426969)) and NAG:StrictSequence("foo", NAG:Cast(2457), NAG:Cast(11585))
    or NAG:Cast(20662)
    ]],

    -- Tracked IDs for optimization
    spells = {1680, 1719, 2457, 2458, 2687, 11574, 11585, 11605, 12328, 14201, 16322, 20572, 20662, 23894, 25286, 413399, 426940, 426969, 457816},
    items = {13442, 233985, 236268, 236334},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Warrior Fury - 2H_3Min_Phase8_PreRaid by APLParser
local fury2HRotation3Min = {
    name = "Warrior Fury - 2H_3Min_Phase8_PreRaid by APLParser",
    specIndex = 2,
    class = "WARRIOR",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -2.0, action = "NAG:Cast(2457)" },
        { time = -1.0, action = "NAG:Cast(2458)" },
        { time = -1.0, action = "NAG:Cast(24427)" },
        { time = -1.0, action = "NAG:Cast(12328)" },
        { time = -1.0, action = "NAG:Cast(20572)" },
        { time = -1.0, action = "NAG:Cast(25286)" }
    },
    rotationString = [[
NAG:DotIsActive(11574) and NAG:Cast(2458)
    or NAG:Cast(236268)
    or (NAG:AuraRemainingTime(457817) <= 3.5) and NAG:StrictSequence("foo", NAG:Cast(23894), NAG:Cast(2457))
    or NAG:Cast(2687)
    or NAG:Cast(12328)
    or NAG:Cast(233985)
    or NAG:AuraIsActive(2457) and NAG:Cast(13442)
    or (NAG:RuneIsEquipped(412507) and (NAG:DotRemainingTime(11574) <= 0)) and NAG:Cast(11574)
    or NAG:Cast(1719)
    or (true) and NAG:Cast(426940)
    or ((not NAG:AuraIsActive(236268))) and NAG:Cast(236334)
    or NAG:Cast(23894)
    or ((NAG:CurrentRage() >= 0)) and NAG:Cast(25286)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and NAG:AuraIsActive(1719)) and NAG:Cast(11605)
    or NAG:AuraIsActive(1719) and NAG:Cast(429765)
    or (NAG:AuraIsKnown(426969) and NAG:AuraIsActive(426969)) and NAG:StrictSequence("foo", NAG:Cast(2457), NAG:Cast(11585))
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399)) and NAG:Cast(11605)
    or NAG:Cast(429765)
    ]],

    -- Tracked IDs for optimization
    spells = {1719, 2457, 2458, 2687, 11574, 11585, 11605, 12328, 23894, 25286, 413399, 426940, 426969, 429765, 457817},
    items = {13442, 233985, 236268, 236334},
    auras = {},
    runes = {412507},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Warrior Fury - 2H_5Min_Phase8_PreRaid by APLParser
local fury2HRotation5Min = {
    name = "Warrior Fury - 2H_5Min_Phase8_PreRaid by APLParser",
    specIndex = 2,
    class = "WARRIOR",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -2.0, action = "NAG:Cast(2457)" },
        { time = -1.0, action = "NAG:Cast(2458)" },
        { time = -1.0, action = "NAG:Cast(24427)" },
        { time = -1.0, action = "NAG:Cast(12328)" },
        { time = -1.0, action = "NAG:Cast(20572)" },
        { time = -1.0, action = "NAG:Cast(25286)" }
    },
        rotationString = [[
NAG:DotIsActive(11574) and NAG:Cast(2458)
    or NAG:Cast(236268)
    or (NAG:AuraRemainingTime(457817) <= 3.5) and NAG:StrictSequence("foo", NAG:Cast(23894), NAG:Cast(2457))
    or NAG:Cast(2687)
    or NAG:Cast(12328)
    or NAG:Cast(233985)
    or NAG:AuraIsActive(2457) and NAG:Cast(13442)
    or (NAG:RuneIsEquipped(412507) and (NAG:DotRemainingTime(11574) <= 0)) and NAG:Cast(11574)
    or NAG:Cast(1719)
    or (true) and NAG:Cast(426940)
    or ((not NAG:AuraIsActive(236268))) and NAG:Cast(236334)
    or NAG:Cast(23894)
    or ((NAG:CurrentRage() >= 0)) and NAG:Cast(25286)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and NAG:AuraIsActive(1719)) and NAG:Cast(11605)
    or NAG:AuraIsActive(1719) and NAG:Cast(429765)
    or (NAG:AuraIsKnown(426969) and NAG:AuraIsActive(426969)) and NAG:StrictSequence("foo", NAG:Cast(2457), NAG:Cast(11585))
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399)) and NAG:Cast(11605)
    or NAG:Cast(429765)
        ]],

        -- New action-based format

        -- Tracked IDs for optimization
        spells = {1719, 2457, 2458, 2687, 11574, 11585, 11605, 12328, 23894, 25286, 413399, 426940, 426969, 429765, 457817},
        items = {13442, 233985, 236268, 236334},
        auras = {},
        runes = {412507},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }

-- Fury 5Min DW Phase8 PreRaid rotation
local furyDWRotation5Min = {
    name = "Warrior Fury - 5Min_DW_Phase8_PreRaid by APLParser",
    specIndex = 2,
    class = "WARRIOR",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -1.0, action = "NAG:Cast(2458)" },
        { time = -1.0, action = "NAG:Cast(2457)" },
        { time = -1.0, action = "NAG:Cast(12328)" },
        { time = -1.0, action = "NAG:Cast(20572)" },
        { time = -1.0, action = "NAG:Cast(25286)" }
    },
        rotationString = [[
NAG:DotIsActive(11574) and NAG:Cast(2458)
    or (NAG:AuraRemainingTime(457816) <= 3.5) and NAG:StrictSequence("foo", NAG:Cast(23894), NAG:Cast(2457))
    or NAG:Cast(2687)
    or NAG:Cast(233985)
    or NAG:Cast(16322)
    or NAG:Cast(25286)
    or NAG:AuraIsActive(426940) and NAG:Cast(13442)
    or NAG:AuraIsActive(1719) and NAG:Cast(426940)
    or NAG:AuraIsActive(426940) and NAG:Cast(236268)
    or NAG:AuraIsActive(426940) and NAG:Cast(236334)
    or ((NAG:DotRemainingTime(11574) <= 0)) and NAG:Cast(11574)
    or (NAG:AuraIsActive(1719) and (not NAG:AuraIsActive(14201))) and NAG:Cast(23894)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and NAG:AuraIsActive(1719)) and NAG:Cast(11605)
    or NAG:Cast(1719)
    or (NAG:RemainingTime() <= 49.0) and NAG:Cast(12328)
    or (NAG:RemainingTime() <= 48.0) and NAG:Cast(20572)
    or (NAG:RemainingTime() <= 48.0) and NAG:Cast(426940)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399)) and NAG:Cast(11605)
    or NAG:Cast(23894)
    or NAG:Cast(1680)
    or (NAG:AuraIsKnown(426969) and NAG:AuraIsActive(426969)) and NAG:StrictSequence("foo", NAG:Cast(2457), NAG:Cast(11585))
    or NAG:Cast(20662)
        ]],

        -- New action-based format

        -- Tracked IDs for optimization
        spells = {1680, 1719, 2457, 2458, 2687, 11574, 11585, 11605, 12328, 14201, 16322, 20572, 20662, 23894, 25286, 413399, 426940, 426969, 457816},
        items = {13442, 233985, 236268, 236334},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }

-- Protection 5Min DW Phase8 PreRaid rotation
local protectionDWRotation5Min = {
    name = "Warrior Protection - 5Min_DW_Phase8_PreRaid by APLParser",
    specIndex = 3,
    class = "WARRIOR",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -1.0, action = "NAG:Cast(2458)" },
        { time = -1.0, action = "NAG:Cast(2457)" },
        { time = -1.0, action = "NAG:Cast(12328)" },
        { time = -1.0, action = "NAG:Cast(20572)" },
        { time = -1.0, action = "NAG:Cast(25286)" }
    },
        rotationString = [[
NAG:DotIsActive(11574) and NAG:Cast(2458)
    or (NAG:AuraRemainingTime(457816) <= 3.5) and NAG:StrictSequence("foo", NAG:Cast(23894), NAG:Cast(2457))
    or NAG:Cast(2687)
    or NAG:Cast(233985)
    or NAG:Cast(16322)
    or NAG:Cast(25286)
    or NAG:AuraIsActive(426940) and NAG:Cast(13442)
    or NAG:AuraIsActive(1719) and NAG:Cast(426940)
    or NAG:AuraIsActive(426940) and NAG:Cast(236268)
    or NAG:AuraIsActive(426940) and NAG:Cast(236334)
    or ((NAG:DotRemainingTime(11574) <= 0)) and NAG:Cast(11574)
    or (NAG:AuraIsActive(1719) and (not NAG:AuraIsActive(14201))) and NAG:Cast(23894)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and NAG:AuraIsActive(1719)) and NAG:Cast(11605)
    or NAG:Cast(1719)
    or (NAG:RemainingTime() <= 49.0) and NAG:Cast(12328)
    or (NAG:RemainingTime() <= 48.0) and NAG:Cast(20572)
    or (NAG:RemainingTime() <= 48.0) and NAG:Cast(426940)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399)) and NAG:Cast(11605)
    or NAG:Cast(23894)
    or NAG:Cast(1680)
    or (NAG:AuraIsKnown(426969) and NAG:AuraIsActive(426969)) and NAG:StrictSequence("foo", NAG:Cast(2457), NAG:Cast(11585))
    or NAG:Cast(20662)
        ]],

        -- New action-based format

        -- Tracked IDs for optimization
        spells = {1680, 1719, 2457, 2458, 2687, 11574, 11585, 11605, 12328, 14201, 16322, 20572, 20662, 23894, 25286, 413399, 426940, 426969, 457816},
        items = {13442, 233985, 236268, 236334},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }

-- Fury 1Target 1Min 2H BiS Phase8 ST rotation
local fury2HRotation1Min = {
    name = "Warrior Fury - 1Target_1Min_2H_BiS_Phase8_ST by APLParser",
    specIndex = 2,
    class = "WARRIOR",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -1.0, action = "NAG:Cast(12328)" },
        { time = -1.0, action = "NAG:Cast(20572)" },
        { time = -1.0, action = "NAG:Cast(25286)" }
    },
        rotationString = [[
((not NAG:DotIsActive(11574)) and NAG:RuneIsEquipped(1219970)) and NAG:Cast(11574)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and (NAG:AuraNumStacks(1227232) >= 3)) and NAG:Cast(11605)
    or (NAG:AuraIsActive(241037) and (NAG:AuraNumStacks(241037) >= 5)) and NAG:Cast(1719)
    or NAG:AutocastOtherCooldowns()
    or ((not NAG:AuraIsActive(14201)) and NAG:AuraIsActive(1719)) and NAG:Cast(23894)
    or NAG:Cast(25286)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and NAG:AuraIsActive(1719) and (NAG:AuraNumStacks(1227232) >= 5)) and NAG:Cast(11605)
    or NAG:Cast(1680)
    or ((not NAG:AuraIsActive(14201)) and (NAG:CurrentRage() >= 90)) and NAG:Cast(23894)
    or NAG:Cast(429765)
        ]],

        -- New action-based format

        -- Tracked IDs for optimization
        spells = {1680, 1719, 11574, 11605, 14201, 23894, 25286, 413399, 429765, 1227232},
        items = {241037},
        auras = {},
        runes = {1219970},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }

-- Fury 1Target 1Min BiS DW Phase8 ST rotation
local furyDWRotation1Min = {
    name = "Warrior Fury - 1Target_1Min_BiS_DW_Phase8_ST by APLParser",
    specIndex = 2,
    class = "WARRIOR",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -1.0, action = "NAG:Cast(12328)" },
        { time = -1.0, action = "NAG:Cast(20572)" },
        { time = -1.0, action = "NAG:Cast(25286)" }
    },
        rotationString = [[
((not NAG:DotIsActive(11574)) and NAG:RuneIsEquipped(1219970)) and NAG:Cast(11574)
    or ((NAG:AuraNumStacks(1231424, "target") >= 8) and (NAG:CurrentRage() >= 75)) and NAG:Cast(20662)
    or NAG:Cast(25286)
    or NAG:Cast(1680)
    or NAG:AutocastOtherCooldowns()
    or NAG:AuraIsActive(413399) and NAG:Cast(11605)
    or NAG:Cast(23894)
        ]],

        -- New action-based format

        -- Tracked IDs for optimization
        spells = {1680, 11574, 11605, 20662, 23894, 25286, 413399, 1231424},
        items = {},
        auras = {},
        runes = {1219970},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }

-- Fury 1Target 2Min 2H BiS Phase8 ST rotation
local fury2HRotation2Min = {
    name = "Warrior Fury - 1Target_2Min_2H_BiS_Phase8_ST by APLParser",
    specIndex = 2,
    class = "WARRIOR",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -1.0, action = "NAG:Cast(12328)" },
        { time = -1.0, action = "NAG:Cast(20572)" },
        { time = -1.0, action = "NAG:Cast(25286)" }
    },
    rotationString = [[
((not NAG:DotIsActive(11574)) and NAG:RuneIsEquipped(1219970)) and NAG:Cast(11574)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and (NAG:AuraNumStacks(1227232) >= 3)) and NAG:Cast(11605)
    or (NAG:AuraIsActive(241037) and (NAG:AuraNumStacks(241037) >= 5)) and NAG:Cast(1719)
    or NAG:AutocastOtherCooldowns()
    or ((not NAG:AuraIsActive(14201)) and NAG:AuraIsActive(1719)) and NAG:Cast(23894)
    or NAG:Cast(25286)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and NAG:AuraIsActive(1719) and (NAG:AuraNumStacks(1227232) >= 5)) and NAG:Cast(11605)
    or NAG:Cast(1680)
    or ((not NAG:AuraIsActive(14201)) and (NAG:CurrentRage() >= 90)) and NAG:Cast(23894)
    or NAG:Cast(429765)
        ]],

        -- New action-based format

        -- Tracked IDs for optimization
        spells = {1680, 1719, 11574, 11605, 14201, 23894, 25286, 413399, 429765, 1227232},
        items = {241037},
        auras = {},
        runes = {1219970},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }

-- Fury 1Target 2Min BiS DW Phase8 ST rotation
local furyDWRotation2Min = {
    name = "Warrior Fury - 1Target_2Min_BiS_DW_Phase8_ST by APLParser",
    specIndex = 2,
    class = "WARRIOR",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -1.0, action = "NAG:Cast(12328)" },
        { time = -1.0, action = "NAG:Cast(20572)" },
        { time = -1.0, action = "NAG:Cast(25286)" }
    },
        rotationString = [[
((not NAG:DotIsActive(11574)) and NAG:RuneIsEquipped(1219970)) and NAG:Cast(11574)
    or ((NAG:AuraNumStacks(1231424, "target") >= 8) and (NAG:CurrentRage() >= 75)) and NAG:Cast(20662)
    or NAG:Cast(25286)
    or NAG:Cast(1680)
    or NAG:AutocastOtherCooldowns()
    or NAG:AuraIsActive(413399) and NAG:Cast(11605)
    or NAG:Cast(23894)
        ]],

        -- New action-based format

        -- Tracked IDs for optimization
        spells = {1680, 11574, 11605, 20662, 23894, 25286, 413399, 1231424},
        items = {},
        auras = {},
        runes = {1219970},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }

-- Fury 1Target 3Min 2H BiS Phase8 ST rotation
local fury2HRotation3Min = {
    name = "Warrior Fury - 1Target_3Min_2H_BiS_Phase8_ST by APLParser",
    specIndex = 2,
    class = "WARRIOR",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -1.0, action = "NAG:Cast(12328)" },
        { time = -1.0, action = "NAG:Cast(20572)" },
        { time = -1.0, action = "NAG:Cast(25286)" }
    },
    rotationString = [[
((not NAG:DotIsActive(11574)) and NAG:RuneIsEquipped(1219970)) and NAG:Cast(11574)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and (NAG:AuraNumStacks(1227232) >= 3)) and NAG:Cast(11605)
    or (NAG:AuraIsActive(241037) and (NAG:AuraNumStacks(241037) >= 5)) and NAG:Cast(1719)
    or NAG:AutocastOtherCooldowns()
    or ((not NAG:AuraIsActive(14201)) and NAG:AuraIsActive(1719)) and NAG:Cast(23894)
    or NAG:Cast(25286)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and NAG:AuraIsActive(1719) and (NAG:AuraNumStacks(1227232) >= 5)) and NAG:Cast(11605)
    or NAG:Cast(1680)
    or ((not NAG:AuraIsActive(14201)) and (NAG:CurrentRage() >= 90)) and NAG:Cast(23894)
    or NAG:Cast(429765)
        ]],

        -- New action-based format

        -- Tracked IDs for optimization
        spells = {1680, 1719, 11574, 11605, 14201, 23894, 25286, 413399, 429765, 1227232},
        items = {241037},
        auras = {},
        runes = {1219970},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }

-- Fury 1Target 3Min BiS DW Phase8 ST rotation
local furyDWRotation3Min = {
    name = "Warrior Fury - 1Target_3Min_BiS_DW_Phase8_ST by APLParser",
    specIndex = 2,
    class = "WARRIOR",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -1.0, action = "NAG:Cast(12328)" },
        { time = -1.0, action = "NAG:Cast(20572)" },
        { time = -1.0, action = "NAG:Cast(25286)" }
    },
    rotationString = [[
((not NAG:DotIsActive(11574)) and NAG:RuneIsEquipped(1219970)) and NAG:Cast(11574)
    or ((NAG:AuraNumStacks(1231424, "target") >= 8) and (NAG:CurrentRage() >= 75)) and NAG:Cast(20662)
    or NAG:Cast(25286)
    or NAG:Cast(1680)
    or NAG:AutocastOtherCooldowns()
    or NAG:AuraIsActive(413399) and NAG:Cast(11605)
    or NAG:Cast(23894)
        ]],

        -- New action-based format

        -- Tracked IDs for optimization
        spells = {1680, 11574, 11605, 20662, 23894, 25286, 413399, 1231424},
        items = {},
        auras = {},
        runes = {1219970},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }

-- Fury 2H 2Target 1Min BiS Cleave Phase8 rotation
local fury2HCleaveRotation1Min = {
    name = "Warrior Fury - 2H_2Target_1Min_BiS_Cleave_Phase8 by APLParser",
    specIndex = 2,
    class = "WARRIOR",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -1.0, action = "NAG:Cast(12328)" },
        { time = -1.0, action = "NAG:Cast(20572)" },
        { time = -1.0, action = "NAG:Cast(20569)" }
    },
    rotationString = [[
((not NAG:DotIsActive(11574)) and NAG:RuneIsEquipped(1219970)) and NAG:Cast(11574)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and (NAG:AuraNumStacks(1227232) >= 3)) and NAG:Cast(11605)
    or (NAG:AuraIsActive(241037) and (NAG:AuraNumStacks(241037) >= 5)) and NAG:Cast(1719)
    or NAG:AutocastOtherCooldowns()
    or ((not NAG:AuraIsActive(14201)) and NAG:AuraIsActive(1719)) and NAG:Cast(23894)
    or NAG:Cast(20569)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and NAG:AuraIsActive(1719) and (NAG:AuraNumStacks(1227232) >= 5)) and NAG:Cast(11605)
    or NAG:Cast(1680)
    or ((not NAG:AuraIsActive(14201)) and (NAG:CurrentRage() >= 90)) and NAG:Cast(23894)
    or NAG:Cast(429765)
        ]],

        -- New action-based format

        -- Tracked IDs for optimization
        spells = {1680, 1719, 11574, 11605, 14201, 20569, 23894, 413399, 429765, 1227232},
        items = {241037},
        auras = {},
        runes = {1219970},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }

-- Fury 2Target 1Min BiS Cleave DW Phase8 rotation
local furyDWCleaveRotation1Min = {
    name = "Warrior Fury - 2Target_1Min_BiS_Cleave_DW_Phase8 by APLParser",
    specIndex = 2,
    class = "WARRIOR",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -1.0, action = "NAG:Cast(2687)" },
        { time = -1.0, action = "NAG:Cast(12328)" },
        { time = -1.0, action = "NAG:Cast(20572)" },
        { time = -1.0, action = "NAG:Cast(20569)" }
    },
    rotationString = [[
NAG:Cast(20569)
    or ((not NAG:DotIsActive(11574)) and NAG:RuneIsEquipped(1219970)) and NAG:Cast(11574)
    or NAG:AutocastOtherCooldowns()
    or NAG:DotIsActive(11574) and NAG:Cast(2458)
    or NAG:Cast(1680)
    or (NAG:AuraIsActive(1719) and (not NAG:AuraIsActive(14201))) and NAG:Cast(23894)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399)) and NAG:Cast(11605)
    or NAG:Cast(23894)
        ]],

        -- New action-based format

        -- Tracked IDs for optimization
        spells = {1680, 1719, 2458, 11574, 11605, 14201, 20569, 23894, 413399},
        items = {},
        auras = {},
        runes = {1219970},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }

-- Fury 2H 3Target 1Min BiS Cleave Phase8 rotation
local fury2HCleaveRotation3Target1Min = {
    name = "Warrior Fury - 2H_3Target_1Min_BiS_Cleave_Phase8 by APLParser",
    specIndex = 2,
    class = "WARRIOR",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -1.0, action = "NAG:Cast(12328)" },
        { time = -1.0, action = "NAG:Cast(20572)" },
        { time = -1.0, action = "NAG:Cast(20569)" }
    },
    rotationString = [[
((not NAG:DotIsActive(11574)) and NAG:RuneIsEquipped(1219970)) and NAG:Cast(11574)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and (NAG:AuraNumStacks(1227232) >= 3)) and NAG:Cast(11605)
    or (NAG:AuraIsActive(241037) and (NAG:AuraNumStacks(241037) >= 5)) and NAG:Cast(1719)
    or NAG:AutocastOtherCooldowns()
    or ((not NAG:AuraIsActive(14201)) and NAG:AuraIsActive(1719)) and NAG:Cast(23894)
    or NAG:Cast(20569)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and NAG:AuraIsActive(1719) and (NAG:AuraNumStacks(1227232) >= 5)) and NAG:Cast(11605)
    or NAG:Cast(1680)
    or ((not NAG:AuraIsActive(14201)) and (NAG:CurrentRage() >= 90)) and NAG:Cast(23894)
    or NAG:Cast(429765)
        ]],

        -- New action-based format

        -- Tracked IDs for optimization
        spells = {1680, 1719, 11574, 11605, 14201, 20569, 23894, 413399, 429765, 1227232},
        items = {241037},
        auras = {},
        runes = {1219970},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }

-- Fury 3Target 1Min BiS Cleave DW Phase8 rotation
local furyDWCleaveRotation3Target1Min = {
    name = "Warrior Fury - 3Target_1Min_BiS_Cleave_DW_Phase8 by APLParser",
    specIndex = 2,
    class = "WARRIOR",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -1.0, action = "NAG:Cast(2687)" },
        { time = -1.0, action = "NAG:Cast(12328)" },
        { time = -1.0, action = "NAG:Cast(20572)" },
        { time = -1.0, action = "NAG:Cast(20569)" }
    },
    rotationString = [[
NAG:Cast(20569)
    or ((not NAG:DotIsActive(11574)) and NAG:RuneIsEquipped(1219970)) and NAG:Cast(11574)
    or NAG:AutocastOtherCooldowns()
    or NAG:DotIsActive(11574) and NAG:Cast(2458)
    or NAG:Cast(1680)
    or (NAG:AuraIsActive(1719) and (not NAG:AuraIsActive(14201))) and NAG:Cast(23894)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399)) and NAG:Cast(11605)
    or NAG:Cast(23894)
        ]],

        -- New action-based format

        -- Tracked IDs for optimization
        spells = {1680, 1719, 2458, 11574, 11605, 14201, 20569, 23894, 413399},
        items = {},
        auras = {},
        runes = {1219970},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }

-- Fury 2H 4Target 1Min BiS Cleave Phase8 rotation
local fury2HCleaveRotation4Target1Min = {
    name = "Warrior Fury - 2H_4Target_1Min_BiS_Cleave_Phase8 by APLParser",
    specIndex = 2,
    class = "WARRIOR",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -1.0, action = "NAG:Cast(12328)" },
        { time = -1.0, action = "NAG:Cast(20572)" },
        { time = -1.0, action = "NAG:Cast(20569)" }
    },
    rotationString = [[
((not NAG:DotIsActive(11574)) and NAG:RuneIsEquipped(1219970)) and NAG:Cast(11574)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and (NAG:AuraNumStacks(1227232) >= 3)) and NAG:Cast(11605)
    or (NAG:AuraIsActive(241037) and (NAG:AuraNumStacks(241037) >= 5)) and NAG:Cast(1719)
    or NAG:AutocastOtherCooldowns()
    or ((not NAG:AuraIsActive(14201)) and NAG:AuraIsActive(1719)) and NAG:Cast(23894)
    or NAG:Cast(20569)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399) and NAG:AuraIsActive(1719) and (NAG:AuraNumStacks(1227232) >= 5)) and NAG:Cast(11605)
    or NAG:Cast(1680)
    or ((not NAG:AuraIsActive(14201)) and (NAG:CurrentRage() >= 90)) and NAG:Cast(23894)
    or NAG:Cast(429765)
        ]],

        -- New action-based format

        -- Tracked IDs for optimization
        spells = {1680, 1719, 11574, 11605, 14201, 20569, 23894, 413399, 429765, 1227232},
        items = {241037},
        auras = {},
        runes = {1219970},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }

-- Fury 4Target 1Min BiS Cleave DW Phase8 rotation
local furyDWCleaveRotation4Target1Min = {
    name = "Warrior Fury - 4Target_1Min_BiS_Cleave_DW_Phase8 by APLParser",
    specIndex = 2,
    class = "WARRIOR",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -1.0, action = "NAG:Cast(2687)" },
        { time = -1.0, action = "NAG:Cast(12328)" },
        { time = -1.0, action = "NAG:Cast(20572)" },
        { time = -1.0, action = "NAG:Cast(20569)" }
    },
    rotationString = [[
NAG:Cast(20569)
    or ((not NAG:DotIsActive(11574)) and NAG:RuneIsEquipped(1219970)) and NAG:Cast(11574)
    or NAG:AutocastOtherCooldowns()
    or NAG:DotIsActive(11574) and NAG:Cast(2458)
    or NAG:Cast(1680)
    or (NAG:AuraIsActive(1719) and (not NAG:AuraIsActive(14201))) and NAG:Cast(23894)
    or (NAG:AuraIsKnown(413399) and NAG:AuraIsActive(413399)) and NAG:Cast(11605)
    or NAG:Cast(23894)
        ]],

        -- New action-based format

        -- Tracked IDs for optimization
        spells = {1680, 1719, 2458, 11574, 11605, 14201, 20569, 23894, 413399},
        items = {},
        auras = {},
        runes = {1219970},

        -- Optional metadata
        glyphs = {},
        lastModified = "06/12/2025",
        author = "APLParser"
    }

--- @class WARRIOR : ClassBase
local WARRIOR = NAG:CreateClassModule("WARRIOR", defaults)

-- ============================ SETUP CLASS DEFAULTS ============================

-- Setup class defaults during PreDatabaseRegistration
function WARRIOR:SetupClassDefaults()
    -- ✅ Add rotations to defaults using the new system
    ns.AddRotationToDefaults(self.defaults, 2, furyDWRotation3Min)  -- furyDWRotation3Min)
    ns.AddRotationToDefaults(self.defaults, 2, fury2HRotation3Min)  -- fury2HRotation3Min)
    ns.AddRotationToDefaults(self.defaults, 2, fury2HRotation5Min)  -- fury2HRotation5Min)
    ns.AddRotationToDefaults(self.defaults, 2, furyDWRotation5Min)  -- furyDWRotation5Min)
    ns.AddRotationToDefaults(self.defaults, 3, protectionDWRotation5Min)  -- protectionDWRotation5Min)
    ns.AddRotationToDefaults(self.defaults, 2, fury2HRotation1Min)  -- fury2HRotation1Min)
    ns.AddRotationToDefaults(self.defaults, 2, furyDWRotation1Min)  -- furyDWRotation1Min)
    ns.AddRotationToDefaults(self.defaults, 2, fury2HRotation2Min)  -- fury2HRotation2Min)
    ns.AddRotationToDefaults(self.defaults, 2, furyDWRotation2Min)  -- furyDWRotation2Min)
    ns.AddRotationToDefaults(self.defaults, 2, fury2HRotation3Min)  -- fury2HRotation3Min)
    ns.AddRotationToDefaults(self.defaults, 2, furyDWRotation3Min)  -- furyDWRotation3Min)
    ns.AddRotationToDefaults(self.defaults, 2, fury2HCleaveRotation1Min)  -- fury2HCleaveRotation1Min)
    ns.AddRotationToDefaults(self.defaults, 2, furyDWCleaveRotation1Min)  -- furyDWCleaveRotation1Min)
    ns.AddRotationToDefaults(self.defaults, 2, fury2HCleaveRotation3Target1Min)  -- fury2HCleaveRotation3Target1Min)
    ns.AddRotationToDefaults(self.defaults, 2, furyDWCleaveRotation3Target1Min)  -- furyDWCleaveRotation3Target1Min)
    ns.AddRotationToDefaults(self.defaults, 2, fury2HCleaveRotation4Target1Min)  -- fury2HCleaveRotation4Target1Min)
    ns.AddRotationToDefaults(self.defaults, 2, furyDWCleaveRotation4Target1Min)  -- furyDWCleaveRotation4Target1Min)
end

if not WARRIOR then return end
NAG.Class = WARRIOR
