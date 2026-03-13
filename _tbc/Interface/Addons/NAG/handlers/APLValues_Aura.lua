--- @module "APLValues_Aura"
--- Aura-related APL value functions for the NAG addon
---
--- This module provides utility functions for aura checking, timing, stacks, and aura management.
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

-- Libraries
local L = ns.AceLocale:GetLocale("NAG", true)
local RC = ns.RC

-- Lua APIs (WoW optimized where available)
local GetTime = _G.GetTime
local UnitExists = _G.UnitExists
local UnitClassBase = _G.UnitClassBase
local UnitName = _G.UnitName
local GetTotemInfo = _G.GetTotemInfo
local GetTotemTimeLeft = _G.GetTotemTimeLeft
local IsInRaid = _G.IsInRaid
local IsInGroup = _G.IsInGroup
local GetWeaponEnchantInfo = _G.GetWeaponEnchantInfo
local GetTime = _G.GetTime
local SpellIsKnown = _G.SpellIsKnown
local IsSpellKnown = _G.IsSpellKnown
local CreateFrame = _G.CreateFrame
local UnitGUID = _G.UnitGUID
local UnitInParty = _G.UnitInParty
local UnitInRaid = _G.UnitInRaid
local UnitIsDeadOrGhost = _G.UnitIsDeadOrGhost
local RegisterAddonMessagePrefix = C_ChatInfo and C_ChatInfo.RegisterAddonMessagePrefix
local SendAddonMessage = C_ChatInfo and C_ChatInfo.SendAddonMessage or _G.SendAddonMessage
local Version = ns.Version

-- NOTE:
-- This file contains both:
-- - Core aura APIs used by rotations across flavors (e.g. NAG:AuraIsActive)
-- - TBC-only Windfury/totem twisting helpers (which must NOT register listeners outside TBC)
local isTBC = Version and Version.IsTBC and Version:IsTBC() or false


local format = string.format
local floor = math.floor
local min = math.min
local max = math.max

local tinsert = tinsert
local wipe = wipe
local tContains = tContains

local sort = table.sort
local concat = table.concat
local pairs = pairs
local ipairs = ipairs
local type = type
local tostring = tostring
local tonumber = tonumber

local WIND_FURY_MELEE_CLASSES = {
    PALADIN = true,
    ROGUE = true,
    WARRIOR = true,
}

local CURSE_OF_RECKLESSNESS_MELEE_CLASSES = {
    PALADIN = true,
    ROGUE = true,
    WARRIOR = true,
    HUNTER = true,
    SHAMAN = true,
}

local WIND_FURY_TOTEM_BUFF_IDS = {
    [8516] = true,   -- Windfury Totem (Rank 1 weapon buff)
    [10608] = true,  -- Windfury Totem (Rank 2 weapon buff)
    [10610] = true,  -- Windfury Totem (Rank 3 weapon buff)
    [25583] = true,  -- Windfury Totem (Rank 4 weapon buff)
    [25584] = true,  -- Windfury Totem (Rank 5 weapon buff)
}

-- Totem-provided player aura IDs (these are BUFFS on players, not the totem cast spell IDs).
-- Important: These buffs can come from OTHER shamans, so they must be checked via aura scan
-- rather than player totem-slot state.
local TOTEM_OF_WRATH_BUFF_IDS = {
    [30708] = true, -- Totem of Wrath (buff aura)
}

local WRATH_OF_AIR_BUFF_IDS = {
    [2895] = true, -- Wrath of Air Totem (buff aura)
}

local MANA_SPRING_BUFF_IDS = {
    [5677] = true,  -- Mana Spring (Rank 1 buff aura)
    [10491] = true, -- Mana Spring (Rank 2 buff aura)
    [10493] = true, -- Mana Spring (Rank 3 buff aura)
    [10494] = true, -- Mana Spring (Rank 4 buff aura)
    [24853] = true, -- Mana Spring (Rank 5 buff aura)
    [25569] = true, -- Mana Spring (Rank 6 buff aura)
}

-- Windfury Totem temporary weapon enchant IDs (player-only visibility)
-- These are distinct from Windfury Weapon imbue IDs.
local WIND_FURY_TOTEM_SPELL_IDS = {
    [8512] = true,
    [10613] = true,
    [10614] = true,
    [25585] = true,
    [25587] = true,
}

local WIND_FURY_TOTEM_ORDER = { 25587, 25585, 10614, 10613, 8512 }
local GRACE_OF_AIR_TOTEM_ORDER = { 25359, 10627, 8835 }
local STRENGTH_OF_EARTH_TOTEM_ORDER = { 25528, 25361, 10442, 8161, 8160, 8075 }
local MANA_SPRING_TOTEM_ORDER = { 25570, 10497, 10496, 10495, 5675 }
local SEARING_TOTEM_ORDER = { 38116, 25533, 10438, 10437, 6365, 6364, 6363, 6563, 3599 }
local FIRE_NOVA_TOTEM_ORDER = { 25547, 25546, 11315, 11314, 8499, 8498, 1535 }
-- Magma Totem ranks (Fire slot). Used for slot-based "is my Magma down?" checks.
-- Note: Totem slot APIs report the *exact* spellId of the currently active totem (rank-specific).
local MAGMA_TOTEM_ORDER = { 25552, 25550, 10587, 10586, 10585, 10581, 10580, 10579, 8190, 8187 }
local IMPROVED_FIRE_TOTEMS_RANK_1 = 16086
local IMPROVED_FIRE_TOTEMS_RANK_2 = 16544

local function BuildTotemSet(list)
    local set = {}
    for _, spellId in ipairs(list) do
        set[spellId] = true
    end
    return set
end

local WIND_FURY_TOTEM_SET = BuildTotemSet(WIND_FURY_TOTEM_ORDER)
local GRACE_OF_AIR_TOTEM_SET = BuildTotemSet(GRACE_OF_AIR_TOTEM_ORDER)
local STRENGTH_OF_EARTH_TOTEM_SET = BuildTotemSet(STRENGTH_OF_EARTH_TOTEM_ORDER)
local MANA_SPRING_TOTEM_SET = BuildTotemSet(MANA_SPRING_TOTEM_ORDER)
local SEARING_TOTEM_SET = BuildTotemSet(SEARING_TOTEM_ORDER)
local FIRE_NOVA_TOTEM_SET = BuildTotemSet(FIRE_NOVA_TOTEM_ORDER)
local MAGMA_TOTEM_SET = BuildTotemSet(MAGMA_TOTEM_ORDER)

local TOTEM_SLOT_BY_SPELLID = {}
local TOTEM_SET_BY_SPELLID = {}

local function RegisterTotemSet(order, set, slot)
    for _, spellId in ipairs(order) do
        TOTEM_SLOT_BY_SPELLID[spellId] = slot
        TOTEM_SET_BY_SPELLID[spellId] = set
    end
end

-- Totem slots: Fire=1, Earth=2, Water=3, Air=4
RegisterTotemSet(WIND_FURY_TOTEM_ORDER, WIND_FURY_TOTEM_SET, 4)
RegisterTotemSet(GRACE_OF_AIR_TOTEM_ORDER, GRACE_OF_AIR_TOTEM_SET, 4)
RegisterTotemSet(STRENGTH_OF_EARTH_TOTEM_ORDER, STRENGTH_OF_EARTH_TOTEM_SET, 2)
RegisterTotemSet(MANA_SPRING_TOTEM_ORDER, MANA_SPRING_TOTEM_SET, 3)
RegisterTotemSet(SEARING_TOTEM_ORDER, SEARING_TOTEM_SET, 1)
RegisterTotemSet(FIRE_NOVA_TOTEM_ORDER, FIRE_NOVA_TOTEM_SET, 1)
RegisterTotemSet(MAGMA_TOTEM_ORDER, MAGMA_TOTEM_SET, 1)

local function IsTotemActiveAnyRank(slot, set)
    if not GetTotemInfo then
        return false
    end
    local hasTotem, _, _, _, _, _, totemSpellId = GetTotemInfo(slot)
    if not hasTotem or not totemSpellId then
        return false
    end
    return set[totemSpellId] == true
end

function NAG:IsWFTotemActiveAnyRank()
    return IsTotemActiveAnyRank(4, WIND_FURY_TOTEM_SET)
end

function NAG:IsGoATotemActiveAnyRank()
    return IsTotemActiveAnyRank(4, GRACE_OF_AIR_TOTEM_SET)
end

function NAG:IsSoETotemActiveAnyRank()
    return IsTotemActiveAnyRank(2, STRENGTH_OF_EARTH_TOTEM_SET)
end

function NAG:IsManaSpringTotemActiveAnyRank()
    return IsTotemActiveAnyRank(3, MANA_SPRING_TOTEM_SET)
end

function NAG:IsSearingTotemActiveAnyRank()
    return IsTotemActiveAnyRank(1, SEARING_TOTEM_SET)
end

function NAG:IsFireNovaTotemActiveAnyRank()
    return IsTotemActiveAnyRank(1, FIRE_NOVA_TOTEM_SET)
end

function NAG:IsMagmaTotemActiveAnyRank()
    return IsTotemActiveAnyRank(1, MAGMA_TOTEM_SET)
end

--- Returns true when Shaman fire totem slot has no active fire totem (and no Fire Elemental).
--- Treats Fire Nova windup as "slot occupied" so we don't suggest Searing/Magma before it explodes.
--- @return boolean
function NAG:FireTotemSlotNeedsFill()
    return (not NAG:IsTotemActiveResolved(2894))
        and (not NAG:IsSearingTotemActiveAnyRank())
        and (not NAG:IsFireNovaTotemActiveOrInWindup())
        and (not NAG:IsMagmaTotemActiveAnyRank())
end

--- Rank-agnostic totem check by spell ID (returns nil if not a tracked totem).
--- @param spellId number
--- @return boolean|nil
function NAG:IsTotemActiveAnyRankForSpell(spellId)
    local slot = TOTEM_SLOT_BY_SPELLID[spellId]
    if not slot then
        return nil
    end
    local set = TOTEM_SET_BY_SPELLID[spellId]
    if not set then
        return nil
    end
    return IsTotemActiveAnyRank(slot, set)
end

local windfuryUnitCache = {
    lastScan = 0,
    units = {},
}

local wfState = {
    lastWFDrop = 0,
    lastWFSpellId = nil,
    lastWFPulse = 0,
    lastGoADrop = 0,
    lastGoASpellId = nil,
    forceWF = false,
    forceWFReason = nil,
}

local WF_DURATION = 10
local WF_ICD = 5
local WF_ADDON_PREFIX = "NAG_WF_REQ"
local TOTEMIC_CALL_SPELL_ID = 36936

local cachedBestWF = nil
local cachedBestGoA = nil
local cachedBestSoE = nil
local cachedBestMS = nil
local cachedBestSearing = nil
local lastSoEDrop = 0
local lastMSDrop = 0
local lastSearingDrop = 0
local lastFireNovaDrop = 0
local lastWFNoBuffSeen = 0
local lastWFRequestSent = 0
local lastWFRequestReceived = 0

-- Windfury Weapon (self-imbue) enchant IDs (TBC ranks)
local WF_WEAPON_ENCHANT_IDS = {
    [283] = true, -- Rank 1
    [284] = true, -- Rank 2
    [525] = true, -- Rank 3
    [1669] = true, -- Rank 4
    [2636] = true, -- Observed TBC WF imbue
    -- Add more if observed in data
}

local function GetWindfuryUnits()
    local now = GetTime()
    if windfuryUnitCache.lastScan and (now - windfuryUnitCache.lastScan) < 0.6 then
        return windfuryUnitCache.units
    end

    local units = windfuryUnitCache.units
    wipe(units)
    local subgroupUnits = NAG:GetSubgroupMemberUnits()
    for i = 1, #subgroupUnits do
        tinsert(units, subgroupUnits[i])
    end

    windfuryUnitCache.lastScan = now
    return units
end

-- ============================ WIND FURY / GOA HELPERS ============================

local function IsKnownSpellId(spellId)
    if not spellId then return false end
    if SpellIsKnown and SpellIsKnown(spellId) then
        return true
    end
    if IsSpellKnown and IsSpellKnown(spellId) then
        return true
    end
    if NAG and NAG.SpellIsKnown and NAG:SpellIsKnown(spellId) then
        return true
    end
    return false
end

local function GetHighestKnownFromList(order)
    for _, spellId in ipairs(order) do
        if IsKnownSpellId(spellId) then
            return spellId
        end
    end
    return nil
end

local function GetLowestKnownFromList(order)
    local lastKnown = nil
    for i = #order, 1, -1 do
        local spellId = order[i]
        if IsKnownSpellId(spellId) then
            lastKnown = spellId
        end
    end
    return lastKnown
end

function NAG:GetBestWFTotemSpell()
    if cachedBestWF then
        return cachedBestWF
    end
    local spellId = GetHighestKnownFromList(WIND_FURY_TOTEM_ORDER)
    if spellId then
        cachedBestWF = spellId
    end
    return spellId
end

function NAG:GetBestGoATotemSpell()
    if cachedBestGoA then
        return cachedBestGoA
    end
    local spellId = GetHighestKnownFromList(GRACE_OF_AIR_TOTEM_ORDER)
    if spellId then
        cachedBestGoA = spellId
    end
    return spellId
end

function NAG:GetBestSoETotemSpell()
    if cachedBestSoE then
        return cachedBestSoE
    end
    local spellId = GetHighestKnownFromList(STRENGTH_OF_EARTH_TOTEM_ORDER)
    if spellId then
        cachedBestSoE = spellId
    end
    return spellId
end

function NAG:GetBestManaSpringTotemSpell()
    if cachedBestMS then
        return cachedBestMS
    end
    local spellId = GetHighestKnownFromList(MANA_SPRING_TOTEM_ORDER)
    if spellId then
        cachedBestMS = spellId
    end
    return spellId
end

function NAG:GetBestSearingTotemSpell()
    if cachedBestSearing then
        return cachedBestSearing
    end
    local spellId = GetHighestKnownFromList(SEARING_TOTEM_ORDER)
    if spellId then
        cachedBestSearing = spellId
    end
    return spellId
end

function NAG:RecordWFTotemCast(spellId)
    if not spellId then return end
    wfState.lastWFDrop = GetTime()
    wfState.lastWFPulse = wfState.lastWFDrop
    wfState.lastWFSpellId = spellId
    wfState.forceWF = false
end

function NAG:RecordGoATotemCast(spellId)
    if not spellId then return end
    wfState.lastGoADrop = GetTime()
    wfState.lastGoASpellId = spellId
end

function NAG:RecordSoETotemCast(spellId)
    if not spellId then return end
    lastSoEDrop = GetTime()
end

function NAG:RecordManaSpringTotemCast(spellId)
    if not spellId then return end
    lastMSDrop = GetTime()
end

function NAG:RecordSearingTotemCast(spellId)
    if not spellId then return end
    lastSearingDrop = GetTime()
end

function NAG:RecordFireNovaTotemCast(spellId)
    if not spellId then return end
    lastFireNovaDrop = GetTime()
    -- Fire Nova replaces the active fire totem, so Searing refresh timing must restart.
    lastSearingDrop = 0
end

--- Clears tracked totem timers after Totemic Call.
--- @return nil
function NAG:RecordTotemicCall()
    wfState.lastWFDrop = 0
    wfState.lastWFPulse = 0
    wfState.lastWFSpellId = nil
    wfState.lastGoADrop = 0
    wfState.lastGoASpellId = nil
    wfState.forceWF = false
    wfState.forceWFReason = nil

    lastSoEDrop = 0
    lastMSDrop = 0
    lastSearingDrop = 0
    lastFireNovaDrop = 0

    if ns.Totem_Tracking and ns.Totem_Tracking.ClearAll then
        ns.Totem_Tracking:ClearAll()
    end
end

function NAG:ForceWFRefresh(reason)
    wfState.forceWF = true
    wfState.forceWFReason = reason or "external"
end

function NAG:WFSecondsRemaining()
    local now = GetTime()
    local hasActiveTotem = false
    local totemRemaining = 0
    local totemSpellId

    -- Prefer explicit WF totem in slot 4
    if GetTotemInfo and GetTotemTimeLeft then
        local tHas, _, startTime, duration, _, _, tSpell = GetTotemInfo(4)
        if tHas and tSpell and WIND_FURY_TOTEM_SPELL_IDS[tSpell] then
            hasActiveTotem = true
            totemSpellId = tSpell
            totemRemaining = GetTotemTimeLeft(4) or 0
            if totemRemaining == 0 and duration and startTime then
                totemRemaining = (startTime + duration) - now
            end
            if totemRemaining < 0 then totemRemaining = 0 end
            if totemRemaining > WF_DURATION then totemRemaining = WF_DURATION end
        end
    end

    -- If no recorded drop and no active totem, no timer
    if (wfState.lastWFDrop or 0) <= 0 and not hasActiveTotem then
        return 0
    end

    -- Seed pulse if totem active but no pulse recorded
    if hasActiveTotem and (wfState.lastWFPulse or 0) <= 0 then
        wfState.lastWFPulse = now
    end

    -- If recorded drop is stale and no totem, clear
    if (wfState.lastWFDrop or 0) > 0 and not hasActiveTotem and (now - wfState.lastWFDrop) > WF_DURATION then
        wfState.lastWFDrop = 0
        wfState.lastWFSpellId = nil
        wfState.lastWFPulse = 0
        return 0
    end

    -- Advance pulse timer if totem is active; pulse every WF_ICD
    if hasActiveTotem and (wfState.lastWFPulse or 0) > 0 then
        local sincePulse = now - wfState.lastWFPulse
        if sincePulse >= WF_ICD then
            local pulses = math.floor(sincePulse / WF_ICD)
            wfState.lastWFPulse = wfState.lastWFPulse + pulses * WF_ICD
        end
    end

    -- Use the better of cached drop remaining vs totem remaining
    if (wfState.lastWFDrop or 0) > 0 then
        local baseRemaining = WF_DURATION - (now - wfState.lastWFDrop)
        local pulseRemaining = (wfState.lastWFPulse or 0) > 0 and (WF_DURATION - (now - wfState.lastWFPulse)) or 0
        if pulseRemaining < 0 then pulseRemaining = 0 end
        local remaining = math.max(baseRemaining, totemRemaining)
        if pulseRemaining > 0 then
            local effective = baseRemaining
            if totemRemaining > effective then
                effective = totemRemaining
            end
            -- allow countdown; use the lesser of effective and pulseRemaining
            remaining = math.min(effective, pulseRemaining)
        end
        if remaining < 0 then remaining = 0 end
        if remaining > WF_DURATION then remaining = WF_DURATION end
        return remaining
    end

    if hasActiveTotem then
        local pulseRemaining = (wfState.lastWFPulse or 0) > 0 and (WF_DURATION - (now - wfState.lastWFPulse)) or 0
        if pulseRemaining < 0 then pulseRemaining = 0 end
        local remaining = totemRemaining
        if pulseRemaining > 0 then
            remaining = math.min(remaining, pulseRemaining)
        end
        if remaining < 0 then remaining = 0 end
        if remaining > WF_DURATION then remaining = WF_DURATION end
        return remaining
    end

    return 0
end

function NAG:WFNeedsRefresh()
    local forceTwistEnabled = false
    local classModule = NAG and NAG.Class
    if classModule and classModule.IsAssignmentEnabled then
        forceTwistEnabled = classModule:IsAssignmentEnabled("shaman_totem_twist_force") == true
    end

    local shouldTwist = forceTwistEnabled or wfState.forceWF or NAG:ShouldTwistWindfury()
    if not shouldTwist then
        return false
    end

    local remaining = NAG:WFSecondsRemaining()

    if wfState.forceWF then
        return true
    end

    -- Force Twist should recover immediately when WF is missing.
    if remaining <= 0 then
        return forceTwistEnabled
    end

    if remaining <= 2 then
        return true
    end

    return false
end

-- ============================ WF MESSAGE LISTENER ============================
local function InitWFMessageListener()
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("CHAT_MSG_PARTY")
    frame:RegisterEvent("CHAT_MSG_PARTY_LEADER")
    frame:RegisterEvent("CHAT_MSG_ADDON")
    if RegisterAddonMessagePrefix then
        RegisterAddonMessagePrefix(WF_ADDON_PREFIX)
    end
    frame:SetScript("OnEvent", function(_, event, ...)
        if event == "CHAT_MSG_ADDON" then
            local prefix, message, _, sender = ...
            if prefix == WF_ADDON_PREFIX and message == "REQ" and sender then
                if (UnitInParty and UnitInParty(sender)) or (UnitInRaid and UnitInRaid(sender)) or true then
                    local now = GetTime()
                    if (now - lastWFRequestReceived) > 1 then
                        lastWFRequestReceived = now
                        if (now - (wfState.lastWFDrop or 0)) > 1.2 then
                            NAG:ForceWFRefresh("addon_msg")
                        end
                    end
                end
            end
        elseif event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER" then
            local message, sender = ...
            if message and message:find("NAG_WF_REQ") and sender and (UnitInParty(sender) or UnitInRaid(sender)) then
                local now = GetTime()
                if (now - lastWFRequestReceived) > 1 then
                    lastWFRequestReceived = now
                    if (now - (wfState.lastWFDrop or 0)) > 1.2 then
                        NAG:ForceWFRefresh("party_msg")
                    end
                end
            end
        end
    end)

    if RegisterAddonMessagePrefix then
        RegisterAddonMessagePrefix(WF_ADDON_PREFIX)
    end
end

if isTBC then
    InitWFMessageListener()
end

-- ============================ CAST LISTENER ============================
local function InitWFTotemCastListener()
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
    frame:SetScript("OnEvent", function(_, event, unit, _, spellId)
        if event ~= "UNIT_SPELLCAST_SUCCEEDED" or unit ~= "player" or not spellId then
            return
        end

        if spellId == TOTEMIC_CALL_SPELL_ID then
            NAG:RecordTotemicCall()
            return
        end

        if WIND_FURY_TOTEM_SPELL_IDS[spellId] then
            NAG:RecordWFTotemCast(spellId)
        elseif tContains(GRACE_OF_AIR_TOTEM_ORDER, spellId) then
            NAG:RecordGoATotemCast(spellId)
        elseif tContains(STRENGTH_OF_EARTH_TOTEM_ORDER, spellId) then
            NAG:RecordSoETotemCast(spellId)
        elseif tContains(MANA_SPRING_TOTEM_ORDER, spellId) then
            NAG:RecordManaSpringTotemCast(spellId)
        elseif tContains(SEARING_TOTEM_ORDER, spellId) then
            NAG:RecordSearingTotemCast(spellId)
        elseif tContains(FIRE_NOVA_TOTEM_ORDER, spellId) then
            NAG:RecordFireNovaTotemCast(spellId)
        end
    end)
end

if isTBC then
    InitWFTotemCastListener()
end

-- ============================ CALL FOR WF ============================
function NAG:CallForWF()
    local now = GetTime()
    if (now - lastWFRequestSent) < 1 then
        return false
    end

    local count = NAG:GetNumGroupMembers()
    if not NAG:PlayerIsInGroup() or count == 0 then
        return false
    end

    if UnitIsDeadOrGhost and UnitIsDeadOrGhost("player") then
        return false
    end

    local remaining = NAG and NAG.WFSecondsRemaining and NAG:WFSecondsRemaining() or 0
    if remaining > 0 then
        -- we have buff active; no need to request
        return false
    end

    if (now - lastWFNoBuffSeen) < 0.5 then
        return false
    end
    lastWFNoBuffSeen = now
    local targets = {}
    local subgroupUnits = NAG:GetSubgroupMemberUnits()
    for i = 1, #subgroupUnits do
        local unit = subgroupUnits[i]
        if UnitExists(unit) then
            local dist = NAG and NAG.UnitDistance and NAG:UnitDistance(unit, 30) or -1
            if dist > 0 and dist <= 25 then
                local classToken = UnitClassBase and UnitClassBase(unit)
                if classToken == "SHAMAN" then
                    local name = UnitName(unit)
                    if name then
                        tinsert(targets, name)
                    end
                end
            end
        end
    end

    if #targets == 0 then
        return false
    end

    if SendAddonMessage and RegisterAddonMessagePrefix then
        RegisterAddonMessagePrefix(WF_ADDON_PREFIX)
        local didSend = false
        for _, name in ipairs(targets) do
            SendAddonMessage(WF_ADDON_PREFIX, "REQ", "WHISPER", name)
            didSend = true
        end
        lastWFRequestSent = now
        return false
    end

    return false
end

function NAG:GoANeedsSwap()
    local now = GetTime()
    local wfRemaining = NAG:WFSecondsRemaining()

    -- If WF timer is not active, do not swap GoA
    if wfRemaining <= 0 then
        return false
    end

    if not NAG:ShouldTwistWindfury() then
        -- Static GoA maintenance: re-drop every 30s if our cache is stale
        local goaActive = NAG:IsActive(25360) -- Grace of Air buff
        if not goaActive and (now - (wfState.lastGoADrop or 0)) > 2 then
            return true
        elseif not goaActive and (now - (wfState.lastGoADrop or 0)) > 30 then
            return true
        end
        return false
    end

    -- Twisting: swap to GoA shortly after WF drop if not just dropped
    if (wfState.lastWFDrop or 0) > 0 and (now - wfState.lastWFDrop) < WF_DURATION then
        local goaActive = NAG:IsActive(25360)
        if not goaActive and (now - wfState.lastGoADrop) > 1 then
            return true
        end
    end

    return false
end

-- ============================ WF WEAPON IMBUE HELPERS ============================
-- ============================ WEAPON ENCHANT HELPERS ============================
--- Checks whether the player has any temporary weapon enchant on a specific hand.
--- This is used for reminders like Rogue poisons where the important question is
--- "is the weapon enchanted at all?" rather than which specific enchant it is.
---
--- @param hand string "MH" (main hand) or "OH" (off hand)
--- @return boolean True if that hand has a temporary weapon enchant, false otherwise.
--- @usage if not NAG:HasWeaponEnchant("OH") then ... end
function NAG:HasWeaponEnchant(hand)
    if not GetWeaponEnchantInfo then
        return false
    end

    -- GetWeaponEnchantInfo returns 8 flat values, not a table.
    local hasMainHandEnchant, _, _, _,
          hasOffHandEnchant = GetWeaponEnchantInfo()

    if hand == "MH" then
        return hasMainHandEnchant == true
    end
    if hand == "OH" then
        return hasOffHandEnchant == true
    end

    return false
end

-- ============================ ROGUE POISON / WF BUFF HELPERS ============================
-- NOTE: These helpers intentionally use GetWeaponEnchantInfo() enchant IDs (temporary enchants),
-- because Rogue poisons / WF weapon buffs are not normal player auras.

-- TBC poison enchant IDs (from `NAG/tbc/data/enchants.lua`).
local DEADLY_POISON_ENCHANT_IDS = {
    [7] = true,    -- Deadly Poison
    [8] = true,    -- Deadly Poison II
    [626] = true,  -- Deadly Poison III
    [627] = true,  -- Deadly Poison IV
    [2630] = true, -- Deadly Poison V
    [2642] = true, -- Deadly Poison VI
    [2643] = true, -- Deadly Poison VII
}

local INSTANT_POISON_ENCHANT_IDS = {
    [323] = true,  -- Instant Poison
    [324] = true,  -- Instant Poison II
    [325] = true,  -- Instant Poison III
    [623] = true,  -- Instant Poison IV
    [624] = true,  -- Instant Poison V
    [625] = true,  -- Instant Poison VI
    [2641] = true, -- Instant Poison VII
}

--- Returns the current temporary enchant ID for the player's main-hand/off-hand, or nil if none.
--- @param hand string "MH" or "OH"
--- @return number|nil enchantId
function NAG:GetWeaponTempEnchantId(hand)
    if not GetWeaponEnchantInfo then
        return nil
    end

    local mhHas, _, _, mhEnchantId, ohHas, _, _, ohEnchantId = GetWeaponEnchantInfo()
    if hand == "MH" then
        return (mhHas and mhEnchantId) or nil
    end
    if hand == "OH" then
        return (ohHas and ohEnchantId) or nil
    end
    return nil
end

--- Checks whether the player's specified weapon has one of the given temporary enchant IDs.
--- @param hand string "MH" or "OH"
--- @param enchantSet table<number, boolean>
--- @return boolean
function NAG:HasWeaponTempEnchantFromSet(hand, enchantSet)
    if not enchantSet then
        return false
    end
    local enchantId = self:GetWeaponTempEnchantId(hand)
    if not enchantId then
        return false
    end
    return enchantSet[enchantId] == true
end

--- Returns true if the player's off-hand currently has any Deadly Poison enchant applied.
--- @return boolean
function NAG:RogueHasDeadlyPoisonOH()
    return self:HasWeaponTempEnchantFromSet("OH", DEADLY_POISON_ENCHANT_IDS)
end

--- Returns true if the player's main-hand currently has any Instant Poison enchant applied.
--- @return boolean
function NAG:RogueHasInstantPoisonMH()
    return self:HasWeaponTempEnchantFromSet("MH", INSTANT_POISON_ENCHANT_IDS)
end

--- Returns true if the player currently has any Windfury Totem weapon buff aura (any rank).
--- This is a buff (not the Shaman's self-imbue), and is used to avoid suggesting MH poisons
--- when the group is providing Windfury.
--- @return boolean
function NAG:HasWindfuryTotemWeaponBuff()
    for buffId, _ in pairs(WIND_FURY_TOTEM_BUFF_IDS) do
        if self:IsActiveAura(buffId, "player", false, true) then
            return true
        end
    end
    return false
end

--- Returns true if the player currently has the Totem of Wrath buff aura (any source).
--- This is used to avoid suggesting Totem of Wrath when another shaman is already providing it.
--- @return boolean
function NAG:HasTotemOfWrathBuff()
    for buffId, _ in pairs(TOTEM_OF_WRATH_BUFF_IDS) do
        if self:IsActiveAura(buffId, "player", false, true) then
            return true
        end
    end
    return false
end

--- Returns true if the player currently has the Wrath of Air Totem buff aura (any source).
--- @return boolean
function NAG:HasWrathOfAirTotemBuff()
    for buffId, _ in pairs(WRATH_OF_AIR_BUFF_IDS) do
        if self:IsActiveAura(buffId, "player", false, true) then
            return true
        end
    end
    return false
end

--- Returns true if the player currently has any Mana Spring buff aura (any rank, any source).
--- @return boolean
function NAG:HasManaSpringTotemBuff()
    for buffId, _ in pairs(MANA_SPRING_BUFF_IDS) do
        if self:IsActiveAura(buffId, "player", false, true) then
            return true
        end
    end
    return false
end

--- Returns remaining time (seconds) of Windfury Weapon on specified hand ("MH" or "OH"), or 0 if absent.
function NAG:WFWeaponRemaining(hand)
    local mhHas, mhTimeLeft, _, mhEnchantId, ohHas, ohTimeLeft, _, ohEnchantId = GetWeaponEnchantInfo()
    if hand == "MH" then
        if mhHas and mhEnchantId and WF_WEAPON_ENCHANT_IDS[mhEnchantId] then
            return (mhTimeLeft or 0) / 1000
        end
        return 0
    elseif hand == "OH" then
        if ohHas and ohEnchantId and WF_WEAPON_ENCHANT_IDS[ohEnchantId] then
            return (ohTimeLeft or 0) / 1000
        end
        return 0
    end
    return 0
end

function NAG:DebugWeaponEnchants()
    return true
end

function NAG:CastWFTotem()
    local spellId = NAG:GetBestWFTotemSpell()
    if not spellId then return false end
    if not NAG:SpellCanCast(spellId) then return false end
    return NAG:Cast(spellId)
end

--- Returns true if the best known Windfury Totem rank is currently castable.
--- @return boolean
function NAG:CanCastWFTotem()
    local spellId = NAG:GetBestWFTotemSpell()
    if not spellId then
        return false
    end
    return NAG:SpellCanCast(spellId)
end

--- Cast Grace of Air Totem (best rank).
--- @param position string|nil Optional NAG.SPELL_POSITIONS constant (PRIMARY, RIGHT, etc.)
--- @return boolean
function NAG:CastGoATotem(position)
    local spellId = NAG:GetBestGoATotemSpell()
    if not spellId then return false end
    if not NAG:SpellCanCast(spellId) then return false end
    return NAG:Cast(spellId, nil, position)
end

function NAG:CastSoETotem()
    local spellId = NAG:GetBestSoETotemSpell()
    if not spellId then return false end
    if not NAG:SpellCanCast(spellId) then return false end
    return NAG:Cast(spellId)
end

function NAG:CastManaSpringTotem()
    local spellId = NAG:GetBestManaSpringTotemSpell()
    if not spellId then return false end
    if not NAG:SpellCanCast(spellId) then return false end
    return NAG:Cast(spellId)
end

function NAG:CastSearingTotem()
    local spellId = NAG:GetBestSearingTotemSpell()
    if not spellId then return false end
    if not NAG:SpellCanCast(spellId) then return false end
    return NAG:Cast(spellId)
end

-- Simple duration-based fallbacks for non-tracked totems
local SOE_DURATION = 120
local MS_DURATION = 120
local SEARING_DURATION = 55

--- Returns Searing Totem duration used by refresh logic.
--- @return number
function NAG:GetSearingTotemDuration()
    return SEARING_DURATION
end

--- Returns Fire Nova detonation delay in seconds based on Improved Fire Totems talent rank.
--- @return number
function NAG:GetFireNovaDetonationDelaySeconds()
    if IsKnownSpellId(IMPROVED_FIRE_TOTEMS_RANK_2) then
        return 2
    end
    if IsKnownSpellId(IMPROVED_FIRE_TOTEMS_RANK_1) then
        return 3
    end
    return 4
end

--- Returns true if Fire Nova Totem is active (in slot) or in windup (recently cast, waiting to explode).
--- Use this to block Magma Totem until Fire Nova has detonated (per TBC-sim fire twist behavior).
--- @return boolean
function NAG:IsFireNovaTotemActiveOrInWindup()
    if NAG:IsFireNovaTotemActiveAnyRank() then
        return true
    end
    if (lastFireNovaDrop or 0) <= 0 then
        return false
    end
    local now = GetTime()
    local delay = NAG:GetFireNovaDetonationDelaySeconds()
    return (now - lastFireNovaDrop) < delay
end

function NAG:SoENeedsRefresh()
    local now = GetTime()
    if lastSoEDrop == 0 then return true end
    return (now - lastSoEDrop) >= (SOE_DURATION - 10)
end

function NAG:MSNeedsRefresh()
    local now = GetTime()
    if lastMSDrop == 0 then return true end
    return (now - lastMSDrop) >= (MS_DURATION - 10)
end

function NAG:SearingNeedsRefresh()
    local now = GetTime()
    if lastSearingDrop == 0 then return true end
    return (now - lastSearingDrop) >= (NAG:GetSearingTotemDuration() - 5)
end

local function ForEachRelevantUnit(callback)
    if not callback then return end
    local units = GetWindfuryUnits()
    for i = 1, #units do
        callback(units[i])
    end
end

-- ============================ MODULE CACHING (PERFORMANCE) ============================
-- Cache frequently accessed modules to avoid GetModule overhead in hot paths
local DataManager = ns.DataManager
local StateManager = ns.StateManager
local SpellTrackingManager = ns.SpellTrackingManager
local Types = ns.Types
local DisplayManager = ns.DisplayManager
local OverlayManager = ns.OverlayManager

local EXACT_AURA_ID_MATCH = {
    [1247275] = true, -- Tigereye Brew buff (shares name with stacks)
    [1247279] = true  -- Tigereye Brew stacks (shares name with buff)
}

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

-- ============================ AURA APL VALUE FUNCTIONS ============================
--- Returns the number of stacks of a specific aura on the given unit (defaults to player).
--- All special cases (totem, vengeance, etc.) are handled automatically by the enhanced UnitAura system.
--- Also handles item IDs by resolving them to their associated spell IDs.
--- @param auraId number The spell ID of the aura, or item ID.
--- @param sourceUnit? string The unit to check (defaults to "player").
--- @param useReactionTime? boolean Whether to use reaction time in calculations (defaults to true).
--- @param exactIdMatch? boolean If true, forces exact spell ID matching and skips name-based matching.
--- @return number The number of stacks of the aura, or 0 if not found.
--- @usage NAG:AuraNumStacks(73643) >= x
function NAG:AuraNumStacks(auraId, sourceUnit, useReactionTime, exactIdMatch)
    if not auraId then return 0 end
    sourceUnit = sourceUnit or "player"
    useReactionTime = useReactionTime ~= false -- Default to true
    if exactIdMatch == nil then
        exactIdMatch = EXACT_AURA_ID_MATCH[auraId] or false
    end

    -- Check if this is an item ID instead of a spell ID
    if not DataManager then return 0 end

    local item = DataManager:Get(auraId, DataManager.EntityTypes.ITEM)
    if item then
        if item.spellId then
            -- Use the associated spellId from the item
            return self:AuraNumStacks(item.spellId, sourceUnit, useReactionTime)
        else
            -- It's an item, but no associated spell
            return 0
        end
    end

    -- All special cases are handled automatically by UnitAura
    local aura = NAG:UnitAura(sourceUnit, auraId, nil, exactIdMatch)
    if aura == false then
        return 0 -- Aura doesn't exist
    end

    local expirationTime = aura.expirationTime
    if useReactionTime and expirationTime and expirationTime > 0 then
        local timeRemaining = expirationTime - NAG:NextTime()

        -- If aura expires within reaction time, return 0 stacks
        if timeRemaining <= self:InputDelay() then
            return 0
        end
    end

    return aura.count or 0
end

--- Returns true if the group contains at least one melee class that strongly benefits from Windfury twisting.
--- Solo play returns true to keep twisting for personal DPS.
--- @return boolean
function NAG:ShouldTwistWindfury()
    local memberCount = NAG:GetNumGroupMembers()
    if memberCount == 0 then
        return false
    end

    local found = false
    ForEachRelevantUnit(function(unit)
        if found then return end
        if UnitExists(unit) and UnitClassBase then
            -- Ignore offline/disconnected units (e.g., raid member DC'd).
            if UnitIsConnected and not UnitIsConnected(unit) then
                return
            end
            local classToken = UnitClassBase(unit)
            if classToken and WIND_FURY_MELEE_CLASSES[classToken] then
                found = true
            end
        end
    end)

    return found
end

--- Returns true if the group contains at least one melee class that benefits from Curse of Recklessness.
--- Solo play returns false (no reason to recommend CoR).
--- @return boolean
function NAG:ShouldUseCurseOfRecklessness()
    local memberCount = NAG:GetNumGroupMembers()
    if memberCount == 0 then
        return false
    end

    local found = false
    ForEachRelevantUnit(function(unit)
        if found then return end
        if UnitExists(unit) and UnitClassBase then
            if UnitIsConnected and not UnitIsConnected(unit) then
                return
            end
            local classToken = UnitClassBase(unit)
            if classToken and CURSE_OF_RECKLESSNESS_MELEE_CLASSES[classToken] then
                found = true
            end
        end
    end)

    return found
end

--- Returns true if another paladin is in the group (not the player). Uses subgroup scope (raid = subgroup only).
--- Solo play returns false.
--- @return boolean
function NAG:HasOtherPaladinInGroup()
    return NAG:HasOtherClassInGroup("PALADIN", "subgroup")
end

--- Returns the number of paladins in the group (including the player). Uses subgroup scope (raid = subgroup only).
--- Solo play returns 1 if player is a paladin, 0 otherwise.
--- @return number
function NAG:GetPaladinCountInGroup()
    return NAG:GetClassCountInGroup("PALADIN", "subgroup")
end

--- Returns true if the group contains at least one melee class that benefits from Faerie Fire.
--- Solo play returns false (no reason to recommend FF).
--- @return boolean
function NAG:ShouldUseFaerieFire()
    local memberCount = NAG:GetNumGroupMembers()
    if memberCount == 0 then
        return false
    end

    local found = false
    ForEachRelevantUnit(function(unit)
        if found then return end
        if UnitExists(unit) and UnitClassBase then
            if UnitIsConnected and not UnitIsConnected(unit) then
                return
            end
            local classToken = UnitClassBase(unit)
            if classToken and CURSE_OF_RECKLESSNESS_MELEE_CLASSES[classToken] then
                found = true
            end
        end
    end)

    return found
end

--- Returns true if any applicable melee unit currently has the Windfury Totem weapon buff.
--- @return boolean
function NAG:GroupHasWindfuryBuff()
    -- If our air totem slot is Windfury Totem and it's still up, assume group has WF (pulse on drop, then every 5s).
    if GetTotemInfo then
        local hasTotem, _, _, _, _, _, totemSpellId = GetTotemInfo(4) -- Air slot
        if hasTotem and totemSpellId and WIND_FURY_TOTEM_SPELL_IDS[totemSpellId] then
            return true
        end
    end

    -- Do not rely on UnitBuff scanning; assume WF applied when totem was dropped.
    return false
end

--- Returns the minimum remaining duration (seconds) of Windfury Totem weapon buff across relevant units.
--- Returns 0 if no buff is found.
--- @return number
function NAG:GroupWindfuryRemaining()
    -- Fallback: if Windfury Totem is still active in air slot, return min(10s, totem time left) as a safe estimate.
    if GetTotemInfo and GetTotemTimeLeft then
        local hasTotem, _, startTime, duration, _, _, totemSpellId = GetTotemInfo(4)
        if hasTotem and totemSpellId and WIND_FURY_TOTEM_SPELL_IDS[totemSpellId] then
            local remaining = GetTotemTimeLeft(4) or 0
            if remaining == 0 and duration and startTime then
                remaining = (startTime + duration) - GetTime()
            end
            if remaining > 10 then
                remaining = 10
            end
            if remaining < 0 then
                remaining = 0
            end
            return remaining
        end
    end

    return 0
end

--- Gets the remaining time (in seconds) of a specific aura on the given unit (defaults to player). Handles item IDs and validates spell existence.
--- @param auraId number The ID of the spell to check.
--- @param sourceUnit? string The unit to check (defaults to "player").
--- @return number The remaining time of the aura in seconds, or 0 if not found.
--- @usage NAG:AuraRemainingTime(73643) >= x
function NAG:AuraRemainingTime(auraId, sourceUnit)
    if not auraId then
        self:Error("AuraRemainingTime called with nil auraId")
        return 0
    end
    sourceUnit = sourceUnit or "player"
    -- Resolve to spellbook ID so we check the spell the player actually has
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(auraId)
        if resolved then
            auraId = resolved
        end
    end

    -- Validate spell exists
    local spell = DataManager:Get(auraId, DataManager.EntityTypes.SPELL)
    if not spell then
        -- Check if it's an item instead
        local item = DataManager:Get(auraId, DataManager.EntityTypes.ITEM)
        if item then
            if item.spellId then
                -- Use the associated spellId from the item
                return self:AuraRemainingTime(item.spellId, sourceUnit)
            else
                -- It's an item, but no associated spell
                return 0
            end
        end
        self:Error("AuraRemainingTime: ID not found: " .. tostring(auraId))
        return 0
    end
    local aura = NAG:UnitAura(sourceUnit, auraId)
    if not aura then
        return 0
    end
    local expirationTime = aura.expirationTime
    if not expirationTime then
        return 0
    end
    -- Sanity checks
    local currentTime = GetTime()
    if expirationTime < currentTime then return 0 end
    local remainingTime = expirationTime - NAG:NextTime()
    if remainingTime > (aura.duration or 0) * 2 then return 0 end
    return max(0, remainingTime)
end

--- Gets the remaining active time for an item in seconds.
--- @param id number The ID of the item.
--- @return number The remaining time in seconds
--- @usage NAG:ItemRemainingTime(12345) > 0
function NAG:ItemRemainingTime(id)
    if not id then return -1 end

    -- Validate ID
    if not tonumber(id) then
        self:Error(format("ItemRemainingTime: ID %s is not a number", tostring(id)))
        return -1
    end

    -- Try to find entity in DataManager
    local entity = DataManager:Get(id, DataManager.EntityTypes.ITEM)

    if not entity then
        self:Error(format("ItemRemainingTime: ID %s not found", tostring(id)))
        return -1
    end

    return entity:RemainingTime()
end

--- Determines if an aura should be refreshed based on its remaining time and a maximum allowed overlap.
--- This function checks not only the specified aura but also any other auras on the same unit,
--- including auras applied by other raid members, which apply the same debuff category.
--- For example, 'Should Refresh Debuff(Sunder Armor)' will return false if the unit has an active Expose Armor aura.
--- @param auraId number The spell ID of the aura.
--- @param maxOverlap number The maximum allowed overlap time in seconds.
--- @param sourceUnit? string The unit to check (defaults to "target").
--- @return boolean True if the aura should be refreshed, false otherwise.
--- @usage NAG:AuraShouldRefresh(7386, 5) -- Sunder Armor with 5 second overlap
function NAG:AuraShouldRefresh(auraId, maxOverlap, sourceUnit)
    if not auraId then return false end
    sourceUnit = sourceUnit or "target"
    maxOverlap = maxOverlap or 0

    -- Get spell from DataManager
    local spell = DataManager:Get(auraId, DataManager.EntityTypes.SPELL)
    if not spell then
        self:Error(format("AuraShouldRefresh: Spell %d not found", auraId))
        return false
    end

    -- Check if the aura is currently active and needs refresh based on timing or stacks
    local remainingTime = self:AuraRemainingTime(auraId, sourceUnit)
    local currentStacks = self:AuraNumStacks(auraId, sourceUnit)

    -- Get max stacks from spell data or known stackable debuffs
    local maxStacks = spell.maxStacks or self:GetKnownMaxStacks(auraId)

    -- Determine if refresh is needed based on timing and/or stacks
    local needsRefresh = false

    if maxStacks > 1 then
        -- For stackable debuffs, check if we need more stacks
        needsRefresh = currentStacks < maxStacks
        self:Debug(format(
            "AuraShouldRefresh: Stackable debuff %d - current stacks: %d, max stacks: %d, needs refresh: %s",
            auraId, currentStacks, maxStacks, tostring(needsRefresh)))
    else
        -- For non-stackable debuffs, check timing
        needsRefresh = remainingTime < maxOverlap
        self:Debug(format(
            "AuraShouldRefresh: Non-stackable debuff %d - remaining time: %.2f, max overlap: %.2f, needs refresh: %s",
            auraId, remainingTime, maxOverlap, tostring(needsRefresh)))
    end

    -- If it doesn't need refresh based on timing/stacks, return false
    if not needsRefresh then
        return false
    end

    -- Check for competing debuffs of the same type (exclusive effects)
    if spell.types and spell.types.DebuffType then
        local debuffTypes = type(spell.types.DebuffType) == "table" and
            spell.types.DebuffType or
            { spell.types.DebuffType }

        for _, debuffType in ipairs(debuffTypes) do
            -- Get all spells that provide this debuff type
            local debuffsOfType = DataManager:GetAllByType("DebuffType", debuffType)

            for competingSpellId in pairs(debuffsOfType) do
                -- Skip the spell we're checking
                if competingSpellId ~= auraId then
                    local competingSpell = DataManager:Get(competingSpellId, DataManager.EntityTypes.SPELL)
                    if competingSpell and competingSpell.flags.debufftype then
                        -- Check if this competing debuff is active on the target
                        if NAG:UnitDebuffGlobal(sourceUnit, competingSpellId) then
                            -- Check if the competing debuff has higher priority
                            if self:HasHigherPriority(competingSpellId, auraId, debuffType) then
                                self:Debug(format(
                                    "AuraShouldRefresh: Not refreshing %d - higher priority debuff %d is active",
                                    auraId, competingSpellId))
                                return false
                            end
                        end
                    end
                end
            end
        end
    end

    -- If we get here, the aura needs refresh and no higher priority competing debuff is active
    return true
end

--- Returns the remaining internal cooldown (ICD) for a given spell on the specified unit (defaults to player). Handles special cases for certain spell IDs.
--- @param auraId number The ID of the spell.
--- @param sourceUnit? string The unit to check (defaults to "player").
--- @return number The remaining ICD time in seconds, or 0 if not found.
--- @usage (NAG:AuraInternalCooldown(73643) <= 0)
function NAG:AuraInternalCooldown(auraId, sourceUnit)
    if not auraId then return 0 end
    sourceUnit = sourceUnit or "player"

    -- Check for custom behavior override first (O(1) lookup)
    if ns.EntityBehaviors and ns.EntityBehaviors.HasOverride and ns.EntityBehaviors.HasOverride("Spell", auraId, "AuraInternalCooldown") then
        return ns.EntityBehaviors.ExecuteBehavior("Spell", auraId, "AuraInternalCooldown", {id = auraId}, sourceUnit)
    end


    -- Get remaining ICD from SpellTrackingManager (handles trinket procs)
    return SpellTrackingManager:GetICDInfo(auraId, sourceUnit) or 0
end


--- Checks if the internal cooldown (ICD) for a given spell is ready (i.e., not on cooldown) for the specified unit (defaults to player).
--- @param auraId number The ID of the spell.
--- @param sourceUnit? string The unit to check (defaults to "player").
--- @param useReactionTime? boolean Whether to use reaction time in calculations (defaults to true).
--- @return boolean True if the ICD is ready, false otherwise.
--- @usage (NAG:AuraICDIsReady(73643))
function NAG:AuraICDIsReady(auraId, sourceUnit, useReactionTime)
    if not auraId then return false end
    sourceUnit = sourceUnit or "player"
    useReactionTime = useReactionTime ~= false -- Default to true

    -- Get spell data from DataManager
    local spell = DataManager:Get(auraId, DataManager.EntityTypes.SPELL)
    if not spell then return false end

    local remain = self:AuraInternalCooldown(auraId, sourceUnit)

    if useReactionTime then
        local reactionTime = self:InputDelay()
        return remain <= reactionTime
    else
        return remain <= 0
    end
end


--- Checks if an aura is known/exists in the system (even if not currently active).
--- This is different from IsActiveAura - this checks if the aura exists at all.
--- @param auraId number The spell ID of the aura to check.
--- @param sourceUnit? string The unit to check (defaults to "player").
--- @return boolean True if the aura is known/exists, false otherwise.
--- @usage NAG:AuraIsKnown(73643) or NAG:AuraIsKnown(73643, "pet")
function NAG:AuraIsKnown(auraId, sourceUnit)
    if not auraId then return false end
    sourceUnit = sourceUnit or "player"

    -- Validate ID
    if not tonumber(auraId) then
        self:Error(format("AuraIsKnown: ID %s is not a number", tostring(auraId)))
        return false
    end

    -- Check if unit exists (important for pet units)
    if sourceUnit == "pet" and not UnitExists("pet") then return false end

    -- Try to find entity in DataManager
    local entity = DataManager:Get(auraId, DataManager.EntityTypes.SPELL) or
        DataManager:Get(auraId, DataManager.EntityTypes.ITEM)

    if not entity then
        self:Info(format("AuraIsKnown: ID %s not found", tostring(auraId)))
        return false
    end

    if entity.IsItem then
        return entity:IsKnown()
    elseif entity.IsSpell then
        if entity.flags.tierset then
            -- Route to tier set spell validation (checks if player has enough tier pieces)
            return self:IsKnownTierset(auraId)
        elseif entity.flags.enchant then
            return self:IsKnownEnchant(auraId)
        elseif entity.flags.battlepet then
            return entity:IsKnown()
        elseif entity.flags.glyph then
            return self:HasGlyph(auraId)
        elseif entity.flags.talent then
            local talent = DataManager:GetTalentBySpellId(auraId)
            if talent then
                return StateManager:HasTalent(talent.talentId)
            end
        elseif entity.flags.tinker then
            return self:IsKnownTinker(auraId)
        else
            return self:IsKnownSpell(auraId)
        end
    end

    self:Info(format("AuraIsKnown: ID %s not found", tostring(auraId)))
    return false
end

--- Checks if a spell, trinket, tinker, or item is currently active.
--- @param id number The ID or alias (e.g., "trinket1") of the item.
--- @param sourceUnit? string|nil Optional: the source unit of the aura.
--- @param includeReactionTime? boolean Whether to enforce reaction-time window for aura checks (defaults to true).
--- @param exactIdMatch? boolean If true, forces exact spell ID matching and skips name-based matching.
--- @return boolean True if the item is active, false otherwise.
--- @usage NAG:AuraIsActive(73643) or NAG:AuraIsActive(12345, "pet")
function NAG:AuraIsActive(id, sourceUnit, includeReactionTime, exactIdMatch)
    if not id then return false end
    --TODO: make this be native to the parser
    --id = translateSpellId(id)
    -- Validate ID
    if not tonumber(id) then
        self:Error(format("AuraIsActive: ID %s is not a number", tostring(id)))
        return false
    end
    -- Resolve to spellbook ID so we check the spell the player actually has
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(id)
        if resolved then
            id = resolved
        end
    end
    -- TODO: Check this
    if sourceUnit and sourceUnit == "target" then
        return self:DotIsActive(id, sourceUnit)
    end

    -- Check for custom behavior override first (O(1) lookup)
    if ns.EntityBehaviors and ns.EntityBehaviors.HasOverride and ns.EntityBehaviors.HasOverride("Spell", id, "IsActive") then
        return ns.EntityBehaviors.ExecuteBehavior("Spell", id, "IsActive", {id = id}, sourceUnit)
    end


    -- Try to find entity in DataManager
    if not DataManager then return false end

    local entity = DataManager:Get(id, DataManager.EntityTypes.SPELL) or
        DataManager:Get(id, DataManager.EntityTypes.ITEM)

    if not entity then
        self:Error(format("AuraIsActive: ID %s not found", tostring(id)))
        return false
    end

    if entity.IsItem then
        return entity:IsActive()
    elseif entity.IsSpell then
        if entity.types.TotemType then
            return (self:TotemRemainingTime(entity.types.TotemType) > 0)
        elseif entity.flags.stance then
            local formMatch = (StateManager:GetShapeshiftFormID() == entity.shapeshiftForm)
            if formMatch then return true end
            -- Paladin seals (and similar) appear as buffs, not shapeshift form in some clients; fall back to aura check
            return self:IsActiveAura(id, sourceUnit or "player", includeReactionTime, exactIdMatch)
        elseif entity.flags.pet and entity.flags.action then
            return self:IsActiveAura(id, "pet", includeReactionTime, exactIdMatch)
        elseif entity.flags.pet then
            return StateManager:IsActivePet(id)
        elseif entity.flags.tinker then
            return self:IsActiveTinker(id)
        elseif entity.flags.enchant then
            -- Enchant-triggered auras (e.g. Clearcasting 16870 from Omen of Clarity) appear as buffs on the
            -- player; IsActiveEnchant only checks weapon slots. Consider active if either is true.
            return self:IsActiveEnchant(id) or self:IsActiveAura(id, sourceUnit, includeReactionTime, exactIdMatch)
        elseif entity.flags.dot then
            return self:DotIsActive(id, sourceUnit)
        elseif entity.flags.battlepet then
            return entity:IsActive()
        else
            return self:IsActiveAura(id, sourceUnit, includeReactionTime, exactIdMatch)
        end
    end

    self:Error(format("AuraIsActive: ID %s: no valid flags found", tostring(id)))
    return false
end


--- Checks if an aura is inactive (not present) on the given unit.
--- @param auraId number The spell ID of the aura to check.
--- @param sourceUnit? string The unit to check (defaults to "player").
--- @param useReactionTime? boolean Whether to use reaction time in calculations (defaults to true).
--- @return boolean True if the aura is inactive, false if active.
--- @usage NAG:AuraIsInactive(73643) or NAG:AuraIsInactive(73643, "pet")
function NAG:AuraIsInactive(auraId, sourceUnit, useReactionTime)
    if not auraId then return true end
    sourceUnit = sourceUnit or "player"
    useReactionTime = useReactionTime ~= false -- Default to true

    -- Check if unit exists (important for pet units)
    if sourceUnit == "pet" and not UnitExists("pet") then return true end

    -- Get spell data from DataManager to check if aura is known
    if not DataManager then return true end

    local spell = DataManager:Get(auraId, DataManager.EntityTypes.SPELL)
    if not spell then
        -- Check if it's an item instead
        local item = DataManager:Get(auraId, DataManager.EntityTypes.ITEM)
        if item and item.spellId then
            return self:AuraIsInactive(item.spellId, sourceUnit, useReactionTime)
        end
        return true -- If spell/item not found, consider it inactive
    end

    -- Check if the aura is active - return inverse
    local aura = NAG:UnitAura(sourceUnit, auraId)
    if aura == false then
        return true -- Aura doesn't exist, so it's inactive
    end

    local expirationTime = aura.expirationTime
    if useReactionTime and expirationTime and expirationTime > 0 then
        local timeRemaining = expirationTime - NAG:NextTime()

        -- Return true (inactive) if aura expires within reaction time
        return timeRemaining <= self:InputDelay()
    end

    return false -- Aura is active
end

--- Checks if a unit has an active aura (buff or debuff).
--- @param auraId number The spell ID of the aura to check.
--- @param sourceUnit? string The unit to check (defaults to "player").
--- @param includeReactionTime? boolean Whether to enforce reaction-time window (defaults to true).
--- @param exactIdMatch? boolean If true, forces exact spell ID matching and skips name-based matching.
--- @return boolean True if the unit has the aura, false otherwise.
--- @usage NAG:IsActiveAura(73643) or NAG:IsActiveAura(73643, "pet")
--- @local This function is used to check if a unit has an active aura (buff or debuff).
function NAG:IsActiveAura(auraId, sourceUnit, includeReactionTime, exactIdMatch)
    if not auraId then return false end
    sourceUnit = sourceUnit or "player"
    includeReactionTime = includeReactionTime ~= false -- default to true
    if exactIdMatch == nil then
        exactIdMatch = EXACT_AURA_ID_MATCH[auraId] or false
    end

    -- Check if unit exists (important for pet units)
    if sourceUnit == "pet" and not UnitExists("pet") then return false end

    -- All special cases (Gargoyle, Dark Transformation, etc.) are handled by EnhancedAuraHandlers
    local aura = NAG:UnitAura(sourceUnit, auraId, nil, exactIdMatch)
    if aura == false then
        return false
    end

    if not includeReactionTime then
        return true
    end

    local expirationTime = aura.expirationTime
    if not expirationTime or expirationTime <= 0 then
        return true -- Permanent/unknown duration buffs ignore reaction time
    end

    local timeRemaining = expirationTime - NAG:NextTime()
    return timeRemaining > self:InputDelay()
end

--- Checks if a spell is an active enchant on the player's weapons.
--- @param spellId number The ID of the spell.
--- @return boolean True if the spell is an active enchant, false otherwise.
--- @usage NAG:IsActiveEnchant(73643)
--- @local This function is used to check if a spell is an active enchant on the player's weapons.
function NAG:IsActiveEnchant(spellId)
    local entity = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
    if not entity then return false end

    -- GetWeaponEnchantInfo returns 8 flat values, not a table
    local hasMainHandEnchant, mainHandExpiration, mainHandCharges, mainHandEnchantID,
          hasOffHandEnchant, offHandExpiration, offHandCharges, offHandEnchantID = GetWeaponEnchantInfo()

    local relatedEnchant = DataManager:GetRelated(spellId, DataManager.EntityTypes.SPELL,
        DataManager.EntityTypes.ENCHANT)
    local enchantId = next(relatedEnchant)

    -- Check if the enchant is active on either weapon
    return (hasMainHandEnchant and mainHandEnchantID == enchantId) or
           (hasOffHandEnchant and offHandEnchantID == enchantId)
end

--- Checks if an aura is active with reaction time consideration.
--- @param auraId number The spell ID of the aura to check.
--- @param sourceUnit? string The unit to check (defaults to "player").
--- @return boolean True if the aura is active with reaction time consideration.
--- @usage NAG:AuraIsActiveWithReactionTime(73643)
function NAG:AuraIsActiveWithReactionTime(auraId, sourceUnit)
    if not auraId then return false end
    sourceUnit = sourceUnit or "player"
    -- Resolve to spellbook ID so we check the aura the player actually has
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(auraId)
        if resolved then
            auraId = resolved
        end
    end
    local reactionTime = self:InputDelay()

    -- All special cases (Gargoyle, Dark Transformation, etc.) are handled by EnhancedAuraHandlers
    local aura = NAG:UnitAura(sourceUnit, auraId)
    if aura == false then return false end

    local expirationTime = aura.expirationTime
    if not expirationTime or expirationTime <= 0 then
        return true -- Treat permanent/unknown duration as active
    end

    -- Check if aura has sufficient remaining time for reaction window
    local timeRemaining = expirationTime - NAG:NextTime()
    return timeRemaining >= reactionTime
end

--- Checks if an aura is inactive or expiring within reaction time.
--- @param auraId number The spell ID of the aura to check.
--- @param sourceUnit? string The unit to check (defaults to "player").
--- @return boolean True if aura is inactive or expiring within reaction time.
--- @usage NAG:AuraIsInactiveWithReactionTime(73643)
function NAG:AuraIsInactiveWithReactionTime(auraId, sourceUnit)
    if not auraId then return true end
    sourceUnit = sourceUnit or "player"
    -- Resolve to spellbook ID so we check the aura the player actually has
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(auraId)
        if resolved then
            auraId = resolved
        end
    end
    local reactionTime = self:InputDelay()

    local aura = NAG:UnitAura(sourceUnit, auraId)
    if aura == false then return true end

    local expirationTime = aura.expirationTime
    if not expirationTime or expirationTime <= 0 then
        return false -- Permanent/unknown duration counts as active
    end

    -- Check if aura is inactive or expiring within reaction time
    local timeRemaining = expirationTime - NAG:NextTime()
    return timeRemaining <= reactionTime
end

-- ============================ HELPER FUNCTIONS ============================


--- Gets the known maximum stacks for a spell ID based on hardcoded knowledge.
--- This is a fallback for spells that don't have maxStacks defined in their data.
--- @param spellId number The spell ID to check.
--- @return number The maximum stacks for the spell, or 1 if not stackable.
--- @usage NAG:GetKnownMaxStacks(113746) -- Returns 3 for Sunder Armor
--- @local This function is used to get the known maximum stacks for a spell ID based on hardcoded knowledge.
function NAG:GetKnownMaxStacks(spellId)
    -- Known stackable debuffs and their max stacks
    local knownStackableDebuffs = {
        [113746] = 3, -- Sunder Armor (Weakened Armor) - 3 stacks
    }

    return knownStackableDebuffs[spellId] or 1
end

-- Table of mutually exclusive buff groups.
local mutuallyExclusiveBuffs = {
    BLESSINGS = {
        [19740] = true, -- Blessing of Might
        [20217] = true, -- Blessing of Kings
    },
    SHOUTS = {
        [469] = true,  -- Commanding Shout
        [6673] = true, -- Battle Shout
    },
}

--- Helper function to check if a buff is already active from its exclusive group.
--- Checks if another mutually exclusive buff is active for the given spell ID.
--- @param self NAG The NAG addon object.
--- @param spellId number The spell ID to check
--- @return boolean True if another exclusive buff is active, false otherwise
--- @usage hasActiveExclusiveBuff(self, 19740) -- Check if Blessing of Might is active
local function hasActiveExclusiveBuff(self, spellId)
    -- Find which group this spell belongs to
    for groupName, spells in pairs(mutuallyExclusiveBuffs) do
        if spells[spellId] then
            -- Check if any spell from this group is active
            for otherSpellId in pairs(spells) do
                if otherSpellId ~= spellId and self:IsActiveAura(otherSpellId) then
                    return true
                end
            end
            break
        end
    end
    return false
end

--- Checks if a raid debuff type is active on the target.
--- Returns true if any debuff of the specified type is currently active on the target.
--- @param debuffType number The type of raid debuff to check from Types:GetType("DebuffType")
--- @return boolean True if the debuff type is active, false otherwise
--- @usage NAG:RaidDebuffIsActive(Types:GetType("DebuffType").PHYSICAL_DAMAGE)
function NAG:RaidDebuffIsActive(debuffType)
    if not debuffType or not UnitExists("target") then return false end

    -- Validate debuff type exists in registry
    local debuffTypeRegistry = Types:GetType("DebuffType")
    if not debuffTypeRegistry or not debuffTypeRegistry:IsValid(debuffType) then
        self:Error(format("RaidDebuffIsActive: Invalid debuff type: %s (type: %s, context: %s)",
            tostring(debuffType), type(debuffType), debugstack(2, 1, 0)))
        return false
    end

    -- Get all spells of this debuff type
    local debuffsOfType = DataManager:GetAllByType("DebuffType", debuffType)

    -- Check each spell that provides this debuff type
    for spellId in pairs(debuffsOfType) do
        --self:Trace("Debuff: Checking spellId: " .. tostring(spellId))
        local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
        if spell and spell.flags.debufftype and self:DotIsActive(spellId) then
            return true
        end
    end

    return false
end

--- Checks if a raid buff type is active on the player.
--- Returns true if any buff of the specified type is currently active on the player.
--- @param buffType number The type of raid buff to check from Types:GetType("BuffType")
--- @return boolean True if the buff type is active, false otherwise
--- @usage NAG:RaidBuffIsActive(Types:GetType("BuffType").STAMINA)
function NAG:RaidBuffIsActive(buffType)
    if not buffType then return false end

    -- Validate buff type exists in registry
    local buffTypeRegistry = Types:GetType("BuffType")
    if not buffTypeRegistry or not buffTypeRegistry:IsValid(buffType) then
        self:Error("RaidBuffIsActive: Invalid buff type: " .. tostring(buffType))
        return false
    end

    -- Get all spells of this buff type
    local buffsOfType = DataManager:GetAllByType("BuffType", buffType)

    -- Check each spell that provides this buff type
    for spellId in pairs(buffsOfType) do
        local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
        if spell and spell.flags.bufftype and self:IsActiveAura(spellId) then
            return true
        end
    end

    return false
end

--- Checks and recommends raid buffs based on missing buffs in group/raid.
--- Recommends a raid buff if the percentage of group/raid members missing it meets or exceeds the threshold.
--- @param percentNeed? number The percentage threshold of units needing buffs (0-100). Defaults to 40 if not specified.
--- @return nil
--- @usage NAG:CheckRaidBuffs(50)
--- @local This function is used to check and recommend raid buffs based on missing buffs in group/raid
function NAG:CheckRaidBuffs(percentNeed)
    -- Validate inputs and initialize
    percentNeed = percentNeed or 40

    if type(percentNeed) ~= "number" or percentNeed < 0 or percentNeed > 100 then
        self:Error("CheckRaidBuffs: percentNeed must be between 0 and 100")
        return
    end

    -- Get all buff types from Types registry
    local buffTypeRegistry = Types:GetType("BuffType")
    if not buffTypeRegistry then return end

    local groupUnits = self:GetGroupMemberUnits()
    local totalUnits = #groupUnits
    if totalUnits == 0 then return end

    local unitsNeedingBuff = {}
    local raidBuffActiveCache = {}
    local function isRaidBuffActive(buffTypeKey, buffTypeValue)
        local cached = raidBuffActiveCache[buffTypeKey]
        if cached ~= nil then
            return cached
        end
        local result = self:RaidBuffIsActive(buffTypeValue)
        raidBuffActiveCache[buffTypeKey] = result
        return result
    end

    -- Initialize buff type tracking
    for buffType in pairs(buffTypeRegistry._values) do
        unitsNeedingBuff[buffType] = 0
    end

    -- Check each group member (player + party/raid)
    for i = 1, #groupUnits do
        local unit = groupUnits[i]
        for buffType in pairs(buffTypeRegistry._values) do
            local buffTypeValue = Types:GetType("BuffType")[buffType]
            if not isRaidBuffActive(buffType, buffTypeValue) then
                unitsNeedingBuff[buffType] = unitsNeedingBuff[buffType] + 1
                self:Trace(format("Unit %s needs buff type: %s", unit, tostring(buffType)))
            end
        end
    end

    -- Check each buff type and recommend if needed
    for buffType in pairs(buffTypeRegistry._values) do
        local percentNeedingThisBuff = (unitsNeedingBuff[buffType] / totalUnits) * 100

        -- Only recommend if we meet the threshold
        if percentNeedingThisBuff >= percentNeed then
            -- Get all spells of this buff type
            local buffsOfType = DataManager:GetAllByType("BuffType", buffType)

            for spellId in pairs(buffsOfType) do
                local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
                -- Only process raid buffs that we can cast
                if spell and spell.flags.bufftype and self:SpellCanCast(spellId) then
                    -- Skip if another exclusive buff is already active
                    if not hasActiveExclusiveBuff(self, spellId) then
                        -- Create closure to capture buffType for this specific notification
                        local function conditionFunc()
                            -- Return true to hide notification when buff is NOT needed
                            return not self:RaidBuffIsActive(Types:GetType("BuffType")[buffType])
                        end

                        -- Show notification on all active display frames
                        for _, displayFrame in ipairs(DisplayManager:GetActivePrimaryFrames()) do
                            OverlayManager:ShowNotification(displayFrame, spellId, 0, 0, conditionFunc)
                        end
                        self:Debug(format("Recommending buff: %s", spell.name))
                        return -- Exit after recommending one buff
                    end
                end
            end
        end
    end
end

--- Checks and recommends raid debuffs based on missing debuffs on the target.
--- Recommends a raid debuff if the target is missing any debuff type and the player can cast a relevant spell.
--- @return nil
--- @usage NAG:CheckRaidDebuffs()
--- @local This function is used to check and recommend raid debuffs based on missing debuffs on the target
function NAG:CheckRaidDebuffs()
    -- Validate inputs and initialize
    if not UnitExists("target") then return end

    -- Get all debuff types from Types registry
    local debuffTypeRegistry = Types:GetType("DebuffType")
    if not debuffTypeRegistry then return end
    local raidDebuffActiveCache = {}
    local function isRaidDebuffActive(debuffTypeKey, debuffTypeValue)
        local cached = raidDebuffActiveCache[debuffTypeKey]
        if cached ~= nil then
            return cached
        end
        local result = self:RaidDebuffIsActive(debuffTypeValue)
        raidDebuffActiveCache[debuffTypeKey] = result
        return result
    end

    -- Check each debuff type
    for debuffType in pairs(debuffTypeRegistry._values) do
        -- Only recommend if this debuff type is missing
        local debuffTypeValue = Types:GetType("DebuffType")[debuffType]
        if not isRaidDebuffActive(debuffType, debuffTypeValue) then
            -- Get all spells of this debuff type
            local debuffsOfType = DataManager:GetAllByType("DebuffType", debuffType)

            for spellId in pairs(debuffsOfType) do
                local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
                -- Only process raid debuffs
                if spell and spell.flags.debufftype then
                    -- Use SpellCanCast to check if we can cast this debuff
                    if self:SpellCanCast(spellId) then
                        local function conditionFunc()
                            if not UnitExists("target") then
                                return true -- Hide notification if target is gone
                            end
                            -- Return true to hide notification when debuff is NOT needed
                            return not self:RaidDebuffIsActive(Types:GetType("DebuffType")[debuffType])
                        end

                        -- Show notification on all active display frames
                        for _, displayFrame in ipairs(DisplayManager:GetActivePrimaryFrames()) do
                            OverlayManager:ShowNotification(displayFrame, spellId, 0, 0, conditionFunc)
                        end
                        self:Debug("Recommending debuff: " .. spell.name)
                        return
                    end
                end
            end
        end
    end
end
