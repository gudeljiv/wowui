local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version

local defaults = ns.InitializeClassDefaults()

-- Wrath Paladin spec spell locations
-- Self-heal when low health (generic rotation)
defaults.class.recommendSelfHeal = true
defaults.class.selfHealThreshold = 0.35

defaults.class.specSpellLocations = {
    [1] = {},  -- Holy
    [2] = {},  -- Protection
    [3] = {},  -- Retribution
}

if UnitClassBase('player') ~= "PALADIN" then return end

-- Generic (0 talent points): low-level abilities before choosing a spec
local genericRotation = {
    name = "Generic",
    specIndex = 0,
    class = "PALADIN",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[
    (NAG:GetClassSetting('recommendSelfHeal', true) and (NAG:CurrentHealthPercent() < (NAG:GetClassSetting('selfHealThreshold', 0.35) or 0.35)) and NAG:SpellCanCast(635)) and NAG:Cast(635)
    or (NAG:GetClassSetting('recommendSelfHeal', true) and (NAG:CurrentHealthPercent() < (NAG:GetClassSetting('selfHealThreshold', 0.35) or 0.35)) and NAG:SpellCanCast(19750)) and NAG:Cast(19750)
    or (not NAG:AuraIsActive(19740)) and NAG:SpellCanCast(19740) and NAG:Cast(19740)
    or (not NAG:AuraIsActive(20154)) and NAG:SpellCanCast(20154) and NAG:Cast(20154)
    or NAG:SpellCanCast(20271) and NAG:Cast(20271)
]],
}

-- Holy Rotation
local holyRotation = {
    -- Core identification
    name = "Holy",
    specIndex = 1,
    class = "PALADIN",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[NAG:Cast(6603)]],
}

-- Protection Rotation
local protectionRotation = {
    -- Core identification
    name = "Protection",
    specIndex = 2,
    class = "PALADIN",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[NAG:Cast(6603)]],
}

-- Retribution Rotation
local retributionRotation = {
    -- Core identification
    name = "Retribution",
    specIndex = 3,
    class = "PALADIN",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[NAG:Cast(6603)]],
}

--- @class Paladin : ClassBase
local Paladin = NAG:CreateClassModule("PALADIN", defaults)
if not Paladin then return end

function Paladin:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 0, genericRotation)  -- Generic (no talents)
    ns.AddRotationToDefaults(self.defaults, 1, holyRotation)  -- Holy
    ns.AddRotationToDefaults(self.defaults, 2, protectionRotation)  -- Protection
    ns.AddRotationToDefaults(self.defaults, 3, retributionRotation)  -- Retribution
end

NAG.Class = Paladin

