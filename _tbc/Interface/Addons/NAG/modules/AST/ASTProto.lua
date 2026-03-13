--- @module "ASTProto"
--- Proto import/export for WoWSims integration
--- Handles conversion between NAG AST and WoWSims proto format
--- License: CC BY-NC 4.0
--- Authors: Rakizi

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local ASTCore = ns.ASTCore
local ASTAction = ns.ASTAction
local ASTValue = ns.ASTValue
local ASTRotation = ns.ASTRotation
local ASTSchema = ns.ASTSchema
local ASTVisitor = ns.ASTVisitor
local TableUtils = ns.TableUtils

local SchemaUtils = NAG:GetModule("SchemaUtils")

local ASTProto = {}
ns.ASTProto = ASTProto

-- ============================ EXPORT TO WOWSIMS ============================

--- Export AST to WoWSims-compatible proto format
--- @param ast ASTNode AST to export
--- @return table|nil Proto data in WoWSims format
--- @return string|nil error Error message if export failed
function ASTProto.ExportToWoWSims(ast)
    if not ast then
        return nil, "No AST provided"
    end

    -- Validate proto compatibility
    local compatible, err = ASTSchema.IsProtoCompatible(ast)
    if not compatible then
        return nil, err
    end

    -- Convert to proto format
    local proto = ast:toProto()

    -- Transform to WoWSims JSON format (camelCase)
    local wowsimsData = ASTProto.TransformToWoWSimsFormat(proto)

    return wowsimsData, nil
end

--- Transform proto data to WoWSims JSON format
--- Converts snake_case fields to camelCase for WoWSims compatibility
--- @param protoData table Proto data (snake_case)
--- @return table WoWSims data (camelCase)
function ASTProto.TransformToWoWSimsFormat(protoData)
    if not protoData or type(protoData) ~= "table" then
        return protoData
    end

    local FieldFormatConverter = ns.FieldFormatConverter
    if FieldFormatConverter then
        -- Use FieldFormatConverter for field-level conversion (handles nested structures)
        return FieldFormatConverter:ProtoToWoWSims(protoData)
    else
        -- Fallback to simple key conversion
        NAG:Warn("[ASTProto] FALLBACK TRACKING: Using simple key conversion fallback in ExportToWoWSims() (FieldFormatConverter unavailable)")
        return SchemaUtils:ConvertKeysToCamelCase(protoData)
    end
end

-- ============================ IMPORT FROM WOWSIMS ============================

--- Import AST from WoWSims-compatible proto format
--- @param wowsimsData table WoWSims data (camelCase)
--- @return ASTNode|nil AST node
--- @return string|nil error Error message if import failed
function ASTProto.ImportFromWoWSims(wowsimsData)
    if not wowsimsData or type(wowsimsData) ~= "table" then
        return nil, "Invalid WoWSims data"
    end

    -- Transform from WoWSims format to proto format
    local protoData = ASTProto.TransformFromWoWSimsFormat(wowsimsData)

    -- Create AST from proto data
    local success, ast = pcall(function()
        return ASTCore.FromProto(protoData)
    end)

    if not success then
        return nil, "Failed to create AST from proto data: " .. tostring(ast)
    end

    -- Validate imported AST
    local valid, issues = ASTSchema.Validate(ast)
    if not valid then
        local errorMsg = "Imported AST validation failed:"
        for _, issue in ipairs(issues or {}) do
            errorMsg = errorMsg .. string.format("\n  [%s] %s at %s", issue.type, issue.message, issue.path)
        end
        return nil, errorMsg
    end

    return ast, nil
end

--- Transform WoWSims data to proto format
--- Converts camelCase fields to snake_case
--- @param wowsimsData table WoWSims data (camelCase)
--- @return table Proto data (snake_case)
function ASTProto.TransformFromWoWSimsFormat(wowsimsData)
    if not wowsimsData or type(wowsimsData) ~= "table" then
        return wowsimsData
    end

    local FieldFormatConverter = ns.FieldFormatConverter
    if FieldFormatConverter then
        -- Use FieldFormatConverter for field-level conversion (handles nested structures)
        return FieldFormatConverter:WoWSimsToProto(wowsimsData)
    else
        -- Fallback to simple key conversion
        NAG:Warn("[ASTProto] FALLBACK TRACKING: Using simple key conversion fallback in ImportFromWoWSims() (FieldFormatConverter unavailable)")
        return SchemaUtils:ConvertKeysToSnakeCase(wowsimsData)
    end
end

-- ============================ VALIDATION HELPERS ============================

--- Validate if data can be exported to WoWSims
--- @param ast ASTNode AST to check
--- @return boolean canExport
--- @return string|nil reason Reason if cannot export
function ASTProto.CanExportToWoWSims(ast)
    if not ast then
        return false, "No AST provided"
    end

    -- Check if it's a proto AST node
    if not ASTCore.IsNode(ast) then
        return false, "AST is not a proto-compatible node"
    end

    -- Validate schema
    local compatible, err = ASTSchema.IsProtoCompatible(ast)
    if not compatible then
        return false, err
    end

    return true, nil
end

--- Get statistics about an AST for export readiness
--- @param ast ASTNode AST to analyze
--- @return table Statistics
function ASTProto.GetExportStatistics(ast)
    local stats = {
        isProtoAST = ASTCore.IsNode(ast),
        totalNodes = 0,
        nodeTypes = {},
        hasUUIDs = false,
        canExport = false,
        exportReadiness = 0, -- Percentage (0-100)
    }

    if not ast then
        return stats
    end

    -- Count nodes by type
    ASTVisitor.PreOrder(ast, function(node)
        stats.totalNodes = stats.totalNodes + 1

        local nodeType = node.type or "unknown"
        stats.nodeTypes[nodeType] = (stats.nodeTypes[nodeType] or 0) + 1

        if node.uuid then
            stats.hasUUIDs = true
        end
    end)

    -- Check export compatibility
    stats.canExport, stats.exportError = ASTProto.CanExportToWoWSims(ast)

    -- Calculate readiness percentage
    if stats.isProtoAST then
        stats.exportReadiness = stats.exportReadiness + 50
    end
    if stats.canExport then
        stats.exportReadiness = 100
    elseif stats.isProtoAST then
        stats.exportReadiness = 75 -- Proto AST but has validation issues
    end

    return stats
end

return ASTProto

