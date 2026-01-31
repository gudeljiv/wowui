local f = CreateFrame("Frame")
f:RegisterEvent("MAIL_SHOW")
f:SetScript("OnEvent", function()
	SendMailNameEditBox:SetText("Dopecure")
end)

local function SetupAuctionFrame()
	if AuctionProgressFrame then
		AuctionProgressFrame:HookScript("OnShow", function(self)
			self:ClearAllPoints()
			self:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 150)
		end)
	end
end

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
