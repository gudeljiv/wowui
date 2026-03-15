local _, ns = ...
local GetTime = _G.GetTime
local UnitHealth = _G.UnitHealth
local UnitHealthMax = _G.UnitHealthMax
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
local UnitLevel = _G.UnitLevel
local UnitAttackPower = _G.UnitAttackPower
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
--- @type SpellTrackingManager|AceModule|CoreModule
local SpellTracker = ns.SpellTrackingManager
local GetInventoryItemLink = _G.GetInventoryItemLink

--- NAG
local defaults = ns.InitializeClassDefaults()


-- MoP Death Knight spec spell locations (new format: spellId = position)
defaults.class.specSpellLocations = {
    [1] = { -- Blood
        -- ABOVE spells
        [48265] = NAG.SPELL_POSITIONS.ABOVE,   -- Unholy Presence
        [48263] = NAG.SPELL_POSITIONS.ABOVE,   -- Blood Presence
        [48266] = NAG.SPELL_POSITIONS.ABOVE,   -- Frost Presence
        [42650] = NAG.SPELL_POSITIONS.ABOVE,   -- Army of the Dead
        [51052] = NAG.SPELL_POSITIONS.ABOVE,   -- Anti-Magic Zone
        [123693] = NAG.SPELL_POSITIONS.ABOVE,  -- Plague Leech
        [49222] = NAG.SPELL_POSITIONS.ABOVE,   -- Bone Shield
        [48707] = NAG.SPELL_POSITIONS.ABOVE,   -- Anti-Magic Shell
        [48792] = NAG.SPELL_POSITIONS.ABOVE,   -- Icebound Fortitude
        [77606] = NAG.SPELL_POSITIONS.ABOVE,   -- Dark Simulacrum
        [47528] = NAG.SPELL_POSITIONS.ABOVE,   -- Mind Freeze
        [61999] = NAG.SPELL_POSITIONS.ABOVE,   -- Raise Ally
        [56222] = NAG.SPELL_POSITIONS.ABOVE,   -- Dark Command
        [48743] = NAG.SPELL_POSITIONS.ABOVE,   -- Death Pact
        [47476] = NAG.SPELL_POSITIONS.ABOVE,   -- Strangulate
        [45524] = NAG.SPELL_POSITIONS.ABOVE,   -- Chains of Ice
        [55233] = NAG.SPELL_POSITIONS.ABOVE,   -- Vampiric Blood
        [49039] = NAG.SPELL_POSITIONS.ABOVE,   -- Lichborne
        [48982] = NAG.SPELL_POSITIONS.ABOVE,   -- Rune Tap

        -- BELOW spells
        [77575] = NAG.SPELL_POSITIONS.BELOW,   -- Outbreak

        -- RIGHT spells
        [46584] = NAG.SPELL_POSITIONS.RIGHT,   -- Raise Dead
        [114866] = NAG.SPELL_POSITIONS.RIGHT,  -- Soul Reaper

        -- LEFT spells
        [45529] = NAG.SPELL_POSITIONS.LEFT,    -- Blood Tap
        [47568] = NAG.SPELL_POSITIONS.LEFT,    -- Empower Rune Weapon
        [49028] = NAG.SPELL_POSITIONS.LEFT,    -- Dancing Rune Weapon
        [49016] = NAG.SPELL_POSITIONS.LEFT,    -- Unholy Frenzy
        [49206] = NAG.SPELL_POSITIONS.LEFT,    -- Summon Gargoyle
        [33697] = NAG.SPELL_POSITIONS.LEFT,    -- Blood Fury

        -- AOE spells
        [43265] = NAG.SPELL_POSITIONS.AOE,     -- Death and Decay
    },
    [2] = { -- Frost
        -- ABOVE spells
        [48263] = NAG.SPELL_POSITIONS.ABOVE,   -- Blood Presence
        [48266] = NAG.SPELL_POSITIONS.ABOVE,   -- Frost Presence
        [123693] = NAG.SPELL_POSITIONS.ABOVE,  -- Frost Presence
        [42650] = NAG.SPELL_POSITIONS.ABOVE,   -- Plague Leech
        [48707] = NAG.SPELL_POSITIONS.ABOVE,   -- Anti-Magic Shell
        [48792] = NAG.SPELL_POSITIONS.ABOVE,   -- Icebound Fortitude
        [77606] = NAG.SPELL_POSITIONS.ABOVE,   -- Dark Simulacrum
        [48265] = NAG.SPELL_POSITIONS.ABOVE,   -- Unholy Presence
        [47528] = NAG.SPELL_POSITIONS.ABOVE,   -- Mind Freeze
        [61999] = NAG.SPELL_POSITIONS.ABOVE,   -- Raise Ally
        [56222] = NAG.SPELL_POSITIONS.ABOVE,   -- Dark Command
        [48743] = NAG.SPELL_POSITIONS.ABOVE,   -- Death Pact
        [47476] = NAG.SPELL_POSITIONS.ABOVE,   -- Strangulate
        [45524] = NAG.SPELL_POSITIONS.ABOVE,   -- Chains of Ice
        [55233] = NAG.SPELL_POSITIONS.ABOVE,   -- Vampiric Blood
        [49039] = NAG.SPELL_POSITIONS.ABOVE,   -- Lichborne
        [48982] = NAG.SPELL_POSITIONS.ABOVE,   -- Rune Tap

        -- BELOW spells
        [77575] = NAG.SPELL_POSITIONS.BELOW,   -- Outbreak

        -- RIGHT spells
        [46584] = NAG.SPELL_POSITIONS.RIGHT,   -- Raise Dead
        [114866] = NAG.SPELL_POSITIONS.RIGHT,  -- Soul Reaper

        -- LEFT spells
        [45529] = NAG.SPELL_POSITIONS.LEFT,    -- Blood Tap
        [47568] = NAG.SPELL_POSITIONS.LEFT,    -- Empower Rune Weapon
        [49028] = NAG.SPELL_POSITIONS.LEFT,    -- Dancing Rune Weapon
        [49016] = NAG.SPELL_POSITIONS.LEFT,    -- Unholy Frenzy
        [49206] = NAG.SPELL_POSITIONS.LEFT,    -- Summon Gargoyle
        [51271] = NAG.SPELL_POSITIONS.LEFT,    -- Pillar of Frost
        [33697] = NAG.SPELL_POSITIONS.LEFT,    -- Blood Fury

        -- AOE spells
        [43265] = NAG.SPELL_POSITIONS.AOE,     -- Death and Decay
        [48721] = NAG.SPELL_POSITIONS.AOE,     -- Blood Boil
    },
    [3] = { -- Unholy
        -- ABOVE spells
        [48265] = NAG.SPELL_POSITIONS.ABOVE,   -- Unholy Presence
        [48263] = NAG.SPELL_POSITIONS.ABOVE,   -- Blood Presence
        [48266] = NAG.SPELL_POSITIONS.ABOVE,   -- Frost Presence
        [123693] = NAG.SPELL_POSITIONS.ABOVE,  -- Plague Leech
        [115989] = NAG.SPELL_POSITIONS.ABOVE,  -- Unholy Blight
        [49222] = NAG.SPELL_POSITIONS.ABOVE,  -- Frost Presence
        [42650] = NAG.SPELL_POSITIONS.ABOVE,    -- Bone Shield
        [48707] = NAG.SPELL_POSITIONS.ABOVE,   -- Anti-Magic Shell
        [48792] = NAG.SPELL_POSITIONS.ABOVE,   -- Icebound Fortitude
        [77606] = NAG.SPELL_POSITIONS.ABOVE,   -- Dark Simulacrum
        [47528] = NAG.SPELL_POSITIONS.ABOVE,   -- Mind Freeze
        [61999] = NAG.SPELL_POSITIONS.ABOVE,   -- Raise Ally
        [56222] = NAG.SPELL_POSITIONS.ABOVE,   -- Dark Command
        [48743] = NAG.SPELL_POSITIONS.ABOVE,   -- Death Pact
        [47476] = NAG.SPELL_POSITIONS.ABOVE,   -- Strangulate
        [45524] = NAG.SPELL_POSITIONS.ABOVE,   -- Chains of Ice
        [55233] = NAG.SPELL_POSITIONS.ABOVE,   -- Vampiric Blood
        [49039] = NAG.SPELL_POSITIONS.ABOVE,   -- Lichborne
        [48982] = NAG.SPELL_POSITIONS.ABOVE,   -- Rune Tap

        -- BELOW spells
        [77575] = NAG.SPELL_POSITIONS.BELOW,   -- Outbreak

        -- RIGHT spells
        [46584] = NAG.SPELL_POSITIONS.RIGHT,   -- Raise Dead
        [114866] = NAG.SPELL_POSITIONS.RIGHT,  -- Soul Reaper

        -- LEFT spells
        [45529] = NAG.SPELL_POSITIONS.LEFT,    -- Blood Tap
        [47568] = NAG.SPELL_POSITIONS.LEFT,    -- Empower Rune Weapon
        [49028] = NAG.SPELL_POSITIONS.LEFT,    -- Dancing Rune Weapon
        [49016] = NAG.SPELL_POSITIONS.LEFT,    -- Unholy Frenzy
        [49206] = NAG.SPELL_POSITIONS.LEFT,    -- Summon Gargoyle
        [51271] = NAG.SPELL_POSITIONS.LEFT,    -- Pillar of Frost
        [33697] = NAG.SPELL_POSITIONS.LEFT,    -- Blood Fury

        -- AOE spells
        [43265] = NAG.SPELL_POSITIONS.AOE,     -- Death and Decay
        [48721] = NAG.SPELL_POSITIONS.AOE,     -- Blood Boil
    }
}

-- Skip loading if not the correct class
if UnitClassBase('player') ~= "DEATHKNIGHT" then return end

local unholySTDiurdussyRotation = {
    -- Core identification
    name = "Unholy",
    specIndex = 3,
    class = "DEATHKNIGHT",

    -- Required parameters
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    rotationType = ns.ROTATION_TYPES.CUSTOM,  -- Handles both ST and AOE without auto-switching
    prePull = {
        { time = -7.0, action = "NAG:Cast(42650)" },
        { time = -1.0, action = "NAG:Cast(76095)" }
    },
    lastModified = "07/30/2025",
    variables = {
        { name = "DiseasesNeedExtend", value = [[(true)]] },  -- Unholy uses refresh; always allow Blood+Frost Festering Strike
        { name = "Festerblight", value = [[(false)]] },  -- Not Festerblight; allow Plague Leech for multi-target
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or (((NAG:CurrentTime() > 15.0) or ((NAG:CurrentTime() > 5.0) and (not NAG:DotIsActive(55078)))) and NAG:AuraIsInactive(115989) and ((NAG:DotPercentIncrease(55078) > 0.2) or (not NAG:DotIsActive(55078)))) and NAG:Cast(77575)

    or ((NAG:AuraIsActive(128986) and (NAG:AuraRemainingTime(128986) <= 1.5)) or (NAG:AuraIsActive(126582) and (NAG:AuraRemainingTime(126582) <= 1.5)) or (NAG:AuraIsActive(60229) and (NAG:AuraRemainingTime(60229) <= 1.5)) or (NAG:AuraIsActive(126734) and (NAG:AuraRemainingTime(126734) <= 1.5)) or (NAG:AuraIsActive(33697) and (NAG:AuraRemainingTime(33697) <= 1.5))) and (NAG:ShowCustomOverlay("Cancel") or true) and NAG:CastPlaceholder(115989, nil, NAG.SPELL_POSITIONS.ABOVE)
    or ((NAG:AuraIsActive(49206) and ((NAG:AuraRemainingTime(49206) <= 26.0) or (((NAG:AuraIsActive(128986) and (NAG:AuraRemainingTime(128986) <= 1.5)) or (NAG:AuraIsActive(126582) and (NAG:AuraRemainingTime(126582) <= 1.5)) or (NAG:AuraIsActive(60229) and (NAG:AuraRemainingTime(60229) <= 1.5))) and NAG:SpellIsReady(77575)))) or ((NAG:RemainingTime() <= (NAG:SpellTimeToReady(49206) + 25)) and (NAG:AuraIsActive(128986) or NAG:AuraIsActive(126582) or NAG:AuraIsActive(60229))) or (NAG:RemainingTime() <= 30.0)) and NAG:Cast(76095)
    or (((NAG:CurrentTime() <= 60.0) and (NAG:AuraIsActive(128986) or NAG:AuraIsActive(126582) or NAG:AuraIsActive(60229) or (NAG:CurrentTime() >= 3.0))) or (NAG:AuraIsActive(49206) and (NAG:AuraIsActive(63560, "pet") or NAG:AuraIsActive(76095) or NAG:AuraIsActive(128986) or NAG:AuraIsActive(126582) or NAG:AuraIsActive(60229)) and (NAG:CurrentTime() > 60.0)) or (NAG:RemainingTime() <= 35.0)) and NAG:Cast(49016)
    or ((NAG:CurrentTime() >= 5.0) and (NAG:AuraIsActive(128986) or NAG:AuraIsActive(126582) or NAG:AuraIsActive(60229) or (NAG:RemainingTime() <= 16.0)) and (not ((NAG:TimeToPercent(35) < 6.0) and (NAG:SpellIsReady(49206) or (NAG:AuraRemainingTime(49206) > 26.0)) and (NAG:RemainingTime() >= 16.0)))) and NAG:Cast(33697)
    or ((NAG:AuraRemainingTime(49206) <= 26.0) and NAG:AuraIsActive(49206)) and NAG:Cast(26297)
    or ((NAG:CurrentTime() >= 5.0) and (NAG:AuraIsActive(128986) or NAG:AuraIsActive(126582) or NAG:AuraIsActive(60229) or (NAG:RemainingTime() <= 12.0)) and (not ((NAG:TimeToPercent(35) < 6.0) and (NAG:SpellIsReady(49206) or (NAG:AuraRemainingTime(49206) > 26.0)) and ((NAG:AuraInternalCooldown(128986) <= 25.0) or (NAG:AuraInternalCooldown(126582) <= 25.0) or (NAG:AuraInternalCooldown(60229) <= 25.0)) and (NAG:RemainingTime() >= 12.0)))) and NAG:Cast(126734)
    or (((NAG:CurrentTime() < 5.0) and NAG:DotIsActive(55078)) or (((NAG:TimeToPercent(35) < 6.0) or (NAG:RemainingTime() >= 205.0)) and ((NAG:AuraInternalCooldown(128986) <= 3.0) or (NAG:AuraInternalCooldown(126582) <= 3.0) or (NAG:AuraInternalCooldown(60229) <= 3.0))) or (NAG:RemainingTime() <= 35.0)) and NAG:Cast(49206)
    or ((NAG:DotRemainingTime(55078) < 3.0) or (NAG:DotRemainingTime(55095) < 3.0) or ((NAG:AuraIsActive(128986) or NAG:AuraIsActive(126582) or NAG:AuraIsActive(60229)) and (NAG:DotPercentIncrease(55078) > 0.0)) or (NAG:AuraIsActive(33697) and NAG:AuraIsActive(126734) and (NAG:DotPercentIncrease(55078) > 0.0))) and NAG:Cast(115989)
    or ((NAG:AuraIsActive(128986) or (not NAG:AuraIsKnown(128986))) and (NAG:AuraIsActive(126582) or (not NAG:AuraIsKnown(126582))) and (NAG:AuraIsActive(60229) or (not NAG:AuraIsKnown(60229))) and ((NAG:DotPercentIncrease(55078) > 0.02) or (NAG:DotRemainingTime(55078) <= 12.0)) and (((NAG:AuraIsActive(76095) or (not (NAG:TimeToPercent(35) < 6.0)) or (not NAG:SpellCanCast(76095)) or ((NAG:SpellTimeToReady(49206) >= (NAG:TrinketProcsMinRemainingTime() - 2.0)) and NAG:AuraIsInactive(49206))) and NAG:AuraIsActive(53365)) or (NAG:TrinketProcsMinRemainingTime() <= 2.0)) and (((NAG:TrinketProcsMinRemainingTime() < (NAG:SpellTimeToReady(126734) - 2.0)) and (not (NAG:TrinketProcsMaxRemainingICD() <= (NAG:TrinketProcsMinRemainingTime() - 5.0)))) or NAG:AuraIsActive(126734)) and ((NAG:TrinketProcsMinRemainingTime() < (NAG:SpellTimeToReady(33697) - 2.0)) or NAG:AuraIsActive(33697) or (not ((NAG:TimeToPercent(35) < 6.0) and (NAG:SpellIsReady(49206) or (NAG:AuraRemainingTime(49206) > 26.0))))) and NAG:SpellIsReady(123693) and NAG:SpellIsKnown(123693) and (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0))) and ((NAG:AuraRemainingTime(126734) >= 3.0) or NAG:AuraIsInactive(126734)) and ((NAG:AuraRemainingTime(33697) >= 3.0) or NAG:AuraIsInactive(33697)) and ((NAG:AuraRemainingTime(76095) >= 3.0) or NAG:AuraIsInactive(76095)) and (NAG:TrinketProcsMinRemainingTime() >= 3.0) and (NAG:NumberTargets() == 1)) and NAG:Cast(55090)
    or ((NAG:AuraIsActive(128986) or (not NAG:AuraIsKnown(128986))) and (NAG:AuraIsActive(126582) or (not NAG:AuraIsKnown(126582))) and (NAG:AuraIsActive(60229) or (not NAG:AuraIsKnown(60229))) and ((NAG:DotPercentIncrease(55078) > 0.02) or (NAG:DotRemainingTime(55078) <= 12.0)) and (((NAG:AuraIsActive(76095) or (not (NAG:TimeToPercent(35) < 6.0)) or (not NAG:SpellCanCast(76095)) or ((NAG:SpellTimeToReady(49206) >= (NAG:TrinketProcsMinRemainingTime() - 2.0)) and NAG:AuraIsInactive(49206))) and NAG:AuraIsActive(53365)) or (NAG:TrinketProcsMinRemainingTime() <= 2.0)) and (((NAG:TrinketProcsMinRemainingTime() < (NAG:SpellTimeToReady(126734) - 2.0)) and (not (NAG:TrinketProcsMaxRemainingICD() <= (NAG:TrinketProcsMinRemainingTime() - 5.0)))) or NAG:AuraIsActive(126734)) and ((NAG:TrinketProcsMinRemainingTime() < (NAG:SpellTimeToReady(33697) - 2.0)) or NAG:AuraIsActive(33697) or (not ((NAG:TimeToPercent(35) < 6.0) and (NAG:SpellIsReady(49206) or (NAG:AuraRemainingTime(49206) > 26.0))))) and (((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost))) or ((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightUnholy))) or ((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost)))) and (NAG:NumberTargets() == 1)) and NAG:Cast(123693)
    or ((NAG:AuraIsActive(128986) or NAG:AuraIsActive(126582) or NAG:AuraIsActive(60229)) and ((NAG:DotPercentIncrease(55078) > 0.02) or (NAG:DotRemainingTime(55078) <= 6.0)) and (((NAG:AuraIsActive(76095) or (not (NAG:TimeToPercent(35) < 6.0)) or (not NAG:SpellCanCast(76095)) or ((NAG:SpellTimeToReady(49206) >= (NAG:TrinketProcsMinRemainingTime() - 2.0)) and NAG:AuraIsInactive(49206))) and NAG:AuraIsActive(53365)) or (NAG:TrinketProcsMinRemainingTime() <= 2.0)) and ((NAG:TrinketProcsMinRemainingTime() < (NAG:SpellTimeToReady(126734) - 2.0)) or NAG:AuraIsActive(126734)) and ((NAG:TrinketProcsMinRemainingTime() < (NAG:SpellTimeToReady(33697) - 2.0)) or NAG:AuraIsActive(33697) or (not ((NAG:TimeToPercent(35) < 6.0) and (NAG:SpellIsReady(49206) or (NAG:AuraRemainingTime(49206) > 26.0))))) and (NAG:TrinketProcsMinRemainingTime() <= (NAG:TrinketProcsMaxRemainingICD() + 2)) and (((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost))) or ((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightUnholy))) or ((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost)))) and (NAG:NumberTargets() == 1)) and NAG:Cast(123693)
    or ((NAG:AuraIsActive(128986) or (not NAG:AuraIsKnown(128986))) and (NAG:AuraIsActive(126582) or (not NAG:AuraIsKnown(126582))) and (NAG:AuraIsActive(60229) or (not NAG:AuraIsKnown(60229))) and ((NAG:DotPercentIncrease(55078) > 0.02) or (NAG:DotRemainingTime(55078) <= 12.0)) and NAG:AuraIsInactive(115989) and (((NAG:AuraIsActive(76095) or (not (NAG:TimeToPercent(35) < 6.0)) or (not NAG:SpellCanCast(76095)) or ((NAG:SpellTimeToReady(49206) >= (NAG:TrinketProcsMinRemainingTime() - 2.0)) and NAG:AuraIsInactive(49206))) and NAG:AuraIsActive(53365)) or (NAG:TrinketProcsMinRemainingTime() <= 2.0)) and (((NAG:TrinketProcsMinRemainingTime() < (NAG:SpellTimeToReady(126734) - 2.0)) and (not (NAG:TrinketProcsMaxRemainingICD() <= (NAG:TrinketProcsMinRemainingTime() - 5.0)))) or NAG:AuraIsActive(126734)) and ((NAG:TrinketProcsMinRemainingTime() < (NAG:SpellTimeToReady(33697) - 2.0)) or NAG:AuraIsActive(33697) or (not ((NAG:TimeToPercent(35) < 6.0) and (NAG:SpellIsReady(49206) or (NAG:AuraRemainingTime(49206) > 26.0))))) and ((not NAG:SpellIsReady(123693)) or NAG:AuraIsActive(2825) or NAG:AuraIsActive(49016))) and NAG:Cast(77575)
    or ((NAG:AuraIsActive(128986) or NAG:AuraIsActive(126582) or NAG:AuraIsActive(60229)) and ((NAG:DotPercentIncrease(55078) > 0.02) or (NAG:DotRemainingTime(55078) <= 6.0)) and NAG:AuraIsInactive(115989) and (((NAG:AuraIsActive(76095) or (not (NAG:TimeToPercent(35) < 6.0)) or (not NAG:SpellCanCast(76095)) or ((NAG:SpellTimeToReady(49206) >= (NAG:TrinketProcsMinRemainingTime() - 2.0)) and NAG:AuraIsInactive(49206))) and NAG:AuraIsActive(53365)) or (NAG:TrinketProcsMinRemainingTime() <= 2.0)) and ((NAG:TrinketProcsMinRemainingTime() < (NAG:SpellTimeToReady(126734) - 2.0)) or NAG:AuraIsActive(126734)) and ((NAG:TrinketProcsMinRemainingTime() < (NAG:SpellTimeToReady(33697) - 2.0)) or NAG:AuraIsActive(33697) or (not ((NAG:TimeToPercent(35) < 6.0) and (NAG:SpellIsReady(49206) or (NAG:AuraRemainingTime(49206) > 26.0))))) and (NAG:TrinketProcsMinRemainingTime() <= (NAG:TrinketProcsMaxRemainingICD() + 2)) and ((not NAG:SpellIsReady(123693)) or NAG:AuraIsActive(2825) or NAG:AuraIsActive(49016))) and NAG:Cast(77575)
    or ((NAG:CurrentTime() > 15.0) and (NAG:DotPercentIncrease(55078) > 0.2) and NAG:SpellIsReady(77575) and (((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost))) or ((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightUnholy))) or ((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost)))) and (NAG:NumberTargets() == 1)) and NAG:Cast(123693)
    or ((NAG:CurrentTime() > 15.0) and (NAG:DotPercentIncrease(55078) >= 0.0) and (NAG:RemainingTime() >= 30.0) and (((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost))) or ((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightUnholy))) or ((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost)))) and (NAG:NumberTargets() == 1)) and NAG:Cast(123693)
    or ((NAG:CurrentTime() > 15.0) and NAG:AuraIsInactive(115989) and ((NAG:DotPercentIncrease(55078) > 0.1) or ((NAG:SpellTimeToReady(123693) > 23.0) and (NAG:DotPercentIncrease(55078) >= 0.0) and NAG:SpellIsKnown(123693))) and ((NAG:RemainingTime() >= 30.0) or ((not NAG:SpellIsReady(77575)) and (not NAG:DotIsActive(55078)))) and (not NAG:SpellIsReady(115989))) and NAG:Cast(45462)
    or ((NAG:AuraNumStacks(114851) > 10) or ((((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) <= 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0)) or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) <= 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0))) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0) and (not (NAG:TimeToPercent(35) < 6.0)) and (NAG:AuraIsActive(128986) or NAG:AuraIsActive(126582) or NAG:AuraIsActive(60229) or NAG:SpellIsReady(43265) or ((NAG:NumberTargets() >= 3) and (NAG:AuraNumStacks(91342) == 5)))) or (NAG:RemainingTime() <= 10.0)) and NAG:Cast(45529)
    or ((NAG:CurrentTime() < 5.0) and (not NAG:DotIsActive(55078))) and NAG:Cast(45462)
    -- AoE opener spread logic: prioritize Blood Plague-based spread; Roiling Blood uses Blood Boil to spread
    or ((NAG:CurrentTime() < 5.0) and NAG:DotIsActive(55078) and NAG:AuraIsKnown(108170) and (NAG:NumberTargets() >= 3)
        and (NAG:NumberTargetsWithDebuff(55078, 8) < NAG:CountEnemiesInRange(8)) and NAG:SpellIsReady(48721)) and NAG:Cast(48721)
    or ((NAG:CurrentTime() < 5.0) and NAG:DotIsActive(55078) and (not NAG:AuraIsKnown(108170)) and (NAG:NumberTargets() >= 3)
        and (NAG:NumberTargetsWithDebuff(55078, 8) < NAG:CountEnemiesInRange(8)) and NAG:SpellIsReady(50842)) and NAG:Cast(50842)
    or (((NAG:CurrentTime() < 5.0) or (NAG:NumberTargets() >= 4)) and NAG:DotIsActive(55078) and (((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) < 2) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) < 2)) or (NAG:NumberTargets() >= 4))) and NAG:Cast(43265)
    or (((NAG:DotRemainingTime(55078) < 3.0) or (NAG:DotRemainingTime(55095) < 3.0)) and (NAG:RemainingTime() <= 30.0) and NAG:SpellIsReady(77575) and (((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost))) or ((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightUnholy))) or ((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost)))) and (NAG:NumberTargets() == 1)) and NAG:Cast(123693)
    or (NAG:DotIsActive(55078) and (NAG:DotRemainingTime(55078) < 3.0) and (((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost))) or ((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightUnholy))) or ((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost)))) and (NAG:NumberTargets() > 1)) and NAG:Cast(123693)
    or (((NAG:DotRemainingTime(55078) < 3.0) or (NAG:DotRemainingTime(55095) < 3.0)) and (not NAG:AuraIsActive(115989)) and (NAG:RemainingTime() <= 30.0)) and NAG:Cast(77575)
    or ((not NAG:DotIsActive(55078)) or (not NAG:DotIsActive(55095))) and NAG:Cast(45462)
    -- Mid-rotation spread logic: use Blood Plague presence to decide spreads, not Frost Fever
    or (NAG:DotIsActive(55078) and (NAG:NumberTargets() > 1) and NAG:AuraIsKnown(108170)
        and (NAG:NumberTargetsWithDebuff(55078, 8) < NAG:CountEnemiesInRange(8)) and NAG:SpellIsReady(48721)) and NAG:Cast(48721)
    or (NAG:DotIsActive(55078) and (NAG:NumberTargets() > 1) and (not NAG:AuraIsKnown(108170))
        and (NAG:NumberTargetsWithDebuff(55078, 8) < NAG:CountEnemiesInRange(8)) and NAG:SpellIsReady(50842)) and NAG:Cast(50842)

    --or ((NAG:SpellIsReady(114867) and ((NAG:TimeToPercent(35) < 6.0) or (NAG:AuraIsKnown(138347) and (NAG:TimeToPercent(45) < 6.0))) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0))) and NAG:StrictSequence("someName207", nil, 45529, 114867)
    or (NAG:SpellIsReady(114867) and ((NAG:TimeToPercent(35) < 6.0) or (NAG:AuraIsKnown(138347) and (NAG:TimeToPercent(45) < 6.0))) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0)) and NAG:Cast(114867, nil, NAG.SPELL_POSITIONS.AOE)
    or (NAG:SpellIsReady(114867) and ((NAG:TimeToPercent(35) < 6.0) or (NAG:AuraIsKnown(138347) and (NAG:TimeToPercent(45) < 6.0))) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0)) and NAG:Cast(45529)
    or (((NAG:TimeToPercent(35) < 6.0) or (NAG:AuraIsKnown(138347) and (NAG:TimeToPercent(45) < 6.0))) and (NAG:RemainingTime() >= 5.0)) and NAG:Cast(114867)
    or ((NAG:RemainingTime() >= 15.0) and (not ((NAG:TimeToPercent(35) < 6.0) and NAG:SpellIsReady(49206) and (NAG:RemainingTime() >= 35.0)))) and NAG:Cast(63560)
    or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) >= 1) and (NAG:NumberTargets() >= 4)) and NAG:Cast(45477)
    or ((NAG:CurrentRunicPower() >= 90) and (not ((NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) <= 1.0) or (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) <= 1.0))) and (NAG:NumberTargets() >= 4)) and NAG:Cast(47541)
    or (NAG:NumberTargets() >= 4) and NAG:Cast(48721)
    or ((NAG:DotRemainingTime(55078) < 3.0) and (not NAG:SpellIsReady(115989)) and ((NAG:DotRemainingTime(55078) < NAG:RemainingTime()) and ((NAG:DotRemainingTime(55078) < NAG:SpellTimeToReady(126734)) or (NAG:DotRemainingTime(55078) < NAG:TrinketProcsMaxRemainingICD()))) and ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) >= 1) or (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) >= 1))) and NAG:Cast(85948)
    or ((((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost))) or ((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightUnholy))) or ((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost)))) and (NAG:DotRemainingTime(55078) < 3.0)) and NAG:Cast(123693)
    or ((NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy) <= 1.0) and ((NAG:RemainingTime() >= 8.0) or ((NAG:NumberTargets() >= 2) and (NAG:RemainingTime() >= 6.0)) or ((NAG:NumberTargets() >= 3) and (NAG:RemainingTime() >= 4.0)))) and NAG:Cast(43265)
    or ((NAG:NumberTargets() >= 2) and (NAG:AuraNumStacks(91342) == 4)) and NAG:Cast(47541)
    or (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy) <= 1.0) and NAG:Cast(55090)
    or (NAG:CurrentRunicPower() > 90) and NAG:Cast(47541)
    or ((((NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) <= 1) and (not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0)) or ((NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) <= 1) and (not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0))) and (NAG:CurrentRunicPower() <= 80)) and NAG:Cast(45529)
    or (NAG:VariableRef("DiseasesNeedExtend") and (((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) >= 1) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) <= 1.0) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) >= 1)) or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) >= 1) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) <= 1.0) and (not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood))) or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) >= 1) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) <= 1.0) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) >= 1)) or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) >= 1) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) <= 1.0) and (not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost))))) and NAG:Cast(85948)
    or (NAG:AuraNumStacks(91342) == 4) and NAG:Cast(47541)
    or ((((NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) <= 1.0) and ((NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) or (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)))) or ((NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) <= 1.0) and ((NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost))))) and ((NAG:RemainingTime() >= 8.0) or ((NAG:NumberTargets() >= 2) and (NAG:RemainingTime() >= 6.0)) or ((NAG:NumberTargets() >= 3) and (NAG:RemainingTime() >= 4.0)))) and NAG:Cast(43265)
    or (((NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) <= 1.0) and ((NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) or (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)))) or ((NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) <= 1.0) and ((NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost))))) and NAG:Cast(55090)
    or (NAG:AuraIsActive(81340) or NAG:AuraIsInactive(63560, "pet")) and NAG:Cast(47541)
    or ((not ((NAG:TimeToPercent(35) < 6.0) and (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) and (NAG:SpellTimeToReady(114867) < NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851) < 5)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) and (NAG:SpellTimeToReady(114867) < NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851) < 5)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) and (NAG:SpellTimeToReady(114867) < NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851) < 5)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) and (NAG:SpellTimeToReady(114867) < NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851) < 5)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) and (NAG:SpellTimeToReady(114867) < NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851) < 5))))) and ((NAG:RemainingTime() >= 8.0) or ((NAG:NumberTargets() >= 2) and (NAG:RemainingTime() >= 6.0)) or ((NAG:NumberTargets() >= 3) and (NAG:RemainingTime() >= 4.0)))) and NAG:Cast(43265)
    or (((not ((NAG:TimeToPercent(35) < 6.0) and (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) and (NAG:SpellTimeToReady(114867) < NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851) < 5)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) and (NAG:SpellTimeToReady(114867) < NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851) < 5)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) and (NAG:SpellTimeToReady(114867) < NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851) < 5)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) and (NAG:SpellTimeToReady(114867) < NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851) < 5)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) and (NAG:SpellTimeToReady(114867) < NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851) < 5))))) or (NAG:RemainingTime() < 5.0) or (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) >= 1)) and (not NAG:SpellCanCast(43265)) and (NAG:NumberTargets() >= 3)) and NAG:Cast(48721)
    or ((not ((NAG:TimeToPercent(35) < 6.0) and (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) and (NAG:SpellTimeToReady(114867) < NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851) < 5)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) and (NAG:SpellTimeToReady(114867) < NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851) < 5)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) and (NAG:SpellTimeToReady(114867) < NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851) < 5)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) and (NAG:SpellTimeToReady(114867) < NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851) < 5)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) and (NAG:SpellTimeToReady(114867) < NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851) < 5))))) or (NAG:RemainingTime() < 5.0)) and NAG:Cast(55090)
    or (not (NAG:AuraIsActive(63560, "pet") and (NAG:AuraRemainingTime(63560, "pet") <= 5.0) and (NAG:RemainingTime() >= 10.0))) and NAG:Cast(47541)
    or ((not (NAG:TimeToPercent(35) < 6.0)) or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) >= 1) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) >= 1))) and NAG:Cast(85948)
    or ((not NAG:VariableRef("Festerblight")) and (NAG:NumberTargets() > 1) and NAG:DotIsActive(55078) and (((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost))) or ((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightUnholy))) or ((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost))))) and NAG:Cast(123693)
    or NAG:Cast(57330)
    or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) >= 3.0) and (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) <= 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) >= 3.0)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) <= 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) >= 3.0))) and ((not NAG:AuraIsActive(63560, "pet")) or (not NAG:SpellCanCast(47541))) and NAG:AuraIsInactive(2825)) and NAG:Cast(47568)

    or NAG:IsExecutePhase(35) and ((
                (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood))
                and (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost))
            )
            or
                (
                    (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)  and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood)  <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood)  <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood)  <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy))
                    or
                    (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy))
                    or
                    (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)  and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost)  <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost)  <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost)  <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy))
                    or
                    (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy))
                    or
                    (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftUnholy) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy))
                    or
                    (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightUnholy) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy))
                )
            ) and NAG:Cast(130736, 10)

        or     (((NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)) and (NAG:DotRemainingTime(55078) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)) and (NAG:DotRemainingTime(55078) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)) and (NAG:DotRemainingTime(55078) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and (NAG:DotRemainingTime(55078) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and (NAG:DotRemainingTime(55078) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost)))) and NAG:Cast(45462, 10)
        or     (((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) > NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or ((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) > NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or ((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) > NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or ((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) > NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) or (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost))) and NAG:AuraNumStacks(91342) >= 5 and NAG:Cast(63560, 10)
        or     (((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) > NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or ((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) > NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or ((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) > NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or ((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) > NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) or (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost))) and NAG:Cast(55090, 10)
        or     NAG:Cast(85948, 10)
    ]],

    -- Tracked IDs for optimization
    spells = {33697, 43265, 45462, 45529, 47541, 47568, 48265, 49016, 49206, 53365, 55078, 55090, 55095, 57330, 63560, 77575, 81340, 85948, 114851, 114867, 115989, 123693, 126734, 138347},
    items = {76095},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {43533, 43548, 104047, 43550, 45806, 43539},
    author = "@Diurdussy",

}

-- ============================ FESTERBLIGHT STATE TRACKING ============================

--- Returns true for 2 seconds after Unholy Blight (115989) ends without Unholy Strength (53365) having been active during its duration.
--- Used when: 115989 was active, then gets cancelled or wears off, and 53365 was never detected during that time.
--- @return boolean True if within the 2-second window after the trigger condition
function NAG:UnholyBlightEndedWithoutUnholyStrength()
    local now = GetTime()
    if not NAG._unholyBlightState then
        NAG._unholyBlightState = {
            blightWasActive = false,
            sawUnholyStrengthDuringBlight = false,
            expiryTime = 0
        }
    end
    local state = NAG._unholyBlightState
    local blightActive = NAG:AuraIsActive(115989, "player")
    local unholyStrengthActive = NAG:AuraIsActive(53365, "player")
    if blightActive then
        state.blightWasActive = true
        if unholyStrengthActive then
            state.sawUnholyStrengthDuringBlight = true
        end
        if now < state.expiryTime then return true end
        return false
    end
    if state.blightWasActive then
        local triggered = not state.sawUnholyStrengthDuringBlight
        state.blightWasActive = false
        state.sawUnholyStrengthDuringBlight = false
        if triggered then
            state.expiryTime = now + 2.0
            return true
        end
        return false
    end
    if now < state.expiryTime then return true end
    state.expiryTime = 0
    return false
end

--- Returns true during a short window when Unholy Blight ended and the last snapped FoF stack count was below 9.
--- Trigger timing: starts 2 seconds after Unholy Blight (115989) ends, lasts for 2 seconds.
--- @return boolean True when snapshot miss condition is active in the check window
function NAG:UnholyBlightEndedWithout10FoFStacks()
    local now = GetTime()
    if not NAG._unholyBlightFoFState then
        NAG._unholyBlightFoFState = {
            blightWasActive = false,
            checkAt = 0,
            expiryTime = 0,
            triggered = false
        }
    end

    local state = NAG._unholyBlightFoFState
    local blightActive = NAG:AuraIsActive(115989, "player")

    if blightActive then
        state.blightWasActive = true
        state.checkAt = 0
        state.expiryTime = 0
        state.triggered = false
        return false
    end

    if state.blightWasActive then
        state.blightWasActive = false
        state.checkAt = now + 2.0
        state.expiryTime = state.checkAt + 2.0
        state.triggered = false
        return false
    end

    if state.checkAt > 0 and now >= state.checkAt then
        if not state.triggered then
            local snapStacks = NAG:SnapStacksFoF("target")
            state.triggered = (snapStacks < 9)
        end
        if now < state.expiryTime then
            return state.triggered
        end
        state.checkAt = 0
        state.expiryTime = 0
        state.triggered = false
    end

    return false
end

--- Returns overlay text for Unholy Blight cancel timing: min(FoF 138758, Unholy Strength 53365) remaining - 0.3s.
--- Returns "" if UB ends before the buffs (no need to prompt). If result <= 0, returns "NOW"; else "Cancel in X.X s".
--- @return string|nil
function NAG:UnholyBlightCancelOverlayText()
    local fof = NAG:AuraRemainingTime(138758, "player")
    local uh = NAG:AuraRemainingTime(53365, "player")
    if not fof and not uh then return nil end
    local ubRemaining = NAG:AuraRemainingTime(115989, "player")
    local t = math.min(fof or 999, uh or 999) - 0.3
    if ubRemaining and ubRemaining < t then return "" end
    if t <= 0 then return "NOW" end
    return string.format("Cancel in %.1f s", t)
end

local unholyFesterblight = {
    -- Core identification
    name = "Festerblight",
    specIndex = 3,
    class = "DEATHKNIGHT",

    -- Required parameters
    default = false,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    rotationType = ns.ROTATION_TYPES.CUSTOM,  -- Handles both ST and AOE without auto-switching
    prePull = {
        { time = -7.0, action = "NAG:Cast(42650)" },
        { time = -1.0, action = "NAG:Cast(76095)" }
    },
    lastModified = "03/02/2026",
    variables = {
        {
            name = "DiseasesNeedExtend",
            value = [[(NAG:DotIsActive(55078) and (NAG:DotRemainingTime(55078) < (NAG:RemainingTime() - 6)) and (NAG:RemainingTime() >= 12) and (NAG:NumberTargets() == 1) and (NAG:DotRemainingTime(55078) <= (NAG:RemainingTime() + 10)))]]
        },
        {
            name = "UnholyBlightShouldCancel",
            value = [[(NAG:AuraIsActive(138758) and (NAG:AuraNumStacks(138758, "player") == 10)) or (NAG:AuraIsActive(115989) and (NAG:AuraRemainingTime(115989) <= 5.0)) or (NAG:AuraIsActive(33697) and (NAG:AuraRemainingTime(33697) <= 2.0)) or (NAG:AuraIsActive(53365) and (NAG:AuraRemainingTime(53365) <= 2.0))]]
        },
        {
            name = "UnholyBlightEndedWithoutUnholyStrength",
            value = [[(NAG:UnholyBlightEndedWithoutUnholyStrength())]]
        },
        {
            name = "UnholyBlightEndedWithout10FoFStacks",
            value = [[(NAG:UnholyBlightEndedWithout10FoFStacks())]]
        },
        { name = "Festerblight", value = [[(true)]] },  -- Festerblight: never use Plague Leech for refresh
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or NAG:VariableRef("UnholyBlightEndedWithoutUnholyStrength") and NAG:SelectRotation("Unholy")
    or NAG:VariableRef("UnholyBlightEndedWithout10FoFStacks") and NAG:SelectRotation("Unholy")
    or NAG:AuraIsActive(115989) and NAG:UnholyBlightCancelOverlayText() and (NAG:ShowCustomOverlay(NAG:UnholyBlightCancelOverlayText()) or true) and NAG:CastPlaceholder(115989, 180, NAG.SPELL_POSITIONS.ABOVE)
    or ((NAG:CurrentTime() < 5.0) and NAG:SpellIsReady(115989) and NAG:AuraIsInactive(115989) and (NAG:AuraIsActive(49206) or NAG:SpellIsReady(49206))) and NAG:Cast(115989, nil, NAG.SPELL_POSITIONS.ABOVE)
    or ((not NAG:DotIsActive(55078)) or (not NAG:DotIsActive(55095))) and NAG:AuraIsInactive(115989) and NAG:Cast(77575, nil, NAG.SPELL_POSITIONS.ABOVE)
    or (NAG:DotIsActive(55078) and NAG:DotPercentIncrease(55078) > 0.02 and NAG:AuraIsInactive(115989)) and NAG:Cast(77575, nil, NAG.SPELL_POSITIONS.ABOVE) --NAG:CastWithOverlay(77575, string.format("+%d%%", NAG:DotPercentIncrease(55078) * 100), NAG.SPELL_POSITIONS.ABOVE)
    --or (NAG:DotIsActive(55078) and NAG:DotPercentIncrease(55078) > 0.02 and NAG:AuraIsInactive(115989) and (not NAG:SpellIsReady(77575))) and NAG:CastPlaceholderWithOverlay(45462, ("+" .. tostring(math.floor((NAG:DotPercentIncrease(55078) or 0) * 100)) .. "%%"), NAG.SPELL_POSITIONS.ABOVE)
    --or ((NAG:AuraIsActive(128986) and (NAG:AuraRemainingTime(128986) <= 1.5)) or (NAG:AuraIsActive(126582) and (NAG:AuraRemainingTime(126582) <= 1.5)) or (NAG:AuraIsActive(60229) and (NAG:AuraRemainingTime(60229) <= 1.5)) or (NAG:AuraIsActive(126734) and (NAG:AuraRemainingTime(126734) <= 1.5)) or (NAG:AuraIsActive(33697) and (NAG:AuraRemainingTime(33697) <= 3.0)) or (NAG:AuraIsActive(53365) and (NAG:AuraRemainingTime(53365) <= 3.0))) and (NAG:ShowCustomOverlay("Cancel") or true) and NAG:CastPlaceholder(115989, nil, NAG.SPELL_POSITIONS.ABOVE)
    or ((NAG:AuraIsActive(49206) and ((NAG:AuraRemainingTime(49206) <= 26.0) or (((NAG:AuraIsActive(128986) and (NAG:AuraRemainingTime(128986) <= 1.5)) or (NAG:AuraIsActive(126582) and (NAG:AuraRemainingTime(126582) <= 1.5)) or (NAG:AuraIsActive(60229) and (NAG:AuraRemainingTime(60229) <= 1.5))) and NAG:SpellIsReady(77575)))) or ((NAG:RemainingTime() <= (NAG:SpellTimeToReady(49206) + 25)) and (NAG:AuraIsActive(128986) or NAG:AuraIsActive(126582) or NAG:AuraIsActive(60229))) or (NAG:RemainingTime() <= 30.0)) and NAG:Cast(76095)
    or (((NAG:CurrentTime() <= 60.0) and (NAG:AuraIsActive(128986) or NAG:AuraIsActive(126582) or NAG:AuraIsActive(60229) or (NAG:CurrentTime() >= 3.0))) or (NAG:AuraIsActive(49206) and (NAG:AuraIsActive(63560, "pet") or NAG:AuraIsActive(76095) or NAG:AuraIsActive(128986) or NAG:AuraIsActive(126582) or NAG:AuraIsActive(60229)) and (NAG:CurrentTime() > 60.0)) or (NAG:RemainingTime() <= 35.0)) and NAG:Cast(49016)
    or ((NAG:CurrentTime() >= 5.0) and (NAG:AuraIsActive(128986) or NAG:AuraIsActive(126582) or NAG:AuraIsActive(60229) or (NAG:RemainingTime() <= 16.0)) and (not ((NAG:TimeToPercent(35) < 6.0) and (NAG:SpellIsReady(49206) or (NAG:AuraRemainingTime(49206) > 26.0)) and (NAG:RemainingTime() >= 16.0)))) and NAG:Cast(33697)
    or ((NAG:AuraRemainingTime(49206) <= 26.0) and NAG:AuraIsActive(49206)) and NAG:Cast(26297)
    or ((NAG:CurrentTime() >= 5.0) and (NAG:AuraIsActive(128986) or NAG:AuraIsActive(126582) or NAG:AuraIsActive(60229) or (NAG:RemainingTime() <= 12.0)) and (not ((NAG:TimeToPercent(35) < 6.0) and (NAG:SpellIsReady(49206) or (NAG:AuraRemainingTime(49206) > 26.0)) and ((NAG:AuraInternalCooldown(128986) <= 25.0) or (NAG:AuraInternalCooldown(126582) <= 25.0) or (NAG:AuraInternalCooldown(60229) <= 25.0)) and (NAG:RemainingTime() >= 12.0)))) and NAG:Cast(126734)
    or (((NAG:CurrentTime() < 5.0) and NAG:DotIsActive(55078)) or (((NAG:TimeToPercent(35) < 6.0) or (NAG:RemainingTime() >= 205.0)) and ((NAG:AuraInternalCooldown(128986) <= 3.0) or (NAG:AuraInternalCooldown(126582) <= 3.0) or (NAG:AuraInternalCooldown(60229) <= 3.0))) or (NAG:RemainingTime() <= 35.0)) and NAG:Cast(49206)
    --or (((not NAG:DotIsActive(55078)) or (not NAG:DotIsActive(55095))) and NAG:SpellIsReady(115989) and NAG:Cast(115989))
    or ((NAG:AuraNumStacks(114851) > 10) or ((((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) <= 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0)) or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) <= 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0))) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0) and (not (NAG:TimeToPercent(35) < 6.0)) and (NAG:AuraIsActive(128986) or NAG:AuraIsActive(126582) or NAG:AuraIsActive(60229) or NAG:SpellIsReady(43265) or ((NAG:NumberTargets() >= 3) and (NAG:AuraNumStacks(91342) == 5)))) or (NAG:RemainingTime() <= 10.0)) and NAG:Cast(45529)
    or ((NAG:CurrentTime() < 5.0) and (not NAG:DotIsActive(55078))) and NAG:Cast(45462)
    -- AoE opener spread logic: prioritize Blood Plague-based spread; Roiling Blood uses Blood Boil to spread
    --or ((NAG:CurrentTime() < 5.0) and NAG:DotIsActive(55078) and NAG:AuraIsKnown(108170) and (NAG:NumberTargets() >= 3)
    --    and (NAG:NumberTargetsWithDebuff(55078, 8) < NAG:CountEnemiesInRange(8)) and NAG:SpellIsReady(48721)) and NAG:Cast(48721)
    or ((NAG:CurrentTime() < 5.0) and NAG:DotIsActive(55078) and (not NAG:AuraIsKnown(108170)) and (NAG:NumberTargets() >= 3)
        and (NAG:NumberTargetsWithDebuff(55078, 8) < NAG:CountEnemiesInRange(8)) and NAG:SpellIsReady(50842)) and NAG:Cast(50842)
    or (((NAG:CurrentTime() < 5.0) or (NAG:NumberTargets() >= 4)) and NAG:DotIsActive(55078) and (((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) < 2) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) < 2)) or (NAG:NumberTargets() >= 4)) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1)) and NAG:Cast(43265)
    or (NAG:VariableRef("DiseasesNeedExtend") and ((((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost))) or ((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightUnholy))) or ((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost))))) and (NAG:NumberTargets() == 1)) and NAG:Cast(85948)
    or (((NAG:DotRemainingTime(55078) < 12.0) or ((NAG:RemainingTime() >= 6) and (NAG:DotRemainingTime(55078) < (NAG:RemainingTime() - 6)))) and (NAG:DotRemainingTime(55078) <= (NAG:RemainingTime() + 10)) and (not NAG:SpellIsReady(115989)) and ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) >= 1) or (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) >= 1))) and NAG:Cast(85948)
    or ((not NAG:DotIsActive(55078)) or (not NAG:DotIsActive(55095))) and NAG:Cast(45462)
    -- Festerblight: no Plague Leech for refresh; Festering Strike extends only
    -- When diseases > TTD+10: no extend needed, prioritize SS; otherwise Festering Strike whenever possible
    -- Mid-rotation spread logic: use Blood Plague presence to decide spreads, not Frost Fever
    --or (NAG:DotIsActive(55078) and (NAG:NumberTargets() > 1) and NAG:AuraIsKnown(108170)
    --    and (NAG:NumberTargetsWithDebuff(55078, 8) < NAG:CountEnemiesInRange(8)) and NAG:SpellIsReady(48721)) and NAG:Cast(48721)
    or (NAG:DotIsActive(55078) and (NAG:NumberTargets() > 1) and (not NAG:AuraIsKnown(108170))
        and (NAG:NumberTargetsWithDebuff(55078, 8) < NAG:CountEnemiesInRange(8)) and NAG:SpellIsReady(50842)) and NAG:Cast(50842)

    --or ((NAG:SpellIsReady(114867) and ((NAG:TimeToPercent(35) < 6.0) or (NAG:AuraIsKnown(138347) and (NAG:TimeToPercent(45) < 6.0))) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0))) and NAG:StrictSequence("someName207", nil, 45529, 114867)
    or (NAG:SpellIsReady(114867) and ((NAG:TimeToPercent(35) < 6.0) or (NAG:AuraIsKnown(138347) and (NAG:TimeToPercent(45) < 6.0))) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0)) and NAG:Cast(114867, nil, NAG.SPELL_POSITIONS.AOE)
    or (NAG:SpellIsReady(114867) and ((NAG:TimeToPercent(35) < 6.0) or (NAG:AuraIsKnown(138347) and (NAG:TimeToPercent(45) < 6.0))) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0)) and NAG:Cast(45529)
    or (((NAG:TimeToPercent(35) < 6.0) or (NAG:AuraIsKnown(138347) and (NAG:TimeToPercent(45) < 6.0))) and (NAG:RemainingTime() >= 5.0)) and NAG:Cast(114867)
    or ((NAG:RemainingTime() >= 15.0) and (not ((NAG:TimeToPercent(35) < 6.0) and NAG:SpellIsReady(49206) and (NAG:RemainingTime() >= 35.0)))) and NAG:Cast(63560)
    or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) >= 1) and (NAG:NumberTargets() >= 4)) and NAG:Cast(45477)
    or ((NAG:CurrentRunicPower() >= 90) and (not ((NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) <= 1.0) or (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) <= 1.0))) and (NAG:NumberTargets() >= 4)) and NAG:Cast(47541)
    --or (NAG:NumberTargets() >= 4) and NAG:Cast(48721)
    or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1) and ((NAG:RemainingTime() >= 8.0) or ((NAG:NumberTargets() >= 2) and (NAG:RemainingTime() >= 6.0)) or ((NAG:NumberTargets() >= 3) and (NAG:RemainingTime() >= 4.0)))) and NAG:Cast(43265)
   -- or ((NAG:NumberTargets() >= 2) and (NAG:AuraNumStacks(91342) == 4)) and NAG:Cast(47541)
    or (NAG:VariableRef("DiseasesNeedExtend") and (((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) >= 1) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) <= 1.0) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) >= 1)) or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) >= 1) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) <= 1.0) and (not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood))) or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) >= 1) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) <= 1.0) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) >= 1)) or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) >= 1) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) <= 1.0) and (not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost))))) and NAG:Cast(85948)
    or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) >= 1) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) >= 1) and NAG:DotIsActive(55078)) and NAG:Cast(85948)
    or (NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftUnholy) or NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightUnholy)) and NAG:Cast(55090)
    or (NAG:CurrentRunicPower() > 90) and NAG:Cast(47541)
    or ((((NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) <= 1) and (not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0)) or ((NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) <= 1) and (not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0))) and (NAG:CurrentRunicPower() <= 80)) and NAG:Cast(45529)
    or (NAG:AuraNumStacks(91342) == 4) and NAG:Cast(47541)
    or ((not NAG:VariableRef("Festerblight")) and (((NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) <= 1.0) and ((NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) or (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)))) or ((NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) <= 1.0) and ((NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost))))) and NAG:Cast(55090)
    or (NAG:AuraIsActive(81340) or NAG:AuraIsInactive(63560, "pet")) and NAG:Cast(47541)
    or ((not (NAG:VariableRef("Festerblight") and NAG:VariableRef("DiseasesNeedExtend"))) and ((not ((NAG:TimeToPercent(35) < 6.0) and (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) and (NAG:SpellTimeToReady(114867) < NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851) < 5)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) and (NAG:SpellTimeToReady(114867) < NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851) < 5)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) and (NAG:SpellTimeToReady(114867) < NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851) < 5)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) and (NAG:SpellTimeToReady(114867) < NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851) < 5)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) and (NAG:SpellTimeToReady(114867) < NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851) < 5))))) and ((NAG:RemainingTime() >= 8.0) or ((NAG:NumberTargets() >= 2) and (NAG:RemainingTime() >= 6.0)) or ((NAG:NumberTargets() >= 3) and (NAG:RemainingTime() >= 4.0))))) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1) and NAG:Cast(43265)
    or (((not ((NAG:TimeToPercent(35) < 6.0) and (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) and (NAG:SpellTimeToReady(114867) < NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851) < 5)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) and (NAG:SpellTimeToReady(114867) < NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851) < 5)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) and (NAG:SpellTimeToReady(114867) < NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851) < 5)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) and (NAG:SpellTimeToReady(114867) < NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851) < 5)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) and (NAG:SpellTimeToReady(114867) < NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851) < 5))))) or (NAG:RemainingTime() < 5.0) or (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) >= 1))) and (not NAG:SpellCanCast(43265)) and (NAG:NumberTargets() >= 3)) and NAG:Cast(48721)
    or ((not NAG:VariableRef("Festerblight")) and (not (NAG:VariableRef("Festerblight") and NAG:VariableRef("DiseasesNeedExtend"))) and ((not ((NAG:TimeToPercent(35) < 6.0) and (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) and (NAG:SpellTimeToReady(114867) < NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851) < 5)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) and (NAG:SpellTimeToReady(114867) < NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851) < 5)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) and (NAG:SpellTimeToReady(114867) < NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851) < 5)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) and (NAG:SpellTimeToReady(114867) < NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851) < 5)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) and (NAG:SpellTimeToReady(114867) < NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851) < 5))))) or (NAG:RemainingTime() < 5.0))) and NAG:Cast(55090)
    or (not (NAG:AuraIsActive(63560, "pet") and (NAG:AuraRemainingTime(63560, "pet") <= 5.0) and (NAG:RemainingTime() >= 10.0))) and NAG:Cast(47541)
    or (NAG:VariableRef("DiseasesNeedExtend") and ((not (NAG:TimeToPercent(35) < 6.0)) or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) >= 1) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) >= 1)))) and NAG:Cast(85948)
    or ((not NAG:VariableRef("Festerblight")) and (NAG:NumberTargets() > 1) and NAG:DotIsActive(55078) and (((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost))) or ((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightUnholy))) or ((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost))))) and NAG:Cast(123693)
    or NAG:Cast(57330)
    or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) >= 3.0) and (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) <= 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) >= 3.0)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) <= 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) >= 3.0))) and ((not NAG:AuraIsActive(63560, "pet")) or (not NAG:SpellCanCast(47541))) and NAG:AuraIsInactive(2825)) and NAG:Cast(47568)

    or NAG:IsExecutePhase(35) and ((
                (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood))
                and (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost))
            )
            or
                (
                    (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)  and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood)  <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood)  <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood)  <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy))
                    or
                    (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy))
                    or
                    (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)  and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost)  <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost)  <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost)  <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy))
                    or
                    (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy))
                    or
                    (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftUnholy) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy))
                    or
                    (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightUnholy) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy))
                )
            ) and NAG:Cast(130736, 10)

        or     (((NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)) and (NAG:DotRemainingTime(55078) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)) and (NAG:DotRemainingTime(55078) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)) and (NAG:DotRemainingTime(55078) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and (NAG:DotRemainingTime(55078) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and (NAG:DotRemainingTime(55078) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost)))) and NAG:Cast(45462, 10)
        or     (((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) > NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or ((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) > NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or ((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) > NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or ((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) > NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) or (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost))) and NAG:AuraNumStacks(91342) >= 5 and NAG:Cast(63560, 10)

        or     (((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) or ((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost)))) and (NAG:DotRemainingTime(55078) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and NAG:Cast(55090, 10)
        or     ((not NAG:VariableRef("Festerblight")) and (((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) > NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or ((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) > NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or ((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) > NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or ((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) > NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost)) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood)) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) <= NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost))))) and NAG:Cast(55090, 10)
            or     NAG:Cast(85948, 10)
        ]],

    -- Tracked IDs for optimization
    spells = {33697, 43265, 45462, 45529, 47541, 47568, 48265, 49016, 49206, 53365, 55078, 55090, 55095, 57330, 63560, 77575, 81340, 85948, 114851, 114867, 115989, 123693, 126734, 138347, 138758},
    items = {76095},
    auras = {138759},  -- Feathers of Fury (trinket) for 10-stack cancel
    runes = {},

    -- Optional metadata
    glyphs = {43533, 43548, 104047, 43550, 45806, 43539},
    author = "Ketchupchips & Fonsas",

}


local bloodSTHeadrippa = {
        -- Core identification
        name = "Blood DPS w/comments",
        specIndex = 1,
        class = "DEATHKNIGHT",

        -- Required parameters
        default = true,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        rotationType = ns.ROTATION_TYPES.SINGLE_TARGET,
        enableSmartSwitching = false,

        -- Custom conditions for smart switching
        customConditions = {
            {
                type = ns.CUSTOM_CONDITION_TYPES.TARGET_COUNT,
                value = { min = 1, max = 3, operator = "range" },  -- Optimal for 1-3 targets
                range = 8  -- Use 8-yard range for precise target counting
            }
        },

        prePull = {
            { time = -31.0, action = "NAG:Cast(48263)" },
            { time = -30.0, action = "NAG:Cast(49222)" },
            { time = -7.0, action = "NAG:Cast(42650)" },
            { time = -1.5, action = "NAG:Cast(57330)" },
            { time = -1.0, action = "NAG:Cast(76095)" }
        },
        lastModified = "07/16/2025",
        rotationString = [[
(not NAG:AuraIsActive(49222)) and NAG:Cast(49222) -- Checks if Bone Shield (49222) is not active and casts it if available
or (NAG:CountEnemiesInRange(8) >= 4) and NAG:SelectRotation("Blood AOE w/comments") -- Switch to Blood AOE rotation if 4+ enemies within 8 yards
or (not NAG:AuraIsActive(48263)) and NAG:Cast(48263) -- Checks if Blood Presence (48263) is not active and casts it if available
or ((UnitHealth("player") / UnitHealthMax("player")) <= 0.4 and (NAG:CurrentRuneCount(2) >= 1 and NAG:CurrentRuneCount(3) >= 1 or NAG:CurrentRuneCount(4) >= 2) and NAG:SpellIsReady(49998)) and NAG:Cast(49998) -- If health ???40%, checks for Frost + Unholy Runes or 2 Death Runes and casts Death Strike (49998) if ready
or ((NAG:IsExecutePhase(35) or NAG:TimeToPercent(35) < 6) and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(114866)) and NAG:Cast(114866) -- Cast Soul Reaper (114866) in execute phase (<35% target health) or within 6 seconds of 35%
or (NAG:CurrentHealthPercent() > 0.5 and NAG:CurrentRuneCount(4) >= 1 and NAG:SpellIsReady(108196) and (function() local base, pos = select(1, UnitAttackPower("player")); local ap = (base and pos) and (base + pos) or 0; local wd = NAG:WeaponDamage() or 0; return (NAG:AuraIsActive(53386) and ap >= 7.07 * wd - 55147) or (not NAG:AuraIsActive(53386) and ap >= 10.1808 * wd - 79351.68) end)()) and NAG:Cast(108196) -- If health >50% and 1 Death Rune available, checks AP threshold scaled with weapon damage, considering Cinderglacier proc and casts Death Siphon (108196) if it's higher damage than Death Strike
    or ((NAG:DotRemainingTime(55095) <= 0 or NAG:DotRemainingTime(55078) <= 0) and NAG:SpellIsReady(77575)) and NAG:Cast(77575) -- If Frost Fever (55095) or Blood Plague (55078) is missing, casts Outbreak (77575) if ready
    or (NAG:AuraIsActive(81141) and not NAG:AuraIsActive(49028) and NAG:SpellIsReady(43265)) and NAG:Cast(43265) -- If Crimson Scourge (81141) proc is active and DRW (49028) is not, casts Death and Decay (43265) if ready
    or (NAG:AuraIsActive(53386) and NAG:CountEnemiesInRange(10) >= 2 and not NAG:AuraIsActive(49028) and not NAG:IsExecutePhase(35) and NAG:SpellTimeToReady(43265) <= 0) and NAG:Cast(43265) -- If Cinderglacier (53386) is active, 2+ enemies within 10 yards, DRW inactive, not in execute, and Death and Decay cooldown ???0, casts Death and Decay (43265)
    or (NAG:AuraIsActive(81141) and not NAG:AuraIsActive(49028) and NAG:SpellTimeToReady(43265) > 5 and NAG:DotRemainingTime(55095) > 0 and (function() local base, pos = select(1, UnitAttackPower("player")); local ap = (base and pos) and (base + pos) or 0; return ap >= NAG:Snapshot("ap", 55095) end)() and NAG:SpellIsReady(48721)) and NAG:Cast(48721) -- If Crimson Scourge proc active, DRW inactive, Death and Decay cooldown >5, Frost Fever active, AP snapshot met, and Blood Boil (48721) ready, casts Blood Boil (48721)
        or (NAG:AuraIsActive(49028) and (NAG:IsExecutePhase(35) or NAG:TimeToPercent(35) < 6) and NAG:SpellIsReady(114866)) and NAG:Cast(114866) -- If DRW (49028) active and target <35% health or will be within 6 seconds, casts Soul Reaper (114866)
        or (NAG:AuraIsActive(49028) and NAG:DotIsActive(55095) and not NAG:TargetHasDRWDebuff(55095) and NAG:SpellIsReady(77575)) and NAG:Cast(77575) -- If DRW active, Frost Fever active, but not mirrored by DRW, casts Outbreak (77575)
        or (NAG:AuraIsActive(81256) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) <=1)) and NAG:Cast(45529) -- If Dancing Rune Blade (81256) active and ???1 Death Rune, casts Blood Tap (45529) (rune conversion during DRW)
        or (NAG:AuraIsActive(49028) and NAG:CountEnemiesInRange(8) >= 2 and NAG:DotRemainingTime(55095) > 0 and NAG:DotRemainingTime(55078) > 0 and NAG:TargetHasDRWDebuff(55095) and NAG:TargetHasDRWDebuff(55078) and NAG:NumberTargetsWithDRWDebuff(55095, 8) < NAG:CountEnemiesInRange(8) and NAG:CurrentHealthPercent() > 0.4 and not NAG:IsExecutePhase(35) and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(50842)) and NAG:Cast(50842) -- If DRW active, diseases active and mirrored on target, but not all enemies have DRW diseases, health >40%, not in execute, and Blood Rune available, casts Pestilence (50842) (spread DRW diseases to multi-target)
        or (NAG:AuraIsActive(49028) and NAG:SpellIsReady(48707)) and NAG:Cast(48707) -- If DRW active, casts Anti-Magic Shell (48707) (Rune Power generation cooldown during DRW)
        or (NAG:AuraIsActive(49028) and NAG:CurrentHealthPercent() > 0.5 and NAG:CurrentRuneCount(4) >= 1 and NAG:SpellIsReady(108196) and (function() local base, pos = select(1, UnitAttackPower("player")); local ap = (base and pos) and (base + pos) or 0; local wd = NAG:WeaponDamage() or 0; return (NAG:AuraIsActive(53386) and ap >= 7.07 * wd - 55147) or (not NAG:AuraIsActive(53386) and ap >= 10.1808 * wd - 79351.68) end)()) and NAG:Cast(108196) -- If DRW active, health >50%, 1 Death Rune available, and AP threshold met, casts Death Siphon (108196) (DPS optimization during DRW).
            or (NAG:AuraIsActive(49028) and NAG:SpellIsReady(49998)) and NAG:Cast(49998) -- If DRW active, casts Death Strike (49998) (survival and damage during DRW)
            or (NAG:AuraIsActive(49028) and NAG:CurrentRunicPower() >= 30 and NAG:SpellIsReady(56815)) and NAG:Cast(56815) -- If DRW active and 30+ Runic Power, casts Rune Strike (56815) (RP dump during DRW)
            or (NAG:AuraIsActive(49028) and NAG:SpellIsReady(47568) and (NAG:CurrentRuneCount(2) == 0 and NAG:CurrentRuneCount(3) == 0 or NAG:CurrentRuneCount(4) == 0)) and NAG:Cast(47568) -- If DRW active and no Frost, Unholy, or Death Runes, casts Empower Rune Weapon (47568) (rune refresh during DRW)
            or (NAG:AuraIsActive(49028) and NAG:CountEnemiesInRange(10) >= 4 and NAG:CurrentHealthPercent() > 0.4 and NAG:DotRemainingTime(55095) > 0 and not NAG:IsExecutePhase(35) and NAG:SpellIsReady(48721) and (NAG:DotRemainingTime(55095) <= 4 or NAG:SnapshotPercent(55095, "ap") >= 0)) and NAG:Cast(48721) -- If DRW active, 4+ enemies within 10 yards, health >40%, Frost Fever active, not in execute, and disease refresh needed, casts Blood Boil (48721) (AOE damage during DRW)
            or ((select(2, UnitAttackPower("player")) >= (UnitLevel("player") < 60 and 0 or (200 + (UnitLevel("player") - 60) * 300)) or (UnitHealth("player") / UnitHealthMax("player")) < 0.65) and NAG:SpellTimeToReady(49028) <= 0) and NAG:Cast(49028) -- Cast Dancing Rune Weapon (49028) if attack power or health <65% conditions met
            or (NAG:AuraNumStacks(114851) >= 10 and NAG:CurrentRuneCount(1) == 0) and NAG:Cast(45529) -- Cast Blood Tap (45529) with 10+ charges and no Blood Runes
            or (NAG:IsExecutePhase(35) and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(114866)) and NAG:Cast(114866) -- Cast Soul Reaper (114866) in execute phase
            or (NAG:IsExecutePhase(35) and not NAG:SpellIsKnown(114866) and NAG:CurrentRunicPower() >= 30 and NAG:SpellIsReady(56815)) and NAG:Cast(56815) -- Cast Rune Strike (56815) in execute if Soul Reaper unknown with 30+ Runic Power
            or (NAG:IsExecutePhase(35) and not NAG:SpellIsKnown(114866) and NAG:CurrentRuneCount(4) >= 1 and NAG:SpellIsReady(49998)) and NAG:Cast(49998) -- Cast Death Strike (49998) in execute if Soul Reaper unknown with Death Rune
            or (NAG:IsExecutePhase(35) and not NAG:SpellIsKnown(114866) and NAG:CurrentRuneCount(1) >= 1 and NAG:CurrentHealthPercent() > 0.4 and NAG:CountEnemiesInRange(8) >= 2 and NAG:DotRemainingTime(55078) <= 4 and NAG:SpellIsReady(48721)) and NAG:Cast(48721) -- Cast Blood Boil (48721) in execute if Soul Reaper unknown, 2+ enemies, and Blood Plague (55078) needs refresh
            or (NAG:DotRemainingTime(55095) <= 4 and NAG:DotRemainingTime(55095) > 0 and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(48721) and not NAG:IsExecutePhase(35)) and NAG:Cast(48721) -- Cast Blood Boil (48721) to refresh Frost Fever (55095) if ???4 seconds remain, not in execute
            or (NAG:AuraIsActive(81141) and NAG:IsExecutePhase(35) and NAG:DotRemainingTime(55095) > 0 and NAG:DotRemainingTime(55095) < 5 and NAG:SpellIsReady(48721)) and NAG:Cast(48721) -- Cast Blood Boil (48721) in Execute phase if Crimson Scourge proc to refresh dots
            or (NAG:IsExecutePhase(35) and not NAG:SpellIsKnown(114866) and NAG:CountEnemiesInRange(8) <= 2 and NAG:CurrentRuneCount(1) >= 1 and NAG:CurrentRuneCount(2) == 0 and NAG:CurrentRuneCount(3) == 0 and NAG:CurrentRuneCount(4) == 0 and NAG:SpellIsReady(55050) and (NAG:DotRemainingTime(55095) >= 6 and NAG:SnapshotPercent(55095, "ap") < 0.05 or (NAG:SnapshotPercent(55095, "ap") >= 0.05 and NAG:SpellIsReady(48721)))) and (NAG:SnapshotPercent(55095, "ap") >= 0.05 and NAG:Cast(48721) or NAG:Cast(55050)) -- Cast Blood Boil (48721) or Heart Strike (55050) in execute if Soul Reaper unknown, ???2 enemies, and Frost Fever snapshot conditions met
            or (not NAG:AuraIsActive(49028) and NAG:CountEnemiesInRange(8) >= 2 and NAG:CountEnemiesInRange(8) <= 3 and NAG:DotRemainingTime(55095) > 0 and NAG:NumberTargetsWithDebuff(55095, 8) < NAG:CountEnemiesInRange(8) and NAG:CurrentHealthPercent() > 0.4 and not NAG:IsExecutePhase(35) and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(48721)) and NAG:Cast(48721) -- Cast Blood Boil (48721) to spread Frost Fever (55095) if 2-3 enemies, Frost Fever active, and not in execute
            or (NAG:CurrentRunicPower() >= 40 and NAG:SpellIsReady(47541) and (select(1, UnitAttackPower("player")) + select(2, UnitAttackPower("player")) >= 6.268 * NAG:WeaponDamage() - 4476.92)) and NAG:Cast(47541) -- Cast Death Coil (47541) with 40+ Runic Power if attack power threshold met
            or (NAG:CurrentRunicPower() >= 30 and NAG:SpellIsReady(56815)) and NAG:Cast(56815) -- Cast Rune Strike (56815) with 30+ Runic Power
            or (NAG:SpellIsReady(49998)) and NAG:Cast(49998) -- Cast Death Strike (49998) if ready
            or (NAG:CountEnemiesInRange(8) >= 4 and NAG:CurrentHealthPercent() > 0.4 and NAG:DotRemainingTime(55095) > 0 and not NAG:IsExecutePhase(35) and NAG:SpellIsReady(48721)) and NAG:Cast(48721) -- Cast Blood Boil (48721) if 4+ enemies, health >40%, Frost Fever active, and not in execute
            or (NAG:CurrentTime() <= 3.0 and NAG:SpellIsReady(49998)) and NAG:Cast(49998) -- Cast Death Strike (49998) in first 3 seconds of combat
            or (NAG:CurrentTime() <= 3.0 and not NAG:IsExecutePhase(35) and NAG:CountEnemiesInRange(8) <= 2 and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(55050) and (NAG:DotRemainingTime(55095) >= 6 and NAG:SnapshotPercent(55095, "ap") < 0.05 or (NAG:SnapshotPercent(55095, "ap") >= 0.05 and NAG:SpellIsReady(48721)))) and (NAG:SnapshotPercent(55095, "ap") >= 0.05 and NAG:Cast(48721) or NAG:Cast(55050)) -- Cast Blood Boil (48721) or Heart Strike (55050) in first 3 seconds, ???2 enemies, with Frost Fever snapshot conditions
            or (NAG:CurrentTime() <= 3.0 and NAG:IsExecutePhase(35) and NAG:CountEnemiesInRange(8) <= 2 and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(55050) and (NAG:DotRemainingTime(55095) >= 6 and NAG:SnapshotPercent(55095, "ap") < 0.35 or (NAG:SnapshotPercent(55095, "ap") >= 0.35 and NAG:SpellIsReady(48721)))) and (NAG:SnapshotPercent(55095, "ap") >= 0.35 and NAG:Cast(48721)) -- Cast Blood Boil (48721) in first 3 seconds, in execute, ???2 enemies, with Frost Fever snapshot conditions
            or (NAG:CountEnemiesInRange(8) >= 3 and not NAG:IsExecutePhase(35) and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(48721) and (NAG:DotRemainingTime(55095) <= 4 or NAG:SnapshotPercent(55095, "ap") >= 0)) and NAG:Cast(48721) -- Cast Blood Boil (48721) if 3+ enemies, not in execute, and Frost Fever needs refresh or snapshot met
            or (NAG:CountEnemiesInRange(8) >= 3 and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(55050) and not NAG:IsExecutePhase(35) and NAG:DotRemainingTime(55095) >= 6 and NAG:SnapshotPercent(55095, "ap") < 0) and NAG:Cast(55050) -- Cast Heart Strike (55050) if 3+ enemies, not in execute, with Frost Fever snapshot conditions
            or (NAG:CountEnemiesInRange(8) <= 2 and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(55050) and not NAG:IsExecutePhase(35) and (NAG:DotRemainingTime(55095) >= 6 and NAG:SnapshotPercent(55095, "ap") < 0.05 or (NAG:SnapshotPercent(55095, "ap") >= 0.05 and NAG:SpellIsReady(48721)))) and (NAG:SnapshotPercent(55095, "ap") >= 0.05 and NAG:Cast(48721) or NAG:Cast(55050)) -- Cast Blood Boil (48721) or Heart Strike (55050) if ???2 enemies, not in execute, with Frost Fever snapshot conditions
            or (NAG:IsExecutePhase(35) and NAG:CurrentRuneCount(1) >= 2 and NAG:SpellTimeToReady(114866) > 2 and NAG:SpellIsReady(55050)) and NAG:Cast(55050) -- Soul Reaper Parry Rune Refund Check to use Heath Strike(55050)
            or (not NAG:AuraIsActive(49028)) and NAG:Cast(57330) -- Cast Horn of Winter (57330) if DRW inactive
            or (NAG:CurrentRunicPower() >= 20 and not NAG:IsReadySpell(108196) and NAG:CurrentRunicPower() < 30 and NAG:Cast(56815, 10)) -- Cast Rune Strike (56815) with 20-29 Runic Power if Death Siphon unavailable
            or NAG:SpellIsKnown(108196) and ((NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy)) or (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy)) or (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftUnholy) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy)) or (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightUnholy) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy))) and (((NAG:AuraIsActive(49028) and NAG:CurrentHealthPercent() > 0.5 and (function() local base, pos = select(1, UnitAttackPower("player")); local ap = (base and pos) and (base + pos) or 0; local wd = NAG:WeaponDamage() or 0; return (NAG:AuraIsActive(53386) and ap >= 7.07 * wd - 55147) or (not NAG:AuraIsActive(53386) and ap >= 10.1808 * wd - 79351.68) end)())) or (NAG:CurrentHealthPercent() > 0.5 and (function() local base, pos = select(1, UnitAttackPower("player")); local ap = (base and pos) and (base + pos) or 0; local wd = NAG:WeaponDamage() or 0; return (NAG:AuraIsActive(53386) and ap >= 7.07 * wd - 55147) or (not NAG:AuraIsActive(53386) and ap >= 10.1808 * wd - 79351.68) end)())) and NAG:Cast(108196, 10) -- Look ahaid for Death Siphon
                    or NAG:Cast(49998, 10) -- Look Ahaid for Death Strike

        ]],


        -- Tracked IDs for optimization
        spells = {45529, 46584, 47568, 48721, 48743, 48792, 48982, 49222, 49998, 55050, 55078, 55095, 55233, 56815, 57330, 77535, 77575, 81141, 81256, 82176, 96171},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {104049, 104048, 43826, 104101, 43550, 43672},
        author = "@Headrippa",

    }


    local bloodAOEHeadrippa = {
        -- Core identification
        name = "Blood AOE w/comments",
        specIndex = 1,
        class = "DEATHKNIGHT",

        -- Required parameters
        default = false,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        rotationType = ns.ROTATION_TYPES.AOE,  -- Specifically designed for AOE
        enableSmartSwitching = false,

        -- Custom conditions for smart switching
            customConditions = {
                {
                    type = ns.CUSTOM_CONDITION_TYPES.TARGET_COUNT,
                    value = { value = 4, operator = "gte" },  -- Optimal for 4+ targets
                    range = 8  -- Use 8-yard range for precise AOE target counting
                }
            },

        prePull = {
            { time = -31.0, action = "NAG:Cast(48263)" },
            { time = -30.0, action = "NAG:Cast(49222)" },
            { time = -7.0, action = "NAG:Cast(42650)" },
            { time = -1.5, action = "NAG:Cast(57330)" },
            { time = -1.0, action = "NAG:Cast(76095)" }
        },
        lastModified = "07/16/2025",
        rotationString = [[
(not NAG:AuraIsActive(49222)) and NAG:Cast(49222) -- Apply Bone Shield (49222) if not active
or (NAG:CountEnemiesInRange(8) <= 3) and NAG:SelectRotation("Blood DPS w/comments") -- Switch to Blood DPS rotation if ???3 enemies within 8 yards (disabled for AOE focus)
or ((UnitHealth("player") / UnitHealthMax("player")) <= 0.4 and (NAG:CurrentRuneCount(2) >= 1 and NAG:CurrentRuneCount(3) >= 1 or NAG:CurrentRuneCount(4) >= 2) and NAG:SpellIsReady(49998)) and NAG:Cast(49998) -- If health ???40%, checks for Frost + Unholy Runes or 2 Death Runes and casts Death Strike (49998) if ready (survival priority to heal at low HP)
or (not NAG:AuraIsActive(48263)) and NAG:Cast(48263) -- Apply Blood Presence (48263) if not active (ensures tank presence)
or ((NAG:DotRemainingTime(55095) <= 0 or NAG:DotRemainingTime(55078) <= 0) and NAG:SpellIsReady(77575)) and NAG:Cast(77575) -- If Frost Fever (55095) or Blood Plague (55078) is missing, casts Outbreak (77575) if ready
or (NAG:AuraIsActive(81141) and not NAG:AuraIsActive(49028) and NAG:SpellIsReady(43265)) and NAG:Cast(43265) -- If Crimson Scourge (81141) proc is active and DRW (49028) is not, casts Death and Decay (43265) if ready (proc usage for AOE damage and threat)
or (NAG:AuraIsActive(53386) and NAG:CountEnemiesInRange(10) >= 3 and not NAG:AuraIsActive(49028) and not NAG:IsExecutePhase(35) and NAG:SpellTimeToReady(43265) <= 0) and NAG:Cast(43265) -- If Cinderglacier (53386) is active, 3+ enemies within 10 yards, DRW inactive, not in execute, and Death and Decay cooldown ???0, casts Death and Decay (43265) (proc synergy for multi-target damage outside execute)
or (NAG:AuraIsActive(81141) and not NAG:AuraIsActive(49028) and NAG:SpellTimeToReady(43265) > 5 and NAG:DotRemainingTime(55095) > 0 and (function() local base, pos = select(1, UnitAttackPower("player")); local ap = (base and pos) and (base + pos) or 0; return ap >= NAG:Snapshot("ap", 55095) end)() and not NAG:IsExecutePhase(35) and NAG:SpellIsReady(48721)) and NAG:Cast(48721) -- If Crimson Scourge proc active, DRW inactive, Death and Decay cooldown >5, Frost Fever active, AP snapshot met, not in execute, and Blood Boil (48721) ready, casts Blood Boil (48721) (fallback proc usage to refresh snapshot if AP is high for multi-dot damage)
    or (NAG:AuraIsActive(49028) and NAG:IsExecutePhase(35) and NAG:SpellIsReady(114866)) and NAG:Cast(114866) -- If DRW (49028) active and target <35% health, casts Soul Reaper (114866) (execute burst during DRW)
    or (NAG:AuraIsActive(49028) and NAG:DotIsActive(55095) and not NAG:TargetHasDRWDebuff(55095) and NAG:SpellIsReady(77575)) and NAG:Cast(77575) -- If DRW active, Frost Fever active, but not mirrored by DRW, casts Outbreak (77575) (disease mirroring for DRW)
    or (NAG:AuraIsActive(81256) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) <=1)) and NAG:Cast(45529) -- If Dancing Rune Blade (81256) active and ???1 Death Rune, casts Blood Tap (45529) (rune conversion during DRW)
    or (NAG:AuraIsActive(49028) and NAG:CountEnemiesInRange(8) >= 3 and NAG:DotRemainingTime(55095) > 0 and NAG:DotRemainingTime(55078) > 0 and NAG:TargetHasDRWDebuff(55095) and NAG:TargetHasDRWDebuff(55078) and NAG:NumberTargetsWithDRWDebuff(55095, 8) < NAG:CountEnemiesInRange(8) and NAG:CurrentHealthPercent() > 0.4 and not NAG:IsExecutePhase(35) and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(50842)) and NAG:Cast(50842) -- If DRW active, diseases active and mirrored on target, but not all enemies have DRW diseases, health >40%, not in execute, and Blood Rune available, casts Pestilence (50842) (spread DRW diseases to 3+ enemies)
    or (NAG:AuraIsActive(49028) and NAG:CountEnemiesInRange(10) >= 3 and NAG:CurrentHealthPercent() > 0.4 and NAG:DotRemainingTime(55095) > 0 and not NAG:IsExecutePhase(35) and NAG:SpellIsReady(48721) and (NAG:DotRemainingTime(55095) <= 4 or NAG:SnapshotPercent(55095, "ap") >= 0)) and NAG:Cast(48721) -- If DRW active, 3+ enemies within 10 yards, health >40%, Frost Fever active, not in execute, and disease refresh needed, casts Blood Boil (48721)
    or (NAG:AuraIsActive(49028) and NAG:SpellIsReady(48707)) and NAG:Cast(48707) -- If DRW active, casts Anti-Magic Shell (48707) rune power generation
    or (NAG:AuraIsActive(49028) and NAG:CurrentRuneCount(2) >= 1 and NAG:CurrentRuneCount(3) >= 1 and NAG:SpellIsReady(49998)) and NAG:Cast(49998) -- If DRW active, Frost + Unholy Runes available, casts Death Strike (49998)
    or (NAG:AuraIsActive(49028) and NAG:CurrentRunicPower() >= 30 and NAG:SpellIsReady(56815)) and NAG:Cast(56815) -- If DRW active and 30+ Runic Power, casts Rune Strike (56815) (RP dump during DRW)
    or (NAG:AuraIsActive(49028) and NAG:SpellIsReady(47568) and (NAG:CurrentRuneCount(2) == 0 and NAG:CurrentRuneCount(3) == 0 or NAG:CurrentRuneCount(4) == 0)) and NAG:Cast(47568) -- If DRW active and no Frost, Unholy, or Death Runes, casts Empower Rune Weapon (47568) (rune refresh during DRW)
    or ((select(2, UnitAttackPower("player")) >= (UnitLevel("player") < 60 and 0 or (200 + (UnitLevel("player") - 60) * 300)) or (UnitHealth("player") / UnitHealthMax("player")) < 0.65) and NAG:SpellTimeToReady(49028) <= 0) and NAG:Cast(49028) -- Cast Dancing Rune Weapon (49028) if attack power or health <65% conditions met
    or (NAG:AuraNumStacks(114851) >= 10 and NAG:CurrentRuneCount(1) == 0) and NAG:Cast(45529) -- Cast Blood Tap (45529) with 10+ charges and no Blood Runes
    or (NAG:IsExecutePhase(35) and NAG:AuraIsActive(53386) and NAG:SpellIsReady(114866)) and NAG:Cast(114866) -- Cast Soul Reaper (114866) in execute phase with Cinderglacier (53386) proc
    or (NAG:IsExecutePhase(35) and NAG:SpellIsReady(114866)) and NAG:Cast(114866) -- Cast Soul Reaper (114866) in execute phase
    or (NAG:IsExecutePhase(35) and not NAG:SpellIsKnown(114866) and NAG:CurrentRunicPower() >= 30 and NAG:SpellIsReady(56815)) and NAG:Cast(56815) -- Cast Rune Strike (56815) in execute if Soul Reaper unknown with 30+ Runic Power
    or (NAG:IsExecutePhase(35) and not NAG:SpellIsKnown(114866) and NAG:CurrentRuneCount(4) >= 1 and NAG:SpellIsReady(49998)) and NAG:Cast(49998) -- Cast Death Strike (49998) in execute if Soul Reaper unknown with Death Rune
    or (NAG:IsExecutePhase(35) and not NAG:SpellIsKnown(114866) and NAG:CurrentRuneCount(1) >= 1 and NAG:CurrentHealthPercent() > 0.4 and NAG:CountEnemiesInRange(8) >= 3 and NAG:DotRemainingTime(55078) <= 4 and NAG:SpellIsReady(48721)) and NAG:Cast(48721) -- Cast Blood Boil (48721) in execute if Soul Reaper unknown, 3+ enemies, and Blood Plague (55078) needs refresh
    or (NAG:CountEnemiesInRange(8) >= 3 and NAG:DotRemainingTime(55095) <= 4 and NAG:DotRemainingTime(55095) > 0 and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(48721) and not NAG:IsExecutePhase(35)) and NAG:Cast(48721) -- Cast Blood Boil (48721) if 3+ enemies, Frost Fever needs refresh, and not in execute
    or (NAG:CountEnemiesInRange(8) >= 4 and NAG:CurrentHealthPercent() > 0.4 and NAG:DotRemainingTime(55095) > 0 and not NAG:IsExecutePhase(35) and NAG:SpellIsReady(48721)) and NAG:Cast(48721) -- Cast Blood Boil (48721) if 4+ enemies, health >40%, Frost Fever active, and not in execute
    or (NAG:CountEnemiesInRange(8) >= 3 and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(48721) and not NAG:IsExecutePhase(35) and (NAG:DotRemainingTime(55095) <= 4 or NAG:SnapshotPercent(55095, "ap") >= 0)) and NAG:Cast(48721) -- Cast Blood Boil (48721) if 3+ enemies, not in execute, and Frost Fever needs refresh or snapshot met
    or (NAG:CountEnemiesInRange(8) >= 3 and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(55050) and not NAG:IsExecutePhase(35) and NAG:DotRemainingTime(55095) >= 6 and NAG:SnapshotPercent(55095, "ap") < 0) and NAG:Cast(55050) -- Cast Heart Strike (55050) if 3+ enemies, not in execute, with Frost Fever snapshot conditions
    or (NAG:CountEnemiesInRange(8) >= 3 and (NAG:CurrentRuneCount(2) >= 1 and NAG:CurrentRuneCount(3) >= 1 or NAG:CurrentRuneCount(4) >= 1) and NAG:SpellIsReady(49998) and NAG:CurrentRuneCount(1) == 0 and not NAG:IsExecutePhase(35)) and NAG:Cast(49998) -- If 3+ enemies, Frost + Unholy or 1 Death Rune available, no Blood Rune, not in execute, casts Death Strike (49998) (survival in AOE without Blood Runes)
    or (NAG:CountEnemiesInRange(8) >= 3 and (NAG:CurrentRunicPower() >= 100 or (NAG:CurrentRuneCount(1) == 0 and NAG:CurrentRuneCount(4) == 0)) and NAG:SpellIsReady(56815) and not NAG:IsExecutePhase(35)) and NAG:Cast(56815) -- If 3+ enemies, 100+ Runic Power or no Blood/Death Runes, not in execute, casts Rune Strike (56815) (RP dump in AOE)
    or (not NAG:AuraIsActive(49028)) and NAG:Cast(57330) -- Cast Horn of Winter (57330) if DRW inactive
    or (NAG:CurrentRunicPower() >= 20 and not NAG:IsReadySpell(108196) and NAG:CurrentRunicPower() < 30 and NAG:Cast(56815, 10)) -- Cast Rune Strike (56815) with 20-29 Runic Power if Death Siphon unavailable
    or (((((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy))))) and NAG:Cast(48721, 10)) -- Cast Blood Boil (48721) with specific Blood Rune cooldown logic for optimal timing
    or NAG:Cast(49998, 10) -- Cast Death Strike (49998) as fallback
        ]],


        -- Tracked IDs for optimization
        spells = {45529, 46584, 47568, 48721, 48743, 48792, 48982, 49222, 49998, 55050, 55078, 55095, 55233, 56815, 57330, 77535, 77575, 81141, 81256, 82176, 96171},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {104049, 104048, 43826, 104101, 43550, 43672},
        author = "@Headrippa",

    }



    local bloodSTONLYHeadrippa = {
        -- Core identification
        name = "Blood Single Target",
        specIndex = 1,
        class = "DEATHKNIGHT",

        -- Required parameters
        default = false,
        enabled = true,
        experimental = false,
        gameType = Version.GAME_TYPES.CLASSIC_MISTS,
        rotationType = ns.ROTATION_TYPES.AOE,  -- Specifically designed for AOE

        -- Custom conditions for smart switching
 --[[           customConditions = {
                {
                    type = ns.CUSTOM_CONDITION_TYPES.TARGET_COUNT,
                    value = { value = 1, operator = "eq" },  -- Optimal for 4+ targets
                    range = 8  -- Use 8-yard range for precise AOE target counting
                }
            },]]

        prePull = {
            { time = -31.0, action = "NAG:Cast(48263)" },
            { time = -30.0, action = "NAG:Cast(49222)" },
            { time = -7.0, action = "NAG:Cast(42650)" },
            { time = -1.5, action = "NAG:Cast(57330)" },
            { time = -1.0, action = "NAG:Cast(76095)" }
        },
        lastModified = "10/16/2025",
        rotationString = [[
(not NAG:AuraIsActive(49222)) and NAG:Cast(49222) -- Apply Bone Shield if not active
or (not NAG:AuraIsActive(48263)) and NAG:Cast(48263) -- Apply Blood Presence if not active
or ((UnitHealth("player") / UnitHealthMax("player")) <= 0.4 and (NAG:CurrentRuneCount(2) >= 1 and NAG:CurrentRuneCount(3) >= 1 or NAG:CurrentRuneCount(4) >= 2) and NAG:SpellIsReady(49998)) and NAG:Cast(49998) -- Cast Death Strike (49998) at ???40% health
or ((NAG:IsExecutePhase(35) or NAG:TimeToPercent(35) < 6) and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(114866)) and NAG:Cast(114866) -- Cast Soul Reaper (114866) in execute phase (<35% target health) or within 6 seconds of 35%
or (NAG:CurrentHealthPercent() > 0.5 and NAG:CurrentRuneCount(4) >= 1 and NAG:SpellIsReady(108196) and (function() local base, pos = select(1, UnitAttackPower("player")); local ap = (base and pos) and (base + pos) or 0; local wd = NAG:WeaponDamage() or 0; return (NAG:AuraIsActive(53386) and ap >= 7.07 * wd - 55147) or (not NAG:AuraIsActive(53386) and ap >= 10.1808 * wd - 79351.68) end)()) and NAG:Cast(108196) -- Cast Death Siphon (108196) with Death Rune if health >50% and attack power threshold met
    or ((NAG:DotRemainingTime(55095) <= 0 or NAG:DotRemainingTime(55078) <= 0) and NAG:SpellIsReady(77575)) and NAG:Cast(77575) -- Cast Outbreak (77575) if Frost Fever (55095) or Blood Plague (55078) is missing
    or (NAG:AuraIsActive(81141) and not NAG:AuraIsActive(49028) and NAG:DotRemainingTime(55095) > 5 and NAG:SpellIsReady(43265)) and NAG:Cast(43265) -- Cast Death and Decay (43265) with Crimson Scourge (81141) proc if Dancing Rune Weapon (49028) is inactive
    or (NAG:AuraIsActive(81141) and not NAG:AuraIsActive(49028) and NAG:SpellTimeToReady(43265) > 5 and NAG:DotRemainingTime(55095) > 0 and (function() local base, pos = select(1, UnitAttackPower("player")); local ap = (base and pos) and (base + pos) or 0; return ap >= NAG:Snapshot("ap", 55095) end)() and NAG:SpellIsReady(48721)) and NAG:Cast(48721) -- Cast Blood Boil (48721) with Crimson Scourge proc if Death and Decay on cooldown, Frost Fever active, and attack power snapshot met
        or (NAG:AuraIsActive(49028) and (NAG:IsExecutePhase(35) or NAG:TimeToPercent(35) < 6) and NAG:SpellIsReady(114866)) and NAG:Cast(114866) -- Cast Soul Reaper (114866) during DRW in execute phase
        or (NAG:AuraIsActive(49028) and NAG:DotIsActive(55095) and not NAG:TargetHasDRWDebuff(55095) and NAG:SpellIsReady(77575)) and NAG:Cast(77575) -- Cast Outbreak (77575) during DRW if Frost Fever (55095) not mirrored by DRW
        or (NAG:AuraIsActive(81256) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) <=1)) and NAG:Cast(45529) -- Cast Blood Tap (45529) during DRW if ???1 Death Rune
        or (NAG:AuraIsActive(49028) and NAG:SpellIsReady(48707)) and NAG:Cast(48707) -- Cast Anti-Magic Shell (48707) during DRW
        or (NAG:AuraIsActive(49028) and NAG:CurrentHealthPercent() > 0.5 and NAG:CurrentRuneCount(4) >= 1 and NAG:SpellIsReady(108196) and (function() local base, pos = select(1, UnitAttackPower("player")); local ap = (base and pos) and (base + pos) or 0; local wd = NAG:WeaponDamage() or 0; return (NAG:AuraIsActive(53386) and ap >= 7.07 * wd - 55147) or (not NAG:AuraIsActive(53386) and ap >= 10.1808 * wd - 79351.68) end)()) and NAG:Cast(108196) -- Cast Death Siphon (108196) during DRW with Death Rune if health >50% and attack power threshold met
            or (NAG:AuraIsActive(49028) and NAG:SpellIsReady(49998)) and NAG:Cast(49998) -- Cast Death Strike (49998) during DRW
            or (NAG:AuraIsActive(49028) and NAG:CurrentRunicPower() >= 30 and NAG:SpellIsReady(56815)) and NAG:Cast(56815) -- Cast Rune Strike (56815) during DRW with 30+ Runic Power
            or (NAG:AuraIsActive(49028) and NAG:SpellIsReady(47568) and (NAG:CurrentRuneCount(2) == 0 and NAG:CurrentRuneCount(3) == 0 or NAG:CurrentRuneCount(4) == 0)) and NAG:Cast(47568) -- Cast Empower Rune Weapon (47568) during DRW if no Frost, Unholy, or Death Runes
            or ((select(2, UnitAttackPower("player")) >= (UnitLevel("player") < 60 and 0 or (200 + (UnitLevel("player") - 60) * 300)) or (UnitHealth("player") / UnitHealthMax("player")) < 0.65) and NAG:SpellTimeToReady(49028) <= 0) and NAG:Cast(49028) -- Cast Dancing Rune Weapon (49028) if attack power or health <65% conditions met
            or (NAG:AuraNumStacks(114851) >= 10 and NAG:CurrentRuneCount(1) == 0) and NAG:Cast(45529) -- Cast Blood Tap (45529) with 10+ charges and no Blood Runes
            or (NAG:IsExecutePhase(35) and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(114866)) and NAG:Cast(114866) -- Cast Soul Reaper (114866) in execute phase
            or (NAG:DotRemainingTime(55095) <= 4 and NAG:DotRemainingTime(55095) > 0 and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(48721) and not NAG:IsExecutePhase(35)) and NAG:Cast(48721) -- Cast Blood Boil (48721) to refresh Frost Fever (55095) if ???4 seconds remain, not in execute
            or (NAG:DotRemainingTime(55095) <= 4 and NAG:DotRemainingTime(55095) > 0 and NAG:CurrentRuneCount(1) >= 2 and NAG:SpellIsReady(48721) and NAG:IsExecutePhase(35)) and NAG:Cast(48721) -- Cast Blood Boil (48721) to refresh Frost Fever (55095) if ???4 seconds remain, in execute with 2 blood runes available
            or (NAG:AuraIsActive(81141) and NAG:IsExecutePhase(35) and NAG:DotRemainingTime(55095) > 0 and NAG:DotRemainingTime(55095) < 4 and NAG:SpellIsReady(48721)) and NAG:Cast(48721) -- Cast Blood Boil (48721) in Execute phase if Crimson Scourge proc to refresh dots
            or (NAG:CurrentRunicPower() >= 40 and NAG:SpellIsReady(47541) and (select(1, UnitAttackPower("player")) + select(2, UnitAttackPower("player")) >= 6.268 * NAG:WeaponDamage() - 4476.92)) and NAG:Cast(47541) -- Cast Death Coil (47541) with 40+ Runic Power if attack power threshold met
            or (NAG:CurrentRunicPower() >= 30 and NAG:SpellIsReady(56815)) and NAG:Cast(56815) -- Cast Rune Strike (56815) with 30+ Runic Power
            or (NAG:SpellIsReady(49998)) and NAG:Cast(49998) -- Cast Death Strike (49998) if ready
            or (NAG:CurrentTime() <= 3.0 and NAG:SpellIsReady(49998)) and NAG:Cast(49998) -- Cast Death Strike (49998) in first 3 seconds of combat
            or (NAG:CurrentTime() <= 3.0 and not NAG:IsExecutePhase(35) and NAG:CountEnemiesInRange(8) <= 2 and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(55050) and (NAG:DotRemainingTime(55095) >= 6 and NAG:SnapshotPercent(55095, "ap") < 0.05 or (NAG:SnapshotPercent(55095, "ap") >= 0.05 and NAG:SpellIsReady(48721)))) and (NAG:SnapshotPercent(55095, "ap") >= 0.05 and NAG:Cast(48721) or NAG:Cast(55050)) -- Cast Blood Boil (48721) or Heart Strike (55050) in first 3 seconds, ???2 enemies, with Frost Fever snapshot conditions
            or (NAG:CurrentHealthPercent() > 0.5 and NAG:CurrentRuneCount(1) >= 1 and NAG:DotRemainingTime(55095) > 0 and not NAG:IsExecutePhase(35) and NAG:SpellIsReady(48721) and (NAG:DotRemainingTime(55095) <= 4 or NAG:SnapshotPercent(55095, "ap") >= 0.1)) and NAG:Cast(48721) -- Casts Blood Boil outside of crimson scourge proc to increase AP snapshot of diseases outside of Execute Range.
            or (NAG:CurrentHealthPercent() > 0.5 and NAG:CurrentRuneCount(1) >= 1 and NAG:DotRemainingTime(55095) > 0 and NAG:IsExecutePhase(35) and NAG:TimeToPercent(1) < 10 and NAG:SpellIsReady(48721) and (NAG:DotRemainingTime(55095) <= 4 or NAG:SnapshotPercent(55095, "ap") >= 0.1)) and NAG:Cast(48721) -- Casts Blood Boil to maintain disease uptime if in execute phase.
            or (NAG:CurrentHealthPercent() > 0.2 and NAG:CurrentRuneCount(1) >= 1 and NAG:DotRemainingTime(55095) > 6 and not NAG:IsExecutePhase(35) and NAG:SpellIsReady(55050) and NAG:SnapshotPercent(55095, "ap") <= 0.1) and NAG:Cast(55050) -- Cast Heart Strike
            or (NAG:IsExecutePhase(35) and NAG:CurrentRuneCount(1) >= 2 and NAG:SpellTimeToReady(114866) > 2 and NAG:SpellIsReady(55050)) and NAG:Cast(55050) -- Soul Reaper Parry Rune Refund Check to use Heath Strike(55050)
            or (not NAG:AuraIsActive(49028)) and NAG:Cast(57330) -- Cast Horn of Winter (57330) if DRW inactive
            or (NAG:CurrentRunicPower() >= 20 and not NAG:IsReadySpell(108196) and NAG:CurrentRunicPower() < 30 and NAG:Cast(56815, 10)) -- Cast Rune Strike (56815) with 20-29 Runic Power if Death Siphon unavailable
            or NAG:SpellIsKnown(108196) and ((NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy)) or (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy)) or (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftUnholy) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy)) or (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightUnholy) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy))) and (((NAG:AuraIsActive(49028) and NAG:CurrentHealthPercent() > 0.5 and (function() local base, pos = select(1, UnitAttackPower("player")); local ap = (base and pos) and (base + pos) or 0; local wd = NAG:WeaponDamage() or 0; return (NAG:AuraIsActive(53386) and ap >= 7.07 * wd - 55147) or (not NAG:AuraIsActive(53386) and ap >= 10.1808 * wd - 79351.68) end)())) or (NAG:CurrentHealthPercent() > 0.5 and (function() local base, pos = select(1, UnitAttackPower("player")); local ap = (base and pos) and (base + pos) or 0; local wd = NAG:WeaponDamage() or 0; return (NAG:AuraIsActive(53386) and ap >= 7.07 * wd - 55147) or (not NAG:AuraIsActive(53386) and ap >= 10.1808 * wd - 79351.68) end)())) and NAG:Cast(108196, 10) -- Cast Death Siphon (108196) with specific Death Rune slot if health >50% and attack power threshold met
                    or NAG:Cast(49998, 10) -- Cast Death Strike (49998) as fallback
        ]],


        -- Tracked IDs for optimization
        spells = {45529, 46584, 47568, 48721, 48743, 48792, 48982, 49222, 49998, 55050, 55078, 55095, 55233, 56815, 57330, 77535, 77575, 81141, 81256, 82176, 96171},
        items = {},
        auras = {},
        runes = {},

        -- Optional metadata
        glyphs = {104049, 104048, 43826, 104101, 43550, 43672},
        author = "@Headrippa",

    }

-- DeathKnight Frost Rotation
local frostMasterfrogRotationUPDATED = {
    name = "Masterfrog by Darkfrog UPDATED",
    class = "DeathKnight",
    specIndex = 2,
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { time = -30.0, action = "NAG:Cast(57330)" },
            { time = -15.0, action = "NAG:Cast(48266)" },
            { time = -7.0, action = "NAG:Cast(46584)" },
            { time = -6.0, action = "NAG:Cast(42650)" },
            { time = -1.0, action = "NAG:Cast(76095)" }
    },
    rotationString = [[
    (not NAG:AuraIsActive(48266, "player", false)) and NAG:Cast(48266)
    or (NAG:AuraIsInactive(19506, "player", false) and NAG:AuraIsInactive(57330, "player", false) and NAG:AuraIsInactive(6673, "player", false)) and NAG:CastSpell(57330)
    or NAG:CastSpell(51271)
    or NAG:AutocastOtherCooldowns()
    or (NAG:AuraIsActive(51271, "player", false) or NAG:AuraIsKnown(145959)) and NAG:CastSpell(126734)
    or (NAG:AuraIsActive(51271, "player", false) or NAG:AuraIsKnown(145959)) and NAG:CastSpell(26297)
    or (NAG:AuraIsActive(51271, "player", false) or NAG:AuraIsKnown(145959)) and NAG:CastSpell(33697)
    or (NAG:AuraIsActive(51271, "player", false) or NAG:AuraIsKnown(145959)) and NAG:CastSpell(121279)
    or (((NAG:SpellTimeToReady(51271) <= 5) or NAG:AuraIsActive(51271, "player", false) or (NAG:RemainingTime() <= 65) or NAG:AuraIsKnown(145959)) and (NAG:RemainingTime() > 10)) and NAG:CastSpell(46584)
    or (((NAG:SpellTimeToReady(51271) <= 5) or NAG:AuraIsActive(51271, "player", false) or (NAG:RemainingTime() <= 65) or NAG:AuraIsKnown(145959)) and (NAG:RemainingTime() > 10) and NAG:VariableRef("No Strength Proc Any")) and NAG:CastSpell(42650)
    or ((NAG:RemainingTime() <= 30.0) or ((NAG:RemainingTime() <= 60.0) and (NAG:SpellTimeToReady(51271) <= 4))) and NAG:CastSpell(76095)
    or (NAG:CurrentTime() == 0) and NAG:CastSpell(77575)
    or ((NAG:UnitDistance() > 1) and NAG:Cast(49184))
    or ((NAG:AuraNumStacks(114851, "player") > 10) or (NAG:RemainingTime() < 5) or (NAG:SpellIsReady(51271) and NAG:VariableRef("No Frost/Death"))) and NAG:CastSpell(45529)
    or (NAG:VariableRef("Soul Reaper 45") or NAG:VariableRef("Soul Reaper 35")) and NAG:CastSpell(114867)
    or (NAG:SpellIsReady(114867) and NAG:VariableRef("No Frost/Death") and (NAG:VariableRef("Soul Reaper 45") or NAG:VariableRef("Soul Reaper 35"))) and NAG:CastSpell(45529)
    or ((NAG:AuraIsActive(51124, "player", true) and NAG:AuraIsActive(59052, "player", true)) or (NAG:CurrentRunicPower() > 88)) and NAG:CastSpell(49143)
    or ((NAG:NumberTargets() == 1) and NAG:VariableRef("Plagues") and ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) == 2) or (NAG:AuraIsActive(51124, "player", true) and (NAG:CurrentRunicPower() < 76) and NAG:AuraIsActive(2825, "player", true) and NAG:VariableRef("No Strength Proc Any")))) and NAG:CastSpell(49020)
    or NAG:AuraIsActive(51124, "player", true) and NAG:CastSpell(49143)
    or ((NAG:NumberTargets() == 1) and NAG:AuraIsActive(51124, "player", true) and (NAG:CurrentRunicPower() < 76) and NAG:VariableRef("Plagues") and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) > 0)) and NAG:CastSpell(49020)
    or ((NAG:NumberTargets() == 1) and NAG:AuraIsActive(51124, "player", true) and (NAG:CurrentRunicPower() < 76) and NAG:VariableRef("Plagues") and ((NAG:VariableRef("No Frost/Death") and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) == 1)))) and NAG:CastSpell(45529)
    or (NAG:VariableRef("Plagues") and NAG:VariableRef("Plague Leech") and NAG:VariableRef("Plagues Expiring")) and NAG:CastSpell(123693)
    or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) > 1) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) > 1)) and NAG:CastSpell(49184)
    or ((NAG:AuraIsActive(51271, "player", false) or (NAG:AnyTrinketStatProcsActive(1, -1, -1) and (NAG:SpellTimeToReady(51271) >= 15))) and NAG:VariableRef("No Frost/Death")) and NAG:CastSpell(45529)
    or NAG:VariableRef("Plagues Expiring") and NAG:CastSpell(115989)
    or (not NAG:DotIsActive(55095)) and NAG:CastSpell(49184)
    or ((not NAG:DotIsActive(55078)) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) > 0)) and NAG:CastSpell(45462)
    or ((not NAG:DotIsActive(55078)) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy) > 1)) and NAG:CastSpell(77575)
    or NAG:AuraIsActive(59052, "player", true) and NAG:CastSpell(49184)
    or ((NAG:NumberTargets() > 1) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) > 0)) and NAG:CastSpell(43265)
    or ((NAG:NumberTargets() == 1) and (NAG:CurrentRunicPower() > 76) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) > 0)) and NAG:CastSpell(49143)
    or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) > 0) and NAG:VariableRef("Plagues") and (NAG:CurrentRunicPower() < 77)) and NAG:CastSpell(49020)
    or (NAG:AuraIsKnown(81229) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1) and ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0))) and NAG:CastSpell(49143)
    or NAG:CastSpell(49184)
    or ((NAG:AuraIsActive(51271, "player", false) or (NAG:NumberTargets() > 2)) and NAG:VariableRef("No Frost/Death")) and NAG:CastSpell(45529)
    or (NAG:CurrentRunicPower() <= 81) and NAG:CastSpell(50613)
    or ((((not NAG:AuraIsKnown(146646)) and (NAG:CurrentRunicPower() <= 87) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0)) or (NAG:AuraIsInactive(51271, "player", true) and NAG:AuraIsInactive(53365, "player", true))) and (NAG:AuraIsKnown(146646) and (NAG:CurrentRunicPower() <= 75))) and NAG:CastSpell(57330)
    or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and ((NAG:AuraIsKnown(145959) and (NAG:CurrentRunicPower() <= 70)) or ((not NAG:AuraIsKnown(145959)) and (NAG:CurrentRunicPower() < 20)))) and NAG:CastSpell(47568)
    or (NAG:VariableRef("Plague Leech") and (NAG:CurrentTime() >= 20)) and NAG:CastSpell(123693)
    or (NAG:CurrentRunicPower() >= 20) and NAG:CastSpell(49143)
    or (NAG:CurrentRunicPower() < 20) and NAG:CastSpell(57330)
    or NAG:CastSpell(43265)
    or (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) < 5) and (NAG:DotRemainingTime(55078) < 5) and NAG:Cast(45426, 10)
    or (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) > 0) and NAG:DotIsActive(55078) and NAG:DotIsActive(55095) and NAG:Cast(49020, 10)
    or NAG:Cast(49184, 10)
    ]],

    -- Tracked IDs for optimization
    spells = {2825, 6673, 19506, 26297, 33697, 42650, 43265, 45462, 45529, 46584, 47568, 49020, 49143, 49184, 50613, 51124, 51271, 53365, 55078, 55095, 57330, 59052, 77575, 81229, 114851, 114867, 115989, 121279, 123693, 126734, 138347, 145959, 146646},
    items = {76095},
    auras = {},
    runes = {},
    glyphs = {major, minor},
    consumables = { prepotId = 76095, potId = 76095, flaskId = 76088, foodId = 74646 },

    -- Groups and Variables from WoWSims APL
    groups = {},
    variables = {
        {
            name = [[Plague Leech]],
            value = [[(((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0)))]]
        },
        {
            name = [[Soul Reaper 45]],
            value = [[((NAG:NumberTargets() <= 4) and NAG:AuraIsKnown(138347) and (NAG:IsExecutePhase(45) or (NAG:TimeToPercent(45)  < 6)) and (NAG:RemainingTime() > 5) and (NAG:CurrentRunicPower() <= 88))]]
        },
        {
            name = [[Soul Reaper 35]],
            value = [[((NAG:NumberTargets() <= 3) and (not NAG:AuraIsKnown(138347)) and (NAG:IsExecutePhase(35) or (NAG:TimeToPercent(35)  < 6)) and (NAG:RemainingTime() > 5) and (NAG:CurrentRunicPower() <= 88))]]
        },
        {
            name = [[No Frost/Death]],
            value = [[((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0))]]
        },
        {
            name = [[Plagues]],
            value = [[(NAG:DotIsActive(55078) and NAG:DotIsActive(55095))]]
        },
        {
            name = [[No Strength Proc All]],
            value = [[((not NAG:AuraIsActive(53365, "player", true)) and (not NAG:AuraIsActive(51271, "player", true)) and (not NAG:AuraIsActive(76095, "player", true)) and (not NAG:AnyTrinketStatProcsActive(1, -1, -1)))]]
        },
        {
            name = [[No Strength Proc Any]],
            value = [[((not NAG:AuraIsActive(53365, "player", true)) or (not NAG:AuraIsActive(51271, "player", true)) or (not NAG:AuraIsActive(76095, "player", true)) or (not NAG:AnyTrinketStatProcsActive(1, -1, -1)))]]
        },
        {
            name = [[Plagues Expiring]],
            value = [[((NAG:DotRemainingTime(55078) < 3) or (NAG:DotRemainingTime(55095) < 3))]]
        }
        },

    -- Optional metadata
    talentsString = "221111",
    lastModified = "02/03/2026",
    author = "Darkfrog"
}



local frostMasterfrogDarkfrog = {
    -- Core identification
    name = "Masterfrog ST",
    specIndex = 2,
    class = "DEATHKNIGHT",

    -- Required parameters
    default = false,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    rotationType = ns.ROTATION_TYPES.AOE,  -- Handles both ST and AOE
    enableSmartSwitching = true,

    -- Custom conditions for smart switching
    customConditions = {
        {
            type = ns.CUSTOM_CONDITION_TYPES.WEAPON_TYPE,
            value = "dualWield"  -- This rotation is for dual-wield setups
        },
        {
            type = ns.CUSTOM_CONDITION_TYPES.TARGET_COUNT,
            value = { value = 2, operator = "lte" },  -- Trigger when 2 targets or fewer
            range = 8  -- Use 8-yard range for precise AOE target counting
        }
    },

    prePull = {
        { time = -7.0, action = "NAG:Cast(46584)" },
        { time = -6.0, action = "NAG:Cast(42650)" },
        { time = -1.0, action = "NAG:Cast(76095)" },
        { time = -1.0, action = "NAG:Cast(51271)" }
    },
    lastModified = "07/04/2025",
    rotationString = [[
            (not NAG:AuraIsActive(48266, "player", false)) and NAG:Cast(48266)
    or ((not NAG:AuraIsActive(19506, "player", false)) and (not NAG:AuraIsActive(6673, "player", false)) and (not NAG:AuraIsActive(57330, "player", false))) and NAG:Cast(57330)
    or NAG:Cast(51271)
    or NAG:Cast(33697)
    or NAG:Cast(26297)
    or NAG:AutocastOtherCooldowns()
    or NAG:Cast(126734)
    or (((NAG:SpellTimeToReady(51271) <= 5) or NAG:AuraIsActive(51271, "player", false) or (NAG:RemainingTime() <= 65)) and (NAG:RemainingTime() > 10)) and NAG:Cast(46584)
    or ((NAG:UnitDistance() > 1) and (not NAG:DotIsActive(55078))) and NAG:Cast(77575)
    or (NAG:UnitDistance() > 1) and (NAG:UnitDistance() <= 40) and NAG:Cast(49184, nil, NAG.SPELL_POSITIONS.AOE)
    or ((NAG:RemainingTime() <= 30.0) or ((NAG:RemainingTime() <= 60.0) and (NAG:AuraIsActive(51271, "player", false) or (NAG:SpellTimeToReady(51271) <= 4)))) and NAG:Cast(76095)
    or ((NAG:AuraNumStacks(114851, "player", false) > 10) or (NAG:RemainingTime() < 5)) and NAG:Cast(45529)
    or (NAG:SpellIsReady(51271) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0)) and NAG:Cast(45529)
    or (NAG:AuraIsKnown(138347) and (NAG:IsExecutePhase(45) or (NAG:TimeToPercent(45)  < 6)) and (NAG:NumberTargets() <= 3) and (NAG:RemainingTime() > 5)) and NAG:Cast(114867)
    or ((NAG:IsExecutePhase(35) or (NAG:AuraIsKnown(138347) and (NAG:NumberTargets() <= 4) and (NAG:IsExecutePhase(45) or (NAG:TimeToPercent(45)  < 6)))) and (NAG:NumberTargets() <= 3) and (NAG:RemainingTime() > 5) and (NAG:TimeToPercent(35)  < 6)) and NAG:Cast(114867)
    or (NAG:SpellIsReady(114867) and (NAG:IsExecutePhase(35) or (NAG:AuraIsKnown(138347) and (NAG:NumberTargets() <= 4) and (NAG:IsExecutePhase(45) or (NAG:TimeToPercent(45)  < 6))) or (NAG:TimeToPercent(35)  < 6)) and (NAG:NumberTargets() <= 3) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:RemainingTime() > 5)) and NAG:Cast(45529)
    or ((NAG:AuraIsActive(51124, "player", false) and NAG:AuraIsActive(59052, "player", false)) or (NAG:CurrentRunicPower() > 88)) and NAG:Cast(49143)
    or (NAG:AuraIsActive(51124, "player", false) and (NAG:CurrentRunicPower() < 76) and NAG:DotIsActive(55078) and NAG:DotIsActive(55095) and (NAG:NumberTargets() == 1) and NAG:AuraIsActive(2825, "player", false)) and NAG:Cast(49020)
    or (NAG:AuraIsActive(51124, "player", false) and (NAG:CurrentRunicPower() >= 20)) and NAG:Cast(49143)
    or (NAG:AuraIsActive(51124, "player", false) and (NAG:CurrentRunicPower() < 76) and NAG:DotIsActive(55078) and NAG:DotIsActive(55095) and (NAG:NumberTargets() == 1) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) > 0)) and NAG:Cast(49020)
    or (NAG:AuraIsActive(51124, "player", false) and (NAG:CurrentRunicPower() < 76) and NAG:DotIsActive(55078) and NAG:DotIsActive(55095) and (((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) == 1))) and (NAG:NumberTargets() == 1)) and NAG:Cast(45529)
    or (((NAG:DotRemainingTime(55078) < 3) or (NAG:DotRemainingTime(55095) < 3)) and NAG:DotIsActive(55078) and NAG:DotIsActive(55095) and (((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost))) or ((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightUnholy))) or ((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightUnholy))))) and NAG:Cast(123693)
    or ((NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) or (NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost))) and NAG:Cast(49184)
    or ((NAG:AuraIsActive(51271, "player", false) or (NAG:AnyTrinketStatProcsActive(1, -1, -1, 54) and (NAG:SpellTimeToReady(51271) > 15))) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0)) and NAG:Cast(45529)
    or ((NAG:DotRemainingTime(55078) < 3.0) or (NAG:DotRemainingTime(55095) < 3.0)) and NAG:Cast(115989)
    or (not NAG:DotIsActive(55095)) and NAG:Cast(49184)
    or ((not NAG:DotIsActive(55078)) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) > 0)) and NAG:Cast(45462)
    or ((not NAG:DotIsActive(55078)) and (NAG:NumberTargets() >= 5) and (NAG:RemainingTime() >= (NAG:DotRemainingTime(55078) + 30))) and NAG:Cast(50842)
    or ((not NAG:DotIsActive(55078))) and NAG:Cast(77575)
    or NAG:AuraIsActive(59052, "player", false) and NAG:Cast(49184)
    or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) > 0) and (NAG:NumberTargets() > 1)) and NAG:Cast(43265)
    or ((NAG:CurrentRunicPower() > 76) and (NAG:NumberTargets() == 1)) and NAG:Cast(49143)
    or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) > 0) and NAG:DotIsActive(55078) and NAG:DotIsActive(55095) and (NAG:CurrentRunicPower() < 77)) and NAG:Cast(49020)
    or NAG:Cast(49184)
    or ((NAG:AuraIsActive(51271, "player", false) or (NAG:NumberTargets() > 2)) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0)) and NAG:Cast(45529)
    or (NAG:AuraIsKnown(81229) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) == 1) and (NAG:CurrentRunicPower() >= 20)) and NAG:Cast(49143)
    or NAG:Cast(50613)
    or NAG:Cast(57330)
    or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and (NAG:CurrentRunicPower() < 20)) and NAG:Cast(47568)
    or (NAG:DotIsActive(55078) and NAG:DotIsActive(55095) and (((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost))) or ((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightUnholy))) or ((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightUnholy))))) and NAG:Cast(123693)
    or (NAG:CurrentRunicPower() >= 20) and NAG:Cast(49143)
    or (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1) and NAG:Cast(43265)
    or (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) < 5) and (NAG:DotRemainingTime(55078) < 5) and NAG:Cast(45426, 10)
    or (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) > 0) and NAG:DotIsActive(55078) and NAG:DotIsActive(55095) and NAG:Cast(49020, 10)
    or NAG:Cast(49184, 10)
    ]],
    --[[
    add these lines after updating the rotation (at the end of it)

or     ((not NAG:IsActive(2825)) and (not NAG:IsActive(51124)) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) > 1) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) > 1) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) > 1) and (NAG:CurrentRunicPower() <= 30.0) and (NAG:CurrentRunicPower() >= 22.0) and NAG:Cast(45462, 10))
or     ((((not NAG:DotIsActive(55078)) or (NAG:DotRemainingTime(55078) < 4)) and (not NAG:DotIsActive(98957))) and (((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) > NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy)) or (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) > NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy)) or (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) > NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy)) or (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) > NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy))) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0)) and (NAG:NumberTargets() == 1.0) and NAG:Cast(45462, 10))
or     (NAG:IsActive(51124) and (not NAG:IsActive(96929)) and (NAG:DotIsActive(55078) or NAG:DotIsActive(98957)) and ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0)) and (NAG:NumberTargets() == 1.0) and NAG:Cast(49020, 10))
or     (NAG:IsActive(51124) and (not NAG:IsActive(96929)) and (NAG:DotIsActive(55078) or NAG:DotIsActive(98957)) and ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 2.0)) and (NAG:NumberTargets() > 1.0) and NAG:Cast(49020, 10))
or     (((NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy) <= 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0)) and (NAG:NumberTargets() == 1.0) and NAG:Cast(49020, 10))
or     NAG:Cast(49184, 10)

    ]]
    -- Tracked IDs for optimization
    spells = {2825, 43265, 45462, 45529, 46584, 47568, 49020, 49143, 49184, 50613, 51124, 51271, 55078, 55095, 57330, 59052, 77575, 81229, 114851, 114867, 115989, 123693, 138347},
    items = {76095},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {43533, 43548, 104047, 43550, 45806, 43673},
    author = "darkfrog",
    -- Condition: Has an off-hand equipped (dual wield)
    condition = function()
        -- If there's an item in the off-hand slot, player is dual-wielding
        local offhandLink = GetInventoryItemLink("player", 17) -- INVSLOT_OFFHAND
        return offhandLink ~= nil
    end


}



local frostMasterfrogDarkfrogAOE = {
    -- Core identification
    name = "Masterfrog AOE",
    specIndex = 2,
    class = "DEATHKNIGHT",

    -- Required parameters
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    rotationType = ns.ROTATION_TYPES.AOE,  -- Handles both ST and AOE
    enableSmartSwitching = true,

    -- Custom conditions for smart switching
    customConditions = {
        {
            type = ns.CUSTOM_CONDITION_TYPES.WEAPON_TYPE,
            value = "dualWield"  -- This rotation is for dual-wield setups
        },
        {
            type = ns.CUSTOM_CONDITION_TYPES.TARGET_COUNT,
            value = { value = 3, operator = "gte" },  -- Optimal for 4+ targets
            range = 8  -- Use 8-yard range for precise AOE target counting
        }
    },

    prePull = {
        { time = -7.0, action = "NAG:Cast(46584)" },
        { time = -6.0, action = "NAG:Cast(42650)" },
        { time = -1.0, action = "NAG:Cast(76095)" },
        { time = -1.0, action = "NAG:Cast(51271)" }
    },
    lastModified = "07/04/2025",
    rotationString = [[
            (not NAG:AuraIsActive(48266)) and NAG:Cast(48266)
    or ((not NAG:AuraIsActive(19506)) and (not NAG:AuraIsActive(6673)) and (not NAG:AuraIsActive(57330))) and NAG:Cast(57330)
    or NAG:Cast(51271)
    or NAG:Cast(33697)
    or NAG:Cast(26297)
    or NAG:AutocastOtherCooldowns()
    or NAG:Cast(126734)
    or (((NAG:SpellTimeToReady(51271) <= 5) or NAG:AuraIsActive(51271) or (NAG:RemainingTime() <= 65)) and (NAG:RemainingTime() > 10)) and NAG:Cast(46584)
    or ((NAG:UnitDistance() > 1) and (not NAG:DotIsActive(55078))) and NAG:Cast(77575)
    or (NAG:UnitDistance() > 1) and NAG:Cast(49184, nil, NAG.SPELL_POSITIONS.AOE)
    or ((NAG:RemainingTime() <= 30.0) or ((NAG:RemainingTime() <= 60.0) and (NAG:AuraIsActive(51271) or (NAG:SpellTimeToReady(51271) <= 4)))) and NAG:Cast(76095)
    or ((NAG:AuraNumStacks(114851) > 10) or (NAG:RemainingTime() < 5)) and NAG:Cast(45529)
    or (NAG:SpellIsReady(51271) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0)) and NAG:Cast(45529)
    or (NAG:AuraIsKnown(138347) and (NAG:IsExecutePhase(45) or (NAG:TimeToPercent(45)  < 6)) and (NAG:NumberTargets() <= 3) and (NAG:RemainingTime() > 5)) and NAG:Cast(114867)
    or ((NAG:IsExecutePhase(35) or (NAG:AuraIsKnown(138347) and (NAG:NumberTargets() <= 4) and (NAG:IsExecutePhase(45) or (NAG:TimeToPercent(45)  < 6)))) and (NAG:NumberTargets() <= 3) and (NAG:RemainingTime() > 5) and (NAG:TimeToPercent(35)  < 6)) and NAG:Cast(114867)
    or (NAG:SpellIsReady(114867) and (NAG:IsExecutePhase(35) or (NAG:AuraIsKnown(138347) and (NAG:NumberTargets() <= 4) and (NAG:IsExecutePhase(35) or (NAG:TimeToPercent(45)  < 6))) or (NAG:TimeToPercent(35)  < 6)) and (NAG:NumberTargets() <= 3) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:RemainingTime() > 5)) and NAG:Cast(45529)
    or ((NAG:AuraIsActive(51124) and NAG:AuraIsActive(59052)) or (NAG:CurrentRunicPower() > 88)) and NAG:Cast(49143)
    or (NAG:AuraIsActive(51124) and (NAG:CurrentRunicPower() < 76) and NAG:DotIsActive(55078) and NAG:DotIsActive(55095) and (NAG:NumberTargets() == 1) and NAG:AuraIsActive(2825)) and NAG:Cast(49020)
    or NAG:AuraIsActive(51124) and NAG:Cast(49143)
    or (NAG:AuraIsActive(51124) and (NAG:CurrentRunicPower() < 76) and NAG:DotIsActive(55078) and NAG:DotIsActive(55095) and (NAG:NumberTargets() == 1) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) > 0)) and NAG:Cast(49020)
    or (NAG:AuraIsActive(51124) and (NAG:CurrentRunicPower() < 76) and NAG:DotIsActive(55078) and NAG:DotIsActive(55095) and (((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) == 1))) and (NAG:NumberTargets() == 1)) and NAG:Cast(45529)
    or (((NAG:DotRemainingTime(55078) < 3) or (NAG:DotRemainingTime(55095) < 3)) and NAG:DotIsActive(55078) and NAG:DotIsActive(55095) and (((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost))) or ((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightUnholy))) or ((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightUnholy))))) and NAG:Cast(123693)
    or ((NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) or (NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost))) and NAG:Cast(49184)
    or ((NAG:AuraIsActive(51271) or (NAG:AnyTrinketStatProcsActive() and (NAG:SpellTimeToReady(51271) > 15))) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0)) and NAG:Cast(45529)
    or ((NAG:DotRemainingTime(55078) < 3.0) or (NAG:DotRemainingTime(55095) < 3.0)) and NAG:Cast(115989)
    or (not NAG:DotIsActive(55095)) and NAG:Cast(49184)
    or ((not NAG:DotIsActive(55078)) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) > 0)) and NAG:Cast(45462)
    or ((not NAG:DotIsActive(55078)) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) > 0) and (NAG:NumberTargets() >= 2) and (NAG:NumberTargets() <= 4)) and NAG:Cast(45462)
    or ((not NAG:DotIsActive(55078)) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) > 0) and (NAG:NumberTargets() >= 3) and (NAG:NumberTargets() <= 4)) and NAG:Cast(45462)
    or ((not NAG:DotIsActive(55078)) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) > 0) and (NAG:NumberTargets() == 4)) and NAG:Cast(45462)
    or ((not NAG:DotIsActive(55078)) and (NAG:NumberTargets() >= 5) and (NAG:RemainingTime() >= (NAG:DotRemainingTime(55078) + 30))) and NAG:Cast(50842)
    or ((not NAG:DotIsActive(55078))) and NAG:Cast(77575)
    or NAG:AuraIsActive(59052) and NAG:Cast(49184)
    or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) > 0) and (NAG:NumberTargets() > 1)) and NAG:Cast(43265)
    or ((NAG:CurrentRunicPower() > 76) and (NAG:NumberTargets() == 1)) and NAG:Cast(49143)
    or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) > 0) and NAG:DotIsActive(55078) and NAG:DotIsActive(55095) and (NAG:CurrentRunicPower() < 77)) and NAG:Cast(49020)
    or NAG:Cast(49184)
    or ((NAG:AuraIsActive(51271) or (NAG:NumberTargets() > 2)) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0)) and NAG:Cast(45529)
    or (NAG:AuraIsKnown(81229) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) == 1)) and NAG:Cast(49143)
    or NAG:Cast(50613)
    or NAG:Cast(57330)
    or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and (NAG:CurrentRunicPower() < 20)) and NAG:Cast(47568)
    or (NAG:DotIsActive(55078) and NAG:DotIsActive(55095) and (((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost))) or ((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightUnholy))) or ((not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftUnholy)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightUnholy))))) and NAG:Cast(123693)
    or (NAG:CurrentRunicPower() >= 20) and NAG:Cast(49143)
    or (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1) and NAG:Cast(43265)
    or (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) < 5) and (NAG:DotRemainingTime(55078) < 5) and NAG:Cast(45426, 10)
    or (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) > 0) and NAG:DotIsActive(55078) and NAG:DotIsActive(55095) and NAG:Cast(49020, 10)
    or NAG:Cast(49184, 10)
    ]],
    --[[
    add these lines after updating the rotation (at the end of it)

or     ((not NAG:IsActive(2825)) and (not NAG:IsActive(51124)) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) > 1) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) > 1) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) > 1) and (NAG:CurrentRunicPower() <= 30.0) and (NAG:CurrentRunicPower() >= 22.0) and NAG:Cast(45462, 10))
or     ((((not NAG:DotIsActive(55078)) or (NAG:DotRemainingTime(55078) < 4)) and (not NAG:DotIsActive(98957))) and (((NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood) > NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy)) or (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) > NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy)) or (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) > NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy)) or (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) > NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy))) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0)) and (NAG:NumberTargets() == 1.0) and NAG:Cast(45462, 10))
or     (NAG:IsActive(51124) and (not NAG:IsActive(96929)) and (NAG:DotIsActive(55078) or NAG:DotIsActive(98957)) and ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0)) and (NAG:NumberTargets() == 1.0) and NAG:Cast(49020, 10))
or     (NAG:IsActive(51124) and (not NAG:IsActive(96929)) and (NAG:DotIsActive(55078) or NAG:DotIsActive(98957)) and ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 2.0)) and (NAG:NumberTargets() > 1.0) and NAG:Cast(49020, 10))
or     (((NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy) <= 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1.0)) and (NAG:NumberTargets() == 1.0) and NAG:Cast(49020, 10))
or     NAG:Cast(49184, 10)

    ]]

    -- Tracked IDs for optimization
    spells = {2825, 43265, 45462, 45529, 46584, 47568, 49020, 49143, 49184, 50613, 51124, 51271, 55078, 55095, 57330, 59052, 77575, 81229, 114851, 114867, 115989, 123693, 138347},
    items = {76095},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {43533, 43548, 104047, 43550, 45806, 43673},
    author = "darkfrog",
    -- Condition: Has an off-hand equipped (dual wield)
    condition = function()
        -- If there's an item in the off-hand slot, player is dual-wielding
        local offhandLink = GetInventoryItemLink("player", 17) -- INVSLOT_OFFHAND
        return offhandLink ~= nil
    end


}



local frost2HDarkfrog = {
    -- Core identification
    name = "Frost 2H",
    specIndex = 2,
    class = "DEATHKNIGHT",

    -- Required parameters
    default = false,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    rotationType = ns.ROTATION_TYPES.SINGLE_TARGET,  -- 2H weapons only do single-target, system handles AOE switching
    enableSmartSwitching = true,

    -- Custom conditions for smart switching
    customConditions = {
        {
            type = ns.CUSTOM_CONDITION_TYPES.WEAPON_TYPE,
            value = "twoHand"  -- This rotation is optimal for 2H weapons
        },
        {
            type = ns.CUSTOM_CONDITION_TYPES.TARGET_COUNT,
            value = { min = 1, max = 2,  operator = "range" },  -- Optimal for 4+ targets
            range = 8  -- Use 8-yard range for precise AOE target counting
        }
    },

    prePull = {
        { time = -7.0, action = "NAG:Cast(46584)" },
        { time = -6.0, action = "NAG:Cast(42650)" },
        { time = -1.0, action = "NAG:Cast(76095)" }
    },
    lastModified = "07/10/2025",
    rotationString = [[
            (not NAG:AuraIsActive(48266)) and NAG:Cast(48266)
    or (NAG:AuraIsInactive(19506) and NAG:AuraIsInactive(6673) and NAG:AuraIsInactive(57330)) and NAG:Cast(57330)
    or NAG:Cast(51271)
    or NAG:AutocastOtherCooldowns()
    or NAG:Cast(126734)
    or (((NAG:SpellTimeToReady(51271) <= 5) or NAG:AuraIsActive(51271) or (NAG:RemainingTime() <= 65)) and (NAG:RemainingTime() > 10)) and NAG:Cast(46584)
    or ((NAG:RemainingTime() <= 30.0) or ((NAG:RemainingTime() <= 60.0) and (NAG:AuraIsActive(51271) or (NAG:SpellTimeToReady(51271) <= 4)))) and NAG:Cast(76095)
    or (NAG:AuraIsKnown(138347) and (NAG:IsExecutePhase(45) or (NAG:TimeToPercent(45)  < 6)) and (NAG:NumberTargets() <= 3) and (NAG:RemainingTime() > 5)) and NAG:Cast(114867)
    or ((NAG:IsExecutePhase(35) or (NAG:AuraIsKnown(138347) and NAG:IsExecutePhase(35) and (NAG:TimeToPercent(45)  < 6)) or (NAG:TimeToPercent(35)  < 6)) and (NAG:RemainingTime() > 5)) and NAG:Cast(114867)
    or (NAG:SpellIsReady(114867) and (NAG:IsExecutePhase(35) or (NAG:AuraIsKnown(138347) and NAG:IsExecutePhase(35) and (NAG:TimeToPercent(45)  < 6)) or (NAG:TimeToPercent(35)  < 6)) and (NAG:RemainingTime() > 5)) and NAG:Cast(45529)
    or ((NAG:DotRemainingTime(55078) < 3.0) or (NAG:DotRemainingTime(55095) < 3.0)) and NAG:Cast(123693)
    or ((NAG:AuraNumStacks(114851) > 10) or (NAG:RemainingTime() < 5)) and NAG:Cast(45529)
    or (NAG:SpellIsReady(51271) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0)) and NAG:Cast(45529)
    or ((((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0))) and NAG:DotIsActive(55078) and NAG:DotIsActive(55095)) and NAG:Cast(123693)
    or ((not NAG:DotIsActive(55078)) or (not NAG:DotIsActive(55095))) and NAG:Cast(77575)
    or ((not NAG:DotIsActive(55078)) or (not NAG:DotIsActive(55095))) and NAG:Cast(115989)
    or (not NAG:DotIsActive(55095)) and NAG:Cast(49184)
    or (not NAG:DotIsActive(55078)) and NAG:Cast(45462)
    or (NAG:AuraIsActive(51124)) and NAG:Cast(49020)
    or (NAG:AuraIsActive(51124) and (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) >= 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) >= 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0)))) and NAG:Cast(45529)
    or ((NAG:CurrentRunicPower() > 76)) and NAG:Cast(49143)
    or (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 2) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 2) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 2))) and NAG:Cast(49020)
    or NAG:AuraIsActive(59052) and NAG:Cast(49184)
    or ((NAG:DotRemainingTime(55078) < 3.0) or (NAG:DotRemainingTime(55095) < 3.0)) and NAG:Cast(77575)
    or (NAG:DotRemainingTime(55078) < 3.0) and NAG:Cast(45462)
    or (NAG:DotRemainingTime(55095) < 3.0) and NAG:Cast(49184)
    or ((NAG:DotRemainingTime(55078) < 3.0) or (NAG:DotRemainingTime(55095) < 3.0)) and NAG:Cast(115989)
    or ((NAG:AuraIsKnown(81229) and ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) == 0) or (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) == 0) or (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) == 0))) or (NAG:SpellIsKnown(45529) and (NAG:AuraNumStacks(114851) <= 10) and NAG:AuraIsInactive(51124))) and NAG:Cast(49143)
    or NAG:Cast(49020)
    or (NAG:CurrentRunicPower() >= 40) and NAG:Cast(49143)
    or (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) <= 0) and NAG:AuraIsActive(51271))) and NAG:Cast(47568)
    or NAG:Cast(123693)
    or NAG:Cast(49143)
    or NAG:Cast(57330)
    ]],
    -- Condition: No off-hand equipped (2H weapon)
    condition = function()
        -- If there's no item in the off-hand slot, player is using a 2H weapon
        local offhandLink = GetInventoryItemLink("player", 17) -- INVSLOT_OFFHAND
        return offhandLink == nil and NAG:NumberTargets() < 3
    end,


    -- Tracked IDs for optimization
    spells = {6673, 19506, 45462, 45529, 46584, 47568, 48266, 49020, 49143, 49184, 51124, 51271, 55078, 55095, 57330, 59052, 77575, 81229, 114851, 114867, 115989, 123693, 138347},
    items = {76095},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {43533, 104048, 104047, 43550, 45806, 43673},
    author = "Darkfrog",

}


local frost2HDarkfrogAOE = {
    -- Core identification
    name = "Frost 2H ST/AOE",
    specIndex = 2,
    class = "DEATHKNIGHT",

    -- Required parameters
    default = false,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    rotationType = ns.ROTATION_TYPES.AOE,  -- AOE rotation for 2H weapons
    enableSmartSwitching = true,

    -- Custom conditions for smart switching
    customConditions = {
        {
            type = ns.CUSTOM_CONDITION_TYPES.WEAPON_TYPE,
            value = "twoHand"  -- This rotation is optimal for 2H weapons
        },
        {
            type = ns.CUSTOM_CONDITION_TYPES.TARGET_COUNT,
            value = { value = 3, operator = "gte" },  -- Optimal for 3+ targets
            range = 8  -- Use 8-yard range for precise AOE target counting
        }
    },

    prePull = {
        { time = -7.0, action = "NAG:Cast(46584)" },
        { time = -6.0, action = "NAG:Cast(42650)" },
        { time = -1.0, action = "NAG:Cast(76095)" }
    },
    lastModified = "07/10/2025",
    rotationString = [[
            (not NAG:AuraIsActive(48266)) and NAG:Cast(48266)
    or (NAG:AuraIsInactive(19506) and NAG:AuraIsInactive(6673) and NAG:AuraIsInactive(57330)) and NAG:Cast(57330)
    or NAG:Cast(51271)
    or NAG:AutocastOtherCooldowns()
    or NAG:Cast(126734)
    or (((NAG:SpellTimeToReady(51271) <= 5) or NAG:AuraIsActive(51271) or (NAG:RemainingTime() <= 65)) and (NAG:RemainingTime() > 10)) and NAG:Cast(46584)
    or ((NAG:RemainingTime() <= 30.0) or ((NAG:RemainingTime() <= 60.0) and (NAG:AuraIsActive(51271) or (NAG:SpellTimeToReady(51271) <= 4)))) and NAG:Cast(76095)
    or ((NAG:IsExecutePhase(35) or (NAG:AuraIsKnown(138347) and NAG:IsExecutePhase(35) and (NAG:TimeToPercent(45)  < 6)) or (NAG:TimeToPercent(35)  < 6)) and (NAG:RemainingTime() > 5)) and NAG:Cast(114867)
    or (NAG:SpellIsReady(114867) and (NAG:IsExecutePhase(35) or (NAG:AuraIsKnown(138347) and NAG:IsExecutePhase(35) and (NAG:TimeToPercent(45)  < 6)) or (NAG:TimeToPercent(35)  < 6)) and (NAG:RemainingTime() > 5)) and NAG:Cast(45529)
    or ((NAG:DotRemainingTime(55078) < 3.0) or (NAG:DotRemainingTime(55095) < 3.0)) and NAG:Cast(123693)
    or ((NAG:AuraNumStacks(114851) > 10) or (NAG:RemainingTime() < 5)) and NAG:Cast(45529)
    or (NAG:SpellIsReady(51271) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0)) and NAG:Cast(45529)
    or ((((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0))) and NAG:DotIsActive(55078) and NAG:DotIsActive(55095)) and NAG:Cast(123693)
    or ((not NAG:DotIsActive(55078)) or (not NAG:DotIsActive(55095))) and NAG:Cast(77575)
    or ((not NAG:DotIsActive(55078)) or (not NAG:DotIsActive(55095))) and NAG:Cast(115989)
    or (not NAG:DotIsActive(55095)) and NAG:Cast(49184)
    or (not NAG:DotIsActive(55078)) and NAG:Cast(45462)
    or ((not NAG:DotIsActive(55078)) and (NAG:NumberTargets() >= 3) and (NAG:RemainingTime() >= (NAG:DotRemainingTime(55078) + 15))) and NAG:Cast(50842)
    or (NAG:AuraIsActive(51124) and (NAG:NumberTargets() <= 3)) and NAG:Cast(49020)
    or (NAG:AuraIsActive(51124) and (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) >= 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) >= 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0))) and (NAG:NumberTargets() <= 3)) and NAG:Cast(45529)
    or (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0)) and (NAG:NumberTargets() >= 4)) and NAG:Cast(45529)
    or ((NAG:CurrentRunicPower() > 76) and (NAG:NumberTargets() <= 3)) and NAG:Cast(49143)
    or ((NAG:CurrentRunicPower() > 88) and (NAG:NumberTargets() >= 4)) and NAG:Cast(49143)
    or (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 2) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 2)) and (NAG:NumberTargets() == 1)) and NAG:Cast(49020)
    or (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 2) and (NAG:NumberTargets() == 2)) or ((NAG:NumberTargets() >= 4) and NAG:AuraIsActive(51124) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1))) and NAG:Cast(49020)
    or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) == 2) and (NAG:NumberTargets() >= 4)) and NAG:Cast(43265)
    or (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 2) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 2)) and (NAG:NumberTargets() > 1)) and NAG:Cast(49184)
    or NAG:AuraIsActive(59052) and NAG:Cast(49184)
    or ((NAG:DotRemainingTime(55078) < 3.0) or (NAG:DotRemainingTime(55095) < 3.0)) and NAG:Cast(77575)
    or (NAG:DotRemainingTime(55078) < 3.0) and NAG:Cast(45462)
    or (NAG:DotRemainingTime(55095) < 3.0) and NAG:Cast(49184)
    or ((NAG:DotRemainingTime(55078) < 3.0) or (NAG:DotRemainingTime(55095) < 3.0)) and NAG:Cast(115989)
    or ((NAG:AuraIsKnown(81229) and ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) == 0) or (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) == 0) or (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneUnholy) == 0))) or (NAG:SpellIsKnown(45529) and (NAG:AuraNumStacks(114851) <= 10) and NAG:AuraIsInactive(51124))) and NAG:Cast(49143)
    or (NAG:NumberTargets() == 1) and NAG:Cast(49020)
    or (NAG:NumberTargets() > 1) and NAG:Cast(49184)
    or (NAG:CurrentRunicPower() >= 40) and NAG:Cast(49143)
    or (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) <= 0) and NAG:AuraIsActive(51271))) and NAG:Cast(47568)
    or NAG:Cast(123693)
    or NAG:Cast(49143)
    or NAG:Cast(57330)
    ]],
    -- Condition: No off-hand equipped (2H weapon)
    condition = function()
        -- If there's no item in the off-hand slot, player is using a 2H weapon
        local offhandLink = GetInventoryItemLink("player", 17) -- INVSLOT_OFFHAND
        return offhandLink == nil and NAG:NumberTargets() >= 3
    end,


    -- Tracked IDs for optimization
    spells = {6673, 19506, 45462, 45529, 46584, 47568, 48266, 49020, 49143, 49184, 51124, 51271, 55078, 55095, 57330, 59052, 77575, 81229, 114851, 114867, 115989, 123693, 138347},
    items = {76095},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {43533, 104048, 104047, 43550, 45806, 43673},
    author = "Darkfrog",

}

-- DeathKnight Unholy Rotation
local unholyGroupRotation = {
    name = "DeathKnight Unholy - New format",
    specIndex = 3,
    class = "DeathKnight",
    experimental = true,
    default = false,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { time = -20.0, action = "NAG:Cast(48265)" },
            { time = -5.0, action = "NAG:Cast(42650)" },
            { time = -0.5, action = "NAG:Cast(76095)" }
    },
    rotationString = [[
NAG:AutocastOtherCooldowns()
    or ((NAG:TrinketProcsMinRemainingTime(1, 7, -1, 54) <= 1.5) or NAG:VariableRef("CDs running outy")) and (NAG:ShowCustomOverlay("Cancel") or true) and NAG:CastPlaceholder(115989, nil, NAG.SPELL_POSITIONS.ABOVE)
    or ((NAG:AuraIsActive(49206, "player", false) and (NAG:VariableRef("Jerry Timey") or ((NAG:TrinketProcsMinRemainingTime(1, -1, -1, 54) <= 2.0) and NAG:SpellIsReady(77575)))) or ((NAG:RemainingTime() <= (NAG:SpellTimeToReady(49206) + 30.0)) and NAG:VariableRef("Any Str/Haste Trinkie")) or (NAG:RemainingTime() <= 30.0)) and NAG:Cast(76095)
    or (((NAG:CurrentTime() <= 60.0) and (NAG:VariableRef("Any Str/Haste Trinkie") or (NAG:CurrentTime() >= 3.0))) or (NAG:AuraIsActive(49206, "player", false) and (NAG:AuraIsActive(63560, "player", false) or NAG:AuraIsActive(76095, "player", false)) and (NAG:CurrentTime() > 60.0)) or (NAG:RemainingTime() <= 35.0)) and NAG:Cast(49016)
    or ((NAG:CurrentTime() >= 5.0) and (NAG:VariableRef("Any Str/Haste Trinkie") or (NAG:RemainingTime() <= 16.0)) and (not (NAG:VariableRef("Executie") and NAG:VariableRef("Jerry not Timey") and (NAG:RemainingTime() >= 16.0)))) and NAG:Cast(33697)
    or ((NAG:CurrentTime() >= 5.0) and (NAG:VariableRef("Any Str/Haste Trinkie") or (NAG:RemainingTime() <= 21.0)) and (not (NAG:VariableRef("Executie") and NAG:VariableRef("Jerry not Timey") and (NAG:RemainingTime() >= 21.0)))) and NAG:Cast(121279)
    or (NAG:VariableRef("Jerry Timey") and NAG:AuraIsActive(49206, "player", false)) and NAG:Cast(26297)
    or ((NAG:CurrentTime() >= 5.0) and (NAG:VariableRef("Any Str/Haste Trinkie") or (NAG:RemainingTime() <= 12.0))) and NAG:Cast(126734)
    or (NAG:VariableRef("No Dotties") or (NAG:VariableRef("Any Str Trinkie") and (NAG:DotPercentIncrease(55078) > 0.0)) or (NAG:AuraIsActive(33697, "player", false) and NAG:AuraIsActive(126734, "player", false) and (NAG:DotPercentIncrease(55078) > 0.0))) and NAG:Cast(115989)
    or NAG:VariableRef("No Dotties") and NAG:Cast(45462)
    or ((NAG:CurrentTime() < 5.0) or ((NAG:RemainingTime() >= 190.0) and NAG:VariableRef("Trinkies off CDy")) or (NAG:VariableRef("Executie") and NAG:VariableRef("Trinkies off CDy")) or (NAG:RemainingTime() <= 35.0)) and NAG:Cast(49206)
    or (NAG:VariableRef("Big Snappy") and (NAG:VariableRef("bofa trinkies") or NAG:VariableRef("1 of 2 Trinkies"))) and NAG:GroupReference("Bend and Snappy")
    or (NAG:AuraIsInactive(2825, "player", true) and (NAG:DotPercentIncrease(55078) >= 0.0) and (NAG:RemainingTime() >= 10.0) and NAG:VariableRef("Plaguey Leechie")) and NAG:Cast(123693)
    or (NAG:AuraIsInactive(2825, "player", true) and NAG:AuraIsInactive(115989, "player", true) and (NAG:DotPercentIncrease(55078) > 0.2) and (not NAG:SpellIsKnown(123693))) and NAG:Cast(77575)
    or ((NAG:AuraNumStacks(114851, "player", false) > 10) or ((((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) <= 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0)) or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) <= 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0))) and NAG:VariableRef("no UD Runies") and (not NAG:VariableRef("Executie")) and (NAG:VariableRef("Any Str Trinkie") or NAG:SpellIsReady(43265))) or (NAG:SpellIsReady(114867) and NAG:VariableRef("Executie") and NAG:VariableRef("no UD Runies")) or (NAG:RemainingTime() <= 10.0)) and NAG:Cast(45529)
    or ((NAG:CurrentTime() < 5.0) and NAG:DotIsActive(55078) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) < 2) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) < 2)) and NAG:Cast(43265)
    or (NAG:VariableRef("No Dotties") and (NAG:RemainingTime() <= 30.0)) and NAG:Cast(77575)
    or (NAG:VariableRef("Executie") and (NAG:RemainingTime() >= 5.0)) and NAG:Cast(114867)
    or ((NAG:RemainingTime() >= 15.0) and (not (NAG:VariableRef("Executie") and NAG:SpellIsReady(49206))) and NAG:VariableRef("HolyMoly")) and NAG:Cast(63560)
    or (NAG:CurrentRunicPower() > 90) and NAG:Cast(47541)
    or ((NAG:VariableRef("Dot Finny") and (not NAG:SpellIsReady(115989)) and ((NAG:DotRemainingTime(55078) < NAG:RemainingTime()) and ((NAG:DotRemainingTime(55078) < NAG:SpellTimeToReady(126734)) or (NAG:DotRemainingTime(55078) < NAG:TrinketProcsMaxRemainingICD(1, -1, -1, 54)))) and ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) >= 1) or (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) >= 1))) or (((NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) <= 1.0) or (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) <= 1.0)) and NAG:AuraIsActive(2825, "player", true))) and NAG:Cast(85948)
    or (NAG:VariableRef("Plaguey Leechie") and NAG:VariableRef("Dot Finny") and NAG:AuraIsInactive(2825, "player", true)) and NAG:Cast(123693)
    or ((NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy) <= 1.0) and (NAG:RemainingTime() >= 8.0)) and NAG:Cast(43265)
    or ((not (NAG:VariableRef("Festerblight") and NAG:VariableRef("DiseasesNeedExtend"))) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy) <= 1.0)) and NAG:Cast(55090)
    or (((NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) <= 1) and (not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0)) or ((NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) <= 1) and (not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0))) and NAG:Cast(45529)
    or (NAG:VariableRef("DiseasesNeedExtend") and (((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) >= 1) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) <= 1.0) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) >= 1)) or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) >= 1) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) <= 1.0) and (not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) and (not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood))) or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) >= 1) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) <= 1.0) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) >= 1)) or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) >= 1) and (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) <= 1.0) and (not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost))))) and NAG:Cast(85948)
    or (((NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) <= 1.0) or (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) <= 1.0)) and (NAG:RemainingTime() >= 8.0)) and NAG:Cast(43265)
    or ((NAG:NextRuneCooldown(NAG.Types.RuneType.RuneBlood) <= 1.0) or (NAG:NextRuneCooldown(NAG.Types.RuneType.RuneFrost) <= 1.0)) and NAG:Cast(55090)
    or (NAG:AuraIsActive(81340, "player", true) or NAG:AuraIsInactive(63560, "player", true)) and NAG:Cast(47541)
    or (NAG:VariableRef("HolyMoly") and (NAG:RemainingTime() >= 8.0)) and NAG:Cast(43265)
    or (NAG:VariableRef("HolyMoly") or (NAG:RemainingTime() < 5.0)) and NAG:Cast(55090)
    or (not (NAG:AuraIsActive(63560, "player", false) and (NAG:AuraRemainingTime(63560) <= 5.0) and (NAG:RemainingTime() >= 10.0))) and NAG:Cast(47541)
    or ((NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneBlood) >= 1) and (NAG:CurrentNonDeathRuneCount(NAG.Types.RuneType.RuneFrost) >= 1)) and NAG:Cast(85948)
    or NAG:Cast(57330)
    or (NAG:VariableRef("no UD Runies") and (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) >= 3.0) and (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) <= 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) >= 3.0)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) <= 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) >= 3.0))) and (not NAG:SpellCanCast(47541)) and NAG:GCDIsReady() and NAG:AuraIsInactive(2825, "player", true)) and NAG:Cast(47568)
    ]],

    -- Tracked IDs for optimization
    spells = {2825, 26297, 33697, 43265, 45462, 45529, 47541, 47568, 49016, 49206, 53365, 55078, 55090, 57330, 60229, 63560, 77575, 81340, 85948, 114851, 114867, 115989, 121279, 123693, 126582, 126734, 128986, 138347},
    items = {76095},
    auras = {},
    runes = {},
    glyphs = {43533, 43548, 104049, 43550, 45806, 43539},
    consumables = { prepotId = 76095, potId = 76095, flaskId = 76088, foodId = 74646 },

    -- Groups and Variables from WoWSims APL
    groups = {
        {
            name = [[Bend and Snappy]],
            actions = {
                [[(NAG:AuraIsInactive(2825, "player", true)) and NAG:Cast(123693)]],
                [[(NAG:VariableRef("PS over OBie")) and NAG:Cast(45462)]],
                [[NAG:Cast(77575)]]
            }
        }
        },
    variables = {
        {
            name = [[Big Snappy]],
            value = [[(NAG:AuraIsInactive(115989, "player", true) and (((NAG:AuraIsActive(76095, "player", false) or (not NAG:VariableRef("Executie")) or (not NAG:SpellCanCast(76095)) or ((NAG:SpellTimeToReady(49206) >= (NAG:TrinketProcsMinRemainingTime(1, -1, -1, 54) - 2.0)) and NAG:AuraIsInactive(49206, "player", false))) and NAG:AuraIsActive(53365, "player", false)) or (NAG:TrinketProcsMinRemainingTime(1, -1, -1, 54) <= 2.0)))]]
        },
        {
            name = [[1 of 2 Trinkies]],
            value = [[(NAG:VariableRef("Any Str Trinkie") and ((NAG:DotPercentIncrease(55078) > 0.02) or (NAG:DotRemainingTime(55078) <= 6.0)) and ((NAG:TrinketProcsMinRemainingTime(1, -1, -1, 54) < (NAG:SpellTimeToReady(126734) - 2.0)) or NAG:AuraIsActive(126734, "player", false)) and ((NAG:TrinketProcsMinRemainingTime(1, -1, -1, 54) < (NAG:SpellTimeToReady(33697) - 2.0)) or NAG:AuraIsActive(33697, "player", false) or (not (NAG:VariableRef("Executie") and NAG:VariableRef("Jerry not Timey")))) and (NAG:TrinketProcsMinRemainingTime(1, -1, -1, 54) <= (NAG:TrinketProcsMaxRemainingICD(1, -1, -1, 54) - 2)))]]
        },
        {
            name = [[bofa trinkies]],
            value = [[(NAG:AllTrinketStatProcsActive(1, -1, -1, 54) and ((NAG:DotPercentIncrease(55078) > 0.02) or (NAG:DotRemainingTime(55078) <= 12.0)) and (((NAG:TrinketProcsMinRemainingTime(1, -1, -1, 54) < (NAG:SpellTimeToReady(126734) - 2.0)) and (not (NAG:TrinketProcsMaxRemainingICD(1, -1, -1, 54) <= (NAG:TrinketProcsMinRemainingTime(1, -1, -1, 54) - 5.0)))) or NAG:AuraIsActive(126734, "player", false)) and ((NAG:TrinketProcsMinRemainingTime(1, -1, -1, 54) < (NAG:SpellTimeToReady(33697) - 2.0)) or NAG:AuraIsActive(33697, "player", false) or (not (NAG:VariableRef("Executie") and NAG:VariableRef("Jerry not Timey")))))]]
        },
        {
            name = [[CDs running outy]],
            value = [[(((NAG:AuraRemainingTime(126734) <= 1.5) and NAG:AuraIsActive(126734, "player", false)) or ((NAG:AuraRemainingTime(33697) <= 1.5) and NAG:AuraIsActive(33697, "player", false) and NAG:AuraIsKnown(33697)) or ((NAG:AuraRemainingTime(53365) <= 1.5) and NAG:AuraIsActive(53365, "player", false)))]]
        },
        {
            name = [[Any Str/Haste Trinkie]],
            value = [[NAG:AnyTrinketStatProcsActive(1, 8, -1, 54)]]
        },
        {
            name = [[Any Str Trinkie]],
            value = [[NAG:AnyTrinketStatProcsActive(1, -1, -1, 54)]]
        },
        {
            name = [[Trinkies off CDy]],
            value = [[((NAG:AuraInternalCooldown(126582) <= 3.0) or (NAG:AuraInternalCooldown(128986) <= 3.0) or (NAG:AuraInternalCooldown(60229) <= 3.0))]]
        },
        {
            name = [[Hastey]],
            value = [[((not NAG:SpellIsReady(123693)) or NAG:AuraIsActive(49016, "player", false) or NAG:AuraIsActive(2825, "player", false))]]
        },
        {
            name = [[Executie]],
            value = [[((NAG:TimeToPercent(35) < 5.0) or (NAG:AuraIsKnown(138347) and (NAG:TimeToPercent(45) < 5.0)))]]
        },
        {
            name = [[Jerry not Timey]],
            value = [[(NAG:SpellIsReady(49206) or (NAG:AuraRemainingTime(49206) > 26.0))]]
        },
        {
            name = [[Jerry Timey]],
            value = [[(NAG:AuraRemainingTime(49206) <= 26.0)]]
        },
        {
            name = [[No Dotties]],
            value = [[((not NAG:DotIsActive(55078)) and NAG:AuraIsInactive(115989, "player", false))]]
        },
        {
            name = [[no UD Runies]],
            value = [[((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0))]]
        },
        {
            name = [[Plaguey Leechie]],
            value = [[(((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0)))]]
        },
        {
            name = [[Dot Finny]],
            value = [[((NAG:DotRemainingTime(55078) < 3.0) and (NAG:DotRemainingTime(55078) < NAG:RemainingTime()))]]
        },
        {
            name = [[PS over OBie]],
            value = [[(NAG:AuraIsActive(2825, "player", true) or (not NAG:SpellCanCast(77575)))]]
        },
        {
            name = [[HolyMoly]],
            value = [[(not (NAG:VariableRef("Executie") and (((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) and (NAG:SpellTimeToReady(114867) < NAG:NextRuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851, "player", false) < 5)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) and (NAG:SpellTimeToReady(114867) < NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851, "player", false) < 5)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) and (NAG:SpellTimeToReady(114867) < NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851, "player", false) < 5)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) and (NAG:SpellTimeToReady(114867) < NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851, "player", false) < 5)) or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood))) and ((not NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost)) or (NAG:SpellTimeToReady(114867) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) and (NAG:SpellTimeToReady(114867) < NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy)) and (NAG:AuraNumStacks(114851, "player", false) < 5)))))]]
        }
        },

    -- Optional metadata
    talentsString = "221111",
    lastModified = "10/23/2025",
    author = "Diurdussy @ Ebon Hold"
}




local BloodAOEwcomments4pcT15 = {
    -- Core identification
    name = "Blood AOE w/comments 4pcT15",
    specIndex = 1,
    class = "DEATHKNIGHT",

    -- Required parameters
    default = false,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    rotationType = ns.ROTATION_TYPES.SINGLE_TARGET,
    enableSmartSwitching = false,

    -- Custom conditions for smart switching
    customConditions = {
        {
            type = ns.CUSTOM_CONDITION_TYPES.TARGET_COUNT,
            value = { min = 1, max = 3, operator = "range" },  -- Optimal for 1-3 targets
            range = 8  -- Use 8-yard range for precise target counting
        }
    },

    prePull = {
        { time = -31.0, action = "NAG:Cast(48263)" },
        { time = -30.0, action = "NAG:Cast(49222)" },
        { time = -7.0, action = "NAG:Cast(42650)" },
        { time = -1.5, action = "NAG:Cast(57330)" },
        { time = -1.0, action = "NAG:Cast(76095)" }
    },
    lastModified = "12/20/2025",
    rotationString = [[
(not NAG:AuraIsActive(49222)) and NAG:Cast(49222) -- Apply Bone Shield (49222) if not active
or (NAG:CountEnemiesInRange(8) <= 3) and NAG:SelectRotation("Blood DPS w/comments 4pcT15") -- Switch to Blood DPS rotation if ???3 enemies within 8 yards
or ((UnitHealth("player") / UnitHealthMax("player")) <= 0.4 and (NAG:CurrentRuneCount(2) >= 1 and NAG:CurrentRuneCount(3) >= 1 or NAG:CurrentRuneCount(4) >= 2) and NAG:SpellIsReady(49998)) and NAG:Cast(49998) -- If health ???40%, checks for Frost + Unholy Runes or 2 Death Runes and casts Death Strike (49998) if ready (survival priority to heal at low HP)
or (not NAG:AuraIsActive(48263)) and NAG:Cast(48263) -- Apply Blood Presence (48263) if not active (ensures tank presence)
or ((NAG:DotRemainingTime(55095) <= 0 or NAG:DotRemainingTime(55078) <= 0) and NAG:SpellIsReady(77575)) and NAG:Cast(77575) -- If Frost Fever (55095) or Blood Plague (55078) is missing, casts Outbreak (77575) if ready (disease application for AOE scaling)
or (NAG:AuraIsActive(81141) and not NAG:AuraIsActive(49028) and NAG:SpellIsReady(43265)) and NAG:Cast(43265) -- If Crimson Scourge (81141) proc active and DRW (49028) inactive, casts Death and Decay (43265) if ready (proc usage for AOE damage and threat)
or (NAG:AuraIsActive(53386) and NAG:CountEnemiesInRange(10) >= 3 and not NAG:AuraIsActive(49028) and not NAG:IsExecutePhase(35) and NAG:SpellTimeToReady(43265) <= 0) and NAG:Cast(43265) -- If Cinderglacier (53386) active, 3+ enemies within 10 yards, DRW inactive, not in execute, and Death and Decay cooldown ???0, casts Death and Decay (43265) (proc synergy for multi-target damage outside execute)
or (NAG:AuraIsActive(81141) and not NAG:AuraIsActive(49028) and NAG:SpellTimeToReady(43265) > 5 and NAG:DotRemainingTime(55095) > 0 and (function() local base, pos = select(1, UnitAttackPower("player")); local ap = (base and pos) and (base + pos) or 0; return ap >= NAG:Snapshot("ap", 55095) end)() and not NAG:IsExecutePhase(35) and NAG:SpellIsReady(48721)) and NAG:Cast(48721) -- If Crimson Scourge proc active, DRW inactive, Death and Decay cooldown >5, Frost Fever active, AP snapshot met, not in execute, and Blood Boil (48721) ready, casts Blood Boil (48721) (fallback proc usage to refresh snapshot if AP is high for multi-dot damage)
    or (NAG:AuraIsActive(49028) and (((NAG:IsExecutePhase(35) or NAG:TimeToPercent(35) < 6) or (NAG:AuraIsKnown(138347) and NAG:TimeToPercent(45) < 6))) and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(114866)) and NAG:Cast(114866) -- Cast Soul Reaper during DRW with T15 extended to 45% if approaching, requires Blood Rune
    or (NAG:AuraIsActive(49028) and NAG:DotIsActive(55095) and not NAG:TargetHasDRWDebuff(55095) and NAG:SpellIsReady(77575)) and NAG:Cast(77575) -- If DRW active, Frost Fever active, but not mirrored by DRW, casts Outbreak (77575) (disease mirroring for DRW)
    or (NAG:AuraIsActive(81256) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) <=1)) and NAG:Cast(45529) -- If Dancing Rune Blade (81256) active and ???1 Death Rune, casts Blood Tap (45529) (rune conversion during DRW)
    or (NAG:AuraIsActive(49028) and NAG:CountEnemiesInRange(8) >= 3 and NAG:DotRemainingTime(55095) > 0 and NAG:DotRemainingTime(55078) > 0 and NAG:TargetHasDRWDebuff(55095) and NAG:TargetHasDRWDebuff(55078) and NAG:NumberTargetsWithDRWDebuff(55095, 8) < NAG:CountEnemiesInRange(8) and NAG:CurrentHealthPercent() > 0.4 and not NAG:IsExecutePhase(35) and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(50842)) and NAG:Cast(50842) -- If DRW active, diseases active and mirrored on target, but not all enemies have DRW diseases, health >40%, not in execute, and Blood Rune available, casts Pestilence (50842) (spread DRW diseases to 3+ enemies)
    or (NAG:AuraIsActive(49028) and NAG:CountEnemiesInRange(10) >= 3 and NAG:CurrentHealthPercent() > 0.4 and NAG:DotRemainingTime(55095) > 0 and not NAG:IsExecutePhase(35) and NAG:SpellIsReady(48721) and (NAG:DotRemainingTime(55095) <= 4 or NAG:SnapshotPercent(55095, "ap") >= 0)) and NAG:Cast(48721) -- If DRW active, 3+ enemies within 10 yards, health >40%, Frost Fever active, not in execute, and disease refresh needed, casts Blood Boil (48721) (AOE damage and dot refresh during DRW)
    or (NAG:AuraIsActive(49028) and NAG:SpellIsReady(48707)) and NAG:Cast(48707) -- If DRW active, casts Anti-Magic Shell (48707) (defensive cooldown during DRW)
    or (NAG:AuraIsActive(49028) and NAG:CurrentRuneCount(2) >= 1 and NAG:CurrentRuneCount(3) >= 1 and NAG:SpellIsReady(49998)) and NAG:Cast(49998) -- If DRW active, Frost + Unholy Runes available, casts Death Strike (49998) (survival and damage during DRW)
    or (NAG:AuraIsActive(49028) and NAG:CurrentRunicPower() >= 30 and NAG:SpellIsReady(56815)) and NAG:Cast(56815) -- If DRW active and 30+ Runic Power, casts Rune Strike (56815) (RP dump during DRW)
    or (NAG:AuraIsActive(49028) and NAG:SpellIsReady(47568) and (NAG:CurrentRuneCount(2) == 0 and NAG:CurrentRuneCount(3) == 0 or NAG:CurrentRuneCount(4) == 0)) and NAG:Cast(47568) -- If DRW active and no Frost, Unholy, or Death Runes, casts Empower Rune Weapon (47568) (rune refresh during DRW)
    or ((select(2, UnitAttackPower("player")) >= (UnitLevel("player") < 60 and 0 or (200 + (UnitLevel("player") - 60) * 300)) or (UnitHealth("player") / UnitHealthMax("player")) < 0.65) and NAG:SpellTimeToReady(49028) <= 0) and NAG:Cast(49028) -- Cast Dancing Rune Weapon (49028) if attack power or health <65% conditions met
    or (NAG:AuraNumStacks(114851) >= 10 and NAG:CurrentRuneCount(1) == 0) and NAG:Cast(45529) -- Cast Blood Tap (45529) with 10+ charges and no Blood Runes
    or (((NAG:IsExecutePhase(35) or (NAG:AuraIsKnown(138347) and NAG:TimeToPercent(45) < 6))) and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(114866)) and NAG:Cast(114866) -- Cast Soul Reaper in execute with T15 extended to 45% if approaching, requires Blood Rune
    or (NAG:IsExecutePhase(35) and NAG:AuraIsActive(53386) and NAG:SpellIsReady(114866)) and NAG:Cast(114866) -- Cast Soul Reaper (114866) in execute phase with Cinderglacier (53386) proc (fallback)
    or (NAG:IsExecutePhase(35) and NAG:SpellIsReady(114866)) and NAG:Cast(114866) -- Cast Soul Reaper (114866) in execute phase (fallback)
    or (NAG:IsExecutePhase(35) and not NAG:SpellIsKnown(114866) and NAG:CurrentRunicPower() >= 30 and NAG:SpellIsReady(56815)) and NAG:Cast(56815) -- Cast Rune Strike (56815) in execute if Soul Reaper unknown with 30+ Runic Power
    or (NAG:IsExecutePhase(35) and not NAG:SpellIsKnown(114866) and NAG:CurrentRuneCount(4) >= 1 and NAG:SpellIsReady(49998)) and NAG:Cast(49998) -- Cast Death Strike (49998) in execute if Soul Reaper unknown with Death Rune
    or (NAG:IsExecutePhase(35) and not NAG:SpellIsKnown(114866) and NAG:CurrentRuneCount(1) >= 1 and NAG:CurrentHealthPercent() > 0.4 and NAG:CountEnemiesInRange(8) >= 3 and NAG:DotRemainingTime(55078) <= 4 and NAG:SpellIsReady(48721)) and NAG:Cast(48721) -- Cast Blood Boil (48721) in execute if Soul Reaper unknown, 3+ enemies, and Blood Plague (55078) needs refresh
    or (NAG:CountEnemiesInRange(8) >= 3 and NAG:DotRemainingTime(55095) <= 4 and NAG:DotRemainingTime(55095) > 0 and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(48721) and not NAG:IsExecutePhase(35)) and NAG:Cast(48721) -- Cast Blood Boil (48721) if 3+ enemies, Frost Fever needs refresh, and not in execute
    or (NAG:CountEnemiesInRange(8) >= 4 and NAG:CurrentHealthPercent() > 0.4 and NAG:DotRemainingTime(55095) > 0 and not NAG:IsExecutePhase(35) and NAG:SpellIsReady(48721)) and NAG:Cast(48721) -- Cast Blood Boil (48721) if 4+ enemies, health >40%, Frost Fever active, and not in execute
    or (NAG:CountEnemiesInRange(8) >= 3 and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(48721) and not NAG:IsExecutePhase(35) and (NAG:DotRemainingTime(55095) <= 4 or NAG:SnapshotPercent(55095, "ap") >= 0)) and NAG:Cast(48721) -- Cast Blood Boil (48721) if 3+ enemies, not in execute, and Frost Fever needs refresh or snapshot met
    or (NAG:CountEnemiesInRange(8) >= 3 and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(55050) and not NAG:IsExecutePhase(35) and NAG:DotRemainingTime(55095) >= 6 and NAG:SnapshotPercent(55095, "ap") < 0) and NAG:Cast(55050) -- Cast Heart Strike (55050) if 3+ enemies, not in execute, with Frost Fever snapshot conditions
    or (NAG:CountEnemiesInRange(8) >= 3 and (NAG:CurrentRuneCount(2) >= 1 and NAG:CurrentRuneCount(3) >= 1 or NAG:CurrentRuneCount(4) >= 1) and NAG:SpellIsReady(49998) and NAG:CurrentRuneCount(1) == 0 and not NAG:IsExecutePhase(35)) and NAG:Cast(49998) -- If 3+ enemies, Frost + Unholy or 1 Death Rune available, no Blood Rune, not in execute, casts Death Strike (49998) (survival in AOE without Blood Runes)
    or (NAG:CountEnemiesInRange(8) >= 3 and (NAG:CurrentRunicPower() >= 100 or (NAG:CurrentRuneCount(1) == 0 and NAG:CurrentRuneCount(4) == 0)) and NAG:SpellIsReady(56815) and not NAG:IsExecutePhase(35)) and NAG:Cast(56815) -- If 3+ enemies, 100+ Runic Power or no Blood/Death Runes, not in execute, casts Rune Strike (56815) (RP dump in AOE)
    or (not NAG:AuraIsActive(49028)) and NAG:Cast(57330) -- Cast Horn of Winter (57330) if DRW inactive
    or (NAG:CurrentRunicPower() >= 20 and not NAG:IsReadySpell(108196) and NAG:CurrentRunicPower() < 30 and NAG:Cast(56815, 10)) -- Cast Rune Strike (56815) with 20-29 Runic Power if Death Siphon unavailable
    or (((((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy))) or ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy)) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) < NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy))))) and NAG:Cast(48721, 10)) -- Cast Blood Boil (48721) with specific Blood Rune cooldown logic for optimal timing
    or NAG:Cast(49998, 10) -- Cast Death Strike (49998) as fallback

    ]],


    -- Tracked IDs for optimization
    spells = {45529, 46584, 47568, 48721, 48743, 48792, 48982, 49222, 49998, 55050, 55078, 55095, 55233, 56815, 57330, 77535, 77575, 81141, 81256, 82176, 96171},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {104049, 104048, 43826, 104101, 43550, 43672},
    author = "@Headrippa",

}



local BloodST4pcT15 = {
    -- Core identification
    name = "Blood Single Target 4pcT15",
    specIndex = 1,
    class = "DEATHKNIGHT",

    -- Required parameters
    default = false,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    rotationType = ns.ROTATION_TYPES.SINGLE_TARGET,
    enableSmartSwitching = false,

    -- Custom conditions for smart switching
    customConditions = {
        {
            type = ns.CUSTOM_CONDITION_TYPES.TARGET_COUNT,
            value = { min = 1, max = 3, operator = "range" },  -- Optimal for 1-3 targets
            range = 8  -- Use 8-yard range for precise target counting
        }
    },

    prePull = {
        { time = -31.0, action = "NAG:Cast(48263)" },
        { time = -30.0, action = "NAG:Cast(49222)" },
        { time = -7.0, action = "NAG:Cast(42650)" },
        { time = -1.5, action = "NAG:Cast(57330)" },
        { time = -1.0, action = "NAG:Cast(76095)" }
    },
    lastModified = "12/20/2025",
    rotationString = [[
(not NAG:AuraIsActive(49222)) and NAG:Cast(49222) -- Apply Bone Shield if not active
or (not NAG:AuraIsActive(48263)) and NAG:Cast(48263) -- Apply Blood Presence if not active
or ((UnitHealth("player") / UnitHealthMax("player")) <= 0.4 and (NAG:CurrentRuneCount(2) >= 1 and NAG:CurrentRuneCount(3) >= 1 or NAG:CurrentRuneCount(4) >= 2) and NAG:SpellIsReady(49998)) and NAG:Cast(49998) -- Cast Death Strike (49998) at ???40% health
or (((NAG:IsExecutePhase(35) or (NAG:AuraIsKnown(138347) and (NAG:TimeToPercent(45) < 6.0) or NAG:TimeToPercent(35) < 6))) and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(114866)) and NAG:Cast(114866) -- Cast Soul Reaper (114866) in execute phase (<35% target health) or within 6 seconds of 35%
or (NAG:CurrentHealthPercent() > 0.5 and NAG:CurrentRuneCount(4) >= 1 and NAG:SpellIsReady(108196) and (function() local base, pos = select(1, UnitAttackPower("player")); local ap = (base and pos) and (base + pos) or 0; local wd = NAG:WeaponDamage() or 0; return (NAG:AuraIsActive(53386) and ap >= 7.07 * wd - 55147) or (not NAG:AuraIsActive(53386) and ap >= 10.1808 * wd - 79351.68) end)()) and NAG:Cast(108196) -- Cast Death Siphon (108196) with Death Rune if health >50% and attack power threshold met
    or ((NAG:DotRemainingTime(55095) <= 0 or NAG:DotRemainingTime(55078) <= 0) and NAG:SpellIsReady(77575)) and NAG:Cast(77575) -- Cast Outbreak (77575) if Frost Fever (55095) or Blood Plague (55078) is missing
    or (NAG:AuraIsActive(81141) and not NAG:AuraIsActive(49028) and NAG:DotRemainingTime(55095) > 5 and NAG:SpellIsReady(43265)) and NAG:Cast(43265) -- Cast Death and Decay (43265) with Crimson Scourge (81141) proc if Dancing Rune Weapon (49028) is inactive
    or (NAG:AuraIsActive(81141) and not NAG:AuraIsActive(49028) and NAG:SpellTimeToReady(43265) > 5 and NAG:DotRemainingTime(55095) > 0 and (function() local base, pos = select(1, UnitAttackPower("player")); local ap = (base and pos) and (base + pos) or 0; return ap >= NAG:Snapshot("ap", 55095) end)() and NAG:SpellIsReady(48721)) and NAG:Cast(48721) -- Cast Blood Boil (48721) with Crimson Scourge proc if Death and Decay on cooldown, Frost Fever active, and attack power snapshot met
        or (NAG:AuraIsActive(49028) and (((NAG:IsExecutePhase(35) or NAG:TimeToPercent(35) < 6) or (NAG:AuraIsKnown(138347) and NAG:TimeToPercent(45) < 6))) and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(114866)) and NAG:Cast(114866) -- Cast Soul Reaper during DRW with T15 extended to 45% if approaching, requires Blood Rune
        or (NAG:AuraIsActive(49028) and NAG:DotIsActive(55095) and not NAG:TargetHasDRWDebuff(55095) and NAG:SpellIsReady(77575)) and NAG:Cast(77575) -- Cast Outbreak (77575) during DRW if Frost Fever (55095) not mirrored by DRW
        or (NAG:AuraIsActive(81256) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) <=1)) and NAG:Cast(45529) -- Cast Blood Tap (45529) during DRW if ???1 Death Rune
        or (NAG:AuraIsActive(49028) and NAG:SpellIsReady(48707)) and NAG:Cast(48707) -- Cast Anti-Magic Shell (48707) during DRW
        or (NAG:AuraIsActive(49028) and NAG:CurrentHealthPercent() > 0.5 and NAG:CurrentRuneCount(4) >= 1 and NAG:SpellIsReady(108196) and (function() local base, pos = select(1, UnitAttackPower("player")); local ap = (base and pos) and (base + pos) or 0; local wd = NAG:WeaponDamage() or 0; return (NAG:AuraIsActive(53386) and ap >= 7.07 * wd - 55147) or (not NAG:AuraIsActive(53386) and ap >= 10.1808 * wd - 79351.68) end)()) and NAG:Cast(108196) -- Cast Death Siphon (108196) during DRW with Death Rune if health >50% and attack power threshold met
            or (NAG:AuraIsActive(49028) and NAG:SpellIsReady(49998)) and NAG:Cast(49998) -- Cast Death Strike (49998) during DRW
            or (NAG:AuraIsActive(49028) and NAG:CurrentRunicPower() >= 30 and NAG:SpellIsReady(56815)) and NAG:Cast(56815) -- Cast Rune Strike (56815) during DRW with 30+ Runic Power
            or (NAG:AuraIsActive(49028) and NAG:SpellIsReady(47568) and (NAG:CurrentRuneCount(2) == 0 and NAG:CurrentRuneCount(3) == 0 or NAG:CurrentRuneCount(4) == 0)) and NAG:Cast(47568) -- Cast Empower Rune Weapon (47568) during DRW if no Frost, Unholy, or Death Runes
            or ((select(2, UnitAttackPower("player")) >= (UnitLevel("player") < 60 and 0 or (200 + (UnitLevel("player") - 60) * 300)) or (UnitHealth("player") / UnitHealthMax("player")) < 0.65) and NAG:SpellTimeToReady(49028) <= 0) and NAG:Cast(49028) -- Cast Dancing Rune Weapon (49028) if attack power or health <65% conditions met
            or (NAG:AuraNumStacks(114851) >= 10 and NAG:CurrentRuneCount(1) == 0) and NAG:Cast(45529) -- Cast Blood Tap (45529) with 10+ charges and no Blood Runes
            or (((NAG:IsExecutePhase(35) or (NAG:AuraIsKnown(138347) and NAG:TimeToPercent(45) < 6))) and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(114866)) and NAG:Cast(114866) -- Cast Soul Reaper in execute with T15 extended to 45%, requires Blood Rune
            or (NAG:DotRemainingTime(55095) <= 4 and NAG:DotRemainingTime(55095) > 0 and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(48721) and not NAG:IsExecutePhase(35)) and NAG:Cast(48721) -- Cast Blood Boil (48721) to refresh Frost Fever (55095) if ???4 seconds remain, not in execute
            or (NAG:DotRemainingTime(55095) <= 4 and NAG:DotRemainingTime(55095) > 0 and NAG:CurrentRuneCount(1) >= 2 and NAG:SpellIsReady(48721) and NAG:IsExecutePhase(35)) and NAG:Cast(48721) -- Cast Blood Boil (48721) to refresh Frost Fever (55095) if ???4 seconds remain, in execute with 2 blood runes available
            or (NAG:AuraIsActive(81141) and NAG:IsExecutePhase(35) and NAG:DotRemainingTime(55095) > 0 and NAG:DotRemainingTime(55095) < 4 and NAG:SpellIsReady(48721)) and NAG:Cast(48721) -- Cast Blood Boil (48721) in Execute phase if Crimson Scourge proc to refresh dots
            or (NAG:CurrentRunicPower() >= 40 and NAG:SpellIsReady(47541) and (select(1, UnitAttackPower("player")) + select(2, UnitAttackPower("player")) >= 6.268 * NAG:WeaponDamage() - 4476.92)) and NAG:Cast(47541) -- Cast Death Coil (47541) with 40+ Runic Power if attack power threshold met
            or (NAG:CurrentRunicPower() >= 30 and NAG:SpellIsReady(56815)) and NAG:Cast(56815) -- Cast Rune Strike (56815) with 30+ Runic Power
            or (NAG:SpellIsReady(49998)) and NAG:Cast(49998) -- Cast Death Strike (49998) if ready
            or (NAG:CurrentTime() <= 3.0 and NAG:SpellIsReady(49998)) and NAG:Cast(49998) -- Cast Death Strike (49998) in first 3 seconds of combat
            or (NAG:CurrentTime() <= 3.0 and not NAG:IsExecutePhase(35) and NAG:CountEnemiesInRange(8) <= 2 and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(55050) and (NAG:DotRemainingTime(55095) >= 6 and NAG:SnapshotPercent(55095, "ap") < 0.05 or (NAG:SnapshotPercent(55095, "ap") >= 0.05 and NAG:SpellIsReady(48721)))) and (NAG:SnapshotPercent(55095, "ap") >= 0.05 and NAG:Cast(48721) or NAG:Cast(55050)) -- Cast Blood Boil (48721) or Heart Strike (55050) in first 3 seconds, ???2 enemies, with Frost Fever snapshot conditions
            or (NAG:CurrentHealthPercent() > 0.5 and NAG:CurrentRuneCount(1) >= 1 and NAG:DotRemainingTime(55095) > 0 and not NAG:IsExecutePhase(35) and NAG:SpellIsReady(48721) and (NAG:DotRemainingTime(55095) <= 4 or NAG:SnapshotPercent(55095, "ap") >= 0.1)) and NAG:Cast(48721) -- Casts Blood Boil outside of crimson scourge proc to increase AP snapshot of diseases outside of Execute Range.
            or (NAG:CurrentHealthPercent() > 0.5 and NAG:CurrentRuneCount(1) >= 1 and NAG:DotRemainingTime(55095) > 0 and NAG:IsExecutePhase(35) and NAG:TimeToPercent(1) < 10 and NAG:SpellIsReady(48721) and (NAG:DotRemainingTime(55095) <= 4 or NAG:SnapshotPercent(55095, "ap") >= 0.1)) and NAG:Cast(48721) -- Casts Blood Boil to maintain disease uptime if in execute phase.
            or (NAG:CurrentHealthPercent() > 0.2 and NAG:CurrentRuneCount(1) >= 1 and NAG:DotRemainingTime(55095) > 6 and not NAG:IsExecutePhase(35) and not (NAG:AuraIsKnown(138347) and NAG:TimeToPercent(45) < 6) and NAG:SpellIsReady(55050) and NAG:SnapshotPercent(55095, "ap") <= 0.1) and NAG:Cast(55050) -- Cast Heart Strike
            or (NAG:IsExecutePhase(35) and NAG:CurrentRuneCount(1) >= 2 and NAG:SpellTimeToReady(114866) > 2 and NAG:SpellIsReady(55050)) and NAG:Cast(55050) -- Soul Reaper Parry Rune Refund Check to use Heath Strike(55050)
            or (not NAG:AuraIsActive(49028)) and NAG:Cast(57330) -- Cast Horn of Winter (57330) if DRW inactive
            or (NAG:CurrentRunicPower() >= 20 and not NAG:IsReadySpell(108196) and NAG:CurrentRunicPower() < 30 and NAG:Cast(56815, 10)) -- Cast Rune Strike (56815) with 20-29 Runic Power if Death Siphon unavailable
            or NAG:SpellIsKnown(108196) and ((NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy)) or (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy)) or (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftUnholy) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy)) or (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightUnholy) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy))) and (((NAG:AuraIsActive(49028) and NAG:CurrentHealthPercent() > 0.5 and (function() local base, pos = select(1, UnitAttackPower("player")); local ap = (base and pos) and (base + pos) or 0; local wd = NAG:WeaponDamage() or 0; return (NAG:AuraIsActive(53386) and ap >= 7.07 * wd - 55147) or (not NAG:AuraIsActive(53386) and ap >= 10.1808 * wd - 79351.68) end)())) or (NAG:CurrentHealthPercent() > 0.5 and (function() local base, pos = select(1, UnitAttackPower("player")); local ap = (base and pos) and (base + pos) or 0; local wd = NAG:WeaponDamage() or 0; return (NAG:AuraIsActive(53386) and ap >= 7.07 * wd - 55147) or (not NAG:AuraIsActive(53386) and ap >= 10.1808 * wd - 79351.68) end)())) and NAG:Cast(108196, 10) -- Cast Death Siphon (108196) with specific Death Rune slot if health >50% and attack power threshold met
                    or NAG:Cast(49998, 10) -- Cast Death Strike (49998) as fallback


    ]],


    -- Tracked IDs for optimization
    spells = {45529, 46584, 47568, 48721, 48743, 48792, 48982, 49222, 49998, 55050, 55078, 55095, 55233, 56815, 57330, 77535, 77575, 81141, 81256, 82176, 96171},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {104049, 104048, 43826, 104101, 43550, 43672},
    author = "@Headrippa",

}





local BloodDPSwcomments4pcT15 = {
    -- Core identification
    name = "Blood DPS w/comments 4pcT15",
    specIndex = 1,
    class = "DEATHKNIGHT",

    -- Required parameters
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    rotationType = ns.ROTATION_TYPES.SINGLE_TARGET,
    enableSmartSwitching = false,

    -- Custom conditions for smart switching
    customConditions = {
        {
            type = ns.CUSTOM_CONDITION_TYPES.TARGET_COUNT,
            value = { min = 1, max = 3, operator = "range" },  -- Optimal for 1-3 targets
            range = 8  -- Use 8-yard range for precise target counting
        }
    },

    prePull = {
        { time = -31.0, action = "NAG:Cast(48263)" },
        { time = -30.0, action = "NAG:Cast(49222)" },
        { time = -7.0, action = "NAG:Cast(42650)" },
        { time = -1.5, action = "NAG:Cast(57330)" },
        { time = -1.0, action = "NAG:Cast(76095)" }
    },
    lastModified = "12/20/2025",
    rotationString = [[

(not NAG:AuraIsActive(49222)) and NAG:Cast(49222) -- Apply Bone Shield if not active
or (NAG:CountEnemiesInRange(8) >= 4) and NAG:SelectRotation("Blood AOE w/comments 4pcT15") -- Switch to Blood AOE rotation if 4+ enemies within 8 yards
or (not NAG:AuraIsActive(48263)) and NAG:Cast(48263) -- Apply Blood Presence if not active
or ((UnitHealth("player") / UnitHealthMax("player")) <= 0.4 and (NAG:CurrentRuneCount(2) >= 1 and NAG:CurrentRuneCount(3) >= 1 or NAG:CurrentRuneCount(4) >= 2) and NAG:SpellIsReady(49998)) and NAG:Cast(49998) -- If health ???40%, checks for Frost + Unholy Runes or 2 Death Runes and casts Death Strike (49998) if ready
or (((NAG:IsExecutePhase(35) or NAG:TimeToPercent(35) < 6) or (NAG:AuraIsKnown(138347) and NAG:TimeToPercent(45) < 6)) and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(114866)) and NAG:Cast(114866) -- Cast Soul Reaper (114866) in execute phase (<35% or approaching within 6 sec), extended to 45% with T15 2P (aura 138347), requires Blood Rune
or (NAG:CurrentHealthPercent() > 0.5 and NAG:CurrentRuneCount(4) >= 1 and NAG:SpellIsReady(108196) and (function() local base, pos = select(1, UnitAttackPower("player")); local ap = (base and pos) and (base + pos) or 0; local wd = NAG:WeaponDamage() or 0; return (NAG:AuraIsActive(53386) and ap >= 7.07 * wd - 55147) or (not NAG:AuraIsActive(53386) and ap >= 10.1808 * wd - 79351.68) end)()) and NAG:Cast(108196) -- If health >50% and 1 Death Rune available, checks AP threshold scaled with weapon damage, considering Cinderglacier proc and casts Death Siphon (108196) if it's higher damage than Death Strike
    or ((NAG:DotRemainingTime(55095) <= 0 or NAG:DotRemainingTime(55078) <= 0) and NAG:SpellIsReady(77575)) and NAG:Cast(77575) -- If Frost Fever (55095) or Blood Plague (55078) is missing, casts Outbreak (77575) if ready
    or (NAG:AuraIsActive(81141) and not NAG:AuraIsActive(49028) and NAG:SpellIsReady(43265)) and NAG:Cast(43265) -- If Crimson Scourge (81141) proc is active and DRW (49028) is not, casts Death and Decay (43265) if ready
    or (NAG:AuraIsActive(53386) and NAG:CountEnemiesInRange(10) >= 2 and not NAG:AuraIsActive(49028) and not NAG:IsExecutePhase(35) and NAG:SpellTimeToReady(43265) <= 0) and NAG:Cast(43265) -- If Cinderglacier (53386) is active, 2+ enemies within 10 yards, DRW inactive, not in execute, and Death and Decay cooldown ???0, casts Death and Decay (43265)
    or (NAG:AuraIsActive(81141) and not NAG:AuraIsActive(49028) and NAG:SpellTimeToReady(43265) > 5 and NAG:DotRemainingTime(55095) > 0 and (function() local base, pos = select(1, UnitAttackPower("player")); local ap = (base and pos) and (base + pos) or 0; return ap >= NAG:Snapshot("ap", 55095) end)() and NAG:SpellIsReady(48721)) and NAG:Cast(48721) -- If Crimson Scourge proc active, DRW inactive, Death and Decay cooldown >5, Frost Fever active, AP snapshot met, and Blood Boil (48721) ready, casts Blood Boil (48721)
        or (NAG:AuraIsActive(49028) and (((NAG:IsExecutePhase(35) or NAG:TimeToPercent(35) < 6) or (NAG:AuraIsKnown(138347) and NAG:TimeToPercent(45) < 6))) and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(114866)) and NAG:Cast(114866) -- Cast Soul Reaper during DRW with T15 extended to 45% if approaching, requires Blood Rune
        or (NAG:AuraIsActive(49028) and NAG:DotIsActive(55095) and not NAG:TargetHasDRWDebuff(55095) and NAG:SpellIsReady(77575)) and NAG:Cast(77575) -- If DRW active, Frost Fever active, but not mirrored by DRW, casts Outbreak (77575)
        or (NAG:AuraIsActive(81256) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) <=1)) and NAG:Cast(45529) -- If Dancing Rune Blade (81256) active and ???1 Death Rune, casts Blood Tap (45529) (rune conversion during DRW)
        or (NAG:AuraIsActive(49028) and NAG:CountEnemiesInRange(8) >= 2 and NAG:DotRemainingTime(55095) > 0 and NAG:DotRemainingTime(55078) > 0 and NAG:TargetHasDRWDebuff(55095) and NAG:TargetHasDRWDebuff(55078) and NAG:NumberTargetsWithDRWDebuff(55095, 8) < NAG:CountEnemiesInRange(8) and NAG:CurrentHealthPercent() > 0.4 and not NAG:IsExecutePhase(35) and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(50842)) and NAG:Cast(50842) -- If DRW active, diseases active and mirrored on target, but not all enemies have DRW diseases, health >40%, not in execute, and Blood Rune available, casts Pestilence (50842) (spread DRW diseases to multi-target)
        or (NAG:AuraIsActive(49028) and NAG:SpellIsReady(48707)) and NAG:Cast(48707) -- If DRW active, casts Anti-Magic Shell (48707) (Rune Power generation cooldown during DRW)
        or (NAG:AuraIsActive(49028) and NAG:CurrentHealthPercent() > 0.5 and NAG:CurrentRuneCount(4) >= 1 and NAG:SpellIsReady(108196) and (function() local base, pos = select(1, UnitAttackPower("player")); local ap = (base and pos) and (base + pos) or 0; local wd = NAG:WeaponDamage() or 0; return (NAG:AuraIsActive(53386) and ap >= 7.07 * wd - 55147) or (not NAG:AuraIsActive(53386) and ap >= 10.1808 * wd - 79351.68) end)()) and NAG:Cast(108196) -- If DRW active, health >50%, 1 Death Rune available, and AP threshold met, casts Death Siphon (108196) (DPS optimization during DRW).
            or (NAG:AuraIsActive(49028) and NAG:SpellIsReady(49998)) and NAG:Cast(49998) -- If DRW active, casts Death Strike (49998) (survival and damage during DRW)
            or (NAG:AuraIsActive(49028) and NAG:CurrentRunicPower() >= 30 and NAG:SpellIsReady(56815)) and NAG:Cast(56815) -- If DRW active and 30+ Runic Power, casts Rune Strike (56815) (RP dump during DRW)
            or (NAG:AuraIsActive(49028) and NAG:SpellIsReady(47568) and (NAG:CurrentRuneCount(2) == 0 and NAG:CurrentRuneCount(3) == 0 or NAG:CurrentRuneCount(4) == 0)) and NAG:Cast(47568) -- If DRW active and no Frost, Unholy, or Death Runes, casts Empower Rune Weapon (47568) (rune refresh during DRW)
            or (NAG:AuraIsActive(49028) and NAG:CountEnemiesInRange(10) >= 4 and NAG:CurrentHealthPercent() > 0.4 and NAG:DotRemainingTime(55095) > 0 and not NAG:IsExecutePhase(35) and NAG:SpellIsReady(48721) and (NAG:DotRemainingTime(55095) <= 4 or NAG:SnapshotPercent(55095, "ap") >= 0)) and NAG:Cast(48721) -- If DRW active, 4+ enemies within 10 yards, health >40%, Frost Fever active, not in execute, and disease refresh needed, casts Blood Boil (48721) (AOE damage during DRW)
            or ((select(2, UnitAttackPower("player")) >= (UnitLevel("player") < 60 and 0 or (200 + (UnitLevel("player") - 60) * 300)) or (UnitHealth("player") / UnitHealthMax("player")) < 0.65) and NAG:SpellTimeToReady(49028) <= 0) and NAG:Cast(49028) -- Cast Dancing Rune Weapon (49028) if attack power or health <65% conditions met
            or (NAG:AuraNumStacks(114851) >= 10 and NAG:CurrentRuneCount(1) == 0) and NAG:Cast(45529) -- Cast Blood Tap (45529) with 10+ charges and no Blood Runes
            or (((NAG:IsExecutePhase(35) or (NAG:AuraIsKnown(138347) and NAG:TimeToPercent(45) < 6))) and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(114866)) and NAG:Cast(114866) -- Cast Soul Reaper in execute with T15 extended to 45% if approaching, requires Blood Rune
            or (NAG:IsExecutePhase(35) and not NAG:SpellIsKnown(114866) and NAG:CurrentRunicPower() >= 30 and NAG:SpellIsReady(56815)) and NAG:Cast(56815) -- Cast Rune Strike (56815) in execute if Soul Reaper unknown with 30+ Runic Power
            or (NAG:IsExecutePhase(35) and not NAG:SpellIsKnown(114866) and NAG:CurrentRuneCount(4) >= 1 and NAG:SpellIsReady(49998)) and NAG:Cast(49998) -- Cast Death Strike (49998) in execute if Soul Reaper unknown with Death Rune
            or (NAG:IsExecutePhase(35) and not NAG:SpellIsKnown(114866) and NAG:CurrentRuneCount(1) >= 1 and NAG:CurrentHealthPercent() > 0.4 and NAG:CountEnemiesInRange(8) >= 2 and NAG:DotRemainingTime(55078) <= 4 and NAG:SpellIsReady(48721)) and NAG:Cast(48721) -- Cast Blood Boil (48721) in execute if Soul Reaper unknown, 2+ enemies, and Blood Plague (55078) needs refresh
            or (NAG:DotRemainingTime(55095) <= 4 and NAG:DotRemainingTime(55095) > 0 and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(48721) and not NAG:IsExecutePhase(35)) and NAG:Cast(48721) -- Cast Blood Boil (48721) to refresh Frost Fever (55095) if ???4 seconds remain, not in execute
            or (NAG:AuraIsActive(81141) and NAG:IsExecutePhase(35) and NAG:DotRemainingTime(55095) > 0 and NAG:DotRemainingTime(55095) < 5 and NAG:SpellIsReady(48721)) and NAG:Cast(48721) -- Cast Blood Boil (48721) in Execute phase if Crimson Scourge proc to refresh dots
            or (NAG:IsExecutePhase(35) and not NAG:SpellIsKnown(114866) and NAG:CountEnemiesInRange(8) <= 2 and NAG:CurrentRuneCount(1) >= 1 and NAG:CurrentRuneCount(2) == 0 and NAG:CurrentRuneCount(3) == 0 and NAG:CurrentRuneCount(4) == 0 and NAG:SpellIsReady(55050) and (NAG:DotRemainingTime(55095) >= 6 and NAG:SnapshotPercent(55095, "ap") < 0.05 or (NAG:SnapshotPercent(55095, "ap") >= 0.05 and NAG:SpellIsReady(48721)))) and (NAG:SnapshotPercent(55095, "ap") >= 0.05 and NAG:Cast(48721) or NAG:Cast(55050)) -- Cast Blood Boil (48721) or Heart Strike (55050) in execute if Soul Reaper unknown, ???2 enemies, and Frost Fever snapshot conditions met
            or (not NAG:AuraIsActive(49028) and NAG:CountEnemiesInRange(8) >= 2 and NAG:CountEnemiesInRange(8) <= 3 and NAG:DotRemainingTime(55095) > 0 and NAG:NumberTargetsWithDebuff(55095, 8) < NAG:CountEnemiesInRange(8) and NAG:CurrentHealthPercent() > 0.4 and not NAG:IsExecutePhase(35) and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(48721)) and NAG:Cast(48721) -- Cast Blood Boil (48721) to spread Frost Fever (55095) if 2-3 enemies, Frost Fever active, and not in execute
            or (NAG:CurrentRunicPower() >= 40 and NAG:SpellIsReady(47541) and (select(1, UnitAttackPower("player")) + select(2, UnitAttackPower("player")) >= 6.268 * NAG:WeaponDamage() - 4476.92)) and NAG:Cast(47541) -- Cast Death Coil (47541) with 40+ Runic Power if attack power threshold met
            or (NAG:CurrentRunicPower() >= 30 and NAG:SpellIsReady(56815)) and NAG:Cast(56815) -- Cast Rune Strike (56815) with 30+ Runic Power
            or (NAG:SpellIsReady(49998)) and NAG:Cast(49998) -- Cast Death Strike (49998) if ready
            or (NAG:CountEnemiesInRange(8) >= 4 and NAG:CurrentHealthPercent() > 0.4 and NAG:DotRemainingTime(55095) > 0 and not NAG:IsExecutePhase(35) and NAG:SpellIsReady(48721)) and NAG:Cast(48721) -- Cast Blood Boil (48721) if 4+ enemies, health >40%, Frost Fever active, and not in execute
            or (NAG:CurrentTime() <= 3.0 and NAG:SpellIsReady(49998)) and NAG:Cast(49998) -- Cast Death Strike (49998) in first 3 seconds of combat
            or (NAG:CurrentTime() <= 3.0 and not NAG:IsExecutePhase(35) and NAG:CountEnemiesInRange(8) <= 2 and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(55050) and (NAG:DotRemainingTime(55095) >= 6 and NAG:SnapshotPercent(55095, "ap") < 0.05 or (NAG:SnapshotPercent(55095, "ap") >= 0.05 and NAG:SpellIsReady(48721)))) and (NAG:SnapshotPercent(55095, "ap") >= 0.05 and NAG:Cast(48721) or NAG:Cast(55050)) -- Cast Blood Boil (48721) or Heart Strike (55050) in first 3 seconds, ???2 enemies, with Frost Fever snapshot conditions
            or (NAG:CurrentTime() <= 3.0 and NAG:IsExecutePhase(35) and NAG:CountEnemiesInRange(8) <= 2 and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(55050) and (NAG:DotRemainingTime(55095) >= 6 and NAG:SnapshotPercent(55095, "ap") < 0.35 or (NAG:SnapshotPercent(55095, "ap") >= 0.35 and NAG:SpellIsReady(48721)))) and (NAG:SnapshotPercent(55095, "ap") >= 0.35 and NAG:Cast(48721)) -- Cast Blood Boil (48721) in first 3 seconds, in execute, ???2 enemies, with Frost Fever snapshot conditions
            or (NAG:CountEnemiesInRange(8) >= 3 and not NAG:IsExecutePhase(35) and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(48721) and (NAG:DotRemainingTime(55095) <= 4 or NAG:SnapshotPercent(55095, "ap") >= 0)) and NAG:Cast(48721) -- Cast Blood Boil (48721) if 3+ enemies, not in execute, and Frost Fever needs refresh or snapshot met
            or (NAG:CountEnemiesInRange(8) >= 3 and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(55050) and not NAG:IsExecutePhase(35) and NAG:DotRemainingTime(55095) >= 6 and NAG:SnapshotPercent(55095, "ap") < 0) and NAG:Cast(55050) -- Cast Heart Strike (55050) if 3+ enemies, not in execute, with Frost Fever snapshot conditions
            or (NAG:CountEnemiesInRange(8) <= 2 and NAG:CurrentRuneCount(1) >= 1 and NAG:SpellIsReady(55050) and not NAG:IsExecutePhase(35) and (NAG:DotRemainingTime(55095) >= 6 and NAG:SnapshotPercent(55095, "ap") < 0.05 or (NAG:SnapshotPercent(55095, "ap") >= 0.05 and NAG:SpellIsReady(48721)))) and (NAG:SnapshotPercent(55095, "ap") >= 0.05 and NAG:Cast(48721) or NAG:Cast(55050)) -- Cast Blood Boil (48721) or Heart Strike (55050) if ???2 enemies, not in execute, with Frost Fever snapshot conditions
            or (NAG:IsExecutePhase(35) and NAG:CurrentRuneCount(1) >= 2 and NAG:SpellTimeToReady(114866) > 2 and NAG:SpellIsReady(55050)) and NAG:Cast(55050) -- Soul Reaper Parry Rune Refund Check to use Heart Strike (55050)
            or (not NAG:AuraIsActive(49028)) and NAG:Cast(57330) -- Cast Horn of Winter (57330) if DRW inactive
            or (NAG:CurrentRunicPower() >= 20 and not NAG:IsReadySpell(108196) and NAG:CurrentRunicPower() < 30 and NAG:Cast(56815, 10)) -- Cast Rune Strike (56815) with 20-29 Runic Power if Death Siphon unavailable
            or NAG:SpellIsKnown(108196) and ((NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy)) or (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy)) or (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftUnholy) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy)) or (NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightUnholy) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightFrost) and NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightUnholy) <= NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotLeftUnholy))) and (((NAG:AuraIsActive(49028) and NAG:CurrentHealthPercent() > 0.5 and (function() local base, pos = select(1, UnitAttackPower("player")); local ap = (base and pos) and (base + pos) or 0; local wd = NAG:WeaponDamage() or 0; return (NAG:AuraIsActive(53386) and ap >= 7.07 * wd - 55147) or (not NAG:AuraIsActive(53386) and ap >= 10.1808 * wd - 79351.68) end)())) or (NAG:CurrentHealthPercent() > 0.5 and (function() local base, pos = select(1, UnitAttackPower("player")); local ap = (base and pos) and (base + pos) or 0; local wd = NAG:WeaponDamage() or 0; return (NAG:AuraIsActive(53386) and ap >= 7.07 * wd - 55147) or (not NAG:AuraIsActive(53386) and ap >= 10.1808 * wd - 79351.68) end)())) and NAG:Cast(108196, 10) -- Look ahead for Death Siphon
                    or NAG:Cast(49998, 10) -- Look ahead for Death Strike
    ]],


    -- Tracked IDs for optimization
    spells = {45529, 46584, 47568, 48721, 48743, 48792, 48982, 49222, 49998, 55050, 55078, 55095, 55233, 56815, 57330, 77535, 77575, 81141, 81256, 82176, 96171},
    items = {},
    auras = {},
    runes = {},

    -- Optional metadata
    glyphs = {104049, 104048, 43826, 104101, 43550, 43672},
    author = "@Headrippa",

}







--- @class DEATHKNIGHT : ClassBase
--- Slash command /festerblight is registered on main NAG addon (NAG.lua) for reliable availability.
local DEATHKNIGHT = NAG:CreateClassModule("DEATHKNIGHT", defaults)

function DEATHKNIGHT:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 2, frostMasterfrogDarkfrog)  -- Frost
    ns.AddRotationToDefaults(self.defaults, 2, frostMasterfrogRotationUPDATED)  -- Frost
    ns.AddRotationToDefaults(self.defaults, 2, frost2HDarkfrog)  -- Frost
    ns.AddRotationToDefaults(self.defaults, 2, frost2HDarkfrogAOE)  -- Frost
    ns.AddRotationToDefaults(self.defaults, 2, frostMasterfrogDarkfrogAOE)  -- Frost
    --ns.AddRotationToDefaults(self.defaults, 1, bloodSTHeadrippa)  -- Blood
    --ns.AddRotationToDefaults(self.defaults, 1, bloodAOEHeadrippa)  -- Blood
    ns.AddRotationToDefaults(self.defaults, 3, unholySTDiurdussyRotation)  -- Unholy
    ns.AddRotationToDefaults(self.defaults, 3, unholyFesterblight)  -- Unholy Festerblight
    --ns.AddRotationToDefaults(self.defaults, 2, frostMasterfrogDarkfrogAOE)  -- Frost
    --ns.AddRotationToDefaults(self.defaults, 1, bloodSTONLYHeadrippa)  -- Blood
    --ns.AddRotationToDefaults(self.defaults, 3, unholyGroupRotation)  -- Unholy
    ns.AddRotationToDefaults(self.defaults, 1, BloodDPSwcomments4pcT15)
    ns.AddRotationToDefaults(self.defaults, 1, BloodST4pcT15)
    ns.AddRotationToDefaults(self.defaults, 1, BloodAOEwcomments4pcT15)
end


-- Register Death Knight specific spell tracking
function DEATHKNIGHT:RegisterSpellTracking()
    if not SpellTracker then return end

    -- Track Death Knight specific mechanics
    SpellTracker:RegisterCastTracking({ 77575 }, { count = 0, startTime = GetTime() }) -- Outbreak
    SpellTracker:RegisterPeriodicDamage({ 55078 }, { tickTime = nil, lastTickTime = nil }) -- Blood Plague
    SpellTracker:RegisterPeriodicDamage({ 55095 }, { tickTime = nil, lastTickTime = nil }) -- Frost Fever
end

-- ============================ SLASH COMMANDS ============================
--- Toggle between Festerblight and Unholy rotations for Unholy spec.
--- First press selects Festerblight, second press selects Unholy.
function DEATHKNIGHT:HandleFesterblightCommand()
    local UNHOLY_SPEC = 3
    local current = self:GetSelectedRotation(UNHOLY_SPEC)
    local nextRotation = (current == "Festerblight") and "Unholy" or "Festerblight"
    self:SelectRotation(UNHOLY_SPEC, nextRotation)
end

NAG.Class = DEATHKNIGHT
