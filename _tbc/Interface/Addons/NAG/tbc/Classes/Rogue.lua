local _, ns = ...
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")
local L = ns.AceLocale:GetLocale("NAG", true)
--- @type Version
local Version = ns.Version

local defaults = ns.InitializeClassDefaults()

local combatMacros = {
    {
        name = "Rogue Racial Orc",
        body = "#showtooltip\n/cast Blood Fury(Racial)\n/use Haste Potion\n/use Thistle Tea\n/use 13"
    },
    {
        name = "Rogue Racial Troll",
        body = "#showtooltip\n/cast Berserking(Racial)\n/use Haste Potion\n/use Thistle Tea\n/use 13"
    },
    {
        name = "Rogue Racial",
        body = "#showtooltip\n/use Haste Potion\n/use Thistle Tea\n/use 13"
    },
}

-- ============================ EXPOSE ARMOR / FINISHER GATING ============================
-- Sim (wowsims-tbc) EA rules for reference:
-- - MaintainExpose = not doneEA and (ImprovedExposeArmor==2 or target has no Sunder).
-- - doneEA = true if not rotation.maintainExposeArmor, or when remaining sim time <= 30s after an EA cast.
-- - Refresh when eaTimeRemaining <= time to build 5 CP + EA cost from current state (eaBuildTime).
-- - SnD is prioritized: PlanMaximalSlice gets SnD while leaving time for EA; EA cast requires SnD healthy.
-- NAG mirrors: assignment toggle, SnD >= 5s before EA, 5 CP, RemainingTime gates (>=10 or >=3 in encounter),
-- and RogueExposeArmorAllowsFinishers() to avoid finisher deadlock when EA is due but not castable.

-- ============================ MULTI-TARGET TTD HELPERS ============================

local UnitGUID = _G.UnitGUID
local TTDManager = ns.TTDManager

local _rogueNearbyMinTTD = 0
local function rogueNearbyTTDCustomCheck(unit)
    if not unit or not UnitGUID then
        return false
    end
    if not TTDManager or not TTDManager.GetTTD then
        return false
    end

    local guid = UnitGUID(unit)
    if not guid then
        return false
    end

    local ttd = TTDManager:GetTTD(guid, 3)
    -- Exclude unknown sentinels (e.g., 8888) by requiring < 7777.
    return ttd and (ttd > _rogueNearbyMinTTD) and (ttd < 7777)
end

local _rogueNearbyTTDOpts = { customCheck = rogueNearbyTTDCustomCheck }

--- True if any nearby enemy has a known TTD greater than the threshold.
--- This is used for multi-target “refresh SnD before spending CP” logic.
--- @param minTTD number
--- @param range number
--- @return boolean
function NAG:RogueHasNearbyEnemyKnownTTDGreaterThan(minTTD, range)
    if not TTDManager or not TTDManager.GetEnemyUnitsInRange then
        return false
    end

    local r = tonumber(range) or 8
    if r <= 0 then
        r = 8
    end

    _rogueNearbyMinTTD = tonumber(minTTD) or 12
    local count = TTDManager:GetEnemyUnitsInRange(r, _rogueNearbyTTDOpts) or 0
    return count >= 1
end

local _rogueNearbyMaxKnownTTD = 0
local function rogueNearbyMaxTTDCustomCheck(unit)
    if not unit or not UnitGUID then
        return false
    end
    if not TTDManager or not TTDManager.GetTTD then
        return false
    end

    local guid = UnitGUID(unit)
    if not guid then
        return false
    end

    local ttd = TTDManager:GetTTD(guid, 3)
    if ttd and ttd > 0 and ttd < 7777 then
        if ttd > _rogueNearbyMaxKnownTTD then
            _rogueNearbyMaxKnownTTD = ttd
        end
        return true
    end

    return false
end

local _rogueNearbyMaxTTDOpts = { customCheck = rogueNearbyMaxTTDCustomCheck }

--- Returns the largest known TTD among nearby enemies.
--- Falls back to target RemainingTime() when no nearby known TTD is available.
--- @param range number|nil
--- @return number|nil
function NAG:RogueLargestNearbyKnownTTD(range)
    local fallbackTTD = tonumber(self:RemainingTime()) or 8888

    if not TTDManager or not TTDManager.GetEnemyUnitsInRange then
        if fallbackTTD > 0 and fallbackTTD < 7777 then
            return fallbackTTD
        end
        return nil
    end

    local r = tonumber(range) or 8
    if r <= 0 then
        r = 8
    end

    _rogueNearbyMaxKnownTTD = 0
    local knownCount = TTDManager:GetEnemyUnitsInRange(r, _rogueNearbyMaxTTDOpts) or 0
    if knownCount >= 1 and _rogueNearbyMaxKnownTTD > 0 then
        return _rogueNearbyMaxKnownTTD
    end

    if fallbackTTD > 0 and fallbackTTD < 7777 then
        return fallbackTTD
    end

    return nil
end

--- Predicts build time for the specified combo points using conservative buff-aware pacing.
--- Baseline seconds-per-CP is adapted from active SnD/BF state:
--- - SnD + BF: 3.4
--- - SnD only: 3.6
--- - BF only: 3.6
--- - Neither: 3.8
--- If Adrenaline Rush is active, the AR-active segment is computed at double pace, and
--- any remaining segment after AR expires is computed at baseline pace.
--- @param comboPointsNeeded number|nil
--- @return number
function NAG:RoguePredictTimeToBuildComboPoints(comboPointsNeeded)
    local cp = tonumber(comboPointsNeeded) or 0
    if cp < 0 then cp = 0 end
    if cp > 5 then cp = 5 end
    if cp == 0 then
        return 0
    end

    local sndActive = (self:AuraRemainingTime(5171, "player") or 0) > 0 -- Slice and Dice
    local bladeFlurryActive = (self:AuraRemainingTime(13877, "player") or 0) > 0 -- Blade Flurry
    local baseSecondsPerCP = 3.6
    if sndActive and bladeFlurryActive then
        baseSecondsPerCP = 3.3
    elseif sndActive or bladeFlurryActive then
        baseSecondsPerCP = 3.4
    end

    local baseCPPerSecond = 1 / baseSecondsPerCP
    local arCPPerSecond = baseCPPerSecond * 2
    local arRemaining = self:AuraRemainingTime(13750, "player") or 0 -- Adrenaline Rush

    if arRemaining <= 0 then
        return cp * baseSecondsPerCP
    end

    local cpBuiltDuringAR = arRemaining * arCPPerSecond
    if cpBuiltDuringAR >= cp then
        return cp / arCPPerSecond
    end

    local cpRemainingAfterAR = cp - cpBuiltDuringAR
    return arRemaining + (cpRemainingAfterAR / baseCPPerSecond)
end

--- Returns the minimum combo points needed for predictive SnD timing.
--- Goal: when the refreshed SnD eventually expires, nearby max TTD should be ~expiryBufferSeconds.
--- Incorporates current SnD remaining into the target duration math.
--- @param range number|nil
--- @param expiryBufferSeconds number|nil
--- @return number
function NAG:RogueDesiredSnDComboPointsPredictive(range, expiryBufferSeconds)
    local largestTTD = self:RogueLargestNearbyKnownTTD(range)
    if not largestTTD then
        return 1
    end

    local expiryBuffer = tonumber(expiryBufferSeconds) or 5
    if expiryBuffer < 0 then
        expiryBuffer = 0
    end

    local sndRemaining = self:AuraRemainingTime(5171, "player") or 0
    -- Time left at planned refresh point is approximately largestTTD - current SnD remaining.
    local targetDuration = (largestTTD - sndRemaining) - expiryBuffer
    if targetDuration <= 0 then
        return 1
    end

    for cp = 1, 5 do
        if self:RogueSliceAndDiceFullDuration(cp) >= targetDuration then
            return cp
        end
    end

    return 5
end

--- Returns true when SnD should be cast at current combo points.
--- Behavior:
--- - While SnD is still active (<=1s), use predictive desired CP.
--- - Once SnD has dropped, cast immediately at any CP >= 1.
--- Preserves existing SnD hold guardrails (EA assignment and hold checks).
--- @param range number|nil
--- @param expiryBufferSeconds number|nil
--- @return boolean
function NAG:RogueShouldCastPredictiveSnD(range, expiryBufferSeconds)
    local sndRemaining = self:AuraRemainingTime(5171, "player") or 0
    if sndRemaining > 1 then
        return false
    end

    local comboPoints = self:CurrentComboPoints() or 0
    if comboPoints < 1 then
        return false
    end

    if self:RogueShouldAvoidSnDHolding(comboPoints) then
        return false
    end

    if self:RogueShouldHoldSnDForAssignedExposeArmor() then
        return false
    end

    if sndRemaining <= 0 then
        return true
    end

    -- TODO(EA timing): future EA-priority helper should short-circuit desired SnD CP here.
    local desiredCP = self:RogueDesiredSnDComboPointsPredictive(range, expiryBufferSeconds)
    return comboPoints >= desiredCP
end

-- Backward-compatible aliases while we migrate call sites.
function NAG:RogueDesiredSnDComboPoints(range, expiryBufferSeconds)
    return self:RogueDesiredSnDComboPointsPredictive(range, expiryBufferSeconds)
end

function NAG:RogueShouldCastAdaptiveSnD(range, expiryBufferSeconds)
    return self:RogueShouldCastPredictiveSnD(range, expiryBufferSeconds)
end

-- ============================ RUPTURE TTD GATING ============================

--- Full duration of Rupture by combo points in TBC.
--- 1cp=8s, 2cp=10s, 3cp=12s, 4cp=14s, 5cp=16s.
--- @param comboPoints number
--- @return number
function NAG:RogueRuptureDurationForComboPoints(comboPoints)
    local cp = tonumber(comboPoints) or 0
    if cp < 1 then cp = 1 end
    if cp > 5 then cp = 5 end
    return 6 + (2 * cp)
end

--- True if the current target is expected to live long enough to justify applying Rupture.
--- Uses the target's TTD directly (ignores encounter timer mode) to avoid suggesting Rupture on
--- dying targets even when an encounter timer is running.
---
--- Behavior:
--- - If target is fresh at 100% HP (TTD intentionally unknown), allow Rupture (consistent with prior behavior).
--- - If TTD is known: require TTD >= Rupture duration for current combo points.
--- - If TTD is unknown on a non-fresh target: do not suggest Rupture (conservative).
--- @return boolean
function NAG:RogueTargetTTDLongEnoughForRupture()
    if not UnitGUID or not TTDManager or not TTDManager.GetTTD then
        return true
    end

    local guid = UnitGUID("target")
    if not guid then
        return false
    end

    local UnitHealth = _G.UnitHealth
    local UnitHealthMax = _G.UnitHealthMax
    local hp = UnitHealth and UnitHealth("target") or 0
    local maxHealth = UnitHealthMax and UnitHealthMax("target") or 0

    -- Fresh target at 100% HP reports unknown TTD by design; treat as safe to apply.
    if maxHealth > 0 and hp >= maxHealth then
        return true
    end

    local ttd = TTDManager:GetTTD(guid, 3)
    if not ttd or ttd <= 0 or ttd >= 7777 then
        return false
    end

    local cp = self:CurrentComboPoints() or 0
    local needed = self:RogueRuptureDurationForComboPoints(cp)
    return ttd >= needed
end

--- Strict early-finisher Rupture eligibility for Combat.
--- Requires: 3+ CP, Rupture not active, and enough remaining fight time for full Rupture + 5s buffer.
--- @return boolean
function NAG:RogueShouldUseEarlyRupture()
    local comboPoints = self:CurrentComboPoints() or 0
    if comboPoints < 3 then
        return false
    end

    if (self:DotRemainingTime(1943) or 0) > 0 then
        return false
    end

    local remainingTime = self:RemainingTime() or 8888
    local requiredTime = self:RogueRuptureDurationForComboPoints(comboPoints) + 5
    return remainingTime >= requiredTime
end

--- Returns true if damage finishers should be allowed when Expose Armor assignment is enabled.
--- Assigned EA cadence priority is maintenance first (5cp Expose Armor and 5cp Slice and Dice).
--- Rupture/Eviscerate are allowed only when both maintenance timers have enough buffer.
--- @return boolean
function NAG:RogueExposeArmorAllowsFinishers()
    if not (NAG:GetNumGroupMembers() > 0 and self:IsAssignmentEnabled("expose_armor")) then
        return true
    end

    -- End-of-fight: spend freely, but only when remaining time is a valid positive value.
    -- Encounter timer can transiently report 0 at pull bootstrap; do not treat that as execute.
    local remainingTime = self:RemainingTime() or 8888
    if remainingTime > 0 and remainingTime <= 10 then
        return true
    end

    local comboPoints = self:CurrentComboPoints() or 0
    local exposeRemaining = self:DotRemainingTime(8647) or 0
    local sndRemaining = self:AuraRemainingTime(5171) or 0
    local maintenanceWindow = 8

    -- Preserve CP economy for assignment cadence: only spend damage finishers at 5 CP.
    if comboPoints < 5 then
        return false
    end

    -- If either maintenance finisher is due soon, hold damage finishers.
    if exposeRemaining <= maintenanceWindow or sndRemaining <= maintenanceWindow then
        return false
    end

    return true
end

--- Returns true when SnD should be held so assigned Expose Armor can be established first.
--- Rule: if both SnD and Expose Armor are down and EA is assigned, allow SnD only at exactly 1 CP.
--- At 2+ CP, hold SnD and prioritize reaching/casting 5cp Expose Armor.
--- @return boolean
function NAG:RogueShouldHoldSnDForAssignedExposeArmor()
    if not (NAG:GetNumGroupMembers() > 0 and self:IsAssignmentEnabled("expose_armor")) then
        return false
    end

    local sndMissing = (self:AuraRemainingTime(5171) <= 1)
    local exposeMissing = (self:DotRemainingTime(8647) <= 2)
    local comboPoints = self:CurrentComboPoints() or 0

    return sndMissing and exposeMissing and (comboPoints > 1)
end

--- Returns true when assigned Expose Armor; we always prioritize EA over SnD.
--- @return boolean
function NAG:RogueShouldBootstrapExposeArmorFirst()
    return NAG:GetNumGroupMembers() > 0 and self:IsAssignmentEnabled("expose_armor")
end

local EA_BUILD_TIME_FACTOR = 1.15

--- Predictive time needed to reach 5 combo points for Expose Armor.
--- Uses the generic buff-aware predictor, then applies an EA-only conservative factor.
--- @param comboPointsOverride number|nil Optional CP state (used for post-spend evaluations)
--- @return number
function NAG:RoguePredictTimeToBuildEA(comboPointsOverride)
    local comboPoints = comboPointsOverride
    if comboPoints == nil then
        comboPoints = self:CurrentComboPoints() or 0
    end
    comboPoints = tonumber(comboPoints) or 0
    if comboPoints < 0 then comboPoints = 0 end
    if comboPoints > 5 then comboPoints = 5 end

    local needed = 5 - comboPoints
    if needed < 0 then
        needed = 0
    end
    local baseTime = self:RoguePredictTimeToBuildComboPoints(needed)
    return baseTime * EA_BUILD_TIME_FACTOR
end

--- True when assigned Expose Armor should be maintained. EA is on current target only; no TTD check.
--- @return boolean
function NAG:RogueShouldMaintainExposeArmorNow()
    return NAG:GetNumGroupMembers() > 0 and self:IsAssignmentEnabled("expose_armor")
end

--- True when combat should stop spending finishers and start preserving CP/energy for Expose Armor.
--- Optional combo point override lets callers evaluate post-spend state conservatively.
--- @param range number|nil
--- @param dropWindowSeconds number|nil
--- @param comboPointsOverride number|nil
--- @return boolean
function NAG:RogueShouldStartSavingForExposeArmor(range, dropWindowSeconds, comboPointsOverride)
    if not self:RogueShouldMaintainExposeArmorNow() then
        return false
    end

    local exposeRemaining = self:DotRemainingTime(8647) or 0
    if exposeRemaining <= 2 then
        return true
    end

    local comboPoints = comboPointsOverride
    if comboPoints == nil then
        comboPoints = self:CurrentComboPoints() or 0
    end
    comboPoints = tonumber(comboPoints) or 0
    if comboPoints < 0 then comboPoints = 0 end
    if comboPoints > 5 then comboPoints = 5 end

    local buildTime = self:RoguePredictTimeToBuildEA(comboPoints)
    return exposeRemaining <= buildTime
end

--- SnD exception while saving for Expose Armor in Combat.
--- Allowed only when SnD is expired/about to expire and player has exactly 1 CP.
--- @return boolean
function NAG:RogueShouldAllowSnDWhileSavingEA()
    if not self:RogueShouldStartSavingForExposeArmor(8, 8) then
        return false
    end

    local sndRemaining = self:AuraRemainingTime(5171, "player") or 0
    local comboPoints = self:CurrentComboPoints() or 0
    return sndRemaining <= 1 and comboPoints == 1
end

--- Combat-only finisher gate while Expose Armor assignment is active.
--- EA has priority unless near end-of-fight or emergency execute fallback.
--- @return boolean
function NAG:RogueCombatExposeArmorAllowsFinishers()
    if not (NAG:GetNumGroupMembers() > 0 and self:IsAssignmentEnabled("expose_armor")) then
        return true
    end

    -- Preserve existing emergency finisher behavior.
    local remainingTime = self:RemainingTime() or 8888
    if remainingTime > 0 and remainingTime < 2 then
        return true
    end

    -- If we no longer need to maintain EA (fight ending soon), finishers are free.
    if not self:RogueShouldMaintainExposeArmorNow() then
        return true
    end

    -- During save window, finishers are blocked to prioritize EA setup/cast.
    -- Evaluate with post-finisher CP=0 to avoid optimistic leaks (e.g. 3cp Rupture while EA is due).
    if self:RogueShouldStartSavingForExposeArmor(8, 8, 0) then
        return false
    end

    return true
end

-- TBC Rogue spec spell locations
defaults.class.specSpellLocations = {
    [1] = { -- Assassination
        [13750] = NAG.SPELL_POSITIONS.LEFT, -- Adrenaline Rush
        [13877] = NAG.SPELL_POSITIONS.LEFT, -- Blade Flurry
        [20572] = NAG.SPELL_POSITIONS.LEFT, -- Blood Fury (Orc Racial)
        [26297] = NAG.SPELL_POSITIONS.LEFT, -- Berserking (Troll Racial)
        [22838] = NAG.SPELL_POSITIONS.LEFT, -- Racial macro (e.g. Berserking)
        [28734] = NAG.SPELL_POSITIONS.LEFT, -- Mana Tap (BE Racial)
        [25046] = NAG.SPELL_POSITIONS.LEFT, -- Arcane Torrent (BE Racial)
    },
    [2] = { -- Combat
        [13750] = NAG.SPELL_POSITIONS.LEFT, -- Adrenaline Rush
        [13877] = NAG.SPELL_POSITIONS.LEFT, -- Blade Flurry
        [20572] = NAG.SPELL_POSITIONS.LEFT, -- Blood Fury (Orc Racial)
        [26297] = NAG.SPELL_POSITIONS.LEFT, -- Berserking (Troll Racial)
        [22838] = NAG.SPELL_POSITIONS.LEFT, -- Racial macro
        [28734] = NAG.SPELL_POSITIONS.LEFT, -- Mana Tap (BE Racial)
        [25046] = NAG.SPELL_POSITIONS.LEFT, -- Arcane Torrent (BE Racial)
    },
    [3] = { -- Subtlety
        [13750] = NAG.SPELL_POSITIONS.LEFT, -- Adrenaline Rush
        [13877] = NAG.SPELL_POSITIONS.LEFT, -- Blade Flurry
        [20572] = NAG.SPELL_POSITIONS.LEFT, -- Blood Fury (Orc Racial)
        [26297] = NAG.SPELL_POSITIONS.LEFT, -- Berserking (Troll Racial)
        [22838] = NAG.SPELL_POSITIONS.LEFT, -- Racial macro
        [28734] = NAG.SPELL_POSITIONS.LEFT, -- Mana Tap (BE Racial)
        [25046] = NAG.SPELL_POSITIONS.LEFT, -- Arcane Torrent (BE Racial)
    },
}

-- Class assignments for raid coordination
defaults.class.classAssignments = {
    {
        id = "expose_armor",
        name = "Expose Armor",
        description = "Apply armor reduction debuff on targets (conflicts with Warrior Sunder Armor)",
        spellIds = {8647, 8649, 8650, 11197, 11198, 26866}, -- All ranks
        category = "debuff",
    },
}

defaults.char.assignmentToggles = defaults.char.assignmentToggles or {}
if defaults.char.assignmentToggles.expose_armor == nil then
    defaults.char.assignmentToggles.expose_armor = false
end
defaults.char.saveEnergyForKicks = false

if UnitClassBase('player') ~= "ROGUE" then return end

-- Generic (0 talent points): low-level abilities before choosing a spec
local genericRotation = {
    name = "Generic",
    specIndex = 0,
    class = "ROGUE",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    rotationString = [[
    (NAG:CurrentComboPoints() >= 4 and NAG:SpellCanCast(2098)) and NAG:Cast(2098)
    or (NAG:SpellCanCast(1752)) and NAG:Cast(1752)
]],
}

-- Assassination Rotation
local assassinationRotation = {
    -- Core identification
    name = "Assassination",
    specIndex = 1,
    class = "ROGUE",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    rotationString = [[
NAG:EnableAssignmentsGate()
or
(not NAG:InCombat()) and (not NAG:RogueHasDeadlyPoisonOH()) and NAG:CastPlaceholderWithOverlay(26967, "OH", NAG.SPELL_POSITIONS.LEFT) -- Deadly Poison VII (OH)
or
(not NAG:InCombat()) and (not NAG:RogueHasInstantPoisonMH()) and (not NAG:HasWindfuryTotemWeaponBuff()) and NAG:CastPlaceholderWithOverlay(8679, "MH", NAG.SPELL_POSITIONS.LEFT) -- Instant Poison VII (MH, skip if Windfury)
or
NAG:StrictSequence("Cold Blood", nil, 14177, 1329) -- Cold Blood
or
NAG:SpellIsKnown(32549) and NAG:AuraIsActive(5171) and (not NAG:IsActive(51120, "player" )) and NAG:AuraIsActive(13750) and NAG:Cast(185848) -- Greater Drums of Battle
or
NAG:SpellIsKnown(32549) and NAG:AuraIsActive(5171) and (not NAG:IsActive(51120, "player" )) and NAG:AuraIsActive(13750) and NAG:Cast(29529) -- Drums of Battle
or
NAG:AuraIsActive(5171) and NAG:SpellIsKnown(20572) and NAG:CastWithOverlay(20572, "Racial Macro") -- Orc Racials
or
NAG:AuraIsActive(5171) and NAG:SpellIsKnown(26297) and NAG:CastWithOverlay(26297, "Racial Macro") -- Troll Racials
or
NAG:AuraIsActive(5171) and NAG:CastWithOverlay(22838, "Racial Macro")
or
(((not NAG:RogueShouldStartSavingForExposeArmor(8, 8)) and NAG:RogueShouldCastPredictiveSnD(8, 5)) or NAG:RogueShouldAllowSnDWhileSavingEA()) and ((NAG:RemainingTime() >= 9) or (NAG:RemainingTime() < 7777 and NAG:RogueSliceAndDiceFullDuration() >= NAG:RemainingTime())) and NAG:Cast(5171) -- Slice And Dice (EA-aware predictive timing)
or
(NAG:InCombat() and NAG:CurrentComboPoints() >= 1 and (NAG:AuraRemainingTime(5171, "player") < 3) and (NAG:NumberTargets(8, false) >= 2) and NAG:RogueHasNearbyEnemyKnownTTDGreaterThan(12, 8)) and NAG:Cast(5171) -- Slice And Dice (multi-target: any nearby mob TTD > 12s)
or
(NAG:GetNumGroupMembers() > 0) and NAG:IsAssignmentEnabled("expose_armor")
    and (NAG:DotRemainingTime(8647) <= 2)
    and NAG:SpellCanCast(8647)
    and (NAG:AuraRemainingTime(5171) >= 5 or NAG:RogueShouldBootstrapExposeArmorFirst())
    and NAG:CurrentComboPoints() >= 5
    and ((not NAG:InEncounter()) and NAG:RemainingTime() >= 10 or (NAG:InEncounter() and NAG:RemainingTime() >= 3))
    and NAG:Cast(8647) -- Expose Armor
or
(NAG:RogueExposeArmorAllowsFinishers()) and (NAG:NumberTargets() == 1 or (not NAG:AuraIsActive(13877, "player"))) and (NAG:DotRemainingTime(1943) == 0) and (NAG:AuraRemainingTime(5171) >= 5 or NAG:RemainingTime() <= 9 or NAG:RogueShouldAvoidSnDHolding()) and (NAG:CurrentComboPoints() >= 3 or (NAG:RemainingTime() < 2 and NAG:CurrentComboPoints() >= 1)) and (NAG:RemainingTime() > 16  and NAG:RemainingTime() < 600) and NAG:RogueTargetTTDLongEnoughForRupture() and NAG:Cast(1943) -- Rupture
or
(NAG:RogueExposeArmorAllowsFinishers()) and (NAG:AuraRemainingTime(5171) >= 5 or NAG:RemainingTime() <= 9 or NAG:RogueShouldAvoidSnDHolding()) and (NAG:CurrentComboPoints() >= 3 or (NAG:RemainingTime() < 2 and NAG:CurrentComboPoints() >= 1)) and NAG:Cast(2098) -- Eviscerate
or
NAG:AuraIsActive(27186, "target") and (NAG:DotRemainingTime(27186) <= 3) and NAG:Cast(5938) -- Deadly Poison and Shiv
or
NAG:SpellIsKnown(28734) and (NAG:CurrentEnergyAtGCD() < 30) and NAG:Cast(28734) -- BE Racial Mana Tap
or
NAG:AuraNumStacks(28734) >= 3 and NAG:SpellIsKnown(25046) and (NAG:CurrentEnergyAtGCD() < 30) and NAG:Cast(25046) -- BE Racial Arcane Torrent
or
(NAG:CurrentComboPoints() <= 4 or (NAG:CurrentEnergyAtGCD() > 80)) and NAG:Cast(1329) -- Mutilate

    ]],
}

-- Combat Rotation
local combatRotation = {
    -- Core identification
    name = "Combat",
    specIndex = 2,
    class = "ROGUE",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    lastModified = "12/10/2025",
    author = "@horalius",
    macros = combatMacros,
    enableSmartSwitching = true,
    rotationString = [[
NAG:EnableAssignmentsGate()
or
(not NAG:InCombat()) and (not NAG:RogueHasDeadlyPoisonOH()) and NAG:CastPlaceholderWithOverlay(26967, "OH", NAG.SPELL_POSITIONS.LEFT) -- Deadly Poison VII (OH)
or
(not NAG:InCombat()) and (not NAG:RogueHasInstantPoisonMH()) and (not NAG:HasWindfuryTotemWeaponBuff()) and NAG:CastPlaceholderWithOverlay(8681, "MH", NAG.SPELL_POSITIONS.LEFT) -- Instant Poison VII (MH, skip if Windfury)
or
(NAG:CurrentComboPoints() == 1) and (NAG:AuraRemainingTime(5171, "player") <= 0.5) and ((NAG:RemainingTime() >= 8) or (NAG:NumberTargets(8, false) >= 2 and NAG:RogueHasNearbyEnemyKnownTTDGreaterThan(12, 8))) and NAG:Cast(5171) -- SnD down at 1 CP: apply 1cp SnD (TTD-gated; AOE bypass)
or
NAG:AuraIsActive(5171) and NAG:Cast(13750) -- Adrenaline Rush
or
NAG:SpellIsKnown(32549) and NAG:AuraIsActive(13750) and NAG:Cast(185848) -- Greater Drums of Battle
or
NAG:AuraIsActive(5171) and NAG:SpellIsKnown(20572) and NAG:CastWithOverlay(20572, "Racial Macro") -- Orc Racials
or
NAG:AuraIsActive(5171) and NAG:SpellIsKnown(26297) and NAG:CastWithOverlay(26297, "Racial Macro") -- Troll Racials
or
NAG:SpellIsReady(13877) and (NAG:NumberTargets(8) >= 2 or NAG:AuraIsActive(5171, "player")) and NAG:Cast(13877) -- Blade Flurry
or
-- Expose Armor: refresh when debuff missing or <=2s (matches wowsims-tbc refresh-by-build-time logic)
    NAG:IsAssignmentEnabled("expose_armor")
    and (NAG:DotRemainingTime(8647) <= 2)
    and NAG:CurrentComboPoints() >= 5
    and ((not NAG:InEncounter()) and NAG:RemainingTime() >= 10 or (NAG:InEncounter() and NAG:RemainingTime() >= 3))
    and NAG:Cast(8647) -- Expose Armor

or
(((not NAG:RogueShouldStartSavingForExposeArmor(8, 8)) and NAG:RogueShouldCastPredictiveSnD(8, 5)) or NAG:RogueShouldAllowSnDWhileSavingEA()) and ((NAG:RemainingTime() >= 9) or (NAG:RemainingTime() < 7777 and NAG:RogueSliceAndDiceFullDuration() >= NAG:RemainingTime())) and NAG:Cast(5171) -- Slice And Dice (EA-aware predictive timing)
or
(NAG:InCombat() and (not NAG:RogueShouldHoldSnDForAssignedExposeArmor()) and NAG:CurrentComboPoints() >= 1 and (NAG:AuraRemainingTime(5171, "player") < 3) and (NAG:NumberTargets(8, false) >= 2) and NAG:RogueHasNearbyEnemyKnownTTDGreaterThan(12, 8)) and NAG:Cast(5171) -- Slice And Dice (multi-target: any nearby mob TTD > 12s)
or
(NAG:RogueCombatExposeArmorAllowsFinishers()) and (NAG:NumberTargets() == 1 or (not NAG:AuraIsActive(13877, "player"))) and (NAG:AuraRemainingTime(5171) >= 5 or NAG:RogueShouldAvoidSnDHolding()) and NAG:RogueShouldUseEarlyRupture() and NAG:RogueTargetTTDLongEnoughForRupture() and NAG:Cast(1943) -- Rupture
or
(NAG:RogueCombatExposeArmorAllowsFinishers()) and (NAG:AuraRemainingTime(5171) >= 5 or NAG:RogueShouldAvoidSnDHolding()) and ((NAG:CurrentComboPoints() >= 3 and (not NAG:RogueShouldUseEarlyRupture())) or (NAG:RemainingTime() < 2 and NAG:CurrentComboPoints() >= 1)) and ((NAG:RemainingTime() < 21 ) or (NAG:NumberTargets() >= 2)) and NAG:Cast(2098) -- Eviscerate
or
NAG:AuraIsActive(27186, "target") and (NAG:DotRemainingTime(27186) <= 3) and NAG:Cast(5938) -- Deadly Poison and Shiv
or
NAG:SpellIsKnown(28734) and (NAG:CurrentEnergyAtGCD() < 30) and NAG:Cast(28734) -- BE Racial Mana Tap
or
NAG:AuraNumStacks(28734) >= 3 and NAG:SpellIsKnown(25046) and (NAG:CurrentEnergyAtGCD() < 30) and NAG:Cast(25046) -- BE Racial Arcane Torrent
or
NAG:Cast(14251)
or
(NAG:CurrentComboPoints() >= 5) and (NAG:CurrentEnergyAtGCD() < 80) and NAG:CastWithOverlay(1752, "Pool\nEnergy\nto FULL") -- Higher-priority pool hint while waiting to spend 5 CP
or
NAG:Cast(1752) -- Sinister Strike
]],
}

-- Subtlety Rotation
local subtletyRotation = {
    -- Core identification
    name = "Subtlety",
    specIndex = 3,
    class = "ROGUE",
    default = true,
    enabled = true,
    gameType = Version.GAME_TYPES.CLASSIC_TBC,
    rotationString = [[
NAG:EnableAssignmentsGate()
or
(not NAG:InCombat()) and (not NAG:RogueHasDeadlyPoisonOH()) and NAG:CastPlaceholderWithOverlay(26967, "OH", NAG.SPELL_POSITIONS.LEFT) -- Deadly Poison VII (OH)
or
(not NAG:InCombat()) and (not NAG:RogueHasInstantPoisonMH()) and (not NAG:HasWindfuryTotemWeaponBuff()) and NAG:CastPlaceholderWithOverlay(8679, "MH", NAG.SPELL_POSITIONS.LEFT) -- Instant Poison VII (MH, skip if Windfury)
or
NAG:AuraIsActive(5171) and NAG:Cast(13750) -- Adrenaline Rush
or
NAG:SpellIsKnown(32549) and NAG:AuraIsActive(5171) and (not NAG:IsActive(51120, "player" )) and NAG:AuraIsActive(13750) and NAG:Cast(185848) -- Greater Drums of Battle
or
NAG:SpellIsKnown(32549) and NAG:AuraIsActive(5171) and (not NAG:IsActive(51120, "player" )) and NAG:AuraIsActive(13750) and NAG:Cast(29529) -- Drums of Battle
or
NAG:AuraIsActive(5171) and NAG:SpellIsKnown(20572) and NAG:CastWithOverlay(20572, "Racial Macro") -- Orc Racials
or
NAG:AuraIsActive(5171) and NAG:SpellIsKnown(26297) and NAG:CastWithOverlay(26297, "Racial Macro") -- Troll Racials
or
NAG:AuraIsActive(5171) and NAG:CastWithOverlay(22838, "Racial Macro")
or
NAG:SpellIsReady(13877) and (NAG:NumberTargets(8) >= 2 or NAG:AuraIsActive(5171, "player")) and NAG:Cast(13877) -- Blade Flurry
or
(NAG:RogueShouldCastPredictiveSnD(8, 5)) and ((NAG:RemainingTime() >= 9) or (NAG:RemainingTime() < 7777 and NAG:RogueSliceAndDiceFullDuration() >= NAG:RemainingTime())) and NAG:Cast(5171) -- Slice And Dice (predictive CP by nearby TTD)
or
(NAG:InCombat() and NAG:CurrentComboPoints() >= 1 and (NAG:AuraRemainingTime(5171, "player") < 3) and (NAG:NumberTargets(8, false) >= 2) and NAG:RogueHasNearbyEnemyKnownTTDGreaterThan(12, 8)) and NAG:Cast(5171) -- Slice And Dice (multi-target: any nearby mob TTD > 12s)
or
(NAG:GetNumGroupMembers() > 0) and NAG:IsAssignmentEnabled("expose_armor")
    and (NAG:DotRemainingTime(8647) <= 2)
    and (NAG:AuraRemainingTime(5171) >= 5 or NAG:RogueShouldBootstrapExposeArmorFirst())
    and NAG:CurrentComboPoints() >= 5
    and ((not NAG:InEncounter()) and NAG:RemainingTime() >= 10 or (NAG:InEncounter() and NAG:RemainingTime() >= 3))
    and NAG:Cast(8647) -- Expose Armor
or
(NAG:RogueExposeArmorAllowsFinishers()) and (NAG:NumberTargets() == 1 or (not NAG:AuraIsActive(13877, "player"))) and (NAG:DotRemainingTime(1943) == 0) and (NAG:AuraRemainingTime(5171) >= 5 or NAG:RogueShouldAvoidSnDHolding()) and (NAG:CurrentComboPoints() >= 3 or (NAG:RemainingTime() < 2 and NAG:CurrentComboPoints() >= 1)) and (NAG:RemainingTime() > 16 ) and NAG:RogueTargetTTDLongEnoughForRupture() and NAG:Cast(1943) -- Rupture
or
(NAG:RogueExposeArmorAllowsFinishers()) and (NAG:AuraRemainingTime(5171) >= 5 or NAG:RogueShouldAvoidSnDHolding()) and (NAG:CurrentComboPoints() >= 3 or (NAG:RemainingTime() < 2 and NAG:CurrentComboPoints() >= 1)) and ((NAG:RemainingTime() < 21 ) or (NAG:NumberTargets() >= 2)) and NAG:Cast(2098) -- Eviscerate
or
NAG:AuraIsActive(27186, "target") and (NAG:DotRemainingTime(27186) <= 3) and NAG:Cast(5938) -- Deadly Poison and Shiv
or
NAG:SpellIsKnown(28734) and (NAG:CurrentEnergyAtGCD() < 30) and NAG:Cast(28734) -- BE Racial Mana Tap
or
NAG:AuraNumStacks(28734) >= 3 and NAG:SpellIsKnown(25046) and (NAG:CurrentEnergyAtGCD() < 30) and NAG:Cast(25046) -- BE Racial Arcane Torrent
or
(NAG:CurrentComboPoints() <= 4 or (NAG:CurrentEnergyAtGCD() > 80)) and NAG:Cast(16511) -- Hemorrhage
]],
}

--- @class Rogue : ClassBase
local Rogue = NAG:CreateClassModule("ROGUE", defaults)
if not Rogue then return end

function Rogue:SetupClassDefaults()
    ns.AddRotationToDefaults(self.defaults, 0, genericRotation)  -- Generic (no talents)
    ns.AddRotationToDefaults(self.defaults, 1, assassinationRotation)  -- Assassination
    ns.AddRotationToDefaults(self.defaults, 2, combatRotation)  -- Combat
    --ns.AddRotationToDefaults(self.defaults, 2, combatRotationExposeArmor)  -- Combat w/Expose Armor
    ns.AddRotationToDefaults(self.defaults, 3, subtletyRotation)  -- Subtlety
end

NAG.Class = Rogue

