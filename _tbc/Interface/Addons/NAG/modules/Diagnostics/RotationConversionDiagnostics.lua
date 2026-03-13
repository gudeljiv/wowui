--- @module 'NAG.RotationConversionDiagnostics'
--- UI-driven diagnostics for RotationConversionService conversions
--- Provides multi-format editors and detailed diagnostics inspection
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, GPT-5 Codex

-- ============================ LOCALIZE ============================

local _, ns = ...
--- @type NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase

-- AceGUI helpers
local AceGUI = ns.AceGUI
local TableUtils = ns.TableUtils

-- Utilities
local LibJSON = ns.LibJSON

-- Lua APIs
local pairs = pairs
local ipairs = ipairs
local type = type
local tostring = tostring
local format = format
local floor = math.floor
local min = math.min
local max = math.max

-- ============================ CONSTANTS ============================

local defaults = {
    global = {
        preferredSource = "rotation_string",
        preferredTarget = "proto_ast",
        validateOnConvert = true,
        useCacheOnConvert = true,
        roundTripIterations = 1,
        roundTripStrict = false,
        roundTripSemantic = true
    },
    char = {}
}

local RotationConversionDiagnostics = NAG:CreateModule("RotationConversionDiagnostics", defaults, {
    moduleType = ns.MODULE_TYPES.SERVICE,
    debugCategories = { ns.DEBUG_CATEGORIES.DIAGNOSTICS },

    slashCommands = {
        ["rotconv"] = {
            handler = "ShowDebugFrame",
            help = "Open Rotation Conversion diagnostics UI. Usage: /nagdebug rotconv",
            root = "nagdebug",
            path = {"rotconv"},
            category = "Debug"
        }
    }
})

if not RotationConversionDiagnostics then
    return
end

local module = RotationConversionDiagnostics

local Format = {
    ROTATION_STRING = "rotation_string",
    CLAUSE_FORMAT = "clause_format",
    PROTO_AST = "proto_ast",
    WOWSIMS_JSON = "wowsims_json"
}

local formatDisplay = {
    [Format.ROTATION_STRING] = "Rotation String",
    [Format.CLAUSE_FORMAT] = "Clause Format",
    [Format.PROTO_AST] = "Proto AST",
    [Format.WOWSIMS_JSON] = "WoWSims JSON"
}

-- ============================ MODULE STATE ============================

function module:ModuleInitialize()
    self.rotationConversionService = NAG:GetModule("RotationConversionService", true)
    self.debugFrame = nil
    self.tabGroup = nil
    self.sourceDropdown = nil
    self.targetDropdown = nil
    self.sourceInput = nil
    self.outputBox = nil
    self.statusLabel = nil
    self.diagnosticsContainer = nil
    self.lastDiagnostics = nil
    self.lastRoundTripDiagnostics = nil
    self.lastOutputs = {}
    self.lastResult = nil
    self.lastRoundTripResult = nil
    self.lastRoundTripSerialized = nil
    self.inputValues = {}
    self.currentSourceFormat = nil
    self.currentTargetFormat = nil
    self.optionsCache = {
        validate = defaults.global.validateOnConvert,
        useCache = defaults.global.useCacheOnConvert
    }
    self.roundTripOptions = {
        iterations = defaults.global.roundTripIterations,
        strict = defaults.global.roundTripStrict,
        semantic = defaults.global.roundTripSemantic
    }
    self.rotationDropdownLookup = {}
end

function module:ModuleEnable()
    self:Info("RotationConversionDiagnostics enabled - /nagdebug rotconv to open UI")
    self.rotationConversionService = self.rotationConversionService or NAG:GetModule("RotationConversionService", true)

    self.optionsCache.validate = self.db.global.validateOnConvert
    self.optionsCache.useCache = self.db.global.useCacheOnConvert

    self.roundTripOptions.iterations = self.db.global.roundTripIterations or defaults.global.roundTripIterations
    self.roundTripOptions.strict = self.db.global.roundTripStrict and true or false
    self.roundTripOptions.semantic = self.db.global.roundTripSemantic ~= false
end

-- ============================ INTERNAL HELPERS ============================

local function isTableEmpty(tbl)
    if not tbl then
        return true
    end
    return next(tbl) == nil
end

local function splitPath(path)
    local segments = {}
    if not path then
        return segments
    end
    for segment in path:gmatch("([^%.]+)") do
        if segment ~= "" then
            segments[#segments + 1] = segment
        end
    end
    return segments
end

local function GetValueAtPath(root, path)
    if not root or not path then
        return nil
    end

    local segments = splitPath(path)
    local current = root

    for _, segment in ipairs(segments) do
        if segment ~= "root" then
            if type(current) ~= "table" then
                return nil
            end
            local numericKey = tonumber(segment)
            if numericKey ~= nil and current[numericKey] ~= nil then
                current = current[numericKey]
            else
                current = current[segment]
            end
        end

        if current == nil then
            return nil
        end
    end

    return current
end

local function ParseDifferenceString(diffString)
    local summary = {
        raw = diffString,
        kind = "unknown",
        path = nil,
        effectivePath = nil,
        baselineOverride = nil,
        candidateOverride = nil,
    }

    if not diffString then
        return summary
    end

    local path, detail = diffString:match("^(.-):%s*(.*)$")
    summary.path = path

    if not detail then
        return summary
    end
    summary.effectivePath = path

    if detail:find("value mismatch", 1, true) then
        summary.kind = "mismatch"
        local baselineText, candidateText = detail:match("value mismatch %((.-) vs (.-)%)")
        summary.baselineText = baselineText
        summary.candidateText = candidateText
    elseif detail:find("missing in second value", 1, true) then
        summary.kind = "missing_in_second"
    elseif detail:find("missing in first value", 1, true) then
        summary.kind = "missing_in_first"
    elseif detail:find("type mismatch", 1, true) then
        summary.kind = "type_mismatch"
    elseif detail:find("cyclic reference mismatch", 1, true) then
        summary.kind = "cycle_mismatch"
    else
        summary.kind = "other"
    end

    summary.detail = detail
    return summary
end

local function CreateTableContainer(columnWeights, spacing)
    spacing = spacing or 8

    local container = AceGUI:Create("SimpleGroup")
    container:SetLayout("Table")

    local columns = {}
    for _, weight in ipairs(columnWeights) do
        columns[#columns + 1] = {
            weight = weight,
            align = "TOPLEFT"
        }
    end

    container:SetUserData("table", {
        columns = columns,
        space = spacing,
        align = "TOPLEFT"
    })

    return container
end

function module:GetPreferredSource()
    return self.db and self.db.global.preferredSource or defaults.global.preferredSource
end

function module:GetPreferredTarget()
    return self.db and self.db.global.preferredTarget or defaults.global.preferredTarget
end

function module:SetPreferredSource(formatKey)
    if self.db and self.db.global then
        self.db.global.preferredSource = formatKey
    end
end

function module:SetPreferredTarget(formatKey)
    if self.db and self.db.global then
        self.db.global.preferredTarget = formatKey
    end
end

local function GetSpecLabel(specIndex)
    if specIndex == 0 then
        return "Shared"
    end
    -- Get spec name from SpecCompat using dedicated API
    if specIndex then
        local SpecCompat = NAG:GetModule("SpecCompat")
        local specName = SpecCompat:GetSpecName(specIndex)
        if specName then
            return specName
        end
    end
    return tostring(specIndex or "Unknown")
end

function module:GetRotationDropdownData()
    self.rotationDropdownLookup = {}
    local values = {}

    local classModule = NAG:GetClassModule()
    if not classModule or not classModule.db or not classModule.db.class then
        return values, self.rotationDropdownLookup
    end

    local allRotations = classModule.db.class.rotations
    if not allRotations then
        return values, self.rotationDropdownLookup
    end

    local specIndices = {}
    for specIndex in pairs(allRotations) do
        specIndices[#specIndices + 1] = specIndex
    end
    table.sort(specIndices, function(a, b)
        return tonumber(a) < tonumber(b)
    end)

    for _, specIndex in ipairs(specIndices) do
        local specRotations = allRotations[specIndex]
        if type(specRotations) == "table" then
            local rotationNames = TableUtils.Keys(specRotations)
            table.sort(rotationNames, function(a, b)
                return tostring(a):lower() < tostring(b):lower()
            end)
            local specLabel = GetSpecLabel(tonumber(specIndex) or specIndex)

            for _, rotationName in ipairs(rotationNames) do
                local rotation = specRotations[rotationName]
                if rotation and type(rotation.rotationString) == "string" and rotation.rotationString ~= "" then
                    local key = tostring(specIndex) .. "::" .. tostring(rotationName)
                    values[key] = string.format("%s - %s", specLabel, rotationName)
                    self.rotationDropdownLookup[key] = {
                        specIndex = specIndex,
                        name = rotationName,
                        rotationString = rotation.rotationString
                    }
                end
            end
        end
    end

    return values, self.rotationDropdownLookup
end

function module:GetConversionService()
    if not self.rotationConversionService then
        self.rotationConversionService = NAG:GetModule("RotationConversionService", true)
    end
    return self.rotationConversionService
end

function module:FormatRoundTripValue(value)
    if type(value) == "table" then
        local ok, serialized = pcall(self.SerializePayload, self, Format.WOWSIMS_JSON, value)
        if ok and serialized then
            return serialized
        end
        return "<table>"
    end

    if value == nil then
        return "nil"
    end

    return tostring(value)
end

local DIFF_VALUE_CHAR_LIMIT = 1200

function module:FormatDiffValue(value, fallback)
    local resolved = value
    if resolved == nil then
        resolved = fallback
    end

    if resolved == nil then
        return "<nil>"
    end

    local text
    if type(resolved) == "string" then
        text = resolved
    else
        text = self:FormatRoundTripValue(resolved)
    end

    if type(text) ~= "string" then
        text = tostring(text)
    end

    if #text > DIFF_VALUE_CHAR_LIMIT then
        text = text:sub(1, math.floor(DIFF_VALUE_CHAR_LIMIT / 2)) ..
            "\n... (truncated, original length " .. #text .. ")\n" ..
            text:sub(-math.floor(DIFF_VALUE_CHAR_LIMIT / 2))
    end

    return text
end

function module:FormatDiffSummary(summary)
    local pathText = summary.effectivePath or summary.path or "root"
    if summary.kind == "mismatch" then
        return format("|cFFFF0000Value mismatch|r at |cFFFFFF00%s|r", pathText)
    elseif summary.kind == "missing_in_second" then
        return format("|cFFFF0000Missing in candidate|r at |cFFFFFF00%s|r", pathText)
    elseif summary.kind == "missing_in_first" then
        return format("|cFFFF0000Missing in baseline|r at |cFFFFFF00%s|r", pathText)
    elseif summary.kind == "type_mismatch" then
        return format("|cFFFF9900Type mismatch|r at |cFFFFFF00%s|r", pathText)
    elseif summary.kind == "cycle_mismatch" then
        return format("|cFFFF9900Cyclic reference mismatch|r at |cFFFFFF00%s|r", pathText)
    elseif summary.kind == "other" then
        return format("|cFFFFAA00Difference|r at |cFFFFFF00%s|r", pathText)
    end

    return summary.raw or "<unknown difference>"
end

function module:BuildDiffDetail(summary, baselineValue, candidateValue)
    local lines = {}
    lines[#lines + 1] = format("Path: %s", summary.effectivePath or summary.path or "root")

    if summary.kind == "mismatch" then
        lines[#lines + 1] = ""
        lines[#lines + 1] = "Baseline:"
        lines[#lines + 1] = self:FormatDiffValue(baselineValue, summary.baselineText)
        lines[#lines + 1] = ""
        lines[#lines + 1] = "Candidate:"
        lines[#lines + 1] = self:FormatDiffValue(candidateValue, summary.candidateText)
        lines[#lines + 1] = ""
    elseif summary.kind == "missing_in_second" then
        lines[#lines + 1] = ""
        lines[#lines + 1] = "Baseline:"
        lines[#lines + 1] = self:FormatDiffValue(baselineValue, summary.baselineText)
        lines[#lines + 1] = ""
        lines[#lines + 1] = "Candidate:"
        lines[#lines + 1] = "<missing>"
    elseif summary.kind == "missing_in_first" then
        lines[#lines + 1] = ""
        lines[#lines + 1] = "Baseline:"
        lines[#lines + 1] = "<missing>"
        lines[#lines + 1] = ""
        lines[#lines + 1] = "Candidate:"
        lines[#lines + 1] = self:FormatDiffValue(candidateValue, summary.candidateText)
    elseif summary.kind == "type_mismatch" or summary.kind == "cycle_mismatch" then
        lines[#lines + 1] = ""
        lines[#lines + 1] = summary.detail or summary.raw or ""
    else
        lines[#lines + 1] = ""
        lines[#lines + 1] = summary.detail or summary.raw or ""
    end

    return table.concat(lines, "\n")
end

local function DrillDownDifference(baseline, candidate, pathSegments, visitedBaseline, visitedCandidate, depthRemaining)
    if depthRemaining <= 0 then
        return nil
    end

    if type(baseline) ~= "table" or type(candidate) ~= "table" then
        return nil
    end

    if visitedBaseline[baseline] or visitedCandidate[candidate] then
        return nil
    end

    visitedBaseline[baseline] = true
    visitedCandidate[candidate] = true

    local keysSet = {}
    for key in pairs(baseline) do
        keysSet[key] = true
    end
    for key in pairs(candidate) do
        keysSet[key] = true
    end

    local keys = {}
    for key in pairs(keysSet) do
        keys[#keys + 1] = key
    end
    table.sort(keys, function(a, b)
        return tostring(a) < tostring(b)
    end)

    for _, key in ipairs(keys) do
        local baseValue = baseline[key]
        local candidateValue = candidate[key]
        local newSegments = {}
        for i = 1, #pathSegments do
            newSegments[i] = pathSegments[i]
        end
        newSegments[#newSegments + 1] = tostring(key)

        if baseValue == nil then
            return newSegments, nil, candidateValue
        elseif candidateValue == nil then
            return newSegments, baseValue, nil
        end

        local sameType = type(baseValue) == type(candidateValue)
        local valuesEqual = sameType and (baseValue == candidateValue)

        if not sameType then
            return newSegments, baseValue, candidateValue
        end

        if type(baseValue) == "table" then
            local deeperSegments, deeperBase, deeperCandidate = DrillDownDifference(
                baseValue,
                candidateValue,
                newSegments,
                visitedBaseline,
                visitedCandidate,
                depthRemaining - 1
            )

            if deeperSegments then
                return deeperSegments, deeperBase, deeperCandidate
            end
        elseif not valuesEqual then
            return newSegments, baseValue, candidateValue
        end
    end

    return nil
end

function module:ParsePayload(formatKey, rawText)
    if not rawText or rawText == "" then
        return nil, "Input is empty"
    end

    if formatKey == Format.ROTATION_STRING then
        return rawText, nil
    end

    -- Attempt JSON first
    if LibJSON then
        if self.Debug then
            local preview = rawText:sub(1, 120)
            local bytes = {}
            for i = 1, math.min(20, #rawText) do
                bytes[#bytes + 1] = rawText:byte(i)
            end
            self:Debug("ParsePayload: rawText preview: %s (bytes: %s)", preview, table.concat(bytes, ","))
        end

        local trimmed = rawText:match("^%s*(.-)%s*$")
        rawText = trimmed or rawText
        if trimmed and trimmed:sub(1, 1) == '"' and trimmed:sub(-1) == '"' then
            local okWrapped, unwrapped = pcall(LibJSON.Deserialize, trimmed)
            if okWrapped and type(unwrapped) == "string" then
                rawText = unwrapped
            end
        end

        local ok, result = pcall(LibJSON.Deserialize, rawText)
        if ok then
            return result, nil
        end

        if self.Debug then
            self:Debug("ParsePayload: LibJSON deserialize failed (%s)", tostring(result))
        end

        if formatKey == Format.WOWSIMS_JSON then
            return nil, format("Failed to parse input as JSON: %s", tostring(result))
        end
    elseif self.Debug then
        self:Debug("ParsePayload: LibJSON unavailable, falling back to loadstring")
    end

    -- Fallback to loadstring for Lua table representations
    local chunkText = rawText
    if not rawText:match("^return") then
        chunkText = "return " .. rawText
    end

    local func, err = loadstring(chunkText)
    if not func then
        if self.Debug then
            self:Debug("ParsePayload: loadstring compile failed (%s)", tostring(err))
        end
        return nil, format("Failed to parse input: %s", err or "unknown error")
    end

    local ok, result = pcall(func)
    if not ok then
        if self.Debug then
            self:Debug("ParsePayload: loadstring execution failed (%s)", tostring(result))
        end
        return nil, format("Failed to evaluate input: %s", result or "unknown error")
    end

    if type(result) ~= "table" then
        return nil, "Parsed value is not a table"
    end

    return result, nil
end

function module:SerializePayload(formatKey, payload)
    if formatKey == Format.ROTATION_STRING then
        return type(payload) == "string" and payload or tostring(payload)
    end

    if not payload or type(payload) ~= "table" then
        return ""
    end

    if LibJSON then
        local ok, serialized = pcall(LibJSON.Serialize, payload)
        if ok then
            return serialized
        end
    end

    -- Fallback serializer (simple)
    local function serializeTable(value, depth)
        depth = depth or 0
        local indent = string.rep("  ", depth)
        local pieces = {"{"}
        for key, item in pairs(value) do
            local keyStr = tostring(key)
            local itemStr
            if type(item) == "table" then
                itemStr = serializeTable(item, depth + 1)
            elseif type(item) == "string" then
                itemStr = string.format("\"%s\"", item)
            else
                itemStr = tostring(item)
            end
            pieces[#pieces + 1] = string.format("%s  [%s] = %s,", indent, keyStr, itemStr)
        end
        pieces[#pieces + 1] = indent .. "}"
        return table.concat(pieces, "\n")
    end

    return serializeTable(payload)
end

function module:CaptureOutputs(result, diagnostics, targetFormat, serializedOutput)
    self.lastResult = result
    self.lastDiagnostics = diagnostics

    if targetFormat and serializedOutput then
        self.lastOutputs[targetFormat] = serializedOutput
    end
end

function module:UpdateStatus(message, isError)
    if self.statusLabel then
        local color = isError and "|cFFFF0000" or "|cFF00FF00"
        self.statusLabel:SetText(color .. (message or "") .. "|r")
    end
end

function module:RefreshDiagnosticsTab()
    if not self.diagnosticsContainer then
        return
    end

    self:RenderDiagnosticsTab(self.diagnosticsContainer)
end

-- ============================ UI RENDERING ============================

function module:ShowDebugFrame()
    if self.debugFrame then
        self.debugFrame:Show()
        return
    end

    local frame = AceGUI:Create("Frame")
    frame:SetTitle("Rotation Conversion Diagnostics")
    frame:SetWidth(1000)
    frame:SetHeight(720)
    frame:SetLayout("Fill")
    frame:SetCallback("OnClose", function(widget)
        if self.sourceDropdown and self.sourceInput then
            local activeFormat = self.currentSourceFormat or self.sourceDropdown:GetValue()
            if activeFormat then
                self.inputValues[activeFormat] = self.sourceInput:GetText() or ""
            end
        end

        AceGUI:Release(widget)
        self.debugFrame = nil
        self.tabGroup = nil
        self.sourceDropdown = nil
        self.targetDropdown = nil
        self.sourceInput = nil
        self.outputBox = nil
        self.diagnosticsContainer = nil
        self.statusLabel = nil
    end)

    local tabGroup = AceGUI:Create("TabGroup")
    tabGroup:SetLayout("Fill")
    tabGroup:SetTabs({
        { text = "Conversion", value = "conversion" },
        { text = "Diagnostics", value = "diagnostics" }
    })

    tabGroup:SetCallback("OnGroupSelected", function(container, _, tabKey)
        container:ReleaseChildren()

        if tabKey == "conversion" then
            self:RenderConversionTab(container)
        elseif tabKey == "diagnostics" then
            self:RenderDiagnosticsTab(container)
        end
    end)

    frame:AddChild(tabGroup)
    tabGroup:SelectTab("conversion")

    self.debugFrame = frame
    self.tabGroup = tabGroup
end

function module:RenderConversionTab(container)
    self.diagnosticsContainer = nil

    container:ReleaseChildren()
    container:SetLayout("List")

    -- Compact controls at top using Flow layout
    local controlsGroup = AceGUI:Create("InlineGroup")
    controlsGroup:SetTitle("Conversion Controls")
    controlsGroup:SetLayout("Flow")
    controlsGroup:SetFullWidth(true)
    controlsGroup:SetFullHeight(false)
    container:AddChild(controlsGroup)

    -- First row: Format dropdowns
    local sourceDropdown = AceGUI:Create("Dropdown")
    sourceDropdown:SetLabel("Source")
    sourceDropdown:SetWidth(180)
    sourceDropdown:SetList({
        [Format.ROTATION_STRING] = formatDisplay[Format.ROTATION_STRING],
        [Format.CLAUSE_FORMAT] = formatDisplay[Format.CLAUSE_FORMAT],
        [Format.PROTO_AST] = formatDisplay[Format.PROTO_AST],
        [Format.WOWSIMS_JSON] = formatDisplay[Format.WOWSIMS_JSON]
    })
    sourceDropdown:SetValue(self:GetPreferredSource())
    controlsGroup:AddChild(sourceDropdown)

    local targetDropdown = AceGUI:Create("Dropdown")
    targetDropdown:SetLabel("Target")
    targetDropdown:SetWidth(180)
    targetDropdown:SetList({
        [Format.ROTATION_STRING] = formatDisplay[Format.ROTATION_STRING],
        [Format.CLAUSE_FORMAT] = formatDisplay[Format.CLAUSE_FORMAT],
        [Format.PROTO_AST] = formatDisplay[Format.PROTO_AST],
        [Format.WOWSIMS_JSON] = formatDisplay[Format.WOWSIMS_JSON]
    })
    targetDropdown:SetValue(self:GetPreferredTarget())
    controlsGroup:AddChild(targetDropdown)

    -- Second row: Checkboxes and buttons
    local validateCheckbox = AceGUI:Create("CheckBox")
    validateCheckbox:SetLabel("Validate")
    validateCheckbox:SetValue(self.optionsCache.validate)
    validateCheckbox:SetCallback("OnValueChanged", function(_, _, value)
        self.optionsCache.validate = value
        if self.db and self.db.global then
            self.db.global.validateOnConvert = value and true or false
        end
    end)
    controlsGroup:AddChild(validateCheckbox)

    local cacheCheckbox = AceGUI:Create("CheckBox")
    cacheCheckbox:SetLabel("Use Cache")
    cacheCheckbox:SetValue(self.optionsCache.useCache)
    cacheCheckbox:SetCallback("OnValueChanged", function(_, _, value)
        self.optionsCache.useCache = value
        if self.db and self.db.global then
            self.db.global.useCacheOnConvert = value and true or false
        end
    end)
    controlsGroup:AddChild(cacheCheckbox)

    local convertButton = AceGUI:Create("Button")
    convertButton:SetText("Convert")
    convertButton:SetWidth(120)
    convertButton:SetCallback("OnClick", function()
        local sourceFormat = sourceDropdown:GetValue()
        local targetFormat = targetDropdown:GetValue()
        self:HandleConversionRequest(sourceFormat, targetFormat)
    end)
    controlsGroup:AddChild(convertButton)

    -- Third row: Round trip controls
    local roundTripSlider = AceGUI:Create("Slider")
    roundTripSlider:SetLabel("Iterations")
    roundTripSlider:SetWidth(150)
    roundTripSlider:SetSliderValues(1, 5, 1)
    roundTripSlider:SetIsPercent(false)
    roundTripSlider:SetValue(self.roundTripOptions.iterations or defaults.global.roundTripIterations)
    roundTripSlider:SetCallback("OnValueChanged", function(_, _, value)
        local numeric = tonumber(value) or defaults.global.roundTripIterations
        numeric = floor(numeric + 0.5)
        numeric = max(1, min(5, numeric))
        self.roundTripOptions.iterations = numeric
        if self.db and self.db.global then
            self.db.global.roundTripIterations = numeric
        end
    end)
    controlsGroup:AddChild(roundTripSlider)

    local strictCheckbox = AceGUI:Create("CheckBox")
    strictCheckbox:SetLabel("Strict")
    strictCheckbox:SetValue(self.roundTripOptions.strict)
    strictCheckbox:SetCallback("OnValueChanged", function(_, _, value)
        local strict = value and true or false
        self.roundTripOptions.strict = strict
        if self.db and self.db.global then
            self.db.global.roundTripStrict = strict
        end
    end)
    controlsGroup:AddChild(strictCheckbox)

    local semanticCheckbox = AceGUI:Create("CheckBox")
    semanticCheckbox:SetLabel("Semantic")
    semanticCheckbox:SetValue(self.roundTripOptions.semantic ~= false)
    semanticCheckbox:SetCallback("OnValueChanged", function(_, _, value)
        self.roundTripOptions.semantic = value and true or false
        if self.db and self.db.global then
            self.db.global.roundTripSemantic = self.roundTripOptions.semantic
        end
    end)
    controlsGroup:AddChild(semanticCheckbox)

    local roundTripButton = AceGUI:Create("Button")
    roundTripButton:SetText("Round Trip")
    roundTripButton:SetWidth(120)
    roundTripButton:SetCallback("OnClick", function()
        local sourceFormat = sourceDropdown:GetValue()
        local targetFormat = targetDropdown:GetValue()
        self:HandleRoundTripRequest(sourceFormat, targetFormat)
    end)
    controlsGroup:AddChild(roundTripButton)

    local roundTripHint = AceGUI:Create("Label")
    roundTripHint:SetFullWidth(true)
    roundTripHint:SetText("Semantic=on: compare canonical form (parens/formatting normalized, same meaning = pass). Semantic=off: strict normalized string. Source & Target = Rotation String.")
    controlsGroup:AddChild(roundTripHint)

    -- Fourth row: Load rotation and status
    local rotationValues, rotationLookup = self:GetRotationDropdownData()
    if TableUtils.Size(rotationValues) > 0 then
        local rotationDropdown = AceGUI:Create("Dropdown")
        rotationDropdown:SetLabel("Load Rotation")
        rotationDropdown:SetWidth(250)
        rotationDropdown:SetList(rotationValues)
        rotationDropdown:SetCallback("OnValueChanged", function(_, _, key)
            local entry = rotationLookup[key]
            if not entry or not self.sourceInput then
                return
            end

            self.sourceInput:SetText(entry.rotationString or "")
            if self.sourceDropdown then
                self.sourceDropdown:SetValue(Format.ROTATION_STRING)
                self.currentSourceFormat = Format.ROTATION_STRING
            end
            self.inputValues[Format.ROTATION_STRING] = entry.rotationString or ""
        end)
        controlsGroup:AddChild(rotationDropdown)
    end

    local statusLabel = AceGUI:Create("Label")
    statusLabel:SetWidth(200)
    statusLabel:SetText("Ready")
    controlsGroup:AddChild(statusLabel)
    self.statusLabel = statusLabel

    -- Store dropdown references
    self.sourceDropdown = sourceDropdown
    self.targetDropdown = targetDropdown

    -- ScrollFrame directly in container - matches Diagnostics tab pattern
    local editorsScroll = AceGUI:Create("ScrollFrame")
    editorsScroll:SetLayout("List")
    editorsScroll:SetFullWidth(true)
    editorsScroll:SetFullHeight(true)
    container:AddChild(editorsScroll)

    local sourceInput = AceGUI:Create("MultiLineEditBox")
    sourceInput:SetLabel("Source Payload")
    sourceInput:SetFullWidth(true)
    sourceInput:SetNumLines(30)
    editorsScroll:AddChild(sourceInput)

    local outputBox = AceGUI:Create("MultiLineEditBox")
    outputBox:SetLabel("Conversion Output")
    outputBox:SetFullWidth(true)
    outputBox:SetNumLines(30)
    outputBox:SetDisabled(false)
    editorsScroll:AddChild(outputBox)

    self.sourceInput = sourceInput
    self.outputBox = outputBox

    self.currentSourceFormat = sourceDropdown:GetValue()
    self.currentTargetFormat = targetDropdown:GetValue()

    sourceInput:SetText(self.inputValues[self.currentSourceFormat] or "")
    outputBox:SetText(self.lastOutputs[self.currentTargetFormat] or "")

    sourceDropdown:SetCallback("OnValueChanged", function(_, _, value)
        local previous = self.currentSourceFormat
        if previous and self.sourceInput then
            self.inputValues[previous] = self.sourceInput:GetText() or ""
        end

        self.currentSourceFormat = value
        self:SetPreferredSource(value)
        self.sourceInput:SetText(self.inputValues[value] or "")
    end)

    targetDropdown:SetCallback("OnValueChanged", function(_, _, value)
        self.currentTargetFormat = value
        self:SetPreferredTarget(value)
        if self.outputBox then
            self.outputBox:SetText(self.lastOutputs[value] or "")
        end
    end)
end

function module:RenderDiagnosticsTab(container)
    self.diagnosticsContainer = container

    container:ReleaseChildren()

    local scrollFrame = AceGUI:Create("ScrollFrame")
    scrollFrame:SetLayout("List")
    scrollFrame:SetFullWidth(true)
    scrollFrame:SetFullHeight(true)
    container:AddChild(scrollFrame)

    local hasConversion = self.lastDiagnostics ~= nil
    local hasRoundTrip = self.lastRoundTripDiagnostics ~= nil

    if not hasConversion and not hasRoundTrip then
        local label = AceGUI:Create("Label")
        label:SetText("No diagnostics yet. Run a conversion or round-trip validation.")
        label:SetFullWidth(true)
        scrollFrame:AddChild(label)
        return
    end

    if hasConversion then
        local summary = AceGUI:Create("Heading")
        summary:SetText("Conversion Summary")
        summary:SetFullWidth(true)
        scrollFrame:AddChild(summary)

        local statusText = format("Success: %s", tostring(self.lastDiagnostics.success))
        local statusLabel = AceGUI:Create("Label")
        statusLabel:SetText(statusText)
        statusLabel:SetFullWidth(true)
        scrollFrame:AddChild(statusLabel)

        local formatsLabel = AceGUI:Create("Label")
        formatsLabel:SetText(format("Path: %s → %s", formatDisplay[self.lastDiagnostics.from] or self.lastDiagnostics.from, formatDisplay[self.lastDiagnostics.to] or self.lastDiagnostics.to))
        formatsLabel:SetFullWidth(true)
        scrollFrame:AddChild(formatsLabel)

        if self.lastDiagnostics.metadata and not isTableEmpty(self.lastDiagnostics.metadata) then
            local metadataHeading = AceGUI:Create("Heading")
            metadataHeading:SetText("Metadata")
            metadataHeading:SetFullWidth(true)
            scrollFrame:AddChild(metadataHeading)

            for key, value in pairs(self.lastDiagnostics.metadata) do
                local valueText
                if type(value) == "table" then
                    valueText = self:SerializePayload(Format.WOWSIMS_JSON, value)
                else
                    valueText = tostring(value)
                end

                local label = AceGUI:Create("Label")
                label:SetText(format("%s: %s", tostring(key), valueText))
                label:SetFullWidth(true)
                scrollFrame:AddChild(label)
            end
        end

        if self.lastDiagnostics.warnings and #self.lastDiagnostics.warnings > 0 then
            local warningsHeading = AceGUI:Create("Heading")
            warningsHeading:SetText("Warnings")
            warningsHeading:SetFullWidth(true)
            scrollFrame:AddChild(warningsHeading)

            for index, warning in ipairs(self.lastDiagnostics.warnings) do
                local label = AceGUI:Create("Label")
                label:SetText(format("%d. %s", index, warning))
                label:SetFullWidth(true)
                scrollFrame:AddChild(label)
            end
        end

        if self.lastDiagnostics.errors and #self.lastDiagnostics.errors > 0 then
            local errorsHeading = AceGUI:Create("Heading")
            errorsHeading:SetText("Errors")
            errorsHeading:SetFullWidth(true)
            scrollFrame:AddChild(errorsHeading)

            for index, err in ipairs(self.lastDiagnostics.errors) do
                local label = AceGUI:Create("Label")
                label:SetText(format("%d. %s", index, err))
                label:SetFullWidth(true)
                scrollFrame:AddChild(label)
            end
        end

        if self.lastDiagnostics.steps and #self.lastDiagnostics.steps > 0 then
            local stepsHeading = AceGUI:Create("Heading")
            stepsHeading:SetText("Conversion Steps")
            stepsHeading:SetFullWidth(true)
            scrollFrame:AddChild(stepsHeading)

            for stepIndex, step in ipairs(self.lastDiagnostics.steps) do
                local label = AceGUI:Create("Label")
                label:SetText(format("%d. %s → %s (%s, %.3fs)", stepIndex, step.from or "?", step.to or "?", step.direct and "direct" or "via hub", step.duration or 0))
                label:SetFullWidth(true)
                scrollFrame:AddChild(label)
            end
        end

        if self.lastResult then
            local resultHeading = AceGUI:Create("Heading")
            resultHeading:SetText("Last Result Snapshot")
            resultHeading:SetFullWidth(true)
            scrollFrame:AddChild(resultHeading)

            local resultBox = AceGUI:Create("MultiLineEditBox")
            resultBox:SetLabel(format("Result (%s)", formatDisplay[self.lastDiagnostics.to] or self.lastDiagnostics.to))
            resultBox:SetFullWidth(true)
            resultBox:SetNumLines(10)
            resultBox:SetText(self:SerializePayload(self.lastDiagnostics.to, self.lastResult))
            resultBox:SetDisabled(true)
            scrollFrame:AddChild(resultBox)
        end
    end

    if hasRoundTrip then
        local roundHeading = AceGUI:Create("Heading")
        roundHeading:SetText("Round Trip Summary")
        roundHeading:SetFullWidth(true)
        scrollFrame:AddChild(roundHeading)

        local rt = self.lastRoundTripDiagnostics

        local successLabel = AceGUI:Create("Label")
        successLabel:SetText(format("Success: %s", tostring(rt and rt.success)))
        successLabel:SetFullWidth(true)
        scrollFrame:AddChild(successLabel)

        local iterationLabel = AceGUI:Create("Label")
        iterationLabel:SetText(format("Iterations: %d", rt and rt.iterations or 0))
        iterationLabel:SetFullWidth(true)
        scrollFrame:AddChild(iterationLabel)

        if rt and rt.metadata then
            local strictLabel = AceGUI:Create("Label")
            local strict = rt.metadata.strict and "true" or "false"
            strictLabel:SetText(format("Strict Comparison: %s", strict))
            strictLabel:SetFullWidth(true)
            scrollFrame:AddChild(strictLabel)
        end

        if rt and rt.normalizedBaseline then
            local baselineHeading = AceGUI:Create("Heading")
            baselineHeading:SetText("Normalized Baseline")
            baselineHeading:SetFullWidth(true)
            scrollFrame:AddChild(baselineHeading)

            local baselineBox = AceGUI:Create("MultiLineEditBox")
            baselineBox:SetLabel("Baseline (canonical form)")
            baselineBox:SetFullWidth(true)
            baselineBox:SetNumLines(8)
            baselineBox:SetText(self:FormatRoundTripValue(rt.normalizedBaseline))
            baselineBox:SetDisabled(true)
            scrollFrame:AddChild(baselineBox)
        end

        if rt and rt.warnings and #rt.warnings > 0 then
            local warningsHeading = AceGUI:Create("Heading")
            warningsHeading:SetText("Round Trip Warnings")
            warningsHeading:SetFullWidth(true)
            scrollFrame:AddChild(warningsHeading)

            for index, warning in ipairs(rt.warnings) do
                local label = AceGUI:Create("Label")
                label:SetText(format("%d. %s", index, warning))
                label:SetFullWidth(true)
                scrollFrame:AddChild(label)
            end
        end

        if rt and rt.errors and #rt.errors > 0 then
            local errorsHeading = AceGUI:Create("Heading")
            errorsHeading:SetText("Round Trip Errors")
            errorsHeading:SetFullWidth(true)
            scrollFrame:AddChild(errorsHeading)

            for index, err in ipairs(rt.errors) do
                local label = AceGUI:Create("Label")
                label:SetText(format("%d. %s", index, err))
                label:SetFullWidth(true)
                scrollFrame:AddChild(label)
            end
        end

        if rt and rt.rounds and #rt.rounds > 0 then
            local roundsHeading = AceGUI:Create("Heading")
            roundsHeading:SetText("Iteration Details")
            roundsHeading:SetFullWidth(true)
            scrollFrame:AddChild(roundsHeading)

            for _, roundInfo in ipairs(rt.rounds) do
                local line = AceGUI:Create("Label")
                local diffCount = roundInfo.differences and #roundInfo.differences or 0
                line:SetText(format("Iteration %d: equal=%s, differences=%d",
                    roundInfo.iteration or 0,
                    tostring(roundInfo.equal),
                    diffCount))
                line:SetFullWidth(true)
                scrollFrame:AddChild(line)

                if diffCount > 0 then
                    for diffIndex, diff in ipairs(roundInfo.differences) do
                        local summary = ParseDifferenceString(diff)
                        local diffGroup = AceGUI:Create("InlineGroup")
                        diffGroup:SetTitle(format("Difference %d", diffIndex))
                        diffGroup:SetFullWidth(true)

                local baselineRoot = roundInfo.normalizedBaseline
                local candidateRoot = roundInfo.normalizedCandidate
                local effectivePath = summary.effectivePath or summary.path

                if (not effectivePath or effectivePath == "root") and type(baselineRoot) == "table" and type(candidateRoot) == "table" then
                    local drilledSegments, drilledBaseline, drilledCandidate = DrillDownDifference(
                        baselineRoot,
                        candidateRoot,
                        {},
                        {},
                        {},
                        8
                    )
                    if drilledSegments then
                        summary.baselineOverride = drilledBaseline
                        summary.candidateOverride = drilledCandidate
                        summary.effectivePath = "root." .. table.concat(drilledSegments, ".")
                        effectivePath = summary.effectivePath
                    end
                end

                        local summaryLabel = AceGUI:Create("Label")
                        summaryLabel:SetText(self:FormatDiffSummary(summary))
                        summaryLabel:SetFullWidth(true)
                        diffGroup:AddChild(summaryLabel)

                local baselineValue = summary.baselineOverride
                if baselineValue == nil then
                    baselineValue = GetValueAtPath(baselineRoot, summary.effectivePath or summary.path)
                end

                local candidateValue = summary.candidateOverride
                if candidateValue == nil then
                    candidateValue = GetValueAtPath(candidateRoot, summary.effectivePath or summary.path)
                end

                        local detailText = self:BuildDiffDetail(summary, baselineValue, candidateValue)

                        local detailBox = AceGUI:Create("MultiLineEditBox")
                        detailBox:SetLabel("Details")
                        detailBox:SetFullWidth(true)
                        detailBox:SetNumLines(8)
                        detailBox:SetText(detailText)
                        detailBox:SetDisabled(true)
                        diffGroup:AddChild(detailBox)

                        scrollFrame:AddChild(diffGroup)
                    end
                end
            end
        end

        if self.lastRoundTripResult then
            local finalHeading = AceGUI:Create("Heading")
            finalHeading:SetText("Round Trip Final Payload")
            finalHeading:SetFullWidth(true)
            scrollFrame:AddChild(finalHeading)

            local finalBox = AceGUI:Create("MultiLineEditBox")
            finalBox:SetLabel("Final Payload (source format)")
            finalBox:SetFullWidth(true)
            finalBox:SetNumLines(8)
            finalBox:SetText(self.lastRoundTripSerialized or "")
            finalBox:SetDisabled(true)
            scrollFrame:AddChild(finalBox)
        end
    end
end

-- ============================ ACTION HANDLERS ============================

function module:HandleConversionRequest(sourceFormat, targetFormat)
    if not sourceFormat or not targetFormat then
        self:UpdateStatus("Select source and target formats", true)
        return
    end

    if sourceFormat == targetFormat then
        self:UpdateStatus("Source and target formats are identical", true)
        return
    end

    local service = self:GetConversionService()
    if not service then
        self:UpdateStatus("RotationConversionService not available", true)
        return
    end

    local inputWidget = self.sourceInput
    if not inputWidget then
        self:UpdateStatus("Input widget not ready", true)
        return
    end

    local rawText = inputWidget:GetText() or ""
    self.inputValues[sourceFormat] = rawText

    local payload, parseErr = self:ParsePayload(sourceFormat, rawText)
    if parseErr then
        self:UpdateStatus(parseErr, true)
        return
    end

    local options = {
        validate = self.optionsCache.validate,
        useCache = self.optionsCache.useCache
    }

    local result, diagnostics = service:Convert(sourceFormat, targetFormat, payload, options)
    if not diagnostics then
        diagnostics = {
            success = false,
            errors = {"Conversion returned no diagnostics"},
            warnings = {},
            metadata = {},
            steps = {},
            from = sourceFormat,
            to = targetFormat
        }
    end

    if not result then
        local errorMessage = diagnostics and diagnostics.errors and diagnostics.errors[1] or "Conversion failed"
        self:CaptureOutputs(nil, diagnostics, targetFormat, nil)
        self:UpdateStatus(errorMessage, true)
        if self.outputBox then
            self.outputBox:SetText("")
        end
        self:RefreshDiagnosticsTab()
        return
    end

    local serializedOutput = self:SerializePayload(targetFormat, result)
    if self.Debug then
        local preview = serializedOutput or ""
        self:Debug("HandleConversionRequest: serialized output preview: %s (length=%d)", preview:sub(1, 120), #preview)
    end
    if self.outputBox then
        self.outputBox:SetText(serializedOutput or "")
    end

    self:CaptureOutputs(result, diagnostics, targetFormat, serializedOutput)
    self:UpdateStatus("Conversion completed", false)

    self:RefreshDiagnosticsTab()
end

function module:HandleRoundTripRequest(sourceFormat, targetFormat)
    if not sourceFormat or not targetFormat then
        self:UpdateStatus("Select source and target formats", true)
        return
    end

    local service = self:GetConversionService()
    if not service then
        self:UpdateStatus("RotationConversionService not available", true)
        return
    end

    local inputWidget = self.sourceInput
    if not inputWidget then
        self:UpdateStatus("Input widget not ready", true)
        return
    end

    local rawText = inputWidget:GetText() or ""
    self.inputValues[sourceFormat] = rawText

    local payload, parseErr = self:ParsePayload(sourceFormat, rawText)
    if parseErr then
        self:UpdateStatus(parseErr, true)
        return
    end

    local options = {
        iterations = self.roundTripOptions.iterations or 1,
        strict = self.roundTripOptions.strict,
        semanticRoundTrip = self.roundTripOptions.semantic ~= false,
        forwardOptions = {
            validate = self.optionsCache.validate,
            useCache = self.optionsCache.useCache
        },
        backwardOptions = {
            validate = self.optionsCache.validate,
            useCache = self.optionsCache.useCache
        }
    }

    local finalPayload, diagnostics = service:ValidateRoundTrip(sourceFormat, targetFormat, payload, options)
    self.lastRoundTripDiagnostics = diagnostics or {
        success = false,
        errors = {"Round-trip diagnostics unavailable"},
        warnings = {},
        iterations = options.iterations,
        metadata = {
            strict = self.roundTripOptions.strict
        }
    }

    self.lastRoundTripResult = finalPayload
    if finalPayload then
        self.lastRoundTripSerialized = self:SerializePayload(sourceFormat, finalPayload)
    else
        self.lastRoundTripSerialized = nil
    end

    if self.outputBox then
        self.outputBox:SetText(self.lastRoundTripSerialized or "")
    end

    if self.lastRoundTripDiagnostics and self.lastRoundTripDiagnostics.success then
        self:UpdateStatus("Round trip successful", false)
    else
        local errMsg
        if self.lastRoundTripDiagnostics and self.lastRoundTripDiagnostics.errors then
            errMsg = self.lastRoundTripDiagnostics.errors[1]
        end
        self:UpdateStatus(errMsg or "Round trip failed", true)
    end

    self:RefreshDiagnosticsTab()
end

return RotationConversionDiagnostics


