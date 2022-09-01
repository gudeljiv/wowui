local _, xVermin = ...

C_Timer.NewTicker(
	1,
	function(self)
		if RXPFrame then
			RXPFrame:HookScript(
				'OnUpdate',
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
