-- Localization.lua
local _, addon = ...

-- Default to English
local locale = GetLocale()

-- Create localization table
addon.L = {}
local L = addon.L

if locale == "esES" or locale == "esMX" then
    -- Spanish
    L["BINDING_HEADER_EXTRAACTIONBARS"] = "Barras de Acción Personalizadas"
    
    -- Bar 6 buttons
    for i = 1, 12 do
        L["BINDING_NAME_CLICK CustomBar6Button"..i..":LeftButton"] = "Barra 6 - Botón "..i
    end
    
    -- Bar 7 buttons
    for i = 1, 12 do
        L["BINDING_NAME_CLICK CustomBar7Button"..i..":LeftButton"] = "Barra 7 - Botón "..i
    end
    
    -- Commands and messages
    L["TOGGLE_BAR6"] = "Mostrar/ocultar barra 6"
    L["TOGGLE_BAR7"] = "Mostrar/ocultar barra 7"
    L["TOGGLE_POSITION"] = "Cambiar posición de barra 7"
    L["BAR6_VISIBLE"] = "Barra 6 visible"
    L["BAR6_HIDDEN"] = "Barra 6 oculta"
    L["BAR7_VISIBLE"] = "Barra 7 visible"
    L["BAR7_HIDDEN"] = "Barra 7 oculta"
    L["BAR7_MOVED_TOP"] = "Barra 7 movida arriba de barra 6"
    L["BAR7_MOVED_BOTTOM"] = "Barra 7 movida arriba de barra 2"
    L["COMBAT_LOCKDOWN"] = "No puedes modificar las barras durante el combate"
    L["AVAILABLE_COMMANDS"] = "Comandos disponibles:"
else
    -- English (default)
    L["BINDING_HEADER_EXTRAACTIONBARS"] = "Custom Action Bars"
    
    -- Bar 6 buttons
    for i = 1, 12 do
        L["BINDING_NAME_CLICK CustomBar6Button"..i..":LeftButton"] = "Bar 6 - Button "..i
    end
    
    -- Bar 7 buttons
    for i = 1, 12 do
        L["BINDING_NAME_CLICK CustomBar7Button"..i..":LeftButton"] = "Bar 7 - Button "..i
    end
    
    -- Commands and messages
    L["TOGGLE_BAR6"] = "Show/hide bar 6"
    L["TOGGLE_BAR7"] = "Show/hide bar 7"
    L["TOGGLE_POSITION"] = "Toggle bar 7 position"
    L["BAR6_VISIBLE"] = "Bar 6 visible"
    L["BAR6_HIDDEN"] = "Bar 6 hidden"
    L["BAR7_VISIBLE"] = "Bar 7 visible"
    L["BAR7_HIDDEN"] = "Bar 7 hidden"
    L["BAR7_MOVED_TOP"] = "Bar 7 moved above bar 6"
    L["BAR7_MOVED_BOTTOM"] = "Bar 7 moved above bar 2"
    L["COMBAT_LOCKDOWN"] = "You cannot modify action bars during combat"
    L["AVAILABLE_COMMANDS"] = "Available commands:"
end

-- Global bindings text
BINDING_HEADER_EXTRAACTIONBARS = L["BINDING_HEADER_EXTRAACTIONBARS"]
for i = 1, 12 do
    _G["BINDING_NAME_CLICK CustomBar6Button"..i..":LeftButton"] = L["BINDING_NAME_CLICK CustomBar6Button"..i..":LeftButton"]
    _G["BINDING_NAME_CLICK CustomBar7Button"..i..":LeftButton"] = L["BINDING_NAME_CLICK CustomBar7Button"..i..":LeftButton"]
end