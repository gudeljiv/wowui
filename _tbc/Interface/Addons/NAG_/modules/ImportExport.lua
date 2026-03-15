--- @module "NAG.ImportExport"
--- Handles import and export of rotation configurations, including validation and registration of entities.
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- TODO: This is currently stripping functions from the rotation config, which is not what we want.
-- We need to find a way to keep the functions in the rotation config, but not in the exported string.
-- This is a temporary fix to allow the rotation to be exported and imported.
-- We need to find a better solution in the future.

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access
local WoWAPI = ns.WoWAPI

--- @type DataManager
local DataManager

--- @type RotationManager
local RotationManager

--- @type SpecCompat
local SpecCompat

-- Proto-compatible AST system
local RotationConversionService = ns.RotationConversionService

local L = ns.AceLocale:GetLocale("NAG", true)
local json = ns.LibJSON
local LibBase64 = ns.LibBase64
local StringUtil = ns.StringUtil
local Version = ns.Version
local AceConfigRegistry = ns.AceConfigRegistry
local LibCompress = LibStub("LibCompress")

-- WoW API
local StaticPopup_Show = StaticPopup_Show
local StaticPopup_OnClick = StaticPopup_OnClick
local ACCEPT = _G.ACCEPT
local CANCEL = _G.CANCEL
local OKAY = _G.OKAY
local time = time

--WoW API

-- Lua APIs (using WoW's optimized versions where available)
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
local GetTime = _G.GetTime
local format = string.format -- WoW's optimized version if available

local strmatch = strmatch
local strsub = strsub
local strupper = strupper


-- Utility functions

-- Enhanced error handling
local pcall = ns.pcall

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

-- Constants
local EXPORT_VERSION = "1.0"
local EXPORT_PREFIX = "NAG_ROTATION:"
local EXPORT_HEADER_FORMAT = "NAG_ROTATION:%s:%s:%s:" -- class:specIndex:version
local EXPORT_HEADER_PATTERN = "^NAG_ROTATION:([^:]+):([^:]+):([^:]+):"

-- Bulk rotation+license bundle import (parallel delivery system)
local BUNDLE_PREFIX = "NAG_BUNDLE:"
local BUNDLE_HEADER_PATTERN = "^NAG_BUNDLE:(%d+):([^:]+):(.+)$" -- version:salt:payload

-- Low-level ops
local byte = string.byte
local char = string.char
local bxor = bit.bxor

-- Default settings (disabled by default, enabled when needed)
local defaults = {
    global = {
        enabled = false, -- Disabled by default (enabled on-demand for import/export operations)
    }
}

--- @class ImportExport : CoreModule
local ImportExport = NAG:CreateModule("ImportExport", defaults, {
    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.FEATURES,
        ns.DEBUG_CATEGORIES.UTILITIES
    }
})
local module = ImportExport
ns.ImportExport = ImportExport

-- ~~~~~~~~~~ HELPERS & PUBLIC API ~~~~~~~~~~

-- Helper function to safely inspect tables
local function inspectTable(t, maxDepth)
    if type(t) ~= "table" then return tostring(t) end
    maxDepth = maxDepth or 2
    local result = {}
    local function recurse(tbl, depth)
        if depth > maxDepth then return "{...}" end
        local items = {}
        local count = 0
        for k, v in pairs(tbl) do
            count = count + 1
            if type(v) == "table" then
                items[#items + 1] = tostring(k) .. "=" .. recurse(v, depth + 1)
            else
                items[#items + 1] = tostring(k) .. "=" .. tostring(v)
            end
            if count > 10 then
                items[#items + 1] = "..."
                break
            end
        end
        return "{" .. table.concat(items, ", ") .. "}"
    end
    return recurse(t, 1)
end

-- Helper function to convert nil values to json.Null()
local function convertNilToJsonNull(value)
    if type(value) == "table" then
        local result = {}
        for k, v in pairs(value) do
            result[k] = convertNilToJsonNull(v)
        end
        return result
    elseif value == nil then
        return json.Null()
    else
        return value
    end
end

-- ============================ MOP SPECID TO SPECINDEX CONVERTER ============================
-- MoP-only specID to specIndex lookup table
-- Maps MoP specIDs to {class, specIndex} for backward compatibility with old exports
local MOP_SPECID_LOOKUP = {
    [71] = {class = "WARRIOR", specIndex = 1},    -- Arms
    [72] = {class = "WARRIOR", specIndex = 2},    -- Fury
    [73] = {class = "WARRIOR", specIndex = 3},    -- Protection
    [65] = {class = "PALADIN", specIndex = 1},    -- Holy
    [66] = {class = "PALADIN", specIndex = 2},    -- Protection
    [70] = {class = "PALADIN", specIndex = 3},    -- Retribution
    [253] = {class = "HUNTER", specIndex = 1},    -- Beast Mastery
    [254] = {class = "HUNTER", specIndex = 2},   -- Marksmanship
    [255] = {class = "HUNTER", specIndex = 3},   -- Survival
    [259] = {class = "ROGUE", specIndex = 1},     -- Assassination
    [260] = {class = "ROGUE", specIndex = 2},     -- Combat
    [261] = {class = "ROGUE", specIndex = 3},     -- Subtlety
    [256] = {class = "PRIEST", specIndex = 1},   -- Discipline
    [257] = {class = "PRIEST", specIndex = 2},   -- Holy
    [258] = {class = "PRIEST", specIndex = 3},   -- Shadow
    [262] = {class = "SHAMAN", specIndex = 1},    -- Elemental
    [263] = {class = "SHAMAN", specIndex = 2},   -- Enhancement (same in all versions)
    [264] = {class = "SHAMAN", specIndex = 3},    -- Restoration
    [62] = {class = "MAGE", specIndex = 1},      -- Arcane
    [63] = {class = "MAGE", specIndex = 2},      -- Fire
    [64] = {class = "MAGE", specIndex = 3},       -- Frost
    [265] = {class = "WARLOCK", specIndex = 1},   -- Affliction
    [266] = {class = "WARLOCK", specIndex = 2},  -- Demonology
    [267] = {class = "WARLOCK", specIndex = 3},   -- Destruction
    [102] = {class = "DRUID", specIndex = 1},    -- Balance
    [103] = {class = "DRUID", specIndex = 2},     -- Feral
    [104] = {class = "DRUID", specIndex = 3},    -- Guardian
    [105] = {class = "DRUID", specIndex = 4},     -- Restoration
    [250] = {class = "DEATHKNIGHT", specIndex = 1},  -- Blood
    [251] = {class = "DEATHKNIGHT", specIndex = 2},  -- Frost
    [252] = {class = "DEATHKNIGHT", specIndex = 3}, -- Unholy
    [268] = {class = "MONK", specIndex = 1},     -- Brewmaster
    [270] = {class = "MONK", specIndex = 2},      -- Mistweaver
    [269] = {class = "MONK", specIndex = 3},     -- Windwalker
}

--- MoP-only specID to specIndex converter
--- Only active on MoP, converts old specID exports to specIndex for backward compatibility
--- @param specIdentifier number The spec identifier (specID or specIndex)
--- @param className string The class name (e.g., "WARRIOR")
--- @return number The converted specIndex, or original value if conversion not possible
local function ConvertSpecIDToSpecIndexMoP(specIdentifier, className)
    -- Only work on MoP
    if not Version or not Version:IsMists() then
        return specIdentifier
    end

    -- If already specIndex (<5), return as-is
    if type(specIdentifier) == "number" and specIdentifier >= 1 and specIdentifier <= 4 then
        return specIdentifier
    end

    -- If specID (>10), convert using MoP mapping
    if type(specIdentifier) == "number" and specIdentifier > 10 then
        local mapping = MOP_SPECID_LOOKUP[specIdentifier]
        if mapping and mapping.class == className:upper() then
            return mapping.specIndex
        end
    end

    -- Return as-is if can't convert
    return specIdentifier
end

-- Utility to recursively strip functions from a table
local function stripFunctions(tbl)
    if type(tbl) ~= "table" then return tbl end
    local result = {}
    for k, v in pairs(tbl) do
        if type(v) == "function" then
            -- skip
        elseif type(v) == "table" then
            result[k] = stripFunctions(v)
        else
            result[k] = v
        end
    end
    return result
end

local function encodeData(data)
    if not data then return nil end
    return LibBase64:encode(data)
end

local function decodeData(data)
    if not data then return nil end
    local ok, decoded = pcall(LibBase64.decode, LibBase64, data)
    if not ok or not decoded then
        return nil
    end
    return decoded
end

--- Builds the canonical BattleTag key identifier (includes discriminator) for bundle obfuscation.
--- This MUST match the identifier normalization used by the license key system.
--- @return string|nil identifier
--- @return string|nil error
local function getBundleKeyIdentifier()
    if not StringUtil or not StringUtil.GetBattleTag or not StringUtil.GetBattleTagKeyIdentifier then
        return nil, "BattleTag helpers unavailable"
    end

    local battleTag = StringUtil.GetBattleTag()
    local identifier = StringUtil.GetBattleTagKeyIdentifier(battleTag)
    if not identifier or identifier == "" then
        return nil, "BattleTag identifier unavailable"
    end
    return identifier
end

--- XOR-obfuscates binary data using a deterministic keystream derived from identifier+salt.
--- Note: This is obfuscation (not cryptographic secrecy). It binds bundles to a specific BattleTag identifier.
--- @param data string
--- @param identifier string
--- @param salt string
--- @return string
local function xorWithKeystream(data, identifier, salt)
    local out = {}
    local outLen = 0

    local counter = 1
    local k1, k2, k3, k4 = 0, 0, 0, 0
    local keyIndex = 5 -- force initial refill

    local function refillKeyBytes()
        local hex = ns.computeHash(identifier .. salt .. tostring(counter))
        counter = counter + 1

        -- 8 hex chars => 4 bytes
        k1 = tonumber(hex:sub(1, 2), 16) or 0
        k2 = tonumber(hex:sub(3, 4), 16) or 0
        k3 = tonumber(hex:sub(5, 6), 16) or 0
        k4 = tonumber(hex:sub(7, 8), 16) or 0
        keyIndex = 1
    end

    for i = 1, #data do
        if keyIndex > 4 then
            refillKeyBytes()
        end

        local keyByte
        if keyIndex == 1 then
            keyByte = k1
        elseif keyIndex == 2 then
            keyByte = k2
        elseif keyIndex == 3 then
            keyByte = k3
        else
            keyByte = k4
        end
        keyIndex = keyIndex + 1

        outLen = outLen + 1
        out[outLen] = char(bxor(byte(data, i), keyByte))
    end

    return table.concat(out, "", 1, outLen)
end

local function validateRotationConfig(config)
    if not config then return false, "Invalid config" end

    -- Required fields
    local required = {
        "name", "specIndex", "rotationString", "gameType", "class"
    }

    for _, field in ipairs(required) do
        if not config[field] then
            return false, format("Missing required field: %s", field)
        end
    end

    -- Simple class name normalization - remove spaces and uppercase
    if config.class then
        config.class = strupper(config.class:gsub("%s+", ""))
    end

    --[[ TODO reenable once parser fixed
    -- Check game type compatibility
    local currentGameType = ns.Version:GetGameType()
    if config.gameType ~= currentGameType then
        ImportExport:Print(format("Game type mismatch. Import is for %s but you are on %s", config.gameType,
            currentGameType))
        return false, "Game type mismatch"
    end
]]
    -- Check class compatibility  TODO: the parser is sending Title case, so we need to use UnitClass not UnitClassBase here
    local playerClass = UnitClassBase('player')
    if config.class ~= playerClass then
        ImportExport:Print(format("Class mismatch. Import is for %s but you are playing %s", config.class,
            playerClass))
        return false, "Class mismatch"
    end

    -- Note: Spec compatibility check removed - users can now import rotations for any spec
    -- They can only actively use rotations for their current spec, but can import and save any spec rotation

    -- Register all entities from the rotation config
    ImportExport:RegisterRotationEntities(config)

    -- Set toggle based on whether spellLocations are provided and have content
    config.useCustomSpellLocations = config.spellLocations and next(config.spellLocations) ~= nil

    local valid, err = RotationManager:ValidateRotation(config)
    if not valid then
        ImportExport:Print(format("ImportExport: Rotation validation failed: %s", err))
        return false, "Rotation validation failed: " .. err
    end

    return true
end

function ImportExport:RegisterRotationEntities(config)
    if not config then return end

    -- Create base paths for each type
    local spellPath = { "Spells", "Rotation", config.name }
    local itemPath = { "Items", "Rotation", config.name }
    local runePath = { "Spells", "Rune", config.name }

    -- AST-based extraction (preferred when aplProto is available)
    if config.aplProto and config.aplProto.type then
        local ASTCore = ns.ASTCore
        local SchemaAccessor = NAG:GetModule("SchemaAccessor", true)

        if SchemaAccessor and config.aplProto.type == ASTCore.NodeType.ROTATION then
            -- Extract all ActionIDs from rotation AST (actions, conditions, prepull, groups, variables)
            local actionIDs = SchemaAccessor:ExtractIDsFromRotationNode(config.aplProto)

            -- Register each extracted ActionID
            for _, actionID in ipairs(actionIDs) do
                if actionID.spell_id then
                    if not DataManager:GetSpell(actionID.spell_id) then
                        DataManager:AddSpell(actionID.spell_id, spellPath)
                    end
                end
                if actionID.item_id then
                    if not DataManager:GetItem(actionID.item_id) then
                        DataManager:AddItem(actionID.item_id, itemPath)
                    end
                end
                if actionID.other_id then
                    -- Try to determine type for other_id (could be spell or item)
                    -- Try spell first, then item
                    if not DataManager:GetSpell(actionID.other_id) and not DataManager:GetItem(actionID.other_id) then
                        -- Try spell first
                        local spellInfo = WoWAPI.GetSpellInfo(actionID.other_id)
                        if spellInfo then
                            DataManager:AddSpell(actionID.other_id, spellPath)
                        else
                            -- Try item
                            local itemInfo = WoWAPI.GetItemInfo(actionID.other_id)
                            if itemInfo then
                                DataManager:AddItem(actionID.other_id, itemPath)
                            end
                        end
                    end
                end
            end
        end
    end

    -- String-based fallback (for backward compatibility when aplProto is not available)
    -- Register spells
    if config.spells then
        for _, spellId in ipairs(config.spells) do
            if not DataManager:GetSpell(spellId) then
                DataManager:AddSpell(spellId, spellPath)
            end
        end
    end

    -- Register items
    if config.items then
        for _, itemId in ipairs(config.items) do
            if not DataManager:GetItem(itemId) then
                DataManager:AddItem(itemId, itemPath)
            end
        end
    end

    -- Register runes
    if config.runes then
        for _, runeId in ipairs(config.runes) do
            if not DataManager:GetSpell(runeId) then
                DataManager:AddSpell(runeId, runePath, {
                    flags = {
                        rune = true
                    }
                })
            end
        end
    end

    -- Register spells from burst trackers if present
    if config.burstTrackers then
        for _, tracker in ipairs(config.burstTrackers) do
            if tracker.spellId and not DataManager:GetSpell(tracker.spellId) then
                DataManager:AddSpell(tracker.spellId, spellPath)
            end
            if tracker.auraId then
                if type(tracker.auraId) == "table" then
                    for _, auraId in ipairs(tracker.auraId) do
                        if not DataManager:GetSpell(auraId) then
                            DataManager:AddSpell(auraId, spellPath)
                        end
                    end
                elseif not DataManager:GetSpell(tracker.auraId) then
                    DataManager:AddSpell(tracker.auraId, spellPath)
                end
            end
        end
    end

    -- Register spells from resource bar if present
    if config.resourceBar and config.resourceBar.spellIds then
        for _, spellId in ipairs(config.resourceBar.spellIds) do
            if not DataManager:GetSpell(spellId) then
                DataManager:AddSpell(spellId, spellPath)
            end
        end
    end
end

-- ~~~~~~~~~~ HELPERS & PUBLIC API ~~~~~~~~~~

-- Core Export Function
function ImportExport:ExportRotation(specIndex, rotationName, options)
    if self.debug then self:Debug("ExportRotation: Starting with specIndex: %s, rotationName: %s", specIndex, rotationName) end

    -- Get class module
    --- @type ClassBase|AceModule|CoreModule
    local classModule = NAG:GetClassModule()
    if not classModule then
        if self.debug then self:Debug("ExportRotation: Failed to get class module for class: %s", NAG.CLASS_FILENAME) end
        return nil, "Class module not found"
    end
    if self.debug then self:Debug("ExportRotation: Got class module: %s", NAG.CLASS_FILENAME) end

    -- Get rotation config using the robust API
    local rotation = classModule:GetRotationByName(rotationName)

    if not rotation then
        if self.debug then self:Debug("ExportRotation: Failed to find rotation by name: %s", rotationName) end
        return nil, "Rotation not found"
    end

    -- Create export config starting with empty rotation
    local exportConfig = classModule:GetEmptyRotation()

    -- Update with current rotation data
    exportConfig.name = rotationName
    exportConfig.specIndex = rotation.specIndex or specIndex or 0
    exportConfig.class = rotation.class or UnitClassBase('player')

    -- Core rotation data
    exportConfig.rotationString = rotation.rotationString
    exportConfig.rotationType = rotation.rotationType or ns.ROTATION_TYPES.CUSTOM

    exportConfig.prePull = rotation.prePull or {}
    exportConfig.macros = rotation.macros or {}
    exportConfig.burstTrackers = rotation.burstTrackers or {}
    exportConfig.resourceBar = rotation.resourceBar or {}
    exportConfig.spellLocations = rotation.spellLocations or {}

    -- Timeline and groups
    exportConfig.prePullActions = rotation.prePullActions or {}
    exportConfig.groups = rotation.groups or {}
    exportConfig.variables = rotation.variables or {}

    -- Tracking arrays
    exportConfig.spells = rotation.spells or {}
    exportConfig.items = rotation.items or {}
    exportConfig.auras = rotation.auras or {}
    exportConfig.runes = rotation.runes or {}

    -- Consumables
    exportConfig.consumables = rotation.consumables or {}

    -- Item swap settings
    exportConfig.enableItemSwap = rotation.enableItemSwap == true
    exportConfig.itemSwap = rotation.itemSwap

    -- Talents and Glyphs
    exportConfig.talentsString = rotation.talentsString
    exportConfig.talents = rotation.talents or {}
    exportConfig.glyphs = rotation.glyphs or {}

    -- Smart switching
    exportConfig.customConditions = rotation.customConditions or {}
    exportConfig.enableSmartSwitching = rotation.enableSmartSwitching or false

    -- Metadata
    exportConfig.default = rotation.default or false
    exportConfig.experimental = rotation.experimental or false
    exportConfig.guide = rotation.guide
    exportConfig.notes = rotation.notes

    -- Version and state
    exportConfig.addonVersion = WoWAPI.GetAddOnMetadata("NAG", "Version")
    exportConfig.gameType = rotation.gameType
    exportConfig.enabled = rotation.enabled or true
    exportConfig.userModified = rotation.userModified or true

    -- Handle both old and new author formats
    if rotation.authors then
        exportConfig.authors = type(rotation.authors) == "table" and rotation.authors or { rotation.authors }
    elseif rotation.author then
        exportConfig.authors = { rotation.author }
    else
        exportConfig.authors = { "@APLParser" }
    end

    exportConfig.lastModified = rotation.lastModified or time()
    exportConfig.lastModifiedBy = rotation.lastModifiedBy or "Unknown"
    exportConfig.exportTime = time()

    -- Debug the export config before conversion
    self:Trace("ExportRotation: Pre-conversion config:")
    for k, v in pairs(exportConfig) do
        if type(v) == "table" then
            if self.debug then self:Trace("  %s: %s", k, inspectTable(v)) end
        else
            if self.debug then self:Trace("  %s: %s (%s)", k, tostring(v), type(v)) end
        end
    end

    -- Strip functions before serialization
    exportConfig = stripFunctions(exportConfig)

    -- Convert nil values to json.Null()
    local success, converted = pcall(function()
        return convertNilToJsonNull(exportConfig)
    end)

    if not success then
        if self.debug then self:Debug("ExportRotation: Failed to convert nil values: %s", converted) end
        return nil, "Failed to convert nil values: " .. tostring(converted)
    end

    exportConfig = converted

    -- Debug the export config after conversion
    self:Trace("ExportRotation: Post-conversion config:")
    for k, v in pairs(exportConfig) do
        if type(v) == "table" then
            if self.debug then self:Trace("  %s: %s", k, inspectTable(v)) end
        else
            if self.debug then self:Trace("  %s: %s (%s)", k, tostring(v), type(v)) end
        end
    end

    -- Verify json object exists
    if not json then
        self:Debug("ExportRotation: json library is nil")
        return nil, "JSON library not found"
    end

    if not json.Serialize then
        self:Debug("ExportRotation: json.Serialize function is nil")
        return nil, "JSON serialize function not found"
    end

    -- Serialize to JSON
    local serializeSuccess, serialized = pcall(json.Serialize, exportConfig)
    if not serializeSuccess then
        if self.debug then self:Debug("ExportRotation: JSON serialization failed: %s", serialized) end
        return nil, "JSON serialization failed: " .. tostring(serialized)
    end

    -- Debug the serialized string
    if self.debug then self:Debug("ExportRotation: Serialized JSON length: %d", #serialized) end

    -- Encode using Base64
    local encoded = encodeData(serialized)
    if not encoded then
        self:Debug("ExportRotation: Encoding failed")
        return nil, "Encoding failed"
    end

    -- Add header with class, specIndex, and version
    local header = format(EXPORT_HEADER_FORMAT, exportConfig.class, exportConfig.specIndex or 0, EXPORT_VERSION)
    local finalString = header .. encoded
    if self.debug then self:Debug("ExportRotation: Successfully completed, final string length: %s",
            finalString and #finalString or "nil") end
    return finalString
end

-- Converts a WoWSims JSON to a valid NAG rotation config
function ImportExport:ImportFromWoWSims(jsonTable)
    -- Attempt to extract relevant fields from the external JSON
    local player = jsonTable.player or {}
    local class = player.class or "UNKNOWN"
    local rotation = player.rotation or {}
    local specIndex = 0 -- Default to 0 if not found (external import, no specIndex available)
    local name
    local lastModified = time()
    -- Use WoW's date() and GetTime() for compatibility
    local dateStr = date("%Y%m%d")
    if class and rotation and rotation.type then
        name = string.format("%s %s %s %d", class, rotation.type, dateStr, lastModified)
    else
        name = "Imported Rotation " .. tostring(lastModified)
    end
    -- Use WoW API for gameType
    local gameType = "UNKNOWN"
    if ns.Version and ns.Version.GetGameType then
        gameType = ns.Version:GetGameType()
    end
    local author = "ExternalImport"

    -- Build the NAG rotation config
    local config = {
        name = name,
        specIndex = specIndex,  -- External import, no specIndex available
        class = class,
        rotationString = nil, -- Not used for AST-based rotations
        apl = rotation,       -- Store the AST directly
        prePull = rotation.prepullActions or {},
        macros = {},
        burstTrackers = {},
        resourceBar = {},
        enabled = true,
        userModified = true,
        gameType = gameType,
        authors = { author },
        lastModified = lastModified,
        lastModifiedBy = author,
        exportTime = lastModified,
        imported = true,
        importTime = lastModified,
    }

    local conversionWarnings
    local conversionService = RotationConversionService or NAG:GetModule("RotationConversionService", true)
    if rotation then
        local formats = conversionService.FORMATS
        local protoAst, diagnostics = conversionService:Convert(formats.WOWSIMS_JSON, formats.PROTO_AST, rotation, {
            validate = true,
        })

        if protoAst then
            config.aplProto = protoAst

            local rotationStringResult, stringDiagnostics = conversionService:Convert(formats.PROTO_AST, formats.ROTATION_STRING, protoAst, {
                validate = false,
            })

            if rotationStringResult and rotationStringResult ~= "" then
                config.rotationString = rotationStringResult
            else
                conversionWarnings = conversionWarnings or {}
                local warnMsg = (stringDiagnostics and stringDiagnostics.errors and stringDiagnostics.errors[1])
                    or "Unable to derive rotation string from proto AST"
                table.insert(conversionWarnings, warnMsg)
            end

            if stringDiagnostics and stringDiagnostics.warnings then
                conversionWarnings = conversionWarnings or {}
                for _, warning in ipairs(stringDiagnostics.warnings) do
                    table.insert(conversionWarnings, warning)
                end
            end
        else
            conversionWarnings = conversionWarnings or {}
            local failureReason = (diagnostics and diagnostics.errors and diagnostics.errors[1])
                or "Failed to convert WoWSims JSON to proto AST"
            table.insert(conversionWarnings, failureReason)
        end

        if diagnostics and diagnostics.warnings then
            conversionWarnings = conversionWarnings or {}
            for _, warning in ipairs(diagnostics.warnings) do
                table.insert(conversionWarnings, warning)
            end
        end
    end

    if conversionWarnings and #conversionWarnings > 0 then
        config.importWarnings = conversionWarnings
        for _, warning in ipairs(conversionWarnings) do
            self:Warn("ImportFromWoWSims warning: %s", warning)
        end
    end

    if player.enableItemSwap ~= nil then
        config.enableItemSwap = player.enableItemSwap and true or false
    end

    if player.itemSwap then
        config.itemSwap = player.itemSwap
        if config.enableItemSwap == nil then
            config.enableItemSwap = true
        end
    end

    local equipmentItems = player.equipment and player.equipment.items
    if equipmentItems then
        local slotMap = {
            [12] = 13,
            [13] = 14,
            [6] = 10,
            [15] = 17,
        }
        config.itemSwap = config.itemSwap or { main = {}, swaps = {} }
        config.itemSwap.main = config.itemSwap.main or {}
        for protoIndex, inventorySlot in pairs(slotMap) do
            if config.itemSwap.main[inventorySlot] == nil then
                local entry = equipmentItems[protoIndex + 1]
                local itemId
                if type(entry) == "table" then
                    itemId = entry.id or entry.itemId
                elseif type(entry) == "number" then
                    itemId = entry
                end
                if itemId and itemId > 0 then
                    config.itemSwap.main[inventorySlot] = itemId
                end
            end
        end
    if next(config.itemSwap.main) == nil then
        config.itemSwap.main = nil
    end
    if not config.itemSwap.main and (not config.itemSwap.swaps or not next(config.itemSwap.swaps)) then
        config.itemSwap = next(config.itemSwap) and config.itemSwap or nil
    end
    end

    -- WoWSims JSON doesn't include spellLocations, so we'll let the validation step handle defaults
    return config
end

function ImportExport:ImportRotationJSON(importString)
    if self.debug then self:Debug("ImportRotationJSON: Starting JSON import process") end

    if not importString then
        self:Debug("ImportRotationJSON: No import string provided")
        return false, "No import string provided"
    end

    -- Try JSON deserialization
    local success, jsonTable = pcall(json.Deserialize, importString)
    if not success or not jsonTable then
        self:Debug("ImportRotationJSON: Failed to deserialize JSON")
        return false, "Failed to deserialize JSON"
    end

    -- Convert WoWSims JSON to NAG rotation config
    local config = self:ImportFromWoWSims(jsonTable)
    if not config then
        self:Debug("ImportRotationJSON: Failed to convert WoWSims JSON to NAG config")
        return false, "Failed to convert external JSON to NAG config"
    end

    -- Convert specID to specIndex for MoP (backward compatibility with old exports)
    -- Note: ImportFromWoWSims sets specIndex = 0 by default, so check for specID first
    if config.specID and (not config.specIndex or config.specIndex == 0) then
        local className = config.class or UnitClassBase('player')
        config.specIndex = ConvertSpecIDToSpecIndexMoP(config.specID, className)
        -- Keep specID for reference but use specIndex as primary
        if self.debug then
            self:Debug("ImportRotationJSON: Converted specID %s to specIndex %s for class %s",
                tostring(config.specID), tostring(config.specIndex), className)
        end
    end

    -- Validate the converted config
    local isValid, validationError = validateRotationConfig(config)
    if not isValid then
        if self.debug then self:Debug("ImportRotationJSON: Config validation failed: %s", validationError) end
        return false, validationError
    end

    return true, config
end

function ImportExport:ImportRotationLegacy(importString)
    if self.debug then self:Debug("ImportRotationLegacy: Starting import process for importString: %s", importString) end

    if not importString then
        if self.debug then self:Debug("ImportRotationLegacy: No import string provided") end
        return false, "No import string provided"
    end

    -- Parse header to get class and spec identifier (may be specID or specIndex)
    local headerMatch = {strmatch(importString, EXPORT_HEADER_PATTERN)}
    local headerClass, headerSpecIdentifier, headerVersion
    if headerMatch and #headerMatch >= 3 then
        headerClass = headerMatch[1]
        headerSpecIdentifier = headerMatch[2]
        headerVersion = headerMatch[3]
        if self.debug then
            self:Debug("ImportRotationLegacy: Parsed header - class: %s, specIdentifier: %s, version: %s",
                headerClass, headerSpecIdentifier, headerVersion)
        end
    end

    -- Extract the last chunk after the last colon
    local lastColonPos = importString:find(":[^:]*$")
    local encodedData = lastColonPos and importString:sub(lastColonPos + 1) or importString

    -- Decode Base64
    local decoded = decodeData(encodedData)
    if not decoded then
        self:Debug("ImportRotationLegacy: Failed to decode import string")
        return false, "Failed to decode import string"
    end

    -- Try JSON deserialization
    local success, result = pcall(json.Deserialize, decoded)
    if not success or not result then
        self:Debug("ImportRotationLegacy: Failed to deserialize JSON")
        return false, "Failed to deserialize JSON"
    end

    -- Convert specID to specIndex for MoP (backward compatibility with old exports)
    -- Check header first (old exports might have specID in header)
    local className = result.class or headerClass or UnitClassBase('player')
    local specIndexFromHeader = nil

    if headerSpecIdentifier then
        local headerSpecNum = tonumber(headerSpecIdentifier)
        if headerSpecNum then
            -- Convert header spec identifier (might be specID or specIndex)
            specIndexFromHeader = ConvertSpecIDToSpecIndexMoP(headerSpecNum, className)
            if self.debug and headerSpecNum ~= specIndexFromHeader then
                self:Debug("ImportRotationLegacy: Converted header specID %s to specIndex %s for class %s",
                    tostring(headerSpecNum), tostring(specIndexFromHeader), className)
            end
        end
    end

    -- Check JSON config for specID/specIndex (fallback or override)
    if result.specID and not result.specIndex then
        result.specIndex = ConvertSpecIDToSpecIndexMoP(result.specID, className)
        if self.debug then
            self:Debug("ImportRotationLegacy: Converted config specID %s to specIndex %s for class %s",
                tostring(result.specID), tostring(result.specIndex), className)
        end
    elseif not result.specIndex and specIndexFromHeader then
        -- Use specIndex from header if config doesn't have it
        result.specIndex = specIndexFromHeader
        if self.debug then
            self:Debug("ImportRotationLegacy: Using specIndex %s from header for class %s",
                tostring(specIndexFromHeader), className)
        end
    end

    -- Validate config
    local isValid, validationError = validateRotationConfig(result)
    if not isValid then
        if self.debug then self:Debug("ImportRotationLegacy: Config validation failed: %s", validationError) end
        return false, validationError
    end

    return true, result
end

--- Imports a bulk-delivery bundle containing license key data and multiple rotation import strings.
--- This is a parallel system that does NOT replace existing single-rotation import.
---
--- Bundle format (v1):
--- `NAG_BUNDLE:1:<salt>:<payload>`
--- - `salt`: short string used in obfuscation key derivation
--- - `payload`: Base64 of XOR( LibCompress:Compress(JSON(bundle)) )
---
--- Bundle JSON shape (v1):
--- `{ bundleVersion=1, licenseKey?="<encoded key string>", rotations={"<importString>", ...} }`
---
--- @param importString string
--- @return boolean success
--- @return table|string resultOrError
function ImportExport:ImportBundle(importString)
    if type(importString) ~= "string" or importString == "" then
        return false, "No import string provided"
    end

    if importString:sub(1, #BUNDLE_PREFIX) ~= BUNDLE_PREFIX then
        return false, "Not a bundle string"
    end

    local versionStr, salt, payload = importString:match(BUNDLE_HEADER_PATTERN)
    local bundleVersion = tonumber(versionStr or "")
    if not bundleVersion or bundleVersion ~= 1 then
        return false, "Unsupported bundle version"
    end
    if not salt or salt == "" or not payload or payload == "" then
        return false, "Malformed bundle header"
    end

    local identifier, idErr = getBundleKeyIdentifier()
    if not identifier then
        return false, idErr or "Unable to derive bundle identifier"
    end

    local decodedPayload = decodeData(payload)
    if not decodedPayload then
        return false, "Failed to decode bundle payload"
    end

    local deobfuscated = xorWithKeystream(decodedPayload, identifier, salt)
    local decompressed, decompErr = LibCompress:Decompress(deobfuscated)
    if not decompressed then
        return false, "Failed to decompress bundle payload: " .. tostring(decompErr)
    end

    local ok, bundle = pcall(json.Deserialize, decompressed)
    if not ok or type(bundle) ~= "table" then
        return false, "Failed to deserialize bundle JSON"
    end

    if tonumber(bundle.bundleVersion or 0) ~= 1 then
        return false, "Invalid bundle JSON version"
    end
    if type(bundle.rotations) ~= "table" or #bundle.rotations == 0 then
        return false, "Bundle contains no rotations"
    end

    local summary = {
        bundleVersion = 1,
        rotationsReceived = #bundle.rotations,
        rotationsEnqueued = 0,
        rotationsImportedNow = 0,
        inboxRemaining = 0,
        licenseProcessed = false,
        licenseValidKeys = 0,
    }

    -- License: optional, uses existing license system without clearing existing keys.
    if type(bundle.licenseKey) == "string" and bundle.licenseKey ~= "" then
        local keyList = ns.splitDecodedString(bundle.licenseKey)
        if not keyList then
            return false, "Bundle licenseKey failed to decode"
        end
        ns.processKeys(keyList)
        local validKeys = ns.retrieveValidKeys and ns.retrieveValidKeys() or {}
        summary.licenseProcessed = true
        summary.licenseValidKeys = type(validKeys) == "table" and #validKeys or 0
    end

    local inboxModule = NAG:GetModule("RotationBundleInbox", true)
    if not inboxModule then
        return false, "RotationBundleInbox service not available"
    end

    for _, rotationImportString in ipairs(bundle.rotations) do
        if type(rotationImportString) == "string" and rotationImportString ~= "" then
            local queuedOk = inboxModule:Enqueue(rotationImportString, "bundle_v1")
            if queuedOk then
                summary.rotationsEnqueued = summary.rotationsEnqueued + 1
            end
        end
    end

    local importedNow, remaining = inboxModule:ProcessInbox()
    summary.rotationsImportedNow = importedNow or 0
    summary.inboxRemaining = remaining or 0

    return true, summary
end

-- Dialog Management
function ImportExport:ShowImportDialog()
    StaticPopup_Show("NAG_IMPORT_ROTATION_STRING")
end

function ImportExport:ShowExportDialog(exportString)
    StaticPopup_Show("NAG_EXPORT_ROTATION_STRING", nil, nil, exportString)
end

-- Wrapper that auto-detects import format and dispatches to the correct function
function ImportExport:ImportRotation(importString)
    if not importString then
        self:Debug("ImportRotation: No import string provided")
        return false, "No import string provided"
    end
    -- Detect direct JSON input (starts with '{')
    if strsub(importString, 1, 1) == '{' then
        -- Call the new AST/JSON-based import logic
        return self:ImportRotationJSON(importString)
    else
        -- Call the legacy string-based import logic
        return self:ImportRotationLegacy(importString)
    end
end

-- ~~~~~~~~~~ DIALOG DEFINITIONS ~~~~~~~~~~

StaticPopupDialogs["NAG_EXPORT_ROTATION_STRING"] = {
    text = L["exportRotationString"] or "Copy the string below to share your rotation:",
    button1 = OKAY,
    hasEditBox = true,
    editBoxWidth = 250,
    maxLetters = 9999999,
    enterClicksFirstButton = true,
    OnShow = function(dialog)
        dialog:SetFrameStrata("FULLSCREEN_DIALOG")
        dialog:SetFrameLevel(200)
        local editBox = dialog:GetEditBox()
        if editBox then
            editBox:SetText(dialog.data)
            editBox:HighlightText()
            editBox:SetFocus()
        end
    end,
    EditBoxOnEnterPressed = function(dialog)
        StaticPopup_OnClick(dialog:GetParent(), 1)
    end,
    EditBoxOnEscapePressed = function(editBox)
        editBox:GetParent():Hide()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

StaticPopupDialogs["NAG_IMPORT_ROTATION_STRING"] = {
    text = L["importRotationString"] or "Paste the rotation string below:",
    button1 = ACCEPT,
    button2 = CANCEL,
    hasEditBox = true,
    editBoxWidth = 250,
    maxLetters = 9999999,
    enterClicksFirstButton = true,
    OnShow = function(dialog)
        dialog:SetFrameStrata("FULLSCREEN_DIALOG")
        dialog:SetFrameLevel(200)
        local editBox = dialog:GetEditBox()
        if editBox then
            editBox:SetFocus()
        end
    end,
    EditBoxOnEnterPressed = function(dialog)
        StaticPopup_OnClick(dialog:GetParent(), 1)
    end,
    EditBoxOnEscapePressed = function(editBox)
        editBox:GetParent():Hide()
    end,
    OnAccept = function(dialog)
        local editBox = dialog:GetEditBox()
        if not editBox then return end
        local importString = editBox:GetText()
        if not importString or importString == "" then
            NAG:Error("No import string provided")
            return
        end

        local ImportExport = NAG:GetModule("ImportExport", true)
        if not ImportExport then
            NAG:Error("ImportExport module not available")
            return
        end

        -- Bulk bundle import (parallel system)
        if importString:sub(1, #BUNDLE_PREFIX) == BUNDLE_PREFIX then
            local ok, summaryOrErr = ImportExport:ImportBundle(importString)
            if not ok then
                NAG:Error("Failed to import bundle: " .. tostring(summaryOrErr))
                return
            end

            local summary = summaryOrErr
            NAG:Info(
                ("Bundle imported: enqueued %d/%d rotations, imported now %d, inbox remaining %d, license keys valid=%d"):format(
                    tonumber(summary.rotationsEnqueued or 0) or 0,
                    tonumber(summary.rotationsReceived or 0) or 0,
                    tonumber(summary.rotationsImportedNow or 0) or 0,
                    tonumber(summary.inboxRemaining or 0) or 0,
                    tonumber(summary.licenseValidKeys or 0) or 0
                )
            )
            AceConfigRegistry:NotifyChange("NAG")
            return
        end

        local success, result = ImportExport:ImportRotation(importString)
        if not success then
            NAG:Error("Failed to import rotation: " .. tostring(result))
            return
        end

        local classModule = NAG:GetClassModule()
        if not classModule then
            NAG:Error("Class module not found")
            return
        end

        local specStatus = SpecCompat and SpecCompat:GetSpecializationStatus()

        result.imported = true
        result.importTime = time()
        result.userModified = true

        local uniqueName = classModule:GenerateUniqueRotationName(result.specIndex, result.name)
        if uniqueName ~= result.name then
            result.name = uniqueName
            NAG:Info("Rotation name changed to avoid conflict: " .. uniqueName)
        end

        local err
        success, err = classModule:SaveRotation(result.specIndex, result.name, result)
        if not success then
            NAG:Error("Failed to save rotation: " .. tostring(err))
            return
        end

        local currentSpecIndex = specStatus and specStatus.specIndex
        local canActivate = specStatus and specStatus.available and currentSpecIndex == result.specIndex
        if canActivate then
            success, err = classModule:SelectRotation(result.specIndex, result.name)
            if not success then
                NAG:Error("Failed to select rotation: " .. tostring(err))
                return
            end
        else
            NAG:Info(format("Rotation '%s' imported for spec %d. Not activated (current spec: %s).",
                result.name, result.specIndex, tostring(currentSpecIndex)))
        end

        NAG:GetModule("RotationManager"):ClearRotationCache(result.specIndex)

        AceConfigRegistry:NotifyChange("NAG")
        NAG:SendMessage(ns.Messages.ROTATION_CHANGED, {
            specIndex = result.specIndex,
            rotationName = result.name,
            dataChanged = true,
            selectionChanged = false,
            action = "import_dialog"
        })
        NAG:Info("Rotation imported successfully")
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~
do
    function ImportExport:ModuleInitialize()
        -- ============================ MODULE ASSIGNMENT ============================
        -- Assign Ace3 modules directly (no metatable access)
        DataManager = NAG:GetModule("DataManager")
        RotationManager = NAG:GetModule("RotationManager")
        SpecCompat = NAG:GetModule("SpecCompat")
        RotationConversionService = RotationConversionService or NAG:GetModule("RotationConversionService", true)
    end

    function ImportExport:ModuleEnable()
        -- Module is enabled on-demand for import/export operations
        -- No persistent initialization needed
    end

    function ImportExport:ModuleDisable()
        -- Module is disabled by default
        -- No cleanup needed
    end
end

-- Expose in private namespace
