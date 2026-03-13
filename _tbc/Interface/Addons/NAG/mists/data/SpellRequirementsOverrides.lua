--- @module "SpellRequirementsOverrides"
--- Special spell requirements overrides for cases not available in DB2 data
---
--- This file contains special requirements for spells where the game logic
--- has OR conditions or other complex requirements that aren't directly
--- represented in the DB2 data.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi, @Fonsas
--- Discord: https://discord.gg/ebonhold

local _, ns = ...

-- Create universal overrides namespace for current expansion
-- This will be accessible via ns.overrides.SpellRequirementsOverrides after DataLoader processing
ns.mists = ns.mists or {}
ns.mists.overrides = ns.mists.overrides or {}

-- Special spell requirements overrides
-- These override or supplement the generated SpellRequirements data
-- Any expansion can provide their own SpellRequirementsOverrides table
-- After DataLoader processing, this becomes ns.overrides.SpellRequirementsOverrides
ns.mists.overrides.SpellRequirementsOverrides = {
    -- Hammer of Wrath (24275) - can be cast when target health below 20% OR Avenging Wrath is active
    [24275] = {
        -- Add the missing Avenging Wrath requirement
        requiredCasterAura = 31884,
        -- Mark this as having an OR condition
        hasOrCondition = true,
        -- Description of the OR condition
        orConditionDescription = "Target health below 20% OR Avenging Wrath active"
    },

    -- Add other special cases here as needed
    -- [spellId] = {
    --     requiredCasterAura = auraId,
    --     hasOrCondition = true,
    --     orConditionDescription = "Description of OR condition"
    -- },
}

-- Helper function to check if a spell has special overrides
function ns.mists.overrides.SpellRequirementsOverrides:HasOverride(spellId)
    return self[spellId] ~= nil
end

-- Helper function to get overrides for a spell
function ns.mists.overrides.SpellRequirementsOverrides:GetOverride(spellId)
    return self[spellId]
end

-- Helper function to merge overrides with base requirements
function ns.mists.overrides.SpellRequirementsOverrides:MergeWithBase(spellId, baseRequirements)
    local override = self[spellId]
    if not override then
        return baseRequirements
    end

    -- Create a merged copy
    local merged = {}
    if baseRequirements then
        for key, value in pairs(baseRequirements) do
            merged[key] = value
        end
    end

    -- Apply overrides
    for key, value in pairs(override) do
        if key ~= "hasOrCondition" and key ~= "orConditionDescription" then
            merged[key] = value
        end
    end

    -- Add special flags
    if override.hasOrCondition then
        merged.hasOrCondition = true
        merged.orConditionDescription = override.orConditionDescription
    end

    return merged
end
