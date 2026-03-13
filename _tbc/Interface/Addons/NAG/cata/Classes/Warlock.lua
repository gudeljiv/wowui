local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
local GetTime = _G.GetTime
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
        id = "curse_of_elements",
        name = "Curse of the Elements",
        description = "Apply magic vulnerability debuff (coordinate with other Warlocks - only one curse per target)",
        spellIds = {1490, 11721, 11722, 27228, 47865}, -- All ranks (Cata uses rank 5)
        category = "debuff",
    },
    {
        id = "curse_of_weakness",
        name = "Curse of Weakness",
        description = "Reduce target's physical damage output (coordinate with other Warlocks - only one curse per target)",
        spellIds = {702}, -- Curse of Weakness
        category = "debuff",
    },
    {
        id = "curse_of_tongues",
        name = "Curse of Tongues",
        description = "Increase enemy casting time (coordinate with other Warlocks - only one curse per target)",
        spellIds = {1714}, -- Curse of Tongues
        category = "debuff",
    },
}

-- Add spec-level spell locations to defaults
defaults.class.specSpellLocations = {
    [1] = {  -- Affliction
        [1454] = NAG.SPELL_POSITIONS.ABOVE, [28176] = NAG.SPELL_POSITIONS.ABOVE, [80398] = NAG.SPELL_POSITIONS.ABOVE,
        [691] = NAG.SPELL_POSITIONS.BELOW,
        [47897] = NAG.SPELL_POSITIONS.RIGHT, [27243] = NAG.SPELL_POSITIONS.RIGHT, [74434] = NAG.SPELL_POSITIONS.RIGHT,
        [77801] = NAG.SPELL_POSITIONS.LEFT, [18540] = NAG.SPELL_POSITIONS.LEFT, [33702] = NAG.SPELL_POSITIONS.LEFT,
        [26297] = NAG.SPELL_POSITIONS.LEFT, [86121] = NAG.SPELL_POSITIONS.LEFT
    },
    [2] = {  -- Demonology
        [1454] = NAG.SPELL_POSITIONS.ABOVE, [28176] = NAG.SPELL_POSITIONS.ABOVE, [80398] = NAG.SPELL_POSITIONS.ABOVE,
        [30146] = NAG.SPELL_POSITIONS.BELOW, [691] = NAG.SPELL_POSITIONS.BELOW,
        [47897] = NAG.SPELL_POSITIONS.RIGHT, [50589] = NAG.SPELL_POSITIONS.RIGHT, [1122] = NAG.SPELL_POSITIONS.RIGHT,
        [89751] = NAG.SPELL_POSITIONS.RIGHT, [1949] = NAG.SPELL_POSITIONS.RIGHT,
        [77801] = NAG.SPELL_POSITIONS.LEFT, [47241] = NAG.SPELL_POSITIONS.LEFT, [74434] = NAG.SPELL_POSITIONS.LEFT,
        [18540] = NAG.SPELL_POSITIONS.LEFT, [33702] = NAG.SPELL_POSITIONS.LEFT, [26297] = NAG.SPELL_POSITIONS.LEFT
    },
    [3] = {  -- Destruction
        [1454] = NAG.SPELL_POSITIONS.ABOVE, [28176] = NAG.SPELL_POSITIONS.ABOVE, [80398] = NAG.SPELL_POSITIONS.ABOVE,
        [688] = NAG.SPELL_POSITIONS.BELOW,
        [47897] = NAG.SPELL_POSITIONS.RIGHT, [1122] = NAG.SPELL_POSITIONS.RIGHT, [5740] = NAG.SPELL_POSITIONS.RIGHT,
        [77801] = NAG.SPELL_POSITIONS.LEFT, [18540] = NAG.SPELL_POSITIONS.LEFT, [74434] = NAG.SPELL_POSITIONS.LEFT,
        [33702] = NAG.SPELL_POSITIONS.LEFT, [26297] = NAG.SPELL_POSITIONS.LEFT
    }
}

-- Affliction Rotation
local afflictionRotation = {
    name = "Cataclysm Affliction - by @Repikas",
    specIndex = 1,
    class = "WARLOCK",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = false,
    prePull = {
        { time = -10, action = "NAG:Cast(691)" },
        { time = -4.0, action = "NAG:Cast(NAG:GetBattlePotion())" },
        { time = -3.0, action = "NAG:Cast(686)" },
        { time = -0.8, action = "NAG:Cast(48181)" }
    },
    macros = {
        { name = "Shadowbolt", body = "#showtooltip\n/cast Shadow Bolt\n/petattack" },
        { name = "Incinerate", body = "#showtooltip\n/cast Shadow Bolt\n/petattack" },
        { name = "Soul Fire",  body = "#showtooltip\n/cast Shadow Bolt\n/petattack" }
    },
    rotationString = [[
        NAG:SpellCastSequence()
        or NAG:AutocastOtherCooldowns()
        or (((NAG:CurrentManaPercent() < 0.15) and (NAG:CurrentHealthPercent() > 0.15)) and NAG:Cast(1454))
        or NAG:Cast(691)
        or ((not NAG:IsActive(28176)) and NAG:Cast(28176))
        or ((not NAG:IsActive(80398)) and NAG:Cast(80398))
        or ((NAG:CurrentTime() < 10) and NAG:Cast(82174))
        or ((NAG:CurrentTime() < 10) and NAG:Cast(33697))
        or ((NAG:CurrentTime() < 10) and NAG:Cast(77801))
        or ((NAG:CurrentTime() < 10) and NAG:Cast(58091))
        or (((NAG:RemainingTime() > 71) or NAG:IsExecutePhase(25)) and NAG:Cast(82174))
        or (((NAG:RemainingTime() > 136) or NAG:IsExecutePhase(25)) and NAG:Cast(33697))
        or (((NAG:RemainingTime() > 141) or NAG:IsExecutePhase(25)) and NAG:Cast(77801))
        or (((NAG:RemainingTime() <= 26) or NAG:IsExecutePhase(25)) and NAG:Cast(58091))
        or (((NAG:IsActive(74241) or (NAG:AuraRemainingTime(96230) < 2)) and (NAG:IsActive(89091) or (NAG:AuraRemainingTime(96230) < 2)) and NAG:DotIsActive(603)) and NAG:Cast(18540))
        or ((NAG:IsReady(47897) and (NAG:UnitDistance("target") < 11.0) and (NAG:NumberTargets() >= 2.0)) and NAG:Cast(47897))
        or ((NAG:IsReady(74434) and (NAG:UnitDistance("target") < 11.0) and (NAG:NumberTargets() >= 3.0)) and NAG:Cast(74434))
        or ((NAG:IsActive(74434) and (NAG:UnitDistance("target") < 11.0) and (NAG:NumberTargets() >= 3.0)) and NAG:Cast(27243))
        or (((NAG:UnitDistance("target") < 11.0) and (NAG:NumberTargets() >= 6.0)) and NAG:Cast(27243))
        or (((NAG:DotRemainingTime(172) < NAG:DotTickFrequency(172)) and NAG:UnitIsMoving()) and NAG:Cast(172))
        or (((NAG:DotRemainingTime(603) < NAG:DotTickFrequency(603)) and NAG:UnitIsMoving()) and NAG:Cast(603))
        or ((NAG:IsReady(47897) and NAG:UnitIsMoving() and (NAG:UnitDistance("target") < 11.0)) and NAG:Cast(47897))
        or ((NAG:IsActive(17941) and NAG:UnitIsMoving()) and NAG:Cast(686))
        or (((NAG:CurrentManaPercent() < 0.40) and NAG:UnitIsMoving() and (NAG:CurrentHealthPercent() > 0.15)) and NAG:Cast(1454))
        or (NAG:UnitIsMoving() and NAG:Cast(77799))
        or ((NAG:DotRemainingTime(172) < NAG:DotTickFrequency(172)) and NAG:Cast(172))
        or ((NAG:DotRemainingTime(30108) < NAG:DotTickFrequency(30108)) and NAG:MultiDot(30108, 1, 0.0))
        or (NAG:SpellCanCast(48181) and NAG:Cast(48181))
        or (((NAG:CurrentManaPercent() < 0.15) and (not NAG:IsExecutePhase(25)) and (NAG:CurrentHealthPercent() > 0.15)) and NAG:Cast(1454))
        or (((not NAG:DotIsActive(603)) and (not NAG:DotIsActive(980))) and NAG:MultiDot(603, 1, 0.0))
        or (NAG:IsActive(89937) and NAG:Cast(77799))
        or (NAG:IsExecutePhase(25) and NAG:ChannelSpell(1120, function() return (NAG:IsActive(89937) or NAG:IsReady(48181) or (NAG:DotRemainingTime(172) < NAG:DotTickFrequency(172)) or (NAG:DotRemainingTime(30108) < (NAG:DotTickFrequency(30108) + NAG:SpellCastTime(30108))) or NAG:IsReady(82174) or NAG:IsReady(77801) or NAG:IsReady(33697) or NAG:IsReady(18540) or (not NAG:DotIsActive(603))) end, true))
        or ((NAG:IsReady(47897) and (NAG:UnitDistance("target") < 11.0)) and NAG:Cast(47897))
        or ((NAG:IsReady(86121) and (NAG:NumberTargets() >= 2.0) and (NAG:UnitDistance("target") < 11.0)) and NAG:Cast(86121))
        or ((NAG:IsReady(74434) and (not NAG:IsActive(2825)) and (NAG:NumberTargets() <= 2.0)) and NAG:Cast(74434))
        or (NAG:IsActive(74434) and NAG:Cast(6353))
        or NAG:Cast(686)
        or NAG:Cast(1454)
]]
}

-- Demonology Shadowbolt Rotation
local demonologyShadowboltRotation = {
    name = "Cataclysm Demonology Shadowbolt - by @Repikas",
    specIndex = 2,
    class = "WARLOCK",
    default = false,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = false,
    prePull = {
        { time = -10, action = "NAG:Cast(30146)" },
        { time = -4.0, action = "NAG:Cast(77801)" },
        { time = -4.0, action = "NAG:Cast(74434)" },
        { time = -4.0, action = "NAG:Cast(691)" },
        { time = -2.5, action = "NAG:Cast(NAG:GetBattlePotion())" },
        { time = -2.5, action = "NAG:Cast(47241)" },
        { time = -2.5, action = "NAG:Cast(686)" },
        { time = -0.7, action = "NAG:Cast(348)" }
    },
    macros = {
        { name = "Demon Soul",    body = "#showtooltip\n/cast Demon Soul\n/cast Soulburn\n/cast Summon Felhunter" },
        { name = "Metamorphosis", body = "#showtooltip\n/cast Metamorphosis\n/cast Blood Fury\n/cast Berserking\n/use Volcanic Potion" },
        { name = "Shadowbolt",    body = "#showtooltip\n/cast Shadow Bolt\n/petattack" },
        { name = "Incinerate",    body = "#showtooltip\n/cast Shadow Bolt\n/petattack" },
        { name = "Soul Fire",     body = "#showtooltip\n/cast Shadow Bolt\n/petattack" }
    },
    rotationString = [[
        NAG:SpellCastSequence()
        or NAG:AutocastOtherCooldowns()
        or (((NAG:CurrentManaPercent() < 0.15) and (NAG:CurrentHealthPercent() > 0.15)) and NAG:Cast(1454))
        or (((NAG:UnitDistance("target") < 11.0) and NAG:IsReady(89751)) and NAG:Cast(89751))
        or (((NAG:TimeToReady(77801) > 40) and (NAG:IsActive(79462) or NAG:IsActive(79460)) and (not NAG:IsReady(89751))) and NAG:Cast(691))
        or ((not NAG:IsActive(28176)) and NAG:Cast(28176))
        or ((not NAG:IsActive(80398)) and NAG:Cast(80398))
        or ((NAG:SpellCanCast(77801) and NAG:SpellCanCast(74434) and NAG:SpellCanCast(47241)) and NAG:Cast(77801))
        or (((NAG:IsActive(79462) or NAG:IsActive(79460)) and NAG:SpellCanCast(74434) and NAG:SpellCanCast(47241)) and NAG:Cast(74434))
        or (((NAG:IsActive(79462) or NAG:IsActive(79460)) and NAG:IsActive(74434) and NAG:SpellCanCast(47241)) and NAG:Cast(691))
        or (((NAG:IsActive(79462) or NAG:IsActive(79460)) and NAG:SpellCanCast(47241)) and NAG:Cast(47241))
        or (NAG:IsActive(47241) and NAG:Cast(82174))
        or (NAG:IsActive(47241) and NAG:Cast(33697))
        or ((NAG:DotIsActive(603) and NAG:IsActive(47241) and (NAG:IsActive(74241) or (NAG:AuraRemainingTime(96230) < 2)) and (NAG:IsActive(89091) or (NAG:AuraRemainingTime(96230) < 2))) and NAG:Cast(18540))
        or ((NAG:TimeToReady(77801) >= 50) and NAG:Cast(82174))
        or (NAG:IsActive(47241) and NAG:Cast(58091))
        or (((NAG:CurrentManaPercent() <= 0.70) and ((NAG:TimeToReady(77801) <= 12) and NAG:IsReady(74434)) and (NAG:CurrentHealthPercent() > 0.15)) and NAG:Cast(1454))
        or (((NAG:TimeToReady(77801) < (NAG:SpellCastTime(30146) + 6)) and (NAG:TimeToReady(47241) < (NAG:SpellCastTime(30146) + 6))) and NAG:Cast(30146))
        or (((NAG:NumberTargets() >= 6.0) and (NAG:UnitDistance("target") < 11.0) and NAG:IsReady(89751)) and NAG:Cast(30146))
        or (((NAG:NumberTargets() >= 6.0) and (NAG:UnitDistance("target") < 11.0)) and NAG:Cast(89751))
        or (((NAG:NumberTargets() >= 6.0) and (NAG:UnitDistance("target") < 11.0) and (NAG:AuraRemainingTime(47241) >= 3)) and NAG:Cast(50589))
        or (((NAG:NumberTargets() >= 6.0) and (NAG:UnitDistance("target") < 11.0)) and NAG:Cast(47897))
        or (((NAG:NumberTargets() >= 6.0) and (NAG:UnitDistance("target") < 11.0)) and NAG:Cast(1949))
        or (((not NAG:DotIsActive(603)) and (not NAG:DotIsActive(980))) and NAG:MultiDot(603, 1, 0.0))
        or ((NAG:IsActive(47241) and (NAG:AuraRemainingTime(47241) > 4) and (NAG:UnitDistance("target") < 11.0) and NAG:UnitIsMoving()) and NAG:Cast(50589))
        or ((NAG:IsReady(47897) and NAG:UnitIsMoving() and (NAG:UnitDistance("target") < 11.0)) and NAG:Cast(47897))
        or (((NAG:DotRemainingTime(172) < NAG:DotTickFrequency(172)) and NAG:UnitIsMoving()) and NAG:Cast(172))
        or (((NAG:DotRemainingTime(603) < NAG:DotTickFrequency(603)) and NAG:UnitIsMoving()) and NAG:Cast(603))
        or ((NAG:UnitIsMoving() and (NAG:CurrentManaPercent() < 0.40) and (NAG:CurrentHealthPercent() > 0.15)) and NAG:Cast(1454))
        or ((NAG:IsActive(17941) and NAG:UnitIsMoving()) and NAG:Cast(686))
        or (NAG:UnitIsMoving() and NAG:Cast(77799))
        or ((NAG:DotRemainingTime(348) < (NAG:SpellCastTime(348) + NAG:DotTickFrequency(348))) and NAG:Cast(348))
        or ((NAG:DotRemainingTime(172) < NAG:DotTickFrequency(172)) and NAG:Cast(172))
        or ((NAG:IsActive(47241) and (NAG:AuraRemainingTime(47241) > 4) and (NAG:UnitDistance("target") < 11.0)) and NAG:Cast(50589))
        or ((NAG:IsReady(71521) and NAG:DotIsActive(348) and (NAG:DotRemainingTime(348) > NAG:SpellCastTime(71521))) and NAG:Cast(71521))
        or (NAG:IsActive(89937) and NAG:Cast(77799))
        or ((NAG:IsReady(47897) and (NAG:UnitDistance("target") < 11.0)) and NAG:Cast(47897))
        or (NAG:IsActive(17941) and NAG:Cast(686))
        or (NAG:IsActive(71165) and NAG:Cast(29722))
        or (NAG:IsActive(63167) and NAG:Cast(6353))
        or NAG:Cast(686)
        or NAG:Cast(1454)
]]
}

-- Demonology Shadowbolt Rotation (deprecated, keeping for backwards compat)
local demonologyShadowboltRotation = {
    name = "Cataclysm Demonology Shadowbolt - by @Repikas",
    specIndex = 2,
    class = "WARLOCK",
    default = false,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = false,
    prePull = {
        { time = -10, action = "NAG:Cast(30146)" },
        { time = -4.0, action = "NAG:Cast(77801)" },
        { time = -4.0, action = "NAG:Cast(74434)" },
        { time = -4.0, action = "NAG:Cast(691)" },
        { time = -2.5, action = "NAG:Cast(NAG:GetBattlePotion())" },
        { time = -2.5, action = "NAG:Cast(47241)" },
        { time = -2.5, action = "NAG:Cast(686)" },
        { time = -0.7, action = "NAG:Cast(348)" }
    },
    macros = {
        { name = "Demon Soul",    body = "#showtooltip\n/cast Demon Soul\n/cast Soulburn\n/cast Summon Felhunter" },
        { name = "Metamorphosis", body = "#showtooltip\n/cast Metamorphosis\n/cast Blood Fury\n/cast Berserking\n/use Volcanic Potion" },
        { name = "Shadowbolt",    body = "#showtooltip\n/cast Shadow Bolt\n/petattack" },
        { name = "Incinerate",    body = "#showtooltip\n/cast Shadow Bolt\n/petattack" },
        { name = "Soul Fire",     body = "#showtooltip\n/cast Shadow Bolt\n/petattack" }
    },
    rotationString = [[
        NAG:SpellCastSequence()
        or NAG:AutocastOtherCooldowns()
        or (((NAG:CurrentManaPercent() < 0.15) and (NAG:CurrentHealthPercent() > 0.15)) and NAG:Cast(1454))
        or (((NAG:UnitDistance("target") < 11.0) and NAG:IsReady(89751)) and NAG:Cast(89751))
        or (((NAG:TimeToReady(77801) > 40) and (NAG:IsActive(79462) or NAG:IsActive(79460)) and (not NAG:IsReady(89751))) and NAG:Cast(691))
        or ((not NAG:IsActive(28176)) and NAG:Cast(28176))
        or ((not NAG:IsActive(80398)) and NAG:Cast(80398))
        or ((NAG:SpellCanCast(77801) and NAG:SpellCanCast(74434) and NAG:SpellCanCast(47241)) and NAG:Cast(77801))
        or (((NAG:IsActive(79462) or NAG:IsActive(79460)) and NAG:SpellCanCast(74434) and NAG:SpellCanCast(47241)) and NAG:Cast(74434))
        or (((NAG:IsActive(79462) or NAG:IsActive(79460)) and NAG:IsActive(74434) and NAG:SpellCanCast(47241)) and NAG:Cast(691))
        or (((NAG:IsActive(79462) or NAG:IsActive(79460)) and NAG:SpellCanCast(47241)) and NAG:Cast(47241))
        or (NAG:IsActive(47241) and NAG:Cast(82174))
        or (NAG:IsActive(47241) and NAG:Cast(33697))
        or ((NAG:DotIsActive(603) and NAG:IsActive(47241) and (NAG:IsActive(74241) or (NAG:AuraRemainingTime(96230) < 2)) and (NAG:IsActive(89091) or (NAG:AuraRemainingTime(96230) < 2))) and NAG:Cast(18540))
        or ((NAG:TimeToReady(77801) >= 50) and NAG:Cast(82174))
        or (NAG:IsActive(47241) and NAG:Cast(58091))
        or (((NAG:CurrentManaPercent() <= 0.70) and ((NAG:TimeToReady(77801) <= 12) and NAG:IsReady(74434)) and (NAG:CurrentHealthPercent() > 0.15)) and NAG:Cast(1454))
        or (((NAG:TimeToReady(77801) < (NAG:SpellCastTime(30146) + 6)) and (NAG:TimeToReady(47241) < (NAG:SpellCastTime(30146) + 6))) and NAG:Cast(30146))
        or (((NAG:NumberTargets() >= 6.0) and (NAG:UnitDistance("target") < 11.0) and NAG:IsReady(89751)) and NAG:Cast(30146))
        or (((NAG:NumberTargets() >= 6.0) and (NAG:UnitDistance("target") < 11.0)) and NAG:Cast(89751))
        or (((NAG:NumberTargets() >= 6.0) and (NAG:UnitDistance("target") < 11.0) and (NAG:AuraRemainingTime(47241) >= 3)) and NAG:Cast(50589))
        or (((NAG:NumberTargets() >= 6.0) and (NAG:UnitDistance("target") < 11.0)) and NAG:Cast(47897))
        or (((NAG:NumberTargets() >= 6.0) and (NAG:UnitDistance("target") < 11.0)) and NAG:Cast(1949))
        or (((not NAG:DotIsActive(603)) and (not NAG:DotIsActive(980))) and NAG:MultiDot(603, 1, 0.0))
        or ((NAG:IsActive(47241) and (NAG:AuraRemainingTime(47241) > 4) and (NAG:UnitDistance("target") < 11.0) and NAG:UnitIsMoving()) and NAG:Cast(50589))
        or ((NAG:IsReady(47897) and NAG:UnitIsMoving() and (NAG:UnitDistance("target") < 11.0)) and NAG:Cast(47897))
        or (((NAG:DotRemainingTime(172) < NAG:DotTickFrequency(172)) and NAG:UnitIsMoving()) and NAG:Cast(172))
        or (((NAG:DotRemainingTime(603) < NAG:DotTickFrequency(603)) and NAG:UnitIsMoving()) and NAG:Cast(603))
        or ((NAG:UnitIsMoving() and (NAG:CurrentManaPercent() < 0.40) and (NAG:CurrentHealthPercent() > 15.0)) and NAG:Cast(1454))
        or ((NAG:IsActive(17941) and NAG:UnitIsMoving()) and NAG:Cast(29722))
        or (NAG:UnitIsMoving() and NAG:Cast(77799))
        or ((NAG:DotRemainingTime(348) < (NAG:SpellCastTime(348) + NAG:DotTickFrequency(348))) and NAG:Cast(348))
        or ((NAG:DotRemainingTime(172) < NAG:DotTickFrequency(172)) and NAG:Cast(172))
        or ((NAG:IsActive(47241) and (NAG:AuraRemainingTime(47241) > 4) and (NAG:UnitDistance("target") < 11.0)) and NAG:Cast(50589))
        or ((NAG:IsReady(71521) and NAG:DotIsActive(348) and (NAG:DotRemainingTime(348) > NAG:SpellCastTime(71521))) and NAG:Cast(71521))
        or (NAG:IsActive(89937) and NAG:Cast(77799))
        or ((NAG:IsReady(47897) and (NAG:UnitDistance("target") < 11.0)) and NAG:Cast(47897))
        or (NAG:IsActive(71165) and NAG:Cast(29722))
        or (NAG:IsActive(63167) and NAG:Cast(6353))
        or NAG:Cast(29722)
        or NAG:Cast(1454)
]]
}

-- Demonology Incinerate Rotation
local demonologyIncinerateRotation = {
    name = "Cataclysm Demonology Incinerate - by @Repikas",
    specIndex = 2,
    class = "WARLOCK",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = false,
    prePull = {
        { time = -10, action = "NAG:Cast(30146)" },
        { time = -4.0, action = "NAG:Cast(77801)" },
        { time = -4.0, action = "NAG:Cast(74434)" },
        { time = -4.0, action = "NAG:Cast(691)" },
        { time = -2.5, action = "NAG:Cast(NAG:GetBattlePotion())" },
        { time = -2.5, action = "NAG:Cast(47241)" },
        { time = -2.5, action = "NAG:Cast(29722)" },
        { time = -0.7, action = "NAG:Cast(348)" }
    },
    macros = {
        { name = "Demon Soul",    body = "#showtooltip\n/cast Demon Soul\n/cast Soulburn\n/cast Summon Felhunter" },
        { name = "Metamorphosis", body = "#showtooltip\n/cast Metamorphosis\n/cast Blood Fury\n/cast Berserking\n/use Volcanic Potion" },
        { name = "Shadowbolt",    body = "#showtooltip\n/cast Shadow Bolt\n/petattack" },
        { name = "Incinerate",    body = "#showtooltip\n/cast Shadow Bolt\n/petattack" },
        { name = "Soul Fire",     body = "#showtooltip\n/cast Shadow Bolt\n/petattack" }
    },
    rotationString = [[
        NAG:SpellCastSequence()
        or NAG:AutocastOtherCooldowns()
        or (((NAG:CurrentManaPercent() < 0.15) and (NAG:CurrentHealthPercent() > 0.15)) and NAG:Cast(1454))
        or (((NAG:UnitDistance("target") < 11.0) and NAG:IsReady(89751)) and NAG:Cast(89751))
        or (((NAG:TimeToReady(77801) > 40) and (NAG:IsActive(79462) or NAG:IsActive(79460)) and (not NAG:IsReady(89751))) and NAG:Cast(691))
        or ((not NAG:IsActive(28176)) and NAG:Cast(28176))
        or ((not NAG:IsActive(80398)) and NAG:Cast(80398))
        or ((NAG:SpellCanCast(77801) and NAG:SpellCanCast(74434) and NAG:SpellCanCast(47241)) and NAG:Cast(77801))
        or (((NAG:IsActive(79462) or NAG:IsActive(79460)) and NAG:SpellCanCast(74434) and NAG:SpellCanCast(47241)) and NAG:Cast(74434))
        or (((NAG:IsActive(79462) or NAG:IsActive(79460)) and NAG:IsActive(74434) and NAG:SpellCanCast(47241)) and NAG:Cast(691))
        or (((NAG:IsActive(79462) or NAG:IsActive(79460)) and NAG:SpellCanCast(47241)) and NAG:Cast(47241))
        or (NAG:IsActive(47241) and NAG:Cast(82174))
        or (NAG:IsActive(47241) and NAG:Cast(33697))
        or ((NAG:DotIsActive(603) and NAG:IsActive(47241) and (NAG:IsActive(74241) or (NAG:AuraRemainingTime(96230) < 2)) and (NAG:IsActive(89091) or (NAG:AuraRemainingTime(96230) < 2))) and NAG:Cast(18540))
        or ((NAG:TimeToReady(77801) >= 50) and NAG:Cast(82174))
        or (NAG:IsActive(47241) and NAG:Cast(58091))
        or (((NAG:CurrentManaPercent() <= 0.70) and ((NAG:TimeToReady(77801) <= 12) and NAG:IsReady(74434)) and (NAG:CurrentHealthPercent() > 15.0)) and NAG:Cast(1454))
        or (((NAG:TimeToReady(77801) < (NAG:SpellCastTime(30146) + 6)) and (NAG:TimeToReady(47241) < (NAG:SpellCastTime(30146) + 6))) and NAG:Cast(30146))
        or (((NAG:NumberTargets() >= 6.0) and (NAG:UnitDistance("target") < 11.0) and NAG:IsReady(89751)) and NAG:Cast(30146))
        or (((NAG:NumberTargets() >= 6.0) and (NAG:UnitDistance("target") < 11.0)) and NAG:Cast(89751))
        or (((NAG:NumberTargets() >= 6.0) and (NAG:UnitDistance("target") < 11.0) and (NAG:AuraRemainingTime(47241) >= 3)) and NAG:Cast(50589))
        or (((NAG:NumberTargets() >= 6.0) and (NAG:UnitDistance("target") < 11.0)) and NAG:Cast(47897))
        or (((NAG:NumberTargets() >= 6.0) and (NAG:UnitDistance("target") < 11.0)) and NAG:Cast(1949))
        or (((not NAG:DotIsActive(603)) and (not NAG:DotIsActive(980))) and NAG:MultiDot(603, 1, 0.0))
        or ((NAG:IsActive(47241) and (NAG:AuraRemainingTime(47241) > 4) and (NAG:UnitDistance("target") < 11.0) and NAG:UnitIsMoving()) and NAG:Cast(50589))
        or ((NAG:IsReady(47897) and NAG:UnitIsMoving() and (NAG:UnitDistance("target") < 11.0)) and NAG:Cast(47897))
        or (((NAG:DotRemainingTime(172) < NAG:DotTickFrequency(172)) and NAG:UnitIsMoving()) and NAG:Cast(172))
        or (((NAG:DotRemainingTime(603) < NAG:DotTickFrequency(603)) and NAG:UnitIsMoving()) and NAG:Cast(603))
        or ((NAG:UnitIsMoving() and (NAG:CurrentManaPercent() < 0.40) and (NAG:CurrentHealthPercent() > 15.0)) and NAG:Cast(1454))
        or ((NAG:IsActive(17941) and NAG:UnitIsMoving()) and NAG:Cast(29722))
        or (NAG:UnitIsMoving() and NAG:Cast(77799))
        or ((NAG:DotRemainingTime(348) < (NAG:SpellCastTime(348) + NAG:DotTickFrequency(348))) and NAG:Cast(348))
        or ((NAG:DotRemainingTime(172) < NAG:DotTickFrequency(172)) and NAG:Cast(172))
        or ((NAG:IsActive(47241) and (NAG:AuraRemainingTime(47241) > 4) and (NAG:UnitDistance("target") < 11.0)) and NAG:Cast(50589))
        or ((NAG:IsReady(71521) and NAG:DotIsActive(348) and (NAG:DotRemainingTime(348) > NAG:SpellCastTime(71521))) and NAG:Cast(71521))
        or (NAG:IsActive(89937) and NAG:Cast(77799))
        or ((NAG:IsReady(47897) and (NAG:UnitDistance("target") < 11.0)) and NAG:Cast(47897))
        or (NAG:IsActive(71165) and NAG:Cast(29722))
        or (NAG:IsActive(63167) and NAG:Cast(6353))
        or NAG:Cast(29722)
        or NAG:Cast(1454)
]]
}

-- Destruction Rotation
local destructionRotation = {
    name = "Cataclysm Destruction - by @Repikas",
    specIndex = 3,
    class = "WARLOCK",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_CATA,
    experimental = false,
    prePull = {
        { time = -10, action = "NAG:Cast(688)" },
        { time = -8.0, action = "NAG:Cast(74434)" },
        { time = -2.5, action = "NAG:Cast(NAG:GetBattlePotion())" },
        { time = -2.5, action = "NAG:Cast(29722)" },
        { time = -0.5, action = "NAG:Cast(6353)" }
    },
    macros = {
        { name = "Shadowbolt", body = "#showtooltip\n/cast Shadow Bolt\n/petattack" },
        { name = "Incinerate", body = "#showtooltip\n/cast Shadow Bolt\n/petattack" },
        { name = "Soul Fire",  body = "#showtooltip\n/cast Shadow Bolt\n/petattack" }
    },
    rotationString = [[
        NAG:SpellCastSequence()
        or NAG:AutocastOtherCooldowns()
        or (((NAG:CurrentManaPercent() < 0.15) and (NAG:CurrentHealthPercent() > 0.15)) and NAG:Cast(1454))
        or NAG:Cast(688)
        or (NAG:IsReady(77801) and NAG:Cast(77801))
        or ((not NAG:IsActive(28176)) and NAG:Cast(28176))
        or ((not NAG:IsActive(80398)) and NAG:Cast(80398))
        or (NAG:IsActive(79459) and NAG:Cast(33697))
        or (NAG:IsActive(79459) and NAG:Cast(NAG:GetBattlePotion()))
        or NAG:Cast(82174)
        or (((NAG:IsActive(74241) or (NAG:AuraRemainingTime(96230) < 2)) and (NAG:IsActive(89091) or (NAG:AuraRemainingTime(96230) < 2)) and NAG:DotIsActive(603)) and NAG:Cast(18540))
        or ((NAG:IsReady(74434) and (not NAG:IsActive(18120))) and NAG:Cast(74434))
        or ((NAG:IsActive(74434) or NAG:IsActive(47221) or (NAG:AuraRemainingTime(18120) < 3)) and NAG:Cast(6353))
        or (((NAG:NumberTargets() >= 3.0) and (NAG:UnitDistance("target") < 11.0)) and NAG:Cast(47897))
        or (((NAG:NumberTargets() >= 6.0) and (NAG:UnitDistance("target") < 11.0)) and NAG:Cast(5740))
        or (((not NAG:DotIsActive(603)) and (not NAG:DotIsActive(980)) and (not NAG:DotIsActive(980))) and NAG:MultiDot(603, 1, 0.0))
        or ((NAG:UnitIsMoving() and (NAG:DotRemainingTime(603) < NAG:DotTickFrequency(603)) and NAG:DotIsActive(603)) and NAG:Cast(603))
        or ((NAG:SpellCanCast(17962) and NAG:UnitIsMoving()) and NAG:Cast(17962))
        or (((NAG:DotRemainingTime(172) < NAG:DotTickFrequency(172)) and NAG:UnitIsMoving()) and NAG:Cast(172))
        or ((NAG:IsActive(89937) and NAG:UnitIsMoving()) and NAG:Cast(77799))
        or ((NAG:SpellCanCast(47897) and (NAG:UnitDistance("target") < 11.0) and NAG:UnitIsMoving()) and NAG:Cast(47897))
        or ((NAG:IsExecutePhase(20) and NAG:SpellCanCast(17877) and NAG:UnitIsMoving()) and NAG:Cast(17877))
        or ((NAG:UnitIsMoving() and (NAG:CurrentManaPercent() < 0.40) and (NAG:CurrentHealthPercent() > 0.15)) and NAG:Cast(1454))
        or ((NAG:DotRemainingTime(348) < (NAG:SpellCastTime(348) + NAG:DotTickFrequency(348))) and NAG:Cast(348))
        or (NAG:SpellCanCast(17962) and NAG:Cast(17962))
        or ((NAG:DotRemainingTime(172) < NAG:DotTickFrequency(172)) and NAG:Cast(172))
        or (NAG:IsReady(50796) and NAG:Cast(50796))
        or ((NAG:SpellCanCast(47897) and (NAG:UnitDistance("target") < 11.0)) and NAG:Cast(47897))
        or ((NAG:IsExecutePhase(20) and NAG:SpellCanCast(17877)) and NAG:Cast(17877))
        or (NAG:IsActive(89937) and NAG:Cast(77799))
        or NAG:Cast(29722)
        or NAG:Cast(1454)
]]
}
-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
-- Leave below as is

if UnitClassBase('player') ~= "WARLOCK" then return end

--- @class Warlock : ClassBase
local Warlock = NAG:CreateClassModule("WARLOCK", defaults)
if not Warlock then return end

-- Setup class defaults during PreDatabaseRegistration
function Warlock:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 1, afflictionRotation)  -- Affliction
    ns.AddRotationToDefaults(self.defaults, 2, demonologyShadowboltRotation)  -- Demonology
    ns.AddRotationToDefaults(self.defaults, 2, demonologyIncinerateRotation)  -- Demonology
    ns.AddRotationToDefaults(self.defaults, 3, destructionRotation)  -- Destruction
end

function Warlock:RegisterSpellTracking()
    --- @type SpellTrackingManager|AceModule|CoreModule
    local SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
        -- Add spells to periodic damage tracking
    -- Add spells to cast tracking
    SpellTrackingManager:RegisterCastTracking({ 30146 }, { count = 0, startTime = GetTime() })     -- Summon Felguard
    SpellTrackingManager:RegisterPeriodicDamage({ 172 }, { tickTime = nil, lastTickTime = nil })   -- Corruption
    SpellTrackingManager:RegisterPeriodicDamage({ 30108 }, { tickTime = nil, lastTickTime = nil }) -- Unstable Affliction
    SpellTrackingManager:RegisterPeriodicDamage({ 603 }, { tickTime = nil, lastTickTime = nil })   -- Bane of Doom
    SpellTrackingManager:RegisterPeriodicDamage({ 348 }, { tickTime = nil, lastTickTime = nil })   -- Immolate
end

NAG.Class = Warlock
