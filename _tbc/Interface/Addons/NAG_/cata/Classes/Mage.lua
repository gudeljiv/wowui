local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
--- @type SpellTrackingManager|AceModule|CoreModule

--- NAG
local defaults = ns.InitializeClassDefaults()

-- Add spec-level spell locations to defaults
defaults.class.specSpellLocations = {
    [1] = {  -- Arcane
        [11129] = NAG.SPELL_POSITIONS.ABOVE,
        [2136] = NAG.SPELL_POSITIONS.RIGHT,
        [55342] = NAG.SPELL_POSITIONS.LEFT, [12051] = NAG.SPELL_POSITIONS.LEFT, [36799] = NAG.SPELL_POSITIONS.LEFT,
        [82731] = NAG.SPELL_POSITIONS.LEFT, [12042] = NAG.SPELL_POSITIONS.LEFT, [12043] = NAG.SPELL_POSITIONS.LEFT,
        [26297] = NAG.SPELL_POSITIONS.LEFT, [33702] = NAG.SPELL_POSITIONS.LEFT
    },
    [2] = {  -- Fire
        [11129] = NAG.SPELL_POSITIONS.ABOVE,
        [2136] = NAG.SPELL_POSITIONS.RIGHT,
        [55342] = NAG.SPELL_POSITIONS.LEFT, [12051] = NAG.SPELL_POSITIONS.LEFT, [36799] = NAG.SPELL_POSITIONS.LEFT,
        [82731] = NAG.SPELL_POSITIONS.LEFT, [26297] = NAG.SPELL_POSITIONS.LEFT, [33702] = NAG.SPELL_POSITIONS.LEFT
    },
    [3] = {  -- Frost
    }
}

-- Arcane Rotation
local arcaneRotation = {
    name = "Cataclysm Arcane - by @Repikas",
    specIndex = 1,
    class = "MAGE",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = false,
    prePull = {
        { time = -10, action = "NAG:Cast(6117)" },
        { time = -1.5, action = "NAG:Cast(NAG:GetBattlePotion())" },
        { time = -1.5, action = "NAG:Cast(30451)" }
    },
    macros = {
        { name = "Arcane Power", body = "#showtooltip\n/cast Arcane Power\n/use Mana gem" }
    },
    rotationString = [[
        NAG:SpellCastSequence()
        or NAG:AutocastOtherCooldowns()
        or ((not NAG:IsActive(6117)) and NAG:Cast(6117))
        or (((not NAG:IsActive(1459)) and (not NAG:IsActive(61316))) and NAG:Cast(1459))
        or (((NAG:AuraNumStacks(36032) == 0.0) and (not NAG:IsActive(12042))) and NAG:Cast(12043))
        or (((NAG:AuraNumStacks(36032) > 3.0) or (NAG:RemainingTime() < 20)) and NAG:Cast(12042))
        or (((NAG:IsActive(12042) and (not NAG:IsActive(2825))) or (NAG:RemainingTime() < 20)) and NAG:Cast(26297))
        or ((NAG:IsActive(12042) or (NAG:RemainingTime() < 25)) and NAG:Cast(58091))
        or (((NAG:IsActive(12042) and (NAG:CurrentManaPercent() < 0.95)) or (NAG:RemainingTime() < 20)) and NAG:Cast(36799))
        or (NAG:IsActive(12042) and NAG:Cast(55342))
        or (((not NAG:IsActive(12042)) and (NAG:RemainingTime() > 25) and (NAG:CurrentManaPercent() < 0.30)) and NAG:ChannelSpell(12051, function() return (NAG:CurrentManaPercent() >= 0.80) end, true))
        or ((NAG:RemainingTime() < NAG:SpellCastTime(30451)) and NAG:Cast(2136))
        or (((((NAG:CurrentMana() / 3333.0) > NAG:RemainingTime()) and (NAG:CurrentManaPercent() > 0.10)) or (NAG:TimeToReady(12051) < 25) or (NAG:CurrentManaPercent() > 0.92) or NAG:IsActive(12042)) and NAG:Cast(30451))
        or NAG:Cast(82731)
        or (NAG:IsActive(79683) and NAG:ChannelSpell(5143, function() return {} end, true))
        or (((NAG:AuraNumStacks(36032) > 3.0) and (NAG:CurrentManaPercent() <= 0.85)) and NAG:Cast(44425))
        or NAG:Cast(30451)
]]
}

-- Fire Rotation
local fireRotation = {
    name = "Cataclysm Fire - by @Repikas",
    specIndex = 2,
    class = "MAGE",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = false,
    prePull = {
        { time = -10, action = "NAG:Cast(30482)" },
        { time = -4, action = "NAG:Cast(55342)" },
        { time = -2.5, action = "NAG:Cast(NAG:GetBattlePotion())" },
        { time = -2.5, action = "NAG:Cast(11366)" }
    },
    macros = {
        { name = "Arcane Power", body = "#showtooltip\n/cast Arcane Power\n/use Mana gem" }
    },
    rotationString = [[
        NAG:SpellCastSequence()
        or NAG:AutocastOtherCooldowns()
        or (NAG:IsActive(64343) and NAG:Cast(2136))
        or (((not NAG:IsActive(1459)) and (not NAG:IsActive(61316))) and NAG:Cast(1459))
        or (((not NAG:IsActive(6117)) and (not NAG:IsActive(30482))) and NAG:Cast(30482))
        or ((NAG:CurrentTime() > 7) and NAG:Cast(26297))
        or ((NAG:CurrentTime() > 7) and NAG:Cast(82174))
        or ((NAG:IsReady(11129)) and NAG:Cast(58091))
        or (((NAG:RemainingTimePercent() > 20.0) and (NAG:CurrentManaPercent() > 0.25) and (not NAG:IsActive(30482))) and NAG:Cast(30482))
        or ((((NAG:CurrentTime() <= 17) and (NAG:DotNumStacks(12846) > 30000.0) and NAG:DotIsActive(12846) and NAG:DotIsActive(44457) and (NAG:DotIsActive(11366) or NAG:DotIsActive(92315)) and NAG:IsActive(26297))) and NAG:Cast(11129))
        or ((((NAG:CurrentTime() <= 17) and (NAG:AuraRemainingTime(26297) < 2.5) and (NAG:DotNumStacks(12846) > 10000.0) and NAG:DotIsActive(12846) and NAG:DotIsActive(44457) and NAG:IsActive(26297))) and NAG:Cast(11129))
        or ((((NAG:CurrentTime() > 17) and (NAG:DotNumStacks(12846) > 15000.0) and NAG:DotIsActive(12846) and NAG:DotIsActive(44457) and (NAG:DotIsActive(11366) or NAG:DotIsActive(92315)))) and NAG:Cast(11129))
        or ((((NAG:RemainingTimePercent() < 5.0) and (NAG:DotNumStacks(12846) > 10000.0) and NAG:DotIsActive(12846) and NAG:DotIsActive(44457))) and NAG:Cast(11129))
        or ((NAG:IsActive(48108)) and NAG:Cast(11366))
        or (((not NAG:DotIsActive(44457))) and NAG:Cast(44457))
        or ((not NAG:IsReady(11129)) and NAG:Cast(82731))
        or ((not NAG:IsReady(11129)) and NAG:Cast(55342))
        or (NAG:UnitIsMoving() and NAG:Cast(2948))
        or ((NAG:CurrentManaPercent() < 0.30) and NAG:ChannelSpell(12051, function() return ((NAG:CurrentManaPercent() > 0.20) and (NAG:RemainingTime() < 20)) end, true))
        or (((NAG:CurrentTime() > 25) and (NAG:CurrentManaPercent() < 0.90)) and NAG:Cast(36799))
        or (((NAG:RemainingTimePercent() >= 20.0) and (NAG:CurrentManaPercent() < 0.10) and (not NAG:IsActive(6117))) and NAG:Cast(6117))
        or (((NAG:CurrentManaPercent() > 0.10)) and NAG:Cast(133))
        or NAG:Cast(2948)
]]
}

-- Frost Rotation
local frostRotation = {
    name = "Cataclysm Frost",
    specIndex = 3,
    class = "MAGE",
    default = true,
    enabled = false,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = true,
    prePull = {},
    macros = {
        { name = "Arcane Power", body = "#showtooltip\n/cast Arcane Power\n/use Mana gem" }
    },
    rotationString = [[
]]
}

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
-- Leave below as is
if UnitClassBase('player') ~= "MAGE" then return end

--- @class Mage : ClassBase
local Mage = NAG:CreateClassModule("MAGE", defaults)
if not Mage then return end

-- Setup class defaults during PreDatabaseRegistration
function Mage:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 1, arcaneRotation)  -- Arcane
    ns.AddRotationToDefaults(self.defaults, 2, fireRotation)  -- Fire
    ns.AddRotationToDefaults(self.defaults, 3, frostRotation)  -- Frost
end

function Mage:RegisterSpellTracking()
    --- @type SpellTrackingManager|AceModule|CoreModule
    local SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
        -- Add spells to periodic damage tracking
    SpellTrackingManager:RegisterPeriodicDamage({ 348 }, { tickTime = nil, lastTickTime = nil })          -- Immolate
    SpellTrackingManager:RegisterPeriodicDamage({ 413843 },
        { tickTime = nil, lastTickTime = nil, spellId = 12846, auraId = 413841, tickDamage = 0 }) -- Ignite
    SpellTrackingManager:RegisterPeriodicDamage({ 11366, 92315 }, { tickTime = nil, lastTickTime = nil }) -- Pyroblast
    SpellTrackingManager:RegisterTravelTime({ 11366 }, { STT = 0, inFlight = nil })                       -- Pyroblast
    SpellTrackingManager:RegisterTravelTime({ 133 }, { STT = 0, inFlight = nil })                         -- Fireball
end

NAG.Class = Mage
