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

local Options = PerfectRaid:NewModule("PerfectRaid-Options")
local L = PerfectRaidLocals

function Options:Initialize()
end

function Options:Enable()
	self.cmd = self:InitializeSlashCommand("PerfectRaid Options", "PERFECTRAID", "praid", "perfectraid")
	self.cmd:RegisterSlashHandler(L["Show options GUI"], "^$", "ShowOptions")
	self.cmd:RegisterSlashHandler(L["lock - Lock frames"], "^lock$", "LockFrames")
	self.cmd:RegisterSlashHandler(L["unlock - Unlock frames"], "^unlock$", "UnlockFrames")
	--self.cmd:InjectDBCommands(PerfectRaid.db, "copy", "delete", "list", "reset", "set")
end

function Options:LockFrames()
	local profile = PerfectRaid.db.profile
	self:Print(L["Frames have been locked"])
	profile.locked = true
end

function Options:UnlockFrames()
	local profile = PerfectRaid.db.profile
	self:Print(L["Frames have been unlocked"])
	profile.locked = false
end

function Options:ShowOptions()
	if not PROptions then
		self:CreateOptions()
		self:FadeIn(PROptions)
	elseif PROptions:IsVisible() then
		self:FadeOut(PROptions)
	else
		self:FadeIn(PROptions)
	end
end

local tabs = {}
function Options:CreateOptions()
	local frame = CreateFrame("Frame", "PROptions", UIParent, "PROptionsTemplate")
	frame:SetHeight(450)
	frame:SetWidth(650)
	frame:SetPoint("CENTER", 0, 50)

	PROptionsHeaderTitle:SetText(L["PerfectRaid Options"])

	local sortTbl = {}
	for name,module in PerfectRaid:IterateModules() do
		table.insert(sortTbl, name)
		sortTbl[name] = module
	end

	table.sort(sortTbl)

	for idx,name in ipairs(sortTbl) do
		local module = sortTbl[name]
		if module ~= self and type(module.CreateOptions) == "function" then
			module:CreateOptions(self)
		end
	end
	PanelTemplates_SetNumTabs(PROptions, #tabs)
	PanelTemplates_SetTab(PROptions, 0)
	self:TabOnClick(PROptionsTab3)
end

local work = {}
function Options:AddOptionsTab(title, frame)
	local num = #tabs + 1
	local name = "PROptionsTab"..num
	local tab = CreateFrame("Button", name, PROptions, "PRTabTemplate")
	tab.idx = num

	if num == 1 then
		tab:SetPoint("CENTER", PROptions, "BOTTOMLEFT", 50, -8)
	else
		local prev = getglobal("PROptionsTab"..num-1)
		tab:SetPoint("TOPLEFT", prev, "TOPRIGHT", -16, 0)
	end

	tab:SetText(title)
	tab.frame = frame
	tab.title = title
	tab:Show()

	tab.frame:SetPoint("TOPLEFT", PROptions, "TOPLEFT", 20, -30)
	tab.frame:SetPoint("BOTTOMRIGHT", PROptions, "BOTTOMRIGHT", -15, 10)
	tab.frame:Hide()

	table.insert(tabs, tab)
	return tab
end

function Options:FadeIn(frame)
	frame:Show()
	UIFrameFadeIn(frame, 0.2)
end

function Options:FadeOut(frame)
	--UIFrameFadeOut(frame, 0.2)
	frame:Hide()
end

local tabselected
function Options:TabOnClick(tab)
	local old = tabselected

	if tabselected then
		self:FadeOut(tabselected.frame)
	end
	self:FadeIn(tab.frame)
	tabselected = tab
	PanelTemplates_SetTab(PROptions, tab.idx)
	self:TriggerMessage("PERFECTRAID_TAB_CHANGED", old, tab)
end

function Options:CreateListFrame(parent, num)
	local function OnClick(self)
		local scrollframe = getglobal(parent:GetName().."ScrollFrame")
		local parent = self:GetParent()

		local offset = FauxScrollFrame_GetOffset(scrollframe)
		local idx = offset + self.idx

		if parent.selected and parent.selected - offset == self.idx then
			parent.entries[parent.selected - offset]:SetChecked(true)
		elseif parent.selected then
			local idx = parent.selected - offset
			if idx <= num then
				parent.entries[parent.selected - offset]:SetChecked(false)
			end
		end

		parent.selected = idx
	end

	local function OnEnter(self)
		if self.tooltip then
			GameTooltip_SetDefaultAnchor(GameTooltip, self);
			GameTooltip:SetText(self.tooltip)
		end
	end

	local function OnLeave(self)
		GameTooltip:Hide()
	end

	local function MakeEntry(name, parent)
		local entry = CreateFrame("CheckButton", name, parent)
		entry:SetScript("OnClick", OnClick)
		entry:SetHeight(20)
		entry:SetPoint("LEFT", 0, 0)
        entry:SetPoint("RIGHT", -20, 0)
		entry:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
		entry:SetCheckedTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
		entry:GetHighlightTexture():SetBlendMode("ADD")
		entry.line1 = entry:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
		entry.line1:SetPoint("LEFT", 0 ,0)
		entry.line1:SetPoint("RIGHT", -5, 0)
		entry.line1:SetJustifyH("LEFT")

		entry:SetScript("OnEnter", OnEnter)
		entry:SetScript("OnLeave", OnLeave)
		return entry
	end

	parent.entries = {}
	local entries = parent.entries
	for i=1,num do
		entries[i] = MakeEntry(parent:GetName().."Entry"..i, parent)
		entries[i].idx = i
	end

	entries[1]:SetPoint("TOPLEFT",0,0)

	for i=2,num do
		 entries[i]:SetPoint("TOPLEFT", entries[i-1], "BOTTOMLEFT", 0, 0)
	end

	local scrollframe = CreateFrame("ScrollFrame", parent:GetName().."ScrollFrame", parent, "FauxScrollFrameTemplate")
	scrollframe:SetPoint("TOPLEFT", entries[1], "TOPLEFT", 0, 0)
	scrollframe:SetPoint("BOTTOMRIGHT", entries[num], "BOTTOMRIGHT", 0, 0)

	local texture = scrollframe:CreateTexture(nil, "BACKGROUND")
	texture:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	texture:SetPoint("TOPLEFT", scrollframe, "TOPRIGHT", 14, 0)
	texture:SetPoint("BOTTOMRIGHT", scrollframe, "BOTTOMRIGHT", 23, 0)
	texture:SetGradientAlpha("HORIZONTAL", 0.5, 0.25, 0.05, 0, 0.15,0.15, 0.15, 1)

	local texture = scrollframe:CreateTexture(nil, "BACKGROUND")
	texture:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	texture:SetPoint("TOPLEFT", scrollframe, "TOPRIGHT", 4, 0)
	texture:SetPoint("BOTTOMRIGHT", scrollframe, "BOTTOMRIGHT", 14, 0)
	texture:SetGradientAlpha("HORIZONTAL", 0.15, 0.15, 0.15, 0.15, 1, 0.5, 0.25, 0.05, 0)

	scrollframe.entries = entries
	return scrollframe
end
