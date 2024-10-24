local ComboColor = nPower.energy.comboColor
local playerClass = select(2, UnitClass("player"))

local f = CreateFrame("Frame", "nPower", UIParent, BackdropTemplateMixin and "BackdropTemplate")
f:SetScale(1.4)
f:SetSize(18, 18)
f:SetPoint(unpack(nPower.position))
f:EnableMouse(false)

f:RegisterEvent("PLAYER_REGEN_ENABLED")
f:RegisterEvent("PLAYER_REGEN_DISABLED")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
--f:RegisterEvent('UNIT_COMBO_POINTS')
f:RegisterEvent("UNIT_POWER_UPDATE")
f:RegisterEvent("PLAYER_TARGET_CHANGED")

-- f:RegisterEvent('UNIT_DISPLAYPOWER')
-- f:RegisterEvent('UNIT_POWER')
-- f:RegisterEvent('UPDATE_SHAPESHIFT_FORM')

if (nPower.energy.showComboPoints) then
	f.ComboPoints = {}
	for i = 1, 5 do
		f.ComboPoints[i] = f:CreateFontString(nil, "ARTWORK")
		if (nPower.energy.comboFontOutline) then
			f.ComboPoints[i]:SetFont(nPower.energy.comboFont, nPower.energy.comboFontSize, "THINOUTLINE")
			f.ComboPoints[i]:SetShadowOffset(0, 0)
		else
			f.ComboPoints[i]:SetFont(nPower.energy.comboFont, nPower.energy.comboFontSize)
			f.ComboPoints[i]:SetShadowOffset(1, -1)
		end

		f.ComboPoints[i]:SetParent(f)
		f.ComboPoints[i]:SetText(i)
		f.ComboPoints[i]:SetAlpha(0)
	end

	f.ComboPoints[1]:SetPoint("CENTER", -52, 0)
	f.ComboPoints[2]:SetPoint("CENTER", -26, 0)
	f.ComboPoints[3]:SetPoint("CENTER", 0, 0)
	f.ComboPoints[4]:SetPoint("CENTER", 26, 0)
	f.ComboPoints[5]:SetPoint("CENTER", 52, 0)
end

if (playerClass == "WARLOCK" and nPower.showSoulshards or playerClass == "PALADIN" and nPower.showHolypower) then
	f.extraPoints = f:CreateFontString(nil, "ARTWORK")

	if (nPower.extraFontOutline) then
		f.extraPoints:SetFont(nPower.extraFont, nPower.extraFontSize, "THINOUTLINE")
		f.extraPoints:SetShadowOffset(0, 0)
	else
		f.extraPoints:SetFont(nPower.extraFont, nPower.extraFontSize)
		f.extraPoints:SetShadowOffset(1, -1)
	end

	f.extraPoints:SetParent(f)
	f.extraPoints:SetPoint("CENTER", 0, 0)
end

f.Power = CreateFrame("StatusBar", "nPowerStatusBar", UIParent, BackdropTemplateMixin and "BackdropTemplate")
f.Power:SetScale(nPower.scale)
f.Power:SetSize(nPower.sizeWidth, 3)
f.Power:SetPoint("CENTER", f, 0, -23)
f.Power:SetStatusBarTexture("Interface\\AddOns\\nPower\\media\\statusbarTexture")
f.Power:SetAlpha(1)

f.Power.Value = f.Power:CreateFontString(nil, "ARTWORK")

if (nPower.valueFontOutline) then
	f.Power.Value:SetFont(nPower.valueFont, nPower.valueFontSize, "THINOUTLINE")
	f.Power.Value:SetShadowOffset(0, 0)
else
	f.Power.Value:SetFont(nPower.valueFont, nPower.valueFontSize)
	f.Power.Value:SetShadowOffset(1, -1)
end

f.Power.Value:SetPoint("CENTER", f.Power, 0, nPower.valueFontAdjustmentX)
f.Power.Value:SetVertexColor(1, 1, 1)

f.Power.Background = f.Power:CreateTexture(nil, "BACKGROUND")
f.Power.Background:SetAllPoints(f.Power)
f.Power.Background:SetTexture("Interface\\AddOns\\nPower\\media\\statusbarTexture")
f.Power.Background:SetVertexColor(0.25, 0.25, 0.25, 1)

f.Power.BackgroundShadow = CreateFrame("Frame", nil, f.Power, BackdropTemplateMixin and "BackdropTemplate")
f.Power.BackgroundShadow:SetFrameStrata("BACKGROUND")
f.Power.BackgroundShadow:SetPoint("TOPLEFT", -4, 4)
f.Power.BackgroundShadow:SetPoint("BOTTOMRIGHT", 4, -4)
f.Power.BackgroundShadow:SetBackdrop(
	{
		BgFile = "Interface\\ChatFrame\\ChatFrameBackground",
		edgeFile = "Interface\\Addons\\nPower\\media\\textureGlow",
		edgeSize = 4,
		insets = {left = 3, right = 3, top = 3, bottom = 3}
	}
)
f.Power.BackgroundShadow:SetBackdropColor(0.15, 0.15, 0.15, 1)
f.Power.BackgroundShadow:SetBackdropBorderColor(0, 0, 0)

f.Power.Below = f.Power:CreateTexture(nil, "BACKGROUND")
f.Power.Below:SetHeight(14)
f.Power.Below:SetWidth(14)
f.Power.Below:SetTexture("Interface\\AddOns\\nPower\\media\\textureArrowBelow")

f.Power.Above = f.Power:CreateTexture(nil, "BACKGROUND")
f.Power.Above:SetHeight(14)
f.Power.Above:SetWidth(14)
f.Power.Above:SetTexture("Interface\\AddOns\\nPower\\media\\textureArrowAbove")
f.Power.Above:SetPoint("BOTTOM", f.Power.Below, "TOP", 0, f.Power:GetHeight())

if (nPower.showCombatRegen) then
	f.mpreg = f.Power:CreateFontString(nil, "ARTWORK")
	f.mpreg:SetFont(nPower.valueFont, 12, "THINOUTLINE")
	f.mpreg:SetShadowOffset(0, 0)
	f.mpreg:SetPoint("TOP", f.Power.Below, "BOTTOM", 0, 4)
	f.mpreg:SetParent(f.Power)
	f.mpreg:Show()
end

local function FormatValue(self)
	if (self >= 10000) then
		return ("%.1fk"):format(self / 1e3)
	else
		return self
	end
end

local function GetRealMpFive()
	local _, activeRegen = GetPowerRegen()
	local realRegen = activeRegen * 5
	local _, powerType = UnitPowerType("player")

	if (powerType == "MANA") then
		return math.floor(realRegen)
	else
		return ""
	end
end

local function SetComboColor(i)
	local comboPoints = GetComboPoints("player", "target") or 0

	if (i > comboPoints or UnitIsDeadOrGhost("target")) then
		return 1, 1, 1
	else
		return ComboColor[i].r, ComboColor[i].g, ComboColor[i].b
	end
end

local function SetComboAlpha(i)
	local comboPoints = GetComboPoints("player", "target") or 0

	if (i == comboPoints) then
		return 1
	else
		return 0
	end
end

local function UpdateBarVisibility()
	local _, powerType = UnitPowerType("player")

	if ((not nPower.energy.show and powerType == "ENERGY") or (not nPower.focus.show and powerType == "FOCUS") or (not nPower.rage.show and powerType == "RAGE") or (not nPower.mana.show and powerType == "MANA") or UnitIsDeadOrGhost("player")) then
		f.Power:SetAlpha(0)
	elseif (InCombatLockdown()) then
		securecall("UIFrameFadeIn", f.Power, 0.3, f.Power:GetAlpha(), nPower.activeAlpha)
	elseif (not InCombatLockdown() and UnitPower("player") > 0) then
		securecall("UIFrameFadeOut", f.Power, 0.3, f.Power:GetAlpha(), nPower.inactiveAlpha)
	else
		securecall("UIFrameFadeOut", f.Power, 0.3, f.Power:GetAlpha(), nPower.emptyAlpha)
	end
end

local function UpdateArrow()
	if (UnitPower("player") == 0) then
		f.Power.Below:SetAlpha(0.3)
		f.Power.Above:SetAlpha(0.3)
	else
		f.Power.Below:SetAlpha(1)
		f.Power.Above:SetAlpha(1)
	end

	local newPosition = UnitPower("player") / UnitPowerMax("player") * f.Power:GetWidth()
	f.Power.Below:SetPoint("TOP", f.Power, "BOTTOMLEFT", newPosition, 0)
end

local function UpdateBarValue()
	local min = UnitPower("player")
	--f.Power:SetMinMaxValues(0, UnitPowerMax('player', f))
	f.Power:SetMinMaxValues(0, UnitPowerMax("player"))
	f.Power:SetValue(min)

	if (nPower.valueAbbrev) then
		f.Power.Value:SetText(min > 0 and FormatValue(min) or "")
	else
		f.Power.Value:SetText(min > 0 and min or "")
	end
end

local function UpdateBarColor()
	local _, powerType, altR, altG, altB = UnitPowerType("player")
	local unitPower = PowerBarColor[powerType]

	if (unitPower) then
		f.Power:SetStatusBarColor(unitPower.r, unitPower.g, unitPower.b)
	else
		f.Power:SetStatusBarColor(altR, altG, altB)
	end
end

local function UpdateBar()
	UpdateBarColor()
	UpdateBarValue()
	UpdateArrow()
end

f:SetScript(
	"OnEvent",
	function(self, event, arg1)
		if (f.ComboPoints) then
			if (event == "UNIT_POWER_UPDATE" or event == "PLAYER_TARGET_CHANGED") then
				for i = 1, 5 do
					f.ComboPoints[i]:SetTextColor(SetComboColor(i))
					f.ComboPoints[i]:SetAlpha(SetComboAlpha(i))
				end
			end
		end

		if (event == "PLAYER_ENTERING_WORLD") then
			if (InCombatLockdown()) then
				securecall("UIFrameFadeIn", f, 0.35, f:GetAlpha(), 1)
			else
				securecall("UIFrameFadeOut", f, 0.35, f:GetAlpha(), nPower.inactiveAlpha)
			end
		end

		if (event == "PLAYER_REGEN_DISABLED") then
			securecall("UIFrameFadeIn", f, 0.35, f:GetAlpha(), 1)
		end

		if (event == "PLAYER_REGEN_ENABLED") then
			securecall("UIFrameFadeOut", f, 0.35, f:GetAlpha(), nPower.inactiveAlpha)
		end
	end
)

local updateTimer = 0
f:SetScript(
	"OnUpdate",
	function(self, elapsed)
		updateTimer = updateTimer + elapsed

		if (updateTimer > 0.1) then
			if (f.mpreg) then
				f.mpreg:SetText(GetRealMpFive())
			end

			UpdateBar()
			UpdateBarVisibility()

			updateTimer = 0
		end
	end
)
