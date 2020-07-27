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

local Config = PerfectRaid:NewModule("PerfectRaid-Config")
local L = PerfectRaidLocals
local utils, frames

function Config:Initialize()
	self:RegisterMessage("DONGLE_PROFILE_CREATED")
	self:RegisterMessage("PERFECTRAID_TAB_CHANGED")
end

function Config:Enable()
	-- Toggle party visibility
	self:PartyVisibility()
end

local options
function Config:CreateOptions(opt)
	options = CreateFrame("Frame", "PROptions_Config", PROptions)

	local tab = opt:AddOptionsTab(L["Config"], options)

	options.widgets = {}

	local check = CreateFrame("CheckButton", "PRConfig_HideParty", options, "PRCheckTemplate")
	check.Label:SetText(L["Hide Blizzard Party Frames"])
	table.insert(options.widgets, check)

	local check = CreateFrame("CheckButton", "PRConfig_ShowManaOnly", options, "PRCheckTemplate")
	check.Label:SetText(L["Only show mana bar for mana users"])
	table.insert(options.widgets, check)

	local check = CreateFrame("CheckButton", "PRConfig_ClickCast", options, "PRCheckTemplate")
	check.Label:SetText(L["Enable click-casting on frames"])
	table.insert(options.widgets, check)

	local check = CreateFrame("CheckButton", "PRConfig_Lock", options, "PRCheckTemplate")
	check.Label:SetText(L["Lock frames"])
	table.insert(options.widgets, check)

	local roles = CreateFrame("CheckButton", "PRConfig_RaidRole", options, "PRCheckTemplate")
	roles.Label:SetText(L["Show raid roles"])
	roles:Show();
	roles:SetPoint( "TOPRIGHT", -160, 0 )	
	
	local role1 = CreateFrame("CheckButton", "PRConfig_RaidRoleTank", options, "PRCheckTemplate")
	role1.Label:SetText(L["Show tanks"])
	role1:Show();
	role1:SetPoint( "TOPLEFT", roles, "BOTTOMLEFT", 25, 0)
	
	local role2 = CreateFrame("CheckButton", "PRConfig_RaidRoleDamager", options, "PRCheckTemplate")
	role2.Label:SetText(L["Show damagers"])
	role2:Show();
	role2:SetPoint( "TOPLEFT", role1, "BOTTOMLEFT", 0, 0)
	
	local role3 = CreateFrame("CheckButton", "PRConfig_RaidRoleHealer", options, "PRCheckTemplate")
	role3.Label:SetText(L["Show healers"])
	role3:Show();
	role3:SetPoint( "TOPLEFT", role2, "BOTTOMLEFT", 0, 0)

	local check = CreateFrame("CheckButton", "PRConfig_RaidIcons", options, "PRCheckTemplate")
	check.Label:SetText(L["Show raid icons"])
	table.insert(options.widgets, check)	
	
	local iconPositionDropDown = CreateFrame("Frame", "PRConfig_IconPositionDropDown", options, "UIDropDownMenuTemplate")
	local clickFunc = function(self) UIDropDownMenu_SetSelectedValue(iconPositionDropDown, self.value) end
	iconPositionDropDown.Initialize = function()
		UIDropDownMenu_AddButton{text = L["Left of the name"], value = "LNAME", func = clickFunc}
		UIDropDownMenu_AddButton{text = L["Healthbar - left"], value = "LHBAR", func = clickFunc}
		UIDropDownMenu_AddButton{text = L["Healthbar - middle"], value = "MHBAR", func = clickFunc}
		UIDropDownMenu_AddButton{text = L["Healthbar - right"], value = "RHBAR", func = clickFunc}
	end
	iconPositionDropDown:SetScript("OnShow", function(f)
		UIDropDownMenu_Initialize(iconPositionDropDown, iconPositionDropDown.Initialize)
		UIDropDownMenu_SetSelectedValue(iconPositionDropDown,"LNAME")
	end)
	iconPositionDropDown:SetWidth(200);
	iconPositionDropDown:SetPoint("LEFT", check, "RIGHT", 100, 0)
	options.iconposition = iconPositionDropDown;
	
	local check = CreateFrame("CheckButton", "PRConfig_IncomingHeals", options, "PRCheckTemplate")
	check.Label:SetText(L["Show incoming heals"])
	table.insert(options.widgets, check)

	local cancel = CreateFrame("Button", "PRConfig_Cancel", options, "PRButtonTemplate")
	cancel:SetText(L["Cancel"])
	cancel:SetPoint("BOTTOMRIGHT", 0, 5)
	cancel:SetScript("OnClick", function() options:CancelOptions() end)
	cancel:Show()

	local save = CreateFrame("Button", "PRConfig_Save", options, "PRButtonTemplate")
	save:SetText(L["Save"])
	save:SetPoint("BOTTOMRIGHT", cancel, "BOTTOMLEFT", -10, 0)
	save:SetScript("OnClick", function() options:SaveOptions() end)
	save:Show()

	function options:SaveOptions()
		local hideParty = PRConfig_HideParty:GetChecked() and true or false
		local showMana = PRConfig_ShowManaOnly:GetChecked() and true or false
		local clickCast = PRConfig_ClickCast:GetChecked() and true or false
		local locked = PRConfig_Lock:GetChecked() and true or false
		local showRaidIcons = PRConfig_RaidIcons:GetChecked() and true or false
		local showIncomingHeals = PRConfig_IncomingHeals:GetChecked() and true or false 
		local showRoles = PRConfig_RaidRole:GetChecked() and true or false
		local showRoleTank = PRConfig_RaidRoleTank:GetChecked() and true or false
		local showRoleDamager = PRConfig_RaidRoleDamager:GetChecked() and true or false
		local showRoleHealer = PRConfig_RaidRoleHealer:GetChecked() and true or false
		local raidIconPosition = UIDropDownMenu_GetSelectedValue(PRConfig_IconPositionDropDown)
		
		PerfectRaid.db.profile.hideparty = hideParty
		PerfectRaid.db.profile.showmanaonly = showMana
		PerfectRaid.db.profile.clickcast = clickCast
		PerfectRaid.db.profile.locked = locked
		PerfectRaid.db.profile.showraidicons = showRaidIcons
		PerfectRaid.db.profile.showroles = showRoles
		PerfectRaid.db.profile.showroletank = showRoleTank
		PerfectRaid.db.profile.showroledamager = showRoleDamager
		PerfectRaid.db.profile.showrolehealer = showRoleHealer
		PerfectRaid.db.profile.raidiconposition = raidIconPosition
		PerfectRaid.db.profile.showincomingheals = showIncomingHeals

		PerfectRaid:TriggerMessage("PERFECTRAID_CONFIG_CHANGED")
		Config:PartyVisibility()
	end

	function options:CancelOptions()
		PRConfig_HideParty:SetChecked(PerfectRaid.db.profile.hideparty)
		PRConfig_ShowManaOnly:SetChecked(PerfectRaid.db.profile.showmanaonly)
		PRConfig_ClickCast:SetChecked(PerfectRaid.db.profile.clickcast)
		PRConfig_Lock:SetChecked(PerfectRaid.db.profile.locked)
		PRConfig_RaidIcons:SetChecked(PerfectRaid.db.profile.showraidicons)
		PRConfig_IncomingHeals:SetChecked(PerfectRaid.db.profile.showincomingheals)
		PRConfig_RaidRole:SetChecked(PerfectRaid.db.profile.showroles)
		PRConfig_RaidRoleTank:SetChecked(PerfectRaid.db.profile.showroletank)
		PRConfig_RaidRoleDamager:SetChecked(PerfectRaid.db.profile.showroledamager)
		PRConfig_RaidRoleHealer:SetChecked(PerfectRaid.db.profile.showrolehealer)
		UIDropDownMenu_SetSelectedValue(PRConfig_IconPositionDropDown,PerfectRaid.db.profile.raidiconposition)
	end

	options:SetScript("OnShow", function() options:CancelOptions() end)
	options:Hide()

	for idx,widget in ipairs(options.widgets) do
		widget:Show()
		if idx == 1 then
			widget:SetPoint("TOPLEFT", 0, 0)
		else
			widget:SetPoint("TOPLEFT", options.widgets[idx - 1], "BOTTOMLEFT", 0, -15)
		end
	end
	options.iconposition:Show();	
	
end

local old_ShowPartyFrame = ShowPartyFrame
function Config:PartyVisibility()
	local hideparty = PerfectRaid.db.profile.hideparty
	if hideparty then
		-- Disable the party frames
		self.hidingparty = true
		for i=1,4 do
			local f = getglobal("PartyMemberFrame"..i)
			f:UnregisterAllEvents()
		end
		if PartyMemberBackground and SHOW_PARTY_BACKGROUND == "1" then
			PartyMemberBackground:Hide()
		end

		ShowPartyFrame = function() end
		HidePartyFrame()
	elseif self.hidingparty then
		self.hidingparty = false
		for i=1,4 do
			local f = getglobal("PartyMemberFrame"..i)
			f:RegisterEvent("PLAYER_ENTERING_WORLD");
			f:RegisterEvent("GROUP_ROSTER_UPDATE");
			f:RegisterEvent("PARTY_LEADER_CHANGED");
			f:RegisterEvent("PARTY_MEMBER_ENABLE");
			f:RegisterEvent("PARTY_MEMBER_DISABLE");
			f:RegisterEvent("PARTY_LOOT_METHOD_CHANGED");
			f:RegisterEvent("MUTELIST_UPDATE");
			f:RegisterEvent("IGNORELIST_UPDATE");
			f:RegisterEvent("UNIT_FACTION");
			f:RegisterEvent("UNIT_AURA");
			f:RegisterEvent("UNIT_PET");
			f:RegisterEvent("VOICE_START");
			f:RegisterEvent("VOICE_STOP");
			f:RegisterEvent("VARIABLES_LOADED");
			f:RegisterEvent("VOICE_STATUS_UPDATE");
			f:RegisterEvent("READY_CHECK");
			f:RegisterEvent("READY_CHECK_CONFIRM");
			f:RegisterEvent("READY_CHECK_FINISHED");
		end
		if PartyMemberBackground and SHOW_PARTY_BACKGROUND == "1" then
			PartyMemberBackground:Show()
		end
		ShowPartyFrame = old_ShowPartyFrame
		ShowPartyFrame()
	end
end
