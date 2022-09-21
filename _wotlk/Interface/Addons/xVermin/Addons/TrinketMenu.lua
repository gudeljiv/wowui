local _, xVermin = ...
local count = 0

C_Timer.NewTicker(
	1,
	function(self)
		if (count > 10) then
			self:Cancel()
		end
		if TrinketMenu_MainFrame then
			TrinketMenu_MainFrame:HookScript(
				'OnUpdate',
				function(self)
					self:ClearAllPoints()
					self:SetPoint('RIGHT', PlayerFrame, 'LEFT', 30, 4)
					self.ClearAllPoints = function()
					end
					self.SetPoint = function()
					end
					self:SetMovable(false)
				end
			)

			self:Cancel()
		end
	end
)
