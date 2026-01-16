local AddonName, Addon = ...
local Functions = Addon.Functions
local Colors = Addon.Colors

--------------------------------------------
-- GENERAL
--------------------------------------------

function Functions:Condition(Condition, If, Else)
    if Condition then return If else return Else end
end

function Functions:IsTable(Value)
    return Value and type(Value) == "table"
end

function Functions:IsBoolean(Value)
    if (Value == nil) then return false end

    Value = string.lower(tostring(Value))
    return Value == "true" or Value == "false"
end

function Functions:CountTable(Table)
    local Counter = 0
	if (not Functions:IsTable(Table)) then return Counter end

	for Key, Value in next, Table, nil do
		Counter = Counter + 1
	end
	
	return Counter
end

function Functions:IsEmptyTable(Table)
    return Functions:IsTable(Table) and Functions:CountTable(Table) == 0
end

function Functions:PrintTable(Table, Indent)
    if (not Indent) then Indent = 0 end

    for Key, Value in pairs(Table) do
        Formatting = string.rep("  ", Indent)..Key..": "
        if Functions:IsTable(Value) then
            print(Formatting)
            Functions:PrintTable(Value, Indent + 1)
        else
            print(Formatting..tostring(Value))
        end
    end
end

function Functions:Trim(Value)
    return strtrim(Value)
end

function Functions:StringContains(Haystack, Needle)
    return string.find(Haystack, Needle)
end

function Functions:StringReplace(Haystack, Search, ReplaceWith)
    ReplaceWith = Functions:Condition(ReplaceWith, ReplaceWith, "")
    local Result, Count = string.gsub(Haystack, Search, ReplaceWith)

    return Functions:Condition(Result, Result, "")
end

function Functions:Substring(Haystack, Start, End)
    return string.sub(Haystack, Start, End)
end

function Functions:Split(Haystack, Separator, Limit)
    local Result = {}
    if (not Haystack or strlen(Haystack) == 0) then return Result end

    for String in string.gmatch(Haystack, "([^"..Separator.."]+)") do
        table.insert(Result, String)
    end

    if (Limit) then
        local CountResult = Functions:CountTable(Result)
        if (CountResult > Limit) then
            for i = Limit + 1, CountResult do
                Result[Limit] = Result[Limit]..Separator..Result[i]
            end
        end
    end

    return Result
end

function Functions:StartsWith(Haystack, Needle)
    if (not Needle or strlen(Needle) == 0) then return false end

    local Substring = Functions:Substring(Haystack, 1, strlen(Needle))
    return Substring == Needle
end

--------------------------------------------
-- PRINT
--------------------------------------------

function Functions:PrintAddon(Value, Color)
	local WhichColor = "green"

    if (Color) then
        Color = string.lower(Color)

        if (Color == "error") then
            WhichColor = "red"
        else
            WhichColor = Color
        end
    end

	return print(Functions:PrintColor(AddonName..":", WhichColor).." "..Value)
end

function Functions:PrintColor(Value, Color)
    if (Functions:StringContains(Color, "#")) then
        return "|cFF"..Functions:StringReplace(Color, "#", "")..Value.."|r"
    else
        return "|cFF"..Functions:StringReplace(Colors[string.lower(Color)], "#", "")..Value.."|r"
    end
end

function Functions:PrintIcon(Icon)
    return "|T"..Icon..":0|t"
end

function Functions:PrintGold(Copper)
    return C_CurrencyInfo.GetCoinTextureString(Copper)
end



local UI = Addon.UI

function Test()
    
end
