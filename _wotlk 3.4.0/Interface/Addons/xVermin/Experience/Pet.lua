local _, xVermin = ...

local size = 125
local scale = 1.4

local PetXP = CreateFrame('Frame', 'PetXPFrame', UIParent)
PetXP:SetScale(scale)
PetXP:SetSize(size, 18)
PetXP:SetPoint('BOTTOM', PlayerXPFrame, 'TOP', 0, 0)
PetXP:EnableMouse(false)

PetXP.XPbar = CreateFrame('StatusBar', 'PetXPFrameStatusBar', UIParent)
PetXP.XPbar:SetScale(1)
PetXP.XPbar:SetSize(size * scale, 3)
PetXP.XPbar:SetPoint('CENTER', PetXP, 0, 0)
PetXP.XPbar:SetStatusBarTexture('Interface\\AddOns\\xVermin\\Media\\statusbarTexture')
PetXP.XPbar:SetAlpha(0)

PetXP.XPbar.Value = PetXP.XPbar:CreateFontString(nil, 'ARTWORK')
PetXP.XPbar.Value:SetFont('Fonts\\ARIALN.ttf', 12, 'THINOUTLINE')
PetXP.XPbar.Value:SetShadowOffset(0, 0)
PetXP.XPbar.Value:SetPoint('LEFT', PetXP.XPbar, 'LEFT', 2, 0)
PetXP.XPbar.Value:SetVertexColor(1, 1, 1)

PetXP.XPbar.UntilLevel = PetXP.XPbar:CreateFontString(nil, 'ARTWORK')
PetXP.XPbar.UntilLevel:SetFont('Fonts\\ARIALN.ttf', 12, 'THINOUTLINE')
PetXP.XPbar.UntilLevel:SetShadowOffset(0, 0)
PetXP.XPbar.UntilLevel:SetPoint('RIGHT', PetXP.XPbar, 'RIGHT', -2, 0)
PetXP.XPbar.UntilLevel:SetVertexColor(1, 1, 1)

PetXP.XPbar.Percent = PetXP.XPbar:CreateFontString(nil, 'ARTWORK')
PetXP.XPbar.Percent:SetFont('Fonts\\ARIALN.ttf', 18, 'THINOUTLINE')
PetXP.XPbar.Percent:SetShadowOffset(0, 0)
PetXP.XPbar.Percent:SetPoint('CENTER', PetXP.XPbar, 0, 0)
PetXP.XPbar.Percent:SetVertexColor(1, 1, 1)

PetXP.XPbar.Background = PetXP.XPbar:CreateTexture(nil, 'BACKGROUND')
PetXP.XPbar.Background:SetAllPoints(PetXP.XPbar)
PetXP.XPbar.Background:SetTexture('Interface\\AddOns\\xVermin\\Media\\statusbarTexture')
PetXP.XPbar.Background:SetVertexColor(0.25, 0.25, 0.25, 1)

PetXP.XPbar.BackgroundShadow = CreateFrame('Frame', nil, PetXP.XPbar, BackdropTemplateMixin and 'BackdropTemplate')
PetXP.XPbar.BackgroundShadow:SetFrameStrata('BACKGROUND')
PetXP.XPbar.BackgroundShadow:SetPoint('TOPLEFT', -4, 4)
PetXP.XPbar.BackgroundShadow:SetPoint('BOTTOMRIGHT', 4, -4)
PetXP.XPbar.BackgroundShadow:SetBackdrop(
	{
		BgFile = 'Interface\\ChatFrame\\ChatFrameBackground',
		edgeFile = 'Interface\\AddOns\\xVermin\\Media\\textureGlow',
		edgeSize = 4,
		insets = {left = 3, right = 3, top = 3, bottom = 3}
	}
)
PetXP.XPbar.BackgroundShadow:SetBackdropColor(0.15, 0.15, 0.15, 1)
PetXP.XPbar.BackgroundShadow:SetBackdropBorderColor(0, 0, 0)

PetXP.XPbar.Below = PetXP.XPbar:CreateTexture(nil, 'BACKGROUND')
PetXP.XPbar.Below:SetHeight(14)
PetXP.XPbar.Below:SetWidth(14)
PetXP.XPbar.Below:SetTexture('Interface\\AddOns\\xVermin\\Media\\textureArrowBelow')

PetXP.XPbar.Above = PetXP.XPbar:CreateTexture(nil, 'BACKGROUND')
PetXP.XPbar.Above:SetHeight(14)
PetXP.XPbar.Above:SetWidth(14)
PetXP.XPbar.Above:SetTexture('Interface\\AddOns\\xVermin\\Media\\textureArrowAbove')
PetXP.XPbar.Above:SetPoint('BOTTOM', PetXP.XPbar.Below, 'TOP', 0, PetXP.XPbar:GetHeight())

local function FormatValue(self)
	if (self >= 10000) then
		return ('%.1fk'):format(self / 1e3)
	else
		return self
	end
end

local PetXPVisible = false
local function UpdateBarVisibility()
	if UnitExists('pet') and UnitLevel('player') > UnitLevel('pet') then
		if not PetXPVisible then
			securecall('UIFrameFadeIn', PetXP.XPbar, 1, 0, 0.8)
			PetXPVisible = true
		end
	else
		if PetXPVisible then
			securecall('UIFrameFadeOut', PetXP.XPbar, 1, 0.8, 0)
			PetXPVisible = false
		end
	end
end

local function UpdateBarValueAndColor(self, event)
	if UnitExists('pet') then
		CurrentXP, MaxXP = GetPetExperience()
		percent = floor((CurrentXP / MaxXP) * 100)
		r, g, b = xVermin.ColorGradient(percent / 100, 1, 0, 0, 1, 1, 0, 0, 1, 0)
		PetXP.XPbar:SetMinMaxValues(0, MaxXP)
		PetXP.XPbar:SetValue(CurrentXP)
		PetXP.XPbar.Value:SetText(xVermin.FormatNumber(CurrentXP, ','))
		-- PetXP.XPbar.UntilLevel:SetText(xVermin.FormatNumber(MaxXP - CurrentXP, ",") .. " / " .. xVermin.FormatNumber(MaxXP, ","))
		PetXP.XPbar.UntilLevel:SetText(xVermin.FormatNumber(MaxXP - CurrentXP, ','))
		PetXP.XPbar.Percent:SetText(xVermin.Round(percent) .. '%')
		PetXP.XPbar:SetStatusBarColor(r, g, b)
	end
end

local function UpdateBar()
	UpdateBarVisibility()
	if xVermin.Class == 'HUNTER' then
		UpdateBarValueAndColor()
	end
end

PetXP:RegisterEvent('UNIT_PET')
PetXP:RegisterEvent('UNIT_PET_EXPERIENCE')
PetXP:RegisterEvent('PLAYER_REGEN_ENABLED')
PetXP:RegisterEvent('PLAYER_LEVEL_CHANGED')
PetXP:SetScript(
	'OnEvent',
	function(self, event)
		C_Timer.After(
			0.5,
			function()
				if UnitLevel('player') == MAX_PLAYER_LEVEL_TABLE[GetExpansionLevel()] then
					PetXP:SetPoint('BOTTOMLEFT', ChatFrame1, 'BOTTOMRIGHT', 5, 0)
				else
					PetXP:SetPoint('BOTTOM', PlayerXPFrame, 'TOP', 0, 0)
				end

				UpdateBar()
			end
		)
	end
)
