local _, Addon = ...
local AbilityGroup = Addon:GetModule("AbilityGroup")
local Colors = Addon:GetModule("Colors")
local HBDPins = Addon:GetLibrary("HBDPins")
local L = Addon:GetModule("Locale")
local PinHelper = Addon:GetModule("PinHelper")
local Widgets = Addon:GetModule("Widgets")

function AbilityGroup:Create(parent, ability, rankIndex)
  -- Tooltip/heading button.
  local title = ("%s (%s %s)"):format(ability.name, L.RANK, rankIndex)
  Widgets:Button({
    parent = parent,
    fullWidth = true,
    text = "|cFFFFFFFF" .. title .. "|r",
    height = 34,
    onEnter = function()
      GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
      GameTooltip:SetHyperlink("spell:" .. ability.ranks[rankIndex].spell_id)
      GameTooltip:Show()
    end,
    onLeave = function()
      GameTooltip:Hide()
    end
  })

  self:AddPetLevelGroup(parent, ability, rankIndex)
  self:AddTrainingCostGroup(parent, ability, rankIndex)
  self:AddLearnedByGroup(parent, ability)
  self:AddTameableNPCsGroup(parent, ability, rankIndex)
end

function AbilityGroup:AddPetLevelGroup(parent, ability, rankIndex)
  parent = Widgets:InlineGroup({
    parent = parent,
    title = L.PET_LEVEL,
    fullWidth = true,
  })

  Widgets:Label({
    parent = parent,
    text = ability.ranks[rankIndex].pet_level or 1,
    fullWidth = true
  })
end

function AbilityGroup:AddTrainingCostGroup(parent, ability, rankIndex)
  parent = Widgets:InlineGroup({
    parent = parent,
    title = L.TRAINING_COST,
    fullWidth = true,
  })

  Widgets:Label({
    parent = parent,
    text = ability.ranks[rankIndex].training_cost or 0,
    fullWidth = true
  })
end

function AbilityGroup:AddLearnedByGroup(parent, ability)
  parent = Widgets:InlineGroup({
    parent = parent,
    title = L.LEARNABLE_BY,
    fullWidth = true,
  })

  Widgets:Label({
    parent = parent,
    text = (
        #ability.learned_by > 0 and
            table.concat(ability.learned_by, ", ") or
            L.ALL_PET_FAMILIES
        ),
    fullWidth = true
  })
end

function AbilityGroup:AddTameableNPCsGroup(parent, ability, rankIndex)
  parent = Widgets:InlineGroup({
    parent = parent,
    title = L.TAMEABLE_NPCS,
    fullWidth = true
  })

  local npc_ids = ability.ranks[rankIndex].npc_ids
  if #npc_ids > 0 then
    for _, npc_id in ipairs(npc_ids) do
      local npc = Addon.TameableNPCs[tostring(npc_id)]
      self:AddNPC(parent, npc)
    end
  else
    Widgets:Label({
      parent = parent,
      text = L.NONE,
      fullWidth = true
    })
  end
end

function AbilityGroup:AddNPC(parent, npc)
  if not npc then return end

  local LABEL_S = Colors.Label("%s:") .. " %s"

  parent = Widgets:InlineGroup({
    parent = parent,
    title = Colors.Primary(npc.name),
    fullWidth = true
  })

  -- Level.
  Widgets:Label({
    parent = parent,
    text = LABEL_S:format(L.LEVEL, npc.level_range),
    fullWidth = true
  })

  -- Abilities.
  Widgets:Label({
    parent = parent,
    text = LABEL_S:format(L.ABILITIES, table.concat(npc.abilities, ", ")),
    fullWidth = true
  })

  -- Family.
  Widgets:Label({
    parent = parent,
    text = LABEL_S:format(L.FAMILY, npc.family),
    fullWidth = true
  })

  -- Diet.
  Widgets:Label({
    parent = parent,
    text = LABEL_S:format(L.DIET, npc.diet),
    fullWidth = true
  })

  -- Type.
  Widgets:Label({
    parent = parent,
    text = LABEL_S:format(L.TYPE, npc.type),
    fullWidth = true
  })

  -- Location.
  Widgets:Label({
    parent = parent,
    text = LABEL_S:format(L.LOCATION, npc.location),
    fullWidth = true
  })

  -- "Show on Map" button.
  local b = Widgets:Button({
    parent = parent,
    -- fullWidth = true,
    text = L.SHOW_ON_MAP,
    onClick = function()
      WorldMapFrame:Show()
      WorldMapFrame:SetMapID(npc.ui_map_id)

      PinHelper:Clear()

      for _, coords in pairs(npc.coords) do
        HBDPins:AddWorldMapIconMap(
          Addon,
          PinHelper:Get(npc),
          npc.ui_map_id,
          coords.x * 0.01,
          coords.y * 0.01,
          HBD_PINS_WORLDMAP_SHOW_WORLD
        )
      end
    end,
  })

  if not npc.ui_map_id or #npc.coords == 0 then
    b:SetText(L.MAP_UNAVAILABLE)
    b:SetDisabled(true)
  end
end
