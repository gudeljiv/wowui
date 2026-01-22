local _, Addon = ...
local Colors = Addon:GetModule("Colors")
local L = Addon:GetModule("Locale")
local TameableAbilities = Addon.TameableAbilities
local TameableNPCs = Addon.TameableNPCs

-- Update TameableAbilities with in-game data.
for key, ability in pairs(TameableAbilities) do
  -- Remove unavailable ranks.
  for i = #ability.ranks, 1, -1 do
    local rank = ability.ranks[i]
    if (GetSpellInfo(rank.spell_id) == nil) then
      table.remove(ability.ranks, i)
    end
  end

  -- If ability exists, update its name and icon.
  if #ability.ranks > 0 then
    local name, _, icon = GetSpellInfo(ability.ranks[1].spell_id)
    if type(name) == "string" and type(icon) == "number" then
      ability.name = name
      ability.icon = icon
    else
      TameableAbilities[key] = nil
    end
  else
    TameableAbilities[key] = nil
  end
end

-- Update TameableNPCs with in-game data.
for npc_id, npc in pairs(TameableNPCs) do
  npc.location = C_Map.GetAreaInfo(npc.zone_id)

  if npc.location then
    -- Add `classification` to `level_range`.
    if npc.classification then
      npc.level_range = ("%s (%s)"):format(
        npc.level_range,
        Colors.Highlight(npc.classification)
      )
    end

    -- Add `abilities` table.
    local abilities = {}
    for _, ability in pairs(TameableAbilities) do
      for rankIndex, rank in ipairs(ability.ranks) do
        for _, id in ipairs(rank.npc_ids) do
          if npc_id == tostring(id) then
            abilities[#abilities + 1] = {
              ability.name,
              ("|T%s:0|t %s |cFF9D9D9D(%s %s)|r"):format(
                ability.icon,
                ability.name,
                L.RANK,
                rankIndex
              )
            }
          end
        end
      end
    end
    table.sort(abilities, function(a, b) return a[1] < b[1] end)
    npc.abilities = {}
    for _, v in ipairs(abilities) do npc.abilities[#npc.abilities + 1] = v[2] end
  else
    TameableNPCs[npc_id] = nil
  end
end
