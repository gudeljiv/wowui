
local _, nMainbar = ...
local cfg = nMainbar.Config

StanceBarLeft:SetTexture(nil)
StanceBarMiddle:SetTexture(nil)
StanceBarRight:SetTexture(nil)

StanceBarFrame:SetFrameStrata("MEDIUM")

StanceBarFrame:SetScale(cfg.stanceBar.scale)
StanceBarFrame:SetAlpha(cfg.stanceBar.alpha)

if cfg.stanceBar.hide then
	-- hooksecurefunc("StanceBar_Update", function()
	-- 	-- if StanceBarFrame:IsShown() and not nMainbar:IsTaintable() then
	-- 	if StanceBarFrame:IsShown() then
	-- 		StanceBarFrame:Hide()
	-- 		-- RegisterStateDriver(StanceBarFrame, "visibility", "hide")
	-- 	end
	-- end)
	RegisterStateDriver(StanceBarFrame, "visibility", "hide")
end

