--- @module "APLValues_Boss"
--- Boss-related APL value functions for the NAG addon
---
--- This module provides utility functions for boss encounters, boss mechanics, and encounter-specific conditions.
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
local WoWAPI = ns.WoWAPI

-- WoW API
local UnitExists = _G.UnitExists
local UnitIsUnit = _G.UnitIsUnit
local IsEncounterInProgress = _G.IsEncounterInProgress

-- ============================ HEADER LOCALS ============================

-- Lua APIs (WoW optimized where available)
local format = string.format
local max = math.max



-- ============================ LOCAL UTILITIES ============================

--- Resolves the most relevant boss unit token, prioritizing explicit input, then boss units, then "target".
--- @param requestedUnit? string|nil The unit token provided by the caller.
--- @return string resolvedUnit The unit token to inspect.
local function resolveBossUnit(requestedUnit)
    if type(requestedUnit) == "string" and requestedUnit ~= "" then
        return requestedUnit
    end

    if IsEncounterInProgress() == true then
        for index = 1, 5 do
            local bossUnit = "boss" .. index
            if UnitExists(bossUnit) then
                return bossUnit
            end
        end
    end

    return "target"
end

local sort = table.sort
local concat = table.concat
local type = type

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~


--- Checks if the boss is currently casting or channeling a specific spell.
--- @param targetUnit? string The target unit to check (defaults to the first active boss unit or "target")
--- @param spellId number The spell ID to check for (returns false if nil or invalid)
--- @return boolean True if the boss is casting or channeling the specified spell, false otherwise
--- @usage NAG:BossSpellIsCasting("target", 12345) -- Check if boss is casting or channeling spell ID 12345
function NAG:BossSpellIsCasting(targetUnit, spellId)
    if not spellId then
        return false
    end

    local resolvedUnit = resolveBossUnit(targetUnit)

    return self:UnitIsCasting(resolvedUnit, spellId) or self:UnitIsChanneling(resolvedUnit, spellId)
end

--- Gets the remaining cast time for the boss's current spell.
--- @return number Remaining cast time in seconds, or 0 if not casting or no boss target
--- @usage NAG:BossCastTimeRemaining() <= 2.5 -- Check if cast will finish within 2.5 seconds
function NAG:BossCastTimeRemaining()
    local targetUnit = resolveBossUnit()
    return self:UnitCastTimeRemaining(targetUnit)
end

--- Gets the remaining channel time for the boss's current spell.
--- @return number Remaining channel time in seconds, or 0 if not channeling or no boss target
--- @usage NAG:BossChannelTimeRemaining() <= 3.0 -- Check if channel will finish within 3 seconds
function NAG:BossChannelTimeRemaining()
    local targetUnit = resolveBossUnit()
    return self:UnitChannelTimeRemaining(targetUnit)
end

-- ============================ BOSS SPELL COOLDOWN FUNCTIONS ============================

--- Gets the time until a boss spell is ready (off cooldown).
--- @param targetUnit? string The target unit to check (defaults to "target")
--- @param spellId number The spell ID to check (returns 0 if nil or invalid)
--- @return number Time in seconds until the spell is ready, or 0 if already ready or invalid spellId
--- @usage NAG:BossSpellTimeToReady("target", 12345) <= 10 -- Check if spell will be ready within 10 seconds
function NAG:BossSpellTimeToReady(targetUnit, spellId)
    if not spellId then
        return 0
    end

    local cdInfo = WoWAPI.GetSpellCooldown(spellId)
    if not cdInfo then
        return 0
    end

    local spellStart = cdInfo.startTime
    local spellDuration = cdInfo.duration

    -- Check if the spell's cooldown is active
    if spellStart > 0 and spellDuration > 0 then
        local currentTime = self:NextTime()
        local cooldownEnd = spellStart + spellDuration
        local timeToReady = cooldownEnd - currentTime

        -- Ensure timeToReady does not go negative
        timeToReady = max(0, timeToReady)

        return timeToReady
    end

    -- If spell is not on cooldown, return 0 (ready)
    return 0
end

--- Checks if the specified unit's current target is the player.
--- Mirrors the simulator's BossCurrentTarget value which evaluates to true when
--- the boss is actively targeting the player (i.e., the player is tanking).
--- @param targetUnit? string Unit token for the boss (defaults to the first active boss unit or "target")
--- @return boolean True if the boss is targeting the player, false otherwise
function NAG:BossCurrentTarget(targetUnit)
    targetUnit = resolveBossUnit(targetUnit)

    if not UnitExists(targetUnit) then
        return false
    end

    local bossTarget = targetUnit .. "target"
    if not UnitExists(bossTarget) then
        return false
    end

    return UnitIsUnit(bossTarget, "player") == true
end
