local TargetHealthFrame = CreateFrame("Frame", "TargetHealthFrame", UIParent)
TargetHealthFrame:SetWidth(1)
TargetHealthFrame:SetHeight(1)
TargetHealthFrame:SetAlpha(0.9)
TargetHealthFrame:SetPoint("CENTER", UIParent, "CENTER", 100, -40)
TargetHealthFrame.text = TargetHealthFrame:CreateFontString(nil, "ARTWORK")
TargetHealthFrame.text:SetFont(config.font.arial, 28, "THINOUTLINE")
TargetHealthFrame.text:SetPoint("CENTER", TargetHealthFrame, "CENTER", 0, 0)
TargetHealthFrame:SetFrameStrata("LOW")

local PlayerHealthFrame = CreateFrame("Frame", "PlayerHealthFrame", UIParent)
PlayerHealthFrame:SetWidth(1)
PlayerHealthFrame:SetHeight(1)
PlayerHealthFrame:SetAlpha(0.9)
PlayerHealthFrame:SetPoint("CENTER", UIParent, "CENTER", -100, -40)
PlayerHealthFrame.text = PlayerHealthFrame:CreateFontString(nil, "ARTWORK")
PlayerHealthFrame.text:SetFont(config.font.arial, 28, "THINOUTLINE")
PlayerHealthFrame.text:SetPoint("CENTER", PlayerHealthFrame, "CENTER", 0, 0)
PlayerHealthFrame:SetFrameStrata("LOW")

local function PHealthShow()
	local playerHP = format("%.0f", (UnitHealth("player") / UnitHealthMax("player")) * 100)
	PlayerHealthFrame.text:SetText(playerHP)
	PlayerHealthFrame.text:SetVertexColor(1, 1, 1)
	PlayerHealthFrame.text:Show()
end

local function THealthHide()
	TargetHealthFrame.text:Hide()
end
local function THealthShow()
	if TargetFrame:IsShown() then
		local targetHP = format("%.0f", (UnitHealth("target") / UnitHealthMax("target")) * 100)
		TargetHealthFrame.text:SetText(targetHP)
		TargetHealthFrame.text:SetVertexColor(1, 1, 1)
		TargetHealthFrame.text:Show()
	else
		THealthHide()
	end
end

UIParent:HookScript("OnUpdate", THealthShow)
PlayerFrame:HookScript("OnUpdate", PHealthShow)
