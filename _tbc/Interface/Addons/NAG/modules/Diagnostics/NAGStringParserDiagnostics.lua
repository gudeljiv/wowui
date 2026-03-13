--- @module 'NAG.NAGStringParserDiagnostics'
--- GUI diagnostic tool for NAGStringParser (WoW API only - no AceGUI)
--- Provides interactive testing and visualization of rotation string parsing
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

-- Services
local RotationConversionService = ns.RotationConversionService

-- Libraries
local L = ns.AceLocale:GetLocale("NAG", true)

-- Lua APIs
local format = string.format
local ipairs = ipairs
local tostring = tostring
local CreateFrame = _G.CreateFrame
local tinsert = table.insert
local tconcat = table.concat
local debugprofilestop = debugprofilestop

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

--- @class NAGStringParserDiagnostics : CoreModule
local defaults = {
    global = {
        windowWidth = 1200,
        windowHeight = 800
    },
    char = {}
}

local NAGStringParserDiagnostics = NAG:CreateModule("NAGStringParserDiagnostics", defaults, {
    moduleType = ns.MODULE_TYPES.SERVICE,
    debugCategories = { ns.DEBUG_CATEGORIES.DIAGNOSTICS },

    slashCommands = {
        ["parser"] = {
            handler = "ShowParserGUI",
            help = "Open NAGStringParser diagnostic GUI. Usage: /nagdebug parser",
            root = "nagdebug",
            category = "Debug"
        },
        ["parsertest"] = {
            handler = "ShowParserGUI",
            help = "Open NAGStringParser diagnostic GUI. Usage: /nagdebug parsertest",
            root = "nagdebug",
            category = "Debug"
        }
    }
})

if not NAGStringParserDiagnostics then return end

-- ============================ MODULE INITIALIZATION ============================

function NAGStringParserDiagnostics:ModuleInitialize()
    self.mainFrame = nil
    self.inputBox = nil
    self.outputScrollFrame = nil
    self.outputContent = nil
    self.lastOutputY = -5
    self.lastParseResult = nil
    self.lastParseAST = nil
    self.lastParseError = nil
    self.lastParseTime = 0
end

function NAGStringParserDiagnostics:ModuleEnable()
    self:Info("NAGStringParserDiagnostics module enabled - Parser diagnostic GUI")
    self:Info("Open GUI: /nagdebug parser")
end

-- ============================ GUI IMPLEMENTATION ============================

--- Show parser diagnostic GUI (WoW API only)
function NAGStringParserDiagnostics:ShowParserGUI()
    if self.mainFrame and self.mainFrame:IsShown() then
        self.mainFrame:Hide()
        return
    end

    if self.mainFrame then
        self.mainFrame:Show()
        return
    end

    -- Create main frame
    local frame = CreateFrame("Frame", "NAGStringParserDiagnosticsFrame", UIParent, "BackdropTemplate")
    frame:SetSize(self.db.global.windowWidth, self.db.global.windowHeight)
    frame:SetPoint("CENTER")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

    -- Backdrop
    local backdrop = {
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 }
    }
    frame:SetBackdrop(backdrop)
    frame:SetBackdropColor(0, 0, 0, 0.95)

    -- Title bar
    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", 0, -15)
    title:SetText("NAGStringParser Diagnostics")

    -- Close button
    local closeBtn = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", -5, -5)
    closeBtn:SetScript("OnClick", function()
        frame:Hide()
    end)

    -- Input section label
    local inputLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    inputLabel:SetPoint("TOPLEFT", 15, -50)
    inputLabel:SetText("Rotation String Input:")

    -- Input editbox
    local inputScrollFrame = CreateFrame("ScrollFrame", "NAGStringParserInputScrollFrame", frame, "UIPanelScrollFrameTemplate")
    inputScrollFrame:SetPoint("TOPLEFT", inputLabel, "BOTTOMLEFT", 0, -5)
    inputScrollFrame:SetPoint("TOPRIGHT", frame, "TOP", -10, -55)
    inputScrollFrame:SetHeight(150)
    inputScrollFrame:SetWidth((self.db.global.windowWidth / 2) - 20)

    local inputEditBox = CreateFrame("EditBox", "NAGStringParserInputEditBox", inputScrollFrame)
    inputEditBox:SetMultiLine(true)
    inputEditBox:SetFontObject(ChatFontNormal)
    inputEditBox:SetWidth(inputScrollFrame:GetWidth() - 30)
    inputEditBox:SetAutoFocus(false)
    inputEditBox:SetText("-- Example:\nNAG:CastSpell(123)\nor (NAG:IsExecutePhase(25)) and NAG:CastSpell(456)")
    inputEditBox:SetScript("OnTextChanged", function(self)
        -- Debounce: parse after user stops typing
        if NAGStringParserDiagnostics.parseTimer then
            NAGStringParserDiagnostics.parseTimer:Cancel()
        end
        NAGStringParserDiagnostics.parseTimer = ns.TimerManager:Create("diagnostics", "parser_parse", function()
            local text = NAGStringParserDiagnostics.inputBox:GetText()
            if text and text ~= "" then
                NAGStringParserDiagnostics:ParseAndUpdate(text)
            end
        end, 0.5, false)
    end)

    inputScrollFrame:SetScrollChild(inputEditBox)
    self.inputBox = inputEditBox

    -- Parse button
    local parseButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    parseButton:SetSize(200, 30)
    parseButton:SetPoint("TOPLEFT", inputScrollFrame, "BOTTOMLEFT", 0, -10)
    parseButton:SetText("Parse Now")
    parseButton:SetScript("OnClick", function()
        local text = inputEditBox:GetText()
        if text and text ~= "" then
            NAGStringParserDiagnostics:ParseAndUpdate(text)
        end
    end)

    -- Output section label
    local outputLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    outputLabel:SetPoint("TOPLEFT", frame, "TOP", 10, -50)
    outputLabel:SetText("Parse Results & Proto AST Output:")

    -- Output scroll frame
    local outputScrollFrame = CreateFrame("ScrollFrame", "NAGStringParserOutputScrollFrame", frame, "UIPanelScrollFrameTemplate")
    outputScrollFrame:SetPoint("TOPLEFT", outputLabel, "BOTTOMLEFT", 0, -5)
    outputScrollFrame:SetPoint("TOPRIGHT", -30, -55)
    outputScrollFrame:SetPoint("BOTTOMRIGHT", -30, 30)

    local outputContent = CreateFrame("Frame", "NAGStringParserOutputContent", outputScrollFrame)
    outputContent:SetWidth(outputScrollFrame:GetWidth() - 30)
    outputContent:SetHeight(1000) -- Will grow dynamically
    outputScrollFrame:SetScrollChild(outputContent)

    self.outputScrollFrame = outputScrollFrame
    self.outputContent = outputContent
    self.mainFrame = frame

    -- Initial parse
    self:ParseAndUpdate(inputEditBox:GetText())

    frame:Show()
end

--- Clear output content
function NAGStringParserDiagnostics:ClearOutput()
    if not self.outputContent then
        return
    end

    -- Collect all children (frames and font strings)
    local children = {}
    local child = self.outputContent:GetChildren()
    while child do
        tinsert(children, child)
        child = child:GetNext()
    end

    -- Collect all regions (font strings created directly on the frame)
    local regions = { self.outputContent:GetRegions() }
    for _, region in ipairs(regions) do
        if region and region:IsObjectType("FontString") then
            tinsert(children, region)
        end
    end

    -- Remove all collected children/regions
    for _, child in ipairs(children) do
        if child then
            child:Hide()
            child:SetParent(nil)
            child:ClearAllPoints()
        end
    end

    -- Reset height and Y position
    self.outputContent:SetHeight(1000)
    self.lastOutputY = -5
end

--- Add text to output
--- @param text string Text to add
--- @param color string|nil Color code (default: white)
--- @param fontSize string|nil Font size (default: GameFontNormalSmall)
--- @return table The created font string
function NAGStringParserDiagnostics:AddOutputText(text, color, fontSize)
    color = color or "|cFFFFFFFF"
    fontSize = fontSize or "GameFontNormalSmall"

    local fontString = self.outputContent:CreateFontString(nil, "OVERLAY", fontSize)
    fontString:SetText(color .. text .. "|r")
    fontString:SetJustifyH("LEFT")
    fontString:SetJustifyV("TOP")

    -- Position based on last Y position
    local currentY = (self.lastOutputY or -5) - 5
    fontString:SetPoint("TOPLEFT", self.outputContent, "TOPLEFT", 5, currentY)
    fontString:SetWidth(self.outputContent:GetWidth() - 10)
    fontString:SetWordWrap(true)
    fontString:SetNonSpaceWrap(false)

    -- Update last Y position
    local height = fontString:GetStringHeight()
    self.lastOutputY = currentY - height

    -- Update content height dynamically
    local totalHeight = math.abs(self.lastOutputY) + 50
    if self.outputContent:GetHeight() < totalHeight then
        self.outputContent:SetHeight(totalHeight)
    end

    return fontString
end

--- Add section header
--- @param title string Section title
--- @param color string|nil Color code
function NAGStringParserDiagnostics:AddSectionHeader(title, color)
    color = color or "|cFFFFFF00"
    self:AddOutputText("=== " .. title .. " ===", color, "GameFontNormal")
end

--- Parse rotation string and update output
--- @param rotationString string The rotation string to parse
function NAGStringParserDiagnostics:ParseAndUpdate(rotationString)
    if not rotationString or rotationString == "" then
        self:ClearOutput()
        self:AddOutputText("Enter a rotation string to see parsing results", "|cFFFFAA00")
        return
    end

    if not self.outputContent then
        return
    end

    self:ClearOutput()

    -- Parse the string
    local conversionService = RotationConversionService or NAG:GetModule("RotationConversionService", true)
    if not conversionService then
        self:AddOutputText("Error: RotationConversionService not available", "|cFFFF0000")
        return
    end

    local startTime = debugprofilestop()
    local protoAST, diagnostics = conversionService:ParseToProtoAST(rotationString, {
        useCache = false,
        validate = false
    })
    local parseTime = debugprofilestop() - startTime

    self.lastParseResult = {
        ast = protoAST,
        diagnostics = diagnostics,
        parseTime = parseTime,
        inputLength = #rotationString
    }
    self.lastParseAST = protoAST
    self.lastParseError = diagnostics and diagnostics.errors and diagnostics.errors[1]
    self.lastParseTime = parseTime

    -- Render results
    self:RenderParseResults(protoAST, diagnostics, parseTime, #rotationString)
end

--- Render parse results
--- @param protoAST table|nil Parsed AST
--- @param diagnostics table|nil Parse diagnostics
--- @param parseTime number Parse time in milliseconds
--- @param inputLength number Input string length
function NAGStringParserDiagnostics:RenderParseResults(protoAST, diagnostics, parseTime, inputLength)
    if not self.outputContent then return end

    -- Status section
    self:AddSectionHeader("Parse Status")

    local statusColor = protoAST and "|cFF00FF00" or "|cFFFF0000"
    local statusText = protoAST and "✓ Parse Successful" or "✗ Parse Failed"
    self:AddOutputText(statusText, statusColor)

    local metricsText = format("Parse Time: %.2fms | Input Length: %d characters", parseTime, inputLength)
    if protoAST and protoAST.priority_list then
        metricsText = metricsText .. format(" | Clauses: %d", #protoAST.priority_list)
    end
    self:AddOutputText(metricsText, "|cFFFFFFFF")

    -- Error section (if any)
    if diagnostics and diagnostics.errors and #diagnostics.errors > 0 then
        self:AddSectionHeader("Errors", "|cFFFF0000")
        for _, errorMsg in ipairs(diagnostics.errors) do
            self:AddOutputText(errorMsg, "|cFFFF0000")
        end
    end

    -- Warnings section (if any)
    if diagnostics and diagnostics.warnings and #diagnostics.warnings > 0 then
        self:AddSectionHeader("Warnings", "|cFFFFAA00")
        for _, warningMsg in ipairs(diagnostics.warnings) do
            self:AddOutputText(warningMsg, "|cFFFFAA00")
        end
    end

    -- Proto AST output section
    self:AddSectionHeader("Proto AST Output", "|cFF00FFFF")

    if protoAST then
        -- Render AST tree
        local astText = self:FormatAST(protoAST)

        local lines = {}
        for line in astText:gmatch("[^\n]+") do
            tinsert(lines, line)
        end

        for _, line in ipairs(lines) do
            self:AddOutputText(line, nil, "GameFontNormalSmall")
        end

        -- Emitted string section
        self:AddSectionHeader("Emitted Rotation String", "|cFF00FF00")

        local emittedString = ASTSchemaEmitter.EmitRotationString(protoAST)
        if emittedString then
            local emitLines = {}
            for line in emittedString:gmatch("[^\n]+") do
                tinsert(emitLines, line)
            end

            for _, line in ipairs(emitLines) do
                self:AddOutputText(line, "|cFFAAAAAA", "GameFontNormalSmall")
            end
        else
            self:AddOutputText("Failed to emit rotation string", "|cFFFF0000")
        end
    else
        self:AddOutputText("No AST generated", "|cFFFFAA00")
    end

    -- Update scroll frame
    local contentHeight = 0
    local children = { self.outputContent:GetChildren() }
    for _, child in ipairs(children) do
        if child:IsShown() then
            local height = child.GetStringHeight and child:GetStringHeight() or child:GetHeight()
            contentHeight = contentHeight + height + 5
        end
    end
    self.outputContent:SetHeight(math.max(contentHeight + 50, 1000))
end

--- Format AST for display
--- @param ast table AST node
--- @param depth number Current depth
--- @return string Formatted AST string
function NAGStringParserDiagnostics:FormatAST(ast, depth)
    depth = depth or 0
    local indent = string.rep("  ", depth)
    local lines = {}

    if not ast then
        return indent .. "|cFFFF0000[nil]|r"
    end

    if ast.type == ASTCore.NodeType.ROTATION then
        tinsert(lines, indent .. "|cFF00FFFF[ROTATION]|r")

        if ast.priority_list then
            for i, listItem in ipairs(ast.priority_list) do
                tinsert(lines, indent .. "  |cFFFFFF00[Clause #" .. i .. "]|r")
                if listItem.action then
                    tinsert(lines, self:FormatAST(listItem.action, depth + 2))
                end
                if listItem.notes then
                    tinsert(lines, indent .. "    |cFFAAAAAANotes:|r " .. listItem.notes)
                end
            end
        end
    elseif ast.type == ASTCore.NodeType.ACTION then
        local actionText = ASTSchemaEmitter.EmitActionNode(ast)
        tinsert(lines, indent .. "|cFF00FF00[ACTION]|r " .. (actionText or "|cFFFF0000[EMIT FAILED]|r"))

        if ast.condition then
            local conditionText = ASTSchemaEmitter.EmitValueNode(ast.condition)
            if conditionText then
                tinsert(lines, indent .. "  |cFFFFAA00Condition:|r " .. conditionText)
            end
        end
    elseif ast.type == ASTCore.NodeType.VALUE then
        local valueText = ASTSchemaEmitter.EmitValueNode(ast)
        tinsert(lines, indent .. "|cFF00AAFF[VALUE]|r " .. (valueText or "|cFFFF0000[EMIT FAILED]|r"))
    else
        tinsert(lines, indent .. "|cFFFF0000[UNKNOWN TYPE: " .. tostring(ast.type) .. "]|r")
    end

    return tconcat(lines, "\n")
end
