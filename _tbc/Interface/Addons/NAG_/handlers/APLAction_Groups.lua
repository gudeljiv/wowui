--- @module "APLAction_Groups"
--- Group system handlers for NAG APL (WoWSims APLActionGroupReference)
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

-- ============================ PERFORMANCE OPTIMIZATIONS ============================
-- Reusable table for group variable scopes to avoid allocations per call
local tempGroupScope = {}

-- ============================ GROUP HANDLERS ============================

--- Execute a group reference (APLActionGroupReference equivalent)
--- @param groupName string The name of the group to execute
--- @param variables table|nil Optional variables to pass to the group
--- @return boolean True if any action in the group succeeded
function NAG:GroupReference(groupName, variables)
    if not groupName or type(groupName) ~= "string" then
        NAG:Warn("NAG:GroupReference() called with invalid group name: %s", tostring(groupName))
        return false
    end

    -- Get current rotation's groups from RotationManager
    local currentRotation = RotationManager.currentRotation
    if not currentRotation.groups then
        NAG:Warn("No groups defined for current rotation")
        return false
    end

    -- Find the group (O(1) lookup)
    local group = currentRotation.groupLookup and currentRotation.groupLookup[groupName]
    if not group then
        NAG:Warn("Group '%s' not found in current rotation", groupName)
        return false
    end

    -- Create group variable scope (merge group variables with passed variables)
    -- Store previous variable scope first (needed to detect nested calls)
    local previousVariableScope = NAG.currentVariableScope

    -- Reuse module-level table to avoid allocations, but only if not nested
    -- If nested (previousVariableScope == tempGroupScope), we need a new table to avoid overwriting parent scope
    local groupVariableScope
    if previousVariableScope == tempGroupScope then
        -- Nested call: create new table to preserve parent scope
        groupVariableScope = {}
    else
        -- Top-level call: reuse temp table for performance
        wipe(tempGroupScope)
        groupVariableScope = tempGroupScope
    end

    -- Add group's own variables first (optimized: use precompiled functions)
    -- Precompilation is required - if this fails, it indicates a precompilation issue
    if group.variables then
        if not group.compiledVariables then
            NAG:Error("Group '%s' variables not precompiled (compiledVariables missing)", groupName)
        else
            -- Evaluate precompiled variables (functions that must be called every time)
            -- Direct calls - precompiled functions are safe, runtime errors indicate bugs that should fail fast
            for name, func in pairs(group.compiledVariables) do
                groupVariableScope[name] = func()
            end
        end
    end

    -- Override with passed variables
    if variables then
        for name, value in pairs(variables) do
            groupVariableScope[name] = value
        end
    end

    -- Set group scope (previousVariableScope was already stored above)
    NAG.currentVariableScope = groupVariableScope

    -- Execute each action in the group until one succeeds
    -- Precompilation is required - if this fails, it indicates a precompilation issue
    local groupSucceeded = false
    if not group.compiledActions then
        NAG:Error("Group '%s' actions not precompiled (compiledActions missing)", groupName)
    else
        for i, action in ipairs(group.actions) do
            local compiledFunc = group.compiledActions[i]
            if not compiledFunc then
                NAG:Error("Group '%s' action #%d not precompiled - precompilation may have failed", groupName, i)
            else
                -- Direct call - precompiled functions are safe, runtime errors indicate bugs that should fail fast
                local result = compiledFunc()
                if result then
                    groupSucceeded = true
                    break -- Action succeeded, stop executing group
                end
            end
        end
    end

    -- Restore previous variable scope
    NAG.currentVariableScope = previousVariableScope

    return groupSucceeded
end
