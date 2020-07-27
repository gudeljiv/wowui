--[[-------------------------------------------------------------------------
  *
  * IncomingHeals module for PerfectRaid addon.
  *
  * Written by: Panoramix
  * Version: 1.0
  *   
---------------------------------------------------------------------------]]


local IncomingHeals = PerfectRaid:NewModule("PerfectRaid-IncomingHeals")

local L = PerfectRaidLocals
local utils, frames

function IncomingHeals:Initialize()
	
	frames = PerfectRaid.frames
	utils = PerfectRaid.utils
	
	self:RegisterMessage("DONGLE_PROFILE_CHANGED")
	self:RegisterMessage("PERFECTRAID_CONFIG_CHANGED")	
end


function IncomingHeals:DONGLE_PROFILE_CHANGED(event, addon, svname, name)
	if svname == "PerfectRaidDB" then
		IncomingHeals:EnableIncomingHeals(PerfectRaid.db.profile.showincomingheals)
	end
end

function IncomingHeals:PERFECTRAID_CONFIG_CHANGED(event, addon, svname, name)
	IncomingHeals:EnableIncomingHeals(PerfectRaid.db.profile.showincomingheals)	
end

function IncomingHeals:Enable()
	IncomingHeals:EnableIncomingHeals(PerfectRaid.db.profile.showincomingheals)	
end

function IncomingHeals:EnableIncomingHeals(value)
	if value then
		self:RegisterEvent("UNIT_HEAL_PREDICTION", "UpdateIncomingHeals")
		self:RegisterEvent("UNIT_ABSORB_AMOUNT_CHANGED", "UpdateIncomingHeals")
	else
		self:UnregisterEvent("UNIT_HEAL_PREDICTION", "UpdateIncomingHeals")
		self:UnregisterEvent("UNIT_ABSORB_AMOUNT_CHANGED", "UpdateIncomingHeals")
	end	
end


function IncomingHeals:ConfigureButton( button )

	local inchealbar = CreateFrame("StatusBar", nil, button)
	button.incominghealsbar = inchealbar	
	
	local absorbbar = CreateFrame("StatusBar", nil, button)
	button.absorbbar = absorbbar 
end

function IncomingHeals:UpdateButtonLayout( button )
	
	button.incominghealsbar:ClearAllPoints()
	button.incominghealsbar:SetPoint("TOPLEFT", button.leftbox, "TOPRIGHT", 0, -1)
	button.incominghealsbar:SetPoint("BOTTOMRIGHT", button.rightbox, "BOTTOMLEFT", 0, 1)
	button.incominghealsbar:SetStatusBarTexture("Interface\\AddOns\\PerfectRaid\\images\\smooth")
	button.incominghealsbar:SetFrameLevel( button.healthbar:GetFrameLevel()-1 )
	button.incominghealsbar:SetStatusBarColor( 0.3, 0.5, 0.3 )
	button.incominghealsbar:Hide()
	
	button.absorbbar:ClearAllPoints()
	button.absorbbar:SetPoint("TOPLEFT", button.leftbox, "TOPRIGHT", 0, -1)
	button.absorbbar:SetPoint("BOTTOMRIGHT", button.rightbox, "BOTTOMLEFT", 0, 1)
	button.absorbbar:SetStatusBarTexture("Interface\\AddOns\\PerfectRaid\\images\\smooth")
	button.absorbbar:SetFrameLevel( button.healthbar:GetFrameLevel()-2 )
	button.absorbbar:SetStatusBarColor( 0, 0.651, 0.871 )
	button.absorbbar:Hide()
	
end

function IncomingHeals:UpdateIncomingHeals( event, target )

	-- not the right unit
	if target == "target" then return end
	
	local health = UnitHealth(target)
	local maxhealth = UnitHealthMax(target)
	local healinc = UnitGetIncomingHeals(target)
	local absorbinc = UnitGetTotalAbsorbs(target)

	-- not correct healinc or health
	if health == null or healinc == null then return end
	
	local healthincsum = health + healinc
	local healthabsorbsum = health + healinc + absorbinc
	
	-- adjust healthsum to maxhealth
	if healthincsum > maxhealth then healthincsum = maxhealth end
	if healthabsorbsum > maxhealth then healthabsorbsum = maxhealth end
	
	for unit, tbl in pairs(frames) do

		if UnitIsUnit( target, unit ) then
				
			for frame in pairs(frames[unit]) do	
			
				-- heal inc
				if healinc == 0 or health == maxhealth then				
					frame.incominghealsbar:Hide()
				else
					frame.incominghealsbar:SetMinMaxValues(0, maxhealth)
					frame.incominghealsbar:SetValue(healthincsum)
					frame.incominghealsbar:Show()
				end
				
				-- absorb inc
				if absorbinc == 0 or health == maxhealth then				
					frame.absorbbar:Hide()
				else
					frame.absorbbar:SetMinMaxValues(0, maxhealth)
					frame.absorbbar:SetValue(healthabsorbsum)
					frame.absorbbar:Show()
				end
				
			end
			
		end			
	end
	
	
end