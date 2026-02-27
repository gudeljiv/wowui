local _, xVermin = ...

GameTimeFrame:Hide()

WorldMapFrame:HookScript("OnShow", function(self)
	WorldMapFrame:SetFrameStrata("HIGH")
end)

xVermin.CheckIfLoadedWithTimer("TimeManagerClockButton", function()
	TimeManagerClockButton:SetFrameStrata("HIGH")
	TimeManagerClockButton:SetScale(1)
	TimeManagerClockTicker:SetScale(0.85)
	TimeManagerClockTicker:ClearAllPoints()
	TimeManagerClockTicker:SetPoint("CENTER", TimeManagerClockButton, "CENTER", 0, 0)
end)

xVermin.CheckIfLoadedWithTimer("CustomContainer_Combat", function()
	FramerateLabel:SetScale(0.8)
	FramerateText:SetScale(0.8)
	FramerateLabel:ClearAllPoints()
	FramerateLabel:SetPoint("TOP", CustomContainer_Combat, "TOP", -15, -22)
end)

CharacterRangedSlotCount:SetScale(0.75)

_G.ShowTotemBars = false
xVermin.CheckIfLoadedWithTimer("XiTimers_Timer1", function()
	local tta = {
		"TT_ActionButton11",
		"TT_ActionButton21",
		"TT_ActionButton31",
		"TT_ActionButton41",
		"TT_ActionButton12",
		"TT_ActionButton22",
		"TT_ActionButton32",
		"TT_ActionButton42",
		"TT_ActionButton13",
		"TT_ActionButton23",
		"TT_ActionButton33",
		"TT_ActionButton43",
		"TT_ActionButton14",
		"TT_ActionButton24",
		"TT_ActionButton34",
		"TT_ActionButton44",
		"TT_ActionButton15",
		"TT_ActionButton25",
		"TT_ActionButton35",
		"TT_ActionButton45",
		"TT_ActionButton16",
		"TT_ActionButton26",
		"TT_ActionButton36",
		"TT_ActionButton46",
		"TT_ActionButton17",
		"TT_ActionButton27",
		"TT_ActionButton37",
		"TT_ActionButton47",
		"TT_ActionButton18",
		"TT_ActionButton28",
		"TT_ActionButton38",
		"TT_ActionButton48",
		"TT_ActionButton19",
		"TT_ActionButton29",
		"TT_ActionButton39",
		"TT_ActionButton49",
	}
	for _, timerName in ipairs(tta) do
		if not _G[timerName] then
			return false
		end

		_G[timerName]:HookScript("OnShow", function(self)
			_G.ShowTotemBars = true
		end)

		_G[timerName]:HookScript("OnHide", function(self)
			_G.ShowTotemBars = false
		end)
	end

	local xt = {
		"XiTimers_Timer1",
		"XiTimers_Timer2",
		"XiTimers_Timer3",
		"XiTimers_Timer4",
	}
	for _, timerName in ipairs(xt) do
		if not _G[timerName] then
			return false
		end

		_G[timerName]:HookScript("OnEnter", function(self)
			_G.ShowTotemBars = true
		end)

		_G[timerName]:HookScript("OnLeave", function(self)
			_G.ShowTotemBars = false
		end)
	end
end)

-- Auto-fill mail recipient
local f = CreateFrame("Frame")
f:RegisterEvent("MAIL_SHOW")
f:SetScript("OnEvent", function()
	SendMailNameEditBox:SetText("Dopecure")
end)

-- Move the auction progress frame
local function SetupAuctionFrame()
	if AuctionProgressFrame then
		AuctionProgressFrame:HookScript("OnShow", function(self)
			self:ClearAllPoints()
			self:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 150)
		end)
	end
end

-- Move the inspect frame gearscore/ilvl text
local function SetupInspectFrame()
	if InspectFrame then
		InspectFrame:HookScript("OnShow", function()
			if InspectGearScoreText then
				InspectGearScoreText:ClearAllPoints()
				InspectGearScoreText:SetPoint("BOTTOMLEFT", InspectFrame, "BOTTOMLEFT", 70, 70)
			end
			if InspectGearScore and InspectGearScoreText then
				InspectGearScore:ClearAllPoints()
				InspectGearScore:SetPoint("LEFT", InspectGearScoreText, "LEFT", 53, 0)
			end
			if InspectAvgItemLvlText then
				InspectAvgItemLvlText:ClearAllPoints()
				InspectAvgItemLvlText:SetPoint("BOTTOMLEFT", InspectFrame, "BOTTOMLEFT", 70, 90)
			end
			if InspectAvgItemLvl and InspectAvgItemLvlText then
				InspectAvgItemLvl:ClearAllPoints()
				InspectAvgItemLvl:SetPoint("LEFT", InspectAvgItemLvlText, "LEFT", 20, 0)
			end
		end)
	end
end

local addonSetup = {
	Blizzard_InspectUI = SetupInspectFrame,
	Blizzard_AuctionUI = SetupAuctionFrame,
}

local pending = {}
for addon, func in pairs(addonSetup) do
	if C_AddOns.IsAddOnLoaded(addon) then
		func()
	else
		pending[addon] = func
	end
end

if next(pending) then
	local f = CreateFrame("Frame")
	f:RegisterEvent("ADDON_LOADED")
	f:SetScript("OnEvent", function(self, event, addon)
		if pending[addon] then
			pending[addon]()
			pending[addon] = nil
			if not next(pending) then
				self:UnregisterEvent("ADDON_LOADED")
			end
		end
	end)
end
