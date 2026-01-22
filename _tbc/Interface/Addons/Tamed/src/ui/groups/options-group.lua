local _, Addon = ...
local DB = Addon:GetModule("DB")
local L = Addon:GetModule("Locale")
local MinimapIcon = Addon:GetModule("MinimapIcon")
local OptionsGroup = Addon:GetModule("OptionsGroup")
local Widgets = Addon:GetModule("Widgets")

function OptionsGroup:Create(parent)
  Widgets:Heading(parent, L.OPTIONS)
  self:AddGeneral(parent)
end

function OptionsGroup:AddGeneral(parent)
  parent = Widgets:InlineGroup({
    parent = parent,
    title = L.GENERAL,
    fullWidth = true
  })

  -- Minimap Icon.
  Widgets:CheckBox({
    parent = parent,
    label = L.MINIMAP_ICON,
    tooltip = L.MINIMAP_ICON_TOOLTIP,
    get = function() return not DB.global.minimapIcon.hide end,
    set = function() MinimapIcon:Toggle() end
  })

  -- NPC Tooltips.
  Widgets:CheckBox({
    parent = parent,
    label = L.NPC_TOOLTIPS,
    tooltip = L.NPC_TOOLTIPS_TOOLTIP,
    get = function() return DB.global.npc_tooltips end,
    set = function(value) DB.global.npc_tooltips = value end
  })
end
