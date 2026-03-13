--- @module "APLValues_Variables"
--- Variable system handlers for NAG APL (WoWSims APLValueVariable, APLValueVariableRef, APLValueVariablePlaceholder)
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ============================ HEADER LOCALS ============================

-- ============================ MODULE CACHING (PERFORMANCE) ============================
-- Cache frequently accessed modules to avoid GetModule overhead in hot paths
local RotationManager = ns.RotationManager

-- ============================ VARIABLE HANDLERS ============================

--- Create a variable placeholder (APLValueVariablePlaceholder equivalent)
--- This is used in group definitions to mark where variables should be substituted
--- In NAG's runtime model, placeholders resolve to actual values when called within group execution
--- @param self NAG
--- @param placeholderName string The name of the placeholder
--- @return any The resolved value if in group context with variable provided, otherwise placeholder object
function NAG:VariablePlaceholder(placeholderName)
    if not placeholderName or type(placeholderName) ~= "string" then
        NAG:Warn("NAG:VariablePlaceholder() called with invalid placeholder name: %s", tostring(placeholderName))
        return nil
    end

    -- Runtime resolution: If we're in a group context and the variable is provided, resolve it
    -- This matches WoWSims behavior where placeholders are replaced with actual values
    -- but adapted for NAG's string-based runtime execution model
    if NAG.currentVariableScope then
        local resolvedValue = NAG.currentVariableScope[placeholderName]
        if resolvedValue ~= nil then
            -- Placeholder variable provided - return the actual value
            return resolvedValue
        end
        -- Variable not provided in group scope - this is an error condition
        NAG:Error("NAG:VariablePlaceholder('%s'): Placeholder variable not provided when referencing group", placeholderName)
        return nil
    end

    -- Not in group context - return placeholder object for validation/identification
    -- This should not normally happen at runtime (placeholders are only valid inside groups)
    NAG:Warn("NAG:VariablePlaceholder('%s'): Called outside of group context - placeholder may not resolve correctly", placeholderName)
    return {
        _isPlaceholder = true,
        _placeholderName = placeholderName
    }
end

--- Get a variable value by name (APLValueVariableRef equivalent)
--- Uses O(1) lookup tables for optimal performance
--- Resolution order matches WoWSims: group scope (with passed variables) -> rotation scope
--- @param self NAG
--- @param variableName string The name of the variable to look up
--- @return any The evaluated value of the variable
function NAG:VariableRef(variableName)
    if not variableName or type(variableName) ~= "string" then
        NAG:Warn("NAG:VariableRef() called with invalid variable name: %s", tostring(variableName))
        return nil
    end

    -- FIRST: Check current variable scope (group scope if inside a group)
    -- This includes: group's own variables + passed variables (merged in GroupReference)
    -- Matches WoWSims behavior: reResolveVariableRefs checks groupVars first
    if NAG.currentVariableScope then
        local groupValue = NAG.currentVariableScope[variableName]
        -- Note: In practice, groupVariableScope only contains keys with non-nil values
        -- (set from group.variables evaluation and passed variables). If a key doesn't exist,
        -- groupValue will be nil and we fall through to rotation scope check below.
        if groupValue ~= nil then
            -- Variable found in group scope - return it (O(1) lookup, already evaluated)
            return groupValue
        end
    end

    -- SECOND: Fall back to rotation-level variables
    -- Matches WoWSims behavior: falls back to rot.valueVariables after checking groupVars
    if not RotationManager or not RotationManager.currentRotation then
        NAG:Warn("No RotationManager or current rotation found")
        return nil
    end

    local rotation = RotationManager.currentRotation
    if not rotation.variables then
        -- No variables defined at rotation level either
        NAG:Warn("Variable '%s' not found in group scope or rotation scope", variableName)
        return nil
    end

    -- O(1) compiled function lookup (evaluated every call for dynamic values)
    -- Precompilation is required - if this fails, it indicates a precompilation issue
    if not rotation.compiledVariables then
        NAG:Error("Variable '%s' lookup failed: rotation not precompiled (compiledVariables missing)", variableName)
        return nil
    end

    local compiledFunc = rotation.compiledVariables[variableName]
    if not compiledFunc then
        -- Variable not found in rotation scope either
        NAG:Warn("Variable '%s' not found in group scope or rotation scope", variableName)
        return nil
    end

    -- Direct call - precompiled functions are safe, runtime errors indicate bugs that should fail fast
    return compiledFunc()
end
