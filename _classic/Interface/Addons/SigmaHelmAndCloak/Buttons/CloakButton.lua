local _, SHC = ...;

-- Cloak Button
SHC.CloakButton = CreateFrame("CheckButton", nil, CharacterBackSlot, "UICheckButtonTemplate");

function SHC.CloakButton:OnLoad()
	SHC.CloakButton:SetPoint("BOTTOMLEFT");
	SHC.CloakButton:SetWidth(15);
	SHC.CloakButton:SetHeight(15);
	SHC.CloakButton.BG = SHC.CloakButton:CreateTexture(nil, "BACKGROUND")
	SHC.CloakButton.BG:SetPoint("CENTER")
	SHC.CloakButton.BG:SetColorTexture(0, 0, 0, 0.75)
	SHC.CloakButton.BG:SetWidth(9);
	SHC.CloakButton.BG:SetHeight(8);
	SHC.CloakButton:SetScript("OnShow", SHC.CloakButton.OnShow);
	SHC.CloakButton:SetScript("OnClick", SHC.CloakButton.OnClick);
end

function SHC.CloakButton:OnShow()
	SHC.CloakButton:SetChecked(ShowingCloak());
end

function SHC.CloakButton:OnClick()
	ShowCloak(not ShowingCloak());
end

SHC.CloakButton:OnLoad();
