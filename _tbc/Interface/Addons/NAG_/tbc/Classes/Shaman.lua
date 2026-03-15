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

-- TBC Shaman spec spell locations
defaults.class.specSpellLocations = {
    [1] = { -- Elemental
        -- ABOVE spells (Debuffs, DoTs)
        -- (empty - primary rotation spells go in center/middle)

        -- BELOW spells (Totems, maintenance)
        [30706] = NAG.SPELL_POSITIONS.BELOW,    -- Totem of Wrath (maintain)
        [5675] = NAG.SPELL_POSITIONS.BELOW,    -- Mana Spring Totem (Rank 1)

        -- LEFT spells (Cooldowns, major buffs, racials)
        [16166] = NAG.SPELL_POSITIONS.LEFT,    -- Elemental Mastery
        [23575] = NAG.SPELL_POSITIONS.LEFT,    -- Water Shield (Rank 1)
        [20572] = NAG.SPELL_POSITIONS.LEFT,    -- Blood Fury (Orc Racial)
        [26297] = NAG.SPELL_POSITIONS.LEFT,    -- Berserking (Troll Racial)
        [28734] = NAG.SPELL_POSITIONS.LEFT,    -- Mana Tap (BE Racial)
        [25046] = NAG.SPELL_POSITIONS.LEFT,    -- Arcane Torrent (BE Racial)

        -- RIGHT spells (Occasional/situational)
        -- (empty - primary rotation spells go in center/middle)

        -- AOE spells
        [421] = NAG.SPELL_POSITIONS.AOE,     -- Chain Lightning (Rank 1)
        [1535] = NAG.SPELL_POSITIONS.AOE,     -- Fire Nova Totem (Rank 1)
        [8187] = NAG.SPELL_POSITIONS.AOE,     -- Magma Totem (Rank 1)

        -- Note: Lightning Bolt (25449) and Flame Shock (25457) default to center/middle
        -- as they are primary rotation spells (including movement situations)
    },
    [2] = { -- Enhancement
        -- ABOVE spells (Debuffs, DoTs)
        -- (empty - primary rotation spells go in center/middle)

        -- BELOW spells (Totems, maintenance)
        --[25533] = NAG.SPELL_POSITIONS.BELOW,   -- Searing Totem (maintain)
        [8075] = NAG.SPELL_POSITIONS.BELOW,    -- Strength of Earth Totem (Rank 1)
        [5675] = NAG.SPELL_POSITIONS.BELOW,    -- Mana Spring Totem (Rank 1)

        -- LEFT spells (Cooldowns, major buffs, racials)
        [23575] = NAG.SPELL_POSITIONS.LEFT,    -- Water Shield (Rank 1)
        [2894] = NAG.SPELL_POSITIONS.LEFT,     -- Fire Elemental Totem (cooldown)
        [20572] = NAG.SPELL_POSITIONS.LEFT,    -- Blood Fury (Orc Racial)
        [26297] = NAG.SPELL_POSITIONS.LEFT,    -- Berserking (Troll Racial)
        [28734] = NAG.SPELL_POSITIONS.LEFT,    -- Mana Tap (BE Racial)
        [25046] = NAG.SPELL_POSITIONS.LEFT,    -- Arcane Torrent (BE Racial)
        --[30823] = NAG.SPELL_POSITIONS.LEFT,     -- Shamanistic Rage(cooldown)

        -- Note: Windfury Totem (25585) and Grace of Air Totem (25359) for totem twisting
        -- default to center/middle (primary rotation) or can be overridden with SPELL_POSITIONS
        -- in the rotation string if needed

        -- RIGHT spells (Occasional/situational)
        -- (empty - primary rotation spells go in center/middle)

        -- AOE spells
        --[25547] = NAG.SPELL_POSITIONS.AOE,     -- Fire Nova Totem
        --[25552] = NAG.SPELL_POSITIONS.AOE,     -- Magma Totem

        -- Note: Stormstrike (17364), Flame Shock (25457), and Earth Shock (25454)
        -- default to center/middle as they are primary rotation spells
    },
    [3] = { -- Restoration
        [20572] = NAG.SPELL_POSITIONS.LEFT,    -- Blood Fury (Orc Racial)
        [26297] = NAG.SPELL_POSITIONS.LEFT,    -- Berserking (Troll Racial)
        [28734] = NAG.SPELL_POSITIONS.LEFT,    -- Mana Tap (BE Racial)
        [25046] = NAG.SPELL_POSITIONS.LEFT,    -- Arcane Torrent (BE Racial)
    },
}

-- Self-heal when low health (generic rotation)
defaults.class.recommendSelfHeal = true
defaults.class.selfHealThreshold = 0.35

defaults.class.classAssignments = {
    {
        id = "shaman_totem_twist_group_only",
        name = "Totem Twist (Group Only)",
        description = "Twist Windfury only when melee group conditions are met (Enhancement only)",
        spellIds = {},
        category = "config",
    },
    {
        id = "shaman_totem_twist_force",
        name = "Totem Twist (Force)",
        description = "Always twist Windfury regardless of group conditions (Enhancement only)",
        spellIds = {},
        category = "config",
    },
    {
        id = "shaman_totem_twist_never",
        name = "Totem Twist (Never)",
        description = "Never twist Windfury (Enhancement only)",
        spellIds = {},
        category = "config",
    },
    {
        id = "shaman_magma_st_always",
        name = "Magma Totem ST (Always)",
        description = "Use Magma Totem on single targets (Enhancement only)",
        spellIds = {},
        category = "config",
    },
    {
        id = "shaman_magma_st_encounter_only",
        name = "Magma Totem ST (Encounters Only)",
        description = "Use Magma Totem on single targets only during encounters (Enhancement only)",
        spellIds = {},
        category = "config",
    },
    {
        id = "shaman_magma_st_never",
        name = "Magma Totem ST (Never)",
        description = "Never use Magma Totem on single targets (Enhancement only)",
        spellIds = {},
        category = "config",
    },
}

defaults.char.assignmentToggles = defaults.char.assignmentToggles or {}
if defaults.char.assignmentToggles.shaman_totem_twist_group_only == nil then
    defaults.char.assignmentToggles.shaman_totem_twist_group_only = true
end
if defaults.char.assignmentToggles.shaman_totem_twist_force == nil then
    defaults.char.assignmentToggles.shaman_totem_twist_force = false
end
if defaults.char.assignmentToggles.shaman_totem_twist_never == nil then
    defaults.char.assignmentToggles.shaman_totem_twist_never = false
end
if defaults.char.assignmentToggles.shaman_magma_st_always == nil then
    defaults.char.assignmentToggles.shaman_magma_st_always = false
end
if defaults.char.assignmentToggles.shaman_magma_st_encounter_only == nil then
    defaults.char.assignmentToggles.shaman_magma_st_encounter_only = true
end
if defaults.char.assignmentToggles.shaman_magma_st_never == nil then
    defaults.char.assignmentToggles.shaman_magma_st_never = false
end

if UnitClassBase('player') ~= "SHAMAN" then return end

local enhancementMacros = {
    {
        name = "Weapon Sync",
        body = "/nagattack\n/startattack"
    },
}

-- Generic (0 talent points): low-level abilities before choosing a spec
local genericRotation = {
    name = "Generic",
    specIndex = 0,
    class = "SHAMAN",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    rotationString = [[
    (NAG:GetClassSetting('recommendSelfHeal', true) and (NAG:CurrentHealthPercent() < (NAG:GetClassSetting('selfHealThreshold', 0.35) or 0.35)) and NAG:SpellCanCast(331)) and NAG:Cast(331)
    or (not NAG:AuraIsActive(324)) and NAG:SpellCanCast(324) and NAG:Cast(324)
    or (not NAG:AuraIsActive(23575)) and NAG:SpellCanCast(23575) and NAG:Cast(23575)
    or (NAG:SpellCanCast(8050) and (not NAG:DotIsActive(8050, "target"))) and NAG:Cast(8050)
    or (NAG:SpellCanCast(403)) and NAG:Cast(403)
    or (NAG:SpellCanCast(331)) and NAG:Cast(331)
]],
}

-- Elemental Rotation
local elementalRotation = {
    -- Core identification
    name = "Elemental",
    specIndex = 1,
    class = "SHAMAN",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    lastModified = "12/17/2025",
    rotationString = [[
    -- Maintain Water Shield (rank-aware via resolved helpers)
    (not NAG:AuraIsActive(23575)) and NAG:SpellCanCast(23575) and NAG:Cast(23575)
    -- Maintain Totem of Wrath
    or (not NAG:HasTotemOfWrathBuff()) and NAG:SpellCanCast(30706) and NAG:Cast(30706)
    -- Maintain Mana Spring Totem
    or (not NAG:HasManaSpringTotemBuff()) and NAG:SpellCanCast(5675) and NAG:Cast(5675)
    -- Maintain Wrath of Air Totem
    or (not NAG:HasWrathOfAirTotemBuff()) and NAG:SpellCanCast(2895) and NAG:Cast(2895)
    -- Use Elemental Mastery before a heavy nuke (prefer CL if mana allows)
    or (NAG:SpellCanCast(16166) and (not NAG:AuraIsActive(16166)) and
        ((NAG:SpellCanCast(421) and (NAG:CurrentManaPercent() >= 0.30)) or NAG:SpellCanCast(403))) and
        NAG:CastWithOverlay(16166, "EM", NAG.SPELL_POSITIONS.LEFT)
    -- Cast Flame Shock while moving (late refresh to reduce downtime)
    or (NAG:UnitIsMoving() and NAG:SpellCanCast(8050) and
        ((not NAG:DotIsActive(8050)) or (NAG:DotRemainingTime(8050) <= 2))) and
        NAG:Cast(8050)
    -- Fire Nova Totem (AoE) if enemies are in melee range (not active or in windup)
    or (NAG:CountEnemiesInRange(10) > 0 and (not NAG:IsFireNovaTotemActiveOrInWindup()) and NAG:SpellCanCast(1535)) and
        NAG:Cast(1535)
    -- Magma Totem for sustained AoE when multiple enemies are in melee range (after Fire Nova explodes)
    or (NAG:CountEnemiesInRange(10) > 1 and (not NAG:IsFireNovaTotemActiveOrInWindup()) and (not NAG:IsTotemActiveResolved(8187)) and
        NAG:SpellCanCast(8187)) and
        NAG:Cast(8187)
    -- Chain Lightning in AoE situations (3+ targets in ranged range)
    or (NAG:CountEnemiesInRange(30) >= 3 and NAG:SpellCanCast(421)) and NAG:Cast(421)
    -- Chain Lightning if mana allows (usually only during short fights)
    or ((NAG:CurrentManaPercent() >= 0.30) and NAG:SpellCanCast(421)) and NAG:Cast(421)
    -- Cast Lightning Bolt
    or (NAG:SpellCanCast(403)) and NAG:Cast(403)
    ]],

    -- Tracked IDs for optimization
    spells = {421, 403, 8050, 16166, 23575, 30706, 5675, 2895, 1535, 8187},
    items = {},
    auras = {23575, 16166, 8050}, -- Water Shield, Elemental Mastery, Flame Shock

    -- Optional metadata
    guide = [[
Elemental Shaman Rotation Guide (TBC)

Core Mechanics:
- Elemental Shamans are ranged DPS casters focusing on nature and fire damage.
- Mana management is critical; Chain Lightning is expensive and should be used with care.
- Totem maintenance is essential for raid support and personal DPS.
- Water Shield provides passive mana regeneration - always maintain it.

Rotation Priority (Single Target):
1. Maintain Water Shield (passive mana regeneration - refresh before it expires).
2. Maintain Totem of Wrath (spell hit/crit + spell power; keep it down).
3. Maintain Mana Spring Totem (mana regen for the group).
4. Maintain Wrath of Air Totem (spell haste; use Windfury only if assigned for melee).
5. Use Elemental Mastery with Chain Lightning when mana allows; otherwise pair with Lightning Bolt.
6. Cast Chain Lightning when mana allows or during short fights/burst windows.
7. Cast Lightning Bolt as the primary filler.
8. Cast Flame Shock while moving or to prevent downtime (refresh late).

AoE Rotation:
1. Cast Fire Nova Totem when available (place it in the pack).
2. Cast Chain Lightning as the primary AoE spell.
3. Drop Magma Totem only after Fire Nova has exploded (wait ~4s base, 3s/2s with Improved Fire Totems).
4. Cast Lightning Bolt as filler when CL is on cooldown or mana is low.

Totem Priority:
- Fire: Totem of Wrath (Elemental) - provides spell hit/crit and spell power
- Earth: situational (Stoneskin or Tremor Totem)
- Water: Mana Spring Totem - provides mana regeneration
- Air: Wrath of Air Totem - provides spell haste

Cooldowns:
- Elemental Mastery: 3min CD. Next spell is free and guaranteed crit.
  Prefer CL for burst, or LB if conserving mana or CL is on cooldown.

Mana Management:
- Water Shield: Provides passive mana regeneration - always maintain it
- Chain Lightning: Very expensive, use only when mana is high (30%+) or during short fights
- Lightning Bolt: Efficient damage per mana - main filler spell
- Mana Spring Totem: Provides mana regeneration to raid - always maintain it

Raid Utility:
- Totem of Wrath: Provides 3% spell crit and 101 spell power to raid
- Mana Spring Totem: Provides mana regeneration to raid
- Wrath of Air Totem: Provides spell haste to raid
- Usually 1-2 Elemental Shamans per raid for Totem of Wrath and raid support
    ]],
    author = "Rakizi",
}

-- Enhancement Rotation
local enhancementRotation = {
    -- Core identification
    name = "Enhancement",
    specIndex = 2,
    class = "SHAMAN",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    lastModified = "12/17/2025",
    macros = enhancementMacros,
    rotationString = [[
    NAG:EnableTBCEnhancementWeaponSync()
    or NAG:EnableAssignmentsGate()
    or (NAG:ShamanShouldSpamAuto() and (NAG:ShowCustomOverlay("Spam AutoAttack\nto stagger weapons")))
    -- should startattacking from distance to force weapon sync
    or NAG:NeedsToStartAttacking() and NAG:CastPlaceholderWithOverlay(6603, "Start attacking from\ndistance to stagger weapons", NAG.SPELL_POSITIONS.PRIMARY)
    -- Apply Windfury Weapon imbue out of combat when either hand <= 120s
    or (not NAG:InCombat() and (NAG:WFWeaponRemaining("OH") <= 120 or NAG:WFWeaponRemaining("MH") <= 120) and NAG:Cast(8232))
    -- Fire Elemental + Bloodlust sequence
    or (not(NAG:IsTotemActive(2894)) and (NAG:InEncounter() or UnitLevel("target") <= 0)
        and (NAG:RemainingTime() >= 30 or not(NAG:InCombat())) and NAG:CurrentTime() < 5
        and NAG:StrictSequence("burst", false, 2894, 2825))
    -- Maintain Water Shield (out of combat or very low mana)
    or ((not NAG:InCombat()) or (NAG:CurrentManaPercent() <= 0.05)) and (not NAG:AuraIsActive(23575)) and NAG:Cast(23575)
    -- Use Shamanistic Rage when mana is low (<10%) and fight has time left
    or ((NAG:CurrentManaPercent() <= 0.1) and NAG:RemainingTime() >= 5 and NAG:Cast(30823))
    -- Maintain Strength of Earth Totem (best rank)
    or (NAG:SoENeedsRefresh() and NAG:CastSoETotem())
    -- Maintain Mana Spring Totem (best rank)
    or (NAG:MSNeedsRefresh() and NAG:CastManaSpringTotem())

    or NAG:WFSecondsRemaining() <2 and (not NAG:IsWFTotemActiveAnyRank()
        and (NAG:IsAssignmentEnabled("shaman_totem_twist_force") or
            ((not NAG:IsAssignmentEnabled("shaman_totem_twist_never")) and NAG:ShouldTwistWindfury()))
        and not(NAG:InCombat()) and NAG:CastWFTotem())
    or (NAG:WFSecondsRemaining() <2 and
        ((NAG:IsAssignmentEnabled("shaman_totem_twist_force") or
            ((not NAG:IsAssignmentEnabled("shaman_totem_twist_never")) and NAG:ShouldTwistWindfury())))
        and NAG:WFNeedsRefresh() and NAG:CastWFTotem())
    or (not(NAG:IsGoATotemActiveAnyRank()) and (not NAG:InCombat())
        and (NAG:IsAssignmentEnabled("shaman_totem_twist_never") or
            (not NAG:IsAssignmentEnabled("shaman_totem_twist_force") and (not NAG:ShouldTwistWindfury())))
        and NAG:CastGoATotem(NAG.SPELL_POSITIONS.PRIMARY))
    or (not(NAG:IsGoATotemActiveAnyRank()) and (NAG:InCombat()) and NAG:CastGoATotem(
        NAG:ShouldTwistWindfury() and NAG.SPELL_POSITIONS.PRIMARY or NAG.SPELL_POSITIONS.RIGHT))

    -- Cast Fire Elemental Totem before Bloodlust is used (fallback)
    --or ((not NAG:IsTotemActive(2894)) and NAG:SpellCanCast(2894) and NAG:Cast(2894))

    -- Cast Stormstrike (main nuke)
    or (NAG:SpellCanCast(17364) and NAG:Cast(17364))
    -- Maintain Flame Shock (let it expire before reapplying)
    or ((not NAG:DotIsActive(8050)) and NAG:Cast(8050))
    -- Cast Earth Shock (filler)
    or (NAG:SpellCanCast(8042) and NAG:Cast(8042))

    -- Cast Fire Nova Totem if no Fire Elemental and no Fire Nova is active or in windup
    or (not NAG:IsTotemActiveResolved(2894)) and NAG:CountEnemiesInRange(10) > 0 and
        (not (NAG:IsAssignmentEnabled("shaman_totem_twist_force") and NAG:WFNeedsRefresh() and NAG:CanCastWFTotem())) and
        (not NAG:IsFireNovaTotemActiveOrInWindup()) and NAG:SpellCanCast(1535) and NAG:Cast(1535)
    -- Cast Magma Totem if no Fire Elemental and 2+ enemies in range (skip if Fire Nova active or in windup)
    or (not NAG:IsTotemActiveResolved(2894)) and NAG:CountEnemiesInRange(10) > 1 and
        (not (NAG:IsAssignmentEnabled("shaman_totem_twist_force") and NAG:WFNeedsRefresh() and NAG:CanCastWFTotem())) and
        (not NAG:IsFireNovaTotemActiveOrInWindup()) and (not NAG:IsTotemActiveResolved(8187))
        and NAG:SpellCanCast(8187) and NAG:Cast(8187)
    -- Cast Magma Totem on single targets if enabled (skip if Fire Nova active or in windup)
    or (not NAG:IsTotemActiveResolved(2894)) and NAG:CountEnemiesInRange(10) <= 1 and
        (not (NAG:IsAssignmentEnabled("shaman_totem_twist_force") and NAG:WFNeedsRefresh() and NAG:CanCastWFTotem())) and
        (not NAG:IsFireNovaTotemActiveOrInWindup()) and (not NAG:IsTotemActiveResolved(8187)) and
        (not NAG:IsAssignmentEnabled("shaman_magma_st_never")) and
        (NAG:IsAssignmentEnabled("shaman_magma_st_always") or
            (NAG:IsAssignmentEnabled("shaman_magma_st_encounter_only") and NAG:InEncounter()))
        and NAG:SpellCanCast(8187) and NAG:Cast(8187)
    -- Maintain Searing Totem: when fire slot is empty (e.g. after Fire Nova detonates) or when duration needs refresh
    or (not(NAG:IsTotemActiveResolved(2894)) and
        (not (NAG:IsAssignmentEnabled("shaman_totem_twist_force") and NAG:WFNeedsRefresh() and NAG:CanCastWFTotem())) and
        (NAG:FireTotemSlotNeedsFill() or
            ((not NAG:IsFireNovaTotemActiveOrInWindup()) and (not NAG:IsTotemActiveResolved(8187)) and NAG:SearingNeedsRefresh()))
        and NAG:CastSearingTotem())
    -- Fillers
    -- Use Shamanistic Rage when mana is low (<30%) and fight has time left
    or ((NAG:CurrentManaPercent() <= 0.3) and NAG:RemainingTime() >= 5 and NAG:Cast(30823))
    -- Water Shield refresh at low mana
    or ((NAG:CurrentManaPercent() <= 0.4) and (not NAG:AuraIsActive(23575)) and NAG:Cast(23575))

    or NAG:WFSecondsRemaining() <5 and NAG:WFSecondsRemaining() > 2 and
        NAG:SpellTimeToReady(17364) >= 2 and NAG:SpellTimeToReady(8050) >= 2 and
        (not NAG:IsWFTotemActiveAnyRank()
            and (NAG:IsAssignmentEnabled("shaman_totem_twist_force") or
                ((not NAG:IsAssignmentEnabled("shaman_totem_twist_never")) and NAG:ShouldTwistWindfury()))
            and not(NAG:InCombat()) and NAG:CastWFTotem())
    or (NAG:WFSecondsRemaining() <5 and NAG:WFSecondsRemaining() > 2 and
        NAG:SpellTimeToReady(17364) >= 2 and NAG:SpellTimeToReady(8050) >= 2 and
        ((NAG:IsAssignmentEnabled("shaman_totem_twist_force") or
            ((not NAG:IsAssignmentEnabled("shaman_totem_twist_never")) and NAG:ShouldTwistWindfury())))
        and NAG:WFNeedsRefresh() and NAG:CastWFTotem())

    -- LOOK-AHEAD (wait logic): predict the next spell the user is holding for
    -- Wait for Stormstrike (up to 3s) if it becomes ready before Flame Shock
    or ((NAG:SpellTimeToReady(17364) < NAG:SpellTimeToReady(8050))) and NAG:Cast(17364, 5)
    -- Wait for Flame Shock (up to 3s) if, by the time it is ready, the dot will have expired
    or ((NAG:SpellTimeToReady(8050) > 0) and (NAG:SpellTimeToReady(8050) <= 5) and
        ((not NAG:DotIsActive(8050)) or (NAG:DotRemainingTime(8050) <= (NAG:SpellTimeToReady(8050) + 0.1)))) and
        NAG:Cast(8050, 5)
    -- Otherwise, wait for Earth Shock (up to 5s)
    or NAG:Cast(8042, 5)
    ]],

    -- Tracked IDs for optimization
    spells = {17364, 8050, 8042, 1535, 3599, 23575, 8232, 2894, 8512, 8512, 8835, 8075, 5675, 8187},
    items = {},
    auras = {23575, 8050, 8232}, -- Water Shield, Flame Shock, Windfury Weapon

    -- Optional metadata
    guide = [[
Enhancement Shaman Rotation Guide (TBC)

Core Mechanics:
- Enhancement Shamans are melee DPS with dual-wield weapons and totem support.
- Weapon syncing is critical for maximizing Flurry uptime and Windfury Weapon procs.
- Totem Twisting (rotating Windfury Totem and Grace of Air Totem every 10 seconds) is essential.
- Mana management is important - use Shamanistic Rage when low on mana.

Rotation Priority (Single Target):
1. Use Windfury Weapon on both weapons (maintained as weapon enchant, not in rotation)
2. Maintain Water Shield (passive mana regeneration - refresh before it expires)
3. Maintain Strength of Earth Totem (provides strength buff to raid)
4. Maintain Mana Spring Totem (provides mana regeneration to raid)
5. Totem Twisting: Every 10 seconds, cast Windfury Totem followed by Grace of Air Totem
   - This technique provides both melee haste (Windfury) and agility (Grace of Air) buffs
   - Requires precise timing - cast Windfury, wait ~2 seconds, then cast Grace of Air
   - Repeat every ~10 seconds to maintain both buffs
6. Cast Fire Elemental Totem before Bloodlust is used (maximizes Fire Elemental damage)
7. Cast Stormstrike (main nuke ability, use on cooldown)
8. Maintain Flame Shock (let it expire before reapplying - DoT damage)
9. Cast Earth Shock (can usually get 2 casts off in between Flame Shock refreshes)
10. Cast Fire Nova Totem (AoE damage, requires Searing Totem or Magma Totem to be active first)
11. Maintain Searing Totem (provides consistent fire damage)

AoE Rotation:
1. Use Fire Nova Totem (AoE damage explosion; wait ~4s for it to detonate before next fire totem)
2. Maintain Magma Totem (drop only after Fire Nova has exploded)
3. Perform single target rotation (Stormstrike, shocks, etc.)

Weapon Syncing:
The benefit of syncing your weapons is to make the most out of Flurry and ensure that your Main Hand weapon is always the one benefiting from Windfury Weapon procs.

To achieve this consistently:
1. Right-click your target from out of range before the fight starts
2. When your weapon swing timer is half way done, use the following macro:

   /tar Player
   /targetlasttarget
   /startattack

3. This resets your swing timer and synchronizes both weapons

Totem Twisting Technique:
- Cast Windfury Totem first (provides melee haste buff)
- Wait approximately 2 seconds
- Cast Grace of Air Totem (provides agility buff)
- Both totems have ~20 second durations, but you refresh them every 10 seconds
- This maintains both buffs simultaneously for maximum DPS

Totem Priority:
- Fire: Searing Totem (single target) or Fire Nova Totem (AoE) -> Magma Totem (after Fire Nova)
- Earth: Strength of Earth Totem (provides strength buff)
- Water: Mana Spring Totem (provides mana regeneration)
- Air: Windfury Totem -> Grace of Air Totem (Totem Twisting)

Cooldowns:
- Fire Elemental Totem: 20min CD. Summons powerful Fire Elemental pet. Use before Bloodlust for maximum damage.
- Shamanistic Rage: 2min CD. Restores mana based on attack power. Use when low on mana.

Mana Management:
- Water Shield: Provides passive mana regeneration - always maintain it
- Mana Spring Totem: Provides mana regeneration to raid - always maintain it
- Shamanistic Rage: Use when low on mana to restore significant amounts
- Earth Shock: Use as filler when Flame Shock is active and Stormstrike is on cooldown

Raid Utility:
- Windfury Totem: Provides melee haste buff to raid (via Totem Twisting)
- Grace of Air Totem: Provides agility buff to raid (via Totem Twisting)
- Strength of Earth Totem: Provides strength buff to raid
- Mana Spring Totem: Provides mana regeneration to raid
- Usually 1-2 Enhancement Shamans per raid for melee group support

Weapon Choice:
- Dual-wield fast one-handed weapons
- Windfury Weapon enchant on both weapons
- Weapon syncing is critical for optimal DPS
    ]],
    author = "Rakizi",
}

-- Restoration Healing Rotation (spec 3)
-- Mouseover-based healing: uses NAG.state.healing from TBC HealingStateManager
-- devOnly: visible only when Developer Mode is enabled
-- TBC Resto Shaman key spells:
--   Healing Wave (331), Lesser Healing Wave (8004), Chain Heal (1064),
--   Earth Shield (974), Water Shield (24398), Mana Tide Totem (16190),
--   Nature's Swiftness (16188), Cure Disease (2870), Cure Poison (526)
local restorationRotation = {
    name = "Restoration",
    specIndex = 3,
    description = "Mouseover healing: Earth Shield, Chain Heal, Healing Wave, Lesser Healing Wave.",
    class = "SHAMAN",
    default = true,
    enabled = true,
    devOnly = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    lastModified = "02/08/2026",
    rotationString = [[
-- Water Shield upkeep (self)
(not NAG:AuraIsActive(24398)) and NAG:SpellCanCast(24398) and NAG:Cast(24398)

-- Dispel: Cure Disease / Cure Poison on mouseover with dispellable debuff
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverNeedsDispel()) and NAG:SpellCanCast(2870) and NAG:Cast(2870)
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverNeedsDispel()) and NAG:SpellCanCast(526) and NAG:Cast(526)

-- Earth Shield on mouseover (keep on focus/tank; TBC has no UnitGroupRolesAssigned)
or (NAG:MouseoverFriendlyExists() and (not NAG:MouseoverIsSelf())
    and (NAG:MouseoverBuffRemains(974) < 3 or not NAG:MouseoverHasBuff(974))
    and NAG:SpellCanCast(974)) and NAG:Cast(974)

-- Nature's Swiftness + Healing Wave for emergency
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 25
    and NAG:SpellCanCast(16188)) and NAG:Cast(16188)

-- Chain Heal when 2+ need healing
or (NAG:LowHealthMemberCount(80) >= 2 and NAG:SpellCanCast(1064)) and NAG:Cast(1064)

-- Mana Tide Totem when low mana
or (NAG:CurrentManaPercent() <= 0.30 and NAG:SpellCanCast(16190)) and NAG:Cast(16190)

-- Lesser Healing Wave on critical mouseover (fast)
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 40
    and NAG:SpellCanCast(8004)) and NAG:Cast(8004)

-- Healing Wave on low mouseover (efficient)
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 70
    and NAG:SpellCanCast(331)) and NAG:Cast(331)

-- Lesser Healing Wave filler on moderate mouseover
or (NAG:MouseoverFriendlyExists() and NAG:MouseoverHealthPercent() < 90
    and NAG:SpellCanCast(8004)) and NAG:Cast(8004)

-- Damage filler: Lightning Bolt
or NAG:SpellCanCast(403) and NAG:Cast(403)
    ]],

    spells = {331, 403, 526, 974, 1064, 2870, 8004, 16188, 16190, 24398},
    items = {},
    auras = {974, 24398},
    author = "Smufrik",
}

--- @class Shaman : ClassBase
local Shaman = NAG:CreateClassModule("SHAMAN", defaults)
if not Shaman then return end

function Shaman:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 0, genericRotation)  -- Generic (no talents)
    ns.AddRotationToDefaults(self.defaults, 1, elementalRotation)  -- Elemental
    ns.AddRotationToDefaults(self.defaults, 2, enhancementRotation)  -- Enhancement
    ns.AddRotationToDefaults(self.defaults, 3, restorationRotation)  -- Restoration
end

local BaseGetOptions = Shaman.GetOptions
function Shaman:GetOptions()
    local options = BaseGetOptions(self)
    options.args = options.args or {}
    options.args.settings = options.args.settings or { type = "group", args = {} }
    options.args.settings.args = options.args.settings.args or {}
    options.args.settings.args.selfHeal = {
        type = "group",
        name = "Self-heal when low",
        order = 20,
        inline = true,
        args = {
            selfHealDesc = {
                type = "description",
                name = "The threshold is only used when the active rotation includes the self-heal suggestion (e.g. Generic rotation). Other rotations ignore these settings.",
                order = 0,
                fontSize = "medium",
            },
            recommendSelfHeal = {
                type = "toggle",
                name = "Recommend self-heal when low health",
                desc = "When the rotation includes self-heal (e.g. Generic), suggest a heal when your health is below the threshold.",
                order = 1,
                get = function() return self:GetSetting("class", "recommendSelfHeal", true) end,
                set = function(_, val) self:SetSetting("class", "recommendSelfHeal", val) end,
                width = "full",
            },
            selfHealThreshold = {
                type = "range",
                name = "Self-heal threshold (health %)",
                desc = "When the rotation includes self-heal, suggest it when health is below this percentage (10-60%).",
                order = 2,
                min = 0.1,
                max = 0.6,
                step = 0.05,
                get = function() return self:GetSetting("class", "selfHealThreshold", 0.35) end,
                set = function(_, val) self:SetSetting("class", "selfHealThreshold", val) end,
                width = "full",
            },
        }
    }
    return options
end

NAG.Class = Shaman

