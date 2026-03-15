--- @module "Version"
--- Version detection module for World of Warcraft across all versions
---
--- Provides a standardized way to detect and handle different WoW versions.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
-- Addon
local _, ns = ...

local GetBuildInfo = _G.GetBuildInfo

local floor = math.floor

local tonumber = tonumber

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~
--- @class Version
local Version = {}

-- Version Constants
-- Interface version format: XYYYY where X is the major version (expansion number)
-- 1 = Classic/Vanilla, 2 = TBC, 3 = Wrath, 4 = Cata, 5 = Mists, 10+ = Retail
Version.EXPANSIONS = {
    VANILLA = "vanilla",           -- Classic Era
    TBC = "tbc",                   -- Burning Crusade Classic
    WRATH = "wrath",               -- Wrath of the Lich King Classic
    CATA = "cata",                 -- Cataclysm Classic
    MISTS = "mists",               -- Mists of Pandaria Classic
    MAINLINE = "mainline",         -- Retail including Plunderstorm
    PLUNDERSTORM = "plunderstorm", -- Plunderstorm mode
    SOD = "sod",                   -- Season of Discovery (data-wise same as vanilla)
}

Version.GAME_TYPES = {
    CLASSIC_ERA = "classic_era",             -- Classic Era (Vanilla)
    CLASSIC_ERA_SOD = "season_of_discovery", -- Season of Discovery
    CLASSIC_TBC = "burning_crusade_classic", -- TBC Classic
    CLASSIC_WRATH = "wrath_classic",         -- Wrath Classic
    CLASSIC_CATA = "cataclysm_classic",      -- Cataclysm Classic
    CLASSIC_MISTS = "mists",                 -- Mists Classic
    RETAIL = "retail",                       -- Retail WoW (excluding special modes)
    PLUNDERSTORM = "plunderstorm",           -- Plunderstorm mode
}

Version.DATA_SOURCES = {
    VANILLA = "vanilla", -- Classic Era data
    SOD = "sod",         -- Season of Discovery data
    TBC = "tbc",         -- TBC data
    WRATH = "wrath",     -- WotLK data
    CATA = "cata",       -- Cata data
    MISTS = "mists",     -- MoP data
    RETAIL = "retail",   -- Retail data
}

Version.DATA_MAPPING = {
    [Version.EXPANSIONS.VANILLA] = Version.DATA_SOURCES.VANILLA,
    [Version.EXPANSIONS.SOD] = Version.DATA_SOURCES.SOD, -- SoD uses its own data
    [Version.EXPANSIONS.TBC] = Version.DATA_SOURCES.TBC,
    [Version.EXPANSIONS.WRATH] = Version.DATA_SOURCES.WRATH,
    [Version.EXPANSIONS.CATA] = Version.DATA_SOURCES.CATA,
    [Version.EXPANSIONS.MISTS] = Version.DATA_SOURCES.MISTS,
    [Version.EXPANSIONS.MAINLINE] = Version.DATA_SOURCES.RETAIL,
    [Version.EXPANSIONS.PLUNDERSTORM] = Version.DATA_SOURCES.RETAIL,
}

--- Maps expansion identifiers to game type identifiers
--- This provides a DRY way to convert between expansion (data/content) and gameType (compatibility)
Version.EXPANSION_TO_GAME_TYPE = {
    [Version.EXPANSIONS.VANILLA] = Version.GAME_TYPES.CLASSIC_ERA,
    [Version.EXPANSIONS.SOD] = Version.GAME_TYPES.CLASSIC_ERA_SOD,
    [Version.EXPANSIONS.TBC] = Version.GAME_TYPES.CLASSIC_TBC,
    [Version.EXPANSIONS.WRATH] = Version.GAME_TYPES.CLASSIC_WRATH,
    [Version.EXPANSIONS.CATA] = Version.GAME_TYPES.CLASSIC_CATA,
    [Version.EXPANSIONS.MISTS] = Version.GAME_TYPES.CLASSIC_MISTS,
    [Version.EXPANSIONS.MAINLINE] = Version.GAME_TYPES.RETAIL,
    [Version.EXPANSIONS.PLUNDERSTORM] = Version.GAME_TYPES.PLUNDERSTORM,
}

-- Cache version info
local cachedVersionInfo = nil

--- Initialize the Version system
function Version:Initialize()
    -- Initialize version info on load
    self:GetVersionInfo()
end

--- Gets the expansion version number (major version from interface version)
--- Extracts the major version number from the interface version (e.g., 20505 -> 2, 30400 -> 3)
--- @return number expansionVersion The expansion version number (1=Classic, 2=TBC, 3=Wrath, 4=Cata, 5=Mists, 10+=Retail)
function Version:GetExpansionVersion()
    local _, _, _, interfaceVersion = GetBuildInfo()
    local version = tonumber(interfaceVersion) or 0
    -- Interface version format: XYYYY where X is the major version (expansion number)
    -- Extract first digit(s): 1=Classic, 2=TBC, 3=Wrath, 4=Cata, 5=Mists, 10+=Retail
    return floor(version / 10000)
end

--- Gets the current expansion based on interface version
--- Uses interface version as primary detection method, with special API checks for SoD and Plunderstorm
--- @return string expansion The current expansion identifier
function Version:GetExpansion()
    local expansionVersion = self:GetExpansionVersion()

    -- Interface version 1xxxx = Classic Era/Vanilla (or SoD if C_Engraving enabled)
    if expansionVersion == 1 then
        -- Season of Discovery (has engraving system)
        if C_Engraving and C_Engraving.IsEngravingEnabled() then
            return self.EXPANSIONS.SOD
        end
        return self.EXPANSIONS.VANILLA
    end

    -- Interface version 2xxxx = TBC
    if expansionVersion == 2 then
        return self.EXPANSIONS.TBC
    end

    -- Interface version 3xxxx = Wrath
    if expansionVersion == 3 then
        return self.EXPANSIONS.WRATH
    end

    -- Interface version 4xxxx = Cata
    if expansionVersion == 4 then
        return self.EXPANSIONS.CATA
    end

    -- Interface version 5xxxx = Mists
    if expansionVersion == 5 then
        return self.EXPANSIONS.MISTS
    end

    -- Interface version 10xxxx+ = Retail (or Plunderstorm if C_GameModeManager enabled)
    if expansionVersion >= 10 then
        -- Check for Plunderstorm (if available)
        if C_GameModeManager and C_GameModeManager.IsFeatureID and C_GameModeManager.IsFeatureID(7) then
            return self.EXPANSIONS.PLUNDERSTORM
        end
        return self.EXPANSIONS.MAINLINE
    end

    -- Fallback: Unknown version, default to vanilla
    return self.EXPANSIONS.VANILLA
end

--- Gets detailed version information about the current WoW client
--- @return table versionInfo Table containing detailed version information
function Version:GetVersionInfo()
    -- Return cached info if available
    if cachedVersionInfo then
        return cachedVersionInfo
    end

    -- Get basic version info
    local version, build, date, interfaceVersion = GetBuildInfo()
    local expansionVersion = self:GetExpansionVersion()
    local expansion = self:GetExpansion()

    -- Determine game type based on expansion (DRY mapping)
    local gameType = self.EXPANSION_TO_GAME_TYPE[expansion] or self.GAME_TYPES.CLASSIC_ERA

    -- Create version info table
    cachedVersionInfo = {
        version = version,
        build = build,
        date = date,
        interfaceVersion = tonumber(interfaceVersion),
        expansionVersion = expansionVersion,
        gameType = gameType,
        expansion = expansion,
        isRetail = gameType == self.GAME_TYPES.RETAIL,
        isPlunderstorm = gameType == self.GAME_TYPES.PLUNDERSTORM,
        isClassicEra = gameType == self.GAME_TYPES.CLASSIC_ERA,
        isSoD = gameType == self.GAME_TYPES.CLASSIC_ERA_SOD,
        isTBC = gameType == self.GAME_TYPES.CLASSIC_TBC,
        isWrath = gameType == self.GAME_TYPES.CLASSIC_WRATH,
        isCata = gameType == self.GAME_TYPES.CLASSIC_CATA,
        isMists = gameType == self.GAME_TYPES.CLASSIC_MISTS,
    }

    return cachedVersionInfo
end

--- Checks if the current version is retail WoW
--- @return boolean isRetail Whether the current version is retail
function Version:IsRetail()
    local info = self:GetVersionInfo()
    return info.isRetail
end

--- Checks if the current version is Classic Era (Vanilla)
--- @return boolean isClassicEra Whether the current version is Classic Era
function Version:IsClassicEra()
    local info = self:GetVersionInfo()
    return info.isClassicEra
end

--- Checks if the current version is Vanilla (alias for IsClassicEra)
--- @return boolean isVanilla Whether the current version is Vanilla
function Version:IsVanilla()
    return self:IsClassicEra()
end

--- Checks if the current version is Season of Discovery
--- @return boolean isSoD Whether the current version is Season of Discovery
function Version:IsSoD()
    local info = self:GetVersionInfo()
    return info.isSoD or self:GetExpansion() == self.EXPANSIONS.SOD
end

--- Checks if the current version is Burning Crusade Classic
--- @return boolean isTBC Whether the current version is Burning Crusade Classic
function Version:IsTBC()
    local info = self:GetVersionInfo()
    return info.isTBC
end

--- Checks if the current version is Wrath Classic
--- @return boolean isWrath Whether the current version is Wrath Classic
function Version:IsWrath()
    local info = self:GetVersionInfo()
    return info.isWrath
end

--- Checks if the current version is Cataclysm Classic
--- @return boolean isCata Whether the current version is Cataclysm Classic
function Version:IsCata()
    local info = self:GetVersionInfo()
    return info.isCata
end

--- Checks if the current version is Mists Classic
--- @return boolean isMists Whether the current version is Mists Classic
function Version:IsMists()
    local info = self:GetVersionInfo()
    return info.isMists
end

Version.IsMoP = Version.IsMists

--- Gets the current game type
--- @return string gameType The current game type (from Version.GAME_TYPES)
function Version:GetGameType()
    local info = self:GetVersionInfo()
    return info.gameType
end

--- Gets the data source identifier for the current or specified expansion
--- This helps determine which data files to use (important for SoD using vanilla data)
--- @param expansion string Optional: The expansion to get the data source for
--- @return string dataSource The data source identifier
function Version:GetDataSource(expansion)
    expansion = expansion or self:GetExpansion()

    -- Return mapped data source or default to expansion name
    return self.DATA_MAPPING[expansion] or expansion
end

ns.Version = Version
Version:Initialize()
