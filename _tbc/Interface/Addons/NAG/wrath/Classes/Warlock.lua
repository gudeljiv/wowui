local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version

local defaults = ns.InitializeClassDefaults()

-- Wrath Warlock spec spell locations
defaults.class.specSpellLocations = {
    [1] = {},  -- Affliction
    [2] = {},  -- Demonology
    [3] = {},  -- Destruction
}

if UnitClassBase('player') ~= "WARLOCK" then return end

-- Generic (0 talent points): low-level abilities before choosing a spec
local genericRotation = {
    name = "Generic",
    specIndex = 0,
    class = "WARLOCK",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[
    (not NAG:AuraIsActive(706) and not NAG:AuraIsActive(687) and not NAG:AuraIsActive(28176)) and NAG:SpellCanCast(706) and NAG:Cast(706)
    or (not NAG:AuraIsActive(687) and not NAG:AuraIsActive(706) and not NAG:AuraIsActive(28176)) and NAG:SpellCanCast(687) and NAG:Cast(687)
    or (not NAG:AuraIsActive(28176) and not NAG:AuraIsActive(706) and not NAG:AuraIsActive(687)) and NAG:SpellCanCast(28176) and NAG:Cast(28176)
    or (NAG:SpellCanCast(348) and (not NAG:DotIsActive(348, "target"))) and NAG:Cast(348)
    or (NAG:SpellCanCast(686)) and NAG:Cast(686)
]],
}

-- Affliction Rotation
local afflictionRotation = {
    -- Core identification
    name = "Affliction",
    specIndex = 1,
    class = "WARLOCK",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[NAG:Cast(6603)]],
}

-- Demonology Rotation
local demonologyRotation = {
    -- Core identification
    name = "Demonology",
    specIndex = 2,
    class = "WARLOCK",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[NAG:Cast(6603)]],
}

-- Destruction Rotation
local destructionRotation = {
    -- Core identification
    name = "Destruction",
    specIndex = 3,
    class = "WARLOCK",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[NAG:Cast(6603)]],
}

--- @class Warlock : ClassBase
local Warlock = NAG:CreateClassModule("WARLOCK", defaults)
if not Warlock then return end

function Warlock:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 0, genericRotation)  -- Generic (no talents)
    ns.AddRotationToDefaults(self.defaults, 1, afflictionRotation)  -- Affliction
    ns.AddRotationToDefaults(self.defaults, 2, demonologyRotation)  -- Demonology
    ns.AddRotationToDefaults(self.defaults, 3, destructionRotation)  -- Destruction
end

NAG.Class = Warlock

