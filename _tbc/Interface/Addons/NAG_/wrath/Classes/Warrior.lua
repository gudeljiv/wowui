local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version

local defaults = ns.InitializeClassDefaults()

-- Wrath Warrior spec spell locations
defaults.class.specSpellLocations = {
    [1] = {},  -- Arms
    [2] = {},  -- Fury
    [3] = {},  -- Protection
}

if UnitClassBase('player') ~= "WARRIOR" then return end

-- Generic (0 talent points): low-level abilities before choosing a spec
local genericRotation = {
    name = "Generic",
    specIndex = 0,
    class = "WARRIOR",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[
    (not NAG:AuraIsActive(6673)) and NAG:SpellCanCast(6673) and NAG:Cast(6673)
    or (not NAG:InCombat("player")) and NAG:SpellCanCast(100) and NAG:Cast(100)
    or (NAG:SpellCanCast(772) and (not NAG:DotIsActive(772, "target"))) and NAG:Cast(772)
    or (NAG:SpellCanCast(78)) and NAG:Cast(78)
]],
}

-- Arms Rotation
local armsRotation = {
    -- Core identification
    name = "Arms",
    specIndex = 1,
    class = "WARRIOR",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[NAG:Cast(6603)]],
}

-- Fury Rotation
local furyRotation = {
    -- Core identification
    name = "Fury",
    specIndex = 2,
    class = "WARRIOR",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[NAG:Cast(6603)]],
}

-- Protection Rotation
local protectionRotation = {
    -- Core identification
    name = "Protection",
    specIndex = 3,
    class = "WARRIOR",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[NAG:Cast(6603)]],
}

--- @class Warrior : ClassBase
local Warrior = NAG:CreateClassModule("WARRIOR", defaults)
if not Warrior then return end

function Warrior:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 0, genericRotation)  -- Generic (no talents)
    ns.AddRotationToDefaults(self.defaults, 1, armsRotation)  -- Arms
    ns.AddRotationToDefaults(self.defaults, 2, furyRotation)  -- Fury
    ns.AddRotationToDefaults(self.defaults, 3, protectionRotation)  -- Protection
end

NAG.Class = Warrior

