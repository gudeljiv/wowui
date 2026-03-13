--- @module "TablePool"
--- Centralized table pool for high-frequency allocations in hotpath code
---
--- Provides table pooling functionality to eliminate garbage collection pressure
--- in performance-critical code paths by reusing existing tables instead of
--- creating new ones. This is essential for combat rotation updates, event
--- handlers, and UI refreshes that run multiple times per second.
---
--- # Usage Examples
---
--- ```lua
--- -- Acquire a table from the pool
--- local data = TablePool:Acquire("medium")
--- data[1] = "value1"
--- data[2] = "value2"
---
--- -- Use the table...
---
--- -- Release it back to the pool when done
--- TablePool:Release("medium", data)
--- data = nil -- Clear reference
--- ```
---
--- # Pool Types
--- - **small**: Tables with < 10 entries (most common)
--- - **medium**: Tables with < 50 entries
--- - **large**: Tables with < 200 entries
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ============================ LOCALIZE ============================
local _, ns = ...
local tinsert = tinsert
local tremove = tremove
local wipe = wipe

-- Standard Lua functions
local type = type
local pairs = pairs

-- ============================ CONTENT ============================

--- @class TablePool
--- Centralized table pool for high-frequency allocations
--- @field pools table Pool storage organized by size
--- @field stats table Statistics for monitoring pool usage
local TablePool = {
    pools = {
        small = {},   -- Tables with < 10 entries (most common)
        medium = {},  -- Tables with < 50 entries
        large = {},   -- Tables with < 200 entries
    },

    stats = {
        totalAcquisitions = 0,
        totalReleases = 0,
        poolHits = 0,
        poolMisses = 0,
    }
}

--- Acquires a table from the specified pool
--- @param poolType string Pool type ("small", "medium", "large") - defaults to "small"
--- @return table A clean, empty table ready for use
function TablePool:Acquire(poolType)
    poolType = poolType or "small"
    local pool = self.pools[poolType]

    if not pool then
        -- Invalid pool type - create new table but don't add to stats
        local t = {}
        wipe(t)
        return t
    end

    local t = tremove(pool)
    if t then
        -- Pool hit - reuse existing table
        wipe(t)
        self.stats.poolHits = self.stats.poolHits + 1
    else
        -- Pool miss - create new table
        t = {}
        self.stats.poolMisses = self.stats.poolMisses + 1
    end

    self.stats.totalAcquisitions = self.stats.totalAcquisitions + 1
    return t
end

--- Releases a table back to the specified pool
--- @param poolType string Pool type ("small", "medium", "large") - defaults to "small"
--- @param t table|nil Table to release (nil is safe)
function TablePool:Release(poolType, t)
    if not t then return end

    poolType = poolType or "small"
    local pool = self.pools[poolType]

    if not pool then
        -- Invalid pool type - just clear the table
        wipe(t)
        return
    end

    -- Clear the table and return to pool
    wipe(t)
    tinsert(pool, t)

    self.stats.totalReleases = self.stats.totalReleases + 1
end

--- Gets pool statistics for monitoring and debugging
--- @return table Statistics about pool usage
function TablePool:GetStats()
    local stats = {}
    for poolType, pool in pairs(self.pools) do
        stats[poolType .. "Size"] = #pool
    end
    stats.totalAcquisitions = self.stats.totalAcquisitions
    stats.totalReleases = self.stats.totalReleases
    stats.poolHits = self.stats.poolHits
    stats.poolMisses = self.stats.poolMisses

    if self.stats.totalAcquisitions > 0 then
        stats.hitRate = self.stats.poolHits / self.stats.totalAcquisitions
    else
        stats.hitRate = 0
    end

    return stats
end

--- Clears all pools and resets statistics (for testing/debugging)
function TablePool:Clear()
    for _, pool in pairs(self.pools) do
        for i = #pool, 1, -1 do
            wipe(pool[i])
            pool[i] = nil
        end
    end

    self.stats.totalAcquisitions = 0
    self.stats.totalReleases = 0
    self.stats.poolHits = 0
    self.stats.poolMisses = 0
end

--- Validates pool integrity (for testing/debugging)
--- @return boolean True if pools are valid, false otherwise
--- @return string|nil Error message if validation failed
function TablePool:Validate()
    for poolType, pool in pairs(self.pools) do
        if type(pool) ~= "table" then
            return false, "Invalid pool type: " .. tostring(poolType)
        end

        for i, t in ipairs(pool) do
            if type(t) ~= "table" then
                return false, "Invalid table in pool " .. poolType .. " at index " .. i
            end
        end
    end

    return true
end

-- ============================ EXPORT ============================

-- Export to namespace
ns.TablePool = TablePool

return TablePool

