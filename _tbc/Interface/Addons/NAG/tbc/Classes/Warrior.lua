local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version

local defaults = ns.InitializeClassDefaults()
defaults.class.allowMultipleAssignments = true

-- TBC Warrior spec spell locations
defaults.class.specSpellLocations = {
    [1] = { -- Arms
        [845] = NAG.SPELL_POSITIONS.BELOW,   -- Cleave (Rank 1)
		[78] = NAG.SPELL_POSITIONS.BELOW,   -- Heroic Strike (Rank 1)


        [12328] = NAG.SPELL_POSITIONS.AOE,   -- Sweeping Strikes
        [2048] = NAG.SPELL_POSITIONS.LEFT,    -- Battle Shout (Rank 1)
        [2687] = NAG.SPELL_POSITIONS.BELOW,     -- Bloodrage
        --[100] = NAG.SPELL_POSITIONS.BELOW,     -- Charge
        [20252] = NAG.SPELL_POSITIONS.BELOW,     -- Intercept (Rank 1)

        [6343] = NAG.SPELL_POSITIONS.AOE,    -- Thunder Clap (Rank 1)
        [1160] = NAG.SPELL_POSITIONS.AOE,   -- Demoralizing Shout (Rank 1)


        [1719] = NAG.SPELL_POSITIONS.LEFT,     -- Recklessness
        [20572] = NAG.SPELL_POSITIONS.LEFT,     -- Blood Fury (Orc Racial)
        [26297] = NAG.SPELL_POSITIONS.LEFT,     -- Berserking (Troll Racial)
        [12292] = NAG.SPELL_POSITIONS.LEFT,    -- Death Wish
        [18499] = NAG.SPELL_POSITIONS.LEFT,    -- Berserker Rage
        [7386] = NAG.SPELL_POSITIONS.ABOVE,     -- Sunder Armor (Rank 1)
        [1715] = NAG.SPELL_POSITIONS.BELOW,     -- Hamstring (Rank 1)
    },
    [2] = { -- Fury
        [845] = NAG.SPELL_POSITIONS.BELOW,   -- Cleave (Rank 1)
		[78] = NAG.SPELL_POSITIONS.BELOW,   -- Heroic Strike (Rank 1)

        [20572] = NAG.SPELL_POSITIONS.LEFT,     -- Blood Fury (Orc Racial)
        [26297] = NAG.SPELL_POSITIONS.LEFT,     -- Berserking (Troll Racial)
        [12328] = NAG.SPELL_POSITIONS.RIGHT,   -- Sweeping Strikes
        [2048] = NAG.SPELL_POSITIONS.ABOVE,    -- Battle Shout (Rank 1)
        [2687] = NAG.SPELL_POSITIONS.ABOVE,     -- Bloodrage
        [100] = NAG.SPELL_POSITIONS.BELOW,     -- Charge
        [20252] = NAG.SPELL_POSITIONS.BELOW,     -- Intercept (Rank 1)

        [6343] = NAG.SPELL_POSITIONS.ABOVE,    -- Thunder Clap (Rank 1)
        [1160] = NAG.SPELL_POSITIONS.ABOVE,   -- Demoralizing Shout (Rank 1)

        [1719] = NAG.SPELL_POSITIONS.LEFT,     -- Recklessness
        [12292] = NAG.SPELL_POSITIONS.RIGHT,    -- Death Wish
        [18499] = NAG.SPELL_POSITIONS.RIGHT,    -- Berserker Rage
        [7386] = NAG.SPELL_POSITIONS.RIGHT,     -- Sunder Armor (Rank 1)
        [1715] = NAG.SPELL_POSITIONS.BELOW,     -- Hamstring (Rank 1)
    },
    [3] = { -- Protection
        [845] = NAG.SPELL_POSITIONS.BELOW,   -- Cleave (Rank 1)
		[78] = NAG.SPELL_POSITIONS.BELOW,   -- Heroic Strike (Rank 1)

        [20572] = NAG.SPELL_POSITIONS.LEFT,     -- Blood Fury (Orc Racial)
        [26297] = NAG.SPELL_POSITIONS.LEFT,     -- Berserking (Troll Racial)
        [12328] = NAG.SPELL_POSITIONS.ABOVE,   -- Sweeping Strikes
        [2048] = NAG.SPELL_POSITIONS.ABOVE,    -- Battle Shout (Rank 1)
        [2687] = NAG.SPELL_POSITIONS.ABOVE,     -- Bloodrage
        [100] = NAG.SPELL_POSITIONS.BELOW,     -- Charge
        [20252] = NAG.SPELL_POSITIONS.BELOW,     -- Intercept (Rank 1)
        [1715] = NAG.SPELL_POSITIONS.BELOW,     -- Hamstring (Rank 1)

        [6343] = NAG.SPELL_POSITIONS.ABOVE,    -- Thunder Clap (Rank 1)
        [1160] = NAG.SPELL_POSITIONS.ABOVE,   -- Demoralizing Shout (Rank 1)

        [1719] = NAG.SPELL_POSITIONS.LEFT,     -- Recklessness
        [12292] = NAG.SPELL_POSITIONS.RIGHT,    -- Death Wish
        [18499] = NAG.SPELL_POSITIONS.RIGHT,    -- Berserker Rage
        [7386] = NAG.SPELL_POSITIONS.RIGHT,     -- Sunder Armor (Rank 1)
    },
}


--- Check if dual-wield warrior should show weapon speed alert
--- Shows alert when MH and OH weapons have the same speed (bad for dual wielding)
function NAG:DualWieldWarriorShouldCheckWeapons()
    -- Get weapon speeds using swing timer library
    local swingTimerLib = LibStub("LibClassicSwingTimerAPI", true)
    if not swingTimerLib then return false end

    local mhSpeed = swingTimerLib:UnitSwingTimerInfo("player", "mainhand")
    local ohSpeed = swingTimerLib:UnitSwingTimerInfo("player", "offhand")

    -- Check if both weapons exist and have the same speed
    if not mhSpeed or not ohSpeed or ohSpeed == 0 then
        return false -- Not dual wielding or offhand is shield
    end

    -- Alert if speeds are the same (within 0.1 second tolerance for floating point)
    return math.abs(mhSpeed - ohSpeed) < 0.1
end


-- Class assignments for raid coordination
defaults.class.classAssignments = {
    {
        id = "sunder_armor",
        name = "Sunder Armor",
        description = "Apply armor reduction debuff on targets (5 stacks, -520 armor each at max rank). Conflicts with Rogue Expose Armor - coordinate with raid for armor debuff coverage.",
        spellIds = {7386, 7405, 8380, 11596, 11597, 25225}, -- All ranks of Sunder Armor
        category = "debuff",
    },
    {
        id = "demoralizing_shout",
        name = "Demoralizing Shout",
        description = "Reduce enemy attack power (coordinate with other Warriors)",
        spellIds = {1160, 6190, 11554, 11555, 11556, 25202, 25203}, -- All ranks
        category = "debuff",
    },
    {
        id = "thunder_clap",
        name = "Thunder Clap",
        description = "Reduce enemy attack speed (coordinate with other Warriors)",
        spellIds = {6343, 8198, 8205, 11580, 11581, 25264}, -- All ranks
        category = "debuff",
    },
}

if UnitClassBase('player') ~= "WARRIOR" then return end

-- Generic (0 talent points): low-level abilities before choosing a spec
local genericRotation = {
    name = "Generic",
    specIndex = 0,
    class = "WARRIOR",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    rotationString = [[
    (not NAG:AuraIsActive(2048)) and NAG:SpellCanCast(2048) and NAG:Cast(2048)
    or (not NAG:InCombat("player")) and NAG:SpellCanCast(100) and NAG:Cast(100)
    or (NAG:SpellCanCast(772) and (not NAG:DotIsActive(772, "target"))) and NAG:Cast(772)
    or (NAG:SpellCanCast(78)) and NAG:Cast(78)
]],
}

-- Arms Rotation
local armsRotation = {
    -- Core identification
    name = "Arms",
    specIndex = 1,
    class = "WARRIOR",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    customConditions = {
        {
            type = ns.CUSTOM_CONDITION_TYPES.WEAPON_TYPE,
            value = "twoHand"  -- This rotation is optimal for 2H weapons
        },
    },
    lastModified = "01/03/2026",
    rotationString = [[
    -- Swap to Kebab Arms when equipped with offhand (dual wield or 1H+shield)
    (NAG:IsDualWield()) and NAG:SelectRotation("Arms (Kebab)")
    or NAG:EnableTBCWarriorBars()
    or NAG:EnableAssignmentsGate()
    -- Keep bar state updated without interrupting APL flow (always returns false)
    or NAG:WarriorSlamWeaveSetBarDimmedWithDebug()

    -- Start auto-attacking from distance to avoid swing hiccup on first engage
    --or (NAG:CurrentHealth("target") > 0) and NAG:NeedsToStartAttacking() and NAG:ShowCustomOverlay("Start attacking\nfrom distance!")
    -- Off-GCD queue: Cleave / Heroic Strike (rage gated, safe to check early)
    -- AoE Cleave: relaxed gates for dungeon scenarios (new clauses at top)
    -- Clause A: Mobs die in <=20s -> no SS gate, keep rage 70
    or ((NAG:NumberTargets() >= 2) and (NAG:RemainingTime() <= 20) and (NAG:RemainingTime() > 0)
        and (NAG:CurrentRageAtGCD() >= 70) and (not NAG:IsQueued(845)) and NAG:SpellCanCast(845))
        and NAG:Cast(845, nil, NAG.SPELL_POSITIONS.BELOW)
    -- Clause B: SS not active and on CD -> no SS gate, keep rage 70
    or ((NAG:NumberTargets() >= 2) and (not NAG:AuraIsActive(12328)) and (NAG:SpellTimeToReady(12328) > 0 or not(NAG:SpellIsKnown(12328)))
        and (NAG:CurrentRageAtGCD() >= 70) and (not NAG:IsQueued(845)) and NAG:SpellCanCast(845))
        and NAG:Cast(845, nil, NAG.SPELL_POSITIONS.BELOW)
    -- Clause C: SS+WW on CD, mobs die in <=10s -> no rage gate
    or ((NAG:NumberTargets() >= 2) and (NAG:SpellTimeToReady(12328) > 0 or not(NAG:SpellIsKnown(12328))) and (NAG:SpellTimeToReady(1680) > 0)
        and (NAG:RemainingTime() <= 10) and (NAG:RemainingTime() > 0)
        and (not NAG:IsQueued(845)) and NAG:SpellCanCast(845))
        and NAG:Cast(845, nil, NAG.SPELL_POSITIONS.BELOW)
    -- Clause D: if mobs will die in the next 6 seconds and WW on cd, no rage gate
    or ((NAG:AuraIsActive(12328) and NAG:NumberTargets() >= 2) and (NAG:RemainingTime() <= 6) and (NAG:RemainingTime() > 0)
        and (NAG:SpellTimeToReady(1680) > 0) and (not NAG:IsQueued(845)) and NAG:SpellCanCast(845))
        and NAG:Cast(845, nil, NAG.SPELL_POSITIONS.BELOW)
    or ((NAG:AuraIsActive(12328) and NAG:NumberTargets() >= 2) and (NAG:CurrentRageAtGCD() >= 70)
        and (not NAG:IsQueued(845)) and NAG:SpellCanCast(845))
        and NAG:Cast(845, nil, NAG.SPELL_POSITIONS.PRIMARY)
    or ((NAG:CurrentRageAtGCD() >= 70) and (not NAG:WarriorSlamWeaveIsInHoldRegion(0.10, 0.05))
        and (not NAG:IsQueued(78)) and NAG:SpellCanCast(78))
        and NAG:Cast(78, nil, NAG.SPELL_POSITIONS.BELOW)
    or
    -- Maintain Battle Shout (rank-aware via resolved helpers)
    (not NAG:WarriorSlamWeaveIsBarVisible())
        and ((not NAG:AuraIsActive(2048)) or (NAG:AuraRemainingTime(2048, "player") <= 10))
        and NAG:SpellCanCast(2048)
        and NAG:Cast(2048)


    -- Battle Shout or Demoralizing Shout if needed (only if assigned + fits before HOLD)
    or ((not NAG:WarriorSlamWeaveIsBarVisible()) and (NAG:GetNumGroupMembers() > 0) and NAG:IsAssignmentEnabled("demoralizing_shout")
        and ((not NAG:AuraIsActive(1160, "target")) or (NAG:AuraRemainingTime(1160, "target") <= 10))
        and NAG:SpellCanCast(1160))
        and NAG:Cast(1160)


    or NAG:InCombat("player") and NAG:CurrentRage() < 15 and (not NAG:IsWarriorInBerserkerStance()) and NAG:Cast(2458)

    -- Gap closers: Charge out of combat, Intercept in combat (8+ yards)
    -- Use Bloodrage
    or NAG:InCombat() and (NAG:SpellCanCast(2687) and (not NAG:AuraIsActive(2687))) and NAG:Cast(2687)

-- battle stance > charge > berserker stance > bloodrage >
-- bloodrage
or NAG:IsWarriorInBattleStance() and (not NAG:InCombat("player")) and NAG:SpellCanCast(2687) and NAG:SpellTimeToReady(100) <= 0
    and NAG:CurrentRage() <= 5 and (not NAG:AuraIsActive(2687))
    and NAG:CastPlaceHolderWithArrow(2687, "left1", "RIGHT", 1.5)
-- berserker stance
or NAG:IsWarriorInBattleStance() and (not NAG:InCombat("player")) and NAG:SpellTimeToReady(100) <= 0 and NAG:CurrentRage() <= 5
    and NAG:CastPlaceHolderWithArrow(2458, "left2", "RIGHT", 1.5)
-- charge
or NAG:IsWarriorInBattleStance() and ((not NAG:InCombat("player")) and NAG:SpellTimeToReady(100) <= 0 and NAG:CurrentRage() <= 5
    and NAG:CastPlaceHolderWithArrow(100, "left3", "RIGHT", 1.5))
-- battle stance
or (not NAG:InCombat("player")) and NAG:CurrentRage() <= 5 and NAG:SpellTimeToReady(100) <= 0
    and (not NAG:IsWarriorInBattleStance()) and NAG:Cast(2457, nil, NAG.SPELL_POSITIONS.LEFT)



    or (NAG:InCombat("player") and NAG:HasRage(20252) and (NAG:UnitDistance("target") > 8) and NAG:SpellCanCast(20252))
        and NAG:Cast(20252, nil, NAG.SPELL_POSITIONS.BELOW)


    -- Use Death Wish, Recklessness, and any on-use effects
    or NAG:InCombat("player") and (NAG:SpellCanCast(12292) and (not NAG:AuraIsActive(12292))) and NAG:Cast(12292)
    or NAG:InEncounter() and ((NAG:PlayerIsInRaid() and NAG:RemainingTime() > 4) or (not NAG:PlayerIsInRaid() and NAG:RemainingTime() > 8))
        and (NAG:AuraIsActive(12292) and ((NAG:UnitAura("player", 2825) ~= false) or (NAG:UnitAura("player", 32182) ~= false)))
        and (NAG:SpellCanCast(1719) and (not NAG:AuraIsActive(1719))) and NAG:Cast(1719)
    -- Use Sweeping Strikes for AoE
    or (NAG:NumberTargets() >= 2) and NAG:Cast(12328)


    -- Execute phase: use WW/MS first, then Execute (only if it fits before HOLD). Gate: target selected, alive, in combat.
    or ((NAG:IsExecutePhase(21) or (NAG:TimeToPercent(20) < NAG:AutoTimeToNext())) and NAG:UnitExists("target") and NAG:CurrentHealth("target") > 0 and NAG:InCombat("player") and (NAG:NumberTargets() >= 2)
        and NAG:SpellCanCast(1680)) and NAG:HasRage(1680)
        and NAG:Cast(1680)
    or ((NAG:IsExecutePhase(21) or (NAG:TimeToPercent(20) < NAG:AutoTimeToNext())) and NAG:UnitExists("target") and NAG:CurrentHealth("target") > 0 and NAG:InCombat("player")
        and NAG:SpellCanCast(12294))
        and NAG:HasRage(12294) and NAG:Cast(12294)
    or ((NAG:IsExecutePhase(21) or (NAG:TimeToPercent(20) < NAG:AutoTimeToNext())) and NAG:UnitExists("target") and NAG:CurrentHealth("target") > 0 and NAG:InCombat("player")
        and NAG:SpellCanCast(5308))
        and NAG:Cast(5308)

    -- ============================ SLAM WEAVING CORE ============================
    -- Slam NOW: immediately after a swing impact (short post-swing window).
    -- Requires WarriorSlamWeaveModule swing tracking; falls back to no-op if module disabled.
    or (NAG:InCombat() and NAG:WarriorSlamWeaveIsBarVisible()
        and NAG:WarriorSlamWeave())

    -- Non-execute: AoE WW, then MS/WW fillers (only if they fit before HOLD)
    or ((not NAG:IsExecutePhase(20)) and (NAG:NumberTargets() >= 2)
        and NAG:SpellCanCast(1680))
        and NAG:WarriorSlamWeaveHasRageAfterSlam(1680) and NAG:Cast(1680)
    or ((not NAG:IsExecutePhase(20))
        and NAG:SpellCanCast(12294))
        and NAG:WarriorSlamWeaveHasRageAfterSlam(12294) and NAG:Cast(12294)
    or ((not NAG:IsExecutePhase(20))
        and NAG:SpellCanCast(1680))
        and NAG:WarriorSlamWeaveHasRageAfterSlam(1680) and NAG:Cast(1680)

    or NAG:InCombat("player") and (not NAG:IsWarriorInBerserkerStance()) and NAG:Cast(2458)
    or not(NAG:InCombat("player")) and NAG:Cast(1680, nil, NAG.SPELL_POSITIONS.AOE)
    or not(NAG:InCombat("player")) and NAG:Cast(12294)
    or NAG:WarriorSlamWeaveForceShow() or NAG:WarriorSlamWeaveWait()
    ]],

    -- Tracked IDs for optimization
    spells = {
        1680,  -- Whirlwind
        25202, -- Demoralizing Shout
        25231, -- Cleave
        25234, -- Execute
        25236, -- Execute (alt rank used in other rotations)
        25248, -- Mortal Strike
        25286, -- Heroic Strike
        25289, -- Battle Shout
        12292, -- Death Wish
        12328, -- Sweeping Strikes
        1719,  -- Recklessness
        2687,  -- Bloodrage
        -- Slam ranks (for lower-level / rank variance)
        25241, -- Slam (Rank 6, TBC)
        11605, -- Slam (Rank 5)
        11604, -- Slam (Rank 4)
        8820,  -- Slam (Rank 3)
        1464,  -- Slam (Rank 1)
        25242, -- (legacy/unknown; kept for compatibility with existing tracking)
    },
    items = {},
    auras = {25289, 25202, 12292, 1719, 12328, 2687}, -- Battle Shout, Demoralizing Shout, Death Wish, Recklessness, Sweeping Strikes, Bloodrage

    -- Optional metadata
    guide = [[
Arms Warrior Rotation Guide (TBC)

Core Mechanics:
- Slam weaving is a timing problem: you must respect swing cadence AND GCD cadence.
- Slam should be used as a *post-swing* action (right after a swing lands), not pre-swing.
- Starting a full GCD too close to the next swing prevents you from Slamming immediately after it.
- Haste and weapon speed change the window sizes dynamically (shorter swings = tighter windows).
- Rage management is essential - use Heroic Strike only with excess rage and avoid starving Slam/MS/WW.
- Arms Warriors provide Mortal Strike debuff (healing reduction) to raid.

Rotation Priority (Single Target):
1. Maintain Battle Shout
2. Bloodrage on cooldown (if appropriate)
3. Major cooldowns (Death Wish, Recklessness) as configured
4. After a swing lands: Slam immediately (\"NOW\" window)
5. Between swings (when safe): Mortal Strike / Whirlwind (only if the GCD will finish before the next swing)
6. Before the next swing (\"HOLD\" region): do not start a new GCD; wait so you can Slam after the swing
7. Execute phase: Execute as a filler only when it still fits before the next HOLD boundary

Slam Weaving Phases (per swing cycle):
- Post-swing \"NOW\": a short window right after the swing impact where Slam should be pressed.
- Mid-cycle: safe region where you can spend a GCD on MS/WW/utility.
- Pre-swing \"HOLD\": a region where spending a full GCD would overlap the next swing; wait here to preserve the post-swing Slam.

AoE Rotation:
1. Use Sweeping Strikes (allows next 5 melee attacks to hit additional nearby target)
2. Prioritize Whirlwind over Mortal Strike (when it fits before HOLD)
3. Queue Cleave when Sweeping Strikes is active (off-GCD)

Slam Cast Time:
- Slam cast time depends on your talents/character state.
- Without Improved Slam, Slam is slower and fewer Slam inserts will be feasible; the timing helpers will naturally become more conservative.

Addon Timing Helpers (what the APL uses):
- `WarriorSlamWeaveIsInSlamNowWindow(0.25)`: swing just happened -> Slam \"NOW\".
- `WarriorSlamWeaveIsInHoldRegion(0.10, 0.05)`: don't start a new GCD -> show Slam \"HOLD\".
- `WarriorSlamWeaveCanCastFillerBeforeHold(spellId, 0.10)`: only suggest fillers that won't overlap the next swing.

Cooldowns:
- Death Wish: 3min CD. Increases physical damage by 20%, reduces armor by 20%.
- Recklessness: 30min CD. Increases crit chance by 100% for 15 seconds.
- Sweeping Strikes: 30sec CD. Next 5 melee attacks hit additional nearby target.
- Bloodrage: 60sec CD. Generates 10 rage over 10 seconds.

Rage Management:
- Battle Shout: Costs rage but provides raid buff - maintain it
- Heroic Strike: Use only with excess rage and avoid it in tight timing regions (it replaces your next swing)
- Execute: Only usable when target is below 20% health - high damage but expensive; still respect timing windows
- Demoralizing Shout: Use if assigned for raid debuff coordination

Raid Utility:
- Mortal Strike: Reduces healing received by target by 50% (important debuff)
- Battle Shout: Provides attack power buff to raid
- Demoralizing Shout: Reduces enemy attack power (coordinate with other Warriors)
- Usually 1-2 Arms Warriors per raid for Mortal Strike debuff
    ]],
    author = "Rakizi",
}


-- Fury Rotation
local furyRotation = {
    -- Core identification
    name = "Fury",
    specIndex = 2,
    class = "WARRIOR",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    lastModified = "12/17/2025",
    rotationString = [[
    NAG:EnableAssignmentsGate()
    or
    -- Check weapon speeds for dual wield - alert if same speed (bad for dual wield)
    (NAG:CurrentHealth("target") > 0) and NAG:IsAttacking() and (not NAG:TargetInMeleeRange(5)) and NAG:DualWieldWarriorShouldCheckWeapons() and NAG:ShowCustomOverlay("Do NOT start attacking\nfrom distance!")
    -- Off-GCD queue: Cleave / Heroic Strike (rage gated, safe to check early)
    -- AoE Cleave: relaxed gates for dungeon scenarios (new clauses at top)
    -- Clause A: Mobs die in <=20s -> no SS gate, keep rage 60
    or ((NAG:NumberTargets() >= 2) and (NAG:RemainingTime() <= 20) and (NAG:RemainingTime() > 0)
        and (NAG:CurrentRageAtGCD() >= 60) and (not NAG:IsQueued(845)) and NAG:SpellCanCast(845))
        and NAG:Cast(845, nil, NAG.SPELL_POSITIONS.BELOW)
    -- Clause B: SS not active and on CD -> no SS gate, keep rage 60
    or ((NAG:NumberTargets() >= 2) and (not NAG:AuraIsActive(12328)) and (NAG:SpellTimeToReady(12328) > 0 or not(NAG:SpellIsKnown(12328)))
        and (NAG:CurrentRageAtGCD() >= 60) and (not NAG:IsQueued(845)) and NAG:SpellCanCast(845))
        and NAG:Cast(845, nil, NAG.SPELL_POSITIONS.BELOW)
    -- Clause C: SS+WW on CD, mobs die in <=10s -> no rage gate
    or ((NAG:NumberTargets() >= 2) and (NAG:SpellTimeToReady(12328) > 0 or not(NAG:SpellIsKnown(12328))) and (NAG:SpellTimeToReady(1680) > 0)
        and (NAG:RemainingTime() <= 10) and (NAG:RemainingTime() > 0)
        and (not NAG:IsQueued(845)) and NAG:SpellCanCast(845))
        and NAG:Cast(845, nil, NAG.SPELL_POSITIONS.BELOW)
    -- Clause D: if mobs will die in the next 6 seconds and WW on cd, no rage gate
    or ((NAG:AuraIsActive(12328) and NAG:NumberTargets() >= 2) and (NAG:RemainingTime() <= 6) and (NAG:RemainingTime() > 0)
        and (NAG:SpellTimeToReady(1680) > 0) and (not NAG:IsQueued(845)) and NAG:SpellCanCast(845))
        and NAG:Cast(845, nil, NAG.SPELL_POSITIONS.BELOW)
    or ((NAG:NumberTargets() >= 2) and NAG:CurrentRage() >= 60 and (not NAG:IsQueued(845)) and NAG:SpellCanCast(845)) and NAG:Cast(845, nil, NAG.SPELL_POSITIONS.BELOW)
    or ((NAG:CurrentRage() >= 60) and (not NAG:IsQueued(78)) and NAG:SpellCanCast(78)) and NAG:Cast(78, nil, NAG.SPELL_POSITIONS.BELOW)
    -- Maintain Battle Shout (rank-aware via resolved helpers)
    or (not NAG:AuraIsActive(2048)) and NAG:SpellCanCast(2048) and NAG:Cast(2048)
    -- Maintain Demoralizing Shout if assigned (usually done by Arms Warrior)
    or ((NAG:GetNumGroupMembers() > 0) and NAG:IsAssignmentEnabled("demoralizing_shout")
        and (not NAG:AuraIsActive(1160)) and NAG:SpellCanCast(1160))
        and NAG:Cast(1160)
    -- Use Bloodrage
    or (NAG:SpellCanCast(2687) and (not NAG:AuraIsActive(2687))) and NAG:Cast(2687)
    -- Use Death Wish, Recklessness, and any on-use effects
    or (NAG:SpellCanCast(12292) and (not NAG:AuraIsActive(12292))) and NAG:Cast(12292)
    or NAG:InEncounter() and ((NAG:PlayerIsInRaid() and NAG:RemainingTime() > 4) or (not NAG:PlayerIsInRaid() and NAG:RemainingTime() > 8))
        and (NAG:SpellCanCast(1719) and (not NAG:AuraIsActive(1719))) and NAG:Cast(1719)
    -- Use Sweeping Strikes for AoE
    or (NAG:NumberTargets() >= 2) and NAG:Cast(12328)
    -- Execute on targets below 20% health (gate: target selected, alive, in combat)
    or (NAG:UnitExists("target") and NAG:CurrentHealth("target") > 0 and NAG:InCombat("player") and NAG:IsExecutePhase(20) and NAG:SpellCanCast(5308)) and NAG:Cast(5308)
    -- AoE: Prioritize Whirlwind over Bloodthirst
    or ((NAG:NumberTargets() >= 2) and NAG:SpellCanCast(1680)) and NAG:Cast(1680)
    -- Use Bloodthirst
    or (NAG:SpellCanCast(23880)) and NAG:Cast(23880)
    -- Use Whirlwind
    or (NAG:SpellCanCast(1680)) and NAG:Cast(1680)
    -- pooling rage placeholder with auto attack
    or NAG:CastWithSwingOverlay(6603, "Pool\nRage")
    ]],

    -- Tracked IDs for optimization
    spells = {1680, 25202, 25231, 25234, 25236, 25251, 25286, 25289, 12292, 12328, 1719, 2687},
    items = {},
    auras = {25289, 25202, 12292, 1719, 12328, 2687}, -- Battle Shout, Demoralizing Shout, Death Wish, Recklessness, Sweeping Strikes, Bloodrage

    -- Optional metadata
    guide = [[
Fury Warrior Rotation Guide (TBC)

Core Mechanics:
- Fury Warriors dual-wield weapons for maximum DPS.
- No cast-time abilities - all instant casts for smooth rotation.
- Rage management is critical - maintain rage for ability usage.
- Fury Warriors are pure DPS with no raid utility debuffs.

Rotation Priority (Single Target):
1. Maintain Battle Shout (2min duration, refresh before it expires)
2. Maintain Demoralizing Shout if assigned (usually done by Arms Warrior)
3. Use Bloodrage (generates rage, use when available)
4. Use Death Wish, Recklessness, and any on-use effects (major DPS cooldowns)
5. Use Execute on targets below 20% health
6. Use Bloodthirst (main nuke, instant cast)
7. Use Whirlwind (AoE ability, also good single target)
8. Use Heroic Strike above 60 rage (rage dump)

AoE Rotation:
1. Use Sweeping Strikes (allows next 5 melee attacks to hit additional nearby target)
2. Proceed with single target rotation, but replace Heroic Strike with Cleave
3. Prioritize Whirlwind over Bloodthirst for AoE

Cooldowns:
- Death Wish: 3min CD. Increases physical damage by 20%, reduces armor by 20%.
- Recklessness: 30min CD. Increases crit chance by 100% for 15 seconds.
- Sweeping Strikes: 30sec CD. Next 5 melee attacks hit additional nearby target.
- Bloodrage: 60sec CD. Generates 10 rage over 10 seconds.

Rage Management:
- Battle Shout: Costs rage but provides raid buff - maintain it
- Heroic Strike: Use when above 60 rage to dump excess rage
- Execute: Only usable when target is below 20% health - high damage but expensive
- Demoralizing Shout: Use if assigned for raid debuff coordination (usually Arms Warrior's job)
- Cleave: Use instead of Heroic Strike for AoE situations

Key Differences from Arms:
- No Slam weaving needed - all abilities are instant cast
- Bloodthirst replaces Mortal Strike as main nuke
- Simpler rotation - priority-based rather than weave-based
- Dual-wield weapons for maximum DPS
- No raid utility debuffs (Mortal Strike is Arms-only)

Weapon Choice:
- Dual-wield fast one-handed weapons
- Best weapons: Dragonmaw and Dragonstrike (Blacksmithing)
- Windfury Weapon enchant is best for main hand
- Adamantite Sharpening Stone or Weightstone for off-hand
    ]],
    author = "Rakizi",
}

-- Protection Rotation
local protectionRotation = {
    -- Core identification
    name = "Protection",
    specIndex = 3,
    class = "WARRIOR",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    lastModified = "01/22/2026",
    rotationString = [[
    NAG:EnableAssignmentsGate()
    or
    -- Use Bloodrage (rage generation)
    (NAG:SpellCanCast(2687) and (not NAG:AuraIsActive(2687))) and
        NAG:Cast(2687, nil, NAG.SPELL_POSITIONS.LEFT)
    -- Use Shield Block (avoid crushing blows / enable Revenge) - use off cooldown
    or (NAG:InCombat() and (not NAG:AuraIsActive(2565)) and NAG:SpellCanCast(2565) and (NAG:CurrentRage() >= 10)) and
        NAG:Cast(2565)
    -- AoE: Replace Heroic Strike with Cleave (rage dump - check before Devastate)
    -- AoE Cleave: relaxed gates for dungeon scenarios (new clauses at top)
    -- Clause A: Mobs die in <=20s -> no SS gate, keep rage 60
    or ((NAG:NumberTargets() >= 2) and (NAG:RemainingTime() <= 20) and (NAG:RemainingTime() > 0)
        and (NAG:CurrentRageAtGCD() >= 60) and (not NAG:IsQueued(845)) and NAG:SpellCanCast(845))
        and NAG:Cast(845, nil, NAG.SPELL_POSITIONS.BELOW)
    -- Clause B: SS not active and on CD -> no SS gate, keep rage 60
    or ((NAG:NumberTargets() >= 2) and (not NAG:AuraIsActive(12328)) and (NAG:SpellTimeToReady(12328) > 0 or not(NAG:SpellIsKnown(12328)))
        and (NAG:CurrentRageAtGCD() >= 60) and (not NAG:IsQueued(845)) and NAG:SpellCanCast(845))
        and NAG:Cast(845, nil, NAG.SPELL_POSITIONS.BELOW)
    -- Clause C: SS+WW on CD, mobs die in <=10s -> no rage gate
    or ((NAG:NumberTargets() >= 2) and (NAG:SpellTimeToReady(12328) > 0 or not(NAG:SpellIsKnown(12328))) and (NAG:SpellTimeToReady(1680) > 0)
        and (NAG:RemainingTime() <= 10) and (NAG:RemainingTime() > 0)
        and (not NAG:IsQueued(845)) and NAG:SpellCanCast(845))
        and NAG:Cast(845, nil, NAG.SPELL_POSITIONS.BELOW)
    -- Clause D: if mobs will die in the next 6 seconds and WW on cd, no rage gate
    or ((NAG:AuraIsActive(12328) and NAG:NumberTargets() >= 2) and (NAG:RemainingTime() <= 6) and (NAG:RemainingTime() > 0)
        and (NAG:SpellTimeToReady(1680) > 0) and (not NAG:IsQueued(845)) and NAG:SpellCanCast(845))
        and NAG:Cast(845, nil, NAG.SPELL_POSITIONS.BELOW)
    or ((NAG:NumberTargets() >= 2) and NAG:CurrentRage() >= 60 and (not NAG:IsQueued(845)) and NAG:SpellCanCast(845)) and NAG:Cast(845, nil, NAG.SPELL_POSITIONS.BELOW)
    -- Heroic Strike (rage dump - instant cast, doesn't trigger GCD, check before Devastate)
    or ((NAG:CurrentRage() >= 60) and (not NAG:IsQueued(78)) and NAG:SpellCanCast(78)) and NAG:Cast(78, nil, NAG.SPELL_POSITIONS.BELOW)
        -- AoE: Thunder Clap for multi-target threat and slow (assigned + melee range)
    or ((NAG:GetNumGroupMembers() > 0) and NAG:IsAssignmentEnabled("thunder_clap")
        and (NAG:NumberTargets() >= 2) and (NAG:CountEnemiesInRange(10) > 0)
        and (not NAG:DotIsActive(6343)) and NAG:SpellCanCast(6343))
        and NAG:Cast(6343, nil, NAG.SPELL_POSITIONS.RIGHT)
    -- Maintain Demoralizing Shout if assigned (melee range, only if missing)
    or ((NAG:GetNumGroupMembers() > 0) and NAG:IsAssignmentEnabled("demoralizing_shout")
        and (NAG:CountEnemiesInRange(10) > 0) and (not NAG:DotIsActive(1160)) and NAG:SpellCanCast(1160))
        and NAG:Cast(1160, nil, NAG.SPELL_POSITIONS.RIGHT)
    -- Shield Slam (top priority when you have 20 rage - highest threat per rage)
    -- Require HasRage so we don't suggest SS when pooling; fall through to Devastate for initial threat
    or (NAG:HasRage(23922) and NAG:SpellCanCast(23922)) and NAG:Cast(23922)
    -- Revenge (second priority - high threat, low cost, requires block/dodge/parry)
    or NAG:Cast(6572)
    -- Devastate (filler + opener threat - use as soon as 15 rage to build Sunder stacks and threat), usable until 5 stacks of Sunder Armor
    or (NAG:SpellCanCast(20243)) and (((NAG:DotNumStacksGlobal(7386) < 5) or not(NAG:DotIsActiveGlobal(26866))) or (NAG:ThreatPercent("player", "target") < 0.95)) and NAG:Cast(20243)
    -- Shield Slam (top priority when you have 20 rage - highest threat per rage)
    -- Require HasRage so we don't suggest SS when pooling; fall through to Devastate for initial threat
    or NAG:Cast(23922)
    -- pooling rage placeholder with auto attack
    or NAG:CastWithSwingOverlay(6603, "Pool\nRage")
    ]],

    -- Tracked IDs for optimization
    spells = {20243, 25202, 25231, 25258, 25264, 25269, 25286, 2565, 2687},
    items = {},
    auras = {25202, 25264, 2565, 2687}, -- Demoralizing Shout, Thunder Clap, Shield Block, Bloodrage

    -- Optional metadata
    guide = [[
Protection Warrior Rotation Guide (TBC)

Core Mechanics:
- Protection Warriors are tanks - threat generation and mitigation are priorities.
- Shield Slam and Revenge are your highest threat-per-rage abilities.
- Shield Block uptime is critical versus boss melee swings (prevents crushing blows).
- Rage management matters: keep enough rage for Shield Slam/Revenge before dumping.

Rotation Priority (Single Target):
The core threat rotation follows this priority:
1. Shield Slam (when you have 20 rage - highest threat per rage, use on cooldown)
2. Revenge (when available - high threat for low rage, requires block/dodge/parry)
3. Devastate (filler and opener - use as soon as you have 15 rage to build threat and Sunder stacks)
4. Shield Block (use off cooldown - enables Revenge and prevents crushing blows)
5. Bloodrage (rage generation when available)
6. Heroic Strike (rage dump with excess rage - instant cast, doesn't trigger GCD)

Initial threat / opener: Use Bloodrage early (pre-pull or first GCD). As soon as you have 15 rage, use Devastate to apply Sunder and generate threat; use Shield Slam whenever you have 20 rage and it is ready. Do not wait for 20 rage before doing anything—Devastate at 15 rage is correct and matches sim/guides.

Maintenance:
- Maintain Demoralizing Shout if assigned (attack power reduction)
- Maintain Thunder Clap if assigned (attack speed slow)

AoE Rotation:
1. Thunder Clap to establish AoE threat and apply attack speed slow
2. Demoralizing Shout if assigned for group mitigation
3. Shield Slam on cooldown (highest threat)
4. Revenge on cooldown (cleaves in AoE)
5. Tab Devastate/Shield Slam to build threat on multiple targets
6. Cleave as the primary rage dump on 2+ targets (replaces Heroic Strike)

Threat Generation:
- Shield Slam: Highest threat per rage - use on cooldown (top priority)
- Revenge: High threat when available - use on cooldown (second priority)
- Devastate: Maintains Sunder Armor stacks and generates threat (filler)
- Heroic Strike/Cleave: Use with excess rage (60+) for additional threat

Mitigation:
- Shield Block: Critical for preventing crushing blows from raid bosses
- Use Shield Block off cooldown to enable Revenge procs
- Use Shield Block when facing bosses who can crush (level 73+ bosses)
- Shield Block increases block chance by 75% for 5 seconds
- Shield Wall / Last Stand: emergency cooldowns for predictable damage spikes

Rage Management:
- Bloodrage: Use when available for rage generation
- Shield Block: Use off cooldown (only requires 10 rage minimum)
- Heroic Strike: Use only with excess rage (60+) to avoid rage starvation
- Cleave: Use instead of Heroic Strike for AoE situations
- Keep enough rage reserve for Shield Slam and Revenge before dumping

Raid Utility:
- Demoralizing Shout: Reduces enemy attack power (coordinate with other Warriors)
- Thunder Clap: Reduces enemy attack speed (coordinate with other Warriors)
- Sunder Armor: Applied via Devastate - reduces target armor
- Usually 1-2 Protection Warriors per raid for tanking duties

Talent Builds:
- Standard Build: Balanced threat and mitigation
- Mitigation Build: Focuses on Improved Thunder Clap and Demoralizing Shout for survivability
    ]],
    author = "Rakizi",
}

local furyRotationEspi = {
    -- Core identification
    name = "Fury",
    specIndex = 2, -- Fury
    class = "WARRIOR",

    -- Required parameters
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,

    lastModified = "29/01/2025",

    -- Rotation Logic
    rotationString = [[
    NAG:EnableAssignmentsGate()
    or
    -- Cleave (Rank 1 ID, resolves to highest known)
    -- AoE Cleave: SS+WW on CD, mobs die in <=10s -> no rage gate
    ((NAG:NumberTargets(5) > 1) and (NAG:SpellTimeToReady(12328) > 0 or not(NAG:SpellIsKnown(12328))) and (NAG:SpellTimeToReady(1680) > 0)
        and (NAG:RemainingTime() <= 10) and (NAG:RemainingTime() > 0)
        and (not NAG:IsQueued(845)) and NAG:SpellCanCast(845))
        and NAG:Cast(845, nil, NAG.SPELL_POSITIONS.BELOW)
    or
    ((NAG:NumberTargets(5) > 1) and (NAG:CurrentRage() >= 60) and not NAG:IsQueued(845)) and NAG:Cast(845, nil, NAG.SPELL_POSITIONS.BELOW)
	or ((NAG:NumberTargets(5) > 1) and (NAG:CurrentRage() >= 45) and not NAG:IsQueued(845) and NAG:SpellTimeToReady(23880) > 2 and NAG:SpellTimeToReady(1680) > 2) and NAG:Cast(845, nil, NAG.SPELL_POSITIONS.BELOW)
    -- Heroic Strike (Rank 1 ID, resolves to highest known)
    or ((NAG:NumberTargets(5) <= 1) and (NAG:CurrentRage() >= 57) and not NAG:IsQueued(78)) and NAG:Cast(78, nil, NAG.SPELL_POSITIONS.BELOW)
	or ((NAG:NumberTargets(5) <= 1) and (NAG:CurrentRage() >= 45) and not NAG:IsQueued(78) and NAG:SpellTimeToReady(23880) > 2 and NAG:SpellTimeToReady(1680) > 2) and NAG:Cast(78, nil, NAG.SPELL_POSITIONS.BELOW)

	-- Sweeping Strikes
	or (NAG:NumberTargets(5) > 1) and (NAG:CurrentRage() >= 30) and NAG:Cast(12328)

    -- Utility
	-- Maintain Battle Shout
    or (not NAG:AuraIsActive(2048)) and NAG:Cast(2048)
	-- Maintain Demoralizing Shout if assigned
    or ((NAG:GetNumGroupMembers() > 0) and NAG:IsAssignmentEnabled("demoralizing_shout")
        and (not NAG:DotIsActive(1160))) and NAG:Cast(1160)
	-- Maintain tclap if assigned
    or ((NAG:GetNumGroupMembers() > 0) and NAG:IsAssignmentEnabled("thunder_clap")
        and (not NAG:DotIsActive(6343))) and NAG:Cast(6343)

	-- Bloodrage if rage < 20
    or (NAG:CurrentRage() < 20 and NAG:AuraIsActive(2458) and NAG:InCombat("player")) and NAG:Cast(2687)

	-- Gap closers: Charge out of combat, Intercept in combat (8+ yards)
	or ((not NAG:InCombat("player")) and NAG:SpellCanCast(100))
        and NAG:Cast(100, nil, NAG.SPELL_POSITIONS.PRIMARY)
	or (NAG:InCombat("player") and (NAG:UnitDistance("target") > 8) and NAG:SpellCanCast(20252))
        and NAG:Cast(20252, nil, NAG.SPELL_POSITIONS.BELOW)

    -- Cooldowns (Death Wish, Recklessness, Racials) together if possible
    -- We prioritize Death Wish, then try to stack others if Death Wish is active
    -- ALSO CHECK FOR RAMPAGE
    or ((NAG:DotIsActiveGlobal(7386) and NAG:DotNumStacksGlobal(7386) == 5) or NAG:DotIsActiveGlobal(26866) or (NAG:InEncounter() and NAG:RemainingTime() < 38)) and NAG:Cast(12292)  -- Death Wish
    or NAG:InEncounter() and ((NAG:PlayerIsInRaid() and NAG:RemainingTime() > 4) or (not NAG:PlayerIsInRaid() and NAG:RemainingTime() > 8))
        and (NAG:AuraIsActive(12292) or NAG:AuraIsActive(29801)) and NAG:Cast(1719) -- Recklessness
    or (NAG:AuraIsActive(12292) or NAG:AuraIsActive(29801)) and NAG:Cast(26297) -- Berserking (Troll)
    or (NAG:AuraIsActive(12292) or NAG:AuraIsActive(29801)) and NAG:Cast(20572) -- Blood Fury (Orc)
    or ((NAG:AuraIsActive(12292) or NAG:AuraIsActive(29801)) and NAG:IsReady(22838)) and NAG:Cast(22838, nil, NAG.SPELL_POSITIONS.LEFT) -- Haste Potion


    -- Always be in Berserker Stance (2458) and rage below 20
    or (not NAG:AuraIsActive(2458)) and NAG:CurrentRage() < 15 and NAG:Cast(2458)

    -- Sunder Armor(<5 stacks or <3s remaining) - only if assigned and Expose Armor not active
    or ((NAG:GetNumGroupMembers() > 0) and NAG:IsAssignmentEnabled("sunder_armor")
        and (not NAG:DotIsActiveGlobal(7386) or (NAG:DotNumStacksGlobal(7386) < 5 or NAG:DotRemainingTime(7386) < 3))
        and not NAG:DotIsActiveGlobal(26866))
        and NAG:Cast(7386)

    -- Whirlwind on CD if > 1 target in range (8 yds)
    or (NAG:NumberTargets(8) > 1) and NAG:Cast(1680)

    -- rampage
    or (not NAG:AuraIsActive(29801))
        and NAG:Cast(29801)
	-- Victory Rush
    or (NAG:SpellTimeToReady(23880) > 1.5) and NAG:Cast(34428)

	-- execute (gate: target selected, alive, in combat)
	or (NAG:UnitExists("target") and NAG:CurrentHealth("target") > 0 and NAG:InCombat("player") and NAG:IsExecutePhase(20) and NAG:CurrentAttackPower() < 2000) and NAG:Cast(5308)

    -- Bloodthirst on CD
    or NAG:Cast(23880)

    -- execute (gate: target selected, alive, in combat)
    or (NAG:UnitExists("target") and NAG:CurrentHealth("target") > 0 and NAG:InCombat("player") and NAG:IsExecutePhase(20)) and NAG:Cast(5308)

    -- Whirlwind on CD (Single Target use)
    or NAG:Cast(1680)

    -- Sunder Armor if active and duration < 8 secs (Refresh) - only if assigned and Expose Armor not active
    or ((NAG:GetNumGroupMembers() > 0) and NAG:IsAssignmentEnabled("sunder_armor")
        and (NAG:DotIsActiveGlobal(7386) and NAG:DotRemainingTimeGlobal(7386) < 8)
        and not NAG:DotIsActiveGlobal(26866))
        and NAG:Cast(7386)

    -- Hamstring if Rage >= 75 is active
    or (NAG:CurrentRage() >= 75 and NAG:SpellTimeToReady(1680) > 1.5 and NAG:SpellTimeToReady(12294) > 1.5 and not NAG:AuraIsActive(12328))and NAG:Cast(1715)
    -- Look ahead: show BT or WW (whichever comes first) with 10s tolerance

    -- Always be in Berserker Stance (2458)
    or (not NAG:AuraIsActive(2458)) and NAG:Cast(2458)

    or (NAG:SpellTimeToReady(23880) < NAG:SpellTimeToReady(1680)) and NAG:Cast(23880, 10)
    or NAG:Cast(1680, 10)
    -- Pool rage: show which of BT or WW comes first within 10s
    or NAG:CastWithSwingOverlay(6603, (function()
        local bt, ww = NAG:SpellTimeToReady(23880), NAG:SpellTimeToReady(1680)
        if bt <= 10 and (bt <= ww or ww > 10) then return "Pool for BT" end
        if ww <= 10 then return "Pool for WW" end
        return "Pool Rage"
    end)())
    ]],

    -- Tracked IDs
    spells = {
        2458,   -- Berserker Stance
        12292,  -- Death Wish
        1719,   -- Recklessness
        2687,   -- Bloodrage
        7386,   -- Sunder Armor
        29707,  -- Heroic Strike
        25231,  -- Cleave
        1680,   -- Whirlwind
        23894,  -- Bloodthirst
        1715,   -- Hamstring
        26297,  -- Berserking
        20572,  -- Blood Fury
		34428,  -- Victory Rush
		25275,  -- Intercept
		12328,  -- Sweeping Strikes
		25236,  -- Execute
    },
    items = {
        22838, -- Haste Potion
    },
    auras = {},
    runes = {},

	author = "espi",
}

local kebabRotationEspi = {
    -- Core identification
    name = "Arms (Kebab)",
    specIndex = 1, -- Arms
    class = "WARRIOR",

    -- Required parameters
    default = true,
    enabled = true,
    experimental = false,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    customConditions = {
        {
            type = ns.CUSTOM_CONDITION_TYPES.WEAPON_TYPE,
            value = "dualWield"  -- This rotation is for dual-wield setups
        },
    },
    lastModified = "04/01/2025",

    -- Rotation Logic
    rotationString = [[
    -- Swap to 2H Arms when equipped with two-handed weapon (no offhand)
    (not NAG:IsDualWield()) and NAG:SelectRotation("Arms")
    or NAG:EnableAssignmentsGate()
    or
    -- Check weapon speeds for dual wield - alert if same speed (bad for dual wield)
    (NAG:CurrentHealth("target") > 0) and NAG:IsAttacking() and (not NAG:TargetInMeleeRange(5)) and NAG:DualWieldWarriorShouldCheckWeapons() and NAG:ShowCustomOverlay("Do NOT start attacking\nfrom distance!")
    -- Cleave (Rank 1 ID, resolves to highest known)
    -- AoE Cleave: SS+WW on CD, mobs die in <=10s -> no rage gate
    or ((NAG:NumberTargets(5) > 1) and (NAG:SpellTimeToReady(12328) > 0 or not(NAG:SpellIsKnown(12328))) and (NAG:SpellTimeToReady(1680) > 0)
        and (NAG:RemainingTime() <= 10) and (NAG:RemainingTime() > 0)
        and (not NAG:IsQueued(845)) and NAG:SpellCanCast(845))
        and NAG:Cast(845, nil, NAG.SPELL_POSITIONS.BELOW)
    or ((NAG:NumberTargets(5) > 1) and (NAG:CurrentRage() >= 45) and not NAG:IsQueued(845)) and NAG:Cast(845, nil, NAG.SPELL_POSITIONS.BELOW)
	or ((NAG:NumberTargets(5) > 1) and (NAG:CurrentRage() >= 30) and not NAG:IsQueued(845) and NAG:SpellTimeToReady(12294) > 2 and NAG:SpellTimeToReady(1680) > 2) and NAG:Cast(845, nil, NAG.SPELL_POSITIONS.BELOW)
    -- Heroic Strike (Rank 1 ID, resolves to highest known)
    or ((NAG:NumberTargets(5) <= 1) and (NAG:CurrentRage() >= 42) and not NAG:IsQueued(78)) and NAG:Cast(78, nil, NAG.SPELL_POSITIONS.BELOW)
	or ((NAG:NumberTargets(5) <= 1) and (NAG:CurrentRage() >= 30) and not NAG:IsQueued(78) and NAG:SpellTimeToReady(12294) > 2 and NAG:SpellTimeToReady(1680) > 2) and NAG:Cast(78, nil, NAG.SPELL_POSITIONS.BELOW)

	-- Sweeping Strikes
	or (NAG:NumberTargets(5) > 1) and (NAG:CurrentRage() >= 30) and NAG:Cast(12328)

    -- Utility
	-- Maintain Battle Shout
    or (not NAG:AuraIsActive(2048)) and NAG:Cast(2048)
	-- Maintain Demoralizing Shout if assigned
    or ((NAG:GetNumGroupMembers() > 0) and NAG:IsAssignmentEnabled("demoralizing_shout")
        and (not NAG:DotIsActive(1160))) and NAG:Cast(1160)
	-- Maintain tclap if assigned
    or ((NAG:GetNumGroupMembers() > 0) and NAG:IsAssignmentEnabled("thunder_clap")
        and (not NAG:DotIsActive(6343))) and NAG:Cast(6343)

	-- Bloodrage if rage < 20
    or (NAG:CurrentRage() < 20 and NAG:AuraIsActive(2458) and NAG:InCombat("player")) and NAG:Cast(2687)

	-- Gap closers: Charge out of combat, Intercept in combat (8+ yards)
	or ((not NAG:InCombat("player")) and NAG:SpellCanCast(100))
        and NAG:Cast(100, nil, NAG.SPELL_POSITIONS.PRIMARY)
	or (NAG:InCombat("player") and (NAG:UnitDistance("target") > 8) and NAG:SpellCanCast(20252))
        and NAG:Cast(20252, nil, NAG.SPELL_POSITIONS.BELOW)

    -- Cooldowns (Death Wish, Recklessness, Racials) together if possible
    -- We prioritize Death Wish, then try to stack others if Death Wish is active
    or ((NAG:DotIsActiveGlobal(7386) and NAG:DotNumStacksGlobal(7386) == 5) or NAG:DotIsActiveGlobal(26866) or (NAG:InEncounter() and NAG:RemainingTime() < 36)) and NAG:Cast(12292) -- Death Wish
    or NAG:InEncounter() and ((NAG:PlayerIsInRaid() and NAG:RemainingTime() > 4) or (not NAG:PlayerIsInRaid() and NAG:RemainingTime() > 8))
        and (NAG:AuraIsActive(12292)) and NAG:Cast(1719) -- Recklessness
    or (NAG:AuraIsActive(12292)) and NAG:Cast(26297) -- Berserking (Troll)
    or (NAG:AuraIsActive(12292)) and NAG:Cast(20572) -- Blood Fury (Orc)
    or (NAG:AuraIsActive(12292) and NAG:IsReady(22838)) and NAG:Cast(22838, nil, NAG.SPELL_POSITIONS.RIGHT) -- Haste Potion

    -- Always be in Berserker Stance (2458) and rage below 20
    or (not NAG:AuraIsActive(2458)) and NAG:CurrentRage() < 15 and NAG:Cast(2458)

    -- Sunder Armor(<5 stacks or <3s remaining) - only if assigned and Expose Armor not active
    or ((NAG:GetNumGroupMembers() > 0) and NAG:IsAssignmentEnabled("sunder_armor")
        and (not NAG:DotIsActiveGlobal(7386) or (NAG:DotNumStacksGlobal(7386) < 5 or NAG:DotRemainingTimeGlobal(7386) < 3))
        and not NAG:DotIsActiveGlobal(26866))
        and NAG:Cast(7386)

    -- Whirlwind on CD if > 1 target in range (8 yds)
    or (NAG:NumberTargets(8) > 1) and NAG:Cast(1680)

	-- execute (gate: target selected, alive, in combat, execute phase)
	or (NAG:UnitExists("target") and NAG:CurrentHealth("target") > 0 and NAG:InCombat("player") and NAG:IsExecutePhase(20)) and NAG:Cast(5308)

    -- MS on CD
    or NAG:Cast(12294)

	-- Victory Rush
    or (NAG:SpellTimeToReady(12294) > 1.5) and NAG:Cast(34428)

    -- Whirlwind on CD (Single Target use)
    or (not NAG:IsReady(12294)) and NAG:Cast(1680)

    -- Sunder Armor if active and duration < 8 secs (Refresh) - only if assigned and Expose Armor not active
    or ((NAG:GetNumGroupMembers() > 0) and NAG:IsAssignmentEnabled("sunder_armor")
        and (NAG:DotIsActiveGlobal(7386) and NAG:DotRemainingTimeGlobal(7386) < 8)
        and not NAG:DotIsActiveGlobal(26866))
        and NAG:Cast(7386)

    -- Hamstring if Rage >= 40
    or (NAG:CurrentRage() >= 70 and NAG:SpellTimeToReady(1680) > 1.5 and NAG:SpellTimeToReady(12294) > 1.5 and not NAG:AuraIsActive(12328)) and NAG:Cast(1715)
    -- Look ahead: show MS or WW (whichever comes first) with 10s tolerance

    -- Always be in Berserker Stance (2458)
    or (not NAG:AuraIsActive(2458)) and NAG:Cast(2458)
    or (NAG:SpellTimeToReady(12294) < NAG:SpellTimeToReady(1680)) and NAG:Cast(12294, 10)
    or NAG:Cast(1680, 10)
    -- Pool rage: show which of MS or WW comes first within 10s
    or NAG:CastWithSwingOverlay(6603, (function()
        local ms, ww = NAG:SpellTimeToReady(12294), NAG:SpellTimeToReady(1680)
        if ms <= 10 and (ms <= ww or ww > 10) then return "Pool for MS" end
        if ww <= 10 then return "Pool for WW" end
        return "Pool Rage"
    end)())
    ]],

    -- Tracked IDs
    spells = {
        2458,   -- Berserker Stance
        12292,  -- Death Wish
        1719,   -- Recklessness
        2687,   -- Bloodrage
        7386,   -- Sunder Armor
        29707,  -- Heroic Strike
        25231,  -- Cleave
        1680,   -- Whirlwind
        30330,  -- Mortal Strike
        1715,   -- Hamstring
        26297,  -- Berserking
        20572,  -- Blood Fury
		34428,  -- Victory Rush
		25275,  -- Intercept
		12328,  -- Sweeping Strikes
		25236,  -- Execute
    },
    items = {
        22838, -- Haste Potion
    },
    auras = {},
    runes = {},

	author = "espi",
}

--- @class Warrior : ClassBase
local Warrior = NAG:CreateClassModule("WARRIOR", defaults)
if not Warrior then return end

function Warrior:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 0, genericRotation)  -- Generic (no talents)
    ns.AddRotationToDefaults(self.defaults, 3, protectionRotation)  -- Protection (moved earlier for better visibility)
    ns.AddRotationToDefaults(self.defaults, 1, armsRotation)  -- Arms
	ns.AddRotationToDefaults(self.defaults, 1, kebabRotationEspi)  -- Arms
    --ns.AddRotationToDefaults(self.defaults, 2, furyRotation)  -- Fury
	ns.AddRotationToDefaults(self.defaults, 2, furyRotationEspi)  -- Fury
end

NAG.Class = Warrior

