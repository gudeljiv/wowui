local _, xVermin = ...
local count = 0

C_Timer.NewTicker(
	1,
	function(self)
		if (count > 10) then
			self:Cancel()
		end
		if RXPFrame then
			if not RXPFrame.SetBackdrop then
				Mixin(RXPFrame, BackdropTemplateMixin)
			end

			RXPFrame:ClearAllPoints()
			RXPFrame:SetPoint('BOTTOMRIGHT', 'ChatFrame3', 'BOTTOMLEFT', 0, -10)
			RXPFrame.ClearAllPoints = function()
			end
			RXPFrame.SetPoint = function()
			end

			self:Cancel()
		end
	end
)
