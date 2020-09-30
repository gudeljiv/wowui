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
txtotal.text:SetPoint("RIGHT", tx, "RIGHT", -5, -1)
txtotal.text:SetText("T: 0")
txtotal.text:SetTextColor(color.r, color.g, color.b, 1)

local txpulltotal = CreateFrame("Frame", "TotalPullXPText", tx)
txpulltotal:SetPoint("CENTER", tx, "CENTER", 0, 0)
txpulltotal:SetWidth(1)
txpulltotal:SetHeight(1)
txpulltotal.text = txpulltotal:CreateFontString(nil, "ARTWORK")
txpulltotal.text:SetFont(xVermin.Config.font.arial, 9, "NONE")
txpulltotal.text:SetPoint("LEFT", tx, "LEFT", 5, -1)
txpulltotal.text:SetText("P: 0")
txpulltotal.text:SetTextColor(color.r, color.g, color.b, 1)

tx:SetScript(
	"OnMouseDown",
	function(self, button)
		if button == "LeftButton" then
			totalxp = 0
			pulltotal = 0
			txtotal.text:SetText("T: " .. totalxp)
			txpulltotal.text:SetText("P: " .. pulltotal)
		end
		if button == "RightButton" then
			xVermin:Debug()
		end
	end
)

local function CalculateTotal(event, isInitialLogin, isReloadingUi)
	if event == "PLAYER_REGEN_DISABLED" then
		pulltotal = 0
	end
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
		pulltotal = pulltotal + gained
		txtotal.text:SetText("T: " .. totalxp)
		txpulltotal.text:SetText("P: " .. pulltotal)

		xVermin:LogBreak(false, "txp")
		xVermin:Log("Gained XP: " .. gained .. ", Total XP: " .. totalxp, "txp")

		currentxp = newxp
	end
end

tx:RegisterEvent("PLAYER_XP_UPDATE")
tx:RegisterEvent("PLAYER_LEVEL_UP")
tx:RegisterEvent("PLAYER_ENTERING_WORLD")
tx:RegisterEvent("PLAYER_REGEN_DISABLED")
tx:SetScript(
	"OnEvent",
	function(self, event, isInitialLogin, isReloadingUi)
		if UnitLevel("player") == MAX_PLAYER_LEVEL_TABLE[GetExpansionLevel()] then
			tx:Hide()
		else
			tx:Show()
			CalculateTotal(event, isInitialLogin, isReloadingUi)
		end
	end
)
