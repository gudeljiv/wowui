local _, A = ...;
A.loaded = false
A.stopAddon = false
local BL = {}
A.bag = 0
A.slot = 0


function A:Print(...)
  DEFAULT_CHAT_FRAME:AddMessage(A.addonName .. "- " .. tostringall(...))
end

A.slashPrefix = "|cff8d63ff/autoopen|r "
A.addonName = "|cff8d63ffAutoOpen|r "

local TYPEID_ARMOR = LE_ITEM_CLASS_ARMOR
local TYPEID_WEAPON = LE_ITEM_CLASS_WEAPON


CreateFrame('GameTooltip', 'AutoOpenTooltip', nil, 'GameTooltipTemplate')
AutoOpenTooltip:SetOwner(UIParent, 'ANCHOR_NONE')
AutoOpenTooltip:ClearLines()


local E = CreateFrame("Frame")
E:RegisterEvent("PLAYER_ENTERING_WORLD")
E:RegisterEvent("ADDON_LOADED")
E:RegisterEvent("BAG_UPDATE")
E:RegisterEvent("MERCHANT_SHOW")
E:RegisterEvent("MERCHANT_CLOSED")
E:RegisterEvent("BANKFRAME_OPENED")
E:RegisterEvent("BANKFRAME_CLOSED")
E:SetScript("OnEvent", function(self, event, ...)
  return self[event] and self[event](self, ...)
end)

--[[
  ADDON LOADING
]]
function E:PLAYER_ENTERING_WORLD(login, reload)
  if A.loaded and (login or reload) and AO_loginMessage then
    print(A.addonName .."loaded")
  end
end

function E:ADDON_LOADED(name)
  if name ~= "AutoOpen" then return end

  A.loaded = true
  AutoOpenBlackList = AutoOpenBlackList or {}
  AO_loginMessage = AO_loginMessage or false
  AutoOpenQuestItems = false

  AOBL = AutoOpenBlackList

  SLASH_AUTOOPEN1= "/autoopen";
  SLASH_AUTOOPEN2= "/ao";
  SlashCmdList.AUTOOPEN = function(msg)
    A:SlashCommand(msg)
  end
end

function A:SlashCommand(args)
  local command, rest = strsplit(" ", args, 2)
  command = command:lower()

  if command == "bl" or command == "blacklist" then
    local itemName = GetItemInfo(rest)

    if AOBL[itemName] then
      AOBL[itemName] = nil
      A:Print(itemName .. " removed from blacklist.")
    else
      AOBL[itemName] = true
      A:Print(itemName .. " added to blacklist.")
    end
  
  elseif command == "login" then
    AO_loginMessage = not AO_loginMessage
    if AO_loginMessage then A:Print("Login message enabled") else A:Print("Login message disabled") end

  elseif command == "quest" then
    AutoOpenQuestItems = not AutoOpenQuestItems
    if AutoOpenQuestItems then A:Print("Auto opening quest items.") else A:Print("Not auto opening quest items.") end

  else
    A:Print("Commands")
    A:Print("/autoopen bl [itemName] - Add [itemName] to blacklist.")
    A:Print("/autoopen login - Toggle login message.")
    A:Print("/autoopen quest - Toggle auto opening of quest items. (diabled by default)")
  end
end

--[[
  MERCHANT
]]
function E:MERCHANT_SHOW()
  A.stopAddon = true
end

function E:MERCHANT_CLOSED()
  A.stopAddon = false
end

--[[
  BANK
]]
function E:BANKFRAME_OPENED()
  A.stopAddon = true
end

function E:BANKFRAME_CLOSED()
  A.stopAddon = false
end

--[[
  BAG UPDATE & CORE FUNCTIONALITY
]]

function A:IsQuestItem(B,S)
  AutoOpenTooltip:ClearLines()
  AutoOpenTooltip:SetBagItem(B, S)
  for i = 1, AutoOpenTooltip:NumLines() do
    local text = _G["AutoOpenTooltipTextLeft"..i]:GetText()

    if string.find(text:lower(), "quest item") then
      return true
    end
  end
  return false
end

function E:BAG_UPDATE(B)
  if A.stopAddon then return end
  if not A.loaded then return end
  if UnitCastingInfo("PLAYER") then
    C_Timer.After(1, function()
      local B = B
      E:BAG_UPDATE(B)
    end)
  end


  --for B = 0, NUM_BAG_SLOTS do
    for S = 1, GetContainerNumSlots(B) do
      local _, _, locked, _, _, lootable, itemLink = GetContainerItemInfo(B, S)
      local itemName = itemLink and string.match(itemLink, "%[(.*)%]") or nil

      if itemLink then
        local typeid = select(12, GetItemInfo(itemLink))
        if typeid ~= TYPEID_ARMOR and typeid ~= TYPEID_WEAPON then
          if lootable and not locked and not string.find(itemLink:lower(), "lockbox") and not string.find(itemLink, "Junkbox") and not AOBL[itemName] then -- make sure its not a lockbox
    
            if A:IsQuestItem(B,S) and not AutoOpenQuestItems then
              return
            end
    
            local autolootDefault = GetCVar("autoLootDefault")
            if autolootDefault then -- autolooting
              if IsModifiedClick(AUTOLOOTTOGGLE) then -- currently holding autoloot mod key
                SetCVar("autoLootDefault", 0) -- swap the autoloot behaviour so it autoloots even with mod key held
                UseContainerItem(B, S)
                SetCVar("autoLootDefault", 1) -- swap back
              else -- not holding autoloot mod key
                UseContainerItem(B, S)
              end
            else -- not autolooting
              SetCVar("autoLootDefault", 1)
              UseContainerItem(B, S)
              SetCVar("autoLootDefault", 0)
            end
            return
          end -- if lootable
        end
      end -- if itemlink
    end
  --end
end
