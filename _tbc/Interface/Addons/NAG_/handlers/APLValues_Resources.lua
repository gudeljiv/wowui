--- @module "APLValues_Resources"
--- Resource-related APL value functions for the NAG addon
---
--- This module provides utility functions for mana, energy, rage, and other resource management.
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
local Version = ns.Version
local Types = ns.Types

-- Lua APIs (WoW optimized where available)
local GetTime = _G.GetTime
local UnitExists = _G.UnitExists
local UnitHealth = _G.UnitHealth
local UnitHealthMax = _G.UnitHealthMax
local UnitPower = _G.UnitPower
local UnitPowerMax = _G.UnitPowerMax
local UnitStat = _G.UnitStat
local UnitSpellHaste = _G.UnitSpellHaste
local UnitAffectingCombat = _G.UnitAffectingCombat
local UnitAttackSpeed = _G.UnitAttackSpeed
local UnitLevel = _G.UnitLevel
local UnitPowerType = _G.UnitPowerType
local GetComboPoints = _G.GetComboPoints
local GetMeleeHaste = _G.GetMeleeHaste
local GetPowerRegen = _G.GetPowerRegen
local GetShapeshiftForm = _G.GetShapeshiftForm
local GetSpellPowerCost = C_Spell and C_Spell.GetSpellPowerCost or _G.GetSpellPowerCost

local format = string.format
local floor = math.floor
local min = math.min
local max = math.max

local tinsert = tinsert

local pairs = pairs
local ipairs = ipairs
local type = type

-- ============================ MODULE CACHING (PERFORMANCE) ============================
-- Cache frequently accessed modules to avoid GetModule overhead in hot paths
local StateManager = ns.StateManager
local SpecCompat = ns.SpecCompat

-- ============================ CONSTANTS ============================
-- Cache StanceType lookup to avoid string allocations
local STANCE_TYPE = Types.StanceType or Types:GetType("StanceType")
local WARRIOR_STANCE_IDS = {
    Battle = 17,
    Defensive = 18,
    Berserker = 19
}

local function GetWarriorStanceId()
    local formId = StateManager:GetShapeshiftFormID()
    if formId then
        return formId
    end
    return GetShapeshiftForm and GetShapeshiftForm() or nil
end

-- ============================ CONSTANTS ============================
-- Resource type name lookup table (cached to avoid string allocations in hot path)
local RESOURCE_TYPE_NAMES = {
    -- Retail
    [Enum.PowerType.Mana] = "MANA",
    [Enum.PowerType.Energy] = "ENERGY",
    [Enum.PowerType.Rage] = "RAGE",
    [Enum.PowerType.RunicPower] = "RUNIC_POWER",
    [Enum.PowerType.Focus] = "FOCUS",
    -- Classic (numeric power types)
    [0] = "MANA",
    [1] = "RAGE",
    [2] = "FOCUS",
    [3] = "ENERGY",
    [6] = "RUNIC_POWER",
}
local ROGUE_KICK_SPELL_ID = 1766
local ROGUE_KICK_ENERGY_RESERVE = 20

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

-- ============================ HEALTH FUNCTIONS ============================

--- Get the current health of a unit
--- @param sourceUnit? string The unit to check health for (defaults to "player")
--- @return number The current health of the specified unit
--- @usage NAG:CurrentHealth() >= 1000
--- @usage NAG:CurrentHealth("target") >= 5000
function NAG:CurrentHealth(sourceUnit)
    sourceUnit = sourceUnit or "player"
    if type(sourceUnit) ~= "string" then
        sourceUnit = "player"
    end
    return UnitHealth(sourceUnit)
end

--- Get the maximum health of the player
--- @return number The maximum health of the player
--- @usage NAG:MaxHealth() >= 10000
function NAG:MaxHealth()
    return UnitHealthMax("player")
end

--- Get the current health percentage of a unit
--- @param unit? string The unit to check health percentage for (defaults to "player")
--- @return number The current health percentage of the specified unit (0-1 for all units)
--- @usage NAG:CurrentHealthPercent() >= 0.5
--- @usage NAG:CurrentHealthPercent("target") >= 0.2
function NAG:CurrentHealthPercent(unit)
    unit = unit or "player"
    if type(unit) ~= "string" then
        unit = "player"
    end

    -- Handle target-specific logic
    if unit == "target" then
        if not UnitExists("target") then return 0 end
        local health = UnitHealth("target")
        local maxHealth = UnitHealthMax("target")
        if not health or not maxHealth or maxHealth == 0 then return 0 end

        local healthPerc = (health / maxHealth)

        -- Use unified encounter timer system for training dummy simulation
        if ns.IsTrainingDummy() then
            if NAG.db.global.enableEncounterTimer then
                local remainingPercent = NAG:RemainingTimePercent()
                if remainingPercent and remainingPercent > 0 and remainingPercent < 7777 then
                    -- RemainingTimePercent() returns 0-100; normalize to 0-1
                    healthPerc = remainingPercent / 100
                end
            end
        end

        return healthPerc
    else
        -- For non-target units (player, etc.), return 0-1 range for consistency
        local healthPerc = 0
        local maxHealth = UnitHealthMax(unit)
        if maxHealth and maxHealth > 0 then
            healthPerc = (UnitHealth(unit) / maxHealth)
        end
        return healthPerc
    end
end

-- ============================ MANA FUNCTIONS ============================

--- Get the current mana of a unit
--- @param sourceUnit? string The unit to check mana for (defaults to "player")
--- @return number The current mana of the specified unit
--- @usage NAG:CurrentMana() >= 1000
--- @usage NAG:CurrentMana("target") >= 5000
function NAG:CurrentMana(sourceUnit)
    sourceUnit = sourceUnit or "player"
    if type(sourceUnit) ~= "string" then
        sourceUnit = "player"
    end
    return UnitPower(sourceUnit, Enum.PowerType.Mana)
end

--- Get the current mana percentage of a unit
--- @param sourceUnit? string The unit to check mana percentage for (defaults to "player")
--- @return number The current mana percentage of the specified unit (0-1 decimal range)
--- @usage NAG:CurrentManaPercent() >= 0.3
--- @usage NAG:CurrentManaPercent("target") >= 0.5
function NAG:CurrentManaPercent(sourceUnit)
    sourceUnit = sourceUnit or "player"
    if type(sourceUnit) ~= "string" then
        sourceUnit = "player"
    end

    local currentMana = UnitPower(sourceUnit, Enum.PowerType.Mana)
    local maxMana = UnitPowerMax(sourceUnit, Enum.PowerType.Mana)

    if not maxMana or maxMana == 0 then
        return 0
    end

    local manaPerc = currentMana / maxMana
    return manaPerc
end

--- Get base mana for a class at a given level (TBC formula)
--- Base mana calculation: level * classCoefficient + baseOffset
--- @param class string The class name (e.g., "DRUID", "SHAMAN")
--- @param level number The character level
--- @return number The base mana value
--- @local
local function GetBaseMana(class, level)
    if not class or not level or level < 1 then
        return 0
    end

    -- TBC base mana coefficients per class
    -- Formula: level * coefficient + offset
    local baseManaCoeffs = {
        DRUID = 15,      -- Druid: 15 mana per level
        SHAMAN = 15,     -- Shaman: 15 mana per level
        PRIEST = 11,     -- Priest: 11 mana per level
        MAGE = 10,       -- Mage: 10 mana per level
        WARLOCK = 10,    -- Warlock: 10 mana per level
        PALADIN = 15,    -- Paladin: 15 mana per level
    }

    local coefficient = baseManaCoeffs[class] or 10
    local baseMana = level * coefficient

    -- Add base offset (varies by class and level range)
    -- At level 70, druids have approximately 1050 base mana
    -- This is approximate: level * 15 gives us the scaling component
    -- We'll use a more accurate formula based on TBC values
    if class == "DRUID" then
        -- Druid base mana at level 70 is approximately 1050
        -- Using formula: baseMana = (level - 1) * 15 + base
        baseMana = (level - 1) * 15 + 20
    elseif class == "SHAMAN" then
        baseMana = (level - 1) * 15 + 20
    elseif class == "PRIEST" then
        baseMana = (level - 1) * 11 + 20
    elseif class == "MAGE" then
        baseMana = (level - 1) * 10 + 20
    elseif class == "WARLOCK" then
        baseMana = (level - 1) * 10 + 20
    elseif class == "PALADIN" then
        baseMana = (level - 1) * 15 + 20
    end

    return baseMana
end

--- Get the current mana percentage based on BASE mana (not total mana pool)
--- This is useful for powershifting checks where you want to know mana percentage
--- relative to your base mana pool, ignoring temporary mana pool increases from buffs.
--- @param sourceUnit? string The unit to check mana percentage for (defaults to "player")
--- @return number The current mana percentage of base mana (0-1 decimal range), or current/total if base cannot be calculated
--- @usage NAG:CurrentManaPercentBase() > 0.35
function NAG:CurrentManaPercentBase(sourceUnit)
    sourceUnit = sourceUnit or "player"
    if type(sourceUnit) ~= "string" then
        sourceUnit = "player"
    end

    -- Only works for player currently
    if sourceUnit ~= "player" then
        -- Fallback to regular mana percent for non-player units
        return self:CurrentManaPercent(sourceUnit)
    end

    local currentMana = UnitPower(sourceUnit, Enum.PowerType.Mana)
    if not currentMana or currentMana == 0 then
        return 0
    end

    -- Get class and level
    local _, class = UnitClass("player")
    local level = UnitLevel("player")

    if not class or not level or level < 1 then
        -- Fallback to regular mana percent if we can't get class/level
        return self:CurrentManaPercent(sourceUnit)
    end

    -- Calculate base mana
    local baseMana = GetBaseMana(class, level)
    if not baseMana or baseMana == 0 then
        -- Fallback to regular mana percent if base mana calculation fails
        return self:CurrentManaPercent(sourceUnit)
    end

    -- Calculate percentage: current mana / base mana
    local manaPerc = currentMana / baseMana
    return manaPerc
end


-- ============================ RAGE FUNCTIONS ============================

--- Get the current rage of the player
--- @return number The current rage of the player
--- @usage NAG:CurrentRage() >= 30
function NAG:CurrentRage()
    return UnitPower("player", Enum.PowerType.Rage)
end

--- Predict rage at GCD end
--- @return number The predicted rage when GCD is ready
--- @usage NAG:CurrentRageAtGCD() >= 30
function NAG:CurrentRageAtGCD()
    local gcdLeft = self:GCDTimeToReady() or 0
    local predictionTime = self:NextTime(gcdLeft)
    return self:PredictResourceValue(predictionTime, Enum.PowerType.Rage)
end

--- Get the maximum rage of the player
--- @return number The maximum rage of the player
--- @usage NAG:MaxRage() >= 100
function NAG:MaxRage()
    return UnitPowerMax("player", Enum.PowerType.Rage) or 100
end

-- ============================ STANCE FUNCTIONS ============================

--- Checks if the Warrior is currently in Berserker Stance.
--- @return boolean True if in Berserker Stance, false otherwise.
--- @usage NAG:IsWarriorInBerserkerStance()
function NAG:IsWarriorInBerserkerStance()
    if self.CLASS_FILENAME ~= "WARRIOR" then
        return false
    end
    local formId = GetWarriorStanceId()
    return formId == WARRIOR_STANCE_IDS.Berserker or formId == STANCE_TYPE.Berserker
end

--- Checks if the Warrior is currently in Battle Stance.
--- @return boolean True if in Battle Stance, false otherwise.
--- @usage NAG:IsWarriorInBattleStance()
function NAG:IsWarriorInBattleStance()
    if self.CLASS_FILENAME ~= "WARRIOR" then
        return false
    end
    local formId = GetWarriorStanceId()
    return formId == WARRIOR_STANCE_IDS.Battle or formId == STANCE_TYPE.Battle
end

--- Checks if the Warrior is in Berserker or Battle Stance.
--- @return boolean True if in Berserker or Battle Stance, false otherwise.
--- @usage NAG:IsWarriorInBerserkerOrBattleStance()
function NAG:IsWarriorInBerserkerOrBattleStance()
    if self.CLASS_FILENAME ~= "WARRIOR" then
        return false
    end
    local formId = GetWarriorStanceId()
    return formId == WARRIOR_STANCE_IDS.Berserker or formId == WARRIOR_STANCE_IDS.Battle or
        formId == STANCE_TYPE.Berserker or formId == STANCE_TYPE.Battle
end

-- ============================ ENERGY FUNCTIONS ============================

--- Get the current energy of the player
--- @return number The current energy of the player
--- @usage NAG:CurrentEnergy() >= 50
function NAG:CurrentEnergy()
    return UnitPower("player", Enum.PowerType.Energy)
end

--- Predict energy at GCD end (TBC uses discrete energy ticks)
--- @return number The predicted energy when GCD is ready
--- @usage NAG:CurrentEnergyAtGCD() <= 21
function NAG:CurrentEnergyAtGCD()
    local gcdLeft = self:GCDTimeToReady() or 0
    local predictionTime = self:NextTime(gcdLeft)
    return self:PredictResourceValue(predictionTime, Enum.PowerType.Energy)
end

--- Get the maximum energy of the player
--- @return number The maximum energy of the player
--- @usage NAG:MaxEnergy() >= 100
function NAG:MaxEnergy()
    return UnitPowerMax("player", Enum.PowerType.Energy) or 100
end

--- Get energy regeneration per second
--- @return number Energy regen rate per second
--- @usage NAG:EnergyRegenPerSecond() >= 10
function NAG:EnergyRegenPerSecond()
    -- Base regen rate is 10 energy per second
    local baseRegen = 10
    -- TODO: Add form-specific regen rates (e.g., Cat Form)
    return baseRegen
end

--- Gets time until target energy level is reached
--- @param targetEnergy number|table The target energy level to reach
--- @return number Time in seconds until target energy is reached
--- @usage NAG:EnergyTimeToTarget(100) <= 5
function NAG:EnergyTimeToTarget(targetEnergy)
    if not targetEnergy then
        self:Error("EnergyTimeToTarget: No targetEnergy provided")
        return 0
    end

    -- If targetEnergy is an APLValue table, extract the actual value
    if type(targetEnergy) == "table" and targetEnergy.GetFloat then
        targetEnergy = targetEnergy:GetFloat()
    elseif type(targetEnergy) ~= "number" then
        targetEnergy = 0
    end

    local currentEnergy = self:CurrentEnergy()

    -- If we already have enough energy, return 0
    if currentEnergy >= targetEnergy then
        return 0
    end

    -- Calculate time needed
    local energyNeeded = targetEnergy - currentEnergy
    local regenRate = self:EnergyRegenPerSecond()

    if regenRate <= 0 then
        return 999 -- Prevent division by zero
    end

    return energyNeeded / regenRate
end

-- ============================ FOCUS FUNCTIONS ============================

--- Get the current focus of the player
--- @return number The current focus of the player
--- @usage NAG:CurrentFocus() >= 50
function NAG:CurrentFocus()
    return UnitPower("player", Enum.PowerType.Focus)
end

--- Get the maximum focus of the player
--- @return number The maximum focus of the player
--- @usage NAG:MaxFocus() >= 100
function NAG:MaxFocus()
    return UnitPowerMax("player", Enum.PowerType.Focus) or 100
end

--- Get focus regeneration per second
--- @return number Focus regen rate per second
--- @usage NAG:FocusRegenPerSecond() >= 4
function NAG:FocusRegenPerSecond()
    -- TODO: Implement focus regen logic
    return 4
end

--- Gets time until target focus level is reached
--- @param targetFocus number The target focus level to reach
--- @return number Time in seconds until target focus is reached
--- @usage NAG:FocusTimeToTarget(100) <= 10
function NAG:FocusTimeToTarget(targetFocus)
    if not targetFocus then
        self:Error("FocusTimeToTarget: No targetFocus provided")
        return 0
    end

    local currentFocus = self:CurrentFocus()

    if currentFocus >= targetFocus then
        return 0
    end

    local focusNeeded = targetFocus - currentFocus
    local regenRate = self:FocusRegenPerSecond()

    if regenRate <= 0 then
        return 999 -- Prevent division by zero
    end

    return focusNeeded / regenRate
end

-- ============================ COMBO POINTS FUNCTIONS ============================

--- Get the current combo points of the player
--- @return number The current combo points of the player
--- @usage NAG:CurrentComboPoints() >= 3
function NAG:CurrentComboPoints()
    if self.CLASS_FILENAME == "WARLOCK" then
        return UnitPower("player", Enum.PowerType.SoulShards)
    else
        return GetComboPoints("player", "target")
    end
end

--- Get the maximum combo points of the player
--- @return number The maximum combo points of the player
--- @usage NAG:MaxComboPoints() >= 5
function NAG:MaxComboPoints()
    return UnitPowerMax("player", Enum.PowerType.ComboPoints) or 5
end

-- ============================ RUNIC POWER FUNCTIONS ============================

--- Get the current runic power of the player
--- @return number The current runic power of the player
--- @usage NAG:CurrentRunicPower() >= 30
function NAG:CurrentRunicPower()
    return UnitPower("player", Enum.PowerType.RunicPower)
end

--- Get the maximum runic power capacity of the player, accounting for talents
--- @return number The maximum runic power capacity
--- @usage NAG:MaxRunicPower() >= 100
function NAG:MaxRunicPower()
    if self.CLASS_FILENAME ~= "DEATHKNIGHT" then
        return 0
    end

    local baseMax = 100 -- Base runic power capacity
    local bonusFromTalents = 0

    -- Check for Runic Power Mastery talent ranks (increases max RP by 10/20/30)
    local runicPowerMasteryRank = StateManager:GetTalentRank(2031) -- Base talent ID
    if runicPowerMasteryRank > 0 then
        bonusFromTalents = runicPowerMasteryRank * 10              -- 10 per rank
    end

    return baseMax + bonusFromTalents
end

-- ============================ GENERIC RESOURCE FUNCTIONS ============================

-- Helper function to get the secondary resource type and modifier preference for the current spec
-- Returns: powerType, useUnmodified (boolean)
local function GetSecondaryResourceType()
    local class = NAG.CLASS_FILENAME
    local spec = SpecCompat and SpecCompat:GetCurrentSpecIndex()
    if not spec then return nil, false end

    -- Map specs to their secondary resource types and modifier preferences
    if class == "WARLOCK" then
        if spec == 1 then     -- Affliction
            return Enum.PowerType.SoulShards, false
        elseif spec == 2 then -- Demonology
            return Enum.PowerType.DemonicFury, false
        elseif spec == 3 then -- Destruction (needs unmodified for raw power values like 36)
            return Enum.PowerType.BurningEmbers, true
        end
    elseif class == "PALADIN" then
        return Enum.PowerType.HolyPower, false
    elseif class == "PRIEST" and spec == 3 then -- Shadow
        return Enum.PowerType.ShadowOrbs, false
    elseif class == "MAGE" and spec == 1 then   -- Arcane
        return Enum.PowerType.ArcaneCharges, false
    elseif class == "DRUID" and spec == 1 then  -- Balance
        return Enum.PowerType.Balance, false
    end
    return nil, false
end

--- Gets the current amount of the spec's secondary resource (Soul Shards, Demonic Fury, Holy Power, etc.)
--- Uses spec-specific logic to determine whether to return modified or unmodified values
--- @return number The current amount of the spec's secondary resource
--- @usage NAG:CurrentGenericResource() >= 3
function NAG:CurrentGenericResource()
    local resourceType, useUnmodified = GetSecondaryResourceType()
    if not resourceType then return 0 end

    if useUnmodified then
        return UnitPower("player", resourceType, true) or 0
    else
        return UnitPower("player", resourceType) or 0
    end
end

--- Gets maximum chi
--- @return number Maximum chi value
function NAG:MonkMaxChi()
    return UnitPowerMax("player", Enum.PowerType.Chi) or 6
end

--- Gets current chi
--- @return number Current chi value
function NAG:MonkCurrentChi()
    return UnitPower("player", Enum.PowerType.Chi) or 0
end

--- Get the current soul shards of the player
--- @return number The current soul shards of the player
--- @usage NAG:CurrentSoulShards() >= 3
function NAG:CurrentSoulShards()
    return UnitPower("player", Enum.PowerType.SoulShards)
end

--- Get the current lunar energy of the player
--- @return number The current lunar energy of the player
--- @usage NAG:CurrentLunarEnergy() >= 50
function NAG:CurrentLunarEnergy()
    local power = UnitPower("player", Enum.PowerType.Balance or 8)
    return power < 0 and -power or 0
end

--- Get the current solar energy of the player
--- @return number The current solar energy of the player
--- @usage NAG:CurrentSolarEnergy() >= 50
function NAG:CurrentSolarEnergy()
    local power = UnitPower("player", Enum.PowerType.Balance or 8)
    return power > 0 and power or 0
end

--- Get the current eclipse energy of the player (raw balance power value)
--- Returns negative values for lunar energy, positive values for solar energy
--- @return number The current eclipse energy of the player (negative = lunar, positive = solar)
--- @usage NAG:CurrentEclipseEnergy() >= -40 and NAG:CurrentEclipseEnergy() <= -60
-- #DEPRECATED: Use CurrentGenericResource instead
--[[function NAG:CurrentEclipseEnergy()
    return UnitPower("player", Enum.PowerType.Balance or 8) or 0
end
--]]

--- Get the current holy power of the player
--- @return number The current holy power of the player
--- @usage NAG:CurrentHolyPower() >= 3
function NAG:CurrentHolyPower()
    return UnitPower("player", Enum.PowerType.HolyPower)
end

--- Get the current alternate power of the player
--- @return number The current alternate power of the player
--- @usage NAG:CurrentAlternate() >= 50
function NAG:CurrentAlternate()
    return UnitPower("player", Enum.PowerType.Alternate)
end

--- Get the current maelstrom of the player
--- @return number The current maelstrom of the player
--- @usage NAG:CurrentMaelstrom() >= 50
function NAG:CurrentMaelstrom()
    return UnitPower("player", Enum.PowerType.Maelstrom)
end

--- Gets the current amount of Demonic Fury
--- @return number The current amount of Demonic Fury
--- @usage NAG:CurrentDemonicFury() >= 50
function NAG:CurrentDemonicFury()
    return UnitPower("player", Enum.PowerType.DemonicFury) or 0
end

--- Gets the current number of Arcane Charges
--- @return number The current number of Arcane Charges
--- @usage NAG:CurrentArcaneCharges() >= 3
function NAG:CurrentArcaneCharges()
    return UnitPower("player", Enum.PowerType.ArcaneCharges) or 0
end

--- Gets the current number of Burning Embers
--- @return number The current number of Burning Embers
--- @usage NAG:CurrentBurningEmbers() >= 2
function NAG:CurrentBurningEmbers()
    return UnitPower("player", Enum.PowerType.BurningEmbers) or 0
end

--- Calculates the time until the next energy tick for Rogues and Feral Druids
--- @return number Time in seconds until the next energy tick
--- @usage NAG:TimeToEnergyTick() <= 1.5
function NAG:TimeToEnergyTick()
    local powerType = UnitPowerType("player")
    if powerType ~= Enum.PowerType.Energy then
        return 0
    end

    local tickRate = Version:IsTBC() and 2.02 or 2.0
    local currentTime = GetTime()
    local timeSinceLastTick = currentTime % tickRate
    local timeToNextTick = tickRate - timeSinceLastTick

    return timeToNextTick
end

--- Calculates the time until the next energy tick for Rogues and Feral Druids
--- @return number Time in seconds until the next energy tick
--- @usage NAG:TimeToEnergyTick() <= 1.5
function NAG:TimeToEnergyTickWithGCD()
    local powerType = UnitPowerType("player")
    if powerType ~= Enum.PowerType.Energy then
        return 0
    end

    local tickRate = Version:IsTBC() and 2.02 or 2.0
    local currentTime = GetTime()
    local timeSinceLastTick = currentTime % tickRate
    local timeToNextTick = tickRate - timeSinceLastTick

    return timeToNextTick - self:GCDTimeToReady()
end

--- Checks if the player's current energy is less than or equal to the specified threshold
--- @param threshold number The energy threshold to check against
--- @return boolean True if the player's current energy is less than or equal to the threshold, false otherwise
--- @usage NAG:EnergyThreshold(35)
function NAG:EnergyThreshold(threshold)
    return self:CurrentEnergy() <= threshold
end

--- Checks if the player has enough Combo Points for a spell
--- NOTE: Combo point finishers CANNOT use HasResource() because GetSpellPowerCost()
---       does not report combo point costs. Finishers are variable-consumption spells
---       that consume 1-5 CP based on what you have, and the minimum CP requirement
---       is a cast condition (not a power cost). This hardcoded list is NECESSARY.
--- @param spellId number The ID of the spell to check
--- @return boolean True if the player has enough Combo Points, false otherwise
--- @usage NAG:HasComboPoints(5171)
--- @local This function is used to check if the player has enough Combo Points for a spell
function NAG:HasComboPoints(spellId)
    -- Handle special case for rogue finishers due to Cata bug
    if self.CLASS_FILENAME == "ROGUE" and (
            spellId == 5171     --Slice and Dice
            or spellId == 1943  --Rupture
            or spellId == 32645 --Envenom
            or spellId == 73651 --Recuperate
            or spellId == 408   --Kidney Shot
            or spellId == 8647  --Expose Armor
            or spellId == 2098  --Eviscerate
            or spellId == 26679 --Deadly Throw
            or spellId == 121411 --Crimson Tempest
        ) then
        -- Special case for Slice and Dice and Crimson Tempest - can use combo points from any target
        if spellId == 5171 or spellId == 121411 then
            return UnitPower("player", Enum.PowerType.ComboPoints) >= 1
        end
        return self:CurrentComboPoints() >= 1
    end
    if self.CLASS_FILENAME == "DRUID" and (
            spellId == 52610    --SAVAGE ROAR
            or spellId == 22568 --Ferocious Bite
            or spellId == 22570 --Maim
            or spellId == 1079  --Rip
        ) then
        return self:CurrentComboPoints() >= 1
    end

    return self:HasResource(spellId, Enum.PowerType.ComboPoints)
end

-- ============================ ROGUE SLICE AND DICE HELPERS ============================
local ROGUE_SND_TALENT_ID = 1827 -- Improved Slice and Dice (TBC talent ID)
local ROGUE_SND_SET_BONUS_SPELL_ID = 37167 -- Increased Slice and Dice Duration (Netherblade 2pc)
local ROGUE_SND_BASE_DURATIONS = {
    [1] = 9,
    [2] = 12,
    [3] = 15,
    [4] = 18,
    [5] = 21
}

--- Gets the full Slice and Dice duration in seconds for the given combo points.
--- @param comboPoints? number Optional combo point override (defaults to current combo points)
--- @return number durationSeconds
function NAG:RogueSliceAndDiceFullDuration(comboPoints)
    comboPoints = max(0, min(5, comboPoints or self:CurrentComboPoints()))
    if comboPoints == 0 then
        return 0
    end

    local baseDuration = ROGUE_SND_BASE_DURATIONS[comboPoints] or 0
    if baseDuration <= 0 then
        return 0
    end

    local improvedRank = StateManager:GetTalentRank(ROGUE_SND_TALENT_ID) or 0
    local durationMultiplier = 1 + (0.15 * improvedRank)
    local durationBonus = (self.IsKnownTierset and self:IsKnownTierset(ROGUE_SND_SET_BONUS_SPELL_ID)) and 3 or 0

    return (baseDuration + durationBonus) * durationMultiplier
end

--- Determines if we should avoid holding combo points for Slice and Dice.
--- Matches TBC-sim: refresh SnD at <=1s, pool when SnD remaining >2s (use finishers instead).
--- @param comboPoints? number Optional combo point override (defaults to current combo points)
--- @return boolean
function NAG:RogueShouldAvoidSnDHolding(comboPoints)
    local timeToDeath = self:RemainingTime()
    -- When TTD is unknown, prefer spending on finishers rather than holding for SnD
    if not timeToDeath or timeToDeath >= 7777 then
        return true
    end

    comboPoints = max(0, min(5, comboPoints or self:CurrentComboPoints()))
    if comboPoints == 0 then
        return false
    end

    local sndRemaining = max(0, self:AuraRemainingTimeResolved(5171, "player") or 0)
    -- Sim pools when SnD remaining >2s: don't hold for SnD, use finishers in this window
    if sndRemaining > 2 then
        return true
    end

    local sndFullDuration = self:RogueSliceAndDiceFullDuration(comboPoints)
    if sndFullDuration <= 0 then
        return false
    end

    -- Avoid holding/refreshing SnD when the target will not live long enough
    -- to realize most of the combined remaining + refreshed duration.
    return timeToDeath < ((sndFullDuration + sndRemaining) * 0.8)
end

--- Checks if the player has enough Chi for a spell
--- @param spellId number The ID of the spell to check
--- @param tolerance number|nil Optional tolerance in seconds for resource prediction
--- @return boolean True if the player has enough Chi, false otherwise
--- @usage NAG:HasChi(100787)
--- @local This function is used to check if the player has enough Chi for a spell
function NAG:HasChi(spellId, tolerance)
    return self:HasResource(spellId, Enum.PowerType.Chi, tolerance)
end

--- Checks if the player has enough Runic Power for a spell
--- @param spellId number The ID of the spell to check
--- @param tolerance number|nil Optional tolerance in seconds for resource prediction
--- @return boolean True if the player has enough Runic Power, false otherwise
--- @usage NAG:HasRunicPower(77575)
--- @local This function is used to check if the player has enough Runic Power for a spell
function NAG:HasRunicPower(spellId, tolerance)
    return self:HasResource(spellId, Enum.PowerType.RunicPower, tolerance)
end

--- Checks if the player has enough Rage for a spell
--- @param spellId number The ID of the spell to check
--- @param tolerance number|nil Optional tolerance in seconds for resource prediction
--- @return boolean True if the player has enough Rage, false otherwise
--- @usage NAG:HasRage(100)
--- @local This function is used to check if the player has enough Rage for a spell
function NAG:HasRage(spellId, tolerance)
    return self:HasResource(spellId, Enum.PowerType.Rage, tolerance)
end

--- Checks if the player has enough Mana for a spell
--- @param spellId number The ID of the spell to check
--- @param tolerance number|nil Optional tolerance in seconds for resource prediction
--- @return boolean True if the player has enough Mana, false otherwise
--- @usage NAG:HasMana(73643)
--- @local This function is used to check if the player has enough Mana for a spell
function NAG:HasMana(spellId, tolerance)
    return self:HasResource(spellId, Enum.PowerType.Mana, tolerance)
end

--- Checks if the player has enough Energy for a spell
--- @param spellId number The ID of the spell to check
--- @param tolerance number|nil Optional tolerance in seconds for resource prediction
--- @return boolean True if the player has enough Energy, false otherwise
--- @usage NAG:HasEnergy(1752)
--- @local This function is used to check if the player has enough Energy for a spell
function NAG:HasEnergy(spellId, tolerance)
    return self:HasResource(spellId, Enum.PowerType.Energy, tolerance)
end

--- Checks if the player has enough Soul Shards for a spell
--- @param spellId number The ID of the spell to check
--- @param tolerance number|nil Optional tolerance in seconds for resource prediction
--- @return boolean True if the player has enough Soul Shards, false otherwise
--- @usage NAG:HasSoulShards(30108)
--- @local This function is used to check if the player has enough Soul Shards for a spell
function NAG:HasSoulShards(spellId, tolerance)
    return self:HasResource(spellId, Enum.PowerType.SoulShards, tolerance)
end

--- Checks if the player has enough Lunar Power for a spell
--- @param spellId number The ID of the spell to check
--- @param tolerance number|nil Optional tolerance in seconds for resource prediction
--- @return boolean True if the player has enough Lunar Power, false otherwise
--- @usage NAG:HasLunarPower(8921)
--- @local This function is used to check if the player has enough Lunar Power for a spell
function NAG:HasLunarPower(spellId, tolerance)
    return self:HasResource(spellId, Enum.PowerType.LunarPower, tolerance)
end

--- Checks if the player has enough Holy Power for a spell
--- @param spellId number The ID of the spell to check
--- @param tolerance number|nil Optional tolerance in seconds for resource prediction
--- @return boolean True if the player has enough Holy Power, false otherwise
--- @usage NAG:HasHolyPower(85256)
--- @local This function is used to check if the player has enough Holy Power for a spell
function NAG:HasHolyPower(spellId, tolerance)
    return self:HasResource(spellId, Enum.PowerType.HolyPower, tolerance)
end

--- Checks if the player has enough Burning Embers for a spell
--- @param spellId number The ID of the spell to check
--- @param tolerance number|nil Optional tolerance in seconds for resource prediction
--- @return boolean True if the player has enough Burning Embers, false otherwise
--- @usage NAG:HasBurningEmber(29722)
--- @local This function is used to check if the player has enough Burning Embers for a spell
function NAG:HasBurningEmber(spellId, tolerance)
    return self:HasResource(spellId, Enum.PowerType.BurningEmbers, tolerance)
end

--- Checks if the player has enough Focus for a spell
--- @param spellId number The ID of the spell to check
--- @param tolerance number|nil Optional tolerance in seconds for resource prediction
--- @return boolean True if the player has enough Focus, false otherwise
--- @usage NAG:HasFocus(34026)
--- @local This function is used to check if the player has enough Focus for a spell
function NAG:HasFocus(spellId, tolerance)
    return self:HasResource(spellId, Enum.PowerType.Focus, tolerance)
end

--- Checks if the player has enough of the specified resource for a spell
--- @param spellId number The ID of the spell
--- @param powerType Enum.PowerType The type of resource to check
--- @param tolerance number|nil Optional tolerance in seconds for resource prediction
--- @return boolean True if the player has enough of the specified resource, false otherwise
--- @usage NAG:HasResource(73643, Enum.PowerType.Mana)
--- @local This function is used to check if the player has enough of the specified resource for a spell
function NAG:HasResource(spellId, powerType, tolerance)
    if not spellId or type(spellId) ~= "number" then
        self:Error("HasResource: Invalid spellId provided")
        return false
    end
    if not powerType then
        self:Error("HasResource: No powerType provided")
        return false
    end

    -- Use the generalized glyph-aware cost function
    -- GetModifiedSpellPowerCost always returns a table (empty if no cost)
    local costTable = self:GetModifiedSpellPowerCost(spellId)
    -- Defensive check (should never trigger, but safety first)
    if type(costTable) ~= "table" then
        self:Warn(format("HasResource: Invalid costTable type for spellId %d (got %s)", spellId, type(costTable)))
        return false
    end

    local cost = nil
    -- If costTable is empty, cost remains nil (spell has no cost)
    for _, v in ipairs(costTable) do
        if v.type == powerType then
            local required = v.minCost or v.cost
            cost = max(required, 0) -- Negative is returned for spells that generate power
            break
        end
    end

    -- Learned Prediction override (when available and enabled)
    local LPP = ns.LearnedPredictionProvider
    if LPP and LPP.GetExpectedCost then
        local learned = LPP:GetExpectedCost(spellId)
        if type(learned) == "number" and learned >= 0 then
            cost = max(learned, 0)
        end
    end

    -- Use PredictResourceAfterSpell to account for resource generation from the spell
    local predictionTime = NAG:NextTime()
    if tolerance and tolerance > 0 then
        predictionTime = NAG:NextTime(tolerance)
    end
    local predictedResource = self:PredictResourceAfterSpell(predictionTime, powerType, spellId)

    -- Add RP prediction from auto attacks if tolerance is provided and we're a Death Knight
    if tolerance and tolerance > 0 and powerType == Enum.PowerType.RunicPower and self.CLASS_FILENAME == "DEATHKNIGHT" then
        local rpFromAutoAttacks = self:PredictRunicPowerFromAutoAttacks(tolerance)
        predictedResource = predictedResource + rpFromAutoAttacks

        -- Cap at max RP (130 for DK in Cataclysm)
        local maxRP = UnitPowerMax("player", Enum.PowerType.RunicPower) or 130
        predictedResource = min(predictedResource, maxRP)
    end

    -- Account for resource generation when calculating net cost
    -- If the spell generates resources, reduce the effective cost
    local netCost = cost or 0
    if LPP and LPP.GetExpectedGeneration then
        -- Use lookup table instead of creating strings every call
        local resourceTypeName = RESOURCE_TYPE_NAMES[powerType]

        if resourceTypeName then
            local learnedGeneration = LPP:GetExpectedGeneration(spellId, resourceTypeName)
            if type(learnedGeneration) == "number" and learnedGeneration > 0 then
                -- Reduce net cost by generation amount
                netCost = max(0, netCost - learnedGeneration)
                if self.debug then
                    self:Debug("HasResource: Spell %d generates %d %s, net cost: %d (original: %d)",
                        spellId, learnedGeneration, resourceTypeName, netCost, cost or 0)
                end
            end
        end
    end

    if self.CLASS_FILENAME == "ROGUE" and powerType == Enum.PowerType.Energy and spellId ~= ROGUE_KICK_SPELL_ID then
        local classModule = self.GetClassModule and self:GetClassModule() or nil
        local reserveEnabled = classModule and classModule.GetSetting
            and classModule:GetSetting("char", "saveEnergyForKicks", false) == true
        local remainingTime = self:RemainingTime()
        local allowReserve = not remainingTime or remainingTime >= 5
        if reserveEnabled and allowReserve then
            netCost = netCost + ROGUE_KICK_ENERGY_RESERVE
        end
    end

    local hasEnough = not netCost or netCost <= predictedResource

    return hasEnough
end

-- Generalized glyph-based spell cost override table
-- Table: [spellId] = { [glyphId] = { [powerType] = { cost = X, minCost = Y } } }
local glyphSpellOverrides = {
    --   [77575] = { [59332] = { [Enum.PowerType.RunicPower] = { cost = 30, minCost = 30 } } }, -- Outbreak
}

--- Returns the spell power cost table for a spell, with glyph overrides applied if present
--- @param spellId number The spell ID
--- @return table The cost table (like GetSpellPowerCost), with overrides applied
--- @usage local costTable = NAG:GetModifiedSpellPowerCost(77575)
--- @local This function is used to get the spell power cost table for a spell, with glyph overrides applied if present
function NAG:GetModifiedSpellPowerCost(spellId)
    local baseCostTable = GetSpellPowerCost(spellId)
    -- Normalize to always return a table (empty table if nil or not a table)
    if not baseCostTable or type(baseCostTable) ~= "table" then
        baseCostTable = {}
    end

    local overrides = nil

    -- Check for glyph override
    if glyphSpellOverrides[spellId] then
        for glyphId, mod in pairs(glyphSpellOverrides[spellId]) do
            if self:HasGlyph(glyphId) then
                overrides = mod
                break
            end
        end
    end

    if not overrides then
        return baseCostTable
    end

    -- Apply overrides to the cost table, preserving all fields
    local modifiedCostTable = {}
    for _, v in ipairs(baseCostTable) do
        local entry = {}
        for k, val in pairs(v) do
            entry[k] = val
        end
        local override = overrides[v.type]
        if override then
            if type(override) == "table" then
                if override.cost ~= nil then entry.cost = override.cost end
                if override.minCost ~= nil then entry.minCost = override.minCost end
            else
                entry.cost = override -- backward compatibility for numeric override
            end
        end
        tinsert(modifiedCostTable, entry)
    end
    -- If the override adds a new resource type not in the base table, add it
    for powerType, override in pairs(overrides) do
        if type(powerType) == "number" then
            local found = false
            for _, v in ipairs(modifiedCostTable) do
                if v.type == powerType then
                    found = true
                    break
                end
            end
            if not found then
                local entry = { type = powerType }
                if type(override) == "table" then
                    if override.cost ~= nil then entry.cost = override.cost end
                    if override.minCost ~= nil then entry.minCost = override.minCost end
                else
                    entry.cost = override
                end
                table.insert(modifiedCostTable, entry)
            end
        end
    end

    return modifiedCostTable
end

--- Determines the resource type of the player
--- @return Enum.PowerType|nil The type of resource the player uses
--- @usage local resourceType = NAG:GetResourceType()
--- @local This function is used to determine the resource type of the player
function NAG:GetResourceType()
    local powerType = UnitPowerType("player")
    if not powerType then
        self:Error("GetResourceType: Failed to get player power type")
        return nil
    end
    return powerType
end

--- Calculates the current resource value of the player
--- @param powerType? number The type of power to check or self:GetResourceType()
--- @return number The current amount of the specified resource
--- @usage NAG:GetCurrentResource() >= 50
--- @local This function is used to calculate the current resource value of the player
function NAG:GetCurrentResource(powerType)
    local resourceType = powerType or self:GetResourceType()
    if not resourceType then
        self:Error("GetCurrentResource: Invalid resourceType")
        return 0
    end
    return UnitPower("player", resourceType)
end

--- Calculates the current resource value of the player as a percentage
--- @param powerType? number The type of power to check
--- @return number The current percentage of the specified resource (0-1 decimal range)
--- @usage NAG:GetCurrentResourcePercent() >= 0.5
--- @local This function is used to calculate the current resource value of the player as a percentage
function NAG:GetCurrentResourcePercent(powerType)
    local resourceType = powerType or self:GetResourceType()
    if not resourceType then
        self:Error("GetCurrentResourcePercent: Invalid resourceType")
        return 0
    end
    local currentResource = UnitPower("player", resourceType)
    local maxResource = UnitPowerMax("player", resourceType)
    if not maxResource or maxResource == 0 then
        return 0
    end
    return currentResource / maxResource
end

--- Gets the secondary resource type for the current specialization
--- @return Enum.PowerType|nil The secondary resource type, or nil if none
--- @usage local resourceType = NAG:GetSecondaryResourceType()
--- @local This function is used to get the secondary resource type for the current specialization
function NAG:GetSecondaryResourceType()
    -- TODO: Implement secondary resource type detection
    return nil
end

--- Gets the current amount of the secondary resource
--- @return number The current amount of the secondary resource
--- @usage NAG:GetSecondaryResource() >= 3
--- @local This function is used to get the current amount of the secondary resource
function NAG:GetSecondaryResource()
    -- TODO: Implement secondary resource retrieval
    return 0
end

--- Gets the current percentage of the secondary resource
--- @return number The current percentage of the secondary resource (0-100)
--- @usage NAG:GetSecondaryResourcePercent() >= 50
--- @local This function is used to get the current percentage of the secondary resource
function NAG:GetSecondaryResourcePercent()
    -- TODO: Implement secondary resource percentage calculation
    return 0
end

--- Predicts the resource value after a certain period
--- @param time number The time in seconds to predict the resource value for
--- @param resourceType number The type of resource to predict (e.g., Mana, Energy, Rage)
--- @return number The predicted resource value after the specified time
--- @usage NAG:PredictResourceValue(5, Enum.PowerType.Mana) >= 1000
--- @local This function is used to predict the resource value after a certain period
function NAG:PredictResourceValue(time, resourceType)
    if not time or type(time) ~= "number" then
        self:Error("PredictResourceValue: Invalid time provided")
        return 0
    end
    if not resourceType then
        self:Error("PredictResourceValue: No resourceType provided")
        return 0
    end

    local nextTime = time - NAG:NextTime() -- RAKIZI: Changed 9/9/25 from GetTime() to NAG:NextTime()
    local currentResource = self:GetCurrentResource(resourceType)
    local regenRate = 0

    if Version:IsRetail() then
        if resourceType == Enum.PowerType.Rage then
            regenRate = self:GetRageRegen()
        else
            regenRate = GetPowerRegen()
        end
    else
        if resourceType == 1 then     -- Rage
            regenRate = self:GetRageRegen()
        elseif resourceType == 3 then -- Energy
            if Version:IsTBC() then
                local tickRate = 2.02
                local energyPerTick = 20.2
                if self.CLASS_FILENAME == "ROGUE" and self:AuraIsActiveResolved(13750) then -- Adrenaline Rush
                    energyPerTick = energyPerTick * 2
                end
                local timeToNextTick = self:TimeToEnergyTick()
                if nextTime >= timeToNextTick then
                    local ticks = 1 + floor((nextTime - timeToNextTick) / tickRate)
                    local predictedResource = currentResource + (ticks * energyPerTick)
                    local maxResource = UnitPowerMax("player", resourceType)
                    predictedResource = min(predictedResource, maxResource)
                    return max(predictedResource, 0)
                end
                return currentResource
            end
            regenRate = self:GetEnergyRegen()
        elseif resourceType == 2 then -- Focus
            regenRate = self:GetFocusRegen()
        elseif resourceType == 6 then -- Runic Power
            regenRate = self:GetRunicPowerRegen()
        elseif resourceType == 0 then -- Mana
            regenRate = self:GetManaRegen()
        end
    end

    local predictedResource = currentResource + (regenRate * nextTime)

    if resourceType == (Version:IsRetail() and Enum.PowerType.Mana or 0) then
        local hasteFactor = self:GetHasteFactor()
        predictedResource = predictedResource * hasteFactor
    end

    -- Calculate predicted resource

    -- Cap at max resource
    local maxResource = UnitPowerMax("player", resourceType)
    predictedResource = min(predictedResource, maxResource)

    return max(predictedResource, 0)
end

--- Predicts the resource value as a percentage after a certain period
--- @param time number The time in seconds to predict the resource value for
--- @param resourceType number The type of resource to predict (e.g., Mana, Energy, Rage)
--- @return number The predicted resource percentage after the specified time (0-1 decimal range)
--- @usage NAG:PredictResourceValuePercent(5, Enum.PowerType.Mana) >= 0.5
--- @local This function is used to predict the resource value as a percentage after a certain period
function NAG:PredictResourceValuePercent(time, resourceType)
    if not time or type(time) ~= "number" then
        self:Error("PredictResourceValuePercent: Invalid time provided")
        return 0
    end
    if not resourceType then
        self:Error("PredictResourceValuePercent: No resourceType provided")
        return 0
    end

    local predictedResource = self:PredictResourceValue(time, resourceType)
    local maxResource = UnitPowerMax("player", resourceType)

    if not maxResource or maxResource == 0 then
        return 0
    end

    return predictedResource / maxResource
end

--- Predicts the resource value after casting a spell, accounting for both cost and generation
--- @local
--- @param time number The time in seconds to predict the resource value for
--- @param resourceType number The type of resource to predict (e.g., Mana, Energy, Rage)
--- @param spellId number|nil Optional spell ID to account for resource generation from the spell
--- @return number The predicted resource value after casting the spell
--- @usage NAG:PredictResourceAfterSpell(5, Enum.PowerType.Mana, 12345) >= 1000
function NAG:PredictResourceAfterSpell(time, resourceType, spellId)
    if not time or type(time) ~= "number" then
        self:Error("PredictResourceAfterSpell: Invalid time provided")
        return 0
    end
    if not resourceType then
        self:Error("PredictResourceAfterSpell: No resourceType provided")
        return 0
    end

    -- Start with base prediction
    local predictedResource = self:PredictResourceValue(time, resourceType)

    -- If spellId provided, account for learned resource generation
    if spellId then
        local LPP = ns.LearnedPredictionProvider
        if LPP and LPP.GetExpectedGeneration then
            -- Get resource type name for lookup
            local resourceTypeName = nil
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
                -- Classic resource types
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

            if resourceTypeName then
                local learnedGeneration = LPP:GetExpectedGeneration(spellId, resourceTypeName)
                if type(learnedGeneration) == "number" and learnedGeneration > 0 then
                    predictedResource = predictedResource + learnedGeneration
                    if self.debug then
                        self:Debug("PredictResourceAfterSpell: Adding learned generation %d for spell %d, resource %s",
                            learnedGeneration, spellId, resourceTypeName)
                    end
                end
            end
        end
    end

    -- Cap at max resource
    local maxResource = UnitPowerMax("player", resourceType)
    predictedResource = min(predictedResource, maxResource)

    return max(predictedResource, 0)
end

--- Predicts the resource value after casting a sequence of spells
--- @local
--- @param time number The time in seconds to predict the resource value for
--- @param resourceType number The type of resource to predict (e.g., Mana, Energy, Rage)
--- @param spellSequence table Array of spell IDs to cast in sequence
--- @return number The predicted resource value after casting the sequence
--- @usage NAG:PredictResourceAfterSequence(5, Enum.PowerType.Mana, {12345, 67890}) >= 1000
function NAG:PredictResourceAfterSequence(time, resourceType, spellSequence)
    if not time or type(time) ~= "number" then
        self:Error("PredictResourceAfterSequence: Invalid time provided")
        return 0
    end
    if not resourceType then
        self:Error("PredictResourceAfterSequence: No resourceType provided")
        return 0
    end
    if not spellSequence or type(spellSequence) ~= "table" or #spellSequence == 0 then
        -- Fallback to regular prediction if no sequence
        return self:PredictResourceValue(time, resourceType)
    end

    local LPP = ns.LearnedPredictionProvider
    if LPP and LPP.PredictResourceAfterSequence then
        local context = LPP:GetCurrentContext()
        return LPP:PredictResourceAfterSequence(time, resourceType, spellSequence, context)
    end

    -- Fallback to regular prediction if LPP not available
    return self:PredictResourceValue(time, resourceType)
end

--- Gets the runic power regeneration rate for Death Knights
--- @return number The runic power regeneration rate per second
--- @usage NAG:GetRunicPowerRegen() >= 10
--- @local This function is used to get the runic power regeneration rate for Death Knights
function NAG:GetRunicPowerRegen()
    return 10 -- Base Runic Power regeneration rate for Death Knights in Cataclysm
end

--- Predicts Runic Power generation from auto attacks over a given time period
--- Each auto attack grants 10 RP. Function calculates how many auto attacks will happen
--- @param timeWindow number The time window in seconds to predict RP generation for
--- @return number The predicted RP from auto attacks in the time window
--- @usage NAG:PredictRunicPowerFromAutoAttacks(5) >= 20
--- @local This function is used to predict Runic Power generation from auto attacks over a given time period
function NAG:PredictRunicPowerFromAutoAttacks(timeWindow)
    if not timeWindow or timeWindow <= 0 then
        return 0
    end

    -- Only apply for Death Knights
    if self.CLASS_FILENAME ~= "DEATHKNIGHT" then
        return 0
    end

    -- Safety checks - don't predict if not in combat or no weapon equipped
    if not UnitAffectingCombat("player") then
        return 0
    end

    -- Get weapon speed using UnitAttackSpeed
    local weaponSpeed = UnitAttackSpeed("player")
    if not weaponSpeed or weaponSpeed <= 0 then
        return 0 -- No weapon or invalid weapon speed
    end

    -- Get time to next auto attack using NAG:AutoTimeToNext function from MiscHandlers
    local timeToNextSwing = 0
    if NAG.AutoTimeToNext then
        timeToNextSwing = NAG:AutoTimeToNext() or 0
    end
    if timeToNextSwing < 0 then
        timeToNextSwing = 0 -- Sanity check
    end

    local rpFromAutoAttacks = 0
    local remainingTime = timeWindow

    -- If we have time until next swing
    if timeToNextSwing > 0 and timeToNextSwing <= remainingTime then
        -- First swing will happen
        rpFromAutoAttacks = rpFromAutoAttacks + 10
        remainingTime = remainingTime - timeToNextSwing

        -- Calculate additional swings after the first one
        local additionalSwings = floor(remainingTime / weaponSpeed)
        rpFromAutoAttacks = rpFromAutoAttacks + (additionalSwings * 10)
    elseif timeToNextSwing <= 0 then
        -- Next swing is happening now or very soon
        rpFromAutoAttacks = rpFromAutoAttacks + 10
        remainingTime = remainingTime - 0.1 -- Small buffer

        -- Calculate additional swings
        local additionalSwings = floor(remainingTime / weaponSpeed)
        rpFromAutoAttacks = rpFromAutoAttacks + (additionalSwings * 10)
    end

    return rpFromAutoAttacks
end

--- Retrieves the haste factor for the player
--- @return number The current haste multiplier (1 + haste percentage)
--- @usage NAG:GetHasteFactor() >= 1.0
--- @local This function is used to get the haste factor for the player
function NAG:GetHasteFactor()
    local haste = GetMeleeHaste()
    if not haste then
        haste = UnitSpellHaste("player")
        if not haste then
            self:Warn("GetHasteFactor: Failed to get haste value")
            return 1
        end
    end
    return 1 + (haste / 100)
end

--- Retrieves the rage regeneration rate for the player
--- @return number The rage regeneration rate per second
--- @usage NAG:GetRageRegen() >= 0
--- @local This function is used to get the rage regeneration rate for the player
function NAG:GetRageRegen()
    local baseRegen = 0 -- Default is no passive rage regeneration
    local stance = StateManager:GetShapeshiftFormID()

    -- Berserker Stance or specific abilities may affect base regen
    if stance == 18 then     -- Berserker Stance
        baseRegen = 3 / 3    -- Full rage generation in this stance
    elseif stance == 17 then -- Defensive Stance
        baseRegen = 1 / 3    -- Lower rage generation in Defensive Stance
    end

    return baseRegen
end

--- Retrieves the energy regeneration rate for the player
--- @return number The energy regeneration rate per second
--- @usage NAG:GetEnergyRegen() >= 10
--- @local This function is used to get the energy regeneration rate for the player
function NAG:GetEnergyRegen()
    -- Energy regenerates at a fixed rate of 10 per second in Cataclysm
    local baseRegen = 10

    -- Check for talents/buffs that might modify regen rate
    if Version:IsCata() and self.CLASS_FILENAME == "ROGUE" then
        -- Vitality increases energy regeneration by 25%
        if self:HasTalent(31123) then -- Vitality talent ID
            baseRegen = baseRegen * 1.25
        end
    end

    return baseRegen
end

--- Retrieves the focus regeneration rate for the player
--- @return number The focus regeneration rate per second
--- @usage NAG:GetFocusRegen() >= 4
--- @local This function is used to get the focus regeneration rate for the player
function NAG:GetFocusRegen()
    -- Base focus regeneration is 4 per second in Cataclysm
    local baseRegen = 4

    -- Check for talents that affect focus regeneration
    if self:HasTalent(34453) then -- Go for the Throat talent
        baseRegen = baseRegen * 1.25
    end

    return baseRegen
end

--- Retrieves the mana regeneration rate for the player
--- @return number The mana regeneration rate per second
--- @usage NAG:GetManaRegen() >= 50
--- @local This function is used to get the mana regeneration rate for the player
function NAG:GetManaRegen()
    -- Spirit-based mana regeneration formula for Cataclysm
    local spirit = UnitStat("player", 5)
    local intellect = UnitStat("player", 4)
    local level = UnitLevel("player")

    -- Base regen coefficient varies by class
    local baseCoeff = ({
        MAGE = 0.003345,
        PRIEST = 0.003345,
        DRUID = 0.003345,
        SHAMAN = 0.003345,
        PALADIN = 0.003345,
        WARLOCK = 0.003345,
    })[self.CLASS_FILENAME] or 0.003345

    -- Calculate base regen
    local baseRegen = (0.001 + spirit * math.sqrt(intellect) * baseCoeff) * 5

    -- In combat regen is reduced
    if UnitAffectingCombat("player") then
        -- Meditation talent for healers gives 50% spirit regen in combat
        if self.CLASS_FILENAME == "PRIEST" or self.CLASS_FILENAME == "DRUID" or self.CLASS_FILENAME == "SHAMAN" then
            return baseRegen * 0.5
        else
            return baseRegen * 0.0
        end
    end

    return baseRegen
end

--- Calculates the spirit regeneration rate for the player
--- @return number The spirit-based mana regeneration rate per second
--- @usage NAG:SpiritRegen() >= 0.1
--- @local This function is used to calculate the spirit regeneration rate for the player
function NAG:SpiritRegen()
    -- (0.001 + (SPI x sqrt(INT) x BASE_REGEN[LEVEL])) x 5
    local BASE_REGEN = 0.001
    local SPIRIT = UnitStat("player", 5)
    local INT = UnitStat("player", 4)

    if not SPIRIT or not INT then
        self:Warn("SpiritRegen: Failed to get player stats")
        return 0
    end

    return (0.001 + (SPIRIT * math.sqrt(INT) * 0.003345))
end
