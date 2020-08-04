function DamageFont:ApplySystemFonts()
	DAMAGE_TEXT_FONT = config.font.damage
end

DamageFont:SetScript(
	"OnEvent",
	function()
		if (event == "ADDON_LOADED") then
			DamageFont:ApplySystemFonts()
		end
	end
)

DamageFont = CreateFrame("Frame", "DamageFont")
DamageFont:RegisterEvent("ADDON_LOADED")
DamageFont:ApplySystemFonts()
