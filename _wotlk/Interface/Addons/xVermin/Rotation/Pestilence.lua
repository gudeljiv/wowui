local _, xVermin = ...

local t = {
	'Critter',
	-- 'Not specified',
	'Totem',
	'Non-combat Pet',
	'Gas Cloud'
}

xVermin.Pestilence = function(number_of_nameplates)
	number_of_nameplates = number_of_nameplates or 15
	local has_frost_fever = 0
	local has_blood_plague = 0
	local target_has_frost_fever = false
	local target_has_blood_plague = false
	local units = 0

	if xVermin.Class ~= 'DEATHKNIGHT' then
		return false
	end

	if xAOE(10) < 1 then
		return false
	end

	if not UnitExists('target') then
		return false
	end

	-- TARGET
	target_has_frost_fever = false
	target_has_blood_plague = false
	for i = 1, 40 do
		local name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, _, spellId, canApplyAura, isBossAura = UnitDebuff('target', i)

		if name == 'Frost Fever' and unitCaster == 'player' then
			target_has_frost_fever = true
		end
		if name == 'Blood Plague' and unitCaster == 'player' then
			target_has_blood_plague = true
		end
	end

	if not target_has_frost_fever or not target_has_blood_plague then
		return false
	end

	-- NAMEPLATES
	for i = 1, number_of_nameplates do
		local unit = 'nameplate' .. i
		if UnitExists(unit) and not xVermin.HasValue(t, UnitCreatureType(unit)) and xRange(10, unit) then
			units = units + 1
			for i = 1, 20 do
				local name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, _, spellId, canApplyAura, isBossAura = UnitDebuff(unit, i)

				if name then
					if name == 'Frost Fever' and unitCaster == 'player' then
						has_frost_fever = has_frost_fever + 1
					end
					if name == 'Blood Plague' and unitCaster == 'player' then
						has_blood_plague = has_blood_plague + 1
					end
				end
			end
		end
	end

	if units > has_frost_fever or units > has_blood_plague then
		return true
	else
		return false
	end
end
xPestilence = xVermin.Pestilence
