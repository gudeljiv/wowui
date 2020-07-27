--[[-------------------------------------------------------------------------
  *
  * RaidRoles module for PerfectRaid addon.
  *
  * Written by: Panoramix
  * Version: 1.0
  *
---------------------------------------------------------------------------]]

if not (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
	return
end

local RaidRoles = PerfectRaid:NewModule("PerfectRaid-Roles")
local L = PerfectRaidLocals
local utils, frames

function RaidRoles:Initialize()

	frames = PerfectRaid.frames
	utils = PerfectRaid.utils

	self:RegisterMessage("DONGLE_PROFILE_CHANGED")
	self:RegisterMessage("PERFECTRAID_CONFIG_CHANGED")
end

-- Update Raid Roles when profiles changes
function RaidRoles:DONGLE_PROFILE_CHANGED(event, addon, svname, name)
	if svname == "PerfectRaidDB" then
		RaidRoles:ShowRaidRoles(PerfectRaid.db.profile.showroles)
	end
end

-- Update Raid Roles when config is changed
function RaidRoles:PERFECTRAID_CONFIG_CHANGED(event, addon, svname, name)
	self:ShowRaidRoles(PerfectRaid.db.profile.showroles)
end

-- Update Raid Roles when addon is enabled
function RaidRoles:Enable()
	self:ShowRaidRoles(PerfectRaid.db.profile.showroles)
end

-- Show/Hide raid icons depending on value
function RaidRoles:ShowRaidRoles(value)
	if value then
		self:RegisterEvent( "PLAYER_ROLES_ASSIGNED", "UpdateAllUnits" )
	else
		self:UnregisterEvent("PLAYER_ROLES_ASSIGNED" )
	end
	self:UpdateAllUnits()
end

-- Request full update for all units
function RaidRoles:FullUpdate()
	self:UpdateAllUnits()
end

function RaidRoles:UpdateAllUnits()

	local showRoles   = PerfectRaid.db.profile.showroles
	local showTank    = PerfectRaid.db.profile.showroletank
	local showDamager = PerfectRaid.db.profile.showroledamager
	local showHealer  = PerfectRaid.db.profile.showrolehealer


    for unit, tbl in pairs(frames) do
		local role = UnitGroupRolesAssigned( unit )

		if role == "NONE" then
			if GetPartyAssignment("MAINTANK", unit) or GetPartyAssignment("MAINASSIST", unit) then
				role = "TANK"
			end
		end

		if ( role and frames and frames[unit] ) then

			for frame in pairs( frames[unit] ) do

				local parent = frame:GetParent()
				local options = PerfectRaid.db.profile.headers[parent.idx]

				-- create indicator and texture
				if (not frame.raidrole) then
					frame.raidrole = CreateFrame("Frame", nil, frame.leftbox)
					frame.raidrole:SetHeight(frame:GetHeight() * 0.75)
					frame.raidrole:SetWidth(frame:GetHeight() * 0.75)
					frame.raidrole:SetFrameLevel(frame.leftbox:GetFrameLevel()+1)

					frame.raidroletex = frame.raidrole:CreateTexture(nil, "OVERLAY")
					frame.raidroletex:SetAllPoints()
					frame.raidroletex:SetTexture("Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES")
				end

				-- position frame according to align
				if options.alignright then
					frame.raidrole:ClearAllPoints()
					frame.raidrole:SetParent(frame.rightbox)
					frame.raidrole:SetPoint("TOPRIGHT", 0, 0)

				else
					frame.raidrole:ClearAllPoints()
					frame.raidrole:SetParent(frame.leftbox)
					frame.raidrole:SetPoint("TOPLEFT", 0, 0)
				end


				if ( showRoles and showTank and role == "TANK" ) then
					frame.raidroletex:SetTexCoord(0, 19/64, 22/64, 41/64)
					frame.raidroletex:Show()

				elseif ( showRoles and showHealer and role == "HEALER" ) then
					frame.raidroletex:SetTexCoord(20/64, 39/64, 1/64, 20/64)
					frame.raidroletex:Show()

				elseif ( showRoles and showDamager and role == "DAMAGER" ) then
					frame.raidroletex:SetTexCoord(20/64, 39/64, 22/64, 41/64)
					frame.raidroletex:Show()

				else
					frame.raidroletex:Hide()
				end

			end
		end

	end
end
