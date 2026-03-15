--- @module "APLValues__Tinkers"
--- Tinker logic handlers for the NAG addon.

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ HEADER LOCALS ============================

-- Libraries
local L = ns.AceLocale:GetLocale("NAG", true)
local RC = ns.RC

local GetItemCooldown = C_Container and C_Container.GetItemCooldown or _G.GetItemCooldown

-- Lua APIs (WoW optimized where available)
local format = string.format


local sort = table.sort
local concat = table.concat
local type = type

-- ============================ MODULE CACHING (PERFORMANCE) ============================
-- Cache frequently accessed modules to avoid GetModule overhead in hot paths
local DataManager = ns.DataManager

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~


--- Resolve item ID for a tinker/enchant spell entity (entity.itemId or first related item).
--- @param entity table Spell entity from DataManager
--- @return number|nil itemId
local function resolveTinkerItemId(entity)
    if entity.itemId then
        return entity.itemId
    end
    if entity.relationships and entity.relationships.item then
        for itemId in pairs(entity.relationships.item) do
            return itemId
        end
    end
    return nil
end

--- Casts a tinker spell if available and ready.
--- Attempts to cast the tinker associated with the given spellId if it is equipped and ready. Adds the tinker as a secondary spell if ready.
--- @param spellId number The ID of the tinker spell to cast.
--- @usage NAG:CastTinker(73643)
--- @return boolean Always returns false (function adds tinker as secondary spell if ready).
--- @local Internal APL value manipulation function
function NAG:CastTinker(spellId)
    local entity = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
    if not entity or not entity.flags.tinker then return false end

    local itemId = resolveTinkerItemId(entity)
    if not itemId then return false end

    -- Equipped check: use slot when available (MoP-safe), else C_Item
    local equipped
    if entity.slot then
        equipped = (_G.GetInventoryItemID("player", entity.slot) == itemId)
    else
        equipped = (C_Item and C_Item.IsEquippedItem and C_Item.IsEquippedItem(itemId))
    end
    if not equipped then return false end

    if self:IsReadyTinker(spellId) then
        -- Add spell ID + item ID so display/cooldown use item unambiguously (GetItemCooldown(itemId))
        local position = ns.SPELL_POSITIONS.LEFT
        local SpellbookManager = NAG:GetModule("SpellbookManager")
        if SpellbookManager and SpellbookManager.GetSpellPosition then
            local pos = SpellbookManager:GetSpellPosition(spellId)
            if pos and pos ~= ns.SPELL_POSITIONS.PRIMARY then
                position = pos
            end
        end
        self:AddSecondarySpell(spellId, position, itemId)
        return false
    end
    return false
end

--- Checks if a tinker is equipped for the given spell ID.
--- Determines if the tinker associated with the provided spell ID is equipped on the player.
--- @param id number The spell ID associated with the tinker to check.
--- @usage NAG:IsKnownTinker(12345)
--- @return boolean True if the tinker is equipped, false otherwise.
--- @local This function is used to check if a tinker is equipped for the given spell ID.
function NAG:IsKnownTinker(id)
    if not id then
        self:Error("IsKnownTinker: No ID provided")
        return false
    end
    local entity = DataManager:Get(id, DataManager.EntityTypes.SPELL)
    if not entity then
        self:Warn("IsKnownTinker: Invalid ID:", id)
        return false
    end
    local itemId = resolveTinkerItemId(entity)
    if not itemId then
        self:Warn("IsKnownTinker: No associated item found for ID:", id)
        return false
    end
    if entity.slot then
        return (_G.GetInventoryItemID("player", entity.slot) == itemId)
    end
    return (C_Item and C_Item.IsEquippedItem and C_Item.IsEquippedItem(itemId))
end

--- Checks if a tinker buff is currently active for the given spell ID.
--- Returns true if the tinker buff associated with the spell ID is currently active on the player.
--- @param id number The spell ID associated with the tinker to check.
--- @usage NAG:IsActiveTinker(12345)
--- @return boolean True if the tinker buff is active, false otherwise.
--- @local This function is used to check if a tinker buff is currently active for the given spell ID.
function NAG:IsActiveTinker(id)
    if not id then
        self:Error("IsActiveTinker: No ID provided")
        return false
    end
    local entity = DataManager:Get(id, DataManager.EntityTypes.SPELL)
    if not entity then
        self:Warn("IsActiveTinker: Invalid ID:", id)
        return false
    end
    return entity:IsActive()
end

--- Gets the time in seconds until a tinker is ready to use.
--- Returns the cooldown time remaining for the tinker associated with the given spell ID, or -1 if invalid.
--- @param id number The spell ID associated with the tinker to check.
--- @usage NAG:TimeToReadyTinker(12345)
--- @return number Time in seconds until ready (0 if ready, -1 if invalid).
--- @local This function is used to get the time in seconds until a tinker is ready to use.
function NAG:TimeToReadyTinker(id)
    if not id then
        self:Error("TimeToReadyTinker: No ID provided")
        return -1
    end
    local entity = DataManager:Get(id, DataManager.EntityTypes.SPELL)
    if not entity then
        self:Warn("TimeToReadyTinker: Invalid ID:", id)
        return -1
    end
    local itemId = resolveTinkerItemId(entity)
    if not itemId then
        self:Warn("TimeToReadyTinker: No associated item found for ID:", id)
        return -1
    end
    local start, duration = GetItemCooldown(itemId)
    if start == 0 then
        return 0
    end
    return start + duration - NAG:NextTime()
end

--- Checks if a tinker is ready to use for the given spell ID.
--- Determines if the tinker associated with the spell ID is equipped and off cooldown.
--- @param id number The spell ID associated with the tinker to check.
--- @usage NAG:IsReadyTinker(12345)
--- @return boolean True if the tinker is ready, false otherwise.
--- @local This function is used to check if a tinker is ready to use for the given spell ID.
function NAG:IsReadyTinker(id)
    if not id then
        self:Error("IsReadyTinker: No ID provided")
        return false
    end
    local entity = DataManager:Get(id, DataManager.EntityTypes.SPELL)
    if not entity then
        self:Warn("IsReadyTinker: Invalid ID:", id)
        return false
    end
    local itemId = resolveTinkerItemId(entity)
    if not itemId then
        return false
    end
    local equipped
    if entity.slot then
        equipped = (_G.GetInventoryItemID("player", entity.slot) == itemId)
    else
        equipped = (C_Item and C_Item.IsEquippedItem and C_Item.IsEquippedItem(itemId))
    end
    if not equipped then
        return false
    end
    local start, duration = GetItemCooldown(itemId)
    return (start == 0 and duration == 0) or (start + duration <= NAG:NextTime())
end
