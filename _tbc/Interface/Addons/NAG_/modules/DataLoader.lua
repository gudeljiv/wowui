--- @module "NAG.DataLoader"
--- Handles version-specific data loading across different WoW versions.
---
--- Responsible for selecting the appropriate version's data based on the current game version.
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

--[[

    Supported Data Files Structure:
    /data
    ├── Classic/           -- Classic Era data
    │   ├── Racials.lua   -- Classic racial abilities
    │   ├── Spells.lua    -- Classic spells and abilities
    │   └── Items.lua     -- Classic items
    ├── SoD/              -- Season of Discovery data
    │   ├── Racials.lua   -- SoD racial abilities
    │   ├── Spells.lua    -- SoD spells and abilities
    │   └── Items.lua     -- SoD items
    ├── cata/             -- Cataclysm data
    │   ├── Racials.lua   -- Cataclysm racial abilities
    │   ├── Spells.lua    -- Cataclysm spells and abilities
    │   └── Items.lua     -- Cataclysm items
    └── Retail/           -- Retail data
        ├── Racials.lua   -- Retail racial abilities
        ├── Spells.lua    -- Retail spells and abilities
        └── Items.lua     -- Retail items

    Each version's data files contain:
    - Racial abilities and passives
    - Class spells and abilities
    - Common spells and buffs
    - Raid buffs and debuffs
    - Items and their effects

    Processed Data Sections:
    Spells.lua:
    - commonSpells        -- Spells available to all classes
    - classSpells        -- Class-specific spells and abilities
    - raidBuffs          -- Raid-wide buff spells
    - raidDebuffs        -- Raid-wide debuff spells
    - individualBuffs    -- Individual target buff spells
    - petSpells         -- Pet-specific abilities and spells

    Racials.lua:
    - racialsByRaceID   -- Racial abilities indexed by race ID
    - racialSpells      -- List of all racial spell IDs

    Items.lua:
    - consumables       -- Consumable items (food, potions, etc.)
    - equipment        -- Equipment items with special effects
    - questItems       -- Quest-related items
    - reagents         -- Crafting and spell reagents
]]

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

--- @type Version
local Version = ns.Version
local TableUtils = ns.TableUtils
-- Lua APIs (using WoW's optimized versions where available)



-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

---@class DataLoader : CoreModule
local DataLoader = NAG:CreateModule("DataLoader", nil, {
    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.DATA,
        ns.DEBUG_CATEGORIES.SERVICES
    }
})
local module = DataLoader
ns.DataLoader = DataLoader

-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~
--- Initializes the DataLoader module
function DataLoader:ModuleInitialize()
    self:LoadVersionSpecificData()
end

-- ~~~~~~~~~~ HELPERS & PUBLIC API ~~~~~~~~~~
--- Loads data specific to the current WoW version
--- Promotes version-specific data to top-level namespace while keeping Global untouched
function DataLoader:LoadVersionSpecificData()
    local expansionKey = Version:GetDataSource()
    self:Info("Loading data for expansion: " .. tostring(expansionKey))

    -- Use shared fast deep clone helper for perf-optimized copies
    local fastClone = TableUtils.FastDeepClone

    -- Ensure ns.data exists (don't replace it - we need to preserve Global)
    ns.data = ns.data or {}

    -- Keep Global untouched - it stays as ns.data.Global
    -- DataWalker will process both ns.data.Global and version-specific data separately

    -- Use expansion key directly as the data namespace key
    local versionData = expansionKey and ns.data[expansionKey] or nil

    -- Promote version-specific data directly to top-level, dropping expansion key level
    if versionData then
        self:Info("Promoting version-specific data to top-level namespace")
        for k, v in pairs(versionData) do
            -- Direct copy to ns.data (no merge needed - DataWalker processes both separately)
            ns.data[k] = fastClone(v)
        end

        -- Clean up: Remove the expansion key table since we've promoted its contents
        self:Debug("Clearing expansion data table: " .. tostring(expansionKey))
        ns.data[expansionKey] = nil

        -- Clean up other expansion table (vanilla TOC loads both vanilla and SoD data)
        -- If running vanilla, remove sod; if running sod, remove vanilla
        local otherExpansion = (expansionKey == "vanilla") and "sod" or ((expansionKey == "sod") and "vanilla" or nil)
        if otherExpansion and ns.data[otherExpansion] then
            self:Debug("Clearing unused expansion data table: " .. tostring(otherExpansion))
            ns.data[otherExpansion] = nil
        end
    else
        self:Warn("Warning: No version-specific data found for " .. tostring(expansionKey))
    end

    -- Process overrides: promote version-specific overrides to top-level
    local versionOverrides = expansionKey and ns.overrides and ns.overrides[expansionKey] or nil

    if versionOverrides then
        self:Info("Promoting version-specific overrides to top-level namespace")
        -- Ensure ns.overrides exists
        ns.overrides = ns.overrides or {}

        -- Copy version-specific overrides directly to top-level
        for k, v in pairs(versionOverrides) do
            ns.overrides[k] = fastClone(v)
        end

        -- Clean up: Remove the expansion key table since we've promoted its contents
        if ns.overrides[expansionKey] then
            self:Debug("Clearing expansion overrides table: " .. tostring(expansionKey))
            ns.overrides[expansionKey] = nil
        end

        self:Info("SpellRequirementsOverrides available in universal namespace (ns.overrides)")
    else
        self:Info("No version-specific overrides found for " .. tostring(expansionKey))
    end

    -- Process custom handlers: promote version-specific handlers to top-level
    -- NOTE: This is planned/future infrastructure with no current data or usage
    -- Infrastructure is in place for when needed, but currently processes empty tables
    -- Ensure ns.customHandlers exists
    ns.customHandlers = ns.customHandlers or {}

    -- First, promote global handlers (apply to all versions)
    local globalCustomHandlers = ns.customHandlers.global
    if globalCustomHandlers then
        self:Info("Promoting global custom handlers to top-level namespace")
        for k, v in pairs(globalCustomHandlers) do
            ns.customHandlers[k] = fastClone(v)
        end
        -- Clean up: Remove the global table since we've promoted its contents
        ns.customHandlers.global = nil
    end

    -- Then, promote version-specific handlers (overwrite global if conflicts)
    local versionCustomHandlers = expansionKey and ns.customHandlers[expansionKey] or nil

    if versionCustomHandlers then
        self:Info("Promoting version-specific custom handlers for " .. tostring(expansionKey))
        for k, v in pairs(versionCustomHandlers) do
            -- Version-specific handlers overwrite global handlers if they conflict
            ns.customHandlers[k] = fastClone(v)
        end
        -- Clean up: Remove the expansion key table since we've promoted its contents
        ns.customHandlers[expansionKey] = nil
    else
        self:Info("No version-specific custom handlers found for " .. tostring(expansionKey))
    end


    -- Notify that version data is selected
    self:Info("Sending NAG_VERSION_DATA_SELECTED message to all modules")
    self:SendMessage("NAG_VERSION_DATA_SELECTED")
    self:Disable()
end

