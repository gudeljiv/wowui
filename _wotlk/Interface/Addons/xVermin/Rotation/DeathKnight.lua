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

xVermin.minRuneCooldownForPestilence = function()
	local tmin_cd = InCombatLockdown() and 7.5 or 10
	local tmax_cd = InCombatLockdown() and 7.5 or 10
	local tmin_cd_overall = 10

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
			if runeType == 4 then
				tmin_cd = 10
				tmax_cd = 10
			end
			remaining = runeReady and 0 or (start and (tmin_cd - (GetTime() - start)) or 0)

			if tmin and remaining <= tmin then
				if runeType == 4 and InCombatLockdown() then
					tmin_cd = 10
				end
				tmin = remaining
			end

			if tmax and remaining >= tmax then
				if runeType == 4 and InCombatLockdown() then
					tmax_cd = 10
				end
				tmax = remaining
			end

			tmin_cd_overall = tmin_cd < tmin_cd_overall and tmin_cd or tmin_cd_overall
		end
	end

	return tmin > 0 and tmin or 0, tmax > 0 and tmax or 0, tmin_cd_overall, tmax_cd
end

xVermin.minRuneForPestilenceCount = function(debuff_duration)
	local remaining, start, duration, runeReady, runeType
	local tmin_cd = InCombatLockdown() and 7.5 or 10

	local ready_runes_incoming = 0
	local ready_runes = 0

	for i = 1, 6 do
		runeType = GetRuneType(i)

		if runeType == 1 or runeType == 4 then
			if runeType == 4 then
				tmin_cd = 10
			end
			start, duration, runeReady = GetRuneCooldown(i)
			remaining = runeReady and 0 or (start and (tmin_cd - (GetTime() - start)) or 0)

			if remaining == 0 then
				ready_runes = ready_runes + 1
			end
			if remaining < debuff_duration then
				ready_runes_incoming = ready_runes_incoming + 1
			end
		end
	end

	return ready_runes, ready_runes_incoming
end

local pf = CreateFrame('Frame', 'pf')
pf:SetPoint('CENTER', UIParent, 'CENTER', 200, 250)
pf:SetWidth(50)
pf:SetHeight(50)
pf.text = pf:CreateFontString(pf:GetName() .. 'Title', 'BACKGROUND')
pf.text:SetFont(xVermin.Config.font.arial, 18, 'NONE')
pf.text:SetPoint('CENTER', pf, 'CENTER', 0, 0)
pf.text:SetTextColor(xVermin.ClassColor.r, xVermin.ClassColor.g, xVermin.ClassColor.b, 1)

xVermin.PestilenceSS = function()
	if xVermin.Class ~= 'xDEATHKNIGHT' then
		return false
	end

	if not UnitExists('target') then
		return false
	end

	local blood, frost, unholy, death = xVermin.RuneCount()
	local debuff_ff = 30
	local debuff_ps = 30
	local debuff_duration = 30
	local grace = 2
	local ready_runes = 0
	local ready_runes_incoming = 0
	local target_has_frost_fever = false
	local target_has_blood_plague = false

	for i = 1, 40 do
		local name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, _, spellId, canApplyAura, isBossAura = UnitDebuff('target', i)
		if name and (name == 'Frost Fever' or name == 'Blood Plague') and unitCaster == 'player' then
			local remaining = expirationTime - GetTime()
			debuff_duration = remaining < debuff_duration and remaining or debuff_duration
		end
		if name and name == 'Frost Fever' then
			target_has_frost_fever = true
		end
		if name and name == 'Blood Plague' then
			target_has_blood_plague = true
		end
	end

	-- pf.text:SetText('debuff duration: ' .. xVermin.FormatNumberDecimal(debuff_duration, 2) .. '\nready runes: ' .. ready_runes .. '\nincoming runes: ' .. ready_runes_incoming)

	ready_runes, ready_runes_incoming = xVermin.minRuneForPestilenceCount(debuff_duration)
	-- print(ready_runes, ready_runes_incoming)

	if debuff_duration ~= 30 and target_has_frost_fever and target_has_blood_plague and debuff_duration < 10 then
		-- pf.text:SetText('debuff duration: ' .. xVermin.FormatNumberDecimal(debuff_duration, 2) .. '\nready runes: ' .. ready_runes .. '\nincoming runes: ' .. ready_runes_incoming)
		-- if tmin > debuff_duration and debuff_duration > tmin_cd then
		-- 	return false
		-- end
		-- if tmin < debuff_duration and debuff_duration < tmin_cd then
		-- 	return true
		-- end
		-- if debuff_duration - tmin > 0 and debuff_duration < tmin_cd then
		-- 	return true
		-- else
		-- 	pf.text:SetText('false\n' .. 'debuff: ' .. xVermin.FormatNumberDecimal(debuff_duration, 2) .. '\n' .. 'tmin: ' .. xVermin.FormatNumberDecimal(tmin, 2) .. ' - ' .. xVermin.FormatNumberDecimal(tmin_cd, 2) .. '\n' .. blood .. '\n' .. death)
		-- end
		-- pf.text:SetText('true\n' .. 'debuff: ' .. xVermin.FormatNumberDecimal(debuff_duration, 2) .. '\n' .. 'tmin: ' .. xVermin.FormatNumberDecimal(tmin, 2) .. ' - ' .. xVermin.FormatNumberDecimal(tmin_cd, 2) .. '\n' .. blood .. ' - ' .. death .. '\n' .. ready_runes .. ' - ' .. ready_runes_incoming)
		-- print('true || ' .. 'debuff: ' .. xVermin.FormatNumberDecimal(debuff_duration, 2) .. ' || ' .. 'tmin: ' .. xVermin.FormatNumberDecimal(tmin, 2) .. ' - ' .. xVermin.FormatNumberDecimal(tmin_cd, 2) .. ' || ' .. blood .. ' - ' .. death .. ' || ' .. ready_runes .. ' - ' .. ready_runes_incoming)
		-- if (ready_runes_incoming and not ready_runes and debuff_duration < tmin_cd) or debuff_duration < 4 then
		-- 	return true
		-- end
		-- if (not ready_runes_incoming and ready_runes and debuff_duration < tmin_cd) or debuff_duration < 4 then
		-- 	return true
		-- end
		-- if debuff_duration < -1 then
		-- 	if frost < 1 and unholy < 1 then
		-- 		if ready_runes_incoming or ready_runes then
		-- 			return true
		-- 		end
		-- 	end
		-- 	if (frost > 1 and unholy < 1 and blood + death < 1) or (frost < 1 and unholy > 1 and blood + death < 1) then
		-- 		if ready_runes_incoming or ready_runes then
		-- 			return true
		-- 		end
		-- 	end
		-- end
		if ready_runes_incoming + ready_runes < 2 or debuff_duration < 3 then
			print('true')
			return true
		end
	end

	print('false')
	return false
end
xPestilenceSS = xVermin.PestilenceSS

-- UIParent:HookScript('OnUpdate', xPestilenceSS)
