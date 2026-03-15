--- @module "DebugFrameUtil"
--- Provides a reusable AceGUI-based debug frame for NAG modules.
---
--- This utility provides a unified debug frame system that supports:
--- - Standard debug sections with automatic data updates
--- - Custom controls (multiline, button, toggle, input, dropdown, slider)
--- - Custom section type renderers for specialized content
--- - Timer controls with auto-refresh capabilities
--- - Position saving and frame management
---
--- Specialized debug frames have been migrated to their respective modules
--- using the enhanced base system for better maintainability.
---
--- License: CC BY-NC 4.0 (https://creativecommons.org/licenses/by-nc/4.0/legalcode)
--- Authors: @Rakizi: farendil2020@gmail.com, @Fonsas
--- Discord: https://discord.gg/ebonhold

-- ============================ LOCALIZE ============================
local _, ns = ...
local NAG = LibStub("AceAddon-3.0"):GetAddon("NAG")

local AceGUI = ns.AceGUI

-- ============================ CONTENT ============================
--- DebugFrameUtil: Provides a generic debug frame for modules
local DebugFrameUtil = {}

-- Internal state
DebugFrameUtil.activeFrames = DebugFrameUtil.activeFrames or {}
DebugFrameUtil.activeTimers = DebugFrameUtil.activeTimers or {}

-- ============================ CUSTOM CONTROL CREATION ============================

--- Create a custom control widget based on configuration
--- @param control table The control configuration
--- @param module table The module requesting the control
--- @param frame table The debug frame
--- @return table|nil The created widget or nil if failed
function DebugFrameUtil:CreateCustomControl(control, module, frame)
    if not control or not control.type then
        return nil
    end

    if control.type == "multiline" then
        local input = AceGUI:Create("MultiLineEditBox")
        input:SetLabel(control.label or "")
        input:SetWidth(control.width or 400)
        input:SetHeight(control.height or 60)

        -- Set the callback first to avoid triggering onChange during init
        if control.onChange then
            input:SetCallback("OnTextChanged", function(widget, event, text)
                -- AceGUI OnTextChanged provides (widget, event, text) parameters
                -- We want to pass just the text value to the onChange callback
                if control.onChange then
                    control.onChange(text)
                end
            end)
        end

        -- Set the text last to avoid triggering the callback during initialization
        input:SetText(control.defaultText or "")

        return input
    elseif control.type == "button" then
        local button = AceGUI:Create("Button")
        button:SetText(control.text or "Button")
        button:SetWidth(control.width or 100)
        if control.onClick then
            button:SetCallback("OnClick", control.onClick)
        end
        return button
    elseif control.type == "toggle" then
        local toggle = AceGUI:Create("CheckBox")
        toggle:SetLabel(control.label or "")
        local currentValue = control.getValue and control.getValue() or false
        toggle:SetValue(currentValue)
        if control.setValue then
            toggle:SetCallback("OnValueChanged", control.setValue)
        end
        return toggle
    elseif control.type == "input" then
        local input = AceGUI:Create("EditBox")
        input:SetLabel(control.label or "")
        input:SetWidth(control.width or 200)

        -- Set the callback first to avoid triggering onChange during init
        if control.onChange then
            input:SetCallback("OnTextChanged", function(widget, event, text)
                -- AceGUI OnTextChanged provides (widget, event, text) parameters
                -- We want to pass just the text value to the onChange callback
                if control.onChange then
                    control.onChange(text)
                end
            end)
        end

        -- Set the text last to avoid triggering the callback during initialization
        input:SetText(control.defaultText or "")

        return input
    elseif control.type == "dropdown" then
        local dropdown = AceGUI:Create("Dropdown")
        dropdown:SetLabel(control.label or "")
        if control.values then
            dropdown:SetList(control.values)
        end
        if control.getValue then
            dropdown:SetValue(control.getValue() or 1)
        end
        if control.setValue then
            dropdown:SetCallback("OnValueChanged", control.setValue)
        end
        dropdown:SetWidth(control.width or 150)
        return dropdown
    elseif control.type == "slider" then
        local slider = AceGUI:Create("Slider")
        slider:SetLabel(control.label or "")
        if control.min and control.max and control.step then
            slider:SetSliderValues(control.min, control.max, control.step)
        end
        if control.getValue then
            slider:SetValue(control.getValue() or control.min or 0)
        end
        if control.setValue then
            slider:SetCallback("OnValueChanged", control.setValue)
        end
        slider:SetWidth(control.width or 200)
        return slider
    end

    return nil
end

-- ============================ TIMER UTILITY FUNCTIONS ============================

--- Start the debug timer for a specific frame
--- @param self table The DebugFrameUtil instance
--- @param key string The frame key
--- @param updateFunction function The function to call on timer
function DebugFrameUtil:StartDebugTimer(key, updateFunction)
    if self.activeTimers[key] then
        ns.TimerManager:CancelTimer(self.activeTimers[key])
    end

    local frameData = self.activeFrames[key]
    if frameData and frameData.autoRefresh and frameData.timerActive then
        self.activeTimers[key] = ns.TimerManager:ScheduleRepeatingTimer(updateFunction, frameData.interval)
    end
end

--- Stop the debug timer for a specific frame
--- @param self table The DebugFrameUtil instance
--- @param key string The frame key
--- @param frame table The frame to update status on
function DebugFrameUtil:StopDebugTimer(key, frame)
    if self.activeTimers[key] then
        ns.TimerManager:CancelTimer(self.activeTimers[key])
        self.activeTimers[key] = nil
    end

    local frameData = self.activeFrames[key]
    if frameData then
        frameData.timerActive = false
    end

    -- Update status label if available
    if frame and frame.timerStatusLabel then
        frame.timerStatusLabel:SetText("Timer: Stopped")
    end
end

--- Start the debug timer manually for a specific frame
--- @param self table The DebugFrameUtil instance
--- @param key string The frame key
--- @param frame table The frame to update status on
function DebugFrameUtil:StartDebugTimerManual(key, frame)
    local frameData = self.activeFrames[key]
    if frameData then
        frameData.timerActive = true
        self:StartDebugTimer(key, frame.UpdateDebugFrame)

        -- Update status label if available
        if frame and frame.timerStatusLabel then
            frame.timerStatusLabel:SetText("Timer: Active")
        end
    end
end

--- Show a debug frame for a module
-- @param module table The module requesting the debug frame
-- @param config table {
--   title,
--   sections = { {header, dataFn, type, customType, data}, ... },
--   refreshInterval,
--   controls = { function(module, frame) -> widget, ... },
--   customControls = { {type, label, text, width, height, getValue, setValue, onChange, onClick}, ... },
--   customSectionTypes = { [type] = function(section, scroll, module) -> widget, ... },
--   summaryFn,
--   position,
--   autoRefresh = true,
--   showTimerControls = true
-- }
function DebugFrameUtil:ShowDebugFrame(module, config)
    local TimerManager = ns.TimerManager

    assert(module, "Module required")
    assert(config and config.sections, "Config with sections required")
    local key = tostring(module)
    if self.activeFrames[key] and self.activeFrames[key].frame then
        self.activeFrames[key].frame:Show()
        return
    end
    local frame = AceGUI:Create("Frame")
    frame:SetTitle(config.title or (module.GetName and module:GetName() .. " Debug" or "Debug Frame"))
    frame:SetWidth(config.width or 600)
    frame:SetHeight(config.height or 500)
    frame:EnableResize(true)
    frame:SetLayout("Fill")

    -- Set initial position if provided
    if config.position then
        frame.frame:ClearAllPoints()
        frame.frame:SetPoint(
            config.position.point or "CENTER",
            UIParent,
            config.position.relativePoint or "CENTER",
            config.position.x or 0,
            config.position.y or 0
        )
    end

    -- Make frame movable and save position if position saving is enabled
    -- AceGUI frames are already SetMovable(true) by default, but we need to set up drag handlers
    -- Use direct SetScript (standard pattern in codebase) - no hooks needed
    if config.savePosition and module.SetSetting then
        frame.frame:RegisterForDrag("LeftButton")

        -- Set drag handlers directly (standard pattern used throughout codebase)
        frame.frame:SetScript("OnDragStart", function()
            frame.frame:StartMoving()
        end)

        frame.frame:SetScript("OnDragStop", function()
            frame.frame:StopMovingOrSizing()
            -- Save position
            local point, _, relativePoint, x, y = frame.frame:GetPoint()
            module:SetSetting("char", "position.point", point)
            module:SetSetting("char", "position.relativePoint", relativePoint)
            module:SetSetting("char", "position.x", x)
            module:SetSetting("char", "position.y", y)
        end)
    end

    frame:SetCallback("OnClose", function(widget)
        if self.activeTimers[key] then
            TimerManager:CancelTimer(self.activeTimers[key])
            self.activeTimers[key] = nil
        end

        -- Clear drag scripts on close (cleanup)
        if frame.frame then
            frame.frame:SetScript("OnDragStart", nil)
            frame.frame:SetScript("OnDragStop", nil)
        end

        -- Clear the debugFrame reference from the module
        if module.debugFrame == frame then
            module.debugFrame = nil
        end
        self.activeFrames[key] = nil
        AceGUI:Release(widget)
    end)

    -- Main vertical group
    local mainGroup = AceGUI:Create("SimpleGroup")
    mainGroup:SetLayout("List")
    mainGroup:SetFullWidth(true)
    mainGroup:SetFullHeight(true)

    -- Top group for controls (refresh interval slider + custom controls)
    local controlGroup = AceGUI:Create("SimpleGroup")
    controlGroup:SetLayout("Flow")
    controlGroup:SetFullWidth(true)

    -- Auto-refresh configuration
    local autoRefresh = config.autoRefresh ~= false             -- Default to true
    local showTimerControls = config.showTimerControls ~= false -- Default to true
    local isDynamic = config.refreshInterval ~= nil and autoRefresh
    local interval = config.refreshInterval or 1.0
    local minInterval, maxInterval = 0.1, 1.0

    local intervalSlider
    local autoRefreshToggle
    local timerStatusLabel

    if showTimerControls then
        -- Auto-refresh toggle
        autoRefreshToggle = AceGUI:Create("CheckBox")
        autoRefreshToggle:SetLabel("Auto-refresh")
        autoRefreshToggle:SetValue(autoRefresh)
        autoRefreshToggle:SetWidth(120)
        controlGroup:AddChild(autoRefreshToggle)

        -- Timer status indicator
        timerStatusLabel = AceGUI:Create("Label")
        timerStatusLabel:SetText(autoRefresh and "Timer: Active" or "Timer: Stopped")
        timerStatusLabel:SetFontObject(GameFontNormalSmall)
        timerStatusLabel:SetWidth(120)
        controlGroup:AddChild(timerStatusLabel)

        -- Store references for later access
        frame.autoRefreshToggle = autoRefreshToggle
        frame.timerStatusLabel = timerStatusLabel
    end

    if isDynamic then
        intervalSlider = AceGUI:Create("Slider")
        intervalSlider:SetLabel("Update Interval (sec)")
        intervalSlider:SetSliderValues(minInterval, maxInterval, 0.1)
        intervalSlider:SetValue(interval)
        intervalSlider:SetWidth(200)
        controlGroup:AddChild(intervalSlider)
    end
    -- Add custom controls if provided (legacy function-based approach)
    if config.controls then
        for _, controlFn in ipairs(config.controls) do
            local widget = controlFn(module, frame)
            if widget then controlGroup:AddChild(widget) end
        end
    end

    -- Add enhanced custom controls if provided (new declarative approach)
    if config.customControls then
        frame.customWidgets = {} -- Store references to custom widgets
        for i, control in ipairs(config.customControls) do
            local widget = self:CreateCustomControl(control, module, frame)
            if widget then
                controlGroup:AddChild(widget)
                -- Store reference to the widget for later access
                frame.customWidgets[i] = {
                    widget = widget,
                    control = control,
                    type = control.type
                }
                -- If it's a multiline input, store it with a special key for easy access
                if control.type == "multiline" then
                    frame.multilineInput = widget
                elseif control.type == "input" then
                    frame.singleInput = widget
                end
            end
        end
    end
    -- Add manual refresh button (always present)
    local refreshBtn = AceGUI:Create("Button")
    refreshBtn:SetText("Refresh")
    refreshBtn:SetWidth(80)
    refreshBtn:SetCallback("OnClick", function()
        if frame.UpdateDebugFrame then frame:UpdateDebugFrame() end
    end)
    controlGroup:AddChild(refreshBtn)

    -- Add timer control buttons if timer controls are shown
    if showTimerControls then
        local startTimerBtn = AceGUI:Create("Button")
        startTimerBtn:SetText("Start Timer")
        startTimerBtn:SetWidth(100)
        startTimerBtn:SetCallback("OnClick", function()
            self:StartDebugTimerManual(key, frame)
        end)
        controlGroup:AddChild(startTimerBtn)

        local stopTimerBtn = AceGUI:Create("Button")
        stopTimerBtn:SetText("Stop Timer")
        stopTimerBtn:SetWidth(100)
        stopTimerBtn:SetCallback("OnClick", function()
            self:StopDebugTimer(key, frame)
        end)
        controlGroup:AddChild(stopTimerBtn)

        -- Store references for later access
        frame.startTimerBtn = startTimerBtn
        frame.stopTimerBtn = stopTimerBtn
    end

    mainGroup:AddChild(controlGroup)

    -- Scrollable debug output
    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("List")
    scroll:SetFullWidth(true)
    scroll:SetFullHeight(true)
    mainGroup:AddChild(scroll)

    -- Optional summary/footer label
    local summaryLabel
    if config.summaryFn then
        summaryLabel = AceGUI:Create("Label")
        summaryLabel:SetFullWidth(true)
        summaryLabel:SetFontObject(GameFontHighlightSmall)
        mainGroup:AddChild(summaryLabel)
    end

    frame:AddChild(mainGroup)

    -- Store frame and scroll for later updates
    self.activeFrames[key] = {
        frame = frame,
        scroll = scroll,
        config = config,
        interval = interval,
        summaryLabel = summaryLabel,
        autoRefresh = autoRefresh,
        timerActive = autoRefresh,
        widgetCache = {} -- PERFORMANCE: Cache for reusable widgets to prevent constant recreation
    }

    -- Set the debugFrame reference on the module so it can access the frame
    module.debugFrame = frame

    -- Add utility methods to the frame for accessing custom widgets
    frame.GetInputFieldText = function(self)
        if self.multilineInput then
            return self.multilineInput:GetText()
        elseif self.singleInput then
            return self.singleInput:GetText()
        end
        return nil
    end

    frame.GetCustomWidget = function(self, index)
        if self.customWidgets and self.customWidgets[index] then
            return self.customWidgets[index].widget
        end
        return nil
    end

    frame.GetCustomWidgetByType = function(self, widgetType)
        if self.customWidgets then
            for _, widgetData in pairs(self.customWidgets) do
                if widgetData.type == widgetType then
                    return widgetData.widget
                end
            end
        end
        return nil
    end

    frame.SetInputFieldText = function(self, text)
        if self.multilineInput then
            self.multilineInput:SetText(text)
        elseif self.singleInput then
            self.singleInput:SetText(text)
        end
    end

    -- TableSection rendering helper
    local function renderTableSection(section)
        -- section: {header, columns, rowsFn, sortField, filterFn, controls}
        local columns = section.columns or {}
        local rows = section.rowsFn and section.rowsFn(module) or {}
        local sortField = section.sortField
        local filterFn = section.filterFn
        if filterFn then
            local filtered = {}
            for _, row in ipairs(rows) do
                if filterFn(row) then tinsert(filtered, row) end
            end
            rows = filtered
        end
        if sortField and columns[sortField] and #rows > 1 then
            table.sort(rows, function(a, b)
                return a[sortField] > b[sortField]
            end)
        end
        -- Header
        local header = AceGUI:Create("Heading")
        header:SetText(section.header)
        header:SetFullWidth(true)
        scroll:AddChild(header)
        -- Table header row
        local headerRow = AceGUI:Create("SimpleGroup")
        headerRow:SetLayout("Flow")
        headerRow:SetFullWidth(true)
        for colKey, col in ipairs(columns) do
            local colLabel = AceGUI:Create("Label")
            colLabel:SetText(col.label or col.key or ("Col" .. colKey))
            colLabel:SetWidth(col.width or 100)
            colLabel:SetFontObject(GameFontHighlightSmall)
            headerRow:AddChild(colLabel)
        end
        scroll:AddChild(headerRow)
        -- Table rows
        for _, row in ipairs(rows) do
            local rowGroup = AceGUI:Create("SimpleGroup")
            rowGroup:SetLayout("Flow")
            rowGroup:SetFullWidth(true)
            for colKey, col in ipairs(columns) do
                local val = row[col.key] or ""
                local cell = AceGUI:Create("Label")
                cell:SetText(val)
                cell:SetWidth(col.width or 100)
                rowGroup:AddChild(cell)
            end
            scroll:AddChild(rowGroup)
        end
    end

    -- Spell diagnostic section rendering helper
    local function renderSpellDiagnosticSection(section)
        -- section: {header, spellIds, diagnosticFn}
        if section.header then
            local header = AceGUI:Create("Heading")
            header:SetText(section.header)
            header:SetFullWidth(true)
            scroll:AddChild(header)
        end

        if section.spellIds and section.diagnosticFn then
            local diagnosticData = section.diagnosticFn(module, section.spellIds)

            -- Create diagnostic table
            local diagnosticGroup = AceGUI:Create("SimpleGroup")
            diagnosticGroup:SetLayout("List")
            diagnosticGroup:SetFullWidth(true)

            -- Add diagnostic info for each spell
            for spellId, info in pairs(diagnosticData) do
                local spellGroup = AceGUI:Create("SimpleGroup")
                spellGroup:SetLayout("Flow")
                spellGroup:SetFullWidth(true)

                -- Spell ID and name
                local spellLabel = AceGUI:Create("Label")
                spellLabel:SetText(string.format("Spell %d: %s", spellId, info.name or "Unknown"))
                spellLabel:SetWidth(200)
                spellLabel:SetFontObject(GameFontHighlight)
                spellGroup:AddChild(spellLabel)

                -- Spell status
                local statusLabel = AceGUI:Create("Label")
                statusLabel:SetText(string.format("Status: %s", info.status or "Unknown"))
                statusLabel:SetWidth(150)
                statusLabel:SetFontObject(GameFontNormal)
                spellGroup:AddChild(statusLabel)

                -- Additional info
                if info.additionalInfo then
                    local infoLabel = AceGUI:Create("Label")
                    infoLabel:SetText(info.additionalInfo)
                    infoLabel:SetWidth(300)
                    infoLabel:SetFontObject(GameFontNormalSmall)
                    spellGroup:AddChild(infoLabel)
                end

                diagnosticGroup:AddChild(spellGroup)
            end

            scroll:AddChild(diagnosticGroup)
        end
    end

    -- Custom section rendering helper for complex UI requirements
    local function renderCustomSection(section)
        -- section: {header, customFn, controls}
        if section.header then
            local header = AceGUI:Create("Heading")
            header:SetText(section.header)
            header:SetFullWidth(true)
            scroll:AddChild(header)
        end

        if section.customFn then
            local customWidget = section.customFn(module, scroll)

            if customWidget then
                scroll:AddChild(customWidget)
            end
        end
    end

    -- ============================ WIDGET CACHING HELPERS ============================

    --- Check if sections structure has changed (needs full rebuild)
    --- @param newSections table The new sections array
    --- @param oldSections table|nil The previous sections array
    --- @return boolean True if structure changed, false otherwise
    local function sectionsChanged(newSections, oldSections)
        if not oldSections then return true end
        if #newSections ~= #oldSections then return true end

        for i, section in ipairs(newSections) do
            local oldSection = oldSections[i]
            if not oldSection then return true end
            if section.header ~= oldSection.header then return true end
            if section.type ~= oldSection.type then return true end
            if section.customType ~= oldSection.customType then return true end
        end

        return false
    end

    --- Render or update a cached default section (text-only sections)
    --- @param section table The section configuration
    --- @param sectionIndex number The section index
    --- @param widgetCache table The widget cache
    --- @param scroll table The scroll frame
    --- @param module table The module
    local function renderCachedSection(section, sectionIndex, widgetCache, scroll, module)
        local cacheKey = "section_" .. sectionIndex
        local cached = widgetCache[cacheKey]

        if not cached then
            -- Create widgets for this section (first time)
            cached = {
                header = AceGUI:Create("Heading"),
                spacer = AceGUI:Create("Label"),
                labels = {},
                spacers = {}
            }
            cached.header:SetText(section.header)
            cached.header:SetFullWidth(true)
            scroll:AddChild(cached.header)

            cached.spacer:SetText("")
            cached.spacer:SetFullWidth(true)
            cached.spacer:SetHeight(8)
            scroll:AddChild(cached.spacer)

            widgetCache[cacheKey] = cached
        else
            -- Update existing header
            cached.header:SetText(section.header)
        end

        -- Get current data
        local lines = section.dataFn and section.dataFn(module) or {}

        -- Adjust label count to match data
        while #cached.labels < #lines do
            local label = AceGUI:Create("Label")
            label:SetFullWidth(true)
            scroll:AddChild(label)
            table.insert(cached.labels, label)

            local spacer = AceGUI:Create("Label")
            spacer:SetText("")
            spacer:SetFullWidth(true)
            spacer:SetHeight(4)
            scroll:AddChild(spacer)
            table.insert(cached.spacers, spacer)
        end

        -- Update label text and show used labels
        for i, line in ipairs(lines) do
            cached.labels[i]:SetText(line)
            cached.labels[i].frame:Show()
            if cached.spacers[i] then
                cached.spacers[i].frame:Show()
            end
        end

        -- Hide unused labels and spacers
        for i = #lines + 1, #cached.labels do
            cached.labels[i].frame:Hide()
            if cached.spacers[i] then
                cached.spacers[i].frame:Hide()
            end
        end
    end

    -- Update function
    local function updateDebugFrame()
        local frameData = self.activeFrames[key]
        local widgetCache = frameData.widgetCache
        local sections = type(config.sections) == "function" and config.sections() or config.sections

        -- Check if we have any complex sections that need full recreation
        local hasComplexSections = false
        for _, section in ipairs(sections) do
            if section.type == "table" or section.type == "custom" or section.type == "spellDiagnostic" or
               (section.customType and config.customSectionTypes) then
                hasComplexSections = true
                break
            end
        end

        -- PERFORMANCE: Only destroy widgets if section structure changed OR if we have complex sections
        local needsFullRebuild = sectionsChanged(sections, widgetCache.lastSections) or hasComplexSections
        if needsFullRebuild then
            scroll:ReleaseChildren()
            if not hasComplexSections then
                -- Only wipe cache if structure actually changed, not just because we have complex sections
                wipe(widgetCache)
            end
        end

        for i, section in ipairs(sections) do
            if section.type == "table" then
                -- Complex section: always recreate (has dynamic structure)
                renderTableSection(section)
            elseif section.customType and config.customSectionTypes and config.customSectionTypes[section.customType] then
                -- Complex section: always recreate (custom renderer)
                local customRenderer = config.customSectionTypes[section.customType]
                if customRenderer then
                    local header = AceGUI:Create("Heading")
                    header:SetText(section.header or "Custom Section")
                    header:SetFullWidth(true)
                    scroll:AddChild(header)

                    -- Get the data for this section (support both static data and dataFn)
                    local sectionData = section.dataFn and section.dataFn(module) or section.data

                    -- Call the custom renderer - it will add widgets directly to the scroll frame
                    customRenderer(section, scroll, module)
                end
            elseif section.type == "custom" then
                -- Complex section: always recreate (has dynamic structure)
                renderCustomSection(section)
            elseif section.type == "spellDiagnostic" then
                -- Complex section: always recreate (has dynamic structure)
                renderSpellDiagnosticSection(section)
            else
                -- PERFORMANCE: Default section rendering with widget caching
                renderCachedSection(section, i, widgetCache, scroll, module)
            end
        end

        -- Store sections for next comparison
        widgetCache.lastSections = sections

        -- Update summary label if present
        if config.summaryFn and summaryLabel then
            summaryLabel:SetText(config.summaryFn(module))
        end
    end
    frame.UpdateDebugFrame = updateDebugFrame

    -- Timer utility functions are now available at module level
    -- No need to define local versions

    -- Add timer control callbacks if controls are shown
    if showTimerControls and autoRefreshToggle then
        autoRefreshToggle:SetCallback("OnValueChanged", function(widget, event, value)
            local frameData = self.activeFrames[key]
            if frameData then
                frameData.autoRefresh = value
                if value then
                    self:StartDebugTimerManual(key, frame)
                else
                    self:StopDebugTimer(key, frame)
                end
            end
        end)
    end

    -- Slider callback to change refresh interval (only if dynamic)
    if isDynamic and intervalSlider then
        intervalSlider:SetCallback("OnValueChanged", function(widget, event, value)
            self.activeFrames[key].interval = value
            self:StartDebugTimer(key, updateDebugFrame)
        end)
    end

    -- Initial update and timer start (dynamic or static)
    updateDebugFrame()
    if isDynamic then
        self:StartDebugTimer(key, updateDebugFrame)
    end

    frame:Show()
end

-- Expose utility globally
ns.DebugFrameUtil = DebugFrameUtil

--[[
USAGE EXAMPLES AND MIGRATION GUIDE:

-- ============================ ENHANCED DEBUG FRAME SYSTEM ============================
-- This system provides a unified approach to debug frame creation with:
-- 1. Custom Controls: Declarative control creation
-- 2. Custom Section Types: Specialized content rendering
-- 3. Timer Management: Centralized timer control
-- 4. Position Saving: Automatic position persistence

-- ============================ BASIC USAGE PATTERN ============================
function MyModule:ShowDebugFrame()
    ns.DebugFrameUtil:ShowDebugFrame(self, {
        title = "My Module Debug",
        width = 800,
        height = 600,
        refreshInterval = 1.0,
        autoRefresh = true,
        showTimerControls = true,

        -- Custom controls for module-specific functionality
        customControls = self:GetDebugControls(),

        -- Custom section type renderers
        customSectionTypes = self:GetDebugSectionTypes(),

        -- Debug sections
        sections = self:GetDebugSections()
    })
end

-- ============================ CUSTOM CONTROLS ============================
function MyModule:GetDebugControls()
    return {
        {
            type = "multiline",
            label = "Input Field",
            defaultText = "Enter data here...",
            width = 500,
            height = 80,
            onChange = function(value) self:HandleInputChange(value) end
        },
        {
            type = "button",
            text = "Process Data",
            width = 120,
            onClick = function() self:ProcessData() end
        },
        {
            type = "toggle",
            label = "Auto-process",
            getValue = function() return self.autoProcess end,
            setValue = function(value) self.autoProcess = value end
        },
        {
            type = "dropdown",
            label = "Mode",
            values = {"Normal", "Debug", "Verbose"},
            getValue = function() return self.currentMode or 1 end,
            setValue = function(value) self.currentMode = value end,
            width = 150
        },
        {
            type = "slider",
            label = "Threshold",
            min = 0,
            max = 100,
            step = 5,
            getValue = function() return self.threshold or 50 end,
            setValue = function(value) self.threshold = value end,
            width = 200
        }
    }
end

-- ============================ CUSTOM SECTION TYPES ============================
function MyModule:GetDebugSectionTypes()
    return {
        ["data_table"] = function(section, scroll, module)
            return module:RenderDataTable(section.data, scroll)
        end,
        ["tree_view"] = function(section, scroll, module)
            return module:RenderTreeView(section.data, scroll)
        end,
        ["chart"] = function(section, scroll, module)
            return module:RenderChart(section.data, scroll)
        end
    }
end

-- ============================ DEBUG SECTIONS ============================
function MyModule:GetDebugSections()
    return {
        {
            header = "Module Status",
            dataFn = function(self)
                return {
                    "Status: " .. (self.enabled and "Enabled" or "Disabled"),
                    "Version: " .. self.version,
                    "Last Update: " .. self.lastUpdate
                }
            end
        },
        {
            header = "Data Table",
            type = "custom",
            customType = "data_table",
            data = self:GetTableData()
        },
        {
            header = "Tree Structure",
            type = "custom",
            customType = "tree_view",
            data = self:GetTreeData()
        },
        {
            header = "Performance Chart",
            type = "custom",
            customType = "chart",
            data = self:GetChartData()
        }
    }
end

-- ============================ CUSTOM RENDERER IMPLEMENTATIONS ============================
function MyModule:RenderDataTable(data, scroll)
    if not data or #data == 0 then
        local noDataLabel = ns.AceGUI:Create("Label")
        noDataLabel:SetText("No data available")
        noDataLabel:SetFullWidth(true)
        scroll:AddChild(noDataLabel)
        return noDataLabel
    end

    -- Create table structure
    local tableGroup = ns.AceGUI:Create("SimpleGroup")
    tableGroup:SetLayout("List")
    tableGroup:SetFullWidth(true)

    -- Table header
    local headerRow = ns.AceGUI:Create("SimpleGroup")
    headerRow:SetLayout("Flow")
    headerRow:SetFullWidth(true)

    for _, column in ipairs(data.columns or {}) do
        local colHeader = ns.AceGUI:Create("Label")
        colHeader:SetText(column.label)
        colHeader:SetWidth(column.width or 150)
        colHeader:SetFontObject(GameFontHighlightSmall)
        headerRow:AddChild(colHeader)
    end

    tableGroup:AddChild(headerRow)

    -- Table rows
    for _, row in ipairs(data.rows or {}) do
        local rowGroup = ns.AceGUI:Create("SimpleGroup")
        rowGroup:SetLayout("Flow")
        rowGroup:SetFullWidth(true)

        for i, value in ipairs(row) do
            local cell = ns.AceGUI:Create("Label")
            cell:SetText(tostring(value))
            cell:SetWidth(data.columns and data.columns[i] and data.columns[i].width or 150)
            rowGroup:AddChild(cell)
        end

        tableGroup:AddChild(rowGroup)
    end

    scroll:AddChild(tableGroup)
    return tableGroup
end

function MyModule:RenderTreeView(data, scroll)
    if not data then
        local noDataLabel = ns.AceGUI:Create("Label")
        noDataLabel:SetText("No tree data available")
        noDataLabel:SetFullWidth(true)
        scroll:AddChild(noDataLabel)
        return noDataLabel
    end

    local function renderNode(node, level)
        if not node then return end

        local indent = string.rep("  ", level)
        local nodeLabel = ns.AceGUI:Create("Label")
        nodeLabel:SetText(indent .. "• " .. (node.text or "Unknown"))
        nodeLabel:SetFullWidth(true)
        nodeLabel:SetFontObject(GameFontNormal)
        scroll:AddChild(nodeLabel)

        -- Render children recursively
        if node.children then
            for _, child in ipairs(node.children) do
                renderNode(child, level + 1)
            end
        end
    end

    if data.children then
        for _, child in ipairs(data.children) do
            renderNode(child, 0)
        end
    end

    return nil -- No single widget to return
end

function MyModule:RenderChart(data, scroll)
    if not data then
        local noDataLabel = ns.AceGUI:Create("Label")
        noDataLabel:SetText("No chart data available")
        noDataLabel:SetFullWidth(true)
        scroll:AddChild(noDataLabel)
        return noDataLabel
    end

    -- Simple chart implementation
    local chartGroup = ns.AceGUI:Create("SimpleGroup")
    chartGroup:SetLayout("List")
    chartGroup:SetFullWidth(true)

    local chartHeader = ns.AceGUI:Create("Label")
    chartHeader:SetText("Chart: " .. (data.title or "Data Visualization"))
    chartHeader:SetFullWidth(true)
    chartHeader:SetFontObject(GameFontHighlight)
    chartGroup:AddChild(chartHeader)

    -- Render chart bars or data points
    if data.values then
        for i, value in ipairs(data.values) do
            local barGroup = ns.AceGUI:Create("SimpleGroup")
            barGroup:SetLayout("Flow")
            barGroup:SetFullWidth(true)

            local label = ns.AceGUI:Create("Label")
            label:SetText(data.labels and data.labels[i] or ("Value " .. i))
            label:SetWidth(100)
            barGroup:AddChild(label)

            local valueLabel = ns.AceGUI:Create("Label")
            valueLabel:SetText(tostring(value))
            valueLabel:SetWidth(100)
            barGroup:AddChild(valueLabel)

            chartGroup:AddChild(barGroup)
        end
    end

    scroll:AddChild(chartGroup)
    return chartGroup
end

-- ============================ MIGRATION FROM SPECIALIZED FRAMES ============================
--
-- BEFORE (Specialized Frame):
-- ns.DebugFrameUtil:ShowASTDebugFrame(self)
-- ns.DebugFrameUtil:ShowTrinketTrackingDebugFrame(self)
--
-- AFTER (Enhanced Base System):
-- ns.DebugFrameUtil:ShowDebugFrame(self, {
--     title = "Custom Title",
--     customControls = self:GetDebugControls(),
--     customSectionTypes = self:GetDebugSectionTypes(),
--     sections = self:GetDebugSections()
-- })
--
-- BENEFITS:
-- - No more duplicate frame creation code
-- - Consistent UI behavior across all debug frames
-- - Easier to maintain and extend
-- - Full backward compatibility maintained
-- - Reusable custom controls and section types
--
-- SUPPORTED CONTROL TYPES:
-- - "multiline": Multi-line text input with label, default text, width, height, onChange
-- - "button": Clickable button with text, width, onClick
-- - "toggle": Checkbox with label, getValue, setValue
-- - "input": Single-line input with label, default text, width, onChange
-- - "dropdown": Selection dropdown with label, values, getValue, setValue, width
-- - "slider": Value slider with label, min, max, step, getValue, setValue, width
--
-- SUPPORTED SECTION TYPES:
-- - "table": Tabular data (existing)
-- - "custom": Custom rendering (existing)
-- - "spellDiagnostic": Spell diagnostics (existing)
-- - [customType]: Custom section renderers (NEW)
--
-- TIMER MANAGEMENT:
-- - Auto-refresh toggle with status indicator
-- - Manual start/stop timer controls
-- - Configurable refresh intervals
-- - Centralized timer management through utility functions
--
-- POSITION MANAGEMENT:
-- - Automatic position saving when enabled
-- - Configurable initial positions
-- - Frame persistence across sessions
--
-- ERROR HANDLING:
-- - Graceful fallback for missing custom renderers
-- - Validation of control configurations
-- - Clear error messages for configuration issues
--
-- PERFORMANCE OPTIMIZATIONS:
-- - Lazy loading of custom controls
-- - Efficient widget creation and cleanup
-- - Minimal memory overhead for inactive frames
--
-- ============================ BEST PRACTICES ============================
--
-- 1. ORGANIZATION:
--    - Keep custom controls focused and minimal
--    - Use descriptive names for custom section types
--    - Group related functionality in single sections
--
-- 2. ERROR HANDLING:
--    - Always validate data before rendering
--    - Provide fallback content for missing data
--    - Use appropriate font objects for different content types
--
-- 3. PERFORMANCE:
--    - Cache expensive computations in data functions
--    - Minimize widget creation in custom renderers
--    - Use appropriate refresh intervals for data updates
--
-- 4. USER EXPERIENCE:
--    - Provide clear labels and descriptions
--    - Use consistent spacing and layout
--    - Include helpful instructions and examples
--
-- 5. MAINTENANCE:
--    - Document custom section types clearly
--    - Keep renderer functions focused and testable
--    - Use consistent naming conventions
--
-- ============================ EXAMPLE MIGRATION ============================
--
-- OLD AST Parser Debug Frame:
-- function NAGStringParser:ShowASTDebugFrame()
--     ns.DebugFrameUtil:ShowASTDebugFrame(self)
-- end
--
-- NEW Enhanced Debug Frame:
-- function NAGStringParser:ShowASTDebugFrame()
--     ns.DebugFrameUtil:ShowDebugFrame(self, {
--         title = "NAG String Parser - AST Debug Frame",
--         width = 1000,
--         height = 800,
--         refreshInterval = 1.0,
--         autoRefresh = true,
--         showTimerControls = true,
--
--         customControls = self:GetASTDebugControls(),
--         customSectionTypes = self:GetASTDebugSectionTypes(),
--         sections = self:GetASTDebugSections()
--     })
-- end
--
-- This migration provides:
-- - Better separation of concerns
-- - Easier testing and maintenance
-- - Consistent UI behavior
-- - Reusable components
-- - Enhanced functionality
]]
