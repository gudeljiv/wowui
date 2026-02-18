-- QuickRack - char.lua
-- Adds a small gearset dropdown to the built-in Character window (C).

local ADDON = ...
QuickRackChar = QuickRackChar or {}

local CURRENT_VALUE = "__QR_CURRENT__"
local CURRENT_LABEL = "Currently Equipped"

local function GetDB()
  QuickRackDB = QuickRackDB or {}
  if EnsureCharDB then
    return EnsureCharDB()
  end
  -- fallback (shouldn't happen if core.lua is present)
  QuickRackDB.sets = QuickRackDB.sets or {}
  return QuickRackDB
end

local function GetActiveSetName()
  if QuickRack_GetActiveSetName then
    return QuickRack_GetActiveSetName()
  end
  return nil
end

local function EnsureCharacterFramesReady()
  return CharacterFrame and PaperDollFrame
end

local function BuildDropdown(parent)
  local db = GetDB()
  db.ui = db.ui or {}
  db.ui.charSelectorMode = db.ui.charSelectorMode or "dropdown" -- "icon" | "dropdown"

  -- This frame is ALSO the dropdown widget if we show it.
  local menu = CreateFrame("Frame", "QuickRack_CharacterGearMenu", parent, "UIDropDownMenuTemplate")

  -- Where the old dropdown used to be
  local anchor = PaperDollFrame
  local xOffIcon, yOff = -65, -45
  local xOffDrop = -50 -- tweak if needed (puts the full dropdown roughly where old one lived)

  -- Main button: armor icon (opens the dropdown menu)
  local armorBtn = CreateFrame("Button", "QuickRack_CharacterArmorButton", parent, "UIPanelButtonTemplate")
  local size = 26
  armorBtn:SetSize(size, size)
  armorBtn:SetPoint("TOPRIGHT", anchor, "TOPRIGHT", xOffIcon, yOff)

  armorBtn:SetFrameStrata("MEDIUM")
  armorBtn:SetFrameLevel((PaperDollFrame:GetFrameLevel() or 1) + 10)

  local armorIcon = armorBtn:CreateTexture(nil, "ARTWORK")
  armorIcon:SetTexture("Interface\\Icons\\INV_Chest_Cloth_17")
  armorIcon:SetPoint("CENTER", armorBtn, "CENTER", 0, 0)
  armorIcon:SetSize(18, 18)
  armorIcon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
  armorBtn._icon = armorIcon

  -- Settings button (gear icon)
  local gearBtn = CreateFrame("Button", "QuickRack_CharacterGearButton", parent, "UIPanelButtonTemplate")
  gearBtn:SetSize(size, size)

  gearBtn:SetFrameStrata(armorBtn:GetFrameStrata() or "MEDIUM")
  gearBtn:SetFrameLevel((armorBtn:GetFrameLevel() or 1) + 1)

  local icon = gearBtn:CreateTexture(nil, "ARTWORK")
  icon:SetTexture("Interface\\Buttons\\UI-OptionsButton")
  icon:SetPoint("CENTER", gearBtn, "CENTER", 0, 0)
  icon:SetSize(13, 13)
  icon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
  gearBtn._icon = icon

  gearBtn:SetScript("OnClick", function()
    if QuickRackEditor and QuickRackEditor.Toggle then
      QuickRackEditor.Toggle()
    elseif QuickRackEditor_Toggle then
      QuickRackEditor_Toggle()
    end
  end)

  gearBtn:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText("QuickRack", 1, 1, 1)
    GameTooltip:AddLine("Open Gearset Editor", 0.9, 0.9, 0.9)
    GameTooltip:Show()
  end)
  gearBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

  local function RefreshLabel()
    local active = GetActiveSetName()

    -- icon tooltip
    armorBtn._activeSet = active

    -- dropdown text
    if menu._mode == "dropdown" then
      UIDropDownMenu_SetText(menu, active or CURRENT_LABEL)
    end
  end

  local function ApplyMode(mode)
    mode = mode or (db.ui and db.ui.charSelectorMode) or "icon"
    db.ui.charSelectorMode = mode
    menu._mode = mode

    if mode == "dropdown" then
      -- Show the actual dropdown control
      menu:Show()
      menu:ClearAllPoints()
      menu:SetPoint("TOPRIGHT", anchor, "TOPRIGHT", xOffDrop, yOff)
      UIDropDownMenu_SetWidth(menu, 110)
      UIDropDownMenu_JustifyText(menu, "LEFT")

      armorBtn:Hide()

      gearBtn:ClearAllPoints()
      gearBtn:SetPoint("LEFT", menu, "RIGHT", -13, 3) -- -10 compensates template padding
    else
      -- Icon mode
      menu:Hide()
      armorBtn:Show()

      gearBtn:ClearAllPoints()
      gearBtn:SetPoint("LEFT", armorBtn, "RIGHT", 2, 0)
    end

    RefreshLabel()
  end

  local function Initialize(self, level)
    if level ~= 1 then return end

    local db2 = GetDB()
    local active = GetActiveSetName()

    local info = UIDropDownMenu_CreateInfo()
    info.text = "QuickRack"
    info.isTitle = true
    info.notCheckable = true
    UIDropDownMenu_AddButton(info, level)

    if not active then
      info = UIDropDownMenu_CreateInfo()
      info.text = CURRENT_LABEL
      info.value = CURRENT_VALUE
      info.notCheckable = false
      info.checked = true
      info.disabled = true
      UIDropDownMenu_AddButton(info, level)
    end

    local names = {}
    for name,_ in pairs((db2 and db2.sets) or {}) do
      table.insert(names, name)
    end
    table.sort(names)

    if #names == 0 then
      info = UIDropDownMenu_CreateInfo()
      info.text = "No gearsets"
      info.notCheckable = true
      info.disabled = true
      UIDropDownMenu_AddButton(info, level)
    else
      for _, name in ipairs(names) do
        info = UIDropDownMenu_CreateInfo()
        info.text = name
        info.value = name
        info.notCheckable = false
        info.checked = (active == name)
        info.func = function()
          if QuickRack_EquipSet then
            QuickRack_EquipSet(name)
          end
          RefreshLabel()
          CloseDropDownMenus()
        end
        UIDropDownMenu_AddButton(info, level)
      end
    end

    -- Divider
    info = UIDropDownMenu_CreateInfo()
    info.text = " "
    info.notCheckable = true
    info.disabled = true
    UIDropDownMenu_AddButton(info, level)

    -- Toggle display mode
    local isIcon = (menu._mode ~= "dropdown")
    info = UIDropDownMenu_CreateInfo()
    info.text = isIcon and "Expand to dropdown" or "Shrink to icon"
    info.notCheckable = true
    info.func = function()
      local newMode = isIcon and "dropdown" or "icon"
      db2.ui = db2.ui or {}
      db2.ui.charSelectorMode = newMode
      ApplyMode(newMode)
      CloseDropDownMenus()
    end
    UIDropDownMenu_AddButton(info, level)
  end

  UIDropDownMenu_Initialize(menu, Initialize)

  -- Close dropdown when character frame hides
  if not parent.__quickrackDropdownHideHooked then
    parent.__quickrackDropdownHideHooked = true
    PaperDollFrame:HookScript("OnHide", function() CloseDropDownMenus() end)
    if CharacterFrame then
      CharacterFrame:HookScript("OnHide", function() CloseDropDownMenus() end)
    end
  end

  -- Click icon button => open menu
  armorBtn:SetScript("OnClick", function(self)
    ToggleDropDownMenu(1, nil, menu, self, 0, 0)
  end)

  armorBtn:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText("QuickRack", 1, 1, 1)

    local active = self._activeSet
    if active then
      GameTooltip:AddLine("Active set: " .. active, 0.9, 0.9, 0.9)
    else
      GameTooltip:AddLine("Active set: " .. CURRENT_LABEL, 0.9, 0.9, 0.9)
    end

    GameTooltip:AddLine("Click to switch gearset", 0.8, 0.8, 0.8)
    GameTooltip:Show()
  end)
  armorBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

  -- When in dropdown mode, clicking the dropdown widget itself should open its menu.
  -- (UIDropDownMenuTemplate already wires its own button; this is just to ensure refresh.)
  menu.RefreshLabel = RefreshLabel
  menu.ApplyMode = ApplyMode

  -- Initial layout
  ApplyMode(db.ui.charSelectorMode)

  -- Store references
  menu.GearButton = gearBtn
  menu.ArmorButton = armorBtn

  return menu
end

local function TryInit()
  if QuickRackChar._initialized then return end
  if not EnsureCharacterFramesReady() then return end

  -- Parent it to the actual CharacterFrame so it follows it properly
  QuickRackChar.dropdown = BuildDropdown(PaperDollFrame)
  QuickRackChar._initialized = true

  -- Refresh when the window opens
  CharacterFrame:HookScript("OnShow", function()
    if QuickRackChar.dropdown and QuickRackChar.dropdown.RefreshLabel then
      QuickRackChar.dropdown:RefreshLabel()
    end
  end)

  -- Refresh when gear changes
  local f = CreateFrame("Frame")
  f:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
  f:RegisterEvent("PLAYER_ENTERING_WORLD")
  f:SetScript("OnEvent", function()
    if QuickRackChar.dropdown and QuickRackChar.dropdown.RefreshLabel then
      QuickRackChar.dropdown:RefreshLabel()
    end
  end)
end

local loader = CreateFrame("Frame")
loader:RegisterEvent("PLAYER_LOGIN")
loader:RegisterEvent("ADDON_LOADED")
loader:SetScript("OnEvent", function(self, event)
  -- CharacterFrame is usually ready by PLAYER_LOGIN, but be safe.
  TryInit()
end)