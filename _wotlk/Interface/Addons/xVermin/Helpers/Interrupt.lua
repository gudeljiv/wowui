local _, xVermin = ...

local HandleRotationFrame = function(on)
	if on then
		RotationFrame3:SetBackdropColor(0, 1, 0, 1)
	else
		RotationFrame3:SetBackdropColor(1, 1, 1, 1)
	end
	return
end

local HandleUnit = function(unit)
	if xVermin.IfUnitIsCastingInteruptable(unit) then
		-- WARRIOR INTERRUPT
		if (xVermin.Class == 'WARRIOR') then
			local _, battle = GetShapeshiftFormInfo(1) -- ako je battle stance
			local _, defensive = GetShapeshiftFormInfo(2) -- ako je defensive stance
			local _, berserker = GetShapeshiftFormInfo(3) -- ako je berserker stance
			if IsSpellInRange('Pummel', unit) == 1 and select(2, GetSpellCooldown('Pummel')) == 0 then
				HandleRotationFrame(true)
			end
			-- if defensive then
			-- 	if IsSpellInRange('Shield Bash', unit) == 1 and select(2, GetSpellCooldown('Shield Bash')) == 0 then
			-- 		HandleRotationFrame(true)
			-- 	end
			-- end
			-- if berserker then
			-- 	if IsSpellInRange('Pummel', unit) == 1 and select(2, GetSpellCooldown('Pummel')) == 0 then
			-- 		HandleRotationFrame(true)
			-- 	end
			-- end
			-- if battle and IsEquippedItemType('Shields') then
			-- 	if IsSpellInRange('Shield Bash', unit) == 1 and select(2, GetSpellCooldown('Shield Bash')) == 0 then
			-- 		HandleRotationFrame(true)
			-- 	end
			-- end
		end

		-- PALADIN INTERRUPT
		if (xVermin.Class == 'PALADIN') then
			if select(2, GetSpellCooldown('Rebuke')) == 0 and CheckInteractDistance(unit, 3) then
				HandleRotationFrame(true)
			end
		end

		-- DRUID INTERRUPT
		if (xVermin.Class == 'DRUID') then
			local _, bear = GetShapeshiftFormInfo(1) -- ako je bear form
			local _, aquatic = GetShapeshiftFormInfo(2) -- ako je aquatic form
			local _, cat = GetShapeshiftFormInfo(3) -- ako je cat form
			local _, travel = GetShapeshiftFormInfo(4) -- ako je travel form
			local _, moonkin = GetShapeshiftFormInfo(5) -- ako je moonkin form
			local _, tree = GetShapeshiftFormInfo(6) -- ako je tree form
			if (bear or cat) and select(2, GetSpellCooldown('Skull Bash')) == 0 and CheckInteractDistance(unit, 3) then
				HandleRotationFrame(true)
			end
		-- if cat and select(2, GetSpellCooldown('Maim')) == 0 and CheckInteractDistance(unit, 3) then
		-- 	HandleRotationFrame(true)
		-- end
		end

		-- DEATHKNIGHT INTERRUPT
		if xVermin.Class == 'DEATHKNIGHT' then
			if select(2, GetSpellCooldown('Mind Freeze')) == 0 and IsSpellInRange('Mind Freeze', unit) == 1 then
				HandleRotationFrame(true)
			end
		end

		-- SHAMAN INTERRUPT
		if xVermin.Class == 'SHAMAN' then
			if select(2, GetSpellCooldown('Wind Shear')) == 0 and IsSpellInRange('Wind Shear', unit) == 1 then
				HandleRotationFrame(true)
			end
		end

		-- HUNTER INTERRUPT
		if xVermin.Class == 'HUNTER' then
			if select(2, GetSpellCooldown('Silencing Shot')) == 0 and IsSpellInRange('Silencing Shot', unit) == 1 then
				HandleRotationFrame(true)
			end
			if select(2, GetSpellCooldown('Intimidation')) == 0 and IsSpellInRange('Intimidation', unit) == 1 then
				HandleRotationFrame(true)
			end
		end
	else
		HandleRotationFrame(false)
	end
end

-- CheckInteractDistance
-- 1 = Inspect, 28 yards
-- 2 = Trade, 11.11 yards
-- 3 = Duel, 9.9 yards
-- 4 = Follow, 28 yards
UIParent:HookScript(
	'OnUpdate',
	function(self)
		if UnitExists('focus') then
			HandleUnit('focus')
		elseif UnitExists('target') then
			HandleUnit('target')
		else
			return
		end
	end
)
