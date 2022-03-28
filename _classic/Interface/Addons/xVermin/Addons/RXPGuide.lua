local _, xVermin = ...


C_Timer.NewTicker(1, function(self)
	if RXPFrame then
		RXPFrame:HookScript("OnUpdate", function(self)

				if not self.SetBackdrop then
					Mixin(self, BackdropTemplateMixin)
				end

				self:ClearAllPoints()
				self:SetPoint("BOTTOMLEFT", "ChatFrame4", "TOPLEFT", 0, 30)
				self.ClearAllPoints = function() end
				self.SetPoint = function() end

			end)

		self:Cancel()
	end
end)