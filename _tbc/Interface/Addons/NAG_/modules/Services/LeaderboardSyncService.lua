--- @module "NAG.LeaderboardSyncService"
--- Intra-addon leaderboard synchronization service.
---
--- Uses lightweight addon-channel messages with compact payload patterns:
--- - BEST_UPDATE for realtime best-score updates
--- - TOPX_SNAPSHOT for periodic bounded reconciliation
--- - SYNC_REQUEST for on-demand reconciliation
--- - SYNC_ACK for optional diagnostics
---
--- This module intentionally keeps payloads compact, applies throttling and channel fallback,
--- and delegates merge logic to LeaderboardService.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

-- ============================ LOCALIZE ============================

local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)

local GetTime = _G.GetTime
local UnitName = _G.UnitName
local UnitFullName = _G.UnitFullName
local GetRealmName = _G.GetRealmName
local GetNormalizedRealmName = _G.GetNormalizedRealmName
local IsInGuild = _G.IsInGuild
local IsInGroup = _G.IsInGroup
local IsInRaid = _G.IsInRaid
local UnitAffectingCombat = _G.UnitAffectingCombat
local C_Timer = _G.C_Timer
local random = math.random
local floor = math.floor
local tonumber = tonumber
local tostring = tostring
local type = type
local pairs = pairs
local ipairs = ipairs
local tinsert = table.insert
local sort = table.sort
local strsplit = strsplit

local AceComm = LibStub("AceComm-3.0")

-- ============================ CONSTANTS ============================

local ADDON_PREFIX = "NAG_LB_SYNC"
local PROTOCOL_VERSION = "1"

local MESSAGE_TYPES = {
    BEST_UPDATE = "BEST_UPDATE",
    TOPX_SNAPSHOT = "TOPX_SNAPSHOT",
    SYNC_REQUEST = "SYNC_REQUEST",
    SYNC_ACK = "SYNC_ACK",
    METRIC_DIGEST = "METRIC_DIGEST",
    DIGEST_REQUEST = "DIGEST_REQUEST",
    HELPER_GLOBAL_DIGEST = "HELPER_GLOBAL_DIGEST",
    HELPER_GLOBAL_REQUEST = "HELPER_GLOBAL_REQUEST",
    HELPER_GLOBAL_CHUNK = "HELPER_GLOBAL_CHUNK",
}
local INBOUND_HANDLER_METHODS = {
    BEST_UPDATE = "HandleInboundBest",
    TOPX_SNAPSHOT = "HandleInboundTopX",
    SYNC_REQUEST = "HandleInboundSyncRequest",
    METRIC_DIGEST = "HandleInboundDigest",
    DIGEST_REQUEST = "HandleInboundDigestRequest",
    HELPER_GLOBAL_DIGEST = "HandleInboundHelperGlobalDigest",
    HELPER_GLOBAL_REQUEST = "HandleInboundHelperGlobalRequest",
    HELPER_GLOBAL_CHUNK = "HandleInboundHelperGlobalChunk",
}
local DEFAULT_INBOUND_DEDUPE_TTL_SECONDS = 20
local DEFAULT_HELPER_CHUNK_TIMEOUT_SECONDS = 60
local DEFAULT_STALE_DEDUPE_CLEANUP_INTERVAL = 30
local SEND_RESULT_CODES = {
    SUCCESS = 0,
    INVALID_PREFIX = 1,
    INVALID_MESSAGE = 2,
    ADDON_MESSAGE_THROTTLE = 3,
    INVALID_CHAT_TYPE = 4,
    NOT_IN_GROUP = 5,
    TARGET_REQUIRED = 6,
    INVALID_CHANNEL = 7,
    CHANNEL_THROTTLE = 8,
    GENERAL_ERROR = 9,
    NOT_IN_GUILD = 10,
}

local CHANNEL_MODES = {
    AUTO = "AUTO",
    REALM_CHANNEL = "REALM_CHANNEL",
    GUILD = "GUILD",
    INSTANCE_CHAT = "INSTANCE_CHAT",
    RAID = "RAID",
    PARTY = "PARTY",
    SAY = "SAY",
    YELL = "YELL",
}

local defaults = {
    global = {
        enabled = true,
        debugSync = false,
        channelMode = CHANNEL_MODES.AUTO,
        topXLimit = 20,
        bestUpdateMinInterval = 3,
        snapshotMinInterval = 30,
        syncRequestCooldown = 300,
        responseJitterMaxSeconds = 1.5,
        periodicSnapshotInterval = 120,
        periodicDigestInterval = 60,
        maxEnvelopeLength = 240,
        startupRequestDelay = 8,
        digestRequestCooldown = 30,
        inboundDedupeTtlSeconds = DEFAULT_INBOUND_DEDUPE_TTL_SECONDS,
        helperChunkTimeoutSeconds = DEFAULT_HELPER_CHUNK_TIMEOUT_SECONDS,
    },
    char = {
        syncStats = {
            sent = 0,
            received = 0,
            throttled = 0,
            dropped = 0,
            merged = 0,
            digestCompared = 0,
            digestUpToDate = 0,
            digestStale = 0,
            snapshotRequested = 0,
            snapshotSkipped = 0,
            lastSentAt = 0,
            lastReceivedAt = 0,
            sentByType = {},
            droppedByType = {},
        },
    },
}

-- ============================ MODULE CREATION ============================

--- @class LeaderboardSyncService: CoreModule
local LeaderboardSyncService = NAG:CreateModule("LeaderboardSyncService", defaults, {
    moduleType = ns.MODULE_TYPES.SERVICE,
    databaseRoot = "leaderboard",
    optionsCategory = ns.MODULE_CATEGORIES.LEADERBOARD,
    eventHandlers = {
        PLAYER_ENTERING_WORLD = true,
        PLAYER_REGEN_ENABLED = true,
        GROUP_ROSTER_UPDATE = true,
    },
    messageHandlers = {
        NAG_LEADERBOARD_LOCAL_RECORD_ADDED = "OnLocalRecordAdded",
    },
    slashCommands = {
        ["leaderboard_sync_debug"] = {
            handler = "HandleSyncSlash",
            root = "nagdebug",
            path = {"leaderboard", "sync"},
            help = "Leaderboard sync diagnostics and controls.",
            category = "Debug",
        },
    },
    defaultState = {
        lastSentByKey = {},
        lastPayloadSignatureByKey = {},
        pendingSnapshotMetrics = {},
        startupSyncRequested = false,
        nextMetricCursor = 1,
        nextDigestMetricCursor = 1,
        digestRequestByKey = {},
        helperGlobalRequestByKey = {},
        pendingHelperGlobalChunks = {},
        recentInboundByKey = {},
        lastInboundCleanupAt = 0,
        lastGroupSyncRequestAt = 0,
    },
    debugCategories = {
        ns.DEBUG_CATEGORIES.SERVICES,
        ns.DEBUG_CATEGORIES.FEATURES,
    },
})

ns.LeaderboardSyncService = LeaderboardSyncService

-- ============================ INTERNAL HELPERS ============================

local function makePlayerKey()
    local fullName, fullRealm = nil, nil
    if UnitFullName then
        fullName, fullRealm = UnitFullName("player")
    end
    local playerName = fullName or (UnitName and UnitName("player")) or "Unknown"
    local realm = fullRealm
    if type(realm) ~= "string" or realm == "" then
        realm = GetRealmName and GetRealmName() or ""
    end
    if realm ~= "" and not tostring(playerName):find("-", 1, true) then
        return tostring(playerName) .. "-" .. realm
    end
    return tostring(playerName)
end

--- Sanitize realm string from sync payload so GUID-like values (e.g. 6065-03F68AFD) are not stored.
local function sanitizeRealmFromPayload(s)
    if type(s) ~= "string" or s == "" then
        return ""
    end
    if s:match("^%d+%-%x+$") then
        return ""
    end
    if not s:match("%a") then
        return ""
    end
    return s
end

local function isGroupCategoryInstance()
    local LE_PARTY_CATEGORY_INSTANCE = _G.LE_PARTY_CATEGORY_INSTANCE
    if LE_PARTY_CATEGORY_INSTANCE then
        return IsInGroup and IsInGroup(LE_PARTY_CATEGORY_INSTANCE)
    end
    return false
end

local function simpleHash32(input)
    local text = tostring(input or "")
    local hash = 5381
    for i = 1, #text do
        hash = ((hash * 33) + string.byte(text, i)) % 4294967296
    end
    return hash
end

local function slugifyRealmName(realmName)
    local token = tostring(realmName or ""):lower()
    token = token:gsub("%s+", "")
    token = token:gsub("[^%w]", "")
    if token == "" then
        return "unknownrealm"
    end
    return token
end

local function normalizeInboundChannel(channel)
    local normalized = tostring(channel or ""):upper()
    if normalized == "PARTY_LEADER" then
        return CHANNEL_MODES.PARTY
    end
    if normalized == "RAID_LEADER" then
        return CHANNEL_MODES.RAID
    end
    if normalized == "INSTANCE_CHAT_LEADER" then
        return CHANNEL_MODES.INSTANCE_CHAT
    end
    return normalized
end

function LeaderboardSyncService:GetLeaderboardService()
    if not self._leaderboardService then
        self._leaderboardService = NAG:GetModule("LeaderboardService", true)
    end
    return self._leaderboardService
end

function LeaderboardSyncService:GetTimerManager()
    if not self._timerManager then
        self._timerManager = NAG:GetModule("TimerManager", true)
    end
    return self._timerManager
end

function LeaderboardSyncService:IsEnabled()
    return self.db.global.enabled == true
end

function LeaderboardSyncService:IsDebugEnabled()
    return self.db.global.debugSync == true
end

function LeaderboardSyncService:IsCombatSyncBlocked()
    return UnitAffectingCombat and UnitAffectingCombat("player")
end

function LeaderboardSyncService:DebugSync(message, ...)
    if not self:IsDebugEnabled() then
        return
    end
    self:Info("LB Sync: " .. tostring(message), ...)
end

function LeaderboardSyncService:IsChannelAvailable(channel)
    if channel == CHANNEL_MODES.REALM_CHANNEL then
        return false
    end
    if channel == CHANNEL_MODES.GUILD then
        return IsInGuild and IsInGuild()
    end
    if channel == CHANNEL_MODES.INSTANCE_CHAT then
        return isGroupCategoryInstance() == true
    end
    if channel == CHANNEL_MODES.RAID then
        return IsInRaid and IsInRaid()
    end
    if channel == CHANNEL_MODES.PARTY then
        return IsInGroup and IsInGroup() and not (IsInRaid and IsInRaid())
    end
    if channel == CHANNEL_MODES.SAY or channel == CHANNEL_MODES.YELL then
        return true
    end
    return false
end

function LeaderboardSyncService:SelectChannel()
    local mode = tostring(self.db.global.channelMode or CHANNEL_MODES.AUTO)
    if mode == "WHISPER_PEERS" then
        -- Cleanly migrate deprecated explicit whisper mode to AUTO.
        mode = CHANNEL_MODES.AUTO
        self.db.global.channelMode = CHANNEL_MODES.AUTO
    end
    if mode == CHANNEL_MODES.REALM_CHANNEL or mode == "REALM_CHANNEL" then
        -- Realm channel removed; migrate to AUTO.
        mode = CHANNEL_MODES.AUTO
        self.db.global.channelMode = CHANNEL_MODES.AUTO
    end
    if mode ~= CHANNEL_MODES.AUTO then
        if self:IsChannelAvailable(mode) then
            return mode
        end
        return nil
    end
    -- Prefer active group channels for immediate in-group convergence, then guild fallback.
    if self:IsChannelAvailable(CHANNEL_MODES.INSTANCE_CHAT) then
        return CHANNEL_MODES.INSTANCE_CHAT
    end
    if self:IsChannelAvailable(CHANNEL_MODES.RAID) then
        return CHANNEL_MODES.RAID
    end
    if self:IsChannelAvailable(CHANNEL_MODES.PARTY) then
        return CHANNEL_MODES.PARTY
    end
    if self:IsChannelAvailable(CHANNEL_MODES.GUILD) then
        return CHANNEL_MODES.GUILD
    end
    return nil
end

function LeaderboardSyncService:ResolveScopeForChannel(channel)
    local normalized = normalizeInboundChannel(channel)
    if normalized == "CHANNEL" then
        return "server"
    end
    if normalized == CHANNEL_MODES.GUILD then
        return "guild"
    end
    if normalized == CHANNEL_MODES.INSTANCE_CHAT or normalized == CHANNEL_MODES.RAID or normalized == CHANNEL_MODES.PARTY or
        normalized == CHANNEL_MODES.SAY or normalized == CHANNEL_MODES.YELL then
        return "server"
    end
    return "global"
end

function LeaderboardSyncService:GetPlayerRealmSlug()
    local realm = nil
    if type(GetNormalizedRealmName) == "function" then
        realm = GetNormalizedRealmName()
    end
    if type(realm) ~= "string" or realm == "" then
        realm = GetRealmName and GetRealmName() or ""
    end
    return slugifyRealmName(realm)
end

function LeaderboardSyncService:IsSenderOnPlayerRealm(sender)
    if type(sender) ~= "string" or sender == "" then
        return false
    end
    local senderRealm = sender:match("%-(.+)$")
    if type(senderRealm) ~= "string" or senderRealm == "" then
        return false
    end
    local playerRealmSlug = self:GetPlayerRealmSlug()
    return playerRealmSlug ~= "" and slugifyRealmName(senderRealm) == playerRealmSlug
end

function LeaderboardSyncService:ResolveInboundScope(channel, sender)
    local scope = self:ResolveScopeForChannel(channel)
    if scope == "global" and self:IsSenderOnPlayerRealm(sender) then
        return "server"
    end
    return scope
end

function LeaderboardSyncService:BuildInboundDedupeKey(parsed, sender)
    if type(parsed) ~= "table" then
        return nil
    end
    return table.concat({
        tostring(parsed.messageType or ""),
        tostring(parsed.metricId or ""),
        tostring(sender or parsed.sender or ""),
        tostring(parsed.payload or ""),
    }, "|")
end

function LeaderboardSyncService:IsInboundMessageDuplicate(parsed, sender)
    local key = self:BuildInboundDedupeKey(parsed, sender)
    if not key then
        return false
    end
    local ttl = tonumber(self.db.global.inboundDedupeTtlSeconds) or DEFAULT_INBOUND_DEDUPE_TTL_SECONDS
    local now = GetTime()
    local seenAt = self.state.recentInboundByKey[key]
    if seenAt and (now - seenAt) <= ttl then
        return true
    end
    self.state.recentInboundByKey[key] = now
    return false
end

function LeaderboardSyncService:CleanupInboundDedupeCache()
    local cache = self.state.recentInboundByKey
    if type(cache) ~= "table" then
        return
    end
    local now = GetTime()
    local ttl = tonumber(self.db.global.inboundDedupeTtlSeconds) or DEFAULT_INBOUND_DEDUPE_TTL_SECONDS
    for key, seenAt in pairs(cache) do
        if (now - (tonumber(seenAt) or 0)) > ttl then
            cache[key] = nil
        end
    end
end

function LeaderboardSyncService:CleanupPendingHelperGlobalChunks()
    local timeout = tonumber(self.db.global.helperChunkTimeoutSeconds) or DEFAULT_HELPER_CHUNK_TIMEOUT_SECONDS
    local now = GetTime()
    for senderKey, senderChunks in pairs(self.state.pendingHelperGlobalChunks or {}) do
        if type(senderChunks) == "table" then
            for streamKey, state in pairs(senderChunks) do
                local startedAt = tonumber(state and state.startedAt) or 0
                local lastUpdate = tonumber(state and state.lastUpdate) or startedAt
                if now - math.max(startedAt, lastUpdate) > timeout then
                    senderChunks[streamKey] = nil
                end
            end
            if not next(senderChunks) then
                self.state.pendingHelperGlobalChunks[senderKey] = nil
            end
        else
            self.state.pendingHelperGlobalChunks[senderKey] = nil
        end
    end
end

function LeaderboardSyncService:CountOnlineGuildMembers()
    if not (IsInGuild and IsInGuild()) then
        return 1
    end
    if type(_G.GetNumGuildMembers) ~= "function" or type(_G.GetGuildRosterInfo) ~= "function" then
        return 1
    end
    local online = 0
    local count = _G.GetNumGuildMembers()
    for i = 1, count do
        local _, _, _, _, _, _, _, _, isOnline = _G.GetGuildRosterInfo(i)
        if isOnline then
            online = online + 1
        end
    end
    return online > 0 and online or 1
end

function LeaderboardSyncService:ShouldRespondToSyncRequest(sender)
    local senderKey = tostring(sender or "")
    if senderKey == "" then
        return true
    end
    local me = makePlayerKey()
    local onlineCount = self:CountOnlineGuildMembers()
    if onlineCount <= 10 then
        return true
    end

    local mod = 16
    if onlineCount <= 20 then
        mod = 4
    elseif onlineCount <= 50 then
        mod = 8
    end
    local hash = simpleHash32(senderKey .. "|" .. tostring(me))
    return (hash % mod) == 0
end

function LeaderboardSyncService:BuildEnvelope(messageType, metricId, payload)
    local sender = makePlayerKey()
    local now = floor(GetTime())
    return table.concat({
        PROTOCOL_VERSION,
        tostring(messageType or ""),
        tostring(metricId or ""),
        sender,
        tostring(now),
        tostring(payload or ""),
    }, "|")
end

function LeaderboardSyncService:ParseEnvelope(message)
    if type(message) ~= "string" then
        return nil, "invalid message"
    end
    local version, messageType, metricId, sender, timestampText, payload =
        message:match("^([^|]*)|([^|]*)|([^|]*)|([^|]*)|([^|]*)|(.*)$")
    if version ~= PROTOCOL_VERSION then
        return nil, "unsupported protocol"
    end
    if not messageType or messageType == "" then
        return nil, "missing message type"
    end
    return {
        version = version,
        messageType = messageType,
        metricId = metricId,
        sender = sender,
        timestamp = tonumber(timestampText) or 0,
        payload = payload or "",
    }, nil
end

function LeaderboardSyncService:BuildHelperMetricKey(metricId, className)
    local metric = tostring(metricId or "")
    local classToken = tostring(className or "ALL")
    return metric .. "@" .. classToken
end

function LeaderboardSyncService:ParseHelperMetricKey(metricKey)
    local metricId, className = strsplit("@", tostring(metricKey or ""), 2)
    if type(metricId) ~= "string" or metricId == "" then
        return nil, nil
    end
    if type(className) ~= "string" or className == "" then
        className = "ALL"
    end
    return metricId, className
end

function LeaderboardSyncService:BuildHelperGlobalDigestPayload(meta, bestRecord)
    local version = tonumber(meta and meta.version) or 0
    local snapshotHash = tostring(meta and meta.snapshotHash or "")
    local bestValue = tonumber(bestRecord and bestRecord.value) or 0
    local bestTimestamp = tonumber(bestRecord and bestRecord.timestamp) or 0
    return table.concat({
        tostring(version),
        snapshotHash:gsub(",", " "),
        tostring(bestValue),
        tostring(bestTimestamp),
    }, ",")
end

function LeaderboardSyncService:ParseHelperGlobalDigestPayload(payload)
    local versionText, snapshotHash, bestValueText, bestTimestampText = strsplit(",", tostring(payload or ""), 4)
    local version = tonumber(versionText)
    if type(version) ~= "number" or version < 1 then
        return nil
    end
    return {
        version = version,
        snapshotHash = tostring(snapshotHash or ""),
        bestValue = tonumber(bestValueText) or 0,
        bestTimestamp = tonumber(bestTimestampText) or 0,
    }
end

function LeaderboardSyncService:BuildHelperGlobalChunkPayload(version, snapshotHash, chunkPayload)
    return table.concat({
        tostring(tonumber(version) or 0),
        tostring(snapshotHash or ""):gsub("~", " "),
        tostring(chunkPayload or ""),
    }, "~")
end

--- Build a single HELPER_GLOBAL_CHUNK payload containing all records (AceComm will multipart the envelope).
--- @param meta table { version, snapshotHash }
--- @param records table array of leaderboard records
--- @return string payload for HELPER_GLOBAL_CHUNK
function LeaderboardSyncService:BuildSingleHelperGlobalChunkPayload(meta, records)
    local entries = {}
    for i = 1, #(records or {}) do
        entries[i] = self:BuildTopXEntry(records[i], "minimal_context")
    end
    local payload = self:BuildTopXPayloadFromEntries(entries)
    local chunkId = tostring(floor(GetTime() * 1000)) .. "-" .. tostring(random(100000, 999999))
    local chunk = self:BuildTopXChunkPayloadFromTopPayload(chunkId, 1, true, payload)
    return self:BuildHelperGlobalChunkPayload(meta.version, meta.snapshotHash or "", chunk)
end

function LeaderboardSyncService:ParseHelperGlobalChunkPayload(payload)
    local versionText, snapshotHash, chunkPayload = strsplit("~", tostring(payload or ""), 3)
    local version = tonumber(versionText)
    if type(version) ~= "number" or version < 1 then
        return nil
    end
    local chunk = self:ParseTopXChunkPayload(chunkPayload or "")
    if not chunk then
        return nil
    end
    return {
        version = version,
        snapshotHash = tostring(snapshotHash or ""),
        chunk = chunk,
    }
end

function LeaderboardSyncService:BuildBestPayload(record, compactness)
    local ctx = record.context or {}
    local eventType = tostring(ctx.eventType or ""):gsub("|", " ")
    local spellName = tostring(ctx.spellName or ""):gsub("|", " ")
    local spellIcon = tostring(ctx.spellIcon or "")
    local targetName = tostring(ctx.targetName or ""):gsub("|", " ")
    local targetLevel = tostring(ctx.targetLevel or "")
    local playerLevel = tostring(ctx.playerLevel or record.playerLevel or "")

    local contextBlob = eventType .. "|" .. spellName .. "|" .. spellIcon .. "|" .. targetName .. "|" .. targetLevel .. "|" .. playerLevel
    if compactness == "minimal_context" then
        contextBlob = eventType .. "||" .. spellIcon .. "||"
    elseif compactness == "minimal" then
        contextBlob = ""
    end

    local playerName = tostring(record.playerName or record.playerKey or "Unknown")
    local playerGUID = tostring(record.playerGUID or "")
    local guildName = tostring(record.guildName or ""):gsub("[~|]", " ")
    local serverName = tostring(record.serverName or ""):gsub("[~|]", " ")
    if #guildName > 32 then
        guildName = guildName:sub(1, 32)
    end
    if #serverName > 32 then
        serverName = serverName:sub(1, 32)
    end
    if compactness == "minimal" then
        playerName = ""
        playerGUID = ""
    end

    local fields = {
        tostring(record.playerKey or record.playerGUID or record.playerName or "Unknown"),
        playerName,
        playerGUID,
        tostring(tonumber(record.value) or 0),
        tostring(tonumber(record.timestamp) or 0),
        tostring(record.className or "ALL"),
        tostring(record.expansionTag or ""),
        guildName,
        serverName,
        contextBlob,
    }
    return table.concat(fields, "~")
end

function LeaderboardSyncService:ParseBestPayload(payload)
    local a, b, c, d, e, f, g, h, i, j = strsplit("~", payload or "", 10)
    local playerKey = a
    local playerName = b
    local playerGUID = c
    local valueText = d
    local timestampText = e
    local className = f
    local expansionTag = g
    local guildName = h
    local serverName = i
    local contextBlob = j
    -- Backward compatibility: legacy payload ended at context blob (8 fields).
    if j == nil and i == nil and type(h) == "string" and h:find("|", 1, true) then
        contextBlob = h
        guildName = ""
        serverName = ""
    end
    local value = tonumber(valueText)
    if type(playerKey) ~= "string" or playerKey == "" then
        return nil
    end
    if type(value) ~= "number" then
        return nil
    end
    local context
    if type(contextBlob) == "string" and contextBlob ~= "" then
        local et, spellName, spellIcon, targetName, targetLevel, playerLevel = strsplit("|", contextBlob, 7)
        context = {
            eventType = et,
            spellName = spellName,
            spellIcon = tonumber(spellIcon) or spellIcon,
            targetName = targetName,
            targetLevel = tonumber(targetLevel),
            playerLevel = (playerLevel and playerLevel ~= "") and tonumber(playerLevel) or nil,
        }
    end
    return {
        playerKey = playerKey,
        playerName = playerName,
        playerGUID = playerGUID,
        value = value,
        timestamp = tonumber(timestampText) or 0,
        className = className,
        expansionTag = expansionTag,
        guildName = tostring(guildName or ""),
        serverName = sanitizeRealmFromPayload(tostring(serverName or "")),
        source = "peer_best_update",
        context = context,
    }
end

function LeaderboardSyncService:BuildTopXPayload(records)
    local function safeCsv(value)
        return tostring(value or ""):gsub("[,;~|]", " ")
    end

    local entries = {}
    for i = 1, #records do
        local record = records[i]
        local ctx = record.context or {}
        local eventType = tostring(ctx.eventType or "")
        local spellName = tostring(ctx.spellName or ""):gsub("|", " ")
        local spellIcon = tostring(ctx.spellIcon or "")
        local targetName = tostring(ctx.targetName or ""):gsub("|", " ")
        local targetLevel = tostring(ctx.targetLevel or "")
        local playerLevel = tostring(ctx.playerLevel or record.playerLevel or "")
        local contextBlob = eventType .. "|" .. spellName .. "|" .. spellIcon .. "|" .. targetName .. "|" .. targetLevel .. "|" .. playerLevel
        entries[#entries + 1] = table.concat({
            safeCsv(record.playerKey or record.playerGUID or record.playerName or "Unknown"),
            safeCsv(record.playerName or record.playerKey or "Unknown"),
            safeCsv(record.playerGUID or ""),
            tostring(tonumber(record.value) or 0),
            tostring(tonumber(record.timestamp) or 0),
            safeCsv(record.className or "ALL"),
            safeCsv(record.guildName or ""),
            safeCsv(record.serverName or ""),
            contextBlob,
        }, ",")
    end
    return table.concat(entries, ";")
end

function LeaderboardSyncService:BuildTopXEntry(record, compactness)
    local safe = function(value, delimiterPattern)
        local text = tostring(value or "")
        text = text:gsub("%|", " ")
        if delimiterPattern then
            text = text:gsub(delimiterPattern, " ")
        end
        return text
    end

    local playerKey = safe(record.playerKey or record.playerGUID or record.playerName or "Unknown", "[,;~]")
    local playerName = safe(record.playerName or record.playerKey or "", "[,;~]")
    local playerGUID = safe(record.playerGUID or "", "[,;~]")
    local valueText = tostring(tonumber(record.value) or 0)
    local timestampText = tostring(tonumber(record.timestamp) or 0)

    local contextBlob = ""
    if compactness == "full" then
        local ctx = record.context or {}
        local spellId = tonumber(ctx.spellId) or 0
        local eventType = safe(ctx.eventType or "", "[|,;~]")
        local spellName = safe(ctx.spellName or "", "[|,;~]")
        local spellIcon = safe(ctx.spellIcon or "", "[|,;~]")
        local targetName = safe(ctx.targetName or "", "[|,;~]")
        local targetLevel = safe(ctx.targetLevel or "", "[|,;~]")
        local playerLevel = safe(ctx.playerLevel or record.playerLevel or "", "[|,;~]")
        contextBlob = tostring(spellId) .. "|" .. eventType .. "|" .. spellName .. "|" .. spellIcon .. "|" .. targetName .. "|" .. targetLevel .. "|" .. playerLevel
    elseif compactness == "minimal_context" then
        local ctx = record.context or {}
        local spellId = tonumber(ctx.spellId) or 0
        local eventType = safe(ctx.eventType or "", "[|,;~]")
        local spellName = safe(ctx.spellName or "", "[|,;~]")
        local spellIcon = safe(ctx.spellIcon or "", "[|,;~]")
        local targetName = safe(ctx.targetName or "", "[|,;~]")
        if #spellName > 28 then
            spellName = spellName:sub(1, 28)
        end
        if #targetName > 28 then
            targetName = targetName:sub(1, 28)
        end
        contextBlob = tostring(spellId) .. "|" .. eventType .. "|" .. spellName .. "|" .. spellIcon .. "|" .. targetName
    end

    if compactness == "minimal" then
        playerName = ""
        playerGUID = ""
        contextBlob = ""
    end

    local guildName = safe(record.guildName or "", "[,;~]")
    local serverName = safe(record.serverName or "", "[,;~]")
    if #guildName > 32 then
        guildName = guildName:sub(1, 32)
    end
    if #serverName > 32 then
        serverName = serverName:sub(1, 32)
    end

    return table.concat({
        playerKey,
        playerName,
        playerGUID,
        valueText,
        timestampText,
        safe(record.className or "ALL", "[,;~]"),
        guildName,
        serverName,
        contextBlob,
    }, ",")
end

function LeaderboardSyncService:BuildTopXPayloadFromEntries(entries)
    return table.concat(entries or {}, ";")
end

function LeaderboardSyncService:ParseTopXPayload(payload)
    if type(payload) ~= "string" or payload == "" then
        return {}
    end
    local out = {}
    for segment in payload:gmatch("([^;]+)") do
        local playerKey, playerName, playerGUID, valueText, timestampText, className, guildName, serverName, contextBlob =
            strsplit(",", segment, 9)
        -- Backward compatibility: legacy payload used 7 fields where field 7 was context blob.
        if contextBlob == nil and serverName == nil and type(guildName) == "string" and guildName:find("|", 1, true) then
            contextBlob = guildName
            guildName = ""
            serverName = ""
        end
        local value = tonumber(valueText)
        if type(playerKey) == "string" and playerKey ~= "" and type(value) == "number" then
            local context
            if type(contextBlob) == "string" and contextBlob ~= "" then
                local parts = { strsplit("|", contextBlob, 8) }
                local spellId, et, spellName, spellIcon, targetName, targetLevel, playerLevel
                if tonumber(parts[1]) and #parts >= 7 then
                    spellId = tonumber(parts[1])
                    et = parts[2]
                    spellName = parts[3]
                    spellIcon = parts[4]
                    targetName = parts[5]
                    targetLevel = parts[6]
                    playerLevel = parts[7]
                else
                    spellId = nil
                    et = parts[1]
                    spellName = parts[2]
                    spellIcon = parts[3]
                    targetName = parts[4]
                    targetLevel = parts[5]
                    playerLevel = parts[6]
                end
                context = {
                    eventType = et,
                    spellId = spellId,
                    spellName = spellName,
                    spellIcon = tonumber(spellIcon) or spellIcon,
                    targetName = targetName,
                    targetLevel = tonumber(targetLevel),
                    playerLevel = (playerLevel and playerLevel ~= "") and tonumber(playerLevel) or nil,
                }
            end
            out[#out + 1] = {
                playerKey = playerKey,
                playerName = playerName,
                playerGUID = playerGUID,
                value = value,
                timestamp = tonumber(timestampText) or 0,
                className = className,
                guildName = tostring(guildName or ""),
                serverName = sanitizeRealmFromPayload(tostring(serverName or "")),
                source = "peer_topx_snapshot",
                context = context,
            }
        end
    end
    return out
end

function LeaderboardSyncService:BuildTopXChunkPayload(chunkId, seq, isLast, records)
    local topPayload = self:BuildTopXPayload(records)
    return table.concat({
        tostring(chunkId or ""),
        tostring(seq or 1),
        isLast and "1" or "0",
        topPayload,
    }, "~")
end

function LeaderboardSyncService:BuildTopXChunkPayloadFromTopPayload(chunkId, seq, isLast, topPayload)
    return table.concat({
        tostring(chunkId or ""),
        tostring(seq or 1),
        isLast and "1" or "0",
        tostring(topPayload or ""),
    }, "~")
end

function LeaderboardSyncService:ParseTopXChunkPayload(payload)
    local chunkId, seqText, isLastText, topPayload = strsplit("~", payload or "", 4)
    if type(chunkId) ~= "string" or chunkId == "" then
        return nil
    end
    local seq = tonumber(seqText)
    if type(seq) ~= "number" or seq < 1 then
        return nil
    end
    local records = self:ParseTopXPayload(topPayload or "")
    return {
        chunkId = chunkId,
        seq = seq,
        isLast = tostring(isLastText or "0") == "1",
        records = records,
    }
end

function LeaderboardSyncService:BuildMetricDigestPayload(record, snapshotMeta)
    if type(record) ~= "table" then
        return ""
    end
    local meta = type(snapshotMeta) == "table" and snapshotMeta or {}
    return table.concat({
        tostring(record.playerKey or record.playerGUID or record.playerName or "Unknown"),
        tostring(record.playerName or record.playerKey or "Unknown"),
        tostring(tonumber(record.value) or 0),
        tostring(tonumber(record.timestamp) or 0),
        tostring(record.className or "ALL"),
        tostring(tonumber(meta.version) or 0),
        tostring(meta.snapshotHash or ""),
    }, ",")
end

function LeaderboardSyncService:ParseMetricDigestPayload(payload)
    local playerKey, playerName, valueText, timestampText, className, versionText, snapshotHash = strsplit(",", payload or "", 7)
    local value = tonumber(valueText)
    if type(playerKey) ~= "string" or playerKey == "" or type(value) ~= "number" then
        return nil
    end
    return {
        playerKey = playerKey,
        playerName = playerName,
        value = value,
        timestamp = tonumber(timestampText) or 0,
        className = className,
        version = tonumber(versionText) or 0,
        snapshotHash = tostring(snapshotHash or ""),
    }
end

function LeaderboardSyncService:GetThrottleInterval(messageType)
    if messageType == MESSAGE_TYPES.BEST_UPDATE then
        return tonumber(self.db.global.bestUpdateMinInterval) or 3
    end
    if messageType == MESSAGE_TYPES.TOPX_SNAPSHOT then
        return tonumber(self.db.global.snapshotMinInterval) or 30
    end
    if messageType == MESSAGE_TYPES.SYNC_REQUEST then
        return tonumber(self.db.global.syncRequestCooldown) or 300
    end
    return 1
end

function LeaderboardSyncService:CanSendNow(messageType, metricId)
    local key = tostring(messageType) .. ":" .. tostring(metricId or "*")
    local now = GetTime()
    local interval = self:GetThrottleInterval(messageType)
    local lastSent = self.state.lastSentByKey[key] or 0
    if (now - lastSent) < interval then
        local stats = self:EnsureSyncStats()
        stats.throttled = (stats.throttled or 0) + 1
        return false
    end
    self.state.lastSentByKey[key] = now
    return true
end

function LeaderboardSyncService:BuildSendStateKey(messageType, metricId, target, className)
    local parts = {
        tostring(messageType or ""),
        tostring(metricId or "*"),
    }
    if type(target) == "string" and target ~= "" then
        parts[#parts + 1] = target
    end
    if type(className) == "string" and className ~= "" then
        parts[#parts + 1] = className
    end
    return table.concat(parts, ":")
end

function LeaderboardSyncService:ComputePayloadSignature(payload)
    local text = tostring(payload or "")
    return tostring(#text) .. ":" .. tostring(simpleHash32(text))
end

function LeaderboardSyncService:HasPayloadChanged(sendStateKey, payload)
    local sigMap = self.state.lastPayloadSignatureByKey or {}
    self.state.lastPayloadSignatureByKey = sigMap
    local signature = self:ComputePayloadSignature(payload)
    local previous = sigMap[sendStateKey]
    return previous ~= signature
end

function LeaderboardSyncService:RecordSentPayloadSignature(sendStateKey, payload)
    local sigMap = self.state.lastPayloadSignatureByKey or {}
    self.state.lastPayloadSignatureByKey = sigMap
    sigMap[sendStateKey] = self:ComputePayloadSignature(payload)
end

function LeaderboardSyncService:EnsureSyncStats()
    if type(self.db.char.syncStats) ~= "table" then
        self.db.char.syncStats = {}
    end
    local stats = self.db.char.syncStats
    stats.sent = tonumber(stats.sent) or 0
    stats.received = tonumber(stats.received) or 0
    stats.throttled = tonumber(stats.throttled) or 0
    stats.dropped = tonumber(stats.dropped) or 0
    stats.merged = tonumber(stats.merged) or 0
    stats.digestCompared = tonumber(stats.digestCompared) or 0
    stats.digestUpToDate = tonumber(stats.digestUpToDate) or 0
    stats.digestStale = tonumber(stats.digestStale) or 0
    stats.snapshotRequested = tonumber(stats.snapshotRequested) or 0
    stats.snapshotSkipped = tonumber(stats.snapshotSkipped) or 0
    stats.lastSentAt = tonumber(stats.lastSentAt) or 0
    stats.lastReceivedAt = tonumber(stats.lastReceivedAt) or 0
    if type(stats.sentByType) ~= "table" then
        stats.sentByType = {}
    end
    if type(stats.droppedByType) ~= "table" then
        stats.droppedByType = {}
    end
    return stats
end

function LeaderboardSyncService:IncrementSyncCounter(counterName, messageType)
    local stats = self:EnsureSyncStats()
    stats[counterName] = (tonumber(stats[counterName]) or 0) + 1
    local typeKey = tostring(messageType or "UNKNOWN")
    if counterName == "sent" then
        stats.sentByType[typeKey] = (tonumber(stats.sentByType[typeKey]) or 0) + 1
    elseif counterName == "dropped" then
        stats.droppedByType[typeKey] = (tonumber(stats.droppedByType[typeKey]) or 0) + 1
    end
    return stats
end

function LeaderboardSyncService:RecordOutboundDrop(messageType, metricId, reason, envelopeLength, envelopeLimit, channel, resultCode)
    self:IncrementSyncCounter("dropped", messageType)
    self:DebugSync("Dropped outbound %s for %s: reason=%s envelope=%s limit=%s channel=%s result=%s",
        tostring(messageType or "UNKNOWN"),
        tostring(metricId or "*"),
        tostring(reason or "unknown"),
        tostring(envelopeLength or "-"),
        tostring(envelopeLimit or "-"),
        tostring(channel or "-"),
        tostring(resultCode or "-"))
end

function LeaderboardSyncService:RecordOutboundSent(messageType)
    local stats = self:IncrementSyncCounter("sent", messageType)
    stats.lastSentAt = GetTime()
end

function LeaderboardSyncService:NormalizeSendResult(result)
    return (result == nil) or (result == true) or (type(result) == "number" and result == SEND_RESULT_CODES.SUCCESS)
end

function LeaderboardSyncService:SendEnvelope(envelope, metricId, messageType)
    if type(envelope) ~= "string" or envelope == "" then
        self:RecordOutboundDrop(messageType, metricId, "invalid envelope", nil, nil, nil, nil)
        return false, "invalid envelope"
    end
    if self:IsCombatSyncBlocked() then
        self:RecordOutboundDrop(messageType, metricId, "in combat", #envelope, nil, nil, nil)
        return false, "in_combat_blocked"
    end
    local channel = self:SelectChannel()
    if not channel then
        self:RecordOutboundDrop(messageType, metricId, "no available channel", #envelope, nil, nil, nil)
        return false, "no available channel"
    end
    if not self.SendCommMessage then
        self:RecordOutboundDrop(messageType, metricId, "AceComm unavailable", #envelope, nil, channel, nil)
        return false, "acecomm_unavailable"
    end
    local distribution = channel
    local target = nil
    self:DebugSync("Outbound %s selecting mode=%s distribution=%s target=%s", tostring(messageType), tostring(channel),
        tostring(distribution), tostring(target or ""))
    self:SendCommMessage(ADDON_PREFIX, envelope, distribution, target, "NORMAL")

    self:RecordOutboundSent(messageType)
    self:DebugSync("Sent %s for %s via %s", tostring(messageType), tostring(metricId or "*"), tostring(distribution))
    return true, nil
end

function LeaderboardSyncService:SendEnvelopeWithType(messageType, metricId, payload)
    local envelope = self:BuildEnvelope(messageType, metricId, payload)
    return self:SendEnvelope(envelope, metricId, messageType)
end

function LeaderboardSyncService:SendEnvelopeToTarget(envelope, metricId, messageType, target)
    if type(target) ~= "string" or target == "" then
        return false, "target required"
    end
    if type(envelope) ~= "string" or envelope == "" then
        self:RecordOutboundDrop(messageType, metricId, "invalid envelope", nil, nil, "WHISPER", nil)
        return false, "invalid envelope"
    end
    if self:IsCombatSyncBlocked() then
        self:RecordOutboundDrop(messageType, metricId, "in combat", #envelope, nil, "WHISPER", target)
        return false, "in_combat_blocked"
    end
    if not self.SendCommMessage then
        self:RecordOutboundDrop(messageType, metricId, "AceComm unavailable", #envelope, nil, "WHISPER", target)
        return false, "acecomm_unavailable"
    end
    self:SendCommMessage(ADDON_PREFIX, envelope, "WHISPER", target, "NORMAL")

    self:RecordOutboundSent(messageType)
    self:DebugSync("Sent direct %s for %s to %s via WHISPER", tostring(messageType), tostring(metricId or "*"), tostring(target))
    return true, nil
end

function LeaderboardSyncService:SendEnvelopeWithTypeToTarget(messageType, metricId, payload, target)
    local envelope = self:BuildEnvelope(messageType, metricId, payload)
    return self:SendEnvelopeToTarget(envelope, metricId, messageType, target)
end

-- ============================ SYNC ACTIONS ============================

function LeaderboardSyncService:QueueSnapshot(metricId)
    if type(metricId) ~= "string" or metricId == "" then
        return
    end
    self.state.pendingSnapshotMetrics[metricId] = true
end

function LeaderboardSyncService:SendBestUpdate(metricId)
    if not self:IsEnabled() then
        return false, "disabled"
    end
    local leaderboardService = self:GetLeaderboardService()
    if not leaderboardService or not leaderboardService.GetMetricBestRecord then
        return false, "leaderboard service unavailable"
    end
    local bestRecord = leaderboardService:GetMetricBestRecord(metricId, nil, nil)
    if not bestRecord then
        return false, "no best record"
    end

    local payload = self:BuildBestPayload(bestRecord, "minimal_context")
    local sendStateKey = self:BuildSendStateKey(MESSAGE_TYPES.BEST_UPDATE, metricId, nil, bestRecord.className)
    if not self:HasPayloadChanged(sendStateKey, payload) then
        return false, "unchanged"
    end
    if not self:CanSendNow(MESSAGE_TYPES.BEST_UPDATE, metricId) then
        return false, "throttled"
    end
    local envelope = self:BuildEnvelope(MESSAGE_TYPES.BEST_UPDATE, metricId, payload)
    local ok, err = self:SendEnvelope(envelope, metricId, MESSAGE_TYPES.BEST_UPDATE)
    if ok then
        self:RecordSentPayloadSignature(sendStateKey, payload)
    end
    return ok, err
end

function LeaderboardSyncService:GetSyncTopRecordsForMetric(metricId, topLimit)
    local leaderboardService = self:GetLeaderboardService()
    if not leaderboardService or not leaderboardService.GetMetricTopX then
        return nil, nil, "leaderboard service unavailable"
    end

    local topRecords = leaderboardService:GetMetricTopX(metricId, topLimit, nil, nil) or {}
    return topRecords, nil, nil
end

function LeaderboardSyncService:SendTopXSnapshot(metricId, forceInCombat, bypassThrottle, bypassUnchanged)
    if not self:IsEnabled() then
        return false, "disabled"
    end
    if not metricId or metricId == "" then
        return false, "metricId required"
    end
    local inCombat = UnitAffectingCombat and UnitAffectingCombat("player")
    if inCombat then
        self:QueueSnapshot(metricId)
        return false, "queued_until_out_of_combat"
    end
    local topLimit = tonumber(self.db.global.topXLimit) or 20
    local topRecords, metricClass, fetchErr = self:GetSyncTopRecordsForMetric(metricId, topLimit)
    if not topRecords then
        return false, fetchErr or "leaderboard service unavailable"
    end
    if #topRecords == 0 then
        self:DebugSync("SYNC snapshot has no records for %s (class filter=%s)", tostring(metricId), tostring(metricClass))
        return false, "no records"
    end
    local payload = self:BuildTopXPayload(topRecords)
    local sendStateKey = self:BuildSendStateKey(MESSAGE_TYPES.TOPX_SNAPSHOT, metricId, nil, topRecords[1] and topRecords[1].className)
    if bypassUnchanged ~= true and not self:HasPayloadChanged(sendStateKey, payload) then
        return false, "unchanged"
    end
    if bypassThrottle ~= true and not self:CanSendNow(MESSAGE_TYPES.TOPX_SNAPSHOT, metricId) then
        return false, "throttled"
    end
    local envelope = self:BuildEnvelope(MESSAGE_TYPES.TOPX_SNAPSHOT, metricId, payload)
    local ok, err = self:SendEnvelope(envelope, metricId, MESSAGE_TYPES.TOPX_SNAPSHOT)
    if ok then
        self:RecordSentPayloadSignature(sendStateKey, payload)
    end
    return ok, err
end

function LeaderboardSyncService:SendTopXSnapshotToTarget(metricId, target, forceInCombat, bypassThrottle, bypassUnchanged)
    if not self:IsEnabled() then
        return false, "disabled"
    end
    if type(target) ~= "string" or target == "" then
        return false, "target required"
    end
    if not metricId or metricId == "" then
        return false, "metricId required"
    end
    local inCombat = UnitAffectingCombat and UnitAffectingCombat("player")
    if inCombat then
        self:QueueSnapshot(metricId)
        return false, "queued_until_out_of_combat"
    end
    local throttleKey = tostring(metricId) .. "@" .. tostring(target)
    local topLimit = tonumber(self.db.global.topXLimit) or 20
    local topRecords, metricClass, fetchErr = self:GetSyncTopRecordsForMetric(metricId, topLimit)
    if not topRecords then
        return false, fetchErr or "leaderboard service unavailable"
    end
    if #topRecords == 0 then
        self:DebugSync("SYNC snapshot to %s has no records for %s (class filter=%s)",
            tostring(target), tostring(metricId), tostring(metricClass))
        return false, "no records"
    end
    local payload = self:BuildTopXPayload(topRecords)
    local sendStateKey = self:BuildSendStateKey(MESSAGE_TYPES.TOPX_SNAPSHOT, metricId, target, topRecords[1] and topRecords[1].className)
    if bypassUnchanged ~= true and not self:HasPayloadChanged(sendStateKey, payload) then
        return false, "unchanged"
    end
    if bypassThrottle ~= true and not self:CanSendNow(MESSAGE_TYPES.TOPX_SNAPSHOT, throttleKey) then
        return false, "throttled"
    end
    local envelope = self:BuildEnvelope(MESSAGE_TYPES.TOPX_SNAPSHOT, metricId, payload)
    local ok, err = self:SendEnvelopeToTarget(envelope, metricId, MESSAGE_TYPES.TOPX_SNAPSHOT, target)
    if ok then
        self:RecordSentPayloadSignature(sendStateKey, payload)
    end
    return ok, err
end

function LeaderboardSyncService:SendSyncRequest(metricId, bypassThrottle)
    if not self:IsEnabled() then
        return false, "disabled"
    end
    local targetMetric = metricId or "*"
    if bypassThrottle ~= true and not self:CanSendNow(MESSAGE_TYPES.SYNC_REQUEST, targetMetric) then
        return false, "throttled"
    end
    return self:SendEnvelopeWithType(MESSAGE_TYPES.SYNC_REQUEST, targetMetric, "")
end

function LeaderboardSyncService:SendSyncRequestToTarget(metricId, target)
    if not self:IsEnabled() then
        return false, "disabled"
    end
    local targetMetric = metricId or "*"
    local throttleKey = targetMetric .. "@" .. tostring(target or "")
    if not self:CanSendNow(MESSAGE_TYPES.SYNC_REQUEST, throttleKey) then
        return false, "throttled"
    end
    return self:SendEnvelopeWithTypeToTarget(MESSAGE_TYPES.SYNC_REQUEST, targetMetric, "", target)
end

function LeaderboardSyncService:SendMetricDigest(metricId)
    if not self:IsEnabled() then
        return false, "disabled"
    end
    local leaderboardService = self:GetLeaderboardService()
    if not leaderboardService or not leaderboardService.GetMetricBestRecord then
        return false, "leaderboard service unavailable"
    end
    local bestRecord = leaderboardService:GetMetricBestRecord(metricId, "local", nil)
    if not bestRecord then
        return false, "no best record"
    end
    local snapshotMeta = nil
    if type(leaderboardService.GetMetricSnapshotMeta) == "function" then
        snapshotMeta = leaderboardService:GetMetricSnapshotMeta(metricId, bestRecord.className)
    end
    local payload = self:BuildMetricDigestPayload(bestRecord, snapshotMeta)
    local sendStateKey = self:BuildSendStateKey(MESSAGE_TYPES.METRIC_DIGEST, metricId, nil, bestRecord.className)
    if not self:HasPayloadChanged(sendStateKey, payload) then
        return false, "unchanged"
    end
    local envelope = self:BuildEnvelope(MESSAGE_TYPES.METRIC_DIGEST, metricId, payload)
    local ok, err = self:SendEnvelope(envelope, metricId, MESSAGE_TYPES.METRIC_DIGEST)
    if ok then
        self:RecordSentPayloadSignature(sendStateKey, payload)
    end
    return ok, err
end

function LeaderboardSyncService:SendMetricDigestToTarget(metricId, target)
    if not self:IsEnabled() then
        return false, "disabled"
    end
    if type(target) ~= "string" or target == "" then
        return false, "target required"
    end
    local leaderboardService = self:GetLeaderboardService()
    if not leaderboardService or not leaderboardService.GetMetricBestRecord then
        return false, "leaderboard service unavailable"
    end
    local bestRecord = leaderboardService:GetMetricBestRecord(metricId, "local", nil)
    if not bestRecord then
        return false, "no best record"
    end
    local snapshotMeta = nil
    if type(leaderboardService.GetMetricSnapshotMeta) == "function" then
        snapshotMeta = leaderboardService:GetMetricSnapshotMeta(metricId, bestRecord.className)
    end
    local payload = self:BuildMetricDigestPayload(bestRecord, snapshotMeta)
    local sendStateKey = self:BuildSendStateKey(MESSAGE_TYPES.METRIC_DIGEST, metricId, target, bestRecord.className)
    if not self:HasPayloadChanged(sendStateKey, payload) then
        return false, "unchanged"
    end
    local ok, err = self:SendEnvelopeWithTypeToTarget(MESSAGE_TYPES.METRIC_DIGEST, metricId, payload, target)
    if ok then
        self:RecordSentPayloadSignature(sendStateKey, payload)
    end
    return ok, err
end

function LeaderboardSyncService:SendHelperGlobalDigest(metricId, className)
    if not self:IsEnabled() then
        return false, "disabled"
    end
    local leaderboardService = self:GetLeaderboardService()
    if not leaderboardService or type(leaderboardService.GetHelperGlobalSnapshotMeta) ~= "function" then
        return false, "helper global metadata unavailable"
    end
    local metricKey = self:BuildHelperMetricKey(metricId, className)
    local parsedMetricId, parsedClassName = self:ParseHelperMetricKey(metricKey)
    if not parsedMetricId then
        return false, "invalid helper metric key"
    end
    local meta = leaderboardService:GetHelperGlobalSnapshotMeta(parsedMetricId, parsedClassName)
    if not meta or (tonumber(meta.version) or 0) < 1 then
        return false, "no helper global snapshot"
    end
    local best = nil
    if type(leaderboardService.GetCanonicalBucketTop) == "function" then
        local records = leaderboardService:GetCanonicalBucketTop(parsedMetricId, "global", parsedClassName, 1, false)
        best = records and records[1] or nil
    end
    local payload = self:BuildHelperGlobalDigestPayload(meta, best)
    local sendStateKey = self:BuildSendStateKey(MESSAGE_TYPES.HELPER_GLOBAL_DIGEST, metricKey, nil, parsedClassName)
    if not self:HasPayloadChanged(sendStateKey, payload) then
        return false, "unchanged"
    end
    local envelope = self:BuildEnvelope(MESSAGE_TYPES.HELPER_GLOBAL_DIGEST, metricKey, payload)
    local ok, err = self:SendEnvelope(envelope, metricKey, MESSAGE_TYPES.HELPER_GLOBAL_DIGEST)
    if ok then
        self:RecordSentPayloadSignature(sendStateKey, payload)
    end
    return ok, err
end

function LeaderboardSyncService:SendHelperGlobalRequest(metricId, className, target)
    if not self:IsEnabled() then
        return false, "disabled"
    end
    local metricKey = self:BuildHelperMetricKey(metricId, className)
    local parsedMetricId = self:ParseHelperMetricKey(metricKey)
    if not parsedMetricId then
        return false, "invalid helper metric key"
    end
    local payload = ""
    if type(target) == "string" and target ~= "" then
        return self:SendEnvelopeWithTypeToTarget(MESSAGE_TYPES.HELPER_GLOBAL_REQUEST, metricKey, payload, target)
    end
    return self:SendEnvelopeWithType(MESSAGE_TYPES.HELPER_GLOBAL_REQUEST, metricKey, payload)
end

function LeaderboardSyncService:SendHelperGlobalSnapshot(metricId, className, target)
    if not self:IsEnabled() then
        return false, "disabled"
    end
    local leaderboardService = self:GetLeaderboardService()
    if not leaderboardService then
        return false, "leaderboard service unavailable"
    end
    local metricKey = self:BuildHelperMetricKey(metricId, className)
    local parsedMetricId, parsedClassName = self:ParseHelperMetricKey(metricKey)
    if not parsedMetricId then
        return false, "invalid helper metric key"
    end
    if type(leaderboardService.GetHelperGlobalSnapshotMeta) ~= "function" then
        return false, "helper global metadata unavailable"
    end
    local meta = leaderboardService:GetHelperGlobalSnapshotMeta(parsedMetricId, parsedClassName)
    if not meta or (tonumber(meta.version) or 0) < 1 then
        return false, "no helper global snapshot"
    end
    local records = {}
    if type(leaderboardService.GetCanonicalBucketTop) == "function" then
        records = leaderboardService:GetCanonicalBucketTop(parsedMetricId, "global", parsedClassName,
            tonumber(self.db.global.topXLimit) or 20, false) or {}
    end
    local helperPayload = self:BuildSingleHelperGlobalChunkPayload(meta, records)
    if type(target) == "string" and target ~= "" then
        return self:SendEnvelopeWithTypeToTarget(MESSAGE_TYPES.HELPER_GLOBAL_CHUNK, metricKey, helperPayload, target)
    end
    return self:SendEnvelopeWithType(MESSAGE_TYPES.HELPER_GLOBAL_CHUNK, metricKey, helperPayload)
end

--- Apply helper snapshot locally and optionally advertise digest for redistribution.
--- @param metricId string
--- @param className string|nil
--- @param records table
--- @param snapshotMeta table
--- @param rebroadcast boolean|nil
--- @return boolean
--- @return string|nil
function LeaderboardSyncService:IngestHelperGlobalSnapshot(metricId, className, records, snapshotMeta, rebroadcast)
    local leaderboardService = self:GetLeaderboardService()
    if not leaderboardService or type(leaderboardService.ApplyHelperGlobalSnapshot) ~= "function" then
        return false, "helper global ingest unavailable"
    end
    local ok, err = leaderboardService:ApplyHelperGlobalSnapshot(metricId, className, records, snapshotMeta)
    if not ok then
        return false, err
    end
    if rebroadcast ~= false then
        self:SendHelperGlobalDigest(metricId, className)
    end
    return true, nil
end

function LeaderboardSyncService:FlushPendingSnapshots()
    local pending = self.state.pendingSnapshotMetrics
    for metricId in pairs(pending) do
        self:SendTopXSnapshot(metricId, true)
        pending[metricId] = nil
    end
end

function LeaderboardSyncService:IsValidInboundClass(leaderboardService, className)
    if type(className) ~= "string" or className == "" then
        return true
    end
    if not leaderboardService or type(leaderboardService.NormalizeClassName) ~= "function" then
        return true
    end
    return leaderboardService:NormalizeClassName(className) ~= nil
end

function LeaderboardSyncService:IsMetricProcessable(metricId, allowWildcard)
    if allowWildcard == true and metricId == "*" then
        return true
    end
    if type(metricId) ~= "string" or metricId == "" then
        return false
    end
    local leaderboardService = self:GetLeaderboardService()
    if not leaderboardService then
        return true
    end
    if type(leaderboardService.IsMetricKnown) == "function" then
        return leaderboardService:IsMetricKnown(metricId)
    end
    return true
end

function LeaderboardSyncService:HandleInboundBest(metricId, payload, sender, scope)
    if not self:IsMetricProcessable(metricId, false) then
        return
    end
    local leaderboardService = self:GetLeaderboardService()
    if not leaderboardService or not leaderboardService.MergePeerBest then
        return
    end
    local record = self:ParseBestPayload(payload)
    if not record then
        self.db.char.syncStats.dropped = (self.db.char.syncStats.dropped or 0) + 1
        return
    end
    record.scope = scope
    local merged = leaderboardService:MergePeerBest(metricId, record, scope)
    if merged then
        self.db.char.syncStats.merged = (self.db.char.syncStats.merged or 0) + 1
        if NAG and NAG.SendMessage then
            NAG:SendMessage("NAG_LEADERBOARD_SYNC_MERGED", metricId)
        end
    end
end

function LeaderboardSyncService:HandleInboundTopX(metricId, payload, sender, scope)
    if not self:IsMetricProcessable(metricId, false) then
        return
    end
    local leaderboardService = self:GetLeaderboardService()
    if not leaderboardService or not leaderboardService.MergePeerTopX then
        return
    end
    local records = self:ParseTopXPayload(payload)
    if #records == 0 then
        return
    end
    local inboundRecords = {}
    for i = 1, #records do
        records[i].scope = scope
        inboundRecords[#inboundRecords + 1] = records[i]
    end
    if #inboundRecords == 0 then
        self.db.char.syncStats.dropped = (self.db.char.syncStats.dropped or 0) + 1
        return
    end
    local merged = leaderboardService:MergePeerTopX(metricId, inboundRecords, scope)
    if merged then
        self.db.char.syncStats.merged = (self.db.char.syncStats.merged or 0) + 1
        if NAG and NAG.SendMessage then
            NAG:SendMessage("NAG_LEADERBOARD_SYNC_MERGED", metricId)
        end
    end
end

local function shouldRequestSnapshotByBestFallback(localBest, digest)
    local incomingValue = tonumber(digest and digest.value) or 0
    local incomingTs = tonumber(digest and digest.timestamp) or 0
    local currentValue = localBest and (tonumber(localBest.value) or 0) or 0
    local currentTs = localBest and (tonumber(localBest.timestamp) or 0) or 0
    if incomingValue < currentValue then
        return false
    end
    if incomingValue == currentValue and incomingTs >= currentTs then
        return false
    end
    return true
end

function LeaderboardSyncService:RequestSnapshotFromDigest(metricId, sender, scope, inboundChannel)
    local senderKey = tostring(sender or "?")
    local reqKey = senderKey .. ":" .. tostring(metricId or "") .. ":" .. tostring(scope or "")
    local now = GetTime()
    local cooldown = tonumber(self.db.global.digestRequestCooldown) or 30
    local lastReq = self.state.digestRequestByKey[reqKey] or 0
    if (now - lastReq) < cooldown then
        local stats = self:EnsureSyncStats()
        stats.snapshotSkipped = (stats.snapshotSkipped or 0) + 1
        return false, "cooldown"
    end
    self.state.digestRequestByKey[reqKey] = now
    local normalizedInbound = normalizeInboundChannel(inboundChannel)
    local ok, err
    if normalizedInbound == "WHISPER" and type(sender) == "string" and sender ~= "" then
        ok, err = self:SendSyncRequestToTarget(metricId, sender)
    else
        ok, err = self:SendSyncRequest(metricId)
    end
    local stats = self:EnsureSyncStats()
    if ok then
        stats.snapshotRequested = (stats.snapshotRequested or 0) + 1
    else
        stats.snapshotSkipped = (stats.snapshotSkipped or 0) + 1
    end
    return ok, err
end

function LeaderboardSyncService:HandleInboundDigest(metricId, payload, sender, scope, inboundChannel)
    if not self:IsMetricProcessable(metricId, false) then
        return
    end
    local digest = self:ParseMetricDigestPayload(payload)
    if not digest then
        return
    end
    local leaderboardService = self:GetLeaderboardService()
    if not leaderboardService then
        return
    end

    local stats = self:EnsureSyncStats()
    stats.digestCompared = (stats.digestCompared or 0) + 1
    local hasVersionedDigest = (tonumber(digest.version) or 0) > 0 or tostring(digest.snapshotHash or "") ~= ""
    if hasVersionedDigest and type(leaderboardService.GetMetricSnapshotMeta) == "function" then
        local localMeta = leaderboardService:GetMetricSnapshotMeta(metricId, digest.className)
        local localVersion = tonumber(localMeta and localMeta.version) or 0
        local localHash = tostring(localMeta and localMeta.snapshotHash or "")
        local incomingVersion = tonumber(digest.version) or 0
        local incomingHash = tostring(digest.snapshotHash or "")
        local shouldRequest = false
        if incomingVersion > localVersion then
            shouldRequest = true
        elseif incomingVersion < localVersion then
            shouldRequest = false
        elseif incomingHash ~= "" and localHash ~= "" and incomingHash ~= localHash then
            shouldRequest = true
        else
            shouldRequest = false
        end

        if not shouldRequest then
            stats.digestUpToDate = (stats.digestUpToDate or 0) + 1
            self:DebugSync("Digest up-to-date for %s from %s (local=%s/%s incoming=%s/%s)",
                tostring(metricId), tostring(sender), tostring(localVersion), tostring(localHash),
                tostring(incomingVersion), tostring(incomingHash))
            return
        end
        stats.digestStale = (stats.digestStale or 0) + 1
        self:DebugSync("Digest stale for %s from %s (local=%s/%s incoming=%s/%s)",
            tostring(metricId), tostring(sender), tostring(localVersion), tostring(localHash),
            tostring(incomingVersion), tostring(incomingHash))
        self:RequestSnapshotFromDigest(metricId, sender, scope, inboundChannel)
        return
    end

    if type(leaderboardService.GetCombinedTopX) ~= "function" then
        return
    end
    local currentTop = leaderboardService:GetCombinedTopX(metricId, 1, scope, nil)
    local best = currentTop[1]
    if not shouldRequestSnapshotByBestFallback(best, digest) then
        stats.digestUpToDate = (stats.digestUpToDate or 0) + 1
        return
    end
    stats.digestStale = (stats.digestStale or 0) + 1
    self:RequestSnapshotFromDigest(metricId, sender, scope, inboundChannel)
end

function LeaderboardSyncService:HandleInboundHelperGlobalDigest(metricKey, payload, sender, inboundChannel)
    local metricId, className = self:ParseHelperMetricKey(metricKey)
    if not metricId then
        return
    end
    if not self:IsMetricProcessable(metricId, false) then
        return
    end
    local digest = self:ParseHelperGlobalDigestPayload(payload)
    if not digest then
        return
    end
    local leaderboardService = self:GetLeaderboardService()
    if not leaderboardService or type(leaderboardService.GetHelperGlobalSnapshotMeta) ~= "function" then
        return
    end
    if not self:IsValidInboundClass(leaderboardService, className) then
        return
    end
    local localMeta = leaderboardService:GetHelperGlobalSnapshotMeta(metricId, className)
    local localVersion = tonumber(localMeta and localMeta.version) or 0
    local localHash = tostring(localMeta and localMeta.snapshotHash or "")
    local incomingVersion = tonumber(digest.version) or 0
    local incomingHash = tostring(digest.snapshotHash or "")
    if incomingVersion < localVersion then
        return
    end
    if incomingVersion == localVersion and incomingHash ~= "" and incomingHash == localHash then
        return
    end

    local senderKey = tostring(sender or "?")
    local reqKey = senderKey .. ":" .. tostring(metricKey or "")
    local now = GetTime()
    local cooldown = tonumber(self.db.global.digestRequestCooldown) or 30
    local lastReq = self.state.helperGlobalRequestByKey[reqKey] or 0
    if (now - lastReq) < cooldown then
        return
    end
    self.state.helperGlobalRequestByKey[reqKey] = now
    local normalizedInbound = normalizeInboundChannel(inboundChannel)
    if normalizedInbound == "WHISPER" and type(sender) == "string" and sender ~= "" then
        self:SendHelperGlobalRequest(metricId, className, sender)
    else
        self:SendHelperGlobalRequest(metricId, className)
    end
end

function LeaderboardSyncService:HandleInboundHelperGlobalRequest(metricKey, sender, inboundChannel)
    if not self:ShouldRespondToSyncRequest(sender) then
        return
    end
    local metricId, className = self:ParseHelperMetricKey(metricKey)
    if not metricId then
        return
    end
    if not self:IsMetricProcessable(metricId, false) then
        return
    end
    local normalizedInbound = normalizeInboundChannel(inboundChannel)
    if normalizedInbound == "WHISPER" and type(sender) == "string" and sender ~= "" then
        self:SendHelperGlobalSnapshot(metricId, className, sender)
    else
        self:SendHelperGlobalSnapshot(metricId, className, nil)
    end
end

function LeaderboardSyncService:HandleInboundHelperGlobalChunk(metricKey, payload, sender)
    local metricId, className = self:ParseHelperMetricKey(metricKey)
    if not metricId then
        return
    end
    if not self:IsMetricProcessable(metricId, false) then
        return
    end
    local parsed = self:ParseHelperGlobalChunkPayload(payload)
    if not parsed then
        self.db.char.syncStats.dropped = (self.db.char.syncStats.dropped or 0) + 1
        return
    end
    local leaderboardService = self:GetLeaderboardService()
    if not leaderboardService or type(leaderboardService.ApplyHelperGlobalSnapshot) ~= "function" then
        return
    end
    if not self:IsValidInboundClass(leaderboardService, className) then
        self.db.char.syncStats.dropped = (self.db.char.syncStats.dropped or 0) + 1
        return
    end

    local senderKey = tostring(sender or "?")
    self.state.pendingHelperGlobalChunks[senderKey] = self.state.pendingHelperGlobalChunks[senderKey] or {}
    local senderChunks = self.state.pendingHelperGlobalChunks[senderKey]
    local streamKey = tostring(metricKey or "") .. ":" .. tostring(parsed.version) .. ":" .. tostring(parsed.snapshotHash or "") ..
        ":" .. tostring(parsed.chunk.chunkId or "")
    local state = senderChunks[streamKey]
    if not state then
        state = {
            received = {},
            lastSeq = nil,
            startedAt = GetTime(),
            lastUpdate = GetTime(),
            metricId = metricId,
            className = className,
            version = parsed.version,
            snapshotHash = parsed.snapshotHash or "",
        }
        senderChunks[streamKey] = state
    end
    state.lastUpdate = GetTime()
    local seq = parsed.chunk.seq
    if state.received[seq] then
        return
    end
    state.received[seq] = parsed.chunk.records or {}
    if parsed.chunk.isLast then
        state.lastSeq = seq
    end
    if not state.lastSeq then
        return
    end
    for i = 1, state.lastSeq do
        if not state.received[i] then
            return
        end
    end

    local mergedRecords = {}
    for i = 1, state.lastSeq do
        local part = state.received[i]
        for j = 1, #part do
            mergedRecords[#mergedRecords + 1] = part[j]
        end
    end
    senderChunks[streamKey] = nil
    if not next(senderChunks) then
        self.state.pendingHelperGlobalChunks[senderKey] = nil
    end
    local ok = leaderboardService:ApplyHelperGlobalSnapshot(
        state.metricId,
        state.className,
        mergedRecords,
        {
            version = state.version,
            snapshotHash = state.snapshotHash,
        }
    )
    if ok then
        self.db.char.syncStats.merged = (self.db.char.syncStats.merged or 0) + 1
    end
end

function LeaderboardSyncService:HandleInboundSyncRequest(metricId, sender, inboundChannel)
    if not self:IsMetricProcessable(metricId, true) then
        return
    end
    if not self:ShouldRespondToSyncRequest(sender) then
        return
    end

    local function respond()
        local leaderboardService = self:GetLeaderboardService()
        if not leaderboardService then
            return
        end

        local function sendDigestForMetric(requestMetricId)
            local ok, err
            if normalizeInboundChannel(inboundChannel) == "WHISPER" and type(sender) == "string" and sender ~= "" then
                ok, err = self:SendMetricDigestToTarget(requestMetricId, sender)
            else
                ok, err = self:SendMetricDigest(requestMetricId)
            end
            if not ok then
                self:DebugSync("SYNC_REQUEST digest response suppressed for %s: %s", tostring(requestMetricId), tostring(err))
            end
        end

        local function sendSnapshotForMetric(requestMetricId)
            local ok, err
            if normalizeInboundChannel(inboundChannel) == "WHISPER" and type(sender) == "string" and sender ~= "" then
                ok, err = self:SendTopXSnapshotToTarget(requestMetricId, sender, true, true, true)
            else
                ok, err = self:SendTopXSnapshot(requestMetricId, true, true, true)
            end
            if not ok then
                self:DebugSync("SYNC_REQUEST response suppressed for %s: %s", tostring(requestMetricId), tostring(err))
            end
        end

        if metricId == "*" then
            local metricMap = leaderboardService:GetMetricValuesMap() or {}
            local metricIds = {}
            for id in pairs(metricMap) do
                metricIds[#metricIds + 1] = id
            end
            sort(metricIds)
            for i = 1, #metricIds do
                sendDigestForMetric(metricIds[i])
            end
        else
            sendSnapshotForMetric(metricId)
        end
    end

    local jitter = tonumber(self.db.global.responseJitterMaxSeconds) or 1.5
    if jitter <= 0 then
        respond()
        return
    end
    local delaySeconds = random() * jitter
    if C_Timer and C_Timer.After then
        C_Timer.After(delaySeconds, respond)
    else
        respond()
    end
end

function LeaderboardSyncService:HandleInboundDigestRequest(metricId)
    if not self:IsMetricProcessable(metricId, true) then
        return
    end
    self:SendSyncRequest(metricId)
end

function LeaderboardSyncService:DispatchInboundEnvelope(parsed, sender, scope, inboundChannel)
    local handlerMethod = INBOUND_HANDLER_METHODS[parsed.messageType]
    if type(handlerMethod) ~= "string" then
        return
    end
    local handler = self[handlerMethod]
    if type(handler) ~= "function" then
        return
    end
    if parsed.messageType == MESSAGE_TYPES.SYNC_REQUEST then
        handler(self, parsed.metricId, sender, inboundChannel)
        return
    end
    if parsed.messageType == MESSAGE_TYPES.DIGEST_REQUEST then
        handler(self, parsed.metricId)
        return
    end
    if parsed.messageType == MESSAGE_TYPES.HELPER_GLOBAL_REQUEST then
        handler(self, parsed.metricId, sender, inboundChannel)
        return
    end
    if parsed.messageType == MESSAGE_TYPES.HELPER_GLOBAL_CHUNK then
        handler(self, parsed.metricId, parsed.payload, sender)
        return
    end
    handler(self, parsed.metricId, parsed.payload, sender, scope, inboundChannel)
end

function LeaderboardSyncService:RotatePeriodicSnapshot()
    if not self:IsEnabled() then
        return
    end
    self:CleanupInboundDedupeCache()
    self:CleanupPendingHelperGlobalChunks()
    local leaderboardService = self:GetLeaderboardService()
    if not leaderboardService then
        return
    end
    local metricMap = leaderboardService:GetMetricValuesMap() or {}
    local metricIds = {}
    for metricId in pairs(metricMap) do
        metricIds[#metricIds + 1] = metricId
    end
    sort(metricIds)
    if #metricIds == 0 then
        return
    end
    local cursor = tonumber(self.state.nextMetricCursor) or 1
    if cursor > #metricIds then
        cursor = 1
    end
    local metricId = metricIds[cursor]
    self.state.nextMetricCursor = cursor + 1
    self:SendTopXSnapshot(metricId, false)
end

function LeaderboardSyncService:RotatePeriodicDigest()
    if not self:IsEnabled() then
        return
    end
    local leaderboardService = self:GetLeaderboardService()
    if not leaderboardService then
        return
    end
    local metricMap = leaderboardService:GetMetricValuesMap() or {}
    local metricIds = {}
    for metricId in pairs(metricMap) do
        metricIds[#metricIds + 1] = metricId
    end
    sort(metricIds)
    if #metricIds == 0 then
        return
    end
    local cursor = tonumber(self.state.nextDigestMetricCursor) or 1
    if cursor > #metricIds then
        cursor = 1
    end
    local metricId = metricIds[cursor]
    self.state.nextDigestMetricCursor = cursor + 1
    self:SendMetricDigest(metricId)
    if leaderboardService and type(leaderboardService.GetMetricClassName) == "function" then
        local metricClass = leaderboardService:GetMetricClassName(metricId) or "ALL"
        self:SendHelperGlobalDigest(metricId, metricClass)
    end
end

function LeaderboardSyncService:GetChannelReachability()
    local autoCandidate = self:SelectChannel()
    return {
        selectedMode = tostring(self.db.global.channelMode or CHANNEL_MODES.AUTO),
        autoCandidate = tostring(autoCandidate or "none"),
        guild = self:IsChannelAvailable(CHANNEL_MODES.GUILD) == true,
        instance = self:IsChannelAvailable(CHANNEL_MODES.INSTANCE_CHAT) == true,
        raid = self:IsChannelAvailable(CHANNEL_MODES.RAID) == true,
        party = self:IsChannelAvailable(CHANNEL_MODES.PARTY) == true,
        say = self:IsChannelAvailable(CHANNEL_MODES.SAY) == true,
        yell = self:IsChannelAvailable(CHANNEL_MODES.YELL) == true,
    }
end

-- ============================ MODULE EVENTS ============================

--- AceComm callback: full reassembled message (prefix, message, distribution, sender).
function LeaderboardSyncService:OnCommReceived(prefix, message, distribution, sender)
    if prefix ~= ADDON_PREFIX then
        return
    end
    local myName = makePlayerKey()
    if sender and sender == myName then
        return
    end
    local parsed, err = self:ParseEnvelope(message)
    if not parsed then
        self.db.char.syncStats.dropped = (self.db.char.syncStats.dropped or 0) + 1
        return
    end
    self.db.char.syncStats.received = (self.db.char.syncStats.received or 0) + 1
    self.db.char.syncStats.lastReceivedAt = GetTime()
    local now = GetTime()
    local cleanupInterval = DEFAULT_STALE_DEDUPE_CLEANUP_INTERVAL
    local lastCleanupAt = tonumber(self.state.lastInboundCleanupAt) or 0
    if (now - lastCleanupAt) >= cleanupInterval then
        self.state.lastInboundCleanupAt = now
        self:CleanupInboundDedupeCache()
        self:CleanupPendingHelperGlobalChunks()
    end
    if self:IsInboundMessageDuplicate(parsed, sender) then
        return
    end
    local normalizedChannel = normalizeInboundChannel(distribution)
    local scope = self:ResolveInboundScope(normalizedChannel, sender)
    self:DebugSync("Inbound %s metric=%s channel=%s scope=%s sender=%s", tostring(parsed.messageType),
        tostring(parsed.metricId), tostring(normalizedChannel), tostring(scope), tostring(sender))

    if parsed.messageType == MESSAGE_TYPES.SYNC_ACK then
        -- Reserved for diagnostics; no-op in v1.
        return
    end
    self:DispatchInboundEnvelope(parsed, sender, scope, normalizedChannel)
end

function LeaderboardSyncService:PLAYER_ENTERING_WORLD()
    if self.state.startupSyncRequested then
        return
    end
    self.state.startupSyncRequested = true
    local delaySeconds = tonumber(self.db.global.startupRequestDelay) or 8
    if C_Timer and C_Timer.After then
        C_Timer.After(delaySeconds, function()
            LeaderboardSyncService:SendSyncRequest("*")
        end)
    end
end

function LeaderboardSyncService:PLAYER_REGEN_ENABLED()
    self:FlushPendingSnapshots()
end

function LeaderboardSyncService:GROUP_ROSTER_UPDATE()
    if not self:IsEnabled() then
        return
    end
    if not ((IsInGroup and IsInGroup()) or (IsInRaid and IsInRaid())) then
        return
    end
    local now = GetTime()
    local lastRequestAt = tonumber(self.state.lastGroupSyncRequestAt) or 0
    if (now - lastRequestAt) < 15 then
        return
    end
    self.state.lastGroupSyncRequestAt = now
    self:SendSyncRequest("*", true)
end

function LeaderboardSyncService:IsLocalRecordPromotionWorthy(metricId, record)
    if type(metricId) ~= "string" or metricId == "" then
        return false
    end
    if type(record) ~= "table" then
        return true
    end
    if type(record.playerKey) ~= "string" or record.playerKey == "" then
        return true
    end
    if type(record.value) ~= "number" then
        return true
    end

    local leaderboardService = self:GetLeaderboardService()
    if not leaderboardService or type(leaderboardService.GetMetricBestRecord) ~= "function" then
        return true
    end

    local bestLocal = leaderboardService:GetMetricBestRecord(metricId, "local", nil)
    if type(bestLocal) ~= "table" then
        return true
    end

    local recordPlayer = tostring(record.playerKey or "")
    local bestPlayer = tostring(bestLocal.playerKey or "")
    if recordPlayer ~= "" and bestPlayer ~= "" and recordPlayer ~= bestPlayer then
        return false
    end

    local recordValue = tonumber(record.value) or 0
    local bestValue = tonumber(bestLocal.value) or 0
    if recordValue < bestValue then
        return false
    end
    if recordValue == bestValue then
        local recordTs = tonumber(record.timestamp) or 0
        local bestTs = tonumber(bestLocal.timestamp) or 0
        if recordTs > 0 and bestTs > 0 and recordTs > bestTs then
            return false
        end
    end
    return true
end

function LeaderboardSyncService:OnLocalRecordAdded(message, metricId, record)
    if type(metricId) ~= "string" or metricId == "" then
        self:DebugSync("OnLocalRecordAdded ignored invalid metricId: %s", tostring(metricId))
        return
    end
    if not self:IsLocalRecordPromotionWorthy(metricId, record) then
        self:DebugSync("OnLocalRecordAdded send suppressed for %s: not promotion-worthy", tostring(metricId))
        return
    end
    local ok, err = self:SendBestUpdate(metricId)
    if not ok then
        self:DebugSync("OnLocalRecordAdded send suppressed for %s: %s", tostring(metricId), tostring(err))
    end
end

-- ============================ OPTIONS / DIAGNOSTICS ============================

function LeaderboardSyncService:GetSyncStats()
    return self:EnsureSyncStats()
end

function LeaderboardSyncService:HandleSyncSlash(input)
    local normalized = tostring(input or ""):lower()
    if normalized == "request" or normalized == "req" or normalized == "request force" or normalized == "req force" then
        local bypassThrottle = (normalized == "request force" or normalized == "req force")
        local ok, err = self:SendSyncRequest("*", bypassThrottle)
        if not ok then
            self:Print(string.format(L["Leaderboard sync request failed: %s"] or "Leaderboard sync request failed: %s", tostring(err)))
        else
            if bypassThrottle then
                self:Print(L["Leaderboard sync request sent (manual force)."] or "Leaderboard sync request sent (manual force).")
            else
                self:Print(L["Leaderboard sync request sent."] or "Leaderboard sync request sent.")
            end
        end
        return
    end
    if normalized == "status" then
        local status = self:GetChannelReachability()
        self:Print(string.format(
            L["Sync status - mode=%s, auto=%s, reachability: guild=%s instance=%s raid=%s party=%s say=%s yell=%s"] or "Sync status - mode=%s, auto=%s, reachability: guild=%s instance=%s raid=%s party=%s say=%s yell=%s",
            tostring(status.selectedMode),
            tostring(status.autoCandidate),
            status.guild and "yes" or "no",
            status.instance and "yes" or "no",
            status.raid and "yes" or "no",
            status.party and "yes" or "no",
            status.say and "yes" or "no",
            status.yell and "yes" or "no"
        ))
        return
    end
    if normalized == "debug on" then
        self.db.global.debugSync = true
        self:Print(L["Leaderboard sync debug enabled."] or "Leaderboard sync debug enabled.")
        return
    end
    if normalized == "debug off" then
        self.db.global.debugSync = false
        self:Print(L["Leaderboard sync debug disabled."] or "Leaderboard sync debug disabled.")
        return
    end
    self:Print(L["Usage: /nagdebug leaderboard sync [request|request force|status|debug on|debug off]"] or "Usage: /nagdebug leaderboard sync [request|request force|status|debug on|debug off]")
end

function LeaderboardSyncService:GetOptions()
    local function hideDeveloperOptions()
        return not (NAG and NAG.IsDevModeEnabled and NAG:IsDevModeEnabled())
    end
    return {
        type = "group",
        name = L["Leaderboard Sync"] or "Leaderboard Sync",
        order = 61,
        args = {
            enabled = {
                type = "toggle",
                name = L["Enable Intra-Addon Leaderboard Sync"] or "Enable Intra-Addon Leaderboard Sync",
                order = 1,
                get = function() return self.db.global.enabled == true end,
                set = function(_, value) self.db.global.enabled = (value == true) end,
            },
            channelMode = {
                type = "select",
                name = L["Channel Mode"] or "Channel Mode",
                order = 2,
                hidden = hideDeveloperOptions,
                values = {
                    [CHANNEL_MODES.AUTO] = L["Auto (Instance -> Raid -> Party -> Guild)"] or "Auto (Instance -> Raid -> Party -> Guild)",
                    [CHANNEL_MODES.GUILD] = L["Guild"] or "Guild",
                    [CHANNEL_MODES.INSTANCE_CHAT] = L["Instance Chat"] or "Instance Chat",
                    [CHANNEL_MODES.RAID] = L["Raid"] or "Raid",
                    [CHANNEL_MODES.PARTY] = L["Party"] or "Party",
                    [CHANNEL_MODES.SAY] = L["Say (Classic Fallback)"] or "Say (Classic Fallback)",
                    [CHANNEL_MODES.YELL] = L["Yell (Classic Fallback)"] or "Yell (Classic Fallback)",
                },
                get = function() return tostring(self.db.global.channelMode or CHANNEL_MODES.AUTO) end,
                set = function(_, value) self.db.global.channelMode = tostring(value or CHANNEL_MODES.AUTO) end,
            },
            topXLimit = {
                type = "range",
                name = L["Top-X Limit"] or "Top-X Limit",
                order = 3,
                hidden = hideDeveloperOptions,
                min = 1,
                max = 25,
                step = 1,
                get = function() return tonumber(self.db.global.topXLimit) or 20 end,
                set = function(_, value) self.db.global.topXLimit = value end,
            },
            bestUpdateMinInterval = {
                type = "range",
                name = L["Best Update Min Interval"] or "Best Update Min Interval",
                order = 4,
                hidden = hideDeveloperOptions,
                min = 1,
                max = 30,
                step = 1,
                get = function() return tonumber(self.db.global.bestUpdateMinInterval) or 3 end,
                set = function(_, value) self.db.global.bestUpdateMinInterval = value end,
            },
            snapshotMinInterval = {
                type = "range",
                name = L["Snapshot Min Interval"] or "Snapshot Min Interval",
                order = 5,
                hidden = hideDeveloperOptions,
                min = 5,
                max = 300,
                step = 1,
                get = function() return tonumber(self.db.global.snapshotMinInterval) or 30 end,
                set = function(_, value) self.db.global.snapshotMinInterval = value end,
            },
            periodicDigestInterval = {
                type = "range",
                name = L["Digest Interval"] or "Digest Interval",
                order = 5.5,
                hidden = hideDeveloperOptions,
                min = 20,
                max = 300,
                step = 5,
                get = function() return tonumber(self.db.global.periodicDigestInterval) or 60 end,
                set = function(_, value) self.db.global.periodicDigestInterval = value end,
            },
            debugSync = {
                type = "toggle",
                name = L["Debug Output"] or "Debug Output",
                order = 6,
                get = function() return self.db.global.debugSync == true end,
                set = function(_, value) self.db.global.debugSync = (value == true) end,
                hidden = function() return not (NAG and NAG.IsDevModeEnabled and NAG:IsDevModeEnabled()) end,
            },
            syncNow = {
                type = "execute",
                name = L["Request Sync Now"] or "Request Sync Now",
                order = 7,
                hidden = hideDeveloperOptions,
                func = function() self:SendSyncRequest("*") end,
            },
            stats = {
                type = "description",
                order = 8,
                hidden = hideDeveloperOptions,
                name = function()
                    local stats = self:GetSyncStats()
                    return string.format(
                        L["Stats - sent: %d, received: %d, merged: %d, throttled: %d, dropped: %d, digest compared/up-to-date/stale: %d/%d/%d, snapshot requested/skipped: %d/%d"] or
                        "Stats - sent: %d, received: %d, merged: %d, throttled: %d, dropped: %d, digest compared/up-to-date/stale: %d/%d/%d, snapshot requested/skipped: %d/%d",
                        tonumber(stats.sent) or 0,
                        tonumber(stats.received) or 0,
                        tonumber(stats.merged) or 0,
                        tonumber(stats.throttled) or 0,
                        tonumber(stats.dropped) or 0,
                        tonumber(stats.digestCompared) or 0,
                        tonumber(stats.digestUpToDate) or 0,
                        tonumber(stats.digestStale) or 0,
                        tonumber(stats.snapshotRequested) or 0,
                        tonumber(stats.snapshotSkipped) or 0
                    )
                end,
            },
        }
    }
end

-- ============================ LIFECYCLE ============================

function LeaderboardSyncService:ModuleInitialize()
    self:EnsureSyncStats()
    if AceComm and AceComm.Embed and AceComm.RegisterComm then
        AceComm:Embed(self)
        self:RegisterComm(ADDON_PREFIX, "OnCommReceived")
        self:DebugSync("AceComm embedded and registered for prefix: %s", tostring(ADDON_PREFIX))
    else
        self:Warn("Leaderboard sync: AceComm-3.0 not available; sync disabled")
    end
end

function LeaderboardSyncService:ModuleEnable()
    local timerManager = self:GetTimerManager()
    if timerManager and timerManager.Create then
        timerManager:Cancel(timerManager.Categories.CORE, "leaderboardSyncPeriodicSnapshot")
        timerManager:Create(
            timerManager.Categories.CORE,
            "leaderboardSyncPeriodicSnapshot",
            function()
                LeaderboardSyncService:RotatePeriodicSnapshot()
            end,
            tonumber(self.db.global.periodicSnapshotInterval) or 120,
            true
        )
        timerManager:Cancel(timerManager.Categories.CORE, "leaderboardSyncPeriodicDigest")
        timerManager:Create(
            timerManager.Categories.CORE,
            "leaderboardSyncPeriodicDigest",
            function()
                LeaderboardSyncService:RotatePeriodicDigest()
            end,
            tonumber(self.db.global.periodicDigestInterval) or 60,
            true
        )
    end
end

function LeaderboardSyncService:ModuleDisable()
    if self.UnregisterAllComm then
        self:UnregisterAllComm()
    end
    local timerManager = self:GetTimerManager()
    if timerManager and timerManager.Cancel then
        timerManager:Cancel(timerManager.Categories.CORE, "leaderboardSyncPeriodicSnapshot")
        timerManager:Cancel(timerManager.Categories.CORE, "leaderboardSyncPeriodicDigest")
    end
    self.state.digestRequestByKey = {}
    self.state.helperGlobalRequestByKey = {}
    self.state.pendingHelperGlobalChunks = {}
    self.state.lastSentByKey = {}
    self.state.lastPayloadSignatureByKey = {}
    self.state.recentInboundByKey = {}
    self.state.lastInboundCleanupAt = 0
end

return LeaderboardSyncService
