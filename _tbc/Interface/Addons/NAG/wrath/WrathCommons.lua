--- @module "WrathCommons"
--- Wrath of the Lich King (3.3.5) common utilities and class hooks.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

local _, ns = ...
local Version = ns.Version

if not Version:IsWrath() then return end

--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ HUNTER ============================

--- Updates the stable pets information for the Hunter class.
--- WotLK has a single active pet slot (Call Pet = spell ID 883); no multi-slot stable API.
--- @function ns.HUNTER_UpdateStablePets
--- @usage ns.HUNTER_UpdateStablePets()
function ns.HUNTER_UpdateStablePets()
    -- WotLK Hunter only has 1 active pet (Call Pet 883). No stable slot API like Cata+.
end
