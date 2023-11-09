-- ElvUI Compatibility
if ElvUI then
	local _, SHC = ...;
	local E = unpack(ElvUI);
	local S = E:GetModule('Skins');
	
	S:HandleCheckBox(SHC.HelmButton, true);
	SHC.HelmButton:SetWidth(10);
	SHC.HelmButton:SetHeight(10);
	SHC.HelmButton:ClearAllPoints();
	SHC.HelmButton:SetPoint("BOTTOMLEFT", 1, 1);
	
	S:HandleCheckBox(SHC.CloakButton, true);
	SHC.CloakButton:SetWidth(10);
	SHC.CloakButton:SetHeight(10);
	SHC.CloakButton:ClearAllPoints();
	SHC.CloakButton:SetPoint("BOTTOMLEFT", 1, 1);
end
