local _, ns = ...
local GetTime = _G.GetTime
local L = ns.AceLocale:GetLocale("NAG")
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ HEADER LOCALS ============================
local WoWAPI = ns.WoWAPI
local UnitExists = _G.UnitExists
local UnitPower = _G.UnitPower
local UnitPowerMax = _G.UnitPowerMax
local UnitName = _G.UnitName
local UnitSpellHaste = _G.UnitSpellHaste
local UnitAffectingCombat = _G.UnitAffectingCombat
local UnitPowerType = _G.UnitPowerType
local IsInInstance = _G.IsInInstance
local GetBuildInfo = _G.GetBuildInfo
local UnitAura = _G.UnitAura
local UnitBuff = _G.UnitBuff
local UnitDebuff = _G.UnitDebuff

-- Lua APIs (WoW optimized where available)
local format = string.format
local min = math.min
local max = math.max
local abs = math.abs
local sqrt = sqrt or math.sqrt
local date = date
local type = type
local pairs = pairs
local ipairs = ipairs
local next = next
local string = string
local tonumber = tonumber
local tostring = tostring
local strmatch = string.match
local strlower = string.lower
local strupper = string.upper
local gsub = string.gsub
local wipe = wipe

local BLOODLUST_IDS = {
    2825,   -- Bloodlust
    32182,  -- Heroism
    80353,  -- Time Warp
    90355,  -- Ancient Hysteria
    160452, -- Netherwinds
    178207, -- Drums of Fury
    264667, -- Primal Rage
}

local LOCK_AND_LOAD_ID = 56343
local DEFAULT_BUCKET_SETTINGS = {
    minSamplesForOutlier = 5,
    stdDevThreshold = 2.5,
    minSamplesForExport = 3,
}

local DEFAULT_CONTEXT_FLAGS = {
    bloodlust = {
        auras = BLOODLUST_IDS,
        label = "Bloodlust/Heroism",
    },
    lockAndLoad = {
        auras = {LOCK_AND_LOAD_ID},
        label = "Lock and Load",
    },
}

local function HasPlayerAura(spellId)
    if not spellId then return false end
    local auraData
    local unitAuras = rawget(WoWAPI, "C_UnitAuras") or _G.C_UnitAuras
    if unitAuras and unitAuras.GetPlayerAuraBySpellID then
        auraData = unitAuras.GetPlayerAuraBySpellID(spellId)
    end

    if auraData then return true end

    -- Fallback: try UnitAura scanning if registry function unavailable
    if UnitAura then
        local index = 1
        while true do
            local name, _, _, _, _, _, _, _, _, spell = UnitAura("player", index)
            if not name then break end
            if spell == spellId then
                return true
            end
            index = index + 1
        end
    end
    return false
end

local function HasAnyPlayerAura(spellIds)
    if not spellIds then return false end
    for _, auraId in ipairs(spellIds) do
        if HasPlayerAura(auraId) then
            return true
        end
    end
    return false
end

local function copyTableShallow(source)
    if not source then return {} end
    local result = {}
    for k, v in pairs(source) do
        result[k] = v
    end
    return result
end

local function trimWhitespace(text)
    if not text then
        return ""
    end
    return (gsub(text, "^%s*(.-)%s*$", "%1"))
end

local function resolveResourceValue(resourceData)
    if resourceData == nil then
        return nil
    end
    local kind = type(resourceData)
    if kind == "number" then
        return resourceData
    elseif kind ~= "table" then
        return nil
    end

    return resourceData.actual
        or resourceData.amount
        or resourceData.value
        or resourceData.average
        or resourceData.min
        or resourceData.max
        or resourceData.total
end

local function ensureStatRecord(stat)
    if stat then return stat end
    return {
        count = 0,
        mean = 0,
        m2 = 0,
        min = nil,
        max = nil,
    }
end

local function updateRunningStat(stat, value)
    if value == nil then
        return stat
    end
    stat = ensureStatRecord(stat)
    local count = stat.count + 1
    local delta = value - stat.mean
    local mean = stat.mean + (delta / count)
    local delta2 = value - mean
    stat.m2 = (stat.m2 or 0) + delta * delta2
    stat.mean = mean
    stat.count = count
    if not stat.min or value < stat.min then
        stat.min = value
    end
    if not stat.max or value > stat.max then
        stat.max = value
    end
    return stat
end

local function getStdDevFromStat(stat)
    if not stat or stat.count < 2 or not stat.m2 then
        return 0
    end
    return sqrt(stat.m2 / (stat.count - 1))
end

local function isOutlierValue(stat, value, settings)
    if value == nil then
        return false
    end
    stat = stat or { count = 0 }
    local minSamples = (settings and settings.minSamplesForOutlier) or 5
    if stat.count < minSamples then
        return false
    end
    local stdDev = getStdDevFromStat(stat)
    if stdDev == 0 then
        return false
    end
    local threshold = (settings and settings.stdDevThreshold) or 3
    return abs(value - stat.mean) > (threshold * stdDev)
end

local function determineTargetBand(targetCount)
    if not targetCount or targetCount <= 1 then
        return "st"
    elseif targetCount == 2 then
        return "2"
    elseif targetCount == 3 then
        return "3"
    elseif targetCount == 4 then
        return "4"
    end
    return "5plus"
end

local function determineHasteBand(hastePercent)
    if not hastePercent or hastePercent <= 0 then
        return "low"
    elseif hastePercent >= 25 then
        return "veryhigh"
    elseif hastePercent >= 18 then
        return "high"
    elseif hastePercent >= 10 then
        return "medium"
    end
    return "low"
end

local function summarizeStat(stat)
    if not stat or not stat.count or stat.count == 0 then
        return nil
    end
    return {
        mean = stat.mean,
        min = stat.min,
        max = stat.max,
        count = stat.count,
    }
end

local function summarizeStatTable(statTable, valueFormatter)
    if not statTable then
        return {}
    end
    local entries = {}
    for key, stat in pairs(statTable) do
        local summary = summarizeStat(stat)
        if summary then
            local formatted = valueFormatter and valueFormatter(key, summary) or format("%s=%.2f (n=%d)", tostring(key), summary.mean, summary.count)
            entries[#entries + 1] = formatted
        end
    end
    table.sort(entries)
    return entries
end

local function formatTelemetryValue(value)
    if value == nil then
        return "nil"
    end
    local valueType = type(value)
    if valueType == "number" then
        return format("%.2f", value)
    elseif valueType == "table" then
        local pieces = {}
        for key, amount in pairs(value) do
            pieces[#pieces + 1] = format("%s=%s", tostring(key), formatTelemetryValue(amount))
        end
        table.sort(pieces)
        return table.concat(pieces, ", ")
    end
    return tostring(value)
end

--- @class LearnedPredictionProvider : CoreModule
local LearnedPredictionProvider = NAG:CreateModule("LearnedPredictionProvider", {
    char = {
        enabled = false,
        useLearnedCosts = true,
        useLearnedCooldowns = true,
        useLearnedAuras = false,
        useLearnedGeneration = true,
        minConfidence = 0.5,
        freshnessSeconds = 1800, -- 30 minutes
        -- Validation settings
        enableValidation = true,
        validationWindow = 2.0, -- Seconds after cast to validate predictions
        autoAdjustConfidence = true,
        accuracyThreshold = 0.8, -- Minimum accuracy to maintain confidence
        -- Caching settings
        enableCache = true,
        cacheTTL = 5.0, -- Cache time-to-live in seconds
        -- Context-aware settings
        useContextAware = true, -- Use context-aware predictions when available
        -- Bucketed metrics & hygiene
        bucketSettings = {
            minSamplesForOutlier = 5,
            stdDevThreshold = 2.5,
            minSamplesForExport = 3,
        },
        bucketedData = {}, -- [spellId] = {[bucketKey] = bucketStats}
        warmStartVersion = 0,
        manualOverrides = {
            cost = {},
            generation = {},
        },
        lastClientBuild = nil,
    }
}, {
    moduleType = ns.MODULE_TYPES.SERVICE,
    optionsCategory = ns.MODULE_CATEGORIES.DEBUG,
    optionsComposers = {
        ["features"] = "composePredictionQueueOptions"
    },
    debugCategories = {ns.DEBUG_CATEGORIES.FEATURES},
    eventHandlers = {
        UNIT_SPELLCAST_SUCCEEDED = true,
    },
    messageHandlers = {
        NAG_SPELL_LEARNED = true,
    },
    slashCommands = {
        ["lpp_stats"] = {
            handler = "PrintUsageStats",
            help = "Show learned prediction usage statistics",
            root = "nag",
            path = {"learned", "stats"},
            category = "Data"
        },
        ["lpp_accuracy"] = {
            handler = "PrintAccuracyStats",
            help = "Show prediction accuracy statistics",
            root = "nag",
            path = {"learned", "accuracy"},
            category = "Data"
        },
        ["lpp_datainfo"] = {
            handler = "PrintDataInfo",
            help = "Show stored data statistics (buckets, age, size)",
            root = "nag",
            path = {"learned", "datainfo"},
            category = "Data"
        },
        ["lpp_prune"] = {
            handler = "PruneStaleDataCommand",
            help = "Prune old/low-sample data (reduces WTF size)",
            root = "nag",
            path = {"learned", "prune"},
            category = "Data"
        },
        ["lpp_clear"] = {
            handler = "ClearAllDataCommand",
            help = "Clear ALL learned prediction data",
            root = "nag",
            path = {"learned", "clear"},
            category = "Data"
        }
    },
})
ns.LearnedPredictionProvider = LearnedPredictionProvider

local OptionsFactory
local PredictionAPI
local StateManager
local TTDManager
local SpellbookManager

function LearnedPredictionProvider:ModuleInitialize()
    OptionsFactory = NAG:GetModule("OptionsFactory")
    PredictionAPI = NAG:GetModule("PredictionAPI")
    StateManager = NAG:GetModule("StateManager")
    TTDManager = NAG:GetModule("TTDManager")
    SpellbookManager = NAG:GetModule("SpellbookManager")

    -- Prediction cache with TTL
    -- [spellId] = {[predictionType] = {value, timestamp, resourceType}}
    self.cache = {
        cost = {},        -- [spellId] = {value, timestamp}
        cooldown = {},    -- [spellId] = {value, timestamp}
        generation = {},  -- [spellId] = {[resourceType] = {value, timestamp}}
        applies = {},     -- [spellId] = {ids, timestamp}
        debuffs = {},     -- [spellId] = {ids, timestamp}
    }

    -- Cache statistics
    self.cacheStats = {
        hits = 0,
        misses = 0,
        evictions = 0,
    }

    -- Debug tracking for learned data usage
    self.usageStats = {
        costs = {},       -- [spellId] = count
        cooldowns = {},   -- [spellId] = count
        generation = {}, -- [spellId] = count
    }

    -- Prediction validation tracking
    -- [spellId] = {[predictionType] = {predicted, timestamp, resourceType}}
    self.pendingValidations = {}

    -- Latest spell delta data for validation
    -- [spellId] = {cost = {...}, generates = {...}, timestamp}
    self.latestSpellDeltas = {}

    -- Accuracy statistics
    -- [spellId] = {[predictionType] = {total, correct, accuracy, avgError}}
    if not self.db.char.accuracyStats then
        self.db.char.accuracyStats = {}
    end

    if not self.db.char.bucketSettings then
        self.db.char.bucketSettings = copyTableShallow(DEFAULT_BUCKET_SETTINGS)
    else
        for key, value in pairs(DEFAULT_BUCKET_SETTINGS) do
            if self.db.char.bucketSettings[key] == nil then
                self.db.char.bucketSettings[key] = value
            end
        end
    end

    if not self.db.char.bucketedData then
        self.db.char.bucketedData = {}
    end

    if not self.db.char.manualOverrides then
        self.db.char.manualOverrides = { cost = {}, generation = {} }
    else
        self.db.char.manualOverrides.cost = self.db.char.manualOverrides.cost or {}
        self.db.char.manualOverrides.generation = self.db.char.manualOverrides.generation or {}
    end

    if not self.db.char.patchSensitiveSpells then
        self.db.char.patchSensitiveSpells = {}
    end

    if not self.db.char.patchResetLog then
        self.db.char.patchResetLog = {}
    end

    -- Session counter for automatic pruning
    if not self.db.char.sessionCount then
        self.db.char.sessionCount = 0
    end

    -- Auto-prune settings
    if self.db.char.autoPruneEveryNSessions == nil then
        self.db.char.autoPruneEveryNSessions = 10
    end

    if self.db.char.lastPatchResetTime == nil then
        self.db.char.lastPatchResetTime = 0
    end

    if not self.db.char.lastPatchResetScope then
        self.db.char.lastPatchResetScope = "none"
    end

    -- Context flag registry (deterministic iteration order)
    self.contextFlags = {}
    self.contextFlagOrder = {}
    for flagKey, config in pairs(DEFAULT_CONTEXT_FLAGS) do
        self:RegisterContextFlag(flagKey, config, true)
    end

    self:CheckClientBuild()

    -- Session tracking and auto-prune
    self:IncrementSessionAndMaybePrune()

end

--- Increment session counter and auto-prune if needed
function LearnedPredictionProvider:IncrementSessionAndMaybePrune()
    self.db.char.sessionCount = (self.db.char.sessionCount or 0) + 1
    local sessionCount = self.db.char.sessionCount
    local pruneEvery = self.db.char.autoPruneEveryNSessions or 10

    if pruneEvery > 0 and sessionCount % pruneEvery == 0 then
        local beforeStats = self:GetDataStatistics()
        local pruned = self:PruneStaleData(30, 3)

        if pruned > 0 then
            self:Info("🧹 Auto-pruned %d stale buckets (session %d). Before: %d buckets, After: %d buckets",
                pruned, sessionCount, beforeStats.totalBuckets, beforeStats.totalBuckets - pruned)
        end
    end
end

-- ============================ CONTEXT FLAG REGISTRY ============================

--- Register a context flag that influences bucket selection
--- @param flagKey string Unique key (used in bucket hashes)
--- @param config table {label, auras, evaluator}
--- @param silent boolean|nil Suppress debug output when true
function LearnedPredictionProvider:RegisterContextFlag(flagKey, config, silent)
    if not flagKey or flagKey == "" then
        return false, "Context flag key required"
    end
    config = config or {}
    config.label = config.label or flagKey
    self.contextFlags = self.contextFlags or {}
    self.contextFlagOrder = self.contextFlagOrder or {}

    local wasRegistered = self.contextFlags[flagKey] ~= nil
    self.contextFlags[flagKey] = config

    if not wasRegistered then
        table.insert(self.contextFlagOrder, flagKey)
    end

    if self.debug and not silent then
        self:Debug("➕ Registered context flag '%s'%s", flagKey, config.label and (" (" .. config.label .. ")") or "")
    end
    return true
end

--- Unregister a context flag
--- @param flagKey string Unique key to remove
function LearnedPredictionProvider:UnregisterContextFlag(flagKey)
    if not flagKey or not self.contextFlags then
        return false
    end
    if not self.contextFlags[flagKey] then
        return false
    end
    self.contextFlags[flagKey] = nil

    if self.contextFlagOrder then
        for index, key in ipairs(self.contextFlagOrder) do
            if key == flagKey then
                table.remove(self.contextFlagOrder, index)
                break
            end
        end
    end

    if self.debug then
        self:Debug("➖ Unregistered context flag '%s'", flagKey)
    end
    return true
end

--- Evaluate a context flag against current context
--- @param flagConfig table Flag configuration
--- @param context table Current context
function LearnedPredictionProvider:EvaluateContextFlag(flagConfig, context)
    if not flagConfig then
        return false
    end

    if flagConfig.evaluator and type(flagConfig.evaluator) == "function" then
        local ok, result = pcall(flagConfig.evaluator, context, flagConfig)
        if ok then
            return result and true or false
        elseif self.debug then
            self:Debug("⚠️ Context flag evaluator failed: %s", tostring(result))
        end
    end

    if flagConfig.auras then
        return HasAnyPlayerAura(flagConfig.auras)
    end

    if flagConfig.aura then
        return HasPlayerAura(flagConfig.aura)
    end

    if flagConfig.stateField and context then
        return context[flagConfig.stateField] and true or false
    end

    return false
end

-- ============================ PATCH-SENSITIVE SPELLS ============================

--- Register a spell to be reset when the client build changes
--- @param spellId number
function LearnedPredictionProvider:RegisterPatchSensitiveSpell(spellId)
    if not spellId then
        return false, "Spell ID required"
    end
    self.db.char.patchSensitiveSpells[spellId] = true
    self:InvalidateSpellPickerCache()
    return true
end

--- Remove a spell from patch-sensitive tracking
--- @param spellId number
function LearnedPredictionProvider:UnregisterPatchSensitiveSpell(spellId)
    if not spellId then
        return false, "Spell ID required"
    end
    if self.db.char.patchSensitiveSpells[spellId] then
        self.db.char.patchSensitiveSpells[spellId] = nil
        self:InvalidateSpellPickerCache()
        return true
    end
    return false
end

--- Handle user input for patch-sensitive additions
--- @param value string
function LearnedPredictionProvider:HandlePatchSensitiveAdd(value)
    local cleaned = trimWhitespace(value)
    if cleaned == "" then
        return
    end

    local spellId = tonumber(cleaned)
    if not spellId then
        self:Warn("Patch-sensitive add failed: '%s' is not a spell ID.", cleaned)
        return
    end

    self:RegisterPatchSensitiveSpell(spellId)
    self:Info("Marked spell %d as patch-sensitive; it will be cleared on build updates.", spellId)
end

--- Handle user input for patch-sensitive removal
--- @param value string
function LearnedPredictionProvider:HandlePatchSensitiveRemove(value)
    local cleaned = trimWhitespace(value)
    if cleaned == "" then
        return
    end

    local spellId = tonumber(cleaned)
    if not spellId then
        self:Warn("Patch-sensitive removal failed: '%s' is not a spell ID.", cleaned)
        return
    end

    if self:UnregisterPatchSensitiveSpell(spellId) then
        self:Info("Removed spell %d from patch-sensitive tracking.", spellId)
    else
        self:Warn("Spell %d was not registered as patch-sensitive.", spellId)
    end
end

--- Summarize patch-sensitive spell list
function LearnedPredictionProvider:GetPatchSensitiveSummary()
    local spells = self.db.char.patchSensitiveSpells
    if not spells or not next(spells) then
        return "No patch-sensitive spells registered."
    end

    local entries = {}
    for spellId in pairs(spells) do
        local spellInfo = WoWAPI.GetSpellInfo and WoWAPI.GetSpellInfo(spellId)
        local name = spellInfo and spellInfo.name or ("Spell " .. tostring(spellId))
        entries[#entries + 1] = format("- %s (%d)", name, spellId)
    end
    table.sort(entries)

    local lastTime = self.db.char.lastPatchResetTime or 0
    local lastScope = self.db.char.lastPatchResetScope or "none"
    local timestamp = lastTime > 0 and format("Last build reset: %s (%s)", date("%Y-%m-%d %H:%M:%S", lastTime), lastScope) or "No build reset performed yet."

    return table.concat(entries, "\n") .. "\n\n" .. timestamp
end

--- Print bucket summary for debugging
--- @param spellId number
function LearnedPredictionProvider:PrintBucketSummary(spellId)
    if not spellId then
        self:Warn("Bucket summary requires a spell ID.")
        return
    end

    local summary = self:GetBucketSummary(spellId)
    if not summary or #summary == 0 then
        self:Info("No bucket data recorded for spell %d.", spellId)
        return
    end

    local spellInfo = WoWAPI.GetSpellInfo and WoWAPI.GetSpellInfo(spellId)
    local name = spellInfo and spellInfo.name or ("Spell " .. tostring(spellId))

    self:Info("=== Bucket Summary: %s (%d) ===", name, spellId)
    for _, bucket in ipairs(summary) do
        local meta = bucket.meta or {}
        local flags = meta.contextFlags or {}
        local flagParts = {}
        for flagKey, active in pairs(flags) do
            flagParts[#flagParts + 1] = flagKey .. "=" .. (active and "1" or "0")
        end
        table.sort(flagParts)

        local resourceSummaries = summarizeStatTable(bucket.metrics and bucket.metrics.cost, function(resourceType, stat)
            return format("%s=%.2f (n=%d)", tostring(resourceType), stat.mean, stat.count)
        end)
        local generationSummaries = summarizeStatTable(bucket.metrics and bucket.metrics.generation, function(resourceType, stat)
            return format("%s=%.2f (n=%d)", tostring(resourceType), stat.mean, stat.count)
        end)
        local flagSummaries = summarizeStatTable(bucket.metrics and bucket.metrics.flags, function(flagKey, stat)
            return format("%s=%.1f%%", tostring(flagKey), (stat.mean or 0) * 100)
        end)

        self:Info("[%s] samples=%d last=%.1fs ago | haste=%s (%.1f%%) | targets=%s | flags=%s",
            bucket.key,
            bucket.samples or 0,
            bucket.lastUpdated and (GetTime() - bucket.lastUpdated) or -1,
            meta.hasteBand or "n/a",
            meta.hastePercent or 0,
            meta.targetBand or "n/a",
            table.concat(flagParts, ", ")
        )

        if #resourceSummaries > 0 then
            self:Info("  Cost: %s", table.concat(resourceSummaries, "; "))
        end
        if #generationSummaries > 0 then
            self:Info("  Generation: %s", table.concat(generationSummaries, "; "))
        end
        if #flagSummaries > 0 then
            self:Info("  Flag activity: %s", table.concat(flagSummaries, "; "))
        end
    end
end

-- ============================ BUCKETED METRICS ============================

--- Get a bucket key and metadata for the current context
--- @param context table|nil
--- @return string bucketKey
--- @return table bucketMeta
function LearnedPredictionProvider:GetBucketKeyForContext(context)
    context = context or self:GetCurrentContext()
    local targetCount = context.targetCount or 0
    local hastePercent = context.hastePercent
    if hastePercent == nil and UnitSpellHaste then
        hastePercent = UnitSpellHaste("player") or 0
    end

    local hasBloodlust = context.hasBloodlust
    if hasBloodlust == nil then
        hasBloodlust = HasAnyPlayerAura(BLOODLUST_IDS)
    end

    local hasLockAndLoad = context.hasLockAndLoad
    if hasLockAndLoad == nil then
        hasLockAndLoad = HasPlayerAura(LOCK_AND_LOAD_ID)
    end

    local hasteBand = context.hasteBand or determineHasteBand(hastePercent)
    local targetBand = determineTargetBand(targetCount)

    local bucketMeta = {
        hasteBand = hasteBand,
        hastePercent = hastePercent or 0,
        hasBloodlust = hasBloodlust and true or false,
        hasLockAndLoad = hasLockAndLoad and true or false,
        targetBand = targetBand,
        targetCount = targetCount,
        inCombat = context.inCombat or false,
        groupType = context.groupType or "solo",
        contextFlags = {},
    }

    local keyParts = {
        bucketMeta.hasteBand,
        bucketMeta.hasBloodlust and "bl1" or "bl0",
        bucketMeta.hasLockAndLoad and "lnl1" or "lnl0",
        bucketMeta.targetBand,
        bucketMeta.inCombat and "c1" or "c0",
        bucketMeta.groupType,
    }

    if self.contextFlagOrder then
        for _, flagKey in ipairs(self.contextFlagOrder) do
            local flagConfig = self.contextFlags[flagKey]
            if flagConfig then
                local active = self:EvaluateContextFlag(flagConfig, context)
                bucketMeta.contextFlags[flagKey] = active and true or false
                keyParts[#keyParts + 1] = flagKey .. ":" .. (active and "1" or "0")
            end
        end
    end

    local bucketKey = table.concat(keyParts, "|")

    return bucketKey, bucketMeta
end

--- Get or create the bucket record for a spell/context combination
--- @param spellId number
--- @param bucketKey string
--- @param bucketMeta table
--- @return table bucket
function LearnedPredictionProvider:GetOrCreateBucket(spellId, bucketKey, bucketMeta)
    local bucketedData = self.db.char.bucketedData
    local spellBuckets = bucketedData[spellId]
    if not spellBuckets then
        spellBuckets = {}
        bucketedData[spellId] = spellBuckets
    end

    local bucket = spellBuckets[bucketKey]
    if not bucket then
        bucket = {
            meta = copyTableShallow(bucketMeta),
            metrics = {
                cost = {},
                generation = {},
                castTime = ensureStatRecord(),
                tickInterval = ensureStatRecord(),
                buffStacks = {},
                flags = {},
                resourceBefore = ensureStatRecord(),
                resourceAfter = ensureStatRecord(),
            },
            samples = 0,
            lastUpdated = 0,
        }
        spellBuckets[bucketKey] = bucket
    else
        -- Merge latest metadata to keep context descriptive
        for key, value in pairs(bucketMeta) do
            bucket.meta[key] = value
        end
        local metrics = bucket.metrics or {}
        metrics.castTime = ensureStatRecord(metrics.castTime)
        metrics.tickInterval = ensureStatRecord(metrics.tickInterval)
        metrics.resourceBefore = ensureStatRecord(metrics.resourceBefore)
        metrics.resourceAfter = ensureStatRecord(metrics.resourceAfter)
        metrics.cost = metrics.cost or {}
        metrics.generation = metrics.generation or {}
        metrics.buffStacks = metrics.buffStacks or {}
        metrics.flags = metrics.flags or {}
        bucket.metrics = metrics
    end
    return bucket
end

--- Retrieve an existing bucket without creating a new one
--- @param spellId number
--- @param bucketKey string
function LearnedPredictionProvider:GetBucketForSpell(spellId, bucketKey)
    local bucketedData = self.db.char.bucketedData
    if not bucketedData then
        return nil
    end
    local spellBuckets = bucketedData[spellId]
    if not spellBuckets then
        return nil
    end
    return spellBuckets[bucketKey]
end

--- Collect bucket summaries for a spell
--- @param spellId number
--- @return table|nil
function LearnedPredictionProvider:GetBucketSummary(spellId)
    local bucketedData = self.db.char.bucketedData
    if not bucketedData or not bucketedData[spellId] then
        return nil
    end
    local summary = {}
    for bucketKey, bucket in pairs(bucketedData[spellId]) do
        summary[#summary + 1] = {
            key = bucketKey,
            samples = bucket.samples or 0,
            lastUpdated = bucket.lastUpdated or 0,
            meta = bucket.meta or {},
            metrics = bucket.metrics or {},
        }
    end
    table.sort(summary, function(a, b)
        return (a.samples or 0) > (b.samples or 0)
    end)
    return summary
end

--- Extract a normalized sample from a delta payload
--- @param spellId number
--- @param delta table
--- @param context table
--- @return table|nil sample
function LearnedPredictionProvider:ExtractSampleFromDelta(spellId, delta, context)
    if not delta or type(delta) ~= "table" then
        return nil
    end

    local sample = {
        timestamp = GetTime(),
        cost = {},
        generation = {},
        buffStacks = {},
        castTime = nil,
        tickInterval = nil,
        hastePercent = context and context.hastePercent or nil,
        contextFlags = {},
        resourceBefore = nil,
        resourceAfter = nil,
    }

    if context and context.contextFlags then
        for flagKey, active in pairs(context.contextFlags) do
            sample.contextFlags[flagKey] = active and true or false
        end
    end

    -- Resource snapshots (focus/energy/etc.)
    local primaryPowerType = UnitPowerType and UnitPowerType("player")
    if primaryPowerType ~= nil and UnitPower and UnitPowerMax then
        sample.resourceBefore = UnitPower("player", primaryPowerType)
        local maxResource = UnitPowerMax("player", primaryPowerType) or 0
        if maxResource > 0 and sample.resourceBefore ~= nil then
            sample.resourceBeforePercent = sample.resourceBefore / maxResource
        end
    end

    -- Resource costs
    if delta.cost then
        local resources = delta.cost.resources or delta.cost
        if type(resources) == "table" then
            for resourceType, resourceData in pairs(resources) do
                local amount = resolveResourceValue(resourceData)
                if amount and amount ~= 0 then
                    sample.cost[resourceType] = amount
                end
            end
        end
        if delta.cost.secondary and type(delta.cost.secondary) == "table" then
            for resourceType, resourceData in pairs(delta.cost.secondary) do
                local amount = resolveResourceValue(resourceData)
                if amount and amount ~= 0 then
                    sample.cost[resourceType] = amount
                end
            end
        end
    end

    -- Resource generation
    if delta.generates then
        local resources = delta.generates.resources or delta.generates
        if type(resources) == "table" then
            for resourceType, resourceData in pairs(resources) do
                local amount = resolveResourceValue(resourceData)
                if amount and amount ~= 0 then
                    sample.generation[resourceType] = amount
                end
            end
        end
        if delta.generates.secondary and type(delta.generates.secondary) == "table" then
            for resourceType, resourceData in pairs(delta.generates.secondary) do
                local amount = resolveResourceValue(resourceData)
                if amount and amount ~= 0 then
                    sample.generation[resourceType] = amount
                end
            end
        end
        if delta.generates.ticks and type(delta.generates.ticks) == "table" then
            sample.tickInterval = delta.generates.ticks.interval or delta.generates.ticks.tickInterval or sample.tickInterval
        end
    end

    if delta.periodic and type(delta.periodic) == "table" then
        sample.tickInterval = delta.periodic.tickInterval or sample.tickInterval
    end

    -- Cast time heuristics
    if delta.castTime then
        sample.castTime = delta.castTime
    elseif delta.cast and type(delta.cast) == "table" then
        sample.castTime = delta.cast.effective or delta.cast.effectiveTime or delta.cast.time or delta.cast.duration
    elseif delta.timing and type(delta.timing) == "table" then
        sample.castTime = delta.timing.castTime or delta.timing.duration
    end

    if not sample.castTime and spellId then
        local spellInfo = WoWAPI.GetSpellInfo and WoWAPI.GetSpellInfo(spellId)
        if spellInfo and spellInfo.castTime and spellInfo.castTime > 0 then
            sample.castTime = spellInfo.castTime / 1000
        end
    end

    -- Buff stacks applied
    if delta.applies and type(delta.applies) == "table" and delta.applies.buffs then
        for buffId, buffData in pairs(delta.applies.buffs) do
            local stacks
            local buffType = type(buffData)
            if buffType == "number" then
                stacks = buffData
            elseif buffType == "table" then
                stacks = buffData.stacks
                    or buffData.maxStacks
                    or buffData.averageStacks
                    or buffData.commonStacks
                    or buffData.frequencyStacks
            end
            if stacks and stacks > 0 then
                local numericId = tonumber(buffId) or buffId
                sample.buffStacks[numericId] = stacks
            end
        end
    end

    -- Derive haste percent if missing
    if not sample.hastePercent and UnitSpellHaste then
        sample.hastePercent = UnitSpellHaste("player") or 0
    end

    -- If we captured nothing useful, skip
    local hasCost = next(sample.cost) ~= nil
    local hasGeneration = next(sample.generation) ~= nil
    local hasBuffStacks = next(sample.buffStacks) ~= nil
    if not hasCost and not hasGeneration and not hasBuffStacks and not sample.castTime and not sample.tickInterval and not sample.resourceBefore then
        return nil
    end

    -- Estimate resource after applying deltas if possible
    if sample.resourceBefore ~= nil then
        local deltaAmount = 0
        for _, amount in pairs(sample.cost) do
            deltaAmount = deltaAmount - amount
        end
        for _, amount in pairs(sample.generation) do
            deltaAmount = deltaAmount + amount
        end
        local after = sample.resourceBefore + deltaAmount
        sample.resourceAfter = after
    end

    return sample
end

--- Determine whether the sample is an outlier for the target bucket
--- @param bucket table
--- @param sample table
--- @return boolean
function LearnedPredictionProvider:IsOutlierSample(bucket, sample)
    if not bucket or not sample then
        return false
    end
    local settings = self.db.char.bucketSettings or DEFAULT_BUCKET_SETTINGS
    local metrics = bucket.metrics or {}

    for resourceType, amount in pairs(sample.cost or {}) do
        if isOutlierValue(metrics.cost and metrics.cost[resourceType], amount, settings) then
            return true
        end
    end

    for resourceType, amount in pairs(sample.generation or {}) do
        if isOutlierValue(metrics.generation and metrics.generation[resourceType], amount, settings) then
            return true
        end
    end

    if sample.castTime and isOutlierValue(metrics.castTime, sample.castTime, settings) then
        return true
    end

    if sample.tickInterval and isOutlierValue(metrics.tickInterval, sample.tickInterval, settings) then
        return true
    end

    for buffId, stacks in pairs(sample.buffStacks or {}) do
        local buffMetrics = metrics.buffStacks and metrics.buffStacks[buffId]
        if isOutlierValue(buffMetrics, stacks, settings) then
            return true
        end
    end

    return false
end

--- Apply a sample to the bucket metrics
--- @param bucket table
--- @param sample table
function LearnedPredictionProvider:ApplySampleToBucket(bucket, sample)
    if not bucket or not sample then
        return
    end

    local metrics = bucket.metrics
    metrics.castTime = updateRunningStat(metrics.castTime, sample.castTime)
    metrics.tickInterval = updateRunningStat(metrics.tickInterval, sample.tickInterval)
    metrics.resourceBefore = updateRunningStat(metrics.resourceBefore, sample.resourceBefore)
    metrics.resourceAfter = updateRunningStat(metrics.resourceAfter, sample.resourceAfter)

    for resourceType, amount in pairs(sample.cost or {}) do
        metrics.cost[resourceType] = updateRunningStat(metrics.cost[resourceType], amount)
    end

    for resourceType, amount in pairs(sample.generation or {}) do
        metrics.generation[resourceType] = updateRunningStat(metrics.generation[resourceType], amount)
    end

    for buffId, stacks in pairs(sample.buffStacks or {}) do
        metrics.buffStacks[buffId] = updateRunningStat(metrics.buffStacks[buffId], stacks)
    end

    for flagKey, active in pairs(sample.contextFlags or {}) do
        metrics.flags[flagKey] = updateRunningStat(metrics.flags[flagKey], active and 1 or 0)
    end

    bucket.samples = (bucket.samples or 0) + 1
    bucket.lastUpdated = sample.timestamp or GetTime()
    bucket.meta.lastHastePercent = sample.hastePercent or bucket.meta.lastHastePercent
end

--- Update bucketed metrics for a newly learned delta
--- @param spellId number
--- @param delta table
function LearnedPredictionProvider:UpdateBucketMetrics(spellId, delta)
    if not self.db or not self.db.char or not self.db.char.bucketedData then
        return
    end
    local context = self:GetCurrentContext()
    local bucketKey, bucketMeta = self:GetBucketKeyForContext(context)
    local bucket = self:GetOrCreateBucket(spellId, bucketKey, bucketMeta)
    local sample = self:ExtractSampleFromDelta(spellId, delta, context)

    if not sample then
        return
    end

    if self:IsOutlierSample(bucket, sample) then
        if self.debug then
            self:Debug("🚫 Discarded outlier sample for spell %d (bucket %s)", spellId, bucketKey)
        end
        return
    end

    self:ApplySampleToBucket(bucket, sample)

    if self.debug then
        self:Debug("📦 Bucket sample recorded: spell %d key %s (samples=%d)", spellId, bucketKey, bucket.samples or 0)
    end
end

-- ============================ DATA HYGIENE ============================

--- Reset learned data and overrides
--- @param spellId number|nil Optional spell ID; nil resets everything
function LearnedPredictionProvider:ResetLearnedData(spellId)
    if spellId then
        if self.db.char.bucketedData then
            self.db.char.bucketedData[spellId] = nil
        end
        if self.db.char.manualOverrides then
            if self.db.char.manualOverrides.cost then
                self.db.char.manualOverrides.cost[spellId] = nil
            end
            if self.db.char.manualOverrides.generation then
                self.db.char.manualOverrides.generation[spellId] = nil
            end
        end
        if self.db.char.accuracyStats then
            self.db.char.accuracyStats[spellId] = nil
        end
        self.pendingValidations[spellId] = nil
        self.latestSpellDeltas[spellId] = nil
        self:InvalidateCache(spellId)
        return
    end

    if self.db.char.bucketedData then
        wipe(self.db.char.bucketedData)
    end

    if self.db.char.manualOverrides then
        if self.db.char.manualOverrides.cost then
            wipe(self.db.char.manualOverrides.cost)
        end
        if self.db.char.manualOverrides.generation then
            wipe(self.db.char.manualOverrides.generation)
        end
    end

    if self.db.char.accuracyStats then
        wipe(self.db.char.accuracyStats)
    end

    wipe(self.pendingValidations)
    wipe(self.latestSpellDeltas)

    if self.cache then
        for _, cacheTable in pairs(self.cache) do
            wipe(cacheTable)
        end
    end
end

--- Get statistics about stored learned data
--- @return table stats { totalSpells, totalBuckets, oldestBucket, newestBucket }
function LearnedPredictionProvider:GetDataStatistics()
    local bucketedData = self.db.char.bucketedData
    if not bucketedData then
        return { totalSpells = 0, totalBuckets = 0, oldestBucket = 0, newestBucket = 0, lowSampleBuckets = 0 }
    end

    local totalSpells = 0
    local totalBuckets = 0
    local lowSampleBuckets = 0
    local oldestBucket = GetTime()
    local newestBucket = 0
    local minSamples = (self.db.char.bucketSettings and self.db.char.bucketSettings.minSamplesForExport) or 3

    for spellId, spellBuckets in pairs(bucketedData) do
        totalSpells = totalSpells + 1
        for bucketKey, bucket in pairs(spellBuckets) do
            totalBuckets = totalBuckets + 1
            local lastUpdated = bucket.lastUpdated or 0
            if lastUpdated > 0 and lastUpdated < oldestBucket then
                oldestBucket = lastUpdated
            end
            if lastUpdated > newestBucket then
                newestBucket = lastUpdated
            end
            if (bucket.samples or 0) < minSamples then
                lowSampleBuckets = lowSampleBuckets + 1
            end
        end
    end

    return {
        totalSpells = totalSpells,
        totalBuckets = totalBuckets,
        oldestBucket = oldestBucket,
        newestBucket = newestBucket,
        lowSampleBuckets = lowSampleBuckets,
    }
end

--- Prune stale or low-sample buckets to reduce saved data size
--- @param maxAgeDays number|nil Max age in days (default 30, nil to skip age check)
--- @param minSamples number|nil Minimum samples to keep (default 3, nil to skip sample check)
--- @return number prunedCount Number of buckets removed
function LearnedPredictionProvider:PruneStaleData(maxAgeDays, minSamples)
    local bucketedData = self.db.char.bucketedData
    if not bucketedData then
        return 0
    end

    maxAgeDays = maxAgeDays or 30
    minSamples = minSamples or 3

    local now = GetTime()
    local maxAgeSeconds = maxAgeDays * 24 * 60 * 60
    local prunedCount = 0
    local spellsToRemove = {}

    for spellId, spellBuckets in pairs(bucketedData) do
        local bucketsToRemove = {}

        for bucketKey, bucket in pairs(spellBuckets) do
            local shouldRemove = false
            local lastUpdated = bucket.lastUpdated or 0
            local samples = bucket.samples or 0

            -- Remove if too old
            if maxAgeDays and lastUpdated > 0 and (now - lastUpdated) > maxAgeSeconds then
                shouldRemove = true
            end

            -- Remove if too few samples (and not recently updated)
            if minSamples and samples < minSamples then
                -- Only remove low-sample buckets if they're also older than 1 day
                local oneDayAgo = now - (24 * 60 * 60)
                if lastUpdated < oneDayAgo then
                    shouldRemove = true
                end
            end

            if shouldRemove then
                bucketsToRemove[#bucketsToRemove + 1] = bucketKey
            end
        end

        for _, bucketKey in ipairs(bucketsToRemove) do
            spellBuckets[bucketKey] = nil
            prunedCount = prunedCount + 1
        end

        -- Mark spell for removal if no buckets remain
        if not next(spellBuckets) then
            spellsToRemove[#spellsToRemove + 1] = spellId
        end
    end

    -- Remove empty spell entries
    for _, spellId in ipairs(spellsToRemove) do
        bucketedData[spellId] = nil
    end

    -- Clear cache after pruning
    if self.cache then
        for _, cacheTable in pairs(self.cache) do
            wipe(cacheTable)
        end
    end

    if prunedCount > 0 and self.debug then
        self:Debug("🧹 Pruned %d stale buckets (maxAge=%d days, minSamples=%d)", prunedCount, maxAgeDays, minSamples)
    end

    return prunedCount
end

--- Get a human-readable summary of data statistics
--- @return string summary
function LearnedPredictionProvider:GetDataSummary()
    local stats = self:GetDataStatistics()
    local now = GetTime()

    local oldestAge = (stats.oldestBucket > 0) and (now - stats.oldestBucket) or 0
    local newestAge = (stats.newestBucket > 0) and (now - stats.newestBucket) or 0

    local function formatAge(seconds)
        if seconds <= 0 then return "never" end
        local days = seconds / (24 * 60 * 60)
        if days >= 1 then
            return format("%.1f days ago", days)
        end
        local hours = seconds / 3600
        if hours >= 1 then
            return format("%.1f hours ago", hours)
        end
        return format("%.0f minutes ago", seconds / 60)
    end

    return format(
        "Learned Data: %d spells, %d buckets (%d low-sample)\nOldest: %s | Newest: %s",
        stats.totalSpells,
        stats.totalBuckets,
        stats.lowSampleBuckets,
        formatAge(oldestAge),
        formatAge(newestAge)
    )
end

--- Ensure learned data is refreshed on client build updates
function LearnedPredictionProvider:CheckClientBuild()
    local currentBuild
    if ns.Version and ns.Version.GetVersionInfo then
        local versionInfo = ns.Version:GetVersionInfo()
        currentBuild = versionInfo and versionInfo.build
    end

    if not currentBuild and GetBuildInfo then
        local _, build = GetBuildInfo()
        currentBuild = build
    end

    if not currentBuild then
        return
    end

    if self.db.char.lastClientBuild ~= currentBuild then
        local previousBuild = self.db.char.lastClientBuild
        local sensitiveSpells = self.db.char.patchSensitiveSpells or {}
        local hasSpecific = next(sensitiveSpells) ~= nil

        if previousBuild and self.debug then
            self:Debug("🔁 Client build changed (%s → %s); resetting learned data (%s)",
                tostring(previousBuild), tostring(currentBuild), hasSpecific and "partial" or "full")
        end

        if hasSpecific then
            for spellId in pairs(sensitiveSpells) do
                self:ResetLearnedData(spellId)
            end
        else
            self:ResetLearnedData()
        end

        self.db.char.lastClientBuild = currentBuild
        self.db.char.lastPatchResetTime = GetTime()
        self.db.char.lastPatchResetScope = hasSpecific and "partial" or "full"

        local logEntry = {
            previous = previousBuild,
            current = currentBuild,
            scope = self.db.char.lastPatchResetScope,
            spellCount = hasSpecific and #self:GetPatchSensitiveSpellIds() or 0,
            timestamp = self.db.char.lastPatchResetTime,
        }
        table.insert(self.db.char.patchResetLog, logEntry)
        if #self.db.char.patchResetLog > 10 then
            table.remove(self.db.char.patchResetLog, 1)
        end
    end
end

--- Helper to get an array of patch-sensitive spell IDs
function LearnedPredictionProvider:GetPatchSensitiveSpellIds()
    local spells = self.db.char.patchSensitiveSpells or {}
    local ids = {}
    for spellId in pairs(spells) do
        ids[#ids + 1] = spellId
    end
    table.sort(ids)
    return ids
end


--- Get manual override record table
--- @param spellId number
--- @param field string "cost"|"generation"
--- @return table|nil
function LearnedPredictionProvider:GetManualOverride(spellId, field)
    local overrides = self.db.char.manualOverrides
    if not overrides or not overrides[field] then
        return nil
    end
    return overrides[field][spellId]
end

--- Get manual override value for a spell/field/resource
--- @param spellId number
--- @param field string
--- @param resourceType string|nil
--- @return number|nil
function LearnedPredictionProvider:GetManualOverrideValue(spellId, field, resourceType)
    local override = self:GetManualOverride(spellId, field)
    if not override then
        return nil
    end

    if resourceType and override.resources then
        local key = strupper(resourceType)
        local value = override.resources[key]
        if value ~= nil then
            return value
        end
    end

    return override.default
end

--- Get manual override table for generation (resource keyed)
--- @param spellId number
--- @param field string
--- @return table|nil
function LearnedPredictionProvider:GetManualOverrideTable(spellId, field)
    local override = self:GetManualOverride(spellId, field)
    if not override or not override.resources then
        if override and override.default ~= nil then
            return { DEFAULT = override.default }
        end
        return nil
    end

    local copy = {}
    if override.default ~= nil then
        copy.DEFAULT = override.default
    end
    for resourceType, value in pairs(override.resources) do
        copy[resourceType] = value
    end
    return next(copy) and copy or nil
end

--- Set a manual override
--- @param spellId number
--- @param field string
--- @param value number
--- @param resourceType string|nil
function LearnedPredictionProvider:SetManualOverride(spellId, field, value, resourceType)
    if not spellId or not field or value == nil then
        return false, "Invalid override arguments"
    end
    field = (field == "generation") and "generation" or "cost"

    local overrides = self.db.char.manualOverrides
    overrides[field][spellId] = overrides[field][spellId] or { resources = {} }
    local record = overrides[field][spellId]
    record.resources = record.resources or {}

    if resourceType and resourceType ~= "" then
        record.resources[strupper(resourceType)] = value
    else
        record.default = value
    end

    self:InvalidateCache(spellId, field)
    self:InvalidateSpellPickerCache()
    return true
end

--- Clear a manual override
--- @param spellId number
--- @param field string
--- @param resourceType string|nil
function LearnedPredictionProvider:ClearManualOverride(spellId, field, resourceType)
    if not spellId or not field then
        return false, "Invalid override arguments"
    end
    field = (field == "generation") and "generation" or "cost"

    local overrides = self.db.char.manualOverrides
    local record = overrides[field] and overrides[field][spellId]
    if not record then
        return false, "No override set"
    end

    if resourceType and resourceType ~= "" and record.resources then
        record.resources[strupper(resourceType)] = nil
    else
        record.default = nil
    end

    if record.resources and next(record.resources) == nil then
        record.resources = nil
    end

    if not record.default and not record.resources then
        overrides[field][spellId] = nil
    end

    self:InvalidateCache(spellId, field)
    self:InvalidateSpellPickerCache()
    return true
end

--- Reset all manual overrides
function LearnedPredictionProvider:ClearAllManualOverrides()
    if not self.db.char.manualOverrides then return end
    wipe(self.db.char.manualOverrides.cost)
    wipe(self.db.char.manualOverrides.generation)
    if self.debug then
        self:Debug("🧹 Cleared all manual overrides")
    end
    self:InvalidateSpellPickerCache()
end

--- Handle reset spell input from options UI
--- @param value string
function LearnedPredictionProvider:HandleResetSpellInput(value)
    local cleaned = trimWhitespace(value)
    if cleaned == "" then
        return
    end
    local spellId = tonumber(cleaned)
    if not spellId then
        self:Warn("Reset spell input invalid: '%s'", cleaned)
        return
    end
    self:ResetLearnedData(spellId)
    self:Info("Cleared learned data for spell %d", spellId)
end

--- Handle override input from options UI
--- @param field string
--- @param value string
function LearnedPredictionProvider:HandleOverrideInput(field, value)
    local cleaned = trimWhitespace(value)
    if cleaned == "" then
        return
    end

    local spellId, resourceType, amount = strmatch(cleaned, "^(%d+)%s*:%s*([%a_]+)%s*=%s*([%d%.%-]+)$")
    if not spellId then
        spellId, amount = strmatch(cleaned, "^(%d+)%s*=%s*([%d%.%-]+)$")
    end

    if not spellId or not amount then
        self:Warn("Override format invalid. Use 'spellId=value' or 'spellId:RESOURCE=value'.")
        return
    end

    spellId = tonumber(spellId)
    local numericValue = tonumber(amount)
    if not numericValue then
        self:Warn("Override value must be numeric.")
        return
    end

    self:SetManualOverride(spellId, field, numericValue, resourceType)
    if resourceType then
        self:Info("Pinned %s override for spell %d (%s) to %.2f", field, spellId, strupper(resourceType), numericValue)
    else
        self:Info("Pinned %s override for spell %d to %.2f", field, spellId, numericValue)
    end
end

--- Handle clear override input from options UI
--- @param value string
function LearnedPredictionProvider:HandleClearOverrideInput(value)
    local cleaned = trimWhitespace(value)
    if cleaned == "" then
        return
    end

    local spellId, resourceType = strmatch(cleaned, "^(%d+)%s*:%s*([%a_]+)$")
    if not spellId then
        spellId = strmatch(cleaned, "^(%d+)$")
    end

    if not spellId then
        self:Warn("Clear override format invalid. Use 'spellId' or 'spellId:RESOURCE'.")
        return
    end

    spellId = tonumber(spellId)
    local clearedCost = self:ClearManualOverride(spellId, "cost", resourceType)
    local clearedGeneration = self:ClearManualOverride(spellId, "generation", resourceType)

    if clearedCost or clearedGeneration then
        if resourceType then
            self:Info("Cleared overrides for spell %d (%s).", spellId, strupper(resourceType))
        else
            self:Info("Cleared overrides for spell %d.", spellId)
        end
    else
        self:Warn("No overrides found for spell %d.", spellId)
    end
end

--- Handle bucket inspection input
--- @param value string
function LearnedPredictionProvider:HandleBucketInspectInput(value)
    local cleaned = trimWhitespace(value)
    if cleaned == "" then
        return
    end
    local spellId = tonumber(cleaned)
    if not spellId then
        self:Warn("Bucket inspect input invalid: '%s'", cleaned)
        return
    end
    self:PrintBucketSummary(spellId)
end

--- Handle cost telemetry inspection input
--- @param value string
function LearnedPredictionProvider:HandleCostTelemetryInput(value)
    local cleaned = trimWhitespace(value)
    if cleaned == "" then
        return
    end
    local spellId = tonumber(cleaned)
    if not spellId then
        self:Warn("Cost telemetry input invalid: '%s'", cleaned)
        return
    end
    local telemetry = self:GetCostTelemetry(spellId)
    local spellInfo = WoWAPI.GetSpellInfo and WoWAPI.GetSpellInfo(spellId)
    self:Info("=== Cost Telemetry: %s (%d) ===", spellInfo and spellInfo.name or "Spell", spellId)
    self:Info("Source: %s | Confidence: %.2f | Override: %s | Bucket: %s | Samples: %d",
        telemetry.source,
        telemetry.confidence or 0,
        telemetry.overrideApplied and "Yes" or "No",
        telemetry.bucketKey or "n/a",
        telemetry.bucketSamples or 0
    )
    if telemetry.reason then
        self:Info("Reason: %s", telemetry.reason)
    end
    if telemetry.bucketMeta then
        self:Info("Context: haste=%s targets=%s flags=%s",
            telemetry.bucketMeta.hasteBand or "n/a",
            telemetry.bucketMeta.targetBand or "n/a",
            telemetry.bucketMeta.contextFlags and formatTelemetryValue(telemetry.bucketMeta.contextFlags) or "n/a"
        )
    end
    self:Info("Value: %s", formatTelemetryValue(telemetry.value or telemetry.learnedValue))
end

--- Handle generation telemetry inspection input
--- @param value string
function LearnedPredictionProvider:HandleGenerationTelemetryInput(value)
    local cleaned = trimWhitespace(value)
    if cleaned == "" then
        return
    end

    local spellIdPart, resourceTypePart = cleaned:match("^(%d+)%s*:%s*([%a_]+)$")
    if not spellIdPart then
        spellIdPart = cleaned
    end

    local spellId = tonumber(spellIdPart)
    if not spellId then
        self:Warn("Generation telemetry input invalid: '%s'", cleaned)
        return
    end
    local resourceType = resourceTypePart and strupper(resourceTypePart) or nil

    local telemetry = self:GetGenerationTelemetry(spellId, resourceType)
    local spellInfo = WoWAPI.GetSpellInfo and WoWAPI.GetSpellInfo(spellId)
    self:Info("=== Generation Telemetry: %s (%d) ===", spellInfo and spellInfo.name or "Spell", spellId)
    self:Info("Resource: %s | Source: %s | Confidence: %.2f | Override: %s",
        resourceType or "ALL",
        telemetry.source,
        telemetry.confidence or 0,
        telemetry.overrideApplied and "Yes" or "No"
    )
    if telemetry.reason then
        self:Info("Reason: %s", telemetry.reason)
    end
    if telemetry.lastSeen then
        self:Info("Last Seen: %.1fs ago", GetTime() - telemetry.lastSeen)
    end
    self:Info("Value: %s", formatTelemetryValue(telemetry.value or telemetry.learnedValue))
end

--- Get a readable summary of manual overrides
--- @param field string "cost"|"generation"
function LearnedPredictionProvider:GetManualOverrideSummary(field)
    field = (field == "generation") and "generation" or "cost"
    local overrides = self.db.char.manualOverrides and self.db.char.manualOverrides[field]
    if not overrides or not next(overrides) then
        return "No overrides applied."
    end

    local lines = {}
    for spellId, record in pairs(overrides) do
        local spellInfo = WoWAPI.GetSpellInfo and WoWAPI.GetSpellInfo(spellId)
        local name = spellInfo and spellInfo.name or ("Spell " .. tostring(spellId))
        local parts = {}
        if record.default ~= nil then
            parts[#parts + 1] = format("default=%.2f", record.default)
        end
        if record.resources then
            for resourceType, amount in pairs(record.resources) do
                parts[#parts + 1] = format("%s=%.2f", tostring(resourceType), amount)
            end
        end
        lines[#lines + 1] = format("- %s (%d): %s", name, spellId, table.concat(parts, ", "))
    end
    table.sort(lines)
    return table.concat(lines, "\n")
end

function LearnedPredictionProvider:GetMaintenanceUIState()
    if not self._maintenanceUI then
        self._maintenanceUI = {
            patchAddSelection = "",
            costSpell = "",
            costValue = "",
            generationSpell = "",
            generationResource = "DEFAULT",
            generationValue = "",
            inspectBucket = "",
            inspectCost = "",
            inspectGeneration = "",
        }
    end
    return self._maintenanceUI
end

function LearnedPredictionProvider:InvalidateSpellPickerCache()
    self._spellDropdownCache = nil
end

function LearnedPredictionProvider:GetSpellDisplayLabel(spellId, includeId)
    if not spellId then
        return "Unknown"
    end

    local name
    local icon

    if SpellbookManager and SpellbookManager.GetSpell then
        local entry = SpellbookManager:GetSpell(spellId)
        if entry then
            name = entry.name or name
            icon = entry.icon or icon
        end
    end

    if not name then
        local spellInfo = WoWAPI.GetSpellInfo and WoWAPI.GetSpellInfo(spellId)
        if spellInfo then
            name = spellInfo.name or name
            icon = spellInfo.icon or icon
        end
    end

    name = name or ("Spell " .. tostring(spellId))
    icon = icon or "Interface\\Icons\\INV_Misc_QuestionMark"

    local label = format("|T%s:16:16:0:0|t %s", icon, name)
    if includeId ~= false then
        label = format("%s (%d)", label, spellId)
    end
    return label
end

function LearnedPredictionProvider:GetSpellDropdownValues()
    local now = GetTime()
    local cache = self._spellDropdownCache
    if cache and cache.timestamp and (now - cache.timestamp) <= 10 then
        return cache.values, cache.sorting
    end

    local values = { [""] = "-- Select Spell --" }
    local sortEntries = { { key = "", sortKey = "" } }
    local seen = { [""] = true }

    local function addSpell(spellId)
        if not spellId then return end
        local key = tostring(spellId)
        if seen[key] then return end
        local label = self:GetSpellDisplayLabel(spellId)
        values[key] = label
        table.insert(sortEntries, { key = key, sortKey = strlower(label) })
        seen[key] = true
    end

    if SpellbookManager and SpellbookManager.GetCastableSpells then
        if SpellbookManager.ForceScan then
            pcall(SpellbookManager.ForceScan, SpellbookManager)
        end
        local castable = SpellbookManager:GetCastableSpells()
        if castable then
            for spellId in pairs(castable) do
                addSpell(spellId)
            end
        end
    end

    for spellId in pairs(self.db.char.patchSensitiveSpells or {}) do
        addSpell(spellId)
    end

    local overrides = self.db.char.manualOverrides or {}
    for spellId in pairs(overrides.cost or {}) do
        addSpell(spellId)
    end
    for spellId in pairs(overrides.generation or {}) do
        addSpell(spellId)
    end

    table.sort(sortEntries, function(a, b)
        return a.sortKey < b.sortKey
    end)

    local sorting = {}
    for _, entry in ipairs(sortEntries) do
        table.insert(sorting, entry.key)
    end

    cache = {
        values = values,
        sorting = sorting,
        timestamp = now
    }
    self._spellDropdownCache = cache
    return values, sorting
end

function LearnedPredictionProvider:GetPatchSensitiveValues()
    local values = {}
    local sortEntries = {}

    for spellId in pairs(self.db.char.patchSensitiveSpells or {}) do
        local key = tostring(spellId)
        local label = self:GetSpellDisplayLabel(spellId)
        values[key] = label
        table.insert(sortEntries, { key = key, sortKey = strlower(label) })
    end

    table.sort(sortEntries, function(a, b)
        return a.sortKey < b.sortKey
    end)

    local sorting = {}
    for _, entry in ipairs(sortEntries) do
        table.insert(sorting, entry.key)
    end

    return values, sorting
end

function LearnedPredictionProvider:FormatOverrideRecord(record)
    if not record then
        return ""
    end
    local parts = {}
    if record.default ~= nil then
        table.insert(parts, format("default=%.2f", record.default))
    end
    if record.resources then
        for resourceType, amount in pairs(record.resources) do
            table.insert(parts, format("%s=%.2f", tostring(resourceType), amount))
        end
    end
    table.sort(parts)
    return table.concat(parts, ", ")
end

function LearnedPredictionProvider:GetOverrideValues(field)
    field = (field == "generation") and "generation" or "cost"
    local overrides = self.db.char.manualOverrides and self.db.char.manualOverrides[field]
    local values = {}
    local sortEntries = {}

    if overrides then
        for spellId, record in pairs(overrides) do
            local key = tostring(spellId)
            local label = self:GetSpellDisplayLabel(spellId)
            local details = self:FormatOverrideRecord(record)
            if details ~= "" then
                label = format("%s - %s", label, details)
            end
            values[key] = label
            table.insert(sortEntries, { key = key, sortKey = strlower(label) })
        end
    end

    table.sort(sortEntries, function(a, b)
        return a.sortKey < b.sortKey
    end)

    local sorting = {}
    for _, entry in ipairs(sortEntries) do
        table.insert(sorting, entry.key)
    end

    return values, sorting
end

local RESOURCE_TYPE_VALUES = {
    DEFAULT = "Default resource",
    MANA = "Mana",
    ENERGY = "Energy",
    RAGE = "Rage",
    FOCUS = "Focus",
    RUNIC_POWER = "Runic Power",
    HOLY_POWER = "Holy Power",
    SOUL_SHARDS = "Soul Shards",
    CHI = "Chi",
    MAELSTROM = "Maelstrom",
    INSANITY = "Insanity",
    LUNAR_POWER = "Lunar Power",
    FURY = "Fury",
    PAIN = "Pain",
    ARCANE_CHARGES = "Arcane Charges",
}

local RESOURCE_TYPE_SORTING

function LearnedPredictionProvider:GetResourceTypeOptions()
    return RESOURCE_TYPE_VALUES
end

function LearnedPredictionProvider:GetResourceTypeSorting()
    if not RESOURCE_TYPE_SORTING then
        RESOURCE_TYPE_SORTING = {}
        for key in pairs(RESOURCE_TYPE_VALUES) do
            table.insert(RESOURCE_TYPE_SORTING, key)
        end
        table.sort(RESOURCE_TYPE_SORTING, function(a, b)
            return RESOURCE_TYPE_VALUES[a] < RESOURCE_TYPE_VALUES[b]
        end)
    end
    return RESOURCE_TYPE_SORTING
end

local function parseNumeric(value)
    if not value or value == "" then
        return nil
    end
    local numeric = tonumber(value)
    return numeric
end

function LearnedPredictionProvider:ApplyCostOverrideFromUI()
    local ui = self:GetMaintenanceUIState()
    local spellId = tonumber(ui.costSpell)
    if not spellId then
        self:Warn("Select a spell before applying a cost override.")
        return
    end

    local amount = parseNumeric(ui.costValue)
    if not amount then
        self:Warn("Enter a numeric cost value before applying the override.")
        return
    end

    local success = self:SetManualOverride(spellId, "cost", amount)
    if success then
        self:Info("Cost override applied: %s → %.2f", self:GetSpellDisplayLabel(spellId, false), amount)
    end
    ui.costValue = ""
    self:InvalidateSpellPickerCache()
end

function LearnedPredictionProvider:ApplyGenerationOverrideFromUI()
    local ui = self:GetMaintenanceUIState()
    local spellId = tonumber(ui.generationSpell)
    if not spellId then
        self:Warn("Select a spell before applying a generation override.")
        return
    end

    local amount = parseNumeric(ui.generationValue)
    if not amount then
        self:Warn("Enter a numeric generation value before applying the override.")
        return
    end

    local resourceType = ui.generationResource
    if resourceType == "DEFAULT" then
        resourceType = nil
    end

    local success = self:SetManualOverride(spellId, "generation", amount, resourceType)
    if success then
        if resourceType then
            self:Info("Generation override applied: %s → %.2f %s", self:GetSpellDisplayLabel(spellId, false), amount, resourceType)
        else
            self:Info("Generation override applied: %s → %.2f", self:GetSpellDisplayLabel(spellId, false), amount)
        end
    end
    ui.generationValue = ""
    self:InvalidateSpellPickerCache()
end

--- Inject shared maintenance options into an options args table
--- @param targetArgs table
--- @param orderBase number|nil
function LearnedPredictionProvider:AppendMaintenanceOptions(targetArgs, orderBase)
    if not targetArgs then
        return
    end

    if not OptionsFactory then
        OptionsFactory = NAG:GetModule("OptionsFactory")
    end

    local order = orderBase or 60
    local uiState = self:GetMaintenanceUIState()

    targetArgs.maintenanceHeader = OptionsFactory:CreateHeader(
        "Maintenance & Overrides",
        { order = order }
    )
    order = order + 1

    targetArgs.patchGroup = {
        type = "group",
        name = "Patch Handling",
        inline = true,
        order = order,
        args = {
            summary = OptionsFactory:CreateDescription(
                "Add spells that should automatically clear learned data when Blizzard adjusts tuning. Uncheck entries to remove them.",
                nil,
                { order = 1, width = "full" }
            ),
            addSpell = {
                type = "select",
                name = "Add Spell",
                desc = "Pick a spell from your spellbook (or previously tracked entries). Selecting adds it immediately.",
                order = 5,
                width = "full",
                values = function()
                    return self:GetSpellDropdownValues()
                end,
                sorting = function()
                    local _, sorting = self:GetSpellDropdownValues()
                    return sorting
                end,
                get = function()
                    return uiState.patchAddSelection or ""
                end,
                set = function(_, value)
                    if value == "" then
                        uiState.patchAddSelection = ""
                        return
                    end
                    local spellId = tonumber(value)
                    if spellId and self:RegisterPatchSensitiveSpell(spellId) then
                        self:Info("Patch-sensitive: %s", self:GetSpellDisplayLabel(spellId, false))
                    end
                    uiState.patchAddSelection = ""
                    self:InvalidateSpellPickerCache()
                end,
            },
            trackedSpells = {
                type = "multiselect",
                name = "Tracked Spells",
                desc = "Uncheck an entry to remove it from the patch-sensitive list.",
                order = 10,
                width = "full",
                values = function()
                    local values, sorting = self:GetPatchSensitiveValues()
                    if not sorting then
                        return values
                    end
                    local ordered = {}
                    for _, key in ipairs(sorting) do
                        ordered[key] = values[key]
                    end
                    return ordered
                end,
                get = function(_, key)
                    local spellId = tonumber(key)
                    return self.db.char.patchSensitiveSpells and self.db.char.patchSensitiveSpells[spellId] or false
                end,
                set = function(_, key, state)
                    local spellId = tonumber(key)
                    if not spellId then return end
                    if state then
                        self:RegisterPatchSensitiveSpell(spellId)
                    else
                        self:UnregisterPatchSensitiveSpell(spellId)
                        self:Info("Removed patch-sensitive spell: %s", self:GetSpellDisplayLabel(spellId, false))
                    end
                    self:InvalidateSpellPickerCache()
                end,
            },
            clearPatchSpells = OptionsFactory:CreateExecute(
                "Clear All Patch-Sensitive Spells",
                "Remove every patch-sensitive entry.",
                function()
                    wipe(self.db.char.patchSensitiveSpells)
                    self:Info("Cleared patch-sensitive spell registry.")
                    self:InvalidateSpellPickerCache()
                end,
                { order = 20, width = "half" }
            ),
        }
    }
    order = order + 1

    targetArgs.overrideGroup = {
        type = "group",
        name = "Overrides",
        inline = true,
        order = order,
        args = {
            overview = OptionsFactory:CreateDescription(
                "Apply temporary overrides when you want different resource costs or generation than the learned data.",
                nil,
                { order = 1, width = "full" }
            ),
            costHeader = OptionsFactory:CreateDescription(
                "|cffFFD200Cost Overrides|r",
                nil,
                { order = 5, width = "full" }
            ),
            costSpell = {
                type = "select",
                name = "Spell",
                order = 6,
                width = "full",
                values = function()
                    return self:GetSpellDropdownValues()
                end,
                sorting = function()
                    local _, sorting = self:GetSpellDropdownValues()
                    return sorting
                end,
                get = function()
                    return uiState.costSpell or ""
                end,
                set = function(_, value)
                    uiState.costSpell = value
                end,
            },
            costValue = OptionsFactory:CreateInput(
                "Override Amount",
                "Positive numbers spend resources, negative values refund.",
                function() return uiState.costValue or "" end,
                function(_, value) uiState.costValue = value end,
                { order = 7, width = "half" }
            ),
            costApply = OptionsFactory:CreateExecute(
                "Apply Cost Override",
                "Apply using the selected spell and amount.",
                function() self:ApplyCostOverrideFromUI() end,
                { order = 8, width = "half" }
            ),
            costActive = {
                type = "multiselect",
                name = "Active Cost Overrides",
                desc = "Uncheck to clear an override.",
                order = 9,
                width = "full",
                values = function()
                    local values, sorting = self:GetOverrideValues("cost")
                    if not sorting then
                        return values
                    end
                    local ordered = {}
                    for _, key in ipairs(sorting) do
                        ordered[key] = values[key]
                    end
                    return ordered
                end,
                get = function(_, key)
                    local spellId = tonumber(key)
                    return self:GetManualOverride(spellId, "cost") ~= nil
                end,
                set = function(_, key, state)
                    local spellId = tonumber(key)
                    if not spellId then return end
                    if state then
                        return
                    end
                    self:ClearManualOverride(spellId, "cost")
                    self:Info("Cleared cost override for %s", self:GetSpellDisplayLabel(spellId, false))
                    self:InvalidateSpellPickerCache()
                end,
            },
            genHeader = OptionsFactory:CreateDescription(
                "|cffFFD200Generation Overrides|r",
                nil,
                { order = 15, width = "full" }
            ),
            genSpell = {
                type = "select",
                name = "Spell",
                order = 16,
                width = "full",
                values = function()
                    return self:GetSpellDropdownValues()
                end,
                sorting = function()
                    local _, sorting = self:GetSpellDropdownValues()
                    return sorting
                end,
                get = function()
                    return uiState.generationSpell or ""
                end,
                set = function(_, value)
                    uiState.generationSpell = value
                end,
            },
            genResource = {
                type = "select",
                name = "Resource",
                order = 17,
                width = "half",
                values = self:GetResourceTypeOptions(),
                sorting = self:GetResourceTypeSorting(),
                get = function()
                    return uiState.generationResource or "DEFAULT"
                end,
                set = function(_, value)
                    uiState.generationResource = value
                end,
            },
            genValue = OptionsFactory:CreateInput(
                "Override Amount",
                "Enter how much of the selected resource should be generated (negative values spend).",
                function() return uiState.generationValue or "" end,
                function(_, value) uiState.generationValue = value end,
                { order = 18, width = "half" }
            ),
            genApply = OptionsFactory:CreateExecute(
                "Apply Generation Override",
                "Apply using the selected spell, resource, and amount.",
                function() self:ApplyGenerationOverrideFromUI() end,
                { order = 19, width = "half" }
            ),
            genActive = {
                type = "multiselect",
                name = "Active Generation Overrides",
                desc = "Uncheck to clear an override.",
                order = 20,
                width = "full",
                values = function()
                    local values, sorting = self:GetOverrideValues("generation")
                    if not sorting then
                        return values
                    end
                    local ordered = {}
                    for _, key in ipairs(sorting) do
                        ordered[key] = values[key]
                    end
                    return ordered
                end,
                get = function(_, key)
                    local spellId = tonumber(key)
                    return self:GetManualOverride(spellId, "generation") ~= nil
                end,
                set = function(_, key, state)
                    local spellId = tonumber(key)
                    if not spellId then return end
                    if state then
                        return
                    end
                    self:ClearManualOverride(spellId, "generation")
                    self:Info("Cleared generation override for %s", self:GetSpellDisplayLabel(spellId, false))
                    self:InvalidateSpellPickerCache()
                end,
            },
            clearOverrides = OptionsFactory:CreateExecute(
                "Clear All Overrides",
                "Remove every manual cost and generation override.",
                function() self:ClearAllManualOverrides() end,
                { order = 25, width = "half" }
            ),
        }
    }
    order = order + 1

    targetArgs.diagnosticsGroup = {
        type = "group",
        name = "Diagnostics",
        inline = true,
        order = order,
        args = {
            help = OptionsFactory:CreateDescription(
                "Pick a spell to print the relevant telemetry to chat.",
                nil,
                { order = 1, width = "full" }
            ),
            resetSpell = OptionsFactory:CreateInput(
                "Reset Learned Spell Data",
                "Enter a spell ID to clear learned data immediately.",
                function() return "" end,
                function(_, value) self:HandleResetSpellInput(value) end,
                { order = 2, width = "full" }
            ),
            inspectBucket = {
                type = "select",
                name = "Bucket Summary",
                order = 5,
                width = "full",
                values = function()
                    return self:GetSpellDropdownValues()
                end,
                sorting = function()
                    local _, sorting = self:GetSpellDropdownValues()
                    return sorting
                end,
                get = function()
                    return uiState.inspectBucket or ""
                end,
                set = function(_, value)
                    if value == "" then return end
                    local spellId = tonumber(value)
                    if spellId then
                        self:PrintBucketSummary(spellId)
                    end
                    uiState.inspectBucket = ""
                end,
            },
            inspectCost = {
                type = "select",
                name = "Cost Telemetry",
                order = 10,
                width = "full",
                values = function()
                    return self:GetSpellDropdownValues()
                end,
                sorting = function()
                    local _, sorting = self:GetSpellDropdownValues()
                    return sorting
                end,
                get = function()
                    return uiState.inspectCost or ""
                end,
                set = function(_, value)
                    if value == "" then return end
                    self:HandleCostTelemetryInput(value)
                    uiState.inspectCost = ""
                end,
            },
            inspectGeneration = {
                type = "select",
                name = "Generation Telemetry",
                order = 11,
                width = "full",
                values = function()
                    return self:GetSpellDropdownValues()
                end,
                sorting = function()
                    local _, sorting = self:GetSpellDropdownValues()
                    return sorting
                end,
                get = function()
                    return uiState.inspectGeneration or ""
                end,
                set = function(_, value)
                    if value == "" then return end
                    self:HandleGenerationTelemetryInput(value)
                    uiState.inspectGeneration = ""
                end,
            },
            showPatchLog = OptionsFactory:CreateExecute(
                "Show Patch Reset Log",
                "Print recent build-change resets.",
                function()
                    if not self.db.char.patchResetLog or #self.db.char.patchResetLog == 0 then
                        self:Info("No patch reset entries recorded.")
                        return
                    end
                    self:Info("=== Patch Reset Log ===")
                    for _, entry in ipairs(self.db.char.patchResetLog) do
                        self:Info("%s → %s | scope=%s | spells=%d | at=%s",
                            tostring(entry.previous or "nil"),
                            tostring(entry.current or "nil"),
                            tostring(entry.scope or "unknown"),
                            entry.spellCount or 0,
                            entry.timestamp and date("%Y-%m-%d %H:%M:%S", entry.timestamp) or "unknown")
                    end
                end,
                { order = 20, width = "half" }
            ),
        }
    }
    order = order + 1

    -- Data Management group
    targetArgs.dataManagementGroup = {
        type = "group",
        name = "Data Management",
        inline = true,
        order = order,
        args = {
            dataStatsDesc = {
                type = "description",
                name = function()
                    return self:GetDataSummary()
                end,
                order = 1,
                width = "full",
                fontSize = "medium",
            },
            pruneStaleData = OptionsFactory:CreateExecute(
                "Prune Stale Data",
                "Remove buckets older than 30 days or with fewer than 3 samples. This reduces WTF file size.",
                function()
                    local pruned = self:PruneStaleData(30, 3)
                    self:Info("Pruned %d stale buckets. %s", pruned, self:GetDataSummary())
                end,
                { order = 5, width = "half" }
            ),
            pruneAggressively = OptionsFactory:CreateExecute(
                "Aggressive Prune",
                "Remove buckets older than 7 days or with fewer than 5 samples.",
                function()
                    local pruned = self:PruneStaleData(7, 5)
                    self:Info("Aggressively pruned %d buckets. %s", pruned, self:GetDataSummary())
                end,
                { order = 6, width = "half" }
            ),
            clearAllData = OptionsFactory:CreateExecute(
                "Clear All Learned Data",
                "Remove ALL learned prediction data. Use this if your WTF file is too large.",
                function()
                    self:ResetLearnedData()
                    self:Info("Cleared all learned prediction data.")
                end,
                { order = 10, width = "half", confirm = true, confirmText = "This will delete ALL learned spell data. Are you sure?" }
            ),
            autoPruneHeader = {
                type = "header",
                name = "Automatic Cleanup",
                order = 15,
            },
            autoPruneEveryNSessions = OptionsFactory:CreateRange(
                "Auto-Prune Every N Sessions",
                "Automatically prune stale data every N logins. Set to 0 to disable.",
                function() return self:GetSetting("char", "autoPruneEveryNSessions") or 10 end,
                function(_, v) self:SetSetting("char", "autoPruneEveryNSessions", v) end,
                { order = 16, min = 0, max = 50, step = 1, width = "full" }
            ),
            sessionCountDesc = {
                type = "description",
                name = function()
                    local count = self.db.char.sessionCount or 0
                    local pruneEvery = self.db.char.autoPruneEveryNSessions or 10
                    if pruneEvery <= 0 then
                        return format("Current session: %d (auto-prune disabled)", count)
                    end
                    local nextPrune = pruneEvery - (count % pruneEvery)
                    return format("Current session: %d | Next auto-prune in: %d sessions", count, nextPrune)
                end,
                order = 17,
                width = "full",
            },
        }
    }
end

--- Handle NAG_SPELL_LEARNED message to get spell delta data
--- @param event string Event name
--- @param spellId number The spell ID
--- @param delta table|nil The spell delta analysis
function LearnedPredictionProvider:NAG_SPELL_LEARNED(event, spellId, delta)
    if not spellId or not delta then return end

    -- Invalidate cache when new data is learned
    self:InvalidateCache(spellId)

    -- Update bucketed metrics prior to any early returns
    self:UpdateBucketMetrics(spellId, delta)

    if not self.db.char.enableValidation then return end

    -- Store latest delta for validation
    self.latestSpellDeltas[spellId] = {
        cost = delta.cost,
        generates = delta.generates,
        timestamp = GetTime()
    }

    -- Clean up old deltas (older than validation window)
    local now = GetTime()
    local window = self.db.char.validationWindow or 2.0
    for id, deltaData in pairs(self.latestSpellDeltas) do
        if now - deltaData.timestamp > window * 2 then
            self.latestSpellDeltas[id] = nil
        end
    end
end

local function isFresh(self, recTime)
    if not recTime then return false end
    local now = GetTime()
    return (now - recTime) <= (self.db.char.freshnessSeconds or 0)
end

--- Check if cache entry is valid (not expired)
--- @param cacheEntry table Cache entry {value, timestamp}
--- @return boolean True if cache entry is valid
local function isCacheValid(cacheEntry, ttl)
    if not cacheEntry or not cacheEntry.timestamp then return false end
    local now = GetTime()
    return (now - cacheEntry.timestamp) <= ttl
end

--- Get cached prediction value
--- @param spellId number The spell ID
--- @param predictionType string Type of prediction
--- @param resourceType string|nil Optional resource type for generation
--- @return any|nil Cached value or nil if not cached/expired
function LearnedPredictionProvider:GetCachedPrediction(spellId, predictionType, resourceType)
    if not self.db.char.enableCache then return nil end

    local cache = self.cache[predictionType]
    if not cache or not cache[spellId] then
        self.cacheStats.misses = self.cacheStats.misses + 1
        return nil
    end

    local ttl = self.db.char.cacheTTL or 5.0
    local entry = cache[spellId]

    -- Handle generation cache (has resourceType sub-keys)
    if predictionType == "generation" and resourceType then
        if entry[resourceType] and isCacheValid(entry[resourceType], ttl) then
            self.cacheStats.hits = self.cacheStats.hits + 1
            return entry[resourceType].value
        end
    elseif isCacheValid(entry, ttl) then
        self.cacheStats.hits = self.cacheStats.hits + 1
        return entry.value
    else
        -- Cache expired, remove it
        cache[spellId] = nil
        self.cacheStats.evictions = self.cacheStats.evictions + 1
        self.cacheStats.misses = self.cacheStats.misses + 1
    end

    return nil
end

--- Cache a prediction value
--- @param spellId number The spell ID
--- @param predictionType string Type of prediction
--- @param value any The value to cache
--- @param resourceType string|nil Optional resource type for generation
function LearnedPredictionProvider:CachePrediction(spellId, predictionType, value, resourceType)
    if not self.db.char.enableCache then return end

    local cache = self.cache[predictionType]
    if not cache then return end

    local timestamp = GetTime()

    -- Handle generation cache (has resourceType sub-keys)
    if predictionType == "generation" and resourceType then
        if not cache[spellId] then
            cache[spellId] = {}
        end
        cache[spellId][resourceType] = {
            value = value,
            timestamp = timestamp
        }
    else
        cache[spellId] = {
            value = value,
            timestamp = timestamp
        }
    end
end

--- Invalidate cache for a spell
--- @param spellId number The spell ID
--- @param predictionType string|nil Optional prediction type (nil = all types)
function LearnedPredictionProvider:InvalidateCache(spellId, predictionType)
    if predictionType then
        local cache = self.cache[predictionType]
        if cache then
            cache[spellId] = nil
        end
    else
        -- Invalidate all caches for this spell
        for _, cache in pairs(self.cache) do
            cache[spellId] = nil
        end
    end
end

-- ============================ CONTEXT-AWARE PREDICTIONS ============================

--- Get current game context for predictions
--- @return table Context table with {pvp, instanceType, targetCount, groupType}
function LearnedPredictionProvider:GetCurrentContext()
    -- Guard against recursive calls during rotation evaluation
    if self._gettingContext then
        -- Return safe defaults to avoid stack overflow
        return {
            pvp = false,
            instanceType = "none",
            targetCount = 1,
            groupType = "solo",
            inCombat = false
        }
    end

    self._gettingContext = true
    local context = {
        pvp = false,
        instanceType = "none", -- "none", "arena", "battleground", "dungeon", "raid"
        targetCount = 1,
        groupType = "solo", -- "solo", "group", "raid"
        inCombat = false
    }

    -- Check PvP status (using IsInInstance which returns instanceType)
    local inInstance, instanceType = IsInInstance()
    if inInstance and instanceType then
        if instanceType == "arena" then
            context.pvp = true
            context.instanceType = "arena"
        elseif instanceType == "pvp" then
            context.pvp = true
            context.instanceType = "battleground"
        elseif instanceType == "party" then
            context.instanceType = "dungeon"
        elseif instanceType == "raid" then
            context.instanceType = "raid"
        end
    end

    -- Get target count (single target vs AoE)
    -- Use cached value from TTDManager state instead of triggering calculation
 if TTDManager.state and TTDManager.state.meleeMobCount then
        context.targetCount = TTDManager.state.meleeMobCount or 1
    elseif UnitExists("target") then
        context.targetCount = 1
    else
        context.targetCount = 0
    end

    -- Get group type
 if StateManager.state then
        local state = StateManager.state
        if state.inRaid then
            context.groupType = "raid"
        elseif state.inParty then
            context.groupType = "group"
        else
            context.groupType = "solo"
        end
    end

    -- Check combat status
    context.inCombat = UnitAffectingCombat("player") or false

    -- Extended context metrics
    if UnitSpellHaste then
        context.hastePercent = UnitSpellHaste("player") or 0
    else
        context.hastePercent = 0
    end
    context.hasteBand = determineHasteBand(context.hastePercent)
    context.hasBloodlust = HasAnyPlayerAura(BLOODLUST_IDS)
    context.hasLockAndLoad = HasPlayerAura(LOCK_AND_LOAD_ID)

    -- Context flag evaluation (deterministic order)
    context.contextFlags = {}
    if self.contextFlagOrder then
        for _, flagKey in ipairs(self.contextFlagOrder) do
            local flagConfig = self.contextFlags and self.contextFlags[flagKey]
            if flagConfig then
                local active = self:EvaluateContextFlag(flagConfig, context)
                context.contextFlags[flagKey] = active and true or false
            end
        end
    end

    self._gettingContext = false
    return context
end

--- Get context key for caching
--- @param context table Context table
--- @return string Context key for cache lookup
local function getContextKey(context)
    if not context then return "default" end
    local parts = {}
    table.insert(parts, context.pvp and "pvp" or "pve")
    table.insert(parts, context.instanceType or "none")
    table.insert(parts, context.targetCount > 1 and "aoe" or "st")
    table.insert(parts, context.groupType or "solo")
    return table.concat(parts, "_")
end

--- Get expected cost with context awareness
--- @param spellId number The spell ID
--- @param context table|nil Optional context (nil = use current context)
--- @return number|nil Expected cost or nil
function LearnedPredictionProvider:GetExpectedCostWithContext(spellId, context)
    -- Manual overrides take precedence
    local overrideTable = self:GetManualOverrideTable(spellId, "cost")
    if overrideTable then
        return overrideTable
    end
    local overrideValue = self:GetManualOverrideValue(spellId, "cost")
    if overrideValue ~= nil then
        return overrideValue
    end

    -- Avoid recursion: if context is provided, use it; otherwise get it safely
    if not context then
        -- Only get context if we're not already in a context-getting call
        if not self._gettingContext then
            context = self:GetCurrentContext()
        else
            -- Use safe defaults to avoid recursion
            context = {
                pvp = false,
                instanceType = "none",
                targetCount = 1,
                groupType = "solo",
                inCombat = false
            }
        end
    end
    local contextKey = getContextKey(context)

    -- Check cache with context
    local cacheKey = spellId .. "_" .. contextKey
    local cached = self:GetCachedPrediction(cacheKey, "cost")
    if cached ~= nil then
        if self.debug then
            self:Debug("💾 Cache hit for cost (context): spell %d, context %s", spellId, contextKey)
        end
        return cached
    end

    -- Get cost directly from PredictionAPI (avoid recursion by not calling GetExpectedCost)
    local cost, conf, lastSeen = PredictionAPI:GetLearnedCost(spellId)
    if cost and conf and conf >= (self.db.char.minConfidence or 0.5) and isFresh(self, lastSeen) then
        -- Cache with context key
        self:CachePrediction(cacheKey, "cost", cost)

        -- Track usage for debugging
        self.usageStats.costs[spellId] = (self.usageStats.costs[spellId] or 0) + 1

        -- Register for validation if enabled
        if self.db.char.enableValidation then
            self:RegisterPredictionForValidation(spellId, "cost", cost)
        end

        if self.debug then
            self:Debug("🔬 Using learned cost (context-aware) for spell %d: %d (confidence: %.2f)", spellId, cost, conf)
        end
        return cost
    end

    return nil
end

--- Get expected generation with context awareness
--- @param spellId number The spell ID
--- @param resourceType string|nil Resource type
--- @param context table|nil Optional context (nil = use current context)
--- @return number|table|nil Expected generation or nil
function LearnedPredictionProvider:GetExpectedGenerationWithContext(spellId, resourceType, context)
    -- Avoid recursion: if context is provided, use it; otherwise get it safely
    if not context then
        -- Only get context if we're not already in a context-getting call
        if not self._gettingContext then
            context = self:GetCurrentContext()
        else
            -- Use safe defaults to avoid recursion
            context = {
                pvp = false,
                instanceType = "none",
                targetCount = 1,
                groupType = "solo",
                inCombat = false
            }
        end
    end
    local contextKey = getContextKey(context)

    -- Check cache with context
    if resourceType then
        local cacheKey = spellId .. "_" .. contextKey
        local cached = self:GetCachedPrediction(cacheKey, "generation", resourceType)
        if cached ~= nil then
            if self.debug then
                self:Debug("💾 Cache hit for generation (context): spell %d, resource %s, context %s",
                    spellId, resourceType, contextKey)
            end
            return cached
        end
    end

    -- Get generation directly from PredictionAPI (avoid recursion by not calling GetExpectedGeneration)
    local generation, conf, lastSeen = PredictionAPI:GetLearnedGeneration(spellId)
    if generation and conf and conf >= (self.db.char.minConfidence or 0.5) and isFresh(self, lastSeen) then
        -- Cache individual resource types
        if resourceType and generation[resourceType] then
            local cacheKey = spellId .. "_" .. contextKey
            self:CachePrediction(cacheKey, "generation", generation[resourceType], resourceType)
        end

        -- Track usage for debugging
        self.usageStats.generation[spellId] = (self.usageStats.generation[spellId] or 0) + 1

        -- Register for validation if enabled
        if self.db.char.enableValidation and resourceType then
            local genValue = generation[resourceType]
            if genValue then
                self:RegisterPredictionForValidation(spellId, "generation", genValue, resourceType)
            end
        end

        if self.debug then
            local genStr = resourceType and tostring(generation[resourceType] or 0) or "multiple resources"
            self:Debug("🔬 Using learned generation (context-aware) for spell %d: %s (confidence: %.2f)", spellId, genStr, conf)
        end

        -- If resourceType specified, return that specific value
        if resourceType then
            return generation[resourceType]
        end

        -- Otherwise return the full table
        return generation
    end

    return nil
end

-- Public API (rotation-facing)

function LearnedPredictionProvider:GetExpectedCost(spellId)
    -- Manual overrides take precedence
    local overrideTable = self:GetManualOverrideTable(spellId, "cost")
    if overrideTable then
        -- Remove DEFAULT helper key for consumers expecting plain table
        local result = {}
        for resourceType, amount in pairs(overrideTable) do
            if resourceType ~= "DEFAULT" then
                result[resourceType] = amount
            end
        end
        if next(result) then
            return result
        end
        if overrideTable.DEFAULT ~= nil then
            return overrideTable.DEFAULT
        end
    end
    local overrideValue = self:GetManualOverrideValue(spellId, "cost")
    if overrideValue ~= nil then
        return overrideValue
    end

    if not (self.db.char.enabled and self.db.char.useLearnedCosts) then return nil end
    if not PredictionAPI:IsEnabled() then return nil end
    -- Use context-aware if enabled (but avoid recursion if already getting context)
    if self.db.char.useContextAware and not self._gettingContext then
        return self:GetExpectedCostWithContext(spellId)
    end

    -- Check cache first
    local cached = self:GetCachedPrediction(spellId, "cost")
    if cached ~= nil then
        if self.debug then
            self:Debug("💾 Cache hit for cost: spell %d", spellId)
        end
        return cached
    end

    local cost, conf, lastSeen = PredictionAPI:GetLearnedCost(spellId)
    if cost and conf and conf >= (self.db.char.minConfidence or 0.5) and isFresh(self, lastSeen) then
        -- Cache the result
        self:CachePrediction(spellId, "cost", cost)

        -- Track usage for debugging
        self.usageStats.costs[spellId] = (self.usageStats.costs[spellId] or 0) + 1

        -- Register for validation if enabled
        if self.db.char.enableValidation then
            self:RegisterPredictionForValidation(spellId, "cost", cost)
        end

        if self.debug then
            self:Debug("🔬 Using learned cost for spell %d: %d (confidence: %.2f)", spellId, cost, conf)
        end
        return cost
    end
    return nil
end

function LearnedPredictionProvider:GetExpectedCooldown(spellId)
    if not (self.db.char.enabled and self.db.char.useLearnedCooldowns) then return nil end
    if not PredictionAPI:IsEnabled() then return nil end
    if PredictionAPI.GetLearnedCooldown then
        local cd, conf, lastSeen = PredictionAPI:GetLearnedCooldown(spellId)
        if cd and conf and conf >= (self.db.char.minConfidence or 0.5) and isFresh(self, lastSeen) then
            -- Track usage for debugging
            self.usageStats.cooldowns[spellId] = (self.usageStats.cooldowns[spellId] or 0) + 1
            if self.debug then
                self:Debug("🔬 Using learned cooldown for spell %d: %.2fs (confidence: %.2f)", spellId, cd, conf)
            end
            return cd
        end
    end
    return nil
end

function LearnedPredictionProvider:GetExpectedAppliedBuffs(spellId)
    if not (self.db.char.enabled and self.db.char.useLearnedAuras) then return nil end
    if PredictionAPI.GetAppliedBuffs then
        local ids, conf, lastSeen = PredictionAPI:GetAppliedBuffs(spellId)
        if ids and conf and conf >= (self.db.char.minConfidence or 0.5) and isFresh(self, lastSeen) then
            if self.debug then
                self:Debug("🔬 Using learned buffs for spell %d: %d buffs (confidence: %.2f)", spellId, #ids, conf)
            end
            return ids
        end
    end
    return nil
end

function LearnedPredictionProvider:GetExpectedAppliedDebuffs(spellId)
    if not (self.db.char.enabled and self.db.char.useLearnedAuras) then return nil end
    if PredictionAPI.GetAppliedDebuffs then
        local ids, conf, lastSeen = PredictionAPI:GetAppliedDebuffs(spellId)
        if ids and conf and conf >= (self.db.char.minConfidence or 0.5) and isFresh(self, lastSeen) then
            if self.debug then
                self:Debug("🔬 Using learned debuffs for spell %d: %d debuffs (confidence: %.2f)", spellId, #ids, conf)
            end
            return ids
        end
    end
    return nil
end

--- Get expected resource generation for a spell
--- @param spellId number The spell ID
--- @param resourceType string|nil Optional resource type filter (e.g., "MANA", "ENERGY", "RAGE")
--- @return number|table|nil Generation amount for specific resource, or table of all generations, or nil
function LearnedPredictionProvider:GetExpectedGeneration(spellId, resourceType)
    if resourceType then
        local overrideValue = self:GetManualOverrideValue(spellId, "generation", resourceType)
        if overrideValue ~= nil then
            return overrideValue
        end
    else
        local overrideDefault = self:GetManualOverrideValue(spellId, "generation")
        if overrideDefault ~= nil then
            return overrideDefault
        end
        local overrideResources = self:GetManualOverrideTable(spellId, "generation")
        if overrideResources then
            return overrideResources
        end
    end

    if not (self.db.char.enabled and self.db.char.useLearnedGeneration) then return nil end
    if not PredictionAPI:IsEnabled() then return nil end

    if PredictionAPI.GetLearnedGeneration then
        -- Use context-aware if enabled (but avoid recursion if already getting context)
        if self.db.char.useContextAware and not self._gettingContext then
            return self:GetExpectedGenerationWithContext(spellId, resourceType)
        end

        -- Check cache first if resourceType is specified
        if resourceType then
            local cached = self:GetCachedPrediction(spellId, "generation", resourceType)
            if cached ~= nil then
                if self.debug then
                    self:Debug("💾 Cache hit for generation: spell %d, resource %s", spellId, resourceType)
                end
                return cached
            end
        end

        local generation, conf, lastSeen = PredictionAPI:GetLearnedGeneration(spellId)
        if generation and conf and conf >= (self.db.char.minConfidence or 0.5) and isFresh(self, lastSeen) then
            -- Cache individual resource types
            if resourceType and generation[resourceType] then
                self:CachePrediction(spellId, "generation", generation[resourceType], resourceType)
            end

            -- Track usage for debugging
            self.usageStats.generation[spellId] = (self.usageStats.generation[spellId] or 0) + 1

            -- Register for validation if enabled
            if self.db.char.enableValidation and resourceType then
                local genValue = generation[resourceType]
                if genValue then
                    self:RegisterPredictionForValidation(spellId, "generation", genValue, resourceType)
                end
            end

            if self.debug then
                local genStr = resourceType and tostring(generation[resourceType] or 0) or "multiple resources"
                self:Debug("🔬 Using learned generation for spell %d: %s (confidence: %.2f)", spellId, genStr, conf)
            end

            -- If resourceType specified, return that specific value
            if resourceType then
                return generation[resourceType]
            end

            -- Otherwise return the full table
            return generation
        end
    end
    return nil
end

-- ============================ TELEMETRY HELPERS ============================

--- Gather telemetry for cost predictions
--- @param spellId number
--- @param context table|nil
function LearnedPredictionProvider:GetCostTelemetry(spellId, context)
    local telemetry = {
        spellId = spellId,
        source = "static",
        confidence = 0,
        value = nil,
        overrideApplied = false,
    }

    if not spellId then
        telemetry.reason = "noSpellId"
        return telemetry
    end

    local overrideTable = self:GetManualOverrideTable(spellId, "cost")
    if overrideTable then
        telemetry.source = "override"
        telemetry.overrideApplied = true
        telemetry.value = overrideTable.DEFAULT or overrideTable
        telemetry.overrideTable = overrideTable
        telemetry.confidence = 1
        return telemetry
    end

    local overrideValue = self:GetManualOverrideValue(spellId, "cost")
    if overrideValue ~= nil then
        telemetry.source = "override"
        telemetry.overrideApplied = true
        telemetry.value = overrideValue
        telemetry.confidence = 1
        return telemetry
    end

    if not (self.db.char.enabled and self.db.char.useLearnedCosts) or not PredictionAPI:IsEnabled() then
        telemetry.reason = "disabled"
        return telemetry
    end

    local contextUsed = context
    if self.db.char.useContextAware and not contextUsed then
        if not self._gettingContext then
            contextUsed = self:GetCurrentContext()
        end
    end
    telemetry.contextUsed = contextUsed

    if self.db.char.useContextAware and contextUsed then
        local bucketKey, bucketMeta = self:GetBucketKeyForContext(contextUsed)
        telemetry.bucketKey = bucketKey
        telemetry.bucketMeta = bucketMeta
        local bucket = self:GetBucketForSpell(spellId, bucketKey)
        if bucket then
            telemetry.bucketSamples = bucket.samples or 0
            telemetry.bucketLastUpdated = bucket.lastUpdated or 0
            telemetry.freshnessOk = isFresh(self, bucket.lastUpdated)
        end
    end

    local cost, confidence = PredictionAPI:GetLearnedCost(spellId)
    telemetry.learnedValue = cost
    telemetry.confidence = confidence or 0

    local minConfidence = self.db.char.minConfidence or 0.5
    local freshnessRequired = self.db.char.freshnessSeconds or 0
    local freshnessSatisfied = telemetry.freshnessOk
    if freshnessRequired == 0 then
        freshnessSatisfied = true
    elseif not self.db.char.useContextAware then
        local deltaData = self.latestSpellDeltas[spellId]
        if deltaData and deltaData.timestamp then
            freshnessSatisfied = isFresh(self, deltaData.timestamp)
        else
            freshnessSatisfied = true
        end
    end
    telemetry.freshnessOk = freshnessSatisfied

    if cost and confidence and confidence >= minConfidence and freshnessSatisfied then
        telemetry.source = "learned"
        telemetry.value = cost
    else
        telemetry.source = "static"
        if cost then
            telemetry.reason = (confidence or 0) < minConfidence and "lowConfidence" or "stale"
        else
            telemetry.reason = "noLearnedData"
        end
    end

    return telemetry
end

--- Gather telemetry for generation predictions
--- @param spellId number
--- @param resourceType string|nil
--- @param context table|nil
function LearnedPredictionProvider:GetGenerationTelemetry(spellId, resourceType, context)
    local telemetry = {
        spellId = spellId,
        resourceType = resourceType,
        source = "static",
        confidence = 0,
        value = nil,
        overrideApplied = false,
    }

    if not spellId then
        telemetry.reason = "noSpellId"
        return telemetry
    end

    local overrideValue = self:GetManualOverrideValue(spellId, "generation", resourceType)
    if overrideValue ~= nil then
        telemetry.source = "override"
        telemetry.overrideApplied = true
        telemetry.value = overrideValue
        telemetry.confidence = 1
        return telemetry
    end

    if resourceType == nil then
        local overrideTable = self:GetManualOverrideTable(spellId, "generation")
        if overrideTable then
            telemetry.source = "override"
            telemetry.overrideApplied = true
            telemetry.value = overrideTable
            telemetry.confidence = 1
            return telemetry
        end
    end

    if not (self.db.char.enabled and self.db.char.useLearnedGeneration) or not PredictionAPI:IsEnabled() then
        telemetry.reason = "disabled"
        return telemetry
    end

    local generation, confidence, lastSeen = PredictionAPI:GetLearnedGeneration(spellId)
    telemetry.learnedValue = generation
    telemetry.confidence = confidence or 0
    telemetry.lastSeen = lastSeen

    local minConfidence = self.db.char.minConfidence or 0.5
    local freshnessRequired = self.db.char.freshnessSeconds or 0
    local freshnessSatisfied = freshnessRequired == 0
    if not freshnessSatisfied and lastSeen then
        freshnessSatisfied = isFresh(self, lastSeen)
    end
    telemetry.freshnessOk = freshnessSatisfied

    if generation and confidence and confidence >= minConfidence and freshnessSatisfied then
        telemetry.source = "learned"
        if resourceType then
            telemetry.value = generation[resourceType]
        else
            telemetry.value = generation
        end
    else
        telemetry.source = "static"
        if generation then
            telemetry.reason = (confidence or 0) < minConfidence and "lowConfidence" or "stale"
        else
            telemetry.reason = "noLearnedData"
        end
    end

    return telemetry
end

-- ============================ MULTI-SPELL SEQUENCE PREDICTIONS ============================

--- Predict resource value after casting a sequence of spells
--- @param time number Time in seconds to predict for
--- @param resourceType number Resource type (e.g., Enum.PowerType.Mana)
--- @param spellSequence table Array of spell IDs to cast in sequence
--- @param context table|nil Optional context for context-aware predictions
--- @return number Predicted resource value after sequence
function LearnedPredictionProvider:PredictResourceAfterSequence(time, resourceType, spellSequence, context)
    if not spellSequence or type(spellSequence) ~= "table" or #spellSequence == 0 then
        return NAG:PredictResourceValue(time, resourceType)
    end

    -- Start with base prediction
    local predictedResource = NAG:PredictResourceValue(time, resourceType)

    -- Get resource type name for lookup
    local resourceTypeName = nil
    local Version = ns.Version
    if Version:IsRetail() then
        if resourceType == Enum.PowerType.Mana then
            resourceTypeName = "MANA"
        elseif resourceType == Enum.PowerType.Energy then
            resourceTypeName = "ENERGY"
        elseif resourceType == Enum.PowerType.Rage then
            resourceTypeName = "RAGE"
        elseif resourceType == Enum.PowerType.RunicPower then
            resourceTypeName = "RUNIC_POWER"
        elseif resourceType == Enum.PowerType.Focus then
            resourceTypeName = "FOCUS"
        end
    else
        if resourceType == 0 then
            resourceTypeName = "MANA"
        elseif resourceType == 1 then
            resourceTypeName = "RAGE"
        elseif resourceType == 3 then
            resourceTypeName = "ENERGY"
        elseif resourceType == 2 then
            resourceTypeName = "FOCUS"
        elseif resourceType == 6 then
            resourceTypeName = "RUNIC_POWER"
        end
    end

    if not resourceTypeName then
        return predictedResource
    end

    -- Calculate net resource change for the sequence
    local netChange = 0

    for _, spellId in ipairs(spellSequence) do
        -- Get cost (negative)
        local cost = nil
        if self.db.char.useLearnedCosts then
            cost = context and self:GetExpectedCostWithContext(spellId, context) or self:GetExpectedCost(spellId)
        end

        if not cost then
            -- Fallback to static cost
            local costTable = NAG:GetModifiedSpellPowerCost(spellId)
            if costTable then
                for _, v in ipairs(costTable) do
                    if v.type == resourceType then
                        cost = max(v.minCost or v.cost or 0, 0)
                        break
                    end
                end
            end
        end

        if cost then
            netChange = netChange - cost
        end

        -- Get generation (positive)
        local generation = nil
        if self.db.char.useLearnedGeneration then
            generation = context and self:GetExpectedGenerationWithContext(spellId, resourceTypeName, context)
                or self:GetExpectedGeneration(spellId, resourceTypeName)
        end

        if generation and type(generation) == "number" and generation > 0 then
            netChange = netChange + generation
        end
    end

    -- Apply net change to predicted resource
    predictedResource = predictedResource + netChange

    -- Cap at max resource
    local maxResource = UnitPowerMax("player", resourceType)
    predictedResource = min(predictedResource, maxResource)

    if self.debug then
        self:Debug("🔮 Sequence prediction: %d spells, net change: %d, final resource: %d",
            #spellSequence, netChange, predictedResource)
    end

    return max(predictedResource, 0)
end

--- Get total cost for a sequence of spells
--- @param spellSequence table Array of spell IDs
--- @param resourceType number Resource type
--- @param context table|nil Optional context
--- @return number Total cost for the sequence
function LearnedPredictionProvider:GetSequenceCost(spellSequence, resourceType, context)
    if not spellSequence or type(spellSequence) ~= "table" then
        return 0
    end

    local totalCost = 0

    for _, spellId in ipairs(spellSequence) do
        local cost = nil
        if self.db.char.useLearnedCosts then
            cost = context and self:GetExpectedCostWithContext(spellId, context) or self:GetExpectedCost(spellId)
        end

        if not cost then
            -- Fallback to static cost
            local costTable = NAG:GetModifiedSpellPowerCost(spellId)
            if costTable then
                for _, v in ipairs(costTable) do
                    if v.type == resourceType then
                        cost = max(v.minCost or v.cost or 0, 0)
                        break
                    end
                end
            end
        end

        if cost then
            totalCost = totalCost + cost
        end
    end

    return totalCost
end

--- Get total generation for a sequence of spells
--- @param spellSequence table Array of spell IDs
--- @param resourceType string Resource type name (e.g., "MANA", "ENERGY")
--- @param context table|nil Optional context
--- @return number Total generation for the sequence
function LearnedPredictionProvider:GetSequenceGeneration(spellSequence, resourceType, context)
    if not spellSequence or type(spellSequence) ~= "table" then
        return 0
    end

    local totalGeneration = 0

    for _, spellId in ipairs(spellSequence) do
        local generation = nil
        if self.db.char.useLearnedGeneration then
            generation = context and self:GetExpectedGenerationWithContext(spellId, resourceType, context)
                or self:GetExpectedGeneration(spellId, resourceType)
        end

        if generation and type(generation) == "number" and generation > 0 then
            totalGeneration = totalGeneration + generation
        end
    end

    return totalGeneration
end

-- ============================ PREDICTION VALIDATION ============================

--- Register a prediction for validation when spell is cast
--- @param spellId number The spell ID
--- @param predictionType string Type of prediction ("cost", "generation", "cooldown")
--- @param predictedValue number The predicted value
--- @param resourceType string|nil Optional resource type for generation predictions
function LearnedPredictionProvider:RegisterPredictionForValidation(spellId, predictionType, predictedValue, resourceType)
    if not self.db.char.enableValidation then return end

    if not self.pendingValidations[spellId] then
        self.pendingValidations[spellId] = {}
    end

    self.pendingValidations[spellId][predictionType] = {
        predicted = predictedValue,
        timestamp = GetTime(),
        resourceType = resourceType
    }

    if self.debug then
        self:Debug("📝 Registered prediction for validation: spell %d, type %s, value %s",
            spellId, predictionType, tostring(predictedValue))
    end
end

--- Validate predictions when spell is cast
--- @param event string Event name
--- @param unit string Unit that cast the spell
--- @param castGUID string Cast GUID
--- @param spellId number The spell ID that was cast
function LearnedPredictionProvider:UNIT_SPELLCAST_SUCCEEDED(event, unit, castGUID, spellId)
    if not self.db.char.enableValidation then return end
    if unit ~= "player" then return end
    if not spellId then return end

    local pending = self.pendingValidations[spellId]
    if not pending or not next(pending) then return end

    -- Validate each pending prediction
    for predictionType, predictionData in pairs(pending) do
        local timeSince = GetTime() - predictionData.timestamp
        if timeSince <= self.db.char.validationWindow then
            self:ValidatePrediction(spellId, predictionType, predictionData)
        end
    end

    -- Clear pending validations for this spell
    self.pendingValidations[spellId] = nil
end

--- Validate a single prediction against actual result
--- @param spellId number The spell ID
--- @param predictionType string Type of prediction
--- @param predictionData table Prediction data {predicted, timestamp, resourceType}
function LearnedPredictionProvider:ValidatePrediction(spellId, predictionType, predictionData)
    local predicted = predictionData.predicted
    local actual = nil
    local tolerance = 0.1 -- 10% tolerance for validation

    if predictionType == "cost" then
        -- Get actual cost from StateManager or resource change
        -- For now, we'll use SpellAnalyzer data if available
        -- This is a simplified version - could be enhanced with actual state comparison
        actual = self:GetActualCost(spellId)
    elseif predictionType == "generation" then
        -- Get actual generation from resource change
        actual = self:GetActualGeneration(spellId, predictionData.resourceType)
    elseif predictionType == "cooldown" then
        -- Get actual cooldown duration
        actual = self:GetActualCooldown(spellId)
    end

    if actual == nil then
        if self.debug then
            self:Debug("⚠️ Could not validate prediction for spell %d, type %s: actual value unavailable",
                spellId, predictionType)
        end
        return
    end

    -- Calculate error
    local error = abs(actual - predicted)
    local relativeError = predicted > 0 and (error / predicted) or error
    local isCorrect = relativeError <= tolerance

    -- Update accuracy statistics
    self:UpdateAccuracyStats(spellId, predictionType, isCorrect, error, relativeError)

    if self.debug then
        local status = isCorrect and "✓" or "✗"
        self:Debug("%s Validation: spell %d, type %s - Predicted: %s, Actual: %s, Error: %.2f (%.1f%%)",
            status, spellId, predictionType, tostring(predicted), tostring(actual), error, relativeError * 100)
    end
end

--- Get actual cost for a spell from latest delta data
--- @param spellId number The spell ID
--- @return number|nil Actual cost or nil if unavailable
function LearnedPredictionProvider:GetActualCost(spellId)
    local delta = self.latestSpellDeltas[spellId]
    if not delta or not delta.cost then return nil end

    -- Get the first cost value found (simplified - could be enhanced to match resource type)
    if delta.cost.resources then
        for _, costValue in pairs(delta.cost.resources) do
            if type(costValue) == "number" and costValue > 0 then
                return costValue
            end
        end
    end

    return nil
end

--- Get actual generation for a spell from latest delta data
--- @param spellId number The spell ID
--- @param resourceType string|nil Resource type (e.g., "MANA", "ENERGY")
--- @return number|nil Actual generation or nil if unavailable
function LearnedPredictionProvider:GetActualGeneration(spellId, resourceType)
    local delta = self.latestSpellDeltas[spellId]
    if not delta or not delta.generates then return nil end

    -- Try to find generation for the specified resource type
    if resourceType and delta.generates.resources then
        local genValue = delta.generates.resources[resourceType]
        if type(genValue) == "number" and genValue > 0 then
            return genValue
        end
    end

    -- Fallback: get first generation value found
    if delta.generates.resources then
        for _, genValue in pairs(delta.generates.resources) do
            if type(genValue) == "number" and genValue > 0 then
                return genValue
            end
        end
    end

    return nil
end

--- Get actual cooldown duration for a spell
--- @param spellId number The spell ID
--- @return number|nil Actual cooldown or nil if unavailable
function LearnedPredictionProvider:GetActualCooldown(spellId)
    local cdInfo = WoWAPI.GetSpellCooldown(spellId)
    if cdInfo and cdInfo.duration and cdInfo.duration > 0 then
        return cdInfo.duration
    end
    return nil
end

--- Update accuracy statistics for a prediction
--- @param spellId number The spell ID
--- @param predictionType string Type of prediction
--- @param isCorrect boolean Whether prediction was correct
--- @param error number Absolute error
--- @param relativeError number Relative error (0-1)
function LearnedPredictionProvider:UpdateAccuracyStats(spellId, predictionType, isCorrect, error, relativeError)
    if not self.db.char.accuracyStats then
        self.db.char.accuracyStats = {}
    end

    if not self.db.char.accuracyStats[spellId] then
        self.db.char.accuracyStats[spellId] = {}
    end

    if not self.db.char.accuracyStats[spellId][predictionType] then
        self.db.char.accuracyStats[spellId][predictionType] = {
            total = 0,
            correct = 0,
            accuracy = 0.0,
            avgError = 0.0,
            totalError = 0.0
        }
    end

    local stats = self.db.char.accuracyStats[spellId][predictionType]
    stats.total = stats.total + 1
    if isCorrect then
        stats.correct = stats.correct + 1
    end

    -- Calculate accuracy
    stats.accuracy = stats.correct / stats.total

    -- Calculate average error
    stats.totalError = stats.totalError + relativeError
    stats.avgError = stats.totalError / stats.total

    -- Auto-adjust confidence if enabled
    if self.db.char.autoAdjustConfidence then
        self:AdjustConfidenceBasedOnAccuracy(spellId, predictionType, stats.accuracy)
    end
end

--- Adjust confidence based on accuracy
--- @param spellId number The spell ID
--- @param predictionType string Type of prediction
--- @param accuracy number Current accuracy (0-1)
function LearnedPredictionProvider:AdjustConfidenceBasedOnAccuracy(spellId, predictionType, accuracy)
    -- If accuracy is below threshold, we could reduce confidence
    -- This is a placeholder - full implementation would modify PredictionAPI confidence
    if accuracy < self.db.char.accuracyThreshold then
        if self.debug then
            self:Debug("⚠️ Low accuracy (%.2f) for spell %d, type %s - consider reducing confidence",
                accuracy, spellId, predictionType)
        end
    end
end

--- Print cache statistics
function LearnedPredictionProvider:PrintCacheStats()
    local stats = self.cacheStats
    local total = stats.hits + stats.misses
    local hitRate = total > 0 and (stats.hits / total * 100) or 0

    self:Info("=== Prediction Cache Stats ===")
    self:Info("Cache enabled: %s", self.db.char.enableCache and "Yes" or "No")
    self:Info("Cache TTL: %.1f seconds", self.db.char.cacheTTL or 5.0)
    self:Info("Cache hits: %d", stats.hits)
    self:Info("Cache misses: %d", stats.misses)
    self:Info("Cache evictions: %d", stats.evictions)
    self:Info("Hit rate: %.1f%%", hitRate)

    -- Count cached entries
    local cachedCount = 0
    for _, cache in pairs(self.cache) do
        for _ in pairs(cache) do
            cachedCount = cachedCount + 1
        end
    end
    self:Info("Cached entries: %d", cachedCount)
end

--- Print accuracy statistics
function LearnedPredictionProvider:PrintAccuracyStats()
    local stats = self.db.char.accuracyStats
    if not stats or not next(stats) then
        self:Info("=== Prediction Accuracy Stats ===")
        self:Info("No accuracy data available yet")
        return
    end

    self:Info("=== Prediction Accuracy Stats ===")

    local spellCount = 0
    for _ in pairs(stats) do spellCount = spellCount + 1 end
    self:Info("Spells with accuracy data: %d", spellCount)

    for spellId, spellStats in pairs(stats) do
        local spellInfo = WoWAPI.GetSpellInfo(spellId)
        local name = spellInfo and spellInfo.name or tostring(spellId)
        self:Info("")
        self:Info("  %s (%d):", name, spellId)

        for predType, predStats in pairs(spellStats) do
            local accuracyPercent = predStats.accuracy * 100
            local avgErrorPercent = predStats.avgError * 100
            self:Info("    %s: %d/%d correct (%.1f%% accuracy, %.1f%% avg error)",
                predType, predStats.correct, predStats.total, accuracyPercent, avgErrorPercent)
        end
    end
end

--- Get usage statistics for debugging
--- @return table Usage stats {costs = {[spellId] = count}, cooldowns = {[spellId] = count}, generation = {[spellId] = count}}
function LearnedPredictionProvider:GetUsageStats()
    return self.usageStats
end

--- Print usage statistics summary
function LearnedPredictionProvider:PrintUsageStats()
    local stats = self.usageStats
    local costCount = 0
    local cdCount = 0
    local genCount = 0

    for _ in pairs(stats.costs) do costCount = costCount + 1 end
    for _ in pairs(stats.cooldowns) do cdCount = cdCount + 1 end
    for _ in pairs(stats.generation) do genCount = genCount + 1 end

    self:Info("=== Learned Prediction Usage Stats ===")
    self:Info("Spells using learned costs: %d", costCount)
    self:Info("Spells using learned cooldowns: %d", cdCount)
    self:Info("Spells using learned generation: %d", genCount)

    if costCount > 0 then
        self:Info("Costs by spell:")
        for spellId, count in pairs(stats.costs) do
            local spellInfo = WoWAPI.GetSpellInfo(spellId)
            local name = spellInfo and spellInfo.name or tostring(spellId)
            self:Info("  %s (%d): %d uses", name, spellId, count)
        end
    end

    if cdCount > 0 then
        self:Info("Cooldowns by spell:")
        for spellId, count in pairs(stats.cooldowns) do
            local spellInfo = WoWAPI.GetSpellInfo(spellId)
            local name = spellInfo and spellInfo.name or tostring(spellId)
            self:Info("  %s (%d): %d uses", name, spellId, count)
        end
    end

    if genCount > 0 then
        self:Info("Generation by spell:")
        for spellId, count in pairs(stats.generation) do
            local spellInfo = WoWAPI.GetSpellInfo(spellId)
            local name = spellInfo and spellInfo.name or tostring(spellId)
            self:Info("  %s (%d): %d uses", name, spellId, count)
        end
    end
end

--- Print data info (slash command handler)
function LearnedPredictionProvider:PrintDataInfo()
    self:Info("=== Learned Prediction Data Info ===")
    self:Info(self:GetDataSummary())
    self:Info("Use '/nag learned prune' to remove stale data")
    self:Info("Use '/nag learned clear' to remove ALL data")
end

--- Prune stale data (slash command handler)
function LearnedPredictionProvider:PruneStaleDataCommand()
    local beforeStats = self:GetDataStatistics()
    local pruned = self:PruneStaleData(30, 3)
    local afterStats = self:GetDataStatistics()

    self:Info("=== Pruned Learned Prediction Data ===")
    self:Info("Removed %d stale buckets", pruned)
    self:Info("Before: %d spells, %d buckets", beforeStats.totalSpells, beforeStats.totalBuckets)
    self:Info("After: %d spells, %d buckets", afterStats.totalSpells, afterStats.totalBuckets)
end

--- Clear all data (slash command handler)
function LearnedPredictionProvider:ClearAllDataCommand()
    local beforeStats = self:GetDataStatistics()
    self:ResetLearnedData()

    self:Info("=== Cleared ALL Learned Prediction Data ===")
    self:Info("Removed %d spells and %d buckets", beforeStats.totalSpells, beforeStats.totalBuckets)
end

-- ============================ OPTIONS COMPOSITION ============================

--- Compose Prediction Queue options for Features category
--- @param options table The options structure to inject into
--- @param context table Optional context information
--- @return table Modified options structure
function LearnedPredictionProvider:composePredictionQueueOptions(options, context)
    if not options.args then options.args = {} end
    if not options.args.predictionQueue then
        options.args.predictionQueue = {
            type = "group",
            name = L["predictionQueue"] or "Prediction Queue",
            order = 90,  -- Near end of features
            hidden = function() return not (NAG and NAG.IsDevModeEnabled and NAG:IsDevModeEnabled()) end,
            args = {}
        }
    end

    local queueArgs = options.args.predictionQueue.args

    queueArgs.enabled = OptionsFactory:CreateToggle(L["enabled"] or "Enable", L["enabledDesc"] or "Enable or disable this module/feature",
        function() return self:GetSetting("char", "enabled") end,
        function(_, v) self:SetSetting("char", "enabled", v) end,
        { order = 1 }
    )

    queueArgs.useLearnedUnified = OptionsFactory:CreateToggle(
        "Use Learned Generation's (Experimental)",
        "Enable learned costs, cooldowns, auras, and generation in predictions (experimental).",
        function()
            return self:GetSetting("char", "useLearnedCosts")
                and self:GetSetting("char", "useLearnedCooldowns")
                and self:GetSetting("char", "useLearnedAuras")
                and self:GetSetting("char", "useLearnedGeneration")
        end,
        function(_, v)
            self:SetSetting("char", "useLearnedCosts", v)
            self:SetSetting("char", "useLearnedCooldowns", v)
            self:SetSetting("char", "useLearnedAuras", v)
            self:SetSetting("char", "useLearnedGeneration", v)
        end,
        { order = 2 }
    )

    queueArgs.minConfidence = OptionsFactory:CreateRange(L["minConfidence"] or "Minimum Confidence", L["minConfidenceDesc"] or "Only use learned data when confidence is above this threshold",
        function() return self:GetSetting("char", "minConfidence") end,
        function(_, v) self:SetSetting("char", "minConfidence", v) end,
        { order = 6, min = 0.0, max = 1.0, step = 0.05 }
    )

    queueArgs.freshnessSeconds = OptionsFactory:CreateRange(L["freshnessSeconds"] or "Freshness (seconds)", L["freshnessSecondsDesc"] or "Ignore data older than this duration",
        function() return self:GetSetting("char", "freshnessSeconds") end,
        function(_, v) self:SetSetting("char", "freshnessSeconds", v) end,
        { order = 7, min = 0, max = 7200, step = 60 }
    )

    queueArgs.showUsageStats = OptionsFactory:CreateExecute(L["showUsageStats"] or "Show Usage Stats", L["showUsageStatsDesc"] or "Print learned prediction usage statistics",
        function()
            self:PrintUsageStats()
        end,
        { order = 10 }
    )

    queueArgs.showAccuracyStats = OptionsFactory:CreateExecute(
        "Show Accuracy Stats",
        "Print prediction accuracy statistics",
        function()
            self:PrintAccuracyStats()
        end,
        { order = 11 }
    )

    queueArgs.enableValidation = OptionsFactory:CreateToggle(
        "Enable Validation",
        "Track and validate prediction accuracy",
        function() return self:GetSetting("char", "enableValidation") end,
        function(_, v) self:SetSetting("char", "enableValidation", v) end,
        { order = 20 }
    )

    queueArgs.autoAdjustConfidence = OptionsFactory:CreateToggle(
        "Auto-Adjust Confidence",
        "Automatically adjust confidence based on accuracy",
        function() return self:GetSetting("char", "autoAdjustConfidence") end,
        function(_, v) self:SetSetting("char", "autoAdjustConfidence", v) end,
        { order = 21 }
    )

    queueArgs.accuracyThreshold = OptionsFactory:CreateRange(
        "Accuracy Threshold",
        "Minimum accuracy to maintain confidence",
        function() return self:GetSetting("char", "accuracyThreshold") end,
        function(_, v) self:SetSetting("char", "accuracyThreshold", v) end,
        { order = 22, min = 0.0, max = 1.0, step = 0.05 }
    )

    queueArgs.enableCache = OptionsFactory:CreateToggle(
        "Enable Cache",
        "Cache predictions for faster access",
        function() return self:GetSetting("char", "enableCache") end,
        function(_, v) self:SetSetting("char", "enableCache", v) end,
        { order = 30 }
    )

    queueArgs.cacheTTL = OptionsFactory:CreateRange(
        "Cache TTL (seconds)",
        "How long to cache predictions",
        function() return self:GetSetting("char", "cacheTTL") end,
        function(_, v) self:SetSetting("char", "cacheTTL", v) end,
        { order = 31, min = 1.0, max = 60.0, step = 1.0 }
    )

    queueArgs.showCacheStats = OptionsFactory:CreateExecute(
        "Show Cache Stats",
        "Print cache performance statistics",
        function()
            self:PrintCacheStats()
        end,
        { order = 32 }
    )

    queueArgs.useContextAware = OptionsFactory:CreateToggle(
        "Use Context-Aware",
        "Use context-aware predictions (PvP/PvE, ST/AoE)",
        function() return self:GetSetting("char", "useContextAware") end,
        function(_, v) self:SetSetting("char", "useContextAware", v) end,
        { order = 40 }
    )

    queueArgs.showContext = OptionsFactory:CreateExecute(
        "Show Current Context",
        "Print current game context",
        function()
            local context = self:GetCurrentContext()
            self:Info("=== Current Game Context ===")
            self:Info("PvP: %s", context.pvp and "Yes" or "No")
            self:Info("Instance Type: %s", context.instanceType)
            self:Info("Target Count: %d", context.targetCount)
            self:Info("Group Type: %s", context.groupType)
            self:Info("In Combat: %s", context.inCombat and "Yes" or "No")
        end,
        { order = 41 }
    )

    if NAG and NAG.IsDevModeEnabled and NAG:IsDevModeEnabled() then
        queueArgs.maintenanceNote = OptionsFactory:CreateDescription(
            "Maintenance and overrides now live under Learned Predictions → Maintenance. Use that section to manage overrides, resets, and telemetry.",
            nil,
            { order = 60, width = "full" }
        )
    end

    return options
end

-- ============================ OPTIONS UI ============================

-- Options UI
function LearnedPredictionProvider:GetOptions()
    local options = {
        type = "group",
        name = L["Learned Prediction"] or "Learned Prediction",
        order = 1,
        hidden = function() return not (NAG and NAG.IsDevModeEnabled and NAG:IsDevModeEnabled()) end,
        args = {
            enabled = OptionsFactory:CreateToggle(L["enabled"] or "Enabled", L["enabledDesc"] or "Enable or disable this module/feature",
                function() return self:GetSetting("char", "enabled") end,
                function(_, v) self:SetSetting("char", "enabled", v) end,
                { order = 1 }
            ),
            minConfidence = OptionsFactory:CreateRange(L["minConfidence"] or "Minimum Confidence", L["minConfidenceDesc"] or "Only use learned data when confidence is above this threshold",
                function() return self:GetSetting("char", "minConfidence") end,
                function(_, v) self:SetSetting("char", "minConfidence", v) end,
                { order = 2, min = 0.0, max = 1.0, step = 0.05 }
            ),
            freshnessSeconds = OptionsFactory:CreateRange(L["freshnessSeconds"] or "Freshness (seconds)", L["freshnessSecondsDesc"] or "Ignore data older than this duration",
                function() return self:GetSetting("char", "freshnessSeconds") end,
                function(_, v) self:SetSetting("char", "freshnessSeconds", v) end,
                { order = 3, min = 0, max = 7200, step = 60 }
            ),
            useLearnedCosts = OptionsFactory:CreateToggle(L["useLearnedCosts"] or "Use Learned Costs", L["useLearnedCostsDesc"] or "Replace static costs when confident",
                function() return self:GetSetting("char", "useLearnedCosts") end,
                function(_, v) self:SetSetting("char", "useLearnedCosts", v) end,
                { order = 4 }
            ),
            useLearnedCooldowns = OptionsFactory:CreateToggle(L["useLearnedCooldowns"] or "Use Learned Cooldowns", L["useLearnedCooldownsDesc"] or "Replace static cooldowns when confident",
                function() return self:GetSetting("char", "useLearnedCooldowns") end,
                function(_, v) self:SetSetting("char", "useLearnedCooldowns", v) end,
                { order = 5 }
            ),
            useLearnedAuras = OptionsFactory:CreateToggle(L["useLearnedAuras"] or "Use Learned Auras", L["useLearnedAurasDesc"] or "Incorporate learned aura applications",
                function() return self:GetSetting("char", "useLearnedAuras") end,
                function(_, v) self:SetSetting("char", "useLearnedAuras", v) end,
                { order = 6 }
            ),
            useLearnedGeneration = OptionsFactory:CreateToggle(
                "Use Learned Generation",
                "Replace static resource generation when confident",
                function() return self:GetSetting("char", "useLearnedGeneration") end,
                function(_, v) self:SetSetting("char", "useLearnedGeneration", v) end,
                { order = 7 }
            ),
            showUsageStats = OptionsFactory:CreateExecute(L["showUsageStats"] or "Show Usage Stats", L["showUsageStatsDesc"] or "Print learned prediction usage statistics",
                function()
                    self:PrintUsageStats()
                end,
                { order = 10 }
            ),
        }
    }

    if NAG and NAG.IsDevModeEnabled and NAG:IsDevModeEnabled() then
        self:AppendMaintenanceOptions(options.args, 60)
    end
    return options
end


