-- By D4KiR

MIPO = MIPO or {}
MIPOPC = MIPOPC or {}

MIPO.name = "Missing Power"
MIPO.colorname = "|c008888ff"
MIPO.author = "D4KiR"
MIPO.colorauthor = "|c0000ffff"

SetCVar("ScriptErrors", 1)
MIPO.DEBUG = false

MIPOPC["DEBUG"] = false

function MIPOGetConfig(str, val)
	local setting = val
	if MIPOPC ~= nil then
		if MIPOPC[str] == nil then
			MIPOPC[str] = val
		end
		setting = MIPOPC[str]
	end
	return setting
end
