--- @module "APLTotemTracking"
--- Totem tracking system for Shaman class in the NAG addon
---
--- This module provides internal tracking for Shaman totems (Fire Elemental, Searing, Magma, Earth Elemental)
--- Used by NAG:IsTotemActive(spellId)
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local GetTime = _G.GetTime
local UnitGUID = _G.UnitGUID
local UnitName = _G.UnitName
local UnitAffectingCombat = _G.UnitAffectingCombat
local GetTotemInfo = _G.GetTotemInfo
local GetTotemTimeLeft = _G.GetTotemTimeLeft
local CreateFrame = _G.CreateFrame
--- @type NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ HEADER LOCALS ============================

-- Libraries
local L = ns.AceLocale:GetLocale("NAG", true)
local RC = ns.RC

-- ============================ MODULE CACHING (PERFORMANCE) ============================
-- Cache frequently accessed modules to avoid GetModule overhead in hot paths
local DisplayManager = ns.DisplayManager
local OverlayManager = ns.OverlayManager


--- Table of tracked totem spell IDs across all classes
--- @type table<number, boolean>
local trackedTotems = {
    -- Shaman totems
    [2894] = true, -- Fire Elemental Totem
    [3599] = true, -- Searing Totem
    [8190] = true, -- Magma Totem
    [2062] = true, -- Earth Elemental Totem
    -- Monk statues (also considered totems by WoW API)
    [115313] = true, -- Jade Serpent Statue
}

-- Canonical IDs used by the internal tracker/attack logic.
local SEARING_TOTEM_CANONICAL_ID = 3599
local MAGMA_TOTEM_CANONICAL_ID = 8190

-- Rank-to-canonical mapping for tracked fire totems.
-- This preserves attack-aware semantics while accepting rank-specific IDs from APLs.
local trackedTotemCanonicalBySpellId = {
    -- Searing Totem ranks
    [3599] = SEARING_TOTEM_CANONICAL_ID,
    [38116] = SEARING_TOTEM_CANONICAL_ID,
    [6563] = SEARING_TOTEM_CANONICAL_ID,
    [6363] = SEARING_TOTEM_CANONICAL_ID,
    [6364] = SEARING_TOTEM_CANONICAL_ID,
    [6365] = SEARING_TOTEM_CANONICAL_ID,
    [10437] = SEARING_TOTEM_CANONICAL_ID,
    [10438] = SEARING_TOTEM_CANONICAL_ID,
    [25533] = SEARING_TOTEM_CANONICAL_ID,

    -- Magma Totem ranks
    [8190] = MAGMA_TOTEM_CANONICAL_ID,
    [8187] = MAGMA_TOTEM_CANONICAL_ID,
    [10579] = MAGMA_TOTEM_CANONICAL_ID,
    [10580] = MAGMA_TOTEM_CANONICAL_ID,
    [10581] = MAGMA_TOTEM_CANONICAL_ID,
    [10585] = MAGMA_TOTEM_CANONICAL_ID,
    [10586] = MAGMA_TOTEM_CANONICAL_ID,
    [10587] = MAGMA_TOTEM_CANONICAL_ID,
    [25550] = MAGMA_TOTEM_CANONICAL_ID,
    [25552] = MAGMA_TOTEM_CANONICAL_ID,
}

local function RegisterCentralCLEU(self)
    local EventManager = ns.EventManager
    if not EventManager or not EventManager.RegisterExternalCLEUHandler then
        return false
    end

    local ownerKey = "APLTotemTracking"
    local callback = function(...)
        self:ProcessCombatLogEvent(...)
    end
    EventManager:RegisterExternalCLEUHandler(ownerKey, "SPELL_SUMMON", callback)
    EventManager:RegisterExternalCLEUHandler(ownerKey, "SPELL_CAST_SUCCESS", callback)
    return true
end

--- Maps rank-specific tracked totem IDs to their canonical tracker ID.
--- @param spellIdOrSlot number
--- @return number
local function NormalizeTrackedTotemSpellId(spellIdOrSlot)
    if type(spellIdOrSlot) ~= "number" then
        return spellIdOrSlot
    end
    if spellIdOrSlot >= 1 and spellIdOrSlot <= 4 then
        return spellIdOrSlot
    end
    return trackedTotemCanonicalBySpellId[spellIdOrSlot] or spellIdOrSlot
end

--- Internal totem tracking system for all classes with totems
local Totem_Tracking = {
    data = {},
    playerGUID = nil,
    totemSlotCache = nil,
    overlayState = nil,

    --- Constants
    slotCacheInterval = 0.75,

    --- Initialize the totem tracking system
    --- @return nil
    Initialize = function(self)
        self.playerGUID = UnitGUID("player")
        self.usesCentralCLEU = RegisterCentralCLEU(self)
        self.totemSlotCache = {
            lastScan = 0,
            slots = {},
            spells = {}
        }
        self.overlayState = {}
        local eventFrame = CreateFrame("Frame")
        eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
        eventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
        if not self.usesCentralCLEU then
            NAG:Warn("APLTotemTracking central CLEU registration unavailable; legacy fallback disabled")
        end
        eventFrame:SetScript("OnEvent", function(_, event, ...)
            if event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED_NEW_AREA" then
                self.playerGUID = UnitGUID("player")
                self:ClearAll()
            end
        end)
        self.frame = eventFrame
    end,

    --- Clear all tracked totem data
    --- @return nil
    ClearAll = function(self)
        wipe(self.data)
        if self.totemSlotCache then
            self.totemSlotCache.lastScan = 0
            wipe(self.totemSlotCache.slots)
            wipe(self.totemSlotCache.spells or {})
        end
        if self.overlayState then
            for spellId, active in pairs(self.overlayState) do
                if active then
                    self:UpdateNotAttackingOverlay(spellId, false)
                end
            end
            wipe(self.overlayState)
        end
    end,

    --- Refresh cached totem slot data
    --- @param self Totem_Tracking
    RefreshSlotCache = function(self)
        if not self.totemSlotCache then
            self.totemSlotCache = {
                lastScan = 0,
                slots = {},
                spells = {}
            }
        end

        local now = GetTime()
        if (now - (self.totemSlotCache.lastScan or 0)) < self.slotCacheInterval then
            return
        end

        local slots = self.totemSlotCache.slots
        local spells = self.totemSlotCache.spells or {}
        wipe(slots)
        wipe(spells)
        self.totemSlotCache.spells = spells

        for slot = 1, 4 do
            local hasTotem, totemName, startTime, duration, totemIcon, modRate, totemSpellId = GetTotemInfo(slot)
            if hasTotem and totemSpellId then
                local remainingTime = GetTotemTimeLeft(slot) or 0
                local data = {
                    hasTotem = true,
                    spellId = totemSpellId,
                    name = totemName,
                    remaining = remainingTime,
                    startTime = startTime,
                    duration = duration,
                }
                slots[slot] = data
                spells[totemSpellId] = data
            else
                -- Once an empty slot is encountered, higher slots are guaranteed empty
                break
            end
        end

        self.totemSlotCache.lastScan = now
    end,

    --- Retrieves cached slot data (refreshing if needed)
    --- @param self Totem_Tracking
    --- @param slot number
    --- @return table|nil
    GetSlotData = function(self, slot)
        self:RefreshSlotCache()
        return self.totemSlotCache and self.totemSlotCache.slots[slot]
    end,

    --- Retrieves cached totem data by spell ID (refreshing if needed)
    --- @param self Totem_Tracking
    --- @param spellId number
    --- @return table|nil
    GetSpellData = function(self, spellId)
        if not spellId then
            return nil
        end
        self:RefreshSlotCache()
        return self.totemSlotCache and self.totemSlotCache.spells and self.totemSlotCache.spells[spellId]
    end,

    --- Checks if a tracked totem is currently attacking
    --- @param self Totem_Tracking
    --- @param spellId number
    --- @return boolean
    IsTrackedTotemAttacking = function(self, spellId)
        local t = self.data[spellId]
        if not t then
            return false
        end

        local now = GetTime()
        if spellId == 3599 or spellId == 8190 then
            if not t.lastAttackTime or (now - t.lastAttackTime > 10) then
                return false
            end
            return now <= (t.expires or 0)
        end

        if spellId == 2894 or spellId == 2062 or spellId == 115313 then
            return now < (t.expires or 0)
        end

        return false
    end,

    --- Shows or hides the "NOT ATTACKING" overlay for applicable totems
    --- @param self Totem_Tracking
    --- @param spellId number
    --- @param shouldShow boolean
    UpdateNotAttackingOverlay = function(self, spellId, shouldShow)
        if spellId ~= 3599 and spellId ~= 8190 then
            return
        end

        -- Modules already cached at top of file
        if not OverlayManager or not DisplayManager then
            return
        end

        if shouldShow and not UnitAffectingCombat("player") then
            shouldShow = false
        end

        self.overlayState = self.overlayState or {}
        local desiredState = shouldShow and true or false
        if self.overlayState[spellId] == desiredState then
            return
        end
        self.overlayState[spellId] = desiredState

        local overlayId = "totem_not_attacking_" .. tostring(spellId)
        local baseMessage = (L and (L["NOT_ATTACKING"] or L["Not Attacking"])) or "NOT ATTACKING"
        local message = (spellId == 3599) and "Searing Totem Not Attacking" or baseMessage
        local tracker = self

        for _, frame in ipairs(DisplayManager:GetActivePrimaryFrames()) do
            if desiredState then
                OverlayManager:ShowTextOverlay(frame, message, nil, function()
                    return tracker.overlayState and tracker.overlayState[spellId]
                end, {
                    id = overlayId,
                    fontColor = { 1, 0.2, 0.2, 1 },
                    fontSize = 14,
                    pulse = false,
                    background = {
                        enable = false
                    },
                    text = message,
                })
            else
                OverlayManager:HideTextOverlay(frame, overlayId)
            end
        end
    end,

    --- Process combat log events to track totem summoning and attacks
    --- @param self Totem_Tracking
    --- @param timestamp number Event timestamp
    --- @param subevent string Combat log subevent type
    --- @param ... any Additional combat log parameters
    --- @return nil
    ProcessCombatLogEvent = function(self, timestamp, subevent, _, sourceGUID, sourceName, sourceFlags, _, destGUID,
                                     destName, destFlags, _, spellId, spellName, ...)
        local now = GetTime()
        local normalizedSpellId = NormalizeTrackedTotemSpellId(spellId)
        -- Summon event - track all classes with totems
        if subevent == "SPELL_SUMMON" and sourceGUID == self.playerGUID and trackedTotems[normalizedSpellId] then
            local summonDuration = 60
            if normalizedSpellId == 2894 then
                -- Glyph of Fire Elemental Totem (55455) halves duration from 60s to 30s.
                summonDuration = (NAG.HasGlyph and NAG:HasGlyph(55455)) and 30 or 60
            end
            -- Only one totem of each type
            self.data[normalizedSpellId] = {
                guid = destGUID,
                startTime = now,
                expires = now + summonDuration,
                lastAttackTime = nil,
            }
        end

        -- Attack event (Searing/Magma only) - using SPELL_CAST_SUCCESS
        if subevent == "SPELL_CAST_SUCCESS" and sourceName == UnitName("player") then
            for tid, t in pairs(self.data) do
                if (tid == 3599 or tid == 8190) and t.guid and sourceGUID == t.guid then
                    t.lastAttackTime = now
                end
            end
        end

        -- Also check for any SPELL_CAST_SUCCESS where sourceGUID matches our tracked totem GUIDs
        if subevent == "SPELL_CAST_SUCCESS" then
            for tid, t in pairs(self.data) do
                if (tid == 3599 or tid == 8190) and t.guid and sourceGUID == t.guid then
                    t.lastAttackTime = now
                end
            end
        end
    end,

    --- Check if a totem is currently active (and attacking for Searing/Magma)
    --- @param self Totem_Tracking
    --- @param spellIdOrSlot number The totem spell ID to check or totem slot number (1-4)
    --- @return boolean True if the totem is active
    IsActive = function(self, spellIdOrSlot)
        -- Handle totem slot numbers (1-4)
        if spellIdOrSlot >= 1 and spellIdOrSlot <= 4 then
            local slotData = self:GetSlotData(spellIdOrSlot)
            if slotData and slotData.hasTotem then
                if trackedTotems[slotData.spellId] then
                    local attacking = self:IsTrackedTotemAttacking(slotData.spellId)
                    self:UpdateNotAttackingOverlay(slotData.spellId, slotData.hasTotem and not attacking)
                    return attacking
                end
                return (slotData.remaining or 0) > 0
            end
            self:UpdateNotAttackingOverlay(3599, false)
            self:UpdateNotAttackingOverlay(8190, false)
            return false
        end

        -- Handle spell IDs
        local spellId = NormalizeTrackedTotemSpellId(spellIdOrSlot)

        -- Check if this is a tracked totem spell ID
        if not trackedTotems[spellId] then
            -- Fallback: check if this spell ID is active in any totem slot
            for slot = 1, 4 do
                local hasTotem, totemName, startTime, duration, totemIcon, modRate, totemSpellId = GetTotemInfo(slot)
                if hasTotem and totemSpellId == spellId then
                    local remainingTime = GetTotemTimeLeft(slot)
                    return remainingTime and remainingTime > 0
                end
            end
            return false
        end

        -- Check internal tracking data first
        local t = self.data[spellId]
        if t then
            local now = GetTime()

            -- Shaman totems with special attack tracking (Searing/Magma)
            if spellId == 3599 or spellId == 8190 then
                local attacking = self:IsTrackedTotemAttacking(spellId)
                local presentData = self:GetSpellData(spellId)
                local isPresent = presentData and (presentData.remaining or 0) > 0
                if (not isPresent) and NAG.IsTotemActiveAnyRankForSpell then
                    isPresent = NAG:IsTotemActiveAnyRankForSpell(spellId) == true
                end
                self:UpdateNotAttackingOverlay(spellId, isPresent and not attacking)
                if attacking then
                    return true
                end
                return false
            end

            -- Other totems (Fire Elemental, Earth Elemental, Monk statues, etc.)
            if spellId == 2894 or spellId == 2062 or spellId == 115313 then
                return now < (t.expires or 0)
            end
        end

        -- Fallback: check cached totem slots
        local spellData = self:GetSpellData(spellId)
        if spellData and spellData.hasTotem then
            if spellId == 3599 or spellId == 8190 then
                self:UpdateNotAttackingOverlay(spellId, true)
            end
            return (spellData.remaining or 0) > 0
        end
        if spellId == 3599 or spellId == 8190 then
            self:UpdateNotAttackingOverlay(spellId, false)
        end

        return false
    end,
}

-- Expose for NAG
ns.Totem_Tracking = Totem_Tracking

-- Initialize on load
Totem_Tracking:Initialize()

-- Add public API function to NAG


--- Checks if a totem is active (and attacking, if Searing/Magma).
--- Tracks Shaman totems: Fire Elemental (2894), Searing (3599), Magma (8190), Earth Elemental (2062).
--- Tracks Monk statues: Jade Serpent Statue (115313).
--- For Searing and Magma totems, also verifies they have attacked recently (within 10 seconds).
--- Supports both spell IDs and totem slot numbers (1-4).
--- @param spellIdOrSlot number The spell ID of the totem to check or totem slot number (1-4)
--- @return boolean True if the totem is active and (for Searing/Magma) has attacked recently
--- @usage NAG:IsTotemActive(3599) -- Check if Searing Totem is active
--- @usage NAG:IsTotemActive(115313) -- Check if Jade Serpent Statue is active
--- @usage NAG:IsTotemActive(1) -- Check if totem slot 1 is active
function NAG:IsTotemActive(spellIdOrSlot)
    if not ns.Totem_Tracking or not ns.Totem_Tracking.IsActive then
        return false
    end
    -- Keep canonical totem spell IDs here. The tracker keys and attack logic are
    -- built around base IDs (e.g. 3599/8190), so rank-resolution must not run here.
    return ns.Totem_Tracking:IsActive(spellIdOrSlot)
end

