--- @module "ASTFormatDiagnostics"
--- Comprehensive AST format diagnostics for refactoring analysis
--- Bypasses validation gates to inspect raw data structures
--- License: CC BY-NC 4.0
--- Authors: Rakizi

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ HEADER LOCALS ============================
local ASTCore = ns.ASTCore
local ASTAction = ns.ASTAction
local ASTValue = ns.ASTValue
local ASTRotation = ns.ASTRotation
local ASTSchemaEmitter = ns.ASTSchemaEmitter
local TableUtils = ns.TableUtils
local AceGUI = ns.AceGUI

-- Services
local SchemaAccessor = NAG:GetModule("SchemaAccessor")
local RotationConversionService = ns.RotationConversionService
local RotationManager = ns.RotationManager

-- Lua APIs
local format = string.format
local pairs = pairs
local ipairs = ipairs
local type = type
local tostring = tostring
local tinsert = table.insert
local tconcat = table.concat
local time = time
local CreateFrame = _G.CreateFrame

-- ============================ MODULE DEFINITION ============================

--- @class ASTFormatDiagnostics
local ASTFormatDiagnostics = {}
ns.ASTFormatDiagnostics = ASTFormatDiagnostics

-- ============================ FORMAT DETECTION ============================

--- Detect format type of a node (bypasses validation)
--- @param node table|any Node to inspect
--- @param path string|nil Path for reporting
--- @return string formatType Format type: PROTO_AST, LEGACY_CLAUSE, LEGACY_MIXED, INVALID, UNKNOWN
--- @return table|nil details Additional details about the format
local function DetectFormatType(node, path)
    path = path or "root"

    if not node or type(node) ~= "table" then
        return "UNKNOWN", { reason = "Not a table", value = node }
    end

    local nodeType = node.type

    -- Check for proto AST structure
    if nodeType == ASTCore.NodeType.ACTION then
        if node.action and type(node.action) == "table" then
            return "PROTO_AST", { hasAction = true, hasCondition = node.condition ~= nil }
        else
            return "LEGACY_MIXED", { reason = "Has proto type but missing node.action structure" }
        end
    elseif nodeType == ASTCore.NodeType.VALUE then
        if node.value and type(node.value) == "table" then
            return "PROTO_AST", { hasValue = true }
        else
            return "LEGACY_MIXED", { reason = "Has proto type but missing node.value structure" }
        end
    elseif nodeType == ASTCore.NodeType.ROTATION then
        if node.priority_list and type(node.priority_list) == "table" then
            return "PROTO_AST", { hasPriorityList = true, itemCount = #node.priority_list }
        else
            return "LEGACY_MIXED", { reason = "Has proto type but missing priority_list" }
        end

    -- Check for legacy format
    elseif nodeType == "action" then
        if node.functionName or node.arguments then
            return "LEGACY_CLAUSE", { hasFunctionName = node.functionName ~= nil, hasArguments = node.arguments ~= nil }
        elseif node.action then
            return "LEGACY_MIXED", { reason = "Has legacy type but proto action structure" }
        else
            return "INVALID", { reason = "Has legacy type but no recognizable structure" }
        end
    elseif nodeType == "value" or nodeType == "function" then
        -- This is the problematic case: type="value" string without proto structure
        if node.value and type(node.value) == "table" then
            return "LEGACY_MIXED", { reason = "Has legacy type string but proto value structure" }
        else
            return "LEGACY_CLAUSE", { hasFunctionName = node.functionName ~= nil, hasArguments = node.arguments ~= nil }
        end

    -- Check for _protoAST wrapper
    elseif node._protoAST then
        return "PROTO_AST", { wrapped = true, wrappedType = type(node._protoAST) }
    end

    -- Unknown
    return "UNKNOWN", { reason = "Unrecognized node structure", nodeType = nodeType, keys = TableUtils and TableUtils.Keys(node) or {} }
end

--- Analyze format at a specific path in data structure
--- @param data table Root data structure
--- @param path string Dot-separated path (e.g., "priority_list[1].action.condition")
--- @return table|nil result Analysis result with format type and details
function ASTFormatDiagnostics.AnalyzeFormatAtPath(data, path)
    if not data or type(data) ~= "table" then
        return { format = "UNKNOWN", error = "Data is not a table", path = path }
    end

    if not path or path == "" or path == "root" then
        local formatType, details = DetectFormatType(data, "root")
        return { format = formatType, path = "root", details = details, node = data }
    end

    -- Navigate to path
    local current = data
    local pathParts = {}
    local currentPath = "root"

    -- Parse path (handles both dot notation and array notation)
    for part in path:gmatch("[^%.]+") do
        local arrayMatch = part:match("^(.+)%[(%d+)%]$")
        if arrayMatch then
            local key, index = arrayMatch, tonumber(part:match("%[(%d+)%]$"))
            if current[key] and type(current[key]) == "table" and index then
                current = current[key][index]
                currentPath = currentPath .. "." .. key .. "[" .. index .. "]"
            else
                return { format = "UNKNOWN", error = "Path not found: " .. currentPath .. "." .. part, path = path }
            end
        else
            if current[part] then
                current = current[part]
                currentPath = currentPath .. "." .. part
            else
                return { format = "UNKNOWN", error = "Path not found: " .. currentPath .. "." .. part, path = path }
            end
        end
    end

    local formatType, details = DetectFormatType(current, currentPath)
    return { format = formatType, path = currentPath, details = details, node = current }
end

-- ============================ DEEP INSPECTION ============================

--- Deep inspect a node recursively
--- @param node table|any Node to inspect
--- @param path string|nil Current path
--- @param maxDepth number|nil Maximum recursion depth
--- @param visited table|nil Visited nodes (for cycle detection)
--- @return table inspectionResult Detailed inspection result
local function DeepInspectNodeRecursive(node, path, maxDepth, visited)
    path = path or "root"
    maxDepth = maxDepth or 10
    visited = visited or {}

    local result = {
        path = path,
        type = type(node),
        format = nil,
        fields = {},
        children = {},
        issues = {}
    }

    if maxDepth <= 0 then
        result.issues[#result.issues + 1] = "Max depth reached"
        return result
    end

    if type(node) ~= "table" then
        result.format = "PRIMITIVE"
        result.value = node
        return result
    end

    -- Cycle detection
    if visited[node] then
        result.issues[#result.issues + 1] = "Circular reference detected"
        return result
    end
    visited[node] = true

    -- Detect format
    local formatType, details = DetectFormatType(node, path)
    result.format = formatType
    result.formatDetails = details

    -- Inspect all fields
    for key, value in pairs(node) do
        if type(key) == "string" and key:sub(1, 2) ~= "__" then  -- Skip internal keys
            local fieldPath = path .. "." .. key
            local fieldType = type(value)

            result.fields[key] = {
                type = fieldType,
                path = fieldPath
            }

            -- Recursively inspect table children
            if fieldType == "table" then
                local childResult = DeepInspectNodeRecursive(value, fieldPath, maxDepth - 1, visited)
                result.children[key] = childResult

                if childResult.format and childResult.format ~= "PRIMITIVE" then
                    result.fields[key].format = childResult.format
                end
            else
                result.fields[key].value = value
            end
        end
    end

    -- Check for common issues
    if formatType == "LEGACY_MIXED" then
        result.issues[#result.issues + 1] = "Mixed format detected: " .. (details.reason or "unknown")
    elseif formatType == "LEGACY_CLAUSE" then
        result.issues[#result.issues + 1] = "Legacy clause format detected (should be proto AST)"
    elseif formatType == "INVALID" then
        result.issues[#result.issues + 1] = "Invalid structure: " .. (details.reason or "unknown")
    end

    visited[node] = nil  -- Unmark for other paths
    return result
end

--- Deep inspect a node
--- @param node table|any Node to inspect
--- @param path string|nil Starting path
--- @return table inspectionResult
function ASTFormatDiagnostics.DeepInspectNode(node, path)
    return DeepInspectNodeRecursive(node, path or "root", 10, {})
end

-- ============================ CONVERSION TRACING ============================

--- Trace rotation string conversion to proto AST
--- @param rotationString string Rotation string to parse
--- @return table result Conversion trace result
function ASTFormatDiagnostics.TraceRotationStringConversion(rotationString)
    local result = {
        rotationString = rotationString,
        steps = {},
        finalAST = nil,
        errors = {},
        warnings = {}
    }

    if not rotationString or rotationString == "" then
        tinsert(result.errors, "No rotation string provided")
        return result
    end

    -- Step 1: Parse rotation string
    tinsert(result.steps, {
        step = 1,
        name = "Parse rotationString",
        status = "pending"
    })

    local parser = NAG:GetModule("NAGStringParser", true)
    if not parser then
        tinsert(result.errors, "NAGStringParser not available")
        result.steps[1].status = "error"
        return result
    end

    local parseStart = debugprofilestop()
    local protoAST, parseErr = parser:ParseRotationString(rotationString)
    local parseTime = debugprofilestop() - parseStart

    if not protoAST then
        tinsert(result.errors, "Parse failed: " .. tostring(parseErr))
        result.steps[1].status = "error"
        result.steps[1].error = tostring(parseErr)
        return result
    end

    result.steps[1].status = "success"
    result.steps[1].time = parseTime
    result.steps[1].result = "Proto AST created"

    -- Step 2: Inspect parsed AST format
    tinsert(result.steps, {
        step = 2,
        name = "Inspect parsed AST format",
        status = "pending"
    })

    local rootFormat, rootDetails = DetectFormatType(protoAST, "root")
    result.steps[2].status = "success"
    result.steps[2].format = rootFormat
    result.steps[2].details = rootDetails

    if rootFormat ~= "PROTO_AST" then
        tinsert(result.warnings, "Parsed AST is not pure proto AST: " .. rootFormat)
    end

    -- Step 3: Deep inspection for format mixing
    tinsert(result.steps, {
        step = 3,
        name = "Deep format inspection",
        status = "pending"
    })

    local inspection = DeepInspectNodeRecursive(protoAST, "root", 5, {})
    result.steps[3].status = "success"
    result.steps[3].inspection = inspection

    -- Find all format issues
    local function FindFormatIssues(node, path, issues)
        if not node or type(node) ~= "table" then
            return
        end

        local formatType = DetectFormatType(node, path)
        if formatType == "LEGACY_CLAUSE" or formatType == "LEGACY_MIXED" or formatType == "INVALID" then
            tinsert(issues, {
                path = path,
                format = formatType,
                node = node
            })
        end

        -- Recursively check children
        if node.priority_list then
            for i, item in ipairs(node.priority_list) do
                if item.action then
                    FindFormatIssues(item.action, path .. ".priority_list[" .. i .. "].action", issues)
                end
                if item.condition then
                    FindFormatIssues(item.condition, path .. ".priority_list[" .. i .. "].condition", issues)
                end
            end
        end
        if node.action then
            for key, value in pairs(node.action) do
                if type(value) == "table" then
                    FindFormatIssues(value, path .. ".action." .. key, issues)
                end
            end
        end
        if node.condition then
            FindFormatIssues(node.condition, path .. ".condition", issues)
        end
        if node.value then
            for key, value in pairs(node.value) do
                if type(value) == "table" then
                    FindFormatIssues(value, path .. ".value." .. key, issues)
                end
            end
        end
    end

    local formatIssues = {}
    FindFormatIssues(protoAST, "root", formatIssues)

    if #formatIssues > 0 then
        result.steps[3].formatIssues = formatIssues
        for _, issue in ipairs(formatIssues) do
            tinsert(result.warnings, "Format issue at " .. issue.path .. ": " .. issue.format)
        end
    end

    result.finalAST = protoAST
    return result
end

-- ============================ STORAGE ANALYSIS ============================

--- Analyze stored rotation format
--- @param rotationName string|nil Rotation name (nil = current)
--- @param specIndex number|nil Spec index (nil = current)
--- @return table result Analysis result
function ASTFormatDiagnostics.AnalyzeStoredRotation(rotationName, specIndex)
    local result = {
        rotationName = rotationName,
        specIndex = specIndex,
        found = false,
        rotationString = nil,
        aplProto = nil,
        rotationStringFormat = nil,
        aplProtoFormat = nil,
        issues = {},
        warnings = {}
    }

    -- Get current rotation if not specified
    if not rotationName or not specIndex then
        local SpecCompat = NAG:GetModule("SpecCompat")
        specIndex = specIndex or (SpecCompat and SpecCompat:GetCurrentSpecIndex())

        if not specIndex then
            tinsert(result.issues, "No specIndex available")
            return result
        end

        local classModule = NAG:GetClassModule()
        if classModule then
            rotationName = rotationName or classModule:GetSelectedRotation(specIndex)
        end
    end

    if not rotationName then
        tinsert(result.issues, "No rotation name available")
        return result
    end

    result.rotationName = rotationName
    result.specIndex = specIndex

    -- Load rotation from database
    local classModule = NAG:GetClassModule()
    if not classModule then
        tinsert(result.issues, "Class module not available")
        return result
    end

    local rotationConfig = classModule:GetRotation(specIndex, rotationName)
    if not rotationConfig then
        tinsert(result.issues, "Rotation not found: " .. tostring(rotationName))
        return result
    end

    result.found = true

    -- Inspect rotationString
    if rotationConfig.rotationString then
        result.rotationString = rotationConfig.rotationString
        result.rotationStringFormat = type(rotationConfig.rotationString) == "string" and "STRING" or "INVALID"

        if result.rotationStringFormat ~= "STRING" then
            tinsert(result.issues, "rotationString is not a string: " .. type(rotationConfig.rotationString))
        end
    else
        tinsert(result.warnings, "No rotationString field in stored rotation")
    end

    -- Inspect aplProto
    -- aplProto is required (generated during precompilation/migration)
    if rotationConfig.aplProto then
        result.aplProto = rotationConfig.aplProto
        local formatType, details = DetectFormatType(rotationConfig.aplProto, "stored.aplProto")
        result.aplProtoFormat = formatType

        if formatType ~= "PROTO_AST" then
            tinsert(result.issues, "aplProto is not proto AST format: " .. formatType)
        end
    else
        tinsert(result.issues, "Rotation missing aplProto (should have been generated during migration)")
    end

    -- Compare formats
    if result.rotationString and result.aplProto then
        -- Try to parse rotationString and compare with aplProto
        local traceResult = ASTFormatDiagnostics.TraceRotationStringConversion(result.rotationString)
        if traceResult.finalAST then
            -- Compare structures (simplified)
            if traceResult.finalAST.type ~= (result.aplProto.type or "unknown") then
                tinsert(result.issues, "rotationString and aplProto have different root types")
            end
        end
    end

    return result
end

-- ============================ EDITOR STATE ANALYSIS ============================

--- Analyze editor state
--- @return table result Analysis result
function ASTFormatDiagnostics.AnalyzeEditorState()
    local result = {
        editorOpen = false,
        workingConfig = nil,
        rotationString = nil,
        aplProto = nil,
        internalAST = nil,
        issues = {},
        warnings = {}
    }

    -- Try to access RotationEditor
    local RotationEditor = ns.RotationEditor
    if not RotationEditor then
        tinsert(result.issues, "RotationEditor not available")
        return result
    end

    -- Check if editor is open by accessing exposed currentEditorState
    local editorState = RotationEditor.currentEditorState
    if editorState then
        result.editorOpen = true
        result.workingConfig = editorState.workingConfig
        result.rotationString = editorState.workingConfig and editorState.workingConfig.rotationString or nil
        result.aplProto = editorState.workingConfig and editorState.workingConfig.aplProto or nil

        -- Get internal AST if available (from ASTEditor)
        if editorState.workingConfig and editorState.rotationStringMode == "visual" then
            local ASTEditor = ns.RotationEditorAST
            if ASTEditor and ASTEditor.GetASTFromEditorState then
                result.internalAST = ASTEditor:GetASTFromEditorState(editorState)
            end
        end

        -- Check for format consistency
        if result.rotationString and result.aplProto then
            local traceResult = ASTFormatDiagnostics.TraceRotationStringConversion(result.rotationString)
            if traceResult.finalAST then
                -- Compare with stored aplProto
                if traceResult.finalAST.type ~= (result.aplProto.type or "unknown") then
                    tinsert(result.warnings, "rotationString and aplProto have different root types")
                end
            end
        elseif result.rotationString and not result.aplProto then
            tinsert(result.issues, "Editor has rotationString but no aplProto (should have been loaded)")
        end

        -- Report editor metadata
        result.specIndex = editorState.specIndex
        result.rotationName = editorState.rotationName
        result.isDirty = editorState.isDirty
        result.currentTab = editorState.currentTab
        result.rotationStringMode = editorState.rotationStringMode
    else
        result.editorOpen = false
    end

    return result
end

-- ============================ SCHEMA INSPECTION ============================

--- Inspect schema structure
--- @param identifier string|nil Identifier (snake_case action/value identifier OR proto message type name, e.g., "cast_spell" or "APLActionCastSpell")
--- @param fieldName string|nil Field name (optional)
--- @return table result Schema inspection result
function ASTFormatDiagnostics.InspectSchemaStructure(identifier, fieldName)
    local result = {
        identifier = identifier,
        fieldName = fieldName,
        found = false,
        structure = nil,
        metadata = nil,
        issues = {}
    }

    if not SchemaAccessor then
        tinsert(result.issues, "SchemaAccessor not available")
        return result
    end

    if not identifier then
        -- List available message types
        local expansion = ns.Version and ns.Version:GetExpansion() or "mists"
        if ns.protoSchema and ns.protoSchema[expansion] and ns.protoSchema[expansion].messages then
            result.availableMessages = {}
            for msgType, _ in pairs(ns.protoSchema[expansion].messages) do
                tinsert(result.availableMessages, msgType)
            end
        end
        return result
    end

    local metadata = nil

    -- Check if identifier is snake_case format (action/value identifier)
    if identifier:match("^[a-z][a-z0-9_]*$") then
        -- Try as action identifier first
        metadata = SchemaAccessor:GetMetadataByIdentifier(identifier, nil)  -- Auto-detect type
    else
        -- Assume it's a proto message type name (e.g., "APLActionCastSpell", "APLAction", "APLValue")
        -- Try to get schema directly
        local messageSchema = SchemaAccessor:GetMessageSchema(identifier)
        if messageSchema then
            -- Build a metadata-like structure from the schema
            metadata = {
                protoName = identifier,
                messageSchema = messageSchema
            }
        end
    end

    if not metadata then
        tinsert(result.issues, "Schema not found for identifier: " .. identifier)
        return result
    end

    result.found = true
    result.metadata = metadata

    -- Get schema structure
    if metadata.messageSchema then
        result.structure = {
            name = metadata.messageSchema.name,
            fields = metadata.messageSchema.fields,
            field_order = metadata.messageSchema.field_order
        }
    end

    -- Inspect specific field if requested
    if fieldName and result.structure and result.structure.fields then
        result.fieldInfo = result.structure.fields[fieldName]
        if not result.fieldInfo then
            tinsert(result.issues, "Field not found: " .. fieldName)
        end
    end

    return result
end

-- ============================ CONVERSION PATH ANALYSIS ============================

--- Analyze full conversion path
--- @param rotationString string|nil Rotation string (nil = current)
--- @return table result Conversion path analysis
function ASTFormatDiagnostics.AnalyzeConversionPath(rotationString)
    local result = {
        rotationString = rotationString,
        steps = {},
        issues = {},
        warnings = {}
    }

    -- Get rotation string if not provided
    if not rotationString then
        local stored = ASTFormatDiagnostics.AnalyzeStoredRotation()
        if stored.rotationString then
            rotationString = stored.rotationString
            result.rotationString = rotationString
        else
            tinsert(result.issues, "No rotation string available")
            return result
        end
    end

    -- Step 1: rotationString → Parser
    tinsert(result.steps, {
        step = 1,
        name = "rotationString → Parser",
        status = "pending"
    })

    local traceResult = ASTFormatDiagnostics.TraceRotationStringConversion(rotationString)
    if traceResult.errors and #traceResult.errors > 0 then
        result.steps[1].status = "error"
        result.steps[1].error = traceResult.errors[1]
        for _, err in ipairs(traceResult.errors) do
            tinsert(result.issues, "Parse error: " .. err)
        end
        return result
    end

    result.steps[1].status = "success"
    result.steps[1].format = "proto AST"
    result.steps[1].formatIssues = traceResult.warnings

    -- Step 2: Parser → Storage (check what would be stored)
    tinsert(result.steps, {
        step = 2,
        name = "Parser → Storage",
        status = "pending"
    })

    if traceResult.finalAST then
        local storedFormat, storedDetails = DetectFormatType(traceResult.finalAST, "root")
        result.steps[2].status = "success"
        result.steps[2].format = storedFormat

        if storedFormat ~= "PROTO_AST" then
            tinsert(result.issues, "AST format issue before storage: " .. storedFormat)
        end
    else
        result.steps[2].status = "error"
        tinsert(result.issues, "No AST from parser")
        return result
    end

    -- Step 3: Storage → Load (check stored format)
    tinsert(result.steps, {
        step = 3,
        name = "Storage → Load",
        status = "pending"
    })

    local stored = ASTFormatDiagnostics.AnalyzeStoredRotation()
    if stored.found then
        result.steps[3].status = "success"
        result.steps[3].storedFormat = stored.aplProtoFormat

        if stored.aplProtoFormat and stored.aplProtoFormat ~= "PROTO_AST" then
            tinsert(result.issues, "Stored format issue: " .. stored.aplProtoFormat)
        end

        if stored.issues and #stored.issues > 0 then
            for _, issue in ipairs(stored.issues) do
                tinsert(result.issues, "Storage issue: " .. issue)
            end
        end
    else
        result.steps[3].status = "warning"
        result.steps[3].warning = "Could not analyze stored rotation"
        tinsert(result.warnings, "Could not analyze stored rotation")
    end

    -- Step 4: Load → Editor (check editor state)
    tinsert(result.steps, {
        step = 4,
        name = "Load → Editor",
        status = "pending"
    })

    local editor = ASTFormatDiagnostics.AnalyzeEditorState()
    result.steps[4].status = editor.editorOpen and "success" or "warning"
    if not editor.editorOpen then
        tinsert(result.warnings, "Editor not open or state not accessible")
    end

    return result
end

-- ============================ COMPREHENSIVE REPORT ============================

--- Generate full rotation report
--- @param rotationName string|nil Rotation name (nil = current)
--- @param specIndex number|nil Spec index (nil = current)
--- @return string reportText Formatted report text
function ASTFormatDiagnostics.GenerateFullRotationReport(rotationName, specIndex)
    local lines = {}

    -- Header
    tinsert(lines, "=== AST Format Diagnostics Report ===")
    local currentTime = time()
    local timeStr = currentTime and ("Timestamp: " .. currentTime) or "Timestamp: N/A"
    tinsert(lines, timeStr)

    -- Get rotation info
    local stored = ASTFormatDiagnostics.AnalyzeStoredRotation(rotationName, specIndex)
    if stored.found then
        tinsert(lines, "Rotation: " .. (stored.rotationName or "Unknown") .. " (SpecIndex: " .. (stored.specIndex or "Unknown") .. ")")
    else
        tinsert(lines, "Rotation: Not found")
        if stored.issues and #stored.issues > 0 then
            for _, issue in ipairs(stored.issues) do
                tinsert(lines, "  ERROR: " .. issue)
            end
        end
        return tconcat(lines, "\n")
    end

    tinsert(lines, "")

    -- Format Detection
    tinsert(lines, "--- Format Detection ---")

    if stored.rotationString then
        local traceResult = ASTFormatDiagnostics.TraceRotationStringConversion(stored.rotationString)

        if traceResult.finalAST then
            local rootFormat, rootDetails = DetectFormatType(traceResult.finalAST, "root")
            local statusText = rootFormat == "PROTO_AST" and "[OK]" or "[FAIL]"
            tinsert(lines, "root: " .. rootFormat .. " " .. statusText)

            if rootFormat ~= "PROTO_AST" then
                tinsert(lines, "  - Issue: " .. (rootDetails.reason or "Unknown"))
            end

            -- Check for format issues in tree
            if traceResult.steps[3] and traceResult.steps[3].formatIssues then
                for _, issue in ipairs(traceResult.steps[3].formatIssues) do
                    tinsert(lines, issue.path .. ": " .. issue.format .. " [FAIL]")
                    tinsert(lines, "  - Path: " .. issue.path)
                end
            end
        else
            tinsert(lines, "root: PARSE_FAILED [FAIL]")
            if traceResult.errors then
                for _, err in ipairs(traceResult.errors) do
                    tinsert(lines, "  - Error: " .. err)
                end
            end
        end
    else
        tinsert(lines, "No rotationString to analyze")
    end

    tinsert(lines, "")

    -- Stored Format Analysis
    tinsert(lines, "--- Stored Format Analysis ---")
    tinsert(lines, "rotationString: " .. (stored.rotationStringFormat or "NOT_FOUND"))
    local aplProtoStatus = stored.aplProtoFormat or "NOT_FOUND"
    tinsert(lines, "aplProto: " .. aplProtoStatus)
    if aplProtoStatus == "NOT_FOUND" then
        tinsert(lines, "  ERROR: aplProto is required (should have been generated during migration)")
    end

    if stored.issues and #stored.issues > 0 then
        for _, issue in ipairs(stored.issues) do
            tinsert(lines, "  ISSUE: " .. issue)
        end
    end

    tinsert(lines, "")

    -- Conversion Path
    tinsert(lines, "--- Conversion Path ---")
    local pathResult = ASTFormatDiagnostics.AnalyzeConversionPath(stored.rotationString)
    for _, step in ipairs(pathResult.steps) do
        local statusIcon = step.status == "success" and "[OK]" or (step.status == "error" and "[FAIL]" or "[?]")
        tinsert(lines, "Step " .. step.step .. ": " .. step.name .. " " .. statusIcon)
        if step.format then
            tinsert(lines, "  Format: " .. step.format)
        end
        if step.error then
            tinsert(lines, "  Error: " .. step.error)
        end
        if step.formatIssues and #step.formatIssues > 0 then
            for _, issue in ipairs(step.formatIssues) do
                tinsert(lines, "  Warning: " .. issue)
            end
        end
    end

    tinsert(lines, "")

    -- Schema Comparison
    tinsert(lines, "--- Schema Comparison ---")
    if stored.rotationString then
        local traceResult = ASTFormatDiagnostics.TraceRotationStringConversion(stored.rotationString)
        if traceResult.finalAST and traceResult.finalAST.priority_list then
            for i, item in ipairs(traceResult.finalAST.priority_list) do
                if item.action then
                    local actionType = ASTAction.GetActionType(item.action)
                    if actionType then
                        -- Pass snake_case identifier directly (e.g., "cast_spell")
                        local schema = ASTFormatDiagnostics.InspectSchemaStructure(actionType, nil)
                        tinsert(lines, "Action [" .. i .. "]: " .. actionType)
                        if schema.found then
                            tinsert(lines, "  Schema: Found [OK]")
                            if schema.metadata and schema.metadata.protoName then
                                tinsert(lines, "  Proto Name: " .. schema.metadata.protoName)
                            end
                        else
                            tinsert(lines, "  Schema: Not found [FAIL]")
                            if schema.issues and #schema.issues > 0 then
                                for _, issue in ipairs(schema.issues) do
                                    tinsert(lines, "    Issue: " .. issue)
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    tinsert(lines, "")

    -- Issues Found
    tinsert(lines, "--- Issues Found ---")
    local allIssues = {}
    if pathResult.issues then
        for _, issue in ipairs(pathResult.issues) do
            tinsert(allIssues, issue)
        end
    end
    if stored.issues then
        for _, issue in ipairs(stored.issues) do
            tinsert(allIssues, issue)
        end
    end

    -- aplProto is required (generated during precompilation/migration)
    if stored.found and not stored.aplProto and stored.rotationString then
        tinsert(allIssues, "Rotation missing aplProto (should have been generated during migration)")
    end

    -- Check for schema lookup failures in Schema Comparison section
    if stored.rotationString then
        local traceResult = ASTFormatDiagnostics.TraceRotationStringConversion(stored.rotationString)
        if traceResult.finalAST and traceResult.finalAST.priority_list then
            local schemaFailures = 0
            for i, item in ipairs(traceResult.finalAST.priority_list) do
                if item.action then
                    local actionType = ASTAction.GetActionType(item.action)
                    if actionType then
                        local schema = ASTFormatDiagnostics.InspectSchemaStructure(actionType, nil)
                        if not schema.found then
                            schemaFailures = schemaFailures + 1
                        end
                    end
                end
            end
            if schemaFailures > 0 then
                tinsert(allIssues, "Schema lookup failures: " .. schemaFailures .. " action(s) could not be resolved to schema metadata")
            end
        end
    end

    if #allIssues == 0 then
        tinsert(lines, "No issues detected")
    else
        for i, issue in ipairs(allIssues) do
            tinsert(lines, i .. ". " .. issue)
        end
    end

    tinsert(lines, "")

    -- Recommendations
    tinsert(lines, "--- Recommendations ---")
    if #allIssues > 0 then
        for _, issue in ipairs(allIssues) do
            if issue:find("Legacy") or issue:find("LEGACY") then
                tinsert(lines, "- Legacy format detected - rotation should be converted to proto AST format")
                break
            end
        end
    else
        tinsert(lines, "No recommendations - format appears correct")
    end

    return tconcat(lines, "\n")
end

-- ============================ UI FRAME ============================

local uiFrame = nil

--- Show diagnostics UI
function ASTFormatDiagnostics.ShowUI()
    if uiFrame and uiFrame:IsShown() then
        uiFrame:Hide()
        return
    end

    -- Create frame
    uiFrame = CreateFrame("Frame", "ASTFormatDiagnosticsFrame", UIParent, "BackdropTemplate")
    uiFrame:SetSize(800, 600)
    uiFrame:SetPoint("CENTER")
    uiFrame:SetMovable(true)
    uiFrame:EnableMouse(true)
    uiFrame:RegisterForDrag("LeftButton")
    uiFrame:SetScript("OnDragStart", uiFrame.StartMoving)
    uiFrame:SetScript("OnDragStop", uiFrame.StopMovingOrSizing)

    -- Backdrop
    local backdrop = {
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 }
    }
    uiFrame:SetBackdrop(backdrop)
    uiFrame:SetBackdropColor(0, 0, 0, 0.95)

    -- Title
    local title = uiFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", 0, -15)
    title:SetText("AST Format Diagnostics")

    -- Close button
    local closeBtn = CreateFrame("Button", nil, uiFrame, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", -5, -5)
    closeBtn:SetScript("OnClick", function() uiFrame:Hide() end)

    -- Button container
    local buttonContainer = CreateFrame("Frame", nil, uiFrame)
    buttonContainer:SetPoint("TOPLEFT", 10, -40)
    buttonContainer:SetPoint("BOTTOMRIGHT", uiFrame, "BOTTOMLEFT", 210, 10)

    -- Output editbox
    local scrollFrame = CreateFrame("ScrollFrame", nil, uiFrame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", buttonContainer, "TOPRIGHT", 10, 0)
    scrollFrame:SetPoint("BOTTOMRIGHT", -30, 10)

    local editbox = CreateFrame("EditBox", nil, scrollFrame)
    editbox:SetMultiLine(true)
    editbox:SetFontObject(ChatFontNormal)
    editbox:SetWidth(580)
    editbox:SetHeight(550)
    editbox:SetScript("OnEscapePressed", function(self) uiFrame:Hide() end)
    scrollFrame:SetScrollChild(editbox)

    -- Buttons
    local buttons = {
        {
            text = "Analyze Current Rotation",
            func = function()
                local report = ASTFormatDiagnostics.GenerateFullRotationReport()
                editbox:SetText(report)
                editbox:HighlightText(0, -1)
            end
        },
        {
            text = "Trace String Conversion",
            func = function()
                local stored = ASTFormatDiagnostics.AnalyzeStoredRotation()
                if stored.rotationString then
                    local traceResult = ASTFormatDiagnostics.TraceRotationStringConversion(stored.rotationString)
                    local lines = {}
                    tinsert(lines, "=== Conversion Trace ===")
                    tinsert(lines, "Rotation String Length: " .. #stored.rotationString)
                    tinsert(lines, "")
                    for _, step in ipairs(traceResult.steps) do
                        tinsert(lines, "Step " .. step.step .. ": " .. step.name)
                        tinsert(lines, "  Status: " .. step.status)
                        if step.format then
                            tinsert(lines, "  Format: " .. step.format)
                        end
                        if step.error then
                            tinsert(lines, "  Error: " .. step.error)
                        end
                        if step.formatIssues then
                            for _, issue in ipairs(step.formatIssues) do
                                tinsert(lines, "  Issue: " .. issue)
                            end
                        end
                        tinsert(lines, "")
                    end
                    if traceResult.errors and #traceResult.errors > 0 then
                        tinsert(lines, "Errors:")
                        for _, err in ipairs(traceResult.errors) do
                            tinsert(lines, "  - " .. err)
                        end
                    end
                    if traceResult.warnings and #traceResult.warnings > 0 then
                        tinsert(lines, "Warnings:")
                        for _, warn in ipairs(traceResult.warnings) do
                            tinsert(lines, "  - " .. warn)
                        end
                    end
                    editbox:SetText(tconcat(lines, "\n"))
                    editbox:HighlightText(0, -1)
                else
                    editbox:SetText("No rotation string available")
                end
            end
        },
        {
            text = "Inspect Stored Format",
            func = function()
                local stored = ASTFormatDiagnostics.AnalyzeStoredRotation()
                local lines = {}
                tinsert(lines, "=== Stored Rotation Analysis ===")
                tinsert(lines, "Rotation: " .. (stored.rotationName or "Unknown"))
                tinsert(lines, "SpecIndex: " .. (stored.specIndex or "Unknown"))
                tinsert(lines, "Found: " .. (stored.found and "Yes" or "No"))
                tinsert(lines, "")
                tinsert(lines, "rotationString: " .. (stored.rotationStringFormat or "NOT_FOUND"))
                tinsert(lines, "aplProto: " .. (stored.aplProtoFormat or "NOT_FOUND"))
                tinsert(lines, "")
                if stored.issues and #stored.issues > 0 then
                    tinsert(lines, "Issues:")
                    for _, issue in ipairs(stored.issues) do
                        tinsert(lines, "  - " .. issue)
                    end
                end
                if stored.warnings and #stored.warnings > 0 then
                    tinsert(lines, "Warnings:")
                    for _, warn in ipairs(stored.warnings) do
                        tinsert(lines, "  - " .. warn)
                    end
                end
                editbox:SetText(tconcat(lines, "\n"))
                editbox:HighlightText(0, -1)
            end
        },
        {
            text = "Analyze Editor State",
            func = function()
                local editor = ASTFormatDiagnostics.AnalyzeEditorState()
                local lines = {}
                tinsert(lines, "=== Editor State Analysis ===")
                tinsert(lines, "Editor Open: " .. (editor.editorOpen and "Yes" or "No"))
                tinsert(lines, "")

                if editor.editorOpen then
                    tinsert(lines, "--- Editor Details ---")
                    if editor.rotationName then
                        tinsert(lines, "Rotation Name: " .. editor.rotationName)
                    end
                    if editor.specIndex then
                        tinsert(lines, "SpecIndex: " .. editor.specIndex)
                    end
                    if editor.currentTab then
                        tinsert(lines, "Current Tab: " .. editor.currentTab)
                    end
                    if editor.rotationStringMode then
                        tinsert(lines, "Mode: " .. editor.rotationStringMode)
                    end
                    tinsert(lines, "Has Unsaved Changes: " .. (editor.isDirty and "Yes" or "No"))
                    tinsert(lines, "")
                    tinsert(lines, "--- Rotation Data ---")
                    tinsert(lines, "rotationString: " .. (editor.rotationString and "Present (" .. #editor.rotationString .. " chars)" or "NOT_FOUND"))
                    tinsert(lines, "aplProto: " .. (editor.aplProto and "Present" or "NOT_FOUND"))
                    tinsert(lines, "internalAST: " .. (editor.internalAST and "Present" or "NOT_FOUND"))
                    tinsert(lines, "")
                end

                if editor.issues and #editor.issues > 0 then
                    tinsert(lines, "Issues:")
                    for _, issue in ipairs(editor.issues) do
                        tinsert(lines, "  - " .. issue)
                    end
                    tinsert(lines, "")
                end
                if editor.warnings and #editor.warnings > 0 then
                    tinsert(lines, "Warnings:")
                    for _, warn in ipairs(editor.warnings) do
                        tinsert(lines, "  - " .. warn)
                    end
                end
                editbox:SetText(tconcat(lines, "\n"))
                editbox:HighlightText(0, -1)
            end
        },
        {
            text = "Deep Node Inspection",
            func = function()
                local stored = ASTFormatDiagnostics.AnalyzeStoredRotation()
                if stored.rotationString then
                    local traceResult = ASTFormatDiagnostics.TraceRotationStringConversion(stored.rotationString)
                    if traceResult.finalAST then
                        local inspection = ASTFormatDiagnostics.DeepInspectNode(traceResult.finalAST, "root")
                        local lines = {}
                        tinsert(lines, "=== Deep Node Inspection ===")
                        tinsert(lines, "Path: " .. inspection.path)
                        tinsert(lines, "Type: " .. inspection.type)
                        tinsert(lines, "Format: " .. (inspection.format or "UNKNOWN"))
                        tinsert(lines, "")
                        if inspection.issues and #inspection.issues > 0 then
                            tinsert(lines, "Issues:")
                            for _, issue in ipairs(inspection.issues) do
                                tinsert(lines, "  - " .. issue)
                            end
                            tinsert(lines, "")
                        end
                        if inspection.fields then
                            tinsert(lines, "Fields:")
                            for key, field in pairs(inspection.fields) do
                                tinsert(lines, "  " .. key .. ": " .. field.type .. (field.format and (" (" .. field.format .. ")") or ""))
                            end
                        end
                        editbox:SetText(tconcat(lines, "\n"))
                        editbox:HighlightText(0, -1)
                    else
                        editbox:SetText("Failed to parse rotation string")
                    end
                else
                    editbox:SetText("No rotation string available")
                end
            end
        },
        {
            text = "Schema Structure",
            func = function()
                local lines = {}
                tinsert(lines, "=== Schema Structure ===")
                local schema = ASTFormatDiagnostics.InspectSchemaStructure()
                if schema.availableMessages then
                    tinsert(lines, "Available Message Types:")
                    for _, msgType in ipairs(schema.availableMessages) do
                        tinsert(lines, "  - " .. msgType)
                    end
                else
                    tinsert(lines, "APLAction structure:")
                    local actionSchema = ASTFormatDiagnostics.InspectSchemaStructure("APLAction")
                    if actionSchema.found then
                        tinsert(lines, "  Found: Yes")
                        if actionSchema.structure then
                            tinsert(lines, "  Name: " .. (actionSchema.structure.name or "Unknown"))
                        end
                    else
                        tinsert(lines, "  Found: No")
                    end
                end
                editbox:SetText(tconcat(lines, "\n"))
                editbox:HighlightText(0, -1)
            end
        },
        {
            text = "Conversion Path",
            func = function()
                local pathResult = ASTFormatDiagnostics.AnalyzeConversionPath()
                local lines = {}
                tinsert(lines, "=== Conversion Path Analysis ===")
                for _, step in ipairs(pathResult.steps) do
                    local statusIcon = step.status == "success" and "[OK]" or (step.status == "error" and "[FAIL]" or "[?]")
                    tinsert(lines, "Step " .. step.step .. ": " .. step.name .. " " .. statusIcon)
                    if step.format then
                        tinsert(lines, "  Format: " .. step.format)
                    end
                    if step.error then
                        tinsert(lines, "  Error: " .. step.error)
                    end
                    if step.warning then
                        tinsert(lines, "  Warning: " .. step.warning)
                    end
                    tinsert(lines, "")
                end
                if pathResult.issues and #pathResult.issues > 0 then
                    tinsert(lines, "Issues:")
                    for _, issue in ipairs(pathResult.issues) do
                        tinsert(lines, "  - " .. issue)
                    end
                end
                editbox:SetText(tconcat(lines, "\n"))
                editbox:HighlightText(0, -1)
            end
        },
        {
            text = "Format Detection",
            func = function()
                local stored = ASTFormatDiagnostics.AnalyzeStoredRotation()
                if stored.aplProto then
                    local analysis = ASTFormatDiagnostics.AnalyzeFormatAtPath(stored.aplProto, "root")
                    local lines = {}
                    tinsert(lines, "=== Format Detection ===")
                    tinsert(lines, "Path: " .. analysis.path)
                    tinsert(lines, "Format: " .. analysis.format)
                    if analysis.details then
                        tinsert(lines, "Details:")
                        for key, value in pairs(analysis.details) do
                            tinsert(lines, "  " .. key .. ": " .. tostring(value))
                        end
                    end
                    if analysis.error then
                        tinsert(lines, "Error: " .. analysis.error)
                    end
                    editbox:SetText(tconcat(lines, "\n"))
                    editbox:HighlightText(0, -1)
                else
                    editbox:SetText("No aplProto available for format detection")
                end
            end
        }
    }

    local buttonHeight = 25
    local buttonSpacing = 5
    local yOffset = -10

    for i, buttonData in ipairs(buttons) do
        local button = CreateFrame("Button", nil, buttonContainer, "UIPanelButtonTemplate")
        button:SetSize(180, buttonHeight)
        button:SetPoint("TOPLEFT", 0, yOffset)
        button:SetText(buttonData.text)
        button:SetScript("OnClick", buttonData.func)
        yOffset = yOffset - (buttonHeight + buttonSpacing)
    end

    uiFrame:Show()
end

return ASTFormatDiagnostics

