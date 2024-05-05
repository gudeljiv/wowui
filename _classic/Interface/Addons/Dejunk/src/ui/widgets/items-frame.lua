local _, Addon = ...
local Colors = Addon:GetModule("Colors") ---@type Colors
local L = Addon:GetModule("Locale") ---@type Locale
local Widgets = Addon:GetModule("Widgets") ---@class Widgets

-- =============================================================================
-- LuaCATS Annotations
-- =============================================================================

--- @class ItemsFrameWidgetOptions : TitleFrameWidgetOptions
--- @field itemButtonOnUpdateTooltip? fun(self: ItemButtonWidget, tooltip: Tooltip)
--- @field itemButtonOnClick? fun(self: ItemButtonWidget, button: string)
--- @field numButtons? integer
--- @field displayPrice? boolean
--- @field getItems fun(): table[]
--- @field addItem fun(itemId: string)
--- @field removeAllItems fun()

--- @class ItemButtonWidgetOptions : FrameWidgetOptions
--- @field onClick? fun(self: ItemButtonWidget, button: string)
--- @field displayPrice? boolean

-- =============================================================================
-- Widgets - Items Frame
-- =============================================================================

--- Creates a fake scrolling frame for displaying items.
--- @param options ItemsFrameWidgetOptions
--- @return ItemsFrameWidget
function Widgets:ItemsFrame(options)
  local SPACING = Widgets:Padding()

  -- Defaults.
  options.titleTemplate = nil
  options.titleJustify = "CENTER"
  options.numButtons = Addon:IfNil(options.numButtons, 7)

  -- Base frame.
  local frame = self:TitleFrame(options) ---@class ItemsFrameWidget : TitleFrameWidget
  frame.buttons = {}

  frame.titleButton:SetScript("OnClick", function(_, button)
    if button == "RightButton" and IsControlKeyDown() and IsAltKeyDown() then
      options.removeAllItems()
    end
  end)

  -- Slider.
  frame.slider = self:Slider({
    name = "$parent_Slider",
    parent = frame,
    points = {
      { "TOPRIGHT",    frame.titleButton, "BOTTOMRIGHT", -SPACING, -SPACING },
      { "BOTTOMRIGHT", frame,             "BOTTOMRIGHT", -SPACING, SPACING }
    }
  })

  -- Buttons.
  for i = 1, options.numButtons do
    frame.buttons[#frame.buttons + 1] = self:ItemButton({
      name = "$parent_ItemButton" .. i,
      parent = frame,
      displayPrice = options.displayPrice,
      onUpdateTooltip = options.itemButtonOnUpdateTooltip,
      onClick = options.itemButtonOnClick
    })
  end

  -- No items text.
  frame.noItemsText = frame:CreateFontString("$parent_NoItemsText", "ARTWORK", "GameFontNormal")
  frame.noItemsText:SetPoint("CENTER")
  frame.noItemsText:SetText(Colors.White(L.NO_ITEMS))
  frame.noItemsText:SetAlpha(0.3)

  function frame:AddCursorItem()
    if CursorHasItem() then
      local infoType, itemId = GetCursorInfo()
      if infoType == "item" then options.addItem(itemId) end
      ClearCursor()
    end
  end

  frame:SetScript("OnMouseDown", frame.AddCursorItem)

  frame:SetScript("OnMouseWheel", function(self, delta)
    self.slider:SetValue(self.slider:GetValue() - delta)
  end)

  frame:SetScript("OnUpdate", function(self)
    local items = options.getItems()

    -- Update buttons.
    for i, button in ipairs(self.buttons) do
      local sliderOffset = math.floor(self.slider:GetValue() + 0.5)
      local item = items[i + sliderOffset]
      if item then
        button:SetItem(item)
        button:Show()
      else
        button:Hide()
      end

      -- Points.
      if i == 1 then
        button:SetPoint("TOPLEFT", self.titleButton, "BOTTOMLEFT", SPACING, -SPACING)
        button:SetPoint("TOPRIGHT", self.slider, "TOPLEFT", -SPACING, 0)
      else
        button:SetPoint("TOPLEFT", self.buttons[i - 1], "BOTTOMLEFT", 0, -SPACING)
        button:SetPoint("TOPRIGHT", self.buttons[i - 1], "BOTTOMRIGHT", 0, -SPACING)
      end

      -- Height.
      local buttonArea = self:GetHeight() - self.titleButton:GetHeight() - (SPACING * 2)
      local buttonSpacing = (options.numButtons - 1) * SPACING
      button:SetHeight((buttonArea - buttonSpacing) / options.numButtons)
    end

    -- Update slider values.
    local maxVal = max((#items - #self.buttons), 0)
    self.slider:SetMinMaxValues(0, maxVal)
    if maxVal == 0 then
      self.slider:Hide()
      self.buttons[1]:SetPoint("TOPRIGHT", self.titleButton, "BOTTOMRIGHT", -SPACING, -SPACING)
    else
      self.slider:Show()
      self.buttons[1]:SetPoint("TOPRIGHT", self.slider, "TOPLEFT", -SPACING, 0)
    end

    -- Update "No items." text.
    if #items == 0 then
      self.noItemsText:Show()
    else
      self.noItemsText:Hide()
    end
  end)

  return frame
end

-- =============================================================================
-- Widgets - Item Button
-- =============================================================================

--- Creates a button for displaying an item in an ItemsFrame.
--- @param options ItemButtonWidgetOptions
--- @return ItemButtonWidget frame
function Widgets:ItemButton(options)
  -- Defaults.
  options.frameType = "Button"
  options.onUpdateTooltip = Addon:IfNil(options.onUpdateTooltip, function(self, tooltip)
    tooltip:SetHyperlink(self.item.link)
  end)

  -- Base frame.
  local frame = self:Frame(options) ---@class ItemButtonWidget : FrameWidget
  frame:RegisterForClicks("LeftButtonUp", "RightButtonUp")
  frame:SetBackdropColor(Colors.DarkGrey:GetRGBA(0.25))
  frame:SetBackdropBorderColor(Colors.White:GetRGBA(0.25))

  -- Item icon.
  frame.icon = frame:CreateTexture("$parent_Icon", "ARTWORK")
  frame.icon:SetPoint("LEFT", self:Padding(0.5), 0)

  -- Item text.
  frame.text = frame:CreateFontString("$parent_Text", "ARTWORK", "GameFontNormal")
  frame.text:SetPoint("LEFT", frame.icon, "RIGHT", self:Padding(0.5), 0)
  frame.text:SetPoint("RIGHT", frame, "RIGHT", -self:Padding(0.5), 0)
  frame.text:SetJustifyH("LEFT")
  frame.text:SetWordWrap(false)

  -- Price text.
  if options.displayPrice then
    frame.price = frame:CreateFontString("$parent_Price", "ARTWORK", "GameFontNormal")
    frame.price:SetPoint("RIGHT", frame, -self:Padding(0.5), 0)
    frame.price:SetJustifyH("RIGHT")
    frame.price:SetWordWrap(false)
    -- Update item text point.
    frame.text:SetPoint("RIGHT", frame.price, "LEFT", -self:Padding(0.5), 0)
  end

  function frame:OnUpdate()
    if not self.item then return end
    -- Icon.
    local size = self:GetHeight() - Widgets:Padding()
    self.icon:SetSize(size, size)
    self.icon:SetTexture(self.item.texture)
    self.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    -- Text.
    local quantity = self.item.quantity or 1
    self.text:SetText(self.item.link .. (quantity > 1 and Colors.White("x" .. quantity) or ""))
    -- Price.
    if self.price then
      self.price:SetText(Colors.White(GetCoinTextureString(self.item.price * quantity)))
    end
  end

  function frame:SetItem(item)
    self.item = item
  end

  frame:HookScript("OnEnter", function(self)
    self:SetBackdropColor(Colors.DarkGrey:GetRGBA(0.5))
    self:SetBackdropBorderColor(Colors.White:GetRGBA(0.5))
  end)

  frame:HookScript("OnLeave", function(self)
    self:SetBackdropColor(Colors.DarkGrey:GetRGBA(0.25))
    self:SetBackdropBorderColor(Colors.White:GetRGBA(0.25))
  end)

  frame:SetScript("OnClick", function(self, button)
    if CursorHasItem() then
      if button == "LeftButton" then
        self:GetParent():AddCursorItem()
      end
    elseif options.onClick then
      options.onClick(self, button)
    end
  end)

  frame:SetScript("OnUpdate", frame.OnUpdate)

  return frame
end
