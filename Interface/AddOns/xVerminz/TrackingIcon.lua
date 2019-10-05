local TrackingIconFrame = CreateFrame("Frame", "CustomContainer_TrackingIconFrame", CustomContainer_Combat)
TrackingIconFrame:SetPoint("BOTTOM", CustomContainer_Combat, "TOP", 0, 10)
TrackingIconFrame:SetWidth(45)
TrackingIconFrame:SetHeight(45)
TrackingIconFrame:CreateBeautyBorder(12)
TrackingIconFrame:SetFrameStrata("HIGH")
TrackingIconFrame.Icon = TrackingIconFrame:CreateTexture()
TrackingIconFrame.Icon:SetAllPoints(TrackingIconFrame)
TrackingIconFrame:Hide()

local function TrackingIconMinerals()
	if(not GetTrackingTexture()) then
		TrackingIconFrame:Show()
		TrackingIconFrame.Icon:SetTexture("Interface\\Icons\\spell_nature_earthquake")
	else
		TrackingIconFrame:Hide()
	end
end

local function TrackingIconHerbs()
	if(not GetTrackingTexture()) then
		TrackingIconFrame:Show()
		TrackingIconFrame.Icon:SetTexture("Interface\\Icons\\inv_misc_flower_02")
	else
		TrackingIconFrame:Hide()
	end
end

local function InitializeTracking()
	local tabName, tabTexture, tabOffset, numEntries = GetSpellTabInfo(1)
	for i=tabOffset + 1, tabOffset + numEntries do
		local spellName, spellSubName = GetSpellBookItemName(i, BOOKTYPE_SPELL)
		if(spellName == "Find Minerals") then
			TrackingIconFrame:RegisterUnitEvent("UNIT_AURA","player")
			TrackingIconFrame:SetScript("OnEvent", TrackingIconMinerals)
			TrackingIconMinerals()
		end

		if(spellName == "Find Herbs") then
			TrackingIconFrame:RegisterUnitEvent("UNIT_AURA","player")
			TrackingIconFrame:SetScript("OnEvent", TrackingIconHerbs)
			TrackingIconHerbs()
		end
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", InitializeTracking)

