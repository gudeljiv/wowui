--- @module "NAG.HunterDamageFormulas"
--- TBC hunter base damage formulas (Steady, Multi, Arcane, Auto, Weave) for in-game weighting.
--- Mirrors extern/TBC-sim/hunter formulas using WoW API; no sim required.
---
--- License: CC BY-NC 4.0
--- Authors: Rakizi, Fonsas

-- ============================ LOCALIZE ============================
local _, ns = ...

local UnitAttackPower = _G.UnitAttackPower
local UnitRangedDamage = _G.UnitRangedDamage
local UnitStat = _G.UnitStat

--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ CONSTANTS ============================
local STEADY_RAP_COEF = 0.2
local STEADY_NORM_SEC = 2.8
local STEADY_FLAT = 150

local MULTI_RAP_COEF = 0.2
local MULTI_FLAT = 205

local ARCANE_RAP_COEF = 0.15
local ARCANE_FLAT = 273

local RAPTOR_FLAT = 170

--- When Windfury Totem is active, melee weapon damage is increased by 20% (affects weave base).
local WF_WEAPON_DAMAGE_MULT = 1.2
--- Windfury Totem weapon buff spell IDs (TBC ranks). Must match APLValues_Aura WIND_FURY_TOTEM_BUFF_IDS.
--- Used only as fallback when NAG:HasWindfuryTotemWeaponBuff and NAG.HunterHasWindfury are unavailable.
local WF_TOTEM_BUFF_IDS = { 8516, 10608, 10610, 25583, 25584 }

-- ============================ RAP ON TARGET (Hunter's Mark + Expose Weakness) ============================
-- Hunter's Mark: +110 RAP base; Improved adds 10% per rank (3 ranks) → max 143. We treat as max rank always
-- (regardless of who applied it). Use UnitDebuffGlobal so we see the debuff no matter who applied it.
-- Expose Weakness (SV hunter): 25% of (applier's) Agility as RAP on target. We use player Agility as estimate.
-- Use UnitDebuffGlobal for both so we track debuffs regardless of applier.
local HUNTERS_MARK_RAP_MAX = 143  -- 110 * (1 + 0.10*3) for 3/3 Improved Hunter's Mark
local HUNTERS_MARK_SPELL_IDS = { 14321, 14322, 14323, 14324, 14325 } -- Ranks 1-5 (TBC uses 14325)
local EXPOSE_WEAKNESS_RAP_COEF = 0.25  -- 25% of Agility as RAP
local EXPOSE_WEAKNESS_SPELL_IDS = { 34500, 34502, 34503 }  -- TBC Expose Weakness debuff (talent 1812 ranks 1-3)

-- ============================ HELPERS ============================

--- Returns current RAP (ranged attack power). For hunters, UnitAttackPower is RAP.
--- @return number
local function GetRAP()
    local base, pos, neg = UnitAttackPower("player")
    if not base then return 0 end
    return base + (pos or 0) - (neg or 0)
end

--- Returns ranged weapon average damage and speed. Uses UnitRangedDamage("player").
--- TBC/Classic: typically (speed, minDamage, maxDamage).
--- @return number weaponAvg  Average damage (min+max)/2, or 0
--- @return number speed      Ranged speed in seconds, or 0
local function GetRangedWeaponStats()
    if not UnitRangedDamage then return 0, 0 end
    local speed, minD, maxD = UnitRangedDamage("player")
    if not minD or not maxD or not speed or speed <= 0 then
        return 0, 0
    end
    return (minD + maxD) / 2, speed
end

--- Returns main-hand base weapon average (for weave). Uses NAG:WeaponDamage("mainhand") if available.
--- @return number MH average base damage, or 0
local function GetMHWeaponAvg()
    if NAG and NAG.WeaponDamage then
        local avg = NAG:WeaponDamage("mainhand")
        return (type(avg) == "number" and avg > 0) and avg or 0
    end
    return 0
end

--- Returns whether the target has Hunter's Mark (any rank, any applier). Uses UnitDebuffGlobal.
--- @return boolean
local function TargetHasHuntersMark()
    if not NAG or not NAG.UnitExists or not NAG.UnitDebuffGlobal then return false end
    if not NAG:UnitExists("target") then return false end
    for _, spellId in ipairs(HUNTERS_MARK_SPELL_IDS) do
        if NAG:UnitDebuffGlobal("target", spellId) then return true end
    end
    return false
end

--- Returns whether the target has Expose Weakness (any rank, any applier). Uses UnitDebuffGlobal.
--- @return boolean
local function TargetHasExposeWeakness()
    if not NAG or not NAG.UnitExists or not NAG.UnitDebuffGlobal then return false end
    if not NAG:UnitExists("target") then return false end
    for _, spellId in ipairs(EXPOSE_WEAKNESS_SPELL_IDS) do
        if NAG:UnitDebuffGlobal("target", spellId) then return true end
    end
    return false
end

--- Returns player Agility (for Expose Weakness RAP estimate). UnitStat("player", 2) = Agility.
--- @return number
local function GetPlayerAgility()
    if not UnitStat then return 0 end
    local agi = UnitStat("player", 2)
    return (type(agi) == "number" and agi > 0) and agi or 0
end

--- Returns whether Windfury Totem weapon buff is active on the player (for weave damage scaling).
--- WF is provided by Shamans (Windfury Totem) and affects melee in range; we detect it via the
--- weapon buff that appears on the player. Prefer canonical NAG:HasWindfuryTotemWeaponBuff() (same
--- as TBC Rogue and APLValues_Aura), then NAG.HunterHasWindfury() (HunterWeaveModule), then local fallback.
--- @return boolean
local function WindfuryActive()
    if NAG and type(NAG.HasWindfuryTotemWeaponBuff) == "function" then
        if NAG:HasWindfuryTotemWeaponBuff() then return true end
    end
    if NAG and type(NAG.HunterHasWindfury) == "function" then
        return NAG.HunterHasWindfury()
    end
    if NAG and NAG.AuraIsActive then
        for _, spellId in ipairs(WF_TOTEM_BUFF_IDS) do
            if NAG:AuraIsActive(spellId, "player") then return true end
        end
    end
    return false
end

-- ============================ PUBLIC API ============================

--- Returns whether Windfury Totem weapon buff is active on the player (for weave damage scaling).
--- When true, weave base uses 20% increased weapon damage in the formula.
--- @return boolean
function ns.HunterDamageFormulas_WindfuryActive()
    return WindfuryActive()
end

--- Returns RAP on target: Hunter's Mark (max rank 143) + Expose Weakness (25% of player Agility).
--- Uses UnitDebuffGlobal so debuffs count regardless of who applied them. Hunter's Mark treated as max rank always.
--- @return number
function ns.HunterDamageFormulas_GetRAPOnTarget()
    local rap = 0
    if TargetHasHuntersMark() then
        rap = rap + HUNTERS_MARK_RAP_MAX
    end
    if TargetHasExposeWeakness() then
        rap = rap + EXPOSE_WEAKNESS_RAP_COEF * GetPlayerAgility()
    end
    return rap
end

--- Returns base damage for Auto Shot (one swing). Ranged weapon avg; ammo is in UnitRangedDamage in TBC.
--- @param rapOnTarget number|nil Optional RAP on target (e.g. Hunter's Mark); default 0
--- @return number
function ns.HunterDamageFormulas_GetAutoBase(rapOnTarget)
    rapOnTarget = rapOnTarget or 0
    local weaponAvg = GetRangedWeaponStats()
    if weaponAvg <= 0 then return 0 end
    return weaponAvg
end

--- Returns base damage for Steady Shot (34120). Formula: (RAP+RAP_on)*0.2 + weaponDPS*2.8 + 150
--- @param rapOnTarget number|nil Optional RAP on target; if nil, uses GetRAPOnTarget()
--- @return number
function ns.HunterDamageFormulas_GetSteadyBase(rapOnTarget)
    if rapOnTarget == nil then rapOnTarget = ns.HunterDamageFormulas_GetRAPOnTarget and ns.HunterDamageFormulas_GetRAPOnTarget() or 0
    else rapOnTarget = rapOnTarget or 0 end
    local rap = GetRAP()
    local weaponAvg, speed = GetRangedWeaponStats()
    if speed <= 0 then return 0 end
    local weaponDPS = weaponAvg / speed
    return (rap + rapOnTarget) * STEADY_RAP_COEF + weaponDPS * STEADY_NORM_SEC + STEADY_FLAT
end

--- Returns base damage for Multi-Shot (27021). Formula: (RAP+RAP_on)*0.2 + weaponAvg + 205
--- @param rapOnTarget number|nil Optional RAP on target; if nil, uses GetRAPOnTarget()
--- @return number
function ns.HunterDamageFormulas_GetMultiBase(rapOnTarget)
    if rapOnTarget == nil then rapOnTarget = ns.HunterDamageFormulas_GetRAPOnTarget and ns.HunterDamageFormulas_GetRAPOnTarget() or 0
    else rapOnTarget = rapOnTarget or 0 end
    local rap = GetRAP()
    local weaponAvg = GetRangedWeaponStats()
    return (rap + rapOnTarget) * MULTI_RAP_COEF + weaponAvg + MULTI_FLAT
end

--- Returns base damage for Arcane Shot (27019). Formula: (RAP+RAP_on)*0.15 + 273
--- @param rapOnTarget number|nil Optional RAP on target; if nil, uses GetRAPOnTarget()
--- @return number
function ns.HunterDamageFormulas_GetArcaneBase(rapOnTarget)
    if rapOnTarget == nil then rapOnTarget = ns.HunterDamageFormulas_GetRAPOnTarget and ns.HunterDamageFormulas_GetRAPOnTarget() or 0
    else rapOnTarget = rapOnTarget or 0 end
    local rap = GetRAP()
    return (rap + rapOnTarget) * ARCANE_RAP_COEF + ARCANE_FLAT
end

--- Returns base damage for one melee weave (Raptor Strike + 1× MH white). Formula: 2*MH_avg + 170.
--- When Windfury Totem is active, weapon damage is scaled by 20%: (2*MH_avg)*1.2 + 170.
--- @param wfActive boolean|nil If true/false, use that; if nil, auto-detect via WindfuryActive()
--- @return number
function ns.HunterDamageFormulas_GetWeaveBase(wfActive)
    local mhAvg = GetMHWeaponAvg()
    if wfActive == nil then wfActive = WindfuryActive() end
    local weaponPart = 2 * mhAvg
    if wfActive then
        weaponPart = weaponPart * WF_WEAPON_DAMAGE_MULT
    end
    return weaponPart + RAPTOR_FLAT
end

--- Returns all base damages in one call (avoids multiple API hits). Keys: auto, steady, multi, arcane, weave.
--- Weave uses Windfury Totem detection when wfActive is nil (20% weapon damage when WF active).
--- @param rapOnTarget number|nil Optional RAP on target; if nil, uses GetRAPOnTarget() (Hunter's Mark)
--- @param wfActive boolean|nil Optional; if nil, weave base auto-detects Windfury for 20% weapon scaling
--- @return table bases
function ns.HunterDamageFormulas_GetAllBases(rapOnTarget, wfActive)
    if rapOnTarget == nil then
        rapOnTarget = ns.HunterDamageFormulas_GetRAPOnTarget and ns.HunterDamageFormulas_GetRAPOnTarget() or 0
    else
        rapOnTarget = rapOnTarget or 0
    end
    local rap = GetRAP()
    local weaponAvg, speed = GetRangedWeaponStats()
    local weaponDPS = (speed and speed > 0) and (weaponAvg / speed) or 0
    local mhAvg = GetMHWeaponAvg()
    local weaveWeaponPart = 2 * mhAvg
    if wfActive == nil then wfActive = WindfuryActive() end
    if wfActive then
        weaveWeaponPart = weaveWeaponPart * WF_WEAPON_DAMAGE_MULT
    end

    return {
        auto   = weaponAvg,
        steady = (rap + rapOnTarget) * STEADY_RAP_COEF + weaponDPS * STEADY_NORM_SEC + STEADY_FLAT,
        multi  = (rap + rapOnTarget) * MULTI_RAP_COEF + weaponAvg + MULTI_FLAT,
        arcane = (rap + rapOnTarget) * ARCANE_RAP_COEF + ARCANE_FLAT,
        weave  = weaveWeaponPart + RAPTOR_FLAT,
    }
end

--- Returns ranged speed in seconds (for cast times and DPS). Uses UnitRangedDamage.
--- @return number
function ns.HunterDamageFormulas_GetRangedSpeed()
    local _, speed = GetRangedWeaponStats()
    return speed
end

--- Steady Shot cast time in seconds: 1.5/speed + latencySec (sim formula).
--- @param latencySec number|nil Optional latency in seconds; default 0.05
--- @return number
function ns.HunterDamageFormulas_GetSteadyCastTime(latencySec)
    latencySec = latencySec or 0.05
    local speed = ns.HunterDamageFormulas_GetRangedSpeed()
    if not speed or speed <= 0 then return 1.5 + latencySec end
    return 1.5 / speed + latencySec
end

--- Multi-Shot cast time in seconds: 0.5/speed + latencySec (sim formula).
--- @param latencySec number|nil Optional latency in seconds; default 0.05
--- @return number
function ns.HunterDamageFormulas_GetMultiCastTime(latencySec)
    latencySec = latencySec or 0.05
    local speed = ns.HunterDamageFormulas_GetRangedSpeed()
    if not speed or speed <= 0 then return 0.5 + latencySec end
    return 0.5 / speed + latencySec
end
