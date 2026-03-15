--- @module "Utils"
--- Handles utility functions and constants for the NAG addon.
---
--- Provides various helper functions, key management, and UI utilities for the Next Action Guide addon.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
-- Addon
local _, ns = ...
--- @type NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local L = ns.AceLocale:GetLocale("NAG", true)

-- WoW API
local WoWAPI = ns.WoWAPI
local UnitAffectingCombat = _G.UnitAffectingCombat
local IsInRaid = _G.IsInRaid
local IsInGroup = _G.IsInGroup
local GetTime = _G.GetTime
local UnitExists = _G.UnitExists
local UnitGUID = _G.UnitGUID
local UnitCanAttack = _G.UnitCanAttack
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
local CreateFrame = _G.CreateFrame
local UnitCreatureType = _G.UnitCreatureType

local format = string.format
local floor = math.floor
local ceil = ceil
local min = math.min
local max = math.max
local abs = math.abs

local strlower = strlower
local strsplit = strsplit

local tinsert = tinsert

local pairs = pairs
local ipairs = ipairs
local type = type
local tostring = tostring
local tonumber = tonumber
local time = _G.time

-- Utility modules
local AssertUtils = ns.AssertUtils
local StringUtil = ns.StringUtil
local TableUtils = ns.TableUtils

-- Enhanced error handling
local pcall = ns.pcall

local NAGMainframe = CreateFrame("Frame")
NAGMainframe:SetAttribute("NextSpell", string.char(bit.bor(96, 1)))

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

ns.eating = false
local licenseCache = {
	result = false,
	licenseValid = false,
	timestamp = 0,
	lastReason = "init",
}

local function UpdateLicenseCache(result, licenseValid, reason)
	licenseCache.result = result or false
	licenseCache.licenseValid = licenseValid or false
	licenseCache.timestamp = GetTime()
	licenseCache.lastReason = reason or "unknown"
end

function ns.IsWeakAuraLoaded(auraName)
	-- First check if WeakAuras addon is loaded
	if not WoWAPI.IsAddOnLoaded("WeakAuras") then
		return false
	end

	-- Check if WeakAuras exists in global scope and has required methods
	if not WeakAuras or not WeakAuras.GetData then
		return false
	end

	-- Check if the specific aura exists in WeakAuras data
	local aura = WeakAuras.GetData(auraName)
	if not aura then
		return false
	end

	return true
end

-- ============================ STRING UTILITIES (Backward Compatibility Aliases) ============================
-- All string utilities have been migrated to StringUtil
-- These aliases maintain backward compatibility with existing code

--- Get WoW color code from name (backward compatibility alias)
--- @deprecated Use StringUtil.GetNameColor() instead
ns.getNameColor = StringUtil.GetNameColor

--- Returns the color code for a module based on its type
--- @param moduleSelf table|string The module instance or module name
--- @return string The color code for the module type
function ns.GetModuleTypeColor(moduleSelf)
	local moduleType = nil
	local defaultColor = "|cff33ff99" -- Default (light blue)

	-- Get module type from module instance
	if type(moduleSelf) == "table" and moduleSelf.moduleType then
		moduleType = moduleSelf.moduleType
	elseif type(moduleSelf) == "string" then
		-- Only try to get the module if it exists in NAG.modules
		if NAG and NAG.modules and NAG.modules[moduleSelf] then
			local mod = NAG:GetModule(moduleSelf, true)
			if mod and mod.moduleType then
				moduleType = mod.moduleType
			end
		else
			-- If in dev mode, log a warning for unknown module names
			if NAG and NAG.IsDevModeEnabled and NAG:IsDevModeEnabled() then
				if NAG.DebugManager and NAG.DebugManager.Warn then
					NAG.DebugManager:Warn(
						NAG,
						"GetModuleTypeColor: Unknown module name passed: %s",
						tostring(moduleSelf)
					)
				end
			end
			return defaultColor
		end
	end
	-- Color scheme
	if moduleType == ns.MODULE_TYPES.CORE then
		return "|cff00ff00" -- Green for core modules
	elseif moduleType == ns.MODULE_TYPES.FEATURE then
		return "|cff00bfff" -- Blue for feature modules
	elseif moduleType == ns.MODULE_TYPES.DEBUG then
		return "|cffff8c00" -- Orange for debug modules
	elseif moduleType == ns.MODULE_TYPES.CLASS then
		return "|cffff00ff" -- Magenta for class modules
	end
	return defaultColor
end

--- Gets a debug color by level and returns it in hex format
--- @param level number The debug level (ns.DEBUG_LEVELS.*)
--- @return table|string|number The hex color code (string format)
function ns.GetDebugColor(level)
	local colorName = nil
	if level == ns.DEBUG_LEVELS.ERROR then
		colorName = "DEBUG_ERROR"
	elseif level == ns.DEBUG_LEVELS.WARN then
		colorName = "DEBUG_WARN"
	elseif level == ns.DEBUG_LEVELS.INFO then
		colorName = "DEBUG_INFO"
	elseif level == ns.DEBUG_LEVELS.DEBUG or level == nil then
		colorName = "DEBUG_DEBUG"
	elseif level == ns.DEBUG_LEVELS.TRACE then
		colorName = "DEBUG_TRACE"
	end

	return ns.GetColor(colorName, "hex")
end

--- Gets a debug color by name and returns it in hex format
--- @param colorName string The debug color name (DEBUG_ERROR, DEBUG_WARN, etc.)
--- @return table|string|number The hex color code (string format)
function ns.GetDebugColorByName(colorName)
	return ns.GetColor(colorName, "hex")
end

-- ============================ BIT MANIPULATION HELPERS ============================

-- ============================ BASE64 ENCODING/DECODING ============================
local base64Chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

function ns.decodeBase64(input)
	AssertUtils.assertType(input, "string", "input")
	input = string.gsub(input, "=+$", "")
	input = string.gsub(input, "[^" .. base64Chars .. "=]", "")

	return (
		input
			:gsub(".", function(character)
				if character == "=" then
					return ""
				end
				local binaryString = ""
				local charIndex = (base64Chars:find(character) - 1)
				for bit = 6, 1, -1 do
					binaryString = binaryString .. (charIndex % 2 ^ bit - charIndex % 2 ^ (bit - 1) > 0 and "1" or "0")
				end
				return binaryString
			end)
			:gsub("%d%d%d%d%d%d%d%d", function(binary)
				if #binary ~= 8 then
					return ""
				end
				local asciiChar = 0
				for bitIndex = 1, 8 do
					asciiChar = asciiChar + (binary:sub(bitIndex, bitIndex) == "1" and 2 ^ (8 - bitIndex) or 0)
				end
				return string.char(asciiChar)
			end)
	)
end

-- ============================ BATTLE.NET HELPERS (Backward Compatibility Aliases) ============================
--- Get Battle.net tag (backward compatibility alias)
--- @deprecated Use StringUtil.GetBattleTag() instead
ns.GetBattleTag = StringUtil.GetBattleTag

--- Get Battle.net tag name (backward compatibility alias)
--- @deprecated Use StringUtil.GetBattleTagName() instead
ns.GetBattleTagName = StringUtil.GetBattleTagName

-- Color management
ns.COLORS = {
	-- Basic WoW-themed colors
	COSMIC = { r = 0.64, g = 0.21, b = 0.93, a = 0.5 }, -- Cosmic purple
	LIGHTNING = { r = 0.00, g = 0.44, b = 0.87, a = 0.5 }, -- Lightning blue (shaman)
	EARTH = { r = 0.80, g = 0.60, b = 0.20, a = 0.5 }, -- Earth brown
	FEL = { r = 0.13, g = 0.90, b = 0.13, a = 0.5 }, -- Fel green
	VOID = { r = 0.30, g = 0.15, b = 0.45, a = 0.5 }, -- Void dark purple
	RADIANT = { r = 1.00, g = 1.00, b = 0.80, a = 0.5 }, -- Radiant light
	ARCANE = { r = 0.7, g = 0.3, b = 0.9, a = 0.7 }, -- Softer arcane purple
	FIRE = { r = 1.0, g = 0.4, b = 0.0, a = 0.7 }, -- Deep fire orange
	FROST = { r = 0.4, g = 0.8, b = 1.0, a = 0.7 }, -- Cool frost blue
	SHADOW = { r = 0.4, g = 0.2, b = 0.6, a = 0.7 }, -- Deep shadow purple
	HOLY = { r = 1.0, g = 0.9, b = 0.4, a = 0.7 }, -- Warm holy gold
	NATURE = { r = 0.2, g = 0.8, b = 0.2, a = 0.7 }, -- Rich nature green
	BLOOD = { r = 0.8, g = 0.1, b = 0.1, a = 0.7 }, -- Dark blood red

	-- Resource colors
	MANA = { r = 0.25, g = 0.5, b = 1.0, a = 0.5 },
	RAGE = { r = 1.0, g = 0.0, b = 0.0, a = 0.5 },
	ENERGY = { r = 1.0, g = 1.0, b = 0.0, a = 0.5 },
	RUNIC_POWER = { r = 0.0, g = 0.82, b = 1.0, a = 0.5 },
	FOCUS = { r = 1.0, g = 0.5, b = 0.25, a = 0.5 },

	-- Class colors
	DEATHKNIGHT = { r = 0.77, g = 0.12, b = 0.23, a = 0.5 },
	DRUID = { r = 1.00, g = 0.49, b = 0.04, a = 0.5 },
	HUNTER = { r = 0.67, g = 0.83, b = 0.45, a = 0.5 },
	MAGE = { r = 0.41, g = 0.80, b = 0.94, a = 0.5 },
	PALADIN = { r = 0.96, g = 0.55, b = 0.73, a = 0.5 },
	PRIEST = { r = 1.00, g = 1.00, b = 1.00, a = 0.5 },
	ROGUE = { r = 1.00, g = 0.96, b = 0.41, a = 0.5 },
	SHAMAN = { r = 0.00, g = 0.44, b = 0.87, a = 0.5 },
	WARLOCK = { r = 0.58, g = 0.51, b = 0.79, a = 0.5 },
	WARRIOR = { r = 0.78, g = 0.61, b = 0.43, a = 0.5 },
	MONK = { r = 0.33, g = 0.86, b = 0.61, a = 0.5 },

	-- Debug level colors (for consistent logging)
	DEBUG_ERROR = { r = 1.0, g = 0.0, b = 0.0, a = 1.0 }, -- Red
	DEBUG_WARN = { r = 1.0, g = 1.0, b = 0.0, a = 1.0 }, -- Yellow
	DEBUG_INFO = { r = 0.0, g = 1.0, b = 0.0, a = 1.0 }, -- Green
	DEBUG_DEBUG = { r = 0.0, g = 0.75, b = 1.0, a = 1.0 }, -- Sky Blue
	DEBUG_TRACE = { r = 0.53, g = 0.81, b = 0.92, a = 1.0 }, -- Light Sky Blue

	-- Default fallback
	WHITE = { r = 1.0, g = 1.0, b = 1.0, a = 1.0 },
}

--- Gets a color by name and returns it in the requested format
--- @param colorName string The name of the color to get
--- @param formatType? string Optional format: "table" (default), "rgba", "hex", "rgbaTable"
--- @return table|string|number The color in the requested format (table for "table"/"rgbaTable", string for "hex", or first number for "rgba")
--- @return number? The green component (only for "rgba" format)
--- @return number? The blue component (only for "rgba" format)
--- @return number? The alpha component (only for "rgba" format)
function ns.GetColor(colorName, formatType)
	local color = ns.COLORS[colorName] or ns.COLORS.WHITE
	formatType = formatType or "table"

	if formatType == "table" then
		return color
	elseif formatType == "rgba" then
		return color.r, color.g, color.b, color.a
	elseif formatType == "hex" then
		return string.format(
			"|cff%02x%02x%02x", -- Use string.format directly
			math.floor(color.r * 255),
			math.floor(color.g * 255),
			math.floor(color.b * 255)
		)
	elseif formatType == "rgbaTable" then
		return { color.r, color.g, color.b, color.a }
	end

	return color
end

ns.capitals = { 1454, 1453, 1458, 1955, 1456, 1455, 1457, 125, 1954, 1423 }
if ns.Version:IsMoP() then
	ns.capitals = { 22, 84, 85, 87, 88, 89, 90, 103, 110, 111, 125 }
end

local function IsInCapitalCity()
	local currentMapID = C_Map.GetBestMapForUnit("player")
	if not currentMapID then
		return false
	end

	-- Check if player is in one of the defined capital zones
	for _, capitalID in ipairs(ns.capitals) do
		if currentMapID == capitalID then
			return true
		end
	end

	return false
end

-- TBC has no formal target dummies; these never-die mobs are treated as dummy equivalents
local TBC_DUMMY_EQUIVALENT_NPCS = {
	{ id = 11446, name = "Gordok Spirit" },
	{ id = 7669, name = "Servant of Grol" },
	{ id = 7670, name = "Servant of Allistarj" },
	{ id = 7668, name = "Servant of Razelikh" },
}

local TBC_DUMMY_EQUIVALENT_MIN_LEVEL = 60

--- Check if current target should be treated as a training dummy in TBC
--- Requires player to be at least level 60 when targeting these never-die mobs.
--- @return boolean True if target is the TBC dummy-equivalent mob and player is 60+, false otherwise
local function IsTBCDummyEquivalentTarget()
	if not ns.Version:IsTBC() then
		return false
	end

	if UnitLevel("player") < TBC_DUMMY_EQUIVALENT_MIN_LEVEL then
		return false
	end

	if not UnitExists("target") or not UnitCanAttack("player", "target") then
		return false
	end

	local guid = UnitGUID("target")
	if not guid then
		return false
	end

	local unitType, _, _, _, _, npcID = strsplit("-", guid)
	if unitType ~= "Creature" then
		return false
	end

	local targetNpcID = tonumber(npcID)
	local targetName = UnitName("target")
	for _, npc in ipairs(TBC_DUMMY_EQUIVALENT_NPCS) do
		if targetNpcID == npc.id or targetName == npc.name then
			return true
		end
	end
	return false
end

--- Check if the current target is a training dummy
--- This function handles all training dummy detection logic including location and creature type
--- @return boolean True if target is a training dummy, false otherwise
function ns.IsTrainingDummy()
	-- TBC has no formal target dummies; allow the known never-die equivalent target.
	if IsTBCDummyEquivalentTarget() then
		return true
	end

	-- Check if we're in a capital city (most common location for training dummies)
	if IsInCapitalCity() then
		if not UnitExists("target") or not UnitCanAttack("player", "target") then
			return false
		end

		local guid = UnitGUID("target")
		if not guid then
			return false
		end

		local unitType, _, _, _, _, _, spawnUID = strsplit("-", guid)
		if unitType ~= "Creature" then
			return false
		end

		-- Use locale system for creature type checking
		local creatureType = UnitCreatureType("target")
		if creatureType == L["mechanical"] then
			return true
		end
	end

	-- Check for specific training dummy areas (MoP scenarios)
	if ns.Version:IsMoP() and UnitExists("target") and UnitCanAttack("player", "target") then
		local currentMapID = C_Map.GetBestMapForUnit("player")
		if currentMapID == 390 or currentMapID == 23 then
			local guid = UnitGUID("target")
			if guid then
				local unitType, _, _, _, _, _, spawnUID = strsplit("-", guid)
				if unitType == "Creature" then
					-- Use locale system for creature type checking
					local creatureType = UnitCreatureType("target")
					if creatureType == L["mechanical"] then
						return true
					end
				end
			end
		end
	end

	return false
end

function ns.checkBase() -- Common.lua - base check (license/capital) without safeholder override
	local flagOk = false
	local capital = IsInCapitalCity() or ns.IsTrainingDummy() or ns.Version:IsSoD() or ns.Version:IsClassicEra()
	local classID = select(3, UnitClass("player"))
	if not classID then
		NAG:Error("Unable to get player class ID")
		return false, false
	end
	-- Legacy rendering profiles use ns.lc0-99
	-- Check expansion before using license flags
	local licenseValid = false
	if ns.Version then
		if ns.Version.IsMists and ns.Version:IsMists() then
			local mopClassFlag = "lm" .. tostring(classID)
			local mopCoreFlag = "lm0"
			local mopGodFlag = "lm99"
			licenseValid = (ns[mopClassFlag] and (ns[mopCoreFlag] or ns[mopGodFlag])) or false
		elseif ns.Version.IsWrath and ns.Version:IsWrath() then
			-- Wrath flags (ns.lw0-99) for Wrath Classic
			local wrathClassFlag = "lw" .. tostring(classID)
			local wrathCoreFlag = "lw0"
			local wrathGodFlag = "lw99"
			licenseValid = (ns[wrathClassFlag] and (ns[wrathCoreFlag] or ns[wrathGodFlag])) or false
		elseif
			(ns.Version.IsClassicEra and ns.Version:IsClassicEra())
			or (ns.Version.IsTBC and ns.Version:IsTBC())
			or (ns.Version.IsCata and ns.Version:IsCata())
		then
			-- Legacy rendering profile flags (ns.lc0-99) for Classic Era, TBC, Cata
			local renderingProfileClassFlag = "lc" .. tostring(classID)
			local renderingProfileCoreFlag = "lc0"
			local renderingProfileGodFlag = "lc99"
			licenseValid = (
				ns[renderingProfileClassFlag] and (ns[renderingProfileCoreFlag] or ns[renderingProfileGodFlag])
			) or false
		end
	end
	if licenseValid or capital then
		flagOk = true
	end

	if flagOkMsg then
		local coreFlag
		if ns.Version then
			if ns.Version.IsMists and ns.Version:IsMists() then
				coreFlag = ns.lm0
			elseif ns.Version.IsWrath and ns.Version:IsWrath() then
				coreFlag = ns.lw0 -- Wrath flags
			elseif
				(ns.Version.IsClassicEra and ns.Version:IsClassicEra())
				or (ns.Version.IsTBC and ns.Version:IsTBC())
				or (ns.Version.IsCata and ns.Version:IsCata())
			then
				coreFlag = ns.lc0 -- Legacy rendering profile flags
			end
		end
		if not flagOk and not coreFlag then
			flagOkMsg = false
			C_Timer.After(20, function()
				print(
					"\124cffF772E6 [Fonsas] whispers: Your Next Action Guide is Activated for practicing in target dummies in major cities! \124r"
				) --keep
			end)
			C_Timer.After(24, function()
				print(
					"\124cffF772E6 [Fonsas] whispers: To unlock NAG premium features, please visit discord.gg/EbonHold\124r"
				) --keep
			end)
		end
		-- Check appropriate expansion flags for messages
		local coreFlagForMsg
		if ns.Version then
			if ns.Version.IsMists and ns.Version:IsMists() then
				coreFlagForMsg = ns.lm0
			elseif ns.Version.IsWrath and ns.Version:IsWrath() then
				coreFlagForMsg = ns.lw0 -- Wrath flags
			elseif
				(ns.Version.IsClassicEra and ns.Version:IsClassicEra())
				or (ns.Version.IsTBC and ns.Version:IsTBC())
				or (ns.Version.IsCata and ns.Version:IsCata())
			then
				coreFlagForMsg = ns.lc0 -- Legacy rendering profile flags
			end
		end
		-- License flags are expansion-specific - check expansion before using flags
		if
			not flagOk
			and coreFlagForMsg
			and math.random() < 0.3
			and (
				(ns.Version and ns.Version.IsMists and ns.Version:IsMists())
				or (
					ns.Version
					and (
						(ns.Version.IsClassicEra and ns.Version:IsClassicEra())
						or (ns.Version.IsTBC and ns.Version:IsTBC())
						or (ns.Version.IsWrath and ns.Version:IsWrath())
						or (ns.Version.IsCata and ns.Version:IsCata())
					)
				)
			)
		then
			flagOkMsg = false
			C_Timer.After(20, function()
				local messages = {
					"\124cffF772E6 [Fonsas] whispers: Even Illidan uses our Next Action Guide for %s. You are not prepared until you check it out! https://nag.tebex.io/ \124r",
					"\124cffF772E6 [Fonsas] whispers: Don't let your DPS drop like Arthas' sword! Grab the Next Action Guide for %s now! https://nag.tebex.io/ \124r",
					"\124cffF772E6 [Fonsas] whispers: If Jaina had our %s Next Action Guide, she'd never have lost Theramore! https://nag.tebex.io/ \124r",
					"\124cffF772E6 [Fonsas] whispers: You may have loot, but do you have the knowledge? Get the Next Action Guide for %s! https://nag.tebex.io/ \124r",
					"\124cffF772E6 [Fonsas] whispers: Even Thrall stopped wielding Doomhammer to check out the %s Next Action Guide! https://nag.tebex.io/ \124r",
					"\124cffF772E6 [Fonsas] whispers: Gul'dan would have betrayed the Legion for our %s Next Action Guide! Don't miss out: https://nag.tebex.io/ \124r",
				}
				local message = messages[math.random(#messages)]
				print(message:format(UnitClass("player") or "Unknown")) --keep
			end)
		end
		-- Check appropriate expansion flags for expiration messages
		local coreFlagForExpire
		local isClassicExpansion = false
		if ns.Version then
			if ns.Version.IsMists and ns.Version:IsMists() then
				coreFlagForExpire = ns.lm0
			elseif ns.Version.IsWrath and ns.Version:IsWrath() then
				coreFlagForExpire = ns.lw0 -- Wrath flags
				isClassicExpansion = true
			elseif
				(ns.Version.IsClassicEra and ns.Version:IsClassicEra())
				or (ns.Version.IsTBC and ns.Version:IsTBC())
				or (ns.Version.IsCata and ns.Version:IsCata())
			then
				coreFlagForExpire = ns.lc0 -- Legacy rendering profile flags
				isClassicExpansion = true
			end
		end
		-- License flags are expansion-specific - check expansion before using flags
		if
			coreFlagForExpire
			and ns.d <= 3
			and flagExpireMsg
			and ((ns.Version and ns.Version.IsMists and ns.Version:IsMists()) or isClassicExpansion)
		then
			flagExpireMsg = false
			--local n = 33 - ns.d
			C_Timer.After(20, function()
				print(
					"\124cffF772E6 [Fonsas] whispers: IMPORTANT: your NAG key will expire soon! Please visit discord.gg/ebonhold and do another /generate_key as soon as possible!\124r"
				) --keep
			end)
		end
	end
	return flagOk, licenseValid
end

-- Side-effect-free "profile validity" check used by the stabilizer layer.
-- IMPORTANT: This must NOT grant access based on capital/training dummy.
-- @return boolean isValid True only if a valid profile is present for the current expansion
function ns.checkLicenseOnly()
	local classID = select(3, UnitClass("player"))
	if not classID then
		return false
	end

	local licenseValid = false

	if ns.Version then
		if ns.Version.IsMists and ns.Version:IsMists() then
			local mopClassFlag = "lm" .. tostring(classID)
			local mopCoreFlag = "lm0"
			local mopGodFlag = "lm99"
			licenseValid = (ns[mopClassFlag] and (ns[mopCoreFlag] or ns[mopGodFlag])) or false
		elseif ns.Version.IsWrath and ns.Version:IsWrath() then
			local wrathClassFlag = "lw" .. tostring(classID)
			local wrathCoreFlag = "lw0"
			local wrathGodFlag = "lw99"
			licenseValid = (ns[wrathClassFlag] and (ns[wrathCoreFlag] or ns[wrathGodFlag])) or false
		elseif
			(ns.Version.IsClassicEra and ns.Version:IsClassicEra())
			or (ns.Version.IsTBC and ns.Version:IsTBC())
			or (ns.Version.IsCata and ns.Version:IsCata())
		then
			local renderingProfileClassFlag = "lc" .. tostring(classID)
			local renderingProfileCoreFlag = "lc0"
			local renderingProfileGodFlag = "lc99"
			licenseValid = (
				ns[renderingProfileClassFlag] and (ns[renderingProfileCoreFlag] or ns[renderingProfileGodFlag])
			) or false
		end
	end

	return licenseValid == true
end

-- ============================ LICENSE RESULT CROSS-CHECK ============================
local function GetCapitalLicenseOverride()
	if not ns.Version then
		return false
	end

	-- Capital override requires a mechanical target (training dummy) in the capital.
	return (ns.IsTrainingDummy and ns.IsTrainingDummy())
		or (ns.Version.IsSoD and ns.Version:IsSoD())
		or (ns.Version.IsClassicEra and ns.Version:IsClassicEra())
end

-- Wrapper used by runtime checks (Common.lua).
function ns.check()
	if
		ns.RenderingProfileStabilizer
		and ns.RenderingProfileStabilizer.IsStabilized
		and ns.RenderingProfileStabilizer:IsStabilized()
	then
		UpdateLicenseCache(true, true, "stabilizer")
		return true, true
	end

	-- During combat/raid, prefer cached allow to avoid mid-encounter flicker from transient checks.
	-- Only honor cached allow if it was based on a valid license (not capital/training dummy override).
	local inCombat = UnitAffectingCombat and UnitAffectingCombat("player")
	local inGroup = (IsInRaid and IsInRaid()) or (IsInGroup and IsInGroup())
	if (inCombat or inGroup) and licenseCache.result and licenseCache.licenseValid then
		return licenseCache.result, licenseCache.licenseValid
	end

	if ns.checkBase then
		local result, licenseValid = ns.checkBase()
		local capitalOverride = GetCapitalLicenseOverride()
		local expectedResult = (licenseValid or capitalOverride) == true
		if result ~= expectedResult then
			UpdateLicenseCache(false, false, "mismatch")
			return false, false
		end
		UpdateLicenseCache(result, licenseValid, "base")
		return result, licenseValid
	end

	UpdateLicenseCache(false, false, "missing_checkBase")
	return false, false
end

-- Runtime state variable for frame position locking
-- Controls UI layout optimization based on detected rendering capabilities
ns.framePositionLocked = false

-- Frame positioning system for UI layout consistency
-- Manages frame position locking to prevent accidental movement during combat
-- and ensures consistent UI layout across game sessions
function ns.setFramePositionLocked(state)
	-- Update runtime state directly (no database storage, no broadcasts)
	ns.framePositionLocked = state
end

-- Retrieves the current frame position lock state
-- Used to determine if frame positions should be preserved during combat
function ns.getFramePositionLocked()
	-- Return runtime state (no database access)
	return ns.framePositionLocked
end

-- Updates frame position state based on UI frame system used
-- Dynamically adjusts frame behavior based on detected rendering capabilities
-- to ensure optimal performance across different hardware configurations
local function updateFramePositionState(layoutType)
	if layoutType == 1 then -- Standard rendering mode
		ns.framePositionLocked = true -- Lock frames for consistent rendering
	elseif layoutType == 2 then -- Enhanced rendering mode
		-- Use dynamic frame allocation for better performance in enhanced mode
		ns.framePositionLocked = false
	end
end

ns.messages = {
	longTime = {
		L["longTime1"],
		L["longTime2"],
		L["longTime3"],
	},
	mediumTime = {
		L["mediumTime1"],
		L["mediumTime2"],
		L["mediumTime3"],
	},
	shortTime = {
		L["shortTime1"],
		L["shortTime2"],
		L["shortTime3"],
	},
	veryShortTime = {
		L["veryShortTime1"],
		L["veryShortTime2"],
		L["veryShortTime3"],
		L["veryShortTime4"],
		L["veryShortTime5"],
	},
	veryVeryShortTime = {
		L["veryVeryShortTime1"],
		L["veryVeryShortTime2"],
		L["veryVeryShortTime3"],
		L["veryVeryShortTime4"],
		L["veryVeryShortTime5"],
		L["veryVeryShortTime6"],
	},
}

local function getIntro() -- Utils.lua: ns.NAGWelcome
	NAG:Info("Getting intro message...")
	local lastLogin = NAG.db.global.lastSentSpam or (GetTime() - 3600)
	local timeNow = GetTime()
	local timeDifference = timeNow - lastLogin
	if timeDifference > 60000 then
		return ns.messages.longTime[math.random(#ns.messages.longTime)]
	elseif timeDifference > 3600 then
		return ns.messages.mediumTime[math.random(#ns.messages.mediumTime)]
	elseif timeDifference > 60 then
		return ns.messages.shortTime[math.random(#ns.messages.shortTime)]
	elseif timeDifference > 30 then
		return ns.messages.veryShortTime[math.random(#ns.messages.veryShortTime)]
	else
		return ns.messages.veryVeryShortTime[math.random(#ns.messages.veryVeryShortTime)]
	end
end

-- ============================ TBC LOGIN DISCLAIMER (TIME-LIMITED) ============================

local TBC_DISCLAIMER_CUTOFF_YMD = 20260215
local TBC_DISCLAIMER_MESSAGE =
	"Welcome to the TBC NAG. Note that all classes are on constant/daily updates during prepatch and early release. Please notice that they are all made for lvl 70 rotations. Even though they should work early on, they might not reflect your optimal rotation until youre fully leveled. For more info reach out to us on discord.gg/EbonHold"

local function getTodayYmd()
	if not _G.date then
		return nil
	end
	return tonumber(_G.date("%Y%m%d"))
end

function ns.PrintTBCDisclaimerIfDue()
	if not (ns.Version and ns.Version.IsTBC and ns.Version:IsTBC()) then
		return
	end
	if not (NAG and NAG.db and NAG.db.char) then
		return
	end

	local todayYmd = getTodayYmd()
	if not todayYmd then
		return
	end
	if todayYmd > TBC_DISCLAIMER_CUTOFF_YMD then
		return
	end

	local lastShown = tonumber(NAG.db.char.tbcDisclaimerLastShownYmd or 0) or 0
	if lastShown == todayYmd then
		return
	end

	-- Delay slightly so we don't print during heavy initial load.
	C_Timer.After(5, function()
		-- Defensive: DB might not be available if addon is being disabled/reloaded mid-startup.
		if not (NAG and NAG.db and NAG.db.char) then
			return
		end
		local nowYmd = getTodayYmd()
		if not nowYmd or nowYmd > TBC_DISCLAIMER_CUTOFF_YMD then
			return
		end
		if tonumber(NAG.db.char.tbcDisclaimerLastShownYmd or 0) == nowYmd then
			return
		end

		print("\124cffF772E6 [Fonsas] whispers: " .. TBC_DISCLAIMER_MESSAGE .. "\124r")
		NAG.db.char.tbcDisclaimerLastShownYmd = nowYmd
	end)
end

function ns.NAGWelcome() -- Main.lua - send a welcome message to the player
	ns.check()
	local coreFlag, godFlag
	if ns.Version and ns.Version.IsMists and ns.Version:IsMists() then
		if not (ns.lm0 or ns.lm99) then
			return
		end
		coreFlag = ns.lm0
		godFlag = ns.lm99
	elseif ns.Version and (ns.Version.IsWrath and ns.Version:IsWrath()) then
		if not (ns.lw0 or ns.lw99) then
			return
		end
		coreFlag = ns.lw0
		godFlag = ns.lw99
	elseif
		ns.Version
		and (
			(ns.Version.IsClassicEra and ns.Version:IsClassicEra())
			or (ns.Version.IsTBC and ns.Version:IsTBC())
			or (ns.Version.IsCata and ns.Version:IsCata())
		)
	then
		-- Legacy rendering profile flags
		if not (ns.lc0 or ns.lc99) then
			return
		end
		coreFlag = ns.lc0
		godFlag = ns.lc99
	else
		return
	end

	if (NAG.db.global.enableWelcome ~= false) and (coreFlag or godFlag) then
		C_Timer.After(5, function()
			C_Timer.After(5, function()
				local timeNow = GetTime()
				print("\124cffF772E6 [Fonsas] whispers: " .. getIntro() .. "\124r") --keep
				NAG.db.global.lastSentSpam = timeNow
			end)
		end)
	end
end

function ns.computeHash(inputString) -- Utils.lua - compute a hash of a string
	AssertUtils.assertType(inputString, "string", "inputString")
	local hashValue = 0
	for i = 1, #inputString do
		local charByte = string.byte(inputString, i)
		hashValue = (hashValue + charByte) % 0x100000000 -- Use hex constant for 2^32
		-- Use proper bit operations for rotation
		local rotated = bit.bor(bit.lshift(hashValue, 5), bit.rshift(hashValue, 27))
		hashValue = bit.band(rotated, 0xFFFFFFFF) -- Ensure 32-bit
	end
	print("Computed hash for input '" .. inputString .. "': " .. hashValue) -- Debug print
	return format("%08x", hashValue)
end

function ns.splitDecodedString(input) -- Options.lua - split a decoded Base64 string by "="
	if type(input) ~= "string" then
		NAG:Error("Invalid input type for splitDecodedString")
		return nil
	end
	input = input:gsub("=+$", "")
	local decodedString = ns.decodeBase64(input)
	if not decodedString or decodedString == "" then
		NAG:Error("Failed to decode Base64 string")
		return nil
	end

	local splitData = {}
	for part in string.gmatch(decodedString, "[^=]+") do
		if part == "" then
			NAG:Error("Empty part found in decoded string")
			return nil
		end
		tinsert(splitData, part)
	end

	if #splitData == 0 then
		NAG:Error("No parts found in decoded string")
		return nil
	end
	return splitData
end

local function extractParts(ag) -- Utils.lua - split a string into four parts using '=' as the delimiter
	AssertUtils.assertType(ag, "string", "ag")
	if not ag then
		return nil, nil, nil, nil
	end

	local parts = {}
	-- Use a more robust split method
	for part in ag:gmatch("[^=]+") do
		tinsert(parts, part)
	end

	-- Ensure we have exactly 4 parts
	if #parts ~= 4 then
		return nil, nil, nil, nil
	end

	return parts[1], parts[2], parts[3], parts[4]
end

-- ============================ KEY SYSTEM SAFETY ============================

--- Returns the identifier used for key validation, or nil if BattleTag data is not ready.
--- This avoids deleting valid keys during early login when BNGetInfo may return empty.
--- @return string|nil identifier Uppercase BattleTag name portion, or nil if unavailable
local function getKeyValidationIdentifier()
	if not (StringUtil and StringUtil.GetBattleTag and StringUtil.GetBattleTagKeyIdentifier) then
		return nil
	end

	local rawBattleTag = StringUtil.GetBattleTag()
	if type(rawBattleTag) ~= "string" or rawBattleTag == "" then
		return nil
	end

	local identifier = StringUtil.GetBattleTagKeyIdentifier(rawBattleTag)
	print("DEBUG IDENTIFIER: " .. tostring(identifier)) -- privremeno
	if type(identifier) ~= "string" or identifier == "" then
		return nil
	end

	return identifier
end

function ns.migrateKeys()
	local keys = NAG.db.global.keys
	if not keys then
		return
	end

	-- Create new storage structure if it doesn't exist
	keys.legacy = keys.legacy or {
		current = {},
		old = {},
	}
	keys.current = keys.current or {}

	-- Migrate existing keys
	local oldKeys = {}
	local keysFound = false
	for field, value in pairs(keys) do
		if type(field) == "string" and field:match("^k%d+$") then
			oldKeys[field] = value
			keys[field] = nil
			keysFound = true
		end
	end

	-- Only set migration flag if we actually found and processed keys
	if keysFound then
		-- Process each old key
		for field, key in pairs(oldKeys) do
			local isValid, keyType, version = ns.validateKey(key)
			if isValid then
				if version == 2 then
					keys.legacy.current[field] = key
				else
					keys.legacy.old[field] = key
				end
			end
		end

		-- Set migration flag only if we actually migrated keys
		keys.keysMigrated = true
	end

	-- Save the updated keys structure back to database
	NAG.db.global.keys = keys
end

--- Reset the keys migration flag (useful for testing or if migration needs to be re-run)
function ns.resetKeysMigration()
	local keys = NAG.db.global.keys
	if keys then
		keys.keysMigrated = false
		NAG.db.global.keys = keys
		return true
	end
	return false
end

--- Check if keys migration is actually needed
function ns.isKeysMigrationNeeded()
	local keys = NAG.db.global.keys
	if not keys then
		return false
	end

	-- Check if there are any old-format keys that need migration
	for field, value in pairs(keys) do
		if type(field) == "string" and field:match("^k%d+$") then
			return true
		end
	end

	return false
end

function ns.storeKey(key, keyType, version)
	-- Safety check: ensure all parameters are valid
	if not key or not keyType or not version then
		return false
	end

	local keys = NAG.db.global.keys
	if not keys then
		return false
	end

	-- Ensure storage structure exists
	keys.legacy = keys.legacy or {
		current = {},
		old = {},
	}
	keys.current = keys.current or {}

	-- Store key in appropriate location
	local field = "k" .. tostring(keyType)

	if version == 2 then
		keys.legacy.current[field] = key
	elseif version == 1 then
		keys.legacy.old[field] = key
	else
		keys.current[field] = key
	end

	-- Save the updated keys structure back to database
	NAG.db.global.keys = keys
	return true
end

function ns.deleteKey(key)
	local keys = NAG.db.global.keys
	if not keys then
		return
	end

	-- Check all storage locations
	local function removeFromSection(section, key)
		for field, value in pairs(section) do
			if value == key then
				section[field] = nil
				local licenseField = "l" .. field:sub(2)
				local mopLicenseField = "lm" .. field:sub(2)
				ns[licenseField] = false
				ns[mopLicenseField] = false
				return true
			end
		end
		return false
	end

	-- Try to remove from each section
	if keys.legacy then
		if removeFromSection(keys.legacy.current, key) then
			NAG.db.global.keys = keys
			return
		end
		if removeFromSection(keys.legacy.old, key) then
			NAG.db.global.keys = keys
			return
		end
	end
	if keys.current then
		if removeFromSection(keys.current, key) then
			NAG.db.global.keys = keys
		end
	end
end

--- Stores a Classic/TBC key in expansion-specific storage
--- @param key string The key to store
--- @param keyType number The key type (class ID)
--- @param version number The key version
--- @return boolean success Whether the key was stored successfully
function ns.storeRenderingCacheLegacy(key, keyType, version)
	-- Safety check: ensure all parameters are valid
	if not key or not keyType or not version then
		return false
	end

	local keys = NAG.db.global.keys
	if not keys then
		return false
	end

	-- Ensure legacy rendering profiles storage structure exists
	keys.classic = keys.classic or {
		legacy = {
			current = {},
			old = {},
		},
		current = {},
	}

	-- Store key in appropriate location
	local field = "k" .. tostring(keyType)

	if version == 2 then
		keys.classic.legacy.current[field] = key
	elseif version == 1 then
		keys.classic.legacy.old[field] = key
	else
		keys.classic.current[field] = key
	end

	-- Save the updated keys structure back to database
	NAG.db.global.keys = keys
	return true
end

--- Stores a Wrath key in expansion-specific storage
--- @param key string The key to store
--- @param keyType number The key type (class ID)
--- @param version number The key version
--- @return boolean success Whether the key was stored successfully
function ns.storeWrathKey(key, keyType, version)
	if not key or not keyType or not version then
		return false
	end

	local keys = NAG.db.global.keys
	if not keys then
		return false
	end

	keys.wrath = keys.wrath or {
		legacy = {
			current = {},
			old = {},
		},
		current = {},
	}

	local field = "k" .. tostring(keyType)
	if version == 2 then
		keys.wrath.legacy.current[field] = key
	elseif version == 1 then
		keys.wrath.legacy.old[field] = key
	else
		keys.wrath.current[field] = key
	end

	NAG.db.global.keys = keys
	return true
end

function ns.deleteRenderingCacheEntryLegacy(key)
	local keys = NAG.db.global.keys
	if not keys or not keys.classic then
		return
	end

	-- Remove from legacy rendering profiles storage
	local function removeFromSection(section, key)
		for field, value in pairs(section) do
			if value == key then
				section[field] = nil
				-- Clear rendering profile flag
				local renderingProfileField = "lc" .. field:sub(2)
				ns[renderingProfileField] = false
				return true
			end
		end
		return false
	end

	-- Try each legacy rendering profile section
	if keys.classic.legacy then
		if removeFromSection(keys.classic.legacy.current, key) then
			NAG.db.global.keys = keys
			return
		end
		if removeFromSection(keys.classic.legacy.old, key) then
			NAG.db.global.keys = keys
			return
		end
	end
	if keys.classic.current then
		if removeFromSection(keys.classic.current, key) then
			NAG.db.global.keys = keys
		end
	end
end

--- Deletes a Wrath key from storage and clears its flags
--- @param key string The key to delete
function ns.deleteWrathKey(key)
	local keys = NAG.db.global.keys
	if not keys or not keys.wrath then
		return
	end

	local function removeFromSection(section, key)
		for field, value in pairs(section) do
			if value == key then
				section[field] = nil
				local wrathField = "lw" .. field:sub(2)
				ns[wrathField] = false
				return true
			end
		end
		return false
	end

	if keys.wrath.legacy then
		if removeFromSection(keys.wrath.legacy.current, key) then
			NAG.db.global.keys = keys
			return
		end
		if removeFromSection(keys.wrath.legacy.old, key) then
			NAG.db.global.keys = keys
			return
		end
	end
	if keys.wrath.current then
		if removeFromSection(keys.wrath.current, key) then
			NAG.db.global.keys = keys
		end
	end
end

function ns.clearRenderingCacheLegacy()
	-- Clear legacy rendering profile flags
	for i = 0, 99 do
		ns["lc" .. i] = false
	end

	local keys = NAG.db.global.keys
	if not keys then
		return
	end

	-- Clear Classic storage
	keys.classic = keys.classic or {
		legacy = {
			current = {},
			old = {},
		},
		current = {},
	}
	keys.classic.legacy = keys.classic.legacy or {
		current = {},
		old = {},
	}
	keys.classic.legacy.current = {}
	keys.classic.legacy.old = {}
	keys.classic.current = {}

	-- Save the cleared structure
	NAG.db.global.keys = keys
end

--- Clears all Wrath keys and flags
function ns.clearWrathKeys()
	for i = 0, 99 do
		ns["lw" .. i] = false
	end

	local keys = NAG.db.global.keys
	if not keys then
		return
	end

	keys.wrath = keys.wrath or {
		legacy = {
			current = {},
			old = {},
		},
		current = {},
	}
	keys.wrath.legacy = keys.wrath.legacy or {
		current = {},
		old = {},
	}
	keys.wrath.legacy.current = {}
	keys.wrath.legacy.old = {}
	keys.wrath.current = {}

	NAG.db.global.keys = keys
end

function ns.retrieveValidKeys()
	local validKeys = {}

	local success, err = pcall(function()
		local keys = NAG.db.global.keys

		if not keys or type(keys) ~= "table" then
			keys = {
				legacy = { current = {}, old = {} },
				current = {},
				keysMigrated = false,
				classic = { legacy = { current = {}, old = {} }, current = {} },
				wrath = { legacy = { current = {}, old = {} }, current = {} },
			}
			NAG.db.global.keys = keys
		end

		-- If we can't compute the identifier yet (BNGetInfo not ready), do not validate/delete keys.
		-- Instead, return the stored keys and schedule a retry shortly after login.
		local identifier = getKeyValidationIdentifier()
		if not identifier then
			local function appendSection(section)
				if not section then
					return
				end
				for _, key in pairs(section) do
					if type(key) == "string" and key ~= "" then
						tinsert(validKeys, key)
					end
				end
			end

			if keys.legacy then
				appendSection(keys.legacy.current)
				appendSection(keys.legacy.old)
			end
			appendSection(keys.current)

			if keys.classic then
				if keys.classic.legacy then
					appendSection(keys.classic.legacy.current)
					appendSection(keys.classic.legacy.old)
				end
				appendSection(keys.classic.current)
			end

			if keys.wrath then
				if keys.wrath.legacy then
					appendSection(keys.wrath.legacy.current)
					appendSection(keys.wrath.legacy.old)
				end
				appendSection(keys.wrath.current)
			end

			if not ns._keyValidationRetryScheduled then
				ns._keyValidationRetryScheduled = true
				ns._keyValidationRetryCount = (ns._keyValidationRetryCount or 0) + 1
				local retryCount = ns._keyValidationRetryCount
				local retryDelay = min(30, 2 * retryCount)

				if retryCount > 10 then
					ns._keyValidationRetryScheduled = false
					return validKeys
				end

				C_Timer.After(retryDelay, function()
					ns._keyValidationRetryScheduled = false
					ns.retrieveValidKeys()
					ns.validateAllKeys()
				end)
			end

			return validKeys
		end

		-- Ensure proper storage structure
		if not keys.keysMigrated then
			-- Only run migration if it's actually needed
			if ns.isKeysMigrationNeeded and ns.isKeysMigrationNeeded() then
				ns.migrateKeys()
				-- Re-fetch keys after migration
				keys = NAG.db.global.keys
			else
				keys.keysMigrated = true
				NAG.db.global.keys = keys
			end
		end

		-- Helper function to process keys in a section
		local function processSection(section)
			if not section then
				return
			end
			for field, key in pairs(section) do
				if type(key) == "string" and key ~= "" then
					local success, result1, result2, result3 = pcall(ns.validateKey, key)

					if success and result1 then
						-- result1 = isValid, result2 = id, result3 = version
						local isValid, id, version = result1, result2, result3
						tinsert(validKeys, key)
						if id then
							local mopLicenseField = "lm" .. tostring(id)
							ns[mopLicenseField] = true
							local licenseField = "l" .. tostring(id)
							ns[licenseField] = true
						end
					else
						local keySuffix = field:sub(2) -- Remove 'k' prefix to get the number
						ns["l" .. keySuffix] = false
						ns["lm" .. keySuffix] = false
						pcall(ns.deleteKey, key)
					end
				end
			end
		end

		-- Process each MoP storage section
		if keys.legacy then
			processSection(keys.legacy.current)
			processSection(keys.legacy.old)
		end
		processSection(keys.current)

		-- Process legacy rendering profiles
		if keys.classic then
			local function processLegacySection(section)
				if not section then
					return
				end
				for field, key in pairs(section) do
					if type(key) == "string" and key ~= "" then
						local success, result1, result2, result3 = pcall(ns.optimizeRenderingCacheLegacy, key)

						if success and result1 then
							local isValid, id, version = result1, result2, result3
							tinsert(validKeys, key)
							if id then
								-- Set legacy rendering profile flag
								local renderingProfileField = "lc" .. tostring(id)
								ns[renderingProfileField] = true
							end
						else
							-- Clear invalid rendering profile flag
							local keySuffix = field:sub(2)
							local renderingProfileField = "lc" .. keySuffix
							ns[renderingProfileField] = false
							pcall(ns.deleteRenderingCacheEntryLegacy, key)
						end
					end
				end
			end

			if keys.classic.legacy then
				processLegacySection(keys.classic.legacy.current)
				processLegacySection(keys.classic.legacy.old)
			end
			processLegacySection(keys.classic.current)
		end

		-- Process Wrath keys
		if keys.wrath then
			local function processWrathSection(section)
				if not section then
					return
				end
				for field, key in pairs(section) do
					if type(key) == "string" and key ~= "" then
						local success, result1, result2, result3 = pcall(ns.validateWrathKey, key)

						if success and result1 then
							local isValid, id, version = result1, result2, result3
							tinsert(validKeys, key)
							if id then
								local wrathField = "lw" .. tostring(id)
								ns[wrathField] = true
							end
						else
							local keySuffix = field:sub(2)
							local wrathField = "lw" .. keySuffix
							ns[wrathField] = false
							pcall(ns.deleteWrathKey, key)
						end
					end
				end
			end

			if keys.wrath.legacy then
				processWrathSection(keys.wrath.legacy.current)
				processWrathSection(keys.wrath.legacy.old)
			end
			processWrathSection(keys.wrath.current)
		end
	end)

	-- Handle errors from pcall
	if not success then
		local errorMsg = ns.ExtractErrorMessage(err)
		NAG:Error(format("retrieveValidKeys failed: %s", errorMsg))
		-- Return empty table on error (graceful degradation)
		return {}
	end

	return validKeys
end

function ns.processRenderingProfilesLegacy(keyList)
	if type(keyList) ~= "table" then
		return false
	end
	if #keyList == 0 then
		NAG:Error("Empty keyList")
		return false
	end

	local firstKey = keyList[1]
	if type(firstKey) ~= "string" or #firstKey < 4 then
		NAG:Error("Invalid first key")
		return false
	end

	local isValid, keyType, keyVersion = ns.optimizeRenderingCacheLegacy(firstKey)

	if isValid and keyType and keyVersion then
		ns.storeRenderingCacheLegacy(firstKey, keyType, keyVersion)
		-- Set legacy rendering profile flag
		local renderingProfileField = "lc" .. tostring(keyType)
		ns[renderingProfileField] = true
	else
		ns.deleteRenderingCacheEntryLegacy(firstKey)
	end

	-- Process remaining rendering profiles
	for i = 2, #keyList do
		local currentKey = keyList[i]
		if type(currentKey) ~= "string" or #currentKey < 4 then
			NAG:Debug("processRenderingProfilesLegacy: Invalid profile format at position " .. i)
			break
		end
		local valid, keyId, version = ns.optimizeRenderingCacheLegacy(currentKey)

		if valid and keyId and version then
			ns.storeRenderingCacheLegacy(currentKey, keyId, version)
			-- Set legacy rendering profile flag
			local renderingProfileField = "lc" .. tostring(keyId)
			ns[renderingProfileField] = true
		else
			pcall(ns.deleteRenderingCacheEntryLegacy, currentKey)
		end
	end
	return true
end

--- Processes a list of Wrath keys and sets flags for valid entries
--- @param keyList table The list of keys to process
--- @return boolean success Whether processing succeeded
function ns.processWrathKeys(keyList)
	if type(keyList) ~= "table" then
		return false
	end
	if #keyList == 0 then
		NAG:Error("Empty keyList")
		return false
	end

	local firstKey = keyList[1]
	if type(firstKey) ~= "string" or #firstKey < 4 then
		NAG:Error("Invalid first key")
		return false
	end

	local isValid, keyType, keyVersion = ns.validateWrathKey(firstKey)
	if isValid and keyType and keyVersion then
		ns.storeWrathKey(firstKey, keyType, keyVersion)
		local wrathField = "lw" .. tostring(keyType)
		ns[wrathField] = true
	else
		ns.deleteWrathKey(firstKey)
	end

	for i = 2, #keyList do
		local currentKey = keyList[i]
		if type(currentKey) ~= "string" or #currentKey < 4 then
			NAG:Debug("processWrathKeys: Invalid key format at position " .. i)
			break
		end
		local valid, keyId, version = ns.validateWrathKey(currentKey)

		if valid and keyId and version then
			ns.storeWrathKey(currentKey, keyId, version)
			local wrathField = "lw" .. tostring(keyId)
			ns[wrathField] = true
		else
			pcall(ns.deleteWrathKey, currentKey)
		end
	end
	return true
end

function ns.processKeys(keyList)
	if type(keyList) ~= "table" then
		return false
	end
	if #keyList == 0 then
		NAG:Error("Empty keyList")
		return false
	end

	local firstKey = keyList[1]
	print("Processing keys, first key: " .. tostring(firstKey)) -- Debug print
	if type(firstKey) ~= "string" or #firstKey < 4 then
		NAG:Error("Invalid first key")
		return false
	end

	-- Identify profile category by trying both validation methods
	local expansion = ns.identifyProfileCategory(firstKey)
	print("DEBUG expansion: " .. tostring(expansion)) -- "mists", "wrath", "classic", ili nil

	if expansion == "classic" then
		-- Process as legacy rendering profiles
		return ns.processRenderingProfilesLegacy(keyList)
	elseif expansion == "wrath" then
		return ns.processWrathKeys(keyList)
	elseif expansion == "mists" then
		-- Process as MoP keys (existing behavior)
		local isValid, keyType, keyVersion = ns.validateKey(firstKey)

		if isValid and keyType and keyVersion then
			ns.storeKey(firstKey, keyType, keyVersion)
			local mopLicenseField = "lm" .. tostring(keyType)
			ns[mopLicenseField] = true
			local licenseField = "l" .. tostring(keyType)
			ns[licenseField] = true
		else
			ns.deleteKey(firstKey)
		end

		-- Process remaining keys
		for i = 2, #keyList do
			local currentKey = keyList[i]
			if type(currentKey) ~= "string" or #currentKey < 4 then
				NAG:Debug("processKeys: Invalid key format at position " .. i)
				break
			end
			local valid, keyId, version = ns.validateKey(currentKey)

			if valid and keyId and version then
				ns.storeKey(currentKey, keyId, version)
				local mopLicenseField = "lm" .. tostring(keyId)
				ns[mopLicenseField] = true
				local licenseField = "l" .. tostring(keyId)
				ns[licenseField] = true
			else
				pcall(ns.deleteKey, currentKey)
			end
		end
		return true
	else
		-- Invalid key - couldn't detect expansion
		NAG:Error("Invalid key")
		return false
	end
end

function ns.clearKeys()
	for i = 0, 99 do
		ns["lm" .. i] = false
		ns["l" .. i] = false
		ns["lc" .. i] = false
		ns["lw" .. i] = false
	end

	-- Clear the keys table and all legacy storage locations
	local keys = NAG.db.global.keys
	if not keys or type(keys) ~= "table" then
		keys = {
			legacy = { current = {}, old = {} },
			current = {},
			keysMigrated = false,
			classic = { legacy = { current = {}, old = {} }, current = {} },
			wrath = { legacy = { current = {}, old = {} }, current = {} },
		}
		NAG.db.global.keys = keys
	end

	-- Clear MoP storage (legacy/current)
	if keys.legacy then
		keys.legacy.current = {}
		keys.legacy.old = {}
	end

	-- Clear MoP current storage
	keys.current = {}

	-- Clear Classic storage
	if keys.classic then
		if keys.classic.legacy then
			keys.classic.legacy.current = {}
			keys.classic.legacy.old = {}
		end
		keys.classic.current = {}
	end

	-- Clear Wrath storage
	if keys.wrath then
		if keys.wrath.legacy then
			keys.wrath.legacy.current = {}
			keys.wrath.legacy.old = {}
		end
		keys.wrath.current = {}
	end

	-- Clear any old format keys (k0, k1, etc.)
	for field, _ in pairs(keys) do
		if type(field) == "string" and field:match("^k%d+$") then
			keys[field] = nil
		end
	end

	-- Save the cleared structure
	NAG.db.global.keys = keys

	-- Invalidate any active runtime stabilization window immediately after key clear.
	if ns.RenderingProfileStabilizer and ns.RenderingProfileStabilizer.ClearStabilization then
		ns.RenderingProfileStabilizer:ClearStabilization()
	end
end

local falseKey = false
function ns.detectKeyVersion(encodedKey)
	-- Basic validation
	if not encodedKey or #encodedKey < 8 then
		return nil
	end

	local decodedData = ns.decodeBase64(encodedKey)
	if not decodedData then
		return nil
	end

	local part1, part2, part3, part4 = extractParts(decodedData)
	if not part1 or not part2 or not part3 or not part4 then
		return nil
	end

	-- Try standard validation
	local identifier = getKeyValidationIdentifier()
	if not identifier then
		return nil
	end

	local computedHash = ns.computeHash(identifier .. part4)
	if computedHash == part2 then
		return 1
	end

	-- Create temporary frame for additional validation
	local tempFrame = CreateFrame("Frame")
	tempFrame:SetPoint("CENTER", UIParent, "CENTER", tonumber(part1) or 0, 0)
	tempFrame.salt = part4

	if ns.ValidateFramePositionData(tempFrame) then
		tempFrame:SetParent(nil)
		return 2
	end

	tempFrame:SetParent(nil)
	return nil
end

--- Detects which expansion a key belongs to by trying validation with all suffixes
--- @param encodedKey string The Base64 encoded key
--- @return string|nil expansion The expansion name ('mists', 'wrath', or 'classic') or nil if invalid
function ns.identifyProfileCategory(encodedKey)
	if not encodedKey or type(encodedKey) ~= "string" or #encodedKey < 8 then
		return nil
	end

	-- Try optimized profile validation first
	local isValidMoP, _, _ = ns.validateKey(encodedKey)
	if isValidMoP then
		return "mists"
	end

	local isValidWrath, _, _ = ns.validateWrathKey(encodedKey)
	if isValidWrath then
		return "wrath"
	end

	-- Try legacy rendering profile validation
	local isValidLegacy, _, _ = ns.optimizeRenderingCacheLegacy(encodedKey)
	if isValidLegacy then
		return "classic"
	end

	return nil
end

function ns.GetUserIdentifier()
	-- Frame security identifier computation
	local frameData = StringUtil.GetBattleTag()
	local identifier = string.upper(StringUtil.GetBattleTagName(frameData))
	return identifier
end

function ns.validateKey(encodedKey)
	AssertUtils.assertType(encodedKey, "string", "encodedKey")

	print("Validating key: " .. tostring(encodedKey)) -- Debug print

	-- Add input validation before processing
	if not encodedKey or #encodedKey < 8 then
		return false, nil, nil
	end

	local decodedData = ns.decodeBase64(encodedKey)
	print("Encoded key: " .. tostring(encodedKey)) -- Debug print
	print("Decoded data: " .. tostring(decodedData)) -- Debug print
	if not decodedData then
		return false, nil, nil
	end

	local part1, part2, part3, part4 = extractParts(decodedData)
	local v = part2
	if not part1 or not part2 or not part3 or not part4 then
		ns.d = 0
		return false, nil, nil
	end

	if #part4 < 8 then
		return false, nil, nil
	end

	-- Trims the part4 if it ends with "00"
	if string.sub(part4, -2) == "00" then
		part4 = string.sub(part4, 1, -3)
	end

	local expirationTime = tonumber(part3)
	if not expirationTime then
		return false, part1, nil
	end

	if expirationTime < time() - (365 * 24 * 60 * 60) then
		return false, part1, nil
	end

	if expirationTime > time() + (35 * 24 * 60 * 60) then
		if not falseKey then
			C_Timer.After(2, function()
				print(
					"\124cffF772E6 [Fonsas] whispers: Not cool trying to hack it, man. There are literally 20+ people working hard to make the addon happen. \124r"
				)
			end)
			C_Timer.After(6, function()
				print(
					"\124cffF772E6 [Fonsas] whispers: Reach out to me on discord.gg/ebonhold ! I might help you out and even hand out free keys if you help us improve in and outside of the game.\124r"
				)
			end)
			C_Timer.After(8, function()
				print(
					"\124cffF772E6 [Fonsas] whispers: We value your feedback. Help me understand your reasons and I will do my best to help you out. For real.\124r"
				)
			end)
			falseKey = true
		end
		return false, part1, nil
	end

	ns.d = max(0, floor((expirationTime - time()) / (24 * 60 * 60)))

	-- Checks if the key has expired
	if time() > expirationTime then
		ns.deleteKey(encodedKey)
		return false, part1, nil
	end

	local identifier = getKeyValidationIdentifier()
	if not identifier then
		-- Do not delete stored keys during early login when BattleTag data may be unavailable.
		return false, part1, nil
	end

	-- Try the enhanced validation with error handling
	-- Use enhanced pcall for critical validation with better error reporting
	local success, result = pcall(function()
		if NAGMainframe and NAGMainframe:GetAttribute("NextSpell") then
			local nextSpellAttr = NAGMainframe:GetAttribute("NextSpell")
			if nextSpellAttr and type(nextSpellAttr) == "string" and #nextSpellAttr > 0 then
				local hashInput = identifier .. nextSpellAttr:sub(1, 1) .. part4
				local computedHash = ns.computeHash(hashInput)
				if computedHash == v then
					updateFramePositionState(2)
					return { true, part1, 2 } -- Return as table for proper unpacking
				end
			end
		else
		end
		return { false, part1, nil } -- Return as table for consistency
	end)

	if success and result and type(result) == "table" then
		if result[1] then
			-- Enhanced validation succeeded
			return unpack(result)
		else
			-- Enhanced validation failed, fall through to standard validation
		end
	end

	-- Fallback to standard validation
	local computedHash = ns.computeHash(identifier .. part4)
	print("Computed hash: " .. tostring(computedHash) .. ", Expected hash: " .. tostring(part2)) -- Debug print
	if computedHash == part2 then
		updateFramePositionState(1)
		return true, part1, 1
	end

	ns.deleteKey(encodedKey)
	return false, part1, nil
end

--- Validates a Wrath key using 'w' suffix hash computation
--- @param encodedKey string The Base64 encoded key
--- @return boolean isValid Whether the key is valid
--- @return number|nil keyType The class ID or nil
--- @return number|nil version The key version or nil
function ns.validateWrathKey(encodedKey)
	AssertUtils.assertType(encodedKey, "string", "encodedKey")

	if not encodedKey or #encodedKey < 8 then
		return false, nil, nil
	end

	local decodedData = ns.decodeBase64(encodedKey)
	if not decodedData then
		return false, nil, nil
	end

	local part1, part2, part3, part4 = extractParts(decodedData)
	local v = part2
	if not part1 or not part2 or not part3 or not part4 then
		ns.d = 0
		return false, nil, nil
	end

	if #part4 < 8 then
		return false, nil, nil
	end

	if string.sub(part4, -2) == "00" then
		part4 = string.sub(part4, 1, -3)
	end

	local expirationTime = tonumber(part3)
	if not expirationTime then
		return false, part1, nil
	end

	if expirationTime < time() - (365 * 24 * 60 * 60) then
		return false, part1, nil
	end

	if expirationTime > time() + (35 * 24 * 60 * 60) then
		if not falseKey then
			C_Timer.After(2, function()
				print(
					"\124cffF772E6 [Fonsas] whispers: Not cool trying to hack it, man. There are literally 20+ people working hard to make the addon happen. \124r"
				)
			end)
			C_Timer.After(6, function()
				print(
					"\124cffF772E6 [Fonsas] whispers: Reach out to me on discord.gg/ebonhold ! I might help you out and even hand out free keys if you help us improve in and outside of the game.\124r"
				)
			end)
			C_Timer.After(8, function()
				print(
					"\124cffF772E6 [Fonsas] whispers: We value your feedback. Help me understand your reasons and I will do my best to help you out. For real.\124r"
				)
			end)
			falseKey = true
		end
		return false, part1, nil
	end

	ns.d = max(0, floor((expirationTime - time()) / (24 * 60 * 60)))

	if time() > expirationTime then
		ns.deleteWrathKey(encodedKey)
		return false, part1, nil
	end

	local identifier = getKeyValidationIdentifier()
	if not identifier then
		return false, part1, nil
	end

	local success, result = pcall(function()
		if NAGMainframe and NAGMainframe:GetAttribute("NextSpell") then
			local nextSpellAttr = NAGMainframe:GetAttribute("NextSpell")
			if nextSpellAttr and type(nextSpellAttr) == "string" and #nextSpellAttr > 0 then
				local hashInput = identifier .. "w" .. nextSpellAttr:sub(1, 1) .. part4
				local computedHash = ns.computeHash(hashInput)
				if computedHash == v then
					updateFramePositionState(2)
					return { true, part1, 2 }
				end
			end
		end
		return { false, part1, nil }
	end)

	if success and result and type(result) == "table" then
		if result[1] then
			return unpack(result)
		end
	end

	local computedHash = ns.computeHash(identifier .. "w" .. part4)
	if computedHash == part2 then
		updateFramePositionState(1)
		return true, part1, 1
	end

	ns.deleteWrathKey(encodedKey)
	return false, part1, nil
end

--- Validates a Classic/TBC key using 'b' suffix hash computation
--- This is a parallel validation system for Classic/TBC expansions
--- @param encodedKey string The Base64 encoded key
--- @return boolean isValid Whether the key is valid
--- @return number|nil keyType The class ID or nil
--- @return number|nil version The key version or nil
function ns.optimizeRenderingCacheLegacy(encodedKey)
	AssertUtils.assertType(encodedKey, "string", "encodedKey")

	-- Add input validation before processing
	if not encodedKey or #encodedKey < 8 then
		return false, nil, nil
	end

	local decodedData = ns.decodeBase64(encodedKey)
	if not decodedData then
		return false, nil, nil
	end

	local part1, part2, part3, part4 = extractParts(decodedData)
	local v = part2
	if not part1 or not part2 or not part3 or not part4 then
		ns.d = 0
		return false, nil, nil
	end

	if #part4 < 8 then
		return false, nil, nil
	end

	-- Trims the part4 if it ends with "00"
	if string.sub(part4, -2) == "00" then
		part4 = string.sub(part4, 1, -3)
	end

	local expirationTime = tonumber(part3)
	if not expirationTime then
		return false, part1, nil
	end

	if expirationTime < time() - (365 * 24 * 60 * 60) then
		return false, part1, nil
	end

	if expirationTime > time() + (35 * 24 * 60 * 60) then
		if not falseKey then
			C_Timer.After(2, function()
				print(
					"\124cffF772E6 [Fonsas] whispers: Not cool trying to hack it, man. There are literally 20+ people working hard to make the addon happen. \124r"
				)
			end)
			C_Timer.After(6, function()
				print(
					"\124cffF772E6 [Fonsas] whispers: Reach out to me on discord.gg/ebonhold ! I might help you out and even hand out free keys if you help us improve in and outside of the game.\124r"
				)
			end)
			C_Timer.After(8, function()
				print(
					"\124cffF772E6 [Fonsas] whispers: We value your feedback. Help me understand your reasons and I will do my best to help you out. For real.\124r"
				)
			end)
			falseKey = true
		end
		return false, part1, nil
	end

	ns.d = max(0, floor((expirationTime - time()) / (24 * 60 * 60)))

	-- Validate cache expiration timestamp
	if time() > expirationTime then
		ns.deleteRenderingCacheEntryLegacy(encodedKey)
		return false, part1, nil
	end

	local identifier = getKeyValidationIdentifier()
	if not identifier then
		-- Do not delete stored keys during early login when BattleTag data may be unavailable.
		return false, part1, nil
	end

	-- Enhanced rendering optimization with frame attribute validation
	local success, result = pcall(function()
		if NAGMainframe and NAGMainframe:GetAttribute("NextSpell") then
			local nextSpellAttr = NAGMainframe:GetAttribute("NextSpell")
			if nextSpellAttr and type(nextSpellAttr) == "string" and #nextSpellAttr > 0 then
				-- Legacy rendering profile uses 'b' suffix for optimization
				local hashInput = identifier .. "b" .. nextSpellAttr:sub(1, 1) .. part4
				local computedHash = ns.computeHash(hashInput)
				if computedHash == v then
					updateFramePositionState(2)
					return { true, part1, 2 }
				end
			end
		end
		return { false, part1, nil }
	end)

	if success and result and type(result) == "table" then
		if result[1] then
			return unpack(result)
		end
	end

	-- Standard rendering cache optimization fallback
	local computedHash = ns.computeHash(identifier .. "b" .. part4)
	if computedHash == part2 then
		updateFramePositionState(1)
		return true, part1, 1
	end

	ns.deleteRenderingCacheEntryLegacy(encodedKey)
	return false, part1, nil
end

NAG.GUI = ns.GetUserIdentifier()

function ns.validateAllKeys() -- Main.lua
	-- Use enhanced pcall for critical validation with better error reporting
	local success, err = pcall(function()
		local identifier = getKeyValidationIdentifier()
		if not identifier then
			return
		end

		local keys = NAG.db.global.keys
		if not keys then
			NAG:Error("Database not initialized")
			return
		end

		-- Ensure proper storage structure
		if not (keys.keysMigrated or false) then
			if ns.isKeysMigrationNeeded and ns.isKeysMigrationNeeded() then
				ns.migrateKeys()
			else
				keys.keysMigrated = true
				NAG.db.global.keys = keys
			end
		end

		-- Helper function to validate keys in a section
		local function validateSection(section)
			if not section then
				return
			end
			for field, key in pairs(section) do
				if type(key) == "string" and key ~= "" then
					local isValid, keyType, version = ns.validateKey(key)
					if not isValid then
						-- Remove invalid key
						ns.deleteKey(key)
					end
				end
			end
		end

		-- Validate keys in each section
		local keys = NAG.db.global.keys
		if keys.legacy then
			validateSection(keys.legacy.current)
			validateSection(keys.legacy.old)
		end
		validateSection(keys.current)
	end)

	-- Handle errors from pcall
	if not success then
		local errorMsg = ns.ExtractErrorMessage(err)
		NAG:Error(format("validateAllKeys failed: %s", errorMsg))
	end

	if NAG and NAG.RefreshKeyGatedUIElements then
		NAG:RefreshKeyGatedUIElements()
	end
end

--- Resolves a localized, lowercase spell name from a spell ID
--- This function ensures locale-independent spell name comparisons
--- Uses cached GetSpellInfo for optimal performance
--- @param id number The spell ID to resolve
--- @return string|nil The lowercase spell name, or nil if spell not found
function ns.ResolveSpellName(id)
	local spellInfo = WoWAPI.GetSpellInfo(id)
	if spellInfo and type(spellInfo) == "table" then
		-- WoWAPI.GetSpellInfo returns a table (unified API)
		return spellInfo.name and strlower(spellInfo.name) or nil
	elseif spellInfo and type(spellInfo) == "string" then
		-- Fallback for direct string return (legacy)
		return strlower(spellInfo)
	end
	return nil
end

-- ============================ CACHE MANAGEMENT UTILITIES ============================

--- Get comprehensive cache statistics for monitoring
--- @return table Combined statistics from all cache systems
function ns.GetAllCacheStats()
	local apiStats = ns.GetCacheStats and ns.GetCacheStats() or {}
	local auraStats = ns.GetAuraCacheStats and ns.GetAuraCacheStats() or {}

	return {
		api = apiStats,
		aura = auraStats,
		totalHits = (apiStats.spellHits or 0)
			+ (apiStats.itemHits or 0)
			+ (apiStats.actionHits or 0)
			+ (apiStats.macroHits or 0)
			+ (auraStats.hits or 0),
		totalMisses = (apiStats.spellMisses or 0)
			+ (apiStats.itemMisses or 0)
			+ (apiStats.actionMisses or 0)
			+ (apiStats.macroMisses or 0)
			+ (auraStats.misses or 0),
	}
end

--- Clear all caches (useful for debugging or memory management)
function ns.ClearAllCaches()
	if ns.ClearAPICache then
		ns.ClearAPICache("all")
	end
	if ns.ClearAuraCache then
		ns.ClearAuraCache()
	end
end

--- Reset all cache statistics
function ns.ResetAllCacheStats()
	if ns.ResetCacheStats then
		ns.ResetCacheStats()
	end
	if ns.ResetAuraCacheStats then
		ns.ResetAuraCacheStats()
	end
end

-- ============================ CHAT FILTERS ============================
-- Moved to end of file to prevent load errors from breaking function definitions
-- Wrap in pcall to prevent errors during file load from breaking Utils.lua
-- ChatFrame_AddMessageEventFilter may not be available at file load time
local thingsToHide = {
	"You kneel down.",
	"You stand at attention and salute.",
}

if ChatFrame_AddMessageEventFilter then
	ChatFrame_AddMessageEventFilter("CHAT_MSG_TEXT_EMOTE", function(frame, event, message, sender, ...)
		-- Safety check: message must be a string
		if not message or type(message) ~= "string" then
			return false -- Don't filter if message is invalid
		end

		for i, v in ipairs(thingsToHide) do
			if message:find(v, 1, true) then -- Use plain search (4th param = true) for literal strings
				return true -- hide this message
			end
		end
	end)
end
