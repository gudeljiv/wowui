-- lists.lua handles the creation, copying and soring of lists of attributes; each list is created with an
-- arbitrary name with sub-tables for the sets of attributes (attribClass,attribType,attribKey,attribValue).
-- To reduce garbage creation, sub-tables are always reused.

local _,s = ...
s.list = {}

local lists = {} -- indexed by name, an ordered list of {attribClass,attribType,attribKey,attribValue}
local sizes = {} -- indexed by name, the number of valid entries in above lists[name] of same name

-- creates a new list with the given name; note this doesn't return anything intentionally
function s.list:Create(name)
    lists[name] = {}
    sizes[name] = 0
end

-- resets the named list without removing tables to reduce garbage creation
function s.list:Reset(name)
    for k,v in ipairs(lists[name]) do
        wipe(v)
    end
    sizes[name] = 0
end

-- returns the number of occupied elements in the named list
function s.list:GetSize(name)
    return sizes[name]
end

-- returns the attributes of a list at the given index
function s.list:Get(name,index)
    if lists[name][index] then
        return lists[name][index][1],lists[name][index][2],lists[name][index][3],lists[name][index][4]
    end
end

-- returns the whole list as a table (calling function should not modify this ever)
function s.list:GetAll(name)
    return lists[name]
end

-- adds the given attributes to the list; if unique is true then it will not add attributes already added to the list
function s.list:Add(name,attribClass,attribType,attribKey,attribValue,unique)
    local list = lists[name]

    if not attribClass then
        return -- only add entries that have an attribClass at least
    end

    if unique then
        for i=1,s.list:GetSize(name) do
            local cClass,cType,cKey,cValue = s.list:Get(name,i)
            if (cClass == attribClass and cType == attribType and cKey == attribKey and cValue == attribValue) then
                return -- this entry already exists and requiring unique, leave
            end
        end
    end

    sizes[name] = sizes[name] + 1
    
    local index = sizes[name] -- putting new entry in this slot

    if not lists[name][index] then
        lists[name][index] = {} -- creating a new sub-table for this entry
    end
    -- finally, saving values
    lists[name][index][1] = attribClass
    lists[name][index][2] = attribType
    lists[name][index][3] = attribKey
    lists[name][index][4] = attribValue
end

-- removes the given search term from the list
function s.list:Remove(name,search)
    local list = lists[name]
    for i=s.list:GetSize(name),1,-1 do
        local attribClass,attribType,attribKey,attribValue = s.list:Get("results",i)
        local itemID = (attribValue or ""):match("item:(%d+)")
        if itemID then
            attribValue = GetItemInfo(itemID) or ""
        end
        if attribValue:match(search) then
            tremove(list,i)
            sizes[name] = sizes[name] - 1
        end
    end
end

-- appends the contents of source list to destination list
function s.list:AddToList(source,destination,unique)
    for i=1,s.list:GetSize(source) do
        local attribClass,attribType,attribKey,attribValue = s.list:Get(source,i)
        s.list:Add(destination,attribClass,attribType,attribKey,attribValue,unique)
    end
end

-- table.sort function for s.list:Sort() to sort list entries by their values' name
local function sortFunc(e1,e2)
    local value1 = e1[4]
    local value2 = e2[4]
    --  if the value contains an item:id, then get the cached name of the item for sorting
    local itemID1 = value1:match("item:(%d+)")
    local itemID2 = value2:match("item:(%d+)")
    if itemID1 or itemID2 then
        local cache = s.cache:Get("item")
        value1 = itemID1 and cache[tonumber(itemID1)] or "zzzz"..value1 -- if not cached, push it to end with zzzzitem:id
        value2 = itemID2 and cache[tonumber(itemID2)] or "zzzz"..value2
    end
    return value1<value2
end

-- sorts the list alphabetically by name
function s.list:Sort(name)
    -- before sorting, remove any empty entries; otherwise sort gets wonky
    -- this causes a little bit of garbage creation but in tests it's not excessive (monitor this)
    for i=#lists[name],1,-1 do
        if not lists[name][i][1] then
            lists[name][i] = nil
        end
    end
    table.sort(lists[name],sortFunc)
end

-- prints the contents of a list for debug purposes
function s.list:Debug(name,header)
    for i=1,s.list:GetSize(name) do
        local attribClass,attribType,attribKey,attribValue = s.list:Get(name,i)
        local itemID = attribValue:match("item:(%d+)")
        if itemID then -- itemIDs replaced with names for legibility; the output is not 100% the contents of the list!
            attribValue = attribValue:gsub("item:"..itemID,s.cache:Get("item")[tonumber(itemID)] or "zzzz"..attribValue)
        end
    end
end

