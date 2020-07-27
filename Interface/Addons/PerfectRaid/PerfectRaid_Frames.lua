--[[-------------------------------------------------------------------------
  Copyright (c) 2006, Jim Whitehead II <cladhaire@gmail.com>
  All rights reserved.

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are
  met:

      * Redistributions of source code must retain the above copyright
        notice, this list of conditions and the following disclaimer.
      * Redistributions in binary form must reproduce the above
        copyright notice, this list of conditions and the following
        disclaimer in the documentation and/or other materials provided
        with the distribution.
      * Neither the name of PerfectRaid nor the names of its contributors
        may be used to endorse or promote products derived from this software
        without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
---------------------------------------------------------------------------]]

local Frames = PerfectRaid:NewModule("PerfectRaid-Frames")
local L = PerfectRaidLocals
local utils, frames

function Frames:Initialize()
	frames = PerfectRaid.frames
	utils = PerfectRaid.utils
	self:RegisterMessage("DONGLE_PROFILE_CREATED")
end

function Frames:Enable()
	self:RegisterMessage("PERFECTRAID_TAB_CHANGED")
end

function Frames:ConfigureButton(button)
end

function Frames:ShowButton(button)
end

function Frames:DONGLE_PROFILE_CREATED(event, db, addon, svname, profileKey)
	if svname ~= "PerfectRaidDB" then return end
	self:PrintF(L["Adding a default raid layout to new profile \"%s\""], profileKey)
	local entry = {
		numColumns = 2,
		scale = 1,
		colSpacing = 0,
		sortType = "NAME",
		deficit = 1,
		colAnchor = "LEFT",
		filter = "WARRIOR,DEATHKNIGHT,PRIEST,DRUID,SHAMAN,PALADIN,MONK,MAGE,ROGUE,WARLOCK,HUNTER,DEMONHUNTER",
		groupBy = "CLASS",
		maxUnits = 25,
	}
	table.insert(db.profile.headers, entry)
end

function Frames:PERFECTRAID_TAB_CHANGED(old, new)
	if PROptions_Frames_Edit and PROptions_Frames_Edit:IsVisible() then
		self:CancelEntry()
		PROptions_Frames:Hide()
	end
end

function Frames:CreateOptions(opt)
	self.options = opt
	local options = CreateFrame("Frame", "PROptions_Frames", PROptions)
	opt:AddOptionsTab(L["Raid Frames"], options)

	local num_entries = 19
	local scrollframe = opt:CreateListFrame(options, num_entries)

	-- Set up double-click handlers
	local function OnDoubleClick(button)
		button:Click()
		self:EditEntry()
	end

	for i=1,num_entries do
		button = scrollframe.entries[i]
		button:SetScript("OnDoubleClick", OnDoubleClick)
	end

	local update = function()
		local list = PerfectRaid.db.profile.headers

		local idx,button
		local offset = FauxScrollFrame_GetOffset(scrollframe)
		FauxScrollFrame_Update(scrollframe, #list, num_entries, 20)
		for i=1,num_entries do
			idx = offset + i
			button = scrollframe.entries[i]
			if idx <= #list then
				local entry = list[idx]
				local work = {}

				if entry.showParty then table.insert(work, L["inParty"]) end
				if entry.showRaid then table.insert(work, L["inRaid"]) end
				if entry.showPlayer then table.insert(work, L["showPlayer"]) end
				if entry.showSolo then table.insert(work, L["showSolo"]) end
				local flags = string.join(",", unpack(work))

				if #flags > 0 then
					flags = flags .. ","
				end

				local display
				if entry.title then
					display = string.format("%s%s: %s%s", entry.disabled and L["Disabled: "] or "", entry.title, flags, entry.filter or L["No filters selected"])
				else
					display = string.format("%s%s%s", entry.disabled and L["Disabled: "] or "", flags, entry.filter or L["No filters selected"])
				end

				button.tooltip = L["This frame has the following options/filters set:"] .. display:gsub(",", ", ")

				button.line1:SetText(display)
				button:Show()
				if PROptions_Frames.selected == idx then
					button:SetChecked(true)
				else
					button:SetChecked(false)
				end
			else
				button:Hide()
			end
		end
		self:EnableButtons()
	end

	scrollframe.update = update

	scrollframe:SetScript("OnVerticalScroll", function(frame, value)
		FauxScrollFrame_OnVerticalScroll(frame, value, 20, update)
		self:EnableButtons()
	end)
	scrollframe:SetScript("OnShow", function()
		scrollframe.update()
		self:EnableButtons()
	end)

	local postClick = function()
		self:EnableButtons()
	end

	for i,frame in ipairs(scrollframe.entries) do
		frame:SetScript("PostClick", postClick)
	end

	self.scrollframe = scrollframe

	local delete = CreateFrame("Button", "PRFrames_Delete", options, "PRButtonTemplate")
	delete:SetText(L["Delete"])
	delete:SetPoint("BOTTOMRIGHT", 0, 5)
	delete:SetScript("OnClick", function() self:DeleteEntry() end)
	delete:Show()

	local edit = CreateFrame("Button", "PRFrames_Edit", options, "PRButtonTemplate")
	edit:SetText(L["Edit"])
	edit:SetPoint("BOTTOMRIGHT", delete, "BOTTOMLEFT", -10, 0)
	edit:SetScript("OnClick", function() self:EditEntry() end)
	edit:Show()

	local add = CreateFrame("Button", "PRFrames_Add", options, "PRButtonTemplate")
	add:SetText(L["Add"])
	add:SetPoint("BOTTOMRIGHT", edit, "BOTTOMLEFT", -10, 0)
	add:SetScript("OnClick", function() self:AddEntry() end)
	add:Show()

	local disable = CreateFrame("Button", "PRFrames_Disable", options, "PRButtonTemplate")
	disable:SetText(L["Disable"])
	disable:SetPoint("BOTTOMRIGHT", add, "BOTTOMLEFT", -10, 0)
	disable:SetScript("OnClick", function() self:DisableEntry() end)
	disable:Show()

	self:CreateEditFrame(options)
end

function Frames:CreateEditFrame(parent)
	local frame = CreateFrame("Frame", "PROptions_Frames_Edit", PROptions)
	local name = "PROptions_Frames_Edit"
	frame:SetAllPoints(PROptions_Frames)
	frame:SetFrameLevel(frame:GetFrameLevel() + 1)
	frame:Hide()

	local title = CreateFrame("EditBox", name.."Title", frame, "InputBoxTemplate")
	local font = title:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	font:SetText(L["Title:"])
	font:SetPoint("BOTTOMLEFT", title, "TOPLEFT", 0, 3)
	title:SetPoint("TOPLEFT", 0, -10)
	title:SetAutoFocus(nil)
	title:SetWidth(180)
	title:SetHeight(20)
	title:Show()
	frame.title = title

	local groupByDropDown = CreateFrame("Frame", "PRFrames_GroupByDropDown", frame, "UIDropDownMenuTemplate")
	local clickFunc = function(self) UIDropDownMenu_SetSelectedValue(groupByDropDown, self.value) end
	groupByDropDown.Initialize = function()
		UIDropDownMenu_AddButton{text = L["None"], value = -1, func = clickFunc}
		UIDropDownMenu_AddButton{text = L["Group"], value = "GROUP", func = clickFunc}
		UIDropDownMenu_AddButton{text = L["Class"], value = "CLASS", func = clickFunc}
	end
	groupByDropDown:SetScript("OnShow", function(f)
		UIDropDownMenu_Initialize(PRFrames_GroupByDropDown, groupByDropDown.Initialize)
	end)
	groupByDropDown:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -125, -10)
	local font = groupByDropDown:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	font:SetText(L["Group frames by:"])
	font:SetPoint("BOTTOMLEFT", groupByDropDown, "TOPLEFT", 0, 0)


	local sortDropDown = CreateFrame("Frame", "PRFrames_SortDropDown", frame, "UIDropDownMenuTemplate")
	local clickFunc = function(self) UIDropDownMenu_SetSelectedValue(sortDropDown, self.value) end
	sortDropDown.Initialize = function()
		UIDropDownMenu_AddButton{text = L["None"], value = -1, func = clickFunc}
		UIDropDownMenu_AddButton{text = L["Name"], value = "NAME", func = clickFunc}
		UIDropDownMenu_AddButton{text = L["Index"], value = "INDEX", func = clickFunc}
	end
	sortDropDown:SetScript("OnShow", function(f)
		UIDropDownMenu_Initialize(sortDropDown, sortDropDown.Initialize)
	end)
	sortDropDown:SetPoint("RIGHT", groupByDropDown, "LEFT", -150, 0)
	local font = sortDropDown:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	font:SetText(L["Sort Frames By:"])
	font:SetPoint("BOTTOMLEFT", sortDropDown, "TOPLEFT", 0, 0)

	self.filters = {}
	local function makeCheck(label, value)
		local button = CreateFrame("CheckButton", "PRFrameFilter_"..value, PROptions_Frames_Edit, "PRCheckTemplate")
		button.Label:SetText(label)
		button.value = value
		table.insert(self.filters, button)
		button:Show()
		return button
	end

	makeCheck(L["Warrior"], "WARRIOR")
	makeCheck(L["Death Knight"], "DEATHKNIGHT")
	makeCheck(L["Priest"], "PRIEST")
	makeCheck(L["Druid"], "DRUID")
	makeCheck(L["Shaman"], "SHAMAN")
	makeCheck(L["Paladin"], "PALADIN")
	makeCheck(L["Monk"], "MONK")
	makeCheck(L["Mage"], "MAGE")
	makeCheck(L["Rogue"], "ROGUE")
	makeCheck(L["Warlock"], "WARLOCK")
	makeCheck(L["Hunter"], "HUNTER")
    makeCheck(L["Demon Hunter"], "DEMONHUNTER")
	makeCheck(L["Group 1"], "1")
	makeCheck(L["Group 2"], "2")
	makeCheck(L["Group 3"], "3")
	makeCheck(L["Group 4"], "4")
	makeCheck(L["Group 5"], "5")
	makeCheck(L["Group 6"], "6")
	makeCheck(L["Group 7"], "7")
	makeCheck(L["Group 8"], "8")
	makeCheck(L["All Classes"], "WARRIOR,DEATHKNIGHT,PRIEST,DRUID,SHAMAN,PALADIN,MONK,MAGE,ROGUE,WARLOCK,HUNTER,DEMONHUNTER")
	makeCheck(L["All Groups"], "1,2,3,4,5,6,7,8")
	makeCheck(L["Main tanks"], "MAINTANK")
	makeCheck(L["Main assists"], "MAINASSIST")

	for idx,button in ipairs(self.filters) do
		if idx == 1 then
			button:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -15)
		elseif math.fmod(idx - 1, 6) == 0 then
			button:SetPoint("TOPLEFT", self.filters[idx-6], "BOTTOMLEFT", 0, 0)
		else
			button:SetPoint("LEFT", self.filters[idx-1], "RIGHT", 60, 0)
		end
	end

	local numCols = CreateFrame("EditBox", name.."NumCols", frame, "InputBoxTemplate")
	local font = numCols:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	font:SetText(L["Number of Columns:"])
	font:SetPoint("RIGHT", numCols, "LEFT", -10, 0)
	numCols:SetPoint("BOTTOMRIGHT", -5, 180)
	numCols:SetAutoFocus(nil)
	numCols:SetWidth(50)
	numCols:SetHeight(20)
	numCols:Show()
	frame.numCols = numCols

	local maxUnits = CreateFrame("EditBox", name.."MaxUnits", frame, "InputBoxTemplate")
	local font = maxUnits:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	font:SetText(L["Max Units per Column:"])
	font:SetPoint("RIGHT", maxUnits, "LEFT", -10, 0)
	maxUnits:SetPoint("TOPLEFT", numCols, "BOTTOMLEFT", 0, -5)
	maxUnits:SetAutoFocus(nil)
	maxUnits:SetWidth(50)
	maxUnits:SetHeight(20)
	maxUnits:Show()
	frame.maxUnits = maxUnits

	local colSpacing = CreateFrame("EditBox", name.."ColSpacing", frame, "InputBoxTemplate")
	local font = colSpacing:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	font:SetText(L["Spacing between columns:"])
	font:SetPoint("RIGHT", colSpacing, "LEFT", -10, 0)
	colSpacing:SetPoint("TOPLEFT", maxUnits, "BOTTOMLEFT", 0, -5)
	colSpacing:SetAutoFocus(nil)
	colSpacing:SetWidth(50)
	colSpacing:SetHeight(20)
	colSpacing:Show()
	frame.colSpacing = colSpacing

	local colAnchorDropDown = CreateFrame("Frame", "PRFrames_ColAnchorDropDown", frame, "UIDropDownMenuTemplate")
	local clickFunc = function(self) UIDropDownMenu_SetSelectedValue(colAnchorDropDown, self.value) end
	local points = {"TOP", "TOPLEFT", "TOPRIGHT", "LEFT", "RIGHT", "BOTTOM", "BOTTOMLEFT", "BOTTOMRIGHT"}
	colAnchorDropDown.Initialize = function()
		UIDropDownMenu_AddButton{text = L["None"], value = -1, func = clickFunc}
		for k,v in pairs(points) do
			UIDropDownMenu_AddButton{text = v, value = v, func = clickFunc}
		end
	end
	colAnchorDropDown:SetScript("OnShow", function(f)
		UIDropDownMenu_Initialize(colAnchorDropDown, colAnchorDropDown.Initialize)
	end)
	colAnchorDropDown:SetPoint("TOPRIGHT", colSpacing, "BOTTOMRIGHT", -100, -25)
	local font = sortDropDown:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	font:SetText(L["Column Anchor Point:"])
	font:SetPoint("RIGHT", colSpacing, "BOTTOMLEFT", -10, -15)

	local hbackdrop = CreateFrame("CheckButton", "PRFrame_HeaderBackdrop", PROptions_Frames_Edit, "PRCheckTemplate")
	hbackdrop.Label:SetText(L["Display a header backdrop"])
	hbackdrop:SetPoint("BOTTOMLEFT", 0, 210)
	hbackdrop:Show()

	local strict = CreateFrame("CheckButton", "PRFrame_Strict", PROptions_Frames_Edit, "PRCheckTemplate")
	strict.Label:SetText(L["Make filters strict"])
	strict:SetPoint("TOPLEFT", hbackdrop, "BOTTOMLEFT", 0, 0)
	strict:Show()

	local classColor = CreateFrame("CheckButton", "PRFrame_ColorClass", PROptions_Frames_Edit, "PRCheckTemplate")
	classColor.Label:SetText(L["Color bars by class"])
	classColor:SetPoint("TOPLEFT", strict, "BOTTOMLEFT", 0, 0)
	classColor:Show()

	local showGroupNum = CreateFrame("CheckButton", "PRFrame_ShowGroupNum", PROptions_Frames_Edit, "PRCheckTemplate")
	showGroupNum.Label:SetText(L["Show group number"])
	showGroupNum:SetPoint("TOPLEFT", classColor, "BOTTOMLEFT", 0, 0)
	showGroupNum:Show()

	local reverseBar = CreateFrame("CheckButton", "PRFrame_ReverseBar", PROptions_Frames_Edit, "PRCheckTemplate")
	reverseBar.Label:SetText(L["Reverse HP bars"])
	reverseBar:SetPoint("TOPLEFT", hbackdrop, "TOPRIGHT", 160, 0)
	reverseBar:Show()

	local showDeficit = CreateFrame("CheckButton", "PRFrame_Deficit", PROptions_Frames_Edit, "PRCheckTemplate")
	showDeficit.Label:SetText(L["Show HP deficit"])
	showDeficit:SetPoint("TOPLEFT", reverseBar, "BOTTOMLEFT", 0, 0)
	showDeficit:Show()

	local alignRight = CreateFrame("CheckButton", "PRFrame_AlignRight", PROptions_Frames_Edit, "PRCheckTemplate")
	alignRight.Label:SetText(L["Align frames to RIGHT"])
	alignRight:SetPoint("TOPLEFT", showDeficit, "BOTTOMLEFT", 0, 0)
	alignRight:Show()

	local alignBottom = CreateFrame("CheckButton", "PRFrame_AlignBottom", PROptions_Frames_Edit, "PRCheckTemplate")
	alignBottom.Label:SetText(L["Align frames to BOTTOM"])
	alignBottom:SetPoint("TOPLEFT", alignRight, "BOTTOMLEFT", 0, 0)
	alignBottom:Show()

	-- showRaid = [BOOLEAN] -- true if the header should be shown while in a raid
	-- showParty = [BOOLEAN] -- true if the header should be shown while in a party and not in a raid
	-- showPlayer = [BOOLEAN] -- true if the header should show the player when not in a raid
	-- showSolo = [BOOLEAN] -- true if the header should be shown while not in a group (implies showPlayer)

	local showRaid = CreateFrame("CheckButton", "PRFrame_ShowRaid", PROptions_Frames_Edit, "PRCheckTemplate")
	showRaid.Label:SetText(L["Show frame in raid"])
	showRaid:SetPoint("TOPLEFT", showGroupNum, "BOTTOMLEFT", 0, 0)
	showRaid:Show()

	local showParty = CreateFrame("CheckButton", "PRFrame_ShowParty", PROptions_Frames_Edit, "PRCheckTemplate")
	showParty.Label:SetText(L["Show frame while in party"])
	showParty:SetPoint("TOPLEFT", showRaid, "BOTTOMLEFT", 0, 0)
	showParty:Show()

	local showPlayer = CreateFrame("CheckButton", "PRFrame_ShowPlayer", PROptions_Frames_Edit, "PRCheckTemplate")
	showPlayer.Label:SetText(L["Show player in frame"])
	showPlayer:SetPoint("TOPLEFT", alignBottom, "BOTTOMLEFT", 0, 0)
	showPlayer:Show()

	local showSolo = CreateFrame("CheckButton", "PRFrame_ShowSolo", PROptions_Frames_Edit, "PRCheckTemplate")
	showSolo.Label:SetText(L["Show frame when solo"])
	showSolo:SetPoint("TOPLEFT", showPlayer, "BOTTOMLEFT", 0, 0)
	showSolo:Show()

	showSolo:SetScript("PostClick", function(self)
										if self:GetChecked() then
											showPlayer:SetChecked(true)
										end
									end)

    local vehicleSwap = CreateFrame("CheckButton", "PRFrame_VehicleSwap", PROptions_Frames_Edit, "PRCheckTemplate")
    vehicleSwap.Label:SetText(L["Swap unit in vehicle"])
    vehicleSwap:SetPoint("TOPLEFT", showParty, "BOTTOMLEFT", 0, 0)
    vehicleSwap:Show()

--[[
	local hborderswatch = self:CreateSwatch("PRFrame_HBorder_Color", PROptions_Frames_Edit)
	local fborderswatch = self:CreateSwatch("PRFrame_FBorder_Color", PROptions_Frames_Edit)
	local fbackdropswatch = self:CreateSwatch("PRFrame_FBackdrop_Color", PROptions_Frames_Edit)
	local hbackdropswatch = self:CreateSwatch("PRFrame_HBackdrop_Color", PROptions_Frames_Edit)
	hborderswatch:SetPoint("LEFT", hborder, "RIGHT", 175, 0)
	fborderswatch:SetPoint("LEFT", fborder, "RIGHT", 175, 0)
	fbackdropswatch:SetPoint("LEFT", fbackdrop, "RIGHT", 175, 0)
	hbackdropswatch:SetPoint("LEFT", hbackdrop, "RIGHT", 175, 0)
--]]

	local slider = CreateFrame("Slider", "PRFrame_Scale", PROptions_Frames_Edit, "PRSliderTemplate")
	slider.Text:SetText(L["Frame Scale:"])
	slider.High:SetText("2.0")
	slider.Low:SetText("0.1")
	slider:SetWidth(125)
	slider:SetMinMaxValues(0.1,2.0)
	slider:SetValueStep(0.05)
	slider:SetPoint("TOP", PRFrames_ColAnchorDropDown, "BOTTOM", 20, -10)
	slider:SetValue(1.0)
	slider:Show()

	local slider = CreateFrame("Slider", "PRFrame_ManaHeight", PROptions_Frames_Edit, "PRSliderTemplate")
	slider.Text:SetText(L["Mana Bar Height:"])
	slider.High:SetText("10")
	slider.Low:SetText("0")
	slider:SetWidth(125)
	slider:SetMinMaxValues(0,10)
	slider:SetValueStep(1)
	slider:SetPoint("TOP", PRFrame_Scale, "BOTTOM", 0, -20)
	slider:SetValue(2.0)
	slider:Show()

	local cancel = CreateFrame("Button", "PRFrames_Cancel", PROptions_Frames_Edit, "PRButtonTemplate")
	cancel:SetText(L["Cancel"])
	cancel:SetPoint("BOTTOMLEFT", 100, 5)
	cancel:SetScript("OnClick", function() self:CancelEntry() end)
	cancel:Show()

	local save = CreateFrame("Button", "PRFrames_Save", PROptions_Frames_Edit, "PRButtonTemplate")
	save:SetText(L["Save"])
	save:SetPoint("BOTTOMRIGHT", cancel, "BOTTOMLEFT", -10, 0)
	save:SetScript("OnClick", function() self:SaveEntry() end)
	save:Show()

	local function onTabPressed(self)
		if IsShiftKeyDown() then
			self.prev:SetFocus()
		else
			self.next:SetFocus()
		end
	end
	PROptions_Frames_EditTitle.next = PROptions_Frames_EditNumCols
	PROptions_Frames_EditTitle.prev = PROptions_Frames_EditColSpacing
	PROptions_Frames_EditTitle:SetScript("OnTabPressed", onTabPressed)

	PROptions_Frames_EditNumCols.next = PROptions_Frames_EditMaxUnits
	PROptions_Frames_EditNumCols.prev = PROptions_Frames_EditTitle
	PROptions_Frames_EditNumCols:SetScript("OnTabPressed", onTabPressed)

	PROptions_Frames_EditMaxUnits.next = PROptions_Frames_EditColSpacing
	PROptions_Frames_EditMaxUnits.prev = PROptions_Frames_EditNumCols
	PROptions_Frames_EditMaxUnits:SetScript("OnTabPressed", onTabPressed)

	PROptions_Frames_EditColSpacing.next = PROptions_Frames_EditTitle
	PROptions_Frames_EditColSpacing.prev = PROptions_Frames_EditMaxUnits
	PROptions_Frames_EditColSpacing:SetScript("OnTabPressed", onTabPressed)
end

function Frames:DisableEntry()
	local idx = PROptions_Frames.selected
	local list = PerfectRaid.db.profile.headers
	local entry = list[idx]

	entry.disabled = not entry.disabled
	self.scrollframe.update()
	PerfectRaid:UpdateRaidFrames()
end

function Frames:EditEntry()
	local idx = PROptions_Frames.selected
	local list = PerfectRaid.db.profile.headers
	local entry = list[idx]
	self.editEntry = entry

	self.options:FadeIn(PROptions_Frames_Edit)
	self.options:FadeOut(PROptions_Frames)
	PROptions_Frames_EditTitle:SetFocus()

	PROptions_Frames_EditTitle:SetText(entry.title or "")
	UIDropDownMenu_SetSelectedValue(PRFrames_GroupByDropDown, entry.groupBy)
	UIDropDownMenu_SetSelectedValue(PRFrames_SortDropDown, entry.sortType)
	UIDropDownMenu_SetText(PRFrames_GroupByDropDown, entry.groupBy or "")
	UIDropDownMenu_SetText(PRFrames_SortDropDown, entry.sortType or "")
	local filterTbl = {strsplit(",", entry.filter or "")}
	for k,v in pairs(filterTbl) do filterTbl[v] = true end

	local partyFrame = entry.partyFrame
	for k,v in pairs(self.filters) do
		if v.value == "Party" then
			v:SetChecked(partyFrame)
		elseif filterTbl[v.value] then
			v:SetChecked(true)
		end
	end

	PROptions_Frames_EditNumCols:SetText(entry.numColumns or "")
	PROptions_Frames_EditMaxUnits:SetText(entry.maxUnits or "")
	PROptions_Frames_EditColSpacing:SetText(entry.colSpacing or "")
	UIDropDownMenu_SetSelectedValue(PRFrames_ColAnchorDropDown, entry.colAnchor)
	PRFrame_HeaderBackdrop:SetChecked(entry.hBackdrop)
	PRFrame_Scale:SetValue(entry.scale)
	PRFrame_ManaHeight:SetValue(entry.manaheight or 0)
	PRFrame_Strict:SetChecked(entry.strict)

	PRFrame_ColorClass:SetChecked(entry.colorclass)
	PRFrame_ShowGroupNum:SetChecked(entry.showgroupnum)
	PRFrame_ReverseBar:SetChecked(entry.reverse)
	PRFrame_Deficit:SetChecked(entry.deficit)
	PRFrame_AlignRight:SetChecked(entry.alignright)
	PRFrame_AlignBottom:SetChecked(entry.alignbottom)

	PRFrame_ShowParty:SetChecked(entry.showParty)
	PRFrame_ShowRaid:SetChecked(entry.showRaid)
	PRFrame_ShowPlayer:SetChecked(entry.showPlayer)
	PRFrame_ShowSolo:SetChecked(entry.showSolo)

	PRFrame_VehicleSwap:SetChecked(entry.vehicleSwap)
end

function Frames:AddEntry()
	PROptions_Frames.selected = nil
	self.editEntry = nil
	self.options:FadeIn(PROptions_Frames_Edit)
	self.options:FadeOut(PROptions_Frames)
	PROptions_Frames_EditTitle:SetFocus()
end

function Frames:DeleteEntry()
	local idx = PROptions_Frames.selected
	local list = PerfectRaid.db.profile.headers
	table.remove(list, idx)
	PROptions_Frames.selected = nil
	self.editEntry = nil
	self.scrollframe.update()
	PerfectRaid:UpdateRaidFrames()
end

function Frames:EnableButtons()
	if PROptions_Frames.selected then
		PRFrames_Edit:Enable()
		PRFrames_Delete:Enable()
		PRFrames_Disable:Enable()
		local list = PerfectRaid.db.profile.headers
		local entry = list[PROptions_Frames.selected]
		if entry.disabled then
			PRFrames_Disable:SetText(L["Enable"])
		else
			PRFrames_Disable:SetText(L["Disable"])
		end
	else
		PRFrames_Edit:Disable()
		PRFrames_Delete:Disable()
		PRFrames_Disable:Disable()
	end
end

function Frames:SaveEntry()
	local title = PROptions_Frames_EditTitle:GetText()
	local groupBy = UIDropDownMenu_GetSelectedValue(PRFrames_GroupByDropDown)
	local sortType = UIDropDownMenu_GetSelectedValue(PRFrames_SortDropDown)
	local partyFrame

	local filterTbl = {}
	for k,v in pairs(self.filters) do
		if v:GetChecked() then
			table.insert(filterTbl, v.value)
		end
	end

	local filter = strjoin(",", unpack(filterTbl))
	local numColumns = tonumber(PROptions_Frames_EditNumCols:GetText())
	local maxUnits = tonumber(PROptions_Frames_EditMaxUnits:GetText())
	local colSpacing = tonumber(PROptions_Frames_EditColSpacing:GetText())
	local colAnchor = UIDropDownMenu_GetSelectedValue(PRFrames_ColAnchorDropDown)
	local hBackdrop = PRFrame_HeaderBackdrop:GetChecked()
	local scale = PRFrame_Scale:GetValue()
	local manaheight = PRFrame_ManaHeight:GetValue()
	local strict = PRFrame_Strict:GetChecked()
	local colorclass = PRFrame_ColorClass:GetChecked()
	local showgroupnum = PRFrame_ShowGroupNum:GetChecked()
	local reverse = PRFrame_ReverseBar:GetChecked()
	local deficit = PRFrame_Deficit:GetChecked()
	local alignright = PRFrame_AlignRight:GetChecked()
	local alignbottom = PRFrame_AlignBottom:GetChecked()
	local showParty = PRFrame_ShowParty:GetChecked()
	local showRaid = PRFrame_ShowRaid:GetChecked()
	local showPlayer = PRFrame_ShowPlayer:GetChecked()
	local showSolo = PRFrame_ShowSolo:GetChecked()
    local vehicleSwap = PRFrame_VehicleSwap:GetChecked()

	if title == "" then title = nil end
	if filter == "" then filter = nil end
	if groupBy == -1 then groupBy = nil end
	if sortType == -1 then sortType = nil end
	if colAnchor == -1 then colAnchor = nil end

	scale = tonumber(string.format("%0.2f", scale))

	-- Validation code here
	local err
	if not (numColumns and maxUnits and colSpacing and colAnchor) and
		(numColumns or maxUnits or colSpacing or colAnchor) then
		err = L["If you choose any of the column options, all of them become required fields.  Please choose the number of columns, max units, column spacing and column anchor."]
	elseif not filter and not partyFrame then
		--err = L["You must select at least one class or group to display."]
	end

	if err then
		StaticPopupDialogs["PR_FRAME_SAVE_ERROR"].text = err
		StaticPopup_Show("PR_FRAME_SAVE_ERROR")
		return
	end

	local entry = self.editEntry or {}
	entry.title = title
	entry.groupBy = groupBy
	entry.sortType = sortType

	entry.partyFrame = partyFrame
	entry.filter = filter
	entry.numColumns = numColumns
	entry.maxUnits = maxUnits
	entry.colSpacing = colSpacing
	entry.colAnchor = colAnchor
	entry.hBackdrop = hBackdrop
	entry.scale = scale
	entry.manaheight = manaheight
	entry.strict = strict
	entry.colorclass = colorclass
	entry.showgroupnum = showgroupnum
	entry.reverse = reverse
	entry.deficit = deficit
	entry.alignright = alignright
	entry.alignbottom = alignbottom

	entry.showParty = showParty
	entry.showRaid = showRaid
	entry.showPlayer = showPlayer
	entry.showSolo = showSolo

    entry.vehicleSwap = vehicleSwap

	if not self.editEntry then
		table.insert(PerfectRaid.db.profile.headers, entry)
	end
	self:CancelEntry()
	self.scrollframe.update()
	PerfectRaid:UpdateRaidFrames()

	-- Update button layouts
	local idx = PROptions_Frames.selected
	if idx then
		local name = "PRHeader"..idx

		local header = getglobal(name)
		for i=1,header:GetNumChildren() do
			local button = header:GetAttribute("child"..i)
			PerfectRaid:UpdateButtonLayout(button)
		end
		for unit in pairs(frames) do
			PerfectRaid:UNIT_HEALTH("UNIT_HEALTH", unit)
		end
	end
end

function Frames:CancelEntry()
	PROptions_Frames_EditTitle:SetText("")
	UIDropDownMenu_ClearAll(PRFrames_GroupByDropDown)
	UIDropDownMenu_ClearAll(PRFrames_SortDropDown)
	UIDropDownMenu_ClearAll(PRFrames_ColAnchorDropDown)

	for k,v in pairs(self.filters) do v:SetChecked(false) end

	PROptions_Frames_EditNumCols:SetText("")
	PROptions_Frames_EditMaxUnits:SetText("")
	PROptions_Frames_EditColSpacing:SetText("")
	PRFrame_HeaderBackdrop:SetChecked(false)
	PRFrame_Scale:SetValue(1.0)
	PRFrame_ManaHeight:SetValue(0)
	PRFrame_Strict:SetChecked(false)
	PRFrame_ColorClass:SetChecked(false)
	PRFrame_ReverseBar:SetChecked(false)
	PRFrame_Deficit:SetChecked(false)
	PRFrame_AlignRight:SetChecked(false)
	PRFrame_AlignBottom:SetChecked(false)
	PRFrame_ShowParty:SetChecked(false)
	PRFrame_ShowRaid:SetChecked(false)
	PRFrame_ShowPlayer:SetChecked(false)
	PRFrame_ShowSolo:SetChecked(false)
    PRFrame_VehicleSwap:SetChecked(false)

	self.options:FadeOut(PROptions_Frames_Edit)
	self.options:FadeIn(PROptions_Frames)
	self.scrollframe.update()
	self:EnableButtons()
end

StaticPopupDialogs["PR_FRAME_SAVE_ERROR"] = {
	text = "",
	button1 = OKAY and OKAY or "Okay",
	OnAccept = function()
	end,
	timeout = 0,
	hideOnEscape = 1
}

local function colorSwatchCancel()
	local self = ColorPickerFrame.object
	local r, g, b, a = self.r, self.g, self.b
	self.normalTexture:SetVertexColor(r, g, b, a)
end

local function colorSwatchColor()
	local self = ColorPickerFrame.object
	local r, g, b = ColorPickerFrame:GetColorRGB()
	local a = OpacitySliderFrame:GetValue()
	self.normalTexture:SetVertexColor(r, g, b, a)
end

local function colorSwatchOpacity()
	local self = ColorPickerFrame.object;
	local a = OpacitySliderFrame:GetValue();
	self.normalTexture:SetAlpha(a)
end

local function colorSwatchShow(self)
	local r, g, b, a = 1, 1, 1, 1

	self.r, self.g, self.b, self.a = r, g, b, a
	self.opacityFunc = colorSwatchOpacity
	self.swatchFunc = colorSwatchColor
	self.cancelFunc = colorSwatchCancel

	ColorPickerFrame.object = self
	ColorPickerFrame.opacity = a
	ColorPickerFrame.hasOpacity = self.hasAlpha
	ColorPickerFrame.func = self.swatchFunc
	ColorPickerFrame:Show()
	ColorPickerFrame:SetFrameStrata("TOOLTIP")
	ColorPickerFrame:Raise()
end

local function colorSwatchOnClick(self)
	CloseMenus();
	colorSwatchShow(self);
end

local function colorSwatchOnEnter(self)
	self.bg:SetVertexColor(1, 0.82, 0);
end

local function colorSwatchOnLeave(self)
	self.bg:SetVertexColor(1, 1, 1);
end

function Frames:CreateSwatch(name, parent)
	local swatch = CreateFrame("Button", name, parent);
	swatch:SetHeight(20) swatch:SetWidth(20)

	local bg = swatch:CreateTexture(nil, "BACKGROUND");
	local normalTexture = swatch:CreateTexture(nil, "ARTWORK");

	normalTexture:SetTexture("Interface\\ChatFrame\\ChatFrameColorSwatch");
	normalTexture:SetAllPoints(swatch);
	swatch:SetNormalTexture(normalTexture);
	bg:SetTexture(1, 1, 1);
	bg:SetPoint("TOPLEFT", swatch, 1, -1);
	bg:SetPoint("BOTTOMRIGHT", swatch, 0, 1);

	normalTexture:SetVertexColor(1,1,1)

	swatch.bg, swatch.normalTexture = bg, normalTexture;
	swatch.object, swatch.hasAlpha = self, false

	swatch:SetScript("OnEnter", colorSwatchOnEnter)
	swatch:SetScript("OnLeave", colorSwatchOnLeave)
	swatch:SetScript("OnClick", colorSwatchOnClick)
	return swatch
end
