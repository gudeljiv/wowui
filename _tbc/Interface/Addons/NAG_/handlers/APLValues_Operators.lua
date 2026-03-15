--- @module "APLValues_Operators"
--- APL value operators, math, and logic handlers for the NAG addon.
--- This file implements APL value operators based on the WoWSims Go reference implementation.
--- Provides type-safe value operations with automatic type coercion and validation.

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ HEADER LOCALS ============================

-- Lua APIs (WoW optimized where available)
local format = string.format
local floor = math.floor
local min = math.min
local max = math.max



local strmatch = strmatch
local strlower = strlower
local tinsert = tinsert
local wipe = wipe
local ipairs = ipairs
local tostring = tostring
local tonumber = tonumber


-- ~~~~~~~~~~ APL VALUE TYPE DEFINITIONS ~~~~~~~~~~

-- APL Value Type constants (from schema)
local APL_VALUE_TYPES = {
    UNKNOWN = 0,
    BOOL = 1,
    INT = 2,
    FLOAT = 3,
    DURATION = 4,
    STRING = 5
}

-- Comparison operator constants
local COMPARISON_OPERATORS = {
    EQ = "==", -- Equals
    NE = "~=", -- Not equals
    LT = "<",  -- Less than
    LE = "<=", -- Less than or equal
    GT = ">",  -- Greater than
    GE = ">="  -- Greater than or equal
}

-- Math operator constants
local MATH_OPERATORS = {
    ADD = "+", -- Add
    SUB = "-", -- Subtract
    MUL = "*", -- Multiply
    DIV = "/"  -- Divide
}

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~


-- ~~~~~~~~~~ APL VALUE CONST ~~~~~~~~~~

--- Creates a constant APL value with automatic type detection
--- Supports duration strings (e.g., "2s", "1.5m", "30ms"), percentages (e.g., "50%"),
--- and standard boolean, integer, float, and string values.
--- @param val string|number|boolean The constant value to convert
--- @return table|nil APLValueConst object with detected type, or nil if invalid
--- @local Internal APL value manipulation function
function NAG:APLValueConst(val)
    local const = {
        valType = APL_VALUE_TYPES.STRING,
        intVal = 0,
        floatVal = 0.0,
        durationVal = 0,
        stringVal = tostring(val),
        boolVal = val ~= "" and val ~= nil and val ~= false
    }

    -- Type detection logic based on Go implementation
    local valStr = tostring(val)

    -- Check for boolean values
    if strlower(valStr) == "true" then
        const.boolVal = true
        const.valType = APL_VALUE_TYPES.BOOL
        return const
    elseif strlower(valStr) == "false" then
        const.boolVal = false
        const.valType = APL_VALUE_TYPES.BOOL
        return const
    end

    -- Check for duration values (e.g., "2s", "1.5m", "30ms")
    -- Note: Unit suffix is REQUIRED to be parsed as duration (not optional)
    local num, unit = strmatch(valStr, "^(%d+%.?%d*)([smhd])$")
    if num and unit then
        local numVal = tonumber(num)
        if numVal then
            local multiplier = 1
            if unit == "s" then
                multiplier = 1
            elseif unit == "m" then
                multiplier = 60
            elseif unit == "h" then
                multiplier = 3600
            elseif unit == "d" then
                multiplier = 86400
            end
            const.durationVal = numVal * multiplier
            const.floatVal = const.durationVal
            const.intVal = floor(const.durationVal)
            const.valType = APL_VALUE_TYPES.DURATION
            return const
        end
    end

    -- Check for integer values
    local intVal = tonumber(valStr)
    if intVal and intVal == floor(intVal) then
        const.intVal = intVal
        const.floatVal = intVal
        const.durationVal = intVal
        const.valType = APL_VALUE_TYPES.INT
        return const
    end

    -- Check for percentage values (e.g., "50%")
    local percentMatch = strmatch(valStr, "^(%d+%.?%d*)%%$")
    if percentMatch then
        local percentVal = tonumber(percentMatch)
        if percentVal then
            const.floatVal = percentVal / 100.0
            const.durationVal = const.floatVal
            const.intVal = floor(const.floatVal)
            const.valType = APL_VALUE_TYPES.FLOAT
            return const
        end
    end

    -- Check for float values
    local floatVal = tonumber(valStr)
    if floatVal then
        const.floatVal = floatVal
        const.durationVal = floatVal
        const.intVal = floor(floatVal)
        const.valType = APL_VALUE_TYPES.FLOAT
        return const
    end

    -- Default to string
    return const
end

--- Gets the type of an APL value
--- @param value table|nil APL value object
--- @return number APL value type (APL_VALUE_TYPES constant), or UNKNOWN if nil
--- @local Internal APL value manipulation function
function NAG:GetAPLValueType(value)
    return value and value.valType or APL_VALUE_TYPES.UNKNOWN
end

--- Gets boolean value from APL value with automatic type coercion
--- @param value table|nil APL value object
--- @return boolean Boolean value (false for nil, empty strings, or zero values)
--- @local Internal APL value manipulation function
function NAG:GetAPLValueBool(value)
    if not value then return false end

    if value.valType == APL_VALUE_TYPES.BOOL then
        return value.boolVal
    elseif value.valType == APL_VALUE_TYPES.INT then
        return value.intVal ~= 0
    elseif value.valType == APL_VALUE_TYPES.FLOAT then
        return value.floatVal ~= 0
    elseif value.valType == APL_VALUE_TYPES.DURATION then
        return value.durationVal ~= 0
    elseif value.valType == APL_VALUE_TYPES.STRING then
        return value.stringVal ~= ""
    end

    return false
end

--- Gets integer value from APL value with automatic type coercion
--- @param value table|nil APL value object
--- @return number Integer value (0 for nil values, floor() applied to floats/durations)
--- @local Internal APL value manipulation function
function NAG:GetAPLValueInt(value)
    if not value then return 0 end

    if value.valType == APL_VALUE_TYPES.BOOL then
        return value.boolVal and 1 or 0
    elseif value.valType == APL_VALUE_TYPES.INT then
        return value.intVal
    elseif value.valType == APL_VALUE_TYPES.FLOAT then
        return floor(value.floatVal)
    elseif value.valType == APL_VALUE_TYPES.DURATION then
        return floor(value.durationVal)
    elseif value.valType == APL_VALUE_TYPES.STRING then
        error("Cannot coerce string to int")
    end

    return 0
end

--- Gets float value from APL value with automatic type coercion
--- @param value table|nil APL value object
--- @return number Float value (0.0 for nil values)
--- @local Internal APL value manipulation function
function NAG:GetAPLValueFloat(value)
    if not value then return 0.0 end

    if value.valType == APL_VALUE_TYPES.BOOL then
        return value.boolVal and 1.0 or 0.0
    elseif value.valType == APL_VALUE_TYPES.INT then
        return value.intVal
    elseif value.valType == APL_VALUE_TYPES.FLOAT then
        return value.floatVal
    elseif value.valType == APL_VALUE_TYPES.DURATION then
        return value.durationVal
    elseif value.valType == APL_VALUE_TYPES.STRING then
        error("Cannot coerce string to float")
    end

    return 0.0
end

--- Gets duration value from APL value with automatic type coercion
--- @param value table|nil APL value object
--- @return number Duration value in seconds (0 for nil values)
--- @local Internal APL value manipulation function
function NAG:GetAPLValueDuration(value)
    if not value then return 0 end

    if value.valType == APL_VALUE_TYPES.BOOL then
        error("Cannot coerce bool to duration")
    elseif value.valType == APL_VALUE_TYPES.INT then
        return value.intVal
    elseif value.valType == APL_VALUE_TYPES.FLOAT then
        return value.floatVal
    elseif value.valType == APL_VALUE_TYPES.DURATION then
        return value.durationVal
    elseif value.valType == APL_VALUE_TYPES.STRING then
        error("Cannot coerce string to duration")
    end

    return 0
end

--- Gets string value from APL value with automatic type coercion
--- @param value table|nil APL value object
--- @return string String value ("" for nil values, formatted for floats/durations)
--- @local Internal APL value manipulation function
function NAG:GetAPLValueString(value)
    if not value then return "" end

    if value.valType == APL_VALUE_TYPES.BOOL then
        error("Cannot coerce bool to string")
    elseif value.valType == APL_VALUE_TYPES.INT then
        return tostring(value.intVal)
    elseif value.valType == APL_VALUE_TYPES.FLOAT then
        return format("%.3f", value.floatVal)
    elseif value.valType == APL_VALUE_TYPES.DURATION then
        return tostring(value.durationVal) .. "s"
    elseif value.valType == APL_VALUE_TYPES.STRING then
        return value.stringVal
    end

    return ""
end

-- ~~~~~~~~~~ TYPE COERCION ~~~~~~~~~~

--- Coerces an APL value to a specific type with automatic type conversion
--- @param value table|nil APL value object to coerce
--- @param targetType number Target APL value type (APL_VALUE_TYPES constant)
--- @return table|nil Coerced APL value object, or nil if value is nil
--- @local Internal APL value manipulation function
function NAG:CoerceAPLValue(value, targetType)
    if not value then return nil end
    if value.valType == targetType then return value end

    local coerced = {
        valType = targetType,
        intVal = 0,
        floatVal = 0.0,
        durationVal = 0,
        stringVal = "",
        boolVal = false
    }

    if targetType == APL_VALUE_TYPES.BOOL then
        coerced.boolVal = self:GetAPLValueBool(value)
    elseif targetType == APL_VALUE_TYPES.INT then
        coerced.intVal = self:GetAPLValueInt(value)
        coerced.floatVal = coerced.intVal
        coerced.durationVal = coerced.intVal
    elseif targetType == APL_VALUE_TYPES.FLOAT then
        coerced.floatVal = self:GetAPLValueFloat(value)
        coerced.intVal = floor(coerced.floatVal)
        coerced.durationVal = coerced.floatVal
    elseif targetType == APL_VALUE_TYPES.DURATION then
        coerced.durationVal = self:GetAPLValueDuration(value)
        coerced.intVal = floor(coerced.durationVal)
        coerced.floatVal = coerced.durationVal
    elseif targetType == APL_VALUE_TYPES.STRING then
        coerced.stringVal = self:GetAPLValueString(value)
    end

    return coerced
end

--- Determines the highest priority type for coercion based on type hierarchy
--- Priority: INT < FLOAT < DURATION < STRING < BOOL
--- @param values table Array of APL values
--- @return number Highest priority type (APL_VALUE_TYPES constant)
--- @local Internal APL value manipulation function
function NAG:GetHighestPriorityType(values)
    local typePriority = {
        [APL_VALUE_TYPES.INT] = 1,
        [APL_VALUE_TYPES.FLOAT] = 2,
        [APL_VALUE_TYPES.DURATION] = 3,
        [APL_VALUE_TYPES.STRING] = 4,
        [APL_VALUE_TYPES.BOOL] = 5
    }

    local highestType = APL_VALUE_TYPES.INT
    local highestPriority = 0

    for _, value in ipairs(values) do
        if value and value.valType then
            local priority = typePriority[value.valType] or 0
            if priority > highestPriority then
                highestPriority = priority
                highestType = value.valType
            end
        end
    end

    return highestType
end

local coercedArray = {}

--- Coerces all values to the same type using highest priority type
--- @param values table Array of APL values
--- @return table Array of coerced APL values (nil entries preserved)
--- @local Internal APL value manipulation function
function NAG:CoerceAllToSameType(values)
    local targetType = self:GetHighestPriorityType(values)

    wipe(coercedArray)

    for _, value in ipairs(values) do
        if value then
            tinsert(coercedArray, self:CoerceAPLValue(value, targetType))
        else
            tinsert(coercedArray, nil)
        end
    end

    return coercedArray
end

-- ~~~~~~~~~~ COMPARISON OPERATIONS ~~~~~~~~~~

--- Creates a comparison APL value with automatic type coercion
--- @param lhs table|nil Left-hand side APL value
--- @param op string Comparison operator (==, ~=, <, <=, >, >=)
--- @param rhs table|nil Right-hand side APL value
--- @return table|nil APLValueCompare object, or nil if either operand is nil
--- @local Internal APL value manipulation function
function NAG:APLValueCompare(lhs, op, rhs)
    if not lhs or not rhs then return nil end

    -- Coerce both values to the same type
    local coercedLhs, coercedRhs = lhs, rhs
    if lhs.valType ~= rhs.valType then
        local targetType = self:GetHighestPriorityType({ lhs, rhs })
        coercedLhs = self:CoerceAPLValue(lhs, targetType)
        coercedRhs = self:CoerceAPLValue(rhs, targetType)
    end

    return {
        op = op,
        lhs = coercedLhs,
        rhs = coercedRhs,
        valType = APL_VALUE_TYPES.BOOL
    }
end

--- Evaluates a comparison APL value
--- @param compare table|nil APLValueCompare object
--- @return boolean Comparison result (false for nil or invalid comparisons)
--- @local Internal APL value manipulation function
function NAG:EvaluateAPLValueCompare(compare)
    if not compare or not compare.lhs or not compare.rhs then return false end

    local lhs = compare.lhs
    local rhs = compare.rhs
    local op = compare.op

    if lhs.valType == APL_VALUE_TYPES.BOOL then
        if op == COMPARISON_OPERATORS.EQ then
            return lhs.boolVal == rhs.boolVal
        elseif op == COMPARISON_OPERATORS.NE then
            return lhs.boolVal ~= rhs.boolVal
        else
            self:Warn("Bool types only allow Equals and NotEquals comparisons!")
            return false
        end
    elseif lhs.valType == APL_VALUE_TYPES.INT then
        if op == COMPARISON_OPERATORS.EQ then
            return lhs.intVal == rhs.intVal
        elseif op == COMPARISON_OPERATORS.NE then
            return lhs.intVal ~= rhs.intVal
        elseif op == COMPARISON_OPERATORS.LT then
            return lhs.intVal < rhs.intVal
        elseif op == COMPARISON_OPERATORS.LE then
            return lhs.intVal <= rhs.intVal
        elseif op == COMPARISON_OPERATORS.GT then
            return lhs.intVal > rhs.intVal
        elseif op == COMPARISON_OPERATORS.GE then
            return lhs.intVal >= rhs.intVal
        end
    elseif lhs.valType == APL_VALUE_TYPES.FLOAT then
        if op == COMPARISON_OPERATORS.EQ then
            return lhs.floatVal == rhs.floatVal
        elseif op == COMPARISON_OPERATORS.NE then
            return lhs.floatVal ~= rhs.floatVal
        elseif op == COMPARISON_OPERATORS.LT then
            return lhs.floatVal < rhs.floatVal
        elseif op == COMPARISON_OPERATORS.LE then
            return lhs.floatVal <= rhs.floatVal
        elseif op == COMPARISON_OPERATORS.GT then
            return lhs.floatVal > rhs.floatVal
        elseif op == COMPARISON_OPERATORS.GE then
            return lhs.floatVal >= rhs.floatVal
        end
    elseif lhs.valType == APL_VALUE_TYPES.DURATION then
        if op == COMPARISON_OPERATORS.EQ then
            return lhs.durationVal == rhs.durationVal
        elseif op == COMPARISON_OPERATORS.NE then
            return lhs.durationVal ~= rhs.durationVal
        elseif op == COMPARISON_OPERATORS.LT then
            return lhs.durationVal < rhs.durationVal
        elseif op == COMPARISON_OPERATORS.LE then
            return lhs.durationVal <= rhs.durationVal
        elseif op == COMPARISON_OPERATORS.GT then
            return lhs.durationVal > rhs.durationVal
        elseif op == COMPARISON_OPERATORS.GE then
            return lhs.durationVal >= rhs.durationVal
        end
    elseif lhs.valType == APL_VALUE_TYPES.STRING then
        if op == COMPARISON_OPERATORS.EQ then
            return lhs.stringVal == rhs.stringVal
        elseif op == COMPARISON_OPERATORS.NE then
            return lhs.stringVal ~= rhs.stringVal
        elseif op == COMPARISON_OPERATORS.LT then
            return lhs.stringVal < rhs.stringVal
        elseif op == COMPARISON_OPERATORS.LE then
            return lhs.stringVal <= rhs.stringVal
        elseif op == COMPARISON_OPERATORS.GT then
            return lhs.stringVal > rhs.stringVal
        elseif op == COMPARISON_OPERATORS.GE then
            return lhs.stringVal >= rhs.stringVal
        end
    end

    return false
end

-- ~~~~~~~~~~ MATHEMATICAL OPERATIONS ~~~~~~~~~~

--- Creates a mathematical APL value with type validation and coercion
--- @param lhs table|nil Left-hand side APL value
--- @param op string Math operator (+, -, *, /)
--- @param rhs table|nil Right-hand side APL value
--- @return table|nil APLValueMath object, or nil if invalid types or operations
--- @local Internal APL value manipulation function
function NAG:APLValueMath(lhs, op, rhs)
    if not lhs or not rhs then return nil end

    -- For addition and subtraction, coerce to same type
    local coercedLhs, coercedRhs = lhs, rhs
    if op == MATH_OPERATORS.ADD or op == MATH_OPERATORS.SUB then
        local targetType = self:GetHighestPriorityType({ lhs, rhs })
        coercedLhs = self:CoerceAPLValue(lhs, targetType)
        coercedRhs = self:CoerceAPLValue(rhs, targetType)
    end

    -- Validate types
    if coercedLhs.valType == APL_VALUE_TYPES.BOOL or coercedRhs.valType == APL_VALUE_TYPES.BOOL then
        self:Warn("Bool types not allowed in Math Operations!")
        return nil
    end

    if coercedLhs.valType == APL_VALUE_TYPES.STRING or coercedRhs.valType == APL_VALUE_TYPES.STRING then
        self:Warn("String types not allowed in Math Operations!")
        return nil
    end

    -- Disallow duration * duration
    if op == MATH_OPERATORS.MUL and
        coercedLhs.valType == APL_VALUE_TYPES.DURATION and
        coercedRhs.valType == APL_VALUE_TYPES.DURATION then
        self:Warn("Duration * Duration is not allowed!")
        return nil
    end

    -- Disallow int/float divided by duration
    if op == MATH_OPERATORS.DIV and
        (coercedLhs.valType == APL_VALUE_TYPES.INT or coercedLhs.valType == APL_VALUE_TYPES.FLOAT) and
        coercedRhs.valType == APL_VALUE_TYPES.DURATION then
        self:Warn("Cannot divide int or float by duration!")
        return nil
    end

    return {
        op = op,
        lhs = coercedLhs,
        rhs = coercedRhs
    }
end

--- Evaluates a mathematical APL value with automatic result type determination
--- @param math table|nil APLValueMath object
--- @return table|nil Result APL value, or nil if invalid or nil input
--- @local Internal APL value manipulation function
function NAG:EvaluateAPLValueMath(math)
    if not math or not math.lhs or not math.rhs then return nil end

    local lhs = math.lhs
    local rhs = math.rhs
    local op = math.op

    -- Determine result type
    local resultType = lhs.valType
    if op == MATH_OPERATORS.MUL or op == MATH_OPERATORS.DIV then
        if lhs.valType == APL_VALUE_TYPES.DURATION or rhs.valType == APL_VALUE_TYPES.DURATION then
            if op == MATH_OPERATORS.MUL then
                resultType = APL_VALUE_TYPES.DURATION
            elseif op == MATH_OPERATORS.DIV and lhs.valType == APL_VALUE_TYPES.DURATION and rhs.valType == APL_VALUE_TYPES.DURATION then
                resultType = APL_VALUE_TYPES.FLOAT
            end
        elseif lhs.valType == APL_VALUE_TYPES.FLOAT or rhs.valType == APL_VALUE_TYPES.FLOAT then
            resultType = APL_VALUE_TYPES.FLOAT
        end
    end

    local result = {
        valType = resultType,
        intVal = 0,
        floatVal = 0.0,
        durationVal = 0,
        stringVal = "",
        boolVal = false
    }

    if resultType == APL_VALUE_TYPES.INT then
        if op == MATH_OPERATORS.ADD then
            result.intVal = lhs.intVal + rhs.intVal
        elseif op == MATH_OPERATORS.SUB then
            result.intVal = lhs.intVal - rhs.intVal
        elseif op == MATH_OPERATORS.MUL then
            result.intVal = lhs.intVal * rhs.intVal
        elseif op == MATH_OPERATORS.DIV then
            result.intVal = floor(lhs.intVal / rhs.intVal)
        end
        result.floatVal = result.intVal
        result.durationVal = result.intVal
    elseif resultType == APL_VALUE_TYPES.FLOAT then
        if op == MATH_OPERATORS.ADD then
            result.floatVal = lhs.floatVal + rhs.floatVal
        elseif op == MATH_OPERATORS.SUB then
            result.floatVal = lhs.floatVal - rhs.floatVal
        elseif op == MATH_OPERATORS.MUL then
            result.floatVal = lhs.floatVal * rhs.floatVal
        elseif op == MATH_OPERATORS.DIV then
            if lhs.valType == APL_VALUE_TYPES.DURATION and rhs.valType == APL_VALUE_TYPES.DURATION then
                if rhs.durationVal == 0 then
                    error("Division by zero in duration / duration")
                end
                result.floatVal = lhs.durationVal / rhs.durationVal
            else
                result.floatVal = lhs.floatVal / rhs.floatVal
            end
        end
        result.intVal = floor(result.floatVal)
        result.durationVal = result.floatVal
    elseif resultType == APL_VALUE_TYPES.DURATION then
        if op == MATH_OPERATORS.ADD then
            result.durationVal = lhs.durationVal + rhs.durationVal
        elseif op == MATH_OPERATORS.SUB then
            result.durationVal = lhs.durationVal - rhs.durationVal
        elseif op == MATH_OPERATORS.MUL then
            if lhs.valType == APL_VALUE_TYPES.DURATION then
                if rhs.valType == APL_VALUE_TYPES.INT then
                    result.durationVal = lhs.durationVal * rhs.intVal
                elseif rhs.valType == APL_VALUE_TYPES.FLOAT then
                    result.durationVal = lhs.durationVal * rhs.floatVal
                else
                    error("Invalid rhs type for duration multiplication")
                end
            elseif rhs.valType == APL_VALUE_TYPES.DURATION then
                if lhs.valType == APL_VALUE_TYPES.INT then
                    result.durationVal = rhs.durationVal * lhs.intVal
                elseif lhs.valType == APL_VALUE_TYPES.FLOAT then
                    result.durationVal = rhs.durationVal * lhs.floatVal
                else
                    error("Invalid lhs type for duration multiplication")
                end
            else
                error("Invalid types for duration multiplication")
            end
        elseif op == MATH_OPERATORS.DIV then
            if rhs.valType == APL_VALUE_TYPES.INT then
                if rhs.intVal == 0 then
                    error("Division by zero in duration / int")
                end
                result.durationVal = lhs.durationVal / rhs.intVal
            elseif rhs.valType == APL_VALUE_TYPES.FLOAT then
                if rhs.floatVal == 0 then
                    error("Division by zero in duration / float")
                end
                result.durationVal = lhs.durationVal / rhs.floatVal
            else
                error("Invalid rhs type for duration division")
            end
        end
        result.intVal = floor(result.durationVal)
        result.floatVal = result.durationVal
    end

    return result
end

-- ~~~~~~~~~~ MIN/MAX OPERATIONS ~~~~~~~~~~

local maxValues = {}

--- Creates a maximum APL value with automatic type coercion
--- @param values table|nil Array of APL values
--- @return table|nil APLValueMax object, or nil if no valid values
--- @local Internal APL value manipulation function
function NAG:APLValueMax(values)
    if not values or #values == 0 then return nil end

    local coercedValues = self:CoerceAllToSameType(values)

    wipe(maxValues)

    for _, value in ipairs(coercedValues) do
        if value then
            tinsert(maxValues, value)
        end
    end

    if #maxValues == 0 then return nil end
    if #maxValues == 1 then return maxValues[1] end

    return {
        vals = maxValues,
        valType = maxValues[1].valType
    }
end

--- Evaluates a maximum APL value
--- @param maxValue table|nil APLValueMax object
--- @return table|nil Result APL value, or nil if invalid or nil input
--- @local Internal APL value manipulation function
function NAG:EvaluateAPLValueMax(maxValue)
    if not maxValue or not maxValue.vals or #maxValue.vals == 0 then return nil end

    local result = {
        valType = maxValue.valType,
        intVal = maxValue.vals[1].intVal,
        floatVal = maxValue.vals[1].floatVal,
        durationVal = maxValue.vals[1].durationVal,
        stringVal = maxValue.vals[1].stringVal,
        boolVal = maxValue.vals[1].boolVal
    }

    for i = 2, #maxValue.vals do
        local val = maxValue.vals[i]
        if val.valType == APL_VALUE_TYPES.INT then
            result.intVal = max(result.intVal, val.intVal)
        elseif val.valType == APL_VALUE_TYPES.FLOAT then
            result.floatVal = max(result.floatVal, val.floatVal)
        elseif val.valType == APL_VALUE_TYPES.DURATION then
            result.durationVal = max(result.durationVal, val.durationVal)
        end
    end

    return result
end

local minValues = {}

--- Creates a minimum APL value with automatic type coercion
--- @param values table|nil Array of APL values
--- @return table|nil APLValueMin object, or nil if no valid values
--- @local Internal APL value manipulation function
function NAG:APLValueMin(values)
    if not values or #values == 0 then return nil end

    local coercedValues = self:CoerceAllToSameType(values)

    wipe(minValues)

    for _, value in ipairs(coercedValues) do
        if value then
            tinsert(minValues, value)
        end
    end

    if #minValues == 0 then return nil end
    if #minValues == 1 then return minValues[1] end

    return {
        vals = minValues,
        valType = minValues[1].valType
    }
end

--- Evaluates a minimum APL value
--- @param minValue table|nil APLValueMin object
--- @return table|nil Result APL value, or nil if invalid or nil input
--- @local Internal APL value manipulation function
function NAG:EvaluateAPLValueMin(minValue)
    if not minValue or not minValue.vals or #minValue.vals == 0 then return nil end

    local result = {
        valType = minValue.valType,
        intVal = minValue.vals[1].intVal,
        floatVal = minValue.vals[1].floatVal,
        durationVal = minValue.vals[1].durationVal,
        stringVal = minValue.vals[1].stringVal,
        boolVal = minValue.vals[1].boolVal
    }

    for i = 2, #minValue.vals do
        local val = minValue.vals[i]
        if val.valType == APL_VALUE_TYPES.INT then
            result.intVal = min(result.intVal, val.intVal)
        elseif val.valType == APL_VALUE_TYPES.FLOAT then
            result.floatVal = min(result.floatVal, val.floatVal)
        elseif val.valType == APL_VALUE_TYPES.DURATION then
            result.durationVal = min(result.durationVal, val.durationVal)
        end
    end

    return result
end

-- ~~~~~~~~~~ LOGICAL OPERATIONS ~~~~~~~~~~

local andValues = {}

--- Creates an AND APL value with automatic boolean coercion
--- @param values table|nil Array of APL values
--- @return table|nil APLValueAnd object, or nil if no valid values
--- @local Internal APL value manipulation function
function NAG:APLValueAnd(values)
    if not values or #values == 0 then return nil end

    wipe(andValues)

    for _, value in ipairs(values) do
        if value then
            tinsert(andValues, self:CoerceAPLValue(value, APL_VALUE_TYPES.BOOL))
        end
    end

    if #andValues == 0 then return nil end
    if #andValues == 1 then return andValues[1] end

    return {
        vals = andValues,
        valType = APL_VALUE_TYPES.BOOL
    }
end

--- Evaluates an AND APL value
--- @param andValue table|nil APLValueAnd object
--- @return boolean AND result (false for nil or empty values)
--- @local Internal APL value manipulation function
function NAG:EvaluateAPLValueAnd(andValue)
    if not andValue or not andValue.vals then return false end

    for _, val in ipairs(andValue.vals) do
        if not val.boolVal then
            return false
        end
    end

    return true
end

local orValues = {}

--- Creates an OR APL value with automatic boolean coercion
--- @param values table|nil Array of APL values
--- @return table|nil APLValueOr object, or nil if no valid values
--- @local Internal APL value manipulation function
function NAG:APLValueOr(values)
    if not values or #values == 0 then return nil end

    wipe(orValues)

    for _, value in ipairs(values) do
        if value then
            tinsert(orValues, self:CoerceAPLValue(value, APL_VALUE_TYPES.BOOL))
        end
    end

    if #orValues == 0 then return nil end
    if #orValues == 1 then return orValues[1] end

    return {
        vals = orValues,
        valType = APL_VALUE_TYPES.BOOL
    }
end

--- Evaluates an OR APL value
--- @param orValue table|nil APLValueOr object
--- @return boolean OR result (false for nil or empty values)
--- @local Internal APL value manipulation function
function NAG:EvaluateAPLValueOr(orValue)
    if not orValue or not orValue.vals then return false end

    for _, val in ipairs(orValue.vals) do
        if val.boolVal then
            return true
        end
    end

    return false
end

--- Creates a NOT APL value with automatic boolean coercion
--- @param value table|nil APL value
--- @return table|nil APLValueNot object, or nil if value is nil
--- @local Internal APL value manipulation function
function NAG:APLValueNot(value)
    if not value then return nil end

    local coercedValue = self:CoerceAPLValue(value, APL_VALUE_TYPES.BOOL)
    if not coercedValue then return nil end

    return {
        val = coercedValue,
        valType = APL_VALUE_TYPES.BOOL
    }
end

--- Evaluates a NOT APL value
--- @param notValue table|nil APLValueNot object
--- @return boolean NOT result (false for nil input)
--- @local Internal APL value manipulation function
function NAG:EvaluateAPLValueNot(notValue)
    if not notValue or not notValue.val then return false end

    return not notValue.val.boolVal
end

-- ~~~~~~~~~~ LEGACY COMPATIBILITY FUNCTIONS ~~~~~~~~~~

--- Legacy Const function for backward compatibility
--- @param val any The constant value to return
--- @return any The constant value (unchanged)
--- @local Internal APL value manipulation function
function NAG:Const(val)
    return val
end

--- Legacy And function for backward compatibility
--- @param ... any A variable number of boolean values
--- @return boolean True if all values are truthy, false otherwise
--- @local Internal APL value manipulation function
function NAG:And(...)
    for i = 1, select('#', ...) do
        if not select(i, ...) then
            return false
        end
    end
    return true
end

--- Legacy Or function for backward compatibility
--- @param ... any A variable number of boolean values
--- @return boolean True if any value is truthy, false otherwise
--- @local Internal APL value manipulation function
function NAG:Or(...)
    for i = 1, select('#', ...) do
        if select(i, ...) then
            return true
        end
    end
    return false
end

--- Legacy Not function for backward compatibility
--- @param val any The value to negate
--- @return boolean The negated value
--- @local Internal APL value manipulation function
function NAG:Not(val)
    return not val
end

--- Legacy Cmp function for backward compatibility
--- @param val1 any The first value
--- @param op string The comparison operator (==, ~=, >, >=, <, <=)
--- @param val2 any The second value
--- @return boolean The result of the comparison
--- @local Internal APL value manipulation function
function NAG:Cmp(val1, op, val2)
    if op == "==" then return val1 == val2 end
    if op == "~=" then return val1 ~= val2 end
    if op == ">" then return val1 > val2 end
    if op == ">=" then return val1 >= val2 end
    if op == "<" then return val1 < val2 end
    if op == "<=" then return val1 <= val2 end
    self:Error("Cmp: Invalid operator %s", tostring(op))
    return false
end

-- Simple Compare alias for APL proto compatibility

--- Legacy Math function for backward compatibility
--- @param val1 number The first value
--- @param op string The math operator (+, -, *, /)
--- @param val2 number The second value
--- @return number The result of the operation, or 0 if the operator is invalid
--- @local Internal APL value manipulation function
function NAG:Math(val1, op, val2)
    if op == "+" then return val1 + val2 end
    if op == "-" then return val1 - val2 end
    if op == "*" then return val1 * val2 end
    if op == "/" then return val1 / val2 end
    self:Error("Math: Invalid operator %s", tostring(op))
    return 0
end

--- Legacy Max function for backward compatibility
--- @param ... number A variable number of numerical values
--- @return number|nil The maximum value, or nil if no values provided
--- @local Internal APL value manipulation function
function NAG:Max(...)
    return max(...)
end

--- Legacy Min function for backward compatibility
--- @param ... number A variable number of numerical values
--- @return number|nil The minimum value, or nil if no values provided
--- @local Internal APL value manipulation function
function NAG:Min(...)
    return min(...)
end
