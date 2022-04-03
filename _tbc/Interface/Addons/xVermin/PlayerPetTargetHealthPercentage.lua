local _, xVermin = ...

local TargetHealthFrame = CreateFrame('Frame', 'TargetHealthFrame', UIParent)
TargetHealthFrame:SetWidth(1)
TargetHealthFrame:SetHeight(1)
TargetHealthFrame:SetAlpha(0.3)
-- TargetHealthFrame:SetPoint("CENTER", UIParent, "CENTER", 100, -40)
TargetHealthFrame:SetPoint('RIGHT', nHealthStatusBar, 'RIGHT', -32, 18)
TargetHealthFrame.text = TargetHealthFrame:CreateFontString(nil, 'ARTWORK')
TargetHealthFrame.text:SetFont(xVermin.Config.font.arial, 28, 'THINOUTLINE')
TargetHealthFrame.text:SetPoint('CENTER', TargetHealthFrame, 'CENTER', 0, 0)
TargetHealthFrame:SetFrameStrata('LOW')

-- local PlayerHealthFrame = CreateFrame("Frame", "PlayerHealthFrame", UIParent)
-- PlayerHealthFrame:SetWidth(1)
-- PlayerHealthFrame:SetHeight(1)
-- PlayerHealthFrame:SetAlpha(0.3)
-- PlayerHealthFrame:SetPoint("CENTER", UIParent, "CENTER", -100, -40)
-- PlayerHealthFrame.text = PlayerHealthFrame:CreateFontString(nil, "ARTWORK")
-- PlayerHealthFrame.text:SetFont(xVermin.Config.font.arial, 28, "THINOUTLINE")
-- PlayerHealthFrame.text:SetPoint("CENTER", PlayerHealthFrame, "CENTER", 0, 0)
-- PlayerHealthFrame:SetFrameStrata("LOW")

local PetHealthFrame = CreateFrame('Frame', 'PetHealthFrame', UIParent)
PetHealthFrame:SetWidth(1)
PetHealthFrame:SetHeight(1)
PetHealthFrame:SetAlpha(0.3)
-- PetHealthFrame:SetPoint('CENTER', UIParent, 'CENTER', -120, -137)
PetHealthFrame.text = PetHealthFrame:CreateFontString(nil, 'ARTWORK')
PetHealthFrame.text:SetFont(xVermin.Config.font.arial, 18, 'THINOUTLINE')
PetHealthFrame.text:SetPoint('CENTER', PetHealthFrame, 'CENTER', 0, 0)
PetHealthFrame:SetFrameStrata('LOW')

-- local function PlayerHealthShow()
-- 	local playerHP = format("%.0f", (UnitHealth("player") / UnitHealthMax("player")) * 100)
-- 	PlayerHealthFrame.text:SetText(playerHP)
-- 	PlayerHealthFrame.text:SetVertexColor(1, 1, 1)
-- 	PlayerHealthFrame.text:Show()
-- end

local function PetHealthShow()
	local petHP = format('%.0f', (UnitHealth('pet') / UnitHealthMax('pet')) * 100)
	PetHealthFrame.text:SetText(petHP)
	PetHealthFrame.text:SetVertexColor(1, 1, 1)
	PetHealthFrame.text:Show()

	-- no happiness
	if PetFrameHappiness:IsVisible() then
		PetHealthFrame:SetPoint('LEFT', PetFrame, 'RIGHT', 40, -4)
	else
		PetHealthFrame:SetPoint('LEFT', PetFrame, 'RIGHT', 20, -4)
	end
end

local function PetHealthHide()
	PetHealthFrame.text:Hide()
end

local function TargetHealthHide()
	TargetHealthFrame.text:Hide()
end

local function TargetHealthShow()
	local targetHP = format('%.0f', (UnitHealth('target') / UnitHealthMax('target')) * 100)
	TargetHealthFrame.text:SetText(targetHP .. '%')
	TargetHealthFrame.text:SetVertexColor(1, 1, 1)
	TargetHealthFrame.text:Show()
end

TargetFrame:HookScript('OnUpdate', TargetHealthShow)
TargetFrame:HookScript('OnHide', TargetHealthHide)

-- PlayerFrame:HookScript("OnUpdate", PlayerHealthShow)

PetFrame:HookScript('OnUpdate', PetHealthShow)
PetFrame:HookScript('OnHide', PetHealthHide)

local f = CreateFrame('Frame')
f:RegisterEvent('PLAYER_REGEN_DISABLED')
f:RegisterEvent('PLAYER_REGEN_ENABLED')
f:SetScript(
	'OnEvent',
	function(self, event, ...)
		if event == 'PLAYER_REGEN_DISABLED' then
			if PlayerHealthFrame then
				PlayerHealthFrame:SetAlpha(0.8)
			end
			if TargetHealthFrame then
				TargetHealthFrame:SetAlpha(0.8)
			end
			if PetHealthFrame then
				PetHealthFrame:SetAlpha(0.8)
			end
		end
		if event == 'PLAYER_REGEN_ENABLED' then
			if PlayerHealthFrame then
				PlayerHealthFrame:SetAlpha(0.3)
			end
			if TargetHealthFrame then
				TargetHealthFrame:SetAlpha(0.3)
			end
			if PetHealthFrame then
				PetHealthFrame:SetAlpha(0.3)
			end
		end
	end
)
