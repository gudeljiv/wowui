local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
local UnitAffectingCombat = _G.UnitAffectingCombat
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
--- @type SpellTrackingManager|AceModule|CoreModule

--- NAG
local defaults = ns.InitializeClassDefaults()

defaults.class.specSpellLocations = {
    [1] = {  -- Blood
        [49222] = NAG.SPELL_POSITIONS.ABOVE, [48707] = NAG.SPELL_POSITIONS.ABOVE, [48792] = NAG.SPELL_POSITIONS.ABOVE,
        [77606] = NAG.SPELL_POSITIONS.ABOVE, [48266] = NAG.SPELL_POSITIONS.ABOVE, [48265] = NAG.SPELL_POSITIONS.ABOVE,
        [48263] = NAG.SPELL_POSITIONS.ABOVE, [47528] = NAG.SPELL_POSITIONS.ABOVE, [61999] = NAG.SPELL_POSITIONS.ABOVE,
        [56222] = NAG.SPELL_POSITIONS.ABOVE, [42650] = NAG.SPELL_POSITIONS.ABOVE, [48743] = NAG.SPELL_POSITIONS.ABOVE,
        [47476] = NAG.SPELL_POSITIONS.ABOVE, [45524] = NAG.SPELL_POSITIONS.ABOVE, [55233] = NAG.SPELL_POSITIONS.ABOVE,
        [51052] = NAG.SPELL_POSITIONS.ABOVE, [49039] = NAG.SPELL_POSITIONS.ABOVE, [48982] = NAG.SPELL_POSITIONS.ABOVE,
        [77575] = NAG.SPELL_POSITIONS.BELOW, [57330] = NAG.SPELL_POSITIONS.BELOW,
        [45529] = NAG.SPELL_POSITIONS.LEFT, [47568] = NAG.SPELL_POSITIONS.LEFT, [3714] = NAG.SPELL_POSITIONS.LEFT,
        [49028] = NAG.SPELL_POSITIONS.LEFT, [49016] = NAG.SPELL_POSITIONS.LEFT, [63560] = NAG.SPELL_POSITIONS.LEFT,
        [49206] = NAG.SPELL_POSITIONS.LEFT, [51271] = NAG.SPELL_POSITIONS.LEFT, [46584] = NAG.SPELL_POSITIONS.LEFT,
        [43265] = NAG.SPELL_POSITIONS.AOE, [47541] = NAG.SPELL_POSITIONS.AOE
    },
    [2] = {  -- Frost
        [48707] = NAG.SPELL_POSITIONS.ABOVE, [48792] = NAG.SPELL_POSITIONS.ABOVE, [77606] = NAG.SPELL_POSITIONS.ABOVE,
        [48266] = NAG.SPELL_POSITIONS.ABOVE, [48265] = NAG.SPELL_POSITIONS.ABOVE, [48263] = NAG.SPELL_POSITIONS.ABOVE,
        [47528] = NAG.SPELL_POSITIONS.ABOVE, [61999] = NAG.SPELL_POSITIONS.ABOVE, [56222] = NAG.SPELL_POSITIONS.ABOVE,
        [42650] = NAG.SPELL_POSITIONS.ABOVE, [48743] = NAG.SPELL_POSITIONS.ABOVE, [47476] = NAG.SPELL_POSITIONS.ABOVE,
        [45524] = NAG.SPELL_POSITIONS.ABOVE, [55233] = NAG.SPELL_POSITIONS.ABOVE, [51052] = NAG.SPELL_POSITIONS.ABOVE,
        [49039] = NAG.SPELL_POSITIONS.ABOVE, [48982] = NAG.SPELL_POSITIONS.ABOVE,
        [45529] = NAG.SPELL_POSITIONS.LEFT, [47568] = NAG.SPELL_POSITIONS.LEFT, [3714] = NAG.SPELL_POSITIONS.LEFT,
        [49028] = NAG.SPELL_POSITIONS.LEFT, [49016] = NAG.SPELL_POSITIONS.LEFT, [63560] = NAG.SPELL_POSITIONS.LEFT,
        [49206] = NAG.SPELL_POSITIONS.LEFT, [51271] = NAG.SPELL_POSITIONS.LEFT, [46584] = NAG.SPELL_POSITIONS.LEFT,
        [77575] = NAG.SPELL_POSITIONS.AOE, [43265] = NAG.SPELL_POSITIONS.AOE, [48721] = NAG.SPELL_POSITIONS.AOE,
        [47541] = NAG.SPELL_POSITIONS.AOE, [49222] = NAG.SPELL_POSITIONS.AOE
    },
    [3] = {  -- Unholy
        [48263] = NAG.SPELL_POSITIONS.ABOVE, [49222] = NAG.SPELL_POSITIONS.ABOVE, [47541] = NAG.SPELL_POSITIONS.ABOVE,
        [48707] = NAG.SPELL_POSITIONS.ABOVE, [48792] = NAG.SPELL_POSITIONS.ABOVE, [77606] = NAG.SPELL_POSITIONS.ABOVE,
        [48266] = NAG.SPELL_POSITIONS.ABOVE, [48265] = NAG.SPELL_POSITIONS.ABOVE, [47528] = NAG.SPELL_POSITIONS.ABOVE,
        [61999] = NAG.SPELL_POSITIONS.ABOVE, [56222] = NAG.SPELL_POSITIONS.ABOVE, [42650] = NAG.SPELL_POSITIONS.ABOVE,
        [48743] = NAG.SPELL_POSITIONS.ABOVE, [47476] = NAG.SPELL_POSITIONS.ABOVE, [45524] = NAG.SPELL_POSITIONS.ABOVE,
        [55233] = NAG.SPELL_POSITIONS.ABOVE, [51052] = NAG.SPELL_POSITIONS.ABOVE, [49039] = NAG.SPELL_POSITIONS.ABOVE,
        [48982] = NAG.SPELL_POSITIONS.ABOVE,
        [46584] = NAG.SPELL_POSITIONS.RIGHT,
        [45529] = NAG.SPELL_POSITIONS.LEFT, [47568] = NAG.SPELL_POSITIONS.LEFT, [3714] = NAG.SPELL_POSITIONS.LEFT,
        [49028] = NAG.SPELL_POSITIONS.LEFT, [49016] = NAG.SPELL_POSITIONS.LEFT, [63560] = NAG.SPELL_POSITIONS.LEFT,
        [49206] = NAG.SPELL_POSITIONS.LEFT, [51271] = NAG.SPELL_POSITIONS.LEFT,
        [77575] = NAG.SPELL_POSITIONS.AOE, [43265] = NAG.SPELL_POSITIONS.AOE, [48721] = NAG.SPELL_POSITIONS.AOE
    }
}
-- LOCAL_DEFS_START
-- Blood - Defensive Rotation
local bloodDefensiveRotation = {
    name = "DeathKnight Blood - Defensive",
    specIndex = 1,
    class = "DEATHKNIGHT",
    authors = { "@APLParser" },
    default = false,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = true,
    prePull = {
        { time = -65, action = "NAG:Cast(48263)" },
        { time = -64, action = "NAG:Cast(57330)" },
        { time = -55, action = "NAG:Cast(49222)" },
        { time = -44, action = "NAG:Cast(57330)" },
        { time = -30, action = "NAG:Cast(43265)" },
        { time = -22, action = "NAG:Cast(57330)" },
        { time = -7, action = "NAG:Cast(42650)" },
        { time = -1.5, action = "NAG:Cast(57330)" },
        { time = -1, action = "NAG:Cast(NAG:GetBattlePotion())" }
    },
    glyphs = { 43827, 43534, 43550, 43533, 45799, 43536, 43673, 43671, 43544 },
    spells = { 42650, 43265, 45529, 46584, 47568, 48263, 48721, 48743, 48792, 48982, 49222, 49998, 55050, 55095, 55233, 56815, 57330, 77535, 77575, 81130, 81141, 81256, 82176, 96171 },
    rotationString = [[
NAG:SpellCastSequence()
    or     ((not NAG:IsActive(48263)) and NAG:Cast(48263))
    or     NAG:AutocastOtherCooldowns()
    or     ((NAG:CurrentHealthPercent() <= 0.55) and NAG:Cast(48743))
    or     ((NAG:CurrentTime() >= 89) and NAG:Cast(48792))
    or     (((NAG:DotRemainingTime(81130) <= 1.0) or (NAG:DotRemainingTime(55095) <= 1.0)) and NAG:Cast(77575))
    or     ((not NAG:IsActive(49222)) and NAG:StrictSequence('someName757', 45529, 49222))
    or     ((NAG:CurrentHealthPercent() <= 0.60) and NAG:Cast(55233))
    or     (NAG:IsActive(55233) and NAG:Cast(82176))
    or     (NAG:IsActive(96171) and NAG:Cast(48982))
    or     (((NAG:CurrentHealthPercent() <= 0.50) and (not NAG:SpellCanCast(49998))) and NAG:Cast(47568))
    or     (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 2.0) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 2.0) or (NAG:CurrentHealthPercent() <= 0.50) or (not NAG:IsActive(77535))) and NAG:Cast(49998))
    or     ((NAG:CurrentRunicPower() >= 120.0) and NAG:Cast(56815))
    or     ((((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 1.0) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 1.0) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 1.0)) and (not NAG:SpellCanCast(49998))) and NAG:StrictSequence('someName583', 45529, 49998))
    or     NAG:Cast(49998)
    or     ((not NAG:IsActive(81256)) and NAG:Cast(46584))
    or     (((NAG:CurrentHealthPercent() <= 0.80) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 2.0)) and NAG:Cast(48982))
    or     (NAG:IsActive(81141) and NAG:Cast(48721))
    or     ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) == 2.0) and NAG:Cast(55050))
    or     NAG:Cast(56815)
    or     NAG:Cast(57330)
    or     ((((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) < NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) or (NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) < NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)))) and NAG:Cast(55050, 10))
    or     NAG:Cast(49998, 10)
]]
}

-- Blood - Simple Rotation
local bloodSimpleRotation = {
    name = "DeathKnight Blood - Damage",
    specIndex = 1,
    class = "DEATHKNIGHT",
    authors = { "@APLParser" },
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = true,
    prePull = {
        { time = -65, action = "NAG:Cast(48263)" },
        { time = -64, action = "NAG:Cast(57330)" },
        { time = -55, action = "NAG:Cast(49222)" },
        { time = -44, action = "NAG:Cast(57330)" },
        { time = -30, action = "NAG:Cast(43265)" },
        { time = -22, action = "NAG:Cast(57330)" },
        { time = -7, action = "NAG:Cast(42650)" },
        { time = -1.5, action = "NAG:Cast(57330)" },
        { time = -1, action = "NAG:Cast(NAG:GetBattlePotion())" }
    },
    glyphs = { 43827, 43534, 43550, 43533, 45799, 43536, 43673, 43671, 43544 },
    spells = { 26297, 33697, 42650, 43265, 45529, 46584, 47568, 48263, 48721, 48743, 48792, 48982, 49028, 49222, 49998, 53365, 55050, 55078, 55095, 55233, 56815, 57330, 77575, 81141, 81256, 82174, 96171 },
    rotationString = [[
    ((not NAG:IsActive(48263)) and NAG:Cast(48263))
    or     (((not NAG:IsActive(49222)) and (not UnitAffectingCombat("player"))) and NAG:Cast(49222))
    or     ((NAG:CurrentHealthPercent() <= 0.55) and NAG:Cast(48743))
    or     NAG:AutocastOtherCooldowns()
    or     ((NAG:CurrentTime() <= 3) and NAG:Cast(49998))
    or     ((NAG:CurrentTime() <= 3) and NAG:Cast(55050))
    or     ((NAG:RemainingTime() <= 3) and NAG:Cast(49998))
    or     ((NAG:RemainingTime() <= 3) and NAG:Cast(55050))
    or     (NAG:IsReady(49028) and NAG:Cast(NAG:GetBattlePotion()))
    or     ((NAG:IsReady(49028) and NAG:IsActive(53365) and NAG:SpellIsKnown(53365)) and NAG:Cast(26297))
    or     ((NAG:IsReady(49028) and NAG:IsActive(53365) and NAG:SpellIsKnown(53365)) and NAG:Cast(33697))
    or     ((NAG:IsReady(49028) and NAG:IsActive(53365) and NAG:SpellIsKnown(53365)) and NAG:Cast(82174))
    or     ((NAG:IsReady(49028) and NAG:IsActive(53365) and NAG:SpellIsKnown(53365)) and NAG:Cast(49028))
    or     (((not NAG:DotIsActive(55095)) and (not NAG:DotIsActive(55078)) and NAG:IsActive(81256)) and NAG:Cast(77575))
    or     ((NAG:CurrentHealthPercent() <= 0.30) and NAG:Cast(48792))
    or     (((NAG:CurrentHealthPercent() <= 0.50) or (not NAG:IsActive(49222))) and NAG:Cast(49222))
    or     ((NAG:CurrentHealthPercent() <= 0.70) and NAG:Cast(55233))
    or     (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0.0) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) == 0.0) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) == 0.0) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) == 0.0)) and NAG:Cast(47568))
    or     (((NAG:DotRemainingTime(55095) <= 1.0) or (NAG:DotRemainingTime(55078) <= 1.0) or (NAG:CurrentTime() >= 7)) and NAG:Cast(77575))
    or     ((NAG:CurrentRunicPower() >= 120.0) and NAG:Cast(56815))
    or     NAG:Cast(49998)
    or     ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) >= 1.0) and NAG:Cast(55050))
    or     (((NAG:CurrentRunicPower() >= 90.0) and (NAG:TimeToReady(49028) >= 3)) and NAG:Cast(56815))
    or     (((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) >= 5) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0.0)) and NAG:Cast(45529))
    or     ((not NAG:IsActive(81256)) and NAG:Cast(46584))
    or     ((NAG:IsActive(96171)) and NAG:Cast(48982))
    or     ((NAG:IsActive(81141)) and NAG:Cast(48721))
    or     (((NAG:TimeToReady(49028) >= 5)) and NAG:Cast(56815))
    or     NAG:Cast(57330)
    or     (((((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy))))) and NAG:Cast(55050, 10))
    or     NAG:Cast(49998, 10)


]]
}

-- Frost - Dwobliterate Rotation
local frostDwobliterateRotation = {
    name = "DeathKnight Frost - Dwobliterate",
    specIndex = 2,
    class = "DEATHKNIGHT",
    authors = { "@APLParser" },
    default = false,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = true,
    prePull = {
        { time = -20, action = "NAG:Cast(48265)" },
        { time = -7, action = "NAG:Cast(57330)" },
        { time = -6, action = "NAG:Cast(42650)" },
        { time = -0.1, action = "NAG:Cast(NAG:GetBattlePotion())" }
    },
    glyphs = { 43543, 43547, 43549, 43533, 43541, 68793, 43673, 43671, 43544 },
    items = { 58146, 62464, 62469, 68972, 69002, 69113 },
    spells = { 2825, 26297, 33697, 42650, 45462, 45477, 45529, 46584, 47568, 48265, 49020, 49143, 49184, 51124, 51271, 53365, 55078, 55095, 57330, 59052, 74497, 77575, 82174, 91363, 91364, 91816, 91821, 92342, 92345, 96923, 96927, 96928, 96929, 98971 },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or     ((not NAG:IsActive(48265)) and NAG:Cast(48265))
    or     NAG:Cast(2825)
    or     (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0.0) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) >= 3) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) >= 3) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy) >= 3) and (NAG:CurrentRunicPower() <= 30.0) and (NAG:CurrentTime() > 10)) and NAG:Cast(47568))
    or     (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) <= 1.0) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) > 5.5)) and NAG:Cast(45529))
    or     ((NAG:RemainingTime() < 20) and NAG:Cast(51271))
    or     ((NAG:RemainingTime() < 20) and NAG:Cast(26297))
    or     ((NAG:RemainingTime() < 60) and NAG:Cast(46584))
    or     (((NAG:CurrentTime() > 180) and (not NAG:IsReady(46584)) and (NAG:RemainingTime() < 85)) and NAG:Cast(51271))
    or     (((NAG:CurrentTime() > 180) and NAG:IsReady(46584) and NAG:IsReady(58146) and NAG:IsActive(53365) and (NAG:IsActive(92345) or NAG:IsActive(91816) or (NAG:IsActive(92342) or NAG:IsActive(91821) or NAG:IsActive(91364) or NAG:IsActive(91363)) or (NAG:RemainingTime() < 85)) and NAG:IsReady(26297)) and NAG:StrictSequence('someName22', 51271, 58146, 26297, 46584))
    or     ((NAG:RemainingTime() < 8) and NAG:Cast(49020))
    or     ((NAG:RemainingTime() < 8) and NAG:Cast(49143))
    or     ((NAG:RemainingTime() < 8) and NAG:Cast(49184))
    or     (((NAG:RemainingTime() < 75.0) and NAG:IsActive(51271) and NAG:IsActive(53365)) and NAG:StrictSequence('someName784', 58146, 46584))
    or     ((NAG:IsReady(51271) and (NAG:CurrentTime() < 170) and ((NAG:CurrentTime() > 5) or ((NAG:AuraNumStacks(96923) == 5.0) or NAG:IsActive(96928) or NAG:IsActive(96927) or NAG:IsActive(96929)))) and NAG:Cast(51271))
    or     (NAG:IsActive(51271) and NAG:Cast(74497))
    or     ((NAG:CurrentTime() > 5.0) and NAG:Cast(69002))
    or     ((NAG:AuraNumStacks(96923) == 5.0) and NAG:Cast(69113))
    or     ((NAG:AuraNumStacks(96923) == 5.0) and NAG:Cast(68972))
    or     (NAG:IsActive(51271) and NAG:Cast(62469))
    or     (NAG:IsActive(51271) and NAG:Cast(62464))
    or     ((NAG:CurrentTime() > 20) and NAG:Cast(82174))
    or     ((((NAG:CurrentTime() > 10) or (NAG:IsActive(53365) and NAG:IsActive(92342) and NAG:IsActive(91821) and (NAG:IsActive(92345) or NAG:IsActive(91816) or NAG:IsActive(91364) or NAG:IsActive(91363))))) and NAG:Cast(82174))
    or     ((NAG:IsActive(51271) and (NAG:IsActive(53365) or (NAG:CurrentTime() > 5)) and (NAG:IsActive(92342) or NAG:IsActive(91821) or (NAG:CurrentTime() > 5))) and NAG:Cast(33697))
    or     ((NAG:IsActive(51271) and (NAG:IsActive(53365) or (NAG:CurrentTime() > 10)) and (NAG:IsActive(92342) or NAG:IsActive(91821) or (NAG:CurrentTime() > 10)) and (NAG:CurrentTime() < 170)) and NAG:Cast(26297))
    or     ((NAG:IsActive(51271) and (NAG:CurrentTime() > 5)) and NAG:Cast(33697))
    or     ((NAG:IsActive(51271) and (NAG:CurrentTime() > 10) and (NAG:CurrentTime() < 170)) and NAG:Cast(26297))
    or     ((NAG:IsActive(51271) and (NAG:IsActive(53365) or ((NAG:AuraRemainingTime(51271) < 3) or (NAG:AuraRemainingTime(92342) < 3) or (NAG:AuraRemainingTime(91821) < 3))) and (NAG:IsActive(62469) or NAG:IsActive(62464) or ((not NAG:SpellIsKnown(62469)) and (not NAG:SpellIsKnown(62464)) and ((NAG:IsActive(92345) and NAG:IsActive(91816) and NAG:IsActive(91364) and NAG:IsActive(91363) and NAG:IsActive(92342) and NAG:IsActive(91821)) or (NAG:AuraRemainingTime(51271) < 3)))) and NAG:IsActive(58146) and (NAG:IsActive(91364) or NAG:IsActive(91363) or NAG:IsActive(92345) or NAG:IsActive(91816) or ((NAG:AuraRemainingTime(51271) < 3) or (NAG:AuraRemainingTime(92342) < 3) or (NAG:AuraRemainingTime(91821) < 3)))) and NAG:Cast(46584))
    or     ((NAG:IsActive(53365) and NAG:IsActive(51271) and NAG:IsReady(46584)) and NAG:StrictSequence('someName583', 58146, 46584))
    or     (NAG:IsActive(51124) and NAG:Cast(49020))
    or     (((NAG:CurrentRunicPower() >= 90.0) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) > 2) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) > 2) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) > 2) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) <= 1.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) <= 1.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) <= 1.0)) and NAG:Cast(49143))
    or     ((NAG:IsReady(77575) and ((NAG:DotRemainingTime(55078) < 3) or (not NAG:DotIsActive(55078)))) and NAG:Cast(77575))
    or     (NAG:IsActive(59052) and NAG:Cast(49184))
    or     ((not NAG:DotIsActive(55095)) and NAG:Cast(45477))
    or     ((not NAG:DotIsActive(55078)) and NAG:Cast(45462))
    or     NAG:Cast(49020)
    or     (((not NAG:IsActive(57330)) or (not NAG:IsActive(98971))) and NAG:Cast(57330))
    or     NAG:Cast(49143)
    or     NAG:Cast(57330)
    --NAG:UnitDistance("target") > 5
    -- ((((NAG:DotRemainingTime(55078) < 3) or (not NAG:DotIsActive(55078))) and (not NAG:DotIsActive(98957)) and NAG:IsReady(77575)) and NAG:Cast(77575))
    --
]]
}

-- Frost - Masterfrost Rotation
local frostMasterfrostRotation = {
    name = "DeathKnight Frost - Masterfrost",
    specIndex = 2,
    class = "DEATHKNIGHT",
    authors = { "@Darkfrog" },
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = true,
    prePull = {
        { time = -20, action = "NAG:Cast(48265)" },
        { time = -7, action = "NAG:Cast(57330)" },
        { time = -6, action = "NAG:Cast(42650)" },
        { time = -0.1, action = "NAG:Cast(NAG:GetBattlePotion())" }
    },
    glyphs = { 43543, 43547, 45806, 43548, 43826, 68793, 43673, 43671, 43544 },
    items = { 58146, 68972, 69113 },
    spells = { 2825, 26297, 33697, 42650, 45462, 45477, 45529, 46584, 47568, 48265, 49020, 49143, 49184, 51124, 51271, 53365, 55078, 55095, 57330, 59052, 77575, 82174, 96229, 96923, 96927, 96928, 96929, 98957, 98971 },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or     ((not NAG:IsActive(48265)) and NAG:Cast(48265))
    or     ((NAG:SpellIsKnown(96923) and (NAG:CurrentTime() >= 5) and NAG:IsReady(51271)) and NAG:Cast(51271))
    or     (((not NAG:SpellIsKnown(96923)) and NAG:IsReady(51271)) and NAG:Cast(51271))
    or     (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) <= 1.0) and (NAG:CurrentRunicPower() <= 31.0) and NAG:IsReady(47568) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) >= 0.2) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) >= 0.2) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) >= 0.2) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) >= 0.2) and ((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) >= 0.2) or (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy) >= 0.2))) and NAG:Cast(47568))
    or     (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0.0) and (NAG:CurrentRunicPower() <= 31.0) and NAG:IsReady(47568) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) >= 0.1) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) >= 0.1) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) >= 0.1) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) >= 0.1) and (NAG:RemainingTime() <= 60.0)) and NAG:Cast(47568))
    or     (((not NAG:SpellIsKnown(96923)) and NAG:IsActive(51271) and NAG:IsReady(82174)) and NAG:Cast(82174))
    or     ((NAG:SpellIsKnown(96923) and NAG:IsReady(82174)) and NAG:Cast(82174))
    or     (((NAG:AuraNumStacks(96923) == 5.0) and NAG:IsReady(69113)) and NAG:Cast(69113))
    or     (((NAG:AuraNumStacks(96923) == 5.0) and NAG:IsReady(68972)) and NAG:Cast(68972))
    or     ((NAG:SpellIsKnown(96923) and (NAG:IsActive(96929) or NAG:IsActive(96928) or NAG:IsActive(96927)) and NAG:IsReady(33697)) and NAG:Cast(33697))
    or     (((not NAG:SpellIsKnown(96923)) and NAG:IsReady(33697)) and NAG:Cast(33697))
    or     ((((NAG:IsExecutePhase(35) and NAG:IsActive(51271)) or (NAG:RemainingTime() <= 25) or (NAG:IsActive(51271) and (NAG:RemainingTime() < 60))) and NAG:IsReady(58146)) and NAG:Cast(58146))
    or     ((NAG:RemainingTime() < 8) and NAG:Cast(49020))
    or     ((NAG:RemainingTime() < 8) and NAG:Cast(49143))
    or     ((NAG:RemainingTime() < 8) and NAG:Cast(49184))
    or     ((((NAG:AllTrinketStatProcsActive(-1, 6, 7) and NAG:IsActive(53365) and NAG:IsActive(58146) and NAG:IsActive(51271)) or ((NAG:TrinketProcsMinRemainingTime(-1, 6, 7, 0) < 3) and (NAG:TrinketProcsMinRemainingTime(-1, 6, 7, 0) > 0.0)) or ((NAG:AuraRemainingTime(51271) < 3) and NAG:IsActive(51271))) and NAG:IsReady(46584) and (NAG:CurrentTime() <= 180)) and NAG:Cast(46584))
    or     ((((NAG:AllTrinketStatProcsActive(-1, 6, 7) and NAG:IsActive(53365) and NAG:IsActive(58146) and NAG:IsActive(51271)) or ((NAG:TrinketProcsMinRemainingTime(-1, 6, 7, 0) < 3) and (NAG:TrinketProcsMinRemainingTime(-1, 6, 7, 0) > 0.0)) or ((NAG:AuraRemainingTime(51271) < 3) and NAG:IsActive(51271))) and NAG:IsReady(26297) and (NAG:CurrentTime() <= 180)) and NAG:Cast(26297))
    or     (((NAG:CurrentTime() > 180) and (NAG:RemainingTime() >= 60) and (((NAG:AuraRemainingTime(51271) < 3) and NAG:IsActive(51271)) or (NAG:IsActive(51271) and NAG:IsActive(96229) and NAG:IsActive(53365) and NAG:AllTrinketStatProcsActive(-1, 6, 7) and NAG:IsActive(58146)) or (NAG:IsActive(51271) and NAG:AnyTrinketStatProcsActive(-1, 6, 7, 0) and ((NAG:TrinketProcsMinRemainingTime(-1, 6, 7, 0) < 3) and (NAG:TrinketProcsMinRemainingTime(-1, 6, 7, 0) > 0.0))) or (NAG:IsActive(51271) and (NAG:AuraRemainingTime(53365) < 3) and NAG:IsActive(53365)) or (NAG:IsActive(51271) and NAG:IsActive(96229) and (NAG:AuraRemainingTime(96229) < 3))) and NAG:IsReady(46584)) and NAG:Cast(46584))
    or     (((NAG:CurrentTime() > 180) and (NAG:RemainingTime() >= 60) and (((NAG:AuraRemainingTime(51271) < 3) and NAG:IsActive(51271)) or (NAG:IsActive(51271) and NAG:IsActive(96229) and NAG:IsActive(53365) and NAG:AllTrinketStatProcsActive(-1, 6, 7) and NAG:IsActive(58146)) or (NAG:IsActive(51271) and NAG:AnyTrinketStatProcsActive(-1, 6, 7, 0) and ((NAG:TrinketProcsMinRemainingTime(-1, 6, 7, 0) < 3) and (NAG:TrinketProcsMinRemainingTime(-1, 6, 7, 0) > 0.0))) or (NAG:IsActive(51271) and (NAG:AuraRemainingTime(53365) < 3) and NAG:IsActive(53365)) or (NAG:IsActive(51271) and NAG:IsActive(96229) and (NAG:AuraRemainingTime(96229) < 3))) and NAG:IsReady(26297)) and NAG:Cast(26297))
    or     (((NAG:RemainingTime() < 60) and (NAG:RemainingTime() > 15) and NAG:IsReady(46584)) and NAG:Cast(46584))
    or     (((NAG:RemainingTime() < 60) and (NAG:RemainingTime() > 15) and NAG:IsReady(26297)) and NAG:Cast(26297))
    or     (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) <= 1.0) and ((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) > 5.5) or (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) > 5.5)) and (not (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) < 5.5)) and NAG:IsReady(45529)) and NAG:Cast(45529))
    or     ((NAG:NumberTargets() > 1.0) and NAG:Cast(43265))
    or     ((((NAG:DotRemainingTime(55078) < 3) or (not NAG:DotIsActive(55078))) and (not(NAG:DotIsActive(98957)) or NAG:UnitDistance("target") > 5) and NAG:IsReady(77575)) and NAG:Cast(77575))
    or     ((((NAG:DotRemainingTime(55078) < 3) or (not NAG:DotIsActive(55078))) and (not NAG:DotIsActive(98957)) and NAG:IsReady(77575)) and NAG:Cast(77575))
    or     ((((NAG:CurrentRunicPower() >= 100.0) and ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 2.0) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0) and NAG:IsActive(51124)))) or ((NAG:CurrentRunicPower() >= 110.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) <= 1.0) and (not NAG:IsActive(51124))) or ((NAG:CurrentRunicPower() >= 120.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) <= 1.0) and (not NAG:IsActive(51124)) and NAG:IsActive(59052))) and NAG:Cast(49143))
    or     ((NAG:IsActive(51124) and (not NAG:IsActive(96929)) and (NAG:CurrentRunicPower() <= 100.0) and (NAG:DotIsActive(55078) or NAG:DotIsActive(98957)) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0) and (NAG:NumberTargets() == 1.0)) and NAG:Cast(49020))
    or     ((NAG:IsActive(51124) and NAG:IsActive(96929) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) <= 1.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) <= 1.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) <= 1.0)) and NAG:Cast(49143))
    or     ((NAG:IsActive(51124) and ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0.0) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) <= 2.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0.0)))) and NAG:Cast(49143))
    or     ((((NAG:DotRemainingTime(55078) <= 3) or (not NAG:DotIsActive(55078))) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) <= 1.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) <= 1.0) and (not NAG:DotIsActive(98957)) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) <= 1.0) and NAG:IsReady(77575)) and NAG:Cast(77575))
    or     (((((not NAG:DotIsActive(55078)) or (NAG:DotRemainingTime(55078) < 3)) and (not NAG:DotIsActive(98957))) and ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 2.0) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy) <= 1)))) and NAG:Cast(45462))
    or     (((NAG:CurrentRunicPower() <= 100.0) and ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 2.0) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy) <= 1))) and (NAG:DotIsActive(55078) or NAG:DotIsActive(98957)) and (NAG:NumberTargets() == 1.0)) and NAG:Cast(49020))
    or     (((NAG:CurrentRunicPower() <= 100.0) and ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 2.0) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy) <= 1))) and (NAG:DotIsActive(55078) or NAG:DotIsActive(98957)) and (NAG:NumberTargets() > 1.0) and NAG:IsActive(51124)) and NAG:Cast(49020))
    or     ((((NAG:CurrentRunicPower() <= 110.0) and (not NAG:IsActive(59052))) or ((NAG:CurrentRunicPower() <= 120.0) and NAG:IsActive(59052))) and NAG:Cast(49184))
    or     (((((not NAG:IsActive(57330)) and (not NAG:IsActive(6673))) or (not NAG:IsActive(98971))) and NAG:IsReady(57330)) and NAG:Cast(57330))
    or     NAG:Cast(49143)
    or     (NAG:IsReady(57330) and NAG:Cast(57330))
    or     ((not NAG:IsActive(2825)) and (not NAG:IsActive(51124)) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) > 1) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) > 1) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) > 1) and (NAG:CurrentRunicPower() <= 30.0) and (NAG:CurrentRunicPower() >= 22.0) and NAG:Cast(45462, 10))
    or     ((((not NAG:DotIsActive(55078)) or (NAG:DotRemainingTime(55078) < 4)) and (not NAG:DotIsActive(98957))) and (((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) > NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy)) or (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) > NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy)) or (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) > NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy)) or (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) > NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy))) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0)) and (NAG:NumberTargets() == 1.0) and NAG:Cast(45462, 10))
    or     (NAG:IsActive(51124) and (not NAG:IsActive(96929)) and (NAG:DotIsActive(55078) or NAG:DotIsActive(98957)) and ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0)) and (NAG:NumberTargets() == 1.0) and NAG:Cast(49020, 10))
    or     (NAG:IsActive(51124) and (not NAG:IsActive(96929)) and (NAG:DotIsActive(55078) or NAG:DotIsActive(98957)) and ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 2.0)) and (NAG:NumberTargets() > 1.0) and NAG:Cast(49020, 10))
    or     (((NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy) <= 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0)) and (NAG:NumberTargets() == 1.0) and NAG:Cast(49020, 10))
    or     NAG:Cast(49184, 10)
]]
}

-- Frost - Twohand Rotation
local frostTwohandRotation = {
    name = "DeathKnight Frost - Twohand",
    specIndex = 2,
    class = "DEATHKNIGHT",
    default = false,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = true,
    prePull = {
        { time = -20, action = "NAG:Cast(48265)" },
        { time = -6, action = "NAG:Cast(42650)" },
        { time = -1, action = "NAG:Cast(57330)" },
        { time = -0.1, action = "NAG:Cast(NAG:GetBattlePotion())" }
    },
    glyphs = { 43543, 43547, 45806, 43548, 43826, 68793, 43673, 43671, 43544 },
    items = { 58146, 62464, 62469 },
    spells = { 2825, 26297, 33697, 42650, 45462, 45529, 46584, 47568, 48265, 49020, 49143, 49184, 51271, 53365, 55078, 55095, 57330, 59052, 77575, 82174, 91363, 91364, 91816, 91821, 92342, 92345 },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or     ((not NAG:IsActive(48265)) and NAG:Cast(48265))
    or     NAG:Cast(2825)
    or     (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0.0) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) >= 3.5) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) >= 3.5) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy) >= 3.5) and (NAG:CurrentRunicPower() <= 30.0) and (NAG:CurrentTime() > 10)) and NAG:Cast(47568))
    or     (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0.0) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) > 5)) and NAG:Cast(45529))
    or     NAG:Cast(51271)
    or     (NAG:IsActive(51271) and NAG:Cast(62469))
    or     (NAG:IsActive(51271) and NAG:Cast(62464))
    or     ((NAG:CurrentTime() > 20) and NAG:Cast(82174))
    or     ((((NAG:CurrentTime() > 10) or (NAG:IsActive(53365) and NAG:IsActive(92342) and NAG:IsActive(91821))) or ((not NAG:SpellIsKnown(62469)) and (not NAG:SpellIsKnown(62464)))) and NAG:Cast(82174))
    or     ((NAG:IsActive(51271) and ((NAG:CurrentTime() > 5) or NAG:IsActive(53365)) and ((NAG:CurrentTime() > 5) or NAG:IsActive(92342) or NAG:IsActive(91821))) and NAG:Cast(33697))
    or     ((NAG:IsActive(51271) and ((NAG:CurrentTime() > 10) or NAG:IsActive(53365)) and ((NAG:CurrentTime() > 10) or NAG:IsActive(92342) or NAG:IsActive(91821))) and NAG:Cast(26297))
    or     ((NAG:IsActive(51271) and (NAG:CurrentTime() > 5)) and NAG:Cast(33697))
    or     ((NAG:IsActive(51271) and (NAG:CurrentTime() > 10)) and NAG:Cast(26297))
    or     ((NAG:IsActive(51271) and NAG:IsActive(58146) and (NAG:IsActive(62469) or NAG:IsActive(62464) or ((not NAG:SpellIsKnown(62469)) and (not NAG:SpellIsKnown(62464)) and ((NAG:IsActive(91364) and NAG:IsActive(91363) and NAG:IsActive(92345) and NAG:IsActive(91816) and NAG:IsActive(92342) and NAG:IsActive(91821)) or (NAG:AuraRemainingTime(51271) < 1)))) and (NAG:IsActive(53365) or ((NAG:AuraRemainingTime(51271) < 1) or (NAG:AuraRemainingTime(92342) < 1) or (NAG:AuraRemainingTime(91821) < 1))) and (NAG:IsActive(92345) or NAG:IsActive(91816) or NAG:IsActive(91364) or NAG:IsActive(91363) or ((NAG:AuraRemainingTime(51271) < 1) or (NAG:AuraRemainingTime(92342) < 1) or (NAG:AuraRemainingTime(91821) < 1)))) and NAG:Cast(46584))
    or     (NAG:IsActive(51271) and NAG:Cast(77575))
    or     ((NAG:CurrentRunicPower() >= 100.0) and NAG:Cast(49143))
    or     ((not NAG:DotIsActive(55095)) and NAG:Cast(49184))
    or     ((not NAG:DotIsActive(55078)) and NAG:Cast(45462))
    or     (NAG:IsActive(59052) and NAG:Cast(49184))
    or     NAG:Cast(49020)
    or     NAG:Cast(49143)
    or     ((NAG:IsActive(51271) and (NAG:IsActive(53365) or NAG:IsActive(92342) or NAG:IsActive(91821)) and NAG:IsReady(46584)) and NAG:Cast(NAG:GetBattlePotion()))
    or     ((NAG:IsActive(51271) and (NAG:IsActive(53365) or NAG:IsActive(92342) or NAG:IsActive(91821)) and NAG:IsActive(58146)) and NAG:Cast(46584))
    or     NAG:Cast(57330)
]]
}

-- Unholy Rotation
local unholyRotation = {
    name = "DeathKnight Unholy - Default",
    specIndex = 3,
    class = "DEATHKNIGHT",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = false,
    prePull = {
        { time = -20, action = "NAG:Cast(48265)" },
        { time = -12, action = "NAG:Cast(57330)" },
        { time = -11, action = "NAG:Cast(47541)" },
        { time = -10, action = "NAG:Cast(47541)" },
        { time = -9, action = "NAG:Cast(47541)" },
        { time = -8, action = "NAG:Cast(47541)" },
        { time = -7, action = "NAG:Cast(42650)" },
        { time = -1, action = "NAG:Cast(47541)" },
        { time = -1, action = "NAG:Cast(NAG:GetBattlePotion())" }
    },
    glyphs = { 45804, 43551, 43549, 43548, 43826, 43533, 43539, 43671, 43544 },
    items = { 58146, 62464, 69002, 77116 },
    spells = { 2825, 26297, 33697, 42650, 43265, 45462, 45477, 45529, 47541, 47568, 48265, 49016, 49206, 51460, 53365, 55078, 55090, 55095, 57330, 63560, 77575, 81340, 82174, 85948, 91342, 96229 },
    rotationString = [[
    (not (NAG:IsActive(48265))) and NAG:Cast(48265)
    or     ((NAG:AuraIsActive(53365) and NAG:AllTrinketStatProcsActive(-1, 6, -1)) or ((NAG:AuraNumStacks(91342, "pet") == 5.0) and (NAG:CurrentTime() < 60) and (NAG:CurrentTime() > 5) and ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) >= 1.0))) or ((NAG:CurrentTime() > 60) and NAG:AnyTrinketStatProcsActive(-1, 6, -1, 60) and (NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) > 10)) or (NAG:RemainingTime() <= 35)) and NAG:Cast(49016)
    or     ((NAG:RemainingTime() >= 15) and (NAG:CurrentTime() > 5) and (NAG:AuraNumStacks(91342, "pet") == 5.0)) and NAG:Cast(63560)
    or     (NAG:CurrentTime() >= 5) and NAG:Cast(2825)
    or     ((NAG:AuraIsActive(53365) and NAG:AllTrinketStatProcsActive(-1, 6, -1) and (NAG:CurrentTime() >= 5)) or (NAG:TimeToReady(49206) >= 30) or (NAG:RemainingTime() <= 35) or (NAG:IsActive(58146) and (NAG:ItemRemainingTime(84963) < 15)) or (NAG:IsReady(49206) and (NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) <= 15))) and NAG:Cast(69002)
    or     ((NAG:AllTrinketStatProcsActive(-1, 6, -1) and (NAG:AuraIsActive(53365) or (NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) <= 20)) and NAG:IsReady(77575) and (NAG:CurrentTime() >= 5)) or ((NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) <= 20) and NAG:IsReady(49206) and (NAG:CurrentTime() >= 5)) or (NAG:RemainingTime() <= 35) or (NAG:IsActive(58146) and (NAG:ItemRemainingTime(84963) <= 20)) or ((NAG:CurrentTime() >= 5) and (NAG:NumEquippedStatProcTrinkets(-1, 6, -1, 110) == 0.0))) and NAG:Cast(62464)
    or     ((NAG:AllTrinketStatProcsActive(-1, 6, -1) and (NAG:AuraIsActive(53365) or (NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) <= 15)) and (NAG:CurrentTime() >= 5)) or ((NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) <= 15) and NAG:IsReady(49206)) or (NAG:RemainingTime() <= 35) or (NAG:IsActive(58146) and (NAG:ItemRemainingTime(84963) <= 15))) and NAG:Cast(77116)
    or     ((NAG:AuraIsActive(53365) and NAG:AnyTrinketStatProcsActive(-1, 6, -1, 60) and (NAG:TrinketProcsMaxRemainingICD(-1, 6, -1, 60) > (NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) - 5))) and NAG:IsReady(49206) and (NAG:CurrentTime() > 60) and (NAG:NumEquippedStatProcTrinkets(-1, 6, -1, 60) == 2.0)) and NAG:Cast(82174)
    or     (((NAG:AuraIsActive(53365) and NAG:AllTrinketStatProcsActive(-1, 6, -1) and (NAG:CurrentTime() >= 5)) or ((NAG:TimeToReady(49206) >= 30)) or (NAG:RemainingTime() <= 35) or (NAG:IsActive(58146) and (NAG:ItemRemainingTime(84963) < 10.5)) or (NAG:IsReady(49206) and (NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) < 10.5))) and (not (NAG:SpellIsKnown(69002) or NAG:SpellIsKnown(62464) or NAG:SpellIsKnown(77116)))) and NAG:Cast(82174)
    or     (((NAG:SpellIsKnown(69002) or NAG:SpellIsKnown(62464) or NAG:SpellIsKnown(77116)) and ((NAG:TimeToReady(69002) > 10) or (NAG:TimeToReady(62464) > 10) or (NAG:TimeToReady(77116) > 10) or ((NAG:TrinketProcsMaxRemainingICD(-1, 6, -1, 60) > 10) and (NAG:RemainingTime() > 45)))) or (NAG:RemainingTime() <= 35)) and NAG:Cast(82174)
    or     ((NAG:AuraIsActive(53365) and NAG:AllTrinketStatProcsActive(-1, 6, -1)) or (NAG:IsActive(58146) and ((NAG:AuraRemainingTime(63560, "pet") >= 7.5) or (NAG:ItemRemainingTime(84963) < 10.5))) or ((NAG:RemainingTime() < 10.5))) and NAG:Cast(26297)
    or     ((NAG:AuraIsActive(53365) and NAG:AnyTrinketStatProcsActive(-1, 6, -1, 60) and (NAG:TrinketProcsMaxRemainingICD(-1, 6, -1, 60) > (NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) - 5))) and NAG:IsReady(49206) and (NAG:CurrentTime() > 60) and (NAG:NumEquippedStatProcTrinkets(-1, 6, -1, 60) == 2.0)) and NAG:Cast(33697)
    or     ((NAG:AllTrinketStatProcsActive(-1, 6, -1) and (NAG:AuraIsActive(53365) or (NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) <= 15)) and NAG:IsReady(77575) and (NAG:CurrentTime() >= 5)) or ((NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) <= 15) and NAG:IsReady(49206)) or (NAG:RemainingTime() <= 35) or (NAG:IsActive(58146) and (NAG:ItemRemainingTime(84963) <= 15))) and NAG:Cast(33697)
    or     (((NAG:RemainingTime() <= 35) and ((NAG:TimeToReady(49016) > (NAG:RemainingTime() - 23)) or NAG:IsReady(49206))) or (NAG:IsActive(49016) and (NAG:IsReady(49206) or (NAG:AuraRemainingTime(49016) < 26) or (NAG:AuraRemainingTime(63560, "pet") >= 24))) or ((NAG:TimeToReady(49206) > (NAG:RemainingTime() - 30)) and NAG:AnyTrinketStatProcsActive(-1, 6, -1, 60))) and NAG:Cast(58146)
    or     ((NAG:AnyTrinketStatProcsActive(-1, 6, -1, 60) and NAG:AuraIsActive(53365) and (NAG:TrinketProcsMaxRemainingICD(-1, 6, -1, 60) > (NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) - 5))) and (NAG:CurrentTime() > 60) and (NAG:NumEquippedStatProcTrinkets(-1, 6, -1, 60) == 2.0)) and NAG:Cast(49206)
    or     ((NAG:AllTrinketStatProcsActive(-1, 6, -1) and NAG:AuraIsActive(53365) and ((NAG:CurrentTime() > 60) or NAG:AuraIsActive(63560, "pet")) and (NAG:RemainingTime() > 6) and ((not NAG:SpellIsKnown(62464)) or NAG:IsActive(62464) or (NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) < (NAG:TimeToReady(62464) - 4.0)))) or ((NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) < 4) and NAG:AuraIsActive(53365) and (NAG:RemainingTime() > 7)) or (NAG:AllTrinketStatProcsActive(-1, 6, -1) and (NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) < 4) and (NAG:RemainingTime() > 7)) or ((NAG:RemainingTime() < 35) and (NAG:RemainingTime() > 7)) or ((NAG:ItemRemainingTime(84963) <= 4) and NAG:IsActive(58146) and (NAG:RemainingTime() > 7)) or ((NAG:AuraRemainingTime(33697) <= 4) and (NAG:AuraRemainingTime(33697) > 0.0) and (NAG:RemainingTime() > 7))) and NAG:Cast(49206)
    or     ((NAG:RemainingTime() < 45) and ((not NAG:DotIsActive(55095)) or (not NAG:DotIsActive(55078)))) and NAG:Cast(77575)
    or     ((NAG:TimeToReady(49206) > 176) and (NAG:NumEquippedStatProcTrinkets(-1, 6, -1, 110) >= 1.0) and (NAG:NumEquippedStatProcTrinkets(-1, 6, -1, 110) >= 1.0)) and NAG:Cast(77575)
    or     (NAG:AuraIsActive(53365) and NAG:AllTrinketStatProcsActive(-1, -1, -1) and (NAG:CurrentTime() > 8) and ((NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 20) < (NAG:TimeToReady(82174) - 2)) or NAG:IsActive(96229)) and ((NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 20) < (NAG:TrinketProcsMaxRemainingICD(-1, 6, -1, 110) - 2)) or NAG:AllTrinketStatProcsActive(-1, 6, -1)) and (not (NAG:SpellIsKnown(69002) or NAG:SpellIsKnown(62464) or NAG:SpellIsKnown(77116)))) and NAG:Cast(77575)
    or     (NAG:AuraIsActive(53365) and NAG:AllTrinketStatProcsActive(-1, -1, -1) and (NAG:CurrentTime() > 8) and ((NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 20) < (NAG:TimeToReady(69002) - 2)) or NAG:IsActive(69002)) and NAG:SpellIsKnown(69002)) and NAG:Cast(77575)
    or     (NAG:AuraIsActive(53365) and NAG:AllTrinketStatProcsActive(-1, -1, -1) and (NAG:CurrentTime() > 8) and ((NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 20) < (NAG:TimeToReady(62464) - 2)) or NAG:IsActive(62464)) and NAG:SpellIsKnown(62464)) and NAG:Cast(77575)
    or     (NAG:AuraIsActive(53365) and NAG:AllTrinketStatProcsActive(-1, -1, -1) and (NAG:CurrentTime() > 8) and ((NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 20) < (NAG:TimeToReady(77116) - 2)) or NAG:IsActive(77116)) and NAG:SpellIsKnown(77116)) and NAG:Cast(77575)
    or     ((NAG:NumEquippedStatProcTrinkets(-1, 6, -1, 110) >= 1.0) and (NAG:NumEquippedStatProcTrinkets(-1, 6, -1, 60) == NAG:NumEquippedStatProcTrinkets(-1, 6, -1, 110)) and NAG:AuraIsActive(53365) and ((NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 110) < (NAG:TimeToReady(82174) - 2)) or NAG:IsActive(96229)) and ((NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 110) < (NAG:TimeToReady(33697) - 2)) or NAG:IsActive(33697)) and NAG:AllTrinketStatProcsActive(-1, 6, -1)) and NAG:Cast(77575)
    or     (((NAG:ItemRemainingTime(84963) <= 3) and NAG:IsActive(58146)) or ((NAG:AuraRemainingTime(33697) <= 3) and (NAG:AuraRemainingTime(33697) > 0.0))) and NAG:Cast(77575)
    or     (NAG:AnyTrinketStatProcsActive(-1, -1, -1, 0) and (NAG:NumEquippedStatProcTrinkets(-1, 6, -1, 60) >= 1.0) and (NAG:TrinketProcsMinRemainingTime(-1, 6, -1, 60) < 2) and (NAG:AuraIsActive(53365) or NAG:AllTrinketStatProcsActive(-1, 6, -1))) and NAG:Cast(77575)
    or     (not NAG:DotIsActive(55095)) and NAG:Cast(45477)
    or     (not NAG:DotIsActive(55078)) and NAG:Cast(45462)
    or     (((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) > 5.5) or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) >= 1.0) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) == 0.0) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) >= 3.5))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or (not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)))) and NAG:Cast(45529)
    or     ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) < NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost)) and (((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost))) or (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) < NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood))))) and NAG:CancelAura(45529)
    or     ((NAG:AuraRemainingTime(81340) <= 1.0) and NAG:Cast(47632)) and NAG:Cast(47541)
    or     ((NAG:CurrentRunicPower() >= (NAG:MaxRunicPower() - 10.0)) and (not ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) >= 3.0) or (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy) <= 1) or (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) <= 1) or (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) <= 1) or (NAG:AuraIsActive(63560, "pet") and (NAG:AuraRemainingTime(63560, "pet") <= 1))))) and NAG:Cast(47541)
    or     ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) == 2.0) and (NAG:CurrentTime() < 6)) and NAG:Cast(85948)
    or     (NAG:RemainingTime() >= 6) and NAG:Cast(43265)
    or     ((not NAG:AuraIsActive(63560, "pet")) and (NAG:AuraNumStacks(91342, "pet") < 5.0) and (NAG:CurrentRunicPower() >= (NAG:MaxRunicPower() - 4.0))) and NAG:Cast(47541)
    or     ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 2.0) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 1.0) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy) < 1))) and NAG:Cast(55090)
    or     (((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) == 2.0) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 1.0) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) < 1))) or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) == 2.0) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 1.0) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) < 1)))) and NAG:Cast(85948)
    or     ((NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) <= 1) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) <= 1)) or (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) <= 1) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) <= 1))) and NAG:Cast(55090)
    or     ((not NAG:AuraIsActive(63560, "pet")) and (NAG:AuraNumStacks(91342, "pet") == 4.0) and ((NAG:CurrentRunicPower() >= 34.0) or NAG:AuraIsActive(81340))) and NAG:Cast(47541)
    or     (NAG:AuraIsActive(81340) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) > 3) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) > 3) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy) > 3) and (not (NAG:AuraIsActive(63560, "pet") and (NAG:AuraRemainingTime(63560, "pet") < 2)))) and NAG:Cast(47541)
    or     NAG:Cast(55090)
    or     ((not NAG:AuraIsActive(63560, "pet")) and (NAG:AuraNumStacks(91342, "pet") < 5.0) and (NAG:CurrentRunicPower() >= 44.0)) and NAG:Cast(47541)
    or     NAG:Cast(85948)
    or     (((not NAG:IsReady(49206)) and (not (NAG:AuraIsActive(63560, "pet") and (NAG:AuraRemainingTime(63560, "pet") < 4)))) or (NAG:AuraIsActive(81340) and (not (NAG:AuraIsActive(63560, "pet") and (NAG:AuraRemainingTime(63560, "pet") < 2)))) or ((NAG:CurrentRunicPower() >= 94.0) and (not (NAG:AuraIsActive(63560, "pet") and (NAG:AuraRemainingTime(63560, "pet") < 3)))) or (NAG:IsReady(49206) and (not (NAG:AuraIsActive(63560, "pet") and (NAG:AuraRemainingTime(63560, "pet") < 4))) and (NAG:CurrentTime() > 175) and (NAG:AuraRemainingTime(49016) > 25) and (NAG:RemainingTime() > 40)) or ((NAG:RemainingTime() < 15) and (NAG:TimeToReady(49206) > (NAG:RemainingTime() - 8.0)))) and NAG:Cast(47541)
    or     NAG:Cast(57330)
    or     ((not NAG:IsActive(2825)) and (not NAG:IsActive(51460)) and (NAG:CurrentRunicPower() <= 38.0) and ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0.0) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) >= 0.2) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) >= 0.2) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) >= 0.2))) and NAG:Cast(47568)


    or     (((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:DotRemainingTime(55095) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:DotRemainingTime(55095) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:DotRemainingTime(55095) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)))) and NAG:Cast(45477, 10)
    or     (((NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)) and (NAG:DotRemainingTime(55078) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)) and (NAG:DotRemainingTime(55078) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)) and (NAG:DotRemainingTime(55078) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and (NAG:DotRemainingTime(55078) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and (NAG:DotRemainingTime(55078) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost)))) and NAG:Cast(45462, 10)
    or     (((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) > NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or ((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) > NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or ((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) > NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or ((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) > NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) or (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost))) and NAG:Cast(55090, 10)
    or     NAG:Cast(85948, 10)

    ]]
}
-- LOCAL_DEFS_END

if UnitClassBase('player') ~= "DEATHKNIGHT" then return end

-- REGISTER_ROTATIONS_START (now handled via SetupClassDefaults)
-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

--- @class DEATHKNIGHT : ClassBase
local DEATHKNIGHT = NAG:CreateClassModule("DEATHKNIGHT", defaults, {
})
if not DEATHKNIGHT then return end

-- Setup class defaults during PreDatabaseRegistration
function DEATHKNIGHT:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 1, bloodDefensiveRotation)  -- Blood
    ns.AddRotationToDefaults(self.defaults, 1, bloodSimpleRotation)  -- Blood
    ns.AddRotationToDefaults(self.defaults, 2, frostDwobliterateRotation)  -- Frost
    ns.AddRotationToDefaults(self.defaults, 2, frostMasterfrostRotation)  -- Frost
    ns.AddRotationToDefaults(self.defaults, 2, frostTwohandRotation)  -- Frost
    ns.AddRotationToDefaults(self.defaults, 3, unholyRotation)  -- Unholy
end

NAG.Class = DEATHKNIGHT
