local _, xVermin = ...

count = 0
C_Timer.NewTicker(
	1,
	function(self)
		if (count > xVermin.WaitTimeUntillAddonLoaded) then
			self:Cancel()
		end
		count = count + 1

		if (RangeDisplayMainFrame_playertarget) then
			RangeDisplayMainFrame_playertarget:SetPoint('CENTER', UIParent, 'CENTER', 0, -20)
			RangeDisplayMainFrame_playertarget.ClearAllPoints = function()
			end
			RangeDisplayMainFrame_playertarget.SetPoint = function()
			end

			self:Cancel()
		end
	end
)

count = 0
C_Timer.NewTicker(
	1,
	function(self)
		if (count > xVermin.WaitTimeUntillAddonLoaded) then
			self:Cancel()
		end
		count = count + 1

		if (RangeDisplayMainFrame_mouseover) then
			RangeDisplayMainFrame_mouseover:SetPoint('CENTER', UIParent, 'CENTER', 0, -35)
			RangeDisplayMainFrame_mouseover.ClearAllPoints = function()
			end
			RangeDisplayMainFrame_mouseover.SetPoint = function()
			end

			self:Cancel()
		end
	end
)
