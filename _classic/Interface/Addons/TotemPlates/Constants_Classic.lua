local select, string_lower = select, string.lower
local GetSpellInfo = GetSpellInfo
local LibStub = LibStub

local Core = LibStub("TotemPlates")
local L = Core.L

---------------------
-- TOTEM STUFF
---------------------

local totemDataShared, totemNpcIdsToTotemDataShared, totemSpellIdToPulseShared = Core:GetSharedTotemData()

local totemData = {
    -- Fire
    -- Water
    [string_lower("Poison Cleansing Totem")] = {id = 8166,texture = select(3, GetSpellInfo(8166)), color = {r = 0, g = 0, b = 0, a = 1}, pulse = 5},
    [string_lower("Mana Spring Totem")] = {id = 5675,texture = select(3, GetSpellInfo(5675)), color = {r = 0, g = 0, b = 0, a = 1}, pulse = 2},
    -- Earth
    -- Air
    [string_lower("Grace of Air Totem")] = {id = 8835,texture = select(3, GetSpellInfo(8835)), color = {r = 0, g = 0, b = 0, a = 1}},
    [string_lower("Windwall Totem")] = {id = 15107,texture = select(3, GetSpellInfo(15107)), color = {r = 0, g = 0, b = 0, a = 1}},
    [string_lower("Tranquil Air Totem")] = {id = 25908,texture = select(3, GetSpellInfo(25908)), color = {r = 0, g = 0, b = 0, a = 1}},
}

local totemSpellIdToPulse = {
    [GetSpellInfo(totemData[string_lower("Poison Cleansing Totem")].id)] = totemData[string_lower("Poison Cleansing Totem")].pulse,
    [8166] = totemData[string_lower("Poison Cleansing Totem")].pulse,
    [GetSpellInfo(totemData[string_lower("Mana Spring Totem")].id)] = totemData[string_lower("Mana Spring Totem")].pulse,
    [5675] = totemData[string_lower("Mana Spring Totem")].pulse, -- Rank 1
    [10495] = totemData[string_lower("Mana Spring Totem")].pulse, -- Rank 2
    [10496] = totemData[string_lower("Mana Spring Totem")].pulse, -- Rank 3
    [10497] = totemData[string_lower("Mana Spring Totem")].pulse, -- Rank 4
    [GetSpellInfo(totemDataShared[string_lower("Tremor Totem")].id)] = 4, -- Tremor Totem
    [8143] = 4, -- Tremor Totem
}

local totemNpcIdsToTotemData = {
    --fire
    -- Water
    [5923] = totemData[string_lower("Poison Cleansing Totem")],
    [22487] = totemData[string_lower("Poison Cleansing Totem")],

    -- Earth
    -- Air
    [7486] = totemData[string_lower("Grace of Air Totem")],
    [7487] = totemData[string_lower("Grace of Air Totem")],
    [15463] = totemData[string_lower("Grace of Air Totem")],

    [9687] = totemData[string_lower("Windwall Totem")],
    [9688] = totemData[string_lower("Windwall Totem")],
    [9689] = totemData[string_lower("Windwall Totem")],
    [15492] = totemData[string_lower("Windwall Totem")],

    [15803] = totemData[string_lower("Tranquil Air Totem")],
}


Core:AddEntriesToTable(totemData, totemDataShared)
Core:AddEntriesToTable(totemNpcIdsToTotemData, totemNpcIdsToTotemDataShared)
Core:AddEntriesToTable(totemSpellIdToPulse, totemSpellIdToPulseShared)

function Core:GetTotemData()
    return totemData, totemNpcIdsToTotemData, totemSpellIdToPulse
end
