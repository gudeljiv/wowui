
xDamageFont = CreateFrame("Frame", "xDamageFont");

function xDamageFont:ApplySystemFonts()
	DAMAGE_TEXT_FONT = config.font.damage;
end

xDamageFont:SetScript("OnEvent", function() 
	if (event == "ADDON_LOADED") then
		xDamageFont:ApplySystemFonts()
	end
end);

xDamageFont:RegisterEvent("ADDON_LOADED");
xDamageFont:ApplySystemFonts()