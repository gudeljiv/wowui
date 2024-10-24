local Addon = select(2, ...) ---@type Addon
local Items = Addon:GetModule("Items")
local L = Addon:GetModule("Locale")
local TickerManager = Addon:GetModule("TickerManager")

--- @class Looter
local Looter = Addon:GetModule("Looter")

-- ============================================================================
-- Local Functions
-- ============================================================================

local canLootItems
do
  local frames = {
    "BankFrame",
    "MerchantFrame",
    "TradeFrame",
    "GameMenuFrame",

    -- Classic
    "AuctionFrame",

    -- Retail
    "AuctionHouseFrame",
    "AzeriteRespecFrame",
    "GuildBankFrame",
    "ScrappingMachineFrame",
    "VoidStorageFrame",
    "SettingsPanel",
    "EditModeManagerFrame"
  }

  canLootItems = function()
    for _, key in pairs(frames) do
      local frame = _G[key]
      if frame and frame.IsShown and frame:IsShown() then
        return false
      end
    end
    return true
  end
end

local function tickerCallback()
  Looter:OnCallback()
end

-- ============================================================================
-- Looter
-- ============================================================================

function Looter:Start()
  if self.ticker and not self.ticker:IsCancelled() then return end

  if not canLootItems() then
    return Addon:Print(L.CANNOT_OPEN_LOOTABLE_ITEMS)
  end

  self.items = Items:GetItems()

  -- Remove non-lootable items.
  for i = #self.items, 1, -1 do
    if not self.items[i].lootable then
      table.remove(self.items, i)
    end
  end

  if #self.items == 0 then
    return Addon:Print(L.NO_LOOTABLE_ITEMS_TO_OPEN)
  end

  -- Start ticker.
  self.autoLootDefault = GetCVar("autoLootDefault")
  self.ticker = TickerManager:NewTicker(Addon:GetLatency(1.8), tickerCallback)
  self:OnCallback()
end

function Looter:Stop()
  self.ticker:Cancel()
end

function Looter:OnCallback()
  SetCVar("autoLootDefault", self.autoLootDefault)

  local item = table.remove(self.items)
  if not (item and canLootItems()) then return self:Stop() end

  if Items:IsItemLocked(item) then return end
  if not Items:IsItemStillInBags(item) then return end

  CloseLoot()
  SetCVar("autoLootDefault", 1)
  C_Container.UseContainerItem(item.bag, item.slot)
end
