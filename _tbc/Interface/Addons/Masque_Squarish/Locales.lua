--[[

	This file is part of 'Masque: Squarish', an add-on for World of Warcraft. For bug reports,
	documentation and license information, please visit https://github.com/SFX-WoW/Masque_Squarish.

	* File...: Locales.lua
	* Author.: StormFX

]]

local _, Core = ...

----------------------------------------
-- Locals
---

local Locale = GetLocale()
local L = {}

----------------------------------------
-- Core
---

Core.Locale = setmetatable(L, {
	__index = function(self, k)
		self[k] = k
		return k
	end
})

----------------------------------------
-- Localization
---

if Locale == "enGB" or Locale == "enUS" then
	L["A port of the original SimpleSquare skin for cyCircled."] = "A port of the original SimpleSquare skin for cyCircled."
	L["A thinner version of Squarish."] = "A thinner version of Squarish."
	return
--elseif Locale == "deDE" then
--elseif Locale == "esES" or Locale == "esMX" then
--elseif Locale == "frFR" then
--elseif Locale == "itIT" then
--elseif Locale == "koKR" then
--elseif Locale == "ptBR" then
elseif Locale == "ruRU" then
	L["A port of the original SimpleSquare skin for cyCircled."] = "Порт оригинального скина SimpleSquare для cyCircled."
	L["A thinner version of Squarish."] = "Более тонкая версия Squarish."
--elseif Locale == "zhCN" then
elseif Locale == "zhTW" then
	L["A port of the original SimpleSquare skin for cyCircled."] = "這是 cyCircled 原始 SimpleSquare 外觀的移植版。"
	L["A thinner version of Squarish."] = "這是 Squarish 的較薄版本。"
end
