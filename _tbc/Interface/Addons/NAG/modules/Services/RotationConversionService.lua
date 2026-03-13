--- @module "NAG.RotationConversionService"
--- Centralized rotation conversion orchestrator
--- Bridges rotation string, legacy AST, proto AST, and WoWSims JSON formats
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, GPT-5 Codex

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase

-- ============================ LOCAL DEPENDENCIES ============================

local TableUtils = ns.TableUtils
local ASTCore
local ASTProto
local ASTSchema
local ASTSchemaEmitter
local ASTCache
local debugprofilestop = debugprofilestop

local RotationConversionService = NAG:CreateModule("RotationConversionService", nil, {
    moduleType = ns.MODULE_TYPES.SERVICE,
    debugCategories = {
        ns.DEBUG_CATEGORIES.UTILITIES,
        ns.DEBUG_CATEGORIES.PROCESSORS
    },
    slashCommands = {
        ["rotation_roundtrip"] = {
            handler = "RunRoundTripDiagnostics",
            help = "Validate round trips for all rotations. Use ast_only (or parse_only) to only parse (no emit/compare); add verbose to see AST summary.",
            root = "nagdebug",
            path = {"rotation", "roundtrip"},
            category = "Rotation"
        }
    }
})
local module = RotationConversionService
ns.RotationConversionService = RotationConversionService

-- ============================ CONSTANTS & STATE =============================

module.FORMATS = {
    ROTATION_STRING = "rotation_string",
    PROTO_AST = "proto_ast",
    WOWSIMS_JSON = "wowsims_json",
}

local Format = module.FORMATS

--- @class RotationConversionDiagnostics
--- @field from string
--- @field to string
--- @field success boolean
--- @field steps table[]
--- @field warnings string[]
--- @field errors string[]
--- @field metadata table
local function CreateDiagnostics(fromFormat, toFormat)
    return {
        from = fromFormat,
        to = toFormat,
        success = false,
        steps = {},
        warnings = {},
        errors = {},
        metadata = {},
    }
end

local function RecordStep(diagnostics, step)
    table.insert(diagnostics.steps, step)
end

local function AddWarning(diagnostics, message)
    table.insert(diagnostics.warnings, message)
end

local function AddError(diagnostics, message)
    table.insert(diagnostics.errors, message)
end

local function NormalizeFormat(format)
    if not format then return nil end
    if type(format) == "string" then
        local lower = format:lower()
        if lower == "rotation" or lower == "rotationstring" then
            return Format.ROTATION_STRING
        elseif lower == "proto" or lower == "proto_ast" or lower == "ast" then
            return Format.PROTO_AST
        elseif lower == "wowsims" or lower == "wowsims_json" or lower == "json" then
            return Format.WOWSIMS_JSON
        end
    end
    return format
end

local function EnsureASTDependencies()
    if not ASTCore then
        ASTCore = ns.ASTCore
    end
    if not ASTProto then
        ASTProto = ns.ASTProto
    end
    if not ASTSchema then
        ASTSchema = ns.ASTSchema
    end
    if not ASTSchemaEmitter then
        ASTSchemaEmitter = ns.ASTSchemaEmitter
    end
    if not ASTCache then
        ASTCache = ns.ASTCache
    end
end

-- Parser reference is resolved lazily to avoid circular initialization issues
local NAGStringParser

function module:ModuleInitialize()
    NAGStringParser = NAG:GetModule("NAGStringParser")
    EnsureASTDependencies()
end


local function EnsureParserAvailability()
        return NAGStringParser
end

-- ============================ HELPER FUNCTIONS ==============================

local function CloneIfPossible(payload)
    if payload and type(payload) == "table" and payload.clone then
        return payload:clone()
    end
    return payload
end

-- BuildRotationStringFromLegacyRotation removed - clause format no longer supported

local function NormalizeProtoAST(ast)
    EnsureASTDependencies()

    if not ast or type(ast) ~= "table" then
        return ast
    end

    -- Normalize list items in priority_list that don't have type field
    if ast.type == ASTCore.NodeType.ROTATION and ast.priority_list then
        for i, item in ipairs(ast.priority_list) do
            if type(item) == "table" and not item.type and item.action then
                -- This looks like a list item without explicit type
                -- Note: condition belongs on APLAction, not APLListItem (per schema)
                -- If condition exists on item, it should be migrated to item.action.condition
                local normalizedItem = {
                    type = ASTCore.NodeType.LIST_ITEM,
                    action = item.action,
                    notes = item.notes,
                    hide = item.hide,
                }

                -- Migrate condition from list item to action if present (legacy data)
                if item.condition and normalizedItem.action and type(normalizedItem.action) == "table" then
                    if not normalizedItem.action.condition then
                        normalizedItem.action.condition = item.condition
                    end
                end

                ast.priority_list[i] = normalizedItem
            end
        end
    end

    -- Normalize prepull_actions similarly
    if ast.type == ASTCore.NodeType.ROTATION and ast.prepull_actions then
        for i, item in ipairs(ast.prepull_actions) do
            if type(item) == "table" and not item.type and item.action then
                -- Note: condition belongs on APLAction, not APLListItem (per schema)
                -- If condition exists on item, it should be migrated to item.action.condition
                local normalizedItem = {
                    type = ASTCore.NodeType.LIST_ITEM,
                    action = item.action,
                    do_at_value = item.do_at_value,
                    hide = item.hide
                }

                -- Migrate condition from list item to action if present (legacy data)
                if item.condition and normalizedItem.action and type(normalizedItem.action) == "table" then
                    if not normalizedItem.action.condition then
                        normalizedItem.action.condition = item.condition
                    end
                end

                ast.prepull_actions[i] = normalizedItem
            end
        end
    end

    return ast
end

--- Normalize and convert plain proto table to ASTNode if needed
--- @param ast table|ASTNode The proto AST (plain table or ASTNode)
--- @return ASTNode|nil The ASTNode (or original if already a node)
--- @return string|nil Error message if conversion failed
local function EnsureProtoASTNode(ast)
    EnsureASTDependencies()

    if ASTCore.IsNode(ast) then
        return ast, nil
    end

    if type(ast) ~= "table" or not ast.type then
        return nil, "Payload is not a proto-compatible AST node"
    end

    -- Normalize structure (add type fields to list items if missing)
    local normalized = NormalizeProtoAST(ast)

    -- Convert plain proto table to ASTNode
    local ok, converted = pcall(ASTCore.FromProto, normalized)
    if ok and converted then
        return converted, nil
    else
        local errMsg = converted and tostring(converted) or "unknown error"
        return nil, string.format("Failed to convert proto table to ASTNode: %s", errMsg)
    end
end

local function ValidateProtoAST(ast, diagnostics)
    EnsureASTDependencies()

    -- Convert plain table (from JSON) to ASTNode if needed
    local nodeToValidate, err = EnsureProtoASTNode(ast)
    if not nodeToValidate then
        return false, err or "Payload is not a proto-compatible AST node"
    end

    local valid, issues = ASTSchema.Validate(nodeToValidate)
    if not valid then
        if issues then
            for _, issue in ipairs(issues) do
                AddError(diagnostics, string.format("[%s] %s at %s", issue.type, issue.message, issue.path or "root"))
            end
        end
        return false, "Proto AST validation failed"
    end

    return true, nil
end

-- ============================ ROUND-TRIP NORMALIZATION =============================

local function AppendList(target, source)
    if not target or not source then
        return
    end

    for index = 1, #source do
        target[#target + 1] = source[index]
    end
end

local function CanonicalizeValue(value, visited)
    if type(value) ~= "table" then
        return value
    end

    visited = visited or {}
    if visited[value] then
        return visited[value]
    end

    local clone = {}
    visited[value] = clone

    for key, nested in pairs(value) do
        clone[key] = CanonicalizeValue(nested, visited)
    end

    return clone
end

--- Normalize a single expression string for comparison (spaces, whole-number floats, comma spacing)
--- @param s string
--- @return string
local function NormalizeExprString(s)
    if not s or type(s) ~= "string" then
        return ""
    end
    local t = s:gsub("[ \t]+", " "):gsub("^%s+", ""):gsub("%s+$", "")
    t = t:gsub("(%d+)%.0+([^%d]|$)", "%1%2")
    -- Collapse optional space after comma so "nil, NAG.X" and "nil,NAG.X" compare equal (emitter uses ", ")
    t = t:gsub(",%s+", ",")
    return t
end

--- Canonicalize a condition string by parse+reemit so equivalent expressions (e.g. different parens) compare equal.
--- @param condStr string Emitted condition expression
--- @return string|nil Canonical form or nil if parse/emit failed
local function CanonicalizeConditionString(condStr)
    if not condStr or type(condStr) ~= "string" or condStr == "(none)" or condStr == "(emit failed)" then
        return nil
    end
    local parser = NAGStringParser
    if not parser then
        return nil
    end
    -- Parse as a fake clause to get condition value AST
    local fakeClause = condStr .. " and NAG:Cast(1)"
    local clause = parser:ParseClause(fakeClause, nil, nil)
    if not clause or not clause.condition then
        return nil
    end
    local cond = clause.condition
    local valueNode = (type(cond.value) == "table") and cond.value or cond
    local ok, out = pcall(ASTSchemaEmitter.EmitValueNode, valueNode, nil)
    if not ok or not out or type(out) ~= "string" then
        return nil
    end
    return out
end

--- Compare two rotation proto ASTs by emitted action + condition strings (so .and vs .not structure differences are ignored)
--- @param baseline table Stripped proto AST (ROTATION with priority_list)
--- @param candidate table Stripped proto AST
--- @param differences table|nil Table to append difference messages to
--- @return boolean equal
local function CompareRotationASTsByEmission(baseline, candidate, differences)
    differences = differences or {}
    local plB = baseline and baseline.priority_list
    local plC = candidate and candidate.priority_list
    if not plB or not plC then
        if (plB and not plC) or (not plB and plC) then
            differences[#differences + 1] = "root.priority_list: one side missing"
        end
        return false
    end
    if #plB ~= #plC then
        differences[#differences + 1] = string.format("root.priority_list: length mismatch (%d vs %d)", #plB, #plC)
        return false
    end
    for i = 1, #plB do
        local itemB = plB[i]
        local itemC = plC[i]
        local actB = itemB and itemB.action
        local actC = itemC and itemC.action
        local okB, strActB = pcall(ASTSchemaEmitter.EmitActionNode, actB)
        local okC, strActC = pcall(ASTSchemaEmitter.EmitActionNode, actC)
        if not okB or not okC then
            differences[#differences + 1] = string.format("root.priority_list.%d.action: emit failed (baseline=%s, candidate=%s)", i, tostring(strActB), tostring(strActC))
            return false
        end
        local normActB = NormalizeExprString(strActB)
        local normActC = NormalizeExprString(strActC)
        if normActB ~= normActC then
            differences[#differences + 1] = string.format("root.priority_list.%d.action: emitted action differs", i)
            return false
        end
        local condB = actB and actB.condition
        local condC = actC and actC.condition
        -- Proto condition may be { value = valueNode } (schema) or the value node directly; emit the inner value
        local valueNodeB = (condB and type(condB.value) == "table") and condB.value or condB
        local valueNodeC = (condC and type(condC.value) == "table") and condC.value or condC
        local strCondB, strCondC = "(none)", "(none)"
        if valueNodeB then
            local ok, out = pcall(ASTSchemaEmitter.EmitValueNode, valueNodeB, nil)
            strCondB = (ok and out and type(out) == "string") and out or "(emit failed)"
        end
        if valueNodeC then
            local ok, out = pcall(ASTSchemaEmitter.EmitValueNode, valueNodeC, nil)
            strCondC = (ok and out and type(out) == "string") and out or "(emit failed)"
        end
        local normCondB = NormalizeExprString(strCondB)
        local normCondC = NormalizeExprString(strCondC)
        if normCondB ~= normCondC then
            -- Try canonical compare: parse both and re-emit so equivalent parens (e.g. ((not A) and (not B)) vs not A and not B) match
            local canB = CanonicalizeConditionString(strCondB)
            local canC = CanonicalizeConditionString(strCondC)
            if canB and canC and NormalizeExprString(canB) == NormalizeExprString(canC) then
                -- Semantically equal
            else
                differences[#differences + 1] = string.format("root.priority_list.%d.action.condition: emitted condition differs (structurally .and vs .not etc)", i)
                return false
            end
        end
    end
    return true
end

--- Strip cache/metadata keys (__*) from AST so semantic compare ignores parser artifacts
--- @param value any
--- @param visited table|nil
--- @return any
local function StripCacheMetadata(value, visited)
    if type(value) ~= "table" then
        return value
    end
    visited = visited or {}
    if visited[value] then
        return visited[value]
    end
    local out = {}
    visited[value] = out
    for key, nested in pairs(value) do
        if type(key) ~= "string" or not key:match("^__") then
            out[key] = StripCacheMetadata(nested, visited)
        end
    end
    return out
end

--- Strip Lua line comments (-- to EOL) from a rotation string for comparison.
--- Respects string literals so "--" inside "..." or '...' is not stripped.
--- @param str string
--- @return string
local function StripRotationComments(str)
    if not str or type(str) ~= "string" or str == "" then
        return str or ""
    end
    local out = {}
    local len = #str
    local i = 1
    local inString = nil   -- nil, '"', or "'"
    local inComment = false
    while i <= len do
        local c = str:sub(i, i)
        if inComment then
            if c == "\n" or c == "\r" then
                inComment = false
                out[#out + 1] = c
                i = i + 1
            else
                i = i + 1
            end
        elseif inString then
            out[#out + 1] = c
            if c == "\\" then
                i = i + 1
                if i <= len then
                    out[#out + 1] = str:sub(i, i)
                    i = i + 1
                end
            elseif c == inString then
                inString = nil
                i = i + 1
            else
                i = i + 1
            end
        else
            if c == "\"" or c == "'" then
                inString = c
                out[#out + 1] = c
                i = i + 1
            elseif c == "-" and i < len and str:sub(i + 1, i + 1) == "-" then
                inComment = true
                i = i + 2
            else
                out[#out + 1] = c
                i = i + 1
            end
        end
    end
    return table.concat(out)
end

local function NormalizeRotationString(payload, options)
    if type(payload) ~= "string" then
        return nil, string.format("Rotation string payload must be a string (got %s)", type(payload))
    end

    if options and options.strict then
        return payload, nil
    end

    local normalized = payload:gsub("\r\n", "\n")
    normalized = normalized:gsub("[ \t]+\n", "\n")
    normalized = normalized:gsub("^%s+", "")
    normalized = normalized:gsub("%s+$", "")

    -- Ignore comment location/content for round-trip: strip line comments before comparing
    normalized = StripRotationComments(normalized)
    normalized = normalized:gsub("[ \t]+\n", "\n")
    normalized = normalized:gsub("\n\n+", "\n\n")
    normalized = normalized:gsub("^%s+", "")
    normalized = normalized:gsub("%s+$", "")

    -- Collapse horizontal whitespace so "a  <=  b" and "a <= b" compare equal
    normalized = normalized:gsub("[ \t]+", " ")

    -- Normalize whole-number floats to integers so "25.0" and "25" compare equal (e.g. NAG:RemainingTime() - 25.0)
    normalized = normalized:gsub("(%d+)%.0+([^%d]|$)", "%1%2")

    normalized = normalized:gsub("^%s+", "")
    normalized = normalized:gsub("%s+$", "")

    return normalized, nil
end

local function NormalizeProtoAST(payload, normalizeOptions)
    if not payload then
        return nil, "Proto AST payload is nil"
    end

    if ASTCore.IsNode and ASTCore.IsNode(payload) then
        local ok, proto = pcall(function()
            return payload:toProto()
        end)

        if not ok then
            return nil, string.format("Failed to serialize proto AST: %s", tostring(proto))
        end

        return CanonicalizeValue(proto), nil
    end

    if type(payload) == "table" then
        if normalizeOptions and normalizeOptions.strict then
            return CanonicalizeValue(TableUtils.DeepClone(payload)), nil
        end
        return CanonicalizeValue(payload), nil
    end

    return nil, "Invalid proto AST payload"
end

local function NormalizeWoWSimsPayload(payload, normalizeOptions)
    if type(payload) ~= "table" then
        return nil, "WoWSims payload must be a table"
    end

    if normalizeOptions and normalizeOptions.strict then
        return CanonicalizeValue(TableUtils.DeepClone(payload)), nil
    end

    local normalized = ASTProto.TransformFromWoWSimsFormat(payload)
    return CanonicalizeValue(normalized), nil
end

local function NormalizePayload(format, payload, normalizeOptions)
    if format == Format.ROTATION_STRING then
        return NormalizeRotationString(payload, normalizeOptions)
    elseif format == Format.PROTO_AST then
        return NormalizeProtoAST(payload, normalizeOptions)
    elseif format == Format.WOWSIMS_JSON then
        return NormalizeWoWSimsPayload(payload, normalizeOptions)
    end

    return nil, string.format("Unsupported format for normalization: %s", tostring(format))
end

local function CombineVisited(visited)
    if visited then
        visited.first = visited.first or {}
        visited.second = visited.second or {}
    else
        visited = {
            first = {},
            second = {},
        }
    end

    return visited
end

local function DeepEqual(first, second, differences, path, visited)
    differences = differences or {}
    visited = CombineVisited(visited)
    path = path or "root"

    if first == second then
        return true
    end

    local typeFirst = type(first)
    local typeSecond = type(second)

    if typeFirst ~= typeSecond then
        differences[#differences + 1] = string.format("%s: type mismatch (%s vs %s)", path, typeFirst, typeSecond)
        return false
    end

    if typeFirst ~= "table" then
        differences[#differences + 1] = string.format("%s: value mismatch (%s vs %s)", path, tostring(first), tostring(second))
        return false
    end

    if visited.first[first] and visited.second[second] then
        return true
    elseif visited.first[first] or visited.second[second] then
        differences[#differences + 1] = string.format("%s: cyclic reference mismatch", path)
        return false
    end

    visited.first[first] = true
    visited.second[second] = true

    local equal = true
    local processed = {}

    for key, value in pairs(first) do
        processed[key] = true
        local childPath = path .. "." .. tostring(key)
        local secondValue = second[key]

        if secondValue == nil then
            differences[#differences + 1] = string.format("%s: missing in second value", childPath)
            equal = false
        else
            if not DeepEqual(value, secondValue, differences, childPath, visited) then
                equal = false
            end
        end
    end

    for key in pairs(second) do
        if not processed[key] then
            local childPath = path .. "." .. tostring(key)
            differences[#differences + 1] = string.format("%s: missing in first value", childPath)
            equal = false
        end
    end

    return equal
end

local function ComparePayloads(format, baseline, candidate, normalizeOptions)
    local normalizedBaseline
    if normalizeOptions and normalizeOptions.baselineCanonical then
        normalizedBaseline = baseline
    else
        local baselineError
        normalizedBaseline, baselineError = NormalizePayload(format, baseline, normalizeOptions)
        if not normalizedBaseline then
            return false, {baselineError or "Baseline normalization failed"}, nil, nil
        end
    end

    local normalizedCandidate, candidateError = NormalizePayload(format, candidate, normalizeOptions)
    if not normalizedCandidate then
        return false, {candidateError or "Candidate normalization failed"}, normalizedBaseline, nil
    end

    local differences = {}
    local equal = DeepEqual(normalizedBaseline, normalizedCandidate, differences, "root")

    return equal, differences, normalizedBaseline, normalizedCandidate
end

-- ============================ DIRECT CONVERTERS =============================

local converters = {}

local function RegisterConverter(fromFormat, toFormat, fn)
    converters[fromFormat] = converters[fromFormat] or {}
    converters[fromFormat][toFormat] = fn
end

-- ROTATION_STRING → PROTO_AST: NAGStringParser now outputs proto AST directly
RegisterConverter(Format.ROTATION_STRING, Format.PROTO_AST, function(service, payload, options, diagnostics)
    EnsureASTDependencies()
    options = options or {}
    local useCache = options.useCache
    local validate = options.validate ~= false

    if type(payload) ~= "string" or payload == "" then
        return nil, "Rotation string payload must be a non-empty string"
    end

    if useCache ~= false and ASTCache then
        local cached
        if options and options.cacheReadOnly then
            cached = ASTCache.GetReadOnly(payload)
        else
            cached = ASTCache.Get(payload)
        end
        if cached then
            diagnostics.metadata.cacheHit = true
            return cached, nil
        end
    end

    local parser = EnsureParserAvailability()
    if not parser then
        return nil, "NAGStringParser module not available"
    end

    -- NAGStringParser now outputs proto AST directly
    local protoAst, err = parser:ParseRotationString(payload)
    if not protoAst then
        return nil, err or "Failed to parse rotation string"
    end

    if validate then
        local ok, validationErr = ValidateProtoAST(protoAst, diagnostics)
        if not ok then
            return nil, validationErr
        end
    end

    if useCache ~= false and ASTCache and protoAst then
        ASTCache.Put(payload, protoAst)
    end

    diagnostics.metadata.clauseCount = protoAst.priority_list and #protoAst.priority_list or 0
    diagnostics.metadata.originalStringLength = #payload
    return protoAst, nil
end)

RegisterConverter(Format.PROTO_AST, Format.WOWSIMS_JSON, function(_, payload, options, diagnostics)
    EnsureASTDependencies()
    options = options or {}
    local validate = options.validate ~= false

    -- Normalize and convert plain table to ASTNode if needed
    local protoNode, err = EnsureProtoASTNode(payload)
    if not protoNode then
        return nil, err or "Failed to convert proto AST payload"
    end

    if validate then
        local ok, validationErr = ValidateProtoAST(protoNode, diagnostics)
        if not ok then
            return nil, validationErr
        end
    end

    local exported, err = ASTProto.ExportToWoWSims(protoNode)
    if not exported then
        return nil, err or "Failed to export proto AST to WoWSims format"
    end

    return exported, nil
end)

RegisterConverter(Format.WOWSIMS_JSON, Format.PROTO_AST, function(_, payload, _, diagnostics)
    EnsureASTDependencies()
    if not payload or type(payload) ~= "table" then
        return nil, "WoWSims payload must be a table"
    end

    local protoAst, err = ASTProto.ImportFromWoWSims(payload)
    if not protoAst then
        return nil, err or "Failed to import WoWSims data"
    end

    diagnostics.metadata.importedNodeCount = type(protoAst) == "table" and TableUtils.Size(protoAst) or nil

    return protoAst, nil
end)

RegisterConverter(Format.PROTO_AST, Format.ROTATION_STRING, function(service, payload, options, diagnostics)
    EnsureASTDependencies()
    options = options or {}
    local validate = options.validate ~= false

    -- Normalize and convert plain table to ASTNode if needed
    local protoNode, err = EnsureProtoASTNode(payload)
    if not protoNode then
        return nil, err or "Failed to convert proto AST payload"
    end

    if validate then
        local ok, validationErr = ValidateProtoAST(protoNode, diagnostics)
        if not ok then
            return nil, validationErr
        end
    end

    -- Use ASTSchemaEmitter exclusively - no fallback to clause format
    if not ASTSchemaEmitter or not ASTSchemaEmitter.EmitRotationString then
        return nil, "ASTSchemaEmitter not available"
    end

    local rotationString, emitErr = ASTSchemaEmitter.EmitRotationString(protoNode, options, diagnostics)
    if not rotationString then
        return nil, emitErr or "Failed to emit rotation string from proto AST"
    end
    if type(rotationString) ~= "string" then
        return nil, string.format("Emitter did not return a string (got %s)", type(rotationString))
    end

    diagnostics.metadata.generatedClauseCount = protoNode.priority_list and #protoNode.priority_list or 0
    diagnostics.metadata.emitter = "schema"
    return rotationString, nil
end)

RegisterConverter(Format.ROTATION_STRING, Format.WOWSIMS_JSON, function(service, payload, options, diagnostics)
    EnsureASTDependencies()
    local protoAst, err = converters[Format.ROTATION_STRING][Format.PROTO_AST](service, payload, options, diagnostics)
    if not protoAst then
        return nil, err
    end

    return converters[Format.PROTO_AST][Format.WOWSIMS_JSON](service, protoAst, options, diagnostics)
end)

RegisterConverter(Format.WOWSIMS_JSON, Format.ROTATION_STRING, function(service, payload, options, diagnostics)
    EnsureASTDependencies()
    local protoAst, err = converters[Format.WOWSIMS_JSON][Format.PROTO_AST](service, payload, options, diagnostics)
    if not protoAst then
        return nil, err
    end

    return converters[Format.PROTO_AST][Format.ROTATION_STRING](service, protoAst, options, diagnostics)
end)

-- ============================ CORE API =====================================

--- Convert between supported rotation formats
--- @param fromFormat string
--- @param toFormat string
--- @param payload any
--- @param options table|nil
--- @return any result
--- @return RotationConversionDiagnostics diagnostics
function module:Convert(fromFormat, toFormat, payload, options)
    EnsureASTDependencies()
    local normalizedFrom = NormalizeFormat(fromFormat)
    local normalizedTo = NormalizeFormat(toFormat)

    local diagnostics = CreateDiagnostics(normalizedFrom, normalizedTo)

    if not normalizedFrom or not converters[normalizedFrom] then
        AddError(diagnostics, string.format("Unsupported source format: %s", tostring(fromFormat)))
        return nil, diagnostics
    end
    if not normalizedTo then
        AddError(diagnostics, string.format("Unsupported target format: %s", tostring(toFormat)))
        return nil, diagnostics
    end

    if normalizedFrom == normalizedTo then
        diagnostics.success = true
        diagnostics.metadata.noop = true
        return CloneIfPossible(payload), diagnostics
    end

    local direct = converters[normalizedFrom] and converters[normalizedFrom][normalizedTo]
    local result, err

    if direct then
        local startTime = debugprofilestop and debugprofilestop() or nil
        result, err = direct(self, payload, options, diagnostics)
        if result then
            diagnostics.success = true
        else
            AddError(diagnostics, err or "Conversion failed")
        end
        RecordStep(diagnostics, {
            from = normalizedFrom,
            to = normalizedTo,
            duration = startTime and ((debugprofilestop() - startTime) / 1000) or nil,
            direct = true,
        })
        return result, diagnostics
    end

    -- Fallback via proto AST hub
    local protoResult = payload
    local currentFormat = normalizedFrom

    if currentFormat ~= Format.PROTO_AST then
        local toProto = converters[currentFormat] and converters[currentFormat][Format.PROTO_AST]
        if not toProto then
            AddError(diagnostics, string.format("No conversion path from %s to proto AST", tostring(currentFormat)))
            return nil, diagnostics
        end
        local startTime = debugprofilestop and debugprofilestop() or nil
        protoResult, err = toProto(self, payload, options, diagnostics)
        RecordStep(diagnostics, {
            from = currentFormat,
            to = Format.PROTO_AST,
            duration = startTime and ((debugprofilestop() - startTime) / 1000) or nil,
            direct = false,
        })
        if not protoResult then
            AddError(diagnostics, err or "Failed to convert to proto AST")
            return nil, diagnostics
        end
        currentFormat = Format.PROTO_AST
    end

    if normalizedTo == Format.PROTO_AST then
        diagnostics.success = true
        return protoResult, diagnostics
    end

    local fromProto = converters[Format.PROTO_AST] and converters[Format.PROTO_AST][normalizedTo]
    if not fromProto then
        AddError(diagnostics, string.format("No conversion path from proto AST to %s", tostring(normalizedTo)))
        return nil, diagnostics
    end

    local startTime = debugprofilestop and debugprofilestop() or nil
    result, err = fromProto(self, protoResult, options, diagnostics)
    RecordStep(diagnostics, {
        from = Format.PROTO_AST,
        to = normalizedTo,
        duration = startTime and ((debugprofilestop() - startTime) / 1000) or nil,
        direct = false,
    })

    if not result then
        AddError(diagnostics, err or "Failed to convert from proto AST")
        diagnostics.success = false
        return nil, diagnostics
    end

    diagnostics.success = #diagnostics.errors == 0
    return result, diagnostics
end

--- Validate round-trip conversion fidelity between two formats
--- @param fromFormat string Source format identifier
--- @param toFormat string Target format identifier
--- @param payload any Original payload
--- @param options table|nil Round-trip options (iterations, strict, forwardOptions, backwardOptions)
--- @return any finalPayload Payload produced by the final backward conversion (if successful)
--- @return table diagnostics Round-trip diagnostics with per-iteration results
function module:ValidateRoundTrip(fromFormat, toFormat, payload, options)
    EnsureASTDependencies()

    options = options or {}
    local normalizedFrom = NormalizeFormat(fromFormat)
    local normalizedTo = NormalizeFormat(toFormat)

    -- semanticRoundTrip is stored in metadata for UI/slash; rotation_string round-trip always compares
    -- normalized original vs normalized emitted (content must match; only formatting is normalized).
    local diagnostics = {
        from = normalizedFrom,
        to = normalizedTo,
        iterations = 0,
        rounds = {},
        errors = {},
        warnings = {},
        success = false,
        metadata = {
            strict = options.strict and true or false,
            semanticRoundTrip = options.semanticRoundTrip ~= false,
        }
    }

    if not normalizedFrom or not converters[normalizedFrom] then
        diagnostics.errors[1] = string.format("Unsupported source format: %s", tostring(fromFormat))
        return nil, diagnostics
    end

    if not normalizedTo or not converters[normalizedTo] then
        diagnostics.errors[#diagnostics.errors + 1] = string.format("Unsupported target format: %s", tostring(toFormat))
        return nil, diagnostics
    end

    local iterations = tonumber(options.iterations) or 1
    if iterations < 1 then
        iterations = 1
    end
    diagnostics.iterations = iterations

    -- When from == to (e.g. rotation_string round-trip), use proto_ast as intermediate so we actually parse and emit
    local forwardToFormat = normalizedTo
    local backwardFromFormat = normalizedTo
    if normalizedFrom == normalizedTo then
        local toProto = converters[normalizedFrom] and converters[normalizedFrom][Format.PROTO_AST]
        local fromProto = converters[Format.PROTO_AST] and converters[Format.PROTO_AST][normalizedFrom]
        if toProto and fromProto then
            forwardToFormat = Format.PROTO_AST
            backwardFromFormat = Format.PROTO_AST
        end
    end

    local compareOptions = { strict = diagnostics.metadata.strict }
    local normalizedBaseline, baselineError = NormalizePayload(normalizedFrom, payload, compareOptions)
    if not normalizedBaseline then
        diagnostics.errors[#diagnostics.errors + 1] = baselineError or "Failed to normalize baseline payload"
        return nil, diagnostics
    end

    diagnostics.normalizedBaseline = normalizedBaseline
    compareOptions.baselineCanonical = true

    local forwardOptions = options.forwardOptions
    local backwardOptions = options.backwardOptions
    local currentPayload = payload

    for iteration = 1, iterations do
        local roundInfo = {
            iteration = iteration,
            normalizedBaseline = normalizedBaseline,
        }

        local forwardResult, forwardDiagnostics = self:Convert(normalizedFrom, forwardToFormat, currentPayload, forwardOptions)
        roundInfo.forward = forwardDiagnostics

        if not forwardResult then
            local errorMessage = (forwardDiagnostics and forwardDiagnostics.errors and forwardDiagnostics.errors[1])
                or "unknown"
            diagnostics.errors[#diagnostics.errors + 1] = string.format(
                "Iteration %d forward conversion failed: %s", iteration, errorMessage)
            AppendList(diagnostics.warnings, forwardDiagnostics and forwardDiagnostics.warnings)
            diagnostics.rounds[#diagnostics.rounds + 1] = roundInfo
            return nil, diagnostics
        end

        AppendList(diagnostics.warnings, forwardDiagnostics and forwardDiagnostics.warnings)

        local backwardResult, backwardDiagnostics = self:Convert(backwardFromFormat, normalizedFrom, forwardResult, backwardOptions)
        roundInfo.backward = backwardDiagnostics

        if not backwardResult then
            local errorMessage = (backwardDiagnostics and backwardDiagnostics.errors and backwardDiagnostics.errors[1])
                or "unknown"
            diagnostics.errors[#diagnostics.errors + 1] = string.format(
                "Iteration %d backward conversion failed: %s", iteration, errorMessage)
            AppendList(diagnostics.warnings, backwardDiagnostics and backwardDiagnostics.warnings)
            diagnostics.rounds[#diagnostics.rounds + 1] = roundInfo
            return nil, diagnostics
        end

        AppendList(diagnostics.warnings, backwardDiagnostics and backwardDiagnostics.warnings)

        -- Semantic=on: compare canonical form (parse+emit each side) so paren/formatting-only differences pass.
        -- Semantic=off: compare normalized strings so content must match exactly (catches parse loss and paren differences).
        local equal, differences, _, normalizedCandidate
        local useSemantic = (normalizedFrom == Format.ROTATION_STRING) and (options.semanticRoundTrip ~= false) and (forwardToFormat == Format.PROTO_AST)
        if useSemantic then
            local candidateAST, candidateDiag = self:Convert(Format.ROTATION_STRING, Format.PROTO_AST, backwardResult, backwardOptions or {})
            if not candidateAST then
                equal = false
                differences = { "Emitted string failed to parse: " .. (candidateDiag and candidateDiag.errors and candidateDiag.errors[1] or "unknown") }
                normalizedCandidate = backwardResult
            else
                local baselineStripped = StripCacheMetadata(forwardResult)
                local candidateStripped = StripCacheMetadata(candidateAST)
                differences = {}
                equal = CompareRotationASTsByEmission(baselineStripped, candidateStripped, differences)
                normalizedCandidate = backwardResult
            end
            roundInfo.semanticCompare = true
            -- If semantic pass but normalized text differs, parser may have lost content (e.g. "X and 5 or 3" -> "X")
            if equal and iteration == 1 then
                local normOrig = NormalizePayload(Format.ROTATION_STRING, currentPayload, compareOptions)
                local normEmit = NormalizePayload(Format.ROTATION_STRING, backwardResult, compareOptions)
                if normOrig and normEmit and normOrig ~= normEmit then
                    diagnostics.warnings[#diagnostics.warnings + 1] = "Semantic match but emitted text differs from original (possible parse/emit loss; uncheck Semantic to require exact text)."
                end
            end
        else
            equal, differences, _, normalizedCandidate = ComparePayloads(
                normalizedFrom,
                normalizedBaseline,
                backwardResult,
                compareOptions
            )
        end

        roundInfo.equal = equal
        roundInfo.differences = differences
        roundInfo.normalizedCandidate = normalizedCandidate

        if not equal then
            diagnostics.errors[#diagnostics.errors + 1] = string.format(
                "Iteration %d detected mismatched payload", iteration)
            for i = 1, #differences do
                diagnostics.errors[#diagnostics.errors + 1] = string.format(
                    "  %s", differences[i])
            end
            diagnostics.rounds[#diagnostics.rounds + 1] = roundInfo
            return backwardResult, diagnostics
        end

        diagnostics.rounds[#diagnostics.rounds + 1] = roundInfo
        currentPayload = backwardResult
    end

    diagnostics.success = true
    return currentPayload, diagnostics
end

--- Convenience wrapper: convert payload to proto AST
--- @param fromFormat string
--- @param payload any
--- @param options table|nil
--- @return any
--- @return RotationConversionDiagnostics
function module:ToProto(fromFormat, payload, options)
    EnsureASTDependencies()
    return self:Convert(fromFormat, Format.PROTO_AST, payload, options)
end

--- Convenience wrapper: convert proto AST to another format
--- @param toFormat string
--- @param protoAst any
--- @param options table|nil
--- @return any
--- @return RotationConversionDiagnostics
function module:FromProto(toFormat, protoAst, options)
    EnsureASTDependencies()
    return self:Convert(Format.PROTO_AST, toFormat, protoAst, options)
end

-- ParseToClauseFormat removed - use ParseToProtoAST instead

--- Convenience wrapper: parse rotation string to proto AST
--- @param rotationString string
--- @param options table|nil
--- @return table|nil protoAST
--- @return RotationConversionDiagnostics diagnostics
function module:ParseToProtoAST(rotationString, options)
    return self:Convert(Format.ROTATION_STRING, Format.PROTO_AST, rotationString, options)
end

--- @deprecated Legacy wrapping disabled - returns proto AST directly. Use ParseToProtoAST instead.
--- Convenience wrapper: parse rotation string to legacy-wrapped proto AST
--- @param rotationString string
--- @param options table|nil
--- @return table|nil protoAST (no wrapping)
--- @return RotationConversionDiagnostics diagnostics
function module:ParseToLegacyWrappedProtoAST(rotationString, options)
    -- DISABLED: No longer wraps AST - returns proto AST directly
    -- Use ParseToProtoAST() instead for production code
    EnsureASTDependencies()
    local protoAST, diagnostics = self:ParseToProtoAST(rotationString, options)
    if not protoAST then
        return nil, diagnostics
    end
    -- Return proto AST directly (no wrapping)
    return protoAST, diagnostics
end

-- ============================ ROUND-TRIP SLASH COMMAND ======================

local function ParseRoundTripArguments(input)
    local params = {
        from = Format.ROTATION_STRING,
        to = Format.PROTO_AST,
        iterations = 1,
        strict = false,
        validate = true,
        useCache = false,
        verbose = false,
        ast_only = false,  -- when true: only parse (string → proto_ast), no emit/compare; report parse result and optional AST summary
        semanticRoundTrip = true   -- default: compare by AST (redundant parens / cache metadata ignored); use "string" to force text compare
    }

    if input and input ~= "" then
        for token in input:gmatch("%S+") do
            local lower = token:lower()
            if lower == "strict" then
                params.strict = true
            elseif lower == "verbose" or lower == "detailed" then
                params.verbose = true
            elseif lower == "ast_only" or lower == "parse_only" then
                params.ast_only = true
            elseif lower == "string" or lower == "no_semantic" then
                params.semanticRoundTrip = false
            else
                local key, value = lower:match("^(%w+)=([%w_%-]+)$")
                if key and value then
                    if key == "from" then
                        params.from = NormalizeFormat(value) or params.from
                    elseif key == "to" then
                        params.to = NormalizeFormat(value) or params.to
                    elseif key == "iterations" or key == "iter" then
                        local numeric = tonumber(value)
                        if numeric and numeric > 0 then
                            params.iterations = numeric
                        end
                    elseif key == "validate" then
                        params.validate = not (value == "0" or value == "false" or value == "no")
                    elseif key == "cache" or key == "usecache" then
                        params.useCache = value == "1" or value == "true" or value == "yes"
                    elseif key == "ast_only" or key == "parse_only" then
                        params.ast_only = (value == "1" or value == "true" or value == "yes")
                    end
                end
            end
        end
    end

    params.options = {
        iterations = params.iterations,
        strict = params.strict,
        semanticRoundTrip = params.semanticRoundTrip ~= false,
        forwardOptions = {
            validate = params.validate,
            useCache = params.useCache
        },
        backwardOptions = {
            validate = params.validate,
            useCache = params.useCache
        }
    }

    return params
end

--- Return a short summary of a parsed rotation AST (for parse-only validation).
--- @param protoAst table Rotation proto AST (type == ROTATION)
--- @param maxClauses number|nil Max clauses to include (default 20); rest summarized as "... and N more"
--- @return string Multi-line summary
local function SummaryProtoAST(protoAst, maxClauses)
    EnsureASTDependencies()
    if not protoAst or type(protoAst) ~= "table" or protoAst.type ~= ASTCore.NodeType.ROTATION then
        return "(not a rotation node)"
    end
    local pl = protoAst.priority_list or {}
    local max = (type(maxClauses) == "number" and maxClauses > 0) and maxClauses or 20
    local lines = {}
    lines[#lines + 1] = string.format("ROTATION: %d clause(s)", #pl)
    for i = 1, math.min(#pl, max) do
        local item = pl[i]
        local action = item and item.action
        local condStr = ""
        if action and action.condition then
            local ok, out = pcall(ASTSchemaEmitter.EmitValueNode, action.condition)
            condStr = (ok and out and type(out) == "string") and out or "(emit failed)"
            if #condStr > 100 then
                condStr = condStr:sub(1, 97) .. "..."
            end
        else
            condStr = "(none)"
        end
        local actStr = ""
        if action then
            local ok, out = pcall(ASTSchemaEmitter.EmitActionNode, action)
            actStr = (ok and out and type(out) == "string") and out or "(emit failed)"
            if #actStr > 70 then
                actStr = actStr:sub(1, 67) .. "..."
            end
        else
            actStr = "(none)"
        end
        lines[#lines + 1] = string.format("  [%d] cond: %s | action: %s", i, condStr, actStr)
    end
    if #pl > max then
        lines[#lines + 1] = string.format("  ... and %d more clause(s)", #pl - max)
    end
    return table.concat(lines, "\n")
end

local function GetSpecLabel(specKey)
    if specKey == 0 then
        return "Shared"
    end

    -- Convert to number if possible
    local specIndex = tonumber(specKey)
    if specIndex and specIndex >= 1 and specIndex <= 4 then
        -- Direct specIndex lookup (rotations are now keyed by specIndex)
        local SpecCompat = NAG:GetModule("SpecCompat")
        local specName = SpecCompat:GetSpecName(specIndex)
        if specName then
            return specName
        end
    end

    -- Invalid specKey (not 0-4) - return as string
    return tostring(specKey or "Unknown")
end

--- Slash command entry point to validate all rotations via round-trip conversion
--- @param input string
function module:RunRoundTripDiagnostics(input)
    EnsureASTDependencies()

    local params = ParseRoundTripArguments(input)
    if not params.from or not params.to then
        self:Error("Rotation round-trip: unsupported format selection (from=%s, to=%s)", tostring(params.from), tostring(params.to))
        return
    end

    local classModule = NAG:GetClassModule()
    if not classModule then
        self:Error("Rotation round-trip: class module not available")
        return
    end

    if classModule.IsDatabaseReady and not classModule:IsDatabaseReady() then
        self:Error("Rotation round-trip: class database not initialized")
        return
    end

    local classDB = classModule.db
    local allRotations = classDB and classDB.class and classDB.class.rotations
    if not allRotations or not next(allRotations) then
        self:Warn("Rotation round-trip: no rotations are currently loaded")
        return
    end

    local specKeys = {}
    for specKey in pairs(allRotations) do
        local numericKey = tonumber(specKey)
        specKeys[#specKeys + 1] = numericKey or specKey
    end
    table.sort(specKeys, function(a, b)
        local aNum = tonumber(a) or a
        local bNum = tonumber(b) or b
        return aNum < bNum
    end)

    local total = 0
    local successes = 0
    local failures = 0
    local warned = 0
    local skipped = 0

    if params.ast_only then
        NAG:Print(string.format("|cFFFFFF00[RoundTrip]|r Parse-only (ast_only): %s → %s (validate=%s). No emit/compare.",
            params.from,
            params.to,
            params.validate and "on" or "off"))
    else
        NAG:Print(string.format("|cFFFFFF00[RoundTrip]|r Starting %s → %s (iterations=%d, strict=%s, semantic=%s, validate=%s, cache=%s)",
            params.from,
            params.to,
            params.iterations,
            params.strict and "on" or "off",
            (params.semanticRoundTrip ~= false) and "on" or "off",
            params.validate and "on" or "off",
            params.useCache and "on" or "off"))
    end

    for _, specKey in ipairs(specKeys) do
        local rotationKey = specKey
        if type(specKey) ~= "number" and allRotations[specKey] == nil then
            local numericKey = tonumber(specKey)
            if numericKey and allRotations[numericKey] then
                rotationKey = numericKey
            end
        end

        local specRotations = allRotations[specKey]
        if specRotations then
            local rotationNames = TableUtils.Keys(specRotations)
            table.sort(rotationNames, function(a, b)
                return tostring(a):lower() < tostring(b):lower()
            end)

            for _, rotationName in ipairs(rotationNames) do
                local config = specRotations[rotationName]
                local payload = config and config.rotationString
                local specLabel = GetSpecLabel(type(specKey) == "number" and specKey or tonumber(specKey) or specKey)

                if type(payload) == "string" and payload ~= "" then
                    total = total + 1
                    if params.ast_only then
                        -- Parse-only: rotation_string → proto_ast; report parse success/failure and optional AST summary
                        local forwardResult, forwardDiagnostics = self:Convert(
                            params.from,
                            Format.PROTO_AST,
                            payload,
                            params.options.forwardOptions or params.options
                        )
                        local success = forwardResult and forwardDiagnostics and forwardDiagnostics.success
                        local errors = (forwardDiagnostics and forwardDiagnostics.errors) or {}
                        local firstError = errors[1]

                        if success then
                            successes = successes + 1
                            if params.verbose then
                                NAG:Print(string.format("|cFF00FF00PASS (parse)|r %s › %s", specLabel, rotationName))
                                local summary = SummaryProtoAST(forwardResult, 15)
                                for line in (summary or ""):gmatch("[^\n]+") do
                                    NAG:Print("  |cFFAAAAAA" .. (line:gsub("|", "||")) .. "|r")
                                end
                            else
                                NAG:Print(string.format("|cFF00FF00PASS (parse)|r %s › %s", specLabel, rotationName))
                            end
                        else
                            failures = failures + 1
                            NAG:Print(string.format("|cFFFF0000FAIL (parse)|r %s › %s - %s",
                                specLabel,
                                rotationName,
                                firstError or "parse failed"))
                            if params.verbose and #errors > 1 then
                                for i = 2, math.min(#errors, 6) do
                                    NAG:Print("  |cFF888888" .. (errors[i] or ""):gsub("|", "||") .. "|r")
                                end
                            end
                        end
                    else
                        local _, diagnostics = self:ValidateRoundTrip(
                            params.from,
                            params.to,
                            payload,
                            params.options
                        )

                        local success = diagnostics and diagnostics.success
                        local warnings = diagnostics and diagnostics.warnings or {}
                        local errors = diagnostics and diagnostics.errors or {}
                        local firstWarning = warnings[1]
                        local firstError = errors[1]

                        if success then
                            successes = successes + 1
                            if #warnings > 0 then
                                warned = warned + 1
                                NAG:Print(string.format("|cFFFFAA00WARN|r %s › %s - %s",
                                    specLabel,
                                    rotationName,
                                    firstWarning or "round trip completed with warnings"))
                            elseif params.verbose then
                                NAG:Print(string.format("|cFF00FF00PASS|r %s › %s",
                                    specLabel,
                                    rotationName))
                            end
                        else
                            failures = failures + 1
                            NAG:Print(string.format("|cFFFF0000FAIL|r %s › %s - %s",
                                specLabel,
                                rotationName,
                                firstError or "round trip failed"))
                            -- With verbose/detailed, print actual differences (first 15 to avoid chat flood)
                            if params.verbose and #errors > 1 then
                                local maxShow = 15
                                for i = 2, math.min(#errors, maxShow + 1) do
                                    NAG:Print("  |cFF888888" .. (errors[i] or ""):gsub("|", "||") .. "|r")
                                end
                                if #errors > maxShow + 1 then
                                    NAG:Print(string.format("  |cFF888888... and %d more (see DebugManager log)|r", #errors - maxShow - 1))
                                end
                            end
                        end
                    end
                else
                    skipped = skipped + 1
                    self:Warn(string.format("Rotation round-trip: skipping %s › %s (no rotationString defined)",
                        specLabel,
                        rotationName))
                end
            end
        end
    end

    NAG:Print("|cFFFFFF00[RoundTrip]|r Summary")
    NAG:Print(string.format("- Checked: %d rotation(s) across %d spec buckets", total, #specKeys))
    NAG:Print(string.format("- Success: %d", successes))
    NAG:Print(string.format("- Failures: %d", failures))
    if not params.ast_only then
        NAG:Print(string.format("- With warnings: %d", warned))
    end
    if skipped > 0 then
        NAG:Print(string.format("- Skipped (missing strings): %d", skipped))
    end

    if params.ast_only then
        if failures == 0 then
            NAG:Print("|cFF00FF00Parse-only validation completed without failures. Use full round-trip (no ast_only) to check emit.|r")
        else
            NAG:Print("|cFFFF0000Parse-only validation detected parse failures. Fix parser before round-trip.|r")
        end
    else
        if failures == 0 then
            NAG:Print("|cFF00FF00Round-trip validation completed without failures.|r")
        else
            NAG:Print("|cFFFF0000Round-trip validation detected failures. See logs above for details.|r")
        end
    end
end

return RotationConversionService
