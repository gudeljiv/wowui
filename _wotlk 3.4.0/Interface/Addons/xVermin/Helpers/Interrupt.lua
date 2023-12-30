local _, xVermin = ...

-- CheckInteractDistance
-- 1 = Inspect, 28 yards
-- 2 = Trade, 11.11 yards
-- 3 = Duel, 9.9 yards
-- 4 = Follow, 28 yards
UIParent:HookScript(
	'OnUpdate',
	function(self)
		if UnitExists('target') and xVermin.IfUnitIsCastingInteruptable('target') then
			-- WARRIOR INTERRUPT
			if (xVermin.Class == 'WARRIOR') then
				local _, battle = GetShapeshiftFormInfo(1) -- ako je battle stance
				local _, defensive = GetShapeshiftFormInfo(2) -- ako je defensive stance
				local _, berserker = GetShapeshiftFormInfo(3) -- ako je berserker stance
				if defensive then
					if IsSpellInRange('Shield Bash', 'target') == 1 and select(2, GetSpellCooldown('Shield Bash')) == 0 then
						RotationFrame3:SetBackdropColor(0, 1, 0, 1)
					end
				end
				if berserker then
					if IsSpellInRange('Pummel', 'target') == 1 and select(2, GetSpellCooldown('Pummel')) == 0 then
						RotationFrame3:SetBackdropColor(0, 1, 0, 1)
					end
				end
				if battle and IsEquippedItemType('Shields') then
					if IsSpellInRange('Shield Bash', 'target') == 1 and select(2, GetSpellCooldown('Shield Bash')) == 0 then
						RotationFrame3:SetBackdropColor(0, 1, 0, 1)
					end
				end
			end

			-- PALADIN INTERRUPT
			if (xVermin.Class == 'PALADIN') then
				if select(2, GetSpellCooldown('Arcane Torrent')) == 0 and CheckInteractDistance('target', 3) then
					RotationFrame3:SetBackdropColor(0, 1, 0, 1)
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
				if bear and select(2, GetSpellCooldown('Bash')) == 0 and CheckInteractDistance('target', 3) then
					RotationFrame3:SetBackdropColor(0, 1, 0, 1)
				end
			-- if cat and select(2, GetSpellCooldown('Maim')) == 0 and CheckInteractDistance('target', 3) then
			-- 	RotationFrame3:SetBackdropColor(0, 1, 0, 1)
			-- end
			end

			-- DEATHKNIGHT INTERRUPT
			if (xVermin.Class == 'DEATHKNIGHT') then
				if select(2, GetSpellCooldown('Mind Freeze')) == 0 and IsSpellInRange('Mind Freeze', 'target') == 1 then
					RotationFrame3:SetBackdropColor(0, 1, 0, 1)
				end
			end

			-- SHAMAN INTERRUPT
			if (xVermin.Class == 'SHAMAN') then
				if select(2, GetSpellCooldown('Wind Shear')) == 0 and IsSpellInRange('Wind Shear', 'target') == 1 then
					RotationFrame3:SetBackdropColor(0, 1, 0, 1)
				end
			end

			-- HUNTER INTERRUPT
			if (xVermin.Class == 'HUNTER') then
				if select(2, GetSpellCooldown('Silencing Shot')) == 0 and IsSpellInRange('Silencing Shot', 'target') == 1 then
					RotationFrame3:SetBackdropColor(0, 1, 0, 1)
				end
				if select(2, GetSpellCooldown('Intimidation')) == 0 and IsSpellInRange('Intimidation', 'target') == 1 then
					RotationFrame3:SetBackdropColor(0, 1, 0, 1)
				end
			end
		else
			RotationFrame3:SetBackdropColor(1, 1, 1, 1)
		end
	end
)
