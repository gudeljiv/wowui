--- @module "RotationEditor.EditorUtils"
--- Utility functions for RotationEditor
--- License: CC BY-NC 4.0
--- Authors: Rakizi, Fonsas

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- Localizations
local L = ns.AceLocale:GetLocale("NAG", true)
local WoWAPI = ns.WoWAPI
local SpellbookManager = NAG:GetModule("SpellbookManager")
local GetItemIcon = C_Item and C_Item.GetItemIconByID or _G.GetItemIcon

-- Lua APIs
local format = string.format
local date = date
local tostring = tostring
local tonumber = tonumber
local type = type
local pairs = pairs
local ipairs = ipairs
local tinsert = tinsert

-- Proto-compatible AST system
local ASTCore = ns.ASTCore
local ASTAction = ns.ASTAction
local ASTValue = ns.ASTValue
local ASTSchemaEmitter = ns.ASTSchemaEmitter

-- ~~~~~~~~~~ MODULE DEFINITION ~~~~~~~~~~

local EditorUtils = {}
ns.RotationEditorUtils = EditorUtils


-- ============================ FAKE CLAUSE INDEX CONSTANTS ============================
--TODO: i think we can remove these and just use the real indices
--- Fake clause index constants for group actions and variables
--- Group actions use indices 999000-999899 (base + groupIdx*100 + actionIdx)
--- Variables use indices 999900+ (base + varIdx)
EditorUtils.FAKE_INDEX_GROUP_ACTION_BASE = 999000
EditorUtils.FAKE_INDEX_VARIABLE_BASE = 999900
EditorUtils.FAKE_INDEX_GROUP_ACTION_MAX = 999899

-- ============================ FAKE CLAUSE INDEX HELPERS ============================

--- Check if clause index is a fake index (group action or variable)
--- @param idx number Clause index
--- @return boolean True if fake index
function EditorUtils.IsFakeClauseIndex(idx)
    return idx >= EditorUtils.FAKE_INDEX_GROUP_ACTION_BASE
end

--- Check if clause index represents a group action
--- @param idx number Clause index
--- @return boolean True if group action
function EditorUtils.IsGroupActionIndex(idx)
    return idx >= EditorUtils.FAKE_INDEX_GROUP_ACTION_BASE and idx < EditorUtils.FAKE_INDEX_VARIABLE_BASE
end

--- Check if clause index represents a variable
--- @param idx number Clause index
--- @return boolean True if variable
function EditorUtils.IsVariableIndex(idx)
    return idx >= EditorUtils.FAKE_INDEX_VARIABLE_BASE
end

--- Create fake clause index for group action
--- @param groupIdx number Group index (1-based)
--- @param actionIdx number Action index within group (1-based)
--- @return number Fake clause index
function EditorUtils.CreateGroupActionIndex(groupIdx, actionIdx)
    return EditorUtils.FAKE_INDEX_GROUP_ACTION_BASE + (groupIdx * 100) + actionIdx
end

--- Create fake clause index for variable
--- @param varIdx number Variable index (1-based)
--- @return number Fake clause index
function EditorUtils.CreateVariableIndex(varIdx)
    return EditorUtils.FAKE_INDEX_VARIABLE_BASE + varIdx
end

--- Decode group action fake index
--- @param clauseIdx number Fake clause index
--- @return number|nil groupIdx Group index or nil if not group action
--- @return number|nil actionIdx Action index or nil if not group action
function EditorUtils.DecodeGroupActionIndex(clauseIdx)
    if not EditorUtils.IsGroupActionIndex(clauseIdx) then
        return nil, nil
    end
    local remainder = clauseIdx - EditorUtils.FAKE_INDEX_GROUP_ACTION_BASE
    local groupIdx = math.floor(remainder / 100)
    local actionIdx = remainder % 100
    return groupIdx, actionIdx
end

--- Decode variable fake index
--- @param clauseIdx number Fake clause index
--- @return number|nil varIdx Variable index or nil if not variable
function EditorUtils.DecodeVariableIndex(clauseIdx)
    if not EditorUtils.IsVariableIndex(clauseIdx) then
        return nil
    end
    return clauseIdx - EditorUtils.FAKE_INDEX_VARIABLE_BASE
end

-- ============================ ICON HELPERS ============================

--- Get icon ID for a spell or item
--- @param id number|string Spell or item ID
--- @return number|nil Icon ID or nil if not found
function EditorUtils.GetIconForID(id)
    if not id then return nil end
    local numId = tonumber(id)
    if not numId then return nil end

    -- Try spell first
    local spellInfo = WoWAPI.GetSpellInfo(numId)
    if spellInfo and spellInfo.iconID then
        return spellInfo.iconID
    end

    -- Try item
    local _, _, _, _, _, _, _, _, _, itemIcon = WoWAPI.GetItemInfo(numId)
    return itemIcon
end

--- Format SchemaEmitter output with different display modes
---
--- **UI Usage**: Helper function used by `GetClauseSchemaEmitterOutput` to format raw APL syntax
--- (e.g., "NAG:Cast(12345)") into human-readable formats with spell/item names and icons.
---
--- **Output Format**: Transforms APL syntax by replacing numeric IDs with formatted displays:
--- - "icon": Icon texture tags only (e.g., "|T123:14:14|t")
--- - "name_id": Spell/item name with ID (e.g., "|cFF00FF00Spell Name|r (12345)")
--- - "verbose": Icon + name (e.g., "|T123:14:14|t |cFF00FF00Spell Name|r")
---
--- **Called By**: `GetClauseSchemaEmitterOutput` (for tooltips)
---
--- @param emitted string Raw SchemaEmitter output (e.g., "NAG:Cast(12345)")
--- @param mode string|nil Format mode: "icon" (icon only), "name_id" (name with ID), "verbose" (icon + name), or nil (default: "name_id")
--- @return string Formatted output with spell/item names and icons
function EditorUtils.FormatSchemaEmitterOutput(emitted, mode)
    if not emitted or emitted == "" then
        return emitted
    end

    local formatted = emitted
    mode = mode or "name_id"  -- Default to name+ID mode

    -- Remove "NAG:" prefix from function calls
    formatted = formatted:gsub("NAG:", "")

    -- Remove "NAG.Types." prefix from enum values
    formatted = formatted:gsub("NAG%.Types%.", "")

    -- Replace spell/item IDs based on mode
    -- Pattern: Match function calls with numeric IDs (e.g., "CastSpell(12345)" or "CastSpell(12345, arg2)")
    formatted = formatted:gsub("([%w_]+)%(([%d, ]+)%)", function(funcName, argsStr)
        -- Split arguments by comma
        local args = {}
        for arg in argsStr:gmatch("([^,]+)") do
            arg = arg:match("^%s*(.-)%s*$") -- Trim whitespace
            tinsert(args, arg)
        end

        -- Process each argument - replace numeric IDs based on mode
        local formattedArgs = {}
        for i, arg in ipairs(args) do
            local numId = tonumber(arg)
            if numId and numId > 0 and numId < 1000000 then
                -- Likely a spell/item ID (reasonable range)
                -- Try to get spell/item name
                local spellInfo = WoWAPI.GetSpellInfo(numId)
                local spellName = nil
                if spellInfo then
                    if type(spellInfo) == "table" then
                        spellName = spellInfo.name
                    else
                        spellName = spellInfo
                    end
                end

                if not spellName then
                    -- Try as item
                    local itemName = WoWAPI.GetItemInfo(numId)
                    if itemName then
                        spellName = itemName
                    end
                end

                if spellName then
                    local icon = EditorUtils.GetIconForID(numId)

                    if mode == "icon" then
                        -- Icon only mode
                        if icon then
                            tinsert(formattedArgs, format("|T%d:14:14|t", icon))
                        else
                            tinsert(formattedArgs, arg)  -- Fallback to ID if no icon
                        end
                    elseif mode == "name_id" then
                        -- Name with ID in parentheses, colorize spell name
                        tinsert(formattedArgs, format("|cFF00FF00%s|r (%s)", spellName, arg))
                    elseif mode == "verbose" then
                        -- Verbose mode: icon + name (colorized)
                        if icon then
                            tinsert(formattedArgs, format("|T%d:14:14|t |cFF00FF00%s|r", icon, spellName))
                        else
                            tinsert(formattedArgs, format("|cFF00FF00%s|r", spellName))
                        end
                    else
                        -- Default: icon only
                        if icon then
                            tinsert(formattedArgs, format("|T%d:14:14|t", icon))
                        else
                            tinsert(formattedArgs, arg)  -- Fallback to ID if no icon
                        end
                    end
                else
                    -- Keep original ID if we couldn't find a name
                    tinsert(formattedArgs, arg)
                end
            else
                -- Not a numeric ID, keep as-is
                tinsert(formattedArgs, arg)
            end
        end

        return format("%s(%s)", funcName, table.concat(formattedArgs, ", "))
    end)

    return formatted
end

--- Get SchemaEmitter output for a clause's condition and action, or variable's value
---
--- **UI Usage**: Generates tooltip text (hover text) for:
--- - **Rotation Clauses** (left panel tree nodes) - shows full APL syntax on hover
--- - **Groups & Variables** (left panel tree nodes) - shows full APL syntax on hover
---
--- **Output Format**: Full APL syntax with formatted spell/item names:
--- - For clauses: "Condition: [condition APL]\nAction: [action APL]"
--- - For variables: "Value: [value APL]"
--- - Uses `FormatSchemaEmitterOutput` to format IDs with names/icons based on mode
---
--- **Called By**:
--- - `ASTEditor:SetupClauseTooltips` (for Rotation Clauses tooltips)
--- - `ASTEditor:SetupVariableTooltips` (for Groups & Variables tooltips)
---
--- **Related Functions**:
--- - `FormatSchemaEmitterOutput` - formats the raw APL syntax
--- - `GetClauseActionSummary` - generates left panel list text (different format)
--- - `FormatActionNode` - generates Node Details panel text (different format)
---
--- @param clause table Clause data (list item from aplProto.priority_list) or variable data
--- @param mode string|boolean|nil Format mode: "icon" (icon only), "name_id" (name with ID), "verbose" (icon + name), true/"verbose" (verbose), false/nil (name_id default)
--- @return string|nil SchemaEmitter output (APL syntax) or nil if unavailable
function EditorUtils.GetClauseSchemaEmitterOutput(clause, mode)

    if not clause then
        NAG:Warn("[EditorUtils] GetClauseSchemaEmitterOutput: clause is nil - returning nil")
        return nil
    end

    if not ASTSchemaEmitter then
        NAG:Warn("[EditorUtils] GetClauseSchemaEmitterOutput: ASTSchemaEmitter not available")
        return "(SchemaEmitter unavailable)"
    end

    local parts = {}

    -- Normalize mode parameter (handle boolean for backward compatibility)
    local formatMode = mode
    if mode == true then
        formatMode = "name_id"
    elseif mode == false or mode == nil then
        formatMode = "icon"  -- Default to icon-only mode
    end

    -- Check if this is a variable (has 'value' field but no 'action' field)
    local isVariable = clause.value ~= nil and clause.action == nil

    if isVariable then
        -- Handle variable: parse value string to get condition AST
        local valueString = clause.value
        if not valueString or valueString == "" then
            return "(empty variable)"
        end

        -- Try to parse the value string to get AST using ParseClause for consistency
        local NAGStringParser = NAG:GetModule("NAGStringParser")
        local conditionAST = nil
        if NAGStringParser then
            local clauseResult = NAGStringParser:ParseClause(valueString, nil, nil)
            if clauseResult then
                -- Extract value from clause result (could be in value or condition field)
                conditionAST = clauseResult.value or clauseResult.condition
            end
        end

        if conditionAST and conditionAST.type == ASTCore.NodeType.VALUE then
            local conditionText = ASTSchemaEmitter.EmitValueNode(conditionAST) or ""
            if conditionText and conditionText ~= "" then
                conditionText = EditorUtils.FormatSchemaEmitterOutput(conditionText, formatMode)
                tinsert(parts, format("Value: %s", conditionText))
            else
                -- Fallback to raw value string if parsing/emission failed
                tinsert(parts, format("Value: %s", valueString))
            end
        else
            -- Fallback to raw value string if parsing failed
            tinsert(parts, format("Value: %s", valueString))
        end

        if #parts == 0 then
            return "(no value)"
        end

        return table.concat(parts, "\n")
    end

    -- Handle clause: has action (may have condition)
    local action = clause.action
    if not action then
        return "(empty action)"
    end

    -- Get and emit condition if present
    local conditionAST = nil
    if ASTAction and ASTAction.HasCondition and ASTAction.HasCondition(action) then
        conditionAST = ASTAction.GetCondition(action)
    end

    if conditionAST and conditionAST.type == ASTCore.NodeType.VALUE then
        local conditionText = ASTSchemaEmitter.EmitValueNode(conditionAST) or ""
        if conditionText and conditionText ~= "" then
            conditionText = EditorUtils.FormatSchemaEmitterOutput(conditionText, formatMode)
            tinsert(parts, format("Condition: %s", conditionText))
        end
    end

    -- Get and emit action
    if action.type == ASTCore.NodeType.ACTION then
        local actionText = ASTSchemaEmitter.EmitActionNode(action) or ""
        if actionText and actionText ~= "" then
            actionText = EditorUtils.FormatSchemaEmitterOutput(actionText, formatMode)
            tinsert(parts, format("Action: %s", actionText))
        elseif action.parseError then
            tinsert(parts, "Action: (parse error)")
        else
            tinsert(parts, "Action: (no output)")
        end
    else
        -- Action might be invalid or missing - check if we at least have a condition
        if #parts == 0 then
            tinsert(parts, "Action: (invalid action type)")
        end
    end

    if #parts == 0 then
        return "(no output)"
    end

    return table.concat(parts, "\n")
end

-- ============================ NODE DETAIL LOOKUP ============================

--- Unified node lookup helper to consolidate lookup logic
--- @param editorData table Editor data with nodeDetails and nodeDetailsByUniqueValue
--- @param nodeId string Node ID to look up
--- @param group string|nil Optional full group path (may include \001 separators)
--- @param returnLookupMethod boolean|nil If true, returns lookup method as second value
--- @return table|nil Node detail or nil
--- @return string|nil Lookup method used or nil (if returnLookupMethod is false)
function EditorUtils.FindNodeDetail(editorData, nodeId, group, returnLookupMethod)
    if not editorData or not nodeId then
        NAG:Debug("[EditorUtils.FindNodeDetail] Invalid input: editorData=%s, nodeId=%s, group=%s",
            editorData and "table" or "nil", tostring(nodeId), group and tostring(group) or "nil")
        return nil, nil
    end

    returnLookupMethod = returnLookupMethod or false

    -- Debug: Log available data structures for diagnosis
    local hasNodeDetails = editorData.nodeDetails ~= nil
    local hasNodeDetailsByUniqueValue = editorData.nodeDetailsByUniqueValue ~= nil
    local nodeDetailsCount = hasNodeDetails and (function()
        local count = 0
        for _ in pairs(editorData.nodeDetails) do count = count + 1 end
        return count
    end)() or 0
    local uniqueValueCount = hasNodeDetailsByUniqueValue and (function()
        local count = 0
        for _ in pairs(editorData.nodeDetailsByUniqueValue) do count = count + 1 end
        return count
    end)() or 0

    NAG:Trace("[EditorUtils.FindNodeDetail] Starting lookup: nodeId=%s, group=%s, hasNodeDetails=%s (count=%d), hasNodeDetailsByUniqueValue=%s (count=%d)",
        tostring(nodeId), group and tostring(group):gsub("\001", " → ") or "nil",
        tostring(hasNodeDetails), nodeDetailsCount, tostring(hasNodeDetailsByUniqueValue), uniqueValueCount)

    -- Try direct nodeId lookup
    if editorData.nodeDetails and editorData.nodeDetails[nodeId] then
        NAG:Trace("[EditorUtils.FindNodeDetail] Found via nodeDetails[nodeId]: nodeId=%s", tostring(nodeId))
        if returnLookupMethod then
            return editorData.nodeDetails[nodeId], "nodeDetails[nodeId]"
        end
        return editorData.nodeDetails[nodeId]
    end

    -- Try uniqueValue lookup with nodeId (in case it's already a uniqueValue path)
    if editorData.nodeDetailsByUniqueValue and editorData.nodeDetailsByUniqueValue[nodeId] then
        NAG:Trace("[EditorUtils.FindNodeDetail] Found via nodeDetailsByUniqueValue[nodeId]: nodeId=%s", tostring(nodeId))
        if returnLookupMethod then
            return editorData.nodeDetailsByUniqueValue[nodeId], "nodeDetailsByUniqueValue[nodeId]"
        end
        return editorData.nodeDetailsByUniqueValue[nodeId]
    end

    -- Try uniqueValue lookup with full path (if group provided)
    if group and editorData.nodeDetailsByUniqueValue and editorData.nodeDetailsByUniqueValue[group] then
        NAG:Trace("[EditorUtils.FindNodeDetail] Found via nodeDetailsByUniqueValue[group]: nodeId=%s, group=%s",
            tostring(nodeId), tostring(group):gsub("\001", " → "))
        if returnLookupMethod then
            return editorData.nodeDetailsByUniqueValue[group], "nodeDetailsByUniqueValue[group]"
        end
        return editorData.nodeDetailsByUniqueValue[group]
    end

    -- Try searching for nodeId in uniqueValue paths
    -- uniqueValue paths are like "root\001root_act\001root_act_9" for nodeId "root_act_9"
    if editorData.nodeDetailsByUniqueValue and nodeId and not nodeId:find("\001") then
        local searchCount = 0
        local matchedUniqueValues = {}
        for uniqueValue, detail in pairs(editorData.nodeDetailsByUniqueValue) do
            searchCount = searchCount + 1
            if uniqueValue and type(uniqueValue) == "string" then
                -- Check if uniqueValue ends with nodeId (after \001 separator or as exact match)
                if uniqueValue == nodeId or uniqueValue:match("\001" .. nodeId:gsub("%-", "%%-") .. "$") then
                    tinsert(matchedUniqueValues, uniqueValue)
                    NAG:Trace("[EditorUtils.FindNodeDetail] Found via uniqueValue search: nodeId=%s, uniqueValue=%s",
                        tostring(nodeId), tostring(uniqueValue):gsub("\001", " → "))
                    if returnLookupMethod then
                        return detail, "uniqueValue search"
                    end
                    return detail
                end
            else
                NAG:Warn("[EditorUtils.FindNodeDetail] Invalid key type in nodeDetailsByUniqueValue: type=%s, key=%s, valueType=%s",
                    type(uniqueValue), tostring(uniqueValue), detail and type(detail) or "nil")
            end
        end
        NAG:Debug("[EditorUtils.FindNodeDetail] Searched %d uniqueValue entries, found %d matches: nodeId=%s, matchedUniqueValues=%s",
            searchCount, #matchedUniqueValues, tostring(nodeId), #matchedUniqueValues > 0 and table.concat(matchedUniqueValues, ", ") or "none")
    else
        if not editorData.nodeDetailsByUniqueValue then
            NAG:Debug("[EditorUtils.FindNodeDetail] Skipping uniqueValue search: nodeDetailsByUniqueValue is nil")
        elseif not nodeId then
            NAG:Debug("[EditorUtils.FindNodeDetail] Skipping uniqueValue search: nodeId is nil")
        elseif nodeId:find("\001") then
            NAG:Debug("[EditorUtils.FindNodeDetail] Skipping uniqueValue search: nodeId contains separator: nodeId=%s",
                tostring(nodeId))
        end
    end

    -- Node not found - provide comprehensive diagnostic info
    NAG:Debug("[EditorUtils.FindNodeDetail] Node not found after all lookup attempts: nodeId=%s, group=%s, hasNodeDetails=%s, hasNodeDetailsByUniqueValue=%s, nodeDetailsCount=%d, uniqueValueCount=%d",
        tostring(nodeId), group and tostring(group):gsub("\001", " → ") or "nil",
        tostring(hasNodeDetails), tostring(hasNodeDetailsByUniqueValue), nodeDetailsCount, uniqueValueCount)
    if returnLookupMethod then
        return nil, nil
    end
    return nil
end

-- ~~~~~~~~~~ HELPER FUNCTIONS ~~~~~~~~~~

--- Deep copy a table
--- @param orig table The table to copy
--- @return table The copied table
function EditorUtils.CopyTable(orig)
    if type(orig) ~= "table" then return orig end
    local copy = {}
    for k, v in pairs(orig) do
        if type(v) == "table" then
            copy[k] = EditorUtils.CopyTable(v)
        else
            copy[k] = v
        end
    end
    return copy
end

--- Mark edit state as dirty and update frame title
--- @param editorState table The editor state for this instance
function EditorUtils.MarkDirty(editorState)
    if not editorState then
        NAG:Warn("[RotationEditor] MarkDirty called without an editor state")
        return
    end

    editorState.isDirty = true
    -- Update frame title to show unsaved changes
    if editorState.mainFrame and editorState.rotationName then
        editorState.mainFrame:SetTitle((L["editRotation"] or "Edit Rotation") .. ": " .. editorState.rotationName .. " |cFFFF8000*|r")
    end
end

--- Get RotationManager module
--- @return table|nil RotationManager module
function EditorUtils.GetRotationManager()
    return NAG:GetModule("RotationManager")
end

-- ============================ CLAUSE EDITOR DATA ACCESS ============================

--- Get clause editor data for a clause index (handles regular clauses, group actions, and variables)
--- @param editorState table The editor state
--- @param clauseIdx number Clause index (may be fake index for group actions or variables)
--- @return table|nil Editor data for the clause or nil
function EditorUtils.GetClauseEditorData(editorState, clauseIdx)
    if not editorState then
        NAG:Debug("[EditorUtils.GetClauseEditorData] Invalid editorState: nil, clauseIdx=%s", tostring(clauseIdx))
        return nil
    end

    if clauseIdx == nil then
        NAG:Debug("[EditorUtils.GetClauseEditorData] Invalid clauseIdx: nil, editorState=%s", editorState and "table" or "nil")
        return nil
    end

    -- Debug: Log available data structures for diagnosis
    local hasClauseEditors = editorState.clauseEditors ~= nil
    local hasGroupActionEditors = editorState.groupActionEditors ~= nil
    local hasVariableEditors = editorState.variableEditors ~= nil

    NAG:Trace("[EditorUtils.GetClauseEditorData] Starting lookup: clauseIdx=%s, hasClauseEditors=%s, hasGroupActionEditors=%s, hasVariableEditors=%s",
        tostring(clauseIdx), tostring(hasClauseEditors), tostring(hasGroupActionEditors), tostring(hasVariableEditors))

    -- Check if this is a variable
    if EditorUtils.IsVariableIndex(clauseIdx) then
        local varIdx = EditorUtils.DecodeVariableIndex(clauseIdx)
        local editorData = editorState.variableEditors and editorState.variableEditors[varIdx]
        NAG:Trace("[EditorUtils.GetClauseEditorData] Variable editor data: clauseIdx=%s, varIdx=%s, found=%s, hasVariableEditors=%s",
            tostring(clauseIdx), tostring(varIdx), editorData and "yes" or "no", tostring(hasVariableEditors))
        if not editorData and hasVariableEditors then
            local varCount = 0
            for _ in pairs(editorState.variableEditors) do varCount = varCount + 1 end
            NAG:Debug("[EditorUtils.GetClauseEditorData] Variable editor data not found: clauseIdx=%s, varIdx=%s, variableEditorsCount=%d",
                tostring(clauseIdx), tostring(varIdx), varCount)
        end
        return editorData
    end

    -- Check if this is a group action
    if EditorUtils.IsGroupActionIndex(clauseIdx) then
        local groupIdx, actionIdx = EditorUtils.DecodeGroupActionIndex(clauseIdx)
        local actionKey = "group_" .. groupIdx .. "_action_" .. actionIdx
        local editorData = editorState.groupActionEditors and editorState.groupActionEditors[actionKey]
        NAG:Trace("[EditorUtils.GetClauseEditorData] Group action editor data: clauseIdx=%s, groupIdx=%s, actionIdx=%s, actionKey=%s, found=%s, hasGroupActionEditors=%s",
            tostring(clauseIdx), tostring(groupIdx), tostring(actionIdx), actionKey, editorData and "yes" or "no", tostring(hasGroupActionEditors))
        if not editorData and hasGroupActionEditors then
            local groupCount = 0
            for _ in pairs(editorState.groupActionEditors) do groupCount = groupCount + 1 end
            NAG:Debug("[EditorUtils.GetClauseEditorData] Group action editor data not found: clauseIdx=%s, groupIdx=%s, actionIdx=%s, actionKey=%s, groupActionEditorsCount=%d",
                tostring(clauseIdx), tostring(groupIdx), tostring(actionIdx), actionKey, groupCount)
        end
        return editorData
    end

    -- Regular clause
    local editorData = editorState.clauseEditors and editorState.clauseEditors[clauseIdx]
    NAG:Trace("[EditorUtils.GetClauseEditorData] Regular clause editor data: clauseIdx=%s, found=%s, hasClauseEditors=%s",
        tostring(clauseIdx), editorData and "yes" or "no", tostring(hasClauseEditors))
    if not editorData then
        if hasClauseEditors then
            local clauseCount = 0
            for _ in pairs(editorState.clauseEditors) do clauseCount = clauseCount + 1 end
            NAG:Debug("[EditorUtils.GetClauseEditorData] Clause editor data not found: clauseIdx=%s, clauseEditorsCount=%d, clauseIdxType=%s",
                tostring(clauseIdx), clauseCount, type(clauseIdx))
        else
            NAG:Debug("[EditorUtils.GetClauseEditorData] Clause editor data not found: clauseIdx=%s, clauseEditors is nil",
                tostring(clauseIdx))
        end
    end
    return editorData
end

-- ============================ ACTION DISPLAY NAME RESOLUTION ============================

--- Resolve action display name from metadata
--- @param metadata table Action metadata from SchemaAccessor
--- @return string Display name for the action
function EditorUtils.ResolveActionDisplayName(metadata)
    if not metadata then
        NAG:Debug("[EditorUtils.ResolveActionDisplayName] No metadata provided")
        return L["unknownAction"] or "Unknown Action"
    end

    -- Debug: Log available metadata fields for diagnosis
    local hasNagFunctionName = metadata.nagFunctionName ~= nil
    local hasNagName = metadata.nagName ~= nil
    local hasName = metadata.name ~= nil
    local hasActionType = metadata.actionType ~= nil
    local hasProtoName = metadata.protoName ~= nil

    NAG:Trace("[EditorUtils.ResolveActionDisplayName] Starting resolution: hasNagFunctionName=%s, hasNagName=%s, hasName=%s, hasActionType=%s, hasProtoName=%s",
        tostring(hasNagFunctionName), tostring(hasNagName), tostring(hasName), tostring(hasActionType), tostring(hasProtoName))

    local name = metadata.nagFunctionName or metadata.nagName
    if (not name or name == "") and metadata.name then
        -- Use name field (from GetAllActionsWithMetadata) or actionType (from GetMetadataByIdentifier)
        local identifier = metadata.name or metadata.actionType
        if identifier then
            local SchemaUtils = ns.SchemaUtils
            if SchemaUtils and SchemaUtils.SnakeToPascal then
                local converted = SchemaUtils:SnakeToPascal(identifier)
                if converted then
                    name = converted
                    NAG:Trace("[EditorUtils.ResolveActionDisplayName] Converted identifier to PascalCase: identifier=%s, name=%s",
                        identifier, name)
                else
                    NAG:Debug("[EditorUtils.ResolveActionDisplayName] SnakeToPascal conversion failed: identifier=%s, identifierType=%s",
                        identifier, type(identifier))
                    name = identifier
                end
            else
                NAG:Debug("[EditorUtils.ResolveActionDisplayName] SchemaUtils not available for conversion: identifier=%s, SchemaUtils=%s",
                    identifier, SchemaUtils and "available" or "nil")
                name = identifier
            end
        else
            NAG:Debug("[EditorUtils.ResolveActionDisplayName] No identifier available: metadata.name=%s, metadata.actionType=%s",
                tostring(metadata.name), tostring(metadata.actionType))
        end
    end

    if (not name or name == "") and metadata.protoName then
        NAG:Trace("[EditorUtils.ResolveActionDisplayName] Using protoName as fallback: protoName=%s", metadata.protoName)
        name = metadata.protoName
    end

    -- Warn if both nagFunctionName and nagName are nil (schema issue)
    if not name or name == "" then
        if not metadata.nagFunctionName and not metadata.nagName then
            local SchemaAccessor = NAG:GetModule("SchemaAccessor")
            if SchemaAccessor then
                SchemaAccessor:Warn("[EditorUtils.ResolveActionDisplayName] Missing nagFunctionName and nagName for action '%s' - schema may be incomplete. Available fields: name=%s, actionType=%s, protoName=%s",
                    tostring(metadata.name or metadata.actionType or "unknown"),
                    tostring(metadata.name), tostring(metadata.actionType), tostring(metadata.protoName))
            else
                NAG:Debug("[EditorUtils.ResolveActionDisplayName] SchemaAccessor not available for warning")
            end
        end
        NAG:Debug("[EditorUtils.ResolveActionDisplayName] Could not resolve display name, returning unknown: nagFunctionName=%s, nagName=%s, name=%s, actionType=%s, protoName=%s",
            tostring(metadata.nagFunctionName), tostring(metadata.nagName), tostring(metadata.name),
            tostring(metadata.actionType), tostring(metadata.protoName))
        return L["unknownAction"] or "Unknown Action"
    end

    local source = metadata.nagFunctionName and "nagFunctionName" or
                   (metadata.nagName and "nagName" or
                   (metadata.name and "name" or "protoName"))
    NAG:Trace("[EditorUtils.ResolveActionDisplayName] Resolved display name: name=%s, source=%s",
        name, source)
    return name
end

-- ============================ ACTION METADATA RESOLUTION ============================

--- Resolve action metadata from AST node
--- @param node table AST node (proto AST)
--- @param nodeType string Node type ("action" or other)
--- @return table|nil Action metadata or nil
function EditorUtils.ResolveNodeActionMetadata(node, nodeType)
    -- Use SchemaAccessor:GetMetadataByIdentifier with auto-detection (single source of truth)
    if nodeType ~= "action" or type(node) ~= "table" then
        NAG:Debug("[EditorUtils.ResolveNodeActionMetadata] Invalid input: nodeType=%s, nodeTypeMatch=%s, node=%s, nodeType=%s",
            tostring(nodeType), tostring(nodeType == "action"), node and "table" or "nil", type(node))
        return nil
    end

    local SchemaAccessor = NAG:GetModule("SchemaAccessor")
    if not SchemaAccessor or not SchemaAccessor.GetMetadataByIdentifier then
        NAG:Debug("[EditorUtils.ResolveNodeActionMetadata] SchemaAccessor not available or missing GetMetadataByIdentifier: SchemaAccessor=%s, hasGetMetadataByIdentifier=%s",
            SchemaAccessor and "available" or "nil", SchemaAccessor and tostring(SchemaAccessor.GetMetadataByIdentifier ~= nil) or "N/A")
        return nil
    end

    -- Debug: Check node structure
    local nodeTypeField = node.type
    NAG:Trace("[EditorUtils.ResolveNodeActionMetadata] Node structure: nodeType=%s, node.type=%s, ASTCore.NodeType.ACTION=%s",
        tostring(nodeType), tostring(nodeTypeField), ASTCore and tostring(ASTCore.NodeType.ACTION) or "N/A")

    -- Use GetActionType directly (returns snake_case identifier)
    local identifier = nil
    if nodeType == "action" then
        if ASTAction and ASTAction.GetActionType then
            identifier = ASTAction.GetActionType(node)
            NAG:Trace("[EditorUtils.ResolveNodeActionMetadata] Extracted action type: identifier=%s, identifierType=%s",
                tostring(identifier), type(identifier))
        else
            NAG:Debug("[EditorUtils.ResolveNodeActionMetadata] ASTAction.GetActionType not available: ASTAction=%s",
                ASTAction and "available" or "nil")
        end
    end

    -- Get metadata using snake_case identifier
    if identifier then
        local isValidFormat = identifier:match("^[a-z][a-z0-9_]*$")
        NAG:Trace("[EditorUtils.ResolveNodeActionMetadata] Identifier validation: identifier=%s, isValidFormat=%s",
            tostring(identifier), tostring(isValidFormat ~= nil))

        if isValidFormat then
            local metadata = SchemaAccessor:GetMetadataByIdentifier(identifier, nil)  -- Use auto-detection
            if metadata then
                NAG:Trace("[EditorUtils.ResolveNodeActionMetadata] Resolved metadata: identifier=%s, actionType=%s, hasNagFunctionName=%s, hasNagName=%s",
                    identifier, tostring(metadata.actionType), tostring(metadata.nagFunctionName ~= nil), tostring(metadata.nagName ~= nil))
            else
                NAG:Debug("[EditorUtils.ResolveNodeActionMetadata] Metadata not found for identifier: identifier=%s, identifierType=%s",
                    identifier, type(identifier))
            end
            return metadata
        else
            NAG:Debug("[EditorUtils.ResolveNodeActionMetadata] Invalid identifier format: identifier=%s, identifierType=%s, expectedPattern=^[a-z][a-z0-9_]*$",
                tostring(identifier), type(identifier))
        end
    else
        NAG:Debug("[EditorUtils.ResolveNodeActionMetadata] No identifier extracted: nodeType=%s, ASTAction=%s, node=%s",
            tostring(nodeType), ASTAction and "available" or "nil", node and "table" or "nil")
    end

    return nil
end

--- Refresh the current tab (used after edits in sub-dialogs)
--- @param RotationEditor table RotationEditor instance
--- @param editorState table The editor state for this instance
function EditorUtils.RefreshCurrentTab(RotationEditor, editorState)
    if not editorState.mainFrame or not editorState.currentTab then
        return
    end

    -- Find the TabGroup widget and trigger a refresh
    local function FindTabGroup(widget)
        if widget.type == "TabGroup" then
            return widget
        end
        if widget.children then
            for _, child in ipairs(widget.children) do
                local found = FindTabGroup(child)
                if found then return found end
            end
        end
        return nil
    end

    local tabGroup = FindTabGroup(editorState.mainFrame)
    if tabGroup then
        tabGroup:SelectTab(editorState.currentTab)
    end
end

--- Check for unsaved changes and confirm close
--- @param editorState table The editor state for this instance
--- @return boolean True if safe to close, false if user cancelled
function EditorUtils.ConfirmClose(editorState)
    if not editorState.isDirty then
        return true
    end

    -- Show confirmation dialog
    local confirmed = false
    local dialogShown = false

    StaticPopupDialogs["NAG_ROTATION_EDITOR_UNSAVED"] = {
        text = L["rotationUnsavedChanges"] or "You have unsaved changes. Close anyway?",
        button1 = YES,
        button2 = NO,
        OnShow = function(dialog)
            dialog:SetFrameStrata("FULLSCREEN_DIALOG")
            dialog:SetFrameLevel(200)
        end,
        OnAccept = function()
            confirmed = true
        end,
        OnCancel = function()
            confirmed = false
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }

    StaticPopup_Show("NAG_ROTATION_EDITOR_UNSAVED")

    -- Wait for dialog result (this is synchronous in WoW)
    return confirmed
end

--- Format a timestamp as a date string
--- @param timestamp number Unix timestamp
--- @return string Formatted date
function EditorUtils.FormatDate(timestamp)
    if not timestamp then return L["rotationUnknown"] or "Unknown" end
    if type(timestamp) == "number" then
        return tostring(date("%Y-%m-%d %H:%M", timestamp))
    end
    return tostring(timestamp)
end

--- Format spell or item display with icon and name
--- @param id number|string The spell or item ID
--- @return string Formatted display string with icon and name
function EditorUtils.FormatSpellOrItemDisplay(id)
    if not id or id == "unknown" then
        return "unknown"
    end

    local numericId = tonumber(id)
    if not numericId then
        return tostring(id)
    end

    -- Try as spell first
    local spellInfo = WoWAPI.GetSpellInfo(numericId)
    if spellInfo then
        local spellName, spellIcon
        if type(spellInfo) == "table" then
            spellName = spellInfo.name
            spellIcon = spellInfo.iconID or spellInfo.originalIconID
        else
            spellName = spellInfo
        end

        if spellName then
            return format("|T%s:16:16|t %s |cFFAAAAFF(%s)|r",
                spellIcon or "Interface\\Icons\\INV_Misc_QuestionMark",
                spellName,
                id)
        end
    end

    -- Try as item
    local itemName, itemLink = WoWAPI.GetItemInfo(numericId)
    if itemName then
        local itemIcon = GetItemIcon(numericId)
        return format("|T%s:16:16|t %s |cFFAAAAFF(%s)|r",
            itemIcon or "Interface\\Icons\\INV_Misc_QuestionMark",
            itemName,
            id)
    end

    -- Not found - return ID with question mark icon
    return format("|TInterface\\Icons\\INV_Misc_QuestionMark:16:16|t |cFFFF6666Unknown|r |cFFAAAAFF(%s)|r", id)
end

--- Extract first argument ID from action node (spell_id or item_id)
--- @param actionNode table Action node (proto AST)
--- @param actionType string|nil Optional action type (if already known, avoids lookup)
--- @return number|nil First argument ID, or nil if not found
function EditorUtils.GetActionFirstArgID(actionNode, actionType)
    if not actionNode then
        return nil
    end

    -- Validate node type
    if actionNode.type ~= ASTCore.NodeType.ACTION then
        return nil
    end

    -- Get action type if not provided
    if not actionType then
        actionType = ASTAction and ASTAction.GetActionType(actionNode)
        if not actionType then
            return nil
        end
    end

    -- Get action data
    local actionData = ASTAction and ASTAction.GetActionData(actionNode)
    if not actionData then
        return nil
    end

    -- Extract spell_id or item_id using FieldFormatConverter
    local FieldFormatConverter = ns.FieldFormatConverter
    if FieldFormatConverter then
        -- Try spell_id first
        if actionData.spell_id then
            return FieldFormatConverter:ExtractActionID(actionData.spell_id)
        end
        -- Then try item_id
        if actionData.item_id then
            return FieldFormatConverter:ExtractActionID(actionData.item_id)
        end
    else
        -- Fallback to manual extraction if FieldFormatConverter unavailable
        NAG:Warn("[EditorUtils] FALLBACK TRACKING: Using manual extraction fallback in FormatActionNode() (FieldFormatConverter unavailable)")
        if actionData.spell_id then
            local spellIdData = actionData.spell_id
            return spellIdData.spell_id or spellIdData.id or spellIdData
        elseif actionData.item_id then
            return actionData.item_id
        end
    end

    return nil
end

--- Format a function call value node with enum-aware argument formatting
---
--- **UI Usage**: Formats function call value nodes (e.g., `DotIsActive(980)`, `RuneSlotCooldown(1)`)
--- for display in Node Details panel and tooltips when showing value expressions.
---
--- **Output Format**: Human-readable function call with formatted arguments:
--- - "FunctionName(arg1, arg2)" format
--- - Enum values shown as "EnumName (value)" (e.g., "RuneSlot (1)")
--- - Spell/item IDs shown with names (e.g., "Spell Name (12345)")
--- - Nested value nodes formatted recursively using `FormatValueNode`
---
--- **Called By**:
--- - `FormatValueNode` (for function call value types)
---
--- **Related Functions**:
--- - `FormatValueNode` - main formatter that calls this for function calls
--- - `FormatSpellOrItemDisplay` - formats spell/item IDs with names
---
--- @param valueNode table The value node (proto AST)
--- @param valueType string The function value type (e.g., "rune_slot_cooldown")
--- @param valueData table The value data containing function arguments
--- @return string Formatted function call (e.g., "DotIsActive(980)" or "RuneSlotCooldown(RuneSlot (1))")
function EditorUtils.FormatFunctionCallValue(valueNode, valueType, valueData)
    local SchemaAccessor = NAG:GetModule("SchemaAccessor")
    local SchemaUtils = ns.SchemaUtils

    if not valueType or not valueData then
        return "(unknown)"
    end

    -- Get function metadata from schema
    local metadata = nil
    if SchemaAccessor and SchemaAccessor.GetMetadataByIdentifier then
        local snakeName = valueType
        -- Ensure snake_case format
        if not snakeName:match("^[a-z][a-z0-9_]*$") then
            if SchemaUtils and SchemaUtils.CamelToSnake then
                local converted = SchemaUtils:CamelToSnake(valueType)
                if converted then
                    snakeName = converted
                else
                    snakeName = valueType:lower()
                end
            else
                snakeName = valueType:lower()
            end
        end

        if snakeName:match("^[a-z][a-z0-9_]*$") then
            metadata = SchemaAccessor:GetMetadataByIdentifier(snakeName, nil)  -- Use auto-detection
        end
    end

    -- Get function display name
    local functionName = nil
    if metadata then
        functionName = metadata.nagFunctionName or metadata.nagName or metadata.identifier
    end

    if not functionName then
        if SchemaUtils and SchemaUtils.SnakeToPascal then
            functionName = SchemaUtils:SnakeToPascal(valueType)
        end
        if not functionName then
            functionName = valueType
        end
    end

    -- Build arguments with enum awareness
    local arguments = {}

    if metadata and metadata.messageSchema and metadata.messageSchema.field_order and metadata.messageSchema.fields then
        -- Use schema field order for proper argument formatting
        local fieldOrder = metadata.messageSchema.field_order
        local fields = metadata.messageSchema.fields

        for _, fieldName in ipairs(fieldOrder) do
            local fieldInfo = fields[fieldName]
            local fieldValue = valueData[fieldName]

            if fieldValue ~= nil then
                local argStr = nil

                -- Check if field is an enum type
                if fieldInfo and fieldInfo.type == "enum" and fieldInfo.enum_type then
                    -- Format enum value with enum name
                    local SchemaAccessor = NAG:GetModule("SchemaAccessor")
                    if SchemaAccessor then
                        local enumLabel = SchemaAccessor:GetEnumLabel(fieldInfo.enum_type, fieldValue)
                        if enumLabel then
                            -- If value is already a string name matching the label, just show the label
                            -- Otherwise show "EnumName (value)" for numeric values
                            if type(fieldValue) == "string" and fieldValue == enumLabel then
                                argStr = enumLabel
                            elseif type(fieldValue) == "number" then
                                argStr = format("%s (%d)", enumLabel, fieldValue)
                            else
                                argStr = format("%s (%s)", enumLabel, tostring(fieldValue))
                            end
                        else
                            argStr = tostring(fieldValue)
                        end
                    else
                        argStr = tostring(fieldValue)
                    end
                elseif fieldInfo and fieldInfo.type == "message" then
                    -- Handle nested APLValue messages
                    if fieldInfo.message_type == "APLValue" then
                        if type(fieldValue) == "table" then
                            -- Check if it's a full wrapper node
                            if fieldValue.type == ASTCore.NodeType.VALUE then
                                argStr = EditorUtils.FormatValueNode(fieldValue)
                            else
                                -- Might be proto structure - try to reconstruct wrapper
                                local reconstructed = false
                                for protoValueType, protoValueData in pairs(fieldValue) do
                                    if protoValueData then
                                        local reconstructedNode = ASTValue.Create(protoValueType, protoValueData)
                                        if reconstructedNode then
                                            argStr = EditorUtils.FormatValueNode(reconstructedNode)
                                            reconstructed = true
                                            break
                                        end
                                    end
                                end
                                if not reconstructed then
                                    argStr = tostring(fieldValue)
                                end
                            end
                        else
                            argStr = tostring(fieldValue)
                        end
                    -- CRITICAL: Handle ActionID/SpellReference message types - extract the actual ID
                    elseif fieldInfo.message_type == "ActionID" or fieldInfo.message_type == "SpellReference" then
                        local FieldFormatConverter = ns.FieldFormatConverter
                        if FieldFormatConverter then
                            local extractedID = FieldFormatConverter:ExtractActionID(fieldValue)
                            if extractedID then
                                -- Format with spell/item name if available
                                argStr = EditorUtils.FormatSpellOrItemDisplay(extractedID)
                            else
                                argStr = tostring(fieldValue)
                            end
                        else
                            argStr = tostring(fieldValue)
                        end
                    -- CRITICAL: Handle UnitReference message types - extract the unit string or enum
                    elseif fieldInfo.message_type == "UnitReference" then
                        local FieldFormatConverter = ns.FieldFormatConverter
                        if FieldFormatConverter then
                            local extractedUnit = FieldFormatConverter:ExtractUnitReferenceForDisplay(fieldValue)
                            argStr = tostring(extractedUnit or fieldValue)
                        else
                            argStr = tostring(fieldValue)
                        end
                    else
                        argStr = tostring(fieldValue)
                    end
                else
                    -- Simple scalar value
                    argStr = tostring(fieldValue)
                end

                if argStr then
                    tinsert(arguments, argStr)
                end
            end
        end
    else
        -- Fallback: format all fields as-is (no schema available)
        for fieldName, fieldValue in pairs(valueData) do
            if fieldValue ~= nil then
                if type(fieldValue) == "table" and fieldValue.type == ASTCore.NodeType.VALUE then
                    tinsert(arguments, EditorUtils.FormatValueNode(fieldValue))
                else
                    tinsert(arguments, tostring(fieldValue))
                end
            end
        end
    end

    -- Format function call
    if #arguments > 0 then
        return format("%s(%s)", functionName, table.concat(arguments, ", "))
    else
        return format("%s()", functionName)
    end
end

--- Format a value node for display
---
--- **UI Usage**: Formats value nodes (conditions, comparisons, function calls, etc.) for display in:
--- - **Node Details panel** (right panel) - when showing condition/value fields
--- - **Tooltips** - when formatting nested value expressions
--- - **Argument rendering** - when displaying value arguments in action nodes
---
--- **Output Format**: Human-readable format for value expressions:
--- - Constants: "123" or "true"
--- - Math ops: "(A + B)"
--- - Comparisons: "(A == B)"
--- - Logical ops: "(A and B)" or "not A"
--- - Function calls: "DotIsActive(980)" or "VariableRef: variable-name"
--- - Enums: "EnumName (value)" when context provides enum type
---
--- **Called By**:
--- - `FormatActionNode` (for condition formatting)
--- - `FormatFunctionCallValue` (for nested value arguments)
--- - `ArgumentRenderer` (for value field display)
---
--- **Related Functions**:
--- - `FormatActionNode` - formats action nodes (uses this for conditions)
--- - `FormatFunctionCallValue` - formats function call value nodes (uses this recursively)
---
--- @param valueNode table The value node (proto AST)
--- @param context table|nil Optional context with enum type information
--- @return string Formatted value expression
function EditorUtils.FormatValueNode(valueNode, context)
    if not valueNode then return "nil" end

    -- Check proto AST first (preferred)
    if valueNode.type == ASTCore.NodeType.VALUE then
        -- Proto AST value node
        if ASTValue.IsConst(valueNode) then
            local constValue = ASTValue.GetConstValue(valueNode)
            -- Try to format as enum if context provides enum type
            if context and context.enumType and constValue ~= nil then
                local SchemaAccessor = NAG:GetModule("SchemaAccessor")
                if SchemaAccessor then
                    local enumLabel = SchemaAccessor:GetEnumLabel(context.enumType, constValue)
                    if enumLabel then
                        -- If value is already a string name matching the label, just show the label
                        -- Otherwise show "EnumName (value)" for numeric values
                        if type(constValue) == "string" and constValue == enumLabel then
                            return enumLabel
                        elseif type(constValue) == "number" then
                            return format("%s (%d)", enumLabel, constValue)
                        else
                            return format("%s (%s)", enumLabel, tostring(constValue))
                        end
                    end
                end
            end
            return tostring(constValue or "nil")
        elseif ASTValue.IsMathOp(valueNode) then
            -- Format math expression recursively from proto AST
            local valueData = ASTValue.GetValueData(valueNode)
            local lhs = valueData and valueData.lhs
            local rhs = valueData and valueData.rhs
            local op = valueData and valueData.op or "OpAdd"
            local opSymbol = ASTValue.MathOpToSymbol(op) or "?"
            local lhsStr = lhs and EditorUtils.FormatValueNode(lhs) or "?"
            local rhsStr = rhs and EditorUtils.FormatValueNode(rhs) or "?"
            return format("(%s %s %s)", lhsStr, opSymbol, rhsStr)
        elseif ASTValue.IsComparison(valueNode) then
            -- Format comparison expression recursively from proto AST
            local valueData = ASTValue.GetValueData(valueNode)
            local lhs = valueData and valueData.lhs
            local rhs = valueData and valueData.rhs
            local op = valueData and valueData.op or "OpEq"
            local opSymbol = ASTValue.ComparisonOpToSymbol(op) or "=="
            local lhsStr = lhs and EditorUtils.FormatValueNode(lhs) or "?"
            local rhsStr = rhs and EditorUtils.FormatValueNode(rhs) or "?"
            return format("(%s %s %s)", lhsStr, opSymbol, rhsStr)
        elseif ASTValue.IsLogicalOp(valueNode) then
            -- Format logical expression recursively from proto AST
            local valueType = ASTValue.GetValueType(valueNode)
            local valueData = ASTValue.GetValueData(valueNode)
            local opText = (valueType == ASTValue.ValueType.AND) and "and" or
                          (valueType == ASTValue.ValueType.OR) and "or" or "not"
            if valueType == ASTValue.ValueType.NOT then
                local child = valueData and valueData.val
                local childStr = child and EditorUtils.FormatValueNode(child) or "?"
                return format("not %s", childStr)
            else
                local children = valueData and valueData.vals or {}
                local parts = {}
                for _, child in ipairs(children) do
                    tinsert(parts, EditorUtils.FormatValueNode(child))
                end
                if #parts > 0 then
                    return "(" .. table.concat(parts, " " .. opText .. " ") .. ")"
                else
                    return "(empty)"
                end
            end
        else
            -- Function call or other value type - format with enum awareness
            local valueType = ASTValue.GetValueType(valueNode)
            local valueData = ASTValue.GetValueData(valueNode) or {}

            -- Special handling for VARIABLE_REF - display as "VariableRef: variable-name"
            if valueType == ASTValue.ValueType.VARIABLE_REF then
                local varName = valueData.name
                if varName then
                    -- Extract from const value if nested (shouldn't happen but handle gracefully)
                    if type(varName) == "table" then
                        if varName.type == ASTCore.NodeType.VALUE then
                            varName = ASTValue.GetConstValue(varName)
                        elseif varName.value then
                            -- Might be wrapped in { value = "name" } structure
                            varName = varName.value
                        end
                    end
                    if varName and varName ~= "" then
                        return format("VariableRef: %s", tostring(varName))
                    else
                        return "VariableRef: (empty)"
                    end
                else
                    return "VariableRef: (unknown)"
                end
            end

            -- Check if this is a function call (not a standard operator)
            local isFunctionCall = valueType and
                valueType ~= ASTValue.ValueType.CONST and
                valueType ~= ASTValue.ValueType.MATH and
                valueType ~= ASTValue.ValueType.CMP and
                valueType ~= ASTValue.ValueType.AND and
                valueType ~= ASTValue.ValueType.OR and
                valueType ~= ASTValue.ValueType.NOT and
                valueType ~= ASTValue.ValueType.MAX and
                valueType ~= ASTValue.ValueType.MIN and
                valueType ~= ASTValue.ValueType.VARIABLE_REF and
                valueType ~= ASTValue.ValueType.VARIABLE_PLACEHOLDER

            if isFunctionCall then
                -- Format function call with enum-aware argument formatting
                return EditorUtils.FormatFunctionCallValue(valueNode, valueType, valueData)
            end

            -- Fallback: use ASTSchemaEmitter if available
            NAG:Warn("[EditorUtils] FALLBACK TRACKING: Using ASTSchemaEmitter fallback in GetClauseActionSummary() (primary emission method failed)")
            if ASTSchemaEmitter then
                local emitted = ASTSchemaEmitter.EmitValueNode(valueNode)
                if emitted and emitted ~= "" then
                    return emitted
                end
            end
            return format("(%s)", valueType or "unknown")
        end
    elseif valueNode.type == "constant" then
        -- Legacy format detected - should not happen in production code
        NAG:Error(format("[EditorUtils] FormatValueNode: Legacy format constant node detected - should be proto AST. Context: FormatValueNode"))
        return tostring(valueNode.value or "nil")
    elseif valueNode.type == "function" then
        -- Legacy format detected - should not happen in production code
        NAG:Error(format("[EditorUtils] FormatValueNode: Legacy format function node detected - should be proto AST. Context: FormatValueNode"))
        local funcName = valueNode.functionName or "unknown"
        local displayName = ns.SchemaUtils:SnakeToPascal(funcName) or funcName
        local args = valueNode.arguments or {}
        local argStrs = {}
        for i = 1, #args do
            local arg = args[i]
            if arg.type == "constant" then
                tinsert(argStrs, tostring(arg.value))
            else
                tinsert(argStrs, EditorUtils.FormatValueNode(arg))
            end
        end
        if #argStrs > 0 then
            return format("%s(%s)", displayName, table.concat(argStrs, ", "))
        else
            return format("%s()", displayName)
        end
    elseif valueNode.type == "empty" then
        return "(empty)"
    else
        return format("(%s)", valueNode.type or "unknown")
    end
end

--- Format an action node for display (human-readable format)
---
--- **UI Usage**: Generates display text for **Node Details panel** (right panel) when showing action nodes.
--- This is the text shown in the "Action: [formatted text]" section of the details panel.
---
--- **Output Format**: Human-readable action summary (no icons, no full APL syntax):
--- - "Cast: Spell Name" (for cast_spell actions)
--- - "OverlayText: [text value]" (for overlay_text actions)
--- - "Sequence(name)" (for sequence actions)
--- - "ActionName(id)" (for generic actions)
--- - "PARSE ERROR: [error]" (for parse errors)
---
--- **Called By**:
--- - `NodeEditors:RebuildNodeDetails` (for Node Details panel action display)
--- - `ASTEditor:BuildClauseASTTree` (for tree node text)
--- - `GetClauseActionSummary` (as fallback when APL emission fails)
---
--- **Related Functions**:
--- - `GetClauseActionSummary` - generates left panel list text (uses full APL syntax + icons)
--- - `GetClauseSchemaEmitterOutput` - generates tooltip text (uses full APL syntax)
--- - `FormatValueNode` - formats condition values (used internally for conditions)
---
--- **Note**: This function does NOT include icons or full APL syntax. For full APL syntax,
--- use `ASTSchemaEmitter.EmitActionNode` directly or `GetClauseActionSummary`.
---
--- @param actionNode table Action node (proto AST)
--- @return string Formatted action text (human-readable, no icons, no full APL syntax)
function EditorUtils.FormatActionNode(actionNode)
    if not actionNode then
        return "(empty)"
    end

    local SchemaUtils = ns.SchemaUtils
    local WoWAPI = ns.WoWAPI

    -- Get action type from proto AST
    local actionType = nil
    if actionNode.type == ASTCore.NodeType.ACTION then
        actionType = ASTAction and ASTAction.GetActionType(actionNode)
    end

    if not actionType then
        -- Unknown or invalid action - try to emit raw APL syntax
        if ASTSchemaEmitter and actionNode.type == ASTCore.NodeType.ACTION then
            local text = ASTSchemaEmitter.EmitActionNode(actionNode) or ""
            if text and text ~= "" then
                return text
            end
        end
        return "(unknown)"
    end

    local displayName = SchemaUtils and SchemaUtils:SnakeToPascal(actionType) or actionType

    -- Special case: OverlayText - display as "OverlayText: [text value]"
    if actionType == "overlay_text" then
        local actionData = ASTAction and ASTAction.GetActionData(actionNode)
        local textValue = actionData and actionData.text
        -- Ensure textValue is a string before using string operations (defensive check)
        if textValue and type(textValue) == "string" and textValue ~= "" then
            -- Truncate long text for display
            if #textValue > 30 then
                textValue = textValue:sub(1, 27) .. "..."
            end
            return format("OverlayText: %s", textValue)
        elseif textValue and type(textValue) ~= "string" then
            -- textValue exists but is not a string (shouldn't happen, but handle gracefully)
            NAG:Warn("[EditorUtils] FormatActionNode: OverlayText text field is not a string (type=%s)", type(textValue))
            return format("OverlayText: (invalid type: %s)", type(textValue))
        else
            return "OverlayText: (empty)"
        end
    end

    -- Special case: Sequence/StrictSequence
    if actionType == "sequence" or actionType == "strict_sequence" then
        local seqName = EditorUtils.GetActionFirstArgID(actionNode, actionType) or actionNode.sequenceName or "?"
        local isStrict = actionType == "strict_sequence"
        local funcName = displayName or (isStrict and "StrictSequence" or "Sequence")
        return format("%s(%s)", funcName, tostring(seqName))
    end

    -- Generic action handling
    if actionType then
        local firstArg = EditorUtils.GetActionFirstArgID(actionNode, actionType)

        if firstArg then
            local argStr = tostring(firstArg)
            if #argStr > 20 then
                argStr = argStr:sub(1, 17) .. "..."
            end

            local normalizedFuncName = actionType:lower()
            local isCastAction = (actionType == "cast_spell") or normalizedFuncName == "cast"

            if isCastAction then
                local spellName
                local spellID = tonumber(firstArg)
                if spellID then
                    -- Try SpellbookManager first (better source), then fallback to WoWAPI
                    if SpellbookManager and SpellbookManager.GetSpellName then
                        spellName = SpellbookManager:GetSpellName(spellID)
                    end
                    if not spellName then
                        local spellInfo = WoWAPI.GetSpellInfo(spellID)
                        if spellInfo then
                            spellName = spellInfo.name
                        end
                    end
                end
                if not spellName and type(firstArg) == "string" then
                    spellName = firstArg
                end

                if spellName and spellName ~= "" then
                    return "Cast: " .. spellName
                else
                    return format("%s(%s)", displayName, argStr)
                end
            else
                return format("%s(%s)", displayName, argStr)
            end
        else
            return format("%s(...)", displayName)
        end
    elseif actionNode.parseError then
        -- Parse error - format error message
        local text = actionNode.text or "Parse Failed"
        if not text or text == "Parse Failed" then
            if ASTSchemaEmitter and actionNode.type == ASTCore.NodeType.ACTION then
                text = ASTSchemaEmitter.EmitActionNode(actionNode) or "Parse Failed"
            end
        end
        if #text > 35 then
            text = text:sub(1, 32) .. "..."
        end
        return "PARSE ERROR: " .. text
    else
        -- Fallback: synthesize text from proto AST
        if ASTSchemaEmitter and actionNode.type == ASTCore.NodeType.ACTION then
            local text = ASTSchemaEmitter.EmitActionNode(actionNode) or ""
            if text and text ~= "" then
                -- Truncate long text for display
                if #text > 50 then
                    text = text:sub(1, 47) .. "..."
                end
                return text
            end
        end
        return "(unknown)"
    end
end

--- Get a summary of a clause's action for display
---
--- **UI Usage**: Generates the main display text for **Rotation Clauses list** (left panel tree).
--- This is the text shown in the left panel tree for each rotation clause node.
---
--- **Output Format**: Full APL syntax with icons and inline comments:
--- - Format: "[icons] NAG:ActionName(args)" (e.g., "|T123:16:16|t NAG:OverlayText(\"SBSS\")")
--- - Includes spell/item icons (up to 5) extracted from action arguments
--- - Includes inline comment hints if present (e.g., "// comment text")
--- - Uses `ASTSchemaEmitter.EmitActionNode` for full APL syntax (consistent with Groups & Variables)
---
--- **Called By**:
--- - `ASTEditor:BuildClauseASTTree` (for left panel Rotation Clauses list text)
---
--- **Related Functions**:
--- - `FormatActionNode` - generates Node Details panel text (human-readable, no icons)
--- - `GetClauseSchemaEmitterOutput` - generates tooltip text (full APL syntax with formatting)
--- - `ASTSchemaEmitter.EmitActionNode` - generates raw APL syntax (used internally)
---
--- **Key Differences**:
--- - vs `FormatActionNode`: Includes icons, uses full APL syntax, includes comments
--- - vs `GetClauseSchemaEmitterOutput`: Includes icons, single-line format, no condition display
---
--- @param clause table Clause data (from aplProto.priority_list)
--- @return string Summary text with icons and full APL syntax (e.g., "|T123:16:16|t NAG:Cast(12345)")
function EditorUtils.GetClauseActionSummary(clause)
    if not clause or not clause.action then
        return "Empty"
    end

    local summary = ""
    local iconTextures = {} -- Changed to array to support multiple icons
    local action = clause.action

    -- CRITICAL: Use proto AST structure - GetActionType is the definitive source
    local protoActionType = nil
    if action.type == ASTCore.NodeType.ACTION then
        protoActionType = ASTAction and ASTAction.GetActionType(action)
    end

    -- Helper: Get spell/item icon for an ID
    -- Helper: Extract multiple spell IDs from action text (for "or" conditions and sequences)
    local function extractMultipleSpellIDs(text)
        local spellIds = {}
        if not text then return spellIds end

        -- Extract all NAG:Cast*(ID) patterns (matches Cast, CastSpell, etc.)
        for id in text:gmatch("NAG:Cast[%w]*%((%d+)%)") do
            local numId = tonumber(id)
            if numId then
                tinsert(spellIds, numId)
                if #spellIds >= 5 then break end -- Limit to 5 icons
            end
        end

        -- If no Cast patterns found, try StrictSequence/Sequence with numeric arguments
        if #spellIds == 0 then
            -- Match StrictSequence("name", id1, id2, ...) or Sequence("name", id1, id2, ...)
            local seqMatch = text:match("NAG:StrictSequence%b()") or text:match("NAG:Sequence%b()")
            if seqMatch then
                -- Extract numeric IDs from the sequence arguments (skip the name string)
                local afterName = false
                for arg in seqMatch:gmatch("[^,]+") do
                    if afterName then
                        local numId = tonumber(arg:match("(%d+)"))
                        if numId then
                            tinsert(spellIds, numId)
                            if #spellIds >= 5 then break end
                        end
                    elseif arg:match('"[^"]*"') or arg:match("'[^']*'") then
                        -- Found the name string, start collecting IDs after this
                        afterName = true
                    end
                end
            end
        end

        return spellIds
    end

    -- Use EmitActionNode to get full APL syntax (e.g., "NAG:OverlayText(SBSS)") for consistency with Groups & Variables
    -- This matches the behavior where variables show the full expression
    if ASTSchemaEmitter and action.type == ASTCore.NodeType.ACTION then
        summary = ASTSchemaEmitter.EmitActionNode(action) or ""
        if summary == "" then
            -- Fallback to FormatActionNode if emission fails
            summary = EditorUtils.FormatActionNode(action)
        end
    else
        -- Fallback to FormatActionNode for non-proto AST or parse errors
        summary = EditorUtils.FormatActionNode(action)
    end

    -- Extract icons for display (icon handling is clause-specific, not in FormatActionNode)
    -- CRITICAL: Use emitted text as source of truth for icons (same as displayed text)
    -- This ensures icons always match the displayed action text, even if proto AST structure is stale
    local actionType = nil
    if action.type == ASTCore.NodeType.ACTION then
        actionType = ASTAction and ASTAction.GetActionType(action)
    end

    -- Extract spell IDs from emitted text (source of truth - matches displayed text)
    if ASTSchemaEmitter and action.type == ASTCore.NodeType.ACTION then
        local actionText = ASTSchemaEmitter.EmitActionNode(action) or ""
        if actionText and actionText ~= "" then
            local spellIds = extractMultipleSpellIDs(actionText)
            if #spellIds > 0 then
                -- Use IDs from emitted text (guaranteed to match displayed text)
                iconTextures = {}
                for _, id in ipairs(spellIds) do
                    local icon = EditorUtils.GetIconForID(id)
                    if icon then
                        tinsert(iconTextures, icon)
                    end
                end
            end
        end
    end

    -- Fallback: If no icons found from emitted text, try proto AST structure
    -- This handles edge cases where emitted text doesn't contain extractable IDs
    if #iconTextures == 0 and actionType then
        -- Special case: Sequence/StrictSequence (multiple IDs)
        if actionType == "sequence" or actionType == "strict_sequence" then
            -- Already handled above via emitted text extraction
        else
            -- Generic action handling using schema-based ID detection
            local firstArg = EditorUtils.GetActionFirstArgID(action, protoActionType)
            if firstArg then
                local SchemaValidator = NAG:GetModule("SchemaValidator")
                if SchemaValidator and SchemaValidator:IsArgumentIDType(actionType, 1) then
                    -- First argument is an ID - get icon
                    local iconTex = EditorUtils.GetIconForID(firstArg)
                    if iconTex then
                        tinsert(iconTextures, iconTex)
                    end
                end
            end
        end
    end

    -- Handle parse error icon
    if action.parseError then
        local errorIcon = "|TInterface\\RaidFrame\\ReadyCheck-NotReady:14:14:0:0:64:64:4:60:4:60|t"
        -- FormatActionNode already includes "PARSE ERROR:" prefix, just add icon
        summary = errorIcon .. " |cFFFF4444" .. summary
    end

    -- Build icon tag with multiple icons (up to 5)
    local iconTag = ""
    local iconCount = #iconTextures
    if iconCount > 0 then
        local displayCount = iconCount > 5 and 5 or iconCount
        for i = 1, displayCount do
            iconTag = iconTag .. "|T" .. tostring(iconTextures[i]) .. ":16:16:0:0:64:64:4:60:4:60|t"
        end
        if iconCount > 5 then
            iconTag = iconTag .. "... "
        else
            iconTag = iconTag .. " "
        end
    end

    -- Append inline comment hint if present
    if clause.inlineComment and clause.inlineComment ~= "" then
        local commentHint = clause.inlineComment:match("^%-%-%s*(.*)") or clause.inlineComment
        if #commentHint > 30 then
            commentHint = commentHint:sub(1, 27) .. "..."
        end
        summary = summary .. " // " .. commentHint
    end

    return iconTag .. summary
end

-- ============================ SCHEMA-BASED MENU BUILDING ============================

--- Build a hierarchical menu from schema Actions or Values grouped by submenu
--- @param category string "Actions" or "Values"
--- @param options table|nil Configuration options:
---   - enableFiltering (boolean|nil): Enable include_if filtering (default: false)
---   - isPrepull (boolean|nil): Current prepull context for filtering
---   - playerSpec (number|nil): Player specialization ID for filtering
---   - onItemSelected (function|nil): Callback(itemMetadata) when item is selected
---   - getDisplayName (function|nil): Custom function(itemMetadata) -> string for display name
---   - getTooltip (function|nil): Custom function(itemMetadata) -> string for tooltip
--- @return table|nil Hierarchical menu structure for LibUIDropDownMenu, or nil if no items
function EditorUtils:BuildSchemaSubmenuMenu(category, options)
    options = options or {}
    local enableFiltering = options.enableFiltering or false
    local isPrepull = options.isPrepull
    local playerSpec = options.playerSpec
    local onItemSelected = options.onItemSelected
    local getDisplayName = options.getDisplayName
    local getTooltip = options.getTooltip

    local SchemaAccessor = NAG:GetModule("SchemaAccessor")
    if not SchemaAccessor then
        NAG:Warn("[EditorUtils] SchemaAccessor not available for BuildSchemaSubmenuMenu")
        return nil
    end

    -- Get grouped items by submenu
    local grouped = {}
    if category == "Actions" then
        if SchemaAccessor.GetActionsGroupedBySubmenu then
            grouped = SchemaAccessor:GetActionsGroupedBySubmenu(
                enableFiltering and playerSpec ~= nil,
                enableFiltering and isPrepull ~= nil,
                isPrepull,
                playerSpec
            )
        end
    elseif category == "Values" then
        if SchemaAccessor.GetValuesGroupedBySubmenu then
            grouped = SchemaAccessor:GetValuesGroupedBySubmenu(
                enableFiltering and playerSpec ~= nil,
                enableFiltering and isPrepull ~= nil,
                isPrepull,
                playerSpec
            )
        end
    else
        NAG:Warn("[EditorUtils] BuildSchemaSubmenuMenu: Invalid category '%s', must be 'Actions' or 'Values'", tostring(category))
        return nil
    end

    if not grouped or next(grouped) == nil then
        return nil
    end

    -- Helper to get display name for an item
    local function resolveDisplayName(itemMetadata)
        if getDisplayName then
            return getDisplayName(itemMetadata)
        end

        -- Default: use ui_label or convert name
        if itemMetadata.ui_label then
            return itemMetadata.ui_label
        end

        -- Use unified ResolveActionDisplayName for actions, fallback for values
        if category == "Actions" then
            return EditorUtils.ResolveActionDisplayName(itemMetadata)
        end

        -- For values, use similar logic but with "unknown" fallback
        local name = itemMetadata.nagFunctionName or itemMetadata.nagName or itemMetadata.name
        if name then
            local SchemaUtils = ns.SchemaUtils
            if SchemaUtils and SchemaUtils.SnakeToPascal then
                local converted = SchemaUtils:SnakeToPascal(name)
                if converted then
                    return converted
                end
            end
            return name
        end

        return L["unknown"] or "Unknown"
    end

    -- Helper to get tooltip for an item
    local function resolveTooltip(itemMetadata)
        if getTooltip then
            return getTooltip(itemMetadata)
        end
        return itemMetadata.short_description or itemMetadata.full_description or ""
    end

    -- Build menu structure
    local menu = {}
    local submenuNames = {}

    -- Collect all submenu names and sort them
    for submenuName in pairs(grouped) do
        table.insert(submenuNames, submenuName)
    end
    table.sort(submenuNames)

    -- Build menu entries for each submenu
    for _, submenuName in ipairs(submenuNames) do
        local items = grouped[submenuName]
        if items and #items > 0 then
            -- Sort items within submenu by display name
            table.sort(items, function(a, b)
                local nameA = resolveDisplayName(a) or ""
                local nameB = resolveDisplayName(b) or ""
                return nameA:lower() < nameB:lower()
            end)

            -- Create submenu entries
            local submenu = {}
            for _, itemMetadata in ipairs(items) do
                local displayName = resolveDisplayName(itemMetadata)
                local tooltip = resolveTooltip(itemMetadata)

                table.insert(submenu, {
                    text = displayName,
                    tooltipTitle = displayName,
                    tooltipText = tooltip,
                    notCheckable = true,
                    func = function()
                        if onItemSelected then
                            onItemSelected(itemMetadata)
                        end
                        -- Close context menu (LibUIDropDownMenu pattern)
                        if ns.LibUIDropDownMenu and ns.LibUIDropDownMenu.CloseDropDownMenus then
                            ns.LibUIDropDownMenu.CloseDropDownMenus()
                        end
                    end
                })
            end

            -- Add submenu to main menu
            table.insert(menu, {
                text = submenuName,
                hasArrow = true,
                notCheckable = true,
                menuList = submenu
            })
        end
    end

    if #menu > 0 then
        return menu
    end

    return nil
end

--- Get current filter context for schema menu building
--- @param editorState table|nil Editor state (optional, for prepull context)
--- @return table Filter context with isPrepull, playerSpec, and enableFiltering
function EditorUtils:GetSchemaMenuFilterContext(editorState)
    local StateManager = NAG:GetModule("StateManager")
    local isPrepull = nil
    local playerSpec = nil

    -- Get prepull context from editorState if available
    if editorState and editorState.isPrepull ~= nil then
        isPrepull = editorState.isPrepull
    end

    -- Get player specialization
    local SpecCompat = NAG:GetModule("SpecCompat")
    if SpecCompat then
        playerSpec = SpecCompat:GetCurrentSpecIndex()
    end

    return {
        isPrepull = isPrepull,
        playerSpec = playerSpec,
        enableFiltering = false  -- Default to disabled, caller can enable
    }
end

--- Build a schema submenu menu with automatic filter context detection
--- Convenience wrapper around BuildSchemaSubmenuMenu that auto-detects context
--- @param category string "Actions" or "Values"
--- @param options table|nil Configuration options (see BuildSchemaSubmenuMenu)
---   Additional options:
---   - autoDetectContext (boolean|nil): Auto-detect filter context (default: true)
---   - editorState (table|nil): Editor state for context detection
--- @return table|nil Hierarchical menu structure
function EditorUtils:BuildSchemaSubmenuMenuAuto(category, options)
    options = options or {}
    local autoDetectContext = options.autoDetectContext ~= false  -- Default to true

    if autoDetectContext then
        local context = self:GetSchemaMenuFilterContext(options.editorState)
        options.isPrepull = options.isPrepull or context.isPrepull
        options.playerSpec = options.playerSpec or context.playerSpec
    end

    return self:BuildSchemaSubmenuMenu(category, options)
end


