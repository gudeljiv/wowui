local button = CreateFrame("Button", "SortBagsButton", ContainerFrame1)
	button:SetPoint("TOPRIGHT", ContainerFrame1, "TOPRIGHT", -10, -27)
	button:SetWidth(50)
	button:SetHeight(20)
	
	button:SetNormalFontObject("GameFontNormal")
	button:SetText("Sort")

	local ntex = button:CreateTexture()
	ntex:SetTexture("Interface/Buttons/UI-Panel-Button-Up")
	ntex:SetTexCoord(0, 0.625, 0, 0.6875)
	ntex:SetAllPoints()	
	button:SetNormalTexture(ntex)
	
	local htex = button:CreateTexture()
	htex:SetTexture("Interface/Buttons/UI-Panel-Button-Highlight")
	htex:SetTexCoord(0, 0.625, 0, 0.6875)
	htex:SetAllPoints()
	button:SetHighlightTexture(htex)
	
	local ptex = button:CreateTexture()
	ptex:SetTexture("Interface/Buttons/UI-Panel-Button-Down")
	ptex:SetTexCoord(0, 0.625, 0, 0.6875)
	ptex:SetAllPoints()
	button:SetPushedTexture(ptex)

button:SetScript("OnClick", function(self, arg1)
	SortBags()
end)


ContainerFrame1:HookScript("OnShow", function(self)
	if ContainerFrame1:GetID() ~= 0 then
		button:Hide()
	else
		button:Show()
	end
end)