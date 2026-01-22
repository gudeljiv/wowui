local ADDON_NAME, Addon = ...
local Colors = Addon:GetModule("Colors")
local DB = Addon:GetModule("DB")
local TameableNPCs = Addon.TameableNPCs

GameTooltip:HookScript("OnTooltipSetUnit", function(self)
  if not DB.global.npc_tooltips then return end

  -- Get unit.
  local _, unit = self:GetUnit()
  if not unit then return end

  -- Get unit type and id.
  local guid = UnitGUID(unit) or ""
  local unitType, _, _, _, _, id = strsplit("-", guid)
  if not (id and unitType == "Creature") then return end

  -- Get npc.
  local npc = TameableNPCs[id]
  if not npc then return end

  -- Add lines.
  self:AddLine(Colors.Primary(ADDON_NAME))
  for _, ability in ipairs(npc.abilities) do
    self:AddLine("  " .. ability, 1, 1, 1)
  end
end)
