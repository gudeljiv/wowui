--- @module "NAG.HealingPriorityManager"
--- Computes prioritized healing targets from group/raid list.
--- Supports raid (raid1..raidN) and party (player, party1..partyN).
--- Tank priority uses UnitGroupRolesAssigned when available (MoP+); TBC has no role API.
---
--- License: CC BY-NC 4.0
--- Authors: NAG Team

local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local UnitExists = _G.UnitExists
local UnitHealth = _G.UnitHealth
local UnitHealthMax = _G.UnitHealthMax
local UnitIsDeadOrGhost = _G.UnitIsDeadOrGhost
local GetNumGroupMembers = _G.GetNumGroupMembers
local IsInRaid = _G.IsInRaid
local GetNumRaidMembers = _G.GetNumRaidMembers
local GetNumPartyMembers = _G.GetNumPartyMembers
local UnitGroupRolesAssigned = _G.UnitGroupRolesAssigned

-- ============================ CONSTANTS ============================

local MAX_RAID_SIZE = 40

-- nil = use spec-based default (enabled on healing specs only)
local defaults = {
    char = {
        enabled = nil,
        healthThreshold = 80
    }
}

local HealingPriorityManager = NAG:CreateModule("HealingPriorityManager", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,
    optionsCategory = "features",
    debugCategories = { ns.DEBUG_CATEGORIES.FEATURES },
})

-- ============================ HEALING SPEC DETECTION ============================

local UnitClass = _G.UnitClass

--- Healer spec indices per class (MoP/TBC). Monk Mistweaver uses a different system and is not gated here.
local HEALER_SPEC_BY_CLASS = {
    PRIEST = { [1] = true, [2] = true },
    DRUID = { [4] = true },
    PALADIN = { [1] = true },
    SHAMAN = { [3] = true },
}

function HealingPriorityManager:IsHealingSpec()
    local _, class = UnitClass("player")
    if not class or not HEALER_SPEC_BY_CLASS[class] then return false end
    local SpecCompat = NAG:GetModule("SpecCompat", true)
    local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
    return specIndex and HEALER_SPEC_BY_CLASS[class][specIndex] or false
end

function HealingPriorityManager:IsEnabled()
    if self.db.char.enabled ~= nil then return self.db.char.enabled end
    return self:IsHealingSpec()
end

--- True if priority logic should run (enabled; no longer requires Developer Mode so glow/priority work for all Resto players)
local function isPriorityActive(module)
    return module:IsEnabled()
end

-- ============================ UNIT LIST (RAID / PARTY) ============================

--- Build list of group units (raid1..N or player + party1..N).
--- @return table units Array of unit IDs
--- @return number count Number of valid units
local function getGroupUnits()
    local raidSize = 0
    if IsInRaid and IsInRaid() then
        raidSize = GetNumGroupMembers()
    elseif GetNumRaidMembers and GetNumRaidMembers() > 0 then
        raidSize = GetNumRaidMembers()
    end

    local units = {}
    local idx = 0

    if raidSize > 0 then
        for i = 1, math.min(raidSize, MAX_RAID_SIZE) do
            idx = idx + 1
            units[idx] = "raid" .. i
        end
    else
        idx = idx + 1
        units[idx] = "player"
        local partySize = (GetNumPartyMembers and GetNumPartyMembers()) or 0
        if partySize <= 0 and GetNumGroupMembers then
            local n = GetNumGroupMembers()
            if n > 0 then
                partySize = n - 1
            end
        end
        for i = 1, partySize do
            idx = idx + 1
            units[idx] = "party" .. i
        end
    end

    return units, idx
end

--- Get role for unit; returns "TANK" only when UnitGroupRolesAssigned exists (MoP+).
--- @param unit string Unit token
--- @return string role "TANK", "HEALER", "DAMAGER", or "NONE"
local function getUnitRole(unit)
    if not UnitGroupRolesAssigned then return "NONE" end
    local role = UnitGroupRolesAssigned(unit)
    return (role and role ~= "NONE") and role or "NONE"
end

-- ============================ PRIORITY LOGIC ============================

--- Get units needing healing below threshold, sorted by priority (tank > low HP).
--- @param maxTargets number|nil Max number of units to return (default 5)
--- @param healthThreshold number|nil 0-100, consider below this % (default from settings)
--- @return table List of unit IDs in priority order
function HealingPriorityManager:GetPrioritizedTargets(maxTargets, healthThreshold)
    local list = {}
    if not isPriorityActive(self) then return list end

    local threshold = (healthThreshold or self.db.char.healthThreshold or 80) / 100
    local units, unitCount = getGroupUnits()

    if unitCount <= 0 then
        if UnitExists("player") and not UnitIsDeadOrGhost("player") then
            local maxH = UnitHealthMax("player")
            if maxH and maxH > 0 and (UnitHealth("player") or 0) / maxH < threshold then
                list[#list + 1] = "player"
            end
        end
        return list
    end

    local candidates = {}
    for i = 1, unitCount do
        local unit = units[i]
        if UnitExists(unit) and not UnitIsDeadOrGhost(unit) then
            local maxH = UnitHealthMax(unit)
            if maxH and maxH > 0 then
                local pct = (UnitHealth(unit) or 0) / maxH
                if pct < threshold then
                    local role = getUnitRole(unit)
                    candidates[#candidates + 1] = {
                        unit = unit,
                        pct = pct,
                        isTank = (role == "TANK")
                    }
                end
            end
        end
    end

    table.sort(candidates, function(a, b)
        if a.isTank ~= b.isTank then return a.isTank end
        return a.pct < b.pct
    end)

    local limit = maxTargets or 5
    for i = 1, math.min(limit, #candidates) do
        list[#list + 1] = candidates[i].unit
    end
    return list
end

--- Get the single best healing target (mouseover if valid and needs heal, else first prioritized).
--- @param healthThreshold number|nil 0-100 (default from settings)
--- @return string|nil Unit ID or nil
function HealingPriorityManager:GetBestHealingTarget(healthThreshold)
    if not isPriorityActive(self) then return nil end

    local threshold = (healthThreshold or self.db.char.healthThreshold or 80) / 100
    if UnitExists("mouseover") and not UnitIsDeadOrGhost("mouseover") then
        local maxH = UnitHealthMax("mouseover")
        if maxH and maxH > 0 and (UnitHealth("mouseover") or 0) / maxH < threshold then
            return "mouseover"
        end
    end
    local th = healthThreshold or self.db.char.healthThreshold or 80
    local list = self:GetPrioritizedTargets(1, th)
    return list[1]
end

--- Count units below health threshold.
--- @param threshold number 0-100
--- @return number
function HealingPriorityManager:CountUnitsNeedingHealing(threshold)
    if not isPriorityActive(self) then return 0 end
    local list = self:GetPrioritizedTargets(999, threshold)
    return #list
end

--- Whether AOE heal is warranted (multiple units below threshold).
--- @param threshold number|nil 0-100
--- @param minCount number|nil Minimum units (default 2)
--- @return boolean
function HealingPriorityManager:ShouldUseAOEHeal(threshold, minCount)
    if not isPriorityActive(self) then return false end
    local n = self:CountUnitsNeedingHealing(threshold or self.db.char.healthThreshold or 80)
    return n >= (minCount or 2)
end

-- ============================ LIFECYCLE ============================

function HealingPriorityManager:ModuleInitialize() end
function HealingPriorityManager:ModuleEnable() end

-- ============================ OPTIONS ============================

function HealingPriorityManager:GetOptions()
    local OptionsFactory = ns.OptionsFactory
    if not OptionsFactory then
        return { type = "group", name = "Healing Priority", args = {} }
    end
    return {
        type = "group",
        name = "Healing Priority",
        desc = "Prioritized healing targets (tank > low HP). Only active when Developer Mode is enabled.",
        hidden = function() return not (NAG.IsDevModeEnabled and NAG:IsDevModeEnabled()) end,
        args = {
            enabled = OptionsFactory:CreateToggle(
                "Enable",
                "Enable healing priority (healer specs: on by default; DPS/tank: off)",
                function() return self:IsEnabled() end,
                function(_, v) self:SetSetting("char", "enabled", v) end,
                { order = 1 }
            ),
            healthThreshold = OptionsFactory:CreateRange(
                "Health threshold (%)",
                "Consider unit needing heal below this %",
                function() return self:GetSetting("char", "healthThreshold") or 80 end,
                function(_, v) self:SetSetting("char", "healthThreshold", v) end,
                { order = 2, min = 50, max = 100, step = 5 }
            )
        }
    }
end

return HealingPriorityManager
