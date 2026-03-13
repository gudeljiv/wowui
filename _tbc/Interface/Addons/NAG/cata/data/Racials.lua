--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
    XXXhttps://creativecommons.org/licenses/by-nc/4.0/

    Author: Rakizi
    Date: 2024

    Cataclysm racial abilities data
]]

local _, ns = ...
ns.data = ns.data or {}
ns.data.cata = ns.data.cata or {}
ns.data.cata.Spells = ns.data.cata.Spells or {}

-- Initialize Cataclysm racial data
ns.data.cata.Spells.Racial = {
    -- Alliance Races
    --XXXhttps://www.wowhead.com/cata/race=1/human#racial-traits
    Human = { 20599, 79738, 20864, 20597, 20598, 59752 },

    --XXXhttps://www.wowhead.com/cata/race=3/dwarf#racial-traits
    Dwarf = { 92682, 20596, 20595, 79739, 59224, 20594 },

    --XXXhttps://www.wowhead.com/cata/race=4/night-elf#racial-traits
    NightElf = { 76252, 20583, 20582, 58984, 20585 },

    --XXXhttps://www.wowhead.com/cata/race=7/gnome#racial-traits
    Gnome = { 20592, 20593, 20589, 20591, 79740, 92680 },

    --XXXhttps://www.wowhead.com/cata/race=11/draenei#racial-traits
    Draenei = { 28875, 59545, 59543, 59548, 59542, 59544, 59547, 28880, 6562, 28878, 79741, 59539, 59536, 59541, 59535, 59538, 59540, 59221 },

    --XXXhttps://www.wowhead.com/cata/race=22/worgen#racial-traits
    Worgen = { 68976, 68992, 94293, 68978, 79742, 87840, 68996, 68975 },

    -- Horde Races
    --XXXhttps://www.wowhead.com/cata/race=2/orc#racial-traits
    Orc = { 20574, 33702, 20572, 33697, 54562, 65222, 20575, 20573, 79743 },

    --XXXhttps://www.wowhead.com/cata/race=5/undead#racial-traits
    Scourge = { 20577, 79747, 20579, 5227, 7744 },

    --XXXhttps://www.wowhead.com/cata/race=6/tauren#racial-traits
    Tauren = { 20552, 20550, 79746, 20551, 20549 },

    --XXXhttps://www.wowhead.com/cata/race=8/troll#racial-traits
    Troll = { 20557, 26297, 26290, 58943, 79744, 20555, 20558 },

    --XXXhttps://www.wowhead.com/cata/race=9/goblin#racial-traits
    Goblin = { 69044, 69045, 79749, 69046, 69041, 69070, 69042 },

    --XXXhttps://www.wowhead.com/cata/race=10/blood-elf#racial-traits
    BloodElf = { 28877, 822, 28730, 50613, 80483, 25046, 69179, 79748 }
}
