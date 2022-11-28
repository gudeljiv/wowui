local MAJOR_VERSION = "LibDogTag-Stats-3.0"
local MINOR_VERSION = 90000 + tonumber(("$Revision: 9 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_Stats_MINOR_VERSION then
	_G.DogTag_Stats_MINOR_VERSION = MINOR_VERSION
end

if GetLocale() == "zhCN" then

DogTag_Stats_funcs[#DogTag_Stats_funcs+1] = function(DogTag_Stats, DogTag)
	local L = DogTag_Stats.L
	
	--@localization(locale="zhCN", format="lua_additive_table", handle-unlocalized="ignore")@
end

end