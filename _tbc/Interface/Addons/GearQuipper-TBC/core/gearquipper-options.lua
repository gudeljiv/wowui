-- scope stuff
gearquipper = gearquipper or {};
local c = gearquipper;

local defaultMargin = 10;
local defaultYOffset = 22;

local optionsPanel, scriptsPanel;

local lblFeatures;
local lblSaveChanges, chSaveAlways, chSaveCharMenu, chSaveGqMenu, chSaveNever;
local lblSaveChangesActionSlots, chSaveAlwaysActionSlots, chSaveCharMenuActionSlots, chSaveGqMenuActionSlots, chSaveNeverActionSlots;
local chIgnoreManuallySwitchedItems, chUprankSpells, chUprankSpells_AllRanks;

local lblVisualSettings;
local chHighlightChanges, chConfirmChangesInChat, chShowCurrentSetLabel, chShowItemTooltip, chShowSlotBackgroundColors, chShowBrokerTooltip;
local chNotifyQueues;

local lblSwitchDelay, sldSwitchDelay, lblSwitchDelayHint;

local lblExperimentalSettings;
local chEnableScriptEditor;

local btnReset;

function c:InitOptions()
	c.OPT_VERSION = "OPT_VERSION";
	c.OPT_ACTIONBARS = "OPT_ACTIONBARS";

	c.OPT_MOUNTING_CRUSADER_AURA = "OPT_MOUNTING_CRUSADER_AURA";
	c.OPT_IGNOREMANUALITEMS = "OPT_IGNOREMANUALITEMS";
	c.OPT_AUTOUPRANKSPELLS = "OPT_AUTOUPRANKSPELLS";
	c.OPT_AUTOUPRANKSPELLS_ALLRANKS = "OPT_AUTOUPRANKSPELLS_ALLRANKS";

	c.OPT_SWITCHDELAY = "OPT_SWITCHDELAY";

	c.OPT_NOTIFYCHANGES = "OPT_NOTIFYCHANGES";
	c.OPT_NOTIFYQUEUES = "OPT_NOTIFYQUEUES";
	c.OPT_HIGHLIGHTCHANGES = "OPT_HIGHLIGHTCHANGES";
	c.OPT_SAVECHANGES = "OPT_SAVECHANGES";
	c.OPT_SAVECHANGES_ACTIONSLOTS = "OPT_SAVECHANGES_ACTIONSLOTS";
	c.OPT_SLOTSTATES = "OPT_SLOTSTATES";
	c.OPT_SHOWCURRENTSET = "OPT_SHOWCURRENTSET";
	c.OPT_SHOWITEMTOOLTIP = "OPT_SHOWITEMTOOLTIP";
	c.OPT_SHOWSLOTBACKDROPS = "OPT_SHOWSLOTBACKDROPS";

	c.OPT_SHOWBROKERTOOLTIP = "OPT_SHOWBROKERTOOLTIP";

	c.OPT_MENUOPEN = "OPT_MENUOPEN";

	c.OPT_SCRIPTEDITORENABLED = "OPT_SCRIPTEDITORENABLED";

	c.OPTVALUE_SAVECHANGES_ALWAYS = "OPTVALUE_SAVECHANGES_ALWAYS";
	c.OPTVALUE_SAVECHANGES_CHARMENU = "OPTVALUE_SAVECHANGES_CHARMENU";
	c.OPTVALUE_SAVECHANGES_GQMENU = "OPTVALUE_SAVECHANGES_GQMENU";
	c.OPTVALUE_SAVECHANGES_NEVER = "OPTVALUE_SAVECHANGES_NEVER";

	if GQ_OPTIONS[c.OPT_ACTIONBARS] == nil then
		GQ_OPTIONS[c.OPT_ACTIONBARS] = true;
	end

	if GQ_OPTIONS[c.OPT_NOTIFYCHANGES] == nil then
		GQ_OPTIONS[c.OPT_NOTIFYCHANGES] = true;
	end

	if GQ_OPTIONS[c.OPT_NOTIFYQUEUES] == nil then
		GQ_OPTIONS[c.OPT_NOTIFYQUEUES] = true;
	end

	if GQ_OPTIONS[c.OPT_HIGHLIGHTCHANGES] == nil then
		GQ_OPTIONS[c.OPT_HIGHLIGHTCHANGES] = true;
	end

	if GQ_OPTIONS[c.OPT_SLOTSTATES] == nil then
		GQ_OPTIONS[c.OPT_SLOTSTATES] = false;
	end

	if GQ_OPTIONS[c.OPT_SHOWCURRENTSET] == nil then
		GQ_OPTIONS[c.OPT_SHOWCURRENTSET] = true;
	end

	if GQ_OPTIONS[c.OPT_SHOWITEMTOOLTIP] == nil then
		GQ_OPTIONS[c.OPT_SHOWITEMTOOLTIP] = true;
	end

	if GQ_OPTIONS[c.OPT_SHOWSLOTBACKDROPS] == nil then
		GQ_OPTIONS[c.OPT_SHOWSLOTBACKDROPS] = true;
	end

	if GQ_OPTIONS[c.OPT_SHOWBROKERTOOLTIP] == nil then
		GQ_OPTIONS[c.OPT_SHOWBROKERTOOLTIP] = true;
	end

	if GQ_OPTIONS[c.OPT_MOUNTING_CRUSADER_AURA] == nil then
		GQ_OPTIONS[c.OPT_MOUNTING_CRUSADER_AURA] = true;
	end

	if GQ_OPTIONS[c.OPT_IGNOREMANUALITEMS] == nil then
		GQ_OPTIONS[c.OPT_IGNOREMANUALITEMS] = false;
	end

	if GQ_OPTIONS[c.OPT_AUTOUPRANKSPELLS] == nil then
		GQ_OPTIONS[c.OPT_AUTOUPRANKSPELLS] = true;
	end

	if GQ_OPTIONS[c.OPT_AUTOUPRANKSPELLS_ALLRANKS] == nil then
		GQ_OPTIONS[c.OPT_AUTOUPRANKSPELLS_ALLRANKS] = false;
	end

	if GQ_OPTIONS[c.OPT_SCRIPTEDITORENABLED] == nil then
		GQ_OPTIONS[c.OPT_SCRIPTEDITORENABLED] = false;
	end

	GQ_OPTIONS[c.OPT_SAVECHANGES] = GQ_OPTIONS[c.OPT_SAVECHANGES] or c.OPTVALUE_SAVECHANGES_CHARMENU;
	GQ_OPTIONS[c.OPT_SAVECHANGES_ACTIONSLOTS] = GQ_OPTIONS[c.OPT_SAVECHANGES_ACTIONSLOTS] or c.OPTVALUE_SAVECHANGES_ALWAYS;
	GQ_OPTIONS[c.OPT_SWITCHDELAY] = GQ_OPTIONS[c.OPT_SWITCHDELAY] or 600;

	-- main panel
	optionsPanel = CreateFrame("Frame", "GearQuipper_Options_Main");
	optionsPanel.name = "GearQuipper";
	optionsPanel.okay = function(self) c:SaveOptions(); end;
	optionsPanel.margin = defaultMargin;
	optionsPanel.elementIndex = 1;
	optionsPanel.checkboxYOffset = defaultYOffset;
	InterfaceOptions_AddCategory(optionsPanel);
	optionsPanel:SetScript("OnShow", function()
		c:ShowOptionsPanel();
	end);
	c:ShowOptionsPanel();

	local S = c:GetElvUiSkinModule();
	if S then
		S:HandleFrame(optionsPanel);
	end

	-- custom scripts panel
	if not scriptsPanel and GQ_OPTIONS[c.OPT_SCRIPTEDITORENABLED] then
		scriptsPanel = CreateFrame("Frame", "GearQuipper_Options_ScriptEditor", optionsPanel);
		scriptsPanel.name = c:GetText("Script Editor (EXPERIMENTAL!)");
		scriptsPanel.margin = defaultMargin;
		scriptsPanel.parent = optionsPanel.name;
		scriptsPanel.cancel = function(self) c:CheckForUnsavedScript() end;
		scriptsPanel.okay = function(self) c:CheckForUnsavedScript() end;
		InterfaceOptions_AddCategory(scriptsPanel);
		scriptsPanel:SetScript("OnShow", function()
			c:ShowScriptEditor();
		end);

		local S = c:GetElvUiSkinModule();
		if S then
			S:HandleFrame(scriptsPanel);
		end

		c:ShowScriptEditor();
	end
end

function c:ShowOptionsPanel()
	optionsPanel.oldOptions = GQ_OPTIONS;

	if not lblFeatures then
		lblFeatures = CreateFrame("Frame", "GqUiOptionElement_lblFeatures", optionsPanel);
		lblFeatures:SetPoint("TOPLEFT", optionsPanel.margin, -(optionsPanel.elementIndex - 1) * optionsPanel.checkboxYOffset - optionsPanel.margin);
		lblFeatures:SetWidth(550);
		lblFeatures:SetHeight(23);
		lblFeatures.fontString = lblFeatures:CreateFontString("GqUiOptionElement_lblFeatures_FontString", "ARTWORK", "GameFontNormalLarge");
		lblFeatures.fontString:SetPoint("CENTER");
		lblFeatures.fontString:SetText(c:GetText("Features"));
		optionsPanel.elementIndex = optionsPanel.elementIndex + 1;
	end

	--optionsPanel.elementIndex = optionsPanel.elementIndex + 1; -- spacing

	if not lblSaveChanges then
		lblSaveChanges = CreateFrame("Frame", "GqUiOptionElement_lblSaveChanges", optionsPanel);
		lblSaveChanges:SetPoint("TOPLEFT", optionsPanel.margin, -(optionsPanel.elementIndex - 1) * optionsPanel.checkboxYOffset - optionsPanel.margin);
		lblSaveChanges:SetWidth(100);
		lblSaveChanges:SetHeight(23);
		lblSaveChanges.fontString = lblSaveChanges:CreateFontString("GqUiOptionElement_lblSaveChanges_FontString", "ARTWORK", "GameFontNormal");
		lblSaveChanges.fontString:SetPoint("LEFT", 3, 0);
		lblSaveChanges.fontString:SetText(c:GetText("Save gear when:"));
	end

	if not lblSaveChangesActionSlots then
		lblSaveChangesActionSlots = CreateFrame("Frame", "GqUiOptionElement_lblSaveChangesActionSlots", optionsPanel);
		lblSaveChangesActionSlots:SetPoint("TOPLEFT", optionsPanel.margin, -(optionsPanel.elementIndex - 1) * optionsPanel.checkboxYOffset - optionsPanel.margin);
		lblSaveChangesActionSlots:SetWidth(100);
		lblSaveChangesActionSlots:SetHeight(23);
		lblSaveChangesActionSlots.fontString = lblSaveChangesActionSlots:CreateFontString("GqUiOptionElement_lblSaveChangesActionSlots_FontString", "ARTWORK", "GameFontNormal");
		lblSaveChangesActionSlots.fontString:SetPoint("LEFT", 280, 0);
		lblSaveChangesActionSlots.fontString:SetText(c:GetText("Save action slots when:"));
	end

	optionsPanel.elementIndex = optionsPanel.elementIndex + 1; -- spacing

	if not chSaveAlways then
		chSaveAlways = c:CreateOptionCheckButton(c:GetText("Always"), optionsPanel.margin);
		chSaveAlways:SetScript("OnClick", function(self)
			if self:GetChecked() then
				chSaveCharMenu:SetChecked(false);
				chSaveGqMenu:SetChecked(false);
				chSaveNever:SetChecked(false);
			else
				self:SetChecked(true);
			end
		end);
	end
	chSaveAlways:SetChecked(GQ_OPTIONS[c.OPT_SAVECHANGES] == c.OPTVALUE_SAVECHANGES_ALWAYS);

	if not chSaveAlwaysActionSlots then
		chSaveAlwaysActionSlots = c:CreateOptionCheckButton(c:GetText("Always"), 280 + optionsPanel.margin);
		chSaveAlwaysActionSlots:SetScript("OnClick", function(self)
			if self:GetChecked() then
				chSaveCharMenuActionSlots:SetChecked(false);
				chSaveGqMenuActionSlots:SetChecked(false);
				chSaveNeverActionSlots:SetChecked(false);
			else
				self:SetChecked(true);
			end
		end);
	end
	chSaveAlwaysActionSlots:SetChecked(GQ_OPTIONS[c.OPT_SAVECHANGES_ACTIONSLOTS] == c.OPTVALUE_SAVECHANGES_ALWAYS);

	optionsPanel.elementIndex = optionsPanel.elementIndex + 1; -- spacing

	if not chSaveCharMenu then
		chSaveCharMenu = c:CreateOptionCheckButton(c:GetText("Character menu open"), optionsPanel.margin);
		chSaveCharMenu:SetScript("OnClick", function(self)
			if self:GetChecked() then
				chSaveAlways:SetChecked(false);
				chSaveGqMenu:SetChecked(false);
				chSaveNever:SetChecked(false);
			else
				self:SetChecked(true);
			end
		end);
	end
	chSaveCharMenu:SetChecked(GQ_OPTIONS[c.OPT_SAVECHANGES] == c.OPTVALUE_SAVECHANGES_CHARMENU);

	if not chSaveCharMenuActionSlots then
		chSaveCharMenuActionSlots = c:CreateOptionCheckButton(c:GetText("Character menu open"), 280 + optionsPanel.margin);
		chSaveCharMenuActionSlots:SetScript("OnClick", function(self)
			if self:GetChecked() then
				chSaveAlwaysActionSlots:SetChecked(false);
				chSaveGqMenuActionSlots:SetChecked(false);
				chSaveNeverActionSlots:SetChecked(false);
			else
				self:SetChecked(true);
			end
		end);
	end
	chSaveCharMenuActionSlots:SetChecked(GQ_OPTIONS[c.OPT_SAVECHANGES_ACTIONSLOTS] == c.OPTVALUE_SAVECHANGES_CHARMENU);

	optionsPanel.elementIndex = optionsPanel.elementIndex + 1; -- spacing

	if not chSaveGqMenu then
		chSaveGqMenu = c:CreateOptionCheckButton(c:GetText("GearQuipper menu open"), optionsPanel.margin);
		chSaveGqMenu:SetScript("OnClick", function(self)
			if self:GetChecked() then
				chSaveAlways:SetChecked(false);
				chSaveCharMenu:SetChecked(false);
				chSaveNever:SetChecked(false);
			else
				self:SetChecked(true);
			end
		end);
	end
	chSaveGqMenu:SetChecked(GQ_OPTIONS[c.OPT_SAVECHANGES] == c.OPTVALUE_SAVECHANGES_GQMENU);

	if not chSaveGqMenuActionSlots then
		chSaveGqMenuActionSlots = c:CreateOptionCheckButton(c:GetText("GearQuipper menu open"), 280 + optionsPanel.margin);
		chSaveGqMenuActionSlots:SetScript("OnClick", function(self)
			if self:GetChecked() then
				chSaveAlwaysActionSlots:SetChecked(false);
				chSaveCharMenuActionSlots:SetChecked(false);
				chSaveNeverActionSlots:SetChecked(false);
			else
				self:SetChecked(true);
			end
		end);
	end
	chSaveGqMenuActionSlots:SetChecked(GQ_OPTIONS[c.OPT_SAVECHANGES_ACTIONSLOTS] == c.OPTVALUE_SAVECHANGES_GQMENU);

	optionsPanel.elementIndex = optionsPanel.elementIndex + 1; -- spacing

	if not chSaveNever then
		chSaveNever = c:CreateOptionCheckButton(c:GetText("Never"), optionsPanel.margin);
		chSaveNever:SetScript("OnClick", function(self)
			if self:GetChecked() then
				chSaveAlways:SetChecked(false);
				chSaveCharMenu:SetChecked(false);
				chSaveGqMenu:SetChecked(false);
			else
				self:SetChecked(true);
			end
		end);
	end
	chSaveNever:SetChecked(GQ_OPTIONS[c.OPT_SAVECHANGES] == c.OPTVALUE_SAVECHANGES_NEVER);

	if not chSaveNeverActionSlots then
		chSaveNeverActionSlots = c:CreateOptionCheckButton(c:GetText("Never"), 280 + optionsPanel.margin);
		chSaveNeverActionSlots:SetScript("OnClick", function(self)
			if self:GetChecked() then
				chSaveAlwaysActionSlots:SetChecked(false);
				chSaveCharMenuActionSlots:SetChecked(false);
				chSaveGqMenuActionSlots:SetChecked(false);
			else
				self:SetChecked(true);
			end
		end);
	end
	chSaveNeverActionSlots:SetChecked(GQ_OPTIONS[c.OPT_SAVECHANGES_ACTIONSLOTS] == c.OPTVALUE_SAVECHANGES_NEVER);

	optionsPanel.elementIndex = optionsPanel.elementIndex + 1; -- spacing
	optionsPanel.elementIndex = optionsPanel.elementIndex + 1; -- spacing

	if not chIgnoreManuallySwitchedItems then
		chIgnoreManuallySwitchedItems = c:CreateOptionCheckButton(c:GetText("Ignore manually switched items for the next event triggered set switch"));
		optionsPanel.elementIndex = optionsPanel.elementIndex + 1;
	end
	chIgnoreManuallySwitchedItems:SetChecked(GQ_OPTIONS[c.OPT_IGNOREMANUALITEMS]);

	if not chUprankSpells then
		chUprankSpells = c:CreateOptionCheckButton(c:GetText("Automatically uprank spells on your sets' action bars"));
		chUprankSpells:SetScript("OnClick", function (self)
			chUprankSpells_AllRanks:SetEnabled(self:GetChecked());
			if self:GetChecked() then
				chUprankSpells_AllRanks.fontString:SetTextColor(unpack(chUprankSpells_AllRanks.fontString.defaultColor));
			else
				chUprankSpells_AllRanks:SetChecked(false);
				chUprankSpells_AllRanks.fontString:SetTextColor(0.7, 0.7, 0.7);
			end
		end);
		optionsPanel.elementIndex = optionsPanel.elementIndex + 1;
	end
	chUprankSpells:SetChecked(GQ_OPTIONS[c.OPT_AUTOUPRANKSPELLS]);

	if not chUprankSpells_AllRanks then
		chUprankSpells_AllRanks = c:CreateOptionCheckButton(c:GetText("Uprank from any rank (will uprank any lower rank to max rank)"), optionsPanel.margin);
		chUprankSpells_AllRanks.fontString.defaultColor = {chUprankSpells_AllRanks.fontString:GetTextColor()};
		optionsPanel.elementIndex = optionsPanel.elementIndex + 1;
	end
	chUprankSpells_AllRanks:SetChecked(GQ_OPTIONS[c.OPT_AUTOUPRANKSPELLS_ALLRANKS]);

	if not lblSwitchDelay then
		lblSwitchDelay = CreateFrame("Frame", "GqUiOptionElement_lblSwitchDelay", optionsPanel);
		lblSwitchDelay:SetPoint("TOPLEFT", optionsPanel.margin, -(optionsPanel.elementIndex - 1) * optionsPanel.checkboxYOffset - optionsPanel.margin - 10);
		lblSwitchDelay:SetWidth(100);
		lblSwitchDelay:SetHeight(23);
		lblSwitchDelay.fontString = lblSwitchDelay:CreateFontString("GqUiOptionElement_lblSwitchDelay_FontString", "ARTWORK", "GameFontNormal");
		lblSwitchDelay.fontString:SetPoint("LEFT", 3, 0);
	end
	lblSwitchDelay.fontString:SetText(c:GetText("Set switch delay: %sms", tostring(GQ_OPTIONS[c.OPT_SWITCHDELAY])));

	if not sldSwitchDelay then
		sldSwitchDelay = c:CreateOptionsSlider(0, 1000, function (self)
			lblSwitchDelay.fontString:SetText(c:GetText("Set switch delay: %sms", tostring(self:GetValue())));
		end, 205, 10, 150, 50, "0ms", "1000ms");
	end
	sldSwitchDelay:SetValue(GQ_OPTIONS[c.OPT_SWITCHDELAY]);

	if not lblSwitchDelayHint then
		lblSwitchDelayHint = CreateFrame("Frame", "GqUiOptionElement_lblSwitchDelayHint", optionsPanel);
		lblSwitchDelayHint:SetPoint("TOPLEFT", 375, -(optionsPanel.elementIndex - 1) * optionsPanel.checkboxYOffset - optionsPanel.margin - 10);
		lblSwitchDelayHint:SetWidth(100);
		lblSwitchDelayHint:SetHeight(23);
		lblSwitchDelayHint.fontString = lblSwitchDelayHint:CreateFontString("GqUiOptionElement_lblSwitchDelayHint_FontString", "ARTWORK", "GameFontNormal");
		lblSwitchDelayHint.fontString:SetPoint("TOPLEFT", 3, 0);
		lblSwitchDelayHint.fontString:SetJustifyH("LEFT");
	end
	lblSwitchDelayHint.fontString:SetText(c:GetText("(Increase if you experience issues with\n automated event switches)"));

	optionsPanel.elementIndex = optionsPanel.elementIndex + 1; -- spacing

	-- VISUAL SETTINGS

	optionsPanel.elementIndex = optionsPanel.elementIndex + 1; -- spacing
	optionsPanel.elementIndex = optionsPanel.elementIndex + 1; -- spacing

	if not lblVisualSettings then
		lblVisualSettings = CreateFrame("Frame", "GqUiOptionElement_lblVisualSettings", optionsPanel);
		lblVisualSettings:SetPoint("TOPLEFT", optionsPanel.margin, -(optionsPanel.elementIndex - 1) * optionsPanel.checkboxYOffset - optionsPanel.margin);
		lblVisualSettings:SetWidth(550);
		lblVisualSettings:SetHeight(23);
		lblVisualSettings.fontString = lblVisualSettings:CreateFontString("GqUiOptionElement_lblVisualSettings_FontString", "ARTWORK", "GameFontNormalLarge");
		lblVisualSettings.fontString:SetPoint("CENTER");
		lblVisualSettings.fontString:SetText(c:GetText("Visual Settings"));
		optionsPanel.elementIndex = optionsPanel.elementIndex + 1;
	end

	if not chNotifyQueues then
		chNotifyQueues = c:CreateOptionCheckButton(c:GetText("Queue/combat chat notifications"));
		optionsPanel.elementIndex = optionsPanel.elementIndex + 1;
	end
	chNotifyQueues:SetChecked(GQ_OPTIONS[c.OPT_NOTIFYQUEUES]);

	if not chHighlightChanges then
		chHighlightChanges = c:CreateOptionCheckButton(c:GetText("Highlight switched slots"));
		optionsPanel.elementIndex = optionsPanel.elementIndex + 1;
	end
	chHighlightChanges:SetChecked(GQ_OPTIONS[c.OPT_HIGHLIGHTCHANGES]);

	if not chConfirmChangesInChat then
		chConfirmChangesInChat = c:CreateOptionCheckButton(c:GetText("Confirm changes in chat"));
		optionsPanel.elementIndex = optionsPanel.elementIndex + 1;
	end
	chConfirmChangesInChat:SetChecked(GQ_OPTIONS[c.OPT_NOTIFYCHANGES]);

	if not chShowCurrentSetLabel then
		chShowCurrentSetLabel = c:CreateOptionCheckButton(c:GetText("Show \"current set\" label"));
		optionsPanel.elementIndex = optionsPanel.elementIndex + 1;
	end
	chShowCurrentSetLabel:SetChecked(GQ_OPTIONS[c.OPT_SHOWCURRENTSET]);

	if not chShowItemTooltip then
		chShowItemTooltip = c:CreateOptionCheckButton(c:GetText("Show item tooltips"));
		optionsPanel.elementIndex = optionsPanel.elementIndex + 1;
	end
	chShowItemTooltip:SetChecked(GQ_OPTIONS[c.OPT_SHOWITEMTOOLTIP]);

	if not chShowSlotBackgroundColors then
		chShowSlotBackgroundColors = c:CreateOptionCheckButton(c:GetText("Show slot background colors"));
		optionsPanel.elementIndex = optionsPanel.elementIndex + 1;
	end
	chShowSlotBackgroundColors:SetChecked(GQ_OPTIONS[c.OPT_SHOWSLOTBACKDROPS]);

	if not chShowBrokerTooltip then
		chShowBrokerTooltip = c:CreateOptionCheckButton(c:GetText("Show data broker tooltip"));
		optionsPanel.elementIndex = optionsPanel.elementIndex + 1;
	end
	chShowBrokerTooltip:SetChecked(GQ_OPTIONS[c.OPT_SHOWBROKERTOOLTIP]);

	optionsPanel.elementIndex = optionsPanel.elementIndex + 1; -- spacing
	optionsPanel.elementIndex = optionsPanel.elementIndex + 1; -- spacing
	
	-- EXPERIMENTAL SETTINGS

	--if false and not lblExperimentalSettings then
	--	lblExperimentalSettings = CreateFrame("Frame", "GqUiOptionElement_lblExperimentalSettings", optionsPanel);
	--	lblExperimentalSettings:SetPoint("TOPLEFT", optionsPanel.margin, -(optionsPanel.elementIndex - 1) * optionsPanel.checkboxYOffset - optionsPanel.margin);
	--	lblExperimentalSettings:SetWidth(550);
	--	lblExperimentalSettings:SetHeight(23);
	--	lblExperimentalSettings.fontString = lblExperimentalSettings:CreateFontString("GqUiOptionElement_lblExperimentalSettings_FontString", "ARTWORK", "GameFontNormalLarge");
	--	lblExperimentalSettings.fontString:SetPoint("CENTER");
	--	lblExperimentalSettings.fontString:SetText(c:GetText("Experimental Features"));
	--	optionsPanel.elementIndex = optionsPanel.elementIndex + 1;
	--end

	--if not chEnableScriptEditor then
	--	chEnableScriptEditor = c:CreateOptionCheckButton(c:GetText("Enable script editor (Beware: Might crash the addon or the game! Needs relog.)"));
	--	optionsPanel.elementIndex = optionsPanel.elementIndex + 1;
	--end
	--chEnableScriptEditor:SetChecked(GQ_OPTIONS[c.OPT_SCRIPTEDITORENABLED]);

	-- RESET BUTTON
	--optionsPanel.elementIndex = optionsPanel.elementIndex + 1; -- spacing

	if not btnReset then
		btnReset = CreateFrame("Button", "GqResetButton", optionsPanel, "GqButtonTemplate");
		btnReset:SetWidth(180);
		btnReset:SetPoint("TOPLEFT", 10, -optionsPanel.elementIndex * optionsPanel.checkboxYOffset - optionsPanel.margin);
		btnReset:SetScript("OnClick", function() c:ShowResetDialog(); end);
		btnReset.fontString = btnReset:CreateFontString("GqResetButton_FontString", "ARTWORK", "GameFontNormal");
		btnReset.fontString:SetPoint("CENTER");
		btnReset.fontString:SetText(c:GetText("Reset GearQuipper"));

		local S = c:GetElvUiSkinModule();
		if S then
			S:HandleButton(btnReset);
		end
	end
end

function c:CreateOptionCheckButton(text, xOffset)
	xOffset = xOffset or 0;

	local element = CreateFrame("CheckButton", "GqUiOptionElement_" .. optionsPanel.elementIndex, optionsPanel, "ChatConfigCheckButtonTemplate");
	element:SetPoint("TOPLEFT", 10 + xOffset, -(optionsPanel.elementIndex - 1) * optionsPanel.checkboxYOffset - optionsPanel.margin);
	element.fontString = element:CreateFontString("GqUiOptionElement_" .. optionsPanel.elementIndex .. "_FontString", "ARTWORK", "GameFontNormal");
	element.fontString:SetPoint("LEFT", 30, 0);
	element.fontString:SetText(text);

	local S = c:GetElvUiSkinModule();
	if S then
		S:HandleCheckBox(element);
	end

	return element;
end

function c:CreateOptionsSlider(min, max, func, xOffset, yOffset, width, valueStep, minText, maxText)
    xOffset = xOffset or 0;
    min = min or 0;
    max = max or 100;
    valueStep = valueStep or 1;
    minText = minText or min;
    maxText = maxText or max;
    width = width or 160;

    local element = CreateFrame("Slider", "GqUiOptionElement_" .. optionsPanel.elementIndex, optionsPanel, "OptionsSliderTemplate");
    element.frameType = "Slider";
    element:SetPoint("TOPLEFT", 10 + xOffset, -(optionsPanel.elementIndex - 1) * optionsPanel.checkboxYOffset - optionsPanel.margin - yOffset);
    element:SetOrientation("HORIZONTAL");
    element:SetWidth(width);
    element:SetHeight(23);
    element:SetScript("OnValueChanged", func);
    element:SetMinMaxValues(min, max);
    element:SetValueStep(valueStep);
    element:SetObeyStepOnDrag(true);

    -- min text
	element.minText = getglobal(element:GetName() .. "Low");
    element.SetMinText = function (self, text)
        self.minText:SetText(text);
    end
    element:SetMinText(minText);

    -- max text
    element.maxText = getglobal(element:GetName() .. "High");
    element.SetMaxText = function (self, text)
        self.maxText:SetText(text);
    end
    element:SetMaxText(maxText);

	local S = c:GetElvUiSkinModule();
	if S then
		S:HandleSliderFrame(element);
	end

    return element;
end

function c:SaveOptions(self)
	if c.initFinished then
		GQ_OPTIONS[c.OPT_NOTIFYQUEUES] = chNotifyQueues:GetChecked();
		GQ_OPTIONS[c.OPT_NOTIFYCHANGES] = chConfirmChangesInChat:GetChecked();
		GQ_OPTIONS[c.OPT_HIGHLIGHTCHANGES] = chHighlightChanges:GetChecked();
		GQ_OPTIONS[c.OPT_SHOWCURRENTSET] = chShowCurrentSetLabel:GetChecked();
		GQ_OPTIONS[c.OPT_SHOWITEMTOOLTIP] = chShowItemTooltip:GetChecked();
		GQ_OPTIONS[c.OPT_SHOWSLOTBACKDROPS] = chShowSlotBackgroundColors:GetChecked();

		GQ_OPTIONS[c.OPT_SHOWBROKERTOOLTIP] = chShowBrokerTooltip:GetChecked();

		GQ_OPTIONS[c.OPT_IGNOREMANUALITEMS] = chIgnoreManuallySwitchedItems:GetChecked();
		GQ_OPTIONS[c.OPT_AUTOUPRANKSPELLS] = chUprankSpells:GetChecked();
		GQ_OPTIONS[c.OPT_AUTOUPRANKSPELLS_ALLRANKS] = chUprankSpells_AllRanks:GetChecked();

		GQ_OPTIONS[c.OPT_SWITCHDELAY] = sldSwitchDelay:GetValue();

		--GQ_OPTIONS[c.OPT_SCRIPTEDITORENABLED] = chEnableScriptEditor:GetChecked();

		if not GQ_OPTIONS[c.OPT_IGNOREMANUALITEMS] then
			c:ResetIgnoredSlots();
		end

		if chSaveAlways:GetChecked() then
			GQ_OPTIONS[c.OPT_SAVECHANGES] = c.OPTVALUE_SAVECHANGES_ALWAYS;
		elseif chSaveCharMenu:GetChecked() then
			GQ_OPTIONS[c.OPT_SAVECHANGES] = c.OPTVALUE_SAVECHANGES_CHARMENU;
		elseif chSaveGqMenu:GetChecked() then
			GQ_OPTIONS[c.OPT_SAVECHANGES] = c.OPTVALUE_SAVECHANGES_GQMENU;
		else
			GQ_OPTIONS[c.OPT_SAVECHANGES] = c.OPTVALUE_SAVECHANGES_NEVER;
		end

		if chSaveAlwaysActionSlots:GetChecked() then
			GQ_OPTIONS[c.OPT_SAVECHANGES_ACTIONSLOTS] = c.OPTVALUE_SAVECHANGES_ALWAYS;
		elseif chSaveCharMenuActionSlots:GetChecked() then
			GQ_OPTIONS[c.OPT_SAVECHANGES_ACTIONSLOTS] = c.OPTVALUE_SAVECHANGES_CHARMENU;
		elseif chSaveGqMenuActionSlots:GetChecked() then
			GQ_OPTIONS[c.OPT_SAVECHANGES_ACTIONSLOTS] = c.OPTVALUE_SAVECHANGES_GQMENU;
		else
			GQ_OPTIONS[c.OPT_SAVECHANGES_ACTIONSLOTS] = c.OPTVALUE_SAVECHANGES_NEVER;
		end
	end
end

-- script editor
local currentEntry;

local lblExistingScripts, lblScriptName, lblScriptText;
local lblSelectScript, lblScriptStatus;

local scriptListScrollFrameBorder;
local scriptListScrollFrame;
local scriptListScrollFrameSlider;
local scriptListContentFrame;

local btnNewScript, btnDeleteScript, btnSaveScript, btnTestScript;
local txtScriptFrameBorder;
local txtScriptName, txtScriptText;

local listScriptEntries = {};

local function SetScriptStatusLabel()
	if currentEntry then
		local status = c:FormatTextWithColor(c:GetText("Not OK"), "ff0000");
		if currentEntry.script and currentEntry.script[c.FIELD_OK] then
			status = c:FormatTextWithColor(c:GetText("OK"), "00ff00");
		end
		lblScriptStatus.fontString:SetText(c:GetText("Status: %s", status));
		lblScriptStatus:Show();
	else
		lblScriptStatus:Hide();
	end
end

local function GetEntryFromScript(script)
	for scriptId, entry in pairs(listScriptEntries) do
		if entry.script[c.FIELD_ID] == script[c.FIELD_ID] then
			return entry;
		end
	end
end

local function SelectScript(value)
	if value then
		if value.script then
			-- scriptEntry
			if currentEntry then
				currentEntry:SetNormalTexture(currentEntry.defaultTexture);
			end
			currentEntry = value;
			if currentEntry.script[c.FIELD_NAME] then
				txtScriptName:SetText(currentEntry.script[c.FIELD_NAME]);
			else
				txtScriptName:SetText("");
			end
			if currentEntry.script[c.FIELD_TEXT] then
				txtScriptText:SetText(currentEntry.script[c.FIELD_TEXT]);
			else
				txtScriptText:SetText("");
			end
			value:SetNormalTexture(value:GetHighlightTexture());

			btnSaveScript:SetEnabled(true);
			btnDeleteScript:SetEnabled(true);
			btnTestScript:SetEnabled(true);
			txtScriptName:SetEnabled(true);
			txtScriptText:SetEnabled(true);
			lblSelectScript:Hide();
			SetScriptStatusLabel();
			return;
		else
			-- script
			local entry = GetEntryFromScript(value);
			if entry then
				SelectScript(entry);
			end
		end
	end

	c:ClearScriptEditorFields();
	lblSelectScript:Show();
end

local function GetScriptListEntry(uiIndex)
	if not listScriptEntries[uiIndex] then
		local scriptEntry = CreateFrame("Button", "GqUiOptionElement_Scripts_Entry" .. uiIndex, scriptListContentFrame, "GqButtonTemplate");
		listScriptEntries[uiIndex] = scriptEntry;

		scriptEntry:RegisterForClicks("LeftButtonUp");
		scriptEntry:SetHeight(20);
		scriptEntry:SetWidth(scriptListContentFrame:GetWidth() - 15);
		scriptEntry:SetPoint("TOPLEFT", 0, -(uiIndex - 1) * defaultYOffset);
		scriptEntry.defaultTexture = scriptEntry:GetNormalTexture();

		scriptEntry:SetScript("OnMouseDown", function(self)
			self.Left:SetTexture(nil);
			self.Middle:SetTexture(nil);
			self.Right:SetTexture(nil);
			self:SetNormalTexture(nil);
			self:SetPushedTexture(nil);
		end);
		scriptEntry:SetScript("OnMouseUp", function(self)
			self.Left:SetTexture(nil);
			self.Middle:SetTexture(nil);
			self.Right:SetTexture(nil);
			self:SetNormalTexture(nil);
			self:SetPushedTexture(nil);
		end);
		scriptEntry:SetScript("OnClick", function(self)
			self.Left:SetTexture(nil);
			self.Middle:SetTexture(nil);
			self.Right:SetTexture(nil);
			self:SetNormalTexture(nil);
			self:SetPushedTexture(nil);
			SelectScript(self);
		end);

		scriptEntry.fontString = scriptEntry:CreateFontString("GqUiOptionElement_Scripts_Entry_" .. uiIndex .. "_FontString", "ARTWORK", "GameFontWhite");
		scriptEntry.fontString:SetWidth(200);
		scriptEntry.fontString:SetJustifyH("LEFT");
		scriptEntry.fontString:SetAllPoints();

		local S = c:GetElvUiSkinModule();
		if S then
			S:HandleFrame(scriptEntry);
		end
	end
	return listScriptEntries[uiIndex];
end

function c:ClearScriptEditorFields()
	txtScriptName:SetText("");
	txtScriptText:SetText("");
	SetScriptStatusLabel();
end

function c:RefreshScripts()
	for scriptId, scriptEntry in pairs(listScriptEntries) do
		scriptEntry:Hide();
	end

	local uiIndex = 1;
	local scripts = c:LoadScripts();
	for _, scriptName in ipairs(c:LoadScriptNames(true)) do
		for scriptId, script in pairs(scripts) do
			if script[c.FIELD_NAME] == scriptName then
				local entry = GetScriptListEntry(uiIndex);
				entry.uiIndex = uiIndex;
				entry.script = script;
				entry:Show();
				entry:SetText(script[c.FIELD_NAME]);

				entry.Left:SetTexture(nil);
				entry.Middle:SetTexture(nil);
				entry.Right:SetTexture(nil);
				entry:SetNormalTexture(nil);
				entry:SetPushedTexture(nil);

				uiIndex = uiIndex + 1;
			end
		end
	end

	btnSaveScript:SetEnabled(currentEntry ~= nil);
	btnDeleteScript:SetEnabled(currentEntry ~= nil);
	btnTestScript:SetEnabled(currentEntry ~= nil);
	txtScriptName:SetEnabled(currentEntry ~= nil);
	txtScriptText:SetEnabled(currentEntry ~= nil);

	if currentEntry then
		lblSelectScript:Hide();
	else
		lblSelectScript:Show();
	end
end

local function NewScript()
	local newScript = c:NewScript();
	c:RefreshScripts();
	SelectScript(newScript);
end

local function DeleteScript()
	c:ShowDeleteScriptDialog(currentEntry.script);
	currentEntry = nil;
end

local function SaveScript()
	if currentEntry then
		local name = txtScriptName:GetText();
		if name and strlen(name) > 3 then
			local oldSelection = currentEntry.script;
			currentEntry.script[c.FIELD_NAME] = txtScriptName:GetText();
			c:SaveScript(currentEntry.script, txtScriptText:GetText());
			currentEntry = nil;

			c:RefreshScripts();
			local newSelection = GetEntryFromScript(oldSelection);
			if newSelection then
				currentEntry = newSelection;
				SelectScript(newSelection);
			end
		else
			c:Println(c:GetText("Invalid script name: At least 4 charaters."));
		end
	end
end

function c:TestScript(script, silent)
	if script then
		if not silent then
			c:Println(c:GetText("Start testing script..."));
		end

		local scriptText = script[c.FIELD_TEXT];

		local func, errorMessage = loadstring(scriptText);
		if not errorMessage then
			if not silent then
				c:Println(c:GetText("Script test finished without errors."));
			end
			c:SaveScriptStatus(script, true);
			SetScriptStatusLabel();
			return true;
		elseif not silent then
			c:Println(c:GetText("Error in script: \n%s", errorMessage));
		end

		script[c.FIELD_OK] = false;
	end
end

function c:ShowScriptEditor()
	if not lblExistingScripts then
		lblExistingScripts = CreateFrame("Frame", "GqUiOptionElement_lblExistingScripts", scriptsPanel);
		lblExistingScripts:SetPoint("TOPLEFT", scriptsPanel.margin + 5, - scriptsPanel.margin);
		lblExistingScripts:SetWidth(100);
		lblExistingScripts:SetHeight(23);
		lblExistingScripts.fontString = lblExistingScripts:CreateFontString("GqUiOptionElement_lblExistingScripts_FontString", "ARTWORK", "GameFontNormal");
		lblExistingScripts.fontString:SetPoint("LEFT", 3, 0);
		lblExistingScripts.fontString:SetText(c:GetText("Your Scripts"));

		local S = c:GetElvUiSkinModule();
		if S then
			S:HandleButton(lblExistingScripts);
		end
	end

	if not scriptListScrollFrameBorder then
		scriptListScrollFrameBorder = CreateFrame("Frame", "GearQuipper_Options_ScriptEditor_ListScrollFrameBorder", scriptsPanel);
		scriptListScrollFrameBorder:SetPoint("TOPLEFT", scriptsPanel.margin, -scriptsPanel.margin - defaultYOffset);
		scriptListScrollFrameBorder:SetWidth(150);
		scriptListScrollFrameBorder:SetHeight(500);
		scriptListScrollFrameBorder:SetBackdrop( {
			bgFile = "Interface\\TutorialFrame\\TutorialFrameBackground",
			edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = false, tileSize = 32, edgeSize = 16,
			insets = { left = 5, right = 5, top = 5, bottom = 5 }
		  });

		local S = c:GetElvUiSkinModule();
		if S then
			S:HandleFrame(scriptListScrollFrameBorder);
		end
	end

	if not scriptListScrollFrame then
		scriptListScrollFrame = CreateFrame("ScrollFrame", "GearQuipper_Options_ScriptEditor_ListScrollFrame", scriptListScrollFrameBorder);
		scriptListScrollFrame:SetPoint("TOPLEFT", scriptsPanel.margin, -scriptsPanel.margin);
		scriptListScrollFrame:SetPoint("BOTTOMRIGHT", -scriptsPanel.margin, scriptsPanel.margin);

		local S = c:GetElvUiSkinModule();
		if S then
			S:HandleFrame(scriptListScrollFrame);
		end
	end

	if not scriptListScrollFrameSlider then
		scriptListScrollFrameSlider = CreateFrame("Slider", "GearQuipper_Options_ScriptEditor_ListScrollFrameSlider", scriptListScrollFrame);
		scriptListScrollFrameSlider:SetPoint("TOPRIGHT", 0, 0);
		scriptListScrollFrameSlider:SetOrientation("VERTICAL");
		scriptListScrollFrameSlider:SetWidth(10);
		scriptListScrollFrameSlider:EnableMouse(true);
		scriptListScrollFrameSlider:SetHeight(scriptListScrollFrameBorder:GetHeight() - 20);
		scriptListScrollFrameSlider:SetScript("OnValueChanged", function(self)
			self:GetParent():SetVerticalScroll(self:GetValue());
		end);
		scriptListScrollFrameSlider:SetBackdrop( {
			bgFile = "Interface\\Buttons\\UI-SliderBar-Border",
			edgeFile = "Interface\\Buttons\\UI-SliderBar-Background", tile = true, tileSize = 8, edgeSize = 8,
			insets = { left = 3, right = 3, top = 6, bottom = 6 }
		  });
		scriptListScrollFrameSlider:SetThumbTexture("Interface\\Buttons\\UI-SliderBar-Button-Vertical");
		scriptListScrollFrameSlider:SetMinMaxValues(1, 100);
		scriptListScrollFrameSlider:SetValueStep(1);
		scriptListScrollFrameSlider:SetValue(1);

		local S = c:GetElvUiSkinModule();
		if S then
			S:HandleFrame(scriptListScrollFrameSlider);
		end
	end

	if not scriptListContentFrame then
		scriptListContentFrame = CreateFrame("Frame", "GearQuipper_Options_ScriptEditor_scriptListContentFrame", scriptListScrollFrameBorder);
		scriptListContentFrame:SetPoint("TOPLEFT", 10, -10);
		scriptListContentFrame:SetPoint("BOTTOMRIGHT", -10, 10);
		scriptListContentFrame:SetWidth(scriptListScrollFrameBorder:GetWidth() - scriptListScrollFrameSlider:GetWidth() - 10);
		scriptListContentFrame:SetHeight(scriptListScrollFrameBorder:GetHeight());
		local S = c:GetElvUiSkinModule();
		if S then
			S:HandleFrame(scriptListContentFrame);
		end
	end
	scriptListScrollFrame:SetScrollChild(scriptListContentFrame);

	if not lblScriptName then
		lblScriptName = CreateFrame("Frame", "GqUiOptionElement_lblScriptName", scriptsPanel);
		lblScriptName:SetPoint("TOPLEFT", scriptsPanel.margin + scriptListScrollFrameBorder:GetWidth() + 8, - scriptsPanel.margin - defaultYOffset);
		lblScriptName:SetWidth(100);
		lblScriptName:SetHeight(23);
		lblScriptName.fontString = lblScriptName:CreateFontString("GqUiOptionElement_lblScriptName_FontString", "ARTWORK", "GameFontNormal");
		lblScriptName.fontString:SetPoint("LEFT", 3, 0);
		lblScriptName.fontString:SetText(c:GetText("Current Script Name:"));

		local S = c:GetElvUiSkinModule();
		if S then
			S:HandleFrame(lblScriptName);
		end
	end

	if not txtScriptName then
		txtScriptName = CreateFrame("EditBox", "GearQuipper_Options_ScriptEditor_TxtScriptName", scriptsPanel, "InputBoxTemplate");
		txtScriptName:SetPoint("TOPLEFT", scriptsPanel.margin + scriptListScrollFrameBorder:GetWidth() + 8 + lblScriptName:GetWidth() + 44, - scriptsPanel.margin - defaultYOffset + 2);
		txtScriptName:SetHeight(28);
		txtScriptName:SetWidth(160);
		txtScriptName:SetAutoFocus(false);
		txtScriptName:ClearFocus();
		txtScriptName:SetEnabled(false);
		txtScriptName:SetScript("OnEscapePressed", function() txtScriptName:ClearFocus() end);

		local S = c:GetElvUiSkinModule();
		if S then
			S:HandleFrame(txtScriptName);
		end
	end

	if not lblScriptStatus then
		lblScriptStatus = CreateFrame("Frame", "GqUiOptionElement_lblScriptStatus", scriptsPanel);
		lblScriptStatus:SetPoint("TOPLEFT", scriptListScrollFrameBorder:GetWidth() + 8 + lblScriptName:GetWidth() + 44 + txtScriptName:GetWidth() + 15, - scriptsPanel.margin - defaultYOffset);
		lblScriptStatus:SetWidth(100);
		lblScriptStatus:SetHeight(23);
		lblScriptStatus.fontString = lblScriptStatus:CreateFontString("GqUiOptionElement_lblScriptStatus_FontString", "ARTWORK", "GameFontNormal");
		lblScriptStatus.fontString:SetPoint("LEFT", 3, 0);
		SetScriptStatusLabel();

		local S = c:GetElvUiSkinModule();
		if S then
			S:HandleFrame(lblScriptStatus);
		end
	end

	if not lblScriptText then
		lblScriptText = CreateFrame("Frame", "GqUiOptionElement_lblScriptText", scriptsPanel);
		lblScriptText:SetPoint("TOPLEFT", scriptsPanel.margin + scriptListScrollFrameBorder:GetWidth() + 8, - scriptsPanel.margin - defaultYOffset * 2);
		lblScriptText:SetWidth(100);
		lblScriptText:SetHeight(23);
		lblScriptText.fontString = lblScriptText:CreateFontString("GqUiOptionElement_lblScriptName_FontString", "ARTWORK", "GameFontNormal");
		lblScriptText.fontString:SetPoint("LEFT", 3, 0);
		lblScriptText.fontString:SetText(c:GetText("Script Text"));

		local S = c:GetElvUiSkinModule();
		if S then
			S:HandleFrame(lblScriptText);
		end
	end

	if not txtScriptFrameBorder then
		txtScriptFrameBorder = CreateFrame("Frame", "GearQuipper_Options_ScriptEditor_txtScriptFrameBorder", scriptsPanel);
		txtScriptFrameBorder:SetPoint("TOPLEFT", scriptsPanel.margin + scriptListScrollFrameBorder:GetWidth() + 5, - scriptsPanel.margin - defaultYOffset * 3);
		txtScriptFrameBorder:SetHeight(456);
		txtScriptFrameBorder:SetWidth(450);
		txtScriptFrameBorder:SetBackdrop( {
			bgFile = "Interface\\TutorialFrame\\TutorialFrameBackground",
			edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = false, tileSize = 32, edgeSize = 16,
			insets = { left = 5, right = 5, top = 5, bottom = 5 }
		  });

		local S = c:GetElvUiSkinModule();
		if S then
			S:HandleFrame(txtScriptFrameBorder);
		end
	end

	if not txtScriptText then
		txtScriptText = CreateFrame("EditBox", "GearQuipper_Options_ScriptEditor_TxtScriptText", txtScriptFrameBorder);
		txtScriptText:SetPoint("TOPLEFT", 10, - 10);
		txtScriptText:SetPoint("BOTTOMRIGHT", -10, 10);
		txtScriptText:SetAutoFocus(false);
		txtScriptText:ClearFocus();
		txtScriptText:SetMultiLine(true);
		txtScriptText:SetMaxLetters(99999);
		txtScriptText:EnableMouse(true);
		txtScriptText:SetEnabled(false);
		txtScriptText:SetFontObject(txtScriptName:GetFontObject());
		txtScriptText:SetScript("OnEscapePressed", function() txtScriptText:ClearFocus() end);
		txtScriptText:SetScript("OnKeyDown", function()
			if currentEntry and currentEntry.script[c.FIELD_OK] then
				currentEntry.script[c.FIELD_OK] = false;
				SetScriptStatusLabel();
			end
		end);
		txtScriptText:SetScript("OnTabPressed", function(self)
			self:Insert("    "); -- (4 spaces)
		end);

		local S = c:GetElvUiSkinModule();
		if S then
			S:HandleFrame(txtScriptText);
		end
	end

	if not lblSelectScript then
		lblSelectScript = CreateFrame("Frame", "GqUiOptionElement_lblSelectScript", txtScriptFrameBorder);
		lblSelectScript:SetPoint("TOPLEFT");
		lblSelectScript:SetPoint("BOTTOMRIGHT");
		lblSelectScript.fontString = lblSelectScript:CreateFontString("GqUiOptionElement_lblExistingScripts_FontString", "ARTWORK", "GameFontNormal");
		--lblSelectScript.fontString:SetPoint("LEFT", 70, 0);
		lblSelectScript.fontString:SetPoint("CENTER");
		lblSelectScript.fontString:SetTextColor(1, 1, 1, 1);
		lblSelectScript.fontString:SetText(c:GetText("Please select a script or create a new one using the button below."));

		local S = c:GetElvUiSkinModule();
		if S then
			S:HandleFrame(lblSelectScript);
		end
	end

	if not btnNewScript then
		btnNewScript = CreateFrame("Button", "GearQuipper_Options_ScriptEditor_BtnNewScript", scriptsPanel, "GqButtonTemplate");
		btnNewScript:SetPoint("BOTTOMLEFT", scriptsPanel.margin + 15, scriptsPanel.margin);
		btnNewScript:SetWidth(120);
		btnNewScript:SetScript("OnClick", function() NewScript() end);
		btnNewScript.fontString = btnNewScript:CreateFontString("GearQuipper_Options_ScriptEditor_BtnNewScript_FontString", "ARTWORK", "GameFontNormal");
		btnNewScript.fontString:SetPoint("CENTER");
		btnNewScript.fontString:SetText(c:GetText("New Script"));

		local S = c:GetElvUiSkinModule();
		if S then
			S:HandleButton(btnNewScript);
		end
	end

	if not btnDeleteScript then
		btnDeleteScript = CreateFrame("Button", "GearQuipper_Options_ScriptEditor_BtnDeleteScript", scriptsPanel, "GqButtonTemplate");
		btnDeleteScript:SetPoint("BOTTOMLEFT", scriptsPanel.margin + 165, scriptsPanel.margin);
		btnDeleteScript:SetWidth(120);
		btnDeleteScript:SetScript("OnClick", function() DeleteScript() end);
		btnDeleteScript.fontString = btnDeleteScript:CreateFontString("GearQuipper_Options_ScriptEditor_BtnDeleteScript_FontString", "ARTWORK", "GameFontNormal");
		btnDeleteScript.fontString:SetPoint("CENTER");
		btnDeleteScript.fontString:SetText(c:GetText("Delete Script"));
		btnDeleteScript:SetEnabled(false);

		local S = c:GetElvUiSkinModule();
		if S then
			S:HandleButton(btnDeleteScript);
		end
	end

	if not btnTestScript then
		btnTestScript = CreateFrame("Button", "GearQuipper_Options_ScriptEditor_BtnTestScript", scriptsPanel, "GqButtonTemplate");
		btnTestScript:SetPoint("BOTTOMRIGHT", - scriptsPanel.margin - 125, scriptsPanel.margin);
		btnTestScript:SetWidth(120);
		btnTestScript:SetScript("OnClick", function()
			c:SaveScript(currentEntry.script, txtScriptText:GetText());
			c:TestScript(currentEntry.script);
		 end);
		btnTestScript.fontString = btnTestScript:CreateFontString("GearQuipper_Options_ScriptEditor_BtnTestScript_FontString", "ARTWORK", "GameFontNormal");
		btnTestScript.fontString:SetPoint("CENTER");
		btnTestScript.fontString:SetText(c:GetText("Test Script"));
		btnTestScript:SetEnabled(false);

		local S = c:GetElvUiSkinModule();
		if S then
			S:HandleButton(btnTestScript);
		end
	end

	if not btnSaveScript then
		btnSaveScript = CreateFrame("Button", "GearQuipper_Options_ScriptEditor_BtnSaveScript", scriptsPanel, "GqButtonTemplate");
		btnSaveScript:SetPoint("BOTTOMRIGHT", - scriptsPanel.margin, scriptsPanel.margin);
		btnSaveScript:SetWidth(120);
		btnSaveScript:SetScript("OnClick", function() SaveScript() end);
		btnSaveScript.fontString = btnSaveScript:CreateFontString("GearQuipper_Options_ScriptEditor_BtnSaveScript_FontString", "ARTWORK", "GameFontNormal");
		btnSaveScript.fontString:SetPoint("CENTER");
		btnSaveScript.fontString:SetText(c:GetText("Save Script"));
		btnSaveScript:SetEnabled(false);

		local S = c:GetElvUiSkinModule();
		if S then
			S:HandleButton(btnSaveScript);
		end
	end

	c:RefreshScripts();
end

function c:CheckForUnsavedScript()
	if currentEntry and currentEntry.script and txtScriptText and currentEntry.script[c.FIELD_TEXT] ~= txtScriptText:GetText() then
		c:ShowSaveScriptAfterClosingDialog(currentEntry.script, txtScriptText:GetText());
	end
end