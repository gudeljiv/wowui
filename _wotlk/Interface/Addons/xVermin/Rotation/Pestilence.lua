local _, xVermin = ...

local t = {
	'Critter',
	-- 'Not specified',
	'Totem',
	'Non-combat Pet',
	'Gas Cloud'
}

-- 1 = Inspect, 28 yards
-- 2 = Trade, 11.11 yards
-- 3 = Duel, 9.9 yards
-- 4 = Follow, 28 yards
xVermin.Pestilence = function(range)
	local frost_fever = 0
	local blood_plague = 0
	local t_ff = false
	local t_bp = false
	local units = 0

	if xVermin.Class ~= 'DEATHKNIGHT' then
		return false
	end

	for i = 1, 40 do
		local unit = 'nameplate' .. i
		if UnitExists(unit) and not xVermin.HasValue(t, UnitCreatureType(unit)) and xAOE(15) then
			units = units + 1
			for i = 1, 40 do
				local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitDebuff(unit, i)

				if (name == 'Frost Fever') then
					frost_fever = frost_fever + 1
				end
				if (name == 'Blood Plague') then
					blood_plague = blood_plague + 1
				end
			end
		end
	end

	if UnitExists('target') then
		t_ff = false
		t_bp = false
		for i = 1, 40 do
			local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitDebuff('target', i)

			if name == 'Frost Fever' then
				t_ff = true
			end
			if name == 'Blood Plague' then
				t_bp = true
			end
		end
	else
		return false
	end

	print(units, frost_fever, blood_plague, t_ff, t_bp)

	if not t_ff or not t_bp then
		return false
	end

	if units > frost_fever or units > blood_plague then
		return true
	else
		return false
	end
end
xPestilence = xVermin.Pestilence
