local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
--- @type SpellTrackingManager|CoreModule

if not Version:IsClassicEra() then return end

if UnitClassBase('player') ~= "WARLOCK" then return end

--- NAG
local defaults = ns.InitializeClassDefaults()

--- Add spec-level spell locations (This needs to be done for all specs for each class at top of file)
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
        id = "curse_of_elements",
        name = "Curse of the Elements",
        description = "Apply magic vulnerability debuff (coordinate with other Warlocks - only one curse per target)",
        spellIds = {1490, 11721, 11722}, -- All ranks (Vanilla uses up to rank 3)
        category = "debuff",
    },
    {
        id = "curse_of_shadow",
        name = "Curse of Shadow",
        description = "Increase shadow and arcane damage taken (coordinate with other Warlocks)",
        spellIds = {17862, 17937}, -- All ranks
        category = "debuff",
    },
    {
        id = "curse_of_recklessness",
        name = "Curse of Recklessness",
        description = "Reduce target armor and remove fear effects (coordinate with other Warlocks)",
        spellIds = {704, 7658, 7659, 11717}, -- All ranks
        category = "debuff",
    },
}
-- Destruction Rotation
local destructionRotation = {
    name = "Warlock Default - Phase 1 destruction by APLParser",
    specIndex = 3,
    class = "WARLOCK",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA,
    prePull = {
        { time = 5, action = "NAG:Cast(18788)" },
        { time = 5, action = "NAG:Cast(18288)" }
    },
    rotationString = [[
    (((NAG:RemainingTime() >= 15) and (NAG:CurrentManaPercent() <= 75) and NAG:IsExecutePhase(35)) and NAG:Cast(NAG:GetBattlePotion()))
    or     (((NAG:RemainingTime() >= 15) and (NAG:CurrentManaPercent() <= 60) and NAG:IsExecutePhase(35)) and NAG:Cast(12662))
    or     NAG:AutocastOtherCooldowns()
    or     ((NAG:RemainingTime() <= 1.5) and NAG:Cast(18871))
    or     ((NAG:RemainingTime() <= 3.5) and NAG:Cast(17923))
    or     ((NAG:CurrentManaPercent() < 10) and NAG:Cast(11689))
    or     ((not NAG:DotIsActive(11713)) and NAG:Cast(11713))
    or     ((not NAG:DotIsActive(25311)) and NAG:Cast(25311))
    or     ((not NAG:DotIsActive(25309)) and NAG:Cast(25309))
    or     NAG:Cast(11661)
    ]],
    -- Optional metadata
    glyphs = {},
    lastModified = "04/01/2025",
    author = "APLParser"
}

--- @class WARLOCK : ClassBase
local WARLOCK = NAG:CreateClassModule("WARLOCK", defaults)
if not WARLOCK then return end

function WARLOCK:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 4, destructionRotation)
end

-- Override RegisterSpellTracking to set up class-specific spell tracking
function WARLOCK:RegisterSpellTracking()
    local SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
    --- @type SpellTrackingManager|CoreModule

        -- No spell tracking registrations needed
end

NAG.Class = WARLOCK
