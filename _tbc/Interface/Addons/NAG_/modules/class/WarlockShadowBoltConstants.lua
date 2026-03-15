--- @module "NAG.WarlockShadowBoltConstants"
--- Shared Shadow Bolt spell ID catalogs for Warlock leaderboard tracking.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas

local _, ns = ...

local WarlockShadowBoltConstants = {
    -- Shadow Bolt spell IDs (all ranks) per expansion.
    -- TBC: 686, 695, 705, 1088, 1106, 7641, 11659-11661, 25307, 27209
    SHADOW_BOLT_IDS_TBC = {
        686,
        695,
        705,
        1088,
        1106,
        7641,
        11659,
        11660,
        11661,
        25307,
        27209,
    },
    -- Wrath adds: 47808, 47809. MoP uses same set (SHADOW_BOLT_SET_WRATH).
    SHADOW_BOLT_IDS_WRATH = {
        686,
        695,
        705,
        1088,
        1106,
        7641,
        11659,
        11660,
        11661,
        25307,
        27209,
        47808,
        47809,
    },
}

local function buildSet(ids)
    local set = {}
    for i = 1, #ids do
        set[ids[i]] = true
    end
    return set
end

WarlockShadowBoltConstants.SHADOW_BOLT_SET_TBC = buildSet(WarlockShadowBoltConstants.SHADOW_BOLT_IDS_TBC)
WarlockShadowBoltConstants.SHADOW_BOLT_SET_WRATH = buildSet(WarlockShadowBoltConstants.SHADOW_BOLT_IDS_WRATH)

ns.WarlockShadowBoltConstants = WarlockShadowBoltConstants
return WarlockShadowBoltConstants
