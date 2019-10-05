
local font = "Interface\\AddOns\\xVerminz\\media\\fontAtari.ttf"
-----------------------------------------------------------------------------------------------------------------------------
-- Unit (Player) state
-----------------------------------------------------------------------------------------------------------------------------
local cus = CreateFrame("Frame", "CustomContainer_CombatUnitState", CustomContainer_Combat)
cus:SetPoint("CENTER", CustomContainer_Combat, "CENTER", 0, 2)
cus:SetWidth(1) 
cus:SetHeight(1)
cus.text = cus:CreateFontString(nil,"ARTWORK") 
cus.text:SetFont(font, 11, "NONE")
cus.text:SetPoint("LEFT", CustomContainer_Combat, "LEFT", 3, 2)

PlayerFrame:HookScript("OnUpdate", function ()
	cus.text:SetText("")
	if(UnitIsAFK("player")) then cus.text:SetText("AFK") end
	if(UnitIsDND("player")) then cus.text:SetText("DND") end
end)

cus.text:SetTextColor(0.058, 0.901, 0.466, 1)

