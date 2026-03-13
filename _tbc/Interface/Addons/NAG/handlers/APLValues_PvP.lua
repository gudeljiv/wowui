--- @module "APLValues_PvP"
--- PvP-related APL value functions for the NAG addon
---
--- Provides EnemyCooldownDown, TargetDRReady, IsInPvP, and related functions
--- for PvP-specific rotation conditions. Requires PvPTracker module.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local UnitExists = _G.UnitExists

-- ============================ PvP VALUE FUNCTIONS ============================

--- Returns true if the player is in a PvP instance (arena or battleground)
--- @return boolean
--- @usage if NAG:IsInPvP() and NAG:EnemyCooldownDown("arena1", 2139) then ...
function NAG:IsInPvP()
    return ns.IsInPvP and ns.IsInPvP() or false
end

--- Returns true if the player is in an arena
--- @return boolean
function NAG:IsInArena()
    return ns.IsInArena and ns.IsInArena() or false
end

--- Returns true if the specified arena unit exists
--- @param arenaIndex number 1-5 for arena1 through arena5
--- @return boolean
--- @usage NAG:ArenaUnitExists(1) -- true if arena1 exists
function NAG:ArenaUnitExists(arenaIndex)
    if not arenaIndex or arenaIndex < 1 or arenaIndex > 5 then
        return false
    end
    return UnitExists("arena" .. arenaIndex) or false
end

--- Returns true if the enemy's cooldown for the given spell is ready (or not tracked)
--- @param unit string Unit ID: "target", "focus", "arena1", "arena2", "arena3", etc.
--- @param spellId number Spell ID to check (e.g. 2139 for Counterspell)
--- @return boolean
--- @usage if NAG:EnemyCooldownDown("arena1", 2139) then NAG:Cast(Counterspell) end
function NAG:EnemyCooldownDown(unit, spellId)
    if not unit or not spellId then return true end
    local PvPTracker = NAG:GetModule("PvPTracker", true)
    if not PvPTracker or not PvPTracker:IsEnabled() then
        return true
    end
    return PvPTracker:IsEnemyCooldownDown(unit, spellId)
end

--- Returns remaining cooldown in seconds for enemy spell, or nil if ready/not tracked
--- @param unit string Unit ID
--- @param spellId number Spell ID
--- @return number|nil Seconds remaining
function NAG:EnemyCooldownRemaining(unit, spellId)
    if not unit or not spellId then return nil end
    local PvPTracker = NAG:GetModule("PvPTracker", true)
    if not PvPTracker or not PvPTracker:IsEnabled() then
        return nil
    end
    return PvPTracker:GetEnemyCooldownRemaining(unit, spellId)
end

--- Returns true if target's DR for the given category is ready (full effect)
--- @param category string DR category: "stun", "incapacitate", "fear", "root", "silence", etc.
--- @return boolean
--- @usage if NAG:TargetDRReady("stun") then NAG:Cast(HammerOfJustice) end
function NAG:TargetDRReady(category)
    if not category then return true end
    return NAG:UnitDRReady("target", category)
end

--- Returns true if focus's DR for the given category is ready
--- @param category string DR category
--- @return boolean
function NAG:FocusDRReady(category)
    if not category then return true end
    return NAG:UnitDRReady("focus", category)
end

--- Returns true if the unit's DR for the given category is ready
--- @param unit string Unit ID
--- @param category string DR category
--- @return boolean
function NAG:UnitDRReady(unit, category)
    if not unit or not category then return true end
    local PvPTracker = NAG:GetModule("PvPTracker", true)
    if not PvPTracker or not PvPTracker:IsEnabled() then
        return true
    end
    return PvPTracker:IsDRReady(unit, category)
end

--- Returns remaining DR reset time in seconds for unit/category, or nil if ready
--- @param unit string Unit ID
--- @param category string DR category
--- @return number|nil Seconds until DR resets
function NAG:UnitDRRemaining(unit, category)
    if not unit or not category then return nil end
    local PvPTracker = NAG:GetModule("PvPTracker", true)
    if not PvPTracker or not PvPTracker:IsEnabled() then
        return nil
    end
    return PvPTracker:GetDRRemaining(unit, category)
end

--- Returns current DR level (1, 2, or 3) for unit/category, or nil if ready
--- @param unit string Unit ID
--- @param category string DR category
--- @return number|nil 1=100%, 2=50%, 3=25%
function NAG:UnitDRLevel(unit, category)
    if not unit or not category then return nil end
    local PvPTracker = NAG:GetModule("PvPTracker", true)
    if not PvPTracker or not PvPTracker:IsEnabled() then
        return nil
    end
    return PvPTracker:GetDRLevel(unit, category)
end

--- Returns true if target has immunity buff (Ice Block, Divine Shield, etc.) - suppress offensive suggestions
--- @return boolean
--- @usage if not NAG:TargetImmune() then NAG:Cast(DamageSpell) end
function NAG:TargetImmune()
    return NAG:UnitImmune("target")
end

--- Returns true if the unit has immunity buff (Ice Block, Divine Shield, Hand of Protection, etc.)
--- @param unit string Unit ID: "target", "focus", "arena1", etc.
--- @return boolean
function NAG:UnitImmune(unit)
    if not unit then return false end
    local PvPTracker = NAG:GetModule("PvPTracker", true)
    if not PvPTracker or not PvPTracker:IsEnabled() then
        return false
    end
    return PvPTracker:IsEnemyImmune(unit)
end

--- Returns true if it is safe to hard cast (all known interrupts for target are on cooldown)
--- @return boolean
--- @usage if NAG:TargetSafeToCast() then NAG:Cast(Fireball) end
function NAG:TargetSafeToCast()
    return NAG:SafeToCast("target")
end

--- Returns true if it is safe to hard cast vs the unit (no enemy interrupt available)
--- @param unit string Unit ID: "target", "focus", "arena1", etc.
--- @return boolean
function NAG:SafeToCast(unit)
    if not unit then return true end
    local PvPTracker = NAG:GetModule("PvPTracker", true)
    if not PvPTracker or not PvPTracker:IsEnabled() then
        return true
    end
    return PvPTracker:IsSafeToCast(unit)
end

--- Returns the suggested kill target (arena unit with no defensives remaining)
--- @return string|nil Unit ID e.g. "arena2", or nil
function NAG:SuggestedKillTarget()
    local PvPTracker = NAG:GetModule("PvPTracker", true)
    if not PvPTracker or not PvPTracker:IsEnabled() then
        return nil
    end
    return PvPTracker:GetVulnerableArenaUnit()
end

--- Returns true if the unit has no defensives remaining
--- @param unit string Unit ID: "target", "focus", "arena1", etc.
--- @return boolean
function NAG:UnitOutOfDefensives(unit)
    if not unit then return false end
    local PvPTracker = NAG:GetModule("PvPTracker", true)
    if not PvPTracker or not PvPTracker:IsEnabled() then
        return false
    end
    return not PvPTracker:HasDefensivesRemaining(unit)
end

--- Returns true if the party healer has a CC debuff
--- @return boolean
function NAG:HealerInCC()
    local PvPTracker = NAG:GetModule("PvPTracker", true)
    if not PvPTracker or not PvPTracker:IsEnabled() then
        return false
    end
    return PvPTracker:IsHealerInCC()
end

--- Returns true if target's PvP trinket is ready
--- @return boolean
function NAG:TargetTrinketReady()
    return NAG:EnemyTrinketReady("target")
end

--- Returns true if the enemy has PvP trinket ready
--- @param unit string Unit ID: "target", "focus", "arena1", etc.
--- @return boolean
function NAG:EnemyTrinketReady(unit)
    if not unit then return true end
    local PvPTracker = NAG:GetModule("PvPTracker", true)
    if not PvPTracker or not PvPTracker:IsEnabled() then
        return true
    end
    return PvPTracker:EnemyTrinketReady(unit)
end

--- Returns true if the player's PvP trinket is ready
--- @return boolean
function NAG:PlayerTrinketReady()
    local PvPTracker = NAG:GetModule("PvPTracker", true)
    if not PvPTracker or not PvPTracker:IsEnabled() then
        return false
    end
    return PvPTracker:PlayerTrinketReady()
end

--- Returns true if the player has the given PvP talent selected
--- @param talentId number PvP talent spell ID
--- @return boolean
function NAG:HasPVPTalent(talentId)
    if not talentId then return false end
    local PvPTracker = NAG:GetModule("PvPTracker", true)
    if not PvPTracker or not PvPTracker:IsEnabled() then
        return false
    end
    return PvPTracker:HasPVPTalent(talentId)
end

--- Returns current arena dampening percentage, or nil if unavailable
--- @return number|nil
function NAG:DampeningPercent()
    local PvPTracker = NAG:GetModule("PvPTracker", true)
    if not PvPTracker or not PvPTracker:IsEnabled() then
        return nil
    end
    return PvPTracker:GetDampeningPercent()
end

--- Returns true when burst window is open for the unit
--- @param unit string Unit ID: "target", "arena1", etc.
--- @return boolean
function NAG:BurstWindowOpen(unit)
    if not unit then return false end
    local PvPTracker = NAG:GetModule("PvPTracker", true)
    if not PvPTracker or not PvPTracker:IsEnabled() then
        return false
    end
    return PvPTracker:IsBurstWindowOpen(unit)
end
