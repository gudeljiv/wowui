-----------------------------------------------------------------------------------------------------------------------------
-- Unit (Player) state
-----------------------------------------------------------------------------------------------------------------------------
local cus = CreateFrame("Frame", "CustomContainer_CombatUnitState", CustomContainer_Combat)
cus:SetPoint("CENTER", CustomContainer_Combat, "CENTER", 0, 2)
cus:SetWidth(1)
cus:SetHeight(1)
cus.text = cus:CreateFontString(nil, "ARTWORK")
cus.text:SetFont(config.font.arial, 10, "NONE")
cus.text:SetPoint("LEFT", CustomContainer_Combat, "LEFT", 3, 0)

PlayerFrame:HookScript(
	"OnUpdate",
	function()
		cus.text:SetText("")
		if (UnitIsAFK("player")) then
			cus.text:SetText("AFK")
		end
		if (UnitIsDND("player")) then
			cus.text:SetText("DND")
		end
		cus.text:SetTextColor(0.058, 0.901, 0.466, 1)
	end
)

-----------------------------------------------------------------------------------------------------------------------------
-- Unit (Player) ammo count
-----------------------------------------------------------------------------------------------------------------------------
local _, class, _ = UnitClass("player")
-- or class == "WARRIOR"
if class == "HUNTER" then
	local ac = CreateFrame("Frame", "CustomContainer_AmmoCount", CustomContainer_Combat)
	ac:SetPoint("CENTER", CustomContainer_Combat, "CENTER", 0, 2)
	ac:SetWidth(1)
	ac:SetHeight(1)
	ac.text = ac:CreateFontString(nil, "ARTWORK")
	ac.text:SetFont(config.font.arial, 10, "NONE")
	ac.text:SetPoint("CENTER", CustomContainer_Combat, "CENTER", 0, 0)

	PlayerFrame:HookScript(
		"OnUpdate",
		function()
			ac.text:SetText("")
			local ammoCount = GetInventoryItemCount("player", GetInventorySlotInfo("AmmoSlot"))
			ac.text:SetText(ammoCount)
			CharacterAmmoSlotCount:Hide()
		end
	)
end

-----------------------------------------------------------------------------------------------------------------------------
-- Unit (Player) speed
-----------------------------------------------------------------------------------------------------------------------------
local speed
local us = CreateFrame("Frame", "CustomContainer_CombatUnitSpeed", CustomContainer_Combat)
us:SetPoint("CENTER", CustomContainer_Combat, "CENTER", 0, 2)
us:SetWidth(1)
us:SetHeight(1)
us.text = us:CreateFontString(nil, "ARTWORK")
us.text:SetFont(config.font.arial, 10, "NONE")
us.text:SetPoint("BOTTOMRIGHT", CustomContainer_Combat, "TOPRIGHT", -1, 2)

PlayerFrame:HookScript(
	"OnUpdate",
	function()
		speed = string.format("%d", (GetUnitSpeed("Player") / 7) * 100)
		if speed and speed ~= "0" then
			us.text:SetText(speed .. "%")
		else
			us.text:SetText("")
		end
		us.text:SetTextColor(0.058, 0.901, 0.466, 1)
	end
)
