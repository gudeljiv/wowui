local _, xVermin = ...

local totalxp, pulltotal, gained = 0
local maxxp, currentxp, tolevel
local combatTimer = time()

cc = CreateFrame("Frame", "CustomContainer", UIParent)
cc:SetWidth(110)
cc:SetHeight(20)
cc:SetPoint("BOTTOM", UIParent, "BOTTOM", -60, 300)

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
txtotal.text:SetFont(xVermin.Config.font.arial, 10, "NONE")
txtotal.text:SetPoint("RIGHT", tx, "RIGHT", -5, -1)
txtotal.text:SetText("T: 0")
txtotal.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)

local txpulltotal = CreateFrame("Frame", "TotalPullXPText", tx)
txpulltotal:SetPoint("CENTER", tx, "CENTER", 0, 0)
txpulltotal:SetWidth(1)
txpulltotal:SetHeight(1)
txpulltotal.text = txpulltotal:CreateFontString(nil, "ARTWORK")
txpulltotal.text:SetFont(xVermin.Config.font.arial, 10, "NONE")
txpulltotal.text:SetPoint("LEFT", tx, "LEFT", 5, -1)
txpulltotal.text:SetText("P: 0")
txpulltotal.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)

tx:SetScript(
	"OnMouseDown",
	function(self, button)
		if button == "LeftButton" then
			totalxp = 0
			pulltotal = 0
			txtotal.text:SetText("T: " .. xVermin:FormatNumber(totalxp, ","))
			txpulltotal.text:SetText("P: " .. xVermin:FormatNumber(pulltotal, ","))
		end
		if button == "RightButton" then
			xVermin:Debug()
		end
	end
)

local function CalculateTotal(event, isInitialLogin, isReloadingUi)
	if event == "PLAYER_REGEN_DISABLED" then
		if time() - combatTimer > 2 then
			pulltotal = 0
			combatTimer = time()
		end
	end
	if event == "PLAYER_ENTERING_WORLD" and (isInitialLogin or isReloadingUi) then
		pulltotal = 0
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
tx:RegisterEvent("PLAYER_REGEN_ENABLED")
tx:SetScript(
	"OnEvent",
	function(self, event, isInitialLogin, isReloadingUi)
		if UnitLevel("player") == MAX_PLAYER_LEVEL_TABLE[GetExpansionLevel()] then
			tx:Hide()
		else
			if event ~= "PLAYER_REGEN_ENABLED" then
				ChatFrame6:AddMessage("TX: " .. event .. ", " .. time() - combatTimer .. "s")
				tx:Show()
				CalculateTotal(event, isInitialLogin, isReloadingUi)
			end
		end

		if event == "PLAYER_REGEN_DISABLED" then
			tx:SetBeautyBorderTexture("Interface\\AddOns\\xVermin\\Media\\textureWhite")
			tx:SetBeautyBorderColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)
		end
		if event == "PLAYER_REGEN_ENABLED" then
			tx:SetBeautyBorderTexture("Interface\\AddOns\\xVermin\\Media\\textureNormal")
			tx:SetBeautyBorderColor(1, 1, 1, 1)
		end
	end
)
