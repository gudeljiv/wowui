--- @module "NAG.tbc.HealingDispelManager"
--- Class-based dispel logic for TBC 2.5.5 healing specs.
--- Used by HealingStateManager to set mouseover.dispel.
--- TBC dispel detection is class-based (not spec-based like MoP).
---
--- License: CC BY-NC 4.0
--- Authors: NAG Team

local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local UnitExists = _G.UnitExists
local UnitBuff = _G.UnitBuff
local UnitDebuff = _G.UnitDebuff
local UnitClass = _G.UnitClass

-- ============================ DISPEL TABLES ============================

--- TBC dispel types by class (all specs can use these)
--- Priests: Abolish Disease / Cure Disease (Disease), Dispel Magic (Magic)
--- Paladins: Cleanse (Magic, Disease, Poison)
--- Shamans: Cleanse Spirit rank depends on spell; Cure Disease (Disease), Cure Poison (Poison)
--- Druids: Abolish Poison (Poison), Remove Curse (Curse)
--- Mages: Remove Curse (Curse)
local DISPEL_BY_CLASS = {
    PRIEST = { Magic = true, Disease = true },
    PALADIN = { Magic = true, Disease = true, Poison = true },
    SHAMAN = { Disease = true, Poison = true },
    DRUID = { Curse = true, Poison = true },
    MAGE = { Curse = true },
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

-- Healer spec indices per class (TBC): Priest 1,2; Druid 4; Paladin 1; Shaman 3
local HEALER_SPEC_BY_CLASS = {
    PRIEST = { [1] = true, [2] = true },
    DRUID = { [4] = true },
    PALADIN = { [1] = true },
    SHAMAN = { [3] = true },
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

-- Cached dispel map
local cachedDispelTypes = nil

-- ============================ DISPEL MAP ============================

--- Build dispel type map for current class
--- @return table Map of dispelType -> true
local function getDispelTypes()
    if cachedDispelTypes then
        return cachedDispelTypes
    end

    local _, class = UnitClass("player")
    if not class then return {} end

    cachedDispelTypes = DISPEL_BY_CLASS[class] or {}
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

    -- TBC uses UnitDebuff with index iteration
    for i = 1, 40 do
        local name, _, _, dispelType = UnitDebuff(unit, i)
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
--- @return number|nil icon Debuff icon
--- @return string|nil dispelType Debuff dispel type
function HealingDispelManager:GetFirstDispellableDebuff(unit)
    if not isDispelActive(self) then return nil end
    if not unit or not UnitExists(unit) then return nil end
    local canDispel = getDispelTypes()
    if not canDispel or not next(canDispel) then return nil end

    for i = 1, 40 do
        local name, _, icon, _, dispelType = UnitDebuff(unit, i)
        if not name then break end
        if dispelType and canDispel[dispelType] then
            return name, icon, dispelType
        end
    end
    return nil
end

--- Invalidate cached dispel types
function HealingDispelManager:InvalidateCache()
    cachedDispelTypes = nil
end

-- ============================ LIFECYCLE ============================

function HealingDispelManager:ModuleInitialize() end

function HealingDispelManager:ModuleEnable()
    cachedDispelTypes = nil
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
        desc = "Dispel detection for healing rotations (TBC). Only active when Developer Mode is enabled.",
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
