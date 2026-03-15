--- @module "ASTCache"
--- AST caching system for performance optimization
--- Caches parsed AST by rotation string hash to avoid redundant parsing
--- License: CC BY-NC 4.0
--- Authors: Rakizi

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local ASTCore = ns.ASTCore
local TableUtils = ns.TableUtils

--- @class ASTCache
local ASTCache = {}
ns.ASTCache = ASTCache

-- ============================ CACHE STORAGE ============================

--- Cache structure
--- @type table<string, {ast: ASTNode, timestamp: number, hits: number}>
local cache = {}

--- Cache statistics
local stats = {
    hits = 0,
    misses = 0,
    evictions = 0,
    totalSize = 0,
}

--- Maximum cache size (number of entries)
local MAX_CACHE_SIZE = 50

--- Sequential ID for cache clone metadata
local cloneSequence = 0

local function NextCloneId()
    cloneSequence = cloneSequence + 1
    return cloneSequence
end

local function AnnotateClone(clone, key)
    if type(clone) ~= "table" then
        return clone
    end

    clone.__cacheCloneId = NextCloneId()
    clone.__cacheSourceKey = key

    return clone
end

local function ApplyReadOnlyGuard(node, key)
    if type(node) ~= "table" then
        return node
    end

    if not (NAG and NAG.IsDevModeEnabled and NAG:IsDevModeEnabled()) then
        return node
    end

    local existingMeta = getmetatable(node)
    if existingMeta and existingMeta.__nagReadOnlyGuard then
        return node
    end

    local guardMeta = {}
    if existingMeta then
        for k, v in pairs(existingMeta) do
            if k ~= "__newindex" then
                guardMeta[k] = v
            end
        end
    end

    guardMeta.__index = (existingMeta and (existingMeta.__index or existingMeta)) or nil
    guardMeta.__newindex = function(_, field, value)
        NAG:Error("ASTCache: Read-only AST mutation detected (key=%s, field=%s, value=%s)", tostring(key),
            tostring(field), tostring(value))
        rawset(node, field, value)
    end
    guardMeta.__nagReadOnlyGuard = true

    setmetatable(node, guardMeta)
    return node
end

local function SanitizeCachedNode(node)
    if type(node) ~= "table" then
        return node
    end

    node.__cacheCloneId = nil
    node.__cacheSourceKey = nil

    return node
end

-- ============================ CACHE OPERATIONS ============================

--- Generate a cache key from rotation string
--- @param rotationString string Rotation string
--- @return string Cache key (hash)
function ASTCache.GenerateKey(rotationString)
    if not rotationString or rotationString == "" then
        return ""
    end

    -- Simple hash function (FNV-1a)
    local hash = 2166136261
    for i = 1, #rotationString do
        hash = bit.bxor(hash, rotationString:byte(i))
        hash = (hash * 16777619) % 4294967296
    end

    return tostring(hash)
end

--- Get AST from cache
--- @param rotationString string Rotation string
--- @return ASTNode|nil Cached AST or nil if not found
function ASTCache.Get(rotationString)
    local key = ASTCache.GenerateKey(rotationString)
    local entry = cache[key]

    if entry then
        -- Update hit count and timestamp
        entry.hits = entry.hits + 1
        entry.timestamp = time()
        stats.hits = stats.hits + 1

        -- Return a clone to prevent mutation of cached AST
        local clone = entry.ast:clone()
        return AnnotateClone(clone, key)
    end

    stats.misses = stats.misses + 1
    return nil
end

--- Get AST from cache without cloning (read-only access)
--- @param rotationString string Rotation string
--- @return ASTNode|nil Cached AST or nil if not found
function ASTCache.GetReadOnly(rotationString)
    local key = ASTCache.GenerateKey(rotationString)
    local entry = cache[key]

    if entry then
        -- Update hit count and timestamp
        entry.hits = entry.hits + 1
        entry.timestamp = time()
        stats.hits = stats.hits + 1

        return ApplyReadOnlyGuard(entry.ast, key)
    end

    stats.misses = stats.misses + 1
    return nil
end

--- Put AST into cache
--- @param rotationString string Rotation string
--- @param ast ASTNode AST to cache
function ASTCache.Put(rotationString, ast)
    if not rotationString or not ast then
        return
    end

    -- Check cache size and evict if necessary
    if TableUtils.Size(cache) >= MAX_CACHE_SIZE then
        ASTCache.EvictLRU()
    end

    local key = ASTCache.GenerateKey(rotationString)

    -- Store clone to prevent external mutation
    cache[key] = {
        ast = SanitizeCachedNode(ast:clone()),
        timestamp = time(),
        hits = 0,
        rotationString = rotationString, -- For debugging
    }

    stats.totalSize = TableUtils.Size(cache)
end

--- Evict least recently used entry
function ASTCache.EvictLRU()
    local oldestKey = nil
    local oldestTimestamp = math.huge

    for key, entry in pairs(cache) do
        if entry.timestamp < oldestTimestamp then
            oldestTimestamp = entry.timestamp
            oldestKey = key
        end
    end

    if oldestKey then
        cache[oldestKey] = nil
        stats.evictions = stats.evictions + 1
        stats.totalSize = TableUtils.Size(cache)
    end
end

--- Invalidate cache entry
--- @param rotationString string Rotation string
function ASTCache.Invalidate(rotationString)
    local key = ASTCache.GenerateKey(rotationString)
    if cache[key] then
        cache[key] = nil
        stats.totalSize = TableUtils.Size(cache)
    end
end

--- Clear entire cache
function ASTCache.Clear()
    cache = {}
    stats.totalSize = 0
end

--- Get cache statistics
--- @return table Statistics
function ASTCache.GetStatistics()
    return {
        hits = stats.hits,
        misses = stats.misses,
        evictions = stats.evictions,
        totalSize = stats.totalSize,
        maxSize = MAX_CACHE_SIZE,
        hitRate = stats.hits + stats.misses > 0 and (stats.hits / (stats.hits + stats.misses) * 100) or 0,
    }
end

--- Reset cache statistics
function ASTCache.ResetStatistics()
    stats.hits = 0
    stats.misses = 0
    stats.evictions = 0
end

--- Set maximum cache size
--- @param maxSize number Maximum number of entries
function ASTCache.SetMaxSize(maxSize)
    if maxSize and maxSize > 0 then
        MAX_CACHE_SIZE = maxSize

        -- Evict entries if we're over the new limit
        while TableUtils.Size(cache) > MAX_CACHE_SIZE do
            ASTCache.EvictLRU()
        end
    end
end

--- Get all cache entries (for debugging)
--- @return table Map of cache keys to entries
function ASTCache.GetAllEntries()
    local entries = {}
    for key, entry in pairs(cache) do
        entries[key] = {
            hits = entry.hits,
            timestamp = entry.timestamp,
            rotationStringLength = entry.rotationString and #entry.rotationString or 0,
            -- Don't include full AST to avoid huge output
        }
    end
    return entries
end

return ASTCache

