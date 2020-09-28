local _, xVermin = ...

local totalxp, gained = 0
local maxxp, currentxp, tolevel

local _, class, _ = UnitClass("player")
local color = RAID_CLASS_COLORS[class]
if class == "SHAMAN" then
	color = {
		b = 0.86666476726532,
		g = 0.4392147064209,
		r = 0
	}
end

cc = CreateFrame("Frame", "CustomContainer", UIParent)
cc:SetWidth(110)
cc:SetHeight(20)
cc:SetPoint("TOP", "CustomContainer_Combat", "BOTTOM", 0, -15)

tx = CreateFrame("Frame", "TotalXP", cc)
tx:SetWidth(110)
tx:SetHeight(20)
tx:SetPoint("LEFT", cc, "LEFT", 0, 0)

tx:SetBackdrop(
	{
		bgFile = xVermin.Config.background.white,
		edgeFile = "",
		tile = false,
		tileSize = 0,
		edgeSize = 0,
		insets = {left = 0, right = 0, top = 0, bottom = 0}
	}
)
tx:SetBackdropColor(0, 0, 0, 0.4)
tx:SetFrameStrata("BACKGROUND")
tx:CreateBeautyBorder(6)

local txtotal = CreateFrame("Frame", "TotalXPText", tx)
txtotal:SetPoint("CENTER", tx, "CENTER", 0, 0)
txtotal:SetWidth(1)
txtotal:SetHeight(1)
txtotal.text = txtotal:CreateFontString(nil, "ARTWORK")
txtotal.text:SetFont(xVermin.Config.font.arial, 9, "NONE")
txtotal.text:SetPoint("CENTER", tx, "CENTER", 0, -1)
txtotal.text:SetText("0 (XP)")
txtotal.text:SetTextColor(color.r, color.g, color.b, 1)

tx:SetScript(
	"OnMouseDown",
	function(self, button)
		if button == "LeftButton" then
			totalxp = 0
			txtotal.text:SetText(totalxp .. " (XP)")
		end
		if button == "RightButton" then
			xVermin:Debug()
		end
	end
)

local function Calculate(event, isInitialLogin, isReloadingUi)
	if event == "PLAYER_ENTERING_WORLD" and (isInitialLogin or isReloadingUi) then
		maxxp = UnitXPMax("player")
		currentxp = UnitXP("player")
	else
		newxp = UnitXP("player")
		if event == "PLAYER_LEVEL_UP" then
			gained = maxxp - currentxp + newxp
			maxxp = UnitXPMax("player")
		else
			gained = newxp - currentxp
		end
		totalxp = totalxp + gained
		txtotal.text:SetText(totalxp .. " (XP)")

		xVermin:LogBreak(false, "txp")
		xVermin:Log("Gained XP: " .. gained .. ", Total XP: " .. totalxp, "txp")

		currentxp = newxp
	end
end

tx:RegisterEvent("PLAYER_XP_UPDATE")
tx:RegisterEvent("PLAYER_LEVEL_UP")
tx:RegisterEvent("PLAYER_ENTERING_WORLD")
tx:SetScript(
	"OnEvent",
	function(self, event, isInitialLogin, isReloadingUi)
		if UnitLevel("player") == MAX_PLAYER_LEVEL_TABLE[GetExpansionLevel()] then
			tx:Hide()
		else
			tx:Show()
			Calculate(event, isInitialLogin, isReloadingUi)
		end
	end
)

-- local f = CreateFrame("Frame")
-- f:RegisterEvent("PLAYER_REGEN_DISABLED")
-- f:RegisterEvent("PLAYER_REGEN_ENABLED")
-- f:SetScript(
-- 	"OnEvent",
-- 	function(self, event, ...)
-- 		if event == "PLAYER_REGEN_DISABLED" then
-- 			-- cc_combat:SetBackdropColor(color.r, color.g, color.b, 0.8)
-- 			cc_combat:SetBeautyBorderTexture("Interface\\AddOns\\xVermin\\Media\\textureWhite")
-- 			cc_combat:SetBeautyBorderColor(color.r, color.g, color.b, 1)
-- 		end
-- 		if event == "PLAYER_REGEN_ENABLED" then
-- 			cc_combat:SetBeautyBorderTexture("Interface\\AddOns\\xVermin\\Media\\textureNormal")
-- 			cc_combat:SetBeautyBorderColor(1, 1, 1, 1)
-- 		-- cc_combat:SetBackdropColor(0, 0, 0, 0.4)
-- 		end
-- 	end
-- )

-- local PlayerXP = CreateFrame("Frame", "PlayerXPFrame", UIParent)
-- PlayerXP:SetScale(scale)
-- PlayerXP:SetSize(size, 18)
-- PlayerXP:SetPoint("BOTTOMLEFT", ChatFrame1, "BOTTOMRIGHT", 5, 0)
-- PlayerXP:EnableMouse(false)

-- PlayerXP.XPbar = CreateFrame("StatusBar", "PlayerXPFrameStatusBar", UIParent)
-- PlayerXP.XPbar:SetScale(1)
-- PlayerXP.XPbar:SetSize(size * scale, 3)
-- PlayerXP.XPbar:SetPoint("CENTER", PlayerXP, 0, 0)
-- PlayerXP.XPbar:SetStatusBarTexture("Interface\\AddOns\\xVermin\\Media\\statusbarTexture")
-- PlayerXP.XPbar:SetAlpha(0)

-- PlayerXP.XPbar.Value = PlayerXP.XPbar:CreateFontString(nil, "ARTWORK")
-- PlayerXP.XPbar.Value:SetFont("Fonts\\ARIALN.ttf", 14, "THINOUTLINE")
-- PlayerXP.XPbar.Value:SetShadowOffset(0, 0)
-- PlayerXP.XPbar.Value:SetPoint("LEFT", PlayerXP.XPbar, "LEFT", 2, 0)
-- PlayerXP.XPbar.Value:SetVertexColor(1, 1, 1)

-- PlayerXP.XPbar.Percent = PlayerXP.XPbar:CreateFontString(nil, "ARTWORK")
-- PlayerXP.XPbar.Percent:SetFont("Fonts\\ARIALN.ttf", 18, "THINOUTLINE")
-- PlayerXP.XPbar.Percent:SetShadowOffset(0, 0)
-- PlayerXP.XPbar.Percent:SetPoint("CENTER", PlayerXP.XPbar, 0, 0)
-- PlayerXP.XPbar.Percent:SetVertexColor(1, 1, 1)

-- PlayerXP.XPbar.Rested = PlayerXP.XPbar:CreateFontString(nil, "ARTWORK")
-- PlayerXP.XPbar.Rested:SetFont("Fonts\\ARIALN.ttf", 14, "THINOUTLINE")
-- PlayerXP.XPbar.Rested:SetShadowOffset(0, 0)
-- PlayerXP.XPbar.Rested:SetPoint("RIGHT", PlayerXP.XPbar, "RIGHT", -2, 5)
-- PlayerXP.XPbar.Rested:SetVertexColor(1, 1, 1)

-- PlayerXP.XPbar.RestedNumber = PlayerXP.XPbar:CreateFontString(nil, "ARTWORK")
-- PlayerXP.XPbar.RestedNumber:SetFont("Fonts\\ARIALN.ttf", 10, "THINOUTLINE")
-- PlayerXP.XPbar.RestedNumber:SetShadowOffset(0, 0)
-- PlayerXP.XPbar.RestedNumber:SetPoint("CENTER", PlayerXP.XPbar.Rested, 0, -10)
-- PlayerXP.XPbar.RestedNumber:SetVertexColor(1, 1, 1)

-- PlayerXP.XPbar.Background = PlayerXP.XPbar:CreateTexture(nil, "BACKGROUND")
-- PlayerXP.XPbar.Background:SetAllPoints(PlayerXP.XPbar)
-- PlayerXP.XPbar.Background:SetTexture("Interface\\AddOns\\xVermin\\Media\\statusbarTexture")
-- PlayerXP.XPbar.Background:SetVertexColor(0.25, 0.25, 0.25, 1)

-- PlayerXP.XPbar.BackgroundShadow = CreateFrame("Frame", nil, PlayerXP.XPbar)
-- PlayerXP.XPbar.BackgroundShadow:SetFrameStrata("BACKGROUND")
-- PlayerXP.XPbar.BackgroundShadow:SetPoint("TOPLEFT", -4, 4)
-- PlayerXP.XPbar.BackgroundShadow:SetPoint("BOTTOMRIGHT", 4, -4)
-- PlayerXP.XPbar.BackgroundShadow:SetBackdrop(
-- 	{
-- 		BgFile = "Interface\\ChatFrame\\ChatFrameBackground",
-- 		edgeFile = "Interface\\AddOns\\xVermin\\Media\\textureGlow",
-- 		edgeSize = 4,
-- 		insets = {left = 3, right = 3, top = 3, bottom = 3}
-- 	}
-- )
-- PlayerXP.XPbar.BackgroundShadow:SetBackdropColor(0.15, 0.15, 0.15, 1)
-- PlayerXP.XPbar.BackgroundShadow:SetBackdropBorderColor(0, 0, 0)

-- PlayerXP.XPbar.Below = PlayerXP.XPbar:CreateTexture(nil, "BACKGROUND")
-- PlayerXP.XPbar.Below:SetHeight(14)
-- PlayerXP.XPbar.Below:SetWidth(14)
-- PlayerXP.XPbar.Below:SetTexture("Interface\\AddOns\\xVermin\\Media\\textureArrowBelow")

-- PlayerXP.XPbar.Above = PlayerXP.XPbar:CreateTexture(nil, "BACKGROUND")
-- PlayerXP.XPbar.Above:SetHeight(14)
-- PlayerXP.XPbar.Above:SetWidth(14)
-- PlayerXP.XPbar.Above:SetTexture("Interface\\AddOns\\xVermin\\Media\\textureArrowAbove")
-- PlayerXP.XPbar.Above:SetPoint("BOTTOM", PlayerXP.XPbar.Below, "TOP", 0, PlayerXP.XPbar:GetHeight())

-- local function UpdateBarVisibility()
-- 	if UnitLevel("player") < MAX_PLAYER_LEVEL_TABLE[GetExpansionLevel()] then
-- 		PlayerXP.XPbar:SetAlpha(0.8)
-- 	else
-- 		PlayerXP.XPbar:SetAlpha(0)
-- 	end
-- end

-- local function UpdateBarValueAndColor(self, event)
-- 	if UnitLevel("player") < MAX_PLAYER_LEVEL_TABLE[GetExpansionLevel()] then
-- 		CurrentXP = UnitXP("player")
-- 		MaxXP = UnitXPMax("player")
-- 		percent = floor((CurrentXP / MaxXP) * 100)
-- 		_, _, rested = GetRestState()
-- 		r, g, b = xVermin:ColorGradient(percent / 100, 1, 0, 0, 1, 1, 0, 0, 1, 0)
-- 		PlayerXP.XPbar:SetMinMaxValues(0, MaxXP)
-- 		PlayerXP.XPbar:SetValue(CurrentXP)
-- 		PlayerXP.XPbar.Value:SetText(xVermin:FormatNumber(CurrentXP, ","))
-- 		PlayerXP.XPbar.Percent:SetText(xVermin:Round(percent) .. "%")
-- 		PlayerXP.XPbar.Rested:SetText(rested == 2 and "R" or "")
-- 		PlayerXP.XPbar.RestedNumber:SetText(rested == 2 and GetXPExhaustion() or "")
-- 		PlayerXP.XPbar:SetStatusBarColor(r, g, b)
-- 	end
-- end

-- local function UpdateBar()
-- 	UpdateBarVisibility()
-- 	UpdateBarValueAndColor()
-- end

-- PlayerXP:RegisterEvent("PLAYER_XP_UPDATE")
-- PlayerXP:RegisterEvent("PLAYER_ENTERING_WORLD")
-- PlayerXP:RegisterEvent("PLAYER_LEVEL_UP")
-- PlayerXP:SetScript(
-- 	"OnEvent",
-- 	function(self, event, isInitialLogin, isReloadingUi)
-- 		if event == "PLAYER_LEVEL_UP" or (event == "PLAYER_ENTERING_WORLD" and (isInitialLogin or isReloadingUi)) then
-- 			C_Timer.After(
-- 				1,
-- 				function()
-- 					UpdateBar()
-- 				end
-- 			)
-- 		end
-- 		if event == "PLAYER_XP_UPDATE" then
-- 			UpdateBar()
-- 		end
-- 	end
-- )
