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

-- Class assignments for raid coordination
defaults.class.classAssignments = {
    {
        id = "power_word_fortitude",
        name = "Power Word: Fortitude",
        description = "Provide stamina buff to raid (coordinate with other Priests)",
        spellIds = {1243, 1244, 1245, 2791, 10937, 10938, 25389, 48161}, -- All ranks (Cata uses rank 8)
        category = "buff",
    },
}

-- Add spec-level spell locations to defaults
-- Note: specNames order is SHADOW, HOLY, DISCIPLINE (1, 2, 3)
defaults.class.specSpellLocations = {
    [1] = {  -- Shadow
        [34433] = NAG.SPELL_POSITIONS.BELOW,
        [26297] = NAG.SPELL_POSITIONS.LEFT, [87151] = NAG.SPELL_POSITIONS.LEFT, [82174] = NAG.SPELL_POSITIONS.LEFT
    },
    [2] = {  -- Holy
    },
    [3] = {  -- Discipline
    }
}

-- Shadow Rotation
local shadowRotation = {
    name = "Cataclysm Shadow",
    specIndex = 1,
    class = "PRIEST",
    authors = { "@Jiw" },
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = false,
    prePull = {
        { time = -5, action = "NAG:Cast(15473)" },
        { time = -1, action = "NAG:Cast(73510)" },
        { time = -1, action = "NAG:Cast(NAG:GetBattlePotion())" }
    },
    burstTrackers = {
        { spellId = 87151, auraId = { 87151, 87153 } } -- Archangel with multiple aura IDs to track
    },
    rotationString = [[
    NAG:AutocastOtherCooldowns()
    or     ((not NAG:IsActive(15473)) and NAG:Cast(15473))
    or     (NAG:IsReady(26297) and NAG:Cast(26297))
    or     (NAG:IsReady(82174) and NAG:Cast(82174))
    or     (NAG:IsReady(NAG:GetBattlePotion()) and NAG:Cast(NAG:GetBattlePotion()))
    or     ((NAG:IsReady(34433) and ((not NAG:SpellIsKnown(105844)) and (not NAG:SpellIsKnown(105844)))) and NAG:Cast(34433))
    or     ((NAG:IsReady(34433) and NAG:IsActive(87153) and (NAG:SpellIsKnown(105844) or NAG:SpellIsKnown(105844))) and NAG:Cast(34433))
    or     ((NAG:UnitIsMoving() and (NAG:DotRemainingTime(589) <= 6.0)) and NAG:Cast(589))
    or     ((NAG:UnitIsMoving() and (NAG:DotRemainingTime(2944) <= 9.0)) and NAG:MultiDot(2944, 1, 0.0))
    or     ((((not NAG:DotIsActive(34914)) or (NAG:DotRemainingTime(34914) <= 1.0)) and NAG:IsActive(95799) and (NAG:RemainingTime() >= 9.0)) and NAG:Cast(34914))
    or     ((((not NAG:DotIsActive(589)) or (NAG:DotRemainingTime(589) <= 0.5)) and (NAG:RemainingTime() >= 14.0)) and NAG:Cast(589))
    -- Hide: or (((not NAG:DotIsActive(589)) or (NAG:DotRemainingTime(589) <= 1.0)) and NAG:Cast(589))
    or     (((not NAG:DotIsActive(2944)) and NAG:IsActive(95799) and (NAG:RemainingTime() >= 15.0)) and NAG:MultiDot(2944, 1, 0.0))
    or     (((NAG:AuraNumStacks(77487) >= 3.0) and (NAG:TimeToReady(8092) >= 2.0) and (NAG:SpellIsKnown(105844) or NAG:SpellIsKnown(105844))) and NAG:Cast(73510))
    or     (((NAG:AuraNumStacks(87118) >= 5.0) and (NAG:DotRemainingTime(34914) >= 6.0) and (NAG:DotRemainingTime(2944) >= 6.0) and NAG:IsReady(87151)) and NAG:Cast(87151))
    or     ((NAG:IsActive(77487)) and NAG:Cast(8092))
    or     (((((NAG:CurrentManaPercent() <= 0.20) and (NAG:RemainingTimePercent() >= 50.0)) or ((NAG:CurrentManaPercent() <= 0.10) and (NAG:RemainingTimePercent() >= 25.0))) and NAG:IsReady(47585)) and NAG:Cast(47585))
    or     ((NAG:SpellCanCast(32379) and NAG:IsExecutePhase(25)) and NAG:Cast(32379))
    or     NAG:ChannelSpell(15407, function() return (NAG:GCDTimeToReady() <= NAG:ChannelClipDelay()) end, true)
]]
}

--[[ Holy
ns.AddRotationToDefaults(defaults, 2, "Cataclysm Holy", {  -- Holy
    default = true,
    enabled = false,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    talents = {},
    experimental = true,
    prePull = prePullHoly or prePullPriestHoly or nil,
    resourceBar = resourceBarHoly or resourceBarPriestHoly or nil,
    guitarHeroBar = guitarHeroBarHoly or guitarHeroBarPriestHoly or nil,
    burstTrackers = burstTrackersHoly or burstTrackersPriestHoly or nil,
    spells = spellsHoly or spellsPriestHoly or nil,
    auras = aurasHoly or aurasPriestHoly or nil,
    items = itemsHoly or itemsPriestHoly or nil,
    consumes = consumesHoly or consumesPriestHoly or nil,
    customVariables = customVariablesHoly or customVariablesPriestHoly or nil,
    macros = macrosHoly or macrosPriestHoly or nil,
    rotationString = rotationStringHoly or rotationStringPriestHoly or debugRotationPriestHoly
})
]]

--[[ Discipline
ns.AddRotationToDefaults(defaults, 3, "Cataclysm Discipline", {  -- Discipline
    default = true,
    enabled = false,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    talents = {},
    experimental = true,
    prePull = prePullDiscipline or prePullPriestDiscipline or nil,
    resourceBar = resourceBarDiscipline or resourceBarPriestDiscipline or nil,
    guitarHeroBar = guitarHeroBarDiscipline or guitarHeroBarPriestDiscipline or nil,
    burstTrackers = burstTrackersDiscipline or burstTrackersPriestDiscipline or nil,
    spells = spellsDiscipline or spellsPriestDiscipline or nil,
    auras = aurasDiscipline or aurasPriestDiscipline or nil,
    items = itemsDiscipline or itemsPriestDiscipline or nil,
    consumes = consumesDiscipline or consumesPriestDiscipline or nil,
    customVariables = customVariablesDiscipline or customVariablesPriestDiscipline or nil,
    macros = macrosDiscipline or macrosPriestDiscipline or nil,
    rotationString = rotationStringDiscipline or rotationStringPriestDiscipline or debugRotationPriestDiscipline
})
]]
-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
-- Leave below as is

if UnitClassBase('player') ~= "PRIEST" then return end

--- @class Priest : ClassBase
local Priest = NAG:CreateClassModule("PRIEST", defaults)
if not Priest then return end

-- Setup class defaults during PreDatabaseRegistration
function Priest:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 1, shadowRotation)  -- Shadow
end

function Priest:RegisterSpellTracking()
    --- @type SpellTrackingManager|AceModule|CoreModule
    local SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
        -- Add spells to periodic damage tracking
    SpellTrackingManager:RegisterPeriodicDamage({ 2944 }, { tickTime = nil, lastTickTime = nil })  -- Devouring Plague
    SpellTrackingManager:RegisterPeriodicDamage({ 34914 }, { tickTime = nil, lastTickTime = nil }) -- Vampiric Touch
end

NAG.Class = Priest
