
local font = "Interface\\AddOns\\xVerminz\\media\\fontAtari.ttf"
-----------------------------------------------------------------------------------------------------------------------------
-- Garbage Collector
-----------------------------------------------------------------------------------------------------------------------------
local cgt = CreateFrame("Frame", "CustomContainer_CombatGarbageText", CustomContainer_Combat)
cgt:SetPoint("CENTER", CustomContainer_Combat, "CENTER", 0, 2)
cgt:SetWidth(10) 
cgt:SetHeight(10)
cgt.text = cgt:CreateFontString(nil,"ARTWORK") 
cgt.text:SetFont(font, 11, "NONE")
cgt.text:SetPoint("RIGHT", CustomContainer_Combat, "RIGHT", -3, 2)
cgt:Hide()

local counter = 0

C_Timer.NewTicker(300, function() 
	collectgarbage()
	counter = counter + 1
	cgt.text:SetText(counter)
	cgt.text:SetTextColor(0.058, 0.901, 0.466, 1)
	cgt:Show()
	-- UIFrameFadeOut(cgt, 3, 1, 0)
end)