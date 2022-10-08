local _, xVermin = ...

-- CheckInteractDistance
-- 1 = Inspect, 28 yards
-- 2 = Trade, 11.11 yards
-- 3 = Duel, 9.9 yards
-- 4 = Follow, 28 yards
TargetFrame:HookScript(
	'OnUpdate',
	function(self)
		local name_casting, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible_casting, spellId = UnitCastingInfo('target')
		local name_channeling, text, texture, startTimeMS, endTimeMS, isTradeSkill, notInterruptible_chanelling, spellId = UnitChannelInfo('target')
		if (name_casting ~= nil and not notInterruptible_casting) or (name_channeling ~= nil and not notInterruptible_chanelling) then
			-- WARRIOR INTERRUPT
			if (select(2, UnitClass('player')) == 'WARRIOR') then
				local _, battle = GetShapeshiftFormInfo(1) -- ako je battle stance
				local _, defensive = GetShapeshiftFormInfo(2) -- ako je defensive stance
				local _, berserker = GetShapeshiftFormInfo(3) -- ako je berserker stance
				if defensive then
					if IsSpellInRange('Shield Bash', 'target') == 1 and GetSpellCooldown('Shield Bash') == 0 then
						RotationFrame2:SetBackdropColor(0, 1, 0, 1)
					end
				end
				if berserker then
					if IsSpellInRange('Pummel', 'target') == 1 and GetSpellCooldown('Pummel') == 0 then
						RotationFrame2:SetBackdropColor(0, 1, 0, 1)
					end
				end
				if battle and IsEquippedItemType('Shields') then
					if IsSpellInRange('Shield Bash', 'target') == 1 and GetSpellCooldown('Shield Bash') == 0 then
						RotationFrame2:SetBackdropColor(0, 1, 0, 1)
					end
				end
			end

			-- PALADIN INTERRUPT
			if (select(2, UnitClass('player')) == 'PALADIN') then
				if GetSpellCooldown('Arcane Torrent') == 0 and CheckInteractDistance('target', 3) then
					RotationFrame2:SetBackdropColor(0, 1, 0, 1)
				end
			end

			-- DRUID INTERRUPT
			if (select(2, UnitClass('player')) == 'DRUID') then
				local _, bear = GetShapeshiftFormInfo(1) -- ako je bear form
				local _, aquatic = GetShapeshiftFormInfo(2) -- ako je aquatic form
				local _, cat = GetShapeshiftFormInfo(3) -- ako je cat form
				local _, travel = GetShapeshiftFormInfo(4) -- ako je travel form
				local _, moonkin = GetShapeshiftFormInfo(5) -- ako je moonkin form
				local _, tree = GetShapeshiftFormInfo(6) -- ako je tree form
				if bear and GetSpellCooldown('Bash') == 0 and CheckInteractDistance('target', 3) then
					RotationFrame2:SetBackdropColor(0, 1, 0, 1)
				end
			end

			-- DEATHKNIGHT INTERRUPT
			if (select(2, UnitClass('player')) == 'DEATHKNIGHT') then
				if GetSpellCooldown('Mind Freeze') == 0 and IsSpellInRange('Mind Freeze', 'target') then
					RotationFrame2:SetBackdropColor(0, 1, 0, 1)
				end
			end

			-- HUNTER INTERRUPT
			if (select(2, UnitClass('player')) == 'HUNTER') then
				if GetSpellCooldown('Silencing Shot') == 0 and IsSpellInRange('Silencing Shot', 'target') then
					RotationFrame2:SetBackdropColor(0, 1, 0, 1)
				end
			end
		else
			RotationFrame2:SetBackdropColor(1, 1, 1, 1)
		end
	end
)

-- local function Interrupt()
-- 	local name_casting, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible_casting, spellId = UnitCastingInfo('target')
-- 	local name_channeling, text, texture, startTimeMS, endTimeMS, isTradeSkill, notInterruptible_chanelling, spellId = UnitChannelInfo('target')
-- 	if (name_casting ~= nil and not notInterruptible_casting) or (name_channeling ~= nil and not notInterruptible_chanelling) then
-- 		-- print(name, name and not notInterruptible)
-- 		-- WARRIOR INTERRUPT
-- 		if (select(2, UnitClass('player')) == 'WARRIOR') then
-- 			local _, battle = GetShapeshiftFormInfo(1) -- ako je battle stance
-- 			local _, defensive = GetShapeshiftFormInfo(2) -- ako je defensive stance
-- 			local _, berserker = GetShapeshiftFormInfo(3) -- ako je berserker stance
-- 			if defensive then
-- 				if IsSpellInRange('Shield Bash', 'target') == 1 and GetSpellCooldown('Shield Bash') == 0 then
-- 					RotationFrame2:SetBackdropColor(0, 1, 0, 1)
-- 				end
-- 			end
-- 			if berserker then
-- 				if IsSpellInRange('Pummel', 'target') == 1 and GetSpellCooldown('Pummel') == 0 then
-- 					RotationFrame2:SetBackdropColor(0, 1, 0, 1)
-- 				end
-- 			end
-- 			if battle and IsEquippedItemType('Shields') then
-- 				if IsSpellInRange('Shield Bash', 'target') == 1 and GetSpellCooldown('Shield Bash') == 0 then
-- 					RotationFrame2:SetBackdropColor(0, 1, 0, 1)
-- 				end
-- 			end
-- 		end

-- 		-- PALADIN INTERRUPT
-- 		if (select(2, UnitClass('player')) == 'PALADIN') then
-- 			if GetSpellCooldown('Arcane Torrent') == 0 and CheckInteractDistance('target', 3) then
-- 				RotationFrame2:SetBackdropColor(0, 1, 0, 1)
-- 			end
-- 		end

-- 		-- DRUID INTERRUPT
-- 		if (select(2, UnitClass('player')) == 'DRUID') then
-- 			local _, bear = GetShapeshiftFormInfo(1) -- ako je bear form
-- 			local _, aquatic = GetShapeshiftFormInfo(2) -- ako je aquatic form
-- 			local _, cat = GetShapeshiftFormInfo(3) -- ako je cat form
-- 			local _, travel = GetShapeshiftFormInfo(4) -- ako je travel form
-- 			local _, moonkin = GetShapeshiftFormInfo(5) -- ako je moonkin form
-- 			local _, tree = GetShapeshiftFormInfo(6) -- ako je tree form
-- 			if bear and GetSpellCooldown('Bash') == 0 and CheckInteractDistance('target', 3) then
-- 				RotationFrame2:SetBackdropColor(0, 1, 0, 1)
-- 			end
-- 		end

-- 		-- DEATHKNIGHT INTERRUPT
-- 		if (select(2, UnitClass('player')) == 'DEATHKNIGHT') then
-- 			if GetSpellCooldown('Mind Freeze') == 0 and IsSpellInRange('Mind Freeze', 'target') then
-- 				RotationFrame2:SetBackdropColor(0, 1, 0, 1)
-- 			end
-- 		end
-- 	else
-- 		RotationFrame2:SetBackdropColor(1, 1, 1, 1)
-- 	end
-- end

-- local f = CreateFrame('Frame')
-- f:RegisterEvent('UNIT_SPELLCAST_START')
-- f:RegisterEvent('UNIT_SPELLCAST_CHANNEL_START')
-- -- f:RegisterEvent('UNIT_SPELLCAST_INTERRUPTIBLE')
-- f:SetScript('OnEvent', Interrupt)
