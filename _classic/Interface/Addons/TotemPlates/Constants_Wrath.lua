local select, string_lower = select, string.lower
local GetSpellInfo = GetSpellInfo
local LibStub = LibStub

local Core = LibStub("TotemPlates")
local L = Core.L

---------------------
-- TOTEM STUFF
---------------------

local totemData = {
    -- Fire
    [string_lower("Fire Elemental Totem")] = {id = 32982,texture = select(3, GetSpellInfo(32982)), color = {r = 0, g = 0, b = 0, a = 1}},
    [string_lower("Totem of Wrath")] = {id = 30706,texture = select(3, GetSpellInfo(30706)), color = {r = 0, g = 0, b = 0, a = 1}},
    -- Water
    [string_lower("Disease Cleansing Totem")] = {id = 8170,texture = select(3, GetSpellInfo(8170)), color = {r = 0, g = 0, b = 0, a = 1}, pulse = 3},
    [string_lower("Mana Spring Totem")] = { id = 5675, texture = select(3, GetSpellInfo(5675)), color = { r = 0, g = 0, b = 0, a = 1 } },
    -- Earth
    [string_lower("Earth Elemental Totem")] = {id = 33663,texture = select(3, GetSpellInfo(33663)), color = {r = 0, g = 0, b = 0, a = 1}},
    -- Air
    [string_lower("Wrath of Air Totem")] = {id = 3738,texture = select(3, GetSpellInfo(3738)), color = {r = 0, g = 0, b = 0, a = 1}},
}

local totemSpellIdToPulse = {
    [GetSpellInfo(totemData[string_lower("Disease Cleansing Totem")].id)] = totemData[string_lower("Disease Cleansing Totem")].pulse,
    [8170] = totemData[string_lower("Disease Cleansing Totem")].pulse,
}

local totemNpcIdsToTotemData = {
    [5924] = totemData[string_lower("Disease Cleansing Totem")],

    [3573] = totemData[string_lower("Mana Spring Totem")],
    [7414] = totemData[string_lower("Mana Spring Totem")],
    [7415] = totemData[string_lower("Mana Spring Totem")],
    [7416] = totemData[string_lower("Mana Spring Totem")],
    [15304] = totemData[string_lower("Mana Spring Totem")],
    [15489] = totemData[string_lower("Mana Spring Totem")],
    [31186] = totemData[string_lower("Mana Spring Totem")],
    [31189] = totemData[string_lower("Mana Spring Totem")],
    [31190] = totemData[string_lower("Mana Spring Totem")],


}

local totemDataShared, totemNpcIdsToTotemDataShared, totemSpellIdToPulseShared = Core:GetSharedTotemData()
Core:AddEntriesToTable(totemData, totemDataShared)
Core:AddEntriesToTable(totemNpcIdsToTotemData, totemNpcIdsToTotemDataShared)
Core:AddEntriesToTable(totemSpellIdToPulse, totemSpellIdToPulseShared)

function Core:GetTotemData()
    return totemData, totemNpcIdsToTotemData, totemSpellIdToPulse
end