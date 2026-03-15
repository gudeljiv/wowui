--- @module "NAG.CustomBehaviorOverrides"
--- Dynamic behavior overrides for special spell cases
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ============================ LOCALIZE ============================

local _, ns = ...
local WoWAPI = ns.WoWAPI
local UnitExists = _G.UnitExists
local UnitHealth = _G.UnitHealth
local UnitHealthMax = _G.UnitHealthMax
local UnitPower = _G.UnitPower
local UnitPowerMax = _G.UnitPowerMax
local UnitName = _G.UnitName
local UnitIsPlayer = _G.UnitIsPlayer
local IsCurrentSpell = C_Spell and C_Spell.IsCurrentSpell or _G.IsCurrentSpell
local IsUsableSpell = C_Spell and C_Spell.IsSpellUsable or _G.IsUsableSpell

-- ============================ ADDON ACCESS ============================

--- @type NAG|AceAddon Main addon reference
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS ~~~~~~~~~~
--- @type Version
local Version

--- @type SpecCompat
local SpecCompat

-- ============================ MODULE CREATION ============================

--- @class CustomBehaviorOverrides: CoreModule
local CustomBehaviorOverrides = NAG:CreateModule("CustomBehaviorOverrides", {}, {
    moduleType = ns.MODULE_TYPES.HANDLER,
})

-- ============================ MODULE INITIALIZATION ============================

function CustomBehaviorOverrides:ModuleInitialize()
    Version = ns.Version
    SpecCompat = NAG:GetModule("SpecCompat")
    self:RegisterAllOverrides()
    self:Debug("CustomBehaviorOverrides initialized")
end

-- ============================ OVERRIDE REGISTRATION ============================

--- Register all custom behavior overrides
function CustomBehaviorOverrides:RegisterAllOverrides()
    self:RegisterSpellOverrides()
    self:RegisterAuraOverrides()
    self:RegisterItemOverrides()
end

--- Register spell-specific behavior overrides
function CustomBehaviorOverrides:RegisterSpellOverrides()

    -- Unholy Death Knight Gargoyle (49206) - MoP cooldown-based simulation
    ns.EntityBehaviors.RegisterOverride("Spell", 49206, "IsActive", function(self, unit)
        if Version:IsMoP() and NAG.CLASS_FILENAME == "DEATHKNIGHT" then
            if SpecCompat then
                local currentSpec = SpecCompat:GetCurrentSpecIndex()
                if currentSpec then
                    local specName = SpecCompat:GetSpecName(currentSpec)
                    if specName == "Unholy" then
                        local timeToReady = NAG:SpellTimeToReady(49206)
                        -- Aura is active if time to ready > 150 seconds (180 - 30)
                        return timeToReady > 150
                    end
                end
            end
        end
        return false
    end)

    -- Blood Tap (45529) - MoP special requirements
    ns.EntityBehaviors.RegisterOverride("Spell", 45529, "SpellCanCast", function(self, tolerance)
        if not NAG:IsKnownSpell(self.id) then return false end
        if Version:IsMoP() then
            local boneShieldStacks = NAG:AuraNumStacks(114851)
            local hasNoRunes = (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0 or
                              NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0 or
                              NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0)
            return boneShieldStacks >= 5 and hasNoRunes and NAG:IsReadySpell(self.id, tolerance)
        end
        return NAG:IsReadySpell(self.id, tolerance)
    end)

    -- Plague Leech (123693) - MoP special requirements
    ns.EntityBehaviors.RegisterOverride("Spell", 123693, "SpellCanCast", function(self, tolerance)
        if not NAG:IsKnownSpell(self.id) then return false end
        if Version:IsMoP() then
            local hasDoTs = NAG:DotIsActive(59921) and NAG:DotIsActive(59879)
            local hasNoRunes = (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 0 or
                              NAG:CurrentRuneCount(NAG.Types.RuneType.RuneFrost) == 0 or
                              NAG:CurrentRuneCount(NAG.Types.RuneType.RuneBlood) == 0)
            return hasDoTs and hasNoRunes and NAG:IsReadySpell(self.id, tolerance)
        end
        return NAG:IsReadySpell(self.id, tolerance)
    end)

    -- Dark Infusion (63560) - requires 5 stacks of Shadow Infusion (49572)
    -- FIXED: Match main Death Knight SpellCanCast logic - check IsReadySpell with tolerance FIRST
    -- When tolerance > 0, IsUsableSpell failures are assumed to be cooldown-related (already handled)
    ns.EntityBehaviors.RegisterOverride("Spell", 63560, "SpellCanCast", function(self, tolerance)
        if not NAG:IsKnownSpell(self.id) then return false end

        local stacks = NAG:AuraNumStacks(49572)
        if stacks < 5 then return false end

        -- Check cooldown readiness with tolerance FIRST (allows spells within tolerance to be considered ready)
        if not NAG:IsReadySpell(self.id, tolerance) then return false end

        -- Then check game usability (range/shape/vehicle/etc.) - required but doesn't respect tolerance
        -- When tolerance > 0, IsUsableSpell failures are assumed to be cooldown-related and ignored
        -- Only fail if tolerance is 0 (spell must be usable right now)
        local usable = IsUsableSpell(self.id)
        if not usable and tolerance == 0 then return false end

        return true
    end)

    -- Revenge (6572) - Warrior special usability check
    ns.EntityBehaviors.RegisterOverride("Spell", 6572, "SpellCanCast", function(self, tolerance)
        if not NAG:IsKnownSpell(self.id) then return false end
        if NAG.CLASS_FILENAME == "WARRIOR" then
            -- High tolerance bypass (preserve original logic)
            if tolerance and tolerance > 6 then
                return true
            end

            if not NAG:HasRage(self.id) then return false end
            local usable = IsUsableSpell(self.id)
            return usable and not IsCurrentSpell(6572) and NAG:IsReadySpell(self.id, tolerance)
        end
        return NAG:IsReadySpell(self.id, tolerance)
    end)

    -- Overpower (7384) and Rend (772) - Warrior spells that bypass IsUsableSpell check
    ns.EntityBehaviors.RegisterOverride("Spell", {7384, 772}, "SpellCanCast", function(self, tolerance)
        if not NAG:IsKnownSpell(self.id) then return false end
        if NAG.CLASS_FILENAME == "WARRIOR" then
            if not NAG:HasRage(self.id) then return false end
            return NAG:IsReadySpell(self.id, tolerance)
        end
        return NAG:IsReadySpell(self.id, tolerance)
    end)

    -- Judgement (20271) - TBC requires an active seal
    -- Data note: `NAG/tbc/data/SpellRequirements.lua` marks Judgement as `casterAuraState = 5`,
    -- but RequirementsChecker currently does not evaluate `casterAuraState`.
    -- In-game, Judgement's seal prerequisite is reflected by spell usability, so we enforce it here.
    ns.EntityBehaviors.RegisterOverride("Spell", 20271, "SpellCanCast", function(self, tolerance)
        if not NAG:IsKnownSpell(self.id) then return false end

        -- Only enforce this special rule for TBC Paladins
        if not (Version and Version.IsTBC and Version:IsTBC()) or NAG.CLASS_FILENAME ~= "PALADIN" then
            return NAG:IsReadySpell(self.id, tolerance)
        end

        -- Respect cooldown/tolerance like other overrides do
        if not NAG:IsReadySpell(self.id, tolerance) then
            return false
        end

        -- Seal prerequisite: without an active seal, Judgement should not be usable.
        -- We intentionally do NOT ignore this even when tolerance > 0.
        local usable = IsUsableSpell(self.id)
        return usable == true
    end)

    -- Tigereye Brew (116740, 1247275) - Monk chi requirement
    ns.EntityBehaviors.RegisterOverride("Spell", {116740, 1247275}, "SpellCanCast", function(self, tolerance)
        if not NAG:IsKnownSpell(self.id) then return false end
        if NAG.CLASS_FILENAME == "MONK" then
            -- Handle both spell IDs with their respective aura stacks
            if self.id == 116740 then
                return NAG:AuraNumStacks(125195) >= 1 and NAG:IsReadySpell(self.id, tolerance)
            elseif self.id == 1247275 then
                return NAG:AuraNumStacks(1247279) >= 1 and NAG:IsReadySpell(self.id, tolerance)
            end
        end
        return NAG:IsReadySpell(self.id, tolerance)
    end)

    -- Touch of Death (115080) - Monk target validation with health comparison and training dummy support
    ns.EntityBehaviors.RegisterOverride("Spell", 115080, "SpellCanCast", function(self, tolerance)
        if not NAG:IsKnownSpell(self.id) then return false end
        if NAG.CLASS_FILENAME == "MONK" then
            if not UnitExists("target") then return false end
            if UnitIsPlayer("target") then return false end

            local playerHealth = UnitHealth("player")
            local targetHealth = UnitHealth("target")

            -- Use unified encounter timer system for training dummy simulation
            -- This provides the same source of truth as other health-related functions
            if ns.IsTrainingDummy() then
                -- Check if encounter timer is enabled and we have valid encounter data
                if NAG.db.global.enableEncounterTimer then
                    local remainingPercent = NAG:RemainingTimePercent()
                    if remainingPercent and remainingPercent > 0 and remainingPercent < 7777 then
                        -- Use the simulated target health percentage from encounter timer
                        -- Convert percentage to absolute health value for comparison
                        local maxHealth = UnitHealthMax("target") or 1
                        targetHealth = (remainingPercent / 100) * maxHealth
                    end
                end
            end

            -- Target must have equal or less health than player
            return targetHealth <= playerHealth and NAG:IsReadySpell(self.id, tolerance)
        end
        return NAG:IsReadySpell(self.id, tolerance)
    end)

    -- Renewing Mist (115151) - Monk chi check with overlay callback
    ns.EntityBehaviors.RegisterOverride("Spell", 115151, "SpellCanCast", function(self, tolerance)
        if not NAG:IsKnownSpell(self.id) then return false end
        if NAG.CLASS_FILENAME == "MONK" then
            if not NAG:HasChi(self.id) then return false end

            -- Renewing Mist (REM) overlay gating similar to pooling overlay
            -- Show the next REM target name while REM is castable, for Monks only
            if NAG:IsReadySpell(self.id, tolerance) and NAG.RemOverlayTickPrevalidated then
                NAG:RemOverlayTickPrevalidated()
            end

            return NAG:IsReadySpell(self.id, tolerance)
        end
        return NAG:IsReadySpell(self.id, tolerance)
    end)

    -- Storm, Earth and Fire (138228) - MoP special case for Monk
    if Version:IsMoP() and NAG.CLASS_FILENAME == "MONK" then
        ns.EntityBehaviors.RegisterOverride("Spell", 138228, "SpellIsKnown", function(self)
            return WoWAPI.IsSpellKnown(137639)
        end)
    end

    -- Sunfire (93402) - Cata special requirements for Druids
    if Version:IsCata() then
        ns.EntityBehaviors.RegisterOverride("Spell", 93402, "SpellIsKnown", function(self)
            if SpecCompat then
                local talentInfo = SpecCompat:GetTalentInfo(1, 20)
                if talentInfo then
                    local currRank = talentInfo.rank or 0
                    return currRank >= 1 and UnitPower("player", Enum.PowerType.Balance) > 0
                end
            end
            return false
        end)
    end

    -- Ascendance (114049) - Shaman transformation spell with unusual cooldown behavior
    -- The spell doesn't go on cooldown until the buff expires, so we need to check buff state
    ns.EntityBehaviors.RegisterOverride("Spell", 114049, "IsReady", function(self, tolerance)
        if NAG.CLASS_FILENAME == "SHAMAN" then
            -- Check if Ascendance buff is currently active
            local isActive = NAG:AuraIsActive(self.id, "player", false)
            if isActive then
                return false -- Ascendance buff is active, spell should not be available
            end
        end

        -- Fall back to normal cooldown check
        local cdInfo = WoWAPI.GetSpellCooldown(self.id)
        if cdInfo then
            local start = cdInfo.startTime or 0
            local duration = cdInfo.duration or 0
            return start + duration - (tolerance or 0) <= NAG:NextTime()
        end
        return false
    end)

    -- Ascendance-related spells - Known only during Ascendance transformation (Elemental)
    -- 115356 = Stormblast (Enhancement), 114074 = Lava Beam (Elemental, replaces Chain Lightning)
    for _, spellId in ipairs({115356, 114074}) do
        ns.EntityBehaviors.RegisterOverride("Spell", spellId, "SpellIsKnown", function(self)
            if NAG.CLASS_FILENAME == "SHAMAN" and Version:IsMoP() then
                local ascendanceActive = NAG:AuraIsActive(114049, "player", false) or
                                       NAG:AuraIsActive(114051, "player", false)
                return ascendanceActive
            end
            return false
        end)
    end


    -- Ambush (8676) and Backstab (14183) - Rogue stealth requirements
    -- REVERTED: Keeping in SpellCanCast due to complex pooling interaction

    -- Soul Swap (86121) - Warlock special requirements
    -- Can only cast if Soulburn (74434) is active OR any of the three DoTs are active on target
    ns.EntityBehaviors.RegisterOverride("Spell", 86121, "SpellCanCast", function(self, tolerance)
        if not NAG:IsKnownSpell(self.id) then return false end
        if NAG.CLASS_FILENAME == "WARLOCK" then
            -- Can cast if Soulburn is active OR any DoT is active
            if NAG:AuraIsActive(74434) or NAG:DotIsActive(172) or NAG:DotIsActive(30108) or NAG:DotIsActive(980) then
                return NAG:IsReadySpell(self.id, tolerance)
            end
            return false
        end
        return NAG:IsReadySpell(self.id, tolerance)
    end)

    -- Exorcism (27138) - TBC Paladin: Only castable on UNDEAD or DEMON targets
    ns.EntityBehaviors.RegisterOverride("Spell", 27138, "SpellCanCast", function(self, tolerance)
        if not NAG:IsKnownSpell(self.id) then return false end
        if Version:IsTBC() and NAG.CLASS_FILENAME == "PALADIN" then
            if not UnitExists("target") then
                return false
            end

            -- Check if target is UNDEAD or DEMON
            local isUndead = NAG:TargetMobType(NAG.Types.MobType.Undead)
            local isDemon = NAG:TargetMobType(NAG.Types.MobType.Demon)

            if not isUndead and not isDemon then
                return false
            end

            return NAG:IsReadySpell(self.id, tolerance)
        end
        return NAG:IsReadySpell(self.id, tolerance)
    end)
end

--- Register aura-specific behavior overrides
function CustomBehaviorOverrides:RegisterAuraOverrides()
    -- Rune of Re-Origination: map ICD checks to proc aura
    ns.EntityBehaviors.RegisterOverride("Spell", 139120, "AuraInternalCooldown", function(self, sourceUnit)
        local SpellTrackingManager = NAG:GetModule("SpellTrackingManager", true)
        if not SpellTrackingManager then return 0 end
        return SpellTrackingManager:GetICDInfo(139116) or 0
    end)
end

--- Register item-specific behavior overrides
function CustomBehaviorOverrides:RegisterItemOverrides()
    -- Honor Among Thieves ICD (51701 -> 51699) - Spell ICD override
    ns.EntityBehaviors.RegisterOverride("Spell", {51701, 51699}, "AuraInternalCooldown", function(self, sourceUnit)
        local cdInfo = WoWAPI.GetSpellCooldown(51699)
        if cdInfo then
            local start = cdInfo.startTime or 0
            local duration = cdInfo.duration or 0
            if start > 0 and duration > 0 then
                local currentTime = NAG:NextTime()
                local cooldownEnd = start + duration
                return math.max(0, cooldownEnd - currentTime)
            end
        end
        return 0
    end)
end

-- ============================ PUBLIC API ============================

--- Register a custom behavior override
--- @param entityType string The entity type (Spell, Aura, Item, etc.)
--- @param entityIdOrTable number|table The entity ID or table of entity IDs
--- @param behaviorName string The behavior name (IsActive, SpellCanCast, etc.)
--- @param overrideFunction function The override function
function CustomBehaviorOverrides:RegisterOverride(entityType, entityIdOrTable, behaviorName, overrideFunction)
    ns.EntityBehaviors.RegisterOverride(entityType, entityIdOrTable, behaviorName, overrideFunction)

    -- Log all registered entities for debugging
    local entityIds = type(entityIdOrTable) == "table" and entityIdOrTable or {entityIdOrTable}
    for _, entityId in pairs(entityIds) do
        self:Debug("Registered override: %s[%d].%s", entityType, entityId, behaviorName)
    end
end

--- Unregister a custom behavior override
--- @param entityType string The entity type
--- @param entityIdOrTable number|table The entity ID or table of entity IDs
--- @param behaviorName string The behavior name
function CustomBehaviorOverrides:UnregisterOverride(entityType, entityIdOrTable, behaviorName)
    ns.EntityBehaviors.UnregisterOverride(entityType, entityIdOrTable, behaviorName)

    -- Log all unregistered entities for debugging
    local entityIds = type(entityIdOrTable) == "table" and entityIdOrTable or {entityIdOrTable}
    for _, entityId in pairs(entityIds) do
        self:Debug("Unregistered override: %s[%d].%s", entityType, entityId, behaviorName)
    end
end

--- Register multiple custom behavior overrides (alias for RegisterOverride with table)
--- @param entityType string The entity type (Spell, Aura, Item, etc.)
--- @param entityIds table The table of entity IDs
--- @param behaviorName string The behavior name (IsActive, SpellCanCast, etc.)
--- @param overrideFunction function The override function
function CustomBehaviorOverrides:RegisterOverrides(entityType, entityIds, behaviorName, overrideFunction)
    return self:RegisterOverride(entityType, entityIds, behaviorName, overrideFunction)
end

--- Unregister multiple custom behavior overrides (alias for UnregisterOverride with table)
--- @param entityType string The entity type
--- @param entityIds table The table of entity IDs
--- @param behaviorName string The behavior name
function CustomBehaviorOverrides:UnregisterOverrides(entityType, entityIds, behaviorName)
    return self:UnregisterOverride(entityType, entityIds, behaviorName)
end

--- Check if an entity has a custom behavior override
--- @param entityType string The entity type
--- @param entityId number The entity ID
--- @param behaviorName string The behavior name
--- @return boolean True if override exists
function CustomBehaviorOverrides:HasOverride(entityType, entityId, behaviorName)
    return ns.EntityBehaviors.HasOverride(entityType, entityId, behaviorName)
end

--- Get all registered overrides for debugging
--- @return table Table of all registered overrides
function CustomBehaviorOverrides:GetAllOverrides()
    return ns.EntityBehaviors._overrides
end

-- ============================ MODULE EXPOSURE ============================

-- Expose functions on NAG namespace for easy access
NAG.RegisterBehaviorOverride = function(self, entityType, entityIdOrTable, behaviorName, overrideFunction)
    return CustomBehaviorOverrides:RegisterOverride(entityType, entityIdOrTable, behaviorName, overrideFunction)
end

NAG.UnregisterBehaviorOverride = function(self, entityType, entityIdOrTable, behaviorName)
    return CustomBehaviorOverrides:UnregisterOverride(entityType, entityIdOrTable, behaviorName)
end

NAG.RegisterBehaviorOverrides = function(self, entityType, entityIds, behaviorName, overrideFunction)
    return CustomBehaviorOverrides:RegisterOverrides(entityType, entityIds, behaviorName, overrideFunction)
end

NAG.UnregisterBehaviorOverrides = function(self, entityType, entityIds, behaviorName)
    return CustomBehaviorOverrides:UnregisterOverrides(entityType, entityIds, behaviorName)
end

NAG.HasBehaviorOverride = function(self, entityType, entityId, behaviorName)
    return CustomBehaviorOverrides:HasOverride(entityType, entityId, behaviorName)
end
