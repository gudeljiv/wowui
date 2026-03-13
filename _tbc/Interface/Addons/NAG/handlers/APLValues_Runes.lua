--- @module "APLValues_Runes"
--- Rune-related APL value functions for the NAG addon
---
--- This module provides utility functions for rune management, rune timing, and rune-based conditions.
---
--- Rune Grace Mechanic (Blizzard): When a READY rune is used in combat, idle time (up to 2.47s) is
--- subtracted from the new cooldown. Example: Rune ready for 0.5s → cooldown = 10 - 0.5 = 9.5s.
--- Maximum benefit: ~7.5s cooldown (10 - 2.47) when used immediately after becoming ready.
---
--- RuneGrace/RuneSlotGrace Functions: Measure idle time since rune regeneration (lastRegenTime),
--- matching wowsims-wotlk logic: grace = min(2500ms, currentTime - lastRegenTime).
--- lastRegenTime is tracked when runes transition from cooldown to ready (RUNE_POWER_UPDATE).
--- For runes on cooldown or pre-pull, returns 0. Same logic applies to WotLK (parallel regen
--- per type) and MoP (sequential regen).
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

-- Module references
local Types = ns.Types

-- Lua APIs (WoW optimized where available)
local format = string.format
local min = math.min
local max = math.max

-- WoW API localizations
local GetRuneType = _G.GetRuneType
local GetRuneCooldown = _G.GetRuneCooldown
local GetCombatRatingBonus = _G.GetCombatRatingBonus


local tostring = tostring

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

-- ============================ MODULE REFERENCE CACHING ============================
-- Initialize rune type references
local RuneType = Types and Types:GetType("RuneType")
local RuneSlot = Types and Types:GetType("RuneSlot")

-- ============================ RUNE GRACE STATE TRACKING ============================
-- Track when each rune last regenerated (became ready) to calculate idle time for grace period
-- Matches wowsims-wotlk logic: grace = min(2500ms, currentTime - lastRegenTime)
-- lastRegenTime is when the rune became ready (regenerated)
local lastRegenTimes = {} -- [slot] = timestamp when rune last regenerated (became ready)
local runeTrackingInitialized = false

-- Create a frame to track RUNE_POWER_UPDATE events (lazy initialization)
local runeTrackingFrame = nil

-- Initialize rune tracking frame and current state (lazy)
local function InitializeRuneTracking()
    if runeTrackingInitialized then return end
    
    -- Check if StateManager is available (required for NAG:NextTime())
    if not NAG:GetModule("StateManager") then
        return -- Not ready yet, will retry on next call
    end
    
    runeTrackingInitialized = true
    
    -- Track previous rune states to detect when they become ready
    local previousRuneStates = {} -- [slot] = wasReady (boolean)
    
    -- Create frame to track RUNE_POWER_UPDATE events
    runeTrackingFrame = CreateFrame("Frame")
    runeTrackingFrame:RegisterEvent("RUNE_POWER_UPDATE")
    runeTrackingFrame:SetScript("OnEvent", function(self, event, runeIndex)
        if event == "RUNE_POWER_UPDATE" then
            local currentTime = NAG:NextTime()
            
            if runeIndex then
                -- Update specific rune
                local _, _, runeReady = GetRuneCooldown(runeIndex)
                local wasReady = previousRuneStates[runeIndex] or false
                
                if runeReady and not wasReady then
                    -- Rune just became ready: store regeneration time
                    lastRegenTimes[runeIndex] = currentTime
                elseif not runeReady and wasReady then
                    -- Rune was spent: clear regeneration time
                    lastRegenTimes[runeIndex] = nil
                end
                
                previousRuneStates[runeIndex] = runeReady
            else
                -- Update all runes
                for i = 1, 6 do
                    local _, _, runeReady = GetRuneCooldown(i)
                    local wasReady = previousRuneStates[i] or false
                    
                    if runeReady and not wasReady then
                        -- Rune just became ready: store regeneration time
                        lastRegenTimes[i] = currentTime
                    elseif not runeReady and wasReady then
                        -- Rune was spent: clear regeneration time
                        lastRegenTimes[i] = nil
                    end
                    
                    previousRuneStates[i] = runeReady
                end
            end
        end
    end)
    
    -- Initialize current state: check which runes are ready and set lastRegenTime
    local currentTime = NAG:NextTime()
    for i = 1, 6 do
        local start, duration, runeReady = GetRuneCooldown(i)
        if start and duration and runeReady then
            -- Rune is ready: try to determine when it became ready
            local readyTime = start + duration
            -- Only use readyTime if it's recent (within last 10s) to avoid stale data
            if readyTime > currentTime - 10 and readyTime <= currentTime then
                lastRegenTimes[i] = readyTime
            else
                -- Use current time as fallback (rune has been ready for a while)
                lastRegenTimes[i] = currentTime
            end
            previousRuneStates[i] = true
        else
            previousRuneStates[i] = false
        end
    end
end

--- Returns the current count of active runes of a specific type.
--- Handles Blood, Frost, Unholy, and Death runes with specialized logic for each type.
--- @function NAG:CurrentRuneCount
--- @param runeType number The type of rune to count (1=Blood, 2=Frost, 3=Unholy, 4=Death)
--- @usage NAG:CurrentRuneCount(runeType) >= x
--- @return number The number of active runes of the specified type, or 0 if the player is not a Death Knight.
function NAG:CurrentRuneCount(runeType)
    if not runeType then return 0 end
    if self.CLASS_FILENAME ~= "DEATHKNIGHT" then return 0 end

    -- Cache Types module to avoid expensive GetModule calls (called 50+ times/rotation)
    if not Types or not RuneType or not RuneSlot then return 0 end

    local total = 0

    -- Handle Death runes separately (original behavior)
    if runeType == RuneType.RuneDeath then
        for i = 1, 6 do
            local rt = GetRuneType(i)
            if rt == RuneType.RuneDeath and self:CurrentRuneActive(i) then
                total = total + 1
            end
        end
        return total
    end

    -- Handle Blood runes - check only blood slots
    if runeType == RuneType.RuneBlood then
        if self:CurrentRuneActive(RuneSlot.SlotLeftBlood) then
            total = total + 1
        end
        if self:CurrentRuneActive(RuneSlot.SlotRightBlood) then
            total = total + 1
        end
        return total
    end

    -- Handle Frost runes - check only frost slots
    if runeType == RuneType.RuneFrost then
        if self:CurrentRuneActive(RuneSlot.SlotLeftFrost) then
            total = total + 1
        end
        if self:CurrentRuneActive(RuneSlot.SlotRightFrost) then
            total = total + 1
        end
        return total
    end

    -- Handle Unholy runes - check only unholy slots
    if runeType == RuneType.RuneUnholy then
        if self:CurrentRuneActive(RuneSlot.SlotLeftUnholy) then
            total = total + 1
        end
        if self:CurrentRuneActive(RuneSlot.SlotRightUnholy) then
            total = total + 1
        end
        return total
    end

    -- Default case for unknown rune types
    for i = 1, 6 do
        local rt = GetRuneType(i)
        if rt == runeType and self:CurrentRuneActive(i) then
            total = total + 1
        end
    end
    return total
end

--- Returns the number of non-death runes of a specific type that are ready.
--- @function NAG:CurrentNonDeathRuneCount
--- @param runeType number The type of rune to count (1=Blood, 2=Frost, 3=Unholy)
--- @usage NAG:CurrentNonDeathRuneCount(runeType) >= x
--- @return number The number of non-death runes of the specified type that are ready, or 0 if the player is not a Death Knight.
function NAG:CurrentNonDeathRuneCount(runeType)
    if not runeType then
        self:Error("CurrentNonDeathRuneCount called with nil runeType")
        return 0
    end
    if self.CLASS_FILENAME ~= "DEATHKNIGHT" then
        self:Warn("CurrentNonDeathRuneCount called by non-Death Knight class")
        return 0
    end

    -- No Types module needed for this function
    local total = 0
    for i = 1, 6 do
        if GetRuneType(i) == runeType and self:RuneReady(i) then
            total = total + 1
        end
    end
    return total
end

--- Checks if a specific rune slot contains a death rune.
--- @function NAG:CurrentRuneDeath
--- @param runeSlot number The rune slot to check (1-6)
--- @usage NAG:CurrentRuneDeath(runeSlot)
--- @return boolean True if the rune slot contains a death rune, false otherwise.
function NAG:CurrentRuneDeath(runeSlot)
    if not runeSlot then
        self:Error("CurrentRuneDeath called with nil runeSlot")
        return false
    end
    if self.CLASS_FILENAME ~= "DEATHKNIGHT" then
        return false  -- String allocation removed from ultra-hot path
    end

    if not Types or not RuneType then return false end

    return (GetRuneType(runeSlot) == RuneType.RuneDeath)
end

--- Checks if a specific rune slot is active (not on cooldown).
--- @function NAG:CurrentRuneActive
--- @param runeSlot number The rune slot to check (1-6)
--- @usage NAG:CurrentRuneActive(runeSlot)
--- @return boolean True if the rune slot is active, false otherwise.
function NAG:CurrentRuneActive(runeSlot)
    if not runeSlot then
        self:Error("CurrentRuneActive called with nil runeSlot")
        return false
    end
    if self.CLASS_FILENAME ~= "DEATHKNIGHT" then
        return false  -- String allocation removed from ultra-hot path
    end
    local active = select(3, GetRuneCooldown(runeSlot))
    return active
end

--- Checks if a specific rune is ready (cooldown has finished).
--- @function NAG:RuneReady
--- @param index number The index of the rune to check (1-6)
--- @usage NAG:RuneReady(index)
--- @return boolean True if the rune is ready, false otherwise.
--- @local This function is used to check if a specific rune is ready (cooldown has finished).
function NAG:RuneReady(index)
    if not index then
        self:Error("RuneReady called with nil index")
        return false
    end
    if self.CLASS_FILENAME ~= "DEATHKNIGHT" then
        return false  -- String allocation removed from ultra-hot path
    end
    local start, duration = GetRuneCooldown(index)
    if not start or not duration then
        return false -- Data unavailable; assume not ready
    end
    return start + duration <= NAG:NextTime()
end

--- Returns the number of runes of a specific type that are ready.
--- @function NAG:NumRunes
--- @param runeType number The type of rune to count (1=Blood, 2=Frost, 3=Unholy, 4=Death)
--- @usage NAG:NumRunes(runeType) > 0
--- @return number The number of runes of the specified type that are ready, or 0 if the player is not a Death Knight.
function NAG:NumRunes(runeType)
    if not runeType then
        self:Error("NumRunes called with nil runeType")
        return 0
    end
    if self.CLASS_FILENAME ~= "DEATHKNIGHT" then
        self:Warn("NumRunes called by non-Death Knight class")
        return 0
    end
    local total = 0
    for i = 1, 6 do
        local rt = GetRuneType(i)
        if (rt == runeType) and self:RuneReady(i) then --removed or rt == Types:GetType("RuneType").RuneDeath
            total = total + 1
        end
    end
    return total
end

--- Returns the highest cooldown time among runes of a specific type.
--- @function NAG:NextRuneCooldown
--- @param runeType number The type of rune to check (1=Blood, 2=Frost, 3=Unholy, 4=Death)
--- @usage NAG:NextRuneCooldown(runeType) <= x
--- @return number The highest cooldown time among runes of the specified type, or 0 if the player is not a Death Knight.
function NAG:NextRuneCooldown(runeType)
    if not runeType then
        self:Error("NextRuneCooldown called with nil runeType")
        return 0
    end
    if self.CLASS_FILENAME ~= "DEATHKNIGHT" then
        return 0  -- String allocation removed from ultra-hot path
    end
    local highestCooldown = 0

    for i = 1, 6 do
        local rt = GetRuneType(i)
        if rt == runeType then
            local start, duration = GetRuneCooldown(i)
            if not start or not duration then
                return 0 -- Treat missing data as ready
            end
            local currentCooldown = max(0, start + duration - NAG:NextTime())
            -- Update highestCooldown if this rune has a higher cooldown
            highestCooldown = max(highestCooldown, currentCooldown)
        end
    end

    return highestCooldown
end


--- Returns the lowest cooldown time among runes of a specific type.
--- Maps rune types to specific slots: 1=Blood(slots 1,2), 2=Frost(slots 5,6), 3=Unholy(slots 3,4), 4=All slots.
--- @function NAG:RuneCooldown
--- @param runeType number The type of rune to check (1=Blood, 2=Frost, 3=Unholy, 4=All slots)
--- @usage NAG:RuneCooldown(runeType) <= x
--- @return number The lowest cooldown time among runes of the specified type, or 0 if the player is not a Death Knight.
function NAG:RuneCooldown(runeType)
    if not runeType or runeType < 1 or runeType > 4 then
        self:Error("RuneCooldown called with invalid runeType: %s", tostring(runeType))
        return 0
    end
    if self.CLASS_FILENAME ~= "DEATHKNIGHT" then
        return 0  -- String allocation removed from ultra-hot path
    end

    local lowestCooldown = 999999 -- Start with a high number to find lowest

    -- Local function to check a single slot and update lowestCooldown
    local function checkSlot(slot)
        local rt = GetRuneType(slot)
        -- For type 4, only process if the rune is actually type 4
        -- For types 1-3, process all runes in their designated slots
        if runeType == 4 and rt == 4 or runeType ~= 4 then
            local start, duration = GetRuneCooldown(slot)
            if not start or not duration then
                return 0 -- Missing data; treat as ready to avoid blocking
            end
            local currentCooldown = max(0, start + duration - NAG:NextTime())
            -- If we found a ready rune, return 0 immediately
            if currentCooldown == 0 then
                return 0
            end
            -- Update lowestCooldown if this rune has a lower cooldown
            lowestCooldown = min(lowestCooldown, currentCooldown)
        end
        return nil -- Continue checking
    end

    -- Check slots directly based on runeType (no intermediate table needed)
    if runeType == 4 then
        -- Check all slots for death runes
        for slot = 1, 6 do
            local result = checkSlot(slot)
            if result == 0 then return 0 end
        end
    elseif runeType == 1 then
        -- Check blood slots
        for slot = 1, 2 do
            local result = checkSlot(slot)
            if result == 0 then return 0 end
        end
    elseif runeType == 2 then
        -- Check frost slots
        for slot = 5, 6 do
            local result = checkSlot(slot)
            if result == 0 then return 0 end
        end
    else -- runeType == 3
        -- Check unholy slots
        for slot = 3, 4 do
            local result = checkSlot(slot)
            if result == 0 then return 0 end
        end
    end

    -- If lowestCooldown wasn't changed, no matching runes were found
    if lowestCooldown == 999999 then
        return 0
    end

    return lowestCooldown
end

--- Returns the cooldown time for a specific rune slot.
--- @function NAG:RuneSlotCooldown
--- @param runeSlot number The rune slot to check (1-6)
--- @usage NAG:RuneSlotCooldown(runeSlot) <= x
--- @return number The cooldown time for the specified rune slot, or 0 if the player is not a Death Knight.
function NAG:RuneSlotCooldown(runeSlot)
    if not runeSlot then return 0 end
    if self.CLASS_FILENAME ~= "DEATHKNIGHT" then return 0 end
    local start, duration, runeReady = GetRuneCooldown(runeSlot)
    -- Add nil checks
    if not start or not duration then
        return 0 -- Return 0 if the data is temporarily unavailable
    end
    if runeReady then
        return 0
    elseif start and duration then
        return max(0, (start + duration) - NAG:NextTime())
    else
        return 0
    end
end

--- Returns the full rune cooldown duration, taking haste into account unless base value requested.
--- @param useBaseValue boolean|nil When true, returns the unmodified baseline cooldown
--- @return number The rune cooldown duration in seconds
function NAG:FullRuneCooldown(useBaseValue)
    if self.CLASS_FILENAME ~= "DEATHKNIGHT" then
        return 0
    end

    local baseCooldown = 10 -- Base rune cooldown in seconds
    if useBaseValue then
        return baseCooldown
    end

    local ratingBonus = GetCombatRatingBonus(CR_HASTE_MELEE or 18) or 0

    local multiplier = 1 + (ratingBonus / 100)
    if multiplier <= 0 then
        multiplier = 1
    end

    return baseCooldown / multiplier
end

--- Returns the grace period for a specific rune type.
--- Matches wowsims-wotlk logic: grace = min(2500ms, currentTime - lastRegenTime)
--- Measures idle time since rune regeneration (lastRegenTime) for ready runes, capped at 2.5s.
--- When a ready rune is used, idle time (up to 2.47s) is subtracted from the new cooldown.
--- Returns maximum grace among all ready runes of this type. For runes on cooldown or pre-pull, returns 0.
--- @function NAG:RuneGrace
--- @param runeType number The type of rune to check (1=Blood, 2=Frost, 3=Unholy, 4=Death)
--- @usage NAG:RuneGrace(runeType) <= x
--- @return number The maximum grace period of any ready rune of this type (capped at 2.5s), or 0 if none are ready or player is not a Death Knight.
--- @local This function is used to get the grace period for a specific rune type.
function NAG:RuneGrace(runeType)
    if not runeType then return 0 end
    if self.CLASS_FILENAME ~= "DEATHKNIGHT" then return 0 end
    
    -- Lazy initialize tracking (only when function is called)
    InitializeRuneTracking()
    
    local maxGrace = 0
    local currentTime = NAG:NextTime()
    
    for i = 1, 6 do
        local rt = GetRuneType(i)
        if rt == runeType then
            local start, duration, runeReady = GetRuneCooldown(i)
            if start and duration then
                if runeReady then
                    -- Rune is ready: calculate grace period (idle time since regeneration)
                    -- Matches wowsims-wotlk: grace = min(2500ms, currentTime - lastRegenTime)
                    local lastRegenTime = lastRegenTimes[i]
                    
                    -- If we don't have tracked data, try to use GetRuneCooldown() as fallback
                    if not lastRegenTime or lastRegenTime <= 0 then
                        local readyTime = start + duration
                        -- Only use if it's recent (within last 10s) to avoid stale data
                        if readyTime > currentTime - 10 and readyTime <= currentTime then
                            lastRegenTime = readyTime
                            lastRegenTimes[i] = readyTime -- Store for future use
                        end
                    end
                    
                    -- Pre-pull casts should not get rune-grace (matches wowsims logic)
                    if lastRegenTime and lastRegenTime > 0 and lastRegenTime < currentTime then
                        local grace = min(2.5, currentTime - lastRegenTime)
                        maxGrace = max(maxGrace, grace)
                    end
                end
                -- Note: Don't clear lastRegenTime when rune is spent - it persists until next regen (matches wowsims)
            end
        end
    end
    
    return max(maxGrace, 0)
end

--- Returns the grace period for a specific rune slot.
--- Matches wowsims-wotlk logic: grace = min(2500ms, currentTime - lastRegenTime)
--- Measures idle time since rune regeneration (lastRegenTime) for ready runes, capped at 2.5s.
--- When a ready rune is used, idle time (up to 2.47s) is subtracted from the new cooldown.
--- For runes on cooldown or pre-pull, returns 0 (no grace available until ready).
--- @function NAG:RuneSlotGrace
--- @param runeSlot number The rune slot to check (1-6)
--- @usage NAG:RuneSlotGrace(runeSlot) <= x
--- @return number The grace period of this slot's rune if ready (capped at 2.5s), or 0 if on cooldown or player is not a Death Knight.
--- @local This function is used to get the grace period for a specific rune slot.
function NAG:RuneSlotGrace(runeSlot)
    if not runeSlot then return 0 end
    if self.CLASS_FILENAME ~= "DEATHKNIGHT" then return 0 end
    
    -- Lazy initialize tracking (only when function is called)
    InitializeRuneTracking()
    
    local start, duration, runeReady = GetRuneCooldown(runeSlot)
    if not start or not duration then
        return 0
    end
    
    if runeReady then
        -- Rune is ready: calculate grace period (idle time since regeneration)
        -- Matches wowsims-wotlk: grace = min(2500ms, currentTime - lastRegenTime)
        local currentTime = NAG:NextTime()
        local lastRegenTime = lastRegenTimes[runeSlot]
        
        -- Pre-pull casts should not get rune-grace (matches wowsims logic)
        if currentTime <= 0 or not lastRegenTime or lastRegenTime <= 0 then
            return 0
        end
        
        if lastRegenTime < currentTime then
            -- Calculate grace: how long since the rune regenerated, capped at 2.5s
            local grace = min(2.5, currentTime - lastRegenTime)
            return max(0, grace)
        end
        
        return 0
    else
        -- Rune is on cooldown: no grace available (don't clear lastRegenTime - it persists until next regen)
        return 0
    end
end
