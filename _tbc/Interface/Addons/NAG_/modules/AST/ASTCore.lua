--- @module "ASTCore"
--- Core AST node class with proto-compatible structure
--- Matches apl.proto message structure for seamless WoWSims integration
--- License: CC BY-NC 4.0
--- Authors: Rakizi

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local TableUtils = ns.TableUtils

--- @class ASTCore
local ASTCore = {}
ns.ASTCore = ASTCore

-- ============================ PROTO NODE TYPES ============================

--- Proto-compatible node types matching apl.proto
ASTCore.NodeType = {
    ACTION = "action",       -- APLAction message
    VALUE = "value",         -- APLValue message
    ROTATION = "rotation",   -- APLRotation message
    LIST_ITEM = "list_item", -- APLListItem message
    GROUP = "group",         -- APLGroup message
}

-- ============================ AST NODE CLASS ============================

--- @class ASTNode
--- @field type string Node type (action, value, rotation)
--- @field uuid table|nil Proto UUID field
--- @field action table|nil Action oneof (for ACTION nodes)
--- @field condition table|nil APLValue condition (for ACTION nodes)
--- @field value table|nil Value oneof (for VALUE nodes)
--- @field prepull_actions table[]|nil Prepull actions (for ROTATION nodes)
--- @field priority_list table[]|nil Priority list (for ROTATION nodes)
--- @field groups table[]|nil Action groups (for ROTATION nodes)
--- @field value_variables table[]|nil Named variables (for ROTATION nodes)
--- @field originalText string|nil Original text for debugging
--- @field sourceLocation table|nil Source location {line, column}
local ASTNode = {}
ASTNode.__index = ASTNode

local function StripInternalKeys(tbl)
    if not tbl or type(tbl) ~= "table" then
        return tbl
    end

    for key in pairs(tbl) do
        if type(key) == "string" and key:sub(1, 2) == "__" then
            tbl[key] = nil
        end
    end

    return tbl
end

local function SerializeNode(value)
    if not value then
        return nil
    end

    if type(value) ~= "table" then
        return value
    end

    if value.toProto then
        return StripInternalKeys(value:toProto())
    end

    return StripInternalKeys(TableUtils.Copy(value))
end

--- Create a new proto-compatible AST node
--- @param nodeType string The type of node (action, value, rotation)
--- @param data table|nil Optional initial data
--- @return ASTNode
function ASTCore.CreateNode(nodeType, data)
    if NAG.debug then
        NAG:Trace("[ASTCore] CreateNode: Creating AST node (nodeType='%s')", nodeType or "nil")
    end

    if not nodeType then
        NAG:Warn("[ASTCore] CreateNode: nodeType is nil - creating node without type")
    end

    local self = setmetatable({}, ASTNode)

    self.type = nodeType
    self.uuid = nil

    -- Initialize type-specific fields
    if nodeType == ASTCore.NodeType.ACTION then
        self.action = {}
        self.condition = nil
    elseif nodeType == ASTCore.NodeType.VALUE then
        self.value = {}
    elseif nodeType == ASTCore.NodeType.ROTATION then
        self.prepull_actions = {}
        self.priority_list = {}
        self.groups = {}
        self.value_variables = {}
    else
        NAG:Warn("[ASTCore] CreateNode: Unknown nodeType='%s' - node may not be properly initialized", tostring(nodeType))
    end

    -- Metadata (non-proto)
    self.originalText = nil
    self.sourceLocation = nil

    -- Apply initial data if provided
    if data then
        for k, v in pairs(data) do
            self[k] = v
        end
    end

    return self
end

--- Validate node against proto schema
--- @return boolean success
--- @return string|nil error Error message if validation fails
function ASTNode:validate()
    if NAG.debug then
        NAG:Info("[ASTCore] validate: Validating AST node (type='%s')", self.type or "nil")
    end

    if not self.type then
        NAG:Warn("[ASTCore] validate: Node missing required 'type' field")
        return false, "Node missing required 'type' field"
    end

    -- Type-specific validation
    if self.type == ASTCore.NodeType.ACTION then
        if not self.action then
            NAG:Warn("[ASTCore] validate: ACTION node missing 'action' field")
            return false, "ACTION node missing 'action' field"
        end
        -- Action must have at least one action type set
        local hasAction = false
        for k, v in pairs(self.action) do
            if v ~= nil and k ~= "condition" then
                hasAction = true
                break
            end
        end
        if not hasAction then
            NAG:Warn("[ASTCore] validate: ACTION node has no action set in action oneof")
            return false, "ACTION node has no action set in action oneof"
        end

    elseif self.type == ASTCore.NodeType.VALUE then
        if not self.value then
            NAG:Warn("[ASTCore] validate: VALUE node missing 'value' field")
            return false, "VALUE node missing 'value' field"
        end
        -- Value must have at least one value type set
        local hasValue = false
        for k, v in pairs(self.value) do
            if v ~= nil then
                hasValue = true
                break
            end
        end
        if not hasValue then
            NAG:Warn("[ASTCore] validate: VALUE node has no value set in value oneof")
            return false, "VALUE node has no value set in value oneof"
        end

    elseif self.type == ASTCore.NodeType.ROTATION then
        if not self.priority_list then
            NAG:Warn("[ASTCore] validate: ROTATION node missing 'priority_list' field")
            return false, "ROTATION node missing 'priority_list' field"
        end
    else
        NAG:Warn("[ASTCore] validate: Unknown node type '%s' - validation may be incomplete", tostring(self.type))
    end

    if NAG.debug then
        NAG:Info("[ASTCore] validate: Node validation successful (type='%s')", self.type)
    end
    return true, nil
end

--- Convert node to pure proto format
--- Removes metadata fields and ensures proto compatibility
--- @return table Proto-compatible data
function ASTNode:toProto()
    local proto = {
        type = self.type
    }

    -- Copy proto fields based on node type
    if self.type == ASTCore.NodeType.ACTION then
        proto.action = TableUtils.Copy(self.action)
        if self.condition then
            proto.condition = self.condition.toProto and self.condition:toProto() or TableUtils.Copy(self.condition)
        end
        if self.uuid then
            proto.uuid = self.uuid
        end

    elseif self.type == ASTCore.NodeType.VALUE then
        proto.value = TableUtils.Copy(self.value)
        if self.uuid then
            proto.uuid = self.uuid
        end

    elseif self.type == ASTCore.NodeType.ROTATION then
        proto.prepull_actions = {}
        proto.priority_list = {}
        proto.groups = {}
        proto.value_variables = {}

        -- Convert arrays
        for _, item in ipairs(self.prepull_actions or {}) do
            local protoItem = {
                type = ASTCore.NodeType.LIST_ITEM,
                hide = item.hide or false,
                notes = item.notes,
            }

            if item.action then
                -- Condition should be on the action, not the list item (per schema)
                -- If condition exists on list item (legacy), migrate it to action
                local actionProto = SerializeNode(item.action)
                if item.condition and actionProto and not actionProto.condition then
                    -- Migrate condition from list item to action (schema compliance)
                    actionProto.condition = SerializeNode(item.condition)
                end
                protoItem.action = actionProto
            end

            -- Note: condition belongs on APLAction, not APLListItem (per schema)
            -- Legacy condition on list item has been migrated to action above

            if item.do_at_value then
                protoItem.do_at_value = SerializeNode(item.do_at_value)
            end

            table.insert(proto.prepull_actions, StripInternalKeys(protoItem))
        end

        for _, item in ipairs(self.priority_list or {}) do
            local protoItem = {
                type = ASTCore.NodeType.LIST_ITEM,
                hide = item.hide or false,
                notes = item.notes,
            }

            if item.action then
                -- Condition should be on the action, not the list item (per schema)
                -- If condition exists on list item (legacy), migrate it to action
                local actionProto = SerializeNode(item.action)
                if item.condition and actionProto and not actionProto.condition then
                    -- Migrate condition from list item to action (schema compliance)
                    actionProto.condition = SerializeNode(item.condition)
                end
                protoItem.action = actionProto
            end

            -- Note: condition belongs on APLAction, not APLListItem (per schema)
            -- Legacy condition on list item has been migrated to action above

            table.insert(proto.priority_list, StripInternalKeys(protoItem))
        end

        for _, group in ipairs(self.groups or {}) do
            local protoGroup = {
                type = ASTCore.NodeType.GROUP,
                name = group.name,
                description = group.description,
                hide = group.hide,
                actions = {},
                variables = {},
            }

            for _, actionItem in ipairs(group.actions or {}) do
                table.insert(protoGroup.actions, StripInternalKeys({
                    type = ASTCore.NodeType.LIST_ITEM,
                    hide = actionItem.hide or false,
                    notes = actionItem.notes,
                    action = actionItem.action and SerializeNode(actionItem.action) or nil,
                    condition = actionItem.condition and SerializeNode(actionItem.condition) or nil,
                }))
            end

            for _, variable in ipairs(group.variables or {}) do
                table.insert(protoGroup.variables, StripInternalKeys({
                    name = variable.name,
                    hide = variable.hide,
                    value = variable.value and SerializeNode(variable.value) or nil,
                }))
            end

            table.insert(proto.groups, StripInternalKeys(protoGroup))
        end

        for _, var in ipairs(self.value_variables or {}) do
            table.insert(proto.value_variables, StripInternalKeys({
                name = var.name,
                hide = var.hide,
                value = var.value and SerializeNode(var.value) or nil,
            }))
        end
    end

    -- Do NOT include metadata in proto output
    -- originalText and sourceLocation are NAG-specific

    return proto
end

--- Create node from proto data
--- @param protoData table Proto-format data
--- @return ASTNode
function ASTCore.FromProto(protoData)
    if not protoData or not protoData.type then
        error("Invalid proto data: missing type field")
    end

    if protoData.type == ASTCore.NodeType.LIST_ITEM then
        local listItem = {
            notes = protoData.notes,
            hide = protoData.hide,
        }

        if protoData.action then
            listItem.action = ASTCore.FromProto(protoData.action)
            -- Note: condition belongs on APLAction, not APLListItem (per schema)
            -- Condition is already on the action node if present
        end

        -- Note: protoData.condition should not exist on APLListItem per schema
        -- If it exists (legacy data), it's ignored - condition should be on the action

        if protoData.do_at_value then
            listItem.do_at_value = ASTCore.FromProto(protoData.do_at_value)
        end

        return listItem
    elseif protoData.type == ASTCore.NodeType.GROUP then
        local group = {
            name = protoData.name,
            description = protoData.description,
            hide = protoData.hide,
            actions = {},
            variables = {},
        }

        for _, actionItem in ipairs(protoData.actions or {}) do
            table.insert(group.actions, ASTCore.FromProto(actionItem))
        end

        for _, variable in ipairs(protoData.variables or {}) do
            local valueVariable = {
                name = variable.name,
                hide = variable.hide,
            }

            if variable.value then
                valueVariable.value = ASTCore.FromProto(variable.value)
            end

            table.insert(group.variables, valueVariable)
        end

        return group
    end

    local node = ASTCore.CreateNode(protoData.type)

    -- Copy proto fields
    if protoData.type == ASTCore.NodeType.ACTION then
        node.action = TableUtils.Copy(protoData.action or {})
        if protoData.condition then
            node.condition = type(protoData.condition) == "table" and protoData.condition.type
                and ASTCore.FromProto(protoData.condition)
                or TableUtils.Copy(protoData.condition)
        end
        node.uuid = protoData.uuid

    elseif protoData.type == ASTCore.NodeType.VALUE then
        node.value = TableUtils.Copy(protoData.value or {})
        node.uuid = protoData.uuid

    elseif protoData.type == ASTCore.NodeType.ROTATION then
        -- Convert arrays
        for _, item in ipairs(protoData.prepull_actions or {}) do
            table.insert(node.prepull_actions, ASTCore.FromProto(item))
        end

        for _, item in ipairs(protoData.priority_list or {}) do
            table.insert(node.priority_list, ASTCore.FromProto(item))
        end

        for _, group in ipairs(protoData.groups or {}) do
            table.insert(node.groups, ASTCore.FromProto(group))
        end

        for _, var in ipairs(protoData.value_variables or {}) do
            local valueVariable = TableUtils.Copy(var) or {}

            if var.value then
                if type(var.value) == "table" and var.value.type then
                    valueVariable.value = ASTCore.FromProto(var.value)
                else
                    valueVariable.value = TableUtils.Copy(var.value)
                end
            end

            table.insert(node.value_variables, valueVariable)
        end
    end

    return node
end

--- Deep clone the node and its children
--- @return ASTNode
function ASTNode:clone()
    local cloned = ASTCore.CreateNode(self.type)

    -- Deep copy all fields
    for k, v in pairs(self) do
        if k ~= "type" then
            if type(v) == "table" then
                if v.clone then
                    cloned[k] = v:clone()
                else
                    cloned[k] = TableUtils.DeepClone(v)
                end
            else
                cloned[k] = v
            end
        end
    end

    return cloned
end

--- Get the primary type of this node
--- @return string The node type
function ASTNode:getType()
    return self.type
end

--- Check if node is of specific type
--- @param nodeType string The type to check
--- @return boolean
function ASTNode:isType(nodeType)
    return self.type == nodeType
end

--- Get a human-readable description of the node
--- @return string
function ASTNode:describe()
    if self.type == ASTCore.NodeType.ACTION then
        local actionType = "unknown"
        for k, v in pairs(self.action or {}) do
            if v and k ~= "condition" then
                actionType = k
                break
            end
        end
        return string.format("ACTION(%s)", actionType)

    elseif self.type == ASTCore.NodeType.VALUE then
        local valueType = "unknown"
        for k, v in pairs(self.value or {}) do
            if v then
                valueType = k
                break
            end
        end
        return string.format("VALUE(%s)", valueType)

    elseif self.type == ASTCore.NodeType.ROTATION then
        return string.format("ROTATION(%d items)", #(self.priority_list or {}))
    end

    return string.format("NODE(%s)", self.type)
end

--- Set metadata for debugging
--- @param originalText string|nil The original source text
--- @param line number|nil Line number
--- @param column number|nil Column number
function ASTNode:setMetadata(originalText, line, column)
    self.originalText = originalText
    if line or column then
        self.sourceLocation = {
            line = line or 0,
            column = column or 0
        }
    end
end

-- ============================ HELPER FUNCTIONS ============================

--- Check if a value is an ASTNode
--- @param value any Value to check
--- @return boolean
function ASTCore.IsNode(value)
    return type(value) == "table" and value.type and value.validate ~= nil
end

--- Generate a UUID for proto compatibility
--- @return table UUID structure
function ASTCore.GenerateUUID()
    -- Simple UUID generation for proto compatibility
    -- Format:xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx
    local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
    local uuid = string.gsub(template, "[xy]", function(c)
        local v = (c == "x") and math.random(0, 15) or math.random(8, 11)
        return string.format("%x", v)
    end)

    return { value = uuid }
end

return ASTCore

