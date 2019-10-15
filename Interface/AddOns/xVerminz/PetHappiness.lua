local PetHappinessFrame = CreateFrame("Frame", "CustomContainer_PetHappinessFrame", CustomContainer_Combat)
PetHappinessFrame:SetPoint("BOTTOM", CustomContainer_Combat, "TOP", 0, 10)
PetHappinessFrame:SetWidth(45)
PetHappinessFrame:SetHeight(45)
PetHappinessFrame:CreateBeautyBorder(12)
PetHappinessFrame:SetFrameStrata("LOW")
PetHappinessFrame.Icon = PetHappinessFrame:CreateTexture()
PetHappinessFrame.Icon:SetAllPoints(PetHappinessFrame)
PetHappinessFrame:Hide()

local function InitializePetHappiness()

	local _, class, _ = UnitClass("player");
	if(class ~= "HUNTER") then
		return
	end

	PetFrameHappiness:Hide()

	local happiness, damagePercentage, loyaltyRate = GetPetHappiness()
	if happiness and not UnitIsDead("pet") and UnitExists("pet") then
		local happy = ({"Unhappy", "Content", "Happy"})[happiness]
		local loyalty = loyaltyRate > 0 and "gaining" or "losing"
		if(happiness ~= 3) then
			PetHappinessFrame:Show()
			PetHappinessFrame.Icon:SetTexture([[Interface\PetPaperDollFrame\UI-PetHappiness]])
			if (happiness == 1) then
				PetHappinessFrame.Icon:SetTexCoord(0.375, 0.5625, 0, 0.359375)
			elseif (happiness == 2) then
				PetHappinessFrame.Icon:SetTexCoord(0.1875, 0.375, 0, 0.359375)
			elseif (happiness == 3) then
				PetHappinessFrame.Icon:SetTexCoord(0, 0.1875, 0, 0.359375)
			end
		else
			PetHappinessFrame:Hide()
		end
	else
		PetHappinessFrame:Hide()
	end

end

--local f = CreateFrame("Frame")
--f:RegisterEvent("PET_DISMISS_START")
--f:RegisterEvent("UNIT_HAPPINESS")
----f:SetScript("OnEvent", function()
----	PetHappinessFrame:Hide()
----end)
--
--f:SetScript("OnEvent", InitializePetHappiness)

PlayerFrame:HookScript("OnShow", InitializePetHappiness)
PlayerFrame:HookScript("OnUpdate", InitializePetHappiness)

