local _, ns = ...
local UnitHealth = _G.UnitHealth
local UnitHealthMax = _G.UnitHealthMax
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
--- @type SpellTrackingManager|CoreModule

if not Version:IsClassicEra() then return end

if UnitClassBase('player') ~= "MAGE" then return end

local defaults = ns.InitializeClassDefaults()

defaults.class.specSpellLocations = {
    ['*'] = {
        ABOVE = {},
        BELOW = {},
        RIGHT = {},
        LEFT = {},
        AOE = {}
    },
}
-- Frost Rotation
local frostRotation = {
    name = "Mage Frost - Phase 2 by EbonHold",
    specIndex = 3,
    class = "MAGE",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA,
    prePull = {
        { time = 5.5, action = "NAG:Cast(11426)" }
    },
    rotationString = [[
    (((NAG:DotRemainingTime(12472) <= 15.22) or (NAG:CurrentTime() <= 2.20)) and NAG:Cast(12472))
    or     (((NAG:DotRemainingTime(12497) <= 15.8) or (NAG:CurrentTime() <= 6.0) or ((NAG:DotRemainingTime(12579) <= 12.74) and (NAG:RemainingTime() > 12.7))) and NAG:Cast(12472))
    or     (((NAG:CurrentSpellID() ~= 33405) and (not NAG:IsActive(12472)) and (NAG:CurrentManaPercent() < 5) and (NAG:DotRemainingTime(12497) > 10.7)) and NAG:Cast(12472))
    or     ((NAG:IsActive(12472)) and (NAG:DotRemainingTime(12579) <= 5.36) and NAG:Cast(12579))
    or     ((NAG:IsActive(12472)) and (UnitHealth("target") < (0.07 * UnitHealthMax("target"))) and (NAG:RemainingTime() > 7.0) and (NAG:CurrentMana() < 69) and NAG:Cast(12579))
    or     ((NAG:IsActive(12472)) and (NAG:DotRemainingTime(12497) <= 10.70) and NAG:Cast(12497))
    or     ((NAG:IsActive(12472)) and (UnitHealth("target") <= (0.08 * UnitHealthMax("target"))) and NAG:Cast(12579))
    or     ((NAG:DotRemainingTime(12579) <= 1.92) and NAG:Cast(12579))
    or     ((NAG:IsActive(12472)) and (NAG:IsActive(12579)) and (NAG:CurrentManaPercent() <= 75) and (UnitHealth("target") <= (0.41 * UnitHealthMax("target"))) and NAG:Cast(31687))
    or     ((NAG:DotRemainingTime(12497) <= 1.08) and NAG:Cast(8408))
    or     ((NAG:IsActive(12472)) and (NAG:CurrentManaPercent() <= 27) and (NAG:RemainingTime() >= 15.0) and (NAG:DotRemainingTime(12579) > 6.0) and (NAG:DotRemainingTime(12497) > 6.0))
    or     ((NAG:IsActive(12472)) and NAG:Cast(13141))
    or     ((not NAG:IsActive(12472)) and (NAG:DotRemainingTime(12579) <= 8.32) and NAG:Cast(12579))
    or     ((NAG:DotRemainingTime(12579) <= 5.39) and NAG:Cast(12579))
    or     ((NAG:IsActive(12472)) and (NAG:CurrentManaPercent() <= 75) and (UnitHealth("target") <= (0.41 * UnitHealthMax("target"))) and NAG:Cast(31687))
    or     ((NAG:CurrentMana() < 55) and (NAG:DotRemainingTime(12579) > 5.14) and (NAG:DotRemainingTime(12497) > 5.2) and NAG:Cast(28682))
    or     NAG:Cast(8408)
    ]],
    -- Optional metadata
    glyphs = {},
    lastModified = "04/01/2025",
    author = "EbonHold"
}

--- @class MAGE : ClassBase
local MAGE = NAG:CreateClassModule("MAGE", defaults)
if not MAGE then return end

function MAGE:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 3, frostRotation)  -- Frost
end

function MAGE:RegisterSpellTracking()
    local SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
    --- @type SpellTrackingManager|CoreModule

        -- No spell tracking registrations needed
end

NAG.Class = MAGE
