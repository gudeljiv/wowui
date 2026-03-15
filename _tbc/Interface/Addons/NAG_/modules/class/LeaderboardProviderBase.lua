--- @module "NAG.LeaderboardProviderBase"
--- Shared helpers for leaderboard metric provider modules.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas

-- ============================ LOCALIZE ============================

local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local UnitGUID = _G.UnitGUID
local UnitFullName = _G.UnitFullName
local UnitName = _G.UnitName
local GetRealmName = _G.GetRealmName
local time = _G.time
local GetTime = _G.GetTime

-- ============================ MODULE TABLE ============================

local LeaderboardProviderBase = {}
ns.LeaderboardProviderBase = LeaderboardProviderBase

-- ============================ HELPERS ============================

--- Return LeaderboardService module with per-provider cache.
--- @param provider table
--- @return table|nil
function LeaderboardProviderBase:GetLeaderboardService(provider)
    if not provider._leaderboardService then
        provider._leaderboardService = NAG:GetModule("LeaderboardService", true)
    end
    return provider._leaderboardService
end

--- Resolve player GUID from NAG runtime state with UnitGUID fallback.
--- @return string|nil
function LeaderboardProviderBase:GetPlayerGUID()
    return (NAG and NAG.state and NAG.state.player and NAG.state.player.guid) or (UnitGUID and UnitGUID("player")) or nil
end

--- True when source GUID is the local player.
--- @param sourceGUID string|nil
--- @return boolean
function LeaderboardProviderBase:IsPlayerSource(sourceGUID)
    local playerGUID = self:GetPlayerGUID()
    return playerGUID ~= nil and sourceGUID == playerGUID
end

--- Create a shallow copy of context table.
--- @param context table|nil
--- @return table
function LeaderboardProviderBase:CopyContext(context)
    local output = {}
    if type(context) ~= "table" then
        return output
    end
    for key, value in pairs(context) do
        output[key] = value
    end
    return output
end

--- Return a normalized player name/key/GUID tuple.
--- @return string playerName
--- @return string playerKey
--- @return string playerGUID
function LeaderboardProviderBase:GetLocalPlayerIdentity()
    local playerName
    local realm = ""
    if type(UnitFullName) == "function" then
        playerName, realm = UnitFullName("player")
    end
    if type(playerName) ~= "string" or playerName == "" then
        playerName = type(UnitName) == "function" and UnitName("player") or "Unknown"
    end
    if type(realm) ~= "string" or realm == "" then
        realm = type(GetRealmName) == "function" and GetRealmName() or ""
    end
    local playerKey = tostring(playerName or "Unknown")
    if realm ~= "" and not playerKey:find("-", 1, true) then
        playerKey = playerKey .. "-" .. realm
    end
    return tostring(playerName or "Unknown"), playerKey, tostring(self:GetPlayerGUID() or "")
end

--- Return current timestamp, preferring epoch seconds.
--- @return number
function LeaderboardProviderBase:GetRecordTimestamp()
    return tonumber(time and time()) or tonumber(GetTime and GetTime()) or 0
end

--- Insert an entry into a descending-by-value local top-N list.
--- @param list table
--- @param cap number
--- @param value number
--- @param context table
--- @param meta table|nil
--- @return boolean inserted
function LeaderboardProviderBase:InsertLocalTopN(list, cap, value, context, meta)
    if type(list) ~= "table" then
        return false
    end
    if type(value) ~= "number" or value <= 0 then
        return false
    end

    local playerName, playerKey, playerGUID = self:GetLocalPlayerIdentity()
    local entry = {
        value = value,
        context = self:CopyContext(context),
        timestamp = self:GetRecordTimestamp(),
        playerKey = playerKey,
        playerName = playerName,
        playerGUID = playerGUID,
        scope = "local",
        className = meta and meta.className or "ALL",
    }

    local insertIdx = #list + 1
    for i = 1, #list do
        if (tonumber(list[i].value) or 0) < value then
            insertIdx = i
            break
        end
    end
    table.insert(list, insertIdx, entry)

    local maxEntries = tonumber(cap) or 10
    if maxEntries < 1 then
        maxEntries = 1
    end
    while #list > maxEntries do
        table.remove(list)
    end
    return true
end

--- Build standardized provider capabilities for local top-N retrieval.
--- This keeps provider registration consistent across metrics and avoids per-provider callback drift.
--- @param metricId string
--- @param getRecordsFn function Callback returning local top-N table for this metric id
--- @return table capabilities
function LeaderboardProviderBase:BuildLocalTopNCapability(metricId, getRecordsFn)
    if type(metricId) ~= "string" or metricId == "" or type(getRecordsFn) ~= "function" then
        return {
            hasLocalTopN = false,
            getLocalTopN = nil,
        }
    end
    return {
        hasLocalTopN = true,
        getLocalTopN = function(_, requestedMetricId)
            if type(requestedMetricId) ~= "string" or requestedMetricId == "" then
                requestedMetricId = metricId
            end
            if requestedMetricId ~= metricId then
                return nil
            end
            return getRecordsFn(requestedMetricId)
        end,
    }
end

return LeaderboardProviderBase
