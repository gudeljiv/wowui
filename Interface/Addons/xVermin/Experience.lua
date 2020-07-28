--local font = "Interface\\AddOns\\xVermin\\media\\fontAtari.ttf"
local _, class, _ = UnitClass("player")
local r, g, b, nxp, hmmm, gained, num, segment, relperc, r1, r2, g1, g2, b1, b2, f, PetExpFrame, PlayerExpFrame, percent, rested, output, pcxp, pmxp, ppercent, cmtk
local cxp = UnitXP("player")
local mxp = UnitXPMax("player")

local function ColorGradient(perc, ...)
	if perc >= 1 then
		r, g, b = select(select("#", ...) - 2, ...)
		return r, g, b
	elseif perc <= 0 then
		r, g, b = ...
		return r, g, b
	end

	num = select("#", ...) / 3
	segment, relperc = math.modf(perc * (num - 1))
	r1, g1, b1, r2, g2, b2 = select((segment * 3) + 1, ...)
	return r1 + (r2 - r1) * relperc, g1 + (g2 - g1) * relperc, b1 + (b2 - b1) * relperc
end

if class == "HUNTER" then
	PetExpFrame = CreateFrame("Frame", "PetExpFrame", UIParent)
	PetExpFrame:SetWidth(1)
	PetExpFrame:SetHeight(1)
	PetExpFrame:SetAlpha(0.9)
	PetExpFrame:SetPoint("BOTTOMLEFT", ChatFrame1, "BOTTOMRIGHT", 5, 40)
	PetExpFrame.text = PetExpFrame:CreateFontString(nil, "ARTWORK")
	PetExpFrame.text:SetJustifyH("LEFT")
	PetExpFrame.text:SetJustifyV("TOP")
	PetExpFrame.text:SetFont(config.font.arial, 12)
	PetExpFrame.text:SetShadowOffset(1, -1)
	PetExpFrame.text:SetTextColor(1, 1, 1, 1)
	PetExpFrame.text:SetPoint("LEFT", PetExpFrame, "LEFT", 0, 0)
	PetExpFrame:SetFrameStrata("MEDIUM")
	PetExpFrame:Hide()
end

PlayerExpFrame = CreateFrame("Frame", "PlayerExpFrame", UIParent)
PlayerExpFrame:SetWidth(1)
PlayerExpFrame:SetHeight(1)
PlayerExpFrame:SetAlpha(0.9)
PlayerExpFrame:SetPoint("BOTTOMLEFT", ChatFrame1, "BOTTOMRIGHT", 5, 10)
PlayerExpFrame.text = PlayerExpFrame:CreateFontString(nil, "ARTWORK")
PlayerExpFrame.text:SetJustifyH("LEFT")
PlayerExpFrame.text:SetJustifyV("TOP")
PlayerExpFrame.text:SetFont(config.font.arial, 12)
PlayerExpFrame.text:SetShadowOffset(1, -1)
PlayerExpFrame.text:SetTextColor(1, 1, 1, 1)
PlayerExpFrame.text:SetPoint("LEFT", PlayerExpFrame, "LEFT", 0, 0)
PlayerExpFrame:SetFrameStrata("MEDIUM")

cmtk = CreateFrame("Frame", "CustomContainer_CombatMobsToKill", CustomContainer_Combat)
cmtk:SetPoint("CENTER", CustomContainer_Combat, "CENTER", 0, 2)
cmtk:SetWidth(10)
cmtk:SetHeight(10)
cmtk.text = cmtk:CreateFontString(nil, "ARTWORK")
cmtk.text:SetFont(config.font.arial, 10, "NONE")
cmtk.text:SetPoint("RIGHT", CustomContainer_Combat, "RIGHT", -3, 0)
cmtk:Hide()

cmxg = CreateFrame("Frame", "CustomContainer_CombatXPgained", CustomContainer_Combat)
cmxg:SetPoint("CENTER", CustomContainer_Combat, "CENTER", 0, 2)
cmxg:SetWidth(10)
cmxg:SetHeight(10)
cmxg.text = cmxg:CreateFontString(nil, "ARTWORK")
cmxg.text:SetFont(config.font.arial, 10, "NONE")
cmxg.text:SetPoint("LEFT", CustomContainer_Combat, "RIGHT", 3, 0)
cmxg:Hide()

local function UpdateExperience(self, event, isInitialLogin, isReloadingUi)
	if event == "PLAYER_ENTERING_WORLD" and (isInitialLogin or isReloadingUi) then
		cxp = UnitXP("player")
		mxp = UnitXPMax("player")
	end

	nxp = UnitXP("player")

	------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--- MOBS TO KILL -------------------------------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------------------------------------------------
	gained = nxp - cxp

	if (gained > 0) then
		hmmm = math.ceil((mxp - nxp) / gained)
		cmtk.text:SetText(hmmm)
		cmtk.text:SetTextColor(0.058, 0.901, 0.466, 1)
		cmtk:Show()
		cmxg.text:SetText("+" .. gained .. " (XP)")
		cmxg.text:SetTextColor(0.058, 0.901, 0.466, 1)
		UIFrameFadeIn(cmxg, 1, 0, 1)
		C_Timer.After(
			3,
			function()
				UIFrameFadeOut(cmxg, 1, 1, 0)
			end
		)
	end

	------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--- PLAYER EXPERIENCE --------------------------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------------------------------------------------
	percent = floor((cxp / mxp) * 100)
	_, _, rested = GetRestState()

	output = "player (" .. UnitLevel("player") .. "):"
	if rested == 2 then
		output = output .. " [rested x2] "
	end
	output = output .. "\n" .. cxp .. " / " .. mxp .. " (" .. percent .. "%)"
	PlayerExpFrame.text:SetText(output)
	r, g, b = ColorGradient(percent / 100, 1, 0, 0, 1, 1, 0, 0, 1, 0)
	PlayerExpFrame.text:SetTextColor(r, g, b, 1)

	------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--- PET EXPERIENCE -----------------------------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------------------------------------------------
	if class == "HUNTER" then
		if UnitExists("pet") then
			pcxp, pmxp = GetPetExperience()
			ppercent = floor((pcxp / pmxp) * 100)
			output = "pet (" .. UnitLevel("pet") .. "):\n" .. pcxp .. " / " .. pmxp .. " (" .. ppercent .. "%)"
			PetExpFrame.text:SetText(output)
			r, g, b = ColorGradient(ppercent / 100, 1, 0, 0, 1, 1, 0, 0, 1, 0)
			PetExpFrame.text:SetTextColor(r, g, b, 1)
			PetExpFrame:Show()
		else
			PetExpFrame:Hide()
		end
	end

	cxp = nxp
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("PLAYER_XP_UPDATE")
f:RegisterEvent("UNIT_PET")
f:SetScript("OnEvent", UpdateExperience)
