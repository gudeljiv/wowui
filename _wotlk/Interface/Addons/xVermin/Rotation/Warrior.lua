local _, xVermin = ...

local t = {
	'Critter',
	-- 'Not specified',
	'Totem',
	'Non-combat Pet',
	'Gas Cloud'
}

xVermin.Rend = function(number_of_nameplates)
	number_of_nameplates = number_of_nameplates or 15
	local has_rend = 0
	local target_has_rend = false
	local units = 0

	if xVermin.Class ~= 'WARRIOR' then
		return false
	end

	if xAOE(10) < 1 then
		return false
	end

	if not UnitExists('target') then
		return false
	end

	-- TARGET
	target_has_rend = false
	for i = 1, 40 do
		local name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, _, spellId, canApplyAura, isBossAura = UnitDebuff('target', i)

		if name == 'Rend' and unitCaster == 'player' then
			target_has_rend = true
		end
	end

	if not target_has_rend then
		return false
	end

	-- NAMEPLATES
	for i = 1, number_of_nameplates do
		local unit = 'nameplate' .. i
		if UnitExists(unit) and not xVermin.HasValue(t, UnitCreatureType(unit)) and xVermin.InRange(10, unit) then
			units = units + 1
			for i = 1, 20 do
				local name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, _, spellId, canApplyAura, isBossAura = UnitDebuff(unit, i)

				if name then
					if name == 'Rend' and unitCaster == 'player' then
						has_rend = has_rend + 1
					end
				end
			end
		end
	end

	if units > has_rend then
		return true
	else
		return false
	end
end
xRend = xVermin.Rend