local ComboColor = nHealth.energy.comboColor

local f = CreateFrame("Frame", "nHealth", UIParent, BackdropTemplateMixin and "BackdropTemplate")
f:SetScale(1.4)
f:SetSize(18, 18)
f:SetPoint(unpack(nHealth.position))
f:EnableMouse(false)

f:RegisterEvent("PLAYER_REGEN_ENABLED")
f:RegisterEvent("PLAYER_REGEN_DISABLED")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
--f:RegisterEvent('UNIT_HEALTH_UPDATE')
f:RegisterEvent("PLAYER_TARGET_CHANGED")

f.Health = CreateFrame("StatusBar", "nHealthStatusBar", UIParent, BackdropTemplateMixin and "BackdropTemplate")
f.Health:SetScale(nHealth.scale)
f.Health:SetSize(nHealth.sizeWidth, 3)
f.Health:SetPoint("CENTER", f, 0, -23)
f.Health:SetStatusBarTexture("Interface\\AddOns\\nHealth\\media\\statusbarTexture")
f.Health:SetAlpha(0)

f.Health.Value = f.Health:CreateFontString(nil, "ARTWORK")

if (nHealth.valueFontOutline) then
	f.Health.Value:SetFont(nHealth.valueFont, nHealth.valueFontSize, "THINOUTLINE")
	f.Health.Value:SetShadowOffset(0, 0)
else
	f.Health.Value:SetFont(nHealth.valueFont, nHealth.valueFontSize)
	f.Health.Value:SetShadowOffset(1, -1)
end

f.Health.Value:SetPoint("CENTER", f.Health, 0, nHealth.valueFontAdjustmentX)
f.Health.Value:SetVertexColor(1, 1, 1)

f.Health.Background = f.Health:CreateTexture(nil, "BACKGROUND")
f.Health.Background:SetAllPoints(f.Health)
f.Health.Background:SetTexture("Interface\\AddOns\\nHealth\\media\\statusbarTexture")
f.Health.Background:SetVertexColor(0.25, 0.25, 0.25, 1)

f.Health.BackgroundShadow = CreateFrame("Frame", nil, f.Health, BackdropTemplateMixin and "BackdropTemplate")
f.Health.BackgroundShadow:SetFrameStrata("BACKGROUND")
f.Health.BackgroundShadow:SetPoint("TOPLEFT", -4, 4)
f.Health.BackgroundShadow:SetPoint("BOTTOMRIGHT", 4, -4)
f.Health.BackgroundShadow:SetBackdrop(
	{
		BgFile = "Interface\\ChatFrame\\ChatFrameBackground",
		edgeFile = "Interface\\Addons\\nHealth\\media\\textureGlow",
		edgeSize = 4,
		insets = {left = 3, right = 3, top = 3, bottom = 3}
	}
)
f.Health.BackgroundShadow:SetBackdropColor(0.15, 0.15, 0.15, 1)
f.Health.BackgroundShadow:SetBackdropBorderColor(0, 0, 0)

f.Health.Below = f.Health:CreateTexture(nil, "BACKGROUND")
f.Health.Below:SetHeight(14)
f.Health.Below:SetWidth(14)
f.Health.Below:SetTexture("Interface\\AddOns\\nHealth\\media\\textureArrowBelow")

f.Health.Above = f.Health:CreateTexture(nil, "BACKGROUND")
f.Health.Above:SetHeight(14)
f.Health.Above:SetWidth(14)
f.Health.Above:SetTexture("Interface\\AddOns\\nHealth\\media\\textureArrowAbove")
f.Health.Above:SetPoint("BOTTOM", f.Health.Below, "TOP", 0, f.Health:GetHeight())

local function FormatValue(self)
	if (self >= 10000) then
		return ("%.1fk"):format(self / 1e3)
	else
		return self
	end
end

local function FormatNumber(number, divider)
	if not divider then
		divider = "."
	end
	if not number then
		return 0
	else
		number = tonumber(number)
	end
	if abs(number) < 1000 then
		return number
	end
	local neg = number < 0 and "-" or ""
	local left, mid, right = tostring(abs(number)):match("^([^%d]*%d)(%d*)(.-)$")
	return ("%s%s%s%s"):format(neg, left, mid:reverse():gsub("(%d%d%d)", "%1" .. divider):reverse(), right)
end

local function UpdateBarVisibility()
	if not TargetFrame:IsShown() or UnitIsDeadOrGhost("target") then
		f.Health:SetAlpha(0.3)
	elseif (InCombatLockdown()) then
		securecall("UIFrameFadeIn", f.Health, 0.3, f.Health:GetAlpha(), nHealth.activeAlpha)
	elseif (not InCombatLockdown() and UnitHealth("target") > 0) then
		securecall("UIFrameFadeOut", f.Health, 0.3, f.Health:GetAlpha(), nHealth.inactiveAlpha)
	else
		securecall("UIFrameFadeOut", f.Health, 0.3, f.Health:GetAlpha(), nHealth.emptyAlpha)
	end
end

local function UpdateBarValue()
	if TargetFrame:IsShown() and not UnitIsDeadOrGhost("target") then
		local min, max
		if IsAddOnLoaded("RealMobHealth") then
			min, max, _, _ = RealMobHealth.GetUnitHealth("target")
		else
			min = UnitHealth("target")
			max = UnitHealthMax("target")
		end

		f.Health:SetMinMaxValues(0, max)
		f.Health:SetValue(min)

		if (nHealth.valueAbbrev) then
			f.Health.Value:SetText(( min > 0 and FormatNumber(min) or 0) .. " / " .. FormatNumber(max))
		else
			f.Health.Value:SetText((min > 0 and FormatNumber(min) or 0) .. " / " .. FormatNumber(max))
		end
	else
		f.Health.Value:SetText("")
	end
end

local function UpdateBarColor()
	if TargetFrame:IsShown() and not UnitIsDeadOrGhost("target") then
		f.Health:SetStatusBarColor(1, 0, 0)
	else
		f.Health:SetStatusBarColor(0, 0, 0, 0)
	end
end

local function UpdateBar()
	UpdateBarColor()
	UpdateBarValue()
end

f:SetScript(
	"OnEvent",
	function(self, event, arg1)
		if (event == "PLAYER_ENTERING_WORLD") then
			if (InCombatLockdown()) then
				securecall("UIFrameFadeIn", f, 0.35, f:GetAlpha(), 1)
			else
				securecall("UIFrameFadeOut", f, 0.35, f:GetAlpha(), nHealth.inactiveAlpha)
			end
		end

		if (event == "PLAYER_REGEN_DISABLED") then
			securecall("UIFrameFadeIn", f, 0.35, f:GetAlpha(), 1)
		end

		if (event == "PLAYER_REGEN_ENABLED") then
			securecall("UIFrameFadeOut", f, 0.35, f:GetAlpha(), nHealth.inactiveAlpha)
		end
	end
)

local updateTimer = 0
f:SetScript(
	"OnUpdate",
	function(self, elapsed)
		updateTimer = updateTimer + elapsed

		if (updateTimer > 0.1) then
			UpdateBar()
			UpdateBarVisibility()
			updateTimer = 0
		end
	end
)
