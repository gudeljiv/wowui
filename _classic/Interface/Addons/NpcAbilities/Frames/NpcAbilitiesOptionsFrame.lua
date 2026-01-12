local addonName = ...
local optionsFrame = CreateFrame("Frame")
local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")
local gameLocale = GetLocale()
local gameLanguage = gameLocale:sub(1, 2)
local defaultOptions = nil
local optionsTranslations = nil

-- General functions
local function CreateOptionDropdown(parent, relativeFrame, offsetX, offsetY, label, defaultValueLabel, optionKey, selectedKey, translationKey)
    local dropdownLabel = parent:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    dropdownLabel:SetText(label)
    dropdownLabel:SetPoint("TOPLEFT", relativeFrame, "TOPLEFT", offsetX, offsetY - 10)

    local dropdown = LibDD:Create_UIDropDownMenu(nil, parent)
    dropdown:SetPoint("TOPLEFT", dropdownLabel, "BOTTOMLEFT", -20, -4)

    local selectedOptionLabel = defaultValueLabel

    LibDD:UIDropDownMenu_Initialize(dropdown, function(self, level, menuList)
        local info = LibDD:UIDropDownMenu_CreateInfo()

        local function OnDropdownValueChanged(self, arg1, arg2, checked)
            NpcAbilitiesOptions[selectedKey] = arg1
            UIDropDownMenu_SetText(dropdown, arg2)
        end

        for index, value in ipairs(NpcAbilitiesOptions[optionKey]) do
            info.text = optionsTranslations[translationKey][value.value]
            info.value = value.value
            info.arg1 = info.value
            info.arg2 = info.text
            info.checked = NpcAbilitiesOptions[selectedKey] == value.value
            info.func = OnDropdownValueChanged
            info.minWidth = 150

            if info.checked then
                selectedOptionLabel = optionsTranslations[translationKey][value.value]
            end

            LibDD:UIDropDownMenu_AddButton(info)
        end
    end)

    LibDD:UIDropDownMenu_SetWidth(dropdown, 150)
    UIDropDownMenu_SetText(dropdown, selectedOptionLabel)
    UIDropDownMenu_SetAnchor(dropdown, 0, 0, "TOPLEFT", dropdown)
    return dropdown
end

local function CreateCheckBox(parent, text, optionKey, onClick)
    local checkbox = CreateFrame("CheckButton", nil, parent, "InterfaceOptionsCheckButtonTemplate")
    checkbox.Text:SetText(text)

    if gameLanguage == "ru" then
        checkbox.Text:SetFont("Fonts\\Arial__.TTF", 12, "OUTLINE")
    elseif gameLanguage == "cn" then
        checkbox.Text:SetFont("Fonts\\ARKai_T.TTF", 12, "OUTLINE")
    elseif gameLanguage == "ko" then
        checkbox.Text:SetFont("Fonts\\2002.TTF", 12, "OUTLINE")
    else
        checkbox.Text:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
    end


    checkbox.Text:SetPoint("LEFT", 30, 0)
    checkbox:SetScript("OnClick", onClick)
    checkbox:SetChecked(NpcAbilitiesOptions[optionKey])
    return checkbox
end

local function CreateHotkeyButton(parent, label, optionKey)
    local description = parent:CreateFontString(nil, "ARTWORK", "GameFontnormalSmall")
    description:SetText(label)

    local button = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    button:SetWidth(120)
    button:SetHeight(25)

    local function UpdateHotkeyButton()
        if NpcAbilitiesOptions[optionKey] then
            button:SetText(NpcAbilitiesOptions[optionKey])
        else
            button:SetText(optionsTranslations["hotkeyButtonNotBoundText"])
        end
    end

    UpdateHotkeyButton()

    local waitingForKey = false

    button:SetScript("OnMouseDown", function(self, buttonPressed)
        if buttonPressed == "LeftButton" then
            if not waitingForKey then
                waitingForKey = true
                button:SetText(optionsTranslations["hotkeyButtonInstructionText"])
            end
        elseif buttonPressed == "RightButton" then
            waitingForKey = false
            button:SetText(optionsTranslations["hotkeyButtonNotBoundText"])
            NpcAbilitiesOptions[optionKey] = nil
        end
    end)

    local function SetHotkey(self, key)
        if waitingForKey then
            NpcAbilitiesOptions[optionKey] = key
            UpdateHotkeyButton()
            waitingForKey = false
        end
    end

    button:SetScript("OnKeyDown", SetHotkey)
    button:SetPropagateKeyboardInput(true)

    return description, button
end

local function getDefaultOptions(optionsTranslations)
    local defaultOptions = {
        SELECTED_LANGUAGE = 'en',
        AVAILABLE_LANGUAGES = {
            {value = 'en', text = optionsTranslations["languages"]["en"]},
            {value = 'es', text = optionsTranslations["languages"]["es"]},
            {value = 'ru', text = optionsTranslations["languages"]["ru"]},
            {value = 'fr', text = optionsTranslations["languages"]["fr"]},
            {value = 'de', text = optionsTranslations["languages"]["de"]},
            {value = 'pt', text = optionsTranslations["languages"]["pt"]},
            {value = 'ko', text = optionsTranslations["languages"]["ko"]},
            {value = 'cn', text = optionsTranslations["languages"]["cn"]}
        },
        SELECTED_HOTKEY = nil,
        SELECTED_HOTKEY_MODE = 'toggle',
        AVAILABLE_HOTKEY_MODES = {
            {value = 'toggle', text = optionsTranslations["hotkeyModes"]["toggle"]},
            {value = 'hold', text = optionsTranslations["hotkeyModes"]["hold"]},
        },
        AVAILABLE_ABILITY_FIELD_DISPLAY_MODES = {
            {value = 'title', text = optionsTranslations["abilityFieldsDisplayModes"]["title"]},
            {value = 'separate', text = optionsTranslations["abilityFieldsDisplayModes"]["separate"]}
        },
        DISPLAY_ABILITY_MECHANIC = true,
        SELECTED_ABILITY_MECHANIC_DISPLAY_MODE = 'title',
        DISPLAY_ABILITY_RANGE = false,
        SELECTED_ABILITY_RANGE_DISPLAY_MODE = 'title',
        DISPLAY_ABILITY_CAST_TIME = false,
        SELECTED_ABILITY_CAST_TIME_DISPLAY_MODE = 'title',
        DISPLAY_ABILITY_COOLDOWN = false,
        SELECTED_ABILITY_COOLDOWN_DISPLAY_MODE = 'title',
        DISPLAY_ABILITY_DISPEL_TYPE = false,
        SELECTED_ABILITY_DISPEL_TYPE_DISPLAY_MODE = 'title',
        HIDE_ABILITIES_SELECTED_HOTKEY = nil,
        HIDE_ABILITIES_IN_INSTANCE = false,
        ABILITY_DISPLAY_LOCATION = "tooltip",
        AVAILABLE_DISPLAY_LOCATIONS = {
            {value = "tooltip", text = optionsTranslations["displayLocations"]["tooltip"]},
            {value = "target_frame", text = optionsTranslations["displayLocations"]["target_frame"]},
            {value = "both", text = optionsTranslations["displayLocations"]["both"]}
        },
        DISPLAY_PRIORITY_INDICATORS = false,
        DELAYED_TOOLTIP_LOADING = false
    }

    return defaultOptions
end

local function InitializeOptions()
    local optionsPanel = CreateFrame("Frame", "NpcAbilitiesOptionsPanel", UIParent)
    optionsPanel.name = "NpcAbilities"

    -- Vars
    local titleOffsetY = -22
    local subTitleOffsetY = -30
    local fieldOffsetX = 25
    local fieldOffsetY = -15

    -- Options panel title
    local panelTitle = optionsPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlightLarge")
    panelTitle:SetPoint("TOPLEFT", optionsPanel, 6, titleOffsetY)
    panelTitle:SetText("NpcAbilities")
    panelTitle:SetTextColor(1, 1, 1)
    panelTitle:SetFont("Fonts\\FRIZQT__.TTF", 20)

    local panelTitleUnderline = optionsPanel:CreateTexture(nil, "ARTWORK")
    panelTitleUnderline:SetColorTexture(1, 1, 1, 0.3)
    panelTitleUnderline:SetPoint("TOPLEFT", panelTitle, "BOTTOMLEFT", 0, -9)
    panelTitleUnderline:SetPoint("TOPRIGHT", optionsPanel, "TOPRIGHT", -16, -31)

    -- Scrollable frame
    local optionsContainerScrollFrame = CreateFrame("ScrollFrame", nil, optionsPanel, "UIPanelScrollFrameTemplate")
    optionsContainerScrollFrame:SetPoint("TOPLEFT", panelTitleUnderline, 0, -10)
    optionsContainerScrollFrame:SetPoint("BOTTOMRIGHT", -38, 30)

    local scrollSpeed = 50

    optionsContainerScrollFrame:EnableMouseWheel(true)
    optionsContainerScrollFrame:SetScript("OnMouseWheel", function(self, delta)
        local newOffset = self:GetVerticalScroll() - (delta * scrollSpeed)
        newOffset = math.max(0, math.min(newOffset, self:GetVerticalScrollRange()))
        self:SetVerticalScroll(newOffset)
    end)

    local optionsContainer = CreateFrame("Frame")
    optionsContainerScrollFrame:SetScrollChild(optionsContainer)
    optionsContainer:SetWidth(UIParent:GetWidth())
    optionsContainer:SetHeight(1)

    -- General options
    local generalOptionsTitle = optionsContainer:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
    generalOptionsTitle:SetPoint("TOPLEFT", 8, titleOffsetY)
    generalOptionsTitle:SetText(optionsTranslations["generalOptionsTitle"])
    generalOptionsTitle:SetTextColor(1, 1, 1)

    -- General options: Language
    local languageDropdown = CreateOptionDropdown(
        optionsContainer,
        generalOptionsTitle,
        fieldOffsetX,
        subTitleOffsetY,
        optionsTranslations["languageDropdownLabel"],
        optionsTranslations["languages"]["en"],
        "AVAILABLE_LANGUAGES",
        "SELECTED_LANGUAGE",
        "languages"
    )

    -- General options: Hotkey
    local hotkeyModeDropdown = CreateOptionDropdown(
        optionsContainer,
        languageDropdown,
        fieldOffsetX - 5,
        subTitleOffsetY,
        optionsTranslations["hotkeyModeLabel"],
        optionsTranslations["hotkeyModes"]["toggle"],
        "AVAILABLE_HOTKEY_MODES",
        "SELECTED_HOTKEY_MODE",
        "hotkeyModes"
    )

    local hotkeyDescription, registerHotkeyButton = CreateHotkeyButton(optionsContainer, optionsTranslations["hotkeyButtonLabel"], "SELECTED_HOTKEY")
    hotkeyDescription:SetPoint("TOPLEFT", hotkeyModeDropdown, "BOTTOMLEFT", fieldOffsetX - 10, fieldOffsetY)
    registerHotkeyButton:SetPoint("TOPLEFT", hotkeyDescription, "TOPLEFT", 0, -12)

    -- General options: Display Location
    local displayLocationDropdown = CreateOptionDropdown(
        optionsContainer,
        registerHotkeyButton,
        5,
        subTitleOffsetY,
        optionsTranslations["displayLocationLabel"] or "Where to display abilities:",
        optionsTranslations["displayLocations"]["both"] or "Both",
        "AVAILABLE_DISPLAY_LOCATIONS",
        "ABILITY_DISPLAY_LOCATION",
        "displayLocations"
    )

    -- General options: Priority Indicators
    local displayPriorityIndicatorsCheckbox = CreateCheckBox(optionsContainer, optionsTranslations["displayPriorityIndicatorsLabel"], "DISPLAY_PRIORITY_INDICATORS", function(self)
        local checked = self:GetChecked()
        NpcAbilitiesOptions["DISPLAY_PRIORITY_INDICATORS"] = checked
    end)
    displayPriorityIndicatorsCheckbox:SetPoint("TOPLEFT", displayLocationDropdown, "BOTTOMLEFT", fieldOffsetX - 10, fieldOffsetY)

    -- Ability fields options
    local abilityFieldsOptionsTitle = optionsContainer:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
    abilityFieldsOptionsTitle:SetPoint("TOPLEFT", displayPriorityIndicatorsCheckbox, "TOPLEFT", -fieldOffsetX + 5, subTitleOffsetY + fieldOffsetY)
    abilityFieldsOptionsTitle:SetText(optionsTranslations["abilityFieldsOptionsTitle"])
    abilityFieldsOptionsTitle:SetTextColor(1, 1, 1)

    -- Ability fields options: Delayed Tooltip Loading
    local delayedTooltipLoadingCheckbox = CreateCheckBox(optionsContainer, optionsTranslations["delayedTooltipLoadingLabel"], "DELAYED_TOOLTIP_LOADING", function(self)
        local checked = self:GetChecked()
        NpcAbilitiesOptions["DELAYED_TOOLTIP_LOADING"] = checked
    end)
    delayedTooltipLoadingCheckbox:SetPoint("TOPLEFT", abilityFieldsOptionsTitle, "BOTTOMLEFT", fieldOffsetX - 5, fieldOffsetY)

    -- Ability fields options: Mechanic
    local displayAbilitiesMechanicCheckbox = CreateCheckBox(optionsContainer, optionsTranslations["displayAbilitiesMechanicLabel"], "DISPLAY_ABILITY_MECHANIC", function(self)
        local checked = self:GetChecked()
        NpcAbilitiesOptions["DISPLAY_ABILITY_MECHANIC"] = checked
    end)
    displayAbilitiesMechanicCheckbox:SetPoint("TOPLEFT", delayedTooltipLoadingCheckbox, "BOTTOMLEFT", 0, fieldOffsetY)

    local mechanicDisplayModeModeDropdown = CreateOptionDropdown(
        optionsContainer,
        displayAbilitiesMechanicCheckbox,
        5,
        subTitleOffsetY,
        optionsTranslations["displayAbilitiesMechanicDisplayModeLabel"],
        optionsTranslations["abilityFieldsDisplayModes"]["title"],
        "AVAILABLE_ABILITY_FIELD_DISPLAY_MODES",
        "SELECTED_ABILITY_MECHANIC_DISPLAY_MODE",
        "abilityFieldsDisplayModes"
    )

    -- Ability fields options: Range
    local displayAbilitiesRangeCheckbox = CreateCheckBox(optionsContainer, optionsTranslations["displayAbilitiesRangeLabel"], "DISPLAY_ABILITY_RANGE", function(self)
        local checked = self:GetChecked()
        NpcAbilitiesOptions["DISPLAY_ABILITY_RANGE"] = checked
    end)
    displayAbilitiesRangeCheckbox:SetPoint("TOPLEFT", mechanicDisplayModeModeDropdown, fieldOffsetX - 10, subTitleOffsetY + fieldOffsetY)

    local rangeDisplayModeModeDropdown = CreateOptionDropdown(
        optionsContainer,
        displayAbilitiesRangeCheckbox,
        5,
        subTitleOffsetY,
        optionsTranslations["displayAbilitiesRangeDisplayModeLabel"],
        optionsTranslations["abilityFieldsDisplayModes"]["title"],
        "AVAILABLE_ABILITY_FIELD_DISPLAY_MODES",
        "SELECTED_ABILITY_RANGE_DISPLAY_MODE",
        "abilityFieldsDisplayModes"
    )

    -- Ability fields options: Cast Time
    local displayAbilitiesCastTimeCheckbox = CreateCheckBox(optionsContainer, optionsTranslations["displayAbilitiesCastTimeLabel"], "DISPLAY_ABILITY_CAST_TIME", function(self)
        local checked = self:GetChecked()
        NpcAbilitiesOptions["DISPLAY_ABILITY_CAST_TIME"] = checked
    end)
    displayAbilitiesCastTimeCheckbox:SetPoint("TOPLEFT", rangeDisplayModeModeDropdown, fieldOffsetX - 10, subTitleOffsetY + fieldOffsetY)

    local castTimeDisplayModeModeDropdown = CreateOptionDropdown(
        optionsContainer,
        displayAbilitiesCastTimeCheckbox,
        5,
        subTitleOffsetY,
        optionsTranslations["displayAbilitiesCastTimeDisplayModeLabel"],
        optionsTranslations["abilityFieldsDisplayModes"]["title"],
        "AVAILABLE_ABILITY_FIELD_DISPLAY_MODES",
        "SELECTED_ABILITY_CAST_TIME_DISPLAY_MODE",
        "abilityFieldsDisplayModes"
    )

    -- Ability fields options: Cooldown
    local displayAbilitiesCooldownCheckbox = CreateCheckBox(optionsContainer, optionsTranslations["displayAbilitiesCooldownLabel"], "DISPLAY_ABILITY_COOLDOWN", function(self)
        local checked = self:GetChecked()
        NpcAbilitiesOptions["DISPLAY_ABILITY_COOLDOWN"] = checked
    end)
    displayAbilitiesCooldownCheckbox:SetPoint("TOPLEFT", castTimeDisplayModeModeDropdown, fieldOffsetX - 10, subTitleOffsetY + fieldOffsetY)

    local cooldownDisplayModeModeDropdown = CreateOptionDropdown(
        optionsContainer,
        displayAbilitiesCooldownCheckbox,
        5,
        subTitleOffsetY,
        optionsTranslations["displayAbilitiesCooldownDisplayModeLabel"],
        optionsTranslations["abilityFieldsDisplayModes"]["title"],
        "AVAILABLE_ABILITY_FIELD_DISPLAY_MODES",
        "SELECTED_ABILITY_COOLDOWN_DISPLAY_MODE",
        "abilityFieldsDisplayModes"
    )

    -- Ability fields options: Dispel Type
    local displayAbilitiesDispelTypeCheckbox = CreateCheckBox(optionsContainer, optionsTranslations["displayAbilitiesDispelTypeLabel"], "DISPLAY_ABILITY_DISPEL_TYPE", function(self)
        local checked = self:GetChecked()
        NpcAbilitiesOptions["DISPLAY_ABILITY_DISPEL_TYPE"] = checked
    end)
    displayAbilitiesDispelTypeCheckbox:SetPoint("TOPLEFT", cooldownDisplayModeModeDropdown, fieldOffsetX - 10, subTitleOffsetY + fieldOffsetY)

    local dispelTypeDisplayModeModeDropdown = CreateOptionDropdown(
        optionsContainer,
        displayAbilitiesDispelTypeCheckbox,
        5,
        subTitleOffsetY,
        optionsTranslations["displayAbilitiesDispelTypeDisplayModeLabel"],
        optionsTranslations["abilityFieldsDisplayModes"]["title"],
        "AVAILABLE_ABILITY_FIELD_DISPLAY_MODES",
        "SELECTED_ABILITY_DISPEL_TYPE_DISPLAY_MODE",
        "abilityFieldsDisplayModes"
    )

    -- Hide options
    local hideOptionsTitle = optionsContainer:CreateFontString("ARTWORK", nil, "GameFontHighlightLarge")
    hideOptionsTitle:SetPoint("TOPLEFT", dispelTypeDisplayModeModeDropdown, "TOPLEFT", -5, subTitleOffsetY + fieldOffsetY)
    hideOptionsTitle:SetText(optionsTranslations["hideOptionsTitle"])
    hideOptionsTitle:SetTextColor(1, 1, 1)

    -- Hide options: Hotkey
    local hideAbilitiesHotkeyDescription, registerHideAbilitiesHotkeyButton = CreateHotkeyButton(optionsContainer, optionsTranslations["hideOptionsHotkeyModeLabel"], "HIDE_ABILITIES_SELECTED_HOTKEY")
    hideAbilitiesHotkeyDescription:SetPoint("TOPLEFT", hideOptionsTitle, "BOTTOMLEFT", fieldOffsetX - 5, fieldOffsetY)
    registerHideAbilitiesHotkeyButton:SetPoint("TOPLEFT", hideAbilitiesHotkeyDescription, "TOPLEFT", 0, -12)

    -- Hide options: Instances
    local hideAbilitiesInInstanceCheckbox = CreateCheckBox(optionsContainer, optionsTranslations["hideAbilitiesInInstanceLabel"], "HIDE_ABILITIES_IN_INSTANCE", function(self)
        local checked = self:GetChecked()
        NpcAbilitiesOptions["HIDE_ABILITIES_IN_INSTANCE"] = checked
    end)
    hideAbilitiesInInstanceCheckbox:SetPoint("TOPLEFT", registerHideAbilitiesHotkeyButton, 0, subTitleOffsetY + fieldOffsetY)

    if InterfaceOptions_AddCategory then
        InterfaceOptions_AddCategory(optionsPanel)
    else
        local category = Settings.RegisterCanvasLayoutCategory(optionsPanel, optionsPanel.name);
        Settings.RegisterAddOnCategory(category);
    end
end

local function addonLoaded(self, event, addonLoadedName)
    if addonLoadedName == addonName then
        optionsTranslations = (_G["NpcAbilitiesTranslations"][gameLanguage] or _G["NpcAbilitiesTranslations"]["en"])["options"]

        defaultOptions = getDefaultOptions(optionsTranslations)
        NpcAbilitiesOptions = NpcAbilitiesOptions or defaultOptions

        for key, value in pairs(defaultOptions) do
            if NpcAbilitiesOptions[key] == nil then
                NpcAbilitiesOptions[key] = value
            end
        end

        InitializeOptions()
    end
end

optionsFrame:RegisterEvent("ADDON_LOADED")
optionsFrame:SetScript("OnEvent", addonLoaded)
