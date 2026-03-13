local _, ns = ...
local UnitHealth = _G.UnitHealth
local UnitHealthMax = _G.UnitHealthMax
local UnitCanAttack = _G.UnitCanAttack
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
local UnitAffectingCombat = _G.UnitAffectingCombat
--- @type NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
--- @type SpellTrackingManager|CoreModule


local CLASS_ID = 3 -- HUNTER

if not Version:IsClassicEra() then return end

if UnitClassBase('player') ~= "HUNTER" then return end

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
-- Beast Mastery Rotation
local beastMasteryRotation = {
    name = "Hunter Beast Mastery - Phase 2 by EbonHold",
    specIndex = 1,
    class = "HUNTER",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA,
    prePull = {
        { time = 5.5, action = "NAG:Cast(2825)" }
    },
    rotationString = [[
    ((UnitAffectingCombat("player") and (not NAG:IsPlayerControlled()) and (UnitCanAttack("player", "pet_target") == true)) and ((NAG:IsActive(53254) == false) and (NAG:IsActive(35346) == false)) and NAG:Cast(77769))
    or ((NAG:IsActive(53254) == false) and NAG:Cast(31674))
    or (NAG:IsActive(53254) and (NAG:IsActive(13161) == false) and NAG:Cast(13161))
    or (NAG:IsActive(13165) and NAG:Cast(13165))
    or (NAG:IsActive(53254) and (NAG:DotRemainingTime(49052) <= 9.0) and NAG:Cast(49052))
    or (NAG:IsActive(53254) and (UnitHealth("target") <= 0.25 * UnitHealthMax("target")) and NAG:Cast(49045))
    or (NAG:IsActive(53254) and NAG:SpellIsKnown(49048) and NAG:Cast(49048))
    or (NAG:IsActive(53254) and NAG:SpellIsKnown(49044) and NAG:Cast(49044))
    or (NAG:IsActive(53254) and NAG:SpellIsKnown(61846) and NAG:Cast(61846))
    or (NAG:IsActive(53254) and NAG:SpellIsKnown(30621) and NAG:Cast(30621))
    or (NAG:IsActive(53254) and NAG:SpellIsKnown(49068) and NAG:Cast(49068))
    or (NAG:IsActive(53254) and NAG:SpellIsKnown(53209) and NAG:Cast(53209))
    ]],
    -- Optional metadata
    glyphs = {},
    lastModified = "04/01/2025",
    author = "EbonHold"
}

--- @class HUNTER : ClassBase
local HUNTER = NAG:CreateClassModule("HUNTER", defaults)
if not HUNTER then return end

function HUNTER:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 1, beastMasteryRotation)  -- Beast Mastery
end

function HUNTER:ModuleEnable()
    self:Debug("HUNTER:ModuleEnable")
end

function HUNTER:RegisterSpellTracking()
    local SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
    --- @type SpellTrackingManager|CoreModule

        -- No spell tracking registrations needed
end

if not HUNTER then return end
NAG.Class = HUNTER
