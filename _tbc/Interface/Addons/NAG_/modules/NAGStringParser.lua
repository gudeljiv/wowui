--- @module "NAG.NAGStringParser"
--- Parses NAG's custom rotation string format into an AST structure
---
---
--- Supported patterns:
---   - Standard (preferred): (condition) and NAG:CastSpell(spell)
---   - Auto-corrected: (condition and NAG:CastSpell(spell))
---   - Testing: /nagdebug parser test nested
---   - Validation: /nagdebug parser validate all
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas

local _, ns = ...
local GetTime = _G.GetTime
local UnitClass = _G.UnitClass
local UnitClassBase = _G.UnitClassBase
local UnitAffectingCombat = _G.UnitAffectingCombat
local L = ns.AceLocale:GetLocale("NAG")
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- Enhanced error handling
local pcall = ns.pcall
local TableUtils = ns.TableUtils

local WoWAPI = ns.WoWAPI
local format = string.format
local strmatch = string.match
local concat = table.concat
local pairs = pairs

local EditorUtils = ns.RotationEditorUtils
-- Proto-compatible AST system
local RotationConversionService = ns.RotationConversionService
local SchemaValidator = NAG:GetModule("SchemaValidator")
local SchemaAccessor
local ASTRotation = ns.ASTRotation
local ASTCore = ns.ASTCore
local ASTAction = ns.ASTAction
local ASTValue = ns.ASTValue
local SchemaUtils = NAG:GetModule("SchemaUtils")

--- @class NAGStringParser: CoreModule
local NAGStringParser = NAG:CreateModule("NAGStringParser", nil, {
    moduleType = ns.MODULE_TYPES.UTILITY,
    debugCategories = { ns.DEBUG_CATEGORIES.PROCESSORS },

    -- Slash commands using zero-boilerplate pattern
    slashCommands = {
        -- NEW HIERARCHICAL FORMAT:
        ["parser_string"] = {
            handler = "TestStringParsing",
            help = "Test NAG string parsing. Usage: /nagdebug parser string [string]",
            root = "nagdebug",
            path = {"parser", "string"},
            category = "Debug"
        },
        ["parser_value"] = {
            handler = "TestValueParsing",
            help = "Test NAG value parsing. Usage: /nagdebug parser value [value_expression]",
            root = "nagdebug",
            path = {"parser", "value"},
            category = "Debug"
        },
        ["parser_ast_debug"] = {
            handler = "ShowASTDebugFrame",
            help = "Show AST debug frame for rotation parsing",
            root = "nagdebug",
            path = {"parser", "ast", "debug"},
            category = "Debug"
        },
        ["parser_test_nested"] = {
            handler = "TestNestedActionHandling",
            help = "Test nested action handling enhancement",
            root = "nagdebug",
            path = {"parser", "test", "nested"},
            category = "Debug"
        },
        ["parser_validate_all"] = {
            handler = "ValidateAllClassRotations",
            help = "Validate parser against all class rotations",
            root = "nagdebug",
            path = {"parser", "validate", "all"},
            category = "Debug"
        }
    }
})
local module = NAGStringParser
ns.NAGStringParser = NAGStringParser

-- ~~~~~~~~~~ AST STRUCTURE DEFINITIONS ~~~~~~~~~~

--- @class APLActionNode
--- @field type string The type of action (cast, channel, wait, sequence, etc.)
--- @field spellId number|string The spell ID or name
--- @field condition APLConditionNode|nil The condition that must be true for this action
--- @field priority number The priority order (lower = higher priority)
--- @field notes string|nil Optional notes about this action

--- @class APLConditionNode
--- @field type string The type of condition (comparison, logical, function)
--- @field operator string|nil The comparison operator (<, >, <=, >=, ==, !=)
--- @field lhs APLValueNode|nil Left hand side of comparison
--- @field rhs APLValueNode|nil Right hand side of comparison
--- @field logicalOp string|nil Logical operator (and, or)
--- @field children APLConditionNode[]|nil Child conditions for logical operations
--- @field functionName string|nil Function name (e.g., "CurrentHealthPercent", "AuraRemainingTime")
--- @field functionArgs APLValueNode[]|nil Function arguments

--- @class APLValueNode
--- @field type string The type of value (constant, function, variable)
--- @field value string|number|nil The actual value
--- @field functionName string|nil Function name if this is a function call
--- @field functionArgs APLValueNode[]|nil Function arguments

-- ~~~~~~~~~~ PARSING FUNCTIONS ~~~~~~~~~~

--- INTERNAL: Parses a NAG rotation string into an AST structure
--- This method is internal-only and called by RotationConversionService.
--- External callers should use RotationConversionService:ParseToProtoAST() instead.
--- @param rotationString string The rotation string to parse
--- @return table|nil The parsed AST, or nil on error
--- @return string|nil Error message if parsing failed
function NAGStringParser:ParseRotationString(rotationString)
    if not rotationString or type(rotationString) ~= "string" then
        self:Error("ParseRotationString: Invalid rotation string provided (type=%s, value=%s)",
            type(rotationString), tostring(rotationString))
        return nil, "Invalid rotation string provided"
    end

    -- Split into lines and merge multi-line clauses
    local lines = self:SplitIntoLines(rotationString)

    -- CRITICAL: Also split single lines on " or " at top level (paren depth 0)
    -- This handles cases like "NAG:CastSpell(111) or NAG:CastSpell(222) or NAG:CastSpell(333)"
    -- CRITICAL: Do NOT split comment lines - they should be preserved as-is
    -- CRITICAL: Do NOT split lines that start with "or " - they are already clause separators
    -- CRITICAL: Only split if the line contains "or" that's not at the start (indicating multiple clauses)
    local expandedLines = {}
    for _, line in ipairs(lines) do
        local trimmedLine = line:match("^%s*(.-)%s*$")
        -- Check if this is a comment line BEFORE splitting
        if trimmedLine and trimmedLine:match("^%-%-") then
            -- Comment line - preserve as-is, don't split
            table.insert(expandedLines, line)
        elseif trimmedLine and trimmedLine:match("^or%s+") then
            -- Line starts with "or " - this is already a clause separator, don't split
            -- The line is already properly formatted as a separate clause
            table.insert(expandedLines, line)
        else
            -- Non-comment line that doesn't start with "or" - check if it needs splitting
            -- Only split if we find "or" at paren depth 0 (not nested in parentheses)
            -- SplitOnOperator already respects parentheses depth, so this is safe
            local lineParts = self:SplitOnOperator(line, "or")
            if #lineParts > 1 then
                -- Multiple clauses in one line - add each as separate line with "or " prefix
                -- SplitOnOperator correctly tracks brace depth, so table literals are safe
                for j, part in ipairs(lineParts) do
                    if j == 1 then
                        -- First part - no "or " prefix
                        table.insert(expandedLines, part)
                    else
                        -- Subsequent parts - add "or " prefix
                        table.insert(expandedLines, "or " .. part)
                    end
                end
            else
                -- Single clause - use the stripped part from SplitOnOperator (comment already removed)
                -- This ensures comments are stripped before further processing
                if #lineParts > 0 and lineParts[1] then
                    table.insert(expandedLines, lineParts[1])
                else
                    table.insert(expandedLines, line)
                end
            end
        end
    end

    local clauses = {}
    local pendingComment = nil
    local currentClause = nil
    local currentClausePriority = 0
    local parenDepth = 0  -- Track parenthesis depth across lines
    local currentInlineComment = nil  -- Track inline comment for current clause
    local currentClauseIndent = nil
    local pendingCommentIndent = nil
    local currentClauseNotes = nil
    local currentClauseNoteIndent = nil
    local currentClauseLeadingOperator = nil

    for i, line in ipairs(expandedLines) do
        local trimmedLine = line:match("^%s*(.-)%s*$")
        -- Handle blank lines first - they reset comment attachment
        if not trimmedLine or trimmedLine == "" then
            -- Blank line - clear pending comment so it doesn't attach to previous clause
            -- Comments after blank lines should attach to the clause after the blank line, not before
            if pendingComment then
                self:Info("ParseRotationString: Blank line encountered, clearing pending comment (comment will attach to next clause)")
            end
            pendingComment = nil
            pendingCommentIndent = nil
        -- Check if this is a comment line
        elseif trimmedLine:match("^%-%-") then
            -- Check if next line is blank (newline after comment)
            local nextLine = expandedLines[i + 1]
            local nextLineTrimmed = nextLine and nextLine:match("^%s*(.-)%s*$") or ""
            local hasNewlineAfter = not nextLine or nextLineTrimmed == ""

            if hasNewlineAfter and currentClause then
                -- Newline after comment → attach to previous clause
                if currentClauseNotes then
                    currentClauseNotes = currentClauseNotes .. "\n" .. trimmedLine
                else
                    currentClauseNotes = trimmedLine
                    currentClauseNoteIndent = line:match("^(%s*)") or ""
                end
            else
                -- No newline after comment → store for next clause
                if pendingComment then
                    pendingComment = pendingComment .. "\n" .. trimmedLine
                else
                    pendingComment = trimmedLine
                    pendingCommentIndent = line:match("^(%s*)") or ""
                end
            end
        -- Handle standalone "or" lines
        elseif trimmedLine == "or" then
            -- Standalone "or" line - check if we're inside parentheses
            if parenDepth > 0 then
                -- Inside parentheses - this is part of the condition, join it
                if currentClause then
                    currentClause = currentClause .. " or"
                else
                    -- No current clause, start new one with "or"
                    currentClausePriority = currentClausePriority + 1
                    currentClause = "or"
                    currentClauseIndent = line:match("^(%s*)") or ""
                end
            else
                -- At paren depth 0 - this is a clause separator, skip it
                -- (This is just a separator from SyncVisualToText)
            end
        else
                -- Check if this line starts a new clause (starts with "or" at paren depth 0)
                -- Only treat "or" as a clause separator if we're not inside parentheses
                local isNewClause = trimmedLine:match("^or%s+") and parenDepth == 0

                -- Check if this is a continuation line (starts with "and", ")", doesn't start with "or", or we're inside parens)
                local isContinuation = not isNewClause and (
                    trimmedLine:match("^and%s+") or
                    trimmedLine:match("^%)") or
                    parenDepth > 0 or  -- If we're inside parens, it's a continuation
                    (currentClause ~= nil and not trimmedLine:match("^or%s+"))
                )

                if isNewClause or (not isContinuation and currentClause == nil) then
                    -- Save previous clause if exists
                    if currentClause and currentClause ~= "" then
                        local clauseIndex = #clauses + 1
                        local clause = self:ParseClause(currentClause, currentClausePriority, clauseIndex)
                        if clause then
                            clause.leadingWhitespace = currentClauseIndent or ""
                            clause.leadingOperator = clause.leadingOperator or currentClauseLeadingOperator
                            if currentClauseNotes and currentInlineComment then
                                clause.notes = currentClauseNotes .. " | " .. currentInlineComment
                                clause.noteIndent = currentClauseNoteIndent or clause.leadingWhitespace
                            elseif currentClauseNotes then
                                clause.notes = currentClauseNotes
                                clause.noteIndent = currentClauseNoteIndent or clause.leadingWhitespace
                            elseif currentInlineComment then
                                clause.notes = currentInlineComment
                            end
                            table.insert(clauses, clause)
                        else
                            self:Warn("Failed to parse clause %d: %s", currentClausePriority, currentClause)
                        end
                    end

                    currentClauseIndent = nil
                    currentClauseNotes = nil
                    currentClauseNoteIndent = nil
                    currentInlineComment = nil
                    currentClauseLeadingOperator = nil

                    -- Start new clause
                    currentClausePriority = currentClausePriority + 1
                    -- Remove leading clause operator (e.g., "or ")
                    local leadingOperator = trimmedLine:match("^(or%s+)")
                    if leadingOperator then
                        currentClauseLeadingOperator = leadingOperator
                    end
                    local newClauseLine
                    if leadingOperator then
                        newClauseLine = trimmedLine:sub(#leadingOperator + 1)
                    else
                        newClauseLine = trimmedLine
                        currentClauseLeadingOperator = nil
                    end
                    -- Strip inline comments from the initial line and capture them
                    local strippedLine, inlineComment = self:StripInlineComment(newClauseLine)
                    currentClause = strippedLine
                    currentInlineComment = inlineComment
                    currentClauseIndent = line:match("^(%s*)") or ""
                    if pendingComment then
                        currentClauseNotes = pendingComment
                        currentClauseNoteIndent = pendingCommentIndent
                        pendingComment = nil
                        pendingCommentIndent = nil
                    end
                    -- Reset paren depth for new clause
                    parenDepth = self:CountParenthesesInLine(currentClause)
                elseif isContinuation and currentClause then
                    -- Strip inline comments from continuation lines to avoid breaking multi-line conditions
                    -- Example: "and NAG:IsReadySpell(116670)) -- TFT buff" becomes "and NAG:IsReadySpell(116670))"
                    local cleanedLine, contInlineComment = self:StripInlineComment(trimmedLine)
                    -- If continuation line has inline comment, append to current inline comment
                    if contInlineComment then
                        if currentInlineComment then
                            currentInlineComment = currentInlineComment .. " | " .. contInlineComment
                        else
                            currentInlineComment = contInlineComment
                        end
                    end
                    -- Append continuation line to current clause with a space
                    currentClause = currentClause .. " " .. cleanedLine
                    -- Update paren depth
                    parenDepth = parenDepth + self:CountParenthesesInLine(cleanedLine)
                else
                    -- First line of rotation (no "or" prefix)
                    currentClausePriority = currentClausePriority + 1
                    -- Strip inline comments from the initial line and capture them
                    local strippedLine, inlineComment = self:StripInlineComment(trimmedLine)
                    currentClause = strippedLine
                    currentInlineComment = inlineComment
                    currentClauseIndent = line:match("^(%s*)") or ""
                    -- Initialize paren depth
                    parenDepth = self:CountParenthesesInLine(currentClause)
                end  -- Closes the if/elseif/else from line 201
            end  -- Closes the else block from line 188 and the if/elseif/else chain starting at line 168
    end  -- Closes the for loop starting at line 165

    -- Don't forget the last clause
    if currentClause and currentClause ~= "" then
        local clauseIndex = #clauses + 1
        local clause = self:ParseClause(currentClause, currentClausePriority, clauseIndex)
        if clause then
            clause.leadingWhitespace = currentClauseIndent or ""
            clause.leadingOperator = clause.leadingOperator or currentClauseLeadingOperator
            if currentClauseNotes and currentInlineComment then
                clause.notes = currentClauseNotes .. " | " .. currentInlineComment
                clause.noteIndent = currentClauseNoteIndent or clause.leadingWhitespace
            elseif currentClauseNotes then
                clause.notes = currentClauseNotes
                clause.noteIndent = currentClauseNoteIndent or clause.leadingWhitespace
            elseif currentInlineComment then
                clause.notes = currentInlineComment
            elseif pendingComment then
                clause.notes = pendingComment
                clause.noteIndent = pendingCommentIndent or clause.leadingWhitespace
                pendingComment = nil
                pendingCommentIndent = nil
            end
            table.insert(clauses, clause)
        else
            self:Error("ParseRotationString: Failed to parse clause %d (priority %d): '%s'",
                clauseIndex, currentClausePriority, currentClause:sub(1, 100) .. (#currentClause > 100 and "..." or ""))
        end
    end

    if #clauses == 0 then
        self:Error("ParseRotationString: No valid clauses found in rotation string (processed %d lines)", #expandedLines)
        return nil, "No valid clauses found in rotation string"
    end

    -- Build proto rotation directly
    local protoRotation = ASTRotation.Create()
    if not protoRotation then
        self:Error("ParseRotationString: Failed to create proto rotation structure")
        return nil, "Failed to create rotation structure"
    end

    for _, clause in ipairs(clauses) do
        -- Parse action to proto AST (already proto from ParseAction)
        local action = clause.action

        -- Parse condition to proto AST (already proto from ParseCondition, or nil)
        local condition = clause.condition

        -- Set condition on action if present
        if action and condition then
            ASTAction.SetCondition(action, condition)
        end

        -- Add to rotation (only list items with an action; value-only clauses are not in priority_list)
        if action then
            ASTRotation.AddPriorityAction(
                protoRotation,
                action,
                clause.notes,  -- From comment parsing
                clause.hidden  -- From NAG:Hidden() detection
            )

            -- Store presentation metadata
            local listItem = protoRotation.priority_list[#protoRotation.priority_list]

            -- Note: originalText removed - use ASTSchemaEmitter.EmitRotationString(protoAST) for text synthesis
        end
    end

    -- If we had clauses but none had an action (e.g. all value-only or action extraction failed), treat as no valid clauses
    if #(protoRotation.priority_list or {}) == 0 and #clauses > 0 then
        self:Error("ParseRotationString: No valid clauses with actions (parsed %d clauses but 0 had an action; check schema/ExtractActionAndCondition)", #clauses)
        return nil, "No valid clauses found in rotation string"
    end

    return protoRotation, nil
end

-- ============================ PROTO AST PARSING ============================
-- NOTE: ParseRotationStringProto() has been removed.
-- Use RotationConversionService:ParseToProtoAST() or RotationConversionService:ParseToLegacyWrappedProtoAST() instead.

--- Splits text into lines, handling different line endings
--- @param text string The text to split
--- @return string[] Array of lines
function NAGStringParser:SplitIntoLines(text)
    if not text or text == "" then
        return {}
    end

    -- Handle different line endings (Windows \r\n, Unix \n, old Mac \r)
    local lines = {}
    for line in text:gmatch("[^\r\n]+") do
        table.insert(lines, line)
    end

    return lines
end

--- Strips inline comments from a line (everything after -- but not inside strings)
--- Used for continuation lines to prevent comments from breaking multi-line conditions
--- @param line string The line to process
--- @return string The line with inline comments removed
--- @return string|nil The inline comment if found
function NAGStringParser:StripInlineComment(line)
    if not line or line == "" then return line, nil end

    local inString = false
    local stringQuote = nil
    for i = 1, #line do
        local ch = line:sub(i, i)
        if not inString then
            if ch == '"' or ch == "'" then
                inString = true
                stringQuote = ch
            elseif line:sub(i, i+1) == "--" then
                -- Found comment outside of string - strip from here and return both parts
                local strippedLine = line:sub(1, i - 1):match("^%s*(.-)%s*$") or line:sub(1, i - 1)
                local comment = line:sub(i)
                return strippedLine, comment
            end
        else
            if ch == stringQuote then
                inString = false
                stringQuote = nil
            end
        end
    end

    return line, nil
end

--- Counts the net change in parenthesis depth for a line (open - close)
--- Respects string literals (doesn't count parens inside strings)
--- @param line string The line to analyze
--- @return number The net change in parenthesis depth
function NAGStringParser:CountParenthesesInLine(line)
    if not line or line == "" then return 0 end

    local depth = 0
    local inString = false
    local stringQuote = nil

    for i = 1, #line do
        local ch = line:sub(i, i)
        if not inString then
            if ch == '"' or ch == "'" then
                inString = true
                stringQuote = ch
            elseif ch == "(" then
                depth = depth + 1
            elseif ch == ")" then
                depth = depth - 1
            end
        else
            if ch == stringQuote then
                inString = false
                stringQuote = nil
            end
        end
    end

    return depth
end

--- EXTERNAL API: Parses a single clause or value into an AST node
--- This is the recommended external API for parsing single clauses (actions with conditions) or values (for variables).
--- Supports: action-only, action+condition, value-only, NAG:Hidden(), and notes.
--- @usage For group actions: local clause = parser:ParseClause("(condition) and NAG:CastSpell(123)", nil, nil)
--- @usage For variable values: local clause = parser:ParseClause("A and B or C", nil, nil); local value = clause.value or clause.condition
--- @param clause string The clause string to parse (can be action, action+condition, or value-only)
--- @param priority number|nil The priority of this clause (for error reporting)
--- @param clauseIndex number|nil Optional clause index for error reporting
--- @return table|nil The parsed clause node with fields: {action, condition, value, hidden, notes, priority}, or nil on error
function NAGStringParser:ParseClause(clause, priority, clauseIndex)
    -- Debug: Log input type and content
    local clauseType = type(clause)
    if clauseType ~= "string" then
        self:Debug("ParseClause: Received non-string clause (type=%s, priority=%s, index=%s)",
            clauseType, tostring(priority), tostring(clauseIndex))

        -- Handle table input (extract the actual clause string)
        if clauseType == "table" then
            -- Find the first non-comment string in the table
            local actualClause = nil
            for i = 1, #clause do
                local item = clause[i]
                if type(item) == "string" and not string.match(item, "^%s*%-%-") then
                    actualClause = item
                    break
                end
            end

            -- If no non-comment found, try the last element
            if not actualClause and #clause > 0 then
                actualClause = clause[#clause]
            end

            if type(actualClause) == "string" then
                local preview = string.sub(actualClause, 1, 100)
                self:Debug("ParseClause: Extracted clause string from table: '%s'", preview)
                clause = actualClause
            else
                self:Error("ParseClause: Invalid clause input - table contains no valid string (priority=%s, index=%s)",
                    tostring(priority), tostring(clauseIndex))
                return nil
            end
        else
            self:Error("ParseClause: Invalid clause input type - expected string, got %s (priority=%s, index=%s)",
                clauseType, tostring(priority), tostring(clauseIndex))
            return nil
        end
    end

    if not clause or clause == "" then
        self:Warn("ParseClause: Empty clause provided (priority=%d, index=%s)", priority or 0, tostring(clauseIndex))
        return nil
    end

    -- Store clause context for error reporting
    local clauseContext = ""
    if clauseIndex then
        clauseContext = string.format("[Clause #%d, Priority %d] ", clauseIndex, priority or 0)
    elseif priority then
        clauseContext = string.format("[Priority %d] ", priority)
    end

    -- Check if clause starts with NAG:Hidden()
    local isHidden = string.match(clause, "^NAG:Hidden%(%)%s+and")

    -- Strip NAG:Hidden() and for further parsing
    if isHidden then
        clause = string.gsub(clause, "^NAG:Hidden%(%)%s+and%s+", "")
    end

    -- Extract action and condition (pass priority and context for better error messages)
    -- Note: Inline comments are now extracted earlier in ParseRotationString
    -- Both action and condition are now proto AST nodes
    -- Action is optional - can be value-only for variables
    local action, condition = self:ExtractActionAndCondition(clause, priority, clauseContext)

    -- Handle value-only case: if action is nil but condition is set, it's actually a value
    local value = nil
    if not action and condition then
        -- This is a value-only clause (e.g., for variables)
        value = condition
        condition = nil
    end

    -- If both action and condition are nil, parsing failed
    if not action and not value then
        local clausePreview = string.sub(clause, 1, 100) .. (#clause > 100 and "..." or "")
        self:Error("ParseClause: %sFailed to extract action or value from clause (length=%d chars): '%s'",
            clauseContext, #clause, clausePreview)
        return nil
    end

    -- Return structure with proto AST action, condition, and/or value
    -- Always return a table (truthy) even when action is nil
    local result = {
        action = action,  -- Proto AST action node (or nil for value-only)
        condition = condition,  -- Proto AST value node (or nil)
        value = value,  -- Proto AST value node (for value-only clauses)
        originalText = clause,
        hidden = isHidden or false,
        priority = priority
    }

    return result
end

--- Strips unnecessary outer parentheses that wrap an entire clause
--- Only removes parentheses if they are balanced and wrap the entire expression
--- Strip outer parentheses that wrap the entire expression
--- Handles string literals to avoid matching parentheses inside strings
--- @param text string The text to strip parentheses from
--- @param returnUnchanged boolean|nil If true, returns original text unchanged when no stripping occurs (default: true). If false, returns nil when no stripping occurs.
--- @return string|nil The text with outer parentheses removed, or original text if returnUnchanged is true, or nil if returnUnchanged is false and no stripping occurred
function NAGStringParser:StripOuterParentheses(text, returnUnchanged)
    if not text or text == "" then
        return returnUnchanged == false and nil or text
    end

    -- Default to returning unchanged value for backward compatibility
    if returnUnchanged == nil then
        returnUnchanged = true
    end

    local trimmed = text:match("^%s*(.-)%s*$")
    if trimmed:sub(1, 1) ~= "(" then
        return returnUnchanged and text or nil
    end

    -- Check if the outer parentheses are balanced and wrap the entire expression
    -- Handle string literals to avoid matching parentheses inside strings
    local parenLevel = 0
    local inString = false
    local stringQuote = nil
    local wrapsEntire = true

    for i = 1, #trimmed do
        local ch = trimmed:sub(i, i)

        if not inString then
            if ch == '"' or ch == "'" then
                inString = true
                stringQuote = ch
            elseif ch == "(" then
                parenLevel = parenLevel + 1
            elseif ch == ")" then
                if parenLevel == 0 then
                    -- Closing paren before we've seen an opening - shouldn't happen
                    return returnUnchanged and text or nil
                end
                parenLevel = parenLevel - 1
                if parenLevel == 0 then
                    -- Check if remainder is empty (parentheses wrap entire expression)
                    local remainder = trimmed:sub(i + 1)
                    if remainder:match("^%s*$") then
                        -- Outer parens wrap entire expression - strip them
                        local inner = trimmed:sub(2, i - 1)
                        -- Recursively strip if there are multiple layers
                        local result = self:StripOuterParentheses(inner, returnUnchanged)
                        if result then
                            if self.debug then self:Debug("StripOuterParentheses: Stripped outer parentheses: '%s' -> '%s'",
                                trimmed:sub(1, 60) .. (trimmed:len() > 60 and "..." or ""),
                                result:sub(1, 60) .. (result:len() > 60 and "..." or "")) end
                            return result
                        else
                            -- Recursive call returned nil (no more parentheses to strip), but we did strip one layer
                            -- Return the inner string we extracted (we successfully stripped outer parentheses)
                            if self.debug then self:Debug("StripOuterParentheses: Recursive strip returned nil, returning inner: '%s' (first 60 chars)",
                                inner:sub(1, 60) .. (inner:len() > 60 and "..." or "")) end
                            return inner
                        end
                    else
                        -- Parentheses don't wrap entire expression
                        if self.debug then self:Debug("StripOuterParentheses: Parentheses don't wrap entire expression, remainder: '%s'",
                            remainder:sub(1, 60) .. (remainder:len() > 60 and "..." or "")) end
                        return returnUnchanged and text or nil
                    end
                end
            end
        else
            -- Inside string literal
            if ch == "\\" then
                -- Escape character - skip next character
                i = i + 1
            elseif ch == stringQuote then
                inString = false
                stringQuote = nil
            end
        end
    end

    -- If we get here, parentheses aren't balanced or don't wrap entirely
    return returnUnchanged and text or nil
end

--- Detects if an action is nested inside condition parentheses and finds the correct split point
--- @param clause string The clause string
--- @param actionPosition number The position where the NAG action starts
--- @param parenLevelAtAction number The parenthesis level at the action position
--- @return boolean isNested True if action is inside condition parens
--- @return number|nil topLevelSplitPos Position of top-level " and " separator
--- @return string|nil warning Warning message if nested action detected
function NAGStringParser:DetectNestedAction(clause, actionPosition, parenLevelAtAction)
    -- If action is at level 0, it's not nested
    if parenLevelAtAction == 0 then
        return false, nil, nil
    end

    -- Search for " and " at level 0 (top level) before the action
    local currentLevel = 0
    local inString = false
    local stringQuote = nil
    local topLevelAndPos = nil

    for i = 1, actionPosition - 1 do
        local ch = clause:sub(i, i)

        if not inString then
            if ch == '"' or ch == "'" then
                inString = true
                stringQuote = ch
            elseif ch == "(" then
                currentLevel = currentLevel + 1
            elseif ch == ")" then
                currentLevel = currentLevel - 1
            elseif currentLevel == 0 then
                -- Check for " and " at level 0
                local checkAnd = clause:sub(i):match("^%s+and%s+")
                if checkAnd then
                    topLevelAndPos = i
                    -- Don't break - find the LAST " and " at level 0 before action
                end
            end
        else
            if ch == stringQuote then
                inString = false
                stringQuote = nil
            end
        end
    end

    if topLevelAndPos then
        local warning = string.format(
            "Action found inside condition parentheses (nested at level %d). " ..
            "Parsing successfully using top-level separator. " ..
            "Consider reformatting to: (conditions) and NAG:FunctionName(...)",
            parenLevelAtAction
        )
        return true, topLevelAndPos, warning
    end

    return false, nil, nil
end

--- Extracts action and condition from a clause string
--- Enhanced to handle actions nested inside condition parentheses for community-friendly parsing
---
--- Supported patterns:
---   - Standard (preferred): (condition) and NAG:CastSpell(spell)
---   - Single nesting: (condition and NAG:CastSpell(spell))  -- Auto-corrected with warning
---   - Double nesting: ((condition and NAG:CastSpell(spell))) -- Auto-corrected with warning
---   - Complex: (cond1 and cond2) and NAG:CastSpell(spell)
---   - Conditional action: (condition) and (check and NAG:CastSpell(spell1) or NAG:CastSpell(spell2))
---
--- The enhancement detects when a NAG action is nested inside condition parentheses
--- and automatically finds the correct top-level " and " separator. A warning is logged
--- to help contributors learn the preferred format without breaking their rotations.
---
--- INTERNAL: This is an internal helper function only called by ParseClause.
--- External callers should use ParseClause instead.
--- @internal
--- @param clause string The clause string
--- @param priority number|nil The clause priority for better error messages
--- @param clauseContext string|nil Optional context string for error reporting
--- @return table|nil The parsed action, or nil on error
--- @return table|nil The parsed condition, or nil if no condition (or value for value-only input)
function NAGStringParser:ExtractActionAndCondition(clause, priority, clauseContext)
    clauseContext = clauseContext or ""

    local originalClause = clause

    -- Strip inline comments (everything after -- but not inside strings)
    -- e.g., "NAG:CastSpell(123) -- comment" -> "NAG:CastSpell(123)"
    local inString = false
    local stringQuote = nil
    for i = 1, #clause do
        local ch = clause:sub(i, i)
        if not inString then
            if ch == '"' or ch == "'" then
                inString = true
                stringQuote = ch
            elseif clause:sub(i, i+1) == "--" then
                -- Found comment outside of string - strip from here
                clause = clause:sub(1, i - 1)
                break
            end
        else
            if ch == stringQuote then
                inString = false
                stringQuote = nil
            end
        end
    end

    -- Trim trailing whitespace after comment removal
    clause = clause:match("^%s*(.-)%s*$") or clause

    if clause ~= originalClause then
    end

    -- Track whether outer parentheses will be stripped (indicates potential nesting)
    local beforeStrip = clause

    -- Strip unnecessary outer parentheses that wrap the entire clause
    -- e.g., "((condition) and action)" -> "(condition) and action"
    clause = self:StripOuterParentheses(clause)

    local hadOuterParensStripped = (beforeStrip ~= clause)

    -- Strategy: Find the LAST " and " separator at parenthesis level 0
    -- Everything after the last " and " is ALWAYS the action (no need to check if it's an action)
    -- Everything before the last " and " is the condition (contains values)
    -- This avoids incorrectly looking up actions as values

    -- Find the last " and " separator at paren level 0
    -- Also accept ")and " and ") or " (no space before "and"/"or" after closing paren) so that
    -- clauses like "(cond1 or cond2)and NAG:Cast(...)" split correctly instead of being parsed as condition.
    local lastAndPos = nil
    local lastParenAndPos = nil   -- position of ")" before ")and " or ") or "
    local lastParenSkipLen = nil  -- length of ")and " or ") or " to skip after the ")"
    local parenLevel = 0
    local inString = false
    local stringQuote = nil

    -- Scan forward to find the last " and " at paren level 0, or ")and "/") or " at depth 1
    -- Stop at comments (--) to avoid processing comment text
    for i = 1, #clause do
        local ch = clause:sub(i, i)
        if not inString then
            -- Check for comment marker (--) - stop processing at comments
            if clause:sub(i, i+1) == "--" then
                -- Found comment - stop scanning, everything after is comment
                break
            elseif ch == '"' or ch == "'" then
                inString = true
                stringQuote = ch
            elseif ch == "(" then
                parenLevel = parenLevel + 1
            elseif ch == ")" then
                -- Before decrementing: if we're at depth 1 and remainder is ")and " or ") or ", this is a valid split
                if parenLevel == 1 then
                    local afterParen = clause:sub(i + 1)
                    local andMatch = afterParen:match("^(%s*and%s+)")
                    local orMatch = afterParen:match("^(%s*or%s+)")
                    if andMatch or orMatch then
                        lastParenAndPos = i
                        lastParenSkipLen = 1 + #(andMatch or orMatch)
                    end
                end
                parenLevel = parenLevel - 1
            elseif parenLevel == 0 then
                -- Check for " and " at paren level 0
                local checkAnd = clause:sub(i):match("^%s+and%s+")
                if checkAnd then
                    lastAndPos = i
                    --self:Trace("ExtractActionAndCondition: Found 'and' separator at position %d (paren level 0)", i)
                end
            end
        else
            if ch == stringQuote then
                inString = false
                stringQuote = nil
            end
        end
    end

    -- Use the rightmost split so the action part is as short as possible (condition is everything before it)
    local splitConditionEnd = nil   -- last character index of condition
    local splitActionStart = nil    -- first character index of action
    if lastAndPos then
        local checkAnd = clause:sub(lastAndPos):match("^%s+and%s+")
        splitConditionEnd = lastAndPos - 1
        splitActionStart = lastAndPos + #checkAnd
    end
    if lastParenAndPos and lastParenSkipLen then
        local condEnd = lastParenAndPos
        local actStart = lastParenAndPos + lastParenSkipLen
        if not splitActionStart or actStart > splitActionStart then
            splitConditionEnd = condEnd
            splitActionStart = actStart
        end
    end

    if splitConditionEnd and splitActionStart then
        local conditionText = clause:sub(1, splitConditionEnd):match("^%s*(.-)%s*$")
        local actionText = clause:sub(splitActionStart):match("^%s*(.-)%s*$")

        -- Validate the split makes sense
        if conditionText and conditionText ~= "" and actionText and actionText ~= "" then
            -- Use schema to detect if the part after "and" is an action or value
            local SchemaAccessor = NAG:GetModule("SchemaAccessor")
            local detectedType = nil
            if SchemaAccessor then
                detectedType = SchemaAccessor:DetectActionOrValue(actionText)
            end

            -- Fallback: if RHS is parenthesized and not detected as action, the real action may be inside
            -- e.g. ( cond1 and ( cond2 and NAG:Cast(...) ) ) -> we split at first " and " and get RHS = "( cond2 and NAG:Cast(...) )"
            -- Strip and re-split to get condition = cond1 and cond2, action = NAG:Cast(...). Repeat for multiple nesting levels.
            if detectedType ~= "action" and SchemaAccessor then
                local rhs = actionText
                local condAccum = conditionText
                while rhs and rhs:match("^%s*%(") and SchemaAccessor:DetectActionOrValue(rhs) ~= "action" do
                    local inner = self:StripOuterParentheses(rhs)
                    if not inner or inner == rhs or not inner:find("%s+and%s+") then
                        break
                    end
                    local lastAndInner = nil
                    local iInner = 1
                    local lenInner = #inner
                    local depthInner = 0
                    while iInner <= lenInner do
                        local c = inner:sub(iInner, iInner)
                        if c == "(" then
                            depthInner = depthInner + 1
                            iInner = iInner + 1
                        elseif c == ")" then
                            depthInner = depthInner - 1
                            iInner = iInner + 1
                        elseif depthInner == 0 then
                            local check = inner:sub(iInner):match("^%s+and%s+")
                            if check then
                                lastAndInner = iInner
                                iInner = iInner + #check
                            else
                                iInner = iInner + 1
                            end
                        else
                            iInner = iInner + 1
                        end
                    end
                    if not lastAndInner then
                        break
                    end
                    local checkAnd = inner:sub(lastAndInner):match("^%s+and%s+")
                    local condPart = inner:sub(1, lastAndInner - 1):match("^%s*(.-)%s*$")
                    local actPart = inner:sub(lastAndInner + #checkAnd):match("^%s*(.-)%s*$")
                    if not condPart or condPart == "" or not actPart or actPart == "" then
                        break
                    end
                    condAccum = condAccum .. " and " .. condPart
                    rhs = actPart
                    if SchemaAccessor:DetectActionOrValue(rhs) == "action" then
                        conditionText = condAccum
                        actionText = rhs
                        detectedType = "action"
                        break
                    end
                end
            end

            local action = nil
            local condition = nil

            if detectedType == "action" then
                -- Schema says it's an action - parse as action
                action = self:ParseAction(actionText, clauseContext)
                condition = self:ParseCondition(conditionText)
            else
                -- RHS is not a single schema action (e.g. compound: (cond1 and NAG:Cast(A)) or (cond2 and NAG:Cast(B)))
                -- Store as compound_expression so we preserve the line for round-trip; emitter will re-emit verbatim
                condition = self:ParseCondition(conditionText)
                if condition then
                    action = ASTAction.Create("compound_expression", { expression = actionText }, nil)
                end
                if not action or not condition then
                    -- Fallback: treat entire clause as value-only (original behavior)
                    if clause:find("%sor%s") or clause:find("%sand%s") then
                        condition = condition or self:ParseCondition(clause)
                    else
                        condition = condition or self:ParseValue(clause)
                    end
                    if condition then
                        return nil, condition
                    end
                    self:Error("ExtractActionAndCondition: %sFailed to parse as value or compound expression", clauseContext)
                    return nil, nil
                end
            end

            if action and condition then
            elseif action then
                self:Warn("ExtractActionAndCondition: %sExtracted action but condition parsing failed", clauseContext)
            elseif condition then
                self:Warn("ExtractActionAndCondition: %sExtracted condition but action parsing failed (may be value expression)", clauseContext)
                -- If action parsing failed but we have a condition, return the condition as value
                return nil, condition
            else
                self:Error("ExtractActionAndCondition: %sBoth action and condition parsing failed", clauseContext)
            end

            return action, condition
        else
            self:Error("ExtractActionAndCondition: %sSplit produced empty parts - condition: '%s', action: '%s'",
                clauseContext, tostring(conditionText), tostring(actionText))
        end
    end

    -- No " and " separator found - use schema to detect if it's an action or value
    local SchemaAccessor = NAG:GetModule("SchemaAccessor")
    local detectedType = nil
    if SchemaAccessor then
        detectedType = SchemaAccessor:DetectActionOrValue(clause)
    end

    if detectedType == "action" then
        -- Schema says it's an action - parse as action
        local action = self:ParseAction(clause, clauseContext)
        if action then
            return action, nil
        else
            self:Warn("ExtractActionAndCondition: %sSchema detected action but parsing failed, trying as value", clauseContext)
            -- Fall through to value parsing
        end
    end

    -- Schema says it's a value, or action parsing failed, or unknown - parse as value/condition
    local value = nil

    -- Check if it contains logical operators (and/or) - use ParseCondition
    if clause:find("%sor%s") or clause:find("%sand%s") then
        value = self:ParseCondition(clause)
    else
        -- No logical operators - use ParseValue
        value = self:ParseValue(clause)
    end

    if value then
        -- Return nil action and value as condition (will be handled by ParseClause)
        return nil, value
    else
        self:Error("ExtractActionAndCondition: %sFailed to parse as value/condition", clauseContext)
        return nil, nil
    end
end

-- ============================ HELPER FUNCTIONS FOR PROTO AST BUILDING ============================

--- Extract scalar value from proto AST node or raw value
--- @param valueNode table|any Proto AST node or raw value
--- @return any The extracted scalar value
local function ExtractProtoValue(valueNode)
    if not valueNode then
        return nil
    end

    -- If it's already a proto AST node, extract the constant value
    if type(valueNode) == "table" and valueNode.type == ASTCore.NodeType.VALUE then
        local valueType = ASTValue.GetValueType(valueNode)
        if valueType == ASTValue.ValueType.CONST then
            local valueData = ASTValue.GetValueData(valueNode)
            local val = valueData and valueData.val
            -- Handle nil constants specially - check if this is explicitly a nil constant (marked during parsing)
            if valueNode.isNil == true or val == nil then
                return nil  -- Return actual nil, not string "nil"
            end
            return val
        end

        -- For NOT nodes, extract from the operand (val field)
        -- This allows normalization of values wrapped in NOT operators
        if valueType == ASTValue.ValueType.NOT then
            local valueData = ASTValue.GetValueData(valueNode)
            if valueData and valueData.val then
                -- Recursively extract from the operand
                -- This unwraps NOT(NAG:AuraIsActive(76093)) -> extracts 76093
                return ExtractProtoValue(valueData.val)
            end
        end

        -- For AND/OR nodes, we can't extract a single scalar value
        -- These should be handled as full nodes in normalization
        -- For non-const values, return the node itself (for nested structures)
        return valueNode
    end

    -- Legacy clause format detected - should not happen in production code
    if type(valueNode) == "table" and valueNode.type == "constant" and valueNode.value ~= nil then
        module:Error(format("[NAGStringParser] Legacy format constant node detected - should be proto AST"))
        -- Fail fast: return nil instead of attempting fallback
        return nil
    end

    -- Raw value
    return valueNode
end

--- Extracts all NAG function calls from text with their positions
--- @param text string The text to search
--- @return table Array of function call entries: {startPos, endPos, fullText, functionName}
function NAGStringParser:ExtractNAGFunctionCalls(text)
    local results = {}
    local i = 1

    -- Stop scanning at comments (--) - actions can't be in comments
    local commentPos = nil
    local inString = false
    local stringQuote = nil
    for j = 1, #text do
        local ch = text:sub(j, j)
        if not inString then
            if ch == '"' or ch == "'" then
                inString = true
                stringQuote = ch
            elseif text:sub(j, j+1) == "--" then
                commentPos = j
                break
            end
        else
            if ch == stringQuote then
                inString = false
                stringQuote = nil
            end
        end
    end
    local textEnd = commentPos and (commentPos - 1) or #text

    while i <= textEnd do
        -- Check for "NAG:" at current position
        -- Allow optional whitespace between function name and opening paren (handles "NAG:Func ()" or "NAG:Func()")
        local nagMatch, spaceAfterName = text:sub(i):match("^NAG:(%w+)%s*(%()")
        if nagMatch then
            local startPos = i
            local functionName = nagMatch
            -- Skip past "NAG:", function name, optional whitespace, and opening paren
            local j = i + 4 + #functionName + (spaceAfterName and #spaceAfterName or 0)  -- "NAG:" = 4 chars

            -- Find matching closing paren
            local parenLevel = 0
            local inString = false
            local stringQuote = nil

            while j <= textEnd do
                local ch = text:sub(j, j)
                if not inString then
                    -- Stop at comments
                    if text:sub(j, j+1) == "--" then
                        break  -- Comment found, stop scanning
                    elseif ch == '"' or ch == "'" then
                        inString = true
                        stringQuote = ch
                    elseif ch == "(" then
                        parenLevel = parenLevel + 1
                    elseif ch == ")" then
                        if parenLevel == 0 then
                            -- Found matching closing paren
                            local endPos = j
                            local fullText = text:sub(startPos, endPos)
                            table.insert(results, {
                                startPos = startPos,
                                endPos = endPos,
                                fullText = fullText,
                                functionName = functionName
                            })
                            i = j + 1
                            break
                        else
                            parenLevel = parenLevel - 1
                        end
                    end
                else
                    if ch == stringQuote then
                        inString = false
                        stringQuote = nil
                    end
                end
                j = j + 1
            end

            if j > #text then
                -- Didn't find closing paren, skip to end
                break
            end
        else
            i = i + 1
        end
    end

    return results
end

--- Parses an action string into an AST node
--- Enhanced with pre-validation, retry logic, and diagnostic logging
--- @param actionText string The action text
--- @param clauseContext string|nil Optional context string for error reporting (e.g., "[Clause #1]")
--- @return table|nil The parsed action node, or nil on error
function NAGStringParser:ParseAction(actionText, clauseContext)
    clauseContext = clauseContext or ""

    -- Handle table input (array of strings) - join them with newlines
    if type(actionText) == "table" then
        if #actionText == 0 then
            self:Warn("ParseAction: %sEmpty action table provided", clauseContext)
            return nil
        end
        -- Join table elements with newlines (filter out comments and empty strings)
        local actionLines = {}
        for i, line in ipairs(actionText) do
            if type(line) == "string" and line ~= "" and not line:match("^%s*%-%-") then
                tinsert(actionLines, line)
            end
        end
        if #actionLines == 0 then
            self:Warn("ParseAction: %sAction table contains only comments or empty strings", clauseContext)
            return nil
        end
        actionText = table.concat(actionLines, " ")
    end

    if not actionText or actionText == "" then
        self:Warn("ParseAction: %sEmpty action text provided", clauseContext)
        return nil
    end

    -- Ensure actionText is a string at this point
    if type(actionText) ~= "string" then
        self:Error("ParseAction: %sInvalid actionText type: %s (expected string)", clauseContext, type(actionText))
        return nil
    end

    local originalText = actionText

    -- Pre-validation: Check for common issues before pattern matching
    local prevalidationIssue = nil

    -- Strip outer parentheses that may wrap the action (e.g., "(NAG:CancelMeta() or NAG:CastPlaceholder(...))")
    -- This handles cases where the action is part of a logical expression
    local beforeStrip = actionText
    actionText = self:StripOuterParentheses(actionText)

    -- Check for leading/trailing whitespace
    if actionText:match("^%s") or actionText:match("%s$") then
        prevalidationIssue = "Leading or trailing whitespace detected"
        actionText = actionText:match("^%s*(.-)%s*$")
    end

    -- CRITICAL: Check for multiple actions (invalid - APLAction can only have one action)
    -- Pattern: Look for "NAG:" followed by function name, then "or" or "and", then another "NAG:"
    -- This handles cases like: "(NAG:CancelMeta() or NAG:CastPlaceholder(...))" or "NAG:CastSpell(123) or NAG:CastSpell(456)"
    local function CountNAGFunctionCalls(text)
        local count = 0
        local i = 1

        while i <= #text do
            -- Check for "NAG:" at current position
            -- Allow optional whitespace between function name and opening paren (handles "NAG:Func ()" or "NAG:Func()")
            local nagMatch, spaceAfterName = text:sub(i):match("^NAG:(%w+)%s*(%()")
            if nagMatch then
                count = count + 1
                -- Skip past this NAG function call by finding matching closing paren
                local parenLevel = 0
                local inString = false
                local stringQuote = nil
                -- Skip past "NAG:", function name, optional whitespace, and opening paren
                local spaceLen = spaceAfterName and #spaceAfterName or 0
                local j = i + 4 + #nagMatch + spaceLen

                while j <= #text do
                    local ch = text:sub(j, j)
                    if not inString then
                        if ch == '"' or ch == "'" then
                            inString = true
                            stringQuote = ch
                        elseif ch == "(" then
                            parenLevel = parenLevel + 1
                        elseif ch == ")" then
                            if parenLevel == 0 then
                                -- Found matching closing paren
                                i = j + 1
                                break
                            else
                                parenLevel = parenLevel - 1
                            end
                        end
                    else
                        if ch == stringQuote then
                            inString = false
                            stringQuote = nil
                        end
                    end
                    j = j + 1
                end

                if j > #text then
                    -- Didn't find closing paren, skip to end
                    break
                end
            else
                i = i + 1
            end
        end

        return count
    end

    local actionCount = CountNAGFunctionCalls(actionText)

    if actionCount > 1 then
        -- Extract all NAG function calls
        local functionCalls = self:ExtractNAGFunctionCalls(actionText)

        if #functionCalls > 0 then

            -- Select the last (rightmost) action
            local lastAction = functionCalls[#functionCalls]
            local extractedActionText = lastAction.fullText

            -- Extract action names for warning message
            local actionNames = {}
            for _, call in ipairs(functionCalls) do
                table.insert(actionNames, call.functionName)
            end
            local actionList = table.concat(actionNames, ", ")

            -- Log warning that we're using the last action
            self:Warn("ParseAction: %sMultiple actions detected (%d actions: %s). Using last action: %s (position %d-%d). " ..
                "Full action text: '%s'",
                clauseContext, actionCount, actionList, lastAction.functionName,
                lastAction.startPos, lastAction.endPos,
                originalText:sub(1, 200) .. (originalText:len() > 200 and "..." or ""))

            -- Replace actionText with the extracted last action
            actionText = extractedActionText
            -- Trim any leading/trailing whitespace from the extracted action
            actionText = actionText:match("^%s*(.-)%s*$")
        else
            -- Fallback: if extraction failed, error out
            self:Error("ParseAction: %sInvalid: Multiple actions detected but failed to extract them. " ..
                "Full action text: '%s'",
                clauseContext, originalText:sub(1, 200) .. (originalText:len() > 200 and "..." or ""))
            return nil
        end
    end

    -- Check for incomplete NAG function pattern
    if actionText:match("^NAG:%w*$") then
        -- Just "NAG:" or "NAG:Function" with no parentheses
        self:Error("ParseAction: %sIncomplete NAG function (missing parentheses): '%s'. Cannot create action without valid syntax.",
            clauseContext, originalText)
        return nil
    end

    if actionText:match("^NAG:%w+%([^%)]*$") then
        -- NAG function with opening paren but no closing paren
        self:Error("ParseAction: %sIncomplete NAG function (missing closing parenthesis): '%s'. Cannot create action without valid syntax.",
            clauseContext, originalText)
        return nil
    end

    -- Check for space between NAG and colon or function name and opening paren
    if actionText:match("^NAG%s+:") or actionText:match("^NAG:%w+%s+%(") then
        local issue = actionText:match("^NAG%s+:") and "space between 'NAG' and ':'" or "space between function name and '('"
        self:Error("ParseAction: %sInvalid spacing in NAG function call (%s): '%s'. Cannot create action without valid syntax.",
            clauseContext, issue, originalText)
        return nil
    end

    -- Extract ANY NAG function call generically: NAG:FunctionName(args)
    -- NOTE: Pattern matching happens AFTER multiple action detection/extraction above
    -- So at this point, actionText should contain only a single action
    local functionName, argsText = actionText:match("^NAG:(%w+)%((.*)%)$")

    if functionName then
        -- Safety check: If argsText contains " or NAG:" or " and NAG:", the pattern matched incorrectly
        -- This can happen if multiple action detection failed or the pattern is too greedy
        if argsText and (argsText:match("%s+or%s+NAG:") or argsText:match("%s+and%s+NAG:")) then
            self:Warn("ParseAction: %sPattern matched but argsText contains another NAG function! " ..
                "This suggests multiple actions weren't properly extracted. Args: '%s'",
                clauseContext, argsText:sub(1, 100) .. (argsText:len() > 100 and "..." or ""))
            -- Try to extract the last action as fallback
            local functionCalls = self:ExtractNAGFunctionCalls(originalText)
            if #functionCalls > 1 then
                local lastAction = functionCalls[#functionCalls]
                self:Warn("ParseAction: %sFallback: Extracting last action instead: %s", clauseContext, lastAction.functionName)
                actionText = lastAction.fullText
                actionText = actionText:match("^%s*(.-)%s*$")  -- Trim whitespace
                functionName, argsText = actionText:match("^NAG:(%w+)%((.*)%)$")
                if not functionName then
                    self:Error("ParseAction: %sFallback extraction failed to match pattern", clauseContext)
                    return nil
                end
            end
        end

        -- Parse the arguments using existing ParseFunctionArgs method (returns proto AST nodes)
        local args = self:ParseFunctionArgs(argsText or "")

        -- Resolve metadata to get action type and schema
        -- Use SchemaAccessor:GetMetadataByIdentifier with auto-detection (single source of truth)
        local SchemaAccessor = NAG:GetModule("SchemaAccessor")

        -- Check nagFunctionMappings first (e.g., "Cast" -> "APLActionCastSpell")
        local snakeIdentifier = nil
        if SchemaAccessor and SchemaAccessor.nagFunctionMappings and SchemaAccessor.nagFunctionMappings[functionName] then
            local protoName = SchemaAccessor.nagFunctionMappings[functionName]
            -- Extract action name from proto name (e.g., "APLActionCastSpell" -> "CastSpell")
            local actionName = protoName:match("^APLAction(.+)$")
            if actionName then
                snakeIdentifier = SchemaUtils:CamelToSnake(actionName)
            end
        end

        -- If no mapping, convert functionName directly to snake_case
        if not snakeIdentifier then
            snakeIdentifier = SchemaUtils:CamelToSnake(functionName)
        end

        local metadata = nil
        if snakeIdentifier and SchemaAccessor then
            metadata = SchemaAccessor:GetMetadataByIdentifier(snakeIdentifier, nil)  -- Use auto-detection
        end

        if not metadata or not metadata.actionType then
            self:Error("ParseAction: GetMetadataByIdentifier failed for functionName='%s' (snakeIdentifier='%s') - metadata=%s, actionType=%s. Cannot create action without valid metadata.",
                functionName or "nil",
                snakeIdentifier or "nil",
                metadata and "table" or "nil",
                metadata and metadata.actionType or "nil")
            -- Return nil - no fallback to generic action (single source of truth)
            return nil
        end

        -- Build action data from arguments using schema
        -- DEBUG: Special logging for SelectRotation
        if functionName == "SelectRotation" then
            if self.debug then self:Debug("ParseAction: SelectRotation DEBUG - functionName='%s', #args=%d", functionName, #args) end
            for i, arg in ipairs(args) do
                local extracted = ExtractProtoValue(arg)
                if self.debug then self:Debug("ParseAction: SelectRotation DEBUG - args[%d]: type=%s, extracted=%s, arg=%s",
                    i, type(arg), tostring(extracted), type(arg) == "table" and TableUtils.ToString(arg, 1) or tostring(arg)) end
            end
        end

        local actionData = self:BuildActionDataFromMetadata(functionName, args, metadata)

        -- DEBUG: Special logging for SelectRotation after BuildActionDataFromMetadata
        if functionName == "SelectRotation" then
            if self.debug then self:Debug("ParseAction: SelectRotation DEBUG - actionData after BuildActionDataFromMetadata: %s",
                actionData and TableUtils.ToString(actionData, 2) or "nil") end
            if actionData then
                if self.debug then self:Debug("ParseAction: SelectRotation DEBUG - actionData.rotation_name=%s",
                    tostring(actionData.rotation_name)) end
            end
        end

        if not actionData then
            self:Error("ParseAction: BuildActionDataFromMetadata failed for functionName='%s'. Cannot create action without valid data.",
                functionName or "nil")
            -- Return nil - no fallback to generic action (single source of truth)
            return nil
        end

        -- Create proto action node (condition added later in ParseClause)
        local protoAction = ASTAction.Create(metadata.actionType, actionData, nil)

        if not protoAction then
            self:Error("ParseAction: ASTAction.Create failed for actionType='%s' (functionName='%s'). Cannot create action node.",
                tostring(metadata.actionType), functionName or "nil")
            -- Return nil - no fallback to generic action (single source of truth)
            return nil
        end

        -- CRITICAL: Verify protoAction is proto AST, not legacy format
        local ASTCore = ns.ASTCore
        if protoAction.type ~= ASTCore.NodeType.ACTION then
            self:Error("[NAGStringParser] ParseAction: protoAction.type is '%s' (expected ASTCore.NodeType.ACTION=%s) - legacyAST may have leaked through!",
                tostring(protoAction.type), tostring(ASTCore.NodeType.ACTION))
        end
        -- Check for legacy fields (arguments) - error logged if detected
        -- Note: protoAction.arguments check removed - legacy field should not exist
        if not protoAction.action or type(protoAction.action) ~= "table" then
            self:Error("[NAGStringParser] ParseAction: protoAction missing 'action' proto structure - legacyAST leaked through!")
        end

        -- Note: originalText removed - use ASTSchemaEmitter.EmitActionNode(node) for text synthesis

        return protoAction
    else
        -- Pattern match failed - provide diagnostic information

        -- Detailed diagnostic analysis
        local diagnosticInfo = {}
        table.insert(diagnosticInfo, string.format("Length: %d chars", #actionText))

        -- Check what part of the pattern failed
        if not actionText:match("^NAG:") then
            table.insert(diagnosticInfo, "Does not start with 'NAG:'")
        elseif not actionText:match("^NAG:%w+") then
            table.insert(diagnosticInfo, "Invalid or missing function name after 'NAG:'")
        elseif not actionText:match("%(") then
            table.insert(diagnosticInfo, "Missing opening parenthesis")
        elseif not actionText:match("%)$") then
            table.insert(diagnosticInfo, "Does not end with closing parenthesis")
        else
            -- Pattern is close but still failed - might be nested parens or other issue
            local openCount = select(2, actionText:gsub("%(", ""))
            local closeCount = select(2, actionText:gsub("%)", ""))
            if openCount ~= closeCount then
                table.insert(diagnosticInfo, string.format("Unbalanced parentheses (open:%d, close:%d)", openCount, closeCount))
            else
                table.insert(diagnosticInfo, "Pattern is close but failed - possibly non-word chars in function name")
            end
        end

        -- Log diagnostic information
        local truncatedInput = originalText:sub(1, 100) .. (originalText:len() > 100 and "..." or "")
        local detailParts = { "input=" .. truncatedInput }
        for _, info in ipairs(diagnosticInfo) do
            detailParts[#detailParts + 1] = info
        end
        self:Error("ParseAction: %sFailed to match NAG function pattern: %s. Cannot create action without valid syntax. Full clause text (first 200 chars): '%s'",
            clauseContext, table.concat(diagnosticInfo, "; "), originalText:sub(1, 200) .. (originalText:len() > 200 and "..." or ""))
        -- Return nil - no fallback to generic action (single source of truth)
        return nil
    end
end

--- Parses a cast action
--- @param actionText string The cast action text
--- @return table The parsed cast action node
function NAGStringParser:ParseCastAction(actionText)
    local spellId = actionText:match("NAG:Cast%(([^%)]+)%)")
    return {
        type = "cast",
        spellId = spellId,
        originalText = actionText
    }
end

--- Parses a channel action
--- @param actionText string The channel action text
--- @return table The parsed channel action node
function NAGStringParser:ParseChannelAction(actionText)
    local spellId = actionText:match("NAG:ChannelSpell%(([^%)]+)%)")
    return {
        type = "channel",
        spellId = spellId,
        originalText = actionText
    }
end

--- Parses a wait action
--- @param actionText string The wait action text
--- @return table The parsed wait action node
function NAGStringParser:ParseWaitAction(actionText)
    local duration = actionText:match("NAG:Wait%(([^%)]+)%)")
    local numericDuration = tonumber(duration)
    if duration and numericDuration == nil then
        self:Info("[StringParser] ParseWaitAction duration coerced to string (duration=%s)", duration)
    end
    return {
        type = "wait",
        duration = numericDuration or duration,
        originalText = actionText
    }
end

--- Parses a sequence action
--- @param actionText string The sequence action text
--- @return table The parsed sequence action node
function NAGStringParser:ParseSequenceAction(actionText)
    local sequenceName = actionText:match("NAG:StrictSequence%(([^%)]+)%)")
    return {
        type = "sequence",
        sequenceName = sequenceName,
        originalText = actionText
    }
end

--- INTERNAL: Parses a condition string into an AST node
--- This is an internal function used by ParseClause. External callers should use ParseClause instead.
--- @internal
--- @param conditionText string The condition text
--- @return table|nil The parsed condition node, or nil on error
function NAGStringParser:ParseCondition(conditionText)
    if not conditionText or conditionText == "" then
        return nil
    end

    -- Preserve original text before stripping outer parentheses
    -- This ensures serialization restores user-authored parentheses
    local originalConditionText = conditionText

    -- Strip unnecessary outer parentheses BEFORE parsing
    -- This normalizes (not condition) → not condition
    -- Ensures NOT is parsed as logical operator node consistently
    local strippedConditionText = self:StripOuterParentheses(conditionText)
    if strippedConditionText ~= conditionText then
    end

    -- ALWAYS use the precedence parser (ParseOrExpression)
    -- This ensures NOT is properly parsed as a logical operator node
    -- even when it's the only condition (no and/or present)
    -- The precedence parser chain: OR → AND → Primary → handles NOT correctly
    local result = self:ParseLogicalCondition(strippedConditionText)

    if not result then
        self:Error("ParseCondition: Failed to parse condition text: '%s'",
            conditionText:sub(1, 100) .. (#conditionText > 100 and "..." or ""))
        return nil
    end

    -- Note: originalText removed - use ASTSchemaEmitter.EmitValueNode(node) for text synthesis

    return result
end

--- Parses a logical condition with proper precedence: AND > OR
--- This is the entry point for parsing logical expressions
--- @param conditionText string The condition text (e.g., "(A and B) or C")
--- @return table The parsed condition node in APL-compatible format
function NAGStringParser:ParseLogicalCondition(conditionText)
    -- Strip leading/trailing whitespace
    conditionText = conditionText:match("^%s*(.-)%s*$") or ""

    -- Use new recursive descent parser with proper precedence
    return self:ParseOrExpression(conditionText)
end

-- ============================ POSITION-BASED PARSING HELPERS ============================

--- Validate that position tracking is properly initialized
--- @return boolean True if position tracking is valid, false otherwise
function NAGStringParser:validatePositionTracking()
    return self.expr ~= nil and self.pos ~= nil and self.len ~= nil and
           type(self.expr) == "string" and type(self.pos) == "number" and type(self.len) == "number" and
           self.pos >= 1 and self.len >= 0
end

--- Skip whitespace at current position
--- Advances self.pos past any whitespace characters
function NAGStringParser:skipWhitespace()
    if not self:validatePositionTracking() then
        return  -- Can't skip whitespace without valid position tracking
    end
    while self.pos <= self.len and self.expr:sub(self.pos, self.pos):match("%s") do
        self.pos = self.pos + 1
    end
end

--- Peek at current character without consuming it
--- @return string|nil The current character or nil if at end
function NAGStringParser:peek()
    self:skipWhitespace()
    if self.pos > self.len then return nil end
    return self.expr:sub(self.pos, self.pos)
end

--- Consume a specific character if present
--- @param ch string The character to consume
--- @return boolean True if consumed, false otherwise
function NAGStringParser:consume(ch)
    self:skipWhitespace()
    if self.pos > self.len or self.expr:sub(self.pos, self.pos) ~= ch then
        return false
    end
    self.pos = self.pos + 1
    return true
end

--- Consume a word with word boundary checks
--- @param word string The word to consume ("and", "or", "not")
--- @return boolean True if consumed, false otherwise
function NAGStringParser:consumeWord(word)
    self:skipWhitespace()
    if not self:validatePositionTracking() then
        return false  -- Can't consume word without valid position tracking
    end
    local wordLen = #word
    if self.pos + wordLen - 1 > self.len then return false end
    local matched = self.expr:sub(self.pos, self.pos + wordLen - 1):lower()
    if matched == word:lower() then
        -- Check word boundary (space, paren, bracket, comma, or end)
        local after = self.pos + wordLen <= self.len and self.expr:sub(self.pos + wordLen, self.pos + wordLen) or ""
        if after == "" or after:match("%s") or after:match("[%)%]%,]") then
            self.pos = self.pos + wordLen
            return true
        end
    end
    return false
end

--- Parse a string literal (handles escape sequences)
--- @return string|nil The parsed string literal including quotes, or nil if not a string
function NAGStringParser:parseString()
    local ch = self:peek()
    if ch ~= '"' and ch ~= "'" then return nil end
    local start = self.pos
    self.pos = self.pos + 1  -- Skip opening quote
    while self.pos <= self.len do
        local curr = self.expr:sub(self.pos, self.pos)
        if curr == "\\" then
            self.pos = self.pos + 2  -- Skip escape sequence
        elseif curr == ch then
            self.pos = self.pos + 1  -- Skip closing quote
            return self.expr:sub(start, self.pos - 1)
        else
            self.pos = self.pos + 1
        end
    end
    return nil  -- Unterminated string
end

--- Parse balanced parentheses (handles nested parens and strings)
--- @return string|nil The full parentheses text including outer parens, or nil on failure
--- @return number|nil The start position of inner content (after opening paren), or nil on failure
--- @return number|nil The end position of inner content (before closing paren), or nil on failure
function NAGStringParser:parseParens()
    local originalPos = self.pos
    if not self:consume("(") then
        if self.debug then self:Debug("parseParens: Failed to consume '(' at pos=%d", originalPos) end
        return nil
    end
    local start = self.pos - 1  -- Position of opening '('
    local innerStart = self.pos  -- Position of first character after '('
    local level = 1
    local inString = false
    local stringQuote = nil

    while self.pos <= self.len do
        local ch = self.expr:sub(self.pos, self.pos)
        if not inString then
            if ch == "(" then
                level = level + 1
            elseif ch == ")" then
                level = level - 1
                if level == 0 then
                    local innerEnd = self.pos - 1  -- Position of last character before closing ')'
                    self.pos = self.pos + 1  -- Advance past closing ')'
                    local text = self.expr:sub(start, self.pos - 1)
                    local innerText = self.expr:sub(innerStart, innerEnd)
                    return text, innerStart, innerEnd
                end
            elseif ch == '"' or ch == "'" then
                inString = true
                stringQuote = ch
            end
        else
            if ch == stringQuote then
                inString = false
                stringQuote = nil
            elseif ch == "\\" then
                self.pos = self.pos + 1  -- Skip escape
                if self.pos <= self.len then
                    self.pos = self.pos + 1  -- Skip escaped character
                end
            end
        end
        self.pos = self.pos + 1
    end

    -- Unterminated parentheses
    self:Error("parseParens: Unterminated parentheses: level=%d, pos=%d, len=%d", level, self.pos, self.len)
    return nil
end

--- Parse OR expression (lowest precedence)
--- Uses position-based recursive descent parsing
--- @param condStr string The condition string
--- @return table AST node
function NAGStringParser:ParseOrExpression(condStr)
    if not condStr or condStr == "" then
        return nil
    end

    -- CRITICAL: Strip outer parentheses before parsing
    -- This handles cases where ParsePrimaryExpression passes double-parenthesized expressions like ((A and B) or (C or D))
    -- ParseCondition does this, but ParsePrimaryExpression calls ParseOrExpression directly
    local strippedCondStr = self:StripOuterParentheses(condStr)
    if strippedCondStr ~= condStr then
        condStr = strippedCondStr
    end

    -- Set up position tracking
    self.expr = condStr
    self.pos = 1
    self.len = #condStr

    -- Parse left operand
    local left = self:ParseAndExpression()
    if not left then
        self:Warn("ParseOrExpression: Failed to parse left operand")
        return nil
    end

    -- Collect children for OR node
    local children = {left}
    local originalText = condStr


    -- Loop consuming 'or' operators
    while self:consumeWord("or") do
        local right = self:ParseAndExpression()
        if not right then
            self:Warn("ParseOrExpression: Failed to parse right operand after 'or'")
            break
        end
        table.insert(children, right)
    end

    -- Build OR node if we have multiple children
    if #children > 1 then
        local orNode = ASTValue.CreateOr(children)
        if not orNode then
            self:Error("ParseOrExpression: Failed to create OR node with %d children", #children)
            return nil
        end

        -- Note: originalText removed - use ASTSchemaEmitter.EmitValueNode(node) for text synthesis
        return orNode
    end

    -- Single operand, return it directly
    return left
end

--- Parse AND expression (higher precedence than OR)
--- Uses position-based recursive descent parsing
--- @param condStr string|nil The condition string (optional if called from ParseOrExpression)
--- @return table AST node
function NAGStringParser:ParseAndExpression(condStr)
    -- If condStr is provided, set up position tracking (called directly)
    -- Otherwise, use existing position tracking (called from ParseOrExpression)
    if condStr then
        self.expr = condStr
        self.pos = 1
        self.len = #condStr
    end

    if not self:validatePositionTracking() then
        return nil
    end

    if self.pos > self.len then
        return nil
    end

    -- Parse left operand
    local left = self:ParsePrimaryExpression()
    if not left then
        self:Warn("ParseAndExpression: Failed to parse left operand")
        return nil
    end


    -- Collect children for AND node
    local children = {left}
    local originalText = condStr or self.expr

    -- Loop consuming 'and' operators
    while self:consumeWord("and") do
        local right = self:ParsePrimaryExpression()
        if not right then
            self:Warn("ParseAndExpression: Failed to parse right operand after 'and'")
            break
        end
        table.insert(children, right)
    end

    -- Build AND node if we have multiple children
    if #children > 1 then
        local andNode = ASTValue.CreateAnd(children)
        if not andNode then
            self:Error("ParseAndExpression: Failed to create AND node with %d children", #children)
            return nil
        end
        -- Note: originalText removed - use ASTSchemaEmitter.EmitValueNode(node) for text synthesis
        return andNode
    end

    -- Single operand, return it directly
    return left
end

--- Find top-level comparison operator in condition text
--- @param conditionText string The condition text to search
--- @return string|nil The comparison operator found (>=, <=, ==, !=, ~=, >, <)
--- @return number|nil The position where the operator was found
local function FindTopLevelComparison(conditionText)
    if not conditionText or conditionText == "" then
        return nil, nil
    end

    local length = #conditionText
    local index = 1
    local depth = 0
    local inString = false
    local stringQuote

    while index <= length do
        local char = conditionText:sub(index, index)

        if inString then
            if char == "\\" then
                index = index + 1
            elseif char == stringQuote then
                inString = false
                stringQuote = nil
            end
        else
            if char == '"' or char == "'" then
                inString = true
                stringQuote = char
            elseif char == "(" then
                depth = depth + 1
            elseif char == ")" then
                if depth > 0 then
                    depth = depth - 1
                end
            elseif depth == 0 then
                local twoChar = conditionText:sub(index, index + 1)
                if twoChar == ">=" or twoChar == "<=" or twoChar == "==" or twoChar == "!=" or twoChar == "~=" then
                    return twoChar, index
                end

                if char == ">" or char == "<" then
                    return char, index
                end
            end
        end

        index = index + 1
    end

    return nil, nil
end

--- Find position of first top-level logical operator in text
--- Similar to FindTopLevelComparison but for logical operators (and, or)
--- Used to enforce proper operator precedence: comparisons bind tighter than logical operators
--- @param text string The text to search
--- @return number|nil The position where the first logical operator was found (1-based)
--- @return string|nil The operator found ("and" or "or")
local function FindTopLevelLogicalOperator(text)
    if not text or text == "" then
        return nil, nil
    end

    local length = #text
    local index = 1
    local depth = 0
    local inString = false
    local stringQuote

    while index <= length do
        local char = text:sub(index, index)

        if inString then
            if char == "\\" then
                index = index + 1
            elseif char == stringQuote then
                inString = false
                stringQuote = nil
            end
        else
            if char == '"' or char == "'" then
                inString = true
                stringQuote = char
            elseif char == "(" then
                depth = depth + 1
            elseif char == ")" then
                if depth > 0 then
                    depth = depth - 1
                end
            elseif depth == 0 then
                -- Check for logical operators at depth 0
                -- Match pattern: optional whitespace + operator + required whitespace
                local ahead = text:sub(index)
                local orPattern = "^(%s*)or(%s+)"
                local andPattern = "^(%s*)and(%s+)"
                local wsBeforeOr, wsAfterOr = ahead:match(orPattern)
                local wsBeforeAnd, wsAfterAnd = ahead:match(andPattern)

                if wsBeforeOr then
                    return index, "or"
                elseif wsBeforeAnd then
                    return index, "and"
                end
            end
        end

        index = index + 1
    end

    return nil, nil
end

--- Parse primary expression (comparisons, function calls, parentheses, negation)
--- This is the highest precedence level
--- Uses position-based recursive descent parsing
--- @param condStr string|nil The condition string (optional if called from ParseAndExpression)
--- @return table|nil AST node
function NAGStringParser:ParsePrimaryExpression(condStr)
    -- If condStr is provided, set up position tracking (called directly)
    -- Otherwise, use existing position tracking (called from ParseAndExpression)
    if condStr then
        self.expr = condStr:match("^%s*(.-)%s*$") or ""
        self.pos = 1
        self.len = #self.expr
    end

    if not self.expr or self.pos > self.len then
        return nil
    end


    -- Save original position for originalText
    local originalStartPos = self.pos
    local originalText = condStr or self.expr

    -- Handle parentheses - use parseParens() helper
    if self:peek() == "(" then
        local parenText, innerStart, innerEnd = self:parseParens()
        if parenText then
            -- Expression was wrapped in parentheses, parse inner and preserve wrapper
            if self.debug then self:Debug("ParsePrimaryExpression: Found parentheses: innerStart=%d, innerEnd=%d, innerExpr length=%d",
                innerStart, innerEnd, innerEnd - innerStart + 1) end

            -- Extract inner expression and parse it
            local innerExpr = self.expr:sub(innerStart, innerEnd)
            if self.debug then self:Debug("ParsePrimaryExpression: Extracted inner expression (first 100 chars): '%s'",
                innerExpr:sub(1, 100) .. (innerExpr:len() > 100 and "..." or "")) end

            -- Check if there's more content after the parentheses
            -- CRITICAL: If we're inside ParseOrExpression and there's more content after
            -- the closing paren (like "or (...)"), we need to let the CALLER continue parsing,
            -- not consume everything here. The position is already advanced past the closing paren,
            -- so the outer ParseOrExpression will find the remaining "or" operators.
            local rawRemainingText = self.pos <= self.len and self.expr:sub(self.pos) or ""
            local remainingAfterParen = rawRemainingText:match("^%s*(.-)%s*$") or ""
            -- Calculate how much leading whitespace was stripped
            local leadingWhitespaceLen = 0
            if rawRemainingText ~= "" then
                local leadingWhitespace = rawRemainingText:match("^(%s*)")
                leadingWhitespaceLen = leadingWhitespace and #leadingWhitespace or 0
            end
            if remainingAfterParen ~= "" then

                -- If content after closing paren starts with "and" or "or", this is the next conjunct in an AND/OR
                -- chain (e.g. "(not A) and B > c"), not "(expr) op rhs". Do not treat as comparison - parse inner
                -- only and let ParseAndExpression/ParseOrExpression handle the logical operator.
                local startsWithLogicalOp = remainingAfterParen:match("^%s*and%s") or remainingAfterParen:match("^%s*or%s")

                -- Check if remaining content starts with a comparison operator (and not a logical op)
                -- If so, this is a comparison expression like "(expr) >= 2" and should be parsed as a comparison
                local foundOp, opPosInRemaining = nil, nil
                if not startsWithLogicalOp then
                    foundOp, opPosInRemaining = FindTopLevelComparison(remainingAfterParen)
                end
                if foundOp then
                    -- CRITICAL: Check if there's a logical operator at depth 0 after the comparison
                    -- Comparison operators bind tighter than logical operators
                    -- If found, we should only parse the comparison part, not the logical operator part
                    -- Find logical operator directly in remainingAfterParen after the comparison operator
                    -- Search in the text after the comparison operator
                    local textAfterComparisonOp = remainingAfterParen:sub(opPosInRemaining + #foundOp + 1)
                    local logicalOpPosInAfterText, logicalOp = FindTopLevelLogicalOperator(textAfterComparisonOp)

                    local advanceToPos
                    local result

                    if logicalOpPosInAfterText and logicalOpPosInAfterText > 0 then
                        -- Logical operator found at depth 0 after comparison - truncate to preserve precedence
                        -- Comparison operators bind tighter than logical operators, so:
                        -- "expr1 <= expr2 and expr3" should parse as "(expr1 <= expr2) and expr3"
                        -- NOT as "expr1 <= (expr2 and expr3)"

                        -- Calculate absolute position in remainingAfterParen:
                        -- textAfterComparisonOp starts at position (opPosInRemaining + #foundOp + 1) in remainingAfterParen
                        -- logicalOpPosInAfterText is 1-based position within textAfterComparisonOp (where whitespace before operator is)
                        -- Absolute position = start of textAfterComparisonOp + logicalOpPosInAfterText - 1
                        local textAfterComparisonOpStart = opPosInRemaining + #foundOp + 1
                        local logicalOpAbsolutePosInRemaining = textAfterComparisonOpStart + logicalOpPosInAfterText - 1

                        -- Extract RHS: text after comparison operator, up to (but not including) the logical operator
                        local rhsTextRaw = remainingAfterParen:sub(textAfterComparisonOpStart, logicalOpAbsolutePosInRemaining - 1)
                        local rhsText = rhsTextRaw:match("^%s*(.-)%s*$")

                        -- Safety check: RHS should not contain logical operators
                        if rhsText and self:HasLogicalOperators(rhsText) then
                            -- Find where logical operator starts in RHS and truncate
                            local logicalOpPosInRHS, _ = FindTopLevelLogicalOperator(rhsText)
                            if logicalOpPosInRHS and logicalOpPosInRHS > 0 then
                                rhsText = rhsText:sub(1, logicalOpPosInRHS - 1):match("^%s*(.-)%s*$")
                                self:Warn("ParsePrimaryExpression: RHS contained logical operator, truncated to: '%s' (first 100 chars)",
                                    rhsText:sub(1, 100) .. (rhsText:len() > 100 and "..." or ""))
                            end
                        end

                        -- Position should advance to where logical operator starts in the original expression
                        -- remainingAfterParen has leading whitespace stripped, so we need to account for that
                        -- logicalOpAbsolutePosInRemaining is position within remainingAfterParen (after whitespace stripped)
                        -- Absolute position = self.pos + leadingWhitespaceLen + logicalOpAbsolutePosInRemaining - 1
                        advanceToPos = self.pos + leadingWhitespaceLen + logicalOpAbsolutePosInRemaining - 1

                        -- Build comparison expression: parse innerExpr first, then build comparison
                        -- This avoids issues with unmatched parentheses when innerExpr has logical operators
                        local savedExpr = self.expr
                        local savedPos = self.pos
                        local savedLen = self.len

                        -- Parse innerExpr (may be compound)
                        local innerNode
                        if self:HasLogicalOperators(innerExpr) then
                            innerNode = self:ParseOrExpression(innerExpr)
                        else
                            innerNode = self:ParseValue(innerExpr)
                        end

                        -- Restore position tracking
                        self.expr = savedExpr
                        self.pos = savedPos
                        self.len = savedLen

                        if not innerNode then
                            self:Warn("ParsePrimaryExpression: Failed to parse innerExpr for comparison: '%s' (first 100 chars)",
                                innerExpr:sub(1, 100) .. (innerExpr:len() > 100 and "..." or ""))
                            -- Fall through to parse inner expression only
                        else
                            -- Parse RHS of comparison (already extracted above)
                            if not rhsText or rhsText == "" then
                                self:Warn("ParsePrimaryExpression: Empty RHS for comparison")
                                -- Fall through to parse inner expression only
                            else
                                local rhsNode = self:ParseValue(rhsText)

                                if not rhsNode then
                                    self:Warn("ParsePrimaryExpression: Failed to parse RHS for comparison: '%s' (first 100 chars)",
                                        rhsText:sub(1, 100) .. (rhsText:len() > 100 and "..." or ""))
                                    -- Fall through to parse inner expression only
                                else
                                    -- Create comparison node
                                    local protoOp = ASTValue.SymbolToComparisonOp(foundOp)
                                    if protoOp then
                                        result = ASTValue.CreateCmp(protoOp, innerNode, rhsNode)
                                    else
                                        self:Error("ParsePrimaryExpression: Failed to convert operator '%s' to proto format", foundOp)
                                    end
                                end
                            end
                        end

                    else
                        -- No logical operator - parse full comparison
                        advanceToPos = innerEnd + 1 + #remainingAfterParen

                        -- Build comparison expression: parse innerExpr first, then build comparison
                        local savedExpr = self.expr
                        local savedPos = self.pos
                        local savedLen = self.len

                        -- Parse innerExpr (may be compound)
                        local innerNode
                        if self:HasLogicalOperators(innerExpr) then
                            innerNode = self:ParseOrExpression(innerExpr)
                        else
                            innerNode = self:ParseValue(innerExpr)
                        end

                        -- Restore position tracking
                        self.expr = savedExpr
                        self.pos = savedPos
                        self.len = savedLen

                        if not innerNode then
                            self:Warn("ParsePrimaryExpression: Failed to parse innerExpr for comparison: '%s' (first 100 chars)",
                                innerExpr:sub(1, 100) .. (innerExpr:len() > 100 and "..." or ""))
                            -- Fall through to parse inner expression only
                        else
                            -- Extract RHS: text after comparison operator
                            local textAfterComparisonOpStart = opPosInRemaining + #foundOp + 1
                            local rhsText = remainingAfterParen:sub(textAfterComparisonOpStart):match("^%s*(.-)%s*$")

                            if not rhsText or rhsText == "" then
                                self:Warn("ParsePrimaryExpression: Empty RHS for comparison")
                                -- Fall through to parse inner expression only
                            else
                                local rhsNode = self:ParseValue(rhsText)

                                if not rhsNode then
                                    self:Warn("ParsePrimaryExpression: Failed to parse RHS for comparison: '%s' (first 100 chars)",
                                        rhsText:sub(1, 100) .. (rhsText:len() > 100 and "..." or ""))
                                    -- Fall through to parse inner expression only
                                else
                                    -- Create comparison node
                                    local protoOp = ASTValue.SymbolToComparisonOp(foundOp)
                                    if protoOp then
                                        result = ASTValue.CreateCmp(protoOp, innerNode, rhsNode)
                                    else
                                        self:Error("ParsePrimaryExpression: Failed to convert operator '%s' to proto format", foundOp)
                                    end
                                end
                            end
                        end
                    end

                    if result then
                        -- Advance position to end of comparison (or to logical operator if one was found)
                        self.pos = advanceToPos
                        return result
                    else
                        self:Warn("ParsePrimaryExpression: Failed to parse comparison, falling back to inner expression only")
                        -- Fall through to parse inner expression only
                    end
                end

                -- Inline IIFE: (function() ... end)() — parse as one token and consume trailing "()"
                -- so we do not leave "()" in the stream and break following primaries.
                local iifeSuffix = rawRemainingText:match("^%s*%(%s*%)")
                if innerExpr:match("^function%s*%(") and iifeSuffix then
                    local fullIIFE = "(" .. innerExpr .. ")" .. iifeSuffix
                    local savedExpr = self.expr
                    local savedPos = self.pos
                    local savedLen = self.len
                    local result = self:ParseValue(fullIIFE)
                    self.expr = savedExpr
                    self.pos = savedPos + #iifeSuffix
                    self.len = savedLen
                    if result then
                        return result
                    end
                end

                -- Not a comparison operator, or comparison parsing failed - parse inner but preserve position for caller
                -- Save current position and expression before any recursive call (ParseOrExpression overwrites them)
                local savedExpr = self.expr
                local savedPos = self.pos
                local savedLen = self.len

                local result
                if self:HasLogicalOperators(innerExpr) then
                    result = self:ParseOrExpression(innerExpr)
                else
                    result = self:ParseValue(innerExpr)
                end

                -- Always restore after inner parse. ParseOrExpression leaves self.expr/pos/len at inner state;
                -- restoring in one place here avoids position mismatch regardless of which branch ran.
                self.expr = savedExpr
                self.pos = savedPos
                self.len = savedLen

                -- Note: originalText removed - use ASTSchemaEmitter.EmitValueNode(node) for text synthesis
                return result
                else
                    -- No content remaining - check if inner expression contains logical operators
                    -- Position is already past the closing paren (from parseParens).
                    -- Save here; this branch does not share locals with the "content after" branch.
                    local savedExpr = self.expr
                    local savedPos = self.pos
                    local savedLen = self.len
                    local result
                    if self:HasLogicalOperators(innerExpr) then
                        -- ParseOrExpression overwrites self.expr/pos/len; restore after.
                        result = self:ParseOrExpression(innerExpr)
                        self.expr = savedExpr
                        self.pos = savedPos
                        self.len = savedLen
                    else
                        result = self:ParseValue(innerExpr)
                    end
                    -- Note: originalText removed - use ASTSchemaEmitter.EmitValueNode(node) for text synthesis
                    return result
                end
        else
            self:Warn("ParsePrimaryExpression: Failed to parse parentheses")
        end
    end

    -- Handle negation (both "not " and "not(...)" patterns)
    local notStartPos = self.pos
    if self:consumeWord("not") then
        -- Found "not" - parse the operand
        local notOriginalText = nil

        -- Check if next is parentheses: "not(...)"
        if self:peek() == "(" then
            local parenText, innerStart, innerEnd = self:parseParens()
            if parenText then
                local innerExpr = self.expr:sub(innerStart, innerEnd)
                notOriginalText = self.expr:sub(notStartPos, self.pos - 1)

                -- If inner contains logical operators (e.g. "(A) and (B)"), parse as condition.
                -- ParseValue does not handle and/or and would fall back to string constant.
                local innerValue
                if self:HasLogicalOperators(innerExpr) then
                    local savedExpr, savedPos, savedLen = self.expr, self.pos, self.len
                    innerValue = self:ParseOrExpression(innerExpr)
                    self.expr, self.pos, self.len = savedExpr, savedPos, savedLen
                else
                    innerValue = self:ParseValue(innerExpr)
                end

                if not innerValue then
                    self:Error("ParsePrimaryExpression: Failed to parse inner expression for NOT")
                    return nil
                end

                local notNode = ASTValue.CreateNot(innerValue)
                if not notNode then
                    self:Error("ParsePrimaryExpression: Failed to create NOT node")
                    return nil
                end

                -- Note: originalText removed - use ASTSchemaEmitter.EmitValueNode(node) for text synthesis

                return notNode
            end
        else
            -- "not " followed by expression (no parentheses)
            -- Extract remaining text and parse it
            local remainingText = self.expr:sub(self.pos)
            notOriginalText = self.expr:sub(notStartPos)

            -- Save outer position state; ParseOrExpression overwrites self.expr/pos/len.
            local savedExpr, savedPos, savedLen = self.expr, self.pos, self.len

            -- If remaining contains logical operators, parse as condition.
            -- ParseValue does not handle and/or and would fall back to string constant.
            local innerValue
            if self:HasLogicalOperators(remainingText) then
                innerValue = self:ParseOrExpression(remainingText)
            else
                innerValue = self:ParseValue(remainingText)
            end

            -- Restore outer state so position and len are valid for the caller.
            self.expr, self.pos, self.len = savedExpr, savedPos, savedLen

            if not innerValue then
                self:Error("ParsePrimaryExpression: Failed to parse inner expression for NOT")
                return nil
            end

            local notNode = ASTValue.CreateNot(innerValue)
            if not notNode then
                self:Error("ParsePrimaryExpression: Failed to create NOT node")
                return nil
            end

            -- Note: originalText removed - use ASTSchemaEmitter.EmitValueNode(node) for text synthesis

            -- Update position to end of consumed primary (we consumed "not " .. remainingText)
            self.pos = savedLen + 1

            return notNode
        end
    end

    -- Delegate to existing ParseSingleCondition for comparisons and function calls
    -- When called from ParseAndExpression (condStr is nil), we need to be careful:
    -- We should only parse up to the next logical operator to avoid infinite recursion
    -- Extract remaining text from current position, but stop at logical operator boundaries
    local remainingText = self.expr:sub(self.pos)
    if remainingText and remainingText ~= "" then
        -- If we're in the middle of parsing a logical expression (condStr is nil),
        -- check if remaining text has logical operators. If so, we need to find where
        -- the current primary expression ends (before the first logical operator).
        local primaryText = remainingText
        local logicalOpStartPos = nil  -- Position where logical operator starts (relative to remainingText)
        if not condStr and self:HasLogicalOperators(remainingText) then
            -- Find the end of the primary expression (before first logical operator at depth 0)
            local endPos = #remainingText + 1
            local depth = 0
            local inString = false
            local stringQuote = nil

            for i = 1, #remainingText do
                local ch = remainingText:sub(i, i)
                if not inString then
                    if ch == '"' or ch == "'" then
                        inString = true
                        stringQuote = ch
                    elseif ch == "(" then
                        depth = depth + 1
                    elseif ch == ")" then
                        depth = depth - 1
                    elseif depth == 0 then
                        -- Check for logical operators at depth 0
                        -- IMPORTANT: Don't stop at comparison operators (==, <, >, etc.) - they're part of the primary expression
                        -- Only stop at logical operators (and, or) which separate primary expressions
                        local ahead = remainingText:sub(i)
                        if ahead:match("^%s*or%s+") or ahead:match("^%s*and%s+") then
                            -- Found logical operator - this is where primary expression ends
                            endPos = i
                            logicalOpStartPos = i  -- Save where the logical operator starts
                            break
                        end
                        -- Note: Comparison operators (==, <, >, <=, >=, !=) are part of the primary expression
                        -- and should NOT cause extraction to stop - they will be handled by ParseSingleCondition
                    end
                else
                    if ch == stringQuote then
                        inString = false
                        stringQuote = nil
                    elseif ch == "\\" then
                        i = i + 1  -- Skip escape sequence
                    end
                end
            end

            primaryText = remainingText:sub(1, endPos - 1):match("^%s*(.-)%s*$")
        end

        if primaryText and primaryText ~= "" then
            -- primaryText may be a compound expression (e.g. "((A or B)" or "A > B and C") when we
            -- truncated at the first depth-0 logical op. ParseSingleCondition must never receive
            -- text with logical operators at depth 0; route compound text to ParseOrExpression.
            local result
            if self:HasLogicalOperators(primaryText) then
                result = self:ParseOrExpression(primaryText)
            else
                result = self:ParseSingleCondition(primaryText)
            end
            if result then
                -- Update position: advance past the parsed text
                if not condStr then
                    -- We're in position-based mode, advance self.pos
                    if logicalOpStartPos then
                        -- CRITICAL: Advance to where the logical operator starts, not just past the trimmed primaryText
                        -- This ensures ParseOrExpression/ParseAndExpression can find the operator
                        self.pos = self.pos + logicalOpStartPos - 1
                    else
                        -- No logical operator found, advance past the parsed text
                        local parsedLength = #primaryText
                        -- Find where this text ends in the original expression (accounting for leading whitespace)
                        local textStart = remainingText:find(primaryText:match("^%s*(.*)"), 1, true)
                        if textStart then
                            self.pos = self.pos + textStart + parsedLength - 1
                        else
                            -- Fallback: advance by parsed length
                            self.pos = self.pos + parsedLength
                        end
                    end
                else
                    -- We consumed everything
                    self.pos = self.len + 1
                end
                return result
            else
                self:Warn("ParsePrimaryExpression: Parse returned nil for: '%s'",
                    primaryText:sub(1, 100) .. (primaryText:len() > 100 and "..." or ""))
            end
        else
        end
    end

    return nil
end

--- Helper: Split string on operator respecting parentheses
--- Returns array of parts split by the operator when outside parentheses
--- NOTE: This is still used for rotation line splitting (ParseRotationString).
--- Logical expression parsing (ParseOrExpression, ParseAndExpression) now uses position-based parsing.
--- @param str string The string to split
--- @param operator string The operator to split on ("and" or "or")
--- @return table Array of string parts
function NAGStringParser:SplitOnOperator(str, operator)
    if self.debug then self:Debug("SplitOnOperator: ENTRY str='%s' (length=%d), operator='%s'", str:sub(1, 100) .. (str:len() > 100 and "..." or ""), #str, operator) end
    local parts = {}
    local current = ""
    local parenDepth = 0
    local braceDepth = 0  -- Track curly braces for tables
    local i = 1
    local opLen = #operator
    local inString = false
    local stringQuote = nil
    local foundComment = false  -- Track if we found a comment and stopped early

    while i <= #str do
        local char = str:sub(i, i)

        -- Track string literals to avoid matching operators inside strings
        if not inString then
            -- Check for comment marker (--) - stop processing at comments
            if str:sub(i, i+1) == "--" then
                -- Found comment - add current accumulated string as final part and stop
                local trimmed = current:match("^%s*(.-)%s*$")
                if trimmed and trimmed ~= "" then
                    if self.debug then self:Debug("SplitOnOperator: Found comment at position %d, adding final part: '%s'", i, trimmed:sub(1, 60) .. (trimmed:len() > 60 and "..." or "")) end
                    table.insert(parts, trimmed)
                end
                foundComment = true
                break  -- Stop processing - everything after -- is comment
            elseif char == '"' or char == "'" then
                inString = true
                stringQuote = char
                current = current .. char
                i = i + 1
            -- Track parenthesis and brace depth
            elseif char == "(" then
                parenDepth = parenDepth + 1
                current = current .. char
                i = i + 1
            elseif char == ")" then
                parenDepth = parenDepth - 1
                current = current .. char
                i = i + 1
            elseif char == "{" then
                braceDepth = braceDepth + 1
                current = current .. char
                i = i + 1
            elseif char == "}" then
                braceDepth = braceDepth - 1
                current = current .. char
                i = i + 1
            elseif parenDepth == 0 and braceDepth == 0 then
                -- Check if we're at the operator (with surrounding whitespace)
                -- Match pattern: word boundary or start + optional whitespace + operator + required whitespace
                -- This prevents matching "or" inside words like "color" or "font_color"
                local ahead = str:sub(i)

                -- For "or", we need to ensure it's not part of a word
                -- Check if character before "or" is a word character (letter, digit, underscore)
                local charBefore = i > 1 and str:sub(i - 1, i - 1) or ""
                local isWordChar = charBefore:match("[%w_]")

                -- Match pattern: optional whitespace + operator + required whitespace
                -- But only if "or" is not part of a word
                local matchPattern = "^(%s*)" .. operator .. "(%s+)"
                local wsBeforeMatch, wsAfter = ahead:match(matchPattern)

                -- Check what's ahead

                if wsBeforeMatch and not isWordChar then
                    -- Found operator at depth 0 (no nested parens or braces, and not part of a word)
                    if self.debug then self:Debug("SplitOnOperator: Found operator '%s' at position %d, parenDepth=%d, braceDepth=%d, wsBefore='%s', wsAfter='%s', charBefore='%s'",
                        operator, i, parenDepth, braceDepth, wsBeforeMatch or "", wsAfter or "", charBefore) end

                    -- Add current accumulated string as a part (strip trailing whitespace)
                    local trimmed = current:match("^%s*(.-)%s*$")
                    if trimmed and trimmed ~= "" then
                        if self.debug then self:Debug("SplitOnOperator: Adding part [%d]: '%s'", #parts + 1, trimmed:sub(1, 60) .. (trimmed:len() > 60 and "..." or "")) end
                        table.insert(parts, trimmed)
                    end
                    current = ""

                    -- Skip past operator and whitespace
                    -- Calculate skip length: whitespace before + operator length + whitespace after
                    local skipLen = #wsBeforeMatch + opLen + (wsAfter and #wsAfter or 0)
                    i = i + skipLen
                else
                    current = current .. char
                    i = i + 1
                end
            else
                -- Inside parentheses, just accumulate
                current = current .. char
                i = i + 1
            end
        else
            -- Inside string literal - add character and check for closing quote
            current = current .. char
            if char == "\\" then
                -- Escape character - skip next character too
                i = i + 1
                if i <= #str then
                    current = current .. str:sub(i, i)
                end
            elseif char == stringQuote then
                inString = false
                stringQuote = nil
            end
            i = i + 1
        end
    end

    -- Add final part (only if we didn't break on a comment - comment already handled above)
    if not foundComment then
        local trimmed = current:match("^%s*(.-)%s*$")
        if trimmed and trimmed ~= "" then
            if self.debug then self:Debug("SplitOnOperator: Adding final part [%d]: '%s'", #parts + 1, trimmed:sub(1, 60) .. (trimmed:len() > 60 and "..." or "")) end
            table.insert(parts, trimmed)
        end
    end

    -- If no splits occurred, return original string as single element (but strip comment first if found)
    if #parts == 0 then
        if foundComment then
            -- Comment found but no parts extracted - return stripped string
            local stripped = str:sub(1, str:find("--") and (str:find("--") - 1) or #str):match("^%s*(.-)%s*$")
            if stripped and stripped ~= "" then
                parts = {stripped}
            else
                parts = {str}  -- Fallback to original if stripping results in empty
            end
        else
            parts = {str}
        end
    end

    local result = parts
    if self.debug then self:Debug("SplitOnOperator: EXIT - split into %d parts (operator='%s')", #result, operator) end
    for idx, part in ipairs(result) do
        if self.debug then self:Debug("SplitOnOperator: Part [%d]: '%s'", idx, part:sub(1, 60) .. (part:len() > 60 and "..." or "")) end
    end
    if #result == 1 then
    end
    return result
end

--- Parses a single condition (no logical operators)
--- @param conditionText string The condition text
--- @return table The parsed condition node

function NAGStringParser:ParseSingleCondition(conditionText)
    -- 1. Strip outer whitespace
    conditionText = conditionText:match("^%s*(.-)%s*$")

    -- 2. Strip outer parentheses recursively - comparison operators need to be at depth 0 to be found
    local stripped = self:StripOuterParentheses(conditionText, false)
    if stripped then
        if self.debug then self:Debug("ParseSingleCondition: Stripped outer parentheses, recursing: '%s' -> '%s'",
            conditionText:sub(1, 60) .. (#conditionText > 60 and "..." or ""),
            stripped:sub(1, 60) .. (#stripped > 60 and "..." or "")) end
        return self:ParseSingleCondition(stripped)
    end

    -- CRITICAL: Check for logical operators at depth 0 BEFORE parsing
    -- ParseSingleCondition should NEVER receive text with logical operators at depth 0
    -- If it does, the caller should have truncated or handled them at a higher level
    local hasLogicalOps = self:HasLogicalOperators(conditionText)
    if hasLogicalOps then
        self:Warn("ParseSingleCondition: CRITICAL - Received text with logical operators at depth 0: '%s' (first 100 chars). " ..
            "This indicates a precedence violation - caller should handle logical operators before calling ParseSingleCondition. " ..
            "Will attempt to parse but this may result in incorrect precedence.",
            conditionText:sub(1, 100) .. (conditionText:len() > 100 and "..." or ""))
    end

    -- 3. Look for top-level comparison operators (ignore operators inside parentheses or strings)
    local foundOp, opPos = FindTopLevelComparison(conditionText)

    if self.debug then self:Debug("ParseSingleCondition: After stripping, looking for comparison operators in: '%s' (first 100 chars)",
        conditionText:sub(1, 100) .. (conditionText:len() > 100 and "..." or "")) end
    if self.debug then self:Debug("ParseSingleCondition: FindTopLevelComparison result: foundOp=%s, opPos=%s",
        foundOp or "nil", opPos or "nil") end

    if foundOp then
        if self.debug then self:Debug("ParseSingleCondition: Found comparison operator '%s' at position %d", foundOp, opPos) end
        -- Comparison condition
        local lhs = conditionText:sub(1, opPos - 1):match("^%s*(.-)%s*$")
        local rhs = conditionText:sub(opPos + #foundOp):match("^%s*(.-)%s*$")

        if not lhs or not rhs then
            self:Error("ParseSingleCondition: Failed to extract lhs/rhs from comparison (op='%s', pos=%d)", foundOp, opPos)
            return nil
        end

        -- CRITICAL: Check if RHS contains logical operators at depth 0
        -- If it does, this is a precedence violation - comparisons bind tighter than logical operators
        -- Example: "expr1 <= expr2 and expr3" should parse as "(expr1 <= expr2) and expr3"
        -- NOT as "expr1 <= (expr2 and expr3)"
        -- The caller should have truncated the RHS before calling ParseSingleCondition
        local rhsHasLogicalOps = self:HasLogicalOperators(rhs)
        if rhsHasLogicalOps then
            local logicalOpPos, logicalOp = FindTopLevelLogicalOperator(rhs)
            -- Truncate RHS at the logical operator to preserve precedence
            -- This is a safety net - the caller should have done this already
            if logicalOpPos and logicalOpPos > 0 then
                local originalRhs = rhs
                rhs = rhs:sub(1, logicalOpPos - 1):match("^%s*(.-)%s*$")
                -- Only log as warning once per unique case to reduce noise
                local truncatedKey = conditionText:sub(1, 200) -- Use first 200 chars as key
                if not self._truncationWarnings then
                    self._truncationWarnings = {}
                end
                if not self._truncationWarnings[truncatedKey] then
                    self._truncationWarnings[truncatedKey] = true
                    self:Warn("ParseSingleCondition: PRECEDENCE VIOLATION - RHS contained logical operator '%s' at depth 0. " ..
                        "Truncated RHS from '%s' to '%s' to preserve precedence. " ..
                        "The caller should have truncated before calling ParseSingleCondition. " ..
                        "Full conditionText: '%s' (first 150 chars).",
                        logicalOp or "unknown",
                        originalRhs:sub(1, 80) .. (originalRhs:len() > 80 and "..." or ""),
                        rhs:sub(1, 80) .. (rhs:len() > 80 and "..." or ""),
                        conditionText:sub(1, 150) .. (conditionText:len() > 150 and "..." or ""))
                end
            end
        end

        -- Parse LHS: if it contains logical operators (e.g. "(A and (B < C))"), parse as condition.
        -- ParseValue delegates to ParseOrExpression when it sees logical ops, but calling
        -- ParseOrExpression here avoids the "LHS contains logical operators" warning and handles
        -- comparison-within-and/or consistently.
        local lhsHasLogicalOps = self:HasLogicalOperators(lhs)
        local lhsNode
        if lhsHasLogicalOps then
            lhsNode = self:ParseOrExpression(lhs)
        else
            lhsNode = self:ParseValue(lhs)
        end
        if not lhsNode and lhsHasLogicalOps then
            self:Warn("ParseSingleCondition: ParseOrExpression failed for lhs with logical operators: '%s' (first 100 chars). " ..
                "This may indicate invalid expression structure. Returning nil to avoid recursion.",
                lhs:sub(1, 100) .. (lhs:len() > 100 and "..." or ""))
        end

        local rhsNode = self:ParseValue(rhs)
        if not rhsNode then
            -- ParseValue failed - this shouldn't happen with valid input after truncation
            self:Warn("ParseSingleCondition: ParseValue failed for rhs: '%s' (first 100 chars). " ..
                "This may indicate invalid expression structure. Returning nil to avoid recursion.",
                rhs:sub(1, 100) .. (rhs:len() > 100 and "..." or ""))
        end

        if not lhsNode or not rhsNode then
            self:Error("ParseSingleCondition: Failed to parse comparison operands (lhs=%s, rhs=%s)",
                lhsNode and "ok" or "nil", rhsNode and "ok" or "nil")
            return nil
        end

        -- Convert operator symbol to proto format
        local protoOp = ASTValue.SymbolToComparisonOp(foundOp)
        if not protoOp then
            self:Error("ParseSingleCondition: Failed to convert operator '%s' to proto format", foundOp)
            return nil
        end

        -- PRECEDENCE FIX: When LHS is "not <expr>", rotation semantics expect "not (expr > rhs)", not "(not expr) > rhs".
        -- So if LHS parsed as a NOT node, build NOT(CMP(op, notOperand, rhs)) so round-trip emits "not (A > c)".
        local lhsValueType = ASTValue.GetValueType(lhsNode)
        if lhsValueType == ASTValue.ValueType.NOT then
            local notData = ASTValue.GetValueData(lhsNode)
            local innerOperand = notData and notData.val
            if innerOperand then
                local innerCmp = ASTValue.CreateCmp(protoOp, innerOperand, rhsNode)
                if innerCmp then
                    local notNode = ASTValue.CreateNot(innerCmp)
                    if notNode then
                        self:Error("ParseSingleCondition: Failed to create NOT node for comparison LHS fix")
                        return nil
                    end
                    return notNode
                end
            end
        end

        -- Create comparison node
        local cmpNode = ASTValue.CreateCmp(protoOp, lhsNode, rhsNode)
        if not cmpNode then
            self:Error("ParseSingleCondition: Failed to create comparison node")
            return nil
        end
        -- Note: originalText removed - use ASTSchemaEmitter.EmitValueNode(node) for text synthesis
        return cmpNode
    else
        -- No comparison operator found
        -- Check if it contains logical operators - if so, parse as condition to avoid infinite recursion
        -- (ParseValue would call ParseOrExpression, which would call ParsePrimaryExpression -> ParseSingleCondition -> ParseValue again)
        -- NOTE: This is a fallback case - ideally, ParseSingleCondition should never receive text with logical operators
        -- at depth 0 when there's no comparison operator. This delegation is for edge cases.
        if self:HasLogicalOperators(conditionText) then
            if self.debug then self:Debug("ParseSingleCondition: No comparison operator but logical operators found at depth 0. " ..
                "Delegating to ParseOrExpression. Text: '%s' (first 100 chars). " ..
                "This delegation is expected when called from ParseValue for expressions like 'expr1 and expr2'.",
                conditionText:sub(1, 100) .. (conditionText:len() > 100 and "..." or "")) end
            return self:ParseOrExpression(conditionText)
        end

        -- Function call or simple value - use ParseValue which properly handles function parsing
        return self:ParseValue(conditionText)
    end
end

--- Helper: Check if text contains logical operators (or, and) at top level
--- Respects parentheses nesting and string literals
--- @param text string The text to check
--- @return boolean True if logical operators found at depth 0
function NAGStringParser:HasLogicalOperators(text)
    if not text or text == "" then
        return false
    end

    local depth = 0
    local i = 1
    local inString = false
    local stringQuote = nil

    while i <= #text do
        local char = text:sub(i, i)

        -- Track string literals to avoid matching operators inside strings
        if not inString then
            if char == '"' or char == "'" then
                inString = true
                stringQuote = char
                i = i + 1
            -- Track parenthesis depth
            elseif char == "(" then
                depth = depth + 1
                i = i + 1
            elseif char == ")" then
                depth = depth - 1
                i = i + 1
            elseif depth == 0 then
                -- Check if we're at an operator (with surrounding whitespace)
                -- Match pattern: optional whitespace + operator + required whitespace
                -- This matches the pattern used in SplitOnOperator
                local ahead = text:sub(i)
                local orPattern = "^(%s*)or(%s+)"
                local andPattern = "^(%s*)and(%s+)"
                local wsBeforeOr, wsAfterOr = ahead:match(orPattern)
                local wsBeforeAnd, wsAfterAnd = ahead:match(andPattern)

                if wsBeforeOr or wsBeforeAnd then
                    -- Found logical operator at depth 0
                    local operator = wsBeforeOr and "or" or "and"
                    if self.debug then self:Debug("HasLogicalOperators: Found logical operator '%s' at position %d", operator, i) end
                    return true
                end

                -- Not an operator, continue scanning
                i = i + 1
            else
                -- Inside parentheses, just continue
                i = i + 1
            end
        else
            -- Inside string literal - check for closing quote
            if char == "\\" then
                -- Escape character - skip next character too
                i = i + 1
                if i <= #text then
                    i = i + 1
                end
            elseif char == stringQuote then
                inString = false
                stringQuote = nil
                i = i + 1
            else
                i = i + 1
            end
        end
    end

    return false
end

--- INTERNAL: Parses a value (function call, constant, math expression, etc.)
--- This is an internal function used by ParseClause. External callers should use ParseClause instead.
--- @internal
--- @param valueText string The value text
--- @return table The parsed value node
function NAGStringParser:ParseValue(valueText)

    if not valueText or valueText == "" then
        self:Warn("ParseValue: Empty value text provided, returning empty type node")
        return { type = "empty" }
    end

    -- Strip outer whitespace
    valueText = valueText:match("^%s*(.-)%s*$")
    if self.debug then self:Debug("ParseValue: After whitespace strip: valueText='%s'", valueText) end

    -- Check for nil literal (case-insensitive)
    if valueText:lower() == "nil" then
        if self.debug then self:Debug("ParseValue: Matched as nil literal") end
        -- Return a special nil constant node that ExtractProtoValue can recognize
        -- Create const node with nil value - we'll mark it specially so ExtractProtoValue returns actual nil
        local nilNode = ASTValue.Create(ASTValue.ValueType.CONST, { val = nil })
        if nilNode then
            nilNode.isNil = true  -- Mark as nil so ExtractProtoValue knows to return actual nil
            return nilNode
        end
    end

    -- Check if it's a quoted string (strip quotes)
    local unquoted = valueText:match('^"(.*)"$') or valueText:match("^'(.*)'$")
    if unquoted then
        if self.debug then self:Debug("ParseValue: Matched as quoted string: '%s' -> '%s'", valueText, unquoted) end
        local constNode = ASTValue.CreateConst(unquoted)
        if not constNode then
            self:Error("ParseValue: Failed to create const node for quoted string: '%s'", unquoted)
            return nil
        end
        return constNode
    end

    -- Inline IIFE: (function() ... end)() or (function(...) ... end)()
    -- Pass through untouched so runtime can execute the Lua. Must run before strip and before
    -- logical-operator delegation, since the body may contain "and"/"or".
    if valueText:match("^%(%s*function%s*%(") then
        local depth = 0
        local inString = false
        local stringQuote = nil
        local i = 1
        while i <= #valueText do
            local ch = valueText:sub(i, i)
            if not inString then
                if ch == '"' or ch == "'" then
                    inString = true
                    stringQuote = ch
                elseif ch == "(" then
                    depth = depth + 1
                elseif ch == ")" then
                    depth = depth - 1
                    if depth == 0 then
                        local rest = valueText:sub(i + 1)
                        local callMatch = rest:match("^%s*%(%s*%)")
                        if callMatch then
                            local fullIIFE = valueText:sub(1, i + #callMatch)
                            local constNode = ASTValue.CreateConst(fullIIFE)
                            if constNode then
                                constNode.isFunctionExpression = true
                                if self.debug then self:Debug("ParseValue: Inline IIFE passed through untouched: %d chars", #fullIIFE) end
                                return constNode
                            end
                        end
                        break
                    end
                end
            else
                if ch == stringQuote then
                    inString = false
                    stringQuote = nil
                elseif ch == "\\" then
                    i = i + 1
                end
            end
            i = i + 1
        end
    end

    -- Strip outer parentheses only when they wrap the entire expression
    -- Use returnUnchanged=false so it returns nil when no stripping occurs
    local unwrapped = self:StripOuterParentheses(valueText, false)
    if unwrapped then
        if self.debug then self:Debug("ParseValue: Outer parentheses stripped: '%s' -> '%s'",
            valueText:sub(1, 60) .. (valueText:len() > 60 and "..." or ""),
            unwrapped:sub(1, 60) .. (unwrapped:len() > 60 and "..." or "")) end
        return self:ParseValue(unwrapped)
    end

    -- Check if it's a number
    local num = tonumber(valueText)
    if num then
        if self.debug then self:Debug("ParseValue: Matched as number: %s", num) end
        local constNode = ASTValue.CreateConst(num)
        if not constNode then
            self:Error("ParseValue: Failed to create const node for number: %s", num)
            return nil
        end
        return constNode
    end

    -- Check for comparison operators (==, <, >, <=, >=, !=, ~=) BEFORE math operators
    -- Comparison operators have lower precedence than math, but we need to detect them
    -- to avoid parsing comparison expressions as math expressions
    local foundOp, opPos = FindTopLevelComparison(valueText)
    if foundOp then
        -- CRITICAL: Check if there are logical operators at depth 0 BEFORE or AFTER the comparison
        -- If ParseValue is called on something like "expr1 and expr2 <= expr3" or "expr1 <= expr2 and expr3",
        -- we should NOT parse it here - it should be handled by ParseCondition at a higher level.
        -- But if we're parsing a nested comparison, we need to truncate before delegating.

        -- Check for logical operators BEFORE the comparison operator
        local textBeforeComparisonOp = valueText:sub(1, opPos - 1)
        local logicalOpPosBefore, logicalOpBefore = FindTopLevelLogicalOperator(textBeforeComparisonOp)

        -- Check for logical operators AFTER the comparison operator
        local textAfterComparisonOp = valueText:sub(opPos + #foundOp + 1)
        local logicalOpPosInAfterText, logicalOpAfter = FindTopLevelLogicalOperator(textAfterComparisonOp)

        if logicalOpPosBefore and logicalOpPosBefore > 0 then
            -- Logical operator found before comparison - this is a compound expression
            -- Delegate to ParseOrExpression to handle the full compound expression
            if self.debug then self:Debug("ParseValue: Found logical operator '%s' before comparison operator. " ..
                "Delegating to ParseOrExpression for compound expression: '%s' (first 100 chars)",
                logicalOpBefore or "unknown",
                valueText:sub(1, 100) .. (valueText:len() > 100 and "..." or "")) end
            return self:ParseOrExpression(valueText)
        elseif logicalOpPosInAfterText and logicalOpPosInAfterText > 0 then
            -- Logical operator found after comparison
            -- This could be:
            -- 1. A ternary pattern: "condition and value1 or value2" (e.g., "level < 60 and 0 or 200")
            -- 2. A precedence violation: "expr1 <= expr2 and expr3" (should be "(expr1 <= expr2) and expr3")
            --
            -- For case 1, we need to parse the full expression via ParseOrExpression
            -- For case 2, we should truncate to preserve precedence
            --
            -- Check if there's an "or" operator later in the expression - if so, it's likely a ternary pattern
            local textAfterLogicalOp = textAfterComparisonOp:sub(logicalOpPosInAfterText + #logicalOpAfter + 1)
            local orOpPos, _ = FindTopLevelLogicalOperator(textAfterLogicalOp)

            if orOpPos and orOpPos > 0 then
                -- Found "or" after "and" - this is likely a ternary pattern
                -- Delegate to ParseOrExpression to handle the full ternary expression
                if self.debug then self:Debug("ParseValue: Found ternary pattern (comparison and value or value). " ..
                    "Delegating to ParseOrExpression: '%s' (first 100 chars)",
                    valueText:sub(1, 100) .. (valueText:len() > 100 and "..." or "")) end
                return self:ParseOrExpression(valueText)
            else
                -- No "or" found - this is a precedence violation
                -- Truncate to preserve precedence: "expr1 <= expr2 and expr3" -> parse only "expr1 <= expr2"
                local logicalOpAbsolutePos = opPos + #foundOp + logicalOpPosInAfterText
                local truncatedValue = valueText:sub(1, logicalOpAbsolutePos - 1):match("^%s*(.-)%s*$")

                self:Warn("ParseValue: Found comparison operator followed by logical operator '%s'. " ..
                    "Truncating before delegating to ParseSingleCondition to preserve precedence. " ..
                    "Full valueText: '%s' (first 100 chars), " ..
                    "Truncated: '%s' (first 100 chars). " ..
                    "This indicates the caller should have handled logical operators before calling ParseValue.",
                    logicalOpAfter,
                    valueText:sub(1, 100) .. (valueText:len() > 100 and "..." or ""),
                    truncatedValue:sub(1, 100) .. (truncatedValue:len() > 100 and "..." or ""))

                return self:ParseSingleCondition(truncatedValue)
            end
        end

        if self.debug then self:Debug("ParseValue: Found comparison operator '%s' at position %d, delegating to ParseSingleCondition", foundOp, opPos) end
        -- Delegate to ParseSingleCondition which handles comparison operators correctly
        return self:ParseSingleCondition(valueText)
    end

    -- Check for math operators (*, /, +, -)
    -- Parse with precedence: * / before + -
    local mathExpr = self:ParseMathExpression(valueText)
    if mathExpr then
        -- Check if it's actually a math expression (has math operators)
        -- ParseMathExpression returns nil if no math operators found
        local isProtoAST = mathExpr.type == ASTCore.NodeType.VALUE
        local isClauseMath = mathExpr.type == "math"

        -- Only return if it's actually a math expression (not a constant fallback)
        if isProtoAST or isClauseMath then
            if self.debug then self:Debug("ParseValue: Matched as math expression") end
            return mathExpr
        end
        -- If ParseMathExpression returned a constant, it means no math operators were found
        -- Continue to next checks (function calls, etc.)
    else
    end

    -- Check for not(...) function-style syntax (e.g., not(NAG:AuraIsActive(77769)))
    -- This handles not() as a function call, not just "not " with space
    -- Use parentheses-aware extraction to handle nested parentheses
    if valueText:match("^not%(") then
        if self.debug then self:Debug("ParseValue: Matched as not(...) expression") end
        local depth = 0
        local startPos = 5  -- After "not("
        local endPos = nil

        for i = startPos, #valueText do
            local char = valueText:sub(i, i)
            if char == "(" then
                depth = depth + 1
            elseif char == ")" then
                if depth == 0 then
                    endPos = i - 1
                    break
                else
                    depth = depth - 1
                end
            end
        end

        if endPos and endPos >= startPos then
            local innerText = valueText:sub(startPos, endPos)
            if self.debug then self:Debug("ParseValue: Extracted inner text from not(...): '%s'", innerText:sub(1, 100) .. (innerText:len() > 100 and "..." or "")) end

            -- Check if inner text contains logical operators (or, and)
            -- If so, parse it as a logical condition using ParseOrExpression
            -- Otherwise, parse it as a value using ParseValue
            local innerValue
            if self:HasLogicalOperators(innerText) then
                if self.debug then self:Debug("ParseValue: Inner text contains logical operators, parsing as logical condition") end
                innerValue = self:ParseOrExpression(innerText)
                if not innerValue then
                    self:Warn("ParseValue: Failed to parse logical condition in not(...), falling back to ParseValue")
                    innerValue = self:ParseValue(innerText)
                end
            else
                if self.debug then self:Debug("ParseValue: Inner text has no logical operators, parsing as value") end
                innerValue = self:ParseValue(innerText)
            end

            -- innerValue is now proto AST, create NOT node
            if not innerValue then
                self:Error("ParseValue: Failed to parse inner value for not(...) expression")
                return nil
            end
            local notNode = ASTValue.CreateNot(innerValue)
            if not notNode then
                self:Error("ParseValue: Failed to create NOT node for not(...) expression")
                return nil
            end
            -- Note: originalText removed - use ASTSchemaEmitter.EmitValueNode(node) for text synthesis
            if self.debug then self:Debug("ParseValue: Successfully created NOT node for not(...) expression") end
            return notNode
        else
            self:Warn("ParseValue: Matched not(...) pattern but couldn't extract inner text")
        end
    end

    -- Check for "not " followed by expression (space-separated, not parentheses)
    -- This handles patterns like "not NAG:VariableRef(...)" or "not NAG:AuraIsActive(...)"
    if valueText:match("^not%s+") then
        if self.debug then self:Debug("ParseValue: Matched as 'not <expression>' pattern") end
        -- Extract everything after "not " (with space)
        local innerText = valueText:match("^not%s+(.+)$")
        if innerText and innerText ~= "" then
            if self.debug then self:Debug("ParseValue: Extracted inner text from 'not <expression>': '%s'",
                innerText:sub(1, 100) .. (innerText:len() > 100 and "..." or "")) end

            -- Parse the inner expression using ParseValue (handles all expression types)
            local innerValue = self:ParseValue(innerText)

            if not innerValue then
                self:Error("ParseValue: Failed to parse inner value for 'not <expression>'")
                return nil
            end

            local notNode = ASTValue.CreateNot(innerValue)
            if not notNode then
                self:Error("ParseValue: Failed to create NOT node for 'not <expression>'")
                return nil
            end

            if self.debug then self:Debug("ParseValue: Successfully created NOT node for 'not <expression>'") end
            return notNode
        else
            self:Warn("ParseValue: Matched 'not <expression>' pattern but couldn't extract inner text")
        end
    end

    -- CRITICAL: Check for function() ... end pattern BEFORE logical operators
    -- Function expressions like "function() return (NAG:GCDIsReady() and ...) end" contain
    -- logical operators in their body but should be treated as atomic constants, not parsed
    -- as logical expressions. If we check logical operators first, we'd try to parse the
    -- function body as a logical expression, causing infinite recursion.
    if valueText:match("^function%s*%(") then
        -- This is a function expression - store as string constant but mark it
        -- so emitter knows to emit it unquoted
        local constNode = ASTValue.CreateConst(valueText)
        if not constNode then
            self:Error("ParseValue: Failed to create const node for function expression")
            return nil
        end
        constNode.isFunctionExpression = true  -- Mark for emitter
        -- Note: originalText removed - use ASTSchemaEmitter.EmitValueNode(node) for text synthesis
        if self.debug then self:Debug("ParseValue: Detected function expression, marking for unquoted emission: '%s'", valueText) end
        return constNode
    end

    -- NOTE: ParseValue should NOT handle logical operators - that's ParseCondition's job
    -- Calling ParseOrExpression here creates infinite recursion:
    -- ParseValue → ParseOrExpression → ParseAndExpression → ParsePrimaryExpression → ParseSingleCondition → ParseValue (loop)
    -- Logical expressions should be parsed by ParseCondition/ParseLogicalCondition, not ParseValue

    -- Check for math.min and math.max BEFORE function pattern check
    -- These need special handling as APLValueMin/APLValueMax with vals arrays
    local matchesMathMin = valueText:match("^math%.min%s*%(")
    local matchesMathMax = valueText:match("^math%.max%s*%(")
    if matchesMathMin or matchesMathMax then
        local funcName = matchesMathMin and "min" or "max"
        if self.debug then self:Debug("ParseValue: Detected math.%s function call: '%s'", funcName, valueText:sub(1, 100)) end

        -- Find the matching closing paren for nested parentheses
        local startPos = valueText:find("%(")
        if not startPos then
            self:Warn("ParseValue: Pattern matched but couldn't find opening paren in '%s'", valueText:sub(1, 50))
            local constNode = ASTValue.CreateConst(valueText)
            return constNode
        end

        -- Find matching closing paren by tracking depth
        local parenLevel = 0
        local argsText = nil
        local inString = false
        local stringQuote = nil

        for i = startPos, #valueText do
            local ch = valueText:sub(i, i)

            if not inString then
                if ch == '"' or ch == "'" then
                    inString = true
                    stringQuote = ch
                elseif ch == "(" then
                    parenLevel = parenLevel + 1
                elseif ch == ")" then
                    parenLevel = parenLevel - 1
                    if parenLevel == 0 then
                        -- Found matching closing paren - extract args between opening and closing
                        argsText = valueText:sub(startPos + 1, i - 1)
                        break
                    end
                end
            else
                -- Inside string - ignore parens
                if ch == stringQuote then
                    inString = false
                    stringQuote = nil
                end
            end
        end

        if self.debug then self:Debug("ParseValue: math.%s function call detected - argsText='%s'", funcName, argsText or "nil") end
        local parsedArgs = argsText and self:ParseFunctionArgs(argsText) or {}

        if not parsedArgs or #parsedArgs == 0 then
            self:Warn("ParseValue: math.%s called with no arguments, treating as constant", funcName)
            local constNode = ASTValue.CreateConst(valueText)
            return constNode
        end

        -- Resolve metadata for min/max to get value type and schema
        local SchemaAccessor = NAG:GetModule("SchemaAccessor")
        if not SchemaAccessor then
            self:Warn("ParseValue: SchemaAccessor not available, treating math.%s as constant", funcName)
            local constNode = ASTValue.CreateConst(valueText)
            return constNode
        end

        -- Get metadata for min or max
        local snakeIdentifier = funcName == "min" and "min" or "max"
        local valueMetadata = SchemaAccessor:GetMetadataByIdentifier(snakeIdentifier, nil)  -- Use auto-detection

        if not valueMetadata or not valueMetadata.valueType then
            self:Warn("ParseValue: GetMetadataByIdentifier failed for math.%s (snakeIdentifier='%s') - treating as constant",
                funcName, snakeIdentifier)
            local constNode = ASTValue.CreateConst(valueText)
            return constNode
        end

        if self.debug then self:Debug("ParseValue: Successfully resolved metadata for math.%s -> valueType='%s'", funcName, valueMetadata.valueType) end

        -- Build value data from arguments using schema (will create vals array)
        local valueData = {}
        if valueMetadata.messageSchema then
            valueData = self:BuildValueDataFromMetadata(parsedArgs, valueMetadata) or {}
            if self.debug then self:Debug("ParseValue: valueData after BuildValueDataFromMetadata: %s",
                valueData and TableUtils.ToString(valueData, 2) or "nil") end
        end

        -- Create proto value node
        local protoNode = ASTValue.Create(valueMetadata.valueType, valueData)
        if not protoNode then
            self:Error("ParseValue: Failed to create proto value node for math.%s (valueType='%s')",
                funcName, tostring(valueMetadata.valueType))
            return nil
        end

        if self.debug then self:Debug("ParseValue: Successfully created proto value node for math.%s (valueType='%s')",
            funcName, tostring(valueMetadata.valueType)) end
        return protoNode
    end

    -- Check if it's a function call
    -- Pattern should handle:
    -- - NAG functions (NAG:FunctionName(args))
    -- - WoW API functions (UnitAffectingCombat("player"))
    -- - Lua standard library functions (string.format(...), math.max(...))

    -- Try flexible pattern that allows optional whitespace between function name and opening paren
    -- This handles reformatted text like "NAG:FunctionName ( args )"
    -- Also handles WoW API functions like "UnitAffectingCombat("player")"
    -- Also handles Lua stdlib functions like "string.format(...)" or "math.max(...)"
    local matchesNAGPattern = valueText:match("^NAG:%w+%s*%(")
    local matchesLuaStdlibPattern = valueText:match("^(string|math)%.%w+%s*%(")  -- Lua stdlib functions (string.format, math.max, etc.)
    local matchesWoWAPIPattern = valueText:match("^%w+%s*%(")  -- WoW API functions (no NAG: prefix, no dot)
    local matchesPattern = matchesNAGPattern or matchesLuaStdlibPattern or matchesWoWAPIPattern

    if matchesPattern then
        -- Extract function name (before any whitespace and opening paren)
        -- Try NAG: prefix first, then Lua stdlib, then WoW API function
        local funcName = valueText:match("^NAG:(%w+)")
        local isLuaStdlib = false
        local isWoWAPI = false

        if not funcName then
            -- Try Lua stdlib function pattern (string.format, math.max, etc.)
            local stdlibMatch = valueText:match("^((string|math)%.%w+)%s*%(")
            if stdlibMatch then
                funcName = stdlibMatch
                isLuaStdlib = true
            else
                -- Try WoW API function pattern (no NAG: prefix, no dot)
                funcName = valueText:match("^(%w+)%s*%(")
                isWoWAPI = funcName ~= nil
            end
        end

        if not funcName then
            self:Warn("ParseValue: Pattern matched but couldn't extract function name from '%s'", valueText:sub(1, 50))
            local constNode = ASTValue.CreateConst(valueText)
            return constNode
        end

        -- Find the matching closing paren for nested parentheses
        -- Start after the opening paren: NAG:FunctionName(|<args>)
        -- Find first opening paren (accounting for potential whitespace)
        local startPos = valueText:find("%(")
        if not startPos then
            -- Should never happen if matchesPattern is true, but be safe
            self:Warn("ParseValue: Pattern matched but couldn't find opening paren in '%s'", valueText:sub(1, 50))
            local constNode = ASTValue.CreateConst(valueText)
            return constNode
        end

        -- Find matching closing paren by tracking depth
        local parenLevel = 0
        local argsText = nil
        local inString = false
        local stringQuote = nil

        for i = startPos, #valueText do
            local ch = valueText:sub(i, i)

            if not inString then
                if ch == '"' or ch == "'" then
                    inString = true
                    stringQuote = ch
                elseif ch == "(" then
                    parenLevel = parenLevel + 1
                elseif ch == ")" then
                    parenLevel = parenLevel - 1
                    if parenLevel == 0 then
                        -- Found matching closing paren - extract args between opening and closing
                        argsText = valueText:sub(startPos + 1, i - 1)
                        break
                    end
                end
            else
                -- Inside string - ignore parens
                if ch == stringQuote then
                    inString = false
                    stringQuote = nil
                end
            end
        end

        if self.debug then self:Debug("ParseValue: Function call detected - funcName='%s', argsText='%s'", funcName or "nil", argsText or "nil") end
        local parsedArgs = argsText and self:ParseFunctionArgs(argsText) or {}

        -- Validation: Warn about parser bugs
        if funcName and funcName:find("%(") then
            self:Warn("Parser bug: functionName contains arguments: %s", funcName)
        end
        if not parsedArgs or #parsedArgs == 0 then
            if argsText and argsText ~= "" then
                self:Warn("Parser bug: Function has args in text but arguments empty: %s", valueText)
            end
        end

        -- For Lua stdlib functions (string.format, math.max, etc.), skip schema lookup entirely
        -- They won't be in the schema and will be handled as raw Lua function calls at runtime
        if isLuaStdlib then
            if self.debug then self:Debug("ParseValue: Lua stdlib function detected: '%s' - creating CONST node for runtime execution", funcName) end
            -- For Lua stdlib functions, create a const node with the original text
            -- This preserves the function call structure while indicating it's not a recognized NAG function
            -- The evaluation system will handle these as raw Lua function calls at runtime
            local constNode = ASTValue.CreateConst(valueText)
            -- Note: originalText removed - use ASTSchemaEmitter.EmitValueNode(node) for text synthesis
            constNode.isLuaStdlibCall = true  -- Mark as Lua stdlib call for evaluation
            constNode.funcName = funcName
            constNode.parsedArgs = parsedArgs
            return constNode
        end

        -- For WoW API functions (no NAG: prefix), skip schema lookup entirely
        -- They won't be in the schema and will be handled as raw WoW API calls at runtime
        if isWoWAPI then
            if self.debug then self:Debug("ParseValue: WoW API function detected: '%s' - creating CONST node for runtime execution", funcName) end
            -- For WoW API functions, create a const node with the original text
            -- This preserves the function call structure while indicating it's not a recognized NAG function
            -- The evaluation system will handle these as raw WoW API calls at runtime
            local constNode = ASTValue.CreateConst(valueText)
            -- Note: originalText removed - use ASTSchemaEmitter.EmitValueNode(node) for text synthesis
            constNode.isWoWAPICall = true  -- Mark as WoW API call for evaluation
            constNode.funcName = funcName
            constNode.parsedArgs = parsedArgs
            return constNode
        end

        -- NAG function - resolve metadata to get value type and schema
        -- Use SchemaAccessor:GetMetadataByIdentifier with auto-detection (single source of truth)
        local SchemaAccessor = NAG:GetModule("SchemaAccessor")

        -- Check nagFunctionMappings first (e.g., "AuraIsActive" -> "APLValueAuraIsActive")
        local snakeIdentifier = nil
        if SchemaAccessor and SchemaAccessor.nagFunctionMappings and SchemaAccessor.nagFunctionMappings[funcName] then
            local protoName = SchemaAccessor.nagFunctionMappings[funcName]
            -- Extract value name from proto name (e.g., "APLValueAuraIsActive" -> "AuraIsActive")
            local valueName = protoName:match("^APLValue(.+)$")
            if valueName then
                snakeIdentifier = SchemaUtils:CamelToSnake(valueName)
            end
        end

        -- If no mapping, convert funcName directly to snake_case
        if not snakeIdentifier then
            snakeIdentifier = SchemaUtils:CamelToSnake(funcName)
        end

        if self.debug then self:Debug("ParseValue: Resolving metadata for NAG function '%s' -> snakeIdentifier='%s'", funcName or "nil", snakeIdentifier or "nil") end

        local valueMetadata = nil
        if snakeIdentifier and SchemaAccessor then
            valueMetadata = SchemaAccessor:GetMetadataByIdentifier(snakeIdentifier, nil)  -- Use auto-detection (fixes "Cast" being treated as value)
        end

        if self.debug then self:Debug("ParseValue: GetMetadataByIdentifier returned: valueMetadata=%s, valueType=%s, actionType=%s",
            valueMetadata and "table" or "nil",
            valueMetadata and valueMetadata.valueType or "nil",
            valueMetadata and valueMetadata.actionType or "nil") end

        -- DEBUG: Log all function calls and arguments for debugging
        if self.debug then self:Debug("ParseValue: Function call DEBUG - funcName='%s', #parsedArgs=%d", funcName or "nil", #parsedArgs) end
        for i, arg in ipairs(parsedArgs) do
            local extracted = ExtractProtoValue(arg)
            if self.debug then self:Debug("ParseValue: Function call DEBUG - parsedArgs[%d]: type=%s, extracted=%s, arg=%s",
                i, type(arg), tostring(extracted), type(arg) == "table" and TableUtils.ToString(arg, 1) or tostring(arg)) end
        end

        -- Check if it's actually a value (not an action that was incorrectly parsed as value)
        if valueMetadata and valueMetadata.valueType then
            if self.debug then self:Debug("ParseValue: Successfully resolved metadata for '%s' -> valueType='%s'", funcName, valueMetadata.valueType) end
        elseif valueMetadata and valueMetadata.actionType then
            -- This is actually an action, not a value - this shouldn't happen in ParseValue
            self:Warn("ParseValue: Function '%s' (snakeIdentifier='%s') is an action, not a value. This may indicate a parsing issue.", funcName, snakeIdentifier)
            local constNode = ASTValue.CreateConst(valueText)
            return constNode
        else
            -- NAG function without metadata - this is an error
            self:Warn("ParseValue: GetMetadataByIdentifier failed for NAG function '%s' (snakeIdentifier='%s') - valueMetadata=%s, valueType=%s",
                funcName or "nil",
                snakeIdentifier or "nil",
                valueMetadata and "table" or "nil",
                valueMetadata and valueMetadata.valueType or "nil")
            -- Return as constant
            local constNode = ASTValue.CreateConst(valueText)
            -- Note: originalText removed - use ASTSchemaEmitter.EmitValueNode(node) for text synthesis
            return constNode
        end

        -- Build value data from arguments using schema
        local valueData = {}
        if valueMetadata.messageSchema then
            valueData = self:BuildValueDataFromMetadata(parsedArgs, valueMetadata) or {}

            -- DEBUG: Log valueData structure for all functions (consistent logging)
            if self.debug then self:Debug("ParseValue: valueData after BuildValueDataFromMetadata: %s",
                valueData and TableUtils.ToString(valueData, 2) or "nil") end
        end

        -- Create proto value node
        local protoNode = ASTValue.Create(valueMetadata.valueType, valueData)
        if not protoNode then
            self:Error("ParseValue: Failed to create proto value node for functionName='%s' (valueType='%s')",
                funcName or "nil", tostring(valueMetadata.valueType))
            return nil
        end
        -- Note: originalText removed - use ASTSchemaEmitter.EmitValueNode(node) for text synthesis
        if self.debug then self:Debug("ParseValue: Successfully created proto value node for functionName='%s' (valueType='%s')",
            funcName or "nil", tostring(valueMetadata.valueType)) end
        return protoNode
    end

    -- Check for boolean literals (true/false)
    if valueText == "true" or valueText == "false" then
        local boolValue = (valueText == "true")
        if self.debug then self:Debug("ParseValue: Matched as boolean: '%s' -> %s", valueText, tostring(boolValue)) end
        local constNode = ASTValue.CreateConst(boolValue)
        if not constNode then
            self:Error("ParseValue: Failed to create const node for boolean: %s", tostring(boolValue))
            return nil
        end
        return constNode
    end

    -- Check for table literals {key = value, ...}
    if valueText:match("^{") and valueText:match("}$") then
        if self.debug then self:Debug("ParseValue: Matched as table literal: '%s'", valueText:sub(1, 100)) end
        -- Parse table literal using loadstring (safe since we control the input)
        -- Wrap in return statement to get the table value
        local chunkText = "return " .. valueText
        local func, err = loadstring(chunkText)
        if func then
            local success, result = pcall(func)
            if success and type(result) == "table" then
                if self.debug then self:Debug("ParseValue: Successfully parsed table literal with %d keys", TableUtils.Size(result)) end
                -- Return the table as-is (will be validated by ConvertFieldValueForParser)
                return result
            else
                self:Warn("ParseValue: Failed to execute table literal: %s", tostring(result))
            end
        else
            self:Warn("ParseValue: Failed to parse table literal: %s", tostring(err))
        end
        -- If parsing failed, continue to other checks
    end

    -- Check for identifier references (NAG.SPELL_POSITIONS.AOE, NAG.Types.RuneType.RuneBlood, etc.)
    -- Pattern: starts with identifier, followed by one or more dot-separated identifiers
    -- Examples: NAG.SPELL_POSITIONS.AOE, NAG.Types.RuneType.RuneBlood, ns.SPELL_POSITIONS.ABOVE
    -- This check happens BEFORE function calls to catch constants like NAG.SPELL_POSITIONS.LEFT
    -- Simple check: must contain at least one dot, start with letter/underscore, all parts are valid identifiers

    -- Check if string contains at least one dot (required for identifier reference)
    if valueText:find("%.") then
        -- Explicit check for NAG.SPELL_POSITIONS.* constants (common developer shortcut)
        if valueText:match("^NAG%.SPELL_POSITIONS%.%w+$") or valueText:match("^ns%.SPELL_POSITIONS%.%w+$") then
            if self.debug then self:Debug("ParseValue: Matched as SPELL_POSITIONS constant: '%s'", valueText) end
            local constNode = ASTValue.CreateConst(valueText)
            if not constNode then
                self:Error("ParseValue: Failed to create const node for SPELL_POSITIONS constant: '%s'", valueText)
                return nil
            end
            constNode.isIdentifier = true
            if self.debug then self:Debug("ParseValue: Successfully parsed SPELL_POSITIONS constant: '%s'", valueText) end
            return constNode
        end

        -- Explicit check for NAG.Types.RuneType.* and NAG.Types.RuneSlot.* (Death Knight rune enums)
        -- These appear as arguments in rotation strings (e.g. NAG:CurrentRuneActive(NAG.Types.RuneSlot.SlotLeftUnholy))
        if valueText:match("^NAG%.Types%.RuneType%.%w+$") or valueText:match("^ns%.Types%.RuneType%.%w+$") or
           valueText:match("^NAG%.Types%.RuneSlot%.%w+$") or valueText:match("^ns%.Types%.RuneSlot%.%w+$") then
            if self.debug then self:Debug("ParseValue: Matched as NAG.Types rune constant: '%s'", valueText) end
            local constNode = ASTValue.CreateConst(valueText)
            if not constNode then
                self:Error("ParseValue: Failed to create const node for rune constant: '%s'", valueText)
                return nil
            end
            constNode.isIdentifier = true
            return constNode
        end

        -- Pattern: identifier followed by one or more dot-separated identifiers
        -- Use %w which matches word characters (letters, digits, underscore)
        -- Pattern breakdown: ^%w+ matches first identifier, (%.%w+)+ matches one or more dot-separated identifiers
        local identifierPattern = "^%w+(%.%w+)+$"
        local fullMatch = valueText:match(identifierPattern)
        if fullMatch and fullMatch == valueText then
            if self.debug then self:Debug("ParseValue: Matched as identifier reference: '%s'", valueText) end
            -- Create constant with identifier marker
            local constNode = ASTValue.CreateConst(valueText)
            if not constNode then
                self:Error("ParseValue: Failed to create const node for identifier reference: '%s'", valueText)
                return nil
            end
            -- Note: originalText removed - use ASTSchemaEmitter.EmitValueNode(node) for text synthesis
            constNode.isIdentifier = true
            if self.debug then self:Debug("ParseValue: Successfully parsed identifier reference: '%s'", valueText) end
            return constNode
        end
    end



    -- If value contains logical operators at top level, treat as condition (e.g. "(A) and (B)" passed from not(...) inner)
    -- ParseValue does not handle and/or; delegating avoids "No pattern matched" and wrong string-constant fallback.
    if self:HasLogicalOperators(valueText) then
        if self.debug then self:Debug("ParseValue: Delegating to ParseOrExpression for value with logical operators") end
        return self:ParseOrExpression(valueText)
    end

    -- Fallback: value looks like a function-call expression (e.g. string.format(...) in overlay text)
    -- Treat as expression so emitter keeps it unquoted; avoids "No pattern matched" for overlay args
    if valueText:match("^[%w_%.]+%s*%(") then
        local constNode = ASTValue.CreateConst(valueText)
        if constNode then
            constNode.isFunctionExpression = true
            if self.debug then self:Debug("ParseValue: Treating as function expression (overlay/code): '%s'", valueText:sub(1, 60) .. (#valueText > 60 and "..." or "")) end
            return constNode
        end
    end

    -- Default to string constant
    self:Warn("ParseValue: No pattern matched for value '%s', returning as string constant (may indicate unrecognized format)",
        valueText:sub(1, 50) .. (#valueText > 50 and "..." or ""))
    local constNode = ASTValue.CreateConst(valueText)
    if not constNode then
        self:Error("ParseValue: Failed to create constant node for: '%s'", valueText)
        return nil
    end
    return constNode
end

--- Parse math expression with proper operator precedence
--- Handles: + - * / with standard precedence
--- @param expr string The expression to parse
--- @return table|nil Parsed expression node or nil if no math operators found
function NAGStringParser:ParseMathExpression(expr)
    -- 1. Strip outer whitespace
    expr = expr:match("^%s*(.-)%s*$")

    -- 2. Strip outer parentheses recursively - math operators need to be at depth 0 to be found
    local stripped = self:StripOuterParentheses(expr, false)
    if stripped then
        if self.debug then self:Debug("ParseMathExpression: Stripped outer parentheses, recursing: '%s' -> '%s'",
            expr:sub(1, 60) .. (#expr > 60 and "..." or ""),
            stripped:sub(1, 60) .. (#stripped > 60 and "..." or "")) end
        return self:ParseMathExpression(stripped)
    else
        if self.debug then self:Debug("ParseMathExpression: StripOuterParentheses returned nil for: '%s' (first 100 chars)",
            expr:sub(1, 100) .. (#expr > 100 and "..." or "")) end
    end

    -- 3. Try addition/subtraction first (lowest precedence)
    local addResult = self:ParseAddSubExpression(expr)
    if addResult then
        if self.debug then self:Debug("ParseMathExpression: Found addition/subtraction expression") end
        return addResult
    end

    -- 4. If no add/sub, try multiplication/division
    local mulResult = self:ParseMulDivExpression(expr)
    if mulResult then
        if self.debug then self:Debug("ParseMathExpression: Found multiplication/division expression") end
        return mulResult
    end

    -- 5. Not a math expression, return nil (don't create constant here - that's ParseValue's job)
    return nil
end

--- Parse addition/subtraction expression (lowest precedence)
--- @param expr string The expression
--- @return table|nil Parsed node or nil
function NAGStringParser:ParseAddSubExpression(expr)
    -- 1. Strip outer whitespace
    expr = expr:match("^%s*(.-)%s*$")

    -- 2. Strip outer parentheses recursively - operators need to be at depth 0 to be found
    local stripped = self:StripOuterParentheses(expr, false)
    if stripped then
        if self.debug then self:Debug("ParseAddSubExpression: Stripped outer parentheses, recursing: '%s' -> '%s'",
            expr:sub(1, 60) .. (#expr > 60 and "..." or ""),
            stripped:sub(1, 60) .. (#stripped > 60 and "..." or "")) end
        return self:ParseAddSubExpression(stripped)
    end

    -- 3. Look for + or - operators at depth 0
    local parts = self:SplitOnMathOperator(expr, "[%+%-]")
    if #parts > 1 then
        -- Found + or - operator
        local op = parts[3]  -- Use operator from SplitOnMathOperator (the one used for splitting)
        if not op then
            self:Error("ParseAddSubExpression: SplitOnMathOperator returned %d parts but parts[3] (operator) is nil. parts=%s",
                #parts, TableUtils.ToString(parts))
            return nil
        end
        -- Convert operator to proto format
        local protoOp = ASTValue.SymbolToMathOp(op)
        if not protoOp then
            self:Error("ParseAddSubExpression: Failed to convert operator '%s' to proto format", op or "nil")
            return nil
        end
        -- Parse lhs and rhs to proto AST
        -- Proper RDP: recursively parse left operand (may contain more additions) before trying higher precedence
        -- ParseValue will handle logical operators in operands (e.g., "or 0" fallback patterns)
        local lhsNode = self:ParseAddSubExpression(parts[1]) or self:ParseMulDivExpression(parts[1]) or self:ParseValue(parts[1])
        local rhsNode = self:ParseAddSubExpression(parts[2]) or self:ParseValue(parts[2])
        if not lhsNode or not rhsNode then
            self:Error("ParseAddSubExpression: Failed to parse operands (lhs=%s, rhs=%s)",
                lhsNode and "ok" or "nil", rhsNode and "ok" or "nil")
            return nil
        end
        -- Create math node
        local mathNode = ASTValue.CreateMath(protoOp, lhsNode, rhsNode)
        if not mathNode then
            self:Error("ParseAddSubExpression: Failed to create math node (op='%s')", op or "nil")
            return nil
        end
        -- Note: originalText removed - use ASTSchemaEmitter.EmitValueNode(node) for text synthesis
        return mathNode
    end
    return nil
end

--- Parse multiplication/division expression (higher precedence)
--- @param expr string The expression
--- @return table|nil Parsed node or nil
function NAGStringParser:ParseMulDivExpression(expr)
    -- 1. Strip outer whitespace
    expr = expr:match("^%s*(.-)%s*$")

    -- 2. Strip outer parentheses recursively - operators need to be at depth 0 to be found
    local stripped = self:StripOuterParentheses(expr, false)
    if stripped then
        if self.debug then self:Debug("ParseMulDivExpression: Stripped outer parentheses, recursing: '%s' -> '%s'",
            expr:sub(1, 60) .. (#expr > 60 and "..." or ""),
            stripped:sub(1, 60) .. (#stripped > 60 and "..." or "")) end
        return self:ParseMulDivExpression(stripped)
    end

    -- 3. Look for * or / operators at depth 0
    local parts = self:SplitOnMathOperator(expr, "[%*/]")
    if #parts > 1 then
        -- Found * or / operator
        local op = parts[3]  -- Use operator from SplitOnMathOperator (the one used for splitting)
        if not op then
            self:Error("ParseMulDivExpression: SplitOnMathOperator returned %d parts but parts[3] (operator) is nil. parts=%s",
                #parts, TableUtils.ToString(parts))
            return nil
        end
        -- Convert operator to proto format
        local protoOp = ASTValue.SymbolToMathOp(op)
        if not protoOp then
            self:Error("ParseMulDivExpression: Failed to convert operator '%s' to proto format", op)
            return nil
        end
        -- Parse lhs and rhs to proto AST
        -- Proper RDP: recursively parse left operand (may contain more multiplications/divisions) before trying ParseValue
        local lhsNode = self:ParseMulDivExpression(parts[1]) or self:ParseValue(parts[1])
        local rhsNode = self:ParseMulDivExpression(parts[2]) or self:ParseValue(parts[2])
        if not lhsNode or not rhsNode then
            self:Error("ParseMulDivExpression: Failed to parse operands (lhs=%s, rhs=%s)",
                lhsNode and "ok" or "nil", rhsNode and "ok" or "nil")
            return nil
        end
        -- Create math node
        local mathNode = ASTValue.CreateMath(protoOp, lhsNode, rhsNode)
        if not mathNode then
            self:Error("ParseMulDivExpression: Failed to create math node (op='%s')", op)
            return nil
        end
        -- Note: originalText removed - use ASTSchemaEmitter.EmitValueNode(node) for text synthesis
        return mathNode
    end
    return nil
end

--- Split expression on math operator respecting parentheses
--- @param expr string The expression
--- @param opPattern string Regex pattern for operators
--- @return table Array of [lhs, rhs, op] or just [expr] if no split
function NAGStringParser:SplitOnMathOperator(expr, opPattern)
    local depth = 0
    local inString = false
    local stringQuote = nil

    -- Find LAST occurrence of operator at depth 0 (for left-to-right evaluation)
    local lastOpPos = nil

    for i = 1, #expr do
        local ch = expr:sub(i, i)

        if not inString then
            if ch == '"' or ch == "'" then
                inString = true
                stringQuote = ch
            elseif ch == "(" then
                depth = depth + 1
            elseif ch == ")" then
                depth = depth - 1
            elseif depth == 0 and ch:match(opPattern) then
                -- Found operator at top level - keep searching for last one
                lastOpPos = i
            end
        else
            if ch == stringQuote then
                inString = false
                stringQuote = nil
            end
        end
    end

    if lastOpPos then
        local lhs = expr:sub(1, lastOpPos - 1):match("^%s*(.-)%s*$")
        local rhs = expr:sub(lastOpPos + 1):match("^%s*(.-)%s*$")
        local op = expr:sub(lastOpPos, lastOpPos)
        return {lhs, rhs, op}
    end

    return {expr}
end

--- Parses function arguments
--- @param argsText string The arguments text
--- @return table[] Array of parsed argument nodes
function NAGStringParser:ParseFunctionArgs(argsText)
    if not argsText or argsText == "" then
        return {}
    end

    if self.debug then self:Debug("ParseFunctionArgs: Starting to parse argsText='%s'", argsText) end

    local args = {}
    local current = ""
    local parenLevel = 0
    local braceLevel = 0  -- Track curly braces for tables
    local inString = false
    local stringQuote = nil

    for i = 1, #argsText do
        local ch = argsText:sub(i, i)

        if not inString then
            if ch == '"' or ch == "'" then
                inString = true
                stringQuote = ch
                current = current .. ch  -- Add opening quote to buffer
            elseif ch == "(" then
                parenLevel = parenLevel + 1
                current = current .. ch
            elseif ch == ")" then
                parenLevel = parenLevel - 1
                current = current .. ch
            elseif ch == "{" then
                braceLevel = braceLevel + 1
                current = current .. ch
            elseif ch == "}" then
                braceLevel = braceLevel - 1
                current = current .. ch
            elseif ch == "," and parenLevel == 0 and braceLevel == 0 then
                -- Argument separator - only split at top level (no nested parens or braces)
                local trimmed = current:match("^%s*(.-)%s*$")
                if trimmed and trimmed ~= "" then
                    if self.debug then self:Debug("ParseFunctionArgs: Extracted argument [%d]: '%s'", #args + 1, trimmed) end
                    table.insert(args, self:ParseValue(trimmed))
                end
                current = ""
            else
                current = current .. ch
            end
        else
            -- Inside string - add all characters including closing quote
            current = current .. ch
            if ch == stringQuote then
                inString = false
                stringQuote = nil
            end
        end
    end

    -- Add final argument
    local trimmed = current:match("^%s*(.-)%s*$")
    if trimmed and trimmed ~= "" then
        if self.debug then self:Debug("ParseFunctionArgs: Extracted final argument [%d]: '%s'", #args + 1, trimmed) end
        table.insert(args, self:ParseValue(trimmed))
    end

    if self.debug then self:Debug("ParseFunctionArgs: Completed parsing - extracted %d arguments", #args) end
    if #args == 0 and argsText and argsText ~= "" then
        self:Warn("ParseFunctionArgs: No arguments extracted from non-empty argsText: '%s'", argsText)
    end
    return args
end


--- Convert value according to schema field type
--- @param fieldInfo table Schema field information
--- @param rawValue any Raw value or proto AST node
--- @return any Converted value
local function ConvertFieldValueForParser(fieldInfo, rawValue)
    if not fieldInfo then
        -- Note: Can't use self:Warn here since this is a local function
        -- Logging happens in caller context
        return nil
    end

    -- Check if this is an identifier reference (NAG.Types.RuneType.RuneBlood, etc.)
    -- These should remain unresolved as strings, not converted to numeric enum values
    local isIdentifier = false
    if type(rawValue) == "table" then
        -- Check if the node has isIdentifier marker (set when parsing identifier references)
        if rawValue.isIdentifier == true then
            isIdentifier = true
        end
    end

    -- Extract value (identifier marker check happens above)
    local extracted = ExtractProtoValue(rawValue)

    if isIdentifier then
        -- Debug log for identifier references being preserved
        -- Note: We can't use self:Debug here since this is a local function, so logging happens in caller
    end

    if fieldInfo.type == "message" then
        local messageType = fieldInfo.message_type
        local FieldFormatConverter = ns.FieldFormatConverter

        -- Use schema-aware ToProto() method for all message type conversions
        if FieldFormatConverter then
            -- Special handling: reject position identifiers for UnitReference
            if messageType == "UnitReference" then
                if type(extracted) == "string" then
                    if extracted:match("^NAG%.SPELL_POSITIONS%.") or extracted:match("^ns%.SPELL_POSITIONS%.") then
                        -- This is a position identifier, not a unit reference - return nil to prevent incorrect conversion
                        return nil
                    end
                end
            end

            -- Special handling: preserve action nodes for APLAction message type
            if messageType == "APLAction" or (type(messageType) == "string" and messageType:find("^APLAction")) then
                if type(rawValue) == "table" and rawValue.type == ASTCore.NodeType.ACTION then
                    return rawValue
                end
                return nil
            end

            -- Special handling: For APLValue message types, call NormalizeAPLValue directly
            -- This bypasses ToProto's schema lookup path which may not handle AST nodes correctly
            if messageType == "APLValue" or (type(messageType) == "string" and messageType:find("^APLValue")) then
                -- Call NormalizeAPLValue directly with rawValue (AST node) to preserve structure
                -- NormalizeAPLValue is designed to handle AST nodes and will recursively normalize nested APLValue fields
                return FieldFormatConverter:NormalizeAPLValue(rawValue)
            else
                -- For other message types, use extracted value
                return FieldFormatConverter:ToProto(extracted, fieldInfo)
            end
        end

        -- Fallback if FieldFormatConverter not available (shouldn't happen)
        if type(rawValue) == "table" then
            return rawValue
        end
        return nil

    elseif fieldInfo.type == "enum" then
        -- Delegate all enum normalization to FieldFormatConverter
        -- FieldFormatConverter handles identifier strings, special enum types, and schema lookup
        local FieldFormatConverter = ns.FieldFormatConverter
        if FieldFormatConverter then
            -- Preserve identifier strings for execution-time resolution
            local options = {}
            if isIdentifier and type(extracted) == "string" then
                options.preserveIdentifiers = true
            end
            if NAG.debug then NAG:Debug("[NAGStringParser] Normalizing enum value using schema-aware NormalizeEnumValue() in BuildFieldValueFromMetadata() for enumType='%s'", tostring(fieldInfo.enum_type)) end
            return FieldFormatConverter:NormalizeEnumValue(extracted, fieldInfo.enum_type, options)
        end

        -- Fallback if FieldFormatConverter not available (shouldn't happen)
        local numeric = tonumber(extracted)
        return numeric

    elseif fieldInfo.type == "int32" or fieldInfo.type == "sint32" or fieldInfo.type == "uint32"
        or fieldInfo.type == "int64" or fieldInfo.type == "sint64" or fieldInfo.type == "uint64" then
        -- CRITICAL: Reject identifier strings for numeric fields - they should only match enum/string fields
        if isIdentifier and type(extracted) == "string" then
            return nil  -- Identifier strings should not be converted to numbers
        end
        return tonumber(extracted)

    elseif fieldInfo.type == "double" or fieldInfo.type == "float" then
        -- CRITICAL: Reject identifier strings for numeric fields - they should only match enum/string fields
        if isIdentifier and type(extracted) == "string" then
            return nil  -- Identifier strings should not be converted to numbers
        end
        return tonumber(extracted)

    elseif fieldInfo.type == "number" then
        -- Generic number type (used in schema modifications for convenience)
        -- CRITICAL: Reject identifier strings for numeric fields - they should only match enum/string fields
        if isIdentifier and type(extracted) == "string" then
            return nil  -- Identifier strings should not be converted to numbers
        end
        return tonumber(extracted)

    elseif fieldInfo.type == "bool" then
        if type(extracted) == "boolean" then
            return extracted
        end
        if type(extracted) == "number" then
            return extracted ~= 0
        end
        if type(extracted) == "string" then
            local normalized = extracted:lower():match("^%s*(.-)%s*$")
            if normalized == "true" or normalized == "yes" or normalized == "on" or normalized == "enabled" or normalized == "1" then
                return true
            elseif normalized == "false" or normalized == "no" or normalized == "off" or normalized == "disabled" or normalized == "0" then
                return false
            end
        end
        return nil

    elseif fieldInfo.type == "string" then
        if extracted == nil then
            return nil
        end
        return tostring(extracted)
    end

    return rawValue
end

--- Get normalized argument type for type-based matching
--- @param argValue any Raw argument value
--- @param extracted any Extracted value from ExtractProtoValue
--- @return string|nil Normalized type: "number", "string", "boolean", "message", or nil
local function GetArgumentTypeForMatching(argValue, extracted)
    if type(extracted) == "number" then
        return "number"
    elseif type(extracted) == "string" then
        -- Check if it's an identifier reference (should match enum/string fields)
        if type(argValue) == "table" and argValue.isIdentifier == true then
            return "identifier_string"
        end
        return "string"
    elseif type(extracted) == "boolean" then
        return "boolean"
    elseif type(extracted) == "table" then
        -- Could be a message type
        return "message"
    end
    return nil
end

--- Find matching optional field for an argument based on type
--- @param argValue any Raw argument value
--- @param extracted any Extracted value from ExtractProtoValue
--- @param optionalFields table Array of optional field names
--- @param fields table Schema fields dictionary
--- @param fieldOrder table Field order array (for positional fallback)
--- @param assignedFields table Set of already assigned field names
--- @param ConvertFieldValueForParser function Converter function
--- @return string|nil Field name if a unique match is found, nil otherwise
local function FindMatchingOptionalField(argValue, extracted, optionalFields, fields, fieldOrder, assignedFields, ConvertFieldValueForParser)
    local argType = GetArgumentTypeForMatching(argValue, extracted)
    if not argType then
        return nil
    end

    -- Check if this is a function expression (marked with isFunctionExpression flag)
    local isFunctionExpression = (type(argValue) == "table" and argValue.isFunctionExpression == true) or
                                 (type(extracted) == "string" and extracted:match("^function%s*%("))

    local matchingFields = {}

    -- Try to match argument to each unassigned optional field by type
    for _, fieldName in ipairs(optionalFields) do
        -- Skip if already assigned
        if not assignedFields[fieldName] then
            local fieldInfo = fields[fieldName]
            if fieldInfo then
                -- Test if this argument can be converted for this field
                local converted = ConvertFieldValueForParser(fieldInfo, argValue)
                if converted ~= nil then
                    table.insert(matchingFields, fieldName)
                end
            end
        end
    end

    -- If no matches found, return nil (will fall back to positional)
    if #matchingFields == 0 then
        return nil
    end

    -- If exactly one match, return it
    if #matchingFields == 1 then
        return matchingFields[1]
    end

    -- CRITICAL: Function expressions should prioritize interrupt_if fields
    -- This ensures function() return ... end expressions go to interrupt_if, not target
    if isFunctionExpression then
        local interruptIfMatches = {}
        local otherMatches = {}
        for _, fieldName in ipairs(matchingFields) do
            if fieldName == "interrupt_if" or fieldName == "interruptIf" then
                table.insert(interruptIfMatches, fieldName)
            else
                table.insert(otherMatches, fieldName)
            end
        end
        -- If we have interrupt_if matches, prefer them
        if #interruptIfMatches > 0 then
            matchingFields = interruptIfMatches
            -- If still multiple matches (unlikely), use positional order
            if #matchingFields == 1 then
                return matchingFields[1]
            end
        end
    end

    -- Multiple matches - prioritize enum fields for identifier strings, then use positional order
    -- CRITICAL: Identifier strings (like NAG.SPELL_POSITIONS.AOE) should match enum fields, not numeric fields
    if argType == "identifier_string" then
        -- Prefer enum fields over numeric/other fields for identifier strings
        local enumMatches = {}
        local otherMatches = {}
        for _, fieldName in ipairs(matchingFields) do
            local fieldInfo = fields[fieldName]
            if fieldInfo and fieldInfo.type == "enum" then
                table.insert(enumMatches, fieldName)
            else
                table.insert(otherMatches, fieldName)
            end
        end
        -- If we have enum matches, prefer them
        if #enumMatches > 0 then
            matchingFields = enumMatches
        end
    end

    -- Use positional order from fieldOrder as tiebreaker
    -- Find the field that appears earliest in fieldOrder
    local bestMatch = nil
    local bestPosition = math.huge
    for _, fieldName in ipairs(matchingFields) do
        for i, orderedField in ipairs(fieldOrder) do
            if orderedField == fieldName then
                if i < bestPosition then
                    bestPosition = i
                    bestMatch = fieldName
                end
                break
            end
        end
    end

    return bestMatch
end

--- Build value data from metadata and parsed arguments
--- @param parsedArgs table[] Array of proto AST value nodes (from ParseFunctionArgs)
--- @param metadata table Schema metadata with messageSchema
--- @return table|nil Value data structure
function NAGStringParser:BuildValueDataFromMetadata(parsedArgs, metadata)

    if not metadata or not metadata.messageSchema then
        self:Warn("BuildValueDataFromMetadata: Invalid metadata (metadata=%s, messageSchema=%s) - cannot build value data",
            metadata and "present" or "nil",
            metadata and metadata.messageSchema and "present" or "nil")
        self:Error("BuildValueDataFromMetadata: Invalid metadata (metadata=%s, messageSchema=%s)",
            metadata and "present" or "nil",
            metadata and metadata.messageSchema and "present" or "nil")
        return nil
    end

    local schema = metadata.messageSchema
    local fieldOrder = schema.field_order or {}
    local fields = schema.fields or {}
    local arguments = parsedArgs or {}
    local valueData = {}
    local argIndex = 1

    -- Log field_order for all functions (helps debug argument mapping issues)
    if self.debug then self:Debug("BuildValueDataFromMetadata: Field order: %s", table.concat(fieldOrder, ", ")) end
    if self.debug then self:Debug("BuildValueDataFromMetadata: Processing valueType='%s' with %d arguments",
        metadata.valueType or "nil", #arguments) end

    -- Log all arguments for consistent debugging
    for i, arg in ipairs(arguments) do
        local extracted = ExtractProtoValue(arg)
        if self.debug then self:Debug("BuildValueDataFromMetadata: ARG[%d]: type=%s, extracted=%s",
            i, type(arg), tostring(extracted)) end
    end

    -- Process ALL fields in field_order positionally (both required and optional)
    -- This respects the modified field_order from SchemaModifications
    -- Type-based matching is only used as a fallback for unmatched arguments

    local assignedFields = {}  -- Track which fields have been assigned
    local assignedArgIndices = {}  -- Track which argument indices were assigned

    -- Phase 1: Process all non-repeated fields in field_order order positionally
    for _, fieldName in ipairs(fieldOrder) do
        local fieldInfo = fields[fieldName]
        if fieldInfo and fieldInfo.label ~= "repeated" and not assignedFields[fieldName] then
            local value = nil
            local testConverted = nil  -- Declare outside if block for use later

            -- Try to get value from current argument position
            if argIndex <= #arguments then
                local testValue = arguments[argIndex]
                local extracted = ExtractProtoValue(testValue)

                if self.debug then self:Debug("BuildValueDataFromMetadata: Testing field '%s' (type=%s, message_type=%s) with arg[%d] (extracted=%s, type=%s)",
                    fieldName, fieldInfo.type or "nil", fieldInfo.message_type or "nil", argIndex, tostring(extracted), type(extracted)) end

                -- DEBUG: Special logging for APLValue fields (like target_energy in EnergyTimeToTarget)
                if fieldInfo.type == "message" and fieldInfo.message_type and (fieldInfo.message_type == "APLValue" or fieldInfo.message_type:find("^APLValue")) then
                    if self.debug then self:Debug("BuildValueDataFromMetadata: APLValue DEBUG - Field '%s': rawValue type=%s, rawValue.type=%s, extracted=%s (type=%s)",
                        fieldName,
                        type(testValue),
                        type(testValue) == "table" and tostring(testValue.type) or "N/A",
                        tostring(extracted),
                        type(extracted)) end
                    if type(testValue) == "table" then
                        local hasValueType = testValue.type == ASTCore.NodeType.VALUE
                        local valueType = hasValueType and ASTValue.GetValueType(testValue) or "N/A"
                        if self.debug then self:Debug("BuildValueDataFromMetadata: APLValue DEBUG - Field '%s': testValue.type==VALUE? %s, GetValueType=%s",
                            fieldName, tostring(hasValueType), tostring(valueType)) end
                    end
                end

                testConverted = ConvertFieldValueForParser(fieldInfo, testValue)

                if self.debug then self:Debug("BuildValueDataFromMetadata: testConverted for field '%s': %s (type=%s)",
                    fieldName, tostring(testConverted), type(testConverted)) end

                -- DEBUG: Special logging for APLValue fields after conversion
                if fieldInfo.type == "message" and fieldInfo.message_type and (fieldInfo.message_type == "APLValue" or fieldInfo.message_type:find("^APLValue")) then
                    if self.debug then self:Debug("BuildValueDataFromMetadata: APLValue DEBUG - Field '%s': testConverted=%s (type=%s)",
                        fieldName, testConverted and tostring(testConverted) or "nil", testConverted and type(testConverted) or "nil") end
                    if testConverted == nil then
                        self:Warn("BuildValueDataFromMetadata: APLValue DEBUG - Field '%s': ConvertFieldValueForParser returned nil! rawValue type=%s",
                            fieldName, type(testValue))
                    end
                end

                if testConverted ~= nil then
                    -- Conversion succeeded, use this argument
                    -- Check if this is an identifier reference being preserved unresolved
                    local isPreservedIdentifier = (type(testConverted) == "string" and type(testValue) == "table" and testValue.isIdentifier == true)
                    if isPreservedIdentifier then
                        if self.debug then self:Debug("BuildValueDataFromMetadata: Conversion succeeded for field '%s' -> preserved identifier reference (unresolved): '%s'", fieldName, tostring(testConverted)) end
                    else
                        if self.debug then self:Debug("BuildValueDataFromMetadata: Conversion succeeded for field '%s' -> converted=%s", fieldName, tostring(testConverted)) end
                    end
                    value = testValue
                    assignedFields[fieldName] = true
                    assignedArgIndices[argIndex] = true  -- Track that this argument was assigned
                    argIndex = argIndex + 1

                    if self.debug then self:Debug("BuildValueDataFromMetadata: Successfully mapped arg[%d] to field '%s'", argIndex - 1, fieldName) end
                else
                    -- Conversion failed
                    -- For optional fields, skip this field and try next field with same argument
                    -- For required fields, we still skip but warn (type-based fallback will try to match it later)
                    if fieldInfo.label == "required" then
                        self:Warn("BuildValueDataFromMetadata: Conversion failed for required field '%s' with arg[%d] (extracted=%s, type=%s, valueType='%s'). " ..
                            "Will attempt type-based fallback matching.",
                            fieldName, argIndex, tostring(extracted), type(extracted), metadata.valueType or "unknown")
                    end
                    -- Don't increment argIndex - let next field try this argument, or type-based fallback will handle it
                end
            else
                -- No argument available at this position
                if fieldInfo.label == "required" then
                    self:Warn("BuildValueDataFromMetadata: No argument available at argIndex=%d (total args=%d) for required field '%s' (valueType='%s')",
                        argIndex, #arguments, fieldName, metadata.valueType or "unknown")
                else
                end
            end

            -- Store the value if conversion succeeded
            -- Use testConverted if available (already computed), otherwise convert again
            local converted = nil
            if value ~= nil then
                -- If we already computed testConverted successfully, use it (avoid double conversion)
                if testConverted ~= nil then
                    converted = testConverted
                    if self.debug then self:Debug("BuildValueDataFromMetadata: Using pre-computed conversion for field '%s': %s (type=%s)",
                        fieldName, tostring(converted), type(converted)) end
                else
                    -- Re-convert (shouldn't happen if testConverted was computed, but handle gracefully)
                    converted = ConvertFieldValueForParser(fieldInfo, value)
                    if converted then
                        if self.debug then self:Debug("BuildValueDataFromMetadata: Re-converted field '%s': %s (type=%s)",
                            fieldName, tostring(converted), type(converted)) end
                    else
                        if self.debug then self:Debug("BuildValueDataFromMetadata: Re-conversion failed for field '%s' (value type=%s)",
                            fieldName, type(value)) end
                    end
                end
            end

            if converted ~= nil then
                valueData[fieldName] = converted

                if self.debug then self:Debug("BuildValueDataFromMetadata: Stored field '%s' in valueData: %s (type=%s)",
                    fieldName, tostring(converted), type(converted)) end

                -- DEBUG: Final verification for APLValue fields
                if fieldInfo.type == "message" and fieldInfo.message_type and (fieldInfo.message_type == "APLValue" or fieldInfo.message_type:find("^APLValue")) then
                    local storedValue = valueData[fieldName]
                    if self.debug then self:Debug("BuildValueDataFromMetadata: APLValue DEBUG - Final stored value for field '%s': type=%s, storedValue.type=%s",
                        fieldName, type(storedValue), type(storedValue) == "table" and tostring(storedValue.type) or "N/A") end
                    if type(storedValue) == "string" then
                        self:Error("BuildValueDataFromMetadata: APLValue DEBUG - CRITICAL: Field '%s' stored as STRING in valueData! This will fail validation!",
                            fieldName)
                    end
                end
            end
        end
    end

    -- Phase 2: Type-based matching fallback for unmatched arguments
    -- Collect remaining unassigned arguments that weren't matched positionally
    local remainingArgs = {}
    for i = 1, #arguments do
        if not assignedArgIndices[i] then
            local extracted = ExtractProtoValue(arguments[i])
            if extracted ~= nil then  -- Skip nil arguments
                table.insert(remainingArgs, {index = i, value = arguments[i]})
            end
        end
    end

    -- Collect unassigned fields (both required and optional) for type-based matching
    -- This helps when field_order doesn't match the actual argument order
    local unassignedFields = {}
    for _, fieldName in ipairs(fieldOrder) do
        local fieldInfo = fields[fieldName]
        if fieldInfo and fieldInfo.label ~= "repeated" and not assignedFields[fieldName] then
            table.insert(unassignedFields, fieldName)
        end
    end

    -- Try to match unmatched arguments to unassigned fields by type (fallback only)
    -- This is especially important when field_order modification isn't applied or is incorrect
    if #remainingArgs > 0 and #unassignedFields > 0 then
        for _, argInfo in ipairs(remainingArgs) do
            local argValue = argInfo.value
            local extracted = ExtractProtoValue(argValue)

            -- Try to find matching field using type-based matching (both required and optional)
            local matchedField = FindMatchingOptionalField(argValue, extracted, unassignedFields, fields, fieldOrder, assignedFields, ConvertFieldValueForParser)

            if matchedField then
                local fieldInfo = fields[matchedField]
                if fieldInfo then
                    local testConverted = ConvertFieldValueForParser(fieldInfo, argValue)
                    if testConverted ~= nil then
                        valueData[matchedField] = testConverted
                        assignedFields[matchedField] = true
                        assignedArgIndices[argInfo.index] = true
                        if self.debug then self:Debug("BuildValueDataFromMetadata: Type-based fallback match - arg[%d] matched to field '%s' (type=%s, label=%s)",
                            argInfo.index, matchedField, fieldInfo.type or "nil", fieldInfo.label or "nil") end
                    end
                end
            end
        end
    end

    -- Process all fields to handle repeated fields (BEFORE warning about unmatched args)
    -- Repeated fields consume all remaining unassigned arguments, so we need to process them first
    -- This prevents false warnings for math.min/math.max which use repeated fields
    for _, fieldName in ipairs(fieldOrder) do
        local fieldInfo = fields[fieldName]
        if fieldInfo then
            -- Handle repeated fields (consume all remaining unassigned arguments)
            if fieldInfo.label == "repeated" then
                local values = {}
                -- Collect all remaining unassigned arguments for repeated fields
                for i = 1, #arguments do
                    if not assignedArgIndices[i] then
                        local converted = ConvertFieldValueForParser(fieldInfo, arguments[i])
                        if converted ~= nil then
                            table.insert(values, converted)
                            assignedArgIndices[i] = true  -- Track that this argument was assigned
                            if self.debug then self:Debug("BuildValueDataFromMetadata: Matched arg[%d] to repeated field '%s'", i, fieldName) end
                        else
                            self:Warn("BuildValueDataFromMetadata: Failed to convert arg[%d] for repeated field '%s' (valueType='%s')",
                                i, fieldName, metadata.valueType or "unknown")
                        end
                    end
                end

                if #values > 0 then
                    valueData[fieldName] = values
                    if self.debug then self:Debug("BuildValueDataFromMetadata: Collected %d values for repeated field '%s'", #values, fieldName) end
                else
                    -- Count unassigned arguments for warning
                    local unassignedCount = 0
                    for i = 1, #arguments do
                        if not assignedArgIndices[i] then
                            unassignedCount = unassignedCount + 1
                        end
                    end
                    self:Warn("BuildValueDataFromMetadata: No values collected for repeated field '%s' from %d unassigned arguments (valueType='%s')",
                        fieldName, unassignedCount, metadata.valueType or "unknown")
                end
            end
        end
    end

    -- Warn about unmatched arguments (AFTER repeated fields are processed)
    -- This helps identify when field_order doesn't match the actual argument order
    -- NOTE: Repeated fields consume all remaining args, so only non-repeated field mismatches will warn
    if #arguments > 0 then
        local unmatchedArgs = {}
        for i = 1, #arguments do
            if not assignedArgIndices[i] then
                local extracted = ExtractProtoValue(arguments[i])
                if extracted ~= nil then
                    table.insert(unmatchedArgs, {index = i, extracted = extracted, type = type(extracted)})
                end
            end
        end

        if #unmatchedArgs > 0 then
            -- Log field_order for debugging
            local fieldOrderStr = table.concat(fieldOrder, ", ")
            local unmatchedStr = table.concat((function()
                local parts = {}
                for _, argInfo in ipairs(unmatchedArgs) do
                    table.insert(parts, string.format("arg[%d]=%s (%s)", argInfo.index, tostring(argInfo.extracted), argInfo.type))
                end
                return parts
            end)(), ", ")
            self:Warn("BuildValueDataFromMetadata: No match found for %d argument(s) (valueType='%s', field_order=[%s]). " ..
                "This may indicate field_order doesn't match the actual argument order. " ..
                "Unmatched args: %s",
                #unmatchedArgs,
                metadata.valueType or "unknown",
                fieldOrderStr,
                unmatchedStr)
        end
    end

    if not valueData then
        self:Warn("BuildValueDataFromMetadata: Failed to build valueData from %d arguments", #parsedArgs)
    end

    return valueData
end

--- Build action data from metadata and parsed arguments
--- @param functionName string The function name (e.g., "Cast", "SelectRotation")
--- @param arguments table Array of parsed arguments
--- @param metadata table Schema metadata with messageSchema
--- @return table|nil Action data structure
function NAGStringParser:BuildActionDataFromMetadata(functionName, arguments, metadata)

    if not metadata or not metadata.messageSchema then
        self:Warn("BuildActionDataFromMetadata: Invalid metadata for functionName='%s' (metadata=%s, messageSchema=%s) - cannot build action data",
            functionName or "nil",
            metadata and "present" or "nil",
            metadata and metadata.messageSchema and "present" or "nil")
        self:Error("BuildActionDataFromMetadata: Invalid metadata for functionName='%s' (metadata=%s, messageSchema=%s)",
            functionName or "nil",
            metadata and "present" or "nil",
            metadata and metadata.messageSchema and "present" or "nil")
        return nil
    end

    local schema = metadata.messageSchema
    local fieldOrder = schema.field_order or {}
    local fields = schema.fields or {}
    arguments = arguments or {}
    local actionData = {}
    local argIndex = 1

    if #arguments > 0 then
        for i, arg in ipairs(arguments) do
            local extracted = ExtractProtoValue(arg)
            local argType = type(arg)
            if argType == "table" then
                local keys = {}
                for k in pairs(arg) do
                    table.insert(keys, tostring(k))
                end
                if self.debug then self:Debug("BuildActionDataFromMetadata:  ARG[%d]: type=%s, extracted=%s, keys=%s", i, argType, tostring(extracted), table.concat(keys, ", ")) end
            else
                if self.debug then self:Debug("BuildActionDataFromMetadata:  ARG[%d]: type=%s, extracted=%s", i, argType, tostring(extracted)) end
            end
        end
    end
    if self.debug then self:Debug("BuildActionDataFromMetadata: Field order: %s", table.concat(fieldOrder, ", ")) end

    -- Process ALL fields in field_order positionally (both required and optional)
    -- This respects the modified field_order from SchemaModifications
    -- Type-based matching is only used as a fallback for unmatched arguments

    local assignedFields = {}  -- Track which fields have been assigned
    local assignedArgIndices = {}  -- Track which argument indices were assigned

    -- Phase 1: Process all non-repeated fields in field_order order positionally
    for _, fieldName in ipairs(fieldOrder) do
        local fieldInfo = fields[fieldName]
        if fieldInfo and fieldInfo.label ~= "repeated" and not assignedFields[fieldName] then
            -- DEBUG: Special logging for SelectRotation rotation_name field
            local isSelectRotationField = (functionName == "SelectRotation" and fieldName == "rotation_name")

            local value = nil

            -- Try to get value from current argument position
            if argIndex <= #arguments then
                local testValue = arguments[argIndex]
                local extracted = ExtractProtoValue(testValue)

                if isSelectRotationField then
                    if self.debug then self:Debug("BuildActionDataFromMetadata: SelectRotation DEBUG - Processing rotation_name field") end
                    if self.debug then self:Debug("BuildActionDataFromMetadata: SelectRotation DEBUG - testValue: %s",
                        type(testValue) == "table" and TableUtils.ToString(testValue, 2) or tostring(testValue)) end
                    if self.debug then self:Debug("BuildActionDataFromMetadata: SelectRotation DEBUG - extracted: %s (type=%s)",
                        tostring(extracted), type(extracted)) end
                    if self.debug then self:Debug("BuildActionDataFromMetadata: SelectRotation DEBUG - fieldInfo: type=%s, label=%s",
                        fieldInfo.type or "nil", fieldInfo.label or "nil") end
                end

                if self.debug then self:Debug("BuildActionDataFromMetadata: Testing field '%s' (type=%s, message_type=%s, label=%s) with arg[%d] (extracted=%s, type=%s)",
                    fieldName, fieldInfo.type or "nil", fieldInfo.message_type or "nil", fieldInfo.label or "nil", argIndex, tostring(extracted), type(extracted)) end

                -- If extracted is nil and field is optional, skip to next field without consuming the argument
                if extracted == nil and fieldInfo.label == "optional" then
                    -- Continue to next field - don't increment argIndex
                else
                    local testConverted = ConvertFieldValueForParser(fieldInfo, testValue)

                    if isSelectRotationField then
                        if self.debug then self:Debug("BuildActionDataFromMetadata: SelectRotation DEBUG - testConverted: %s (type=%s)",
                            tostring(testConverted), type(testConverted)) end
                    end

                    if testConverted ~= nil then
                        -- Conversion succeeded, use this argument
                        local isPreservedIdentifier = (type(testConverted) == "string" and type(testValue) == "table" and testValue.isIdentifier == true)
                        if isPreservedIdentifier then
                            if self.debug then self:Debug("BuildActionDataFromMetadata: Conversion succeeded for field '%s' -> preserved identifier reference (unresolved): '%s'", fieldName, tostring(testConverted)) end
                        else
                            -- Conversion succeeded
                        end
                        value = testValue
                        assignedFields[fieldName] = true
                        assignedArgIndices[argIndex] = true  -- Track that this argument was assigned
                        argIndex = argIndex + 1

                        if isSelectRotationField then
                            if self.debug then self:Debug("BuildActionDataFromMetadata: SelectRotation DEBUG - Successfully mapped argument to rotation_name, value=%s",
                                type(value) == "table" and TableUtils.ToString(value, 2) or tostring(value)) end
                        end
                    else
                        -- Conversion failed
                        if fieldInfo.label == "required" then
                            self:Warn("BuildActionDataFromMetadata: Conversion failed for required field '%s' with arg[%d] (extracted=%s, type=%s, functionName='%s')",
                                fieldName, argIndex, tostring(extracted), type(extracted), functionName or "unknown")
                            if isSelectRotationField then
                                self:Warn("BuildActionDataFromMetadata: SelectRotation DEBUG - Conversion FAILED for rotation_name field!")
                            end
                        end
                        -- Don't increment argIndex - let next field try this argument
                    end
                end
            else
                -- No argument available at this position
                if fieldInfo.label == "required" then
                    self:Warn("BuildActionDataFromMetadata: No argument available at argIndex=%d (total args=%d) for required field '%s' (functionName='%s')",
                        argIndex, #arguments, fieldName, functionName or "unknown")
                    if isSelectRotationField then
                        self:Warn("BuildActionDataFromMetadata: SelectRotation DEBUG - No argument available at argIndex=%d (total args=%d) for required field '%s'", argIndex, #arguments, fieldName)
                    end
                else
                end
            end

            -- Store the value if conversion succeeded
            if value ~= nil then
                local converted = ConvertFieldValueForParser(fieldInfo, value)
                if converted ~= nil then
                    -- DEBUG: Log what we're storing, especially for options field
                    if fieldName == "options" then
                        self:Warn("BuildActionDataFromMetadata: Storing 'options' field - converted type=%s, keys=%s",
                            type(converted), type(converted) == "table" and table.concat(TableUtils.Keys(converted or {}), ", ") or "N/A")
                        if type(converted) == "table" then
                            for k, v in pairs(converted) do
                                if self.debug then self:Debug("BuildActionDataFromMetadata: options[%s] = %s (type=%s)", k, tostring(v), type(v)) end
                            end
                        end
                    end
                    actionData[fieldName] = converted
                    if self.debug then self:Debug("BuildActionDataFromMetadata: Stored field '%s' in actionData (type=%s)", fieldName, type(converted)) end
                end
            end
        end
    end

    -- Phase 2: Type-based matching fallback for unmatched arguments
    -- Collect remaining unassigned arguments that weren't matched positionally
    local remainingArgs = {}
    for i = 1, #arguments do
        if not assignedArgIndices[i] then
            local extracted = ExtractProtoValue(arguments[i])
            if extracted ~= nil then  -- Skip nil arguments
                table.insert(remainingArgs, {index = i, value = arguments[i]})
            end
        end
    end

    -- Collect unassigned optional fields for type-based matching
    local unassignedOptionalFields = {}
    for _, fieldName in ipairs(fieldOrder) do
        local fieldInfo = fields[fieldName]
        if fieldInfo and fieldInfo.label == "optional" and fieldInfo.label ~= "repeated" and not assignedFields[fieldName] then
            table.insert(unassignedOptionalFields, fieldName)
        end
    end

    -- Try to match unmatched arguments to unassigned optional fields by type (fallback only)
    if #remainingArgs > 0 and #unassignedOptionalFields > 0 then
        for _, argInfo in ipairs(remainingArgs) do
            local argValue = argInfo.value
            local extracted = ExtractProtoValue(argValue)

            -- Try to find matching optional field using type-based matching
            local matchedField = FindMatchingOptionalField(argValue, extracted, unassignedOptionalFields, fields, fieldOrder, assignedFields, ConvertFieldValueForParser)

            if matchedField then
                local fieldInfo = fields[matchedField]
                if fieldInfo then
                    local testConverted = ConvertFieldValueForParser(fieldInfo, argValue)
                    if testConverted ~= nil then
                        actionData[matchedField] = testConverted
                        assignedFields[matchedField] = true
                        assignedArgIndices[argInfo.index] = true
                        if self.debug then self:Debug("BuildActionDataFromMetadata: Type-based fallback match - arg[%d] matched to field '%s' (type=%s)",
                            argInfo.index, matchedField, fieldInfo.type or "nil") end
                    end
                end
            end
        end
    end

    -- Process all fields to handle repeated fields and ensure all assigned values are stored
    -- Also handle fields that were set from legacy AST but not yet stored in actionData
    for _, fieldName in ipairs(fieldOrder) do
        local fieldInfo = fields[fieldName]
        if fieldInfo then
            -- Handle repeated fields (consume all remaining unassigned arguments)
            if fieldInfo.label == "repeated" then
                local values = {}
                -- Collect all remaining arguments that weren't assigned to optional fields
                for i = argIndex, #arguments do
                    -- Only collect arguments that weren't assigned to optional fields
                    if not assignedArgIndices[i] then
                        local argValue = arguments[i]
                        local extracted = ExtractProtoValue(argValue)
                        if self.debug then self:Debug("BuildActionDataFromMetadata: Processing repeated field '%s' for arg[%d]: type=%s, extracted=%s, message_type=%s",
                            fieldName, i, type(argValue), tostring(extracted), fieldInfo.message_type or "nil") end
                        local converted = ConvertFieldValueForParser(fieldInfo, argValue)
                        if converted ~= nil then
                            local convertedType = type(converted)
                            local convertedKeys = {}
                            if convertedType == "table" then
                                for k in pairs(converted) do
                                    table.insert(convertedKeys, tostring(k))
                                end
                            end
                            if self.debug then self:Debug("BuildActionDataFromMetadata: Repeated field '%s' converted arg[%d]: type=%s, keys=[%s]",
                                fieldName, i, convertedType, table.concat(convertedKeys, ", ")) end
                            table.insert(values, converted)
                            assignedArgIndices[i] = true  -- Mark as assigned
                            if self.debug then self:Debug("BuildActionDataFromMetadata: Repeated field '%s' collected arg[%d]", fieldName, i) end
                        else
                            if self.debug then self:Debug("BuildActionDataFromMetadata: Repeated field '%s' failed to convert arg[%d] (extracted=%s, type=%s)",
                                fieldName, i, tostring(extracted), type(extracted)) end
                        end
                    end
                end

                if #values > 0 then
                    actionData[fieldName] = values
                    if self.debug then self:Debug("BuildActionDataFromMetadata: Repeated field '%s' collected %d values", fieldName, #values) end
                    -- Debug: Log the structure of collected values
                    for idx, val in ipairs(values) do
                        local valType = type(val)
                        local valKeys = {}
                        if valType == "table" then
                            for k in pairs(val) do
                                table.insert(valKeys, tostring(k))
                            end
                            if self.debug then self:Debug("BuildActionDataFromMetadata: Repeated field '%s' value[%d]: type=%s, keys=[%s]",
                                fieldName, idx, valType, table.concat(valKeys, ", ")) end
                        else
                            if self.debug then self:Debug("BuildActionDataFromMetadata: Repeated field '%s' value[%d]: type=%s, value=%s",
                                fieldName, idx, valType, tostring(val)) end
                        end
                    end
                end
            end
        end
    end

    -- Warn about unmatched arguments (after repeated-field processing so args consumed by repeated fields are not warned)
    for i = 1, #arguments do
        if not assignedArgIndices[i] then
            local extracted = ExtractProtoValue(arguments[i])
            if extracted ~= nil then
                self:Warn("BuildActionDataFromMetadata: No match found for arg[%d] (extracted=%s, type=%s) - argument may be ignored",
                    i, tostring(extracted), type(extracted))
            end
        end
    end

    -- CRITICAL: Verify we're returning actionData (table with field names), not a wrapper structure
    -- actionData should have schema field names (snake_case), NOT wrapper fields (type, functionName, arguments)
    if actionData and actionData.type == "action" then
        self:Error("[NAGStringParser] BuildActionDataFromMetadata: CRITICAL BUG - returning wrapper structure instead of actionData! This will create legacy nodes!")
        return nil
    end
    if actionData and actionData.functionName then
        self:Error("[NAGStringParser] BuildActionDataFromMetadata: CRITICAL BUG - actionData contains functionName (wrapper field)! This will create legacy nodes!")
        return nil
    end

    if not actionData then
        self:Warn("BuildActionDataFromMetadata: Failed to build actionData for functionName='%s' from %d arguments",
            functionName or "nil", arguments and #arguments or 0)
    else
        -- DEBUG: Check for font_color at wrong level (for OverlayText)
        if functionName == "OverlayText" or functionName == "overlay_text" then
            self:Warn("BuildActionDataFromMetadata: OverlayText DEBUG - Final actionData keys: %s",
                table.concat(TableUtils.Keys(actionData), ", "))
            if actionData.font_color then
                self:Error("BuildActionDataFromMetadata: CRITICAL - font_color found at action level! Should only be in options!")
                self:Warn("BuildActionDataFromMetadata: actionData.font_color = %s", TableUtils.ToString(actionData.font_color, 1))
            end
            if actionData.options then
                if self.debug then self:Debug("BuildActionDataFromMetadata: actionData.options keys: %s",
                    table.concat(TableUtils.Keys(actionData.options or {}), ", ")) end
                if actionData.options.font_color then
                    if self.debug then self:Debug("BuildActionDataFromMetadata: ✓ font_color correctly inside options") end
                else
                    self:Warn("BuildActionDataFromMetadata: ✗ font_color NOT found inside options!")
                end
            end
        end
    end

    return actionData
end

-- ~~~~~~~~~~ UTILITY FUNCTIONS ~~~~~~~~~~

--- Convert PascalCase to snake_case (uses SchemaUtils for consistency)
--- @param str string The PascalCase string
--- @return string The snake_case version
function NAGStringParser:PascalToSnake(str)
    if not str then return "" end

    -- Use SchemaUtils for consistent conversion (handles acronyms properly)
    local SchemaUtils = NAG:GetModule("SchemaUtils")
    local converted = SchemaUtils and SchemaUtils:PascalToSnake(str) or nil
    if converted then
        return converted
    end

    converted = SchemaUtils and SchemaUtils:CamelToSnake(str) or nil
    if converted then
        return converted
    end

    -- Fallback if SchemaUtils cannot convert (unexpected)
    local result = str:gsub("(%u+)(%u%l)", "%1_%2")
    result = result:gsub("(%l)(%u)", "%1_%2")
    return result:lower()
end

--- Convert snake_case to PascalCase (uses SchemaUtils for consistency)
--- @param str string The snake_case string
--- @return string The PascalCase version
function NAGStringParser:SnakeToPascal(str)
    if not str then return "" end

    -- Use SchemaUtils for consistent conversion (handles acronyms properly)
    local SchemaUtils = NAG:GetModule("SchemaUtils")
    local converted = SchemaUtils and SchemaUtils:SnakeToPascal(str) or nil
    if converted then
        return converted
    end

    -- Fallback if SchemaUtils cannot convert (unexpected)
    local result = str:gsub("_(%w)", function(c) return c:upper() end)
    return result:gsub("^%l", string.upper)
end

--- Parse comparison into APL-compatible cmp node
--- @param left string Left side expression
--- @param op string Operator (>=, <=, ==, ~=, !=, >, <)
--- @param right string Right side expression
--- @return table APL cmp node
function NAGStringParser:ParseComparison(left, op, right)
    local opMap = {
        [">"] = "OpGt",
        ["<"] = "OpLt",
        [">="] = "OpGe",
        ["<="] = "OpLe",
        ["=="] = "OpEq",
        ["~="] = "OpNe",
        ["!="] = "OpNe"  -- Support both ~= and != for not-equal
    }

    return {
        cmp = {
            op = opMap[op] or "OpEq",
            lhs = self:ParseValue(left),
            rhs = self:ParseValue(right)
        }
    }
end

--- Parse function call into APL node format
--- Handles both NAG:FunctionName() and FunctionName() formats
--- @param funcStr string Function call string
--- @return table APL node
function NAGStringParser:ParseFunctionCallAPL(funcStr)
    -- Try to match NAG:FunctionName(args) format first
    local nagPrefix, funcName, argsStr = funcStr:match("^(NAG:)([%w_]+)%((.*)%)$")

    if not nagPrefix then
        -- Try simple FunctionName(args) format
        funcName, argsStr = funcStr:match("^([%w_]+)%((.*)%)$")
    end

    if not funcName then
        -- Not a function call - return as constant
        return self:ParseConstant(funcStr)
    end

    -- Convert PascalCase to snake_case for APL format
    local snakeName = self:PascalToSnake(funcName)

    -- Parse arguments
    local args = self:ParseArguments(argsStr)

    -- Build APL node: { function_name = { arg1 = ..., arg2 = ... } }
    local node = {}
    node[snakeName] = args

    return node
end

--- Parse function arguments into table (handles both positional and named)
--- @param argsStr string The arguments string
--- @return table Arguments table
function NAGStringParser:ParseArguments(argsStr)
    if not argsStr or argsStr == "" then
        return {}
    end

    local args = {}
    local argList = self:SplitArguments(argsStr)

    for i, arg in ipairs(argList) do
        -- Check for named argument: key=value
        local key, value = arg:match("^(%w+)%s*=%s*(.+)$")
        if key and value then
            -- Named argument
            args[key] = self:ParseValue(value)
        else
            -- Positional argument - store with numeric index
            args[i] = self:ParseValue(arg)
        end
    end

    return args
end

--- Split arguments respecting parentheses and quotes
--- @param argsStr string The arguments string
--- @return table Array of argument strings
function NAGStringParser:SplitArguments(argsStr)
    local args = {}
    local current = ""
    local parenDepth = 0
    local braceDepth = 0  -- Track curly braces for tables
    local inString = false
    local stringQuote = nil

    for i = 1, #argsStr do
        local ch = argsStr:sub(i, i)

        if not inString then
            if ch == '"' or ch == "'" then
                inString = true
                stringQuote = ch
                current = current .. ch  -- Add opening quote to buffer
            elseif ch == "(" then
                parenDepth = parenDepth + 1
                current = current .. ch
            elseif ch == ")" then
                parenDepth = parenDepth - 1
                current = current .. ch
            elseif ch == "{" then
                braceDepth = braceDepth + 1
                current = current .. ch
            elseif ch == "}" then
                braceDepth = braceDepth - 1
                current = current .. ch
            elseif ch == "," and parenDepth == 0 and braceDepth == 0 then
                -- Argument separator at top level (no nested parens or braces)
                local trimmed = current:match("^%s*(.-)%s*$")
                if trimmed and trimmed ~= "" then
                    table.insert(args, trimmed)
                end
                current = ""
            else
                current = current .. ch
            end
        else
            -- Inside string - add all characters including closing quote
            current = current .. ch
            if ch == stringQuote then
                inString = false
                stringQuote = nil
            end
        end
    end

    -- Add final argument
    local trimmed = current:match("^%s*(.-)%s*$")
    if trimmed and trimmed ~= "" then
        table.insert(args, trimmed)
    end

    return args
end

--- Parse constant value (number or string)
--- @param valueStr string The value string
--- @return table APL const node
function NAGStringParser:ParseConstant(valueStr)
    if not valueStr or valueStr == "" then
        return { const = { val = "" } }
    end

    -- Remove quotes if present
    local unquoted = valueStr:match('^"(.*)"$') or valueStr:match("^'(.*)'$") or valueStr

    -- Try to parse as number
    local num = tonumber(unquoted)
    if num then
        return { const = { val = num } }
    end

    -- Return as string constant
    return { const = { val = unquoted } }
end

--- Converts the AST back to a readable string format
--- @param ast table The AST to convert
--- @param indent number The indentation level
--- @return string The formatted string representation
function NAGStringParser:ASTToString(ast, indent)
    indent = indent or 0
    local indentStr = string.rep("  ", indent)

    if not ast then return "nil" end

    local ASTCore = ns.ASTCore
    local ASTValue = ns.ASTValue
    local ASTAction = ns.ASTAction
    local ASTSchemaEmitter = ns.ASTSchemaEmitter

    -- Proto AST rotation
    if ast.type == "rotation" then
        local result = indentStr .. "Rotation:\n"
        if ast.priority_list then
            local ASTAction = ns.ASTAction
            for i, listItem in ipairs(ast.priority_list) do
                result = result .. indentStr .. string.format("  Priority Item %d:\n", i)
                -- CRITICAL: In proto AST, condition is on actionNode.condition, NOT listItem.condition
                local conditionNode = nil
                if listItem.action and ASTAction and ASTAction.GetCondition then
                    conditionNode = ASTAction.GetCondition(listItem.action)
                end
                -- Note: listItem.condition is legacy field - condition is on actionNode.condition in proto AST
                -- Error logging removed - legacy field access should not occur
                if conditionNode then
                    result = result .. indentStr .. "    Condition:\n"
                    result = result .. self:ASTToString(conditionNode, indent + 3)
                end
                if listItem.action then
                    result = result .. indentStr .. "    Action:\n"
                    result = result .. self:ASTToString(listItem.action, indent + 3)
                end
            end
        end
        return result
    end

    -- Proto AST nodes
    if ast.type == ASTCore.NodeType.ACTION then
        local actionType = ASTAction.GetActionType(ast) or "unknown"
        local actionText = ASTSchemaEmitter and ASTSchemaEmitter.EmitActionNode(ast) or actionType
        return indentStr .. string.format("Action (%s): %s\n", actionType, actionText)
    elseif ast.type == ASTCore.NodeType.VALUE then
        local valueType = ASTValue.GetValueType(ast)
        local valueData = ASTValue.GetValueData(ast) or {}

        if ASTValue.IsLogicalOp(ast) then
            local opName = (valueType == ASTValue.ValueType.AND and "AND") or
                          (valueType == ASTValue.ValueType.OR and "OR") or
                          (valueType == ASTValue.ValueType.NOT and "NOT") or "UNKNOWN"
            local result = indentStr .. string.format("Logical %s:\n", opName)
            local children = {}
            if valueType == ASTValue.ValueType.NOT then
                if valueData.val then
                    children = { valueData.val }
                end
            else
                children = valueData.vals or {}
            end
            for _, child in ipairs(children) do
                result = result .. self:ASTToString(child, indent + 1)
            end
            return result
        elseif ASTValue.IsComparison(ast) then
            local op = valueData.op or "?"
            local lhs = valueData.lhs and self:ASTToString(valueData.lhs, 0) or "Unknown"
            local rhs = valueData.rhs and self:ASTToString(valueData.rhs, 0) or "Unknown"
            return indentStr .. string.format("Comparison: %s %s %s\n", lhs, op, rhs)
        elseif ASTValue.IsMathOp(ast) then
            local op = valueData.op or "?"
            local result = indentStr .. string.format("Math %s:\n", op)
            if valueData.lhs then
                result = result .. indentStr .. "  LHS:\n" .. self:ASTToString(valueData.lhs, indent + 2)
            end
            if valueData.rhs then
                result = result .. indentStr .. "  RHS:\n" .. self:ASTToString(valueData.rhs, indent + 2)
            end
            return result
        elseif ASTValue.IsConst(ast) then
            local constValue = ASTValue.GetConstValue(ast)
            return indentStr .. string.format("Constant: %s\n", tostring(constValue))
        elseif valueType then
            -- Function call value node
            local valueText = ASTSchemaEmitter and ASTSchemaEmitter.EmitValueNode(ast) or valueType
            return indentStr .. string.format("Value Function (%s): %s\n", valueType, valueText)
        else
            return indentStr .. string.format("Unknown VALUE node\n")
        end
    end

    -- Legacy clause format nodes - log error
    if ast.type == "clause" or ast.type == "cast" or ast.type == "channel" or
       ast.type == "wait" or ast.type == "sequence" or ast.type == "logical" or
       ast.type == "comparison" or ast.type == "function" or ast.type == "constant" or
       ast.type == "math" then
        self:Error(format("[NAGStringParser] ASTToString: Legacy clause format node detected: type='%s' - should be proto AST", tostring(ast.type)))
        -- Fail fast: return error message instead of attempting to process legacy format
        return indentStr .. string.format("[ERROR: Legacy format node type='%s']\n", tostring(ast.type))
    end

    return indentStr .. string.format("Unknown type '%s'\n", tostring(ast.type))
end

--- Gets a simplified tree structure for UI display
--- @param ast table The AST to convert (proto AST)
--- @return table|nil The tree structure for AceGUI Tree widget
function NAGStringParser:GetTreeStructure(ast)
    if not ast then return {} end

    local ASTCore = ns.ASTCore
    local ASTValue = ns.ASTValue
    local ASTAction = ns.ASTAction

    local function nodeToTree(node, path)
        if not node then return nil end

        local treeNode = {
            value = table.concat(path, "."),
            text = self:GetNodeDisplayText(node),
            children = {}
        }

        -- Proto AST rotation
        if node.type == "rotation" then
            if node.priority_list then
                local ASTAction = ns.ASTAction
                for i, listItem in ipairs(node.priority_list) do
                    local newPath = {}
                    for j = 1, #path do newPath[j] = path[j] end
                    newPath[#newPath + 1] = "item" .. i
                    local itemNode = {
                        value = table.concat(newPath, "."),
                        text = string.format("Priority Item %d", i),
                        children = {}
                    }
                    -- CRITICAL: In proto AST, condition is on actionNode.condition, NOT listItem.condition
                    local conditionNode = nil
                    if listItem.action and ASTAction and ASTAction.GetCondition then
                        conditionNode = ASTAction.GetCondition(listItem.action)
                    end
                    -- Note: listItem.condition is legacy field - condition is on actionNode.condition in proto AST
                    -- Error logging removed - legacy field access should not occur
                    if conditionNode then
                        local condPath = {}
                        for j = 1, #newPath do condPath[j] = newPath[j] end
                        condPath[#condPath + 1] = "condition"
                        local conditionChild = nodeToTree(conditionNode, condPath)
                        if conditionChild then
                            table.insert(itemNode.children, conditionChild)
                        end
                    end
                    if listItem.action then
                        local actionPath = {}
                        for j = 1, #newPath do actionPath[j] = newPath[j] end
                        actionPath[#actionPath + 1] = "action"
                        local actionChild = nodeToTree(listItem.action, actionPath)
                        if actionChild then
                            table.insert(itemNode.children, actionChild)
                        end
                    end
                    table.insert(treeNode.children, itemNode)
                end
            end
        elseif node.type == ASTCore.NodeType.ACTION then
            -- Proto AST action node - no children to traverse
        elseif node.type == ASTCore.NodeType.VALUE then
            local valueType = ASTValue.GetValueType(node)
            local valueData = ASTValue.GetValueData(node) or {}

            if ASTValue.IsLogicalOp(node) then
                local children = {}
                if valueType == ASTValue.ValueType.NOT then
                    if valueData.val then
                        children = { valueData.val }
                    end
                else
                    children = valueData.vals or {}
                end
                for i, child in ipairs(children) do
                    local newPath = {}
                    for j = 1, #path do newPath[j] = path[j] end
                    newPath[#newPath + 1] = "child" .. i
                    local childNode = nodeToTree(child, newPath)
                    if childNode then
                        table.insert(treeNode.children, childNode)
                    end
                end
            elseif ASTValue.IsComparison(node) or ASTValue.IsMathOp(node) then
                if valueData.lhs then
                    local newPath = {}
                    for j = 1, #path do newPath[j] = path[j] end
                    newPath[#newPath + 1] = "lhs"
                    local lhsChild = nodeToTree(valueData.lhs, newPath)
                    if lhsChild then
                        table.insert(treeNode.children, lhsChild)
                    end
                end
                if valueData.rhs then
                    local newPath = {}
                    for j = 1, #path do newPath[j] = path[j] end
                    newPath[#newPath + 1] = "rhs"
                    local rhsChild = nodeToTree(valueData.rhs, newPath)
                    if rhsChild then
                        table.insert(treeNode.children, rhsChild)
                    end
                end
            end
        elseif node.type == "clause" or node.type == "logical" then
            -- Legacy clause format - log error and fail fast
            module:Error(format("[NAGStringParser] GetTreeStructure: Legacy clause format node detected: type='%s' - should be proto AST", tostring(node.type)))
            -- Fail fast: return error node instead of attempting to process legacy format
            treeNode.text = format("[ERROR: Legacy format type='%s']", tostring(node.type))
        end

        return treeNode
    end

    return nodeToTree(ast, { "root" })
end

--- Gets display text for a node (proto AST)
--- @param node table The AST node
--- @return string The display text
function NAGStringParser:GetNodeDisplayText(node)
    if not node then return "Unknown" end

    local ASTCore = ns.ASTCore
    local ASTValue = ns.ASTValue
    local ASTAction = ns.ASTAction
    local ASTSchemaEmitter = ns.ASTSchemaEmitter

    -- Proto AST rotation
    if node.type == "rotation" then
        local count = 0
        if node.priority_list then
            count = #node.priority_list
        end
        return string.format("Rotation (Items: %d)", count)
    end

    -- Proto AST nodes
    if node.type == ASTCore.NodeType.ACTION then
        local actionType = ASTAction.GetActionType(node) or "unknown"
        local actionText = ASTSchemaEmitter and ASTSchemaEmitter.EmitActionNode(node) or actionType
        return string.format("Action (%s): %s", actionType, actionText)
    elseif node.type == ASTCore.NodeType.VALUE then
        local valueType = ASTValue.GetValueType(node)
        local valueData = ASTValue.GetValueData(node) or {}

        if ASTValue.IsLogicalOp(node) then
            local opName = (valueType == ASTValue.ValueType.AND and "AND") or
                          (valueType == ASTValue.ValueType.OR and "OR") or
                          (valueType == ASTValue.ValueType.NOT and "NOT") or "UNKNOWN"
            return string.format("Logical %s", opName)
        elseif ASTValue.IsComparison(node) then
            local op = valueData.op or "?"
            local lhs = valueData.lhs and self:GetNodeDisplayText(valueData.lhs) or "Unknown"
            local rhs = valueData.rhs and self:GetNodeDisplayText(valueData.rhs) or "Unknown"
            return string.format("%s %s %s", lhs, op, rhs)
        elseif ASTValue.IsMathOp(node) then
            local op = valueData.op or "?"
            local lhs = valueData.lhs and self:GetNodeDisplayText(valueData.lhs) or "Unknown"
            local rhs = valueData.rhs and self:GetNodeDisplayText(valueData.rhs) or "Unknown"
            return string.format("(%s %s %s)", lhs, op, rhs)
        elseif ASTValue.IsConst(node) then
            local constValue = ASTValue.GetConstValue(node)
            return string.format("%s", tostring(constValue))
        elseif valueType then
            -- Function call value node
            local valueText = ASTSchemaEmitter and ASTSchemaEmitter.EmitValueNode(node) or valueType
            return string.format("Value (%s): %s", valueType, valueText)
        else
            return "Unknown VALUE node"
        end
    end

    -- Legacy clause format nodes - log error
    if node.type == "clause" or node.type == "cast" or node.type == "channel" or
       node.type == "wait" or node.type == "sequence" or node.type == "logical" or
       node.type == "comparison" or node.type == "function" or node.type == "constant" or
       node.type == "math" then
        self:Error(format("[NAGStringParser] GetNodeDisplayText: Legacy clause format node detected: type='%s' - should be proto AST", tostring(node.type)))
        -- Fail fast: return error message instead of attempting to process legacy format
        return string.format("[ERROR: Legacy format type='%s']", tostring(node.type))
    end

    return string.format("Unknown (%s)", node.type or "no type")
end

-- ~~~~~~~~~~ MODULE INITIALIZATION ~~~~~~~~~~

function NAGStringParser:ModuleInitialize()
    -- Slash commands are now handled via zero-boilerplate slashCommands table

    -- Test with a simple example
    if self.debug then self:Debug("NAGStringParser: Module initialized, testing parser...") end
    if self.debug then self:Debug("NAGStringParser: Enhanced parsing enabled - handles nested actions gracefully") end
    if self.debug then self:Debug("NAGStringParser: Use /nagdebug parser test nested to run comprehensive tests") end

    local testString = [[
    (NAG:CurrentHealthPercent() < 35) and NAG:Cast(67890) or NAG:CastSpell(12345)
    ]]
    local ast, err = self:ParseRotationString(testString)
    if ast then
        local clauseCount = ast.priority_list and #ast.priority_list or 0
        if self.debug then self:Debug("NAGStringParser: Test parsing successful, " .. clauseCount .. " clauses parsed") end
    else
        if self.debug then self:Debug("NAGStringParser: Test parsing failed: " .. tostring(err)) end
    end

    RotationConversionService = RotationConversionService or NAG:GetModule("RotationConversionService")
end

--- Show the AST debug frame for interactive parsing validation
function NAGStringParser:ShowASTDebugFrame()

    -- Initialize the current input state with the default text
    self.currentInput = "NAG:CastSpell(12345) and NAG:CurrentHealthPercent() < 35 or NAG:CastSpell(67890)"
    self.suppressInputCallback = true -- Flag to suppress initial callback

    if self.debug then self:Debug("Initialized currentInput: " .. tostring(self.currentInput)) end

    if ns.DebugFrameUtil then
        if self.debug then self:Debug("Creating debug frame with DebugFrameUtil") end
        ns.DebugFrameUtil:ShowDebugFrame(self, {
            title = "NAG String Parser - AST Debug Frame",
            width = 1000,
            height = 800,
            refreshInterval = 1.0,
            autoRefresh = true,
            showTimerControls = true,

            -- Enhanced custom controls
            customControls = self:GetASTDebugControls(),

            -- Custom section type renderers
            customSectionTypes = self:GetASTDebugSectionTypes(),

            -- Enhanced sections
            sections = self:GetASTDebugSections()
        })

        -- Clear the suppression flag after frame creation
        self.suppressInputCallback = false
        if self.debug then self:Debug("Debug frame created, suppression flag cleared") end

        -- Force an initial sync to ensure the input field state is reflected
        self:ForceInputFieldSync()
    else
        self:Error("DebugFrameUtil not available")
    end
end

--- Get custom controls for AST debug frame
--- @return table Array of custom control configurations
function NAGStringParser:GetASTDebugControls()
    if self.debug then self:Debug("Creating AST debug controls, current input: " .. tostring(self.currentInput)) end

    return {
        {
            type = "multiline",
            label = "Rotation String Input",
            defaultText = "NAG:CastSpell(12345) and NAG:CurrentHealthPercent() < 35 or NAG:CastSpell(67890)",
            width = 600,
            height = 80,
            onChange = function(value)
                if self.debug then self:Debug("Input field onChange triggered with value: " .. tostring(value)) end
                if self.debug then self:Debug("Value type: " .. type(value)) end
                self:HandleInputChange(value)
            end
        },
        {
            type = "button",
            text = "Parse String",
            width = 120,
            onClick = function()
                if self.debug then self:Debug("Parse String button clicked") end
                self:ParseCurrentInput()
            end
        },
        {
            type = "button",
            text = "Clear",
            width = 80,
            onClick = function()
                if self.debug then self:Debug("Clear button clicked") end
                self:ClearInput()
            end
        },
        {
            type = "button",
            text = "Debug Input",
            width = 120,
            onClick = function()
                if self.debug then self:Debug("Debug Input button clicked") end
                self:GetInputFieldDebugInfo()
                -- Force a refresh to show debug info
                if self.debugFrame and self.debugFrame.UpdateDebugFrame then
                    self.debugFrame:UpdateDebugFrame()
                end
            end
        },
        {
            type = "button",
            text = "Check Field Text",
            width = 120,
            onClick = function()
                if self.debug then self:Debug("Check Field Text button clicked") end
                self:GetInputFieldActualText()
                -- Also force a sync to ensure state is up to date
                self:ForceInputFieldSync()
                -- Force a refresh to show debug info
                if self.debugFrame and self.debugFrame.UpdateDebugFrame then
                    self.debugFrame:UpdateDebugFrame()
                end
            end
        },
        {
            type = "button",
            text = "Test Set Text",
            width = 120,
            onClick = function()
                if self.debug then self:Debug("Test Set Text button clicked") end
                -- Test setting the input field text
                if self.debugFrame and self.debugFrame.SetInputFieldText then
                    local testText = "Test text from button click: " .. GetTime()
                    self.debugFrame:SetInputFieldText(testText)
                    if self.debug then self:Debug("Set input field text to: " .. testText) end
                    -- Force a refresh to show the change
                    self.debugFrame:UpdateDebugFrame()
                end
            end
        },
        {
            type = "button",
            text = "Force Refresh",
            width = 120,
            onClick = function()
                if self.debug then self:Debug("Force Refresh button clicked") end
                -- Force a manual refresh of the debug frame
                if self.debugFrame and self.debugFrame.UpdateDebugFrame then
                    if self.debug then self:Debug("Forcing debug frame refresh") end
                    self.debugFrame:UpdateDebugFrame()
                else
                    self:Warn("Cannot force refresh - frame or UpdateDebugFrame method not available")
                end
            end
        }
    }
end

--- Get custom section type renderers for AST debug frame
--- @return table Map of custom section types to renderer functions
function NAGStringParser:GetASTDebugSectionTypes()
    return {
        ["ast_tree"] = function(section, scroll, module)
            -- Get the data for this section (support both static data and dataFn)
            local sectionData = section.dataFn and section.dataFn(module) or section.data
            module:Debug("ast_tree renderer called with data: " .. tostring(sectionData))
            return module:RenderASTTree(sectionData, scroll)
        end,
        ["parsing_results"] = function(section, scroll, module)
            -- Get the data for this section (support both static data and dataFn)
            local sectionData = section.dataFn and section.dataFn(module) or section.data
            module:Debug("parsing_results renderer called with data: " .. tostring(sectionData))
            return module:RenderParsingResults(sectionData, scroll)
        end,
        ["clause_analysis"] = function(section, scroll, module)
            -- Get the data for this section (support both static data and dataFn)
            local sectionData = section.dataFn and section.dataFn(module) or section.data
            module:Debug("clause_analysis renderer called with data: " .. tostring(sectionData))
            return module:RenderClauseAnalysis(sectionData, scroll)
        end
    }
end

--- Get enhanced debug sections for AST debug frame
--- @return table Array of debug section configurations
function NAGStringParser:GetASTDebugSections()
    return {
        {
            header = "Input Status",
            dataFn = function()
                local lines = {}
                local currentInput = self.currentInput or "None"
                table.insert(lines, "Current Input: " .. tostring(currentInput))
                table.insert(lines, "Input Length: " .. (currentInput ~= "None" and #tostring(currentInput) or 0))
                return lines
            end
        },
        {
            header = "Debug Information",
            dataFn = function()
                local lines = {}
                table.insert(lines, "Module Current Input: " .. tostring(self.currentInput or "None"))
                table.insert(lines, "Input Type: " .. type(self.currentInput or "None"))
                table.insert(lines, "Suppress Callback: " .. tostring(self.suppressInputCallback or false))
                table.insert(lines, "Last Parsed AST: " .. (self.lastParsedAST and "Available" or "None"))
                table.insert(lines, "Debug Frame: " .. (self.debugFrame and "Available" or "None"))
                return lines
            end
        },
        {
            header = "Input Field Debug",
            dataFn = function()
                local lines = {}
                table.insert(lines, "Module Current Input: " .. tostring(self.currentInput or "None"))
                table.insert(lines, "Expected Input Field Text: " .. tostring(self.currentInput or "None"))
                table.insert(lines, "Input Field Widget: " .. (self.debugFrame and "Available" or "None"))
                table.insert(lines, "Callback Suppression: " .. tostring(self.suppressInputCallback or false))
                return lines
            end
        },
        {
            header = "Last Parsed AST",
            type = "custom",
            customType = "parsing_results",
            dataFn = function()
                return self.lastParsedAST
            end
        },
        {
            header = "AST Structure",
            type = "custom",
            customType = "ast_tree",
            dataFn = function()
                return self.lastParsedAST
            end
        },
        {
            header = "Detailed Clause Analysis",
            type = "custom",
            customType = "clause_analysis",
            dataFn = function()
                return self.lastParsedAST
            end
        },
        {
            header = "Module Status",
            dataFn = function()
                return {
                    "NAGStringParser Loaded: Yes",
                    "Parser Functions Available: ParseRotationString, ASTToString, GetTreeStructure",
                    "Current Input: " .. tostring(self.currentInput or "None"),
                    "Last Parse Success: " .. (self.lastParsedAST and "Yes" or "No")
                }
            end
        },
        {
            header = "Usage Instructions",
            dataFn = function()
                return {
                    "Step 1: Enter a rotation string in the input field above",
                    "Step 2: Click 'Parse String' to parse and analyze",
                    "Step 3: Review the AST structure and tree view",
                    "Step 4: Use results for validation or UI generation",
                    "",
                    "Testing Commands:",
                    "  /nagdebug parser test nested - Run nested action test suite",
                    "  /nagdebug parser validate all - Validate all class rotations"
                }
            end
        },
        {
            header = "Example Rotation Formats",
            dataFn = function()
                return {
                    "✓ Standard (preferred): (NAG:CurrentHealthPercent() < 35) and NAG:CastSpell(12345)",
                    "⚠ Auto-corrected: (NAG:CurrentHealthPercent() < 35 and NAG:CastSpell(12345))",
                    "✓ Complex condition: (cond1 and cond2) and NAG:CastSpell(12345)",
                    "✓ Multiple clauses: NAG:CastSpell(12345) or NAG:CastSpell(67890)",
                    "",
                    "The parser now handles nested actions gracefully!",
                    "Warnings guide contributors toward best practices."
                }
            end
        },
        {
            header = "Enhancement Info",
            dataFn = function()
                return {
                    "Enhanced Parsing: Enabled",
                    "Feature: Handles actions nested inside condition parentheses",
                    "Benefit: More forgiving for international contributors",
                    "Compatibility: 100% backward compatible",
                    "",
                    "The parser detects when NAG:CastSpell() or other actions are",
                    "incorrectly nested inside condition parentheses and",
                    "automatically finds the correct top-level separator.",
                    "",
                    "Example correction:",
                    "  Input: (condition and NAG:CastSpell(spell))",
                    "  Parsed as: (condition) and NAG:CastSpell(spell)",
                    "  Result: ⚠ Warning logged but rotation works!"
                }
            end
        }
    }
end

--- Handle input field changes
--- @param value string The new input value
function NAGStringParser:HandleInputChange(value)
    -- Skip processing if we're suppressing callbacks during initialization
    if self.suppressInputCallback then
        if self.debug then self:Debug("Skipping input change during initialization: " .. tostring(value)) end
        return
    end

    -- Ensure value is a string
    if type(value) == "table" then
        self:Warn("HandleInputChange: Received table instead of string, converting to string")
        value = tostring(value)
    elseif value == nil then
        value = ""
    end

    self.currentInput = value
    if self.debug then self:Debug("Input changed to: " .. tostring(value)) end

    -- Trigger a refresh of the debug frame if available
    -- Note: The debug frame might not be available during initial setup
    if self.debugFrame and self.debugFrame.UpdateDebugFrame then
        self.debugFrame:UpdateDebugFrame()
    end
end

--- Parse the current input and update the debug frame
function NAGStringParser:ParseCurrentInput()
    if not self.currentInput or self.currentInput == "" then
        self:Warn("No input to parse")
        return
    end

    if self.debug then self:Debug("Parsing input: " .. tostring(self.currentInput)) end

    -- Parse the input
    local ast, err = self:ParseRotationString(self.currentInput)
    if not ast then
        self:Warn("Parsing failed: " .. tostring(err))
        self.lastParsedAST = nil
    else
        self.lastParsedAST = ast
        self:Info("Parsing successful! Generated AST with " ..
        (ast.metadata and ast.metadata.clauseCount or 0) .. " clauses")
        if self.debug then self:Debug("AST data: " .. TableUtils.ToString(ast)) end
    end

    -- Trigger a refresh of the debug frame
    if self.debugFrame and self.debugFrame.UpdateDebugFrame then
        if self.debug then self:Debug("Updating debug frame after parsing") end
        self.debugFrame:UpdateDebugFrame()
    else
        self:Warn("Cannot update debug frame - frame or UpdateDebugFrame method not available")
    end
end

--- Clear the current input
function NAGStringParser:ClearInput()
    self.currentInput = ""
    self.lastParsedAST = nil

    -- Trigger a refresh of the debug frame
    if self.debugFrame and self.debugFrame.UpdateDebugFrame then
        self.debugFrame:UpdateDebugFrame()
    end
end

--- Sync the input field state with the module state
--- This method can be called to ensure the input field and module state are synchronized
function NAGStringParser:SyncInputField()
    if self.currentInput then
        if self.debug then self:Debug("Syncing input field with current input: " .. tostring(self.currentInput)) end
        -- The input field should already have this text, but we can verify
        if self.debugFrame and self.debugFrame.UpdateDebugFrame then
            self.debugFrame:UpdateDebugFrame()
        end
    end
end

--- Force an initial sync of the input field state with the module's current input
--- This is useful when the module is initialized and the input field already has a value.
function NAGStringParser:ForceInputFieldSync()
    if self.currentInput then
        if self.debug then self:Debug("Forcing input field sync with current input: " .. tostring(self.currentInput)) end

        -- Try to get the actual text from the input field
        if self.debugFrame and self.debugFrame.GetInputFieldText then
            local actualText = self.debugFrame:GetInputFieldText()
            if self.debug then self:Debug("Input field actual text: " .. tostring(actualText)) end

            -- If the input field has different text than expected, update the module state
            if actualText and actualText ~= self.currentInput then
                if self.debug then self:Debug("Input field text differs from module state, updating module state") end
                self.currentInput = actualText
            end
        end

        -- Force a refresh to show the updated state
        if self.debugFrame and self.debugFrame.UpdateDebugFrame then
            self.debugFrame:UpdateDebugFrame()
        end
    end
end

--- Get the actual text from the input field widget if available
--- This helps debug the connection between the input field and module state
function NAGStringParser:GetInputFieldActualText()
    -- Try to find the input field widget in the debug frame
    if self.debugFrame and self.debugFrame.GetInputFieldText then
        local actualText = self.debugFrame:GetInputFieldText()
        if self.debug then self:Debug("Input field actual text: " .. tostring(actualText)) end
        return actualText
    else
        if self.debug then self:Debug("Cannot get input field text - debug frame or method not available") end
        return nil
    end
end

--- Get the current input field value for debugging
--- This method helps troubleshoot input field connection issues
function NAGStringParser:GetInputFieldDebugInfo()
    local debugInfo = {
        moduleCurrentInput = self.currentInput,
        moduleCurrentInputType = type(self.currentInput),
        suppressInputCallback = self.suppressInputCallback,
        lastParsedAST = self.lastParsedAST ~= nil,
        debugFrameAvailable = self.debugFrame ~= nil
    }

    if self.debug then self:Debug("Input field debug info: " .. TableUtils.ToString(debugInfo)) end
    return debugInfo
end

--- Render AST tree visualization
--- @param ast table The AST data to render
--- @param scroll table The scroll frame to add widgets to
--- @return table|nil The created widget or nil
function NAGStringParser:RenderASTTree(ast, scroll)
    if self.debug then self:Debug("RenderASTTree called with AST: " .. tostring(ast)) end

    if not ast then
        if self.debug then self:Debug("No AST provided to RenderASTTree") end
        local noDataLabel = ns.AceGUI:Create("Label")
        noDataLabel:SetText("No AST parsed yet")
        noDataLabel:SetFullWidth(true)
        scroll:AddChild(noDataLabel)
        return noDataLabel
    end

    if self.debug then self:Debug("AST has " .. (ast.priority_list and #ast.priority_list or 0) .. " clauses") end

    local treeStructure = self:GetTreeStructure(ast)
    if self.debug then self:Debug("Tree structure: " .. TableUtils.ToString(treeStructure)) end

    -- Render tree nodes recursively
    local function renderTreeNode(node, level)
        if not node then return end

        local indent = string.rep("  ", level)
        local nodeLabel = ns.AceGUI:Create("Label")
        nodeLabel:SetText(indent .. "• " .. (node.text or "Unknown"))
        nodeLabel:SetFullWidth(true)
        nodeLabel:SetFontObject(GameFontNormal)
        scroll:AddChild(nodeLabel)
        if self.debug then self:Debug("Added tree node: " .. (indent .. "• " .. (node.text or "Unknown"))) end

        -- Add children recursively
        if node.children then
            for _, child in ipairs(node.children) do
                renderTreeNode(child, level + 1)
            end
        end
    end

    -- Render the tree
    if treeStructure and treeStructure.children then
        for _, child in ipairs(treeStructure.children) do
            renderTreeNode(child, 0)
        end
    else
        local noTreeLabel = ns.AceGUI:Create("Label")
        noTreeLabel:SetText("No tree structure available")
        noTreeLabel:SetFullWidth(true)
        scroll:AddChild(noTreeLabel)
        if self.debug then self:Debug("Added 'no tree structure' label") end
        return noTreeLabel
    end

    return nil -- No single widget to return
end

--- Render parsing results
--- @param ast table The AST data to render
--- @param scroll table The scroll frame to add widgets to
--- @return table|nil The created widget or nil
function NAGStringParser:RenderParsingResults(ast, scroll)
    if self.debug then self:Debug("RenderParsingResults called with AST: " .. tostring(ast)) end

    if not ast then
        if self.debug then self:Debug("No AST provided to RenderParsingResults") end
        local noDataLabel = ns.AceGUI:Create("Label")
        noDataLabel:SetText("No AST parsed yet")
        noDataLabel:SetFullWidth(true)
        scroll:AddChild(noDataLabel)
        return noDataLabel
    end

    if self.debug then self:Debug("Rendering parsing results for AST with " .. (ast.priority_list and #ast.priority_list or 0) .. " clauses") end

    -- Show AST structure as string
    local astString = self:ASTToString(ast)
    if self.debug then self:Debug("AST string: " .. astString) end

    local astLines = {}
    for line in astString:gmatch("[^\n]+") do
        table.insert(astLines, line)
    end

    if self.debug then self:Debug("AST has " .. #astLines .. " lines to render") end

    for _, line in ipairs(astLines) do
        local lineLabel = ns.AceGUI:Create("Label")
        lineLabel:SetText(line)
        lineLabel:SetFullWidth(true)
        lineLabel:SetFontObject(GameFontNormalSmall)
        scroll:AddChild(lineLabel)
        if self.debug then self:Debug("Added AST line: " .. line) end
    end

    return nil -- No single widget to return
end

--- Render detailed clause analysis
--- @param ast table The AST data to render
--- @param scroll table The scroll frame to add widgets to
--- @return table|nil The created widget or nil
function NAGStringParser:RenderClauseAnalysis(ast, scroll)
    if self.debug then self:Debug("RenderClauseAnalysis called with AST: " .. tostring(ast)) end

    if not ast or not ast.priority_list then
        if self.debug then self:Debug("No clauses to analyze in AST") end
        local noDataLabel = ns.AceGUI:Create("Label")
        noDataLabel:SetText("No clauses to analyze")
        noDataLabel:SetFullWidth(true)
        scroll:AddChild(noDataLabel)
        return noDataLabel
    end

    if self.debug then self:Debug("Analyzing " .. #ast.priority_list .. " clauses") end

    -- Analyze each clause
    for i, listItem in ipairs(ast.priority_list) do
        if self.debug then self:Debug("Rendering clause " .. i .. ": " .. tostring(listItem)) end

        -- Clause header
        local clauseHeader = ns.AceGUI:Create("Heading")
        clauseHeader:SetText(string.format("Clause %d", i))
        clauseHeader:SetFullWidth(true)
        scroll:AddChild(clauseHeader)
        if self.debug then self:Debug("Added clause header for clause " .. i) end

        -- Clause details
        local detailsGroup = ns.AceGUI:Create("SimpleGroup")
        detailsGroup:SetLayout("Flow")
        detailsGroup:SetFullWidth(true)

        -- Priority (index in priority_list)
        local priorityLabel = ns.AceGUI:Create("Label")
        priorityLabel:SetText("Priority: " .. tostring(i))
        priorityLabel:SetWidth(150)
        detailsGroup:AddChild(priorityLabel)

        -- Type (from action if available)
        local typeLabel = ns.AceGUI:Create("Label")
        local ASTAction = ns.ASTAction
        local ASTCore = ns.ASTCore
        local actionTypeStr = "Unknown"
        if listItem.action and listItem.action.type == ASTCore.NodeType.ACTION then
            actionTypeStr = ASTAction.GetActionType(listItem.action) or "Unknown"
        end
        typeLabel:SetText("Type: " .. actionTypeStr)
        typeLabel:SetWidth(150)
        detailsGroup:AddChild(typeLabel)

        scroll:AddChild(detailsGroup)

        -- Action details
        if listItem.action then
            local actionGroup = ns.AceGUI:Create("SimpleGroup")
            actionGroup:SetLayout("Flow")
            actionGroup:SetFullWidth(true)

            local actionLabel = ns.AceGUI:Create("Label")
            local displayParts = {}
            local function addDisplayPart(value, reference)
                if value and value ~= "" and value ~= reference then
                    table.insert(displayParts, value)
                end
            end

            -- Derive function name from proto AST structure
            if listItem.action.type == ASTCore.NodeType.ACTION then
                local actionType = ASTAction.GetActionType(listItem.action)
                if actionType then
                    local SchemaUtils = ns.SchemaUtils
                    local functionName = SchemaUtils and SchemaUtils:SnakeToPascal(actionType) or actionType
                    addDisplayPart(functionName)
                end
            end

            local actionDisplay = table.concat(displayParts, " | ")
            if actionDisplay == "" then
                actionDisplay = "Unknown"
            end

            actionLabel:SetText("Action Type: " .. actionDisplay)
            actionLabel:SetWidth(200)
            actionGroup:AddChild(actionLabel)

            local actionDetailsLabel = ns.AceGUI:Create("Label")
            -- Note: originalText removed - use ASTSchemaEmitter.EmitActionNode(node) for text synthesis
            actionDetailsLabel:SetText("Details: [Use ASTSchemaEmitter for text synthesis]")
            actionDetailsLabel:SetWidth(400)
            actionGroup:AddChild(actionDetailsLabel)

            scroll:AddChild(actionGroup)
        end

        -- Condition details - use actionNode.condition in proto AST, not listItem.condition
        -- Note: listItem.condition is legacy field - removed legacy field access

        -- Add spacer between clauses
        if i < #ast.priority_list then
            local spacer = ns.AceGUI:Create("Label")
            spacer:SetText("")
            spacer:SetFullWidth(true)
            spacer:SetHeight(8)
            scroll:AddChild(spacer)
        end
    end

    return nil -- No single widget to return
end

--- Validate parser against all class rotations to ensure no breaking changes
--- Uses RotationManager's cached and validated rotations for efficiency
function NAGStringParser:ValidateAllClassRotations()
    self:Print("=== Validating Parser Against All Class Rotations ===")

    local totalRotations = 0
    local successfulParses = 0
    local failedParses = 0
    local warningCount = 0

    -- Get RotationManager to access cached rotations
    local RotationManager = NAG:GetModule("RotationManager")
    -- Get current player class
    local playerClass = UnitClassBase("player")
    self:Print(string.format("Current class: %s", playerClass))

    -- Get class module for rotation access
    local classModule = NAG:GetClassModule()
    if not classModule then
        self:Print("|cFFFF0000Class module not available|r")
        self:Print("|cFF888888Testing with known rotation patterns instead...|r")
        self:TestKnownRotationPatterns()
        return
    end

    -- Use RotationManager's cached rotation list (already validated and compiled)
    local cachedRotations = RotationManager:GetCachedRotationsList()

    if not cachedRotations or #cachedRotations == 0 then
        self:Print("|cFFFFD100No cached rotations found|r")
        self:Print("|cFF888888Note: Rotations are cached during addon load|r")
        self:Print("|cFF888888Testing with known rotation patterns instead...|r")
        self:TestKnownRotationPatterns()
        return
    end

    self:Print(string.format("\nValidating %d cached %s rotations...", #cachedRotations, playerClass))

    -- Iterate through cached rotations (already organized and validated by RotationManager)
    for _, rotationInfo in ipairs(cachedRotations) do
        local specIndex = rotationInfo.specIndex or 0  -- Support both for backward compatibility
        local rotationName = rotationInfo.name

        -- Get the actual rotation config from ClassModule
        local rotation = classModule:GetRotation(specIndex, rotationName)

        if rotation and rotation.rotationString then
            totalRotations = totalRotations + 1

            -- Capture warnings
            local hadWarning = false
            local warningMsgs = {}
            local originalWarn = self.Warn
            self.Warn = function(module, msg, ...)
                hadWarning = true
                table.insert(warningMsgs, string.format(msg, ...))
                originalWarn(module, msg, ...)
            end

            local ast, err = self:ParseRotationString(rotation.rotationString)

            -- Restore original Warn
            self.Warn = originalWarn

            if ast then
                successfulParses = successfulParses + 1
                if hadWarning then
                    warningCount = warningCount + 1
                    self:Print(string.format("  ⚠ [Spec %d] %s: Auto-corrected nested actions", specIndex, rotationName))
                    for _, warnMsg in ipairs(warningMsgs) do
                        self:Print(string.format("      %s", warnMsg))
                    end
                end
            else
                failedParses = failedParses + 1
                self:Print(string.format("  ✗ [Spec %d] %s: Parse failed", specIndex, rotationName))
                if err then
                    self:Print(string.format("      Error: %s", err))
                end
            end
        end
    end

    self:Print("")
    self:Print(string.format("=== Validation Complete ==="))
    self:Print(string.format("Total rotations tested: %d", totalRotations))
    self:Print(string.format("Successful parses: %d", successfulParses))
    self:Print(string.format("Failed parses: %d", failedParses))
    self:Print(string.format("Auto-corrected (warnings): %d", warningCount))

    if failedParses == 0 then
        self:Print("|cFF00FF00✓ All rotations parsed successfully!|r")
    else
        self:Print("|cFFFF0000⚠ Some rotations failed to parse - review errors above|r")
    end
end

--- Test known rotation patterns from recent fixes
function NAGStringParser:TestKnownRotationPatterns()
    self:Print("\n=== Testing Known Rotation Patterns ===")

    -- Import test cases from validation file
    local testCases = ns.ParserEnhancementValidation and ns.ParserEnhancementValidation.GetTestCases() or {}

    if #testCases == 0 then
        -- Fallback to inline test cases
        testCases = {
            {
                name = "Warlock Demonology - Fixed Pattern",
                original = "((NAG:AuraIsActive(103958)) and ((NAG:DotIsActive(603) and NAG:ShouldMultidot(603, 4, NAG:DotTickFrequency(603))))) and NAG:Cast(603, nil, NAG.SPELL_POSITIONS.RIGHT)",
                shouldParse = true
            },
            {
                name = "Shaman Elemental - Fixed Pattern",
                original = "(((NAG:DotRemainingTime(8050) < 2)) and ((NAG:DotIsActive(8050) and NAG:ShouldMultidot(8050, 2, 2.0)))) and NAG:Cast(8050, nil, NAG.SPELL_POSITIONS.RIGHT)",
                shouldParse = true
            },
            {
                name = "Blood DK - Conditional Action",
                original = "(NAG:IsExecutePhase(35) and NAG:CurrentRuneCount(1) >= 1) and (NAG:SnapshotPercent(55095, \"ap\") >= 0.05) and NAG:Cast(48721) or NAG:Cast(55050)",
                shouldParse = true
            }
        }
    end

    local passCount = 0
    local failCount = 0

    for i, testCase in ipairs(testCases) do
        self:Print(string.format("\n%d. %s", i, testCase.name))

        local testInput = testCase.fixed or testCase.original
        self:Print(string.format("  Input: %s", testInput:sub(1, 70) .. (testInput:len() > 70 and "..." or "")))

        local ast, err = self:ParseRotationString(testInput)

        if ast and testCase.shouldParse then
            self:Print(string.format("  ✓ PASS - Parsed successfully"))
            passCount = passCount + 1
        elseif not ast and not testCase.shouldParse then
            self:Print(string.format("  ✓ PASS - Failed as expected"))
            passCount = passCount + 1
        else
            self:Print(string.format("  ✗ FAIL"))
            if err then
                self:Print(string.format("    Error: %s", err))
            end
            failCount = failCount + 1
        end
    end

    self:Print("")
    self:Print(string.format("=== Pattern Test Results: %d passed, %d failed ===", passCount, failCount))
end

--- Test nested action handling with comprehensive test cases
function NAGStringParser:TestNestedActionHandling()
    self:Print("=== Testing Nested Action Handling Enhancement ===")

    local testCases = {
        {
            name = "Correct format (baseline) - CastSpell",
            input = "(NAG:CurrentHealthPercent() < 35) and NAG:CastSpell(12345)",
            shouldParse = true,
            expectWarning = false
        },
        {
            name = "Single-level nesting - CastSpell",
            input = "(NAG:CurrentHealthPercent() < 35 and NAG:CastSpell(12345))",
            shouldParse = true,
            expectWarning = true
        },
        {
            name = "Double-level nesting - CastSpell",
            input = "((NAG:CurrentHealthPercent() < 35 and NAG:CastSpell(12345)))",
            shouldParse = true,
            expectWarning = true
        },
        {
            name = "Complex condition with nesting - CastSpell",
            input = "(NAG:IsExecutePhase(35) and NAG:CurrentRuneCount(1) >= 1 and NAG:CastSpell(55050))",
            shouldParse = true,
            expectWarning = true
        },
        {
            name = "Multiple NAG functions in condition (edge case) - CastSpell",
            input = "(NAG:AuraIsActive(123) and NAG:IsReady(456)) and NAG:CastSpell(789)",
            shouldParse = true,
            expectWarning = false
        },
        {
            name = "Conditional action with or - CastSpell",
            input = "(NAG:SnapshotPercent(55095, \"ap\") >= 0.05) and NAG:CastSpell(48721) or NAG:CastSpell(55050)",
            shouldParse = true,
            expectWarning = false
        },
        {
            name = "Blood DK pattern - nested with conditional cast - CastSpell",
            input = "(NAG:CurrentTime() <= 3.0 and NAG:CountEnemiesInRange(8) <= 2 and (NAG:DotRemainingTime(55095) >= 6)) and (NAG:SnapshotPercent(55095, \"ap\") >= 0.05) and NAG:CastSpell(48721) or NAG:CastSpell(55050)",
            shouldParse = true,
            expectWarning = false
        },
        {
            name = "Backward compatibility - Cast alias (baseline)",
            input = "(NAG:CurrentHealthPercent() < 35) and NAG:Cast(12345)",
            shouldParse = true,
            expectWarning = false
        },
        {
            name = "Backward compatibility - Cast alias with or",
            input = "(NAG:SnapshotPercent(55095, \"ap\") >= 0.05) and NAG:Cast(48721) or NAG:CastSpell(55050)",
            shouldParse = true,
            expectWarning = false
        }
    }

    local passCount = 0
    local failCount = 0

    for i, testCase in ipairs(testCases) do
        self:Print("")
        self:Print(string.format("Test %d: %s", i, testCase.name))
        self:Print(string.format("  Input: %s", testCase.input:sub(1, 60) .. (testCase.input:len() > 60 and "..." or "")))

        -- Capture warnings and debug messages
        local hadWarning = false
        local warningMessages = {}
        local debugMessages = {}

        local originalWarn = self.Warn
        local originalDebug = self.Debug

        self.Warn = function(module, msg, ...)
            hadWarning = true
            table.insert(warningMessages, string.format(msg, ...))
            originalWarn(module, msg, ...)
        end

        self.Debug = function(module, msg, ...)
            local formatted = string.format(msg, ...)
            table.insert(debugMessages, formatted)
            -- Don't call original to reduce spam
        end

        local ast, err = self:ParseRotationString(testCase.input)

        -- Restore originals
        self.Warn = originalWarn
        self.Debug = originalDebug

        local parsedOk = (ast ~= nil)
        local warningMatch = (hadWarning == testCase.expectWarning)

        if parsedOk == testCase.shouldParse and warningMatch then
            self:Print(string.format("  ✓ PASS (parsed: %s, warning: %s)", tostring(parsedOk), tostring(hadWarning)))
            passCount = passCount + 1
        else
            self:Print(string.format("  ✗ FAIL"))
            if parsedOk ~= testCase.shouldParse then
                self:Print(string.format("    Expected parse: %s, got: %s", tostring(testCase.shouldParse), tostring(parsedOk)))
                if err then
                    self:Print(string.format("    Error: %s", err))
                end
            end
            if not warningMatch then
                self:Print(string.format("    Expected warning: %s, got: %s", tostring(testCase.expectWarning), tostring(hadWarning)))

                -- Show relevant debug messages
                self:Print("    Key debug messages:")
                for _, debugMsg in ipairs(debugMessages) do
                    if debugMsg:find("stripped") or debugMsg:find("warning") or debugMsg:find("paren level") then
                        self:Print("      " .. debugMsg)
                    end
                end

                if #warningMessages > 0 then
                    self:Print("    Warnings emitted:")
                    for _, warnMsg in ipairs(warningMessages) do
                        self:Print("      " .. warnMsg)
                    end
                else
                    self:Print("    No warnings were emitted")
                end
            end
            failCount = failCount + 1
        end

        -- Show parsed structure if successful
        if ast then
            local clauseCount = ast.priority_list and #ast.priority_list or 0
            self:Print(string.format("  Clauses parsed: %d", clauseCount))
            if ast.priority_list and ast.priority_list[1] then
                local listItem = ast.priority_list[1]
                -- Note: listItem.condition and originalText are legacy fields - removed legacy field access
                if listItem.action then
                    -- Note: originalText removed - use ASTSchemaEmitter.EmitActionNode(node) for text synthesis
                    self:Print(string.format("  Action: [Use ASTSchemaEmitter for text synthesis]"))
                end
            end
        end
    end

    self:Print("")
    self:Print(string.format("=== Test Results: %d passed, %d failed ===", passCount, failCount))
end

--- Test function for string parsing
--- @param input string The input string to test
function NAGStringParser:TestStringParsing(input)
    if not input or input == "" then
        self:Print("Usage: /nagdebug parser string <rotation_string>")
        self:Print("Example: /nagdebug parser string \"NAG:CastSpell(12345) and NAG:CurrentHealthPercent() < 35 or NAG:CastSpell(67890)\"")
        self:Print("Or test a value: /nagdebug parser string \"value:(NAG:SpellCastTime(48181) + (NAG:SpellTravelTime(48181) + 2.0))\"")
        return
    end

    self:Print("=== Testing NAG String Parser ===")
    self:Print("Input: " .. input)

    -- Check if this is a value test (starts with "value:" - handle with or without quotes)
    local trimmedInput = input:match("^%s*(.-)%s*$")
    local isValueTest = trimmedInput:match("^value:") or trimmedInput:match('^"value:') or trimmedInput:match("^'value:")
    if isValueTest then
        -- Remove "value:" prefix and any surrounding quotes
        local valueText = trimmedInput:gsub("^value:", ""):match("^%s*(.-)%s*$")
        -- Remove outer quotes if present
        if valueText:match('^".*"$') or valueText:match("^'.*'$") then
            valueText = valueText:sub(2, -2)
        end
        self:Print("Testing as VALUE (not rotation string)")
        self:Print("Value text: " .. valueText)

        local valueNode = self:ParseValue(valueText)
        if not valueNode then
            self:Print("Parsing failed: ParseValue returned nil")
            return
        end

        self:Print("Parsing successful!")
        self:Print("Value node type: " .. (valueNode.type or "nil"))
        if valueNode.value then
            for valueType, valueData in pairs(valueNode.value) do
                self:Print("  Value type: " .. valueType)
                if valueType == "math" then
                    self:Print("    Operator: " .. (valueData.op or "nil"))
                    self:Print("    LHS type: " .. (valueData.lhs and valueData.lhs.type or "nil"))
                    if valueData.lhs and valueData.lhs.value then
                        for lhsType, lhsData in pairs(valueData.lhs.value) do
                            self:Print("      LHS " .. lhsType .. ": " .. tostring(lhsData.val or lhsData))
                        end
                    end
                    self:Print("    RHS type: " .. (valueData.rhs and valueData.rhs.type or "nil"))
                    if valueData.rhs and valueData.rhs.value then
                        for rhsType, rhsData in pairs(valueData.rhs.value) do
                            self:Print("      RHS " .. rhsType .. ": " .. tostring(rhsData.val or rhsData))
                        end
                    end
                elseif valueType == "const" then
                    self:Print("    Constant value: " .. tostring(valueData.val))
                    self:Print("    ⚠ WARNING: Expression was parsed as a constant string, not as a math expression!")
                end
            end
        end
        return
    end

    local ast, err = self:ParseRotationString(input)
    if not ast then
        self:Print("Parsing failed: " .. tostring(err))
        return
    end

    self:Print("Parsing successful!")
    self:Print("AST Structure:")
    self:Print(self:ASTToString(ast))

    self:Print("Tree Structure:")
    local tree = self:GetTreeStructure(ast)
    self:Print(self:ASTToString(tree))

    -- Test the tree structure specifically
    self:Print("Tree Structure Details:")
    for i, clause in ipairs(tree.children or {}) do
        self:Print(string.format("Clause %d: %s", i, clause.text))
        if clause.children then
            for j, child in ipairs(clause.children) do
                self:Print(string.format("  Child %d: %s", j, child.text))
            end
        end
    end
end

--- Test value parsing directly (for testing math expressions, function calls, etc.)
--- @param input string The value expression to test
function NAGStringParser:TestValueParsing(input)
    if not input or input == "" then
        self:Print("Usage: /nagdebug parser value <value_expression>")
        self:Print("Example: /nagdebug parser value \"(NAG:SpellCastTime(48181) + (NAG:SpellTravelTime(48181) + 2.0))\"")
        self:Print("Example: /nagdebug parser value \"NAG:SpellCastTime(48181)\"")
        self:Print("Example: /nagdebug parser value \"A + B + C\"")
        return
    end

    self:Print("=== Testing NAG Value Parser ===")
    self:Print("Input: " .. input)

    -- Remove outer quotes if present
    local valueText = input:match("^%s*(.-)%s*$")
    if valueText:match('^".*"$') or valueText:match("^'.*'$") then
        valueText = valueText:sub(2, -2)
    end

    self:Print("Value text: " .. valueText)

    local valueNode = self:ParseValue(valueText)
    if not valueNode then
        self:Print("Parsing failed: ParseValue returned nil")
        return
    end

    self:Print("Parsing successful!")
    self:Print("Value node type: " .. (valueNode.type or "nil"))
    if valueNode.value then
        for valueType, valueData in pairs(valueNode.value) do
            self:Print("  Value type: " .. valueType)
            if valueType == "math" then
                self:Print("    ✓ Math expression parsed correctly!")
                self:Print("    Operator: " .. (valueData.op or "nil"))
                self:Print("    LHS type: " .. (valueData.lhs and valueData.lhs.type or "nil"))
                if valueData.lhs and valueData.lhs.value then
                    for lhsType, lhsData in pairs(valueData.lhs.value) do
                        if lhsType == "math" then
                            self:Print("      LHS is nested math: " .. (lhsData.op or "nil"))
                        else
                            self:Print("      LHS " .. lhsType .. ": " .. tostring(lhsData.val or lhsData))
                        end
                    end
                end
                self:Print("    RHS type: " .. (valueData.rhs and valueData.rhs.type or "nil"))
                if valueData.rhs and valueData.rhs.value then
                    for rhsType, rhsData in pairs(valueData.rhs.value) do
                        if rhsType == "math" then
                            self:Print("      RHS is nested math: " .. (rhsData.op or "nil"))
                        else
                            self:Print("      RHS " .. rhsType .. ": " .. tostring(rhsData.val or rhsData))
                        end
                    end
                end
            elseif valueType == "const" then
                self:Print("    ⚠ WARNING: Expression was parsed as a constant string, not as a math expression!")
                self:Print("    Constant value: " .. tostring(valueData.val))
                self:Print("    This indicates the math expression was not properly parsed.")
            else
                self:Print("    Data: " .. TableUtils.ToString(valueData, 2))
            end
        end
    else
        self:Print("  ⚠ WARNING: Value node has no value field!")
    end
end

