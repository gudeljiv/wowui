
local _, ns = ...
ns.data = ns.data or {}
ns.data.tbc = ns.data.tbc or {}
ns.data.tbc.Spells = ns.data.tbc.Spells or {}

ns.data.tbc.Spells.ExtraSpells = {
    Class = {
        DRUID = { -- Druid
            [33357] = { -- Dash
                -- Spell-level properties
                rolesMask = 14,
                categoryRecovery = 180000,
                duration = 15000,
                schoolMask = 1,
                attributes = "262160,32,0,0,0,0,0,0,0,0,8192,0,0,0,0,0",
                procTypeMask = "0,0",
                -- Effects subtable
                effects = {
                    [0] = { effect = 6,aura = 31,basePoints = 69,dieSides = 1,groupSizeBasePointsCoefficient = 1,targetA = 1,chainAmplitude = 1.0,pvpMultiplier = 1,},
                },
                -- Legacy compatibility fields (from primary effect)
                effect = 6,
                aura = 31,
                targetId = 1,
            },
        },
        SHAMAN = { -- Shaman
            [30823] = { -- Shamanistic Rage
                -- Spell-level properties
                rolesMask = 12,
                startRecovery = 1500,
                recoveryTime = 60000,
                duration = 15000,
                schoolMask = 1,
                attributes = "327696,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0",
                procChance = 100,
                procTypeMask = "20,0",
                -- Effects subtable
                effects = {
                    [0] = { effect = 6,aura = 42,basePoints = 14,dieSides = 1,triggerSpell = 30824,groupSizeBasePointsCoefficient = 1,targetA = 1,chainAmplitude = 1.0,pvpMultiplier = 1,},
                    [1] = { effect = 6,aura = 87,basePoints = -31,dieSides = 1,miscValue0 = 127,groupSizeBasePointsCoefficient = 1,targetA = 1,chainAmplitude = 1.0,pvpMultiplier = 1,},
                },
                -- Legacy compatibility fields (from primary effect)
                effect = 6,
                aura = 42,
                targetId = 1,
                auraId = 30824,
            },
        },
    }
}
