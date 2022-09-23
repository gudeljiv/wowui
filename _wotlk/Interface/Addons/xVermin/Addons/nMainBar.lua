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
		count = count + 1

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
		count = count + 1

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
		count = count + 1

		if MultiBarRight then
			MultiBarRightButton1:SetScale(0.8)
			MultiBarRightButton2:SetScale(0.8)
			MultiBarRightButton3:SetScale(0.8)
			MultiBarRightButton4:SetScale(0.8)
			MultiBarRightButton5:SetScale(0.8)
			MultiBarRightButton6:SetScale(0.8)
			MultiBarRightButton7:SetScale(0.8)
			MultiBarRightButton8:SetScale(0.8)
			MultiBarRightButton9:SetScale(0.8)
			MultiBarRightButton10:SetScale(0.8)
			MultiBarRightButton11:SetScale(0.8)
			MultiBarRightButton12:SetScale(0.8)

			MultiBarRightButton1:ClearAllPoints()
			MultiBarRightButton1:SetPoint('TOPRIGHT', UIParent, 'TOPRIGHT', -9, -25)
			MultiBarRightButton1.ClearAllPoints = function()
			end
			MultiBarRightButton1.SetPoint = function()
			end

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
		count = count + 1

		if MultiBarLeft then
			MultiBarLeftButton1:SetScale(0.8)
			MultiBarLeftButton2:SetScale(0.8)
			MultiBarLeftButton3:SetScale(0.8)
			MultiBarLeftButton4:SetScale(0.8)
			MultiBarLeftButton5:SetScale(0.8)
			MultiBarLeftButton6:SetScale(0.8)
			MultiBarLeftButton7:SetScale(0.8)
			MultiBarLeftButton8:SetScale(0.8)
			MultiBarLeftButton9:SetScale(0.8)
			MultiBarLeftButton10:SetScale(0.8)
			MultiBarLeftButton11:SetScale(0.8)
			MultiBarLeftButton12:SetScale(0.8)

			MultiBarLeftButton1:ClearAllPoints()
			MultiBarLeftButton1:SetPoint('TOP', MultiBarRightButton12, 'BOTTOM', 0, -20)
			MultiBarLeftButton1.ClearAllPoints = function()
			end
			MultiBarLeftButton1.SetPoint = function()
			end

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
		count = count + 1

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
