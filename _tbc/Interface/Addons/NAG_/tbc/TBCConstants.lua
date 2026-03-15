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
    NOTES: Constants for vanilla WoW consumables, sourced from WoWSims
]]
-- ======= LOCALIZE =======
--Addon
local _, ns = ...
local AceEvent = ns.AceEvent

local Version = ns.Version

if not Version:IsTBC() then return end


-- Battle Elixirs
ns.battleElixirs = { 22831, 22825, 28103, 22824, 22835, 28104, 31679, 22833, 22827, 34537, 28102 }

-- Guardian Elixirs
ns.guardianElixirs = { 32067, 22834, 22840, 32062, 32068, 22848, 32063 }

-- Combine both elixir types for consistency with Cata
ns.elixirs = {}
for _, id in ipairs(ns.battleElixirs) do table.insert(ns.elixirs, id) end
for _, id in ipairs(ns.guardianElixirs) do table.insert(ns.elixirs, id) end

-- Flasks
ns.flasks = { 22861, 22854, 22866, 22851, 22853, 32598, 32900, 32899, 33208, 32898, 32601, 32766, 32901, 35717, 32767, 32764, 32765, 32600, 32597, 35716, 32596, 32599 }
tinsert(ns.flasks, 7676) -- Thistle Tea
-- Food and Drink
ns.food = { 27860, 23848, 33874, 29112, 33052, 27657, 27666, 27665, 31672, 31673, 33866, 27658, 33053, 27667, 32685, 33872, 27659, 29401, 30361, 30358, 32453, 38429, 32686, 38428, 24072, 28399, 20857, 24009, 29394, 34062, 38427, 38431, 28284, 28486, 29293, 29412, 34832, 27854, 35710, 27664, 27651, 29449, 32455, 38466, 27660, 30357, 27656, 32722, 33042, 33048, 34411, 27655, 29451, 22018, 24338, 27858, 30155, 34780, 35565, 35720, 22019, 32721, 33924, 23495, 27662, 27857, 28112, 28501, 29292, 22645, 24539, 27661, 27663, 29393, 29452, 30610, 30816, 32667, 32668, 33825, 33867, 23704, 24008, 24105, 27635, 27636, 27855, 27856, 27859, 29448, 33004, 38430, 38432, 23756, 29395, 29402, 29450, 29453, 29454, 30355, 30359, 30457, 30458, 30703, 35563 }
ns.drink = {}

-- Temporary Item Enhancements
ns.temporaryEnhancements = { 22522, 23529, 28421, 25521, 23576, 22521, 23559, 23575, 28420, 34538, 23528, 25679, 21927, 22055, 34539, 34861, 22054, 22053, 31535, 21835 }

-- Permanent Item Enhancements
ns.permanentEnhancements = { 29535, 24274, 29192, 29536, 29191, 28888, 23530, 28886, 24276, 23766, 24273, 28887, 23765, 28909, 34836, 29189, 34330, 24275, 29186, 28911, 29533, 29534, 29190, 28889, 30845, 29868, 28910, 28912, 29195, 29193, 28885, 28907, 34207, 25651, 29197, 30846, 25650, 29483, 28882, 29198, 28908, 29187, 29196, 29488, 29485, 29486, 33185, 29194, 29199, 28881, 35729, 25652, 23764, 28903, 29188, 35728, 37312, 28878, 28904, 29487, 35730, 35731 }

-- Combine both enhancement types for consistency with Cata
ns.itemEnhancements = {}
for _, id in ipairs(ns.temporaryEnhancements) do table.insert(ns.itemEnhancements, id) end
for _, id in ipairs(ns.permanentEnhancements) do table.insert(ns.itemEnhancements, id) end


-- Combat Potions
ns.potions = { 22838, 22839, 22832, 34440, 22849, 22829, 22836, 31677, 22826, 22850, 28100, 32948, 22846, 33935, 22828, 32844, 32902, 32846, 22837, 32845, 33934, 22871, 32847, 22845, 32905, 22841, 28101, 32840, 22842, 22847, 22844, 25548, 32762, 32947, 30793, 31676, 32763 }

-- Scrolls
ns.scrolls = { 27498, 27503, 27500, 27501, 27502, 27499 }

ns.other = { 29529, 185848, 35446, 29528, 33093, 29530, 23381, 29531, 32852, 29841, 23862, 35429, 185851, 24268, 23768, 35444, 35425, 29532, 35458, 23864, 35455, 33081, 34504, 29840, 29863, 22105, 29842, 30193, 32965, 32966, 35436, 22103, 23769, 29852, 29872, 30199, 31845, 32952, 33092, 33315, 35432, 35440, 35441, 35396, 23354, 35398, 29853, 35445, 23865, 32839, 23770, 29873, 32576, 33933, 35447, 23822, 35419, 35456, 35397, 35448, 35453, 32775, 35400, 35420, 35439, 35460, 187815, 32851, 34258, 35418, 35430, 35433, 35451, 23329, 24538, 25886, 35434, 35443, 187737, 22104, 33930, 35287, 35427, 35438, 187739, 23771, 24269, 29845, 29856, 32850, 35399, 35428, 35431, 35437, 35459, 35462, 185852, 23823, 23857, 25550, 29839, 29858, 31847, 32849, 32967, 35417, 35423, 35426, 35442, 35452, 35454, 35457, 185850, 187783, 23334, 29837, 29838, 29844, 29849, 29851, 29854, 29862, 29866, 29869, 31844, 31848, 33083, 33931, 33932, 35421, 35422, 35435, 35449, 35461, 187800, 23386, 24491, 24541, 29843, 29846, 29847, 29848, 29850, 29857, 29859, 29860, 29864, 29867, 29870, 29871, 29874, 30195, 30197, 30198, 30877, 31437, 31842, 31843, 31846, 31849, 35424, 35450, 38308, 185849, 187738, 187740, 187801, 187807, 187814 }

-- Register consumables and runes with DataManager after expansion data is ready
local registrar = {}
AceEvent:Embed(registrar)

registrar:RegisterMessage("NAG_EXPANSION_DATA_LOADED", function()
    local DataManager = NAG:GetModule("DataManager")
    NAG:Debug("TBCConstants: Registering consumables with DataManager")

    -- Flasks
    for _, id in ipairs(ns.flasks) do
        DataManager:AddItem(id, { "Consumable", "Flask" })
    end
    -- Battle Elixirs
    for _, id in ipairs(ns.battleElixirs) do
        DataManager:AddItem(id, { "Consumable", "BattleElixir" })
    end
    -- Guardian Elixirs
    for _, id in ipairs(ns.guardianElixirs) do
        DataManager:AddItem(id, { "Consumable", "GuardianElixir" })
    end
    -- Elixirs (combined)
    for _, id in ipairs(ns.elixirs) do
        DataManager:AddItem(id, { "Consumable", "Elixir" })
    end
    -- Potions
    for _, id in ipairs(ns.potions) do
        DataManager:AddItem(id, { "Consumable", "Potion" })
    end
    -- Temporary Enhancements
    for _, id in ipairs(ns.temporaryEnhancements) do
        DataManager:AddItem(id, { "Consumable", "TempEnhancement" })
    end
    -- Permanent Enhancements
    for _, id in ipairs(ns.permanentEnhancements) do
        DataManager:AddItem(id, { "Consumable", "PermEnhancement" })
    end
    -- Item Enhancements (combined)
    for _, id in ipairs(ns.itemEnhancements) do
        DataManager:AddItem(id, { "Consumable", "Enhancement" })
    end
    -- Food
    for _, id in ipairs(ns.food) do
        DataManager:AddItem(id, { "Consumable", "Food" })
    end
    -- Drink
    for _, id in ipairs(ns.drink) do
        DataManager:AddItem(id, { "Consumable", "Drink" })
    end
    -- Scrolls
    for _, id in ipairs(ns.scrolls) do
        DataManager:AddItem(id, { "Consumable", "Scroll" })
    end
    for _, id in ipairs(ns.other) do
        DataManager:AddItem(id, { "Consumable", "Other" })
    end

    registrar:UnregisterMessage("NAG_EXPANSION_DATA_LOADED")
end)
