--- @module "StringUtil"
--- String utilities and WoW-specific formatting helpers
---
--- Provides string manipulation, hashing, color generation, and validation functions.
--- Does NOT recreate WoW's built-in string functions (strsplit, strjoin, strtrim, etc.)
--- Use WoW native functions directly when available.
---
--- Usage patterns:
--- - CoreModule: via ns.StringUtil.FunctionName()
--- - Service modules: via ns.StringUtil.FunctionName()
--- - Main addon: via ns.StringUtil.FunctionName()
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ============================ LOCALIZE ============================
local _, ns = ...

-- String operations (WoW's optimized versions - DO NOT recreate these, just localize)
local strmatch = strmatch
local strfind = strfind
local strsub = strsub
local strlower = strlower
local strtrim = strtrim        -- WoW native - trim whitespace
local format = string.format
local gsub = string.gsub
local byte = string.byte
local len = string.len
local tinsert = tinsert

-- Standard Lua functions
local type = type
local tonumber = tonumber
local select = select
local floor = math.floor
local fmod = math.fmod

-- Bit operations
local bit = bit
local band = bit.band
local bor = bit.bor
local lshift = bit.lshift
local rshift = bit.rshift

-- ============================ CONTENT ============================

--- StringUtil: Provides string manipulation and formatting utilities
local StringUtil = {}

-- ============================ STRING HASHING ============================

--- Hashes a string to a number using a simple hash algorithm
--- @param text string The text to hash
--- @return number The hash value (0 if text is nil)
function StringUtil.Hash(text)
    if not text then return 0 end
    local counter = 1
    local textLen = len(text)
    for i = 1, textLen, 3 do
        counter = fmod(counter * 8161, 4294967279) + -- 2^32 - 17: Prime!
            (byte(text, i) * 16776193) +
            ((byte(text, i + 1) or (textLen - i + 256)) * 8372226) +
            ((byte(text, i + 2) or (textLen - i + 256)) * 3932164)
    end
    return fmod(counter, 4294967291) -- 2^32 - 5: Prime (and different from the prime in the loop)
end

--- Hashes a string to a number using djb2 algorithm (better distribution)
--- @param str string The string to hash
--- @return number The hash value
function StringUtil.HashDJB2(str)
    if not str then return 0 end
    local hash = 5381
    for i = 1, #str do
        hash = (lshift(hash, 5) + hash) + byte(str, i)
        hash = band(hash, 0xFFFFFFFF) -- Ensure 32-bit
    end
    return hash
end

-- ============================ COLOR GENERATION ============================

--- Extracts RGB components from a hash value
--- @param hash number The hash value
--- @return number r Red component (0-255)
--- @return number g Green component (0-255)
--- @return number b Blue component (0-255)
function StringUtil.GetColorFromHash(hash)
    if not hash then return 255, 255, 255 end
    -- Extract RGB components using bit operations
    local r = rshift(band(hash, 0xFF0000), 16)
    local g = rshift(band(hash, 0xFF00), 8)
    local b = band(hash, 0xFF)
    return r, g, b
end

--- Generates a WoW color code from a name string
--- @param name string The name to colorize
--- @return string WoW hex color code (e.g., "|cffrrggbb")
function StringUtil.GetNameColor(name)
    if not name then return "|cffffffff" end
    local r, g, b = StringUtil.GetColorFromHash(StringUtil.Hash(name))
    return format("|cff%02x%02x%02x", r, g, b)
end

--- Maps a hash to a readable HSL color space (returns h, s, l in 0-1 range)
--- @param hash number The hash value
--- @return number h Hue (0.0-1.0)
--- @return number s Saturation (0.0-1.0)
--- @return number l Lightness (0.0-1.0)
function StringUtil.HashToHSL(hash)
    if not hash then return 0, 0, 1 end
    local h = (hash % 360) / 360 -- Hue: 0.0–1.0
    local s = 0.6                -- Saturation: 60% (readable)
    local l = 0.5                -- Lightness: 50% (readable)
    return h, s, l
end

--- Converts HSL to RGB (returns r, g, b in 0-255 range)
--- @param h number Hue (0.0-1.0)
--- @param s number Saturation (0.0-1.0)
--- @param l number Lightness (0.0-1.0)
--- @return number r Red component (0-255)
--- @return number g Green component (0-255)
--- @return number b Blue component (0-255)
function StringUtil.HSLToRGB(h, s, l)
    local function hue2rgb(p, q, t)
        if t < 0 then t = t + 1 end
        if t > 1 then t = t - 1 end
        if t < 1 / 6 then return p + (q - p) * 6 * t end
        if t < 1 / 2 then return q end
        if t < 2 / 3 then return p + (q - p) * (2 / 3 - t) * 6 end
        return p
    end

    local r, g, b
    if s == 0 then
        r, g, b = l, l, l
    else
        local q = l < 0.5 and l * (1 + s) or l + s - l * s
        local p = 2 * l - q
        r = hue2rgb(p, q, h + 1 / 3)
        g = hue2rgb(p, q, h)
        b = hue2rgb(p, q, h - 1 / 3)
    end
    return floor(r * 255), floor(g * 255), floor(b * 255)
end

--- Returns a WoW hex color code for a string, using HSL for readability
--- @param name string The name to colorize
--- @return string WoW hex color code (e.g., "|cffrrggbb")
function StringUtil.GetHSLNameColor(name)
    if not name then return "|cffffffff" end
    local hash = StringUtil.HashDJB2(name)
    local h, s, l = StringUtil.HashToHSL(hash)
    local r, g, b = StringUtil.HSLToRGB(h, s, l)
    return format("|cff%02x%02x%02x", r, g, b)
end

--- Returns a colorized string for a module name (for log output)
--- @param name string The module name
--- @return string Colorized string with reset code
function StringUtil.ColorizeModuleName(name)
    if not name then return "|cffffffffUnknown|r" end
    return StringUtil.GetHSLNameColor(name) .. name .. "|r"
end

-- ============================ WOW COLOR SYSTEM REFERENCE ============================
-- WoW provides these GLOBALLY AVAILABLE color functions:
-- - CreateColor(r, g, b, a) - Creates ColorMixin object (values 0-1 range)
-- - WrapTextInColorCode(text, hexColor) - Wraps text in color: |cAARRGGBBtext|r
-- - RGBToColorCode(r, g, b) - Converts RGB (0-1) to |cffRRGGBB format
-- - CreateColorFromHexString(hex) - From AARRGGBB hex string
-- - CreateColorFromBytes(r, g, b, a) - From 0-255 byte values
-- - GetClassColor(classFilename) - Get class color values
--
-- Use NAG's StringUtil when you need:
-- - Deterministic color generation from strings (GetHSLNameColor, GetNameColor)
-- - Auto-detection of 0-1 vs 0-255 range (Colorize)
-- - Flexible hex input handling (ColorizeHex)
-- - Color stripping/validation (StripColors, ValidateColorCode)

-- ============================ WOW FORMATTING HELPERS ============================

--- Applies RGB color to text
--- @param text string The text to colorize
--- @param r number Red component (0-1 or 0-255, auto-detected)
--- @param g number Green component (0-1 or 0-255, auto-detected)
--- @param b number Blue component (0-1 or 0-255, auto-detected)
--- @return string Colorized text with reset code
function StringUtil.Colorize(text, r, g, b)
    if not text then return "" end
    if not r or not g or not b then return text end

    -- Auto-detect if values are 0-1 or 0-255 range
    if r <= 1 and g <= 1 and b <= 1 then
        r = floor(r * 255)
        g = floor(g * 255)
        b = floor(b * 255)
    end

    return format("|cff%02x%02x%02x%s|r", r, g, b, text)
end

--- Applies hex color code to text
--- @param text string The text to colorize
--- @param hexColor string Hex color code (with or without |c prefix, e.g., "ff00ff" or "|cffff00ff")
--- @return string Colorized text with reset code
function StringUtil.ColorizeHex(text, hexColor)
    if not text then return "" end
    if not hexColor then return text end

    -- Strip any existing |c prefix and |r suffix
    hexColor = gsub(hexColor, "^|c[fF][fF]", "")
    hexColor = gsub(hexColor, "|r$", "")

    -- Ensure 6-character hex
    if len(hexColor) ~= 6 then return text end

    return format("|cff%s%s|r", hexColor, text)
end

--- Applies a WoW color code to text (handles full |cAARRGGBB format)
--- @param text string The text to colorize
--- @param colorCode string Full WoW color code (e.g., "|cffff0000")
--- @return string Colorized text with reset code
function StringUtil.ColorizeText(text, colorCode)
    if not text then return "" end
    if not colorCode then return text end

    -- Ensure color code ends without |r
    colorCode = gsub(colorCode, "|r$", "")

    return colorCode .. text .. "|r"
end

--- Strips all WoW color codes from text
--- @param text string The text to strip colors from
--- @return string Text without color codes
function StringUtil.StripColors(text)
    if not text then return "" end
    -- Remove |cAARRGGBB and |r codes
    text = gsub(text, "|c%x%x%x%x%x%x%x%x", "")
    text = gsub(text, "|r", "")
    return text
end

--- Escapes pipe characters in text (| becomes ||)
--- @param text string The text to escape
--- @return string result Text with escaped pipes
function StringUtil.EscapePipes(text)
    if not text then return "" end
    local result = gsub(text, "|", "||")
    return result
end

--- Validates a WoW color code format
--- @param colorCode string The color code to validate
--- @return boolean True if valid WoW color code format
function StringUtil.ValidateColorCode(colorCode)
    if not colorCode or type(colorCode) ~= "string" then return false end
    -- Valid formats: |cAARRGGBB or |cffRRGGBB (most common)
    return strfind(colorCode, "^|c%x%x%x%x%x%x%x%x") ~= nil
end

--- Creates a WoW texture format string
--- @param path string The texture path
--- @param width number Texture width (default: 16)
--- @param height number Texture height (default: 16)
--- @return string WoW texture format string
function StringUtil.FormatTexture(path, width, height)
    if not path then return "" end
    width = width or 16
    height = height or 16
    return format("|T%s:%d:%d|t", path, height, width)
end

-- ============================ NUMERIC STRING UTILITIES ============================

--- Cleans numeric string by removing thousand separators and parsing to number
--- @param str string The numeric string to clean (e.g., "1,234.56")
--- @return number|nil Parsed number or nil if invalid
function StringUtil.CleanNumber(str)
    if not str then return nil end
    -- Remove commas, spaces, and periods (thousand separators)
    local cleaned = gsub(gsub(gsub(str, ",", ""), " ", ""), "%.", "")
    return tonumber(cleaned, 10)
end

--- Parses a number string with validation
--- @param str string The string to parse
--- @return number|nil num Parsed number or nil if invalid
--- @return string|nil error Error message if invalid
function StringUtil.ParseNumber(str)
    if not str then
        return nil, "String cannot be nil"
    end

    local num = tonumber(str)
    if not num then
        return nil, format("Invalid number format: %s", str)
    end

    return num, nil
end

--- Formats a number with thousand separators
--- @param num number The number to format
--- @param decimals number Number of decimal places (default: 0)
--- @param separator string Thousand separator (default: ",")
--- @return string Formatted number string
function StringUtil.FormatNumber(num, decimals, separator)
    if not num then return "0" end

    decimals = decimals or 0
    separator = separator or ","

    -- Format with decimals
    local formatted = format("%." .. decimals .. "f", num)

    -- Add thousand separators
    local int, dec = strmatch(formatted, "^([^%.]+)%.?(.*)$")
    if int then
        -- Add separators from right to left
        local reversed = int:reverse()
        local withSeparators = reversed:gsub("(%d%d%d)", "%1" .. separator)
        int = withSeparators:reverse()

        -- Remove leading separator if present
        if int:sub(1, 1) == separator then
            int = int:sub(2)
        end

        if dec and dec ~= "" then
            return int .. "." .. dec
        else
            return int
        end
    end

    return formatted
end


-- ============================ STRING PARSING UTILITIES ============================

--- Parses duration strings to seconds (e.g., "2s", "1.5m", "30ms", "2h", "1d")
--- @param str string The duration string
--- @return number|nil Duration in seconds, or nil if invalid
function StringUtil.ParseDuration(str)
    if not str or type(str) ~= "string" then return nil end

    -- Match number and unit: "2s", "1.5m", "30ms", etc.
    local num, unit = strmatch(str, "^(%d+%.?%d*)([smhd]+)$")
    if not num or not unit then return nil end

    local numVal = tonumber(num)
    if not numVal then return nil end

    -- Convert to seconds based on unit
    local multiplier = 1
    unit = strlower(unit)

    if unit == "ms" then
        multiplier = 0.001
    elseif unit == "s" then
        multiplier = 1
    elseif unit == "m" then
        multiplier = 60
    elseif unit == "h" then
        multiplier = 3600
    elseif unit == "d" then
        multiplier = 86400
    else
        return nil -- Unknown unit
    end

    return numVal * multiplier
end

--- Parses percentage strings to decimal (e.g., "50%" → 0.5, "12.5%" → 0.125)
--- @param str string The percentage string
--- @return number|nil Decimal value, or nil if invalid
function StringUtil.ParsePercentage(str)
    if not str or type(str) ~= "string" then return nil end

    -- Match number followed by %: "50%", "12.5%"
    local num = strmatch(str, "^(%d+%.?%d*)%%$")
    if not num then return nil end

    local numVal = tonumber(num)
    if not numVal then return nil end

    return numVal / 100.0
end

--- Extracts first number from a string
--- @param str string The string to extract from
--- @return number|nil First number found, or nil if none
function StringUtil.ExtractNumber(str)
    if not str then return nil end

    local num = strmatch(str, "(%d+%.?%d*)")
    if num then
        return tonumber(num)
    end
    return nil
end

--- Extracts all numbers from a string
--- @param str string The string to extract from
--- @return table Array of numbers found (empty if none)
function StringUtil.ExtractNumbers(str)
    if not str then return {} end

    local numbers = {}
    for num in str:gmatch("(%d+%.?%d*)") do
        local value = tonumber(num)
        if value then
            tinsert(numbers, value)
        end
    end
    return numbers
end

--- Parses time value with unit to seconds (e.g., value=5, unit="min" → 300)
--- @param value number The time value
--- @param unit string The time unit ("min", "sec", "s", "m", "h")
--- @return number Time in seconds
function StringUtil.ParseTimeToSeconds(value, unit)
    if not value or not unit then return 0 end

    unit = strlower(unit)

    if unit:find("min") or unit == "m" then
        return value * 60
    elseif unit:find("hour") or unit == "h" then
        return value * 3600
    elseif unit:find("day") or unit == "d" then
        return value * 86400
    end

    -- Default: assume seconds
    return value
end

-- ============================ ADVANCED TRIMMING ============================

--- Trims only leading whitespace from a string
--- @param str string The string to trim
--- @return string String with leading whitespace removed
function StringUtil.TrimStart(str)
    if not str then return "" end
    local result = gsub(str, "^%s+", "")
    return result
end

--- Trims only trailing whitespace from a string
--- @param str string The string to trim
--- @return string String with trailing whitespace removed
function StringUtil.TrimEnd(str)
    if not str then return "" end
    local result = gsub(str, "%s+$", "")
    return result
end

-- ============================ VALIDATION & SANITIZATION ============================

--- Checks if a string is nil or empty
--- @param str string The string to check
--- @return boolean True if string is nil or empty
function StringUtil.IsEmpty(str)
    return not str or str == ""
end

--- Checks if a string contains only whitespace
--- @param str string The string to check
--- @return boolean True if string is only whitespace
function StringUtil.IsWhitespace(str)
    if not str then return true end
    return strmatch(str, "^%s*$") ~= nil
end

--- Trims leading and trailing characters from a string (wrapper for strtrim with validation)
--- @param str string The string to trim
--- @param chars string Optional characters to trim (default: whitespace)
--- @return string Trimmed string
function StringUtil.Trim(str, chars)
    if not str then return "" end
    -- Use WoW's native strtrim for whitespace
    if not chars then
        return strtrim(str)
    end
    -- Custom character trimming
    local pattern = "^[" .. chars .. "]*(.-)[" .. chars .. "]*$"
    return (strmatch(str, pattern))
end

--- Truncates a string with ellipsis if it exceeds max length
--- @param str string The string to truncate
--- @param maxLen number Maximum length (default: 50)
--- @param ellipsis string Ellipsis string (default: "...")
--- @return string Truncated string
function StringUtil.TruncateWithEllipsis(str, maxLen, ellipsis)
    if not str then return "" end
    maxLen = maxLen or 50
    ellipsis = ellipsis or "..."

    if len(str) <= maxLen then
        return str
    end

    return strsub(str, 1, maxLen - len(ellipsis)) .. ellipsis
end

--- Validates string length against min/max constraints
--- @param str string The string to validate
--- @param minLen number Minimum length (optional)
--- @param maxLen number Maximum length (optional)
--- @return boolean valid True if valid
--- @return string? error Error message if invalid
function StringUtil.ValidateLength(str, minLen, maxLen)
    if not str then
        if minLen and minLen > 0 then
            return false, "String cannot be nil or empty"
        end
        -- Explicitly return two values for linter
        ---@diagnostic disable-next-line: redundant-return-value
        return true, nil
    end

    local strLen = len(str)

    if minLen and strLen < minLen then
        return false, format("String too short (min: %d, got: %d)", minLen, strLen)
    end

    if maxLen and strLen > maxLen then
        return false, format("String too long (max: %d, got: %d)", maxLen, strLen)
    end

    -- Explicitly return two values for linter
    ---@diagnostic disable-next-line: redundant-return-value
    return true, nil
end

--- Sanitizes user input by removing potentially dangerous characters
--- @param str string The string to sanitize
--- @return string Sanitized string
function StringUtil.SanitizeInput(str)
    if not str then return "" end
    -- Remove control characters and potentially dangerous sequences
    str = gsub(str, "%c", "") -- Remove control characters
    str = gsub(str, "|T", "") -- Remove texture codes
    str = gsub(str, "|H", "") -- Remove hyperlinks
    return str
end

--- Escapes Lua pattern special characters in a string
--- @param str string The string to escape
--- @return string String with escaped pattern characters
function StringUtil.EscapePattern(str)
    if not str then return "" end
    -- Escape magic characters: ^$()%.[]*+-?
    return (gsub(str, "[%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%1"))
end

-- ============================ BATTLE.NET HELPERS ============================

--- Gets the current player's Battle.net tag
--- @return string Battle tag (empty string if not available)
function StringUtil.GetBattleTag()
    if not BNGetInfo then return "" end
    local battleTag = select(2, BNGetInfo())
    return battleTag or ""
end

--- Builds the canonical identifier used for license key hashing from a BattleTag.
--- IMPORTANT: Includes the discriminator (numbers after '#') when present.
--- Mirrors the Discord bot logic:
---   - name_clean = uppercase alnum-only name portion
---   - discr_clean = digits-only discriminator portion
---   - if name_clean length <= 2 and discr_clean exists, use name_clean = discr_clean
---   - identifier = name_clean .. "#" .. discr_clean if discr_clean exists, else name_clean
--- @param battleTag string|nil Raw Battle.net tag (e.g., "Name#1234")
--- @return string identifier Canonical identifier for hashing (empty string if invalid/unavailable)
function StringUtil.GetBattleTagKeyIdentifier(battleTag)
    if not battleTag or type(battleTag) ~= "string" then
        return ""
    end

    local raw = battleTag:gsub("^%s+", ""):gsub("%s+$", "")
    if raw == "" then
        return ""
    end

    local namePart = raw
    local discrPart = ""

    local hashPos = raw:find("#", 1, true)
    if hashPos then
        namePart = raw:sub(1, hashPos - 1)
        discrPart = raw:sub(hashPos + 1)
    end

    -- Match bot behavior: allow only A-Z / 0-9 (no underscore).
    local nameClean = namePart:gsub("[^%d%a]", ""):upper()
    local discrClean = discrPart:gsub("[^%d]", "")

    if #nameClean <= 2 and discrClean ~= "" then
        -- Legacy fallback for very short/unsupported names
        nameClean = discrClean
    end

    if discrClean ~= "" then
        return nameClean .. "#" .. discrClean
    end

    return nameClean
end

--- Extracts the name portion from a Battle.net tag
--- @param battleTag string|number The Battle.net tag (e.g., "Name#1234")
--- @return string name The name portion (empty string if invalid)
function StringUtil.GetBattleTagName(battleTag)
    if not battleTag or type(battleTag) ~= "string" then
        return ""
    end

    local name = strmatch(battleTag, "([^#]+)")
    if not name then return "" end

    name = gsub(name, "[^%w]", "")
    if len(name) <= 2 then
        local after_hash = strmatch(battleTag, "#(.+)")
        if after_hash then return after_hash end
    end
    return name
end

-- ============================ MODULE EXPORTS ============================

-- Expose StringUtil on namespace
ns.StringUtil = StringUtil

