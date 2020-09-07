--[[-------------------------------------------------------------------------
  Copyright (c) 2008, Jim Whitehead II <cladhaire@gmail.com>
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

local Highlight = PerfectRaid:NewModule("PerfectRaid-Highlight")
local L = PerfectRaidLocals
local utils, frames

-- Initialization functions
function Highlight:Initialize()
	PerfectRaid.defaults.profile.buffs = {}

	frames = PerfectRaid.frames
	utils = PerfectRaid.utils
	self:RegisterMessage("DONGLE_PROFILE_CREATED")
	self:RegisterMessage("PERFECTRAID_TAB_CHANGED")
end

function Highlight:Enable()
	self:RegisterMessage("PERFECTRAID_DEBUFFTYPE_GAINED")
	self:RegisterMessage("PERFECTRAID_DEBUFFTYPE_LOST")
end

-- Create the backdrop, and the OnEnter/OnLeave scripts
local backdrop = {
	bgFile = "Interface\\AddOns\\PerfectRaid\\images\\bgFile",
	tile = true, tileSize = 32,
	insets = {
		left = 6,
		right = 6,
	},
}

local mouseover
local function OnEnter(frame)
	local opt = PerfectRaid.db.profile.highlight
	if( opt.tooltip and frame.unit ) then
		UnitFrame_UpdateTooltip(frame)
	end

	if( opt.mouseover ) then
		frame:SetBackdropColor(0.9, 0.9, 0.9, 0.3)
		mouseover = frame
	end
end

local function OnLeave(frame)
	mouseover = nil
	GameTooltip:Hide()
	Highlight:UpdateUnit(nil, frame)
end

function Highlight:UpdateButtonLayout(button, options)
	button:SetBackdrop(backdrop)
	button:SetBackdropColor(0,0,0,0)

    if not button.highlight_scripts_set then
        button:HookScript("OnEnter", OnEnter)
        button:HookScript("OnLeave", OnLeave)
        button.highlight_scripts_set = true
    end
end

-- Handle the buff events as they come across, and keep track of who has what buffs.
local BIT_CURSE = 1
local BIT_MAGIC = 2
local BIT_POISON = 4
local BIT_DISEASE = 8

local status = setmetatable({}, {__index=function(t,k) rawset(t,k,0); return 0 end})

function Highlight:PERFECTRAID_DEBUFFTYPE_GAINED(msg, unit, type)
	if type == "Disease" then
		status[unit] = status[unit] + BIT_DISEASE
	elseif type == "Poison" then
		status[unit] = status[unit] + BIT_POISON
	elseif type == "Magic" then
		status[unit] = status[unit] + BIT_MAGIC
	elseif type == "Curse" then
		status[unit] = status[unit] + BIT_CURSE
	end

	self:UpdateUnit(unit)
end

function Highlight:PERFECTRAID_DEBUFFTYPE_LOST(msg, unit, type)
	if type == "Disease" then
		status[unit] = status[unit] - BIT_DISEASE
	elseif type == "Poison" then
		status[unit] = status[unit] - BIT_POISON
	elseif type == "Magic" then
		status[unit] = status[unit] - BIT_MAGIC
	elseif type == "Curse" then
		status[unit] = status[unit] - BIT_CURSE
	end

	if status[unit] < 0 then
		status[unit] = 0
	end

	self:UpdateUnit(unit)
end

local band = bit.band
local function checkbit(num, bit) return band(num, bit) == bit end
function Highlight:UpdateUnit(unit, frame)
	-- Check to see if we need to change the backdrop
	local opt = PerfectRaid.db.profile.highlight

	if not unit and frame then
		unit = frame:GetAttribute("unit")
	end

	local r,g,b,a = 0,0,0,0
	local statnum = status[unit]

	-- Color the frame properly
	if opt.disease and checkbit(statnum, BIT_DISEASE) then
		r,g,b,a = 0.6,0.4,0,0.7
	elseif opt.poison and checkbit(statnum, BIT_POISON) then
		r,g,b,a = 0,0.6,0,0.7
	elseif opt.magic and checkbit(statnum, BIT_MAGIC) then
		r,g,b,a = 0.2,0.6,1,0.7
	elseif opt.curse and checkbit(statnum, BIT_CURSE) then
		r,g,b,a = 0.6,0,1,0.7
	end

	if frame then
		if frame == mouseover then
			frame:SetBackdropColor(0.9, 0.9, 0.9, 0.3)
		else
			frame:SetBackdropColor(r,g,b,a)
		end
	else
		for frame in pairs(frames[unit]) do
			if frame == mouseover then
				frame:SetBackdropColor(0.9, 0.9, 0.9, 0.3)
			else
				frame:SetBackdropColor(r,g,b,a)
			end
		end
	end
end

local options
function Highlight:CreateOptions(opt)
	local Buffs = PerfectRaid:HasModule("PerfectRaid-Buffs")

	options = CreateFrame("Frame", "PROptions_Highlight", PROptions)

	opt:AddOptionsTab(L["Highlight"], options)

	options.widgets = {}

	local check = CreateFrame("CheckButton", "PRHighlight_Mouseover", options, "PRCheckTemplate")
	check.Label:SetText(L["Highlight on mouseover"])
	table.insert(options.widgets, check)

	local check = CreateFrame("CheckButton", "PRHighlight_Tooltip", options, "PRCheckTemplate")
	check.Label:SetText(L["Show unit tooltip on mouseover"])
	table.insert(options.widgets, check)

	local check = CreateFrame("CheckButton", "PRHighlight_Disease", options, "PRCheckTemplate")
	check.Label:SetText(L["Highlight when diseased"])
	table.insert(options.widgets, check)

	local check = CreateFrame("CheckButton", "PRHighlight_Curse", options, "PRCheckTemplate")
	check.Label:SetText(L["Highlight when cursed"])
	table.insert(options.widgets, check)

	local check = CreateFrame("CheckButton", "PRHighlight_Magic", options, "PRCheckTemplate")
	check.Label:SetText(L["Highlight when magic debuffed"])
	table.insert(options.widgets, check)

	local check = CreateFrame("CheckButton", "PRHighlight_Poison", options, "PRCheckTemplate")
	check.Label:SetText(L["Highlight when poisoned"])
	table.insert(options.widgets, check)

	local cancel = CreateFrame("Button", "PRHighlight_Cancel", options, "PRButtonTemplate")
	cancel:SetText(L["Cancel"])
	cancel:SetPoint("BOTTOMRIGHT", 0, 5)
	cancel:SetScript("OnClick", function() options:CancelOptions() end)
	cancel:Show()

	local save = CreateFrame("Button", "PRHighlight_Save", options, "PRButtonTemplate")
	save:SetText(L["Save"])
	save:SetPoint("BOTTOMRIGHT", cancel, "BOTTOMLEFT", -10, 0)
	save:SetScript("OnClick", function() options:SaveOptions() end)
	save:Show()

	function options:SaveOptions()
		local mouseover = PRHighlight_Mouseover:GetChecked() and true or false
		local tooltip = PRHighlight_Tooltip:GetChecked() and true or false
		local disease = PRHighlight_Disease:GetChecked() and true or false
		local curse = PRHighlight_Curse:GetChecked() and true or false
		local magic = PRHighlight_Magic:GetChecked() and true or false
		local poison = PRHighlight_Poison:GetChecked() and true or false

		PerfectRaid.db.profile.highlight.mouseover = mouseover
		PerfectRaid.db.profile.highlight.tooltip = tooltip
		PerfectRaid.db.profile.highlight.disease = disease
		PerfectRaid.db.profile.highlight.curse = curse
		PerfectRaid.db.profile.highlight.magic = magic
		PerfectRaid.db.profile.highlight.poison = poison

		-- Trigger update here
		for unit in pairs(frames) do
			Highlight:UpdateUnit(unit)
		end
	end

	function options:CancelOptions()
		local opt = PerfectRaid.db.profile.highlight

		PRHighlight_Mouseover:SetChecked(opt.mouseover)
		PRHighlight_Tooltip:SetChecked(opt.tooltip)
		PRHighlight_Disease:SetChecked(opt.disease)
		PRHighlight_Curse:SetChecked(opt.curse)
		PRHighlight_Magic:SetChecked(opt.magic)
		PRHighlight_Poison:SetChecked(opt.poison)

		-- Trigger update here
		for unit in pairs(frames) do
			Highlight:UpdateUnit(unit)
		end
	end

	-- Force an update when tab is clicked
	options:SetScript("OnShow", options.CancelOptions)

	for idx,widget in ipairs(options.widgets) do
		widget:Show()
		if idx == 1 then
			widget:SetPoint("TOPLEFT", 0, 0)
		else
			widget:SetPoint("TOPLEFT", options.widgets[idx - 1], "BOTTOMLEFT", 0, -15)
		end
	end
end
