-- QuickRack - pinbar.lua
-- A draggable bar showing pinned equipment slots for fast, real-gear swapping.
-- Uses the existing QuickRackPaperDollSwap strip picker for UI + equipping.

local ADDON = ...

QuickRackPinBar = QuickRackPinBar or {}

local U = QuickRackUtil
local Print = (U and U.Print) or function() end

local ICON_SIZE = 32
local PADDING = 6

QuickRackPinBar.DEBUG = QuickRackPinBar.DEBUG or false
local function Debug(msg)
  if QuickRackPinBar.DEBUG then
    Print("|cffaaaaaa[PinBar]|r " .. msg)
  end
end

local function ProbeButton(btn, where, clickButton)
  if not QuickRackPinBar.DEBUG then return end
  if not btn then
    Print("|cffff3333[PinBarProbe]|r " .. where .. ": btn=nil")
    return
  end

  local t  = tostring(btn:GetAttribute("type"))
  local mt = tostring(btn:GetAttribute("macrotext"))
  local t2 = tostring(btn:GetAttribute("type2"))
  local mt2= tostring(btn:GetAttribute("macrotext2"))
  local it2  = tostring(btn:GetAttribute("item2"))
local st2  = tostring(btn:GetAttribute("*type2"))
local sit2 = tostring(btn:GetAttribute("*item2"))

  Print("|cffffff00[PinBarProbe]|r " .. where
    .. " click=" .. tostring(clickButton)
    .. " slot=" .. tostring(btn.slotID)
    .. " protected=" .. tostring(btn.IsProtected and btn:IsProtected() or "n/a")
    .. " inCombat=" .. tostring(InCombatLockdown and InCombatLockdown() or false)
    .. " type=" .. t .. " macro=" .. mt
    .. " type2=" .. t2 .. " macro2=" .. mt2
    .. " mouseFocus=" .. tostring(GetMouseFocus and GetMouseFocus() or "n/a")
    .. " item2=".. it2
    .. "type2=" .. st2
    .. "item2=".. sit2)
end

-- SlotID -> inventory slot name (for GetInventorySlotInfo)
local SLOT_ID_TO_NAME = {
  [1]  = "HeadSlot",
  [2]  = "NeckSlot",
  [3]  = "ShoulderSlot",
  [4]  = "ShirtSlot",
  [5]  = "ChestSlot",
  [6]  = "WaistSlot",
  [7]  = "LegsSlot",
  [8]  = "FeetSlot",
  [9]  = "WristSlot",
  [10] = "HandsSlot",
  [11] = "Finger0Slot",
  [12] = "Finger1Slot",
  [13] = "Trinket0Slot",
  [14] = "Trinket1Slot",
  [15] = "BackSlot",
  [16] = "MainHandSlot",
  [17] = "SecondaryHandSlot",
  [18] = "RangedSlot",
  [19] = "TabardSlot",
}

local SLOT_ID_TO_LABEL = {
  [1]  = "Head",
  [2]  = "Neck",
  [3]  = "Shoulder",
  [4]  = "Shirt",
  [5]  = "Chest",
  [6]  = "Waist",
  [7]  = "Legs",
  [8]  = "Feet",
  [9]  = "Wrist",
  [10] = "Hands",
  [11] = "Ring 1",
  [12] = "Ring 2",
  [13] = "Trinket 1",
  [14] = "Trinket 2",
  [15] = "Back",
  [16] = "Main Hand",
  [17] = "Off Hand",
  [18] = "Ranged",
  [19] = "Tabard",
}

local frame

local function SetCooldown(cdFrame, start, duration, enable)
  if not cdFrame then return end
  if not start or not duration or enable ~= 1 or duration <= 0 then
    -- clear
    if cdFrame.Clear then cdFrame:Clear() end
    cdFrame:SetCooldown(0, 0)
    return
  end

  if _G.CooldownFrame_Set then
    _G.CooldownFrame_Set(cdFrame, start, duration, enable)
  else
    cdFrame:SetCooldown(start, duration)
  end
end

local function UpdateButtonCooldown(btn)
  if not btn or not btn.slotID or not _G.GetInventoryItemCooldown then return end
  local start, duration, enable = _G.GetInventoryItemCooldown("player", btn.slotID)
  SetCooldown(btn.cooldown, start, duration, enable)
end

local function GetDB()
  if EnsureCharDB then
    return EnsureCharDB()
  end
  return QuickRackDB
end

local function EnsureUIBuckets()
  local db = GetDB()
  if not db then return nil end
  db.ui = db.ui or {}
  db.ui.pins = db.ui.pins or {}
  db.ui.pinbar = db.ui.pinbar or { point = "CENTER", relPoint = "CENTER", x = 0, y = 0 }
  return db
end

local function GetPinnedMap()
  local db = EnsureUIBuckets()
  return db and db.ui and db.ui.pins or {}
end

local function GetPinnedSlotIDsSorted()
  local pins = GetPinnedMap()
  local ids = {}
  for slotID, v in pairs(pins) do
    if v then
      local n = tonumber(slotID) or slotID
      table.insert(ids, n)
    end
  end
  table.sort(ids, function(a, b) return a < b end)
  return ids
end

-- =========================
-- Public pin API (used by editor)
-- =========================

function QuickRackPinBar.IsPinned(slotID)
  local sid = tonumber(slotID) or slotID
  local pins = GetPinnedMap()
  return pins and pins[sid] == true or false
end

function QuickRackPinBar.SetPinned(slotID, pinned)
  local sid = tonumber(slotID) or slotID
  local pins = GetPinnedMap()
  if not pins then return end

  if pinned then
    pins[sid] = true
  else
    pins[sid] = nil
  end
end

local function GetSlotDefaultTexture(slotID)
  local slotName = SLOT_ID_TO_NAME[slotID]
  if not slotName or not GetInventorySlotInfo then return nil end
  local _, tex = GetInventorySlotInfo(slotName)
  return tex
end

local function GetEquippedTextureForSlot(slotID)
  local link = GetInventoryItemLink and GetInventoryItemLink("player", slotID) or nil
  if not link then return nil end
  local tex = select(10, GetItemInfo(link))
  return tex
end

local function ApplySavedPosition()
  if not frame then return end
  local db = EnsureUIBuckets()
  if not db then return end
  local p = db.ui.pinbar or {}
  frame:ClearAllPoints()
  frame:SetPoint(p.point or "CENTER", UIParent, p.relPoint or "CENTER", p.x or 0, p.y or 0)
end

local function SavePosition()
  if not frame then return end
  local db = EnsureUIBuckets()
  if not db then return end

  local point, relTo, relPoint, x, y = frame:GetPoint(1)
  if not point then return end
  db.ui.pinbar.point = point
  db.ui.pinbar.relPoint = relPoint or point
  db.ui.pinbar.x = math.floor((x or 0) + 0.5)
  db.ui.pinbar.y = math.floor((y or 0) + 0.5)
end

local function EnsureFrame()
  if frame then return frame end

  frame = CreateFrame("Frame", "QuickRackPinBarFrame", UIParent, "BackdropTemplate")
  frame:SetFrameStrata("MEDIUM")
  frame:SetFrameLevel(2000)
  frame:SetClampedToScreen(true)

  frame:SetBackdrop({
    bgFile   = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left=4, right=4, top=4, bottom=4 }
  })
  frame:SetBackdropColor(0, 0, 0, 0.85)

  -- The container should NOT steal clicks from buttons.
frame:EnableMouse(false)
frame:SetMovable(true)

-- Create a dedicated drag handle (background)
-- Drag handle: a small strip on top of the bar (does NOT cover the buttons)
frame.drag = frame.drag or CreateFrame("Frame", nil, frame)
frame.drag:EnableMouse(true)
frame.drag:RegisterForDrag("LeftButton")
frame.drag:SetFrameLevel(frame:GetFrameLevel() + 1)

frame.drag:ClearAllPoints()
frame.drag:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, -4)
frame.drag:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -4, -4)
frame.drag:SetHeight(14)

frame.drag:SetScript("OnDragStart", function()
  frame:StartMoving()
end)
frame.drag:SetScript("OnDragStop", function()
  frame:StopMovingOrSizing()
  SavePosition()
end)


  frame.buttons = frame.buttons or {}

  frame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
  frame:RegisterEvent("UNIT_INVENTORY_CHANGED")
  frame:RegisterEvent("PLAYER_REGEN_ENABLED")

  ApplySavedPosition()
  frame:Hide()

  return frame
end

local function EnsureButton(i)
  EnsureFrame()
  local b = frame.buttons[i]
  if b then return b end

  b = CreateFrame("Button", nil, frame, "BackdropTemplate")
  b:SetSize(ICON_SIZE, ICON_SIZE)
  b:RegisterForClicks("LeftButtonUp")
  b:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
  b:EnableMouse(true)
  b:SetFrameLevel(frame:GetFrameLevel() + 10)

  b.icon = b:CreateTexture(nil, "ARTWORK")
  b.icon:SetAllPoints()

    -- Cooldown swipe overlay (trinkets, on-use items, etc.)
  b.cooldown = CreateFrame("Cooldown", nil, b, "CooldownFrameTemplate")
  b.cooldown:SetAllPoints()
  b.cooldown:SetReverse(false)
  b.cooldown:SetDrawEdge(false)
  b.cooldown:SetSwipeColor(0, 0, 0, 0.75)

  b:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")

    local hasItem = false
    if self.slotID and _G.GameTooltip.SetInventoryItem then
      hasItem = GameTooltip:SetInventoryItem("player", self.slotID) and true or false
    end

    if not hasItem then
      GameTooltip:AddLine(
        SLOT_ID_TO_LABEL[self.slotID] or ("Slot " .. tostring(self.slotID)),
        1, 1, 1
      )
    end

    GameTooltip:AddLine("Left-click: swap item", 0.8, 0.8, 0.8)
    GameTooltip:Show()
  end)

  b:SetScript("OnLeave", function()
    if GameTooltip then GameTooltip:Hide() end
  end)

  b:SetScript("OnClick", function(self)
    if QuickRackPaperDollSwap and QuickRackPaperDollSwap.ShowForSlot then
      QuickRackPaperDollSwap.ShowForSlot(self, self.slotID, "pinbar")
    end
  end)

  frame.buttons[i] = b
  return b
end

function QuickRackPinBar.TogglePin(slotID)
  local sid = tonumber(slotID) or slotID
  if QuickRackPinBar.IsPinned(sid) then
    QuickRackPinBar.SetPinned(sid, false)
  else
    QuickRackPinBar.SetPinned(sid, true)
  end
  QuickRackPinBar.Refresh()
end

function QuickRackPinBar.Refresh()
  EnsureUIBuckets()
  EnsureFrame()

  local ids = GetPinnedSlotIDsSorted()

-- Never show the bar when nothing is pinned.
if #ids == 0 then
  if frame.emptyHint then frame.emptyHint:Hide() end
  frame:Hide()
  return
end

if frame.emptyHint then
  frame.emptyHint:Hide()
end

  local count = #ids
  local width = PADDING + count * (ICON_SIZE + PADDING)
  local height = ICON_SIZE + PADDING * 2
  frame:SetSize(width, height)

  for i = 1, count do
    local slotID = ids[i]
    local b = EnsureButton(i)
    b.slotID = slotID
    
    b:ClearAllPoints()
    b:SetPoint("LEFT", frame, "LEFT", PADDING + (i - 1) * (ICON_SIZE + PADDING), 0)

    local tex = GetEquippedTextureForSlot(slotID) or GetSlotDefaultTexture(slotID)
    if tex then b.icon:SetTexture(tex) end

    UpdateButtonCooldown(b)
    b:Show()
  end

  for i = count + 1, #frame.buttons do
    frame.buttons[i]:Hide()
    frame.buttons[i].slotID = nil
  end

  frame:Show()
end

function QuickRackPinBar.UpdateCooldowns()
  if not frame or not frame.buttons then return end
  for i = 1, #frame.buttons do
    local b = frame.buttons[i]
    if b and b:IsShown() and b.slotID then
      UpdateButtonCooldown(b)
    end
  end
end

function QuickRackPinBar.Init()
  EnsureUIBuckets()
  EnsureFrame()
  QuickRackPinBar.Refresh()
end

do
  local f = CreateFrame("Frame")
  f:RegisterEvent("PLAYER_LOGIN")
  f:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
  f:RegisterEvent("BAG_UPDATE_DELAYED")
  f:RegisterEvent("UNIT_INVENTORY_CHANGED")
  f:RegisterEvent("PLAYER_REGEN_ENABLED")
    f:RegisterEvent("BAG_UPDATE_COOLDOWN")
  f:RegisterEvent("SPELL_UPDATE_COOLDOWN")
  f:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
  f:SetScript("OnEvent", function(_, event)
    if not frame then
      QuickRackPinBar.Init()
      return
    end

    if event == "BAG_UPDATE_COOLDOWN" or event == "SPELL_UPDATE_COOLDOWN" or event == "ACTIONBAR_UPDATE_COOLDOWN" then
      QuickRackPinBar.UpdateCooldowns()
    else
      QuickRackPinBar.Refresh()
    end
  end)
end
