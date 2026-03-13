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
    NOTES: Constants for Mists of Pandaria consumables
]]

-- ======= LOCALIZE =======
-- Addon
local _, ns = ...
local AceEvent = ns.AceEvent
local Version = ns.Version

if not Version:IsMists() then return end

-- Flasks
ns.flasks = { 76085, 76088, 75525, 76084, 76087, 65455, 103557, 40084, 40079, 45009, 40082, 45006, 45007, 46379, 58087, 46377, 58085, 58086, 40404, 40083, 45008, 76086, 46376, 58088, 46378, 67438 }

-- Battle Elixirs
ns.battleElixirs = { 58084, 58089, 58144, 58148, 58094, 58092 }

-- Guardian Elixirs
ns.guardianElixirs = { 40078, 44328, 58143, 44332, 58093, 40097 }

-- Combine both elixir types for consistency
ns.elixirs = {}
for _, id in ipairs(ns.battleElixirs) do table.insert(ns.elixirs, id) end
for _, id in ipairs(ns.guardianElixirs) do table.insert(ns.elixirs, id) end

-- Combat Potions
ns.potions = {  86569, 93351, 76096, 76093, 76089, 76095, 76098, 58488, 93742, 247802, 76091, 76097, 92941, 58146, 76090, 92954, 33448, 60265, 57192, 58091, 265419, 54213, 80040, 91803, 39671, 40213, 40217, 40081, 45277, 57099, 58090, 92943, 40215, 44728, 45276, 38351, 39971, 43531, 54643, 58489, 76092, 57191, 76094, 92979, 95055, 33447, 43569, 58487, 64993, 64994, 37926, 40087, 40093, 40212, 42545, 58145, 40067, 40214, 40216, 97156, 98062, 36770, 43530, 54642, 57193, 63300, 67416, 88416, 92942, 43570, 57194, 74633, 63144, 92964, 95054, 39327, 40211, 63145, 54641, 67944, 98061, 104277, 97157, 40077, 41166, 98063, 67415 }

-- Temporary Item Enhancements
ns.temporaryEnhancements = {}

-- Permanent Item Enhancements
ns.permanentEnhancements = { 90046, 93403, 74726, 74724, 98163, 82444, 77529, 82445, 98164, 83007, 74725, 87559, 74723, 83764, 83765, 74708, 74718, 74729, 74705, 95349, 74703, 83006, 74713, 74719, 74712, 74704, 74717, 77531, 74720, 87578, 74715, 74727, 74710, 74722, 87585, 74721, 86597, 87582, 265774, 83763, 80167, 89737, 74707, 86599, 74700, 74728, 85559, 87580, 74709, 74716, 80154, 74701, 87581, 74706, 80156, 77276, 79061, 85570, 85569, 82959, 85568, 87579, 87583, 87584, 80157, 87577, 254314, 80153, 80155, 80158, 87560, 74711, 82442, 82443, 94904 }

-- Combine both enhancement types for consistency
ns.itemEnhancements = {}
for _, id in ipairs(ns.temporaryEnhancements) do table.insert(ns.itemEnhancements, id) end
for _, id in ipairs(ns.permanentEnhancements) do table.insert(ns.itemEnhancements, id) end

-- Food and Drink
ns.food = {}
ns.drink = {}

-- Scrolls
ns.scrolls = { 44315, 67231, 43465, 33457, 33459, 33460, 33462, 37091, 43463, 43466, 43468, 63304, 63307, 37097, 63308, 37092, 37093, 37094, 37098, 49768, 43464, 43467, 62251, 37118, 49632, 33458, 33461, 63303, 63305, 63306, 79257, 44314 }

-- Miscellaneous items
ns.other = { 87872, 93730, 85973, 86592, 88375, 254313, 88802, 93215, 93724, 102351, 89230, 93226, 91904, 93224, 89227, 89614, 89999, 93229, 88370, 91860, 93225, 88801, 92522, 93044, 88387, 93230, 82960, 86607, 93220, 88491, 87764, 95559, 89303, 265414, 88576, 95548, 104142, 83795, 88380, 88579, 88584, 88587, 88589, 90901, 93232, 79338, 87647, 91861, 91864, 93158, 104145, 104149, 104152, 88381, 91850, 95056, 87648, 93045, 88377, 88385, 88386, 92965, 89222, 90638, 104112, 104148, 88582, 91866, 92980, 93231, 97155, 104140, 265851, 88489, 88588, 91865, 104153, 88580, 89224, 90000, 93043, 95545, 104146, 88384, 88493, 89301, 88669, 89223, 89888, 91862, 88487, 89893, 104154, 104155, 88581, 89302, 104141, 104143, 104144, 104151, 89225, 89911, 89912, 91863, 104114, 104150 }

-- ============================ REGISTRATION ============================
-- Register consumables and runes with DataManager after expansion data is ready
local registrar = {}
AceEvent:Embed(registrar)

registrar:RegisterMessage("NAG_EXPANSION_DATA_LOADED", function()
    local DataManager = NAG:GetModule("DataManager")
    NAG:Debug("MistsConstants: Registering consumables with DataManager")

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
    for _, id in ipairs(ns.other) do
        DataManager:AddItem(id, { "Consumable", "Other" })
    end

    registrar:UnregisterMessage("NAG_EXPANSION_DATA_LOADED")
end)

