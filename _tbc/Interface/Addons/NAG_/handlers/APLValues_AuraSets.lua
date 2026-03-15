--- @module "APLValues_AuraSets"
--- APL Values and Actions for Aura Sets functionality in the NAG addon.
---
--- This module provides functions for checking and managing aura sets, including item stat procs,
--- trinket procs, stat buff cooldowns, and related APL values and actions.
--- Maps to apl_values_aura_sets.go in the Go simulation.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold
---

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ HEADER LOCALS ============================

-- Libraries
local L = ns.AceLocale:GetLocale("NAG", true)
local RC = ns.RC

-- ======= WoW API =======
local GetTime = _G.GetTime

local format = string.format
local min = math.min
local max = math.max

local wipe = wipe

local sort = table.sort
local concat = table.concat
local next = next

-- ============================ MODULE CACHING (PERFORMANCE) ============================
-- Cache frequently accessed modules to avoid GetModule overhead in hot paths
local Types = ns.Types
local TrinketTrackingManager = ns.TrinketTrackingManager
local StateManager = ns.StateManager

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~


-- ============================ UNIFIED STAT MATCHING HELPERS ============================

--- Normalize stat argument to number (supports strings like "str", "crit", etc.)
--- @param v any The stat argument to normalize
--- @return number|nil The normalized stat type number, or nil if invalid
local function normalizeStatArg(v)
    if v == nil or v == -1 then return nil end
    if type(v) == "number" then return v end
    if type(v) == "string" then
        if Types then
            local s = string.lower(v)
            local stat = Types:GetType("Stat")
            if stat then
                local map = {
                    str = stat.STRENGTH,
                    strength = stat.STRENGTH,
                    agi = stat.AGILITY,
                    agility = stat.AGILITY,
                    int = stat.INTELLECT,
                    intellect = stat.INTELLECT,
                    sta = stat.STAMINA,
                    stamina = stat.STAMINA,
                    haste = stat.HASTE,
                    crit = stat.CRIT,
                    mastery = stat.MASTERY,
                    ap = stat.ATTACK_POWER,
                    attack_power = stat.ATTACK_POWER,
                    sp = stat.SPELL_POWER,
                    spell_power = stat.SPELL_POWER,
                    hit = stat.HIT,
                    exp = stat.EXPERTISE,
                    expertise = stat.EXPERTISE
                }
                return map[s]
            end
        end
    end
    return nil
end

--- Add a stat to the requested stats table if valid
--- @param requested table The requested stats table
--- @param val any The stat value to add
local function addRequestedStat(requested, val)
    if val and val ~= -1 then requested[val] = true end
end

--- Check if trinket info matches any of the requested stats (unified stat matching)
--- @param info table The trinket info from TrinketTrackingManager
--- @param requested table Table of requested stat types (key=statType, value=true)
--- @return boolean True if trinket matches any requested stat
local function matchesRequestedStats(info, requested)
    if not requested or next(requested) == nil then return true end
    if not info then
        -- Info is nil, cannot match stats
        return false
    end
    local s1, s2, s3 = info.statType1, info.statType2, info.statType3
    -- Only check valid stat types (not -1 or nil)
    if s1 and s1 ~= -1 and requested[s1] then return true end
    if s2 and s2 ~= -1 and requested[s2] then return true end
    if s3 and s3 ~= -1 and requested[s3] then return true end
    return false
end

local CACHED_REQUESTED_STATS = {}

--- Unified stat matching function for all trinket functions
--- @param self NAG The NAG addon object
--- @param trinketId number The ID of the trinket to check
--- @param statType1? any First stat type to check (supports strings like "str", numbers, or nil)
--- @param statType2? any Second stat type to check (supports strings like "crit", numbers, or nil)
--- @param statType3? any Third stat type to check (supports strings like "haste", numbers, or nil)
--- @param minIcdSeconds? number Minimum internal cooldown required in seconds (optional)
--- @return boolean True if trinket matches any of the requested stat types
local function unifiedMatchesStatTypes(self, trinketId, statType1, statType2, statType3, minIcdSeconds)
    if not trinketId then
        self:Warn("unifiedMatchesStatTypes: trinketId is nil")
        return false
    end

    -- Normalize stat arguments
    local normalized1 = normalizeStatArg(statType1) or statType1
    local normalized2 = normalizeStatArg(statType2) or statType2
    local normalized3 = normalizeStatArg(statType3) or statType3

    -- PERFORMANCE: Reuse cached table instead of creating new one
    wipe(CACHED_REQUESTED_STATS)
    addRequestedStat(CACHED_REQUESTED_STATS, normalized1)
    addRequestedStat(CACHED_REQUESTED_STATS, normalized2)
    addRequestedStat(CACHED_REQUESTED_STATS, normalized3)

    -- Get trinket info from TrinketTrackingManager first (needed for ICD check)
    local trinketInfo = TrinketTrackingManager:GetTrinketInfo(trinketId)
    if not trinketInfo then
        return false
    end

    -- Check minimum ICD requirement if provided
    if minIcdSeconds and minIcdSeconds > 0 then
        if not trinketInfo.icd or trinketInfo.icd < minIcdSeconds then
            return false -- Filter out trinkets with low or no ICD
        end
    end

    -- If no valid stats requested, match any trinket (after ICD filtering)
    if not next(CACHED_REQUESTED_STATS) then
        return true
    end

    -- Use unified stat matching
    return matchesRequestedStats(trinketInfo, CACHED_REQUESTED_STATS)
end

local CACHED_MATCHING_TRINKETS = {}

--- Get trinket data from StateManager (no caching needed)
--- @param self NAG The NAG addon object
--- @param statType1? any First stat type to check
--- @param statType2? any Second stat type to check
--- @param statType3? any Third stat type to check
--- @param minIcdSeconds? number Minimum ICD threshold in seconds (optional)
--- @return table Trinket data with matching results
local function getTrinketData(self, statType1, statType2, statType3, minIcdSeconds)
    -- Get trinket data directly from StateManager
    local trinketData = StateManager:GetAllTrinketData()

    -- PERFORMANCE: Reuse cached table instead of creating new one
    wipe(CACHED_MATCHING_TRINKETS)
    local matchingTrinkets = CACHED_MATCHING_TRINKETS

    for slot = 13, 14 do
        local data = trinketData[slot]
        if data and data.trinketInfo then
            -- Check if trinket matches the requested stat types
            local matches = unifiedMatchesStatTypes(self, data.itemId, statType1, statType2, statType3, minIcdSeconds)

            if matches then
                matchingTrinkets[#matchingTrinkets + 1] = {
                    slot = slot,
                    itemId = data.itemId,
                    trinketInfo = data.trinketInfo
                }
            end
        end
    end

    return matchingTrinkets
end

--- Item Procs Max Remaining ICD
--- Longest remaining ICD on any inactive proc trinkets (not use trinkets) that buff the specified stat type(s), or 0 if all are currently active.
--- @param statType1? any First stat type to match (supports strings like "str", numbers, or nil)
--- @param statType2? any Second stat type to match (supports strings like "crit", numbers, or nil)
--- @param statType3? any Third stat type to match (supports strings like "haste", numbers, or nil)
--- @param minIcdSeconds? number Minimum ICD in seconds to consider (optional)
--- @return number The maximum remaining ICD time in seconds, or 0 if all matching proc trinkets are active
--- @usage local maxIcd = NAG:TrinketProcsMaxRemainingICD(Types:GetType("Stat").HASTE)
function NAG:TrinketProcsMaxRemainingICD(statType1, statType2, statType3, minIcdSeconds)
    local maxRemaining = 0

    -- Get trinket data directly from StateManager
    local matchingTrinkets = getTrinketData(self, statType1, statType2, statType3, minIcdSeconds)

    -- Process matching trinkets (only proc trinkets, not use trinkets)
    for _, trinketData in ipairs(matchingTrinkets) do
        local itemId = trinketData.itemId
        local trinketInfo = trinketData.trinketInfo

        -- Skip use trinkets - only check proc trinkets
        if trinketInfo and trinketInfo.procType == "use" then
            if self.debug then
                self:Debug(format("Skipping use trinket %d (procType=use)", itemId))
            end
        else
            -- If trinket has low ICD, filter it out entirely
            if not (trinketInfo and minIcdSeconds and trinketInfo.icd < minIcdSeconds) then
                -- Handle proc trinkets using unified StateManager data
                if trinketInfo and trinketInfo.buffId then
                    local remaining = TrinketTrackingManager:GetInternalCooldownRemaining(trinketInfo.buffId)
                    if remaining and remaining > 0 then
                        maxRemaining = math.max(maxRemaining, remaining)
                    end
                end
            end
        end
    end

    -- Return the maximum remaining ICD time
    -- If all matching trinkets are low-ICD (always active), maxRemaining will be 0
    return maxRemaining
end


--- Item Procs Min Remaining Time
--- Shortest remaining duration on any active proc trinkets (not use trinkets) that buff the specified stat type(s), or infinity if none are currently active.
--- @param statType1? any First stat type to check (supports strings like "str", numbers, or nil)
--- @param statType2? any Second stat type to check (supports strings like "crit", numbers, or nil)
--- @param statType3? any Third stat type to check (supports strings like "haste", numbers, or nil)
--- @param minIcdSeconds? number Minimum ICD in seconds to consider (optional)
--- @return number Minimum remaining time among matching proc trinkets, or 999 if none are currently active
--- @usage local minTime = NAG:TrinketProcsMinRemainingTime(Types:GetType("Stat").HASTE)
function NAG:TrinketProcsMinRemainingTime(statType1, statType2, statType3, minIcdSeconds)
    local minTime = math.huge

    -- Get trinket data directly from StateManager
    local matchingTrinkets = getTrinketData(self, statType1, statType2, statType3, minIcdSeconds)

    -- Process matching trinkets (only proc trinkets, not use trinkets)
    for _, trinketData in ipairs(matchingTrinkets) do
        local itemId = trinketData.itemId
        local trinketInfo = trinketData.trinketInfo

        -- Skip use trinkets - only check proc trinkets
        if not (trinketInfo and trinketInfo.procType == "use") then
            -- Handle proc trinkets using unified StateManager data
            if trinketInfo and trinketInfo.buffId then
                local aura = NAG:UnitAura("player", trinketInfo.buffId)
                if aura then
                    local expirationTime = aura.expirationTime
                    if expirationTime then
                        local remainingTime = expirationTime - NAG:NextTime()                                        -- RAKIZI: Changed 9/9/25 from GetTime() to NAG:NextTime()
                        if remainingTime > 0 then
                            minTime = math.min(minTime, remainingTime)
                        end
                    end
                end
            end
        end
    end

    -- Return the minimum remaining time, or 999 if none found
    local result = minTime == math.huge and 999 or minTime
    return result
end

--- Checks if any proc trinket that matches the requested stat types is currently available to trigger.
--- Availability is defined as the proc aura being inactive while the internal cooldown is ready.
--- @param statType1? any First stat type to check (supports strings, numbers, or nil)
--- @param statType2? any Second stat type to check (supports strings, numbers, or nil)
--- @param statType3? any Third stat type to check (supports strings, numbers, or nil)
--- @param minIcdSeconds? number Minimum ICD threshold in seconds (optional)
--- @return boolean True if any matching proc trinket can proc immediately
--- @usage if NAG:AnyTrinketStatProcsAvailable(Types:GetType("Stat").HASTE) then ... end
function NAG:AnyTrinketStatProcsAvailable(statType1, statType2, statType3, minIcdSeconds)

    local matchingTrinkets = getTrinketData(self, statType1, statType2, statType3, minIcdSeconds)
    if #matchingTrinkets == 0 then
        return false
    end

    -- TrinketTrackingManager already cached at top of file

    for _, trinketData in ipairs(matchingTrinkets) do
        local trinketInfo = trinketData.trinketInfo

        -- Only consider proc trinkets
        if trinketInfo and trinketInfo.procType ~= "use" and trinketInfo.buffId then
            local auraActive = self:AuraIsActive(trinketInfo.buffId)

            local icdReady = true
            if TrinketTrackingManager and TrinketTrackingManager.GetInternalCooldownRemaining then
                local remaining = TrinketTrackingManager:GetInternalCooldownRemaining(trinketInfo.buffId)
                icdReady = not remaining or remaining <= 0
            end

            if not auraActive and icdReady then
                return true
            end
        end
    end

    return false
end

--- Num Equipped Stat Proc Effects
--- Number of equipped passive item/enchant effects that buff the specified stat type(s) when they proc.
--- @param statType1? any First stat type to check (supports strings like "str", numbers, or nil)
--- @param statType2? any Second stat type to check (supports strings like "crit", numbers, or nil)
--- @param statType3? any Third stat type to check (supports strings like "haste", numbers, or nil)
--- @param minIcdSeconds? number Minimum ICD threshold in seconds (defaults to 0)
--- @return number Number of matching equipped trinkets
--- @usage local count = NAG:NumEquippedStatProcTrinkets(Types:GetType("Stat").HASTE)
function NAG:NumEquippedStatProcTrinkets(statType1, statType2, statType3, minIcdSeconds)
    local count = 0
    minIcdSeconds = minIcdSeconds or 0 -- default to 0 if not provided

    -- Get trinket data directly from StateManager
    local matchingTrinkets = getTrinketData(self, statType1, statType2, statType3, minIcdSeconds)

    -- Process matching trinkets
    for _, trinketData in ipairs(matchingTrinkets) do
        local itemId = trinketData.itemId
        local trinketInfo = trinketData.trinketInfo

        -- Only count PROC trinkets, not USE trinkets
        local isProcTrinket = trinketInfo and trinketInfo.procType == "proc"

        if isProcTrinket then
            -- Check minimum ICD requirement if provided
            if not (minIcdSeconds and trinketInfo and trinketInfo.icd and trinketInfo.icd < minIcdSeconds) then
                count = count + 1
            end
        end
    end

    return count
end

--- All Item Proc Buffs Active
--- True if all proc trinkets (not use trinkets) that buff the specified stat type(s) are currently active, otherwise False. For stacking proc buffs, this condition also checks that the buff has been stacked to its maximum possible strength.
--- @param statType1? any First stat type to check (supports strings like "str", numbers, or nil)
--- @param statType2? any Second stat type to check (supports strings like "crit", numbers, or nil)
--- @param statType3? any Third stat type to check (supports strings like "haste", numbers, or nil)
--- @param minIcdSeconds? number Minimum ICD threshold in seconds (defaults to 0)
--- @return boolean True if all matching proc trinkets have active procs, or if none are registered
--- @usage local allActive = NAG:AllTrinketStatProcsActive(Types:GetType("Stat").HASTE)
function NAG:AllTrinketStatProcsActive(statType1, statType2, statType3, minIcdSeconds)
    minIcdSeconds = minIcdSeconds or 0 -- default to 0 if not provided

    -- Get trinket data directly from StateManager
    local matchingTrinkets = getTrinketData(self, statType1, statType2, statType3, minIcdSeconds)

    local matchingCount = 0
    local activeCount = 0
    local hasRegisteredTrinkets = false

    -- Process matching trinkets (only proc trinkets, not use trinkets)
    for _, trinketData in ipairs(matchingTrinkets) do
        local itemId = trinketData.itemId
        local trinketInfo = trinketData.trinketInfo

        -- Skip use trinkets - only check proc trinkets
        if trinketInfo and trinketInfo.procType == "use" then
            if self.debug then
                self:Debug(format("Skipping use trinket %d (procType=use)", itemId))
            end
        else
            -- Track if we have any registered proc trinkets
            if trinketInfo then
                hasRegisteredTrinkets = true
            end

            matchingCount = matchingCount + 1
            local isActive = false

            -- If trinket has low ICD, filter it out entirely
            if not (trinketInfo and minIcdSeconds and trinketInfo.icd < minIcdSeconds) then
                -- Check trinket buff using unified StateManager data
                if trinketInfo and trinketInfo.buffId then
                    local aura = NAG:UnitAura("player", trinketInfo.buffId)
                    if aura then
                        local expirationTime = aura.expirationTime
                        if expirationTime and (expirationTime - NAG:NextTime()) > 0 then -- RAKIZI: Changed 9/9/25 from GetTime() to NAG:NextTime()
                            -- Check if this is a stacking buff and if it's at maximum stacks
                            local count = aura.count
                            if count and count >= (trinketInfo.stacks or 1) then
                                isActive = true
                            elseif not count or count == 0 then
                                -- Non-stacking buff, just check if active
                                isActive = true
                            end
                        end
                    end
                end
            end

            if isActive then
                activeCount = activeCount + 1
            end
        end
    end

    -- If we have no registered trinkets at all, return true to avoid blocking actions
    if not hasRegisteredTrinkets then
        return true
    end

    local result = activeCount >= matchingCount
    return result
end

--- Any Item Proc Buff Active
--- True if any proc trinkets (not use trinkets) that buff the specified stat type(s) are currently active, otherwise False. For stacking proc buffs, this condition also checks that the buff has been stacked to its maximum possible strength.
--- @param statType1? any First stat type to check (supports strings like "str", numbers, or nil)
--- @param statType2? any Second stat type to check (supports strings like "crit", numbers, or nil)
--- @param statType3? any Third stat type to check (supports strings like "haste", numbers, or nil)
--- @param minIcdSeconds? number Minimum ICD threshold in seconds (defaults to 0)
--- @return boolean True if any matching proc trinket has an active proc
--- @usage local anyActive = NAG:AnyTrinketStatProcsActive(Types:GetType("Stat").HASTE)
function NAG:AnyTrinketStatProcsActive(statType1, statType2, statType3, minIcdSeconds)
    minIcdSeconds = minIcdSeconds or 0 -- default to 0 if not provided

    -- Get trinket data directly from StateManager
    local matchingTrinkets = getTrinketData(self, statType1, statType2, statType3, minIcdSeconds)


    -- Process matching trinkets (only proc trinkets, not use trinkets)
    for _, trinketData in ipairs(matchingTrinkets) do
        local itemId = trinketData.itemId
        local trinketInfo = trinketData.trinketInfo

        -- Skip use trinkets - only check proc trinkets
        if not (trinketInfo and trinketInfo.procType == "use") then
            -- Check if trinket has low ICD
            if not (trinketInfo and minIcdSeconds and trinketInfo.icd and trinketInfo.icd < minIcdSeconds) then
                -- Check if the proc trinket's buff is currently active
                local isActive = false

                if trinketInfo and trinketInfo.buffId then
                    isActive = self:AuraIsActive(trinketInfo.buffId)

                    if isActive then
                        -- Check if this is a stacking buff and if it's at maximum stacks
                        local aura = NAG:UnitAura("player", trinketInfo.buffId)
                        if aura then
                            local expirationTime = aura.expirationTime
                            if expirationTime and (expirationTime - NAG:NextTime()) > 0 then -- RAKIZI: Changed 9/9/25 from GetTime() to NAG:NextTime()
                                local count = aura.count
                                if count and count >= (trinketInfo.stacks or 1) then
                                    return true
                                elseif not count or count == 0 then
                                    -- Non-stacking buff, just check if active
                                    return true
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    return false
end

--- Any Stat Buff Cooldowns Active
--- True if any use trinkets (Major Cooldowns) that buff the specified stat type(s) are currently active, otherwise False. For stacking buffs, this condition also checks that the buff has been stacked to its maximum possible strength after the cooldown is activated. Both manually casted cooldowns as well as cooldowns controlled by "Cast All Stat Buff Cooldowns" and "Autocast Other Cooldowns" actions are checked.
--- @param statType1? any First stat type to check (supports strings like "str", numbers, or nil)
--- @param statType2? any Second stat type to check (supports strings like "crit", numbers, or nil)
--- @param statType3? any Third stat type to check (supports strings like "haste", numbers, or nil)
--- @return boolean True if any matching use trinket cooldowns are active
--- @usage local anyActive = NAG:AnyStatBuffCooldownsActive(Types:GetType("Stat").HASTE)
function NAG:AnyStatBuffCooldownsActive(statType1, statType2, statType3)


    -- Get trinket data directly from StateManager
    local matchingTrinkets = getTrinketData(self, statType1, statType2, statType3, nil)


    -- Process matching trinkets (only use trinkets, not proc trinkets)
    for _, trinketData in ipairs(matchingTrinkets) do
        local itemId = trinketData.itemId
        local trinketInfo = trinketData.trinketInfo

        -- Only check use trinkets - skip proc trinkets
        if trinketInfo and trinketInfo.procType == "use" then
            -- Check if the use trinket's buff is currently active
            if trinketInfo and trinketInfo.buffId then
                local isActive = self:AuraIsActive(trinketInfo.buffId)

                if isActive then
                    -- Check if this is a stacking buff and if it's at maximum stacks
                    local aura = NAG:UnitAura("player", trinketInfo.buffId)
                    if aura then
                        local expirationTime = aura.expirationTime
                        if expirationTime and (expirationTime - NAG:NextTime()) > 0 then -- RAKIZI: Changed 9/9/25 from GetTime() to NAG:NextTime()
                            local count = aura.count
                            if count and count >= (trinketInfo.stacks or 1) then
                                return true
                            elseif not count or count == 0 then
                                -- Non-stacking buff, just check if active
                                return true
                            end
                        end
                    end
                end
            end
        end
    end

    return false
end

--- Gets the minimum remaining duration among active stat buff cooldowns (use trinkets) for the requested stat types.
--- Returns 999 when no matching cooldown buffs are currently active to mirror simulator behavior.
--- @param statType1? any First stat type to check (supports strings, numbers, or nil)
--- @param statType2? any Second stat type to check (supports strings, numbers, or nil)
--- @param statType3? any Third stat type to check (supports strings, numbers, or nil)
--- @return number Minimum remaining duration in seconds, or 999 if none are active
--- @usage local minDuration = NAG:AnyStatBuffCooldownsMinDuration(Types:GetType("Stat").HASTE)
function NAG:AnyStatBuffCooldownsMinDuration(statType1, statType2, statType3)

    local matchingTrinkets = getTrinketData(self, statType1, statType2, statType3, nil)
    local currentTime = NAG:NextTime()
    local minRemaining = math.huge

    for _, trinketData in ipairs(matchingTrinkets) do
        local trinketInfo = trinketData.trinketInfo

        if trinketInfo and trinketInfo.procType == "use" and trinketInfo.buffId then
            local aura = NAG:UnitAura("player", trinketInfo.buffId)
            if aura then
                local expirationTime = aura.expirationTime
                if expirationTime and expirationTime > currentTime then
                    local stacks = aura.count
                    if not stacks or stacks >= (trinketInfo.stacks or 1) then
                        local remaining = expirationTime - currentTime
                        if remaining > 0 then
                            minRemaining = math.min(minRemaining, remaining)
                        end
                    end
                end
            end
        end
    end

    if minRemaining == math.huge then
        return 999
    end

    return minRemaining
end

--- Num Stat Buff Cooldowns
--- Number of registered Major Cooldowns that buff the specified stat type(s) when they are cast. Both manually casted cooldowns as well as cooldowns controlled by "Cast All Stat Buff Cooldowns" and "Autocast Other Cooldowns" actions are included in the total count returned by this value.
--- NOTE: Currently only counts equipped OnUse trinkets (major cooldowns not yet implemented)
--- @param statType1? any First stat type to check (supports strings like "str", numbers, or nil)
--- @param statType2? any Second stat type to check (supports strings like "crit", numbers, or nil)
--- @param statType3? any Third stat type to check (supports strings like "haste", numbers, or nil)
--- @return number Number of equipped OnUse trinkets that provide matching stat buffs
--- @usage local numBuffs = NAG:NumStatBuffCooldowns(Types:GetType("Stat").HASTE)
function NAG:NumStatBuffCooldowns(statType1, statType2, statType3)
    local count = 0

    -- Get trinket data directly from StateManager
    local matchingTrinkets = getTrinketData(self, statType1, statType2, statType3, nil)

    -- Process matching trinkets
    for _, trinketData in ipairs(matchingTrinkets) do
        local itemId = trinketData.itemId
        local trinketInfo = trinketData.trinketInfo

        -- Only count USE trinkets, not PROC trinkets
        local isUseTrinket = trinketInfo and trinketInfo.procType == "use"

        if isUseTrinket then
            count = count + 1
        end
    end

    return count
end

--- Casts all available stat buff cooldowns that match the given stat types.
--- Attempts to cast all on-use trinket cooldowns that match the specified stat types. (Currently a stub, always returns true.)
