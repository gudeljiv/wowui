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

local Aggro = PerfectRaid:NewModule("PerfectRaid-Aggro")
local L = PerfectRaidLocals

local frames,aggro
local victims = {}
local targets = {}
local marked = {}
local rate

function Aggro:Initialize()
	PerfectRaid.defaults.profile.AggroCheck = true
	PerfectRaid.defaults.profile.AggroRate = 1.0

	frames = PerfectRaid.frames
	aggro = PerfectRaid.aggro
	self:RegisterMessage("DONGLE_PROFILE_CHANGED")
	self:RegisterMessage("GROUP_ROSTER_UPDATE")
end

function Aggro:Enable()
	if not PerfectRaid.defaults.profile.AggroCheck then return end
	if not self.frame then
		self.frame = CreateFrame("Frame")
	end
	self.frame:SetScript("OnUpdate", self.OnUpdate)
	rate = PerfectRaid.db.profile.AggroRate
end

function Aggro:Disable()
	if self.frame then
		self.frame:SetScript("OnUpdate", nil)
	end
	for k,v in pairs(aggro) do aggro[k] = 0 end
end

function Aggro:DONGLE_PROFILE_CHANGED(event, addon, svname, name)
	if svname == "PerfectRaidDB" then
		rate = PerfectRaid.db.profile.AggroRate
		if PerfectRaid.db.profile.AggroCheck then
			self:Enable()
		else
			self:Disable()
		end
	end
end

local elapsed_counter = 0
function Aggro.OnUpdate(frame, elapsed)
	elapsed_counter = elapsed_counter + elapsed
	if elapsed_counter >= rate then
		-- Aggro check
		for unit,tbl in pairs(frames) do
			if not targets[unit] then
				targets[unit] = unit.."target"
				victims[unit] = unit.."targettarget"
				aggro[unit] = 0
			end

			local target = targets[unit]
			local victim = victims[unit]

			if UnitExists(target) and UnitCanAttack(unit, target) and UnitExists( victim ) and UnitCanAttack(victim, target) then
				for unit2, tbl2  in pairs(frames) do
					if unit2 and UnitIsUnit( unit2, victim ) then
						-- unit is being targeted by a hostile mob
						if not targets[unit2] then
							targets[unit2] = unit2.."target"
							victims[unit2] = unit2.."targettarget"
							aggro[unit2] = 0
						end
						local val = aggro[unit2]
						if val < 20 then
							aggro[unit2] = val + 10
						end
					end
				end
			end
		end

		-- aggro update
		for unit, tbl in pairs(frames) do
			-- Aggro decay (thanks BanzaiLib)
			if aggro[unit] >= 5 then
				aggro[unit] = aggro[unit] - 5
			end
			-- Use this when a unit has aggro
			if aggro[unit] >= 15 then
				if not marked[unit] then
					PerfectRaid:UNIT_HEALTH(nil, unit)
					marked[unit] = true
				end
			else
				if marked[unit] then
					PerfectRaid:UNIT_HEALTH(nil, unit)
					marked[unit] = nil
				end
			end
		end
		elapsed_counter = 0
	end
end

local options
function Aggro:CreateOptions(opt)
	options = CreateFrame("Frame", "PROptions_Aggro", PROptions)
	options:SetScript("OnShow", function() self:OnShow() end)

	opt:AddOptionsTab(L["Aggro"], options)

	options.widgets = {}

	local check = CreateFrame("CheckButton", "PRAggro_Enable", options, "PRCheckTemplate")
	check.Label:SetText(L["Perform aggro checking"])
	table.insert(options.widgets, check)

	local slider = CreateFrame("Slider", "PRAggro_Rate", options, "PRSliderTemplate")
	slider.Text:SetText(L["Update delay"])
	slider.High:SetText("2.0")
	slider.Low:SetText("0")
	slider:SetMinMaxValues(0,2.0)
	slider:SetValueStep(0.1)
	table.insert(options.widgets, slider)

	local cancel = CreateFrame("Button", "PRAggro_Cancel", options, "PRButtonTemplate")
	cancel:SetText(L["Cancel"])
	cancel:SetPoint("BOTTOMRIGHT", 0, 5)
	cancel:SetScript("OnClick", function() self:OnShow() end)
	cancel:Show()

	local save = CreateFrame("Button", "PRAggro_Save", options, "PRButtonTemplate")
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

function Aggro:OnShow()
	local profile = PerfectRaid.db.profile

	PRAggro_Enable:SetChecked(profile.AggroCheck)
	PRAggro_Rate:SetValue(profile.AggroRate)
end

function Aggro:SaveOptions()
	local profile = PerfectRaid.db.profile

	profile.AggroCheck = PRAggro_Enable:GetChecked() or false
	profile.AggroRate = PRAggro_Rate:GetValue()

	if not profile.AggroCheck then
		self:Disable()
	else
		self:Enable()
	end
end
