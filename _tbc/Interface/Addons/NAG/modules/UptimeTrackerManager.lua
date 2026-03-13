--- @module "NAG.UptimeTrackerManager"
--- Handles uptime tracking management for buffs/debuffs/timers
---
--- This module provides functions for managing uptime timeline clusters and tracking active auras.
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi, @Fonsas

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- DIAGNOSTIC: Verify file is loading
print("|cFFFF00FFUptimeTrackerManager.lua is loading...|r")

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~

--- @type DataManager
--- @type StateManager
--- @type TimerManager
local DataManager, StateManager, TimerManager

--- @type SpecCompat
local SpecCompat

local L = ns.AceLocale:GetLocale("NAG", true)

-- Lua APIs
local GetTime = _G.GetTime
local UnitExists = _G.UnitExists
local UnitName = _G.UnitName
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
local UnitAffectingCombat = _G.UnitAffectingCombat
local format = string.format

-- Table operations
local tinsert = tinsert
local tremove = tremove
local tContains = tContains

-- ~~~~~~~~~~ CONSTANTS ~~~~~~~~~~
local UPDATE_INTERVAL = 0.05 -- 20 updates per second for smooth countdown

-- ~~~~~~~~~~ DEFAULTS ~~~~~~~~~~
local defaults = {
    char = {
        enabled = true,
        clusters = {} -- Will be populated dynamically by editor
    }
}

--- @class UptimeTrackerManager: CoreModule
local UptimeTrackerManager = NAG:CreateModule("UptimeTrackerManager", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,
    optionsCategory = ns.MODULE_CATEGORIES.UI,
    debug = true,
    eventHandlers = {
        PLAYER_REGEN_DISABLED = true,
        PLAYER_REGEN_ENABLED = true,
    },
    messageHandlers = {
        NAG_SPECIALIZATION_CHANGED = true,
    },
    slashCommands = {
        ["uptimeauras"] = {
            handler = "DumpTargetAuras",
            help = "List all auras (buffs/debuffs) on current target",
            root = "nagdebug",
            category = "Data"
        }
    },
    debugCategories = {
        ns.DEBUG_CATEGORIES.FEATURES,
        ns.DEBUG_CATEGORIES.MANAGERS
    },
    defaultState = {
        clusterData = {}, -- Active buff data per cluster index
        lastUpdate = 0,
        lastDebugTime = 0 -- Throttle debug output to once per second
    }
})
print("|cFFFF00FFUptimeTrackerManager module created: " .. tostring(UptimeTrackerManager) .. "|r")
local module = UptimeTrackerManager
ns.UptimeTrackerManager = UptimeTrackerManager
print("|cFFFF00FFUptimeTrackerManager stored in namespace|r")

-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~
do
    function UptimeTrackerManager:ModuleInitialize()
        self:Debug("UptimeTrackerManager:ModuleInitialize called")

        -- Module assignment
        DataManager = NAG:GetModule("DataManager")
        StateManager = NAG:GetModule("StateManager")
        TimerManager = NAG:GetModule("TimerManager")
        SpecCompat = NAG:GetModule("SpecCompat")

        -- Initialize cluster data storage
        self.state.clusterData = {}
    end

    function UptimeTrackerManager:ModuleEnable()
        print("|cFF00FF00UptimeTrackerManager: ModuleEnable called (storage-only)|r")
        self:Debug("ModuleEnable called (storage-only)")
        -- Storage-only mode: no timers or polling; UI performs detection per-frame
    end

    function UptimeTrackerManager:ModuleDisable()
        -- Storage-only: ensure any stray timers are cancelled defensively
        TimerManager:Cancel(TimerManager.Categories.UI, "uptimeTracking")
    end
end

-- ~~~~~~~~~~ EVENT HANDLERS ~~~~~~~~~~
do
    function UptimeTrackerManager:PLAYER_REGEN_DISABLED()
        -- No-op, just triggers module refresh
    end

    function UptimeTrackerManager:PLAYER_REGEN_ENABLED()
        -- No-op, just triggers module refresh
    end

    function UptimeTrackerManager:NAG_SPECIALIZATION_CHANGED()
        -- Force refresh when spec changes to update visibility
        self:UpdateTracking()
    end
end

-- ~~~~~~~~~~ INITIALIZATION ~~~~~~~~~~
function UptimeTrackerManager:InitializeTracking()
    -- Storage-only mode: no timers are created; renderer handles per-frame detection
    self:Debug("InitializeTracking skipped (storage-only mode)")
end

-- ~~~~~~~~~~ TRACKING LOGIC ~~~~~~~~~~
function UptimeTrackerManager:UpdateTracking()
    -- Storage-only mode: no polling; simply notify UI to refresh visuals/layout
    NAG:SendMessage("NAG_UPTIME_TRACKING_UPDATED")
end

function UptimeTrackerManager:ShouldShowCluster(cluster)
    -- Check class filter
    if cluster.showForClasses and type(cluster.showForClasses) == "table" and #cluster.showForClasses > 0 then
        local _, playerClass = UnitClass("player")
        if not tContains(cluster.showForClasses, playerClass) then
            return false
        end
    end

    -- Check spec filter
    if cluster.showForSpecs and type(cluster.showForSpecs) == "table" and #cluster.showForSpecs > 0 then
        local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
        if specIndex and not tContains(cluster.showForSpecs, specIndex) then
            return false
        end
    end

    -- Check combat state
    if cluster.hideOutOfCombat and not UnitAffectingCombat("player") then
        return false
    end

    -- Note: hideWhenEmpty is handled by the UI module
    -- We still return true here to let UI decide

    return true
end

-- ~~~~~~~~~~ DEBUG COMMANDS ~~~~~~~~~~
function UptimeTrackerManager:DumpTargetAuras()
    if not UnitExists("target") then
        print("|cFFFF0000No target selected!|r")
        return
    end

    local targetName = UnitName("target")
    print("|cFF00FF00=== Auras on " .. targetName .. " ===|r")

    -- Dump debuffs (HARMFUL)
    print("|cFFFFAA00DEBUFFS:|r")
    local debuffCount = 0
    for i = 1, 40 do
        local auraData = UnitAura("target", i, "HARMFUL")
        if not auraData or not auraData.name then break end

        local timeLeft = auraData.expirationTime and (auraData.expirationTime - GetTime()) or 0
        print(string.format("  [%d] %s (ID: %d) - %.1fs remaining, stacks: %d, icon: %s",
            i, auraData.name, auraData.spellId or 0, timeLeft, auraData.count or 0, tostring(auraData.icon)))
        debuffCount = debuffCount + 1
    end
    print(string.format("|cFFFFAA00Total debuffs: %d|r", debuffCount))

    -- Dump buffs (HELPFUL)
    print("|cFF00AAFFBUFFS:|r")
    local buffCount = 0
    for i = 1, 40 do
        local auraData = UnitAura("target", i, "HELPFUL")
        if not auraData or not auraData.name then break end

        local timeLeft = auraData.expirationTime and (auraData.expirationTime - GetTime()) or 0
        print(string.format("  [%d] %s (ID: %d) - %.1fs remaining, stacks: %d",
            i, auraData.name, auraData.spellId or 0, timeLeft, auraData.count or 0))
        buffCount = buffCount + 1
    end
    print(string.format("|cFF00AAFFTotal buffs: %d|r", buffCount))

    -- Also check player auras for comparison
    print("|cFFFF00FF=== PLAYER Auras ===|r")
    print("|cFFFFAA00PLAYER DEBUFFS:|r")
    local playerDebuffCount = 0
    for i = 1, 40 do
        local auraData = UnitAura("player", i, "HARMFUL")
        if not auraData or not auraData.name then break end

        local timeLeft = auraData.expirationTime and (auraData.expirationTime - GetTime()) or 0
        print(string.format("  [%d] %s (ID: %d) - %.1fs remaining",
            i, auraData.name, auraData.spellId or 0, timeLeft))
        playerDebuffCount = playerDebuffCount + 1
    end

    print("|cFF00AAFFPLAYER BUFFS:|r")
    local playerBuffCount = 0
    for i = 1, 40 do
        local auraData = UnitAura("player", i, "HELPFUL")
        if not auraData or not auraData.name then break end

        local timeLeft = auraData.expirationTime and (auraData.expirationTime - GetTime()) or 0
        print(string.format("  [%d] %s (ID: %d) - %.1fs remaining",
            i, auraData.name, auraData.spellId or 0, timeLeft))
        playerBuffCount = playerBuffCount + 1
    end
end

-- ~~~~~~~~~~ CLUSTER MANAGEMENT ~~~~~~~~~~
function UptimeTrackerManager:GetClusterData(clusterIndex)
    return self.state.clusterData[clusterIndex]
end

function UptimeTrackerManager:AddCluster(clusterConfig)
    if not clusterConfig then
        self:Error("AddCluster: Invalid cluster config")
        return false
    end

    -- Ensure clusters table exists
    if not self.db.char.clusters then
        self.db.char.clusters = {}
    end

    -- Add default values
    local defaultCluster = {
        name = clusterConfig.name or "New Cluster",
        enabled = true,
        trackingConfigs = clusterConfig.trackingConfigs or {},
        position = clusterConfig.position or { point = "CENTER", x = 0, y = 0 },
        size = clusterConfig.size or { width = 200, height = 2 },
        orientation = clusterConfig.orientation or "horizontal",
        direction = clusterConfig.direction or "rightToLeft",
        maxTrackingTime = clusterConfig.maxTrackingTime or 15,
        windowStart = clusterConfig.windowStart or 0,
        windowEnd = clusterConfig.windowEnd or 15,
        showBackground = clusterConfig.showBackground ~= nil and clusterConfig.showBackground or true,
        backgroundAlpha = clusterConfig.backgroundAlpha or 0.7,
        showForClasses = clusterConfig.showForClasses or {},
        showForSpecs = clusterConfig.showForSpecs or {},
        hideOutOfCombat = clusterConfig.hideOutOfCombat or false,
        hideWhenEmpty = clusterConfig.hideWhenEmpty ~= nil and clusterConfig.hideWhenEmpty or false
    }

    tinsert(self.db.char.clusters, defaultCluster)
    self:UpdateTracking()
    return true
end

function UptimeTrackerManager:UpdateCluster(clusterIndex, clusterConfig)
    if not clusterConfig or not self.db.char.clusters[clusterIndex] then
        self:Error("UpdateCluster: Invalid cluster index or config")
        return false
    end

    -- Merge new config with existing
    for key, value in pairs(clusterConfig) do
        self.db.char.clusters[clusterIndex][key] = value
    end

    self:UpdateTracking()
    return true
end

function UptimeTrackerManager:DeleteCluster(clusterIndex)
    if not self.db.char.clusters[clusterIndex] then
        self:Error("DeleteCluster: Invalid cluster index")
        return false
    end

    tremove(self.db.char.clusters, clusterIndex)

    -- Clear cluster data
    self.state.clusterData[clusterIndex] = nil

    -- Reindex cluster data (shifts down after removal)
    local newClusterData = {}
    local newIndex = 1
    for i, cluster in ipairs(self.db.char.clusters) do
        newClusterData[newIndex] = self.state.clusterData[i]
        newIndex = newIndex + 1
    end
    self.state.clusterData = newClusterData

    self:UpdateTracking()
    return true
end

function UptimeTrackerManager:GetCluster(clusterIndex)
    return self.db.char.clusters and self.db.char.clusters[clusterIndex] or nil
end

function UptimeTrackerManager:GetAllClusters()
    return self.db.char.clusters or {}
end

function UptimeTrackerManager:SetClusterEnabled(clusterIndex, enabled)
    if self.db.char.clusters and self.db.char.clusters[clusterIndex] then
        self.db.char.clusters[clusterIndex].enabled = enabled
        self:UpdateTracking()
        return true
    end
    return false
end

-- ~~~~~~~~~~ PUBLIC API ~~~~~~~~~~
function UptimeTrackerManager:IsEnabled()
    return self.db.char.enabled == true
end

function UptimeTrackerManager:SetEnabled(enabled)
    self.db.char.enabled = enabled
    self:UpdateTracking()
end

