local _, Addon = ...
local Bags = Addon.Bags
local CalculateTotalNumberOfFreeBagSlots = _G.CalculateTotalNumberOfFreeBagSlots
local Chat = Addon.Chat
local ClearCursor = _G.ClearCursor
local Consts = Addon.Consts
local Core = Addon.Core
local DB = Addon.DB
local DeleteCursorItem = _G.DeleteCursorItem
local Destroyer = Addon.Destroyer
local E = Addon.Events
local EventManager = Addon.EventManager
local Filters = Addon.Filters
local GetCursorInfo = _G.GetCursorInfo
local ItemFrames = Addon.ItemFrames
local L = Addon.Libs.L
local Lists = Addon.Lists
local max = math.max
local PickupContainerItem = _G.PickupContainerItem
local tremove = table.remove
local tsort = table.sort
local UI = Addon.UI

Destroyer.items = {}
Destroyer.timer = 0

-- ============================================================================
-- Events
-- ============================================================================

do
  local function start()
    if DB.Profile and not UI:IsShown() then
      if DB.Profile.destroy.autoOpen.enabled then
        if not ItemFrames.Destroy:IsShown() then
          Destroyer:AutoShow()
        end
        return true
      end
    end

    return false
  end

  local frame = _G.CreateFrame("Frame")
  frame.timer = 0

  frame:SetScript("OnUpdate", function(self, elapsed)
    if not self.dirty then return end

    self.timer = self.timer + elapsed

    if self.timer >= 1 then
      self.timer = 0
      self.dirty = not start()
    end
  end)

  local function queueAutoDestroy()
    frame.timer = 0
    frame.dirty = true
  end

  local function flagForRefresh()
    Destroyer.needsRefresh = true
  end

  for _, e in ipairs({
    E.BagsUpdated,
    E.ListItemAdded,
    E.ListItemRemoved,
    E.ListRemovedAll,
    E.MainUIClosed,
    E.ProfileChanged,
    E.Wow.ItemUnlocked,
  }) do
    EventManager:On(e, flagForRefresh)
    EventManager:On(e, queueAutoDestroy)
  end
end

-- ============================================================================
-- Local Functions
-- ============================================================================

local function handleItem(index)
  local item = tremove(Destroyer.items, index)
  if not item then return end

  -- Don't run if the cursor has an item, spell, etc.
  if GetCursorInfo() then return end

  -- Verify that the item can be destroyed.
  if not Bags:StillInBags(item) or Bags:IsLocked(item) then return end

  -- Destroy item.
  PickupContainerItem(item.Bag, item.Slot)
  DeleteCursorItem()
  -- Clear cursor in case any issues occurred.
  ClearCursor()

  -- Fire event.
  EventManager:Fire(E.DestroyerAttemptToDestroy, item)
end


local function handleAllItems()
  -- Stop if unsafe.
  local canDestroy, msg = Core:CanDestroy()
  if not canDestroy then
    return Chat:Print(msg)
  end

  -- Refresh items.
  Destroyer:RefreshItems()

  -- Stop if no items.
  if #Destroyer.items == 0 then
    return Chat:Print(
      Destroyer.items.allCached and
      L.NO_DESTROYABLE_ITEMS or
      L.NO_CACHED_DESTROYABLE_ITEMS
    )
  end

  -- Handle until no more items.
  while #Destroyer.items > 0 do
    handleItem()
  end
end

-- ============================================================================
-- Functions
-- ============================================================================

function Destroyer:GetItems()
  return self.items
end


function Destroyer:GetLists()
  return Lists.destroy
end


function Destroyer:RefreshItems()
  -- Stop if not necessary.
  if not (self.needsRefresh or UI:IsShown()) then return end
  self.needsRefresh = false

  Filters:GetItems(self, self.items)

  -- Sort by price.
  tsort(self.items, function(a, b)
    return (a.Price * a.Quantity) < (b.Price * b.Quantity)
  end)
end


function Destroyer:HandleNextItem(item)
  -- Stop if unsafe.
  local canDestroy, msg = Core:CanDestroy()
  if not canDestroy then
    return Chat:Print(msg)
  end

  -- Refresh items.
  self:RefreshItems()

  -- Stop if no items.
  if #self.items == 0 then
    return Chat:Print(
      self.items.allCached and
      L.NO_DESTROYABLE_ITEMS or
      L.NO_CACHED_DESTROYABLE_ITEMS
    )
  end

  -- Get item index.
  local index = 1
  if item then
    -- Get index of specified item.
    index = nil
    for i, v in pairs(self.items) do
      if v == item then index = i end
    end
    -- Stop if the item was not found.
    if index == nil then return end
  end

  -- Handle item.
  handleItem(index)
end


function Destroyer:AutoShow()
  -- Refresh items.
  self:RefreshItems()

  -- Stop if no items.
  if #self.items == 0 then return end

  -- Auto open slider check.
  if DB.Profile.destroy.autoOpen.value > Consts.DESTROY_AUTO_SLIDER_MIN then
    -- Calculate number of items to destroy.
    local freeSpace = CalculateTotalNumberOfFreeBagSlots()
    local maxToDestroy = DB.Profile.destroy.autoOpen.value - freeSpace
    -- Stop if destroying is not necessary.
    if maxToDestroy <= 0 then return end
  end

  ItemFrames.Destroy:Show()
end


-- Starts the destroying process.
function Destroyer:Start()
  handleAllItems()
end
