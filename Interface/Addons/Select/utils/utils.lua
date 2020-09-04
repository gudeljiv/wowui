-- util.lua contains miscellaneous utility functions used throughout the addon

local _,s = ...
s.utils = {}

-- for deDE and ruRU clients, we can't use [Tt][Hh][Ii][Ss] type of matching
local useAlternateCaseInsensitivity = (GetLocale()=="deDE" or GetLocale()=="ruRU")

-- for s.utils:Debug(debugTYpe,...), the debugTypes that are enabled
local debugs = {
    event = false,
    func = false,
    create = false,
    flyout = false,
    list = false,
    attrib = false,
    init = false,
    fill = false,
    profile = false,
}

-- converts a string to a case-insensitive pattern: "Hello" -> "[Hh][Ee][Ll][Ll][Oo]"
function s.utils:GetCaseInsensitive(text)
    if useAlternateCaseInsensitivity then
        return text
    elseif text then
        return (text:gsub("%a",function(a) return "["..a:upper()..a:lower().."]" end))
	end
end

-- returns a string with "magic characters" escaped, for a literal gsub
function s.utils:GetEscapedText(text)
	return (text:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", function(c) return "%"..c end))
end

-- prints debug of the given type, if that type is enabled in table above
-- eg. s.utils:Debug("event",event.." just triggered")
function s.utils:Debug(debugType,...)
    if debugType and debugs[debugType] then
        print(...)
    end
end

-- use this to the 4 attributes in buttons, flyouts, menus and actions
function s.utils:SetAttributes(button,attribClass,attribType,attribKey,attribValue)
    button:SetAttribute("attribClass",attribClass)
    button:SetAttribute("attribType",attribType)
    button:SetAttribute("attribKey",attribKey)
    button:SetAttribute("attribValue",attribValue)
end

-- returns the four attributes of a button
function s.utils:GetAttributes(button)
    return button:GetAttribute("attribClass"),
            button:GetAttribute("attribType"),
            button:GetAttribute("attribKey"),
            button:GetAttribute("attribValue")
end

-- copies attributes from one secure frame to another
function s.utils:CopyAttributes(source,dest)
    dest:SetAttribute("attribClass",source:GetAttribute("attribClass"))
    dest:SetAttribute("attribType",source:GetAttribute("attribType"))
    dest:SetAttribute("attribKey",source:GetAttribute("attribKey"))
    dest:SetAttribute("attribValue",source:GetAttribute("attribValue"))
end

-- runs func for each ...
function s.utils:RunForEach(func,...)
	for i=1,select("#",...) do
		func((select(i,...)))
	end
end

function s.utils:GetTableSize(table)
    local c = 0
    for k,v in pairs(table) do
        c=c+1
    end
    return c
end
