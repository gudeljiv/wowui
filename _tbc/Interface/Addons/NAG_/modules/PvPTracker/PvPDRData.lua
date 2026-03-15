--- @module "NAG.PvPTracker.PvPDRData"
--- Diminishing returns spell-to-category mapping for PvP.
---
--- DR categories follow WoW standard. Reset window typically 15-18 seconds.
--- Expansion-specific overrides in Phase 7.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

local _, ns = ...

-- DR reset window (seconds) - standard PvP
local DR_RESET_SECONDS = 18

-- [spellId] = "category"
local SPELL_TO_DR_CATEGORY = {
    -- Stun
    [5211] = "stun",       -- Bash (Druid)
    [24394] = "stun",      -- Intimidation (Hunter)
    [853] = "stun",        -- Hammer of Justice (Paladin)
    [408] = "stun",        -- Kidney Shot (Rogue)
    [1833] = "stun",       -- Cheap Shot (Rogue)
    [30283] = "stun",      -- Shadowfury (Warlock)
    [20549] = "stun",      -- War Stomp (Tauren)
    [255723] = "stun",     -- Bull Rush (Highmountain)
    [119381] = "stun",     -- Leg Sweep (Monk)
    [89766] = "stun",      -- Axe Toss (Warlock Felguard)
    [91800] = "stun",      -- Gnaw (DK Ghoul)
    [91797] = "stun",      -- Monstrous Blow (DK Ghoul)
    [22570] = "stun",      -- Maim (Druid)
    [118345] = "stun",     -- Pulverize (Monk)
    [132168] = "stun",     -- Shockwave (Warrior)
    [132169] = "stun",     -- Storm Bolt (Warrior)
    [199804] = "stun",     -- Between the Eyes (Rogue)
    [179057] = "stun",     -- Chaos Nova (DH)
    [211881] = "stun",     -- Fel Eruption (DH)
    [108194] = "stun",     -- Asphyxiate (DK)
    [47481] = "stun",      -- Gnaw (DK Ghoul - different ID)

    -- Incapacitate
    [118] = "incapacitate",   -- Polymorph (Mage)
    [61305] = "incapacitate", -- Polymorph: Black Cat
    [28272] = "incapacitate", -- Polymorph: Pig
    [61721] = "incapacitate", -- Polymorph: Rabbit
    [61780] = "incapacitate", -- Polymorph: Turkey
    [126819] = "incapacitate",-- Polymorph: Porcupine
    [161353] = "incapacitate",-- Polymorph: Polar Bear
    [161354] = "incapacitate",-- Polymorph: Monkey
    [161355] = "incapacitate",-- Polymorph: Penguin
    [161372] = "incapacitate",-- Polymorph: Peacock
    [277787] = "incapacitate",-- Polymorph: Direhorn
    [277792] = "incapacitate",-- Polymorph: Bumblebee
    [20066] = "incapacitate", -- Repentance (Paladin)
    [1776] = "incapacitate",  -- Gouge (Rogue)
    [6770] = "incapacitate",  -- Sap (Rogue)
    [51514] = "incapacitate", -- Hex (Shaman)
    [3355] = "incapacitate",  -- Freezing Trap
    [203337] = "incapacitate",-- Freezing Trap (Survival)
    [115078] = "incapacitate",-- Paralysis (Monk)
    [221527] = "incapacitate",-- Imprison (DH - baseline)
    [217832] = "incapacitate",-- Imprison (DH)
    [2637] = "incapacitate",  -- Hibernate (Druid)
    [99] = "incapacitate",   -- Incapacitating Roar (Druid)
    [2637] = "incapacitate",  -- Hibernate
    [38385] = "incapacitate", -- Frost Trap (legacy)
    [197214] = "incapacitate",-- Sundering (Shaman)
    [207167] = "incapacitate",-- Blinding Sleet (DK)
    [2094] = "incapacitate",  -- Blind (Rogue)

    -- Fear
    [5782] = "fear",       -- Fear (Warlock)
    [118699] = "fear",     -- Fear (Warlock)
    [8122] = "fear",       -- Psychic Scream (Priest)
    [5246] = "fear",       -- Intimidating Shout (Warrior)
    [20511] = "fear",      -- Intimidating Shout (Warrior)
    [10326] = "fear",      -- Turn Evil (Paladin)
    [115268] = "fear",     -- Mesmerize (Warlock Shivarra)
    [6358] = "fear",       -- Seduction (Warlock Succubus)
    [87194] = "fear",      -- Mortal Coil (Warlock)
    [226943] = "fear",     -- Mind Bomb (Priest)

    -- Disorient
    [2094] = "disorient",  -- Blind (Rogue) - shares with incapacitate in some systems
    [31661] = "disorient",  -- Dragon's Breath (Mage)
    [105421] = "disorient", -- Blinding Light (Paladin)
    [198909] = "disorient", -- Song of Chi-Ji (Monk)
    [207685] = "disorient", -- Sigil of Misery (DH)

    -- Root
    [339] = "root",        -- Entangling Roots (Druid)
    [102359] = "root",     -- Mass Entanglement (Druid)
    [122] = "root",        -- Frost Nova (Mage)
    [33395] = "root",      -- Freeze (Mage Water Ele)
    [136634] = "root",     -- Narrow Escape (Hunter)
    [201158] = "root",     -- Super Sticky Tar (Hunter)
    [117526] = "root",     -- Binding Shot (Hunter)
    [170855] = "root",     -- Shot (Hunter trap)
    [64803] = "root",      -- Entrapment (Shaman)
    [64695] = "root",      -- Earthgrab (Shaman)
    [19975] = "root",      -- Nature's Grasp (Druid)
    [204085] = "root",     -- Death Grip (DK - Root effect)
    [212638] = "root",     -- Trapped (DH)
    [233395] = "root",     -- Frostbite (Mage)
    [162480] = "root",     -- Steel Trap (Hunter)
    [200108] = "root",     -- Ranger's Net (Hunter)
    [229159] = "root",     -- Explosive Trap (Hunter)
    [121411] = "root",     -- Crimson Tempest (Rogue - root component)
    [107566] = "root",     -- Staggering Shout (Warrior)

    -- Silence
    [15487] = "silence",   -- Silence (Priest)
    [24259] = "silence",   -- Spell Lock (Warlock Felhunter)
    [31935] = "silence",   -- Avenger's Shield (Paladin - silence)
    [102051] = "silence",  -- Frost Jaw (Druid)
    [1330] = "silence",    -- Garrote (Rogue)
    [47476] = "silence",   -- Strangulate (DK)
    [19647] = "silence",   -- Spell Lock (Felhunter)
    [212619] = "silence",  -- Call Felhunter

    -- Knockback
    [108199] = "knockback", -- Gorefiend's Grasp (DK)
    [51514] = "knockback",  -- Hex has knockback in some contexts
    [6360] = "knockback",   -- Whirlwind (Warrior)
}

-- Normalize duplicate keys (Lua overwrites)
SPELL_TO_DR_CATEGORY[2094] = "incapacitate" -- Blind - incapacitate takes precedence

-- ============================ EXPANSION-SPECIFIC FILTERING ============================
-- DR spell IDs that do not exist in each expansion (DK Wrath+, Monk MoP+, DH Legion+)

local DR_SPELLS_EXCLUDED_FROM_TBC = {
    [255723] = true, [119381] = true, [89766] = true, [91800] = true, [91797] = true,
    [22570] = true, [118345] = true, [132168] = true, [132169] = true, [199804] = true,
    [179057] = true, [211881] = true, [108194] = true, [47481] = true,
    [203337] = true, [115078] = true, [221527] = true, [217832] = true, [197214] = true,
    [207167] = true, [87194] = true, [226943] = true, [105421] = true, [198909] = true,
    [207685] = true, [102359] = true, [136634] = true, [201158] = true, [117526] = true,
    [170855] = true, [64803] = true, [204085] = true, [212638] = true, [233395] = true,
    [162480] = true, [200108] = true, [229159] = true, [121411] = true, [107566] = true,
    [102051] = true, [47476] = true, [212619] = true, [108199] = true,
}

local DR_SPELLS_EXCLUDED_FROM_WRATH = {
    [255723] = true, [119381] = true, [118345] = true, [115078] = true, [203337] = true,
    [221527] = true, [217832] = true, [197214] = true, [198909] = true, [207685] = true,
    [102359] = true, [136634] = true, [201158] = true, [117526] = true, [170855] = true,
    [212638] = true, [233395] = true, [162480] = true, [200108] = true, [229159] = true,
    [121411] = true, [107566] = true, [102051] = true, [212619] = true,
}

local DR_SPELLS_EXCLUDED_FROM_CATA = {
    [255723] = true, [221527] = true, [217832] = true, [207685] = true, [212638] = true,
}

local DR_SPELLS_EXCLUDED_FROM_MISTS = {
    [255723] = true, [212638] = true,
}

local function BuildDRCategoryForVersion()
    local Version = ns.Version
    if not Version then return SPELL_TO_DR_CATEGORY end

    local exclude
    if Version.IsTBC and Version:IsTBC() then
        exclude = DR_SPELLS_EXCLUDED_FROM_TBC
    elseif Version.IsWrath and Version:IsWrath() then
        exclude = DR_SPELLS_EXCLUDED_FROM_WRATH
    elseif Version.IsCata and Version:IsCata() then
        exclude = DR_SPELLS_EXCLUDED_FROM_CATA
    elseif Version.IsMists and Version:IsMists() then
        exclude = DR_SPELLS_EXCLUDED_FROM_MISTS
    else
        return SPELL_TO_DR_CATEGORY
    end

    if not exclude then return SPELL_TO_DR_CATEGORY end

    local result = {}
    for spellId, category in pairs(SPELL_TO_DR_CATEGORY) do
        if not exclude[spellId] then
            result[spellId] = category
        end
    end
    return result
end

local ACTIVE_SPELL_TO_DR_CATEGORY = BuildDRCategoryForVersion()

-- ============================ EXPORTS ============================

ns.PvPDRData = ns.PvPDRData or {}
ns.PvPDRData.SPELL_TO_DR_CATEGORY = ACTIVE_SPELL_TO_DR_CATEGORY
ns.PvPDRData.SPELL_TO_DR_CATEGORY_FULL = SPELL_TO_DR_CATEGORY
ns.PvPDRData.DR_RESET_SECONDS = DR_RESET_SECONDS

--- Get DR category for spell
--- @param spellId number
--- @return string|nil category name
function ns.PvPDRData.GetCategory(spellId)
    return spellId and ACTIVE_SPELL_TO_DR_CATEGORY[spellId]
end
