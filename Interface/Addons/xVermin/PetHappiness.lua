local _, xVermin = ...

local PetHappinessFrame = CreateFrame("Frame", "CustomContainer_PetHappinessFrame", CustomContainer_Combat)
PetHappinessFrame:SetPoint("BOTTOM", CustomContainer_Combat, "TOP", 0, 10)
PetHappinessFrame:SetWidth(35)
PetHappinessFrame:SetHeight(35)
-- PetHappinessFrame:CreateBeautyBorder(12)
PetHappinessFrame:SetFrameStrata("LOW")
PetHappinessFrame.Icon = PetHappinessFrame:CreateTexture()
PetHappinessFrame.Icon:SetAllPoints(PetHappinessFrame)
PetHappinessFrame:Hide()

local function InitializePetHappiness()
	if (xVermin.Class ~= "HUNTER") then
		return
	end

	PetFrameHappiness:SetPoint("LEFT", PetFrame, "LEFT", -21, -6)
	PetFrameHappiness:SetScale(0.75)

	-- local happiness, damagePercentage, loyaltyRate = GetPetHappiness()
	-- if happiness and not UnitIsDead("pet") and UnitExists("pet") then
	-- 	local happy = ({"Unhappy", "Content", "Happy"})[happiness]
	-- 	local loyalty = loyaltyRate > 0 and "gaining" or "losing"
	-- 	if (happiness ~= 3) then
	-- 		PetHappinessFrame:Show()
	-- 		PetHappinessFrame.Icon:SetTexture([[Interface\PetPaperDollFrame\UI-PetHappiness]])
	-- 		if (happiness == 1) then
	-- 			PetHappinessFrame.Icon:SetTexCoord(0.375, 0.5625, 0, 0.359375)
	-- 		elseif (happiness == 2) then
	-- 			PetHappinessFrame.Icon:SetTexCoord(0.1875, 0.375, 0, 0.359375)
	-- 		elseif (happiness == 3) then
	-- 			PetHappinessFrame.Icon:SetTexCoord(0, 0.1875, 0, 0.359375)
	-- 		end
	-- 	else
	-- 		PetHappinessFrame:Hide()
	-- 	end
	-- else
	-- 	PetHappinessFrame:Hide()
	-- end
end

local f = CreateFrame("Frame")
f:RegisterEvent("UNIT_HAPPINESS")
f:RegisterEvent("PET_UI_UPDATE")
f:RegisterEvent("PET_UI_CLOSE")
f:RegisterEvent("UNIT_PET", "player")
f:RegisterUnitEvent("UNIT_AURA", "pet")
f:SetScript("OnEvent", InitializePetHappiness)

-- PetFrame:HookScript("OnShow", InitializePetHappiness)
-- PetFrame:HookScript("OnUpdate", InitializePetHappiness)
-- PetFrame:HookScript("OnHide", InitializePetHappiness)
