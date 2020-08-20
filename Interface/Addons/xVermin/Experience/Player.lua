local _, xVermin = ...

local size = 125
local scale = 1.4

local PlayerXP = CreateFrame("Frame", "PlayerXPFrame", UIParent)
PlayerXP:SetScale(scale)
PlayerXP:SetSize(size, 18)
PlayerXP:SetPoint("BOTTOMLEFT", ChatFrame1, "BOTTOMRIGHT", 5, 15)
PlayerXP:EnableMouse(false)

PlayerXP.XPbar = CreateFrame("StatusBar", "PlayerXPFrameStatusBar", UIParent)
PlayerXP.XPbar:SetScale(1)
PlayerXP.XPbar:SetSize(size * scale, 3)
PlayerXP.XPbar:SetPoint("CENTER", PlayerXP, 0, -23)
PlayerXP.XPbar:SetStatusBarTexture("Interface\\AddOns\\xVermin\\Media\\statusbarTexture")
PlayerXP.XPbar:SetAlpha(0)

PlayerXP.XPbar.Value = PlayerXP.XPbar:CreateFontString(nil, "ARTWORK")
PlayerXP.XPbar.Value:SetFont("Fonts\\ARIALN.ttf", 14, "THINOUTLINE")
PlayerXP.XPbar.Value:SetShadowOffset(0, 0)
PlayerXP.XPbar.Value:SetPoint("LEFT", PlayerXP.XPbar, "LEFT", 2, 0)
PlayerXP.XPbar.Value:SetVertexColor(1, 1, 1)

PlayerXP.XPbar.Percent = PlayerXP.XPbar:CreateFontString(nil, "ARTWORK")
PlayerXP.XPbar.Percent:SetFont("Fonts\\ARIALN.ttf", 18, "THINOUTLINE")
PlayerXP.XPbar.Percent:SetShadowOffset(0, 0)
PlayerXP.XPbar.Percent:SetPoint("CENTER", PlayerXP.XPbar, 0, 0)
PlayerXP.XPbar.Percent:SetVertexColor(1, 1, 1)

PlayerXP.XPbar.Rested = PlayerXP.XPbar:CreateFontString(nil, "ARTWORK")
PlayerXP.XPbar.Rested:SetFont("Fonts\\ARIALN.ttf", 14, "THINOUTLINE")
PlayerXP.XPbar.Rested:SetShadowOffset(0, 0)
PlayerXP.XPbar.Rested:SetPoint("RIGHT", PlayerXP.XPbar, "RIGHT", -2, 0)
PlayerXP.XPbar.Rested:SetVertexColor(1, 1, 1)

PlayerXP.XPbar.Background = PlayerXP.XPbar:CreateTexture(nil, "BACKGROUND")
PlayerXP.XPbar.Background:SetAllPoints(PlayerXP.XPbar)
PlayerXP.XPbar.Background:SetTexture("Interface\\AddOns\\xVermin\\Media\\statusbarTexture")
PlayerXP.XPbar.Background:SetVertexColor(0.25, 0.25, 0.25, 1)

PlayerXP.XPbar.BackgroundShadow = CreateFrame("Frame", nil, PlayerXP.XPbar)
PlayerXP.XPbar.BackgroundShadow:SetFrameStrata("BACKGROUND")
PlayerXP.XPbar.BackgroundShadow:SetPoint("TOPLEFT", -4, 4)
PlayerXP.XPbar.BackgroundShadow:SetPoint("BOTTOMRIGHT", 4, -4)
PlayerXP.XPbar.BackgroundShadow:SetBackdrop(
	{
		BgFile = "Interface\\ChatFrame\\ChatFrameBackground",
		edgeFile = "Interface\\AddOns\\xVermin\\Media\\textureGlow",
		edgeSize = 4,
		insets = {left = 3, right = 3, top = 3, bottom = 3}
	}
)
PlayerXP.XPbar.BackgroundShadow:SetBackdropColor(0.15, 0.15, 0.15, 1)
PlayerXP.XPbar.BackgroundShadow:SetBackdropBorderColor(0, 0, 0)

PlayerXP.XPbar.Below = PlayerXP.XPbar:CreateTexture(nil, "BACKGROUND")
PlayerXP.XPbar.Below:SetHeight(14)
PlayerXP.XPbar.Below:SetWidth(14)
PlayerXP.XPbar.Below:SetTexture("Interface\\AddOns\\xVermin\\Media\\textureArrowBelow")

PlayerXP.XPbar.Above = PlayerXP.XPbar:CreateTexture(nil, "BACKGROUND")
PlayerXP.XPbar.Above:SetHeight(14)
PlayerXP.XPbar.Above:SetWidth(14)
PlayerXP.XPbar.Above:SetTexture("Interface\\AddOns\\xVermin\\Media\\textureArrowAbove")
PlayerXP.XPbar.Above:SetPoint("BOTTOM", PlayerXP.XPbar.Below, "TOP", 0, PlayerXP.XPbar:GetHeight())

local function UpdateBarVisibility()
	if UnitLevel("player") < MAX_PLAYER_LEVEL_TABLE[GetExpansionLevel()] then
		PlayerXP.XPbar:SetAlpha(0.8)
	else
		PlayerXP.XPbar:SetAlpha(0)
	end
end

local function UpdateBarValueAndColor(self, event)
	if UnitLevel("player") < MAX_PLAYER_LEVEL_TABLE[GetExpansionLevel()] then
		CurrentXP = UnitXP("player")
		MaxXP = UnitXPMax("player")
		percent = floor((CurrentXP / MaxXP) * 100)
		_, _, rested = GetRestState()
		r, g, b = xVermin:ColorGradient(percent / 100, 1, 0, 0, 1, 1, 0, 0, 1, 0)
		PlayerXP.XPbar:SetMinMaxValues(0, MaxXP)
		PlayerXP.XPbar:SetValue(CurrentXP)
		PlayerXP.XPbar.Value:SetText(xVermin:FormatNumber(CurrentXP, ","))
		PlayerXP.XPbar.Percent:SetText(xVermin:Round(percent) .. "%")
		PlayerXP.XPbar.Rested:SetText(rested == 2 and "R" or "")
		PlayerXP.XPbar:SetStatusBarColor(r, g, b)
	end
end

local function UpdateBar()
	UpdateBarVisibility()
	UpdateBarValueAndColor()
end

PlayerXP:RegisterEvent("PLAYER_XP_UPDATE")
PlayerXP:RegisterEvent("PLAYER_ENTERING_WORLD")
PlayerXP:RegisterEvent("PLAYER_LEVEL_UP")
PlayerXP:SetScript(
	"OnEvent",
	function(self, event, arg1)
		if event == "PLAYER_LEVEL_UP" or event == "PLAYER_ENTERING_WORLD" then
			C_Timer.After(
				1,
				function()
					UpdateBar()
				end
			)
		else
			UpdateBar()
		end
	end
)
