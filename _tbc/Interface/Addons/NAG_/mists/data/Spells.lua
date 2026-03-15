--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
    XXXhttps://creativecommons.org/licenses/by-nc/4.0/

    Author: Rakizi
    Date: 2024

    Mists of Pandaria spell data
]]

local _, ns = ...
ns.data = ns.data or {}
ns.data.mists = ns.data.mists or {}
ns.data.mists.Spells = ns.data.mists.Spells or {}

ns.data.mists.Spells.Common = {
    utility = { 61304 },                       -- gcd
    bloodlust = { 2825, 32182, 80353, 90355 }, -- bloodlust spells
    sated = { 57724, 57723, 80354, 95809 },    -- associated debuffs
    -- Expose Armor(Rogue), Sunder Armor(Warrior), Corrosive Spit(Hunter), Trauma, Hemorrhage(Rogue), Mangle(Feral), Blood Frenzy(Warrior), Stampede, Power Torrent(Weapon EnchantTODO), Quickflip Plates(Tinker?), Faerie Fire (Feral), tricks of the trade(rogue) Mind Quickening(Priest)
    other = { 74241, 82176, 49868, 96927, 96928, 96929, 66842, 79634 }, -- 8647, 35387, 16511, 33876, 57933, 57386 -Blessing of the shaper
    trainingDummy = { 61573, 61574 }
}

-- Class-specific spells
ns.data.mists.Spells.Class = {
    -- Warrior (Mists specific)
    WARRIOR = {
        --stance = { 2457, 71, 2458 },
    },

    -- Paladin (Mists specific)
    PALADIN = {
        stance = { 31801, 20154, 20165 }, -- Seals
    },

    -- Hunter (Mists specific)
    HUNTER = {
    --    stance = { 13165, 5118, 13159, 20043, 82661 },             -- Aspects
        pet = { 93435, 90364, 90363, 90355, 19615, 93433, 92380 }, -- Pet action
    },

    -- Rogue (Mists specific)
    ROGUE = {
        stance = { 1784 }, -- Stealth
        -- Combat:  Moderate Insight, Deep Insight | Subtelty:  Overload
        other = { 115192 },-- subterfuge
    },

    -- Priest (Mists specific)
    PRIEST = {
        stance = { 15473 }, -- Shadowform
        -- Shadow: Shadow Orb
    --    other = { 77487 },
    },

    -- Death Knight (Mists specific)
    DEATHKNIGHT = {
        --stance = { 48263, 48266, 48265 }, -- Presences
        --  Rune of the Fallen Crusader buff: Unholy Strength, Blood Shield, lifeblood
    --    other = { 53365, 98971, 77535, 74497 },
    },

    -- Shaman (Mists specific)
    SHAMAN = {
    },

    -- Mage (Mists specific)
    MAGE = {
    },

    -- Warlock (Mists specific)
    WARLOCK = {
        pet = {
            action = {
                imp = { 3110, 4511, 89766 },
                voidwalker = { 3716, 7812, 17767, 17735, 87939 },
                succubus = { 7814, 6358, 6360 },
                felhunter = { 54049, 19647, 19505, 87933, 87948 },
                felguard = { 30213, 30151, 30213, 89751, 89766 },
                infernal = { 19483 },
                doomguard = { 20812, 89766 }
            },
        },
    },

    -- Druid (Mists specific)
    DRUID = {
--        stance = { 5487, 768, 783, 1066, 33943, 24858, 33891, 40120 }, -- Forms
    },
}
