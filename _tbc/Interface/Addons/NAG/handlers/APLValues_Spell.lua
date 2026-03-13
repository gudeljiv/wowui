--- @module "APLValues_Spell"
--- Spell-related APL value functions for the NAG addon
---
--- This module provides utility functions for spell checking, cooldowns, and spell-related operations.
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
local Version = ns.Version

local Types = ns.Types

-- Lua APIs (WoW optimized where available)
local GetItemCount = C_Item and C_Item.GetItemCount or _G.GetItemCount
local GetTime = _G.GetTime
local UnitExists = _G.UnitExists
local UnitPower = _G.UnitPower
local UnitPowerMax = _G.UnitPowerMax
local UnitName = _G.UnitName
local UnitCanAttack = _G.UnitCanAttack
local UnitCastingInfo = _G.UnitCastingInfo
local UnitChannelInfo = _G.UnitChannelInfo
local UnitPowerType = _G.UnitPowerType
local GetShapeshiftForm = _G.GetShapeshiftForm
local GetItemCooldown = C_Container and C_Container.GetItemCooldown or _G.GetItemCooldown
local IsUsableSpell = C_Spell and C_Spell.IsSpellUsable or _G.IsUsableSpell

local format = string.format
local max = math.max


local type = type
local tostring = tostring
local tonumber = tonumber

-- ============================ MODULE CACHING (PERFORMANCE) ============================
-- Cache frequently accessed modules to avoid GetModule overhead in hot paths
local DataManager = ns.DataManager
local StateManager = ns.StateManager
local SpellbookManager = ns.SpellbookManager
local SpellTrackingManager = ns.SpellTrackingManager

-- ============================ CONSTANTS ============================
-- Cache StanceType lookup to avoid string allocations
local STANCE_TYPE = Types.StanceType or Types:GetType("StanceType")

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

-- ============================= NAG-SPECIFIC DEBUFF FUNCTIONS =============================
--TODO: Remove this after testing consolidated method works.  Need to update schemamodifications as well as APLParser
--- Gets the number of stacks of a specific debuff on the player.
--- @param spellId number The ID of the spell to check.
--- @return number The number of stacks of the debuff, or 0 if not found.
--- @usage NAG:DebuffNumStacks(73643) >= x
function NAG:DebuffNumStacks(spellId)
    if not spellId then return 0 end
    local lookupId = spellId
    -- Resolve to spellbook ID for aura lookup (entity lookup stays by original for schema)
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then
            lookupId = resolved
        end
    end
    local entry = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
    if not entry then
        self:Error(format("DebuffNumStacks: Spell ID not found: %s (spellId type: %s)",
            tostring(spellId), type(spellId)))
        return 0
    end

    local aura = NAG:UnitDebuffGlobal("player", lookupId)
    return aura and aura.count or 0
end

--TODO: Remove this after testing consolidated method works.  Need to update schemamodifications as well as APLParser
--- Checks if a debuff spell is active on the player or specified unit.
--- @param spellId number The ID of the spell.
--- @param targetUnit? string The unit to check (defaults to "player").
--- @return boolean True if the debuff is active, false otherwise.
--- @usage NAG:DebuffIsActive(73643)
function NAG:DebuffIsActive(spellId, targetUnit)
    if not spellId then return false end
    targetUnit = targetUnit or "player"
    -- Resolve to spellbook ID so we check the aura the player actually has
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then
            spellId = resolved
        end
    end
    return NAG:UnitDebuffGlobal(targetUnit, spellId) ~= false
end

--- Checks if a spell, trinket, tinker, or item is known to the player.
--- Resolves APL/schema spell ID to spellbook ID so one implementation works for all call sites.
--- @param spellId number The ID of the spell, trinket, tinker, or item.
--- @return boolean True if the ID is known, false otherwise.
--- @usage NAG:SpellIsKnown(73643) or NAG:SpellIsKnown(12345)
function NAG:SpellIsKnown(spellId)
    if not spellId then return false end

    -- Validate ID
    if not tonumber(spellId) then
        self:Error(format("SpellIsKnown: ID %s is not a number", tostring(spellId)))
        return false
    end

    -- Resolve to spellbook ID so we check the spell the player actually has
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then
            spellId = resolved
        end
    end

    -- Check for custom behavior override first (O(1) lookup)
    if ns.EntityBehaviors and ns.EntityBehaviors.HasOverride and ns.EntityBehaviors.HasOverride("Spell", spellId, "SpellIsKnown") then
        return ns.EntityBehaviors.ExecuteBehavior("Spell", spellId, "SpellIsKnown", {id = spellId})
    end

    -- Try to find entity in DataManager
    local entity = DataManager:Get(spellId, DataManager.EntityTypes.SPELL) or
        DataManager:Get(spellId, DataManager.EntityTypes.ITEM)

    if not entity then
        -- Fallback: if the ID isn’t registered in DataManager, still check via spellbook by ID
        return self:IsKnownSpell(spellId)
    end

    if entity.IsItem then
        return entity:IsKnown()
    elseif entity.IsSpell then
        if entity.flags.tierset then
            -- Route to tier set spell validation (checks if player has enough tier pieces)
            return self:IsKnownTierset(spellId)
        elseif entity.flags.enchant then
            return self:IsKnownEnchant(spellId)
        elseif entity.flags.battlepet then
            return entity:IsKnown()
        elseif entity.flags.glyph then
            return self:HasGlyph(spellId)
        elseif entity.flags.talent then
            local talent = DataManager:GetTalentBySpellId(spellId)
            if talent then
                local hasTalent = StateManager:HasTalent(talent.talentId)
                if hasTalent then
                    return true
                end
                -- Fallback: trust spellbook/API if talent detection disagrees
                return self:IsKnownSpell(spellId)
            end
        elseif entity.flags.tinker then
            return self:IsKnownTinker(spellId)
        else
            return self:IsKnownSpell(spellId)
        end
    end

    self:Info(format("SpellIsKnown: ID %d not found", spellId))
    return false
end

NAG.IsKnown = NAG.SpellIsKnown

--- Checks if a spell is known, with special handling for certain classes and expansions.
--- Resolves APL/schema spell ID to spellbook ID so we check the correct spell.
--- @param spellId number The ID of the spell.
--- @return boolean True if the spell is known, false otherwise.
--- @usage NAG:IsKnownSpell(130735)
function NAG:IsKnownSpell(spellId)
    if not spellId then return false end
    if not tonumber(spellId) then return false end

    -- Resolve to spellbook ID so we check the spell the player actually has
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then
            spellId = resolved
        end
    end

    -- Check for custom behavior override first (O(1) lookup)
    if ns.EntityBehaviors and ns.EntityBehaviors.HasOverride and ns.EntityBehaviors.HasOverride("Spell", spellId, "SpellIsKnown") then
        return ns.EntityBehaviors.ExecuteBehavior("Spell", spellId, "SpellIsKnown", {id = spellId})
    end

    return SpellbookManager:IsSpellKnown(spellId)
end

--- Checks if a spell is a known enchant.
--- @param spellId number The ID of the spell.
--- @return boolean True if the spell is a known enchant, false otherwise.
--- @usage NAG:IsKnownEnchant(73643)
function NAG:IsKnownEnchant(spellId)
    if not spellId then return false end

    -- Use StateManager's cached enchant data for efficient checking
    local stateResult = StateManager:IsKnownEnchant(spellId)
    if stateResult ~= nil then
        return stateResult
    end

    -- Fallback to unified IsSpellKnown check for compatibility (both player and pet spells)
    if WoWAPI.IsSpellKnown(spellId) or WoWAPI.IsSpellKnown(spellId, true) then
        return true
    end
end

--- Checks if a tier set spell is known (player has enough tier pieces equipped).
--- @param spellId number The ID of the tier set spell.
--- @return boolean True if the player has enough tier pieces equipped for this spell, false otherwise.
--- @usage NAG:IsKnownTierset(123078)
function NAG:IsKnownTierset(spellId)
    if not spellId then return false end

    -- Get tier set information (this validates the spell is a tier set)
    local tierSet = DataManager:GetTierSetForSpell(spellId)
    if not tierSet then
        return false
    end

    -- Get spell entity to access setBonusCount
    local spell = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
    if not spell or not spell.setBonusCount then
        return false
    end

    -- Prefer checking the specific tiersetId piece count (most accurate, and doesn't depend on tier indexing)
    local tiersetId = tierSet.tiersetId or tierSet.id
    local hasEnoughPieces
    if tiersetId then
        hasEnoughPieces = StateManager:HasTierSetPieceCount(tiersetId, spell.setBonusCount)
    else
        -- Fallback: tier-wide check (less precise, but keeps backward compatibility)
        hasEnoughPieces = StateManager:HasTierCount(tierSet.tier, spell.setBonusCount)
    end

    if self.debug then
        self:Debug(format("IsKnownTierset: Spell %d (%s) - TierSetId: %s, Tier: %s, Required: %dpc, Has: %s",
            spellId,
            spell.name or "Unknown",
            tostring(tiersetId),
            tierSet.tier or "Unknown",
            spell.setBonusCount,
            tostring(hasEnoughPieces)))
    end

    return hasEnoughPieces
end

--- Checks if a spell, trinket, tinker, or item is ready to be used.
--- @param id number The ID of the spell, trinket, tinker, or item.
--- @return boolean True if the ID is ready, false otherwise.
--- @usage NAG:IsReady(12345)
function NAG:IsReady(id)
    if not id then return false end

    -- Validate ID
    if not tonumber(id) then
        self:Error(format("IsReady: ID %s is not a number", tostring(id)))
        return false
    end

    -- Resolve identity once so spell/item ambiguity is handled consistently (DataManager is single source).
    local identity = DataManager.GetIdentity and DataManager:GetIdentity(id, "readiness") or nil
    local entity = identity and identity.entity or (DataManager:Get(id, DataManager.EntityTypes.SPELL) or
        DataManager:Get(id, DataManager.EntityTypes.ITEM))

    if not entity then
        -- Fallback: Try to check readiness directly via WoW API
        -- First try as a spell (matches IsReadySpell pattern)
        local spellCdInfo = WoWAPI.GetSpellCooldown(id)
        if spellCdInfo then
            -- Valid spell cooldown found, check if ready (matches IsReadySpell logic)
            local isReady = spellCdInfo.startTime + spellCdInfo.duration <= NAG:NextTime()
            if self.debug then
                self:Debug("IsReady: ID %d not in DataManager, using fallback spell check: %s", id, tostring(isReady))
            end
            return isReady
        end

        -- Try as an item (check if item exists and get cooldown)
        -- Use the same pattern as EntityBehaviors.Item.IsReady
        if GetItemCount and (GetItemCount(id) > 0 or (C_Item and C_Item.IsEquippedItem and C_Item.IsEquippedItem(id))) then
            local itemStart, itemDuration = GetItemCooldown(id)
            if itemStart and itemDuration then
                local isReady = (itemStart == 0 and itemDuration == 0) or (itemStart + itemDuration <= NAG:NextTime())
                if self.debug then
                    self:Debug("IsReady: ID %d not in DataManager, using fallback item check: %s", id, tostring(isReady))
                end
                return isReady
            end
        end

        -- ID not found in DataManager and not a valid spell/item via API
        -- Only log once per ID to reduce noise
        if not self._missingIdWarnings then
            self._missingIdWarnings = {}
        end
        if not self._missingIdWarnings[id] then
            self._missingIdWarnings[id] = true
            self:Warn("IsReady: ID %d not found in DataManager and not accessible via WoW API", id)
        end
        return false
    end

    if entity.IsItem then
        return entity:IsReady()
    elseif entity.IsSpell then
        local effectiveSpellId = (identity and identity.spellId) or id
        if entity.flags.enchant then
            return entity:IsReady()
        elseif entity.flags.battlepet then
            return entity:IsReady()
        elseif entity.flags.tinker then
            return self:IsReadyTinker(effectiveSpellId)
        else
            return self:IsReadySpell(effectiveSpellId)
        end
    end

    -- Entity found but type not recognized
    self:Error("IsReady: ID %d found but entity type not recognized", id)
    return false
end


--- Checks if a spell is ready to cast based on cooldown and optional tolerance.
--- Resolves APL/schema spell ID to spellbook ID so we check the correct spell's cooldown.
--- @param spellId number The ID of the spell.
--- @param tolerance? number The tolerance in seconds for the spell cooldown.
--- @return boolean True if the spell is ready, false otherwise.
--- @usage NAG:IsReadySpell(73643, 1)
function NAG:IsReadySpell(spellId, tolerance)
    local Version = ns.Version
    if not spellId then
        self:Error("IsReadySpell: spellId is nil")
        return false
    end

    -- Resolve to spellbook ID so we check the spell the player actually has
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then
            spellId = resolved
        end
    end

    -- Check for custom behavior override first (O(1) lookup)
    if ns.EntityBehaviors and ns.EntityBehaviors.HasOverride and ns.EntityBehaviors.HasOverride("Spell", spellId, "IsReady") then
        return ns.EntityBehaviors.ExecuteBehavior("Spell", spellId, "IsReady", {id = spellId})
    end

    -- Proactive CD override for TBC Hunter MS: WoW API lags; we set CD on UNIT_SPELLCAST_SENT.
    if (Version and Version.IsTBC and Version:IsTBC()) and _G.UnitClassBase and _G.UnitClassBase("player") == "HUNTER" then
        if NAG._FillerCdOverride and (spellId == 27021 or spellId == 2643) then
            local overrideEnd = NAG._FillerCdOverride[27021] or NAG._FillerCdOverride[2643]
            if overrideEnd and overrideEnd > NAG:NextTime() then
                return false
            end
            if overrideEnd then
                NAG._FillerCdOverride[27021] = nil
                NAG._FillerCdOverride[2643] = nil
            end
        end
    end

    -- Tinker: use item cooldown so we only consider "ready" when the gloves are off CD (GetItemCooldown), not spell CD
    local StateManager = NAG:GetModule("StateManager", true)
    if StateManager and StateManager.GetTinkerInfoBySpellId then
        local ti = StateManager:GetTinkerInfoBySpellId(spellId)
        if ti and type(ti) == "table" and ti.itemId then
            return self:IsReadyTinker(spellId)
        end
    end

    tolerance = tolerance or 0
    if Version:IsMoP() then
        local spellInfo = WoWAPI.GetSpellInfo(spellId)
        if spellInfo and spellInfo.name then
            local spellInfo2 = WoWAPI.GetSpellInfo(spellInfo.name)
            if spellInfo2 and spellInfo2.name then
                spellId = spellInfo2.spellID
            end
        end
    end

    -- Treat cast-only spells as ready while they are actively casting/channeling.
    -- Some clients report cast lock through GetSpellCooldown during the cast window.
    local _, _, _, _, _, _, _, _, castingSpellId = UnitCastingInfo and UnitCastingInfo("player") or nil
    local _, _, _, _, _, _, _, channelingSpellId = UnitChannelInfo and UnitChannelInfo("player") or nil
    if castingSpellId == spellId or channelingSpellId == spellId then
        local baseCooldownMS = _G.GetSpellBaseCooldown and _G.GetSpellBaseCooldown(spellId)
        if type(baseCooldownMS) ~= "number" or baseCooldownMS <= 0 then
            return true
        end
    end

    local cdInfo = WoWAPI.GetSpellCooldown(spellId)
    if not cdInfo then
        return false
    end

    return cdInfo.startTime + cdInfo.duration - tolerance <= NAG:NextTime()
end
-- Reusable table for EntityBehaviors calls (avoid allocation in hot path)
local entityBehaviorArgs = {id = nil}

--- Checks if a spell is ready to cast, considering class-specific resource requirements and pooling.
--- Resolves APL/schema spell ID to the player's spellbook ID so one implementation works for all call sites.
--- @param spellId number The ID of the spell to check (APL or spellbook ID).
--- @param tolerance? number Optional tolerance in seconds.
--- @return boolean True if the spell can be cast, false otherwise.
--- @usage NAG:SpellCanCast(12345, 0.5)
function NAG:SpellCanCast(spellId, tolerance)
    local Version = ns.Version
    if not spellId then return false end

    -- Resolve to spellbook ID so icon/cooldown match the spell the player actually has (e.g. Blood Fury 20572 vs 33697)
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then
            spellId = resolved
        end
    end

    -- Check for custom behavior override first (O(1) lookup)
    if ns.EntityBehaviors and ns.EntityBehaviors.HasOverride and ns.EntityBehaviors.HasOverride("Spell", spellId, "SpellCanCast") then
        entityBehaviorArgs.id = spellId
        return ns.EntityBehaviors.ExecuteBehavior("Spell", spellId, "SpellCanCast", entityBehaviorArgs, tolerance)
    end

    -- Use IsKnown (SpellIsKnown) so enchant/tinker/item-use spells (e.g. 82174 glove) are considered known when equipped
    if not NAG:IsKnown(spellId) then return false end

    -- Mana Tap (Blood Elf, 28734) requires an attackable target that uses mana
    if spellId == 28734 then
        if not UnitExists("target") then
            return false
        end
        if not UnitCanAttack("player", "target") then
            return false
        end
        local manaType = (Enum and Enum.PowerType and Enum.PowerType.Mana) or 0
        local targetPowerType = select(1, UnitPowerType("target"))
        local targetMax = UnitPowerMax("target", targetPowerType or manaType) or 0
        if targetPowerType ~= manaType or targetMax <= 0 then
            return false
        end
    end


    if self.CLASS_FILENAME == "DEATHKNIGHT" then

        -- Death Coil (47541) can be free via Sudden Doom (81340); track the free-cast state
        local isDeathCoil = spellId == 47541
        local hasFreeDeathCoil = isDeathCoil and self:AuraIsActive(81340, "player", true)
        -- If the spell is not free, require runic power
        if not hasFreeDeathCoil and not self:HasRunicPower(spellId, tolerance) then
            return false
        end

        -- Check cooldown readiness with tolerance FIRST (allows spells within tolerance to be considered ready)
        if not self:IsReadySpell(spellId, tolerance) then
            return false
        end

        -- Then check game usability (range/shape/vehicle/etc.) - required but doesn't respect tolerance
        -- When tolerance > 0, IsUsableSpell failures are assumed to be cooldown-related and ignored
        -- Only fail if tolerance is 0 (spell must be usable right now)
        local usable = IsUsableSpell(spellId)
        if not usable and tolerance == 0 then
            return false
        end

    elseif self.CLASS_FILENAME == "WARRIOR" then
        -- Allow pooling overlay for rage in Classic/TBC/Wrath only
        if Version and (Version:IsCata() or Version:IsMoP()) then
            if tolerance then
                if tolerance > 6 then
                    return true
                end
            end
            if not self:HasRage(spellId) then
                return false
            end
            return self:IsReadySpell(spellId, tolerance) and IsUsableSpell(spellId)
        end

        if tolerance then
            if tolerance > 6 then
                return true
            end
        end
        if not self:HasRage(spellId) and not NAG:IsSecondarySpell(spellId) then
            -- Only start pooling if not already pooling
            if not self.isPooling then
                self.isPooling = true
                NAG:Pooling()
            end
            return true
        elseif self.isPooling and not NAG:IsSecondarySpell(spellId) then
            self:StopPooling()
        end
        return self:IsReadySpell(spellId, tolerance) and IsUsableSpell(spellId)
    elseif self.CLASS_FILENAME == "DRUID" then
        local formId = GetShapeshiftForm()
        if formId == STANCE_TYPE.Bear then
            if not self:HasRage(spellId) then
                return false
            end
        elseif formId == STANCE_TYPE.Cat then
            if not self:HasComboPoints(spellId) then
                return false
            end
            local energyTolerance = (Version and Version.IsTBC and Version:IsTBC()) and self:GCDTimeToReady() or nil
            if not self:HasEnergy(spellId, energyTolerance) and not NAG:IsSecondarySpell(spellId) then
                -- Only start pooling if not already pooling
                if not self.isPooling then
                    self.isPooling = true
                    NAG:Pooling()
                end
                return true
            elseif self.isPooling and not NAG:IsSecondarySpell(spellId) then
                self:StopPooling()
            end
        end
        if not self:HasMana(spellId) then
            return false
        end
    elseif self.CLASS_FILENAME == "MONK" then
        if not self:HasChi(spellId) then
            return false
        end
    elseif self.CLASS_FILENAME == "ROGUE" then
        local energyTolerance = (Version and Version.IsTBC and Version:IsTBC()) and self:GCDTimeToReady() or nil
        if not self:HasEnergy(spellId, energyTolerance) and not NAG:IsSecondarySpell(spellId) then
            -- Only start pooling if not already pooling
            if not self.isPooling then
                self.isPooling = true
                NAG:Pooling()
            end

            if spellId == 8676 then
                return (self:AuraIsActive(1784) or self:AuraIsActive(58984) or self:AuraIsActive(11327) or self:AuraIsActive(145211) or self:AuraIsActive(115192)) and self:IsReadySpell(spellId, tolerance)
            elseif spellId == 14183 then
                return (self:AuraIsActive(1784) or self:AuraIsActive(58984) or self:AuraIsActive(11327) or self:AuraIsActive(115192)) and self:IsReadySpell(spellId, tolerance)
            end
            return true
        elseif self.isPooling and not NAG:IsSecondarySpell(spellId) then
            self:StopPooling()
        end
        -- Riposte (14251) is only usable for 6s after *you* parry an incoming attack (destGUID==player, missType PARRY).
        -- Do not use sourceGUID==player+PARRY (that would mean "your attack was parried" - wrong trigger).
        -- IsUsableSpell correctly reflects this window (TBC, Wrath, etc.)
        if spellId == 14251 then
            if IsUsableSpell then
                return self:IsReadySpell(spellId, tolerance) and IsUsableSpell(spellId)
            end
            return false
        end
        if not self:HasComboPoints(spellId) then
            return false
        end
        if spellId == 8676 then
            return (self:AuraIsActive(1784) or self:AuraIsActive(58984) or self:AuraIsActive(11327) or self:AuraIsActive(145211) or self:AuraIsActive(115192)) and self:IsReadySpell(spellId, tolerance)
        elseif spellId == 14183 then
            return (self:AuraIsActive(1784) or self:AuraIsActive(58984) or self:AuraIsActive(11327) or self:AuraIsActive(115192)) and self:IsReadySpell(spellId, tolerance)
        end
    elseif self.CLASS_FILENAME == "WARLOCK" then
        if not self:HasMana(spellId) or not self:HasSoulShards(spellId) then
            return false
        end
        if Version:IsMoP() and not self:HasBurningEmber(spellId) then
            return false
        end
    elseif self.CLASS_FILENAME == "PALADIN" then
        local hasMana = self:HasMana(spellId, tolerance)
        local hasManaNow = self:HasMana(spellId)
        local hasHolyPower = self:HasHolyPower(spellId)
        local soCId = (self.RetTwistGetSoCSealId and self:RetTwistGetSoCSealId()) or nil
        local twistId = (self.RetTwistGetTwistSealId and self:RetTwistGetTwistSealId()) or nil
        local isRetCoreManaOverlaySpell = (spellId == 20271) or (spellId == 35395)
            or (soCId and spellId == soCId)
            or (twistId and spellId == twistId)

        -- TBC Retribution only: keep showing core Ret actions even when mana-starved.
        -- Use one shared custom MANA overlay (pooling-style), mirroring warrior/rogue pooling flow:
        -- show/refresh while starved, clear when recovered.
        if Version and Version:IsTBC() and isRetCoreManaOverlaySpell then
            if (not hasManaNow) then
                if self.ShowManaOverlay then
                    self:ShowManaOverlay()
                end
                self.isManaPooling = true
                return true
            elseif self.isManaPooling then
                if self.HideManaOverlay then
                    self:HideManaOverlay()
                end
                self.isManaPooling = false
            end
        end

        if (not hasMana) or (not hasHolyPower) then
            return false
        end
    elseif self.CLASS_FILENAME == "HUNTER" then
        if not self:HasFocus(spellId) then
            return false
        end
    else
        if not self:HasMana(spellId) then
            return false
        end
    end
    return self:IsReadySpell(spellId, tolerance)
end

--- Returns the cooldown time in seconds until a spell, trinket, tinker, or item is ready.
--- @param id number The ID of the spell, trinket, tinker, or item.
--- @return number|boolean The time in seconds until the item is ready, or false if not applicable.
--- @usage NAG:TimeToReady(12345)
function NAG:TimeToReady(id)
    if not id then return false end

    -- Validate ID
    if not tonumber(id) then
        self:Error(format("TimeToReady: ID %s is not a number", tostring(id)))
        return false
    end

    -- Try to find entity in DataManager
    local entity = DataManager:Get(id, DataManager.EntityTypes.SPELL) or
        DataManager:Get(id, DataManager.EntityTypes.ITEM)

    if not entity then
        self:Error("TimeToReady: ID %d not found", id)
        return false
    end

    -- first  check if it's a spell
    if entity.IsSpell then
        if entity.flags.enchant then
            return self:TimeToReadyEnchant(id)
        elseif entity.flags.tinker then
            return self:TimeToReadyTinker(id)
        else
            return self:SpellTimeToReady(id)
        end
    elseif entity.IsItem then
        return entity:TimeToReady()
    end

    self:Error("TimeToReady: ID %d not found", id)
    return false
end

--- Gets the time until a spell is ready to cast.
--- Resolves APL/schema spell ID to spellbook ID so we report the correct spell's cooldown.
--- @param spellId number The ID of the spell.
--- @return number The time in seconds until the spell is ready, or -1 if the spellId is invalid.
--- @usage NAG:SpellTimeToReady(73643)
function NAG:SpellTimeToReady(spellId)
    if not spellId then return -1 end

    -- Resolve to spellbook ID so we check the spell the player actually has
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then
            spellId = resolved
        end
    end

    -- Check for custom behavior override first (O(1) lookup)
    if ns.EntityBehaviors and ns.EntityBehaviors.HasOverride and ns.EntityBehaviors.HasOverride("Spell", spellId, "TimeToReady") then
        return ns.EntityBehaviors.ExecuteBehavior("Spell", spellId, "TimeToReady", {id = spellId})
    end

    -- Proactive CD override for TBC Hunter MS: WoW API lags; we set CD on UNIT_SPELLCAST_SENT.
    if (Version and Version.IsTBC and Version:IsTBC()) and _G.UnitClassBase and _G.UnitClassBase("player") == "HUNTER" then
        if NAG._FillerCdOverride then
            local overrideEnd = NAG._FillerCdOverride[27021] or NAG._FillerCdOverride[2643]
            if overrideEnd and (spellId == 27021 or spellId == 2643) then
                local nextTime = NAG:NextTime()
                if overrideEnd > nextTime then
                    return overrideEnd - nextTime
                end
                NAG._FillerCdOverride[27021] = nil
                NAG._FillerCdOverride[2643] = nil
            end
        end
    end

    local cdInfo = WoWAPI.GetSpellCooldown(spellId)
    if not cdInfo then
        return -1
    end
    local start, duration = cdInfo.startTime, cdInfo.duration

    -- Learned Prediction override for cooldown duration
    -- IMPORTANT: Only apply learned duration when the spell is actually ON cooldown (start > 0)
    -- to avoid converting a ready spell into not-ready due to a learned average.
    do
        local LPP = ns.LearnedPredictionProvider
        if LPP and LPP.GetExpectedCooldown and start and start > 0 then
            local learnedCd = LPP:GetExpectedCooldown(spellId)
            if type(learnedCd) == "number" and learnedCd > 0 then
                duration = learnedCd
            end
        end
    end

    if start == 0 then
        return 0
    end

    return start + duration - NAG:NextTime()
end

--- Gets the time until an enchant spell is ready to cast.
--- @param spellId number The ID of the enchant spell.
--- @return number The time in seconds until the enchant spell is ready, or -1 if the spellId is invalid.
--- @usage NAG:TimeToReadyEnchant(12345)
--- @local This function is used to get the time until an enchant spell is ready to cast.
function NAG:TimeToReadyEnchant(spellId)
    if not spellId then return -1 end
    -- Resolve to spellbook ID for correct cooldown
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then
            spellId = resolved
        end
    end
    local cdInfo = WoWAPI.GetSpellCooldown(spellId)
    if not cdInfo then
        return -1
    end
    local start, duration = cdInfo.startTime, cdInfo.duration

    if start == 0 then
        return 0
    end

    return start + duration - NAG:NextTime()
end

--- Gets the time until a spell is ready to cast, accounting for both spell cooldown and GCD.
--- This is used for StrictSequence readiness checks to ensure spells are truly ready.
--- @param spellId number The ID of the spell.
--- @return number The time in seconds until the spell is ready, or -1 if the spellId is invalid.
--- @usage NAG:SpellTimeToReadyWithGCD(73643)
function NAG:SpellTimeToReadyWithGCD(spellId)
    if not spellId then return -1 end

    -- Get spell cooldown time
    local spellTimeToReady = self:SpellTimeToReady(spellId)
    if spellTimeToReady == -1 then
        return -1 -- Invalid spell
    end

    -- Get GCD time to ready
    local gcdTimeToReady = self:GCDTimeToReady()

    -- CRITICAL FIX: Handle negative values properly
    -- Negative values mean the spell is ready (on GCD or off cooldown)
    -- We should return the maximum of the two times, but handle negative values correctly
    if spellTimeToReady <= 0 and gcdTimeToReady <= 0 then
        -- Both spell and GCD are ready
        return 0
    elseif spellTimeToReady <= 0 then
        -- Spell is ready, but GCD is not
        return gcdTimeToReady
    elseif gcdTimeToReady <= 0 then
        -- GCD is ready, but spell is not
        return spellTimeToReady
    else
        -- Both have positive times, return the maximum
        return max(spellTimeToReady, gcdTimeToReady)
    end
end

--- Returns the cast time of a spell in seconds.
--- @param spellId number The ID of the spell.
--- @return number The cast time in seconds, or 0 if not found.
--- @usage NAG:SpellCastTime(73643)
function NAG:SpellCastTime(spellId)
    if not spellId then
        self:Error("SpellCastTime: No spellId provided")
        return 0
    end
    -- Resolve to spellbook ID for correct cast time / channel info
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then
            spellId = resolved
        end
    end

    -- If currently channeling this spell, return the total channel duration (start→end)
    local _, _, _, channelStartMS, channelEndMS, _, _, channelSpellID = UnitChannelInfo("player")
    if channelSpellID and channelSpellID == spellId and channelStartMS and channelEndMS and channelEndMS > channelStartMS then
        return (channelEndMS - channelStartMS) / 1000
    end

    -- Check for custom behavior override first (O(1) lookup)
    if ns.EntityBehaviors and ns.EntityBehaviors.HasOverride and ns.EntityBehaviors.HasOverride("Spell", spellId, "GetCastTime") then
        return ns.EntityBehaviors.ExecuteBehavior("Spell", spellId, "GetCastTime", {id = spellId})
    end

    -- Get base cast time
    local spellInfo = WoWAPI.GetSpellInfo(spellId)
    if not spellInfo then
        return 0
    end
    local name, castTime = spellInfo.name, spellInfo.castTime
    if not castTime then
        castTime = 0
    end

    -- Convert to seconds
    local baseCastTime = castTime / 1000
    if baseCastTime == 0 then
        if SpellTrackingManager and SpellTrackingManager.GetChannelDuration then
            local learnedDuration = SpellTrackingManager:GetChannelDuration(spellId)
            if learnedDuration and learnedDuration > 0 then
                return learnedDuration
            end
        end
    end

    --self:Debug(format("SpellCastTime: Base cast time for %s (%d): %.2f seconds", name, spellId, baseCastTime))

    return baseCastTime
end

--- Returns the travel time of a spell in seconds, or 0 if not found.
--- @param spellId number The ID of the spell.
--- @return number The travel time in seconds, or 0 if not found.
--- @usage NAG:SpellTravelTime(73643)
function NAG:SpellTravelTime(spellId)
    if not spellId then return 0 end
    -- Resolve to spellbook ID for correct tracking
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then
            spellId = resolved
        end
    end

    -- Use SpellTrackingManager API which handles registration automatically
    return SpellTrackingManager:GetSpellTravelTime(spellId) or 0
end

--- Calculates the CPM (Casts Per Minute) for a spell, or 0 if not tracked.
--- @param spellId number The ID of the spell.
--- @return number The CPM of the spell, or 0 if not tracked.
--- @usage NAG:SpellCPM(73643)
function NAG:SpellCPM(spellId)
    if not spellId then return 0 end
    -- Resolve to spellbook ID for correct tracking
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then
            spellId = resolved
        end
    end

    return SpellTrackingManager:GetCPM(spellId) or 0
end

--- Checks if a spell is currently being channeled by the player.
--- @param spellId number The ID of the spell.
--- @return boolean True if the spell is being channeled, false otherwise.
--- @usage NAG:SpellIsChanneling(73643)
function NAG:SpellIsChanneling(spellId)
    if not spellId then return false end
    -- Resolve to spellbook ID so we match the spell the player is channeling
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then
            spellId = resolved
        end
    end

    local spellName, _, _, _, _, _, _, currentSpellID = UnitChannelInfo("player")

    if currentSpellID and currentSpellID == spellId then
        return true
    end
    return false
end

--- Returns the number of ticks for a channeled spell. (Not implemented, always returns 0.)
--- @param spellId number The ID of the spell.
--- @return number Always returns 0.
--- @usage NAG:SpellChanneledTicks(73643)
function NAG:SpellChanneledTicks(spellId)
    if not spellId then return 0 end
    -- Resolve to spellbook ID for correct tracking
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then
            spellId = resolved
        end
    end

    if not SpellTrackingManager or not SpellTrackingManager.GetChannelTickCount then
        return 0
    end

    return SpellTrackingManager:GetChannelTickCount(spellId) or 0
end

--- Returns the number of charges available for a spell, or 0 if not applicable.
--- @param spellId number The ID of the spell to check.
--- @return number The number of charges available, or 0 if the spell doesn't use charges.
--- @usage NAG:SpellNumCharges(115399)
function NAG:SpellNumCharges(spellId)
    if not spellId then return 0 end
    -- Resolve to spellbook ID for correct charge info
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then
            spellId = resolved
        end
    end

    -- Check for custom behavior override first (O(1) lookup)
    if ns.EntityBehaviors and ns.EntityBehaviors.HasOverride and ns.EntityBehaviors.HasOverride("Spell", spellId, "GetCharges") then
        return ns.EntityBehaviors.ExecuteBehavior("Spell", spellId, "GetCharges", {id = spellId})
    end

    -- Get spell charge information using our unified API wrapper
    local chargeInfo = WoWAPI.GetSpellCharges(spellId)
    if not chargeInfo then
        return 0
    end

    local charges, maxCharges = chargeInfo.currentCharges, chargeInfo.maxCharges

    -- If the spell doesn't use charges (maxCharges would be nil)
    if not maxCharges then
        return 0
    end

    return charges or 0
end

--- Returns the time until the next charge of a spell will be ready, or 0 if fully charged or doesn't use charges.
--- @param spellId number The ID of the spell to check.
--- @return number The time in seconds until the next charge, or 0 if fully charged or doesn't use charges.
--- @usage NAG:SpellTimeToCharge(115399)
function NAG:SpellTimeToCharge(spellId)
    if not spellId then return 0 end
    -- Resolve to spellbook ID for correct charge info
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then
            spellId = resolved
        end
    end

    -- Get spell charge information using our unified API wrapper
    local chargeInfo = WoWAPI.GetSpellCharges(spellId)
    if not chargeInfo then
        return 0
    end

    local charges, maxCharges, chargeStart, chargeDuration = chargeInfo.currentCharges, chargeInfo.maxCharges, chargeInfo.cooldownStartTime, chargeInfo.cooldownDuration
    -- If the spell doesn't use charges (maxCharges would be nil)
    if not maxCharges then
        return 0
    end

    -- If we have max charges, return 0
    if charges >= maxCharges then
        return 0
    end

    -- If we have charge cooldown information, calculate time until next charge
    if chargeStart and chargeDuration then
        return max(0, (chargeStart + chargeDuration) - NAG:NextTime()) -- RAKIZI: Changed 9/9/25 from GetTime() to NAG:NextTime()
    end

    return 0
end

--- Returns the GCD duration for the provided spell, adjusted for the player's current haste when applicable.
--- @param spellId number The spell ID to evaluate.
--- @return number The GCD duration in seconds.
function NAG:SpellGCDHastedDuration(spellId)
    if not spellId then
        return self:GCDTimeValue()
    end

    local baseGCD = self:GCDTimeValue()
    local ignoreHaste = false
    local gcdMin = 0.75

    local entry

    entry = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
    if entry then
        if entry.startRecovery and entry.startRecovery > 0 then
            baseGCD = entry.startRecovery / 1000
        elseif entry.categoryRecovery and entry.categoryRecovery > 0 then
            baseGCD = entry.categoryRecovery / 1000
        end

        if entry.flags then
            ignoreHaste = entry.flags.ignoreHaste or entry.flags.IgnoreHaste or false
            if entry.flags.minimumGcd and entry.flags.minimumGcd > 0 then
                gcdMin = entry.flags.minimumGcd / 1000
            end
        end

        if entry.minimumGcd and entry.minimumGcd > 0 then
            gcdMin = entry.minimumGcd / 1000
        end
    end

    if not baseGCD or baseGCD <= 0 then
        return 0
    end

    if ignoreHaste then
        return baseGCD
    end

    local hasteFactor = self.GetHasteFactor and self:GetHasteFactor() or 1
    if hasteFactor <= 0 then
        hasteFactor = 1
    end

    local hasted = baseGCD / hasteFactor
    return max(gcdMin, hasted)
end

--- Returns the full cooldown duration for a spell, independent of its current cast state.
--- @param spellId number The spell ID to evaluate.
--- @return number The spell's full cooldown duration in seconds.
function NAG:SpellFullCooldown(spellId)
    if not spellId then
        return 0
    end
    -- Resolve to spellbook ID for correct cooldown
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then
            spellId = resolved
        end
    end

    local cdInfo = WoWAPI.GetSpellCooldown(spellId)
    if cdInfo and type(cdInfo) == "table" then
        local duration = cdInfo.duration or 0
        if duration and duration > 0 then
            return duration
        end
    end

    local baseCooldownMS = _G.GetSpellBaseCooldown and _G.GetSpellBaseCooldown(spellId)
    if type(baseCooldownMS) == "number" and baseCooldownMS > 0 then
        return baseCooldownMS / 1000
    end

    return 0
end

--- Returns the remaining channel time of a spell in seconds.
--- @return number The remaining channel time in seconds, or 0 if not channeling.
--- @usage NAG:SpellChannelTime()
--- @local This function is used to get the remaining channel time of a spell in seconds.
function NAG:SpellChannelTime()
    local endTimeMS = select(5, UnitChannelInfo("player"))
    if not endTimeMS then
        return 0
    end
    local finish = endTimeMS / 1000 - NAG:NextTime()
    return finish
end

--- Returns the current cost of a spell. (Not implemented, always returns 0.)
--- @param spellId number The ID of the spell.
--- @return number Always returns 0.
--- @usage NAG:SpellCurrentCost(73643)
function NAG:SpellCurrentCost(spellId)
    if not spellId then return 0 end
    return 0
end

--- Checks if a spell is currently in flight.
--- @param spellId number The spell ID to check.
--- @return boolean True if the spell is in flight, false otherwise.
--- @usage NAG:SpellInFlight(12345)
function NAG:SpellInFlight(spellId)
    if not spellId then return false end
    -- Resolve to spellbook ID for correct tracking
    if NAG.ResolveEffectiveSpellId then
        local resolved = NAG:ResolveEffectiveSpellId(spellId)
        if resolved then
            spellId = resolved
        end
    end
    return SpellTrackingManager:IsSpellInFlight(spellId)
end

--- Returns the last cast spell ID or 0 if none.
--- @return number The spell ID of the last cast spell, or 0 if not available.
--- @usage NAG:SpellLastCast()
function NAG:SpellLastCast()
    return StateManager:GetLastCastId() or 0
end

