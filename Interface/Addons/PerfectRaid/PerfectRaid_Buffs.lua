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

local Buffs = PerfectRaid:NewModule("PerfectRaid-Buffs")
local L = PerfectRaidLocals
local utils, frames
local timerFrame

-- Speed up this module as much as possible
local genv = _G
local PerfectRaid = genv.PerfectRaid
local setmetatable = genv.setmetatable
local pairs = genv.pairs
local table = genv.table
local ipairs = genv.ipairs
local select = genv.select
local UnitClass = genv.UnitClass
local UnitRaid = genv.UnitRace
local GetNumGroupMembers = genv.GetNumGroupMembers
local CreateFrame = genv.CreateFrame
local UIParent = genv.UIParent
local GetRaidRosterInfo = genv.GetRaidRosterInfo
local string = genv.string
local rawset = genv.rawset
local UnitBuff = genv.UnitBuff
local UnitDebuff = genv.UnitDebuff
local unpack = genv.unpack
local GetTime = genv.GetTime
local strjoin = genv.strjoin

function Buffs:Initialize()
	PerfectRaid.defaults.profile.buffs = {}

	frames = PerfectRaid.frames
	utils = PerfectRaid.utils
	self:RegisterMessage("DONGLE_PROFILE_CREATED")
	self:RegisterMessage("PERFECTRAID_TAB_CHANGED")
end

function Buffs:Enable()
	self:RegisterEvent("UNIT_AURA")
	self:RegisterEvent("GROUP_ROSTER_UPDATE")

	if GetNumGroupMembers() > 0 then
		self:GROUP_ROSTER_UPDATE()
	end

	self:UpdateBuffTable()

	for unit in pairs(frames) do
		self:UNIT_AURA(nil, unit)
	end

    -- Create a simple OnUpdate timer that triggers an update every second
    local updateInterval = 1.0  -- How often the OnUpdate code will run (in seconds)
    local elapsedCount = 0
	timerFrame = CreateFrame("Frame", "PraidBuffTimerFrame", UIParent);
	timerFrame:SetScript("OnUpdate", function(frame, elapsed)
        elapsedCount = elapsedCount + elapsed
        if elapsedCount > updateInterval then
            self:FullUpdate()
            timerFrame.TimeSinceLastUpdate = elapsedCount - updateInterval;
        end
    end)
end

function Buffs:FullUpdate()
    for unit in pairs(frames) do
        self:UNIT_AURA(nil, unit)
    end
end

function Buffs:DONGLE_PROFILE_CREATED(event, db, addon, svname, profileKey)
	if svname ~= "PerfectRaidDB" then return end
	self:PrintF(L["Adding default buffs to new profile \"%s\""], profileKey)
	local buffs = db.profile.buffs
	for k,v in ipairs(self.defaults) do
		if not v.disabled then
			self:AddDefaultBuff(buffs, v)
		end
	end
end

function Buffs:PERFECTRAID_TAB_CHANGED(old,new)
	if PROptions_Buffs_Edit and PROptions_Buffs_Edit:IsVisible() then
		self.options:FadeOut(PROptions_Buffs_Edit)
	end
end

local raidLookup = {}
for i=1,40 do
	raidLookup[i] = "raid"..i
end
function Buffs:GROUP_ROSTER_UPDATE()
	if GetNumGroupMembers() > 0 then
		for i=1,GetNumGroupMembers() do
			local group = select(3, GetRaidRosterInfo(i))
			local unit = raidLookup[i]
			if UnitIsUnit(unit, "player") then raidLookup.player = group end
			raidLookup[unit] = group
		end
	end
end

function Buffs:ConfigureButton(button)
	local font = button:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	button.aura = font
end

function Buffs:UpdateButtonLayout(button, options)
	button.aura:ClearAllPoints()

	if options.alignright then
		button.aura:SetPoint("RIGHT", button.leftbox, "RIGHT", -2, 0)
	else
		button.aura:SetPoint("LEFT", button.rightbox, "LEFT", 2, 0)
	end
end

function Buffs:ShowButton(button)
	local unit = button:GetAttribute("unit")
	self:UNIT_AURA(nil, unit)
end

local band = bit.band
local buffs = {}
local buffcache = {}
local mybuffs = {}
local mymask = {}
local buffexpiry = {}
local buffstacks = {}
local mystacks = {}

local BIT_CURSE = 1
local BIT_MAGIC = 2
local BIT_POISON = 4
local BIT_DISEASE = 8

local debuffstatus = setmetatable({}, {__index=function(t,k) rawset(t,k,0); return 0 end})

local work = {}
local patterns = setmetatable({}, {__index=function(t,k)
											   local str = string.rep("%s ", k):sub(1,-2)
											   rawset(t,k,str)
											   return str
										   end})

function Buffs:UNIT_AURA(event, unit)
	if not frames[unit] then return end

	for k,v in pairs(buffcache) do buffcache[k] = nil end
	for k,v in pairs(buffstacks) do buffstacks[k] = nil end
	for k,v in pairs(mybuffs) do mybuffs[k] = nil end
	for k,v in pairs(mystacks) do mystacks[k] = nil end
	for k,v in pairs(buffexpiry) do buffexpiry[k] = nil end


	for i=1,40 do
		local name,texture,count,dispelType,duration,expires,caster,stealable = UnitBuff(unit, i)
		if not name then break end
		if caster == "player" then
			mybuffs[name] = true
			mystacks[name] = (mystacks[name] or 0) + count
			buffexpiry[name] = expires
		end

		buffcache[name] = (buffcache[name] or 0) + 1
		buffstacks[name] = (buffstacks[name] or 0) + count
	end

	local debuffType
	for i=1,40 do
		local name,texture,count,dispelType,duration,expires,caster = UnitDebuff(unit, i)
		if not name and not dispelType then break end

		buffcache[name] = (buffcache[name] or 0) + 1
		buffstacks[name] = (buffstacks[name] or 0) + count
		buffexpiry[name] = expires

		if dispelType and name ~= dispelType then
			buffcache[dispelType] = (buffcache[dispelType] or 0) + 1
			buffstacks[dispelType] = (buffstacks[dispelType] or 0) + count
			debuffType = dispelType
		end
	end

	-- Raise any relevant debuff gained/lost messages
	local status = debuffstatus[unit]

	-- Disease
	if buffcache.Disease and band(status, BIT_DISEASE) == 0 then
		status = status + BIT_DISEASE
		self:TriggerMessage("PERFECTRAID_DEBUFFTYPE_GAINED", unit, "Disease")
	elseif not buffcache.Disease and band(status, BIT_DISEASE) > 0 then
		status = status - BIT_DISEASE
		self:TriggerMessage("PERFECTRAID_DEBUFFTYPE_LOST", unit, "Disease")
	end

	if buffcache.Poison and band(status, BIT_POISON) == 0 then
		status = status + BIT_POISON
		self:TriggerMessage("PERFECTRAID_DEBUFFTYPE_GAINED", unit, "Poison")
	elseif not buffcache.Poison and band(status, BIT_POISON) > 0 then
		status = status - BIT_POISON
		self:TriggerMessage("PERFECTRAID_DEBUFFTYPE_LOST", unit, "Poison")
	end

	if buffcache.Magic and band(status, BIT_MAGIC) == 0 then
		status = status + BIT_MAGIC
		self:TriggerMessage("PERFECTRAID_DEBUFFTYPE_GAINED", unit, "Magic")
	elseif not buffcache.Magic and band(status, BIT_MAGIC) > 0 then
		status = status - BIT_MAGIC
		self:TriggerMessage("PERFECTRAID_DEBUFFTYPE_LOST", unit, "Magic")
	end

	if buffcache.Curse and band(status, BIT_CURSE) == 0 then
		status = status + BIT_CURSE
		self:TriggerMessage("PERFECTRAID_DEBUFFTYPE_GAINED", unit, "Curse")
	elseif not buffcache.Curse and band(status, BIT_CURSE) > 0 then
		status = status - BIT_CURSE
		self:TriggerMessage("PERFECTRAID_DEBUFFTYPE_LOST", unit, "Curse")
	end

	-- Update the status
	debuffstatus[unit] = status
	for k,v in pairs(work) do work[k] = nil end

	for i,entry in ipairs(buffs) do
		local checkcond = false

		-- Determine which spell name we matched
		local buffname
		if buffcache[entry.buffname] then
			buffname = entry.buffname
		elseif buffcache[entry.groupname or "nil"] then
			buffname = entry.groupname
		elseif buffcache[entry.groupname2 or "nil"] then
			buffname = entry.groupname2		
		elseif buffcache[entry.groupname3 or "nil"] then
			buffname = entry.groupname3
		elseif buffcache[entry.groupname4 or "nil"] then
			buffname = entry.groupname4
		end
		
		-- How many stacks are there?
		local class = select(2, UnitClass(unit))
		local conds = self.conditions
		local group = raidLookup[unit]
		local mine = mybuffs[buffname]

		if entry.missing then
			if not buffname then
				checkcond = true
			end
		else
			if buffname then
				if (entry.mine and mine) or not entry.mine then
					checkcond = true
				end
			end
		end

		-- Handle the condition checking for the buff, taking strictness into account
		if checkcond then
			if entry.strict then
				-- Set up a boolean value so we can trip it if a filter fails
				local pass = true

				for i,name in pairs(entry.cond) do
					if conds[name] and not conds[name](unit, class, group, mine) then
						pass = false
					end
				end

				if pass then
					self:CreateBuffEntry(buffname, entry)
				end
			else
				-- Simply iterate each of the conditions, and break when we match
				for i,name in pairs(entry.cond) do
					if conds[name] and conds[name](unit, class, group, mine) then
						self:CreateBuffEntry(buffname, entry)
						break
					end
				end
			end
		end
	end

	for frame in pairs(frames[unit]) do
		frame.aura:SetFormattedText(patterns[#work], unpack(work))
	end
end

function Buffs:CreateBuffEntry(buffname, entry)
	local expires = buffexpiry[buffname]
	local num = buffcache[buffname]
	local stacks = buffstacks[buffname]
	local mine = mybuffs[buffname]

	-- show only my stacks
	if entry.onlymine then
		stacks = mystacks[buffname]
	end
	
	if ( ( num and num > 1 ) or ( stacks and stacks > 1 ) ) and not entry.onlymine then
		local num = num
		-- If the buff is mine, and it should be masked
		-- A buff is masked when there is a "mine" filter set for it
		if mine and not mymask[buffname] then
			num = num - 1
		end

		if (expires and entry.showexpiry) and (stacks > 1 and entry.showstacks) then
			work[#work + 1] = string.format("%s(%d,%d)", entry.colortext, stacks, -1 * (GetTime()-expires) )					
		elseif (stacks and stacks > 1 and entry.showstacks) then
			work[#work + 1] = string.format("%s(%d)", entry.colortext, stacks )				
		elseif ( num and expires and entry.showexpiry) then
			work[#work + 1] = string.format("%s(%d,%d)", entry.colortext, num, -1 * (GetTime() - expires))
		elseif ( num and num > 1 ) then
			work[#work + 1] = string.format("%s(%d)", entry.colortext, num)
		else
			work[#work + 1] = string.format("%s", entry.colortext)
		end
	else
		if (entry.onlymine and not mine) or (not entry.onlymine and mymask[buffname]) then
			-- Don't show
		else
			if (expires and entry.showexpiry) and (stacks > 1 and entry.showstacks) then
				work[#work + 1] = string.format("%s(%d,%d)", entry.colortext, stacks, -1 * (GetTime()-expires) )					
			elseif (stacks and stacks > 1 and entry.showstacks) then
				work[#work + 1] = string.format("%s(%d)", entry.colortext, stacks )							
			elseif (expires and entry.showexpiry) then
				work[#work + 1] = string.format("%s(%d)", entry.colortext, -1 * (GetTime()-expires))
			else
				work[#work + 1] = entry.colortext
			end
		end
	end
end

function Buffs:CreateOptions(opt)
	self.options = opt
	local options = CreateFrame("Frame", "PROptions_Buffs", PROptions)
	opt:AddOptionsTab(L["Buffs/Debuffs"], options)

	local num_entries = 19
	local scrollframe = opt:CreateListFrame(options, num_entries)

	-- Set up double-click handlers
	local function OnDoubleClick(button)
		button:Click()
		self:EditEntry()
	end

	for i=1,num_entries do
		local button = scrollframe.entries[i]
		button:SetScript("OnDoubleClick", OnDoubleClick)
	end

	local update = function()
		local list = PerfectRaid.db.profile.buffs

		local idx,button
		local offset = FauxScrollFrame_GetOffset(scrollframe)
		FauxScrollFrame_Update(scrollframe, #list, num_entries, 20)
		for i=1,num_entries do
			idx = offset + i
			local button = scrollframe.entries[i]
			if idx <= #list then
				local entry = list[idx]
				local display = entry.buffname

				if entry.groupname then
					display = display .. "/"..entry.groupname
				end
				display = display .. " (|cFF"..entry.color..entry.disptext.."|r)"

				if entry.disabled then
					display = display .. L[" *** DISABLED ***"]
				end

				button.line1:SetText(display)
				button:Show()
				if options.selected == idx then
					button:SetChecked(true)
				else
					button:SetChecked(false)
				end
			else
				button:Hide()
			end
		end
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

	local delete = CreateFrame("Button", "PRBuffs_Delete", options, "PRButtonTemplate")
	delete:SetText(L["Delete"])
	delete:SetPoint("BOTTOMRIGHT", 0, 5)
	delete:SetScript("OnClick", function() self:DeleteEntry() end)
	delete:Show()

	local edit = CreateFrame("Button", "PRBuffs_Edit", options, "PRButtonTemplate")
	edit:SetText(L["Edit"])
	edit:SetPoint("BOTTOMRIGHT", delete, "BOTTOMLEFT", -10, 0)
	edit:SetScript("OnClick", function() self:EditEntry() end)
	edit:Show()

	local add = CreateFrame("Button", "PRBuffs_Add", options, "PRButtonTemplate")
	add:SetText(L["Add"])
	add:SetPoint("BOTTOMRIGHT", edit, "BOTTOMLEFT", -10, 0)
	add:SetScript("OnClick", function() self:AddEntry() end)
	add:Show()

	local disable = CreateFrame("Button", "PRBuffs_Disable", options, "PRButtonTemplate")
	disable:SetText(L["Disable"])
	disable:SetPoint("BOTTOMRIGHT", add, "BOTTOMLEFT", -10, 0)
	disable:SetScript("OnClick", function() self:DisableEntry() end)
	disable:Show()

	local up = CreateFrame("Button", "PRBuffs_Up", options, "PRButtonTemplate")
	up:SetWidth(70)
	up:SetText(L["Up"])
	up:SetPoint("BOTTOMRIGHT", disable, "BOTTOMLEFT", -10, 0)
	up:SetScript("OnClick", function() self:MoveEntry("UP") end)
	up:Show()

	local down = CreateFrame("Button", "PRBuffs_Down", options, "PRButtonTemplate")
	down:SetWidth(70)
	down:SetText(L["Down"])
	down:SetPoint("BOTTOMRIGHT", up, "BOTTOMLEFT", -10, 0)
	down:SetScript("OnClick", function() self:MoveEntry("DOWN") end)
	down:Show()

	self:CreateEditFrame(options)
end

function Buffs:CreateEditFrame(parent)
	local frame = CreateFrame("Frame", "PROptions_Buffs_Edit", PROptions)
	local name = "PROptions_Buffs_Edit"
--	frame:SetPoint("TOPLEFT", 15, -25)
--	frame:SetPoint("BOTTOMRIGHT", -15, 15)
	frame:SetAllPoints(PROptions_Buffs)
	frame:SetFrameLevel(frame:GetFrameLevel() + 1)
	frame:Hide()

	local buffname = CreateFrame("EditBox", name.."BuffName", frame, "InputBoxTemplate")
	local font = buffname:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	font:SetText(L["Buff Name:"])
	font:SetPoint("BOTTOMLEFT", buffname, "TOPLEFT", 0, 3)
	buffname:SetPoint("TOPLEFT", 0, -10)
	buffname:SetAutoFocus(nil)
	buffname:SetWidth(180)
	buffname:SetHeight(20)
	buffname:Show()
	frame.buffname = buffname

	local groupname1 = CreateFrame("EditBox", name.."GroupName", frame, "InputBoxTemplate")
	local groupname2 = CreateFrame("EditBox", name.."GroupName2", frame, "InputBoxTemplate")
	local groupname3 = CreateFrame("EditBox", name.."GroupName3", frame, "InputBoxTemplate")	
	local groupname4 = CreateFrame("EditBox", name.."GroupName4", frame, "InputBoxTemplate")	
	local font = groupname1:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	
	-- label
	font:SetText(L["Buffs that share the same effect:"])
	font:SetPoint("BOTTOMLEFT", groupname1, "TOPLEFT", 0, 3)
	
	-- share/group name 1
	groupname1:SetPoint("TOPLEFT", 230, -10)
	groupname1:SetAutoFocus(nil)
	groupname1:SetWidth(200)
	groupname1:SetHeight(20)
	groupname1:Show()
	frame.groupname1 = groupname1
	
	-- share/group name 2
	groupname2:SetPoint("TOPLEFT", groupname1, "BOTTOMLEFT", 0, -2)
	groupname2:SetAutoFocus(nil)
	groupname2:SetWidth(200)
	groupname2:SetHeight(20)
	groupname2:Show()
	frame.groupname2 = groupname2
	
	-- share/group name 3
	groupname3:SetPoint("TOPLEFT", groupname2, "BOTTOMLEFT", 0, -2)
	groupname3:SetAutoFocus(nil)
	groupname3:SetWidth(200)
	groupname3:SetHeight(20)
	groupname3:Show()
	frame.groupname3 = groupname3
	
	-- share/group name 4
	groupname4:SetPoint("TOPLEFT", groupname3, "BOTTOMLEFT", 0, -2)
	groupname4:SetAutoFocus(nil)
	groupname4:SetWidth(200)
	groupname4:SetHeight(20)
	groupname4:Show()
	frame.groupname4 = groupname4

	local disptext = CreateFrame("EditBox", name.."DispText", frame, "InputBoxTemplate")
	local font = disptext:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	font:SetText(L["Display Text:"])
	font:SetPoint("BOTTOMLEFT", disptext, "TOPLEFT", 0, 3)
	disptext:SetPoint("TOPLEFT", 0, -54)
	disptext:SetAutoFocus(nil)
	disptext:SetWidth(180)
	disptext:SetHeight(20)
	disptext:Show()
	frame.disptext = disptext

	-- Color Swatch
	local function colorSwatchCancel()
		local self = ColorPickerFrame.object;
		local r, g, b = self.r, self.g, self.b;
		self.normalTexture:SetVertexColor(r, g, b);
	end

	local function colorSwatchColor()
		local self = ColorPickerFrame.object;
		local r, g, b = ColorPickerFrame:GetColorRGB();
		self.normalTexture:SetVertexColor(r, g, b);
		self.color[1] = r
		self.color[2] = g
		self.color[3] = b
		disptext:SetTextColor(r,g,b)
	end

	local function colorSwatchOpacity()
		local self = ColorPickerFrame.object;
		local a = OpacitySliderFrame:GetValue();
	end

	local function colorSwatchShow(self)
		local r, g, b, a;
		self.color = self.color or {1,1,1}

		local color = self.color;
		if ( color ) then
			r, g, b, a = unpack(color);
		end

		self.r, self.g, self.b = r, g, b
		self.opacityFunc = colorSwatchOpacity;
		self.swatchFunc = colorSwatchColor;
		self.cancelFunc = colorSwatchCancel;

		ColorPickerFrame.object = self;
		UIDropDownMenuButton_OpenColorPicker(self);
		ColorPickerFrame:SetFrameStrata("TOOLTIP");
		ColorPickerFrame:Raise();
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

	local swatch = CreateFrame("Button", "PRColorSelect", frame);
	swatch:SetHeight(20) swatch:SetWidth(20)
	swatch:SetPoint("LEFT", disptext, "RIGHT", 5, 0)
	local bg = swatch:CreateTexture(nil, "BACKGROUND");
	local normalTexture = swatch:CreateTexture(nil, "ARTWORK");
	frame.color = swatch

	normalTexture:SetTexture("Interface\\ChatFrame\\ChatFrameColorSwatch");
	normalTexture:SetAllPoints(swatch);
	swatch:SetNormalTexture(normalTexture);
	bg:SetTexture(.2,.2,.2);
	bg:SetPoint("TOPLEFT", swatch, 1, -1);
	bg:SetPoint("BOTTOMRIGHT", swatch, 0, 1);

	normalTexture:SetVertexColor(1,1,1)

	swatch.bg, swatch.normalTexture = bg, normalTexture;
	swatch.object, swatch.hasAlpha = self, 1

	swatch:SetScript("OnLeave", colorSwatchOnLeave);
	swatch:SetScript("OnEnter", colorSwatchOnEnter);
	swatch:SetScript("OnClick", colorSwatchOnClick);

	buffname:SetScript("OnTabPressed", function() if IsShiftKeyDown() then disptext:SetFocus() else groupname1:SetFocus() end end)
	groupname1:SetScript("OnTabPressed", function() if IsShiftKeyDown() then buffname:SetFocus() else groupname2:SetFocus() end end)
	groupname2:SetScript("OnTabPressed", function() if IsShiftKeyDown() then groupname1:SetFocus() else groupname3:SetFocus() end end)
	groupname3:SetScript("OnTabPressed", function() if IsShiftKeyDown() then groupname2:SetFocus() else groupname4:SetFocus() end end)
	groupname4:SetScript("OnTabPressed", function() if IsShiftKeyDown() then groupname3:SetFocus() else disptext:SetFocus() end end)
	disptext:SetScript("OnTabPressed", function() if IsShiftKeyDown() then groupname4:SetFocus() else buffname:SetFocus() end end)

	local function makeCheck(value)
		local button = CreateFrame("CheckButton", "PRBuffCond_"..value, PROptions_Buffs_Edit, "PRCheckTemplate")
		button.Label:SetText(value)
		button.value = value
		return button
	end

	PROptions_Buffs_Edit.checks = {}
	local checks = PROptions_Buffs_Edit.checks

	-- Build condition checkboxes

	checks[1] = makeCheck(self.conditions[1])
	checks[1]:SetPoint("TOPLEFT", disptext, "BOTTOMLEFT", 0, -40)
	checks[1]:Show()

	for i=2,6 do
		checks[i] = makeCheck(self.conditions[i])
		checks[i]:SetPoint("TOPLEFT", checks[i-1], "TOPRIGHT", 75, 0)
		checks[i]:Show()
	end

	checks[7] = makeCheck(self.conditions[7])
	checks[7]:SetPoint("TOPLEFT", checks[1], "BOTTOMLEFT", 0, -5)
	checks[7]:Show()

	for i=8,12 do
		checks[i] = makeCheck(self.conditions[i])
		checks[i]:SetPoint("TOPLEFT", checks[i-1], "TOPRIGHT", 75, 0)
		checks[i]:Show()
	end

	checks[13] = makeCheck(self.conditions[13])
	checks[13]:SetPoint("TOPLEFT", checks[7], "BOTTOMLEFT", 0, -5)
	checks[13]:Show()

	for i=14,18 do
		checks[i] = makeCheck(self.conditions[i])
		checks[i]:SetPoint("TOPLEFT", checks[i-1], "TOPRIGHT", 75, 0)
		checks[i]:Show()
	end

	checks[19] = makeCheck(self.conditions[19])
	checks[19]:SetPoint("TOPLEFT", checks[13], "BOTTOMLEFT", 0, -5)
	checks[19]:Show()

	for i=20,22 do
		checks[i] = makeCheck(self.conditions[i])
		checks[i]:SetPoint("TOPLEFT", checks[i-1], "TOPRIGHT", 75, 0)
		checks[i]:Show()
	end

	local cancel = CreateFrame("Button", "PRBuffs_EditCancel", PROptions_Buffs_Edit, "PRButtonTemplate")
	cancel:SetText(L["Cancel"])
	cancel:SetPoint("BOTTOMRIGHT", 0, 5)
	cancel:SetScript("OnClick", function() self:CancelEntry() end)
	cancel:Show()

	local save = CreateFrame("Button", "PRBuffs_EditSave", PROptions_Buffs_Edit, "PRButtonTemplate")
	save:SetText(L["Save"])
	save:SetPoint("BOTTOMRIGHT", cancel, "BOTTOMLEFT", -10, 0)
	save:SetScript("OnClick", function() self:SaveEntry() end)
	save:Show()

	local missing = CreateFrame("CheckButton", "PRBuffs_Missing", PROptions_Buffs_Edit, "PRCheckTemplate")
	missing.Label:SetText(L["Only show if this buff is missing"])
	missing:SetPoint("BOTTOMLEFT", 0, 10)
	missing:Show()
	frame.missing = missing

	local strict = CreateFrame("CheckButton", "PRBuffs_Strict", PROptions_Buffs_Edit, "PRCheckTemplate")
	strict.Label:SetText(L["Make filters strict"])
	strict:SetPoint("BOTTOMLEFT", missing, "TOPLEFT", 0, 0)
	strict:Show()
	frame.strict = strict
	
	local disabled = CreateFrame("CheckButton", "PRBuffs_Disabled", PROptions_Buffs_Edit, "PRCheckTemplate")
	disabled.Label:SetText(L["Do not check this buff (Disable)"])
	disabled:SetPoint("BOTTOMLEFT", strict, "TOPLEFT", 0, 0)
	disabled:Show()
	frame.disabled = disabled

	local onlymine = CreateFrame("CheckButton", "PRBuffs_OnlyMine", PROptions_Buffs_Edit, "PRCheckTemplate")
	onlymine.Label:SetText(L["Only show my buffs"])
	onlymine:SetPoint("TOPLEFT", disabled, "TOPRIGHT", 200, 0)
	onlymine:Show()
	frame.onlymine = onlymine

	local showexpiry = CreateFrame("CheckButton", "PRBuffs_ShowExpiry", PROptions_Buffs_Edit, "PRCheckTemplate")
	showexpiry.Label:SetText(L["Show expiry"])
	showexpiry:SetPoint("TOPLEFT", strict, "TOPRIGHT", 200, 0)
	showexpiry:Show()	
	frame.showexpiry = showexpiry
	
	local showstacks = CreateFrame("CheckButton", "PRBuffs_ShowStacks", PROptions_Buffs_Edit, "PRCheckTemplate")
	showstacks.Label:SetText(L["Show stacks"])
	showstacks:SetPoint("TOPLEFT", missing, "TOPRIGHT", 200, 0)
	showstacks:Show()
	frame.showstacks = showstacks

	local dropdown = CreateFrame("Frame", "PRBuffs_Dropdown", PROptions_Buffs_Edit, "UIDropDownMenuTemplate")
	dropdown:SetID(1)
	dropdown:SetPoint("BOTTOMRIGHT", -115, 80)
	dropdown:SetScript("OnShow", function() self:DropDown_OnShow() end)

	PRBuffs_DropdownButton:SetScript("OnClick", function() ToggleDropDownMenu(nil, nil, PRBuffs_Dropdown, "cursor") end)
	UIDropDownMenu_SetText(dropdown, L["Auto-fill Default"])
end

function Buffs:FillEntry(entry)
	local options = PROptions_Buffs_Edit
	options.buffname:SetText(entry.buffname)
	options.groupname1:SetText(entry.groupname or "")
	options.groupname2:SetText(entry.groupname2 or "")
	options.groupname3:SetText(entry.groupname3 or "")
	options.groupname4:SetText(entry.groupname4 or "")
	options.disptext:SetText(entry.disptext)
	options.disptext:SetTextColor(utils.HexToRGBPerc(entry.color))
	PRColorSelect.normalTexture:SetVertexColor(utils.HexToRGBPerc(entry.color))

	local cond = {string.split(",", entry.conds)}
	for k,v in ipairs(cond) do
		cond[v] = true
	end
	for idx,button in ipairs(PROptions_Buffs_Edit.checks) do
		if cond[button.value] then
			button:SetChecked(true)
		else
			button:SetChecked(false)
		end
	end

	options.missing:SetChecked(entry.missing)
	options.disabled:SetChecked(entry.disabled)
	options.strict:SetChecked(entry.strict)
	options.onlymine:SetChecked(entry.onlymine)
	options.showstacks:SetChecked(entry.showstacks)
	options.showexpiry:SetChecked(entry.showexpiry)
end

function Buffs:EditEntry()
	local scrollframe = PROptions_BuffsScrollFrame
	local offset = FauxScrollFrame_GetOffset(scrollframe)
	local selected = PROptions_Buffs.selected
	local entry = PerfectRaid.db.profile.buffs[selected]

	local options = PROptions_Buffs_Edit
	options.editEntry = entry
	self.options:FadeOut(PROptions_Buffs)
	self.options:FadeIn(options)
	self:FillEntry(entry)
end

function Buffs:MoveEntry(direction)
	local selected = PROptions_Buffs.selected
	local destination

	if direction == "UP" then
		destination = selected - 1
	else
		destination = selected + 1
	end

	local tmp = PerfectRaid.db.profile.buffs[destination]
	PerfectRaid.db.profile.buffs[destination] = PerfectRaid.db.profile.buffs[selected]
	PerfectRaid.db.profile.buffs[selected] = tmp

	PROptions_Buffs.selected = destination
	PROptions_BuffsScrollFrame.update()
	self:EnableButtons()
	self:UpdateBuffTable()
end

function Buffs:DisableEntry()
	local scrollframe = PROptions_BuffsScrollFrame
	local offset = FauxScrollFrame_GetOffset(scrollframe)
	local selected = PROptions_Buffs.selected
	local entry = PerfectRaid.db.profile.buffs[selected]
	entry.disabled = not entry.disabled

	scrollframe.update()
	self:EnableButtons()
	self:UpdateBuffTable()
end

function Buffs:AddEntry()
	local options = PROptions_Buffs_Edit
	self.options:FadeOut(PROptions_Buffs)
	self.options:FadeIn(options)
	options.buffname:SetText("")
	options.groupname1:SetText("")
	options.groupname2:SetText("")
	options.groupname3:SetText("")
	options.groupname4:SetText("")
	options.disptext:SetText("")
	options.disptext:SetTextColor(1,1,1)
	PRColorSelect.normalTexture:SetVertexColor(1,1,1)

	for idx,button in ipairs(PROptions_Buffs_Edit.checks) do
		button:SetChecked(false)
	end
	options.missing:SetChecked(false)
	options.disabled:SetChecked(false)
	options.strict:SetChecked(false)
	options.onlymine:SetChecked(false)
	options.showstacks:SetChecked(false)
	options.showexpiry:SetChecked(false)
	options.buffname:SetFocus()
end

function Buffs:DeleteEntry()
	local scrollframe = PROptions_BuffsScrollFrame
	local offset = FauxScrollFrame_GetOffset(scrollframe)
	local selected = PROptions_Buffs.selected

	table.remove(PerfectRaid.db.profile.buffs, selected)
	PROptions_Buffs.selected = nil

	scrollframe.update()
	self:EnableButtons()
	self:UpdateBuffTable()
end

function Buffs:UpdateBuffTable()
	for k,v in pairs(buffs) do buffs[k] = nil end
	for k,v in pairs(mymask) do mymask[k] = nil end

	for idx,entry in ipairs(PerfectRaid.db.profile.buffs) do
		if not entry.disabled then
			local tbl = {}
			tbl.buffname = entry.buffname
			tbl.groupname = entry.groupname
			tbl.groupname2 = entry.groupname2
			tbl.groupname3 = entry.groupname3
			tbl.groupname4 = entry.groupname4
			tbl.colortext = "|cFF"..entry.color..tostring(entry.disptext).."|r"
			tbl.missing = entry.missing
			tbl.strict = entry.strict
			tbl.cond = {string.split(",", entry.conds)}
			tbl.onlymine = entry.onlymine
			tbl.showstacks = entry.showstacks
			tbl.showexpiry = entry.showexpiry

			if tbl.onlymine then
				mymask[tbl.buffname] = true
				if entry.groupname then
					mymask[tbl.groupname] = true
				end
			end

			table.insert(buffs, tbl)
		end
	end

	for unit in pairs(frames) do
		self:UNIT_AURA(nil, unit)
	end
end

function Buffs:SaveEntry()
	local frame = PROptions_Buffs_Edit

	local buffname = frame.buffname:GetText()
	local groupname1 = frame.groupname1:GetText()
	local groupname2 = frame.groupname2:GetText()
	local groupname3 = frame.groupname3:GetText()
	local groupname4 = frame.groupname4:GetText()
	local disptext = frame.disptext:GetText()

	local err
	if buffname == "" then
		err = "You must supply a buff name"
	elseif disptext == "" then
		err = "You must supply a display text"
	end

	if err then
		StaticPopupDialogs["PR_BUFF_SAVE_ERROR"].text = err
		StaticPopup_Show("PR_BUFF_SAVE_ERROR")
		return
	end

	if groupname1 == "" then groupname1 = nil end
	if groupname2 == "" then groupname2 = nil end
	if groupname3 == "" then groupname3 = nil end
	if groupname4 == "" then groupname4 = nil end

	local options = PROptions_Buffs_Edit
	local entry = options.editEntry or {}

	entry.buffname = buffname
	entry.groupname = groupname1
	entry.groupname2 = groupname2
	entry.groupname3 = groupname3
	entry.groupname4 = groupname4
	entry.disptext = disptext

	local work = {}
	for idx,button in ipairs(PROptions_Buffs_Edit.checks) do
		if button:GetChecked() then
			table.insert(work, button.value)
		end
	end

	local conds = strjoin(",", unpack(work))
	entry.conds = conds
	entry.missing = frame.missing:GetChecked()
	entry.disabled = frame.disabled:GetChecked()
	entry.strict = frame.strict:GetChecked()
	entry.onlymine = frame.onlymine:GetChecked()
	entry.showstacks = frame.showstacks:GetChecked()
	entry.showexpiry = frame.showexpiry:GetChecked()

	local color = utils.RGBPercToHex(frame.disptext:GetTextColor())
	entry.color = color
	if not options.editEntry then
		table.insert(PerfectRaid.db.profile.buffs, entry)
	end

	options.editEntry = nil

	self:CancelEntry()
	PROptions_BuffsScrollFrame.update()
	self:UpdateBuffTable()
end

function Buffs:CancelEntry()
	local options = PROptions_Buffs_Edit
	self.options:FadeOut(options)
	options.editEntry = nil
	self.options:FadeIn(PROptions_Buffs)
end

function Buffs:EnableButtons()
	local selected = PROptions_Buffs.selected
	if selected then
		PRBuffs_Edit:Enable()
		PRBuffs_Delete:Enable()
		PRBuffs_Disable:Enable()
		PRBuffs_Up:Enable()
		PRBuffs_Down:Enable()

		-- Change enable/disable
		local scrollframe = PROptions_BuffsScrollFrame
		local offset = FauxScrollFrame_GetOffset(scrollframe)
		local selected = PROptions_Buffs.selected
		local entry = PerfectRaid.db.profile.buffs[selected]

		if selected == 1 then
			PRBuffs_Up:Disable()
		end

		if selected == #PerfectRaid.db.profile.buffs then
			PRBuffs_Down:Disable()
		end

		if entry.disabled then
			PRBuffs_Disable:SetText(L["Enable"])
		else
			PRBuffs_Disable:SetText(L["Disable"])
		end
	else
		PRBuffs_Edit:Disable()
		PRBuffs_Delete:Disable()
		PRBuffs_Disable:Disable()
		PRBuffs_Up:Disable()
		PRBuffs_Down:Disable()
	end
end

Buffs.conditions = {
	["All"] = function(u,c,g) return true end,
	["Warrior"] = function(u,c,g) return c == "WARRIOR" end,
	["Death Knight"] = function(u,c,g) return c == "DEATHKNIGHT" end,
	["Monk"] = function(u,c,g) return c == "MONK" end,
	["Priest"] = function(u,c,g) return c == "PRIEST" end,
	["Demon Hunter"] = function(u,c,g) return c == "DEMONHUNTER" end,
	["Druid"] = function(u,c,g) return c == "DRUID" end,
	["Paladin"] = function(u,c,g) return c == "PALADIN" end,
	["Shaman"] = function(u,c,g) return c == "SHAMAN" end,
	["Hunter"] = function(u,c,g) return c == "HUNTER" end,
	["Rogue"] = function(u,c,g) return c == "ROGUE" end,
	["Warlock"] = function(u,c,g) return c == "WARLOCK" end,
	["Mage"] = function(u,c,g) return c == "MAGE" end,
	["Mana"] = function(u,c,g) return c == "DRUID" or c == "PRIEST" or c == "PALADIN" or c == "SHAMAN" or c == "MAGE" or c == "WARLOCK" or c == "HUNTER" end,
	["Healer"] = function(u,c,g) return c == "PRIEST" or c == "SHAMAN" or c == "DRUID" or c == "PALADIN" end,
	["Group 1"] = function(u,c,g) return g == 1 end,
	["Group 2"] = function(u,c,g) return g == 2 end,
	["Group 3"] = function(u,c,g) return g == 3 end,
	["Group 4"] = function(u,c,g) return g == 4 end,
	["Group 5"] = function(u,c,g) return g == 5 end,
	["Group 6"] = function(u,c,g) return g == 6 end,
	["Group 7"] = function(u,c,g) return g == 7 end,
	["Group 8"] = function(u,c,g) return g == 8 end,
	["MyGroup"] = function(u,c,g) return g == raidLookup.player end,
}

local work = {}
for k,v in pairs(Buffs.conditions) do
	table.insert(work, k)
end
table.sort(work)

for k,v in ipairs(work) do
	Buffs.conditions[k] = v
end

StaticPopupDialogs["PR_BUFF_SAVE_ERROR"] = {
	text = "",
	button1 = OKAY and OKAY or "Okay",
	OnAccept = function()
	end,
	timeout = 0,
	hideOnEscape = 1
}

local click_func = function(frame) Buffs:DropDown_OnClick(frame) end
local init_func = function() Buffs:DropDown_Initialize() end

function Buffs:DropDown_Initialize()
    local info = {}

    for k,v in pairs(self.defaults) do
        info = {}
        info.text = string.format("%s (|cFF%s%s|r)", v.buffname, v.color, v.disptext)
        info.value = v
        info.func = click_func
        UIDropDownMenu_AddButton(info)
	end
end

function Buffs:DropDown_OnClick(frame)
	local entry = frame.value
	self:FillEntry(entry)
end

function Buffs:DropDown_OnShow(this)
	table.sort(self.defaults, function(a,b) return a.buffname < b.buffname end)
	UIDropDownMenu_Initialize(PRBuffs_Dropdown, init_func);
end

function Buffs:AddDefaultBuff(profile, entry)
	local tbl = {}
	for k,v in pairs(entry) do tbl[k] = v end
	tbl.disabled = nil
	table.insert(profile, tbl)
end

local class = select(2, UnitClass("player"))
local race = select(2, UnitRace("player"))

Buffs.defaults = {
	-- Priest
	{
		conds = "All",
		buffname = L["Power Word: Fortitude"],
		groupname = L["Imp: Blood Pact"],
		groupname2 = L["Commanding Shout"],
		groupname3 = L["Qiraji Fortitude"],
		disptext = L["STATUS_FORT"],
		color = "FFFFFF",
		missing = true,
		disabled = (class ~= "PRIEST"),
	},
	{
		conds = "All",
		buffname = L["Power Word: Shield"],
		disptext = L["STATUS_PWS"],
		color = "FFD800",
		disabled = (class ~= "PRIEST"),
	},
	{
		conds = "All",
		buffname = L["Weakened Soul"],
		disptext = L["STATUS_WEAKENEDSOUL"],
		color = "FF5500",
		disabled = (class ~= "PRIEST"),
	},
	{
		conds = "All",
		buffname = L["Renew"],
		disptext = L["STATUS_RENEW"],
		color = "00FF10",
        showexpiry = true,
		disabled = (class ~= "PRIEST"),
	},
	{
		conds = "All",
		buffname = L["Shadow Protection"],
		groupname = L["Prayer of Shadow Protection"],
		disptext = L["STATUS_SHADOWPROT"],
		missing = true,
		color = "9900FF",
		disabled = (class ~= "PRIEST"),
	},
	{
		conds = "All",
		buffname = L["Divine Spirit"],
		groupname = L["Prayer of Spirit"],
		disptext = L["STATUS_DIVINESPIRIT"],
		missing = true,
		color = "9900FF",
		disabled = (class ~= "PRIEST"),
	},
	{
		conds = "All",
		buffname = L["Power Infusion"],
		disptext = L["STATUS_POWERINFUSION"],
		color = "00FF33",
	},
	{
		conds = "All",
		buffname = L["Fear Ward"],
		disptext = L["STATUS_FEARWARD"],
		color = "9900FF",
		disabled = (class ~= "PRIEST" and race == "Dwarf"),
	},
	{
		conds = "All",
		buffname = L["Prayer of Mending"],
		disptext = L["STATUS_PRAYERMEND"],
		color = "FFCF7F",
		disabled = (class ~= "PRIEST"),
	},
	-- Druid specific spells
	{
		conds = "All",
		buffname = L["Mark of the Wild"],
		groupname = L["Blessing of Kings"],
		groupname2 = L["Legacy of the Emperor"],
		groupname3 = L["Embrace of the Shale Spider"],
		disptext = L["STATUS_MOTW"],
		color = "BC64AA",
		missing = true,
		disabled = (class ~= "DRUID"),
	},
	{
		conds = "All",
		buffname = L["Rejuvenation"],
		disptext = L["STATUS_REJUV"],
		color = "bc64aa",
        showexpiry = true,
		disabled = (class ~= "DRUID"),
	},
	{
		conds = "All",
		buffname = L["Lifebloom"],
		disptext = L["STATUS_LIFEBLOOM"],
		color = "50fe37",
		showexpiry = true,
		disabled = (class ~= "DRUID"),
	},
	{
		conds = "All",
		buffname = L["Regrowth"],
		disptext = L["STATUS_REGROWTH"],
		color = "00FF10",
        showexpiry = true,
		disabled = (class ~= "DRUID"),
	},	
	{
		conds = "Mana",
		buffname = L["Innervate"],
		disptext = L["STATUS_INNERVATE"],
		color = "00FF33",
	},
	{
		conds = "All",
		buffname = L["Wild Growth"],
		disptext = L["STATUS_WILD_GROWTH"],
		color = "01796F",
	},
	-- Shaman
	{
		conds = "All",
		buffname = L["Grace of Air"],
		groupname = L["Blessing of Might"],		
		groupname2 = L["Roar of Courage"],
		groupname3 = L["Spirit Beast Blessing"],
		disptext = L["STATUS_GRACEOFAIR"],
		color = "F48CBA",
		missing = true,
		disabled = (class ~= "SHAMAN"),
	},	
	-- Paladin Buffs
	{
		conds = "All",
		buffname = L["Blessing of Might"],
		groupname = L["Grace of Air"],
		groupname2 = L["Roar of Courage"],
		groupname3 = L["Spirit Beast Blessing"],
		disptext = L["STATUS_BLESSINGMIGHT"],
		color = "F48CBA",
		missing = true,
		disabled = (class ~= "PALADIN"),
	},	
	{
		conds = "All",
		buffname = L["Blessing of Kings"],
		groupname = L["Mark of the Wild"],		
		groupname2 = L["Legacy of the Emperor"],
		groupname3 = L["Embrace of the Shale Spider"],
		disptext = L["STATUS_BLESSINGKINGS"],
		color = "F48CBA",
		missing = true,
		disabled = (class ~= "PALADIN"),
	},
	-- Monk buffs
	{
		conds = "All",
		buffname = L["Legacy of the Emperor"],		
		groupname = L["Blessing of Kings"],
		groupname2 = L["Mark of the Wild"],
		groupname3 = L["Embrace of the Shale Spider"],
		disptext = L["STATUS_LEGACYOFTHEEMPEROR"],
		color = "01796F",
		missing = true,
		disabled = (class ~= "MONK"),
	},	
	-- Mage Buffs
	{
		conds = "Mana",
		buffname = L["Arcane Brilliance"],
		groupname = L["Dalaran Brilliance"],
		groupname2 = L["Burning Wrath"],
		groupname3 = L["Dark Intent"],
		groupname4 = L["Still Water"],
		disptext = L["STATUS_ARCANEINT"],
		color = "3399FF",
		missing = true,
		disabled = (class ~= "MAGE"),
	},
	-- Warlock Buffs
	{
		conds = "All",
		buffname = L["Soulstone Resurrection"],
		disptext = L["STATUS_SOULSTONE"],
		color = "CA21FF",
	},
	{
		conds = "All",
		buffname = L["Imp: Blood Pact"],
		groupname = L["Power Word: Fortitude"],		
		groupname2 = L["Commanding Shout"],
		groupname3 = L["Qiraji Fortitude"],
		disptext = L["STATUS_IMPBLOODPACT"],
		color = "C90404",
		missing = true,
		disabled = (class ~= "WARLOCK"),
	},
	-- Warrior
	{
		conds = "All",
		buffname = L["Commanding Shout"],
		groupname = L["Imp: Blood Pact"],
		groupname2 = L["Power Word: Fortitude"],
		groupname3 = L["Qiraji Fortitude"],
		disptext = L["STATUS_COMMANDINGSHOUT"],
		color = "FFBF00",
		missing = true,
		disabled = (class ~= "WARRIOR"),
	},
	-- Misc Debuffs
	{
		conds = "All",
		buffname = L["Mortal Strike"],
		disptext = L["STATUS_MORTALSTRIKE"],
		color = "FF1111",
	},
	-- Debuffs.  These should not be localized.
	{
		conds = "All",
		buffname = "Curse",
		disptext = L["STATUS_CURSE"],
		color = "9900FF",
		disabled = (class ~= "MAGE" and class ~= "DRUID")
	},
	{
		conds = "All",
		buffname = "Poison",
		disptext = L["STATUS_POISON"],
		color = "009900",
		disabled = (class ~= "PALADIN" and class ~= "DRUID" and class ~= "SHAMAN")
	},
	{
		conds = "All",
		buffname = "Disease",
		disptext = L["STATUS_DISEASE"],
		color = "996600",
		disabled = (class ~= "PRIEST" and class ~= "PALADIN" and class ~= "SHAMAN")
	},
	{
		conds = "All",
		buffname = "Magic",
		disptext = L["STATUS_MAGIC"],
		color = "3399FF",
		disabled = (class ~= "PRIEST" and class ~= "PALADIN")
	},
	{
		conds = "All",
		buffname = L["Food"],
		disptext = L["STATUS_FOOD"],
		color = "d79a6d",
	},
	{
		conds = "All",
		buffname = L["Drink"],
		disptext = L["STATUS_DRINK"],
		color = "00a1de",
	}
}
