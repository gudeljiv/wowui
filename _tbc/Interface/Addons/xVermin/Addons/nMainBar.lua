local _, xVermin = ...
local count

MainMenuExpBar:Hide()
MainMenuExpBar:HookScript(
	'OnShow',
	function(self)
		self:Hide()
	end
)

ReputationWatchBar:Hide()
ReputationWatchBar:HookScript(
	'OnShow',
	function(self)
		self:Hide()
	end
)

count = 0
C_Timer.NewTicker(
	1,
	function(self)
		if (count > 10) then
			self:Cancel()
		end
		if StanceButton1 then
			-- StanceButton1:HookScript("OnUpdate", function(self)
			StanceButton1:ClearAllPoints()
			StanceButton1:SetPoint('BOTTOMLEFT', 'MultiBarBottomRightButton1', 'TOPLEFT', 0, 7)
			StanceButton1.ClearAllPoints = function()
			end
			StanceButton1.SetPoint = function()
			end
			-- end)
			self:Cancel()
		end
	end
)

count = 0
C_Timer.NewTicker(
	1,
	function(self)
		if (count > 10) then
			self:Cancel()
		end
		if MultiBarBottomLeft then
			-- MultiBarBottomLeftButton1:HookScript("OnUpdate", function(self)
			MultiBarBottomLeftButton1:ClearAllPoints()
			MultiBarBottomLeftButton1:SetPoint('BOTTOMLEFT', MainMenuBar, 'TOPLEFT', 9, -4)
			MultiBarBottomLeftButton1.ClearAllPoints = function()
			end
			MultiBarBottomLeftButton1.SetPoint = function()
			end
			-- end)
			self:Cancel()
		end
	end
)

count = 0
C_Timer.NewTicker(
	1,
	function(self)
		if (count > 10) then
			self:Cancel()
		end
		if MultiBarRight then
			MultiBarRight:SetScale(0.8)
			MultiBarRight.SetScale = function()
			end
			-- MultiBarRightButton1:HookScript("OnUpdate", function(self)
			MultiBarRightButton1:ClearAllPoints()
			MultiBarRightButton1:SetPoint('TOPRIGHT', UIParent, 'TOPRIGHT', -9, -25)
			MultiBarRightButton1.ClearAllPoints = function()
			end
			MultiBarRightButton1.SetPoint = function()
			end
			-- end)
			self:Cancel()
		end
	end
)

count = 0
C_Timer.NewTicker(
	1,
	function(self)
		if (count > 10) then
			self:Cancel()
		end
		if MultiBarLeft then
			MultiBarLeft:SetScale(0.8)
			MultiBarLeft.SetScale = function()
			end
			-- MultiBarLeftButton1:HookScript("OnUpdate", function(self)
			MultiBarLeftButton1:ClearAllPoints()
			MultiBarLeftButton1:SetPoint('TOP', MultiBarRightButton12, 'BOTTOM', 0, -20)
			MultiBarLeftButton1.ClearAllPoints = function()
			end
			MultiBarLeftButton1.SetPoint = function()
			end
			-- end)
			self:Cancel()
		end
	end
)

count = 0
C_Timer.NewTicker(
	1,
	function(self)
		if (count > 10) then
			self:Cancel()
		end

		if PetActionButton1 then
			PetActionButton1:Show()
			PetActionButton1:ClearAllPoints()
			PetActionButton1:SetMovable(true)
			PetActionButton1:SetUserPlaced(true)
			PetActionButton1:SetPoint('BOTTOM', MultiBarBottomRightButton2, 'TOP', 20, 7)
			PetActionButton1.ClearAllPoints = function()
			end
			PetActionButton1.SetPoint = function()
			end

			self:Cancel()
		end
	end
)

-- C_Timer.NewTicker(1, function(self)
-- 	if MultiBarRight then
-- 		MultiBarRight:SetScale(0.8)
-- 		MultiBarRight.SetScale = function() end
-- 		self:Cancel()
-- 	end
-- end)

-- C_Timer.NewTicker(1, function(self)
-- 	if MultiBarLeft then
-- 		MultiBarLeft:SetScale(0.8)
-- 		MultiBarLeft.SetScale = function() end
-- 		self:Cancel()
-- 	end
-- end)

-- C_Timer.NewTicker(1, function(self)
-- 	if MainMenuBarExpText then
-- 		MainMenuBarExpText:HookScript("OnUpdate", function(self)
-- 			self:ClearAllPoints()
-- 			self:SetPoint("RIGHT", MainMenuExpBar, "RIGHT", -10, 2)
-- 			self.ClearAllPoints = function() end
-- 			self.SetPoint = function() end
-- 		end)
-- 		self:Cancel()
-- 	end
-- end)
