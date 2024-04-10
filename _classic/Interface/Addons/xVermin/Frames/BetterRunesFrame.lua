RUNE_BUTTON_HEIGHT = 40;
RUNE_HEADER_BUTTON_HEIGHT = 23;

local function RuneButtonOnClick(mouseButton, abilityID, equipmentSlot)
	C_Engraving.CastRune(abilityID);

	if mouseButton == "RightButton" then
		UseInventoryItem(equipmentSlot);

		for i = 1, STATICPOPUP_NUMDIALOGS do
			local popupFrame = _G["StaticPopup" .. i];

			if popupFrame.which == "REPLACE_ENCHANT" and popupFrame:IsVisible() then
				popupFrame.button1:Click();
				break
			end
		end
	end
end

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

local function UpdateButtons()
	local scrollFrame = EngravingFrame.scrollFrame;
	local buttons = scrollFrame.buttons;
	local offset = HybridScrollFrame_GetOffset(scrollFrame);
	EngravingFrame_HideAllHeaders();
	local equippedRunes = GetEquippedRunes();

	local categories = C_Engraving.GetRuneCategories(true, true);
	local numHeaders = #categories;

	local numRows = 0;
	local currentOffset = 0;
	local currentHeader = 1;
	local currentButton = 1;
	local prevRowStart = 1;

	for _, category in ipairs(categories) do
		if currentOffset < offset then
			currentOffset = currentOffset + 1;
		else
			local button = buttons[currentButton];
			if button then
				header = _G["EngravingFrameHeader" .. currentHeader];
				if header then
					if prevRowStart > 1 then
						button:ClearAllPoints();
						button:SetPoint("TOPLEFT", buttons[prevRowStart], "BOTTOMLEFT");
					end
					prevRowStart = currentButton;
					header:ClearAllPoints();
					header:SetPoint("BOTTOMLEFT", button, 0, 0);
					header:Show();
					currentHeader = currentHeader + 1;
					currentButton = currentButton + 1;
				end
			end
		end

		local runes = C_Engraving.GetRunesForCategory(category, true);
		for runeIndex, rune in ipairs(runes) do
			if currentOffset < offset then
				currentOffset = currentOffset + 1;
			else
				local button = buttons[currentButton];
				if button then
					button:CreateBeautyBorder(8)
					-- _G[button:GetName() .. 'Highlight']:Hide()

					button:SetScript("OnClick", function(_, mouseButton)
						RuneButtonOnClick(mouseButton, rune.skillLineAbilityID, rune.equipmentSlot);
					end);

					button.name:Hide();
					button.typeName:Hide();
					button:SetWidth(RUNE_BUTTON_HEIGHT);

					button.checkedTexture:Hide();
					button.icon:Hide()

					if not button.texture then 
						button.texture = button:CreateTexture(nil, 'BACKGROUND')
						button.texture:SetSize(button:GetSize())
						button.texture:SetPoint('CENTER')
					end
					button.texture:SetTexture(rune.iconTexture)

					if equippedRunes[rune.skillLineAbilityID] then
						button:SetBeautyBorderTexture('Interface\\AddOns\\xVermin\\media\\textureWhite')
						button:SetBeautyBorderColor(0, 1, 0)
						button.texture:SetDrawLayer("ARTWORK", 7)
						-- button.checkedTexture:Show();
						-- EngravingFrameScrollFrameButton3Icon:Hide()
					else
						button:SetBeautyBorderTexture('Interface\\AddOns\\xVermin\\media\\textureNormal')
						button:SetBeautyBorderColor(1, 1, 1)
						button.texture:SetDrawLayer("ARTWORK", -8)
						-- button.checkedTexture:Hide();
					end
					button:ClearAllPoints();
					if runeIndex % 4 == 1 then
						button:SetPoint("TOPLEFT", buttons[prevRowStart], "BOTTOMLEFT");
						prevRowStart = currentButton;
						numRows = numRows + 1;
					else
						button:SetPoint("LEFT", buttons[currentButton - 1], "RIGHT");
					end
					button:Show();

					-- button:SetScript('OnEnter', function() 
					-- 	button:SetBeautyBorderColor(0, 1, 0) 
					-- 	button.texture:SetDrawLayer("ARTWORK", 7)
					-- end)
					-- button:SetScript('OnLeave', function() 
					-- 	button:SetBeautyBorderColor(1, 1, 0) 
					-- 	button.texture:SetDrawLayer("ARTWORK", 7)
					-- end)
					
					currentButton = currentButton + 1;
				end
			end
		end
	end

	while currentButton <= #buttons do
		buttons[currentButton]:Hide();
		currentButton = currentButton + 1;
	end

	local totalHeight = numRows * RUNE_BUTTON_HEIGHT;
	totalHeight = totalHeight + (numHeaders * RUNE_HEADER_BUTTON_HEIGHT);
	HybridScrollFrame_Update(scrollFrame, totalHeight, 20);
end

local function AddMoreButtons()
	local scrollFrame = EngravingFrame.scrollFrame;
	local buttons = scrollFrame.buttons;
	local parentName = scrollFrame:GetName();
	local buttonName = parentName and (parentName .. "Button") or nil;

	for i = #buttons, 25 do
		local button = CreateFrame("BUTTON", buttonName and (buttonName .. 1) or nil, scrollFrame.scrollChild, "RuneSpellButtonTemplate");
		button.disabledBG:Hide();
		button.selectedTex:Hide();
		button:Hide();
		tinsert(buttons, button);
	end
end

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

local function EventHandler(self, event, addonName)
	if event == "ADDON_LOADED" and addonName == "Blizzard_EngravingUI" then
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

