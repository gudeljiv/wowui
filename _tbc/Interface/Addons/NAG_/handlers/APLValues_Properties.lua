--- @module "APLValues_Properties"
--- Property-related APL value functions for the NAG addon
---
--- This module provides utility functions for character properties, conditions, and state checking.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold
---
--- luacheck: ignore GetSpellInfo
---

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ HEADER LOCALS ============================

-- Lua APIs (WoW optimized where available)
local format = string.format



-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~


--- Retrieves the input delay from the global settings.
--- @function NAG:InputDelay
--- @return number Input delay in seconds.
--- @usage NAG:InputDelay() >= x
function NAG:InputDelay()
    return self.db.global.inputDelay
end

--- Returns the channel clip delay for the current class/module.
--- @function NAG:ChannelClipDelay
--- @return number The channel clip delay in seconds.
--- @usage NAG:ChannelClipDelay()
function NAG:ChannelClipDelay()
    local classModule = NAG:GetClassModule()
    if classModule then
        return classModule.db.char.channelClipDelay or 0.1
    end
    return 0.1
end

--- Placeholder for checking if the player is in front of the target.
--- @function NAG:FrontOfTarget
--- @return boolean True if the player is in front of the target, false otherwise.
--- @usage NAG:FrontOfTarget()
function NAG:FrontOfTarget()
    -- TODO: Implement logic to check player position relative to target.
    self:Warn("WOW API doesn't allow us to check if the player is in front of the target. Returning true")
    return true -- Assuming true for now.
end
