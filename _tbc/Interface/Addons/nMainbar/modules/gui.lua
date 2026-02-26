local _, nMainbar = ...
local L = nMainbar.L

-- We need to work directly with the config table that will be saved
local cfg = nMainbar.Config

-- IMPORTANT: Don't show reload dialog on first load
local isFirstLoad = true
C_Timer.After(2, function() isFirstLoad = false end)

-- Track which settings need reload
local needsReload = false

-- Show reload dialog
local function ShowReloadDialog()
    if not isFirstLoad and needsReload then
        StaticPopup_Show("NMAINBAR_RELOAD")
    end
end

-- Save config immediately without reload
local function SaveConfigNow()
    if nMainbar.SaveConfig then
        nMainbar.SaveConfig()
    end
end

-- Mark that reload is needed
local function MarkNeedsReload()
    needsReload = true
    ShowReloadDialog()
end

-- Helper for checkboxes: Save and mark for reload
local function SaveAndMarkReload()
    SaveConfigNow()
    MarkNeedsReload()
end

-- Apply button settings immediately without reload
local function ApplyButtonSettings()
    -- Apply to all action buttons
    for i = 1, 12 do
        for _, barName in ipairs({"ActionButton", "MultiBarBottomLeftButton", "MultiBarBottomRightButton", "MultiBarRightButton", "MultiBarLeftButton"}) do
            local button = _G[barName..i]
            if button and button.HotKey then
                -- Hide HotKey background textures
                if button.HotKey.Background then
                    button.HotKey.Background:Hide()
                end
                
                if cfg.button.showKeybinds then
                    button.HotKey:Show()
                    button.HotKey:SetAlpha(1)
                else
                    button.HotKey:Hide()
                end
            end
            if button and button.Name then
                if cfg.button.showMacroNames then
                    button.Name:Show()
                else
                    button.Name:Hide()
                end
            end
        end
    end
end

-- Register reload popup
StaticPopupDialogs["NMAINBAR_RELOAD"] = {
    text = L["Some changes require /reload to take effect."] or "Some changes require /reload to take effect.",
    button1 = L["Reload"] or "Reload",
    button2 = L["Later"] or "Later",
    OnAccept = function()
        ReloadUI()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

-- ========================================
-- MODERN UI HELPERS
-- ========================================

-- Color scheme
local COLORS = {
    primary = {0.2, 0.5, 0.9},
    accent = {0.9, 0.4, 0.2},
    success = {0.3, 0.8, 0.3},
    warning = {0.9, 0.7, 0.2},
    text = {0.95, 0.95, 0.95},
    textDim = {0.7, 0.7, 0.7},
    bg = {0.08, 0.08, 0.08},
    bgLight = {0.12, 0.12, 0.12},
    border = {0.25, 0.25, 0.25},
}

-- Helper: Create a modern section header
local function CreateSectionHeader(parent, text, icon)
    local header = CreateFrame("Frame", nil, parent)
    header:SetSize(560, 32)
    
    -- Background line
    local line = header:CreateTexture(nil, "BACKGROUND")
    line:SetColorTexture(COLORS.border[1], COLORS.border[2], COLORS.border[3], 0.5)
    line:SetPoint("LEFT", 0, 0)
    line:SetPoint("RIGHT", 0, 0)
    line:SetHeight(1)
    
    -- Text background
    local textBg = header:CreateTexture(nil, "BACKGROUND")
    textBg:SetColorTexture(COLORS.bgLight[1], COLORS.bgLight[2], COLORS.bgLight[3], 1)
    textBg:SetPoint("CENTER", header, "LEFT", 80, 0)
    textBg:SetSize(140, 24)
    
    -- Icon (optional)
    if icon then
        local iconTex = header:CreateTexture(nil, "ARTWORK")
        iconTex:SetPoint("LEFT", textBg, "LEFT", 8, 0)
        iconTex:SetSize(16, 16)
        iconTex:SetTexture(icon)
    end
    
    -- Text
    local label = header:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    label:SetPoint("CENTER", textBg, "CENTER", icon and 8 or 0, 0)
    label:SetText(text)
    label:SetTextColor(COLORS.primary[1], COLORS.primary[2], COLORS.primary[3])
    
    return header
end

-- Helper: Create modern checkbox with custom styling
local function CreateModernCheckbox(parent, text, description, getter, onClick)
    local container = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    container:SetSize(540, description and 52 or 36)
    container:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        tileSize = 1,
        edgeSize = 1,
        insets = {left = 0, right = 0, top = 0, bottom = 0}
    })
    container:SetBackdropColor(COLORS.bgLight[1], COLORS.bgLight[2], COLORS.bgLight[3], 0.4)
    container:SetBackdropBorderColor(COLORS.border[1], COLORS.border[2], COLORS.border[3], 0.6)
    
    -- Checkbox
    local check = CreateFrame("CheckButton", nil, container)
    check:SetPoint("LEFT", 12, 0)
    check:SetSize(24, 24)
    check:SetScript("OnClick", onClick)
    
    -- Custom checkbox visuals
    local checkBg = check:CreateTexture(nil, "BACKGROUND")
    checkBg:SetAllPoints(check)
    checkBg:SetColorTexture(0.05, 0.05, 0.05, 1)
    
    local checkBorder = check:CreateTexture(nil, "BORDER")
    checkBorder:SetPoint("TOPLEFT", -1, 1)
    checkBorder:SetPoint("BOTTOMRIGHT", 1, -1)
    checkBorder:SetColorTexture(COLORS.border[1], COLORS.border[2], COLORS.border[3], 1)
    
    local checkMark = check:CreateTexture(nil, "ARTWORK")
    checkMark:SetPoint("CENTER")
    checkMark:SetSize(16, 16)
    checkMark:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
    checkMark:SetVertexColor(COLORS.success[1], COLORS.success[2], COLORS.success[3])
    checkMark:Hide()
    
    -- Store references for later updates
    check.checkBorder = checkBorder
    check.checkMark = checkMark
    
    check:SetScript("OnEnter", function(self)
        checkBorder:SetVertexColor(COLORS.primary[1], COLORS.primary[2], COLORS.primary[3], 1)
    end)
    
    check:SetScript("OnLeave", function(self)
        if self:GetChecked() then
            checkBorder:SetVertexColor(COLORS.success[1], COLORS.success[2], COLORS.success[3], 1)
        else
            checkBorder:SetVertexColor(COLORS.border[1], COLORS.border[2], COLORS.border[3], 1)
        end
    end)
    
    -- Update check mark visibility
    local originalOnClick = onClick
    check:SetScript("OnClick", function(self)
        local isChecked = self:GetChecked()
        if isChecked then
            checkMark:Show()
            checkBorder:SetVertexColor(COLORS.success[1], COLORS.success[2], COLORS.success[3], 1)
        else
            checkMark:Hide()
            checkBorder:SetVertexColor(COLORS.border[1], COLORS.border[2], COLORS.border[3], 1)
        end
        originalOnClick(self)
    end)
    
    -- Label
    local label = container:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    label:SetPoint("LEFT", check, "RIGHT", 12, description and 8 or 0)
    label:SetPoint("RIGHT", container, "RIGHT", -12, 0)
    label:SetJustifyH("LEFT")
    label:SetText(text)
    label:SetTextColor(COLORS.text[1], COLORS.text[2], COLORS.text[3])
    
    -- Description (optional)
    if description then
        local desc = container:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
        desc:SetPoint("TOPLEFT", label, "BOTTOMLEFT", 0, -4)
        desc:SetPoint("RIGHT", container, "RIGHT", -12, 0)
        desc:SetJustifyH("LEFT")
        desc:SetText(description)
        desc:SetTextColor(COLORS.textDim[1], COLORS.textDim[2], COLORS.textDim[3])
    end
    
    container.check = check
    return container, check
end

-- Helper: Create modern slider
local function CreateModernSlider(parent, text, description, min, max, step, getter, setValue, needsReload)
    local container = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    container:SetSize(540, 72)
    container:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        tileSize = 1,
        edgeSize = 1,
        insets = {left = 0, right = 0, top = 0, bottom = 0}
    })
    container:SetBackdropColor(COLORS.bgLight[1], COLORS.bgLight[2], COLORS.bgLight[3], 0.4)
    container:SetBackdropBorderColor(COLORS.border[1], COLORS.border[2], COLORS.border[3], 0.6)
    
    -- Label
    local label = container:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    label:SetPoint("TOPLEFT", 12, -12)
    label:SetText(text)
    label:SetTextColor(COLORS.text[1], COLORS.text[2], COLORS.text[3])
    
    -- Value display
    local valueText = container:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    valueText:SetPoint("TOPRIGHT", -12, -10)
    valueText:SetTextColor(COLORS.primary[1], COLORS.primary[2], COLORS.primary[3])
    
    -- Slider
    local slider = CreateFrame("Slider", nil, container)
    slider:SetPoint("BOTTOMLEFT", 12, 12)
    slider:SetPoint("BOTTOMRIGHT", -12, 12)
    slider:SetHeight(18)
    slider:SetMinMaxValues(min, max)
    slider:SetValueStep(step)
    slider:SetObeyStepOnDrag(true)
    slider:SetOrientation("HORIZONTAL")
    
    -- Slider background track
    local sliderBg = slider:CreateTexture(nil, "BACKGROUND")
    sliderBg:SetAllPoints(slider)
    sliderBg:SetColorTexture(0.05, 0.05, 0.05, 1)
    
    -- Slider progress
    local sliderProgress = slider:CreateTexture(nil, "BORDER")
    sliderProgress:SetPoint("LEFT")
    sliderProgress:SetHeight(18)
    sliderProgress:SetColorTexture(COLORS.primary[1], COLORS.primary[2], COLORS.primary[3], 0.6)
    
    -- Slider thumb
    local thumb = slider:CreateTexture(nil, "OVERLAY")
    thumb:SetSize(16, 24)
    thumb:SetColorTexture(COLORS.primary[1], COLORS.primary[2], COLORS.primary[3], 1)
    slider:SetThumbTexture(thumb)
    
    -- Track if we're updating programmatically (to prevent feedback loops)
    local updatingProgrammatically = false
    
    -- Track if value changed by user (for reload detection)
    local userChangedValue = false
    
    slider:SetScript("OnValueChanged", function(self, value)
        -- Update visual elements ALWAYS (even for programmatic updates)
        valueText:SetText(string.format("%.0f", value))
        local percent = (value - min) / (max - min)
        sliderProgress:SetWidth(slider:GetWidth() * percent)
        
        -- Only save and track changes if not updating programmatically
        if not updatingProgrammatically then
            setValue(value)
            SaveConfigNow()
            -- Mark that user changed the value (but don't show dialog yet)
            if needsReload then
                userChangedValue = true
            end
        end
    end)
    
    -- Show reload dialog only when user releases the slider
    slider:SetScript("OnMouseUp", function(self)
        if userChangedValue and needsReload then
            MarkNeedsReload()
            userChangedValue = false
        end
    end)
    
    slider:SetScript("OnEnter", function(self)
        thumb:SetVertexColor(1, 1, 1, 1)
    end)
    
    slider:SetScript("OnLeave", function(self)
        thumb:SetVertexColor(COLORS.primary[1], COLORS.primary[2], COLORS.primary[3], 1)
    end)
    
    -- Set initial value without triggering callbacks
    updatingProgrammatically = true
    slider:SetValue(getter())
    updatingProgrammatically = false
    
    -- Store the update function for later use
    slider.UpdateFromConfig = function()
        updatingProgrammatically = true
        local value = getter()
        slider:SetValue(value)
        -- Ensure visual update happens even if OnValueChanged doesn't fire properly
        C_Timer.After(0, function()
            valueText:SetText(string.format("%.0f", value))
            local percent = (value - min) / (max - min)
            local width = slider:GetWidth()
            if width > 0 then
                sliderProgress:SetWidth(width * percent)
            end
        end)
        updatingProgrammatically = false
    end
    
    container.slider = slider
    return container, slider
end

-- Helper: Create modern button
local function CreateModernButton(parent, text, onClick, variant)
    variant = variant or "primary" -- primary, secondary, warning
    
    local btn = CreateFrame("Button", nil, parent, "BackdropTemplate")
    btn:SetSize(180, 32)
    btn:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        tileSize = 1,
        edgeSize = 1,
        insets = {left = 0, right = 0, top = 0, bottom = 0}
    })
    
    local color = COLORS.primary
    if variant == "warning" then color = COLORS.warning
    elseif variant == "secondary" then color = COLORS.textDim end
    
    btn:SetBackdropColor(color[1], color[2], color[3], 0.8)
    btn:SetBackdropBorderColor(color[1], color[2], color[3], 1)
    
    local label = btn:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    label:SetPoint("CENTER")
    label:SetText(text)
    label:SetTextColor(1, 1, 1, 1)
    
    btn:SetScript("OnEnter", function(self)
        self:SetBackdropColor(color[1], color[2], color[3], 1)
    end)
    
    btn:SetScript("OnLeave", function(self)
        self:SetBackdropColor(color[1], color[2], color[3], 0.8)
    end)
    
    btn:SetScript("OnMouseDown", function(self)
        self:SetBackdropColor(color[1] * 0.7, color[2] * 0.7, color[3] * 0.7, 1)
    end)
    
    btn:SetScript("OnMouseUp", function(self)
        self:SetBackdropColor(color[1], color[2], color[3], 1)
    end)
    
    btn:SetScript("OnClick", onClick)
    
    return btn
end

-- Helper: Create info box
local function CreateInfoBox(parent, text, variant)
    variant = variant or "info" -- info, warning, success
    
    local box = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    box:SetSize(540, 60)
    box:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        tileSize = 1,
        edgeSize = 2,
        insets = {left = 0, right = 0, top = 0, bottom = 0}
    })
    
    local color = COLORS.primary
    if variant == "warning" then color = COLORS.warning
    elseif variant == "success" then color = COLORS.success end
    
    box:SetBackdropColor(color[1], color[2], color[3], 0.15)
    box:SetBackdropBorderColor(color[1], color[2], color[3], 0.5)
    
    -- Icon
    local icon = box:CreateFontString(nil, "ARTWORK", "GameFontNormalHuge")
    icon:SetPoint("LEFT", 16, 0)
    icon:SetText(variant == "warning" and "!" or "i")
    icon:SetTextColor(color[1], color[2], color[3])
    
    -- Text
    local label = box:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    label:SetPoint("LEFT", icon, "RIGHT", 12, 0)
    label:SetPoint("RIGHT", box, "RIGHT", -16, 0)
    label:SetJustifyH("LEFT")
    label:SetText(text)
    label:SetTextColor(COLORS.text[1], COLORS.text[2], COLORS.text[3])
    
    return box
end

-- ========================================
-- MAIN OPTIONS FRAME
-- ========================================

-- Create main options frame
local optionsFrame = CreateFrame("Frame", "nMainbarOptionsFrame", UIParent, "BackdropTemplate")
optionsFrame.name = "nMainbar"
optionsFrame:Hide()
optionsFrame:SetBackdrop({
    bgFile = "Interface\\Buttons\\WHITE8x8",
    tile = false,
})
optionsFrame:SetBackdropColor(COLORS.bg[1], COLORS.bg[2], COLORS.bg[3], 1)

-- Save references to all checkboxes and sliders for updating
local guiElements = {}

-- Function to update all GUI elements from config
local function UpdateGUIFromConfig()
    for element, getter in pairs(guiElements) do
        if element.SetChecked then
            element:SetChecked(getter())
            -- Update visual state
            if element:GetChecked() then
                element.checkMark:Show()
                element.checkBorder:SetVertexColor(COLORS.success[1], COLORS.success[2], COLORS.success[3], 1)
            else
                element.checkMark:Hide()
                element.checkBorder:SetVertexColor(COLORS.border[1], COLORS.border[2], COLORS.border[3], 1)
            end
        elseif element.UpdateFromConfig then
            -- Use special update method for sliders to prevent feedback loops
            element:UpdateFromConfig()
        elseif element.SetValue then
            element:SetValue(getter())
        end
    end
end

-- Update GUI when shown
optionsFrame:SetScript("OnShow", function(self)
    UpdateGUIFromConfig()
    needsReload = false
end)

-- Header area
local headerBg = optionsFrame:CreateTexture(nil, "BACKGROUND")
headerBg:SetPoint("TOPLEFT")
headerBg:SetPoint("TOPRIGHT")
headerBg:SetHeight(80)
headerBg:SetColorTexture(COLORS.bgLight[1], COLORS.bgLight[2], COLORS.bgLight[3], 0.8)

-- Title
local title = optionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalHuge")
title:SetPoint("TOPLEFT", 24, -20)
title:SetText("nMainbar")
title:SetTextColor(COLORS.primary[1], COLORS.primary[2], COLORS.primary[3])

-- Subtitle
local subtitle = optionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -6)
subtitle:SetText("Modern Action Bar Customization")
subtitle:SetTextColor(COLORS.textDim[1], COLORS.textDim[2], COLORS.textDim[3])

-- Scroll Frame
local scrollFrame = CreateFrame("ScrollFrame", nil, optionsFrame, "UIPanelScrollFrameTemplate")
scrollFrame:SetPoint("TOPLEFT", 20, -90)
scrollFrame:SetPoint("BOTTOMRIGHT", -32, 20)

-- Custom scrollbar styling
if scrollFrame.ScrollBar then
    scrollFrame.ScrollBar:ClearAllPoints()
    scrollFrame.ScrollBar:SetPoint("TOPRIGHT", -4, -16)
    scrollFrame.ScrollBar:SetPoint("BOTTOMRIGHT", -4, 16)
end

-- Content Frame
local content = CreateFrame("Frame", nil, scrollFrame)
content:SetSize(560, 1550)
scrollFrame:SetScrollChild(content)

-- Current Y position
local yOffset = -10

-- ========================================
-- GENERAL SETTINGS
-- ========================================

local generalHeader = CreateSectionHeader(content, L["General"] or "Allgemein")
generalHeader:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
yOffset = yOffset - 45

-- Edit Mode Info
local editModeInfo = CreateInfoBox(content,
    L["Size, transparency and bar art are controlled via Blizzard's Edit Mode."] or "Size, transparency and bar art are controlled via Blizzard's Edit Mode.",
    "info"
)
editModeInfo:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
yOffset = yOffset - 72

-- Open Edit Mode Button
local editModeBtn = CreateModernButton(content,
    L["Open Edit Mode"] or "Open Edit Mode",
    function()
        if EditModeManagerFrame then
            if not EditModeManagerFrame:IsShown() then
                EditModeManagerFrame:Show()
                C_Timer.After(0.1, function()
                    if EditModeManagerFrame.ShowSystem then
                        EditModeManagerFrame:ShowSystem(Enum.EditModeSystem.ActionBar)
                    end
                end)
                print("|cffCC3333nMainbar|r: Edit Mode opened. Click 'Action Bar 1' for bar art options.")
            else
                EditModeManagerFrame:Hide()
            end
        else
            print("|cffCC3333nMainbar|r: Edit Mode not available")
        end
    end,
    "primary"
)
editModeBtn:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
editModeBtn:SetWidth(240)
yOffset = yOffset - 48

-- Picomenu
local picomenuContainer, picomenuCheck = CreateModernCheckbox(content,
    L["Show Picomenu"] or "Show Picomenu",
    L["Show the circular menu button"] or "Show the circular menu button",
    function() return cfg.showPicomenu end,
    function(self)
        cfg.showPicomenu = self:GetChecked()
        SaveAndMarkReload()
    end
)
picomenuContainer:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
guiElements[picomenuCheck] = function() return cfg.showPicomenu end
yOffset = yOffset - 58

-- Picomenu Move Hint
local picomenuHint = content:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
picomenuHint:SetPoint("TOPLEFT", content, "TOPLEFT", 28, yOffset)
picomenuHint:SetText("|cFFAAAAAA" .. (L["Picomenu Move Hint"] or "Hold Shift + Left Click to move the Picomenu.") .. "|r")
picomenuHint:SetJustifyH("LEFT")
picomenuHint:SetWidth(480)
yOffset = yOffset - 28

-- Combined Bags
local bagsContainer, bagsCheck = CreateModernCheckbox(content,
    L["Combined Bags"] or "Taschen kombinieren",
    L["Combine all bags into one button"] or "Kombiniere alle Taschen zu einem Button",
    function() return cfg.combinedBags end,
    function(self)
        cfg.combinedBags = self:GetChecked()
        SaveConfigNow()
        if nMainbar.ApplyCombinedBags then
            nMainbar.ApplyCombinedBags()
        end
    end
)
bagsContainer:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
guiElements[bagsCheck] = function() return cfg.combinedBags end
yOffset = yOffset - 60

-- MicroMenu Mouseover
local microContainer, microCheck = CreateModernCheckbox(content,
    L["MicroMenu Mouseover"] or "MicroMenu Mouseover",
    L["Only show MicroMenu icons on mouseover"] or "Only show MicroMenu icons on mouseover",
    function() return cfg.microMenu.mouseover end,
    function(self)
        cfg.microMenu.mouseover = self:GetChecked()
        SaveConfigNow()
        if nMainbar.ApplyMicroMenuMouseover then
            nMainbar.ApplyMicroMenuMouseover()
        end
    end
)
microContainer:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
guiElements[microCheck] = function() return cfg.microMenu.mouseover end
yOffset = yOffset - 60

-- Show Minimap Button
local minimapContainer, minimapCheck = CreateModernCheckbox(content,
    L["Show Minimap Button"] or "Show Minimap Button",
    L["Display nMainbar icon on the minimap"] or "Display nMainbar icon on the minimap",
    function() 
        return nMainbar.IsMinimapButtonShown and nMainbar.IsMinimapButtonShown() or true
    end,
    function(self)
        if self:GetChecked() then
            if nMainbar.ShowMinimapButton then
                nMainbar.ShowMinimapButton()
            end
        else
            if nMainbar.HideMinimapButton then
                nMainbar.HideMinimapButton()
            end
        end
    end
)
minimapContainer:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
guiElements[minimapCheck] = function() 
    return nMainbar.IsMinimapButtonShown and nMainbar.IsMinimapButtonShown() or true
end
yOffset = yOffset - 70

-- ========================================
-- BUTTON SETTINGS
-- ========================================

local buttonHeader = CreateSectionHeader(content, L["Button Settings"] or "Button-Einstellungen")
buttonHeader:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
yOffset = yOffset - 45

-- Show Keybinds
local keybindsContainer, keybindsCheck = CreateModernCheckbox(content,
    L["Show Keybinds"] or "Show Keybinds",
    L["Display keybinding text on buttons"] or "Display keybinding text on buttons",
    function() return cfg.button.showKeybinds end,
    function(self)
        cfg.button.showKeybinds = self:GetChecked()
        SaveConfigNow()
        ApplyButtonSettings()
    end
)
keybindsContainer:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
guiElements[keybindsCheck] = function() return cfg.button.showKeybinds end
yOffset = yOffset - 60

-- Show Macro Names
local macroNamesContainer, macroNamesCheck = CreateModernCheckbox(content,
    L["Show Macro Names"] or "Show Macro Names",
    L["Display macro names on buttons"] or "Display macro names on buttons",
    function() return cfg.button.showMacroNames end,
    function(self)
        cfg.button.showMacroNames = self:GetChecked()
        SaveConfigNow()
        ApplyButtonSettings()
    end
)
macroNamesContainer:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
guiElements[macroNamesCheck] = function() return cfg.button.showMacroNames end
yOffset = yOffset - 60

-- Out of Range Coloring
local rangeContainer, rangeCheck = CreateModernCheckbox(content,
    L["Out of Range Coloring"] or "Out of Range Coloring",
    L["Color buttons red when target is out of range"] or "Color buttons red when target is out of range",
    function() return cfg.button.buttonOutOfRange end,
    function(self)
        cfg.button.buttonOutOfRange = self:GetChecked()
        SaveAndMarkReload()
    end
)
rangeContainer:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
guiElements[rangeCheck] = function() return cfg.button.buttonOutOfRange end
yOffset = yOffset - 70

-- Font Sizes Section Header
local fontHeader = content:CreateFontString(nil, "ARTWORK", "GameFontNormal")
fontHeader:SetPoint("TOPLEFT", content, "TOPLEFT", 12, yOffset)
fontHeader:SetText(L["Font Sizes"] or "Font Sizes")
fontHeader:SetTextColor(COLORS.textDim[1], COLORS.textDim[2], COLORS.textDim[3])
yOffset = yOffset - 30

-- Hotkey Font Size
local hotkeyContainer, hotkeySlider = CreateModernSlider(content,
    L["Hotkey Font Size"] or "Hotkey Font Size",
    nil,
    8, 24, 1,
    function() return cfg.button.hotkeyFontsize end,
    function(value)
        cfg.button.hotkeyFontsize = value
    end,
    true -- needs reload
)
hotkeyContainer:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
guiElements[hotkeySlider] = function() return cfg.button.hotkeyFontsize end
yOffset = yOffset - 80

-- Count Font Size
local countContainer, countSlider = CreateModernSlider(content,
    L["Count Font Size"] or "Count Font Size",
    nil,
    8, 24, 1,
    function() return cfg.button.countFontsize end,
    function(value)
        cfg.button.countFontsize = value
    end,
    true -- needs reload
)
countContainer:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
guiElements[countSlider] = function() return cfg.button.countFontsize end
yOffset = yOffset - 80

-- Macro Name Font Size
local macroSizeContainer, macroSizeSlider = CreateModernSlider(content,
    L["Macro Name Font Size"] or "Macro Name Font Size",
    nil,
    8, 24, 1,
    function() return cfg.button.macronameFontsize end,
    function(value)
        cfg.button.macronameFontsize = value
    end,
    true -- needs reload
)
macroSizeContainer:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
guiElements[macroSizeSlider] = function() return cfg.button.macronameFontsize end
yOffset = yOffset - 90

-- ========================================
-- COLOR SETTINGS
-- ========================================

local colorHeader = CreateSectionHeader(content, L["Color Settings"] or "Farb-Einstellungen")
colorHeader:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
yOffset = yOffset - 45

-- Color picker helper using WoW's built-in ColorPickerFrame
local function OpenColorPicker(r, g, b, a, onChange, onCancel)
    local prevR, prevG, prevB, prevA = r, g, b, a

    local function callback(isCancel)
        if isCancel then
            onCancel(prevR, prevG, prevB, prevA)
        else
            local nr, ng, nb = ColorPickerFrame:GetColorRGB()
            -- opacity: 0 = fully visible, 1 = fully transparent → alpha = 1 - opacity
            local opacity = ColorPickerFrame:GetColorAlpha() or 0
            local na = 1 - opacity
            onChange(nr, ng, nb, na)
        end
    end

    -- Dragonflight/Midnight API (TWW+): uses swatchFunc, not func
    if ColorPickerFrame.SetupColorPickerAndShow then
        ColorPickerFrame:SetupColorPickerAndShow({
            r = r, g = g, b = b,
            opacity = 1 - a,
            hasOpacity = true,
            swatchFunc  = function() callback(false) end,
            opacityFunc = function() callback(false) end,
            cancelFunc  = function() callback(true) end,
        })
    else
        -- Legacy API fallback (pre-Dragonflight)
        ColorPickerFrame.func        = function() callback(false) end
        ColorPickerFrame.opacityFunc = function() callback(false) end
        ColorPickerFrame.cancelFunc  = function() callback(true) end
        ColorPickerFrame:SetColorRGB(r, g, b)
        ColorPickerFrame.hasOpacity = true
        ColorPickerFrame.opacity = 1 - a
        ColorPickerFrame:Hide()
        ColorPickerFrame:Show()
    end
end

-- Mouseover border color row
do
    local row = CreateFrame("Frame", nil, content, "BackdropTemplate")
    row:SetSize(540, 52)
    row:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false, tileSize = 1, edgeSize = 1,
        insets = {left=0, right=0, top=0, bottom=0},
    })
    row:SetBackdropColor(COLORS.bgLight[1], COLORS.bgLight[2], COLORS.bgLight[3], 0.4)
    row:SetBackdropBorderColor(COLORS.border[1], COLORS.border[2], COLORS.border[3], 0.6)
    row:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)

    -- Label
    local label = row:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    label:SetPoint("LEFT", 12, 0)
    label:SetText(L["Mouseover Border Color"] or "Mouseover-Rand Farbe")
    label:SetTextColor(COLORS.text[1], COLORS.text[2], COLORS.text[3])

    -- Color swatch button
    local swatchBtn = CreateFrame("Button", nil, row, "BackdropTemplate")
    swatchBtn:SetSize(32, 32)
    swatchBtn:SetPoint("RIGHT", row, "RIGHT", -120, 0)
    swatchBtn:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false, tileSize = 1, edgeSize = 2,
        insets = {left=0, right=0, top=0, bottom=0},
    })

    local function RefreshSwatch()
        local c = cfg.color.Mouseover
        swatchBtn:SetBackdropColor(c.r, c.g, c.b, 1)
        swatchBtn:SetBackdropBorderColor(1, 1, 1, 0.8)
    end
    RefreshSwatch()

    swatchBtn:SetScript("OnEnter", function(self)
        self:SetBackdropBorderColor(COLORS.primary[1], COLORS.primary[2], COLORS.primary[3], 1)
    end)
    swatchBtn:SetScript("OnLeave", function(self)
        self:SetBackdropBorderColor(1, 1, 1, 0.8)
    end)

    swatchBtn:SetScript("OnClick", function()
        local c = cfg.color.Mouseover
        OpenColorPicker(c.r, c.g, c.b, c.a,
            function(r, g, b, a) -- onChange
                cfg.color.Mouseover.r = r
                cfg.color.Mouseover.g = g
                cfg.color.Mouseover.b = b
                cfg.color.Mouseover.a = a
                RefreshSwatch()
                SaveConfigNow()
                if nMainbar.UpdateMouseoverColor then nMainbar.UpdateMouseoverColor() end
            end,
            function(r, g, b, a) -- onCancel: restore
                cfg.color.Mouseover.r = r
                cfg.color.Mouseover.g = g
                cfg.color.Mouseover.b = b
                cfg.color.Mouseover.a = a
                RefreshSwatch()
                if nMainbar.UpdateMouseoverColor then nMainbar.UpdateMouseoverColor() end
            end
        )
    end)

    -- Tooltip hint on swatch
    swatchBtn:SetScript("OnEnter", function(self)
        self:SetBackdropBorderColor(COLORS.primary[1], COLORS.primary[2], COLORS.primary[3], 1)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(L["Click to choose color"] or "Klicken um Farbe zu wählen", 1, 1, 1)
        GameTooltip:Show()
    end)
    swatchBtn:SetScript("OnLeave", function(self)
        self:SetBackdropBorderColor(1, 1, 1, 0.8)
        GameTooltip:Hide()
    end)

    -- Reset button
    local resetBtn = CreateModernButton(row, L["Reset"] or "Reset",
        function()
            local def = cfg.defaultMouseoverColor
            cfg.color.Mouseover.r = def.r
            cfg.color.Mouseover.g = def.g
            cfg.color.Mouseover.b = def.b
            cfg.color.Mouseover.a = def.a
            RefreshSwatch()
            SaveConfigNow()
            if nMainbar.UpdateMouseoverColor then nMainbar.UpdateMouseoverColor() end
        end,
        "secondary"
    )
    resetBtn:SetSize(100, 32)
    resetBtn:SetPoint("RIGHT", row, "RIGHT", -8, 0)

    yOffset = yOffset - 62
end

-- ========================================
-- DEVELOPER OPTIONS
-- ========================================

local devHeader = CreateSectionHeader(content, L["Developer Options"] or "Entwickler-Optionen")
devHeader:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
yOffset = yOffset - 45

-- Debug Mode
local debugContainer, debugCheck = CreateModernCheckbox(content,
    L["Enable Debug Mode"] or "Debug-Modus aktivieren",
    L["Show debug messages in chat"] or "Zeige Debug-Nachrichten im Chat",
    function() return cfg.debug or false end,
    function(self)
        cfg.debug = self:GetChecked()
        SaveConfigNow()
    end
)
debugContainer:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
guiElements[debugCheck] = function() return cfg.debug or false end
yOffset = yOffset - 60

-- Dump Texture Info Button
local dumpBtn = CreateModernButton(content,
    L["Dump Texture Info"] or "Textur-Info ausgeben",
    function()
        if nMainbar.DebugButtonTextures then
            nMainbar.DebugButtonTextures()
        end
    end,
    "secondary"
)
dumpBtn:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)
dumpBtn:SetWidth(220)
yOffset = yOffset - 40

-- Debug info text
local debugInfo = content:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
debugInfo:SetPoint("TOPLEFT", content, "TOPLEFT", 12, yOffset)
debugInfo:SetText("|cff888888Debug info will be printed to chat window.\nAlso available via: /nm debug|r")
debugInfo:SetJustifyH("LEFT")
debugInfo:SetWidth(400)
yOffset = yOffset - 40

-- ========================================
-- FOOTER WITH RELOAD WARNING
-- ========================================

local footerInfo = CreateInfoBox(content,
    "⚠ " .. (L["Some changes require /reload to take effect."] or "Some changes require /reload to take effect."),
    "warning"
)
footerInfo:SetPoint("TOPLEFT", content, "TOPLEFT", 0, yOffset)

-- ========================================
-- REGISTRATION AND SLASH COMMANDS
-- ========================================

optionsFrame.name = "nMainbar"
local settingsCategoryID = nil

local function RegisterGUI()
    if Settings and Settings.RegisterCanvasLayoutCategory then
        local category = Settings.RegisterCanvasLayoutCategory(optionsFrame, "nMainbar")
        category:SetParentCategory(Settings.GetCategory("Action Bars"))
        Settings.RegisterAddOnCategory(category)
        settingsCategoryID = category:GetID()
        -- Store in nMainbar for minimap button access
        nMainbar.settingsCategoryID = settingsCategoryID
    else
        optionsFrame.parent = "Action Bars"
        InterfaceOptions_AddCategory(optionsFrame)
    end
end

local guiFrame = CreateFrame("Frame")
guiFrame:RegisterEvent("PLAYER_LOGIN")
guiFrame:SetScript("OnEvent", function()
    RegisterGUI()
    C_Timer.After(1, function()
        ApplyButtonSettings()
    end)
    guiFrame:UnregisterAllEvents()
end)

-- Slash commands
SLASH_NMAINBAR1 = "/nmainbar"
SLASH_NMAINBAR2 = "/nm"
SlashCmdList["NMAINBAR"] = function(msg)
    msg = (msg or ""):lower():trim()
    
    if msg == "debug" then
        if nMainbar.DebugButtonTextures then
            nMainbar.DebugButtonTextures()
        end
        return
    end
    
    if Settings and Settings.OpenToCategory then
        if settingsCategoryID then
            Settings.OpenToCategory(settingsCategoryID)
        else
            local category = Settings.GetCategory("nMainbar")
            if category then
                Settings.OpenToCategory(category:GetID())
            end
        end
    elseif SettingsPanel then
        if SettingsPanel:IsShown() then
            HideUIPanel(SettingsPanel)
        else
            ShowUIPanel(SettingsPanel)
        end
    else
        InterfaceOptionsFrame_OpenToCategory(optionsFrame)
        InterfaceOptionsFrame_OpenToCategory(optionsFrame)
    end
end
