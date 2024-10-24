local ADDON_NAME = ... ---@type string
local Addon = select(2, ...) ---@type Addon
local Colors = Addon:GetModule("Colors")
local Items = Addon:GetModule("Items")
local JunkFilter = Addon:GetModule("JunkFilter")
local L = Addon:GetModule("Locale")
local StateManager = Addon:GetModule("StateManager")

hooksecurefunc(GameTooltip, "SetBagItem", function(self, bag, slot)
  if not StateManager:GetGlobalState().itemTooltips or Items:IsBagSlotEmpty(bag, slot) then return end

  local item = Items:GetItem(bag, slot)
  if not item then return end

  local isJunk, reason = JunkFilter:IsJunkItem(item)
  if not reason then return end

  -- Add lines.
  self:AddLine(" ")
  self:AddLine(Colors.Blue(ADDON_NAME))
  self:AddLine("  " .. (isJunk and Colors.Red(L.ITEM_IS_JUNK) or Colors.Green(L.ITEM_IS_NOT_JUNK)))
  self:AddLine("  " .. Colors.Grey("- " .. Colors.White(reason)))

  self:Show()
end)
