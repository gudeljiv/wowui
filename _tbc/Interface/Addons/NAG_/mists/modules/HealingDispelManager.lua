--- @module "NAG.mists.HealingDispelManager"
--- Spec-based dispel logic for Mists of Pandaria healing specs.
--- Used by HealingStateManager to set mouseover.dispel.
--- MoP dispel types depend on both class AND spec (e.g. Druid Resto gets Magic via Nature's Cure).
---
--- License: CC BY-NC 4.0
--- Authors: NAG Team

local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local UnitExists = _G.UnitExists
local UnitAura = _G.UnitAura
local UnitClass = _G.UnitClass

-- ============================ DISPEL TABLES ============================

--- Class-level dispels (always available regardless of spec)
local DISPEL_BY_CLASS = {
    PRIEST = { Disease = true },
    PALADIN = { Disease = true, Poison = true },
    SHAMAN = { Curse = true },
    DRUID = { Curse = true, Poison = true },
    MONK = { Disease = true, Poison = true },
    MAGE = { Curse = true },
}

--- Spec-specific ADDITIONAL dispels on top of class dispels
--- Format: [class] = { [specIndex] = { [dispelType] = true } }
local DISPEL_BY_SPEC = {
    PRIEST = {
        [1] = { Magic = true }, -- Discipline: Purify
        [2] = { Magic = true }, -- Holy: Purify
    },
    PALADIN = {
        [1] = { Magic = true }, -- Holy: Cleanse (full)
    },
    SHAMAN = {
        [3] = { Magic = true }, -- Restoration: Purify Spirit
    },
    DRUID = {
        [4] = { Magic = true }, -- Restoration: Nature's Cure
    },
    MONK = {
        [2] = { Magic = true }, -- Mistweaver: Detox (magic)
    },
}

-- nil = use spec-based default (enabled on healing specs only)
local defaults = {
    char = { enabled = nil }
}

local HealingDispelManager = NAG:CreateModule("HealingDispelManager", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,
    optionsCategory = "features",
    debugCategories = { ns.DEBUG_CATEGORIES.FEATURES },
})

-- Healer spec indices per class (MoP) - same as HealingStateManager
local HEALER_SPEC_BY_CLASS = {
    PRIEST = { [1] = true, [2] = true },
    DRUID = { [4] = true },
    PALADIN = { [1] = true },
    SHAMAN = { [3] = true },
    MONK = { [2] = true },
}

function HealingDispelManager:IsHealingSpec()
    local _, class = UnitClass("player")
    if not class or not HEALER_SPEC_BY_CLASS[class] then return false end
    local SpecCompat = NAG:GetModule("SpecCompat", true)
    local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
    return specIndex and HEALER_SPEC_BY_CLASS[class][specIndex] or false
end

function HealingDispelManager:IsEnabled()
    if self.db.char.enabled ~= nil then return self.db.char.enabled end
    return self:IsHealingSpec()
end

--- True if dispel detection should run (developer mode + enabled)
local function isDispelActive(module)
    if not NAG.IsDevModeEnabled or not NAG:IsDevModeEnabled() then return false end
    return module:IsEnabled()
end

-- Cached dispel map (rebuilt on spec change)
local cachedDispelTypes = nil
local cachedSpecIndex = nil

-- ============================ DISPEL MAP BUILDING ============================

--- Build the effective dispel type map for current class + spec
--- @return table Map of dispelType -> true
local function buildDispelMap()
    local _, class = UnitClass("player")
    if not class then return {} end

    local result = {}

    -- Add class-level dispels
    local classDispels = DISPEL_BY_CLASS[class]
    if classDispels then
        for dtype, v in pairs(classDispels) do
            result[dtype] = v
        end
    end

    -- Add spec-level dispels
    local SpecCompat = NAG:GetModule("SpecCompat", true)
    local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex() or nil

    if specIndex then
        local specDispels = DISPEL_BY_SPEC[class]
        if specDispels and specDispels[specIndex] then
            for dtype, v in pairs(specDispels[specIndex]) do
                result[dtype] = v
            end
        end
    end

    return result, specIndex
end

--- Get current dispel types, using cache when possible
--- @return table Map of dispelType -> true
local function getDispelTypes()
    local SpecCompat = NAG:GetModule("SpecCompat", true)
    local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex() or nil

    if cachedDispelTypes and cachedSpecIndex == specIndex then
        return cachedDispelTypes
    end

    cachedDispelTypes, cachedSpecIndex = buildDispelMap()
    return cachedDispelTypes
end

-- ============================ PUBLIC API ============================

--- Check if unit has a dispellable debuff we can remove
--- @param unit string Unit token (e.g. "mouseover", "party1")
--- @return boolean True if unit has at least one dispellable debuff
function HealingDispelManager:CheckDispellable(unit)
    if not isDispelActive(self) then return false end
    if not unit or not UnitExists(unit) then return false end
    local canDispel = getDispelTypes()
    if not canDispel or not next(canDispel) then return false end

    for i = 1, 40 do
        local name, _, _, dispelType = UnitAura(unit, i, "HARMFUL")
        if not name then break end
        if dispelType and canDispel[dispelType] then
            return true
        end
    end
    return false
end

--- Get the first dispellable debuff info
--- @param unit string Unit token
--- @return string|nil name Debuff name
--- @return number|nil spellId Debuff spell ID
--- @return string|nil dispelType Debuff dispel type
function HealingDispelManager:GetFirstDispellableDebuff(unit)
    if not isDispelActive(self) then return nil end
    if not unit or not UnitExists(unit) then return nil end
    local canDispel = getDispelTypes()
    if not canDispel or not next(canDispel) then return nil end

    for i = 1, 40 do
        local name, _, _, dispelType, _, _, _, _, _, spellId = UnitAura(unit, i, "HARMFUL")
        if not name then break end
        if dispelType and canDispel[dispelType] then
            return name, spellId, dispelType
        end
    end
    return nil
end

--- Invalidate cached dispel types (call on spec change)
function HealingDispelManager:InvalidateCache()
    cachedDispelTypes = nil
    cachedSpecIndex = nil
end

-- ============================ LIFECYCLE ============================

function HealingDispelManager:ModuleInitialize()
    -- Cache will be built lazily on first CheckDispellable call
end

function HealingDispelManager:ModuleEnable()
    -- Rebuild cache when module is enabled
    cachedDispelTypes = nil
    cachedSpecIndex = nil
end

-- ============================ OPTIONS ============================

function HealingDispelManager:GetOptions()
    local OptionsFactory = ns.OptionsFactory
    if not OptionsFactory then
        return { type = "group", name = "Healing Dispel", args = {} }
    end
    return {
        type = "group",
        name = "Healing Dispel",
        desc = "Spec-based dispel detection for healing rotations (MoP). Only active when Developer Mode is enabled.",
        hidden = function() return not (NAG.IsDevModeEnabled and NAG:IsDevModeEnabled()) end,
        args = {
            enabled = OptionsFactory:CreateToggle(
                "Enable",
                "Enable dispel detection for mouseover (healer specs: on by default; DPS/tank: off)",
                function() return self:IsEnabled() end,
                function(_, v) self:SetSetting("char", "enabled", v) end,
                { order = 1 }
            )
        }
    }
end

return HealingDispelManager
