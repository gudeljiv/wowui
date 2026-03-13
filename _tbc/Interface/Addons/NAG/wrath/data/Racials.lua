--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
    XXXhttps://creativecommons.org/licenses/by-nc/4.0/

    Author: Rakizi
    Date: 2025

    Wrath of the Lich King (WotLK) racial abilities data.
    Same races as TBC; spell IDs for WotLK 3.x.
]]

local _, ns = ...
ns.data = ns.data or {}
ns.data.wrath = ns.data.wrath or {}
ns.data.wrath.Spells = ns.data.wrath.Spells or {}

ns.data.wrath.Spells.Racial = {
    -- Alliance Races
    -- XXXhttps://www.wowhead.com/wotlk/race=1/human#racial-traits
    Human = { 20599, 59752, 20864, 20597, 20598 },

    -- XXXhttps://www.wowhead.com/wotlk/race=3/dwarf#racial-traits
    Dwarf = { 20596, 20595, 2481, 20594 },

    -- XXXhttps://www.wowhead.com/wotlk/race=4/night-elf#racial-traits
    NightElf = { 20583, 20582, 20580, 58984, 20585 },

    -- XXXhttps://www.wowhead.com/wotlk/race=7/gnome#racial-traits
    Gnome = { 20592, 20593, 20589, 20591 },

    -- XXXhttps://www.wowhead.com/wotlk/race=11/draenei#racial-traits
    Draenei = { 28875, 28880, 6562, 28878, 59542, 59543, 59544, 59545, 59547, 59548 },

    -- Horde Races
    -- XXXhttps://www.wowhead.com/wotlk/race=2/orc#racial-traits
    Orc = { 20574, 20572, 33697, 33702, 20575, 20573 },

    -- XXXhttps://www.wowhead.com/wotlk/race=5/undead#racial-traits
    Scourge = { 20577, 20579, 5227, 7744 },

    -- XXXhttps://www.wowhead.com/wotlk/race=6/tauren#racial-traits
    Tauren = { 20552, 20550, 20551, 20549 },

    -- XXXhttps://www.wowhead.com/wotlk/race=8/troll#racial-traits
    Troll = { 20557, 26297, 26290, 58943, 20555, 20558 },

    -- XXXhttps://www.wowhead.com/wotlk/race=10/blood-elf#racial-traits
    BloodElf = { 28877, 822, 28730, 25046, 50613 },
}
