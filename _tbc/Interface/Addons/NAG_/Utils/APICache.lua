
--- @module "APICache"
--- Centralized API caching system for NAG addon
--- Provides cached versions of expensive WoW API calls to improve performance
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ======= LOCALIZE =======
local _, ns = ...
local GetTime = _G.GetTime
local GetMacroInfo = _G.GetMacroInfo

-- Prefer unified APIs directly to avoid circular dependencies with ns.WoWAPI
local GetSpellInfoUnified = ns.GetSpellInfoUnified
local GetItemInfoUnified = ns.GetItemInfoUnified

-- Cache storage tables
local spellCache = {}
local itemCache = {}
local actionCache = {}
local macroCache = {}

-- Sentinel value for caching nil results (prevents repeated queries for non-existent spell IDs)
local NIL_CACHE_MARKER = {}

-- Cache timestamps for TTL management
local actionCacheTimestamp = 0
local macroCacheTimestamp = 0

-- Cache TTL constants
local ACTION_CACHE_TTL = 1.0 -- 1 second TTL
local MACRO_CACHE_TTL = 5.0 -- 5 second TTL

-- Cache statistics
local cacheStats = {}

local function resetCacheStats()
    cacheStats.spellHits = 0
    cacheStats.spellMisses = 0
    cacheStats.itemHits = 0
    cacheStats.itemMisses = 0
    cacheStats.actionHits = 0
    cacheStats.actionMisses = 0
    cacheStats.macroHits = 0
    cacheStats.macroMisses = 0
end

resetCacheStats()

-- ============================ SPELL INFO CACHE ============================

--- Cached version of GetSpellInfo with permanent storage
--- We can't perm cache GetSpellInfo because castTime is variable and changes based on haste and other factors.
--- @param spellID number The spell ID to look up
--- @return SpellInfo|nil spellInfo Table from GetSpellInfoUnified or nil if missing
function ns.CachedGetSpellInfo(spellID)
    if not spellID then return nil end

    local cached = spellCache[spellID]
    if cached ~= nil then
        cacheStats.spellHits = cacheStats.spellHits + 1
        -- Return nil if cached as NIL_CACHE_MARKER, otherwise return cached value
        return cached == NIL_CACHE_MARKER and nil or cached
    end

    cacheStats.spellMisses = cacheStats.spellMisses + 1
    local spellInfo = GetSpellInfoUnified(spellID)
    if spellInfo then
        spellCache[spellID] = spellInfo
        return spellInfo
    else
        -- Cache nil result to prevent repeated queries for non-existent spell IDs
        spellCache[spellID] = NIL_CACHE_MARKER
        return nil
    end
end

-- ============================ ITEM INFO CACHE ============================

--- Cached version of GetItemInfo with permanent storage (Hekili pattern)
--- @param itemID number The item ID to look up
--- @return string|nil name, string|nil link, number|nil quality, number|nil level, number|nil minLevel, string|nil type, string|nil subType, number|nil stackCount, string|nil equipSlot, string|nil texture, number|nil sellPrice
function ns.CachedGetItemInfo(itemID)
    if not itemID then return nil end

    local cached = itemCache[itemID]
    if cached ~= nil then
        cacheStats.itemHits = cacheStats.itemHits + 1
        -- Return nil if cached as NIL_CACHE_MARKER, otherwise unpack cached array
        if cached == NIL_CACHE_MARKER then
            return nil
        else
            return unpack(cached)
        end
    end

    cacheStats.itemMisses = cacheStats.itemMisses + 1
    local itemData = {GetItemInfoUnified(itemID)}
    if itemData[1] then
        itemCache[itemID] = itemData
        return unpack(itemData)
    else
        -- Cache nil result to prevent repeated queries for non-existent item IDs
        itemCache[itemID] = NIL_CACHE_MARKER
        return nil
    end
end

-- ============================ ACTION INFO CACHE ============================

--- Cached version of GetActionInfo with TTL-based invalidation
--- @param slot number The action slot to look up
--- @return string|nil actionType, number|nil actionID, string|nil action, boolean|nil showSpell, boolean|nil showCount
function ns.CachedGetActionInfo(slot)
    local currentTime = GetTime()
    if currentTime - actionCacheTimestamp > ACTION_CACHE_TTL then
        wipe(actionCache)
        actionCacheTimestamp = currentTime
    end

    if actionCache[slot] then
        cacheStats.actionHits = cacheStats.actionHits + 1
        return unpack(actionCache[slot])
    end

    cacheStats.actionMisses = cacheStats.actionMisses + 1
    local actionData = {GetActionInfo(slot)}
    if actionData[1] then
        actionCache[slot] = actionData
        return unpack(actionData)
    end

    return nil
end

-- ============================ MACRO INFO CACHE ============================

--- Cached version of GetMacroInfo with TTL-based invalidation
--- @param macroID number The macro ID to look up
--- @return string|nil name, string|nil texture, string|nil body, boolean|nil isLocal
function ns.CachedGetMacroInfo(macroID)
    local currentTime = GetTime()
    if currentTime - macroCacheTimestamp > MACRO_CACHE_TTL then
        wipe(macroCache)
        macroCacheTimestamp = currentTime
    end

    if macroCache[macroID] then
        cacheStats.macroHits = cacheStats.macroHits + 1
        return unpack(macroCache[macroID])
    end

    cacheStats.macroMisses = cacheStats.macroMisses + 1
    local macroData = {GetMacroInfo(macroID)}
    if macroData[1] then
        macroCache[macroID] = macroData
        return unpack(macroData)
    end

    return nil
end

-- ============================ CACHE MANAGEMENT ============================

--- Get cache statistics for monitoring
--- @return table Statistics about cache hit/miss rates
function ns.GetCacheStats()
    return cacheStats
end

--- Reset cache statistics
function ns.ResetCacheStats()
    resetCacheStats()
end

--- Clear specific cache or all caches
--- @param cacheType string|nil Type of cache to clear ("spell", "item", "action", "macro", "all")
function ns.ClearAPICache(cacheType)
    if cacheType == "spell" then
        wipe(spellCache)
    elseif cacheType == "item" then
        wipe(itemCache)
    elseif cacheType == "action" then
        wipe(actionCache)
        actionCacheTimestamp = 0
    elseif cacheType == "macro" then
        wipe(macroCache)
        macroCacheTimestamp = 0
    elseif cacheType == "all" then
        wipe(spellCache)
        wipe(itemCache)
        wipe(actionCache)
        wipe(macroCache)
        actionCacheTimestamp = 0
        macroCacheTimestamp = 0
    end
end

--- Get cache sizes for memory monitoring
--- @return table Cache sizes
function ns.GetCacheSizes()
    local function countTable(t)
        local count = 0
        for _ in pairs(t) do count = count + 1 end
        return count
    end

    return {
        spellCache = countTable(spellCache),
        itemCache = countTable(itemCache),
        actionCache = countTable(actionCache),
        macroCache = countTable(macroCache)
    }
end

-- Register cached APIs with the WoWAPI registry (post-construction, avoiding circular deps)
if ns.RegisterCachedAPI then
    ns.RegisterCachedAPI("GetSpellInfo", ns.CachedGetSpellInfo)
    ns.RegisterCachedAPI("GetItemInfo", ns.CachedGetItemInfo)
    ns.RegisterCachedAPI("GetActionInfo", ns.CachedGetActionInfo)
    ns.RegisterCachedAPI("GetMacroInfo", ns.CachedGetMacroInfo)

end
