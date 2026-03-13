local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version

local defaults = ns.InitializeClassDefaults()

-- Wrath Priest spec spell locations
-- Self-heal when low health (generic rotation)
defaults.class.recommendSelfHeal = true
defaults.class.selfHealThreshold = 0.35

defaults.class.specSpellLocations = {
    [1] = {},  -- Discipline
    [2] = {},  -- Holy
    [3] = {},  -- Shadow
}

if UnitClassBase('player') ~= "PRIEST" then return end

-- Generic (0 talent points): low-level abilities before choosing a spec
local genericRotation = {
    name = "Generic",
    specIndex = 0,
    class = "PRIEST",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[
    (NAG:GetClassSetting('recommendSelfHeal', true) and (NAG:CurrentHealthPercent() < (NAG:GetClassSetting('selfHealThreshold', 0.35) or 0.35)) and NAG:SpellCanCast(2061)) and NAG:Cast(2061)
    or (NAG:GetClassSetting('recommendSelfHeal', true) and (NAG:CurrentHealthPercent() < (NAG:GetClassSetting('selfHealThreshold', 0.35) or 0.35)) and NAG:SpellCanCast(2050)) and NAG:Cast(2050)
    or (not NAG:AuraIsActive(1243)) and NAG:SpellCanCast(1243) and NAG:Cast(1243)
    or (NAG:SpellCanCast(589) and (not NAG:DotIsActive(589, "target"))) and NAG:Cast(589)
    or (NAG:SpellCanCast(8092)) and NAG:Cast(8092)
    or (NAG:SpellCanCast(585)) and NAG:Cast(585)
]],
}

-- Discipline Rotation
local disciplineRotation = {
    -- Core identification
    name = "Discipline",
    specIndex = 1,
    class = "PRIEST",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[NAG:Cast(6603)]],
}

-- Holy Rotation
local holyRotation = {
    -- Core identification
    name = "Holy",
    specIndex = 2,
    class = "PRIEST",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[NAG:Cast(6603)]],
}

-- Shadow Rotation
local shadowRotation = {
    -- Core identification
    name = "Shadow",
    specIndex = 3,
    class = "PRIEST",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[NAG:Cast(6603)]],
}

--- @class Priest : ClassBase
local Priest = NAG:CreateClassModule("PRIEST", defaults)
if not Priest then return end

function Priest:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 0, genericRotation)  -- Generic (no talents)
    ns.AddRotationToDefaults(self.defaults, 1, disciplineRotation)  -- Discipline
    ns.AddRotationToDefaults(self.defaults, 2, holyRotation)  -- Holy
    ns.AddRotationToDefaults(self.defaults, 3, shadowRotation)  -- Shadow
end

NAG.Class = Priest

