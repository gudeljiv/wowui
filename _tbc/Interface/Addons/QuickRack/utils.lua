-- QuickRack - util.lua
-- Shared helpers used by core/editor/paperdoll code.
-- Intentionally small + stable.

QuickRackUtil = QuickRackUtil or {}

function QuickRackUtil.Print(msg)
  DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99QuickRack|r: " .. tostring(msg))
end

-- Slot IDs in WoW
QuickRackUtil.SLOT_IDS = {
  1,  -- HeadSlot
  2,  -- NeckSlot
  3,  -- ShoulderSlot
  4,  -- ShirtSlot
  5,  -- ChestSlot
  6,  -- WaistSlot
  7,  -- LegsSlot
  8,  -- FeetSlot
  9,  -- WristSlot
  10, -- HandsSlot
  11, -- Finger0Slot
  12, -- Finger1Slot
  13, -- Trinket0Slot
  14, -- Trinket1Slot
  15, -- BackSlot
  16, -- MainHandSlot
  17, -- SecondaryHandSlot
  18, -- RangedSlot
  19, -- TabardSlot
}

-- Returns "item:...." from a hyperlink, or passes through an item: string.
function QuickRackUtil.NormalizeItemString(linkOrString)
  if not linkOrString or type(linkOrString) ~= "string" then return nil end
  local s = linkOrString:match("|H(item:[^|]+)|h")
  if s then return s end
  if linkOrString:find("^item:") then return linkOrString end
  return nil
end

-- =========================
-- Bag search + exact-link equip helpers (fix duplicate-name weapons)
-- =========================
function QuickRackUtil.GetBagNumSlots(bag)
  if C_Container and C_Container.GetContainerNumSlots then
    return C_Container.GetContainerNumSlots(bag)
  end
  return GetContainerNumSlots(bag)
end

function QuickRackUtil.GetBagItemLink(bag, slot)
  if C_Container and C_Container.GetContainerItemLink then
    return C_Container.GetContainerItemLink(bag, slot)
  end
  return GetContainerItemLink(bag, slot)
end

function QuickRackUtil.PickupBagItem(bag, slot)
  if C_Container and C_Container.PickupContainerItem then
    C_Container.PickupContainerItem(bag, slot)
  else
    PickupContainerItem(bag, slot)
  end
end

function QuickRackUtil.UseBagItem(bag, slot)
  if not bag or not slot then return false end
  if C_Container and C_Container.UseContainerItem then
    C_Container.UseContainerItem(bag, slot)
    return true
  elseif UseContainerItem then
    UseContainerItem(bag, slot)
    return true
  end
  return false
end
