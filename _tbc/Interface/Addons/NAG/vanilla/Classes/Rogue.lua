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

if UnitClassBase('player') ~= "ROGUE" then return end

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
        id = "expose_armor",
        name = "Expose Armor",
        description = "Apply armor reduction debuff on targets (conflicts with Warrior Sunder Armor)",
        spellIds = {8647, 8649, 8650, 11197, 11198}, -- All ranks (Vanilla uses up to rank 5)
        category = "debuff",
    },
}
-- Rogue Backstab Rotation
local backstabRotation = {
    name = "Rogue Default - Phase 1 backstab by APLParser",
    specIndex = 3,
    class = "ROGUE",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA,
    prePull = {

    },
    rotationString = [[
    ((((NAG:CurrentComboPoints() >= 1.0) and (not NAG:IsActive(6774)) and (NAG:RemainingTime() >= 6.0)) or ((NAG:CurrentComboPoints() >= 5.0) and (NAG:AuraRemainingTime(6774) < 3.0) and (NAG:RemainingTime() > 9.0))) and NAG:Cast(6774))
    or     (((NAG:CurrentEnergy() < 59.0) and (NAG:TimeToEnergyTick() < 1.0)) and NAG:Cast(13750))
    or     (NAG:IsActive(6774) and NAG:AutocastOtherCooldowns())
    or     (((NAG:CurrentComboPoints() >= 5.0) and (NAG:IsActive(6774) or (NAG:CurrentEnergy() >= 79.0) or (NAG:RemainingTime() < 6.0))) and NAG:Cast(11300))
    or     NAG:Cast(11281)
    ]],
    -- Optional metadata
    glyphs = {},
    lastModified = "04/01/2025",
    author = "APLParser"
}

-- Rogue Sinister Strike Rotation
local sinisterStrikeRotation = {
    name = "Rogue Default - Phase 1 sinister strike by APLParser",
    specIndex = 3,
    class = "ROGUE",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA,
    prePull = {

    },
    rotationString = [[
    ((((NAG:CurrentComboPoints() >= 1.0) and (not NAG:IsActive(6774)) and (NAG:RemainingTime() >= 6.0)) or ((NAG:CurrentComboPoints() >= 5.0) and (NAG:AuraRemainingTime(6774) < 3.0) and (NAG:RemainingTime() > 9.0))) and NAG:Cast(6774))
    or     (((NAG:CurrentEnergy() < 59.0) and (NAG:TimeToEnergyTick() < 1.0)) and NAG:Cast(13750))
    or     (NAG:IsActive(6774) and NAG:AutocastOtherCooldowns())
    or     (((NAG:CurrentComboPoints() >= 5.0) and (NAG:IsActive(6774) or (NAG:CurrentEnergy() >= 79.0) or (NAG:RemainingTime() < 6.0))) and NAG:Cast(11300))
    or     NAG:Cast(11294)
    ]],
    -- Optional metadata
    glyphs = {},
    lastModified = "04/01/2025",
    author = "APLParser"
}

-- Rogue IEA Rotation
local ieaRotation = {
    name = "Rogue Default - Iea by APLParser",
    specIndex = 3,
    class = "ROGUE",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA,
    prePull = {
        { time = 1, action = "NAG:Cast(13750)" }
    },
    rotationString = [[
    (((NAG:CurrentEnergy() <= 29.0) and (NAG:CurrentComboPoints() < 5.0) and (NAG:DotRemainingTime(11198) <= 6.0) and (NAG:TimeToEnergyTick() > 1.0) and (not NAG:IsActive(13750))) and NAG:Cast(7676))
    or     (((NAG:DotRemainingTime(11198) < 3.0) and (NAG:CurrentComboPoints() >= 5.0) and (NAG:RemainingTime() >= 3.0)) and NAG:Cast(11198))
    or     ((((NAG:CurrentComboPoints() >= 1.0) and (not NAG:IsActive(6774)) and (NAG:RemainingTime() >= 6.0) and NAG:DotIsActive(11198)) or ((NAG:CurrentComboPoints() >= 5.0) and (NAG:AuraRemainingTime(6774) < 3.0) and (NAG:RemainingTime() > 9.0) and (NAG:DotRemainingTime(11198) > 15.0))) and NAG:Cast(6774))
    or     (((NAG:CurrentEnergy() < 59.0) and (NAG:TimeToEnergyTick() < 1.0)) and NAG:Cast(13750))
    or     (NAG:IsActive(6774) and NAG:AutocastOtherCooldowns())
    or     (((NAG:CurrentComboPoints() >= 5.0) and (NAG:IsActive(6774) or (NAG:CurrentEnergy() >= 79.0) or (NAG:RemainingTime() < 6.0)) and (NAG:DotRemainingTime(11198) > 15.0)) and NAG:Cast(11300))
    or     NAG:Cast(11294)
    ]],
    -- Optional metadata
    glyphs = {},
    lastModified = "04/01/2025",
    author = "APLParser"
}

--- @class ROGUE : ClassBase
local ROGUE = NAG:CreateClassModule("ROGUE", defaults)
if not ROGUE then return end

function ROGUE:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 3, backstabRotation)
    ns.AddRotationToDefaults(self.defaults, 3, sinisterStrikeRotation)
    ns.AddRotationToDefaults(self.defaults, 3, ieaRotation)
end

-- Override RegisterSpellTracking to set up class-specific spell tracking
function ROGUE:RegisterSpellTracking()
    local SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
    --- @type SpellTrackingManager|CoreModule

        -- No spell tracking registrations needed
end

if not ROGUE then return end
NAG.Class = ROGUE
