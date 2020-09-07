--[[-------------------------------------------------------------------------
  *
  * RaidIcons module for PerfectRaid addon.
  *
  * Written by: Panoramix
  * Version: 1.0
  *
---------------------------------------------------------------------------]]

local Resurrection = PerfectRaid:NewModule("PerfectRaid-Resurrection")
local L = PerfectRaidLocals
local utils, frames

function Resurrection:Initialize()
	frames = PerfectRaid.frames
	utils = PerfectRaid.utils
end

-- Update Raid Icons when addon is enabled
function Resurrection:Enable()
	self:ShowResurrection()
end

-- Show/Hide raid icons depending on value
function Resurrection:ShowResurrection(value)
	self:RegisterEvent("INCOMING_RESURRECT_CHANGED", "UpdateAllUnits")
	self:RegisterEvent("UNIT_OTHER_PARTY_CHANGED", "UpdateAllUnits")
	self:RegisterMessage("PERFECTRAID_FRAME_LAYOUT_CHANGED", "UpdateAllUnits")
	self:UpdateAllUnits()
end

-- Request full update for all units
function Resurrection:FullUpdate()
	self:UpdateAllUnits()
end

function Resurrection:UpdateAllUnits()

    for unit, tbl in pairs(frames) do
	
		local resurrecting = UnitHasIncomingResurrection(unit) 
		
		if (resurrecting and frames and frames[unit]) then
		
			for frame in pairs(frames[unit]) do
				-- create indicator and texture
				if (not frame.resurrect) then
					frame.resurrect = CreateFrame("Frame", nil, frame.healthbar)
					frame.resurrect:SetHeight(frame:GetHeight())
					frame.resurrect:SetWidth(frame:GetHeight( ))
					frame.resurrect:SetFrameLevel(frame.leftbox:GetFrameLevel()+1)

					frame.resurrecticon = frame.resurrect:CreateTexture(nil, "OVERLAY")
					frame.resurrecticon:SetAllPoints()
					frame.resurrecticon:SetTexture("Interface\\RaidFrame\\Raid-Icon-Rez")
				end

				-- resize the texture and show it
				frame.resurrect:ClearAllPoints()
				frame.resurrect:SetParent(frame.healthbar)
				frame.resurrect:SetPoint("LEFT", 0, 0)		
				frame.resurrect:Show()
				frame.resurrecticon:Show()
			end
		end

		-- unit doesn't have resurrection, hide it
		if (not resurrecting and frames and frames[unit]) then
			for frame in pairs(frames[unit]) do
				if (frame.resurrecticon) then
					frame.resurrecticon:Hide()
				end
			end
		end
	end
end
