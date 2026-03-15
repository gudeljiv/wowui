--- @module "APLValues_Unit"
--- Unit-related APL value functions for the NAG addon
---
--- This module provides utility functions for unit movement, distance, casting, and other unit-related operations.
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
local GetTime = _G.GetTime
local UnitExists = _G.UnitExists
local UnitCanAttack = _G.UnitCanAttack
local UnitCastingInfo = _G.UnitCastingInfo
local UnitChannelInfo = _G.UnitChannelInfo
local UnitCreatureType = _G.UnitCreatureType
local GetUnitSpeed = _G.GetUnitSpeed
local UnitThreatSituation = _G.UnitThreatSituation
local WoWAPI = ns.WoWAPI
local UnitDetailedThreatSituation = WoWAPI.UnitDetailedThreatSituation

-- Libraries
local L = ns.AceLocale:GetLocale("NAG", true)
local RC = ns.RC

local function GetRangeCheck()
    local current = ns.RC
    if current ~= RC then
        RC = current
    end
    return RC
end

-- Lua APIs (WoW optimized where available)
local format = string.format
local max = math.max


-- ============================ MODULE CACHING (PERFORMANCE) ============================
-- Cache frequently accessed modules to avoid GetModule overhead in hot paths
local Types = ns.Types

local ipairs = ipairs
local type = type

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

-- ============================ UNIT EXISTENCE AND VALIDATION FUNCTIONS ============================

--- Checks if a unit exists
--- @param unit? string The unit to check (e.g., "player", "target", "focus") (default: "target")
--- @return boolean True if the unit exists, false otherwise
--- @usage NAG:UnitExists("target")
--- @usage NAG:UnitExists("player")
function NAG:UnitExists(unit)
    unit = unit or "target"
    return UnitExists(unit) or false
end

--- Checks if one unit can attack another unit
--- @param sourceUnit? string The source unit (default: "player")
--- @param targetUnit? string The target unit (default: "target")
--- @return boolean True if the source unit can attack the target unit, false otherwise
--- @usage NAG:UnitCanAttack("player", "target")
--- @usage NAG:UnitCanAttack()
function NAG:UnitCanAttack(sourceUnit, targetUnit)
    sourceUnit = sourceUnit or "player"
    targetUnit = targetUnit or "target"
    if not UnitExists(targetUnit) then
        return false
    end
    return UnitCanAttack(sourceUnit, targetUnit) or false
end

-- ============================ UNIT MOVEMENT FUNCTIONS ============================

--- Checks if a unit is currently moving.
--- @param unit? string The unit identifier (e.g., "player", "target", "party1") (default: "player")
--- @return boolean True if the unit is moving, false otherwise
--- @usage NAG:UnitIsMoving("player") -- Check if player is moving
--- @usage NAG:UnitIsMoving("target") -- Check if target is moving
function NAG:UnitIsMoving(unit)
    -- Default to player if no unit specified
    unit = unit or "player"

    -- Check if the unit exists
    if not UnitExists(unit) then
        return false
    end

    -- Get the unit's current speed
    local speed = GetUnitSpeed(unit)

    -- If speed is greater than 0, the unit is moving
    return speed > 0
end

-- ============================ HEALING (MOUSEOVER AND GROUP STATE) ============================
-- State is populated by NAG.mists.HealingStateManager when loaded (MoP). Handlers read from NAG.state.healing.

--- True if mouseover unit exists and is friendly.
--- @return boolean
function NAG:MouseoverFriendlyExists()
    local h = NAG.state and NAG.state.healing and NAG.state.healing.mouseover
    if h then return h.exists or false end
    return UnitExists("mouseover") or false
end

--- Mouseover unit health as 0-100.
--- @return number
function NAG:MouseoverHealthPercent()
    local h = NAG.state and NAG.state.healing and NAG.state.healing.mouseover
    if h and h.health and h.health.pct then
        return h.health.pct * 100
    end
    if not UnitExists("mouseover") then return 100 end
    local maxH = UnitHealthMax("mouseover")
    if not maxH or maxH <= 0 then return 100 end
    return ((UnitHealth("mouseover") or 0) / maxH) * 100
end

--- Mouseover unit effective health as 0-100 (health after absorb; MoP+ when available).
--- Falls back to MouseoverHealthPercent when effective health is not in state.
--- @return number
function NAG:MouseoverEffectiveHealthPercent()
    local h = NAG.state and NAG.state.healing and NAG.state.healing.mouseover
    if h and h.effectiveHealth and h.effectiveHealth.pct then
        return h.effectiveHealth.pct * 100
    end
    return self:MouseoverHealthPercent()
end

--- True if mouseover unit is assigned as tank.
--- @return boolean
function NAG:MouseoverIsTank()
    local h = NAG.state and NAG.state.healing and NAG.state.healing.mouseover
    if h then return h.isTank or false end
    return false
end

--- True if mouseover unit is the player.
--- @return boolean
function NAG:MouseoverIsSelf()
    local h = NAG.state and NAG.state.healing and NAG.state.healing.mouseover
    if h then return h.is_self or false end
    return UnitIsUnit("mouseover", "player") or false
end

--- True if mouseover has the given buff.
--- @param auraId number Spell ID of the buff
--- @param exactIdMatch boolean|nil
--- @return boolean
function NAG:MouseoverHasBuff(auraId, exactIdMatch)
    if not UnitExists("mouseover") then return false end
    local aura = NAG:UnitAura("mouseover", auraId, "HELPFUL", exactIdMatch)
    return aura and aura ~= false
end

--- Remaining duration in seconds of buff on mouseover.
--- @param auraId number Spell ID of the buff
--- @param exactIdMatch boolean|nil
--- @return number
function NAG:MouseoverBuffRemains(auraId, exactIdMatch)
    if not UnitExists("mouseover") then return 0 end
    local aura = NAG:UnitAura("mouseover", auraId, "HELPFUL", exactIdMatch)
    if not aura or aura == false then return 0 end
    local exp = aura.expirationTime
    if not exp or exp <= 0 then return 0 end
    return max(0, exp - GetTime())
end

--- True if mouseover has a dispellable debuff.
--- @return boolean
function NAG:MouseoverNeedsDispel()
    local h = NAG.state and NAG.state.healing and NAG.state.healing.mouseover
    if h then return h.dispel or false end
    return false
end

--- Dispel type of first dispellable debuff on mouseover (Magic, Curse, Disease, Poison).
--- Lets rotations choose the correct spell (e.g. Cure Disease vs Purify).
--- @return string|nil dispelType or nil if none or no dispel manager
function NAG:MouseoverDispelType()
    local mod = NAG:GetModule("HealingDispelManager", true)
    if not mod or not mod.GetFirstDispellableDebuff then return nil end
    local _, _, dispelType = mod:GetFirstDispellableDebuff("mouseover")
    return dispelType
end

--- True if any group member is below health threshold.
--- @param healthThreshold number|nil 0-100 (default from HealingStateManager)
--- @return boolean
function NAG:GroupNeedsHealing(healthThreshold)
    local h = NAG.state and NAG.state.healing and NAG.state.healing.group
    if h and (healthThreshold == nil or healthThreshold == 0) then
        return h.heal_needed or false
    end
    local priorityMod = NAG:GetModule("HealingPriorityManager", true)
    if priorityMod and priorityMod.CountUnitsNeedingHealing then
        return priorityMod:CountUnitsNeedingHealing(healthThreshold or 80) > 0
    end
    return false
end

--- Number of group members below health threshold.
--- @param healthThreshold number|nil 0-100 (default from HealingStateManager)
--- @return number
function NAG:LowHealthMemberCount(healthThreshold)
    local h = NAG.state and NAG.state.healing and NAG.state.healing.group
    if h and (healthThreshold == nil or healthThreshold == 0) then
        return h.low_health_count or 0
    end
    local priorityMod = NAG:GetModule("HealingPriorityManager", true)
    if priorityMod and priorityMod.CountUnitsNeedingHealing then
        return priorityMod:CountUnitsNeedingHealing(healthThreshold or 80)
    end
    return 0
end

-- ============================ UNIT DISTANCE FUNCTIONS ============================

--- Gets the distance to a specific unit with optional range capping.
--- @param unit? string The unit to check distance to (e.g., "target", "focus", "player", etc.)
--- @param maxRange? number Optional maximum range to cap the result at
--- @return number Distance to the unit in yards, or -1 if unavailable
--- @usage NAG:UnitDistance("target") <= 30
--- @usage NAG:UnitDistance("focus", 40) <= 30
function NAG:UnitDistance(unit, maxRange)
    unit = unit or "target"

    local rangeCheck = GetRangeCheck()
    if not rangeCheck or not rangeCheck.GetRange then
        return -1
    end

    -- Validate unit exists
    if not UnitExists(unit) then
        return -1
    end

    -- Get range info with visibility check for accuracy
    local minRange, maxDist = rangeCheck:GetRange(unit, true)

    if not minRange and not maxDist then
        return -1 -- Unit not visible or out of range
    end

    -- Use the most precise range value available
    local distance = minRange or maxDist

    if not distance then
        return -1
    end

    -- Apply range capping if specified
    if maxRange and distance > maxRange then
        return maxRange
    end

    return distance
end

-- ============================ UNIT CASTING FUNCTIONS ============================

--- Checks if a unit is currently casting any spell or a specific spell.
--- @param unit string The unit to check (e.g., "player", "target", "focus")
--- @param spellId number|nil Optional spell ID to check for specific spell
--- @return boolean True if the unit is casting (any spell or specific spell), false otherwise
--- @usage NAG:UnitIsCasting("target") -- Check if casting any spell
--- @usage NAG:UnitIsCasting("target", 12345) -- Check if casting specific spell
function NAG:UnitIsCasting(unit, spellId)
    if not unit then
        return false
    end

    -- Check if unit exists
    if not UnitExists(unit) then
        return false
    end

    local spellName, _, _, _, _, _, _, _, currentSpellID = UnitCastingInfo(unit)
    if not spellName then
        return false
    end

    if spellId then
        -- Resolve to spellbook ID so we match the spell the unit is casting
        if NAG and NAG.ResolveEffectiveSpellId then
            local resolved = NAG:ResolveEffectiveSpellId(spellId)
            if resolved then
                spellId = resolved
            end
        end
        return currentSpellID and currentSpellID == spellId
    else
        return true
    end
end

--- Checks if a unit is currently channeling any spell or a specific spell.
--- @param unit string The unit to check (e.g., "player", "target", "focus")
--- @param spellId number|nil Optional spell ID to check for specific spell
--- @return boolean True if the unit is channeling (any spell or specific spell), false otherwise
--- @usage NAG:UnitIsChanneling("target") -- Check if channeling any spell
--- @usage NAG:UnitIsChanneling("target", 12345) -- Check if channeling specific spell
function NAG:UnitIsChanneling(unit, spellId)
    if not unit then
        return false
    end

    -- Check if unit exists
    if not UnitExists(unit) then
        return false
    end

    local spellName, _, _, _, _, _, _, currentSpellID = UnitChannelInfo(unit)
    if not spellName then
        return false
    end

    if spellId then
        -- Resolve to spellbook ID so we match the spell the unit is channeling
        if NAG and NAG.ResolveEffectiveSpellId then
            local resolved = NAG:ResolveEffectiveSpellId(spellId)
            if resolved then
                spellId = resolved
            end
        end
        return currentSpellID and currentSpellID == spellId
    else
        return true
    end
end

--- Checks if a unit is currently casting or channeling any spell.
--- @param unit string The unit to check (e.g., "player", "target", "focus")
--- @return boolean True if the unit is casting or channeling, false otherwise
--- @usage NAG:UnitIsCastingOrChanneling("target")
--- @usage NAG:UnitIsCastingOrChanneling("player")
function NAG:UnitIsCastingOrChanneling(unit)
    if not unit then
        return false
    end

    -- Check if unit exists
    if not UnitExists(unit) then
        return false
    end

    local isCasting = UnitCastingInfo(unit)
    local isChanneling = UnitChannelInfo(unit)

    return (isCasting ~= nil) or (isChanneling ~= nil)
end

--- Gets the remaining cast time for a unit's current spell.
--- @param unit string The unit to check (e.g., "player", "target", "focus")
--- @return number Remaining cast time in seconds, or 0 if not casting
--- @usage NAG:UnitCastTimeRemaining("target") <= 2.5
--- @usage NAG:UnitCastTimeRemaining("player") >= 1.0
function NAG:UnitCastTimeRemaining(unit)
    if not unit then
        return 0
    end

    -- Check if unit exists
    if not UnitExists(unit) then
        return 0
    end

    local spellName, _, _, _, startTime, endTime = UnitCastingInfo(unit)
    if not endTime or not startTime then
        return 0
    end

    local currentTime = GetTime() * 1000                 -- Convert to milliseconds
    local remainingTime = (endTime - currentTime) / 1000 -- Convert back to seconds

    return max(0, remainingTime)
end

--- Gets the remaining channel time for a unit's current spell.
--- @param unit string The unit to check (e.g., "player", "target", "focus")
--- @return number Remaining channel time in seconds, or 0 if not channeling
--- @usage NAG:UnitChannelTimeRemaining("target") <= 3.0
--- @usage NAG:UnitChannelTimeRemaining("player") >= 0.5
function NAG:UnitChannelTimeRemaining(unit)
    if not unit then
        return 0
    end

    -- Check if unit exists
    if not UnitExists(unit) then
        return 0
    end

    local spellName, _, _, _, startTime, endTime = UnitChannelInfo(unit)
    if not endTime or not startTime then
        return 0
    end

    local currentTime = GetTime() * 1000                 -- Convert to milliseconds
    local remainingTime = (endTime - currentTime) / 1000 -- Convert back to seconds

    return max(0, remainingTime)
end

-- ============================ NAG-SPECIFIC ALIASES ============================

--- Checks if the player is currently casting a specific spell.
--- @param spellId number The spell ID to check
--- @return boolean True if the player is casting the spell, false otherwise
--- @usage NAG:SpellIsCasting(12345)
function NAG:SpellIsCasting(spellId)
    return self:UnitIsCasting("player", spellId)
end

--- Checks if a unit's cast or channel is interruptible.
--- This function robustly checks both casting and channeling states, handling version differences in the WoW API.
--- In modern clients, uses the 'notInterruptible' (8th return value) from both UnitCastingInfo and UnitChannelInfo.
--- In Classic, these fields may be nil, so the function returns false (not interruptible) if the info is unavailable.
--- @param unit? string The unit to check (e.g., "target", "focus", "player") (default: "target")
--- @return boolean True if the unit is currently casting or channeling and is interruptible, false otherwise
--- @usage NAG:UnitIsInterruptible("target")
--- @usage NAG:UnitIsInterruptible("focus")
function NAG:UnitIsInterruptible(unit)
    unit = unit or "target"

    if not UnitExists(unit) then
        return false
    end
    local notInterruptible
    -- Check if unit is casting a spell
    notInterruptible = select(8, UnitCastingInfo(unit))
    if notInterruptible ~= nil then
        -- Retail and Wrath+ API: 'notInterruptible' is true if NOT interruptible
        return not notInterruptible
    end

    -- Check if unit is channeling a spell
    -- Retail: 'notInterruptible' is true if NOT interruptible
    notInterruptible = select(7, UnitChannelInfo(unit))
    if notInterruptible ~= nil then
        return not notInterruptible
    end

    -- If neither field is available (Classic), assume not interruptible
    return false
end

-- ============================ UNIT THREAT FUNCTIONS ============================

--- Checks if a source unit is the primary target (has aggro) on a target unit.
--- @param source? string The unit to check threat for (default: "player")
--- @param target? string The unit to check threat against (default: "target")
--- @return boolean True if the source unit is tanking the target, false otherwise
--- @usage NAG:UnitIsPrimaryTarget("player", "target") -- Check if player has aggro on target
--- @usage NAG:UnitIsPrimaryTarget("focus", "target") -- Check if focus has aggro on target
--- @usage NAG:UnitIsPrimaryTarget() -- Check if player has aggro on target (defaults)
function NAG:UnitIsPrimaryTarget(source, target)
    source = source or "player"
    target = target or "target"

    if not UnitExists(source) or not UnitExists(target) then
        return false
    end

    local threat = UnitThreatSituation(source, target)
    return threat ~= nil and threat >= 2
end

--- Returns the detailed threat percent for a source unit on a target unit.
--- @param source? string The unit to check threat for (default: "player")
--- @param target? string The unit to check threat against (default: "target")
--- @return number The threat percent (0-100), or 0 if unavailable
--- @usage NAG:UnitThreatPercent("player", "target")
function NAG:UnitThreatPercent(source, target)
    source = source or "player"
    target = target or "target"

    if not UnitDetailedThreatSituation or not UnitExists(source) or not UnitExists(target) then
        return 0
    end

    local _, _, threatPct = UnitDetailedThreatSituation(source, target)
    return threatPct or 0
end

--- Returns the raw threat percent for a source unit on a target unit.
--- @param source? string The unit to check threat for (default: "player")
--- @param target? string The unit to check threat against (default: "target")
--- @return number The raw threat percent (0-100), or 0 if unavailable
--- @usage NAG:UnitThreatRawPercent("player", "target")
function NAG:UnitThreatRawPercent(source, target)
    source = source or "player"
    target = target or "target"

    if not UnitDetailedThreatSituation or not UnitExists(source) or not UnitExists(target) then
        return 0
    end

    local _, _, _, rawThreatPct = UnitDetailedThreatSituation(source, target)
    return rawThreatPct or 0
end

--- Returns the raw threat value for a source unit on a target unit.
--- @param source? string The unit to check threat for (default: "player")
--- @param target? string The unit to check threat against (default: "target")
--- @return number The raw threat value, or 0 if unavailable
--- @usage NAG:UnitThreatValue("player", "target")
function NAG:UnitThreatValue(source, target)
    source = source or "player"
    target = target or "target"

    if not UnitDetailedThreatSituation or not UnitExists(source) or not UnitExists(target) then
        return 0
    end

    local _, _, _, _, threatValue = UnitDetailedThreatSituation(source, target)
    return threatValue or 0
end

--- Returns normalized threat percent for a source unit on a target unit.
--- Value is typically 0-1, and can be above 1 when above 100% threat (e.g. 1.3 = 130%).
--- @param source? string The unit to check threat for (default: "player")
--- @param target? string The unit to check threat against (default: "target")
--- @return number The normalized threat value, or 0 if unavailable
--- @usage NAG:ThreatPercent("player", "target")
function NAG:ThreatPercent(source, target)
    source = source or "player"
    target = target or "target"

    if not UnitDetailedThreatSituation or not UnitExists(source) or not UnitExists(target) then
        return 0
    end

    local _, _, threatPct, rawThreatPct = UnitDetailedThreatSituation(source, target)
    local threatPercent = rawThreatPct or threatPct or 0
    return threatPercent / 100
end

-- ============================ UNIT MOB TYPE FUNCTIONS ============================

--- Checks if a unit is of a specific mob type.
--- @param unit? string The unit to check (e.g., "target", "focus", "player") (default: "target")
--- @param mobType string The type of mob to check for
--- @return boolean True if the unit is of the specified mob type, false otherwise
--- @usage NAG:UnitIsMobType("target", NAG.Types:GetType("MobType").Undead)
--- @usage NAG:UnitIsMobType("focus", NAG.Types:GetType("MobType").Mechanical)
--- @usage NAG:UnitIsMobType(nil, mobType) -- Check target (default)
function NAG:UnitIsMobType(unit, mobType)
    unit = unit or "target"

    if not mobType then
        return false
    end

    if not UnitExists(unit) then
        return false
    end

    -- Get the creature type of the unit
    local creatureType = UnitCreatureType(unit)
    if not creatureType then
        return false
    end

    -- Direct comparison with the mob type from Types
    return Types:GetType("MobType")[creatureType] == mobType
end

-- ============================ UNIT STEALTH FUNCTIONS ============================

--- Checks if a unit is currently stealthed by checking known stealth abilities.
--- @param unit? string The unit to check (e.g., "player", "target", "focus") (default: "player")
--- @return boolean True if the unit is stealthed, false otherwise
--- @usage NAG:UnitIsStealthed("player") -- Check if player is stealthed
--- @usage NAG:UnitIsStealthed("target") -- Check if target is stealthed (PvP)
--- @usage NAG:UnitIsStealthed() -- Check if player is stealthed (default)
function NAG:UnitIsStealthed(unit)
    unit = unit or "player"

    -- Check if unit exists
    if not UnitExists(unit) then
        return false
    end

    local stealthAbilities = {
        1784,  -- Stealth
        11327, -- Vanish
    }

    for _, spellId in ipairs(stealthAbilities) do
        if self:IsActiveAura(spellId, unit) then
            return true
        end
    end

    return false
end

-- ============================ ALIASES ============================

--- @deprecated Use NAG:UnitIsInterruptible("target") instead
--- @return boolean True if the target is currently casting or channeling and is interruptible, false otherwise
--- @usage if NAG:IsTargetInterruptible() then NAG:CastSpell(interruptSpellId) end
function NAG:IsTargetInterruptible()
    return self:UnitIsInterruptible("target")
end

--- @deprecated Use NAG:UnitIsPrimaryTarget("player", "target") instead
--- @param unit? string The unit to check threat against (default: "target")
--- @return boolean True if the player is tanking, false otherwise
function NAG:HasAggro(unit)
    unit = unit or "target"
    return self:UnitIsPrimaryTarget("player", unit)
end

--- @deprecated Use NAG:UnitIsMobType("target", mobType) instead
--- @param mobType string The type of mob to check for
--- @return boolean True if the target is of the specified mob type, false otherwise
--- @usage NAG:TargetMobType(NAG.Types:GetType("MobType").Undead)
function NAG:TargetMobType(mobType, targetUnit)
    return self:UnitIsMobType(targetUnit, mobType)
end
