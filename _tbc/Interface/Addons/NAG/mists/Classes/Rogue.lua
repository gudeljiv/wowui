---@diagnostic disable: undefined-global
local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
---@type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
---@type Version
local Version = ns.Version
---@type SpellTrackingManager|AceModule|CoreModule

local defaults = ns.InitializeClassDefaults()

-- MoP Rogue spec spell locations
defaults.class.specSpellLocations = {
    [1] = { -- Assassination
        -- ABOVE spells
        [57934] = NAG.SPELL_POSITIONS.ABOVE,

        -- BELOW spells
        -- (empty)

        -- RIGHT spells
        [51723] = NAG.SPELL_POSITIONS.RIGHT,
        [121411] = NAG.SPELL_POSITIONS.RIGHT,

        -- LEFT spells
        [79140] = NAG.SPELL_POSITIONS.LEFT,
        [1856] = NAG.SPELL_POSITIONS.LEFT,
        [14177] = NAG.SPELL_POSITIONS.LEFT,
        [58426] = NAG.SPELL_POSITIONS.LEFT,
        [13750] = NAG.SPELL_POSITIONS.LEFT,
        [51690] = NAG.SPELL_POSITIONS.LEFT,
        [14185] = NAG.SPELL_POSITIONS.LEFT,
        [36554] = NAG.SPELL_POSITIONS.LEFT,
        [14183] = NAG.SPELL_POSITIONS.LEFT,
        [121471] = NAG.SPELL_POSITIONS.LEFT,

        -- AOE spells
        [13877] = NAG.SPELL_POSITIONS.AOE
    },
    [2] = { -- Combat
        -- ABOVE spells
        [57934] = NAG.SPELL_POSITIONS.ABOVE,

        -- RIGHT spells
        [103828] = NAG.SPELL_POSITIONS.RIGHT,
        [121411] = NAG.SPELL_POSITIONS.RIGHT,

        -- LEFT spells
        [1856] = NAG.SPELL_POSITIONS.LEFT,
        [13750] = NAG.SPELL_POSITIONS.LEFT,
        [14177] = NAG.SPELL_POSITIONS.LEFT,
        [14183] = NAG.SPELL_POSITIONS.LEFT,
        [14185] = NAG.SPELL_POSITIONS.LEFT,
        [36554] = NAG.SPELL_POSITIONS.LEFT,
        [51690] = NAG.SPELL_POSITIONS.LEFT,
        [58426] = NAG.SPELL_POSITIONS.LEFT,
        [79140] = NAG.SPELL_POSITIONS.LEFT,
        [121471] = NAG.SPELL_POSITIONS.LEFT,

        -- AOE spells
        [13877] = NAG.SPELL_POSITIONS.AOE,
        [51723] = NAG.SPELL_POSITIONS.AOE,

    },
    [3] = { -- Subtlety
        -- ABOVE spells
        [57934] = NAG.SPELL_POSITIONS.ABOVE,

        -- RIGHT spells
        [51723] = NAG.SPELL_POSITIONS.RIGHT,
        [78632] = NAG.SPELL_POSITIONS.RIGHT,
        [121411] = NAG.SPELL_POSITIONS.RIGHT,

        -- LEFT spells
        [14183] = NAG.SPELL_POSITIONS.LEFT,
        [14185] = NAG.SPELL_POSITIONS.LEFT,
        [1856] = NAG.SPELL_POSITIONS.LEFT,
        [51713] = NAG.SPELL_POSITIONS.LEFT,
        [121471] = NAG.SPELL_POSITIONS.LEFT,

    }
}

-- Class assignments for raid coordination
defaults.class.classAssignments = {
    {
        id = "expose_armor",
        name = "Expose Armor",
        description = "Apply armor reduction debuff on targets (conflicts with Warrior Sunder Armor)",
        spellIds = {8647, 8649, 8650, 11197, 11198, 26866, 8647}, -- All ranks
        category = "debuff",
    },
    {
        id = "tricks_of_trade",
        name = "Tricks of the Trade",
        description = "Use Tricks of the Trade on a target (coordinate with other Rogues to spread benefits)",
        spellIds = {57934}, -- Tricks of the Trade
        category = "utility",
    },
}

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
-- Leave below as is

if UnitClassBase('player') ~= "ROGUE" then return end

-- START OF GENERATED_ROTATIONS

-- Generic (0 spec / no spec selected): low-level abilities before choosing a spec
local genericRotation = {
    name = "Generic",
    specIndex = 0,
    class = "ROGUE",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    rotationString = [[
    (NAG:CurrentComboPoints() >= 4 and NAG:SpellCanCast(2098)) and NAG:Cast(2098)
    or (NAG:SpellCanCast(1752)) and NAG:Cast(1752)
]],
}

local assassinationRotation = {
    -- Core identification
    name = "Assassination",
    specIndex = 1,
    class = "ROGUE",
    author = "Horalius",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { time = -5, action = "NAG:Cast(57934)" },
        { time = -2, action = "NAG:GetBattlePotion()" },
        { time = -1, action = "NAG:Cast(1784)" },
    },
    lastModified = "11/05/2025",
    rotationString = [[
(not NAG:IsActive(2823)) and (not NAG:IsActive(8679)) and NAG:Cast(2823)

or (NAG:CurrentTime() == 0) and NAG:Cast(1784)

or ((NAG:AuraIsActive(79140, "target", false)) or (NAG:RemainingTime() <= 30)) and NAG:AutocastOtherCooldowns()

or ((NAG:AuraIsActive(79140, "target", false)) or (NAG:RemainingTime() <= 30.0)) and NAG:Cast(76089)

or (NAG:AuraIsActive(5171, "player", false) or NAG:DotIsActive(1943)) and ((NAG:RemainingTime() <= 60.0) or NAG:IsExecutePhase(35) or (NAG:RemainingTime() >= 90.0)) and NAG:Cast(79140)

or (NAG:AuraIsActive(5171, "player", false) or NAG:DotIsActive(1943)) and ((NAG:RemainingTime() <= 60.0) or NAG:AuraIsActive(79140, "target", false)) and NAG:Cast(121471)

or (NAG:AuraRemainingTime(5171) <= 3) and ((NAG:CurrentComboPoints() >= 1) or (NAG:CurrentStoredComboPoints() >= 1)) and (NAG:RemainingTime() >= 9) and NAG:Cast(5171)

or (NAG:AuraRemainingTime(5171) >= 3) and (NAG:CurrentComboPoints() == 0) and (NAG:CurrentStoredComboPoints() >= 1) and NAG:Cast(73981)

or (NAG:CurrentComboPoints() == 0) and (not NAG:AuraIsActive(1784, "player", false)) and NAG:AuraIsActive(5171, "player", false) and NAG:DotIsActive(1943) and NAG:Cast(137619)

or (NAG:CurrentTime() <= 2) and (not (NAG:DotIsActive(703) or NAG:DotIsActive(1943))) and (NAG:AuraIsActive(1784, "player", false) or NAG:AuraIsActive(108208, "player", false)) and NAG:Cast(703)

or (not NAG:AuraIsActive(5171, "player", false)) and (NAG:RemainingTime() >= 9) and NAG:Cast(5171)

or ((NAG:DotRemainingTime(1943) <= 3) or ((not NAG:DotIsActive(1943)) and (not NAG:DotIsActive(703)))) and ((NAG:CurrentComboPoints() >= 5) or ((not NAG:AuraIsKnown(114015)) and (NAG:CurrentComboPoints() >= 4))) and NAG:Cast(1943)

or (NAG:AuraIsActive(5171, "player", false) and (NAG:DotIsActive(1943) or NAG:DotIsActive(703) or NAG:AuraIsActive(79140, "target", false))) and NAG:Cast(126734)

or ((NAG:CurrentComboPoints() >= 4) or (NAG:CurrentStoredComboPoints() >= 5)) and (NAG:NumberTargets() > 7) and NAG:Cast(121411)

or ((NAG:CurrentComboPoints() >= 1) and (NAG:NumberTargets() > 2) and (NAG:AuraRemainingTime(5171) < 3)) and NAG:Cast(32645)

or (((NAG:CurrentComboPoints() >= 5) and (NAG:DotRemainingTime(1943) >= 4)) or ((NAG:CurrentComboPoints() >= 4) and ((NAG:CurrentEnergy() >= 55) or (NAG:AuraRemainingTime(32645) <= 2)) and (not NAG:IsExecutePhase(35)) and (not NAG:AuraIsActive(121153, "player", false)) and (not NAG:AuraIsActive(121471, "player", false)) and (not NAG:AuraIsKnown(114015)) and (NAG:DotRemainingTime(1943) >= 3))) and NAG:Cast(32645)

or (NAG:NumberTargets() > 2) and NAG:Cast(51723)

or ((NAG:CurrentComboPoints() <= 4) or (NAG:AuraIsKnown(114015) and (NAG:AuraNumStacks(114015, "player", false) <= 1))) and (NAG:IsExecutePhase(35) or NAG:AuraIsActive(121153, "player", false)) and NAG:Cast(111240)

or ((NAG:AuraIsActive(79140, "target", false)) and (NAG:CurrentEnergy() <= 60) and (NAG:CurrentComboPoints() <= 4) and (not NAG:AuraIsActive(121153, "player", false))) and NAG:Cast(1856)

or (not NAG:SpellIsReady(1856)) and NAG:Cast(14185)

or ((NAG:CurrentComboPoints() <= 4) or (NAG:AuraIsKnown(114015) and (NAG:AuraNumStacks(114015, "player", false) <= 1))) and (not NAG:IsExecutePhase(35)) and NAG:Cast(1329)

   ]],

    -- Tracked IDs for optimization
    spells = {1784, 2823, 703, 1329, 1856, 1943, 32645, 5171, 73981, 79140, 8679, 108208, 111240, 114015, 121153, 121411, 121471, 126734, 137619, 14185, 51723},
    items = {76089},
}

local combatRotation = {
    -- Core identification
    name = "Combat",
    specIndex = 2,
    class = "ROGUE",
    author = "Horalius",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { time = -1.5, action = "NAG:GetBattlePotion()" }
    },
    lastModified = "12/18/2025",
    rotationString = [[
(not NAG:IsActive(2823)) and (not NAG:IsActive(8679)) and NAG:Cast(2823) -- Deadly/Wound Posion Cast
    or (NAG:CurrentTime() == 0) and NAG:Cast(1784) -- Stealth when not in combat
    or ((NAG:NumberTargets() > 1) and (not NAG:AuraIsActive(13877))) and NAG:Cast(13877, nil, NAG.SPELL_POSITIONS.RIGHT) -- Blade Flurry
    or ((NAG:NumberTargets() == 1) and NAG:AuraIsActive(13877)) and NAG:CastPlaceholder(103828) -- Blade Flurry OFF
    or (NAG:CurrentComboPoints() == 0) and NAG:Cast(137619) -- Mark for Death
    or (((NAG:AuraRemainingTime(5171) <= 4) and ((NAG:CurrentComboPoints() >= 5) or (NAG:CurrentStoredComboPoints() >= 5))) or (not NAG:AuraIsActive(5171))) and NAG:Cast(5171) -- Slice and Dice
    or (NAG:CurrentComboPoints() == 0) and (NAG:CurrentStoredComboPoints() >= 1) and NAG:Cast(73981) -- Redirect
    or (NAG:AuraIsActive(51690) or NAG:AuraIsActive(13750)) and NAG:Cast(76089) -- Agi Potion
    or ((NAG:NumberTargets() > 7) and ((NAG:CurrentComboPoints() >= 5) or (NAG:CurrentStoredComboPoints() >= 5)) and NAG:NumberTargetsWithTTD(12)) and NAG:Cast(121411) -- Crimson Tempest
    or (NAG:NumberTargets() > 7) and NAG:Cast(51723) -- Fan of Knives
    or (NAG:AuraIsActive(5171) and (NAG:CurrentTime() >= 15 or NAG:AuraIsActive(84745)) and ((NAG:CurrentComboPoints() >= 5) or (NAG:CurrentEnergy() <= 40))) and NAG:Cast(51690) -- Kiling Spree
    or (NAG:AuraRemainingTime(13750) >= 12) and NAG:AutocastOtherCooldowns()
    or (NAG:SpellTimeToReady(51690) >= 15) and NAG:Cast(13750) -- Adrenaline Rush
    or (NAG:AuraRemainingTime(13750) >= 12) and NAG:Cast(121471) -- Shadow Blades
    or ((NAG:CurrentComboPoints() <= 4) and (NAG:AuraIsActive(1784) or NAG:AuraIsActive(108208) or NAG:AuraIsActive(11327))) and NAG:Cast(8676) -- Ambush
    or (((NAG:CurrentComboPoints() <= 4) or (NAG:AuraIsKnown(114015) and (NAG:AuraNumStacks(114015) <= 4))) and (NAG:AuraRemainingTime(84617, "target") <= 3)) and NAG:Cast(84617) -- Revealing Strike
    or (NAG:AuraIsActive(13877) and (NAG:NumberTargets() > 1) and (NAG:CurrentComboPoints()) >= 5) and NAG:Cast(2098, nil, NAG.SPELL_POSITIONS.RIGHT) -- Eviscerate AOE
    or ((NAG:CurrentComboPoints() >= 5) and (NAG:DotRemainingTime(1943) <= 2.0)) and NAG:Cast(1943, nil, NAG.SPELL_POSITIONS.PRIMARY) --Rupture
    or (NAG:CurrentComboPoints() >= 5) and NAG:Cast(2098) -- Eviscerate
    or ((not NAG:AuraIsActive(13750)) and (not NAG:SpellIsReady(1856)) and (NAG:CurrentEnergy() < 30)) and NAG:Cast(14185) -- Preparation
    or ((not NAG:SpellIsReady(13750)) and (NAG:CurrentEnergy() <= 50) and (NAG:CurrentComboPoints() <= 3) and NAG:AuraIsActive(84747)) and NAG:Cast(1856) -- Vanish
    or (NAG:CurrentComboPoints() <= 4) and NAG:Cast(1752) -- Sinister Strike
    ]],

    -- Tracked IDs for optimization
    spells = {1752, 1784, 2098, 2823, 5171, 73981, 76089, 8676, 8679, 103828, 108208, 11327, 114015, 121411, 121471, 126734, 13750, 137619, 13877, 14185, 1856, 1943, 51690, 51723, 84617, 84745, 84746, 84747},
    items = {},
}

local subtletyRotation = {
    -- Core identification
    name = "Subtlety",
    specIndex = 3,
    class = "ROGUE",
    author = "Horalius",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { time = -5, action = "NAG:Cast(57934)" },
        { time = -2, action = "NAG:Cast(76089)" },
        { time = -1, action = "NAG:Cast(1784)" },
    },
    lastModified = "11/05/2025",
    rotationString = [[
(not NAG:IsActive(2823)) and (not NAG:IsActive(8679)) and NAG:Cast(2823)

or (NAG:CurrentTime() == 0) and NAG:Cast(1784)

or (NAG:CurrentComboPoints() == 0) and (NAG:CurrentStoredComboPoints() >= 1) and (NAG:AuraRemainingTime(5171) >= 2) and NAG:Cast(73981)

or (NAG:AuraIsActive(51713, "player", false)) and NAG:Cast(76089)

or (NAG:CurrentComboPoints() == 0) and NAG:Cast(137619)

or NAG:Cast(121471)

or (NAG:AuraIsActive(51713, "player", false)) and NAG:AutocastOtherCooldowns()

or (NAG:CurrentComboPoints() <= 3) and (NAG:AuraIsActive(58984, "player", false) or NAG:AuraIsActive(51713, "player", false) or NAG:AuraIsActive(1784, "player", false) or NAG:AuraIsActive(11327)) and NAG:Cast(14183)

or (NAG:SpellTimeToReady(1856) >= 20) and (NAG:CurrentEnergy() < 30) and NAG:Cast(14185)

or (NAG:AuraRemainingTime(51713) <= 1) and NAG:PlayerIsInGroup() and NAG:Cast(8676)

or (NAG:AuraRemainingTime(51713) <= 1) and NAG:AuraIsActive(51713, "player", false) and NAG:Cast(703)

or (NAG:AuraRemainingTime(5171) <= 2) and ((NAG:CurrentComboPoints() >= 3) or (NAG:CurrentStoredComboPoints() >= 3)) and (NAG:RemainingTime() >= 9) and NAG:Cast(5171)

or (NAG:NumberTargets() > 2) and ((NAG:DotRemainingTime(121411) <= 4)  and ((NAG:CurrentComboPoints() >= 5) or (NAG:CurrentStoredComboPoints() >= 5))) and NAG:Cast(121411)

or NAG:DotRemainingTime(1943) and (NAG:NumberTargets() > 2) and ((NAG:DotRemainingTime(121411) >= 4)  and ((NAG:CurrentComboPoints() >= 5) or (NAG:CurrentStoredComboPoints() >= 5))) and NAG:Cast(1943, nil,NAG.SPELL_POSITIONS.RIGHT)

or (NAG:DotRemainingTime(1943) <= 3) and (NAG:CurrentComboPoints() >= 5) and (NAG:RemainingTime() > 3) and NAG:Cast(1943)

or NAG:AuraIsKnown(108208) and (NAG:CurrentTime() <= 3) and (not NAG:DotIsActive(703)) and NAG:Cast(703)

or NAG:AuraIsKnown(108208) and NAG:AuraIsActive(108208, "player", false) and NAG:PlayerIsInGroup() and NAG:Cast(8676)

or (NAG:NumberTargets() > 2) and ((NAG:DotRemainingTime(121411) >= 4) and (NAG:DotRemainingTime(1943) >= 4)) and NAG:CastWithOverlay(78632, "Tab\nBleed", NAG.SPELL_POSITIONS.RIGHT)

or (NAG:DotRemainingTime(1943) >= 3) and (NAG:CurrentComboPoints() >= 5) and (NAG:AuraIsActive(51713)) and NAG:Cast(2098)

or (NAG:DotRemainingTime(1943) >= 3) and (NAG:CurrentComboPoints() >= 5) and (not NAG:AuraIsActive(1784, "player")) and (not NAG:AuraIsActive(108208, "player", false)) and (not NAG:AuraIsActive(58984, "player", false)) and (not NAG:AuraIsActive(11327)) and NAG:Cast(2098)

or ((NAG:DotRemainingTime(16511) >= 10) or (NAG:DotRemainingTime(1943) >= 10)) and ((NAG:AuraRemainingTime(91023, "target") <= 0.5) or (NAG:CurrentTime() <= 10)) and (NAG:CurrentComboPoints() <= 3) and (NAG:AuraRemainingTime(5171) >= 6) and NAG:Cast(51713)

or ((NAG:DotRemainingTime(16511) >= 10) or (NAG:DotRemainingTime(1943) >= 10)) and ((NAG:AuraRemainingTime(91023, "target") <= 0.5) or (not NAG:AuraIsActive(91023, "target", false))) and (not NAG:AuraIsActive(51713, "player", false)) and (NAG:SpellTimeToReady(51713) >= 10) and NAG:CurrentComboPoints() <= 3 and NAG:Cast(1856)

or ((NAG:DotRemainingTime(16511) >= 10) or (NAG:DotRemainingTime(1943) >= 10)) and ((NAG:AuraRemainingTime(91023, "target") <= 0.5) or (not NAG:AuraIsActive(91023, "target", false))) and (not NAG:AuraIsActive(51713, "player", false)) and (not NAG:AuraIsActive(1784, "player", false)) and (NAG:SpellTimeToReady(51713) >= 10) and (NAG:SpellTimeToReady(1856) >= 10) and (NAG:CurrentComboPoints() <= 3) and NAG:Cast(58984)

or ((NAG:CurrentComboPoints() <= 4) or (NAG:AuraIsKnown(114015) and (NAG:AuraNumStacks(114015, "player", false) <= 3))) and (NAG:AuraIsActive(58984, "player", false) or NAG:AuraIsActive(51713, "player", false) or NAG:AuraIsActive(1784, "player", false) or NAG:AuraIsActive(11327) or NAG:AuraIsActive(145211, "player", false)) and NAG:PlayerIsInGroup() and NAG:Cast(8676)

or ((NAG:CurrentComboPoints() <= 4) or (NAG:AuraIsKnown(114015) and (NAG:AuraNumStacks(114015, "player", false) <= 3))) and (NAG:AuraIsActive(58984, "player", false) or NAG:AuraIsActive(51713, "player", false) or NAG:AuraIsActive(1784, "player", false) or NAG:AuraIsActive(11327) or NAG:AuraIsActive(145211, "player", false)) and (NAG:DotRemainingTime(703) <= 3) and NAG:Cast(703)

or ((NAG:CurrentComboPoints() <= 4) or (NAG:AuraIsKnown(114015) and (NAG:AuraNumStacks(114015, "player", false) <= 3))) and (NAG:AuraIsActive(58984, "player", false) or NAG:AuraIsActive(51713, "player", false) or NAG:AuraIsActive(1784, "player", false) or NAG:AuraIsActive(11327) or NAG:AuraIsActive(145211, "player", false)) and NAG:Cast(16511)

or (NAG:NumberTargets() > 2) and ((NAG:CurrentComboPoints() <= 4) and (not NAG:AuraIsActive(145211, "player", false)) and (not NAG:AuraIsActive(51713, "player", false)) and (not NAG:AuraIsActive(1784, "player", false)) and (not NAG:AuraIsActive(58984, "player", false)) and (not NAG:AuraIsActive(11327))) and NAG:Cast(51723)

or (NAG:CurrentComboPoints() <= 4) and (NAG:DotRemainingTime(16511) <= 3) and (not NAG:DotIsActive(703)) and (not NAG:AuraIsActive(51713, "player", false)) and NAG:Cast(16511)

or (NAG:CurrentComboPoints() <= 4) and (not NAG:AuraIsActive(145211, "player", false)) and (not NAG:AuraIsActive(51713, "player", false)) and (not NAG:AuraIsActive(1784, "player", false)) and (not NAG:AuraIsActive(58984, "player", false)) and (not NAG:AuraIsActive(11327)) and NAG:PlayerIsInGroup() and NAG:Cast(53)

or (NAG:CurrentComboPoints() <= 4) and (not NAG:AuraIsActive(145211, "player", false)) and (not NAG:AuraIsActive(51713, "player", false)) and (not NAG:AuraIsActive(1784, "player", false)) and (not NAG:AuraIsActive(58984, "player", false)) and (not NAG:AuraIsActive(11327)) and NAG:Cast(16511)
]],

    -- Tracked IDs for optimization
    spells = {53, 703, 1784, 1856, 1943, 2823, 5171, 51713, 51723, 73981, 76089, 8676, 8679, 108208, 11327, 114015, 121411, 121471, 137619, 14183, 14185, 145211, 16511, 2098, 58984, 78632, 91023},
    items = {},
}

---@class Rogue : ClassBase
local Rogue = NAG:CreateClassModule("ROGUE", defaults)
if not Rogue then return end

function Rogue:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 0, genericRotation)  -- Generic (no spec)
    ns.AddRotationToDefaults(self.defaults, 1, assassinationRotation)  -- Assassination
    ns.AddRotationToDefaults(self.defaults, 2, combatRotation)  -- Combat
    ns.AddRotationToDefaults(self.defaults, 3, subtletyRotation)  -- Subtlety
end


function Rogue:RegisterSpellTracking()
    local SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
    end






NAG.Class = Rogue
