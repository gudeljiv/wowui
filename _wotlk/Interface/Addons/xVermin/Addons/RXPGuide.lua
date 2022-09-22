local _, xVermin = ...
local count = 0

C_Timer.NewTicker(
	1,
	function(self)
		if (count > 10) then
			self:Cancel()
		end
		if RXPFrame then
			RXPFrame:HookScript(
				'OnLoad',
				function(self)
					if not self.SetBackdrop then
						Mixin(self, BackdropTemplateMixin)
					end

					self:ClearAllPoints()
					self:SetPoint('BOTTOMRIGHT', 'ChatFrame3', 'BOTTOMLEFT', 0, -10)
					self.ClearAllPoints = function()
					end
					self.SetPoint = function()
					end
				end
			)

			self:Cancel()
		end
	end
)
