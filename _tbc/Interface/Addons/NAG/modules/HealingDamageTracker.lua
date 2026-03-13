--- @module "HealingDamageTracker"
--- Tracks per-unit damage intake via CLEU events in a rolling time window.
--- Used by HealingPriorityManager for triage scoring urgency multiplier.
--- License: CC BY-NC 4.0
--- Discord: https://discord.gg/ebonhold

local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local GetTime = _G.GetTime
local UnitHealthMax = _G.UnitHealthMax
local wipe = wipe
local max = math.max

local DAMAGE_WINDOW_SEC = 3
local MAX_ENTRIES_PER_UNIT = 20

local defaults = {
    char = {
        enabled = nil,
    }
}

local HealingDamageTracker = NAG:CreateModule("HealingDamageTracker", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,
    optionsCategory = "features",
    debugCategories = { ns.DEBUG_CATEGORIES.FEATURES },
    cleuHandlers = {
        SWING_DAMAGE = "OnDamageEvent",
        SPELL_DAMAGE = "OnDamageEvent",
        SPELL_PERIODIC_DAMAGE = "OnDamageEvent",
        RANGE_DAMAGE = "OnDamageEvent",
        ENVIRONMENTAL_DAMAGE = "OnDamageEvent",
    },
    eventHandlers = {
        PLAYER_REGEN_ENABLED = "OnCombatEnd",
    },
})

-- Storage: guidData[guid] = { entries = { {amount, time}, ... }, writeIdx = 1 }
local guidData = {}

-- Circular buffer: record a damage event for a GUID
function HealingDamageTracker:RecordDamage(destGUID, amount, timestamp)
    if not destGUID or not amount or amount <= 0 then return end
    timestamp = timestamp or GetTime()

    local data = guidData[destGUID]
    if not data then
        data = { entries = {}, writeIdx = 1 }
        guidData[destGUID] = data
    end

    local idx = data.writeIdx
    local entry = data.entries[idx]
    if not entry then
        entry = {}
        data.entries[idx] = entry
    end
    entry[1] = amount
    entry[2] = timestamp

    data.writeIdx = (idx % MAX_ENTRIES_PER_UNIT) + 1
end

-- Sum damage within the last `windowSec` seconds for a GUID
function HealingDamageTracker:GetRecentDamage(guid, windowSec)
    if not guid then return 0 end
    local data = guidData[guid]
    if not data then return 0 end

    windowSec = windowSec or DAMAGE_WINDOW_SEC
    local now = GetTime()
    local cutoff = now - windowSec
    local total = 0

    local entries = data.entries
    for i = 1, #entries do
        local entry = entries[i]
        local ts = entry and entry[2]
        if ts and ts >= cutoff then
            total = total + entry[1]
        end
    end
    return total
end

-- Get recent damage as fraction of max health
function HealingDamageTracker:GetRecentDamagePct(guid, unitId, windowSec)
    local dmg = self:GetRecentDamage(guid, windowSec)
    if dmg <= 0 then return 0 end

    local maxH = UnitHealthMax(unitId)
    if not maxH or maxH <= 0 then return 0 end
    return dmg / maxH
end

-- CLEU handler: extract damage amount from combat log args
function HealingDamageTracker:OnDamageEvent(timestamp, subEvent, hideCaster,
    sourceGUID, sourceName, sourceFlags, sourceRaidFlags,
    destGUID, destName, destFlags, destRaidFlags, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20,
    arg21, arg22, arg23, arg24)

    -- Only track damage to friendly group members
    if not destGUID then return end
    local destInGroup = bit.band(destFlags or 0, COMBATLOG_OBJECT_AFFILIATION_MINE + COMBATLOG_OBJECT_AFFILIATION_PARTY + COMBATLOG_OBJECT_AFFILIATION_RAID) > 0
    if not destInGroup then return end

    local amount
    if subEvent == "SWING_DAMAGE" then
        amount = arg12
    elseif subEvent == "ENVIRONMENTAL_DAMAGE" then
        amount = arg13
    else
        -- SPELL_DAMAGE, SPELL_PERIODIC_DAMAGE, RANGE_DAMAGE: amount is arg 4 after spell info
        amount = arg15
    end

    if amount and amount > 0 then
        self:RecordDamage(destGUID, amount, timestamp)
    end
end

-- Clear all data on combat end
function HealingDamageTracker:OnCombatEnd(event)
    self:WipeCombatData()
end

function HealingDamageTracker:WipeCombatData()
    wipe(guidData)
end

-- Expose for other modules
function HealingDamageTracker:GetDamageWindowSeconds()
    return DAMAGE_WINDOW_SEC
end
