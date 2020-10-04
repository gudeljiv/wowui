local AddonName, Addon = ...
local L = Addon.Libs.L
local Utils = Addon.UI.Utils
local Ignore = Addon.UI.Groups.Ignore
local DB = Addon.DB

function Ignore:Create(parent)
  Utils:Heading(parent, L.IGNORE_TEXT)
  self:AddByCategory(parent)
  self:AddByType(parent)
end

function Ignore:AddByCategory(parent)
  parent = Utils:InlineGroup({
    parent = parent,
    title = L.BY_CATEGORY_TEXT,
    fullWidth = true
  })

  -- Consumables
  Utils:CheckBox({
    parent = parent,
    label = L.IGNORE_CONSUMABLES_TEXT,
    tooltip = L.IGNORE_CONSUMABLES_TOOLTIP,
    get = function() return DB.Profile.IgnoreConsumables end,
    set = function(value) DB.Profile.IgnoreConsumables = value end
  })

  -- Item Enhancements
  Utils:CheckBox({
    parent = parent,
    label = L.IGNORE_ITEM_ENHANCEMENTS_TEXT,
    tooltip = L.IGNORE_ITEM_ENHANCEMENTS_TOOLTIP,
    get = function() return DB.Profile.IgnoreItemEnhancements end,
    set = function(value) DB.Profile.IgnoreItemEnhancements = value end
  })

  -- Recipes
  Utils:CheckBox({
    parent = parent,
    label = L.IGNORE_RECIPES_TEXT,
    tooltip = L.IGNORE_RECIPES_TOOLTIP,
    get = function() return DB.Profile.IgnoreRecipes end,
    set = function(value) DB.Profile.IgnoreRecipes = value end
  })

  -- Trade Goods
  Utils:CheckBox({
    parent = parent,
    label = L.IGNORE_TRADE_GOODS_TEXT,
    tooltip = L.IGNORE_TRADE_GOODS_TOOLTIP,
    get = function() return DB.Profile.IgnoreTradeGoods end,
    set = function(value) DB.Profile.IgnoreTradeGoods = value end
  })
end

function Ignore:AddByType(parent)
  parent = Utils:InlineGroup({
    parent = parent,
    title = L.BY_TYPE_TEXT,
    fullWidth = true
  })

  -- Binds When Equipped
  Utils:CheckBox({
    parent = parent,
    label = L.IGNORE_BOE_TEXT,
    tooltip = L.IGNORE_BOE_TOOLTIP,
    get = function() return DB.Profile.IgnoreBindsWhenEquipped end,
    set = function(value) DB.Profile.IgnoreBindsWhenEquipped = value end
  })

  -- Cosmetic
  Utils:CheckBox({
    parent = parent,
    label = L.IGNORE_COSMETIC_TEXT,
    tooltip = L.IGNORE_COSMETIC_TOOLTIP,
    get = function() return DB.Profile.IgnoreCosmetic end,
    set = function(value) DB.Profile.IgnoreCosmetic = value end
  })

  -- Readable
  Utils:CheckBox({
    parent = parent,
    label = L.IGNORE_READABLE_TEXT,
    tooltip = L.IGNORE_READABLE_TOOLTIP,
    get = function() return DB.Profile.IgnoreReadable end,
    set = function(value) DB.Profile.IgnoreReadable = value end
  })

  -- Soulbound
  Utils:CheckBox({
    parent = parent,
    label = L.IGNORE_SOULBOUND_TEXT,
    tooltip = L.IGNORE_SOULBOUND_TOOLTIP,
    get = function() return DB.Profile.IgnoreSoulbound end,
    set = function(value) DB.Profile.IgnoreSoulbound = value end
  })
end
