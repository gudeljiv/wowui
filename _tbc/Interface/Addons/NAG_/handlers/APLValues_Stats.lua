--- @module "APLValues_Stats"
--- Stat-related APL value functions for the NAG addon
---
--- This module provides utility functions for character stats, stat calculations, and stat-based conditions.
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

-- Lua APIs (WoW optimized where available)
local GetTime = _G.GetTime
local UnitDamage = _G.UnitDamage
local UnitAttackSpeed = _G.UnitAttackSpeed
local UnitAttackPower = _G.UnitAttackPower
local GetCombatRatingBonus = _G.GetCombatRatingBonus


local format = string.format
local floor = math.floor


-- ============================ MODULE CACHING (PERFORMANCE) ============================
-- Cache frequently accessed modules to avoid GetModule overhead in hot paths
local TooltipParser = ns.TooltipParser
local Types = ns.Types

local type = type
local tostring = tostring

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~


-- Cache for generic aura stat parsing
local auraStatCache = {}
local AURA_STAT_CACHE_DURATION = 0.2 -- Cache for 200ms

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~



--- Calculates the average base weapon damage for a given weapon.
--- This includes base damage, buffs, and debuffs, but excludes attack power scaling.
--- Uses UnitDamage() for real-time dynamic damage calculations that reflect current buffs/debuffs.
--- @param weapon string|nil The weapon to check ("mainhand" or "offhand"). Defaults to "mainhand".
--- @return number The average base weapon damage, or 0 if weapon data is unavailable.
--- @usage NAG:WeaponDamage("mainhand")
function NAG:WeaponDamage(weapon)
    weapon = weapon or "mainhand"

    local lo, hi, minOffHandDamage, maxOffHandDamage = UnitDamage("player")
    local b, p, n = UnitAttackPower("player")
    local ap = b + p - n
    local s = UnitAttackSpeed("player")
    local h = GetCombatRatingBonus(20) / 100
    local bs = s * (1 + h)
    local apB = ap * bs / 14

    if weapon == "mainhand" then
        if not lo or not hi then return 0 end
        -- Calculate base weapon damage by removing attack power contribution
        local baseLo = floor(lo - apB)
        local baseHi = floor(hi - apB)
        return (baseLo + baseHi) / 2
    elseif weapon == "offhand" then
        if not minOffHandDamage or not maxOffHandDamage then return 0 end
        -- For offhand, we need to calculate its specific attack power contribution
        local offhandSpeed = UnitAttackSpeed("player", true) or s
        local offhandBs = offhandSpeed * (1 + h)
        local offhandApB = ap * offhandBs / 14
        local baseLo = floor(minOffHandDamage - offhandApB)
        local baseHi = floor(maxOffHandDamage - offhandApB)
        return (baseLo + baseHi) / 2
    else
        self:Error("WeaponDamage: Invalid weapon type specified: %s", weapon)
        return 0
    end
end

--- Calculates the average ranged weapon damage for the player.
--- Includes base damage, buffs, and debuffs, but not attack power scaling.
--- @return number The average ranged weapon damage, or 0 if ranged weapon data is unavailable.
--- @usage NAG:RangedWeaponDamage()
--- @local This function is used to calculate the average ranged weapon damage for the player.
function NAG:RangedWeaponDamage()
    local _, minDamage, maxDamage = UnitRangedDamage("player")

    if not minDamage or not maxDamage then return 0 end
    return (minDamage + maxDamage) / 2
end

local VENGEANCE_SPELL_ID = 132365
local VENGEANCE_STAT_NAME = "ATTACK_POWER"

--- Gets the current attack power provided by the Vengeance buff.
--- Uses GetStatFromAuraBySpellID for stat extraction. Result is cached briefly for performance.
--- @return number The amount of attack power from Vengeance, or 0 if not found.
--- @usage NAG:GetVengeanceAP()
function NAG:GetVengeanceAP()
    -- Debug: Let's see what the actual tooltip looks like
    local aura = NAG:UnitAura("player", VENGEANCE_SPELL_ID, "HELPFUL")
    if aura then
        local value1 = aura.points and aura.points[1]
        local value2 = aura.points and aura.points[2]
        local value3 = aura.points and aura.points[3]
        local value4 = aura.points and aura.points[4]
        self:Debug(
            "GetVengeanceAP: Found Vengeance aura - name='%s', count=%d, value1=%s, value2=%s, value3=%s, value4=%s",
            aura.name, aura.count or 0, tostring(value1), tostring(value2), tostring(value3), tostring(value4))

        -- Check if we can get the value directly from the aura data
        if value1 and value1 > 0 then
            self:Debug("GetVengeanceAP: Using direct value1: %d", value1)
            return value1
        end
    end

    return self:GetStatFromAuraBySpellID(VENGEANCE_SPELL_ID, VENGEANCE_STAT_NAME)
end

--- Gets a specific stat value from an aura tooltip on the player.
--- Generic function for any aura granting stats. Result is cached briefly for performance.
--- @param spellId number|nil The spell ID of the aura to find.
--- @param statName string|nil The name of the stat to parse (e.g., "HASTE", "ATTACK_POWER"). Case-insensitive.
--- @return number The value of the stat found, or 0 if not found or invalid input.
--- @usage NAG:GetStatFromAuraBySpellID(12345, "HASTE")
--- @local This function is used to get a specific stat value from an aura tooltip on the player.
function NAG:GetStatFromAuraBySpellID(spellId, statName)
    if not spellId or not statName then
        self:Error("GetStatFromAuraBySpellID: spellId or statName is nil")
        return 0
    end


    local upperStatName = statName:upper()
    local statType = Types:GetType("Stat")[upperStatName]
    if not statType then
        self:Warn("GetStatFromAuraBySpellID: Invalid stat name: %s", tostring(statName))
        return 0
    end

    local cacheKey = format("%s:%s", spellId, statType)
    local currentTime = GetTime()

    local cacheEntry = auraStatCache[cacheKey]
    if cacheEntry and currentTime < cacheEntry.lastCheck + AURA_STAT_CACHE_DURATION then
        return cacheEntry.value
    end

    local value = TooltipParser:GetStatFromAura("player", spellId, statType) or 0

    auraStatCache[cacheKey] = {
        value = value,
        lastCheck = currentTime
    }
    return value
end

--- Gets the current attack power of the player.
--- @return number The current attack power of the player, or 0 if unavailable.
--- @usage NAG:CurrentAttackPower() >= x
function NAG:CurrentAttackPower()
    local base, posBuff, negBuff = UnitAttackPower("player")
    if not base then return 0 end
    return base + posBuff + negBuff
end
