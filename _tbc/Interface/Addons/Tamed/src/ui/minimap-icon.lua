local ADDON_NAME, Addon = ...
local Colors = Addon:GetModule("Colors")
local DB = Addon:GetModule("DB")
local L = Addon:GetModule("Locale")
local LDB = Addon:GetLibrary("LDB")
local LDBIcon = Addon:GetLibrary("LDBIcon")
local MinimapIcon = Addon:GetModule("MinimapIcon")
local PinHelper = Addon:GetModule("PinHelper")
local UI = Addon:GetModule("UI")

-- Initialize LDB object.
function MinimapIcon:Initialize()
  local object = LDB:NewDataObject(ADDON_NAME, {
    type = "data source",
    text = ADDON_NAME,
    icon = Addon.ICON,

    OnClick = function(_, button)
      if button == "LeftButton" then
        UI:Toggle()
      elseif button == "RightButton" then
        PinHelper:Clear()
      end
    end,

    OnTooltipShow = function(tooltip)
      tooltip:AddDoubleLine(
        Colors.Primary(ADDON_NAME),
        Addon.VERSION
      )
      tooltip:AddLine(" ")
      tooltip:AddDoubleLine(L.LEFT_CLICK, L.TOGGLE_UI, nil, nil, nil, 1, 1, 1)
      tooltip:AddDoubleLine(L.RIGHT_CLICK, L.CLEAR_PINS, nil, nil, nil, 1, 1, 1)
    end,
  })

  LDBIcon:Register(ADDON_NAME, object, DB.global.minimapIcon)
  self.Initialize = nil
end

-- Displays the minimap icon.
function MinimapIcon:Show()
  DB.global.minimapIcon.hide = false
  LDBIcon:Show(ADDON_NAME)
end

-- Hides the minimap icon.
function MinimapIcon:Hide()
  DB.global.minimapIcon.hide = true
  LDBIcon:Hide(ADDON_NAME)
end

-- Toggles the minimap icon.
function MinimapIcon:Toggle()
  if DB.global.minimapIcon.hide then
    self:Show()
  else
    self:Hide()
  end
end
