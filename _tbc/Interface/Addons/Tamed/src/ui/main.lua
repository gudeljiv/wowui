local AddonName, Addon = ...
local AbilityGroup = Addon:GetModule("AbilityGroup")
local AceGUI = Addon:GetLibrary("AceGUI")
local Colors = Addon:GetModule("Colors")
local L = Addon:GetModule("Locale")
local OptionsGroup = Addon:GetModule("OptionsGroup")
local TameableAbilities = Addon.TameableAbilities
local UI = Addon:GetModule("UI")
local Widgets = Addon:GetModule("Widgets")

local TreeGroup = {}

-- ============================================================================
-- Functions
-- ============================================================================

function UI:IsShown()
  return self.frame and self.frame:IsShown()
end

function UI:Toggle()
  if self:IsShown() then
    self:Hide()
  else
    self:Show()
  end
end

function UI:Show()
  if not self.frame then self:Create() end
  self.frame:Show()
end

function UI:Hide()
  if not self.frame then return end
  self.frame:Hide()
end

function UI:Create()
  local frame = AceGUI:Create("Frame")
  frame:SetTitle(AddonName)
  frame:SetWidth(650)
  frame:SetHeight(500)
  frame.frame:SetResizeBounds(650, 500)
  frame:SetLayout("Flow")
  self.frame = frame

  -- Add heading.
  Widgets:Heading(
    frame,
    ("%s: %s"):format(
      L.VERSION,
      Colors.Primary(Addon.VERSION)
    )
  )

  -- Add spacer.
  Widgets:Spacer(frame)

  -- Add TreeGroup.
  TreeGroup:Create(frame)

  self.Create = nil
end

-- ============================================================================
-- TreeGroup Functions
-- ============================================================================

function TreeGroup:Create(parent)
  local treeGroup = AceGUI:Create("TreeGroup")
  treeGroup:SetLayout("Fill")
  treeGroup:EnableButtonTooltips(false)
  treeGroup:SetCallback("OnGroupSelected", self.OnGroupSelected)

  -- Set tree.
  local tree = self:BuildTree()
  treeGroup:SetTree(tree)
  treeGroup:SelectByValue(tree[1].value)

  -- Add a SimpleGroup to `parent`, and add `treeGroup` to it.
  Widgets:SimpleGroup({
    parent = parent,
    fullWidth = true,
    fullHeight = true,
    layout = "Fill"
  }):AddChild(treeGroup)

  self.Create = nil
  self.BuildTree = nil
end

function TreeGroup:BuildTree()
  local tree = {
    { text = L.OPTIONS, value = "OPTIONS_GROUP" },
    { text = " ", value = "BLANK_1", disabled = true }
  }

  do -- Add ability groups to `tree`.
    local abilities = {}
    for id, ability in pairs(TameableAbilities) do
      local children = {}

      for i in ipairs(ability.ranks) do
        children[#children + 1] = {
          text = ("%s %s"):format(L.RANK, i),
          value = i
        }
      end

      abilities[#abilities + 1] = {
        text = ability.name,
        value = id,
        icon = ability.icon,
        disabled = true,
        children = children
      }
    end

    -- Sort `abilities` by `text`, and insert into `tree`.
    table.sort(abilities, function(a, b) return a.text < b.text end)
    for _, ability in ipairs(abilities) do tree[#tree + 1] = ability end
  end

  return tree
end

function TreeGroup:OnGroupSelected(event, value)
  self:ReleaseChildren()

  local parent = AceGUI:Create("ScrollFrame")
  parent:SetLayout("Flow")
  parent:PauseLayout()

  -- Create a ui based on the selected tree group `value`.
  if value == "OPTIONS_GROUP" then
    OptionsGroup:Create(parent)
  else
    local abilityId, abilityRank = value:match("^(.+)\001(%d+)$")
    local ability = TameableAbilities[abilityId] or error("Invalid ability id: " .. abilityId)
    AbilityGroup:Create(parent, ability, tonumber(abilityRank))
  end

  parent:ResumeLayout()
  parent:DoLayout()

  self:AddChild(parent)
end

-- ============================================================================
-- `CloseSpecialWindows` Hook
-- ============================================================================

-- `CloseSpecialWindows` is called when the "Esc" key is pressed.
local closeSpecialWindows = _G.CloseSpecialWindows
_G.CloseSpecialWindows = function()
  local found = closeSpecialWindows()

  if UI:IsShown() then
    UI:Hide()
    return true
  end

  return found
end
