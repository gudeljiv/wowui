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

if UnitClassBase('player') ~= "SHAMAN" then return end

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
        id = "windfury_totem",
        name = "Windfury Totem",
        description = "Place totem that increases melee attack speed (coordinate with other Shamans)",
        spellIds = {8512, 10613, 10614}, -- All ranks (Vanilla uses up to rank 3)
        category = "buff",
    },
    {
        id = "grace_of_air_totem",
        name = "Grace of Air Totem",
        description = "Place totem that increases agility (coordinate with other Shamans)",
        spellIds = {8835, 10627}, -- All ranks
        category = "buff",
    },
    {
        id = "strength_of_earth_totem",
        name = "Strength of Earth Totem",
        description = "Place totem that increases strength (coordinate with other Shamans)",
        spellIds = {8075, 8160, 8161, 10442}, -- All ranks
        category = "buff",
    },
}
-- Elemental Rotation
local elementalRotation = {
    name = "Shaman Elemental - Phase 2 by EbonHold",
    specIndex = 1,
    class = "SHAMAN",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA,
    prePull = {
        { time = 2, action = "NAG:Cast(15208)" }
    },
    rotationString = [[
    (((NAG:NumberTargets() == 1.0) and (not NAG:DotIsActive(10438))) and NAG:Cast(10438))
    or     (((NAG:NumberTargets() >= 2.0) and (not NAG:DotIsActive(10587))) and NAG:Cast(10587))
    or     NAG:AutocastOtherCooldowns()
    or     NAG:Cast(10605)
    or     (NAG:IsActive(16166) and NAG:Cast(10414))
    or     ((NAG:CurrentManaPercent() >= 30) and NAG:Cast(15208))
    or     NAG:Cast(915)
    or     (false and NAG:Cast(20572))
    ]],
    -- Optional metadata
    glyphs = {},
    lastModified = "04/01/2025",
    author = "EbonHold"
}

-- Enhancement Rotation
local enhancementRotation = {
    name = "Shaman Enhancement - Phase 1 by EbonHold",
    specIndex = 2,
    class = "SHAMAN",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA,
    prePull = {
        { time = 6, action = "NAG:Cast(10442)" },
        { time = 4.5, action = "NAG:Cast(10614)" },
        { time = 3, action = "NAG:Cast(10627)" },
        { time = 1.5, action = "NAG:Cast(10438)" }
    },
    rotationString = [[
    ((not NAG:IsActive(10442)) and NAG:Cast(10442))
    or     ((NAG:AuraRemainingTime(10611) <= 1.5) and NAG:Cast(10614))
    or     ((not NAG:IsActive(10627)) and NAG:Cast(10627))
    or     NAG:AutocastOtherCooldowns()
    or     NAG:Cast(17364)
    or     (((not NAG:DotIsActive(10438)) and (NAG:RemainingTime() >= 20)) and NAG:Cast(10438))
    or     ((NAG:CurrentManaPercent() >= 50) and NAG:Cast(10414))
    ]],
    -- Optional metadata
    glyphs = {},
    lastModified = "04/01/2025",
    author = "EbonHold"
}

-- Restoration Rotation
local restorationRotation = {
    name = "Shaman Warden - Phase 1 by APLParser",
    specIndex = 3,
    class = "SHAMAN",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA,
    prePull = {
        { time = 6, action = "NAG:Cast(10442)" },
        { time = 4.5, action = "NAG:Cast(10614)" },
        { time = 3, action = "NAG:Cast(10627)" },
        { time = 1.5, action = "NAG:Cast(10438)" }
    },
    rotationString = [[
    ((not NAG:IsActive(10442)) and NAG:Cast(10442))
    -- Hide: or ((NAG:AuraRemainingTime(10611) <= 1.5) and NAG:Cast(10614))
    -- Hide: or ((not NAG:IsActive(10627)) and NAG:Cast(10627))
    or     NAG:AutocastOtherCooldowns()
    or     NAG:Cast(17364)
    or     (((not NAG:DotIsActive(10438)) and (NAG:RemainingTime() >= 20)) and NAG:Cast(10438))
    or     ((NAG:CurrentManaPercent() >= 50) and NAG:Cast(10414))
    ]],
    -- Optional metadata
    glyphs = {},
    lastModified = "04/01/2025",
    author = "APLParser"
}

--- @class SHAMAN : ClassBase
local SHAMAN = NAG:CreateClassModule("SHAMAN", defaults)
if not SHAMAN then return end

function SHAMAN:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 1, elementalRotation)  -- Elemental
    ns.AddRotationToDefaults(self.defaults, 2, enhancementRotation)  -- Enhancement
    ns.AddRotationToDefaults(self.defaults, 3, restorationRotation)  -- Restoration
end

-- Override RegisterSpellTracking to set up class-specific spell tracking
function SHAMAN:RegisterSpellTracking()
    local SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
    --- @type SpellTrackingManager|CoreModule

        -- No spell tracking registrations needed
end

NAG.Class = SHAMAN
