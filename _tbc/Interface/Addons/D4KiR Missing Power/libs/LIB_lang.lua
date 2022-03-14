-- LIB Design

MIPO = MIPO or {}

lang = lang or {}

function MIPOGT(str, tab)
	local strid = string.lower(str)
	local result = lang[strid]
	if result ~= nil then
		if tab ~= nil then
			for i, v in pairs(tab) do
				local find = i -- "[" .. i .. "]"
				local replace = v
				if find ~= nil and replace ~= nil then
					result = string.gsub(result, find, replace)
				end
			end
		end
		return result
	else
		return str
	end
end

function MIPOUpdateLanguage()
	MIPO:Lang_enUS()
	if GetLocale() == "enUS" then
		--MIPOmsg("Language detected: enUS (English)")
		MIPO.Lang_enUS()
	elseif GetLocale() == "deDE" then
		--MIPOmsg("Language detected: deDE (Deutsch)")
		MIPO.Lang_deDE()
	elseif GetLocale() == "koKR" then
		--MIPOmsg("Language detected: koKR (Korean)")
		MIPO.Lang_koKR()
	elseif GetLocale() == "ruRU" then
		--MIPOmsg("Language detected: ruRU (Russian)")
		MIPO.Lang_ruRU()
	elseif GetLocale() == "zhCN" then
		--MIPOmsg("Language detected: zhCN (Simplified Chinese)")
		MIPO.Lang_zhCN()
	elseif GetLocale() == "zhTW" then
		--MIPOmsg("Language detected: zhTW (Traditional Chinese)")
		MIPO.Lang_zhTW()
	else
		MIPOmsg("Language not found (" .. GetLocale() .. "), using English one!")
		MIPOmsg("If you want your language, please visit the cursegaming site of this project!")
	end
end

MIPOUpdateLanguage()
