--- @module "NAG.APLMonitorAST"
--- AST-Native APL Monitor - Real-time rotation evaluation debugger
---
--- Provides visual debugging of APL rotation evaluation using AST instrumentation.
--- Displays node-level evaluation results, performance metrics, and evaluation history
--- with pause/resume, step controls, and comprehensive filtering.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: Rakizi, Fonsas
--- Discord: https://discord.gg/ebonhold

-- ~~~~~~~~~~ LOCALIZE ~~~~~~~~~~
local _, ns = ...
local L = ns.AceLocale:GetLocale("NAG")
--- @type NAG|AceAddon
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

-- ~~~~~~~~~~ MODULE DECLARATIONS ~~~~~~~~~~
local TableUtils = ns.TableUtils
local DebugFrameUtil = ns.DebugFrameUtil
local ASTCore = ns.ASTCore
local ASTValue = ns.ASTValue
local ASTAction = ns.ASTAction

-- Lua APIs
local format = string.format
local pairs = pairs
local ipairs = ipairs
local type = type
local tostring = tostring
local tinsert = tinsert
local sort = table.sort
local concat = table.concat
local GetTime = _G.GetTime
local CreateFrame = _G.CreateFrame

-- ~~~~~~~~~~ MODULE DEFAULTS ~~~~~~~~~~
local defaults = {
    global = {
        enabled = false, -- Locked behind DevMode
        evaluationMode = "compiled", -- "compiled" or "tree"

        -- UI settings
        framePosition = { point = "CENTER", x = 0, y = 0 },
        frameWidth = 1200,
        frameHeight = 800,

        -- Display settings
        showPerformanceColors = true,
        highlightFirstTrue = true,
        treeExpandDepth = 2,
        currentViewMode = "clause", -- "detailed", "clause", "grid"

        -- UI Refresh settings
        uiRefreshRate = 0.5, -- Update UI every 0.5s (default)
        minRefreshRate = 0.1, -- Min 10 FPS for precision debugging
        maxRefreshRate = 1.5, -- Max 1.5s (1 GCD) for performance
        smartDisplay = true, -- Only show clauses up to first PRIMARY action that would execute
        autoScroll = true, -- Auto-scroll to active clause

        -- Filters
        filters = {
            showActions = true,
            showValues = true,
            showOperators = true,
            showSuccessOnly = false,
            showFailureOnly = false,
            performanceThreshold = nil, -- ms threshold
        },

        -- Breakpoints
        breakpoints = {}, -- { nodeId -> { type, condition, enabled } }

        -- Auto-start
        autoStartInCombat = false,
    }
}

--- @class APLMonitorAST: CoreModule
local APLMonitorAST = NAG:CreateModule("APLMonitorAST", defaults, {
    moduleType = ns.MODULE_TYPES.DEBUG,
    optionsCategory = ns.MODULE_CATEGORIES.DEBUG,

    -- Hide behind DevMode
    hidden = function()
        return not NAG:IsDevModeEnabled()
    end,

    defaultState = {
        -- UI state
        frame = nil,
        isShown = false,
        selectedNodeId = nil,

        -- Current snapshot
        currentSnapshot = nil,

        -- AST cache
        cachedAST = nil,
        cachedRotationString = nil,

        -- Tree view state
        treeData = {},
        expandedNodes = {},

        -- UI refresh throttling
        lastUIUpdate = 0,
        pendingUpdate = false,

        -- Statistics
        totalTicks = 0,
        avgDuration = 0,
    },

    -- Message handlers
    messageHandlers = {
        APLMonitor_TickComplete = true,
        APLMonitor_SnapshotAdded = true,
        APLMonitor_StateChanged = true,
    },

    -- Slash commands (hierarchical debug command)
    slashCommands = {
        ["monitor"] = {
            handler = "HandleShowCommand",
            help = "Toggle AST-native APL Monitor window",
            root = "nagdebug",
            path = {"monitor"},
            category = "Debug"
        },
    },

    -- Debug categories
    debugCategories = {
        ns.DEBUG_CATEGORIES.DEBUG,
        ns.DEBUG_CATEGORIES.FEATURES
    }
})
local module = APLMonitorAST
ns.APLMonitorAST = APLMonitorAST

-- ~~~~~~~~~~ ACE3 LIFECYCLE ~~~~~~~~~~

function APLMonitorAST:ModuleInitialize()
    self:Trace("APLMonitorAST: Initialized")
end

function APLMonitorAST:ModuleEnable()
    -- Auto-start if configured
    if self.db.global.autoStartInCombat then
        self:RegisterEvent("PLAYER_REGEN_DISABLED", "OnCombatStart")
        self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnCombatEnd")
    end

    -- Invalidate AST cache on rotation change
    self:RegisterMessage("NAG_ROTATION_CHANGED", "OnRotationChanged")

    self:Debug("APLMonitorAST: Enabled")
end

--- Handle rotation change event
--- @param message string The message name
--- @param payload table|nil Optional payload with rotation details
function APLMonitorAST:OnRotationChanged(message, payload)
    self:InvalidateASTCache()
end

function APLMonitorAST:ModuleDisable()
    -- Stop monitoring if active
    self:StopMonitoring()

    -- Hide frame
    if self.state.frame then
        self.state.frame:Hide()
    end

    self:Debug("APLMonitorAST: Disabled")
end

-- ~~~~~~~~~~ AST INTEGRATION ~~~~~~~~~~

--- Get and cache rotation AST from current rotation
--- @return table|nil ast Parsed AST or nil
function APLMonitorAST:GetRotationAST()
    local rotationManager = NAG:GetModule("RotationManager")
    local classModule = NAG:GetClassModule()
    if not classModule then
        return nil
    end

    local config, rotationName = classModule:GetCurrentRotation()
    if not config or not rotationName then
        return nil
    end

    -- Use GetRotationWithProto to ensure aplProto exists
    local specIndex = config.specIndex or 0
    local rotation, err = rotationManager:GetRotationWithProto(specIndex, rotationName)

    if not rotation then
        self:Warn("GetRotationAST: %s", tostring(err))
        return nil
    end

    return rotation.aplProto
end

--- Invalidate AST cache (call when rotation changes)
function APLMonitorAST:InvalidateASTCache()
    self.state.cachedAST = nil
    self.state.cachedRotationString = nil

    self:Debug("InvalidateASTCache: AST cache cleared")
end

-- ~~~~~~~~~~ PUBLIC API ~~~~~~~~~~

--- Start monitoring evaluation
function APLMonitorAST:StartMonitoring()
    local APLMonitorFeed = NAG:GetModule("APLMonitorFeed")
    local SnapshotManager = NAG:GetModule("SnapshotManager")

    -- Enable services
    if not APLMonitorFeed:IsEnabled() then
        APLMonitorFeed:Enable()
    end

    if not SnapshotManager:IsEnabled() then
        SnapshotManager:Enable()
    end

    -- Start instrumentation
    APLMonitorFeed:StartInstrumentation(self.db.global.evaluationMode)

    -- Resume snapshot manager
    SnapshotManager:Resume()

    -- Show frame if hidden
    if not self.state.isShown then
        self:ShowFrame()
    end

    self:Info("APL Monitor started in %s mode", self.db.global.evaluationMode)

    return true
end

--- Stop monitoring evaluation
function APLMonitorAST:StopMonitoring()
    local APLMonitorFeed = NAG:GetModule("APLMonitorFeed", true)
    local SnapshotManager = NAG:GetModule("SnapshotManager", true)

    if APLMonitorFeed then
        APLMonitorFeed:StopInstrumentation()
    end

    if SnapshotManager then
        SnapshotManager:Pause()
    end

    self:Info("APL Monitor stopped")
end

--- Toggle monitoring state
function APLMonitorAST:ToggleMonitoring()
    local APLMonitorFeed = NAG:GetModule("APLMonitorFeed", true)

    if APLMonitorFeed:IsInstrumentationActive() then
        self:StopMonitoring()
    else
        self:StartMonitoring()
    end
end

--- Check if currently monitoring
--- @return boolean active True if monitoring
function APLMonitorAST:IsMonitoring()
    local APLMonitorFeed = NAG:GetModule("APLMonitorFeed", true)
    return APLMonitorFeed and APLMonitorFeed:IsInstrumentationActive() or false
end

-- ~~~~~~~~~~ UI MANAGEMENT ~~~~~~~~~~

--- Show the monitor frame
function APLMonitorAST:ShowFrame()
    if not self.state.frame then
        self:CreateFrame()
    end

    self.state.frame:Show()
    self.state.isShown = true

    -- Update display
    self:UpdateDisplay()
end

--- Hide the monitor frame
function APLMonitorAST:HideFrame()
    if self.state.frame then
        self.state.frame:Hide()
        self.state.isShown = false
    end
end

--- Toggle frame visibility
function APLMonitorAST:ToggleFrame()
    if self.state.isShown then
        self:HideFrame()
    else
        self:ShowFrame()
    end
end

--- Create the main monitor frame
function APLMonitorAST:CreateFrame()
    local frame = CreateFrame("Frame", "NAG_APLMonitor", UIParent, "BackdropTemplate")

    -- Size and position
    frame:SetSize(self.db.global.frameWidth, self.db.global.frameHeight)
    frame:SetPoint(
        self.db.global.framePosition.point,
        self.db.global.framePosition.x,
        self.db.global.framePosition.y
    )

    -- Make movable
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", function(self) self:StartMoving() end)
    frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        local point, _, _, x, y = self:GetPoint()
        APLMonitorAST.db.global.framePosition = { point = point, x = x, y = y }
    end)

    -- Backdrop
    frame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 }
    })
    frame:SetBackdropColor(0, 0, 0, 0.95)

    -- Title bar
    frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.title:SetPoint("TOP", 0, -15)
    frame.title:SetText("NAG APL Monitor")

    -- Close button
    frame.closeBtn = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    frame.closeBtn:SetPoint("TOPRIGHT", -5, -5)
    frame.closeBtn:SetScript("OnClick", function() APLMonitorAST:HideFrame() end)

    -- Control buttons panel
    self:CreateControlPanel(frame)

    -- View tabs
    self:CreateViewTabs(frame)

    -- Main content area (split into sections)
    self:CreateContentArea(frame)

    -- Status bar at bottom
    self:CreateStatusBar(frame)

    self.state.frame = frame

    self:Debug("CreateFrame: Frame created")
end

--- Create control panel with playback buttons
function APLMonitorAST:CreateControlPanel(parent)
    local panel = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    panel:SetPoint("TOPLEFT", 20, -45)
    panel:SetPoint("TOPRIGHT", -20, -45)
    panel:SetHeight(35)

    panel:SetBackdrop({
        bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    panel:SetBackdropColor(0.1, 0.1, 0.1, 0.8)
    panel:SetBackdropBorderColor(0.4, 0.4, 0.4, 1)

    -- Start/Stop button
    local startBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    startBtn:SetSize(80, 25)
    startBtn:SetPoint("LEFT", 10, 0)
    startBtn:SetText("Start")
    startBtn:SetScript("OnClick", function()
        if APLMonitorAST:IsMonitoring() then
            APLMonitorAST:StopMonitoring()
            startBtn:SetText("Start")
        else
            APLMonitorAST:StartMonitoring()
            startBtn:SetText("Stop")
        end
    end)
    panel.startBtn = startBtn

    -- Pause/Resume button
    local pauseBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    pauseBtn:SetSize(80, 25)
    pauseBtn:SetPoint("LEFT", startBtn, "RIGHT", 5, 0)
    pauseBtn:SetText("Pause")
    pauseBtn:SetScript("OnClick", function()
        local SnapshotManager = NAG:GetModule("SnapshotManager")
        if SnapshotManager:IsPaused() then
            SnapshotManager:Resume()
            pauseBtn:SetText("Pause")
        else
            SnapshotManager:Pause()
            pauseBtn:SetText("Resume")
        end
        APLMonitorAST:UpdateDisplay()
    end)
    panel.pauseBtn = pauseBtn

    -- Step back button
    local stepBackBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    stepBackBtn:SetSize(60, 25)
    stepBackBtn:SetPoint("LEFT", pauseBtn, "RIGHT", 5, 0)
    stepBackBtn:SetText("< Step")
    stepBackBtn:SetScript("OnClick", function()
        local SnapshotManager = NAG:GetModule("SnapshotManager")
        if SnapshotManager then
            SnapshotManager:StepBackward()
            APLMonitorAST:UpdateDisplay()
        end
    end)
    panel.stepBackBtn = stepBackBtn

    -- Step forward button
    local stepFwdBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    stepFwdBtn:SetSize(60, 25)
    stepFwdBtn:SetPoint("LEFT", stepBackBtn, "RIGHT", 5, 0)
    stepFwdBtn:SetText("Step >")
    stepFwdBtn:SetScript("OnClick", function()
        local SnapshotManager = NAG:GetModule("SnapshotManager")
        if SnapshotManager then
            SnapshotManager:StepForward()
            APLMonitorAST:UpdateDisplay()
        end
    end)
    panel.stepFwdBtn = stepFwdBtn

    -- Refresh button
    local refreshBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    refreshBtn:SetSize(70, 25)
    refreshBtn:SetPoint("LEFT", stepFwdBtn, "RIGHT", 5, 0)
    refreshBtn:SetText("Refresh")
    refreshBtn:SetScript("OnClick", function()
        APLMonitorAST:ForceUpdateDisplay()
    end)
    panel.refreshBtn = refreshBtn

    -- Mode selector
    local modeText = panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    modeText:SetPoint("LEFT", refreshBtn, "RIGHT", 15, 0)
    modeText:SetText("Mode:")

    local modeBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    modeBtn:SetSize(90, 25)
    modeBtn:SetPoint("LEFT", modeText, "RIGHT", 5, 0)
    modeBtn:SetText(self.db.global.evaluationMode)
    modeBtn:SetScript("OnClick", function()
        if self.db.global.evaluationMode == "compiled" then
            self.db.global.evaluationMode = "tree"
        else
            self.db.global.evaluationMode = "compiled"
        end
        modeBtn:SetText(self.db.global.evaluationMode)

        -- Restart if monitoring
        if APLMonitorAST:IsMonitoring() then
            APLMonitorAST:StopMonitoring()
            APLMonitorAST:StartMonitoring()
        end
    end)
    panel.modeBtn = modeBtn

    -- Smart display toggle (positioned on the left side)
    local smartDisplayCheckbox = CreateFrame("CheckButton", nil, panel, "UICheckButtonTemplate")
    smartDisplayCheckbox:SetSize(20, 20)
    smartDisplayCheckbox:SetPoint("RIGHT", -320, 0)
    smartDisplayCheckbox:SetChecked(self.db.global.smartDisplay)
    smartDisplayCheckbox:SetScript("OnClick", function(self)
        APLMonitorAST.db.global.smartDisplay = self:GetChecked()
        APLMonitorAST:ForceUpdateDisplay()
    end)

    local smartDisplayLabel = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    smartDisplayLabel:SetPoint("LEFT", smartDisplayCheckbox, "RIGHT", 5, 0)
    smartDisplayLabel:SetText("Smart Display")

    -- Auto-scroll toggle (positioned next to smart display)
    local autoScrollCheckbox = CreateFrame("CheckButton", nil, panel, "UICheckButtonTemplate")
    autoScrollCheckbox:SetSize(20, 20)
    autoScrollCheckbox:SetPoint("LEFT", smartDisplayLabel, "RIGHT", 15, 0)
    autoScrollCheckbox:SetChecked(self.db.global.autoScroll)
    autoScrollCheckbox:SetScript("OnClick", function(self)
        APLMonitorAST.db.global.autoScroll = self:GetChecked()
        APLMonitorAST:ForceUpdateDisplay()
    end)

    local autoScrollLabel = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    autoScrollLabel:SetPoint("LEFT", autoScrollCheckbox, "RIGHT", 5, 0)
    autoScrollLabel:SetText("Auto-Scroll")

    -- Refresh rate text
    local refreshText = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    refreshText:SetPoint("LEFT", autoScrollLabel, "RIGHT", 15, 0)
    refreshText:SetText("UI Refresh:")

    -- Refresh rate slider
    local refreshSlider = CreateFrame("Slider", nil, panel, "OptionsSliderTemplate")
    refreshSlider:SetSize(120, 20)
    refreshSlider:SetPoint("LEFT", refreshText, "RIGHT", 5, 0)
    refreshSlider:SetMinMaxValues(self.db.global.minRefreshRate, self.db.global.maxRefreshRate)
    refreshSlider:SetValue(self.db.global.uiRefreshRate)
    refreshSlider:SetValueStep(0.1)
    refreshSlider:SetObeyStepOnDrag(true)

    -- Slider labels
    refreshSlider.Low = refreshSlider:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    refreshSlider.Low:SetPoint("TOPLEFT", refreshSlider, "BOTTOMLEFT", 0, 0)
    refreshSlider.Low:SetText("0.1s")

    refreshSlider.High = refreshSlider:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    refreshSlider.High:SetPoint("TOPRIGHT", refreshSlider, "BOTTOMRIGHT", 0, 0)
    refreshSlider.High:SetText("1.5s")

    refreshSlider.Text = refreshSlider:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    refreshSlider.Text:SetPoint("TOP", refreshSlider, "BOTTOM", 0, 0)
    refreshSlider.Text:SetText(format("%.1fs", self.db.global.uiRefreshRate))

    refreshSlider:SetScript("OnValueChanged", function(self, value)
        APLMonitorAST.db.global.uiRefreshRate = value
        refreshSlider.Text:SetText(format("%.1fs", value))
        -- Force immediate update to show new rate
        APLMonitorAST:ForceUpdateDisplay()
    end)

    panel.refreshSlider = refreshSlider

    -- Clear button
    local clearBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    clearBtn:SetSize(60, 25)
    clearBtn:SetPoint("RIGHT", -10, 0)
    clearBtn:SetText("Clear")
    clearBtn:SetScript("OnClick", function()
        local SnapshotManager = NAG:GetModule("SnapshotManager")
        if SnapshotManager then
            SnapshotManager:ClearBuffer()
            APLMonitorAST:ForceUpdateDisplay()
        end
    end)
    panel.clearBtn = clearBtn

    parent.controlPanel = panel
end

--- Create view tabs
function APLMonitorAST:CreateViewTabs(parent)
    local tabContainer = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    tabContainer:SetPoint("TOPLEFT", parent.controlPanel, "BOTTOMLEFT", 0, -5)
    tabContainer:SetPoint("TOPRIGHT", parent.controlPanel, "BOTTOMRIGHT", 0, -5)
    tabContainer:SetHeight(30)

    tabContainer:SetBackdrop({
        bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
        tile = true, tileSize = 16,
    })
    tabContainer:SetBackdropColor(0.05, 0.05, 0.05, 0.8)

    -- Clause View tab (default)
    local clauseTab = CreateFrame("Button", nil, tabContainer, "UIPanelButtonTemplate")
    clauseTab:SetSize(120, 25)
    clauseTab:SetPoint("LEFT", 10, 0)
    clauseTab:SetText("Clause View")
    clauseTab:SetScript("OnClick", function()
        self.db.global.currentViewMode = "clause"
        self:UpdateViewVisibility()
        self:ForceUpdateDisplay()
    end)

    -- Detailed View tab
    local detailedTab = CreateFrame("Button", nil, tabContainer, "UIPanelButtonTemplate")
    detailedTab:SetSize(120, 25)
    detailedTab:SetPoint("LEFT", clauseTab, "RIGHT", 5, 0)
    detailedTab:SetText("Detailed View")
    detailedTab:SetScript("OnClick", function()
        self.db.global.currentViewMode = "detailed"
        self:UpdateViewVisibility()
        self:ForceUpdateDisplay()
    end)

    -- Grid View tab (future)
    local gridTab = CreateFrame("Button", nil, tabContainer, "UIPanelButtonTemplate")
    gridTab:SetSize(120, 25)
    gridTab:SetPoint("LEFT", detailedTab, "RIGHT", 5, 0)
    gridTab:SetText("Grid View")
    gridTab:SetScript("OnClick", function()
        self.db.global.currentViewMode = "grid"
        self:UpdateViewVisibility()
        self:ForceUpdateDisplay()
    end)

    parent.viewTabs = { clauseTab, detailedTab, gridTab }
    parent.tabContainer = tabContainer
end

--- Update view visibility based on current mode
function APLMonitorAST:UpdateViewVisibility()
    if not self.state.frame or not self.state.frame.contentArea then
        return
    end

    local mode = self.db.global.currentViewMode
    local content = self.state.frame.contentArea

    -- Show/hide appropriate containers
    if content.clauseContainer then
        content.clauseContainer:SetShown(mode == "clause")
    end

    if content.detailedContainer then
        content.detailedContainer:SetShown(mode == "detailed")
    end

    if content.gridContainer then
        content.gridContainer:SetShown(mode == "grid")
    end

    -- Update tab highlights
    if self.state.frame.viewTabs then
        for i, tab in ipairs(self.state.frame.viewTabs) do
            local tabMode = ({ "clause", "detailed", "grid" })[i]
            if tabMode == mode then
                tab:Disable()
                tab:SetAlpha(1.0)
            else
                tab:Enable()
                tab:SetAlpha(0.7)
            end
        end
    end
end

--- Create main content area with all view containers
function APLMonitorAST:CreateContentArea(parent)
    local content = CreateFrame("Frame", nil, parent)
    content:SetPoint("TOPLEFT", 20, -120) -- Adjusted for tabs
    content:SetPoint("BOTTOMRIGHT", -20, 40)

    -- CLAUSE VIEW Container (full width)
    local clauseContainer = CreateFrame("Frame", nil, content)
    clauseContainer:SetAllPoints(content)

    local clauseScroll = CreateFrame("ScrollFrame", nil, clauseContainer, "UIPanelScrollFrameTemplate")
    clauseScroll:SetPoint("TOPLEFT", 0, 0)
    clauseScroll:SetPoint("BOTTOMRIGHT", -20, 0)

    local clauseContent = CreateFrame("Frame", nil, clauseScroll)
    clauseContent:SetSize(clauseScroll:GetWidth() - 20, 1)
    clauseScroll:SetScrollChild(clauseContent)

    clauseContainer.scroll = clauseScroll
    clauseContainer.content = clauseContent
    content.clauseContainer = clauseContainer

    -- DETAILED VIEW Container (split view)
    local detailedContainer = CreateFrame("Frame", nil, content)
    detailedContainer:SetAllPoints(content)

    -- Create scroll frame for tree view (left side)
    local treeScroll = CreateFrame("ScrollFrame", nil, detailedContainer, "UIPanelScrollFrameTemplate")
    treeScroll:SetPoint("TOPLEFT", 0, 0)
    treeScroll:SetPoint("BOTTOMLEFT", 0, 0)
    treeScroll:SetWidth(content:GetWidth() * 0.5 - 10)

    local treeContent = CreateFrame("Frame", nil, treeScroll)
    treeContent:SetSize(treeScroll:GetWidth() - 20, 1)
    treeScroll:SetScrollChild(treeContent)

    detailedContainer.treeScroll = treeScroll
    detailedContainer.treeContent = treeContent

    -- Create details panel (right side)
    local detailsScroll = CreateFrame("ScrollFrame", nil, detailedContainer, "UIPanelScrollFrameTemplate")
    detailsScroll:SetPoint("TOPRIGHT", 0, 0)
    detailsScroll:SetPoint("BOTTOMRIGHT", 0, 0)
    detailsScroll:SetWidth(content:GetWidth() * 0.5 - 10)

    local detailsContent = CreateFrame("Frame", nil, detailsScroll)
    detailsContent:SetSize(detailsScroll:GetWidth() - 20, 1)
    detailsScroll:SetScrollChild(detailsContent)

    detailedContainer.detailsScroll = detailsScroll
    detailedContainer.detailsContent = detailsContent
    content.detailedContainer = detailedContainer

    -- GRID VIEW Container (future)
    local gridContainer = CreateFrame("Frame", nil, content)
    gridContainer:SetAllPoints(content)
    gridContainer:Hide()
    content.gridContainer = gridContainer

    parent.contentArea = content

    -- Set initial visibility
    self:UpdateViewVisibility()
end

--- Create status bar at bottom
function APLMonitorAST:CreateStatusBar(parent)
    local status = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    status:SetPoint("BOTTOMLEFT", 20, 10)
    status:SetPoint("BOTTOMRIGHT", -20, 10)
    status:SetHeight(25)

    status:SetBackdrop({
        bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
        tile = true, tileSize = 16,
    })
    status:SetBackdropColor(0.1, 0.1, 0.1, 0.8)

    status.text = status:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    status.text:SetPoint("LEFT", 10, 0)
    status.text:SetText("Ready")

    parent.statusBar = status
end

-- ~~~~~~~~~~ DISPLAY UPDATE ~~~~~~~~~~

--- Update all display elements
function APLMonitorAST:UpdateDisplay()
    if not self.state.frame or not self.state.isShown then
        return
    end

    -- Get current snapshot
    local SnapshotManager = NAG:GetModule("SnapshotManager")
    self.state.currentSnapshot = SnapshotManager:GetCurrentSnapshot()

    -- Route to appropriate view
    local mode = self.db.global.currentViewMode

    if mode == "clause" then
        self:UpdateClauseView()
    elseif mode == "detailed" then
        -- Update tree view
        self:UpdateTreeView()
        -- Update details panel
        self:UpdateDetailsPanel()
    elseif mode == "grid" then
        self:UpdateGridView()
    end

    -- Update status bar
    self:UpdateStatusBar()

    -- Update button states
    self:UpdateButtonStates()
end

-- ~~~~~~~~~~ CLAUSE VIEW RENDERING ~~~~~~~~~~

--- Update clause view with current snapshot
function APLMonitorAST:UpdateClauseView()
    local container = self.state.frame.contentArea.clauseContainer
    if not container then
        return
    end

    local content = container.content

    -- Clear existing
    for _, child in ipairs({content:GetChildren()}) do
        child:Hide()
        child:SetParent(nil)
    end

    for _, region in ipairs({content:GetRegions()}) do
        if region.GetObjectType and region:GetObjectType() == "FontString" then
            region:Hide()
            region:SetText("")
            region:SetParent(nil)
        end
    end

    -- Get rotation AST
    local ast = self:GetRotationAST()
    if not ast or not ast.priority_list then
        local noDataFrame = CreateFrame("Frame", nil, content)
        noDataFrame:SetPoint("TOPLEFT", 10, -10)
        noDataFrame:SetSize(content:GetWidth() - 20, 100)

        local noData = noDataFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        noData:SetPoint("TOPLEFT", 0, 0)
        noData:SetText("|cFFFF6600No rotation AST available|r\n\nSelect a rotation and start monitoring.")
        noData:SetJustifyH("LEFT")
        return
    end

    -- Determine if we should use smart display (stop at first PRIMARY action)
    local smartDisplay = self.db.global.smartDisplay

    -- Get current snapshot for handler results
    if not self.state.currentSnapshot then
        local noSnapFrame = CreateFrame("Frame", nil, content)
        noSnapFrame:SetPoint("TOPLEFT", 10, -10)
        noSnapFrame:SetSize(content:GetWidth() - 20, 100)

        local noSnap = noSnapFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        noSnap:SetPoint("TOPLEFT", 0, 0)
        noSnap:SetText("|cFFFF6600No evaluation snapshot|r\n\nStart monitoring to capture data.")
        noSnap:SetJustifyH("LEFT")
        return
    end

    -- Build handler results map by signature
    local handlerResults = {}
    for _, node in ipairs(self.state.currentSnapshot.nodes or {}) do
        if node.data and node.data.signature then
            handlerResults[node.data.signature] = {
                result = node.result,
                duration = node.duration,
            }
        end
    end

    -- DEBUG: Show sample AST structure
    if ast.priority_list and ast.priority_list[1] and ast.priority_list[1].condition then
        self:Debug("=== SAMPLE AST CONDITION STRUCTURE ===")
        local firstCond = ast.priority_list[1].condition
        self:Debug("First clause condition dump:")
        self:Debug(ns.TableUtils.ToString(firstCond, 3))
        self:Debug("======================================")
    end

    -- DEBUG: Show what signatures we have
    local totalSigs = ns.TableUtils.Size(handlerResults)
    self:Debug("=== HANDLER RESULTS MAP (%d total) ===", totalSigs)
    local count = 0
    for sig, data in pairs(handlerResults) do
        count = count + 1
        if count <= 20 then -- Show first 20
            self:Debug("#%d [%s] = %s", count, sig, tostring(data.result))
        end
    end
    if totalSigs > 20 then
        self:Debug("... (%d more)", totalSigs - 20)
    end
    self:Debug("==========================")

    -- Find first true clause (where all conditions passed)
    local firstTrueClause = self:FindFirstTrueClause(ast.priority_list, handlerResults)

    -- Determine stopping point for smart display
    local stopAtClause = nil
    if smartDisplay and firstTrueClause then
        -- Check if the first-true action is PRIMARY (would stop evaluation)
        local listItem = ast.priority_list[firstTrueClause]
        if listItem and listItem.action then
            local isPrimary = self:IsActionPrimary(listItem.action)
            if isPrimary then
                -- This PRIMARY action would stop evaluation (return true)
                stopAtClause = firstTrueClause
            else
                -- This SECONDARY action would continue (return false)
                -- Find the first PRIMARY action that would actually execute
                for i = firstTrueClause + 1, #ast.priority_list do
                    local testListItem = ast.priority_list[i]
                    if testListItem and testListItem.action then
                        -- Check if this clause's conditions would pass
                        local wouldPass = self:EvaluateClauseConditions(testListItem.condition, handlerResults)
                        if wouldPass then
                            local isTestPrimary = self:IsActionPrimary(testListItem.action)
                            if isTestPrimary then
                                stopAtClause = i
                                break
                            end
                        end
                    end
                end
                -- If no PRIMARY action found after first-true, show up to first-true
                if not stopAtClause then
                    stopAtClause = firstTrueClause
                end
            end
        end
    end

    -- Render clauses (up to stopAtClause if smart display is enabled)
    local maxClause = stopAtClause or #ast.priority_list
    local yOffset = -10
    local firstTrueYPosition = nil

    for i, listItem in ipairs(ast.priority_list) do
        if i > maxClause then
            break -- Stop rendering
        end

        local isFirstTrue = (i == firstTrueClause)

        -- Track Y position of first true clause for auto-scroll
        if isFirstTrue then
            firstTrueYPosition = math.abs(yOffset)
        end

        local clauseFrame = self:RenderClause(content, listItem, i, handlerResults, yOffset, isFirstTrue)
        yOffset = yOffset - (clauseFrame.height or 80)
    end

    -- Show indicator if clauses were filtered
    if smartDisplay and stopAtClause and stopAtClause < #ast.priority_list then
        local indicatorFrame = CreateFrame("Frame", nil, content)
        indicatorFrame:SetPoint("TOPLEFT", 0, yOffset)
        indicatorFrame:SetSize(content:GetWidth(), 20)

        local indicator = indicatorFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        indicator:SetPoint("TOPLEFT", 0, 0)
        indicator:SetText(format("|cFF888888... (%d more clause%s hidden - evaluation stopped at PRIMARY action)|r",
            #ast.priority_list - stopAtClause,
            (#ast.priority_list - stopAtClause) == 1 and "" or "s"))
        yOffset = yOffset - 25
    end

    -- Update content height
    content:SetHeight(math.abs(yOffset) + 20)

    -- Auto-scroll to first true clause (if enabled)
    if self.db.global.autoScroll and firstTrueYPosition and container.scroll then
        -- Center the first true clause in the viewport
        local scrollFrame = container.scroll
        local viewportHeight = scrollFrame:GetHeight()

        -- Calculate scroll position to center the clause
        -- Subtract half viewport height to center it
        local scrollTo = math.max(0, firstTrueYPosition - (viewportHeight / 2))

        -- Clamp to valid scroll range
        local maxScroll = math.max(0, content:GetHeight() - viewportHeight)
        scrollTo = math.min(scrollTo, maxScroll)

        scrollFrame:SetVerticalScroll(scrollTo)
    end
end

--- Find first clause where all conditions resolved true
--- @param priorityList table Array of priority list items (proto AST)
--- @param handlerResults table Map of signature -> result data
--- @return number|nil clauseNum First true clause number or nil
function APLMonitorAST:FindFirstTrueClause(priorityList, handlerResults)
    for i, listItem in ipairs(priorityList) do
        local allTrue = self:EvaluateClauseConditions(listItem.condition, handlerResults)
        if allTrue then
            return i
        end
    end
    return nil
end

--- Evaluate if all conditions in a clause are true
--- @param condNode table Condition AST node (proto AST)
--- @param handlerResults table Map of signature -> result data
--- @return boolean allTrue True if all conditions passed
function APLMonitorAST:EvaluateClauseConditions(condNode, handlerResults)
    if not condNode then
        return true -- Unconditional clause
    end

    -- Handle proto AST value nodes
    if condNode.type == ASTCore.NodeType.VALUE then
        local valueType = ASTValue.GetValueType(condNode)
        local valueData = ASTValue.GetValueData(condNode)

        if not valueType or not valueData then
            return false
        end

        -- Handle logical operators (AND, OR, NOT)
        if valueType == ASTValue.ValueType.AND then
            -- All children must be true
            for _, val in ipairs(valueData.vals or {}) do
                if not self:EvaluateClauseConditions(val, handlerResults) then
                    return false
                end
            end
            return true
        elseif valueType == ASTValue.ValueType.OR then
            -- At least one child must be true
            for _, val in ipairs(valueData.vals or {}) do
                if self:EvaluateClauseConditions(val, handlerResults) then
                    return true
                end
            end
            return false
        elseif valueType == ASTValue.ValueType.NOT then
            return not self:EvaluateClauseConditions(valueData.val, handlerResults)

        -- Handle comparison (we don't have both sides evaluated, default to unknown)
        elseif valueType == ASTValue.ValueType.CMP then
            return false

        -- Handle function calls (value types like spell_is_ready, aura_is_active, etc.)
        else
            local signature = self:GetNodeSignature(condNode)
            local resultData = handlerResults[signature]
            return resultData and resultData.result == true or false
        end
    end

    return false
end

--- Render a single clause with conditions and action
--- @param parent Frame Parent frame
--- @param listItem table Priority list item (proto AST with action/condition)
--- @param clauseNum number Clause number
--- @param handlerResults table Map of signature -> result data
--- @param yOffset number Y offset for positioning
--- @param isFirstTrue boolean Whether this is the first clause where all conditions passed
--- @return table clauseFrame Created clause frame
function APLMonitorAST:RenderClause(parent, listItem, clauseNum, handlerResults, yOffset, isFirstTrue)
    local frame = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    frame:SetPoint("TOPLEFT", 0, yOffset)
    frame:SetSize(parent:GetWidth(), 1) -- Height will be calculated

    -- Highlight first-true clause with green border
    local bgColor = isFirstTrue and {0.0, 0.2, 0.0, 0.6} or {0.1, 0.1, 0.1, 0.5}
    local borderColor = isFirstTrue and {0.0, 1.0, 0.0, 1.0} or {0.3, 0.3, 0.3, 0.8}

    frame:SetBackdrop({
        bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 12,
        insets = { left = 3, right = 3, top = 3, bottom = 3 }
    })
    frame:SetBackdropColor(bgColor[1], bgColor[2], bgColor[3], bgColor[4])
    frame:SetBackdropBorderColor(borderColor[1], borderColor[2], borderColor[3], borderColor[4])

    local currentY = -8

    -- Clause header
    local headerFrame = CreateFrame("Frame", nil, frame)
    headerFrame:SetPoint("TOPLEFT", 8, currentY)
    headerFrame:SetSize(frame:GetWidth() - 16, 18)

    local header = headerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    header:SetPoint("TOPLEFT", 0, 0)
    header:SetText(format("|cFFFFD700Clause %d:|r", clauseNum))
    currentY = currentY - 20

    -- Render condition
    if listItem.condition then
        local condText = self:RenderConditionInline(listItem.condition, handlerResults)

        local condFrame = CreateFrame("Frame", nil, frame)
        condFrame:SetPoint("TOPLEFT", 15, currentY)
        condFrame:SetSize(frame:GetWidth() - 30, 30)

        local condStr = condFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        condStr:SetPoint("TOPLEFT", 0, 0)
        condStr:SetText(condText)
        condStr:SetJustifyH("LEFT")
        condStr:SetNonSpaceWrap(true)
        condStr:SetWidth(condFrame:GetWidth())

        currentY = currentY - 35
    else
        -- No condition (unconditional clause)
        local uncondFrame = CreateFrame("Frame", nil, frame)
        uncondFrame:SetPoint("TOPLEFT", 15, currentY)
        uncondFrame:SetSize(frame:GetWidth() - 30, 15)

        local uncondStr = uncondFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        uncondStr:SetPoint("TOPLEFT", 0, 0)
        uncondStr:SetText("|cFF888888(unconditional)|r")
        currentY = currentY - 18
    end

    -- Render action
    if listItem.action then
        local actionText = self:RenderAction(listItem.action, handlerResults, isFirstTrue)

        local actionFrame = CreateFrame("Frame", nil, frame)
        actionFrame:SetPoint("TOPLEFT", 15, currentY)
        actionFrame:SetSize(frame:GetWidth() - 30, 20)

        local actionStr = actionFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        actionStr:SetPoint("TOPLEFT", 0, 0)

        -- Add special marker for first-true clause (use WoW-safe characters)
        local marker = isFirstTrue and "|cFF00FF00<< ACTIVE|r " or ""
        actionStr:SetText("|cFFAAFFAA>|r " .. actionText .. " " .. marker)
        currentY = currentY - 25
    end

    -- Set final frame height
    frame.height = math.abs(currentY) + 10
    frame:SetHeight(frame.height)

    return frame
end

--- Render condition tree with inline results
--- @param condNode table Condition AST node (proto AST)
--- @param handlerResults table Map of signature -> result data
--- @return string Formatted condition text
function APLMonitorAST:RenderConditionInline(condNode, handlerResults)
    if not condNode then
        return ""
    end

    -- Handle proto AST value nodes
    if condNode.type == ASTCore.NodeType.VALUE then
        local valueType = ASTValue.GetValueType(condNode)
        local valueData = ASTValue.GetValueData(condNode)

        if not valueType or not valueData then
            return "|cFFFF0000[Unknown Value]|r"
        end

        -- Handle logical operators (AND, OR, NOT)
        if valueType == ASTValue.ValueType.AND or valueType == ASTValue.ValueType.OR then
            local parts = {}
            local op = valueType == ASTValue.ValueType.AND and "and" or "or"
            for i, val in ipairs(valueData.vals or {}) do
                if i > 1 then
                    tinsert(parts, format("|cFF888888%s|r", op:upper()))
                end
                tinsert(parts, self:RenderConditionInline(val, handlerResults))
            end
            return concat(parts, " ")
        elseif valueType == ASTValue.ValueType.NOT then
            return format("|cFF888888NOT|r %s", self:RenderConditionInline(valueData.val, handlerResults))

        -- Handle comparison
        elseif valueType == ASTValue.ValueType.CMP then
            local lhs = self:RenderConditionInline(valueData.lhs, handlerResults)
            local rhs = self:RenderConditionInline(valueData.rhs, handlerResults)
            local op = ASTValue.ComparisonOpToSymbol(valueData.op) or "?"
            return format("%s |cFFFFFFFF%s|r %s", lhs, op, rhs)

        -- Handle constants
        elseif valueType == ASTValue.ValueType.CONST then
            return format("|cFFAAFFFF%s|r", tostring(valueData.val))

        -- Handle function calls (value types like spell_is_ready, aura_is_active, etc.)
        else
            -- Get handler signature and result
            local signature = self:GetNodeSignature(condNode)
            local resultData = handlerResults[signature]

            -- DEBUG: Show detailed signature lookup
            self:Debug("=== Condition Node Lookup ===")
            self:Debug("  Node type: %s, valueType: %s", condNode.type, tostring(valueType))
            self:Debug("  Generated signature: [%s]", signature)
            self:Debug("  Found in results? %s", resultData and "YES" or "NO")
            if resultData then
                self:Debug("  Result: %s (type: %s)", tostring(resultData.result), type(resultData.result))
            else
                -- Show first 5 matching signatures from map
                self:Debug("  Searching for similar signatures in map...")
                local count = 0
                for sig, data in pairs(handlerResults) do
                    if sig:find(valueType or "???", 1, true) then
                        count = count + 1
                        if count <= 5 then
                            self:Debug("    Similar: [%s] = %s", sig, tostring(data.result))
                        end
                    end
                end
                if count == 0 then
                    self:Debug("    No similar signatures found!")
                elseif count > 5 then
                    self:Debug("    ... (%d more similar)", count - 5)
                end
            end
            self:Debug("==========================")

            -- Result icon using WoW-appropriate textures
            local icon = "|TInterface\\RaidFrame\\ReadyCheck-Waiting:14:14|t" -- Default: unknown/waiting
            if resultData then
                if resultData.result == true then
                    -- Green checkmark using ready check icon
                    icon = "|TInterface\\RaidFrame\\ReadyCheck-Ready:14:14|t"
                elseif resultData.result == false then
                    -- Red X using ready check icon
                    icon = "|TInterface\\RaidFrame\\ReadyCheck-NotReady:14:14|t"
                end
            end

            -- Resolve name
            local displayName = self:ResolveName(condNode)

            -- Format value
            local value = ""
            if resultData and resultData.result ~= nil then
                local funcName = self:GetHandlerNameFromValueType(valueType)
                value = " = " .. self:FormatValue(resultData.result, funcName)
            end

            return format("%s %s%s", icon, displayName, value)
        end
    end

    return "|cFFFF0000[Unknown]|r"
end

--- Render action with result
--- @param actionNode table Action AST node
--- @param handlerResults table Map of signature -> result data
--- @param isFirstTrue boolean Whether this is the first-true clause
--- @return string Formatted action text
function APLMonitorAST:RenderAction(actionNode, handlerResults, isFirstTrue)
    if not actionNode then
        return "|cFFFF0000[No action]|r"
    end

    -- DEBUG: Log the entire action node structure (only in DevMode)
    local TableUtils = ns.TableUtils
    self:Debug("=== RenderAction DEBUG ===")
    self:Debug("Action node type: %s", tostring(actionNode.type))
    self:Debug("Action node spellId: %s", tostring(actionNode.spellId))
    self:Debug("Action node sequenceName: %s", tostring(actionNode.sequenceName))
    if actionNode.action then
        self:Debug("Action node has 'action' table")
        for key, value in pairs(actionNode.action) do
            self:Debug("  action.%s = %s", tostring(key), type(value) == "table" and "{table}" or tostring(value))
        end
    else
        self:Debug("Action node has NO 'action' table")
    end
    self:Debug("Full action node structure:")
    self:Debug(TableUtils.ToString(actionNode, 2))
    self:Debug("=========================")

    -- Extract action type and spell ID from action node
    -- The AST stores actions with:
    --   actionType = "cast_spell" | "strict_sequence" | etc.
    --   functionName = "Cast" | "StrictSequence" | etc.
    --   arguments = { [1] = { value = spellId, type = "constant" }, ... }

    local actionType = actionNode.actionType or "unknown"  -- Use actionType, not type
    local spellId = nil
    local sequenceName = nil

    -- Extract spell ID and action type from proto AST action node using FieldFormatConverter
    local FieldFormatConverter = ns.FieldFormatConverter
    if actionNode.action then
        self:Debug("Checking proto format in actionNode.action table...")
        -- Proto format: actionNode.action.cast_spell or .channel_spell
        if actionNode.action.cast_spell then
            self:Debug("Found cast_spell action")
            if actionNode.action.cast_spell.spell_id then
                actionType = "cast"
                local spellIdRef = actionNode.action.cast_spell.spell_id
                self:Debug("spell_id type: %s, value: %s", type(spellIdRef), tostring(spellIdRef))
                -- Use FieldFormatConverter to extract ActionID properly
                if FieldFormatConverter then
                    spellId = FieldFormatConverter:ExtractActionID(spellIdRef)
                    if spellId then
                        self:Debug("Extracted spellId via FieldFormatConverter: %d", spellId)
                    end
                end
            else
                self:Debug("cast_spell exists but has no spell_id")
            end
        elseif actionNode.action.channel_spell then
            self:Debug("Found channel_spell action")
            if actionNode.action.channel_spell.spell_id then
                actionType = "channel"
                local spellIdRef = actionNode.action.channel_spell.spell_id
                self:Debug("spell_id type: %s, value: %s", type(spellIdRef), tostring(spellIdRef))
                -- Use FieldFormatConverter to extract ActionID properly
                if FieldFormatConverter then
                    spellId = FieldFormatConverter:ExtractActionID(spellIdRef)
                    if spellId then
                        self:Debug("Extracted spellId via FieldFormatConverter: %d", spellId)
                    end
                end
            else
                self:Debug("channel_spell exists but has no spell_id")
            end
        elseif actionNode.action.sequence then
            self:Debug("Found sequence action")
            actionType = "sequence"
            sequenceName = actionNode.action.sequence.name or actionNode.sequenceName
            self:Debug("Sequence name: %s", tostring(sequenceName))
        elseif actionNode.action.autocast_other_cooldowns then
            self:Debug("Found autocast_other_cooldowns action")
            actionType = "autocast_cooldowns"
        elseif actionNode.action.wait then
            self:Debug("Found wait action")
            actionType = "wait"
        else
            self:Debug("No recognized action type in actionNode.action")
        end
    else
        self:Debug("No actionNode.action table and no legacy spellId")
    end

    -- Also check legacy sequenceName field
    if not sequenceName and actionNode.sequenceName then
        sequenceName = actionNode.sequenceName
        if actionType == "unknown" then
            actionType = "sequence"
        end
    end

    -- DEBUG: Show final extraction results (only in DevMode)
    self:Debug("FINAL EXTRACTION: actionType=%s, spellId=%s, sequenceName=%s",
        tostring(actionType), tostring(spellId), tostring(sequenceName))

    -- Determine action color based on primary vs secondary
    local isPrimary = self:IsActionPrimary(actionNode)

    local actionColor
    if not isPrimary then
        -- All secondary actions: consistent orange color
        actionColor = "|cFFFFAA00"
    elseif isFirstTrue then
        -- Primary action in first true clause: bright green
        actionColor = "|cFF00FF00"
    else
        -- Primary action in other clauses: white
        actionColor = "|cFFFFFFFF"
    end

    local actionText = ""

    -- Check for cast actions (actionType is "cast_spell" or "channel_spell" from AST)
    if (actionType == "cast_spell" or actionType == "channel_spell") and spellId then
        -- Get spell name from DataManager
        local DataManager = NAG:GetModule("DataManager")
        local spellName = "Unknown"
        if DataManager then
            local entity = DataManager:Get(spellId, DataManager.EntityTypes.SPELL)
            if entity and entity.name then
                spellName = entity.name
            end
        end

        -- Format action with spell details
        local displayType = actionType == "cast_spell" and "CAST" or "CHANNEL"
        actionText = format("%s%s|r(%s: %d)",
            actionColor, displayType, spellName, spellId)

    elseif actionType == "strict_sequence" then
        local seqName = sequenceName or "Unknown"
        actionText = format("%sSTRICT_SEQUENCE|r(%s)", actionColor, seqName)

    elseif actionType == "sequence" then
        local seqName = sequenceName or "Unknown"
        actionText = format("%sSEQUENCE|r(%s)", actionColor, seqName)

    elseif actionType == "wait" then
        local duration = actionNode.duration or "?"
        actionText = format("%sWAIT|r(%s)", actionColor, tostring(duration))

    elseif actionType == "autocast_other_cooldowns" then
        actionText = format("%sAUTOCAST_COOLDOWNS|r", actionColor)

    else
        -- Fallback: show action type (shouldn't normally happen)
        actionText = format("%s%s|r", actionColor, actionType:upper())
    end

    return actionText
end

-- ~~~~~~~~~~ ACTION CLASSIFICATION UTILITIES ~~~~~~~~~~

--- Check if an action is PRIMARY (would set nextSpell and stop evaluation)
--- @param actionNode table Action AST node
--- @return boolean isPrimary True if action is PRIMARY, false if SECONDARY
function APLMonitorAST:IsActionPrimary(actionNode)
    if not actionNode then
        return false
    end

    -- Check for specific action types that are always SECONDARY (no spellId needed)
    if actionNode.actionType == "autocast_other_cooldowns" or
       (actionNode.action and actionNode.action.autocast_other_cooldowns) then
        return false
    end

    -- Extract spellId from proto AST action node using FieldFormatConverter
    -- Proto AST stores spell ID in action.action.cast_spell.spell_id or action.action.channel_spell.spell_id
    local spellId = nil
    local FieldFormatConverter = ns.FieldFormatConverter

    if actionNode.action and FieldFormatConverter then
        -- Proto format: actionNode.action.cast_spell or .channel_spell
        if actionNode.action.cast_spell and actionNode.action.cast_spell.spell_id then
            local spellIdRef = actionNode.action.cast_spell.spell_id
            spellId = FieldFormatConverter:ExtractActionID(spellIdRef)
        elseif actionNode.action.channel_spell and actionNode.action.channel_spell.spell_id then
            local spellIdRef = actionNode.action.channel_spell.spell_id
            spellId = FieldFormatConverter:ExtractActionID(spellIdRef)
        end
    end

    if not spellId or type(spellId) ~= "number" then
        -- Can't determine spell ID, check action type
        -- Specific non-spell actions that are SECONDARY (autocast cooldowns)
        if actionNode.actionType == "autocast_other_cooldowns" or
           actionNode.actionType == "autocast_cooldowns" or
           (actionNode.action and (actionNode.action.autocast_other_cooldowns or actionNode.action.autocast_cooldowns)) then
            return false
        end

        -- Can't determine spell ID, assume PRIMARY (most actions without spellId are PRIMARY)
        return true
    end

    -- Check if spell is secondary using NAG's classification system
    -- Note: This requires NAG to be loaded, but APLMonitorAST is a debug tool so that's fine
    if NAG and NAG.IsSecondarySpell then
        local isSecondary = NAG:IsSecondarySpell(spellId)
        -- If it's secondary, return false (not primary)
        -- If it's not secondary (or IsSecondarySpell fails), return true (is primary)
        return not isSecondary
    end

    -- Fallback: Check SpellbookManager directly
    local SpellbookManager = NAG:GetModule("SpellbookManager")
    if SpellbookManager then
        local position = SpellbookManager:GetSpellPosition(spellId)
        -- PRIMARY (or nil/defaults to PRIMARY) means it's a primary action
        return not position or position == ns.SPELL_POSITIONS.PRIMARY
    end

    -- Final fallback: assume PRIMARY (safer default)
    return true
end

-- ~~~~~~~~~~ VALUE FORMATTING UTILITIES ~~~~~~~~~~

--- Get handler signature from proto AST value node
--- @param valueNode table Proto AST value node
--- @return string signature Handler signature
function APLMonitorAST:GetNodeSignature(valueNode)
    if not valueNode or valueNode.type ~= ASTCore.NodeType.VALUE then
        return "unknown()"
    end

    local valueType = ASTValue.GetValueType(valueNode)
    if not valueType then
        return "unknown()"
    end

    -- Get NAG handler name from value type
    local funcName = self:GetHandlerNameFromValueType(valueType)
    if not funcName then
        return "unknown()"
    end

    -- Extract first argument from proto value node
    local valueData = ASTValue.GetValueData(valueNode)
    if not valueData then
        return funcName .. "()"
    end

    -- Use schema-based extraction with FieldFormatConverter
    local SchemaAccessor = NAG:GetModule("SchemaAccessor")
    local FieldFormatConverter = ns.FieldFormatConverter
    if SchemaAccessor and FieldFormatConverter then
        -- Convert value type to proto name (e.g., "spell_is_ready" -> "APLValueSpellIsReady")
        local protoName = "APLValue" .. self:SnakeToCamel(valueType)
        local fields, fieldOrder = SchemaAccessor:GetFields(protoName)
        if fieldOrder and #fieldOrder > 0 then
            local firstField = fieldOrder[1]
            local firstArg = valueData[firstField]
            local fieldInfo = fields[firstField]

            if firstArg and fieldInfo then
                -- Use FieldFormatConverter to extract value (handles ActionID, UnitReference, etc.)
                local extracted = FieldFormatConverter:ExtractValue(firstArg, fieldInfo)
                if extracted ~= nil then
                    if type(extracted) == "number" then
                        return format("%s(%d)", funcName, extracted)
                    elseif type(extracted) == "string" then
                        return format("%s(%s)", funcName, extracted)
                    else
                        return format("%s(%s)", funcName, tostring(extracted))
                    end
                end
            end
        end
    end

    return funcName .. "(...)"
end

--- Get NAG handler name from proto value type
--- @param valueType string Proto value type (e.g., "spell_is_ready")
--- @return string|nil Handler name (e.g., "SpellIsReady")
function APLMonitorAST:GetHandlerNameFromValueType(valueType)
    if not valueType then
        return nil
    end

    local SchemaAccessor = NAG:GetModule("SchemaAccessor")
    if not SchemaAccessor then
        return nil
    end

    -- Convert value type to proto name (e.g., "spell_is_ready" -> "APLValueSpellIsReady")
    local protoName = "APLValue" .. self:SnakeToCamel(valueType)
    local nagName = SchemaAccessor:GetNagNameFromProtoName(protoName)
    return nagName
end

--- Convert snake_case to CamelCase
--- @param str string Snake case string
--- @return string CamelCase string
function APLMonitorAST:SnakeToCamel(str)
    if not str or type(str) ~= "string" then
        return ""
    end

    local parts = {}
    for part in str:gmatch("[^_]+") do
        tinsert(parts, part:sub(1, 1):upper() .. part:sub(2):lower())
    end
    return concat(parts, "")
end

--- Resolve spell/aura name from proto AST value node
--- @param valueNode table Proto AST value node
--- @return string displayName Display name with ID
function APLMonitorAST:ResolveName(valueNode)
    if not valueNode or valueNode.type ~= ASTCore.NodeType.VALUE then
        return "Unknown"
    end

    local valueType = ASTValue.GetValueType(valueNode)
    if not valueType then
        return "Unknown"
    end

    -- Get NAG handler name
    local funcName = self:GetHandlerNameFromValueType(valueType) or "Unknown"

    -- Extract first argument from proto value node
    local valueData = ASTValue.GetValueData(valueNode)
    if not valueData then
        return format("%s()", funcName)
    end

    -- Use schema-based extraction with FieldFormatConverter
    local SchemaAccessor = NAG:GetModule("SchemaAccessor")
    local FieldFormatConverter = ns.FieldFormatConverter
    local entityId = nil
    local extractedValue = nil

    if SchemaAccessor and FieldFormatConverter then
        local protoName = "APLValue" .. self:SnakeToCamel(valueType)
        local fields, fieldOrder = SchemaAccessor:GetFields(protoName)
        if fieldOrder and #fieldOrder > 0 then
            local firstField = fieldOrder[1]
            local firstArg = valueData[firstField]
            local fieldInfo = fields[firstField]

            if firstArg and fieldInfo then
                -- Use FieldFormatConverter to extract value (handles ActionID, UnitReference, etc.)
                extractedValue = FieldFormatConverter:ExtractValue(firstArg, fieldInfo)

                -- Check if it's a unit reference (string)
                if type(extractedValue) == "string" then
                    return format("%s(%s)", funcName, extractedValue)
                end

                -- Check if it's a numeric ID (spell/item)
                if type(extractedValue) == "number" then
                    entityId = extractedValue
                end
            end
        end
    end

    if not entityId or type(entityId) ~= "number" then
        return format("%s(...)", funcName)
    end

    -- Look up name
    local DataManager = NAG:GetModule("DataManager")
    if DataManager then
        local entity = DataManager:Get(entityId, DataManager.EntityTypes.SPELL)
            or DataManager:Get(entityId, DataManager.EntityTypes.ITEM)

        if entity and entity.name then
            return format("%s(%s: %d)", funcName, entity.name, entityId)
        end
    end

    return format("%s(#%d)", funcName, entityId)
end

--- Format handler result value
--- @param result any Handler result value
--- @param funcName string Handler function name
--- @return string Formatted value
function APLMonitorAST:FormatValue(result, funcName)
    if result == nil then
        return "|cFF888888nil|r"
    end

    -- Boolean results
    if type(result) == "boolean" then
        if result then
            return "|cFF00FF00true|r"
        else
            return "|cFFFF0000false|r"
        end
    end

    -- Numeric results
    if type(result) == "number" then
        -- Time-based handlers
        if funcName and (funcName:match("Time") or funcName:match("Remaining") or funcName:match("Duration")) then
            return format("|cFFAAFFFF%.1fs|r", result)
        end

        -- Stack handlers
        if funcName and (funcName:match("Stacks") or funcName:match("NumStacks") or funcName:match("Count")) then
            return format("|cFFAAFFFF%d|r", result)
        end

        -- Percentage handlers
        if funcName and funcName:match("Percent") then
            return format("|cFFAAFFFF%.1f%%|r", result)
        end

        -- Generic number
        return format("|cFFAAFFFF%.2f|r", result)
    end

    -- String results
    if type(result) == "string" then
        return format("|cFFAAFFFF%s|r", result)
    end

    -- Default
    return format("|cFF888888%s|r", tostring(result))
end

-- ~~~~~~~~~~ DETAILED VIEW RENDERING ~~~~~~~~~~

--- Update tree view with current snapshot
function APLMonitorAST:UpdateTreeView()
    local content = self.state.frame.contentArea.detailedContainer.treeContent

    -- Clear existing children AND regions (FontStrings)
    for _, child in ipairs({content:GetChildren()}) do
        child:Hide()
        child:SetParent(nil)
    end

    -- Also clear any orphaned font strings
    for _, region in ipairs({content:GetRegions()}) do
        if region.GetObjectType and region:GetObjectType() == "FontString" then
            region:Hide()
            region:SetText("")
            region:SetParent(nil)
        end
    end

    if not self.state.currentSnapshot then
        -- Create a frame container for the "no data" message
        local noDataFrame = CreateFrame("Frame", nil, content)
        noDataFrame:SetPoint("TOPLEFT", 10, -10)
        noDataFrame:SetSize(content:GetWidth() - 20, 100)

        local noData = noDataFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        noData:SetPoint("TOPLEFT", 0, 0)
        noData:SetText("|cFFFF6600No evaluation data available|r\n\nStart monitoring to capture rotation evaluations.")
        noData:SetJustifyH("LEFT")
        return
    end

    -- Render nodes as simple list for now
    local yOffset = -10
    local nodes = self.state.currentSnapshot.nodes or {}

    if #nodes == 0 then
        -- Create a frame container for the "no nodes" message
        local noNodesFrame = CreateFrame("Frame", nil, content)
        noNodesFrame:SetPoint("TOPLEFT", 10, yOffset)
        noNodesFrame:SetSize(content:GetWidth() - 20, 30)

        local noNodes = noNodesFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        noNodes:SetPoint("TOPLEFT", 0, 0)
        noNodes:SetText("|cFFFF6600No nodes evaluated this tick|r")
        return
    end

    for i, node in ipairs(nodes) do
        local nodeFrame = self:CreateNodeRow(content, node, yOffset)
        yOffset = yOffset - 25
    end

    -- Update content height
    content:SetHeight(math.abs(yOffset) + 20)
end

--- Create a node row in tree view
--- @param parent Frame Parent frame
--- @param node table Node data
--- @param yOffset number Y offset for positioning
--- @return table nodeFrame Created node frame
function APLMonitorAST:CreateNodeRow(parent, node, yOffset)
    local frame = CreateFrame("Button", nil, parent)
    frame:SetSize(parent:GetWidth(), 20)
    frame:SetPoint("TOPLEFT", 10, yOffset)

    -- Result indicator using WoW-appropriate textures
    local resultIcon
    if node.result == true then
        resultIcon = "|TInterface\\RaidFrame\\ReadyCheck-Ready:14:14|t"
    elseif node.result == false then
        resultIcon = "|TInterface\\RaidFrame\\ReadyCheck-NotReady:14:14|t"
    else
        resultIcon = "|TInterface\\RaidFrame\\ReadyCheck-Waiting:14:14|t"
    end

    -- Duration color coding
    local durationColor = "|cFFFFFFFF"
    if self.db.global.showPerformanceColors then
        if node.duration > 1.0 then
            durationColor = "|cFFFF0000" -- Red for >1ms
        elseif node.duration > 0.5 then
            durationColor = "|cFFFFAA00" -- Orange for >0.5ms
        else
            durationColor = "|cFF00FF00" -- Green for <=0.5ms
        end
    end

    -- Text
    frame.text = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.text:SetPoint("LEFT", 0, 0)
    frame.text:SetText(format(
        "%s %s [%s] %s%.3fms|r",
        resultIcon,
        node.nodeId or "unknown",
        node.nodeType or "?",
        durationColor,
        node.duration or 0
    ))
    frame.text:SetJustifyH("LEFT")

    -- Click to select
    frame:SetScript("OnClick", function()
        APLMonitorAST.state.selectedNodeId = node.nodeId
        APLMonitorAST:UpdateDetailsPanel()
    end)

    -- Highlight on hover
    frame:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")

    return frame
end

--- Update grid view (future implementation)
function APLMonitorAST:UpdateGridView()
    local container = self.state.frame.contentArea.gridContainer
    if not container then
        return
    end

    -- TODO: Implement grid view rendering
    self:Trace("UpdateGridView: Not yet implemented")
end

--- Update details panel with selected node info
function APLMonitorAST:UpdateDetailsPanel()
    local content = self.state.frame.contentArea.detailedContainer.detailsContent

    -- Clear existing children AND regions (FontStrings)
    for _, child in ipairs({content:GetChildren()}) do
        child:Hide()
        child:SetParent(nil)
    end

    -- Also clear any orphaned font strings
    for _, region in ipairs({content:GetRegions()}) do
        if region.GetObjectType and region:GetObjectType() == "FontString" then
            region:Hide()
            region:SetText("")
            region:SetParent(nil)
        end
    end

    local yOffset = -10

    -- Show snapshot context
    if self.state.currentSnapshot then
        -- Create container frame for header
        local headerFrame = CreateFrame("Frame", nil, content)
        headerFrame:SetPoint("TOPLEFT", 10, yOffset)
        headerFrame:SetSize(content:GetWidth() - 20, 25)

        local header = headerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        header:SetPoint("TOPLEFT", 0, 0)
        header:SetText(format("Tick #%d", self.state.currentSnapshot.tickId or 0))
        yOffset = yOffset - 25

        -- Context info
        local context = self.state.currentSnapshot.context or {}
        local contextText = format(
            "|cFFAAAAAAMode:|r %s\n" ..
            "|cFFAAAAAADuration:|r %.3fms\n" ..
            "|cFFAAAAAANodes:|r %d\n" ..
            "|cFFAAAAAAFirst True:|r %s\n\n" ..
            "|cFFAAAAAATarget:|r %s (%.1f%%)\n" ..
            "|cFFAAAAAAPlayer HP:|r %.1f%%\n" ..
            "|cFFAAAAAAPlayer Power:|r %d/%d\n" ..
            "|cFFAAAAAAIn Combat:|r %s",
            self.state.currentSnapshot.evaluationMode or "unknown",
            self.state.currentSnapshot.totalDuration or 0,
            self.state.currentSnapshot.nodeCount or 0,
            self.state.currentSnapshot.firstTrueAction or "none",
            context.targetName or "none",
            context.targetHealthPercent or 0,
            context.playerHealthPercent or 0,
            context.playerPower or 0,
            context.playerPowerMax or 0,
            context.inCombat and "Yes" or "No"
        )

        -- Create container frame for context info
        local contextFrame = CreateFrame("Frame", nil, content)
        contextFrame:SetPoint("TOPLEFT", 10, yOffset)
        contextFrame:SetSize(content:GetWidth() - 20, 200)

        local contextInfo = contextFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        contextInfo:SetPoint("TOPLEFT", 0, 0)
        contextInfo:SetText(contextText)
        contextInfo:SetJustifyH("LEFT")
        yOffset = yOffset - 200
    end

    -- Show selected node details
    if self.state.selectedNodeId and self.state.currentSnapshot then
        local nodes = self.state.currentSnapshot.nodes or {}
        local selectedNode
        for _, node in ipairs(nodes) do
            if node.nodeId == self.state.selectedNodeId then
                selectedNode = node
                break
            end
        end

        if selectedNode then
            -- Create container frame for node header
            local nodeHeaderFrame = CreateFrame("Frame", nil, content)
            nodeHeaderFrame:SetPoint("TOPLEFT", 10, yOffset)
            nodeHeaderFrame:SetSize(content:GetWidth() - 20, 25)

            local nodeHeader = nodeHeaderFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
            nodeHeader:SetPoint("TOPLEFT", 0, 0)
            nodeHeader:SetText("Selected Node")
            yOffset = yOffset - 25

            local nodeText = format(
                "|cFFAAAAAANode ID:|r %s\n" ..
                "|cFFAAAAAAType:|r %s\n" ..
                "|cFFAAAAAAResult:|r %s\n" ..
                "|cFFAAAAAADuration:|r %.3fms",
                selectedNode.nodeId or "unknown",
                selectedNode.nodeType or "unknown",
                tostring(selectedNode.result),
                selectedNode.duration or 0
            )

            -- Create container frame for node info
            local nodeInfoFrame = CreateFrame("Frame", nil, content)
            nodeInfoFrame:SetPoint("TOPLEFT", 10, yOffset)
            nodeInfoFrame:SetSize(content:GetWidth() - 20, 100)

            local nodeInfo = nodeInfoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
            nodeInfo:SetPoint("TOPLEFT", 0, 0)
            nodeInfo:SetText(nodeText)
            nodeInfo:SetJustifyH("LEFT")
            yOffset = yOffset - 100
        end
    end

    -- Update content height
    content:SetHeight(math.abs(yOffset) + 20)
end

--- Update status bar text
function APLMonitorAST:UpdateStatusBar()
    if not self.state.frame or not self.state.frame.statusBar then
        return
    end

    local SnapshotManager = NAG:GetModule("SnapshotManager")
    local stats = SnapshotManager:GetBufferStats()
    local state = SnapshotManager:GetState()

    -- Add refresh rate and pending update indicator
    local pendingIndicator = self.state.pendingUpdate and " |cFFFFAA00[UPDATE PENDING]|r" or ""

    local statusText = format(
        "Buffer: %d/%d (%.0f%%) | State: %s | Total: %d ticks | Refresh: %.1fs%s",
        stats.size,
        stats.capacity,
        stats.utilizationPercent,
        state,
        stats.totalSnapshots,
        self.db.global.uiRefreshRate,
        pendingIndicator
    )

    self.state.frame.statusBar.text:SetText(statusText)
end

--- Update button states based on current state
function APLMonitorAST:UpdateButtonStates()
    if not self.state.frame or not self.state.frame.controlPanel then
        return
    end

    local panel = self.state.frame.controlPanel
    local SnapshotManager = NAG:GetModule("SnapshotManager")

    -- Update pause button text
    if SnapshotManager:IsPaused() then
        panel.pauseBtn:SetText("Resume")
    else
        panel.pauseBtn:SetText("Pause")
    end

    -- Update start button text
    if self:IsMonitoring() then
        panel.startBtn:SetText("Stop")
    else
        panel.startBtn:SetText("Start")
    end
end

-- ~~~~~~~~~~ MESSAGE HANDLERS ~~~~~~~~~~

--- Handle tick complete message
function APLMonitorAST:APLMonitor_TickComplete(message, snapshot)
    self.state.totalTicks = self.state.totalTicks + 1

    -- Check if UI update is needed (throttled)
    self:ThrottledUpdateDisplay()
end

--- Handle snapshot added message
function APLMonitorAST:APLMonitor_SnapshotAdded(message, data)
    -- Check if UI update is needed (throttled)
    self:ThrottledUpdateDisplay()
end

--- Update display with configurable throttling
function APLMonitorAST:ThrottledUpdateDisplay()
    if not self.state.isShown then
        return
    end

    local now = GetTime()
    local timeSinceLastUpdate = now - (self.state.lastUIUpdate or 0)

    if timeSinceLastUpdate >= self.db.global.uiRefreshRate then
        self.state.lastUIUpdate = now
        self.state.pendingUpdate = false
        self:UpdateDisplay()
    else
        -- Mark that an update is pending
        self.state.pendingUpdate = true
        self:Trace("Skipped UI update (throttled, %.2fs since last)", timeSinceLastUpdate)
    end
end

--- Force immediate display update (ignores throttle)
function APLMonitorAST:ForceUpdateDisplay()
    self.state.lastUIUpdate = GetTime()
    self.state.pendingUpdate = false
    self:UpdateDisplay()
end

--- Handle state changed message
function APLMonitorAST:APLMonitor_StateChanged(message, data)
    self:Debug("State changed: %s -> %s", data.oldState, data.newState)

    -- Update display
    if self.state.isShown then
        self:UpdateDisplay()
    end
end

-- ~~~~~~~~~~ EVENT HANDLERS ~~~~~~~~~~

--- Handle combat start
function APLMonitorAST:OnCombatStart()
    if self.db.global.autoStartInCombat and not self:IsMonitoring() then
        self:StartMonitoring()
    end
end

--- Handle combat end
function APLMonitorAST:OnCombatEnd()
    -- Keep monitoring after combat if configured
end

-- ~~~~~~~~~~ SLASH COMMAND HANDLERS ~~~~~~~~~~

--- Handle show command
function APLMonitorAST:HandleShowCommand()
    self:ToggleFrame()
end

--- Handle help command
function APLMonitorAST:HandleHelpCommand()
    NAG:Print("=== APL Monitor Help ===")
    NAG:Print("/aplmonitor - Toggle monitor window")
    NAG:Print("/aplmonitorhelp - Show this help")
    NAG:Print("")
    NAG:Print("Controls:")
    NAG:Print("  Start/Stop - Begin/end monitoring")
    NAG:Print("  Pause/Resume - Freeze/unfreeze evaluation tracking")
    NAG:Print("  < Step / Step > - Navigate through history")
    NAG:Print("  Mode - Switch between compiled/tree evaluation")
    NAG:Print("  Clear - Clear snapshot buffer")
end

-- ~~~~~~~~~~ OPTIONS ~~~~~~~~~~

function APLMonitorAST:GetOptions()
    return {
        type = "group",
        name = L["APL Monitor (AST-Native)"] or "APL Monitor (AST-Native)",
        desc = L["Real-time rotation evaluation debugger"] or "Real-time rotation evaluation debugger",
        order = 150,
        args = {
            header = {
                type = "header",
                name = L["APL Monitor Settings"] or "APL Monitor Settings",
                order = 1
            },
            enabled = {
                type = "toggle",
                name = L["enabled"] or "Enabled",
                desc = L["enabledDesc"] or "Enable or disable this module/feature",
                get = function() return self.db.global.enabled end,
                set = function(_, value)
                    self.db.global.enabled = value
                    if value then
                        self:Enable()
                    else
                        self:Disable()
                    end
                end,
                order = 2
            },
            autoStart = {
                type = "toggle",
                name = L["autoStart"] or "Auto-start in combat",
                desc = L["autoStartDesc"] or "Automatically start monitoring when entering combat",
                get = function() return self.db.global.autoStartInCombat end,
                set = function(_, value) self.db.global.autoStartInCombat = value end,
                order = 3
            },
            showWindow = {
                type = "execute",
                name = L["showWindow"] or "Show Monitor Window",
                desc = L["showWindowDesc"] or "Open the APL Monitor window",
                func = function() self:ShowFrame() end,
                order = 4
            }
        }
    }
end

