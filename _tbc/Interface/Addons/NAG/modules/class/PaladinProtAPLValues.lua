--- @module "NAG.PaladinProtAPLValues"
--- Protection Paladin (TBC) helper values for seal/judgement/aura/blessing coordination.
--- This file is intentionally prot-scoped and must not modify Ret twist behavior.

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local StateManager = ns.StateManager

local max = math.max

-- ============================ CONSTANTS ============================

local PALADIN_IMP_SEAL_OF_CRUSADER_TALENT_ID = 1464 -- Improved Seal of the Crusader (TBC talent table id)

-- Seals / debuffs for Prot seal management.
-- Note: we track Vengeance/Corruption stacks via the target debuff, not the player aura.
local SEAL_OF_VENGEANCE_ID = 31801 -- Seal of Vengeance
local SEAL_OF_CORRUPTION_ID = 348704 -- Seal of Corruption (Horde equivalence)
local HOLY_VENGEANCE_DOT_ID = 31803 -- Holy Vengeance (target debuff from Seal of Vengeance)
local SEAL_OF_CORRUPTION_DOT_ID = 356112 -- Target debuff from Seal of Corruption (per our spell DB)
local SEAL_OF_RIGHTEOUSNESS_ID = 20154 -- Seal of Righteousness (base; ResolveEffectiveSpellId handles rank)

local JUDGEMENT_OF_WISDOM_DEBUFF_IDS = {
    20354, -- Judgement of Wisdom
    20355, -- Judgement of Wisdom
}

local BLESSING_SANCTUARY_IDS = {
    20911, -- Blessing of Sanctuary
    20912, -- Blessing of Sanctuary
    20913, -- Blessing of Sanctuary
    20914, -- Blessing of Sanctuary
    25899, -- Greater Blessing of Sanctuary
    27168, -- Blessing of Sanctuary
    27169, -- Greater Blessing of Sanctuary
}

local BLESSING_KINGS_IDS = {
    20217, -- Blessing of Kings
    25898, -- Greater Blessing of Kings
}

local BLESSING_WISDOM_IDS = {
    19742, -- Blessing of Wisdom
    19850, -- Blessing of Wisdom
    19852, -- Blessing of Wisdom
    19853, -- Blessing of Wisdom
    19854, -- Blessing of Wisdom
    25290, -- Blessing of Wisdom
    25894, -- Greater Blessing of Wisdom
    25918, -- Greater Blessing of Wisdom
    27142, -- Blessing of Wisdom
    27143, -- Greater Blessing of Wisdom
}

-- If ANY blessing is active, Prot should not prompt for another blessing.
-- Rationale: a paladin can only have one active blessing from themself at a time.
local BLESSING_ANY_IDS = {
    -- Might
    19740, -- Blessing of Might
    25782, -- Greater Blessing of Might

    -- Wisdom
    19742, -- Blessing of Wisdom
    25894, -- Greater Blessing of Wisdom
    27142, -- Blessing of Wisdom
    27143, -- Greater Blessing of Wisdom

    -- Kings
    20217, -- Blessing of Kings
    25898, -- Greater Blessing of Kings

    -- Sanctuary
    20911, -- Blessing of Sanctuary
    25899, -- Greater Blessing of Sanctuary
    27168, -- Blessing of Sanctuary
    27169, -- Greater Blessing of Sanctuary

    -- Light
    19977, -- Blessing of Light

    -- Salvation (do not overwrite other paladin's blessings)
    1038,  -- Blessing of Salvation
    25895, -- Greater Blessing of Salvation
}

-- Auras (base spell ids; AuraIsActiveResolved() handles rank resolution)
local PALADIN_AURA_IDS_NON_CRUSADER = {
    20218, -- Sanctity Aura
    465,   -- Devotion Aura
    7294,  -- Retribution Aura
    19746, -- Concentration Aura
    19876, -- Shadow Resistance Aura
    19888, -- Frost Resistance Aura
    19891, -- Fire Resistance Aura
}

local CRUSADER_AURA_ID = 32223 -- Crusader Aura

-- ============================ HELPERS ============================

local function hasAnyAuraIdActive(self, ids)
    for i = 1, #ids do
        local id = ids[i]
        if id and self:IsActive(id) then
            return true
        end
    end
    return false
end

--- Returns true if any aura in the list is active on the player and was cast by the player (or pet).
--- Uses `NAG:UnitBuff` to read unified `AuraData` (includes `isFromPlayerOrPlayerPet` / `sourceUnit`).
--- @param self NAG
--- @param ids number[]
--- @return boolean
local function hasAnyAuraIdActiveFromPlayer(self, ids)
    for i = 1, #ids do
        local id = ids[i]
        if id then
            local aura = self:UnitBuff("player", id, "HELPFUL", true)
            if aura and type(aura) == "table" then
                if aura.isFromPlayerOrPlayerPet == true then
                    return true
                end
                -- Fallback: some builds populate `sourceUnit` only.
                if aura.sourceUnit == "player" then
                    return true
                end
            end
        end
    end
    return false
end

--- Returns true if any aura in the list is active on the player and was NOT cast by the player (or pet).
--- If source cannot be determined, treat it as "other" to avoid overwriting.
--- @param self NAG
--- @param ids number[]
--- @return boolean
local function hasAnyAuraIdActiveFromOther(self, ids)
    for i = 1, #ids do
        local id = ids[i]
        if id then
            local aura = self:UnitBuff("player", id, "HELPFUL", true)
            if aura and type(aura) == "table" then
                if aura.isFromPlayerOrPlayerPet == false then
                    return true
                end
                if aura.isFromPlayerOrPlayerPet == nil then
                    return true
                end
                -- If it is from player/pet, do not count as "other".
            end
        end
    end
    return false
end

local function hasAnyDebuffId(self, unit, ids)
    for i = 1, #ids do
        local id = ids[i]
        if id and self:UnitDebuff(unit, id) then
            return true
        end
    end
    return false
end

-- ============================ JUDGEMENT / SEAL COORDINATION ============================

--- True if the target currently has Judgement of Wisdom.
--- @param targetUnit? string
--- @return boolean
function NAG:ProtHasJudgementOfWisdom(targetUnit)
    return hasAnyDebuffId(self, targetUnit or "target", JUDGEMENT_OF_WISDOM_DEBUFF_IDS)
end

--- True if the target currently has Judgement of the Crusader.
--- Uses the existing Ret helper (debuff id is shared across ranks).
--- @return boolean
function NAG:ProtHasJudgementOfCrusader()
    return self:RetTwistHasJudgementOfCrusaderDebuff()
end

--- True if Prot should default to Judgement of the Crusader due to talents.
--- @return boolean
function NAG:ProtWantsJudgeCrusaderByDefault()
    local rank = StateManager and StateManager.GetTalentRank and StateManager:GetTalentRank(PALADIN_IMP_SEAL_OF_CRUSADER_TALENT_ID) or 0
    return (rank or 0) > 0
end

--- Chooses which judgement Prot should maintain: "crusader" or "wisdom".
--- Precedence: assignment override > other-paladin coordination > talent default.
--- @return string judgementKey
function NAG:ProtChooseJudgement()
    -- Assignment override (if both are enabled, Crusader wins)
    if self:IsAssignmentEnabled("judge_crusader") then
        return "crusader"
    end
    if self:IsAssignmentEnabled("judge_wisdom") then
        return "wisdom"
    end

    -- Coordination: if another paladin is present and one judgement is already on target, pick the other.
    if self:HasOtherPaladinInGroup() then
        local hasJoW = self:ProtHasJudgementOfWisdom("target")
        local hasJoC = self:ProtHasJudgementOfCrusader()
        if hasJoW and (not hasJoC) then
            return "crusader"
        end
        if hasJoC and (not hasJoW) then
            return "wisdom"
        end
    end

    if self:ProtWantsJudgeCrusaderByDefault() then
        return "crusader"
    end

    return "wisdom"
end

-- ============================ AURA / BLESSING CHECKS ============================

--- True if the player has a non-Crusader Paladin aura active.
--- @return boolean
function NAG:ProtHasNonCrusaderAuraActive()
    if self:AuraIsActiveResolved(CRUSADER_AURA_ID, "player") then
        return false
    end
    for i = 1, #PALADIN_AURA_IDS_NON_CRUSADER do
        local id = PALADIN_AURA_IDS_NON_CRUSADER[i]
        if id and self:AuraIsActiveResolved(id, "player") then
            return true
        end
    end
    return false
end

--- Returns the first known non-Crusader aura spellId to suggest, or nil.
--- @return number|nil
function NAG:ProtGetFallbackAuraSpellId()
    -- Prefer Devotion, then Retribution, then Concentration, then resist auras.
    local preferred = {465, 7294, 19746, 19876, 19888, 19891}
    for i = 1, #preferred do
        local id = preferred[i]
        if id and self:SpellIsKnown(id) then
            return id
        end
    end
    return nil
end

--- True if any Blessing of Sanctuary is active on the player.
--- @return boolean
function NAG:ProtHasBlessingSanctuary()
    return hasAnyAuraIdActive(self, BLESSING_SANCTUARY_IDS)
end

--- True if any Blessing of Kings is active on the player.
--- @return boolean
function NAG:ProtHasBlessingKings()
    return hasAnyAuraIdActive(self, BLESSING_KINGS_IDS)
end

--- True if any Blessing of Wisdom is active on the player.
--- @return boolean
function NAG:ProtHasBlessingWisdom()
    return hasAnyAuraIdActive(self, BLESSING_WISDOM_IDS)
end

--- True if ANY blessing is active on the player (greater or lesser).
--- Used to avoid prompting for multiple blessings from the same paladin.
--- @return boolean
function NAG:ProtHasAnyBlessing()
    return hasAnyAuraIdActive(self, BLESSING_ANY_IDS)
end

--- True if ANY blessing is active on the player that was cast by the player (or pet).
--- @return boolean
function NAG:ProtHasAnyBlessingFromPlayer()
    return hasAnyAuraIdActiveFromPlayer(self, BLESSING_ANY_IDS)
end

--- True if ANY blessing is active on the player that was cast by another player.
--- This is used to avoid overwriting other paladin's buffs.
--- @return boolean
function NAG:ProtHasAnyBlessingFromOther()
    return hasAnyAuraIdActiveFromOther(self, BLESSING_ANY_IDS)
end

--- True if any Blessing of Sanctuary is active on the player and was cast by the player (or pet).
--- @return boolean
function NAG:ProtHasBlessingSanctuaryFromPlayer()
    return hasAnyAuraIdActiveFromPlayer(self, BLESSING_SANCTUARY_IDS)
end

--- True if any Blessing of Kings is active on the player and was cast by the player (or pet).
--- @return boolean
function NAG:ProtHasBlessingKingsFromPlayer()
    return hasAnyAuraIdActiveFromPlayer(self, BLESSING_KINGS_IDS)
end

--- True if any Blessing of Wisdom is active on the player and was cast by the player (or pet).
--- @return boolean
function NAG:ProtHasBlessingWisdomFromPlayer()
    return hasAnyAuraIdActiveFromPlayer(self, BLESSING_WISDOM_IDS)
end

-- ============================ RANGE HELPERS ============================

--- True if we have no enemies in melee and at least N enemies in range.
--- This uses current-target range checks as an approximation (same style as existing rotations).
--- @param minTargets number
--- @param rangedYards number
--- @param meleeYards number
--- @return boolean
function NAG:ProtIsRangedPack(minTargets, rangedYards, meleeYards)
    local minT = max(1, tonumber(minTargets) or 2)
    local r = tonumber(rangedYards) or 7
    local m = tonumber(meleeYards) or 5
    return (self:NumberTargets(r, false) >= minT) and (not self:TargetInMeleeRange(m))
end

-- ============================ ROTATION SELECTION TOGGLES ============================

--- True if the user has disabled seal twisting for Protection.
--- @return boolean
function NAG:ProtNeverSealTwistEnabled()
    local classModule = self.Class
    if not classModule or not classModule.db or not classModule.db.char then
        return false
    end
    return classModule.db.char.protNeverSealTwist == true
end

--- True if seal twisting is enabled for Protection (inverted storage of `protNeverSealTwist`).
--- @return boolean
function NAG:ProtSealTwistEnabled()
    return not self:ProtNeverSealTwistEnabled()
end

-- ============================ SEAL OF VENGEANCE (STACK MANAGEMENT) ============================

--- Returns the Vengeance-equivalent seal spell id to use (SoCorruption if known, else SoV), or nil if neither is known.
--- @return number|nil
function NAG:ProtGetVengeanceSealId()
    if self:SpellIsKnown(SEAL_OF_CORRUPTION_ID) then
        return SEAL_OF_CORRUPTION_ID
    end
    if self:SpellIsKnown(SEAL_OF_VENGEANCE_ID) then
        return SEAL_OF_VENGEANCE_ID
    end
    return nil
end

--- Returns the target debuff id used for Vengeance/Corruption stack tracking, or nil if the seal is not available.
--- @return number|nil
function NAG:ProtGetVengeanceDotId()
    local sealId = self:ProtGetVengeanceSealId()
    if not sealId then
        return nil
    end
    if sealId == SEAL_OF_CORRUPTION_ID then
        return SEAL_OF_CORRUPTION_DOT_ID
    end
    return HOLY_VENGEANCE_DOT_ID
end

--- Returns the current Vengeance/Corruption stack count on the target.
--- @return number
function NAG:ProtVengeanceStacks()
    local dotId = self:ProtGetVengeanceDotId()
    if not dotId then
        return 0
    end
    return tonumber(self:DotNumStacksResolved(dotId)) or 0
end

--- Returns the remaining time (seconds) on the Vengeance/Corruption target debuff.
--- @return number
function NAG:ProtVengeanceRemaining()
    local dotId = self:ProtGetVengeanceDotId()
    if not dotId then
        return 0
    end
    return tonumber(self:DotRemainingTimeResolved(dotId)) or 0
end

--- Returns the seal to use once Vengeance/Corruption reaches 5 stacks.
--- Rule: swap to SoC if known (talented), otherwise swap to SoR.
--- @return number|nil
function NAG:ProtGetFiveStackSwapSealId()
    local socId = self.RetTwistGetSoCSealId and self:RetTwistGetSoCSealId() or nil
    if socId and self:SpellIsKnown(socId) then
        return socId
    end

    local sorId = self:ResolveEffectiveSpellId(SEAL_OF_RIGHTEOUSNESS_ID)
    if sorId and self:SpellIsKnown(sorId) then
        return sorId
    end

    return nil
end

