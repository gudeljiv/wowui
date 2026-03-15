--- @module "LuaFormatter"
--- Formats NAG rotation strings with proper indentation and line breaks
---
--- Provides pretty-printing for rotation strings while maintaining backward compatibility.
--- Formats complex single-line Lua expressions into readable multi-line format.
---
--- Rainbow Parenthesis Colorization:
--- - Handled by ForAllIndentsAndPurposes.lua at the EditBox display layer
--- - Matching parentheses show in the same color based on nesting depth
--- - 6 cycling colors: Red, Cyan, Orange, Mint, Yellow, Purple
--- - LuaFormatter returns CLEAN strings (no embedded color codes)
--- - Colorization happens automatically in any EditBox with ns.IndentationLib.enable()
---
--- Usage patterns:
--- - CoreModule: via ns.LuaFormatter.FunctionName()
--- - Service modules: via ns.LuaFormatter.FunctionName()
--- - Main addon: via ns.LuaFormatter.FunctionName()
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ============================ LOCALIZE ============================
local _, ns = ...

-- String operations
local strmatch = strmatch
local strsub = strsub
local strtrim = strtrim
local format = string.format
local gsub = string.gsub
local len = string.len

-- Table operations
local tinsert = tinsert
local tconcat = table.concat

-- Standard Lua functions
local type = type
local tostring = tostring
local pairs = pairs
local ipairs = ipairs
local max = math.max
local min = math.min

-- ============================ CONTENT ============================

--- LuaFormatter: Provides rotation string formatting utilities
local LuaFormatter = {}

-- ============================ DEFAULT OPTIONS ============================

--- Default formatting options
local DEFAULT_OPTIONS = {
    indentSize = 4,
    maxLineLength = 100,
    breakAtLogicalOperators = true,
    blankLineBetweenClauses = true,
    alignParentheses = true
}

-- ============================ HELPER FUNCTIONS ============================

--- Creates an indentation string
--- @param level number The indentation level
--- @param size number The number of spaces per level
--- @return string The indentation string
local function CreateIndent(level, size)
    if level <= 0 then return "" end
    local spaces = ""
    for i = 1, level * size do
        spaces = spaces .. " "
    end
    return spaces
end

--- Merges options with defaults
--- @param options table|nil User-provided options
--- @return table Merged options
local function MergeOptions(options)
    if not options then return DEFAULT_OPTIONS end

    local merged = {}
    for k, v in pairs(DEFAULT_OPTIONS) do
        merged[k] = options[k] ~= nil and options[k] or v
    end
    return merged
end

--- Checks if a string fits on one line
--- @param text string The text to check
--- @param maxLength number Maximum line length
--- @return boolean True if text fits on one line
local function FitsOneLine(text, maxLength)
    return len(text) <= maxLength
end

--- Counts the depth of nested parentheses at a position
--- @param text string The text to analyze
--- @param pos number The position to check
--- @return number The parenthesis depth
local function GetParenDepth(text, pos)
    local depth = 0
    for i = 1, pos do
        local char = strsub(text, i, i)
        if char == "(" then
            depth = depth + 1
        elseif char == ")" then
            depth = depth - 1
        end
    end
    return depth
end

-- ============================ EXPRESSION TOKENIZATION ============================

--- Tokenizes a Lua expression for formatting
--- @param expression string The expression to tokenize
--- @return table Array of tokens with type and value
local function TokenizeExpression(expression)
    if not expression or expression == "" then
        return {}
    end

    local tokens = {}
    local i = 1
    local exprLen = len(expression)

    while i <= exprLen do
        local char = strsub(expression, i, i)

        -- Skip whitespace
        if char == " " or char == "\t" or char == "\n" then
            i = i + 1
        -- Parentheses
        elseif char == "(" or char == ")" then
            tinsert(tokens, {type = "paren", value = char, pos = i})
            i = i + 1
        -- Logical operators
        elseif strsub(expression, i, i + 2) == "and" then
            -- Note: strsub(expression, 0, 0) returns empty string when i == 1, which is handled by prevChar == ""
            local prevChar = strsub(expression, i - 1, i - 1)
            local nextChar = strsub(expression, i + 3, i + 3)
            local boundaryBefore = prevChar == "" or strmatch(prevChar, "%W")
            local boundaryAfter = nextChar == "" or strmatch(nextChar, "%W")
            if boundaryBefore and boundaryAfter then
                tinsert(tokens, {type = "operator", value = "and", pos = i})
                i = i + 3
            else
                i = i + 1
            end
        elseif strsub(expression, i, i + 1) == "or" then
            -- Note: strsub(expression, 0, 0) returns empty string when i == 1, which is handled by prevChar == ""
            local prevChar = strsub(expression, i - 1, i - 1)
            local nextChar = strsub(expression, i + 2, i + 2)
            local boundaryBefore = prevChar == "" or strmatch(prevChar, "%W")
            local boundaryAfter = nextChar == "" or strmatch(nextChar, "%W")
            if boundaryBefore and boundaryAfter then
                tinsert(tokens, {type = "operator", value = "or", pos = i})
                i = i + 2
            else
                i = i + 1
            end
        elseif strsub(expression, i, i + 2) == "not" then
            -- Note: strsub(expression, 0, 0) returns empty string when i == 1, which is handled by prevChar == ""
            local prevChar = strsub(expression, i - 1, i - 1)
            local nextChar = strsub(expression, i + 3, i + 3)
            local boundaryBefore = prevChar == "" or strmatch(prevChar, "%W")
            local boundaryAfter = nextChar == "" or strmatch(nextChar, "%W")
            if boundaryBefore and boundaryAfter then
                tinsert(tokens, {type = "operator", value = "not", pos = i})
                i = i + 3
            else
                i = i + 1
            end
        else
            -- Collect other characters as text
            local start = i
            while i <= exprLen do
                local c = strsub(expression, i, i)
                if c == "(" or c == ")" or c == " " or c == "\t" or c == "\n" then
                    break
                end
                -- Check if upcoming is a keyword
                local nextChar
                if strsub(expression, i, i + 2) == "and" then
                    nextChar = strsub(expression, i + 3, i + 3)
                elseif strsub(expression, i, i + 1) == "or" then
                    nextChar = strsub(expression, i + 2, i + 2)
                elseif strsub(expression, i, i + 2) == "not" then
                    nextChar = strsub(expression, i + 3, i + 3)
                end
                if nextChar and (nextChar == "" or strmatch(nextChar, "%W")) then break end
                i = i + 1
            end

            if i > start then
                local value = strsub(expression, start, i - 1)
                tinsert(tokens, {type = "text", value = value, pos = start})
            end
        end
    end

    return tokens
end

-- ============================ EXPRESSION FORMATTING ============================

--- Formats the content of an expression (helper for FormatExpression)
--- @param expression string The expression content
--- @param indentLevel number Current indentation level
--- @param options table Formatting options
--- @return string The formatted expression content
local function FormatExpressionContent(expression, indentLevel, options)
    if not expression or expression == "" then
        return ""
    end

    local tokens = TokenizeExpression(expression)
    if #tokens == 0 then
        return expression
    end

    -- Build formatted output by processing tokens
    local lines = {}
    local currentLine = {}
    local parenDepth = 0
    local indent = CreateIndent(indentLevel, options.indentSize)

    for i, token in ipairs(tokens) do
        if token.type == "paren" then
            if token.value == "(" then
                tinsert(currentLine, token.value)
                parenDepth = parenDepth + 1
            else
                tinsert(currentLine, token.value)
                parenDepth = parenDepth - 1
            end
        elseif token.type == "operator" then
            -- Break at logical operators if at depth 0 and option enabled
            if options.breakAtLogicalOperators and parenDepth == 0 then
                -- Finish current line
                if #currentLine > 0 then
                    tinsert(lines, tconcat(currentLine, " "))
                    currentLine = {}
                end

                -- Start new line with operator
                tinsert(currentLine, token.value)
            else
                -- Keep on same line
                tinsert(currentLine, token.value)
            end
        elseif token.type == "text" then
            tinsert(currentLine, token.value)
        end
    end

    -- Add remaining line
    if #currentLine > 0 then
        tinsert(lines, tconcat(currentLine, " "))
    end

    -- Join lines with indentation
    if #lines == 0 then
        return ""
    elseif #lines == 1 then
        return lines[1]
    else
        return tconcat(lines, "\n" .. indent)
    end
end

--- Formats a Lua expression with proper indentation and line breaks
--- @param expression string The expression to format
--- @param indentLevel number Current indentation level
--- @param options table Formatting options
--- @return string The formatted expression
local function FormatExpression(expression, indentLevel, options)
    if not expression or expression == "" then
        return ""
    end

    -- Trim the expression
    expression = strtrim(expression)

    -- If it fits on one line, return as-is
    if FitsOneLine(expression, options.maxLineLength) then
        return expression
    end

    -- Check if expression is wrapped in outer parentheses
    local hasOuterParens = false
    if strsub(expression, 1, 1) == "(" and strsub(expression, -1) == ")" then
        -- Verify they're matching outer parens
        local depth = 0
        local allCovered = true
        for i = 1, len(expression) do
            local char = strsub(expression, i, i)
            if char == "(" then
                depth = depth + 1
            elseif char == ")" then
                depth = depth - 1
                if depth == 0 and i < len(expression) then
                    allCovered = false
                    break
                end
            end
        end
        hasOuterParens = allCovered and depth == 0
    end

    -- If wrapped in outer parens, format the content
    if hasOuterParens then
        local inner = strsub(expression, 2, -2)
        inner = strtrim(inner)

        local indent = CreateIndent(indentLevel, options.indentSize)
        local innerIndent = CreateIndent(indentLevel + 1, options.indentSize)

        -- Format inner content
        local formattedInner = FormatExpressionContent(inner, indentLevel + 1, options)

        return "(\n" .. innerIndent .. formattedInner .. "\n" .. indent .. ")"
    else
        -- Format without outer parens
        return FormatExpressionContent(expression, indentLevel, options)
    end
end

--- Strip outermost balanced parentheses that wrap the entire expression.
--- @param expression string
--- @return string strippedExpression
local function StripOutermostParentheses(expression)
    if not expression or expression == "" then
        return expression or ""
    end

    local trimmed = strtrim(expression)
    local removedAny = false

    while trimmed ~= "" do
        if strsub(trimmed, 1, 1) ~= "(" or strsub(trimmed, -1) ~= ")" then
            break
        end

        local depth = 0
        local balanced = true
        local length = len(trimmed)

        for i = 1, length do
            local char = strsub(trimmed, i, i)
            if char == "(" then
                depth = depth + 1
            elseif char == ")" then
                depth = depth - 1
                if depth == 0 and i < length then
                    balanced = false
                    break
                end
            end

            if depth < 0 then
                balanced = false
                break
            end
        end

        if not balanced or depth ~= 0 then
            break
        end

        local inner = strsub(trimmed, 2, -2)
        inner = strtrim(inner)

        if inner == trimmed then
            break
        end

        trimmed = inner
        removedAny = true

        if trimmed == "" then
            break
        end
    end

    if removedAny and trimmed ~= "" then
        return trimmed
    end

    return removedAny and trimmed or strtrim(expression)
end

-- ============================ CLAUSE FORMATTING ============================

--- Formats a single rotation clause
--- @param clause table The clause to format (from AST)
--- @param indentLevel number Current indentation level
--- @param options table Formatting options
--- @return string The formatted clause
local function FormatClause(clause, indentLevel, options)
    if not clause then
        return ""
    end

    local lines = {}
    local indent = CreateIndent(indentLevel, options.indentSize)
    local innerIndent = CreateIndent(indentLevel + 1, options.indentSize)

    -- Add notes if present (appears before clause as comment)
    if clause.notes and clause.notes ~= "" then
        local noteText = clause.notes
        if not strmatch(noteText, "^%-%-") then
            noteText = "-- " .. noteText
        end
        tinsert(lines, indent .. noteText)
    end

    -- Build the clause with proper formatting
    local hasCondition = clause.condition and clause.condition.originalText and clause.condition.originalText ~= ""
    local actionText = clause.action and clause.action.originalText or ""

    -- Validate that action exists
    if not actionText or actionText == "" then
        -- Return error indication - preserve notes if they exist
        if #lines > 0 then
            tinsert(lines, indent .. "-- [ERROR: Missing action]")
            return tconcat(lines, "\n")
        else
            return indent .. "-- [ERROR: Missing action]"
        end
    end

    -- Handle NAG:Hidden() prefix
    local hiddenPrefix = clause.hidden and "NAG:Hidden() and " or ""

    if hasCondition then
        -- Format: or (\n    condition\n) and action
        local conditionText = clause.condition.originalText or ""
        local strippedCondition = StripOutermostParentheses(conditionText)

        local formattedCondition = FormatExpression(strippedCondition, indentLevel + 1, options)

        -- Only add condition line if it's not empty
        tinsert(lines, indent .. hiddenPrefix .. "(")
        if formattedCondition and formattedCondition ~= "" then
            tinsert(lines, innerIndent .. formattedCondition)
        end

        -- Closing paren with action on same line
        local closingLine = indent .. ") and " .. actionText

        -- Add inline comment if present
        if clause.inlineComment and clause.inlineComment ~= "" then
            if #lines == 3 and not strmatch(clause.inlineComment, "^%-%-") then
                closingLine = closingLine .. " -- " .. clause.inlineComment
                tinsert(lines, closingLine)
            elseif #lines == 3 then
                closingLine = closingLine .. " " .. clause.inlineComment
                tinsert(lines, closingLine)
            else
                tinsert(lines, closingLine)
                if not strmatch(clause.inlineComment, "^%-%-") then
                    tinsert(lines, indent .. "-- " .. clause.inlineComment)
                else
                    tinsert(lines, indent .. clause.inlineComment)
                end
            end
        else
            tinsert(lines, closingLine)
        end
    else
        -- No condition: just action
        local actionLine = indent .. hiddenPrefix .. actionText

        -- Add inline comment if present
        if clause.inlineComment and clause.inlineComment ~= "" then
            if not strmatch(clause.inlineComment, "^%-%-") then
                actionLine = actionLine .. " -- " .. clause.inlineComment
            else
                actionLine = actionLine .. " " .. clause.inlineComment
            end
        end

        tinsert(lines, actionLine)
    end

    return tconcat(lines, "\n")
end

-- ============================ MAIN API ============================

--- Formats a rotation string with proper indentation and line breaks
--- @param rotationString string The rotation string to format
--- @param options table|nil Optional formatting options
--- @return string|nil The formatted rotation string, or nil on error
--- @return string|nil Error message if formatting failed
function LuaFormatter.FormatRotationString(rotationString, options)
    -- Validate input
    if not rotationString or type(rotationString) ~= "string" then
        return nil, "Invalid rotation string: expected non-nil string"
    end

    if rotationString == "" then
        return "", nil
    end

    -- Merge options with defaults
    local opts = MergeOptions(options)

    -- Get RotationConversionService
    local conversionService = NAG:GetModule("RotationConversionService")
    if not conversionService then
        return nil, "RotationConversionService module not available"
    end

    -- DEBUG: Log input
    NAG:Debug("[LuaFormatter] FormatRotationString called - input length: %d", len(rotationString))

    -- Parse rotation string into AST
    local ast, diagnostics = conversionService:ParseToProtoAST(rotationString, {
        useCache = true,
        validate = false,
    })
    if not ast or not ast.priority_list then
        local err = (diagnostics and diagnostics.errors and diagnostics.errors[1]) or "Parse failed"
        -- Fallback to original string on parse error
        NAG:Debug("[LuaFormatter] Parse failed, returning original string")
        return rotationString, "Failed to parse rotation string: " .. tostring(err)
    end

    -- Format each priority list item (proto AST)
    local formattedClauses = {}
    local ASTSchemaEmitter = ns.ASTSchemaEmitter

    for i, listItem in ipairs(ast.priority_list) do
        -- Convert listItem to clause-like structure for FormatClause
        -- FormatClause expects: condition.originalText, action.originalText, notes, hidden, inlineComment
        local clause = {
            condition = nil,
            action = nil,
            notes = listItem.notes or "",
            hidden = listItem.hidden or false,
            inlineComment = listItem.inline_comment or ""
        }

        -- Synthesize condition text from proto AST
        -- In proto AST, condition is on action.condition, not listItem.condition
        if listItem.action and listItem.action.condition then
            local conditionText = ""
            if ASTSchemaEmitter and ASTSchemaEmitter.EmitValueNode then
                conditionText = ASTSchemaEmitter.EmitValueNode(listItem.action.condition) or ""
            end
            if conditionText and conditionText ~= "" then
                clause.condition = { originalText = conditionText }
            end
        end

        -- Synthesize action text from proto AST
        if listItem.action then
            local actionText = ""
            if ASTSchemaEmitter and ASTSchemaEmitter.EmitActionNode then
                actionText = ASTSchemaEmitter.EmitActionNode(listItem.action) or ""
            end
            -- Validate action text exists
            if actionText and actionText ~= "" then
                clause.action = { originalText = actionText }
            end
        end

        local formattedClause = FormatClause(clause, 0, opts)

        -- Add "or" prefix except for first clause
        if i > 1 then
            formattedClause = "or " .. formattedClause
        end

        tinsert(formattedClauses, formattedClause)
    end

    -- Join clauses with blank lines if option enabled
    local separator = opts.blankLineBetweenClauses and "\n\n" or "\n"
    local formatted = tconcat(formattedClauses, separator)

    if strmatch(formatted, "^%s*%-%-") then
        formatted = "\n" .. formatted
    end

    -- DEBUG: Compare input and output
    local inputLen = len(rotationString)
    local outputLen = len(formatted)
    local isIdentical = rotationString == formatted

    NAG:Debug("[LuaFormatter] Format complete - input: %d chars, output: %d chars, identical: %s",
        inputLen, outputLen, tostring(isIdentical))

    if not isIdentical then
        -- Find first difference
        local minLen = min(inputLen, outputLen)
        for i = 1, minLen do
            local inputChar = strsub(rotationString, i, i)
            local outputChar = strsub(formatted, i, i)
            if inputChar ~= outputChar then
                local start = max(1, i - 10)
                local inputSnippet = strsub(rotationString, start, i + 10)
                local outputSnippet = strsub(formatted, start, i + 10)
                NAG:Debug("[LuaFormatter] First difference at position %d: input='%s' output='%s'",
                    i, inputSnippet, outputSnippet)
                break
            end
        end
        if inputLen ~= outputLen then
            NAG:Debug("[LuaFormatter] Length difference: input has %d chars, output has %d chars",
                inputLen, outputLen)
        end
    else
        NAG:Debug("[LuaFormatter] WARNING: Formatter returned identical string - this may cause false diff")
    end

    return formatted, nil
end

--- Formats a function call with arguments
--- @param funcName string The function name
--- @param args table Array of argument strings
--- @param indentLevel number Current indentation level
--- @param options table|nil Optional formatting options
--- @return string The formatted function call
function LuaFormatter.FormatFunctionCall(funcName, args, indentLevel, options)
    if not funcName then
        return ""
    end

    local opts = MergeOptions(options)

    if not args or #args == 0 then
        return funcName .. "()"
    end

    -- Build simple function call
    local argsText = tconcat(args, ", ")
    local fullCall = funcName .. "(" .. argsText .. ")"

    -- If it fits on one line, return it
    if FitsOneLine(fullCall, opts.maxLineLength) then
        return fullCall
    end

    -- Otherwise, break args across lines
    local indent = CreateIndent(indentLevel + 1, opts.indentSize)
    local formattedArgs = {}
    for _, arg in ipairs(args) do
        tinsert(formattedArgs, indent .. arg)
    end

    return funcName .. "(\n" .. tconcat(formattedArgs, ",\n") .. "\n" .. CreateIndent(indentLevel, opts.indentSize) .. ")"
end

-- ============================ TEST FUNCTIONS ============================

--- Test function to verify formatter is working
--- @param rotationString string|table Test rotation string (or self if called with :)
--- @return boolean success True if test passed
function LuaFormatter.RunTest(rotationString)
    -- Handle both ns.LuaFormatter.RunTest() and ns.LuaFormatter:RunTest() calls
    if type(rotationString) == "table" or not rotationString then
        -- Default test string
        rotationString = [[or (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneUnholy) == 1) and (NAG:CurrentRuneCount(NAG.Types.RuneType.RuneDeath) == 0) and NAG:CastSpell(114867)]]
    end

    print("=== LuaFormatter Test ===")
    print("Original:")
    print(rotationString)
    print("\nFormatted:")

    local formatted, err = LuaFormatter.FormatRotationString(rotationString)
    if formatted then
        print(formatted)
        print("\n|cFF00FF00Test PASSED|r")
        return true
    else
        print("|cFFFF0000Test FAILED: " .. tostring(err) .. "|r")
        return false
    end
end

-- ============================ MODULE EXPORT ============================

ns.LuaFormatter = LuaFormatter

