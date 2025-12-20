local ADDON_NAME, Addon = ...

local function GetBindCommand(idx)
    return "CLICK RadialWheelToggle" .. idx .. ":LeftButton"
end

local function GetBoundKeys(idx)
    return { GetBindingKey(GetBindCommand(idx)) }
end

local function ClearBindings(idx)
    for _, key in ipairs(GetBoundKeys(idx)) do
        SetBinding(key)
    end
end

local function GetBindingDisplayText(idx)
    local keys = GetBoundKeys(idx)
    return #keys > 0 and _G.GetBindingText(keys[1]) or "(unbound)"
end

local function GetSelectorText(idx)
    local profile = RadialWheelProfiles[idx]
    local text = GetBindingDisplayText(idx)
    if profile.label and #profile.label > 0 then
        return text .. ": " .. profile.label
    end
    return text
end

local function SaveBindings()
    if AttemptToSaveBindings then
        AttemptToSaveBindings(GetCurrentBindingSet())
    else
        _G.SaveBindings(GetCurrentBindingSet())
    end
end

local function RestoreAllBindings()
    for i = 1, RadialWheelDB.wheelCount do
        local profile = RadialWheelProfiles[i]
        if profile.binding then
            SetBinding(profile.binding, GetBindCommand(i))
        end
    end
    SaveBindings()
end

function RadialWheelPanel_AddWheel()
    PlaySound(624)
    local panel = RadialWheelSettingsPanel
    panel.activeWheel = Addon:CreateWheel()
    Addon:BuildAllWheels()
    panel.UpdateWidgets()
end

function RadialWheelPanel_RemoveWheel()
    PlaySound(624)
    if RadialWheelDB.wheelCount <= 1 then
        PlaySound(847)
        return
    end

    local panel = RadialWheelSettingsPanel
    ClearBindings(panel.activeWheel)
    Addon:DestroyWheel(panel.activeWheel)

    if panel.activeWheel > RadialWheelDB.wheelCount then
        panel.activeWheel = RadialWheelDB.wheelCount
    end

    RestoreAllBindings()
    Addon:BuildAllWheels()
    panel.UpdateWidgets()
end

local WIDGET_SPECS = {
    { id = "binding",      title = "Key Binding",     kind = "keybind" },
    { id = "label",        title = "Label",           kind = "textbox" },
    { id = "slotStart",    title = "Starting Slot",   kind = "numeric", hint = "Action bar slot for first button" },
    { id = "slotCount",    title = "Button Count",    kind = "range", low = 1, high = 24, step = 1, suffix = "" },
    { id = "quickCast",    title = "Quick Cast",      kind = "toggle", hint = "Hold to show, release to activate" },
    { id = "dismissOnUse", title = "Dismiss on Use",  kind = "toggle" },
    { id = "bgTint",       title = "Background Tint", kind = "colorpicker" },
    { id = "size",         title = "Wheel Radius",    kind = "range", low = 0, high = 300, step = 1, suffix = " px" },
    { id = "rotation",     title = "Rotation Offset", kind = "range", low = 0, high = 360, step = 1, suffix = "°" },
}

function Addon:SetupSettingsPanel()
    local panel = RadialWheelSettingsPanel
    local config = RadialWheelSettingsPanelConfig
    local selector = RadialWheelSettingsPanelSelector

    panel.activeWheel = 1

    local function PopulateMenu()
        for i = 1, RadialWheelDB.wheelCount do
            local info = UIDropDownMenu_CreateInfo()
            info.text = GetSelectorText(i)
            info.value = i
            info.checked = i == panel.activeWheel
            info.func = function(_, idx)
                panel.activeWheel = idx
                panel.UpdateWidgets()
            end
            info.arg1 = i
            UIDropDownMenu_AddButton(info)
        end
    end

    UIDropDownMenu_Initialize(selector, PopulateMenu)
    UIDropDownMenu_SetWidth(selector, 200)
    UIDropDownMenu_JustifyText(selector, "LEFT")

    local LABEL_W, WIDGET_W, ROW_GAP = 160, 180, 24

    local function AttachWidget(widget)
        widget:SetParent(config)
        if config.lastChild then
            widget:SetPoint("TOPLEFT", config.lastChild, "BOTTOMLEFT", 0, -ROW_GAP)
        else
            widget:SetPoint("TOPLEFT", config, "TOPLEFT", 16, -16)
        end
        config.lastChild = widget
    end

    local function RefreshWidget(spec)
        local w = spec.widget
        if not w then return end
        local profile = RadialWheelProfiles[panel.activeWheel]
        if not profile then return end
        local val = profile[spec.id]

        if spec.kind == "range" then
            w:SetValue(val or spec.low)
            _G[w:GetName() .. "Text"]:SetText(math.floor((val or spec.low) + 0.5) .. (spec.suffix or ""))
        elseif spec.kind == "toggle" then
            w:SetChecked(val)
        elseif spec.kind == "textbox" then
            w:SetText(val or "")
            w:SetCursorPosition(0)
            w:ClearFocus()
        elseif spec.kind == "numeric" then
            w:SetText(val or 0)
            w:SetCursorPosition(0)
            w:ClearFocus()
        elseif spec.kind == "keybind" then
            w:SetText(GetBindingDisplayText(panel.activeWheel))
        elseif spec.kind == "colorpicker" then
            if val then
                w.swatch:SetVertexColor(val.red, val.green, val.blue, val.alpha)
            end
        end
    end

    local function OnChange(spec, val)
        RadialWheelProfiles[panel.activeWheel][spec.id] = val
        Addon:BuildWheel(panel.activeWheel)
        UIDropDownMenu_SetText(selector, GetSelectorText(panel.activeWheel))
    end

    for _, spec in ipairs(WIDGET_SPECS) do
        local lbl = config:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        lbl:SetText(spec.title)
        lbl:SetWidth(LABEL_W)
        lbl:SetJustifyH("LEFT")
        AttachWidget(lbl)

        local w

        if spec.kind == "range" then
            w = CreateFrame("Slider", config:GetName() .. spec.id, config, "OptionsSliderTemplate")
            w:SetPoint("LEFT", lbl, "RIGHT", 0, 0)
            w:SetSize(WIDGET_W, 17)
            w:SetMinMaxValues(spec.low, spec.high)
            w:SetValueStep(spec.step or 1)
            w:SetObeyStepOnDrag(true)

            -- Hide the default labels
            _G[w:GetName() .. "Low"]:SetText("")
            _G[w:GetName() .. "High"]:SetText("")
            _G[w:GetName() .. "Text"]:SetText("")

            w:SetScript("OnValueChanged", function(self, val, user)
                _G[self:GetName() .. "Text"]:SetText(math.floor(val + 0.5) .. (spec.suffix or ""))
                if user then OnChange(spec, math.floor(val + 0.5)) end
            end)

            -- Initialize with default value
            w:SetValue(spec.low)

        elseif spec.kind == "toggle" then
            w = CreateFrame("CheckButton", nil, config)
            w:SetSize(26, 26)
            w:SetPoint("LEFT", lbl, "RIGHT", -2, 0)
            w:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up")
            w:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down")
            w:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight", "ADD")
            w:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
            w:SetDisabledCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
            w:SetScript("OnClick", function(self) OnChange(spec, self:GetChecked()) end)

        elseif spec.kind == "textbox" then
            w = CreateFrame("EditBox", nil, config, "InputBoxTemplate")
            w:SetPoint("LEFT", lbl, "RIGHT", 6, 0)
            w:SetSize(WIDGET_W - 6, 20)
            w:SetAutoFocus(false)
            w:SetScript("OnTextChanged", function(self, user) if user then OnChange(spec, self:GetText()) end end)

        elseif spec.kind == "numeric" then
            w = CreateFrame("EditBox", nil, config, "InputBoxTemplate")
            w:SetPoint("LEFT", lbl, "RIGHT", 6, 0)
            w:SetSize(40, 20)
            w:SetAutoFocus(false)
            w:SetNumeric(true)
            w:SetMaxLetters(3)
            w:SetScript("OnTextChanged", function(self, user) if user then OnChange(spec, tonumber(self:GetText())) end end)

        elseif spec.kind == "keybind" then
            w = CreateFrame("Button", nil, config, "UIPanelButtonTemplate")
            w:SetPoint("LEFT", lbl, "RIGHT", -1, 0)
            w:SetSize(WIDGET_W + 2, 22)
            w.capturing = false

            w:SetScript("OnClick", function(self)
                if self.capturing then
                    self.capturing = false
                    self:SetText(GetBindingDisplayText(panel.activeWheel))
                    self:EnableKeyboard(false)
                else
                    self.capturing = true
                    self:SetText("Press key...")
                    self:EnableKeyboard(true)
                end
            end)

            w:SetScript("OnKeyDown", function(self, key)
                if not self.capturing then return end
                if key:match("^[LR]?(SHIFT|CTRL|ALT)$") then return end

                if key == "ESCAPE" then
                    self.capturing = false
                    self:SetText(GetBindingDisplayText(panel.activeWheel))
                    self:EnableKeyboard(false)
                    return
                end

                local combo = ""
                if IsShiftKeyDown() then combo = "SHIFT-" end
                if IsControlKeyDown() then combo = combo .. "CTRL-" end
                if IsAltKeyDown() then combo = combo .. "ALT-" end
                combo = combo .. key

                ClearBindings(panel.activeWheel)
                SetBinding(combo, GetBindCommand(panel.activeWheel))
                SaveBindings()
                OnChange(spec, combo)

                self.capturing = false
                self:SetText(GetBindingDisplayText(panel.activeWheel))
                self:EnableKeyboard(false)
            end)

        elseif spec.kind == "colorpicker" then
            w = CreateFrame("Button", nil, config)
            w:SetPoint("LEFT", lbl, "RIGHT", 2, 0)
            w:SetSize(18, 18)

            local bg = w:CreateTexture(nil, "BACKGROUND")
            bg:SetAllPoints()
            bg:SetColorTexture(0.8, 0.8, 0.8, 1)

            w:SetNormalTexture("Interface/ChatFrame/ChatFrameColorSwatch")
            w.swatch = w:GetNormalTexture()
            w.swatch:SetAllPoints()

            w:SetScript("OnClick", function()
                local tint = RadialWheelProfiles[panel.activeWheel][spec.id]
                ColorPickerFrame:SetColorRGB(tint.red, tint.green, tint.blue)
                ColorPickerFrame.hasOpacity = true
                ColorPickerFrame.opacity = tint.alpha
                ColorPickerFrame.previousValues = { tint.red, tint.green, tint.blue, tint.alpha }

                local function Callback(restore)
                    local t = {}
                    if restore then
                        t.red, t.green, t.blue, t.alpha = unpack(restore)
                    else
                        t.red, t.green, t.blue = ColorPickerFrame:GetColorRGB()
                        t.alpha = OpacitySliderFrame:GetValue()
                    end
                    spec.widget.swatch:SetVertexColor(t.red, t.green, t.blue, t.alpha)
                    OnChange(spec, t)
                end

                ColorPickerFrame.func = Callback
                ColorPickerFrame.opacityFunc = Callback
                ColorPickerFrame.cancelFunc = Callback
                ColorPickerFrame:Hide()
                ColorPickerFrame:Show()
            end)
        end

        if w then
            w.tooltipText = spec.hint
            w.spec = spec
            spec.widget = w
        end
    end

    panel.UpdateWidgets = function()
        UIDropDownMenu_SetText(selector, GetSelectorText(panel.activeWheel))
        for _, spec in ipairs(WIDGET_SPECS) do
            RefreshWidget(spec)
        end
    end

    -- Refresh widgets when panel is shown
    panel:SetScript("OnShow", function()
        panel.UpdateWidgets()
    end)

    local ver = C_AddOns and C_AddOns.GetAddOnMetadata(ADDON_NAME, "Version") or GetAddOnMetadata(ADDON_NAME, "Version")
    RadialWheelSettingsPanelHeader:SetText("RingMenu Reborn |cFF888888v" .. ver)

    panel.name = "RingMenu Reborn"
    panel.refresh = panel.UpdateWidgets

    if Settings and Settings.RegisterCanvasLayoutCategory then
        local cat = Settings.RegisterCanvasLayoutCategory(panel, panel.name)
        cat.ID = panel.name
        Settings.RegisterAddOnCategory(cat)
        Addon.settingsCategoryID = cat.ID
    else
        InterfaceOptions_AddCategory(panel)
    end

    -- Initial refresh
    panel.UpdateWidgets()
end
