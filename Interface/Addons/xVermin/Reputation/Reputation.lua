local _, xVermin = ...

local size = 125
local scale = 1.4
local bars = {}

local function CreateBar(name, factionIndex)
	local f = CreateFrame("Frame", name, UIParent)
	f:SetScale(scale)
	f:SetSize(size, 12)
	f:SetPoint("CENTER", UIParent, "CENTER", -600, 0)
	f:EnableMouse(false)

	f.Bar = CreateFrame("StatusBar", name .. "StatusBar", UIParent)
	f.Bar:SetScale(1)
	f.Bar:SetSize(size * scale, 2)
	f.Bar:SetPoint("CENTER", f, 0, 0)
	f.Bar:SetStatusBarTexture("Interface\\AddOns\\xVermin\\Media\\statusbarTexture")
	f.Bar:SetAlpha(0)

	f.Bar.Value = f.Bar:CreateFontString(nil, "ARTWORK")
	f.Bar.Value:SetFont("Fonts\\ARIALN.ttf", 14, "THINOUTLINE")
	f.Bar.Value:SetShadowOffset(0, 0)
	f.Bar.Value:SetPoint("LEFT", f.Bar, "LEFT", 2, 0)
	f.Bar.Value:SetVertexColor(1, 1, 1)

	f.Bar.Percent = f.Bar:CreateFontString(nil, "ARTWORK")
	f.Bar.Percent:SetFont("Fonts\\ARIALN.ttf", 18, "THINOUTLINE")
	f.Bar.Percent:SetShadowOffset(0, 0)
	f.Bar.Percent:SetPoint("CENTER", f.Bar, 0, 0)
	f.Bar.Percent:SetVertexColor(1, 1, 1)

	f.Bar.Background = f.Bar:CreateTexture(nil, "BACKGROUND")
	f.Bar.Background:SetAllPoints(f.Bar)
	f.Bar.Background:SetTexture("Interface\\AddOns\\xVermin\\Media\\statusbarTexture")
	f.Bar.Background:SetVertexColor(0.25, 0.25, 0.25, 1)

	f.Bar.BackgroundShadow = CreateFrame("Frame", nil, f.Bar)
	f.Bar.BackgroundShadow:SetFrameStrata("BACKGROUND")
	f.Bar.BackgroundShadow:SetPoint("TOPLEFT", -4, 4)
	f.Bar.BackgroundShadow:SetPoint("BOTTOMRIGHT", 4, -4)
	f.Bar.BackgroundShadow:SetBackdrop(
		{
			BgFile = "Interface\\ChatFrame\\ChatFrameBackground",
			edgeFile = "Interface\\AddOns\\xVermin\\Media\\textureGlow",
			edgeSize = 4,
			insets = {left = 3, right = 3, top = 3, bottom = 3}
		}
	)
	f.Bar.BackgroundShadow:SetBackdropColor(0.15, 0.15, 0.15, 1)
	f.Bar.BackgroundShadow:SetBackdropBorderColor(0, 0, 0)

	f.Bar.Below = f.Bar:CreateTexture(nil, "BACKGROUND")
	f.Bar.Below:SetHeight(14)
	f.Bar.Below:SetWidth(14)
	f.Bar.Below:SetTexture("Interface\\AddOns\\xVermin\\Media\\textureArrowBelow")

	f.Bar.Above = f.Bar:CreateTexture(nil, "BACKGROUND")
	f.Bar.Above:SetHeight(14)
	f.Bar.Above:SetWidth(14)
	f.Bar.Above:SetTexture("Interface\\AddOns\\xVermin\\Media\\textureArrowAbove")
	f.Bar.Above:SetPoint("BOTTOM", f.Bar.Below, "TOP", 0, f.Bar:GetHeight())
end

local function UpdateBarVisibility()
	print("Update Visibility: ", table.getn(bars))

	for key, value in pairs(bars) do
		if value.hidden then
			_G[value.frameStatusBar]:SetAlpha(0)
		else
			_G[value.frameStatusBar]:SetAlpha(0.8)
		end
	end
end

local function UpdateBarValueAndColor()
	if UnitLevel("player") < MAX_PLAYER_LEVEL_TABLE[GetExpansionLevel()] then
		CurrentXP = UnitXP("player")
		MaxXP = UnitXPMax("player")
		percent = floor((CurrentXP / MaxXP) * 100)
		_, _, rested = GetRestState()
		r, g, b = xVermin:ColorGradient(percent / 100, 1, 0, 0, 1, 1, 0, 0, 1, 0)
		Reputation.Bar:SetMinMaxValues(0, MaxXP)
		Reputation.Bar:SetValue(CurrentXP)
		Reputation.Bar.Value:SetText(xVermin:FormatNumber(CurrentXP, ","))
		Reputation.Bar.Percent:SetText(xVermin:Round(percent) .. "%")
		Reputation.Bar:SetStatusBarColor(r, g, b)
	end
end

local function UpdateBars()
	local factionIndex = 1
	local lastFactionName, frameName, frameStatusBar

	repeat
		local name, description, standingId, bottomValue, topValue, earnedValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild = GetFactionInfo(factionIndex)
		if name == lastFactionName then
			break
		end
		lastFactionName = name
		frameName = "xVerminReputationBar" .. factionIndex
		frameStatusBar = "xVerminReputationBar" .. factionIndex .. "StatusBar"

		if bars[factionIndex] then
			bars[factionIndex].hidden = true
		end
		if isWatched then
			if not bars[factionIndex] then
				print("create bar: " .. frameName)
				CreateBar(frameName, factionIndex)
				bars[factionIndex] = {factionIndex = factionIndex, name = frameName, frameStatusBar = frameStatusBar, time = GetTime(), isWatched = isWatched, hidden = false}
			end
			bars[factionIndex].hidden = false
		end

		factionIndex = factionIndex + 1
	until factionIndex > 200

	UpdateBarVisibility()
	-- UpdateBarValueAndColor(event)
end

local wf = CreateFrame("Frame")
wf:RegisterEvent("UPDATE_FACTION")
wf:SetScript("OnEvent", UpdateBars)
