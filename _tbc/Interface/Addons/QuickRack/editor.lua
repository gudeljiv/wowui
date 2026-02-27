-- QuickRack - editor.lua
-- Gearset editor: edit sets without equipping, support per-slot ignore.

QuickRackEditor = QuickRackEditor or {}

local NormalizeItemString = QuickRackUtil.NormalizeItemString
local Print = QuickRackUtil.Print
local SLOT_IDS = QuickRackUtil.SLOT_IDS

local function EnsureDB()
  QuickRackDB = QuickRackDB or {}
  -- If core.lua per-character DB exists, it will create the right buckets.
  if EnsureCharDB then
    EnsureCharDB()
  end
end

local function GetDB()
  -- Prefer core.lua’s per-character db if available
  if EnsureCharDB then
    return EnsureCharDB()
  end
  EnsureDB()
  return QuickRackDB
end

local TRIGGERS = {
  { key = "none",  label = "None" },
  { key = "mount", label = "Mounting" },
}

-- Slot layout (paperdoll-ish)
local SLOT_LAYOUT = {
  -- left column
  { slotName="HeadSlot",      x=40,  y=-90 },
  { slotName="NeckSlot",      x=40,  y=-130 },
  { slotName="ShoulderSlot",  x=40,  y=-170 },
  { slotName="BackSlot",      x=40,  y=-210 },
  { slotName="ChestSlot",     x=40,  y=-250 },
  { slotName="ShirtSlot",     x=40,  y=-290 },
  { slotName="TabardSlot",    x=40,  y=-330 },
  { slotName="WristSlot",     x=40,  y=-370 },

  -- right column
  { slotName="HandsSlot",     x=260, y=-90 },
  { slotName="WaistSlot",     x=260, y=-130 },
  { slotName="LegsSlot",      x=260, y=-170 },
  { slotName="FeetSlot",      x=260, y=-210 },
  { slotName="Finger0Slot",   x=260, y=-250 },
  { slotName="Finger1Slot",   x=260, y=-290 },
  { slotName="Trinket0Slot",  x=260, y=-330 },
  { slotName="Trinket1Slot",  x=260, y=-370 },

    -- bottom row (Character tab style)
  { slotName="MainHandSlot",      x=95, y=-370 },
  { slotName="SecondaryHandSlot", x=150, y=-370 },
  { slotName="RangedSlot",        x=205, y=-370 },

}

local frame
local dropdown
local LoadSetToDraft
local Dropdown_Initialize
local buttonsBySlotID = {}
local RefreshButton
local currentSetName = nil
local bindBtn
local bindLabel
local RefreshBindLabel
local StartBindFlow
local draftSlots = nil -- slotID -> false(ignore) | nil(empty) | itemID(number)
local CURRENT_VALUE = "__QR_CURRENT__"
local CURRENT_LABEL = "Currently Equipped"

local triggerDropdown
local function RefreshTriggerDropdown() end
local function TriggerDropdown_Initialize(self, level) end

local slotPickMenuFrame
local currentPickAnchorButton = nil
local currentPickSlotID = nil
local ShowPickMenu  -- forward declare so ReopenPickMenu can call it

local pickMenuClickCatcher
local function EnsurePickMenuClickCatcher()
  if pickMenuClickCatcher then return end

  pickMenuClickCatcher = CreateFrame("Frame", "QuickRackEditorPickMenuClickCatcher", UIParent)
  pickMenuClickCatcher:Hide()
  pickMenuClickCatcher:SetAllPoints(UIParent)

  -- Must be BELOW the dropdown list (which is typically FULLSCREEN_DIALOG)
  pickMenuClickCatcher:SetFrameStrata("FULLSCREEN")
  pickMenuClickCatcher:SetFrameLevel(1)

  pickMenuClickCatcher:EnableMouse(true)
  pickMenuClickCatcher:SetScript("OnMouseDown", function()
    CloseDropDownMenus()
  end)
end

QuickRackEditor._openingDropdown = false

local function SlotKey(slotID)
  return tostring(slotID)
end

-- =========================
-- Pin helpers (real-gear pinbar)
-- =========================
local function IsSlotPinned(slotID)
  if QuickRackPinBar and QuickRackPinBar.IsPinned then
    return QuickRackPinBar.IsPinned(slotID)
  end
  local db = GetDB()
  db.ui = db.ui or {}
  db.ui.pins = db.ui.pins or {}
  return db.ui.pins[tonumber(slotID) or slotID] == true
end

local function ToggleSlotPin(slotID)
  if QuickRackPinBar and QuickRackPinBar.TogglePin then
    QuickRackPinBar.TogglePin(slotID)
    return
  end
  local db = GetDB()
  db.ui = db.ui or {}
  db.ui.pins = db.ui.pins or {}
  local sid = tonumber(slotID) or slotID
  db.ui.pins[sid] = not db.ui.pins[sid] and true or nil
end

-- Popup: New (creates a new set from currently equipped gear)
StaticPopupDialogs["QUICKRACK_EDITOR_NEW"] = {
  text = "Name your new gearset:",
  button1 = "Create",
  button2 = "Cancel",
  hasEditBox = true,
  timeout = 0,
  whileDead = true,
  hideOnEscape = true,
  preferredIndex = 3,

  OnShow = function(self)
    self.EditBox:SetText("")
    self.EditBox:SetFocus()
  end,

  OnAccept = function(self)
    local name = self.EditBox:GetText()
    if name and name:gsub("%s+", "") ~= "" then
      QuickRackEditor.NewFromEquipped(name)
    end
  end,

  EditBoxOnEnterPressed = function(editBox)
    local parent = editBox:GetParent()
    local name = editBox:GetText()
    if name and name:gsub("%s+", "") ~= "" then
      QuickRackEditor.NewFromEquipped(name)
    end
    parent:Hide()
  end,
}

local function BuildKeyString(key)
  -- Convert WoW key + modifier state into binding string, like "CTRL-SHIFT-F"
  if not key or key == "" then return nil end
  if key == "UNKNOWN" then return nil end

  -- Disallow pure modifier keys
  if key == "LSHIFT" or key == "RSHIFT" or key == "LCTRL" or key == "RCTRL"
     or key == "LALT" or key == "RALT" then
    return nil
  end

  local parts = {}
  if IsControlKeyDown() then table.insert(parts, "CTRL") end
  if IsAltKeyDown() then table.insert(parts, "ALT") end
  if IsShiftKeyDown() then table.insert(parts, "SHIFT") end
  table.insert(parts, key:upper())
  return table.concat(parts, "-")
end

local function ShowBindKeyPrompt(parent, onKeyPicked)
  -- Modal that captures exactly one key combo, then closes.
  -- Uses an invisible EditBox to reliably get keyboard focus on all clients.

  local f = CreateFrame("Frame", nil, parent, "BackdropTemplate")
  f:SetAllPoints(parent)
  f:SetFrameStrata("DIALOG")
  f:SetFrameLevel((parent:GetFrameLevel() or 1) + 50)

  f:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 8, right = 8, top = 8, bottom = 8 },
  })
  f:SetBackdropColor(0, 0, 0, 0.8)

  local text = f:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
  text:SetPoint("CENTER", f, "CENTER", 0, 18)
  text:SetText("Press a key to bind\n(ESC to cancel)")

  local sub = f:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
  sub:SetPoint("TOP", text, "BOTTOM", 0, -10)
  sub:SetText("Tip: Use Ctrl / Alt / Shift modifiers")

  local function Cleanup()
    f:Hide()
    f:EnableKeyboard(false)
    f:SetScript("OnKeyDown", nil)
    f:ClearAllPoints()
    f:SetParent(nil)
  end

  local function HandleKey(key)
    if key == "ESCAPE" then
      Cleanup()
      return
    end

    local bind = BuildKeyString(key)
    if not bind then
      -- Ignore invalid keys (pure modifiers etc.)
      return
    end

    if onKeyPicked then
      onKeyPicked(bind)
    end
    Cleanup()
  end

  -- Invisible focus catcher (EditBox has SetFocus)
  local e = CreateFrame("EditBox", nil, f)
  e:SetAutoFocus(true)
  e:EnableKeyboard(true)
  e:SetSize(1, 1)
  e:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
  e:SetAlpha(0)

  -- Some clients send key events to the focused EditBox, others to the parent.
  e:SetScript("OnKeyDown", function(_, key) HandleKey(key) end)

  f:EnableKeyboard(true)
  f:SetScript("OnKeyDown", function(_, key) HandleKey(key) end)

  f:Show()

  -- Focus AFTER show so it actually takes.
  if e.SetFocus then
    e:SetFocus()
  end
end

function QuickRackEditor.NewFromEquipped(name)
  EnsureDB()
  local db = GetDB()

  if db.sets[name] then
    Print("A gearset with that name already exists.")
    return
  end

  if not QuickRack_SaveSet then
    Print("Core not loaded: can't snapshot equipped gear.")
    return
  end

  -- This creates a brand new set using CURRENTLY EQUIPPED gear
  QuickRack_SaveSet(name)

  -- Select + load it into the editor
  currentSetName = name
  if db.editor then db.editor.lastSetName = name end

  UIDropDownMenu_Initialize(dropdown, Dropdown_Initialize)
  UIDropDownMenu_SetSelectedValue(dropdown, name)
  UIDropDownMenu_SetText(dropdown, name)

  LoadSetToDraft(name)
end

function ClearAllDropdownItemTooltips()
  for level = 1, 5 do
    local listFrame = _G["DropDownList" .. level]
    if listFrame then
      local num = listFrame.numButtons or 0
      for i = 1, num do
        local btn = _G["DropDownList" .. level .. "Button" .. i]
        if btn then
          btn.qrItemLink = nil
        end
      end
    end
  end
  if GameTooltip then GameTooltip:Hide() end
end

-- Add once (somewhere after the function exists)
if not QuickRackEditor._qrDropHooked then
  hooksecurefunc("CloseDropDownMenus", function()
  -- IMPORTANT: ToggleDropDownMenu() calls CloseDropDownMenus() while opening.
  -- Don't wipe qrItemLink during open, or item-row tooltips will never work.
  if QuickRackEditor._openingDropdown then return end

  if pickMenuClickCatcher then
    pickMenuClickCatcher:Hide()
  end

  if ClearAllDropdownItemTooltips then
    ClearAllDropdownItemTooltips()
  end
end)
  QuickRackEditor._qrDropHooked = true
end

local function GetEquipLocForSlot(slotID)
  -- Map slotID -> equipLoc string(s)
  -- Not perfect for every edge-case, but good for: boots/gloves/rings/trinkets/weapons etc.
  if slotID == 1 then return { "INVTYPE_HEAD" } end
  if slotID == 2 then return { "INVTYPE_NECK" } end
  if slotID == 3 then return { "INVTYPE_SHOULDER" } end
  if slotID == 4 then return { "INVTYPE_BODY" } end
  if slotID == 5 then return { "INVTYPE_CHEST", "INVTYPE_ROBE" } end
  if slotID == 6 then return { "INVTYPE_WAIST" } end
  if slotID == 7 then return { "INVTYPE_LEGS" } end
  if slotID == 8 then return { "INVTYPE_FEET" } end
  if slotID == 9 then return { "INVTYPE_WRIST" } end
  if slotID == 10 then return { "INVTYPE_HAND" } end
  if slotID == 11 or slotID == 12 then return { "INVTYPE_FINGER" } end
  if slotID == 13 or slotID == 14 then return { "INVTYPE_TRINKET" } end
  if slotID == 15 then return { "INVTYPE_CLOAK" } end
  if slotID == 16 then return { "INVTYPE_WEAPON", "INVTYPE_WEAPONMAINHAND", "INVTYPE_2HWEAPON" } end
  if slotID == 17 then return { "INVTYPE_WEAPONOFFHAND", "INVTYPE_SHIELD", "INVTYPE_HOLDABLE", "INVTYPE_WEAPON" } end
  if slotID == 18 then return { "INVTYPE_RANGED", "INVTYPE_RANGEDRIGHT", "INVTYPE_THROWN", "INVTYPE_RELIC" } end
  if slotID == 19 then return { "INVTYPE_TABARD" } end
  return nil
end


local qrHoverTracker

local function EnsureHoverTracker()
  if qrHoverTracker then return end

  qrHoverTracker = CreateFrame("Frame", nil, UIParent)
  qrHoverTracker:Hide()
  qrHoverTracker:SetFrameStrata("BACKGROUND")
  qrHoverTracker:SetAllPoints(UIParent)

  qrHoverTracker.lastBtn = nil

  qrHoverTracker:SetScript("OnUpdate", function(self)
    -- Only active for our pick menu
local anyShown = false
for level = 1, 5 do
  local lf = _G["DropDownList" .. level]
  if lf and lf:IsShown() then
    anyShown = true
    break
  end
end

if UIDROPDOWNMENU_OPEN_MENU ~= slotPickMenuFrame or not anyShown then
  if self.lastBtn then
    GameTooltip:Hide()
    self.lastBtn = nil
  end
  self:Hide()
  return
end

    -- Find which dropdown button is under the mouse
local hovered = nil

for level = 1, 5 do
  local lf = _G["DropDownList" .. level]
  if lf and lf:IsShown() then
    for i = 1, (lf.numButtons or 0) do
      local btn = _G["DropDownList" .. level .. "Button" .. i]
      if btn and btn:IsShown() then
        -- Prefer checking the text region (this is where your cursor actually is)
        local name = btn:GetName()
        local txt = name and _G[name .. "NormalText"] or nil

        local over = false
        if txt and txt.IsMouseOver and txt:IsMouseOver() then
          over = true
        elseif btn.IsMouseOver and btn:IsMouseOver() then
          over = true
        end

        if over then
          hovered = btn
          break
        end
      end
    end
  end
  if hovered then break end
end

    if hovered ~= self.lastBtn then
      -- Changed hovered row
      GameTooltip:Hide()
      self.lastBtn = hovered

      if hovered then
        local name = hovered:GetName()
        local txt = name and _G[name .. "NormalText"] or nil
        local link = txt and txt:GetText() or nil

        if link and link:find("|Hitem:") then
          GameTooltip:SetOwner(hovered, "ANCHOR_RIGHT")
          GameTooltip:ClearLines()

          GameTooltip:SetHyperlink(link)
          if GameTooltip:NumLines() == 0 then
            local raw = link:match("|H([^|]+)|h") or link
            GameTooltip:SetHyperlink(raw)
          end

          GameTooltip:Show()
        end
      end
      end
  end)
end
EnsureHoverTracker()
_G.QuickRack_qrHoverTracker = qrHoverTracker

local function OwnedItemsForSlot(slotID, maxItems)
  maxItems = maxItems or 60
  local want = GetEquipLocForSlot(slotID)
  if not want then return {} end

  local wantSet = {}
  for _, loc in ipairs(want) do wantSet[loc] = true end

  local results = {}
  local seen = {} -- key -> true (dedupe by instance: inv slot or bag slot)

  local function AddItem(key, link)
    if not key or not link then return end
    if seen[key] then return end

    local equipLoc = select(4, GetItemInfoInstant(link))
    if not equipLoc or not wantSet[equipLoc] then return end

    local itemID = tonumber(string.match(link, "item:(%d+)")) or 0
    seen[key] = true
    table.insert(results, { key = key, itemID = itemID, link = link })
  end

  -- Which equipped slots to include for this chooser
  local equippedSlots
  if slotID == 11 or slotID == 12 then
    equippedSlots = {11, 12}
  elseif slotID == 13 or slotID == 14 then
    equippedSlots = {13, 14}
  elseif slotID == 16 or slotID == 17 then
    equippedSlots = {16, 17}
  else
    equippedSlots = {slotID}
  end

  -- 1) Equipped items
  for _, invSlot in ipairs(equippedSlots) do
    local link = GetInventoryItemLink("player", invSlot)
    if link then
      AddItem("inv:" .. tostring(invSlot), link)
    end
  end

  -- 2) Bag items (0..4), include each bag instance (bag:slot)
  for bag = 0, 4 do
    local slots = (C_Container and C_Container.GetContainerNumSlots and C_Container.GetContainerNumSlots(bag))
               or (GetContainerNumSlots and GetContainerNumSlots(bag))
               or 0

    for i = 1, (slots or 0) do
      local link = (C_Container and C_Container.GetContainerItemLink and C_Container.GetContainerItemLink(bag, i))
                or (GetContainerItemLink and GetContainerItemLink(bag, i))

      if link then
        AddItem("bag:" .. bag .. ":" .. i, link)
        if #results >= maxItems then
          return results
        end
      end
    end
  end

  return results
end

-- =========================
-- Editor Item Strip (like paperdoll/pinbar, but updates the draft gearset ONLY)
-- =========================

local EDITOR_STRIP_MAX_SHOW = 14
local EDITOR_STRIP_ICON_SIZE = 36
local EDITOR_STRIP_PADDING = 4

local editorStrip
local editorStripCloseInstalled = false

-- Forward declarations so earlier code doesn't bind to globals
local HideCompareTooltips
local ShowDraftCompareTooltip
local GetDraftLinkForSlot

local function QR_GetMouseFocus()
  if _G.GetMouseFocus then
    return _G.GetMouseFocus()
  end
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

local function EditorStripIsHot()
  return editorStrip and editorStrip:IsShown() and (editorStrip.hovering or editorStrip.slotHovering)
end

local function EditorStripScheduleHide(delay)
  if not editorStrip then return end
  editorStrip.hideToken = (editorStrip.hideToken or 0) + 1
  local token = editorStrip.hideToken
  C_Timer.After(delay or 0.20, function()
    if not editorStrip then return end
    if token == editorStrip.hideToken and editorStrip:IsShown() and not EditorStripIsHot() then
      editorStrip:Hide()
    end
  end)
end

-- Draft/gearset compare tooltip (Shift) for editor strip:
-- Show the CURRENT DRAFT item for the target slot instead of the equipped item.
GetDraftLinkForSlot = function(slotID)
  if not slotID or not draftSlots then return nil end

  local v = draftSlots[SlotKey(slotID)]
  if not v or v == false then return nil end

  -- If the draft explicitly means "currently equipped"
  if v == CURRENT_VALUE then
    return GetInventoryItemLink("player", slotID)
  end

  -- If draft stores an itemID
  if type(v) == "number" then
    local link = select(2, GetItemInfo(v))
    return link
  end

  -- If draft stores a hyperlink already
  if type(v) == "string" then
    if v:find("|Hitem:") then
      return v
    end
    -- If it's an itemString like "item:123:..."
    local link = select(2, GetItemInfo(v))
    return link
  end

  return nil
end

local function EnsureEditorStrip()
  if editorStrip then return editorStrip end

  editorStrip = CreateFrame("Frame", "QuickRackEditorItemStrip", UIParent, "BackdropTemplate")
  editorStrip.hovering = false
  editorStrip.slotHovering = false
  editorStrip.hideToken = 0
  editorStrip:SetFrameStrata("TOOLTIP")
  editorStrip:SetFrameLevel(2000)
  editorStrip:EnableMouse(true)
  editorStrip:SetClampedToScreen(true)
  editorStrip:Hide()

  editorStrip:SetBackdrop({
    bgFile   = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left=4, right=4, top=4, bottom=4 }
  })
  editorStrip:SetBackdropColor(0, 0, 0, 0.85)

  editorStrip.buttons = {}
  editorStrip.items = {}

  editorStrip:SetScript("OnEnter", function()
    editorStrip.hovering = true
  end)

  editorStrip:SetScript("OnLeave", function()
    editorStrip.hovering = false
    EditorStripScheduleHide(0.25)
  end)

  -- Keep tooltip compare behavior consistent with other strips
  editorStrip:RegisterEvent("MODIFIER_STATE_CHANGED")
  editorStrip:SetScript("OnEvent", function(_, event, key)
    if event ~= "MODIFIER_STATE_CHANGED" then return end
    if key ~= "LSHIFT" and key ~= "RSHIFT" then return end
    if editorStrip.hoveredButton and editorStrip.hoveredButton:IsShown() and editorStrip.hoveredButton:IsMouseOver() then
      local btn = editorStrip.hoveredButton
      GameTooltip:SetOwner(btn, "ANCHOR_RIGHT")
      if btn.link then
        GameTooltip:SetHyperlink(btn.link)
      end
      GameTooltip:Show()
      ShowDraftCompareTooltip(editorStrip.targetSlotID)
    end
  end)

  return editorStrip
end

-- =========================
-- Editor itemstrip rarity glow
-- =========================
local function CreateEditorStripRarityGlow(btn)
  local glow = btn:CreateTexture(nil, "OVERLAY")
  glow:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
  glow:SetBlendMode("ADD")
  glow:SetAlpha(0.65)
  glow:SetPoint("TOPLEFT", -14, 14)
  glow:SetPoint("BOTTOMRIGHT", 14, -14)
  glow:Hide()
  return glow
end

local function UpdateEditorStripRarityGlow(btn, itemLink)
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

local function EditorStrip_Clear()
  if not editorStrip then return end
  for _, b in ipairs(editorStrip.buttons) do
    b:Hide()
    if b.rarityGlow then b.rarityGlow:Hide() end
    b.link = nil
    b.key = nil
  end
  wipe(editorStrip.items)
end

HideCompareTooltips = function()
  if _G.ShoppingTooltip1 then _G.ShoppingTooltip1:Hide() end
  if _G.ShoppingTooltip2 then _G.ShoppingTooltip2:Hide() end
  if _G.ShoppingTooltip3 then _G.ShoppingTooltip3:Hide() end
end

ShowDraftCompareTooltip = function(slotID)
  if not IsShiftKeyDown() then
    HideCompareTooltips()
    return
  end

  local link = GetDraftLinkForSlot(slotID)
  if not link or not _G.ShoppingTooltip1 then
    HideCompareTooltips()
    return
  end

  local st = _G.ShoppingTooltip1
  st:SetOwner(GameTooltip, "ANCHOR_NONE")
  st:ClearAllPoints()
  st:SetPoint("TOPLEFT", GameTooltip, "TOPRIGHT", 0, -10)
  st:SetHyperlink(link)
  st:Show()

  -- Ensure we don't show extra compare tooltips from other systems
  if _G.ShoppingTooltip2 then _G.ShoppingTooltip2:Hide() end
  if _G.ShoppingTooltip3 then _G.ShoppingTooltip3:Hide() end
end

local function EditorStrip_Layout(count)
  local w = EDITOR_STRIP_PADDING + count * (EDITOR_STRIP_ICON_SIZE + EDITOR_STRIP_PADDING)
  local h = EDITOR_STRIP_ICON_SIZE + EDITOR_STRIP_PADDING * 2
  editorStrip:SetSize(w, h)

  for i = 1, count do
    local b = editorStrip.buttons[i]
    if not b then
      b = CreateFrame("Button", nil, editorStrip)
      b:SetSize(EDITOR_STRIP_ICON_SIZE, EDITOR_STRIP_ICON_SIZE)

      b.icon = b:CreateTexture(nil, "ARTWORK")
      b.icon:SetAllPoints()
      b.rarityGlow = CreateEditorStripRarityGlow(b)
      b:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")

      b:SetScript("OnEnter", function(self)
        editorStrip.hovering = true
        editorStrip.hoveredButton = self

        if not self.link then return end
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetHyperlink(self.link)
        GameTooltip:Show()
        ShowDraftCompareTooltip(editorStrip.targetSlotID)
      end)

      b:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
        if editorStrip.hoveredButton == self then
          editorStrip.hoveredButton = nil
        end
        editorStrip.hovering = false
        EditorStripScheduleHide(0.25)
      end)

      b:SetScript("OnClick", function(self)
        if not self.link then return end
        if not draftSlots then draftSlots = {} end

        local slotID = editorStrip.targetSlotID
        if not slotID then return end

        -- Update draft ONLY (do not equip)
        draftSlots[SlotKey(slotID)] = self.link
        RefreshButton(slotID)

        -- Keep the strip open and refresh its content based on the new draft
          -- Close strip after selecting
          HideCompareTooltips()
          GameTooltip:Hide()
          editorStrip.hovering = false
          editorStrip.slotHovering = false
          editorStrip:Hide()
      end)

      editorStrip.buttons[i] = b
    end

    b:ClearAllPoints()
    b:SetPoint("LEFT", editorStrip, "LEFT", EDITOR_STRIP_PADDING + (i - 1) * (EDITOR_STRIP_ICON_SIZE + EDITOR_STRIP_PADDING), 0)
  end
end

local function EditorStrip_InstallGlobalClose()
  if editorStripCloseInstalled then return end
  editorStripCloseInstalled = true

  if not QuickRackEditor.__globalMouseCloseFrame then
    local gm = CreateFrame("Frame")
    QuickRackEditor.__globalMouseCloseFrame = gm
    gm:RegisterEvent("GLOBAL_MOUSE_DOWN")
    gm:SetScript("OnEvent", function(_, _, mouseButton)
      if not editorStrip or not editorStrip:IsShown() then return end

      local focus = QR_GetMouseFocus()

      if focus and IsDescendantOf(focus, editorStrip) then
        return
      end

      local anchor = editorStrip._anchorButton
      if anchor and focus and IsDescendantOf(focus, anchor) then
        return
      end

      editorStrip.hovering = false
      editorStrip.slotHovering = false
      editorStrip:Hide()
    end)
  end
end

local function BuildUsedCountFromDraft(draft)
  local usedCount = {}
  if type(draft) ~= "table" then return usedCount end
  for _, raw in pairs(draft) do
    if raw ~= nil and raw ~= false and raw ~= 0 and raw ~= "0" then
      local s = NormalizeItemString(raw)
      if s then
        usedCount[s] = (usedCount[s] or 0) + 1
      end
    end
  end
  return usedCount
end

local function GetStripItemsForSlot(slotID, maxItems)
  local items = OwnedItemsForSlot(slotID, maxItems or 60)
  if not items or #items == 0 then return {} end

  -- Hide items already assigned in the draft (including THIS slot),
  -- but only hide as many copies as are used.
  local usedCount = BuildUsedCountFromDraft(draftSlots)
  local remaining = {}
  for k2, v2 in pairs(usedCount) do remaining[k2] = v2 end

  local out = {}
  for _, it in ipairs(items) do
    local itemString = NormalizeItemString(it.link)
    if itemString and remaining[itemString] and remaining[itemString] > 0 then
      remaining[itemString] = remaining[itemString] - 1
    else
      table.insert(out, it)
    end
  end

  return out
end

function QuickRackEditor.ShowItemStripForSlot(anchorButton, slotID)
  slotID = tonumber(slotID)
  if not anchorButton or not slotID then return end

  EnsureEditorStrip()
  EditorStrip_Clear()

  editorStrip.targetSlotID = slotID
  editorStrip._anchorButton = anchorButton

  local items = GetStripItemsForSlot(slotID, 60)
  local count = math.min(#items, EDITOR_STRIP_MAX_SHOW)
  if count <= 0 then
    editorStrip:Hide()
    return
  end

  EditorStrip_Layout(count)

  for i = 1, count do
    local entry = items[i]
    local link = entry.link
    local tex = select(10, GetItemInfo(link))
    local b = editorStrip.buttons[i]
    b.link = link
    b.icon:SetTexture(tex)
    UpdateEditorStripRarityGlow(b, link)
    b:Show()
  end

  for i = count + 1, #editorStrip.buttons do
    editorStrip.buttons[i]:Hide()
  end

  editorStrip:ClearAllPoints()

  -- Keep weapons below so we don't cover neighbor slots
  local isWeaponSlot = (slotID == 16) or (slotID == 17) or (slotID == 18)
  if isWeaponSlot then
    editorStrip:SetPoint("TOPLEFT", anchorButton, "BOTTOMLEFT", 0, -6)
  else
    editorStrip:SetPoint("TOPLEFT", anchorButton, "TOPRIGHT", 6, 2)
  end

  EditorStrip_InstallGlobalClose()
  editorStrip:Show()

  -- Clamp horizontally
  if editorStrip:GetRight() and editorStrip:GetRight() > UIParent:GetRight() - 10 then
    editorStrip:ClearAllPoints()
    if isWeaponSlot then
      editorStrip:SetPoint("TOPRIGHT", anchorButton, "BOTTOMRIGHT", 0, -6)
    else
      editorStrip:SetPoint("TOPRIGHT", anchorButton, "TOPLEFT", -6, 2)
    end
  end

  -- Clamp vertically
  if editorStrip:GetBottom() and editorStrip:GetBottom() < UIParent:GetBottom() + 10 then
    editorStrip:ClearAllPoints()
    if isWeaponSlot then
      editorStrip:SetPoint("BOTTOMLEFT", anchorButton, "TOPLEFT", 0, 6)
    else
      editorStrip:SetPoint("BOTTOMLEFT", anchorButton, "TOPRIGHT", 6, -2)
    end
  end
end

local function AddItemTooltipToButton(level, buttonIndex, itemLink)
  local btn = _G["DropDownList" .. level .. "Button" .. buttonIndex]
  if not btn then return end

  -- Store on button for debugging/inspection
  btn.qrItemLink = itemLink

  -- Hook the text region (this is what gets mouseover in your client)
  local name = btn:GetName()
  local textRegion = name and _G[name .. "NormalText"] or nil
  if not textRegion then
    textRegion = btn:GetFontString()
  end
  if not textRegion then return end

  -- Store on the region (this is what the handlers read)
  textRegion.qrItemLink = itemLink

  if not textRegion.qrTooltipHooked then
    -- IMPORTANT: do NOT EnableMouse(true) here, it steals clicks.
    -- We only attach handlers; the region already participates in mouseover.

    textRegion:HookScript("OnEnter", function(self)
      local link = self.qrItemLink
      if not link or not link:find("|Hitem:") then return end

      -- Anchor away from cursor so it doesn’t cover the row you’re trying to click
      GameTooltip:SetOwner(btn, "ANCHOR_RIGHT")
      GameTooltip:ClearLines()

      GameTooltip:SetHyperlink(link)
      if GameTooltip:NumLines() == 0 then
        local raw = link:match("|H([^|]+)|h") or link
        GameTooltip:SetHyperlink(raw)
      end

      GameTooltip:Show()
    end)

    textRegion:HookScript("OnLeave", function()
      GameTooltip:Hide()
    end)

    textRegion.qrTooltipHooked = true
  end
end

local function ReopenPickMenu()
  if not currentPickAnchorButton or not currentPickSlotID then return end
  CloseDropDownMenus()

  if C_Timer and C_Timer.After then
    C_Timer.After(0, function()
      ShowPickMenu(currentPickAnchorButton, currentPickSlotID)
    end)
  else
    ShowPickMenu(currentPickAnchorButton, currentPickSlotID)
  end
end

local function GetDropDownButtonText(btn)
  if not btn then return nil end

  -- 1) Some clients support GetText()
  local t = btn.GetText and btn:GetText()
  if t and t ~= "" then return t end

  -- 2) Standard UIDropDownMenu text region
  local name = btn.GetName and btn:GetName()
  if name then
    local fs = _G[name .. "NormalText"]
    if fs and fs.GetText then
      t = fs:GetText()
      if t and t ~= "" then return t end
    end
  end

  -- 3) Fallback: fontstring
  local fs = btn.GetFontString and btn:GetFontString()
  if fs and fs.GetText then
    t = fs:GetText()
    if t and t ~= "" then return t end
  end

  return nil
end

local function BindPickMenuTooltips()
  if UIDROPDOWNMENU_OPEN_MENU ~= slotPickMenuFrame then
    qrBindRetries = (qrBindRetries or 0) + 1
    if qrBindRetries <= 5 and C_Timer and C_Timer.After then
      C_Timer.After(0, BindPickMenuTooltips)
    end
    return
  end
  qrBindRetries = 0

  -- EnsureHoverTracker()

  for level = 1, 5 do
    local listFrame = _G["DropDownList" .. level]
    if listFrame and listFrame:IsShown() then
      local num = listFrame.numButtons or 0
      for i = 1, num do
        local btn = _G["DropDownList" .. level .. "Button" .. i]
        if btn then
          local text = GetDropDownButtonText(btn)
          if text and text:find("|Hitem:") then
            btn.qrItemLink = text
          else
            btn.qrItemLink = nil
          end
        end
      end
    end
  end

  -- enable hover tracking after assigning links
  if qrHoverTracker then qrHoverTracker:Show() end

end

-- =========================
-- Item rarity glow helpers
-- =========================
local function CreateRarityGlow(btn)
  local glow = btn:CreateTexture(nil, "OVERLAY")
  glow:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
  glow:SetBlendMode("ADD")
  glow:SetAlpha(0.85)
  glow:SetPoint("TOPLEFT", -14, 14)
  glow:SetPoint("BOTTOMRIGHT", 14, -14)
  glow:Hide()
  return glow
end

local function UpdateRarityGlow(btn, val)
  if not btn.rarityGlow then return end

-- Hide for empty / cleared / ignored
if not val or val == 0 or val == "0" or val == false then
  btn.rarityGlow:Hide()
  return
end

  local quality
  if type(val) == "number" then
    quality = select(3, GetItemInfo(val))
  elseif type(val) == "string" then
    quality = select(3, GetItemInfo(val))
  end

  if not quality or quality <= 1 then
    btn.rarityGlow:Hide()
    return
  end

  local r, g, b = GetItemQualityColor(quality)
  btn.rarityGlow:SetVertexColor(r, g, b)
  btn.rarityGlow:Show()
end

local function RefreshAllButtons()
  for slotID, _ in pairs(buttonsBySlotID) do
    RefreshButton(slotID)
  end
end

-- Build a set of "used items" already assigned in the current draft gearset,
-- excluding the slot we're currently editing.
local function BuildUsedItemsFromDraft(draft, excludeKey)
  local used = {}
  if type(draft) ~= "table" then return used end

  local exclude = tostring(excludeKey)

  for k, raw in pairs(draft) do
    if tostring(k) ~= exclude then
      -- meanings in your code:
      -- false => ignore
      -- nil   => empty/unspecified
      -- 0/"0" => explicitly empty
      if raw ~= nil and raw ~= false and raw ~= 0 and raw ~= "0" then
        local itemString = NormalizeItemString(raw)
        if itemString then
          used[itemString] = true
        else
          local n = tonumber(raw)
          if n and n > 0 then
            used["id:" .. n] = true
          end
        end
      end
    end
  end

  return used
end

ShowPickMenu = function(anchorButton, slotID)
  -- Toggle: if the menu is already open for this same slot, close it.
  slotID = tonumber(slotID)
  local k = SlotKey(slotID)

  if UIDROPDOWNMENU_OPEN_MENU == slotPickMenuFrame
     and currentPickSlotID == slotID
     and DropDownList1
     and DropDownList1:IsShown()
  then
    CloseDropDownMenus()
    return
  end

  currentPickAnchorButton = anchorButton
  currentPickSlotID = slotID
  ClearAllDropdownItemTooltips()

  if not slotPickMenuFrame then
    slotPickMenuFrame = CreateFrame("Frame", "QuickRackEditorPickMenu", UIParent, "UIDropDownMenuTemplate")
    slotPickMenuFrame:Hide()
    slotPickMenuFrame:ClearAllPoints()
    slotPickMenuFrame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", -2000, -2000) -- park offscreen
  end

  local items = OwnedItemsForSlot(slotID, 60)
  -- Count how many copies of each exact itemString are already used in this gearset
-- (including THIS slot too, so the chooser won't show its currently selected item).
local usedCount = {}

for slotKey, raw in pairs(draftSlots or {}) do
  if raw ~= nil and raw ~= false and raw ~= 0 and raw ~= "0" then
    local s = NormalizeItemString(raw)
    if s then
      usedCount[s] = (usedCount[s] or 0) + 1
    end
  end
end
  local used = BuildUsedItemsFromDraft(draftSlots, k)

  UIDropDownMenu_Initialize(slotPickMenuFrame, function(self, level)
    level = level or 1
    if level ~= 1 then return end

    local info

    -- Title
    info = UIDropDownMenu_CreateInfo()
    info.isTitle = true
    info.text = "Choose item"
    info.notCheckable = true
    UIDropDownMenu_AddButton(info, level)



    if #items == 0 then
      info = UIDropDownMenu_CreateInfo()
      info.text = "No matching items in bags"
      info.notCheckable = true
      info.disabled = true
      UIDropDownMenu_AddButton(info, level)

	  
	    -- Cancel (even when empty)
	  info = UIDropDownMenu_CreateInfo()
	  info.text = "Cancel"
	  info.notCheckable = true
	  info.func = function()
		CloseDropDownMenus()
	  end
	  UIDropDownMenu_AddButton(info, level)

      return
    end

    -- Item entries (with tooltip on hover)
-- Item entries (with tooltip on hover)
-- We'll copy usedCount so we can "consume" it while iterating items
local remaining = {}
for k2, v2 in pairs(usedCount) do remaining[k2] = v2 end

for _, it in ipairs(items) do
  local itemID = it.itemID
  local link = it.link
  local itemString = NormalizeItemString(link)

  -- If this exact itemString is already used in the set N times,
  -- hide exactly N instances from the chooser (leaving extra copies visible).
  if itemString and remaining[itemString] and remaining[itemString] > 0 then
    remaining[itemString] = remaining[itemString] - 1
  else
    info = UIDropDownMenu_CreateInfo()
    info.text = link
    info.notCheckable = true
    info.func = function()
      -- Store the full link (keeps enchants/variants)
      draftSlots[k] = link or itemID
      RefreshButton(slotID)
      CloseDropDownMenus()
    end
    UIDropDownMenu_AddButton(info, level)

    -- keep your existing tooltip capture logic as-is below
    local listFrame = _G["DropDownList" .. level]
    local idx = listFrame and listFrame.numButtons
    if idx then
      local thisLevel = level
      local thisIdx = idx
      local thisLink = link
      -- your existing tooltip hook remains unchanged
    end
  end
end

    -- Spacer
    info = UIDropDownMenu_CreateInfo()
    info.text = " "
    info.notCheckable = true
    info.disabled = true
    UIDropDownMenu_AddButton(info, level)

	
    -- Ignore toggle
    local ignored = (draftSlots[k] == false)
    info = UIDropDownMenu_CreateInfo()
    info.text = ignored and "Unignore slot" or "Ignore slot"
    info.notCheckable = true
    info.func = function()
      if draftSlots[k] == false then
        -- Unignore => default to "clear/empty" (unequip)
        draftSlots[k] = 0
      else
        -- Ignore => do not touch this slot on equip
        draftSlots[k] = false
      end
      RefreshButton(slotID)
      CloseDropDownMenus()
    end
    UIDropDownMenu_AddButton(info, level)

	
		    -- Clear slot
    info = UIDropDownMenu_CreateInfo()
    info.text = "Clear slot"
    info.notCheckable = true
	info.func = function()
	  -- Clear assignment for this slot (not "ignore")
	  draftSlots[k] = 0
	  RefreshButton(slotID)
	  CloseDropDownMenus()
	end
    UIDropDownMenu_AddButton(info, level)

	
	info = UIDropDownMenu_CreateInfo()
	info.text = "Cancel"
	info.notCheckable = true
	info.func = function()
  CloseDropDownMenus()
end
UIDropDownMenu_AddButton(info, level)
  end, "MENU")

QuickRackEditor._openingDropdown = true
ToggleDropDownMenu(1, nil, slotPickMenuFrame, anchorButton, 0, 0)

-- Close the pick menu if user clicks anywhere else
EnsurePickMenuClickCatcher()
pickMenuClickCatcher:Show()

if C_Timer and C_Timer.After then
  C_Timer.After(0, function()
    QuickRackEditor._openingDropdown = false
    BindPickMenuTooltips()
  end)
else
  QuickRackEditor._openingDropdown = false
  BindPickMenuTooltips()
end
end

-- Popup: Save As (new name)
StaticPopupDialogs["QUICKRACK_EDITOR_SAVEAS"] = {
  text = "Save gearset as:",
  button1 = "Save",
  button2 = "Cancel",
  hasEditBox = true,
  timeout = 0,
  whileDead = true,
  hideOnEscape = true,
  preferredIndex = 3,

  OnShow = function(self)
    self.EditBox:SetText("")
	self.EditBox:SetFocus()
  end,

  OnAccept = function(self)
    local name = self.EditBox:GetText()
    if name and name:gsub("%s+", "") ~= "" then
      QuickRackEditor.SaveAs(name)
    end
  end,

EditBoxOnEnterPressed = function(editBox)
  local parent = editBox:GetParent()
  local name = editBox:GetText()
  if name and name:gsub("%s+", "") ~= "" then
    QuickRackEditor.SaveAs(name)
  end
  parent:Hide()
end,
}

local function CopyTableShallow(src)
  local t = {}
  for k,v in pairs(src or {}) do t[k] = v end
  return t
end

local function GetItemIcon(itemID)
  if not itemID then return nil end
  local icon = select(10, GetItemInfo(itemID))
  return icon
end

local function SetButtonIgnoredVisual(btn, ignored)
	if ignored then
	  if btn.ignoreShade   then btn.ignoreShade:Show()   end
	  if btn.ignoredX      then btn.ignoredX:Show()      end
	  if btn.ignoreBorder  then btn.ignoreBorder:Show()  end
	else
	  if btn.ignoreShade   then btn.ignoreShade:Hide()   end
	  if btn.ignoredX      then btn.ignoredX:Hide()      end
	  if btn.ignoreBorder  then btn.ignoreBorder:Hide()  end
	end
end

RefreshButton = function(slotID)
  slotID = tonumber(slotID)
  local btn = buttonsBySlotID[slotID]
  if not btn then return end
  -- Reset rarity glow every refresh
  if btn.rarityGlow then btn.rarityGlow:Hide() end

  -- Update editor pin button text based on pinned state
if btn.pinBtn then
  local pinned = false
  if QuickRackPinBar and QuickRackPinBar.IsPinned then
    pinned = QuickRackPinBar.IsPinned(slotID)
  elseif QuickRack_IsPinned then
    pinned = QuickRack_IsPinned(slotID)
  elseif QuickRackDB and QuickRackDB.pins then
    pinned = QuickRackDB.pins[tostring(slotID)] and true or false
  end

  if pinned then
    btn.pinBtn:SetText("Unpin")
  else
    btn.pinBtn:SetText("Pin")
  end
end

  local k = SlotKey(slotID)
local val
if draftSlots then
  val = draftSlots[k]  -- this preserves false correctly
else
  val = nil
end

  -- Always start by hiding ignore visuals (prevents "stuck" overlays)
  SetButtonIgnoredVisual(btn, false)

  -- Ignored slot
  if val == false then
    btn.icon:SetTexture(btn.defaultTexture)
    if btn.icon.SetDesaturated then btn.icon:SetDesaturated(true) end
    btn.icon:SetVertexColor(0.6, 0.6, 0.6, 1)
    SetButtonIgnoredVisual(btn, true)
    btn.itemID = nil
    if btn.rarityGlow then btn.rarityGlow:Hide() end
    return
  end

  -- Normal visuals
  if btn.icon.SetDesaturated then btn.icon:SetDesaturated(false) end
  btn.icon:SetVertexColor(1, 1, 1, 1)

  -- val can be:
  -- number: itemID
  -- string: itemLink
  -- 0 / nil: empty slot
    if val == "0" then
    val = 0
  end
  -- Treat 0 as "cleared/empty" (do NOT query item info/icon for itemID 0)
  if val == 0 then
    btn.icon:SetTexture(btn.defaultTexture)
    btn.itemID = nil
    if btn.rarityGlow then btn.rarityGlow:Hide() end
    return
  end

  if type(val) == "number" then
      -- Backward compat: some saved sets may store cleared as string "0"
  if val == "0" then
    val = 0
  end

  -- Treat 0 as cleared/empty (never query item info for 0)
  if val == 0 then
    btn.icon:SetTexture(btn.defaultTexture)
    btn.itemID = nil
    if btn.rarityGlow then btn.rarityGlow:Hide() end
    return
  end
    local icon = GetItemIcon(val)
    btn.icon:SetTexture(icon or btn.defaultTexture)
    btn.itemID = val
    UpdateRarityGlow(btn, val)
    return
  end

  if type(val) == "string" then
    local itemID = tonumber(val:match("item:(%d+)"))
    local icon = itemID and GetItemIcon(itemID) or nil
    btn.icon:SetTexture(icon or btn.defaultTexture)
    btn.itemID = itemID
    UpdateRarityGlow(btn, val)
    return
  end

  -- empty / cleared
  btn.icon:SetTexture(btn.defaultTexture)
  btn.itemID = nil
end

local function LoadEquippedToDraft()
  EnsureDB()
  currentSetName = CURRENT_VALUE
  draftSlots = {}

  -- Prefer core snapshot (string keys + links), else fall back to direct inventory reads.
  if QuickRack_GetEquippedSlotsForEditor then
    local slots = QuickRack_GetEquippedSlotsForEditor()
    for k, v in pairs(slots or {}) do
      draftSlots[tostring(k)] = v
    end
  else
    for slotID = 1, 19 do
      local link = GetInventoryItemLink("player", slotID)
      draftSlots[tostring(slotID)] = link or 0
    end
  end

  RefreshAllButtons()
  RefreshTriggerDropdown()
  RefreshBindLabel()
end

LoadSetToDraft = function(name)
  EnsureDB()
  currentSetName = name
  local db = GetDB()
  local set = name and db.sets[name] or nil
	draftSlots = {}
	if set and set.slots then
	  for key, v in pairs(set.slots) do
		draftSlots[tostring(key)] = v
	  end
	end
  RefreshAllButtons()
  RefreshTriggerDropdown()
  RefreshBindLabel()
end

Dropdown_Initialize = function(self, level)
  EnsureDB()
  level = level or 1
  if level ~= 1 then return end

  local active = nil
  if QuickRack_GetActiveSetName then
    active = QuickRack_GetActiveSetName()
  end

  local info = UIDropDownMenu_CreateInfo()
  info.isTitle = true
  info.text = "Select gearset"
  info.notCheckable = true
  UIDropDownMenu_AddButton(info, level)

  -- "Currently Equipped" (matches no saved set, but reflects what you're wearing right now)
if not active then
  info = UIDropDownMenu_CreateInfo()
  info.text = CURRENT_LABEL
  info.value = CURRENT_VALUE
  info.notCheckable = false
  info.checked = (currentSetName == CURRENT_VALUE)
  info.func = function()
    UIDropDownMenu_SetSelectedValue(dropdown, CURRENT_VALUE)
    UIDropDownMenu_SetText(dropdown, CURRENT_LABEL)
    LoadEquippedToDraft()
  end
  UIDropDownMenu_AddButton(info, level)
end

  local names = {}

  local db = GetDB()
  for name, _ in pairs(db.sets) do
    table.insert(names, name)
  end
  table.sort(names)

  if #names == 0 then
    info = UIDropDownMenu_CreateInfo()
    info.text = "No sets saved"
    info.notCheckable = true
    info.disabled = true
    UIDropDownMenu_AddButton(info, level)
    return
  end

  for _, name in ipairs(names) do
    local setName = name
    info = UIDropDownMenu_CreateInfo()
	info.text = setName
	info.value = setName
	info.notCheckable = false
	info.checked = (currentSetName == setName)
	info.func = function()
	  UIDropDownMenu_SetSelectedValue(dropdown, setName)
	  UIDropDownMenu_SetText(dropdown, setName)
    local db = GetDB()
    db.editor.lastSetName = setName
	  LoadSetToDraft(setName)
	end
	UIDropDownMenu_AddButton(info, level)
  end
end

RefreshTriggerDropdown = function()
  if not triggerDropdown then return end
  EnsureDB()

  local val = "none"
  local txt = "None"

  if currentSetName and currentSetName ~= "" and currentSetName ~= CURRENT_VALUE then
    local trigMount = QuickRack_GetTrigger and QuickRack_GetTrigger("mount") or QuickRackDB.mountSetName
    local trigSpec1 = QuickRack_GetTrigger and QuickRack_GetTrigger("spec1") or nil
    local trigSpec2 = QuickRack_GetTrigger and QuickRack_GetTrigger("spec2") or nil

    if trigMount == currentSetName then
      val = "mount"; txt = "Mounting"
    elseif trigSpec1 == currentSetName then
      val = "spec1"; txt = "Primary talents"
    elseif trigSpec2 == currentSetName then
      val = "spec2"; txt = "Secondary talents"
    end
  end

  UIDropDownMenu_SetSelectedValue(triggerDropdown, val)
  UIDropDownMenu_SetText(triggerDropdown, txt)
end

TriggerDropdown_Initialize = function(self, level)
  level = level or 1
  if level ~= 1 then return end
  EnsureDB()

  if not currentSetName or currentSetName == "" or currentSetName == CURRENT_VALUE then
    local info = UIDropDownMenu_CreateInfo()
    info.text = "Select a saved gearset first"
    info.notCheckable = false
    info.disabled = true
    UIDropDownMenu_AddButton(info, level)
    return
  end

  local trigMount = QuickRack_GetTrigger and QuickRack_GetTrigger("mount") or QuickRackDB.mountSetName
  local trigSpec1 = QuickRack_GetTrigger and QuickRack_GetTrigger("spec1") or nil
  local trigSpec2 = QuickRack_GetTrigger and QuickRack_GetTrigger("spec2") or nil

  local function ThisSetHasAnyTrigger()
    return (trigMount == currentSetName) or (trigSpec1 == currentSetName) or (trigSpec2 == currentSetName)
  end

  local function ClearAnyTriggerForThisSet()
    if trigMount == currentSetName then
      if QuickRack_SetTrigger then QuickRack_SetTrigger("mount", nil) else QuickRack_ClearMountSet() end
    end
    if trigSpec1 == currentSetName and QuickRack_SetTrigger then QuickRack_SetTrigger("spec1", nil) end
    if trigSpec2 == currentSetName and QuickRack_SetTrigger then QuickRack_SetTrigger("spec2", nil) end
  end

  -- None (unbind if this set currently owns any trigger)
  local info = UIDropDownMenu_CreateInfo()
  info.text = "None"
  info.value = "none"
  info.notCheckable = false
  info.checked = (not ThisSetHasAnyTrigger())
  info.func = function()
    ClearAnyTriggerForThisSet()
    UIDropDownMenu_SetSelectedValue(triggerDropdown, "none")
    UIDropDownMenu_SetText(triggerDropdown, "None")
    RefreshTriggerDropdown()
    CloseDropDownMenus()
  end
  UIDropDownMenu_AddButton(info, level)

-- Mounting (bind)
info = UIDropDownMenu_CreateInfo()
info.text = "Mounting"
info.value = "mount"
info.notCheckable = false
info.checked = (trigMount == currentSetName)
info.func = function()
  -- Enforce: only ONE trigger per gearset
  ClearAnyTriggerForThisSet()

  if QuickRack_SetTrigger then
    QuickRack_SetTrigger("mount", currentSetName)
  else
    QuickRack_SetMountSet(currentSetName)
  end
  UIDropDownMenu_SetSelectedValue(triggerDropdown, "mount")
  UIDropDownMenu_SetText(triggerDropdown, "Mounting")
  RefreshTriggerDropdown()
  CloseDropDownMenus()
end
UIDropDownMenu_AddButton(info, level)

  -- Primary talents (spec1)
  info = UIDropDownMenu_CreateInfo()
  info.text = "Primary talents"
  info.value = "spec1"
  info.notCheckable = false
  info.checked = (trigSpec1 == currentSetName)
info.func = function()
  -- Enforce: only ONE trigger per gearset
  ClearAnyTriggerForThisSet()

  if QuickRack_SetTrigger then
    QuickRack_SetTrigger("spec1", currentSetName)
  else
    Print("This trigger requires the newer trigger system (QuickRack_SetTrigger).")
  end
  UIDropDownMenu_SetSelectedValue(triggerDropdown, "spec1")
  UIDropDownMenu_SetText(triggerDropdown, "Primary talents")
  RefreshTriggerDropdown()
  CloseDropDownMenus()
end
  UIDropDownMenu_AddButton(info, level)

  -- Secondary talents (spec2)
  info = UIDropDownMenu_CreateInfo()
  info.text = "Secondary talents"
  info.value = "spec2"
  info.notCheckable = false
  info.checked = (trigSpec2 == currentSetName)
info.func = function()
  -- Enforce: only ONE trigger per gearset
  ClearAnyTriggerForThisSet()

  if QuickRack_SetTrigger then
    QuickRack_SetTrigger("spec2", currentSetName)
  else
    Print("This trigger requires the newer trigger system (QuickRack_SetTrigger).")
  end
  UIDropDownMenu_SetSelectedValue(triggerDropdown, "spec2")
  UIDropDownMenu_SetText(triggerDropdown, "Secondary talents")
  RefreshTriggerDropdown()
  CloseDropDownMenus()
end
  UIDropDownMenu_AddButton(info, level)
end

local function CreatePinCheckbox(parentBtn, slotID)
  local cb = CreateFrame("Button", nil, parentBtn)
  cb:SetSize(13, 13)
  cb:SetPoint("TOPLEFT", parentBtn, "TOPLEFT", 0, 0)
  cb:RegisterForClicks("LeftButtonUp")
  cb:EnableMouse(true)
  cb:SetFrameLevel(parentBtn:GetFrameLevel() + 10)

  -- Persistent border (always visible)
  cb.border = cb:CreateTexture(nil, "BORDER")
  cb.border:SetAllPoints()
  cb.border:SetColorTexture(1, 1, 1, 0.22) -- unchecked default

  -- Inner haze (very subtle, always present, slightly stronger when checked)
  cb.haze = cb:CreateTexture(nil, "ARTWORK")
  cb.haze:SetPoint("TOPLEFT", cb, "TOPLEFT", 1, -1)
  cb.haze:SetPoint("BOTTOMRIGHT", cb, "BOTTOMRIGHT", -1, 1)
  cb.haze:SetColorTexture(1, 1, 1, 0.06) -- unchecked default

  -- Soft fill (only when checked)
  cb.fill = cb:CreateTexture(nil, "ARTWORK")
  cb.fill:SetPoint("TOPLEFT", cb, "TOPLEFT", 2, -2)
  cb.fill:SetPoint("BOTTOMRIGHT", cb, "BOTTOMRIGHT", -2, 2)
  cb.fill:SetColorTexture(1, 1, 1, 0.14)
  cb.fill:Hide()

  -- Checkmark texture (better than font glyphs across clients)
  cb.check = cb:CreateTexture(nil, "OVERLAY")
  cb.check:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
  cb.check:SetPoint("CENTER", cb, "CENTER", 0, 0)
  cb.check:SetSize(14, 14)
  cb.check:SetVertexColor(1, 1, 1, 0.85)
  cb.check:Hide()

  local function IsPinned()
    return (QuickRackPinBar and QuickRackPinBar.IsPinned) and QuickRackPinBar.IsPinned(slotID) or false
  end

  local function UpdateVisual()
    local pinned = IsPinned()

    if pinned then
      -- Checked: crisp border + soft fill + checkmark
      cb.border:SetColorTexture(1, 1, 1, 0.70)
      cb.haze:SetColorTexture(1, 1, 1, 0.12)

      cb.fill:Show()
      cb.check:Show()
    else
      -- Unchecked: faint border + ultra soft haze
      cb.border:SetColorTexture(1, 1, 1, 0.25)
      cb.haze:SetColorTexture(1, 1, 1, 0.06)

      cb.fill:Hide()
      cb.check:Hide()
    end
  end

  cb:SetScript("OnClick", function()
    if QuickRackPinBar and QuickRackPinBar.TogglePin then
      QuickRackPinBar.TogglePin(slotID)
      UpdateVisual()
    end
  end)

  cb:SetScript("OnEnter", function()
    GameTooltip:SetOwner(cb, "ANCHOR_RIGHT")
    GameTooltip:SetText(IsPinned() and "Unpin" or "Pin", 1, 1, 1)
    GameTooltip:Show()
  end)
  cb:SetScript("OnLeave", function() if GameTooltip then GameTooltip:Hide() end end)

  cb.UpdateVisual = UpdateVisual
  UpdateVisual()
  return cb
end

local function GetSelectedSetNameForBinding()
  -- Only allow binding saved sets (not "Currently Equipped")
  if not currentSetName or currentSetName == "" or currentSetName == CURRENT_VALUE then
    return nil
  end
  return currentSetName
end

RefreshBindLabel = function()
  if not bindLabel then return end

  local setName = GetSelectedSetNameForBinding()
  if not setName then
    bindLabel:SetText("")
    return
  end

  local db = GetDB()
  local key = db and db.sets and db.sets[setName] and db.sets[setName].bindKey

  if key and key ~= "" then
    bindLabel:SetText("Bound key: " .. key)
  else
    bindLabel:SetText("")
  end
end

StartBindFlow = function(setName)
  ShowBindKeyPrompt(frame, function(bindKey)
    local db = GetDB()
    if not db.sets or not db.sets[setName] then return end

    -- Optional: enforce uniqueness (same key can't exist on multiple sets)
    for otherName, s in pairs(db.sets) do
      if otherName ~= setName and s.bindKey == bindKey then
        s.bindKey = nil
      end
    end

    db.sets[setName].bindKey = bindKey

    if QuickRack_ApplyKeybinds then
      QuickRack_ApplyKeybinds()
    end

    RefreshBindLabel()
    Print("Bound " .. bindKey .. " to " .. setName)
  end)
end

local function BuildUI()
  if frame then return end
  EnsureDB()

  frame = CreateFrame("Frame", "QuickRackEditorFrame", UIParent, "BackdropTemplate")
  frame:SetSize(380, 520)
  frame:SetPoint("CENTER")
  frame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 8, right = 8, top = 8, bottom = 8 }
  })
  -- Darken/opaque the background a bit
frame.shade = frame:CreateTexture(nil, "BACKGROUND")
frame.shade:ClearAllPoints()
frame.shade:SetPoint("TOPLEFT", frame, "TOPLEFT", 12, -12)
frame.shade:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -12, 12)
frame.shade:SetColorTexture(0, 0, 0, 0.65) -- increase alpha for more opaque (0.8 = very dark)
  frame:SetMovable(true)
  frame:EnableMouse(true)
  frame:RegisterForDrag("LeftButton")
  frame:SetScript("OnDragStart", function() frame:StartMoving() end)
  frame:SetScript("OnDragStop", function() frame:StopMovingOrSizing() end)
  frame:Hide()
frame:SetScript("OnHide", function()
  EnsureDB()
  if currentSetName and currentSetName ~= "" and currentSetName ~= CURRENT_VALUE then
    local db = GetDB()
    db.editor.lastSetName = currentSetName
  end
  draftSlots = nil
  if editorStrip and editorStrip:IsShown() then
  editorStrip.hovering = false
  editorStrip.slotHovering = false
  editorStrip:Hide()
end
end)

local credit = frame:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
credit:SetPoint("BOTTOMRIGHT", -14, 10)
credit:SetText("Created by Sealion")

  local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
  title:SetPoint("TOP", 0, -18)
  title:SetText("QuickRack Gearset Editor")

  local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
  close:SetPoint("TOPRIGHT", -6, -6)
  close:SetScript("OnClick", function()
  -- go through Toggle() so drafts are discarded correctly
  QuickRackEditor.Toggle()
end)

  local help = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  help:ClearAllPoints()
help:SetPoint("TOP", 0, -46)
help:SetJustifyH("CENTER")
  help:SetText("Left-click slot: Assign item\nAlt+Left-click: Clear slot\nRight-click: Ignore/unignore slot")

-- =========================
-- Top controls (two dropdowns side-by-side)
-- =========================
local controls = CreateFrame("Frame", nil, frame)
controls:SetSize(340, 70)
controls:SetPoint("TOP", 0, -88)

-- Left: Gearset dropdown + label
local gearLabel = controls:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
gearLabel:SetPoint("TOPLEFT", 0, 0)
gearLabel:SetText("Gearset")

dropdown = CreateFrame("Frame", "QuickRackEditorDropdown", controls, "UIDropDownMenuTemplate")
dropdown:SetPoint("TOPLEFT", gearLabel, "BOTTOMLEFT", -16, -2)
UIDropDownMenu_SetWidth(dropdown, 150)
UIDropDownMenu_Initialize(dropdown, Dropdown_Initialize)

-- Right: Trigger dropdown + label
local trigLabel = controls:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
trigLabel:SetPoint("TOPLEFT", 170, 0)
trigLabel:SetText("Use this gearset when")

triggerDropdown = CreateFrame("Frame", "QuickRackEditorTriggerDropdown", controls, "UIDropDownMenuTemplate")
triggerDropdown:SetPoint("TOPLEFT", trigLabel, "BOTTOMLEFT", -16, -2)
UIDropDownMenu_SetWidth(triggerDropdown, 150)
UIDropDownMenu_Initialize(triggerDropdown, TriggerDropdown_Initialize)

-- Ensure both show a sane default instead of "Custom"
UIDropDownMenu_SetSelectedValue(triggerDropdown, "none")
UIDropDownMenu_SetText(triggerDropdown, "None")

bindBtn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
bindBtn:SetSize(100, 24)
bindBtn:SetPoint("TOP", controls, "BOTTOM", 0, -6)
bindBtn:SetText("Bind key")
bindBtn:RegisterForClicks("LeftButtonUp", "RightButtonUp")

bindBtn:SetScript("OnEnter", function(self)
  GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
  GameTooltip:SetText("Bind key", 1, 1, 1)
  GameTooltip:AddLine("Left-click: bind a key", 0.9, 0.9, 0.9)
  GameTooltip:AddLine("Right-click: clear binding", 0.9, 0.9, 0.9)
  GameTooltip:Show()
end)
bindBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

bindLabel = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
bindLabel:SetPoint("TOP", bindBtn, "BOTTOM", 0, -6)
bindLabel:SetText("Bound key: (none)")

bindBtn:SetScript("OnClick", function(self, mouseButton)
  local setName = GetSelectedSetNameForBinding()
  if not setName then
    Print("Select a saved gearset first (not 'Currently Equipped').")
    return
  end

  local db = GetDB()
  if not db or not db.sets or not db.sets[setName] then return end

  -- RIGHT CLICK = clear binding
  if mouseButton == "RightButton" then
    db.sets[setName].bindKey = nil
    if QuickRack_ApplyKeybinds then QuickRack_ApplyKeybinds() end
    RefreshBindLabel()
    Print("Cleared key binding for " .. setName)
    return
  end

  -- LEFT CLICK = capture a key
  StartBindFlow(setName)
end)

-- Initialize label once UI exists
RefreshBindLabel()


local SLOT_Y_OFFSET = -40  -- keep your existing value
local SLOT_SIZE = 38
local GRID_MIN_X = 40
local GRID_MAX_X = 260 + SLOT_SIZE
local gridWidth = GRID_MAX_X - GRID_MIN_X
local originX = math.floor((frame:GetWidth() - gridWidth) / 2) - GRID_MIN_X

  -- Buttons
  for _, cfg in ipairs(SLOT_LAYOUT) do
    local slotID, defaultTexture = GetInventorySlotInfo(cfg.slotName)
    local btn = CreateFrame("Button", "QuickRackEditorSlot"..slotID, frame)
    btn:SetSize(38, 38)
	btn:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	btn:SetPoint("TOPLEFT", cfg.x + originX, cfg.y + SLOT_Y_OFFSET)
    btn.slotID = slotID
    btn.defaultTexture = defaultTexture

	btn:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")

    btn.icon = btn:CreateTexture(nil, "ARTWORK")
    btn.rarityGlow = CreateRarityGlow(btn)
    btn.icon:SetPoint("CENTER", 0, 0)
    btn.icon:SetSize(32, 32)
    btn.icon:SetTexture(defaultTexture)

-- Pin toggle (pin/unpin only happens in the editor)
btn.pinBtn = CreatePinCheckbox(btn, btn.slotID)

btn.ignoredX = btn:CreateTexture(nil, "OVERLAY")
btn.ignoredX:ClearAllPoints()
btn.ignoredX:SetPoint("TOPLEFT", btn, "TOPLEFT", 0, 0)
btn.ignoredX:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", 0, 0)
btn.ignoredX:SetTexture("Interface\\RaidFrame\\ReadyCheck-NotReady")
btn.ignoredX:SetBlendMode("ADD")
btn.ignoredX:SetAlpha(1)
btn.ignoredX:SetTexCoord(0.05, 0.95, 0.05, 0.95)
btn.ignoredX:Hide()

-- Ignore visuals
btn.ignoreShade = btn:CreateTexture(nil, "OVERLAY")
btn.ignoreShade:SetAllPoints(btn.icon)
btn.ignoreShade:SetColorTexture(0, 0, 0, 0.65)
btn.ignoreShade:Hide()

btn.ignoreBorder = btn:CreateTexture(nil, "OVERLAY")
btn.ignoreBorder:SetPoint("TOPLEFT", btn, "TOPLEFT", 2, -2)
btn.ignoreBorder:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -2, 2)
btn.ignoreBorder:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
btn.ignoreBorder:SetBlendMode("ADD")
btn.ignoreBorder:SetAlpha(0.85)
btn.ignoreBorder:Hide()

    btn:SetScript("OnEnter", function(self)
  GameTooltip:SetOwner(self, "ANCHOR_RIGHT")

  local val = draftSlots and draftSlots[tostring(self.slotID)]
  if val == "0" then val = 0 end


  if val == false then
    GameTooltip:AddLine("Ignored", 1, 0.3, 0.3)
    GameTooltip:AddLine("Right-click to unignore", 0.8, 0.8, 0.8)

elseif type(val) == "number" then
  if val and val > 0 then
    -- itemID (no enchants possible)
    GameTooltip:SetItemByID(val)
    GameTooltip:AddLine("Right-click: Ignore slot", 0.8, 0.8, 0.8)
    GameTooltip:AddLine("Alt+Left-click: Clear", 0.8, 0.8, 0.8)
  else
    -- cleared/empty
    GameTooltip:AddLine(self.slotName or "Slot", 1, 1, 1)
    GameTooltip:AddLine("Left-click: Assign item from cursor", 0.8, 0.8, 0.8)
    GameTooltip:AddLine("Right-click: Ignore slot", 0.8, 0.8, 0.8)
  end

elseif type(val) == "string" then
  GameTooltip:ClearLines()
  GameTooltip:SetHyperlink(val)
  if GameTooltip:NumLines() == 0 then
    local raw = val:match("|H([^|]+)|h") or val
    GameTooltip:SetHyperlink(raw)
  end
  GameTooltip:AddLine("Right-click: Ignore slot", 0.8, 0.8, 0.8)
  GameTooltip:AddLine("Alt+Left-click: Clear", 0.8, 0.8, 0.8)
  else
    GameTooltip:AddLine(self.slotName or "Slot", 1, 1, 1)
    GameTooltip:AddLine("Left-click: Assign item from cursor", 0.8, 0.8, 0.8)
    GameTooltip:AddLine("Right-click: Ignore slot", 0.8, 0.8, 0.8)
  end

  GameTooltip:Show()
-- Always show strip on hover (no Shift gating)
EnsureEditorStrip()
editorStrip.slotHovering = true
QuickRackEditor.ShowItemStripForSlot(self, self.slotID)
end)
    btn:SetScript("OnLeave", function()
  GameTooltip:Hide()
  if editorStrip then
    editorStrip.slotHovering = false
    EditorStripScheduleHide(0.25)
  end
end)

    btn:SetScript("OnClick", function(self, mouseButton)
      if not draftSlots then draftSlots = {} end

      if mouseButton == "RightButton" then
  -- toggle ignore (unignore defaults to clear/empty)
  local k = SlotKey(self.slotID)
  if draftSlots[k] == false then
    draftSlots[k] = 0
  else
    draftSlots[k] = false
  end
  RefreshButton(self.slotID)
  return
end

      if mouseButton == "LeftButton" then
		  if IsAltKeyDown() then
			draftSlots[SlotKey(self.slotID)] = 0
			RefreshButton(self.slotID)
			return
		  end

		  -- If player has an item on cursor, allow "drop to assign" (keep this convenience)
    local ctype, itemID, itemLink = GetCursorInfo()
    if ctype == "item" and (itemLink or itemID) then
      -- Prefer full link so enchants/gems show in tooltips
      draftSlots[SlotKey(self.slotID)] = itemLink or tonumber(itemID)
      ClearCursor()
      RefreshButton(self.slotID)
      return
    end

		  -- Otherwise show bag alternatives menu
-- Otherwise: click opens the dropdown menu (no Shift needed)
-- Also hide strip so they don't overlap.
if editorStrip and editorStrip:IsShown() then
  editorStrip.hovering = false
  editorStrip.slotHovering = false
  editorStrip:Hide()
end

ShowPickMenu(self, self.slotID)
		end
    end)

    buttonsBySlotID[slotID] = btn
  end


-- Bottom bar (create FIRST)
local bottomBar = CreateFrame("Frame", nil, frame)
bottomBar:SetSize(350, 26) -- 4*80 + 3*10
bottomBar:SetPoint("BOTTOM", frame, "BOTTOM", 0, 28)

-- Buttons MUST be parented to bottomBar (not frame)
local newBtn = CreateFrame("Button", nil, bottomBar, "UIPanelButtonTemplate")
newBtn:SetSize(80, 24)
newBtn:SetText("New")
newBtn:SetScript("OnClick", function()
  StaticPopup_Show("QUICKRACK_EDITOR_NEW")
end)

local saveBtn = CreateFrame("Button", nil, bottomBar, "UIPanelButtonTemplate")
saveBtn:SetSize(80, 24)
saveBtn:SetText("Save")
saveBtn:SetScript("OnClick", function()
  if currentSetName == CURRENT_VALUE then
    Print("You are viewing currently equipped gear. Use Save As… to create a new gearset.")
    return
  end
  if not currentSetName or currentSetName == "" then
    Print("Select a gearset first (or Save As).")
    return
  end
  QuickRack_SaveSetData(currentSetName, CopyTableShallow(draftSlots))
end)

local saveAsBtn = CreateFrame("Button", nil, bottomBar, "UIPanelButtonTemplate")
saveAsBtn:SetSize(80, 24)
saveAsBtn:SetText("Save As…")
saveAsBtn:SetScript("OnClick", function()
  StaticPopup_Show("QUICKRACK_EDITOR_SAVEAS")
end)

local deleteBtn = CreateFrame("Button", nil, bottomBar, "UIPanelButtonTemplate")
deleteBtn:SetSize(80, 24)
deleteBtn:SetText("Delete")
deleteBtn:SetScript("OnClick", function()
  if not currentSetName or currentSetName == "" or currentSetName == CURRENT_VALUE then return end
  QuickRack_DeleteSet(currentSetName)
  currentSetName = nil
  draftSlots = {}
  UIDropDownMenu_SetText(dropdown, "Select…")
  UIDropDownMenu_Initialize(dropdown, Dropdown_Initialize)
  RefreshAllButtons()
end)

-- IMPORTANT: clear any default anchors (prevents stacking/overlap)
newBtn:ClearAllPoints()
saveBtn:ClearAllPoints()
saveAsBtn:ClearAllPoints()
deleteBtn:ClearAllPoints()

-- Horizontal layout inside the centered bottomBar
newBtn:SetPoint("LEFT", bottomBar, "LEFT", 0, 0)
saveBtn:SetPoint("LEFT", newBtn, "RIGHT", 10, 0)
saveAsBtn:SetPoint("LEFT", saveBtn, "RIGHT", 10, 0)
deleteBtn:SetPoint("LEFT", saveAsBtn, "RIGHT", 10, 0)

-- Initialize selection (editor-only):
-- Default to Currently Equipped on first open; Toggle() will re-select on each open anyway.
local db = GetDB()

UIDropDownMenu_SetSelectedValue(dropdown, CURRENT_VALUE)
UIDropDownMenu_SetText(dropdown, CURRENT_LABEL)
LoadEquippedToDraft()
end

function QuickRackEditor.SaveAs(name)
  EnsureDB()
  if not name or name == "" then return end
  QuickRack_SaveSetData(name, CopyTableShallow(draftSlots))
  currentSetName = name
  UIDropDownMenu_Initialize(dropdown, Dropdown_Initialize)
  UIDropDownMenu_SetSelectedValue(dropdown, name)
  UIDropDownMenu_SetText(dropdown, name)
  local db = GetDB()
  db.editor.lastSetName = name
end

function QuickRackEditor.Toggle()
  BuildUI()
  EnsureDB()
  local db = GetDB()

  if frame:IsShown() then
    -- Remember which set was being edited
    if currentSetName and currentSetName ~= "" then
      db.editor.lastSetName = currentSetName
    end

    -- Discard unsaved edits
    draftSlots = nil

    frame:Hide()
    return
  end

  -- Opening: always discard any old in-memory draft and reload saved state
  draftSlots = nil
  currentSetName = nil

  UIDropDownMenu_Initialize(dropdown, Dropdown_Initialize)
  UIDropDownMenu_Initialize(triggerDropdown, TriggerDropdown_Initialize)

-- Opening: always show what is currently equipped.
-- If it matches a saved gearset, select that gearset; otherwise show "Currently Equipped".
local active = nil
if QuickRack_GetActiveSetName then
  active = QuickRack_GetActiveSetName()
end

-- If we match a saved set: open on that set. Otherwise: open on Currently Equipped.
local chosen = active

if chosen and db.sets[chosen] then
  UIDropDownMenu_SetSelectedValue(dropdown, chosen)
  UIDropDownMenu_SetText(dropdown, chosen)
  LoadSetToDraft(chosen)
else
  UIDropDownMenu_SetSelectedValue(dropdown, CURRENT_VALUE)
  UIDropDownMenu_SetText(dropdown, CURRENT_LABEL)
  LoadEquippedToDraft()
end

  frame:Show()
end