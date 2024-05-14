local _, Addon = ...
local E = Addon:GetModule("Events") ---@type Events
local EquipmentSetsCache = Addon:GetModule("EquipmentSetsCache")
local EventManager = Addon:GetModule("EventManager") ---@type EventManager
local GetDetailedItemLevelInfo = C_Item.GetDetailedItemLevelInfo or GetDetailedItemLevelInfo
local IsCosmeticItem = C_Item.IsCosmeticItem or IsCosmeticItem
local IsEquippableItem = C_Item.IsEquippableItem or IsEquippableItem
local Items = Addon:GetModule("Items")
local NUM_BAG_SLOTS = Addon.IS_RETAIL and NUM_TOTAL_EQUIPPED_BAG_SLOTS or NUM_BAG_SLOTS
local TickerManager = Addon:GetModule("TickerManager") ---@type TickerManager

-- Initialize cache table.
Items.cache = {}
Items.location = ItemLocation:CreateEmpty()

-- ============================================================================
-- Local Functions
-- ============================================================================

local getContainerItem
do
  local t = {}

  function getContainerItem(bag, slot)
    local item = C_Container.GetContainerItemInfo(bag, slot)
    if type(item) ~= "table" then return nil end

    for k in pairs(t) do t[k] = nil end
    for k in pairs(item) do
      t[k] = item[k]
      item[k] = nil
    end

    item.bag = bag
    item.slot = slot
    item.texture = t.iconFileID
    item.quantity = t.stackCount
    item.quality = t.quality
    item.lootable = t.hasLoot
    item.link = t.hyperlink
    item.noValue = t.hasNoValue
    item.id = t.itemID

    return item
  end
end

local function getItem(bag, slot)
  local item = getContainerItem(bag, slot)
  if item == nil then return nil end

  -- GetItemInfo.
  local name, _, _, itemLevel, _, _, _, _, invType, _, price, classId, subclassId = GetItemInfo(item.link)
  if name == nil then
    name, _, _, itemLevel, _, _, _, _, invType, _, price, classId, subclassId = GetItemInfo(item.id)
    if name == nil then return nil end
  end

  item.name = name
  item.itemLevel = GetDetailedItemLevelInfo(item.link) or itemLevel
  item.invType = invType
  item.price = price
  item.classId = classId
  item.subclassId = subclassId
  item.isEquipmentSet = EquipmentSetsCache:IsBagSlotCached(bag, slot)

  return item
end

local function iterateBags()
  local bag, slot = BACKPACK_CONTAINER, 0
  local numSlots = C_Container.GetContainerNumSlots(bag)

  return function()
    slot = slot + 1

    if slot > numSlots then
      slot = 1

      -- Move to next bag
      repeat
        bag = bag + 1
        if bag > NUM_BAG_SLOTS then return nil end
        numSlots = C_Container.GetContainerNumSlots(bag)
      until numSlots > 0
    end

    return bag, slot, C_Container.GetContainerItemID(bag, slot)
  end
end

local function updateCache()
  EquipmentSetsCache:Refresh()

  for k in pairs(Items.cache) do Items.cache[k] = nil end

  local allItemsCached = true

  for bag, slot, itemId in iterateBags() do
    if itemId then
      local item = getItem(bag, slot)
      if item then
        Items.cache[#Items.cache + 1] = item
      else
        allItemsCached = false
      end
    end
  end

  EventManager:Fire(E.BagsUpdated, allItemsCached)
end

-- ============================================================================
-- Events
-- ============================================================================

-- Register events to trigger cache updates.
EventManager:Once(E.Wow.PlayerLogin, function()
  local debounce = TickerManager:NewDebouncer(0.01, updateCache)
  debounce()

  EventManager:On(E.Wow.BagUpdate, debounce)
  EventManager:On(E.Wow.BagUpdateDelayed, debounce)
  EventManager:On(E.Wow.EquipmentSetsChanged, debounce)
  EventManager:On(E.BagsUpdated, function(allItemsCached)
    if not allItemsCached then debounce() end
  end)
end)

-- ============================================================================
-- Bags
-- ============================================================================

function Items:GetFreshItem(bag, slot)
  EquipmentSetsCache:Refresh()
  return getItem(bag, slot)
end

function Items:GetItem(bag, slot)
  for _, item in pairs(self.cache) do
    if item.bag == bag and item.slot == slot then
      return item
    end
  end
end

function Items:GetItems(items)
  if type(items) ~= "table" then
    items = {}
  else
    for k in pairs(items) do items[k] = nil end
  end

  -- Add cached items.
  for _, item in ipairs(self.cache) do
    items[#items + 1] = item
  end

  return items
end

function Items:IsBagSlotEmpty(bag, slot)
  return C_Container.GetContainerItemID(bag, slot) == nil
end

function Items:IsItemStillInBags(item)
  return item.id == C_Container.GetContainerItemID(item.bag, item.slot)
end

function Items:IsItemLocked(item)
  self.location:SetBagAndSlot(item.bag, item.slot)
  local success, isLocked = pcall(C_Item.IsLocked, self.location)
  if success then return isLocked end
  return true
end

function Items:IsItemBound(item)
  self.location:SetBagAndSlot(item.bag, item.slot)
  local success, isBound = pcall(C_Item.IsBound, self.location)
  if success then return isBound end
  return false
end

function Items:IsItemJunkable(item)
  return item.quality == Enum.ItemQuality.Poor or
      item.quality == (Enum.ItemQuality.Common or Enum.ItemQuality.Standard) or
      item.quality == (Enum.ItemQuality.Uncommon or Enum.ItemQuality.Good) or
      item.quality == Enum.ItemQuality.Rare or
      item.quality == Enum.ItemQuality.Epic or
      item.quality == Enum.ItemQuality.Heirloom
end

function Items:IsItemSellable(item)
  return not item.noValue and item.price > 0 and self:IsItemJunkable(item)
end

function Items:IsItemDestroyable(item)
  if Addon.IS_RETAIL and item.classId == Enum.ItemClass.Battlepet then
    return false
  end

  return self:IsItemJunkable(item)
end

function Items:IsItemRefundable(item)
  local refundTimeRemaining = select(3, C_Container.GetContainerItemPurchaseInfo(item.bag, item.slot, false))
  return refundTimeRemaining and refundTimeRemaining > 0
end

do -- Items:IsItemEquipment()
  local invTypeExceptions = {
    ["INVTYPE_FINGER"] = true,
    ["INVTYPE_NECK"] = true,
    ["INVTYPE_TRINKET"] = true,
    ["INVTYPE_HOLDABLE"] = true
  }

  function Items:IsItemEquipment(item)
    if not IsEquippableItem(item.link) then return false end
    if IsCosmeticItem and IsCosmeticItem(item.link) then return false end

    if item.classId == Enum.ItemClass.Armor then
      if invTypeExceptions[item.invType] then return true end
      return not (
        item.subclassId == Enum.ItemArmorSubclass.Generic or
        item.subclassId == Enum.ItemArmorSubclass.Cosmetic
      )
    end

    if item.classId == Enum.ItemClass.Weapon then
      return not (
        item.subclassId == Enum.ItemWeaponSubclass.Generic or
        item.subclassId == Enum.ItemWeaponSubclass.Fishingpole
      )
    end

    return false
  end
end

function Items:IsItemSuitable(item)
  if item.invType == "INVTYPE_CLOAK" then return true end
  return self.suitable[item.classId] and self.suitable[item.classId][item.subclassId]
end

function Items:IsItemArtifactRelic(item)
  return item.classId == Enum.ItemClass.Gem and item.subclassId == Enum.ItemGemSubclass.Artifactrelic
end

-- ============================================================================
-- Suitable Items Table
-- ============================================================================

--- Map of suitable armor and weapon subclasses based on the player's class.
--- @type table<integer, table<integer, boolean>>
Items.suitable = {
  -- [classId] = { [subclassId] = boolean|nil }
  [Enum.ItemClass.Armor] = {},
  [Enum.ItemClass.Weapon] = {}
}

--- Updates the `Items.suitable` table.
--- @param playerLevel integer
local function updateSuitableTable(playerLevel)
  local IS_LESSER_ARMOR_TYPE_SUITABLE = Addon.IS_VANILLA or (Addon.IS_CATA and playerLevel < 50)
  local _, class = UnitClass("player")

  -- Generic armor.
  Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Generic] = true
  Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Cosmetic] = true
  -- Generic weapons.
  Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Generic] = true
  Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Fishingpole] = true

  -- Warrior.
  if class == "WARRIOR" then
    -- Armor.
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Cloth] = IS_LESSER_ARMOR_TYPE_SUITABLE
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Leather] = IS_LESSER_ARMOR_TYPE_SUITABLE
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Mail] = IS_LESSER_ARMOR_TYPE_SUITABLE
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Plate] = true
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Shield] = true
    -- Weapons.
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Axe1H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Axe2H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Bows] = Addon.IS_VANILLA or Addon.IS_CATA
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Crossbow] = Addon.IS_VANILLA or Addon.IS_CATA
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Dagger] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Guns] = Addon.IS_VANILLA or Addon.IS_CATA
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Mace1H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Mace2H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Polearm] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Staff] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Sword1H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Sword2H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Thrown] = Addon.IS_VANILLA or Addon.IS_CATA
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Unarmed] = true
  end

  -- Paladin.
  if class == "PALADIN" then
    -- Armor.
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Cloth] = IS_LESSER_ARMOR_TYPE_SUITABLE
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Leather] = IS_LESSER_ARMOR_TYPE_SUITABLE
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Libram] = Addon.IS_VANILLA
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Mail] = IS_LESSER_ARMOR_TYPE_SUITABLE
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Plate] = true
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Relic] = Addon.IS_CATA
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Shield] = true
    -- Weapons.
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Axe1H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Axe2H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Mace1H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Mace2H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Polearm] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Sword1H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Sword2H] = true
  end

  -- Hunter.
  if class == "HUNTER" then
    -- Armor.
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Cloth] = IS_LESSER_ARMOR_TYPE_SUITABLE
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Leather] = IS_LESSER_ARMOR_TYPE_SUITABLE
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Mail] = true
    -- Weapons.
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Axe1H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Axe2H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Bows] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Crossbow] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Dagger] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Guns] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Polearm] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Staff] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Sword1H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Sword2H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Thrown] = Addon.IS_VANILLA or Addon.IS_CATA
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Unarmed] = true
  end

  -- Rogue.
  if class == "ROGUE" then
    -- Armor
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Cloth] = IS_LESSER_ARMOR_TYPE_SUITABLE
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Leather] = true
    -- Weapons
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Axe1H] = not Addon.IS_VANILLA
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Bows] = Addon.IS_VANILLA or Addon.IS_CATA
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Crossbow] = Addon.IS_VANILLA or Addon.IS_CATA
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Dagger] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Guns] = Addon.IS_VANILLA or Addon.IS_CATA
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Mace1H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Sword1H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Thrown] = Addon.IS_VANILLA or Addon.IS_CATA
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Unarmed] = true
  end

  -- Priest.
  if class == "PRIEST" then
    -- Armor
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Cloth] = true
    -- Weapons
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Dagger] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Mace1H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Staff] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Wand] = true
  end

  -- Death Knight.
  if class == "DEATHKNIGHT" then
    -- Armor.
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Plate] = true
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Relic] = Addon.IS_CATA
    -- Weapons.
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Axe1H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Axe2H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Mace1H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Mace2H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Polearm] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Sword1H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Sword2H] = true
  end

  -- Shaman.
  if class == "SHAMAN" then
    -- Armor.
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Cloth] = IS_LESSER_ARMOR_TYPE_SUITABLE
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Leather] = IS_LESSER_ARMOR_TYPE_SUITABLE
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Mail] = true
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Relic] = Addon.IS_CATA
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Shield] = true
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Totem] = Addon.IS_VANILLA
    -- Weapons.
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Axe1H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Axe2H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Dagger] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Mace1H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Mace2H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Staff] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Unarmed] = true
  end

  -- Mage/Warlock.
  if class == "MAGE" or class == "WARLOCK" then
    -- Armor.
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Cloth] = true
    -- Weapons.
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Dagger] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Staff] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Sword1H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Wand] = true
  end

  -- Monk.
  if class == "MONK" then
    -- Armor.
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Leather] = true
    -- Weapons.
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Axe1H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Mace1H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Polearm] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Staff] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Sword1H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Unarmed] = true
  end

  -- Druid.
  if class == "DRUID" then
    -- Armor.
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Cloth] = IS_LESSER_ARMOR_TYPE_SUITABLE
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Idol] = Addon.IS_VANILLA
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Leather] = true
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Relic] = Addon.IS_CATA
    -- Weapons.
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Dagger] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Mace1H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Mace2H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Staff] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Unarmed] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Bearclaw] = not Addon.IS_VANILLA
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Catclaw] = not Addon.IS_VANILLA
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Polearm] = not Addon.IS_VANILLA
  end

  -- Demon Hunter.
  if class == "DEMONHUNTER" then
    -- Armor.
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Leather] = true
    -- Weapons.
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Axe1H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Sword1H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Unarmed] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Warglaive] = true
  end

  -- Evoker.
  if class == "EVOKER" then
    -- Armor.
    Items.suitable[Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Mail] = true
    -- Weapons.
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Axe1H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Axe2H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Dagger] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Mace1H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Mace2H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Staff] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Sword1H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Sword2H] = true
    Items.suitable[Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Unarmed] = true
  end
end

EventManager:Once(E.Wow.PlayerLogin, function()
  updateSuitableTable(UnitLevel("player"))
  EventManager:On(E.Wow.PlayerLevelUp, updateSuitableTable)
end)
