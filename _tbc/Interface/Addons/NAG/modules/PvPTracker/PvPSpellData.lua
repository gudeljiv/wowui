--- @module "NAG.PvPTracker.PvPSpellData"
--- Tracked cooldown spell data for PvP (interrupts, defensives, CC).
---
--- Expansion-specific overrides in Phase 7. Base set uses common spell IDs
--- that exist across TBC/Wrath/Cata/Mists.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

local _, ns = ...

-- Combat log object flags (WoW API)
local COMBATLOG_OBJECT_REACTION_FRIENDLY = 0x40

-- ============================ TRACKED COOLDOWNS ============================
-- [spellId] = { duration = seconds, category = "interrupt"|"defensive"|"cc"|"offensive" }
-- Durations from default cooldowns; WoWAPI.GetSpellCooldown can override when available.

local TRACKED_COOLDOWNS = {
    -- Interrupts (24-15 sec typically)
    [2139] = { duration = 24, category = "interrupt" },   -- Counterspell (Mage)
    [1766] = { duration = 15, category = "interrupt" },   -- Kick (Rogue)
    [6552] = { duration = 15, category = "interrupt" },   -- Pummel (Warrior)
    [72] = { duration = 12, category = "interrupt" },     -- Shield Bash (Warrior)
    [19647] = { duration = 24, category = "interrupt" },  -- Spell Lock (Warlock Felhunter)
    [47528] = { duration = 15, category = "interrupt" },  -- Mind Freeze (DK)
    [96231] = { duration = 15, category = "interrupt" },  -- Rebuke (Paladin)
    [57994] = { duration = 12, category = "interrupt" },  -- Wind Shear (Shaman)
    [147362] = { duration = 24, category = "interrupt" }, -- Counter Shot (Hunter)
    [116705] = { duration = 15, category = "interrupt" }, -- Spear Hand Strike (Monk)
    [183752] = { duration = 24, category = "interrupt" }, -- Disrupt (DH)
    [106839] = { duration = 15, category = "interrupt" }, -- Skull Bash (Druid Feral)
    [212619] = { duration = 24, category = "interrupt" }, -- Call Felhunter (Warlock)
    [31935] = { duration = 15, category = "interrupt" },  -- Avenger's Shield (Paladin - interrupts)
    [15487] = { duration = 45, category = "interrupt" },  -- Silence (Priest)
    [132409] = { duration = 24, category = "interrupt" }, -- Spell Lock (Warlock - different ID)
}

-- Defensives (major CDs)
local DEFENSIVE_SPELLS = {
    [45438] = { duration = 300, category = "defensive" }, -- Ice Block (Mage)
    [871] = { duration = 480, category = "defensive" },   -- Shield Wall (Warrior)
    [5277] = { duration = 180, category = "defensive" },  -- Evasion (Rogue)
    [31224] = { duration = 120, category = "defensive" }, -- Cloak of Shadows (Rogue)
    [642] = { duration = 300, category = "defensive" },   -- Divine Shield (Paladin)
    [498] = { duration = 60, category = "defensive" },    -- Divine Protection (Paladin)
    [48792] = { duration = 120, category = "defensive" }, -- Icebound Fortitude (DK)
    [55233] = { duration = 60, category = "defensive" },  -- Vampiric Blood (DK)
    [33206] = { duration = 180, category = "defensive" }, -- Pain Suppression (Priest)
    [47788] = { duration = 180, category = "defensive" }, -- Guardian Spirit (Priest)
    [19263] = { duration = 90, category = "defensive" },  -- Deterrence (Hunter)
    [30823] = { duration = 60, category = "defensive" },  -- Shamanistic Rage (Shaman)
    [108271] = { duration = 90, category = "defensive" }, -- Astral Shift (Shaman)
    [22812] = { duration = 60, category = "defensive" },  -- Barkskin (Druid)
    [61336] = { duration = 180, category = "defensive" }, -- Survival Instincts (Druid)
    [47585] = { duration = 120, category = "defensive" }, -- Dispersion (Priest)
    [110909] = { duration = 120, category = "defensive" }, -- Alter Time (Mage)
    [104773] = { duration = 180, category = "defensive" }, -- Unending Resolve (Warlock)
    [108416] = { duration = 60, category = "defensive" }, -- Dark Pact (Warlock)
    [115203] = { duration = 180, category = "defensive" }, -- Fortifying Brew (Monk)
    [122783] = { duration = 120, category = "defensive" }, -- Diffuse Magic (Monk)
    [122278] = { duration = 90, category = "defensive" }, -- Dampen Harm (Monk)
    [1966] = { duration = 15, category = "defensive" },   -- Feint (Rogue)
    [1856] = { duration = 120, category = "defensive" },  -- Vanish (Rogue)
}

-- Merge defensives into tracked
for spellId, data in pairs(DEFENSIVE_SPELLS) do
    if not TRACKED_COOLDOWNS[spellId] then
        TRACKED_COOLDOWNS[spellId] = data
    end
end

-- PvP Trinket (Gladiator's Medallion etc.)
local PVP_TRINKET_SPELLS = {
    [42292] = { duration = 120, category = "defensive" }, -- Trinket (many IDs exist per expansion)
    [195710] = { duration = 120, category = "defensive" }, -- Gladiator's Medallion (Legion+)
    [208683] = { duration = 120, category = "defensive" }, -- Gladiator's Medallion
}

for spellId, data in pairs(PVP_TRINKET_SPELLS) do
    if not TRACKED_COOLDOWNS[spellId] then
        TRACKED_COOLDOWNS[spellId] = data
    end
end

-- ============================ IMMUNITY BUFFS ============================
-- Buffs that make the unit immune to damage/CC. When present, suppress offensive suggestions.
local IMMUNITY_SPELL_IDS = {
    [45438] = true, -- Ice Block (Mage)
    [642] = true,   -- Divine Shield (Paladin)
    [1022] = true,  -- Hand of Protection (Paladin)
    [10278] = true, -- Hand of Protection (Paladin rank)
    [5599] = true,  -- Hand of Protection (Paladin rank)
    [1038] = true,  -- Hand of Salvation (different - not immunity, skip)
}
-- Fix: 1038 is not immunity. Only 45438, 642, 1022, 10278, 5599 are.
IMMUNITY_SPELL_IDS[1038] = nil

-- Legion+ and other expansion immunities (filtered per-version)
local IMMUNITY_SPELL_IDS_LEGION = {
    [186265] = true, -- Aspect of the Turtle (Hunter)
    [196555] = true, -- Netherwalk (DH)
}

for spellId, _ in pairs(IMMUNITY_SPELL_IDS_LEGION) do
    IMMUNITY_SPELL_IDS[spellId] = true
end

-- ============================ EXPANSION-SPECIFIC FILTERING ============================
-- Spell IDs that do not exist in each expansion (DK added Wrath, Monk MoP, DH Legion)
-- When Version matches, we exclude these from the active table.

local SPELLS_EXCLUDED_FROM_TBC = {
    -- Death Knight (Wrath+)
    [47528] = true, [48792] = true, [55233] = true, [47476] = true, [91800] = true,
    [91797] = true, [47481] = true, [108194] = true, [204085] = true, [108199] = true,
    -- Monk (MoP+)
    [116705] = true, [119381] = true, [118345] = true, [115078] = true, [115203] = true,
    [122783] = true, [122278] = true, [198909] = true,
    -- Demon Hunter (Legion+)
    [183752] = true, [179057] = true, [211881] = true, [221527] = true, [217832] = true,
    [207685] = true, [212638] = true,
    -- Cata+ interrupts/abilities
    [96231] = true, [147362] = true, [106839] = true, [132409] = true, [212619] = true,
    -- Legion+ trinket
    [195710] = true, [208683] = true,
    -- Cata+ defensives
    [108271] = true, [110909] = true, [104773] = true, [108416] = true,
}

local SPELLS_EXCLUDED_FROM_WRATH = {
    -- Monk (MoP+)
    [116705] = true, [119381] = true, [118345] = true, [115078] = true, [115203] = true,
    [122783] = true, [122278] = true, [198909] = true,
    -- Demon Hunter (Legion+)
    [183752] = true, [179057] = true, [211881] = true, [221527] = true, [217832] = true,
    [207685] = true, [212638] = true,
    -- Cata+ (Rebuke, Counter Shot, Skull Bash, etc.)
    [96231] = true, [147362] = true, [106839] = true, [132409] = true, [212619] = true,
    [108271] = true, [110909] = true, [104773] = true, [108416] = true,
    [195710] = true, [208683] = true,
}

local SPELLS_EXCLUDED_FROM_CATA = {
    -- Monk (MoP+)
    [116705] = true, [119381] = true, [118345] = true, [115078] = true, [115203] = true,
    [122783] = true, [122278] = true, [198909] = true,
    -- Demon Hunter (Legion+)
    [183752] = true, [179057] = true, [211881] = true, [221527] = true, [217832] = true,
    [207685] = true, [212638] = true,
    [195710] = true, [208683] = true,
}

local SPELLS_EXCLUDED_FROM_MISTS = {
    -- Demon Hunter (Legion+)
    [183752] = true, [179057] = true, [211881] = true, [221527] = true, [217832] = true,
    [207685] = true, [212638] = true,
    [195710] = true, [208683] = true,
}

local function BuildTrackedCooldownsForVersion()
    local Version = ns.Version
    if not Version then return TRACKED_COOLDOWNS end

    local exclude
    if Version.IsTBC and Version:IsTBC() then
        exclude = SPELLS_EXCLUDED_FROM_TBC
    elseif Version.IsWrath and Version:IsWrath() then
        exclude = SPELLS_EXCLUDED_FROM_WRATH
    elseif Version.IsCata and Version:IsCata() then
        exclude = SPELLS_EXCLUDED_FROM_CATA
    elseif Version.IsMists and Version:IsMists() then
        exclude = SPELLS_EXCLUDED_FROM_MISTS
    else
        return TRACKED_COOLDOWNS
    end

    if not exclude then return TRACKED_COOLDOWNS end

    local result = {}
    for spellId, data in pairs(TRACKED_COOLDOWNS) do
        if not exclude[spellId] then
            result[spellId] = data
        end
    end
    return result
end

local ACTIVE_TRACKED_COOLDOWNS = BuildTrackedCooldownsForVersion()

-- ============================ EXPORTS ============================

-- Filter immunity spells by expansion (Legion+ spells not in TBC/Wrath)
local IMMUNITY_EXCLUDED_TBC = { [186265] = true, [196555] = true }
local IMMUNITY_EXCLUDED_WRATH = { [186265] = true, [196555] = true }
local IMMUNITY_EXCLUDED_CATA = { [196555] = true }
local IMMUNITY_EXCLUDED_MISTS = { [196555] = true }

local function BuildImmunitySpellIdsForVersion()
    local Version = ns.Version
    if not Version then return IMMUNITY_SPELL_IDS end

    local exclude
    if Version.IsTBC and Version:IsTBC() then
        exclude = IMMUNITY_EXCLUDED_TBC
    elseif Version.IsWrath and Version:IsWrath() then
        exclude = IMMUNITY_EXCLUDED_WRATH
    elseif Version.IsCata and Version:IsCata() then
        exclude = IMMUNITY_EXCLUDED_CATA
    elseif Version.IsMists and Version:IsMists() then
        exclude = IMMUNITY_EXCLUDED_MISTS
    else
        return IMMUNITY_SPELL_IDS
    end

    if not exclude then return IMMUNITY_SPELL_IDS end

    local result = {}
    for spellId in pairs(IMMUNITY_SPELL_IDS) do
        if not exclude[spellId] then
            result[spellId] = true
        end
    end
    return result
end

local ACTIVE_IMMUNITY_SPELL_IDS = BuildImmunitySpellIdsForVersion()

ns.PvPSpellData = ns.PvPSpellData or {}
ns.PvPSpellData.TRACKED_COOLDOWNS = ACTIVE_TRACKED_COOLDOWNS
ns.PvPSpellData.TRACKED_COOLDOWNS_FULL = TRACKED_COOLDOWNS
ns.PvPSpellData.IMMUNITY_SPELL_IDS = ACTIVE_IMMUNITY_SPELL_IDS
ns.PvPSpellData.COMBATLOG_OBJECT_REACTION_FRIENDLY = COMBATLOG_OBJECT_REACTION_FRIENDLY

--- Check if sourceFlags indicates enemy (not friendly)
--- @param sourceFlags number Combat log source flags
--- @return boolean
function ns.PvPSpellData.IsEnemySource(sourceFlags)
    if not sourceFlags then return true end
    local bitLib = _G.bit
    if not bitLib or not bitLib.band then return true end
    return bitLib.band(sourceFlags, COMBATLOG_OBJECT_REACTION_FRIENDLY) == 0
end

--- Get cooldown data for spell
--- @param spellId number
--- @return table|nil { duration, category }
function ns.PvPSpellData.GetCooldownData(spellId)
    return spellId and ACTIVE_TRACKED_COOLDOWNS[spellId]
end

--- Get all tracked interrupt spell IDs (for SafeToCast checks)
--- @return table Set of spell IDs (keys)
function ns.PvPSpellData.GetInterruptSpellIds()
    local ids = {}
    for spellId, data in pairs(ACTIVE_TRACKED_COOLDOWNS) do
        if data and data.category == "interrupt" then
            ids[spellId] = true
        end
    end
    return ids
end

--- Get all tracked defensive spell IDs (for HasDefensivesRemaining / GetVulnerableArenaUnit)
--- @return table Set of spell IDs (keys)
function ns.PvPSpellData.GetDefensiveSpellIds()
    local ids = {}
    for spellId, data in pairs(ACTIVE_TRACKED_COOLDOWNS) do
        if data and data.category == "defensive" then
            ids[spellId] = true
        end
    end
    return ids
end

--- PvP trinket spell IDs (Gladiator's Medallion etc.) for trinket-ready checks
ns.PvPSpellData.PVP_TRINKET_SPELL_IDS = { [42292] = true, [195710] = true, [208683] = true }

--- Get PvP trinket spell IDs for EnemyTrinketReady checks
--- @return table Set of spell IDs (keys)
function ns.PvPSpellData.GetPVPTrinketSpellIds()
    return ns.PvPSpellData.PVP_TRINKET_SPELL_IDS
end
