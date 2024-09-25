local CPF, C, L = unpack(select(2, ...))
local MODULE_NAME = "SkillFilter"

--[==[@debug@
print(CPF.ADDON_NAME, MODULE_NAME)
--@end-debug@]==]


---------------------------------------------
-- CONSTANTS
---------------------------------------------
local BUTTON_HEIGHT = 16
local BUTTON_MARGIN = 0


---------------------------------------------
-- VARIABLES
---------------------------------------------
local previousTradeSkillName = nil


---------------------------------------------
-- UTILITIES
---------------------------------------------
local function trim(str)
   return (str:gsub("^%s*(.-)%s*$", "%1"))
end

local function searchFilterMatches(searchFilter, header, skillNum, shouldSearchMats)
    local headerMatches = header and CPF:strmatch(header:lower(), searchFilter)

    local skillName = GetTradeSkillInfo(skillNum)
    ---START CHANGES
    if skillName == nil then return end
    ---END CHANGES
    local recipeMatches = CPF:strmatch(skillName:lower(), searchFilter)

    local materialMatches = false
    if shouldSearchMats then
        for materialNum = 1, GetTradeSkillNumReagents(skillNum) do
            local materialName = GetTradeSkillReagentInfo(skillNum, materialNum)
            if materialName and CPF:strmatch(materialName:lower(), searchFilter) then
                materialMatches = true
                break
            end
        end
    end

    return headerMatches or recipeMatches or materialMatches
end

local function haveMatsFilterMatches(haveMatsFilter, numAvailable)
    return not haveMatsFilter or ( haveMatsFilter and numAvailable > 0 )
end


---------------------------------------------
-- SEARCH BAR
---------------------------------------------
local function applyFilter(searchFilter, haveMatsFilter, shouldSearchMats)
    local filtered = {}
    local currentHeader = nil
    local currentHeaderIncluded = false
    local currentSelectedSkillIncluded = false
    local firstNonHeaderIndexIncluded = 0 -- used to identify the index of the top of the list

    for i = 1, GetNumTradeSkills(), 1 do
        local skillName, skillType, numAvailable = GetTradeSkillInfo(i)
        if ( skillType == "header" ) then
            currentHeader = {i, GetTradeSkillInfo(i)}
            currentHeaderIncluded = false
            -- add header if it matches filter
            if ( not haveMatsFilter and CPF:strmatch(currentHeader[2]:lower(), searchFilter) ) then
                tinsert(filtered, currentHeader)
                currentHeaderIncluded = true
            end
        elseif ( searchFilterMatches(searchFilter, currentHeader and currentHeader[2] or nil, i, shouldSearchMats)
                and haveMatsFilterMatches(haveMatsFilter, numAvailable) ) then
            -- add header if it wasn't already added (can't add a skill without its header)
            if ( not currentHeaderIncluded ) then
                tinsert(filtered, currentHeader)
                currentHeaderIncluded = true
            end
            tinsert(filtered, {i, GetTradeSkillInfo(i)})
            firstNonHeaderIndexIncluded = firstNonHeaderIndexIncluded == 0 and i or firstNonHeaderIndexIncluded
            currentSelectedSkillIncluded = currentSelectedSkillIncluded or GetTradeSkillSelectionIndex() == i
        end
    end

    CPF:debugf("Filtered %d skills (%d remaining)", GetNumTradeSkills()-#filtered, #filtered)

    -- move selection if current selection is omitted
    if ( not currentSelectedSkillIncluded and firstNonHeaderIndexIncluded > 0 ) then
        CPF:debug("Moving selected skill to #", firstNonHeaderIndexIncluded, GetTradeSkillInfo(firstNonHeaderIndexIncluded))
        TradeSkillFrame_SetSelection(firstNonHeaderIndexIncluded)
    end

    return filtered
end

local function showFilteredSkills()
    if ( not TradeSkillFrame:IsVisible() or GetNumTradeSkills() == 0 ) then
        return
    end

    -- Hide blizzard default filters
    TradeSkillInvSlotDropdown:Hide()
    TradeSkillSubClassDropdown:Hide()

    -- Get the current list of filtered skills
    local searchFilter = trim(TradeSkillFrame.SearchBox:GetText():lower())
    local haveMatsFilter = TradeSkillFrame.HaveMats:GetChecked()
    local shouldSearchMats = TradeSkillFrame.SearchMats:GetChecked()
    local isFiltering = searchFilter ~= "" or haveMatsFilter

    local skills = applyFilter(searchFilter, haveMatsFilter, shouldSearchMats)

    -- Display the filtered skill buttons
    local numTradeSkills = #skills
    local skillOffset = FauxScrollFrame_GetOffset(TradeSkillListScrollFrame);
    if ( numTradeSkills == 0 ) then
        TradeSkillFrameTitleText:SetText(format(TRADE_SKILL_TITLE, GetTradeSkillLine()));
        TradeSkillSkillName:Hide();
        TradeSkillSkillIcon:Hide();
        TradeSkillRequirementLabel:Hide();
        TradeSkillRequirementText:SetText("");
        TradeSkillCollapseAllButton:Disable();
        for i=1, MAX_TRADE_SKILL_REAGENTS, 1 do
            getglobal("TradeSkillReagent"..i):Hide();
        end
    else
        TradeSkillSkillName:Show();
        TradeSkillSkillIcon:Show();
        TradeSkillCollapseAllButton:Enable();
    end

    FauxScrollFrame_Update(TradeSkillListScrollFrame, numTradeSkills, TRADE_SKILLS_DISPLAYED, TRADE_SKILL_HEIGHT, nil, nil, nil, TradeSkillHighlightFrame, 293, 316 );

    TradeSkillHighlightFrame:Hide();
    for i=1, TRADE_SKILLS_DISPLAYED, 1 do
        local index = i + skillOffset;
        local skillButton = getglobal("TradeSkillSkill"..i);
        if ( index <= numTradeSkills ) then
            if ( skills[index] == nil ) then
                print("nil case", i, index)
            end
            local skillIndex, skillName, skillType, numAvailable, isExpanded = unpack(skills[index]);

            -- Set button widths if scrollbar is shown or hidden
            if ( TradeSkillListScrollFrame:IsVisible() ) then
                skillButton:SetWidth(293);
            else
                skillButton:SetWidth(323);
            end
            local color = TradeSkillTypeColor[skillType];
            if ( color ) then
                skillButton:SetNormalFontObject(color.font);
            end

            skillButton:SetID(skillIndex);
            skillButton:Show();
            -- Handle headers
            if ( skillType == "header" ) then
                skillButton:SetText(skillName);
                if ( isExpanded ) then
                    skillButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
                    skillButton:SetDisabledTexture("Interface\\Buttons\\UI-MinusButton-Disabled");
                else
                    skillButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
                    skillButton:SetDisabledTexture("Interface\\Buttons\\UI-PlusButton-Disabled");
                end
                skillButton:SetEnabled(not isFiltering)
                getglobal("TradeSkillSkill"..i.."Highlight"):SetTexture("Interface\\Buttons\\UI-PlusButton-Hilight");
                getglobal("TradeSkillSkill"..i):UnlockHighlight();
            else
                if ( not skillName ) then
                    return;
                end
                skillButton:SetNormalTexture("");
                skillButton:SetDisabledTexture("");
                skillButton:Enable()
                getglobal("TradeSkillSkill"..i.."Highlight"):SetTexture("");
                if ( numAvailable == 0 ) then
                    skillButton:SetText(" "..skillName);
                else
                    skillButton:SetText(" "..skillName.." ["..numAvailable.."]");
                end

                -- Place the highlight and lock the highlight state
                if ( GetTradeSkillSelectionIndex() == skillIndex ) then
                    TradeSkillHighlightFrame:SetPoint("TOPLEFT", "TradeSkillSkill"..i, "TOPLEFT", 0, 0);
                    TradeSkillHighlightFrame:Show();
                    getglobal("TradeSkillSkill"..i):LockHighlight();
                else
                    getglobal("TradeSkillSkill"..i):UnlockHighlight();
                end
            end

        else
            skillButton:Hide();
        end
    end

    -- Set the expand/collapse all button texture
    local numHeaders = 0;
    local notExpanded = 0;
    for i=1, numTradeSkills, 1 do
        if ( skills[i] == nil ) then
            print("nil case", i)
        end
        local skillIndex, skillName, skillType, numAvailable, isExpanded = unpack(skills[i]);
        if ( skillName and skillType == "header" ) then
            numHeaders = numHeaders + 1;
            if ( not isExpanded ) then
                notExpanded = notExpanded + 1;
            end
        end
        if ( GetTradeSkillSelectionIndex() == skillIndex ) then
            -- Set the max makeable items for the create all button
            TradeSkillFrame.numAvailable = numAvailable;
        end
    end
    -- If all headers are not expanded then show collapse button, otherwise show the expand button
    if ( notExpanded ~= numHeaders ) then
        TradeSkillCollapseAllButton.collapsed = nil;
        TradeSkillCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
        TradeSkillCollapseAllButton:SetDisabledTexture("Interface\\Buttons\\UI-MinusButton-Disabled")
    else
        TradeSkillCollapseAllButton.collapsed = 1;
        TradeSkillCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
        TradeSkillCollapseAllButton:SetDisabledTexture("Interface\\Buttons\\UI-PlusButton-Disabled")
    end
    if ( isFiltering) then
        TradeSkillCollapseAllButton:Disable();
    end
end

local function expandAllHeadersWhenFiltering()
    local filter = trim(TradeSkillFrame.SearchBox:GetText():lower())
    local isFiltering = filter ~= "" or TradeSkillFrame.HaveMats:GetChecked()

    if ( isFiltering ) then
        ExpandTradeSkillSubClass(0) -- expand all
    end
end

local function resetFilter()
    TradeSkillFrame.SearchBox:SetText("")
    TradeSkillFrame.SearchBox:ClearFocus()
    TradeSkillFrame.HaveMats:SetChecked(false)
end

local function resetFilterOnTradeSkillChange()
    if ( not TradeSkillFrame:IsVisible() ) then
        return
    end
    if ( previousTradeSkillName ~= GetTradeSkillLine() ) then
        previousTradeSkillName = GetTradeSkillLine();
        resetFilter()
    end
end

---------------------------------------------
-- INITIALIZE
---------------------------------------------
CPF.RegisterCallback(MODULE_NAME, "initialize", function()
    CPF:InitializeOnDemand("Blizzard_TradeSkillUI", function()
        -- Create search bar
        TradeSkillFrame.SearchBox = CreateFrame("EditBox", nil, TradeSkillFrame, "ClassicProfessionFilterSearchBoxTemplate")
        TradeSkillFrame.SearchBox:SetPoint("BOTTOMRIGHT", TradeSkillListScrollFrame, "TOPRIGHT", 23, 3)
        TradeSkillFrame.SearchBox:Show()

        -- Create have mats checkbox
        TradeSkillFrame.HaveMats = CreateFrame("CheckButton", nil, TradeSkillFrame, "ClassicProfessionFilterCheckButtonTemplate")
        if (LeaPlusDB and LeaPlusDB["EnhanceProfessions"] == "On") then -- thank you rumchiller
            TradeSkillFrame.HaveMats:SetPoint("LEFT", TradeSkillFrame.SearchBox, "RIGHT", 8, 0)
        else
            TradeSkillFrame.HaveMats:SetPoint("BOTTOMLEFT", TradeSkillFrame.SearchBox, "TOPLEFT", -40, -3)
        end
        ---START CHANGES
        TradeSkillFrame.HaveMats.Text:SetText(CRAFT_IS_MAKEABLE)
        ---END CHANGES
        TradeSkillFrame.HaveMats.tooltipText = CRAFT_IS_MAKEABLE_TOOLTIP
        TradeSkillFrame.HaveMats:Show()

        -- Create search mats checkbox
        TradeSkillFrame.SearchMats = CreateFrame("CheckButton", nil, TradeSkillFrame, "ClassicProfessionFilterCheckButtonTemplate")
        TradeSkillFrame.SearchMats:SetPoint("LEFT", TradeSkillFrame.HaveMats, "RIGHT", 105, 0)
        ---START CHANGES
        TradeSkillFrame.SearchMats.Text:SetText(L["Search Materials"])
        ---END CHANGES
        TradeSkillFrame.SearchMats.tooltipText = L["Include materials when searching recipes"]
        TradeSkillFrame.SearchMats:Show()

        -- Reset filter when closing window
        TradeSkillFrame:HookScript("OnHide", resetFilter)

        -- Reset filter when change to new skill without closing window
        CPF.RegisterEvent(MODULE_NAME, "TRADE_SKILL_UPDATE", resetFilterOnTradeSkillChange)

        -- Hook displaying to use filters
        hooksecurefunc("TradeSkillFrame_Update", showFilteredSkills)

        -- Expand all headers on filter change
        TradeSkillFrame.SearchBox:HookScript("OnTextChanged", expandAllHeadersWhenFiltering)
        TradeSkillFrame.HaveMats:HookScript("OnClick", expandAllHeadersWhenFiltering)

        -- Apply filter on filter change
        TradeSkillFrame.SearchBox:HookScript("OnTextChanged", showFilteredSkills)
        TradeSkillFrame.HaveMats:HookScript("OnClick", showFilteredSkills)
        TradeSkillFrame.SearchMats:HookScript("OnClick", showFilteredSkills)
    end)
end)
