--- @module "NAG.APLMonitor"
--- Debugging and visualizing action priority lists (APL) for NAG
---
--- Provides a UI for monitoring and analyzing APL conditions in real time.
--- Useful for developers and advanced users to debug rotations.
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold
--
-- luacheck: ignore GetSpellInfo


-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~--
local _, ns = ...
local CreateFrame = _G.CreateFrame
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS (NEW PATTERN) ~~~~~~~~~~
-- Declare all Ace3 module locals at the top of the file
-- These will be assigned in OnEnable to avoid expensive metatable access
local StringUtil = ns.StringUtil

--- @type DataManager
--- @type StateManager
local DataManager, StateManager

--- @type DisplayManager
local DisplayManager


local L = ns.AceLocale:GetLocale("NAG", true)
local LSM = ns.LibSharedMedia


local AceGUI = ns.AceGUI

-- Lua APIs (WoW-optimized versions where available)
local GetCursorPosition = _G.GetCursorPosition
local GetScreenWidth = _G.GetScreenWidth
local min = math.min
local max = math.max


-- Table operations
local tinsert = tinsert     -- WoW's optimized version


-- Enhanced error handling
local pcall = ns.pcall
local TableUtils = ns.TableUtils

-- ~~~~~~~~~~ CONTENT ~~~~~~~~~~

-- Constants
local DisplayMode = {
    SIMPLE = 1,
    GROUPED = 2
}

-- Default settings
local defaults = {
    global = {
        displayMode = DisplayMode.SIMPLE,
        updateInterval = 0.1,
        maxConditions = 100,
        useDebugFrame = false, -- Toggle between new DebugFrame and old CreateFrame
        enabled = false, -- Disabled by default, hidden behind DevMode
        appearance = {
            fontSize = 12,
            font = "Friz Quadrata TT",
            fontOutline = "OUTLINE",
            colors = {
                header = { 1.0, 0.84, 0.0, 1.0 },
                active = { 0.0, 1.0, 0.0, 1.0 },
                inactive = { 0.4, 0.4, 0.4, 1.0 },
                operator = { 0.5, 0.5, 0.5, 1.0 }
            },
            frameWidth = GetScreenWidth() * 0.75,
            frameHeight = 400,
            position = { point = "TOPLEFT", x = 0, y = -125 }
        },
        filters = {
            Sequence = true,
            Other = true,
            Distance = true,
            Targets = true,
            Time = true,
            Execute = true,
            ["Buffs/Auras"] = true,
            DoTs = true,
            Resources = true,
            Cast = true,
        },
        monitorFramePosition = { point = "TOPLEFT", x = 0, y = -125 } -- Store frame position in global settings
    }
}

--- @class APLMonitor: CoreModule
local APLMonitor = NAG:CreateModule("APLMonitor", defaults, {
    moduleType = ns.MODULE_TYPES.FEATURE,
    -- Subscribe to rotation updates instead of polling each frame
    messageHandlers = {
        NAG_ROTATION_CHANGED = true,           -- Unified rotation change message
    },
    -- Register events for display state management
    eventHandlers = {
        PLAYER_REGEN_DISABLED = true,  -- Enter combat
        PLAYER_REGEN_ENABLED = true,   -- Exit combat
        PLAYER_TARGET_CHANGED = true,  -- Target changed
    },

    -- Override default enabled state for this specific module
    defaultState = {
        selectedRotation = nil,
        hiddenConditions = {}
    },
    -- Debug categories for group-based debugging
    debugCategories = {
        ns.DEBUG_CATEGORIES.DEBUG,
        ns.DEBUG_CATEGORIES.FEATURES
    },
    optionsCategory = ns.MODULE_CATEGORIES.DEBUG,

    -- Slash commands using zero-boilerplate pattern
    slashCommands = {
        ["aplmonitor"] = {
            handler = "ToggleFrame",
            help = "Toggle the APL Monitor interface",
            aliases = {"aplmon"},
            root = "nagdebug",
            category = "Debug"
        },
        ["aplmonitorhelp"] = {
            handler = "ShowHelp",
            help = "Show help for the APL Monitor interface",
            root = "nagdebug",
            category = "Debug"
        }
    }
})
local module = APLMonitor
ns.APLMonitor = APLMonitor

-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~
do
    function APLMonitor:ModuleEnable()
        -- Check if APL Monitor is enabled in settings (hidden behind DevMode)
        if not self.db.global.enabled then
            self:Debug("APL Monitor disabled - not showing frame")
            return
        end

        -- Initialize cached rotation from current class module once
        local classModule = NAG:GetClassModule()
        if classModule then
            local rotationConfig = select(1, classModule:GetCurrentRotation())
            if rotationConfig and rotationConfig.rotationString then
                self:SetState("rotationString", rotationConfig.rotationString)
            end
        end

        -- Start update timer
        self.debugTimer = self:ScheduleRepeatingTimer("Update", self.db.global.updateInterval)

        -- Only show frame if enabled AND NAG:ShouldShowDisplay() says we should
        -- This follows the same rules as the main NAG display (combat state, target state, etc.)
        if NAG:ShouldShowDisplay() then
            self:ShowFrame()
            self:Info("APL Monitor enabled and frame shown")
        else
            self:Info("APL Monitor enabled (frame hidden - not in combat/target state)")
        end
    end

    function APLMonitor:ModuleDisable()
        -- Clean up UI and resources

        self:HideFrame()

        -- Cancel timer
        if self.debugTimer then
            self:CancelTimer(self.debugTimer)
            self.debugTimer = nil
        end

        -- Clean up frame references
        self:CleanupFrame()

        -- Clear state
        self.lastSpecIndex = nil
        self.debugDisplayMode = nil
    end

    -- Event handlers for display state management
    function APLMonitor:PLAYER_REGEN_DISABLED()
        -- Entered combat - update frame visibility
        self:UpdateFrameVisibility()
    end

    function APLMonitor:PLAYER_REGEN_ENABLED()
        -- Exited combat - update frame visibility
        self:UpdateFrameVisibility()
    end

    function APLMonitor:PLAYER_TARGET_CHANGED()
        -- Target changed - update frame visibility
        self:UpdateFrameVisibility()
    end

    --- Update frame visibility based on enabled state and NAG:ShouldShowDisplay()
    function APLMonitor:UpdateFrameVisibility()
        if not self.frame then return end

        -- First check if APL Monitor is even enabled
        if not self.db.global.enabled then
            if self.frame and self.frame:IsShown() then
                self:HideFrame()
                self:Debug("Frame hidden - APL Monitor disabled")
            end
            return
        end

        -- Then check display conditions
        local shouldShow = NAG:ShouldShowDisplay()
        if shouldShow then
            if self.frame and not self.frame:IsShown() then
                self:ShowFrame()
                self:Debug("Frame shown due to display conditions met")
            end
        else
            if self.frame and self.frame:IsShown() then
                self:HideFrame()
                self:Debug("Frame hidden due to display conditions not met")
            end
        end
    end

    function APLMonitor:ModuleInitialize()
        -- Get required modules
        -- ============================ MODULE ASSIGNMENT ============================
        -- Assign Ace3 modules directly (no metatable access)
        DataManager = NAG:GetModule("DataManager")
        DisplayManager = NAG:GetModule("DisplayManager")
        StateManager = NAG:GetModule("StateManager")

        -- ============================ MODULE INITIALIZATION ============================

                        -- Slash commands are now handled via zero-boilerplate slashCommands table

        -- Initialize state
        self.lastSpecIndex = nil
        self.debugDisplayMode = self.db.global.displayMode
    end
end
function APLMonitor:EnsureASTData()
    -- Early return if we already have data (no logging needed - this is called frequently)
    if self.state.treeStructure then
        return
    end

    -- No tree structure, get aplProto from current rotation
    self:Debug("APLMonitor: No tree structure found, attempting to get rotation AST...")

    local rotationManager = NAG:GetModule("RotationManager")
    local classModule = NAG:GetClassModule()

    if not classModule then
        self:Debug("APLMonitor: ClassModule not available")
        return
    end

    local rotation = classModule:GetCurrentRotation()
    if not rotation or not rotation.aplProto then
        -- Try to get rotation with proto
        local config, rotationName = classModule:GetCurrentRotation()
        if config and rotationName then
            local specIndex = config.specIndex or 0
            rotation, _ = rotationManager:GetRotationWithProto(specIndex, rotationName)
        end

        if not rotation or not rotation.aplProto then
            self:Warn("EnsureASTData: No aplProto available")
            return
        end
    end

    local ast = rotation.aplProto
    self.state.ast = ast

    -- Update tree structure if needed
            if ast then
        local NAGStringParser = NAG:GetModule("NAGStringParser")
        if NAGStringParser then
                self.state.parsedAST = ast
                self.state.treeStructure = NAGStringParser:GetTreeStructure(ast)
            self:Debug("APLMonitor: Got AST with " .. #(ast.priority_list or {}) .. " clauses")
                self:Debug("APLMonitor: Tree structure created with " ..
                    (self.state.treeStructure and #self.state.treeStructure.children or 0) .. " root nodes")
            end
    end
end -- ~~~~~~~~~~ EVENT HANDLERS & HELPERS ~~~~~~~~~~

function APLMonitor:NAG_ROTATION_CHANGED(message, payload)
    self:Debug("APLMonitor: NAG_ROTATION_CHANGED received (action: %s, dataChanged: %s, selectionChanged: %s)",
        payload and payload.action or "unknown",
        payload and tostring(payload.dataChanged) or "unknown",
        payload and tostring(payload.selectionChanged) or "unknown")

    -- Invalidate cached data - parsing will happen lazily via EnsureASTData() when needed
    self.state.rotationString = nil
    self.state.parsedAST = nil
    self.state.treeStructure = nil

    -- If the frame is visible, refresh immediately (EnsureASTData will be called during Update)
    if self.frame and self.frame:IsShown() then
        self:Update()
    end
end

local function splitSubConditions(condition)
    -- Remove outermost parentheses if they enclose the entire condition
    if condition:sub(1, 1) == "(" and condition:sub(-1, -1) == ")" then
        local tempCondition = condition:sub(2, -2)
        local balance = 0
        local isEnclosed = true
        for i = 1, #tempCondition do
            local char = tempCondition:sub(i, i)
            if char == "(" then
                balance = balance + 1
            elseif char == ")" then
                balance = balance - 1
                if balance < 0 then
                    isEnclosed = false
                    break
                end
            end
        end
        if isEnclosed and balance == 0 then
            condition = tempCondition
        end
    end

    local subConditions = {}
    local operators = {}
    local parenthesisLevel = 0
    local lastSplitIndex = 1
    local i = 1

    while i <= #condition do
        local char = condition:sub(i, i)
        if char == "(" then
            parenthesisLevel = parenthesisLevel + 1
        elseif char == ")" then
            parenthesisLevel = parenthesisLevel - 1
        elseif parenthesisLevel == 0 then
            local nextChars = condition:sub(i, i + 3)
            if nextChars:match("^%s*and%s*") or nextChars:match("^%s*or%s*") then
                -- Match the operator pattern to get the full length (including whitespace)
                local operatorMatch = nextChars:match("^(%s*and%s*)") or nextChars:match("^(%s*or%s*)")
                if operatorMatch then
                    local subCondition = condition:sub(lastSplitIndex, i - 1):match("^%s*(.-)%s*$")
                    -- Only add non-empty conditions with meaningful content
                    if subCondition and subCondition ~= "" and #subCondition:gsub("%s", "") > 2 then
                        tinsert(subConditions, subCondition)
                        tinsert(operators, operatorMatch:match("%s*(%S+)%s*"))  -- Extract just the operator word
                    end
                    i = i + #operatorMatch  -- Skip the full operator match (including whitespace)
                    lastSplitIndex = i  -- Start next condition at current position (after operator)
                end
            end
        end
        i = i + 1
    end

    if lastSplitIndex <= #condition then
        local subCondition = condition:sub(lastSplitIndex):match("^%s*(.-)%s*$")
        -- Only add non-empty conditions with meaningful content
        if subCondition and subCondition ~= "" and #subCondition:gsub("%s", "") > 2 then
            tinsert(subConditions, subCondition)
        end
    end

    -- If no splits were made and the condition is complex, return it as a single condition
    if #subConditions == 0 then
        return { condition }
    end

    return subConditions, operators
end

-- Splits a rotation string into top-level OR clauses, respecting parentheses and line comments
local function splitTopLevelOrClauses(text)
    if not text or text == "" then return {} end

    local clauses = {}
    local parenLevel = 0
    local inString = false
    local stringQuote = nil
    local i = 1
    local last = 1

    local function trimAndStripComments(s)
        -- strip line comments and trim
        s = s:gsub("%-%-[^\n]*", "")
        return (s:match("^%s*(.-)%s*$"))
    end

    while i <= #text do
        local ch = text:sub(i, i)
        local two = text:sub(i, i + 1)

        local advanced = false
        if not inString then
            -- skip single-line comments
            if two == "--" then
                local nl = text:find("\n", i + 2, true)
                if not nl then
                    -- rest is comment; stop scanning
                    break
                else
                    i = nl + 1
                    advanced = true
                end
            else
                if ch == '"' or ch == "'" then
                    inString = true
                    stringQuote = ch
                elseif ch == "(" then
                    parenLevel = parenLevel + 1
                elseif ch == ")" then
                    parenLevel = parenLevel - 1
                end

                if parenLevel == 0 then
                    -- detect top-level OR with surrounding whitespace
                    local rest = text:sub(i)
                    local m = rest:match("^%s+or%s+")
                    if m then
                        local clause = trimAndStripComments(text:sub(last, i - 1))
                        if clause and clause ~= "" then tinsert(clauses, clause) end
                        i = i + #m
                        last = i
                        advanced = true
                    end
                end
            end
        else
            if ch == stringQuote then
                inString = false
                stringQuote = nil
            end
        end

        if not advanced then
            i = i + 1
        end
    end

    -- tail
    if last <= #text then
        local clause = trimAndStripComments(text:sub(last))
        if clause and clause ~= "" then tinsert(clauses, clause) end
    end

    return clauses
end

local function evaluateCondition(condition)
    -- Handle empty or invalid conditions
    if not condition or type(condition) ~= "string" then
        return false
    end

    -- Trim and strip any remaining comments (safety check)
    local trimmed = condition:gsub("%-%-[^\n]*", ""):match("^%s*(.-)%s*$")
    if not trimmed or trimmed == "" then
        return false
    end

    -- Ignore fragments that are only punctuation/parentheses (common during splitting)
    if trimmed == "and" or trimmed == "or" then
        return false
    end

    -- Must contain at least one word character, colon, or parenthesis to be valid code
    if not trimmed:match("[%w_:%(%)]") then
        return false
    end

    -- Skip fragments that look like function calls without NAG: or self: prefix
    -- This catches cases where splitting creates fragments like "ShouldInterrupt()" 
    -- instead of "NAG:WarriorShouldInterrupt()"
    if trimmed:match("^%s*[%w_]+%s*%(") and not trimmed:match("NAG:") and not trimmed:match("self:") and not trimmed:match("Unit") then
        return false
    end

    -- Skip fragments with unbalanced parentheses to avoid loadstring errors
    local balance = 0
    for i = 1, #trimmed do
        local ch = trimmed:sub(i, i)
        if ch == "(" then
            balance = balance + 1
        elseif ch == ")" then
            balance = balance - 1
            if balance < 0 then return false end
        end
    end
    if balance ~= 0 then return false end

    -- If this is a pure action call (no comparisons/logical ops), do not evaluate to avoid side effects
    if trimmed:find("NAG:") and not trimmed:find("[<>=]") and not trimmed:match("%f[%w]and%f[%W]") and not trimmed:match("%f[%w]or%f[%W]") then
        return false
    end

    -- Validate: Skip conditions that are clearly invalid fragments (empty or meaningless)
    if trimmed:match("^%s*%(%)%s*$") or trimmed == "" then
        return false
    end

    -- Replace NAG: with self: for evaluation (use trimmed version to ensure no comments)
    local evalCondition = trimmed:gsub("NAG:", "self:")

    -- Create a protected environment for evaluation
    local env = setmetatable({
        self = setmetatable({}, {
            __index = function(_, key)
                -- Explicit safe wrappers for commonly used query functions
                if key == "Wait" then
                    -- In monitor, Wait should never activate a condition on its own
                    return function() return false end
                elseif key == "Cast" then
                    return function(_, spellId) return NAG:SpellCanCast(spellId) end
                elseif key == "TimeToReady" then
                    return function(_, spellId) return NAG:TimeToReady(spellId) end
                elseif key == "RemainingTime" then
                    return function() return NAG:RemainingTime() end
                elseif key == "NumberTargets" then
                    return function(_, range) return NAG:NumberTargets(range) end
                elseif key == "StrictSequence" or key == "AutocastOtherCooldowns" or key == "SelectRotation" or key == "GetBattlePotion" or key == "CancelAura" then
                    -- Neutralize stateful/action methods during monitor evaluation
                    return function() return false end
                end

                -- Default: bind methods to the real NAG as self to avoid passing the sandbox table
                local value = NAG[key]
                if type(value) == "function" then
                    return function(_, ...)
                        return value(NAG, ...)
                    end
                end
                return value
            end
        }),
    }, { __index = _G })

    -- Create and load the function with error handling (use cleaned condition)
    local func, err = loadstring("return " .. evalCondition)
    if not func then
        APLMonitor:Debug("Error creating function for condition: " .. tostring(err))
        return false
    end

    -- Set the protected environment
    setfenv(func, env)

    -- Execute with pcall for safety
    local success, result = pcall(func)
    if not success then
        APLMonitor:Debug("Error evaluating condition: " .. tostring(result))
        return false
    end

    return result
end

local function highlightCondition(condition)
    -- Handle empty or invalid conditions
    if not condition or type(condition) ~= "string" then
        return ""
    end

    -- Strip comments and trim
    local trimmedCondition = condition:gsub("%-%-[^\n]*", ""):match("^%s*(.-)%s*$")
    if not trimmedCondition or trimmedCondition == "" then
        return ""
    end

    -- Handle logical operators
    if trimmedCondition == "and" or trimmedCondition == "or" then
        return "|cff808080" .. trimmedCondition .. "|r"
    end

    -- Extract spell/item ID from condition using comprehensive patterns
    -- This covers all NAG function variations that take spell/item IDs as parameters
    local id = trimmedCondition:match("NAG:[%w]*Cast[%w]*%((%d+)%)")
        or trimmedCondition:match("NAG:[%w]*SpellCanCast[%w]*%((%d+)%)")
        or trimmedCondition:match("NAG:[%w]*IsReady[%w]*%((%d+)%)")
        or trimmedCondition:match("NAG:[%w]*IsActive[%w]*%((%d+)%)")
        or trimmedCondition:match("NAG:[%w]*TimeToReady[%w]*%((%d+)%)")
        or trimmedCondition:match("NAG:[%w]*NumStacks[%w]*%((%d+)%)")
        or trimmedCondition:match("NAG:[%w]*IsKnown[%w]*%((%d+)%)")
        or trimmedCondition:match("NAG:[%w]*AuraNumStacks[%w]*%((%d+)%)")
        or trimmedCondition:match("NAG:[%w]*DotNumStacks[%w]*%((%d+)%)")
        or trimmedCondition:match("NAG:[%w]*AuraRemainingTime[%w]*%((%d+)%)")
        or trimmedCondition:match("NAG:[%w]*DotRemainingTime[%w]*%((%d+)%)")
        or trimmedCondition:match("NAG:[%w]*AuraIsActiveWithReactionTime[%w]*%((%d+)%)")
        -- Additional patterns for missing functions
        or trimmedCondition:match("NAG:[%w]*AuralsActive[%w]*%((%d+)%)")
        or trimmedCondition:match("NAG:[%w]*AuralsInactiveWithReactionTime[%w]*%((%d+)%)")
        or trimmedCondition:match("NAG:[%w]*SpellTimeReady[%w]*%((%d+)%)")
        or trimmedCondition:match("NAG:[%w]*SpellIsKnown[%w]*%((%d+)%)")
        or trimmedCondition:match("NAG:[%w]*SpellNumCharges[%w]*%((%d+)%)")
        or trimmedCondition:match("NAG:[%w]*DotIsActive[%w]*%((%d+)%)")
        or trimmedCondition:match("NAG:[%w]*ItemRemainingTime[%w]*%((%d+)%)")
        or trimmedCondition:match("NAG:[%w]*IsTotemActive[%w]*%((%d+)%)")
        -- Generic pattern to catch any NAG function with numeric ID parameter
        or trimmedCondition:match("NAG:[%w]+%((%d+)%)")

    -- Get name from DataManager if ID found
    local displayText = trimmedCondition
    if id then
        id = tonumber(id)
        local entity = DataManager:Get(id, DataManager.EntityTypes.SPELL) or
            DataManager:Get(id, DataManager.EntityTypes.ITEM)
        if entity and entity.name then
            -- Generate unique color for this name
            local nameColor = StringUtil.GetNameColor(entity.name)
            -- Replace ID with colored name
            displayText = displayText:gsub(tostring(id), nameColor .. entity.name .. "|r")
        end
    end

    -- Evaluate the condition safely (strip trailing action calls first)
    local function stripTrailingAction(expr)
        if not expr then return expr end
        local i = #expr
        local paren = 0
        while i > 0 do
            local ch = expr:sub(i, i)
            if ch == ')' then
                paren = paren + 1
            elseif ch == '(' then
                paren = paren - 1
            end
            -- look for " and NAG:" at top level
            if paren == 0 then
                local seg = expr:sub(1, i)
                local j = seg:find("%s+and%s+NAG:")
                if j then
                    return expr:sub(1, j - 1)
                end
            end
            i = i - 1
        end
        return expr
    end

    local evalExpr = stripTrailingAction(trimmedCondition)
    local isTrue = false
    local success, result = pcall(evaluateCondition, evalExpr)
    if success then
        isTrue = result
    end

    -- Return colored text based on evaluation
    if isTrue then
        return "|cff00FF00" .. displayText .. "|r"
    else
        return "|cff666666" .. displayText .. "|r"
    end
end

local function getConditionGroupType(condition)
    if condition:match("Sequence") then
        return "Sequence"
    elseif condition:match("Distance") or condition:match("Range") then
        return "Distance"
    elseif condition:match("NumberTargets") or condition:match("Targets") then
        return "Targets"
    elseif condition:match("CurrentTime") or condition:match("RemainingTime") or condition:match("Time") then
        return "Time"
    elseif condition:match("IsExecutePhase") or condition:match("Execute") then
        return "Execute"
    elseif condition:match("Buff") or condition:match("Debuff") or condition:match("IsActive") or condition:match("Aura") then
        return "Buffs/Auras"
    elseif condition:match("Dot") or condition:match("DoT") then
        return "DoTs"
    elseif condition:match("Power") or condition:match("Rage") or condition:match("Energy") or condition:match("Mana") or condition:match("Resource") then
        return "Resources"
    elseif condition:match("Cast") or condition:match("Casting") then
        return "Cast"
    else
        return "Other"
    end
end

-- ~~~~~~~~~~ UI & OPTIONS ~~~~~~~~~~

function APLMonitor:CreateFrame(parentFrame, numConditions, rotationConfig)
    if self.frame then
        self.frame:Show()
        return
    end

    local frame = CreateFrame("Frame", "NAGMonitorFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate")
    self.frame = frame
    frame.isDebugFrame = false     -- Mark as old-style frame

    -- Restore saved position or use default, with bounds checking
    local pos = self.db.global.monitorFramePosition
    local screenWidth = GetScreenWidth()
    local screenHeight = GetScreenHeight()

    -- Calculate default size and clamp to screen bounds
    -- Use a reasonable default height instead of calculating from maxConditions
    local defaultWidth = screenWidth * 0.75
    local defaultHeight = 400  -- Reasonable default height
    local frameWidth = min(defaultWidth, screenWidth)
    local frameHeight = min(defaultHeight, screenHeight - 50)  -- Leave some margin from screen edges

    frame:SetSize(frameWidth, frameHeight)

    -- Clamp position to ensure frame is visible
    local clampedX = pos.x
    local clampedY = pos.y
    if pos.point == "TOPLEFT" or pos.point == "LEFT" or pos.point == "BOTTOMLEFT" then
        clampedX = max(0, min(clampedX, screenWidth - 200))  -- Keep at least 200px visible
    elseif pos.point == "TOPRIGHT" or pos.point == "RIGHT" or pos.point == "BOTTOMRIGHT" then
        clampedX = min(0, max(clampedX, -(screenWidth - 200)))
    end
    if pos.point == "TOPLEFT" or pos.point == "TOP" or pos.point == "TOPRIGHT" then
        clampedY = min(0, max(clampedY, -(screenHeight - 100)))  -- Keep at least 100px visible
    elseif pos.point == "BOTTOMLEFT" or pos.point == "BOTTOM" or pos.point == "BOTTOMRIGHT" then
        clampedY = max(0, min(clampedY, screenHeight - 100))
    end

    frame:SetPoint(pos.point, UIParent, pos.point, clampedX, clampedY)

    -- Make frame movable
    frame:SetMovable(true)

    -- Add title bar
    local titleBar = CreateFrame("Frame", nil, frame, BackdropTemplateMixin and "BackdropTemplate")
    titleBar:SetHeight(20)
    titleBar:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 20)
    titleBar:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 20)

    local backdrop = {
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = false,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    }

    if titleBar.SetBackdrop then
        titleBar:SetBackdrop(backdrop)
        titleBar:SetBackdropColor(0, 0, 0, 0.8)
    end

    -- Add title text
    local title = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("LEFT", titleBar, "LEFT", 8, 0)
    title:SetText("NAG APL Monitor")

    -- Add close button
    local closeButton = CreateFrame("Button", nil, titleBar, "UIPanelCloseButton")
    closeButton:SetPoint("RIGHT", titleBar, "RIGHT", 2, 0)
    closeButton:SetScript("OnClick", function()
        self:Disable()
    end)

    -- Setup title bar drag functionality
    titleBar:EnableMouse(true)
    titleBar:RegisterForDrag("LeftButton")
    titleBar:SetScript("OnDragStart", function()
        frame:StartMoving()
    end)
    titleBar:SetScript("OnDragStop", function()
        frame:StopMovingOrSizing()
        -- Save position with bounds checking
        local point, _, _, x, y = frame:GetPoint()
        local screenWidth = GetScreenWidth()
        local screenHeight = GetScreenHeight()

        -- Clamp position to ensure frame stays on screen
        local clampedX = x
        local clampedY = y
        if point == "TOPLEFT" or point == "LEFT" or point == "BOTTOMLEFT" then
            clampedX = max(0, min(clampedX, screenWidth - 200))
        elseif point == "TOPRIGHT" or point == "RIGHT" or point == "BOTTOMRIGHT" then
            clampedX = min(0, max(clampedX, -(screenWidth - 200)))
        end
        if point == "TOPLEFT" or point == "TOP" or point == "TOPRIGHT" then
            clampedY = min(0, max(clampedY, -(screenHeight - 100)))
        elseif point == "BOTTOMLEFT" or point == "BOTTOM" or point == "BOTTOMRIGHT" then
            clampedY = max(0, min(clampedY, screenHeight - 100))
        end

        -- Update frame position if clamped
        if clampedX ~= x or clampedY ~= y then
            frame:ClearAllPoints()
            frame:SetPoint(point, UIParent, point, clampedX, clampedY)
        end

        self.db.global.monitorFramePosition = { point = point, x = clampedX, y = clampedY }
    end)

    -- Add resize handle
    local resizeButton = CreateFrame("Button", nil, frame)
    resizeButton:SetSize(16, 16)
    resizeButton:SetPoint("BOTTOMRIGHT")
    resizeButton:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
    resizeButton:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
    resizeButton:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")

    -- Apply backdrop to main frame
    if frame.SetBackdrop then
        frame:SetBackdrop(backdrop)
        frame:SetBackdropColor(0, 0, 0, 0.7)
    end

    -- Create scrolling content frame
    local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -8)
    scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -28, 8)

    local contentFrame = CreateFrame("Frame")
    scrollFrame:SetScrollChild(contentFrame)
    -- Content frame needs to be tall enough to hold all conditions for scrolling to work
    -- Calculate height based on font size and number of conditions
    local fontSize = self.db.global.appearance.fontSize
    local lineHeight = fontSize + 4  -- Add 4 pixels padding between lines
    local contentHeight = min(numConditions * lineHeight + 10, GetScreenHeight() * 0.8)
    contentFrame:SetSize(scrollFrame:GetWidth(), contentHeight)

    -- Simple resize functionality
    resizeButton:SetScript("OnMouseDown", function(_, button)
        if button == "LeftButton" then
            local startX, startY = GetCursorPosition()
            local startWidth = frame:GetWidth()
            local startHeight = frame:GetHeight()
            local scale = frame:GetEffectiveScale()
            local resizeAccum = 0

            resizeButton:SetScript("OnUpdate", function(_, elapsed)
                resizeAccum = resizeAccum + (elapsed or 0)
                if resizeAccum < 0.033 then
                    return
                end
                resizeAccum = 0
                local x, y = GetCursorPosition()
                local deltaX = (x - startX) / scale
                local deltaY = (y - startY) / scale

                local screenWidth = GetScreenWidth()
                local screenHeight = GetScreenHeight()

                -- Clamp size to screen bounds
                local newWidth = max(200, min(startWidth + deltaX, screenWidth))
                local newHeight = max(100, min(startHeight - deltaY, screenHeight))

                frame:SetSize(newWidth, newHeight)
                if contentFrame then
                    -- Update content frame width to match new frame width, keep height for scrolling
                    local fontSize = self.db.global.appearance.fontSize
                    local lineHeight = fontSize + 4
                    local contentHeight = min(numConditions * lineHeight + 10, GetScreenHeight() * 0.8)
                    local contentWidth = newWidth - 36
                    contentFrame:SetSize(contentWidth, contentHeight)
                    -- Update container sizes too
                    if frame.simpleContainer then
                        frame.simpleContainer:SetSize(contentWidth, contentHeight)
                    end
                    if frame.groupedContainer then
                        frame.groupedContainer:SetSize(contentWidth, contentHeight)
                    end
                    -- Update font string widths to match new container width
                    if frame.simpleConditions then
                        for _, fontString in ipairs(frame.simpleConditions) do
                            if fontString then
                                fontString:SetWidth(contentWidth - 4)
                            end
                        end
                    end
                    if frame.groupedConditions then
                        for _, fontString in ipairs(frame.groupedConditions) do
                            if fontString then
                                fontString:SetWidth(contentWidth - 4)
                            end
                        end
                    end
                end
            end)
        end
    end)

    resizeButton:SetScript("OnMouseUp", function()
        resizeButton:SetScript("OnUpdate", nil)
    end)

    -- Store references
    frame.scrollFrame = scrollFrame
    frame.contentFrame = contentFrame

    -- Initialize filters
    frame.filters = {
        Sequence = true,
        Other = true,
        Distance = true,
        Targets = true,
        Time = true,
        Execute = true,
        ["Buffs/Auras"] = true,
        DoTs = true,
        Resources = true,
        Cast = true
    }

    -- Create containers for views
    local simpleContainer = CreateFrame("Frame", nil, contentFrame)
    simpleContainer:SetSize(contentFrame:GetWidth(), contentHeight)
    simpleContainer:SetPoint("TOPLEFT")

    local groupedContainer = CreateFrame("Frame", nil, contentFrame)
    groupedContainer:SetSize(contentFrame:GetWidth(), contentHeight)
    groupedContainer:SetPoint("TOPLEFT")

    frame.simpleContainer = simpleContainer
    frame.groupedContainer = groupedContainer

    -- Create condition arrays
    frame.simpleConditions = {}
    frame.groupedConditions = {}

    -- Calculate line height based on font size (add some padding)
    local fontSize = self.db.global.appearance.fontSize
    local lineHeight = fontSize + 4  -- Add 4 pixels padding between lines

    -- Create conditions for simple view
    for i = 1, numConditions do
        local fontString = simpleContainer:CreateFontString(nil, 'OVERLAY', "GameFontNormal")
        local fontPath = LSM:Fetch("font", self.db.global.appearance.font) or LSM:GetDefault("font") or
            "Fonts\\FRIZQT__.TTF"
        local fontOutline = self.db.global.appearance.fontOutline

        local success = fontString:SetFont(fontPath, fontSize, fontOutline)

        if not success then
            self:Error("APLMonitor: Failed to set font for simple condition")
        end
        -- Position with proper line spacing and set width to prevent wrapping
        fontString:SetPoint("TOPLEFT", simpleContainer, "TOPLEFT", 2, -(i - 1) * lineHeight)
        fontString:SetJustifyH("LEFT")
        fontString:SetWidth(simpleContainer:GetWidth() - 4)  -- Set width
        fontString:SetWordWrap(false)  -- Disable word wrapping
        fontString:SetNonSpaceWrap(false)  -- Disable non-space wrapping
        fontString:EnableMouse(true)
        frame.simpleConditions[i] = fontString
    end

    -- Create conditions for grouped view
    for i = 1, numConditions do
        local fontString = groupedContainer:CreateFontString(nil, 'OVERLAY', "GameFontNormal")
        local fontPath = LSM:Fetch("font", self.db.global.appearance.font) or LSM:GetDefault("font") or
            "Fonts\\FRIZQT__.TTF"
        local fontOutline = self.db.global.appearance.fontOutline

        local success = fontString:SetFont(fontPath, fontSize, fontOutline)

        if not success then
            self:Error("APLMonitor: Failed to set font for grouped condition")
        end
        -- Position with proper line spacing and set width to prevent wrapping
        fontString:SetPoint("TOPLEFT", groupedContainer, "TOPLEFT", 2, -(i - 1) * lineHeight)
        fontString:SetJustifyH("LEFT")
        fontString:SetWidth(groupedContainer:GetWidth() - 4)  -- Set width
        fontString:SetWordWrap(false)  -- Disable word wrapping
        fontString:SetNonSpaceWrap(false)  -- Disable non-space wrapping
        fontString:EnableMouse(true)
        frame.groupedConditions[i] = fontString
    end

    -- Set initial visibility
    simpleContainer:SetShown(self.debugDisplayMode == DisplayMode.SIMPLE)
    groupedContainer:SetShown(self.debugDisplayMode == DisplayMode.GROUPED)

    -- Add display mode toggle
    local displayModeToggle = CreateFrame("Button", nil, titleBar, "UIPanelButtonTemplate")
    displayModeToggle:SetSize(100, 18)
    displayModeToggle:SetPoint("LEFT", title, "RIGHT", 20, 0)
    displayModeToggle:SetText(self.debugDisplayMode == DisplayMode.SIMPLE and "Show Grouped" or "Show Simple")
    displayModeToggle:SetScript("OnClick", function(button)
        self.debugDisplayMode = self.debugDisplayMode == DisplayMode.SIMPLE and DisplayMode.GROUPED or DisplayMode
            .SIMPLE
        button:SetText(self.debugDisplayMode == DisplayMode.SIMPLE and "Show Grouped" or "Show Simple")
        simpleContainer:SetShown(self.debugDisplayMode == DisplayMode.SIMPLE)
        groupedContainer:SetShown(self.debugDisplayMode == DisplayMode.GROUPED)
        self:Update()
    end)

    frame:Show()
    self:Update()
end

function APLMonitor:Update()
    if not self.frame or not self.frame:IsShown() then return end

    -- Ensure we have AST data before updating (lazy parsing)
    self:EnsureASTData()

    if not self.state.rotationString then
        self:Debug("No rotation string in state")
        return
    end

    -- Check if we're using the new debug frame system
    if self.db.global.useDebugFrame then
        -- For new debug frame, live refresh is handled by DebugFrameUtil; no polling here
        return
    end

    -- For old frame system, update the views
    if self.debugDisplayMode == DisplayMode.SIMPLE then
        self:UpdateSimpleView(self.state.rotationString)
    else
        self:UpdateGroupedView(self.state.rotationString)
    end
end

function APLMonitor:UpdateSimpleView(conditions)
    if not self.frame.simpleConditions then
        self:Debug("No simple conditions container found")
        return
    end

    -- Clear existing conditions
    for i = 1, #self.frame.simpleConditions do
        if self.frame.simpleConditions[i] then
            self.frame.simpleConditions[i]:SetText("")
        end
    end

    local firstTrueFound = false
    local currentIndex = 1

    local clauses = splitTopLevelOrClauses(conditions)
    for _, cleanedCondition in ipairs(clauses) do
        local groupType = getConditionGroupType(cleanedCondition)

        if self.frame.filters[groupType] then
            if self.frame.simpleConditions[currentIndex] then
                local isActive = false
                if not firstTrueFound and evaluateCondition(cleanedCondition) then
                    firstTrueFound = true
                    isActive = true
                    if self.debug then self:Debug("Found first active condition: %s", cleanedCondition) end
                end

                -- Evaluate and highlight the condition
                local displayText
                if isActive then
                    displayText = cleanedCondition .. " |cff00ff00<<<==== ACTIVE|r"
                else
                    -- Strip the trailing action (e.g., "and NAG:Cast(...)") before splitting sub-conditions
                    -- Actions are: Cast, StrictSequence, CancelBladestorm, CastAllStatBuffCooldowns, AutocastOtherCooldowns
                    local conditionOnly = cleanedCondition
                    local i = #conditionOnly
                    local paren = 0
                    while i > 0 do
                        local ch = conditionOnly:sub(i, i)
                        if ch == ')' then
                            paren = paren + 1
                        elseif ch == '(' then
                            paren = paren - 1
                        end
                        -- look for " and NAG:" followed by action keywords at top level (this is the action separator)
                        if paren == 0 then
                            local seg = conditionOnly:sub(1, i)
                            -- Match action calls specifically - check for known action function patterns
                            local actionPatterns = {
                                "%s+and%s+NAG:Cast%(",
                                "%s+and%s+NAG:StrictSequence%(",
                                "%s+and%s+NAG:CancelBladestorm%(",
                                "%s+and%s+NAG:CastAllStatBuffCooldowns%(",
                                "%s+and%s+NAG:AutocastOtherCooldowns%(",
                            }
                            local foundAction = false
                            for _, pattern in ipairs(actionPatterns) do
                                local j = seg:find(pattern)
                                if j then
                                    conditionOnly = conditionOnly:sub(1, j - 1):match("^%s*(.-)%s*$")
                                    foundAction = true
                                    break
                                end
                            end
                            if foundAction then
                                break  -- Exit the while loop
                            end
                        end
                        i = i - 1
                    end
                    
                    local subConditions = splitSubConditions(conditionOnly)
                    local conditionTexts = {}
                    for _, subCondition in ipairs(subConditions) do
                        tinsert(conditionTexts, highlightCondition(subCondition))
                    end
                    displayText = "    " .. table.concat(conditionTexts, " ")
                end

                self.frame.simpleConditions[currentIndex]:SetText(displayText)
                currentIndex = currentIndex + 1
            end
        end
    end
end

function APLMonitor:UpdateGroupedView(conditions)
    if not self.frame.groupedConditions then
        self:Debug("No grouped conditions container found")
        return
    end

    -- Clear existing conditions
    for i = 1, #self.frame.groupedConditions do
        if self.frame.groupedConditions[i] then
            self.frame.groupedConditions[i]:SetText("")
        end
    end

    -- Parse and organize conditions by group
    local groupedConditions = {}
    local firstTrueFound = false

    local clauses = splitTopLevelOrClauses(conditions)
    for _, cleanedCondition in ipairs(clauses) do
        local groupType = getConditionGroupType(cleanedCondition)

        if self.frame.filters[groupType] then
            groupedConditions[groupType] = groupedConditions[groupType] or {}
            local active = not firstTrueFound and evaluateCondition(cleanedCondition)
            tinsert(groupedConditions[groupType], {
                condition = cleanedCondition,
                isActive = active
            })

            if active then
                firstTrueFound = true
                if self.debug then self:Debug("Found first active condition in group %s: %s", groupType, cleanedCondition) end
            end
        end
    end

    -- Display conditions by group
    local currentIndex = 1
    local groupOrder = {
        "Sequence", "Other", "Distance", "Targets", "Time",
        "Execute", "Buffs/Auras", "DoTs", "Resources", "Cast"
    }

    for _, groupType in ipairs(groupOrder) do
        local groupConditions = groupedConditions[groupType]
        if groupConditions and #groupConditions > 0 then
            -- Add group header
            if self.frame.groupedConditions[currentIndex] then
                local headerText = "|cffFFD700=== " .. groupType .. " Conditions ===|r"
                self.frame.groupedConditions[currentIndex]:SetText(headerText)
                currentIndex = currentIndex + 1
            end

            -- Display conditions in this group
            for _, conditionData in ipairs(groupConditions) do
                if self.frame.groupedConditions[currentIndex] then
                    local displayText
                    if conditionData.isActive then
                        displayText = "    " .. conditionData.condition .. " |cff00ff00<<<==== ACTIVE|r"
                    else
                        local subConditions = splitSubConditions(conditionData.condition)
                        local conditionTexts = {}
                        for _, subCondition in ipairs(subConditions) do
                            tinsert(conditionTexts, highlightCondition(subCondition))
                        end
                        displayText = "    " .. table.concat(conditionTexts, " ")
                    end

                    self.frame.groupedConditions[currentIndex]:SetText(displayText)
                    currentIndex = currentIndex + 1
                end
            end

            -- Add spacing after group
            if self.frame.groupedConditions[currentIndex] then
                self.frame.groupedConditions[currentIndex]:SetText("")
                currentIndex = currentIndex + 1
            end
        end
    end
end

-- ~~~~~~~~~~ OPTIONS UI ~~~~~~~~~~

--- Gets the options table for APL Monitor settings
--- @return table The options table for AceConfig
function APLMonitor:GetOptions()
    -- Ace3-compliant group table for options UI
    local args = {}

    -- Enable toggle - always visible since module is no longer hidden behind devmode
    args.enabled = {
        type = "toggle",
        name = "Enable APL Monitor",
        desc = "Enable or disable the APL Monitor display",
        order = 0,
        get = function() return self:GetSetting("global", "enabled") end,
        set = function(_, value)
            self:SetSetting("global", "enabled", value)
            if value then
                -- Re-run ModuleEnable to start the monitor
                if not self:IsEnabled() then
                    self:Enable()
                else
                    -- Already enabled, just check if we should show frame
                    self:ModuleEnable()
                end
            else
                -- Hide frame but keep module enabled (for event handling)
                self:HideFrame()
            end
        end
    }

    -- Other options (flat into args)
    args.showMonitor = {
        type = "execute",
        name = function(info) return L[info[#info]] or info[#info] end,
        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
        order = 1,
        func = function() self:ToggleFrame() end,
    }

    args.useDebugFrame = {
        type = "toggle",
        name = "Use New Debug Frame",
        desc = "Toggle between the new DebugFrame system and the old CreateFrame system for compatibility testing",
        order = 2,
        get = function() return self:GetSetting("global", "useDebugFrame") end,
        set = function(_, value)
            self:SetSetting("global", "useDebugFrame", value)
            if self.frame then
                self:HideFrame()
                self:CleanupFrame()
            end
            self:Info("Switched to " .. (value and "new DebugFrame" or "old CreateFrame") .. " system")
        end
    }

    args.displayMode = {
        type = "select",
        name = function(info) return L[info[#info]] or info[#info] end,
        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
        order = 3,
        values = {
            [DisplayMode.SIMPLE] = L["simple"],
            [DisplayMode.GROUPED] = L["grouped"]
        },
        get = function() return self.db.global.displayMode end,
        set = function(_, value)
            self.db.global.displayMode = value
            self.debugDisplayMode = value
            if self.frame then
                self:Update()
            end
        end
    }

    args.updateInterval = {
        type = "range",
        name = function(info) return L[info[#info]] or info[#info] end,
        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
        order = 4,
        min = 0.1,
        max = 1.0,
        step = 0.1,
        get = function() return self.db.global.updateInterval end,
        set = function(_, value)
            self.db.global.updateInterval = value
            if self.debugTimer then
                self:CancelTimer(self.debugTimer)
                self.debugTimer = self:ScheduleRepeatingTimer("Update", value)
            end
        end
    }

    args.resetFrame = {
        type = "execute",
        name = "Reset Frame Position/Size",
        desc = "Reset the APL Monitor frame position and size to defaults",
        order = 5,
        func = function()
            self:ResetFrame()
        end
    }

    args.filters = {
        type = "group",
        name = function(info) return L[info[#info]] or info[#info] end,
        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
        order = 6,
        inline = true,
        args = {
            sequence = {
                type = "toggle",
                name = L["sequence"],
                order = 1,
                get = function() return self.db.global.filters.Sequence end,
                set = function(_, value)
                    self.db.global.filters.Sequence = value
                    if self.frame then
                        self:Update()
                    end
                end
            }
        }
    }

    args.appearance = {
        type = "group",
        name = function(info) return L[info[#info]] or info[#info] end,
        desc = function(info) return L[info[#info] .. "Desc"] or "" end,
        order = 7,
        inline = true,
        args = {
            fontSize = {
                type = "range",
                name = function(info) return L[info[#info]] or info[#info] end,
                desc = function(info) return L[info[#info] .. "Desc"] or "" end,
                order = 1,
                min = 8,
                max = 20,
                step = 1,
                get = function() return self.db.global.appearance.fontSize end,
                set = function(_, value)
                    self.db.global.appearance.fontSize = value
                    if self.frame then
                        self:UpdateAppearance()
                    end
                end
            }
        }
    }

    return {
        type = "group",
        name = "APL Monitor",
        order = 4,
        args = args
    }
end

--- Updates the appearance of the monitor frame based on current settings
function APLMonitor:UpdateAppearance()
    if not self.frame then return end

    local appearance = self.db.global.appearance
    local fontName = appearance.font or "Friz Quadrata TT"
    local size = appearance.fontSize or 12
    local outline = appearance.fontOutline or "OUTLINE"

    -- Get the actual font path from LSM
    local fontPath = LSM:Fetch("font", fontName) or LSM:GetDefault("font") or "Fonts\\FRIZQT__.TTF"

    -- Calculate new line height based on font size
    local lineHeight = size + 4

    -- Update simple view fonts and reposition
    for i, fontString in ipairs(self.frame.simpleConditions) do
        if fontString then
            fontString:SetFont(fontPath, size, outline)
            -- Reposition with new line height
            fontString:ClearAllPoints()
            fontString:SetPoint("TOPLEFT", self.frame.simpleContainer, "TOPLEFT", 2, -(i - 1) * lineHeight)
            -- Ensure wrapping is disabled
            fontString:SetWordWrap(false)
            fontString:SetNonSpaceWrap(false)
        end
    end

    -- Update grouped view fonts and reposition
    for i, fontString in ipairs(self.frame.groupedConditions) do
        if fontString then
            fontString:SetFont(fontPath, size, outline)
            -- Reposition with new line height
            fontString:ClearAllPoints()
            fontString:SetPoint("TOPLEFT", self.frame.groupedContainer, "TOPLEFT", 2, -(i - 1) * lineHeight)
            -- Ensure wrapping is disabled
            fontString:SetWordWrap(false)
            fontString:SetNonSpaceWrap(false)
        end
    end

    -- Update content frame height if needed
    if self.frame.contentFrame then
        local numConditions = self.db.global.maxConditions
        local contentHeight = min(numConditions * lineHeight + 10, GetScreenHeight() * 0.8)
        self.frame.contentFrame:SetHeight(contentHeight)
        if self.frame.simpleContainer then
            self.frame.simpleContainer:SetHeight(contentHeight)
        end
        if self.frame.groupedContainer then
            self.frame.groupedContainer:SetHeight(contentHeight)
        end
    end

    -- Update frame dimensions if needed
    if appearance.frameWidth and appearance.frameHeight then
        self.frame:SetSize(appearance.frameWidth, appearance.frameHeight)
    end

    -- Update position if specified
    if appearance.position then
        self.frame:ClearAllPoints()
        self.frame:SetPoint(appearance.position.point, UIParent, appearance.position.point,
            appearance.position.x, appearance.position.y)
    end
end

--- ShowHelp: Shows help information for the APL Monitor interface
function APLMonitor:ShowHelp()
    self:Print("=== NAG APL Monitor Help ===")
    self:Print("Commands:")
    self:Print("  /aplmonitor or /aplmon - Toggle the APL Monitor interface")
    self:Print("  /aplmonitorhelp - Show this help")
    self:Print("")
    self:Print("How to use:")
    self:Print("  1. Type /aplmonitor to enable the APL Monitor")
    self:Print("  2. The monitor will show automatically when enabled")
    self:Print("  3. The monitor shows APL conditions in real-time")
    self:Print("  4. Active conditions are highlighted in green")
    self:Print("  5. Use the toggle button to switch between Simple and Grouped views")
    self:Print("  6. Click X to disable the monitor completely")
    self:Print("  7. Adjust update interval in options for performance")
    self:Print("")
    self:Print("Features:")
    self:Print("  - Real-time APL condition monitoring")
    self:Print("  - Simple and grouped view modes")
    self:Print("  - Condition highlighting and evaluation")
    self:Print("  - Filterable condition types")
    self:Print("  - Movable and resizable interface")
    self:Print("  - Debug frame system integration")
    self:Print("")
    self:Print("The APL Monitor is a development tool for debugging rotations.")
    self:Print("It shows which conditions are active and helps optimize APL logic.")
    self:Print("")
    self:Print("  /aplmonitorreset or /aplmonreset - Reset frame position and size to defaults")
end

--- ResetFrame: Resets the APL Monitor frame position and size to defaults
function APLMonitor:ResetFrame()
    -- Reset to default position and size
    local defaultPos = { point = "TOPLEFT", x = 0, y = -125 }
    self.db.global.monitorFramePosition = defaultPos

    if self.frame then
        if self.frame.isDebugFrame then
            -- Handle debug frame system
            if ns.DebugFrameUtil and ns.DebugFrameUtil.activeFrames then
                local debugFrame = ns.DebugFrameUtil.activeFrames[tostring(self)]
                if debugFrame and debugFrame.frame then
                    debugFrame.frame:ClearAllPoints()
                    debugFrame.frame:SetPoint(defaultPos.point, UIParent, defaultPos.point, defaultPos.x, defaultPos.y)
                    -- DebugFrameUtil handles its own size constraints
                    self:Print("APL Monitor debug frame position reset to defaults.")
                end
            end
        else
            -- Handle old-style frame
            -- Reset frame position
            self.frame:ClearAllPoints()
            self.frame:SetPoint(defaultPos.point, UIParent, defaultPos.point, defaultPos.x, defaultPos.y)

            -- Reset frame size to default
            local screenHeight = GetScreenHeight()
            local defaultWidth = GetScreenWidth() * 0.75
            local defaultHeight = min(400, screenHeight - 50)  -- Reasonable default height with margin
            self.frame:SetSize(defaultWidth, defaultHeight)

            -- Update content frame size (needs to be tall enough for all conditions)
            if self.frame.contentFrame then
                local numConditions = self.db.global.maxConditions
                local fontSize = self.db.global.appearance.fontSize
                local lineHeight = fontSize + 4
                local contentWidth = defaultWidth - 36
                local contentHeight = min(numConditions * lineHeight + 10, screenHeight * 0.8)
                self.frame.contentFrame:SetSize(contentWidth, contentHeight)
                -- Update container sizes too
                if self.frame.simpleContainer then
                    self.frame.simpleContainer:SetSize(contentWidth, contentHeight)
                end
                if self.frame.groupedContainer then
                    self.frame.groupedContainer:SetSize(contentWidth, contentHeight)
                end
                -- Update font string widths and reposition
                if self.frame.simpleConditions then
                    for i, fontString in ipairs(self.frame.simpleConditions) do
                        if fontString then
                            fontString:SetWidth(contentWidth - 4)
                            fontString:ClearAllPoints()
                            fontString:SetPoint("TOPLEFT", self.frame.simpleContainer, "TOPLEFT", 2, -(i - 1) * lineHeight)
                            fontString:SetWordWrap(false)
                            fontString:SetNonSpaceWrap(false)
                        end
                    end
                end
                if self.frame.groupedConditions then
                    for i, fontString in ipairs(self.frame.groupedConditions) do
                        if fontString then
                            fontString:SetWidth(contentWidth - 4)
                            fontString:ClearAllPoints()
                            fontString:SetPoint("TOPLEFT", self.frame.groupedContainer, "TOPLEFT", 2, -(i - 1) * lineHeight)
                            fontString:SetWordWrap(false)
                            fontString:SetNonSpaceWrap(false)
                        end
                    end
                end
            end

            self:Print("APL Monitor frame position and size reset to defaults.")
        end
    else
        self:Print("APL Monitor frame not found. Position will be reset when frame is created.")
    end
end

-- ~~~~~~~~~~ PUBLIC API ~~~~~~~~~~

--- Shows the APL Monitor frame
function APLMonitor:ShowFrame()
    local useDebugFrame = self.db.global.useDebugFrame

    -- Check if we need to recreate the frame due to system change
    if self.frame then
        local currentIsDebugFrame = self.frame.isDebugFrame -- Check if current frame is debug frame
        if useDebugFrame ~= currentIsDebugFrame then
            -- System changed, clean up old frame
            self:CleanupFrame()
        end
    end

    -- Create frame if it doesn't exist
    if not self.frame then
        if useDebugFrame then
            self:ShowDebugFrame()
            -- ShowDebugFrame handles showing the frame, so we're done
            return
        else
            -- Create the old-style frame
            local numConditions = self.db.global.maxConditions
            local classModule = NAG:GetClassModule()
            local currentRotation = {}
            if classModule then
                currentRotation = select(1, classModule:GetCurrentRotation()) or {}
            end
            self:CreateFrame(UIParent, numConditions, currentRotation)
        end
    end

    -- Handle showing the frame based on type
    if self.frame then
        if useDebugFrame then
            -- For debug frames, ensure it's visible
            if ns.DebugFrameUtil and ns.DebugFrameUtil.activeFrames then
                local debugFrame = ns.DebugFrameUtil.activeFrames[tostring(self)]
                if debugFrame and debugFrame.frame then
                    debugFrame.frame:Show()
                    self:Debug("Debug frame shown via DebugFrameUtil")
                else
                    self:Debug("Debug frame not found in activeFrames, recreating...")
                    -- Frame might have been lost, recreate it
                    self:ShowDebugFrame()
                    return
                end
            else
                self:Debug("DebugFrameUtil not available, recreating debug frame...")
                self:ShowDebugFrame()
                return
            end
        else
            -- For old-style frames, call Show()
            if self.frame.Show then
                self.frame:Show()
            end
        end
    end
    self:Info("APL Monitor frame shown")
end

--- Hides the APL Monitor frame
function APLMonitor:HideFrame()
    if self.frame then
        if self.frame.isDebugFrame then
            -- Hide debug frame
            if ns.DebugFrameUtil and ns.DebugFrameUtil.activeFrames then
                local debugFrame = ns.DebugFrameUtil.activeFrames[tostring(self)]
                if debugFrame and debugFrame.frame then
                    debugFrame.frame:Hide()
                end
            end
        else
            -- Hide old-style frame
            if self.frame.Hide then
                self.frame:Hide()
            end
        end
        self:Info("APL Monitor frame hidden")
    end
end

--- Toggles the APL Monitor module (enable/disable)
function APLMonitor:ToggleFrame()
    -- Check if module is currently enabled
    if self:IsEnabled() then
        -- Module is enabled, so disable it
        self:Disable()
        self:Info("APL Monitor disabled via toggle")
    else
        -- Module is disabled, so enable it
        self:Enable()
        self:Info("APL Monitor enabled via toggle")
    end
end

-- ~~~~~~~~~~ DEBUG FRAME UTIL INTEGRATION ~~~~~~~~~~
do
    function APLMonitor:GetDebugSections()
        -- Initialize view state if not set
        if not self.state.currentView then
            self.state.currentView = "text"
            self:Debug("APLMonitor: Initialized currentView to 'text'")
        end

        self:Debug("APLMonitor: Returning " ..
            (self.state.currentView == "tree" and "TREE" or "TEXT") .. " view sections")

        if self.state.currentView == "tree" then
            -- Tree view
            return {
                {
                    header = "APL Tree View",
                    type = "custom",
                    customFn = function(scroll)
                        -- Create tree view using AceGUI - use TreeGroup directly like RotationEditor does
                        local container = AceGUI:Create("SimpleGroup")
                        container:SetLayout("Flow")   -- Use Flow layout for multiple children
                        container:SetFullWidth(true)
                        container:SetFullHeight(true) -- Let container expand to fill available space

                        if not self.state.treeStructure then
                            local noDataLabel = AceGUI:Create("Label")
                            noDataLabel:SetText("No parsed AST data available")
                            noDataLabel:SetFullWidth(true)
                            container:AddChild(noDataLabel)
                            return container
                        end

                        -- Create tree widget with error handling
                        self:Debug("APLMonitor: Attempting to create TreeGroup widget...")
                        self:Debug("APLMonitor: AceGUI available: " .. tostring(AceGUI))
                        self:Debug("APLMonitor: Called from: " .. debugstack(2, 3, 2))

                        -- Check if TreeGroup widget type is registered
                        local widgetVersion = AceGUI:GetWidgetVersion("TreeGroup")
                        self:Debug("APLMonitor: TreeGroup widget version: " .. tostring(widgetVersion))

                        if not widgetVersion then
                            self:Error("APLMonitor: TreeGroup widget type not registered in AceGUI")
                            local errorLabel = AceGUI:Create("Label")
                            errorLabel:SetText("|cffFF0000Error: TreeGroup widget type not registered|r")
                            errorLabel:SetFullWidth(true)
                            container:AddChild(errorLabel)

                            -- Show available widget types for debugging
                            local availableLabel = AceGUI:Create("Label")
                            availableLabel:SetText("|cffFFD700Available widget types:|r")
                            availableLabel:SetFullWidth(true)
                            container:AddChild(availableLabel)

                            -- List some common widget types
                            local commonWidgets = { "Button", "Label", "EditBox", "CheckBox", "Dropdown", "SimpleGroup",
                                "Frame" }
                            for _, widgetType in ipairs(commonWidgets) do
                                local version = AceGUI:GetWidgetVersion(widgetType)
                                if version then
                                    local widgetLabel = AceGUI:Create("Label")
                                    widgetLabel:SetText("  " .. widgetType .. " (v" .. version .. ")")
                                    widgetLabel:SetFullWidth(true)
                                    container:AddChild(widgetLabel)
                                end
                            end

                            return container
                        end

                        -- Try to create TreeGroup widget with error handling
                        local success, tree = pcall(AceGUI.Create, AceGUI, "TreeGroup")
                        if not success then
                            self:Error("APLMonitor: Failed to create TreeGroup widget: " .. tostring(tree))
                            local errorLabel = AceGUI:Create("Label")
                            errorLabel:SetText("|cffFF0000Error: Failed to create TreeGroup widget - " ..
                                tostring(tree) .. "|r")
                            errorLabel:SetFullWidth(true)
                            container:AddChild(errorLabel)
                            return container
                        end

                        self:Debug("APLMonitor: TreeGroup widget creation result: " .. tostring(tree))

                        if not tree then
                            self:Error("APLMonitor: TreeGroup widget creation returned nil")
                            local errorLabel = AceGUI:Create("Label")
                            errorLabel:SetText("|cffFF0000Error: TreeGroup widget creation returned nil|r")
                            errorLabel:SetFullWidth(true)
                            container:AddChild(errorLabel)
                            return container
                        end

                        -- Validate tree structure before setting
                        self:Debug("APLMonitor: Tree structure validation - type: " ..
                            type(self.state.treeStructure) .. ", value: " .. tostring(self.state.treeStructure))
                        if not self.state.treeStructure or type(self.state.treeStructure) ~= "table" then
                            self:Error("APLMonitor: Invalid tree structure: " .. tostring(self.state.treeStructure))
                            local errorLabel = AceGUI:Create("Label")
                            errorLabel:SetText("|cffFF0000Error: Invalid tree structure|r")
                            errorLabel:SetFullWidth(true)
                            container:AddChild(errorLabel)
                            return container
                        end

                        self:Debug("APLMonitor: Tree structure is valid, proceeding with configuration...")

                        -- Convert our tree structure to TreeGroup format
                        local treeGroupData = {}
                        if self.state.treeStructure and self.state.treeStructure.children then
                            for i, child in ipairs(self.state.treeStructure.children) do
                                -- Create a more descriptive text for the clause
                                local clauseText = child.text or "Clause " .. i
                                if clauseText:len() > 50 then
                                    clauseText = clauseText:sub(1, 47) .. "..."
                                end

                                local node = {
                                    value = "clause_" .. i,
                                    text = clauseText,
                                    children = {}
                                }

                                -- Add sub-conditions as children
                                if child.children then
                                    for j, subChild in ipairs(child.children) do
                                        local subText = subChild.text or "Sub-condition " .. j
                                        if subText:len() > 60 then
                                            subText = subText:sub(1, 57) .. "..."
                                        end

                                        local subNode = {
                                            value = "clause_" .. i .. "_sub_" .. j,
                                            text = subText
                                        }
                                        table.insert(node.children, subNode)
                                    end
                                end

                                table.insert(treeGroupData, node)
                            end
                        end

                        self:Debug("APLMonitor: Converted tree data - " .. #treeGroupData .. " root nodes")
                        for i, node in ipairs(treeGroupData) do
                            self:Debug("APLMonitor: Node " ..
                                i .. ": " .. node.text .. " (" .. #node.children .. " children)")
                        end

                        -- Debug the actual tree data structure
                        self:Debug("APLMonitor: TreeGroupData type: " .. type(treeGroupData))
                        self:Debug("APLMonitor: TreeGroupData[1] type: " .. type(treeGroupData[1]))
                        if treeGroupData[1] then
                            self:Debug("APLMonitor: TreeGroupData[1] keys: " ..
                                table.concat(TableUtils.Keys(treeGroupData[1]), ", "))
                            self:Debug("APLMonitor: TreeGroupData[1].value: " .. tostring(treeGroupData[1].value))
                            self:Debug("APLMonitor: TreeGroupData[1].text: " .. tostring(treeGroupData[1].text))
                            self:Debug("APLMonitor: TreeGroupData[1].children type: " .. type(treeGroupData[1].children))
                            if treeGroupData[1].children then
                                self:Debug("APLMonitor: TreeGroupData[1].children count: " .. #treeGroupData[1].children)
                            end
                        end

                        -- Set tree properties with error handling
                        local setTreeSuccess, err = pcall(function()
                            self:Debug("APLMonitor: Setting tree data - " .. #treeGroupData .. " nodes")
                            self:Debug("APLMonitor: TreeGroup widget type: " .. tostring(tree.type))
                            self:Debug("APLMonitor: TreeGroup widget methods: SetTree=" ..
                                tostring(tree.SetTree) .. ", SetLayout=" .. tostring(tree.SetLayout))

                            tree:SetTree(treeGroupData)
                            self:Debug("APLMonitor: SetTree completed")

                            -- Debug: Check if tree data was actually set
                            if tree.GetTree then
                                local currentTree = tree:GetTree()
                                self:Debug("APLMonitor: Tree.GetTree() returned: " ..
                                    type(currentTree) .. " with " .. #(currentTree or {}) .. " nodes")
                            else
                                self:Debug("APLMonitor: Tree widget has no GetTree method")
                            end

                            tree:SetLayout("Fill") -- Use Fill layout for proper sizing
                            self:Debug("APLMonitor: SetLayout completed")

                            tree:SetFullWidth(true)
                            tree:SetFullHeight(true) -- Let tree expand to fill container
                            self:Debug("APLMonitor: SetFullWidth/Height completed")

                            tree:SetTreeWidth(400) -- Set explicit tree panel width (wider for better visibility)
                            self:Debug("APLMonitor: SetTreeWidth completed")

                            tree.height = "fill" -- Set height property to fill
                            self:Debug("APLMonitor: Set height property completed")

                            -- Set up status table for TreeGroup to track expanded/collapsed state
                            local status = {
                                groups = {},
                                scrollvalue = 0,
                                treewidth = 400, -- Match the SetTreeWidth value
                                treesizable = true,
                                height = "fill"  -- Ensure tree takes remaining height
                            }
                            tree:SetStatusTable(status)
                            self:Debug("APLMonitor: SetStatusTable completed")

                            -- Debug tree state after configuration
                            self:Debug("APLMonitor: Tree state after config - width=" ..
                                tostring(tree.width) .. ", height=" .. tostring(tree.height))
                            self:Debug("APLMonitor: Tree frame dimensions - " ..
                                tostring(tree.frame:GetWidth()) .. "x" .. tostring(tree.frame:GetHeight()))

                            -- Add OnShow callback to debug when tree is actually displayed
                            tree:SetCallback("OnShow", function(widget)
                                self:Debug("APLMonitor: TreeGroup OnShow callback fired")
                                self:Debug("APLMonitor: Tree frame visible: " .. tostring(widget.frame:IsVisible()))
                                self:Debug("APLMonitor: Tree frame dimensions on show: " ..
                                    tostring(widget.frame:GetWidth()) .. "x" .. tostring(widget.frame:GetHeight()))
                            end)
                        end)

                        if not setTreeSuccess then
                            self:Error("APLMonitor: Failed to configure TreeGroup widget: " .. tostring(err))
                            self:Debug("APLMonitor: Falling back to simple list view...")

                            -- Fallback: Create a simple list view
                            local fallbackLabel = AceGUI:Create("Label")
                            fallbackLabel:SetText("|cffFFD700Tree view failed, showing simple list:|r")
                            fallbackLabel:SetFullWidth(true)
                            container:AddChild(fallbackLabel)

                            -- Create simple list of conditions
                            local priorityList = self.state.parsedAST and self.state.parsedAST.priority_list or {}
                            for i, listItem in ipairs(priorityList) do
                                local clauseLabel = AceGUI:Create("Label")
                                local ASTSchemaEmitter = ns.ASTSchemaEmitter
                                local actionText = "No action"
                                if listItem.action and ASTSchemaEmitter then
                                    actionText = ASTSchemaEmitter.EmitActionNode(listItem.action) or "No text"
                                end
                                clauseLabel:SetText(string.format("Clause %d: %s", i, actionText))
                                clauseLabel:SetFullWidth(true)
                                container:AddChild(clauseLabel)
                            end

                            return container
                        end

                        -- Add tree to container
                        self:Debug("APLMonitor: Adding tree to container...")
                        self:Debug("APLMonitor: Container children before: " .. #container.children)
                        container:AddChild(tree)
                        self:Debug("APLMonitor: Container children after: " .. #container.children)
                        self:Debug("APLMonitor: Tree added to container successfully")

                        -- Store tree reference for cleanup
                        container.treeWidget = tree

                        -- Add expand/collapse controls
                        local buttonContainer = AceGUI:Create("SimpleGroup")
                        buttonContainer:SetLayout("Flow")
                        buttonContainer:SetFullWidth(true)
                        buttonContainer:SetAutoAdjustHeight(true) -- Only take needed height

                        local expandAllBtn = AceGUI:Create("Button")
                        expandAllBtn:SetText("Expand All")
                        expandAllBtn:SetWidth(100)
                        expandAllBtn:SetCallback("OnClick", function()
                            if tree and tree.SetStatusTable then
                                -- TreeGroup doesn't have ExpandAll, but we can set all groups to expanded
                                local status = tree.status or tree.localstatus
                                if status and status.groups then
                                    for groupName, _ in pairs(status.groups) do
                                        status.groups[groupName] = true
                                    end
                                    tree:RefreshTree()
                                end
                            else
                                self:Error("APLMonitor: TreeGroup widget not available for ExpandAll")
                            end
                        end)
                        buttonContainer:AddChild(expandAllBtn)

                        local collapseAllBtn = AceGUI:Create("Button")
                        collapseAllBtn:SetText("Collapse All")
                        collapseAllBtn:SetWidth(100)
                        collapseAllBtn:SetCallback("OnClick", function()
                            if tree and tree.SetStatusTable then
                                -- TreeGroup doesn't have CollapseAll, but we can set all groups to collapsed
                                local status = tree.status or tree.localstatus
                                if status and status.groups then
                                    for groupName, _ in pairs(status.groups) do
                                        status.groups[groupName] = false
                                    end
                                    tree:RefreshTree()
                                end
                            else
                                self:Error("APLMonitor: TreeGroup widget not available for CollapseAll")
                            end
                        end)
                        buttonContainer:AddChild(collapseAllBtn)

                        -- Add refresh button for tree view
                        local refreshTreeBtn = AceGUI:Create("Button")
                        refreshTreeBtn:SetText("Refresh Tree")
                        refreshTreeBtn:SetWidth(100)
                        refreshTreeBtn:SetCallback("OnClick", function()
                            -- Re-parse the rotation string to update tree
                            if self.state.rotationString then
                                local conversionService = NAG:GetModule("RotationConversionService")
                                local NAGStringParser = NAG:GetModule("NAGStringParser")
                                if conversionService and NAGStringParser then
                                    local ast, diagnostics = conversionService:ParseToProtoAST(self.state.rotationString, {
                                        useCache = true,
                                        validate = false,
                                    })
                                    if ast then
                                        self.state.parsedAST = ast
                                        self.state.treeStructure = NAGStringParser:GetTreeStructure(ast)
                                        -- Force refresh the frame
                                        local debugFrame = ns.DebugFrameUtil and
                                            ns.DebugFrameUtil.activeFrames[tostring(self)]
                                        if debugFrame and debugFrame.frame and debugFrame.frame.UpdateDebugFrame then
                                            debugFrame.frame:UpdateDebugFrame()
                                        end
                                    end
                                end
                            end
                        end)
                        buttonContainer:AddChild(refreshTreeBtn)

                        container:AddChild(buttonContainer)

                        -- Store tree reference for cleanup - AceGUI will handle release automatically
                        -- when the container is released, so we don't need to override Release
                        container.treeWidget = tree

                        -- Add a spacer to push the tree to use remaining height
                        local spacer = AceGUI:Create("Label")
                        spacer:SetText("")
                        spacer:SetHeight(10) -- Small gap between buttons and tree
                        spacer:SetFullWidth(true)
                        container:AddChild(spacer)

                        self:Debug("APLMonitor: Tree view container created successfully")
                        self:Debug("APLMonitor: Container type: " .. tostring(container.type))
                        self:Debug("APLMonitor: Container layout: " .. tostring(container.LayoutFunc))
                        self:Debug("APLMonitor: Container children count: " .. #container.children)

                        return container
                    end
                },
                {
                    header = "Debug Info",
                    type = "custom",
                    customFn = function(scroll)
                        local container = AceGUI:Create("SimpleGroup")
                        container:SetLayout("List")
                        container:SetFullWidth(true)
                        container:SetHeight(200) -- Limit debug info height

                        local debugLabel = AceGUI:Create("Label")
                        debugLabel:SetText("Current View: " .. (self.state.currentView or "nil"))
                        debugLabel:SetFullWidth(true)
                        container:AddChild(debugLabel)

                        local stateLabel = AceGUI:Create("Label")
                        stateLabel:SetText("Has Tree Structure: " .. (self.state.treeStructure and "Yes" or "No"))
                        stateLabel:SetFullWidth(true)
                        container:AddChild(stateLabel)

                        local rotationLabel = AceGUI:Create("Label")
                        rotationLabel:SetText("Has Rotation String: " .. (self.state.rotationString and "Yes" or "No"))
                        rotationLabel:SetFullWidth(true)
                        container:AddChild(rotationLabel)

                        -- Add tree structure details
                        if self.state.treeStructure then
                            local treeDetailsLabel = AceGUI:Create("Label")
                            treeDetailsLabel:SetText("Tree Structure Type: " .. type(self.state.treeStructure))
                            treeDetailsLabel:SetFullWidth(true)
                            container:AddChild(treeDetailsLabel)

                            local treeChildrenLabel = AceGUI:Create("Label")
                            treeChildrenLabel:SetText("Root Children Count: " ..
                                (self.state.treeStructure.children and #self.state.treeStructure.children or "No children property"))
                            treeChildrenLabel:SetFullWidth(true)
                            container:AddChild(treeChildrenLabel)

                            -- Show first few children as example
                            if self.state.treeStructure.children and #self.state.treeStructure.children > 0 then
                                local exampleLabel = AceGUI:Create("Label")
                                exampleLabel:SetText("First Child: " .. tostring(self.state.treeStructure.children[1]))
                                exampleLabel:SetFullWidth(true)
                                container:AddChild(exampleLabel)
                            end
                        end

                        -- Add parsed AST details
                        if self.state.parsedAST then
                            local astLabel = AceGUI:Create("Label")
                            astLabel:SetText("AST Clauses Count: " .. #(self.state.parsedAST.priority_list or {}))
                            astLabel:SetFullWidth(true)
                            container:AddChild(astLabel)
                        end

                        return container
                    end
                }
            }
        else
            -- Text view (original)
            return {
                {
                    header = "APL Conditions (Text View)",
                    type = "custom",
                    customFn = function(scroll)
                        -- Create a simplified view using AceGUI
                        local container = AceGUI:Create("SimpleGroup")
                        container:SetLayout("List")
                        container:SetFullWidth(true)

                        if not self.state.rotationString then
                            local noDataLabel = AceGUI:Create("Label")
                            noDataLabel:SetText("No rotation data available")
                            noDataLabel:SetFullWidth(true)
                            container:AddChild(noDataLabel)
                            return container
                        end

                        -- Parse and display conditions
                        local conditions = {}
                        local firstTrueFound = false
                        local maxLines = 50 -- Limit to prevent overflow
                        local lineCount = 0

                        for condition in self.state.rotationString:gmatch("[^\r\n]+") do
                            if lineCount >= maxLines then
                                local limitLabel = AceGUI:Create("Label")
                                limitLabel:SetText("|cffFFD700... (showing first " ..
                                    maxLines .. " conditions, use tree view for full list)|r")
                                limitLabel:SetFullWidth(true)
                                limitLabel:SetFontObject(GameFontNormalSmall)
                                container:AddChild(limitLabel)
                                break
                            end

                            if condition:match("^%s*%(*NAG:") or condition:match("^%s*or") then
                                local cleanedCondition = condition:gsub("^%s*or%s*", "")
                                local groupType = getConditionGroupType(cleanedCondition)

                                -- Check if this filter is enabled
                                local filters = self.db.global.filters
                                if filters[groupType] then
                                    local isActive = false
                                    if not firstTrueFound and evaluateCondition(cleanedCondition) then
                                        firstTrueFound = true
                                        isActive = true
                                    end

                                    local displayText = cleanedCondition

                                    if isActive then
                                        displayText = displayText .. " |cff00ff00<<<==== ACTIVE|r"
                                        -- Show action first (as requested by user)
                                        local actionMatch = cleanedCondition:match("NAG:Cast%(([^%)]+)%)")
                                        if actionMatch then
                                            displayText = "|cffFFD700" .. actionMatch .. "|r: " .. displayText
                                        end
                                    else
                                        -- Apply highlighting
                                        local subConditions = splitSubConditions(cleanedCondition)
                                        local conditionTexts = {}
                                        for _, subCondition in ipairs(subConditions) do
                                            tinsert(conditionTexts, highlightCondition(subCondition))
                                        end
                                        displayText = table.concat(conditionTexts, " | ")
                                    end

                                    local conditionLabel = AceGUI:Create("Label")
                                    conditionLabel:SetText(displayText)
                                    conditionLabel:SetFullWidth(true)
                                    conditionLabel:SetFontObject(isActive and GameFontHighlight or GameFontNormal)
                                    container:AddChild(conditionLabel)

                                    -- Add small spacer
                                    local spacer = AceGUI:Create("Label")
                                    spacer:SetText("")
                                    spacer:SetFullWidth(true)
                                    spacer:SetHeight(2)
                                    container:AddChild(spacer)

                                    lineCount = lineCount + 1
                                end
                            end
                        end

                        return container
                    end
                },
                {
                    header = "Debug Info",
                    type = "custom",
                    customFn = function(scroll)
                        local container = AceGUI:Create("SimpleGroup")
                        container:SetLayout("List")
                        container:SetFullWidth(true)

                        local debugLabel = AceGUI:Create("Label")
                        debugLabel:SetText("Current View: " .. (self.state.currentView or "nil"))
                        debugLabel:SetFullWidth(true)
                        container:AddChild(debugLabel)

                        local stateLabel = AceGUI:Create("Label")
                        stateLabel:SetText("Has Tree Structure: " .. (self.state.treeStructure and "Yes" or "No"))
                        stateLabel:SetFullWidth(true)
                        container:AddChild(stateLabel)

                        local rotationLabel = AceGUI:Create("Label")
                        rotationLabel:SetText("Has Rotation String: " .. (self.state.rotationString and "Yes" or "No"))
                        rotationLabel:SetFullWidth(true)
                        container:AddChild(rotationLabel)

                        return container
                    end
                }
            }
        end
    end

    function APLMonitor:GetDebugControls()
        return {
            {
                type = "button",
                text = "Refresh Data",
                width = 100,
                onClick = function()
                    self:UpdateRotationData()
                    if self.debugFrame and self.debugFrame.UpdateDebugFrame then
                        self.debugFrame:UpdateDebugFrame()
                    end
                end
            },
            {
                type = "button",
                text = "Toggle View",
                width = 120,
                onClick = function()
                    -- Toggle between text and tree view
                    if self.state.currentView == "tree" then
                        self.state.currentView = "text"
                        self:Debug("APLMonitor: Switched to TEXT view")
                    else
                        self.state.currentView = "tree"
                        self:Debug("APLMonitor: Switched to TREE view")
                    end

                    -- Force refresh the debug frame
                    if self.debugFrame and self.debugFrame.UpdateDebugFrame then
                        self:Debug("APLMonitor: Using debugFrame.UpdateDebugFrame")
                        self.debugFrame:UpdateDebugFrame()
                    else
                        -- Fallback: try to find the frame through DebugFrameUtil
                        local fallbackFrame = ns.DebugFrameUtil and ns.DebugFrameUtil.activeFrames[tostring(self)]
                        if fallbackFrame and fallbackFrame.frame and fallbackFrame.frame.UpdateDebugFrame then
                            self:Debug("APLMonitor: Using DebugFrameUtil fallback")
                            fallbackFrame.frame:UpdateDebugFrame()
                        else
                            self:Debug("APLMonitor: No frame reference found for update")
                        end
                    end

                    -- Additional debugging: log the current state
                    self:Debug("APLMonitor: After toggle - currentView = '" .. self.state.currentView .. "'")
                    self:Debug("APLMonitor: After toggle - has treeStructure = " ..
                        (self.state.treeStructure and "Yes" or "No"))
                end
            }
        }
    end

    function APLMonitor:UpdateRotationData()
        -- No-op here; rotation string is now cached via message handler
    end

    function APLMonitor:ShowDebugFrame()
        -- Update rotation data before showing frame
        -- rotation data is already cached from the last message; nothing to poll
        -- Ensure we have parsed AST data before showing the frame
        self:EnsureASTData()
        ns.DebugFrameUtil:ShowDebugFrame(self, {
            title = "NAG APL Monitor (Debug)",
            width = GetScreenWidth() * 0.75,
            height = 400,
            sections = function() return self:GetDebugSections() end,
            refreshInterval = self.db.global.updateInterval,
            customControls = self:GetDebugControls(),
            position = self.db.global.monitorFramePosition,
            savePosition = true
        })

        -- Store frame reference for compatibility
        local debugFrame = ns.DebugFrameUtil.activeFrames[tostring(self)] and
            ns.DebugFrameUtil.activeFrames[tostring(self)].frame
        if debugFrame then
            self.frame = debugFrame
            self.frame.isDebugFrame = true -- Mark as debug frame
        end
    end

    function APLMonitor:CleanupFrame()
        -- Clean up frame references when switching between systems
        if self.frame then
            if self.frame.isDebugFrame then
                -- Clean up DebugFrame
                if ns.DebugFrameUtil and ns.DebugFrameUtil.activeFrames then
                    ns.DebugFrameUtil.activeFrames[tostring(self)] = nil
                end
            else
                -- Clean up old CreateFrame
                if self.frame and self.frame.GetScript then
                    if self.frame:GetScript("OnHide") then
                        self.frame:SetScript("OnHide", nil)
                    end
                end
            end
            self.frame = nil
        end
    end
end
