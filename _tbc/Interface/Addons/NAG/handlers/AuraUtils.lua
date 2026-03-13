--- @module "AuraUtils"
--- Aura utility and debugging functions for the NAG addon
---
--- This module provides utility functions for aura exploration, debugging, and group management.
--- These are not APL value functions but rather tools for developers and users.
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
local WoWAPI = ns.WoWAPI

-- Lua APIs (WoW optimized where available)
local GetTime = _G.GetTime
local UnitExists = _G.UnitExists
local UnitAura = _G.UnitAura
local UnitBuff = _G.UnitBuff
local UnitDebuff = _G.UnitDebuff


local format = string.format
local floor = math.floor
local ceil = ceil
local min = math.min
local max = math.max
local abs = math.abs




local tinsert = tinsert
local wipe = wipe
local tContains = tContains

local sort = table.sort
local ipairs = ipairs
local type = type
local tostring = tostring

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~


-- ============================ API AVAILABILITY CACHING ============================

-- Lightweight cache for by-player aura checks (name/id scoped)
-- Key format: unit .. "|" .. tostring(nameOrId)
local AURA_BY_PLAYER_CACHE_TTL = 0.7
local auraByPlayerCache = {}

-- Cache for dot-by-player (optionally including pet) checks
local DOT_BY_PLAYER_CACHE_TTL = 0.7
local dotByPlayerCache = {}

-- Reusable auras table to avoid allocation every PrintAuras call (Blizzard pattern)
-- This table is returned to callers, so we can't use TablePool here
local aurasTable = {}

--- Lists all auras on a unit with their spell IDs and other information. Prints the list to chat and returns a table of aura data.
--- @param unit string The unit to check.
--- @param filter? string Optional filter ("HELPFUL", "HARMFUL", "HELPFUL|PLAYER", "HARMFUL|PLAYER", etc.).
--- @return table A table containing all auras, each with id, name, count, duration, expires, and other info.
--- @usage local auras = NAG:PrintAuras("player", "HELPFUL")
--- @local This function is used to list all auras on a unit with their spell IDs and other information.
function NAG:PrintAuras(unit, filter)
    if not unit then
        self:Warn("PrintAuras: Invalid input - unit is nil")
        return {}
    end

    filter = filter or "HELPFUL"

    -- Reuse table to avoid allocation (Blizzard pattern)
    wipe(aurasTable)
    local auras = aurasTable

    -- Use classic API (works in both Classic and Retail)
    local i = 1
    while true do
        --TODO: Change to NAG:UnitAura?
        local name, icon, count, debuffType, duration, expirationTime,
        unitCaster, isStealable, shouldConsolidate, spellId = UnitAura(unit, i, filter)

        if not name then
            break
        end

        tinsert(auras, {
            id = spellId,
            name = name,
            count = count or 1,
            duration = duration or 0,
            expires = expirationTime or 0,
            icon = icon,
            source = unitCaster,
            dispelType = debuffType or 0,
            isStealable = isStealable and true or false
        })

        i = i + 1
    end

    -- Print the auras directly
    if #auras == 0 then
        self:Print(format("No %s auras found on %s", filter or "HELPFUL", unit))
    else
        self:Print(format("Found %d %s auras on %s:", #auras, filter or "HELPFUL", unit))

        -- Sort by ID
        sort(auras, function(a, b) return a.id < b.id end)

        for _, aura in ipairs(auras) do
            local remains = aura.expires > 0 and format("%.1fs", aura.expires - GetTime()) or "N/A"
            local stacks = aura.count > 1 and format(" (%d stacks)", aura.count) or ""
            self:Print(format("ID: %d - %s%s - Remains: %s", aura.id, aura.name, stacks, remains))
        end
    end

    return auras
end


--- @local
--- Returns true if the specified aura (by name or spellID) is active on unit and cast by the player
--- Uses HARMFUL|PLAYER filter to ensure player-cast debuffs only
--- @param auraNameOrId string|number The aura name or spellID to check
--- @param unit string|nil The unit to scan (defaults to "target")
--- @return boolean
function NAG:AuraByNameAndCasterIsPlayer(auraNameOrId, unit)
    unit = unit or "target"
    if not unit or not UnitExists(unit) or not auraNameOrId then
        return false
    end

    local wantedId = nil
    local wantedName = nil
    if type(auraNameOrId) == "number" then
        wantedId = auraNameOrId
        local spellInfo = WoWAPI.GetSpellInfo(auraNameOrId)
        wantedName = spellInfo and spellInfo.name
    else
        wantedName = tostring(auraNameOrId)
    end
    if not wantedName then return false end

    -- Cache fast-path - format() avoids temporary string allocations
    local cacheKey = format("%s|%s", unit, tostring(wantedId or wantedName))
    local now = GetTime()
    local entry = auraByPlayerCache[cacheKey]
    if entry and (now - entry.ts) <= AURA_BY_PLAYER_CACHE_TTL then
        return entry.val
    end

    -- Use classic API (works in both Classic and Retail)
    local i = 1
    while true do
        --TODO: Change to NAG:UnitAura?
        local name, _, _, _, _, _, unitCaster, _, _, spellId = UnitAura(unit, i, "HARMFUL|PLAYER")
        if not name then break end
        local matches = (wantedId and spellId == wantedId) or (name == wantedName)
        if matches and unitCaster == "player" then
            auraByPlayerCache[cacheKey] = { ts = now, val = true }
            return true
        end
        i = i + 1
    end
    auraByPlayerCache[cacheKey] = { ts = now, val = false }
    return false
end

--- Returns true if a debuff (by spellID) is active on unit and cast by player (or optionally pet)
--- @param spellID number The debuff spell ID to check
--- @param unit string|nil Unit to scan (defaults to "target")
--- @param includePet boolean|nil If true, counts pet/guardian as caster as well
--- @return boolean
function NAG:DotIsActiveByPlayer(spellID, unit, includePet)
    unit = unit or "target"
    if not unit or not UnitExists(unit) or not spellID then
        return false
    end

    local spellInfo = WoWAPI.GetSpellInfo(spellID)
    if not spellInfo or not spellInfo.name then return false end

    local spellName = spellInfo.name

    local cacheKey = format("%s|%s|%s", unit, tostring(spellID), includePet and "pet" or "nopet")
    local now = GetTime()
    local entry = dotByPlayerCache[cacheKey]
    if entry and (now - entry.ts) <= DOT_BY_PLAYER_CACHE_TTL then
        return entry.val
    end

    local function save(val)
        dotByPlayerCache[cacheKey] = { ts = now, val = val }
        return val
    end

    -- Use classic API (works in both Classic and Retail)
    local i = 1
    while true do
        --TODO: Change to NAG:UnitAura?
        local aname, _, _, _, _, _, unitCaster, _, _, sid = UnitAura(unit, i, "HARMFUL|PLAYER")
        if not aname then break end
        if sid == spellID or aname == spellName then
            if unitCaster == "player" then
                return save(true)
            end
            if includePet and unitCaster == "pet" then
                return save(true)
            end
        end
        i = i + 1
    end
    return save(false)
end

