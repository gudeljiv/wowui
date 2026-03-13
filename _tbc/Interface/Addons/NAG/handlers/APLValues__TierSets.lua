--- @module "APLValues__TierSets"
--- Tier set logic handlers for the NAG addon.
--- This file is part of the handler refactor to improve maintainability and modularity.

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ HEADER LOCALS ============================
-- Lua APIs (WoW optimized where available)
local format = string.format



local sort = table.sort
local concat = table.concat
local type = type

-- ============================ MODULE CACHING (PERFORMANCE) ============================
-- Cache frequently accessed modules to avoid GetModule overhead in hot paths
local StateManager = ns.StateManager

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

--- Checks if a specific tier set is equipped.
--- Determines if the player has at least the specified number of pieces for a given tier set.
--- @param tier string The tier set identifier to check (e.g., "Druid_T30")
--- @param count number The minimum number of pieces required (1-6)
--- @return boolean True if the player has at least 'count' pieces of the specified tier set, false otherwise
--- @see NAG:GetItemTier
--- @usage
-- if NAG:TierSetEquipped("Druid_T30", 4) then
--     print("4-piece Druid T30 bonus active!")
-- elseif NAG:TierSetEquipped("Druid_T30", 2) then
--     print("2-piece Druid T30 bonus active!")
-- end
function NAG:TierSetEquipped(tier, count)
    if not tier or not count then
        self:Warn("TierSetEquipped: Missing required parameters")
        return false
    end

    return StateManager:HasTierCount(tier, count)
end
