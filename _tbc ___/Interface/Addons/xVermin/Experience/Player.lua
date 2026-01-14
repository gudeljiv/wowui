local _, xVermin = ...

local size = 125
local scale = 1.4
local MaxXP, CurrentXP, percent, r, g, b

local PlayerXP = CreateFrame('Frame', 'PlayerXPFrame', UIParent)
PlayerXP:SetScale(scale)
PlayerXP:SetSize(size, 18)
PlayerXP:SetPoint('BOTTOMLEFT', ChatFrame1, 'BOTTOMRIGHT', 5, 0)
PlayerXP:EnableMouse(false)

PlayerXP.XPbar = CreateFrame('StatusBar', 'PlayerXPFrameStatusBar', UIParent)
PlayerXP.XPbar:SetScale(1)
PlayerXP.XPbar:SetSize(size * scale, 3)
PlayerXP.XPbar:SetPoint('CENTER', PlayerXP, 0, 0)
PlayerXP.XPbar:SetStatusBarTexture('Interface\\AddOns\\xVermin\\Media\\statusbarTexture')
PlayerXP.XPbar:SetAlpha(0)

PlayerXP.XPbar.Value = PlayerXP.XPbar:CreateFontString(nil, 'ARTWORK')
PlayerXP.XPbar.Value:SetFont('Fonts\\ARIALN.ttf', 14, 'THINOUTLINE')
PlayerXP.XPbar.Value:SetShadowOffset(0, 0)
PlayerXP.XPbar.Value:SetPoint('LEFT', PlayerXP.XPbar, 'LEFT', 2, 0)
PlayerXP.XPbar.Value:SetVertexColor(1, 1, 1)

PlayerXP.XPbar.UntilLevel = PlayerXP.XPbar:CreateFontString(nil, 'ARTWORK')
PlayerXP.XPbar.UntilLevel:SetFont('Fonts\\ARIALN.ttf', 10, 'THINOUTLINE')
PlayerXP.XPbar.UntilLevel:SetShadowOffset(0, 0)
PlayerXP.XPbar.UntilLevel:SetPoint('RIGHT', PlayerXP.XPbar, 'RIGHT', 2, 10)
PlayerXP.XPbar.UntilLevel:SetVertexColor(1, 1, 1)

PlayerXP.XPbar.Percent = PlayerXP.XPbar:CreateFontString(nil, 'ARTWORK')
PlayerXP.XPbar.Percent:SetFont('Fonts\\ARIALN.ttf', 18, 'THINOUTLINE')
PlayerXP.XPbar.Percent:SetShadowOffset(0, 0)
PlayerXP.XPbar.Percent:SetPoint('CENTER', PlayerXP.XPbar, 0, 0)
PlayerXP.XPbar.Percent:SetVertexColor(1, 1, 1)

PlayerXP.XPbar.RestedNumber = PlayerXP.XPbar:CreateFontString(nil, 'ARTWORK')
PlayerXP.XPbar.RestedNumber:SetFont('Fonts\\ARIALN.ttf', 10, 'THINOUTLINE')
PlayerXP.XPbar.RestedNumber:SetShadowOffset(0, 0)
PlayerXP.XPbar.RestedNumber:SetPoint('RIGHT', PlayerXP.XPbar, 'RIGHT', 2, -10)
PlayerXP.XPbar.RestedNumber:SetVertexColor(1, 1, 1)

PlayerXP.XPbar.Background = PlayerXP.XPbar:CreateTexture(nil, 'BACKGROUND')
PlayerXP.XPbar.Background:SetAllPoints(PlayerXP.XPbar)
PlayerXP.XPbar.Background:SetTexture('Interface\\AddOns\\xVermin\\Media\\statusbarTexture')
PlayerXP.XPbar.Background:SetVertexColor(0.25, 0.25, 0.25, 1)

PlayerXP.XPbar.BackgroundShadow = CreateFrame('Frame', nil, PlayerXP.XPbar, BackdropTemplateMixin and 'BackdropTemplate')
PlayerXP.XPbar.BackgroundShadow:SetFrameStrata('BACKGROUND')
PlayerXP.XPbar.BackgroundShadow:SetPoint('TOPLEFT', -4, 4)
PlayerXP.XPbar.BackgroundShadow:SetPoint('BOTTOMRIGHT', 4, -4)
PlayerXP.XPbar.BackgroundShadow:SetBackdrop(
	{
		BgFile = 'Interface\\ChatFrame\\ChatFrameBackground',
		edgeFile = 'Interface\\AddOns\\xVermin\\Media\\textureGlow',
		edgeSize = 4,
		insets = {left = 3, right = 3, top = 3, bottom = 3}
	}
)
PlayerXP.XPbar.BackgroundShadow:SetBackdropColor(0.15, 0.15, 0.15, 1)
PlayerXP.XPbar.BackgroundShadow:SetBackdropBorderColor(0, 0, 0)

PlayerXP.XPbar.Below = PlayerXP.XPbar:CreateTexture(nil, 'BACKGROUND')
PlayerXP.XPbar.Below:SetHeight(14)
PlayerXP.XPbar.Below:SetWidth(14)
PlayerXP.XPbar.Below:SetTexture('Interface\\AddOns\\xVermin\\Media\\textureArrowBelow')

PlayerXP.XPbar.Above = PlayerXP.XPbar:CreateTexture(nil, 'BACKGROUND')
PlayerXP.XPbar.Above:SetHeight(14)
PlayerXP.XPbar.Above:SetWidth(14)
PlayerXP.XPbar.Above:SetTexture('Interface\\AddOns\\xVermin\\Media\\textureArrowAbove')
PlayerXP.XPbar.Above:SetPoint('BOTTOM', PlayerXP.XPbar.Below, 'TOP', 0, PlayerXP.XPbar:GetHeight())

local function UpdateBar(event, isInitialLogin, isReloadingUi)
	MaxXP = UnitXPMax('player')
	CurrentXP = UnitXP('player')

	percent = floor((CurrentXP / MaxXP) * 100)
	r, g, b = xVermin:ColorGradient(percent / 100, 1, 0, 0, 1, 1, 0, 0, 1, 0)

	PlayerXP.XPbar:SetMinMaxValues(0, MaxXP)
	PlayerXP.XPbar:SetValue(CurrentXP)
	PlayerXP.XPbar.Value:SetText(xVermin:FormatNumber(CurrentXP, ','))
	PlayerXP.XPbar.UntilLevel:SetText(xVermin:FormatNumber(MaxXP - CurrentXP, ','))
	PlayerXP.XPbar.Percent:SetText(xVermin:Round(percent) .. '%')
	PlayerXP.XPbar:SetStatusBarColor(r, g, b)

	if (select(3, GetRestState()) == 2) then
		PlayerXP.XPbar.RestedNumber:SetText('R: ' .. xVermin:FormatNumber(GetXPExhaustion(), ','))
	else
		PlayerXP.XPbar.RestedNumber:Hide()
		PlayerXP.XPbar.UntilLevel:SetText(xVermin:FormatNumber(MaxXP - CurrentXP, ','))
		PlayerXP.XPbar.UntilLevel:SetPoint('RIGHT', PlayerXP.XPbar, 'RIGHT', -2, 0)
		PlayerXP.XPbar.UntilLevel:SetFont('Fonts\\ARIALN.ttf', 14, 'THINOUTLINE')
	end
end

PlayerXP:RegisterEvent('PLAYER_XP_UPDATE')
PlayerXP:RegisterEvent('PLAYER_ENTERING_WORLD')
PlayerXP:RegisterEvent('PLAYER_LEVEL_CHANGED')
PlayerXP:SetScript(
	'OnEvent',
	function(self, event, isInitialLogin, isReloadingUi)
		if UnitLevel('player') == MAX_PLAYER_LEVEL_TABLE[GetExpansionLevel()] then
			PlayerXP.XPbar:SetAlpha(0)
			self:UnregisterAllEvents()
		else
			PlayerXP.XPbar:SetAlpha(0.8)
			UpdateBar(event, isInitialLogin, isReloadingUi)
		end
	end
)
