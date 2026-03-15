local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version

local defaults = ns.InitializeClassDefaults()

-- Wrath Shaman spec spell locations
-- Self-heal when low health (generic rotation)
defaults.class.recommendSelfHeal = true
defaults.class.selfHealThreshold = 0.35

defaults.class.specSpellLocations = {
    [1] = {},  -- Elemental
    [2] = {},  -- Enhancement
    [3] = {},  -- Restoration
}

if UnitClassBase('player') ~= "SHAMAN" then return end

-- Generic (0 talent points): low-level abilities before choosing a spec
local genericRotation = {
    name = "Generic",
    specIndex = 0,
    class = "SHAMAN",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[
    (NAG:GetClassSetting('recommendSelfHeal', true) and (NAG:CurrentHealthPercent() < (NAG:GetClassSetting('selfHealThreshold', 0.35) or 0.35)) and NAG:SpellCanCast(331)) and NAG:Cast(331)
    or (not NAG:AuraIsActive(324)) and NAG:SpellCanCast(324) and NAG:Cast(324)
    or (not NAG:AuraIsActive(23575)) and NAG:SpellCanCast(23575) and NAG:Cast(23575)
    or (NAG:SpellCanCast(8050) and (not NAG:DotIsActive(8050, "target"))) and NAG:Cast(8050)
    or (NAG:SpellCanCast(403)) and NAG:Cast(403)
    or (NAG:SpellCanCast(331)) and NAG:Cast(331)
]],
}

-- Elemental Rotation
local elementalRotation = {
    -- Core identification
    name = "Elemental",
    specIndex = 1,
    class = "SHAMAN",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[NAG:Cast(6603)]],
}

-- Enhancement Rotation
local enhancementRotation = {
    -- Core identification
    name = "Enhancement",
    specIndex = 2,
    class = "SHAMAN",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[NAG:Cast(6603)]],
}

-- Restoration Rotation
local restorationRotation = {
    -- Core identification
    name = "Restoration",
    specIndex = 3,
    class = "SHAMAN",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[NAG:Cast(6603)]],
}

--- @class Shaman : ClassBase
local Shaman = NAG:CreateClassModule("SHAMAN", defaults)
if not Shaman then return end

function Shaman:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 0, genericRotation)  -- Generic (no talents)
    ns.AddRotationToDefaults(self.defaults, 1, elementalRotation)  -- Elemental
    ns.AddRotationToDefaults(self.defaults, 2, enhancementRotation)  -- Enhancement
    ns.AddRotationToDefaults(self.defaults, 3, restorationRotation)  -- Restoration
end

NAG.Class = Shaman

