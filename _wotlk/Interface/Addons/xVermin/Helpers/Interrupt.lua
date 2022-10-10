local _, xVermin = ...

-- CheckInteractDistance
-- 1 = Inspect, 28 yards
-- 2 = Trade, 11.11 yards
-- 3 = Duel, 9.9 yards
-- 4 = Follow, 28 yards
TargetFrame:HookScript(
	'OnUpdate',
	function(self)
		if xVermin.IfUnitIsCastingInteruptable('target') then
			-- WARRIOR INTERRUPT
			if (xVermin.Class == 'WARRIOR') then
				local _, battle = GetShapeshiftFormInfo(1) -- ako je battle stance
				local _, defensive = GetShapeshiftFormInfo(2) -- ako je defensive stance
				local _, berserker = GetShapeshiftFormInfo(3) -- ako je berserker stance
				if defensive then
					if IsSpellInRange('Shield Bash', 'target') and not GetSpellCooldown('Shield Bash') then
						RotationFrame2:SetBackdropColor(0, 1, 0, 1)
					end
				end
				if berserker then
					if IsSpellInRange('Pummel', 'target') and not GetSpellCooldown('Pummel') then
						RotationFrame2:SetBackdropColor(0, 1, 0, 1)
					end
				end
				if battle and IsEquippedItemType('Shields') then
					if IsSpellInRange('Shield Bash', 'target') and not GetSpellCooldown('Shield Bash') then
						RotationFrame2:SetBackdropColor(0, 1, 0, 1)
					end
				end
			end

			-- PALADIN INTERRUPT
			if (xVermin.Class == 'PALADIN') then
				if not GetSpellCooldown('Arcane Torrent') and CheckInteractDistance('target', 3) then
					RotationFrame2:SetBackdropColor(0, 1, 0, 1)
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
				if bear and not GetSpellCooldown('Bash') and CheckInteractDistance('target', 3) then
					RotationFrame2:SetBackdropColor(0, 1, 0, 1)
				end
			end

			-- DEATHKNIGHT INTERRUPT
			if (xVermin.Class == 'DEATHKNIGHT') then
				if not GetSpellCooldown('Mind Freeze') and IsSpellInRange('Mind Freeze', 'target') then
					RotationFrame2:SetBackdropColor(0, 1, 0, 1)
				end
			end

			-- HUNTER INTERRUPT
			if (xVermin.Class == 'HUNTER') then
				if not GetSpellCooldown('Silencing Shot') and IsSpellInRange('Silencing Shot', 'target') then
					RotationFrame2:SetBackdropColor(0, 1, 0, 1)
				end
			end
		else
			RotationFrame2:SetBackdropColor(1, 1, 1, 1)
		end
	end
)
