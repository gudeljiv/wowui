--- @module "RotationEditor"
--- Utility module for rendering tabbed rotation editor UI
--- Provides comprehensive editing interface for all rotation properties
--- License: CC BY-NC 4.0
--- Authors: Rakizi, Fonsas

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- Localizations
local AceGUI = ns.AceGUI
local L = ns.AceLocale:GetLocale("NAG", true)
local AceConfigRegistry = ns.AceConfigRegistry
local StringUtil = ns.StringUtil

-- Lua APIs
local format = string.format
local tinsert = tinsert
local time = time

-- Load sub-modules
local EditorUtils = ns.RotationEditorUtils
local Validation = ns.RotationEditorValidation
local Export = ns.RotationEditorExport
local ArgumentRenderer = ns.RotationEditorArgumentRenderer
local NodeEditors = ns.RotationEditorNodeEditors
local ASTEditor = ns.RotationEditorAST
local TabRenderers = ns.RotationEditorTabRenderers
local PrePullEditor = ns.RotationEditorPrePull
local SmartSwitchingEditor = ns.RotationEditorSmartSwitching
local SpellLocationsEditor = ns.RotationEditorSpellLocations

-- ~~~~~~~~~~ MODULE DEFINITION ~~~~~~~~~~

local RotationEditor = {}
ns.RotationEditor = RotationEditor

-- Rotation string synchronization is now controlled by ns.USE_SYNC_ROTATION_STRING in Core.lua

-- ============================ INTERNAL HELPERS ============================

local function splitLines(text)
    local lines = {}
    if not text or text == "" then
        return lines
    end

    for line in (text .. "\n"):gmatch("([^\n]*)\n") do
        table.insert(lines, line)
    end

    return lines
end

local function isCommentOnlyLine(line)
    if not line then return false end
    local trimmed = line:match("^%s*(.-)%s*$")
    return trimmed ~= "" and trimmed:match("^%-%-") ~= nil
end

local function normalizeCodeLine(line)
    if not line or line == "" then
        return ""
    end

    local placeholders = {}
    local placeholderIndex = 0

    local protected = line:gsub("\"[^\"]*\"", function(str)
        placeholderIndex = placeholderIndex + 1
        placeholders[placeholderIndex] = str
        return "\0" .. placeholderIndex .. "\0"
    end)

    protected = protected:gsub("%-%-.*$", "", 1)
    protected = protected:gsub("^%s*(.-)%s*$", "%1")

    if protected == "" then
        return ""
    end

    protected = protected:gsub("%s+", "")

    protected = protected:gsub("\0(%d+)\0", function(index)
        return placeholders[tonumber(index)] or ""
    end)

    return protected
end

local function computeNormalizedLines(lines)
    local normalized = {}
    for idx = 1, #lines do
        normalized[idx] = normalizeCodeLine(lines[idx])
    end
    return normalized
end

local function trim(str)
    if not str then
        return ""
    end

    return (str:match("^%s*(.-)%s*$") or "")
end

local function shortenDebugValue(value)
    if not value or value == "" then
        return "<empty>"
    end

    local maxLength = 200
    if #value > maxLength then
        return value:sub(1, maxLength) .. "..."
    end

    return value
end

local function extractCanonicalData(text)
    local codeParts = {}
    local commentCounts = {}

    if not text or text == "" then
        return "", commentCounts
    end

    for line in (text .. "\n"):gmatch("([^\n]*)\n") do
        local commentStart = line:find("%-%-")
        local codePart = line
        local commentPart

        if commentStart then
            codePart = line:sub(1, commentStart - 1)
            commentPart = line:sub(commentStart + 2)
        end

        if codePart and codePart:match("%S") then
            tinsert(codeParts, (codePart:gsub("%s+", "")))
        end

        if commentPart and commentPart:match("%S") then
            local commentText = trim(commentPart)
            if commentText ~= "" then
                commentCounts[commentText] = (commentCounts[commentText] or 0) + 1
            end
        end
    end

    return table.concat(codeParts, ""), commentCounts
end

local function commentCountsEqual(first, second)
    for commentText, firstCount in pairs(first) do
        if (second[commentText] or 0) ~= firstCount then
            return false
        end
    end

    for commentText, secondCount in pairs(second) do
        if (first[commentText] or 0) ~= secondCount then
            return false
        end
    end

    return true
end

local function buildCommentDiffText(originalCounts, currentCounts)
    local diffLines = {}
    local processed = {}

    for commentText, originalCount in pairs(originalCounts) do
        local currentCount = currentCounts[commentText] or 0
        if originalCount > currentCount then
            for _ = 1, (originalCount - currentCount) do
                tinsert(diffLines, "|cFFFF5555- -- " .. commentText .. "|r")
            end
        elseif currentCount > originalCount then
            for _ = 1, (currentCount - originalCount) do
                tinsert(diffLines, "|cFF55FF55+ -- " .. commentText .. "|r")
            end
        end
        processed[commentText] = true
    end

    for commentText, currentCount in pairs(currentCounts) do
        if not processed[commentText] and currentCount > 0 then
            for _ = 1, currentCount do
                tinsert(diffLines, "|cFF55FF55+ -- " .. commentText .. "|r")
            end
        end
    end

    if #diffLines == 0 then
        tinsert(diffLines, "|cFF00FF00No comment differences detected|r")
    end

    return table.concat(diffLines, "\n")
end

local function extractCommentSegments(notes)
    local segments = {}
    if not notes or notes == "" then
        return segments
    end

    for line in notes:gmatch("[^\n]+") do
        if line:find("|") then
            for piece in line:gmatch("[^|]+") do
                local cleaned = trim(piece)
                if cleaned ~= "" then
                    table.insert(segments, cleaned)
                end
            end
        else
            local cleaned = trim(line)
            if cleaned ~= "" then
                table.insert(segments, cleaned)
            end
        end
    end

    return segments
end

local function normalizeCommentSegment(segment)
    if not segment or segment == "" then
        return ""
    end

    local normalized = trim(segment)
    if normalized ~= "" and not normalized:match("^%-%-") then
        normalized = "-- " .. normalized
    end

    return normalized
end

local function buildClauseDataList(rotationString)
    if not rotationString or rotationString == "" or rotationString:match("^%s*$") then
        return {}
    end

    local conversionService = NAG:GetModule("RotationConversionService")
    local ast, diagnostics = conversionService:ParseToProtoAST(rotationString, {
        useCache = true,
        validate = false,
    })
    local err = not ast and (diagnostics and diagnostics.errors and diagnostics.errors[1]) or nil
    if not ast or not ast.priority_list then
        NAG:Debug("[PendingDiff] Clause parsing failed: %s", tostring(err))
        return nil
    end

    local clauses = {}
    local ASTSchemaEmitter = ns.ASTSchemaEmitter
    local ASTAction = ns.ASTAction
    for index, listItem in ipairs(ast.priority_list or {}) do
        -- Extract action from listItem (proto AST structure)
        local actionNode = listItem.action
        if not actionNode then
            -- Skip if no action node
        else
            -- CRITICAL: Synthesize both condition and action text from proto AST
            -- Condition is on actionNode.condition (proto AST structure)
            local conditionText = ""
            if ASTAction and ASTAction.HasCondition(actionNode) then
                local conditionNode = ASTAction.GetCondition(actionNode)
                if conditionNode and ASTSchemaEmitter then
                    conditionText = ASTSchemaEmitter.EmitValueNode(conditionNode) or ""
                end
            end

            -- Synthesize action text from proto AST
            local actionText = ""
            if ASTSchemaEmitter then
                actionText = ASTSchemaEmitter.EmitActionNode(actionNode) or ""
            end

            -- Combine condition and action in clause format: (condition) and action
            local clauseText = ""
            if conditionText and conditionText ~= "" then
                clauseText = format("(%s) and %s", conditionText, actionText)
            else
                clauseText = actionText
            end

            local leadingWhitespace = ""  -- Proto AST doesn't preserve whitespace
            local prefix = (index > 1) and "or " or ""
            local codeDisplay = leadingWhitespace .. prefix .. clauseText
            local flattenedDisplay = codeDisplay
                :gsub("\r", "")
                :gsub("%s*\n%s*", " ")
                :gsub("%s+", " ")
                :gsub("^%s+", prefix ~= "" and "" or "")
            local canonical = normalizeCodeLine(prefix .. clauseText)

            local commentIndent = leadingWhitespace
            local commentCounts = {}
            local commentLines = {}

            -- Notes are on listItem, not action (proto AST structure)
            if listItem.notes then
                for _, segment in ipairs(extractCommentSegments(listItem.notes)) do
                    local normalized = normalizeCommentSegment(segment)
                    if normalized ~= "" then
                        commentCounts[normalized] = (commentCounts[normalized] or 0) + 1
                        table.insert(commentLines, commentIndent .. normalized)
                    end
                end
            end

            table.insert(clauses, {
                index = index,
                canonical = canonical,
                codeDisplay = codeDisplay,
                flattenedDisplay = flattenedDisplay,
                commentLines = commentLines,
                commentCounts = commentCounts,
                commentIndent = commentIndent,
                leadingWhitespace = leadingWhitespace,
            })
        end
    end

    if NAG:IsDevModeEnabled() then
        local parserModule = NAG:GetModule("NAGStringParser", true)
        local parserLabel = "unknown"
        if parserModule then
            local parserName = parserModule.GetName and parserModule:GetName() or "NAGStringParser"
            local moduleType = parserModule.GetModuleType and parserModule:GetModuleType() or nil
            if moduleType and moduleType ~= "" then
                parserLabel = parserName .. "::" .. tostring(moduleType)
            else
                parserLabel = parserName
            end
        end

        NAG:Debug("[PendingDiff] Parsed %d clauses from rotation (parser=%s)", #clauses, parserLabel)

        for idx, clause in ipairs(clauses) do
            local preview = clause.codeDisplay or ""
            if #preview > 120 then
                preview = preview:sub(1, 117) .. "..."
            end
            NAG:Debug("[PendingDiff] Clause %d canonical=%s preview=%s", idx, clause.canonical ~= "" and "yes" or "no", preview)
        end
    end

    return clauses
end

local function appendCommentDiff(diffLines, oldClause, newClause)
    local oldCounts = oldClause.commentCounts or {}
    local newCounts = newClause.commentCounts or {}
    local oldIndent = oldClause.commentIndent or oldClause.leadingWhitespace or ""
    local newIndent = newClause.commentIndent or newClause.leadingWhitespace or ""

    for text, oldCount in pairs(oldCounts) do
        local newCount = newCounts[text] or 0
        if oldCount > newCount then
            for _ = 1, oldCount - newCount do
                table.insert(diffLines, "|cFFFF5555- " .. oldIndent .. text .. "|r")
            end
        end
    end

    for text, newCount in pairs(newCounts) do
        local oldCount = oldCounts[text] or 0
        if newCount > oldCount then
            for _ = 1, newCount - oldCount do
                table.insert(diffLines, "|cFF55FF55+ " .. newIndent .. text .. "|r")
            end
        end
    end
end

local function appendClauseRemoval(diffLines, clauseData)
    if clauseData.commentLines and #clauseData.commentLines > 0 then
        for _, commentLine in ipairs(clauseData.commentLines) do
            table.insert(diffLines, "|cFFFF5555- " .. commentLine .. "|r")
        end
    end
    local display = clauseData.flattenedDisplay or clauseData.codeDisplay
    if display and display ~= "" then
        table.insert(diffLines, "|cFFFF5555- " .. display .. "|r")
    end
end

local function appendClauseAddition(diffLines, clauseData)
    if clauseData.commentLines and #clauseData.commentLines > 0 then
        for _, commentLine in ipairs(clauseData.commentLines) do
            table.insert(diffLines, "|cFF55FF55+ " .. commentLine .. "|r")
        end
    end
    local display = clauseData.flattenedDisplay or clauseData.codeDisplay
    if display and display ~= "" then
        table.insert(diffLines, "|cFF55FF55+ " .. display .. "|r")
    end
end

local function buildClauseDiff(original, current)
    local originalClauses = buildClauseDataList(original)
    local currentClauses = buildClauseDataList(current)

    if originalClauses == nil or currentClauses == nil then
        return nil
    end

    local n = #originalClauses
    local m = #currentClauses

    if n == 0 and m == 0 then
        return "|cFF00FF00No differences detected|r"
    end

    local lcs = {}
    for i = 1, n + 1 do
        lcs[i] = {}
        for j = 1, m + 1 do
            lcs[i][j] = 0
        end
    end

    for i = n, 1, -1 do
        for j = m, 1, -1 do
            if originalClauses[i].canonical == currentClauses[j].canonical then
                lcs[i][j] = lcs[i + 1][j + 1] + 1
            else
                local down = lcs[i + 1][j]
                local right = lcs[i][j + 1]
                lcs[i][j] = (down >= right) and down or right
            end
        end
    end

    local operations = {}
    local i, j = 1, 1

    while i <= n and j <= m do
        local oldClause = originalClauses[i]
        local newClause = currentClauses[j]

        if oldClause.canonical == newClause.canonical then
            if not commentCountsEqual(oldClause.commentCounts, newClause.commentCounts) then
                table.insert(operations, {
                    type = "comment",
                    oldClause = oldClause,
                    newClause = newClause,
                })
            end
            i = i + 1
            j = j + 1
        elseif lcs[i + 1][j] >= lcs[i][j + 1] then
            table.insert(operations, {
                type = "remove",
                clause = oldClause,
            })
            i = i + 1
        else
            table.insert(operations, {
                type = "add",
                clause = newClause,
            })
            j = j + 1
        end
    end

    while i <= n do
        table.insert(operations, {
            type = "remove",
            clause = originalClauses[i],
        })
        i = i + 1
    end

    while j <= m do
        table.insert(operations, {
            type = "add",
            clause = currentClauses[j],
        })
        j = j + 1
    end

    local diffLines = {}
    local pendingRemovals = {}

    local function flushPendingRemovals()
        while #pendingRemovals > 0 do
            local clause = table.remove(pendingRemovals, 1)
            appendClauseRemoval(diffLines, clause)
            if #pendingRemovals > 0 then
                table.insert(diffLines, "")
            end
        end
    end

    for _, op in ipairs(operations) do
        if op.type == "comment" then
            flushPendingRemovals()
            table.insert(diffLines, "|cFFFFFF00Comment differences in clause " .. tostring(op.oldClause.index) .. "|r")
            table.insert(diffLines, "  " .. op.oldClause.codeDisplay)
            appendCommentDiff(diffLines, op.oldClause, op.newClause)
            table.insert(diffLines, "")
        elseif op.type == "remove" then
            table.insert(pendingRemovals, op.clause)
        elseif op.type == "add" then
            local pairedRemoval = nil
            if #pendingRemovals > 0 then
                pairedRemoval = table.remove(pendingRemovals, 1)
            end

            if pairedRemoval then
                appendClauseRemoval(diffLines, pairedRemoval)
                appendClauseAddition(diffLines, op.clause)
            else
                appendClauseAddition(diffLines, op.clause)
            end
            table.insert(diffLines, "")
        end
    end

    if #pendingRemovals > 0 then
        flushPendingRemovals()
    end

    if diffLines[#diffLines] == "" then
        table.remove(diffLines, #diffLines)
    end

    if #diffLines == 0 then
        return "|cFF00FF00No differences detected|r"
    end

    return table.concat(diffLines, "\n")
end

local function buildLineDiff(original, current)
    local oldLines = splitLines(original or "")
    local newLines = splitLines(current or "")
    local n = #oldLines
    local m = #newLines

    local oldNormalized = computeNormalizedLines(oldLines)
    local newNormalized = computeNormalizedLines(newLines)

    -- DEBUG: Log normalization results
    if NAG:IsDevModeEnabled() then
        NAG:Debug("[buildLineDiff] Comparing %d old lines vs %d new lines", n, m)
        for i = 1, math.min(n, m) do
            if oldNormalized[i] ~= newNormalized[i] then
                NAG:Debug("[buildLineDiff] Line %d differs - old normalized: '%s', new normalized: '%s'",
                    i, oldNormalized[i] or "<nil>", newNormalized[i] or "<nil>")
                NAG:Debug("[buildLineDiff] Line %d raw - old: '%s', new: '%s'",
                    i, oldLines[i] or "<nil>", newLines[i] or "<nil>")
            end
        end
    end

    local lcs = {}
    for i = 1, n + 1 do
        lcs[i] = {}
        for j = 1, m + 1 do
            lcs[i][j] = 0
        end
    end

    for i = n, 1, -1 do
        for j = m, 1, -1 do
        if oldNormalized[i] == newNormalized[j] then
                lcs[i][j] = lcs[i + 1][j + 1] + 1
            else
                local down = lcs[i + 1][j]
                local right = lcs[i][j + 1]
                lcs[i][j] = (down >= right) and down or right
            end
        end
    end

    local diffLines = {}
    local i, j = 1, 1
    while i <= n and j <= m do
        if isCommentOnlyLine(oldLines[i]) and isCommentOnlyLine(newLines[j]) then
            i = i + 1
            j = j + 1
        elseif isCommentOnlyLine(oldLines[i]) then
            i = i + 1
        elseif isCommentOnlyLine(newLines[j]) then
            j = j + 1
        elseif oldNormalized[i] == newNormalized[j] then
            table.insert(diffLines, "  " .. oldLines[i])
            i = i + 1
            j = j + 1
        elseif lcs[i + 1][j] >= lcs[i][j + 1] then
            table.insert(diffLines, "|cFFFF5555- " .. oldLines[i] .. "|r")
            i = i + 1
        else
            table.insert(diffLines, "|cFF55FF55+ " .. newLines[j] .. "|r")
            j = j + 1
        end
    end

    while i <= n do
        if not isCommentOnlyLine(oldLines[i]) then
            table.insert(diffLines, "|cFFFF5555- " .. oldLines[i] .. "|r")
        end
        i = i + 1
    end

    while j <= m do
        if not isCommentOnlyLine(newLines[j]) then
            table.insert(diffLines, "|cFF55FF55+ " .. newLines[j] .. "|r")
        end
        j = j + 1
    end

    if #diffLines == 0 then
        table.insert(diffLines, "|cFF00FF00No differences detected|r")
    end

    return table.concat(diffLines, "\n")
end

local function buildPendingDiff(original, current)
    local clauseDiff = buildClauseDiff(original, current)
    if clauseDiff then
        return clauseDiff
    end

    return buildLineDiff(original, current)
end

-- ~~~~~~~~~~ MAIN EDITOR FUNCTION ~~~~~~~~~~

--- Show the tabbed rotation editor
--- @param specIndex number The specialization index (1, 2, 3)
--- @param rotation table The rotation data {name, config}
--- @param classModule table The class module
--- @param initialTab string|nil Optional tab to preselect (e.g., "prepull")
function RotationEditor:ShowEditor(specIndex, rotation, classModule, initialTab)
    if not specIndex or not rotation or not classModule then
        NAG:Error("RotationEditor: Invalid parameters")
        return
    end

    -- Load rotation with aplProto
    local rotationManager = NAG:GetModule("RotationManager")
    local rotationWithProto, err = rotationManager:GetRotationWithProto(specIndex, rotation.name)

    if not rotationWithProto then
        NAG:Error("Failed to load rotation: %s", tostring(err))
        return
    end

    -- Load aplProto as primary source - workingConfig.aplProto is a safe deep copy
    local workingConfig = EditorUtils.CopyTable(rotationWithProto)

    NAG:Debug("[ROT-SYNC] ShowEditor: INIT | rotationName=%s | specIndex=%s | hasAplProto=%s | hasRotationString=%s",
        rotation.name or "unknown",
        tostring(specIndex or "unknown"),
        tostring(workingConfig.aplProto ~= nil),
        tostring(workingConfig.rotationString ~= nil))

    -- Ensure aplProto exists in workingConfig - respect source of truth
    if not workingConfig.aplProto then
        NAG:Debug("[ROT-SYNC] ShowEditor: aplProto missing, parsing from rotationString")
        -- If missing, try to parse from rotationString
        local conversionService = NAG:GetModule("RotationConversionService")
        if conversionService and workingConfig.rotationString then
            local parsedAST, diagnostics = conversionService:ParseToProtoAST(workingConfig.rotationString, {
                useCache = true,
                validate = false
            })
            if parsedAST then
                workingConfig.aplProto = parsedAST
                NAG:Debug("[ROT-SYNC] ShowEditor: Successfully parsed aplProto from rotationString")
            else
                NAG:Warn("[ROT-SYNC] ShowEditor: Failed to parse aplProto from rotationString")
            end
        else
            NAG:Warn("[ROT-SYNC] ShowEditor: Cannot parse aplProto - conversionService=%s | rotationString=%s",
                tostring(conversionService ~= nil), tostring(workingConfig.rotationString ~= nil))
        end
    elseif not ns.USE_SYNC_ROTATION_STRING and workingConfig.rotationString then
        -- rotationString is source of truth - regenerate aplProto from it in-memory (don't save)
        NAG:Debug("[ROT-SYNC] ShowEditor: USE_SYNC_ROTATION_STRING=false, regenerating aplProto from rotationString (in-memory)")
        local conversionService = NAG:GetModule("RotationConversionService")
        if conversionService then
            local parsedAST, diagnostics = conversionService:ParseToProtoAST(workingConfig.rotationString, {
                useCache = true,
                validate = false
            })
            if parsedAST then
                workingConfig.aplProto = parsedAST
                NAG:Debug("[ROT-SYNC] ShowEditor: Successfully regenerated aplProto from rotationString (source of truth, in-memory only)")
            else
                NAG:Warn("[ROT-SYNC] ShowEditor: Failed to regenerate aplProto from rotationString")
            end
        end
    else
        NAG:Debug("[ROT-SYNC] ShowEditor: aplProto loaded from rotationWithProto (deep copy)")
    end

    -- Sync groups and variables from strings to AST (after aplProto is ready)
    if workingConfig.aplProto then
        local ASTEditor = ns.RotationEditorAST
        if ASTEditor then
            ASTEditor:SyncGroupsVariablesTextToVisual({ workingConfig = workingConfig })
        end
    end

    local editorState = {
        originalConfig = EditorUtils.CopyTable(rotationWithProto),
        workingConfig = workingConfig,
        -- protoAST removed - use workingConfig.aplProto directly
        specIndex = specIndex,
        rotationName = rotation.name,
        classModule = classModule,
        isDirty = false,
        closeConfirmed = false,
        validationErrors = {},
        sidebarCollapsed = true,  -- Start with sidebar hidden by default
        currentTab = initialTab or "rotation",
        mainFrame = nil
    }
    NAG:Debug(format("[Editor Debug] Has prePull: %s", tostring(editorState.workingConfig.prePull ~= nil)))
    if editorState.workingConfig.prePull then
        NAG:Debug(format("[Editor Debug] prePull count: %d", #editorState.workingConfig.prePull))
    end

    -- Create main frame
    local frame = AceGUI:Create("Frame")
    frame:SetTitle((L["editRotation"] or "Edit Rotation") .. ": " .. rotation.name)
    frame:SetLayout("Flow")
    frame:SetWidth(1100)
    frame:SetHeight(770)

    -- Store editorState in frame.userdata for widget callbacks
    if not frame.userdata then
        frame.userdata = {}
    end
    frame.userdata.editorState = editorState

    editorState.mainFrame = frame

    -- Expose current editor state on module for diagnostics access
    RotationEditor.currentEditorState = editorState

    -- Helper function to handle close with unsaved changes check
    local function RequestClose(editorState, frame)
        if not editorState.isDirty then
            -- No unsaved changes, close immediately
            editorState.closeConfirmed = true
            frame:Hide()
            return
        end

        -- Has unsaved changes, show confirmation dialog
        StaticPopupDialogs["NAG_ROTATION_EDITOR_UNSAVED"] = {
            text = L["rotationUnsavedChanges"] or "You have unsaved changes. Close anyway?",
            button1 = YES,
            button2 = NO,
            OnShow = function(dialog)
                dialog:SetFrameStrata("FULLSCREEN_DIALOG")
                dialog:SetFrameLevel(200)
            end,
            OnAccept = function()
                editorState.closeConfirmed = true
                frame:Hide()
            end,
            OnCancel = function()
                -- User cancelled - keep editor open
                editorState.closeConfirmed = false
                -- Frame is already shown (OnHide hook prevented the close)
            end,
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
            preferredIndex = 3,
        }
        StaticPopup_Show("NAG_ROTATION_EDITOR_UNSAVED")
    end

    -- Intercept OnHide while preserving the original handler (no AceHook dependency)
    local originalOnHide = nil
    if frame.frame then
        originalOnHide = frame.frame:GetScript("OnHide")
        frame.frame:SetScript("OnHide", function(self)
            -- Only intercept if frame is being hidden and we haven't confirmed
            if editorState.mainFrame and editorState.isDirty and not editorState.closeConfirmed then
                -- Prevent the hide by showing the frame again immediately
                self:Show()

                -- Request close (which will show dialog if needed)
                RequestClose(editorState, frame)
            end

            if originalOnHide then
                originalOnHide(self)
            end
        end)
    end

    frame:SetCallback("OnClose", function(widget)
        -- Only release widget if close was confirmed or no unsaved changes
        -- If there are unsaved changes and not confirmed, the OnHide hook will prevent the close
        if editorState.closeConfirmed or not editorState.isDirty then
            -- Restore original OnHide handler
            if widget.frame then
                widget.frame:SetScript("OnHide", originalOnHide)
            end

            -- Clean up editor-owned widget markers before releasing
            local ASTEditor = ns.RotationEditorAST
            if ASTEditor and ASTEditor.CleanupEditorWidgets then
                ASTEditor:CleanupEditorWidgets(editorState)
            end

            AceGUI:Release(widget)
            -- Clear exposed editor state when editor closes
            if RotationEditor.currentEditorState == editorState then
                RotationEditor.currentEditorState = nil
            end
            -- End any active pre-pull preview broadcast
            if NAG and NAG.SendMessage then
                NAG:SendMessage("NAG_PREPULL_PREVIEW_END", {
                    specIndex = editorState.specIndex,
                    rotationName = editorState.rotationName
                })
            end
        else
            -- Close was requested but not confirmed - prevent widget release
            -- The OnHide hook will show the confirmation dialog
        end
    end)

    -- Create button bar
    local buttonGroup = AceGUI:Create("SimpleGroup")
    buttonGroup:SetLayout("Flow")
    buttonGroup:SetFullWidth(true)
    frame:AddChild(buttonGroup)

    -- Validate button
    local validateBtn = AceGUI:Create("Button")
    validateBtn:SetText(L["validate"] or "Validate")
    validateBtn:SetWidth(100)
    validateBtn:SetCallback("OnClick", function()
        Validation:ValidateAllFields(editorState)
    end)
    buttonGroup:AddChild(validateBtn)

    if NAG:IsDevModeEnabled() then
        local diffBtn = AceGUI:Create("Button")
        diffBtn:SetText(L["showPendingChanges"] or "Show Pending Changes")
        diffBtn:SetWidth(160)
        diffBtn:SetCallback("OnClick", function()
            self:ShowPendingChanges(editorState)
        end)
        buttonGroup:AddChild(diffBtn)
    end

    -- Save button
    local saveBtn = AceGUI:Create("Button")
    saveBtn:SetText(L["save"] or "Save")
    saveBtn:SetWidth(100)
    saveBtn:SetCallback("OnClick", function()
        self:SaveRotation(editorState)
    end)
    buttonGroup:AddChild(saveBtn)

    -- Rename button
    local renameBtn = AceGUI:Create("Button")
    renameBtn:SetText(L["rename"] or "Rename")
    renameBtn:SetWidth(100)
    renameBtn:SetCallback("OnClick", function()
        self:ShowRenameDialog(editorState)
    end)
    buttonGroup:AddChild(renameBtn)

    -- Export to Class Format button (devmode only)
    if NAG:IsDevModeEnabled() then
        local exportClassBtn = AceGUI:Create("Button")
        exportClassBtn:SetText("Export Format")
        exportClassBtn:SetWidth(120)
        exportClassBtn:SetCallback("OnClick", function()
            Export:ShowClassFormatExport(editorState)
        end)
        buttonGroup:AddChild(exportClassBtn)

        local exportModuleBtn = AceGUI:Create("Button")
        exportModuleBtn:SetText("Export Class File")
        exportModuleBtn:SetWidth(140)
        exportModuleBtn:SetCallback("OnClick", function()
            Export:ShowClassModuleExport(editorState)
        end)
        buttonGroup:AddChild(exportModuleBtn)
    end

    -- Sidebar toggle button (devmode only)
    if NAG:IsDevModeEnabled() then
        local sidebarToggleBtn = AceGUI:Create("Button")
        sidebarToggleBtn:SetWidth(120)

        -- Helper function to update button text
        local function UpdateSidebarButtonText()
            sidebarToggleBtn:SetText(editorState.sidebarCollapsed and "Show Sidebar" or "Hide Sidebar")
        end

        -- Set initial text
        UpdateSidebarButtonText()

        sidebarToggleBtn:SetCallback("OnClick", function()
            if editorState.sidebarCollapsed == nil then
                editorState.sidebarCollapsed = true
            end
            editorState.sidebarCollapsed = not editorState.sidebarCollapsed
            UpdateSidebarButtonText()
            -- Refresh the tab to apply new layout
            EditorUtils.RefreshCurrentTab(RotationEditor, editorState)
        end)
        buttonGroup:AddChild(sidebarToggleBtn)
    end

    -- Cancel button
    local cancelBtn = AceGUI:Create("Button")
    cancelBtn:SetText(L["cancel"] or "Cancel")
    cancelBtn:SetWidth(100)
    cancelBtn:SetCallback("OnClick", function()
        -- Use the same close handler that checks for unsaved changes
        RequestClose(editorState, frame)
    end)
    buttonGroup:AddChild(cancelBtn)

    -- Warning banner when syncRotationString is disabled
    if not ns.USE_SYNC_ROTATION_STRING then
        local warningBanner = AceGUI:Create("Label")
        warningBanner:SetText("|cFFFF0000⚠ WARNING: String output synchronization is disabled. There are still known issues with rotationString generation. This toggle will be removed once issues are resolved.|r")
        warningBanner:SetFullWidth(true)
        warningBanner:SetFontObject(GameFontNormalLarge)
        frame:AddChild(warningBanner)
    end

    -- Helper function to build tab list based on enableSmartSwitching
    local function BuildTabList()
        local tabs = {
            {text = L["rotationString"] or "Rotation", value = "rotation"},
            {text = L["properties"] or "Properties", value = "properties"},
        }

        -- Only show Smart Switching tab if enabled
        if editorState.workingConfig.enableSmartSwitching then
            tinsert(tabs, {text = L["smartSwitching"] or "Smart Switching", value = "switching"})
        end

        -- Add remaining tabs
        tinsert(tabs, {text = L["prePull"] or "PrePull & Timeline", value = "prepull"})
        tinsert(tabs, {text = L["tracking"] or "Tracking & Optimization", value = "tracking"})
        tinsert(tabs, {text = L["guide"] or "Guide & Setup", value = "guide"})
        if editorState.workingConfig.enableItemSwap then
            tinsert(tabs, {text = L["itemSwap"] or "Item Swap", value = "itemswap"})
        end

        -- Only show Spell Locations tab if custom locations enabled
        if editorState.workingConfig.useCustomSpellLocations then
            tinsert(tabs, {text = L["spellLocations"] or "Spell Locations", value = "spelllocations"})
        end

        tinsert(tabs, {text = L["talentsGlyphs"] or "Talents & Glyphs", value = "talentsglyphs"})

        return tabs
    end

    -- Create tab group
    local tabGroup = AceGUI:Create("TabGroup")
    tabGroup:SetLayout("Fill")
    tabGroup:SetFullWidth(true)
    tabGroup:SetFullHeight(true)
    tabGroup:SetTabs(BuildTabList())
    tabGroup:SetCallback("OnGroupSelected", function(container, event, group)
        -- Reset cursor when switching tabs to prevent drag cursor from persisting
        ResetCursor()

        editorState.currentTab = group
        container:ReleaseChildren()

        if group == "rotation" then
            TabRenderers:RenderRotationStringTab(container, editorState)
        elseif group == "properties" then
            TabRenderers:RenderPropertiesTab(container, editorState)
        elseif group == "switching" then
            SmartSwitchingEditor:RenderSmartSwitchingTab(container, editorState)
        elseif group == "prepull" then
            PrePullEditor:RenderPrePullTab(container, editorState)
        elseif group == "tracking" then
            TabRenderers:RenderTrackingTab(container, editorState)
        elseif group == "guide" then
            TabRenderers:RenderGuideTab(container, editorState)
        elseif group == "itemswap" then
            TabRenderers:RenderItemSwapTab(container, editorState)
        elseif group == "spelllocations" then
            SpellLocationsEditor:RenderSpellLocationsTab(container, editorState)
        elseif group == "talentsglyphs" then
            TabRenderers:RenderTalentsGlyphsTab(container, editorState)
        end
    end)
    tabGroup:SelectTab(editorState.currentTab or "rotation")
    frame:AddChild(tabGroup)

    -- Store tabGroup and BuildTabList in editorState for updates
    editorState.tabGroup = tabGroup
    editorState.BuildTabList = BuildTabList
end

--- Display pending rotation changes in a diff viewer
--- @param editorState table
function RotationEditor:ShowPendingChanges(editorState)
    if not editorState then
        return
    end

    local original = (editorState.originalConfig and editorState.originalConfig.rotationString) or ""
    local current = (editorState.workingConfig and editorState.workingConfig.rotationString) or ""

    -- DEBUG: Log string comparison
    if NAG:IsDevModeEnabled() then
        local origLen = #original
        local currLen = #current
        NAG:Debug("[ShowPendingChanges] Original length: %d, Current length: %d", origLen, currLen)
        NAG:Debug("[ShowPendingChanges] Strings identical: %s", tostring(original == current))
        if original ~= current then
            -- Find first difference
            local minLen = math.min(origLen, currLen)
            for i = 1, minLen do
                local origChar = string.sub(original, i, i)
                local currChar = string.sub(current, i, i)
                if origChar ~= currChar then
                    local start = math.max(1, i - 20)
                    local origSnippet = string.sub(original, start, i + 20)
                    local currSnippet = string.sub(current, start, i + 20)
                    NAG:Debug("[ShowPendingChanges] First difference at position %d: orig='%s' curr='%s'",
                        i, origSnippet, currSnippet)
                    break
                end
            end
        end
    end

    if original == current then
        NAG:Info("No pending rotation changes detected")
        return
    end

    local originalCodeCanonical, originalCommentCounts = extractCanonicalData(original)
    local currentCodeCanonical, currentCommentCounts = extractCanonicalData(current)
    local hasCommentDifferences = not commentCountsEqual(originalCommentCounts, currentCommentCounts)
    local canonicalMatch = originalCodeCanonical == currentCodeCanonical

    if NAG:IsDevModeEnabled() then
        NAG:Info("[PendingDiff] Inspecting rotation '%s' (spec: %s)", editorState.rotationName or "?", tostring(editorState.specIndex))
        NAG:Debug("[PendingDiff] Canonical match: %s, Comment differences: %s", tostring(canonicalMatch), tostring(hasCommentDifferences))

        if not canonicalMatch then
            NAG:Trace("[PendingDiff] Original canonical (truncated): %s", shortenDebugValue(originalCodeCanonical))
            NAG:Trace("[PendingDiff] Current canonical (truncated): %s", shortenDebugValue(currentCodeCanonical))
        end

        if canonicalMatch and hasCommentDifferences then
            NAG:Warn("[PendingDiff] Canonical code matches but comments differ; showing comment diff summary")
        elseif canonicalMatch and not hasCommentDifferences then
            NAG:Trace("[PendingDiff] Canonical and comments match; formatting-only changes detected")
        end
    end

    local diffText

    if canonicalMatch and not hasCommentDifferences then
        diffText = "|cFF00FF00No substantive differences detected (formatting/comment relocation only)|r"
    elseif canonicalMatch and hasCommentDifferences then
        diffText = "|cFFFFFF00Comment differences detected:|r\n" .. buildCommentDiffText(originalCommentCounts, currentCommentCounts)
    else
        diffText = buildPendingDiff(original, current)

        if hasCommentDifferences then
            diffText = diffText .. "\n\n|cFFFFFF00Comment differences detected:|r\n" .. buildCommentDiffText(originalCommentCounts, currentCommentCounts)
        end
    end

    if editorState.pendingChangesFrame then
        AceGUI:Release(editorState.pendingChangesFrame)
        editorState.pendingChangesFrame = nil
    end

    local frame = AceGUI:Create("Frame")
    frame:SetTitle(L["pendingChanges"] or "Rotation Pending Changes")
    frame:SetLayout("Flow")
    frame:SetWidth(860)
    frame:SetHeight(620)
    frame:EnableResize(true)

    frame:SetCallback("OnClose", function(widget)
        editorState.pendingChangesFrame = nil
        AceGUI:Release(widget)
    end)

    editorState.pendingChangesFrame = frame

    local legend = AceGUI:Create("Label")
    legend:SetText("|cFF55FF55+|r added lines, |cFFFF5555-|r removed lines")
    legend:SetFullWidth(true)
    frame:AddChild(legend)

    local diffBox = AceGUI:Create("MultiLineEditBox")
    diffBox:SetLabel(L["diffOutput"] or "Diff (Original → Current)")
    diffBox:SetText(diffText)
    diffBox:SetFullWidth(true)
    diffBox:SetNumLines(18)
    diffBox:DisableButton(true)
    frame:AddChild(diffBox)

    local columns = AceGUI:Create("SimpleGroup")
    columns:SetLayout("Flow")
    columns:SetFullWidth(true)
    frame:AddChild(columns)

    local originalBox = AceGUI:Create("MultiLineEditBox")
    originalBox:SetLabel(L["originalRotation"] or "Original Rotation String")
    originalBox:SetText(original)
    originalBox:SetRelativeWidth(0.5)
    originalBox:SetNumLines(10)
    originalBox:DisableButton(true)
    columns:AddChild(originalBox)

    local currentBox = AceGUI:Create("MultiLineEditBox")
    currentBox:SetLabel(L["currentRotation"] or "Current Rotation String")
    currentBox:SetText(current)
    currentBox:SetRelativeWidth(0.5)
    currentBox:SetNumLines(10)
    currentBox:DisableButton(true)
    columns:AddChild(currentBox)
end

-- ~~~~~~~~~~ SAVE LOGIC ~~~~~~~~~~

--- Save the rotation
--- @param editorState table The editor state for this instance
function RotationEditor:SaveRotation(editorState)
    NAG:Debug("[ROT-SYNC] SaveRotation: ENTRY | rotationName=%s | specIndex=%s",
        editorState.rotationName or "unknown",
        tostring(editorState.specIndex or "unknown"))

    -- workingConfig.aplProto is already the source of truth - no sync needed

    -- Visual mode: Conditionally sync rotationString based on flag
    NAG:Debug("[ROT-SYNC] SaveRotation: VISUAL MODE | syncRotationString=%s",
        tostring(ns.USE_SYNC_ROTATION_STRING))

    local SpecCompat = NAG:GetModule("SpecCompat")
        -- Generate new rotationString from aplProto to compare
    local existingString = editorState.workingConfig.rotationString or ""
    local newString = nil
    local ASTSchemaEmitter = ns.ASTSchemaEmitter
    if ASTSchemaEmitter and editorState.workingConfig.aplProto then
        newString, _ = ASTSchemaEmitter.EmitRotationString(editorState.workingConfig.aplProto, {
            format = false
        })
        if newString then
            NAG:Debug("[ROT-SYNC] SaveRotation: VISUAL MODE - generated newString length=%d", #newString)
        else
            NAG:Warn("[ROT-SYNC] SaveRotation: VISUAL MODE - failed to generate newString from aplProto")
        end
    end

    if ns.USE_SYNC_ROTATION_STRING then
        -- AUTO-SYNC MODE: Sync automatically without dialog
        NAG:Debug("[ROT-SYNC] SaveRotation: VISUAL MODE - auto-sync enabled, syncing rotationString")
        ASTEditor:SyncVisualToText(editorState)
        NAG:Debug("[ROT-SYNC] SaveRotation: VISUAL MODE - SyncVisualToText completed")
    else
        -- DEVELOPMENT MODE: Show dialog to offer optional sync
        -- If we have both and they differ, ask for confirmation
        if newString and existingString ~= "" and newString ~= existingString and not editorState._skipOverwriteConfirm then
            NAG:Info("[ROT-SYNC] SaveRotation: VISUAL MODE - strings differ, showing confirmation dialog")
            -- Show confirmation dialog
            StaticPopupDialogs["NAG_ROTATION_OVERWRITE_CONFIRM"] = {
                text = "The visual editor has generated a new rotationString that differs from the existing one.\n\n" ..
                       "|cFFFFD100Do you want to update rotationString from the visual changes?|r\n\n" ..
                       "|cFF888888Yes: Save and update rotationString\n" ..
                       "No: Save but keep existing rotationString|r",
                button1 = "Yes, Update",
                button2 = "No, Keep Existing",
                OnShow = function(dialog)
                    dialog:SetFrameStrata("FULLSCREEN_DIALOG")
                    dialog:SetFrameLevel(200)
                end,
                OnAccept = function()
                    -- User confirmed, proceed with sync and save
                    NAG:Info("[ROT-SYNC] SaveRotation: VISUAL MODE - user confirmed overwrite")
                    editorState._skipOverwriteConfirm = true
                    editorState._forceUpdateRotationString = true
                    -- Re-call SaveRotation to continue (will skip confirmation this time)
                    C_Timer.After(0.1, function()
                        RotationEditor:SaveRotation(editorState)
                    end)
                end,
                OnCancel = function()
                    -- User chose to keep existing rotationString, but still save aplProto
                    NAG:Info("[ROT-SYNC] SaveRotation: VISUAL MODE - user chose to keep existing rotationString")
                    NAG:Print("|cFF00FF00Save proceeding: aplProto saved, rotationString unchanged|r")
                    -- Continue with save (aplProto will be saved, rotationString will remain unchanged)
                    editorState._skipOverwriteConfirm = true
                    editorState._userCancelledSync = true
                    C_Timer.After(0.1, function()
                        RotationEditor:SaveRotation(editorState)
                    end)
                end,
                timeout = 0,
                whileDead = true,
                hideOnEscape = true,
                preferredIndex = 3,
            }

            StaticPopup_Show("NAG_ROTATION_OVERWRITE_CONFIRM")
            return -- Exit early, will retry after confirmation
        end

        -- Clear the flags if they were set
        local userCancelledSync = editorState._userCancelledSync
        local forceUpdateRotationString = editorState._forceUpdateRotationString
        if editorState._skipOverwriteConfirm then
            editorState._skipOverwriteConfirm = nil
        end
        if editorState._userCancelledSync then
            editorState._userCancelledSync = nil
        end
        if editorState._forceUpdateRotationString then
            editorState._forceUpdateRotationString = nil
        end

        -- If user cancelled sync, don't sync rotationString
        -- NOTE: We still save aplProto (for testing APLExecutor) even when USE_SYNC_ROTATION_STRING=false
        -- The aplProto will be regenerated from rotationString on next load/precompile
        if userCancelledSync then
            NAG:Debug("[ROT-SYNC] SaveRotation: VISUAL MODE - user cancelled sync, keeping existing rotationString")
            NAG:Debug("[ROT-SYNC] SaveRotation: aplProto will be saved (for testing) but regenerated from rotationString on load")
        elseif forceUpdateRotationString and newString then
            -- User explicitly confirmed they want to update rotationString
            NAG:Info("[ROT-SYNC] SaveRotation: VISUAL MODE - user confirmed update, forcing rotationString sync")
            editorState.workingConfig.rotationString = newString
            -- Also sync groups and variables
            ASTEditor:SyncGroupsVariablesVisualToText(editorState)
        elseif newString and (existingString == "" or newString == existingString) then
            -- If strings match or no existing string, sync automatically
            NAG:Debug("[ROT-SYNC] SaveRotation: VISUAL MODE - strings match or no existing string, syncing automatically")
            ASTEditor:SyncVisualToText(editorState)
        else
            -- No newString generated or other condition - don't sync rotationString
            NAG:Debug("[ROT-SYNC] SaveRotation: VISUAL MODE - USE_SYNC_ROTATION_STRING disabled, skipping rotationString sync")
        end
    end

    -- SAFETY NET: Preserve original enabled state if editing from different spec
    local currentSpecIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
    if currentSpecIndex and editorState.specIndex ~= currentSpecIndex then
        -- Restore original enabled state
        editorState.workingConfig.enabled = editorState.originalConfig.enabled
    end

    -- Validate all fields
    if not Validation:ValidateAllFields(editorState) then
        return
    end

    -- Update metadata
    editorState.workingConfig.lastModified = time()
    editorState.workingConfig.lastModifiedBy = StringUtil.GetBattleTagName(StringUtil.GetBattleTag())
    editorState.workingConfig.userModified = true

    -- Set edit source (always aplProto since we're visual-only)
    editorState.workingConfig._lastEditSource = "aplProto"
    NAG:Debug("[ROT-SYNC] SaveRotation: Setting _lastEditSource=aplProto")

    -- workingConfig.aplProto is already the source of truth - no sync needed
    if not editorState.workingConfig.aplProto then
        NAG:Warn("[ROT-SYNC] SaveRotation: WARNING - workingConfig.aplProto is nil before save")
    end

    NAG:Debug("[ROT-SYNC] SaveRotation: Calling classModule:SaveRotation | specIndex=%s | rotationName=%s",
        tostring(editorState.specIndex), editorState.rotationName)
    -- Save to class module
    local success = editorState.classModule:SaveRotation(
        editorState.specIndex,
        editorState.rotationName,
        editorState.workingConfig
    )
    if success then
        NAG:Info("[ROT-SYNC] SaveRotation: SUCCESS | specIndex=%s | rotationName=%s",
            tostring(editorState.specIndex), editorState.rotationName)
    else
        NAG:Error("[ROT-SYNC] SaveRotation: FAILED | specIndex=%s | rotationName=%s",
            tostring(editorState.specIndex), editorState.rotationName)
    end

    if not success then
        NAG:Error("Failed to save rotation")
        return
    end

    -- Check if we can activate this rotation (must match current spec)
    local currentSpecIndex = SpecCompat and SpecCompat:GetCurrentSpecIndex()
    local canActivate = currentSpecIndex and currentSpecIndex == editorState.specIndex
    local activationMessage = ""

    -- Invalidate and conditionally reactivate rotation
    local rotationManager = EditorUtils.GetRotationManager()
    if rotationManager then
        rotationManager:InvalidateRotation(editorState.specIndex, editorState.rotationName)

        -- Only activate if rotation spec matches current spec
        if canActivate then
            local cacheSuccess, cacheErr = rotationManager:SetActiveRotation(editorState.specIndex, editorState.rotationName)
            if cacheSuccess then
                activationMessage = " and activated"
            else
                NAG:Warn("Rotation saved but failed to activate: " .. tostring(cacheErr))
                activationMessage = " (not activated - activation failed)"
            end
        else
            activationMessage = " (not activated - different spec)"
        end

        -- Notify and refresh
        AceConfigRegistry:NotifyChange("NAG")
        rotationManager:RefreshRotationList()
    end

    -- Provide detailed feedback about what was saved
    local savedComponents = {}
    if editorState.workingConfig.customConditions and #editorState.workingConfig.customConditions > 0 then
        tinsert(savedComponents, format("%d conditions", #editorState.workingConfig.customConditions))
    end
    if editorState.workingConfig.spellLocations and next(editorState.workingConfig.spellLocations) then
        local count = 0
        for _ in pairs(editorState.workingConfig.spellLocations) do count = count + 1 end
        tinsert(savedComponents, format("%d spell locations", count))
    end
    if editorState.workingConfig.spells and #editorState.workingConfig.spells > 0 then
        tinsert(savedComponents, format("%d tracked spells", #editorState.workingConfig.spells))
    end
    if editorState.workingConfig.consumables and next(editorState.workingConfig.consumables) then
        tinsert(savedComponents, "consumables")
    end
    if editorState.workingConfig.glyphs and (editorState.workingConfig.glyphs.major or editorState.workingConfig.glyphs.minor) then
        local majorCount = editorState.workingConfig.glyphs.major and #editorState.workingConfig.glyphs.major or 0
        local minorCount = editorState.workingConfig.glyphs.minor and #editorState.workingConfig.glyphs.minor or 0
        if majorCount > 0 or minorCount > 0 then
            tinsert(savedComponents, format("glyphs (%d major, %d minor)", majorCount, minorCount))
        end
    end

    local saveMessage = "|cFF00FF00Rotation saved successfully" .. activationMessage .. "!|r"
    if #savedComponents > 0 then
        saveMessage = saveMessage .. "\n|cFFFFD100Saved: " .. table.concat(savedComponents, ", ") .. "|r"
    end
    NAG:Print(saveMessage)

    editorState.isDirty = false

    -- Update frame title to remove asterisk
    if editorState.mainFrame and editorState.rotationName then
        editorState.mainFrame:SetTitle((L["editRotation"] or "Edit Rotation") .. ": " .. editorState.rotationName)
    end

    -- DO NOT close the editor - let user continue editing or close manually
end

-- ~~~~~~~~~~ RENAME FUNCTIONALITY ~~~~~~~~~~

--- Show rename dialog for the current rotation
--- @param editorState table The editor state for this instance
function RotationEditor:ShowRenameDialog(editorState)
    if not editorState.rotationName or not editorState.specIndex or not editorState.classModule then
        NAG:Error("Cannot rename: editor state not initialized")
        return
    end

    StaticPopupDialogs["NAG_ROTATION_RENAME"] = {
        text = L["renameRotation"] or "Enter new name for rotation:",
        button1 = ACCEPT,
        button2 = CANCEL,
        hasEditBox = true,
        editBoxWidth = 250,
        maxLetters = 100,
        enterClicksFirstButton = true,
        OnShow = function(dialog)
            dialog:SetFrameStrata("FULLSCREEN_DIALOG")
            dialog:SetFrameLevel(200)
            local editBox = dialog:GetEditBox()
            if editBox then
                editBox:SetText(editorState.rotationName)
                editBox:HighlightText()
                editBox:SetFocus()
            end
        end,
        OnAccept = function(dialog)
            local editBox = dialog:GetEditBox()
            local newName = editBox and editBox:GetText() or ""
            if newName and newName ~= "" and newName ~= editorState.rotationName then
                self:RenameRotation(newName, editorState)
            end
        end,
        EditBoxOnEnterPressed = function(dialog)
            StaticPopup_OnClick(dialog:GetParent(), 1)
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }
    StaticPopup_Show("NAG_ROTATION_RENAME")
end

--- Rename the current rotation
--- @param newName string The new name for the rotation
--- @param editorState table The editor state for this instance
function RotationEditor:RenameRotation(newName, editorState)
    -- Validate new name doesn't conflict
    if editorState.classModule:HasRotation(editorState.specIndex, newName) then
        NAG:Error(format("Rotation '%s' already exists", newName))
        return
    end

    -- Save current working config with old name first
    local oldName = editorState.rotationName
    editorState.workingConfig.name = newName
    editorState.workingConfig.userModified = true
    editorState.workingConfig.lastModified = time()
    editorState.workingConfig.lastModifiedBy = StringUtil.GetBattleTagName(StringUtil.GetBattleTag())

    -- Save with new name
    local success = editorState.classModule:SaveRotation(editorState.specIndex, newName, editorState.workingConfig)
    if not success then
        NAG:Error("Failed to save rotation with new name")
        return
    end

    -- Delete old rotation
    editorState.classModule:DeleteRotation(editorState.specIndex, oldName)

    -- Update selectedRotations if this rotation was selected
    local selectedRotation = editorState.classModule:GetSelectedRotation(editorState.specIndex)
    if selectedRotation == oldName then
        editorState.classModule:SetSelectedRotation(editorState.specIndex, newName)
    end

    NAG:Print(format("|cFF00FF00Rotation renamed from '%s' to '%s'|r", oldName, newName))

    -- Update edit state
    editorState.rotationName = newName
    editorState.originalConfig.name = newName

    -- Close editor and refresh
    if editorState.mainFrame then
        editorState.mainFrame:Hide()
    end

    local rotationManager = EditorUtils.GetRotationManager()
    if rotationManager then
        rotationManager:RefreshRotationList()
    end
end

return RotationEditor
