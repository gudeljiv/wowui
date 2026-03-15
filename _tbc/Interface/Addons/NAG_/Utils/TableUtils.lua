--- @module "TableUtils"
--- Shared utility for table operations and missing Lua 5.1 functions
---
--- Provides unified table utility functions that can be used by:
--- - CoreModule (regular modules) - via ns.TableUtils.FunctionName()
--- - NAG (main addon) - via ns.TableUtils functions
--- - Service modules (non-CoreModule) - via ns.TableUtils functions
--- - Any other module or service
---
--- This ensures consistent behavior and interface across the entire codebase
--- while providing missing Lua 5.1 functionality that's available in newer versions.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ============================ LOCALIZE ============================
local _, ns = ...
local tinsert = tinsert
local tremove = tremove
local wipe = wipe
local tContains = tContains
local concat = table.concat
local sort = sort
local removemulti = removemulti

-- Standard Lua functions
local type = type
local tostring = tostring
local pairs = pairs
local ipairs = ipairs
local select = select
local math = math

-- ============================ CONTENT ============================

-- Debug flag to control logging (set to false to disable debug output)
local DEBUG_TABLE_UTILS = false

-- Debug: Track loading order
if DEBUG_TABLE_UTILS then
    print("|cff00ff00[NAG TableUtils] TableUtils module loading...|r")
    print("|cff00ff00[NAG TableUtils] Current stack:|r")
    print(debugstack(1, 3, 0))
end

--- TableUtils: Provides unified table utility functions
local TableUtils = {}

-- ============================ WOW-OPTIMIZED TABLE FUNCTIONS ============================

--- Concatenates table elements to a string (WoW-optimized)
--- @param t table The table to concatenate
--- @param sep string Separator string (default: "")
--- @param i number Start index (default: 1)
--- @param j number End index (default: #t)
--- @return string Concatenated string
function TableUtils.Concat(t, sep, i, j)
    if not t or type(t) ~= "table" then
        return ""
    end
    return concat(t, sep, i, j)
end

--- Sorts a table in-place (WoW-optimized)
--- @param t table The table to sort
--- @param comp function Optional comparison function
function TableUtils.Sort(t, comp)
    if not t or type(t) ~= "table" then
        return
    end
    sort(t, comp)
end

--- Removes multiple elements from a table (WoW-specific)
--- @param t table The table to remove from
--- @param pos number Starting position (default: #t)
--- @param count number Number of elements to remove (default: 1)
function TableUtils.RemoveMulti(t, pos, count)
    if not t or type(t) ~= "table" then
        return
    end
    removemulti(t, pos, count)
end

--- Checks if a table contains a value (WoW-optimized)
--- @param t table The table to check
--- @param value any The value to find
--- @return boolean True if the value is found, false otherwise
function TableUtils.Contains(t, value)
    if not t or type(t) ~= "table" then
        return false
    end
    return tContains(t, value)
end

--- Inserts a value into a table (WoW-optimized)
--- @param t table The table to insert into
--- @param pos number Position to insert at (optional)
--- @param value any The value to insert
function TableUtils.Insert(t, pos, value)
    if not t or type(t) ~= "table" then
        return
    end
    if value == nil then
        value = pos
        pos = nil
    end

    if pos then
        tinsert(t, pos, value)
    else
        tinsert(t, value)
    end
end

--- Removes and returns an element from a table (WoW-optimized)
--- @param t table The table to remove from
--- @param pos number Position to remove from (default: #t)
--- @return any The removed value
function TableUtils.Remove(t, pos)
    if not t or type(t) ~= "table" then
        return nil
    end
    return tremove(t, pos)
end

--- Clears a table (WoW-optimized)
--- @param t table The table to clear
function TableUtils.Clear(t)
    if not t or type(t) ~= "table" then
        return
    end
    wipe(t)
end

-- ============================ MISSING LUA 5.1 FUNCTIONS ============================

--- Gets all keys from a table (Lua 5.4+ table.keys equivalent)
--- @param t table The table to get keys from
--- @return table Array of keys as strings
function TableUtils.Keys(t)
    if not t or type(t) ~= "table" then
        return {}
    end

    local keys = {}
    for key, _ in pairs(t) do
        tinsert(keys, tostring(key))
    end
    return keys
end

--- Gets all values from a table (Lua 5.4+ table.values equivalent)
--- @param t table The table to get values from
--- @return table Array of values
function TableUtils.Values(t)
    if not t or type(t) ~= "table" then
        return {}
    end

    local values = {}
    for _, value in pairs(t) do
        tinsert(values, value)
    end
    return values
end

--- Gets the size of a table (Lua 5.4+ table.size equivalent)
--- @param t table The table to get size of
--- @return number The number of key-value pairs in the table
function TableUtils.Size(t)
    if not t or type(t) ~= "table" then
        return 0
    end

    local count = 0
    for _ in pairs(t) do
        count = count + 1
    end
    return count
end

--- Gets the length of a table (Lua 5.4+ table.length equivalent)
--- @param t table The table to get length of
--- @return number The length of the table (number of consecutive numeric keys)
function TableUtils.Length(t)
    if not t or type(t) ~= "table" then
        return 0
    end

    return #t
end

--- Checks if a table is empty (Lua 5.4+ table.isempty equivalent)
--- @param t table The table to check
--- @return boolean True if the table is empty, false otherwise
function TableUtils.IsEmpty(t)
    if not t or type(t) ~= "table" then
        return true
    end

    return next(t) == nil
end

--- Creates a shallow copy of a table
--- @param t table The table to copy
--- @return table A shallow copy of the table
function TableUtils.Copy(t)
    if not t or type(t) ~= "table" then
        return t
    end

    local copy = {}
    for key, value in pairs(t) do
        copy[key] = value
    end

    return copy
end

--- Creates a deep copy of a table
--- @param t table The table to deep clone
--- @param visited table Internal use for circular reference detection
--- @return table A deep copy of the table
function TableUtils.DeepClone(t, visited)
    if not t or type(t) ~= "table" then
        return t
    end

    visited = visited or {}
    if visited[t] then
        return visited[t] -- Return existing copy to prevent circular references
    end

    local copy = {}
    visited[t] = copy

    for key, value in pairs(t) do
        if type(value) == "table" then
            copy[key] = TableUtils.DeepClone(value, visited)
        else
            copy[key] = value
        end
    end

    return copy
end

--- Fast deep clone for non-circular tables (no visited tracking overhead)
--- Use this when you know the table has no circular references
--- Performance: ~40% faster than DeepClone for typical data structures
--- @param t table The table to clone
--- @return table|any The cloned table or the original value if not a table
function TableUtils.FastDeepClone(t)
    if type(t) ~= "table" then
        return t
    end

    -- Stack-based iteration avoids recursive function call overhead
    local copy = {}
    local stack = {{orig = t, copy = copy}}
    local stackSize = 1

    while stackSize > 0 do
        local current = stack[stackSize]
        stackSize = stackSize - 1

        for k, v in pairs(current.orig) do
            if type(v) == "table" then
                local newCopy = {}
                current.copy[k] = newCopy
                stackSize = stackSize + 1
                stack[stackSize] = {orig = v, copy = newCopy}
            else
                current.copy[k] = v
            end
        end
    end

    return copy
end

--- Merges multiple tables into the first table
--- @param target table The target table to merge into
--- @param ... table Variable number of source tables to merge
--- @return table The merged target table
function TableUtils.Merge(target, ...)
    if not target or type(target) ~= "table" then
        target = {}
    end

    for i = 1, select("#", ...) do
        local source = select(i, ...)
        if source and type(source) == "table" then
            for key, value in pairs(source) do
                target[key] = value
            end
        end
    end

    return target
end

--- Merges multiple tables into a new table (doesn't modify original)
--- @param ... table Variable number of tables to merge
--- @return table A new table containing all merged data
function TableUtils.MergeNew(...)
    local result = {}
    return TableUtils.Merge(result, ...)
end

--- Deep merge that overwrites existing values
--- @param target table The target table to merge into
--- @param source table The source table with values
--- @return table The merged target table
function TableUtils.DeepMerge(target, source)
    if not target or type(target) ~= "table" then
        target = {}
    end

    if not source or type(source) ~= "table" then
        return target
    end

    for key, value in pairs(source) do
        if type(value) == "table" and type(target[key]) == "table" then
            -- Recursively merge nested tables
            target[key] = TableUtils.DeepMerge(target[key], value)
        else
            -- Always overwrite existing values
            target[key] = value
        end
    end

    return target
end

--- Deep merge that preserves existing values (perfect for settings/defaults)
--- @param target table The target table to merge into
--- @param source table The source table with defaults
--- @return table The merged target table
function TableUtils.DeepMergePreserve(target, source)
    if not target or type(target) ~= "table" then
        target = {}
    end

    if not source or type(source) ~= "table" then
        return target
    end

    for key, value in pairs(source) do
        if type(value) == "table" and type(target[key]) == "table" then
            -- Recursively merge nested tables
            target[key] = TableUtils.DeepMergePreserve(target[key], value)
        elseif target[key] == nil then
            -- Only set if the key doesn't exist (preserve user settings)
            target[key] = value
        end
    end

    return target
end

--- Deep merge that creates a new table (doesn't modify original)
--- @param ... table Variable number of tables to merge
--- @return table A new table containing all merged data
function TableUtils.DeepMergeNew(...)
    local result = {}
    for i = 1, select("#", ...) do
        local source = select(i, ...)
        if source and type(source) == "table" then
            result = TableUtils.DeepMerge(result, source)
        end
    end
    return result
end

--- Generic table merge with options
--- @param target table The target table to merge into
--- @param source table The source table with values
--- @param options? table Merge options
--- @return table The merged target table
function TableUtils.MergeWithOptions(target, source, options)
    if not target or type(target) ~= "table" then
        target = {}
    end

    if not source or type(source) ~= "table" then
        return target
    end

    options = options or {}
    local deep = options.deep ~= false -- Default to true
    local preserveExisting = options.preserveExisting ~= false -- Default to true

    for key, value in pairs(source) do
        if deep and type(value) == "table" and type(target[key]) == "table" then
            -- Recursively merge nested tables
            target[key] = TableUtils.MergeWithOptions(target[key], value, options)
        elseif not deep and type(value) == "table" or not preserveExisting or target[key] == nil then
            -- When deep=false, always copy table references directly
            -- Or set value based on preserveExisting option for non-table values
            target[key] = value
        end
    end

    return target
end

--- Smart merge that intelligently handles table conflicts
--- @param target table The target table to merge into
--- @param source table The source table with values
--- @param options? table Merge options
--- @return table The merged target table
function TableUtils.SmartMerge(target, source, options)
    if not target or type(target) ~= "table" then
        target = {}
    end

    if not source or type(source) ~= "table" then
        return target
    end

    options = options or {}
    local mergeStrategy = options.mergeStrategy or "smart"
    local conflictResolution = options.conflictResolution or "merge"
    local allowNesting = options.allowNesting ~= false -- Default to true

    for key, value in pairs(source) do
        local targetValue = target[key]

        if type(value) == "table" and type(targetValue) == "table" then
            -- Both are tables - need to decide how to merge
            if mergeStrategy == "smart" then
                -- Smart strategy: Check if this looks like a data structure conflict
                local isDataStructure = TableUtils.IsDataStructure(value)
                local isTargetDataStructure = TableUtils.IsDataStructure(targetValue)

                if isDataStructure and isTargetDataStructure or conflictResolution == "merge" or conflictResolution == "preserve" then
                    -- Both are data structures - merge them
                    -- Or merge nested tables - use same options for nested merge
                    -- Or preserve existing nested table but add new keys
                    target[key] = TableUtils.SmartMerge(targetValue, value, options)
                elseif conflictResolution == "overwrite" then
                    -- Overwrite with new table
                    target[key] = TableUtils.DeepClone(value)
                end
            elseif mergeStrategy == "deep" then
                -- Always deep merge
                target[key] = TableUtils.SmartMerge(targetValue, value, options)
            elseif mergeStrategy == "shallow" then
                -- Always overwrite with table reference (not deep clone)
                target[key] = value
            end
        else
            -- One or both are not tables - apply conflict resolution directly
            if conflictResolution == "merge" or conflictResolution == "overwrite" then
                -- For merge strategy, we should overwrite existing values
                -- Or always overwrite
                target[key] = value
            elseif conflictResolution == "preserve" then
                -- Only set if target doesn't exist
                if targetValue == nil then
                    target[key] = value
                end
            end
        end
    end

    return target
end

--- Checks if a table looks like a data structure (has numeric keys or specific patterns)
--- @param t table The table to check
--- @return boolean True if it appears to be a data structure
function TableUtils.IsDataStructure(t)
    if not t or type(t) ~= "table" then
        return false
    end

    local keyCount = 0
    local hasNumericKeys = false
    local hasStringKeys = false
    local maxNumericKey = 0
    local minNumericKey = math.huge

    for key, _ in pairs(t) do
        keyCount = keyCount + 1

        if type(key) == "number" then
            hasNumericKeys = true
            maxNumericKey = math.max(maxNumericKey, key)
            minNumericKey = math.min(minNumericKey, key)
        elseif type(key) == "string" then
            hasStringKeys = true
        end
    end

    -- If it has many keys (>10), likely a data structure
    if keyCount > 10 then
        return true
    end

    -- If it has both numeric and string keys, likely a data structure
    if hasNumericKeys and hasStringKeys then
        return true
    end

    -- If it has only numeric keys, check if they're sparse or large
    if hasNumericKeys and not hasStringKeys then
        -- If max key is much larger than count, likely a data structure
        if maxNumericKey > keyCount * 2 or maxNumericKey > 100 then
            return true
        end

        -- If keys are not starting from 1 or have gaps, likely a data structure
        if minNumericKey > 1 or (maxNumericKey - minNumericKey + 1) > keyCount then
            return true
        end
    end

    -- Small arrays with consecutive numeric keys starting from 1 are not data structures
    -- Regular objects with string keys are not data structures
    return false
end

-- ============================ COMMON TABLE OPERATIONS ============================

--- Finds the first key that matches a predicate function
--- @param t table The table to search
--- @param predicate function Function that takes (key, value) and returns boolean
--- @return any The first key that matches, or nil if none found
function TableUtils.FindKey(t, predicate)
    if not t or type(t) ~= "table" or type(predicate) ~= "function" then
        return nil
    end

    for key, value in pairs(t) do
        if predicate(key, value) then
            return key
        end
    end

    return nil
end

--- Finds the first value that matches a predicate function
--- @param t table The table to search
--- @param predicate function Function that takes (key, value) and returns boolean
--- @return any The first value that matches, or nil if none found
function TableUtils.FindValue(t, predicate)
    if not t or type(t) ~= "table" or type(predicate) ~= "function" then
        return nil
    end

    for key, value in pairs(t) do
        if predicate(key, value) then
            return value
        end
    end

    return nil
end

--- Filters a table based on a predicate function
--- @param t table The table to filter
--- @param predicate function Function that takes (key, value) and returns boolean
--- @return table A new table containing only matching key-value pairs
function TableUtils.Filter(t, predicate)
    if not t or type(t) ~= "table" or type(predicate) ~= "function" then
        return {}
    end

    local result = {}
    -- Check if it's an array (has consecutive numeric keys starting from 1)
    local isArray = true
    for i = 1, #t do
        if t[i] == nil then
            isArray = false
            break
        end
    end

    if isArray then
        -- For arrays, maintain array structure
        for i = 1, #t do
            if predicate(i, t[i]) then
                tinsert(result, t[i])
            end
        end
    else
        -- For regular tables, preserve keys
        for key, value in pairs(t) do
            if predicate(key, value) then
                result[key] = value
            end
        end
    end

    return result
end

--- Maps a table using a transform function
--- @param t table The table to map
--- @param transform function Function that takes (key, value) and returns new value
--- @return table A new table with transformed values
function TableUtils.Map(t, transform)
    if not t or type(t) ~= "table" or type(transform) ~= "function" then
        return {}
    end

    local result = {}
    for key, value in pairs(t) do
        result[key] = transform(key, value)
    end

    return result
end

--- Reduces a table using a reducer function
--- @param t table The table to reduce
--- @param reducer function Function that takes (accumulator, key, value) and returns new accumulator
--- @param initial any The initial value for the accumulator
--- @return any The final accumulator value
function TableUtils.Reduce(t, reducer, initial)
    if not t or type(t) ~= "table" or type(reducer) ~= "function" then
        return initial
    end

    local accumulator = initial
    for key, value in pairs(t) do
        accumulator = reducer(accumulator, key, value)
    end

    return accumulator
end

--- Checks if all key-value pairs in a table match a predicate
--- @param t table The table to check
--- @param predicate function Function that takes (key, value) and returns boolean
--- @return boolean True if all pairs match, false otherwise
function TableUtils.All(t, predicate)
    if not t or type(t) ~= "table" or type(predicate) ~= "function" then
        return false
    end

    for key, value in pairs(t) do
        if not predicate(key, value) then
            return false
        end
    end

    return true
end

--- Checks if any key-value pair in a table matches a predicate
--- @param t table The table to check
--- @param predicate function Function that takes (key, value) and returns boolean
--- @return boolean True if any pair matches, false otherwise
function TableUtils.Any(t, predicate)
    if not t or type(t) ~= "table" or type(predicate) ~= "function" then
        return false
    end

    for key, value in pairs(t) do
        if predicate(key, value) then
            return true
        end
    end

    return false
end

--- Counts the number of key-value pairs that match a predicate
--- @param t table The table to count
--- @param predicate function Function that takes (key, value) and returns boolean
--- @return number The count of matching pairs
function TableUtils.Count(t, predicate)
    if not t or type(t) ~= "table" or type(predicate) ~= "function" then
        return 0
    end

    local count = 0
    for key, value in pairs(t) do
        if predicate(key, value) then
            count = count + 1
        end
    end

    return count
end

-- ============================ ARRAY-SPECIFIC OPERATIONS ============================

--- Finds the index of a value in an array
--- @param t table The array to search
--- @param value any The value to find
--- @return number|nil The index of the value, or nil if not found
function TableUtils.IndexOf(t, value)
    if not t or type(t) ~= "table" then
        return nil
    end

    for i = 1, #t do
        if t[i] == value then
            return i
        end
    end

    return nil
end

--- Removes all elements from an array that match a predicate
--- @param t table The array to filter
--- @param predicate function Function that takes (index, value) and returns boolean
--- @return table A new array without matching elements
function TableUtils.RemoveIf(t, predicate)
    if not t or type(t) ~= "table" or type(predicate) ~= "function" then
        return {}
    end

    local result = {}
    for i = 1, #t do
        if not predicate(i, t[i]) then
            tinsert(result, t[i])
        end
    end

    return result
end

--- Removes duplicate values from an array
--- @param t table The array to deduplicate
--- @return table A new array with duplicates removed
function TableUtils.Unique(t)
    if not t or type(t) ~= "table" then
        return {}
    end

    local seen = {}
    local result = {}

    for i = 1, #t do
        local value = t[i]
        if not seen[value] then
            seen[value] = true
            tinsert(result, value)
        end
    end

    return result
end

--- Flattens a nested array structure
--- @param t table The array to flatten
--- @param depth number Maximum depth to flatten (default: 1)
--- @return table A flattened array
function TableUtils.Flatten(t, depth)
    if not t or type(t) ~= "table" then
        return {}
    end

    depth = depth or 1
    local result = {}

    for i = 1, #t do
        local value = t[i]
        if type(value) == "table" and depth > 0 then
            local flattened = TableUtils.Flatten(value, depth - 1)
            for j = 1, #flattened do
                tinsert(result, flattened[j])
            end
        else
            tinsert(result, value)
        end
    end

    return result
end

--- Reverses an array
--- @param t table The array to reverse
--- @return table A new array with elements in reverse order
function TableUtils.Reverse(t)
    if not t or type(t) ~= "table" then
        return {}
    end

    local result = {}
    for i = #t, 1, -1 do
        tinsert(result, t[i])
    end

    return result
end

--- Gets a slice of an array
--- @param t table The array to slice
--- @param start number Starting index (default: 1)
--- @param finish number Ending index (default: #t)
--- @return table A new array containing the slice
function TableUtils.Slice(t, start, finish)
    if not t or type(t) ~= "table" then
        return {}
    end

    start = start or 1
    finish = finish or #t

    -- Handle negative indices
    if start < 0 then start = #t + start + 1 end
    if finish < 0 then finish = #t + finish + 1 end

    -- Clamp to valid range
    start = math.max(1, math.min(start, #t))
    finish = math.max(1, math.min(finish, #t))

    local result = {}
    for i = start, finish do
        tinsert(result, t[i])
    end

    return result
end

-- ============================ UTILITY FUNCTIONS ============================

--- Creates a table with default values for missing keys
--- @param t table The table to add defaults to
--- @param defaults table The default values
--- @return table The table with defaults applied
function TableUtils.WithDefaults(t, defaults)
    if not t or type(t) ~= "table" then
        t = {}
    end

    if not defaults or type(defaults) ~= "table" then
        return t
    end

    for key, defaultValue in pairs(defaults) do
        if t[key] == nil then
            t[key] = defaultValue
        end
    end

    return t
end

--- Creates a table from an array of key-value pairs
--- @param pairs table Array of {key, value} pairs
--- @return table A table constructed from the pairs
function TableUtils.FromPairs(pairs)
    if not pairs or type(pairs) ~= "table" then
        return {}
    end

    local result = {}
    for i = 1, #pairs do
        local pair = pairs[i]
        if type(pair) == "table" and pair[1] and pair[2] then
            result[pair[1]] = pair[2]
        end
    end

    return result
end

--- Converts a table to an array of key-value pairs
--- @param t table The table to convert
--- @return table Array of {key, value} pairs
function TableUtils.ToPairs(t)
    if not t or type(t) ~= "table" then
        return {}
    end

    local result = {}
    for key, value in pairs(t) do
        tinsert(result, {key, value})
    end

    return result
end

--- Gets a nested value from a table using dot notation
--- @param t table The table to navigate
--- @param path string Dot-separated path (e.g., "a.b.c")
--- @param defaultValue any Default value if path not found
--- @return any The value at the path, or defaultValue
function TableUtils.GetNested(t, path, defaultValue)
    if not t or type(t) ~= "table" or not path or type(path) ~= "string" then
        return defaultValue
    end

    local current = t
    for key in path:gmatch("[^%.]+") do
        if type(current) == "table" and current[key] ~= nil then
            current = current[key]
        else
            return defaultValue
        end
    end

    return current
end

--- Sets a nested value in a table using dot notation
--- @param t table The table to modify
--- @param path string Dot-separated path (e.g., "a.b.c")
--- @param value any The value to set
--- @return boolean True if successful, false otherwise
function TableUtils.SetNested(t, path, value)
    if not t or type(t) ~= "table" or not path or type(path) ~= "string" then
        return false
    end

    local current = t
    local keys = {}
    for key in path:gmatch("[^%.]+") do
        tinsert(keys, key)
    end

    -- Navigate to the parent of the final key
    for i = 1, #keys - 1 do
        local key = keys[i]
        if type(current) ~= "table" or current[key] == nil then
            current[key] = {}
        end
        current = current[key]
    end

    -- Set the final value
    if #keys > 0 then
        current[keys[#keys]] = value
        return true
    end

    return false
end

-- ============================ ADDITIONAL UTILITY FUNCTIONS ============================

--- Creates a table with a specific size filled with a default value
--- @param size number The size of the table to create
--- @param defaultValue any The default value to fill the table with
--- @return table A new table with the specified size and default values
function TableUtils.CreateFilled(size, defaultValue)
    if not size or type(size) ~= "number" or size < 0 then
        return {}
    end

    local result = {}
    for i = 1, size do
        result[i] = defaultValue
    end
    return result
end

--- Creates a table with sequential numbers from start to finish
--- @param start number Starting number (default: 1)
--- @param finish number Ending number
--- @param step number Step size (default: 1)
--- @return table A new table with sequential numbers
function TableUtils.Range(start, finish, step)
    if not finish or type(finish) ~= "number" then
        return {}
    end

    start = start or 1
    step = step or 1

    local result = {}
    local count = 1
    for i = start, finish, step do
        result[count] = i
        count = count + 1
    end
    return result
end

--- Shuffles a table in-place using Fisher-Yates algorithm
--- @param t table The table to shuffle
function TableUtils.Shuffle(t)
    if not t or type(t) ~= "table" then
        return
    end

    local n = #t
    for i = n, 2, -1 do
        local j = math.random(i)
        t[i], t[j] = t[j], t[i]
    end
end

--- Gets a random element from a table
--- @param t table The table to get a random element from
--- @return any A random element from the table, or nil if empty
function TableUtils.RandomElement(t)
    if not t or type(t) ~= "table" or #t == 0 then
        return nil
    end

    return t[math.random(#t)]
end

--- Removes all occurrences of a value from a table
--- @param t table The table to remove from
--- @param value any The value to remove
--- @return number The number of elements removed
function TableUtils.RemoveAll(t, value)
    if not t or type(t) ~= "table" then
        return 0
    end

    local removed = 0
    for i = #t, 1, -1 do
        if t[i] == value then
            tremove(t, i)
            removed = removed + 1
        end
    end
    return removed
end

--- Removes the first occurrence of a value from a table
--- @param t table The table to remove from
--- @param value any The value to remove
--- @return boolean True if the value was found and removed, false otherwise
function TableUtils.RemoveFirst(t, value)
    if not t or type(t) ~= "table" then
        return false
    end

    for i = 1, #t do
        if t[i] == value then
            tremove(t, i)
            return true
        end
    end
    return false
end

--- Checks if two tables have the same content (shallow comparison)
--- @param t1 table First table
--- @param t2 table Second table
--- @return boolean True if tables have the same content, false otherwise
function TableUtils.Equals(t1, t2)
    if type(t1) ~= "table" or type(t2) ~= "table" then
        return t1 == t2
    end

    if #t1 ~= #t2 then
        return false
    end

    for i = 1, #t1 do
        if t1[i] ~= t2[i] then
            return false
        end
    end

    return true
end

--- Gets the maximum value in a table
--- @param t table The table to find the maximum in
--- @return any The maximum value, or nil if table is empty
function TableUtils.Max(t)
    if not t or type(t) ~= "table" or #t == 0 then
        return nil
    end

    local max = t[1]
    for i = 2, #t do
        if t[i] > max then
            max = t[i]
        end
    end
    return max
end

--- Gets the minimum value in a table
--- @param t table The table to find the minimum in
--- @return any The minimum value, or nil if table is empty
function TableUtils.Min(t)
    if not t or type(t) ~= "table" or #t == 0 then
        return nil
    end

    local min = t[1]
    for i = 2, #t do
        if t[i] < min then
            min = t[i]
        end
    end
    return min
end

--- Gets the sum of all numeric values in a table
--- @param t table The table to sum
--- @return number The sum of all numeric values, or 0 if no numeric values
function TableUtils.Sum(t)
    if not t or type(t) ~= "table" then
        return 0
    end

    local sum = 0
    for i = 1, #t do
        if type(t[i]) == "number" then
            sum = sum + t[i]
        end
    end
    return sum
end

--- Gets the average of all numeric values in a table
--- @param t table The table to average
--- @return number The average of all numeric values, or 0 if no numeric values
function TableUtils.Average(t)
    if not t or type(t) ~= "table" then
        return 0
    end

    local sum = 0
    local count = 0
    for i = 1, #t do
        if type(t[i]) == "number" then
            sum = sum + t[i]
            count = count + 1
        end
    end

    return count > 0 and sum / count or 0
end

-- ============================ DEBUG AND INSPECTION ============================

--- Creates a string representation of a table for debugging
--- @param t table The table to stringify
--- @param indent number Current indentation level (internal use)
--- @param visited table Table to track visited references (internal use)
--- @return string String representation of the table
function TableUtils.ToString(t, indent, visited)
    indent = indent or 0
    visited = visited or {}

    if type(t) ~= "table" then
        return tostring(t)
    end

    if visited[t] then
        return string.rep(" ", indent) .. "<recursion>"
    end
    visited[t] = true

    local lines = {"{"}
    for k, v in pairs(t) do
        local keyStr = (type(k) == "string" and "[\""..k.."\"]" or "["..tostring(k).."]")
        local valueStr
        if type(v) == "table" then
            valueStr = TableUtils.ToString(v, indent + 2, visited)
        elseif type(v) == "string" then
            valueStr = '"'..v..'"'
        else
            valueStr = tostring(v)
        end
        tinsert(lines, string.rep(" ", indent + 2) .. keyStr .. " = " .. valueStr .. ",")
    end
    tinsert(lines, string.rep(" ", indent) .. "}")
    return concat(lines, "\n")
end

-- ============================ EXPORTS ============================

-- Export the utility functions
ns.TableUtils = TableUtils

-- Debug: Log that TableUtils has been loaded
if DEBUG_TABLE_UTILS then
    print("|cff00ff00[NAG TableUtils] TableUtils loaded successfully|r")
    print("|cff00ff00[NAG TableUtils] Available functions: Keys, Values, Size, Length, IsEmpty, Copy, DeepClone, Merge, MergeNew, DeepMerge, DeepMergePreserve, DeepMergeNew, MergeWithOptions, FindKey, FindValue, Filter, Map, Reduce, All, Any, Count, RemoveIf, Unique, Flatten, Reverse, Slice, WithDefaults, FromPairs, ToPairs, GetNested, SetNested, ToString, Concat, Sort, RemoveMulti, Contains, Insert, Remove, Clear, CreateFilled, Range, Shuffle, RandomElement, RemoveAll, RemoveFirst, Equals, Max, Min, Sum, Average|r")
end

--[[
USAGE EXAMPLES:

1. CoreModule-inheriting module (via ns.TableUtils):
function MyModule:OnInitialize()
    -- Table utility methods are available via ns.TableUtils
    local keys = ns.TableUtils.Keys(myTable)
    local size = ns.TableUtils.Size(myTable)
    local isEmpty = ns.TableUtils.IsEmpty(myTable)

    -- WoW-optimized functions
    ns.TableUtils.Insert(myArray, "newValue")
    ns.TableUtils.Remove(myArray, 1)
    ns.TableUtils.Clear(myTable)
    ns.TableUtils.Sort(myArray)
    local contains = ns.TableUtils.Contains(myTable, "value")
    local concat = ns.TableUtils.Concat(myArray, ", ")

    -- Additional utilities
    local filled = ns.TableUtils.CreateFilled(10, 0)
    local range = ns.TableUtils.Range(1, 10, 2)
    ns.TableUtils.Shuffle(myArray)
    local random = ns.TableUtils.RandomElement(myArray)
    local removed = ns.TableUtils.RemoveAll(myArray, "value")
    local max = ns.TableUtils.Max(myArray)
    local sum = ns.TableUtils.Sum(myArray)
end

2. Service module (non-CoreModule):
function MyServiceModule:OnInitialize()
    -- Use TableUtils directly
    local keys = ns.TableUtils.Keys(myTable)
    local values = ns.TableUtils.Values(myTable)
    local merged = ns.TableUtils.MergeNew(table1, table2, table3)

    -- WoW-optimized functions
    ns.TableUtils.Insert(myArray, "newValue")
    ns.TableUtils.Remove(myArray, 1)
    ns.TableUtils.Clear(myTable)
    ns.TableUtils.Sort(myArray)
    local contains = ns.TableUtils.Contains(myTable, "value")
    local concat = ns.TableUtils.Concat(myArray, ", ")

    -- Additional utilities
    local filled = ns.TableUtils.CreateFilled(10, 0)
    local range = ns.TableUtils.Range(1, 10, 2)
    ns.TableUtils.Shuffle(myArray)
    local random = ns.TableUtils.RandomElement(myArray)
    local removed = ns.TableUtils.RemoveAll(myArray, "value")
    local max = ns.TableUtils.Max(myArray)
    local sum = ns.TableUtils.Sum(myArray)
end

3. Main addon usage:
local keys = ns.TableUtils.Keys(someTable)
local filtered = ns.TableUtils.Filter(someTable, function(key, value) return value > 10 end)
local mapped = ns.TableUtils.Map(someTable, function(key, value) return value * 2 end)

4. Array operations:
local unique = ns.TableUtils.Unique(array)
local reversed = ns.TableUtils.Reverse(array)
local slice = ns.TableUtils.Slice(array, 2, 5)

5. Nested operations:
local value = ns.TableUtils.GetNested(table, "a.b.c", "default")
ns.TableUtils.SetNested(table, "a.b.c", "new value")

6. WoW-optimized operations:
ns.TableUtils.Insert(array, "value")           -- Uses tinsert
ns.TableUtils.Remove(array, 1)                -- Uses tremove
ns.TableUtils.Clear(table)                    -- Uses wipe
ns.TableUtils.Sort(array)                     -- Uses sort
ns.TableUtils.Contains(table, "value")        -- Uses tContains
ns.TableUtils.Concat(array, ", ")             -- Uses concat
ns.TableUtils.RemoveMulti(array, 1, 3)       -- Uses removemulti

NOTE: All modules now use the same underlying TableUtils implementation,
providing consistent behavior and missing Lua 5.1 functionality while
leveraging WoW's optimized table functions where available.
]]
