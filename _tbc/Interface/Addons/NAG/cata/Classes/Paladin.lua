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
        id = "blessings",
        name = "Blessings (Kings/Might)",
        description = "Cast blessings on raid members (coordinate with other Paladins to cover all groups)",
        spellIds = {20217, 25898, 19740, 19834, 19835, 19836, 19837, 19838, 25782, 25916}, -- Kings, Might ranks (Cata simplified)
        category = "buff",
    },
}

-- Add spec-level spell locations to defaults
defaults.class.specSpellLocations = {
    [3] = {  -- Retribution
        [86150] = NAG.SPELL_POSITIONS.LEFT, [633] = NAG.SPELL_POSITIONS.LEFT, [1022] = NAG.SPELL_POSITIONS.LEFT,
        [853] = NAG.SPELL_POSITIONS.LEFT, [6940] = NAG.SPELL_POSITIONS.LEFT, [31884] = NAG.SPELL_POSITIONS.LEFT,
        [498] = NAG.SPELL_POSITIONS.LEFT, [31801] = NAG.SPELL_POSITIONS.LEFT, [85696] = NAG.SPELL_POSITIONS.LEFT,
        [31821] = NAG.SPELL_POSITIONS.LEFT, [31842] = NAG.SPELL_POSITIONS.LEFT, [1044] = NAG.SPELL_POSITIONS.LEFT,
        [1038] = NAG.SPELL_POSITIONS.LEFT, [31850] = NAG.SPELL_POSITIONS.LEFT, [20925] = NAG.SPELL_POSITIONS.LEFT,
        [70940] = NAG.SPELL_POSITIONS.LEFT, [642] = NAG.SPELL_POSITIONS.LEFT, [20154] = NAG.SPELL_POSITIONS.LEFT,
        [54428] = NAG.SPELL_POSITIONS.LEFT
    },
    [2] = {  -- Protection
        [86150] = NAG.SPELL_POSITIONS.LEFT, [31850] = NAG.SPELL_POSITIONS.LEFT, [20925] = NAG.SPELL_POSITIONS.LEFT,
        [31884] = NAG.SPELL_POSITIONS.LEFT, [54428] = NAG.SPELL_POSITIONS.LEFT
    },
    [1] = {  -- Holy
    }
}
-- Retribution (old) Rotation
local retributionRotation = {
    name = "Cataclysm Retribution - by @Surveillant & @Mysto",
    specIndex = 3,
    class = "PALADIN",
    default = false,
    enabled = false,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = false,
    prePull = {
        { time = -0.2, action = "NAG:Cast(NAG:GetBattlePotion())" },
        { time = -0.1, action = "NAG:Cast(86150)" },
        { time = 0, action = "NAG:Cast(2825)" },
        { time = 0, action = "NAG:Cast(20271)" }
    },
    burstTrackers = {
        { spellId = 31884, auraId = { 31884 } },       -- Avenging Wrath
        { spellId = 85696, auraId = { 85696 } },       -- Zealotry
        { spellId = 84963, auraId = { 84963, 85696 } } -- Inquisition with multiple aura IDs to track
    },
    rotationString = [[
        (((not NAG:IsActive(31801)) and (not NAG:IsActive(20154))) and NAG:Cast(31801))
        or (((not NAG:IsActive(31801)) and (NAG:NumberTargets() < 3.0)) and NAG:Cast(31801))
        or (((NAG:NumberTargets() >= 4.0) and (not NAG:IsActive(20154))) and NAG:Cast(20154))
        or (((NAG:CurrentHolyPower() == 3.0) or NAG:IsActive(90174)) and NAG:Cast(85696))
        or ((((not NAG:IsActive(84963)) or (NAG:AuraRemainingTime(84963) < 3.5)) and (NAG:RemainingTime() > 6.0) and (NAG:CurrentTime() >= 12.0) and NAG:IsReady(85696)) and NAG:Cast(84963))
        or ((((not NAG:IsActive(84963)) or (NAG:AuraRemainingTime(84963) < 3.5)) and (not NAG:IsReady(85696)) and (NAG:RemainingTime() > 6.0) and (not NAG:SpellCanCast(85696))) and NAG:Cast(84963))
        or (((NAG:CurrentTime() < 12.0) and ((NAG:CurrentHolyPower() == 3.0) or NAG:IsActive(90174)) and (NAG:AuraRemainingTime(84963) < 3.5)) and NAG:Cast(84963))
        or ((not NAG:IsActive(53657)) and NAG:Cast(20271))
        or (((NAG:TimeToReady(85696) <= 10.0) or (NAG:TimeToReady(85696) >= NAG:RemainingTime())) and NAG:Cast(86150))
        or ((NAG:IsActive(85696) and NAG:IsActive(84963) and (NAG:CurrentTime() < 12.0)) and NAG:Cast(31884))
        or ((NAG:IsActive(84963) and (NAG:CurrentTime() >= 12.0)) and NAG:Cast(31884))
        or ((NAG:IsActive(85696) and NAG:IsActive(84963)) and NAG:AutocastOtherCooldowns())
        or (((NAG:TimeToReady(31884) >= 10.0) and (not NAG:IsReady(31884))) and NAG:Cast(82174))
        or (((NAG:CurrentHolyPower() == 3.0) or (NAG:IsActive(90174) and (not NAG:SpellCanCast(35395)))) and NAG:Cast(85256))
        or (((NAG:CurrentHolyPower() < 3.0) and (NAG:NumberTargets() >= 4.0) and NAG:IsActive(20154)) and NAG:Cast(53385))
        or ((NAG:CurrentHolyPower() < 3.0) and NAG:Cast(35395))
        or ((((NAG:TimeToReady(35395) >= 1.0) or (not NAG:IsActive(2825))) and NAG:IsActive(59578)) and NAG:Cast(879))
        or ((NAG:IsActive(31884) or NAG:IsExecutePhase(20)) and NAG:Cast(24275))
        or (((not NAG:IsActive(2825)) or (NAG:TimeToReady(35395) >= 1.0)) and NAG:Cast(20271))
        or (((not NAG:IsActive(2825)) or (NAG:TimeToReady(35395) >= 1.0)) and NAG:Cast(2812))
        or ((((NAG:TimeToReady(35395) >= 1.0) or (not NAG:IsActive(2825))) and (NAG:CurrentMana() >= 16000.0)) and NAG:Cast(26573))
        or ((((not NAG:IsActive(2825)) or (NAG:TimeToReady(35395) >= 1.0)) and (NAG:CurrentManaPercent() < 85.0)) and NAG:Cast(54428))
        or (((NAG:TimeToReady(35395) <= NAG:TimeToReady(20271)) and (NAG:TimeToReady(35395) <= NAG:TimeToReady(2812))) and NAG:Cast(35395))
        or (((NAG:TimeToReady(20271) < NAG:TimeToReady(35395)) and (NAG:TimeToReady(20271) < NAG:TimeToReady(2812))) and NAG:Cast(20271))
        or ((NAG:NumberTargets() >= 4.0) and NAG:CastPlaceholder(53385))
        or ((NAG:NumberTargets() < 4.0) and NAG:CastPlaceholder(35395))
]]
}

-- Protection Rotation
local protectionRotation = {
    name = "Cataclysm Protection - by @Surveillant & @Mysto",
    specIndex = 2,
    class = "PALADIN",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = true,
    prePull = {
        { time = -3, action = "NAG:Cast(54428)" },
        { time = -1.5, action = "NAG:Cast(84963)" },
        { time = 0, action = "NAG:Cast(31884)" }
    },
    guitarHeroBar = {
        tracking = {
            enabled = true,
            iconSize = 24,
            duration = 2.0,
            spacing = 2,
            maxIcons = 8
        },
        appearance = {
            width = 200,
            height = 20,
            texture = "Blizzard",
            segmentTexture = "Blizzard",
            backgroundColor = { 0.1, 0.1, 0.1, 0.8 },
            barColor = { 0.9, 0.9, 0.1, 1 }, -- Gold for Holy Power
            segmentColor = { 1, 0.7, 0, 1 },
            showClassDecoration = true
        },
        trackedSpells = {
            -- Holy Power Generators
            { id = 35395, highlight = { 0.8, 0.8, 0.2 } }, -- Crusader Strike
            { id = 31935, highlight = { 0.7, 0.7, 0.2 } }, -- Avenger's Shield
            -- Holy Power Spenders
            { id = 53600, highlight = { 1, 0.3, 0 } },     -- Shield of the Righteous
            -- Important Cooldowns
            { id = 31884, highlight = { 1, 1, 0.5 } },     -- Avenging Wrath
            { id = 84963, highlight = { 0.8, 0.6, 0 } },   -- Inquisition
            -- Utility/Defensive
            { id = 20925, highlight = { 0.4, 0.8, 1 } },   -- Holy Shield
            { id = 53595, highlight = { 0.4, 0.7, 1 } }    -- Hammer of the Righteous
        },
        auraEffects = {
            {
                auraId = 84963,            -- Inquisition
                texture = "Interface\\Artifacts\\Artifacts-Paladin-Header",
                color = { 1, 0.8, 0, 0.7 } -- Golden glow
            },
            {
                auraId = 31884,            -- Avenging Wrath
                texture = "Interface\\Artifacts\\Artifacts-PaladinProtection-Header",
                color = { 1, 1, 0.4, 0.7 } -- Bright golden glow
            },
            {
                auraId = 85696,            -- Zealotry
                texture = "Interface\\Artifacts\\Artifacts-PaladinRetribution-Header",
                color = { 1, 0.4, 0, 0.7 } -- Orange glow
            }
        }
    },
    rotationString = [[
        NAG:SpellCastSequence()
        or ((not NAG:IsActive(31801)) and NAG:Cast(31801))
        or NAG:Cast(20925)
        or NAG:Cast(31884)
        or (((NAG:AuraRemainingTime(84963) <= 4.5) and (NAG:NumberTargets() >= 3.0) and (NAG:CurrentHolyPower() == 3.0)) and NAG:Cast(84963))
        or ((NAG:CurrentHolyPower() == 3.0) and NAG:Cast(53600))
        or (NAG:IsActive(85043) and NAG:Cast(31935))
        or ((NAG:NumberTargets() <= 2.0) and NAG:Cast(35395))
        or ((NAG:NumberTargets() >= 3.0) and NAG:Cast(53595))
        or NAG:Cast(31935)
        or (NAG:IsExecutePhase(20) and NAG:Cast(24275))
        or NAG:Cast(20271)
        or ((NAG:CurrentManaPercent() >= 40) and NAG:Cast(26573))
        or ((NAG:CurrentManaPercent() >= 80) and NAG:Cast(2812))
        or ((NAG:NumberTargets() <= 2.0) and NAG:CastPlaceholder(35395))
        or ((NAG:NumberTargets() >= 3.0) and NAG:CastPlaceholder(53595))
]]
}

-- Holy Rotation
local holyRotation = {
    name = "Cataclysm Holy - by @Surveillant & @Mysto",
    specIndex = 1,
    class = "PALADIN",
    default = true,
    enabled = false,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = true,
    rotationString = [[
        NAG:AutocastOtherCooldowns()
]]
}

-- Retribution AoK Rotation
local retributionAoKRotation = {
    name = "Paladin Retribution - AoK by surveillant @ Ebon Hold",
    specIndex = 3,
    class = "PALADIN",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = false,
    prePull = {
        { time = -0.1, action = "NAG:Cast(NAG:GetBattlePotion())" },
        { time = -0.1, action = "NAG:Cast(86150)" },
        { time = 0, action = "NAG:Cast(2825)" },
        { time = 0, action = "NAG:Cast(20271)" }
    },
    items = { 68972, 69113 },
    spells = { 879, 2812, 2825, 20154, 20271, 24275, 26573, 28730, 31801, 31884, 35395, 53385, 53657, 54428, 54934, 58146, 59578, 68972, 69002, 69113, 82174, 84963, 85256, 85696, 86150, 90174, 96923, 96929, 99116, 105767 },
    version = "3.2.1",
    lastModified = "12/06/2024",
    author = "surveillant @ Ebon Hold",
    rotationString = [[
    NAG:AutocastOtherCooldowns()
    or     (((not NAG:IsActive(31801)) and (NAG:NumberTargets() <= 3.0)) and NAG:Cast(31801))
    or     (((NAG:NumberTargets() >= 4.0) and (not NAG:IsActive(20154))) and NAG:Cast(20154))
    or     (((not NAG:IsActive(31801)) and (not NAG:IsActive(20154))) and NAG:Cast(31801))
    or     ((NAG:IsActive(31884) or (NAG:TimeToReady(31884) >= 55.0) or NAG:SpellIsKnown(69002)) and NAG:Cast(69002))
    or     (((not NAG:SpellIsKnown(69113)) and (not NAG:SpellIsKnown(68972)) and NAG:IsActive(31884) and ((NAG:CurrentHolyPower() == 3.0) or NAG:IsActive(90174) or NAG:IsActive(85696))) and NAG:Cast(31884))
    or     (((NAG:SpellIsKnown(69113) or NAG:SpellIsKnown(68972)) and NAG:IsActive(85696) and (NAG:TimeToReady(85696) < 116.0) and ((not NAG:TierSetEquipped(12, 4)) or (NAG:AuraNumStacks(96923) == 5.0) or (NAG:AuraRemainingTime(85696) < 16.0)) and (((NAG:CurrentHolyPower() < 3.0) and NAG:SpellCanCast(35395)) or ((NAG:CurrentHolyPower() == 3.0) or NAG:AuraIsActive(90174)))) and NAG:Cast(69113))
    or     (((NAG:SpellIsKnown(69113) or NAG:SpellIsKnown(68972)) and NAG:IsActive(85696) and (NAG:TimeToReady(85696) < 116.0) and ((not NAG:TierSetEquipped(12, 4)) or (NAG:AuraNumStacks(96923) == 5.0) or (NAG:AuraRemainingTime(85696) < 16.0)) and (((NAG:CurrentHolyPower() < 3.0) and NAG:SpellCanCast(35395)) or ((NAG:CurrentHolyPower() == 3.0) or NAG:AuraIsActive(90174)))) and NAG:Cast(68972))
    or     (((NAG:SpellIsKnown(69113) or NAG:SpellIsKnown(68972)) and NAG:IsActive(85696) and (NAG:TimeToReady(85696) < 116.0) and ((not NAG:TierSetEquipped(12, 4)) or (NAG:AuraNumStacks(96923) == 5.0) or (NAG:AuraRemainingTime(85696) < 16.0)) and (((NAG:CurrentHolyPower() < 3.0) and NAG:SpellCanCast(35395)) or ((NAG:CurrentHolyPower() == 3.0) or NAG:AuraIsActive(90174)))) and NAG:Cast(31884))
    or     ((((NAG:NumStatBuffCooldowns(1, -1, -1) >= 1.0) and (NAG:IsActive(31884) or ((not NAG:IsActive(85696)) and (NAG:TimeToReady(85696) > 35.0)) or (NAG:IsActive(85696) and (NAG:TimeToReady(85696) < 116.0)))) or ((NAG:NumStatBuffCooldowns(1, -1, -1) == 0.0) and (NAG:IsActive(31884) or ((not NAG:IsActive(85696)) and (NAG:TimeToReady(85696) > 55.0))) and (not NAG:SpellIsKnown(69113)) and (not NAG:SpellIsKnown(68972))) or ((NAG:SpellIsKnown(69113) or NAG:SpellIsKnown(68972)) and (NAG:IsActive(85696) or (NAG:TimeToReady(85696) > 55.0) or ((NAG:IsReady(85696) or (NAG:TimeToReady(85696) <= 5.0)) and (NAG:AuraIsActive(90174) or (NAG:CurrentHolyPower() >= 2.0)))))) and NAG:Cast(82174))
    or     (((not NAG:IsActive(85696)) and NAG:IsReady(85696) and ((NAG:AuraIsInactive(90174) and (NAG:CurrentHolyPower() < 2.0)) or (NAG:AuraIsActive(90174) and (NAG:CurrentHolyPower() == 2.0)))) and NAG:Cast(35395))
    or     (((not NAG:IsActive(53657)) and ((not NAG:SpellIsKnown(105767)) or (NAG:SpellIsKnown(105767) and NAG:AuraIsInactive(90174) and (NAG:CurrentHolyPower() < 3.0)))) and NAG:Cast(20271))
    or     ((NAG:CurrentMana() < 16000.0) and NAG:Cast(28730))
    or     ((((NAG:AuraRemainingTime(85696) < 34.0) and NAG:TierSetEquipped(12, 4) and NAG:IsActive(85696)) or ((not NAG:TierSetEquipped(12, 4)) and ((NAG:TimeToReady(85696) <= 10.0) or (NAG:TimeToReady(85696) >= NAG:RemainingTime())))) and NAG:Cast(86150))
    or     ((NAG:IsActive(31884) and NAG:IsActive(85696)) and NAG:Cast(58146))
    or     ((((not NAG:TierSetEquipped(12, 4)) and (NAG:AuraRemainingTime(84963) >= 20.0)) and (NAG:IsActive(90174) or (NAG:CurrentHolyPower() == 3.0))) and NAG:Cast(85696))
    or     (((not NAG:TierSetEquipped(12, 4)) and (NAG:AuraRemainingTime(84963) >= 20.0) and NAG:IsActive(85696)) and NAG:Cast(31884))
    or     (((NAG:TierSetEquipped(12, 4) or (not NAG:IsActive(84963)) or (NAG:AuraRemainingTime(84963) < 20.0)) and (NAG:IsActive(90174) or (NAG:CurrentHolyPower() == 3.0))) and NAG:Cast(85696))
    or     ((NAG:IsActive(85696) and ((NAG:TierSetEquipped(12, 4) and (NAG:AuraRemainingTime(85696) < 34.0)) or ((not NAG:TierSetEquipped(12, 4)) and (NAG:AuraRemainingTime(85696) < 19.0)))) and NAG:Cast(31884))
    or     (((NAG:CurrentHolyPower() == 3.0) or NAG:IsActive(90174)) and NAG:Cast(85696))
    or     (((NAG:CurrentHolyPower() < 3.0) and (NAG:NumberTargets() >= 4.0) and NAG:IsActive(20154)) and NAG:Cast(53385))
    or     ((NAG:CurrentHolyPower() < 3.0) and NAG:Cast(35395))
    or     ((((not NAG:IsActive(84963)) or (NAG:AuraRemainingTime(84963) < 1.5)) and (NAG:RemainingTime() > 6.0) and (NAG:CurrentTime() >= 12.0) and NAG:IsReady(85696) and ((NAG:CurrentHolyPower() >= 1.0) or NAG:IsActive(90174))) and NAG:Cast(84963))
    or     ((((not NAG:IsActive(84963)) or (NAG:AuraRemainingTime(84963) < 1.5)) and (not NAG:IsReady(85696)) and (NAG:RemainingTime() > 6.0) and (not NAG:SpellCanCast(85696)) and ((NAG:CurrentHolyPower() >= 1.0) or NAG:IsActive(90174))) and NAG:Cast(84963))
    or     (((NAG:CurrentTime() < 12.0) and ((NAG:CurrentHolyPower() == 3.0) or NAG:IsActive(90174)) and (NAG:AuraRemainingTime(84963) < 1.5)) and NAG:Cast(84963))
    or     ((NAG:SpellIsKnown(105767) and NAG:AuraIsInactive(90174) and (not NAG:IsActive(85696)) and (NAG:CurrentHolyPower() < 3.0)) and NAG:Cast(20271))
    or     ((NAG:AuraIsActive(90174) or ((NAG:CurrentHolyPower() == 3.0) and (((not NAG:SpellIsKnown(54934)) and NAG:IsActive(85696)) or (NAG:TimeToReady(35395) <= 1.25) or NAG:IsActive(96929)))) and NAG:Cast(85256))
    or     ((NAG:SpellIsKnown(105767) and (not NAG:IsActive(85696)) and (NAG:CurrentHolyPower() < 3.0)) and NAG:Cast(20271))
    or     (NAG:AuraIsActive(59578) and NAG:Cast(879))
    or     (((NAG:CurrentHolyPower() == 3.0) and (NAG:TimeToReady(35395) > 1.25)) and NAG:Cast(85256))
    or     ((NAG:IsExecutePhase(20) or NAG:IsActive(31884)) and NAG:Cast(24275))
    or     (((not NAG:SpellIsKnown(105767)) or (NAG:SpellIsKnown(105767) and NAG:IsActive(85696) and (NAG:CurrentHolyPower() < 3.0))) and NAG:Cast(20271))
    or     NAG:Cast(2812)
    or     ((NAG:CurrentMana() > 16000.0) and NAG:Cast(26573))
    or     ((((not NAG:IsActive(2825)) or (NAG:TimeToReady(35395) >= 1.5)) and (NAG:CurrentManaPercent() < 85.0)) and NAG:Cast(54428))
    or     (((NAG:TimeToReady(35395) <= NAG:TimeToReady(20271)) and (NAG:TimeToReady(35395) <= NAG:TimeToReady(2812))) and NAG:Cast(35395))
    or     (((NAG:TimeToReady(20271) < NAG:TimeToReady(35395)) and (NAG:TimeToReady(20271) < NAG:TimeToReady(2812))) and NAG:Cast(20271))
    or     (NAG:CastPlaceholder(35395))
]]
}

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
-- Leave below as is

if UnitClassBase('player') ~= "PALADIN" then return end

--- @class Paladin : ClassBase
local Paladin = NAG:CreateClassModule("PALADIN", defaults, {
    weakAuraName = "Paladin Next Action Guide",
})
if not Paladin then return end

-- Setup class defaults during PreDatabaseRegistration
function Paladin:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 3, retributionAoKRotation)  -- Retribution
    ns.AddRotationToDefaults(self.defaults, 1, holyRotation)  -- Holy
    ns.AddRotationToDefaults(self.defaults, 2, protectionRotation)  -- Protection
    ns.AddRotationToDefaults(self.defaults, 3, retributionRotation)  -- Retribution
end

NAG.Class = Paladin
