local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
--- @type SpellTrackingManager|CoreModule

if not Version:IsClassicEra() then return end

if UnitClassBase('player') ~= "WARRIOR" then return end

--- NAG
local defaults = ns.InitializeClassDefaults()

--- Add spec-level spell locations (This needs to be done for all specs for each class at top of file)
defaults.class.specSpellLocations = {
    ['*'] = {
        ABOVE = {},
        BELOW = {},
        RIGHT = {},
        LEFT = {},
        AOE = {}
    },
}

-- Class assignments for raid coordination
defaults.class.classAssignments = {
    {
        id = "sunder_armor",
        name = "Sunder Armor",
        description = "Apply armor reduction debuff on targets (conflicts with Rogue Expose Armor)",
        spellIds = {7386, 7405, 8380, 11596, 11597}, -- All ranks (Vanilla uses up to rank 5)
        category = "debuff",
    },
    {
        id = "demoralizing_shout",
        name = "Demoralizing Shout",
        description = "Reduce enemy attack power (coordinate with other Warriors)",
        spellIds = {1160, 6190, 11554, 11555, 11556}, -- All ranks
        category = "debuff",
    },
    {
        id = "thunder_clap",
        name = "Thunder Clap",
        description = "Reduce enemy attack speed (coordinate with other Warriors)",
        spellIds = {6343, 8198, 8205, 11580, 11581}, -- All ranks
        category = "debuff",
    },
}

-- DPS Rotation (no reck)
local dpsNoReckRotation = {
    name = "Warrior Default - Dps (no reck) by APLParser",
    specIndex = 2,
    class = "WARRIOR",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA,
    prePull = {

    },
    rotationString = [[
    (((NAG:AuraNumStacks(11597) < 1.0) and (not NAG:DotIsActive(11198))) and NAG:Cast(11597))
    or     NAG:Cast(10646)
    or     NAG:Cast(18641)
    or     (((NAG:RemainingTime() <= 30) or (NAG:RemainingTime() >= 211.5)) and NAG:Cast(12328))
    or     (false and NAG:Cast(1719))
    -- Hide: or ((NAG:RemainingTime() <= 15) and NAG:Cast(1719))
    or     (((NAG:RemainingTime() <= 20) or (NAG:RemainingTime() >= 140)) and NAG:Cast(NAG:GetBattlePotion()))
    or     (((NAG:RemainingTime() <= 20) or (NAG:RemainingTime() >= 141.5)) and NAG:Cast(20572))
    or     ((NAG:RemainingTime() <= 60) and NAG:Cast(24427))
    or     (((NAG:RemainingTime() <= 30) or (NAG:RemainingTime() >= 130)) and NAG:Cast(21180))
    or     (((NAG:RemainingTime() <= 30) or (NAG:RemainingTime() >= 130)) and NAG:Cast(29602))
    or     (((NAG:RemainingTime() <= 30) or (NAG:RemainingTime() >= 130)) and NAG:Cast(23041))
    or     (((NAG:RemainingTime() <= 30) or (NAG:RemainingTime() >= 130)) and NAG:Cast(23041))
    or     (((NAG:RemainingTime() <= 30) or (NAG:RemainingTime() >= 140)) and NAG:AutocastOtherCooldowns())
    or     ((NAG:NumberTargets() > 1.0) and NAG:Cast(1680))
    or     (NAG:IsExecutePhase(20) and NAG:Cast(20662))
    or     NAG:Cast(23894)
    or     ((NAG:TimeToReady(23894) > 1.5) and NAG:Cast(1680))
    or     (((NAG:NumberTargets() == 1.0) and ((NAG:CurrentRage() >= 40.0) or NAG:IsExecutePhase(20))) and NAG:Cast(11567))
    or     (((NAG:NumberTargets() > 1.0) and ((NAG:CurrentRage() >= 40.0) or NAG:IsExecutePhase(20))) and NAG:Cast(20569))
    or     (((NAG:TimeToReady(23894) > 1.5) and (NAG:TimeToReady(1680) > 1.5) and (NAG:CurrentRage() > 80.0)) and NAG:Cast(27584))
    or     ((NAG:CurrentRage() < 90.0) and NAG:Cast(2687))
    -- Hide: or (((NAG:TimeToReady(23894) > 1.5) and (NAG:TimeToReady(1680) > 1.5)) and NAG:Cast(18499))
    or     ((not NAG:IsActive(11551)) and NAG:Cast(11551))
    or     ((not NAG:IsActive(2458)) and NAG:Cast(2458))
    ]],
    -- Optional metadata
    glyphs = {},
    lastModified = "04/01/2025",
    author = "APLParser"
}

-- DPS Rotation (with reck)
local dpsWithReckRotation = {
    name = "Warrior Default - Dps (with reck) by APLParser",
    specIndex = 2,
    class = "WARRIOR",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA,
    prePull = {

    },
    rotationString = [[
    (((NAG:AuraNumStacks(11597) < 1.0) and (not NAG:DotIsActive(11198))) and NAG:Cast(11597))
    or     NAG:Cast(10646)
    or     NAG:Cast(18641)
    or     (((NAG:RemainingTime() <= 30) or (NAG:RemainingTime() >= 211.5)) and NAG:Cast(12328))
    -- Hide: or (false and NAG:Cast(1719))
    or     ((NAG:RemainingTime() <= 15) and NAG:Cast(1719))
    or     (((NAG:RemainingTime() <= 20) or (NAG:RemainingTime() >= 140)) and NAG:Cast(NAG:GetBattlePotion()))
    or     (((NAG:RemainingTime() <= 20) or (NAG:RemainingTime() >= 141.5)) and NAG:Cast(20572))
    or     ((NAG:RemainingTime() <= 60) and NAG:Cast(24427))
    or     (((NAG:RemainingTime() <= 30) or (NAG:RemainingTime() >= 130)) and NAG:Cast(21180))
    or     (((NAG:RemainingTime() <= 30) or (NAG:RemainingTime() >= 130)) and NAG:Cast(29602))
    or     (((NAG:RemainingTime() <= 30) or (NAG:RemainingTime() >= 130)) and NAG:Cast(23041))
    or     (((NAG:RemainingTime() <= 30) or (NAG:RemainingTime() >= 130)) and NAG:Cast(23041))
    or     (((NAG:RemainingTime() <= 30) or (NAG:RemainingTime() >= 140)) and NAG:AutocastOtherCooldowns())
    or     ((NAG:NumberTargets() > 1.0) and NAG:Cast(1680))
    or     (NAG:IsExecutePhase(20) and NAG:Cast(20662))
    or     NAG:Cast(23894)
    or     ((NAG:TimeToReady(23894) > 1.5) and NAG:Cast(1680))
    or     (((NAG:NumberTargets() == 1.0) and ((NAG:CurrentRage() >= 40.0) or NAG:IsExecutePhase(20))) and NAG:Cast(11567))
    or     (((NAG:NumberTargets() > 1.0) and ((NAG:CurrentRage() >= 40.0) or NAG:IsExecutePhase(20))) and NAG:Cast(20569))
    or     (((NAG:TimeToReady(23894) > 1.5) and (NAG:TimeToReady(1680) > 1.5) and (NAG:CurrentRage() > 80.0)) and NAG:Cast(27584))
    or     ((NAG:CurrentRage() < 90.0) and NAG:Cast(2687))
    -- Hide: or (((NAG:TimeToReady(23894) > 1.5) and (NAG:TimeToReady(1680) > 1.5)) and NAG:Cast(18499))
    or     ((not NAG:IsActive(11551)) and NAG:Cast(11551))
    or     ((not NAG:IsActive(2458)) and NAG:Cast(2458))
    ]],
    -- Optional metadata
    glyphs = {},
    lastModified = "04/01/2025",
    author = "APLParser"
}

-- Protection Tank Rotation
local protectionTankRotation = {
    name = "Warrior Tank - Phase 1 tanky by APLParser",
    specIndex = 3,
    class = "WARRIOR",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA,
    prePull = {

    },
    rotationString = [[
    NAG:AutocastOtherCooldowns()
    or     NAG:Cast(11605)
    ]],
    -- Optional metadata
    glyphs = {},
    lastModified = "04/01/2025",
    author = "APLParser"
}

--- @class WARRIOR : ClassBase
local WARRIOR = NAG:CreateClassModule("WARRIOR", defaults)
if not WARRIOR then return end

function WARRIOR:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 3, dpsNoReckRotation)
    ns.AddRotationToDefaults(self.defaults, 3, dpsWithReckRotation)
    ns.AddRotationToDefaults(self.defaults, 4, protectionTankRotation)  -- Protection
end

-- Override RegisterSpellTracking to set up class-specific spell tracking
function WARRIOR:RegisterSpellTracking()
    --- @type SpellTrackingManager|CoreModule
    local SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
        -- No spell tracking registrations needed
end

NAG.Class = WARRIOR
