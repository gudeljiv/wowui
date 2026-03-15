--- @module "AuraCache"
--- Advanced aura snapshot caching system for NAG addon
--- Provides cached aura lookups to minimize expensive UnitAura iterations
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ======= LOCALIZE =======
local _, ns = ...
local GetTime = _G.GetTime
local UnitIsUnit = _G.UnitIsUnit
local WoWAPI = ns.WoWAPI

-- Aura cache storage
local auraCache = {
    player = { buffs = {}, debuffs = {}, timestamp = 0 },
    target = { buffs = {}, debuffs = {}, timestamp = 0 },
    focus = { buffs = {}, debuffs = {}, timestamp = 0 },
    pet = { buffs = {}, debuffs = {}, timestamp = 0 }
}

-- Cache TTL constant
local AURA_CACHE_TTL = 0.05 -- 50ms cache for high-frequency updates

-- Cache statistics
local auraCacheStats = {
    hits = 0,
    misses = 0,
    snapshots = 0
}

-- ============================ AURA SNAPSHOT CACHE ============================

--- Snapshot all auras for a unit with caching
--- @param unit string The unit to snapshot auras for
--- @return table|nil The cached aura data
function ns.SnapshotAuras(unit)
    local cache = auraCache[unit]
    if not cache then return nil end

    local currentTime = GetTime()
    if currentTime - cache.timestamp < AURA_CACHE_TTL then
        auraCacheStats.hits = auraCacheStats.hits + 1
        return cache
    end

    auraCacheStats.misses = auraCacheStats.misses + 1
    auraCacheStats.snapshots = auraCacheStats.snapshots + 1

    -- Clear existing cache
    wipe(cache.buffs)
    wipe(cache.debuffs)

    -- Snapshot all buffs
    for i = 1, 40 do
        local data = {WoWAPI.UnitAura(unit, i, "HELPFUL")}
        if not data[1] then break end
        cache.buffs[i] = data
    end

    -- Snapshot all debuffs
    for i = 1, 40 do
        local data = {WoWAPI.UnitAura(unit, i, "HARMFUL")}
        if not data[1] then break end
        cache.debuffs[i] = data
    end

    cache.timestamp = currentTime
    return cache
end

--- Find a buff by spell ID in cached data
--- @param unit string The unit to search
--- @param spellID number The spell ID to find
--- @param filter string|nil Optional filter ("PLAYER", "PET", etc.)
--- @return table|nil The aura data if found
function ns.FindCachedBuffByID(unit, spellID, filter)
    local cache = ns.SnapshotAuras(unit)
    if not cache then return nil end

    for i = 1, #cache.buffs do
        local auraData = cache.buffs[i]
        if auraData and auraData[10] == spellID then
            -- Check filter if provided
            if filter then
                local caster = auraData[7]
                if filter == "PLAYER" and not UnitIsUnit(caster, "player") then
                    -- Skip this entry
                elseif filter == "PET" and not UnitIsUnit(caster, "pet") then
                    -- Skip this entry
                elseif filter == "PLAYER|PET" and not (UnitIsUnit(caster, "player") or UnitIsUnit(caster, "pet")) then
                    -- Skip this entry
                else
                    return auraData
                end
            else
                return auraData
            end
        end
    end

    return nil
end

--- Find a debuff by spell ID in cached data
--- @param unit string The unit to search
--- @param spellID number The spell ID to find
--- @param filter string|nil Optional filter ("PLAYER", "PET", etc.)
--- @return table|nil The aura data if found
function ns.FindCachedDebuffByID(unit, spellID, filter)
    local cache = ns.SnapshotAuras(unit)
    if not cache then return nil end

    for i = 1, #cache.debuffs do
        local auraData = cache.debuffs[i]
        if auraData and auraData[10] == spellID then
            -- Check filter if provided
            if filter then
                local caster = auraData[7]
                if filter == "PLAYER" and not UnitIsUnit(caster, "player") then
                    -- Skip this entry
                elseif filter == "PET" and not UnitIsUnit(caster, "pet") then
                    -- Skip this entry
                elseif filter == "PLAYER|PET" and not (UnitIsUnit(caster, "player") or UnitIsUnit(caster, "pet")) then
                    -- Skip this entry
                else
                    return auraData
                end
            else
                return auraData
            end
        end
    end

    return nil
end

--- Find multiple buffs by spell ID table in cached data
--- @param unit string The unit to search
--- @param spellIDs table Table of spell IDs to find
--- @param filter string|nil Optional filter ("PLAYER", "PET", etc.)
--- @return table Table of found aura data
function ns.FindCachedBuffsByIDs(unit, spellIDs, filter)
    local cache = ns.SnapshotAuras(unit)
    if not cache then return {} end

    local found = {}
    for i = 1, #cache.buffs do
        local auraData = cache.buffs[i]
        if auraData and spellIDs[auraData[10]] then
            -- Check filter if provided
            if filter then
                local caster = auraData[7]
                if filter == "PLAYER" and not UnitIsUnit(caster, "player") then
                    -- Skip this entry
                elseif filter == "PET" and not UnitIsUnit(caster, "pet") then
                    -- Skip this entry
                elseif filter == "PLAYER|PET" and not (UnitIsUnit(caster, "player") or UnitIsUnit(caster, "pet")) then
                    -- Skip this entry
                else
                    found[auraData[10]] = auraData
                end
            else
                found[auraData[10]] = auraData
            end
        end
    end

    return found
end

--- Find multiple debuffs by spell ID table in cached data
--- @param unit string The unit to search
--- @param spellIDs table Table of spell IDs to find
--- @param filter string|nil Optional filter ("PLAYER", "PET", etc.)
--- @return table Table of found aura data
function ns.FindCachedDebuffsByIDs(unit, spellIDs, filter)
    local cache = ns.SnapshotAuras(unit)
    if not cache then return {} end

    local found = {}
    for i = 1, #cache.debuffs do
        local auraData = cache.debuffs[i]
        if auraData and spellIDs[auraData[10]] then
            -- Check filter if provided
            if filter then
                local caster = auraData[7]
                if filter == "PLAYER" and not UnitIsUnit(caster, "player") then
                    -- Skip this entry
                elseif filter == "PET" and not UnitIsUnit(caster, "pet") then
                    -- Skip this entry
                elseif filter == "PLAYER|PET" and not (UnitIsUnit(caster, "player") or UnitIsUnit(caster, "pet")) then
                    -- Skip this entry
                else
                    found[auraData[10]] = auraData
                end
            else
                found[auraData[10]] = auraData
            end
        end
    end

    return found
end

-- ============================ CACHE MANAGEMENT ============================

--- Get aura cache statistics
--- @return table Statistics about aura cache performance
function ns.GetAuraCacheStats()
    return auraCacheStats
end

--- Reset aura cache statistics
function ns.ResetAuraCacheStats()
    wipe(auraCacheStats)
end

--- Clear aura cache for specific unit or all units
--- @param unit string|nil Unit to clear cache for, or nil for all units
function ns.ClearAuraCache(unit)
    if unit and auraCache[unit] then
        wipe(auraCache[unit].buffs)
        wipe(auraCache[unit].debuffs)
        auraCache[unit].timestamp = 0
    else
        for unitName, cache in pairs(auraCache) do
            wipe(cache.buffs)
            wipe(cache.debuffs)
            cache.timestamp = 0
        end
    end
end

--- Get aura cache sizes for memory monitoring
--- @return table Cache sizes per unit
function ns.GetAuraCacheSizes()
    local function countTable(t)
        local count = 0
        for _ in pairs(t) do count = count + 1 end
        return count
    end

    local sizes = {}
    for unitName, cache in pairs(auraCache) do
        sizes[unitName] = {
            buffs = countTable(cache.buffs),
            debuffs = countTable(cache.debuffs)
        }
    end

    return sizes
end
