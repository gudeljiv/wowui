local ADDON_NAME, Addon = ...
local Colors = Addon:GetModule("Colors")
local HBDPins = Addon:GetLibrary("HBDPins")
local L = Addon:GetModule("Locale")
local PinHelper = Addon:GetModule("PinHelper")

local pins = {}
local pool = {}
local count = 0

-- ============================================================================
-- Callbacks
-- ============================================================================

local function onEnter(self)
  -- Show highlight
  self.highlight:SetAlpha(0.4)
  -- Show tooltip
  GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
  GameTooltip:SetText(Colors.Primary(self.npc.name))
  GameTooltip:AddDoubleLine(L.LEVEL, self.npc.level_range, nil, nil, nil, 1, 1, 1)
  GameTooltip:AddDoubleLine(L.ABILITIES, table.concat(self.npc.abilities, ", "), nil, nil, nil, 1, 1, 1)
  GameTooltip:AddDoubleLine(L.FAMILY, self.npc.family, nil, nil, nil, 1, 1, 1)
  GameTooltip:AddDoubleLine(L.DIET, self.npc.diet, nil, nil, nil, 1, 1, 1)
  GameTooltip:AddDoubleLine(L.TYPE, self.npc.type, nil, nil, nil, 1, 1, 1)
  GameTooltip:AddDoubleLine(L.LOCATION, self.npc.location, nil, nil, nil, 1, 1, 1)
  GameTooltip:AddDoubleLine(L.LEFT_CLICK, L.CLEAR_PINS, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6)
  GameTooltip:Show()
end

local function onLeave(self)
  self.highlight:SetAlpha(0)
  GameTooltip:Hide()
end

local function onClick(self)
  PinHelper:Clear()
end

-- ============================================================================
-- Functions
-- ============================================================================

function PinHelper:Get(npc)
  local pin = next(pool)

  if pin then
    pool[pin] = nil
  else
    count = count + 1
    pin = CreateFrame("Button", ADDON_NAME .. "Pin" .. count, WorldMapFrame)
    pin:SetSize(14, 14)

    pin.texture = pin:CreateTexture(ADDON_NAME .. "PinTexture" .. count, "BACKGROUND")
    pin.texture:SetTexture(Addon.ICON)
    pin.texture:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    pin.texture:SetAllPoints()

    pin.highlight = pin:CreateTexture(pin:GetName() .. "Hightlight", "HIGHLIGHT")
    pin.highlight:SetTexture(Addon.ICON)
    pin.highlight:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    pin.highlight:SetBlendMode("ADD")
    pin.highlight:SetAlpha(0)
    pin.highlight:SetAllPoints(pin.texture)

    pin:SetScript("OnEnter", onEnter)
    pin:SetScript("OnLeave", onLeave)
    pin:SetScript("OnClick", onClick)

    pins[#pins + 1] = pin
  end

  pin.npc = npc
  pin:Show()
  return pin
end

function PinHelper:Clear()
  for _, pin in next, pins do
    pin:Hide()
    pool[pin] = true
  end
  HBDPins:RemoveAllWorldMapIcons(Addon)
end

function PinHelper:Hide()
  for _, pin in next, pins do pin:Hide() end
end
