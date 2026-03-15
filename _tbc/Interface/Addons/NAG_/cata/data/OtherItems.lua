--[[
    Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
    https://creativecommons.org/licenses/by-nc/4.0/

    Author: Rakizi
    Date: 2024

    Cataclysm item data
]]

local _, ns = ...

ns.data = ns.data or {}
ns.data.cata = ns.data.cata or {}
ns.data.cata.Items = ns.data.cata.Items or {}
-- Initialize Cataclysm item data
ns.data.cata.Items.OtherItems = {
    -- Trinkets
    Trinket = {
    },
    -- Consumables
    Consumable = { 36799 },
    -- Weapons
    Weapon = {},

    -- Engineering items (Cata specific)
    Engineering = {
        -- Tinkers
        tinker = {
            Spells = { 82174, 41903, 96230, 96228, 96229, 54758 },
        },
        -- Gadgets
        gadget = {
        },
    },
}
