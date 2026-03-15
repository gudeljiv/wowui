--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
    XXXhttps://creativecommons.org/licenses/by-nc/4.0/

    Author: Rakizi
    Date: 2025

    Wrath of the Lich King (WotLK) spell data.
    Raid buff/debuff IDs aligned with extern/wowsims-wotlk (buffs_debuffs.ts) where applicable.
]]

local _, ns = ...
ns.data = ns.data or {}
ns.data.wrath = ns.data.wrath or {}
ns.data.wrath.Spells = ns.data.wrath.Spells or {}

ns.data.wrath.Spells.Common = {
    utility = { 61304 },                -- gcd
    bloodlust = { 2825, 32182 },        -- Bloodlust, Heroism
    sated = { 57724, 57723 },           -- Sated / Exhaustion after Bloodlust

    -- @raid_stats.tsx:raidBuffs (wowsims-wotlk buffs_debuffs.ts)
    BuffType = {
        ATTACK_POWER = { 19506, 30809, 53138, 47436, 12861, 48934, 20045 },
        HASTE = { 53648, 48396 },       -- Swift Retribution, Moonkin Aura
        MAJOR_MANA = {},
        ARMOR = { 465, 8071, 48942, 20140, 58753, 16293, 43468 },
        ATTACK_SPEED = { 55610, 65990, 29193, 53290 },
        CRIT = { 17007, 34300, 29801, 24907, 48396, 51470 },
        DAMAGE = { 31869, 31583, 34460 },
        HEROISM = { 2825, 32182 },
        MANA = { 43002, 57567, 54038 },
        MP5 = { 48938, 20245, 58774, 16206 },
        SPELL_HASTE = { 3738 },
        SPELL_POWER = { 47240, 57722, 58656, 48073 },
        SPELL_RESISTANCE = { 48170, 58749, 49071, 48945, 58745 },
        STAMINA = { 48161, 14767, 469, 37094 },
        STATS = { 48470, 17051, 49634, 49633, 25898, 25899 },
        STRENGTH_AGILITY = { 58643, 52456, 57623, 43464, 43466 },
    },

    -- @raid_stats.tsx:raidDebuffs (wowsims-wotlk buffs_debuffs.ts)
    DebuffType = {
        HEALING_REDUCTION = {},
        ARMOR = { 47467, 8647, 55754, 770, 33602, 50511, 18180, 56631, 53598 },
        ATTACK_SPEED = { 47502, 12666, 55095, 51456, 53696, 48485 },
        BLEED = { 48564, 46855, 57393 }, -- Mangle, Trauma (WotLK ID 46855), Stampede
        PHYSICAL_DAMAGE = { 29859, 58413 },
        PHYSICAL_DAMAGE_REDUCTION = { 26016, 47437, 12879, 48560, 16862, 55487 },
        SPELL_CRIT = { 30706, 20337, 58410, 17803, 12873, 28593 },
        SPELL_DAMAGE = { 51161, 48511, 47865 },
        SPELL_HIT = { 33198, 33602 },
    },

    -- @raid_stats.tsx:individualBuffs
    individualBuff = {
        10060, 29166, 33206, 47788, 54648, 57933, 49016
    },

    -- Expose Armor, Sunder Armor, Acid Spit, Trauma, Faerie Fire, Blood Frenzy, Mangle, Stampede, Tricks of the Trade, etc.
    other = {
        8647, 47467, 55754, 46857, 770, 33602, 29859, 48564, 57393, 57933, 53338, 53408, 20271
    },
    trainingDummy = { 61573, 61574 }
}
