local _, nMainbar = ...
local cfg = nMainbar.Config

PetActionBar:SetFrameStrata("HIGH")

PetActionBar:SetScale(cfg.petBar.scale)
PetActionBar:SetAlpha(cfg.petBar.alpha)

-- horizontal/vertical bars

if cfg.petBar.vertical then
	for i = 2, 10 do
		button = _G["PetActionButton" .. i]
		button:ClearAllPoints()
		button:SetPoint("TOP", _G["PetActionButton" .. (i - 1)], "BOTTOM", 0, -8)
	end
end
