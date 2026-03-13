--- @module "APLDRW"
--- Dancing Rune Weapon (DRW) tracking system for Death Knight
---
--- This module provides tracking for DRW summons, debuffs, and expiration for the NAG addon.
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

-- Lua APIs (WoW optimized where available)
local GetTime = _G.GetTime
local UnitExists = _G.UnitExists
local UnitGUID = _G.UnitGUID
local UnitCanAttack = _G.UnitCanAttack
local CreateFrame = _G.CreateFrame


local format = string.format
local min = math.min
local max = math.max

local wipe = wipe
local tContains = tContains

local sort = table.sort
local concat = table.concat
local type = type

-- ============================ MODULE CACHING (PERFORMANCE) ============================
-- Cache frequently accessed modules to avoid GetModule overhead in hot paths
local TTDManager = ns.TTDManager

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

local function RegisterCentralCLEU(self)
    local EventManager = ns.EventManager
    if not EventManager or not EventManager.RegisterExternalCLEUHandler then
        return false
    end

    local ownerKey = "APLDRW"
    local callback = function(...)
        self:ProcessCombatLogEvent(...)
    end

    EventManager:RegisterExternalCLEUHandler(ownerKey, "SPELL_SUMMON", callback)
    EventManager:RegisterExternalCLEUHandler(ownerKey, "SPELL_AURA_APPLIED", callback)
    EventManager:RegisterExternalCLEUHandler(ownerKey, "SPELL_AURA_REFRESH", callback)
    EventManager:RegisterExternalCLEUHandler(ownerKey, "UNIT_DIED", callback)
    return true
end


-- ~~~~~~~~~~ DRW TRACKING SYSTEM ~~~~~~~~~~
-- Dancing Rune Weapon tracking system for Death Knight
---
--- Tracks DRW summons, debuffs, and expiration for the NAG addon.
local DRW_Tracking = {
    DRW_SPELL_IDS = {
        49028, -- Dancing Rune Weapon (Blood)
        81256, -- Dancing Rune Weapon (Frost)
        49028, -- Dancing Rune Weapon (Unholy)
    },
    playerGUID = nil,
    drwGUID = nil,
    drwExpireTime = 0,
    drwDebuffs = {},

    --- Initializes the DRW tracking system and registers event handlers.
    --- @return nil
    --- @usage DRW_Tracking:Initialize() -- Called automatically during addon initialization
    Initialize = function(self)
        self.playerGUID = UnitGUID("player")
        self.usesCentralCLEU = RegisterCentralCLEU(self)
        local eventFrame = CreateFrame("Frame")
        eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
        eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
        if not self.usesCentralCLEU then
            NAG:Warn("APLDRW central CLEU registration unavailable; legacy fallback disabled")
        end
        eventFrame:SetScript("OnEvent", function(_, event, ...)
            if event == "PLAYER_ENTERING_WORLD" then
                self.playerGUID = UnitGUID("player")
                self:ClearDRWData()
            elseif event == "PLAYER_REGEN_ENABLED" then
                -- Clear any lingering DRW data on leaving combat
                self:ClearDRWData()
            end
        end)
        self.frame = eventFrame
    end,

    --- Processes combat log events to track DRW summons, debuffs, and expiration.
    --- @param timestamp number Event timestamp
    --- @param subevent string Combat log subevent
    --- @param sourceGUID string Source GUID
    --- @param sourceName string Source name
    --- @param sourceFlags number Source flags
    --- @param destGUID string Destination GUID
    --- @param destName string Destination name
    --- @param destFlags number Destination flags
    --- @param spellId number Spell ID
    --- @param spellName string Spell name
    --- @param auraType string Aura type
    --- @return nil
    --- @usage DRW_Tracking:ProcessCombatLogEvent(timestamp, subevent, ...) -- Called by event handler
    ProcessCombatLogEvent = function(self, timestamp, subevent, _, sourceGUID, sourceName, sourceFlags, _, destGUID,
                                     destName, destFlags, _, spellId, spellName, _, auraType)
        self:CheckDRWExpiration()
        if subevent == "SPELL_SUMMON" and sourceGUID == self.playerGUID and tContains(self.DRW_SPELL_IDS, spellId) then
            self.drwGUID = destGUID
            self.drwExpireTime = GetTime() + 30
            NAG:Debug(format("DRW Tracking: Captured DRW GUID: %s", destGUID))
        end
        if (subevent == "SPELL_AURA_APPLIED" or subevent == "SPELL_AURA_REFRESH") and
            sourceGUID == self.drwGUID and auraType == "DEBUFF" then
            self:TrackDRWDebuff(destGUID, spellId, subevent == "SPELL_AURA_REFRESH")
        end
        if subevent == "UNIT_DIED" and destGUID == self.drwGUID then
            self:ClearDRWData()
        end
    end,

    --- Tracks a DRW-applied debuff on a target, updating or creating the debuff entry.
    --- @param targetGUID string The GUID of the target
    --- @param spellId number The spell ID of the debuff
    --- @param isRefresh boolean True if the debuff is being refreshed
    --- @return nil
    --- @usage DRW_Tracking:TrackDRWDebuff("targetGUID", 55095, false) -- Track new DRW debuff
    TrackDRWDebuff = function(self, targetGUID, spellId, isRefresh)
        if not targetGUID or not spellId then return end
        if not self.drwDebuffs[targetGUID] then
            self.drwDebuffs[targetGUID] = {}
        end
        local currentTime = GetTime()
        local debuffData = self.drwDebuffs[targetGUID][spellId]
        if isRefresh and debuffData then
            debuffData.appliedTime = currentTime
            debuffData.expirationTime = currentTime + (debuffData.expirationTime - debuffData.appliedTime)
        else
            local duration = self:EstimateDebuffDuration(spellId)
            self.drwDebuffs[targetGUID][spellId] = {
                appliedTime = currentTime,
                expirationTime = currentTime + duration
            }
        end
        NAG:Debug(format("DRW Tracking: %s debuff %d on target %s",
            isRefresh and "Refreshed" or "Applied", spellId, targetGUID))
    end,

    --- Estimates the duration of a DRW-applied debuff based on spell ID.
    --- @param spellId number The spell ID
    --- @return number The estimated duration in seconds
    --- @usage local duration = DRW_Tracking:EstimateDebuffDuration(55095) -- Get duration for Frost Fever
    EstimateDebuffDuration = function(self, spellId)
        local durations = {
            [55078] = 21, [55095] = 21, [194310] = 6, [191587] = 6, [155159] = 6, [194679] = 6,
        }
        return durations[spellId] or 15
    end,

    --- Checks if the DRW has expired and clears data if so.
    --- @return nil
    --- @usage DRW_Tracking:CheckDRWExpiration() -- Called periodically to check expiration
    CheckDRWExpiration = function(self)
        if self.drwGUID and GetTime() > self.drwExpireTime then
            NAG:Debug("DRW Tracking: DRW expired, clearing data")
            self:ClearDRWData()
        end
    end,

    --- Clears all DRW tracking data.
    --- @return nil
    --- @usage DRW_Tracking:ClearDRWData() -- Clear all DRW tracking information
    ClearDRWData = function(self)
        self.drwGUID = nil
        self.drwExpireTime = 0
        wipe(self.drwDebuffs)
    end,

    --- Checks if a target has a DRW-applied debuff.
    --- @param targetGUID string The GUID of the target
    --- @param spellId number The spell ID of the debuff
    --- @return boolean True if the debuff is present and not expired
    --- @usage local hasDebuff = DRW_Tracking:HasDRWDebuff("targetGUID", 55095) -- Check for Frost Fever
    HasDRWDebuff = function(self, targetGUID, spellId)
        if not targetGUID or not spellId or not self.drwDebuffs[targetGUID] then
            return false
        end
        local debuffData = self.drwDebuffs[targetGUID][spellId]
        if not debuffData then return false end
        local currentTime = GetTime()
        return currentTime < debuffData.expirationTime
    end,

    --- Gets the remaining time for a DRW-applied debuff on a target.
    --- @param targetGUID string The GUID of the target
    --- @param spellId number The spell ID of the debuff
    --- @return number Remaining time in seconds, or 0 if not found
    --- @usage local remaining = DRW_Tracking:GetDRWDebuffRemainingTime("targetGUID", 55095) -- Get Frost Fever time
    GetDRWDebuffRemainingTime = function(self, targetGUID, spellId)
        if not targetGUID or not spellId or not self.drwDebuffs[targetGUID] then
            return 0
        end
        local debuffData = self.drwDebuffs[targetGUID][spellId]
        if not debuffData then return 0 end
        local currentTime = GetTime()
        local remaining = debuffData.expirationTime - currentTime
        return max(0, remaining)
    end,

    --- Counts the number of targets with a DRW-applied debuff, optionally within a given range.
    --- @param spellId number The spell ID of the debuff
    --- @param range number|nil Optional range to use for counting targets
    --- @return number The number of targets with the DRW-applied debuff
    --- @usage local count = DRW_Tracking:CountTargetsWithDRWDebuff(55095, 15) -- Count targets with Frost Fever in 15yd
    CountTargetsWithDRWDebuff = function(self, spellId, range)
        if not spellId then return 0 end


        -- Check if temporary AoE override is active - force single target mode
        if TTDManager:IsSingleTargetOverrideActive() then
            -- Still check if the single target has the DRW debuff
            if UnitExists("target") and UnitCanAttack("player", "target") then
                local targetGUID = UnitGUID("target")
                if targetGUID and self:HasDRWDebuff(targetGUID, spellId) then
                    return 1 -- Found the DRW debuff on single target
                end
            end
            return 0
        end

        local count = 0
        local currentTime = GetTime()
        for i = 5, #ns.GetIterableUnits() do
            local unit = ns.GetIterableUnits()[i]
            if UnitExists(unit) and UnitCanAttack("player", unit) then
                local unitGUID = UnitGUID(unit)
                if unitGUID and self:HasDRWDebuff(unitGUID, spellId) then
                    if range then
                        if RC then
                            local minRange, maxDist = RC:GetRange(unit, true)
                            local distance = minRange or maxDist
                            if distance and distance <= range then
                                count = count + 1
                            end
                        end
                    else
                        count = count + 1
                    end
                end
            end
        end
        return count
    end
}


--- Checks if the current target has a specific debuff applied by Dancing Rune Weapon (DRW).
--- @function NAG:TargetHasDRWDebuff
--- @param spellId number The ID of the debuff to check for.
--- @usage NAG:TargetHasDRWDebuff(55095) -- Check if target has DRW's Frost Fever
--- @return boolean True if the target has the DRW-applied debuff, false otherwise.
function NAG:TargetHasDRWDebuff(spellId)
    if not spellId then
        self:Error("TargetHasDRWDebuff: No spellId provided")
        return false
    end
    local targetGUID = UnitGUID("target")
    if not targetGUID then return false end
    return DRW_Tracking:HasDRWDebuff(targetGUID, spellId)
end

--- Gets the remaining time for a DRW-applied debuff on the current target.
--- @function NAG:TargetDRWDebuffRemainingTime
--- @param spellId number The ID of the debuff to check for.
--- @usage NAG:TargetDRWDebuffRemainingTime(55095) -- Get remaining time for DRW's Frost Fever
--- @return number The remaining time in seconds, or 0 if not found.
function NAG:TargetDRWDebuffRemainingTime(spellId)
    if not spellId then
        self:Error("TargetDRWDebuffRemainingTime: No spellId provided")
        return 0
    end
    local targetGUID = UnitGUID("target")
    if not targetGUID then return 0 end
    return DRW_Tracking:GetDRWDebuffRemainingTime(targetGUID, spellId)
end

--- Gets the number of targets in range that have a specific debuff applied by DRW.
--- @function NAG:NumberTargetsWithDRWDebuff
--- @param spellId number The ID of the debuff to check for.
--- @param range number|nil Optional range to use for counting targets (default: 15).
--- @usage NAG:NumberTargetsWithDRWDebuff(55095) -- Count targets with DRW's Frost Fever
--- @usage NAG:NumberTargetsWithDRWDebuff(55078, 10) -- Count targets within 10 yards with DRW's Blood Plague
--- @return number The number of targets with the DRW-applied debuff.
function NAG:NumberTargetsWithDRWDebuff(spellId, range)
    if not spellId then
        self:Error("NumberTargetsWithDRWDebuff: No spellId provided")
        return 0
    end

    local maxRange = range and min(max(1, range), 100) or 100
    return TTDManager:GetEnemyUnitsInRange(maxRange, {
        customCheck = function(unit)
            return NAG:UnitHasDRWDebuff(unit, spellId)
        end
    }) or 0
end

--- Checks if a specific unit has a DRW-applied debuff.
--- @function NAG:UnitHasDRWDebuff
--- @param unit string The unit to check (e.g., "target", "focus", "nameplate1").
--- @param spellId number The ID of the debuff to check for.
--- @usage NAG:UnitHasDRWDebuff("target", 55095) -- Check if target has DRW's Frost Fever
--- @return boolean True if the unit has the DRW-applied debuff, false otherwise.
--- @local This function is used to check if a specific unit has a DRW-applied debuff.
function NAG:UnitHasDRWDebuff(unit, spellId)
    if not unit or not spellId then
        self:Error("UnitHasDRWDebuff: Invalid parameters")
        return false
    end
    local unitGUID = UnitGUID(unit)
    if not unitGUID then return false end
    return DRW_Tracking:HasDRWDebuff(unitGUID, spellId)
end

--- Gets the remaining time for a DRW-applied debuff on a specific unit.
--- @function NAG:UnitDRWDebuffRemainingTime
--- @param spellIdOrUnit number|string The spell ID or unit string.
--- @param unitOrSpellId string|number|nil The unit string or spell ID (optional).
--- @usage NAG:UnitDRWDebuffRemainingTime(55095) -- Get remaining time for DRW's Frost Fever on target
--- @usage NAG:UnitDRWDebuffRemainingTime(55095, "focus") -- Get remaining time for DRW's Frost Fever on focus
--- @usage NAG:UnitDRWDebuffRemainingTime("nameplate1", 55078) -- Get remaining time for DRW's Blood Plague on nameplate1
--- @return number The remaining time in seconds, or 0 if not found.
--- @local This function is used to get the remaining time for a DRW-applied debuff on a specific unit.
function NAG:UnitDRWDebuffRemainingTime(spellIdOrUnit, unitOrSpellId)
    local spellId, unit
    -- Determine parameter types and assign accordingly
    if type(spellIdOrUnit) == "number" then
        spellId = spellIdOrUnit
        if type(unitOrSpellId) == "string" then
            unit = unitOrSpellId
        else
            unit = "target"
        end
    elseif type(spellIdOrUnit) == "string" then
        unit = spellIdOrUnit
        if type(unitOrSpellId) == "number" then
            spellId = unitOrSpellId
        else
            self:Error("UnitDRWDebuffRemainingTime: No spellId provided")
            return 0
        end
    else
        self:Error("UnitDRWDebuffRemainingTime: Invalid parameters")
        return 0
    end
    if not spellId then
        self:Error("UnitDRWDebuffRemainingTime: No spellId provided")
        return 0
    end

    local unitGUID = UnitGUID(unit)
    if not unitGUID then return 0 end
    return DRW_Tracking:GetDRWDebuffRemainingTime(unitGUID, spellId)
end

-- Initialize DRW tracking system
DRW_Tracking:Initialize()
