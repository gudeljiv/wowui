local ADDON_NAME, Addon = ...
local AceAddon = Addon:GetLibrary("AceAddon")
local Commands = Addon:GetModule("Commands")
local PinHelper = Addon:GetModule("PinHelper")
local UI = Addon:GetModule("UI")

function Commands:Initialize()
  AceAddon:RegisterChatCommand(ADDON_NAME, function(...) self:Handle(...) end)
  self.Initialize = nil
end

function Commands:Handle(...)
  local s = ...

  if type(s) == "string" then
    local cmd = AceAddon:GetArgs(s)
    if cmd == "clear" then
      return PinHelper:Clear()
    end
  end

  UI:Toggle()
end
