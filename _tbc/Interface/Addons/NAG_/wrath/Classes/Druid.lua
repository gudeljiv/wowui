local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version

local defaults = ns.InitializeClassDefaults()

-- Wrath Druid spec spell locations
-- Self-heal when low health (generic rotation)
defaults.class.recommendSelfHeal = true
defaults.class.selfHealThreshold = 0.35

defaults.class.specSpellLocations = {
    [1] = { -- Balance
        -- ABOVE spells
        -- (empty)

        -- BELOW spells
        -- (empty)

        -- RIGHT spells
        -- (empty)

        -- LEFT spells (long cooldowns)
        [48505] = NAG.SPELL_POSITIONS.LEFT,   -- Starfall
        [33831] = NAG.SPELL_POSITIONS.LEFT,   -- Force of Nature
        [17116] = NAG.SPELL_POSITIONS.LEFT,   -- Nature's Swiftness
        [29166] = NAG.SPELL_POSITIONS.LEFT,   -- Innervate
        [22812] = NAG.SPELL_POSITIONS.LEFT,   -- Barkskin
    },
    [2] = { -- Feral
        -- ABOVE spells
        -- (empty)

        -- BELOW spells
        -- (empty)

        -- RIGHT spells
        -- (empty)

        -- LEFT spells (long cooldowns)
        [50334] = NAG.SPELL_POSITIONS.LEFT,   -- Berserk
        [50213] = NAG.SPELL_POSITIONS.LEFT,   -- Tiger's Fury
        [61336] = NAG.SPELL_POSITIONS.LEFT,   -- Survival Instincts
        [29166] = NAG.SPELL_POSITIONS.LEFT,   -- Innervate
        [22812] = NAG.SPELL_POSITIONS.LEFT,   -- Barkskin
    },
    [3] = { -- Restoration
        -- ABOVE spells
        -- (empty)

        -- BELOW spells
        -- (empty)

        -- RIGHT spells
        -- (empty)

        -- LEFT spells (long cooldowns)
        [17116] = NAG.SPELL_POSITIONS.LEFT,   -- Nature's Swiftness
        [29166] = NAG.SPELL_POSITIONS.LEFT,   -- Innervate
        [48447] = NAG.SPELL_POSITIONS.LEFT,   -- Tranquility
        [22812] = NAG.SPELL_POSITIONS.LEFT,   -- Barkskin
    },
}

if UnitClassBase('player') ~= "DRUID" then return end

-- Generic (0 talent points): low-level abilities before choosing a spec
local genericRotation = {
    name = "Generic",
    specIndex = 0,
    class = "DRUID",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[
    (NAG:GetClassSetting('recommendSelfHeal', true) and (NAG:CurrentHealthPercent() < (NAG:GetClassSetting('selfHealThreshold', 0.35) or 0.35)) and NAG:SpellCanCast(5185)) and NAG:Cast(5185)
    or (not NAG:AuraIsActive(1126)) and NAG:SpellCanCast(1126) and NAG:Cast(1126)
    or (not NAG:AuraIsActive(467)) and NAG:SpellCanCast(467) and NAG:Cast(467)
    or (NAG:SpellCanCast(8921) and (not NAG:DotIsActive(8921, "target"))) and NAG:Cast(8921)
    or (NAG:SpellCanCast(5176)) and NAG:Cast(5176)
]],
}

-- Balance Rotation
local balanceRotation = {
    -- Core identification
    name = "Balance",
    specIndex = 1,
    class = "DRUID",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[NAG:Cast(6603)]],
}

-- Feral Rotation
local feralRotation = {
    -- Core identification
    name = "Feral (DPS)",
    specIndex = 2,
    class = "DRUID",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[
NAG:AuraIsActive(9634) and NAG:SelectRotation("Feral (Guardian)")
or NAG:AutocastOtherCooldowns()
or (NAG:CurrentEnergy() <= 30) and NAG:Cast(50213)
or not NAG:AuraIsActive(16870, "player") and (NAG:CurrentComboPoints() == 5) and not NAG:DotIsActive(49800) and (NAG:RemainingTime() >= 10) and NAG:Cast(49800)
or not NAG:AuraIsActive(16870, "player") and ((NAG:AuraIsActive(50334, "player") and (NAG:CurrentEnergy() < 15)) or (not NAG:AuraIsActive(50334, "player") and (NAG:CurrentEnergy() < 87))) and NAG:Cast(16857)
or (NAG:SpellTimeToReady(50213) > 15) and NAG:DotIsActive(49800) and not NAG:AuraIsActive(16870, "player") and NAG:Cast(50334)
or (NAG:CurrentComboPoints() >= 1) and (not NAG:AuraIsActive(52610, "player") or (NAG:DotIsActive(49800) and ((NAG:RemainingTime() - NAG:DotRemainingTime(49800)) > 10) and (NAG:AuraRemainingTime(52610) < (NAG:DotRemainingTime(49800) + 4)) and (NAG:AuraRemainingTime(52610) < NAG:RemainingTime()) and (NAG:CatNewSavageRoarDuration() >= (NAG:DotRemainingTime(49800) + 25)))) and NAG:Cast(52610)
or (NAG:CurrentComboPoints() == 5) and not NAG:AuraIsActive(16870, "player") and ((NAG:AuraIsActive(50334, "player") and (NAG:CurrentEnergy() <= 25)) or (not NAG:AuraIsActive(50334, "player") and (NAG:CurrentEnergy() < 67))) and ((NAG:DotIsActive(49800) and NAG:AuraIsActive(52610, "player") and (NAG:DotRemainingTime(49800) >= 4) and (NAG:AuraRemainingTime(52610) >= 4)) or (NAG:DotIsActive(49800) and ((NAG:RemainingTime() - NAG:DotRemainingTime(49800)) < 10)) or (NAG:RemainingTime() < 10)) and NAG:Cast(48577)
or not NAG:UnitDebuffGlobal("target", 46857) and not NAG:UnitDebuffGlobal("target", 48566) and not NAG:AuraIsActive(16870, "player") and NAG:Cast(48566)
or not NAG:AuraIsActive(16870, "player") and not NAG:DotIsActive(48574) and (NAG:RemainingTime() > 9) and NAG:Cast(48574)
or (NAG:AuraIsActive(16870, "player") or (NAG:CurrentEnergy() >= 42)) and NAG:Cast(48572)
or NAG:Cast(48572)
    ]],
}

-- Feral Rotation
local feralRotation2 = {
    -- Core identification
    name = "Feral (Guardian)",
    specIndex = 2,
    class = "DRUID",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[
NAG:AuraIsActive(768) and NAG:SelectRotation("Feral (DPS)")
or NAG:AutocastOtherCooldowns()
or (NAG:CurrentEnergy() <= 30) and NAG:Cast(50213)
or not NAG:AuraIsActive(16870, "player") and (NAG:CurrentComboPoints() == 5) and not NAG:DotIsActive(49800) and (NAG:RemainingTime() >= 10) and NAG:Cast(49800)
or not NAG:AuraIsActive(16870, "player") and ((NAG:AuraIsActive(50334, "player") and (NAG:CurrentEnergy() < 15)) or (not NAG:AuraIsActive(50334, "player") and (NAG:CurrentEnergy() < 87))) and NAG:Cast(16857)
or (NAG:SpellTimeToReady(50213) > 15) and NAG:DotIsActive(49800) and not NAG:AuraIsActive(16870, "player") and NAG:Cast(50334)
or (NAG:CurrentComboPoints() >= 1) and (not NAG:AuraIsActive(52610, "player") or (NAG:DotIsActive(49800) and ((NAG:RemainingTime() - NAG:DotRemainingTime(49800)) > 10) and (NAG:AuraRemainingTime(52610) < (NAG:DotRemainingTime(49800) + 4)) and (NAG:AuraRemainingTime(52610) < NAG:RemainingTime()) and (NAG:CatNewSavageRoarDuration() >= (NAG:DotRemainingTime(49800) + 25)))) and NAG:Cast(52610)
or (NAG:CurrentComboPoints() == 5) and not NAG:AuraIsActive(16870, "player") and ((NAG:AuraIsActive(50334, "player") and (NAG:CurrentEnergy() <= 25)) or (not NAG:AuraIsActive(50334, "player") and (NAG:CurrentEnergy() < 67))) and ((NAG:DotIsActive(49800) and NAG:AuraIsActive(52610, "player") and (NAG:DotRemainingTime(49800) >= 4) and (NAG:AuraRemainingTime(52610) >= 4)) or (NAG:DotIsActive(49800) and ((NAG:RemainingTime() - NAG:DotRemainingTime(49800)) < 10)) or (NAG:RemainingTime() < 10)) and NAG:Cast(48577)
or NAG:AuraShouldRefresh(48566, 1) and not NAG:UnitDebuffGlobal("target", 46857) and not NAG:UnitDebuffGlobal("target", 48566) and not NAG:AuraIsActive(16870, "player") and NAG:Cast(48566)
or not NAG:AuraIsActive(16870, "player") and not NAG:DotIsActive(48574) and (NAG:RemainingTime() > 9) and NAG:Cast(48574)
or (NAG:AuraIsActive(16870, "player") or (NAG:CurrentEnergy() >= 42)) and NAG:Cast(48572)
or NAG:Cast(48572)
    ]],
}

-- Restoration Rotation
local restorationRotation = {
    -- Core identification
    name = "Restoration",
    specIndex = 3,
    class = "DRUID",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[NAG:Cast(6603)]],
}

--- @class Druid : ClassBase
local Druid = NAG:CreateClassModule("DRUID", defaults)
if not Druid then return end

function Druid:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 0, genericRotation)  -- Generic (no talents)
    ns.AddRotationToDefaults(self.defaults, 1, balanceRotation)  -- Balance
    ns.AddRotationToDefaults(self.defaults, 2, feralRotation)  -- Feral
    ns.AddRotationToDefaults(self.defaults, 2, feralRotation2)  -- Feral
    ns.AddRotationToDefaults(self.defaults, 3, restorationRotation)  -- Restoration
end

NAG.Class = Druid

