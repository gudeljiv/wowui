local _, SHC = ...;

-- Helm Button
SHC.HelmButton = CreateFrame("CheckButton", nil, CharacterHeadSlot, "UICheckButtonTemplate");

function SHC.HelmButton:OnLoad()
	SHC.HelmButton:SetPoint("BOTTOMLEFT");
	SHC.HelmButton:SetWidth(15);
	SHC.HelmButton:SetHeight(15);
	SHC.HelmButton.BG = SHC.HelmButton:CreateTexture(nil, "BACKGROUND")
	SHC.HelmButton.BG:SetPoint("CENTER")
	SHC.HelmButton.BG:SetColorTexture(0, 0, 0, 0.75)
	SHC.HelmButton.BG:SetWidth(9);
	SHC.HelmButton.BG:SetHeight(8);
	SHC.HelmButton:SetScript("OnShow", SHC.HelmButton.OnShow);
	SHC.HelmButton:SetScript("OnClick", SHC.HelmButton.OnClick);
end

function SHC.HelmButton:OnShow()
	SHC.HelmButton:SetChecked(ShowingHelm());
end

function SHC.HelmButton:OnClick()
	ShowHelm(not ShowingHelm());
end

SHC.HelmButton:OnLoad();
