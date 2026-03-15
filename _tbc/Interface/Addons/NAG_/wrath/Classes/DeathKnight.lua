local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version

local defaults = ns.InitializeClassDefaults()

-- Wrath Death Knight spec spell locations
defaults.class.specSpellLocations = {
    [1] = {},  -- Blood
    [2] = {},  -- Frost
    [3] = {},  -- Unholy
}

if UnitClassBase('player') ~= "DEATHKNIGHT" then return end

-- Blood Rotation
local bloodRotation = {
    -- Core identification
    name = "Blood",
    specIndex = 1,
    class = "DEATHKNIGHT",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[NAG:Cast(6603)]],
}

-- Frost Rotation
local frostRotation = {
    -- Core identification
    name = "Frost",
    specIndex = 2,
    class = "DEATHKNIGHT",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    lastModified = "02/02/2026",
    rotationString = [[
    NAG:AutocastOtherCooldowns()
    or NAG:AuraIsActive(51271, "player", false) and NAG:CastSpell(54758)
    or (NAG:RemainingTime() <= 10.0) and NAG:CastSpell(51425)
    or ((NAG:RemainingTime() <= 8.0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 2) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) <= 2.0)) and NAG:CastSpell(51425)
    or (NAG:RemainingTime() <= 5.0) and NAG:CastSpell(55268)
    or (NAG:RemainingTime() <= 5.0) and NAG:CastSpell(51411)
    or (NAG:RemainingTime() <= 3.0) and NAG:CastSpell(49930)
    or ((NAG:CurrentTime() == 0) or (not NAG:DotIsActive(55095))) and NAG:CastSpell(59131)
    or (not NAG:DotIsActive(55078)) and NAG:CastSpell(49921)
    or ((NAG:DotIsActive(55078) and (NAG:CurrentTime() <= 19.0))) and NAG:StrictSequence("UB Blood Tap", nil, 51271,45529)
    or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 2) and NAG:AuraIsActive(51271, "player", false) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentTime() > 10) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and NAG:SpellIsReady(47568)) and NAG:CastSpell(51425)
    or -- Strictsequence filtered: only spellIds from Cast, removed none
((((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) >= 1) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) >= 1)) and NAG:AuraIsActive(51271, "player", false) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) > 3) and (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) > 3) and (NAG:CurrentRunicPower() <= 105)) and (NAG:RemainingTime() >= 60)) and NAG:CastWithOverlay(47568, "Pesti+ERW")
    or (NAG:AuraIsActive(51271, "player", false) and NAG:AuraIsActive(54758, "player", false) and (not ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 2) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 2) or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 2)))) and NAG:CastSpell(46584, nil, NAG.SPELL_POSITIONS.LEFT)
    or ((NAG:DotRemainingTime(55095) <= 1.5) and NAG:DotIsActive(55095)) and NAG:CastSpell(50842,0.5)
    or -- Strictsequence filtered: only spellIds from Cast, removed none
((NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood) and (NAG:RuneSlotCooldown(NAG.Types.RuneSlot.SlotRightBlood) <= 1.5) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftFrost)) and (not NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightFrost)) and ((NAG:SpellTimeToReady(51271) <= 1.5) or NAG:SpellIsReady(51271)))) and NAG:StrictSequence("Pest+UB", nil, 50842,51271)
    or -- Strictsequence filtered: only spellIds from Cast, removed none
((NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotLeftBlood) and NAG:CurrentRuneDeath(NAG.Types.RuneSlot.SlotRightBlood) and NAG:SpellIsReady(45529) and NAG:AuraIsActive(51271, "player", false) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotRightBlood))) and NAG:StrictSequence("OB+BT", nil, 45529, 51425)
    or (NAG:AuraIsActive(59052, "player", false) and NAG:DotIsActive(55095) and (NAG:DotRemainingTime(55095) >= 3.0)) and NAG:CastSpell(51411)
    or NAG:AuraIsActive(51271, "player", false) and NAG:CastSpell(51425)
    or ((NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) >= 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) >= 1)) and NAG:CastSpell(51425)
    or (NAG:CurrentRunicPower() >= 115) and NAG:CastSpell(55268)
    or ((NAG:DotRemainingTime(55095) <= 6.0) and NAG:DotIsActive(55095) and NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftBlood) and (NAG:SpellTimeToReady(51271) >= 6.0)) and NAG:CastSpell(50842,0.5)
    or (NAG:DotIsActive(55095) and (NAG:DotRemainingTime(55095) > 10.0) and (NAG:CurrentTime() > 22.5)) and NAG:CastSpell(49930,0.5)
    or NAG:AuraIsActive(59052, "player", false) and NAG:CastSpell(51411)
    or (NAG:AuraIsActive(51271, "player", false) and NAG:AuraIsActive(54758, "player", false)) and NAG:CastSpell(46584, nil,  NAG.SPELL_POSITIONS.LEFT)
    or (not ((NAG:RuneCooldown(NAG.Types.RuneType.RuneBlood) < 0.5) or (NAG:RuneCooldown(NAG.Types.RuneType.RuneFrost) < 0.5) or (NAG:RuneCooldown(NAG.Types.RuneType.RuneUnholy) < 0.5))) and NAG:CastSpell(57623)
    or NAG:CastSpell(55268)
    ]],

    -- Tracked IDs for optimization
    spells = {
        59131,  -- Icy Touch (applies Frost Fever)
        49921,  -- Plague Strike (applies Blood Plague)
        51425,  -- Obliterate (main damage)
        55268,  -- Frost Strike (RP dump)
        51411,  -- Howling Blast (AoE / Rime proc)
        49930,  -- Blood Strike (converts Blood -> Death rune)
        50842,  -- Pestilence (spreads/refreshes diseases with glyph)
        51271,  -- Unbreakable Armor (burst CD)
        45529,  -- Blood Tap (converts Blood -> Death rune)
        47568,  -- Empower Rune Weapon (resets all runes)
        46584,  -- Raise Dead (summon ghoul)
        57623,  -- Horn of Winter (buff + RP)
    },
    items = {},
    auras = {
        55095,  -- Frost Fever (disease)
        55078,  -- Blood Plague (disease)
        51271,  -- Unbreakable Armor (self buff)
        59052,  -- Rime proc (free Howling Blast)
        51130,  -- Killing Machine proc (guaranteed crit)
    },

    -- Comprehensive guide for Frost Death Knight
    guide = [[
Frost Death Knight Rotation Guide (WotLK Classic)

================================================================================
RESOURCE SYSTEM
================================================================================

RUNES (Primary Resource):
- 6 runes total: 2 Blood (red), 2 Frost (blue), 2 Unholy (green)
- Each rune has a 10-second regeneration cooldown when consumed
- Death Runes: Special runes that can substitute for ANY rune type
- Blood Runes can be converted to Death Runes via Blood Strike or Blood Tap

RUNIC POWER (Secondary Resource):
- Generated when using abilities that consume runes (~10 RP per rune)
- Maximum capacity: 130 Runic Power
- Spent on Frost Strike (40 RP, or 32 with Glyph of Frost Strike)
- NEVER cap out - always spend before hitting 130 to avoid waste

================================================================================
RUNE GRACE PERIOD (Critical Mechanic)
================================================================================

How it works:
1. When you use a rune, it goes on a 10-second cooldown
2. After the cooldown finishes, you have ~2.5 seconds of "grace period"
3. During this grace period, use Runic Power abilities (Frost Strike)
4. If you cast a rune ability within the grace period, the next cooldown
   is REDUCED by the time you waited

Example:
- Use Frost rune -> 10 sec cooldown starts
- Cooldown finishes, you have 2.5 sec grace period
- Cast Frost Strike (RP ability) taking ~1.5 sec
- Cast Icy Touch (Frost rune ability)
- NEW cooldown is only ~8.5 seconds instead of 10

Optimal Play:
- Use WeakAuras to track rune grace periods visually
- Fill grace periods with Frost Strike, Horn of Winter, or Rime procs
- This mechanic is KEY to maximizing DPS

Technical Detail:
Using a rune puts it on a (10 - rune_grace) cooldown. As long as you spend
runes within 2.5s of them coming off CD, you use each rune "on cooldown"
and never drift its regeneration timing.

================================================================================
RUNE DESYNC & OBLIT TRICKING (Advanced)
================================================================================

WHAT IS RUNE DESYNC?
Rune Desync refers to when paired runes (left and right of the same type)
get out of synchronization with each other:

- SYNCED: Both Frost runes come off cooldown at nearly the same time
- DESYNCED: Left Frost rune ready, Right Frost rune has 3-5 seconds left

Why it matters:
Obliterate costs 1 Frost + 1 Unholy. If pairs are perfectly synced, you
cast Obliterate -> wait 10s -> both pairs ready -> Obliterate again.

If desynced, you might have partial runes available but can't Obliterate
because you need one of EACH type simultaneously.

OBLIT TRICKING (Advanced Technique):
"Rune Grace is actively used in Frost to spend Killing Machine procs
sooner without drifting Obliterate runes - this is called Oblit Tricking."
- Blight Club DK FAQ

How it works:
1. Cast Obliterate (uses 1 Frost + 1 Unholy)
2. Wait for Killing Machine proc from auto-attacks
3. DURING RUNE GRACE (within 2.5s of runes returning), cast Frost Strike
4. Cast next Obliterate within the grace window
5. Runes DON'T drift because you stayed within grace period

Benefits:
- Maximize KM procs on Frost Strike (highest single-target damage)
- Fill every grace window optimally
- Rune cooldowns stay consistent and predictable

DISEASE REFRESH DESYNC PROBLEM:
When following rotations like IT -> PS -> BT -> UA -> Pesti -> Obli -> Obli,
players find that by the third Pestilence, Blood runes aren't ready yet
and diseases fall off before they can be refreshed.

Solutions:
1. SIMPLE: Let diseases expire naturally, reapply with IT + PS instead
   Rotation: IT -> PS -> Obli -> BS -> BS -> FS -> Obli -> Obli -> Obli -> FS

2. PLANNED: Refresh diseases when <1.5-3s remaining AND Blood rune ready
   Accept occasional hard-cast IT/PS when timing doesn't align

INTENTIONAL DESYNC (Expert Level):
Some players intentionally desync runes for optimization:

Why desync intentionally?
- More grace period windows for Frost Strike insertion
- Better Killing Machine proc usage
- Smoother Runic Power management (avoid capping)

How to desync:
- Use single-rune abilities (Icy Touch, Blood Strike) to offset pairs
- Creates staggered rune availability instead of synchronized bursts

Tradeoff:
- More complex to track mentally
- Requires excellent rune grace understanding
- Slightly more Frost Strikes possible
- Higher skill floor, marginal DPS gain

RUNEFORGE OPTIMIZATION:
- Razorice MAIN HAND + Fallen Crusader OFF HAND (if not expertise capped)
- Why? If Obliterate is dodged, only MAIN HAND portion is dodged
- OFF HAND still hits, giving more Fallen Crusader procs
- If expertise capped: FC on slower weapon, Razorice on faster

================================================================================
CORE SPELLS
================================================================================

Disease Application:
- Icy Touch (59131): 1 Frost rune - applies Frost Fever disease
- Plague Strike (49921): 1 Unholy rune - applies Blood Plague disease

Main Damage:
- Obliterate (51425): 1 Frost + 1 Unholy - MAIN damage ability, use often
- Frost Strike (55268): 40 RP (32 glyphed) - RP dump between rune abilities
- Howling Blast (51411): 1 Frost + 1 Unholy - ONLY use on Rime proc for ST

Rune Management:
- Blood Strike (49930): 1 Blood - converts Blood rune to Death rune
- Pestilence (50842): 1 Blood - refreshes diseases (with Glyph of Disease)
- Blood Tap (45529): Health cost - instantly converts Blood to Death rune

Cooldowns:
- Unbreakable Armor (51271): 1 Frost - +20% Str, +25% Armor (1 min CD)
- Empower Rune Weapon (47568): Resets ALL runes + 25 RP (5 min CD)
- Raise Dead (46584): Summons ghoul for extra damage

Utility:
- Horn of Winter (57623): Group buff + 10 RP (use when all runes on CD)

================================================================================
KEY PROCS TO TRACK
================================================================================

Rime (59052):
- Source: Obliterate crits
- Effect: Free, instant Howling Blast
- Priority: Use immediately when diseases have >3s remaining

Killing Machine (51130):
- Source: Auto-attacks (higher proc rate with dual wield)
- Effect: Next Frost Strike/Howling Blast/Icy Touch = guaranteed crit
- Priority: Use Frost Strike during rune grace periods when KM is active

================================================================================
TALENT BUILD VARIATIONS
================================================================================

FROST/BLOOD (Standard Build) - Recommended for most players:
Talent String: 23050005-32005350352203012300033101351

Key Blood Talents:
- Butchery (2/2): Passive RP generation in combat
- Bladed Armor (5/5): +5 AP per 180 Armor (synergy with Unbreakable Armor)
- Dark Conviction (5/5): +5% crit
- Subversion (3/3): +9% crit on Blood Strike/Obliterate

Best For:
- Lower gear levels and early phases (Naxx, Ulduar)
- When you lack crit/haste from gear
- Smoother RP generation

FROST/UNHOLY (Sub-Unholy Build) - For high-end gear:
Talent String: 01-32002350342203012300033101351-230200305003

Key Unholy Talents:
- Necrosis (5/5): +20% shadow damage on all melee attacks
- Blood-Caked Blade (3/3): 30% chance for extra attack
- Impurity: Increases spell power scaling

Best For:
- ICC phase with high gear levels
- High attack speed gear (more Necrosis/BCB procs)
- When you already have high crit from gear

WHEN TO SWITCH:
- Pre-BiS / Early Phases: Frost/Blood
- Low crit (<35%): Frost/Blood
- High crit (>40%) + fast weapons: Frost/Unholy
- ICC Gear (high ArP, fast weapons): Frost/Unholy
- Need threat reduction: Frost/Blood (has Subversion)

================================================================================
SINGLE TARGET ROTATION PRIORITY
================================================================================

1. APPLY DISEASES (if missing):
   - Icy Touch if no Frost Fever
   - Plague Strike if no Blood Plague

2. OPENER (first 19 seconds):
   - Blood Tap + Unbreakable Armor
   - Obliterate
   - Frost Strike
   - Pestilence (refresh diseases)
   - Empower Rune Weapon (reset runes)
   - Obliterate spam + Frost Strike dumps
   - Raise Dead during burst

3. SUSTAIN PRIORITY:
   a) Refresh diseases via Pestilence (when <1.5-3s remaining)
   b) Obliterate (when Frost + Unholy runes available)
   c) Howling Blast on Rime proc (free, use when diseases >3s)
   d) Frost Strike (when capping RP >115, or during rune grace)
   e) Blood Strike (to convert Blood -> Death runes)
   f) Horn of Winter (when all runes on CD, gives 10 RP)
   g) Raise Dead (during Unbreakable Armor + trinket procs)

4. END OF FIGHT (<10 seconds):
   - Dump everything: Obliterate > Frost Strike > Howling Blast

================================================================================
AOE ROTATION
================================================================================

For multiple targets:
1. Apply diseases to primary target (Icy Touch + Plague Strike)
   OR use Howling Blast with Glyph of Howling Blast to apply Frost Fever
2. Spread diseases with Pestilence
3. Drop Death and Decay
4. Spam Howling Blast (uses Frost + Unholy runes)
5. Use Blood Strike to convert Blood runes to Death runes
6. More Howling Blast spam

================================================================================
REQUIRED GLYPHS
================================================================================

Major Glyphs:
- Glyph of Obliterate: +25% Obliterate damage (MANDATORY)
- Glyph of Frost Strike: Reduces cost by 8 RP (MANDATORY)
- Glyph of Disease: Pestilence refreshes disease duration (MANDATORY)

Minor Glyphs:
- Glyph of Blood Tap: No health cost
- Glyph of Pestilence: +5 yard range
- Glyph of Raise Dead: No reagent required

================================================================================
STAT PRIORITY
================================================================================

1. Hit Rating to melee cap (8%)
2. Expertise to soft cap (26)
3. Strength (primary stat)
4. Armor Penetration (cap achievable in ICC)
5. Critical Strike
6. Haste

================================================================================
WEAPON CHOICE
================================================================================

Dual Wield is standard for Frost DK in WotLK:
- Two runeforges (Fallen Crusader + Razorice typically)
- More auto-attacks = more Killing Machine procs
- Better synergy with Necrosis and Blood-Caked Blade
- Higher Frost Strike frequency

================================================================================
PRESENCES
================================================================================

- Blood Presence (default): +15% damage, 4% healing from damage dealt
- Unholy Presence: -0.5s GCD, +15% movement/attack speed (niche use)
- Frost Presence: Tank presence, not for DPS

================================================================================
TIPS FOR OPTIMIZATION
================================================================================

1. Track rune grace periods with WeakAuras - this is huge for DPS
2. Never cap Runic Power - dump with Frost Strike before hitting 130
3. Always use Rime procs when diseases have sufficient duration (>3s)
4. Line up Unbreakable Armor with trinket procs when possible
5. Use Empower Rune Weapon early (5 min CD) to potentially get 2 uses
6. Convert Blood runes to Death runes for more Obliterate casts
7. Use Horn of Winter as filler when all runes are on cooldown
8. Pre-cast Army of the Dead before pull (long channel time)
    ]],
    author = "NAG Team",
}

-- Unholy Rotation
local unholyRotation = {
    -- Core identification
    name = "Unholy",
    specIndex = 3,
    class = "DEATHKNIGHT",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_WRATH,
    rotationString = [[NAG:Cast(6603)]],
}

--- @class DeathKnight : ClassBase
local DeathKnight = NAG:CreateClassModule("DEATHKNIGHT", defaults)
if not DeathKnight then return end

function DeathKnight:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 1, bloodRotation)  -- Blood
    ns.AddRotationToDefaults(self.defaults, 2, frostRotation)  -- Frost
    ns.AddRotationToDefaults(self.defaults, 3, unholyRotation)  -- Unholy
end

NAG.Class = DeathKnight

