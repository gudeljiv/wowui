-- QuickRack - ui.lua

QuickRackUI = {}

local function Print(msg)
  DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99QuickRack|r: " .. msg)
end

local function GetDB()
  if EnsureCharDB then
    return EnsureCharDB()
  end
  QuickRackDB = QuickRackDB or {}
  QuickRackDB.sets = QuickRackDB.sets or {}
  return QuickRackDB
end

local frame

local function CreateUI()
  if frame then return end

  frame = CreateFrame("Frame", "QuickRackFrame", UIParent)
  frame:SetWidth(240)
  frame:SetHeight(300)
  frame:SetPoint("CENTER")
  frame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 8, right = 8, top = 8, bottom = 8 }
  })
  frame:SetMovable(true)
  frame:EnableMouse(true)
  frame:RegisterForDrag("LeftButton")
  frame:SetScript("OnDragStart", function() frame:StartMoving() end)
  frame:SetScript("OnDragStop", function() frame:StopMovingOrSizing() end)
  frame:Hide()

  local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
  title:SetPoint("TOP", 0, -14)
  title:SetText("QuickRack")

  local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
  close:SetPoint("TOPRIGHT", -6, -6)

  local hint = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  hint:SetPoint("TOPLEFT", 16, -40)
  hint:SetJustifyH("LEFT")
  hint:SetText("Buttons equip sets.\nUse /qr save <name> to add.")

  local scroll = CreateFrame("ScrollFrame", "QuickRackScroll", frame, "UIPanelScrollFrameTemplate")
  scroll:SetPoint("TOPLEFT", 16, -70)
  scroll:SetPoint("BOTTOMRIGHT", -30, 16)

  local content = CreateFrame("Frame", nil, scroll)
  content:SetWidth(180)
  content:SetHeight(1)
  scroll:SetScrollChild(content)

  frame.content = content
  frame.buttons = {}

  -- Create once; just show/hide it later (prevents duplicates)
  frame.emptyText = content:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
  frame.emptyText:SetPoint("TOPLEFT", 0, -6)
  frame.emptyText:SetText("No sets yet.")
  frame.emptyText:Hide()
end

local function GetSortedSetNames(db)
  local names = {}
  for name, _ in pairs(db.sets or {}) do
    table.insert(names, name)
  end
  table.sort(names, function(a, b) return tostring(a):lower() < tostring(b):lower() end)
  return names
end

function QuickRackUI.Refresh()
  if not frame then return end
  local db = GetDB()

  -- Clear old buttons
  for _, b in ipairs(frame.buttons) do
    b:Hide()
    b:SetParent(nil)
  end
  frame.buttons = {}

  frame.emptyText:Hide()

  local y = -4
  local names = GetSortedSetNames(db)

  for i = 1, #names do
    local name = names[i]
    local btn = CreateFrame("Button", nil, frame.content, "UIPanelButtonTemplate")
    btn:SetWidth(160)
    btn:SetHeight(22)
    btn:SetPoint("TOPLEFT", 0, y)
    btn:SetText(name)
    btn:SetScript("OnClick", function()
      QuickRack_EquipSet(name)
    end)

    table.insert(frame.buttons, btn)
    y = y - 26
  end

  if #names == 0 then
    frame.emptyText:Show()
  end

  frame.content:SetHeight(math.max(1, #names * 26))
end

function QuickRackUI.Toggle()
  CreateUI()
  if frame:IsShown() then
    frame:Hide()
  else
    frame:Show()
    QuickRackUI.Refresh()
  end
end

local function EnsureMinimapDB()
  QuickRackDB = QuickRackDB or {}
  QuickRackDB.minimap = QuickRackDB.minimap or { angle = 220, hide = false }
end

local function NormalizeAngle(a)
  if not a then return 220 end
  a = a % 360
  if a < 0 then a = a + 360 end
  return a
end

local function GetMinimapButtonPos(angle)
  local rad = math.rad(NormalizeAngle(angle))
  local x = math.cos(rad) * 80
  local y = math.sin(rad) * 80
  return x, y
end

local function SetMinimapButtonPos(btn, angle)
  local x, y = GetMinimapButtonPos(angle)
  btn:ClearAllPoints()
  btn:SetPoint("CENTER", Minimap, "CENTER", x, y)
end

-- Static popup to input a set name
StaticPopupDialogs["QUICKRACK_SAVE_SET"] = {
  text = "Save current gear as set:",
  button1 = "Save",
  button2 = "Cancel",
  hasEditBox = true,
  timeout = 0,
  whileDead = true,
  hideOnEscape = true,
  preferredIndex = 3,

  OnShow = function(self)
    self.editBox:SetText("")
    self.editBox:SetFocus()
  end,

  OnAccept = function(self)
    local name = self.editBox:GetText()
    if name and name:gsub("%s+", "") ~= "" then
      QuickRack_SaveSet(name)
    end
  end,

  EditBoxOnEnterPressed = function(self)
    local parent = self:GetParent()
    local name = self:GetText()
    if name and name:gsub("%s+", "") ~= "" then
      QuickRack_SaveSet(name)
    end
    parent:Hide()
  end,
}

local menuFrame

local function BuildMenu()
  local db = GetDB()
  local names = GetSortedSetNames(db)

  local loadSub = {}

  for i = 1, #names do
    local setName = names[i]
    table.insert(loadSub, {
      text = setName,
      notCheckable = true,
      func = function()
        QuickRack_EquipSet(setName)
        CloseDropDownMenus()
      end,
    })
  end

  if #loadSub == 0 then
    loadSub = { { text = "No sets saved", notCheckable = true, disabled = true } }
  end

  -- IMPORTANT: level-1 menu is now ONLY your sets (no submenus)
  return loadSub
end


function QuickRackUI.CreateMinimapButton()
  EnsureMinimapDB()

  if QuickRackUI.minimapButton then
    if QuickRackDB.minimap.hide then
      QuickRackUI.minimapButton:Hide()
    else
      QuickRackUI.minimapButton:Show()
      SetMinimapButtonPos(QuickRackUI.minimapButton, QuickRackDB.minimap.angle)
    end
    return
  end

  menuFrame = CreateFrame("Frame", "QuickRackMinimapMenuFrame", UIParent, "UIDropDownMenuTemplate")
  UIDropDownMenu_SetWidth(menuFrame, 180)
  UIDropDownMenu_Initialize(menuFrame, function(self, level, menuList)
    level = level or 1

    if level == 1 then
      local menu = BuildMenu()
      for _, item in ipairs(menu) do
        UIDropDownMenu_AddButton(item, level)
      end
      return
    end

    if menuList then
      for _, item in ipairs(menuList) do
        UIDropDownMenu_AddButton(item, level)
      end
    end
  end, "MENU")

  local btn = CreateFrame("Button", "QuickRackMinimapButton", Minimap)
  btn:SetFrameStrata("MEDIUM")
  btn:SetSize(32, 32)
  btn:RegisterForClicks("LeftButtonUp", "RightButtonUp")
  btn:RegisterForDrag("LeftButton")

  local function SetRingTexture(tex)
    btn:SetNormalTexture(tex)
    local ring = btn:GetNormalTexture()
    if ring then
      ring:ClearAllPoints()
      ring:SetPoint("TOPLEFT", btn, "TOPLEFT", -5, 5)
      ring:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", 5, -5)
      ring:SetAlpha(1)
      ring:SetVertexColor(1, 1, 1, 1)
      if ring.SetDesaturated then ring:SetDesaturated(false) end
      ring:Show()
    end
    return ring and ring:GetTexture()
  end

  local chosen = SetRingTexture("Interface\\Buttons\\UI-Quickslot2")
  if not chosen then chosen = SetRingTexture("Interface\\Minimap\\MiniMap-TrackingBorder") end
  if not chosen then chosen = SetRingTexture("Interface\\Buttons\\UI-Quickslot") end

  -- ICON as its own texture on top
  btn.icon = btn:CreateTexture(nil, "ARTWORK")
  btn.icon:SetPoint("CENTER", btn, "CENTER", 0, 0)
  btn.icon:SetSize(20, 20)
  btn.icon:SetTexture("Interface\\Icons\\INV_Chest_Chain_15")
  btn.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

  btn:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", "ADD")

  -- compatibility for minimap button collectors
  btn.Icon = btn.icon
  btn.texture = btn.icon

  btn:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    GameTooltip:AddLine("QuickRack", 1, 1, 1)
    GameTooltip:AddLine("Left-click: Gear Editor", 0.8, 0.8, 0.8)
    GameTooltip:AddLine("Right-click: Load Saved Set", 0.8, 0.8, 0.8)
    GameTooltip:Show()
  end)
  btn:SetScript("OnLeave", function() GameTooltip:Hide() end)

  btn:SetScript("OnDragStart", function(self)
    self.isDragging = true
    self:SetScript("OnUpdate", function()
      local mx, my = Minimap:GetCenter()
      local px, py = GetCursorPosition()
      local scale = UIParent:GetScale()
      px, py = px / scale, py / scale

      local dx, dy = px - mx, py - my
      local angle = NormalizeAngle(math.deg(math.atan2(dy, dx)))
      QuickRackDB.minimap.angle = angle
      SetMinimapButtonPos(self, angle)
    end)
  end)

  btn:SetScript("OnDragStop", function(self)
    self.isDragging = false
    self:SetScript("OnUpdate", nil)
    QuickRackDB.minimap.angle = NormalizeAngle(QuickRackDB.minimap.angle)
    SetMinimapButtonPos(self, QuickRackDB.minimap.angle)
  end)

  btn:SetScript("OnClick", function(self, button)
    if button == "LeftButton" then
      if QuickRackEditor and QuickRackEditor.Toggle then
        QuickRackEditor.Toggle()
      end
      return
    end

    if button == "RightButton" then
      if ClearAllDropdownItemTooltips then ClearAllDropdownItemTooltips() end
      ToggleDropDownMenu(1, nil, menuFrame, "cursor", 0, 0)
      return
    end
  end)

  QuickRackUI.minimapButton = btn

  if QuickRackDB.minimap.hide then
    btn:Hide()
  else
    btn:Show()
    SetMinimapButtonPos(btn, QuickRackDB.minimap.angle)
  end
end

-- Initialize on login so Minimap exists
local initFrame = CreateFrame("Frame")
initFrame:RegisterEvent("PLAYER_LOGIN")
initFrame:SetScript("OnEvent", function()
  QuickRackUI.CreateMinimapButton()
end)
