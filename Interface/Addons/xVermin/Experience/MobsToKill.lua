local _, xVermin = ...

local r, g, b, NewXP, hmmm, gained, XPToLVL, num, segment, relperc, r1, r2, g1, g2, b1, b2, PlayerXP, PetExpFrame, PlayerExpFrame, percent, rested, output, pcxp, pmxp, ppercent, MobsToKill
local timer = time()

MobsToKill = CreateFrame("Frame", "CustomContainer_CombatMobsToKill", CustomContainer_Combat)
MobsToKill:SetPoint("CENTER", CustomContainer_Combat, "CENTER", 0, 0)
MobsToKill:SetWidth(10)
MobsToKill:SetHeight(10)
MobsToKill.text = MobsToKill:CreateFontString(nil, "ARTWORK")
MobsToKill.text:SetFont(xVermin.Config.font.arial, 10, "NONE")
MobsToKill.text:SetPoint("RIGHT", CustomContainer_Combat, "RIGHT", -5, -1)
MobsToKill:Hide()

gainedExperience = CreateFrame("Frame", "CustomContainer_CombatgainedExperience", CustomContainer_Combat)
gainedExperience:SetPoint("CENTER", CustomContainer_Combat, "CENTER", 0, 0)
gainedExperience:SetWidth(10)
gainedExperience:SetHeight(10)
gainedExperience.text = gainedExperience:CreateFontString(nil, "ARTWORK")
gainedExperience.text:SetFont(xVermin.Config.font.arial, 10, "NONE")
gainedExperience.text:SetPoint("LEFT", CustomContainer_Combat, "RIGHT", 5, -1)
gainedExperience:Hide()

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local CurrentXP = UnitXP("player")
local MaxXP = UnitXPMax("player")
local MobToKillTimer
local mbk = false

local function UpdateExperience(event, isInitialLogin, isReloadingUi)
	if event == "PLAYER_ENTERING_WORLD" and (isInitialLogin or isReloadingUi) then
		MaxXP = UnitXPMax("player")
		CurrentXP = UnitXP("player")
	else
		NewXP = UnitXP("player")

		if event == "PLAYER_LEVEL_UP" then
			-- ChatFrame6:AddMessage(event)
			-- ChatFrame6:AddMessage("MaxXP A: " .. MaxXP)
			-- ChatFrame6:AddMessage("CurrentXP: " .. CurrentXP)
			-- ChatFrame6:AddMessage("NewXP: " .. NewXP)
			-- ChatFrame6:AddMessage("Gained: " .. gained)
			-- ChatFrame6:AddMessage("Mobs: " .. math.ceil((MaxXP - NewXP) / gained))
			-- ChatFrame6:AddMessage("-------------------------------------------------------------")
			-- ChatFrame6:AddMessage("MaxXP B: " .. MaxXP)

			gained = MaxXP - CurrentXP + NewXP
			MaxXP = UnitXPMax("player")
		else
			-- ChatFrame6:AddMessage(event)
			-- ChatFrame6:AddMessage("MaxXP: " .. MaxXP)
			-- ChatFrame6:AddMessage("CurrentXP: " .. CurrentXP)
			-- ChatFrame6:AddMessage("NewXP: " .. NewXP)
			-- ChatFrame6:AddMessage("Gained: " .. gained)
			-- ChatFrame6:AddMessage("Mobs: " .. math.ceil((MaxXP - NewXP) / gained))
			-- ChatFrame6:AddMessage("-------------------------------------------------------------")
			gained = NewXP - CurrentXP
		end

		if gained > 0 then
			hmmm = math.ceil((MaxXP - NewXP) / gained)
			MobsToKill.text:SetText(hmmm)
			MobsToKill.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)

			-- ako MBK frame nije prikazan prikazi ga
			if not mbk then
				UIFrameFadeIn(MobsToKill, 1, 0, 1)
				mbk = true
			end

			-- ako postoji timer zaustavi ga
			if MobToKillTimer then
				MobToKillTimer:Cancel()
			end

			-- kreiranje novog timera
			MobToKillTimer =
				C_Timer.NewTimer(
				120,
				function(self)
					-- ugasi MBK frame nakon 120 sekundi
					UIFrameFadeOut(MobsToKill, 1, 1, 0)
					mbk = false
				end
			)

			gainedExperience.text:SetText("+" .. gained .. " (XP)")
			gainedExperience.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)
			UIFrameFadeIn(gainedExperience, 1, 0, 1)
			C_Timer.After(
				5,
				function()
					UIFrameFadeOut(gainedExperience, 1, 1, 0)
				end
			)
		end

		CurrentXP = NewXP
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("PLAYER_LEVEL_UP")
f:RegisterEvent("PLAYER_XP_UPDATE")
f:SetScript(
	"OnEvent",
	function(self, event, isInitialLogin, isReloadingUi)
		if UnitLevel("player") == MAX_PLAYER_LEVEL_TABLE[GetExpansionLevel()] then
			MobsToKill:Hide()
			self:UnregisterAllEvents()
		else
			C_Timer.After(
				1,
				function()
					UpdateExperience(event, isInitialLogin, isReloadingUi)
				end
			)
		end
	end
)
