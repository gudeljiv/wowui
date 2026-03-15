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

if UnitClassBase('player') ~= "DRUID" then return end

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
        id = "faerie_fire",
        name = "Faerie Fire",
        description = "Apply armor reduction debuff on targets (conflicts with Sunder Armor/Expose Armor)",
        spellIds = {770, 778, 9749, 9907}, -- All ranks (includes Feral version)
        category = "debuff",
    },
    {
        id = "mark_of_the_wild",
        name = "Mark of the Wild",
        description = "Provide stats buff to raid (coordinate with other Druids)",
        spellIds = {1126, 5232, 6756, 5234, 8907, 9884, 9885}, -- All ranks
        category = "buff",
    },
    {
        id = "innervate",
        name = "Innervate",
        description = "Provide mana regeneration (coordinate with other healers/Druids)",
        spellIds = {29166}, -- Innervate
        category = "utility",
    },
}
-- Feral Rotation
local feralRotation = {
    name = "Druid Feral - Phase 2 by EbonHold",
    specIndex = 1,
    class = "DRUID",
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_ERA,
    prePull = {
        { time = 1.0, action = "NAG:Cast(17392)" },
        { time = 3.5, action = "NAG:Cast(9846)" }
    },
    rotationString = [[
    (((NAG:DotRemainingTime(17392) <= 1.0) and (NAG:DotRemainingTime(9907) <= 1.0)) and NAG:Cast(17392))
    or     ((NAG:IsActive(768) and NAG:SpellIsKnown(13494) and (not NAG:IsActive(13494)) and (NAG:CurrentTime() < 90.0)) and NAG:Cast(13494))
    or     (NAG:IsActive(768) and NAG:AutocastOtherCooldowns())
    or     ((NAG:SpellIsKnown(17061) and (NAG:CurrentMana() >= NAG:SpellCurrentCost(768)) and NAG:GCDIsReady() and (NAG:SpellIsKnown(16870) and NAG:IsActive(16870) and (NAG:CurrentEnergy() < 27.8))) and NAG:CancelAura(768))
    or     (((NAG:CurrentComboPoints() == 5.0) and (not NAG:IsActive(16870)) and ((NAG:CurrentEnergy() + 20.2) < (NAG:SpellCurrentCost(9830) + NAG:SpellCurrentCost(22829)))) and NAG:Cast(22829))
    or     NAG:Cast(9830)
    or     ((NAG:SpellIsKnown(17061) and (NAG:CurrentMana() >= NAG:SpellCurrentCost(768)) and (NAG:TimeToEnergyTick() > 1.02)) and NAG:Cast(9850))
    or     ((NAG:SpellIsKnown(17061) and (NAG:CurrentMana() >= NAG:SpellCurrentCost(768)) and NAG:GCDIsReady() and (((NAG:CurrentComboPoints() < 5.0) and ((NAG:CurrentEnergy() + 20.2) < NAG:SpellCurrentCost(9830))) or ((NAG:CurrentComboPoints() == 5.0) and ((NAG:CurrentEnergy() + 20.2) < NAG:SpellCurrentCost(22829))) or (NAG:SpellIsKnown(16870) and NAG:IsActive(16870) and (NAG:CurrentEnergy() < 27.8)))) and NAG:CancelAura(768))
    or     (((NAG:DotRemainingTime(17392) <= 14.0) and (NAG:DotRemainingTime(9907) <= 14.0)) and NAG:Cast(17392))
    or     ((not NAG:IsActive(768)) and NAG:Cast(10646))
    or     (((not NAG:IsActive(768)) and ((NAG:CurrentMana() + 1500.0) <= (NAG:CurrentMana() / NAG:CurrentManaPercent()))) and NAG:Cast(12662))
    or     (((not NAG:IsActive(768)) and ((NAG:CurrentMana() + 2250.0) <= (NAG:CurrentMana() / NAG:CurrentManaPercent()))) and NAG:Cast(NAG:GetBattlePotion()))
    or     (((not NAG:IsActive(768)) and (NAG:CurrentManaPercent() <= 80) and (not ((NAG:SpellIsKnown(12662) and NAG:IsReady(12662)) or (NAG:SpellIsKnown(NAG:GetBattlePotion()) and NAG:IsReady(NAG:GetBattlePotion()))))) and NAG:Cast(23724))
    or     (((not NAG:IsActive(768)) and (NAG:CurrentManaPercent() <= 40) and (NAG:RemainingTime() >= 20.0) and (not ((NAG:SpellIsKnown(12662) and NAG:IsReady(12662)) or (NAG:SpellIsKnown(NAG:GetBattlePotion()) and NAG:IsReady(NAG:GetBattlePotion()))))) and NAG:Cast(29166))
    or     ((not NAG:IsActive(768)) and NAG:Cast(768))
    ]],

    -- Optional metadata
    glyphs = {},
    lastModified = "04/01/2025",
    author = "EbonHold"
}

--- @class DRUID : ClassBase
local DRUID = NAG:CreateClassModule("DRUID", defaults)
if not DRUID then return end

function DRUID:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 1, feralRotation)  -- Feral
end

-- Override RegisterSpellTracking to set up class-specific spell tracking
function DRUID:RegisterSpellTracking()
    local SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
    --- @type SpellTrackingManager|CoreModule

        -- No spell tracking registrations needed
end

NAG.Class = DRUID
