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

if UnitClassBase('player') ~= "PALADIN" then return end

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
        id = "blessings",
        name = "Blessings (Kings/Might/Wisdom/Salvation)",
        description = "Cast blessings on raid members (coordinate with other Paladins to cover all groups)",
        spellIds = {20217, 19740, 19742, 19834, 19835, 19836, 19837, 19838, 1038}, -- Kings, Might, Wisdom, Salvation ranks
        category = "buff",
    },
}
--- @class PALADIN : ClassBase
local PALADIN = NAG:CreateClassModule("PALADIN", defaults)
if not PALADIN then return end

function PALADIN:SetupClassDefaults()
    -- No rotations defined yet
end

-- Override RegisterSpellTracking to set up class-specific spell tracking
function PALADIN:RegisterSpellTracking()
    local SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
    --- @type SpellTrackingManager|CoreModule

        -- No spell tracking registrations needed
end

NAG.Class = PALADIN
