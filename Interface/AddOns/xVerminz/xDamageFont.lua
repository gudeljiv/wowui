
xDamageFont = CreateFrame("Frame", "xDamageFont");
local damagefont_FONT_NUMBER = "Interface\\AddOns\\xVerminz\\media\\damagefont.ttf";

function xDamageFont:ApplySystemFonts()
	DAMAGE_TEXT_FONT = damagefont_FONT_NUMBER;
end

xDamageFont:SetScript("OnEvent", function() 
	if (event == "ADDON_LOADED") then
		xDamageFont:ApplySystemFonts()
	end
end);

xDamageFont:RegisterEvent("ADDON_LOADED");
xDamageFont:ApplySystemFonts()