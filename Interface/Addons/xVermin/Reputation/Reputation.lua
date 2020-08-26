local _, xVermin = ...

local size = 125
local scale = 1.4
local bars = {}

local function CreateBar(name, factionIndex)
	local y = (factionIndex - 1) * 24

	local f = CreateFrame("Frame", name, UIParent)
	f:SetScale(scale)
	f:SetSize(size, 12)
	f:SetPoint("CENTER", UIParent, "CENTER", -600, y)
	f:EnableMouse(false)

	f.Bar = CreateFrame("StatusBar", name .. "StatusBar", UIParent)
	f.Bar:SetScale(1)
	f.Bar:SetSize(size * scale, 2)
	f.Bar:SetPoint("CENTER", f, 0, 0)
	f.Bar:SetStatusBarTexture("Interface\\AddOns\\xVermin\\Media\\statusbarTexture")
	f.Bar:SetAlpha(0.8)

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

	print("create bar: " .. name)
end

local function UpdateBarVisibility(event)
	-- print(table.getn(bars))
	-- print(event)
	for key, value in pairs(bars) do -- Tells the engine to go through all of the table and put the keys and values of the table in pairs and then do something with them.
		-- print(value.name)
		-- print("-----------------------------------------")
	end
	-- if UnitLevel("player") < MAX_PLAYER_LEVEL_TABLE[GetExpansionLevel()] then
	-- 	Reputation.Bar:SetAlpha(0.8)
	-- else
	-- 	Reputation.Bar:SetAlpha(0)
	-- end
end

local function UpdateBarValueAndColor(event)
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

local function UpdateBars(event)
	if event then
		local factionIndex = 1
		local lastFactionName
		local create_bar = true
		local frameName

		repeat
			local name, description, standingId, bottomValue, topValue, earnedValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild = GetFactionInfo(factionIndex)
			print(name, lastFactionName, factionIndex)
			if name == lastFactionName then
				break
			end
			lastFactionName = name

			if bars[factionIndex] then
				create_bar = false
			end

			frameName = "xVerminReputationBar" .. factionIndex

			if create_bar and isWatched then
				CreateBar(frameName, factionIndex)
				bars[factionIndex] = {factionIndex = factionIndex, name = frameName, time = GetTime(), isWatched = isWatched, hidden = false}
			else
				if _G[frameName .. "StatusBar"] then
					_G[frameName .. "StatusBar"]:Show()
				end
			end

			if not isWatched then
				if bars[factionIndex] then
					bars[factionIndex].hidden = "true"
				end
				if _G[frameName .. "StatusBar"] then
					_G[frameName .. "StatusBar"]:Hide()
				end
			end

			if bars[factionIndex] then
				print(bars[factionIndex].name, bars[factionIndex].hidden, bars[factionIndex].time)
			end

			factionIndex = factionIndex + 1
		until factionIndex > 200

		UpdateBarVisibility(event)
	-- UpdateBarValueAndColor(event)
	end
end

local wf = CreateFrame("Frame")
wf:RegisterEvent("UPDATE_FACTION")
wf:RegisterEvent("PLAYER_ENTERING_WORLD")
wf:SetScript(
	"OnEvent",
	function(self, event, isInitialLogin, isReloadingUi)
		-- if event == "PLAYER_ENTERING_WORLD" and (isInitialLogin or isReloadingUi) then
		-- 	C_Timer.After(
		-- 		1,
		-- 		function()
		-- 			UpdateBars(event)
		-- 		end
		-- 	)
		-- end
		if event == "UPDATE_FACTION" then
		-- UpdateBars(event)
		end
	end
)
