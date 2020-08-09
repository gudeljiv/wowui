--local font = "Interface\\AddOns\\xVermin\\Media\\fontAtari.ttf"
local _, class, _ = UnitClass("player")
local r, g, b, NewXP, hmmm, gained, XPToLVL, num, segment, relperc, r1, r2, g1, g2, b1, b2, f, PetExpFrame, PlayerExpFrame, percent, rested, output, pcxp, pmxp, ppercent, cmtk
local color = RAID_CLASS_COLORS[class]
if class == "SHAMAN" then
	color = {
		b = 0.86666476726532,
		g = 0.4392147064209,
		r = 0
	}
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- color funtion based on amount of XP
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- creating all the frames we need
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if class == "HUNTER" then
	PetExpFrame = CreateFrame("Frame", "PetExpFrame", UIParent)
	PetExpFrame:SetWidth(1)
	PetExpFrame:SetHeight(1)
	PetExpFrame:SetAlpha(0.9)
	PetExpFrame:SetPoint("BOTTOMLEFT", ChatFrame1, "BOTTOMRIGHT", 5, 40)
	PetExpFrame.text = PetExpFrame:CreateFontString(nil, "ARTWORK")
	PetExpFrame.text:SetJustifyH("LEFT")
	PetExpFrame.text:SetJustifyV("TOP")
	PetExpFrame.text:SetFont(xVerminConfig.font.arial, 12)
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
PlayerExpFrame.text:SetFont(xVerminConfig.font.arial, 12)
PlayerExpFrame.text:SetShadowOffset(1, -1)
PlayerExpFrame.text:SetTextColor(1, 1, 1, 1)
PlayerExpFrame.text:SetPoint("LEFT", PlayerExpFrame, "LEFT", 0, 0)
PlayerExpFrame:SetFrameStrata("MEDIUM")
PlayerExpFrame:Hide()

cmtk = CreateFrame("Frame", "CustomContainer_CombatMobsToKill", CustomContainer_Combat)
cmtk:SetPoint("CENTER", CustomContainer_Combat, "CENTER", 0, 2)
cmtk:SetWidth(10)
cmtk:SetHeight(10)
cmtk.text = cmtk:CreateFontString(nil, "ARTWORK")
cmtk.text:SetFont(xVerminConfig.font.arial, 10, "NONE")
cmtk.text:SetPoint("RIGHT", CustomContainer_Combat, "RIGHT", -3, 0)
cmtk:Hide()

cmxg = CreateFrame("Frame", "CustomContainer_CombatXPgained", CustomContainer_Combat)
cmxg:SetPoint("CENTER", CustomContainer_Combat, "CENTER", 0, 2)
cmxg:SetWidth(10)
cmxg:SetHeight(10)
cmxg.text = cmxg:CreateFontString(nil, "ARTWORK")
cmxg.text:SetFont(xVerminConfig.font.arial, 10, "NONE")
cmxg.text:SetPoint("LEFT", CustomContainer_Combat, "RIGHT", 3, 0)
cmxg:Hide()

cpxf = CreateFrame("Frame", "CustomContainer_CombatXPcurrent", CustomContainer_Combat)
cpxf:SetPoint("CENTER", CustomContainer_Combat, "CENTER", 0, 2)
cpxf:SetWidth(10)
cpxf:SetHeight(10)
cpxf.text = cpxf:CreateFontString(nil, "ARTWORK")
cpxf.text:SetFont(xVerminConfig.font.arial, 8, "NONE")
cpxf.text:SetPoint("TOPRIGHT", CustomContainer_Combat, "BOTTOMRIGHT", 0, -3)
cpxf:Hide()

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local CurrentXP = UnitXP("player")
local MaxXP = UnitXPMax("player")
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- calculate experience and populate right frames
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local function UpdateExperience(self, event)
	if UnitLevel("player") < MAX_PLAYER_LEVEL_TABLE[GetExpansionLevel()] then
		NewXP = UnitXP("player")

		------------------------------------------------------------------------------------------------------------------------------------------------------------------
		--- MOBS TO KILL -------------------------------------------------------------------------------------------------------------------------------------------------
		------------------------------------------------------------------------------------------------------------------------------------------------------------------
		if event ~= "UNIT_PET" then
			gained = NewXP - CurrentXP
			XPToLVL = MaxXP - NewXP

			-- print("------------------------------------------------------")
			-- print("Event: " .. event)
			-- print("CurrentXP: " .. CurrentXP)
			-- print("MaxXP: " .. MaxXP)
			-- print("NewXP: " .. NewXP)
			-- print("Gained: " .. gained)
			-- print("XPToLVL: " .. XPToLVL)
			-- print("------------------------------------------------------")

			cpxf.text:SetText(XPToLVL .. " (XP)")
			cpxf.text:SetTextColor(color.r, color.g, color.b, 1)

			if gained > 0 and event ~= "PLAYER_ENTERING_WORLD" then
				hmmm = math.ceil((MaxXP - NewXP) / gained)
				cmtk.text:SetText(hmmm)
				cmtk.text:SetTextColor(color.r, color.g, color.b, 1)

				cmxg.text:SetText("+" .. gained .. " (XP)")
				cmxg.text:SetTextColor(color.r, color.g, color.b, 1)
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
			percent = floor((NewXP / MaxXP) * 100)
			_, _, rested = GetRestState()

			output = "player (" .. UnitLevel("player") .. "):"
			if rested == 2 then
				output = output .. " [rested x2] "
			end
			output = output .. "\n" .. NewXP .. " / " .. MaxXP .. " (" .. percent .. "%)"
			PlayerExpFrame.text:SetText(output)
			r, g, b = ColorGradient(percent / 100, 1, 0, 0, 1, 1, 0, 0, 1, 0)
			PlayerExpFrame.text:SetTextColor(r, g, b, 1)
		end

		------------------------------------------------------------------------------------------------------------------------------------------------------------------
		--- PET EXPERIENCE -----------------------------------------------------------------------------------------------------------------------------------------------
		------------------------------------------------------------------------------------------------------------------------------------------------------------------
		if class == "HUNTER" then
			C_Timer.After(
				0.5,
				function()
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
			)
		end

		CurrentXP = NewXP

		PlayerExpFrame:Show()
		cmtk:Show()
		cpxf:Show()
	else
		PlayerExpFrame:Hide()
		PetExpFrame:Hide()
		cmtk:Hide()
		cmxg:Hide()
		cpxf:Hide()
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_XP_UPDATE")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("UNIT_PET")
f:RegisterEvent("PLAYER_LEVEL_UP")
f:SetScript(
	"OnEvent",
	function(self, event)
		if event == "PLAYER_LEVEL_UP" or event == "PLAYER_ENTERING_WORLD" then
			C_Timer.After(
				1,
				function()
					MaxXP = UnitXPMax("player")
					UpdateExperience(self, event)
				end
			)
		else
			UpdateExperience(self, event)
		end
	end
)
