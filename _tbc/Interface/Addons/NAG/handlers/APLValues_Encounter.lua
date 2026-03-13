--- @module "APLValues_Encounter"
--- Encounter-related APL value functions for the NAG addon
---
--- This module provides utility functions for encounter detection, mechanics, and encounter-specific conditions.
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

-- Libraries
local RC = ns.RC

-- Lua APIs (WoW optimized where available)
local GetTime = _G.GetTime
local UnitExists = _G.UnitExists
local UnitGUID = _G.UnitGUID
local UnitHealth = _G.UnitHealth
local UnitHealthMax = _G.UnitHealthMax
local UnitCanAttack = _G.UnitCanAttack
local InCombatLockdown = _G.InCombatLockdown
local UnitAffectingCombat = _G.UnitAffectingCombat
local IsInRaid = _G.IsInRaid
local IsEncounterInProgress = _G.IsEncounterInProgress


local format = string.format
local min = math.min
local max = math.max

local wipe = wipe

-- ============================ MODULE CACHING (PERFORMANCE) ============================
-- Cache frequently accessed modules to avoid GetModule overhead in hot paths
local StateManager = ns.StateManager
local PullTimerManager = ns.PullTimerManager
local TTDManager = ns.TTDManager


-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

-- ============================ ENCOUNTER TIMING FUNCTIONS ============================

--- Get the current combat time in seconds since combat started, or 0 if not in combat.
--- @param self NAG The NAG addon instance
--- @return number The current combat time in seconds.
--- @usage NAG:CurrentTime() >= 10
function NAG:CurrentTime()
    -- If NAG is not fully initialized, return 0
    if not self or not self.GetModule then
        return 0
    end

    -- If not in combat, return 0
    if not UnitAffectingCombat("player") then
        return 0
    end

    -- Ensure StateManager is enabled
    if not StateManager.IsEnabled or not StateManager:IsEnabled() then
        return 0
    end

    -- Ensure state exists and is properly initialized
    if not StateManager.state or
        not StateManager.state.combat or
        not StateManager.state.combat.startTime then
        return 0
    end

    -- Calculate time since combat started
    local currentTime = GetTime()
    return max(0, currentTime - StateManager.state.combat.startTime)
end

--- Check if a unit is currently in combat
--- @param unit? string The unit to check (defaults to "player")
--- @return boolean True if the unit is in combat, false otherwise
--- @usage NAG:InCombat()
--- @usage NAG:InCombat("target")
function NAG:InCombat(unit)
    -- Default to player if no unit is given
    unit = unit or "player"

    -- UnitAffectingCombat works for players and most units
    if UnitAffectingCombat(unit) then
        return true
    end

    -- Fallback for secure/combat lockdown checks (UI-level combat)
    -- Only check this for "player" since InCombatLockdown is player-specific
    if unit == "player" and InCombatLockdown then
        if InCombatLockdown() then
            return true
        end
    end

    return false
end

--- Check if a pre-pull timer is currently active
--- @return boolean True if a pre-pull timer is active
--- @usage NAG:PrepullActive()
function NAG:PrepullActive()
    return PullTimerManager:IsPullTimer() or false
end

--- Get the number of seconds until pull (negative means pull has happened)
--- @return number Seconds until pull, or 0 if no active pull timer
--- @usage NAG:PrepullSecondsRemaining() > 5
function NAG:PrepullSecondsRemaining()
    local timeToZero = PullTimerManager:GetTimeToZero()
    return timeToZero or 0
end

--- Get the time spent on the current target in seconds, or 0 if not in combat or no target.
--- @param self NAG The NAG addon instance
--- @return number The time spent on the current target in seconds.
--- @usage NAG:TimeOnTarget() >= 10
function NAG:TimeOnTarget()
    -- If not in combat or no target, return 0
    if not UnitAffectingCombat("player") or not UnitExists("target") then
        return 0
    end

    local targetStartTime = StateManager.state.target.startTime
    -- If no start time recorded for this target, return 0
    if not targetStartTime then
        return 0
    end

    -- Calculate time spent on current target
    return max(0, GetTime() - targetStartTime)
end

--- Get the current time as a percentage of the total time (elapsed/total).
--- @param self NAG The NAG addon instance
--- @return number The current time percentage (0-100).
--- @usage NAG:CurrentTimePercent() >= 50
function NAG:CurrentTimePercent()
    -- Get current time remaining
    local remainingTime = self:RemainingTime()
    if remainingTime >= 7777 then
        return 0 -- Return 0% if we don't have valid TTD
    end

    local elapsedTimeSec = self:TimeOnTarget()       -- Calculate how much time has passed on this target
    local totalTime = elapsedTimeSec + remainingTime -- Calculate the total time duration for this target

    -- Avoid division by zero
    if totalTime <= 0 then
        return 0
    end

    local currentPercent = (elapsedTimeSec / totalTime) * 100 -- Calculate the elapsed time as a percentage
    -- Ensure the percentage is within valid range (0-100)
    return max(0, min(100, currentPercent))
end

--- Get the remaining time (TTD or encounter timer) in seconds for the current target or encounter.
--- @param self NAG The NAG addon instance
--- @return number The remaining time.
--- @usage NAG:RemainingTime()
function NAG:RemainingTime()

    -- 1) Encounter timer / training dummy stopwatch has priority
    if NAG.db.global.enableEncounterTimer then
        if StateManager.state and StateManager.state.combat and StateManager.state.combat.currentTimeRemaining then
            return StateManager.state.combat.currentTimeRemaining
        end
    end

    -- 2) Require a valid target
    local guid = UnitGUID("target")
    if not guid then
        return 8888
    end

    -- 3) Fresh/invalid targets report "unknown"
    local hp  = UnitHealth("target") or 0
    local maxHealth = UnitHealthMax("target") or 1
    if maxHealth <= 0 or hp <= 0 then
        return 8888
    end
    if hp >= maxHealth then
        -- Fresh 100% target -> unknown (no leakage from previous target)
        return 8888
    end

    -- 4) Ask TTDManager for a live value (no extra throttling here)
    local ttd = TTDManager:GetTTD(guid, 3)

    -- 5) Record same-target snapshot for brief anti-flicker (same target only)
    if StateManager.state and StateManager.state.target then
        StateManager.state.target.guid   = guid
        StateManager.state.target.ttd    = ttd
        StateManager.state.target.ttd_ts = GetTime()
        StateManager.state.target.ttd_guid = guid
    end

    -- 6) Return live value if valid
    if ttd and ttd > 0 and ttd < 7777 then
        return ttd
    end

    -- 7) Same-target short TTL fallback (never across targets)
    if StateManager.state and StateManager.state.target and StateManager.state.target.guid == guid and StateManager.state.target.ttd_guid == guid then
        local ttl  = (TTDManager.state and TTDManager.state.userInterval or 0.75) * 2
        local last = StateManager.state.target.ttd
        local ts   = StateManager.state.target.ttd_ts
        if last and last > 0 and last < 7777 and ts and (GetTime() - ts) < ttl then
            return last
        end
    end

    return 8888
end

--- Get the remaining time as a percentage of the total time (remaining/total).
--- @param self NAG The NAG addon instance
--- @return number The remaining time percentage (0-100).
--- @usage NAG:RemainingTimePercent()
function NAG:RemainingTimePercent()
    -- Get current time remaining
    local remainingTime = self:RemainingTime()
    if remainingTime >= 7777 then
        return 100 -- Return 100% if we don't have valid TTD
    end

    local elapsedTimeSec = self:CurrentTime()        -- Calculate how much time has passed since the fight started
    local totalTime = elapsedTimeSec + remainingTime -- Calculate the total time duration of the fight

    -- Avoid division by zero
    if totalTime <= 0 then
        return 100
    end

    local remainingPercent = (remainingTime / totalTime) * 100 -- Calculate the remaining time as a percentage
    -- Ensure the percentage is within valid range (0-100)
    return max(0, min(100, remainingPercent))
end

-- ============================ ENCOUNTER TARGET FUNCTIONS ============================

--- Get the number of valid targets within range for AoE abilities.
--- Uses spec-appropriate ranges for melee vs ranged classes.
---
--- Behavior:
--- - If range is provided: Uses the specified range for target counting regardless of class type
--- - If range is nil: Uses spec-appropriate ranges (melee for melee classes, ranged for ranged classes)
---
--- Spec-specific ranges are automatically applied when no range parameter is provided:
--- - Enhancement Shaman: 10-yard melee range for abilities like Unleash Elements
--- - Retribution Paladin: 10-yard melee range for abilities like Hammer of Wrath
--- - Ranged specs: 40-yard ranged range for spell casting
--- - Other melee specs: 5-8 yard melee ranges based on class abilities
---
--- @function NAG:NumberTargets
--- @param range number|nil Optional range to use for counting targets (overrides spec-appropriate ranges)
--- @param useMeleeFallback boolean|nil Optional: Whether melee classes should fallback to ranged range when no enemies found in melee range. Default: true
--- @usage NAG:NumberTargets() -- Uses spec-appropriate ranges (e.g., 10 yards for Enhancement Shaman)
--- @usage NAG:NumberTargets(10) -- Uses 10 yards for target counting (class logic determines melee vs ranged behavior)
--- @usage NAG:NumberTargets(10, false) -- Uses 10 yards without melee fallback for explicit range checking
--- @return number The number of valid targets within range. Returns 0 if no targets found.
---
--- **Important Usage Notes:**
--- - **No parameter**: Uses spec-appropriate ranges (melee=5-10 yards, ranged=30-40 yards based on class/spec)
--- - **With range parameter**: Uses the specified range for target counting regardless of class type
--- - **With useMeleeFallback parameter**: Controls whether melee classes fallback to ranged range when no enemies in melee range
--- - **Class behavior**: Melee classes check melee range first, fallback to ranged if no targets found (unless disabled)
--- - **Ranged classes**: Always use the specified range (no fallback logic)
--- - **WoWSims compatible**: Matches WoWSims NumberTargets() behavior exactly when useMeleeFallback is true (default)
function NAG:NumberTargets(range, useMeleeFallback)
    -- Per-tick cache during rotation execution to avoid redundant TTDManager work (e.g. Frost APL calls NumberTargets many times per tick)
    if NAG._rotationExecuting and NAG._numberTargetsCache then
        local cacheKey = (range == nil and "n" or tostring(range)) .. ":" .. (useMeleeFallback == nil and "d" or useMeleeFallback and "t" or "f")
        local cached = NAG._numberTargetsCache[cacheKey]
        if cached ~= nil then
            return cached
        end
    end

    local result
    if range then
        -- Use GetTargetCount for explicit range so we keep TTDManager's cache (avoids full scan every tick)
        result = TTDManager:GetTargetCount(range, range, useMeleeFallback) or 0
    else
        result = TTDManager:GetTargetCount(nil, nil, useMeleeFallback) or 0
    end

    if NAG._rotationExecuting and NAG._numberTargetsCache then
        local cacheKey = (range == nil and "n" or tostring(range)) .. ":" .. (useMeleeFallback == nil and "d" or useMeleeFallback and "t" or "f")
        NAG._numberTargetsCache[cacheKey] = result
    end

    return result
end

--- Returns true if the player's current target is within a specified melee range.
--- Uses LibRangeCheck-3.0 via the shared `ns.RC` handle (same dependency used by NumberTargets logic).
--- @param maxRange number|nil Max range in yards (default: 5)
--- @return boolean
function NAG:TargetInMeleeRange(maxRange)
    maxRange = maxRange or 5
    if not UnitExists("target") or not UnitCanAttack("player", "target") then
        return false
    end
    if not RC or not RC.GetRange then
        return false
    end

    local minRange, maxDist = RC:GetRange("target", true)
    local distance = minRange or maxDist
    if not distance then
        return false
    end
    return distance <= maxRange
end

--- Checks if the target is in execute phase (below a health percentage threshold).
--- @param threshold number The health percentage threshold for execute phase.
--- @return boolean True if the target is in execute phase, false otherwise.
--- @usage NAG:IsExecutePhase(20)
function NAG:IsExecutePhase(threshold)
    if not threshold then return false end
    if not UnitExists("target") then return false end

    local healthPerc = 100
    if UnitHealthMax("target") then
        healthPerc = (UnitHealth("target") / UnitHealthMax("target")) * 100
    end

    -- Use unified encounter timer system for training dummy simulation
    -- This provides the same source of truth as EncounterStopwatch.lua
    if ns.IsTrainingDummy() then
        -- Check if encounter timer is enabled and we have valid encounter data
        if NAG.db.global.enableEncounterTimer then
            local remainingPercent = NAG:RemainingTimePercent()
            if remainingPercent and remainingPercent > 0 and remainingPercent < 7777 then
                -- Use the simulated target health percentage from encounter timer
                healthPerc = remainingPercent
            end
        end
    end

    return (healthPerc <= threshold)
end

--- Get the time remaining in seconds until the target reaches the specified health percentage.
--- @param self NAG The NAG addon instance
--- @param percent number The target health percentage (0-100).
--- @return number The time remaining in seconds, or 8888 if unable to calculate.
--- @usage NAG:TimeToPercent(20) -- Time until target reaches 20% health
function NAG:TimeToPercent(percent)

    percent = math.max(0, math.min(100, percent or 0))

    if percent == 0 then
        return self:RemainingTime()
    end

    local guid = UnitGUID("target")
    if not guid then
        return 8888
    end

    local hp = UnitHealth("target") or 0
    local maxHealth = UnitHealthMax("target") or 1
    if maxHealth <= 0 or hp <= 0 then
        return 8888
    end

    local curPct = (hp / maxHealth) * 100

    -- Use unified encounter timer system for training dummy simulation
    -- This provides the same source of truth as other health-related functions
    if ns.IsTrainingDummy() then
        -- Check if encounter timer is enabled and we have valid encounter data
        if NAG.db.global.enableEncounterTimer then
            local remainingPercent = self:RemainingTimePercent()
            if remainingPercent and remainingPercent > 0 and remainingPercent < 7777 then
                -- Use the simulated target health percentage from encounter timer
                curPct = remainingPercent
            end
        end
    end

    if curPct <= percent then
        return 0
    end
    if curPct >= 100 then
        return 8888
    end

    -- Use TTDManager directly - evaluation caching handled by APLEvaluationCache
    local ttx = TTDManager:GetTimeToPercent(guid, percent, 3)

    if StateManager.state and StateManager.state.target then
        StateManager.state.target.guid     = guid
        StateManager.state.target.ttx      = ttx
        StateManager.state.target.ttx_p    = percent
        StateManager.state.target.ttx_ts   = GetTime()
        StateManager.state.target.ttx_guid = guid
    end

    if ttx and ttx >= 0 and ttx < 7777 then
        return ttx
    end

    if StateManager.state and StateManager.state.target and StateManager.state.target.guid == guid and StateManager.state.target.ttx_guid == guid then
        local ttl = (TTDManager.state and TTDManager.state.userInterval or 0.75) * 2
        local last, ts, p = StateManager.state.target.ttx, StateManager.state.target.ttx_ts,
            StateManager.state.target.ttx_p
        if last and p == percent and ts and (GetTime() - ts) < ttl then
            return last
        end
    end

    return 8888
end

-- ============================ NAG-SPECIFIC HELPERS ============================
--- Get the number of targets in range that have a specific debuff applied by the player.
--- Uses the same dynamic range calculation as NAG:NumberTargets() with spec-appropriate ranges.
---
--- Behavior:
--- - If range is provided: Adds that range to target distance for calculations
--- - If range is nil: Uses spec-appropriate ranges (melee for melee classes, ranged for ranged classes)
---
--- Spec-specific ranges are automatically applied when no range parameter is provided:
--- - Enhancement Shaman: 10-yard melee range for abilities like Unleash Elements
--- - Retribution Paladin: 10-yard melee range for abilities like Hammer of Wrath
--- - Ranged specs: 40-yard ranged range for spell casting
---
--- @function NAG:NumberTargetsWithDebuff
--- @param debuffId number The ID of the debuff to check for
--- @param range number|nil Optional additional range to add to target distance (overrides spec-appropriate ranges)
--- @usage NAG:NumberTargetsWithDebuff(55078) -- Check how many targets have Blood Plague (spec-appropriate range)
--- @usage NAG:NumberTargetsWithDebuff(55095, 10) -- Check targets within targetDistance + 10 yards have Frost Fever
--- @return number The number of targets with the specified debuff
function NAG:NumberTargetsWithDebuff(debuffId, range)
    if not debuffId then
        self:Error("NumberTargetsWithDebuff: No debuffId provided")
        return 0
    end

    if not RC then
        self:Error("LibRangeCheck-3.0 not found")
        return 0
    end

    local targetDistance = 0
    if UnitExists("target") then
        local minRange, maxDist = RC:GetRange("target", true)
        targetDistance = minRange or maxDist or 0
    else
        return 0
    end

    local effectiveRange
    if range then
        effectiveRange = targetDistance + range
    else
        if TTDManager:IsRangedClass() then
            effectiveRange = targetDistance + TTDManager:GetSpecRange("ranged")
        else
            effectiveRange = TTDManager:GetSpecRange("melee")
        end
    end

    return TTDManager:GetEnemyUnitsInRange(min(max(1, effectiveRange), 100), { debuffId = debuffId }) or 0
end

--- Helper function to count targets with a specific debuff within a given range (uses unified enemy iteration).
--- @param debuffId number The ID of the debuff to check for
--- @param maxRange number The maximum range to check
--- @return number The number of targets with the specified debuff
function NAG:CountTargetsWithDebuffInRange(debuffId, maxRange)
    if not debuffId or not maxRange then return 0 end
    return TTDManager:GetEnemyUnitsInRange(min(max(1, maxRange), 100), { debuffId = debuffId }) or 0
end

--- Counts the number of enemies in range.
--- @param self NAG The NAG addon instance
--- @param maxRange number The maximum range to check (1-100 yards).
--- @param useAdvancedFeatures boolean|nil Optional: Whether to use advanced features (default: true)
--- @param useCaching boolean|nil Optional: Whether to use caching (default: true)
--- @return number Number of enemies in range.
--- @usage NAG:CountEnemiesInRange(30)
---
--- **Note:** This function now uses the unified TTDManager implementation with basic features.
--- For advanced features (training dummy detection, target handling, caching), use TTDManager directly.
function NAG:CountEnemiesInRange(maxRange, useAdvancedFeatures, useCaching)
    -- Use the unified TTDManager implementation with configurable features
    -- Default to basic features for performance in APL system
    useAdvancedFeatures = useAdvancedFeatures ~= false -- Default to true for backward compatibility
    useCaching = useCaching ~= false                   -- Default to true for backward compatibility

    return TTDManager:CountEnemiesInRange(maxRange, useAdvancedFeatures, useCaching)
end

--- Get the number of targets in range that have Time To Death higher than a given threshold.
--- @param minTTD number The minimum Time To Death threshold in seconds
--- @param range number|nil Optional range to use for counting targets (default: 15)
--- @usage NAG:NumberTargetsWithTTD(10) -- Check how many targets have TTD > 10 seconds
--- @usage NAG:NumberTargetsWithTTD(5, 20) -- Check how many targets within 20 yards have TTD > 5 seconds
--- @return number The number of targets with TTD higher than the threshold
function NAG:NumberTargetsWithTTD(minTTD, range)
    if not minTTD then
        self:Error("NumberTargetsWithTTD: No minTTD provided")
        return 0
    end

    range = range or 15
    return TTDManager:GetEnemyUnitsInRange(min(max(1, range), 100), { minTTD = minTTD }) or 0
end

--- Checks if the player is currently in a raid group.
--- RESPECTS GROUP/RAID OVERRIDES for testing purposes.
--- @param self NAG The NAG addon instance
--- @return boolean True if the player is in a raid, false otherwise.
--- @usage NAG:PlayerIsInRaid()
--- @local This function is used to check if the player is currently in a raid group.
function NAG:PlayerIsInRaid()
    -- Check for group/raid overrides first (StateManager is preloaded)
    return StateManager:IsEffectivelyInRaid()
end

--- Checks if the player is in any group (party or raid).
--- RESPECTS GROUP/RAID OVERRIDES for testing purposes.
--- @param self NAG The NAG addon instance
--- @return boolean True if the player is in a party or raid, false otherwise.
--- @usage NAG:PlayerIsInGroup()
--- @local This function is used to check if the player is currently in any group (party or raid).
function NAG:PlayerIsInGroup()
    -- Check for group/raid overrides first (StateManager is preloaded)
    -- In WoW, being in a raid OR party means you're in a group
    return StateManager:IsEffectivelyInParty() or StateManager:IsEffectivelyInRaid()
end

--- Gets the effective group member count (with overrides applied)
--- RESPECTS GROUP/RAID OVERRIDES for testing purposes.
--- @param self NAG The NAG addon instance
--- @return number The effective group member count
--- @usage local count = NAG:GetEffectiveGroupMemberCount()
--- @local This function is used to get the group member count with overrides applied.
function NAG:GetEffectiveGroupMemberCount()
    -- Check for group/raid overrides first (StateManager is preloaded)
    return StateManager:GetEffectiveGroupMemberCount()
end

--- Returns the list of unit IDs for current group members (respects overrides).
--- Solo returns {"player"}. Callers should iterate immediately; do not store the returned table.
--- @param self NAG The NAG addon instance
--- @return table Table of unit ID strings
--- @usage for _, unit in ipairs(NAG:GetGroupMemberUnits()) do ... end
function NAG:GetGroupMemberUnits()
    return StateManager:GetGroupMemberUnits()
end

--- Returns the list of unit IDs for the player's subgroup (raid = subgroup only; party = full party; solo = player).
--- Callers should iterate immediately; do not store the returned table.
--- @return table Table of unit ID strings
function NAG:GetSubgroupMemberUnits()
    return StateManager:GetSubgroupMemberUnits()
end

--- Returns the number of units of the given class in the group or subgroup. When classToken is nil, uses player's class.
--- @param classToken string|nil e.g. "HUNTER"; nil = UnitClassBase("player")
--- @param scope string|nil "group" (default) or "subgroup"
--- @return number
function NAG:GetClassCountInGroup(classToken, scope)
    return StateManager:GetClassCountInGroup(classToken, scope)
end

--- Returns true when at most one unit of the given class is in the group. When classToken is nil, uses player's class.
--- @param classToken string|nil nil = player's class
--- @param scope string|nil "group" (default) or "subgroup"
--- @return boolean
function NAG:IsOnlyClassInGroup(classToken, scope)
    return StateManager:IsOnlyClassInGroup(classToken, scope)
end

--- Returns true when at least one other unit of the given class (excluding player) is in the group/subgroup. When classToken is nil, uses player's class.
--- @param classToken string|nil nil = player's class
--- @param scope string|nil "subgroup" (default) or "group"
--- @return boolean
function NAG:HasOtherClassInGroup(classToken, scope)
    return StateManager:HasOtherClassInGroup(classToken, scope)
end

--- Check if the player is currently in a raid or dungeon boss encounter or Training Dummy
--- @param self NAG The NAG addon instance
--- @return boolean True if in an encounter or training dummy simulation, false otherwise
--- @usage
--- local inEncounter = NAG:InEncounter()
--- if inEncounter then
---     print("Player is in an encounter or training dummy simulation")
--- end
--- @note Originally from TTDManager module - moved to APLValues_Encounter for better organization
function NAG:InEncounter()
    -- Check for actual encounter or training dummy simulation
    return IsEncounterInProgress() == true or TTDManager:IsTrainingDummyWithSimulation()
end

--- Get the current encounter ID if in an encounter, or 0 otherwise
--- @return number The current encounter ID, or 0 if none
--- @usage if NAG:CurrentEncounterId() == 1498 then ... end
function NAG:CurrentEncounterId()
 if StateManager.currentEncounterId then
        return StateManager.currentEncounterId
    end
    return 0
end

--- Check if a class assignment is enabled for the current class
--- @param assignmentId string The assignment ID to check
--- @return boolean True if the assignment is enabled, false otherwise
--- @usage if NAG:IsAssignmentEnabled("curse_of_elements") then ... end
function NAG:IsAssignmentEnabled(assignmentId)
    if not assignmentId then return false end

    -- Get the current class module
    local classModule = NAG.Class
    if not classModule or not classModule.GetAssignmentStates then
        return false
    end
    if classModule.IsClassAssignmentsEnabled and not classModule:IsClassAssignmentsEnabled() then
        return false
    end

    local states = classModule:GetAssignmentStates()
    return states[assignmentId] or false
end

--- Check if a spell belongs to an enabled assignment
--- @param spellId number The spell ID to check against assignment spell lists
--- @return boolean True if the spell is part of an enabled assignment, false otherwise
--- @usage if NAG:IsAssignmentSpellEnabled(980) then ... end
function NAG:IsAssignmentSpellEnabled(spellId)
    if not spellId then return false end

    local classModule = NAG.Class
    if not classModule then return false end

    local assignments = classModule.defaults.class.classAssignments or {}
    if not assignments or #assignments == 0 then
        return false
    end

    for _, assignment in ipairs(assignments) do
        if NAG:IsAssignmentEnabled(assignment.id) then
            for _, assignedSpellId in ipairs(assignment.spellIds or {}) do
                if assignedSpellId == spellId then
                    return true
                end
            end
        end
    end

    return false
end

--- Get the user's current assignment states
--- @return table Table of assignment states { [assignmentId] = enabled }
--- @usage local states = NAG:GetCurrentAssignments()
function NAG:GetCurrentAssignments()
    local classModule = NAG.Class
    if not classModule or not classModule.GetAssignmentStates then
        return {}
    end
    return classModule:GetAssignmentStates()
end

--- Get the next priority assignment that should be cast
--- Checks enabled assignments in order and returns the first one that needs to be applied
--- @return string|nil The assignment ID that should be cast next, or nil if none needed
--- @usage local nextAssignment = NAG:GetNextAssignment()
function NAG:GetNextAssignment()
    local classModule = NAG.Class
    if not classModule then return nil end

    local assignments = classModule.defaults.class.classAssignments or {}

    for _, assignment in ipairs(assignments) do
        -- Only consider enabled assignments
        if NAG:IsAssignmentEnabled(assignment.id) then
            -- Check if this assignment needs to be applied
            -- For debuffs, check if any targets are missing the effect
            if assignment.category == "debuff" then
                -- Check if any targets are missing this debuff
                for _, spellId in ipairs(assignment.spellIds) do
                    if NAG:CountTargetsWithDebuff(spellId, 10) < NAG:NumberTargets(10) then
                        return assignment.id
                    end
                end
            elseif assignment.category == "buff" then
                -- For buffs, check if the buff is missing
                for _, spellId in ipairs(assignment.spellIds) do
                    if not NAG:AuraIsActiveResolved(spellId) then
                        return assignment.id
                    end
                end
            end
        end
    end

    return nil -- No assignments need attention
end

--- Debug function to test assignment states (prints to chat)
--- @param assignmentId string|nil Optional specific assignment ID to test, or nil to test all
--- @usage NAG:TestAssignmentEnabled() -- Test all assignments
--- @usage NAG:TestAssignmentEnabled("curse_of_elements") -- Test specific assignment
function NAG:TestAssignmentEnabled(assignmentId)
    local classModule = NAG.Class
    if not classModule then
        NAG:Print("No class module found")
        return
    end

    if assignmentId then
        -- Test specific assignment
        local enabled = NAG:IsAssignmentEnabled(assignmentId)
        NAG:Print(format("Assignment '%s': %s", assignmentId, enabled and "|cff00ff00ENABLED|r" or "|cffff0000DISABLED|r"))
    else
        -- Test all assignments
        local states = classModule:GetAssignmentStates()
        NAG:Print("=== Class Assignment States ===")
        for id, enabled in pairs(states) do
            NAG:Print(format("  %s: %s", id, enabled and "|cff00ff00ENABLED|r" or "|cffff0000DISABLED|r"))
        end

        -- Show next priority assignment
        local nextAssignment = NAG:GetNextAssignment()
        if nextAssignment then
            NAG:Print(format("Next priority assignment: |cff00ff00%s|r", nextAssignment))
        else
            NAG:Print("All assignments up to date")
        end
        NAG:Print("=== End Assignment States ===")
    end
end
