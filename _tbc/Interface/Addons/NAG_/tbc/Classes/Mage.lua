local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version

local defaults = ns.InitializeClassDefaults()

-- TBC Mage spec spell locations
defaults.class.specSpellLocations = {
    [1] = { -- Arcane
        -- ABOVE spells (Buffs, maintenance)
        [6117] = NAG.SPELL_POSITIONS.ABOVE,    -- Mage Armor (maintain)

        -- LEFT spells (Cooldowns, major buffs, racials)
        [12472] = NAG.SPELL_POSITIONS.LEFT,    -- Icy Veins
        [12042] = NAG.SPELL_POSITIONS.LEFT,    -- Arcane Power
        [12043] = NAG.SPELL_POSITIONS.LEFT,    -- Presence of Mind
        [11958] = NAG.SPELL_POSITIONS.LEFT,    -- Cold Snap
        [12051] = NAG.SPELL_POSITIONS.LEFT,    -- Evocation
        [20572] = NAG.SPELL_POSITIONS.LEFT,    -- Blood Fury (Orc Racial)
        [26297] = NAG.SPELL_POSITIONS.LEFT,    -- Berserking (Troll Racial)
        [28734] = NAG.SPELL_POSITIONS.LEFT,    -- Mana Tap (BE Racial)
        [25046] = NAG.SPELL_POSITIONS.LEFT,    -- Arcane Torrent (BE Racial)

        -- AOE spells
        [1449] = NAG.SPELL_POSITIONS.AOE,      -- Arcane Explosion

        -- PRIMARY spells (default, not explicitly set)
        -- Arcane Blast (30451) - main filler
        -- Frostbolt (27072) - mana conservation filler
    },
    [2] = { -- Fire
        -- ABOVE spells (Buffs, maintenance)
        [30482] = NAG.SPELL_POSITIONS.ABOVE,   -- Molten Armor (maintain)

        -- LEFT spells (Cooldowns, major buffs, racials)
        [12472] = NAG.SPELL_POSITIONS.LEFT,    -- Icy Veins
        [11129] = NAG.SPELL_POSITIONS.LEFT,    -- Combustion
        [12051] = NAG.SPELL_POSITIONS.LEFT,    -- Evocation
        [20572] = NAG.SPELL_POSITIONS.LEFT,    -- Blood Fury (Orc Racial)
        [26297] = NAG.SPELL_POSITIONS.LEFT,    -- Berserking (Troll Racial)
        [28734] = NAG.SPELL_POSITIONS.LEFT,    -- Mana Tap (BE Racial)
        [25046] = NAG.SPELL_POSITIONS.LEFT,    -- Arcane Torrent (BE Racial)

        -- AOE spells
        [2120] = NAG.SPELL_POSITIONS.AOE,      -- Flamestrike
        [31661] = NAG.SPELL_POSITIONS.AOE,     -- Dragon's Breath
        [11113] = NAG.SPELL_POSITIONS.AOE,     -- Blast Wave
        [10] = NAG.SPELL_POSITIONS.AOE,        -- Blizzard

        -- PRIMARY spells (default, not explicitly set)
        -- Fireball (27070) - main filler
        -- Scorch (27074) - maintain 5 stacks if assigned
    },
    [3] = { -- Frost
        -- ABOVE spells (Buffs, maintenance)
        [7302] = NAG.SPELL_POSITIONS.ABOVE,    -- Ice Armor (maintain)

        -- LEFT spells (Cooldowns, major buffs, racials)
        [31687] = NAG.SPELL_POSITIONS.LEFT,    -- Summon Water Elemental
        [12472] = NAG.SPELL_POSITIONS.LEFT,    -- Icy Veins
        [11958] = NAG.SPELL_POSITIONS.LEFT,    -- Cold Snap
        [12051] = NAG.SPELL_POSITIONS.LEFT,    -- Evocation
        [20572] = NAG.SPELL_POSITIONS.LEFT,    -- Blood Fury (Orc Racial)
        [26297] = NAG.SPELL_POSITIONS.LEFT,    -- Berserking (Troll Racial)
        [28734] = NAG.SPELL_POSITIONS.LEFT,    -- Mana Tap (BE Racial)
        [25046] = NAG.SPELL_POSITIONS.LEFT,    -- Arcane Torrent (BE Racial)

        -- AOE spells
        [10] = NAG.SPELL_POSITIONS.AOE,        -- Blizzard

        -- PRIMARY spells (default, not explicitly set)
        -- Frostbolt (27072) - main filler
    },
}

if UnitClassBase('player') ~= "MAGE" then return end

-- Generic (0 talent points): low-level abilities before choosing a spec
local genericRotation = {
    name = "Generic",
    specIndex = 0,
    class = "MAGE",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    rotationString = [[
    -- Maintain Frost Armor (level 1) or Ice Armor if known
    (not NAG:AuraIsActive(168) and not NAG:AuraIsActive(7302)) and NAG:SpellCanCast(168) and NAG:Cast(168)
    or (not NAG:AuraIsActive(7302) and not NAG:AuraIsActive(168)) and NAG:SpellCanCast(7302) and NAG:Cast(7302)
    or (NAG:UnitIsMoving() and NAG:SpellCanCast(2136)) and NAG:Cast(2136)
    or (NAG:SpellCanCast(116)) and NAG:Cast(116)
    or (NAG:SpellCanCast(133)) and NAG:Cast(133)
]],
}

-- Arcane Rotation
local arcaneRotation = {
    -- Core identification
    name = "Arcane",
    specIndex = 1,
    class = "MAGE",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    lastModified = "12/30/2025",
    rotationString = [[
    -- Maintain Mage Armor
    (not NAG:AuraIsActive(6117)) and NAG:SpellCanCast(6117) and NAG:Cast(6117)
    -- Maintain Arcane Intellect/Arcane Brilliance (out of combat, refresh at 2 min)
    or (not NAG:InCombat() and (
        (not NAG:AuraIsActive(1459) and not NAG:AuraIsActive(23028)) or
        (NAG:AuraIsActive(1459) and NAG:AuraRemainingTime(1459) <= 120) or
        (NAG:AuraIsActive(23028) and NAG:AuraRemainingTime(23028) <= 120)
    )) and (
        (NAG:SpellCanCast(23028) and NAG:Cast(23028, nil, NAG.SPELL_POSITIONS.ABOVE)) or
        (NAG:SpellCanCast(1459) and NAG:Cast(1459, nil, NAG.SPELL_POSITIONS.ABOVE))
    )
    -- Evocation when low mana in combat (bottom position)
    or (NAG:InCombat() and (NAG:CurrentManaPercent() < 0.15) and NAG:SpellCanCast(12051)) and
        NAG:Cast(12051, nil, NAG.SPELL_POSITIONS.BELOW)
    -- AoE: Cast Arcane Explosion when targets are in melee range
    or (NAG:NumberTargets() >= 2 and NAG:CountEnemiesInRange(10) > 2 and NAG:SpellCanCast(1449)) and
        NAG:Cast(1449, nil, NAG.SPELL_POSITIONS.AOE)

    -- Cast Cold Snap after Icy Veins (Icy Veins on cooldown, no Icy Veins buff)
    or ((NAG:SpellTimeToReady(12472) > 0) and (not NAG:AuraIsActive(12472)) and NAG:SpellCanCast(11958)) and
        NAG:Cast(11958, nil, NAG.SPELL_POSITIONS.LEFT)

    -- Cast Presence of Mind right before Arcane Power ends (if Arcane Power is active and about to expire)
    or ((NAG:AuraIsActive(12042)) and (NAG:AuraRemainingTime(12042) <= 3.0) and (not NAG:AuraIsActive(12043)) and NAG:SpellCanCast(12043)) and
        NAG:Cast(12043)

    -- Cast Arcane Blast if Presence of Mind buff is active (instant cast)
    or (NAG:AuraIsActive(12043) and NAG:SpellCanCast(16067)) and NAG:Cast(16067)

    -- Cast Icy Veins and Arcane Power together
    or ((not NAG:AuraIsActive(12472)) and (not NAG:AuraIsActive(12042)) and
        NAG:SpellCanCast(12472) and NAG:SpellCanCast(12042)) and
        NAG:Cast(12472, nil, NAG.SPELL_POSITIONS.LEFT)
    or ((not NAG:AuraIsActive(12042)) and NAG:AuraIsActive(12472) and NAG:SpellCanCast(12042)) and
        NAG:Cast(12042, nil, NAG.SPELL_POSITIONS.LEFT)

    -- Cast Fire Blast while moving
    or (NAG:UnitIsMoving() and NAG:SpellCanCast(2136)) and NAG:Cast(2136)

    -- Cast Arcane Blast during cooldown windows (when Icy Veins or Arcane Power is active)
    or NAG:NotSpamCast(16067)
    or ((NAG:AuraIsActive(12472) or NAG:AuraIsActive(12042)) and NAG:SpellCanCast(16067)) and
        NAG:Cast(16067)

    -- Cast Frostbolt to conserve mana outside cooldown windows (main filler when cooldowns are down)
    or ((not NAG:AuraIsActive(12472)) and (not NAG:AuraIsActive(12042)) and NAG:SpellCanCast(116)) and
        NAG:Cast(116)

    -- Fallback: Cast Arcane Blast if nothing else is available
    or (NAG:SpellCanCast(16067)) and NAG:Cast(16067)
    ]],

    -- Tracked IDs for optimization
    spells = {16067, 116, 2136, 12051, 12472, 12042, 12043, 11958, 6117, 1449},
    items = {},
    auras = {6117, 12472, 12042, 12043}, -- Mage Armor, Icy Veins, Arcane Power, Presence of Mind

    -- Optional metadata
    guide = [[
Arcane Mage Rotation Guide (TBC)

Core Mechanics:
- Arcane Mages are burst DPS casters with high mana consumption during cooldown windows.
- Arcane Blast stacks up to 3 times, increasing damage and reducing cast time while sharply increasing mana cost.
- Rotation alternates between Arcane Blast burst windows and Frostbolt for mana conservation.
- Use Evocation in combat when mana is low to reset for the next burst window.

Rotation Priority (Single Target):
1. Maintain Mage Armor (mana regeneration).
2. If in combat and mana is low, Evocation (bottom position).
3. Use Icy Veins + Arcane Power together for burst windows.
4. Use Presence of Mind for an instant Arcane Blast near the end of Arcane Power.
5. Cast Arcane Blast during cooldown windows to build/maintain 3 stacks.
6. Cast Frostbolt outside cooldown windows to conserve mana.
7. Use Fire Blast while moving.

Cooldown Usage:
- Icy Veins: 3min CD, 20 second duration. Increases casting speed by 20%.
- Arcane Power: 3min CD, 15 second duration. Increases damage by 30% but increases mana cost by 30%.
- Presence of Mind: 3min CD. Makes next spell instant cast.
- Cold Snap: 8min CD. Resets all Frost spell cooldowns (use to reset Icy Veins).
- Use Icy Veins and Arcane Power together for maximum burst damage.
- Use Presence of Mind with Arcane Blast right before Arcane Power expires for maximum burst.

Mana Management:
- Evocation: 8min CD. Restores mana over 8 seconds - use when mana is very low (<15%).
- Frostbolt: Use outside cooldown windows to conserve mana.
- Arcane Blast: Use during cooldown windows for maximum damage (high mana cost).
- Mage Armor: Provides passive mana regeneration - always maintain it.

Movement:
- Fire Blast: Instant cast fire damage - use while moving
- Try to minimize movement during cooldown windows to maximize Arcane Blast spam

AoE Rotation:
- Cast Arcane Explosion on 2+ targets when they are in melee range.
- Use cooldowns (Icy Veins, Arcane Power) for AoE situations as well.

Raid Coordination:
- Arcane Mages provide high burst DPS during cooldown windows
- Coordinate cooldowns with raid buffs (Bloodlust/Heroism) for maximum effect
- Usually 1-2 Arcane Mages per raid for burst damage and Arcane Intellect buff
    ]],
    author = "Rakizi",
}

-- Fire Rotation
local fireRotation = {
    -- Core identification
    name = "Fire",
    specIndex = 2,
    class = "MAGE",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    lastModified = "12/30/2025",
    rotationString = [[
    -- Maintain Molten Armor
    (not NAG:AuraIsActive(30482)) and NAG:SpellCanCast(30482) and NAG:Cast(30482)
    -- Maintain Arcane Intellect/Arcane Brilliance (out of combat, refresh at 2 min)
    or (not NAG:InCombat() and (
        (not NAG:AuraIsActive(1459) and not NAG:AuraIsActive(23028)) or
        (NAG:AuraIsActive(1459) and NAG:AuraRemainingTime(1459) <= 120) or
        (NAG:AuraIsActive(23028) and NAG:AuraRemainingTime(23028) <= 120)
    )) and (
        (NAG:SpellCanCast(23028) and NAG:Cast(23028, nil, NAG.SPELL_POSITIONS.ABOVE)) or
        (NAG:SpellCanCast(1459) and NAG:Cast(1459, nil, NAG.SPELL_POSITIONS.ABOVE))
    )
    -- Evocation when low mana in combat (bottom position)
    or (NAG:InCombat() and (NAG:CurrentManaPercent() < 0.15) and NAG:SpellCanCast(12051)) and
        NAG:Cast(12051, nil, NAG.SPELL_POSITIONS.BELOW)
    -- AoE: Cast Flamestrike (situational, right position)
    or (NAG:NumberTargets() >= 3 and NAG:SpellCanCast(2120)) and
        NAG:Cast(2120, nil, NAG.SPELL_POSITIONS.RIGHT)
    -- AoE: Cast Dragon's Breath
    or (NAG:NumberTargets() >= 2 and NAG:SpellCanCast(31661)) and NAG:Cast(31661)
    -- AoE: Cast Blast Wave
    or (NAG:NumberTargets() >= 2 and NAG:SpellCanCast(11113)) and NAG:Cast(11113)
    -- AoE: Cast Blizzard (situational, right position; only after recent Flamestrike)
    or (NAG:NumberTargets() >= 3 and NAG:SpellCanCast(10) and
        (select(1, NAG:GetLastPlayerSpellSucceededInfo()) == 2120) and
        (select(2, NAG:GetLastPlayerSpellSucceededInfo()) <= 8)) and
        NAG:Cast(10, nil, NAG.SPELL_POSITIONS.RIGHT)
    -- Cast Icy Veins, Combustion, and any on-use effects (at start of fight or when available)
    or ((not NAG:AuraIsActive(12472)) and (not NAG:AuraIsActive(11129)) and NAG:SpellCanCast(12472) and NAG:SpellCanCast(11129)) and NAG:Cast(12472)
    or ((not NAG:AuraIsActive(11129)) and NAG:AuraIsActive(12472) and NAG:SpellCanCast(11129)) and NAG:Cast(11129)
    -- Maintain 5 stacks of Scorch if assigned (check Improved Scorch debuff stacks on target, recast before expiring)
    or ((NAG:AuraNumStacks(22959, "target") < 5 or NAG:AuraRemainingTime(22959, "target") <= 3.0) and NAG:SpellCanCast(2948)) and NAG:Cast(2948)
    -- Cast Fire Blast while moving
    or (NAG:UnitIsMoving() and NAG:SpellCanCast(2136)) and NAG:Cast(2136)
    -- Cast Fireball (main filler)
    or NAG:NotSpamCast(133)
    -- If Improved Scorch will drop before the current cast + next Fireball, refresh it first
    or (NAG:AuraRemainingTime(22959, "target") > 0 and
        (NAG:AuraRemainingTime(22959, "target") <=
        (NAG:UnitCastTimeRemaining("player") + NAG:SpellCastTime(133))) and
        NAG:SpellCanCast(2948)) and
        NAG:Cast(2948)
    or (NAG:SpellCanCast(133)) and NAG:Cast(133)
    ]],

    -- Tracked IDs for optimization
    spells = {133, 2948, 2136, 12051, 12472, 11129, 30482, 2120, 31661, 11113, 10},
    items = {},
    auras = {30482, 12472, 11129, 2948}, -- Molten Armor, Icy Veins, Combustion, Improved Scorch (on target)

    -- Optional metadata
    guide = [[
Fire Mage Rotation Guide (TBC)

Core Mechanics:
- Fire Mages are sustained DPS casters focusing on fire damage with burst cooldowns.
- Fireball is the primary filler; Scorch is used to build/refresh Improved Scorch if assigned.
- Improved Scorch stacks to 5 (15% fire damage taken) and lasts 30 seconds.
- Combustion is your big fire burst cooldown; use with trinkets and execute windows.
- Mana management matters on longer fights - plan Evocation and consumables.

Rotation Priority (Single Target):
1. Maintain Molten Armor (always on for Fire).
2. If assigned, build/refresh 5 stacks of Improved Scorch (refresh late, before it falls).
3. Use Combustion (and Icy Veins if available) during high uptime/burst windows.
4. Cast Fireball as the primary filler.
5. Cast Scorch as a movement-friendly filler if you are assigned to maintain it.
6. Cast Fire Blast while moving for instant damage.

Cooldown Usage:
- Icy Veins: 3min CD, 20 second duration. Increases casting speed by 20%.
- Combustion: 3min CD. Each Fire crit increases your Fire crit chance until 3 crits occur.
- Use Icy Veins and Combustion together for maximum burst damage.

Scorch Maintenance:
- Improved Scorch applies a 5-stack fire vulnerability debuff (15% at 5 stacks, 30s duration).
- Only maintain if assigned (usually one Fire Mage per raid keeps this up).
- Refresh near expiration; avoid overcasting Scorch once 5 stacks are set.

Mana Management:
- Evocation: 8min CD. Restores mana over 8 seconds - use when mana is very low (<15%).
- Molten Armor: Provides passive benefits - always maintain it.

Movement:
- Fire Blast: Instant cast fire damage - use while moving
- Try to minimize movement to maximize Fireball casts

AoE Rotation:
1. Cast Flamestrike for burst AoE (ground DoT after impact).
2. Use Dragon's Breath and Blast Wave for instant AoE when in range.
3. Cast Blizzard for sustained AoE on stacked packs.

AoE Priority:
- Flamestrike for burst/ground DoT.
- Dragon's Breath and Blast Wave for close-range AoE.
- Blizzard for sustained AoE when you can channel safely.

Raid Coordination:
- Fire Mages provide sustained DPS with good burst during cooldown windows
- Usually 1 Fire Mage per raid maintains Improved Scorch (5 stacks) debuff
- Coordinate cooldowns with raid buffs (Bloodlust/Heroism) for maximum effect
- Usually 1-2 Fire Mages per raid for Scorch debuff and fire damage
    ]],
    author = "Rakizi",
}

-- Frost Rotation
local frostRotation = {
    -- Core identification
    name = "Frost",
    specIndex = 3,
    class = "MAGE",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    lastModified = "12/30/2025",
    rotationString = [[
    -- Maintain Ice Armor
    (not NAG:AuraIsActive(7302)) and NAG:SpellCanCast(7302) and NAG:Cast(7302)
    -- Maintain Arcane Intellect/Arcane Brilliance (out of combat, refresh at 2 min)
    or (not NAG:InCombat() and (
        (not NAG:AuraIsActive(1459) and not NAG:AuraIsActive(23028)) or
        (NAG:AuraIsActive(1459) and NAG:AuraRemainingTime(1459) <= 120) or
        (NAG:AuraIsActive(23028) and NAG:AuraRemainingTime(23028) <= 120)
    )) and (
        (NAG:SpellCanCast(23028) and NAG:Cast(23028, nil, NAG.SPELL_POSITIONS.ABOVE)) or
        (NAG:SpellCanCast(1459) and NAG:Cast(1459, nil, NAG.SPELL_POSITIONS.ABOVE))
    )
    -- Evocation when low mana in combat (bottom position)
    or (NAG:InCombat() and (NAG:CurrentManaPercent() < 0.15) and NAG:SpellCanCast(12051)) and
        NAG:Cast(12051, nil, NAG.SPELL_POSITIONS.BELOW)
    -- AoE: Cast Blizzard (priority over single target)
    or (NAG:NumberTargets() >= 2 and NAG:SpellCanCast(10)) and NAG:Cast(10)
    -- Cast Cold Snap after Icy Veins (Icy Veins on cooldown, no Icy Veins buff)
    or ((NAG:SpellTimeToReady(12472) > 0) and (not NAG:AuraIsActive(12472)) and NAG:SpellCanCast(11958)) and
        NAG:Cast(11958, nil, NAG.SPELL_POSITIONS.LEFT)
    -- Cast Summon Water Elemental
    or ((not NAG:PetIsActive()) and NAG:SpellCanCast(31687)) and NAG:Cast(31687)
    -- Cast Icy Veins for burst windows
    or ((not NAG:AuraIsActive(12472)) and NAG:SpellCanCast(12472)) and
        NAG:Cast(12472, nil, NAG.SPELL_POSITIONS.LEFT)
    -- Maintain 5 stacks of Winter's Chill (check Winter's Chill debuff stacks on target, recast before expiring)
    or ((NAG:AuraNumStacks(11180, "target") < 5 or NAG:AuraRemainingTime(11180, "target") <= 3.0) and NAG:SpellCanCast(116)) and
        NAG:Cast(116)
    -- Cast Ice Lance while moving
    or (NAG:UnitIsMoving() and NAG:SpellCanCast(30455)) and NAG:Cast(30455)
    -- Cast Frostbolt (main filler)
    or NAG:NotSpamCast(116)
    or (NAG:SpellCanCast(116)) and NAG:Cast(116)
    ]],

    -- Tracked IDs for optimization
    spells = {116, 30455, 12051, 12472, 11958, 31687, 7302, 10},
    items = {},
    auras = {7302, 12472, 11180}, -- Ice Armor, Icy Veins, Winter's Chill (on target)

    -- Optional metadata
    guide = [[
Frost Mage Rotation Guide (TBC)

Core Mechanics:
- Frost Mages are sustained DPS casters focusing on frost damage with good mana efficiency.
- Frostbolt is the primary filler; Winter's Chill stacks are maintained by landing Frost spells.
- Winter's Chill stacks to 5 (10% increased frost crit chance) and lasts 15 seconds.
- Icy Veins and Water Elemental are your main burst tools; use them in stable casting windows.
- Evocation is used in combat at low mana to reset for the next burst window.

Rotation Priority (Single Target):
1. Maintain Ice Armor (always on for Frost).
2. Use Icy Veins and Summon Water Elemental on cooldown in stable casting windows.
3. Use Cold Snap after Icy Veins and Water Elemental are on cooldown to reset them.
4. Maintain 5 stacks of Winter's Chill (Frostbolt; Ice Lance while moving to refresh).
5. Cast Frostbolt as the main filler.
6. Cast Ice Lance while moving.
7. If in combat and mana is low, Evocation (bottom position).

Cooldown Usage:
- Icy Veins: 3min CD, 20 second duration. Increases casting speed by 20%.
- Summon Water Elemental: 3min CD, 45 second duration. Summons a pet that provides DPS.
- Summon Water Elemental before Bloodlust/Heroism when possible for haste benefit.
- Cold Snap: 8min CD. Resets all Frost spell cooldowns (use after Icy Veins).
- Use Cold Snap to reset Icy Veins and Water Elemental for extra uptime.

Winter's Chill Maintenance:
- Winter's Chill is a stacking debuff applied by frost spells
- At 5 stacks, provides 10% increased crit chance for frost spells on the target
- Critical for maximizing DPS - keep 5 stacks up
- Use Frostbolt to stack/refresh; use Ice Lance while moving to prevent it dropping

Mana Management:
- Evocation: 8min CD. Restores mana over 8 seconds - use when mana is very low (<15%).
- Frost spec has better mana efficiency than other specs
- Ice Armor: Provides passive benefits - always maintain it.

Movement:
- Ice Lance: Instant cast frost damage - use while moving or to refresh Winter's Chill
- Try to minimize movement to maximize Frostbolt casts

AoE Rotation:
- Cast Blizzard on 2+ targets (channeled AoE damage)
- Blizzard is your primary AoE spell for Frost spec

Pet Management:
- Summon Water Elemental provides additional DPS
- Water Elemental has a 45 second duration and 3 minute cooldown
- Use Cold Snap to reset Water Elemental cooldown if needed
- Maintain Water Elemental when possible for maximum DPS

Raid Coordination:
- Frost Mages provide sustained DPS with good mana efficiency
- Maintain Winter's Chill (5 stacks) on target for raid-wide crit chance increase
- Coordinate cooldowns with raid buffs (Bloodlust/Heroism) for maximum effect
- Usually 1-2 Frost Mages per raid for Winter's Chill debuff and frost damage
    ]],
    author = "Rakizi",
}

--- @class Mage : ClassBase
local Mage = NAG:CreateClassModule("MAGE", defaults)
if not Mage then return end

function Mage:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 0, genericRotation)  -- Generic (no talents)
    ns.AddRotationToDefaults(self.defaults, 1, arcaneRotation)  -- Arcane
    ns.AddRotationToDefaults(self.defaults, 2, fireRotation)  -- Fire
    ns.AddRotationToDefaults(self.defaults, 3, frostRotation)  -- Frost
end

NAG.Class = Mage

