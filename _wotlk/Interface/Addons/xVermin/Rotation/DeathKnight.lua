local _, xVermin = ...

local t = {
	'Critter',
	-- 'Not specified',
	'Totem',
	'Non-combat Pet',
	'Gas Cloud'
}

xVermin.PestilenceAOE = function(number_of_nameplates)
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
		if UnitExists(unit) and not xVermin.HasValue(t, UnitCreatureType(unit)) and xVermin.InRange(10, unit) then
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
xPestilenceAOE = xVermin.PestilenceAOE

xVermin.RuneCount = function()
	local blood = 0
	local frost = 0
	local unholy = 0
	local death = 0
	for i = 1, 6 do
		local runeType = GetRuneType(i)
		local start, duration, runeReady = GetRuneCooldown(i)
		if runeReady then
			blood = runeType == 1 and blood + 1 or blood
			frost = runeType == 3 and frost + 1 or frost
			unholy = runeType == 2 and unholy + 1 or unholy
			death = runeType == 4 and death + 1 or death
		end
	end

	return blood, frost, unholy, death
end
xRuneCount = xVermin.RuneCount

xVermin.minRuneCooldown = function()
	local cd = InCombatLockdown() and 7.5 or 10

	local blood = cd
	local frost = cd
	local unholy = cd
	local death = cd

	local tmin = 30
	local tmax = 0
	local remaining, start, duration, runeReady, runeType

	for i = 1, 6 do
		runeType = GetRuneType(i)

		-- blood = (runeType == 1 and remaining < blood) and remaining or blood
		-- death = (runeType == 4 and remaining < death) and remaining or death
		-- frost = (runeType == 3 and remaining < frost) and remaining or frost
		-- unholy = (runeType == 2 and remaining < unholy) and remaining or unholy

		if runeType == 1 or runeType == 4 then
			start, duration, runeReady = GetRuneCooldown(i)
			remaining = runeReady and 0 or (start and (cd - (GetTime() - start)) or 0)
			tmin = (tmin and remaining <= tmin) and remaining or tmin
			tmax = (tmax and remaining >= tmax) and remaining or tmax
		end
	end

	return tmin > 0 and tmin or 0, tmax > 0 and tmax or 0, cd
end
xminRuneCooldown = xVermin.minRuneCooldown

xVermin.PestilenceSS = function()
	if xVermin.Class ~= 'DEATHKNIGHT' then
		return false
	end

	if not UnitExists('target') then
		return false
	end

	local tmin, tmax, cd = xminRuneCooldown()
	local debuff_ff = 30
	local debuff_ps = 30
	local debuff_duration = 30
	local grace = 2

	for i = 1, 40 do
		local name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, _, spellId, canApplyAura, isBossAura = UnitDebuff('target', i)
		if name and (name == 'Frost Fever' or name == 'Blood Plague') and unitCaster == 'player' then
			local remaining = expirationTime - GetTime()
			debuff_duration = remaining < debuff_duration and remaining or debuff_duration
		end
	end

	if debuff_duration < cd - grace and debuff_duration > tmin then
		return true
	else
		return false
	end
end

xPestilenceSS = xVermin.PestilenceSS
