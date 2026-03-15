--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)

    This software is provided 'as-is', without any express or implied warranty. In no event will the authors be held
        liable for any damages arising from the use of this software.

    You are free to:
    - Share — copy and redistribute the material in any medium or format
    - Adapt — remix, transform, and build upon the material

    Under the following terms:
    - Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were
        made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or
        your use.
    - NonCommercial — You may not use the material for commercial purposes.

    Full license text: https://creativecommons.org/licenses/by-nc/4.0/legalcode

    Author: Rakizi: farendil2020@gmail.com @rakizi http://discord.gg/ebonhold
    Date: 06/01/2024

    STATUS: Initial implementation
    NOTES: Constants for Cataclysm consumables
]]

-- ======= LOCALIZE =======
-- Addon
local _, ns = ...
local AceEvent = ns.AceEvent
local Version = ns.Version

if not Version:IsCata() then return end

-- Flasks
ns.flasks = {}

-- Battle Elixirs
ns.battleElixirs = { }

-- Guardian Elixirs
ns.guardianElixirs = {}

-- Combine both elixir types for consistency
ns.elixirs = {}
for _, id in ipairs(ns.battleElixirs) do table.insert(ns.elixirs, id) end
for _, id in ipairs(ns.guardianElixirs) do table.insert(ns.elixirs, id) end

-- Combat Potions
ns.potions = {}

-- Temporary Item Enhancements
ns.temporaryEnhancements = {}

-- Permanent Item Enhancements
ns.permanentEnhancements = {}

-- Combine both enhancement types for consistency
ns.itemEnhancements = {}
for _, id in ipairs(ns.temporaryEnhancements) do table.insert(ns.itemEnhancements, id) end
for _, id in ipairs(ns.permanentEnhancements) do table.insert(ns.itemEnhancements, id) end

-- Food and Drink
ns.food = {}
ns.drink = {}

-- Scrolls
ns.scrolls = {}

-- Runes / special spells
ns.runes = {}

-- Miscellaneous items
ns.other = {}

-- ============================ REGISTRATION ============================
-- Register consumables and runes with DataManager after expansion data is ready
local registrar = {}
AceEvent:Embed(registrar)

registrar:RegisterMessage("NAG_EXPANSION_DATA_LOADED", function()
    local DataManager = NAG:GetModule("DataManager")
    NAG:Debug("CataConstants: Registering consumables with DataManager")

    for _, id in ipairs(ns.flasks) do
        DataManager:AddItem(id, { "Consumable", "Flask" })
    end
    for _, id in ipairs(ns.battleElixirs) do
        DataManager:AddItem(id, { "Consumable", "BattleElixir" })
    end
    for _, id in ipairs(ns.guardianElixirs) do
        DataManager:AddItem(id, { "Consumable", "GuardianElixir" })
    end
    for _, id in ipairs(ns.elixirs) do
        DataManager:AddItem(id, { "Consumable", "Elixir" })
    end
    for _, id in ipairs(ns.potions) do
        DataManager:AddItem(id, { "Consumable", "Potion" })
    end
    for _, id in ipairs(ns.temporaryEnhancements) do
        DataManager:AddItem(id, { "Consumable", "TempEnhancement" })
    end
    for _, id in ipairs(ns.permanentEnhancements) do
        DataManager:AddItem(id, { "Consumable", "PermEnhancement" })
    end
    for _, id in ipairs(ns.itemEnhancements) do
        DataManager:AddItem(id, { "Consumable", "Enhancement" })
    end
    for _, id in ipairs(ns.food) do
        DataManager:AddItem(id, { "Consumable", "Food" })
    end
    for _, id in ipairs(ns.drink) do
        DataManager:AddItem(id, { "Consumable", "Drink" })
    end
    for _, id in ipairs(ns.scrolls) do
        DataManager:AddItem(id, { "Consumable", "Scroll" })
    end
    for _, id in ipairs(ns.runes) do
        DataManager:AddSpell(id, { "Consumable", "Rune" })
    end
    for _, id in ipairs(ns.other) do
        DataManager:AddItem(id, { "Consumable", "Other" })
    end

    registrar:UnregisterMessage("NAG_EXPANSION_DATA_LOADED")
end)

