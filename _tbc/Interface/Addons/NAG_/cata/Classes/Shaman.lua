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
        id = "windfury_totem",
        name = "Windfury Totem",
        description = "Place totem that increases melee attack speed (coordinate with other Shamans)",
        spellIds = {8512, 10613, 10614, 25585, 25587}, -- All ranks
        category = "buff",
    },
    {
        id = "strength_of_earth_totem",
        name = "Strength of Earth Totem",
        description = "Place totem that increases strength (coordinate with other Shamans)",
        spellIds = {8075, 8160, 8161, 10442, 25528, 25361, 58643}, -- All ranks (Cata uses rank 8)
        category = "buff",
    },
    {
        id = "bloodlust",
        name = "Bloodlust/Heroism",
        description = "Cast Bloodlust/Heroism for raid-wide haste (coordinate with other Shamans/Mages)",
        spellIds = {2825, 32182}, -- Bloodlust, Heroism
        category = "buff",
    },
}

-- Add spec-level spell locations to defaults
defaults.class.specSpellLocations = {
    [1] = {  -- Elemental
        [2062] = NAG.SPELL_POSITIONS.ABOVE,
        [8071] = NAG.SPELL_POSITIONS.BELOW, [3599] = NAG.SPELL_POSITIONS.BELOW, [5394] = NAG.SPELL_POSITIONS.BELOW,
        [3738] = NAG.SPELL_POSITIONS.BELOW, [8190] = NAG.SPELL_POSITIONS.BELOW,
        [16166] = NAG.SPELL_POSITIONS.LEFT, [2894] = NAG.SPELL_POSITIONS.LEFT, [33697] = NAG.SPELL_POSITIONS.LEFT,
        [79206] = NAG.SPELL_POSITIONS.LEFT, [2825] = NAG.SPELL_POSITIONS.LEFT, [26297] = NAG.SPELL_POSITIONS.LEFT,
        [421] = NAG.SPELL_POSITIONS.AOE, [61882] = NAG.SPELL_POSITIONS.AOE
    },
    [2] = {  -- Enhancement
        [403] = NAG.SPELL_POSITIONS.ABOVE, [401] = NAG.SPELL_POSITIONS.ABOVE,
        [8024] = NAG.SPELL_POSITIONS.ABOVE, [8232] = NAG.SPELL_POSITIONS.ABOVE,
        [3599] = NAG.SPELL_POSITIONS.BELOW, [8075] = NAG.SPELL_POSITIONS.BELOW,
        [8512] = NAG.SPELL_POSITIONS.BELOW, [5394] = NAG.SPELL_POSITIONS.BELOW, [324] = NAG.SPELL_POSITIONS.BELOW,
        [2062] = NAG.SPELL_POSITIONS.LEFT, [2825] = NAG.SPELL_POSITIONS.LEFT, [51533] = NAG.SPELL_POSITIONS.LEFT,
        [33697] = NAG.SPELL_POSITIONS.LEFT, [30823] = NAG.SPELL_POSITIONS.LEFT,
        [1535] = NAG.SPELL_POSITIONS.AOE
    },
    [3] = {  -- Restoration
    }
}

-- Elemental Rotation
local elementalRotation = {
    name = "Cataclysm Elemental - by @Mysto/@Jiw",
    specIndex = 1,
    class = "SHAMAN",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = false,
    prePull = {
        { time = -7, action = "NAG:Cast(8024)" },
        { time = -5, action = "NAG:Cast(324)" },
        { time = -3, action = "NAG:Cast(66842)" },
        { time = -1.5, action = "NAG:Cast(NAG:GetBattlePotion())" },
        { time = -1.5, action = "NAG:Cast(403)" }
    },
    burstTrackers = {
        { spellId = 16166, auraId = { 16166 } }, -- Elemental Mastery
        { spellId = 2825,  auraId = { 2825 } },  -- Bloodlust
    },
    rotationString = [[
        NAG:AutocastOtherCooldowns()
        or ((not NAG:IsActive(324)) and NAG:Cast(324))
        or ((not NAG:IsActive(8024)) and NAG:Cast(8024))
        or (((not NAG:IsActive(2894)) and (NAG:TotemRemainingTime(NAG.Types.TotemType.Fire) <= 3.0)) and NAG:Cast(3599))
        or (((not NAG:IsActive(3738)) and (not NAG:IsActive(49868))) and NAG:Cast(3738))
        or (NAG:IsReady(33697) and NAG:Cast(33697))
        or (NAG:IsReady(26297) and NAG:Cast(26297))
        or (NAG:IsReady(16166) and NAG:Cast(16166))
        or (NAG:IsReady(82174) and NAG:Cast(82174))
        or (NAG:IsReady(NAG:GetBattlePotion()) and NAG:Cast(NAG:GetBattlePotion()))
        or (NAG:IsReady(2825) and NAG:Cast(2825))
        or ((((NAG:DotRemainingTime(8050) <= 1.0) or (not NAG:DotIsActive(8050))) and NAG:IsReady(8050)) and NAG:Cast(8050))
        or ((NAG:UnitIsMoving() and (not NAG:SpellIsKnown(101052)) and (NAG:DotRemainingTime(8050) <= 10.0)) and NAG:Cast(8050))
        --or ((NAG:UnitIsMoving() and (not NAG:SpellIsKnown(101052)) and (NAG:DotRemainingTime(8050) > 10.0)) and NAG:Cast(8042))
        or (((NAG:DotRemainingTime(8050) >= 3.0) and ((NAG:TimeToReady(51505) <= 1.0) or NAG:IsReady(51505))) and NAG:Cast(51505))
        or (((NAG:AuraNumStacks(324) >= 8.0) and (NAG:DotRemainingTime(8050) >= 5.0) and NAG:IsReady(8042)) and NAG:Cast(8042))
        or (((((NAG:CurrentManaPercent() <= 30.0) and (NAG:RemainingTimePercent() >= 50.0)) or ((NAG:CurrentManaPercent() <= 20.0) and (NAG:RemainingTimePercent() >= 35.0)) or ((NAG:CurrentManaPercent() <= 10.0) and (NAG:RemainingTimePercent() >= 20.0)) or ((NAG:CurrentManaPercent() <= 5.0) and (NAG:RemainingTimePercent() >= 10.0)) or (NAG:CurrentManaPercent() <= 3.0)) and NAG:IsReady(51490)) and NAG:Cast(51490))
        or NAG:Cast(403)
]]
}

-- Enhancement (Classic) Rotation
local enhancementRotation = {
    name = "Cataclysm Enhancement - by @Mysto/@Jiw",
    specIndex = 2,
    class = "SHAMAN",
    default = false,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = false,
    prePull = {
        { time = -8, action = "NAG:Cast(8232)" },
        { time = -8, action = "NAG:Cast(8024)" },
        { time = -6, action = "NAG:Cast(324)" },
        { time = -4.5, action = "NAG:Cast(66842)" },
        { time = -3, action = "NAG:Cast(51533)" },
        { time = -1, action = "NAG:Cast(NAG:GetBattlePotion())" },
        { time = -1, action = "NAG:Cast(403)" }
    },
    burstTrackers = {
        { spellId = 51533, auraId = { 51533 } }, -- Feral Spirit
        { spellId = 2825,  auraId = { 2825 } },  -- Bloodlust
    },
    rotationString = [[
        NAG:SpellCastSequence()
        or ((not NAG:IsActive(8232)) and NAG:Cast(8232))
        or ((not NAG:IsActive(8024)) and NAG:Cast(8024))
        or ((not NAG:IsActive(324)) and NAG:Cast(324))
        or (((not NAG:IsActive(8512)) and (not NAG:IsActive(55610)) and (not NAG:IsActive(53290))) and NAG:Cast(8512))
        or (((not NAG:IsActive(8075)) and (not NAG:IsActive(57330)) and (not NAG:IsActive(6673))) and NAG:Cast(8075))
        or (((not NAG:IsActive(2894)) and (NAG:TotemRemainingTime(NAG.Types.TotemType.Fire) <= 3.0) and (NAG:CountEnemiesInRange(10)<= 2.0)) and NAG:Cast(3599))
        or ((NAG:IsReady(26297) and (NAG:CountEnemiesInRange(10)>= 1.0)) and NAG:Cast(26297))
        or ((NAG:IsReady(33697) and (NAG:CountEnemiesInRange(10)>= 1.0)) and NAG:Cast(33697))
        or (NAG:IsReady(2825) and NAG:Cast(2825))
        or ((NAG:IsReady(NAG:GetBattlePotion()) and (NAG:CountEnemiesInRange(10)>= 1.0)) and NAG:Cast(NAG:GetBattlePotion()))
        or ((NAG:IsReady(82174) and (NAG:CountEnemiesInRange(10)>= 1.0)) and NAG:Cast(82174))
        or ((NAG:IsReady(30823) and (NAG:CountEnemiesInRange(10)>= 1.0)) and NAG:Cast(30823))
        or (NAG:IsReady(51533) and NAG:Cast(51533))
        or (((NAG:DotRemainingTime(8050) <= 1.0) or (not NAG:DotIsActive(8050))) and NAG:Cast(8050))
        or (((NAG:AuraNumStacks(51530) >= 3.0) and NAG:IsReady(421) and (NAG:CountEnemiesInRange(10)>= 2.0)) and NAG:Cast(421))
        or (((NAG:CountEnemiesInRange(10)>= 3.0)) and NAG:Cast(8190))
        or ((NAG:IsReady(17364) and (NAG:CountEnemiesInRange(3)>= 1.0)) and NAG:Cast(17364))
        or ((NAG:IsReady(60103) and (NAG:CountEnemiesInRange(3)>= 1.0)) and NAG:Cast(60103))
        or (((NAG:AuraNumStacks(51530) >= 3.0) and (NAG:CountEnemiesInRange(10)== 1.0)) and NAG:Cast(403))
        or (NAG:IsReady(73680) and NAG:Cast(73680))
        or NAG:Cast(8042)
        or ((NAG:CountEnemiesInRange(10)<= 0.0) and NAG:Cast(403))
]]
}

-- Enhancement Snek-Weaving Rotation
local enhancementSnekRotation = {
    name = "Enhancement Snek-Weaving",
    specIndex = 2,
    class = "SHAMAN",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = true,
    prePull = {
        { time = -8, action = "NAG:Cast(8232)" },
        { time = -8, action = "NAG:Cast(8024)" },
        { time = -6, action = "NAG:Cast(324)" },
        { time = -4.5, action = "NAG:Cast(66842)" },
        { time = -3, action = "NAG:Cast(51533)" },
        { time = -1, action = "NAG:Cast(NAG:GetBattlePotion())" },
        { time = -1, action = "NAG:Cast(403)" }
    },
    rotationString = [[
        NAG:AutocastOtherCooldowns()
    or     (NAG:SwingTimeDifference() >= 0.1 and NAG:Cast(10713))
    or     ((not NAG:IsActive(8232)) and NAG:Cast(8232))
    or     ((not NAG:IsActive(8024)) and NAG:Cast(8024))
    or     ((NAG:AuraIsInactive(324)) and NAG:Cast(324))
    or     NAG:Cast(2062)
    or     NAG:Cast(51533)
    or     (((not NAG:DotIsActive(3599))) and NAG:Cast(3599))
    or     IsActionInRange(1,"target") == false and NAG:Cast(73680)
    or     NAG:Cast(17364)
    or     NAG:Cast(60103)
    or     ((NAG:CanWeave(403) and (NAG:AuraNumStacks(51530) >= 3.0)) and NAG:Cast(403))
    or     ((NAG:CurrentTime() <= 7.0) and NAG:Cast(2062))
    or     (((not NAG:DotIsActive(8050)) and NAG:IsActive(73683)) and NAG:Cast(8050))
    or     NAG:Cast(73680)
    or     ((NAG:CanWeave(421)) and NAG:Cast(421))
    or     (((NAG:DotRemainingTime(8050) <= 9) and NAG:IsActive(73683)) and NAG:Cast(8050))
    or     NAG:Cast(8042)
    or     ((NAG:DotRemainingTime(3599) < 15) and NAG:Cast(3599))
    or     ((NAG:TimeToReady(17364) <= NAG:TimeToReady(60103)) and (NAG:TimeToReady(17364) <= NAG:TimeToReady(73680)) and (NAG:TimeToReady(17364) <= NAG:TimeToReady(8042)) and NAG:Cast(17364, 10))
    or     ((NAG:TimeToReady(17364) > NAG:TimeToReady(60103)) and (NAG:TimeToReady(60103) <= NAG:TimeToReady(73680)) and (NAG:TimeToReady(60103) <= NAG:TimeToReady(8042)) and NAG:Cast(60103, 10))
    or     (((NAG:DotRemainingTime(8050) <= 12) and NAG:IsActive(73683) and NAG:Cast(8050, 10)))
    or     NAG:Cast(8042, 10)

    ]]
}

-- Restoration Rotation
local restorationRotation = {
    name = "Cataclysm Restoration - by @Mysto/@Jiw",
    specIndex = 3,
    class = "SHAMAN",
    default = true,
    enabled = false,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = true,
    rotationString = [[
        NAG:AutocastOtherCooldowns()
]]
}
-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
-- Leave below as is

if UnitClassBase('player') ~= "SHAMAN" then return end

--- @class Shaman : ClassBase
local Shaman = NAG:CreateClassModule("SHAMAN", defaults, {
    weakAuraName = "Shaman Next Action Guide",
})
if not Shaman then return end

-- Setup class defaults during PreDatabaseRegistration
function Shaman:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 1, elementalRotation)  -- Elemental
    ns.AddRotationToDefaults(self.defaults, 2, enhancementRotation)  -- Enhancement
    ns.AddRotationToDefaults(self.defaults, 2, enhancementSnekRotation)  -- Enhancement
    ns.AddRotationToDefaults(self.defaults, 3, restorationRotation)  -- Restoration
end

NAG.Class = Shaman
