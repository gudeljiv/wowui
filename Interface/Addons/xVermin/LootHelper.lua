local _, xVermin = ...

local ai = false
local costR1, costMAX

----------------------------------------------------------
-- LOOT HELPER - hide some of the UI
----------------------------------------------------------
local lm = CreateFrame("Frame", "LootModeWarningFrame")
lm:SetPoint("TOP", UIParent, "TOP", 0, -50)
lm.text = lm:CreateFontString(nil, "ARTWORK")
lm.text:SetFont(xVermin.Config.font.arial, 50, "NONE")
lm.text:SetShadowOffset(1, -1)
lm.text:SetPoint("TOP", lm, "TOP", 0, 0)
lm.text:SetText("LOOT MODE")
lm.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)
lm:SetWidth(lm.text:GetStringWidth())
lm:SetHeight(lm.text:GetStringHeight())
lm:Hide()

----------------------------------------------------------
-- BLIZZARD counter
----------------------------------------------------------
local bcf = CreateFrame("Frame", "BlizzardCountFrame")
bcf:SetPoint("TOP", UIParent, "TOP", 0, -50)
bcf.text = bcf:CreateFontString(nil, "ARTWORK")
bcf.text:SetFont(xVermin.Config.font.arial, 50, "NONE")
bcf.text:SetShadowOffset(1, -1)
bcf.text:SetPoint("TOP", bcf, "TOP", 0, 0)
bcf.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)

----------------------------------------------------------
-- Mana tick counter
----------------------------------------------------------
-- local mcf = CreateFrame("Frame", "ManaCountFrame")
-- mcf:SetPoint("LEFT", PlayerFrame, "RIGHT", 5, 2)
-- mcf.text = mcf:CreateFontString(nil, "ARTWORK")
-- mcf.text:SetFont(xVermin.Config.font.arial, 12, "NONE")
-- mcf.text:SetShadowOffset(1, -1)
-- mcf.text:SetPoint("TOP", mcf, "TOP", 0, 0)
-- mcf.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)

local function Set(autointeract)
	-- SetCVar("AutoInteract", autointeract and "1" or "0")
	if autointeract then
		SetBinding("MOUSEWHEELUP", "INTERACTMOUSEOVER", 1)
		SetBinding("MOUSEWHEELDOWN", "INTERACTMOUSEOVER", 1)
		PlayerFrame:SetAlpha(0)
		PlayerFrame:EnableMouse(false)
		TargetFrame:SetAlpha(0)
		TargetFrame:EnableMouse(false)
		LootFrame:SetAlpha(0)
		GameTooltip:SetScript("OnShow", GameTooltip.Hide)
		lm:Show()
		bcf:Hide()
	else
		SetBinding("MOUSEWHEELDOWN", "MULTIACTIONBAR2BUTTON1", 1)
		SetBinding("MOUSEWHEELUP", "MULTIACTIONBAR2BUTTON2", 1)
		PlayerFrame:SetAlpha(1)
		PlayerFrame:EnableMouse(true)
		TargetFrame:SetAlpha(1)
		TargetFrame:EnableMouse(true)
		LootFrame:SetAlpha(1)
		GameTooltip:SetScript("OnShow", GameTooltip.Show)
		lm:Hide()
		bcf:Show()
	end

	ai = autointeract
end

local function Get()
	return GetCVar("AutoInteract") == "1"
end

local f = CreateFrame("FRAME")
f:SetScript(
	"OnEvent",
	function(self, event)
		if event == "PLAYER_REGEN_ENABLED" then
			Set(not ai)
			f:UnregisterEvent("PLAYER_REGEN_ENABLED")
		end
	end
)

local btn = CreateFrame("BUTTON", "MyBindingLootHelper")
SetBindingClick("ALT-Q", btn:GetName())
btn:SetScript(
	"OnClick",
	function(self, event)
		if not InCombatLockdown() then
			-- Set(not Get())
			Set(not ai)
		else
			f:RegisterEvent("PLAYER_REGEN_ENABLED")
		end
	end
)

local lastmana = nil
local ticktime = time()
local bcount, base, casting
local manatick = 0
local manaticktotal = 0

bcf:RegisterEvent("ADDON_LOADED")
bcf:RegisterEvent("SPELLS_CHANGED")
bcf:RegisterUnitEvent("UNIT_POWER_UPDATE")
bcf:RegisterEvent("PLAYER_REGEN_DISABLED")
bcf:SetScript(
	"OnEvent",
	function(self, event, ...)
		if xVermin.Class == "MAGE" or xVermin.Class == "SHAMAN" or xVermin.Class == "PRIEST" or xVermin.Class == "HUNTER" or xVermin.Class == "PALADIN" or xVermin.Class == "WARLOCK" then
			---------------------------------------------------------
			-- mana ticks
			---------------------------------------------------------
			if event == PLAYER_REGEN_DISABLED then
				if time() - ticktime > 3 then
					manaticktotal = 0
					ticktime = time()
				end
			end

			base, casting = GetManaRegen()
			if (xVermin:Round(base, 2) or xVermin:Round(casting, 2)) > 0 then
				if lastmana then
					if UnitPower("player") > lastmana then
						manatick = UnitPower("player") - lastmana
					end
				end
			else
				manatick = 0
			end
			lastmana = UnitPower("player")
			if UnitPower("Player") == UnitPowerMax("player") then
				manatick = 0
			end

			-- mcf.text:SetText(manatick)
			-- mcf:SetWidth(mcf.text:GetStringWidth())
			-- mcf:SetHeight(mcf.text:GetStringHeight())

			---------------------------------------------------------
			-- blizzard counter
			---------------------------------------------------------
			if GetSpellPowerCost("Blizzard(Rank 1)") and GetSpellPowerCost("Blizzard(Rank 1)")[1].cost and GetSpellPowerCost("Blizzard(Rank 1)")[1].cost > 0 then
				local r1 = floor(UnitPower("Player") / GetSpellPowerCost("Blizzard(Rank 1)")[1].cost)
				local rm = floor(UnitPower("Player") / GetSpellPowerCost("Blizzard")[1].cost)
				local nr1 = floor((UnitPower("player") - (rm * GetSpellPowerCost("Blizzard")[1].cost)) / GetSpellPowerCost("Blizzard(Rank 1)")[1].cost)
				bcount = r1 .. " (" .. rm .. ") .. " .. nr1

				bcf.text:SetText(bcount)
				bcf:SetWidth(bcf.text:GetStringWidth())
				bcf:SetHeight(bcf.text:GetStringHeight())
			else
				bcf:Hide()
				self:UnregisterEvent("SPELLS_CHANGED")
			end
		else
			self:UnregisterAllEvents()
			bcf:Hide()
			-- mcf:Hide()
		end
	end
)
