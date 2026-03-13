local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version

local defaults = ns.InitializeClassDefaults()

-- Wrath Rogue spec spell locations
defaults.class.specSpellLocations = {
    [1] = {},  -- Assassination
    [2] = {},  -- Combat
    [3] = {},  -- Subtlety
}

if UnitClassBase('player') ~= "ROGUE" then return end

-- Generic (0 talent points): low-level abilities before choosing a spec
local genericRotation = {
    name = "Generic",
    specIndex = 0,
    class = "ROGUE",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[
    (NAG:CurrentComboPoints() >= 4 and NAG:SpellCanCast(2098)) and NAG:Cast(2098)
    or (NAG:SpellCanCast(1752)) and NAG:Cast(1752)
]],
}

-- Assassination Rotation
local assassinationRotation = {
    -- Core identification
    name = "Assassination",
    specIndex = 1,
    class = "ROGUE",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[NAG:Cast(6603)]],
}

-- Combat Rotation
local combatRotation = {
    -- Core identification
    name = "Combat",
    specIndex = 2,
    class = "ROGUE",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[NAG:Cast(6603)]],
}

-- Subtlety Rotation
local subtletyRotation = {
    -- Core identification
    name = "Subtlety",
    specIndex = 3,
    class = "ROGUE",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[NAG:Cast(6603)]],
}

--- @class Rogue : ClassBase
local Rogue = NAG:CreateClassModule("ROGUE", defaults)
if not Rogue then return end

function Rogue:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 0, genericRotation)  -- Generic (no talents)
    ns.AddRotationToDefaults(self.defaults, 1, assassinationRotation)  -- Assassination
    ns.AddRotationToDefaults(self.defaults, 2, combatRotation)  -- Combat
    ns.AddRotationToDefaults(self.defaults, 3, subtletyRotation)  -- Subtlety
end

NAG.Class = Rogue

