--- @module "ASTRotation"
--- Rotation node types matching APLRotation message from apl.proto
--- Handles priority lists, groups, and variables
--- License: CC BY-NC 4.0
--- Authors: Rakizi

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local ASTCore = ns.ASTCore
local TableUtils = ns.TableUtils

--- @class ASTRotation
local ASTRotation = {}
ns.ASTRotation = ASTRotation

-- ============================ ROTATION TYPES ============================

--- Rotation type enum matching APLRotation.Type
ASTRotation.Type = {
    UNKNOWN = 0,
    AUTO = 1,
    SIMPLE = 2,
    APL = 3,
}

-- ============================ FACTORY FUNCTIONS ============================

--- Create a rotation node
--- @param rotationType number|nil Rotation type (default: APL)
--- @return ASTNode
function ASTRotation.Create(rotationType)
    local node = ASTCore.CreateNode(ASTCore.NodeType.ROTATION)
    node.rotation_type = rotationType or ASTRotation.Type.APL
    return node
end

--- Create a prepull action entry
--- @param action table APLAction node
--- @param doAtValue table|nil APLValue for timing (should be negative)
--- @param hide boolean|nil Whether to hide this action
--- @return table APLPrepullAction
function ASTRotation.CreatePrepullAction(action, doAtValue, hide)
    return {
        action = action,
        do_at_value = doAtValue,
        hide = hide or false
    }
end

--- Create a list item entry
--- @param action table APLAction node
--- @param notes string|nil Comments for the reader
--- @param hide boolean|nil Whether to hide this action
--- @return table APLListItem
function ASTRotation.CreateListItem(action, notes, hide)
    return {
        action = action,
        notes = notes,
        hide = hide or false
    }
end

--- Create a group
--- @param name string Group name
--- @param actions table[]|nil Array of APLListItem
--- @param variables table[]|nil Array of APLValueVariable
--- @return table APLGroup
function ASTRotation.CreateGroup(name, actions, variables)
    return {
        name = name,
        actions = actions or {},
        variables = variables or {}
    }
end

--- Create a value variable
--- @param name string Variable name
--- @param value table APLValue node
--- @return table APLValueVariable
function ASTRotation.CreateVariable(name, value)
    return {
        name = name,
        value = value
    }
end

-- ============================ MUTATION FUNCTIONS ============================

--- Add a prepull action to a rotation
--- @param node ASTNode Rotation node
--- @param action table APLAction node
--- @param doAtValue table|nil APLValue for timing
--- @param hide boolean|nil Whether to hide this action
function ASTRotation.AddPrepullAction(node, action, doAtValue, hide)
    if not node or node.type ~= ASTCore.NodeType.ROTATION then
        error("AddPrepullAction: node must be a ROTATION node")
    end

    table.insert(node.prepull_actions, ASTRotation.CreatePrepullAction(action, doAtValue, hide))
end

--- Add an action to the priority list
--- @param node ASTNode Rotation node
--- @param action table APLAction node
--- @param notes string|nil Comments
--- @param hide boolean|nil Whether to hide this action
function ASTRotation.AddPriorityAction(node, action, notes, hide)
    if not node or node.type ~= ASTCore.NodeType.ROTATION then
        error("AddPriorityAction: node must be a ROTATION node")
    end

    table.insert(node.priority_list, ASTRotation.CreateListItem(action, notes, hide))
end

--- Add a group to the rotation
--- @param node ASTNode Rotation node
--- @param group table APLGroup
function ASTRotation.AddGroup(node, group)
    if not node or node.type ~= ASTCore.NodeType.ROTATION then
        error("AddGroup: node must be a ROTATION node")
    end

    table.insert(node.groups, group)
end

--- Add a variable to the rotation
--- @param node ASTNode Rotation node
--- @param variable table APLValueVariable
function ASTRotation.AddVariable(node, variable)
    if not node or node.type ~= ASTCore.NodeType.ROTATION then
        error("AddVariable: node must be a ROTATION node")
    end

    table.insert(node.value_variables, variable)
end

-- ============================ QUERY FUNCTIONS ============================

--- Get the number of prepull actions
--- @param node ASTNode Rotation node
--- @return number
function ASTRotation.GetPrepullActionCount(node)
    if not node or node.type ~= ASTCore.NodeType.ROTATION then
        return 0
    end

    return #(node.prepull_actions or {})
end

--- Get the number of priority list actions
--- @param node ASTNode Rotation node
--- @return number
function ASTRotation.GetPriorityListCount(node)
    if not node or node.type ~= ASTCore.NodeType.ROTATION then
        return 0
    end

    return #(node.priority_list or {})
end

--- Get the number of groups
--- @param node ASTNode Rotation node
--- @return number
function ASTRotation.GetGroupCount(node)
    if not node or node.type ~= ASTCore.NodeType.ROTATION then
        return 0
    end

    return #(node.groups or {})
end

--- Get the number of variables
--- @param node ASTNode Rotation node
--- @return number
function ASTRotation.GetVariableCount(node)
    if not node or node.type ~= ASTCore.NodeType.ROTATION then
        return 0
    end

    return #(node.value_variables or {})
end

--- Get prepull actions
--- @param node ASTNode Rotation node
--- @return table[] Array of APLPrepullAction
function ASTRotation.GetPrepullActions(node)
    if not node or node.type ~= ASTCore.NodeType.ROTATION then
        return {}
    end

    return node.prepull_actions or {}
end

--- Get priority list
--- @param node ASTNode Rotation node
--- @return table[] Array of APLListItem
function ASTRotation.GetPriorityList(node)
    if not node or node.type ~= ASTCore.NodeType.ROTATION then
        return {}
    end

    return node.priority_list or {}
end

--- Get groups
--- @param node ASTNode Rotation node
--- @return table[] Array of APLGroup
function ASTRotation.GetGroups(node)
    if not node or node.type ~= ASTCore.NodeType.ROTATION then
        return {}
    end

    return node.groups or {}
end

--- Get variables
--- @param node ASTNode Rotation node
--- @return table[] Array of APLValueVariable
function ASTRotation.GetVariables(node)
    if not node or node.type ~= ASTCore.NodeType.ROTATION then
        return {}
    end

    return node.value_variables or {}
end

--- Find a group by name
--- @param node ASTNode Rotation node
--- @param groupName string Group name
--- @return table|nil APLGroup if found
function ASTRotation.FindGroup(node, groupName)
    if not node or node.type ~= ASTCore.NodeType.ROTATION then
        return nil
    end

    for _, group in ipairs(node.groups or {}) do
        if group.name == groupName then
            return group
        end
    end

    return nil
end

--- Find a variable by name
--- @param node ASTNode Rotation node
--- @param varName string Variable name
--- @return table|nil APLValueVariable if found
function ASTRotation.FindVariable(node, varName)
    if not node or node.type ~= ASTCore.NodeType.ROTATION then
        return nil
    end

    for _, var in ipairs(node.value_variables or {}) do
        if var.name == varName then
            return var
        end
    end

    return nil
end

--- Remove a prepull action by index
--- @param node ASTNode Rotation node
--- @param index number Action index (1-based)
--- @return boolean Success
function ASTRotation.RemovePrepullAction(node, index)
    if not node or node.type ~= ASTCore.NodeType.ROTATION then
        return false
    end

    if index < 1 or index > #node.prepull_actions then
        return false
    end

    table.remove(node.prepull_actions, index)
    return true
end

--- Remove a priority list action by index
--- @param node ASTNode Rotation node
--- @param index number Action index (1-based)
--- @return boolean Success
function ASTRotation.RemovePriorityAction(node, index)
    if not node or node.type ~= ASTCore.NodeType.ROTATION then
        return false
    end

    if index < 1 or index > #node.priority_list then
        return false
    end

    table.remove(node.priority_list, index)
    return true
end

--- Remove a group by name
--- @param node ASTNode Rotation node
--- @param groupName string Group name
--- @return boolean Success
function ASTRotation.RemoveGroup(node, groupName)
    if not node or node.type ~= ASTCore.NodeType.ROTATION then
        return false
    end

    for i, group in ipairs(node.groups or {}) do
        if group.name == groupName then
            table.remove(node.groups, i)
            return true
        end
    end

    return false
end

--- Remove a variable by name
--- @param node ASTNode Rotation node
--- @param varName string Variable name
--- @return boolean Success
function ASTRotation.RemoveVariable(node, varName)
    if not node or node.type ~= ASTCore.NodeType.ROTATION then
        return false
    end

    for i, var in ipairs(node.value_variables or {}) do
        if var.name == varName then
            table.remove(node.value_variables, i)
            return true
        end
    end

    return false
end

--- Clear all prepull actions
--- @param node ASTNode Rotation node
function ASTRotation.ClearPrepullActions(node)
    if node and node.type == ASTCore.NodeType.ROTATION then
        node.prepull_actions = {}
    end
end

--- Clear the priority list
--- @param node ASTNode Rotation node
function ASTRotation.ClearPriorityList(node)
    if node and node.type == ASTCore.NodeType.ROTATION then
        node.priority_list = {}
    end
end

--- Clear all groups
--- @param node ASTNode Rotation node
function ASTRotation.ClearGroups(node)
    if node and node.type == ASTCore.NodeType.ROTATION then
        node.groups = {}
    end
end

--- Clear all variables
--- @param node ASTNode Rotation node
function ASTRotation.ClearVariables(node)
    if node and node.type == ASTCore.NodeType.ROTATION then
        node.value_variables = {}
    end
end

return ASTRotation

