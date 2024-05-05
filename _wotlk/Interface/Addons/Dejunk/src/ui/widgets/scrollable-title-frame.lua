local _, Addon = ...
local Widgets = Addon:GetModule("Widgets") ---@class Widgets

-- =============================================================================
-- LuaCATS Annotations
-- =============================================================================

--- @class ScrollableTitleFrameWidgetOptions : TitleFrameWidgetOptions

-- =============================================================================
-- Widgets - Scrollable Title Frame
-- =============================================================================

--- Creates a TitleFrame with an embedded scroll frame and slider.
--- @param options ScrollableTitleFrameWidgetOptions
--- @return ScrollableTitleFrameWidget frame
function Widgets:ScrollableTitleFrame(options)
  local SPACING = self:Padding()

  -- Base frame.
  local frame = self:TitleFrame(options) ---@class ScrollableTitleFrameWidget : TitleFrameWidget

  -- Scroll frame.
  frame.scrollFrame = CreateFrame("ScrollFrame", "$parent_ScrollFrame", frame)
  frame.scrollFrame:SetPoint("TOPLEFT", frame.titleButton, "BOTTOMLEFT", SPACING, -SPACING)

  -- Slider.
  frame.slider = self:Slider({
    name = "$parent_Slider",
    parent = frame,
    points = {
      { "TOPRIGHT",    frame.titleButton, "BOTTOMRIGHT", -SPACING, -SPACING },
      { "BOTTOMRIGHT", frame,             "BOTTOMRIGHT", -SPACING, SPACING }
    }
  })

  frame.slider:SetScript("OnValueChanged", function(self, value)
    local min, max = self:GetMinMaxValues()
    frame.scrollFrame:SetVerticalScroll(Clamp(math.floor(value + 0.5), min, max))
  end)

  -- OnUpdate.
  frame:SetScript("OnUpdate", function(self)
    local scrollChild = self.scrollFrame:GetScrollChild()
    if not scrollChild then return end
    scrollChild:SetWidth(self.scrollFrame:GetWidth())

    -- Slider.
    local maxSliderValue = math.max(scrollChild:GetHeight() - frame.scrollFrame:GetHeight(), 0)
    self.slider:SetMinMaxValues(0, maxSliderValue)

    if maxSliderValue > 0 then
      self.slider:Show()
      self.scrollFrame:SetPoint("BOTTOMRIGHT", self.slider, "BOTTOMLEFT", -SPACING, 0)
    else
      self.slider:Hide()
      self.scrollFrame:SetPoint("BOTTOMRIGHT", -SPACING, SPACING)
    end
  end)

  -- OnMouseWheel.
  frame:SetScript("OnMouseWheel", function(self, delta)
    local value = self.slider:GetValue() - (self.scrollFrame:GetHeight() * 0.75 * delta)
    self.slider:SetValue(value)
  end)

  return frame
end
