local _, xVermin = ...

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

xVermin.CheckIfLoadedWithTimer(
	'StanceButton1',
	function()
		StanceButton1:ClearAllPoints()
		StanceButton1:SetPoint('BOTTOMLEFT', 'MultiBarBottomRightButton1', 'TOPLEFT', 0, 7)
	end
)

xVermin.CheckIfLoadedWithTimer(
	'MultiBarBottomLeft',
	function()
		MultiBarBottomLeftButton1:ClearAllPoints()
		MultiBarBottomLeftButton1:SetPoint('BOTTOMLEFT', MainMenuBar, 'TOPLEFT', 9, -4)
	end
)

xVermin.CheckIfLoadedWithTimer(
	'MultiBarRight',
	function()
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
	end
)

xVermin.CheckIfLoadedWithTimer(
	'MultiBarLeft',
	function()
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
	end
)

xVermin.CheckIfLoadedWithTimer(
	'PetActionButton1',
	function()
		PetActionButton1:Show()
		PetActionButton1:ClearAllPoints()
		PetActionButton1:SetMovable(true)
		PetActionButton1:SetUserPlaced(true)
		PetActionButton1:SetPoint('BOTTOM', MultiBarBottomRightButton2, 'TOP', 20, 7)
	end
)

xVermin.CheckIfLoadedWithTimer(
	'PossessButton1',
	function()
		PossessButton1:Show()
		PossessButton1:ClearAllPoints()
		PossessButton1:SetMovable(true)
		PossessButton1:SetUserPlaced(true)
		PossessButton1:SetPoint('BOTTOM', UnitExists('pet') and PetActionButton1 or MultiBarBottomRightButton2, 'TOP', 20, 7)
	end
)
