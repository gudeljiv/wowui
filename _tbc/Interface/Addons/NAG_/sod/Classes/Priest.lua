local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = ns.NAG
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
if not Version:IsSoD() then return end

if UnitClassBase('player') ~= "PRIEST" then return end

-- ============================ CONSTANTS ============================

-- Initialize defaults
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
        id = "power_word_fortitude",
        name = "Power Word: Fortitude",
        description = "Provide stamina buff to raid (coordinate with other Priests)",
        spellIds = {1243, 1244, 1245, 2791, 10937, 10938}, -- All ranks
        category = "buff",
    },
    {
        id = "shadow_protection",
        name = "Shadow Protection / Prayer of Shadow Protection",
        description = "Provide shadow resistance buff to raid (coordinate with other Priests)",
        spellIds = {976, 10957, 10958}, -- All ranks
        category = "buff",
    },
}

-- Shadow 3Min Phase8 PreRaid rotation
local shadow3MinPhase8PreRaid = {
    name = "Priest Shadow - 3Min_Phase8_PreRaid by APLParser",
    specIndex = 3,
    class = "PRIEST",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(15473)" },
        { time = -5.0, action = "NAG:Cast(402799)" }
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or (not NAG:DotIsActive(425204)) and NAG:Cast(425204)
    or (not NAG:DotIsActive(10894)) and NAG:Cast(10894)
    or (not NAG:DotIsActive(402668)) and NAG:Cast(402668)
    or NAG:SpellIsReady(10947) and NAG:Cast(10947)
    or NAG:Cast(401977)
    or NAG:ChannelSpell(18807, function() return (NAG:SpellChanneledTicks(18807) == 3) end)
    or (NAG:SpellTimeToReady(10947) >= 2) and NAG:ChannelSpell(18807, function() return (NAG:SpellChanneledTicks(18807) == 1) end)
    or NAG:Cast(431655)
        ]],

    -- Tracked IDs for optimization
    spells = {10894, 10947, 18807, 401977, 402668, 425204, 431655},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Shadow 5Min Phase8 PreRaid rotation
local shadow5MinPhase8PreRaid = {
    name = "Priest Shadow - 5Min_Phase8_PreRaid by APLParser",
    specIndex = 3,
    class = "PRIEST",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(15473)" },
        { time = -5.0, action = "NAG:Cast(402799)" }
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or (not NAG:DotIsActive(425204)) and NAG:Cast(425204)
    or (not NAG:DotIsActive(10894)) and NAG:Cast(10894)
    or (not NAG:DotIsActive(402668)) and NAG:Cast(402668)
    or NAG:SpellIsReady(10947) and NAG:Cast(10947)
    or NAG:Cast(401977)
    or NAG:ChannelSpell(18807, function() return (NAG:SpellChanneledTicks(18807) == 3) end)
    or (NAG:SpellTimeToReady(10947) >= 2) and NAG:ChannelSpell(18807, function() return (NAG:SpellChanneledTicks(18807) == 1) end)
    or NAG:Cast(431655)
        ]],

    -- Tracked IDs for optimization
    spells = {10894, 10947, 18807, 401977, 402668, 425204, 431655},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Shadow 1Target 1Min BiS Phase8 ST rotation
local shadow1Target1MinBiSPhase8ST = {
    name = "Priest Shadow - 1Target_1Min_BiS_Phase8_ST by APLParser",
    specIndex = 3,
    class = "PRIEST",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(15473)" },
        { time = -5.0, action = "NAG:Cast(402799)" }
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or (not NAG:DotIsActive(425204)) and NAG:Cast(425204)
    or (not NAG:DotIsActive(10894)) and NAG:Cast(10894)
    or (not NAG:DotIsActive(402668)) and NAG:Cast(402668)
    or NAG:Cast(231509)
    or NAG:SpellIsReady(10947) and NAG:Cast(10947)
    or NAG:AuraIsActive(456549) and NAG:Cast(18807)
    or (not NAG:AuraIsActive(231509)) and NAG:Cast(401977)
    or NAG:ChannelSpell(18807, function() return (NAG:SpellChanneledTicks(18807) == 3) end)
        ]],

    -- Tracked IDs for optimization
    spells = {10894, 10947, 18807, 401977, 402668, 425204, 456549},
    items = {231509},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Shadow 1Target 2Min BiS Phase8 ST rotation
local shadow1Target2MinBiSPhase8ST = {
    name = "Priest Shadow - 1Target_2Min_BiS_Phase8_ST by APLParser",
    specIndex = 3,
    class = "PRIEST",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(15473)" },
        { time = -5.0, action = "NAG:Cast(402799)" }
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or (not NAG:DotIsActive(425204)) and NAG:Cast(425204)
    or (not NAG:DotIsActive(10894)) and NAG:Cast(10894)
    or (not NAG:DotIsActive(402668)) and NAG:Cast(402668)
    or NAG:Cast(231509)
    or NAG:SpellIsReady(10947) and NAG:Cast(10947)
    or NAG:AuraIsActive(456549) and NAG:Cast(18807)
    or (not NAG:AuraIsActive(231509)) and NAG:Cast(401977)
    or NAG:ChannelSpell(18807, function() return (NAG:SpellChanneledTicks(18807) == 3) end)
        ]],

    -- Tracked IDs for optimization
    spells = {10894, 10947, 18807, 401977, 402668, 425204, 456549},
    items = {231509},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Shadow 1Target 3Min BiS Phase8 ST rotation
local shadow1Target3MinBiSPhase8ST = {
    name = "Priest Shadow - 1Target_3Min_BiS_Phase8_ST by APLParser",
    specIndex = 3,
    class = "PRIEST",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(15473)" },
        { time = -5.0, action = "NAG:Cast(402799)" }
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or (not NAG:DotIsActive(425204)) and NAG:Cast(425204)
    or (not NAG:DotIsActive(10894)) and NAG:Cast(10894)
    or (not NAG:DotIsActive(402668)) and NAG:Cast(402668)
    or NAG:Cast(231509)
    or NAG:SpellIsReady(10947) and NAG:Cast(10947)
    or NAG:AuraIsActive(456549) and NAG:Cast(18807)
    or (not NAG:AuraIsActive(231509)) and NAG:Cast(401977)
    or NAG:ChannelSpell(18807, function() return (NAG:SpellChanneledTicks(18807) == 3) end)
        ]],

    -- Tracked IDs for optimization
    spells = {10894, 10947, 18807, 401977, 402668, 425204, 456549},
    items = {231509},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

-- Shadow 2Target 1Min BiS Cleave Phase8 rotation
local shadow2Target1MinBiSCleavePhase8 = {
    name = "Priest Shadow - 2Target_1Min_BiS_Cleave_Phase8 by APLParser",
    specIndex = 3,
    class = "PRIEST",
    rotationType = "classic_era_sod",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    prePull = {
        { time = -10.0, action = "NAG:Cast(15473)" }
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or (not NAG:DotIsActive(425204)) and NAG:Cast(425204)
    or (not NAG:DotIsActive(425204)) and NAG:Cast(425204)
    or (not NAG:DotIsActive(10894)) and NAG:Cast(10894)
    or (not NAG:DotIsActive(402668)) and NAG:Cast(402668)
    or (not NAG:DotIsActive(402668)) and NAG:Cast(402668)
    or (NAG:AuraNumStacks(431655, "target") >= 2) and NAG:Cast(10947)
    or (NAG:DotRemainingTime(402668) < 6) and NAG:Cast(18807)
    or (NAG:DotRemainingTime(425204) < 6) and NAG:Cast(18807)
    or (NAG:DotRemainingTime(10894) < 9) and NAG:Cast(18807)
    or (NAG:AuraNumStacks(431655, "target") >= 2) and NAG:Cast(10947)
    or NAG:ChannelSpell(18807, function() return true end)
        ]],

    -- Tracked IDs for optimization
    spells = {10894, 10947, 18807, 402668, 425204, 431655},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {},
    lastModified = "06/12/2025",
    author = "APLParser"
}

--- @class PRIEST : ClassBase
local PRIEST = NAG:CreateClassModule("PRIEST", defaults)

--- Setup class defaults with all rotations
function PRIEST:SetupClassDefaults()
    -- Add all rotation definitions to defaults
    ns.AddRotationToDefaults(self.defaults, 3, shadow3MinPhase8PreRaid)  -- Shadow
    ns.AddRotationToDefaults(self.defaults, 3, shadow5MinPhase8PreRaid)  -- Shadow
    ns.AddRotationToDefaults(self.defaults, 3, shadow1Target1MinBiSPhase8ST)  -- Shadow
    ns.AddRotationToDefaults(self.defaults, 3, shadow1Target2MinBiSPhase8ST)  -- Shadow
    ns.AddRotationToDefaults(self.defaults, 3, shadow1Target3MinBiSPhase8ST)  -- Shadow
    ns.AddRotationToDefaults(self.defaults, 3, shadow2Target1MinBiSCleavePhase8)  -- Shadow
end

if not PRIEST then return end
NAG.Class = PRIEST
