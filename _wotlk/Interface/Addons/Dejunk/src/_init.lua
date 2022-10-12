local ADDON_NAME, Addon = ...

Addon.VERSION = GetAddOnMetadata(ADDON_NAME, "Version")
Addon.IS_RETAIL = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
Addon.IS_VANILLA = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
Addon.IS_WRATH = WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC
Addon.IS_CLASSIC = Addon.IS_VANILLA or Addon.IS_WRATH

-- ============================================================================
-- Tables
-- ============================================================================

-- Libs.
Addon.Libs = {
  LDB = LibStub("LibDataBroker-1.1"),
  LDBIcon = LibStub("LibDBIcon-1.0")
}

-- Locale.
Addon.Locale = setmetatable({}, {
  __index = function(t, k)
    return rawget(t, k) or k
  end
})

do -- Colors.
  Addon.Colors = {}

  local colors = {
    White = "FFFFFFFF",
    Blue = "FF4FAFE3",
    Red = "FFE34F4F",
    Green = "FF4FE34F",
    Yellow = "FFE3E34F",
    Gold = "FFFFD100",
    Grey = "FF9D9D9D",
    DarkGrey = "FF1E1E1E"
  }

  for name, hex in pairs(colors) do
    local color = CreateColorFromHexString(hex)

    local t = setmetatable({}, {
      __call = function(self, text, alpha)
        alpha = (alpha or 1) * 255
        local _hex = ("%.2x%.2x%.2x%.2x"):format(alpha, color:GetRGBAsBytes())
        return WrapTextInColorCode(text or "", _hex)
      end
    })

    function t:GetRGB()
      return color:GetRGB()
    end

    function t:GetRGBA(alpha)
      local r, g, b, a = color:GetRGBA()
      return r, g, b, alpha or a
    end

    function t:GetHex(alpha)
      alpha = (alpha or 1) * 255
      return ("%.2x%.2x%.2x%.2x"):format(alpha, color:GetRGBAsBytes())
    end

    Addon.Colors[name] = t
  end
end

do -- Sounds.
  Addon.Sounds = {}

  local sounds = {
    Click = SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON,
    Repair = SOUNDKIT.ITEM_REPAIR,
    WindowOpened = SOUNDKIT.IG_CHARACTER_INFO_TAB,
    WindowClosed = SOUNDKIT.IG_MAINMENU_CLOSE
  }

  for name, id in pairs(sounds) do
    Addon.Sounds[name] = function() PlaySound(id) end
  end
end

-- Events.
Addon.Events = {}
Addon.EventManager = {}

-- SavedVariables.
Addon.SavedVariables = {}

-- Commands.
Addon.Commands = {}

-- Items.
Addon.Items = {}

-- Lists.
Addon.Lists = {
  Inclusions = {},
  Exclusions = {}
}

-- JunkFilter.
Addon.JunkFilter = {}

-- Seller.
Addon.Seller = {}

-- Destroyer.
Addon.Destroyer = {}

-- Confirmer.
Addon.Confirmer = {}

-- UserInterface.
Addon.UserInterface = {
  JunkFrame = {},
  TransportFrame = {},
  Widgets = {}
}

-- Tooltip.
Addon.Tooltip = {
  Show = function() GameTooltip:Show() end,
  Hide = function() GameTooltip:Hide() end,
  SetOwner = function(_, ...) GameTooltip:SetOwner(...) end,
  SetText = function(_, text) GameTooltip:SetText(Addon.Colors.White(text)) end,
  AddLine = function(_, text) GameTooltip:AddLine(Addon.Colors.Gold(text), nil, nil, nil, true) end,
  AddDoubleLine = function(_, leftText, rightText)
    GameTooltip:AddDoubleLine(Addon.Colors.Yellow(leftText), Addon.Colors.White(rightText))
  end
}

-- ============================================================================
-- Functions
-- ============================================================================

function Addon:IfNil(value, default)
  if value == nil then return default end
  return value
end

function Addon:IsBusy()
  if self.Seller:IsBusy() then return true, self.Locale.IS_BUSY_SELLING_ITEMS end
  if self.Lists:IsBusy() then return true, self.Locale.IS_BUSY_UPDATING_LISTS end
  if self.Confirmer:IsBusy() then return true, self.Locale.IS_BUSY_CONFIRMING_ITEMS end
  return false
end

function Addon:ForcePrint(...)
  print(self.Colors.Blue("[" .. ADDON_NAME .. "]"), ...)
end

function Addon:Print(...)
  if self.SavedVariables:Get().chatMessages then
    print(self.Colors.Blue("[" .. ADDON_NAME .. "]"), ...)
  end
end

function Addon:Debug(...)
  print(self.Colors.Red("[Debug]"), ...)
end
