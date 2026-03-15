--- @module "NAG.LeaderboardService"
--- Central leaderboard registry, storage, integrity validation, and export queue management.
---
--- This service provides a modular metric-provider contract for leaderboard metrics:
--- - Providers register metadata and supported scope.
--- - Providers submit normalized records.
--- - Records are stored in append-only metric buckets with a rolling hash chain.
--- - Queries return top/recent/personal-best values with integrity filtering.
--- - Export payloads are generated for external helper-app upload pipelines.
---
--- Tamper model:
--- - Client-side records are tamper-evident (hash-chain), not tamper-proof.
--- - Integrity state is recomputed on load and before query/export operations.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

-- ============================ LOCALIZE ============================

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)

local Version = ns.Version
local json = ns.LibJSON
local LibBase64 = ns.LibBase64

local LibCompress = nil
if LibStub and LibStub.GetLibrary then
    local ok, library = pcall(LibStub.GetLibrary, LibStub, "LibCompress", true)
    if ok then
        LibCompress = library
    end
end

-- Lua APIs
local type = type
local tostring = tostring
local tonumber = tonumber
local pairs = pairs
local ipairs = ipairs
local tinsert = table.insert
local tremove = table.remove
local sort = table.sort
local max = math.max
local strlower = string.lower
local os_time = os and os.time
local GetTime = _G.GetTime
local UnitName = _G.UnitName
local UnitFullName = _G.UnitFullName
local GetRealmName = _G.GetRealmName
local GetGuildInfo = _G.GetGuildInfo
local wipe = wipe

-- ============================ CONSTANTS ============================

local SCHEMA_VERSION = 1
local EXPORT_FORMAT_VERSION = 1
local ROOT_PREV_HASH = "root"
local DEFAULT_TOP_LIMIT = 20
local DEFAULT_RECENT_LIMIT = 20
local DEFAULT_PEER_TOP_LIMIT = 20
local DISPLAY_MIGRATION_VERSION = 1
local BUCKET_SCHEMA_VERSION = 1
local DAMAGE_CRIT_METRIC_ID = "damage_crit_topX"
local HEAL_CRIT_METRIC_ID = "heal_crit_topX"
local LEADERBOARD_SCOPES = {
    ALL = "all",
    LOCAL = "local",
    GUILD = "guild",
    SERVER = "server",
    GLOBAL = "global",
}
local CLASS_ALL = "ALL"
local VALID_CLASS_TOKENS = {
    DEATHKNIGHT = true,
    DRUID = true,
    HUNTER = true,
    MAGE = true,
    MONK = true,
    PALADIN = true,
    PRIEST = true,
    ROGUE = true,
    SHAMAN = true,
    WARLOCK = true,
    WARRIOR = true,
    EVOKER = true,
    DEMONHUNTER = true,
    [CLASS_ALL] = true,
}
local DEFAULT_SCOPE_FILTER = LEADERBOARD_SCOPES.ALL
local MAX_FUTURE_TIMESTAMP_SKEW_SECONDS = 120
-- Locale keys for metric display names when provider is not registered (e.g. viewing synced class-specific metric on another class).
local KNOWN_METRIC_DISPLAY_KEYS = {
    [DAMAGE_CRIT_METRIC_ID] = "Damage Crit Top X",
    [HEAL_CRIT_METRIC_ID] = "Healing Crit Top X",
    ["death_knight_gargoyle_damage"] = "Gargoyle Damage",
    ["warlock_shadow_bolt_crit"] = "Shadow Bolt Crit",
    ["paladin_seal_twist_tbc"] = "TBC Paladin Seal Twist Damage",
}
-- Class tag prefix for dropdown (class-specific metrics only). Used in GetMetricValuesMap.
local KNOWN_METRIC_CLASS_PREFIX = {
    ["death_knight_gargoyle_damage"] = "[DK] ",
    ["warlock_shadow_bolt_crit"] = "[Warlock] ",
    ["paladin_seal_twist_tbc"] = "[Paladin] ",
}
local KNOWN_METRIC_CLASS_NAME = {
    ["death_knight_gargoyle_damage"] = "DEATHKNIGHT",
    ["warlock_shadow_bolt_crit"] = "WARLOCK",
    ["paladin_seal_twist_tbc"] = "PALADIN",
}
-- Metrics that are only valid for specific expansions; nil = show on all. Used to filter dropdown and avoid showing e.g. TBC twist on Wrath.
local KNOWN_METRIC_EXPANSIONS = {
    ["death_knight_gargoyle_damage"] = { "wrath", "mists" },
    ["paladin_seal_twist_tbc"] = { "tbc" },
    ["warlock_shadow_bolt_crit"] = { "tbc", "wrath", "mists" },
    -- damage_crit_topX, heal_crit_topX = nil (all expansions)
}
local PEER_SCOPES = {
    LEADERBOARD_SCOPES.GUILD,
    LEADERBOARD_SCOPES.SERVER,
    LEADERBOARD_SCOPES.GLOBAL,
}
local SCOPE_DISPLAY = {
    [LEADERBOARD_SCOPES.ALL] = "All",
    [LEADERBOARD_SCOPES.LOCAL] = "Local",
    [LEADERBOARD_SCOPES.GUILD] = "Guild",
    [LEADERBOARD_SCOPES.SERVER] = "Server",
    [LEADERBOARD_SCOPES.GLOBAL] = "Global",
}

local defaults = {
    global = {
        enabled = true,
        schemaVersion = SCHEMA_VERSION,
        maxRecordsPerMetric = 250,
        exportQueueMax = 20,
        peerTopXLimit = DEFAULT_PEER_TOP_LIMIT,
        includeInvalidInDebugViews = false,
        showUnregisteredMetrics = true,
        pruneMissingProviderMetrics = false,
    },
    char = {
        metricRecords = {},
        metricMeta = {},
        recordsByScopeClassMetric = {},
        displayMigrationVersion = 0,
        bucketSchemaVersion = 0,
        exportQueue = {
            nextId = 1,
            items = {},
        },
        helperGlobalState = {
            latestVersion = 0,
            latestHash = "",
            latestAppliedAt = 0,
            byMetricVersion = {},
            byMetricHash = {},
            byMetricAppliedAt = {},
        },
        metricSnapshotState = {
            byMetricVersion = {},
            byMetricHash = {},
            byMetricAppliedAt = {},
        },
    },
}

-- ============================ MODULE CREATION ============================

--- @class LeaderboardService: CoreModule
local LeaderboardService = NAG:CreateModule("LeaderboardService", defaults, {
    moduleType = ns.MODULE_TYPES.SERVICE,
    databaseRoot = "leaderboard",
    optionsCategory = ns.MODULE_CATEGORIES.LEADERBOARD,
    debugCategories = {
        ns.DEBUG_CATEGORIES.SERVICES,
        ns.DEBUG_CATEGORIES.FEATURES,
    },
})

ns.LeaderboardService = LeaderboardService

-- ============================ MODULE STATE ============================

LeaderboardService.metricProviders = {}
LeaderboardService.selectedMetricId = ""
LeaderboardService.selectedScope = DEFAULT_SCOPE_FILTER
LeaderboardService.runtimeStats = {
    submitCount = 0,
    rejectedCount = 0,
    lastSubmitAt = 0,
}

-- ============================ PRIVATE HELPERS ============================

local function isFiniteNumber(value)
    if type(value) ~= "number" then
        return false
    end
    if value ~= value then
        return false
    end
    if value == math.huge or value == -math.huge then
        return false
    end
    return true
end

local function copyShallow(input)
    local output = {}
    if type(input) ~= "table" then
        return output
    end
    for key, value in pairs(input) do
        output[key] = value
    end
    return output
end

local function getLocalPlayerNameRealm()
    local playerName = UnitName and UnitName("player") or "Unknown"
    local fullName, fullRealm = UnitFullName and UnitFullName("player") or nil, nil
    if UnitFullName then
        fullName, fullRealm = UnitFullName("player")
    end
    if type(fullName) == "string" and fullName ~= "" then
        playerName = fullName
    end
    local realm = fullRealm
    if type(realm) ~= "string" or realm == "" then
        realm = GetRealmName and GetRealmName() or ""
    end
    if realm ~= "" and not tostring(playerName):find("-", 1, true) then
        playerName = tostring(playerName) .. "-" .. realm
    end
    return tostring(playerName)
end

local function normalizePlayerKey(playerKey)
    if type(playerKey) ~= "string" or playerKey == "" then
        return "Unknown"
    end
    return playerKey
end

local function deriveServerName(playerKey, playerName)
    local key = tostring(playerKey or playerName or "")
    if key == "" then
        return ""
    end
    local _, realm = key:match("^([^-]+)%-(.+)$")
    if type(realm) ~= "string" then
        return ""
    end
    return realm
end

--- Returns true if the string looks like a displayable realm name (not a GUID fragment or internal ID).
--- Used to avoid storing/displaying values like "6065-03F68AFD" as realm.
local function isRealmDisplaySafe(s)
    if type(s) ~= "string" or s == "" then
        return false
    end
    if s:match("^%d+%-%x+$") then
        return false
    end
    if not s:match("%a") then
        return false
    end
    return true
end

local function sanitizeRealmForStore(s)
    if type(s) ~= "string" then
        return ""
    end
    if isRealmDisplaySafe(s) then
        return s
    end
    return ""
end

local function getLocalGuildName()
    if type(GetGuildInfo) ~= "function" then
        return ""
    end
    local guildName = GetGuildInfo("player")
    if type(guildName) == "string" then
        return guildName
    end
    return ""
end

local function normalizeIdentityKey(playerKey, playerGUID, playerName)
    local guid = tostring(playerGUID or "")
    if guid ~= "" and guid ~= "unknown" then
        return "guid:" .. guid
    end
    local key = tostring(playerKey or "")
    if key == "" or key == "Unknown" then
        key = tostring(playerName or "")
    end
    if key == "" then
        return "name:unknown"
    end
    return "name:" .. strlower(key)
end

local function normalizeScope(scope, allowAll)
    if type(scope) ~= "string" or scope == "" then
        return nil
    end
    local normalized = tostring(scope):lower()
    if normalized == LEADERBOARD_SCOPES.LOCAL or
        normalized == LEADERBOARD_SCOPES.GUILD or
        normalized == LEADERBOARD_SCOPES.SERVER or
        normalized == LEADERBOARD_SCOPES.GLOBAL then
        return normalized
    end
    if allowAll and normalized == LEADERBOARD_SCOPES.ALL then
        return LEADERBOARD_SCOPES.ALL
    end
    return nil
end

local function normalizeClassName(className, allowAllFilter)
    if className == nil then
        return allowAllFilter and LEADERBOARD_SCOPES.ALL or CLASS_ALL
    end
    if type(className) ~= "string" or className == "" then
        return nil
    end
    if allowAllFilter and string.lower(className) == LEADERBOARD_SCOPES.ALL then
        return LEADERBOARD_SCOPES.ALL
    end
    local upperName = string.upper(className)
    if VALID_CLASS_TOKENS[upperName] then
        return upperName
    end
    return nil
end

local function getRecordScope(record)
    local scoped = record and normalizeScope(record.scope, false)
    return scoped or LEADERBOARD_SCOPES.LOCAL
end

local function doesClassIncludeRecord(classFilter, recordClass)
    if classFilter == nil or classFilter == LEADERBOARD_SCOPES.ALL then
        return true
    end
    local normalizedRecordClass = normalizeClassName(recordClass, false) or CLASS_ALL
    if classFilter == CLASS_ALL then
        return normalizedRecordClass == CLASS_ALL
    end
    return normalizedRecordClass == classFilter
end

local function doesScopeIncludeRecord(scopeFilter, recordScope)
    if scopeFilter == nil or scopeFilter == LEADERBOARD_SCOPES.ALL then
        return true
    end
    if scopeFilter == LEADERBOARD_SCOPES.LOCAL then
        return recordScope == LEADERBOARD_SCOPES.LOCAL
    end
    if scopeFilter == LEADERBOARD_SCOPES.GUILD then
        return recordScope == LEADERBOARD_SCOPES.GUILD or recordScope == LEADERBOARD_SCOPES.LOCAL
    end
    if scopeFilter == LEADERBOARD_SCOPES.SERVER then
        return recordScope == LEADERBOARD_SCOPES.SERVER or
            recordScope == LEADERBOARD_SCOPES.GUILD or
            recordScope == LEADERBOARD_SCOPES.LOCAL
    end
    if scopeFilter == LEADERBOARD_SCOPES.GLOBAL then
        return recordScope == LEADERBOARD_SCOPES.GLOBAL or
            recordScope == LEADERBOARD_SCOPES.SERVER or
            recordScope == LEADERBOARD_SCOPES.GUILD or
            recordScope == LEADERBOARD_SCOPES.LOCAL
    end
    return false
end

local function getPeerScopesForFilter(scopeFilter)
    if scopeFilter == nil or scopeFilter == LEADERBOARD_SCOPES.ALL then
        return PEER_SCOPES
    end
    if scopeFilter == LEADERBOARD_SCOPES.LOCAL then
        return {}
    end
    if scopeFilter == LEADERBOARD_SCOPES.GUILD then
        return {LEADERBOARD_SCOPES.GUILD}
    end
    if scopeFilter == LEADERBOARD_SCOPES.SERVER then
        return {
            LEADERBOARD_SCOPES.SERVER,
            LEADERBOARD_SCOPES.GUILD,
        }
    end
    if scopeFilter == LEADERBOARD_SCOPES.GLOBAL then
        return {
            LEADERBOARD_SCOPES.GLOBAL,
            LEADERBOARD_SCOPES.SERVER,
            LEADERBOARD_SCOPES.GUILD,
        }
    end
    return {}
end

local function getReferenceTimestamp()
    local now = tonumber(os_time and os_time()) or tonumber(GetTime and GetTime()) or 0
    if now < 0 then
        return 0
    end
    return now
end

local MIN_EPOCH_LIKE = 86400 * 31
local MAX_REASONABLE_EPOCH = 4102444800 -- 2100-01-01

local function normalizeTimestampToEpoch(candidateTimestamp)
    local ts = tonumber(candidateTimestamp)
    if not ts then
        return getReferenceTimestamp()
    end
    if ts > 0 and ts <= 86400 * 30 then
        local nowEpoch = tonumber(os_time and os_time()) or 0
        local uptime = tonumber(GetTime and GetTime()) or 0
        if nowEpoch > 0 and uptime > 0 then
            ts = (nowEpoch - uptime) + ts
        else
            -- Preserve order when we can't get real epoch (e.g. test harness); use epoch-like base.
            ts = MIN_EPOCH_LIKE + ts
        end
    end
    return ts
end

local function isTimestampSane(candidateTimestamp)
    local ts = tonumber(candidateTimestamp)
    if not ts or ts <= 0 then
        return false
    end
    if ts > MAX_REASONABLE_EPOCH then
        return false
    end
    local nowEpoch = tonumber(os_time and os_time()) or nil
    if nowEpoch and nowEpoch >= MIN_EPOCH_LIKE then
        return ts <= (nowEpoch + MAX_FUTURE_TIMESTAMP_SKEW_SECONDS)
    end
    -- In environments without epoch clock (some test harnesses), allow sane positive timestamps.
    return true
end

local function isPeerScope(scopeId)
    return scopeId == LEADERBOARD_SCOPES.GUILD or
        scopeId == LEADERBOARD_SCOPES.SERVER or
        scopeId == LEADERBOARD_SCOPES.GLOBAL
end

local function getExpectedEventTypeMapForMetric(service, metricId)
    local provider = service.metricProviders and service.metricProviders[metricId] or nil
    local schema = provider and provider.schema or nil
    local allowedEventTypes = schema and schema.allowedEventTypes or nil
    if type(allowedEventTypes) == "table" then
        return allowedEventTypes
    end

    -- Backward compatibility for legacy registrations.
    if metricId == DAMAGE_CRIT_METRIC_ID then
        return {
            SWING_DAMAGE = true,
            RANGE_DAMAGE = true,
            SPELL_DAMAGE = true,
            SPELL_PERIODIC_DAMAGE = true,
        }
    end
    if metricId == HEAL_CRIT_METRIC_ID then
        return {
            SPELL_HEAL = true,
            SPELL_PERIODIC_HEAL = true,
        }
    end
    return nil
end

local function isContextEventTypeValidForMetric(service, metricId, context, forSanitize)
    local expectedMap = getExpectedEventTypeMapForMetric(service, metricId)
    if not expectedMap then
        return true
    end
    local provider = service.metricProviders and service.metricProviders[metricId] or nil
    local schema = provider and provider.schema or nil
    local contextPolicy = schema and schema.contextPolicy or "strict_event_type"
    if schema == nil and (metricId == DAMAGE_CRIT_METRIC_ID or metricId == HEAL_CRIT_METRIC_ID) then
        contextPolicy = "allow_sparse"
    end
    if type(context) ~= "table" then
        return contextPolicy ~= "strict_event_type" and not forSanitize
    end
    local eventType = context.eventType
    if type(eventType) ~= "string" or eventType == "" then
        if forSanitize then
            return false
        end
        if contextPolicy == "allow_sparse" then
            return true
        end
        return false
    end
    return expectedMap[eventType] == true
end

local function collectSortedKeys(tableValue)
    local keys = {}
    for key in pairs(tableValue) do
        keys[#keys + 1] = key
    end
    sort(keys, function(a, b)
        local typeA = type(a)
        local typeB = type(b)
        if typeA == typeB then
            if typeA == "number" then
                return a < b
            end
            return tostring(a) < tostring(b)
        end
        if typeA == "number" then
            return true
        end
        if typeB == "number" then
            return false
        end
        return tostring(typeA) < tostring(typeB)
    end)
    return keys
end

local function canonicalizeValue(value, depth)
    depth = depth or 0
    if depth > 10 then
        return "<max-depth>"
    end

    local valueType = type(value)
    if valueType == "nil" then
        return "null"
    end
    if valueType == "boolean" then
        return value and "true" or "false"
    end
    if valueType == "number" then
        return string.format("%.6f", value)
    end
    if valueType == "string" then
        return value
    end
    if valueType ~= "table" then
        return "<" .. valueType .. ">"
    end

    local parts = {}
    local keys = collectSortedKeys(value)
    for i = 1, #keys do
        local key = keys[i]
        local encodedKey = tostring(key)
        local encodedValue = canonicalizeValue(value[key], depth + 1)
        parts[#parts + 1] = encodedKey .. "=" .. encodedValue
    end
    return "{" .. table.concat(parts, ",") .. "}"
end

local function buildRecordPayloadString(record)
    local payloadParts = {
        "metricId=" .. tostring(record.metricId or ""),
        "value=" .. canonicalizeValue(record.value),
        "timestamp=" .. canonicalizeValue(record.timestamp),
        "playerGUID=" .. tostring(record.playerGUID or ""),
        "expansionTag=" .. tostring(record.expansionTag or ""),
        "sourceModule=" .. tostring(record.sourceModule or ""),
        "className=" .. tostring(record.className or CLASS_ALL),
        "context=" .. canonicalizeValue(record.context or {}),
        "addonVersion=" .. tostring(record.addonVersion or ""),
        "buildTag=" .. tostring(record.buildTag or ""),
    }
    return table.concat(payloadParts, "|")
end

local function buildPayloadHash(record)
    return ns.computeHash(buildRecordPayloadString(record))
end

local function buildChainHash(prevHash, payloadHash)
    return ns.computeHash(tostring(prevHash or ROOT_PREV_HASH) .. "|" .. tostring(payloadHash or ""))
end

function LeaderboardService:GetMetricRecordsTable(metricId, createIfMissing)
    if type(self.db.char.metricRecords) ~= "table" then
        self.db.char.metricRecords = {}
    end
    local records = self.db.char.metricRecords[metricId]
    if createIfMissing and type(records) ~= "table" then
        records = {}
        self.db.char.metricRecords[metricId] = records
    end
    return records
end

function LeaderboardService:GetMetricMetaTable(metricId, createIfMissing)
    if type(self.db.char.metricMeta) ~= "table" then
        self.db.char.metricMeta = {}
    end
    local meta = self.db.char.metricMeta[metricId]
    if createIfMissing and type(meta) ~= "table" then
        meta = {
            lastHash = ROOT_PREV_HASH,
            totalRecords = 0,
            validRecords = 0,
            invalidRecords = 0,
            lastRecordAt = 0,
        }
        self.db.char.metricMeta[metricId] = meta
    end
    return meta
end

function LeaderboardService:InitializeStorage()
    -- Keep class-specific metric categories visible cross-class (release behavior).
    self.db.global.showUnregisteredMetrics = true
    if type(self.db.char.metricRecords) ~= "table" then
        self.db.char.metricRecords = {}
    end
    if type(self.db.char.metricMeta) ~= "table" then
        self.db.char.metricMeta = {}
    end
    if type(self.db.char.recordsByScopeClassMetric) ~= "table" then
        self.db.char.recordsByScopeClassMetric = {}
    end
    if type(self.db.char.displayMigrationVersion) ~= "number" then
        self.db.char.displayMigrationVersion = 0
    end
    if type(self.db.char.bucketSchemaVersion) ~= "number" then
        self.db.char.bucketSchemaVersion = 0
    end
    if type(self.db.char.exportQueue) ~= "table" then
        self.db.char.exportQueue = { nextId = 1, items = {} }
    end
    if type(self.db.char.exportQueue.items) ~= "table" then
        self.db.char.exportQueue.items = {}
    end
    if type(self.db.char.exportQueue.nextId) ~= "number" then
        self.db.char.exportQueue.nextId = 1
    end
    if type(self.db.char.helperGlobalState) ~= "table" then
        self.db.char.helperGlobalState = {}
    end
    local helperState = self.db.char.helperGlobalState
    helperState.latestVersion = tonumber(helperState.latestVersion) or 0
    helperState.latestHash = tostring(helperState.latestHash or "")
    helperState.latestAppliedAt = tonumber(helperState.latestAppliedAt) or 0
    if type(helperState.byMetricVersion) ~= "table" then
        helperState.byMetricVersion = {}
    end
    if type(helperState.byMetricHash) ~= "table" then
        helperState.byMetricHash = {}
    end
    if type(helperState.byMetricAppliedAt) ~= "table" then
        helperState.byMetricAppliedAt = {}
    end
    if type(self.db.char.metricSnapshotState) ~= "table" then
        self.db.char.metricSnapshotState = {}
    end
    local metricSnapshotState = self.db.char.metricSnapshotState
    if type(metricSnapshotState.byMetricVersion) ~= "table" then
        metricSnapshotState.byMetricVersion = {}
    end
    if type(metricSnapshotState.byMetricHash) ~= "table" then
        metricSnapshotState.byMetricHash = {}
    end
    if type(metricSnapshotState.byMetricAppliedAt) ~= "table" then
        metricSnapshotState.byMetricAppliedAt = {}
    end

end

local function pruneEmptyCanonicalBuckets(byScope)
    if type(byScope) ~= "table" then
        return
    end
    for scopeId, classMap in pairs(byScope) do
        if type(classMap) ~= "table" then
            byScope[scopeId] = nil
        else
            for className, metricMap in pairs(classMap) do
                if type(metricMap) ~= "table" then
                    classMap[className] = nil
                else
                    for metricId, board in pairs(metricMap) do
                        if type(board) ~= "table" or next(board) == nil then
                            metricMap[metricId] = nil
                        end
                    end
                    if next(metricMap) == nil then
                        classMap[className] = nil
                    end
                end
            end
            if next(classMap) == nil then
                byScope[scopeId] = nil
            end
        end
    end
end

function LeaderboardService:GetScopeClassMetricBucket(scope, className, metricId, createIfMissing)
    local scopeId = normalizeScope(scope, false)
    local normalizedClassName = normalizeClassName(className, false)
    if type(metricId) ~= "string" or metricId == "" or not scopeId or not normalizedClassName then
        return nil
    end
    if type(self.db.char.recordsByScopeClassMetric) ~= "table" then
        self.db.char.recordsByScopeClassMetric = {}
    end
    local byScope = self.db.char.recordsByScopeClassMetric
    local scopeBucket = byScope[scopeId]
    if createIfMissing and type(scopeBucket) ~= "table" then
        scopeBucket = {}
        byScope[scopeId] = scopeBucket
    end
    if type(scopeBucket) ~= "table" then
        return nil
    end
    local classBucket = scopeBucket[normalizedClassName]
    if createIfMissing and type(classBucket) ~= "table" then
        classBucket = {}
        scopeBucket[normalizedClassName] = classBucket
    end
    if type(classBucket) ~= "table" then
        return nil
    end
    local metricBucket = classBucket[metricId]
    if createIfMissing and type(metricBucket) ~= "table" then
        metricBucket = {}
        classBucket[metricId] = metricBucket
    end
    return metricBucket
end

function LeaderboardService:UpsertBucketRecord(scope, className, metricId, candidateRecord)
    local bucket = self:GetScopeClassMetricBucket(scope, className, metricId, true)
    if type(bucket) ~= "table" or type(candidateRecord) ~= "table" then
        return false
    end
    local playerKey = normalizePlayerKey(candidateRecord.playerKey or candidateRecord.playerGUID or candidateRecord.playerName)
    local bucketKey = tostring(candidateRecord.runKey or playerKey)
    if bucketKey == "" then
        bucketKey = playerKey
    end
    local existing = bucket[bucketKey]
    local candidateValue = tonumber(candidateRecord.value) or 0
    local candidateTimestamp = tonumber(candidateRecord.timestamp) or 0
    if existing then
        local existingValue = tonumber(existing.value) or 0
        local existingTimestamp = tonumber(existing.timestamp) or 0
        if candidateValue < existingValue then
            return false
        end
        if candidateValue == existingValue and candidateTimestamp >= existingTimestamp then
            return false
        end
    end
    local copied = copyShallow(candidateRecord)
    copied.playerKey = playerKey
    copied.identityKey = normalizeIdentityKey(copied.playerKey, copied.playerGUID, copied.playerName)
    copied.className = normalizeClassName(copied.className, false) or normalizeClassName(className, false) or CLASS_ALL
    copied.scope = normalizeScope(scope, false) or LEADERBOARD_SCOPES.LOCAL
    bucket[bucketKey] = copied
    return true
end

function LeaderboardService:GetPeerTopLimit()
    local limit = tonumber(self.db.global.peerTopXLimit) or DEFAULT_PEER_TOP_LIMIT
    if limit < 1 then
        limit = 1
    end
    return limit
end

local function sortEntriesByValueThenTime(records)
    sort(records, function(a, b)
        if (a.value or 0) == (b.value or 0) then
            return (a.timestamp or 0) < (b.timestamp or 0)
        end
        return (a.value or 0) > (b.value or 0)
    end)
end

function LeaderboardService:TrimPeerMetricBoard(metricId, scope)
    local recordsByScopeClassMetric = self.db.char.recordsByScopeClassMetric or {}
    local keepLimit = self:GetPeerTopLimit()
    local function trimBucket(scopeId, classBucket)
        local board = classBucket and classBucket[metricId]
        if type(board) ~= "table" then
            return
        end
        local values = {}
        for recordKey, record in pairs(board) do
            values[#values + 1] = {
                key = recordKey,
                record = record,
            }
        end
        sort(values, function(a, b)
            local ra = a and a.record or {}
            local rb = b and b.record or {}
            if (ra.value or 0) == (rb.value or 0) then
                return (ra.timestamp or 0) < (rb.timestamp or 0)
            end
            return (ra.value or 0) > (rb.value or 0)
        end)
        local keep = {}
        for i = 1, keepLimit do
            local entry = values[i]
            if entry and entry.key ~= nil then
                keep[entry.key] = true
            end
        end
        for recordKey in pairs(board) do
            if not keep[recordKey] then
                board[recordKey] = nil
            end
        end
    end

    local scopeId = normalizeScope(scope, false)
    for currentScope, classMap in pairs(recordsByScopeClassMetric) do
        if (not scopeId or scopeId == currentScope) and type(classMap) == "table" and currentScope ~= LEADERBOARD_SCOPES.LOCAL then
            for _, classBucket in pairs(classMap) do
                trimBucket(currentScope, classBucket)
            end
        end
    end
end

function LeaderboardService:TrimMetricRecords(metricId)
    local records = self:GetMetricRecordsTable(metricId, false)
    if type(records) ~= "table" then
        return
    end

    local maxRecords = tonumber(self.db.global.maxRecordsPerMetric) or 250
    maxRecords = max(1, maxRecords)

    while #records > maxRecords do
        tremove(records, 1)
    end
end

function LeaderboardService:SanitizeCritMetricBuckets()
    local changed = false
    local metricIds = {}
    for metricId in pairs(self.metricProviders or {}) do
        metricIds[#metricIds + 1] = metricId
    end
    if #metricIds == 0 then
        metricIds = {
            DAMAGE_CRIT_METRIC_ID,
            HEAL_CRIT_METRIC_ID,
        }
    end

    for i = 1, #metricIds do
        local metricId = metricIds[i]
        local records = self:GetMetricRecordsTable(metricId, false)
        if type(records) == "table" and #records > 0 then
            local metricChanged = false
            local cleaned = {}
            for j = 1, #records do
                local record = records[j]
                if type(record) == "table" and isContextEventTypeValidForMetric(self, metricId, record.context, true) then
                    cleaned[#cleaned + 1] = record
                else
                    metricChanged = true
                    changed = true
                end
            end
            if metricChanged then
                self.db.char.metricRecords[metricId] = cleaned
            end
        end

        local byScope = self.db.char.recordsByScopeClassMetric or {}
        for i = 1, #PEER_SCOPES do
            local scopeId = PEER_SCOPES[i]
            local classMap = byScope[scopeId]
            if type(classMap) == "table" then
                for _, metricMap in pairs(classMap) do
                    local peerBoard = metricMap and metricMap[metricId]
                    if type(peerBoard) == "table" then
                        for playerKey, record in pairs(peerBoard) do
                            if type(record) ~= "table" or not isContextEventTypeValidForMetric(self, metricId, record.context, true) then
                                peerBoard[playerKey] = nil
                                changed = true
                            end
                        end
                    end
                end
            end
        end
    end

    return changed
end

function LeaderboardService:RebuildLocalScopeMetricBucket(metricId)
    if type(metricId) ~= "string" or metricId == "" then
        return
    end
    local byScope = self.db.char.recordsByScopeClassMetric or {}
    local localClassMap = byScope[LEADERBOARD_SCOPES.LOCAL]
    if type(localClassMap) == "table" then
        for _, metricMap in pairs(localClassMap) do
            if type(metricMap) == "table" then
                metricMap[metricId] = nil
            end
        end
    end
    local records = self:GetMetricRecordsTable(metricId, false) or {}
    for i = 1, #records do
        local record = records[i]
        if type(record) == "table" then
            local normalizedClass = normalizeClassName(record.className, false) or self:GetMetricClassName(metricId) or CLASS_ALL
            self:UpsertBucketRecord(LEADERBOARD_SCOPES.LOCAL, normalizedClass, metricId, record)
        end
    end
end

function LeaderboardService:RunDisplayMigrationV1()
    local changedMetrics = {}
    for metricId, records in pairs(self.db.char.metricRecords or {}) do
        if type(records) == "table" and #records > 0 then
            local seenRuns = {}
            local rebuilt = {}
            local metricChanged = false
            for i = 1, #records do
                local record = records[i]
                if type(record) == "table" and isFiniteNumber(tonumber(record.value)) then
                    local normalizedTimestamp = normalizeTimestampToEpoch(record.timestamp)
                    if isTimestampSane(normalizedTimestamp) then
                        local sanitized = copyShallow(record)
                        sanitized.timestamp = normalizedTimestamp
                        sanitized.playerGUID = tostring(sanitized.playerGUID or "")
                        sanitized.playerName = tostring(sanitized.playerName or sanitized.playerKey or "Unknown")
                        sanitized.playerKey = normalizePlayerKey(sanitized.playerKey or sanitized.playerName or sanitized.playerGUID)
                        sanitized.identityKey = normalizeIdentityKey(sanitized.playerKey, sanitized.playerGUID, sanitized.playerName)
                        local runKey = sanitized.identityKey .. "|" .. tostring(tonumber(sanitized.value) or 0) .. "|" ..
                            tostring(math.floor(normalizedTimestamp))
                        if not seenRuns[runKey] then
                            seenRuns[runKey] = true
                            rebuilt[#rebuilt + 1] = sanitized
                        else
                            metricChanged = true
                        end
                    else
                        metricChanged = true
                    end
                else
                    metricChanged = true
                end
            end
            if metricChanged then
                self.db.char.metricRecords[metricId] = rebuilt
                changedMetrics[#changedMetrics + 1] = metricId
            end
        end
    end
    for i = 1, #changedMetrics do
        local metricId = changedMetrics[i]
        self:RebuildMetricChain(metricId)
        self:RebuildLocalScopeMetricBucket(metricId)
        self:TouchMetricSnapshotMeta(metricId, self:GetMetricClassName(metricId), true)
    end
end

function LeaderboardService:RunDisplayMigrations()
    local appliedVersion = tonumber(self.db.char.displayMigrationVersion) or 0
    if appliedVersion < 1 then
        self:RunDisplayMigrationV1()
        appliedVersion = 1
    end
    self.db.char.displayMigrationVersion = appliedVersion
end

function LeaderboardService:RunBucketSchemaMigrationV1()
    local byScope = self.db.char.recordsByScopeClassMetric
    if type(byScope) ~= "table" then
        self.db.char.recordsByScopeClassMetric = {}
        byScope = self.db.char.recordsByScopeClassMetric
    end

    -- Peer buckets are cache-like and may hold stale keys from prior schema rules. Keep local records, drop peer scopes.
    byScope[LEADERBOARD_SCOPES.GUILD] = nil
    byScope[LEADERBOARD_SCOPES.SERVER] = nil
    byScope[LEADERBOARD_SCOPES.GLOBAL] = nil

    local metricRecords = self.db.char.metricRecords or {}
    for metricId in pairs(metricRecords) do
        self:RebuildMetricChain(metricId)
        self:RebuildLocalScopeMetricBucket(metricId)
        self:TouchMetricSnapshotMeta(metricId, self:GetMetricClassName(metricId), true)
    end

    pruneEmptyCanonicalBuckets(byScope)
end

function LeaderboardService:RunBucketSchemaMigrations()
    local appliedVersion = tonumber(self.db.char.bucketSchemaVersion) or 0
    if appliedVersion < 1 then
        self:RunBucketSchemaMigrationV1()
        appliedVersion = 1
    end
    self.db.char.bucketSchemaVersion = appliedVersion
end

function LeaderboardService:RebuildMetricChain(metricId)
    local records = self:GetMetricRecordsTable(metricId, false)
    local meta = self:GetMetricMetaTable(metricId, true)
    if type(records) ~= "table" then
        meta.lastHash = ROOT_PREV_HASH
        meta.totalRecords = 0
        meta.validRecords = 0
        meta.invalidRecords = 0
        return
    end

    local previousChainHash = ROOT_PREV_HASH
    local validCount = 0
    local invalidCount = 0

    for i = 1, #records do
        local record = records[i]
        local expectedPayloadHash = buildPayloadHash(record)
        local expectedChainHash = buildChainHash(previousChainHash, expectedPayloadHash)

        local payloadMatches = (record.payloadHash == expectedPayloadHash)
        local chainMatches = (record.chainHash == expectedChainHash and record.prevHash == previousChainHash)

        if payloadMatches and chainMatches then
            record.integrityState = "valid"
            validCount = validCount + 1
            previousChainHash = record.chainHash
        else
            if not payloadMatches then
                record.integrityState = "invalid_payload"
            else
                record.integrityState = "broken_chain"
            end
            invalidCount = invalidCount + 1
            previousChainHash = tostring(record.chainHash or previousChainHash)
        end

        -- Keep canonical local best bucket integrity flags aligned with chain rebuild results.
        local metricClass = normalizeClassName(record.className, false) or self:GetMetricClassName(metricId) or CLASS_ALL
        local localBucket = self:GetScopeClassMetricBucket(LEADERBOARD_SCOPES.LOCAL, metricClass, metricId, false)
        if type(localBucket) == "table" then
            local playerKey = normalizePlayerKey(record.playerKey or record.playerName or record.playerGUID)
            local bestRow = localBucket[playerKey]
            if type(bestRow) == "table" then
                local bestTs = tonumber(bestRow.timestamp) or 0
                local recordTs = tonumber(record.timestamp) or 0
                if bestTs == recordTs then
                    bestRow.integrityState = record.integrityState
                end
            end
        end
    end

    meta.lastHash = previousChainHash
    meta.totalRecords = #records
    meta.validRecords = validCount
    meta.invalidRecords = invalidCount
    meta.lastRecordAt = (#records > 0 and (records[#records].timestamp or 0)) or 0
end

function LeaderboardService:ValidateAllMetricChains()
    for metricId in pairs(self.db.char.metricRecords) do
        self:RebuildMetricChain(metricId)
    end
end

function LeaderboardService:ShouldIncludeRecord(record, includeInvalid)
    if includeInvalid then
        return true
    end
    if type(record) ~= "table" then
        return false
    end
    -- Peer/helper bucket rows are not hash-chain validated and may not carry integrityState.
    if record.integrityState == nil then
        return true
    end
    return record.integrityState == "valid"
end

-- ============================ PROVIDER CONTRACT ============================

--- Register a metric provider.
--- Provider contract:
--- - id: string (required, globally unique)
--- - name: string (required, display name)
--- - description: string|nil
--- - className: string|nil (e.g. "PALADIN")
--- - expansionTag: string|nil (e.g. "tbc")
--- - sourceModule: string|nil
--- - enabled: boolean|function|nil
--- - schema: table|nil (allowedEventTypes/contextPolicy/valueLabel)
--- - capabilities: table|nil (hasLocalTopN/getLocalTopN)
--- - normalizers: table|nil (normalizeContext/normalizeTimestamp)
---
--- Display/query contract:
--- - Providers must only supply metric metadata, record submission, and optional localTopN capability.
--- - Local vs merged row composition is centralized in GetDisplayRows() and must not be reimplemented per provider.
--- - Sync modules are transport/storage only; display semantics live in this service.
--- @param provider table Metric provider definition
--- @return boolean success
--- @return string|nil errorMessage
function LeaderboardService:RegisterMetricProvider(provider)
    if type(provider) ~= "table" then
        return false, "provider must be a table"
    end
    if type(provider.id) ~= "string" or provider.id == "" then
        return false, "provider.id must be a non-empty string"
    end
    if type(provider.name) ~= "string" or provider.name == "" then
        return false, "provider.name must be a non-empty string"
    end

    local normalizedProviderClass = normalizeClassName(provider.className, false) or CLASS_ALL
    local allowedEventTypes = nil
    if type(provider.schema) == "table" and type(provider.schema.allowedEventTypes) == "table" then
        allowedEventTypes = {}
        for eventType, isAllowed in pairs(provider.schema.allowedEventTypes) do
            if type(eventType) == "string" and isAllowed == true then
                allowedEventTypes[eventType] = true
            end
        end
    end

    self.metricProviders[provider.id] = {
        id = provider.id,
        name = provider.name,
        description = provider.description,
        className = normalizedProviderClass,
        expansionTag = provider.expansionTag,
        sourceModule = provider.sourceModule,
        enabled = provider.enabled,
        schema = {
            allowedEventTypes = allowedEventTypes,
            contextPolicy = type(provider.schema) == "table" and tostring(provider.schema.contextPolicy or "strict_event_type")
                or "strict_event_type",
            valueLabel = type(provider.schema) == "table" and provider.schema.valueLabel or nil,
        },
        capabilities = {
            hasLocalTopN = type(provider.capabilities) == "table" and provider.capabilities.hasLocalTopN == true,
            getLocalTopN = type(provider.capabilities) == "table" and type(provider.capabilities.getLocalTopN) == "function"
                and provider.capabilities.getLocalTopN or nil,
        },
        normalizers = {
            normalizeContext = type(provider.normalizers) == "table" and type(provider.normalizers.normalizeContext) == "function"
                and provider.normalizers.normalizeContext or nil,
            normalizeTimestamp = type(provider.normalizers) == "table" and type(provider.normalizers.normalizeTimestamp) == "function"
                and provider.normalizers.normalizeTimestamp or nil,
        },
    }

    if self.selectedMetricId == "" then
        self.selectedMetricId = provider.id
    end
    return true, nil
end

--- Unregister a metric provider by id.
--- @param metricId string
function LeaderboardService:UnregisterMetricProvider(metricId)
    if type(metricId) ~= "string" or metricId == "" then
        return
    end
    self.metricProviders[metricId] = nil
    if self.selectedMetricId == metricId then
        self.selectedMetricId = self:GetFirstMetricId() or ""
    end
end

function LeaderboardService:IsProviderEnabled(metricId)
    local provider = self.metricProviders[metricId]
    if not provider then
        return false
    end
    if type(provider.enabled) == "function" then
        local ok, result = pcall(provider.enabled)
        return ok and result == true
    end
    if provider.enabled == nil then
        return true
    end
    return provider.enabled == true
end

function LeaderboardService:GetFirstMetricId()
    local ids = {}
    for metricId in pairs(self.metricProviders) do
        ids[#ids + 1] = metricId
    end
    sort(ids)
    return ids[1]
end

function LeaderboardService:GetMetricDisplayName(metricId)
    local provider = self.metricProviders[metricId]
    if provider and provider.name then
        return provider.name
    end
    return metricId
end

function LeaderboardService:GetMetricProvider(metricId)
    if type(metricId) ~= "string" or metricId == "" then
        return nil
    end
    return self.metricProviders[metricId]
end

function LeaderboardService:IsMetricKnown(metricId)
    if type(metricId) ~= "string" or metricId == "" then
        return false
    end
    -- Allow known class-specific metrics so sync can be accepted and stored even when no provider is registered (e.g. viewing DK Gargoyle on non-DK).
    if KNOWN_METRIC_DISPLAY_KEYS and KNOWN_METRIC_DISPLAY_KEYS[metricId] then
        return true
    end
    if next(self.metricProviders or {}) == nil then
        return true
    end
    if self.metricProviders[metricId] then
        return true
    end
    if type(self.db.char.metricRecords) == "table" and self.db.char.metricRecords[metricId] ~= nil then
        return true
    end
    local byScope = self.db.char.recordsByScopeClassMetric or {}
    for _, classMap in pairs(byScope) do
        if type(classMap) == "table" then
            for _, metricMap in pairs(classMap) do
                if type(metricMap) == "table" and metricMap[metricId] ~= nil then
                    return true
                end
            end
        end
    end
    return false
end

function LeaderboardService:GetMetricClassName(metricId)
    local provider = self.metricProviders[metricId]
    if not provider then
        local knownClass = KNOWN_METRIC_CLASS_NAME and KNOWN_METRIC_CLASS_NAME[metricId]
        if type(knownClass) == "string" and knownClass ~= "" then
            return knownClass
        end
        return CLASS_ALL
    end
    return normalizeClassName(provider.className, false) or CLASS_ALL
end

function LeaderboardService:NormalizeClassName(className)
    return normalizeClassName(className, false)
end

function LeaderboardService:IsMetricRegistered(metricId)
    return type(metricId) == "string" and metricId ~= "" and self.metricProviders[metricId] ~= nil
end

function LeaderboardService:ShouldExposeUnregisteredMetrics()
    return self.db and self.db.global and self.db.global.showUnregisteredMetrics == true
end

function LeaderboardService:ShouldPruneMissingProviderMetrics()
    return self.db and self.db.global and self.db.global.pruneMissingProviderMetrics == true
end

function LeaderboardService:PruneUnregisteredMetricData()
    if not self:ShouldPruneMissingProviderMetrics() then
        return
    end
    if next(self.metricProviders or {}) == nil then
        return
    end
    local registered = {}
    for metricId in pairs(self.metricProviders or {}) do
        registered[metricId] = true
    end

    local records = self.db.char.metricRecords or {}
    for metricId in pairs(records) do
        if not registered[metricId] then
            records[metricId] = nil
        end
    end

    local metricMeta = self.db.char.metricMeta or {}
    for metricId in pairs(metricMeta) do
        if not registered[metricId] then
            metricMeta[metricId] = nil
        end
    end

    local byScope = self.db.char.recordsByScopeClassMetric or {}
    for scopeId, classMap in pairs(byScope) do
        if type(classMap) == "table" then
            for className, metricMap in pairs(classMap) do
                if type(metricMap) == "table" then
                    for metricId in pairs(metricMap) do
                        if not registered[metricId] then
                            metricMap[metricId] = nil
                        end
                    end
                    if next(metricMap) == nil then
                        classMap[className] = nil
                    end
                end
            end
            if next(classMap) == nil then
                byScope[scopeId] = nil
            end
        end
    end

    local helperState = self.db.char.helperGlobalState or {}
    local byMetricVersion = helperState.byMetricVersion or {}
    local byMetricHash = helperState.byMetricHash or {}
    local byMetricAppliedAt = helperState.byMetricAppliedAt or {}
    local function pruneStateMap(stateMap)
        for stateKey in pairs(stateMap) do
            local metricId = tostring(stateKey):match("^(.-)|")
            if type(metricId) == "string" and metricId ~= "" and not registered[metricId] then
                stateMap[stateKey] = nil
            end
        end
    end
    pruneStateMap(byMetricVersion)
    pruneStateMap(byMetricHash)
    pruneStateMap(byMetricAppliedAt)
    local metricSnapshotState = self.db.char.metricSnapshotState or {}
    pruneStateMap(metricSnapshotState.byMetricVersion or {})
    pruneStateMap(metricSnapshotState.byMetricHash or {})
    pruneStateMap(metricSnapshotState.byMetricAppliedAt or {})

    if self.selectedMetricId ~= "" and not registered[self.selectedMetricId] then
        self.selectedMetricId = self:GetFirstMetricId() or ""
    end
end

local function isMetricAllowedForCurrentExpansion(metricId)
    local allowed = KNOWN_METRIC_EXPANSIONS and KNOWN_METRIC_EXPANSIONS[metricId]
    if not allowed or type(allowed) ~= "table" then
        return true
    end
    local current = (Version and type(Version.GetExpansion) == "function" and Version:GetExpansion()) or ""
    for i = 1, #allowed do
        if allowed[i] == current then
            return true
        end
    end
    return false
end

function LeaderboardService:GetMetricValuesMap()
    self:PruneUnregisteredMetricData()
    local values = {}
    for metricId, provider in pairs(self.metricProviders) do
        if not isMetricAllowedForCurrentExpansion(metricId) then
            -- Skip version-inappropriate metrics (e.g. TBC twist on Wrath client)
        else
            local baseName = provider.name or metricId
            -- Only add [DK]/[Paladin]/[Warlock] prefix for truly class-specific metrics, not for generic CritHealLeaderboardProvider (Damage/Healing Crit Top X).
            local prefix = (KNOWN_METRIC_CLASS_PREFIX and KNOWN_METRIC_CLASS_PREFIX[metricId]) or ""
            values[metricId] = prefix .. baseName
        end
    end
    if not self:ShouldExposeUnregisteredMetrics() then
        return values
    end
    -- Include metrics that appear in storage (e.g. from sync) so they show in the viewer dropdown on any class.
    local function addMetricFromStorage(metricId)
        if type(metricId) ~= "string" or metricId == "" or values[metricId] then
            return
        end
        if not isMetricAllowedForCurrentExpansion(metricId) then
            return
        end
        local baseName = (KNOWN_METRIC_DISPLAY_KEYS[metricId] and (L[KNOWN_METRIC_DISPLAY_KEYS[metricId]] or KNOWN_METRIC_DISPLAY_KEYS[metricId])) or metricId
        local prefix = KNOWN_METRIC_CLASS_PREFIX and KNOWN_METRIC_CLASS_PREFIX[metricId] or ""
        values[metricId] = prefix .. baseName
    end
    for metricId in pairs(self.db.char.metricRecords or {}) do
        addMetricFromStorage(metricId)
    end
    local byScope = self.db.char.recordsByScopeClassMetric or {}
    for _, classMap in pairs(byScope) do
        if type(classMap) == "table" then
            for _, metricMap in pairs(classMap) do
                if type(metricMap) == "table" then
                    for metricId in pairs(metricMap) do
                        addMetricFromStorage(metricId)
                    end
                end
            end
        end
    end
    -- Always list known class-specific metrics so the dropdown shows them even before any sync (e.g. Rogue can select "Gargoyle Damage" and then see data once it arrives).
    if KNOWN_METRIC_DISPLAY_KEYS then
        for metricId, localeKey in pairs(KNOWN_METRIC_DISPLAY_KEYS) do
            if type(metricId) == "string" and metricId ~= "" and not values[metricId] and isMetricAllowedForCurrentExpansion(metricId) then
                local baseName = L[localeKey] or localeKey or metricId
                local prefix = KNOWN_METRIC_CLASS_PREFIX and KNOWN_METRIC_CLASS_PREFIX[metricId] or ""
                values[metricId] = prefix .. baseName
            end
        end
    end
    if next(values) == nil then
        for metricId in pairs(self.db.char.metricRecords or {}) do
            values[metricId] = metricId
        end
        for _, classMap in pairs(byScope) do
            if type(classMap) == "table" then
                for _, metricMap in pairs(classMap) do
                    if type(metricMap) == "table" then
                        for metricId in pairs(metricMap) do
                            values[metricId] = values[metricId] or metricId
                        end
                    end
                end
            end
        end
    end
    return values
end

-- ============================ RECORD INGEST ============================

--- Submit a normalized metric record.
--- @param record table
--- @return boolean success
--- @return string|nil errorMessage
function LeaderboardService:SubmitMetricRecord(record)
    if not self.db.global.enabled then
        self.runtimeStats.rejectedCount = (self.runtimeStats.rejectedCount or 0) + 1
        return false, "LeaderboardService disabled"
    end
    if type(record) ~= "table" then
        self.runtimeStats.rejectedCount = (self.runtimeStats.rejectedCount or 0) + 1
        return false, "record must be table"
    end
    if type(record.metricId) ~= "string" or record.metricId == "" then
        self.runtimeStats.rejectedCount = (self.runtimeStats.rejectedCount or 0) + 1
        return false, "record.metricId missing"
    end
    if not isFiniteNumber(record.value) then
        self.runtimeStats.rejectedCount = (self.runtimeStats.rejectedCount or 0) + 1
        return false, "record.value must be finite number"
    end
    if not self:IsProviderEnabled(record.metricId) and self.metricProviders[record.metricId] then
        self.runtimeStats.rejectedCount = (self.runtimeStats.rejectedCount or 0) + 1
        return false, "metric provider disabled"
    end

    local metricId = record.metricId
    local records = self:GetMetricRecordsTable(metricId, true)
    local meta = self:GetMetricMetaTable(metricId, true)
    local previousHash = meta.lastHash or ROOT_PREV_HASH

    local playerGUID = record.playerGUID
    if type(playerGUID) ~= "string" or playerGUID == "" then
        playerGUID = NAG and NAG.state and NAG.state.player and NAG.state.player.guid or "unknown"
    end

    local expansionTag = record.expansionTag
    if type(expansionTag) ~= "string" or expansionTag == "" then
        expansionTag = Version and Version:GetExpansion() or "unknown"
    end

    local sourceModule = record.sourceModule
    if type(sourceModule) ~= "string" or sourceModule == "" then
        sourceModule = "unknown"
    end

    local provider = self.metricProviders[metricId]
    local normalizedTimestamp = tonumber(record.timestamp)
    if provider and provider.normalizers and type(provider.normalizers.normalizeTimestamp) == "function" then
        local ok, customTs = pcall(provider.normalizers.normalizeTimestamp, provider, record.timestamp, record)
        if ok and isFiniteNumber(tonumber(customTs)) then
            normalizedTimestamp = tonumber(customTs)
        end
    end
    normalizedTimestamp = normalizeTimestampToEpoch(normalizedTimestamp)
    if not isTimestampSane(normalizedTimestamp) then
        self.runtimeStats.rejectedCount = (self.runtimeStats.rejectedCount or 0) + 1
        return false, "record.timestamp is invalid or too far in the future"
    end
    local normalizedScope = normalizeScope(record.scope, false) or LEADERBOARD_SCOPES.LOCAL
    if normalizedScope ~= LEADERBOARD_SCOPES.LOCAL then
        self.runtimeStats.rejectedCount = (self.runtimeStats.rejectedCount or 0) + 1
        return false, "SubmitMetricRecord only accepts local scope"
    end
    local providerClass = self:GetMetricClassName(metricId)
    if record.className ~= nil and normalizeClassName(record.className, false) == nil then
        self.runtimeStats.rejectedCount = (self.runtimeStats.rejectedCount or 0) + 1
        return false, "record.className is invalid"
    end
    local playerState = NAG and NAG.state and NAG.state.player or nil
    local runtimeClass = playerState and playerState.classInfo and playerState.classInfo.fileName or nil
    if type(runtimeClass) ~= "string" or runtimeClass == "" then
        runtimeClass = NAG and NAG.CLASS_FILENAME or nil
    end
    local normalizedClassName = normalizeClassName(record.className, false) or
        normalizeClassName(providerClass, false) or
        normalizeClassName(runtimeClass, false) or
        CLASS_ALL

    local playerName = tostring(record.playerName or getLocalPlayerNameRealm())
    local normalizedPlayerKey = normalizePlayerKey(record.playerKey or playerName or playerGUID)
    local serverName = sanitizeRealmForStore(tostring(record.serverName or deriveServerName(normalizedPlayerKey, playerName)))
    local guildName = tostring(record.guildName or (record.context and record.context.guildName) or getLocalGuildName())
    local normalizedContext = copyShallow(record.context)
    if provider and provider.normalizers and type(provider.normalizers.normalizeContext) == "function" then
        local ok, customContext = pcall(provider.normalizers.normalizeContext, provider, normalizedContext, record)
        if ok and type(customContext) == "table" then
            normalizedContext = customContext
        end
    end
    local normalizedRecord = {
        metricId = metricId,
        value = tonumber(record.value) or 0,
        timestamp = normalizedTimestamp,
        context = normalizedContext,
        playerGUID = playerGUID,
        playerName = playerName,
        playerKey = normalizedPlayerKey,
        playerLevel = (record.context and record.context.playerLevel ~= nil) and tonumber(record.context.playerLevel) or nil,
        identityKey = normalizeIdentityKey(record.playerKey, playerGUID, playerName),
        serverName = serverName,
        guildName = guildName,
        expansionTag = expansionTag,
        sourceModule = sourceModule,
        scope = normalizedScope,
        className = normalizedClassName,
        addonVersion = tostring((NAG and NAG.version) or "unknown"),
        buildTag = tostring((Version and Version:GetExpansion()) or "unknown"),
        prevHash = previousHash,
    }

    normalizedRecord.payloadHash = buildPayloadHash(normalizedRecord)
    normalizedRecord.chainHash = buildChainHash(normalizedRecord.prevHash, normalizedRecord.payloadHash)
    normalizedRecord.integrityState = "valid"

    tinsert(records, normalizedRecord)
    self:UpsertBucketRecord(normalizedScope, normalizedClassName, metricId, normalizedRecord)
    self:TrimMetricRecords(metricId)
    self:RebuildMetricChain(metricId)
    self:TouchMetricSnapshotMeta(metricId, normalizedClassName, false)
    self.runtimeStats.submitCount = (self.runtimeStats.submitCount or 0) + 1
    self.runtimeStats.lastSubmitAt = GetTime()
    if NAG and NAG.SendMessage then
        NAG:SendMessage("NAG_LEADERBOARD_LOCAL_RECORD_ADDED", metricId, normalizedRecord)
    elseif self.Debug then
        self:Debug("Leaderboard local record message not emitted: NAG.SendMessage unavailable")
    end

    return true, nil
end

function LeaderboardService:GetRuntimeStats()
    return {
        submitCount = self.runtimeStats.submitCount or 0,
        rejectedCount = self.runtimeStats.rejectedCount or 0,
        lastSubmitAt = self.runtimeStats.lastSubmitAt or 0,
    }
end

-- ============================ LEADERBOARD QUERIES ============================

local function copyRecordList(input)
    if type(input) ~= "table" then
        return {}
    end
    local out = {}
    for i = 1, #input do
        out[#out + 1] = input[i]
    end
    return out
end

local function buildCurrentPlayerIdentity()
    local playerName, playerRealm = nil, nil
    if type(UnitFullName) == "function" then
        playerName, playerRealm = UnitFullName("player")
    end
    if type(playerName) ~= "string" or playerName == "" then
        playerName = type(UnitName) == "function" and UnitName("player") or ""
    end
    if type(playerRealm) ~= "string" or playerRealm == "" then
        playerRealm = type(GetRealmName) == "function" and GetRealmName() or ""
    end
    local playerKey = tostring(playerName or "")
    if playerKey ~= "" and playerRealm ~= "" and not playerKey:find("-", 1, true) then
        playerKey = playerKey .. "-" .. playerRealm
    end
    return {
        guid = tostring((NAG and NAG.state and NAG.state.player and NAG.state.player.guid) or ""),
        key = playerKey,
        shortName = tostring(playerName or ""),
    }
end

local function isCurrentPlayerRecord(record, identity)
    if type(record) ~= "table" or type(identity) ~= "table" then
        return false
    end
    local currentGuid = tostring(identity.guid or "")
    local candidateGuid = tostring(record.playerGUID or "")
    if currentGuid ~= "" and candidateGuid ~= "" and currentGuid == candidateGuid then
        return true
    end
    local currentKey = tostring(identity.key or "")
    local candidateKey = tostring(record.playerKey or "")
    if currentKey ~= "" and candidateKey ~= "" and currentKey == candidateKey then
        return true
    end
    local currentName = currentKey:match("^([^-]+)") or tostring(identity.shortName or "")
    local candidateName = candidateKey:match("^([^-]+)") or tostring(record.playerName or ""):match("^([^-]+)")
    return candidateName ~= nil and currentName ~= nil and candidateName == currentName
end

local function canonicalRunIdentityKey(record)
    if type(record) ~= "table" then
        return ""
    end
    if type(record.identityKey) == "string" and record.identityKey ~= "" then
        return record.identityKey
    end
    return normalizeIdentityKey(record.playerKey, record.playerGUID, record.playerName)
end

local function buildRecordRunKey(record)
    if type(record) ~= "table" then
        return ""
    end
    local identityKey = canonicalRunIdentityKey(record)
    if identityKey == "" then
        return ""
    end
    local value = tonumber(record.value) or 0
    local normalizedTs = normalizeTimestampToEpoch(record.timestamp)
    local timestampSec = normalizedTs >= 0 and math.floor(normalizedTs) or 0
    return identityKey .. "|" .. tostring(value) .. "|" .. tostring(timestampSec)
end

local function trimRecordsToLimit(records, limit, fallback)
    local maxCount = tonumber(limit) or tonumber(fallback) or DEFAULT_TOP_LIMIT
    if maxCount < 1 then
        maxCount = 1
    end
    if #records > maxCount then
        for i = #records, maxCount + 1, -1 do
            records[i] = nil
        end
    end
end

local function mergeLocalTopNIntoCombined(combined, localTop)
    local output = copyRecordList(combined)
    if type(localTop) ~= "table" or #localTop == 0 then
        return output
    end
    local byRunKey = {}
    for i = 1, #output do
        local record = output[i]
        if type(record) == "table" then
            local runKey = buildRecordRunKey(record)
            if runKey ~= "" then
                byRunKey[runKey] = record
            end
        end
    end
    for i = 1, #localTop do
        local record = localTop[i]
        if type(record) == "table" then
            local runKey = buildRecordRunKey(record)
            if runKey ~= "" then
                byRunKey[runKey] = record
            end
        end
    end
    output = {}
    for _, record in pairs(byRunKey) do
        output[#output + 1] = record
    end
    sortEntriesByValueThenTime(output)
    return output
end

function LeaderboardService:GetMetricSchema(metricId)
    local provider = self:GetMetricProvider(metricId)
    if type(provider) ~= "table" then
        return nil
    end
    return provider.schema
end

function LeaderboardService:FilterRecordsByMetricType(metricId, records)
    if type(records) ~= "table" or type(metricId) ~= "string" or metricId == "" then
        return records or {}
    end
    local schema = self:GetMetricSchema(metricId)
    if type(schema) ~= "table" then
        return records
    end
    local allowedEventTypes = schema.allowedEventTypes
    if type(allowedEventTypes) ~= "table" then
        return records
    end
    local contextPolicy = tostring(schema.contextPolicy or "strict_event_type")
    local filtered = {}
    for i = 1, #records do
        local record = records[i]
        local context = record and record.context or nil
        local eventType = context and context.eventType or nil
        if type(eventType) == "string" and allowedEventTypes[eventType] then
            filtered[#filtered + 1] = record
        elseif contextPolicy == "allow_sparse" and (eventType == nil or eventType == "") then
            filtered[#filtered + 1] = record
        end
    end
    return filtered
end

--- Resolve display rows for leaderboard viewer in a single canonical path.
--- @param metricId string
--- @param viewMode string "local"|"merged"
--- @param scopeFilter string "all"|"local"|"guild"|"server"|"global"
--- @param classFilter string "all"|"ALL"|class token
--- @param limit number
--- @param currentIdentity table|nil { guid, key, shortName }
--- @return table
function LeaderboardService:GetDisplayRows(metricId, viewMode, scopeFilter, classFilter, limit, currentIdentity)
    if type(metricId) ~= "string" or metricId == "" then
        return {}
    end
    self:PruneUnregisteredMetricData()
    if not self:IsMetricRegistered(metricId) and not self:ShouldExposeUnregisteredMetrics() then
        return {}
    end
    local mode = tostring(viewMode or "local")
    local scope = tostring(scopeFilter or LEADERBOARD_SCOPES.ALL):lower()
    if mode == LEADERBOARD_SCOPES.LOCAL then
        scope = LEADERBOARD_SCOPES.LOCAL
    end

    local rows = nil
    if mode == LEADERBOARD_SCOPES.LOCAL then
        local localTop = self:GetLocalTopN(metricId)
        if type(localTop) == "table" and #localTop > 0 then
            rows = copyRecordList(localTop)
        end
    end

    if not rows then
        if mode == "merged" then
            rows = self:GetCombinedTopX(metricId, limit, scope, classFilter) or {}
            local localTop = self:GetLocalTopN(metricId)
            if type(localTop) == "table" and #localTop > 0 then
                rows = mergeLocalTopNIntoCombined(rows, localTop)
                trimRecordsToLimit(rows, limit, DEFAULT_TOP_LIMIT)
            end
        else
            rows = self:GetTop(metricId, limit, false, scope, classFilter) or {}
        end
        if mode == LEADERBOARD_SCOPES.LOCAL then
            local identity = type(currentIdentity) == "table" and currentIdentity or buildCurrentPlayerIdentity()
            local personalRows = {}
            for i = 1, #rows do
                local record = rows[i]
                if isCurrentPlayerRecord(record, identity) then
                    personalRows[#personalRows + 1] = record
                end
            end
            rows = personalRows
        end
    end

    rows = self:FilterRecordsByMetricType(metricId, rows)
    trimRecordsToLimit(rows, limit, DEFAULT_TOP_LIMIT)
    return rows
end

function LeaderboardService:CollectTopFromCanonicalBuckets(metricId, scopeFilter, classFilter, includeLocal, includeInvalid)
    local byScope = self.db.char.recordsByScopeClassMetric or {}
    local mergedByDisplayKey = {}
    local shouldIncludeInvalid = includeInvalid == true
    for scopeId, classMap in pairs(byScope) do
        if (includeLocal or scopeId ~= LEADERBOARD_SCOPES.LOCAL) and
            doesScopeIncludeRecord(scopeFilter, scopeId) and
            type(classMap) == "table" then
            for className, metricMap in pairs(classMap) do
                if doesClassIncludeRecord(classFilter, className) and type(metricMap) == "table" then
                    local metricBucket = metricMap[metricId]
                    if type(metricBucket) == "table" then
                        for _, record in pairs(metricBucket) do
                            if type(record) == "table" and self:ShouldIncludeRecord(record, shouldIncludeInvalid) then
                                local displayKey = nil
                                if tostring(record.source or "") == "peer_topx_snapshot" then
                                    displayKey = buildRecordRunKey(record)
                                end
                                if displayKey == nil or displayKey == "" then
                                    displayKey = tostring(record.identityKey or
                                        normalizeIdentityKey(record.playerKey, record.playerGUID, record.playerName))
                                end
                                local existing = mergedByDisplayKey[displayKey]
                                if not existing then
                                    mergedByDisplayKey[displayKey] = record
                                else
                                    local existingValue = tonumber(existing.value) or 0
                                    local incomingValue = tonumber(record.value) or 0
                                    local existingTs = tonumber(existing.timestamp) or 0
                                    local incomingTs = tonumber(record.timestamp) or 0
                                    if incomingValue > existingValue or (incomingValue == existingValue and incomingTs < existingTs) then
                                        mergedByDisplayKey[displayKey] = record
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    local out = {}
    for _, record in pairs(mergedByDisplayKey) do
        out[#out + 1] = record
    end
    sortEntriesByValueThenTime(out)
    return out
end

function LeaderboardService:GetTop(metricId, limit, includeInvalid, scope, className)
    local filtered = self:CollectTopFromCanonicalBuckets(
        metricId,
        normalizeScope(scope, true),
        normalizeClassName(className, true),
        true,
        includeInvalid == true
    )
    local maxCount = tonumber(limit) or DEFAULT_TOP_LIMIT
    if maxCount < 1 then
        maxCount = 1
    end
    if #filtered > maxCount then
        for i = #filtered, maxCount + 1, -1 do
            filtered[i] = nil
        end
    end
    return filtered
end

function LeaderboardService:GetRecent(metricId, limit, includeInvalid, scope, className)
    local records = self:GetMetricRecordsTable(metricId, false) or {}
    local filtered = {}
    local shouldIncludeInvalid = includeInvalid == true
    local scopeFilter = normalizeScope(scope, true)
    local classFilter = normalizeClassName(className, true)

    for i = #records, 1, -1 do
        local record = records[i]
        local matchesScope = doesScopeIncludeRecord(scopeFilter, getRecordScope(record))
        local matchesClass = doesClassIncludeRecord(classFilter, record.className)
        if matchesScope and matchesClass and self:ShouldIncludeRecord(record, shouldIncludeInvalid) then
            filtered[#filtered + 1] = record
        end
    end

    local maxCount = tonumber(limit) or DEFAULT_RECENT_LIMIT
    if maxCount < 1 then
        maxCount = 1
    end
    if #filtered > maxCount then
        for i = #filtered, maxCount + 1, -1 do
            filtered[i] = nil
        end
    end
    return filtered
end

function LeaderboardService:GetPersonalBest(metricId, includeInvalid, scope, className)
    local top = self:GetTop(metricId, 1, includeInvalid == true, scope, className)
    return top[1]
end

--- Return local-only BCDL-style top-N crit list from CritHealLeaderboardProvider (for local view).
--- @param metricId string "damage_crit_topX" or "heal_crit_topX"
--- @return table|nil Array of record-shaped entries, or nil
function LeaderboardService:GetLocalCritTopN(metricId)
    return self:GetLocalTopN(metricId)
end

--- Return local top-N list for metrics that maintain one (e.g. seal twist, crit). Used by viewer for Local tab.
--- @param metricId string
--- @return table|nil Array of record-shaped entries (sorted by value desc), or nil
function LeaderboardService:GetLocalTopN(metricId)
    if type(metricId) ~= "string" or metricId == "" then
        return nil
    end
    local provider = self.metricProviders[metricId]
    local capabilities = provider and provider.capabilities or nil
    if capabilities and capabilities.hasLocalTopN and type(capabilities.getLocalTopN) == "function" then
        local ok, records = pcall(capabilities.getLocalTopN, provider, metricId, self)
        if ok and type(records) == "table" then
            return records
        end
    end
    return nil
end

function LeaderboardService:GetMetricBestRecord(metricId, scope, className)
    local best = self:GetPersonalBest(metricId, false, scope, className)
    if not best then
        -- Fallback: provider local top-N (so class-specific metrics sync and show in merged view like crit).
        local localTop = self:GetLocalTopN(metricId)
        if type(localTop) == "table" and #localTop > 0 then
            best = localTop[1]
        end
    end
    if not best then
        return nil
    end
    return copyShallow(best)
end

function LeaderboardService:GetMetricTopX(metricId, limit, scope, className)
    local topLimit = tonumber(limit) or self:GetPeerTopLimit()
    local fromBuckets = self:GetTop(metricId, topLimit, false, scope, className)
    -- Merge in provider local top-N so class-specific metrics (Gargoyle, Twist, Shadow Bolt) sync like crit.
    local localTop = self:GetLocalTopN(metricId)
    if type(localTop) ~= "table" or #localTop == 0 then
        return fromBuckets
    end
    local byRunKey = {}
    for i = 1, #fromBuckets do
        local r = fromBuckets[i]
        if type(r) == "table" then
            local key = buildRecordRunKey(r)
            if key ~= "" then
                byRunKey[key] = r
            end
        end
    end
    for i = 1, #localTop do
        local r = localTop[i]
        if type(r) == "table" then
            local key = buildRecordRunKey(r)
            if key == "" then
                key = tostring(r.identityKey or normalizeIdentityKey(r.playerKey, r.playerGUID, r.playerName))
            end
            local existing = byRunKey[key]
            local rVal = tonumber(r.value) or 0
            local rTs = tonumber(r.timestamp) or 0
            if not existing then
                byRunKey[key] = r
            else
                local exVal = tonumber(existing.value) or 0
                local exTs = tonumber(existing.timestamp) or 0
                if rVal > exVal or (rVal == exVal and rTs < exTs) then
                    byRunKey[key] = r
                end
            end
        end
    end
    local out = {}
    for _, rec in pairs(byRunKey) do
        out[#out + 1] = rec
    end
    sortEntriesByValueThenTime(out)
    if #out > topLimit then
        for i = #out, topLimit + 1, -1 do
            out[i] = nil
        end
    end
    return out
end

function LeaderboardService:MergePeerBest(metricId, peerRecord, scope)
    if type(metricId) ~= "string" or metricId == "" then
        return false, "metricId required"
    end
    if type(peerRecord) ~= "table" then
        return false, "peerRecord must be table"
    end
    local value = tonumber(peerRecord.value)
    if not isFiniteNumber(value) then
        return false, "peerRecord.value must be finite number"
    end
    if not isContextEventTypeValidForMetric(self, metricId, peerRecord.context) then
        return false, "peerRecord.context.eventType invalid for metric"
    end
    local scopeId = normalizeScope(scope, false) or normalizeScope(peerRecord.scope, false) or LEADERBOARD_SCOPES.GUILD
    if not isPeerScope(scopeId) then
        return false, "peer scope must be guild/server/global"
    end
    if peerRecord.className ~= nil and normalizeClassName(peerRecord.className, false) == nil then
        return false, "peerRecord.className is invalid"
    end
    local className = normalizeClassName(peerRecord.className, false) or CLASS_ALL
    local candidateTimestamp = normalizeTimestampToEpoch(peerRecord.timestamp)
    if not isTimestampSane(candidateTimestamp) then
        return false, "peerRecord.timestamp is invalid or too far in the future"
    end
    local playerName = tostring(peerRecord.playerName or peerRecord.playerKey or "Unknown")
    local playerKey = normalizePlayerKey(peerRecord.playerKey or playerName or peerRecord.playerGUID)
    local serverName = sanitizeRealmForStore(tostring(peerRecord.serverName or deriveServerName(playerKey, playerName)))
    local guildName = tostring(peerRecord.guildName or (peerRecord.context and peerRecord.context.guildName) or "")
    local runKey = nil
    if tostring(peerRecord.source or "") == "peer_topx_snapshot" then
        runKey = buildRecordRunKey({
            playerKey = playerKey,
            playerGUID = peerRecord.playerGUID,
            playerName = playerName,
            value = value,
            timestamp = candidateTimestamp,
        })
    end
    local updated = self:UpsertBucketRecord(scopeId, className, metricId, {
        metricId = metricId,
        playerKey = playerKey,
        identityKey = normalizeIdentityKey(playerKey, peerRecord.playerGUID, playerName),
        playerName = playerName,
        playerGUID = tostring(peerRecord.playerGUID or ""),
        serverName = serverName,
        guildName = guildName,
        value = value,
        timestamp = candidateTimestamp,
        scope = scopeId,
        className = className,
        source = tostring(peerRecord.source or "peer"),
        runKey = runKey,
        receivedAt = GetTime(),
        context = type(peerRecord.context) == "table" and copyShallow(peerRecord.context) or nil,
    })
    if not updated then
        return false, nil
    end
    self:TrimPeerMetricBoard(metricId, scopeId)
    self:TouchMetricSnapshotMeta(metricId, className, false)
    return true, nil
end

function LeaderboardService:MergePeerTopX(metricId, peerTopX, scope)
    if type(peerTopX) ~= "table" then
        return false, "peerTopX must be table"
    end
    local mergedAny = false
    for i = 1, #peerTopX do
        local peerRecord = peerTopX[i]
        if type(peerRecord) == "table" and (type(peerRecord.source) ~= "string" or peerRecord.source == "") then
            peerRecord = copyShallow(peerRecord)
            peerRecord.source = "peer_topx_snapshot"
        end
        local ok = self:MergePeerBest(metricId, peerRecord, scope)
        if ok then
            mergedAny = true
        end
    end
    return mergedAny, nil
end

function LeaderboardService:GetPeerTopX(metricId, limit, scope, className)
    local values = self:CollectTopFromCanonicalBuckets(
        metricId,
        normalizeScope(scope, true),
        normalizeClassName(className, true),
        false,
        false
    )
    local maxCount = tonumber(limit) or self:GetPeerTopLimit()
    if maxCount < 1 then
        maxCount = 1
    end
    if #values > maxCount then
        for i = #values, maxCount + 1, -1 do
            values[i] = nil
        end
    end
    return values
end

function LeaderboardService:GetCombinedTopX(metricId, limit, scope, className)
    local merged = self:CollectTopFromCanonicalBuckets(
        metricId,
        normalizeScope(scope, true),
        normalizeClassName(className, true),
        true,
        false
    )
    local maxCount = tonumber(limit) or self:GetPeerTopLimit()
    if #merged > maxCount then
        for i = #merged, maxCount + 1, -1 do
            merged[i] = nil
        end
    end
    return merged
end

function LeaderboardService:GetCanonicalBucketTop(metricId, scope, className, limit, includeInvalid)
    local scopeId = normalizeScope(scope, false)
    local normalizedClass = normalizeClassName(className, false)
    if type(metricId) ~= "string" or metricId == "" or not scopeId or not normalizedClass then
        return {}
    end
    local bucket = self:GetScopeClassMetricBucket(scopeId, normalizedClass, metricId, false)
    if type(bucket) ~= "table" then
        return {}
    end
    local shouldIncludeInvalid = includeInvalid == true
    local out = {}
    for _, record in pairs(bucket) do
        if type(record) == "table" and self:ShouldIncludeRecord(record, shouldIncludeInvalid) then
            out[#out + 1] = record
        end
    end
    sortEntriesByValueThenTime(out)
    local maxCount = tonumber(limit) or self:GetPeerTopLimit()
    if maxCount < 1 then
        maxCount = 1
    end
    if #out > maxCount then
        for i = #out, maxCount + 1, -1 do
            out[i] = nil
        end
    end
    return out
end

-- ============================ SNAPSHOT METADATA ============================

function LeaderboardService:GetMetricSnapshotState()
    self:InitializeStorage()
    return self.db.char.metricSnapshotState
end

local function buildMetricSnapshotStateKey(metricId, className)
    return tostring(metricId or "") .. "|" .. tostring(className or CLASS_ALL)
end

local function buildMetricSnapshotHashPayload(records)
    local chunks = {}
    for i = 1, #(records or {}) do
        local record = records[i]
        local context = type(record and record.context) == "table" and record.context or {}
        chunks[#chunks + 1] = table.concat({
            tostring(record and record.identityKey or ""),
            tostring(record and record.playerKey or ""),
            tostring(tonumber(record and record.value) or 0),
            tostring(tonumber(record and record.timestamp) or 0),
            tostring(record and record.className or CLASS_ALL),
            tostring(context.eventType or ""),
        }, "|")
    end
    return table.concat(chunks, ";")
end

function LeaderboardService:ComputeMetricSnapshotHash(metricId, className, limit)
    if type(metricId) ~= "string" or metricId == "" then
        return ""
    end
    local normalizedClass = normalizeClassName(className, false) or self:GetMetricClassName(metricId) or CLASS_ALL
    local maxCount = tonumber(limit) or self:GetPeerTopLimit()
    if maxCount < 1 then
        maxCount = 1
    end
    local records = self:GetMetricTopX(metricId, maxCount, nil, normalizedClass) or {}
    if type(records) ~= "table" or #records == 0 then
        return ""
    end
    return ns.computeHash(buildMetricSnapshotHashPayload(records))
end

function LeaderboardService:TouchMetricSnapshotMeta(metricId, className, forceVersionBump)
    if type(metricId) ~= "string" or metricId == "" then
        return
    end
    local normalizedClass = normalizeClassName(className, false) or self:GetMetricClassName(metricId) or CLASS_ALL
    local snapshotState = self:GetMetricSnapshotState()
    local stateKey = buildMetricSnapshotStateKey(metricId, normalizedClass)
    local previousVersion = tonumber(snapshotState.byMetricVersion[stateKey]) or 0
    local previousHash = tostring(snapshotState.byMetricHash[stateKey] or "")
    local nextHash = self:ComputeMetricSnapshotHash(metricId, normalizedClass, self:GetPeerTopLimit())
    local shouldBump = forceVersionBump == true or nextHash ~= previousHash
    if not shouldBump and previousVersion == 0 and nextHash ~= "" then
        shouldBump = true
    end
    if shouldBump then
        snapshotState.byMetricVersion[stateKey] = previousVersion + 1
        snapshotState.byMetricHash[stateKey] = nextHash
        snapshotState.byMetricAppliedAt[stateKey] = GetTime()
    end
end

function LeaderboardService:GetMetricSnapshotMeta(metricId, className)
    if type(metricId) ~= "string" or metricId == "" then
        return nil
    end
    local normalizedClass = normalizeClassName(className, false) or self:GetMetricClassName(metricId) or CLASS_ALL
    local snapshotState = self:GetMetricSnapshotState()
    local stateKey = buildMetricSnapshotStateKey(metricId, normalizedClass)
    local top = self:GetMetricTopX(metricId, 1, nil, normalizedClass) or {}
    local best = top[1]
    local bestValue = tonumber(best and best.value) or 0
    local bestTimestamp = tonumber(best and best.timestamp) or 0
    local snapshotHash = tostring(snapshotState.byMetricHash[stateKey] or "")
    if snapshotHash == "" then
        snapshotHash = self:ComputeMetricSnapshotHash(metricId, normalizedClass, self:GetPeerTopLimit())
    end
    return {
        metricId = metricId,
        className = normalizedClass,
        version = tonumber(snapshotState.byMetricVersion[stateKey]) or 0,
        snapshotHash = snapshotHash,
        appliedAt = tonumber(snapshotState.byMetricAppliedAt[stateKey]) or 0,
        bestValue = bestValue,
        bestTimestamp = bestTimestamp,
    }
end

-- ============================ EXPORT QUEUE ============================

function LeaderboardService:GetExportQueue()
    self:InitializeStorage()
    return self.db.char.exportQueue
end

function LeaderboardService:GetHelperGlobalState()
    self:InitializeStorage()
    return self.db.char.helperGlobalState
end

local function buildHelperMetricStateKey(metricId, className)
    return tostring(metricId or "") .. "|" .. tostring(className or CLASS_ALL)
end

function LeaderboardService:GetHelperGlobalSnapshotMeta(metricId, className)
    if type(metricId) ~= "string" or metricId == "" then
        return nil
    end
    local normalizedClass = normalizeClassName(className, false) or CLASS_ALL
    local helperState = self:GetHelperGlobalState()
    local stateKey = buildHelperMetricStateKey(metricId, normalizedClass)
    return {
        metricId = metricId,
        className = normalizedClass,
        version = tonumber(helperState.byMetricVersion[stateKey]) or 0,
        snapshotHash = tostring(helperState.byMetricHash[stateKey] or ""),
        appliedAt = tonumber(helperState.byMetricAppliedAt[stateKey]) or 0,
    }
end

--- Apply helper-authored global snapshot for one metric/class bucket.
--- @param metricId string
--- @param className string|nil
--- @param records table
--- @param snapshotMeta table|nil
--- @return boolean
--- @return string|nil
function LeaderboardService:ApplyHelperGlobalSnapshot(metricId, className, records, snapshotMeta)
    if type(metricId) ~= "string" or metricId == "" then
        return false, "metricId is required"
    end
    if type(records) ~= "table" then
        return false, "records must be table"
    end

    local normalizedClass = normalizeClassName(className, false) or self:GetMetricClassName(metricId) or CLASS_ALL
    local metadata = type(snapshotMeta) == "table" and snapshotMeta or {}
    local incomingVersion = tonumber(metadata.version) or 0
    local incomingHash = tostring(metadata.snapshotHash or "")

    local helperState = self:GetHelperGlobalState()
    local stateKey = buildHelperMetricStateKey(metricId, normalizedClass)
    local previousVersion = tonumber(helperState.byMetricVersion[stateKey]) or 0
    local previousHash = tostring(helperState.byMetricHash[stateKey] or "")
    if incomingVersion < previousVersion then
        return false, "stale helper snapshot version"
    end
    if incomingVersion == previousVersion and incomingHash ~= "" and incomingHash == previousHash then
        return false, "unchanged helper snapshot"
    end

    local bestByIdentity = {}
    for i = 1, #records do
        local incoming = records[i]
        if type(incoming) == "table" then
            local value = tonumber(incoming.value)
            local timestamp = normalizeTimestampToEpoch(incoming.timestamp)
            if isFiniteNumber(value) and isTimestampSane(timestamp) then
                local recordClass = normalizeClassName(incoming.className, false) or normalizedClass
                if recordClass == normalizedClass and isContextEventTypeValidForMetric(self, metricId, incoming.context) then
                    local playerName = tostring(incoming.playerName or incoming.playerKey or "Unknown")
                    local playerKey = normalizePlayerKey(incoming.playerKey or playerName or incoming.playerGUID)
                    local identityKey = normalizeIdentityKey(playerKey, incoming.playerGUID, playerName)
                    local incomingServerName = tostring(incoming.serverName or deriveServerName(playerKey, playerName))
                    local candidate = {
                        metricId = metricId,
                        playerKey = playerKey,
                        identityKey = identityKey,
                        playerName = playerName,
                        playerGUID = tostring(incoming.playerGUID or ""),
                        serverName = sanitizeRealmForStore(incomingServerName),
                        guildName = tostring(incoming.guildName or (incoming.context and incoming.context.guildName) or ""),
                        value = value,
                        timestamp = timestamp,
                        scope = LEADERBOARD_SCOPES.GLOBAL,
                        className = recordClass,
                        source = "helper_global_snapshot",
                        sourceModule = "helper_global_snapshot",
                        receivedAt = GetTime(),
                        context = type(incoming.context) == "table" and copyShallow(incoming.context) or nil,
                    }
                    local existing = bestByIdentity[identityKey]
                    if not existing then
                        bestByIdentity[identityKey] = candidate
                    else
                        local existingValue = tonumber(existing.value) or 0
                        local existingTimestamp = tonumber(existing.timestamp) or 0
                        if value > existingValue or (value == existingValue and timestamp < existingTimestamp) then
                            bestByIdentity[identityKey] = candidate
                        end
                    end
                end
            end
        end
    end

    local bucket = self:GetScopeClassMetricBucket(LEADERBOARD_SCOPES.GLOBAL, normalizedClass, metricId, true)
    if type(bucket) ~= "table" then
        return false, "global bucket unavailable"
    end
    wipe(bucket)
    for _, candidate in pairs(bestByIdentity) do
        self:UpsertBucketRecord(LEADERBOARD_SCOPES.GLOBAL, normalizedClass, metricId, candidate)
    end
    self:TrimPeerMetricBoard(metricId, LEADERBOARD_SCOPES.GLOBAL)
    self:TouchMetricSnapshotMeta(metricId, normalizedClass, true)

    local now = GetTime()
    helperState.byMetricVersion[stateKey] = max(incomingVersion, previousVersion)
    helperState.byMetricHash[stateKey] = incomingHash
    helperState.byMetricAppliedAt[stateKey] = now
    helperState.latestVersion = max(tonumber(helperState.latestVersion) or 0, helperState.byMetricVersion[stateKey] or 0)
    if incomingHash ~= "" then
        helperState.latestHash = incomingHash
    end
    helperState.latestAppliedAt = now
    return true, nil
end

function LeaderboardService:TrimExportQueue()
    local queue = self:GetExportQueue()
    local items = queue.items
    local maxItems = tonumber(self.db.global.exportQueueMax) or 20
    maxItems = max(1, maxItems)
    while #items > maxItems do
        tremove(items, 1)
    end
end

function LeaderboardService:BuildExportPayload(metricId, recentLimit)
    local provider = self.metricProviders[metricId]
    local records = self:GetRecent(metricId, recentLimit or 100, false)
    local payload = {
        formatVersion = EXPORT_FORMAT_VERSION,
        schemaVersion = self.db.global.schemaVersion or SCHEMA_VERSION,
        metricId = metricId,
        metricName = provider and provider.name or metricId,
        generatedAt = GetTime(),
        expansionTag = provider and provider.expansionTag or (Version and Version:GetExpansion() or "unknown"),
        playerGUID = NAG and NAG.state and NAG.state.player and NAG.state.player.guid or "unknown",
        records = records,
    }
    return payload
end

function LeaderboardService:QueueMetricExport(metricId, recentLimit)
    if type(metricId) ~= "string" or metricId == "" then
        return nil, "metricId is required"
    end

    local payload = self:BuildExportPayload(metricId, recentLimit)
    local serialized = json and json.Serialize and json.Serialize(payload) or nil
    if type(serialized) ~= "string" or serialized == "" then
        return nil, "failed to serialize export payload"
    end

    local dataToEncode = serialized
    local compression = "raw"
    if LibCompress and LibCompress.CompressLZW then
        local compressed = LibCompress:CompressLZW(serialized)
        if type(compressed) == "string" and compressed ~= "" then
            dataToEncode = compressed
            compression = "lzw"
        end
    end

    local encoded = LibBase64 and LibBase64.encode and LibBase64:encode(dataToEncode) or nil
    if type(encoded) ~= "string" or encoded == "" then
        return nil, "failed to encode export payload"
    end

    local queue = self:GetExportQueue()
    local item = {
        id = queue.nextId or 1,
        metricId = metricId,
        createdAt = GetTime(),
        compression = compression,
        payload = encoded,
        payloadHash = ns.computeHash(serialized),
        recordCount = #payload.records,
    }
    queue.nextId = item.id + 1
    tinsert(queue.items, item)
    self:TrimExportQueue()
    return item, nil
end

--- Reset leaderboard data only (dedicated leaderboard DB namespace).
--- @return boolean success
--- @return string|nil errorMessage
function LeaderboardService:ResetLeaderboardData()
    if not self.db or type(self.db.char) ~= "table" then
        return false, "leaderboard database unavailable"
    end

    self.db.char.metricRecords = {}
    self.db.char.metricMeta = {}
    self.db.char.recordsByScopeClassMetric = {}
    self.db.char.displayMigrationVersion = 0
    self.db.char.bucketSchemaVersion = 0
    self.db.char.exportQueue = {
        nextId = 1,
        items = {},
    }
    self.db.char.helperGlobalState = {
        latestVersion = 0,
        latestHash = "",
        latestAppliedAt = 0,
        byMetricVersion = {},
        byMetricHash = {},
        byMetricAppliedAt = {},
    }
    self.db.char.metricSnapshotState = {
        byMetricVersion = {},
        byMetricHash = {},
        byMetricAppliedAt = {},
    }

    self.selectedMetricId = ""
    self.runtimeStats.submitCount = 0
    self.runtimeStats.rejectedCount = 0
    self.runtimeStats.lastSubmitAt = 0

    if NAG and NAG.SendMessage then
        NAG:SendMessage("NAG_LEADERBOARD_RESET")
    end
    return true, nil
end

function LeaderboardService:PopNextExportItem()
    local queue = self:GetExportQueue()
    if #queue.items == 0 then
        return nil
    end
    return tremove(queue.items, 1)
end

-- ============================ UI HELPERS ============================

function LeaderboardService:BuildSummaryText(metricId)
    if type(metricId) ~= "string" or metricId == "" then
        return L["No metric selected."] or "No metric selected."
    end
    local meta = self:GetMetricMetaTable(metricId, true)
    local top = self:GetPersonalBest(metricId, false, self.selectedScope)
    local topValue = top and tostring(top.value) or "n/a"
    local scopeDisplayMap = self:GetScopeValuesMap()
    local scopeLabel = scopeDisplayMap[self.selectedScope] or scopeDisplayMap[LEADERBOARD_SCOPES.ALL] or "All"
    return string.format(
        L["Metric: %s\nScope: %s\nRecords: %d (valid: %d, invalid: %d)\nPersonal Best: %s"] or "Metric: %s\nScope: %s\nRecords: %d (valid: %d, invalid: %d)\nPersonal Best: %s",
        self:GetMetricDisplayName(metricId),
        scopeLabel,
        meta.totalRecords or 0,
        meta.validRecords or 0,
        meta.invalidRecords or 0,
        topValue
    )
end

function LeaderboardService:BuildTopText(metricId)
    local top = self:GetTop(metricId, 5, self.db.global.includeInvalidInDebugViews == true, self.selectedScope)
    if #top == 0 then
        return L["No records."] or "No records."
    end

    local lines = {}
    local fmt = L["%d) %.2f @ %.2f (%s)"] or "%d) %.2f @ %.2f (%s)"
    for i = 1, #top do
        local record = top[i]
        lines[#lines + 1] = string.format(
            fmt,
            i,
            tonumber(record.value) or 0,
            tonumber(record.timestamp) or 0,
            tostring(record.integrityState or "unknown")
        )
    end
    return table.concat(lines, "\n")
end

function LeaderboardService:GetScopeValuesMap()
    return {
        [LEADERBOARD_SCOPES.ALL] = L["All"] or "All",
        [LEADERBOARD_SCOPES.LOCAL] = L["Local"] or "Local",
        [LEADERBOARD_SCOPES.GUILD] = L["Guild"] or "Guild",
        [LEADERBOARD_SCOPES.SERVER] = L["Server"] or "Server",
        [LEADERBOARD_SCOPES.GLOBAL] = L["Global"] or "Global",
    }
end

function LeaderboardService:GetOptions()
    local function hideDeveloperOptions()
        return not (NAG and NAG.IsDevModeEnabled and NAG:IsDevModeEnabled())
    end
    return {
        type = "group",
        name = L["Leaderboard"] or "Leaderboard",
        order = 60,
        args = {
            enabled = {
                type = "toggle",
                name = L["Enable Leaderboard Tracking"] or "Enable Leaderboard Tracking",
                order = 1,
                get = function() return self.db.global.enabled == true end,
                set = function(_, value) self.db.global.enabled = value == true end,
            },
            maxRecordsPerMetric = {
                type = "range",
                name = L["Max records per metric"] or "Max records per metric",
                order = 2,
                hidden = hideDeveloperOptions,
                min = 50,
                max = 1000,
                step = 10,
                get = function() return tonumber(self.db.global.maxRecordsPerMetric) or 250 end,
                set = function(_, value)
                    self.db.global.maxRecordsPerMetric = value
                    for metricId in pairs(self.db.char.metricRecords or {}) do
                        self:TrimMetricRecords(metricId)
                        self:RebuildMetricChain(metricId)
                    end
                end,
            },
            exportQueueMax = {
                type = "range",
                name = L["Export queue size"] or "Export queue size",
                order = 3,
                hidden = hideDeveloperOptions,
                min = 5,
                max = 100,
                step = 1,
                get = function() return tonumber(self.db.global.exportQueueMax) or 20 end,
                set = function(_, value)
                    self.db.global.exportQueueMax = value
                    self:TrimExportQueue()
                end,
            },
            peerTopXLimit = {
                type = "range",
                name = L["Peer top-X limit"] or "Peer top-X limit",
                order = 4,
                hidden = hideDeveloperOptions,
                min = 1,
                max = 25,
                step = 1,
                get = function() return self:GetPeerTopLimit() end,
                set = function(_, value)
                    self.db.global.peerTopXLimit = value
                    for metricId in pairs(self.db.char.metricRecords or {}) do
                        self:TrimPeerMetricBoard(metricId)
                    end
                end,
            },
            selectedMetricId = {
                type = "select",
                name = L["Metric"] or "Metric",
                order = 10,
                hidden = hideDeveloperOptions,
                values = function() return self:GetMetricValuesMap() end,
                get = function()
                    if self.selectedMetricId == "" then
                        self.selectedMetricId = self:GetFirstMetricId() or ""
                    end
                    return self.selectedMetricId
                end,
                set = function(_, value)
                    self.selectedMetricId = tostring(value or "")
                end,
            },
            selectedScope = {
                type = "select",
                name = L["Scope"] or "Scope",
                order = 10.5,
                hidden = hideDeveloperOptions,
                values = function() return self:GetScopeValuesMap() end,
                get = function()
                    self.selectedScope = normalizeScope(self.selectedScope, true) or DEFAULT_SCOPE_FILTER
                    return self.selectedScope
                end,
                set = function(_, value)
                    self.selectedScope = normalizeScope(value, true) or DEFAULT_SCOPE_FILTER
                end,
            },
            summary = {
                type = "description",
                name = function() return self:BuildSummaryText(self.selectedMetricId) end,
                order = 11,
                hidden = hideDeveloperOptions,
                fontSize = "medium",
            },
            topList = {
                type = "description",
                name = function() return self:BuildTopText(self.selectedMetricId) end,
                order = 12,
                hidden = hideDeveloperOptions,
                fontSize = "medium",
            },
            queueExport = {
                type = "execute",
                name = L["Queue Export Payload"] or "Queue Export Payload",
                order = 13,
                hidden = hideDeveloperOptions,
                func = function()
                    if self.selectedMetricId and self.selectedMetricId ~= "" then
                        local item, err = self:QueueMetricExport(self.selectedMetricId, 200)
                        if item then
                            self:Info(L["Queued leaderboard export item #%d for metric %s (%d records)"] or "Queued leaderboard export item #%d for metric %s (%d records)",
                                item.id, self.selectedMetricId, item.recordCount or 0)
                        else
                            self:Warn(L["Queue export failed: %s"] or "Queue export failed: %s", tostring(err))
                        end
                    end
                end,
            },
            queueStatus = {
                type = "description",
                hidden = hideDeveloperOptions,
                name = function()
                    local queue = self:GetExportQueue()
                    return string.format(L["Export queue items: %d"] or "Export queue items: %d", #queue.items)
                end,
                order = 14,
            },
            runtimeStats = {
                type = "description",
                hidden = hideDeveloperOptions,
                name = function()
                    local stats = self:GetRuntimeStats()
                    return string.format(
                        L["Runtime stats - submitted: %d, rejected: %d, last submit at: %.2f"] or "Runtime stats - submitted: %d, rejected: %d, last submit at: %.2f",
                        stats.submitCount,
                        stats.rejectedCount,
                        stats.lastSubmitAt
                    )
                end,
                order = 15,
            },
            peerTop = {
                type = "description",
                hidden = hideDeveloperOptions,
                name = function()
                    local metricId = self.selectedMetricId
                    if not metricId or metricId == "" then
                        return L["Peer top: no metric selected."] or "Peer top: no metric selected."
                    end
                    local peerTop = self:GetPeerTopX(metricId, 5, self.selectedScope)
                    if #peerTop == 0 then
                        return L["Peer top: no synced entries."] or "Peer top: no synced entries."
                    end
                    local lines = {}
                    local lineFmt = L["%d) %s - %.2f"] or "%d) %s - %.2f"
                    for i = 1, #peerTop do
                        local record = peerTop[i]
                        lines[#lines + 1] = string.format(lineFmt, i,
                            tostring(record.playerName or record.playerKey or "Unknown"), tonumber(record.value) or 0)
                    end
                    return (L["Peer top (synced):\n"] or "Peer top (synced):\n") .. table.concat(lines, "\n")
                end,
                order = 16,
            },
        }
    }
end

-- ============================ LIFECYCLE ============================

function LeaderboardService:RegisterGlobalAPI()
    NAG.RegisterLeaderboardMetric = function(_, provider)
        return LeaderboardService:RegisterMetricProvider(provider)
    end
    NAG.UnregisterLeaderboardMetric = function(_, metricId)
        LeaderboardService:UnregisterMetricProvider(metricId)
    end
    NAG.SubmitLeaderboardRecord = function(_, record)
        return LeaderboardService:SubmitMetricRecord(record)
    end
    NAG.GetLeaderboardTop = function(_, metricId, limit, includeInvalid, scope, className)
        return LeaderboardService:GetTop(metricId, limit, includeInvalid, scope, className)
    end
    NAG.QueueLeaderboardExport = function(_, metricId, recentLimit)
        return LeaderboardService:QueueMetricExport(metricId, recentLimit)
    end
end

function LeaderboardService:UnregisterGlobalAPI()
    if NAG.RegisterLeaderboardMetric then NAG.RegisterLeaderboardMetric = nil end
    if NAG.UnregisterLeaderboardMetric then NAG.UnregisterLeaderboardMetric = nil end
    if NAG.SubmitLeaderboardRecord then NAG.SubmitLeaderboardRecord = nil end
    if NAG.GetLeaderboardTop then NAG.GetLeaderboardTop = nil end
    if NAG.QueueLeaderboardExport then NAG.QueueLeaderboardExport = nil end
end

function LeaderboardService:ModuleInitialize()
    self:InitializeStorage()
    self.runtimeStats.submitCount = 0
    self.runtimeStats.rejectedCount = 0
    self.runtimeStats.lastSubmitAt = 0
end

function LeaderboardService:ModuleEnable()
    self:InitializeStorage()
    self:RunDisplayMigrations()
    self:RunBucketSchemaMigrations()
    self:SanitizeCritMetricBuckets()
    self:ValidateAllMetricChains()
    self:RegisterGlobalAPI()
end

function LeaderboardService:ModuleDisable()
    self:UnregisterGlobalAPI()
    wipe(self.metricProviders)
end

return LeaderboardService
