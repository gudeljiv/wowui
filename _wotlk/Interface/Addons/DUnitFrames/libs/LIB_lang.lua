-- LIB Design

lang = lang or {}

function DUFGT(str, tab)
	local strid = str
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

function DUFUpdateLanguage()
	DUFLang_enUS()
	if GetLocale() == "enUS" then
		DUFLang_enUS()
	elseif GetLocale() == "deDE" then
		DUFLang_deDE()
	elseif GetLocale() == "ruRU" then
		DUFLang_ruRU()
	elseif GetLocale() == "zhTW" then
		DUFLang_zhTW()
	end
end
DUFUpdateLanguage()
