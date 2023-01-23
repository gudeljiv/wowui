local _, ns = ...
local oGlowClassic = ns.oGlowClassic
local argcheck = oGlowClassic.argcheck

local displaysTable = {}

--[[ Display API ]]

function oGlowClassic:RegisterDisplay(name, display)
	argcheck(name, 2, 'string')
	argcheck(display, 3, 'function')

	displaysTable[name] = display
end

ns.displaysTable = displaysTable
