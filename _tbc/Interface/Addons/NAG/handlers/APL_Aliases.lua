--- @module "APL_Aliases"
--- Centralized APL function aliases for the NAG addon
---
--- This module sets up all function aliases in one place to maintain consistency
--- and make it easy to see all available aliases. It should be loaded last to ensure
--- all original functions are defined before creating aliases.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ APL FUNCTION ALIASES ~~~~~~~~~~
-- These aliases provide alternative names for APL functions to maintain
-- compatibility with different naming conventions and improve readability.

-- AuraIsActive is the canonical public entry point; IsActive remains as a
-- compatibility alias that points to the same handler.
NAG.IsActive = NAG.AuraIsActive

-- ============================ CLASS-SPECIFIC ALIASES ============================
-- Class-specific function aliases
-- #DEPRECATED: Use CurrentGenericResource instead
NAG.CurrentEclipseEnergy = NAG.CurrentGenericResource

-- ============================ SPELL ALIASES ============================
-- Spell-related function aliases
NAG.SpellIsReady = NAG.IsReady
NAG.Channel = NAG.ChannelSpell
NAG.Cast = NAG.CastSpell

-- Backward-compatibility: *Resolved names (base handlers resolve at entry; same behavior as base)
NAG.AuraIsActiveResolved = NAG.AuraIsActive
NAG.AuraRemainingTimeResolved = NAG.AuraRemainingTime
NAG.DotIsActiveResolved = NAG.DotIsActive
NAG.DotNumStacksResolved = NAG.DotNumStacks
NAG.DotRemainingTimeResolved = NAG.DotRemainingTime
NAG.DotRemainingTimeNowResolved = NAG.DotRemainingTimeNow
NAG.SpellTimeToReadyResolved = NAG.SpellTimeToReady
NAG.SpellCanCastResolved = NAG.SpellCanCast
NAG.IsQueuedResolved = NAG.IsQueued

-- ============================ OPERATOR ALIASES ============================
-- Comparison operator aliases
NAG.Compare = NAG.Cmp

-- ============================ TANK-SPECIFIC ALIASES ============================
-- Tank specialization damage taken aliases
NAG.ProtectionPaladinDamageTakenLastGlobal = NAG.DamageTakenLastGlobal
NAG.ProtectionWarriorDamageTakenLastGlobal = NAG.DamageTakenLastGlobal
NAG.GuardianDruidDamageTakenLastGlobal = NAG.DamageTakenLastGlobal
NAG.BrewmasterMonkDamageTakenLastGlobal = NAG.DamageTakenLastGlobal
NAG.BloodDeathKnightDamageTakenLastGlobal = NAG.DamageTakenLastGlobal


-- ~~~~~~~~~~ ALIAS VALIDATION ~~~~~~~~~~
-- Optional: Add validation to ensure all aliases point to existing functions
-- This can be enabled during development to catch missing functions early
local function ValidateAliases()
    local aliases = {
        "AuraIsActive",
        "CurrentEclipsePhase", "CurrentEclipseEnergy",
        "SpellIsReady", "Channel",
        "DotDamageIncreasePercent", "Compare",
        "ProtectionPaladinDamageTakenLastGlobal", "ProtectionWarriorDamageTakenLastGlobal",
        "GuardianDruidDamageTakenLastGlobal", "BrewmasterMonkDamageTakenLastGlobal",
        "BloodDeathKnightDamageTakenLastGlobal",
        "AuraIsActiveResolved", "AuraRemainingTimeResolved", "DotIsActiveResolved",
        "DotNumStacksResolved", "DotRemainingTimeResolved", "DotRemainingTimeNowResolved",
        "SpellTimeToReadyResolved", "SpellCanCastResolved", "IsQueuedResolved"
        }

    for _, aliasName in ipairs(aliases) do
        if not NAG[aliasName] or type(NAG[aliasName]) ~= "function" then
            NAG:Error("APL_Aliases: Alias '%s' does not point to a valid function", aliasName)
        end
    end
end

-- Uncomment the line below to enable alias validation during development
-- ValidateAliases()
