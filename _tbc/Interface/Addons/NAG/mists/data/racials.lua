--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
    XXXhttps://creativecommons.org/licenses/by-nc/4.0/

    Author: Rakizi
    Date: 2024

    mists racial abilities data
]]

local _, ns = ...
ns.data = ns.data or {}
ns.data.mists = ns.data.mists or {}
ns.data.mists.Spells = ns.data.mists.Spells or {}

-- Initialize mists racial data
ns.data.mists.Spells.Racial = {
    -- Alliance Races
    --https://www.wowhead.com/mop-classic/race=1/human#racial-traits
    Human = { 59752 },

    --XXXhttps://www.wowhead.com/mop-classic/race=3/dwarf#racial-traits
    Dwarf = { 20594 },

    --XXXhttps://www.wowhead.com/mop-classic/race=4/night-elf#racial-traits
    NightElf = { 58984 },

    --XXXhttps://www.wowhead.com/mop-classic/race=7/gnome#racial-traits
    Gnome = { 20589 },

    --XXXhttps://www.wowhead.com/mop-classic/race=11/draenei#racial-traits
    Draenei = { 28880 },

    --XXXhttps://www.wowhead.com/mop-classic/race=22/worgen#racial-traits
    Worgen = { 68992 },

    -- Horde Races
    --XXXhttps://www.wowhead.com/mop-classic/race=2/orc#racial-traits
    Orc = { 20572, 33697 },

    --XXXhttps://www.wowhead.com/mop-classic/race=5/undead#racial-traits
    Scourge = { 7744 },

    --XXXhttps://www.wowhead.com/mop-classic/race=6/tauren#racial-traits
    Tauren = { 20549 },

    --XXXhttps://www.wowhead.com/mop-classic/race=8/troll#racial-traits
    Troll = { 26297 },

    --XXXhttps://www.wowhead.com/mop-classic/race=9/goblin#racial-traits
    Goblin = { 69041, 69042 },

    --XXXhttps://www.wowhead.com/mop-classic/race=10/blood-elf#racial-traits
    BloodElf = { 28730 },

    --XXXhttps://www.wowhead.com/mop-classic/race=24/pandaren#racial-traits
    Pandaren = { 107072 },

}
