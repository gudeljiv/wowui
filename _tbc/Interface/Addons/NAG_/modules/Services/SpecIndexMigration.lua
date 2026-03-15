--- @module 'NAG.SpecIndexMigration'
--- Self-contained migration layer for converting specID-based database keys to specIndex-based keys
---
--- This module provides:
--- 1. Detection of old format (specID keys) vs new format (specIndex keys)
--- 2. Lookup functions that work with both formats during migration
--- 3. Database migration function to convert existing data
--- 4. Can be easily removed after migration period
---
--- Note: Uses SpecCompat module for specID to specIndex conversion (centralized lookup table)
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

--- ============================ LOCALIZE ============================
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- Lua APIs
local type = type
local pairs = pairs
local tostring = tostring
local format = string.format
local CopyTable = _G.CopyTable
local tinsert = table.insert

--- @type SpecCompat
local SpecCompat

--- ============================ MODULE CREATION ============================

--- @class SpecIndexMigration : CoreModule
local SpecIndexMigration = NAG:CreateModule("SpecIndexMigration", {
    moduleType = ns.MODULE_TYPES.SERVICE,
}, {
    -- No event handlers needed
})

if not SpecIndexMigration then
    return
end

--- ============================ MODULE INITIALIZATION ============================

-- Get SpecCompat module reference (loaded before this module)
function SpecIndexMigration:ModuleInitialize()
    SpecCompat = NAG:GetModule("SpecCompat")
    if not SpecCompat then
        self:Error("SpecIndexMigration: SpecCompat module not found - migration functionality will be limited")
    end
end

--- ============================ CONSTANTS ============================

-- Migration flag key in global database
local MIGRATION_FLAG_KEY = "specIndexMigrationComplete"
local MIGRATION_BACKUP_KEY = "specIndexMigrationBackup"

--- ============================ HELPER FUNCTIONS ============================

--- Check if a key looks like a specID (large number > 10) vs specIndex (1-4)
--- @param key number The key to check
--- @return boolean True if key looks like specID, false if specIndex
local function IsSpecIDKey(key)
    if type(key) ~= "number" then
        return false
    end
    -- specIndex is typically 1-4, specID is typically > 10
    return key > 10
end

--- Check if a key looks like a specIndex (1-4)
--- @param key number The key to check
--- @return boolean True if key looks like specIndex
local function IsSpecIndexKey(key)
    if type(key) ~= "number" then
        return false
    end
    return key >= 1 and key <= 4
end

--- ============================ MIGRATION DETECTION ============================

--- Detect if database needs migration (uses specID keys instead of specIndex keys)
--- @param self SpecIndexMigration
--- @param classModule ClassBase The class module to check
--- @return boolean True if migration is needed
function SpecIndexMigration:NeedsMigration(classModule)
    if not classModule or not classModule.db then
        return false
    end

    -- Check if migration already completed
    if NAG.db.global[MIGRATION_FLAG_KEY] then
        return false
    end

    local rotations = classModule.db.class.rotations
    if not rotations then
        return false
    end

    -- Check if any rotation keys look like specIDs (old format)
    for key in pairs(rotations) do
        if IsSpecIDKey(key) then
            self:Debug("NeedsMigration: Found specID key %s in rotations", tostring(key))
            return true
        end
    end

    return false
end

--- ============================ LOOKUP HELPERS ============================

--- Convert specID → specIndex for lookups (normalize to specIndex)
--- Uses SpecCompat's unified lookup table that includes all specIDs from all game versions
--- @param self SpecIndexMigration
--- @param specIdentifier number The spec identifier (specID or specIndex)
--- @param className string The class name (e.g., "WARRIOR")
--- @return number|nil The normalized specIndex, or nil if conversion failed
function SpecIndexMigration:NormalizeSpecKey(specIdentifier, className)
    if not specIdentifier or not className then
        return nil
    end

    -- If already specIndex (1-4), return as-is
    if IsSpecIndexKey(specIdentifier) then
        return specIdentifier
    end

    -- If specID (>10), convert to specIndex using SpecCompat's lookup table
    if IsSpecIDKey(specIdentifier) then
        if SpecCompat then
            local specIndex = SpecCompat:ConvertSpecIDToSpecIndex(specIdentifier, className)
            if specIndex then
                return specIndex
            end
        end
    end

    -- If we can't determine, return as-is (might be custom or invalid)
    return specIdentifier
end

--- ============================ DATABASE MIGRATION ============================

--- Migrate database from specID keys to specIndex keys
--- @param self SpecIndexMigration
--- @param classModule ClassBase The class module to migrate
--- @return boolean success True if migration succeeded
--- @return table|nil errors Table of error messages, or nil if no errors
function SpecIndexMigration:MigrateDatabase(classModule)
    if not classModule or not classModule.db then
        return false, { "Invalid class module or database" }
    end

    local errors = {}
    local className = classModule.className:upper()

    -- Migrate rotations
    local rotations = classModule.db.class.rotations
    local newRotations = {}
    if rotations then
        for oldKey, rotationTable in pairs(rotations) do
            if IsSpecIDKey(oldKey) then
                -- Convert specID → specIndex using SpecCompat's lookup table
                if SpecCompat then
                    local specIndex = SpecCompat:ConvertSpecIDToSpecIndex(oldKey, className)
                    if specIndex then
                        newRotations[specIndex] = CopyTable(rotationTable)
                        self:Debug("Migrated rotations[%s] → rotations[%s] for %s", tostring(oldKey), tostring(specIndex), className)
                    else
                        local err = format("Could not convert specID %s to specIndex for %s rotations", tostring(oldKey), className)
                        tinsert(errors, err)
                        self:Warn(err)
                        -- Keep old key as fallback
                        newRotations[oldKey] = CopyTable(rotationTable)
                    end
                else
                    local err = format("SpecCompat not available - cannot convert specID %s to specIndex for %s rotations", tostring(oldKey), className)
                    tinsert(errors, err)
                    self:Warn(err)
                    -- Keep old key as fallback
                    newRotations[oldKey] = CopyTable(rotationTable)
                end
            elseif IsSpecIndexKey(oldKey) then
                -- Already in new format, copy as-is
                newRotations[oldKey] = CopyTable(rotationTable)
            else
                -- Unknown format, keep as-is
                newRotations[oldKey] = CopyTable(rotationTable)
                self:Warn("Unknown key format: %s, keeping as-is", tostring(oldKey))
            end
        end
        classModule.db.class.rotations = newRotations
    end

    -- Migrate selectedRotations
    local selectedRotations = classModule.db.char.selectedRotations
    local newSelectedRotations = {}
    if selectedRotations then
        for oldKey, rotationName in pairs(selectedRotations) do
            if IsSpecIDKey(oldKey) then
                -- Convert specID → specIndex using SpecCompat's lookup table
                if SpecCompat then
                    local specIndex = SpecCompat:ConvertSpecIDToSpecIndex(oldKey, className)
                    if specIndex then
                        newSelectedRotations[specIndex] = rotationName
                        self:Debug("Migrated selectedRotations[%s] → selectedRotations[%s] = %s", tostring(oldKey), tostring(specIndex), tostring(rotationName))
                    else
                        local err = format("Could not convert specID %s to specIndex for selectedRotations", tostring(oldKey))
                        tinsert(errors, err)
                        self:Warn(err)
                        -- Keep old key as fallback
                        newSelectedRotations[oldKey] = rotationName
                    end
                else
                    local err = format("SpecCompat not available - cannot convert specID %s to specIndex for selectedRotations", tostring(oldKey))
                    tinsert(errors, err)
                    self:Warn(err)
                    -- Keep old key as fallback
                    newSelectedRotations[oldKey] = rotationName
                end
            elseif IsSpecIndexKey(oldKey) then
                -- Already in new format, copy as-is
                newSelectedRotations[oldKey] = rotationName
            else
                -- Unknown format, keep as-is
                newSelectedRotations[oldKey] = rotationName
            end
        end
        classModule.db.char.selectedRotations = newSelectedRotations
    end

    -- Migrate specSpellLocations
    local specSpellLocations = classModule.db.class.specSpellLocations
    local newSpecSpellLocations = {}
    if specSpellLocations then
        for oldKey, locations in pairs(specSpellLocations) do
            if IsSpecIDKey(oldKey) then
                -- Convert specID → specIndex using SpecCompat's lookup table
                if SpecCompat then
                    local specIndex = SpecCompat:ConvertSpecIDToSpecIndex(oldKey, className)
                    if specIndex then
                        newSpecSpellLocations[specIndex] = CopyTable(locations)
                        self:Debug("Migrated specSpellLocations[%s] → specSpellLocations[%s]", tostring(oldKey), tostring(specIndex))
                    else
                        local err = format("Could not convert specID %s to specIndex for specSpellLocations", tostring(oldKey))
                        tinsert(errors, err)
                        self:Warn(err)
                        -- Keep old key as fallback
                        newSpecSpellLocations[oldKey] = CopyTable(locations)
                    end
                else
                    local err = format("SpecCompat not available - cannot convert specID %s to specIndex for specSpellLocations", tostring(oldKey))
                    tinsert(errors, err)
                    self:Warn(err)
                    -- Keep old key as fallback
                    newSpecSpellLocations[oldKey] = CopyTable(locations)
                end
            elseif IsSpecIndexKey(oldKey) then
                -- Already in new format, copy as-is
                newSpecSpellLocations[oldKey] = CopyTable(locations)
            else
                -- Unknown format, keep as-is
                newSpecSpellLocations[oldKey] = CopyTable(locations)
            end
        end
        classModule.db.class.specSpellLocations = newSpecSpellLocations
    end

    -- Mark migration as complete
    if #errors == 0 then
        NAG.db.global[MIGRATION_FLAG_KEY] = true
        self:Info("Migration completed successfully for %s", className)
        return true, nil
    else
        self:Warn("Migration completed with %d errors for %s", #errors, className)
        return true, errors  -- Still return true, but with errors
    end
end
