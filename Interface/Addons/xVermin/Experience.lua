--local font = "Interface\\AddOns\\xVermin\\media\\fontAtari.ttf"
local _, class, _ = UnitClass("player")
local r, g, b

local function ColorGradient(perc, ...)
	if perc >= 1 then
		r, g, b = select(select("#", ...) - 2, ...)
		return r, g, b
	elseif perc <= 0 then
		r, g, b = ...
		return r, g, b
	end

	local num = select("#", ...) / 3
	local segment, relperc = math.modf(perc * (num - 1))
	local r1, g1, b1, r2, g2, b2 = select((segment * 3) + 1, ...)
	return r1 + (r2 - r1) * relperc, g1 + (g2 - g1) * relperc, b1 + (b2 - b1) * relperc
end

if class == "HUNTER" then
	local PetExpFrame = CreateFrame("Frame", "PetExpFrame", UIParent)
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

local PlayerExpFrame = CreateFrame("Frame", "PlayerExpFrame", UIParent)
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

MainMenuExpBar:HookScript(
	"OnUpdate",
	function()
		local currentXP = UnitXP("player")
		local maxXP = UnitXPMax("player")
		local percent = floor((currentXP / maxXP) * 100)
		local _, _, rested = GetRestState()

		local output = "player (" .. UnitLevel("player") .. "):"
		if rested == 2 then
			output = output .. " [rested x2] "
		end
		output = output .. "\n" .. currentXP .. " / " .. maxXP .. " (" .. percent .. "%)"

		PlayerExpFrame.text:SetText(output)

		r, g, b = ColorGradient(percent / 100, 1, 0, 0, 1, 1, 0, 0, 1, 0)
		PlayerExpFrame.text:SetTextColor(r, g, b, 1)

		if class == "HUNTER" then
			if UnitExists("pet") then
				local petCurrentXP, petMaxXP = GetPetExperience()
				local petPercent = floor((petCurrentXP / petMaxXP) * 100)
				PetExpFrame.text:SetText(
					"pet (" .. UnitLevel("pet") .. "):\n" .. petCurrentXP .. " / " .. petMaxXP .. " (" .. petPercent .. "%)"
				)

				r, g, b = ColorGradient(petPercent / 100, 1, 0, 0, 1, 1, 0, 0, 1, 0)
				PetExpFrame.text:SetTextColor(r, g, b, 1)

				PetExpFrame:Show()
			else
				PetExpFrame:Hide()
			end
		end
	end
)

local cmtk = CreateFrame("Frame", "CustomContainer_CombatMobsToKill", CustomContainer_Combat)
cmtk:SetPoint("CENTER", CustomContainer_Combat, "CENTER", 0, 2)
cmtk:SetWidth(10)
cmtk:SetHeight(10)
cmtk.text = cmtk:CreateFontString(nil, "ARTWORK")
cmtk.text:SetFont(config.font.atari, 11, "NONE")
cmtk.text:SetPoint("RIGHT", CustomContainer_Combat, "RIGHT", -3, 2)
cmtk:Hide()

local cxp = UnitXP("player")
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_XP_UPDATE")
f:SetScript(
	"OnEvent",
	function(self, event, ...)
		local nxp = UnitXP("player")
		local mxp = UnitXPMax("player")
		local gained = nxp - cxp
		if (gained > 0) then
			local hmmm = math.ceil((mxp - nxp) / gained)
			cmtk.text:SetText(hmmm)
			cmtk.text:SetTextColor(0.058, 0.901, 0.466, 1)
			cmtk:Show()
		end
		cxp = nxp
	end
)
