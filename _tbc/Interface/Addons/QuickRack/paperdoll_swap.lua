-- QuickRack - paperdoll_swap.lua
-- Hover a paperdoll slot to show swappable items for that slot (icons + tooltips + click to equip).

local ADDON = ...
QuickRackPaperDollSwap = QuickRackPaperDollSwap or {}

local MAX_SHOW = 14         -- cap how many icons to show
local ICON_SIZE = 36
local PADDING = 4

-- Shared container wrappers (from utils.lua)
local GetBagItemLink = QuickRackUtil.GetBagItemLink
local GetBagNumSlots = QuickRackUtil.GetBagNumSlots

local function GetEquippedItemID(slotID)
  local link = GetInventoryItemLink("player", slotID)
  if not link then return 0 end
  local id = link:match("item:(%d+)")
  return id and tonumber(id) or 0
end

-- InventoryType -> eligible paperdoll slotIDs
-- (Not exhaustive; expand as needed.)
local INVTYPE_TO_SLOTS = {
  INVTYPE_HEAD        = {1},
  INVTYPE_NECK        = {2},
  INVTYPE_SHOULDER    = {3},
  INVTYPE_BODY        = {4},   -- shirt
  INVTYPE_CHEST       = {5},
  INVTYPE_ROBE        = {5},
  INVTYPE_WAIST       = {6},
  INVTYPE_LEGS        = {7},
  INVTYPE_FEET        = {8},
  INVTYPE_WRIST       = {9},
  INVTYPE_HAND        = {10},
  INVTYPE_FINGER      = {11, 12},
  INVTYPE_TRINKET     = {13, 14},
  INVTYPE_CLOAK       = {15},
  INVTYPE_WEAPON      = {16, 17},  -- 1H/2H weapons generally ok for main hand
  INVTYPE_WEAPONMAINHAND = {16},
  INVTYPE_WEAPONOFFHAND  = {17},
  INVTYPE_2HWEAPON    = {16},
  INVTYPE_SHIELD      = {17},
  INVTYPE_HOLDABLE    = {17},
  INVTYPE_RANGED      = {18},  -- varies by era/class
  INVTYPE_RANGEDRIGHT = {18},
  INVTYPE_THROWN      = {18},
  INVTYPE_RELIC       = {18},
}

local function ItemCanGoInSlot(itemLink, targetSlotID)
  if not itemLink then return false end
  local _, _, _, _, _, _, _, _, equipLoc = GetItemInfo(itemLink)
  if not equipLoc then return false end
  local slots = INVTYPE_TO_SLOTS[equipLoc]
  if not slots then return false end
  for _, s in ipairs(slots) do
    if s == targetSlotID then return true end
  end
  return false
end

local function CanSwapNow()
  if InCombatLockdown and InCombatLockdown() then
    return false
  end
  return true
end

-- ---------- UI Strip ----------
local strip
local GetCandidateItemsForSlot
local globalCloseInstalled = false
local UpdateStripButtonTooltip -- forward declare (used inside EnsureStrip)

local function QR_GetMouseFocus()
  if _G.GetMouseFocus then
    return _G.GetMouseFocus()
  end

  -- Some clients (incl. some Classic builds) use GetMouseFoci() instead.
  if _G.GetMouseFoci then
    local foci = _G.GetMouseFoci()
    if type(foci) == "table" then
      return foci[1]
    end
  end

  return nil
end

local function IsDescendantOf(frame, ancestor)
  if not frame or not ancestor then return false end
  local p = frame
  while p do
    if p == ancestor then return true end
    p = p.GetParent and p:GetParent() or nil
  end
  return false
end

local function StripIsHot()
  return strip and strip:IsShown() and (strip.hovering or strip.slotHovering)
end

local function StripScheduleHide(delay)
  if not strip then return end
  strip.hideToken = (strip.hideToken or 0) + 1
  local token = strip.hideToken
  C_Timer.After(delay or 0.20, function()
    if not strip then return end
    -- only hide if nothing is hovered AND no newer schedule happened
    if token == strip.hideToken and strip:IsShown() and not StripIsHot() then
      strip:Hide()
    end
  end)
end

local function EnsureStrip()
  if strip then return strip end

  strip = CreateFrame("Frame", "QuickRackPaperDollSwapStrip", UIParent, "BackdropTemplate")
  strip.hovering = false
strip.slotHovering = false
strip.hideToken = 0
  strip:SetFrameStrata("TOOLTIP")
  strip:SetFrameLevel(2000)
  strip:EnableMouse(true)
  strip:SetClampedToScreen(true)
  strip:Hide()

  strip:SetBackdrop({
    bgFile   = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left=4, right=4, top=4, bottom=4 }
  })
  strip:SetBackdropColor(0, 0, 0, 0.85)

  strip.buttons = {}
  strip.items = {} -- list of {link=..., id=...}

  strip.hovering = false

strip:SetScript("OnEnter", function()
  strip.hovering = true
end)

strip:SetScript("OnLeave", function()
  strip.hovering = false
  StripScheduleHide(0.25)
end)

  strip:RegisterEvent("MODIFIER_STATE_CHANGED")
  strip:SetScript("OnEvent", function(_, event, key)
    if event ~= "MODIFIER_STATE_CHANGED" then return end
    if key ~= "LSHIFT" and key ~= "RSHIFT" then return end
    if strip.hoveredButton and strip.hoveredButton:IsShown() and strip.hoveredButton:IsMouseOver() then
      UpdateStripButtonTooltip(strip.hoveredButton)
    end
  end)

  return strip
end

-- =========================
-- Itemstrip rarity glow
-- =========================
local function CreateStripRarityGlow(btn)
  local glow = btn:CreateTexture(nil, "OVERLAY")
  glow:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
  glow:SetBlendMode("ADD")
  glow:SetAlpha(0.65)
  glow:SetPoint("TOPLEFT", -14, 14)
  glow:SetPoint("BOTTOMRIGHT", 14, -14)
  glow:Hide()
  return glow
end

local function UpdateStripRarityGlow(btn, itemLink)
  if not btn or not btn.rarityGlow then return end

  if not itemLink then
    btn.rarityGlow:Hide()
    return
  end

  local quality = select(3, GetItemInfo(itemLink))
  if not quality or quality <= 1 then
    btn.rarityGlow:Hide()
    return
  end

  local r, g, b = GetItemQualityColor(quality)
  btn.rarityGlow:SetVertexColor(r, g, b)
  btn.rarityGlow:Show()
end

function UpdateStripButtonTooltip(btn)
  if not btn then return end
  if not strip then return end

  GameTooltip:SetOwner(btn, "ANCHOR_RIGHT")

  -- Always show the hovered strip item's real tooltip
  if btn.link then
    GameTooltip:SetHyperlink(btn.link)
  elseif strip.targetSlotID and GameTooltip.SetInventoryItem then
    -- Fallback (should rarely happen)
    GameTooltip:SetInventoryItem("player", strip.targetSlotID)
  end

  GameTooltip:Show()

  -- Shift: show currently equipped item(s) as compare tooltips
  if IsShiftKeyDown() then
    if _G.GameTooltip_ShowCompareItem then
      _G.GameTooltip_ShowCompareItem(GameTooltip)
    end
  else
    -- Ensure compare tooltips don't “stick”
    if _G.ShoppingTooltip1 then _G.ShoppingTooltip1:Hide() end
    if _G.ShoppingTooltip2 then _G.ShoppingTooltip2:Hide() end
    if _G.ShoppingTooltip3 then _G.ShoppingTooltip3:Hide() end
  end
end

local function InstallGlobalStripClose()
  if globalCloseInstalled then return end
  globalCloseInstalled = true

    -- Global close for the strip (works even when opened from pinbar).
  -- Uses GLOBAL_MOUSE_DOWN so we don't hook UIParent or create click-catcher frames
  -- (those can interfere with mouselook / cursor behavior).
  if not QuickRackPaperDollSwap.__globalMouseCloseFrame then
    local gm = CreateFrame("Frame")
    QuickRackPaperDollSwap.__globalMouseCloseFrame = gm

    gm:RegisterEvent("GLOBAL_MOUSE_DOWN")
    gm:SetScript("OnEvent", function(_, _, mouseButton)
      if not strip or not strip:IsShown() then return end

      local focus = QR_GetMouseFocus()

      -- Ignore clicks on the strip OR any of its children (buttons, textures, etc.)
      if focus and IsDescendantOf(focus, strip) then
        return
      end

      -- Ignore clicks on the anchor button that spawned the strip (or its children)
      local anchor = strip._anchorButton
      if anchor and focus and IsDescendantOf(focus, anchor) then
        return
      end

      strip.hovering = false
      strip.slotHovering = false
      strip:Hide()
    end)
  end

  local function HookFrame(frame)
    if not frame or frame.__qr_stripCloseHooked then return end
    frame.__qr_stripCloseHooked = true

    frame:HookScript("OnMouseDown", function()
      if not strip or not strip:IsShown() then return end

      local focus = QR_GetMouseFocus()

      -- Ignore clicks on the strip itself
      if focus and (focus == strip or (focus.IsDescendantOf and focus:IsDescendantOf(strip))) then
        return
      end

      -- Ignore clicks on the anchor button that spawned the strip
      local anchor = strip._anchorButton
      if anchor and focus and (focus == anchor or (focus.IsDescendantOf and focus:IsDescendantOf(anchor))) then
        return
      end

      strip.hovering = false
      strip.slotHovering = false
      strip:Hide()
    end)
  end

  -- Only hook UI frames (do NOT hook UIParent — it can break world mouse behavior)
  HookFrame(CharacterFrame)
  HookFrame(PaperDollFrame)
end

local function ClearStrip()
  if not strip then return end
  for _, b in ipairs(strip.buttons) do
    b:Hide()
    if b.rarityGlow then b.rarityGlow:Hide() end
    b.link = nil
    b.bag = nil
    b.bagSlot = nil
  end
  wipe(strip.items)
end

local function LayoutStrip(count)
  local w = PADDING + count * (ICON_SIZE + PADDING)
  local h = ICON_SIZE + PADDING * 2
  strip:SetSize(w, h)

  for i = 1, count do
    local b = strip.buttons[i]
    if not b then
      b = CreateFrame("Button", nil, strip)
      b:SetSize(ICON_SIZE, ICON_SIZE)

      b.icon = b:CreateTexture(nil, "ARTWORK")
      b.icon:SetAllPoints()
      b.rarityGlow = CreateStripRarityGlow(b)


      b:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")

      b:SetScript("OnEnter", function(self)
        if strip then
          strip.hovering = true
          strip.hoveredButton = self
        end
        if not self.link and not (strip and strip.targetSlotID) then return end
        UpdateStripButtonTooltip(self)
      end)

      b:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
        if strip then
          if strip.hoveredButton == self then
            strip.hoveredButton = nil
          end
          strip.hovering = false
          StripScheduleHide(0.25)
        end
      end)

      b:SetScript("OnClick", function(self)
        if not self.link or self.bag == nil or self.bagSlot == nil then return end
        if not CanSwapNow() then
          UIErrorsFrame:AddMessage("Can't swap gear in combat.", 1, 0.1, 0.1)
          return
        end

        if strip and strip.targetSlotID then
          ClearCursor()

          QuickRackUtil.PickupBagItem(self.bag, self.bagSlot)

          if CursorHasItem and CursorHasItem() then
            EquipCursorItem(strip.targetSlotID)

            -- If Blizzard shows a bind/trade warning, the item remains on the cursor
            -- until the user confirms/cancels. Clearing the cursor here would suppress it.
            if not (CursorHasItem and CursorHasItem()) then
              ClearCursor()
            end
          end

          -- Hide the strip immediately after a click
          strip.hovering = false
          strip.slotHovering = false
          strip:Hide()
        end
      end)

      strip.buttons[i] = b
    end

    -- Position button i
    b:ClearAllPoints()
    b:SetPoint("LEFT", strip, "LEFT", PADDING + (i - 1) * (ICON_SIZE + PADDING), 0)
  end
end

local function ShowStripForSlot(slotButton, slotID, items, opts)
  EnsureStrip()
  ClearStrip()

  local count = math.min(#items, MAX_SHOW)
  if count <= 0 then
    strip:Hide()
    return
  end

  strip.targetSlotID = slotID
  LayoutStrip(count)

  for i = 1, count do
    local entry = items[i]
    local link = entry.link
    local tex = select(10, GetItemInfo(link)) -- texture
    local b = strip.buttons[i]

    b.link = link
    b.bag = entry.bag
    b.bagSlot = entry.slot

    b.icon:SetTexture(tex)
    UpdateStripRarityGlow(b, link)
    b:Show()
  end

  -- Hide any unused buttons from a previous larger strip
  for i = count + 1, #strip.buttons do
    strip.buttons[i]:Hide()
  end

  -- Position:
  -- Default: to the right of the slot button.
  -- Weapon slots (16/17/18): show BELOW and then extend to the right. This avoids covering neighboring slots.
  strip:ClearAllPoints()

  local isWeaponSlot = (slotID == 16) or (slotID == 17) or (slotID == 18)
  local forceBelow = opts and opts.forceBelow

  if forceBelow or isWeaponSlot then
    strip:SetPoint("TOPLEFT", slotButton, "BOTTOMLEFT", 0, -6)
  else
    strip:SetPoint("TOPLEFT", slotButton, "TOPRIGHT", 6, 2)
  end

  InstallGlobalStripClose()
  strip._anchorButton = slotButton

  strip:Show()

  -- Clamp horizontally if we go off the right edge.
  if strip:GetRight() and strip:GetRight() > UIParent:GetRight() - 10 then
    strip:ClearAllPoints()
    if forceBelow or isWeaponSlot then
      strip:SetPoint("TOPRIGHT", slotButton, "BOTTOMRIGHT", 0, -6)
    else
      strip:SetPoint("TOPRIGHT", slotButton, "TOPLEFT", -6, 2)
    end
  end

  -- Clamp vertically if we go off the bottom of the screen (rare, but possible).
  if strip:GetBottom() and strip:GetBottom() < UIParent:GetBottom() + 10 then
    strip:ClearAllPoints()
    if forceBelow or isWeaponSlot then
      -- Move above the slot instead.
      strip:SetPoint("BOTTOMLEFT", slotButton, "TOPLEFT", 0, 6)
    else
      strip:SetPoint("BOTTOMLEFT", slotButton, "TOPRIGHT", 6, -2)
    end
  end
end

-- ============================================================
-- Public API for PinBar (and others)
-- ============================================================

function QuickRackPaperDollSwap.ShowForSlot(anchorButton, slotID, ownerTag)
  slotID = tonumber(slotID)
  if not slotID then return end
  if not anchorButton then return end

  local items = GetCandidateItemsForSlot(slotID, 30)
  if not items or #items == 0 then
    return
  end

    local opts = nil
  if ownerTag == "pinbar" then
    opts = { forceBelow = true }
  end

  ShowStripForSlot(anchorButton, slotID, items, opts)
end

function QuickRackPaperDollSwap.Hide()
  if strip then strip:Hide() end
end

function QuickRackPaperDollSwap.IsShowing()
  return strip and strip:IsShown()
end

-- ---------- Bag Scan ----------
GetCandidateItemsForSlot = function(targetSlotID)
  local out = {}

  for bag = 0, 4 do
    local n = GetBagNumSlots(bag)
    for slot = 1, n do
      local link = GetBagItemLink(bag, slot)
      if link and ItemCanGoInSlot(link, targetSlotID) then
        table.insert(out, { bag = bag, slot = slot, link = link })
      end
    end
  end

  -- Sort by item name for stability (optional)
  table.sort(out, function(a, b)
    local na = GetItemInfo(a.link) or ""
    local nb = GetItemInfo(b.link) or ""
    if na == nb then
      -- stable-ish ordering within same name
      if a.bag == b.bag then
        return a.slot < b.slot
      end
      return a.bag < b.bag
    end
    return na < nb
  end)

  return out
end

-- ---------- Hook PaperDoll ----------
local function HookSlot(slotName, slotID)
  local btn = _G[slotName]
  if not btn then return end

  if btn.__qr_hooked then return end
  btn.__qr_hooked = true

btn:HookScript("OnEnter", function(self)
  if not PaperDollFrame or not PaperDollFrame:IsShown() then return end

  EnsureStrip()
  strip.slotHovering = true

  local items = GetCandidateItemsForSlot(slotID)
  if #items == 0 then
    strip:Hide()
    return
  end

  ShowStripForSlot(self, slotID, items)
end)

btn:HookScript("OnLeave", function(self)
  if not strip then return end
  strip.slotHovering = false
  StripScheduleHide(0.25)
end)
end
local function Init()
  -- Slot buttons in PaperDoll
  HookSlot("CharacterHeadSlot", 1)
  HookSlot("CharacterNeckSlot", 2)
  HookSlot("CharacterShoulderSlot", 3)
  HookSlot("CharacterShirtSlot", 4)
  HookSlot("CharacterChestSlot", 5)
  HookSlot("CharacterWaistSlot", 6)
  HookSlot("CharacterLegsSlot", 7)
  HookSlot("CharacterFeetSlot", 8)
  HookSlot("CharacterWristSlot", 9)
  HookSlot("CharacterHandsSlot", 10)
  HookSlot("CharacterFinger0Slot", 11)
  HookSlot("CharacterFinger1Slot", 12)
  HookSlot("CharacterTrinket0Slot", 13)
  HookSlot("CharacterTrinket1Slot", 14)
  HookSlot("CharacterBackSlot", 15)
  HookSlot("CharacterMainHandSlot", 16)
  HookSlot("CharacterSecondaryHandSlot", 17)
  HookSlot("CharacterRangedSlot", 18)
  -- Tabard slot is 19 in equipment but not always present as a standard button
  -- HookSlot("CharacterTabardSlot", 19)

  -- Hide strip if character frame closes
  if CharacterFrame then
    CharacterFrame:HookScript("OnHide", function()
      if strip and strip.owner == "paperdoll" then
        strip.hovering = false
        strip.slotHovering = false
        strip:Hide()
      end
    end)
  end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function()
  Init()
end)