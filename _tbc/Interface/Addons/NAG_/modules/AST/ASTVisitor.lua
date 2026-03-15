--- @module "ASTVisitor"
--- AST visitor/traversal system using the Visitor pattern
--- Provides flexible tree walking and transformation capabilities
--- License: CC BY-NC 4.0
--- Authors: Rakizi

local _, ns = ...
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local ASTCore = ns.ASTCore
local ASTAction = ns.ASTAction
local ASTValue = ns.ASTValue
local ASTRotation = ns.ASTRotation

--- @class ASTVisitor
local ASTVisitor = {}
ns.ASTVisitor = ASTVisitor

-- ============================ BASE VISITOR ============================

--- Create a new visitor instance
--- @param visitMethods table|nil Table of visit methods
--- @return table Visitor instance
function ASTVisitor.Create(visitMethods)
    NAG:Trace("[ASTVisitor] Create: Creating new visitor instance")

    local visitor = {
        -- Default visit methods (can be overridden)
        visitAction = function(self, node, context) end,
        visitValue = function(self, node, context) end,
        visitRotation = function(self, node, context) end,
        visitListItem = function(self, node, context) end,
        visitGroup = function(self, node, context) end,
        visitPrepullAction = function(self, node, context) end,

        -- Generic fallback
        visitNode = function(self, node, context) end,
    }

    -- Override with provided methods
    if visitMethods then
        local methodCount = 0
        for k, v in pairs(visitMethods) do
            visitor[k] = v
            methodCount = methodCount + 1
        end
        NAG:Debug("[ASTVisitor] Create: Overrode %d visit methods", methodCount)
    end

    NAG:Trace("[ASTVisitor] Create: Visitor instance created successfully")
    return visitor
end

-- ============================ TRAVERSAL METHODS ============================

--- Walk the AST tree, calling appropriate visitor methods
--- @param visitor table Visitor instance
--- @param ast table AST root node
--- @param context table|nil Optional context passed to visit methods
function ASTVisitor.Walk(visitor, ast, context)
    if not ast or type(ast) ~= "table" then
        -- Enhanced logging with context
        local contextInfo = {}
        if context then
            if context.fieldName then
                table.insert(contextInfo, string.format("field='%s'", context.fieldName))
            end
            if context.parentType then
                table.insert(contextInfo, string.format("parentType='%s'", context.parentType))
            end
            if context.parentValueType then
                table.insert(contextInfo, string.format("parentValueType='%s'", context.parentValueType))
            end
        end

        local contextStr = #contextInfo > 0 and (" (" .. table.concat(contextInfo, ", ") .. ")") or ""
        local valueStr = ""
        if type(ast) == "string" then
            -- Truncate long strings for readability
            local strValue = tostring(ast)
            if #strValue > 100 then
                valueStr = string.format(" (value='%s...' [%d chars])", strValue:sub(1, 100), #strValue)
            else
                valueStr = string.format(" (value='%s')", strValue)
            end
        elseif type(ast) == "number" then
            valueStr = string.format(" (value=%s)", tostring(ast))
        end

        -- Get call stack info (last 2 levels to see where it's called from)
        local stackInfo = ""
        if NAG.debugMode then
            local stack = debugstack(2, 2, 0)
            if stack then
                -- Extract just the function/file info
                local lines = {}
                for line in stack:gmatch("[^\n]+") do
                    if not line:match("^%s*%[C%]") then  -- Skip C stack frames
                        table.insert(lines, line:match("^%s*(.+)") or line)
                    end
                end
                if #lines > 0 then
                    stackInfo = string.format(" [called from: %s]", lines[1])
                end
            end
        end

        NAG:Warn("[ASTVisitor] Walk: Invalid AST node provided (type=%s)%s%s%s",
            type(ast), valueStr, contextStr, stackInfo)
        return
    end

    if not visitor or type(visitor) ~= "table" then
        NAG:Warn("[ASTVisitor] Walk: Invalid visitor provided (type=%s)", type(visitor))
        return
    end

    context = context or {}
    NAG:Trace("[ASTVisitor] Walk: Starting traversal (nodeType=%s)", ast.type or "unknown")

    -- Determine node type and call appropriate visitor
    if ast.type == ASTCore.NodeType.ACTION then
        NAG:Trace("[ASTVisitor] Walk: Visiting ACTION node")
        visitor:visitAction(ast, context)

        -- Visit condition if present
        if ast.condition then
            NAG:Trace("[ASTVisitor] Walk: Visiting ACTION condition")
            local childContext = context or {}
            childContext.fieldName = "condition"
            childContext.parentType = ASTCore.NodeType.ACTION
            ASTVisitor.Walk(visitor, ast.condition, childContext)
        end

        -- Visit nested actions (sequences, etc.)
        local actionData = ASTAction.GetActionData(ast)
        if actionData then
            if actionData.actions then
                NAG:Trace("[ASTVisitor] Walk: Visiting %d nested actions", #actionData.actions)
                for i, action in ipairs(actionData.actions) do
                    local childContext = context or {}
                    childContext.fieldName = string.format("actions[%d]", i)
                    childContext.parentType = ASTCore.NodeType.ACTION
                    ASTVisitor.Walk(visitor, action, childContext)
                end
            end
            if actionData.inner_action then
                NAG:Trace("[ASTVisitor] Walk: Visiting inner action")
                local childContext = context or {}
                childContext.fieldName = "inner_action"
                childContext.parentType = ASTCore.NodeType.ACTION
                ASTVisitor.Walk(visitor, actionData.inner_action, childContext)
            end
        end

    elseif ast.type == ASTCore.NodeType.VALUE then
        NAG:Trace("[ASTVisitor] Walk: Visiting VALUE node")
        visitor:visitValue(ast, context)

        -- Visit child values for operators
        local valueData = ASTValue.GetValueData(ast)
        local valueType = ASTValue.GetValueType(ast)

        if valueData then
            -- Logical operators: and, or (have vals array)
            if valueData.vals then
                NAG:Trace("[ASTVisitor] Walk: Visiting %d value operands", #valueData.vals)
                for i, val in ipairs(valueData.vals) do
                    local childContext = context or {}
                    childContext.fieldName = string.format("vals[%d]", i)
                    childContext.parentType = ASTCore.NodeType.VALUE
                    childContext.parentValueType = valueType
                    ASTVisitor.Walk(visitor, val, childContext)
                end
            end

            -- NOT operator (has val field containing a child AST node)
            -- NOTE: For const nodes, valueData.val is the actual value (string/number), NOT a child node
            -- So we only traverse val for NOT operators, not for const nodes
            if valueType == ASTValue.ValueType.NOT and valueData.val then
                NAG:Trace("[ASTVisitor] Walk: Visiting NOT operand")
                local childContext = context or {}
                childContext.fieldName = "val"
                childContext.parentType = ASTCore.NodeType.VALUE
                childContext.parentValueType = valueType
                ASTVisitor.Walk(visitor, valueData.val, childContext)
            end

            -- Binary operators: cmp, math (have lhs and rhs)
            if valueData.lhs then
                NAG:Trace("[ASTVisitor] Walk: Visiting binary operator lhs")
                local childContext = context or {}
                childContext.fieldName = "lhs"
                childContext.parentType = ASTCore.NodeType.VALUE
                childContext.parentValueType = valueType
                ASTVisitor.Walk(visitor, valueData.lhs, childContext)
            end
            if valueData.rhs then
                NAG:Trace("[ASTVisitor] Walk: Visiting binary operator rhs")
                local childContext = context or {}
                childContext.fieldName = "rhs"
                childContext.parentType = ASTCore.NodeType.VALUE
                childContext.parentValueType = valueType
                ASTVisitor.Walk(visitor, valueData.rhs, childContext)
            end
        end

    elseif ast.type == ASTCore.NodeType.ROTATION then
        NAG:Debug("[ASTVisitor] Walk: Visiting ROTATION node")
        visitor:visitRotation(ast, context)

        -- Visit prepull actions
        local prepullCount = #(ast.prepull_actions or {})
        if prepullCount > 0 then
            NAG:Trace("[ASTVisitor] Walk: Visiting %d prepull actions", prepullCount)
            for i, prepullAction in ipairs(ast.prepull_actions) do
                visitor:visitPrepullAction(prepullAction, context)
                if prepullAction.action then
                    local childContext = context or {}
                    childContext.fieldName = string.format("prepull_actions[%d].action", i)
                    childContext.parentType = ASTCore.NodeType.ROTATION
                    ASTVisitor.Walk(visitor, prepullAction.action, childContext)
                end
            end
        end

        -- Visit priority list
        local priorityCount = #(ast.priority_list or {})
        if priorityCount > 0 then
            NAG:Trace("[ASTVisitor] Walk: Visiting %d priority list items", priorityCount)
            for i, listItem in ipairs(ast.priority_list) do
                visitor:visitListItem(listItem, context)
                if listItem.action then
                    local childContext = context or {}
                    childContext.fieldName = string.format("priority_list[%d].action", i)
                    childContext.parentType = ASTCore.NodeType.ROTATION
                    ASTVisitor.Walk(visitor, listItem.action, childContext)
                end
            end
        end

        -- Visit groups
        local groupCount = #(ast.groups or {})
        if groupCount > 0 then
            NAG:Trace("[ASTVisitor] Walk: Visiting %d groups", groupCount)
            for groupIdx, group in ipairs(ast.groups) do
                visitor:visitGroup(group, context)
                local actionCount = #(group.actions or {})
                if actionCount > 0 then
                    NAG:Trace("[ASTVisitor] Walk: Visiting %d actions in group", actionCount)
                    for actionIdx, listItem in ipairs(group.actions) do
                        visitor:visitListItem(listItem, context)
                        if listItem.action then
                            local childContext = context or {}
                            childContext.fieldName = string.format("groups[%d].actions[%d].action", groupIdx, actionIdx)
                            childContext.parentType = ASTCore.NodeType.ROTATION
                            ASTVisitor.Walk(visitor, listItem.action, childContext)
                        end
                    end
                end
            end
        end

    else
        -- Generic node visit
        NAG:Trace("[ASTVisitor] Walk: Visiting generic node (type=%s)", tostring(ast.type))
        visitor:visitNode(ast, context)
    end
end

--- Pre-order traversal (visit parent before children)
--- @param ast table AST root node
--- @param callback function Callback function(node, context)
--- @param context table|nil Optional context
function ASTVisitor.PreOrder(ast, callback, context)
    NAG:Debug("[ASTVisitor] PreOrder: Starting pre-order traversal")

    if not callback or type(callback) ~= "function" then
        NAG:Warn("[ASTVisitor] PreOrder: Invalid callback provided (type=%s)", type(callback))
        return
    end

    local visitor = ASTVisitor.Create({
        visitAction = function(self, node, ctx)
            callback(node, ctx)
        end,
        visitValue = function(self, node, ctx)
            callback(node, ctx)
        end,
        visitRotation = function(self, node, ctx)
            callback(node, ctx)
        end,
    })

    ASTVisitor.Walk(visitor, ast, context)
    NAG:Trace("[ASTVisitor] PreOrder: Pre-order traversal completed")
end

--- Post-order traversal (visit children before parent)
--- @param ast table AST root node
--- @param callback function Callback function(node, context)
--- @param context table|nil Optional context
function ASTVisitor.PostOrder(ast, callback, context)
    if not ast or type(ast) ~= "table" then
        NAG:Warn("[ASTVisitor] PostOrder: Invalid AST node provided (type=%s)", type(ast))
        return
    end

    if not callback or type(callback) ~= "function" then
        NAG:Warn("[ASTVisitor] PostOrder: Invalid callback provided (type=%s)", type(callback))
        return
    end

    NAG:Debug("[ASTVisitor] PostOrder: Starting post-order traversal")
    context = context or {}

    -- Visit children first
    if ast.type == ASTCore.NodeType.ACTION then
        if ast.condition then
            ASTVisitor.PostOrder(ast.condition, callback, context)
        end

        local actionData = ASTAction.GetActionData(ast)
        if actionData then
            if actionData.actions then
                for _, action in ipairs(actionData.actions) do
                    ASTVisitor.PostOrder(action, callback, context)
                end
            end
        end

    elseif ast.type == ASTCore.NodeType.VALUE then
        local valueData = ASTValue.GetValueData(ast)
        if valueData then
            if valueData.vals then
                for _, val in ipairs(valueData.vals) do
                    ASTVisitor.PostOrder(val, callback, context)
                end
            end
            if valueData.val then
                ASTVisitor.PostOrder(valueData.val, callback, context)
            end
            if valueData.lhs then
                ASTVisitor.PostOrder(valueData.lhs, callback, context)
            end
            if valueData.rhs then
                ASTVisitor.PostOrder(valueData.rhs, callback, context)
            end
        end

    elseif ast.type == ASTCore.NodeType.ROTATION then
        for _, prepullAction in ipairs(ast.prepull_actions or {}) do
            if prepullAction.action then
                ASTVisitor.PostOrder(prepullAction.action, callback, context)
            end
        end

        for _, listItem in ipairs(ast.priority_list or {}) do
            if listItem.action then
                ASTVisitor.PostOrder(listItem.action, callback, context)
            end
        end

        for _, group in ipairs(ast.groups or {}) do
            for _, listItem in ipairs(group.actions or {}) do
                if listItem.action then
                    ASTVisitor.PostOrder(listItem.action, callback, context)
                end
            end
        end
    end

    -- Then visit the node itself
    callback(ast, context)
    NAG:Trace("[ASTVisitor] PostOrder: Post-order traversal completed")
end

-- ============================ UTILITY VISITORS ============================

--- Find nodes matching a predicate
--- @param ast table AST root node
--- @param predicate function Function(node) that returns true for matching nodes
--- @return table[] Array of matching nodes
function ASTVisitor.FindNodes(ast, predicate)
    if not predicate or type(predicate) ~= "function" then
        NAG:Warn("[ASTVisitor] FindNodes: Invalid predicate provided (type=%s)", type(predicate))
        return {}
    end

    NAG:Debug("[ASTVisitor] FindNodes: Searching for matching nodes")
    local matches = {}

    ASTVisitor.PreOrder(ast, function(node)
        if predicate(node) then
            table.insert(matches, node)
        end
    end)

    NAG:Info("[ASTVisitor] FindNodes: Found %d matching nodes", #matches)
    return matches
end

--- Count nodes matching a predicate
--- @param ast table AST root node
--- @param predicate function Function(node) that returns true for matching nodes
--- @return number Count of matching nodes
function ASTVisitor.CountNodes(ast, predicate)
    if not predicate or type(predicate) ~= "function" then
        NAG:Warn("[ASTVisitor] CountNodes: Invalid predicate provided (type=%s)", type(predicate))
        return 0
    end

    NAG:Debug("[ASTVisitor] CountNodes: Counting matching nodes")
    local count = 0

    ASTVisitor.PreOrder(ast, function(node)
        if predicate(node) then
            count = count + 1
        end
    end)

    NAG:Info("[ASTVisitor] CountNodes: Found %d matching nodes", count)
    return count
end

--- Find first node matching a predicate
--- @param ast table AST root node
--- @param predicate function Function(node) that returns true for matching node
--- @return table|nil First matching node
function ASTVisitor.FindFirst(ast, predicate)
    if not predicate or type(predicate) ~= "function" then
        NAG:Warn("[ASTVisitor] FindFirst: Invalid predicate provided (type=%s)", type(predicate))
        return nil
    end

    NAG:Debug("[ASTVisitor] FindFirst: Searching for first matching node")
    local found = nil
    local searchDone = false

    ASTVisitor.PreOrder(ast, function(node)
        if not searchDone and predicate(node) then
            found = node
            searchDone = true
            NAG:Trace("[ASTVisitor] FindFirst: Found matching node (type=%s)", node.type or "unknown")
        end
    end)

    if found then
        NAG:Info("[ASTVisitor] FindFirst: Found matching node")
    else
        NAG:Trace("[ASTVisitor] FindFirst: No matching node found")
    end

    return found
end

--- Transform AST by replacing nodes
--- @param ast table AST root node
--- @param transformer function Function(node) that returns replacement node or nil to keep original
--- @return table Transformed AST
function ASTVisitor.Transform(ast, transformer)
    if not ast or type(ast) ~= "table" then
        NAG:Warn("[ASTVisitor] Transform: Invalid AST node provided (type=%s)", type(ast))
        return ast
    end

    if not transformer or type(transformer) ~= "function" then
        NAG:Warn("[ASTVisitor] Transform: Invalid transformer provided (type=%s)", type(transformer))
        return ast
    end

    NAG:Debug("[ASTVisitor] Transform: Transforming AST (nodeType=%s)", ast.type or "unknown")

    -- Try to transform this node
    local transformed = transformer(ast)
    if transformed and transformed ~= ast then
        NAG:Trace("[ASTVisitor] Transform: Node transformed")
        return transformed
    end

    -- Otherwise clone and transform children
    local TableUtils = ns.TableUtils
    local cloned = ast.clone and ast:clone() or TableUtils.Copy(ast)

    if cloned.type == ASTCore.NodeType.ACTION then
        if cloned.condition then
            cloned.condition = ASTVisitor.Transform(cloned.condition, transformer)
        end

    elseif cloned.type == ASTCore.NodeType.VALUE then
        local valueData = ASTValue.GetValueData(cloned)
        if valueData then
            if valueData.vals then
                for i, val in ipairs(valueData.vals) do
                    valueData.vals[i] = ASTVisitor.Transform(val, transformer)
                end
            end
            if valueData.val then
                valueData.val = ASTVisitor.Transform(valueData.val, transformer)
            end
            if valueData.lhs then
                valueData.lhs = ASTVisitor.Transform(valueData.lhs, transformer)
            end
            if valueData.rhs then
                valueData.rhs = ASTVisitor.Transform(valueData.rhs, transformer)
            end
        end

    elseif cloned.type == ASTCore.NodeType.ROTATION then
        for _, listItem in ipairs(cloned.priority_list or {}) do
            if listItem.action then
                listItem.action = ASTVisitor.Transform(listItem.action, transformer)
            end
        end
    end

    NAG:Trace("[ASTVisitor] Transform: Transformation completed")
    return cloned
end

--- Collect all nodes of a specific type
--- @param ast table AST root node
--- @param nodeType string Type to collect (action, value, rotation)
--- @return table[] Array of matching nodes
function ASTVisitor.CollectByType(ast, nodeType)
    if not nodeType or type(nodeType) ~= "string" then
        NAG:Warn("[ASTVisitor] CollectByType: Invalid nodeType provided (type=%s)", type(nodeType))
        return {}
    end

    NAG:Debug("[ASTVisitor] CollectByType: Collecting nodes of type '%s'", nodeType)
    local matches = ASTVisitor.FindNodes(ast, function(node)
        return node.type == nodeType
    end)

    NAG:Info("[ASTVisitor] CollectByType: Collected %d nodes of type '%s'", #matches, nodeType)
    return matches
end

--- Get the depth of the AST tree
--- @param ast table AST root node
--- @return number Maximum depth
function ASTVisitor.GetDepth(ast)
    if not ast or type(ast) ~= "table" then
        NAG:Warn("[ASTVisitor] GetDepth: Invalid AST node provided (type=%s)", type(ast))
        return 0
    end

    NAG:Debug("[ASTVisitor] GetDepth: Calculating AST depth")
    local maxDepth = 0

    local function visit(node, depth)
        if not node or type(node) ~= "table" then
            return
        end

        maxDepth = math.max(maxDepth, depth)
        NAG:Trace("[ASTVisitor] GetDepth: Visiting node at depth %d (type=%s)", depth, node.type or "unknown")

        -- Recurse to children
        if node.type == ASTCore.NodeType.ACTION then
            if node.condition then
                visit(node.condition, depth + 1)
            end
        elseif node.type == ASTCore.NodeType.VALUE then
            local valueData = ASTValue.GetValueData(node)
            if valueData then
                if valueData.vals then
                    for _, val in ipairs(valueData.vals) do
                        visit(val, depth + 1)
                    end
                end
                if valueData.lhs then
                    visit(valueData.lhs, depth + 1)
                end
                if valueData.rhs then
                    visit(valueData.rhs, depth + 1)
                end
            end
        elseif node.type == ASTCore.NodeType.ROTATION then
            for _, listItem in ipairs(node.priority_list or {}) do
                if listItem.action then
                    visit(listItem.action, depth + 1)
                end
            end
        end
    end

    visit(ast, 0)
    NAG:Info("[ASTVisitor] GetDepth: Maximum depth is %d", maxDepth)
    return maxDepth
end

return ASTVisitor

