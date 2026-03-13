--- ForAllIndentsAndPurposes - Lua Syntax Highlighting and Indentation Library
--- Original Author: Kristofer Karlsson (kristofer.karlsson@gmail.com)
--- Source: WeakAuras2 (https://github.com/WeakAuras/WeakAuras2)
--- Original: https://www.wowinterface.com/downloads/info4895-ForAllIndentsAndPurposes.html
--- Embedded with modifications for NAG addon
--- License: Same as original WeakAuras2 (GPL-2.0)
---
--- NAG Modifications (Revision 24):
--- - Changed from global IndentationLib to ns.IndentationLib (namespace isolation)
--- - Added rainbow parenthesis colorization for matching pairs
---   * Tracks parenthesis depth during syntax highlighting
---   * Uses 6 cycling colors: paren_depth_0 through paren_depth_5
---   * Matching pairs show in the same color based on nesting level
---   * Fallback chain: paren_depth_N -> colorTable["("] or colorTable[")"] -> colorTable[tokenType]
---   * Preserves original colorization if rainbow colors not defined in colorTable

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~

local _, ns = ...

-- For All Indents And Purposes
local revision = 24  -- NAG: Added rainbow parenthesis colorization

-- Maintainer: kristofer.karlsson@gmail.com

-- For All Indents And Purposes -
-- a indentation + syntax highlighting library
-- All valid lua code should be processed correctly.

-- Usage (for developers)
--------
-- Variant 1: - non embedded
-- 1) Add ForAllIndentsAndPurposes to your dependencies (or optional dependencies)

-- Variant 2: - embedded
-- 1.a) Copy indent.lua to your addon directory
-- 1.b) Put indent.lua first in your list of files in the TOC

-- For both variants:
-- 2) hook the editboxes that you want to have indentation like this:
--    IndentationLib.enable(editbox [, colorTable [, tabWidth [, options] ] ])
--    if you don't select a color table, it will use the default.

-- Read through this code for further usage help.
-- (The documentation IS the code)

-- NAG Modification: Changed from global IndentationLib to ns.IndentationLib
if not ns.IndentationLib then
  ns.IndentationLib = {}
end

if not ns.IndentationLib.revision or revision > ns.IndentationLib.revision then
  local lib = ns.IndentationLib
  lib.revision = revision

  local stringlen = string.len
  local stringformat = string.format
  local stringfind = string.find
  local stringsub = string.sub
  local stringbyte = string.byte
  local stringchar = string.char
  local stringrep = string.rep
  local stringgsub = string.gsub

  local defaultTabWidth = 2
  local defaultColorTable
  local MAX_FULL_COLOR_CODE_LENGTH = 16000
  local MAX_PAREN_COLOR_CODE_LENGTH = 9000

  local workingTable = {}
  local workingTable2 = {}

  local function tableclear(t)
    for k in next,t do
      t[k] = nil
    end
  end

  local function shallowCopy(source)
    if not source then
      return nil
    end

    local copy = {}
    for k, v in pairs(source) do
      copy[k] = v
    end
    return copy
  end

  local function shallowEqual(a, b)
    if a == b then
      return true
    end

    if not a or not b then
      return false
    end

    for k, v in pairs(a) do
      if b[k] ~= v then
        return false
      end
    end

    for k, v in pairs(b) do
      if a[k] ~= v then
        return false
      end
    end

    return true
  end

  local function sanitizeUTF8(token)
    if not token or token == "" then
      return token, false
    end

    local length = stringlen(token)
    local startIndex = 1
    local segments = nil
    local i = 1

    while i <= length do
      local byte = stringbyte(token, i)
      if byte and byte >= 128 then
        segments = segments or {}
        if i > startIndex then
          segments[#segments + 1] = stringsub(token, startIndex, i - 1)
        end
        segments[#segments + 1] = "?"

        if byte >= 240 then
          i = i + 4
        elseif byte >= 224 then
          i = i + 3
        elseif byte >= 192 then
          i = i + 2
        else
          i = i + 1
        end

        startIndex = i
      else
        i = i + 1
      end
    end

    if segments then
      if startIndex <= length then
        segments[#segments + 1] = stringsub(token, startIndex, length)
      end
      return table.concat(segments), true
    end

    return token, false
  end

  lib.sanitizeUTF8 = sanitizeUTF8

  local function stringinsert(s, pos, insertStr)
    return stringsub(s, 1, pos) .. insertStr .. stringsub(s, pos + 1)
  end

  lib.stringinsert = stringinsert

  local function stringdelete(s, pos1, pos2)
    return stringsub(s, 1, pos1 - 1) .. stringsub(s, pos2 + 1)
  end

  lib.stringdelete = stringdelete

  -- token types
  local tokens = {}
  lib.tokens = tokens
  tokens.TOKEN_UNKNOWN = 0
  tokens.TOKEN_NUMBER = 1
  tokens.TOKEN_LINEBREAK = 2
  tokens.TOKEN_WHITESPACE = 3
  tokens.TOKEN_IDENTIFIER = 4
  tokens.TOKEN_ASSIGNMENT = 5
  tokens.TOKEN_EQUALITY = 6
  tokens.TOKEN_MINUS = 7
  tokens.TOKEN_COMMENT_SHORT = 8
  tokens.TOKEN_COMMENT_LONG = 9
  tokens.TOKEN_STRING = 10
  tokens.TOKEN_LEFTBRACKET = 11
  tokens.TOKEN_PERIOD = 12
  tokens.TOKEN_DOUBLEPERIOD = 13
  tokens.TOKEN_TRIPLEPERIOD = 14
  tokens.TOKEN_LTE = 15
  tokens.TOKEN_LT = 16
  tokens.TOKEN_GTE = 17
  tokens.TOKEN_GT = 18
  tokens.TOKEN_NOTEQUAL = 19
  tokens.TOKEN_COMMA = 20
  tokens.TOKEN_SEMICOLON = 21
  tokens.TOKEN_COLON = 22
  tokens.TOKEN_LEFTPAREN = 23
  tokens.TOKEN_RIGHTPAREN = 24
  tokens.TOKEN_PLUS = 25
  tokens.TOKEN_SLASH = 27
  tokens.TOKEN_LEFTWING = 28
  tokens.TOKEN_RIGHTWING = 29
  tokens.TOKEN_CIRCUMFLEX = 30
  tokens.TOKEN_ASTERISK = 31
  tokens.TOKEN_RIGHTBRACKET = 32
  tokens.TOKEN_KEYWORD = 33
  tokens.TOKEN_SPECIAL = 34
  tokens.TOKEN_VERTICAL = 35
  tokens.TOKEN_TILDE = 36

  -- WoW specific tokens
  tokens.TOKEN_COLORCODE_START = 37
  tokens.TOKEN_COLORCODE_STOP = 38

  -- new as of lua 5.1
  tokens.TOKEN_HASH = 39
  tokens.TOKEN_PERCENT = 40

  -- ascii codes
  local bytes = {}
  lib.bytes = bytes
  bytes.BYTE_LINEBREAK_UNIX = stringbyte("\n")
  bytes.BYTE_LINEBREAK_MAC = stringbyte("\r")
  bytes.BYTE_SINGLE_QUOTE = stringbyte("'")
  bytes.BYTE_DOUBLE_QUOTE = stringbyte('"')
  bytes.BYTE_0 = stringbyte("0")
  bytes.BYTE_9 = stringbyte("9")
  bytes.BYTE_PERIOD = stringbyte(".")
  bytes.BYTE_SPACE = stringbyte(" ")
  bytes.BYTE_TAB = stringbyte("\t")
  bytes.BYTE_E = stringbyte("E")
  bytes.BYTE_e = stringbyte("e")
  bytes.BYTE_MINUS = stringbyte("-")
  bytes.BYTE_EQUALS = stringbyte("=")
  bytes.BYTE_LEFTBRACKET = stringbyte("[")
  bytes.BYTE_RIGHTBRACKET = stringbyte("]")
  bytes.BYTE_BACKSLASH = stringbyte("\\")
  bytes.BYTE_COMMA = stringbyte(",")
  bytes.BYTE_SEMICOLON = stringbyte(";")
  bytes.BYTE_COLON = stringbyte(":")
  bytes.BYTE_LEFTPAREN = stringbyte("(")
  bytes.BYTE_RIGHTPAREN = stringbyte(")")
  bytes.BYTE_TILDE = stringbyte("~")
  bytes.BYTE_PLUS = stringbyte("+")
  bytes.BYTE_SLASH = stringbyte("/")
  bytes.BYTE_LEFTWING = stringbyte("{")
  bytes.BYTE_RIGHTWING = stringbyte("}")
  bytes.BYTE_CIRCUMFLEX = stringbyte("^")
  bytes.BYTE_ASTERISK = stringbyte("*")
  bytes.BYTE_LESSTHAN = stringbyte("<")
  bytes.BYTE_GREATERTHAN = stringbyte(">")

  -- WoW specific chars
  bytes.BYTE_VERTICAL = stringbyte("|")
  bytes.BYTE_r = stringbyte("r")
  bytes.BYTE_c = stringbyte("c")

  -- new as of lua 5.1
  bytes.BYTE_HASH = stringbyte("#")
  bytes.BYTE_PERCENT = stringbyte("%")

  local linebreakCharacters = {}
  lib.linebreakCharacters = linebreakCharacters
  linebreakCharacters[bytes.BYTE_LINEBREAK_UNIX] = 1
  linebreakCharacters[bytes.BYTE_LINEBREAK_MAC] = 1

  local whitespaceCharacters = {}
  lib.whitespaceCharacters = whitespaceCharacters
  whitespaceCharacters[bytes.BYTE_SPACE] = 1
  whitespaceCharacters[bytes.BYTE_TAB] = 1

  local specialCharacters = {}
  lib.specialCharacters = specialCharacters
  specialCharacters[bytes.BYTE_PERIOD] = -1
  specialCharacters[bytes.BYTE_LESSTHAN] = -1
  specialCharacters[bytes.BYTE_GREATERTHAN] = -1
  specialCharacters[bytes.BYTE_LEFTBRACKET] = -1
  specialCharacters[bytes.BYTE_EQUALS] = -1
  specialCharacters[bytes.BYTE_MINUS] = -1
  specialCharacters[bytes.BYTE_SINGLE_QUOTE] = -1
  specialCharacters[bytes.BYTE_DOUBLE_QUOTE] = -1
  specialCharacters[bytes.BYTE_TILDE] = -1
  specialCharacters[bytes.BYTE_RIGHTBRACKET] = tokens.TOKEN_RIGHTBRACKET
  specialCharacters[bytes.BYTE_COMMA] = tokens.TOKEN_COMMA
  specialCharacters[bytes.BYTE_COLON] = tokens.TOKEN_COLON
  specialCharacters[bytes.BYTE_SEMICOLON] = tokens.TOKEN_SEMICOLON
  specialCharacters[bytes.BYTE_LEFTPAREN] = tokens.TOKEN_LEFTPAREN
  specialCharacters[bytes.BYTE_RIGHTPAREN] = tokens.TOKEN_RIGHTPAREN
  specialCharacters[bytes.BYTE_PLUS] = tokens.TOKEN_PLUS
  specialCharacters[bytes.BYTE_SLASH] = tokens.TOKEN_SLASH
  specialCharacters[bytes.BYTE_LEFTWING] = tokens.TOKEN_LEFTWING
  specialCharacters[bytes.BYTE_RIGHTWING] = tokens.TOKEN_RIGHTWING
  specialCharacters[bytes.BYTE_CIRCUMFLEX] = tokens.TOKEN_CIRCUMFLEX
  specialCharacters[bytes.BYTE_ASTERISK] = tokens.TOKEN_ASTERISK

  -- WoW specific
  specialCharacters[bytes.BYTE_VERTICAL] = -1

  -- new as of lua 5.1
  specialCharacters[bytes.BYTE_HASH] = tokens.TOKEN_HASH
  specialCharacters[bytes.BYTE_PERCENT] = tokens.TOKEN_PERCENT

  local function nextNumberExponentPartInt(text, pos)
    while true do
      local byte = stringbyte(text, pos)
      if not byte then
        return tokens.TOKEN_NUMBER, pos
      end
      if byte >= bytes.BYTE_0 and byte <= bytes.BYTE_9 then
        pos = pos + 1
      else
        return tokens.TOKEN_NUMBER, pos
      end
    end
  end

  local function nextNumberExponentPart(text, pos)
    local byte = stringbyte(text, pos)
    if not byte then
      return tokens.TOKEN_NUMBER, pos
    end
    if byte == bytes.BYTE_MINUS then
      -- handle this case: a = 1.2e-- some comment
      -- i decide to let 1.2e be parsed as a a number
      byte = stringbyte(text, pos + 1)
      if byte == bytes.BYTE_MINUS then
        return tokens.TOKEN_NUMBER, pos
      end
    end
    if byte == bytes.BYTE_MINUS or (byte >= bytes.BYTE_0 and byte <= bytes.BYTE_9) then
      return nextNumberExponentPartInt(text, pos + 1)
    end
    return tokens.TOKEN_NUMBER, pos
  end

  local function nextNumberExponent(text, pos)
    local byte = stringbyte(text, pos)
    if not byte then
      return tokens.TOKEN_NUMBER, pos
    end
    if byte == bytes.BYTE_E or byte == bytes.BYTE_e then
      return nextNumberExponentPart(text, pos + 1)
    end
    return tokens.TOKEN_NUMBER, pos
  end

  local function nextNumberDecimalPart(text, pos)
    while true do
      local byte = stringbyte(text, pos)
      if not byte then
        return tokens.TOKEN_NUMBER, pos
      end
      if byte >= bytes.BYTE_0 and byte <= bytes.BYTE_9 then
        pos = pos + 1
      else
        return nextNumberExponent(text, pos)
      end
    end
  end

  local function nextNumberPeriod(text, pos)
    local byte = stringbyte(text, pos)
    if not byte then
      return tokens.TOKEN_NUMBER, pos
    end
    if byte == bytes.BYTE_PERIOD then
      return nextNumberDecimalPart(text, pos + 1)
    end
    return nextNumberExponent(text, pos)
  end

  local function nextNumberIntegerPart(text, pos)
    while true do
      local byte = stringbyte(text, pos)
      if not byte then
        return tokens.TOKEN_NUMBER, pos
      end
      if byte >= bytes.BYTE_0 and byte <= bytes.BYTE_9 then
        pos = pos + 1
      else
        return nextNumberPeriod(text, pos)
      end
    end
  end

  local function nextNumber(text, pos)
    local byte = stringbyte(text, pos)
    if not byte then
      return tokens.TOKEN_NUMBER, pos
    end
    if byte >= bytes.BYTE_0 and byte <= bytes.BYTE_9 then
      return nextNumberIntegerPart(text, pos + 1)
    elseif byte == bytes.BYTE_PERIOD then
      return nextNumberDecimalPart(text, pos + 1)
    end
    return tokens.TOKEN_UNKNOWN, pos
  end

  local function nextLinebreak(text, pos)
    local byte = stringbyte(text, pos)
    if not byte then
      return tokens.TOKEN_LINEBREAK, pos
    end
    if linebreakCharacters[byte] then
      local nextByte = stringbyte(text, pos + 1)
      if linebreakCharacters[nextByte] and nextByte ~= byte then
        return tokens.TOKEN_LINEBREAK, pos + 2
      end
      return tokens.TOKEN_LINEBREAK, pos + 1
    end
    return tokens.TOKEN_UNKNOWN, pos
  end

  local function nextWhitespace(text, pos)
    while true do
      local byte = stringbyte(text, pos)
      if not byte then
        return tokens.TOKEN_WHITESPACE, pos
      end
      if not whitespaceCharacters[byte] then
        return tokens.TOKEN_WHITESPACE, pos
      end
      pos = pos + 1
    end
  end

  local alphaNum = {}
  for i = stringbyte("a"), stringbyte("z") do
    alphaNum[i] = true
  end
  for i = stringbyte("A"), stringbyte("Z") do
    alphaNum[i] = true
  end
  for i = stringbyte("0"), stringbyte("9") do
    alphaNum[i] = true
  end
  alphaNum[stringbyte("_")] = true

  local function nextIdentifier(text, pos)
    while true do
      local byte = stringbyte(text, pos)
      if not byte then
        return tokens.TOKEN_IDENTIFIER, pos
      end
      if not alphaNum[byte] then
        return tokens.TOKEN_IDENTIFIER, pos
      end
      pos = pos + 1
    end
  end

  local function nextMinus(text, pos)
    local byte = stringbyte(text, pos)
    if not byte then
      return tokens.TOKEN_MINUS, pos
    end
    if byte == bytes.BYTE_MINUS then
      local byte = stringbyte(text, pos + 1)
      if byte == bytes.BYTE_LEFTBRACKET then
        local byte = stringbyte(text, pos + 2)
        if byte == bytes.BYTE_LEFTBRACKET then
          return tokens.TOKEN_COMMENT_LONG, pos + 3
        elseif byte == bytes.BYTE_EQUALS then
          local level = 0
          while byte == bytes.BYTE_EQUALS do
            level = level + 1
            pos = pos + 1
            byte = stringbyte(text, pos + 2)
          end
          if byte == bytes.BYTE_LEFTBRACKET then
            return tokens.TOKEN_COMMENT_LONG, pos + 3, level
          end
        end
      end
      return tokens.TOKEN_COMMENT_SHORT, pos + 1
    end
    return tokens.TOKEN_MINUS, pos
  end

  local function nextBracketString(text, pos, level)
    level = level or 0
    local closePat = stringrep("=", level)
    local startPat = "[" .. closePat .. "["
    closePat = "]" .. closePat .. "]"
    local closePos = stringfind(text, closePat, pos, true)
    if not closePos then
      return tokens.TOKEN_STRING, stringlen(text) + 1, level
    end
    return tokens.TOKEN_STRING, closePos + stringlen(closePat), level
  end

  local function nextBracketComment(text, pos, level)
    level = level or 0
    local closePat = stringrep("=", level)
    closePat = "]" .. closePat .. "]"
    local closePos = stringfind(text, closePat, pos, true)
    if not closePos then
      return tokens.TOKEN_COMMENT_LONG, stringlen(text) + 1, level
    end
    return tokens.TOKEN_COMMENT_LONG, closePos + stringlen(closePat), level
  end

  local function nextLeftBracket(text, pos)
    local byte = stringbyte(text, pos)
    if not byte then
      return tokens.TOKEN_LEFTBRACKET, pos
    end
    if byte == bytes.BYTE_LEFTBRACKET then
      return nextBracketString(text, pos + 1, 0)
    elseif byte == bytes.BYTE_EQUALS then
      local level = 0
      while byte == bytes.BYTE_EQUALS do
        level = level + 1
        pos = pos + 1
        byte = stringbyte(text, pos)
      end
      if byte == bytes.BYTE_LEFTBRACKET then
        return nextBracketString(text, pos + 1, level)
      end
    end
    return tokens.TOKEN_LEFTBRACKET, pos
  end

  local function nextPeriod(text, pos)
    local byte = stringbyte(text, pos)
    if not byte then
      return tokens.TOKEN_PERIOD, pos
    end
    if byte == bytes.BYTE_PERIOD then
      local byte = stringbyte(text, pos + 1)
      if byte == bytes.BYTE_PERIOD then
        return tokens.TOKEN_TRIPLEPERIOD, pos + 2
      end
      return tokens.TOKEN_DOUBLEPERIOD, pos + 1
    elseif byte >= bytes.BYTE_0 and byte <= bytes.BYTE_9 then
      return nextNumberDecimalPart(text, pos)
    end
    return tokens.TOKEN_PERIOD, pos
  end

  local function nextLT(text, pos)
    local byte = stringbyte(text, pos)
    if not byte then
      return tokens.TOKEN_LT, pos
    end
    if byte == bytes.BYTE_EQUALS then
      return tokens.TOKEN_LTE, pos + 1
    end
    return tokens.TOKEN_LT, pos
  end

  local function nextGT(text, pos)
    local byte = stringbyte(text, pos)
    if not byte then
      return tokens.TOKEN_GT, pos
    end
    if byte == bytes.BYTE_EQUALS then
      return tokens.TOKEN_GTE, pos + 1
    end
    return tokens.TOKEN_GT, pos
  end

  local function nextEquals(text, pos)
    local byte = stringbyte(text, pos)
    if not byte then
      return tokens.TOKEN_ASSIGNMENT, pos
    end
    if byte == bytes.BYTE_EQUALS then
      return tokens.TOKEN_EQUALITY, pos + 1
    end
    return tokens.TOKEN_ASSIGNMENT, pos
  end

  local function nextTilde(text, pos)
    local byte = stringbyte(text, pos)
    if not byte then
      return tokens.TOKEN_TILDE, pos
    end
    if byte == bytes.BYTE_EQUALS then
      return tokens.TOKEN_NOTEQUAL, pos + 1
    end
    return tokens.TOKEN_TILDE, pos
  end

  local function nextQuoteString(text, pos, quote)
    while true do
      local byte = stringbyte(text, pos)
      if not byte then
        return tokens.TOKEN_STRING, pos
      end
      if byte == quote then
        return tokens.TOKEN_STRING, pos + 1
      end
      if byte == bytes.BYTE_BACKSLASH then
        pos = pos + 2
      elseif linebreakCharacters[byte] then
        return tokens.TOKEN_STRING, pos
      else
        pos = pos + 1
      end
    end
  end

  local function nextVertical(text, pos)
    local byte = stringbyte(text, pos)
    if not byte then
      return tokens.TOKEN_VERTICAL, pos
    end
    if byte == bytes.BYTE_c then
      for i = 1, 8 do
        local byte = stringbyte(text, pos + i)
        if not byte then
          return tokens.TOKEN_VERTICAL, pos
        end
        if not alphaNum[byte] then
          return tokens.TOKEN_VERTICAL, pos
        end
      end
      return tokens.TOKEN_COLORCODE_START, pos + 9
    elseif byte == bytes.BYTE_r then
      return tokens.TOKEN_COLORCODE_STOP, pos + 1
    end
    return tokens.TOKEN_VERTICAL, pos
  end

  local keyWords = {}
  for _, keyWord in ipairs({
    "and", "break", "do", "else", "elseif",
    "end", "false", "for", "function", "if",
    "in", "local", "nil", "not", "or",
    "repeat", "return", "then", "true", "until", "while"
  }) do
    keyWords[keyWord] = true
  end

  local function nextToken(text, pos)
    local byte = stringbyte(text, pos)
    if not byte then
      return
    end

    if linebreakCharacters[byte] then
      return nextLinebreak(text, pos)
    elseif whitespaceCharacters[byte] then
      return nextWhitespace(text, pos)
    end

    if byte == bytes.BYTE_VERTICAL then
      return nextVertical(text, pos + 1)
    end

    if byte >= bytes.BYTE_0 and byte <= bytes.BYTE_9 then
      return nextNumber(text, pos)
    end

    local token = specialCharacters[byte]
    if token then
      if token == -1 then
        if byte == bytes.BYTE_MINUS then
          return nextMinus(text, pos + 1)
        elseif byte == bytes.BYTE_LEFTBRACKET then
          return nextLeftBracket(text, pos + 1)
        elseif byte == bytes.BYTE_PERIOD then
          return nextPeriod(text, pos + 1)
        elseif byte == bytes.BYTE_LESSTHAN then
          return nextLT(text, pos + 1)
        elseif byte == bytes.BYTE_GREATERTHAN then
          return nextGT(text, pos + 1)
        elseif byte == bytes.BYTE_EQUALS then
          return nextEquals(text, pos + 1)
        elseif byte == bytes.BYTE_SINGLE_QUOTE then
          return nextQuoteString(text, pos + 1, bytes.BYTE_SINGLE_QUOTE)
        elseif byte == bytes.BYTE_DOUBLE_QUOTE then
          return nextQuoteString(text, pos + 1, bytes.BYTE_DOUBLE_QUOTE)
        elseif byte == bytes.BYTE_TILDE then
          return nextTilde(text, pos + 1)
        end
      else
        return token, pos + 1
      end
    end

    if alphaNum[byte] then
      local tokenType, nextPos = nextIdentifier(text, pos + 1)
      local word = stringsub(text, pos, nextPos - 1)
      if keyWords[word] then
        return tokens.TOKEN_KEYWORD, nextPos, word
      end
      return tokenType, nextPos
    end

    return tokens.TOKEN_UNKNOWN, pos + 1
  end

  lib.nextToken = nextToken

  function lib.encode(str)
    if not str then
      return ""
    end
    str = stringgsub(str, "|", "||")
    return str
  end

  function lib.decode(str)
    if not str then
      return ""
    end
    str = stringgsub(str, "|([^cr])", "%1")
    str = stringgsub(str, "||||", "||")
    str = stringgsub(str, "|c%x%x%x%x%x%x%x%x", "")
    str = stringgsub(str, "|r", "")
    return str
  end

  function lib.stripWowColors(str)
    if not str then
      return ""
    end
    str = stringgsub(str, "|c%x%x%x%x%x%x%x%x", "")
    str = stringgsub(str, "|r", "")
    return str
  end

  function lib.stripWowColorsWithPos(str, pos)
    if not str then
      return "", pos
    end
    if not pos then
      return lib.stripWowColors(str), pos
    end
    local newStr = ""
    local newPos = pos
    local strPos = 1
    local byte
    repeat
      byte = stringbyte(str, strPos)
      if not byte then
        break
      end
      if byte == bytes.BYTE_VERTICAL then
        local nextByte = stringbyte(str, strPos + 1)
        if nextByte == bytes.BYTE_c then
          local allOk = true
          for i = 2, 9 do
            local byte = stringbyte(str, strPos + i)
            if not byte or not alphaNum[byte] then
              allOk = false
              break
            end
          end
          if allOk then
            if strPos < pos then
              newPos = newPos - 10
            end
            strPos = strPos + 10
          else
            newStr = newStr .. "|"
            strPos = strPos + 1
          end
        elseif nextByte == bytes.BYTE_r then
          if strPos < pos then
            newPos = newPos - 2
          end
          strPos = strPos + 2
        else
          newStr = newStr .. "|"
          strPos = strPos + 1
        end
      else
        newStr = newStr .. stringchar(byte)
        strPos = strPos + 1
      end
    until false
    return newStr, newPos
  end

  function lib.padWithLinebreaks(str, numLineBreaks)
    if not str then
      return ""
    end
    numLineBreaks = numLineBreaks or 10
    local count = 0
    local pos = 1
    repeat
      local byte = stringbyte(str, pos)
      if not byte then
        break
      end
      if linebreakCharacters[byte] then
        count = count + 1
      end
      pos = pos + 1
    until false
    if count < numLineBreaks then
      return str .. stringrep("\n", numLineBreaks - count)
    end
    return str
  end

  function lib.indentCode(code, tabWidth, colorTable, caretPos, options)
    tabWidth = tabWidth or defaultTabWidth
    colorTable = colorTable or defaultColorTable
    options = options or {}

    local codeLength = stringlen(code or "")
    local disableColorization = options.disableColorization == true
    local baseColorize = not disableColorization
    local colorize = baseColorize and codeLength <= MAX_FULL_COLOR_CODE_LENGTH
    local parenColorize = baseColorize and codeLength <= MAX_PAREN_COLOR_CODE_LENGTH
    local resetColor = colorTable[0] or "|r"

    local caretComparePos = nil
    if caretPos and caretPos >= 0 then
      caretComparePos = caretPos + 1 -- Lua strings are 1-based; cursor position from WoW editboxes is 0-based
    end

    local indentLevel = 0
    local indentNextLine = false
    local tokenPos = 1
    local caretShift = 0
    local newCaretPos

    local result = ""

    local lineStart = true
    local lineStartIndent

    local lastTokenType
    local lastToken
    local lastIndentLevel
    local lastWasEnd = false

    -- NAG: Track parenthesis depth for rainbow colorization
    local parenDepth = 0
    local preserveIndent = options.preserveExistingIndent
    local suppressColor = false

    local function appendToken(token, color, tokenStartPos)
      if not token or token == "" then
        return
      end

      local sanitized, replaced = sanitizeUTF8(token)
      if replaced then
        token = sanitized
      end

      if suppressColor then
        color = nil
      end

      local tokenLength = stringlen(token)
      local beforeResultLength = stringlen(result)
      local colorLength = 0
      local resetLength = 0

      if colorize and color then
        colorLength = stringlen(color)
        resetLength = stringlen(resetColor)
        result = result .. color .. token .. resetColor
      else
        result = result .. token
      end

      if caretComparePos and tokenStartPos then
        if not newCaretPos and tokenStartPos <= caretComparePos and tokenStartPos + tokenLength >= caretComparePos then
          local offset = caretComparePos - tokenStartPos
          if offset < 0 then
            offset = 0
          elseif offset > tokenLength then
            offset = tokenLength
          end

          local basePosition = beforeResultLength
          if colorize and color then
            basePosition = basePosition + colorLength
          end

          newCaretPos = basePosition + offset
        elseif tokenStartPos + tokenLength < caretComparePos and colorize and color then
          caretShift = caretShift + colorLength + resetLength
        end
      end
    end

    while true do
      local tokenType, nextTokenPos, extra = nextToken(code, tokenPos)
      if not tokenType then
        break
      end

      local token = stringsub(code, tokenPos, nextTokenPos - 1)

      if tokenType == tokens.TOKEN_KEYWORD then
        if extra == "end" or extra == "until" or extra == "elseif" or extra == "else" then
          if lineStart and not lastWasEnd then
            indentLevel = indentLevel - 1
            if indentLevel < 0 then
              indentLevel = 0
            end
          end
          lastWasEnd = (extra == "end")
        else
          lastWasEnd = false
        end
      else
        lastWasEnd = false
      end

      if lineStart and tokenType ~= tokens.TOKEN_LINEBREAK and tokenType ~= tokens.TOKEN_WHITESPACE then
        lineStart = false
        local indent
        if preserveIndent and lineStartIndent then
          indent = lineStartIndent
        else
          indent = stringrep(" ", indentLevel * tabWidth)
        end
        lineStartIndent = nil
        if caretComparePos and tokenPos <= caretComparePos then
          caretShift = caretShift + stringlen(indent)
        end
        result = result .. indent
      end

      if tokenType == tokens.TOKEN_LINEBREAK then
        appendToken(token, nil, tokenPos)
        lineStart = true
        lineStartIndent = nil
        suppressColor = false
      elseif tokenType == tokens.TOKEN_WHITESPACE then
        if lineStart then
          if preserveIndent then
            if lineStartIndent then
              lineStartIndent = lineStartIndent .. token
            else
              lineStartIndent = token
            end
          end
        else
          appendToken(token, nil, tokenPos)
        end
      elseif tokenType == tokens.TOKEN_KEYWORD then
        local color = colorTable[extra] or colorTable[tokenType]
        appendToken(token, color, tokenPos)
        if extra == "then" or extra == "do" or extra == "repeat" or extra == "function" or extra == "else" or extra == "elseif" then
          indentLevel = indentLevel + 1
        end
      elseif tokenType == tokens.TOKEN_COMMENT_SHORT then
        suppressColor = true
        appendToken(token, nil, tokenPos)
      elseif tokenType == tokens.TOKEN_COMMENT_LONG then
        suppressColor = true
        appendToken(token, nil, tokenPos)
        suppressColor = false
      elseif tokenType == tokens.TOKEN_STRING then
        appendToken(token, colorTable[tokenType], tokenPos)
      elseif tokenType == tokens.TOKEN_LEFTPAREN then
        -- NAG: Rainbow parenthesis colorization with proper fallback
        local color = nil
        if parenColorize then
          color = colorTable["paren_depth_" .. (parenDepth % 6)] or colorTable[token] or colorTable[tokenType]
        end
        appendToken(token, color, tokenPos)
        parenDepth = parenDepth + 1
      elseif tokenType == tokens.TOKEN_RIGHTPAREN then
        -- NAG: Rainbow parenthesis colorization (decrement first to match opening paren color)
        parenDepth = parenDepth - 1
        if parenDepth < 0 then parenDepth = 0 end
        local color = nil
        if parenColorize then
          color = colorTable["paren_depth_" .. (parenDepth % 6)] or colorTable[token] or colorTable[tokenType]
        end
        appendToken(token, color, tokenPos)
      else
        local color = colorTable[token] or colorTable[tokenType]
        appendToken(token, color, tokenPos)
      end

      if tokenType == tokens.TOKEN_LEFTWING then
        indentLevel = indentLevel + 1
      elseif tokenType == tokens.TOKEN_RIGHTWING then
        indentLevel = indentLevel - 1
        if indentLevel < 0 then
          indentLevel = 0
        end
      end

      lastTokenType = tokenType
      lastToken = token
      tokenPos = nextTokenPos
    end

    if caretPos and not newCaretPos then
      newCaretPos = caretPos + caretShift
    end

    return result, newCaretPos
  end

  -- editbox integration

  local editboxSetText
  local editboxGetText
  local enabled = {}
  local dirty = {}
  local editboxIndentCache = {}
  local decodeCache = {}
  local editboxStringCache = {}
  local editboxNumLinesCache = {}

  local function getCaretPos(editbox)
    local text = editboxGetText(editbox) or ""
    local cursorPos = editbox:GetCursorPosition()
    if cursorPos == 0 then
      return 0
    end
    if cursorPos >= stringlen(text) then
      return stringlen(text)
    end
    return cursorPos
  end

  local function setCaretPos(editbox, pos)
    editbox:SetCursorPosition(pos)
  end

  local function critical_enter(editbox)
    local script = editbox:GetScript("OnTextChanged")
    local script2 = editbox:GetScript("OnCursorChanged")
    editbox:SetScript("OnTextChanged", nil)
    editbox:SetScript("OnCursorChanged", nil)
    return script, script2
  end

  local function critical_leave(editbox, script, script2)
    editbox:SetScript("OnTextChanged", script)
    editbox:SetScript("OnCursorChanged", script2)
  end

  function lib.colorCodeEditbox(editbox)
    dirty[editbox] = nil

    local colorTable = editbox.faiap_colorTable or defaultColorTable
    local tabWidth = editbox.faiap_tabWidth or defaultTabWidth
    local options = editbox.faiap_options
    local orgCode = editboxGetText(editbox)
    local prevCode = editboxStringCache[editbox]
    if prevCode == orgCode then
      return
    end

    local pos = getCaretPos(editbox)
    local code
    code, pos = lib.stripWowColorsWithPos(orgCode, pos)

    colorTable[0] = "|r"

    local newCode, newPos = lib.indentCode(code, tabWidth, colorTable, pos, options)

    editboxStringCache[editbox] = newCode

    if code ~= newCode then
      local script, script2 = critical_enter(editbox)
      decodeCache[editbox] = nil

      local numLines = 0
      for i = 1, stringlen(newCode) do
        if stringbyte(newCode, i) == bytes.BYTE_LINEBREAK_UNIX then
          numLines = numLines + 1
        end
      end

      local stringlenNewCode = stringlen(newCode)
      editboxSetText(editbox, newCode)

      if newPos then
        if newPos < 0 then
          newPos = 0
        end
        if newPos > stringlenNewCode then
          newPos = stringlenNewCode
        end
        setCaretPos(editbox, newPos)
      end

      critical_leave(editbox, script, script2)

      if editboxNumLinesCache[editbox] ~= numLines then
        lib.indentEditbox(editbox)
      end
      editboxNumLinesCache[editbox] = numLines
    end
  end

  function lib.indentEditbox(editbox)
    dirty[editbox] = nil

    local colorTable = editbox.faiap_colorTable or defaultColorTable
    local tabWidth = editbox.faiap_tabWidth
    local options = editbox.faiap_options

    local orgCode = editboxGetText(editbox)
    local prevCode = editboxIndentCache[editbox]
    if prevCode == orgCode then
      return
    end

    local pos = getCaretPos(editbox)
    local code
    code, pos = lib.stripWowColorsWithPos(orgCode, pos)

    colorTable[0] = "|r"

    local newCode, newPos = lib.indentCode(code, tabWidth, colorTable, pos, options)

    newCode = lib.padWithLinebreaks(newCode)

    editboxIndentCache[editbox] = newCode

    if code ~= newCode then
      local script, script2 = critical_enter(editbox)
      decodeCache[editbox] = nil

      local stringlenNewCode = stringlen(newCode)
      editboxSetText(editbox, newCode)

      if newPos then
        if newPos < 0 then
          newPos = 0
        end
        if newPos > stringlenNewCode then
          newPos = stringlenNewCode
        end
        setCaretPos(editbox, newPos)
      end

      critical_leave(editbox, script, script2)
    end
  end

  local function hookHandler(editbox, handler, newFun)
    local oldFun = editbox:GetScript(handler)
    if oldFun == newFun then
      -- already hooked, ignore it
      return
    end
    editbox["faiap_old_" .. handler] = oldFun
    editbox:SetScript(handler, newFun)
  end

  local function textChangedHook(editbox, ...)
    local oldFun = editbox["faiap_old_OnTextChanged"]
    if oldFun then
      oldFun(editbox, ...)
    end
    if enabled[editbox] and not editbox:IsInIMECompositionMode() then
      dirty[editbox] = GetTime()
    end
  end

  local function tabPressedHook(editbox, ...)
    local oldFun = editbox["faiap_old_OnTabPressed"]
    if oldFun then
      oldFun(editbox, ...)
    end
    if enabled[editbox] then
      return lib.indentEditbox(editbox)
    end
  end

  local function onUpdateHook(editbox, ...)
    local oldFun = editbox["faiap_old_OnUpdate"]
    if oldFun then
      oldFun(editbox, ...)
    end
    if enabled[editbox] and not editbox:IsInIMECompositionMode() then
      local now = GetTime()
      local lastUpdate = dirty[editbox] or now
      if now - lastUpdate > 0.2 then
        decodeCache[editbox] = nil
        return lib.colorCodeEditbox(editbox)
      end
    end
  end

  local function newGetText(editbox)
    local decoded = decodeCache[editbox]
    if not decoded then
      decoded = lib.decode(editboxGetText(editbox))
      decodeCache[editbox] = decoded
    end
    return decoded or ""
  end

  local function newSetText(editbox, text)
    decodeCache[editbox] = nil
    if text then
      local encoded = lib.encode(text)
      return editboxSetText(editbox, encoded)
    end
  end

  function lib.enable(editbox, colorTable, tabWidth, options)
    if not editboxSetText then
      editboxSetText = editbox.SetText
      editboxGetText = editbox.GetText
    end

    local modified
    if editbox.faiap_colorTable ~= colorTable then
      editbox.faiap_colorTable = colorTable
      modified = true
    end
    if editbox.faiap_tabWidth ~= tabWidth then
      editbox.faiap_tabWidth = tabWidth
      modified = true
    end

    local optionsCopy = shallowCopy(options)
    if not shallowEqual(editbox.faiap_options, optionsCopy) then
      editbox.faiap_options = optionsCopy
      modified = true
    end

    if enabled[editbox] then
      if modified then
        lib.indentEditbox(editbox)
      end
      return
    end

    -- Editbox is possibly hooked, but disabled
    enabled[editbox] = true

    editbox.oldMaxBytes = editbox:GetMaxBytes()
    editbox.oldMaxLetters = editbox:GetMaxLetters()
    editbox:SetMaxBytes(0)
    editbox:SetMaxLetters(0)

    editbox.GetText = newGetText
    editbox.SetText = newSetText

    hookHandler(editbox, "OnTextChanged", textChangedHook)
    hookHandler(editbox, "OnTabPressed", tabPressedHook)
    hookHandler(editbox, "OnUpdate", onUpdateHook)

    lib.indentEditbox(editbox)
  end

  -- Deprecated
  function lib.addSmartCode(...)
    return lib.enable(...)
  end

  function lib.disable(editbox)
    if not enabled[editbox] then
      return
    end
    enabled[editbox] = nil

    -- revert settings for max bytes / letters
    editbox:SetMaxBytes(editbox.oldMaxBytes)
    editbox:SetMaxLetters(editbox.oldMaxLetters)

    -- try a real unhooking, if possible
    if editbox:GetScript("OnTextChanged") == textChangedHook then
      editbox:SetScript("OnTextChanged", editbox.faiap_old_OnTextChanged)
      editbox.faiap_old_OnTextChanged = nil
    end
    if editbox:GetScript("OnTabPressed") == tabPressedHook then
      editbox:SetScript("OnTabPressed", editbox.faiap_old_OnTabPressed)
      editbox.faiap_old_OnTabPressed = nil
    end
    if editbox:GetScript("OnUpdate") == onUpdateHook then
      editbox:SetScript("OnUpdate", editbox.faiap_old_OnUpdate)
      editbox.faiap_old_OnUpdate = nil
    end

    editbox.GetText = nil
    editbox.SetText = nil

    -- change the text back to unformatted
    editbox:SetText(newGetText(editbox))

    -- clear caches
    editboxIndentCache[editbox] = nil
    decodeCache[editbox] = nil
    editboxStringCache[editbox] = nil
    editboxNumLinesCache[editbox] = nil
  end

  defaultColorTable = {}
  lib.defaultColorTable = defaultColorTable

  defaultColorTable[tokens.TOKEN_SPECIAL] = "|c00ff99ff"
  defaultColorTable[tokens.TOKEN_KEYWORD] = "|c006666ff"
  defaultColorTable[tokens.TOKEN_COMMENT_SHORT] = "|c00999999"
  defaultColorTable[tokens.TOKEN_COMMENT_LONG] = "|c00999999"

  local stringColor = "|c00ffff77"
  defaultColorTable[tokens.TOKEN_STRING] = stringColor
  defaultColorTable[".."] = stringColor

  local tableColor = "|c00ff9900"
  defaultColorTable["..."] = tableColor
  defaultColorTable["{"] = tableColor
  defaultColorTable["}"] = tableColor
  defaultColorTable["["] = tableColor
  defaultColorTable["]"] = tableColor

  local arithmeticColor = "|c0033ff55"
  defaultColorTable[tokens.TOKEN_NUMBER] = arithmeticColor
  defaultColorTable["+"] = arithmeticColor
  defaultColorTable["-"] = arithmeticColor
  defaultColorTable["/"] = arithmeticColor
  defaultColorTable["*"] = arithmeticColor

  local logicColor1 = "|c0055ff88"
  defaultColorTable["=="] = logicColor1
  defaultColorTable["<"] = logicColor1
  defaultColorTable["<="] = logicColor1
  defaultColorTable[">"] = logicColor1
  defaultColorTable[">="] = logicColor1
  defaultColorTable["~="] = logicColor1

  local logicColor2 = "|c0088ffbb"
  defaultColorTable["and"] = logicColor2
  defaultColorTable["or"] = logicColor2
  defaultColorTable["not"] = logicColor2

  -- NAG: Rainbow parenthesis colors for matching pairs (6 colors cycling)
  -- Bright, high-contrast colors optimized for dark backgrounds
  defaultColorTable["paren_depth_0"] = "|c00FF3333"  -- Bright Red
  defaultColorTable["paren_depth_1"] = "|c0000DDFF"  -- Bright Cyan
  defaultColorTable["paren_depth_2"] = "|c00FF9933"  -- Bright Orange
  defaultColorTable["paren_depth_3"] = "|c0099FF33"  -- Bright Lime Green
  defaultColorTable["paren_depth_4"] = "|c00FFDD33"  -- Bright Yellow
  defaultColorTable["paren_depth_5"] = "|c00FF33DD"  -- Bright Magenta

  defaultColorTable[0] = "|r"
end

