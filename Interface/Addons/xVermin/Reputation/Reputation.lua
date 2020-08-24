local _, xVermin = ...

local size = 125
local scale = 1.4

local Reputation = CreateFrame("Frame", "ReputationFrame", UIParent)
Reputation:SetScale(scale)
Reputation:SetSize(size, 18)
Reputation:SetPoint("BOTTOMLEFT", ChatFrame1, "BOTTOMRIGHT", 5, 15)
Reputation:EnableMouse(false)

Reputation.Bar = CreateFrame("StatusBar", "ReputationFrameStatusBar", UIParent)
Reputation.Bar:SetScale(1)
Reputation.Bar:SetSize(size * scale, 3)
Reputation.Bar:SetPoint("CENTER", Reputation, 0, -23)
Reputation.Bar:SetStatusBarTexture("Interface\\AddOns\\xVermin\\Media\\statusbarTexture")
Reputation.Bar:SetAlpha(0)

Reputation.Bar.Value = Reputation.Bar:CreateFontString(nil, "ARTWORK")
Reputation.Bar.Value:SetFont("Fonts\\ARIALN.ttf", 14, "THINOUTLINE")
Reputation.Bar.Value:SetShadowOffset(0, 0)
Reputation.Bar.Value:SetPoint("LEFT", Reputation.Bar, "LEFT", 2, 0)
Reputation.Bar.Value:SetVertexColor(1, 1, 1)

Reputation.Bar.Percent = Reputation.Bar:CreateFontString(nil, "ARTWORK")
Reputation.Bar.Percent:SetFont("Fonts\\ARIALN.ttf", 18, "THINOUTLINE")
Reputation.Bar.Percent:SetShadowOffset(0, 0)
Reputation.Bar.Percent:SetPoint("CENTER", Reputation.Bar, 0, 0)
Reputation.Bar.Percent:SetVertexColor(1, 1, 1)

Reputation.Bar.Background = Reputation.Bar:CreateTexture(nil, "BACKGROUND")
Reputation.Bar.Background:SetAllPoints(Reputation.Bar)
Reputation.Bar.Background:SetTexture("Interface\\AddOns\\xVermin\\Media\\statusbarTexture")
Reputation.Bar.Background:SetVertexColor(0.25, 0.25, 0.25, 1)

Reputation.Bar.BackgroundShadow = CreateFrame("Frame", nil, Reputation.Bar)
Reputation.Bar.BackgroundShadow:SetFrameStrata("BACKGROUND")
Reputation.Bar.BackgroundShadow:SetPoint("TOPLEFT", -4, 4)
Reputation.Bar.BackgroundShadow:SetPoint("BOTTOMRIGHT", 4, -4)
Reputation.Bar.BackgroundShadow:SetBackdrop(
	{
		BgFile = "Interface\\ChatFrame\\ChatFrameBackground",
		edgeFile = "Interface\\AddOns\\xVermin\\Media\\textureGlow",
		edgeSize = 4,
		insets = {left = 3, right = 3, top = 3, bottom = 3}
	}
)
Reputation.Bar.BackgroundShadow:SetBackdropColor(0.15, 0.15, 0.15, 1)
Reputation.Bar.BackgroundShadow:SetBackdropBorderColor(0, 0, 0)

Reputation.Bar.Below = Reputation.Bar:CreateTexture(nil, "BACKGROUND")
Reputation.Bar.Below:SetHeight(14)
Reputation.Bar.Below:SetWidth(14)
Reputation.Bar.Below:SetTexture("Interface\\AddOns\\xVermin\\Media\\textureArrowBelow")

Reputation.Bar.Above = Reputation.Bar:CreateTexture(nil, "BACKGROUND")
Reputation.Bar.Above:SetHeight(14)
Reputation.Bar.Above:SetWidth(14)
Reputation.Bar.Above:SetTexture("Interface\\AddOns\\xVermin\\Media\\textureArrowAbove")
Reputation.Bar.Above:SetPoint("BOTTOM", Reputation.Bar.Below, "TOP", 0, Reputation.Bar:GetHeight())

local function UpdateBarVisibility()
	if UnitLevel("player") < MAX_PLAYER_LEVEL_TABLE[GetExpansionLevel()] then
		Reputation.Bar:SetAlpha(0.8)
	else
		Reputation.Bar:SetAlpha(0)
	end
end

local function UpdateBarValueAndColor(self, event)
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

local function UpdateBar()
	for factionIndex = 1, GetNumFactions() do
		name, description, standingId, bottomValue, topValue, earnedValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild = GetFactionInfo(factionIndex)
		if isHeader == nil then
			DEFAULT_CHAT_FRAME:AddMessage("Faction: " .. name .. " - " .. earnedValue)
		end
	end

	local factionIndex = 1
	local lastFactionName
	repeat
		local name, description, standingId, bottomValue, topValue, earnedValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild = GetFactionInfo(factionIndex)
		if name == lastFactionName then
			break
		end
		lastFactionName = name
		DEFAULT_CHAT_FRAME:AddMessage("Faction: " .. lastFactionName .. " - " .. earnedValue)
		factionIndex = factionIndex + 1
	until factionIndex > 200
	-- UpdateBarVisibility()
	-- UpdateBarValueAndColor()
end

Reputation:RegisterEvent("PLAYER_XP_UPDATE")
Reputation:RegisterEvent("PLAYER_ENTERING_WORLD")
Reputation:RegisterEvent("PLAYER_LEVEL_UP")
Reputation:SetScript(
	"OnEvent",
	function(self, event, isInitialLogin, isReloadingUi)
		if event == "PLAYER_LEVEL_UP" or (event == "PLAYER_ENTERING_WORLD" and (isInitialLogin or isReloadingUi)) then
			C_Timer.After(
				1,
				function()
					UpdateBar()
				end
			)
		end
		if event == "PLAYER_XP_UPDATE" then
			UpdateBar()
		end
	end
)
