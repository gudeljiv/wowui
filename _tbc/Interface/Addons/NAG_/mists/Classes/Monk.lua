local _, ns = ...
local GetTime = _G.GetTime
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version
--- @type SpellTrackingManager|AceModule|CoreModule

-- Initialize class defaults with standard structure
local defaults = ns.InitializeClassDefaults()

-- Add spec-level spell locations to defaults
defaults.class.specSpellLocations = {
    [1] = { -- Brewmaster
        -- ABOVE spells
        [115203] = NAG.SPELL_POSITIONS.ABOVE,   -- Fortifying Brew
        [115308] = NAG.SPELL_POSITIONS.ABOVE,   -- Elusive Brew
        [119582] = NAG.SPELL_POSITIONS.ABOVE,   -- Purifying Brew
        [115176] = NAG.SPELL_POSITIONS.ABOVE,   -- Zen Meditation
        [115213] = NAG.SPELL_POSITIONS.ABOVE,   -- Avert Harm
        [115295] = NAG.SPELL_POSITIONS.ABOVE,   -- Guard
        [122278] = NAG.SPELL_POSITIONS.ABOVE,   -- Dampen Harm
        [122783] = NAG.SPELL_POSITIONS.ABOVE,   -- Diffuse Magic

        -- BELOW spells
        [123986] = NAG.SPELL_POSITIONS.BELOW,   -- Chi Burst
        [124081] = NAG.SPELL_POSITIONS.BELOW,   -- Zen Sphere
        [115315] = NAG.SPELL_POSITIONS.BELOW,   -- Black Ox Statue / Summon Black Ox Statue
        [120267] = NAG.SPELL_POSITIONS.BELOW,   -- Vengeance
        [124255] = NAG.SPELL_POSITIONS.BELOW,   -- Stagger
        [124275] = NAG.SPELL_POSITIONS.BELOW,   -- Light Stagger
        [124274] = NAG.SPELL_POSITIONS.BELOW,   -- Moderate Stagger
        [124273] = NAG.SPELL_POSITIONS.BELOW,   -- Heavy Stagger
        [115069] = NAG.SPELL_POSITIONS.BELOW,   -- Stance of the Sturdy Ox
        [1247275] = NAG.SPELL_POSITIONS.BELOW,  -- Tigereye Brew

        -- RIGHT spells
        [138228] = NAG.SPELL_POSITIONS.RIGHT,   -- Storm, Earth and Fire
        [137639] = NAG.SPELL_POSITIONS.RIGHT,   -- (unknown spell)
        [115181] = NAG.SPELL_POSITIONS.RIGHT,   -- Breath of Fire

        -- LEFT spells
        [101643] = NAG.SPELL_POSITIONS.LEFT,    -- Transcendence
        [119996] = NAG.SPELL_POSITIONS.LEFT,    -- Transcendence: Transfer
        [109132] = NAG.SPELL_POSITIONS.LEFT,    -- Roll / Chi Torpedo
        [123904] = NAG.SPELL_POSITIONS.LEFT,    -- Invoke Xuen, the White Tiger
        [115399] = NAG.SPELL_POSITIONS.LEFT,    -- Chi Brew
        [119392] = NAG.SPELL_POSITIONS.LEFT,    -- Charging Ox Wave
        [119381] = NAG.SPELL_POSITIONS.LEFT,    -- Leg Sweep
        [116844] = NAG.SPELL_POSITIONS.LEFT,    -- Ring of Peace
        [116841] = NAG.SPELL_POSITIONS.LEFT,    -- Tiger's Lust
        [137562] = NAG.SPELL_POSITIONS.LEFT,    -- Nimble Brew
        [115543] = NAG.SPELL_POSITIONS.LEFT,    -- Leer of the Ox
        [117368] = NAG.SPELL_POSITIONS.LEFT,    -- Grapple Weapon
        [116705] = NAG.SPELL_POSITIONS.LEFT,    -- Spear Hand Strike
        [122057] = NAG.SPELL_POSITIONS.LEFT,    -- Clash
        [126456] = NAG.SPELL_POSITIONS.LEFT,    -- Fortifying Brew
        [115078] = NAG.SPELL_POSITIONS.LEFT,    -- Paralysis

        -- AOE spells
        [101546] = NAG.SPELL_POSITIONS.AOE,     -- Spinning Crane Kick
        [116847] = NAG.SPELL_POSITIONS.AOE      -- Rushing Jade Wind
    },
    [2] = { -- Mistweaver
        -- ABOVE spells
        [116694] = NAG.SPELL_POSITIONS.ABOVE,    -- Surging Mist
        -- (empty)

        -- BELOW spells
        [115313] = NAG.SPELL_POSITIONS.BELOW,    -- Revival

        -- RIGHT spells
        [116670] = NAG.SPELL_POSITIONS.RIGHT,    -- Uplift

        -- LEFT spells
        [115310] = NAG.SPELL_POSITIONS.LEFT,    -- Revival
        [123904] = NAG.SPELL_POSITIONS.LEFT,    -- Invoke Xuen, the White Tiger


        -- AOE spells
        -- (empty)
    },
    [3] = { -- Windwalker
        -- ABOVE spells
        [115072] = NAG.SPELL_POSITIONS.ABOVE,   -- Expel Harm
        [115098] = NAG.SPELL_POSITIONS.ABOVE,   -- Chi Wave

        -- BELOW spells
        [1247275] = NAG.SPELL_POSITIONS.BELOW,  -- Tigereye Brew

        -- RIGHT spells
        [123904] = NAG.SPELL_POSITIONS.RIGHT,   -- Invoke Xuen, the White Tiger
        [138228] = NAG.SPELL_POSITIONS.RIGHT,   -- Storm, Earth and Fire
        [137639] = NAG.SPELL_POSITIONS.RIGHT,   -- (unknown spell)

        -- LEFT spells
        [115288] = NAG.SPELL_POSITIONS.LEFT,    -- Energizing Brew
        [116740] = NAG.SPELL_POSITIONS.LEFT,    -- Tiger Brew
        [115399] = NAG.SPELL_POSITIONS.LEFT,    -- Chi Brew
        [122470] = NAG.SPELL_POSITIONS.LEFT,    -- Touch of Karma
        [115080] = NAG.SPELL_POSITIONS.LEFT,    -- Touch of Death
        [126456] = NAG.SPELL_POSITIONS.LEFT,    -- Fortifying Brew

        -- AOE spells
        [101546] = NAG.SPELL_POSITIONS.AOE,     -- Spinning Crane Kick
        [116847] = NAG.SPELL_POSITIONS.AOE      -- Rushing Jade Wind
    }
}

-- Skip loading if not the correct class
if UnitClassBase('player') ~= "MONK" then return end

function NAG:WWMonkDebug()
    if not (NAG.IsDevModeEnabled and NAG:IsDevModeEnabled()) then
        return false
    end

    local snapshotter = (ns and ns.Snapshotter) or (NAG.GetModule and NAG:GetModule("Snapshotter", true))
    local snapshot = nil
    if snapshotter and snapshotter.state and snapshotter.state.snapshots then
        local map = snapshotter.state.snapshots[1247275]
        snapshot = map and map["*"] or nil
    end

    local perSpell = snapshot and snapshot.perSpell or nil
    local tebPreCast = perSpell and perSpell.tebPreCastStacks or nil
    local tebConsumed = perSpell and perSpell.tebConsumedStacks or nil
    local tebRemainingStacks = perSpell and perSpell.tebStacksRemaining or nil

    local tebStacks = NAG.AuraNumStacks and NAG:AuraNumStacks(1247279, "player", true) or 0
    local tebActive = NAG.AuraIsActive and NAG:AuraIsActive(1247275, "player", true) or false
    local tebRemaining = NAG.AuraRemainingTime and NAG:AuraRemainingTime(1247275, "player", true) or 0
    local roroActive = NAG.AuraIsActive and NAG:AuraIsActive(139120, "player", true) or false
    local roroRemaining = NAG.AuraRemainingTime and NAG:AuraRemainingTime(139120, "player", true) or 0

    print(string.format(
        "[WWMonkDebug] t=%.2f TEB:active=%s rem=%.2f stacks=%d snapshot={pre=%s consumed=%s remaining=%s} RoRo:active=%s rem=%.2f",
        GetTime(),
        tostring(tebActive),
        tebRemaining,
        tebStacks,
        tostring(tebPreCast),
        tostring(tebConsumed),
        tostring(tebRemainingStacks),
        tostring(roroActive),
        roroRemaining
    ))
    return false
end

function NAG:WWMonkTEBRecastAllowed()
    if not (NAG.AuraIsActive and NAG.AuraRemainingTime and NAG.AuraNumStacks) then
        return true
    end

    local tebActive = NAG:AuraIsActive(1247275, "player", true)
    if not tebActive then
        return true
    end

    local tebRemaining = NAG:AuraRemainingTime(1247275, "player", true) or 0
    if tebRemaining <= 2.0 then
        return true
    end

    local snapshotter = (ns and ns.Snapshotter) or (NAG.GetModule and NAG:GetModule("Snapshotter", true))
    local snapshot = nil
    if snapshotter and snapshotter.state and snapshotter.state.snapshots then
        local map = snapshotter.state.snapshots[1247275]
        snapshot = map and map["*"] or nil
    end

    if not snapshot or not snapshot.perSpell then
        return true
    end

    local currentStacks = snapshot.perSpell.tebConsumedStacks
    if not currentStacks then
        return true
    end

    local currentRoro = snapshot.perSpell.tebRoroActive and 2 or 1
    local currentStrength = currentStacks * currentRoro

    local nextStacks = math.min(10, NAG:AuraNumStacks(1247279, "player", true) or 0)
    local nextRoro = (NAG:AuraIsActive(139120, "player", true) and 2 or 1)
    local nextStrength = nextStacks * nextRoro

    return nextStrength >= currentStrength
end

function NAG:WWMonkTEBTimingAllowed()
    if not (NAG.AuraIsActive and NAG.AuraRemainingTime and NAG.AuraNumStacks) then
        return true
    end

    local roroActive = NAG:AuraIsActive(139120, "player", true)
    if not roroActive then
        return true
    end

    local stacks = NAG:AuraNumStacks(1247279, "player", true) or 0
    local potActive = NAG:AuraIsActive(76089, "player", true)
    local roroRemaining = NAG:AuraRemainingTime(139120, "player", true) or 0
    local remainingTime = NAG:RemainingTime() or 0

    if stacks >= 10 then
        return potActive or roroRemaining <= 2.0 or (remainingTime > 0 and remainingTime < (roroRemaining + 17))
    end

    return roroRemaining <= 2.0 or (remainingTime > 0 and remainingTime < (roroRemaining + 17))
end

function NAG:WWMonkTEBICDAllowedAttempt2()
    if not (NAG.AuraInternalCooldown and NAG.AuraNumStacks and NAG.RemainingTime) then
        return true
    end

    local icdRemaining = NAG:AuraInternalCooldown(139120, "player") or 0
    if icdRemaining <= 0 then
        local spellTrackingManager = NAG.GetModule and NAG:GetModule("SpellTrackingManager", true)
        if spellTrackingManager and spellTrackingManager.GetICDInfo then
            local procIcd = spellTrackingManager:GetICDInfo(139120) or 0
            local triggerIcd = spellTrackingManager:GetICDInfo(139116) or 0
            icdRemaining = math.max(procIcd, triggerIcd, 0)
        end
    end
    if icdRemaining <= 0 or icdRemaining > 15 then
        return true
    end

    local stacks = NAG:AuraNumStacks(1247279, "player", true) or 0
    if stacks >= 19 then
        return true
    end

    local remainingTime = NAG:RemainingTime() or 0
    if remainingTime > 0 and remainingTime < 16 then
        return true
    end

    return false
end

-- START OF GENERATED_ROTATIONS
--
--[[
    ]]
-- Generic (0 spec / no spec selected): low-level abilities before choosing a spec
local genericRotation = {
    name = "Generic",
    specIndex = 0,
    class = "MONK",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    rotationString = [[
    (NAG:SpellCanCast(100784)) and NAG:Cast(100784)
    or (NAG:SpellCanCast(115698)) and NAG:Cast(115698)
    or (NAG:SpellCanCast(100780)) and NAG:Cast(100780)
]],
}

-- Brewmaster Tank Rotation
local brewmasterRotation = {
    name = "Brewmaster",
    specIndex = 1,
    class = "MONK",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { time = -1.5, action = "NAG:GetBattlePotion()" }
    },
    lastModified = "10/11/2025",
    rotationString = [[
NAG:AutocastOtherCooldowns()

-- Elusive Brew
    or ((NAG:AuraNumStacks(128938) >= 6) and (not NAG:AuraIsActive(115308))) and NAG:Cast(115308)

-- Chi Brew
    or (((NAG:MonkCurrentChi() <= 2) and (NAG:SpellTimeToReady(121253) >= 2.0) and (NAG:CurrentEnergy() <= (NAG:MaxEnergy() - (NAG:EnergyRegenPerSecond() * 2)))) or (NAG:MonkCurrentChi() == 0)) and NAG:Cast(115399)

-- Guard
    or ((NAG:AuraRemainingTime(115307) > 2.0) and NAG:AuraIsActive(118636) and (NAG:MonkCurrentChi() >= 3)) and NAG:Cast(115295)

-- Chi Overcap protection with Blackout Kick if KS is close to ready
    or ((NAG:SpellTimeToReady(121253) <= 2) and (NAG:MonkCurrentChi() >= (NAG:MonkMaxChi() - 1))) and NAG:Cast(100784)

-- Keg Smash
    or (NAG:CurrentEnergy() >= 35) and NAG:Cast(121253)

-- Shuffle Uptime protection with each Chi Generator followed by Blackout Kick if enough Chi; RJW > EH > Jab > BoK
    or ((NAG:AuraRemainingTime(115307) <= 2.0) and (NAG:MonkCurrentChi() <= 1) and (NAG:NumberTargets() >= 3)) and NAG:Cast(116847)
    or ((NAG:AuraRemainingTime(115307) <= 2.0) and (NAG:MonkCurrentChi() <= 1) and (NAG:CurrentHealthPercent() < 0.85)) and NAG:Cast(115072)
    or ((NAG:AuraRemainingTime(115307) <= 2.0) and (NAG:MonkCurrentChi() <= 1)) and NAG:Cast(100780)
    or ((NAG:AuraRemainingTime(115307) <= 1.5) or ((NAG:SpellTimeToReady(121253) <= 2.0) and (NAG:MonkCurrentChi() >= (NAG:MonkMaxChi() - 1)))) and NAG:Cast(100784)

-- Xuen
    or NAG:Cast(123904)

-- Purifying Brew
-- *Note: It's set to a high stagger % and longer than 5s duration to prevent poor usage of PB; PB should be used as needed and that's difficult to model in an APL
    or ((NAG:BrewmasterMonkCurrentStaggerPercent() >= 0.1) and (NAG:AuraRemainingTime(124255) >= 5.0)) and NAG:Cast(119582)

-- Chi Overcap Protection - Capped
    or (NAG:MonkCurrentChi() == (NAG:MonkMaxChi())) and NAG:Cast(100784)

-- Energy Overcap protection: RJW > EH > SCK > Jab
-- *Note: EH/Jab check if RJW is known and it's aoe, they will not be recommended if RJW is known and you're in aoe until very high energy
-- RJW
    or ((NAG:CurrentEnergy() >= (80 - (NAG:EnergyRegenPerSecond() * NAG:SpellTimeToReady(121253)))) and (NAG:NumberTargets() >= 3)) and NAG:Cast(116847)
-- EH
    or ((((NAG:CurrentEnergy() >= (NAG:MaxEnergy() - (2.5 * NAG:EnergyRegenPerSecond()))) and ((not NAG:SpellIsKnown(116847)) or (NAG:NumberTargets() < 3))) or ((NAG:CurrentEnergy() >= (100 - ((NAG:EnergyRegenPerSecond() - 10) * 2))) and ((NAG:SpellIsKnown(116847)) and (NAG:NumberTargets() >= 3)))) and (NAG:CurrentHealthPercent() < 0.85)) and NAG:Cast(115072)
-- SCK
    or ((NAG:CurrentEnergy() >= (NAG:MaxEnergy() - (2.5 * NAG:EnergyRegenPerSecond()))) and (NAG:NumberTargets() >= 3)) and NAG:Cast(101546)
-- Jab
    or ((((NAG:CurrentEnergy() >= (NAG:MaxEnergy() - (2.5 * NAG:EnergyRegenPerSecond()))) and ((not NAG:SpellIsKnown(116847)) or (NAG:NumberTargets() < 3))) or ((NAG:CurrentEnergy() >= (100 - ((NAG:EnergyRegenPerSecond() - 10) * 2))) and ((NAG:SpellIsKnown(116847)) and (NAG:NumberTargets() >= 3))))) and NAG:Cast(100780)

-- Tiger Power Uptime protection
    or (NAG:AuraRemainingTime(125359) <= 1.5) and NAG:Cast(100787)

-- Chi Overcap Protection - Capped or -1
    or (NAG:MonkCurrentChi() >= (NAG:MonkMaxChi() - 1)) and NAG:Cast(100784)

-- Row 2 Talents
    or NAG:Cast(115098)
    or NAG:Cast(123986)
    or NAG:Cast(124081)

-- Tiger Palm Filler
    or NAG:Cast(100787)
    ]],

    -- Tracked IDs for optimization
    spells = {100780, 100784, 100787, 101546, 115072, 115098, 115295, 115307, 115308, 115399, 116847, 118636, 119582, 121253, 123904, 123986, 124081, 124255, 125359, 128938},
    items = {},

    -- MoP talents structure (one per tier)
    talents = {
        -- Tier 1 (Level 56)
        123904, -- Celerity
        -- Tier 2 (Level 57)
        123986, -- Chi Wave
        -- Tier 3 (Level 58)
        123980, -- Chi Burst
        -- Tier 4 (Level 60)
        123983, -- Chi Torpedo
        -- Tier 5 (Level 75)
        123986, -- Chi Wave
        -- Tier 6 (Level 90)
        123986  -- Chi Wave
    },

    -- MoP glyphs (only Major/Minor)
    glyphs = {
        major = {
            123904, -- Glyph of Fortifying Brew
            123986, -- Glyph of Zen Meditation
            123980  -- Glyph of Guard
        },
        minor = {
            123904, -- Glyph of Zen Flight
            123986  -- Glyph of Zen Meditation
        }
    },
    author = "@Mantipper"
}


-- Brewmaster Tank Rotation
local brewmasterRotationOffensively = {
    name = "Brewmaster RJW-ST Offensive",
    specIndex = 1,
    class = "MONK",
    default = false,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { time = -1.5, action = "NAG:GetBattlePotion()" }
    },
    lastModified = "10/11/2025",
    rotationString = [[
NAG:AutocastOtherCooldowns()

-- Elusive Brew
    or ((NAG:AuraNumStacks(128938) >= 6) and (not NAG:AuraIsActive(115308))) and NAG:Cast(115308)

-- Chi Brew
    or (((NAG:MonkCurrentChi() <= 1) and (NAG:SpellTimeToReady(121253) >= 2.0) and (NAG:CurrentEnergy() <= (NAG:MaxEnergy() - (NAG:EnergyRegenPerSecond() * 2)))) or (NAG:MonkCurrentChi() == 0)) and NAG:Cast(115399)

-- Chi Overcap Protection
    or ((NAG:SpellTimeToReady(121253) <= 1.5) and (NAG:MonkCurrentChi() >= (NAG:MonkMaxChi() - 1))) and NAG:Cast(100784)

-- Keg Smash
    or (NAG:CurrentEnergy() >= 35) and NAG:Cast(121253)

-- Rushing Jade Wind
    or (NAG:CurrentEnergy() >= (75 - (NAG:SpellTimeToReady(121253) * NAG:EnergyRegenPerSecond()))) and NAG:Cast(116847)

-- Expel Harm and Jab
    or ((NAG:CurrentEnergy() >= (100 - ((NAG:EnergyRegenPerSecond() - 10) * 2))) and (NAG:CurrentHealthPercent() < 0.9)) and NAG:Cast(115072)
    or (NAG:CurrentEnergy() >= (100 - ((NAG:EnergyRegenPerSecond() - 10) * 2))) and NAG:Cast(100780)

-- Tiger Power
    or (NAG:AuraRemainingTime(125359) <= 1.5) and NAG:Cast(100787)

-- Blackout Kick
    or (NAG:MonkCurrentChi() >= (NAG:MonkMaxChi() - 1)) and NAG:Cast(100784)

-- Row 2 Talents
    or NAG:Cast(115098)
    or NAG:Cast(123986)
    or NAG:Cast(124081)

-- Tiger Palm
    or NAG:Cast(100787)
    ]],

    -- Tracked IDs for optimization
    spells = {100780, 100784, 100787, 115072, 115098, 115308, 115399, 116847, 121253, 123986, 124081, 125359, 128938},
    items = {},

    -- MoP talents structure (one per tier)
    talents = {
        -- Tier 1 (Level 56)
        123904, -- Celerity
        -- Tier 2 (Level 57)
        123986, -- Chi Wave
        -- Tier 3 (Level 58)
        123980, -- Chi Burst
        -- Tier 4 (Level 60)
        123983, -- Chi Torpedo
        -- Tier 5 (Level 75)
        123986, -- Chi Wave
        -- Tier 6 (Level 90)
        123986  -- Chi Wave
    },

    -- MoP glyphs (only Major/Minor)
    glyphs = {
        major = {
            123904, -- Glyph of Fortifying Brew
            123986, -- Glyph of Zen Meditation
            123980  -- Glyph of Guard
        },
        minor = {
            123904, -- Glyph of Zen Flight
            123986  -- Glyph of Zen Meditation
        }
    },
    author = "@Mantipper"
}

-- Mistweaver Healer Rotation
local mistweaverRotation = {
    name = "Monk Mistweaver - Healer",
    specIndex = 2,
    class = "MONK",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { time = -1.5, action = "NAG:GetBattlePotion()" }
    },
    lastModified = "10/11/2025",
    rotationString = [[
(not NAG:IsTotemActive(1) or NAG:AuraIsActive(1249074)) and NAG:Cast(115313)

-- Revival when average raid HP < 50%
or ((NAG:AvgRaidHP() < 0.5)
 and NAG:IsReadySpell(115310))
and NAG:Cast(115310) -- Revival (spell cast)

-- Uplift when players with Renewing Mist avg < 85% HP
or (NAG:AvgRemHP() < 0.85
    and NAG:MonkCurrentChi() >= 2
    and NAG:IsReadySpell(116670))
   and NAG:Cast(116670) -- Uplift (spell cast)

-- Renewing Mist upkeep
or (NAG:IsReadySpell(115151))
   and NAG:Cast(115151) -- Renewing Mist (spell cast)

-- Mana management: Use Mana Tea (glyphed or un-glyphed)
or (NAG:CurrentManaPercent() < 0.25 and NAG:IsKnownSpell(123761) and NAG:IsReadySpell(123761)) and NAG:Cast(123761) -- Mana Tea (glyphed)
or (NAG:CurrentManaPercent() < 0.25 and NAG:IsKnownSpell(115294) and NAG:IsReadySpell(115294)) and NAG:Cast(115294) -- Mana Tea (unglyphed)

-- Invoke Xuen if talented and ready
or (NAG:IsKnownSpell(123904) and NAG:IsReadySpell(123904)) and NAG:Cast(123904)

-- Uplift only if TFT buff is active AND spell is ready
or (NAG:AuraIsActive(116680) and NAG:IsReadySpell(116670)) and NAG:Cast(116670) -- Uplift (TFT active)

--  EMERGENCY SPEND: avoid Chi overcap even if MM not active
or (NAG:MonkCurrentChi() >= 4) and (NAG:UnitDistance("target") <= 8) and NAG:Cast(100784) -- Blackout Kick
or (NAG:MonkCurrentChi() >= 4) and (NAG:UnitDistance("target") >= 8) and NAG:Cast(116670) -- Uplift


--  Spend Chi when Muscle Memory is active (moved up so it fires ASAP after GCD)
or ((NAG:MonkCurrentChi() >= 2) and NAG:AuraIsActive(139597)) and NAG:Cast(100784) -- BoK
or ((NAG:MonkCurrentChi() < 2) and NAG:AuraIsActive(139597)) and NAG:Cast(100787) -- Tiger Palm

--  Maintain Rushing Jade Wind (below spenders so Chi dumping has priority)
or (NAG:IsKnownSpell(116847) and NAG:IsReadySpell(116847) and not NAG:AuraIsActive(116847)) and NAG:Cast(116847) -- RJW

-- Vital Mists stack = 5 → Surging Mist (free Chi)
or (NAG:AuraNumStacks(118674) == 5
    and NAG:IsReadySpell(116694))
   and NAG:Cast(116694) -- Surging Mist

-- TALENTED DAMAGE / HEALING SPELLS (always on cooldown) ✦
or (NAG:IsKnownSpell(123986) and NAG:IsReadySpell(123986))
   and NAG:Cast(123986) -- Chi Burst

or (NAG:IsKnownSpell(115098) and NAG:IsReadySpell(115098))
   and NAG:Cast(115098) -- Chi Wave



-- Rebuild Chi with Chi Brew if < 3 Chi and charges won’t cap
or (
  NAG:IsKnownSpell(115399)
  and NAG:IsReadySpell(115399)
  and NAG:MonkCurrentChi() < 3
  and (
    NAG:SpellNumCharges(115399) == 2
    or NAG:SpellTimeToCharge(115399) < 10
  )
) and NAG:Cast(115399) -- Chi Brew

-- Expel Harm on cooldown (Chi + healing)
or (NAG:IsReadySpell(115072)
    and NAG:MonkCurrentChi() < 2)
   and NAG:Cast(115072) -- Expel Harm

--  Out of range fallback: Crackling Jade Lightning
or (NAG:UnitDistance("target") > 8) and NAG:Cast(117952) -- CJL

--  Maintain Tiger Power buff
or (not NAG:AuraIsActive(125359)) and NAG:Cast(100787) -- Tiger Palm

--  Maintain Serpent's Zeal
or (NAG:MonkCurrentChi() > 0 and (not NAG:AuraIsActive(127722))) and NAG:Cast(100784) -- Blackout Kick

-- Build Chi + Muscle Memory - Jab/SCK (AoE if 3+)
or ((not NAG:AuraIsActive(139597)) and (NAG:NumberTargets() >= 3)) and NAG:Cast(107270) -- SCK
or (not NAG:AuraIsActive(139597)) and NAG:Cast(108557) -- Jab
]],

    -- Tracked IDs for optimization
    spells = {100784, 100787, 107270, 108557, 115072, 115098, 115151, 115294, 115310, 115313, 115399, 116670, 116680, 116694, 116847, 117952, 118674, 123761, 123904, 123986, 125359, 127722, 139597, 1249074},
    items = {},

    -- MoP talents structure (one per tier)
    talents = {
        -- Tier 1 (Level 56)
        123904, -- Celerity
        -- Tier 2 (Level 57)
        123986, -- Chi Wave
        -- Tier 3 (Level 58)
        123980, -- Chi Burst
        -- Tier 4 (Level 60)
        123983, -- Chi Torpedo
        -- Tier 5 (Level 75)
        123986, -- Chi Wave
        -- Tier 6 (Level 90)
        123986  -- Chi Wave
    },

    -- MoP glyphs (only Major/Minor)
    glyphs = {
        major = {
            123904, -- Glyph of Fortifying Brew
            123986, -- Glyph of Zen Meditation
            123980  -- Glyph of Guard
        },
        minor = {
            123904, -- Glyph of Zen Flight
            123986  -- Glyph of Zen Meditation
        }
    }
}

-- Windwalker DPS Rotation
local windwalkerRotation = {
    name = "Monk Windwalker - DPS",
    specIndex = 3,
    class = "MONK",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { time = -1.5, action = "NAG:GetBattlePotion()" }
    },
    -- or ((NAG:MonkCurrentChi() <= 2) and NAG:AuraIsInactive(101546) and NAG:AuraIsInactive(113656) and ((1 and (true <= 10.0)) or 2 or (NAG:RemainingTime() < (true * 10)) or NAG:AllTrinketStatProcsActive(1))) and NAG:Cast(115399)
    -- removed the above.. to be placed AFTER the autocastotherCDs
    lastModified = "10/11/2025",
    rotationString = [[
        (NAG:CurrentHealth("target") > 0 and NAG:CurrentHealth()*1.21 >= NAG:CurrentHealth("target")) and NAG:InEncounter() and NAG:Cast(126456)
            or NAG:SpellCanCast(115080) and NAG:InEncounter() and NAG:Cast(115080)
        -- Fort Brew into Touch of Death

        -- Storm, Earth, and Fire
            or ((NAG:AuraNumStacks(138228) < 2) and (NAG:AuraNumStacks(138228) < (NAG:NumberTargets() - 1))) and NAG:Cast(138228)

        -- Potion
            or (NAG:AuraIsActive(2825) or NAG:AuraIsActive(123904) or (((NAG:SpellTimeToReady(123904) + 30) > NAG:RemainingTime()) and (NAG:AuraRemainingTime(1247275) > 12.0)) or (NAG:AuraIsActive(1247275) and NAG:AuraIsActive(138228) and (NAG:AuraNumStacks(138228) == math.min((NAG:NumberTargets() - 1), 2)))) and NAG:GetBattlePotion() and NAG:Cast(NAG:GetBattlePotion())

        -- Chi Sphere Check
            or ((NAG:MonkCurrentChi() < NAG:MonkMaxChi()) and NAG:AuraIsActive(121286) and (not NAG:AuraIsActive(129914))) and NAG:Cast(121283)

        -- Chi Brew
            or (((NAG:MonkCurrentChi() <= (NAG:MonkMaxChi() - 2)) and NAG:AuraIsActive(1247275) and (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > 4)) or ((NAG:MonkCurrentChi() <= (NAG:MonkMaxChi() - 2)) and (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > 4)) or (NAG:AuraIsActive(139120) and (NAG:AuraNumStacks(1247279) <= 8))) and NAG:Cast(115399)

        --Tigereye Brew
            or (not(NAG:AuraIsActive(1247275)) and ((NAG:AuraNumStacks(1247279) >= 19) or ((NAG:MonkCurrentChi() >= 2) and ((NAG:AuraNumStacks(1247279) >= 15) or (NAG:RemainingTime() < 30.0 and NAG:InEncounter()) or ((NAG:AuraNumStacks(1247279) >= 10)) or ((NAG:CurrentTime() < 10 and NAG:InEncounter()) and (NAG:AuraNumStacks(1247279) >= 7)))))) and NAG:Cast(1247275)

        -- Energizing Brew
            or ((not NAG:AuraIsActive(2825)) and (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > 5.0)) and NAG:Cast(115288)

        -- Xuen + other cooldowns
            or NAG:Cast(123904)
            or NAG:AutocastOtherCooldowns()

        -- Rushing Jade Wind; yes, it's better on 2 target
            or (NAG:NumberTargets() >= 2) and NAG:Cast(116847)

        -- Rising Sun Kick Uptime/CD
            or ((NAG:AuraRemainingTime(130320) <= 1) or (NAG:NumberTargets() < 2)) and NAG:Cast(130320)

        -- Tiger Power Uptime
            or (NAG:AuraRemainingTime(125359) <= 2.5) and NAG:Cast(100787)

        -- Spinning Crane Kick 4+
            or ((NAG:NumberTargets() >= 4) and (NAG:AuraRemainingTime(130320) >= 2.5)) and NAG:Cast(101546)

        -- RSK CD
            or NAG:Cast(130320)

        -- SCK 3+
            or (NAG:NumberTargets() >= 3) and NAG:Cast(101546)

        -- Chi Wave
            or (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) >= 1.0) and NAG:Cast(115098)

        -- Combo Breaker: Blackout Kick
            or NAG:AuraIsActive(116768) and NAG:Cast(100784)

        -- Fists of Fury
            or ((not NAG:AuraIsActive(115288)) and (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > 5) and ((not NAG:AuraIsActive(139120)) or (NAG:AuraIsActive(139120) and (NAG:AuraRemainingTime(139120) <= 2) and (not NAG:AuraIsActive(1247275))))) and NAG:Cast(113656)

        -- Zen Sphere
            or ((NAG:NumberTargets() < 3) and (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > 2.0) and (NAG:AuraNumStacks(124081) < 2)) and NAG:Cast(124081)

        -- Tiger Palm
            or ((NAG:CurrentTime() > 23) and (not NAG:AuraIsActive(115288)) and NAG:AuraIsActive(118864) and ((NAG:AuraRemainingTime(118864) <= 1.0) or (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) >= 2.0))) and NAG:Cast(100787)

        -- Chi Burst
            or (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > 2.0) and NAG:Cast(123986)

        -- Jab
            or ((NAG:MonkMaxChi() - NAG:MonkCurrentChi()) >= 2) and NAG:Cast(100780)

        -- Zen Sphere lower
            or (NAG:AuraNumStacks(124081) < 2) and NAG:Cast(124081)

        -- Chi Overcap Protection
            or ((((NAG:CurrentEnergy() + (NAG:EnergyRegenPerSecond() * NAG:SpellTimeToReady(130320))) >= 35) and (NAG:NumberTargets() <= 2)) or (((NAG:CurrentEnergy() + (NAG:EnergyRegenPerSecond() * NAG:SpellTimeToReady(130320))) >= 105) and (NAG:NumberTargets() >= 3))) and NAG:Cast(100784)


            or ((NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > 4)) and NAG:Cast(115288, nil, NAG.SPELL_POSITIONS.AOE)
            or (NAG:MonkCurrentChi() <= (NAG:MonkMaxChi() - 4)) and NAG:Cast(115399, nil, NAG.SPELL_POSITIONS.AOE)
            ]],


    -- Tracked IDs for optimization
    spells = {2825, 26297, 33697, 100780, 100784, 100787, 101546, 113656, 115080, 115098, 115288, 115399, 116768, 116847, 118864, 121279, 121283, 121286, 123904, 123986, 124081, 125359, 126456, 126734, 129914, 130320, 138228, 139120, 1247275, 1247279},
    items = {},

    -- MoP talents structure (one per tier)
    talents = {
        -- Tier 1 (Level 56)
        123904, -- Celerity
        -- Tier 2 (Level 57)
        123986, -- Chi Wave
        -- Tier 3 (Level 58)
        123980, -- Chi Burst
        -- Tier 4 (Level 60)
        123983, -- Chi Torpedo
        -- Tier 5 (Level 75)
        123986, -- Chi Wave
        -- Tier 6 (Level 90)
        123986  -- Chi Wave
    },

    -- MoP glyphs (only Major/Minor)
    glyphs = {
        major = {
            123904, -- Glyph of Fortifying Brew
            123986, -- Glyph of Zen Meditation
            123980  -- Glyph of Guard
        },
        minor = {
            123904, -- Glyph of Zen Flight
            123986  -- Glyph of Zen Meditation
        }
    },
    variables = {
        {
            name = [[FoF: Channel Time]],
            value = [[((NAG:DotTickFrequency(113656) * 4) + NAG:InputDelay())]]
        },
        {
            name = [[TEB: Active]],
            value = [[NAG:AuraIsActive(1247275, "player", true)]]
        },
        {
            name = [[RoRo: Equipped]],
            value = [[NAG:AuraIsKnown(139120)]]
        },
        {
            name = [[RoRo: Active]],
            value = [[(NAG:VariableRef("RoRo: Equipped") and NAG:AuraIsActive(139120, "player", true))]]
        }
    }
}
-- Monk Windwalker Rotation
local windwalkerRotation2 = {
    name = "WW RoRo attempt 2",
    specIndex = 3,
    class = "MONK",
    default = false,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { time = -1.5, action = "NAG:GetBattlePotion()" }
    },
    -- or ((NAG:MonkCurrentChi() <= 2) and NAG:AuraIsInactive(101546) and NAG:AuraIsInactive(113656) and ((1 and (true <= 10.0)) or 2 or (NAG:RemainingTime() < (true * 10)) or NAG:AllTrinketStatProcsActive(1))) and NAG:Cast(115399)
    -- removed the above.. to be placed AFTER the autocastotherCDs
    lastModified = "10/11/2025",
    rotationString = [[
NAG:VariableRef("WW Monk Debug")
    or (NAG:CurrentHealth("target") > 0 and NAG:CurrentHealth()*1.21 >= NAG:CurrentHealth("target")) and NAG:InEncounter() and NAG:Cast(126456)
    or NAG:SpellCanCast(115080) and NAG:InEncounter() and NAG:Cast(115080)
-- Fort Brew into Touch of Death

-- Storm, Earth, and Fire
    or NAG:GroupReference("Use SEF")

-- Potion
    or (NAG:AuraIsActive(2825, "player", false) or NAG:AuraIsActive(123904, "player", true) or (((NAG:SpellTimeToReady(123904) + 30) > NAG:RemainingTime()) and (NAG:AuraRemainingTime(1247275) > 12.0)) or (NAG:AuraIsActive(1247275, "player", true) and NAG:AuraIsActive(138228, "player", false) and (NAG:AuraNumStacks(138228, "player", false) == math.min((NAG:NumberTargets() - 1), 2)))) and NAG:Cast(76089)

-- Cooldowns: On use
    or NAG:GroupReference("Cooldowns: On use")

-- Chi Sphere Check
    or ((NAG:MonkCurrentChi() < NAG:MonkMaxChi()) and NAG:AuraIsActive(121286) and (not NAG:AuraIsActive(129914))) and NAG:Cast(121283)

-- Chi Brew
    or (((NAG:MonkCurrentChi() <= (NAG:MonkMaxChi() - 2)) and NAG:AuraIsActive(1247275) and (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > 4)) or ((NAG:MonkCurrentChi() <= (NAG:MonkMaxChi() - 2)) and (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > 4)) or (NAG:AuraIsActive(139120) and (NAG:AuraNumStacks(1247279) <= 8))) and NAG:Cast(115399)

--Tigereye Brew
    or (NAG:VariableRef("WW TEB Recast Allowed"))
        and (NAG:VariableRef("WW TEB Timing Allowed"))
        and (NAG:VariableRef("WW TEB ICD Allowed"))
        and (
            (NAG:AuraNumStacks(1247279) >= 19)
            or (
                (NAG:AuraNumStacks(1247279) >= 15)
                or (NAG:RemainingTime() < 30.0 and NAG:InEncounter())
                or (NAG:AuraNumStacks(1247279) >= 10)
                or ((NAG:CurrentTime() < 10 and NAG:InEncounter()) and (NAG:AuraNumStacks(1247279) >= 7))
            )
        )
        and NAG:Cast(1247275)

-- Energizing Brew
    or ((not NAG:AuraIsActive(2825)) and (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > 5.0)) and NAG:Cast(115288)

-- Xuen + other cooldowns
    or NAG:Cast(123904)
    or NAG:AutocastOtherCooldowns()

-- Rushing Jade Wind; yes, it's better on 2 target
    or (NAG:NumberTargets() >= 2) and NAG:Cast(116847)

-- Rising Sun Kick Uptime/CD
    or ((NAG:AuraRemainingTime(130320) <= 1) or (NAG:NumberTargets() < 2)) and NAG:Cast(130320)

-- Tiger Power Uptime
    or (NAG:AuraRemainingTime(125359) <= 2.5) and NAG:Cast(100787)

-- Spinning Crane Kick 4+
    or ((NAG:NumberTargets() >= 4) and (NAG:AuraRemainingTime(130320) >= 2.5)) and NAG:Cast(101546)

-- RSK CD
    or NAG:Cast(130320)

-- SCK 3+
    or (NAG:NumberTargets() >= 3) and NAG:Cast(101546)

-- Chi Wave
    or (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) >= 1.0) and NAG:Cast(115098)

-- Combo Breaker: Blackout Kick
    or NAG:AuraIsActive(116768) and NAG:Cast(100784)

-- Fists of Fury (RoRo-aware windowing)
    or (
        (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > NAG:VariableRef("FoF: Channel Time"))
        and ((not NAG:AuraIsActive(115288)) or (NAG:SpellIsKnown(116847) and (NAG:AuraRemainingTime(116847) >= NAG:VariableRef("FoF: Channel Time"))))
        and ((not NAG:VariableRef("RoRo: Active")) or (NAG:VariableRef("RoRo: Active") and ((NAG:AuraRemainingTime(139120) + (NAG:SpellGCDHastedDuration(113656) + NAG:InputDelay())) >= NAG:VariableRef("FoF: Channel Time")) and NAG:VariableRef("TEB: Active")))
    ) and NAG:Cast(113656)

-- Zen Sphere
    or ((NAG:NumberTargets() < 3) and (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > 2.0) and (NAG:AuraNumStacks(124081) < 2)) and NAG:Cast(124081)

-- Tiger Palm
    or ((NAG:CurrentTime() > 23) and (not NAG:AuraIsActive(115288)) and NAG:AuraIsActive(118864) and ((NAG:AuraRemainingTime(118864) <= 1.0) or (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) >= 2.0))) and NAG:Cast(100787)

-- Chi Burst
    or (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > 2.0) and NAG:Cast(123986)

-- Jab
    or ((NAG:MonkMaxChi() - NAG:MonkCurrentChi()) >= 2) and NAG:Cast(100780)

-- Zen Sphere lower
    or (NAG:AuraNumStacks(124081) < 2) and NAG:Cast(124081)

-- Chi Overcap Protection
    or ((((NAG:CurrentEnergy() + (NAG:EnergyRegenPerSecond() * NAG:SpellTimeToReady(130320))) >= 35) and (NAG:NumberTargets() <= 2)) or (((NAG:CurrentEnergy() + (NAG:EnergyRegenPerSecond() * NAG:SpellTimeToReady(130320))) >= 105) and (NAG:NumberTargets() >= 3))) and NAG:Cast(100784)


    or ((NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > 4)) and NAG:Cast(115288, nil, NAG.SPELL_POSITIONS.AOE)
    or (NAG:MonkCurrentChi() <= (NAG:MonkMaxChi() - 4)) and NAG:Cast(115399, nil, NAG.SPELL_POSITIONS.AOE)
    ]],

    -- Tracked IDs for optimization
    spells = {2825, 100780, 100784, 100787, 101546, 113656, 115080, 115098, 115288, 115399, 116768, 116847, 118864, 121283, 121286, 123904, 123986, 124081, 125359, 126456, 129914, 130320, 138228, 139120, 1247275, 1247279},
    items = {},

    -- MoP talents structure (one per tier)
    talents = {
        -- Tier 1 (Level 56)
        123904, -- Celerity
        -- Tier 2 (Level 57)
        123986, -- Chi Wave
        -- Tier 3 (Level 58)
        123980, -- Chi Burst
        -- Tier 4 (Level 60)
        123983, -- Chi Torpedo
        -- Tier 5 (Level 75)
        123986, -- Chi Wave
        -- Tier 6 (Level 90)
        123986  -- Chi Wave
    },

    -- MoP glyphs (only Major/Minor)
    glyphs = {
        major = {
            123904, -- Glyph of Fortifying Brew
            123986, -- Glyph of Zen Meditation
            123980  -- Glyph of Guard
        },
        minor = {
            123904, -- Glyph of Zen Flight
            123986  -- Glyph of Zen Meditation
        }
    },
    groups = {
        {
            name = [[Cooldowns: On use]],
            actions = {
                [[(NAG:AuraIsActive(2825, "player", false) or NAG:AuraIsActive(123904, "player", true) or (((NAG:SpellTimeToReady(123904) + 25.0) > NAG:RemainingTime()) and (NAG:AuraRemainingTime(1247275) > 14.0)) or (NAG:VariableRef("TEB: Active") and NAG:AuraIsActive(138228, "player", false) and (NAG:AuraNumStacks(138228, "player") == math.min((NAG:NumberTargets() - 1), 2)))) and NAG:GetBattlePotion() and NAG:Cast(NAG:GetBattlePotion())]],
                [[NAG:VariableRef("TEB: Active") and NAG:Cast(126734)]],
                [[NAG:VariableRef("TEB: Active") and NAG:Cast(121279)]],
                [[NAG:VariableRef("TEB: Active") and NAG:Cast(33697)]],
                [[NAG:VariableRef("TEB: Active") and NAG:Cast(26297)]]
            }
        },
        {
            name = [[Use SEF]],
            actions = {
                [[(((NAG:NumberTargets() == 2) and (NAG:AuraNumStacks(138228, "player", false) < 1))) and NAG:Cast(138228)]],
                [[((NAG:VariableRef("Targets: More than 2") and (NAG:AuraNumStacks(138228, "player", false) < 2))) and NAG:Sequence("sef", nil, 138228, 138228)]]
            }
        },
        {
            name = [[Internal: Cast TEB]],
            actions = {
                [[NAG:Cast(1247275)]]
            }
        },
        {
            name = [[RoRo: TEB - Actions]],
            actions = {
                [[(NAG:VariableRef("TEB: Inactive") and (NAG:AuraNumStacks(1247279, "player", false) >= 10)) and NAG:GroupReference("Internal: Cast TEB")]],
                [[(NAG:VariableRef("TEB: Inactive") and (NAG:AuraNumStacks(1247279, "player", false) >= 8) and (NAG:AuraRemainingTime(139120) <= 3.0)) and NAG:GroupReference("Internal: Cast TEB")]],
                [[(NAG:VariableRef("TEB: Inactive") and (NAG:AuraNumStacks(1247279, "player", false) >= 6) and (NAG:AuraRemainingTime(139120) <= 2.0)) and NAG:GroupReference("Internal: Cast TEB")]],
                [[(NAG:VariableRef("TEB: Inactive") and (NAG:AuraNumStacks(1247279, "player", false) >= 4) and (NAG:AuraRemainingTime(139120) <= 0.5)) and NAG:GroupReference("Internal: Cast TEB")]],
                [[(NAG:VariableRef("TEB: Active") and (NAG:AuraNumStacks(1247279, "player", false) >= 5) and (NAG:AuraRemainingTime(139120) <= 0.5)) and NAG:GroupReference("Internal: Cast TEB")]]
            }
        },
        {
            name = [[RoRo: TEB - Cast]],
            actions = {
                [[NAG:VariableRef("RoRo: Active") and NAG:GroupReference("RoRo: TEB - Actions")]]
            }
        }
    },
    variables = {
        {
            name = [[Targets: Max 2]],
            value = [[(NAG:NumberTargets() <= 2)]]
        },
        {
            name = [[Targets: More than 1]],
            value = [[(NAG:NumberTargets() >= 2)]]
        },
        {
            name = [[Targets: More than 2]],
            value = [[(NAG:NumberTargets() >= 3)]]
        },
        {
            name = [[FoF: Channel Time]],
            value = [[((NAG:DotTickFrequency(113656) * 4) + NAG:InputDelay())]]
        },
        {
            name = [[TEB: Active]],
            value = [[NAG:AuraIsActive(1247275, "player", true)]]
        },
        {
            name = [[TEB: Inactive]],
            value = [[(not NAG:AuraIsActive(1247275, "player", true))]]
        },
        {
            name = [[RoRo: Equipped]],
            value = [[NAG:AuraIsKnown(139120)]]
        },
        {
            name = [[RoRo: Active]],
            value = [[(NAG:VariableRef("RoRo: Equipped") and NAG:AuraIsActive(139120, "player", true))]]
        },
        {
            name = [[WW Monk Debug]],
            value = [[NAG:WWMonkDebug()]]
        },
        {
            name = [[WW TEB Recast Allowed]],
            value = [[NAG:WWMonkTEBRecastAllowed()]]
        },
        {
            name = [[WW TEB Timing Allowed]],
            value = [[NAG:WWMonkTEBTimingAllowed()]]
        },
        {
            name = [[WW TEB ICD Allowed]],
            value = [[NAG:WWMonkTEBICDAllowedAttempt2()]]
        }
    }
}
-- Monk Windwalker Rotation
local windwalkerRotationRoro = {
    name = "WW RoRo",
    specIndex = 3,
    class = "Monk",
    default = false,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_MISTS,
    prePull = {
        { time = -20.0, action = "NAG:Cast(103985)" },
            { time = -1.0, action = "NAG:Cast(115098)" },
            { time = -0.1, action = "NAG:Cast(76089)" }
    },
    lastModified = "10/11/2025",
    rotationString = [[
-- Strictsequence filtered: only spellIds from NAG:Cast, removed none
    NAG:GroupReference("Wait for Channeling")
    or NAG:GroupReference("Use SEF")
    or (NAG:AuraIsActive(2825, "player", false) or NAG:AuraIsActive(123904, "player", true) or (((NAG:SpellTimeToReady(123904) + 30) > NAG:RemainingTime()) and (NAG:AuraRemainingTime(1247275) > 12.0)) or (NAG:AuraIsActive(1247275, "player", true) and NAG:AuraIsActive(138228, "player", false) and (NAG:AuraNumStacks(138228, "player", false) == math.min((NAG:NumberTargets() - 1), 2)))) and NAG:Cast(76089)
    or ((NAG:MonkCurrentChi() < NAG:MonkMaxChi()) and NAG:AuraIsActive(121286, "player", true) and NAG:AuraIsInactive(129914, "player", true)) and NAG:Cast(121283)
    or (((NAG:CurrentTime() > 5.0) and (NAG:CurrentTime() < 10.0) and (NAG:MonkCurrentChi() <= (NAG:MonkMaxChi() - 2))) or ((NAG:MonkCurrentChi() <= (NAG:MonkMaxChi() - 2)) and NAG:AuraIsActive(1247275, "player", true) and (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > 4)) or (NAG:VariableRef("RoRo: Active") and (((NAG:AuraNumStacks(1247279, "player", false) <= 8))))) and NAG:Cast(115399)
    or NAG:GroupReference("RoRo: TEB - Cast")
    or ((not NAG:AuraIsActive(1247275, "player", true)) and NAG:GCDIsReady() and ((NAG:AuraNumStacks(1247279, "player", true) >= 19) or ((NAG:MonkCurrentChi() >= 2) and ((NAG:AuraNumStacks(1247279, "player", true) >= 15) or (NAG:RemainingTime() < 30.0) or (NAG:AllTrinketStatProcsActive(2, -1, -1, 40) and (NAG:AuraNumStacks(1247279, "player", false) >= 10)) or ((NAG:CurrentTime() < 10.0) and (NAG:AuraNumStacks(1247279, "player", false) >= 7)))))) and NAG:Cast(1247275)
    or (NAG:AuraIsInactive(2825, "player", true) and (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > 5.0)) and NAG:Cast(115288)
    or NAG:AutocastOtherCooldowns()
    or NAG:VariableRef("Targets: More than 1") and NAG:Cast(116847)
    or ((NAG:AuraRemainingTime(130320, "target") <= 1.0) or (not NAG:VariableRef("Targets: More than 2"))) and NAG:Cast(130320)
    or (NAG:AuraRemainingTime(125359) <= 1.0) and NAG:Cast(100787)
    or ((NAG:NumberTargets() >= 4) and (NAG:AuraRemainingTime(130320, "target") >= 2.25)) and NAG:Cast(101546)
    or NAG:Cast(130320)
    or (NAG:VariableRef("Targets: More than 2")) and NAG:Cast(101546)
    or (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) >= 1.0) and NAG:Cast(115098)
    or NAG:AuraIsActive(116768, "player", true) and NAG:Cast(100784)
    or ((not NAG:AuraIsActive(115288, "player", true)) and (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > 4.0) and ((not NAG:VariableRef("RoRo: Active")) or (NAG:VariableRef("RoRo: Active") and (NAG:AuraRemainingTime(139120) <= NAG:SpellCastTime(113656)) and (not NAG:AuraIsActive(1247275, "player", true))))) and NAG:Cast(113656)
    or ((not NAG:VariableRef("Targets: More than 2")) and (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > 2.0) and (NAG:AuraNumStacks(124081, "player", true) < 2)) and NAG:Cast(124081)
    or ((NAG:CurrentTime() > 23.0) and NAG:AuraIsInactive(115288, "player", true) and NAG:AuraIsActive(118864, "player", true) and ((NAG:AuraRemainingTime(118864) <= 1.0) or (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) >= 2.0))) and NAG:Cast(100787)
    or (NAG:EnergyTimeToTarget(NAG:MaxEnergy()) > 2.0) and NAG:Cast(123986)
    or ((NAG:MonkMaxChi() - NAG:MonkCurrentChi()) >= 2) and NAG:Cast(100780)
    or (NAG:AuraNumStacks(124081, "player", true) < 2) and NAG:Cast(124081)
    or NAG:Cast(116847)
    or ((((NAG:CurrentEnergy() + (NAG:EnergyRegenPerSecond() * NAG:SpellTimeToReady(130320))) >= 35) and NAG:VariableRef("Targets: Max 2")) or (((NAG:CurrentEnergy() + (NAG:EnergyRegenPerSecond() * NAG:SpellTimeToReady(130320))) >= 105) and NAG:VariableRef("Targets: More than 2"))) and NAG:Cast(100784)
    ]],

    -- Tracked IDs for optimization
    spells = {2825, 100780, 100784, 100787, 101546, 113656, 115080, 115098, 115288, 115399, 116768, 116847, 118864, 121283, 121286, 123904, 123986, 124081, 125359, 129914, 130320, 138228, 139120, 1247275, 1247279},
    items = {76089},
    auras = {},
    runes = {},
    glyphs = {
        major = {85697, 87900},  -- Spinning Crane Kick, Touch of Karma
        minor = {90715}          -- Blackout Kick
    },
    consumables = { prepotId = 76089, potId = 76089, flaskId = 76084, foodId = 74648 },

    -- Groups and Variables from WoWSims APL
    groups = {
        {
            name = [[Wait for Channeling]],
            actions = {
                [[NAG:SpellIsChanneling(113656) and NAG:WaitUntil(function() return (not NAG:SpellIsChanneling(113656)) end)]],
                [[NAG:SpellIsChanneling(101546) and NAG:WaitUntil(function() return (not NAG:SpellIsChanneling(101546)) end)]]
            }
        },
        {
            name = [[Use SEF]],
            actions = {
                [[(((NAG:NumberTargets() == 2) and (NAG:AuraNumStacks(138228, "player", false) < 1))) and NAG:Cast(138228)]],
                [[((NAG:VariableRef("Targets: More than 2") and (NAG:AuraNumStacks(138228, "player", false) < 2))) and NAG:Sequence("sef", nil, 138228, 138228)]]
            }
        },
        {
            name = [[Internal: Cast TEB]],
            actions = {
                [[NAG:Cast(1247275)]]
            }
        },
        {
            name = [[RoRo: TEB - Actions]],
            actions = {
                [[(NAG:VariableRef("TEB: Inactive") and (NAG:AuraNumStacks(1247279, "player", false) >= 10)) and NAG:GroupReference("Internal: Cast TEB")]],
                [[(NAG:VariableRef("TEB: Inactive") and (NAG:AuraNumStacks(1247279, "player", false) >= 8) and (NAG:AuraRemainingTime(139120) <= 3.0)) and NAG:GroupReference("Internal: Cast TEB")]],
                [[(NAG:VariableRef("TEB: Inactive") and (NAG:AuraNumStacks(1247279, "player", false) >= 6) and (NAG:AuraRemainingTime(139120) <= 2.0)) and NAG:GroupReference("Internal: Cast TEB")]],
                [[(NAG:VariableRef("TEB: Inactive") and (NAG:AuraNumStacks(1247279, "player", false) >= 4) and (NAG:AuraRemainingTime(139120) <= 0.5)) and NAG:GroupReference("Internal: Cast TEB")]],
                [[(NAG:VariableRef("TEB: Active") and (NAG:AuraNumStacks(1247279, "player", false) >= 5) and (NAG:AuraRemainingTime(139120) <= 0.5)) and NAG:GroupReference("Internal: Cast TEB")]]
            }
        },
        {
            name = [[RoRo: TEB - Cast]],
            actions = {
                [[NAG:VariableRef("RoRo: Active") and NAG:GroupReference("RoRo: TEB - Actions")]]
            }
        }
        },
    variables = {
        {
            name = [[Targets: Max 2]],
            value = [[(NAG:NumberTargets() <= 2)]]
        },
        {
            name = [[Targets: More than 1]],
            value = [[(NAG:NumberTargets() >= 2)]]
        },
        {
            name = [[Targets: More than 2]],
            value = [[(NAG:NumberTargets() >= 3)]]
        },
        {
            name = [[TEB: Active]],
            value = [[NAG:AuraIsActive(1247275, "player", true)]]
        },
        {
            name = [[TEB: Inactive]],
            value = [[(not NAG:AuraIsActive(1247275, "player", true))]]
        },
        {
            name = [[RoRo: Equipped]],
            value = [[NAG:AuraIsKnown(139120)]]
        },
        {
            name = [[RoRo: Active]],
            value = [[(NAG:VariableRef("RoRo: Equipped") and NAG:AuraIsActive(139120, "player", true))]]
        }
        },

    -- Optional metadata
    talentsString = "213322",
    author = "APLParser"
}
-- END OF GENERATED_ROTATIONS

--- @class MONK : ClassBase
local MONK = NAG:CreateClassModule("MONK", defaults)

-- Setup class defaults during PreDatabaseRegistration
function MONK:SetupClassDefaults()
    -- ✅ Add rotations to defaults using the new system
    ns.AddRotationToDefaults(self.defaults, 0, genericRotation)  -- Generic (no spec)
    ns.AddRotationToDefaults(self.defaults, 1, brewmasterRotation)  -- Brewmaster
    ns.AddRotationToDefaults(self.defaults, 1, brewmasterRotationOffensively)  -- Brewmaster
    ns.AddRotationToDefaults(self.defaults, 2, mistweaverRotation)  -- Mistweaver
    ns.AddRotationToDefaults(self.defaults, 3, windwalkerRotation)  -- Windwalker
    ns.AddRotationToDefaults(self.defaults, 3, windwalkerRotation2)  -- Windwalker
    --ns.AddRotationToDefaults(self.defaults, 3, windwalkerRotationRoro)  -- Windwalker

end

-- Register spell tracking if needed
function MONK:RegisterSpellTracking()
    if not SpellTrackingManager then return end

    -- Track Monk specific mechanics
    SpellTrackingManager:RegisterCastTracking({ 100780 }, { count = 0, startTime = GetTime() }) -- Jab
    SpellTrackingManager:RegisterCastTracking({ 100787 }, { count = 0, startTime = GetTime() }) -- Tiger Palm
    SpellTrackingManager:RegisterCastTracking({ 115072 }, { count = 0, startTime = GetTime() }) -- Expel Harm
end

-- Make the module available globally through NAG
NAG.Class = MONK
