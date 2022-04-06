-- scope stuff
gearquipper = gearquipper or {};
gearquipper.localizations = gearquipper.localizations or {};

-- locales
local LOCALE_GERMAN = "deDE";
local currentLocale = GetLocale();

function gearquipper:GetText(key, ...)
	if gearquipper.localizations[currentLocale] and gearquipper.localizations[currentLocale][key] then
		return string.format(gearquipper.localizations[currentLocale][key], ...);
	end
	return string.format(key, ...);
end