--- @module "EntityBehaviors"
--- Handles all entity behaviors for the NAG addon
---
--- This module defines and manages all entity behaviors for the Next Action Guide addon.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ======= LOCALIZE =======
-- Addon
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- WoW API
local WoWAPI = ns.WoWAPI
local GetItemCount = C_Item and C_Item.GetItemCount or _G.GetItemCount
local IsEquippedItem = (C_Item and C_Item.IsEquippedItem) or _G.IsEquippedItem
local IsCurrentSpell = C_Spell and C_Spell.IsCurrentSpell or _G.IsCurrentSpell
local GetSpellPowerCost = C_Spell and C_Spell.GetSpellPowerCost or _G.GetSpellPowerCost
local GetItemCooldown = C_Container and C_Container.GetItemCooldown or _G.GetItemCooldown
local IsUsableSpell = C_Spell and C_Spell.IsSpellUsable or _G.IsUsableSpell
local GetUnitSpeed = _G.GetUnitSpeed
local HasPetUI = _G.HasPetUI
local GetShapeshiftFormID = _G.GetShapeshiftFormID

-- Lua APIs
local max = math.max
local min = math.min
local GetTime = _G.GetTime
local UnitExists = _G.UnitExists
local UnitGUID = _G.UnitGUID
local UnitHealth = _G.UnitHealth
local UnitHealthMax = _G.UnitHealthMax
local UnitIsDead = _G.UnitIsDead
local UnitIsEnemy = _G.UnitIsEnemy
local UnitIsFriend = _G.UnitIsFriend
local UnitCreatureFamily = _G.UnitCreatureFamily
local GetWeaponEnchantInfo = _G.GetWeaponEnchantInfo
local GetTotemInfo = _G.GetTotemInfo
local GetShapeshiftForm = _G.GetShapeshiftForm
local strsplit = strsplit
local tonumber = tonumber
local pairs = pairs
local floor = math.floor

-- Create behavior registry
ns.EntityBehaviors = {
    -- Dynamic behavior override registry
    _overrides = {
        -- Structure: [entityType][entityId][behaviorName] = function
        -- Example: ["Spell"][63560]["IsActive"] = customFunction
    },

    -- Register a custom behavior override for a specific entity or multiple entities
    RegisterOverride = function(entityType, entityIdOrTable, behaviorName, overrideFunction)
        -- Handle both single entity ID and table of entity IDs
        local entityIds = type(entityIdOrTable) == "table" and entityIdOrTable or {entityIdOrTable}

        if not ns.EntityBehaviors._overrides[entityType] then
            ns.EntityBehaviors._overrides[entityType] = {}
        end

        for _, entityId in pairs(entityIds) do
            if not ns.EntityBehaviors._overrides[entityType][entityId] then
                ns.EntityBehaviors._overrides[entityType][entityId] = {}
            end
            ns.EntityBehaviors._overrides[entityType][entityId][behaviorName] = overrideFunction
        end
    end,

    -- Alias for bulk registration (same as RegisterOverride, just for clarity)
    RegisterOverrides = function(entityType, entityIdOrTable, behaviorName, overrideFunction)
        return ns.EntityBehaviors.RegisterOverride(entityType, entityIdOrTable, behaviorName, overrideFunction)
    end,

    -- Unregister a custom behavior override for a specific entity or multiple entities
    UnregisterOverride = function(entityType, entityIdOrTable, behaviorName)
        -- Handle both single entity ID and table of entity IDs
        local entityIds = type(entityIdOrTable) == "table" and entityIdOrTable or {entityIdOrTable}

        for _, entityId in pairs(entityIds) do
            if ns.EntityBehaviors._overrides[entityType] and
               ns.EntityBehaviors._overrides[entityType][entityId] then
                ns.EntityBehaviors._overrides[entityType][entityId][behaviorName] = nil
            end
        end
    end,

    -- Alias for bulk unregistration (same as UnregisterOverride, just for clarity)
    UnregisterOverrides = function(entityType, entityIdOrTable, behaviorName)
        return ns.EntityBehaviors.UnregisterOverride(entityType, entityIdOrTable, behaviorName)
    end,

    -- Check if an entity has a custom behavior override
    HasOverride = function(entityType, entityId, behaviorName)
        return ns.EntityBehaviors._overrides[entityType] and
               ns.EntityBehaviors._overrides[entityType][entityId] and
               ns.EntityBehaviors._overrides[entityType][entityId][behaviorName] ~= nil
    end,

    -- Store original ExecuteBehavior function for caching integration
    _originalExecuteBehavior = function(entityType, entityId, behaviorName, entity, ...)
        -- Check for custom override first
        if ns.EntityBehaviors.HasOverride(entityType, entityId, behaviorName) then
            local overrideFunc = ns.EntityBehaviors._overrides[entityType][entityId][behaviorName]
            return overrideFunc(entity, ...)
        end

        -- Fall back to default behavior
        local behaviorTable = ns.EntityBehaviors[entityType]
        if behaviorTable and behaviorTable[behaviorName] then
            return behaviorTable[behaviorName](entity, ...)
        end

        -- Fall back to base behavior
        if ns.EntityBehaviors.Base[behaviorName] then
            return ns.EntityBehaviors.Base[behaviorName](entity, ...)
        end

        return false
    end,

    -- Execute a behavior with override support and evaluation caching
    ExecuteBehavior = function(entityType, entityId, behaviorName, entity, ...)
        -- Check if we're in APL evaluation context
        local APLEvaluationCache = NAG:GetModule("APLEvaluationCache", true)
        if APLEvaluationCache and APLEvaluationCache:IsActive() then
            -- Use the new nested table cache system
            -- Create a composite function name for cache lookup
            local compositeFuncName = "behavior:" .. entityType .. ":" .. tostring(entityId) .. ":" .. behaviorName

            -- Leverage GetCachedOrExecute with the new nested table cache
            return APLEvaluationCache:GetCachedOrExecute(
                "behavior",
                compositeFuncName,
                ns.EntityBehaviors._originalExecuteBehavior,
                ns.EntityBehaviors,
                entityType, entityId, behaviorName, entity, ...
            )
        end

        -- Not in evaluation context, execute normally
        return ns.EntityBehaviors._originalExecuteBehavior(entityType, entityId, behaviorName, entity, ...)
    end,


    -- Add unit validation helpers at the top
    _helpers = {
        ValidateUnit = function(unit)
            if not unit then return false end
            if type(unit) ~= "string" then return false end
            return UnitExists(unit)
        end,
        ValidateHostileUnit = function(unit)
            if not unit then return false end
            if type(unit) ~= "string" then return false end
            return UnitExists(unit) and not UnitIsFriend("player", unit)
        end,
        ValidateFriendlyUnit = function(unit)
            if not unit then return false end
            if type(unit) ~= "string" then return false end
            return UnitExists(unit) and UnitIsFriend("player", unit)
        end,
        ValidatePet = function(unit)
            if not unit then return false end
            if type(unit) ~= "string" then return false end
            -- Check if unit exists and is a pet
            return UnitExists(unit) and unit == "pet"
        end,
        GetDefaultUnit = function(self)
            return (self.flags and self.flags.dot) and "target" or "player"
        end,
        CheckAura = function(unit, id)
            if not id then return false end
            return NAG:UnitAura(unit, id) ~= false
        end,
        GetAuraInfo = function(unit, id)
            if not id then return nil end
            return NAG:UnitAura(unit, id)
        end,
        GetAuraExpiration = function(unit, id)
            if not id then return 0 end
            local aura = NAG:UnitAura(unit, id)
            if not aura or not aura.expirationTime then return 0 end
            return max(0, aura.expirationTime - NAG:NextTime())
        end,
        GetAuraStacks = function(unit, id)
            if not id then return 0 end
            local aura = NAG:UnitAura(unit, id)
            return aura and aura.count or 0
        end,
        CheckRelatedSpells = function(itemId, checkFunc)
            local DataManager = NAG:GetModule("DataManager")
            local relatedSpells = DataManager:GetRelated(itemId, DataManager.EntityTypes.ITEM,
                DataManager.EntityTypes.SPELL)
            if not relatedSpells then return nil end

            for spellId, _ in pairs(relatedSpells) do
                local result = checkFunc(spellId)
                if result then return result end
            end
            return nil
        end,
    },

    Base = {
        -- Base behaviors all entities should have
        IsKnown = function(self)
            return false
        end,
        IsActive = function(self) return false end,
        RemainingTime = function(self) return 0 end,
        IsReady = function(self) return false end,
        TimeToReady = function(self) return 0 end,
        GetStacks = function(self) return 0 end,
        --- Internal helper method for entity casting behavior.
        --- Does not map to APL proto - this is a behavior helper only.
        --- @local
        --- @return boolean Always returns false for base implementation
        CastSpell = function(self) return false end,
        --- Gets all related entities of a specific type
        --- @param self table The entity instance
        --- @param targetType string The target entity type to get relationships for
        --- @return table Map of related entities keyed by their IDs
        GetRelated = function(self, targetType)
            if not targetType then return {} end
            local DataManager = NAG:GetModule("DataManager")
            return DataManager:GetRelated(self.id, self.entryType, targetType) or {}
        end,
        --- Gets the first related entity of a specific type
        --- @param self table The entity instance
        --- @param targetType string The target entity type to get relationship for
        --- @return table|nil The first related entity if found, nil otherwise
        GetFirstRelated = function(self, targetType)
            if not targetType then return nil end
            local related = ns.EntityBehaviors.Base.GetRelated(self, targetType)
            -- Return the first value from the table
            for _, entity in pairs(related) do
                return entity
            end
            return nil
        end,
    },
    Talent = {
        IsKnown = function(self)
            local StateManager = NAG:GetModule("StateManager")
            return StateManager:HasTalent(self.id)
        end,
        GetRank = function(self)
            local StateManager = NAG:GetModule("StateManager")
            return StateManager:GetTalentRank(self.id)
        end,
        GetSpellId = function(self)
            local StateManager = NAG:GetModule("StateManager")
            return StateManager:GetCurrentTalentSpellId(self.id)
        end,
    },
    Set = {
        --TODO:
        IsKnown = function(self) return false end,
        IsActive = function(self) return false end,
        RemainingTime = function(self) return 0 end,
        IsReady = function(self) return false end,
        TimeToReady = function(self) return 0 end,
    },

    Spell = {
        IsKnown = function(self)
            -- First check if it's a talent spell
            local DataManager = NAG:GetModule("DataManager")
            local StateManager = NAG:GetModule("StateManager")
            local talent = DataManager:GetTalentBySpellId(self.id)
            if talent then
                return StateManager:HasTalent(talent.talentId)
            end

            -- Use unified API for spell knowledge checking
            -- Check player spells first
            if WoWAPI.IsSpellKnown(self.id, false, true) then -- isPet=false, includeOverrides=true
                return true
            end

            -- Check pet spells only if pet is active
            if HasPetUI() and UnitExists("pet") and WoWAPI.IsSpellKnown(self.id, true, true) then -- isPet=true, includeOverrides=true
                return true
            end

            return false
        end,
        IsActive = function(self, unit)
            unit = unit or ns.EntityBehaviors._helpers.GetDefaultUnit(self)
            if not ns.EntityBehaviors._helpers.ValidateUnit(unit) then return false end
            -- Use enhanced aura detection with exact ID matching for spell ID conflicts
            return NAG:UnitAura(unit, self.id) ~= false
        end,
        RemainingTime = function(self, unit)
            unit = unit or ns.EntityBehaviors._helpers.GetDefaultUnit(self)
            if not ns.EntityBehaviors._helpers.ValidateUnit(unit) then return 0 end
            local aura = NAG:UnitAura(unit, self.id)
            if not aura or not aura.expirationTime then return 0 end
            return max(0, aura.expirationTime - NAG:NextTime())
        end,
        IsReady = function(self)
            local cdInfo = WoWAPI.GetSpellCooldown(self.id)
            if not cdInfo or not cdInfo.startTime or not cdInfo.duration then return false end
            local start, duration = cdInfo.startTime, cdInfo.duration
            return start + duration <= NAG:NextTime()
        end,
        TimeToReady = function(self)
            local cdInfo = WoWAPI.GetSpellCooldown(self.id)
            if not cdInfo or not cdInfo.startTime or not cdInfo.duration then return 0 end
            local start, duration = cdInfo.startTime, cdInfo.duration
            if start == 0 then return 0 end
            return max(0, start + duration - NAG:NextTime())
        end,
        GetStacks = function(self, unit)
            unit = unit or ns.EntityBehaviors._helpers.GetDefaultUnit(self)
            if not ns.EntityBehaviors._helpers.ValidateUnit(unit) then return 0 end
            local aura = NAG:UnitAura(unit, self.id)
            return aura and aura.count or 0
        end,
        IsInFlight = function(self)
            local SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
            return SpellTrackingManager:IsSpellInFlight(self.id)
        end,
        GetCost = function(self)
            local costTable = GetSpellPowerCost(self.id)
            if not costTable or #costTable == 0 or not costTable[1] then return 0 end
            return costTable[1].cost or 0
        end,
        ShouldRefresh = function(self, maxOverlap)
            maxOverlap = maxOverlap or 0
            if not ns.EntityBehaviors.Spell.IsActive(self) then return true end
            return ns.EntityBehaviors.Spell.RemainingTime(self) <= maxOverlap
        end,
        GetCharges = function(self)
            local chargeInfo = WoWAPI.GetSpellCharges(self.id)
            if not chargeInfo or not chargeInfo.currentCharges then return 0 end
            return chargeInfo.currentCharges
        end,
        GetMaxCharges = function(self)
            local chargeInfo = WoWAPI.GetSpellCharges(self.id)
            if not chargeInfo or not chargeInfo.maxCharges then return 0 end
            return chargeInfo.maxCharges
        end,
        GetChargesFractional = function(self)
            local chargeInfo = WoWAPI.GetSpellCharges(self.id)
            if not chargeInfo then return 0 end
            local charges, maxCharges, start, duration = chargeInfo.currentCharges, chargeInfo.maxCharges, chargeInfo.cooldownStartTime, chargeInfo.cooldownDuration
            if not charges or not maxCharges or not start or not duration then return 0 end
            if charges >= maxCharges then return charges end
            local timeSinceStart = NAG:NextTime() - start
            return charges + (timeSinceStart / duration)
        end,
        SpellCanCast = function(self, tolerance)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Spell", self.id, "SpellCanCast") then
                return ns.EntityBehaviors.ExecuteBehavior("Spell", self.id, "SpellCanCast", self, tolerance)
            end

            if not ns.EntityBehaviors.Spell.IsKnown(self) then return false end

            local spellId = self.id
            local class = NAG.CLASS_FILENAME

            if class == "DEATHKNIGHT" then
                if not NAG:HasRunicPower(spellId) then
                    return false
                end
                --TODO believe this can be removed?
                -- Rune Strike has no cooldown, it becomes usable after a dodge or parry
                if spellId == 56815 then                                  --Rune Strike
                    local usable = IsUsableSpell(spellId)
                    if not usable or IsCurrentSpell(56815) then --Rune Strike
                        return false
                    end
                end
            elseif class == "WARRIOR" then
                if tolerance then
                    if tolerance > 6 then
                        return true
                    end
                end
                if not NAG:HasRage(spellId) then
                    return false
                end
                if spellId == 6572 then                                  --Revenge
                    local usable = IsUsableSpell(spellId)
                    if not usable or IsCurrentSpell(6572) then --Revenge
                        return false
                    end
                end
                if spellId == 7384 or spellId == 772 then --OP or REND
                    return ns.EntityBehaviors.Spell.IsReady(self, tolerance)
                end
                return ns.EntityBehaviors.Spell.IsReady(self, tolerance) and IsUsableSpell(spellId)
            elseif class == "DRUID" then
                local Types = NAG:GetModule("Types")
                local formId = GetShapeshiftForm()
                if formId == Types:GetType("StanceType").Bear then
                    if not NAG:HasRage(spellId) then
                        return false
                    end
                elseif formId == Types:GetType("StanceType").Cat then
                    if not NAG:HasEnergy(spellId) or not NAG:HasComboPoints(spellId) then
                        return false
                    end
                end
                if not NAG:HasMana(spellId) then
                    return false
                end
            elseif class == "MONK" then
                --if not NAG:HasEnergy(spellId) then
                --    return true
                --end
                if spellId == 116740 then
                    return NAG:AuraNumStacks(125195) >= 1
                end
                if not NAG:HasChi(spellId) then
                    return false
                end
            elseif class == "ROGUE" then
                -- Removed for 3/6 to account for pooling issues. But still showing when pooling energy.
                if not NAG:HasEnergy(spellId) then
                    NAG.isPooling = true
                    NAG:Pooling()
                    return true
                elseif NAG.isPooling then
                    NAG:StopPooling()
                end
                if not NAG:HasComboPoints(spellId) then
                    return false
                end
            elseif class == "WARLOCK" then
                if not NAG:HasMana(spellId) or not NAG:HasSoulShards(spellId) then
                    return false
                end
            elseif class == "PALADIN" then
                if not NAG:HasMana(spellId) or not NAG:HasHolyPower(spellId) then
                    return false
                end
            elseif class == "HUNTER" then
                if not NAG:HasFocus(spellId) then
                    return false
                end
            else
                if not NAG:HasMana(spellId) then
                    return false
                end
            end
            return ns.EntityBehaviors.Spell.IsReady(self, tolerance)
        end,
        --- Internal helper method for spell casting behavior.
        --- Does not map to APL proto - this is a behavior helper only.
        --- Use NAG:CastSpell() for APL actions.
        --- @local
        --- @param tolerance number|nil Optional casting tolerance in seconds
        --- @return boolean True if spell was set to cast, false otherwise
        CastSpell = function(self, tolerance)
            tolerance = tolerance or 0

            -- Handle stance spells
            if self.flags.stance and GetShapeshiftFormID() == self.shapeshiftForm then
                return false
            end

            -- Handle pet spells
            if self.flags.pet then
                local StateManager = NAG:GetModule("StateManager")
                if self.flags.action then
                    -- Only proceed if we have the correct pet active
                    if StateManager:IsActivePet(self.summonSpellId) then
                        if NAG:IsSecondarySpell(self.id) then
                            NAG:AddSecondarySpell(self.id)
                            return false
                        else
                            NAG.nextSpell = NAG:NormalizePrimaryAction(self.id, { context = "entity_spell_primary" })
                            return true
                        end
                    end
                elseif self.id == self.id and StateManager:IsActivePet(self.id) then
                    return false
                end
            end

            -- Check if the spell can be cast
            if ns.EntityBehaviors.Spell.SpellCanCast(self, tolerance) then
                if NAG:IsSecondarySpell(self.id) then
                    NAG:AddSecondarySpell(self.id)
                    return false
                else
                    NAG.nextSpell = NAG:NormalizePrimaryAction(self.id, { context = "entity_spell_primary" })
                    return true
                end
            end

            return false
        end,
    },
    -- TODO: Need to associate these in @datamanager still
    Tinker = {
        -- Tinker-specific behaviors that override or extend Spell behaviors
        IsKnown = function(self)
            if not self.itemId then return false end
            return IsEquippedItem(self.itemId)
        end,
        IsReady = function(self)
            if not self.itemId then return false end
            if not IsEquippedItem(self.itemId) then return false end

            local start, duration = GetItemCooldown(self.itemId)
            return (start == 0 and duration == 0) or (start + duration <= NAG:NextTime())
        end,
        TimeToReady = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Tinker", self.id, "TimeToReady") then
                return ns.EntityBehaviors.ExecuteBehavior("Tinker", self.id, "TimeToReady", self)
            end

            if not self.itemId then return -1 end

            local start, duration = GetItemCooldown(self.itemId)
            if start == 0 then return 0 end
            return start + duration - NAG:NextTime()
        end,
        --- Internal helper method for tinker casting behavior.
        --- Does not map to APL proto - this is a behavior helper only.
        --- @local
        --- @return boolean True if tinker was set to cast, false otherwise
        CastSpell = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Tinker", self.id, "CastSpell") then
                return ns.EntityBehaviors.ExecuteBehavior("Tinker", self.id, "CastSpell", self)
            end

            -- First check if we have an itemId
            if not self.itemId then return false end
            -- Then check if that item is equipped
            if not IsEquippedItem(self.itemId) then return false end
            -- Finally check if it's ready
            if not ns.EntityBehaviors.Tinker.IsReady(self) then return false end

            NAG:AddSecondarySpell(self.itemId)
            return false
        end,
    },

    Aura = {
        -- Aura-specific behaviors that override or extend Spell behaviors
        IsActive = function(self, unit)
            unit = unit or "player"
            if not ns.EntityBehaviors._helpers.ValidateUnit(unit) then return false end
            -- Use enhanced aura detection with exact ID matching for spell ID conflicts
            return NAG:UnitAura(unit, self.id) ~= false
        end,
        GetExpirationTime = function(self, unit)
            unit = unit or "player"
            if not ns.EntityBehaviors._helpers.ValidateUnit(unit) then return 0 end
            local aura = NAG:UnitAura(unit, self.id)
            return aura and aura.expirationTime or 0
        end,
        GetICDRemaining = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Aura", self.id, "GetICDRemaining") then
                return ns.EntityBehaviors.ExecuteBehavior("Aura", self.id, "GetICDRemaining", self)
            end

            if not self.id then return 0 end
            local SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
            return SpellTrackingManager:GetICDInfo(self.id) or 0
        end,
        GetStacks = function(self, unit)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Aura", self.id, "GetStacks") then
                return ns.EntityBehaviors.ExecuteBehavior("Aura", self.id, "GetStacks", self, unit)
            end

            unit = unit or "player"
            if not ns.EntityBehaviors._helpers.ValidateUnit(unit) then return 0 end

            -- Special case for totem stacks
            if self.id == 88747 then
                if GetTotemInfo(3) then
                    return 3
                elseif GetTotemInfo(2) then
                    return 2
                elseif GetTotemInfo(1) then
                    return 1
                else
                    return 0
                end
            end

            -- Get aura stacks using enhanced detection
            local aura = NAG:UnitAura(unit, self.id)
            return aura and aura.count or 1 -- Always return at least 1 stack if the aura exists
        end,
    },

    Dot = {
        -- DoT-specific behaviors that override or extend Spell behaviors
        IsActive = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Dot", self.id, "IsActive") then
                return ns.EntityBehaviors.ExecuteBehavior("Dot", self.id, "IsActive", self)
            end

            if not ns.EntityBehaviors._helpers.ValidateHostileUnit("target") then return false end
            return NAG:UnitDebuffGlobal("target", self.id) ~= false
        end,
        GetPeriodicInfo = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Dot", self.id, "GetPeriodicInfo") then
                return ns.EntityBehaviors.ExecuteBehavior("Dot", self.id, "GetPeriodicInfo", self)
            end

            if not self.id then return nil end
            if not ns.EntityBehaviors._helpers.ValidateHostileUnit("target") then return nil end

            -- Handle special cases like Ignite where we track a different spell ID
            local effectId = self.id
            if self.id == 12846 then -- Ignite
                effectId = 413843
            end

            -- Get the effect info
            local SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
            local effect = SpellTrackingManager:GetPeriodicEffectInfo(effectId)
            if not effect then return nil end

            -- If the effect has a mapped spellId, get that effect instead
            if effect.spellId and effect.spellId ~= effectId then
                effect = SpellTrackingManager:GetPeriodicEffectInfo(effect.spellId)
            end

            -- Validate effect has required fields
            if not effect or type(effect) ~= "table" then return nil end
            if not effect.targets or type(effect.targets) ~= "table" then return nil end

            return effect
        end,
        GetTickTime = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Dot", self.id, "GetTickTime") then
                return ns.EntityBehaviors.ExecuteBehavior("Dot", self.id, "GetTickTime", self)
            end

            if not ns.EntityBehaviors._helpers.ValidateHostileUnit("target") then return 0 end
            local effect = ns.EntityBehaviors.Dot.GetPeriodicInfo(self)
            if not effect then return 0 end

            -- Get target-specific data
            local targetGuid = UnitGUID("target")
            if not targetGuid or not effect.targets[targetGuid] then return 0 end
            if not effect.targets[targetGuid].tickTime or type(effect.targets[targetGuid].tickTime) ~= "number" then return 0 end

            return effect.targets[targetGuid].tickTime
        end,
        GetTickDamage = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Dot", self.id, "GetTickDamage") then
                return ns.EntityBehaviors.ExecuteBehavior("Dot", self.id, "GetTickDamage", self)
            end

            if not ns.EntityBehaviors._helpers.ValidateHostileUnit("target") then return 0 end

            -- Check if this spell has a custom damage handler (O(1) lookup)
            if NAG:HasCustomDamageHandler(self.id) then
                return NAG:GetCustomDamage(self.id, "target")
            end

            -- For other DoTs, use the existing logic
            local effect = ns.EntityBehaviors.Dot.GetPeriodicInfo(self)
            if not effect then return 0 end

            -- Get target-specific data
            local targetGuid = UnitGUID("target")
            if not targetGuid or not effect.targets[targetGuid] then return 0 end
            if not effect.targets[targetGuid].tickDamage or type(effect.targets[targetGuid].tickDamage) ~= "number" then return 0 end

            return effect.targets[targetGuid].tickDamage
        end,
        GetLastTickTime = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Dot", self.id, "GetLastTickTime") then
                return ns.EntityBehaviors.ExecuteBehavior("Dot", self.id, "GetLastTickTime", self)
            end

            if not ns.EntityBehaviors._helpers.ValidateHostileUnit("target") then return 0 end
            local effect = ns.EntityBehaviors.Dot.GetPeriodicInfo(self)
            if not effect then return 0 end

            local targetGuid = UnitGUID("target")
            if not targetGuid then return 0 end

            local targetData = effect.targets[targetGuid]
            if not targetData or type(targetData) ~= "table" then return 0 end
            if not targetData.lastTickTime or type(targetData.lastTickTime) ~= "number" then return 0 end

            return targetData.lastTickTime
        end,
        GetTimeToNextTick = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Dot", self.id, "GetTimeToNextTick") then
                return ns.EntityBehaviors.ExecuteBehavior("Dot", self.id, "GetTimeToNextTick", self)
            end

            local lastTick = ns.EntityBehaviors.Dot.GetLastTickTime(self)
            if lastTick == 0 then return 0 end
            local tickTime = ns.EntityBehaviors.Dot.GetTickTime(self)
            if tickTime == 0 then return 0 end

            local timeSinceLastTick = NAG:NextTime() - lastTick
            return max(0, tickTime - (timeSinceLastTick % tickTime))
        end,
        GetRemainingTicks = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Dot", self.id, "GetRemainingTicks") then
                return ns.EntityBehaviors.ExecuteBehavior("Dot", self.id, "GetRemainingTicks", self)
            end

            local remaining = ns.EntityBehaviors.Spell.RemainingTime(self) -- This already uses nextTime
            local tickTime = ns.EntityBehaviors.Dot.GetTickTime(self)
            if tickTime == 0 then return 0 end
            return floor(remaining / tickTime)
        end,
        GetTotalDamage = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Dot", self.id, "GetTotalDamage") then
                return ns.EntityBehaviors.ExecuteBehavior("Dot", self.id, "GetTotalDamage", self)
            end

            local ticks = ns.EntityBehaviors.Dot.GetRemainingTicks(self)
            local damage = ns.EntityBehaviors.Dot.GetTickDamage(self)
            return ticks * damage
        end,
        ShouldRefresh = function(self, maxOverlap)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Dot", self.id, "ShouldRefresh") then
                return ns.EntityBehaviors.ExecuteBehavior("Dot", self.id, "ShouldRefresh", self, maxOverlap)
            end

            maxOverlap = maxOverlap or ns.EntityBehaviors.Dot.GetTickTime(self)
            if not ns.EntityBehaviors.Dot.IsActive(self) then return true end
            return ns.EntityBehaviors.Spell.RemainingTime(self) <= maxOverlap -- RemainingTime already uses nextTime
        end,
    },

    Item = {
        IsKnown = function(self)
            return GetItemCount(self.id) > 0
        end,
        IsActive = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Item", self.id, "IsActive") then
                return ns.EntityBehaviors.ExecuteBehavior("Item", self.id, "IsActive", self)
            end

            -- For items with spellId, check that first
            if self.spellId and ns.EntityBehaviors._helpers.CheckAura("player", self.spellId) then
                return true
            end

            if ns.EntityBehaviors._helpers.CheckRelatedSpells(self.id, function(spellId)
                    return ns.EntityBehaviors._helpers.CheckAura("player", spellId)
                end) then
                return true
            end

            -- For equipment, check if equipped
            return IsEquippedItem(self.id)
        end,
        RemainingTime = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Item", self.id, "RemainingTime") then
                return ns.EntityBehaviors.ExecuteBehavior("Item", self.id, "RemainingTime", self)
            end

            -- For items with spellId, check that first
            if self.spellId then
                local remaining = ns.EntityBehaviors._helpers.GetAuraExpiration("player", self.spellId)
                if remaining > 0 then return remaining end
            end

            -- Check for ITEM_TO_SPELL relationships as fallback
            local maxRemaining = ns.EntityBehaviors._helpers.CheckRelatedSpells(self.id, function(spellId)
                return ns.EntityBehaviors._helpers.GetAuraExpiration("player", spellId)
            end) or 0

            return maxRemaining
        end,

        GetStacks = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Item", self.id, "GetStacks") then
                return ns.EntityBehaviors.ExecuteBehavior("Item", self.id, "GetStacks", self)
            end

            -- For items with spellId, check that first
            if self.spellId then
                local count = ns.EntityBehaviors._helpers.GetAuraStacks("player", self.spellId)
                if count > 0 then return count end
            end

            -- Check for ITEM_TO_SPELL relationships as fallback
            local maxStacks = ns.EntityBehaviors._helpers.CheckRelatedSpells(self.id, function(spellId)
                return ns.EntityBehaviors._helpers.GetAuraStacks("player", spellId)
            end) or 0

            -- If buff is active but no stacks found, return 1
            return maxStacks > 0 and maxStacks or (ns.EntityBehaviors.Item.IsActive(self) and 1 or 0)
        end,
        IsReady = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Item", self.id, "IsReady") then
                return ns.EntityBehaviors.ExecuteBehavior("Item", self.id, "IsReady", self)
            end

            -- First check if we have the item
            if not (GetItemCount(self.id) > 0 or IsEquippedItem(self.id)) then
                return false
            end

            -- Then check cooldown
            local start, duration = GetItemCooldown(self.id)
            return start + duration <= NAG:NextTime()
        end,
        TimeToReady = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Item", self.id, "TimeToReady") then
                return ns.EntityBehaviors.ExecuteBehavior("Item", self.id, "TimeToReady", self)
            end

            local start, duration = GetItemCooldown(self.id)
            if start == 0 then return 0 end
            return max(0, start + duration - NAG:NextTime())
        end,
        --- Internal helper method for item casting behavior.
        --- Does not map to APL proto - this is a behavior helper only.
        --- @local
        --- @return boolean Always returns false (items are added as secondary spells)
        CastSpell = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Item", self.id, "CastSpell") then
                return ns.EntityBehaviors.ExecuteBehavior("Item", self.id, "CastSpell", self)
            end

            if not ns.EntityBehaviors.Item.IsReady(self) then return false end
            NAG:AddSecondarySpell(self.id)
            return false
        end,
    },

    Trinket = {
        -- Trinket-specific behaviors that override or extend Item behaviors
        IsKnown = function(self)
            return IsEquippedItem(self.id)
        end,
        IsActive = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Trinket", self.id, "IsActive") then
                return ns.EntityBehaviors.ExecuteBehavior("Trinket", self.id, "IsActive", self)
            end

            -- For proc trinkets, check proc state
            if self.procId and ns.EntityBehaviors._helpers.CheckAura("player", self.procId) then
                return true
            end
            -- For on-use trinkets, check buff using spellId
            if self.spellId and ns.EntityBehaviors._helpers.CheckAura("player", self.spellId) then
                return true
            end

            -- Check for ITEM_TO_SPELL relationships as fallback
            return ns.EntityBehaviors._helpers.CheckRelatedSpells(self.id, function(spellId)
                return ns.EntityBehaviors._helpers.CheckAura("player", spellId)
            end) ~= nil
        end,
        RemainingTime = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Trinket", self.id, "RemainingTime") then
                return ns.EntityBehaviors.ExecuteBehavior("Trinket", self.id, "RemainingTime", self)
            end

            -- For proc trinkets, check proc remaining
            if self.procId then
                local remaining = ns.EntityBehaviors._helpers.GetAuraExpiration("player", self.procId)
                if remaining > 0 then return remaining end
            end
            -- For on-use trinkets, check buff remaining using spellId
            if self.spellId then
                local remaining = ns.EntityBehaviors._helpers.GetAuraExpiration("player", self.spellId)
                if remaining > 0 then return remaining end
            end

            -- Check for ITEM_TO_SPELL relationships as fallback
            return ns.EntityBehaviors._helpers.CheckRelatedSpells(self.id, function(spellId)
                return ns.EntityBehaviors._helpers.GetAuraExpiration("player", spellId)
            end) or 0
        end,
        GetStacks = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Trinket", self.id, "GetStacks") then
                return ns.EntityBehaviors.ExecuteBehavior("Trinket", self.id, "GetStacks", self)
            end

            -- For proc trinkets, check proc aura stacks
            if self.procId then
                local count = ns.EntityBehaviors._helpers.GetAuraStacks("player", self.procId)
                if count > 0 then return count end
            end
            -- For on-use trinkets, check buff stacks using spellId
            if self.spellId then
                local count = ns.EntityBehaviors._helpers.GetAuraStacks("player", self.spellId)
                if count > 0 then return count end
            end

            -- Check for ITEM_TO_SPELL relationships as fallback
            local maxStacks = ns.EntityBehaviors._helpers.CheckRelatedSpells(self.id, function(spellId)
                return ns.EntityBehaviors._helpers.GetAuraStacks("player", spellId)
            end) or 0

            -- If buff is active but no stacks found, return 1
            return maxStacks > 0 and maxStacks or (ns.EntityBehaviors.Trinket.IsActive(self) and 1 or 0)
        end,
        IsReady = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Trinket", self.id, "IsReady") then
                return ns.EntityBehaviors.ExecuteBehavior("Trinket", self.id, "IsReady", self)
            end

            -- First check if equipped
            if not IsEquippedItem(self.id) then
                return false
            end

            -- Check item cooldown
            local start, duration = GetItemCooldown(self.id)
            if start + duration > NAG:NextTime() then
                return false
            end

            -- For proc trinkets, also check ICD
            if self.procId then
                local TrinketTrackingManager = NAG:GetModule("TrinketTrackingManager")
                local procState = TrinketTrackingManager:GetTrinketProcInfo(self.procId)
                if procState and procState.nextProcTime and procState.nextProcTime > NAG:NextTime() then
                    return false
                end
            end

            return true
        end,
        TimeToReady = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Trinket", self.id, "TimeToReady") then
                return ns.EntityBehaviors.ExecuteBehavior("Trinket", self.id, "TimeToReady", self)
            end

            -- Check item cooldown
            local start, duration = GetItemCooldown(self.id)
            local itemCD = start + duration - NAG:NextTime()

            -- For proc trinkets, also check ICD
            if self.procId then
                local TrinketTrackingManager = NAG:GetModule("TrinketTrackingManager")
                local procState = TrinketTrackingManager:GetTrinketProcInfo(self.procId)
                if procState and procState.nextProcTime then
                    local icdRemaining = max(0, procState.nextProcTime - NAG:NextTime())
                    return max(itemCD, icdRemaining)
                end
            end

            return max(0, itemCD)
        end,
        GetProcState = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Trinket", self.id, "GetProcState") then
                return ns.EntityBehaviors.ExecuteBehavior("Trinket", self.id, "GetProcState", self)
            end

            if self.procId then
                local TrinketTrackingManager = NAG:GetModule("TrinketTrackingManager")
                local procState = TrinketTrackingManager:GetTrinketProcInfo(self.procId)
                if procState then return procState end
            end

            -- Check if trinket is equipped using trinketData
            local StateManager = NAG:GetModule("StateManager")
            local trinketState = StateManager.state.player.equipment.trinketData
            for slot = 13, 14 do
                if trinketState[slot] and trinketState[slot].itemId == self.id then
                    local trinketData = trinketState[slot]
                    local trinketInfo = trinketData.trinketInfo

                    -- Return enhanced state from analyzed trinket data
                    return {
                        itemId = self.id,
                        procId = self.procId or (trinketInfo and trinketInfo.buffId),
                        spellId = self.spellId,
                        flags = self.flags,
                        icd = trinketInfo and trinketInfo.icd or self.ICD, -- Use analyzed ICD if available
                        duration = trinketInfo and trinketInfo.duration,
                        isProc = trinketInfo and trinketInfo.isProc,
                        isUse = trinketInfo and trinketInfo.isUse,
                        lastUpdate = trinketData.lastUpdate
                    }
                end
            end
            return nil
        end,
        IsProcActive = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Trinket", self.id, "IsProcActive") then
                return ns.EntityBehaviors.ExecuteBehavior("Trinket", self.id, "IsProcActive", self)
            end

            -- First check aura directly if we have a procId
            if self.procId then
                return NAG:UnitAura("player", self.procId) ~= false
            end

            local procState = ns.EntityBehaviors.Trinket.GetProcState(self)
            if not procState then return false end

            -- If we have lastProcTime and duration info, check if proc is active
            if procState.lastProcTime then
                local duration = procState.duration or procState.learnedDuration or 0
                return (NAG:NextTime() - procState.lastProcTime) < duration
            end
            return false
        end,
        GetProcRemaining = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Trinket", self.id, "GetProcRemaining") then
                return ns.EntityBehaviors.ExecuteBehavior("Trinket", self.id, "GetProcRemaining", self)
            end

            -- First check aura directly if we have a procId
            if self.procId then
                local aura = NAG:UnitAura("player", self.procId)
                if aura and aura.expirationTime then
                    return max(0, aura.expirationTime - NAG:NextTime())
                end
            end

            local procState = ns.EntityBehaviors.Trinket.GetProcState(self)
            if not procState or not procState.lastProcTime then return 0 end

            local duration = procState.duration or procState.learnedDuration or 0
            if duration == 0 then return 0 end

            return max(0, (procState.lastProcTime + duration) - NAG:NextTime())
        end,
        GetICDRemaining = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Trinket", self.id, "GetICDRemaining") then
                return ns.EntityBehaviors.ExecuteBehavior("Trinket", self.id, "GetICDRemaining", self)
            end

            if not self.procId then return 0 end
            local SpellTrackingManager = NAG:GetModule("SpellTrackingManager")
            return SpellTrackingManager:GetICDInfo(self.procId) or 0
        end,
        GetMaxStacks = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Trinket", self.id, "GetMaxStacks") then
                return ns.EntityBehaviors.ExecuteBehavior("Trinket", self.id, "GetMaxStacks", self)
            end

            -- First check DataManager data (self)
            if self.maxStacks then return self.maxStacks end

            local procState = ns.EntityBehaviors.Trinket.GetProcState(self)
            return procState and procState.maxStacks or 1
        end,
        ShouldUseStacks = function(self, minStacks)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Trinket", self.id, "ShouldUseStacks") then
                return ns.EntityBehaviors.ExecuteBehavior("Trinket", self.id, "ShouldUseStacks", self, minStacks)
            end

            -- For trinkets with activatable effects that use stacks
            if not ns.EntityBehaviors.Trinket.IsReady(self) then return false end
            minStacks = minStacks or ns.EntityBehaviors.Trinket.GetMaxStacks(self) -- Default to max stacks if not specified

            -- For trinkets, check stacks on the proc buff if it exists
            if self.flags.trinket and self.procId then
                local count = select(3, ns.EntityBehaviors._helpers.GetAuraStacks("player", self.procId))
                return count and count >= minStacks
            end

            -- For non-trinkets or trinkets without procs, check regular stacks
            return ns.EntityBehaviors.Trinket.GetStacks(self) >= minStacks
        end,
    },

    Unit = {
        IsAlive = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Unit", self.id, "IsAlive") then
                return ns.EntityBehaviors.ExecuteBehavior("Unit", self.id, "IsAlive", self)
            end

            if not ns.EntityBehaviors._helpers.ValidateUnit(self.id) then return false end
            return not UnitIsDead(self.id)
        end,
        GetHealth = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Unit", self.id, "GetHealth") then
                return ns.EntityBehaviors.ExecuteBehavior("Unit", self.id, "GetHealth", self)
            end

            if not ns.EntityBehaviors._helpers.ValidateUnit(self.id) then return 0 end
            return UnitHealth(self.id)
        end,
        GetHealthMax = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Unit", self.id, "GetHealthMax") then
                return ns.EntityBehaviors.ExecuteBehavior("Unit", self.id, "GetHealthMax", self)
            end

            if not ns.EntityBehaviors._helpers.ValidateUnit(self.id) then return 0 end
            return UnitHealthMax(self.id)
        end,
        GetHealthPercent = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Unit", self.id, "GetHealthPercent") then
                return ns.EntityBehaviors.ExecuteBehavior("Unit", self.id, "GetHealthPercent", self)
            end

            if not ns.EntityBehaviors._helpers.ValidateUnit(self.id) then return 0 end
            local maxHealth = ns.EntityBehaviors.Unit.GetHealthMax(self)
            return maxHealth > 0 and (ns.EntityBehaviors.Unit.GetHealth(self) / maxHealth * 100) or 0
        end,
        IsEnemy = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Unit", self.id, "IsEnemy") then
                return ns.EntityBehaviors.ExecuteBehavior("Unit", self.id, "IsEnemy", self)
            end

            if not ns.EntityBehaviors._helpers.ValidateUnit(self.id) then return false end
            return UnitIsEnemy("player", self.id)
        end,
        IsFriend = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Unit", self.id, "IsFriend") then
                return ns.EntityBehaviors.ExecuteBehavior("Unit", self.id, "IsFriend", self)
            end

            if not ns.EntityBehaviors._helpers.ValidateUnit(self.id) then return false end
            return UnitIsFriend("player", self.id)
        end,
    },

    Pet = {
        -- Pet-specific behaviors that override Unit behaviors
        IsActive = function(self, unit)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Pet", self.id, "IsActive") then
                return ns.EntityBehaviors.ExecuteBehavior("Pet", self.id, "IsActive", self, unit)
            end

            unit = unit or "pet"
            if not ns.EntityBehaviors._helpers.ValidatePet(unit) then return false end
            local petGUID = UnitGUID(unit)
            if not petGUID then return false end
            local npcId = select(6, strsplit("-", petGUID))
            return tonumber(npcId) == self.npcId
        end,
        GetFamily = function(self, unit)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Pet", self.id, "GetFamily") then
                return ns.EntityBehaviors.ExecuteBehavior("Pet", self.id, "GetFamily", self, unit)
            end

            unit = unit or "pet"
            if not ns.EntityBehaviors._helpers.ValidatePet(unit) then return nil end
            if not ns.EntityBehaviors.Pet.IsActive(self, unit) then return nil end
            return UnitCreatureFamily(unit)
        end,
        -- Inherit other Unit behaviors but with pet validation
        IsAlive = function(self, unit)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Pet", self.id, "IsAlive") then
                return ns.EntityBehaviors.ExecuteBehavior("Pet", self.id, "IsAlive", self, unit)
            end

            unit = unit or "pet"
            if not ns.EntityBehaviors._helpers.ValidatePet(unit) then return false end
            return not UnitIsDead(unit)
        end,
        GetHealth = function(self, unit)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Pet", self.id, "GetHealth") then
                return ns.EntityBehaviors.ExecuteBehavior("Pet", self.id, "GetHealth", self, unit)
            end

            unit = unit or "pet"
            if not ns.EntityBehaviors._helpers.ValidatePet(unit) then return 0 end
            return UnitHealth(unit)
        end,
        GetHealthMax = function(self, unit)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Pet", self.id, "GetHealthMax") then
                return ns.EntityBehaviors.ExecuteBehavior("Pet", self.id, "GetHealthMax", self, unit)
            end

            unit = unit or "pet"
            if not ns.EntityBehaviors._helpers.ValidatePet(unit) then return 0 end
            return UnitHealthMax(unit)
        end,
        GetHealthPercent = function(self, unit)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Pet", self.id, "GetHealthPercent") then
                return ns.EntityBehaviors.ExecuteBehavior("Pet", self.id, "GetHealthPercent", self, unit)
            end

            unit = unit or "pet"
            if not ns.EntityBehaviors._helpers.ValidatePet(unit) then return 0 end
            local maxHealth = ns.EntityBehaviors.Pet.GetHealthMax(self, unit)
            return maxHealth > 0 and (ns.EntityBehaviors.Pet.GetHealth(self, unit) / maxHealth * 100) or 0
        end,
    },

    BattlePet = {
        -- Companion-specific behaviors for non-combat pets (battle pets/companions)
        --- Internal helper method for battle pet casting behavior.
        --- Does not map to APL proto - this is a behavior helper only.
        --- @local
        --- @return boolean Always returns false (battle pets are added as secondary spells)
        CastSpell = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("BattlePet", self.id, "CastSpell") then
                return ns.EntityBehaviors.ExecuteBehavior("BattlePet", self.id, "CastSpell", self)
            end

            if not ns.EntityBehaviors.BattlePet.IsReady(self) then return false end
            NAG:AddSecondarySpell(self.spellId)
            return false
        end,
        IsKnown = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("BattlePet", self.id, "IsKnown") then
                return ns.EntityBehaviors.ExecuteBehavior("BattlePet", self.id, "IsKnown", self)
            end

            if not self.speciesId then return false end
            local numCollected = C_PetJournal.GetNumCollectedInfo(self.speciesId)
            return numCollected > 0
        end,
        IsActive = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("BattlePet", self.id, "IsActive") then
                return ns.EntityBehaviors.ExecuteBehavior("BattlePet", self.id, "IsActive", self)
            end

            local _, petGUID = C_PetJournal.FindPetIDByName(self.name)
            if not petGUID then return false end
            local isSummoned = C_PetJournal.IsCurrentlySummoned(petGUID)
            return isSummoned
        end,
        IsReady = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("BattlePet", self.id, "IsReady") then
                return ns.EntityBehaviors.ExecuteBehavior("BattlePet", self.id, "IsReady", self)
            end

            if not ns.EntityBehaviors.BattlePet.IsKnown(self) then return false end
            local _, petGUID = C_PetJournal.FindPetIDByName(self.name)
            local cooldown = C_PetJournal.GetPetCooldownByGUID(petGUID)
            return cooldown == 0
        end,
    },

    Totem = {
        IsActive = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Totem", self.id, "IsActive") then
                return ns.EntityBehaviors.ExecuteBehavior("Totem", self.id, "IsActive", self)
            end

            if not self.TotemType then return false end
            local _, totemName, startTime = GetTotemInfo(self.TotemType)
            return totemName ~= nil and startTime > 0
        end,
        RemainingTime = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Totem", self.id, "RemainingTime") then
                return ns.EntityBehaviors.ExecuteBehavior("Totem", self.id, "RemainingTime", self)
            end

            if not self.TotemType then return 0 end
            local _, _, startTime, duration = GetTotemInfo(self.TotemType)
            if not startTime or not duration then return 0 end
            return max(0, (startTime + duration) - NAG:NextTime())
        end,
    },

    Enchant = {
        -- Enchant-specific behaviors that override Spell behaviors
        GetMainHandInfo = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Enchant", self.id, "GetMainHandInfo") then
                return ns.EntityBehaviors.ExecuteBehavior("Enchant", self.id, "GetMainHandInfo", self)
            end

            local hasMainHandEnchant, mainHandExpiration, mainHandCharges, mainHandEnchantID = GetWeaponEnchantInfo()
            if not hasMainHandEnchant then return nil end
            return {
                expiration = mainHandExpiration / 1000,
                charges = mainHandCharges,
                enchantId = mainHandEnchantID
            }
        end,
        GetOffHandInfo = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Enchant", self.id, "GetOffHandInfo") then
                return ns.EntityBehaviors.ExecuteBehavior("Enchant", self.id, "GetOffHandInfo", self)
            end

            local _, _, _, _, hasOffHandEnchant, offHandExpiration, offHandCharges, offHandEnchantID =
                GetWeaponEnchantInfo()
            if not hasOffHandEnchant then return nil end
            return {
                expiration = offHandExpiration / 1000,
                charges = offHandCharges,
                enchantId = offHandEnchantID
            }
        end,
        IsActive = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Enchant", self.id, "IsActive") then
                return ns.EntityBehaviors.ExecuteBehavior("Enchant", self.id, "IsActive", self)
            end

            local mainHandInfo = ns.EntityBehaviors.Enchant.GetMainHandInfo(self)
            local offHandInfo = ns.EntityBehaviors.Enchant.GetOffHandInfo(self)
            return (mainHandInfo and mainHandInfo.enchantId == self.enchantId) or
                (offHandInfo and offHandInfo.enchantId == self.enchantId)
        end,
        RemainingTime = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Enchant", self.id, "RemainingTime") then
                return ns.EntityBehaviors.ExecuteBehavior("Enchant", self.id, "RemainingTime", self)
            end

            local mainHandInfo = ns.EntityBehaviors.Enchant.GetMainHandInfo(self)
            local offHandInfo = ns.EntityBehaviors.Enchant.GetOffHandInfo(self)

            if mainHandInfo and mainHandInfo.enchantId == self.id then
                return mainHandInfo.expiration
            end

            if offHandInfo and offHandInfo.enchantId == self.id then
                return offHandInfo.expiration
            end

            return 0
        end,
    },

    PetAura = {
        -- PetAura-specific behaviors that extend Aura behaviors
        IsActive = function(self, unit)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("PetAura", self.id, "IsActive") then
                return ns.EntityBehaviors.ExecuteBehavior("PetAura", self.id, "IsActive", self, unit)
            end

            unit = unit or "pet"
            if not ns.EntityBehaviors._helpers.ValidatePet(unit) then return false end
            return NAG:UnitAura(unit, self.id) ~= false
        end,
        GetExpirationTime = function(self, unit)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("PetAura", self.id, "GetExpirationTime") then
                return ns.EntityBehaviors.ExecuteBehavior("PetAura", self.id, "GetExpirationTime", self, unit)
            end

            unit = unit or "pet"
            if not ns.EntityBehaviors._helpers.ValidatePet(unit) then return 0 end
            local aura = NAG:UnitAura(unit, self.id)
            return aura and aura.expirationTime or 0
        end,
        GetStacks = function(self, unit)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("PetAura", self.id, "GetStacks") then
                return ns.EntityBehaviors.ExecuteBehavior("PetAura", self.id, "GetStacks", self, unit)
            end

            unit = unit or "pet"
            if not ns.EntityBehaviors._helpers.ValidatePet(unit) then return 0 end
            local aura = NAG:UnitAura(unit, self.id)
            return aura and aura.count or 0 -- For pet auras, return 0 if no stacks (unlike regular Auras that return 1)
        end,
        RemainingTime = function(self, unit)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("PetAura", self.id, "RemainingTime") then
                return ns.EntityBehaviors.ExecuteBehavior("PetAura", self.id, "RemainingTime", self, unit)
            end

            unit = unit or "pet"
            if not ns.EntityBehaviors._helpers.ValidatePet(unit) then return 0 end
            local aura = NAG:UnitAura(unit, self.id)
            if not aura or not aura.expirationTime then return 0 end
            return max(0, aura.expirationTime - NAG:NextTime())
        end,
    },
    Glyph = {
        IsKnown = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Glyph", self.id, "IsKnown") then
                return ns.EntityBehaviors.ExecuteBehavior("Glyph", self.id, "IsKnown", self)
            end

            return NAG:HasGlyph(self.id)
        end,
        IsActive = function(self)
            -- Check for custom override first
            if ns.EntityBehaviors.HasOverride("Glyph", self.id, "IsActive") then
                return ns.EntityBehaviors.ExecuteBehavior("Glyph", self.id, "IsActive", self)
            end

            return NAG:HasGlyph(self.id)
        end,
    },
}
