-- Right click function
local function RuneButtonOnClick(mouseButton, abilityID, equipmentSlot)
	C_Engraving.CastRune(abilityID);

	if mouseButton == "RightButton" then
		if ( IsShiftKeyDown() ) then 
			UseInventoryItem(12);
		else
			if equipmentSlot == 16 then
				UseInventoryItem(15);
			else
				UseInventoryItem(equipmentSlot);
			end
		end

		for i = 1, STATICPOPUP_NUMDIALOGS do
			local popupFrame = _G["StaticPopup" .. i];

			if popupFrame.which == "REPLACE_ENCHANT" and popupFrame:IsVisible() then
				popupFrame.button1:Click();
				break
			end
		end
	end
end

-- Pulls equipped runes
local function GetEquippedRunes()
	local equippedRunes = {};
	local equippedFilterInitialllyEnabled = C_Engraving.IsEquippedFilterEnabled();
	C_Engraving.EnableEquippedFilter(true);

	local categories = C_Engraving.GetRuneCategories(true, true);
	for _, category in ipairs(categories) do
		local runes = C_Engraving.GetRunesForCategory(category, true);
		for _, rune in ipairs(runes) do
			equippedRunes[rune.skillLineAbilityID] = true;
		end
	end
	C_Engraving.EnableEquippedFilter(equippedFilterInitialllyEnabled);
	return equippedRunes;
end

-- Main function. Configures all the buttons
local function UpdateButtons()
	local scrollFrame = EngravingFrame.scrollFrame;
	local buttons = scrollFrame.buttons;
	local offset = HybridScrollFrame_GetOffset(scrollFrame);
	EngravingFrame_HideAllHeaders();
	local equippedRunes = GetEquippedRunes();	
	local numRunes = 0;
	local currOffset = 0;
	local currentHeader = 1;	
	local currButton = 1;
	local prevRowStart = 1;
	local multiRow = 0;
	local categories = C_Engraving.GetRuneCategories(true, true);
	local numHeaders = #categories;
	
	for _, category in ipairs(categories) do
		if currOffset < offset then
			currOffset = currOffset + 1;
		else
			local button = buttons[currButton];
			if button then
				button:Hide();
				header = _G["EngravingFrameHeader"..currentHeader];
				if header then
					if currButton == 1 then
						button:ClearAllPoints();
						button:SetPoint("TOPLEFT", scrollFrame.scrollChild, "TOPLEFT", -2, -1);
						prevRowStart = currButton
					elseif multiRow == 1 then
						button:ClearAllPoints();
						button:SetPoint("TOPLEFT", buttons[prevRowStart], "BOTTOMLEFT",-26, -2);
						prevRowStart = currButton	
						multiRow = 0
					else
						button:ClearAllPoints();
						button:SetPoint("TOPLEFT", buttons[prevRowStart], "BOTTOMLEFT",0, -2);
						prevRowStart = currButton	
					end
					header:SetPoint("BOTTOMLEFT", button, 0 , 0);
					header:SetWidth(38);
					header:Show();
					header:SetParent(button:GetParent());
					header.leftEdge:SetWidth(14);
					header.leftEdge:SetHeight(31);	
					header.leftEdge:SetPoint("LEFT", header.middle, "RIGHT", -18, 5);
					header.name:ClearAllPoints();
					header.name:SetPoint("LEFT", header.leftEdge, "RIGHT", -10, 1);
					header.middle:Hide();
					header.middle:SetHeight(31);	
					header.rightEdge:ClearAllPoints();
					header.rightEdge:SetPoint("LEFT", header.leftEdge, "RIGHT", -5, 0);
					header.rightEdge:SetWidth(15);					
					header.rightEdge:SetHeight(31);	
					
					currentHeader = currentHeader + 1;				
					header.filter = category;
					header.name:SetText(string.sub(C_Item.GetItemInventorySlotInfo(category),0,1));
					header.name:SetWidth(15);
					header.expandedIcon:Hide();
					header.collapsedIcon:Hide();
					button:SetHeight(32);
					button:SetWidth(26);
					currButton = currButton + 1;
				end
			end
		end

		local runes = C_Engraving.GetRunesForCategory(category, true);
		numRunes = numRunes + #runes;
		for runeIndex, rune in ipairs(runes) do
			if currOffset < offset then
				currOffset = currOffset + 1;
			else
				local button = buttons[currButton];
				if button then
					button:SetScript("OnClick", function(_, mouseButton)
						RuneButtonOnClick(mouseButton, rune.skillLineAbilityID, rune.equipmentSlot);
					end);
					button:SetHeight(32);
					button:SetWidth(32);
					button.name:Hide();
					button.typeName:Hide();
					button.icon:SetTexture(rune.iconTexture);
					button.icon:SetSize(30,30)
					button.tooltipName = rune.name;
					button.name:SetText(rune.name);
					button.skillLineAbilityID = rune.skillLineAbilityID;
					button.disabledBG:Hide();
					button.selectedTex:Hide();
					if equippedRunes[rune.skillLineAbilityID] then
						button.checkedTexture:Show();
					else
						button.checkedTexture:Hide();
					end

					button:ClearAllPoints();
					if runeIndex == 6 then
						button:SetPoint("TOPLEFT", buttons[currButton - 5], "BOTTOMLEFT",0, 1);
						prevRowStart = currButton
						multiRow = 1						
					else
					button:SetPoint("LEFT", buttons[currButton - 1], "RIGHT");
					end
					button:Show();				
					currButton = currButton + 1;
				end
			end
		end
	end
	
	while currButton < #buttons do
		buttons[currButton]:Hide();
		currButton = currButton + 1;
	end

	if numHeaders == 0 and numRunes == 0 then
		scrollFrame.emptyText:Show();
	else
		scrollFrame.emptyText:Hide();
	end
	
	EngravingFrame_UpdateCollectedLabel(EngravingFrame);
end

-- adds additional buttons
local function AddMoreButtons()
	local scrollFrame = EngravingFrame.scrollFrame;
	local buttons = scrollFrame.buttons;
	local parentName = scrollFrame:GetName();
	local buttonName = parentName and (parentName .. "Button") or nil;
	for i = #buttons, 60 do
		local button = CreateFrame("BUTTON", buttonName and (buttonName .. 1) or nil, scrollFrame.scrollChild, "RuneSpellButtonTemplate");
		button.disabledBG:Hide();
		button.selectedTex:Hide();
		button:Hide();
		tinsert(buttons, button);
	end
end

-- adds glow to the buttons
local function AddCheckedTextures()
	local buttons = EngravingFrame.scrollFrame.buttons;
	for _, button in ipairs(buttons) do
		button.checkedTexture = button:CreateTexture(nil, "OVERLAY");
		button.checkedTexture:SetAllPoints(button);
		button.checkedTexture:SetTexture("Interface\\Buttons\\CheckButtonHilight");
		button.checkedTexture:SetBlendMode("ADD");
		button.checkedTexture:Hide();
	end
end

--handles frame and events
local function EventHandler(self, event, addonName)
	if event == "ADDON_LOADED" and addonName == "Blizzard_EngravingUI" then
		EngravingFrameScrollFrameScrollBar.doNotHide = false
		EngravingFrameScrollFrameScrollBar.Show = function() end
		EngravingFrameScrollFrameScrollBar:Hide();
		EngravingFrameSideInsetBackground:SetWidth(190);
		EngravingFrameScrollFrameScrollChild:SetWidth(190);
		EngravingFrameScrollFrame:ClearAllPoints();
		EngravingFrameScrollFrame:SetPoint("TOPLEFT", EngravingFrameSideInset, "TOPLEFT",5, -3);
		EngravingFrameScrollFrame:SetWidth(190);
		EngravingFrameCollectedFrame:ClearAllPoints();
		EngravingFrameCollectedFrame:SetPoint("TOPLEFT", EngravingFrameScrollFrame, "BOTTOMLEFT", 0, 10);
		AddMoreButtons();
		AddCheckedTextures();	
		hooksecurefunc("EngravingFrame_UpdateRuneList", UpdateButtons);
	elseif event == "RUNE_UPDATED" then
		if EngravingFrame then
			UpdateButtons();
		end
	end
end

local frame = CreateFrame("Frame");
frame:RegisterEvent("ADDON_LOADED");
frame:RegisterEvent("RUNE_UPDATED");
frame:SetScript("OnEvent", EventHandler);

