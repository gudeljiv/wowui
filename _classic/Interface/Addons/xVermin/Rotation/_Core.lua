local _, xVermin = ...

-- function Rotation.AOE(type)
-- 	local type = type or 'bool'
-- 	local inRange = 0

-- 	for i = 1, 40 do
-- 		if UnitExists('nameplate' .. i) and IsSpellInRange('Cleave', 'nameplate' .. i) == 1 then
-- 			inRange = inRange + 1
-- 		end
-- 	end
-- 	if type == 'bool' then
-- 		if inRange > 1 then
-- 			return true
-- 		else
-- 			return false
-- 		end
-- 	end
-- 	if type == 'number' then
-- 		return inRange
-- 	end
-- end

xVermin.CheckDebuff = function(input, unit)
	unit = unit and unit or 'target'
	for i = 1, 40 do
		local name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, _, spellId, canApplyAura, isBossAura = UnitDebuff(unit, i)
		if name then
			if name == input or spellId == input then
				return false
			else
				return true
			end
		end
	end
end

xVermin.CheckBuff = function(input, unit)
	unit = unit and unit or 'target'
	for i = 1, 40 do
		local name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, _, spellId, canApplyAura, isBossAura = UnitBuff('target', i)
		if buff then
			if name == input or spellId == input then
				return false
			else
				return true
			end
		end
	end
end
