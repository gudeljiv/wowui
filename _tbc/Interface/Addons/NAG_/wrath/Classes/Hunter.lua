local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version

local defaults = ns.InitializeClassDefaults()

-- Wrath Hunter spec spell locations
defaults.class.specSpellLocations = {
    [1] = {  -- Beast Mastery
        -- ABOVE: Pet, Aspects, debuffs
        [883] = NAG.SPELL_POSITIONS.ABOVE,      -- Call Pet
        [61847] = NAG.SPELL_POSITIONS.ABOVE,    -- Aspect of the Dragonhawk
        [34074] = NAG.SPELL_POSITIONS.ABOVE,   -- Aspect of the Viper
        [53338] = NAG.SPELL_POSITIONS.ABOVE,   -- Hunter's Mark
        [49001] = NAG.SPELL_POSITIONS.ABOVE,   -- Serpent Sting
        -- LEFT: Cooldowns
        [19574] = NAG.SPELL_POSITIONS.LEFT,     -- Bestial Wrath
        [3045] = NAG.SPELL_POSITIONS.LEFT,     -- Rapid Fire
        [49050] = NAG.SPELL_POSITIONS.LEFT,    -- Kill Command
        -- RIGHT
        [49048] = NAG.SPELL_POSITIONS.AOE,     -- Multi-Shot (ST and AOE)
    },
    [2] = {},  -- Marksmanship
    [3] = {},  -- Survival
}

if UnitClassBase('player') ~= "HUNTER" then return end

-- Generic (0 talent points): low-level abilities before choosing a spec
local genericRotation = {
    name = "Generic",
    specIndex = 0,
    class = "HUNTER",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[
    (not NAG:AuraIsActive(13165)) and NAG:SpellCanCast(13165) and NAG:Cast(13165)
    or (NAG:SpellCanCast(1978) and (not NAG:DotIsActive(1978, "target"))) and NAG:Cast(1978)
    or (NAG:SpellCanCast(3044)) and NAG:Cast(3044)
]],
}

-- Beast Mastery Rotation (WotLK / Titanforged Chinese TRR 3.80)
local beastMasteryRotation = {
    name = "Beast Mastery",
    specIndex = 1,
    class = "HUNTER",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    prePull = {
        { time = -3.0, action = "NAG:Cast(53338)" },   -- Hunter's Mark
        { time = -1.5, action = "NAG:Cast(61847)" },  -- Aspect of the Dragonhawk
    },
    rotationString = [[
    (not NAG:PetIsActive() and NAG:SpellCanCast(883)) and NAG:Cast(883, nil, NAG.SPELL_POSITIONS.ABOVE)
    or (NAG:GetClassSetting('recommendAspects', true) and (
        (NAG:CurrentManaPercent() < 0.10 and (not NAG:AuraIsActive(34074)) and NAG:SpellCanCast(34074)) and NAG:Cast(34074, nil, NAG.SPELL_POSITIONS.ABOVE)
        or (NAG:CurrentManaPercent() > 0.30 and (not NAG:AuraIsActive(61847)) and NAG:SpellCanCast(61847)) and NAG:Cast(61847, nil, NAG.SPELL_POSITIONS.ABOVE)
    ))
    or (NAG:PetIsActive() and NAG:InCombat() and NAG:UnitExists("target") and ((not NAG:UnitExists("pettarget")) or (not NAG:InCombat("pet")))) and NAG:ShowCustomOverlay("Pet Not Attacking")
    or (NAG:NumberTargets() >= 2 and NAG:SpellCanCast(49048)) and NAG:Cast(49048, nil, NAG.SPELL_POSITIONS.AOE)
    or (NAG:IsExecutePhase(20) and NAG:SpellCanCast(61006)) and NAG:Cast(61006, nil, NAG.SPELL_POSITIONS.PRIMARY)
    or (NAG:UnitExists("target") and NAG:UnitCanAttack("player", "target") and NAG:SpellCanCast(53338) and (not NAG:AuraIsActive(53338, "target"))) and NAG:Cast(53338, nil, NAG.SPELL_POSITIONS.ABOVE)
    or (NAG:UnitExists("target") and (not NAG:DotIsActive(49001, "target")) and NAG:RemainingTime() > 6 and NAG:SpellCanCast(49001)) and NAG:Cast(49001, nil, NAG.SPELL_POSITIONS.ABOVE)
    or NAG:SpellCanCast(49050) and NAG:Cast(49050, nil, NAG.SPELL_POSITIONS.LEFT)
    or NAG:SpellCanCast(19574) and NAG:Cast(19574, nil, NAG.SPELL_POSITIONS.LEFT)
    or NAG:SpellCanCast(3045) and NAG:Cast(3045, nil, NAG.SPELL_POSITIONS.LEFT)
    or NAG:SpellCanCast(49048) and NAG:Cast(49048, nil, NAG.SPELL_POSITIONS.AOE)
    or NAG:SpellCanCast(49045) and NAG:Cast(49045, nil, NAG.SPELL_POSITIONS.RIGHT)
    or NAG:SpellCanCast(49052) and NAG:Cast(49052, nil, NAG.SPELL_POSITIONS.PRIMARY)
]],
}

-- Marksmanship Rotation
local marksmanshipRotation = {
    -- Core identification
    name = "Marksmanship",
    specIndex = 2,
    class = "HUNTER",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[NAG:Cast(6603)]],
}

-- Survival Rotation
local survivalRotation = {
    -- Core identification
    name = "Survival",
    specIndex = 3,
    class = "HUNTER",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[NAG:Cast(6603)]],
}

--- @class Hunter : ClassBase
local Hunter = NAG:CreateClassModule("HUNTER", defaults)
if not Hunter then return end

function Hunter:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 0, genericRotation)  -- Generic (no talents)
    ns.AddRotationToDefaults(self.defaults, 1, beastMasteryRotation)  -- Beast Mastery
    ns.AddRotationToDefaults(self.defaults, 2, marksmanshipRotation)  -- Marksmanship
    ns.AddRotationToDefaults(self.defaults, 3, survivalRotation)  -- Survival
end

NAG.Class = Hunter

