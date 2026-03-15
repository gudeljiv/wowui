--- @module 'NAG.ProtoASTDiagnostics'
--- Comprehensive proto AST diagnostics for NAG addon
--- Works exclusively with proto AST format (no legacy conversion)
--- Validates AST structure, argument mapping, and parser correctness
--- License: CC BY-NC 4.0
--- Authors: Rakizi

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ HEADER LOCALS ============================
local TableUtils = ns.TableUtils

-- Proto AST system
local ASTCore = ns.ASTCore
local ASTSchema = ns.ASTSchema
local ASTSchemaEmitter = ns.ASTSchemaEmitter
local ASTAction = ns.ASTAction
local ASTValue = ns.ASTValue
local ASTRotation = ns.ASTRotation

-- Services
local SchemaValidator = NAG:GetModule("SchemaValidator", true)
local RotationConversionService = ns.RotationConversionService

-- Module declarations (assigned in ModuleInitialize)
--- @type SpecCompat
local SpecCompat

-- Libraries
local L = ns.AceLocale:GetLocale("NAG", true)

-- Lua APIs
local format = string.format
local gsub = string.gsub
local pairs = pairs
local ipairs = ipairs
local type = type
local tostring = tostring
local tinsert = table.insert
local tconcat = table.concat
local debugprofilestop = debugprofilestop

--- Strip WoW color codes for plain-text copy (|cAARRGGBB, |r)
--- @param text string
--- @return string
local function StripWoWColorCodes(text)
    if not text or text == "" then
        return ""
    end
    local s = gsub(text, "|c%x%x%x%x%x%x%x%x", "")
    return gsub(s, "|r", "")
end

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

--- @class ProtoASTDiagnostics : CoreModule
local defaults = {
    global = {
        verboseOutput = true,
        showStackTraces = false
    },
    char = {}
}

local ProtoASTDiagnostics = NAG:CreateModule("ProtoASTDiagnostics", defaults, {
    moduleType = ns.MODULE_TYPES.SERVICE,
    debugCategories = { ns.DEBUG_CATEGORIES.DIAGNOSTICS },

    slashCommands = {
        ["ast_validate"] = {
            handler = "ValidateRotationString",
            help = "Validate AST structure. Usage: /nagdebug ast validate <string|current>",
            root = "nagdebug",
            path = { "ast", "validate" },
            category = "Debug"
        },
        ["ast_inspect"] = {
            handler = "InspectAST",
            help = "Deep inspection of AST nodes. Usage: /nagdebug ast inspect <string|current>",
            root = "nagdebug",
            path = { "ast", "inspect" },
            category = "Debug"
        },
        ["ast_arguments"] = {
            handler = "AnalyzeArguments",
            help = "Analyze argument mapping. Usage: /nagdebug ast arguments <string|current>",
            root = "nagdebug",
            path = { "ast", "arguments" },
            category = "Debug"
        },
        ["ast_compare"] = {
            handler = "CompareWithSchema",
            help = "Compare with expected schema. Usage: /nagdebug ast compare <string|current>",
            root = "nagdebug",
            path = { "ast", "compare" },
            category = "Debug"
        },
        ["ast_health"] = {
            handler = "ParserHealthCheck",
            help = "Overall parser health check. Usage: /nagdebug ast health",
            root = "nagdebug",
            path = { "ast", "health" },
            category = "Debug"
        },
        ["ast_proto"] = {
            handler = "ValidateProtoAST",
            help = "Validate proto AST compatibility. Usage: /nagdebug ast proto <string|current>",
            root = "nagdebug",
            path = { "ast", "proto" },
            category = "Debug"
        },
        ["ast_export"] = {
            handler = "TestWoWSimsExport",
            help = "Test WoWSims export. Usage: /nagdebug ast export <string|current>",
            root = "nagdebug",
            path = { "ast", "export" },
            category = "Debug"
        },
        ["ast_ui"] = {
            handler = "ShowDebugFrame",
            help = "Open visual debug UI. Usage: /nagdebug ast ui",
            root = "nagdebug",
            path = { "ast", "ui" },
            category = "Debug"
        }
    }
})

if not ProtoASTDiagnostics then return end

-- ============================ MODULE INITIALIZATION ============================

function ProtoASTDiagnostics:ModuleInitialize()
    -- Module assignment
    SpecCompat = NAG:GetModule("SpecCompat")

    self.diagnosticStats = {
        totalValidations = 0,
        totalIssues = 0,
        issuesByType = {}
    }

    -- Performance tracking
    self.performanceMetrics = {
        parseTimings = {},
        cacheHitTimes = {},
        cacheMissTimes = {},
        validationTimes = {},
        exportTimes = {}
    }

    -- Debug frame state
    self.debugFrame = nil
    self.currentAST = nil
    self.currentRotationString = nil
    self.currentRotationName = nil
    self.currentSpecIndex = nil

    -- Ensure services are available
    self.conversionService = RotationConversionService or NAG:GetModule("RotationConversionService", true)
end

function ProtoASTDiagnostics:ModuleEnable()
    self:Info("ProtoASTDiagnostics module enabled - Proto AST debugging tools")
    self:Info("Visual UI: /nagdebug ast ui")
    self:Info("Commands: validate|inspect|arguments|compare|health|proto|export")
    self:Info("Use /nagdebug ast ui for the full diagnostic interface")
end

-- ============================ HELPER FUNCTIONS ============================

--- Get current rotation from RotationManager (uses ClassBase:GetCurrentRotation)
--- @return string|nil rotationString The current rotation string
--- @return table|nil aplProto The current rotation AST
--- @return string|nil rotationName The rotation name
--- @return number|nil specIndex The spec index
--- @return string|nil error Error message if failed
function ProtoASTDiagnostics:GetCurrentRotation()
    local classModule = NAG:GetClassModule()
    if not classModule then
        return nil, nil, nil, nil, "Class module not available"
    end

    local specIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
    if not specIndex then
        return nil, nil, nil, nil, "No specialization available"
    end

    -- Use ClassBase's GetCurrentRotation instead of duplicating logic
    local rotation, rotationName = classModule:GetCurrentRotation(specIndex)
    if not rotation then
        return nil, nil, nil, nil, "No rotation selected or found"
    end

    -- Ensure aplProto exists (RotationManager:GetRotationWithProto handles this)
    local RotationManager = NAG:GetModule("RotationManager")
    local rotationWithProto, err = RotationManager:GetRotationWithProto(specIndex, rotationName)
    if not rotationWithProto then
        return nil, nil, nil, nil, err or "Failed to get rotation with proto"
    end

    -- Return both rotationString and aplProto from the rotation config
    return rotationWithProto.rotationString, rotationWithProto.aplProto, rotationName, specIndex, nil
end

--- Parse rotation string to proto AST
--- @param rotationString string|nil Rotation string or "current" keyword
--- @param options table|nil Parse options
--- @return table|nil protoAST The parsed proto AST
--- @return table|nil diagnostics Parse diagnostics
--- @return string|nil error Error message if failed
function ProtoASTDiagnostics:ParseRotationString(rotationString, options)
    -- Handle "current" keyword
    if rotationString == "current" or rotationString == nil then
        local rotStr, _, rotName, specIndex, err = self:GetCurrentRotation()
        if not rotStr then
            return nil, nil, err or "Failed to get current rotation"
        end
        rotationString = rotStr
        self.currentRotationName = rotName
        self.currentSpecIndex = specIndex
    end

    if not rotationString or rotationString == "" then
        return nil, nil, "No rotation string provided"
    end

    self.currentRotationString = rotationString

    -- Parse using RotationConversionService
    if not self.conversionService then
        return nil, nil, "RotationConversionService not available"
    end

    local startTime = debugprofilestop()
    local protoAST, diagnostics = self.conversionService:ParseToProtoAST(rotationString, options or {})
    local parseTime = debugprofilestop() - startTime

    -- Track performance (keep last 100)
    tinsert(self.performanceMetrics.parseTimings, parseTime)
    if #self.performanceMetrics.parseTimings > 100 then
        table.remove(self.performanceMetrics.parseTimings, 1)
    end

    if not protoAST then
        return nil, diagnostics, diagnostics and diagnostics.errors and diagnostics.errors[1] or "Parse failed"
    end

    -- Validate proto AST format (no legacy)
    local legacyDetected, legacyError = self:DetectLegacyFormat(protoAST)
    if legacyDetected then
        self:Error("Legacy format detected in parsed AST: " .. (legacyError or "unknown"))
        return nil, diagnostics, legacyError or "Legacy format detected - proto AST required"
    end

    self.currentAST = protoAST
    return protoAST, diagnostics, nil
end

--- Detect legacy format in AST node
--- @param node table AST node to check
--- @param path string|nil Current path for error reporting
--- @return boolean isLegacy True if legacy format detected
--- @return string|nil error Error message if legacy detected
function ProtoASTDiagnostics:DetectLegacyFormat(node, path)
    if not node or type(node) ~= "table" then
        return false, nil
    end

    path = path or "root"

    local nodeType = node.type

    -- Check for legacy node types (these are never valid in proto AST)
    if nodeType == "function" or nodeType == "logical" or nodeType == "comparison" or nodeType == "math" then
        return true, format("Legacy node type detected at %s: %s", path, nodeType)
    end

    -- Check for legacy action format
    -- In proto AST: node.type == "action" (ASTCore.NodeType.ACTION == "action") is CORRECT
    -- Legacy format is when type is "action" but missing proto structure OR has legacy fields
    if nodeType == "action" or nodeType == ASTCore.NodeType.ACTION then
        -- Proto AST action nodes must have node.action proto structure
        if not node.action or type(node.action) ~= "table" then
            return true, format("Legacy action format detected at %s: missing node.action proto structure", path)
        end
        -- Legacy nodes use arguments field instead of proto structure
        if node.arguments then
            return true, format("Legacy action format detected at %s: has 'arguments' field (proto AST doesn't use this)", path)
        end
        -- Legacy nodes use functionName instead of proto structure
        if node.functionName then
            return true, format("Legacy action format detected at %s: has 'functionName' field (proto AST doesn't use this)", path)
        end
    end

    -- Check for legacy value format
    -- In proto AST: node.type == "value" (ASTCore.NodeType.VALUE == "value") is CORRECT
    -- Legacy format is when type is "value" but missing proto structure OR has legacy fields
    if nodeType == "value" or nodeType == ASTCore.NodeType.VALUE then
        -- Proto AST value nodes must have node.value proto structure
        if not node.value or type(node.value) ~= "table" then
            return true, format("Legacy value format detected at %s: missing node.value proto structure", path)
        end
        -- Legacy nodes use functionName/arguments instead of proto structure
        if node.functionName then
            return true, format("Legacy value format detected at %s: has 'functionName' field (proto AST doesn't use this)", path)
        end
        if node.arguments then
            return true, format("Legacy value format detected at %s: has 'arguments' field (proto AST doesn't use this)", path)
        end
    end

    -- Recursively check children
    if nodeType == ASTCore.NodeType.ROTATION then
        if node.priority_list then
            for i, listItem in ipairs(node.priority_list) do
                if listItem.action then
                    local isLegacy, err = self:DetectLegacyFormat(listItem.action, format("%s.priority_list[%d].action", path, i))
                    if isLegacy then
                        return true, err
                    end
                end
            end
        end
        if node.prepull_actions then
            for i, prepull in ipairs(node.prepull_actions) do
                if prepull.action then
                    local isLegacy, err = self:DetectLegacyFormat(prepull.action, format("%s.prepull_actions[%d].action", path, i))
                    if isLegacy then
                        return true, err
                    end
                end
            end
        end
    elseif nodeType == ASTCore.NodeType.ACTION then
        if node.condition then
            local isLegacy, err = self:DetectLegacyFormat(node.condition, format("%s.condition", path))
            if isLegacy then
                return true, err
            end
        end
    elseif nodeType == ASTCore.NodeType.VALUE then
        local valueType = ASTValue.GetValueType(node)
        local valueData = ASTValue.GetValueData(node) or {}

        -- Check logical operators
        if valueType == ASTValue.ValueType.AND or valueType == ASTValue.ValueType.OR then
            if valueData.vals then
                for i, val in ipairs(valueData.vals) do
                    local isLegacy, err = self:DetectLegacyFormat(val, format("%s.vals[%d]", path, i))
                    if isLegacy then
                        return true, err
                    end
                end
            end
        elseif valueType == ASTValue.ValueType.NOT then
            if valueData.val then
                local isLegacy, err = self:DetectLegacyFormat(valueData.val, format("%s.val", path))
                if isLegacy then
                    return true, err
                end
            end
        elseif valueType == ASTValue.ValueType.CMP then
            if valueData.lhs then
                local isLegacy, err = self:DetectLegacyFormat(valueData.lhs, format("%s.lhs", path))
                if isLegacy then
                    return true, err
                end
            end
            if valueData.rhs then
                local isLegacy, err = self:DetectLegacyFormat(valueData.rhs, format("%s.rhs", path))
                if isLegacy then
                    return true, err
                end
            end
        elseif valueType == ASTValue.ValueType.MATH then
            if valueData.lhs then
                local isLegacy, err = self:DetectLegacyFormat(valueData.lhs, format("%s.lhs", path))
                if isLegacy then
                    return true, err
                end
            end
            if valueData.rhs then
                local isLegacy, err = self:DetectLegacyFormat(valueData.rhs, format("%s.rhs", path))
                if isLegacy then
                    return true, err
                end
            end
        end
    end

    return false, nil
end

-- ============================ PROTO AST FORMATTING ============================

--- Format a proto AST node for display
--- @param node table Proto AST node
--- @param depth number Current depth for indentation
--- @return string formatted text
function ProtoASTDiagnostics:FormatProtoASTNode(node, depth)
    depth = depth or 0
    local indent = string.rep("  ", depth)

    if not node or type(node) ~= "table" then
        return indent .. "|cFFFF0000[INVALID NODE]|r"
    end

    local nodeType = node.type

    if nodeType == ASTCore.NodeType.ROTATION then
        return self:FormatRotationNode(node, depth)
    elseif nodeType == ASTCore.NodeType.ACTION then
        return self:FormatActionNode(node, depth)
    elseif nodeType == ASTCore.NodeType.VALUE then
        return self:FormatValueNode(node, depth)
    else
        return indent .. format("|cFFFF0000[UNKNOWN NODE TYPE: %s]|r", tostring(nodeType))
    end
end

--- Format a rotation node
--- @param node table Rotation node
--- @param depth number Current depth
--- @return string formatted text
function ProtoASTDiagnostics:FormatRotationNode(node, depth)
    depth = depth or 0
    local indent = string.rep("  ", depth)
    local lines = {}

    tinsert(lines, indent .. "|cFF00FFFF[ROTATION]|r")

    -- Emit rotation using ASTSchemaEmitter
    local rotationText = ASTSchemaEmitter.EmitRotationString(node)
    if rotationText then
        for line in rotationText:gmatch("[^\n]+") do
            tinsert(lines, indent .. "  " .. line)
        end
    end

    -- Show priority list structure
    if node.priority_list and #node.priority_list > 0 then
        tinsert(lines, indent .. "  |cFFFFFF00Priority List:|r " .. #node.priority_list .. " items")
        for i, listItem in ipairs(node.priority_list) do
            if listItem.action then
                local actionText = self:FormatActionNode(listItem.action, depth + 2)
                tinsert(lines, indent .. "    [" .. i .. "] " .. actionText:match("^%s*(.+)") or "")
            end
        end
    end

    return tconcat(lines, "\n")
end

--- Format an action node
--- @param node table Action node
--- @param depth number Current depth
--- @return string formatted text
function ProtoASTDiagnostics:FormatActionNode(node, depth)
    depth = depth or 0
    local indent = string.rep("  ", depth)

    if not node or node.type ~= ASTCore.NodeType.ACTION then
        return indent .. "|cFFFF0000[INVALID ACTION]|r"
    end

    local actionType = ASTAction.GetActionType(node)
    local actionData = ASTAction.GetActionData(node)

    -- Use ASTSchemaEmitter for display
    local actionText = ASTSchemaEmitter.EmitActionNode(node)
    local displayText = indent .. "|cFF00FF00[ACTION]|r " .. (actionText or "|cFFFF0000[EMIT FAILED]|r")

    -- Show condition if present
    if node.condition then
        local conditionText = ASTSchemaEmitter.EmitValueNode(node.condition)
        if conditionText and conditionText ~= "" then
            displayText = displayText .. "\n" .. indent .. "  |cFFFFAA00Condition:|r " .. conditionText
        end
    end

    return displayText
end

--- Format a value node
--- @param node table Value node
--- @param depth number Current depth
--- @return string formatted text
function ProtoASTDiagnostics:FormatValueNode(node, depth)
    depth = depth or 0
    local indent = string.rep("  ", depth)

    if not node or node.type ~= ASTCore.NodeType.VALUE then
        return indent .. "|cFFFF0000[INVALID VALUE]|r"
    end

    local valueType = ASTValue.GetValueType(node)
    local valueData = ASTValue.GetValueData(node) or {}

    -- Use ASTSchemaEmitter for display
    local valueText = ASTSchemaEmitter.EmitValueNode(node)
    local displayText = indent .. "|cFF00AAFF[VALUE]|r " .. (valueText or "|cFFFF0000[EMIT FAILED]|r")

    -- Show value type info
    if valueType then
        displayText = displayText .. " |cFFAAAAAA(type: " .. tostring(valueType) .. ")|r"
    end

    return displayText
end

-- ============================ UI RENDERING ============================

--- Render a collapsible section
--- @param scroll table AceGUI scroll container
--- @param title string Section title
--- @param contentFn function Function that returns content string
--- @param statusColor string|nil Status color code
function ProtoASTDiagnostics:RenderCollapsibleSection(scroll, title, contentFn, statusColor)
    statusColor = statusColor or "|cFF00FF00"

    -- Section header
    local header = ns.AceGUI:Create("Heading")
    header:SetText(statusColor .. title .. "|r")
    header:SetFullWidth(true)
    scroll:AddChild(header)

    -- Content
    local content = contentFn()
    if content and content ~= "" then
        local lines = {}
        for line in content:gmatch("[^\n]+") do
            tinsert(lines, line)
        end

        for _, line in ipairs(lines) do
            local label = ns.AceGUI:Create("Label")
            label:SetText(line)
            label:SetFullWidth(true)
            label:SetFontObject(GameFontNormalSmall)
            scroll:AddChild(label)
        end
    end

    -- Spacer
    local spacer = ns.AceGUI:Create("Label")
    spacer:SetText(" ")
    spacer:SetFullWidth(true)
    scroll:AddChild(spacer)
end

--- Show debug frame with tabbed interface
function ProtoASTDiagnostics:ShowDebugFrame()
    if self.debugFrame then
        self.debugFrame:Show()
        return
    end

    local frame = ns.AceGUI:Create("Frame")
    frame:SetTitle("Proto AST Diagnostics")
    frame:SetWidth(900)
    frame:SetHeight(700)
    frame:SetLayout("Fill")
    frame:SetCallback("OnClose", function(widget)
        ns.AceGUI:Release(widget)
        self.debugFrame = nil
        self.tabGroup = nil
    end)

    local tabGroup = ns.AceGUI:Create("TabGroup")
    tabGroup:SetLayout("Fill")
    tabGroup:SetTabs({
        { text = "Overview", value = "overview" },
        { text = "Structure", value = "structure" },
        { text = "Validation", value = "validation" },
        { text = "Arguments", value = "arguments" },
        { text = "Performance", value = "performance" },
        { text = "Export", value = "export" }
    })

    tabGroup:SetCallback("OnGroupSelected", function(container, _, group)
        container:ReleaseChildren()

        if group == "overview" then
            self:RenderOverviewTab(container)
        elseif group == "structure" then
            self:RenderStructureTab(container)
        elseif group == "validation" then
            self:RenderValidationTab(container)
        elseif group == "arguments" then
            self:RenderArgumentsTab(container)
        elseif group == "performance" then
            self:RenderPerformanceTab(container)
        elseif group == "export" then
            self:RenderExportTab(container)
        end
    end)

    frame:AddChild(tabGroup)
    tabGroup:SelectTab("overview")

    self.debugFrame = frame
    self.tabGroup = tabGroup
end

-- ============================ TAB RENDERING ============================

--- Render Overview tab
--- @param container table AceGUI container
function ProtoASTDiagnostics:RenderOverviewTab(container)
    local scroll = ns.AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Flow")
    container:AddChild(scroll)

    -- Parse current rotation if available
    local protoAST, diagnostics, err = self:ParseRotationString("current")

    self:RenderCollapsibleSection(scroll, "Parse Status", function()
        if err then
            return "|cFFFF0000Parse Failed:|r " .. (err or "Unknown error")
        elseif protoAST then
            return "|cFF00FF00Parse Successful|r"
        else
            return "|cFFFFAA00No rotation parsed|r"
        end
    end, protoAST and "|cFF00FF00" or "|cFFFF0000")

    self:RenderCollapsibleSection(scroll, "Current Rotation Info", function()
        local lines = {}
        if self.currentRotationName then
            tinsert(lines, "|cFFFFFF00Name:|r " .. self.currentRotationName)
        end
        if self.currentSpecIndex then
            tinsert(lines, "|cFFFFFF00Spec Index:|r " .. tostring(self.currentSpecIndex))
        end
        if self.currentRotationString then
            tinsert(lines, "|cFFFFFF00Rotation String Length:|r " .. #self.currentRotationString .. " characters")
        end
        if #lines == 0 then
            return "|cFFFFAA00No current rotation|r"
        end
        return tconcat(lines, "\n")
    end)

    self:RenderCollapsibleSection(scroll, "Basic Metrics", function()
        if not protoAST then
            return "|cFFFFAA00No AST available|r"
        end

        local lines = {}
        local actionCount = 0
        local valueCount = 0

        -- Count nodes
        if protoAST.priority_list then
            for _, listItem in ipairs(protoAST.priority_list) do
                if listItem.action then
                    actionCount = actionCount + 1
                    if listItem.action.condition then
                        valueCount = valueCount + 1
                    end
                end
            end
        end

        tinsert(lines, "|cFFFFFF00Priority List Items:|r " .. (protoAST.priority_list and #protoAST.priority_list or 0))
        tinsert(lines, "|cFFFFFF00Actions:|r " .. actionCount)
        tinsert(lines, "|cFFFFFF00Values (conditions):|r " .. valueCount)

        return tconcat(lines, "\n")
    end)

    self:RenderCollapsibleSection(scroll, "Health Check", function()
        if not protoAST then
            return "|cFFFFAA00No AST available for health check|r"
        end

        local lines = {}
        local isValid, issues = ASTSchema.Validate(protoAST)
        if isValid then
            tinsert(lines, "|cFF00FF00Schema Validation:|r Passed")
        else
            tinsert(lines, "|cFFFF0000Schema Validation:|r Failed (" .. (#issues or 0) .. " issues)")
        end

        -- Check for legacy format
        local legacyDetected, legacyError = self:DetectLegacyFormat(protoAST)
        if legacyDetected then
            tinsert(lines, "|cFFFF0000Legacy Format:|r Detected - " .. (legacyError or "unknown"))
        else
            tinsert(lines, "|cFF00FF00Legacy Format:|r None detected (proto AST only)")
        end

        return tconcat(lines, "\n")
    end)
end

--- Render Structure tab
--- @param container table AceGUI container
function ProtoASTDiagnostics:RenderStructureTab(container)
    local scroll = ns.AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Flow")
    container:AddChild(scroll)

    local protoAST, diagnostics, err = self:ParseRotationString("current")

    self:RenderCollapsibleSection(scroll, "Proto AST Tree", function()
        if err then
            return "|cFFFF0000Error:|r " .. (err or "Unknown error")
        end

        if not protoAST then
            return "|cFFFFAA00No AST available|r"
        end

        return self:FormatProtoASTNode(protoAST, 0)
    end, protoAST and "|cFF00FF00" or "|cFFFF0000")

    -- Copyable plain-text AST (select all + copy)
    local copyHeading = ns.AceGUI:Create("Heading")
    copyHeading:SetText("|cFF00FF00Proto AST (copyable)|r")
    copyHeading:SetFullWidth(true)
    scroll:AddChild(copyHeading)

    local astPlain = ""
    if err then
        astPlain = "Error: " .. (err or "Unknown error")
    elseif protoAST then
        astPlain = StripWoWColorCodes(self:FormatProtoASTNode(protoAST, 0))
    else
        astPlain = "No AST available"
    end

    local copyBox = ns.AceGUI:Create("MultiLineEditBox")
    copyBox:SetLabel("Select and copy (Ctrl+A, Ctrl+C) — editable")
    copyBox:SetFullWidth(true)
    copyBox:SetNumLines(28)
    copyBox:SetText(astPlain)
    scroll:AddChild(copyBox)
end

--- Render Validation tab
--- @param container table AceGUI container
function ProtoASTDiagnostics:RenderValidationTab(container)
    local scroll = ns.AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Flow")
    container:AddChild(scroll)

    local protoAST, diagnostics, err = self:ParseRotationString("current")

    self:RenderCollapsibleSection(scroll, "Schema Validation Results", function()
        if err then
            return "|cFFFF0000Parse Error:|r " .. (err or "Unknown error")
        end

        if not protoAST then
            return "|cFFFFAA00No AST available|r"
        end

        local isValid, issues = ASTSchema.Validate(protoAST)
        local lines = {}

        if isValid then
            tinsert(lines, "|cFF00FF00Validation Status:|r Passed")
        else
            tinsert(lines, "|cFFFF0000Validation Status:|r Failed")
            tinsert(lines, "|cFFFFFF00Total Issues:|r " .. (#issues or 0))
        end

        return tconcat(lines, "\n")
    end, protoAST and "|cFF00FF00" or "|cFFFF0000")

    if protoAST then
        local isValid, issues = ASTSchema.Validate(protoAST)
        if not isValid and issues then
            self:RenderCollapsibleSection(scroll, "Validation Errors", function()
                local lines = {}
                for i, issue in ipairs(issues) do
                    local issueType = issue.type or "UNKNOWN"
                    local issueMsg = issue.message or "No message"
                    local issuePath = issue.path or "root"
                    tinsert(lines, format("|cFFFF0000[%d]|r %s: %s (at %s)", i, issueType, issueMsg, issuePath))
                end
                return tconcat(lines, "\n")
            end, "|cFFFF0000")
        end
    end

    self:RenderCollapsibleSection(scroll, "Validation Statistics", function()
        local lines = {}
        tinsert(lines, "|cFFFFFF00Total Validations:|r " .. self.diagnosticStats.totalValidations)
        tinsert(lines, "|cFFFFFF00Total Issues:|r " .. self.diagnosticStats.totalIssues)
        return tconcat(lines, "\n")
    end)
end

--- Render Arguments tab
--- @param container table AceGUI container
function ProtoASTDiagnostics:RenderArgumentsTab(container)
    local scroll = ns.AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Flow")
    container:AddChild(scroll)

    local protoAST, diagnostics, err = self:ParseRotationString("current")

    self:RenderCollapsibleSection(scroll, "Argument Mapping Analysis", function()
        if err then
            return "|cFFFF0000Error:|r " .. (err or "Unknown error")
        end

        if not protoAST then
            return "|cFFFFAA00No AST available|r"
        end

        local lines = {}
        local SchemaAccessor = NAG:GetModule("SchemaAccessor")

        if protoAST.priority_list then
            for i, listItem in ipairs(protoAST.priority_list) do
                if listItem.action then
                    local actionType = ASTAction.GetActionType(listItem.action)
                    local actionData = ASTAction.GetActionData(listItem.action) or {}

                    tinsert(lines, format("|cFFFFFF00Action [%d]:|r %s", i, actionType or "unknown"))

                    if SchemaAccessor and actionType then
                        local metadata = SchemaAccessor:GetMetadataByIdentifier(actionType, nil)
                        if metadata and metadata.messageSchema and metadata.messageSchema.fields then
                            for fieldName, fieldInfo in pairs(metadata.messageSchema.fields) do
                                local fieldValue = actionData[fieldName]
                                if fieldValue ~= nil then
                                    tinsert(lines, format("  |cFFAAAAAA%s:|r %s", fieldName, tostring(fieldValue)))
                                end
                            end
                        end
                    end
                end
            end
        end

        if #lines == 0 then
            return "|cFFFFAA00No actions found|r"
        end

        return tconcat(lines, "\n")
    end)
end

--- Render Performance tab
--- @param container table AceGUI container
function ProtoASTDiagnostics:RenderPerformanceTab(container)
    local scroll = ns.AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Flow")
    container:AddChild(scroll)

    self:RenderCollapsibleSection(scroll, "Parse Timings", function()
        local timings = self.performanceMetrics.parseTimings
        if #timings == 0 then
            return "|cFFFFAA00No parse timings available|r"
        end

        local lines = {}
        local total = 0
        local min = math.huge
        local max = 0

        for _, time in ipairs(timings) do
            total = total + time
            if time < min then min = time end
            if time > max then max = time end
        end

        local avg = total / #timings
        tinsert(lines, format("|cFFFFFF00Samples:|r %d", #timings))
        tinsert(lines, format("|cFFFFFF00Average:|r %.3f ms", avg))
        tinsert(lines, format("|cFFFFFF00Min:|r %.3f ms", min))
        tinsert(lines, format("|cFFFFFF00Max:|r %.3f ms", max))

        return tconcat(lines, "\n")
    end)

    self:RenderCollapsibleSection(scroll, "Cache Statistics", function()
        local lines = {}
        local cacheHits = #self.performanceMetrics.cacheHitTimes
        local cacheMisses = #self.performanceMetrics.cacheMissTimes
        local total = cacheHits + cacheMisses

        if total > 0 then
            local hitRate = (cacheHits / total) * 100
            tinsert(lines, format("|cFFFFFF00Cache Hits:|r %d", cacheHits))
            tinsert(lines, format("|cFFFFFF00Cache Misses:|r %d", cacheMisses))
            tinsert(lines, format("|cFFFFFF00Hit Rate:|r %.1f%%", hitRate))
        else
            return "|cFFFFAA00No cache statistics available|r"
        end

        return tconcat(lines, "\n")
    end)
end

--- Render Export tab
--- @param container table AceGUI container
function ProtoASTDiagnostics:RenderExportTab(container)
    local scroll = ns.AceGUI:Create("ScrollFrame")
    scroll:SetLayout("Flow")
    container:AddChild(scroll)

    local protoAST, diagnostics, err = self:ParseRotationString("current")

    self:RenderCollapsibleSection(scroll, "WoWSims Export Test", function()
        if err then
            return "|cFFFF0000Parse Error:|r " .. (err or "Unknown error")
        end

        if not protoAST then
            return "|cFFFFAA00No AST available|r"
        end

        -- Try to export using ASTProto
        local ASTProto = ns.ASTProto
        if ASTProto and ASTProto.ToProto then
            local success, protoData = pcall(ASTProto.ToProto, protoAST)
            if success and protoData then
                return "|cFF00FF00Export Successful|r\nProto data generated successfully"
            else
                return "|cFFFF0000Export Failed|r\n" .. tostring(protoData)
            end
        else
            return "|cFFFFAA00ASTProto not available|r"
        end
    end, protoAST and "|cFF00FF00" or "|cFFFF0000")
end

-- ============================ SLASH COMMAND HANDLERS ============================

--- Validate rotation string
--- @param input string|nil Rotation string or "current"
function ProtoASTDiagnostics:ValidateRotationString(input)
    local rotationString = input or "current"
    self:Print("|cFF00FF00=== Validating Rotation ===|r")

    local protoAST, diagnostics, err = self:ParseRotationString(rotationString)
    if err then
        self:Print("|cFFFF0000Parse Error:|r " .. err)
        return
    end

    if not protoAST then
        self:Print("|cFFFF0000Failed to parse rotation|r")
        return
    end

    -- Run schema validation
    local startTime = debugprofilestop()
    local isValid, issues = ASTSchema.Validate(protoAST)
    local validationTime = debugprofilestop() - startTime

    tinsert(self.performanceMetrics.validationTimes, validationTime)
    self.diagnosticStats.totalValidations = self.diagnosticStats.totalValidations + 1

    if isValid then
        self:Print("|cFF00FF00Validation:|r Passed")
    else
        self:Print("|cFFFF0000Validation:|r Failed (" .. (#issues or 0) .. " issues)")
        self.diagnosticStats.totalIssues = self.diagnosticStats.totalIssues + (#issues or 0)

        if issues then
            for i, issue in ipairs(issues) do
                local issueType = issue.type or "UNKNOWN"
                local issueMsg = issue.message or "No message"
                local issuePath = issue.path or "root"
                self:Print(format("  |cFFFF0000[%d]|r %s: %s (at %s)", i, issueType, issueMsg, issuePath))
            end
        end
    end
end

--- Inspect AST nodes
--- @param input string|nil Rotation string or "current"
function ProtoASTDiagnostics:InspectAST(input)
    local rotationString = input or "current"
    self:Print("|cFF00FF00=== Inspecting AST ===|r")

    local protoAST, diagnostics, err = self:ParseRotationString(rotationString)
    if err then
        self:Print("|cFFFF0000Parse Error:|r " .. err)
        return
    end

    if not protoAST then
        self:Print("|cFFFF0000Failed to parse rotation|r")
        return
    end

    local formatted = self:FormatProtoASTNode(protoAST, 0)
    for line in formatted:gmatch("[^\n]+") do
        self:Print(line)
    end

    self:ShowDebugFrame()
    if self.tabGroup then
        self.tabGroup:SelectTab("structure")
    end
end

--- Analyze argument mapping
--- @param input string|nil Rotation string or "current"
function ProtoASTDiagnostics:AnalyzeArguments(input)
    local rotationString = input or "current"
    self:Print("|cFF00FF00=== Analyzing Arguments ===|r")

    local protoAST, diagnostics, err = self:ParseRotationString(rotationString)
    if err then
        self:Print("|cFFFF0000Parse Error:|r " .. err)
        return
    end

    if not protoAST then
        self:Print("|cFFFF0000Failed to parse rotation|r")
        return
    end

    local SchemaAccessor = NAG:GetModule("SchemaAccessor")
    if not SchemaAccessor then
        self:Print("|cFFFF0000SchemaAccessor not available|r")
        return
    end

    if protoAST.priority_list then
        for i, listItem in ipairs(protoAST.priority_list) do
            if listItem.action then
                local actionType = ASTAction.GetActionType(listItem.action)
                local actionData = ASTAction.GetActionData(listItem.action) or {}

                self:Print(format("|cFFFFFF00Action [%d]:|r %s", i, actionType or "unknown"))

                if actionType then
                    local metadata = SchemaAccessor:GetMetadataByIdentifier(actionType, nil)
                    if metadata and metadata.messageSchema and metadata.messageSchema.fields then
                        for fieldName, fieldInfo in pairs(metadata.messageSchema.fields) do
                            local fieldValue = actionData[fieldName]
                            if fieldValue ~= nil then
                                self:Print(format("  |cFFAAAAAA%s:|r %s", fieldName, tostring(fieldValue)))
                            end
                        end
                    end
                end
            end
        end
    end
end

--- Compare with expected schema
--- @param input string|nil Rotation string or "current"
function ProtoASTDiagnostics:CompareWithSchema(input)
    local rotationString = input or "current"
    self:Print("|cFF00FF00=== Comparing with Schema ===|r")

    local protoAST, diagnostics, err = self:ParseRotationString(rotationString)
    if err then
        self:Print("|cFFFF0000Parse Error:|r " .. err)
        return
    end

    if not protoAST then
        self:Print("|cFFFF0000Failed to parse rotation|r")
        return
    end

    local isValid, issues = ASTSchema.Validate(protoAST)
    if isValid then
        self:Print("|cFF00FF00Schema Comparison:|r AST matches expected schema")
    else
        self:Print("|cFFFF0000Schema Comparison:|r AST does not match expected schema")
        if issues then
            for i, issue in ipairs(issues) do
                self:Print(format("  |cFFFF0000[%d]|r %s: %s (at %s)", i, issue.type or "UNKNOWN", issue.message or "No message", issue.path or "root"))
            end
        end
    end
end

--- Parser health check
function ProtoASTDiagnostics:ParserHealthCheck()
    self:Print("|cFF00FF00=== Parser Health Check ===|r")

    local totalValidations = self.diagnosticStats.totalValidations
    local totalIssues = self.diagnosticStats.totalIssues
    local successRate = totalValidations > 0 and ((totalValidations - totalIssues) / totalValidations * 100) or 0

    self:Print(format("|cFFFFFF00Total Validations:|r %d", totalValidations))
    self:Print(format("|cFFFFFF00Total Issues:|r %d", totalIssues))
    self:Print(format("|cFFFFFF00Success Rate:|r %.1f%%", successRate))

    local parseTimings = self.performanceMetrics.parseTimings
    if #parseTimings > 0 then
        local total = 0
        for _, time in ipairs(parseTimings) do
            total = total + time
        end
        local avg = total / #parseTimings
        self:Print(format("|cFFFFFF00Average Parse Time:|r %.3f ms", avg))
    end
end

--- Validate proto AST compatibility
--- @param input string|nil Rotation string or "current"
function ProtoASTDiagnostics:ValidateProtoAST(input)
    local rotationString = input or "current"
    self:Print("|cFF00FF00=== Validating Proto AST ===|r")

    local protoAST, diagnostics, err = self:ParseRotationString(rotationString)
    if err then
        self:Print("|cFFFF0000Parse Error:|r " .. err)
        return
    end

    if not protoAST then
        self:Print("|cFFFF0000Failed to parse rotation|r")
        return
    end

    -- Check for legacy format
    local legacyDetected, legacyError = self:DetectLegacyFormat(protoAST)
    if legacyDetected then
        self:Print("|cFFFF0000Legacy Format Detected:|r " .. (legacyError or "unknown"))
        self:Error("Legacy format detected in AST - proto AST required")
    else
        self:Print("|cFF00FF00Proto AST Validation:|r Passed (no legacy format detected)")
    end

    -- Check node structure integrity
    if protoAST.type ~= ASTCore.NodeType.ROTATION then
        self:Print("|cFFFF0000Invalid Root Node:|r Expected ROTATION, got " .. tostring(protoAST.type))
    else
        self:Print("|cFF00FF00Root Node Type:|r Valid (ROTATION)")
    end
end

--- Test WoWSims export
--- @param input string|nil Rotation string or "current"
function ProtoASTDiagnostics:TestWoWSimsExport(input)
    local rotationString = input or "current"
    self:Print("|cFF00FF00=== Testing WoWSims Export ===|r")

    local protoAST, diagnostics, err = self:ParseRotationString(rotationString)
    if err then
        self:Print("|cFFFF0000Parse Error:|r " .. err)
        return
    end

    if not protoAST then
        self:Print("|cFFFF0000Failed to parse rotation|r")
        return
    end

    -- Try to export using ASTProto
    local ASTProto = ns.ASTProto
    if not ASTProto or not ASTProto.ToProto then
        self:Print("|cFFFF0000ASTProto not available|r")
        return
    end

    local startTime = debugprofilestop()
    local success, protoData = pcall(ASTProto.ToProto, protoAST)
    local exportTime = debugprofilestop() - startTime

    tinsert(self.performanceMetrics.exportTimes, exportTime)

    if success and protoData then
        self:Print("|cFF00FF00Export:|r Successful")
        self:Print(format("|cFFFFFF00Export Time:|r %.3f ms", exportTime))
    else
        self:Print("|cFFFF0000Export:|r Failed")
        self:Print("|cFFFF0000Error:|r " .. tostring(protoData))
    end
end

