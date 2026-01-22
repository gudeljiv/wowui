local ADDON_NAME, Addon = ...

-- ============================================================================
-- Consts
-- ============================================================================

Addon.VERSION = C_AddOns.GetAddOnMetadata(ADDON_NAME, "Version")
Addon.ICON = "Interface\\ICONS\\Ability_Hunter_BeastTaming"

-- ============================================================================
-- Functions
-- ============================================================================

do -- Addon:GetModule()
  local modules = {}

  function Addon:GetModule(key)
    key = key:upper()
    if type(modules[key]) ~= "table" then modules[key] = {} end
    return modules[key]
  end
end

do -- Addon:GetLibrary()
  local libraries = {
    AceAddon = LibStub("AceAddon-3.0"):NewAddon(ADDON_NAME, "AceConsole-3.0"),
    AceGUI = LibStub("AceGUI-3.0"),
    HBD = LibStub("HereBeDragons-2.0"),
    HBDPins = LibStub("HereBeDragons-Pins-2.0"),
    LDB = LibStub("LibDataBroker-1.1"),
    LDBIcon = LibStub("LibDBIcon-1.0")
  }

  function Addon:GetLibrary(key)
    return libraries[key] or error("Invalid library: " .. key)
  end
end

do -- AceAddon:OnInitialize().
  local AceAddon = Addon:GetLibrary("AceAddon")

  function AceAddon:OnInitialize()
    Addon:GetModule("DB"):Initialize()
    Addon:GetModule("MinimapIcon"):Initialize()
    Addon:GetModule("Commands"):Initialize()
  end
end
