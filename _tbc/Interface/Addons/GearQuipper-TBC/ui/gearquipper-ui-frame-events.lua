
gearquipper = gearquipper or {};
local c = gearquipper;
local e;

local function HasEventSubType(value)
	return value == c.EVENT_ZONE_ENTER or
		value == c.EVENT_ZONE_LEAVE or
		value == c.EVENT_SHAPESHIFT_IN or
		value == c.EVENT_SHAPESHIFT_OUT or
		value == c.EVENT_AURA_CHANGED or
		value == c.EVENT_STANCE_CHANGED or
		value == c.EVENT_CUSTOMSCRIPT
end

function GqUiFrameEvents_OnShow(self)
	if not e then
		e = self;

		-- eventtype (main, combobox)
		function e:ShowCbEventType()
			if not e.cbEventType then
				local info = UIDropDownMenu_CreateInfo();
				info.hasArrow = false;
				info.notCheckable  = true;

				e.cbEventType = CreateFrame("Frame", "GqUiFrameEvents_CbEventType", GqUiFrameEventsContent, "UIDropDownMenuTemplate");
				e.cbEventType:SetPoint("TOPLEFT", -15, 0);
				UIDropDownMenu_SetWidth(e.cbEventType, 135);
				UIDropDownMenu_Initialize(e.cbEventType, function(self, level, menuList)
					info.func = function(self)
						e:CbEventType_ValueChanged(self);
						CloseDropDownMenus();
					end;

					if (level or 1) == 1 then
						for eventIndex, eventName in ipairs(c:GetEventNamesSorted()) do
							info.text = c:GetEvents()[eventName];
							info.value = eventName;
							UIDropDownMenu_AddButton(info);
						end
					end
				end);

				local S = c:GetElvUiSkinModule();
				if S then
					S:HandleDropDownBox(e.cbEventType);
				end
			end
			e.cbEventType:Show();
			UIDropDownMenu_SetText(e.cbEventType, c:GetText("on < choose event >"));
		end

		function e:CbEventType_ValueChanged(self)
			e.newBindingValues[c.FIELD_TYPE] = self.value;
			UIDropDownMenu_SetText(e.cbEventType, c:GetEvents()[self.value]);

			e:HideCbEventSubType();
			e:HideCbEventSubSubType();
			e:HideSearchBoxEventSubType();

			if HasEventSubType(self.value) then
				e:ShowCbEventSubType();
			--elseif self.value == c.EVENT_SPELLCAST_START or self.value == c.EVENT_SPELLCAST_SUCCEED then
			--	e:ShowSearchboxEventSubType();
			end

			e.newBindingValues[c.FIELD_SUBTYPE] = nil;
			e.newBindingValues[c.FIELD_SUBSUBTYPE] = nil;
			GqUiFrameEvents_BtnApply:SetEnabled(e:CheckValues());
		end

		-- event subtype (combobox or editbox)
		function e:ShowCbEventSubType()
			if not e.cbEventSubType then
				local info = UIDropDownMenu_CreateInfo();
				info.hasArrow = false;
				info.notCheckable  = true;

				e.cbEventSubType = CreateFrame("Frame", "GqUiFrameEvents_CbEventSubType", GqUiFrameEventsContent, "UIDropDownMenuTemplate");
				e.cbEventSubType:SetPoint("TOPLEFT", -15, -30);
				UIDropDownMenu_SetWidth(e.cbEventSubType, 135);
				UIDropDownMenu_Initialize(e.cbEventSubType, function(self, level, menuList)
					info.func = function(self)
						e:CbEventSubType_ValueChanged(self);
						CloseDropDownMenus();
					end;

					if (level or 1) == 1 then
						if e.newBindingValues[c.FIELD_TYPE] == c.EVENT_CUSTOMSCRIPT then
							-- custom scripts
							for scriptId, script in pairs(c:LoadScripts()) do
								info.text = script[c.FIELD_NAME];
								info.value = script;
								UIDropDownMenu_AddButton(info);
							end
						elseif e.newBindingValues[c.FIELD_TYPE] == c.EVENT_AURA_CHANGED then
							-- paladin aura
							for _, spellDisplayName in ipairs(c:GetPaladinAurasSorted()) do
								info.text = spellDisplayName;
								for spellId, spellName in pairs(c:GetPaladinAuras()) do
									if spellName == spellDisplayName then
										info.value = { name = spellDisplayName, spellId = spellId };
										break;
									end
								end
								UIDropDownMenu_AddButton(info);
							end
						elseif e.newBindingValues[c.FIELD_TYPE] == c.EVENT_STANCE_CHANGED then
							-- warrior stance
							for _, spellDisplayName in ipairs(c:GetWarriorStancesSorted()) do
								info.text = spellDisplayName;
								for spellId, spellName in pairs(c:GetWarriorStances()) do
									if spellName == spellDisplayName then
										info.value = { name = spellDisplayName, spellId = spellId };
										break;
									end
								end
								UIDropDownMenu_AddButton(info);
							end
						elseif e.newBindingValues[c.FIELD_TYPE] == c.EVENT_SHAPESHIFT_IN or e.newBindingValues[c.FIELD_TYPE] == c.EVENT_SHAPESHIFT_OUT then
							-- druid shapeshift
							for _, spellDisplayName in ipairs(c:GetDruidFormsSorted()) do
								info.text = spellDisplayName;
								for spellId, spellName in pairs(c:GetDruidForms()) do
									if spellName == spellDisplayName then
										info.value = { name = spellDisplayName, spellId = spellId };
										break;
									end
								end
								UIDropDownMenu_AddButton(info);
							end
						else
							-- zone enter/leave
							for zoneId, zoneValues in ipairs(c:GetZoneChildrenSorted(947)) do
								info.text = zoneValues["name"];
								info.value = c:Deepcopy(zoneValues);
								UIDropDownMenu_AddButton(info);
							end
						end
					end
				end);

				local S = c:GetElvUiSkinModule();
				if S then
					S:HandleDropDownBox(e.cbEventSubType);
				end
			end
			e.cbEventSubType:Show();

			if e.newBindingValues[c.FIELD_TYPE] == c.EVENT_CUSTOMSCRIPT then
				-- custom scripts
				UIDropDownMenu_SetText(e.cbEventSubType, c:GetText("< choose script >"));
			elseif e.newBindingValues[c.FIELD_TYPE] == c.EVENT_AURA_CHANGED then
				-- paladin aura
				UIDropDownMenu_SetText(e.cbEventSubType, c:GetText("< choose aura >"));
			elseif e.newBindingValues[c.FIELD_TYPE] == c.EVENT_STANCE_CHANGED then
				-- warrior stance
				UIDropDownMenu_SetText(e.cbEventSubType, c:GetText("< choose stance >"));
			elseif e.newBindingValues[c.FIELD_TYPE] == c.EVENT_SHAPESHIFT_IN or e.newBindingValues[c.FIELD_TYPE] == c.EVENT_SHAPESHIFT_OUT then
				-- druid form
				UIDropDownMenu_SetText(e.cbEventSubType, c:GetText("< choose form >"));
			else
				-- zone enter/leave
				UIDropDownMenu_SetText(e.cbEventSubType, c:GetText("< choose zone >"));
			end
		end

		function e:HideCbEventSubType()
			if e.cbEventSubType then
				e.cbEventSubType:Hide();
			end
		end

		function e:CbEventSubType_ValueChanged(self)
			e.newBindingValues[c.FIELD_SUBTYPE] = self.value;

			if e.newBindingValues[c.FIELD_TYPE] == c.EVENT_CUSTOMSCRIPT then
				-- custom scripts
				UIDropDownMenu_SetText(e.cbEventSubType, self.value[c.FIELD_NAME]);
			elseif e.newBindingValues[c.FIELD_TYPE] == c.EVENT_AURA_CHANGED then
				-- paladin aura
				UIDropDownMenu_SetText(e.cbEventSubType, self.value["name"]);
			elseif e.newBindingValues[c.FIELD_TYPE] == c.EVENT_STANCE_CHANGED then
				-- warrior stance
				UIDropDownMenu_SetText(e.cbEventSubType, self.value["name"]);
			elseif e.newBindingValues[c.FIELD_TYPE] == c.EVENT_SHAPESHIFT_IN or e.newBindingValues[c.FIELD_TYPE] == c.EVENT_SHAPESHIFT_OUT then
				-- druid form
				UIDropDownMenu_SetText(e.cbEventSubType, self.value["name"]);
			else
				-- zone enter/leave
				UIDropDownMenu_SetText(e.cbEventSubType, self.value["name"]);

				if table.getn(c:GetZoneChildrenSorted(self.value["mapID"])) > 0 then
					e:ShowCbEventSubSubType();
				elseif e.cbEventSubSubType then
					e.newBindingValues[c.FIELD_SUBSUBTYPE] = nil;
					e.cbEventSubSubType:Hide();
				end
			end

			e.newBindingValues[c.FIELD_SUBSUBTYPE] = nil;
			GqUiFrameEvents_BtnApply:SetEnabled(e:CheckValues());
		end

		function e:ShowSearchboxEventSubType()
			if not e.editBoxEventSubType then
				e.editBoxEventSubType = CreateFrame("EditBox", "GqUiFrameEvents_EditBoxEventSubType", GqUiFrameEventsContent, "SearchBoxTemplate");
				e.editBoxEventSubType:SetPoint("TOPLEFT", 9, -33);
				e.editBoxEventSubType:SetHeight(20);
				e.editBoxEventSubType:SetWidth(145);
				e.editBoxEventSubType:SetScript("OnEnterPressed", function(self)
					e:EditBoxEventSubType_EnterPressed(self);
				end);

				local S = c:GetElvUiSkinModule();
				if S then
					S:HandleDropDownBox(e.editBoxEventSubType);
				end
			end
			e.editBoxEventSubType:Show();
		end

		function e:HideSearchBoxEventSubType()
			if e.editBoxEventSubType then
				e.editBoxEventSubType:Hide();
			end
		end

		function e:EditBoxEventSubType_EnterPressed(self)
			local spells, maxResultsExceeded = c:SearchSpells(self:GetText());
			if spells and table.getn(spells) > 0 then
				e.spellSearchResults = spells;
				if maxResultsExceeded then
					e:SetErrorMessage(c:GetText("Maximum search results (%s) exceeded.", maxResultsExceeded));
				end
				e:ShowCbEventSubSubType();
			else
				e.spellSearchResults = nil;
				e:HideCbEventSubSubType();
			end
		end

		-- eventsubsubtype (combobox)
		function e:ShowCbEventSubSubType()
			if not e.cbEventSubSubType then
				local info = UIDropDownMenu_CreateInfo();
				info.hasArrow = false;
				info.notCheckable  = true;

				e.cbEventSubSubType = CreateFrame("Frame", "GqUiFrameEvents_CbEventSubSubType", GqUiFrameEventsContent, "UIDropDownMenuTemplate");
				e.cbEventSubSubType:SetPoint("TOPLEFT", -15, -60);
				UIDropDownMenu_SetWidth(e.cbEventSubSubType, 135);
				UIDropDownMenu_Initialize(e.cbEventSubSubType, function(self, level, menuList)
					info.func = function(self)
						e:CbEventSubSubType_ValueChanged(self);
						CloseDropDownMenus();
					end;

					if (level or 1) == 1 then
						if e.newBindingValues[c.FIELD_TYPE] == c.EVENT_ZONE_ENTER or e.newBindingValues[c.FIELD_TYPE] == c.EVENT_ZONE_LEAVE then
							for zoneId, zoneValues in ipairs(c:GetZoneChildrenSorted(e.newBindingValues[c.FIELD_SUBTYPE]["mapID"])) do
								info.text = zoneValues["name"];
								info.value = c:Deepcopy(zoneValues);
								UIDropDownMenu_AddButton(info);
							end
						--elseif e.newBindingValues[c.FIELD_TYPE] == c.EVENT_SPELLCAST_START or e.newBindingValues[c.FIELD_TYPE] == c.EVENT_SPELLCAST_SUCCEED and e.spellSearchResults then
						--	for spellId, spell in pairs(e.spellSearchResults) do
						--		info.text = spell["name"];
						--		info.value = c:Deepcopy(spell);
						--		UIDropDownMenu_AddButton(info);
						--	end
						end
					end
				end);

				local S = c:GetElvUiSkinModule();
				if S then
					S:HandleDropDownBox(e.cbEventSubSubType);
				end
			end

			e.cbEventSubSubType:Show();
			if e.newBindingValues[c.FIELD_TYPE] == c.EVENT_ZONE_ENTER or e.newBindingValues[c.FIELD_TYPE] == c.EVENT_ZONE_LEAVE then
				UIDropDownMenu_SetText(e.cbEventSubSubType, c:GetText("< subzone (optional) >"));
			elseif e.newBindingValues[c.FIELD_TYPE] == c.EVENT_AURA_CHANGED then
				-- paladin aura
				UIDropDownMenu_SetText(e.cbEventSubSubType, c:GetText("< choose aura >"));
			elseif e.newBindingValues[c.FIELD_TYPE] == c.EVENT_STANCE_CHANGED then
				-- warrior stance
				UIDropDownMenu_SetText(e.cbEventSubSubType, c:GetText("< choose stance >"));
			elseif e.newBindingValues[c.FIELD_TYPE] == c.EVENT_SHAPESHIFT_IN or e.newBindingValues[c.FIELD_TYPE] == c.EVENT_SHAPESHIFT_OUT then
				-- druid form
				UIDropDownMenu_SetText(e.cbEventSubSubType, c:GetText("< choose form >"));
			--elseif e.newBindingValues[c.FIELD_TYPE] == c.EVENT_SPELLCAST_START or e.newBindingValues[c.FIELD_TYPE] == c.EVENT_SPELLCAST_SUCCEED then
			--	UIDropDownMenu_SetText(e.cbEventSubSubType, c:GetText("< choose spell >"));
			end
		end

		function e:HideCbEventSubSubType()
			if e.cbEventSubSubType then
				e.cbEventSubSubType:Hide();
			end
		end

		function e:CbEventSubSubType_ValueChanged(self)
			e.newBindingValues[c.FIELD_SUBSUBTYPE] = self.value;
			UIDropDownMenu_SetText(e.cbEventSubSubType, self.value["name"]);
			GqUiFrameEvents_BtnApply:SetEnabled(e:CheckValues());
		end

		-- set name
		function e:ShowCbSetName()
			if not e.cbSetName then
				local info = UIDropDownMenu_CreateInfo();
				info.hasArrow = false;
				info.notCheckable  = true;

				e.cbSetName = CreateFrame("Frame", "GqUiFrameEvents_CbSetName", GqUiFrameEventsContent, "UIDropDownMenuTemplate");
				e.cbSetName:SetPoint("TOPRIGHT", 15, -30);
				UIDropDownMenu_SetWidth(e.cbSetName, 135);
				UIDropDownMenu_Initialize(e.cbSetName, function(self, level, menuList)
					info.func = function(self)
						e:CbSetName_ValueChanged(self);
						CloseDropDownMenus();
					end;

					if (level or 1) == 1 then
						info.text = c:GetText("[Previous set]");
						info.value = c.KEYWORD_PREVIOUS;
						UIDropDownMenu_AddButton(info);

						info.text = c:GetText("[Previous equipment]");
						info.value = c.KEYWORD_PREVIOUSEQUIPMENT;
						UIDropDownMenu_AddButton(info);

						for index, setName in ipairs(c:LoadSetNames()) do
							info.text = setName;
							info.value = setName;
							UIDropDownMenu_AddButton(info);
						end
					end
				end);

				local S = c:GetElvUiSkinModule();
				if S then
					S:HandleDropDownBox(e.cbSetName);
					e.cbSetName:SetPoint("TOPRIGHT", -10, -30);
				end
			end
			e.cbSetName:Show();
			UIDropDownMenu_SetText(e.cbSetName, c:GetText("< choose set >"));
		end

		function e:CbSetName_ValueChanged(self)
			e.newBindingValues[c.FIELD_NAME] = self.value;
			if self.value == c.KEYWORD_PREVIOUS then
				UIDropDownMenu_SetText(e.cbSetName, c:GetText("[Previous set]"));
			elseif self.value == c.KEYWORD_PREVIOUSEQUIPMENT then
				UIDropDownMenu_SetText(e.cbSetName, c:GetText("[Previous equipment]"));
			else
				UIDropDownMenu_SetText(e.cbSetName, self.value);
			end
			GqUiFrameEvents_BtnApply:SetEnabled(e:CheckValues());
		end

		-- pvp / pve checkboxes
		function GqUiFrameEvents_CbPVE_OnClick(self)
			e.newBindingValues[c.FIELD_PVE] = self:GetChecked();
			GqUiFrameEvents_BtnApply:SetEnabled(e:CheckValues());
		end

		function GqUiFrameEvents_CbPVP_OnClick(self)
			e.newBindingValues[c.FIELD_PVP] = self:GetChecked();
			GqUiFrameEvents_BtnApply:SetEnabled(e:CheckValues());
		end

		-- apply / cancel buttons
		function GqUiFrameEvents_BtnApply_OnClick()
			if c:BindEvent(e.newBindingValues) then
				c:RefreshEventEntries();
				GqUiFrameEvents:Hide();
			end
		end

		function GqUiFrameEvents_BtnCancel_OnClick()
			GqUiFrameEvents:Hide();
		end

		-- initialization
		GqUiFrameEventsFontString:SetText(c:GetText("GearQuipper - New event binding"));
		GqUiFrameEventsSetLabelFontString:SetText(c:GetText("... equip set:"));
		GqUiFrameEvents_CbPVEFontString:SetText(c:GetText("in PvE situations"));
		GqUiFrameEvents_CbPVPFontString:SetText(c:GetText("in PvP situations"));
		GqUiFrameEvents_BtnApply:SetText(c:GetText("Apply"));
		GqUiFrameEvents_BtnCancel:SetText(c:GetText("Cancel"));

		GqUiFrameEvents_BtnApply:SetEnabled(false);
		table.insert(UISpecialFrames, GqUiFrameEvents:GetName());

		local S = c:GetElvUiSkinModule();
		if S then
			S:HandleFrame(GqUiFrameEvents);
			GqUiFrameEvents:SetBackdropColor(0, 0, 0, 1);
			S:HandleCheckBox(GqUiFrameEvents_CbPVE);
			S:HandleCheckBox(GqUiFrameEvents_CbPVP);
			S:HandleButton(GqUiFrameEvents_BtnApply);
			S:HandleButton(GqUiFrameEvents_BtnCancel);
			GqUiFrameEvents.CloseButton:Hide();
		end
	end

	-- misc stuff
	function e:CheckValues()
		e:SetErrorMessage();
		if e.newBindingValues then
			if c:BindingExists(e.newBindingValues) then
				e:SetErrorMessage(c:GetText("This event already exists."));
				return false;
			end
			return (e.newBindingValues[c.FIELD_PVE] or e.newBindingValues[c.FIELD_PVP]) and
					e.newBindingValues[c.FIELD_NAME] and e.newBindingValues[c.FIELD_TYPE] and
					((e.newBindingValues[c.FIELD_TYPE] ~= c.EVENT_ZONE_ENTER and
						e.newBindingValues[c.FIELD_TYPE] ~= c.EVENT_ZONE_LEAVE and
						e.newBindingValues[c.FIELD_TYPE] ~= c.EVENT_CUSTOMSCRIPT and
						e.newBindingValues[c.FIELD_TYPE] ~= c.EVENT_SHAPESHIFT_IN and
						e.newBindingValues[c.FIELD_TYPE] ~= c.EVENT_SHAPESHIFT_OUT and
						e.newBindingValues[c.FIELD_TYPE] ~= c.EVENT_AURA_CHANGED and
						e.newBindingValues[c.FIELD_TYPE] ~= c.EVENT_STANCE_CHANGED) or e.newBindingValues[c.FIELD_SUBTYPE]);
		end
	end

	function e:SetErrorMessage(text)
		GqUiFrameEventsErrorsLabelFontString:SetText(text);
	end

	function c:BindEvent(bindingValues)
		if bindingValues[c.FIELD_TYPE] and bindingValues[c.FIELD_NAME] then
			if not HasEventSubType(bindingValues[c.FIELD_TYPE]) or bindingValues[c.FIELD_SUBTYPE] then
				if not c:BindingExists(bindingValues) then
					c:SaveEventBinding(bindingValues);
					return true;
				end
			end
		end
	end

	e:HideCbEventSubType();
	e:HideCbEventSubSubType();
	e:HideSearchBoxEventSubType();

	e.newBindingValues = { [c.FIELD_PVE] = true, [c.FIELD_PVP] = true };
	e:ShowCbEventType();
	e:ShowCbSetName();

	GqUiFrameEvents_CbPVE:SetChecked(true);
	GqUiFrameEvents_CbPVP:SetChecked(true);
end