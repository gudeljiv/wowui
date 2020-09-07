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

local Range = PerfectRaid:NewModule("PerfectRaid-Range")
local frames, rate
local inalpha, outalpha
local L = PerfectRaidLocals

function Range:Initialize()
	PerfectRaid.defaults.profile.RangeCheck = true
	PerfectRaid.defaults.profile.RangeRate = 0.2
	PerfectRaid.defaults.profile.RangeOutAlpha = 0.3
	PerfectRaid.defaults.profile.RangeInAlpha = 1.0

	frames = PerfectRaid.frames
end

function Range:Enable()
	if PerfectRaid.db.profile.RangeCheck then
		if not self.frame then
			self.frame = CreateFrame("Frame")
		end

		self.frame:SetScript("OnUpdate", self.OnUpdate)
		rate = PerfectRaid.db.profile.RangeRate
		outalpha = PerfectRaid.db.profile.RangeOutAlpha
		inalpha = PerfectRaid.db.profile.RangeInAlpha

		self:RegisterMessage("DONGLE_PROFILE_CHANGED")
	end
end

function Range:Disable()
	if self.frame then
		self.frame:SetScript("OnUpdate", nil)
	end
	for unit,tbl in pairs(frames) do
		for frame in pairs(tbl) do
			frame:SetAlpha(1.0)
		end
	end
end

function Range:DONGLE_PROFILE_CHANGED(event, addon, svname, name)
	if svname == "PerfectRaidDB" then
		rate = PerfectRaid.db.profile.RangeRate
		outalpha = PerfectRaid.db.profile.RangeOutAlpha
		inalpha = PerfectRaid.db.profile.RangeInAlpha
		if PerfectRaid.db.profile.RangeCheck then
			self:Enable()
		else
			self:Disable()
		end
	end
end

local alpha = 1
local elapsed_counter = 0
function Range.OnUpdate(frame, elapsed)
	elapsed_counter = elapsed_counter + elapsed

	if elapsed_counter >= rate then
		for unit,tbl in pairs(frames) do
			local inRange, checkedRange = UnitInRange(unit)

			if checkedRange and not inRange then
				alpha = outalpha
			else
				alpha = inalpha
			end

			for frame in pairs(tbl) do
				frame:SetAlpha(alpha)
			end
		end
		elapsed_counter = 0
	end
end

local options
function Range:CreateOptions(opt)
	options = CreateFrame("Frame", "PROptions_Range", PROptions)
	options:SetScript("OnShow", function() self:OnShow() end)

	opt:AddOptionsTab(L["Range Check"], options)

	options.widgets = {}

	local check = CreateFrame("CheckButton", "PRRange_Enable", options, "PRCheckTemplate")
	check.Label:SetText(L["Perform range checking"])
	table.insert(options.widgets, check)

	local slider = CreateFrame("Slider", "PRRange_Rate", options, "PRSliderTemplate")
	slider.Text:SetText(L["Update delay"])
	slider.High:SetText("2.0")
	slider.Low:SetText("0")
	slider:SetMinMaxValues(0,2.0)
	slider:SetValueStep(0.1)
	table.insert(options.widgets, slider)

	local slider = CreateFrame("Slider", "PRRange_InAlpha", options, "PRSliderTemplate")
	slider.Text:SetText(L["In-Range Alpha"])
	slider.High:SetText("1")
	slider.Low:SetText("0")
	slider:SetMinMaxValues(0,1)
	slider:SetValueStep(0.05)
	table.insert(options.widgets, slider)

	local slider = CreateFrame("Slider", "PRRange_OutAlpha", options, "PRSliderTemplate")
	slider.Text:SetText(L["Out-of-Range Alpha"])
	slider.High:SetText("1")
	slider.Low:SetText("0")
	slider:SetMinMaxValues(0,1)
	slider:SetValueStep(0.05)
	table.insert(options.widgets, slider)

	local cancel = CreateFrame("Button", "PRRange_Cancel", options, "PRButtonTemplate")
	cancel:SetText(L["Cancel"])
	cancel:SetPoint("BOTTOMRIGHT", 0, 5)
	cancel:SetScript("OnClick", function() self:OnShow() end)
	cancel:Show()

	local save = CreateFrame("Button", "PRRange_Save", options, "PRButtonTemplate")
	save:SetText(L["Save"])
	save:SetPoint("BOTTOMRIGHT", cancel, "BOTTOMLEFT", -10, 0)
	save:SetScript("OnClick", function() self:SaveOptions() end)
	save:Show()

	for idx,widget in ipairs(options.widgets) do
		widget:Show()
		if idx == 1 then
			widget:SetPoint("TOPLEFT", 0, 0)
		else
			widget:SetPoint("TOPLEFT", options.widgets[idx - 1], "BOTTOMLEFT", 0, -15)
		end
	end
end

function Range:OnShow()
	local profile = PerfectRaid.db.profile

	PRRange_Enable:SetChecked(profile.RangeCheck)
	PRRange_Rate:SetValue(profile.RangeRate)
	PRRange_InAlpha:SetValue(profile.RangeInAlpha)
	PRRange_OutAlpha:SetValue(profile.RangeOutAlpha)
end

function Range:SaveOptions()
	local profile = PerfectRaid.db.profile

	profile.RangeCheck = PRRange_Enable:GetChecked() or false
	profile.RangeRate = PRRange_Rate:GetValue()
	profile.RangeInAlpha = PRRange_InAlpha:GetValue()
	profile.RangeOutAlpha = PRRange_OutAlpha:GetValue()

	if profile.RangeCheck then
		self:Enable()
	else
		self:Disable()
	end
end

