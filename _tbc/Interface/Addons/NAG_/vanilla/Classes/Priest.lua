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

if UnitClassBase('player') ~= "PRIEST" then return end

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
--- @class PRIEST : ClassBase
local PRIEST = NAG:CreateClassModule("PRIEST", defaults)
if not PRIEST then return end

function PRIEST:SetupClassDefaults()
    -- No rotations defined yet
end

-- Override RegisterSpellTracking to set up class-specific spell tracking
function PRIEST:RegisterSpellTracking()
    local SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
    --- @type SpellTrackingManager|CoreModule

        -- No spell tracking registrations needed
end

NAG.Class = PRIEST
