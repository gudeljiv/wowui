local _, ns = ...

ns.L = setmetatable({}, {__index = function(L, key) return key end})

-- TODO: Add translations.
if GetLocale() == "frFR" then
  ns.L["Rune not known yet!"] = "Rune pas encore connue!"
elseif GetLocale() == "deDE" then
  ns.L["Rune not known yet!"] = "Rune noch nicht bekannt!"
elseif GetLocale() == "ruRU" then
  ns.L["Rune not known yet!"] = "Руна еще не известна!"
end
