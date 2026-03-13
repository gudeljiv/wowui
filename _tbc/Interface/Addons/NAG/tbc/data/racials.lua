--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
    XXXhttps://creativecommons.org/licenses/by-nc/4.0/

    Author: Rakizi
    Date: 2024

    tbc racial abilities data
]]

local _, ns = ...
ns.data = ns.data or {}
ns.data.tbc = ns.data.tbc or {}
ns.data.tbc.Spells = ns.data.tbc.Spells or {}

-- Initialize mists racial data
ns.data.tbc.Spells.Racial = {
    -- Alliance Races
    --https://www.wowhead.com/mop-classic/race=1/human#racial-traits
    Human = { 20599, 20864, 20600, 20597, 20598 },

    --XXXhttps://www.wowhead.com/mop-classic/race=3/dwarf#racial-traits
    Dwarf = { 2481, 20596, 20595, 20594 },

    --XXXhttps://www.wowhead.com/mop-classic/race=4/night-elf#racial-traits
    NightElf = { 20583, 20582, 20580, 20585 },

    --XXXhttps://www.wowhead.com/mop-classic/race=7/gnome#racial-traits
    Gnome = { 20592, 20593, 20589, 20591 },

    --XXXhttps://www.wowhead.com/mop-classic/race=11/draenei#racial-traits
    Draenei = { 28875, 28880, 6562, 28878, 20579 },

    -- Horde Races
    --XXXhttps://www.wowhead.com/mop-classic/race=2/orc#racial-traits
    Orc = { 20574, 20572, 33697, 33702, 20575, 20573 },

    --XXXhttps://www.wowhead.com/mop-classic/race=5/undead#racial-traits
    Scourge = { 20577, 20579, 5227, 7744 },

    --XXXhttps://www.wowhead.com/mop-classic/race=6/tauren#racial-traits
    Tauren = { 20552, 20550, 20551, 20549 },

    --XXXhttps://www.wowhead.com/mop-classic/race=8/troll#racial-traits
    Troll = { 20557, 20554, 26297, 26296, 26290, 20555, 20558 },

    --XXXhttps://www.wowhead.com/mop-classic/race=10/blood-elf#racial-traits
    BloodElf = { 28877, 28730, 25046, 822, 28734 },

}
