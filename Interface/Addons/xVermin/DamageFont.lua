local _, xVermin = ...

DamageFont = CreateFrame("Frame", "DamageFont")
function DamageFont:ApplySystemFonts()
	DAMAGE_TEXT_FONT = xVermin.Config.font.damage
end

DamageFont:SetScript(
	"OnEvent",
	function()
		DamageFont:ApplySystemFonts()
	end
)

DamageFont:RegisterEvent("ADDON_LOADED")
DamageFont:ApplySystemFonts()
