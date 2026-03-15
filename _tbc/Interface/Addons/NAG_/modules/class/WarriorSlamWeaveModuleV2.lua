--- @module "NAG.WarriorSlamWeaveModuleV2"
--- Runtime timing tracker for Warrior Slam weave visuals (V2).
---
--- Tracks runtime-only state:
--- - last main-hand swing time
--- - slam cast success timing vs last swing
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

-- ============================ LOCALIZE ============================
local _, ns = ...
local GetTime = _G.GetTime

--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ DEFAULTS ============================
local defaults = {
    class = {
        enabled = true,
    }
}

--- @class WarriorSlamWeaveModuleV2:CoreModule
local WarriorSlamWeaveModuleV2 = NAG:CreateModule("WarriorSlamWeaveModuleV2", defaults, {
    moduleType = ns.MODULE_TYPES.CLASS,
    className = "WARRIOR",
    optionsCategory = ns.MODULE_CATEGORIES.CLASS,
    debugCategories = { ns.DEBUG_CATEGORIES.CLASS },
    eventHandlers = {
        PLAYER_REGEN_DISABLED = "OnCombatStateChanged",
        PLAYER_REGEN_ENABLED = "OnCombatStateChanged",
    },
    cleuHandlers = {
        SWING_DAMAGE = "HandleCLEUSwing",
        SWING_MISSED = "HandleCLEUSwing",
        SPELL_CAST_SUCCESS = "HandleCLEUSpellCastSuccess",
    },
    defaultState = {
        inCombat = false,
        swingCount = 0,
        lastSwingTime = 0,
        lastSlamSuccessTime = 0,
        lastSlamDeltaFromSwing = 0,
    }
})

ns.WarriorSlamWeaveModuleV2 = WarriorSlamWeaveModuleV2
local module = WarriorSlamWeaveModuleV2

-- ============================ INTERNALS ============================

local SLAM_SPELL_IDS = {
    1464,  -- Slam (Rank 1)
    8820,  -- Slam (Rank 3)
    11604, -- Slam (Rank 4)
    11605, -- Slam (Rank 5)
    25241, -- Slam (Rank 6, TBC)
}

local function isSlamSpellId(spellId)
    if not spellId then
        return false
    end
    for i = 1, #SLAM_SPELL_IDS do
        if spellId == SLAM_SPELL_IDS[i] then
            return true
        end
    end
    return false
end

local function isPlayerSourceGUID(sourceGUID)
    return sourceGUID and NAG.state and NAG.state.player and sourceGUID == NAG.state.player.guid
end

-- ============================ LIFECYCLE ============================

function module:ModuleInitialize()
    -- No heavy work; events are wired via declarative tables.
end

function module:ModuleEnable()
    local playerClass = NAG.CLASS_FILENAME
    if playerClass ~= "WARRIOR" then
        self:SetEnabledState(false)
        return
    end

    self:InitializeState()
    self.state.inCombat = false
    self.state.swingCount = 0
    self.state.lastSwingTime = 0
    self.state.lastSlamSuccessTime = 0
    self.state.lastSlamDeltaFromSwing = 0
end

function module:ModuleDisable()
    self:InitializeState()
    self.state.inCombat = false
    self.state.swingCount = 0
    self.state.lastSwingTime = 0
    self.state.lastSlamSuccessTime = 0
    self.state.lastSlamDeltaFromSwing = 0
end

-- ============================ EVENT HANDLING ============================

function module:OnCombatStateChanged(event)
    if not self.db.class.enabled then
        return
    end

    self:InitializeState()
    self.state.inCombat = (event == "PLAYER_REGEN_DISABLED")
    self.state.swingCount = 0
    self.state.lastSwingTime = 0
    self.state.lastSlamSuccessTime = 0
    self.state.lastSlamDeltaFromSwing = 0
end

--- Handle main-hand swing events
--- @param timestamp number
--- @param subEvent string
--- @param hideCaster boolean
--- @param sourceGUID string
function module:HandleCLEUSwing(timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags,
    destGUID, destName, destFlags, destRaidFlags, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20,
    arg21, arg22, arg23, arg24)
    if not self.db.class.enabled then
        return
    end
    if not isPlayerSourceGUID(sourceGUID) then
        return
    end

    self:InitializeState()
    self.state.swingCount = (self.state.swingCount or 0) + 1
    self.state.lastSwingTime = GetTime()
end

--- Handle Slam cast success timing
--- @param timestamp number
--- @param subEvent string
--- @param hideCaster boolean
--- @param sourceGUID string
--- @param sourceName string
--- @param sourceFlags number
--- @param sourceRaidFlags number
--- @param destGUID string
--- @param destName string
--- @param destFlags number
--- @param destRaidFlags number
function module:HandleCLEUSpellCastSuccess(
    timestamp,
    subEvent,
    hideCaster,
    sourceGUID,
    sourceName,
    sourceFlags,
    sourceRaidFlags,
    destGUID,
    destName,
    destFlags,
    destRaidFlags,
    arg12,
    arg13,
    arg14,
    arg15,
    arg16,
    arg17,
    arg18,
    arg19,
    arg20,
    arg21,
    arg22,
    arg23,
    arg24
)
    local spellId = arg12
    if not self.db.class.enabled then
        return
    end
    if not isPlayerSourceGUID(sourceGUID) then
        return
    end
    if not isSlamSpellId(spellId) then
        return
    end

    self:InitializeState()
    local now = GetTime()
    self.state.lastSlamSuccessTime = now
    if self.state.lastSwingTime and self.state.lastSwingTime > 0 then
        self.state.lastSlamDeltaFromSwing = now - self.state.lastSwingTime
    else
        self.state.lastSlamDeltaFromSwing = 0
    end
end

-- ============================ PUBLIC API ============================

--- Get a snapshot of the current Slam weave timing state
--- @return table state
function module:GetSlamWeaveState()
    self:InitializeState()
    return self.state
end
