local CPF, C, L = unpack(select(2, ...))
local MODULE_NAME = "CraftFilter"
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
local previousCraftName = nil
---------------------------------------------
-- UTILITIES
---------------------------------------------
local function trim(str)
  return (str:gsub("^%s*(.-)%s*$", "%1"))
end

local function searchFilterMatches(searchFilter, header, craftNum, shouldSearchMats)
  local headerMatches = header and CPF:strmatch(header:lower(), searchFilter)
  local craftName = GetCraftInfo(craftNum)
  local recipeMatches = CPF:strmatch(craftName:lower(), searchFilter)
  local materialMatches = false
  if shouldSearchMats then
    for materialNum = 1, GetCraftNumReagents(craftNum) do
      local materialName = GetCraftReagentInfo(craftNum, materialNum)
      if materialName and CPF:strmatch(materialName:lower(), searchFilter) then
        materialMatches = true
        break
      end
    end
  end
  return headerMatches or recipeMatches or materialMatches
end

local function haveMatsFilterMatches(haveMatsFilter, numAvailable)
  return not haveMatsFilter or (haveMatsFilter and numAvailable > 0)
end


---------------------------------------------
-- SEARCH BAR
---------------------------------------------
local function applyFilter(searchFilter, haveMatsFilter, shouldSearchMats)
  local filtered = {}
  local currentHeader = nil
  local currentHeaderIncluded = false
  local currentSelectedSkillIncluded = false
  local firstNonHeaderIndexIncluded = 0   -- used to identify the index of the top of the list
  for i = 1, GetNumCrafts(), 1 do
    local craftName, _, craftType, numAvailable = GetCraftInfo(i)
    if (craftType == "header") then
      currentHeader = { i, GetCraftInfo(i) }
      currentHeaderIncluded = false
      -- add header if it matches filter
      if (not haveMatsFilter and CPF:strmatch(currentHeader[2]:lower(), searchFilter)) then
        tinsert(filtered, currentHeader)
        currentHeaderIncluded = true
      end
    elseif (searchFilterMatches(searchFilter, currentHeader and currentHeader[2] or nil, i, shouldSearchMats)
          and haveMatsFilterMatches(haveMatsFilter, numAvailable)) then
      -- add header if it wasn't already added (can't add a skill without its header)
      if (not currentHeaderIncluded) then
        tinsert(filtered, currentHeader)
        currentHeaderIncluded = true
      end
      tinsert(filtered, { i, GetCraftInfo(i) })
      firstNonHeaderIndexIncluded = firstNonHeaderIndexIncluded == 0 and i or firstNonHeaderIndexIncluded
      currentSelectedSkillIncluded = currentSelectedSkillIncluded or GetCraftSelectionIndex() == i
    end
  end
  CPF:debugf("Filtered %d crafts (%d remaining)", GetNumCrafts() - #filtered, #filtered)
  -- move selection if current selection is omitted
  if (not currentSelectedSkillIncluded and firstNonHeaderIndexIncluded > 0) then
    CPF:debug("Moving selected craft to #", firstNonHeaderIndexIncluded, GetCraftInfo(firstNonHeaderIndexIncluded))
    CraftFrame_SetSelection(firstNonHeaderIndexIncluded)
  end
  return filtered
end

local function showFilteredCrafts()
  if (not CraftFrame:IsVisible() or GetNumCrafts() == 0) then
    return
  end
  -- Get the current list of filtered crafts
  local searchFilter = trim(CraftFrame.SearchBox:GetText():lower())
  local haveMatsFilter = CraftFrame.HaveMats:GetChecked()
  local shouldSearchMats = CraftFrame.SearchMats:GetChecked()
  local isFiltering = searchFilter ~= "" or haveMatsFilter
  local crafts = applyFilter(searchFilter, haveMatsFilter, shouldSearchMats)
  -- Display the filtered crafts buttons
  SetPortraitTexture(CraftFramePortrait, "player")
  CraftFrameTitleText:SetText(GetCraftName())
  local numCrafts = #crafts
  local craftOffset = FauxScrollFrame_GetOffset(CraftListScrollFrame)
  -- Set the action button text
  CraftCreateButton:SetText(getglobal(GetCraftButtonToken()))
  -- Set the craft skill line status bar info
  local name, rank, maxRank = GetCraftDisplaySkillLine()
  if (name) then
    CraftRankFrameSkillName:SetText(name)
    CraftRankFrame:SetStatusBarColor(0.0, 0.0, 1.0, 0.5)
    CraftRankFrameBackground:SetVertexColor(0.0, 0.0, 0.75, 0.5)
    CraftRankFrame:SetMinMaxValues(0, maxRank)
    CraftRankFrame:SetValue(rank)
    CraftRankFrameSkillRank:SetText(rank .. "/" .. maxRank)
    CraftRankFrame:Show()
    CraftSkillBorderLeft:Show()
    CraftSkillBorderRight:Show()
  else
    CraftRankFrame:Hide()
    CraftSkillBorderLeft:Hide()
    CraftSkillBorderRight:Hide()
  end
  -- Hide the expand all button if less than 2 crafts learned
  if (numCrafts <= 1) then
    CraftExpandButtonFrame:Hide()
  else
    CraftExpandButtonFrame:Show()
  end
  -- If no Crafts
  if (numCrafts == 0) then
    CraftName:Hide()
    CraftRequirements:Hide()
    CraftIcon:Hide()
    CraftReagentLabel:Hide()
    CraftDescription:Hide()
    for i = 1, MAX_CRAFT_REAGENTS, 1 do
      getglobal("CraftReagent" .. i):Hide()
    end
    CraftDetailScrollFrameScrollBar:Hide()
    CraftDetailScrollFrameTop:Hide()
    CraftDetailScrollFrameBottom:Hide()
    CraftListScrollFrame:Hide()
    for i = 1, CRAFTS_DISPLAYED, 1 do
      getglobal("Craft" .. i):Hide()
    end
    CraftHighlightFrame:Hide()
    CraftRequirements:Hide()
    return
  end
  -- If has crafts
  CraftName:Show()
  CraftRequirements:Show()
  CraftIcon:Show()
  CraftDescription:Show()
  CraftCollapseAllButton:Enable()
  -- ScrollFrame update
  FauxScrollFrame_Update(CraftListScrollFrame, numCrafts, CRAFTS_DISPLAYED, CRAFT_SKILL_HEIGHT, nil, nil, nil, CraftHighlightFrame, 293, 316)
  CraftHighlightFrame:Hide()
  local craftButton, craftButtonSubText, craftButtonCost, craftButtonText
  for i = 1, CRAFTS_DISPLAYED, 1 do
    local index = i + craftOffset
    craftButton = getglobal("Craft" .. i)
    craftButtonSubText = getglobal("Craft" .. i .. "SubText")
    craftButtonCost = getglobal("Craft" .. i .. "Cost")
    craftButtonText = getglobal("Craft" .. i .. "Text")
    if (index <= numCrafts) then
      local craftIndex, craftName, craftSubSpellName, craftType, numAvailable, isExpanded, trainingPointCost, requiredLevel = unpack(crafts[index])
      -- Set button widths if scrollbar is shown or hidden
      if (CraftListScrollFrame:IsVisible()) then
        craftButton:SetWidth(293)
        -- HACK to fix a bug with (Rank) rendering in Beast Training --
        if (not trainingPointCost) then
          craftButtonText:SetWidth(290)
        end
      else
        craftButton:SetWidth(323)
        -- HACK to fix a bug with (Rank) rendering in Beast Training --
        if (not trainingPointCost) then
          craftButtonText:SetWidth(320)
        end
      end
      local color = CraftTypeColor[craftType]
      craftButton:SetNormalFontObject(color.font)
      craftButtonCost:SetTextColor(color.r, color.g, color.b)
      Craft_SetSubTextColor(craftButton, color.r, color.g, color.b)
      craftButton:SetID(craftIndex)
      craftButton:Show()
      -- Handle headers
      if (craftType == "header") then
        craftButton:SetText(craftName)
        craftButtonSubText:SetText("")
        if (isExpanded) then
          craftButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up")
          craftButton:SetDisabledTexture("Interface\\Buttons\\UI-MinusButton-Disabled")
        else
          craftButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")
          craftButton:SetDisabledTexture("Interface\\Buttons\\UI-PlusButton-Disabled")
        end
        craftButton:SetEnabled(not isFiltering)
        getglobal("Craft" .. i .. "Highlight"):SetTexture("Interface\\Buttons\\UI-PlusButton-Hilight")
        getglobal("Craft" .. i):UnlockHighlight()
      else
        craftButton:ClearNormalTexture()
        -- getglobal("Craft"..i.."Highlight"):ClearTexture();
        if (numAvailable == 0) then
          craftButton:SetText(" " .. craftName)
        else
          craftButton:SetText(" " .. craftName .. " [" .. numAvailable .. "]")
        end
        if (craftSubSpellName and craftSubSpellName ~= "") then
          craftButtonSubText:SetText(format(PARENS_TEMPLATE, craftSubSpellName))
        else
          craftButtonSubText:SetText("")
        end
        if (trainingPointCost > 0) then
          craftButtonCost:SetText(format(PARENS_TEMPLATE --[[TRAINER_LIST_TP]], trainingPointCost))
        else
          craftButtonCost:SetText("")
        end
        craftButtonSubText:SetPoint("LEFT", "Craft" .. i .. "Text", "RIGHT", 10, 0)
        -- Place the highlight and lock the highlight state
        if (GetCraftSelectionIndex() == craftIndex) then
          CraftHighlightFrame:SetPoint("TOPLEFT", "Craft" .. i, "TOPLEFT", 0, 0)
          CraftHighlightFrame:Show()
          Craft_SetSubTextColor(craftButton, 1.0, 1.0, 1.0)
          craftButtonCost:SetTextColor(1.0, 1.0, 1.0)
          getglobal("Craft" .. i):LockHighlight()
        else
          getglobal("Craft" .. i):UnlockHighlight()
        end
      end
    else
      craftButton:Hide()
    end
  end
  -- If player has training points show them here
  Craft_UpdateTrainingPoints()
  -- Set the expand/collapse all button texture
  local numHeaders = 0
  local notExpanded = 0
  for i = 1, numCrafts, 1 do
    local craftIndex, craftName, craftSubSpellName, craftType, numAvailable, isExpanded = unpack(crafts[i])
    if (craftName and craftType == "header") then
      numHeaders = numHeaders + 1
      if (not isExpanded) then
        notExpanded = notExpanded + 1
      end
    end
  end
  -- If all headers are not expanded then show collapse button, otherwise show the expand button
  if (notExpanded ~= numHeaders) then
    CraftCollapseAllButton.collapsed = nil
    CraftCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up")
    CraftCollapseAllButton:SetDisabledTexture("Interface\\Buttons\\UI-MinusButton-Disabled")
  else
    CraftCollapseAllButton.collapsed = 1
    CraftCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")
    CraftCollapseAllButton:SetDisabledTexture("Interface\\Buttons\\UI-PlusButton-Disabled")
  end
  if (isFiltering) then
    CraftCollapseAllButton:Disable()
  end
  -- If has headers show the expand all button
  if (numHeaders > 0) then
    -- If has headers then move all the names to the right
    for i = 1, CRAFTS_DISPLAYED, 1 do
      getglobal("Craft" .. i .. "Text"):SetPoint("TOPLEFT", "Craft" .. i, "TOPLEFT", 21, 0)
    end
    CraftExpandButtonFrame:Show()
  else
    -- If no headers then move all the names to the left
    for i = 1, CRAFTS_DISPLAYED, 1 do
      getglobal("Craft" .. i .. "Text"):SetPoint("TOPLEFT", "Craft" .. i, "TOPLEFT", 3, 0)
    end
    CraftExpandButtonFrame:Hide()
  end
end

local function expandAllHeadersWhenFiltering()
  local filter = trim(CraftFrame.SearchBox:GetText():lower())
  local isFiltering = filter ~= "" or CraftFrame.HaveMats:GetChecked()
  if (isFiltering) then
    ExpandCraftSkillLine(0)     -- expand all
  end
end

local function resetFilter()
  CraftFrame.SearchBox:SetText("")
  CraftFrame.SearchBox:ClearFocus()
  CraftFrame.HaveMats:SetChecked(false)
end

local function resetFilterOnCraftChange()
  if (not CraftFrame:IsVisible()) then
    return
  end
  if (previousCraftName ~= GetCraftDisplaySkillLine()) then
    previousCraftName = GetCraftDisplaySkillLine()
    resetFilter()
  end
end


---------------------------------------------
-- INITIALIZE
---------------------------------------------
CPF.RegisterCallback(MODULE_NAME, "initialize", function ()
  CPF:InitializeOnDemand("Blizzard_CraftUI", function ()
    -- Create search bar
    CraftFrame.SearchBox = CreateFrame("EditBox", nil, CraftFrame, "ClassicProfessionFilterSearchBoxTemplate")
    ---START CHANGES
    if CTradeSkillDB then
      CraftFrame.SearchBox:SetPoint("BOTTOMRIGHT", CraftListScrollFrame, "TOPRIGHT", 0, -22)
    else
      CraftFrame.SearchBox:SetPoint("BOTTOMRIGHT", CraftListScrollFrame, "TOPRIGHT", 23, 3)
    end
    ---END CHANGES
    CraftFrame.SearchBox:Show()
    -- Create have mats checkbox
    CraftFrame.HaveMats = CreateFrame("CheckButton", nil, CraftFrame, "ClassicProfessionFilterCheckButtonTemplate")
    if (LeaPlusDB and LeaPlusDB["EnhanceProfessions"] == "On") then     -- thank you rumchiller
      CraftFrame.HaveMats:SetPoint("LEFT", CraftFrame.SearchBox, "RIGHT", 8, 0)
    else
      CraftFrame.HaveMats:SetPoint("BOTTOMLEFT", CraftFrame.SearchBox, "TOPLEFT", -40, -3)
    end
    ---START CHANGES
    CraftFrame.HaveMats.Text:SetText(CRAFT_IS_MAKEABLE)
    ---END CHANGES
    CraftFrame.HaveMats.tooltipText = CRAFT_IS_MAKEABLE_TOOLTIP
    CraftFrame.HaveMats:Show()
    -- Create search mats checkbox
    CraftFrame.SearchMats = CreateFrame("CheckButton", nil, CraftFrame, "ClassicProfessionFilterCheckButtonTemplate")
    CraftFrame.SearchMats:SetPoint("LEFT", CraftFrame.HaveMats, "RIGHT", 105, 0)
    ---START CHANGES
    CraftFrame.SearchMats.Text:SetText(L["Search Materials"])
    ---END CHANGES
    CraftFrame.SearchMats.tooltipText = L["Include materials when searching recipes"]
    CraftFrame.SearchMats:Show()
    -- Reset filter when closing window
    CraftFrame:HookScript("OnHide", resetFilter)
    -- Reset filter when change to new craft without closing window
    CPF.RegisterEvent(MODULE_NAME, "CRAFT_UPDATE", resetFilterOnCraftChange)
    -- Hook displaying to use filters
    hooksecurefunc("CraftFrame_Update", showFilteredCrafts)
    -- Expand all headers on filter change
    CraftFrame.SearchBox:HookScript("OnTextChanged", expandAllHeadersWhenFiltering)
    CraftFrame.HaveMats:HookScript("OnClick", expandAllHeadersWhenFiltering)
    -- Apply filter on filter change
    CraftFrame.SearchBox:HookScript("OnTextChanged", showFilteredCrafts)
    CraftFrame.HaveMats:HookScript("OnClick", showFilteredCrafts)
    CraftFrame.SearchMats:HookScript("OnClick", showFilteredCrafts)
  end)
end)
