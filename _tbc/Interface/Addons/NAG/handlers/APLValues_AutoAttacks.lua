--- @module "APLValues_AutoAttacks"
--- Auto Attack related APL value functions for the NAG addon
---
--- This module provides utility functions for auto attack timing, swing timers, and melee attack management.
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

-- WoW API (compat)
local WoWAPI = ns.WoWAPI
local Version = ns.Version

-- Libraries
local L = ns.AceLocale:GetLocale("NAG", true)
local RC = ns.RC
local swingTimerLib = ns.LibClassicSwingTimerAPI

-- Modules
local SpellbookManager = ns.SpellbookManager

-- Lazy module cache (avoid GetModule cost unless needed)
local SpecCompat



-- Lua APIs (WoW optimized where available)
local GetTime = _G.GetTime
local UnitAttackSpeed = _G.UnitAttackSpeed
local UnitCastingInfo = _G.UnitCastingInfo
local CreateFrame = _G.CreateFrame
local IsUsableSpell = C_Spell and C_Spell.IsSpellUsable or _G.IsUsableSpell
local IsCurrentSpell = C_Spell and C_Spell.IsCurrentSpell or _G.IsCurrentSpell
local UnitCanAttack = _G.UnitCanAttack
local UnitExists = _G.UnitExists


local format = string.format
local min = math.min
local max = math.max
local abs = math.abs
local JUDGE_HOLD_LOG_VERSION = "jhfix_v2_2026-02-13"
local OG_RET_SHADOW_LOG_VERSION = "ogret_shadow_v1_2026-02-13"



local sort = table.sort
local concat = table.concat
local type = type
local tonumber = tonumber

local function retTwistPolicyDebug(self, message)
    -- Temporarily muted: keep only RET_FILLER_GATE output.
    if true then
        return
    end
    if not (self and self.IsDevModeEnabled and self:IsDevModeEnabled()) then
        return
    end

    local now = (_G.GetTime and _G.GetTime()) or 0
    local lastMessage = self._retTwistPolicyDebugLastMessage
    local lastAt = self._retTwistPolicyDebugLastAt or 0
    if lastMessage == message and (now - lastAt) <= 0.20 then
        return
    end
    self._retTwistPolicyDebugLastMessage = message
    self._retTwistPolicyDebugLastAt = now
    print(message)
end

--- Throttled, state-change-only diagnostics for live rotation validation.
--- Intended usage: place AFTER a cast/branch action so it only fires when the branch actually wins.
--- @param cluster string One of: "judge_hold", "soc_hold", "retain_sob", "cs_fallback"
--- @param detail string|nil Optional sub-reason/branch name
--- @return boolean Always true (safe for `and (Dbg() or true)` chains)
function NAG:RetTwistDebugBranchWinner(cluster, detail)
    if not (self and self.IsDevModeEnabled and self:IsDevModeEnabled()) then
        return true
    end

    local now = (_G.GetTime and _G.GetTime()) or 0
    local tag = tostring(cluster or "unknown")
    local info = detail and tostring(detail) or ""

    local lastTag = self._retTwistBranchWinnerLastTag
    local lastInfo = self._retTwistBranchWinnerLastInfo
    local lastAt = self._retTwistBranchWinnerLastAt or 0

    -- State-change-first: print only when winner changes (or detail changes), with a small time floor.
    if lastTag == tag and lastInfo == info and (now - lastAt) <= 0.20 then
        return true
    end

    self._retTwistBranchWinnerLastTag = tag
    self._retTwistBranchWinnerLastInfo = info
    self._retTwistBranchWinnerLastAt = now

    local remTime = (self.RemainingTime and self:RemainingTime()) or -1
    print(string.format(
        "[RET_BRANCH_WIN][ver=%s] cluster=%s detail=%s remTime=%.3f",
        JUDGE_HOLD_LOG_VERSION,
        tag,
        info,
        remTime
    ))
    return true
end

-- ============================ MODULE CACHING (PERFORMANCE) ============================
-- Cache frequently accessed modules to avoid GetModule overhead in hot paths
local Types = ns.Types
local StateManager = ns.StateManager

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

-- ============================ WARRIOR BAR GATE (TBC) ============================
-- Keep gate helpers here so rotation strings can always call them.
if not NAG.IsTBCWarriorBarsEnabled or not NAG.EnableTBCWarriorBars then
    local WARRIOR_BAR_GATE_TTL_SECONDS = 5

    local function getTBCWarriorBarsGate()
        if ns.tbcWarriorBarsGateEnabled == nil then
            ns.tbcWarriorBarsGateEnabled = false
        end
        return ns.tbcWarriorBarsGateEnabled
    end

    local function getTBCWarriorBarsGateLastEnable()
        if ns.tbcWarriorBarsGateLastEnable == nil then
            ns.tbcWarriorBarsGateLastEnable = 0
        end
        return ns.tbcWarriorBarsGateLastEnable
    end

    local function updateTBCWarriorBarsGateLastEnable(timeSeconds)
        ns.tbcWarriorBarsGateLastEnable = timeSeconds or 0
    end

    local function isTBCWarriorBarsGateExpired(now)
        local lastEnable = getTBCWarriorBarsGateLastEnable()
        if lastEnable <= 0 then
            return true
        end
        return (now - lastEnable) > WARRIOR_BAR_GATE_TTL_SECONDS
    end

    --- Returns true when the TBC Warrior slam bars are gated on by a rotation call.
    --- @return boolean
    function NAG:IsTBCWarriorBarsEnabled()
        if not getTBCWarriorBarsGate() then
            return false
        end
        local now = GetTime()
        if isTBCWarriorBarsGateExpired(now) then
            ns.tbcWarriorBarsGateEnabled = false
            return false
        end
        return true
    end

    --- Enable the TBC Warrior slam bars gate (does not override user visibility settings).
    --- @return boolean Always false so it never short-circuits rotation strings
    function NAG:EnableTBCWarriorBars()
        local now = GetTime()
        local wasEnabled = getTBCWarriorBarsGate()
        ns.tbcWarriorBarsGateEnabled = true
        updateTBCWarriorBarsGateLastEnable(now)

        local bar = ns.WarriorSlamWeaveBar
        if bar and bar.UpdateVisibility and not wasEnabled then
            bar:UpdateVisibility()
        end

        local TimerManager = ns.TimerManager
        if TimerManager and TimerManager.Create then
            TimerManager:Cancel(TimerManager.Categories.UI_NOTIFICATION, "tbcWarriorBarsGateExpire")
            TimerManager:Create(
                TimerManager.Categories.UI_NOTIFICATION,
                "tbcWarriorBarsGateExpire",
                function()
                    local expiredNow = GetTime()
                    if isTBCWarriorBarsGateExpired(expiredNow) then
                        ns.tbcWarriorBarsGateEnabled = false
                        if bar and bar.UpdateVisibility then
                            bar:UpdateVisibility()
                        end
                    end
                end,
                WARRIOR_BAR_GATE_TTL_SECONDS,
                false
            )
        end
        return false
    end
end

-- ============================ HUNTER STEADY BAR GATE (TBC) ============================
-- Gate the Hunter Steady weave bar so it only loads when the rotation is active.
-- The rotation string calls EnableTBCHunterSteadyBars() as the first action to keep this alive.
if not NAG.IsTBCHunterSteadyBarsEnabled or not NAG.EnableTBCHunterSteadyBars then
    local HUNTER_STEADY_BAR_GATE_TTL_SECONDS = 5

    local function getTBCHunterSteadyBarsGate()
        if ns.tbcHunterSteadyBarsGateEnabled == nil then
            ns.tbcHunterSteadyBarsGateEnabled = false
        end
        return ns.tbcHunterSteadyBarsGateEnabled
    end

    local function getTBCHunterSteadyBarsGateLastEnable()
        if ns.tbcHunterSteadyBarsGateLastEnable == nil then
            ns.tbcHunterSteadyBarsGateLastEnable = 0
        end
        return ns.tbcHunterSteadyBarsGateLastEnable
    end

    local function updateTBCHunterSteadyBarsGateLastEnable(timeSeconds)
        ns.tbcHunterSteadyBarsGateLastEnable = timeSeconds or 0
    end

    local function isTBCHunterSteadyBarsGateExpired(now)
        local lastEnable = getTBCHunterSteadyBarsGateLastEnable()
        if lastEnable <= 0 then
            return true
        end
        return (now - lastEnable) > HUNTER_STEADY_BAR_GATE_TTL_SECONDS
    end

    --- Returns true when the TBC Hunter Steady bar is gated on by a rotation call.
    --- @return boolean
    function NAG:IsTBCHunterSteadyBarsEnabled()
        if not getTBCHunterSteadyBarsGate() then
            return false
        end
        local now = GetTime()
        if isTBCHunterSteadyBarsGateExpired(now) then
            ns.tbcHunterSteadyBarsGateEnabled = false
            return false
        end
        return true
    end

    --- Enable the TBC Hunter Steady bar gate (does not override user visibility settings).
    --- @return boolean Always false so it never short-circuits rotation strings
    function NAG:EnableTBCHunterSteadyBars()
        local now = GetTime()
        local wasEnabled = getTBCHunterSteadyBarsGate()
        ns.tbcHunterSteadyBarsGateEnabled = true
        updateTBCHunterSteadyBarsGateLastEnable(now)

        local bar = ns.HunterSteadyWeaveBar
        if bar and bar.UpdateVisibility and not wasEnabled then
            bar:UpdateVisibility()
        end

        local TimerManager = ns.TimerManager
        if TimerManager and TimerManager.Create then
            TimerManager:Cancel(TimerManager.Categories.UI_NOTIFICATION, "tbcHunterSteadyBarsGateExpire")
            TimerManager:Create(
                TimerManager.Categories.UI_NOTIFICATION,
                "tbcHunterSteadyBarsGateExpire",
                function()
                    local expiredNow = GetTime()
                    if isTBCHunterSteadyBarsGateExpired(expiredNow) then
                        ns.tbcHunterSteadyBarsGateEnabled = false
                        if bar and bar.UpdateVisibility then
                            bar:UpdateVisibility()
                        end
                    end
                end,
                HUNTER_STEADY_BAR_GATE_TTL_SECONDS,
                false
            )
        end
        return false
    end
end

-- ============================ HUNTER STEADY EARLY GAP GATE (TBC) ============================
-- Gate the Hunter Steady early-gap segment so it only updates when the rotation opts in.
if not NAG.IsTBCHunterSteadyEARLYgapEnabled or not NAG.EnableTBCHunterSteadyEARLYgap then
    local HUNTER_STEADY_EARLY_GAP_GATE_TTL_SECONDS = 5

    local function getTBCHunterSteadyEarlyGapGate()
        if ns.tbcHunterSteadyEarlyGapGateEnabled == nil then
            ns.tbcHunterSteadyEarlyGapGateEnabled = false
        end
        return ns.tbcHunterSteadyEarlyGapGateEnabled
    end

    local function getTBCHunterSteadyEarlyGapGateLastEnable()
        if ns.tbcHunterSteadyEarlyGapGateLastEnable == nil then
            ns.tbcHunterSteadyEarlyGapGateLastEnable = 0
        end
        return ns.tbcHunterSteadyEarlyGapGateLastEnable
    end

    local function updateTBCHunterSteadyEarlyGapGateLastEnable(timeSeconds)
        ns.tbcHunterSteadyEarlyGapGateLastEnable = timeSeconds or 0
    end

    local function isTBCHunterSteadyEarlyGapGateExpired(now)
        local lastEnable = getTBCHunterSteadyEarlyGapGateLastEnable()
        if lastEnable <= 0 then
            return true
        end
        return (now - lastEnable) > HUNTER_STEADY_EARLY_GAP_GATE_TTL_SECONDS
    end

    --- Returns true when the TBC Hunter Steady early-gap segment gate is enabled by rotation.
    --- @return boolean
    function NAG:IsTBCHunterSteadyEARLYgapEnabled()
        if not getTBCHunterSteadyEarlyGapGate() then
            return false
        end
        local now = GetTime()
        if isTBCHunterSteadyEarlyGapGateExpired(now) then
            ns.tbcHunterSteadyEarlyGapGateEnabled = false
            return false
        end
        return true
    end

    --- Enable the TBC Hunter Steady early-gap segment gate.
    --- @return boolean Always false so it never short-circuits rotation strings
    function NAG:EnableTBCHunterSteadyEARLYgap()
        local now = GetTime()
        ns.tbcHunterSteadyEarlyGapGateEnabled = true
        updateTBCHunterSteadyEarlyGapGateLastEnable(now)

        local TimerManager = ns.TimerManager
        if TimerManager and TimerManager.Create then
            TimerManager:Cancel(TimerManager.Categories.UI_NOTIFICATION, "tbcHunterSteadyEarlyGapGateExpire")
            TimerManager:Create(
                TimerManager.Categories.UI_NOTIFICATION,
                "tbcHunterSteadyEarlyGapGateExpire",
                function()
                    local expiredNow = GetTime()
                    if isTBCHunterSteadyEarlyGapGateExpired(expiredNow) then
                        ns.tbcHunterSteadyEarlyGapGateEnabled = false
                    end
                end,
                HUNTER_STEADY_EARLY_GAP_GATE_TTL_SECONDS,
                false
            )
        end
        return false
    end
end

-- ============================ SHARED SWING TIMER INITIALIZATION ============================

--- Initialize swing timer tracking with optional event handler
--- @param eventHandler function|nil Optional custom event handler function
--- @return boolean True if initialized successfully
local function initializeSwingTimer(eventHandler)
    if not swingTimerLib then return false end
    if NAG.swingTimerInitialized then return true end

    local f = CreateFrame("Frame")

    local function SwingTimerEventHandler(event, ...)
        if eventHandler then
            eventHandler(event, ...)
        else
            if event == "UNIT_SWING_TIMER_DELTA" then
                local _, swingDelta = ...
                NAG.lastSwingDelta = swingDelta
            end
        end
    end

    swingTimerLib.RegisterCallback(f, "UNIT_SWING_TIMER_INFO_INITIALIZED", SwingTimerEventHandler)
    swingTimerLib.RegisterCallback(f, "UNIT_SWING_TIMER_START", SwingTimerEventHandler)
    swingTimerLib.RegisterCallback(f, "UNIT_SWING_TIMER_UPDATE", SwingTimerEventHandler)
    swingTimerLib.RegisterCallback(f, "UNIT_SWING_TIMER_DELTA", SwingTimerEventHandler)

    NAG.swingTimerFrame = f
    NAG.swingTimerInitialized = true
    return true
end

-- ~~~~~~~~~~~~~~~~~~~~
-- Autoattack values

-- ============================ PARRY HASTE (LOCAL OVERRIDE) ============================
-- Parry haste reduces the *parrying unit's* remaining swing timer by 40% of weapon speed,
-- but it cannot go below 20% of weapon speed.
--
-- We cannot edit the external swing timer library (it may be overwritten by other addons),
-- so we apply a local override layer here and feed it into `AutoTimeToNext()` results.
--
-- SwedgeTimer reference: `extern/SwedgeTimer/player.lua` (SWING_MISSED, miss_type == "PARRY")

--- Clears the local parry-haste override state.
--- @param self NAG
local function clearParryHasteOverride(self)
    self._autoParryHasteNextSwingAt = nil
    self._autoParryHasteAppliedAt = nil
    self._autoParryHasteWeaponSpeed = nil
end

--- Returns active parry-haste remaining time from `now`, or nil if no active override.
--- Expired overrides are cleared.
--- @param self NAG
--- @param now number
--- @return number|nil
local function getActiveParryHasteRemainingNow(self, now)
    local overrideAt = self._autoParryHasteNextSwingAt
    if not overrideAt then
        return nil
    end

    local overrideRemaining = overrideAt - now
    if overrideRemaining <= 0 then
        clearParryHasteOverride(self)
        return nil
    end

    return overrideRemaining
end

--- Calculates the parry-hasted remaining time for the current swing only.
--- Rule set:
--- - remaining >= 60% of speed: subtract 40% of speed
--- - 20% < remaining < 60%: clamp to 20% of speed
--- - remaining <= 20%: no change
--- @param oldRemaining number
--- @param weaponSpeed number
--- @return number newRemaining
--- @return boolean didReduce
local function calculateParryHasteRemaining(oldRemaining, weaponSpeed)
    oldRemaining = tonumber(oldRemaining) or 0
    weaponSpeed = tonumber(weaponSpeed) or 0
    if oldRemaining < 0 then
        oldRemaining = 0
    end
    if weaponSpeed <= 0 or oldRemaining <= 0 then
        return oldRemaining, false
    end

    local swingTime60p = weaponSpeed * 0.6
    local swingTime40p = weaponSpeed * 0.4
    local minSwingTime20p = weaponSpeed * 0.2
    local newRemaining = oldRemaining

    if oldRemaining >= swingTime60p then
        newRemaining = oldRemaining - swingTime40p
    elseif oldRemaining > minSwingTime20p then
        newRemaining = minSwingTime20p
    end

    if newRemaining < 0.01 then
        newRemaining = 0.01
    end

    if newRemaining >= (oldRemaining - 0.001) then
        return oldRemaining, false
    end
    return newRemaining, true
end

--- Applies a parry-haste reduction to the player's next melee swing timer.
--- Stores an absolute "next swing at" override which is then honored by `AutoTimeToNext()`.
--- @return boolean applied True if an override was applied
--- @return number|nil newRemainingSeconds The new remaining swing time (seconds) if applied
--- @return number|nil oldRemainingSeconds The prior remaining swing time (seconds) used as input if applied
function NAG:ApplyParryHasteToAutoSwing()
    local now = (GetTime and GetTime()) or 0

    local weaponSpeed = self:AutoSwingTime() or 0
    if weaponSpeed <= 0 then
        return false
    end

    local _, rawTimeToSwing = self:AutoTimeToNext()
    rawTimeToSwing = rawTimeToSwing or 0
    if rawTimeToSwing < 0 then
        rawTimeToSwing = 0
    end

    -- If we already have an active override, apply the reduction on the effective remaining time.
    local overrideRemaining = getActiveParryHasteRemainingNow(self, now)
    if overrideRemaining and overrideRemaining < rawTimeToSwing then
        rawTimeToSwing = overrideRemaining
    end

    local oldRemaining = rawTimeToSwing
    local reduced, applied = calculateParryHasteRemaining(oldRemaining, weaponSpeed)
    if not applied then
        return false
    end

    self._autoParryHasteNextSwingAt = now + reduced
    self._autoParryHasteAppliedAt = now
    self._autoParryHasteWeaponSpeed = weaponSpeed

    -- Invalidate Ret twist HOLD caches so swipe/text can retarget immediately when endAt is reduced.
    -- These caches intentionally stabilize endAt across frames, but parry haste is a real timing jump.
    self._retTwistJudgeHoldEndAt = nil
    self._retTwistSoCHoldEndAt = nil
    self._retTwistJudgeSetupGcdSnapshot = nil
    self._retTwistJudgeSetupLastDisplayableHoldState = nil

    return true, reduced, oldRemaining
end

--- Returns the time until the next auto attack for the player.
--- @function NAG:AutoTimeToNext
--- @return number The time until the next auto attack (GCD affected).
--- @return number The raw time until the next auto attack (not affected by GCD).
--- @usage NAG:AutoTimeToNext() <= x
function NAG:AutoTimeToNext()
    if not swingTimerLib then return 0, 0 end

    initializeSwingTimer()

    -- Get swing timer info for both hands
    local mhSpeed, mhExpiration = swingTimerLib:UnitSwingTimerInfo("player", "mainhand")
    local ohSpeed, ohExpiration = swingTimerLib:UnitSwingTimerInfo("player", "offhand")
    if not mhExpiration then return 0, 0 end -- No valid swing timer

    local currentTime = NAG:NextTime()
    local mhTimeToNext = mhExpiration - currentTime
    local ohTimeToNext = ohExpiration and (ohExpiration - currentTime) or math.huge

    -- Get the shorter time until next swing
    local timeToNextSwing = min(mhTimeToNext, ohTimeToNext)
    -- If negative, add weapon speed to get next window
    local timeToNextSwingUpdated = timeToNextSwing
    if timeToNextSwing < 0 then
        timeToNextSwingUpdated = timeToNextSwing + mhSpeed
    end

    -- Raw time-to-swing from NOW (GetTime horizon), used by twist math.
    local now = (GetTime and GetTime()) or 0
    local rawTimeToSwingNow = mhTimeToNext + currentTime - now -- Reverted from NAG:NextTime() back to GetTime()
    if rawTimeToSwingNow < 0 then
        rawTimeToSwingNow = 0
    end

    -- Apply local parry-haste override (if active).
    local overrideAt = self._autoParryHasteNextSwingAt
    if overrideAt then
        local overrideRemainingNow = getActiveParryHasteRemainingNow(self, now)
        if overrideRemainingNow then
            if overrideRemainingNow < rawTimeToSwingNow then
                rawTimeToSwingNow = overrideRemainingNow
            end

            local overrideRemainingAtAction = overrideAt - currentTime
            if overrideRemainingAtAction > 0 and overrideRemainingAtAction < timeToNextSwingUpdated then
                timeToNextSwingUpdated = overrideRemainingAtAction
            end
        end
    end

    -- Return both GCD-affected and raw times
    return max(0, timeToNextSwingUpdated), max(0, rawTimeToSwingNow)
end

--- Gets the auto swing time for the specified weapon type.
--- @function NAG:AutoSwingTime
--- @param weaponType? string "MainHand", "OffHand", or "Ranged". Defaults to MainHand if not provided.
--- @return number The swing time in seconds, or 0 if invalid.
--- @usage NAG:AutoSwingTime("MainHand")
function NAG:AutoSwingTime(weaponType)
    if not weaponType then
        weaponType = Types:GetType("SwingType").MainHand
    end

    local swingTime
    if weaponType == Types:GetType("SwingType").MainHand then
        swingTime = UnitAttackSpeed("player")
    elseif weaponType == Types:GetType("SwingType").OffHand then
        swingTime = select(2, UnitAttackSpeed("player"))
    elseif weaponType == Types:GetType("SwingType").Ranged then
        swingTime = UnitRangedDamage("player")
    else
        self:Warn("AutoSwingTime: Invalid weapon type: %s", weaponType)
    end
    return swingTime or 0
end

--- Returns true when the player should start auto-attacking the current target.
--- Intended to detect the common case where the player is out of 10-yard range and has not started attacking.
--- Logic:
--- - Target must exist and be attackable
--- - Target distance must be > 10 yards
--- - Auto Attack (6603) must NOT be the current spell (i.e., not already attacking)
--- @function NAG:NeedsToStartAttacking
--- @return boolean True if target is >10y and player is not currently auto-attacking; false otherwise.
--- @usage if NAG:NeedsToStartAttacking() then ... end
function NAG:NeedsToStartAttacking()
    if not UnitExists("target") then
        return false
    end
    if not UnitCanAttack("player", "target") then
        return false
    end

    local distance = self:UnitDistance("target")
    if not distance or distance < 0 then
        return false
    end
    if distance <= 5 then
        return false
    end

    if IsCurrentSpell and IsCurrentSpell(6603) then -- Auto Attack
        return false
    end

    return true
end

--- Returns true if the player is currently auto-attacking the target.
--- Intended to detect if the player has started attacking the current target.
--- Logic:
--- - Target must exist and be attackable
--- - Auto Attack (6603) must be the current spell (i.e., currently attacking)
--- @function NAG:IsAttacking
--- @return boolean True if target exists, is attackable, and player is currently auto-attacking; false otherwise.
--- @usage if NAG:IsAttacking() then ... end
function NAG:IsAttacking()
    if not UnitExists("target") then
        return false
    end
    if not UnitCanAttack("player", "target") then
        return false
    end

    if IsCurrentSpell and IsCurrentSpell(6603) then -- Auto Attack
        return true
    end

    return false
end

-- ============================ SHAMAN: MAELSTROM WEAPON CAST-TIME ADJUSTMENT ============================
-- Enhancement Shaman: Maelstrom Weapon reduces cast time of certain spells by 20% per stack (up to 5).
-- We need to reflect this in weave calculations; WoWAPI GetSpellInfo cast time does not include temporary buffs.
local function clampNumber(value, minValue, maxValue)
    if value == nil then return minValue end
    if value < minValue then return minValue end
    if value > maxValue then return maxValue end
    return value
end

local MAELSTROM_WEAPON_AURA_ID = 51530
local MAELSTROM_AFFECTED_SPELLS = {
    [403] = true,    -- Lightning Bolt
    [421] = true,    -- Chain Lightning
    [117014] = true, -- Elemental Blast
}

local function getMaelstromAdjustedCastTime(self, spellId, baseCastTime)
    if not baseCastTime or baseCastTime <= 0 then
        return baseCastTime or 0
    end
    if self.CLASS_FILENAME ~= "SHAMAN" then
        return baseCastTime
    end
    if not MAELSTROM_AFFECTED_SPELLS[spellId] then
        return baseCastTime
    end

    local stacks = clampNumber(tonumber(self:AuraNumStacks(MAELSTROM_WEAPON_AURA_ID)) or 0, 0, 5)
    if stacks <= 0 then
        return baseCastTime
    end

    local multiplier = 1 - (0.20 * stacks)
    if multiplier < 0 then multiplier = 0 end
    return baseCastTime * multiplier
end

--- Checks if a spell can be safely weaved between auto attacks.
--- For instant cast spells, always returns true since they can't clip auto attacks.
--- For non-instant casts, verifies that the total cast time (input delay + cast time)
--- is less than the time left until the next auto attack.
--- @function NAG:CanWeave
--- @param spellId number The spell ID to check.
--- @return boolean True if the spell can be cast, false otherwise.
--- @usage NAG:CanWeave(12345)
function NAG:CanWeave(spellId)
    local castTime = self:SpellCastTime(spellId) -- Cache was perm storing max casttime: getMaelstromAdjustedCastTime(self, spellId, self:SpellCastTime(spellId))

    -- For instant cast spells, always return true since they can't clip auto attacks
    if castTime == 0 then
        return true
    end


    -- For non-instant casts, check total cast time against swing time
    local gcdTimeToReady = self:GCDTimeToReady()

    -- Apply Maelstrom Weapon logic for input delay with latency awareness and fixed buffer
    local userPing = self:GetNetStats()               -- Use cached network stats
    local baseInputDelay = self:InputDelay() or 0.050 -- fallback to 50ms
    local staticPressBuffer = 0.200                   -- 200ms flat buffer for press-to-cast
    local maelstromStacks = self:AuraNumStacks(51530) -- Maelstrom Weapon spell ID

    -- Final delay: input + ping + 200ms fixed buffer
    local adjustedInputDelay = baseInputDelay + userPing + staticPressBuffer
    if maelstromStacks >= 5 then
        adjustedInputDelay = 0                                  -- instant cast, ignore delay
    else
        adjustedInputDelay = math.min(adjustedInputDelay, 0.45) -- cap at 0.45s
    end

    local swingTimeLeft = self:AutoTimeToNext()
    local totalCastTime = adjustedInputDelay + castTime
    local weaponSpeed = self:AutoSwingTime(Types.SwingType.MainHand)

    return totalCastTime < swingTimeLeft
end

-- ============================ SEAL TWISTING HELPERS ============================
--- Returns the time until the next auto attack *after the current GCD completes*.
--- This is intentionally explicit for APL authors who want to reason about "what can I do next"
--- at the moment the player becomes actionable (GCD end), rather than "right now".
---
--- NOTE: `AutoTimeToNext()` returns two values:
--- 1) a value computed against NAG:NextTime() (may effectively be "at next action time")
--- 2) a raw time-to-next-swing using GetTime() (not GCD-adjusted)
--- For seal twisting we want the second one, adjusted by GCDTimeToReady().
---
--- @function NAG:AutoTimeToNextAfterGCD
--- @return number timeToSwingAfterGCD Seconds until next swing at the moment the GCD is ready (clamped >= 0).
--- @return number rawTimeToSwing Seconds until next swing from *now* (raw, clamped >= 0).
--- @usage NAG:AutoTimeToNextAfterGCD() <= 0.4
function NAG:AutoTimeToNextAfterGCD()
    local _, rawTimeToSwing = self:AutoTimeToNext()
    local gcd = self:GCDTimeToReady() or 0
    if not rawTimeToSwing then
        rawTimeToSwing = 0
    end

    rawTimeToSwing = max(0, rawTimeToSwing)
    if gcd < 0 then gcd = 0 end

    -- If the GCD ends after the next swing occurs, project into the next swing cycle.
    -- This avoids collapsing to 0 ("swingReady") when in reality, at GCD end we are
    -- part-way through the next swing (often "preDiv").
    if gcd > rawTimeToSwing then
        local swingSpeed = self:AutoSwingTime() or 0
        if swingSpeed > 0 then
            return max(0, (rawTimeToSwing + swingSpeed) - gcd), rawTimeToSwing
        end
    end

    return max(0, rawTimeToSwing - gcd), rawTimeToSwing
end

--- Returns the time until the "div boundary" (seconds from now), i.e. the point where starting a new GCD
--- risks pushing the next actionable time into (or past) the twist window.
---
--- For TBC Ret seal twisting we approximate the "div boundary" as:
---     timeToDiv = rawTimeToSwing - (twistWindowSeconds + lastGcdDuration)
---
--- This matches the APL notion of: "how long do I have before I must stop spending a full GCD?"
---
--- @param twistWindowSeconds number|nil Default 0.4
--- @return number timeToDivSeconds Seconds until div boundary from now (clamped >= 0).
--- @usage local t = NAG:RetTwistTimeToDivBoundary(0.4)
function NAG:RetTwistTimeToDivBoundary(twistWindowSeconds)
    local window = twistWindowSeconds or 0.4
    if window < 0 then window = 0 end

    local _, rawTimeToSwing = self:AutoTimeToNext()
    rawTimeToSwing = rawTimeToSwing or 0
    rawTimeToSwing = max(0, rawTimeToSwing)

    local gcdVal = self:GCDTimeValue() or 0
    if gcdVal < 0 then gcdVal = 0 end

    return max(0, rawTimeToSwing - (window + gcdVal))
end

--- Returns the raw (unclamped) time to div boundary. This can be negative after crossing div.
--- @param twistWindowSeconds number|nil Default 0.4
--- @return number rawTimeToDiv Seconds to div boundary from now (can be < 0).
function NAG:RetTwistRawTimeToDivBoundary(twistWindowSeconds)
    local window = twistWindowSeconds or 0.4
    if window < 0 then window = 0 end

    local _, rawTimeToSwing = self:AutoTimeToNext()
    rawTimeToSwing = rawTimeToSwing or 0
    rawTimeToSwing = max(0, rawTimeToSwing)

    local gcdVal = self:GCDTimeValue() or 0
    if gcdVal < 0 then gcdVal = 0 end

    return rawTimeToSwing - (window + gcdVal)
end

--- Returns the raw (unclamped) time to div boundary, evaluated at the next actionable moment.
--- If GCD is running, this projects into the swing cycle where the GCD ends (including rolling
--- into the next swing if the GCD ends after the next swing).
--- If GCD is 0, this is equivalent to RetTwistRawTimeToDivBoundary().
--- @param twistWindowSeconds number|nil Default 0.4
--- @return number rawTimeToDivAtAction Seconds to div boundary at action time (can be < 0).
function NAG:RetTwistRawTimeToDivBoundaryAtAction(twistWindowSeconds)
    local window = twistWindowSeconds or 0.4
    if window < 0 then window = 0 end

    local gcdLeft = self:GCDTimeToReady() or 0
    if gcdLeft < 0 then gcdLeft = 0 end

    local gcdVal = self:GCDTimeValue() or 0
    if gcdVal < 0 then gcdVal = 0 end

    -- Project time-to-swing at the moment we can act.
    local swingAfterGcd, rawSwingNow = self:AutoTimeToNextAfterGCD()
    rawSwingNow = rawSwingNow or 0
    if rawSwingNow < 0 then rawSwingNow = 0 end
    swingAfterGcd = swingAfterGcd or 0
    if swingAfterGcd < 0 then swingAfterGcd = 0 end

    local projectedSwing = (gcdLeft > 0) and swingAfterGcd or rawSwingNow

    -- Show both "simple" (same-cycle) and "projected" (includes next-cycle rollover) values.
    local swingAtActionSimple = max(0, (rawSwingNow or 0) - gcdLeft)
    local swingAtActionProjected = swingAfterGcd or 0
    if not swingAtActionSimple then swingAtActionSimple = 0 end
    if not swingAtActionProjected then swingAtActionProjected = 0 end
    return projectedSwing - (window + gcdVal)
end

--- Stable (hysteresis) "are we before div?" helper to prevent 1-tick flicker when rawTimeToDiv hovers near 0.
--- @param twistWindowSeconds number|nil Default 0.4
--- @param hysteresisSeconds number|nil Default 0.05 (50ms)
--- @return boolean isPreDiv True if we're considered pre-div (stable), false otherwise.
function NAG:RetTwistIsPreDivStable(twistWindowSeconds, hysteresisSeconds)
    local hyst = hysteresisSeconds or 0.05
    if hyst < 0 then hyst = 0 end

    local rawTimeToDiv = self:RetTwistRawTimeToDivBoundary(twistWindowSeconds)
    local prev = self._retTwistPreDivStable

    if prev == nil then
        prev = rawTimeToDiv > 0
        self._retTwistPreDivStable = prev
        return prev
    end

    if prev then
        -- Stay pre-div until we are clearly post-div by the hysteresis margin
        if rawTimeToDiv < -hyst then
            self._retTwistPreDivStable = false
        end
    else
        -- Stay post-div until we are clearly pre-div by the hysteresis margin
        if rawTimeToDiv > hyst then
            self._retTwistPreDivStable = true
        end
    end

    return self._retTwistPreDivStable
end

--- Stable (hysteresis) "are we before div?" helper, evaluated at action time (GCD end).
--- This is the correct basis for "wait for X before div" look-ahead, because those clauses
--- are meant to reason about where the player will be able to act next (not strictly 'right now').
--- @param twistWindowSeconds number|nil Default 0.4
--- @param hysteresisSeconds number|nil Default 0.05 (50ms)
--- @return boolean isPreDiv True if we're considered pre-div at action time (stable), false otherwise.
function NAG:RetTwistIsPreDivStableAtAction(twistWindowSeconds, hysteresisSeconds)
    local hyst = hysteresisSeconds or 0.05
    if hyst < 0 then hyst = 0 end

    local rawTimeToDiv = self:RetTwistRawTimeToDivBoundaryAtAction(twistWindowSeconds)
    local prev = self._retTwistPreDivAtActionStable

    if prev == nil then
        prev = rawTimeToDiv > 0
        self._retTwistPreDivAtActionStable = prev
        return prev
    end

    if prev then
        if rawTimeToDiv < -hyst then
            self._retTwistPreDivAtActionStable = false
        end
    else
        if rawTimeToDiv > hyst then
            self._retTwistPreDivAtActionStable = true
        end
    end

    return self._retTwistPreDivAtActionStable
end

--- Computes a stable, clamped tolerance for "wait for X before div" UX.
--- Returns 0 when we are not in the pre-div region at ACTION TIME (stable).
--- @param maxToleranceSeconds number|nil Hard cap for tolerance (e.g. 3)
--- @param twistWindowSeconds number|nil Default 0.4
--- @param hysteresisSeconds number|nil Default 0.05
--- @return number tolSeconds A tolerance to use in NAG:Cast(spell, tolSeconds)
function NAG:RetTwistWaitToleranceBeforeDiv(maxToleranceSeconds, twistWindowSeconds, hysteresisSeconds)
    local maxTol = maxToleranceSeconds or 0
    if maxTol < 0 then maxTol = 0 end

    if maxTol == 0 then
        return 0
    end

    if not self:RetTwistIsPreDivStableAtAction(twistWindowSeconds, hysteresisSeconds) then
        return 0
    end

    local rawTimeToDiv = self:RetTwistRawTimeToDivBoundaryAtAction(twistWindowSeconds)
    if not rawTimeToDiv or rawTimeToDiv <= 0 then
        return 0
    end

    return min(maxTol, rawTimeToDiv)
end

--- Returns spell cooldown remaining from *now* (GetTime), ignoring NAG:NextTime() horizon.
--- This is required for off-GCD spells like Judgement (TBC), where readiness should not be
--- reduced by current GCD/cast locks.
--- @param spellId number
--- @return number secondsRemaining Returns -1 if cooldown info missing.
local function getSpellCooldownRemainingNow(spellId)
    if not spellId then
        return -1
    end
    local now = (_G.GetTime and _G.GetTime()) or 0
    local cdInfo = WoWAPI and WoWAPI.GetSpellCooldown and WoWAPI.GetSpellCooldown(spellId) or nil
    if not cdInfo then
        return -1
    end
    local start, duration
    if type(cdInfo) == "table" then
        start = cdInfo.startTime or 0
        duration = cdInfo.duration or 0
    else
        -- Defensive: if wrapper is missing and raw multi-return leaks through (rare).
        start = cdInfo or 0
        duration = 0
    end
    if start == 0 or duration == 0 then
        return 0
    end
    local remaining = (start + duration) - now
    if remaining < 0 then
        remaining = 0
    end
    return remaining
end

--- Returns true if we are planning a "Judge -> SoC" setup and Judgement will be ready before
--- the safe div boundary at action time (pre-div, with an extra safety margin).
--- This is used to prevent prematurely casting SoC when we intend to keep a SoB/SoM seal up
--- until Judgement becomes available.
--- @param maxToleranceSeconds number|nil Default 3
--- @param twistWindowSeconds number|nil Default 0.4
--- @param hysteresisSeconds number|nil Default 0.05
--- @param safetySeconds number|nil Default 0.2 (200ms extra safety before div)
--- @return boolean
function NAG:RetTwistJudgeSetupIsPlanned(maxToleranceSeconds, twistWindowSeconds, hysteresisSeconds, safetySeconds)
    local now = (_G.GetTime and _G.GetTime()) or 0
    local shouldPrint = false -- Set true temporarily when investigating Judge setup planning.

    local window = twistWindowSeconds or 0.4
    local hyst = hysteresisSeconds or 0.05
    local maxTol = maxToleranceSeconds or 0
    if maxTol < 0 then maxTol = 0 end

    local gcdLeft = self:GCDTimeToReady() or 0
    if gcdLeft < 0 then gcdLeft = 0 end
    local gcdVal = self:GCDTimeValue() or 0
    if gcdVal < 0 then gcdVal = 0 end
    local swingAtAction, rawSwingNow = self:AutoTimeToNextAfterGCD()
    swingAtAction = swingAtAction or 0
    rawSwingNow = rawSwingNow or 0
    if swingAtAction < 0 then swingAtAction = 0 end
    if rawSwingNow < 0 then rawSwingNow = 0 end
    local rawDivAtActionNow = self:RetTwistRawTimeToDivBoundaryAtAction(window) or 0
    local swingSpeed = self:AutoSwingTime() or 0
    if swingSpeed < 0 then swingSpeed = 0 end
    local rawDivAtActionNext = (swingSpeed > 0) and (rawDivAtActionNow + swingSpeed) or rawDivAtActionNow
    -- If we're post-div in the CURRENT swing at action time, evaluate the wait window against the NEXT swing instead.
    -- This matches the APL intent: "wait for Judge if it will be ready within the safe gap of the next swing".
    local useNextSwing = rawDivAtActionNow <= 0
    local rawDivUsed = useNextSwing and rawDivAtActionNext or rawDivAtActionNow
    local preDivStable = rawDivUsed > hyst

    local soCActive = (self.RetTwistIsSoCActive and self:RetTwistIsSoCActive()) or false
    local soBActive = (self.RetTwistIsSoBActive and self:RetTwistIsSoBActive()) or false

    local tol = 0
    if preDivStable and rawDivUsed > 0 then
        tol = min(maxTol, rawDivUsed)
    end
    if not tol or tol <= 0 then
        return false
    end

    local safety = safetySeconds or 0.2
    if safety < 0 then safety = 0 end

    local safeTolAtAction = tol - safety
    if safeTolAtAction <= 0 then
        return false
    end
    local safeTolFromNow = gcdLeft + safeTolAtAction

    -- IMPORTANT: Use raw cooldown-from-now for Judgement (off-GCD in TBC),
    -- not SpellTimeToReady (which is evaluated against NAG:NextTime()).
    local judgeReadyIn = getSpellCooldownRemainingNow(20271) -- Judgement
    if not judgeReadyIn or judgeReadyIn < 0 then
        return false
    end

    local planned = judgeReadyIn <= safeTolFromNow
    if shouldPrint then
        local remTime = (self.RemainingTime and self:RemainingTime()) or -1
        print(string.format(
            "[JUDGE_HOLD_PLANNED][ver=%s] planned=%s rawDivUsed=%.3f preDivStable=%s tol=%.3f safeTolAction=%.3f safeTolNow=%.3f judgeReadyIn=%.3f swingAtAction=%.3f gcdLeft=%.3f gcdVal=%.3f useNextSwing=%s remTime=%.3f",
            JUDGE_HOLD_LOG_VERSION,
            tostring(planned),
            rawDivUsed or 0,
            tostring(preDivStable),
            tol or 0,
            safeTolAtAction or 0,
            safeTolFromNow or 0,
            judgeReadyIn or -1,
            swingAtAction or 0,
            gcdLeft or 0,
            gcdVal or 0,
            tostring(useNextSwing),
            remTime
        ))
    end
    return planned
end

--- Computes canonical next-swing hold markers from now.
--- Marker A: swingPlusSafety = rawSwingNow + 0.1
--- Marker B: nextSwingPreDivMinusSafety = (rawSwingNow + swingSpeed - window) - 0.2
--- Ensures Marker B is never below Marker A.
--- @param rawSwingNow number
--- @param swingSpeed number
--- @param window number
--- @return number swingPlusSafety
--- @return number nextSwingPreDivMinusSafety
local function getRetTwistCanonicalHoldMarkers(rawSwingNow, swingSpeed, window)
    local raw = rawSwingNow or 0
    if raw < 0 then raw = 0 end

    local speed = swingSpeed or 0
    if speed < 0 then speed = 0 end
    if speed <= 0 and raw > 0 then
        speed = raw
    end

    local holdPostSwingSafety = 0.1
    local preDivSafety = 0.2

    local swingPlusSafety = raw + holdPostSwingSafety
    local nextSwingPreDivMinusSafety = (raw + speed - window) - preDivSafety
    if nextSwingPreDivMinusSafety < swingPlusSafety then
        nextSwingPreDivMinusSafety = swingPlusSafety
    end

    return swingPlusSafety, nextSwingPreDivMinusSafety
end

--- Returns true when post-div next-swing HOLD can be deferred to allow filler checks first.
--- Rule (user-tuned): if `gcdVal - rawSwingNow > swingSpeed - window - gcdVal - 0.2`,
--- do not force early Judge/SoC HOLD in the primary planned branch.
--- @param rawSwingNow number
--- @param swingSpeed number
--- @param window number
--- @param gcdVal number
--- @return boolean
--- @return number lhs
--- @return number rhs
local function canRetTwistDeferNextSwingHoldForFillers(rawSwingNow, swingSpeed, window, gcdVal)
    local raw = rawSwingNow or 0
    if raw < 0 then raw = 0 end

    local speed = swingSpeed or 0
    if speed < 0 then speed = 0 end

    local gcd = gcdVal or 0
    if gcd < 0 then gcd = 0 end

    local holdBuffer = 0.2
    local lhs = gcd - raw
    local rhs = speed - window - gcd - holdBuffer
    return lhs > rhs, lhs, rhs
end

--- Returns a tolerance to use for "WAIT for Judgement before div" UX.
--- If the return value is > 0, the APL should recommend Judgement with that tolerance (i.e., show the icon + swipe).
--- If the return value is 0, the APL should NOT wait; it should allow fillers to proceed.
--- Rules:
--- - Only wait if Judgement becomes ready before the safe div boundary at action time.
--- - If we can fit ONE full GCD (+ a buffer) before Judgement, AND still be safely pre-div, do not wait (allow a filler).
--- @param maxToleranceSeconds number|nil Default 3
--- @param twistWindowSeconds number|nil Default 0.4
--- @param hysteresisSeconds number|nil Default 0.05
--- @param safetySeconds number|nil Default 0.2
--- @param fillerBufferSeconds number|nil Default 0.3
--- @return number tolSeconds
function NAG:RetTwistJudgeSetupWaitTolerance(maxToleranceSeconds, twistWindowSeconds, hysteresisSeconds, safetySeconds, fillerBufferSeconds)
    local now = (_G.GetTime and _G.GetTime()) or 0
    local remTime = (self.RemainingTime and self:RemainingTime()) or -1
    local gcdLeft = self:GCDTimeToReady() or 0
    if gcdLeft < 0 then gcdLeft = 0 end
    -- Diagnostic: log return reasons when on GCD and dev mode (to investigate Judge+SoC display blocking)
    local shouldPrint = (self.IsDevModeEnabled and self:IsDevModeEnabled()) and (gcdLeft > 0)

    local window = twistWindowSeconds or 0.4
    local hyst = hysteresisSeconds or 0.05
    local maxTol = maxToleranceSeconds or 0
    if maxTol < 0 then maxTol = 0 end

    local gcdVal = self:GCDTimeValue() or 0
    if gcdVal < 0 then gcdVal = 0 end
    local swingAtAction, rawSwingNow = self:AutoTimeToNextAfterGCD()
    swingAtAction = swingAtAction or 0
    rawSwingNow = rawSwingNow or 0
    if swingAtAction < 0 then swingAtAction = 0 end
    if rawSwingNow < 0 then rawSwingNow = 0 end
    local rawDivAtActionNow = self:RetTwistRawTimeToDivBoundaryAtAction(window) or 0
    local swingSpeed = self:AutoSwingTime() or 0
    if swingSpeed < 0 then swingSpeed = 0 end
    local rawDivAtActionNext = (swingSpeed > 0) and (rawDivAtActionNow + swingSpeed) or rawDivAtActionNow
    local useNextSwing = rawDivAtActionNow <= 0
    local rawDivUsed = useNextSwing and rawDivAtActionNext or rawDivAtActionNow
    local preDivStable = rawDivUsed > hyst
    local postSwingGuardActive = false
    local postSwingGuardHoldFromNow = 0

    -- Extra-safe post-swing guard: if the projected action point lands in the first
    -- 100ms after a swing, force a HOLD window (instead of dropping Judge+SoC visibility).
    local postSwingSafetySeconds = 0.1
    if swingSpeed > 0 and swingAtAction > 0 then
        local sinceLastSwingAtAction = swingSpeed - swingAtAction
        if sinceLastSwingAtAction < 0 then
            sinceLastSwingAtAction = 0
        end
        if sinceLastSwingAtAction <= postSwingSafetySeconds then
            postSwingGuardActive = true
            postSwingGuardHoldFromNow = gcdLeft + (postSwingSafetySeconds - sinceLastSwingAtAction)
            if postSwingGuardHoldFromNow < 0.05 then
                postSwingGuardHoldFromNow = 0.05
            end
            if shouldPrint then
                print(string.format(
                    "[JUDGE_HOLD_TOL][ver=%s] reason=post_swing_guard mark_hold sinceLastSwingAtAction=%.3f guard=%.3f holdFromNow=%.3f swingAtAction=%.3f swingSpeed=%.3f gcdLeft=%.3f",
                    JUDGE_HOLD_LOG_VERSION,
                    sinceLastSwingAtAction,
                    postSwingSafetySeconds,
                    postSwingGuardHoldFromNow,
                    swingAtAction or 0,
                    swingSpeed or 0,
                    gcdLeft or 0
                ))
            end
        end
    end

    local soCActive = (self.RetTwistIsSoCActive and self:RetTwistIsSoCActive()) or false
    local soBActive = (self.RetTwistIsSoBActive and self:RetTwistIsSoBActive()) or false

    local tol = 0
    if preDivStable and rawDivUsed > 0 then
        tol = min(maxTol, rawDivUsed)
    end
    if not tol or tol <= 0 then
        if shouldPrint then
            print(string.format(
                "[JUDGE_HOLD_TOL][ver=%s] result=0 reason=no_prediv_tol rawDivUsed=%.3f preDivStable=%s maxTol=%.3f",
                JUDGE_HOLD_LOG_VERSION,
                rawDivUsed or 0,
                tostring(preDivStable),
                maxTol or 0
            ))
        end
        return 0
    end

    local safety = safetySeconds or 0.2
    if safety < 0 then safety = 0 end

    local safeTolAtAction = tol - safety
    if safeTolAtAction <= 0 then
        if shouldPrint then
            print(string.format(
                "[JUDGE_HOLD_TOL][ver=%s] result=0 reason=safe_tol_non_positive tol=%.3f safety=%.3f safeTolAction=%.3f gcdLeft=%.3f",
                JUDGE_HOLD_LOG_VERSION,
                tol or 0,
                safety or 0,
                safeTolAtAction or 0,
                gcdLeft or 0
            ))
        end
        return 0
    end
    local safeTolFromNow = gcdLeft + safeTolAtAction

    -- IMPORTANT: Use raw cooldown-from-now for Judgement (off-GCD in TBC),
    -- not SpellTimeToReady (which is evaluated against NAG:NextTime()).
    local judgeReadyIn = getSpellCooldownRemainingNow(20271) -- Judgement
    if not judgeReadyIn or judgeReadyIn < 0 then
        if shouldPrint then
            print(string.format(
                "[JUDGE_HOLD_TOL][ver=%s] result=0 reason=invalid_judge_ready judgeReadyIn=%s safeTolNow=%.3f safeTolAction=%.3f",
                JUDGE_HOLD_LOG_VERSION,
                tostring(judgeReadyIn),
                safeTolFromNow or 0,
                safeTolAtAction or 0
            ))
        end
        return 0
    end
    -- Small epsilon for boundary stability: avoid dropping Judge setup on near-equal
    -- values caused by frame timing/rounding at the safe-window edge.
    local judgeAfterSafeWindowEpsilon = 0.05
    if judgeReadyIn > (safeTolFromNow + judgeAfterSafeWindowEpsilon) then
        -- Won't be ready before safe div; don't block fillers.
        if shouldPrint then
            print(string.format(
                "[JUDGE_HOLD_TOL][ver=%s] result=0 reason=judge_after_safe_window judgeReadyIn=%.3f safeTolNow=%.3f safeTolAction=%.3f eps=%.3f gcdLeft=%.3f useNextSwing=%s",
                JUDGE_HOLD_LOG_VERSION,
                judgeReadyIn or 0,
                safeTolFromNow or 0,
                safeTolAtAction or 0,
                judgeAfterSafeWindowEpsilon or 0,
                gcdLeft or 0,
                tostring(useNextSwing)
            ))
        end
        return 0
    end

    -- If Judgement is ready now:
    -- - current-swing pre-div plan: display immediately
    -- - next-swing plan (post-div / before-gap): HOLD until next-swing setup time
    -- Exception: post-swing guard forces a short HOLD to avoid recommending Judgement within 0.1s after a swing.
    if judgeReadyIn <= 0 then
        if postSwingGuardActive then
            if postSwingGuardHoldFromNow > safeTolFromNow then
                if shouldPrint then
                    print(string.format(
                        "[JUDGE_HOLD_TOL][ver=%s] result=0 reason=post_swing_guard_exceeds_safe hold=%.3f safeTolNow=%.3f",
                        JUDGE_HOLD_LOG_VERSION,
                        postSwingGuardHoldFromNow or 0,
                        safeTolFromNow or 0
                    ))
                end
                return 0
            end
            if shouldPrint then
                print(string.format(
                    "[JUDGE_HOLD_TOL][ver=%s] result=%.3f reason=post_swing_guard_judge_ready_now hold=%.3f safeTolNow=%.3f",
                    JUDGE_HOLD_LOG_VERSION,
                    postSwingGuardHoldFromNow or 0,
                    postSwingGuardHoldFromNow or 0,
                    safeTolFromNow or 0
                ))
            end
            return postSwingGuardHoldFromNow
        end

        if useNextSwing then
            -- Next-swing planning means that at action time we are already post-div.
            -- Even if Judgement is ready now, do not force an "immediate" Judge+SoC call
            -- while GCD is active; keep HOLD timing for the next-swing setup.
            local allowFillerGap, fillerLhs, fillerRhs = canRetTwistDeferNextSwingHoldForFillers(rawSwingNow, swingSpeed, window, gcdVal)
            if allowFillerGap then
                if shouldPrint then
                    print(string.format(
                        "[JUDGE_HOLD_TOL][ver=%s] result=0 reason=next_swing_filler_gap_allowed lhs=%.3f rhs=%.3f rawSwingNow=%.3f swingSpeed=%.3f gcdVal=%.3f",
                        JUDGE_HOLD_LOG_VERSION,
                        fillerLhs or 0,
                        fillerRhs or 0,
                        rawSwingNow or 0,
                        swingSpeed or 0,
                        gcdVal or 0
                    ))
                end
                return 0
            end

            -- Post-div / before-gap path: keep Judge+SoC on HOLD for next-swing setup.
            -- Use swing + 0.2s to avoid early setup calls in this region.
            local holdForNextSwing = rawSwingNow + 0.2
            if holdForNextSwing < 0.05 then
                holdForNextSwing = 0.05
            end
            if holdForNextSwing > safeTolFromNow then
                if shouldPrint then
                    print(string.format(
                        "[JUDGE_HOLD_TOL][ver=%s] result=0 reason=judge_ready_now_next_swing_hold_exceeds_safe hold=%.3f safeTolNow=%.3f rawSwingNow=%.3f remTime=%.3f",
                        JUDGE_HOLD_LOG_VERSION,
                        holdForNextSwing or 0,
                        safeTolFromNow or 0,
                        rawSwingNow or 0,
                        remTime
                    ))
                end
                return 0
            end
            if shouldPrint then
                print(string.format(
                    "[JUDGE_HOLD_TOL][ver=%s] result=%.3f reason=judge_ready_now_next_swing_hold safeTolNow=%.3f rawSwingNow=%.3f useNextSwing=%s remTime=%.3f",
                    JUDGE_HOLD_LOG_VERSION,
                    holdForNextSwing or 0,
                    safeTolFromNow or 0,
                    rawSwingNow or 0,
                    tostring(useNextSwing),
                    remTime
                ))
            end
            return holdForNextSwing
        end

        if shouldPrint then
            print(string.format(
                "[JUDGE_HOLD_TOL][ver=%s] result=-1 reason=judge_ready_now safeTolNow=%.3f safeTolAction=%.3f rawDivUsed=%.3f gcdLeft=%.3f useNextSwing=%s",
                JUDGE_HOLD_LOG_VERSION,
                safeTolFromNow or 0,
                safeTolAtAction or 0,
                rawDivUsed or 0,
                gcdLeft or 0,
                tostring(useNextSwing)
            ))
        end
        return -1
    end

    -- Decide if we should allow ONE filler GCD before Judgement.
    local buffer = fillerBufferSeconds or 0.3
    if buffer < 0 then buffer = 0 end

    -- Decide if we should allow ONE filler GCD before the planned "Judge -> SoC" setup.
    --
    -- IMPORTANT (TBC Ret): Judgement is OFF-GCD, but SoC is ON-GCD.
    -- If we spend a filler GCD now, the earliest we can press SoC is after that filler GCD ends.
    -- We must also have Judgement available by then (or we can wait a bit for it), since we want:
    --   Judge (off-gcd) -> immediately SoC (on-gcd)
    --
    -- So the relevant timeline for safety is when SoC would be pressed/landed from now:
    --   predictionLand = gcdLeft + gcdVal
    --   soCPressInFromNow = max(predictionLand, judgeReadyIn) + buffer
    -- If that fits within safeTolFromNow, a filler can be squeezed in and we should NOT wait-block.
    local predictionLand = gcdLeft + gcdVal
    local soCPressInFromNow = max(predictionLand, judgeReadyIn) + buffer

    -- Tighten filler allowance near div/mid boundary:
    -- require an additional reserve before allowing filler so Judge+SoC gets priority unless
    -- the setup has clearly enough headroom.
    local judgeFillerMidDivReserveSeconds = 0.25
    if judgeFillerMidDivReserveSeconds < 0 then
        judgeFillerMidDivReserveSeconds = 0
    end
    local fillerRequiredHeadroom = soCPressInFromNow + judgeFillerMidDivReserveSeconds
    local fillerMargin = safeTolFromNow - fillerRequiredHeadroom
    local canFitFiller = fillerMargin >= 0
    if canFitFiller then
        -- Filler can fit: do NOT return 0. Return the hold value so Judge+SoC still displays
        -- with a countdown. Fillers run during the hold; Judge+SoC is the upcoming action.
        local swingPlusSafety, nextSwingPreDivMinusSafety = getRetTwistCanonicalHoldMarkers(rawSwingNow, swingSpeed, window)
        local holdSource = "filler_fits_hold"
        local holdSeconds = judgeReadyIn
        if useNextSwing then
            holdSource = "filler_fits_swing_plus_safety"
            holdSeconds = swingPlusSafety
            if judgeReadyIn >= swingPlusSafety and judgeReadyIn <= nextSwingPreDivMinusSafety then
                holdSource = "filler_fits_judge_ready_in"
                holdSeconds = judgeReadyIn
            end
        end
        if holdSeconds > safeTolFromNow then
            holdSeconds = safeTolFromNow
        end
        if holdSeconds < 0.05 then
            holdSeconds = 0.05
        end
        if shouldPrint then
            print(string.format(
                "[JUDGE_HOLD_TOL][ver=%s] result=%.3f reason=filler_fits_return_hold safeTolNow=%.3f fillerMargin=%.3f holdSource=%s holdSeconds=%.3f judgeReadyIn=%.3f useNextSwing=%s",
                JUDGE_HOLD_LOG_VERSION,
                holdSeconds or 0,
                safeTolFromNow or 0,
                fillerMargin or 0,
                holdSource,
                holdSeconds or 0,
                judgeReadyIn or 0,
                tostring(useNextSwing)
            ))
        end
        return holdSeconds
    end

    -- Current-swing pre-div plan:
    -- when useNextSwing=false, we should hold to Judge readiness (with post-swing guard floor),
    -- not to full swing+0.1. Otherwise we can incorrectly drop a valid Judge plan right after swing.
    local holdSource = "judge_ready_in_current_swing"
    local holdSeconds = judgeReadyIn
    local swingPlusSafety, nextSwingPreDivMinusSafety = getRetTwistCanonicalHoldMarkers(rawSwingNow, swingSpeed, window)
    if useNextSwing then
        -- Next-swing plan:
        -- HOLD must resolve to one of:
        -- 1) swingPlusSafety (judge ready now OR judge too late for next-swing pre-div safety)
        -- 2) judgeReadyIn (judge comes ready between swingPlusSafety and nextSwingPreDivMinusSafety)
        holdSource = "swing_plus_safety"
        holdSeconds = swingPlusSafety
        if judgeReadyIn >= swingPlusSafety and judgeReadyIn <= nextSwingPreDivMinusSafety then
            holdSource = "judge_ready_in"
            holdSeconds = judgeReadyIn
        end
    end

    if postSwingGuardActive and postSwingGuardHoldFromNow > holdSeconds then
        holdSource = "post_swing_guard_floor"
        holdSeconds = postSwingGuardHoldFromNow
    end

    -- Option B: When on GCD, relax hold_exceeds_safe slightly. Player cannot act until GCD ends,
    -- so a hold that extends past the strict window by up to half a GCD is still displayable.
    local effectiveSafeTol = safeTolFromNow
    if gcdLeft > 0 and gcdVal > 0 then
        effectiveSafeTol = safeTolFromNow + (gcdVal * 0.5)
    end
    if holdSeconds > effectiveSafeTol then
        if shouldPrint then
            print(string.format(
                "[JUDGE_HOLD_TOL][ver=%s] result=0 reason=hold_exceeds_safe hold=%.3f safeTolNow=%.3f effectiveSafeTol=%.3f source=%s swingPlusSafety=%.3f nextSwingPreDivMinusSafety=%.3f judgeReadyIn=%.3f",
                JUDGE_HOLD_LOG_VERSION,
                holdSeconds or 0,
                safeTolFromNow or 0,
                effectiveSafeTol or 0,
                holdSource,
                swingPlusSafety or 0,
                nextSwingPreDivMinusSafety or 0,
                judgeReadyIn or 0
            ))
        end
        return 0
    end

    if holdSeconds <= 0 then
        if shouldPrint then
            print(string.format(
                "[JUDGE_HOLD_TOL][ver=%s] result=-1 reason=immediate_ready_now safeTolNow=%.3f safeTolAction=%.3f swingAtAction=%.3f useNextSwing=%s",
                JUDGE_HOLD_LOG_VERSION,
                safeTolFromNow or 0,
                safeTolAtAction or 0,
                swingAtAction or 0,
                tostring(useNextSwing)
            ))
        end
        return -1
    end

    if holdSeconds < 0.05 then
        holdSeconds = 0.05
    end

    if shouldPrint then
        print(string.format(
            "[JUDGE_HOLD_TOL][ver=%s] result=%.3f reason=hold_calibrated source=%s safeTolNow=%.3f safeTolAction=%.3f swingPlusSafety=%.3f nextSwingPreDivMinusSafety=%.3f soCPressInNow=%.3f predictionLand=%.3f judgeReadyIn=%.3f rawDivUsed=%.3f gcdLeft=%.3f useNextSwing=%s",
            JUDGE_HOLD_LOG_VERSION,
            holdSeconds or 0,
            holdSource,
            safeTolFromNow or 0,
            safeTolAtAction or 0,
            swingPlusSafety or 0,
            nextSwingPreDivMinusSafety or 0,
            soCPressInFromNow or 0,
            predictionLand or 0,
            judgeReadyIn or 0,
            rawDivUsed or 0,
            gcdLeft or 0,
            tostring(useNextSwing)
        ))
    end
    return holdSeconds
end

--- Returns true if we are in the WA-style "div hold region" at action time (GCD end):
--- windowSeconds < timeToSwingAtAction <= windowSeconds + gcdDurationValue
--- This is used to decide when we must HOLD to avoid spending a full GCD and missing the twist.
--- @param windowSeconds number|nil Default 0.4
--- @return boolean
function NAG:RetTwistIsInHoldRegion(windowSeconds)
    local window = windowSeconds or 0.4
    if window < 0 then window = 0 end

    if not (self.RetTwistIsSoCActive and self:RetTwistIsSoCActive()) then
        return false
    end

    local gcdVal = self:GCDTimeValue() or 0
    if gcdVal < 0 then gcdVal = 0 end

    -- First return from AutoTimeToNextAfterGCD is "timeToSwing at action time" (includes next-cycle projection).
    local timeToSwingAtAction = self:AutoTimeToNextAfterGCD()
    if not timeToSwingAtAction or timeToSwingAtAction <= 0 then
        return false
    end

    return (timeToSwingAtAction > window) and (timeToSwingAtAction <= (window + gcdVal))
end

--- Returns the WA-like swing timing category based on current swing position.
--- Categories:
--- - "before_div"
--- - "after_div_before_gap"
--- - "in_twist"
--- - "swing_ready"
--- @param windowSeconds number|nil Default 0.4
--- @return string category
--- @return number rawDivNow
--- @return number twistGapNow
function NAG:RetTwistGetSwingTimingCategory(windowSeconds)
    local window = windowSeconds or 0.4
    if window < 0 then window = 0 end

    local gcdLeft = self:GCDTimeToReady() or 0
    if gcdLeft < 0 then gcdLeft = 0 end

    local _, rawSwingNow = self:AutoTimeToNext()
    rawSwingNow = rawSwingNow or 0
    -- Conservative action-time awareness:
    -- when GCD is active, prefer the larger of "raw now" and
    -- "projected-at-action + gcdLeft" so stale/cached short reads
    -- don't incorrectly collapse pre-div into HOLD-only branches.
    if gcdLeft > 0 then
        local projectedAtAction = self:AutoTimeToNextAfterGCD()
        if projectedAtAction and projectedAtAction > 0 then
            local projectedNow = projectedAtAction + gcdLeft
            if projectedNow > rawSwingNow then
                rawSwingNow = projectedNow
            end
        end
    end
    if rawSwingNow <= 0 then
        return "swing_ready", 0, 0
    end

    local gcdVal = self:GCDTimeValue() or 0
    if gcdVal < 0 then gcdVal = 0 end

    local rawDivNow = rawSwingNow - (window + gcdVal)
    local twistGapNow = rawSwingNow - window

    if rawDivNow > 0 then
        return "before_div", rawDivNow, twistGapNow
    end
    if twistGapNow <= 0 then
        return "in_twist", rawDivNow, twistGapNow
    end
    return "after_div_before_gap", rawDivNow, twistGapNow
end

--- Returns the configured Ret filler source position from PaladinRetTwistBar settings.
--- Falls back to left1 when the module/db is unavailable.
--- @return string
function NAG:RetTwistGetFillerSourcePosition()
    local fallback = "left1"
    if not (self and self.GetModule) then
        return fallback
    end

    local twistBar = self:GetModule("PaladinRetTwistBar", true)
    if not twistBar or not twistBar.db or not twistBar.db.class then
        return fallback
    end

    local position = twistBar.db.class.fillerSourcePosition
    if position == "right1" then
        return "right1"
    end
    return fallback
end

--- Returns the arrow orientation for the configured Ret filler side.
--- left1 => RIGHT (arrow on right edge), right1 => LEFT (arrow on left edge).
--- @return string
function NAG:RetTwistGetFillerArrowOrientation()
    return (self:RetTwistGetFillerSourcePosition() == "right1") and "LEFT" or "RIGHT"
end

--- Returns true when SoC is allowed for a Judge setup under current timing.
--- @param maxToleranceSeconds number|nil
--- @param twistWindowSeconds number|nil
--- @param hysteresisSeconds number|nil
--- @param safetySeconds number|nil
--- @param fillerBufferSeconds number|nil
--- @return boolean
function NAG:RetTwistCanExposeSoCForJudgeSetup(maxToleranceSeconds, twistWindowSeconds, hysteresisSeconds, safetySeconds, fillerBufferSeconds)
    if not (self.RetTwistIsSoBActive and self:RetTwistIsSoBActive()) then
        return false
    end
    if not self:RetTwistJudgeSetupIsPlanned(maxToleranceSeconds, twistWindowSeconds, hysteresisSeconds, safetySeconds) then
        return false
    end
    local hold = self:RetTwistJudgeSetupWaitTolerance(
        maxToleranceSeconds,
        twistWindowSeconds,
        hysteresisSeconds,
        safetySeconds,
        fillerBufferSeconds
    ) or 0
    return hold ~= 0
end

--- Returns true when SoC is allowed to prep an immediate upcoming twist state.
--- This is stricter than generic pre-div logic and focuses on immediate timing buckets.
--- @param windowSeconds number|nil Default 0.4
--- @return boolean
function NAG:RetTwistCanExposeSoCForImmediateTwistPrep(windowSeconds)
    if not (self.RetTwistIsSoBActive and self:RetTwistIsSoBActive()) then
        return false
    end

    local category = self:RetTwistGetSwingTimingCategory(windowSeconds)
    if category == "after_div_before_gap" or category == "in_twist" or category == "swing_ready" then
        return true
    end
    return false
end

--- Returns true when policy says we should keep SoB active and avoid exposing SoC.
--- This encodes the Ret golden rule: maximize SoB weapon swings unless setup timing requires SoC.
--- @param windowSeconds number|nil Default 0.4
--- @param maxToleranceSeconds number|nil Default 3
--- @param hysteresisSeconds number|nil Default 0.05
--- @param safetySeconds number|nil Default 0.2
--- @param fillerBufferSeconds number|nil Default 0.3
--- @return boolean
function NAG:RetTwistShouldPreferSoBForSwing(windowSeconds, maxToleranceSeconds, hysteresisSeconds, safetySeconds, fillerBufferSeconds)
    if not (self.RetTwistIsSoBActive and self:RetTwistIsSoBActive()) then
        return false
    end

    local window = windowSeconds or 0.4
    local maxTol = maxToleranceSeconds or 3
    local hyst = hysteresisSeconds or 0.05
    local safety = safetySeconds or 0.2
    local fillerBuffer = fillerBufferSeconds or 0.3

    if self:RetTwistCanExposeSoCForJudgeSetup(maxTol, window, hyst, safety, fillerBuffer) then
        retTwistPolicyDebug(self, "[RET_SOB_POLICY] preferSoB=false reason=judge_setup_allowed")
        return false
    end

    if self:RetTwistCanExposeSoCForImmediateTwistPrep(window) then
        retTwistPolicyDebug(self, "[RET_SOB_POLICY] preferSoB=false reason=immediate_twist_prep_allowed")
        return false
    end

    local category = self:RetTwistGetSwingTimingCategory(window)
    local judgeReady = self.SpellIsReady and self:SpellIsReady(20271) or false
    if category == "before_div" and (not judgeReady) then
        local csBlocksCurrentPreDiv = self:RetTwistShouldBlockSoCSetupForCS(window, "current_pre_div")
        if not csBlocksCurrentPreDiv then
            -- Current-swing pre-div setup is feasible and CS is not an immediate blocker for this swing.
            -- In this specific state, do not force SoB retention; allow plain SoC setup path.
            retTwistPolicyDebug(self, "[RET_SOB_POLICY] preferSoB=false reason=prediv_soc_allowed_judge_not_ready")
            return false
        end
        local csBlocksNextPreDiv = self:RetTwistShouldBlockSoCSetupForCS(window, "next_swing_pre_div")
        if not csBlocksNextPreDiv then
            -- GCD/action timing can miss current pre-div while still allowing a valid next-swing pre-div setup.
            -- In this case, do not force SoB retention; allow SoC setup/hold path to plan for next swing.
            retTwistPolicyDebug(self, "[RET_SOB_POLICY] preferSoB=false reason=next_prediv_soc_allowed_judge_not_ready")
            return false
        end
    end

    retTwistPolicyDebug(self, string.format("[RET_SOB_POLICY] preferSoB=true reason=retain_sob category=%s", tostring(category)))
    if self.RetTwistDebugBranchWinner then
        self:RetTwistDebugBranchWinner("retain_sob", tostring(category))
    end
    return true
end

--- Checks if we can execute a seal twist at GCD end (i.e., the next action time) inside the twist window.
--- This is analogous to `CanWeave`, but for **instant** seal swaps that must land within the
--- last `windowSeconds` before the next auto attack.
---
--- A twist is considered possible if, when the GCD ends:
--- - there is still time before the swing occurs, and
--- - we are within the twist window (time_to_swing <= windowSeconds), and
--- - our estimated press+latency delay fits inside that remaining time.
---
--- @function NAG:CanTwist
--- @param windowSeconds number|nil Twist window size in seconds (default: 0.4)
--- @param extraDelaySeconds number|nil Optional extra delay buffer (e.g., reaction time) to add (default: 0)
--- @return boolean True if we can twist within the upcoming swing window, false otherwise.
--- @usage NAG:CanTwist(0.4)
function NAG:CanTwist(windowSeconds, extraDelaySeconds)
    local window = windowSeconds or 0.4
    if window <= 0 then
        return false
    end

    local timeToSwingAfterGCD = self:AutoTimeToNextAfterGCD()
    if not timeToSwingAfterGCD or timeToSwingAfterGCD <= 0 then
        return false
    end

    if timeToSwingAfterGCD > window then
        return false
    end

    -- Seal twisting is an instant swap inside a very small window (~0.4s).
    -- For this TBC Ret implementation we intentionally IGNORE ping in all twist decisions.
    -- We model only:
    -- - fixed input delay of 0.1s (per project decision)
    -- - optional extraDelaySeconds (reaction/extra buffer)
    local baseInputDelay = 0.1

    local extra = extraDelaySeconds or 0
    if extra < 0 then
        extra = 0
    end

    -- If our estimated delay already exceeds the entire window, twisting is not realistically possible.
    local adjustedInputDelay = baseInputDelay + extra
    if adjustedInputDelay >= window then
        return false
    end

    return adjustedInputDelay <= timeToSwingAfterGCD
end

--- Debug helper for Ret seal twisting.
--- Prints the current swing timing state AND the projected state at GCD end:
--- - "preDiv": enough time for a full GCD before the twist window
--- - "postDiv": inside the sensitive region (a full GCD would push into/past twist window)
--- - "twist": inside the actual twist window (<= windowSeconds)
---
--- This function intentionally returns false so it can be inserted into an APL as:
--- `or (NAG:InCombat() and NAG:RetTwistDebugTick())`
--- without affecting the chosen action.
--- @return boolean Always returns false.
function NAG:RetTwistDebugTick()
    -- Debug prints disabled (was used for investigating HOLD<->CS flicker).
    -- Intentionally keep this function as a no-op so APLs that still reference it won't break.
    return false
end

--- Returns the predicted "hold until" time (seconds from now) for the next twist window to open.
--- This is a minimal, timing-only analogue of the WA's `predictionHold` concept:
--- we model the next twist opportunity as `max(0, rawTimeToSwing - windowSeconds)`.
--- @param windowSeconds number|nil Twist window size in seconds (default: 0.4)
--- @return number holdSeconds Seconds from now until the twist window opens (clamped >= 0).
--- @usage local hold = NAG:RetTwistTimeToTwistWindow(0.4)
function NAG:RetTwistTimeToTwistWindow(windowSeconds)
    local window = windowSeconds or 0.4
    -- Time-until-gap is a UI hint: "how long until the twist window opens?"
    -- If the current GCD would finish AFTER the next swing, count down to the NEXT swing cycle's window.
    local _, rawTimeToSwing = self:AutoTimeToNext()
    rawTimeToSwing = rawTimeToSwing or 0
    rawTimeToSwing = max(0, rawTimeToSwing)

    local gcdLeft = self:GCDTimeToReady() or 0
    if gcdLeft < 0 then gcdLeft = 0 end

    if rawTimeToSwing <= 0 then
        return 0
    end

    if gcdLeft > rawTimeToSwing then
        -- We won't be able to act before this swing; use the next swing cycle.
        local swingSpeed = self:AutoSwingTime() or 0
        if swingSpeed <= 0 then
            return 0
        end
        local holdIn = max(0, (rawTimeToSwing + swingSpeed) - window)
        return holdIn
    end

    -- We can act before the next swing; count down to the current cycle's twist window.
    return max(0, rawTimeToSwing - window)
end

-- ============================ STARTATTACK SPAM DETECTION ============================

--- Record a user "attack pressed" signal.
--- Intended to be called from a macro via `/nagattack`.
---
--- Behavior:
--- - Sets a short-lived flag for 0.30s (extended on repeated calls)
--- - Records press timestamps into a small ring buffer for rate/interval checks
---
--- Runtime-only: stored in `NAG.state` (no AceDB writes).
function NAG:AttackPressed()
    local now = GetTime()

    self.state = self.state or {}
    self.state.attackSpam = self.state.attackSpam or {}
    local st = self.state.attackSpam

    -- "Pressed recently" window (resets on every press)
    st.attackPressedUntil = now + 0.30

    -- Ring buffer of recent press times
    st.pressTimes = st.pressTimes or {}
    st.pressCount = st.pressCount or 0
    st.pressIndex = st.pressIndex or 0

    local maxSamples = 12
    st.pressIndex = (st.pressIndex % maxSamples) + 1
    st.pressTimes[st.pressIndex] = now
    if st.pressCount < maxSamples then
        st.pressCount = st.pressCount + 1
    end
end

--- Return current attack spam statistics.
--- @return table stats
function NAG:GetAttackSpamStats()
    local now = GetTime()

    self.state = self.state or {}
    local st = self.state.attackSpam
    if not st or not st.pressTimes or not st.pressCount or st.pressCount <= 0 then
        return {
            pressesLast1s = 0,
            lastPressAt = nil,
            lastPressAgo = nil,
            avgInterval = nil,
        }
    end

    local cutoff = now - 1.0
    local times = {}
    local lastPressAt = nil

    local maxSamples = 12
    local limit = min(st.pressCount, maxSamples)
    for i = 1, limit do
        local t = st.pressTimes[i]
        if t and t >= cutoff and t <= now then
            times[#times + 1] = t
            if not lastPressAt or t > lastPressAt then
                lastPressAt = t
            end
        end
    end

    local pressesLast1s = #times
    local lastPressAgo = lastPressAt and (now - lastPressAt) or nil

    local avgInterval = nil
    if pressesLast1s >= 2 then
        table.sort(times)
        local sum = 0
        local n = 0
        for i = 2, pressesLast1s do
            local dt = times[i] - times[i - 1]
            if dt > 0 and dt < 1.0 then
                sum = sum + dt
                n = n + 1
            end
        end
        if n > 0 then
            avgInterval = sum / n
        end
    end

    return {
        pressesLast1s = pressesLast1s,
        lastPressAt = lastPressAt,
        lastPressAgo = lastPressAgo,
        avgInterval = avgInterval,
    }
end

--- True if the user is currently spamming attack at or above the configured cadence.
--- Definition (per project request):
--- - >= 3 presses in the last 1.0s
--- - and last press was within the last 0.30s (so it's "currently" happening)
--- @return boolean
function NAG:IsSpammingAttack()
    local stats = self:GetAttackSpamStats()
    if not stats then
        return false
    end
    if (stats.pressesLast1s or 0) < 3 then
        return false
    end
    if not stats.lastPressAgo or stats.lastPressAgo > 0.30 then
        return false
    end
    return true
end

-- ============================ SHAMAN: SHOULD SPAM AUTO (TBC ENH) ============================

local function isTBCEnhancementShaman(self)
    if not (Version and Version.IsTBC and Version:IsTBC()) then
        return false
    end
    if (self.CLASS_FILENAME or "") ~= "SHAMAN" then
        return false
    end

    if not SpecCompat then
        -- AceAddon GetModule supports silent=true as 2nd arg.
        SpecCompat = self:GetModule("SpecCompat", true)
    end
    if not SpecCompat then
        -- If spec detection isn't available, don't hard-block.
        -- We only want to block if we can positively identify a non-Enhancement spec.
        return true
    end

    local specStatus = SpecCompat:GetSpecializationStatus()
    if not specStatus or not specStatus.available or not specStatus.specIndex then
        -- Spec not known yet (common briefly during login/updates). Don't hard-block.
        return true
    end

    return specStatus.specIndex == 2
end

-- ============================ PALADIN: OG RET SHADOW HELPERS ============================

local function isTBCRetributionPaladin(self)
    if not (Version and Version.IsTBC and Version:IsTBC()) then
        return false
    end
    if (self.CLASS_FILENAME or "") ~= "PALADIN" then
        return false
    end

    if not SpecCompat then
        SpecCompat = self:GetModule("SpecCompat", true)
    end
    if not SpecCompat then
        return true
    end

    local specStatus = SpecCompat:GetSpecializationStatus()
    if not specStatus or not specStatus.available or not specStatus.specIndex then
        return true
    end

    return specStatus.specIndex == 3
end

local function getRetActiveSealState(self)
    local soCActive = (self.RetTwistIsSoCActive and self:RetTwistIsSoCActive()) or false
    local soBActive = (self.RetTwistIsSoBActive and self:RetTwistIsSoBActive()) or false
    if soCActive then
        return "soc"
    end
    if soBActive then
        return "sob"
    end
    return "none"
end

local function mapProjectedPhaseToBucket(phase)
    if phase == "pre_hold" then
        return "before_div"
    end
    if phase == "hold_region" then
        return "after_div_before_gap"
    end
    if phase == "in_twist_window" then
        return "in_twist"
    end
    return "swing_ready"
end

--- Builds a WA-style shadow context for TBC Ret Paladin analysis.
--- Runtime-only: stored in `NAG.state` (no AceDB writes).
--- @param windowSeconds number|nil Default 0.4
--- @return table|nil
local function buildOGRetShadowContext(self, windowSeconds)
    if not isTBCRetributionPaladin(self) then
        return nil
    end

    local window = windowSeconds or 0.4
    if window < 0 then
        window = 0
    end

    local gcdReadyIn = self:GCDTimeToReady() or 0
    if gcdReadyIn < 0 then
        gcdReadyIn = 0
    end

    local gcdDuration = self:GCDTimeValue() or 0
    if gcdDuration < 0 then
        gcdDuration = 0
    end

    -- IMPORTANT: Use cooldown-from-now for Judgement (off-GCD in TBC) so the shadow context
    -- matches the same horizon used by RetTwistJudgeSetupIsPlanned/WaitTolerance.
    local judgeReadyIn = getSpellCooldownRemainingNow(20271) or 0
    if judgeReadyIn < 0 then
        judgeReadyIn = 0
    end

    local csReadyIn = self:SpellTimeToReady(35395) or 0
    if csReadyIn < 0 then
        csReadyIn = 0
    end

    local categoryNow, rawDivNow, twistGapNow = self:RetTwistGetSwingTimingCategory(window)
    local _, rawSwingNow = self:AutoTimeToNext()
    rawSwingNow = rawSwingNow or 0
    if rawSwingNow < 0 then
        rawSwingNow = 0
    end

    local mhSwingSpeed = UnitAttackSpeed and UnitAttackSpeed("player") or nil
    if not mhSwingSpeed or mhSwingSpeed <= 0 then
        mhSwingSpeed = rawSwingNow
    end
    if mhSwingSpeed < 0 then
        mhSwingSpeed = 0
    end

    local nextSwingWhen = rawSwingNow + mhSwingSpeed
    local nextDivWhen = nextSwingWhen - (window + gcdDuration)
    local nextTwistGap = nextSwingWhen - window

    local swingAtAction = self:AutoTimeToNextAfterGCD() or 0
    if swingAtAction < 0 then
        swingAtAction = 0
    end
    local projectedPhase = "post_swing_or_idle"
    if swingAtAction > 0 then
        if swingAtAction <= window then
            projectedPhase = "in_twist_window"
        elseif swingAtAction <= (window + gcdDuration) then
            projectedPhase = "hold_region"
        else
            projectedPhase = "pre_hold"
        end
    end
    local twistWindowOpenInAtAction = 0
    if projectedPhase == "hold_region" or projectedPhase == "pre_hold" then
        twistWindowOpenInAtAction = max(0, swingAtAction - window)
    end

    return {
        now = GetTime(),
        windowSeconds = window,
        gcdReadyIn = gcdReadyIn,
        gcdDuration = gcdDuration,
        judgeReadyIn = judgeReadyIn,
        csReadyIn = csReadyIn,
        activeSeal = getRetActiveSealState(self),
        swing = {
            rawSwingNow = rawSwingNow,
            swingAtAction = swingAtAction,
            mhSwingSpeed = mhSwingSpeed,
            currentCategory = categoryNow,
            projectedCategory = mapProjectedPhaseToBucket(projectedPhase),
            divWhen = rawDivNow or 0,
            twistGap = twistGapNow or 0,
            nextDivWhen = nextDivWhen,
            nextTwistGap = nextTwistGap,
            twistWindowOpenInAtAction = twistWindowOpenInAtAction,
        },
    }
end

--- Returns true when OG Ret shadow helper should run this loop.
--- Feature flag: developer mode.
--- @return boolean
function NAG:IsOGRetShadowEnabled()
    if not (self and self.IsDevModeEnabled and self:IsDevModeEnabled()) then
        return false
    end
    return isTBCRetributionPaladin(self)
end

--- Returns true if the user (TBC Enhancement Shaman only) should be spamming the AutoAttack macro
--- to enforce a usable MH/OH swing relationship.
---
--- Historically this helper only fired while we were desynced (not effectively synchronized).
--- Per updated expectations, it should also fire when we are "too perfectly synced" and need to
--- re-introduce some stagger (perfect syncs are not acceptable).
---
--- This is driven by the runtime state computed by `TBCEnhancementShamanWeaponSync`.
--- @return boolean
function NAG:ShamanShouldSpamAuto()
    if not isTBCEnhancementShaman(self) then
        return false
    end

    local mod = self:GetModule("TBCEnhancementShamanWeaponSync", true)
    if not mod then
        return false
    end
    if mod.IsEnabled and (not mod:IsEnabled()) then
        return false
    end

    local st = mod._debugState
    if not st then
        return false
    end

    -- Only meaningful when swing timers are stable (avoid idle ttn=0/p=1 state).
    if not st.lastHasStableSwingTimers then
        return false
    end

    local diff = st.lastSyncDifference

    -- If we're effectively synced, we generally don't want to spam...
    -- ...except when we're "too perfectly synced" and we want to re-stagger.
    if st.lastIsEffectivelySynchronized then
        -- Use the module's MH lead bias as a practical "too perfect" threshold: if the swings are
        -- closer than this, treat it as needing stagger.
        local perfectSyncMaxSeconds = 0.05
        if mod.db and mod.db.class and mod.db.class.mhLeadTimeSeconds ~= nil then
            perfectSyncMaxSeconds = mod.db.class.mhLeadTimeSeconds
        end
        if perfectSyncMaxSeconds < 0 then
            perfectSyncMaxSeconds = 0
        end

        if diff and diff >= 0 and diff <= perfectSyncMaxSeconds then
            return true
        end
        return false
    end

    -- Desired default stagger behavior:
    -- - MH should be slightly ahead (ties are not acceptable)
    -- - Accept MH-leading stagger up to 0.49s
    local leader = st.lastLeaderHand
    if diff and leader == "MH" then
        if diff <= 0.49 then
            return false
        end
    end

    return true
end

--- Builds the projected Ret twist timing state at the next actionable moment.
--- This keeps CS-delay decisions anchored to where the GCD will land.
--- @param self NAG
--- @param windowSeconds number
--- @return number gcdLeft Seconds until next action.
--- @return number gcdVal GCD duration value.
--- @return number timeToSwingAtAction Predicted time-to-swing at action time.
--- @return number timeToWindowOpenFromNow Predicted time until twist window opens.
--- @return string phase Projected phase at action time.
--- @return string projectionMode "gcd_oriented" when GCD is active, else "flexible_now".
--- @return number divBoundaryDeltaAtAction Signed delta to div boundary at action time.
local function getRetTwistActionProjection(self, windowSeconds)
    local window = windowSeconds or 0.4
    if window < 0 then
        window = 0
    end

    local gcdLeft = self:GCDTimeToReady() or 0
    if gcdLeft < 0 then
        gcdLeft = 0
    end

    local gcdVal = self:GCDTimeValue() or 0
    if gcdVal < 0 then
        gcdVal = 0
    end

    local timeToSwingAtAction = self:AutoTimeToNextAfterGCD() or 0
    if timeToSwingAtAction < 0 then
        timeToSwingAtAction = 0
    end

    local divBoundaryDeltaAtAction = timeToSwingAtAction - window
    local projectionMode = (gcdLeft > 0) and "gcd_oriented" or "flexible_now"

    local phase = "post_swing_or_idle"
    if timeToSwingAtAction > 0 then
        if timeToSwingAtAction <= window then
            phase = "in_twist_window"
        elseif timeToSwingAtAction <= (window + gcdVal) then
            phase = "hold_region"
        else
            phase = "pre_hold"
        end
    end

    local timeToWindowOpenFromNow = 0
    if phase == "hold_region" or phase == "pre_hold" then
        timeToWindowOpenFromNow = gcdLeft + max(0, timeToSwingAtAction - window)
    end

    return gcdLeft, gcdVal, timeToSwingAtAction, timeToWindowOpenFromNow, phase, projectionMode, divBoundaryDeltaAtAction
end

--- Parallel OG (WA-style) Ret logic evaluation.
--- This is a shadow engine only and never mutates recommendations.
--- @return table payload
function NAG:OGRetLogic()
    local payload = {
        ok = false,
        nextAction = "none",
        holdFlag = false,
        fillerFlag = false,
        judgeCall = false,
        predictionHold = 0,
        csDelay = 0,
        csOverride = false,
        timingBucket = "unknown",
        activeSeal = "none",
        reasons = {},
        metrics = {},
        version = OG_RET_SHADOW_LOG_VERSION,
    }

    if not self:IsOGRetShadowEnabled() then
        payload.reasons[1] = "shadow_disabled"
        return payload
    end

    local window = 0.4
    local reaction = 0.1
    local csMaxDelay = 1.7
    local maxTolerance = 3
    local hysteresis = 0.05
    local safety = 0.2
    local fillerBuffer = 0.3

    local context = buildOGRetShadowContext(self, window)
    if not context then
        payload.reasons[1] = "context_unavailable"
        return payload
    end

    local reasons = {}
    local function addReason(tag)
        reasons[#reasons + 1] = tag
    end

    payload.ok = true
    payload.activeSeal = context.activeSeal
    payload.timingBucket = context.swing.projectedCategory

    local judgePlanned = self:RetTwistJudgeSetupIsPlanned(maxTolerance, window, hysteresis, safety)
    local holdTolerance = self:RetTwistJudgeSetupWaitTolerance(maxTolerance, window, hysteresis, safety, fillerBuffer) or 0
    local holdWait = holdTolerance
    if holdWait < 0 then
        holdWait = 0
    end

    local predictionHold = max(context.gcdReadyIn, holdWait, context.swing.twistWindowOpenInAtAction or 0)
    local csUsableIn = max(context.csReadyIn, context.gcdReadyIn)
    local projectedCsWhenIn = predictionHold + context.gcdDuration + reaction
    local remainingBudget = csUsableIn + csMaxDelay
    local csDelay = projectedCsWhenIn - remainingBudget
    local csOverride = csDelay > 0.05

    payload.predictionHold = predictionHold
    payload.csDelay = csDelay
    payload.csOverride = csOverride
    payload.holdFlag = holdTolerance > 0
    payload.fillerFlag = judgePlanned and holdTolerance == 0
    payload.judgeCall = judgePlanned and holdTolerance ~= 0 and context.judgeReadyIn <= 0 and context.activeSeal == "sob"

    if holdTolerance == -1 then
        addReason("judge_ready_now")
    elseif holdTolerance > 0 then
        addReason("judge_hold_required")
    elseif judgePlanned then
        addReason("filler_allowed_before_judge")
    end

    if csOverride then
        addReason("cs_override_budget")
    else
        addReason("cs_within_budget")
    end

    if context.activeSeal == "none" then
        payload.nextAction = "sob"
        addReason("no_active_seal")
    elseif payload.timingBucket == "in_twist" then
        payload.nextAction = "twist"
        addReason("twist_window")
    elseif csOverride and context.csReadyIn <= context.gcdReadyIn then
        payload.nextAction = "CS"
        addReason("force_cs_now")
    elseif judgePlanned and holdTolerance ~= 0 then
        payload.nextAction = "soc"
        addReason("judge_setup_soc")
    elseif judgePlanned and holdTolerance == 0 then
        if context.csReadyIn <= context.gcdReadyIn then
            payload.nextAction = "CS"
            addReason("filler_cs")
        else
            payload.nextAction = "none"
            addReason("filler_non_cs")
        end
    elseif self:RetTwistShouldPreferSoBForSwing(window, maxTolerance, hysteresis, safety, fillerBuffer) then
        payload.nextAction = "sob"
        addReason("retain_sob_policy")
    else
        payload.nextAction = "soc"
        addReason("prepare_soc")
    end

    payload.reasons = reasons
    payload.metrics = {
        gcdReadyIn = context.gcdReadyIn,
        gcdDuration = context.gcdDuration,
        judgeReadyIn = context.judgeReadyIn,
        csReadyIn = context.csReadyIn,
        csUsableIn = csUsableIn,
        holdTolerance = holdTolerance,
        predictionHold = predictionHold,
        projectedCsWhenIn = projectedCsWhenIn,
        remainingBudget = remainingBudget,
        csDelay = csDelay,
        timingBucketNow = context.swing.currentCategory,
        timingBucketProjected = context.swing.projectedCategory,
        divWhen = context.swing.divWhen,
        twistGap = context.swing.twistGap,
        nextDivWhen = context.swing.nextDivWhen,
        nextTwistGap = context.swing.nextTwistGap,
        swingAtAction = context.swing.swingAtAction,
        rawSwingNow = context.swing.rawSwingNow,
        version = OG_RET_SHADOW_LOG_VERSION,
    }

    return payload
end

--- Implements the WA-style "CS delay analyzer" rule for seal twisting:
--- only force Crusader Strike if following the current twist plan (holding until the next twist window)
--- would delay CS beyond the configured maximum.
---
--- This is intentionally an additive support helper for APL authors; it does not change any
--- existing consolidated casting/rotation semantics.
---
--- @param csMaxDelaySeconds number|nil Default 1.7 (1700ms)
--- @param reactionSeconds number|nil Default 0.1 (100ms)
--- @param windowSeconds number|nil Default 0.4
--- @return boolean True if CS should be forced now (or held as primary) to avoid over-delaying it.
--- @usage if NAG:RetTwistShouldForceCrusaderStrike(1.7, 0.1, 0.4) then ...
function NAG:RetTwistShouldForceCrusaderStrike(csMaxDelaySeconds, reactionSeconds, windowSeconds)
    local GetTime = _G.GetTime
    local now = GetTime and GetTime() or 0

    -- Debug snapshot fields (written on all exits so RetTwistDebugTick can print the exact math inputs/outputs)
    self._retTwistForceCs_dbgReason = nil
    self._retTwistForceCs_dbgActIn = nil
    self._retTwistForceCs_dbgCsUsableIn = nil
    self._retTwistForceCs_dbgCsReadyIn = nil
    self._retTwistForceCs_dbgCsMaxDelay = nil
    self._retTwistForceCs_dbgUsableFor = nil
    self._retTwistForceCs_dbgHoldWaitIn = nil
    self._retTwistForceCs_dbgPredictionHoldIn = nil
    self._retTwistForceCs_dbgProjectedCsWhenIn = nil
    self._retTwistForceCs_dbgRemainingBudget = nil
    self._retTwistForceCs_dbgRawExcess = nil
    self._retTwistForceCs_dbgPhase = nil
    self._retTwistForceCs_dbgProjectionMode = nil
    self._retTwistForceCs_dbgTimeToSwingAtAction = nil
    self._retTwistForceCs_dbgTimeToWindowOpen = nil
    self._retTwistForceCs_dbgDivBoundaryDeltaAtAction = nil
    self._retTwistForceCs_dbgBoundaryGuard = nil
    self._retTwistForceCs_dbgCsReadyAtTs = nil
    self._retTwistForceCs_dbgActionAtTs = nil
    self._retTwistForceCs_dbgCsReadyAtAction = nil

    local window = windowSeconds or 0.4
    local reaction = reactionSeconds or 0
    if reaction < 0 then reaction = 0 end

    local csMaxDelay = csMaxDelaySeconds or 1.7
    if csMaxDelay < 0 then csMaxDelay = 0 end
    self._retTwistForceCs_dbgCsMaxDelay = csMaxDelay

    -- SpellTimeToReady can occasionally return -1 (missing cooldown info) for a single tick.
    -- That causes visible flicker in "force CS" decisions. Use a short cache of the last good
    -- value to make the behavior stable.
    local csReadyIn = self:SpellTimeToReady(35395)
    if csReadyIn and csReadyIn >= 0 then
        self._retTwistCsReadyInCache = csReadyIn
        self._retTwistCsReadyInCacheTime = now
    else
        local cached = self._retTwistCsReadyInCache
        local cachedAt = self._retTwistCsReadyInCacheTime or 0
        if cached ~= nil and (now - cachedAt) <= 0.50 then
            csReadyIn = cached
        else
            self._retTwistForceCs_dbgReason = "no_cs_cdinfo"
            return false
        end
    end
    self._retTwistForceCs_dbgCsReadyIn = csReadyIn

    -- Prefer absolute cooldown-ready timestamp for CS so action-horizon normalization
    -- is stable even when SpellTimeToReady jitters or quantizes during the same GCD.
    local csReadyAtTs = nil
    local csCdInfo = WoWAPI and WoWAPI.GetSpellCooldown and WoWAPI.GetSpellCooldown(35395) or nil
    if csCdInfo then
        local csStart = csCdInfo.startTime or 0
        local csDuration = csCdInfo.duration or 0
        if csDuration > 0 and csStart > 0 then
            csReadyAtTs = csStart + csDuration
        else
            csReadyAtTs = now
        end
    end
    if not csReadyAtTs then
        csReadyAtTs = now + (csReadyIn or 0)
    end
    self._retTwistForceCs_dbgCsReadyAtTs = csReadyAtTs

    -- ============================ PREDICTIVE DELAY MATH (WA-STYLE INTENT) ============================
    -- Model the CS delay if we continue following the twist/hold plan:
    --   projectedCsWhenIn = predictionHoldIn + gcdDuration + reaction
    -- where:
    --   predictionHoldIn = max(gcdReadyIn, holdWaitIn)
    -- This captures the user's requirement that hold-region timing contributes to CS delay.
    local actIn, gcdVal, projectedSwingAtAction, projectedWindowOpenIn, projectedPhase, projectionMode, divBoundaryDeltaAtAction = getRetTwistActionProjection(self, window)
    self._retTwistForceCs_dbgActIn = actIn
    self._retTwistForceCs_dbgProjectionMode = projectionMode
    self._retTwistForceCs_dbgTimeToSwingAtAction = projectedSwingAtAction
    self._retTwistForceCs_dbgTimeToWindowOpen = projectedWindowOpenIn
    self._retTwistForceCs_dbgDivBoundaryDeltaAtAction = divBoundaryDeltaAtAction

    local csUsableIn = csReadyIn
    if not csUsableIn then
        csUsableIn = 0
    end
    if csUsableIn < 0 then
        csUsableIn = 0
    end
    -- GCD-aware CS usability: even if CS cooldown is ready, we cannot use it before GCD ends.
    -- This prevents premature CS overrides when the only blocker is current GCD lockout.
    if actIn > csUsableIn then
        csUsableIn = actIn
    end
    self._retTwistForceCs_dbgCsUsableIn = csUsableIn

    if csUsableIn <= 0 then
        if not self._retTwistCsReadySince then
            self._retTwistCsReadySince = now
        end
    else
        self._retTwistCsReadySince = nil
    end

    local usableFor = 0
    if self._retTwistCsReadySince then
        usableFor = now - self._retTwistCsReadySince
        if usableFor < 0 then
            usableFor = 0
        end
    end
    self._retTwistForceCs_dbgUsableFor = usableFor

    local socActive = (self.RetTwistIsSoCActive and self:RetTwistIsSoCActive()) or false
    local sobActive = (self.RetTwistIsSoBActive and self:RetTwistIsSoBActive()) or false

    -- ============================ TWIST-ONLY CS DELAY GATES ============================
    -- Core rule:
    -- - CS delay logic only applies when SoC is already active (twist-ready state).
    -- - GCD must be off-CD OR ready before/at latest +100ms into twist-gap open.
    local twistGapSlack = 0.1
    local twistWindowOpenIn = projectedWindowOpenIn or 0
    if twistWindowOpenIn < 0 then
        twistWindowOpenIn = 0
    end
    local gcdMeetsTwistGate = (actIn <= (twistWindowOpenIn + twistGapSlack))
    if (not socActive) then
        self._retTwistForceCsActive = false
        self._retTwistForceCs_dbgReason = "gate_soc_inactive"
        self._retTwistForceCs_dbgHoldWaitIn = 0
        self._retTwistForceCs_dbgPredictionHoldIn = 0
        self._retTwistForceCs_dbgProjectedCsWhenIn = 0
        self._retTwistForceCs_dbgRemainingBudget = 0
        self._retTwistForceCs_dbgRawExcess = 0
        self._retTwistForceCs_dbgPhase = projectedPhase
        self._retTwistForceCs_dbgBoundaryGuard = false
        if false and self:IsDevModeEnabled() then
            print(string.format(
                "[RET_CS_OVERRIDE][ver=%s] force=false reason=gate_soc_inactive actIn=%.3f twistWindowOpenIn=%.3f twistGapSlack=%.3f socActive=%s sobActive=%s",
                JUDGE_HOLD_LOG_VERSION,
                actIn or 0,
                twistWindowOpenIn or 0,
                twistGapSlack or 0,
                tostring(socActive),
                tostring(sobActive)
            ))
        end
        return false
    end
    if not gcdMeetsTwistGate then
        self._retTwistForceCsActive = false
        self._retTwistForceCs_dbgReason = "gate_gcd_misses_twist_open"
        self._retTwistForceCs_dbgHoldWaitIn = 0
        self._retTwistForceCs_dbgPredictionHoldIn = 0
        self._retTwistForceCs_dbgProjectedCsWhenIn = 0
        self._retTwistForceCs_dbgRemainingBudget = 0
        self._retTwistForceCs_dbgRawExcess = 0
        self._retTwistForceCs_dbgPhase = projectedPhase
        self._retTwistForceCs_dbgBoundaryGuard = false
        if false and self:IsDevModeEnabled() then
            print(string.format(
                "[RET_CS_OVERRIDE][ver=%s] force=false reason=gate_gcd_misses_twist_open actIn=%.3f twistWindowOpenIn=%.3f twistGapSlack=%.3f threshold=%.3f socActive=%s",
                JUDGE_HOLD_LOG_VERSION,
                actIn or 0,
                twistWindowOpenIn or 0,
                twistGapSlack or 0,
                (twistWindowOpenIn + twistGapSlack) or 0,
                tostring(socActive)
            ))
        end
        return false
    end

    local holdWaitIn = 0
    local phase = "no_twist_state"
    local boundaryGuardUsed = false
    if socActive or sobActive then
        -- Use GCD-oriented hold target aligned to the action horizon (GCD end).
        holdWaitIn = projectedWindowOpenIn or 0
        if holdWaitIn < 0 then
            holdWaitIn = 0
        end
        phase = projectedPhase

        -- Tiny anti-flip guard around the div boundary to avoid one-frame phase jitter.
        -- Keep rolling recalculation, but preserve only phase label for a very short window.
        -- Do NOT preserve holdWaitIn itself: it must decay continuously each frame.
        local boundaryEpsilon = 0.03
        local boundaryGuardTtl = 0.20
        local prevSampleAt = self._retTwistForceCsProjectionSampleAt
        local prevMode = self._retTwistForceCsProjectionMode
        local prevPhase = self._retTwistForceCsProjectionPhase

        if actIn > 0 and abs(divBoundaryDeltaAtAction) <= boundaryEpsilon
            and prevSampleAt and (now - prevSampleAt) <= boundaryGuardTtl
            and prevMode == projectionMode and prevPhase then
            phase = prevPhase
            boundaryGuardUsed = true
        end

        self._retTwistForceCsProjectionMode = projectionMode
        self._retTwistForceCsProjectionPhase = phase
        self._retTwistForceCsProjectionHoldWaitIn = holdWaitIn
        self._retTwistForceCsProjectionSampleAt = now
    else
        self._retTwistForceCsProjectionMode = nil
        self._retTwistForceCsProjectionPhase = nil
        self._retTwistForceCsProjectionHoldWaitIn = nil
        self._retTwistForceCsProjectionSampleAt = nil
        self._retTwistForceCsGcdSnapshot = nil
    end

    -- ============================ GCD-NORMALIZED DECISION SPACE ============================
    -- Normalize all timing values to the same action horizon (GCD end) so the decision is
    -- stable between sequential frames under the same active GCD.
    local holdWaitAfterAction = holdWaitIn - actIn
    if holdWaitAfterAction < 0 then
        holdWaitAfterAction = 0
    end
    local actionAtTs = now + actIn
    local snapshot = self._retTwistForceCsGcdSnapshot
    local prevActIn = self._retTwistForceCsSnapshotLastActIn or 0
    local startedNewGcd = actIn > (prevActIn + 0.05)
    if actIn <= 0 then
        snapshot = nil
        self._retTwistForceCsGcdSnapshot = nil
    else
        if (not snapshot) or startedNewGcd then
            snapshot = { actionAtTs = actionAtTs }
            self._retTwistForceCsGcdSnapshot = snapshot
        end
        actionAtTs = snapshot.actionAtTs or actionAtTs
        if snapshot.phase == nil then
            snapshot.phase = phase
        end
        if snapshot.holdWaitAfterAction == nil then
            snapshot.holdWaitAfterAction = holdWaitAfterAction
        end
        phase = snapshot.phase
        holdWaitAfterAction = snapshot.holdWaitAfterAction
    end
    self._retTwistForceCsSnapshotLastActIn = actIn

    local csReadyAfterAction = csReadyAtTs - actionAtTs
    if csReadyAfterAction < 0 then
        csReadyAfterAction = 0
    end
    self._retTwistForceCs_dbgActionAtTs = actionAtTs
    self._retTwistForceCs_dbgCsReadyAtAction = csReadyAfterAction

    -- Decision variables (strictly action-horizon normalized).
    -- These are the values we compare for force-CS; they should remain stable during the same
    -- active GCD window unless the underlying projected state changes.
    local predictionHoldIn = holdWaitAfterAction
    local projectedCsWhenIn = predictionHoldIn + gcdVal + reaction

    -- ============================ WA-STYLE UNIVERSAL CS ANSWER ============================
    -- OG WA intent:
    --   csWhenIn = predictionHold + frozenGCD + reaction
    --   csDelay = csReadyIn - csWhenIn + csDelayMax
    --   force CS when csDelay <= 0
    -- Equivalent:
    --   force CS when csWhenIn >= (csReadyIn + csDelayMax)
    --
    -- Keep CS cooldown side exactly WA-like (csReadyIn), while prediction side remains
    -- GCD-oriented via `predictionHoldIn = max(actIn, holdWaitIn)`.
    local csDelayMaxAdjusted = csMaxDelay
    if socActive and phase == "in_twist_window" then
        -- WA applies +0.1 when the next action is already "twist".
        -- In this helper we approximate that state as SoC active inside twist window.
        csDelayMaxAdjusted = csDelayMaxAdjusted + 0.1
    end

    local remainingBudget = csReadyAfterAction + csDelayMaxAdjusted
    if remainingBudget < 0 then
        remainingBudget = 0
    end

    local rawExcess = projectedCsWhenIn - remainingBudget

    -- Tiny hysteresis around zero to prevent 1-frame flips when values sit on the boundary.
    local onMargin = 0.05
    local offMargin = 0.10
    local wasForceCs = self._retTwistForceCsActive == true
    local forceCs = false
    if wasForceCs then
        forceCs = rawExcess >= -offMargin
    else
        forceCs = rawExcess > onMargin
    end

    self._retTwistForceCsActive = forceCs
    self._retTwistForceCs_dbgHoldWaitIn = holdWaitIn
    self._retTwistForceCs_dbgPredictionHoldIn = predictionHoldIn
    self._retTwistForceCs_dbgProjectedCsWhenIn = projectedCsWhenIn
    self._retTwistForceCs_dbgRemainingBudget = remainingBudget
    self._retTwistForceCs_dbgRawExcess = rawExcess
    self._retTwistForceCs_dbgPhase = phase
    self._retTwistForceCs_dbgBoundaryGuard = boundaryGuardUsed

    if false and self:IsDevModeEnabled() then
        local suspiciousEarlyForce = forceCs and (csReadyIn and csReadyIn > 2.5)
        local snapshotActive = (actIn > 0 and self._retTwistForceCsGcdSnapshot ~= nil)
        local remTime = (self.RemainingTime and self:RemainingTime()) or -1
        print(string.format(
            "[RET_CS_OVERRIDE][ver=%s] force=%s reason=%s actIn=%.3f actionAtTs=%.3f csReadyAtTs=%.3f holdWaitIn=%.3f holdWaitAtAction=%.3f csReadyIn=%.3f csReadyAtAction=%.3f predictionHoldAtAction=%.3f projectedCsWhenAtAction=%.3f remainingBudgetAtAction=%.3f rawExcessAtAction=%.3f onMargin=%.3f offMargin=%.3f csUsableIn=%.3f phase=%s boundaryGuard=%s snapshotActive=%s suspiciousEarlyForce=%s remTime=%.3f",
            JUDGE_HOLD_LOG_VERSION,
            tostring(forceCs),
            forceCs and "wa_csdelay_over_budget" or "wa_csdelay_within_budget",
            actIn or 0,
            actionAtTs or 0,
            csReadyAtTs or 0,
            holdWaitIn or 0,
            holdWaitAfterAction or 0,
            csReadyIn or 0,
            csReadyAfterAction or 0,
            predictionHoldIn or 0,
            projectedCsWhenIn or 0,
            remainingBudget or 0,
            rawExcess or 0,
            onMargin or 0,
            offMargin or 0,
            csUsableIn or 0,
            tostring(phase),
            tostring(boundaryGuardUsed),
            tostring(snapshotActive),
            tostring(suspiciousEarlyForce),
            remTime
        ))
        self._retTwistForceCsLastLogAt = now
        self._retTwistForceCsLastLoggedState = forceCs
    end

    if forceCs then
        self._retTwistForceCs_dbgReason = "wa_csdelay_over_budget"
        return true
    end

    self._retTwistForceCs_dbgReason = "wa_csdelay_within_budget"
    return false
end

--- Debug helper to understand why the CS override is (or isn't) active in the Ret twist APL.
--- @param csMaxDelaySeconds number|nil
--- @param reactionSeconds number|nil
--- @param windowSeconds number|nil
--- @return boolean Always returns false so it can be used as `NAG:RetTwistCSDebugTick(...) or ...` in an APL.
function NAG:RetTwistCSDebugTick(csMaxDelaySeconds, reactionSeconds, windowSeconds)
    -- Debug prints disabled (was used for investigating HOLD<->CS flicker).
    -- Intentionally keep this function as a no-op so APLs that still reference it won't break.
    return false
end

--- Returns the predicted "hold until" time (seconds from now) for the next twist window to open
--- using the raw (non-GCD-adjusted) time-to-next-swing.
--- @param windowSeconds number|nil Twist window size in seconds (default: 0.4)
--- @return number holdSeconds Seconds from now until the twist window opens (clamped >= 0).
function NAG:RetTwistTimeToTwistWindowNow(windowSeconds)
    local window = windowSeconds or 0.4
    local _, rawNow = self:AutoTimeToNext()
    if not rawNow then
        return 0
    end
    return max(0, rawNow - window)
end

--- Returns the estimated lead time (seconds) needed to complete the backup Judge+SoC setup.
--- Includes any required HOLD time plus one GCD for SoC application.
--- @return number
function NAG:RetTwistBackupJudgeSoCLeadTime()
    local hold = self:RetTwistJudgeSetupWaitTolerance(3, 0.4, 0.05, 0.2, 0.3) or 0
    if hold < 0 then
        hold = 0
    end
    local gcdVal = self:GCDTimeValue() or 0
    if gcdVal < 0 then
        gcdVal = 0
    end
    return hold + gcdVal
end

local SOC_SETUP_CS_GATE_LOG_VERSION = "1.0.0"

--- Returns true when SoC setup should be blocked due to CS timing or swing-horizon infeasibility.
--- Core rule: block when CS will be ready before/at (targetSwingAtAction - 0.7).
--- @param windowSeconds number|nil Default 0.4
--- @param swingPlanMode string|nil "current_pre_div" or "next_swing_pre_div"
--- @return boolean
function NAG:RetTwistShouldBlockSoCSetupForCS(windowSeconds, swingPlanMode)
    local window = windowSeconds or 0.4
    if window < 0 then
        window = 0
    end

    local planMode = swingPlanMode or "current_pre_div"
    if planMode ~= "current_pre_div" and planMode ~= "next_swing_pre_div" then
        planMode = "current_pre_div"
    end

    local csSpellId = 35395
    if self.SpellIsKnown and (not self:SpellIsKnown(csSpellId)) then
        self._retTwistSoCSetupCsGate = {
            version = SOC_SETUP_CS_GATE_LOG_VERSION,
            planMode = planMode,
            blocked = false,
            reason = "cs_not_known",
        }
        return false
    end

    local csReadyIn = self:SpellTimeToReady(csSpellId) or 0
    if csReadyIn < 0 then
        csReadyIn = 0
    end

    local gcdLeft, _, projectedSwingAtAction = getRetTwistActionProjection(self, window)
    local _, rawSwingNow = self:AutoTimeToNext()
    rawSwingNow = rawSwingNow or 0
    if rawSwingNow < 0 then
        rawSwingNow = 0
    end

    local swingSpeed = self:AutoSwingTime() or 0
    if swingSpeed < 0 then
        swingSpeed = 0
    end
    if swingSpeed <= 0 and rawSwingNow > 0 then
        swingSpeed = rawSwingNow
    end

    local crossedCurrentSwing = (rawSwingNow > 0) and (gcdLeft >= rawSwingNow)
    local targetSwingAtAction = 0
    local twistFeasible = true
    local reason = "allow_soc_setup"

    if planMode == "current_pre_div" then
        if rawSwingNow <= 0 then
            twistFeasible = false
            reason = "no_current_swing"
        elseif crossedCurrentSwing then
            twistFeasible = false
            reason = "current_swing_passed_before_action"
        else
            targetSwingAtAction = projectedSwingAtAction or 0
            if targetSwingAtAction <= window then
                twistFeasible = false
                reason = "current_prediv_missed"
            end
        end
    else
        if swingSpeed <= 0 then
            twistFeasible = false
            reason = "unknown_swing_speed"
        else
            if crossedCurrentSwing then
                targetSwingAtAction = projectedSwingAtAction or 0
            else
                targetSwingAtAction = (projectedSwingAtAction or 0) + swingSpeed
            end
            if targetSwingAtAction <= window then
                twistFeasible = false
                reason = "next_prediv_missed"
            end
        end
    end

    local threshold = targetSwingAtAction - 0.7
    -- When on GCD, we can only act when GCD ends. Don't block SoC if CS won't be ready by then
    -- (e.g. we just cast CS - show SoC immediately since that's our next action when GCD ends).
    local csUsableWhenWeAct = (gcdLeft or 0) <= 0 or (csReadyIn <= (gcdLeft or 0))
    local blockForCs = twistFeasible and (csReadyIn <= threshold) and csUsableWhenWeAct
    local shouldBlock = (not twistFeasible) or blockForCs
    if shouldBlock and blockForCs then
        reason = "cs_ready_before_swing_minus_0_7"
    elseif shouldBlock and reason == "allow_soc_setup" then
        reason = "twist_not_feasible"
    end

    self._retTwistSoCSetupCsGate = {
        version = SOC_SETUP_CS_GATE_LOG_VERSION,
        planMode = planMode,
        blocked = shouldBlock,
        reason = reason,
        csReadyIn = csReadyIn,
        threshold = threshold,
        targetSwingAtAction = targetSwingAtAction,
        rawSwingNow = rawSwingNow,
        gcdLeft = gcdLeft or 0,
        crossedCurrentSwing = crossedCurrentSwing,
    }

    if false and self:IsDevModeEnabled() then
        local now = GetTime and GetTime() or 0
        local dbgKey = string.format("%s|%s|%s", planMode, tostring(shouldBlock), reason)
        if self._retTwistSoCSetupCsGateLastKey ~= dbgKey
            or (not self._retTwistSoCSetupCsGateLastPrintAt)
            or ((now - self._retTwistSoCSetupCsGateLastPrintAt) >= 0.5) then
            local remTime = (self.RemainingTime and self:RemainingTime()) or -1
            print(string.format(
                "[RET_SOC_CS_GATE][ver=%s] mode=%s blocked=%s reason=%s csReadyIn=%.3f threshold=%.3f targetSwingAtAction=%.3f rawSwingNow=%.3f gcdLeft=%.3f crossedCurrent=%s remTime=%.3f",
                SOC_SETUP_CS_GATE_LOG_VERSION,
                planMode,
                tostring(shouldBlock),
                reason,
                csReadyIn,
                threshold,
                targetSwingAtAction,
                rawSwingNow,
                gcdLeft or 0,
                tostring(crossedCurrentSwing),
                remTime
            ))
            self._retTwistSoCSetupCsGateLastKey = dbgKey
            self._retTwistSoCSetupCsGateLastPrintAt = now
        end
    end

    return shouldBlock
end

--- Debug helper for the plain SoC primary clause in TBC Ret rotation strings.
--- Prints a compact gate breakdown so we can see exactly why line-655 style SoC did/didn't fire.
--- Always returns false so it can be inserted into APL `or` chains safely.
--- @param windowSeconds number|nil Default 0.4
--- @param maxToleranceSeconds number|nil Default 3
--- @param hysteresisSeconds number|nil Default 0.05
--- @param safetySeconds number|nil Default 0.2
--- @param fillerBufferSeconds number|nil Default 0.3
--- @return boolean
function NAG:RetTwistDebugSoCPrimaryGate(windowSeconds, maxToleranceSeconds, hysteresisSeconds, safetySeconds, fillerBufferSeconds)
    if not (self and self.IsDevModeEnabled and self:IsDevModeEnabled()) then
        return false
    end
    if not (self.InCombat and self:InCombat()) then
        return false
    end

    local window = windowSeconds or 0.4
    local maxTol = maxToleranceSeconds or 3
    local hyst = hysteresisSeconds or 0.05
    local safety = safetySeconds or 0.2
    local fillerBuffer = fillerBufferSeconds or 0.3

    local socActive = self.RetTwistIsSoCActive and self:RetTwistIsSoCActive() or false
    local sobActive = self.RetTwistIsSoBActive and self:RetTwistIsSoBActive() or false
    local judgeReady = self.SpellIsReady and self:SpellIsReady(20271) or false
    local preferSoB = self:RetTwistShouldPreferSoBForSwing(window, maxTol, hyst, safety, fillerBuffer)
    local judgePlanned = self:RetTwistJudgeSetupIsPlanned(maxTol, window, hyst, safety)
    local judgeRecent = (self.RetTwistJudgeSetupRecentlyDisplayable and self:RetTwistJudgeSetupRecentlyDisplayable(0.15)) or false
    local setupCurrent = self:RetTwistShouldSetupSoCInCurrentPreDiv(window)
    local category = self:RetTwistGetSwingTimingCategory(window)

    local blockCurrent = self:RetTwistShouldBlockSoCSetupForCS(window, "current_pre_div")
    local currentGate = self._retTwistSoCSetupCsGate or {}
    local currentReason = currentGate.reason or "n/a"
    local currentTargetAtAction = currentGate.targetSwingAtAction or 0
    local currentThreshold = currentGate.threshold or 0

    local blockNext = self:RetTwistShouldBlockSoCSetupForCS(window, "next_swing_pre_div")
    local nextGate = self._retTwistSoCSetupCsGate or {}
    local nextReason = nextGate.reason or "n/a"
    local nextTargetAtAction = nextGate.targetSwingAtAction or 0
    local nextThreshold = nextGate.threshold or 0
    local deferJudgeToFillers = self:RetTwistShouldDeferJudgeSetupToFillers(window, maxTol, hyst, safety, fillerBuffer)
    local judgeHoldSeconds = self._retTwistJudgeHoldSeconds or 0

    local line655Context = (not socActive) and (not judgeReady) and sobActive
    local line655WouldCastSoC = line655Context
        and (not preferSoB)
        and (not judgePlanned)
        and (not judgeRecent)
        and setupCurrent
        and (not blockCurrent)

    local judgeSocHoldEligible = (not socActive)
        and sobActive
        and (not deferJudgeToFillers)
        and (judgeHoldSeconds > 0)
        and (
            (setupCurrent and (not blockCurrent))
            or ((not setupCurrent) and (not blockNext))
        )

    local judgeSocImmediateEligible = (not socActive)
        and sobActive
        and (not deferJudgeToFillers)
        and (not judgePlanned)
        and (not judgeRecent)
        and judgeReady
        and (not blockCurrent)

    local judgeReason = "eligible"
    if socActive then
        judgeReason = "soc_active"
    elseif not sobActive then
        judgeReason = "sob_inactive"
    elseif deferJudgeToFillers then
        judgeReason = "defer_judge_to_fillers"
    elseif judgeHoldSeconds <= 0 then
        judgeReason = "no_judge_hold_seconds"
    elseif setupCurrent and blockCurrent then
        judgeReason = "cs_block_current:" .. tostring(currentReason)
    elseif (not setupCurrent) and blockNext then
        judgeReason = "cs_block_next:" .. tostring(nextReason)
    end

    local socReason = "eligible"
    if socActive then
        socReason = "soc_active"
    elseif preferSoB then
        socReason = "prefer_sob"
    elseif judgePlanned then
        socReason = "judge_planned"
    elseif judgeRecent then
        socReason = "judge_recent"
    elseif judgeReady then
        socReason = "judge_ready_branch"
    elseif setupCurrent and blockCurrent then
        socReason = "cs_block_current:" .. tostring(currentReason)
    elseif (not setupCurrent) and blockNext then
        socReason = "cs_block_next:" .. tostring(nextReason)
    end

    local now = (GetTime and GetTime()) or 0
    local rawSwingNow = select(2, self:AutoTimeToNext()) or 0
    local csReadyIn = self:SpellTimeToReady(35395) or 0
    if csReadyIn < 0 then
        csReadyIn = 0
    end

    local dbgKey = string.format(
        "%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s",
        tostring(line655Context),
        tostring(line655WouldCastSoC),
        tostring(judgeSocHoldEligible),
        tostring(judgeSocImmediateEligible),
        tostring(preferSoB),
        tostring(judgePlanned),
        tostring(judgeRecent),
        tostring(setupCurrent),
        tostring(blockCurrent),
        tostring(blockNext),
        tostring(judgeReady),
        tostring(sobActive),
        tostring(socActive),
        tostring(judgeHoldSeconds > 0)
    )

    if self._retTwistSoCPrimaryGateDbgLastKey ~= dbgKey
        or (not self._retTwistSoCPrimaryGateDbgLastAt)
        or ((now - self._retTwistSoCPrimaryGateDbgLastAt) >= 0.35) then
        print(string.format(
            "[RET_SOC_PRIMARY_GATE][ver=1.2.0] judgeHoldEligible=%s judgeImmediateEligible=%s judgeReason=%s socEligible=%s socReason=%s preferSoB=%s judgePlanned=%s judgeRecent=%s judgeReady=%s deferJudgeToFillers=%s setupCurrent=%s csBlockCurrent=%s csReasonCurrent=%s csBlockNext=%s csReasonNext=%s category=%s rawSwingNow=%.3f currentTargetAtAction=%.3f currentThreshold=%.3f nextTargetAtAction=%.3f nextThreshold=%.3f csReadyIn=%.3f",
            tostring(judgeSocHoldEligible),
            tostring(judgeSocImmediateEligible),
            tostring(judgeReason),
            tostring(line655WouldCastSoC),
            tostring(socReason),
            tostring(preferSoB),
            tostring(judgePlanned),
            tostring(judgeRecent),
            tostring(judgeReady),
            tostring(deferJudgeToFillers),
            tostring(setupCurrent),
            tostring(blockCurrent),
            tostring(currentReason),
            tostring(blockNext),
            tostring(nextReason),
            tostring(category),
            rawSwingNow,
            currentTargetAtAction,
            currentThreshold,
            nextTargetAtAction,
            nextThreshold,
            csReadyIn
        ))
        self._retTwistSoCPrimaryGateDbgLastKey = dbgKey
        self._retTwistSoCPrimaryGateDbgLastAt = now
    end

    return false
end

--- Returns true when SoC can be safely set up in the current swing pre-div window.
--- @param windowSeconds number|nil Default 0.4
--- @return boolean
function NAG:RetTwistShouldSetupSoCInCurrentPreDiv(windowSeconds)
    local category = self:RetTwistGetSwingTimingCategory(windowSeconds or 0.4)
    return category == "before_div"
end

--- Returns true when early CS fallback clauses should be suppressed to keep a valid Judge+SoC plan.
--- Prevents post-swing one-tick flips into CS when Judge setup is already displayable.
--- @param windowSeconds number|nil Default 0.4
--- @param maxToleranceSeconds number|nil Default 3
--- @param hysteresisSeconds number|nil Default 0.05
--- @param safetySeconds number|nil Default 0.2
--- @param fillerBufferSeconds number|nil Default 0.3
--- @return boolean
function NAG:RetTwistShouldSuppressEarlyCSForJudgeSetup(windowSeconds, maxToleranceSeconds, hysteresisSeconds, safetySeconds, fillerBufferSeconds)
    if not (self.RetTwistIsSoBActive and self:RetTwistIsSoBActive()) then
        return false
    end
    if self.RetTwistIsSoCActive and self:RetTwistIsSoCActive() then
        return false
    end
    return self:RetTwistJudgeSetupCanDisplay(
        maxToleranceSeconds or 3,
        windowSeconds or 0.4,
        hysteresisSeconds or 0.05,
        safetySeconds or 0.2,
        fillerBufferSeconds or 0.3
    )
end

--- Returns true when pre-filler Judge setup clauses should defer to filler checks.
--- This MUST NOT defer purely by swing timing category; it should defer only when the
--- predicted Judge->SoC setup is not viable at the action horizon (i.e. hold=0).
---
--- NOTE: This helper is used to prevent early "Judge+SoC" clauses from short-circuiting
--- the filler section in cases where a filler can still safely fit.
--- @param windowSeconds number|nil Default 0.4
--- @param maxToleranceSeconds number|nil Default 3
--- @param hysteresisSeconds number|nil Default 0.05
--- @param safetySeconds number|nil Default 0.2
--- @param fillerBufferSeconds number|nil Default 0.3
--- @return boolean
function NAG:RetTwistShouldDeferJudgeSetupToFillers(windowSeconds, maxToleranceSeconds, hysteresisSeconds, safetySeconds, fillerBufferSeconds)
    local window = windowSeconds or 0.4
    local maxTol = maxToleranceSeconds or 3
    local hyst = hysteresisSeconds or 0.05
    local safety = safetySeconds or 0.2
    local fillerBuffer = fillerBufferSeconds or 0.3

    if not (self.RetTwistIsSoBActive and self:RetTwistIsSoBActive()) then
        return false
    end
    if self.RetTwistIsSoCActive and self:RetTwistIsSoCActive() then
        return false
    end

    -- If GCD is still active, do not defer to fillers yet.
    -- Filler deferral is intended for immediately actionable filler decisions;
    -- during active GCD this can cause late flips where Judge+SoC appears only after GCD ends.
    local gcdLeft = self:GCDTimeToReady() or 0
    if gcdLeft < 0 then
        gcdLeft = 0
    end
    if gcdLeft > 0 then
        return false
    end

    -- Only defer if we DO have a Judge setup plan, but the wait tolerance reports "0" (filler fits / do not show).
    if not self:RetTwistJudgeSetupIsPlanned(maxTol, window, hyst, safety) then
        return false
    end

    local hold = self:RetTwistJudgeSetupWaitTolerance(maxTol, window, hyst, safety, fillerBuffer) or 0
    return hold == 0
end

--- Returns HOLD seconds to wait before SoC setup when we miss current pre-div.
--- Uses next-swing timing (not twist-gap timing) so HOLD counts down to the swing handoff.
--- @param windowSeconds number|nil Default 0.4
--- @return number
function NAG:RetTwistSoCSetupHoldSeconds(windowSeconds)
    local window = windowSeconds or 0.4
    local gcdLeft = self:GCDTimeToReady() or 0
    if gcdLeft < 0 then gcdLeft = 0 end

    local _, rawSwingNow = self:AutoTimeToNext()
    rawSwingNow = rawSwingNow or 0
    if rawSwingNow < 0 then
        rawSwingNow = 0
    end

    local swingSpeed = self:AutoSwingTime() or 0
    if swingSpeed < 0 then
        swingSpeed = 0
    end
    if swingSpeed <= 0 and rawSwingNow > 0 then
        swingSpeed = rawSwingNow
    end

    -- When on GCD and we've passed the current swing, hold counts down to next swing.
    local crossedCurrentSwing = (rawSwingNow > 0) and (gcdLeft >= rawSwingNow)
    if crossedCurrentSwing and swingSpeed > 0 then
        rawSwingNow = rawSwingNow + swingSpeed
    end

    local swingPlusSafety = getRetTwistCanonicalHoldMarkers(rawSwingNow, swingSpeed, window)
    local hold = swingPlusSafety

    -- Same post-div deferral rule as Judge HOLD:
    -- when this inequality is true, allow filler checks to run before forcing SoC HOLD.
    local allowFillerGap = canRetTwistDeferNextSwingHoldForFillers(rawSwingNow, swingSpeed, window, self:GCDTimeValue() or 0)
    if allowFillerGap then
        if self:IsDevModeEnabled() then
            local _, lhs, rhs = canRetTwistDeferNextSwingHoldForFillers(rawSwingNow, swingSpeed, window, self:GCDTimeValue() or 0)
            print(string.format(
                "[RET_SOC_SETUP_HOLD][ver=%s] result=0 reason=next_swing_filler_gap_allowed lhs=%.3f rhs=%.3f rawSwingNow=%.3f swingSpeed=%.3f gcdVal=%.3f",
                SOC_SETUP_CS_GATE_LOG_VERSION,
                lhs or 0,
                rhs or 0,
                rawSwingNow or 0,
                swingSpeed or 0,
                self:GCDTimeValue() or 0
            ))
        end
        return 0
    end

    if hold < 0.05 then
        hold = 0.05
    end
    return hold
end

--- Computes the safe pre-div tolerance window from NOW for Judge+SoC planning.
--- This mirrors the internal math used by `RetTwistJudgeSetupIsPlanned()` / `RetTwistJudgeSetupWaitTolerance()`.
--- @param maxToleranceSeconds number|nil Default 3
--- @param windowSeconds number|nil Default 0.4
--- @param hysteresisSeconds number|nil Default 0.05
--- @param safetySeconds number|nil Default 0.2
--- @return number safeTolFromNowSeconds Returns 0 when no stable pre-div tolerance exists
local function getRetTwistJudgeSetupSafeTolFromNow(self, maxToleranceSeconds, windowSeconds, hysteresisSeconds, safetySeconds)
    if not self then
        return 0
    end

    local window = windowSeconds or 0.4
    local hyst = hysteresisSeconds or 0.05
    local maxTol = maxToleranceSeconds or 3
    if maxTol < 0 then maxTol = 0 end

    local gcdLeft = self:GCDTimeToReady() or 0
    if gcdLeft < 0 then gcdLeft = 0 end

    local rawDivAtActionNow = self:RetTwistRawTimeToDivBoundaryAtAction(window) or 0
    local swingSpeed = self:AutoSwingTime() or 0
    if swingSpeed < 0 then swingSpeed = 0 end
    local rawDivAtActionNext = (swingSpeed > 0) and (rawDivAtActionNow + swingSpeed) or rawDivAtActionNow

    local useNextSwing = rawDivAtActionNow <= 0
    local rawDivUsed = useNextSwing and rawDivAtActionNext or rawDivAtActionNow
    local preDivStable = rawDivUsed > hyst
    if not preDivStable or rawDivUsed <= 0 then
        return 0
    end

    local tol = min(maxTol, rawDivUsed)
    if not tol or tol <= 0 then
        return 0
    end

    local safety = safetySeconds or 0.2
    if safety < 0 then safety = 0 end

    local safeTolAtAction = tol - safety
    if safeTolAtAction <= 0 then
        return 0
    end

    local safeTolFromNow = gcdLeft + safeTolAtAction
    if safeTolFromNow < 0 then
        safeTolFromNow = 0
    end
    return safeTolFromNow
end

--- Returns the time budget (seconds) until SoC becomes the correct next-step to maintain twist planning.
--- This is used to decide whether fillers should be evaluated before SoC alternatives.
---
--- Return contract (locked):
--- - `0`  = SoC path is immediate now.
--- - `-1` = no valid SoC path currently.
--- - `>0` = total time (seconds) until we must commit to SoC, matching the HOLD overlay timing when HOLD is shown.
--- @param windowSeconds number|nil Default 0.4
--- @return number
function NAG:TimeUntilSoC(windowSeconds)
    local window = windowSeconds or 0.4
    local shouldPrint = false -- Temporarily muted: keep only RET_FILLER_GATE output.
    if window < 0 then window = 0 end

    -- If SoC is already active, this helper is not meaningful for "setup SoC" gating.
    if self.RetTwistIsSoCActive and self:RetTwistIsSoCActive() then
        return -1
    end

    local maxTol = 3
    local hyst = 0.05
    local safety = 0.2
    local fillerBuffer = 0.3

    -- If policy says to retain SoB (i.e. do NOT expose SoC yet), treat as no SoC path for filler gating.
    if self.RetTwistShouldPreferSoBForSwing and self:RetTwistShouldPreferSoBForSwing(window, maxTol, hyst, safety, fillerBuffer) then
        return -1
    end

    -- 1) Judge+SoC planned path (SoB active): use the same HOLD math used by the overlay.
    if self.RetTwistIsSoBActive and self:RetTwistIsSoBActive() then
        if self:RetTwistJudgeSetupIsPlanned(maxTol, window, hyst, safety) then
            local hold = self:RetTwistJudgeSetupWaitTolerance(maxTol, window, hyst, safety, fillerBuffer) or 0
            if hold == -1 then
                if shouldPrint and self:IsDevModeEnabled() then
                    print(string.format("[TIME_UNTIL_SOC] path=judge_soc result=0 reason=immediate window=%.3f", window or 0))
                end
                return 0
            end
            if hold > 0 then
                if shouldPrint and self:IsDevModeEnabled() then
                    print(string.format("[TIME_UNTIL_SOC] path=judge_soc result=%.3f reason=hold window=%.3f", hold or 0, window or 0))
                end
                return hold
            end

            -- hold == 0 => fillers can fit first; return the remaining safe pre-div budget from now.
            local safeTolFromNow = getRetTwistJudgeSetupSafeTolFromNow(self, maxTol, window, hyst, safety) or 0
            if shouldPrint and self:IsDevModeEnabled() then
                print(string.format("[TIME_UNTIL_SOC] path=judge_soc result=%.3f reason=filler_fits_budget window=%.3f", safeTolFromNow or 0, window or 0))
            end
            if safeTolFromNow > 0 then
                return safeTolFromNow
            end
            return 0
        end
    end

    -- 2) Plain SoC setup path (no Judgement): use swing category + existing SoC HOLD math.
    local category, rawDivNow = self:RetTwistGetSwingTimingCategory(window)
    if category == "before_div" then
        local budget = rawDivNow or 0
        if budget < 0 then budget = 0 end
        if shouldPrint and self:IsDevModeEnabled() then
            print(string.format("[TIME_UNTIL_SOC] path=soc_plain result=%.3f reason=before_div_budget window=%.3f", budget or 0, window or 0))
        end
        return budget
    end

    local hold = self:RetTwistSoCSetupHoldSeconds(window) or 0
    if hold > 0 then
        if shouldPrint and self:IsDevModeEnabled() then
            print(string.format("[TIME_UNTIL_SOC] path=soc_plain result=%.3f reason=next_swing_hold window=%.3f", hold or 0, window or 0))
        end
        return hold
    end
    if hold == 0 then
        -- Filler-gap is allowed post-div; return next-swing pre-div deadline (Marker B).
        local _, rawSwingNow = self:AutoTimeToNext()
        local swingSpeed = self:AutoSwingTime() or 0
        local _, nextSwingPreDivMinusSafety = getRetTwistCanonicalHoldMarkers(rawSwingNow or 0, swingSpeed or 0, window)
        local budget = nextSwingPreDivMinusSafety or 0
        if budget < 0 then budget = 0 end
        if shouldPrint and self:IsDevModeEnabled() then
            print(string.format("[TIME_UNTIL_SOC] path=soc_plain result=%.3f reason=post_div_filler_gap_budget window=%.3f", budget or 0, window or 0))
        end
        return budget
    end

    return -1
end

local function retTwistFillerGateDebug(self, tag, stateKey, message)
    if not (self and self.IsDevModeEnabled and self:IsDevModeEnabled()) then
        return
    end

    local now = (_G.GetTime and _G.GetTime()) or 0
    self._retTwistFillerGateDebugState = self._retTwistFillerGateDebugState or {}
    local rec = self._retTwistFillerGateDebugState[tag]
    if rec and rec.key == stateKey and (now - (rec.at or 0)) <= 0.25 then
        return
    end

    -- print(message)
    self._retTwistFillerGateDebugState[tag] = {
        key = stateKey,
        at = now,
    }
end

--- Returns true when filler checks should run before SoC alternatives.
--- @param windowSeconds number|nil Default 0.4
--- @return boolean
function NAG:RetTwistCanCheckFillersBeforeSoC(windowSeconds)
    local window = windowSeconds or 0.4
    local timeUntil = self:TimeUntilSoC(window)
    if not timeUntil or timeUntil < 0 then
        retTwistFillerGateDebug(
            self,
            "CAN_CHECK_FILLERS",
            "invalid_timeuntil",
            string.format(
                "[RET_FILLER_GATE][canCheckFillers] allow=false reason=no_soc_path window=%.3f timeUntil=%s",
                window,
                tostring(timeUntil)
            )
        )
        return false
    end
    local gcdVal = self:GCDTimeValue() or 0
    if gcdVal < 0 then gcdVal = 0 end
    local threshold = gcdVal + 0.1
    local allowed = timeUntil >= threshold
    retTwistFillerGateDebug(
        self,
        "CAN_CHECK_FILLERS",
        string.format("%s|%.2f|%.2f", tostring(allowed), timeUntil, threshold),
        string.format(
            "[RET_FILLER_GATE][canCheckFillers] allow=%s reason=%s window=%.3f timeUntil=%.3f threshold=%.3f",
            tostring(allowed),
            allowed and "budget_ok" or "budget_too_small",
            window,
            timeUntil,
            threshold
        )
    )
    return allowed
end

--- Returns true when CS should be prioritized over backup Judge+SoC timing.
--- Rule: if (Judge+SoC+HOLD lead time) exceeds remaining CS cooldown, show CS.
--- @param csSpellId number|nil Default 35395
--- @return boolean
function NAG:RetTwistBackupShouldPrioritizeCSBeforeJudgeSoC(csSpellId)
    local csId = csSpellId or 35395
    local csReadyIn = self:SpellTimeToReady(csId)
    if not csReadyIn or csReadyIn < 0 then
        return false
    end
    local leadTime = self:RetTwistBackupJudgeSoCLeadTime()
    return leadTime > csReadyIn
end

--- Returns HOLD seconds for backup Judge+SoC post-div handling.
--- @param windowSeconds number|nil Default 0.4
--- @return number
function NAG:RetTwistBackupJudgeHoldSeconds(windowSeconds)
    return self:RetTwistSoCSetupHoldSeconds(windowSeconds or 0.4)
end

--- Returns true if it is safe (timing-wise) to spend a GCD on `spellId` and still reach the next twist window.
--- This is an APL support helper for fillers; it is intentionally conservative.
--- @param spellId number
--- @param windowSeconds number|nil Default: 0.4
--- @param reactionSeconds number|nil Default: 0.1
--- @return boolean
function NAG:RetTwistCanCastFillerBeforeTwist(spellId, windowSeconds, reactionSeconds)
    if not spellId then
        retTwistFillerGateDebug(self, "FILLER_BEFORE_TWIST", "missing_spell", "[RET_FILLER_GATE][beforeTwist] allow=false reason=missing_spell")
        return false
    end

    local window = windowSeconds or 0.4
    local reaction = reactionSeconds or 0.1
    if reaction < 0 then reaction = 0 end
    local allowed = false
    local reason = "unknown"
    local timeToWindowAtAction = 0
    local fillerGcd = 0
    local useNextSwing = false
    local rawDivAtActionNow = 0
    local swingAtAction = 0
    local soBActive = false
    local soCActive = false

    -- Must be usable for current target/context (prevents Exorcism on invalid targets, etc.)
    if IsUsableSpell and not IsUsableSpell(spellId) then
        reason = "not_usable"
    else
        -- If spell will not be ready by the time the GCD ends, don't suggest it as a filler.
        local gcd = self:GCDTimeToReady() or 0
        local ttr = self:SpellTimeToReady(spellId)
        if ttr and ttr > 0 and ttr > gcd then
            reason = "spell_not_ready_by_gcd"
        else
            -- Ensure there is enough time before the relevant twist window opens at ACTION horizon.
            -- If SoC is not active and current swing is already post-div, use NEXT swing window.
            local rawSwingNow = 0
            swingAtAction, rawSwingNow = self:AutoTimeToNextAfterGCD()
            swingAtAction = swingAtAction or 0
            rawSwingNow = rawSwingNow or 0
            if swingAtAction < 0 then swingAtAction = 0 end
            if rawSwingNow < 0 then rawSwingNow = 0 end

            local swingSpeed = self:AutoSwingTime() or 0
            if swingSpeed < 0 then swingSpeed = 0 end

            rawDivAtActionNow = self:RetTwistRawTimeToDivBoundaryAtAction(window) or 0
            soBActive = (self.RetTwistIsSoBActive and self:RetTwistIsSoBActive()) or false
            soCActive = (self.RetTwistIsSoCActive and self:RetTwistIsSoCActive()) or false
            useNextSwing = (not soCActive) and (rawDivAtActionNow <= 0) and (swingSpeed > 0)

            -- If SoB is active, SoC is not active, and we're still pre-div at action horizon,
            -- SoC setup has priority over fillers.
            if soBActive and (not soCActive) and rawDivAtActionNow > 0 then
                reason = "soc_setup_priority_prediv"
                allowed = false
                fillerGcd = self:SpellGCDHastedDuration(spellId) or 1.5
                if fillerGcd < 0 then fillerGcd = 0 end
                timeToWindowAtAction = max(0, swingAtAction - window)
            else

                local swingForWindow = swingAtAction
                if useNextSwing then
                    swingForWindow = swingForWindow + swingSpeed
                end
                timeToWindowAtAction = max(0, swingForWindow - window)

                fillerGcd = self:SpellGCDHastedDuration(spellId) or 1.5
                if fillerGcd < 0 then fillerGcd = 0 end

                -- Small fixed buffer (matches WA-style conservatism, avoids cutting it too close)
                local safety = 0.05
                if (fillerGcd + reaction + safety) > timeToWindowAtAction then
                    reason = "window_too_small"
                else
                    -- Also avoid swing clipping for non-instant casts.
                    allowed = self:CanWeave(spellId)
                    reason = allowed and "ok" or "canweave_failed"
                end
            end
        end
    end
    retTwistFillerGateDebug(
        self,
        "FILLER_BEFORE_TWIST",
        string.format("%s|%d|%s|%.2f|%.2f|%s", tostring(allowed), spellId, reason, timeToWindowAtAction or 0, fillerGcd or 0, tostring(useNextSwing)),
        string.format(
            "[RET_FILLER_GATE][beforeTwist] allow=%s spell=%d reason=%s window=%.3f timeToWindowAtAction=%.3f fillerGcd=%.3f reaction=%.3f useNextSwing=%s rawDivAtAction=%.3f swingAtAction=%.3f sobActive=%s socActive=%s",
            tostring(allowed),
            spellId,
            reason,
            window,
            timeToWindowAtAction or 0,
            fillerGcd or 0,
            reaction,
            tostring(useNextSwing),
            rawDivAtActionNow or 0,
            swingAtAction or 0,
            tostring(soBActive),
            tostring(soCActive)
        )
    )
    return allowed
end

--- Returns true when it's safe to spend a filler GCD before CS comes up.
--- Mirrors RetSim-style guard: only allow filler if its GCD+reaction budget fits before CS ready.
--- @param spellId number
--- @param csSpellId number|nil Default 35395 (Crusader Strike)
--- @param reactionSeconds number|nil Default 0.1
--- @return boolean
function NAG:RetTwistCanCastFillerBeforeCS(spellId, csSpellId, reactionSeconds)
    if not spellId then
        retTwistFillerGateDebug(self, "FILLER_BEFORE_CS", "missing_spell", "[RET_FILLER_GATE][beforeCS] allow=false reason=missing_spell")
        return false
    end

    local csId = csSpellId or 35395
    if self.SpellIsKnown and (not self:SpellIsKnown(csId)) then
        retTwistFillerGateDebug(
            self,
            "FILLER_BEFORE_CS",
            string.format("allow_no_cs_%d", spellId),
            string.format("[RET_FILLER_GATE][beforeCS] allow=true spell=%d reason=cs_not_known csId=%d", spellId, csId)
        )
        return true
    end

    local csReadyIn = self:SpellTimeToReady(csId)
    if csReadyIn == nil then
        retTwistFillerGateDebug(
            self,
            "FILLER_BEFORE_CS",
            string.format("nil_cs_%d", spellId),
            string.format("[RET_FILLER_GATE][beforeCS] allow=false spell=%d reason=cs_ready_nil csId=%d", spellId, csId)
        )
        return false
    end
    if csReadyIn < 0 then
        csReadyIn = 0
    end
    if csReadyIn <= 0 then
        retTwistFillerGateDebug(
            self,
            "FILLER_BEFORE_CS",
            string.format("cs_now_%d", spellId),
            string.format("[RET_FILLER_GATE][beforeCS] allow=false spell=%d reason=cs_ready_now csId=%d", spellId, csId)
        )
        return false
    end

    local fillerGcd = self:SpellGCDHastedDuration(spellId) or self:GCDTimeValue() or 1.5
    if fillerGcd < 0 then
        fillerGcd = 0
    end

    local reaction = reactionSeconds or 0.1
    if reaction < 0 then
        reaction = 0
    end

    local safety = 0.05
    local budget = fillerGcd + reaction + safety
    local allowed = budget < csReadyIn
    retTwistFillerGateDebug(
        self,
        "FILLER_BEFORE_CS",
        string.format("%s|%d|%.2f|%.2f", tostring(allowed), spellId, budget, csReadyIn),
        string.format(
            "[RET_FILLER_GATE][beforeCS] allow=%s spell=%d budget=%.3f csReadyIn=%.3f fillerGcd=%.3f reaction=%.3f",
            tostring(allowed),
            spellId,
            budget,
            csReadyIn,
            fillerGcd,
            reaction
        )
    )
    return allowed
end

--- Returns true when fillers should be blocked because SoB is active and we are in current-swing pre-div.
--- Requested rule: pre-div spans from just after the last swing until `(weaponSpeed - window - fillerGCD)`.
--- With default values this is `weaponSpeed - 0.4 - 1.5`.
--- GCD-aware behavior: evaluate against ACTION-TIME horizon (when we can actually press filler),
--- so if GCD expiry lands in the twist gap, this helper won't incorrectly block for "pre-div now".
--- @param windowSeconds number|nil Default 0.4
--- @param fillerGcdSeconds number|nil Default 1.5
--- @return boolean
function NAG:RetTwistShouldBlockFillersInSoBPreDiv(windowSeconds, fillerGcdSeconds)
    local soBActive = (self.RetTwistIsSoBActive and self:RetTwistIsSoBActive()) or false
    if not soBActive then
        retTwistFillerGateDebug(self, "BLOCK_FILLERS_SOB_PREDIV", "sob_inactive", "[RET_FILLER_GATE][sobPreDiv] block=false reason=sob_not_active")
        return false
    end
    local soCActive = (self.RetTwistIsSoCActive and self:RetTwistIsSoCActive()) or false

    local window = windowSeconds or 0.4
    if window < 0 then
        window = 0
    end

    local fillerGcd = fillerGcdSeconds or 1.5
    if fillerGcd < 0 then
        fillerGcd = 0
    end

    local swingAtAction, rawSwingNow = self:AutoTimeToNextAfterGCD()
    swingAtAction = swingAtAction or 0
    rawSwingNow = rawSwingNow or 0
    if swingAtAction < 0 then
        swingAtAction = 0
    end
    if rawSwingNow < 0 then
        rawSwingNow = 0
    end

    local threshold = window + fillerGcd
    local rawDivAtActionNow = self:RetTwistRawTimeToDivBoundaryAtAction(window) or 0

    -- Core setup priority: if SoB is active, SoC is not active, and we're still pre-div at action horizon,
    -- fillers should be blocked to allow SoC setup.
    if (not soCActive) and rawDivAtActionNow > 0 then
        retTwistFillerGateDebug(
            self,
            "BLOCK_FILLERS_SOB_PREDIV",
            string.format("block_soc_setup_prediv|%.2f|%.2f", rawDivAtActionNow or 0, swingAtAction or 0),
            string.format(
                "[RET_FILLER_GATE][sobPreDiv] block=true reason=soc_setup_priority_prediv rawDivAtAction=%.3f rawSwingNow=%.3f swingAtAction=%.3f threshold=%.3f",
                rawDivAtActionNow or 0,
                rawSwingNow,
                swingAtAction,
                threshold
            )
        )
        return true
    end

    -- Explicit "post mid-mark" allow:
    -- if current-swing remaining is already at/inside `(window + fillerGcd)`, do not block fillers.
    -- This prevents next-swing projection from over-blocking when we're already past the current pre-div zone.
    if rawSwingNow <= threshold then
        retTwistFillerGateDebug(
            self,
            "BLOCK_FILLERS_SOB_PREDIV",
            string.format("allow_postmid|%.2f|%.2f", rawSwingNow, threshold),
            string.format(
                "[RET_FILLER_GATE][sobPreDiv] block=false reason=post_midmark rawSwingNow=%.3f swingAtAction=%.3f threshold=%.3f",
                rawSwingNow,
                swingAtAction,
                threshold
            )
        )
        return false
    end

    -- ACTION-horizon guard: if by the time GCD ends we land at/inside post-div (or twist gap),
    -- fillers should be allowed. Only block when still clearly pre-div at action time.
    local inPreDivAtAction = swingAtAction > threshold
    retTwistFillerGateDebug(
        self,
        "BLOCK_FILLERS_SOB_PREDIV",
        string.format("%s|%.2f|%.2f|%.2f", tostring(inPreDivAtAction), rawSwingNow, swingAtAction, threshold),
        string.format(
            "[RET_FILLER_GATE][sobPreDiv] block=%s reason=%s rawSwingNow=%.3f swingAtAction=%.3f threshold=%.3f window=%.3f fillerGcd=%.3f",
            tostring(inPreDivAtAction),
            inPreDivAtAction and "prediv_at_action" or "lands_post_div_or_gap",
            rawSwingNow,
            swingAtAction,
            threshold,
            window,
            fillerGcd
        )
    )
    return inPreDivAtAction
end

-- ============================ WARRIOR: SLAM WEAVING HELPERS (TBC ARMS 2H) ============================
-- These helpers intentionally mirror the Ret twist design:
-- - Evaluate timing at ACTION TIME (GCD end) where relevant
-- - Provide a stable HOLD-region decision (hysteresis) to avoid 1-tick flicker
-- - Use a runtime module for last swing impact timing (for the post-swing Slam window)

local function getWarriorSlamWeaveModule(self)
    if not self or not self.GetModule then
        return nil
    end
    local mod = self:GetModule("WarriorSlamWeaveModule", true)
    if not mod then
        return nil
    end
    if mod.IsEnabled and (not mod:IsEnabled()) then
        return nil
    end
    if mod.db and mod.db.class and mod.db.class.enabled == false then
        return nil
    end
    return mod
end

local function getWarriorSlamWeaveConfig(self)
    local mod = getWarriorSlamWeaveModule(self)
    local defaults = {
        slamWindowSeconds = 0.25,
        slamLatencySeconds = 0.10,
        slamGcdDelaySeconds = 0.40,
        slamMsWwDelaySeconds = 2.00,
        holdReactionSeconds = 0.10,
    }

    if not mod or not mod.db or not mod.db.class then
        return defaults
    end

    local db = mod.db.class
    return {
        slamWindowSeconds = db.slamWindowSeconds or defaults.slamWindowSeconds,
        slamLatencySeconds = db.slamLatencySeconds or defaults.slamLatencySeconds,
        slamGcdDelaySeconds = db.slamGcdDelaySeconds or defaults.slamGcdDelaySeconds,
        slamMsWwDelaySeconds = db.slamMsWwDelaySeconds or defaults.slamMsWwDelaySeconds,
        holdReactionSeconds = db.holdReactionSeconds or defaults.holdReactionSeconds,
    }
end

--- Returns the last observed player melee swing impact time (seconds, GetTime()).
--- @return number
function NAG:WarriorSlamWeaveLastSwingTime()
    local mod = getWarriorSlamWeaveModule(self)
    if not mod then
        return 0
    end
    mod:InitializeState()
    return (mod.state and mod.state.lastSwingTime) or 0
end

--- Returns seconds since last swing impact. Returns math.huge if unknown.
--- @return number
function NAG:WarriorSlamWeaveTimeSinceLastSwing()
    local last = self:WarriorSlamWeaveLastSwingTime() or 0
    if last <= 0 then
        return math.huge
    end
    local now = GetTime and GetTime() or 0
    local dt = now - last
    if dt < 0 then dt = 0 end
    return dt
end

--- Returns true if we are inside the post-swing \"Slam now\" window.
--- This is a *player UX* helper: it answers \"did a swing just land recently?\".
--- @param nowWindowSeconds number|nil Default 0.25
--- @return boolean
function NAG:WarriorSlamWeaveIsInSlamNowWindow(nowWindowSeconds)
    local window = nowWindowSeconds or 0.25
    if window < 0 then window = 0 end
    local dt = self:WarriorSlamWeaveTimeSinceLastSwing()
    if not dt or dt == math.huge then
        return false
    end
    return dt <= window
end

--- Returns true if we should queue Slam NOW based on sim-style timing gates.
--- Respects slam window, GCD delay gate, and MS/WW delay budget.
--- @param msSpellId number|nil Mortal Strike ID
--- @param wwSpellId number|nil Whirlwind ID
--- @return boolean
function NAG:WarriorSlamWeaveShouldSlamNow(msSpellId, wwSpellId)
    local config = getWarriorSlamWeaveConfig(self)
    local window = config.slamWindowSeconds or 0.25
    if window < 0 then window = 0 end

    local dt = self:WarriorSlamWeaveTimeSinceLastSwing()
    if not dt or dt == math.huge or dt > window then
        return false
    end

    local slamLatency = config.slamLatencySeconds or 0.10
    if slamLatency < 0 then slamLatency = 0 end
    local slamGcdDelay = config.slamGcdDelaySeconds or 0.40
    if slamGcdDelay < 0 then slamGcdDelay = 0 end

    local gcdLeft = self:GCDTimeToReady() or 0
    if gcdLeft < 0 then gcdLeft = 0 end
    if gcdLeft > slamLatency and (gcdLeft - slamLatency) > slamGcdDelay then
        return false
    end

    local slamAt = slamLatency
    if gcdLeft > slamLatency then
        slamAt = gcdLeft
    end

    local slamGcd = self:GCDTimeValue() or 1.5
    if slamGcd < 0 then slamGcd = 0 end
    local gcdReadyAgainAt = slamAt + slamGcd

    local msDelay = 0
    if msSpellId and self:SpellIsKnown(msSpellId) then
        local ttr = self:SpellTimeToReady(msSpellId) or 0
        if ttr < 0 then ttr = 0 end
        msDelay = math.max(0, gcdReadyAgainAt - ttr)
    end

    local wwDelay = 0
    if wwSpellId and self:SpellIsKnown(wwSpellId) then
        local ttr = self:SpellTimeToReady(wwSpellId) or 0
        if ttr < 0 then ttr = 0 end
        wwDelay = math.max(0, gcdReadyAgainAt - ttr)
    end

    local delayBudget = config.slamMsWwDelaySeconds or 2.00
    if delayBudget > 0 and (msDelay + wwDelay) > delayBudget then
        return false
    end

    return true
end

--- Returns raw time-to-hold boundary at ACTION TIME (GCD end):
--- positive => safe to spend another full GCD and still be free at the next swing
--- <= 0 => starting a full GCD would overlap the next swing (should HOLD)
--- @param reactionSeconds number|nil Default 0.10
--- @return number
function NAG:WarriorSlamWeaveRawTimeToHoldBoundary(reactionSeconds)
    local reaction = reactionSeconds or 0.10
    if reaction < 0 then reaction = 0 end

    local gcdVal = self:GCDTimeValue() or 0
    if gcdVal < 0 then gcdVal = 0 end

    -- Time to next swing evaluated at ACTION TIME (GCD end).
    local timeToSwingAtAction = self:AutoTimeToNextAfterGCD() or 0
    if timeToSwingAtAction < 0 then timeToSwingAtAction = 0 end

    return timeToSwingAtAction - (gcdVal + reaction)
end

--- Stable (hysteresis) HOLD region helper to avoid flicker at the boundary.
--- @param reactionSeconds number|nil Default 0.10
--- @param hysteresisSeconds number|nil Default 0.05
--- @return boolean
function NAG:WarriorSlamWeaveIsInHoldRegion(reactionSeconds, hysteresisSeconds)
    local hyst = hysteresisSeconds or 0.05
    if hyst < 0 then hyst = 0 end

    local raw = self:WarriorSlamWeaveRawTimeToHoldBoundary(reactionSeconds)
    local prev = self._warriorSlamWeaveHoldStable

    if prev == nil then
        prev = raw <= 0
        self._warriorSlamWeaveHoldStable = prev
        return prev
    end

    if prev then
        -- Stay in HOLD until we are clearly safe by hysteresis margin
        if raw > hyst then
            self._warriorSlamWeaveHoldStable = false
        end
    else
        -- Stay out of HOLD until we are clearly unsafe by hysteresis margin
        if raw < -hyst then
            self._warriorSlamWeaveHoldStable = true
        end
    end

    return self._warriorSlamWeaveHoldStable
end

--- Returns true if it is safe (timing-wise) to spend a GCD on `spellId` and still be free at the next swing.
--- Intended for mid-cycle fillers like Mortal Strike / Whirlwind in a Slam-weaving rotation.
--- @param spellId number
--- @param reactionSeconds number|nil Default 0.10
--- @return boolean
function NAG:WarriorSlamWeaveCanCastFillerBeforeHold(spellId, reactionSeconds)
    if not spellId then
        return false
    end

    local reaction = reactionSeconds or 0.10
    if reaction < 0 then reaction = 0 end

    -- Must be usable for current target/context.
    if IsUsableSpell and not IsUsableSpell(spellId) then
        return false
    end

    -- If spell won't be ready by action time, don't suggest it as filler.
    local gcdLeft = self:GCDTimeToReady() or 0
    if gcdLeft < 0 then gcdLeft = 0 end
    local ttr = self:SpellTimeToReady(spellId)
    if ttr and ttr > 0 and ttr > gcdLeft then
        return false
    end

    -- Project time-to-swing at ACTION TIME (GCD end).
    local timeToSwingAtAction = self:AutoTimeToNextAfterGCD() or 0
    if timeToSwingAtAction <= 0 then
        return false
    end

    local fillerGcd = self:SpellGCDHastedDuration(spellId) or (self:GCDTimeValue() or 1.5)
    if fillerGcd < 0 then fillerGcd = 0 end

    -- Small fixed buffer (avoid cutting it too close)
    local safety = 0.05
    if (fillerGcd + reaction + safety) > timeToSwingAtAction then
        return false
    end

    -- Also avoid swing clipping for non-instant casts.
    return self:CanWeave(spellId)
end

--- Estimates the time until the next opportunity to weave a spell.
--- Returns 0 for instant casts, math.huge if weaving is impossible, or the time until the next gap.
--- @function NAG:TimeToNextWeaveGap
--- @param spellId number The spell ID to check.
--- @return number The estimated time in seconds until the next weave gap, or math.huge if weaving is impossible.
--- @usage NAG:TimeToNextWeaveGap(12345)
--- @local This function is used to estimate the time until the next opportunity to weave a spell.
function NAG:TimeToNextWeaveGap(spellId)
    local castTime = getMaelstromAdjustedCastTime(self, spellId, self:SpellCastTime(spellId))

    -- For instant cast spells, return 0 since they can always be weaved
    if castTime == 0 then
        return 0
    end


    -- Check if we're currently casting or channeling
    local name = UnitCastingInfo("player")
    if name or StateManager.state.casting then
        return math.huge
    end

    -- Apply Maelstrom Weapon logic for input delay with latency awareness and fixed buffer
    local userPing = self:GetNetStats()               -- Use cached network stats
    local baseInputDelay = self:InputDelay() or 0.050 -- fallback to 50ms
    local staticPressBuffer = 0.200                   -- 200ms flat buffer for press-to-cast
    local maelstromStacks = self:AuraNumStacks(51530) -- Maelstrom Weapon spell ID

    -- Final delay: input + ping + 200ms fixed buffer
    local adjustedInputDelay = baseInputDelay + userPing + staticPressBuffer
    if maelstromStacks >= 5 then
        adjustedInputDelay = 0                                  -- instant cast, ignore delay
    else
        adjustedInputDelay = math.min(adjustedInputDelay, 0.45) -- cap at 0.45s
    end

    local totalCastTime = adjustedInputDelay + castTime
    local weaponSpeed = self:AutoSwingTime(Types.SwingType.MainHand)
    local currentSwingTime = self:AutoTimeToNext()

    -- If total cast time is greater than weapon speed, weaving is impossible
    if totalCastTime >= weaponSpeed then
        return math.huge
    end

    -- If we can't weave now but it's theoretically possible (totalCastTime < weaponSpeed)
    if totalCastTime >= currentSwingTime then
        -- Return the actual remaining time before the next auto-attack
        return currentSwingTime + NAG:GCDTimeToReady()
    end

    -- If we can weave now, return 0
    return 0
end

--- Calculates the difference between mainhand and offhand swing times.
--- Returns the phase difference in seconds, or 0 if unavailable.
--- @function NAG:SwingTimeDifference
--- @return number The difference in swing times.
--- @usage local diff = NAG:SwingTimeDifference()
function NAG:SwingTimeDifference()
    if not swingTimerLib then return 0 end

    -- Initialize swing timer tracking with custom handler for mainhand swing tracking
    initializeSwingTimer(function(event, ...)
        if event == "UNIT_SWING_TIMER_DELTA" then
            local _, swingDelta = ...
            NAG.lastSwingDelta = abs(swingDelta) -- Ensure positive value
        elseif event == "UNIT_SWING_TIMER_START" then
            local _, hand = ...
            if hand == "mainhand" then
                NAG.lastMainHandSwing = GetTime()
            end
        end
    end)

    local mhSpeed, mhExpiration, mhLastSwing = swingTimerLib:UnitSwingTimerInfo("player", "mainhand")
    local ohSpeed, ohExpiration, ohLastSwing = swingTimerLib:UnitSwingTimerInfo("player", "offhand")

    if not mhSpeed or not ohSpeed then
        --self:Debug("SwingTimeDifference: Missing weapon speeds")
        return 0
    end

    -- Calculate current swing positions
    local currentTime = GetTime()
    local mhPosition = mhExpiration and (mhExpiration - currentTime) or 0
    local ohPosition = ohExpiration and (ohExpiration - currentTime) or 0

    -- Calculate the phase difference between the swings
    local difference = abs(mhPosition - ohPosition)

    -- If the difference is more than half the swing time, adjust it
    local minSwingTime = min(mhSpeed, ohSpeed)
    if difference > (minSwingTime / 2) then
        difference = minSwingTime - difference
    end

    -- Use cached delta if available
    if self.lastSwingDelta then
        difference = self.lastSwingDelta
    end

    return difference
end
