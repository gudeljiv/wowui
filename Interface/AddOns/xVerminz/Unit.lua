
-----------------------------------------------------------------------------------------------------------------------------
-- Unit (Player) state
-----------------------------------------------------------------------------------------------------------------------------
local cus = CreateFrame("Frame", "CustomContainer_CombatUnitState", CustomContainer_Combat)
cus:SetPoint("CENTER", CustomContainer_Combat, "CENTER", 0, 2)
cus:SetWidth(1) 
cus:SetHeight(1)
cus.text = cus:CreateFontString(nil,"ARTWORK") 
cus.text:SetFont(config.font.atari, 11, "NONE")
cus.text:SetPoint("LEFT", CustomContainer_Combat, "LEFT", 3, 2)

PlayerFrame:HookScript("OnUpdate", function ()
	cus.text:SetText("")
	if(UnitIsAFK("player")) then cus.text:SetText("AFK") end
	if(UnitIsDND("player")) then cus.text:SetText("DND") end
end)

cus.text:SetTextColor(0.058, 0.901, 0.466, 1)



-----------------------------------------------------------------------------------------------------------------------------
-- Unit (Player) ammo count
-----------------------------------------------------------------------------------------------------------------------------
local _, class, _ = UnitClass("player");
if class == "HUNTER" or class == "WARRIOR" then
	local ac = CreateFrame("Frame", "CustomContainer_AmmoCount", CustomContainer_Combat)
	ac:SetPoint("CENTER", CustomContainer_Combat, "CENTER", 0, 2)
	ac:SetWidth(1)
	ac:SetHeight(1)
	ac.text = ac:CreateFontString(nil,"ARTWORK")
	ac.text:SetFont(config.font.atari, 11, "NONE")
	ac.text:SetPoint("CENTER", CustomContainer_Combat, "CENTER", 0, 2)

	PlayerFrame:HookScript("OnUpdate", function ()
		ac.text:SetText("")
		local ammoCount = GetInventoryItemCount("player", GetInventorySlotInfo("AmmoSlot"));
		ac.text:SetText(ammoCount)
		CharacterAmmoSlotCount:Hide()
	end)
end


-------------------------------------------
-- Set font in Character font for ammo count
-------------------------------------------
--CharacterAmmoSlotCount:SetFont("Fonts\\ARIALN.ttf", 10, 'THINOUTLINE')
--CharacterAmmoSlotCount:ClearAllPoints()
--CharacterAmmoSlotCount:SetPoint("TOP", CharacterAmmoSlot, "BOTTOM", 10, -2)

