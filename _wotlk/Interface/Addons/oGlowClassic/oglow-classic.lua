local title, ns = ...
local oGlowClassic = ns.oGlowClassic

local _VERSION = GetAddOnMetadata('oGlowClassic', 'version')

local argcheck = oGlowClassic.argcheck

local print = function(...) print("|cff33ff99oGlowClassic:|r ", ...) end
local error = function(...) print("|cffff0000Error:|r "..string.format(...)) end

local pipesTable = ns.pipesTable
local filtersTable = ns.filtersTable
local displaysTable = ns.displaysTable

local numFilters = 0

local optionCallbacks = {}
local activeFilters = ns.activeFilters

local upgradePath = {
	[0] = function(db)
		db.FilterSettings = {}
		db.Colors = {}
		db.version = 1
	end
}

local upgradeDB = function(db)
	local version = db.version
	if(upgradePath[version]) then
		repeat
			upgradePath[version](db)
			version = version + 1
		until not upgradePath[version]
	end
end

local ADDON_LOADED = function(self, event, addon)
	if(addon == 'oGlowClassic') then
		if(not oGlowClassicDB) then
			oGlowClassicDB = {
				version = 1,
				EnabledPipes = {},
				EnabledFilters = {},

				FilterSettings = {},
				Colors = {},
			}

			for pipe in next, pipesTable do
				self:EnablePipe(pipe)

				for filter in next, filtersTable do
					self:RegisterFilterOnPipe(pipe, filter)
				end
			end
		else
			upgradeDB(oGlowClassicDB)

			for name, color in next, oGlowClassicDB.Colors do
				oGlowClassic:RegisterColor(name, unpack(color))
			end

			for pipe in next, oGlowClassicDB.EnabledPipes do
				self:EnablePipe(pipe)

				for filter, enabledPipes in next, oGlowClassicDB.EnabledFilters do
					if(enabledPipes[pipe]) then
						self:RegisterFilterOnPipe(pipe, filter)
						break
					end
				end
			end
		end

		self:CallOptionCallbacks()

        print("v" .. _VERSION .. " loaded.")
	end
end

--[[ General API ]]

function oGlowClassic:CallFilters(pipe, frame, ...)
	argcheck(pipe, 2, 'string')

	if(not pipesTable[pipe]) then return nil, 'Pipe does not exist.' end

	local ref = activeFilters[pipe]
	if(ref) then
		for display, filters in next, ref do
			-- TODO: Move this check out of the loop.
			if(not displaysTable[display]) then return nil, 'Display does not exist.' end

			for i=1,#filters do
				local func = filters[i][2]

				-- drop out of the loop if we actually do something nifty on a frame.
				if(displaysTable[display](frame, func(...))) then break end
			end
		end
	end
end

function oGlowClassic:RegisterOptionCallback(func)
	argcheck(func, 2, 'function')

	table.insert(optionCallbacks, func)
end

function oGlowClassic:CallOptionCallbacks()
	for _, func in next, optionCallbacks do
		func(oGlowClassicDB)
	end
end

oGlowClassic:RegisterEvent('ADDON_LOADED', ADDON_LOADED)

oGlowClassic.argcheck = argcheck

oGlowClassic.version = _VERSION
_G.oGlowClassic = oGlowClassic
