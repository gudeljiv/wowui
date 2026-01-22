local _, Addon = ...
local Colors = Addon:GetModule("Colors")

local colorMap = {
  Primary = "FFAAD372",
  Highlight = "FFE3E34F",
  Label = "FFFFD100"
}

for name, hex in pairs(colorMap) do
  local color = CreateColorFromHexString(hex)
  Colors[name] = setmetatable({}, {
    __call = function(self, text, alpha)
      alpha = (alpha or 1) * 255
      local colorHexString = ("%.2x%.2x%.2x%.2x"):format(alpha, color:GetRGBAsBytes())
      return WrapTextInColorCode(text or "", colorHexString)
    end
  })
end
