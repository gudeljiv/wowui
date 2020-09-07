--[[-------------------------------------------------------------------------
  *
  * RaidIcons module for PerfectRaid addon.
  *
  * Written by: Panoramix
  * Version: 1.0
  *
---------------------------------------------------------------------------]]

local RaidIcons = PerfectRaid:NewModule("PerfectRaid-RaidIcons")
local L = PerfectRaidLocals
local utils, frames

function RaidIcons:Initialize()

	frames = PerfectRaid.frames
	utils = PerfectRaid.utils

	self:RegisterMessage("DONGLE_PROFILE_CHANGED")
	self:RegisterMessage("PERFECTRAID_CONFIG_CHANGED")
end

-- Update Raid Icons when profiles changes
function RaidIcons:DONGLE_PROFILE_CHANGED(event, addon, svname, name)
	if svname == "PerfectRaidDB" then
		RaidIcons:ShowRaidIcons(PerfectRaid.db.profile.showraidicons)
	end
end

-- Update Raid Icons when config is changed
function RaidIcons:PERFECTRAID_CONFIG_CHANGED(event, addon, svname, name)
	self:ShowRaidIcons(PerfectRaid.db.profile.showraidicons)
end

-- Update Raid Icons when addon is enabled
function RaidIcons:Enable()
	self:ShowRaidIcons(PerfectRaid.db.profile.showraidicons)
end

-- Show/Hide raid icons depending on value
function RaidIcons:ShowRaidIcons(value)
	if value then
		self:RegisterEvent("RAID_TARGET_UPDATE", "UpdateAllUnits")
		self:RegisterMessage("PERFECTRAID_FRAME_LAYOUT_CHANGED", "UpdateAllUnits")
	else
		self:UnregisterEvent("RAID_TARGET_UPDATE")
		self:UnregisterMessage("PERFECTRAID_FRAME_LAYOUT_CHANGED")
	end
	self:UpdateAllUnits()
end

-- Request full update for all units
function RaidIcons:FullUpdate()
	self:UpdateAllUnits()
end

function RaidIcons:UpdateAllUnits()
	local showraidicons = PerfectRaid.db.profile.showraidicons
	local iconposition = PerfectRaid.db.profile.raidiconposition

    for unit, tbl in pairs(frames) do
		local raidicon = GetRaidTargetIndex(unit)
		if (showraidicons and raidicon and frames and frames[unit]) then
			for frame in pairs(frames[unit]) do
				-- create indicator and texture
				if (not frame.raidicon) then
					--frame.indicator = CreateFrame("Frame", nil, frame.leftbox)
					frame.indicator = CreateFrame("Frame", nil, frame.healthbar)
					frame.indicator:SetHeight(frame:GetHeight())
					frame.indicator:SetWidth(frame:GetHeight( ))
					frame.indicator:SetFrameLevel(frame.leftbox:GetFrameLevel()+1)

					frame.raidicon = frame.indicator:CreateTexture(nil, "OVERLAY")
					frame.raidicon:SetAllPoints()
					frame.raidicon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
				end

				-- resize the texture and show it
				frame.indicator:ClearAllPoints()

				if iconposition == "LNAME" then
					frame.indicator:SetParent(frame.leftbox)
					frame.indicator:SetPoint("RIGHT", -3-frame.name:GetWidth(), 0)
				elseif iconposition == "LHBAR" then
					frame.indicator:SetParent(frame.healthbar)
					frame.indicator:SetPoint("LEFT", 0, 0)
				elseif iconposition == "MHBAR" then
					frame.indicator:SetParent(frame.healthbar)
					frame.indicator:SetPoint("CENTER", 0, 0)
				elseif iconposition == "RHBAR" then
					frame.indicator:SetParent(frame.healthbar)
					frame.indicator:SetPoint("RIGHT", 0, 0)
				end
				SetRaidTargetIconTexture(frame.raidicon, raidicon)
				frame.raidicon:Show()
			end
		end

		-- unit doesn't have raidtarget icon, hide it
		if ((not showraidicons or not raidicon) and frames and frames[unit]) then
			for frame in pairs(frames[unit]) do
				if (frame.raidicon) then
					frame.raidicon:Hide()
				end
			end
		end
	end
end
