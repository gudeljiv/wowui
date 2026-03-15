--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
    XXXhttps://creativecommons.org/licenses/by-nc/4.0/

    Author: Rakizi
    Date: 2024

    SoD racial abilities data
]]

local _, ns = ...
ns.data = ns.data or {}
ns.data.sod = ns.data.sod or {}
ns.data.sod.Spells = ns.data.sod.Spells or {}

-- Initialize SoD racial data
ns.data.sod.Spells.Racial = {
    -- Alliance Races
    --XXXhttps://www.wowhead.com/classic/race=1/human#racial-traits
    Human = { 20599, 20864, 20600, 20597, 20598 },

    --XXXhttps://www.wowhead.com/classic/race=3/dwarf#racial-traits
    Dwarf = { 2481, 20596, 20595, 20594 },

    --XXXhttps://www.wowhead.com/classic/race=4/night-elf#racial-traits
    NightElf = { 20583, 20582, 20580, 20585 },

    --XXXhttps://www.wowhead.com/classic/race=7/gnome#racial-traits
    Gnome = { 20592, 20593, 20589, 20591 },

    -- Horde Races
    --XXXhttps://www.wowhead.com/classic/race=2/orc#racial-traits
    Orc = { 20574, 20572, 20575, 20573 },

    --XXXhttps://www.wowhead.com/classic/race=5/undead#racial-traits
    Scourge = { 20577, 20579, 5227, 7744 },

    --XXXhttps://www.wowhead.com/classic/race=6/tauren#racial-traits
    Tauren = { 20552, 20550, 20551, 20549 },

    --XXXhttps://www.wowhead.com/classic/race=8/troll#racial-traits
    Troll = { 20557, 20554, 26297, 26296, 26290, 20555, 20558 },
}
