--- @module "NAG.PaladinTwistConstants"
--- Shared spell ID catalogs for paladin twist runtime and leaderboard tracking.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas

local _, ns = ...

local PaladinTwistConstants = {
    -- Seal of Command cast IDs.
    RET_TWIST_SOC_IDS = {
        20375,
        20915,
        20918,
        20919,
        20920,
        27170,
    },

    -- Seal of Blood / Seal of the Martyr cast IDs.
    RET_TWIST_SOB_IDS = {
        31892,
        31893,
        348700,
        348701,
    },

    -- Seal of Righteousness IDs accepted as twist seal replacements.
    RET_TWIST_SOR_IDS = {
        20154,
        21084,
        20293,
    },

    -- Seal of Command proc spell ID.
    SOC_PROC_ID = 20424,

    -- SPELL_DAMAGE IDs accepted as twist proc contribution.
    TWIST_PROC_IDS = {
        31893,
        31898,
        348701,
        20186,
        20187,
        20279,
        20280,
        20281,
        20282,
        20283,
        20284,
        20285,
        25713,
        25735,
        25736,
        25737,
        25738,
        25739,
        25740,
        25741,
        25742,
        27155,
        27156,
        27157,
    },
}

local function buildSet(ids)
    local set = {}
    for i = 1, #ids do
        set[ids[i]] = true
    end
    return set
end

PaladinTwistConstants.SOC_CAST_IDS = buildSet(PaladinTwistConstants.RET_TWIST_SOC_IDS)
PaladinTwistConstants.TWIST_CAST_IDS = buildSet(PaladinTwistConstants.RET_TWIST_SOB_IDS)
for i = 1, #PaladinTwistConstants.RET_TWIST_SOR_IDS do
    PaladinTwistConstants.TWIST_CAST_IDS[PaladinTwistConstants.RET_TWIST_SOR_IDS[i]] = true
end

PaladinTwistConstants.TWIST_PROC_SET = buildSet(PaladinTwistConstants.TWIST_PROC_IDS)

ns.PaladinTwistConstants = PaladinTwistConstants
return PaladinTwistConstants
