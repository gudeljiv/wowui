--- @module "BasicRotationStringEditor"
--- Basic rotation string editor with enhanced features
--- License: CC BY-NC 4.0
--- Authors: Rakizi, Fonsas

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- Localizations
local AceGUI = ns.AceGUI
local L = ns.AceLocale:GetLocale("NAG", true)
local WoWAPI = ns.WoWAPI
local SchemaUtils = ns.SchemaUtils
local StringUtil = ns.StringUtil
local AceConfigRegistry = ns.AceConfigRegistry
local Version = ns.Version

-- GroupsVariablesEditor module (loaded via modules.xml)

-- Lua APIs
local format = string.format
local tinsert = tinsert
local tostring = tostring
local tonumber = tonumber
local type = type
local time = time
local sort = table.sort
local C_Timer = C_Timer
local strtrim = strtrim

-- ~~~~~~~~~~ MODULE DEFINITION ~~~~~~~~~~

local BasicRotationStringEditor = {}
-- Preserve sub-modules if they exist (GroupsVariablesEditor loads first)
local existingSubModules = ns.BasicRotationStringEditor
ns.BasicRotationStringEditor = BasicRotationStringEditor
-- Restore sub-modules if they existed
if existingSubModules then
    for k, v in pairs(existingSubModules) do
        if not BasicRotationStringEditor[k] then
            ns.BasicRotationStringEditor[k] = v
        end
    end
end

-- ~~~~~~~~~~ UTILITY FUNCTIONS ~~~~~~~~~~

--- Normalize rotation string by removing export wrapper if present
--- @param rotationString string The rotation string
--- @return string normalized The normalized string
--- @return boolean sanitized True if wrapper was removed
local function NormalizeRotationStringPayload(rotationString)
    if not rotationString or rotationString == "" then
        return rotationString, false
    end

    local openStart, openEnd = rotationString:find("%[%[")
    local closeStart, closeEnd = rotationString:find("%]%]")
    if openStart and openEnd and closeStart and closeEnd and closeStart > openEnd then
        local payload = rotationString:sub(openEnd + 1, closeStart - 1)
        payload = (payload:match("^%s*(.-)%s*$")) or payload
        return payload, true
    end

    return rotationString, false
end

--- Extract spells from rotation string
--- @param rotationString string The rotation string
--- @return table Array of spell entries
local function ExtractSpellsFromRotation(rotationString)
    if not rotationString or rotationString == "" then
        return {}
    end

    local SchemaAccessor = NAG:GetModule("SchemaAccessor")
    if not SchemaAccessor then
        return {}
    end

    local spells = {}
    local seenIDs = {}

    -- Pattern to match NAG action functions with spell IDs
    local actionPattern = "NAG:(%w+)%(([^%)]+)%)"

    for actionName, args in rotationString:gmatch(actionPattern) do
        -- Use SchemaUtils for proper acronym handling (GCD, DRW, etc.)
        local snakeIdentifier = SchemaUtils and SchemaUtils:CamelToSnake(actionName) or actionName:lower()
        local isAction = false

        if SchemaAccessor.GetMetadataByIdentifier and snakeIdentifier:match("^[a-z][a-z0-9_]*$") then
            local metadata = SchemaAccessor:GetMetadataByIdentifier(snakeIdentifier, nil)
            if metadata then
                isAction = true
            end
        end

        if not isAction and SchemaAccessor.nagFunctionMappings then
            local protoName = SchemaAccessor.nagFunctionMappings[actionName]
            if not protoName and snakeIdentifier:match("^[a-z][a-z0-9_]*$") then
                local pascalCase = snakeIdentifier:gsub("^%l", function(c) return c:upper() end)
                protoName = SchemaAccessor.nagFunctionMappings[pascalCase]
            end
            if protoName and protoName:match("^APLAction") then
                isAction = true
            end
        end

        if isAction then
            for spellIDStr in args:gmatch("(%d+)") do
                local spellID = tonumber(spellIDStr)
                if spellID and not seenIDs[spellID] then
                    seenIDs[spellID] = true

                    local spellInfo = WoWAPI.GetSpellInfo(spellID)
                    if spellInfo and spellInfo.name then
                        local spellName = spellInfo.name
                        local iconID = spellInfo.iconID or spellInfo.icon

                        local displayText
                        if iconID and type(iconID) == "number" then
                            displayText = format("|T%d:20:20|t %s (%d)", iconID, spellName, spellID)
                        elseif iconID and type(iconID) == "string" then
                            displayText = format("|T%s:20:20|t %s (%d)", iconID, spellName, spellID)
                        else
                            displayText = format("%s (%d)", spellName, spellID)
                        end

                        tinsert(spells, {
                            name = spellName,
                            value = spellID,
                            type = "spell",
                            displayText = displayText
                        })
                    else
                        tinsert(spells, {
                            name = "Spell ID: " .. spellID,
                            value = spellID,
                            type = "spell",
                            displayText = format("Spell ID: %d", spellID)
                        })
                    end
                end
            end
        end
    end

    sort(spells, function(a, b)
        return (a.name or "") < (b.name or "")
    end)

    return spells
end

--- Find all positions where a spell ID appears in action clauses
--- @param rotationString string The rotation string
--- @param spellID number The spell ID to find
--- @return table Array of {startPos, endPos} for each match
local function FindSpellIDInActions(rotationString, spellID)
    if not rotationString or not spellID then
        return {}
    end

    local matches = {}
    local searchPattern = tostring(spellID)
    local actionPattern = "(NAG:%w+%([^%)]+%))"

    local pos = 1
    while pos <= #rotationString do
        local actionStart, actionEnd, actionText = rotationString:find(actionPattern, pos)
        if not actionStart then
            break
        end

        local idPattern = "(%D)" .. searchPattern .. "(%D)"
        local idPatternStart = "^" .. searchPattern .. "(%D)"
        local idPatternEnd = "(%D)" .. searchPattern .. "$"
        local idPatternAlone = "^" .. searchPattern .. "$"

        if actionText:match(idPattern) or actionText:match(idPatternStart) or
           actionText:match(idPatternEnd) or actionText:match(idPatternAlone) then
            local idStart = actionText:find(searchPattern, 1, true)
            if idStart then
                local absoluteStart = actionStart + idStart - 1
                local absoluteEnd = absoluteStart + #searchPattern - 1

                tinsert(matches, {
                    startPos = absoluteStart,
                    endPos = absoluteEnd
                })
            end
        end

        pos = actionEnd + 1
    end

    return matches
end

--- Highlight a match in the editbox
--- @param editbox table AceGUI MultiLineEditBox widget
--- @param match table {startPos, endPos} match position
local function HighlightMatch(editbox, match)
    if not match or not editbox then
        return
    end

    editbox:SetFocus()

    local startPos0 = match.startPos - 1
    local endPos0 = match.endPos

    editbox.editBox:SetCursorPosition(startPos0)
    editbox:HighlightText(startPos0, endPos0)
end

--- Split rotation string into clauses by 'or' keyword
--- @param rotationString string The rotation string
--- @return table Array of {text, startLine, endLine, startPos, endPos}
local function SplitRotationIntoClauses(rotationString)
    if not rotationString or rotationString == "" then
        return {}
    end

    local normalized, sanitized = NormalizeRotationStringPayload(rotationString)
    if sanitized then
        rotationString = normalized
    end

    local clauses = {}
    local lines = {}

    for line in rotationString:gmatch("[^\n]+") do
        tinsert(lines, line)
    end

    local currentClause = {}
    local clauseStartLine = 1
    local clauseStartPos = 1
    local currentPos = 1
    local parenDepth = 0

    for lineNum, line in ipairs(lines) do
        local trimmed = line:match("^%s*(.-)%s*$")
        local startsWithOrAtDepth0 = false
        if parenDepth == 0 and trimmed:match("^or%s+") and #currentClause > 0 then
            startsWithOrAtDepth0 = true
        end

        if startsWithOrAtDepth0 then
            local clauseText = table.concat(currentClause, "\n")
            local clauseEndPos = currentPos - 1

            tinsert(clauses, {
                text = clauseText,
                startLine = clauseStartLine,
                endLine = lineNum - 1,
                startPos = clauseStartPos,
                endPos = clauseEndPos
            })

            currentClause = {line}
            clauseStartLine = lineNum
            clauseStartPos = currentPos
        else
            tinsert(currentClause, line)
        end

        for i = 1, #line do
            local char = line:sub(i, i)
            if char == "(" then
                parenDepth = parenDepth + 1
            elseif char == ")" then
                parenDepth = parenDepth - 1
            end
        end

        currentPos = currentPos + #line + 1
    end

    if #currentClause > 0 then
        local clauseText = table.concat(currentClause, "\n")
        tinsert(clauses, {
            text = clauseText,
            startLine = clauseStartLine,
            endLine = #lines,
            startPos = clauseStartPos,
            endPos = #rotationString
        })
    end

    return clauses
end

--- Validate a single clause
--- @param clauseText string The clause text to validate
--- @param clauseIdx number The clause index
--- @return boolean success True if valid
--- @return string|nil error Error message if invalid
local function ValidateClause(clauseText, clauseIdx)
    local trimmed = clauseText:match("^%s*(.-)%s*$")
    if trimmed == "" then
        return true, nil
    end

    local parenCount = 0
    for i = 1, #trimmed do
        local char = trimmed:sub(i, i)
        if char == "(" then
            parenCount = parenCount + 1
        elseif char == ")" then
            parenCount = parenCount - 1
        end
    end
    if parenCount ~= 0 then
        return false, format("Unbalanced parentheses (diff: %d)", parenCount)
    end

    local cleanedClause = trimmed:gsub("^or%s+", "")
    local normalizedClause, wrapped = NormalizeRotationStringPayload(cleanedClause)
    if wrapped then
        cleanedClause = normalizedClause
    end

    -- Fast guard: disallow whitespace inside NAG function identifiers
    -- Examples: "NAG: Aura(", "NAG:Is Active(" should be rejected
    local function findInvalidNagIdentifier(clause)
        for namePart in clause:gmatch("NAG:([^%(]+)%(") do
            if namePart:match("%s") then
                return namePart
            end
        end
        return nil
    end

    local badName = findInvalidNagIdentifier(cleanedClause)
    if badName then
        return false, format("Invalid NAG function name (whitespace in identifier): '%s'", badName)
    end

    local conversionService = NAG:GetModule("RotationConversionService", true)
    local ast, diagnostics = conversionService:ParseToProtoAST(cleanedClause, {
        useCache = true,
        validate = false, -- structural parse only; enum validation can’t resolve NAG.Types.* constants
    })

    if not ast then
        local err = (diagnostics and diagnostics.errors and diagnostics.errors[1]) or "Unknown parse error"
        return false, err
    end

    local ASTCore = ns.ASTCore
    local ASTAction = ns.ASTAction

    if ast.priority_list and #ast.priority_list > 0 then
        local listItem = ast.priority_list[1]
        if listItem and listItem.action then
            local actionNode = listItem.action

            if actionNode.type ~= ASTCore.NodeType.ACTION then
                return false, "Invalid action node type"
            end

            local actionType = ASTAction.GetActionType(actionNode)
            if not actionType or actionType == "" then
                local ASTSchemaEmitter = ns.ASTSchemaEmitter
                local actionText = ASTSchemaEmitter and ASTSchemaEmitter.EmitActionNode(actionNode) or "unknown"

                if actionText:match("NAG:%w+%([^%)]*$") then
                    return false, "Incomplete NAG function call: " .. actionText .. " | Fix: Add closing ')'"
                end

                return false, "Invalid action node structure"
            end
        end
    end

    return true, nil
end

--- Copy table utility
--- @param src table Source table
--- @return table Copied table
local function CopyTable(src)
    if type(src) ~= "table" then
        return src
    end
    local dest = {}
    for k, v in pairs(src) do
        dest[k] = (type(v) == "table") and CopyTable(v) or v
    end
    return dest
end

-- ~~~~~~~~~~ MAIN EDITOR FUNCTION ~~~~~~~~~~

--- Show the basic rotation string editor
--- @param specIndex number The specialization index (1,2,3)
--- @param rotation table The rotation data
--- @param classModule ClassBase The class module
function BasicRotationStringEditor:ShowEditor(specIndex, rotation, classModule)
    local RotationManager = NAG:GetModule("RotationManager")
    if not RotationManager then
        NAG:Error("RotationManager module not available")
        return
    end

    -- Get GroupsVariablesEditor module
    local GroupsVariablesEditor = ns.BasicRotationStringEditor and ns.BasicRotationStringEditor.GroupsVariablesEditor

    -- Create editor state
    local editorState = {
        specIndex = specIndex,
        rotation = rotation,
        classModule = classModule,
        workingConfig = CopyTable(rotation.config),
        RotationManager = RotationManager
    }

    -- Ensure groups, variables, and prePull arrays exist
    if not editorState.workingConfig.groups then
        editorState.workingConfig.groups = {}
    end
    if not editorState.workingConfig.variables then
        editorState.workingConfig.variables = {}
    end
    if not editorState.workingConfig.prePull then
        editorState.workingConfig.prePull = {}
    end

    -- Create editor frame
    local frame = AceGUI:Create("Frame")
    frame:SetTitle((L["editRotation"] or "Edit Rotation") .. ": " .. rotation.name)
    frame:SetLayout("List")
    frame:SetCallback("OnClose", function(widget)
        AceGUI:Release(widget)
    end)
    frame:SetWidth(1200)
    frame:SetHeight(800)

    -- Store editorState in frame.userdata
    if not frame.userdata then
        frame.userdata = {}
    end
    frame.userdata.editorState = editorState

    -- ============================ BUTTON BAR ============================

    local buttonBar = AceGUI:Create("SimpleGroup")
    buttonBar:SetLayout("Flow")
    buttonBar:SetFullWidth(true)
    frame:AddChild(buttonBar)

    local validateBtn = AceGUI:Create("Button")
    validateBtn:SetText(L["validate"] or "Validate")
    validateBtn:SetWidth(100)
    buttonBar:AddChild(validateBtn)

    local saveBtn = AceGUI:Create("Button")
    saveBtn:SetText(L["save"] or "Save")
    saveBtn:SetWidth(100)
    buttonBar:AddChild(saveBtn)

    local cancelBtn = AceGUI:Create("Button")
    cancelBtn:SetText(L["cancel"] or "Cancel")
    cancelBtn:SetWidth(100)
    buttonBar:AddChild(cancelBtn)

    -- APL validation toggle (devmode only)
    -- Check if we're in TBC or Wrath - validation is disabled for these expansions
    local isTBC = Version:IsTBC()
    local isWrath = Version:IsWrath()
    local validationDisabledByExpansion = isTBC or isWrath
    local validationToggle = nil
    if NAG:IsDevModeEnabled() or validationDisabledByExpansion then
        local SchemaValidator = NAG:GetModule("SchemaValidator", true)
        validationToggle = AceGUI:Create("CheckBox")
        validationToggle:SetLabel("Disable APL Validation")
        validationToggle:SetWidth(200)
        -- In TBC/Wrath, validation is disabled by default
        local defaultDisabled = validationDisabledByExpansion or (SchemaValidator and SchemaValidator:IsValidationDisabled() or false)
        validationToggle:SetValue(defaultDisabled)
        if validationDisabledByExpansion and SchemaValidator then
            SchemaValidator:SetSetting("char", "disableValidation", true)
        end
        validationToggle:SetCallback("OnValueChanged", function(_, _, value)
            if SchemaValidator then
                SchemaValidator:SetSetting("char", "disableValidation", value)
                if value then
                    local prefix = validationDisabledByExpansion and (isTBC and "[TBC]" or "[Wrath]") or "[DevMode]"
                    NAG:Print(format("|cffff8000%s APL validation disabled for this session|r", prefix))
                else
                    local prefix = validationDisabledByExpansion and (isTBC and "[TBC]" or "[Wrath]") or "[DevMode]"
                    NAG:Print(format("|cff00ff00%s APL validation enabled|r", prefix))
                end
            end
        end)
        buttonBar:AddChild(validationToggle)
    end

    -- ============================ TAB GROUP ============================

    local tabGroup = AceGUI:Create("TabGroup")
    tabGroup:SetLayout("Fill")
    tabGroup:SetFullWidth(true)
    tabGroup:SetFullHeight(true)

    -- Load sub-modules
    local GroupsVariablesEditor = ns.BasicRotationStringEditor and ns.BasicRotationStringEditor.GroupsVariablesEditor
    local BasicPrePullEditor = ns.BasicRotationStringEditor and ns.BasicRotationStringEditor.BasicPrePullEditor

    tabGroup:SetTabs({
        {text = L["rotationString"] or "Rotation String", value = "rotation"},
        {text = L["groupsVariables"] or "Groups & Variables", value = "groupsvariables"},
        {text = L["prePull"] or "PrePull", value = "prepull"}
    })
    tabGroup:SetCallback("OnGroupSelected", function(container, event, group)
        container:ReleaseChildren()

        if group == "rotation" then
            self:RenderRotationStringTab(container, editorState, buttonBar, validationToggle, validationDisabledByExpansion, isTBC and "[TBC]" or "[Wrath]")
        elseif group == "groupsvariables" then
            if GroupsVariablesEditor then
                GroupsVariablesEditor:RenderGroupsVariablesTab(container, editorState)
            else
                local errorLabel = AceGUI:Create("Label")
                errorLabel:SetText("|cFFFF0000GroupsVariablesEditor module not available|r")
                errorLabel:SetFullWidth(true)
                container:AddChild(errorLabel)
            end
        elseif group == "prepull" then
            if BasicPrePullEditor then
                BasicPrePullEditor:RenderPrePullTab(container, editorState)
            else
                local errorLabel = AceGUI:Create("Label")
                errorLabel:SetText("|cFFFF0000BasicPrePullEditor module not available|r")
                errorLabel:SetFullWidth(true)
                container:AddChild(errorLabel)
            end
        end
    end)
    tabGroup:SelectTab("rotation")
    frame:AddChild(tabGroup)

    -- Set up button callbacks after frame is created
    self:SetupButtonCallbacks(frame, editorState, buttonBar)
end

-- ~~~~~~~~~~ TAB RENDERERS ~~~~~~~~~~

--- Render the Rotation String tab
--- @param container table AceGUI container
--- @param editorState table Editor state
--- @param buttonBar table Button bar widget
--- @param validationToggle table Validation toggle widget
--- @param validationDisabledByExpansion boolean Whether validation is disabled for this expansion (TBC/Wrath)
--- @param validationExpansionPrefix string Prefix for expansion-specific messages ("[TBC]" or "[Wrath]")
function BasicRotationStringEditor:RenderRotationStringTab(container, editorState, buttonBar, validationToggle, validationDisabledByExpansion, validationExpansionPrefix)
    container:SetLayout("List")

    local rotation = editorState.rotation

    -- ============================ SPELL SEARCH UI ============================

    local searchState = {
        currentSpellID = nil,
        matches = {},
        currentMatchIndex = 0
    }

    local searchGroup = AceGUI:Create("SimpleGroup")
    searchGroup:SetLayout("Flow")
    searchGroup:SetFullWidth(true)
    container:AddChild(searchGroup)

    local searchLabel = AceGUI:Create("Label")
    searchLabel:SetText("Find Spell:")
    searchLabel:SetWidth(70)
    searchGroup:AddChild(searchLabel)

    -- Spell search widget (will be populated after editbox creation)
    local spellSearch = nil
    local matchCounter = nil

    -- ============================ EDITOR ============================

    local editorGroup = AceGUI:Create("InlineGroup")
    editorGroup:SetTitle(rotation.name)
    editorGroup:SetLayout("List")
    editorGroup:SetFullWidth(true)
    container:AddChild(editorGroup)

    -- Normalize rotation string (remove export wrapper if present)
    local rotationText = editorState.workingConfig.rotationString or ""
    local normalizedRotationText, sanitizedRotation = NormalizeRotationStringPayload(rotationText)
    if sanitizedRotation then
        rotationText = normalizedRotationText
    end

    local editbox = AceGUI:Create("MultiLineEditBox")
    editbox:SetLabel(L["rotationString"] or "Rotation String")
    editbox:SetText(rotationText)
    editbox:SetFullWidth(true)
    -- CRITICAL: Don't use SetFullHeight with MultiLineEditBox - it has its own internal scrolling
    -- and calculates height based on SetNumLines(). Using SetFullHeight conflicts with internal sizing.
    editbox:DisableButton(true)
    editbox:SetNumLines(25)

    -- Store editbox in editorState for save handler
    editorState.rotationStringEditbox = editbox

    -- Enable syntax highlighting
    local SyntaxHL = ns.RotationEditorSyntaxHighlighting
    if SyntaxHL and editbox.editBox then
        SyntaxHL.EnableAPLSyntaxHighlighting(editbox.editBox, 4, {
            preserveExistingIndent = true
        })
    elseif editbox.editBox then
        editbox.editBox:SetMaxLetters(0)
        editbox.editBox:SetMaxBytes(0)
    end

    editorGroup:AddChild(editbox)

    -- ============================ ERROR CONSOLE ============================

    local errorState = {
        enabled = true,
        errorClauses = {},
        errorPanel = nil
    }

    local errorPanel = AceGUI:Create("SimpleGroup")
    errorPanel:SetLayout("List")
    errorPanel:SetFullWidth(true)
    container:AddChild(errorPanel)
    errorState.errorPanel = errorPanel

    local function CreateErrorHighlights(editboxWidget, errorClauses)
        if not errorState.errorPanel then
            return
        end

        errorState.errorPanel:ReleaseChildren()

        if not errorClauses or #errorClauses == 0 then
            return
        end

        local headerLabel = AceGUI:Create("Label")
        headerLabel:SetText(format("|cFFFF4444⚠ %d Validation Error(s)|r", #errorClauses))
        headerLabel:SetFullWidth(true)
        headerLabel:SetFontObject(GameFontNormalLarge)
        errorState.errorPanel:AddChild(headerLabel)

        for _, errClause in ipairs(errorClauses) do
            local errorGroup = AceGUI:Create("InlineGroup")
            errorGroup:SetTitle(format("Clause %d", errClause.clauseNum))
            errorGroup:SetLayout("List")
            errorGroup:SetFullWidth(true)
            errorState.errorPanel:AddChild(errorGroup)

            local errorLabel = AceGUI:Create("Label")
            errorLabel:SetText(format("|cFFFF6666Error:|r %s", errClause.error))
            errorLabel:SetFullWidth(true)
            errorGroup:AddChild(errorLabel)

            local locationLabel = AceGUI:Create("Label")
            locationLabel:SetText(format("|cFF888888Lines %d-%d|r", errClause.startLine, errClause.endLine))
            locationLabel:SetFullWidth(true)
            errorGroup:AddChild(locationLabel)

            local previewText = errClause.text:sub(1, 150):gsub("\n", " ")
            if errClause.text:len() > 150 then
                previewText = previewText .. "..."
            end
            local previewLabel = AceGUI:Create("Label")
            previewLabel:SetText(format("|cFF666666Preview:|r %s", previewText))
            previewLabel:SetFullWidth(true)
            errorGroup:AddChild(previewLabel)
        end
    end

    local function ValidateAndHighlight()
        if not errorState.enabled then
            return
        end
        -- Skip validation if expansion lacks schema support or validation is disabled
        local skipValidation = validationDisabledByExpansion or (validationToggle and validationToggle:GetValue())
        if skipValidation then
            return
        end

        local text = editbox:GetText()
        local clauses = SplitRotationIntoClauses(text)

        local errorClauses = {}
        for i, clause in ipairs(clauses) do
            local valid, err = ValidateClause(clause.text, i)
            if not valid then
                tinsert(errorClauses, {
                    clauseNum = i,
                    startLine = clause.startLine,
                    endLine = clause.endLine,
                    startPos = clause.startPos,
                    endPos = clause.endPos,
                    error = err,
                    text = clause.text
                })
            end
        end

        errorState.errorClauses = errorClauses
        CreateErrorHighlights(editbox, errorClauses)
    end

    -- ============================ SPELL SEARCH SETUP ============================

    local spellList = ExtractSpellsFromRotation(rotationText)
    spellSearch = AceGUI:Create("NAG_SpellAutocomplete")
    spellSearch:SetWidth(200)
    spellSearch:SetLabel("")
    spellSearch:SetSpells(spellList)
    searchGroup:AddChild(spellSearch)

    matchCounter = AceGUI:Create("Label")
    matchCounter:SetText("")
    matchCounter:SetWidth(120)
    searchGroup:AddChild(matchCounter)

    local function UpdateMatchCounter()
        if #searchState.matches == 0 then
            if searchState.currentSpellID then
                matchCounter:SetText("|cFFFF8800No matches|r")
            else
                matchCounter:SetText("")
            end
        else
            matchCounter:SetText(format("|cFF00FF00Match %d of %d|r",
                searchState.currentMatchIndex, #searchState.matches))
        end
    end

    spellSearch:SetCallback(function(spellID)
        searchState.currentSpellID = spellID
        searchState.matches = FindSpellIDInActions(editbox:GetText(), spellID)
        searchState.currentMatchIndex = #searchState.matches > 0 and 1 or 0

        if #searchState.matches > 0 then
            HighlightMatch(editbox, searchState.matches[1])
        end

        UpdateMatchCounter()
    end)

    local prevButton = AceGUI:Create("Button")
    prevButton:SetText("< Prev")
    prevButton:SetWidth(80)
    prevButton:SetCallback("OnClick", function()
        if #searchState.matches == 0 then return end

        searchState.currentMatchIndex = searchState.currentMatchIndex - 1
        if searchState.currentMatchIndex < 1 then
            searchState.currentMatchIndex = #searchState.matches
        end

        HighlightMatch(editbox, searchState.matches[searchState.currentMatchIndex])
        UpdateMatchCounter()
    end)
    searchGroup:AddChild(prevButton)

    local nextButton = AceGUI:Create("Button")
    nextButton:SetText("Next >")
    nextButton:SetWidth(80)
    nextButton:SetCallback("OnClick", function()
        if #searchState.matches == 0 then return end

        searchState.currentMatchIndex = searchState.currentMatchIndex + 1
        if searchState.currentMatchIndex > #searchState.matches then
            searchState.currentMatchIndex = 1
        end

        HighlightMatch(editbox, searchState.matches[searchState.currentMatchIndex])
        UpdateMatchCounter()
    end)
    searchGroup:AddChild(nextButton)

    -- Store navigation buttons
    editorState.prevButton = prevButton
    editorState.nextButton = nextButton

    -- ============================ FORMAT BUTTON ============================

    local buttonGroup = AceGUI:Create("SimpleGroup")
    buttonGroup:SetLayout("Flow")
    buttonGroup:SetFullWidth(true)
    container:AddChild(buttonGroup)

    local formatButton = AceGUI:Create("Button")
    formatButton:SetText(L["formatRotationString"] or "Format")
    formatButton:SetWidth(120)
    formatButton:SetCallback("OnClick", function()
        local rotationString = editbox:GetText()
        if not rotationString or rotationString == "" then
            NAG:Print("|cFFFF8800No rotation string to format|r")
            return
        end

        -- Parse to protoAST first
        local conversionService = NAG:GetModule("RotationConversionService", true)
        if conversionService then
            local protoAST, diagnostics = conversionService:ParseToProtoAST(rotationString, {
                useCache = true,
                validate = false
            })

            if protoAST then
                -- Emit formatted rotationString from protoAST
                local ASTSchemaEmitter = ns.ASTSchemaEmitter
                if ASTSchemaEmitter then
                    local formatted, err = ASTSchemaEmitter.EmitRotationString(protoAST, {
                        format = true
                    })

                    if formatted then
                        editbox:SetText(formatted)
                        editbox:SetFocus()
                        editbox:ClearFocus()
                        NAG:Print("|cFF00FF00Rotation string formatted successfully!|r")
                    else
                        NAG:Print("|cFFFF0000Format failed: " .. tostring(err) .. "|r")
                    end
                else
                    -- Fallback to LuaFormatter
                    local LuaFormatter = ns.LuaFormatter
                    if LuaFormatter then
                        local formatted, err = LuaFormatter.FormatRotationString(rotationString)
                        if formatted then
                            editbox:SetText(formatted)
                            editbox:SetFocus()
                            editbox:ClearFocus()
                            NAG:Print("|cFF00FF00Rotation string formatted successfully!|r")
                        else
                            NAG:Print("|cFFFF0000Format failed: " .. tostring(err) .. "|r")
                        end
                    else
                        NAG:Print("|cFFFF0000LuaFormatter not available|r")
                    end
                end
            else
                local parseErr = (diagnostics and diagnostics.errors and diagnostics.errors[1]) or "unknown error"
                NAG:Print("|cFFFF0000Failed to parse rotation string: " .. tostring(parseErr) .. "|r")
            end
        end
    end)
    buttonGroup:AddChild(formatButton)

    -- Live validation toggle
    local liveValidationToggle = AceGUI:Create("CheckBox")
    liveValidationToggle:SetLabel(L["liveValidation"] or "Live Validation")
    liveValidationToggle:SetValue(errorState.enabled)
    liveValidationToggle:SetWidth(150)
    liveValidationToggle:SetCallback("OnValueChanged", function(widget, event, value)
        errorState.enabled = value
        if value then
            ValidateAndHighlight()
        else
            if errorState.errorPanel then
                errorState.errorPanel:ReleaseChildren()
            end
            errorState.errorClauses = {}
        end
    end)
    buttonGroup:AddChild(liveValidationToggle)

    -- Character/line count
    local text = rotationText
    local charCount = #text
    local lineCount = 1
    for _ in text:gmatch("\n") do
        lineCount = lineCount + 1
    end

    local infoLabel = AceGUI:Create("Label")
    infoLabel:SetText(format("|cFF888888Characters: %d | Lines: %d|r", charCount, lineCount))
    infoLabel:SetFullWidth(true)
    container:AddChild(infoLabel)

    -- ============================ APL AUTOCOMPLETE ============================

    local SchemaAccessor = NAG:GetModule("SchemaAccessor")
    local APLAutocomplete = ns.APLAutocomplete
    if APLAutocomplete and SchemaAccessor then
        local actionsData = SchemaAccessor:GetAutocompleteData("Actions")
        local valuesData = SchemaAccessor:GetAutocompleteData("Values")

        local combinedData = {}
        if actionsData then
            for _, entry in ipairs(actionsData) do
                tinsert(combinedData, entry)
            end
        end
        if valuesData then
            for _, entry in ipairs(valuesData) do
                tinsert(combinedData, entry)
            end
        end

        if #combinedData > 0 then
            APLAutocomplete:AddToEditBox(editbox, combinedData, "Actions & Values", function(entry, widget)
                local text = widget:GetText() or ""
                local cursorPos = widget.editBox:GetCursorPosition()
                local beforeCursor = text:sub(1, cursorPos)
                local afterCursor = text:sub(cursorPos + 1)

                local newBefore = beforeCursor:gsub("[%w_:]+$", entry.name)
                widget:SetText(newBefore .. afterCursor)
                widget.editBox:SetCursorPosition(#newBefore)
            end)
        end
    end

    -- ============================ VALIDATION TIMER ============================

    local validationTimer = nil

    editbox:SetCallback("OnTextChanged", function(widget, event, text)
        -- Update workingConfig
        editorState.workingConfig.rotationString = text

        -- Refresh search if active
        if searchState.currentSpellID and spellSearch then
            local spellList = ExtractSpellsFromRotation(text)
            spellSearch:SetSpells(spellList)
            searchState.matches = FindSpellIDInActions(text, searchState.currentSpellID)
            if editorState.UpdateMatchCounter then
                editorState.UpdateMatchCounter()
            end
        end

        -- Cancel pending validation
        if validationTimer then
            validationTimer:Cancel()
            validationTimer = nil
        end

        -- Schedule validation after 1 second of no typing
        validationTimer = C_Timer.NewTimer(1, function()
            ValidateAndHighlight()
            validationTimer = nil
        end)
    end)


    -- Store errorState and searchState in editorState for button callbacks
    editorState.errorState = errorState
    editorState.searchState = searchState
    editorState.spellSearch = spellSearch
    editorState.matchCounter = matchCounter
    editorState.validationToggle = validationToggle
    editorState.validationDisabledByExpansion = validationDisabledByExpansion
    editorState.validationExpansionPrefix = validationExpansionPrefix or "[Wrath]"
    editorState.UpdateMatchCounter = UpdateMatchCounter

    editbox:SetFocus()
end

-- ~~~~~~~~~~ BUTTON CALLBACKS SETUP ~~~~~~~~~~

--- Set up button callbacks for the editor
--- @param frame table AceGUI Frame
--- @param editorState table Editor state
--- @param buttonBar table Button bar
function BasicRotationStringEditor:SetupButtonCallbacks(frame, editorState, buttonBar)
    local validateBtn = buttonBar.children[1]
    local saveBtn = buttonBar.children[2]
    local cancelBtn = buttonBar.children[3]

    local rotation = editorState.rotation
    local specIndex = editorState.specIndex
    local classModule = editorState.classModule
    local RotationManager = editorState.RotationManager
    local validationDisabledByExpansion = editorState.validationDisabledByExpansion
    local validationToggle = editorState.validationToggle

    validateBtn:SetCallback("OnClick", function()
        local editbox = editorState.rotationStringEditbox
        if not editbox then return end

        local value = editbox:GetText()
        if not value or strtrim(value) == "" then
            NAG:Error("Invalid rotation string")
            return
        end

        local skipValidation = validationDisabledByExpansion or (validationToggle and validationToggle:GetValue())
        if skipValidation then
            local prefix = validationDisabledByExpansion and (editorState.validationExpansionPrefix or "[Wrath]") or "[DevMode]"
            NAG:Print(format("|cffff8000%s APL validation is disabled|r", prefix))
            return
        end

        local tempConfig = CopyTable(editorState.workingConfig)
        tempConfig.rotationString = value
        local valid, err = RotationManager:ValidateRotation(tempConfig, true)
        if not valid then
            NAG:Error("Invalid rotation configuration: " .. tostring(err))
        else
            NAG:Print("Rotation configuration is valid")
        end
    end)

    saveBtn:SetCallback("OnClick", function()
        local editbox = editorState.rotationStringEditbox
        if not editbox then return end

        local value = editbox:GetText()
        if not value or strtrim(value) == "" then
            NAG:Error("Invalid rotation string")
            return
        end

        -- Update workingConfig with all changes
        local newConfig = CopyTable(editorState.workingConfig)
        newConfig.rotationString = value
        newConfig._lastEditSource = "rotationString"
        newConfig.lastModified = time()
        newConfig.lastModifiedBy = StringUtil.GetBattleTagName(StringUtil.GetBattleTag())
        newConfig.userModified = true

        -- Groups, variables, and prePull are already in workingConfig, so they'll be saved automatically

        -- Invalidate cache before validation since rotationString has changed
        RotationManager:InvalidateRotation(specIndex, rotation.name)

        local skipValidation = validationDisabledByExpansion or (validationToggle and validationToggle:GetValue())
        if not skipValidation then
            local valid, err = RotationManager:ValidateRotation(newConfig, true)
            if not valid then
                NAG:Error("Invalid rotation configuration: " .. tostring(err))
                return
            end
        else
            local prefix = validationDisabledByExpansion and (editorState.validationExpansionPrefix or "[Wrath]") or "[DevMode]"
            NAG:Print(format("|cffff8000%s Skipping validation as requested|r", prefix))
        end

        local func, err = RotationManager:CompileRotation(value)
        if not func then
            NAG:Error("Failed to compile rotation: " .. tostring(err))
            return
        end

        -- Regenerate aplProto from updated rotationString
        local conversionService = NAG:GetModule("RotationConversionService", true)
        if conversionService then
            local protoAST, diagnostics = conversionService:ParseToProtoAST(value, {
                useCache = true,
                validate = false
            })

            if protoAST then
                newConfig.aplProto = protoAST
            else
                local parseErr = (diagnostics and diagnostics.errors and diagnostics.errors[1]) or "unknown error"
                NAG:Warn("Failed to regenerate aplProto: " .. tostring(parseErr))
            end
        end

        local success = classModule:SaveRotation(specIndex, rotation.name, newConfig)
        if success then
            RotationManager:InvalidateRotation(specIndex, rotation.name)
            local cacheSuccess, cacheErr = RotationManager:SetActiveRotation(specIndex, rotation.name)
            if not cacheSuccess then
                NAG:Error("Failed to activate rotation: " .. tostring(cacheErr))
                return
            end

            AceConfigRegistry:NotifyChange("NAG")
            RotationManager:RefreshRotationList()
            NAG:Print("Rotation updated successfully")
            frame:Hide()
        end
    end)

    cancelBtn:SetCallback("OnClick", function()
        frame:Hide()
    end)
end

return BasicRotationStringEditor

