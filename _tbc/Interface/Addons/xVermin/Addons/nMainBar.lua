local _, xVermin = ...

if C_AddOns.IsAddOnLoaded("nMainBar") then
	MainStatusTrackingBarContainer:Hide()
	MainStatusTrackingBarContainer:HookScript("OnShow", function(self)
		self:Hide()
	end)

	SecondaryStatusTrackingBarContainer:Hide()
	SecondaryStatusTrackingBarContainer:HookScript("OnShow", function(self)
		self:Hide()
	end)

	xVermin.CheckIfLoadedWithTimer("StanceButton1", function()
		StanceButton1:ClearAllPoints()
		StanceButton1:SetPoint("BOTTOMLEFT", "MultiBarBottomRightButton1", "TOPLEFT", 0, 7)
	end)

	xVermin.CheckIfLoadedWithTimer("MultiBarBottomRight", function()
		for i = 1, 12 do
			local button = _G["MultiBarBottomRightButton" .. i]
			if button then
				button:Show()
			end
		end
	end)

	xVermin.CheckIfLoadedWithTimer("MultiBarBottomLeft", function()
		for i = 1, 12 do
			local button = _G["MultiBarBottomLeftButton" .. i]
			if button then
				button:Show()
			end
		end

		MultiBarBottomLeftButton1:ClearAllPoints()
		MultiBarBottomLeftButton1:SetPoint("BOTTOMLEFT", MainMenuBar, "TOPLEFT", 9, -4)
	end)

	xVermin.CheckIfLoadedWithTimer("MultiBarRight", function()
		for i = 1, 12 do
			local button = _G["MultiBarRightButton" .. i]
			if button then
				button:Show()
				button:SetScale(0.8)
			end
		end

		MultiBarRightButton1:ClearAllPoints()
		MultiBarRightButton1:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -9, -25)
	end)

	xVermin.CheckIfLoadedWithTimer("MultiBarLeft", function()
		for i = 1, 12 do
			local button = _G["MultiBarLeftButton" .. i]
			if button then
				button:Show()
				button:SetScale(0.8)
			end
		end

		MultiBarLeftButton1:ClearAllPoints()
		MultiBarLeftButton1:SetPoint("TOP", MultiBarRightButton12, "BOTTOM", 0, -20)
	end)

	xVermin.CheckIfLoadedWithTimer("PetActionButton1", function()
		PetActionButton1:Show()
		PetActionButton1:ClearAllPoints()
		PetActionButton1:SetMovable(true)
		PetActionButton1:SetUserPlaced(true)
		PetActionButton1:SetPoint("BOTTOM", MultiBarBottomRightButton2, "TOP", 20, 7)
	end)

	xVermin.CheckIfLoadedWithTimer("PossessButton1", function()
		PossessButton1:Show()
		PossessButton1:ClearAllPoints()
		PossessButton1:SetMovable(true)
		PossessButton1:SetUserPlaced(true)
		PossessButton1:SetPoint(
			"BOTTOM",
			UnitExists("pet") and PetActionButton1 or MultiBarBottomRightButton2,
			"TOP",
			20,
			7
		)
	end)
end
