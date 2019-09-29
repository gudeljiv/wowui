
local f = CreateFrame("Frame")
f:SetScript("OnUpdate", function()
  if(AutoCarrot_Disabled) then return end
  if(IsMounted()) then
    local itemId = GetInventoryItemID("player", 13)
    if(itemId) then
      if(itemId ~= 11122) then
        AutoCarrot_trinketId = itemId
        EquipItemByName(11122, 13) -- Carrot on a Stick
      end
    else
      AutoCarrot_trinketId = nil
      EquipItemByName(11122, 13) -- Carrot on a Stick
    end
  else
    local itemId = GetInventoryItemID("player", 13)
    if(itemId) then
      if(itemId ~= 11122) then
        AutoCarrot_trinketId = itemId
      elseif(AutoCarrot_trinketId) then
        EquipItemByName(AutoCarrot_trinketId, 13)
      end
      EquipItemByName(AutoCarrot_trinketId, 13)
    else
      AutoCarrot_trinketId = nil
    end
  end
end)

SLASH_AUTOCARROT1 = "/autocarrot";
SLASH_AUTOCARROT2 = "/ac";
SlashCmdList["AUTOCARROT"] = function(msg)
  AutoCarrot_Disabled = not AutoCarrot_Disabled
  if(AutoCarrot_Disabled) then
    print("|cff00ff00Auto|cffed9121Carrot|cffff0000: disabled")
  else
    print("|cff00ff00Auto|cffed9121Carrot|cff1eff00: enabled")
  end
end

