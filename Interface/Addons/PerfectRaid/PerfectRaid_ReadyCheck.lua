--[[-------------------------------------------------------------------------
  *
  * ReadyCheck module for PerfectRaid addon.
  *
  * Written by: Panoramix
  * Version: 1.0
  *   
---------------------------------------------------------------------------]]


local ReadyCheck = PerfectRaid:NewModule("PerfectRaid-ReadyCheck")
local frames

-- the duration to fade the ready check status
ReadyCheck.fadeDuration = 4

function ReadyCheck:Initialize()
	
	frames = PerfectRaid.frames
	
	self:RegisterEvent("READY_CHECK", "UpdateReadyCheck")
	self:RegisterEvent("READY_CHECK_CONFIRM", "UpdateReadyCheck")
	self:RegisterEvent("READY_CHECK_FINISHED", "UpdateReadyCheck")
	
	self.started = false
end


function ReadyCheck:ConfigureButton( button )
	button.readycheck = CreateFrame("Frame", nil, button.leftbox)	
	button.readycheck.indicator = button.readycheck:CreateTexture(nil, "OVERLAY")
end

function ReadyCheck:UpdateButtonLayout( button )
	
	button.readycheck:ClearAllPoints()
	button.readycheck:SetWidth(button:GetHeight( ))
	button.readycheck:SetHeight(button:GetHeight( ))
	button.readycheck:SetFrameLevel(button.leftbox:GetFrameLevel()+1)
	
	button.readycheck.indicator:SetAllPoints()
	button.readycheck.indicator:SetTexture(READY_CHECK_READY_TEXTURE)	
		
	button.readycheck:SetPoint("RIGHT", button.name, "RIGHT", 0, 0)	
	button.readycheck:Hide()

end


--[[

	event = READY_CHECK | READY_CHECK_CONFIRM(unit)| READY_CHECK_FINISHED
	status = GetReadyCheckStatus( unit )  
		   = "ready" | "notready" | "waiting" 
]]--
function ReadyCheck:UpdateReadyCheck( event, target )

	-- a ready check is initiated, update all frames
	if event == "READY_CHECK" then
	
		for unit, tbl in pairs(frames) do
			
			local status = GetReadyCheckStatus( unit )
						
			for frame in pairs(frames[unit]) do	
				ReadyCheck:SetReadyCheckStatus( frame, status )
			end
		end
		
	-- a ready check is confirmed or declined, update frames of the unit
	elseif event == "READY_CHECK_CONFIRM" then
	
		for unit, tbl in pairs(frames) do
			
			if UnitIsUnit( target, unit ) then
			
				local status = GetReadyCheckStatus( unit )
			
				for frame in pairs(frames[unit]) do	
					ReadyCheck:SetReadyCheckStatus( frame, status )
				end
				
				break
			end
			
		end	
		
	-- the ready check has finished, wrap it up
	elseif event == "READY_CHECK_FINISHED" then
	
		-- update any ~ready status
		for unit, tbl in pairs(frames) do						
			for frame in pairs(frames[unit]) do	

				if frame.readycheck.status then
					
					-- update status to not ready
					if  frame.readycheck.status ~= "ready" then			
						ReadyCheck:SetReadyCheckStatus( frame, "notready" )
					end
					
					-- start fade timer
					frame.readycheck.elapsed = ReadyCheck.fadeDuration
					frame.readycheck:SetScript("OnUpdate", function(self, elapsed) 
	
						self.elapsed = self.elapsed - elapsed
						self:SetAlpha( self.elapsed / ReadyCheck.fadeDuration )					
						
						if self.elapsed <= 0 then
							self:Hide()
							self:SetScript("OnUpdate", nil)
						end
					end)
					
				end
			end
		end	
		
	end
end

function ReadyCheck:SetReadyCheckStatus( frame, status )
	
	frame.readycheck.status = status
	
	if not status then
		return
	end
		
	if( status == "ready" ) then
		frame.readycheck.indicator:SetTexture(READY_CHECK_READY_TEXTURE)
	elseif( status == "notready" ) then
		frame.readycheck.indicator:SetTexture(READY_CHECK_NOT_READY_TEXTURE)
	elseif( status == "waiting" ) then
		frame.readycheck.indicator:SetTexture(READY_CHECK_WAITING_TEXTURE)
	end
	
	frame.readycheck:SetAlpha( 1.0 )
	frame.readycheck:Show()
end

