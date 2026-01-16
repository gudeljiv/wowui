-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local tonumber = _G.tonumber
local ipairs = _G.ipairs

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname = ...

-----------------------------------------------------------------------
-- AddOn version handling (fixed)
-----------------------------------------------------------------------

local GetAddOnMetadata = C_AddOns.GetAddOnMetadata
local addonVersion = GetAddOnMetadata(addonname, "Version")

-- Dev fallback when packaged version not replaced
if addonVersion == string.format("@%s@", "project-version") then
	addonVersion = "v99.99.9999-dev"
end

-- Supports:
-- v2.5.5.12131
-- v99.99.9999-dev
-- v1.2.3-beta
local major, minor, patch, buildOrTag = string.match(addonVersion, "^v(%d+)%.(%d+)%.(%d+)%.([%w%-]+)$")

-- Safety fallback
if not major then
	major, minor, patch, buildOrTag = "0", "0", "0", "0"
end

local versionT = { major, minor, patch, buildOrTag }

-- Build sortable numeric revision from major.minor.patch only
-- MM mm pppp bbbbb -> 2.5.5.123456 => 2 5 5 123456 => 255123456
local addonRevision = ""

-- major, minor, patch
for k = 1, 4 do
	local v = versionT[k]
	addonRevision = addonRevision .. v
end

addonRevision = tonumber(addonRevision) or 0

_G.AtlasLoot = {
	__addonrevision = addonRevision,

	__addonversion = (buildOrTag == "dev")
		and ("dev-" .. (GetServerTime() or 0))
		or addonVersion,

	IsDevVersion  = (buildOrTag == "dev")   and true or nil,
	IsTestVersion = (buildOrTag == "beta" or buildOrTag == "alpha") and true or nil,
}

local AddonNameVersion = string.format("%s-%d", addonname, _G.AtlasLoot.__addonrevision)
local MainMT = {
	__tostring = function(self)
		return AddonNameVersion
	end,
}
setmetatable(_G.AtlasLoot, MainMT)

-- DB
AtlasLootClassicDB                        = {}

-- Translations
_G.AtlasLoot.Locale                       = {}

-- Init functions
_G.AtlasLoot.Init                         = {}

-- Data table
_G.AtlasLoot.Data                         = {}

-- Version
local WOW_PROJECT_ID                      = _G.WOW_PROJECT_ID or 99
local WOW_PROJECT_MAINLINE                = _G.WOW_PROJECT_MAINLINE or 99
local WOW_PROJECT_CLASSIC                 = _G.WOW_PROJECT_CLASSIC or 1
local WOW_PROJECT_BURNING_CRUSADE_CLASSIC = _G.WOW_PROJECT_BURNING_CRUSADE_CLASSIC or 2
local WOW_PROJECT_WRATH_CLASSIC           = _G.WOW_PROJECT_WRATH_CLASSIC or 11

AtlasLoot.RETAIL_VERSION_NUM              = 99
AtlasLoot.CLASSIC_VERSION_NUM             = 1
AtlasLoot.BC_VERSION_NUM                  = 2
AtlasLoot.WRATH_VERSION_NUM               = 3

AtlasLoot.GAME_VERSION_TEXTURES           = {
	[AtlasLoot.CLASSIC_VERSION_NUM] = C_Seasons.GetActiveSeason() == 2 and 6366097 or 538639,
	[AtlasLoot.BC_VERSION_NUM] = 131194,
	[AtlasLoot.WRATH_VERSION_NUM] = 235509,
}

AtlasLoot.IS_CLASSIC                      = false
AtlasLoot.IS_BC                           = false
AtlasLoot.IS_WRATH                        = false
AtlasLoot.IS_RETAIL                       = false

local CurrentGameVersion                  = AtlasLoot.RETAIL_VERSION_NUM
if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
	CurrentGameVersion = AtlasLoot.RETAIL_VERSION_NUM
	AtlasLoot.IS_RETAIL = true
elseif WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC then
	if LE_EXPANSION_LEVEL_CURRENT == LE_EXPANSION_WRATH_OF_THE_LICH_KING then
		CurrentGameVersion = AtlasLoot.WRATH_VERSION_NUM
		AtlasLoot.IS_WRATH = true
	elseif LE_EXPANSION_LEVEL_CURRENT == LE_EXPANSION_BURNING_CRUSADE then
		CurrentGameVersion = AtlasLoot.BC_VERSION_NUM
		AtlasLoot.IS_BC = true
	end
elseif WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC then
	CurrentGameVersion = AtlasLoot.WRATH_VERSION_NUM
	AtlasLoot.IS_WRATH = true
elseif WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
	CurrentGameVersion = AtlasLoot.CLASSIC_VERSION_NUM
	AtlasLoot.IS_CLASSIC = true
end

AtlasLoot.CURRENT_VERSION_NUM = CurrentGameVersion

function AtlasLoot:GetGameVersion()
	return CurrentGameVersion
end

-- equal
function AtlasLoot:GameVersion_EQ(gameVersion, ret, retFalse)
	if CurrentGameVersion == gameVersion then
		return ret or true
	else
		return retFalse
	end
end

-- not equal
function AtlasLoot:GameVersion_NE(gameVersion, ret, retFalse)
	if CurrentGameVersion ~= gameVersion then
		return ret or true
	else
		return retFalse
	end
end

-- not greater then
function AtlasLoot:GameVersion_GT(gameVersion, ret, retFalse)
	if CurrentGameVersion > gameVersion then
		return ret or true
	else
		return retFalse
	end
end

-- not lesser then
function AtlasLoot:GameVersion_LT(gameVersion, ret, retFalse)
	if CurrentGameVersion < gameVersion then
		return ret or true
	else
		return retFalse
	end
end

-- not greater equal
function AtlasLoot:GameVersion_GE(gameVersion, ret, retFalse)
	if CurrentGameVersion >= gameVersion then
		return ret or true
	else
		return retFalse
	end
end

-- not lesser equal
function AtlasLoot:GameVersion_LE(gameVersion, ret, retFalse)
	if CurrentGameVersion <= gameVersion then
		return ret or true
	else
		return retFalse
	end
end
