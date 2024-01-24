local _, xVermin = ...

local frames = {
	SettingsPanel
}


for index, frame in pairs(frames) do

	if not frame then return end

	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:SetScript(
		"OnMouseDown", 
		function(self, button)
			if button == "LeftButton" and not self.isMoving then
				self:StartMoving();
				self.isMoving = true;
			end
		end
	)
	frame:SetScript(
		"OnMouseUp", 
		function(self, button)
			if button == "LeftButton" and self.isMoving then
			self:StopMovingOrSizing();
			self.isMoving = false;
			end
		end
	)
	frame:SetScript(
		"OnHide", 
		function(self)
			if ( self.isMoving ) then
				self:StopMovingOrSizing();
				self.isMoving = false;
			end
		end
	)
end

