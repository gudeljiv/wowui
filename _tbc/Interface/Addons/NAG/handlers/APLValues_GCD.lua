--- @module "APLValues_GCD"
--- GCD (Global Cooldown) related APL value functions for the NAG addon
---
--- This module provides utility functions for GCD timing, cooldown management, and spell readiness.
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
local WoWAPI = ns.WoWAPI
local Version = ns.Version

-- Lua APIs (WoW optimized where available)
local GetTime = _G.GetTime


local format = string.format
local min = math.min
local max = math.max



-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

-- GCD values
--- Checks if the global cooldown (GCD) is ready.
--- @function NAG:GCDIsReady
--- @return boolean True if the GCD is ready, false otherwise.
--- @usage if NAG:GCDIsReady() then
---     -- GCD is ready, can cast spells
--- end
function NAG:GCDIsReady()
    return self:GCDTimeToReady() == 0
end

--- Returns the time until the global cooldown (GCD) is ready.
--- @function NAG:GCDTimeToReady
--- @return number The time until the GCD is ready in seconds (0 if ready).
--- @usage local timeLeft = NAG:GCDTimeToReady()
--- if timeLeft <= 0.5 then
---     -- GCD will be ready soon
--- end
function NAG:GCDTimeToReady()
    -- GCD probing spell IDs differ between client families.
    -- In this project we use:
    -- - 61304 on Retail / Cata / Mists
    -- - 29515 on Vanilla / SoD / TBC / Wrath
    local spellId = (Version:IsRetail() or Version:IsCata() or Version:IsMists()) and 61304 or 29515
    local cdInfo = WoWAPI.GetSpellCooldown(spellId)

    if not cdInfo then
        return 0
    end

    local start = cdInfo.startTime
    local duration = cdInfo.duration
    return max(0, min(duration, (start + duration - GetTime()))) -- RAKIZI: Changed 9/9/25 from GetTime() to NAG:NextTime() // REVERTED 9/15/25
end

--- Returns the last observed Global Cooldown (GCD) duration value in seconds.
--- When GCD is ready, GetSpellCooldown returns duration 0, so we cache the
--- last non-zero value and return it. Uses unified API and Classic/Retail IDs.
--- @function NAG:GCDTimeValue
--- @return number The last non-zero GCD duration in seconds (defaults to 1.5 if never observed)
--- @usage local gcdDuration = NAG:GCDTimeValue()
--- -- Use for timing calculations when GCD is not currently active
function NAG:GCDTimeValue()
    -- Default to 1.5s if never observed; kept up-to-date by event hooks
    self._lastGCDDuration = self._lastGCDDuration or 1.5
    return self._lastGCDDuration
end

--- Returns a debug snapshot of the raw GCD probe cooldown and computed remaining.
--- Useful for verifying "duration vs remaining" behavior on Classic/TBC clients.
--- @function NAG:GCDDebugSnapshot
--- @return table
function NAG:GCDDebugSnapshot()
    local spellId = (Version:IsRetail() or Version:IsCata() or Version:IsMists()) and 61304 or 29515
    local now = GetTime()
    local cdInfo = WoWAPI.GetSpellCooldown(spellId)
    local start = cdInfo and cdInfo.startTime or 0
    local duration = cdInfo and cdInfo.duration or 0
    local remaining = max(0, min(duration, (start + duration - now)))

    return {
        probeSpellId = spellId,
        now = now,
        start = start,
        duration = duration,
        remaining = remaining,
        gcdTimeToReady = self:GCDTimeToReady(),
        gcdTimeValue = self:GCDTimeValue(),
        lastGCDDuration = self._lastGCDDuration,
    }
end

-- Keep a live cache of the player's GCD duration by listening to cooldown/spellcast events
--- Updates the cached GCD duration if a non-zero duration is observed.
--- This function is called automatically by event handlers and should not be called manually.
--- @function NAG:UpdateGCDCache
--- @usage -- Called automatically by UNIT_SPELLCAST_SUCCEEDED event
--- @local Internal APL value manipulation function
function NAG:UpdateGCDCache()
    local spellId = (Version:IsRetail() or Version:IsCata() or Version:IsMists()) and 61304 or 29515
    local cdInfo = WoWAPI.GetSpellCooldown(spellId)

    if not cdInfo then return end

    local duration
    if type(cdInfo) == "table" then
        duration = cdInfo.duration
    else
        -- Raw API fallback: cdInfo is startTime (number), re-query for duration
        local _, dur = _G.GetSpellCooldown(spellId)
        duration = dur
    end

    if duration and duration > 0 then
        self._lastGCDDuration = duration
    end
end

NAG:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", function(_, unit)
    if unit == "player" then
        NAG:UpdateGCDCache()
    end
end)
