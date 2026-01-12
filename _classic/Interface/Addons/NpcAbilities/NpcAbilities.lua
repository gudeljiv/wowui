local npcAbilitiesFrame = CreateFrame("Frame")
local hotkeyButtonPressed = false
local hideAbilitiesHotkeyButtonPressed = false
local seasonId = C_Seasons.GetActiveSeason()
local checkForHotkeyReleased = false

local priorityColors = {
    [1] = {hex = "ff0000", r = 1, g = 0, b = 0},
    [2] = {hex = "ff9900", r = 1, g = 0.6, b = 0},
    [3] = {hex = "ffcc00", r = 1, g = 0.8, b = 0},
    [4] = {hex = "00ff00", r = 0, g = 1, b = 0}
}

local targetAbilitiesFrame = CreateFrame("Frame", "NpcAbilitiesTargetFrame", UIParent, "BackdropTemplate")
targetAbilitiesFrame:SetPoint("TOPLEFT", TargetFrame, "BOTTOMLEFT", 2.5, 5)
targetAbilitiesFrame:SetSize(200, 50)
targetAbilitiesFrame:SetBackdrop({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true,
    tileSize = 16,
    edgeSize = 12,
    insets = { left = 2, right = 2, top = 2, bottom = 2 }
})
targetAbilitiesFrame:SetBackdropColor(0, 0, 0, 0.8)
targetAbilitiesFrame:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)
targetAbilitiesFrame:Hide()

local targetAbilitiesContent = targetAbilitiesFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
targetAbilitiesContent:SetPoint("TOPLEFT", targetAbilitiesFrame, "TOPLEFT", 8, -8)
targetAbilitiesContent:SetPoint("RIGHT", targetAbilitiesFrame, "RIGHT", -8, 0)
targetAbilitiesContent:SetJustifyH("LEFT")
targetAbilitiesContent:SetJustifyV("TOP")
targetAbilitiesContent:SetWordWrap(true)
targetAbilitiesContent:SetNonSpaceWrap(true)

local function GetDataByID(dataType, dataId)
    local data = _G[dataType]
    if not data then return nil end

    local convertedId = tonumber(dataId)
    if not convertedId then return nil end

    if dataType == "NpcAbilitiesNpcData" then
        return data[convertedId]
    else
        local languageCode = NpcAbilitiesOptions["SELECTED_LANGUAGE"]
        if data[languageCode] then
            return data[languageCode][convertedId]
        end
    end

    return nil
end

local function GetAbilityPriority(spellId)
    local priorityData = _G['NpcAbilitiesPriorityData']
    if priorityData then
        return priorityData[spellId]
    end
    return nil
end

local function SortAbilitiesByPriority(abilities)
    table.sort(abilities, function(a, b)
        local priorityA = GetAbilityPriority(a.id) or 4
        local priorityB = GetAbilityPriority(b.id) or 4
        return priorityA < priorityB
    end)
end

local function AddAbilityLinesToGameTooltip(id, name, description, mechanic, range, castTime, cooldown, dispelType, addedAbilityLine)
    if not addedAbilityLine then
        GameTooltip:AddLine(" ")
    end

    local options = NpcAbilitiesOptions
    local selectedLanguage = options["SELECTED_LANGUAGE"]
    local translations = _G["NpcAbilitiesTranslations"][selectedLanguage]["game"]

    local texture = GetSpellTexture(id)
    local icon = "|T" .. texture .. ":12:12:0:0:64:64:4:60:4:60|t"
    local abilityNameText = icon .. " " .. name

    local function appendTitleInfo(display, value, mode, label)
        if value ~= "" and options[display] then
            local text = " - " .. value
            if options[mode] == "title" then
                abilityNameText = abilityNameText .. text
            end
        end
    end

    appendTitleInfo("DISPLAY_ABILITY_MECHANIC", mechanic, "SELECTED_ABILITY_MECHANIC_DISPLAY_MODE", "mechanicText")
    appendTitleInfo("DISPLAY_ABILITY_RANGE", range, "SELECTED_ABILITY_RANGE_DISPLAY_MODE", "rangeText")
    appendTitleInfo("DISPLAY_ABILITY_CAST_TIME", castTime, "SELECTED_ABILITY_CAST_TIME_DISPLAY_MODE", "castTimeText")
    appendTitleInfo("DISPLAY_ABILITY_COOLDOWN", cooldown, "SELECTED_ABILITY_COOLDOWN_DISPLAY_MODE", "cooldownText")
    appendTitleInfo("DISPLAY_ABILITY_DISPEL_TYPE", dispelType, "SELECTED_ABILITY_DISPEL_TYPE_DISPLAY_MODE", "dispelTypeText")

    if options["DISPLAY_PRIORITY_INDICATORS"] then
        local priority = GetAbilityPriority(id) or 4
        local colors = priorityColors[priority]
        GameTooltip:AddLine(abilityNameText, colors.r, colors.g, colors.b)
    else
        GameTooltip:AddLine(abilityNameText)
    end

    if hotkeyButtonPressed then
        local function addSeparateLine(display, value, mode, labelKey)
            if value ~= "" and options[display] and options[mode] == "separate" then
                GameTooltip:AddLine(translations[labelKey] .. ": " .. value, 1, 1, 1, true)
            end
        end

        addSeparateLine("DISPLAY_ABILITY_MECHANIC", mechanic, "SELECTED_ABILITY_MECHANIC_DISPLAY_MODE", "mechanicText")
        addSeparateLine("DISPLAY_ABILITY_RANGE", range, "SELECTED_ABILITY_RANGE_DISPLAY_MODE", "rangeText")
        addSeparateLine("DISPLAY_ABILITY_CAST_TIME", castTime, "SELECTED_ABILITY_CAST_TIME_DISPLAY_MODE", "castTimeText")
        addSeparateLine("DISPLAY_ABILITY_COOLDOWN", cooldown, "SELECTED_ABILITY_COOLDOWN_DISPLAY_MODE", "cooldownText")
        addSeparateLine("DISPLAY_ABILITY_DISPEL_TYPE", dispelType, "SELECTED_ABILITY_DISPEL_TYPE_DISPLAY_MODE", "dispelTypeText")

        GameTooltip:AddLine(description, 1, 1, 1, true)
    end
end

local function UpdateTargetFrameAbilities()
    local displayLocation = NpcAbilitiesOptions["ABILITY_DISPLAY_LOCATION"] or "both"
    if displayLocation == "tooltip" then
        targetAbilitiesFrame:Hide()
        return
    end

    if not UnitExists("target") then
        targetAbilitiesFrame:Hide()
        return
    end

    local inInstance, _ = IsInInstance()
    if hideAbilitiesHotkeyButtonPressed or (inInstance and NpcAbilitiesOptions["HIDE_ABILITIES_IN_INSTANCE"]) then
        targetAbilitiesFrame:Hide()
        return
    end

    local unitGUID = UnitGUID("target")
    if not unitGUID then
        targetAbilitiesFrame:Hide()
        return
    end

    local unitType, _, _, _, _, npcId = strsplit("-", unitGUID)
    if unitType ~= "Creature" then
        targetAbilitiesFrame:Hide()
        return
    end

    local npcData = GetDataByID('NpcAbilitiesNpcData', npcId)
    if npcData == nil then
        targetAbilitiesFrame:Hide()
        return
    end

    local options = NpcAbilitiesOptions
    local selectedLanguage = options["SELECTED_LANGUAGE"]
    local abilities = {}
    local addedAbilityNames = {}

    for _, classicAbilityId in pairs(npcData.classic_spell_ids) do
        local classicAbilitiesData = GetDataByID('NpcAbilitiesAbilityData', classicAbilityId)

        if classicAbilitiesData ~= nil then
            local name = classicAbilitiesData.name

            if not addedAbilityNames[name] then
                addedAbilityNames[name] = true
                table.insert(abilities, {
                    id = classicAbilityId,
                    name = name,
                    description = classicAbilitiesData.description or ""
                })
            end
        end
    end

    if #abilities == 0 then
        targetAbilitiesFrame:Hide()
        return
    end

    if options["DISPLAY_PRIORITY_INDICATORS"] then
        SortAbilitiesByPriority(abilities)
    end

    local lines = {}
    local hasDescriptions = false
    local translations = _G["NpcAbilitiesTranslations"][selectedLanguage]["game"]

    for _, ability in ipairs(abilities) do
        local texture = GetSpellTexture(ability.id)
        local icon = texture and ("|T" .. texture .. ":14:14:0:0:64:64:4:60:4:60|t") or ""
        local line = icon .. " " .. ability.name

        if options["DISPLAY_PRIORITY_INDICATORS"] then
            local priority = GetAbilityPriority(ability.id) or 4
            local colors = priorityColors[priority]
            line = "|cff" .. colors.hex .. icon .. " " .. ability.name .. "|r"
        end

        table.insert(lines, line)

        if hotkeyButtonPressed and ability.description ~= "" then
            table.insert(lines, "|cffffffff" .. ability.description .. "|r")
        end

        if ability.description ~= "" then
            hasDescriptions = true
        end
    end

    if hasDescriptions and not hotkeyButtonPressed then
        if options["SELECTED_HOTKEY"] then
            local hotkey = options["SELECTED_HOTKEY"]
            local hotkeyText = "|cffaaaaaa(" .. translations["hotkeyExplanatoryTextOne"] .. " " .. hotkey .. " " .. translations["hotkeyExplanatoryTextTwo"] .. ")|r"
            table.insert(lines, hotkeyText)
        else
            table.insert(lines, "|cffaaaaaa(" .. translations["hotkeyNotBoundText"] .. ")|r")
        end
    end

    local text = table.concat(lines, "\n")
    local targetAbilitiesFrameBackDrop = targetAbilitiesFrame:GetBackdrop()

    local frameWidth = TargetFrame:GetWidth() - (targetAbilitiesFrame:GetBackdrop().edgeSize * 2) - 16
    targetAbilitiesFrame:SetWidth(frameWidth)
    targetAbilitiesContent:SetWidth(frameWidth - 16)
    targetAbilitiesContent:SetText(text)

    local textHeight = targetAbilitiesContent:GetStringHeight()
    targetAbilitiesFrame:SetHeight(textHeight + 16)
    targetAbilitiesFrame:Show()
end

local tooltipHookRegistered = false
local SetNpcAbilityData

local targetEventFrame = CreateFrame("Frame")
targetEventFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
targetEventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
targetEventFrame:RegisterEvent("PLAYER_LOGIN")
targetEventFrame:RegisterEvent("ADDON_LOADED")
targetEventFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "NpcAbilities" then
        if NpcAbilitiesOptions["ABILITY_DISPLAY_LOCATION"] == nil then
            NpcAbilitiesOptions["ABILITY_DISPLAY_LOCATION"] = "both"
        end

        if not NpcAbilitiesOptions["DELAYED_TOOLTIP_LOADING"] and not tooltipHookRegistered then
            GameTooltip:HookScript("OnTooltipSetUnit", SetNpcAbilityData)
            tooltipHookRegistered = true
        end
    elseif event == "PLAYER_LOGIN" then
        if NpcAbilitiesOptions["DELAYED_TOOLTIP_LOADING"] then
            C_Timer.After(5, function()
                if not tooltipHookRegistered then
                    GameTooltip:HookScript("OnTooltipSetUnit", SetNpcAbilityData)
                    tooltipHookRegistered = true
                end
            end)
        end
    elseif event == "PLAYER_ENTERING_WORLD" then
        UpdateTargetFrameAbilities()
    elseif event == "PLAYER_TARGET_CHANGED" then
        UpdateTargetFrameAbilities()
    end
end)

SetNpcAbilityData = function()
    local displayLocation = NpcAbilitiesOptions["ABILITY_DISPLAY_LOCATION"] or "both"
    if displayLocation == "target_frame" then
        return
    end

    local inInstance, _ = IsInInstance()

    if hideAbilitiesHotkeyButtonPressed or (inInstance and NpcAbilitiesOptions["HIDE_ABILITIES_IN_INSTANCE"]) then
        return
    end

    local _, unitId = GameTooltip:GetUnit()

    if not unitId then
        return
    end

    local unitGUID = UnitGUID(unitId)

    if not unitGUID then
        return
    end

    local unitType, _, _, _, _, npcId = strsplit("-", unitGUID)

    if unitType ~= "Creature" then
        return
    end

    local npcData = GetDataByID('NpcAbilitiesNpcData', npcId)

    if npcData == nil then
       return
    end

    local abilities = {}
    local addedAbilityNames = {}

    if seasonId == 2 then
        for _, sodAbilityId in pairs(npcData.sod_spell_ids) do
            local sodAbilitiesData = GetDataByID('NpcAbilitiesAbilityData', sodAbilityId)

            if sodAbilitiesData ~= nil then
                local sodAbilityName = sodAbilitiesData.name
                if not addedAbilityNames[sodAbilityName] then
                    addedAbilityNames[sodAbilityName] = true
                    table.insert(abilities, {
                        id = sodAbilityId,
                        name = sodAbilityName,
                        description = sodAbilitiesData.description or "",
                        mechanic = sodAbilitiesData.mechanic or "",
                        range = sodAbilitiesData.range or "",
                        cast_time = sodAbilitiesData.cast_time or "",
                        cooldown = sodAbilitiesData.cooldown or "",
                        dispel_type = sodAbilitiesData.dispel_type or ""
                    })
                end
            end
        end
    end

    for _, classicAbilityId in pairs(npcData.classic_spell_ids) do
        local classicAbilitiesData = GetDataByID('NpcAbilitiesAbilityData', classicAbilityId)

        if classicAbilitiesData ~= nil then
            local classicAbilityName = classicAbilitiesData.name

            if not addedAbilityNames[classicAbilityName] then
                addedAbilityNames[classicAbilityName] = true
                table.insert(abilities, {
                    id = classicAbilityId,
                    name = classicAbilityName,
                    description = classicAbilitiesData.description or "",
                    mechanic = classicAbilitiesData.mechanic or "",
                    range = classicAbilitiesData.range or "",
                    cast_time = classicAbilitiesData.cast_time or "",
                    cooldown = classicAbilitiesData.cooldown or "",
                    dispel_type = classicAbilitiesData.dispel_type or ""
                })
            end
        end
    end

    if #abilities == 0 then
        return
    end

    if NpcAbilitiesOptions["DISPLAY_PRIORITY_INDICATORS"] then
        SortAbilitiesByPriority(abilities)
    end

    local addedAbilityLine = false
    local addedAbilityLineWithDescription = false

    for _, ability in ipairs(abilities) do
        AddAbilityLinesToGameTooltip(ability.id, ability.name, ability.description, ability.mechanic, ability.range, ability.cast_time, ability.cooldown, ability.dispel_type, addedAbilityLine)
        addedAbilityLine = true

        if ability.description ~= '' then
            addedAbilityLineWithDescription = true
        end
    end

    local selectedLanguage = NpcAbilitiesOptions["SELECTED_LANGUAGE"]

    if addedAbilityLineWithDescription and not hotkeyButtonPressed and NpcAbilitiesOptions["SELECTED_HOTKEY"] then
        local hotkey = NpcAbilitiesOptions["SELECTED_HOTKEY"]
        local hotkeyExplanatoryText = "(" .. _G["NpcAbilitiesTranslations"][selectedLanguage]["game"]["hotkeyExplanatoryTextOne"] .. " " .. hotkey .. " " ..  _G["NpcAbilitiesTranslations"][selectedLanguage]["game"]["hotkeyExplanatoryTextTwo"] .. ")"
        GameTooltip:AddLine(hotkeyExplanatoryText, 0.8, 0.8, 0.8)
    end

    if addedAbilityLineWithDescription and not hotkeyButtonPressed and not NpcAbilitiesOptions["SELECTED_HOTKEY"] then
        GameTooltip:AddLine("(" .. _G["NpcAbilitiesTranslations"][selectedLanguage]["game"]["hotkeyNotBoundText"] .. ")", 0.8, 0.8, 0.8)
    end
end

local function CheckHotkeyState()
    local hotkey = NpcAbilitiesOptions["SELECTED_HOTKEY"]

    if not IsKeyDown(hotkey) then
        checkForHotkeyReleased = false
        hotkeyButtonPressed = false
        GameTooltip:SetUnit("mouseover");
        UpdateTargetFrameAbilities()
        npcAbilitiesFrame:SetScript("OnUpdate", nil)
    end
end

local function StartCheckingHotkey()
    checkForHotkeyReleased = true

    npcAbilitiesFrame:SetScript("OnUpdate", function(self, elapsed)
        CheckHotkeyState()
    end)
end

local function SetHotkeyButtonPressed(self, key, eventType)
   if NpcAbilitiesOptions["SELECTED_HOTKEY"] then
       if eventType == "OnKeyDown" and key == NpcAbilitiesOptions["SELECTED_HOTKEY"] then
            if NpcAbilitiesOptions["SELECTED_HOTKEY_MODE"] == "hold" then
                StartCheckingHotkey()
            end

            if hotkeyButtonPressed then
               hotkeyButtonPressed = false
            else
               hotkeyButtonPressed = true
            end

            GameTooltip:SetUnit("mouseover");
            UpdateTargetFrameAbilities()
       end
   end

   if NpcAbilitiesOptions["HIDE_ABILITIES_SELECTED_HOTKEY"] then
       if eventType == "OnKeyDown" and key == NpcAbilitiesOptions["HIDE_ABILITIES_SELECTED_HOTKEY"] then
           if hideAbilitiesHotkeyButtonPressed then
              hideAbilitiesHotkeyButtonPressed = false
           else
              hideAbilitiesHotkeyButtonPressed = true
           end

           GameTooltip:SetUnit("mouseover");
           UpdateTargetFrameAbilities()
       end
   end
end

npcAbilitiesFrame:SetScript("OnKeyDown", function(self, key) SetHotkeyButtonPressed(self, key, "OnKeyDown") end)
npcAbilitiesFrame:SetPropagateKeyboardInput(true)
npcAbilitiesFrame:RegisterEvent("MODIFIER_STATE_CHANGED")
