--- @module "RotationEditor.SyntaxHighlighting"
--- Syntax highlighting integration for RotationEditor using FAIAP library
---
--- Uses ForAllIndentsAndPurposes (FAIAP) library for Lua syntax highlighting.
--- Features: Rainbow parenthesis matching, AST-consistent colors, auto-indentation.
---
--- Original: Kristofer Karlsson (kristofer.karlsson@gmail.com)
--- Source: WeakAuras2 (https://github.com/WeakAuras/WeakAuras2)
--- Embedded with modifications for NAG addon (Rev 24: Rainbow parenthesis colorization)
---
--- License: CC BY-NC 4.0
--- Authors: Rakizi, Fonsas (NAG integration), Kristofer Karlsson (FAIAP library)

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DEFINITION ~~~~~~~~~~

local SyntaxHighlighting = {}
ns.RotationEditorSyntaxHighlighting = SyntaxHighlighting

-- APL-specific color table optimized for rotation editing; colors match AST tree view for consistency
local aplColorTable = {}

-- Only initialize if FAIAP library is available
if ns.IndentationLib and ns.IndentationLib.tokens then
    local tokens = ns.IndentationLib.tokens

    -- Lua keywords (purple-blue)
    aplColorTable[tokens.TOKEN_KEYWORD] = "|c006666ff"

    -- Comments (gray)
    aplColorTable[tokens.TOKEN_COMMENT_SHORT] = "|c00999999"
    aplColorTable[tokens.TOKEN_COMMENT_LONG] = "|c00999999"

    -- Strings (yellow)
    aplColorTable[tokens.TOKEN_STRING] = "|c00ffff77"
    aplColorTable[".."] = "|c00ffff77"

    -- Numbers (bright green)
    aplColorTable[tokens.TOKEN_NUMBER] = "|c0033ff55"

    -- Comparison operators (cyan - matches tree view)
    aplColorTable["<"] = "|c0000FFFF"
    aplColorTable["<="] = "|c0000FFFF"
    aplColorTable[">"] = "|c0000FFFF"
    aplColorTable[">="] = "|c0000FFFF"
    aplColorTable["=="] = "|c0000FFFF"
    aplColorTable["~="] = "|c0000FFFF"

    -- Logical operators - match AST tree colors
    aplColorTable["and"] = "|c0000FF00"  -- Green like AND in tree
    aplColorTable["or"] = "|c00FFA500"   -- Orange like OR in tree
    aplColorTable["not"] = "|c00FF0000"  -- Red like NOT in tree

    -- Parentheses: Rainbow matching pairs (6 cycling colors by depth), bright high-contrast colors optimized for dark backgrounds
    aplColorTable["paren_depth_0"] = "|c00FF3333"  -- Bright Red
    aplColorTable["paren_depth_1"] = "|c0000DDFF"  -- Bright Cyan
    aplColorTable["paren_depth_2"] = "|c00FF9933"  -- Bright Orange
    aplColorTable["paren_depth_3"] = "|c0099FF33"  -- Bright Lime Green
    aplColorTable["paren_depth_4"] = "|c00FFDD33"  -- Bright Yellow
    aplColorTable["paren_depth_5"] = "|c00FF33DD"  -- Bright Magenta
    -- Fallback for parentheses without rainbow (shouldn't be needed with FAIAP rev 24+)
    aplColorTable["("] = "|c00FF8800"
    aplColorTable[")"] = "|c00FF8800"

    -- Brackets (orange)
    aplColorTable["["] = "|c00ff9900"
    aplColorTable["]"] = "|c00ff9900"
    aplColorTable["{"] = "|c00ff9900"
    aplColorTable["}"] = "|c00ff9900"
    aplColorTable["..."] = "|c00ff9900"

    -- Math operators (bright green)
    aplColorTable["+"] = "|c0033ff55"
    aplColorTable["-"] = "|c0033ff55"
    aplColorTable["*"] = "|c0033ff55"
    aplColorTable["/"] = "|c0033ff55"

    -- Special APL markers
    aplColorTable[tokens.TOKEN_SPECIAL] = "|c00ff99ff"

    -- Reset
    aplColorTable[0] = "|r"
end

-- ============================ INTERNAL HELPERS ============================

--- Validate that FAIAP library is available
--- @return boolean True if available, logs and returns false otherwise
local function validateIndentationLib()
    if not ns.IndentationLib then
        NAG:Info("[SyntaxHighlighting] FAIAP library not loaded - syntax highlighting unavailable")
        return false
    end
    return true
end

--- Validate that editbox parameter is provided
--- @param editbox table The editbox to validate
--- @param functionName string Name of calling function for error messages
--- @return boolean True if valid, logs and returns false otherwise
local function validateEditbox(editbox, functionName)
    if not editbox then
        NAG:Warn("[SyntaxHighlighting] Invalid editbox provided to %s", functionName)
        return false
    end
    return true
end

-- ============================ PUBLIC API ============================

--- Enable APL syntax highlighting on an EditBox widget
--- @param editbox table The actual EditBox widget (not AceGUI wrapper - use widget.editBox)
--- @param tabWidth number Optional tab width (default: 2)
--- @param options table|nil Optional configuration table
--- @return boolean Success status
function SyntaxHighlighting.EnableAPLSyntaxHighlighting(editbox, tabWidth, options)
    if not validateIndentationLib() then
        return false
    end

    if not validateEditbox(editbox, "EnableAPLSyntaxHighlighting") then
        return false
    end

    tabWidth = tabWidth or 2

    -- Extract forceInitialIndent option if present (FAIAP handles it separately from other options)
    local forceInitialIndent = false
    local enableOptions = options
    if type(options) == "table" and options.forceInitialIndent then
        forceInitialIndent = options.forceInitialIndent
        -- Create copy without forceInitialIndent for FAIAP enable call
        enableOptions = {}
        for key, value in pairs(options) do
            if key ~= "forceInitialIndent" then
                enableOptions[key] = value
            end
        end
    end

    ns.IndentationLib.enable(editbox, aplColorTable, tabWidth, enableOptions)

    if forceInitialIndent and ns.IndentationLib.indentEditbox then
        ns.IndentationLib.indentEditbox(editbox)
    end

    return true
end

--- Disable APL syntax highlighting on an EditBox widget
--- @param editbox table The actual EditBox widget
--- @return boolean Success status
function SyntaxHighlighting.DisableAPLSyntaxHighlighting(editbox)
    if not validateIndentationLib() then
        NAG:Debug("[SyntaxHighlighting] DisableAPLSyntaxHighlighting: FAIAP library not available")
        return false
    end

    if not validateEditbox(editbox, "DisableAPLSyntaxHighlighting") then
        return false
    end

    ns.IndentationLib.disable(editbox)
    return true
end

--- Get the APL color table for custom usage
--- @return table The color table used for APL syntax highlighting
function SyntaxHighlighting.GetAPLColorTable()
    return aplColorTable
end

return SyntaxHighlighting

