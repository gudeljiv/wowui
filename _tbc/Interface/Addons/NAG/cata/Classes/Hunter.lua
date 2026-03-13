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
    [1] = {  -- Beast Mastery
        [53517] = NAG.SPELL_POSITIONS.RIGHT,
        [19574] = NAG.SPELL_POSITIONS.LEFT, [3045] = NAG.SPELL_POSITIONS.LEFT, [82726] = NAG.SPELL_POSITIONS.LEFT,
        [2643] = NAG.SPELL_POSITIONS.AOE
    },
    [2] = {  -- Marksmanship
        [53517] = NAG.SPELL_POSITIONS.RIGHT,
        [19574] = NAG.SPELL_POSITIONS.LEFT, [3045] = NAG.SPELL_POSITIONS.LEFT, [82726] = NAG.SPELL_POSITIONS.LEFT,
        [2643] = NAG.SPELL_POSITIONS.AOE
    },
    [3] = {  -- Survival
        [53517] = NAG.SPELL_POSITIONS.RIGHT,
        [53434] = NAG.SPELL_POSITIONS.LEFT, [3045] = NAG.SPELL_POSITIONS.LEFT,
        [2643] = NAG.SPELL_POSITIONS.AOE
    }
}

-- Beast Mastery Rotation
local beastMasteryRotation = {
    name = "Cataclysm Beast Mastery - by @Bicarbxd",
    specIndex = 1,
    class = "HUNTER",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = false,
    prePull = {
        { time = -1, action = "NAG:Cast(NAG:GetBattlePotion())" },
        { time = -2, action = "NAG:Cast(13165)" },
        { time = -3, action = "NAG:Cast(1130)" },
        { time = -1, action = "NAG:Cast(2825)" }
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or     (((NAG:AuraNumStacks(19615, "pet") == 5.0) and (NAG:AuraRemainingTime(82692) <= 4)) and NAG:Cast(82692))
    or     ((NAG:CurrentFocus() >= 60.0) and NAG:Cast(19574))
    or     ((not (NAG:DotIsActive(1978) or NAG:DotIsActive(88453))) and NAG:Cast(1978))
    or     ((NAG:IsExecutePhase(20) and NAG:IsReady(53351)) and NAG:Cast(NAG:GetBattlePotion()))
    or     ((NAG:IsExecutePhase(20) and NAG:IsReady(53351)) and NAG:Cast(53351))
    or     (NAG:IsReady(3045) and NAG:Cast(3045))
    or     (((NAG:NumberTargets() >= 3.0) and NAG:SpellIsKnown(93433)) and NAG:Cast(93433))
    or     (((NAG:NumberTargets() >= 3.0) and NAG:SpellIsKnown(92380)) and NAG:Cast(92380))
    or     (((NAG:NumberTargets() >= 3.0) and (NAG:CurrentFocus() >= 40.0)) and NAG:Cast(2643))
    or     (NAG:IsReady(34026) and NAG:Cast(34026))
    or     ((NAG:CurrentFocus() <= 37.0) and NAG:Cast(82726))
    or     ((NAG:CurrentFocus() <= 50.0) and NAG:Cast(53517))
    or     ((((NAG:CurrentFocus() >= 59.0) and (NAG:NumberTargets() <= 2.0)) or (NAG:IsActive(19574) and (NAG:NumberTargets() <= 2.0))) and NAG:Cast(3044))
    or     NAG:Cast(77767)
]]
}

-- Marksmanship Rotation
local marksmanshipRotation = {
    name = "Cataclysm Marksmanship - by @Bicarbxd",
    specIndex = 2,
    class = "HUNTER",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = false,
    prePull = {
        { time = -25, action = "NAG:Cast(13812)" },
        { time = -3, action = "NAG:Cast(NAG:GetBattlePotion())" },
        { time = -10, action = "NAG:Cast(13165)" },
        { time = -11, action = "NAG:Cast(1130)" },
        { time = -1, action = "NAG:Cast(2825)" }
    },
    rotationString = [[
        NAG:AutocastOtherCooldowns()
        or (((NAG:SpellCastTime(19434) <= 1) or NAG:IsExecutePhase(90)) and NAG:Cast(19434))
        or (((not NAG:IsActive(1978)) and (not NAG:IsExecutePhase(90))) and NAG:Cast(1978))
        or (((not NAG:IsExecutePhase(90))) and NAG:Cast(53209))
        or (((not NAG:IsActive(53221)) or (NAG:AuraRemainingTime(53221) <= 3)) and NAG:Cast(56641))
        or (NAG:SpellCanCast(53351) and NAG:Cast(53351))
        or (((NAG:CurrentFocus() >= 66.0) or (NAG:TimeToReady(53209) >= 4.0)) and NAG:Cast(3044))
        or NAG:Cast(56641)
]]
}

-- Survival Rotation
local survivalRotation = {
    name = "Cataclysm Survival - by @Bicarbxd",
    specIndex = 3,
    class = "HUNTER",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = false,
    prePull = {
        { time = -25, action = "NAG:Cast(13812)" },
        { time = -1.4, action = "NAG:Cast(NAG:GetBattlePotion())" },
        { time = -1.4, action = "NAG:Cast(77767)" }
    },
    rotationString = [[
        NAG:SpellCastSequence()
        or (((NAG:AuraRemainingTime(2825) <= 4) and NAG:IsActive(2825)) and NAG:Cast(3045))
        or (((NAG:AuraRemainingTime(2825) <= 4) and NAG:IsActive(2825)) and NAG:Cast(3045))
        or (NAG:IsReady(82174) and NAG:Cast(82174))
        or ((NAG:IsExecutePhase(20)) and NAG:Cast(58145))
        or ((not (NAG:IsActive(1978) or NAG:IsActive(88453))) and NAG:Cast(1978))
        or ((NAG:IsActive(53301) and (NAG:CurrentFocus() >= 95.0) and (NAG:IsActive(3674) or NAG:IsActive(13812))) and NAG:Cast(3044))
        or (((not NAG:IsActive(53301)) or (NAG:DotRemainingTime(53301) < (NAG:SpellTravelTime(53301) + 1.0))) and NAG:Cast(53301))
        or (NAG:IsExecutePhase(20) and NAG:Cast(53351))
        or ((NAG:IsActive(53301) and (NAG:DotRemainingTime(53301) >= (NAG:SpellTravelTime(53301) + 1.0)) and NAG:SpellCanCast(53301) and (NAG:DotRemainingTime(53301) <= (NAG:SpellTravelTime(53301) + 1.05))) and NAG:Wait(0.051))
        or ((NAG:IsReady(3674) and (not NAG:IsReady(53301))) and NAG:Cast(3674))
        or (((NAG:TimeToReady(53301) < 0.25) and (NAG:CurrentFocus() > 44.0)) and NAG:Cast(53301))
        or ((NAG:CurrentFocus() >= 80.0) and NAG:Cast(3044))
        or (((NAG:CurrentFocus() >= 40.0) and (NAG:RemainingTime() <= 8) and (NAG:TimeToReady(53301) >= 3)) and NAG:Cast(3044))
        or NAG:Cast(77767)

]]
}

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
-- Leave below as is

if UnitClassBase('player') ~= "HUNTER" then return end

--- @class Hunter : ClassBase
local Hunter = NAG:CreateClassModule("HUNTER", defaults, {
    weakAuraName = "Hunter Next Action Guide",
})
if not Hunter then return end

-- Setup class defaults during PreDatabaseRegistration
function Hunter:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 1, beastMasteryRotation)  -- Beast Mastery
    ns.AddRotationToDefaults(self.defaults, 2, marksmanshipRotation)  -- Marksmanship
    ns.AddRotationToDefaults(self.defaults, 3, survivalRotation)  -- Survival
end

function Hunter:RegisterSpellTracking()
    --- @type SpellTrackingManager|AceModule|CoreModule
    local SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
        -- Add spells to periodic damage tracking
    SpellTrackingManager:RegisterTravelTime({ 53301 }, { STT = 0, inFlight = nil }) -- Explosive Shot
end

ns.HUNTER_UpdateStablePets()
NAG.Class = Hunter
