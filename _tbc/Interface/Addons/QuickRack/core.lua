-- QuickRack - core.lua

local ADDON = ...
QuickRackDB = QuickRackDB or {}

-- Shared helpers (from utils.lua)
local U = QuickRackUtil
local Print = U.Print
local SLOT_IDS = U.SLOT_IDS
local NormalizeItemString = U.NormalizeItemString
local GetBagNumSlots = U.GetBagNumSlots
local GetBagItemLink = U.GetBagItemLink
local PickupBagItem = U.PickupBagItem
local UseBagItem = U.UseBagItem
local FindEmptyBagSlot

-- ============================================================
-- 1) Per-character DB / Model
-- ============================================================
local EnsureDB
local CanSwapNow

local function GetCharKey()
  local name = UnitName("player")
  local realm = GetRealmName()
  return realm .. "-" .. name
end

function EnsureCharDB()
  QuickRackDB = QuickRackDB or {}
  QuickRackDB.characters = QuickRackDB.characters or {}

  local key = GetCharKey()
  QuickRackDB.characters[key] = QuickRackDB.characters[key] or {}
  local db = QuickRackDB.characters[key]

  db.sets = db.sets or {}
  db.triggers = db.triggers or {}
  db.editor = db.editor or {}
  db.minimap = db.minimap or { angle = 220, hide = false }
  -- db.lastEquippedSet is optional; keep if you want per-char memory

  -- UI state (pins + pinbar position)
  db.ui = db.ui or {}
  db.ui.pins = db.ui.pins or {} -- [slotID]=true
  db.ui.pinbar = db.ui.pinbar or { point = "CENTER", relPoint = "CENTER", x = 0, y = 0 }

  return db
end

EnsureDB = function()
  return EnsureCharDB()
end

-- ============================================================
-- Tooltip: show which gearsets an item belongs to
-- ============================================================

-- Returns a sorted list of gearset names that contain this exact itemString.
-- Comparison is done on normalized "item:..." (includes enchants/bonuses if present in the link).
function QuickRack_GetGearsetsForItem(linkOrItemString)
  local want = NormalizeItemString(linkOrItemString)
  if not want then return {} end

  local db = EnsureDB()
  local out = {}

  for setName, set in pairs(db.sets or {}) do
    if set and set.slots then
      local found = false
      for _, v in pairs(set.slots) do
        if type(v) == "string" then
          local have = NormalizeItemString(v)
          if have and have == want then
            found = true
            break
          end
        end
      end
      if found then
        out[#out + 1] = setName
      end
    end
  end

  table.sort(out)
  return out
end

local function QuickRack_AppendGearsetLine(tooltip)
  if not tooltip or not tooltip.GetItem then return end

  local _, link = tooltip:GetItem()
  if not link then return end

local sets = QuickRack_GetGearsetsForItem(link)

-- Golden header
local headerText = "|cffffd100QuickRack Gearsets|r"

-- Gearset names on their own row
local setsText = (sets and #sets > 0) and table.concat(sets, ", ") or "None"
  -- Prevent duplicates (tooltips can refresh multiple times).
  local tname = tooltip:GetName()
  if tname then
    for i = 1, tooltip:NumLines() do
      local fs = _G[tname .. "TextLeft" .. i]
      local txt = fs and fs:GetText()
      if txt == headerText then
        return
      end
    end
  end

  tooltip:AddLine(" ")
  tooltip:AddLine(headerText, 1, 1, 1, true)
  tooltip:AddLine(setsText, 1, 1, 1, true)
  tooltip:Show()
end

-- Hook common item tooltips so the line appears everywhere.
if not QuickRackTooltipHooked then
  QuickRackTooltipHooked = true

  if GameTooltip and GameTooltip.HookScript then
    GameTooltip:HookScript("OnTooltipSetItem", QuickRack_AppendGearsetLine)
  end

  if ItemRefTooltip and ItemRefTooltip.HookScript then
    ItemRefTooltip:HookScript("OnTooltipSetItem", QuickRack_AppendGearsetLine)
  end

  -- Optional: covers some compare/extra tooltips used by the default UI
  if ShoppingTooltip1 and ShoppingTooltip1.HookScript then
    ShoppingTooltip1:HookScript("OnTooltipSetItem", QuickRack_AppendGearsetLine)
  end
  if ShoppingTooltip2 and ShoppingTooltip2.HookScript then
    ShoppingTooltip2:HookScript("OnTooltipSetItem", QuickRack_AppendGearsetLine)
  end
end

local function EnsureTriggersDB()
  local db = EnsureCharDB()
  db.triggers = db.triggers or {}
  return db
end

function QuickRack_SetTrigger(triggerKey, setNameOrNil)
  local db = EnsureTriggersDB()
  if setNameOrNil == nil or setNameOrNil == "" then
    db.triggers[triggerKey] = nil
  else
    db.triggers[triggerKey] = setNameOrNil
  end
end

function QuickRack_GetTrigger(triggerKey)
  local db = EnsureTriggersDB()
  return db.triggers[triggerKey]
end

-- Keybinds (override bindings per character)
QuickRackKeybind = QuickRackKeybind or {}
local Keybind = QuickRackKeybind

local function EnsureBinderFrame()
  if Keybind.frame then return end

  local f = CreateFrame("Frame", "QuickRackKeybindFrame", UIParent)
  f:Hide()
  Keybind.frame = f

  Keybind.buttons = Keybind.buttons or {}
end

local function EnsureBindButton(setName)
  EnsureBinderFrame()

  local safeName = setName:gsub("[^%w_]", "_")
  local btnName = "QuickRackBindButton_" .. safeName

  if _G[btnName] then
    Keybind.buttons[setName] = _G[btnName]
    return _G[btnName]
  end

  local b = CreateFrame("Button", btnName, UIParent, "SecureActionButtonTemplate")
  b:Hide()

  b:SetScript("OnClick", function()
    if QuickRack_EquipSet then
      QuickRack_EquipSet(setName)
    end
  end)

  Keybind.buttons[setName] = b
  return b
end

local function ClearAllOverrides()
  EnsureBinderFrame()
  ClearOverrideBindings(Keybind.frame)
end

function QuickRack_ApplyKeybinds()
  -- Call this on login and whenever sets/binds change
  EnsureBinderFrame()
  ClearAllOverrides()

  if not QuickRackDB or not QuickRackDB.characters then return end

  -- You probably already have a GetCharKey() helper; use it if available.
  local name = UnitName("player")
  local realm = GetRealmName()
  local charKey = realm .. "-" .. name

  local cdb = QuickRackDB.characters[charKey]
  if not cdb or not cdb.sets then return end

  for setName, setData in pairs(cdb.sets) do
    local key = setData and setData.bindKey
    if key and key ~= "" then
      local btn = EnsureBindButton(setName)
      SetOverrideBindingClick(Keybind.frame, false, key, btn:GetName())
    end
  end
end

-- Apply on login
do
  local f = CreateFrame("Frame")
  f:RegisterEvent("PLAYER_LOGIN")
  f:SetScript("OnEvent", function()
    QuickRack_ApplyKeybinds()
  end)
end

-- ============================================================
-- 2) Normalization + Bag/Inventory helpers
-- ============================================================
local function GetItemIDFromLink(link)
  if not link then return nil end
  local id = string.match(link, "item:(%d+)")
  if id then return tonumber(id) end
  return nil
end

-- Normalize an equipment value (itemLink/itemID/0) into:
--   nil = unspecified/ignore, 0 = empty, number = itemID
local function NormalizeItemValue(v)
  if v == nil then return nil end
  if v == false then return nil end
  if v == 0 or v == "0" then return 0 end
  if type(v) == "number" then return v end
  if type(v) == "string" then
    local id = v:match("item:(%d+)")
    if id then return tonumber(id) end
    local asNum = tonumber(v)
    if asNum then return asNum end
  end
  return nil
end

local function SnapshotCurrentGearLinks()
  local snap = { slots = {} }
  for _, slotID in ipairs(SLOT_IDS) do
    local link = GetInventoryItemLink("player", slotID)
    if link then
      snap.slots[tostring(slotID)] = link
    else
      snap.slots[tostring(slotID)] = 0 -- explicitly empty
    end
  end
  return snap
end

local function FindItemInBagsByExactLink(targetLink, excludeBagKey)
  if not targetLink or type(targetLink) ~= "string" then return nil end

  local want = NormalizeItemString(targetLink) or targetLink:match("item:[^|]+")
  if not want then return nil end

  for bag = 0, 4 do
    local n = GetBagNumSlots(bag) or 0
    for slot = 1, n do
      local key = bag .. ":" .. slot
      if key ~= excludeBagKey then
        local link = GetBagItemLink(bag, slot)
        if link then
          local have = NormalizeItemString(link)
          if have and have == want then
            return bag, slot
          end
        end
      end
    end
  end
  return nil
end

local function EquipByExactLinkNoCursor(targetLink, excludeBagKey)
  if not targetLink then return false end

  -- Only accept true hyperlinks or item: strings.
  if type(targetLink) ~= "string" then return false end
  if not (targetLink:find("|Hitem:", 1, true) or targetLink:find("^item:")) then
    return false
  end

  local bag, slot = FindItemInBagsByExactLink(targetLink, excludeBagKey)
  if bag and slot then
    return UseBagItem(bag, slot)
  end
  return false
end

-- Find a bag slot containing an item matching an itemString (includes enchant).
local function FindBagSlotByItemString(itemString, excludeKey)
  if not itemString then return nil end

  for bag = 0, 4 do
    local n = GetBagNumSlots(bag) or 0
    for slot = 1, n do
      local key = bag .. ":" .. slot
      if key ~= excludeKey then
        local link = GetBagItemLink(bag, slot)
        if link then
          local have = NormalizeItemString(link)
          if have and have == itemString then
            return bag, slot, key
          end
        end
      end
    end
  end
  return nil
end

-- Check if a specific bag slot currently holds an item matching itemString
-- (itemString is the NormalizeItemString output, so it includes enchant/unique bits.)
local function BagSlotHasItemString(bag, slot, itemString)
  if not (bag and slot and itemString) then return false end
  local link = GetBagItemLink(bag, slot)
  if not link then return false end
  local have = NormalizeItemString(link)
  return have and have == itemString
end

-- Deterministic equip from a specific bag slot into a specific inv slot (MH/OH only).
local function EquipBagSlotToInvSlot_Once(bag, slot, invSlotID)
  if not bag or not slot or not invSlotID then return false end
  if not CanSwapNow() then return false end

  -- If cursor is dirty, don't risk desync.
  if CursorHasItem and CursorHasItem() then
    ClearCursor()
    return false
  end

  ClearCursor()
  PickupBagItem(bag, slot)

  if CursorHasItem and CursorHasItem() then
    EquipCursorItem(invSlotID)
    ClearCursor()
    return true
  end

  ClearCursor()
  return false
end

FindEmptyBagSlot = function(reserved)
  reserved = reserved or {}

  for bag = 0, 4 do
    local numSlots = GetBagNumSlots(bag) or 0
    for slot = 1, numSlots do
      local key = bag .. ":" .. slot
      if not reserved[key] then
        local link = GetBagItemLink(bag, slot)
        if not link then
          reserved[key] = true
          return bag, slot
        end
      end
    end
  end

  return nil
end

-- ============================================================
-- 3) Equip engine (SafeEquip/SafeUnequip/Finalize/Weapons)
-- ============================================================
CanSwapNow = function()
  if InCombatLockdown and InCombatLockdown() then
    Print("Can't swap gear in combat.")
    return false
  end
  return true
end

local function EquipSnapshotLinks(snap)
  if not snap or not snap.slots then return end
  if not CanSwapNow() then return end
  local reservedBagSlots = {}

  for _, slotID in ipairs(SLOT_IDS) do
    local raw = snap.slots[tostring(slotID)]
    if raw == 0 or raw == "0" then
      -- Unequip
      local equippedLink = GetInventoryItemLink("player", slotID)
      if equippedLink then
        local bag, bagSlot = FindEmptyBagSlot(reservedBagSlots)
        if bag and bagSlot then
          ClearCursor()
          PickupInventoryItem(slotID)

          if CursorHasItem and CursorHasItem() then
            PickupBagItem(bag, bagSlot)
            if CursorHasItem and CursorHasItem() then
              ClearCursor()
            end
          else
            ClearCursor()
          end
        end
      end
    elseif type(raw) == "string" then
      EquipItemByName(raw, slotID) -- keep enchant identity where possible
    elseif type(raw) == "number" and raw > 0 then
      EquipItemByName(raw, slotID)
    end
  end
end

-- Forward-declare link helpers so earlier-defined closures can call them safely.
local function IsRealItemLink(v)
  return type(v) == "string" and v:find("|Hitem:", 1, true) ~= nil
end

local function IsTwoHandLink(link)
  if type(link) ~= "string" then return false end
  local itemString = NormalizeItemString(link)
  if not itemString then return false end

  -- Prefer C_Item.GetItemInfo if available, otherwise GetItemInfo
  local _, _, _, _, _, _, _, _, equipLoc = GetItemInfo(link)
  return equipLoc == "INVTYPE_2HWEAPON"
      or equipLoc == "INVTYPE_RANGED"
      or equipLoc == "INVTYPE_RANGEDRIGHT"
end

local QR_Finalize = { active = false, setName = nil, tries = 0 }

-- Weapon retry helper used only during finalize.
-- Conservative: only retries if slots are still incorrect.
local function TryFinalizeWeapons(GetDesired, IsCorrect, SafeEquip)
  local mhRaw = GetDesired(16)
  local ohRaw = GetDesired(17)

  if mhRaw == false then mhRaw = nil end
  if ohRaw == false then ohRaw = nil end

  -- If MH is a real link and 2H, don't try to force OH
  if mhRaw ~= nil and IsRealItemLink(mhRaw) and IsTwoHandLink(mhRaw) then
    if not IsCorrect(16, mhRaw) then
      SafeEquip(16, mhRaw)
      return true
    end
    return false
  end

  local any = false

  -- Retry MH if wrong
  if mhRaw ~= nil and not IsCorrect(16, mhRaw) then
    SafeEquip(16, mhRaw)
    any = true
  end

  -- Retry OH if wrong (this is the important one for MH(old)=Y -> OH(new)=Y)
  if ohRaw ~= nil and not IsCorrect(17, ohRaw) then
    SafeEquip(17, ohRaw)
    any = true
  end

  return any
end

local function QR_StopFinalize(frame)
  QR_Finalize.active = false
  QR_Finalize.setName = nil
  QR_Finalize.tries = 0
  if frame then
    frame:UnregisterAllEvents()
    frame:SetScript("OnEvent", nil)
  end
end

local function QR_StartFinalize(setName, set, GetDesired, IsCorrect, SafeEquip)
  if QR_Finalize.active then return end
  QR_Finalize.active = true
  QR_Finalize.setName = setName
  QR_Finalize.tries = 0

  local f = CreateFrame("Frame")
  f:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
  f:RegisterEvent("BAG_UPDATE_DELAYED")

  f:SetScript("OnEvent", function(self, event, ...)
    if not QR_Finalize.active then
      QR_StopFinalize(self)
      return
    end
    if not CanSwapNow() then
      -- If combat starts etc, stop. User can click again after.
      QR_StopFinalize(self)
      return
    end

    QR_Finalize.tries = QR_Finalize.tries + 1
    if QR_Finalize.tries > 3 then
      QR_StopFinalize(self)
      return
    end

    local anyLeft = false

    -- Retry all non-weapon slots once state has settled.
    for _, slotID in ipairs(SLOT_IDS) do
      if slotID ~= 16 and slotID ~= 17 then
        local raw = GetDesired(slotID)
        if raw ~= nil and raw ~= false then
          if not IsCorrect(slotID, raw) then
            anyLeft = true
            SafeEquip(slotID, raw)
          end
        end
      end
    end

    -- This fixes cross-slot reuse cases like MH(old)=Y -> OH(new)=Y.
if TryFinalizeWeapons(GetDesired, IsCorrect, SafeEquip) then
  anyLeft = true
end

    if not anyLeft then
      QR_StopFinalize(self)
    end
  end)
end

function QuickRack_EquipSet(name)
  local db = EnsureDB()

    -- If we are resuming after a pre-unequip phase, skip the pre-unequip logic once.
  local _resume = db._qr_preunequip
  local _skipPreUnequip = false
  if _resume and _resume.setName == name and _resume.phase == "resume" then
    _skipPreUnequip = true
    db._qr_preunequip = nil
  end

  if not name or name == "" then
    Print("Usage: /qr equip <name>")
    return
  end

    local set = db.sets[name]
  if not set then
    Print("No set named '" .. name .. "'.")
    return
  end

  if not CanSwapNow() then return end

   -- Safe equip: use itemLinks via EquipItemByName (no bag-slot/cursor equipping).
  -- For MH/OH, do a second verification pass to avoid dual-wield "steal" edge cases.

  local reservedBagSlots = {} -- track empty bag slots consumed during this equip

  local function GetDesired(slotID)
    if not set.slots then return nil end
    local raw = set.slots[tostring(slotID)]
    if raw == nil then raw = set.slots[slotID] end
    if raw == "0" then raw = 0 end
    return raw
  end

  local function IsCorrect(slotID, raw)
    local equippedLink = GetInventoryItemLink("player", slotID)
    if raw == nil or raw == false then return true end -- ignore slots count as "fine"
    if raw == 0 then return equippedLink == nil end

    if not equippedLink then return false end

    if type(raw) == "string" then
      -- If it's a real hyperlink, compare normalized item strings (includes enchant)
      if raw:find("|Hitem:", 1, true) then
        local want = NormalizeItemString(raw)
        local have = NormalizeItemString(equippedLink)
        return want and have and want == have
      end
      -- numeric string fallback
      local asNum = tonumber(raw)
      if asNum then
        local haveID = GetItemIDFromLink(equippedLink)
        return haveID and haveID == asNum
      end
      return false
    end

    if type(raw) == "number" then
      local haveID = GetItemIDFromLink(equippedLink)
      return haveID and haveID == raw
    end

    return false
  end

    -- ============================================================
  -- Guard: if this set is already equipped (for all specified slots),
  -- bail out early. This prevents side-effects from the equip pipeline
  -- (pre-unequip / MH<->OH handling / finalize passes) when nothing
  -- actually needs to change.
  --
  -- Note: slots with nil/false in the set are treated as "ignore".
  -- ============================================================
  local function IsSetAlreadyEquipped()
    for _, slotID in ipairs(SLOT_IDS) do
      local raw = GetDesired(slotID)
      if raw ~= nil and raw ~= false then
        if not IsCorrect(slotID, raw) then
          return false
        end
      end
    end
    return true
  end

  if IsSetAlreadyEquipped() then
    -- If we were mid-resume from a previous attempt, clear it.
    if db._qr_preunequip and db._qr_preunequip.setName == name then
      db._qr_preunequip = nil
    end
    Print("Set '" .. name .. "' is already equipped.")
    return
  end

  local function SafeUnequip(slotID)
    local equippedLink = GetInventoryItemLink("player", slotID)
    if not equippedLink then return end

    local bag, bagSlot = FindEmptyBagSlot(reservedBagSlots)
    if not (bag and bagSlot) then
      Print("Bags full; can't unequip slot " .. tostring(slotID) .. ".")
      return
    end

    ClearCursor()
    PickupInventoryItem(slotID)

    if CursorHasItem and CursorHasItem() then
      PickupBagItem(bag, bagSlot)
      if CursorHasItem and CursorHasItem() then
        ClearCursor()
      end
    else
      ClearCursor()
    end
  end

  local function SafeEquip(slotID, raw)
    if raw == nil or raw == false then return end
    if raw == 0 then
      SafeUnequip(slotID)
      return
    end

    if type(raw) == "number" then
      if raw > 0 then EquipItemByName(raw, slotID) end
      return
    end

    if type(raw) == "string" then
      -- If real link, always use it (keeps enchant identity)
      if raw:find("|Hitem:", 1, true) then
        EquipItemByName(raw, slotID)
        return
      end

      -- numeric string fallback
      local asNum = tonumber(raw)
      if asNum and tostring(asNum) == raw then
        EquipItemByName(asNum, slotID)
      else
        EquipItemByName(raw, slotID)
      end
    end
  end


    -- ============================================================
  -- Pragmatic fix for cross-slot reuse (MH<->OH) without breaking shield cases:
  -- If the target set wants a currently-equipped weapon to move to the other slot
  -- (e.g. MH(old)=Y -> OH(new)=Y), we first unequip the source slot, then resume
  -- equipping on BAG_UPDATE_DELAYED / PLAYER_EQUIPMENT_CHANGED.
  -- This ensures the moved item is actually in bags before we try to equip it.
  -- ============================================================
  if not _skipPreUnequip then
    local function RawMatchesEquipped(raw, equippedLink)
      if raw == nil or raw == false then return false end
      if raw == 0 or raw == "0" then return (equippedLink == nil) end
      if not equippedLink then return false end

      if type(raw) == "string" and raw:find("|Hitem:", 1, true) then
        local want = NormalizeItemString(raw)
        local have = NormalizeItemString(equippedLink)
        return want and have and want == have
      end

      local asNum = (type(raw) == "number") and raw or tonumber(raw)
      if asNum then
        local haveID = GetItemIDFromLink(equippedLink)
        return haveID and haveID == asNum
      end

      -- Name fallback (best-effort; supports sets storing plain names)
      if type(raw) == "string" then
        local haveName = GetItemInfo(equippedLink)
        return haveName and haveName == raw
      end

      return false
    end

    local wantMH = GetDesired(16)
    local wantOH = GetDesired(17)
    local haveMH = GetInventoryItemLink("player", 16)
    local haveOH = GetInventoryItemLink("player", 17)

    local unequippedAny = false

    -- If the item currently in MH should become OH in the new set, unequip MH first.
    if haveMH and RawMatchesEquipped(wantOH, haveMH) and (not RawMatchesEquipped(wantMH, haveMH)) then
      SafeUnequip(16)
      unequippedAny = true
    end

    -- If the item currently in OH should become MH in the new set, unequip OH first.
    if haveOH and RawMatchesEquipped(wantMH, haveOH) and (not RawMatchesEquipped(wantOH, haveOH)) then
      SafeUnequip(17)
      unequippedAny = true
    end

    if unequippedAny then
      -- Mark resume and stop this equip pass. We'll re-run once inventory is settled.
      db._qr_preunequip = { setName = name, phase = "resume" }

      local f = CreateFrame("Frame")
      f:RegisterEvent("BAG_UPDATE_DELAYED")
      f:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")

      f:SetScript("OnEvent", function(self, event, ...)
        local db2 = EnsureDB()
        local r = db2._qr_preunequip
        if r and r.setName == name and r.phase == "resume" then
          self:UnregisterAllEvents()
          self:SetScript("OnEvent", nil)
          -- Re-run the equip; the top-of-function guard will skip pre-unequip this time.
          if C_Timer and C_Timer.NewTimer then
            -- Small delay makes this far more reliable (bags/equip updates can race the event).
            C_Timer.NewTimer(0.05, function() QuickRack_EquipSet(name) end)
          else
            QuickRack_EquipSet(name)
          end
        else
          self:UnregisterAllEvents()
          self:SetScript("OnEvent", nil)
        end
      end)

      return
    end
  end




    -- Weapons: deterministic MH/OH mapping using bag-slot -> specific slot.
    -- Weapons: deterministic handling + correct behavior for 2H swaps.
  do
    local mhRaw = GetDesired(16)
    local ohRaw = GetDesired(17)

    local mhIsLink = IsRealItemLink(mhRaw)
    local ohIsLink = IsRealItemLink(ohRaw)

    -- If the set wants a 2H in MH, never try to equip OH.
    if mhIsLink and IsTwoHandLink(mhRaw) then
      -- Equip the 2H (fast path is OK; no need for bag-slot mapping usually)
      SafeEquip(16, mhRaw)

      -- If the set explicitly wants OH empty, great (it will be forced empty anyway).
      -- If the set specifies some OH item, we ignore it because 2H blocks OH.
      -- Optional: you can unequip OH if it somehow remains (rare), but 2H equip should clear it.

    else
      -- Dual-wield / 1H case: deterministic mapping using bag-slot -> specific slot.
      if not (mhIsLink and ohIsLink) then
        -- Fallback: just try fast equip
        SafeEquip(16, mhRaw)
        SafeEquip(17, ohRaw)
      else
        local mhStr = NormalizeItemString(mhRaw)
        local ohStr = NormalizeItemString(ohRaw)

        -- Equip MH from bags into MH slot (exact instance)
        local mhBag, mhSlot, mhKey = FindBagSlotByItemString(mhStr, nil)
        if mhBag and mhSlot then
          EquipBagSlotToInvSlot_Once(mhBag, mhSlot, 16)
        else
          SafeEquip(16, mhRaw)
        end

        -- Equip OH from bags into OH slot, excluding MH bag key
        local ohBag, ohSlot = FindBagSlotByItemString(ohStr, mhKey)
        if ohBag and ohSlot then
          EquipBagSlotToInvSlot_Once(ohBag, ohSlot, 17)
        else
          SafeEquip(17, ohRaw)
        end

        -- If MH change temporarily blocked OH, finalize pass will catch it.
      end
    end
  end
  SafeEquip(11, GetDesired(11))
  SafeEquip(12, GetDesired(12))
  SafeEquip(13, GetDesired(13))
  SafeEquip(14, GetDesired(14))
  -- 2) Equip all other slots (everything except 16/17)
  for _, slotID in ipairs(SLOT_IDS) do
        if slotID ~= 16 and slotID ~= 17 and slotID ~= 11 and slotID ~= 12 and slotID ~= 13 and slotID ~= 14 then

      local raw = GetDesired(slotID)
      -- If already correct, skip
      if not IsCorrect(slotID, raw) then
        SafeEquip(slotID, raw)
      end
    end
  end


  QR_StartFinalize(name, set, GetDesired, IsCorrect, SafeEquip)

  Print("Equipping set '" .. name .. "'.")
end  -- closes: function QuickRack_EquipSet(name)

-- ============================================================
-- 4) Public API (save/equip/delete/list) + Slash Commands
-- ============================================================
function QuickRack_SaveSet(name)
  local db = EnsureDB()
  if not name or name == "" then
    Print("Usage: /qr save <name>")
    return
  end

  local set = {
    name = name,
    slots = {}, -- slotID -> itemLink OR 0 OR false OR nil
  }

  for _, slotID in ipairs(SLOT_IDS) do
    local link = GetInventoryItemLink("player", slotID)
    -- Store the link directly so enchants show in tooltips later
    set.slots[tostring(slotID)] = link
  end

  db.sets[name] = set
  Print("Saved set '" .. name .. "'.")
  if QuickRackUI and QuickRackUI.Refresh then QuickRackUI.Refresh() end
end

function QuickRack_DeleteSet(name)
  local db = EnsureDB()
  if not name or name == "" then
    Print("Usage: /qr delete <name>")
    return
  end

  if db.sets[name] then
    db.sets[name] = nil
    Print("Deleted set '" .. name .. "'.")
    if QuickRackUI and QuickRackUI.Refresh then QuickRackUI.Refresh() end
  else
    Print("No set named '" .. name .. "'.")
  end
end

function QuickRack_SaveSetData(name, slotsTable)
  local db = EnsureDB()
  if not name or name == "" then
    Print("Missing set name.")
    return
  end
  if type(slotsTable) ~= "table" then
    Print("Invalid slots data.")
    return
  end

  db.sets[name] = {
    name = name,
    slots = slotsTable,
  }

  Print("Saved set '" .. name .. "'.")
  if QuickRackUI and QuickRackUI.Refresh then QuickRackUI.Refresh() end
end

function QuickRack_ListSets()
  local db = EnsureDB()
  local sets = db.sets
  local count = 0
  for n,_ in pairs(sets) do count = count + 1 end

  if count == 0 then
    Print("No sets saved. Use /qr save <name>.")
    return
  end

  Print("Saved sets:")
  for n,_ in pairs(sets) do
    DEFAULT_CHAT_FRAME:AddMessage("  - " .. n)
  end
end

-- Returns the name of a saved gearset that matches what is currently equipped, or nil.
function QuickRack_GetActiveSetName()
  local db = EnsureDB()
  if not db.sets then return nil end

  -- Build equipped itemID map once
  local equipped = {}
  for _, slotID in ipairs(SLOT_IDS) do
    local link = GetInventoryItemLink("player", slotID)
    equipped[slotID] = link and NormalizeItemValue(link) or 0
  end

  local names = {}
  for n,_ in pairs(db.sets) do table.insert(names, n) end
  table.sort(names)

  for _, name in ipairs(names) do
    local set = db.sets[name]
    local ok = true
    for _, slotID in ipairs(SLOT_IDS) do
      local raw = nil
      if set and set.slots then
        raw = set.slots[tostring(slotID)]
        if raw == nil then raw = set.slots[slotID] end
      end

      -- Ignore if not specified or explicitly ignored
      if raw ~= nil and raw ~= false then
        local expected = NormalizeItemValue(raw)
        if expected ~= nil then
          if expected == 0 then
            if equipped[slotID] ~= 0 then ok = false; break end
          else
            if equipped[slotID] ~= expected then ok = false; break end
          end
        end
      end
    end

    if ok then return name end
  end

  return nil
end

-- Returns an editor-style slots table (string keys) representing currently equipped gear.
function QuickRack_GetEquippedSlotsForEditor()
  local snap = SnapshotCurrentGearLinks()
  return snap.slots
end

-- Slash commands
SLASH_QUICKRACK1 = "/qr"
SLASH_QUICKRACK2 = "/quickrack"
SlashCmdList["QUICKRACK"] = function(msg)
  msg = msg or ""
  local cmd, rest = msg:match("^(%S+)%s*(.-)$")
  cmd = cmd and cmd:lower() or ""

  if cmd == "save" then
    QuickRack_SaveSet(rest)
  elseif cmd == "equip" or cmd == "wear" then
    QuickRack_EquipSet(rest)
  elseif cmd == "delete" or cmd == "del" then
    QuickRack_DeleteSet(rest)
  elseif cmd == "mountset" then
    if QuickRack_SetTrigger then
    QuickRack_SetTrigger("mount", rest)
  else
    QuickRack_SetMountSet(rest) -- fallback if you haven’t added triggers yet
  end
	elseif cmd == "mountclear" then
    if QuickRack_SetTrigger then
    QuickRack_SetTrigger("mount", nil)
  else
    QuickRack_ClearMountSet()
  end
  elseif cmd == "list" then
    QuickRack_ListSets()
  elseif cmd == "ui" then
    if QuickRackUI and QuickRackUI.Toggle then QuickRackUI.Toggle() end
  else
    Print("Commands:")
    DEFAULT_CHAT_FRAME:AddMessage("  /qr save <name>")
    DEFAULT_CHAT_FRAME:AddMessage("  /qr equip <name>")
    DEFAULT_CHAT_FRAME:AddMessage("  /qr delete <name>")
    DEFAULT_CHAT_FRAME:AddMessage("  /qr list")
    DEFAULT_CHAT_FRAME:AddMessage("  /qr ui")
  end
end

-- ============================================================
-- 5) Triggers (Mount + Dual Spec)
-- ============================================================
local pendingAction = nil     -- "equipMount" | "restorePreMount"
local lastMountedState = nil  -- track transitions  -- track transitions

local function HaveMountSet()
  EnsureDB()
  local setName = QuickRack_GetTrigger and QuickRack_GetTrigger("mount") or QuickRackDB.mountSetName
  return setName and setName ~= ""
end

function QuickRack_SetMountSet(name)
  EnsureDB()
  if not name or name == "" then
    Print("Usage: /qr mountset <name>")
    return
  end
  if not QuickRackDB.sets[name] then
    Print("No set named '" .. name .. "'. Save it first with /qr save " .. name)
    return
  end
  QuickRackDB.mountSetName = name
  Print("Mount set is now '" .. name .. "'.")
end

function QuickRack_ClearMountSet()
  EnsureDB()
  QuickRackDB.mountSetName = nil
  Print("Mount set cleared.")
end

local function TryRunPending()
  if not pendingAction then return end
  if InCombatLockdown and InCombatLockdown() then return end

  -- While dead/ghost, equipping can be flaky; wait until we're alive again.
  if UnitIsDeadOrGhost and UnitIsDeadOrGhost("player") then return end

  if pendingAction == "equipMount" then
    pendingAction = nil
    if IsMounted and IsMounted() then
      local setName = QuickRack_GetTrigger and QuickRack_GetTrigger("mount") or QuickRackDB.mountSetName
      if setName and setName ~= "" then
        QuickRack_EquipSet(setName)
      end
    end
    elseif pendingAction == "restorePreMount" then
    pendingAction = nil
    local db = EnsureDB()
    if db.mountSwap and db.mountSwap.preSnapshot and (not IsMounted or not IsMounted()) then
      EquipSnapshotLinks(db.mountSwap.preSnapshot)
      db.mountSwap.preSnapshot = nil
      db.mountSwap.active = nil
      Print("Restored pre-mount gear.")
    end
  end
end

local function OnMountChanged()
  local mounted = (IsMounted and IsMounted()) or false
  if lastMountedState == mounted then return end
  lastMountedState = mounted

  local db = EnsureDB()
  db.mountSwap = db.mountSwap or {}

  -- If no mount set configured, do nothing (but clear stale snapshot when unmounted).
  if not HaveMountSet() then
    if not mounted then
      db.mountSwap.preSnapshot = nil
      db.mountSwap.active = nil
      pendingAction = nil
    end
    return
  end

  if mounted then
    -- Mounting: snapshot current gear (persisted) then equip mount set (or defer)
    db.mountSwap.preSnapshot = SnapshotCurrentGearLinks()
    db.mountSwap.active = true

    if InCombatLockdown and InCombatLockdown() then
      pendingAction = "equipMount"
      Print("Mounted in combat; will equip mount set when combat ends.")
      return
    end

    local setName = QuickRack_GetTrigger and QuickRack_GetTrigger("mount") or QuickRackDB.mountSetName
    if setName and setName ~= "" then
      QuickRack_EquipSet(setName)
    end
  else
    -- Unmounting: restore persisted snapshot (or defer)
    if not (db.mountSwap and db.mountSwap.preSnapshot and db.mountSwap.active) then return end

    -- Some transitions (BG enter, death, etc.) can force-dismount without firing
    -- PLAYER_MOUNT_DISPLAY_CHANGED, and restoring while dead/ghost can be flaky.
    if UnitIsDeadOrGhost and UnitIsDeadOrGhost("player") then
      pendingAction = "restorePreMount"
      return
    end

    if InCombatLockdown and InCombatLockdown() then
      pendingAction = "restorePreMount"
      Print("Dismounted in combat; will restore gear when combat ends.")
      return
    end

    EquipSnapshotLinks(db.mountSwap.preSnapshot)
    db.mountSwap.preSnapshot = nil
    db.mountSwap.active = nil
    Print("Restored pre-mount gear.")
  end
end

local mountFrame = CreateFrame("Frame")
mountFrame:RegisterEvent("PLAYER_LOGIN")
mountFrame:RegisterEvent("PLAYER_MOUNT_DISPLAY_CHANGED") -- fires on mount/unmount in Classic-era clients
mountFrame:RegisterEvent("PLAYER_REGEN_ENABLED")         -- leaving combat
mountFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")     -- keep active set cache updated
-- Extra safety nets: some forced dismounts (BG zoning, death) don't fire PLAYER_MOUNT_DISPLAY_CHANGED.
mountFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
mountFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
mountFrame:RegisterEvent("PLAYER_DEAD")
mountFrame:RegisterEvent("PLAYER_ALIVE")
mountFrame:RegisterEvent("PLAYER_UNGHOST")

mountFrame:SetScript("OnEvent", function(self, event, ...)
  if event == "PLAYER_LOGIN" then
  lastMountedState = (IsMounted and IsMounted()) or false
  local db = EnsureDB()
  db.mountSwap = db.mountSwap or {}
  -- If we log in NOT mounted, clear any stale pre-mount snapshot
  if not lastMountedState then
    db.mountSwap.preSnapshot = nil
    db.mountSwap.active = nil
  end

  -- Cache equipped snapshot + active set for UI/editor
  db.equipped = db.equipped or {}
  db.equipped.slots = SnapshotCurrentGearLinks().slots
  db.equipped.activeSet = QuickRack_GetActiveSetName()
  elseif event == "PLAYER_MOUNT_DISPLAY_CHANGED" then
    OnMountChanged()
  elseif event == "PLAYER_REGEN_ENABLED" then
    TryRunPending()
  elseif event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED_NEW_AREA" then
    -- Zoning can force-dismount without the mount display event.
    OnMountChanged()
    TryRunPending()
  elseif event == "PLAYER_DEAD" then
    -- Dying while mounted can skip the mount display event; treat it like a potential dismount.
    OnMountChanged()
  elseif event == "PLAYER_ALIVE" or event == "PLAYER_UNGHOST" then
    -- If we deferred a restore because we were dead/ghost, try again now.
    OnMountChanged()
    TryRunPending()
  end
end)

-- =========================
-- Talent spec auto-swap support (Dual Spec)
-- =========================
-- Triggers:
--   "spec1" => when Primary talent group becomes active
--   "spec2" => when Secondary talent group becomes active
--
-- We intentionally delay execution until the client has fully applied the spec swap
-- (action bars/spells/talents), which can lag slightly behind the event.

do
  local specFrame = CreateFrame("Frame")
  local lastGroup = nil

  local pendingGroup = nil      -- 1 or 2
  local pendingSince = 0
  local pendingTimer = nil

  local function GetActiveGroupSafe()
    if not GetActiveTalentGroup then return nil end
    local ok, grp = pcall(GetActiveTalentGroup)
    if ok then return grp end
    return nil
  end

  local function TalentsLookReady()
    if not GetNumTalentTabs or not GetTalentTabInfo then
      -- If talent APIs aren't available, assume ready once group matches.
      return true
    end
    local okTabs, tabs = pcall(GetNumTalentTabs)
    if not okTabs or not tabs or tabs <= 0 then return false end

    -- If we can read tab names without error, it's "loaded enough" for our purpose.
    for i = 1, tabs do
      local ok, name = pcall(GetTalentTabInfo, i)
      if not ok or not name then return false end
    end
    return true
  end

  local function StopTimer()
    if pendingTimer and pendingTimer.Cancel then
      pendingTimer:Cancel()
    end
    pendingTimer = nil
  end

  local function ScheduleRetry()
    StopTimer()
    if C_Timer and C_Timer.NewTimer then
      pendingTimer = C_Timer.NewTimer(0.25, function()
        specFrame:GetScript("OnEvent")(specFrame, "QUICKRACK_SPEC_RETRY")
      end)
    end
  end

  local function TryEquipForGroup(group)
    if not group then return end
    if not CanSwapNow() then return end
    if UnitIsDeadOrGhost and UnitIsDeadOrGhost("player") then return end

    local triggerKey = (group == 2) and "spec2" or "spec1"
    local setName = QuickRack_GetTrigger and QuickRack_GetTrigger(triggerKey) or nil
    if not setName or setName == "" then return end

    -- Avoid re-equipping if we already match.
    if QuickRack_GetActiveSetName and QuickRack_GetActiveSetName() == setName then
      return
    end

    QuickRack_EquipSet(setName)
  end

  local function TryRunPendingSpec()
    if not pendingGroup then return end

    -- Don't attempt instantly; allow the client to settle after the swap.
    if GetTime and (GetTime() - pendingSince) < 0.40 then
      ScheduleRetry()
      return
    end

    local active = GetActiveGroupSafe()
    if not active or active ~= pendingGroup then
      ScheduleRetry()
      return
    end

    if not TalentsLookReady() then
      ScheduleRetry()
      return
    end

    local g = pendingGroup
    pendingGroup = nil
    StopTimer()
    TryEquipForGroup(g)
  end

  local function OnSpecPossiblyChanged()
    local active = GetActiveGroupSafe()
    if not active then return end

    if lastGroup == nil then
      lastGroup = active
      return
    end

    if active ~= lastGroup then
      lastGroup = active
      pendingGroup = active
      pendingSince = GetTime and GetTime() or 0
      TryRunPendingSpec()
    end
  end

  specFrame:RegisterEvent("PLAYER_LOGIN")
  specFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
  specFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
  specFrame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
  specFrame:RegisterEvent("PLAYER_TALENT_UPDATE")

  specFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
      lastGroup = GetActiveGroupSafe()
      pendingGroup = nil
      StopTimer()
    elseif event == "ACTIVE_TALENT_GROUP_CHANGED" then
      -- Some clients pass (curr, prev); we still verify with GetActiveTalentGroup().
      OnSpecPossiblyChanged()
    elseif event == "PLAYER_TALENT_UPDATE" then
      -- Often fires after the new spec is fully applied.
      TryRunPendingSpec()
    elseif event == "PLAYER_ENTERING_WORLD" then
      OnSpecPossiblyChanged()
      TryRunPendingSpec()
    elseif event == "PLAYER_REGEN_ENABLED" then
      -- If a swap happened in combat, try after leaving combat.
      TryRunPendingSpec()
    elseif event == "QUICKRACK_SPEC_RETRY" then
      TryRunPendingSpec()
    end
  end)
end
