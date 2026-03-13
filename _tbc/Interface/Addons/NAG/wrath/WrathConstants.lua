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
    NOTES: Constants for Wrath of the Lich King consumables
]]

-- ======= LOCALIZE =======
-- Addon
local _, ns = ...
local AceEvent = ns.AceEvent
local Version = ns.Version

if not Version:IsWrath() then return end

-- Flasks
ns.flasks = { 46376, 46377, 44939, 46379, 40079, 47499, 46378, 40082, 45009, 40404, 40083, 40084, 45008, 45007, 45006 }

-- Battle Elixirs
ns.battleElixirs = { 44330, 40070, 39666, 44331, 40076, 44325, 44329, 40072, 40073, 45621, 40109, 44327, 40068 }

-- Guardian Elixirs
ns.guardianElixirs = { 44332, 40097, 44328, 40078 }

-- Combine both elixir types for consistency
ns.elixirs = {}
for _, id in ipairs(ns.battleElixirs) do table.insert(ns.elixirs, id) end
for _, id in ipairs(ns.guardianElixirs) do table.insert(ns.elixirs, id) end

-- Combat Potions
ns.potions = { 40211, 33447, 40212, 40093, 40077, 33448, 39327, 40081, 41166, 42545, 43569, 39671, 40067, 43570, 38351, 36770, 37926, 40214, 40215, 40213, 43531, 45276, 40087, 40677, 43530, 39971, 40216, 40217, 44728, 45277 }

-- Temporary Item Enhancements
ns.temporaryEnhancements = { 46006, 43231, 43233, 36900, 43234, 41174, 41196, 41191, 43237, 43235, 41169, 43232, 36899, 41173, 41170, 41193, 41194, 41172, 41192, 43230, 41195, 40773, 41171 }

-- Permanent Item Enhancements
ns.permanentEnhancements = { 41611, 44149, 38374, 44957, 44135, 44133, 41602, 44159, 50369, 50367, 50335, 44493, 44936, 41604, 44465, 44150, 50368, 44075, 41167, 38373, 38979, 44152, 44136, 50338, 44963, 41976, 44069, 38925, 44067, 41111, 41118, 44068, 38986, 50370, 44458, 38873, 38877, 44871, 39006, 44457, 44560, 44559, 45056, 44134, 44561, 44872, 44815, 50336, 38838, 44467, 38880, 39003, 44739, 38378, 38865, 44137, 44879, 44131, 50337, 44874, 44878, 38837, 44877, 45628, 38835, 38847, 38921, 44470, 38375, 38803, 38813, 38859, 38788, 38841, 41093, 44455, 38770, 38814, 38834, 38866, 38887, 38890, 38904, 38949, 38985, 38989, 44701, 38867, 38954, 38990, 41091, 46098, 38776, 38959, 38961, 38973, 44453, 44563, 46026, 38372, 38918, 38967, 41146, 44132, 44141, 50373, 38882, 38892, 38935, 38945, 38947, 38376, 38863, 38938, 44129, 44139, 38371, 38766, 38857, 38860, 38868, 38944, 50372, 38884, 38889, 38942, 38951, 38966, 38995, 42500, 38679, 38833, 38842, 38852, 38872, 38978, 39005, 44138, 44140, 44702, 44946, 45060, 38812, 38846, 38850, 38878, 38886, 38894, 38906, 38991, 40776, 43987, 38845, 38871, 38943, 38976, 38977, 44463, 44562, 44876, 38781, 38801, 38811, 38854, 38928, 38930, 38939, 38955, 38975, 38984, 38987, 41601, 44875, 37603, 38809, 38828, 38915, 44947, 38774, 38784, 38802, 38817, 38821, 38839, 38855, 38856, 38862, 38885, 38902, 38903, 38931, 38932, 38968, 38972, 38981, 38982, 38997, 44456, 44466, 44469, 38377, 38767, 38772, 38779, 38782, 38789, 38792, 38793, 38794, 38807, 38808, 38823, 38826, 38830, 38848, 38861, 38883, 38888, 38895, 38896, 38897, 38901, 38909, 38910, 38913, 38916, 38948, 38960, 38962, 38964, 38965, 38969, 38970, 38974, 38988, 44125, 44126, 44449, 44881, 44883, 44884, 38768, 38769, 38771, 38780, 38783, 38787, 38795, 38797, 38799, 38804, 38818, 38824, 38829, 38836, 38849, 38853, 38858, 38869, 38891, 38907, 38933, 38934, 38936, 38937, 38953, 38956, 38957, 38980, 38983, 39000, 39001, 39002, 41603, 44124, 44497, 44882, 50816, 38773, 38777, 38778, 38785, 38791, 38796, 38798, 38800, 38805, 38806, 38810, 38819, 38822, 38825, 38827, 38832, 38840, 38844, 38851, 38870, 38874, 38875, 38879, 38893, 38898, 38900, 38905, 38908, 38911, 38917, 38919, 38920, 38923, 38924, 38926, 38927, 38929, 38946, 38950, 38958, 38963, 38971, 38992, 38993, 38994, 38999, 39004, 39300, 43097, 44130, 44880, 38775, 38786, 38790, 38815, 38816, 38820, 38831, 38843, 38864, 38876, 38881, 38899, 38912, 38914, 38922, 38940, 38941, 38996, 38998, 44873 }

-- Combine both enhancement types for consistency
ns.itemEnhancements = {}
for _, id in ipairs(ns.temporaryEnhancements) do table.insert(ns.itemEnhancements, id) end
for _, id in ipairs(ns.permanentEnhancements) do table.insert(ns.itemEnhancements, id) end

-- Food and Drink
ns.food = { 34747, 43015, 34752, 34767, 43005, 43268, 43000, 43478, 34753, 35949, 45932, 34755, 34754, 43523, 43004, 44228, 44114, 39520, 34763, 42431, 35948, 42995, 43490, 43492, 34748, 43488, 44854, 42999, 43480, 42996, 42997, 34125, 42994, 35950, 40359, 41729, 33454, 34751, 46887, 46784, 34750, 44839, 35953, 37252, 33445, 34765, 38350, 40356, 44838, 44855, 33452, 43491, 44722, 34762, 43695, 46797, 34764, 35947, 42942, 43001, 43236, 43696, 44608, 34756, 34769, 42777, 43518, 44616, 44837, 33444, 34766, 35954, 40042, 41731, 45279, 33451, 34749, 35952, 42998, 44619, 34760, 44617, 44620, 46793, 46796, 33443, 34768, 40035, 42428, 42433, 43086, 44571, 44607, 46691, 33449, 34761, 34770, 36831, 38706, 40358, 42434, 42993, 44575, 44618, 44749, 44836, 35951, 37253, 40036, 40202, 40357, 41751, 42429, 42432, 42778, 43087, 44049, 44071, 44573, 44791, 44840, 44940, 44941, 46690, 34757, 34758, 44072, 44570, 44574, 44609, 44750, 44953, 45901, 34759, 37452, 38698, 39691, 42430, 42779 }

-- Scrolls
ns.scrolls = { 49632, 37092, 43468, 37118, 37098, 43466, 44315, 43467, 33457, 33461, 37094, 37097, 43464, 33458, 33460, 37091, 43463, 43465, 49768, 37093, 44314, 33459, 33462 }

-- Miscellaneous items
ns.other = { 49633, 39969, 44711, 44115, 44710, 49634, 49702, 43850, 43950, 36892, 41509, 43002, 42420, 36771, 44713, 36891, 39972, 41427, 44506, 45718, 45719, 42986, 45706, 45723, 39213, 43303, 38571, 42421, 37464, 36894, 38474, 38475, 38478, 43302, 44507, 45715, 46845, 36890, 36893, 38266, 38476, 41367, 43304, 45714, 45717, 45720, 45721, 36889, 45716, 45722, 46852 }

-- ============================ REGISTRATION ============================
-- Register consumables with DataManager after expansion data is ready
local registrar = {}
AceEvent:Embed(registrar)

registrar:RegisterMessage("NAG_EXPANSION_DATA_LOADED", function()
    local DataManager = NAG:GetModule("DataManager")
    NAG:Debug("WrathConstants: Registering consumables with DataManager")

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
    for _, id in ipairs(ns.scrolls) do
        DataManager:AddItem(id, { "Consumable", "Scroll" })
    end
    for _, id in ipairs(ns.other) do
        DataManager:AddItem(id, { "Consumable", "Other" })
    end

    registrar:UnregisterMessage("NAG_EXPANSION_DATA_LOADED")
end)

