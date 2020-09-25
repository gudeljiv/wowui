local _, xVermin = ...

--local font = "Interface\\AddOns\\xVermin\\Media\\fontAtari.ttf"
local _, class, _ = UnitClass("player")
local r, g, b, NewXP, hmmm, gained, XPToLVL, num, segment, relperc, r1, r2, g1, g2, b1, b2, PlayerXP, PetExpFrame, PlayerExpFrame, percent, rested, output, pcxp, pmxp, ppercent, MobsToKill
local color = RAID_CLASS_COLORS[class]
if class == "SHAMAN" then
	color = {
		b = 0.86666476726532,
		g = 0.4392147064209,
		r = 0
	}
end

MobsToKill = CreateFrame("Frame", "CustomContainer_CombatMobsToKill", CustomContainer_Combat)
MobsToKill:SetPoint("CENTER", CustomContainer_Combat, "CENTER", 0, 2)
MobsToKill:SetWidth(10)
MobsToKill:SetHeight(10)
MobsToKill.text = MobsToKill:CreateFontString(nil, "ARTWORK")
MobsToKill.text:SetFont(xVermin.Config.font.arial, 10, "NONE")
MobsToKill.text:SetPoint("RIGHT", CustomContainer_Combat, "RIGHT", -3, 0)
MobsToKill:Hide()

gainedExperience = CreateFrame("Frame", "CustomContainer_CombatgainedExperience", CustomContainer_Combat)
gainedExperience:SetPoint("CENTER", CustomContainer_Combat, "CENTER", 0, 2)
gainedExperience:SetWidth(10)
gainedExperience:SetHeight(10)
gainedExperience.text = gainedExperience:CreateFontString(nil, "ARTWORK")
gainedExperience.text:SetFont(xVermin.Config.font.arial, 10, "NONE")
gainedExperience.text:SetPoint("LEFT", CustomContainer_Combat, "RIGHT", 3, 0)
gainedExperience:Hide()

XPToLevel = CreateFrame("Frame", "CustomContainer_CombatXPToLevel", CustomContainer_Combat)
XPToLevel:SetPoint("CENTER", CustomContainer_Combat, "CENTER", 0, 2)
XPToLevel:SetWidth(10)
XPToLevel:SetHeight(10)
XPToLevel.text = XPToLevel:CreateFontString(nil, "ARTWORK")
XPToLevel.text:SetFont(xVermin.Config.font.arial, 8, "NONE")
XPToLevel.text:SetPoint("TOPRIGHT", CustomContainer_Combat, "BOTTOMRIGHT", 0, -3)
XPToLevel:Hide()

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local CurrentXP = UnitXP("player")
local MaxXP = UnitXPMax("player")
local MobToKillTimer
local mbk = false

local function UpdateExperience()
	if UnitLevel("player") < MAX_PLAYER_LEVEL_TABLE[GetExpansionLevel()] then
		XPToLevel:Show()
		NewXP = UnitXP("player")

		gained = NewXP - CurrentXP
		XPToLVL = MaxXP - NewXP

		XPToLevel.text:SetText(XPToLVL .. " (XP)")
		XPToLevel.text:SetTextColor(color.r, color.g, color.b, 1)

		xVermin:LogBreak()
		xVermin:Log("current xp: " .. CurrentXP, mbk)
		xVermin:Log("new xp: " .. NewXP, mbk)
		xVermin:Log("gained: " .. gained, mbk)
		xVermin:Log("xp to lvl: " .. XPToLVL, mbk)
		xVermin:Log("mobs to lvl: " .. math.ceil((MaxXP - NewXP) / gained), mbk)
		xVermin:LogBreak()

		if gained > 0 then
			hmmm = math.ceil((MaxXP - NewXP) / gained)
			MobsToKill.text:SetText(hmmm)
			MobsToKill.text:SetTextColor(color.r, color.g, color.b, 1)

			xVermin:Log("mbk frame: " .. (mbk and "true" or "false"), mbk)
			xVermin:Log("mbk timer: " .. (MobToKillTimer and "true" or "false"), mbk)
			xVermin:LogBreak()

			if not mbk then
				UIFrameFadeIn(MobsToKill, 1, 0, 1)
				mbk = true
			end

			if MobToKillTimer then
				MobToKillTimer:Cancel()
			end

			MobToKillTimer =
				C_Timer.NewTimer(
				60,
				function(self)
					UIFrameFadeOut(MobsToKill, 1, 1, 0)
					mbk = false
				end
			)

			gainedExperience.text:SetText("+" .. gained .. " (XP)")
			gainedExperience.text:SetTextColor(color.r, color.g, color.b, 1)
			UIFrameFadeIn(gainedExperience, 1, 0, 1)
			C_Timer.After(
				3,
				function()
					UIFrameFadeOut(gainedExperience, 1, 1, 0)
				end
			)
		end

		CurrentXP = NewXP
	else
		MobsToKill:Hide()
		XPToLevel:Hide()
		gainedExperience:Hide()
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LEVEL_UP")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("PLAYER_XP_UPDATE")
f:SetScript(
	"OnEvent",
	function(self, event, isInitialLogin, isReloadingUi)
		if event == "PLAYER_LEVEL_UP" or (event == "PLAYER_ENTERING_WORLD" and (isInitialLogin or isReloadingUi)) then
			C_Timer.After(
				1,
				function()
					MaxXP = UnitXPMax("player")
					UpdateExperience()
					MobsToKill:Hide()
				end
			)
		end
		if event == "PLAYER_XP_UPDATE" then
			UpdateExperience()
		end
	end
)
