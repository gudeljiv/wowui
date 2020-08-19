local _, xVermin = ...
local CurrentXP = UnitXP("player")
local MaxXP = UnitXPMax("player")

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
PlayerXP.XPbar:SetStatusBarTexture("Interface\\AddOns\\nPower\\media\\statusbarTexture")
PlayerXP.XPbar:SetAlpha(0)

PlayerXP.XPbar.Value = PlayerXP.XPbar:CreateFontString(nil, "ARTWORK")
PlayerXP.XPbar.Value:SetFont("Fonts\\ARIALN.ttf", 18, "THINOUTLINE")
PlayerXP.XPbar.Value:SetShadowOffset(0, 0)
PlayerXP.XPbar.Value:SetPoint("CENTER", PlayerXP.XPbar, 0, 0)
PlayerXP.XPbar.Value:SetVertexColor(1, 1, 1)

PlayerXP.XPbar.Rested = PlayerXP.XPbar:CreateFontString(nil, "ARTWORK")
PlayerXP.XPbar.Rested:SetFont("Fonts\\ARIALN.ttf", 14, "THINOUTLINE")
PlayerXP.XPbar.Rested:SetShadowOffset(0, 0)
PlayerXP.XPbar.Rested:SetPoint("RIGHT", PlayerXP.XPbar, "RIGHT", -2, 0)
PlayerXP.XPbar.Rested:SetVertexColor(1, 1, 1)

PlayerXP.XPbar.Background = PlayerXP.XPbar:CreateTexture(nil, "BACKGROUND")
PlayerXP.XPbar.Background:SetAllPoints(PlayerXP.XPbar)
PlayerXP.XPbar.Background:SetTexture("Interface\\AddOns\\nPower\\media\\statusbarTexture")
PlayerXP.XPbar.Background:SetVertexColor(0.25, 0.25, 0.25, 1)

PlayerXP.XPbar.BackgroundShadow = CreateFrame("Frame", nil, PlayerXP.XPbar)
PlayerXP.XPbar.BackgroundShadow:SetFrameStrata("BACKGROUND")
PlayerXP.XPbar.BackgroundShadow:SetPoint("TOPLEFT", -4, 4)
PlayerXP.XPbar.BackgroundShadow:SetPoint("BOTTOMRIGHT", 4, -4)
PlayerXP.XPbar.BackgroundShadow:SetBackdrop(
	{
		BgFile = "Interface\\ChatFrame\\ChatFrameBackground",
		edgeFile = "Interface\\Addons\\nPower\\media\\textureGlow",
		edgeSize = 4,
		insets = {left = 3, right = 3, top = 3, bottom = 3}
	}
)
PlayerXP.XPbar.BackgroundShadow:SetBackdropColor(0.15, 0.15, 0.15, 1)
PlayerXP.XPbar.BackgroundShadow:SetBackdropBorderColor(0, 0, 0)

PlayerXP.XPbar.Below = PlayerXP.XPbar:CreateTexture(nil, "BACKGROUND")
PlayerXP.XPbar.Below:SetHeight(14)
PlayerXP.XPbar.Below:SetWidth(14)
PlayerXP.XPbar.Below:SetTexture("Interface\\AddOns\\nPower\\media\\textureArrowBelow")

PlayerXP.XPbar.Above = PlayerXP.XPbar:CreateTexture(nil, "BACKGROUND")
PlayerXP.XPbar.Above:SetHeight(14)
PlayerXP.XPbar.Above:SetWidth(14)
PlayerXP.XPbar.Above:SetTexture("Interface\\AddOns\\nPower\\media\\textureArrowAbove")
PlayerXP.XPbar.Above:SetPoint("BOTTOM", PlayerXP.XPbar.Below, "TOP", 0, PlayerXP.XPbar:GetHeight())

local function FormatValue(self)
	if (self >= 10000) then
		return ("%.1fk"):format(self / 1e3)
	else
		return self
	end
end

local function UpdateBarVisibility()
	if UnitLevel("player") < MAX_PLAYER_LEVEL_TABLE[GetExpansionLevel()] then
		PlayerXP.XPbar:SetAlpha(0.8)
	else
		PlayerXP.XPbar:SetAlpha(0)
	end
end

local function UpdateBarValueAndColor(self, event)
	if UnitLevel("player") < MAX_PLAYER_LEVEL_TABLE[GetExpansionLevel()] then
		if event ~= "UNIT_PET" then
			NewXP = UnitXP("player")
			percent = floor((NewXP / MaxXP) * 100)
			_, _, rested = GetRestState()
			r, g, b = xVermin:ColorGradient(percent / 100, 1, 0, 0, 1, 1, 0, 0, 1, 0)
			PlayerXP.XPbar:SetMinMaxValues(0, MaxXP)
			PlayerXP.XPbar:SetValue(CurrentXP)
			PlayerXP.XPbar.Value:SetText(CurrentXP > 0 and FormatValue(CurrentXP) or "")
			PlayerXP.XPbar.Rested:SetText(rested == 2 and "R" or "")
			PlayerXP.XPbar:SetStatusBarColor(r, g, b)
			CurrentXP = NewXP
		end
	end
end

local function UpdateBar()
	UpdateBarVisibility()
	UpdateBarValueAndColor()
end

PlayerXP:RegisterEvent("PLAYER_XP_UPDATE")
PlayerXP:RegisterEvent("PLAYER_ENTERING_WORLD")
PlayerXP:RegisterEvent("UNIT_PET")
PlayerXP:RegisterEvent("PLAYER_LEVEL_UP")
PlayerXP:SetScript(
	"OnEvent",
	function(self, event, arg1)
		if event == "PLAYER_LEVEL_UP" or event == "PLAYER_ENTERING_WORLD" then
			C_Timer.After(
				3,
				function()
					MaxXP = UnitXPMax("player")
					UpdateBar()
				end
			)
		else
			UpdateBar()
		end
	end
)
