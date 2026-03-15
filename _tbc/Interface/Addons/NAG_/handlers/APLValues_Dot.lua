--- @module "APLValues_Dot"
--- DoT (Damage over Time) related APL value functions for the NAG addon
---
--- This module provides utility functions for DoT management, timing, and damage calculations.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold
---
--- luacheck: ignore GetSpellInfo
---

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ HEADER LOCALS ============================
local UnitExists = _G.UnitExists
local UnitGUID = _G.UnitGUID
local UnitCanAttack = _G.UnitCanAttack
local GetTime = _G.GetTime

-- Lua APIs (WoW optimized where available)
local format = string.format
local min = math.min
local max = math.max

local wipe = wipe

local sort = table.sort
local concat = table.concat
local pairs = pairs
local type = type

-- ============================ MODULE CACHING (PERFORMANCE) ============================
-- Cache frequently accessed modules to avoid GetModule overhead in hot paths
local SpellTrackingManager = ns.SpellTrackingManager
local DataManager = ns.DataManager
local Snapshotter = ns.Snapshotter

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

-- Hardcoded fallback values for known DoT spells (moved outside function for performance)
local DEFAULT_TICK_TIMES = {
    [114923] = 1.0, -- Nether Tempest (Mage)
    [44457] = 3.0,  -- Living Bomb (Mage)
    [11366] = 3.0,  -- Pyroblast DoT (Mage)
    [12654] = 2.0,  -- Ignite (Mage)
    [34914] = 3.0,  -- Vampiric Touch (Priest)
    [589] = 3.0,    -- Shadow Word: Pain (Priest)
    [2944] = 1.0,   -- Devouring Plague (Priest)
    [348] = 3.0,    -- Immolate (Warlock)
    [172] = 2.0,    -- Corruption (Warlock)
    [603] = 15.0,   -- Curse of Doom (Warlock)
    [113656] = 1.0, -- Fists of Fury (Monk)
}

-- ============================ GLOBAL DOT FUNCTIONS (DEPRECATED) ============================
-- TODO: These functions are deprecated and should be replaced with proper target-specific versions
-- They are kept for backward compatibility with existing rotations

--TODO: Remove this after testing consolidated method works.  Need to update schemamodifications as well as APLParser
-- ============================ DOT IS ACTIVE ============================


--- Checks if a DoT (Damage over Time) spell is active on the target or specified unit.
--- Uses smart detection to automatically determine if the spell should check player-only or global scope.
--- For non-stacking debuffs (like Rend, Faerie Fire), checks if ANYONE has applied the debuff.
--- For regular DoTs, checks if the PLAYER has applied the debuff.
--- @param spellId number The spell ID to check for
--- @param targetUnit? string The unit to check (defaults to "target")
--- @return boolean True if the DoT is active, false otherwise
--- @usage NAG:DotIsActive(73643) -- Check if spell 73643 is active on target
--- @usage NAG:DotIsActive(73643, "focus") -- Check if spell 73643 is active on focus
function NAG:DotIsActive(spellId, targetUnit)
    if not spellId then return false end
    targetUnit = targetUnit or "target"
    -- Resolve to spellbook ID so we check the spell the player actually has
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then
            spellId = resolved
        end
    end
    -- Some spells have same-name variants from pets/guardians (e.g., Treant "Rake" 150017).
    -- For these, enforce exact spellID matching to avoid name-based collisions.
    local exactIdMatch = (spellId == 1822) -- Rake (Feral Druid)
    return NAG:UnitDebuff(targetUnit, spellId, nil, exactIdMatch) ~= false
end

--- Checks if a debuff is active on a unit, regardless of who applied it (global scope).
--- This is the "any applier" version (uses HARMFUL, not HARMFUL|PLAYER).
--- @param unit? string The unit to check (defaults to "target")
--- @param spellId number The spell ID to check for
--- @return boolean True if the debuff is active, false otherwise
--- @usage NAG:DotIsActiveGlobal("target", 33983) -- Mangle (Cat) debuff, any applier
--- @usage NAG:DotIsActiveGlobal("focus", 27011) -- Faerie Fire (Feral), any applier
function NAG:DotIsActiveGlobal(unit, spellId)
    -- Backward-compatible safety: allow calling as DotIsActiveGlobal(spellId)
    if spellId == nil and type(unit) == "number" then
        spellId = unit
        unit = "target"
    end

    if not spellId then return false end
    unit = unit or "target"
    if type(unit) ~= "string" then return false end
    -- Resolve to spellbook ID so we check the debuff the player actually has
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then
            spellId = resolved
        end
    end
    return NAG:UnitDebuffGlobal(unit, spellId) ~= false
end

-- Table for DotIsActiveOnAllTargets function
local activeTargets = {}
local activeTargetsCount = 0

--- Checks if a DoT (Damage over Time) spell is active on all targets.
--- @param spellId number The spell ID to check for
--- @return boolean True if the DoT is active on all targets, false otherwise
--- @usage NAG:DotIsActiveOnAllTargets(73643) -- Check if spell 73643 is active on all targets
function NAG:DotIsActiveOnAllTargets(spellId)
    if not spellId then return false end

    -- Get all target units in the encounter
    -- Reuse table to avoid allocation
    wipe(activeTargets)
    activeTargetsCount = 0

    for i = 1, 40 do -- Check up to 40 targets
        local unit = "nameplate" .. i
        if UnitExists(unit) and UnitCanAttack("player", unit) then
            activeTargetsCount = activeTargetsCount + 1
            activeTargets[activeTargetsCount] = unit
        end
    end

    -- Also check main target
    if UnitExists("target") and UnitCanAttack("player", "target") then
        activeTargetsCount = activeTargetsCount + 1
        activeTargets[activeTargetsCount] = "target"
    end

    -- Check if DoT is active on all targets
    for i = 1, activeTargetsCount do
        if not NAG:DotIsActive(spellId, activeTargets[i]) then
            return false
        end
    end

    return activeTargetsCount > 0 -- Return true only if we have targets and DoT is active on all
end

-- ============================ DOT REMAINING TIME ============================

--- Returns the remaining time of a DoT spell on the target or specified unit.
--- Uses smart detection to automatically determine if the spell should check player-only or global scope.
--- For non-stacking debuffs (like Rend, Faerie Fire), checks if ANYONE has applied the debuff.
--- For regular DoTs, checks if the PLAYER has applied the debuff.
--- @param spellId number The spell ID to check
--- @param targetUnit? string The unit to check (defaults to "target")
--- @return number The remaining time in seconds, or 0 if the DoT is not active
--- @usage NAG:DotRemainingTime(73643) -- Get remaining time for spell 73643 on target
--- @usage NAG:DotRemainingTime(73643, "focus") -- Get remaining time for spell 73643 on focus
function NAG:DotRemainingTime(spellId, targetUnit)
    if not spellId then return 0 end
    targetUnit = targetUnit or "target"
    -- Resolve to spellbook ID so we check the spell the player actually has
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then
            spellId = resolved
        end
    end
    -- See DotIsActive: avoid same-name pet/guardian collisions by forcing exact ID for specific spells.
    local exactIdMatch = (spellId == 1822) -- Rake (Feral Druid)
    local aura = NAG:UnitDebuff(targetUnit, spellId, nil, exactIdMatch)
    if aura then
        local expirationTime = aura.expirationTime
        if expirationTime and expirationTime > 0 then
            return expirationTime - NAG:NextTime()
        end
    end
    return 0
end

--- Returns the remaining time of a debuff on a unit, regardless of who applied it (global scope).
--- This is the "any applier" version of DotRemainingTime (uses UnitDebuffGlobal).
--- @param unit? string The unit to check (defaults to "target")
--- @param spellId number The spell ID to check
--- @return number The remaining time in seconds, or 0 if the debuff is not active
--- @usage NAG:DotRemainingTimeGlobal("target", 7386) -- Sunder Armor remaining on target, any applier
--- @usage NAG:DotRemainingTimeGlobal(7386) -- backward-compat: defaults unit to "target"
function NAG:DotRemainingTimeGlobal(unit, spellId)
    -- Backward-compatible: allow DotRemainingTimeGlobal(spellId) with unit defaulting to "target"
    if spellId == nil and type(unit) == "number" then
        spellId = unit
        unit = "target"
    end

    if not spellId then return 0 end
    unit = unit or "target"
    if type(unit) ~= "string" then return 0 end

    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then
            spellId = resolved
        end
    end

    local aura = NAG:UnitDebuffGlobal(unit, spellId)
    if aura then
        local expirationTime = aura.expirationTime
        if expirationTime and expirationTime > 0 then
            return expirationTime - NAG:NextTime()
        end
    end
    return 0
end

--- Returns the remaining time of a DoT spell using the current time (not NextTime).
--- Use this when you need to compare against a future cast finish time.
--- @param spellId number The spell ID to check
--- @param targetUnit? string The unit to check (defaults to "target")
--- @return number The remaining time in seconds, or 0 if the DoT is not active
--- @usage NAG:DotRemainingTimeNow(73643)
function NAG:DotRemainingTimeNow(spellId, targetUnit)
    if not spellId then return 0 end
    targetUnit = targetUnit or "target"
    -- Resolve to spellbook ID so we check the spell the player actually has
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then
            spellId = resolved
        end
    end
    -- See DotIsActive: avoid same-name pet/guardian collisions by forcing exact ID for specific spells.
    local exactIdMatch = (spellId == 1822) -- Rake (Feral Druid)
    local aura = NAG:UnitDebuff(targetUnit, spellId, nil, exactIdMatch)
    if aura then
        local expirationTime = aura.expirationTime
        if expirationTime and expirationTime > 0 then
            return expirationTime - GetTime()
        end
    end
    return 0
end

-- Table for DotLowestRemainingTime function
local remainingTimeTargets = {}
local remainingTimeTargetsCount = 0

--- Returns the lowest remaining time of a DoT spell across all targets.
--- @param spellId number The spell ID to check
--- @return number The lowest remaining time in seconds, or 0 if not active on any target
--- @usage NAG:DotLowestRemainingTime(73643) -- Get lowest remaining time for spell 73643 across all targets
function NAG:DotLowestRemainingTime(spellId)
    if not spellId then return 0 end

    local lowestTime = math.huge
    local hasActiveDot = false

    -- Get all target units in the encounter
    -- Reuse table to avoid allocation
    wipe(remainingTimeTargets)
    remainingTimeTargetsCount = 0

    for i = 1, 40 do -- Check up to 40 targets
        local unit = "nameplate" .. i
        if UnitExists(unit) and UnitCanAttack("player", unit) then
            remainingTimeTargetsCount = remainingTimeTargetsCount + 1
            remainingTimeTargets[remainingTimeTargetsCount] = unit
        end
    end

    -- Also check main target
    if UnitExists("target") and UnitCanAttack("player", "target") then
        remainingTimeTargetsCount = remainingTimeTargetsCount + 1
        remainingTimeTargets[remainingTimeTargetsCount] = "target"
    end

    -- Find the lowest remaining time
    for i = 1, remainingTimeTargetsCount do
        local remainingTime = NAG:DotRemainingTime(spellId, remainingTimeTargets[i])
        if remainingTime > 0 then
            hasActiveDot = true
            lowestTime = min(lowestTime, remainingTime)
        end
    end

    return hasActiveDot and lowestTime or 0
end

-- ============================ DOT TICK FREQUENCY ============================

--- Returns the tick frequency of a DoT spell on the target or specified unit.
--- @param spellId number The spell ID to check
--- @param targetUnit? string The unit to check (defaults to "target")
--- @return number The tick frequency in seconds, or 0 if not found
--- @usage NAG:DotTickFrequency(73643) -- Get tick frequency for spell 73643 on target
--- @usage NAG:DotTickFrequency(73643, "focus") -- Get tick frequency for spell 73643 on focus
function NAG:DotTickFrequency(spellId, targetUnit)
    if not spellId then return 0 end
    targetUnit = targetUnit or "target"
    -- Resolve to spellbook ID for correct tracking
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then
            spellId = resolved
        end
    end

    -- Get target GUID
    local targetGUID = UnitGUID(targetUnit)
    if not targetGUID then return 0 end

    -- Use SpellTrackingManager API which handles registration automatically
    local targetData = SpellTrackingManager:GetPeriodicEffectInfo(spellId, targetGUID)
    if targetData and targetData.tickTime then
        return targetData.tickTime
    end

    -- Fallback: use learned channel tick intervals if available
    if SpellTrackingManager.GetChannelTickInterval then
        local channelInterval = SpellTrackingManager:GetChannelTickInterval(spellId)
        if channelInterval and channelInterval > 0 then
            return channelInterval
        end
    end

    -- Fallback: try to get from spell data if available
    local entry = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
    if entry and entry.tickTime then
        return entry.tickTime
    end

    -- Hardcoded fallback values for known DoT spells (when no dynamic data is available yet)
    return DEFAULT_TICK_TIMES[spellId] or 2.0
end

--- Returns the time remaining until the next DoT tick occurs.
--- @param spellId number The spell ID to check
--- @param targetUnit? string The unit to check (defaults to "target")
--- @return number The time in seconds until the next tick, or 0 if unknown
function NAG:DotTimeToNextTick(spellId, targetUnit)
    if not spellId then return 0 end
    targetUnit = targetUnit or "target"
    -- Resolve to spellbook ID for correct tracking
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then
            spellId = resolved
        end
    end

    local targetGUID = UnitGUID(targetUnit)
    if not targetGUID then return 0 end

    local targetData = SpellTrackingManager:GetPeriodicEffectInfo(spellId, targetGUID)
    if not targetData then
        return 0
    end

    local tickTime = targetData.tickTime
    if not tickTime or tickTime <= 0 then
        return 0
    end

    local lastTick = targetData.lastTickTime
    if not lastTick or lastTick <= 0 then
        return tickTime
    end

    local elapsed = NAG:NextTime() - lastTick
    local remaining = tickTime - (elapsed % tickTime)
    return max(0, remaining)
end


-- ============================ DOT STACKS ============================

--- Returns the number of stacks for a DoT (Damage over Time) spell on the target.
--- Uses smart detection to automatically determine if the spell should check player-only or global scope.
--- For non-stacking debuffs (like Rend, Faerie Fire), checks if ANYONE has applied the debuff.
--- For regular DoTs, checks if the PLAYER has applied the debuff.
--- @param spellId number The spell ID to check
--- @return number The number of stacks, or 0 if not found
--- @usage NAG:DotNumStacks(73643) -- Get stack count for spell 73643 on target
function NAG:DotNumStacks(spellId)
    if not spellId then return 0 end
    -- Resolve to spellbook ID so we check the spell the player actually has
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then
            spellId = resolved
        end
    end

    -- Check if this spell has a custom damage handler (O(1) lookup)
    if NAG:HasCustomDamageHandler(spellId) then
        return NAG:GetCustomDamage(spellId, "target")
    end

    -- See DotIsActive: avoid same-name pet/guardian collisions by forcing exact ID for specific spells.
    local exactIdMatch = (spellId == 1822) -- Rake (Feral Druid)
    local aura = NAG:UnitDebuff("target", spellId, nil, exactIdMatch)
    return aura and aura.count or 0
end

--- Returns the number of stacks for a debuff on a unit, regardless of who applied it.
--- This is the "global" version of DotNumStacks (uses HARMFUL, not HARMFUL|PLAYER).
--- @param spellId number The spell ID to check
--- @param unit? string The unit to check (defaults to "target")
--- @return number The number of stacks, or 0 if not found
--- @usage NAG:DotNumStacksGlobal(7386) -- Sunder Armor stacks on target, any applier
--- @usage NAG:DotNumStacksGlobal(33745, "focus") -- Lacerate stacks on focus, any applier
function NAG:DotNumStacksGlobal(spellId, unit)
    if not spellId then return 0 end
    unit = unit or "target"
    -- Resolve to spellbook ID so we check the debuff the player actually has
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then
            spellId = resolved
        end
    end

    -- Keep custom damage handlers consistent with DotNumStacks behavior
    if NAG:HasCustomDamageHandler(spellId) then
        return NAG:GetCustomDamage(spellId, unit)
    end

    local aura = NAG:UnitDebuffGlobal(unit, spellId)
    return aura and aura.count or 0
end

-- ============================ DOT REFRESH LOGIC ============================
--TODO: Add integration into priority checks in EnhancedAuraHandlers
--- Checks if a DoT (Damage over Time) spell should be refreshed based on overlap time.
--- @param spellId number The spell ID to check
--- @param overlap number The overlap time in seconds before expiration
--- @return boolean True if the DoT should be refreshed, false otherwise
--- @usage NAG:DotShouldRefresh(73643, 5) -- Check if spell 73643 should be refreshed with 5s overlap
function NAG:DotShouldRefresh(spellId, overlap)
    if not spellId then return false end
    if NAG:DotRemainingTime(spellId) < overlap then
        return true
    end
    return false
end

-- ============================ SNAPSHOT FUNCTIONS ============================

--- Query and compare stat snapshots with current values
---
--- This function provides a flexible way to:
--- 1. Get snapshot values for DoT effects that are still active
--- 2. Get raw current stat values without comparison
---
--- For active DoTs, returns the snapshot value (the stat value when the DoT was applied):
--- - This represents the stat value at the time the DoT was cast
--- - Useful for determining the "snapshot" value that affects DoT damage
---
--- For expired DoTs, returns the current stat value.
---
--- @param ... any Variable number of arguments:
---   - number: spellID to check snapshot for
---   - string: stat name(s) to check. Valid stats: "str", "agi", "int", "crit", "haste", "mastery", "ap"
--- @return number The snapshot value or current value:
---   - With spellID (active DoT): snapshot_stat value
---   - With spellID (expired DoT): current_stat value
---   - Without spellID: sum of current stats
---
--- @usage
--- -- Get attack power snapshot for a DoT
--- local snapshotAP = NAG:Snapshot("ap", 55095)  -- Returns: AP value when Frost Fever was applied
---
--- -- Get current strength + agility (no comparison)
--- local total = NAG:Snapshot("str", "agi")  -- Returns: current_str + current_agi
---
--- -- Get multiple stats from snapshot
--- local snapshotStats = NAG:Snapshot(12345, "crit", "haste")  -- Returns: (snapshot_crit + snapshot_haste)
---
--- -- Arguments can be in any order
--- local snapshotStats = NAG:Snapshot("ap", 67890, "mastery")  -- Returns: (snapshot_ap + snapshot_mastery)
function NAG:Snapshot(...)
    return Snapshotter:Snapshot(...)
end

--- Calculate percentage difference between current stats and snapshot values
---
--- This function calculates the percentage change from snapshot to current values:
--- - Positive values indicate stat gains (e.g., 0.2 = 20% increase)
--- - Negative values indicate stat losses (e.g., -0.1 = 10% decrease)
--- - Zero indicates no change
---
--- @param spellID number The spell ID to compare snapshot against
--- @param ... string Variable number of stat names to compare ("str", "agi", "int", "crit", "haste", "mastery", "ap")
--- @return number The percentage difference: (current_total / snapshot_total) - 1
---   - Returns 0 if no snapshot exists or snapshot total is 0
---   - Returns 0 if no valid stats provided
---
--- @usage
--- -- Check AP percentage difference for a buff
--- local apPercent = NAG:SnapshotPercent(59879, "ap")  -- Returns: (current_ap / snapshot_ap) - 1
---
--- -- Check combined crit + haste percentage difference
--- local combinedPercent = NAG:SnapshotPercent(12345, "crit", "haste")  -- Returns: ((current_crit + current_haste) / (snapshot_crit + snapshot_haste)) - 1
---
--- -- Example usage in conditions:
--- -- if NAG:SnapshotPercent(59879, "ap") > 0.1 then  -- If AP increased by more than 10%
function NAG:SnapshotPercent(spellID, ...)
    return Snapshotter:SnapshotPercent(spellID, ...)
end

--- Calculate DoT damage increase percentage based on attack power changes
---
--- This is a specialized function for DoT (Damage over Time) effects that snapshot
--- attack power when applied. It calculates how much the DoT damage has increased
--- since the spell was cast based on current vs snapshot attack power.
---
--- @param spellID number The spell ID of the DoT to check
--- @param targetUnit? string Optional unit to inspect (defaults to "target")
--- @param useBaseValue? boolean When true, compares against the baseline value recorded at encounter start if available
--- @return number The attack power percentage difference: (current_ap / snapshot_ap) - 1
---   - Positive values indicate damage increase (e.g., 0.15 = 15% more damage)
---   - Negative values indicate damage decrease (e.g., -0.1 = 10% less damage)
---   - Returns 0 if no snapshot exists or snapshot AP is 0
---
--- @usage
--- -- Check how much a DoT's damage has increased since application
--- local damageIncrease = NAG:DotPercentIncrease(59879)
---
--- -- Example usage in conditions:
--- -- if NAG:DotPercentIncrease(rip_spellid) > 0.2 then  -- If damage increased by 20%+
--- --     -- Consider refreshing the DoT for higher damage
--- -- end
function NAG:DotPercentIncrease(spellID, targetUnit, useBaseValue)
    if not Snapshotter or not Snapshotter.DotPercentIncrease then
        return 0
    end
    return Snapshotter:DotPercentIncrease(spellID, targetUnit, useBaseValue)
end

--- Calculate the crit chance delta for a DoT relative to its snapshot.
--- @param spellID number The spell ID to inspect
--- @param targetUnit? string Optional unit to inspect (defaults to "target")
--- @param useBaseValue? boolean Optional baseline comparison flag
--- @return number The crit chance percentage delta (e.g., 0.1 = 10% increase)
function NAG:DotCritPercentIncrease(spellID, targetUnit, useBaseValue)
    if not Snapshotter or not Snapshotter.DotCritPercentIncrease then
        return 0
    end
    return Snapshotter:DotCritPercentIncrease(spellID, targetUnit, useBaseValue)
end

--- Calculate the tick-rate delta for a DoT relative to its snapshot.
--- @param spellID number The spell ID to inspect
--- @param targetUnit? string Optional unit to inspect (defaults to "target")
--- @param useBaseValue? boolean Optional baseline comparison flag
--- @return number The tick-rate percentage delta (e.g., 0.1 = 10% faster)
function NAG:DotTickRatePercentIncrease(spellID, targetUnit, useBaseValue)
    if not Snapshotter or not Snapshotter.DotTickRatePercentIncrease then
        return 0
    end
    return Snapshotter:DotTickRatePercentIncrease(spellID, targetUnit, useBaseValue)
end

--- Returns Feathers of Fury stacks captured at the last Blood Plague snapshot.
--- @param targetUnit? string Optional unit token (defaults to "target")
--- @return number Snapshot FoF stacks in range 0-10
function NAG:SnapStacksFoF(targetUnit)
    if not Snapshotter or not Snapshotter.GetSnapStacksFoF then
        return 0
    end
    return Snapshotter:GetSnapStacksFoF(targetUnit or "target")
end

--- TODO: This appears not working currently, most like needs data updates to work properly.
--- Retrieves the base duration (unmodified) of a DoT.
--- @param spellId number The spell ID to check
--- @return number The base duration in seconds, or 0 if unavailable
function NAG:DotBaseDuration(spellId)
    if not spellId then return 0 end

    -- DataManager already cached at top of file
    if DataManager then
        local entry = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
        if entry then
            if entry.duration and entry.duration > 0 then
                return entry.duration / 1000
            end
            if entry.effects then
                for _, effect in pairs(entry.effects) do
                    if effect.duration and effect.duration > 0 then
                        return effect.duration / 1000
                    end
                end
            end
        end
    end

    return 0
end
