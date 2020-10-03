-- DB: provides addon modules easy access to saved variables.

local AddonName, Addon = ...
local Clamp = _G.Clamp
local Consts = Addon.Consts
local DB = Addon.DB

-- Default database values
local defaults = {
  Global = {
    Minimap = { hide = false },
    ItemTooltip = true
  },
  Profile = {
    -- General options
    SilentMode = false,
    VerboseMode = true,
    AutoSell = false,
    SafeMode = true,
    AutoRepair = false,
    SellBelowPrice = {
      Enabled = false,
      Value = Consts.SELL_BELOW_PRICE_MIN
    },

    -- Sell options
    SellPoor = true,
    SellCommon = false,
    SellUncommon = false,
    SellRare = false,
    SellEpic = false,

    SellUnsuitable = false,

    -- Ignore options
    IgnoreConsumables = false,
    IgnoreItemEnhancements = false,
    IgnoreRecipes = false,
    IgnoreTradeGoods = false,
    IgnoreCosmetic = false,
    IgnoreBindsWhenEquipped = false,
    IgnoreSoulbound = false,
    IgnoreReadable = false,

    -- Destroy options
    AutoDestroy = false,
    DestroyBelowPrice = {
      Enabled = false,
      Value = Consts.DESTROY_BELOW_PRICE_MIN
    },
    DestroyPoor = false,
    DestroyInclusions = false,
    DestroyExcessSoulShards = {
      Enabled = false,
      Value = Consts.DESTROY_EXCESS_SOUL_SHARDS_MIN
    },
    DestroyIgnoreExclusions = false,
    DestroyIgnoreReadable = false,

    -- Lists, table of itemIDs: { ["itemID"] = true }
    Inclusions = {},
    Exclusions = {},
    Destroyables = {}
  }
}

-- ============================================================================
-- Database Functions
-- ============================================================================

-- Converts the old version of the DB into the new one.
local function reformat()
  -- Iterate all profiles
  for _, profile in pairs(_G.DEJUNK_ADDON_SV.Profiles) do
    -- Clamp min-max values
    profile.SellBelowPrice.Value = Clamp(
      profile.SellBelowPrice.Value,
      Consts.SELL_BELOW_PRICE_MIN,
      Consts.SELL_BELOW_PRICE_MAX
    )

    profile.DestroyBelowPrice.Value = Clamp(
      profile.DestroyBelowPrice.Value,
      Consts.DESTROY_BELOW_PRICE_MIN,
      Consts.DESTROY_BELOW_PRICE_MAX
    )

    profile.DestroyExcessSoulShards.Value = Clamp(
      profile.DestroyExcessSoulShards.Value,
      Consts.DESTROY_EXCESS_SOUL_SHARDS_MIN,
      Consts.DESTROY_EXCESS_SOUL_SHARDS_MAX
    )
  end
end

-- Initializes the database.
function DB:Initialize()
  self.Initialize = nil
  local db = Addon.DethsDBLib(AddonName, defaults)
  setmetatable(self, { __index = db })
  reformat()
end
