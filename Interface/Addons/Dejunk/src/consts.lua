-- Consts: provides Dejunk modules easy access to constant values.

local _, Addon = ...
local Consts = Addon.Consts
local GetItemClassInfo = _G.GetItemClassInfo
local GetItemSubClassInfo = _G.GetItemSubClassInfo
local LE_ITEM_ARMOR_CLOTH = _G.LE_ITEM_ARMOR_CLOTH
local LE_ITEM_ARMOR_COSMETIC = _G.LE_ITEM_ARMOR_COSMETIC
local LE_ITEM_ARMOR_GENERIC = _G.LE_ITEM_ARMOR_GENERIC
local LE_ITEM_ARMOR_IDOL = _G.LE_ITEM_ARMOR_IDOL
local LE_ITEM_ARMOR_LEATHER = _G.LE_ITEM_ARMOR_LEATHER
local LE_ITEM_ARMOR_LIBRAM = _G.LE_ITEM_ARMOR_LIBRAM
local LE_ITEM_ARMOR_MAIL = _G.LE_ITEM_ARMOR_MAIL
local LE_ITEM_ARMOR_PLATE = _G.LE_ITEM_ARMOR_PLATE
local LE_ITEM_ARMOR_SHIELD = _G.LE_ITEM_ARMOR_SHIELD
local LE_ITEM_ARMOR_TOTEM = _G.LE_ITEM_ARMOR_TOTEM
local LE_ITEM_CLASS_ARMOR = _G.LE_ITEM_CLASS_ARMOR
local LE_ITEM_CLASS_WEAPON = _G.LE_ITEM_CLASS_WEAPON
local LE_ITEM_WEAPON_AXE1H = _G.LE_ITEM_WEAPON_AXE1H
local LE_ITEM_WEAPON_AXE2H = _G.LE_ITEM_WEAPON_AXE2H
local LE_ITEM_WEAPON_BOWS = _G.LE_ITEM_WEAPON_BOWS
local LE_ITEM_WEAPON_CROSSBOW = _G.LE_ITEM_WEAPON_CROSSBOW
local LE_ITEM_WEAPON_DAGGER = _G.LE_ITEM_WEAPON_DAGGER
local LE_ITEM_WEAPON_FISHINGPOLE = _G.LE_ITEM_WEAPON_FISHINGPOLE
local LE_ITEM_WEAPON_GENERIC = _G.LE_ITEM_WEAPON_GENERIC
local LE_ITEM_WEAPON_GUNS = _G.LE_ITEM_WEAPON_GUNS
local LE_ITEM_WEAPON_MACE1H = _G.LE_ITEM_WEAPON_MACE1H
local LE_ITEM_WEAPON_MACE2H = _G.LE_ITEM_WEAPON_MACE2H
local LE_ITEM_WEAPON_POLEARM = _G.LE_ITEM_WEAPON_POLEARM
local LE_ITEM_WEAPON_STAFF = _G.LE_ITEM_WEAPON_STAFF
local LE_ITEM_WEAPON_SWORD1H = _G.LE_ITEM_WEAPON_SWORD1H
local LE_ITEM_WEAPON_SWORD2H = _G.LE_ITEM_WEAPON_SWORD2H
local LE_ITEM_WEAPON_THROWN = _G.LE_ITEM_WEAPON_THROWN
local LE_ITEM_WEAPON_UNARMED = _G.LE_ITEM_WEAPON_UNARMED
local LE_ITEM_WEAPON_WAND = _G.LE_ITEM_WEAPON_WAND
local NUM_LE_ITEM_ARMORS = _G.NUM_LE_ITEM_ARMORS
local NUM_LE_ITEM_WEAPONS = _G.NUM_LE_ITEM_WEAPONS

-- ============================================================================
-- General Constants
-- ============================================================================

Consts.SAFE_MODE_MAX = 12

-- SellBelowPrice
Consts.SELL_BELOW_PRICE_MIN = 2 -- 2 copper
Consts.SELL_BELOW_PRICE_MAX = 100 * 100 * 1 -- 1 gold
Consts.SELL_BELOW_PRICE_STEP = 1 -- 1 copper

-- DestroyBelowPrice
Consts.DESTROY_BELOW_PRICE_MIN = 2 -- 2 copper
Consts.DESTROY_BELOW_PRICE_MAX = 100 * 100 * 1 -- 1 gold
Consts.DESTROY_BELOW_PRICE_STEP = 1 -- 1 copper

-- DestroyExcessSoulShards
Consts.DESTROY_EXCESS_SOUL_SHARDS_MIN = 3
Consts.DESTROY_EXCESS_SOUL_SHARDS_MAX = 28
Consts.DESTROY_EXCESS_SOUL_SHARDS_STEP = 1
Consts.SOUL_SHARD_ITEM_ID = 6265

-- ============================================================================
-- Consts Functions
-- ============================================================================

-- Called from Core during the PLAYER_ENTERING_WORLD event.
function Consts:Initialize()
  -- Player class
  self.PLAYER_CLASS = select(2, _G.UnitClass("PLAYER"))
  self:BuildSuitables()

  -- Item classes
  self.CONSUMABLE_CLASS = GetItemClassInfo(_G.LE_ITEM_CLASS_CONSUMABLE)
  self.ITEM_ENHANCEMENT_CLASS = GetItemClassInfo(_G.LE_ITEM_CLASS_ITEM_ENHANCEMENT)
  self.RECIPE_CLASS = GetItemClassInfo(_G.LE_ITEM_CLASS_RECIPE)
  self.TRADEGOODS_CLASS = GetItemClassInfo(_G.LE_ITEM_CLASS_TRADEGOODS)

  -- Armor class and subclasses
  self.ARMOR_CLASS = GetItemClassInfo(LE_ITEM_CLASS_ARMOR)
  self.ARMOR_SUBCLASSES = {}
  for i=0, (NUM_LE_ITEM_ARMORS - 1) do -- Add localized armor types to the table
    local name = GetItemSubClassInfo(LE_ITEM_CLASS_ARMOR, i)
    if name then self.ARMOR_SUBCLASSES[name] = i end
  end

  -- Weapon class and subclasses
  self.WEAPON_CLASS = GetItemClassInfo(LE_ITEM_CLASS_WEAPON)
  self.WEAPON_SUBCLASSES = {}
  for i=0, (NUM_LE_ITEM_WEAPONS - 1) do -- Add localized weapon types to the table
    local name = GetItemSubClassInfo(LE_ITEM_CLASS_WEAPON, i)
    if name then self.WEAPON_SUBCLASSES[name] = i end
  end

  -- nil functions
  self.Initialize = nil
  self.BuildSuitables = nil
end

-- Builds the SUITABLE_ARMOR and SUITABLE_WEAPONS Consts tables based on player class.
function Consts:BuildSuitables()
  local class = self.PLAYER_CLASS

  if (class == "DRUID") then
    self.SUITABLE_ARMOR = {
      [LE_ITEM_ARMOR_CLOTH] = true,
      [LE_ITEM_ARMOR_LEATHER] = true,
      [LE_ITEM_ARMOR_IDOL] = true,
    }

    self.SUITABLE_WEAPONS = {
      [LE_ITEM_WEAPON_DAGGER] = true,
      [LE_ITEM_WEAPON_MACE1H] = true,
      [LE_ITEM_WEAPON_MACE2H] = true,
      [LE_ITEM_WEAPON_STAFF] = true,
      [LE_ITEM_WEAPON_UNARMED] = true,
    }
  elseif (class == "HUNTER") then
    self.SUITABLE_ARMOR = {
      [LE_ITEM_ARMOR_CLOTH] = true,
      [LE_ITEM_ARMOR_LEATHER] = true,
      [LE_ITEM_ARMOR_MAIL] = true,
    }

    self.SUITABLE_WEAPONS = {
      [LE_ITEM_WEAPON_AXE1H] = true,
      [LE_ITEM_WEAPON_AXE2H] = true,
      [LE_ITEM_WEAPON_BOWS] = true,
      [LE_ITEM_WEAPON_CROSSBOW] = true,
      [LE_ITEM_WEAPON_GUNS] = true,
      [LE_ITEM_WEAPON_POLEARM] = true,
      [LE_ITEM_WEAPON_STAFF] = true,
      [LE_ITEM_WEAPON_SWORD1H] = true,
      [LE_ITEM_WEAPON_SWORD2H] = true,
      [LE_ITEM_WEAPON_THROWN] = true,
      [LE_ITEM_WEAPON_UNARMED] = true,
    }
  elseif (class == "MAGE") then
    self.SUITABLE_ARMOR = {
      [LE_ITEM_ARMOR_CLOTH] = true
    }

    self.SUITABLE_WEAPONS = {
      [LE_ITEM_WEAPON_DAGGER] = true,
      [LE_ITEM_WEAPON_STAFF] = true,
      [LE_ITEM_WEAPON_SWORD1H] = true,
      [LE_ITEM_WEAPON_WAND] = true,
    }
  elseif (class == "PALADIN") then
    self.SUITABLE_ARMOR = {
      [LE_ITEM_ARMOR_CLOTH] = true,
      [LE_ITEM_ARMOR_LEATHER] = true,
      [LE_ITEM_ARMOR_MAIL] = true,
      [LE_ITEM_ARMOR_PLATE] = true,
      [LE_ITEM_ARMOR_SHIELD] = true,
      [LE_ITEM_ARMOR_LIBRAM] = true,
    }

    self.SUITABLE_WEAPONS = {
      [LE_ITEM_WEAPON_AXE1H] = true,
      [LE_ITEM_WEAPON_AXE2H] = true,
      [LE_ITEM_WEAPON_MACE1H] = true,
      [LE_ITEM_WEAPON_MACE2H] = true,
      [LE_ITEM_WEAPON_POLEARM] = true,
      [LE_ITEM_WEAPON_SWORD1H] = true,
      [LE_ITEM_WEAPON_SWORD2H] = true,
    }
  elseif (class == "PRIEST") then
    self.SUITABLE_ARMOR = {
      [LE_ITEM_ARMOR_CLOTH] = true,
    }

    self.SUITABLE_WEAPONS = {
      [LE_ITEM_WEAPON_DAGGER] = true,
      [LE_ITEM_WEAPON_MACE1H] = true,
      [LE_ITEM_WEAPON_STAFF] = true,
      [LE_ITEM_WEAPON_WAND] = true,
    }
  elseif (class == "ROGUE") then
    self.SUITABLE_ARMOR = {
      [LE_ITEM_ARMOR_CLOTH] = true,
      [LE_ITEM_ARMOR_LEATHER] = true,
    }

    self.SUITABLE_WEAPONS = {
      [LE_ITEM_WEAPON_BOWS] = true,
      [LE_ITEM_WEAPON_CROSSBOW] = true,
      [LE_ITEM_WEAPON_DAGGER] = true,
      [LE_ITEM_WEAPON_GUNS] = true,
      [LE_ITEM_WEAPON_MACE1H] = true,
      [LE_ITEM_WEAPON_SWORD1H] = true,
      [LE_ITEM_WEAPON_THROWN] = true,
      [LE_ITEM_WEAPON_UNARMED] = true,
    }
  elseif (class == "SHAMAN") then
    self.SUITABLE_ARMOR = {
      [LE_ITEM_ARMOR_CLOTH] = true,
      [LE_ITEM_ARMOR_LEATHER] = true,
      [LE_ITEM_ARMOR_MAIL] = true,
      [LE_ITEM_ARMOR_SHIELD] = true,
      [LE_ITEM_ARMOR_TOTEM] = true,
    }

    self.SUITABLE_WEAPONS = {
      [LE_ITEM_WEAPON_AXE1H] = true,
      [LE_ITEM_WEAPON_AXE2H] = true,
      [LE_ITEM_WEAPON_DAGGER] = true,
      [LE_ITEM_WEAPON_MACE1H] = true,
      [LE_ITEM_WEAPON_MACE2H] = true,
      [LE_ITEM_WEAPON_STAFF] = true,
      [LE_ITEM_WEAPON_UNARMED] = true,
    }
  elseif (class == "WARLOCK") then
    self.SUITABLE_ARMOR = {
      [LE_ITEM_ARMOR_CLOTH] = true,
    }

    self.SUITABLE_WEAPONS = {
      [LE_ITEM_WEAPON_DAGGER] = true,
      [LE_ITEM_WEAPON_STAFF] = true,
      [LE_ITEM_WEAPON_SWORD1H] = true,
      [LE_ITEM_WEAPON_WAND] = true,
    }
  elseif (class == "WARRIOR") then
    self.SUITABLE_ARMOR = {
      [LE_ITEM_ARMOR_CLOTH] = true,
      [LE_ITEM_ARMOR_LEATHER] = true,
      [LE_ITEM_ARMOR_MAIL] = true,
      [LE_ITEM_ARMOR_PLATE] = true,
      [LE_ITEM_ARMOR_SHIELD] = true,
    }

    self.SUITABLE_WEAPONS = {
      [LE_ITEM_WEAPON_AXE1H] = true,
      [LE_ITEM_WEAPON_AXE2H] = true,
      [LE_ITEM_WEAPON_BOWS] = true,
      [LE_ITEM_WEAPON_CROSSBOW] = true,
      [LE_ITEM_WEAPON_DAGGER] = true,
      [LE_ITEM_WEAPON_GUNS] = true,
      [LE_ITEM_WEAPON_MACE1H] = true,
      [LE_ITEM_WEAPON_MACE2H] = true,
      [LE_ITEM_WEAPON_POLEARM] = true,
      [LE_ITEM_WEAPON_STAFF] = true,
      [LE_ITEM_WEAPON_SWORD1H] = true,
      [LE_ITEM_WEAPON_SWORD2H] = true,
      [LE_ITEM_WEAPON_THROWN] = true,
      [LE_ITEM_WEAPON_UNARMED] = true,
    }
  else
    error(("Unsupported player class: \"%s\""):format(class))
  end

  -- Generic suitables
  self.SUITABLE_ARMOR[LE_ITEM_ARMOR_GENERIC] = true -- Miscellaneous
  self.SUITABLE_ARMOR[LE_ITEM_ARMOR_COSMETIC] = true

  self.SUITABLE_WEAPONS[LE_ITEM_WEAPON_GENERIC] = true -- Miscellaneous
  self.SUITABLE_WEAPONS[LE_ITEM_WEAPON_FISHINGPOLE] = true
end
