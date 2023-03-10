local _, xVermin = ...

xRTF(1, 1, aura_env.nextAction)

local DKrot = function()
	local lastAction = aura_env.nextAction
	local timeNow = GetTime()
	aura_env.varFlag2 = false

	if aura_env.fixedGCD < 0 then
		aura_env.fixedGCD = 1.5
	end

	aura_env.gcdFreeWhen = aura_env.gcdWhen - timeNow
	if aura_env.gcdFreeWhen < 0 then
		aura_env.gcdFreeWhen = 0
	end

	for i = 1, 6 do
		aura_env.runes[i].cd = aura_env.runes[i].when - timeNow - aura_env.gcdFreeWhen
		if aura_env.runes[i].cd < -(2.45) then
			aura_env.runes[i].cd = -2.45
		end
	end
	local KM, rime, HoWTimer, totem, UA1, BT1, speed = aura_env.trackB_frost()
	local ff, uh = aura_env.trackD_frost()

	local expire = 20
	if ff < uh then
		expire = ff
	else
		expire = uh
	end
	expire = expire - aura_env.gcdFreeWhen
	if expire < -0.1 then
		expire = -0.1
	end
	ff = ff - aura_env.gcdFreeWhen
	uh = uh - aura_env.gcdFreeWhen
	if ff < -0.1 then
		ff = -0.1
	end
	if uh < -0.1 then
		uh = -0.1
	end

	-- print("ff: "..tostring(ff).." / uh: "..tostring(uh))
	-- print("gcdFreeWhen:" .. tostring(aura_env.gcdFreeWhen))

	KM = KM - aura_env.gcdFreeWhen - aura_env.config.reaction / 1000
	HoWTimer = HoWTimer - aura_env.gcdFreeWhen - aura_env.config.reaction / 1000
	UA1 = UA1 - aura_env.gcdFreeWhen - aura_env.config.reaction / 1000
	speed = speed - aura_env.gcdFreeWhen - aura_env.config.reaction / 1000
	if speed < 0 then
		speed = 0
	end
	if BT1 then
		BT1 = BT1 - aura_env.gcdFreeWhen - aura_env.config.reaction / 1000
	end
	if rime then
		rime = rime - aura_env.gcdFreeWhen - aura_env.config.reaction / 1000
	end

	if KM < 0 then
		KM = 0
	end
	if rime < 0 then
		rime = 0
	end
	if HoWTimer < 0 then
		HoWTimer = 0
	end
	if UA1 < 0 then
		UA1 = 0
	end
	if BT1 < 0 then
		BT1 = 0
	end

	aura_env.rime = rime
	aura_env.KM = KM
	aura_env.HoWTimer = KM

	local cut = 100 / 1000 + aura_env.config.reaction / 1000

	local a = (aura_env.runes[3].cd + cut > aura_env.runes[5].cd and aura_env.runes[3].cd - cut < aura_env.runes[5].cd) or (aura_env.runes[3].cd + cut > aura_env.runes[6].cd and aura_env.runes[3].cd - cut < aura_env.runes[6].cd)
	local b = (aura_env.runes[4].cd + cut > aura_env.runes[5].cd and aura_env.runes[4].cd - cut < aura_env.runes[5].cd) or (aura_env.runes[4].cd + cut > aura_env.runes[6].cd and aura_env.runes[4].cd - cut < aura_env.runes[6].cd)

	if aura_env.lastCastID == 47568 then
		aura_env.desyncCounter = 2
	end

	if (a and b) or aura_env.desyncCounter >= 2 or aura_env.subUH then
		aura_env.desync = false
	else
		aura_env.desync = true
	end

	if aura_env.desyncFlag == false then
		aura_env.desync = false
	end
	if aura_env.subUH then
		aura_env.desync = true
	end
	local desync = aura_env.desync

	local bn, fn, un, bl, fl, ul, dn, dl = 0
	local d1, d2 = 20
	if (aura_env.runes[1].cd) > (aura_env.runes[2].cd) then
		bn = 2
		bl = 1
	else
		bn = 1
		bl = 2
	end
	if (aura_env.runes[3].cd) > (aura_env.runes[4].cd) then
		un = 4
		ul = 3
	else
		un = 3
		ul = 4
	end
	if (aura_env.runes[5].cd) > (aura_env.runes[6].cd) then
		fn = 6
		fl = 5
	else
		fn = 5
		fl = 6
	end

	if GetRuneType(1) == 4 then
		d1 = aura_env.runes[1].cd
	end
	if GetRuneType(2) == 4 then
		d2 = aura_env.runes[2].cd
	end

	local flCap = aura_env.runes[fl].cd
	if flCap < 0 then
		flCap = 0
	end
	local fnCap = aura_env.runes[fn].cd
	if fnCap < 0 then
		fnCap = 0
	end

	local ulCap = aura_env.runes[ul].cd
	if ulCap < 0 then
		ulCap = 0
	end
	local unCap = aura_env.runes[un].cd
	if unCap < 0 then
		unCap = 0
	end

	local blCap = aura_env.runes[bl].cd
	if blCap < 0 then
		blCap = 0
	end
	local bnCap = aura_env.runes[bn].cd
	if bnCap < 0 then
		bnCap = 0
	end

	local obWhen, obTimer, rune1Tag, rune2Tag = aura_env.obFunction_frost()

	local durationUA = aura_env.UAcast + 60 - timeNow - aura_env.gcdFreeWhen + aura_env.config.reaction / 1000
	local durationBT = aura_env.BTcast + 60 - timeNow - aura_env.gcdFreeWhen + aura_env.config.reaction / 1000
	local startERW, durationERW = GetSpellCooldown(47568)
	--erw

	local durationH = aura_env.HoWcast + 20 - timeNow - aura_env.gcdFreeWhen + aura_env.config.reaction / 1000
	aura_env.durationH = durationH

	aura_env.OBwhen = obWhen

	if not UnitAffectingCombat('player') then
		-- ADD HOW
		aura_env.desyncCounter = 0
		aura_env.combatStart = timeNow

		lastAction = ''
		aura_env.totemDetected = false
		if not UnitCanAttack('player', 'target') and aura_env.config.oocHide then
			aura_env.nextAction = 'clear'
		elseif HoWTimer < 30 and not totem and durationH <= 0 then
			aura_env.nextAction = 'HOW'
		else
			aura_env.nextAction = 'IT'
		end
		WeakAuras.ScanEvents('fonsas_UA', false)
		WeakAuras.ScanEvents('fonsas_ERW_frost', false)
		WeakAuras.ScanEvents('fonsas_Pesti_ERW_frost', false)
		WeakAuras.ScanEvents('fonsas_pes_drop', false)
	else
		if totem then
			aura_env.totemDetected = true
		end

		local pestiBT = false
		local oblitBT = false
		local a = (aura_env.runeUse == 1 or aura_env.runeUse == 2)
		if aura_env.runeUse ~= 1 and aura_env.runeUse ~= 2 and aura_env.lastCastID == 51271 then
			oblitBT = true
		elseif aura_env.lastCastID == 51271 and a then
			pestiBT = true
		end

		if (ff > 0.05 and uh > 0.05 and oblitBT and durationBT <= 1.5) and false then
			aura_env.nextAction = 'BT_full'
			WeakAuras.ScanEvents('fonsas_pes_drop', false)
		elseif (ff > 0.06 and uh > 0.06 and oblitBT == false) or (aura_env.TTD - aura_env.fixedGCD + aura_env.gcdFreeWhen < aura_env.config.disDropTime) then
			local canOb = false
			local a = aura_env.runes[bl].cd

			local tolerance = obTimer
			local temp = 0
			--print("obWhen:" .. tostring(obWhen) .. " is it static?")
			if obWhen > 0 then
				temp = obWhen
			else
				temp = 0
			end
			aura_env.oblitWhen = temp

			if UA1 > obTimer + 0.1 and rime <= 0.05 and KM <= 0.05 then
				tolerance = obTimer
			end
			if UA1 > obWhen + 0.2 and UA1 <= obTimer and rune1Tag + rune2Tag ~= 3 then
				tolerance = 0
			end

			--print("UA1 "..tostring(UA1))

			if timeNow - aura_env.ERWcounter - aura_env.gcdFreeWhen > 7 and timeNow - aura_env.ERWcounter - aura_env.gcdFreeWhen < 14 then
				tolerance = 0
			end

			local runeGraceERW = aura_env.ERWcounter - timeNow - aura_env.gcdFreeWhen

			local runeGraceERWflag = true
			if runeGraceERW < -4.5 then
				runeGraceERWflag = false
			else
				WeakAuras.ScanEvents('fonsas_RD2', false)
			end
			if runeGraceERW < -2.5 then
				runeGraceERW = -2.5
			else
				tolerance = 0
			end
			local pesDrop = false

			if (temp <= expire + aura_env.fixedGCD + (aura_env.config.reaction / 1000)) and not (aura_env.TTD - aura_env.fixedGCD + aura_env.gcdFreeWhen < aura_env.config.disDropTime) then
				if rune1Tag == 1 or rune1Tag == 2 or rune2Tag == 1 or rune2Tag == 2 then
					if rune1Tag + rune2Tag == 3 then
						if (expire - temp > 10 + runeGraceERW) or (expire > 10 + aura_env.runes[bn].cd + 0.2 and expire > obWhen + tolerance + 10 + aura_env.runes[bl].cd) then
							canOb = true

							if (rime > 0.5 or KM > 0.5 or UnitPower('player') > 105) and expire > 7.5 + (aura_env.config.reaction / 1000) * 4 and not aura_env.subUH then
								tolerance = expire - 7.5 - (aura_env.config.reaction / 1000) * 4
							end
						end
					elseif expire - temp > blCap and expire - temp > aura_env.config.reaction / 1000 * 5 + aura_env.fixedGCD then
						canOb = true
					end
				elseif expire - temp > aura_env.config.reaction / 1000 * 5 + aura_env.fixedGCD then
					canOb = true
				end
			elseif (aura_env.TTD - aura_env.fixedGCD + aura_env.gcdFreeWhen < aura_env.config.disDropTime) then
				canOb = true
				pesDrop = true
			end

			if pesDrop and aura_env.runes[bn].cd < 0 and expire < 4 and expire > 0 then
				WeakAuras.ScanEvents('fonsas_pes_drop', true)
			else
				WeakAuras.ScanEvents('fonsas_pes_drop', false)
			end

			if canOb then
				local highest = 0
				if obWhen > tolerance then
					highest = obWhen
				else
					highest = tolerance
				end
				if highest <= aura_env.fixedGCD + (aura_env.config.reaction / 1000) * 2 then --aura_env.fixedGCD
					if rime > 0.1 and not desync then
						aura_env.nextAction = 'HB'
					else
						aura_env.nextAction = 'OB'
					end
				else
					local a = (rime > 0.1) and (aura_env.OBwhen + tolerance <= aura_env.fixedGCD + aura_env.gcdFreeWhen + (aura_env.config.reaction / 1000) * 2)

					local start, duration = GetSpellCooldown(57330)
					local startG, durationG = GetSpellCooldown(46584)

					if HoWTimer < 10 and not aura_env.totemDetected and durationH <= 0 then
						--elseif UnitPower("player")>=aura_env.FSRP and KM>0 and not a then
						--    aura_env.nextAction="FS"
						aura_env.nextAction = 'HOW'
					elseif rime > 0.1 and KM > 0.1 and (UnitPower('player') < 121) then
						aura_env.nextAction = 'HB'
					elseif rime > 0.1 and KM > 0.1 and UnitPower('player') >= aura_env.FSRP then
						aura_env.nextAction = 'FS'
					elseif
						((desync and (UA1 < 20 - aura_env.fixedGCD - 1.8) and durationERW <= 2.5) or (desync and durationERW > 2.5) or (timeNow + aura_env.gcdFreeWhen - aura_env.combatStart > 4 and UA1 < 20 - aura_env.fixedGCD - 0.5) and durationERW <= 2.5) and aura_env.runes[bn].cd - aura_env.fixedGCD <= (aura_env.config.reaction / 1000) - 2.5 and bn ~= rune1Tag and
							bn ~= rune2Tag
					 then
						local alpha = 0
						if aura_env.runes[bl].cd + aura_env.config.reaction / 1000 > aura_env.fixedGCD + aura_env.gcdFreeWhen then
							alpha = aura_env.runes[bl].cd + aura_env.config.reaction / 1000
						else
							alpha = aura_env.fixedGCD + aura_env.gcdFreeWhen
						end

						local obWhenNN, obTimerNN, rune1TagNN, rune2TagNN = aura_env.obFunctionNextNext_frost(rune1Tag, rune2Tag)
						if ((rune1Tag ~= bl and rune2Tag ~= bl and rune1TagNN ~= bl and rune2TagNN ~= bl and expire > alpha) or (aura_env.TTD - aura_env.fixedGCD + aura_env.gcdFreeWhen < aura_env.config.disDropTime)) or expire > 10 then
							aura_env.nextAction = 'BS'
						else
							aura_env.nextAction = 'PES'
						end
					elseif rime > 0.1 and UnitPower('player') < 110 then
						aura_env.nextAction = 'HB'
					elseif UnitPower('player') >= aura_env.FSRP * 2 then
						-- elseif durationG- aura_env.fixedGCD <=0.1 and UA1<16.5 and UA1>0 and aura_env.RDencounter then
						--     aura_env.nextAction="RD"
						aura_env.nextAction = 'FS'
					elseif
						((desync and (UA1 < 20 - aura_env.fixedGCD - 1) and durationERW <= 2.5) or (desync and durationERW > 2.5) or (timeNow + aura_env.gcdFreeWhen - aura_env.combatStart > 4 and UA1 < 20 - aura_env.fixedGCD - 0.5) and durationERW <= 2.5) and aura_env.runes[bn].cd <= (aura_env.config.reaction / 1000) and bn ~= rune1Tag and bn ~= rune2Tag and
							expire < 11
					 then
						--should bs?  222
						local alpha = 0
						if aura_env.runes[bl].cd + aura_env.config.reaction / 1000 > aura_env.fixedGCD + aura_env.gcdFreeWhen then
							alpha = aura_env.runes[bl].cd + aura_env.config.reaction / 1000
						else
							alpha = aura_env.fixedGCD + aura_env.gcdFreeWhen
						end

						local obWhenNN, obTimerNN, rune1TagNN, rune2TagNN = aura_env.obFunctionNextNext_frost(rune1Tag, rune2Tag)
						if (rune1Tag ~= bl and rune2Tag ~= bl and rune1TagNN ~= bl and rune2TagNN ~= bl and expire > alpha) or (aura_env.TTD - aura_env.fixedGCD + aura_env.gcdFreeWhen < aura_env.config.disDropTime) then
							aura_env.nextAction = 'BS'
						else
							aura_env.nextAction = 'PES'
						end
					elseif UnitPower('player') >= aura_env.FSRP then
						aura_env.nextAction = 'FS'
					elseif aura_env.runes[bn].cd <= (aura_env.config.reaction / 1000) and bn ~= rune1Tag and bn ~= rune2Tag and not desync then
						local alpha = 0
						if aura_env.runes[bl].cd + aura_env.config.reaction / 1000 > aura_env.fixedGCD + aura_env.gcdFreeWhen then
							alpha = aura_env.runes[bl].cd + aura_env.config.reaction / 1000
						else
							alpha = aura_env.fixedGCD + aura_env.gcdFreeWhen
						end
						if (expire > alpha) or (aura_env.TTD - aura_env.fixedGCD + aura_env.gcdFreeWhen < aura_env.config.disDropTime) and aura_env.desyncFlag then
							aura_env.nextAction = 'BS'
						else
							aura_env.nextAction = 'PES'
						end
					elseif durationH <= 0 then
						aura_env.nextAction = 'HOW'
					else
						aura_env.nextAction = 'OB'
					end
				end
				WeakAuras.ScanEvents('fonsas_CANCEL_BT', false)
			else
				local varFlagLast = aura_env.varFlag2
				if bn == 1 and BT1 < 14 and aura_env.blood1Type_cancelBT then
					aura_env.varFlag2 = true
					WeakAuras.ScanEvents('fonsas_CANCEL_BT', true)
				else
					aura_env.varFlag2 = false
					WeakAuras.ScanEvents('fonsas_CANCEL_BT', false)
				end
				if varFlagLast ~= aura_env.varFlag2 then
					WeakAuras.ScanEvents('fonsas_CANCEL_BT', aura_env.varFlag2)
				end

				local obWhenTemp, obTimerTemp, rune1TagTemp, rune2TagTemp = aura_env.obFunction_frost(bn)

				local a = obWhenTemp - aura_env.fixedGCD / 2
				local b = rime < 0.1 and a < aura_env.fixedGCD + aura_env.gcdFreeWhen + 0.1
				local startG, durationG = GetSpellCooldown(46584)

				local multi = 1
				if aura_env.subUH then
					multi = 2
				end

				local d = expire - (aura_env.config.reaction / 1000) * 10 * multi <= aura_env.fixedGCD

				local e = obWhenTemp + obTimerTemp <= aura_env.fixedGCD + (aura_env.config.reaction / 1000) * 10

				local f = desync and aura_env.runes[bn].cd - aura_env.fixedGCD <= (aura_env.config.reaction / 1000) - 2.45
				--aura_env.nextAction="PES"

				local lost = false
				local lostRune = aura_env.runes[bn].cd
				if lostRune < 0 then
					lostRune = 0
				end
				if expire < lostRune then
					lost = true
				end

				--  print(lost)

				if (d or e or f) and not lost then
					local var = aura_env.runes[bl].cd
					if var < 0 then
						var = 0
					end
					if not desync and aura_env.desyncFlag and expire > var + aura_env.fixedGCD * 2 + (aura_env.config.reaction / 1000) * 5 and aura_env.runes[bn].cd <= (aura_env.config.reaction / 1000) then
						aura_env.nextAction = 'BS'
					else
						aura_env.nextAction = 'PES'
					end
				elseif not lost then
					if HoWTimer < 10 and not aura_env.totemDetected and durationH <= 0 then
						-- elseif UnitPower("player")>=aura_env.FSRP and KM>0 and not b then
						--    aura_env.nextAction="FS"
						aura_env.nextAction = 'HOW'
					elseif rime > 0.1 and KM > 0.1 and UnitPower('player') < 121 then
						aura_env.nextAction = 'HB'
					elseif rime > 0.1 and KM > 0.1 and UnitPower('player') >= aura_env.FSRP then
						aura_env.nextAction = 'FS'
					elseif (desync) and aura_env.runes[bn].cd - aura_env.fixedGCD <= (aura_env.config.reaction / 1000) - 2.45 then
						aura_env.nextAction = 'PES'
					elseif rime > 0.1 and UnitPower('player') < 110 then
						aura_env.nextAction = 'HB'
					elseif UnitPower('player') >= aura_env.FSRP * 2 then
						-- elseif durationG- aura_env.fixedGCD <=0.1 and UA1<16.5 and UA1>1  and aura_env.RDencounter  then
						--    aura_env.nextAction="RD"
						aura_env.nextAction = 'FS'
					elseif desync and aura_env.runes[bn].cd <= (aura_env.config.reaction / 1000) then
						aura_env.nextAction = 'PES'
					elseif UnitPower('player') >= aura_env.FSRP then
						aura_env.nextAction = 'FS'
					elseif not desync and aura_env.desyncFlag and expire > aura_env.runes[bl].cd + aura_env.fixedGCD + (aura_env.config.reaction / 1000) and aura_env.runes[bn].cd <= (aura_env.config.reaction / 1000) then
						aura_env.nextAction = 'BS'
					elseif durationH <= 0 and BT1 == 0 then
						aura_env.nextAction = 'HOW'
					elseif (not desync or aura_env.desyncFlag) and expire > aura_env.runes[bl].cd + aura_env.fixedGCD + (aura_env.config.reaction / 1000) then
						aura_env.nextAction = 'BS'
					else
						aura_env.nextAction = 'PES'
					end
				elseif lost then
					WeakAuras.ScanEvents('fonsas_UA', false)
					WeakAuras.ScanEvents('fonsas_ERW_frost', false)
					WeakAuras.ScanEvents('fonsas_Pesti_ERW_frost', false)
					if ff <= blCap and uh <= blCap then
						if aura_env.runes[fn].cd <= aura_env.runes[un].cd and aura_env.runes[fn].cd <= (aura_env.runes[bn].cd + aura_env.gcdFreeWhen + aura_env.fixedGCD + 0.05) then
							local a = aura_env.filler()
							if (aura_env.runes[fn].cd > aura_env.gcdFreeWhen + aura_env.fixedGCD + 0.05) and a ~= '' then
								aura_env.nextAction = a
							else
								aura_env.nextAction = 'IT'
							end
						elseif aura_env.runes[un].cd <= aura_env.runes[fn].cd and aura_env.runes[un].cd <= (aura_env.runes[bn].cd + aura_env.gcdFreeWhen + aura_env.fixedGCD + 0.05) then
							local a = aura_env.filler()
							if (aura_env.runes[un].cd > aura_env.gcdFreeWhen + aura_env.fixedGCD + 0.05) and a ~= '' then
								aura_env.nextAction = a
							else
								aura_env.nextAction = 'PS'
							end
						else
							local a = aura_env.filler()
							if (aura_env.runes[bn].cd > aura_env.gcdFreeWhen + aura_env.fixedGCD + 0.05) and a ~= '' then
								aura_env.nextAction = a
							else
								aura_env.nextAction = 'BS'
							end
						end
					elseif ff <= blCap and (uh > blCap) then
						if aura_env.runes[fn].cd <= (aura_env.runes[bn].cd + aura_env.gcdFreeWhen + aura_env.fixedGCD + 0.05) then
							if UnitPower('player') >= aura_env.FSRP and aura_env.runes[fn].cd > aura_env.fixedGCD / 2 then
								aura_env.nextAction = 'FS'
							else
								aura_env.nextAction = 'IT'
							end
						else
							if UnitPower('player') >= aura_env.FSRP and aura_env.runes[bn].cd > aura_env.fixedGCD / 2 then
								aura_env.nextAction = 'FS'
							else
								if uh > aura_env.runes[bl].cd + 0.1 then
									aura_env.nextAction = 'BS'
								else
									aura_env.nextAction = 'PES'
								end
							end
						end
					elseif ff > blCap and uh <= blCap then
						if aura_env.runes[un].cd <= (aura_env.runes[bn].cd + aura_env.gcdFreeWhen + aura_env.fixedGCD + 0.05) then
							if UnitPower('player') >= aura_env.FSRP and aura_env.runes[fn].cd > aura_env.fixedGCD / 2 then
								aura_env.nextAction = 'FS'
							else
								aura_env.nextAction = 'PS'
							end
						else
							if UnitPower('player') >= aura_env.FSRP and aura_env.runes[bn].cd > aura_env.fixedGCD / 2 then
								aura_env.nextAction = 'FS'
							else
								aura_env.nextAction = 'BS'
							end
						end
					end
				end
			end
		else
			WeakAuras.ScanEvents('fonsas_UA', false)
			WeakAuras.ScanEvents('fonsas_ERW_frost', false)
			WeakAuras.ScanEvents('fonsas_Pesti_ERW_frost', false)
			if ff <= blCap and uh <= blCap then
				if aura_env.runes[fn].cd <= aura_env.runes[un].cd and aura_env.runes[fn].cd <= (aura_env.runes[bn].cd + aura_env.gcdFreeWhen + aura_env.fixedGCD + 0.05) then
					local a = aura_env.filler()
					if (aura_env.runes[fn].cd > aura_env.gcdFreeWhen + aura_env.fixedGCD + 0.05) and a ~= '' then
						aura_env.nextAction = a
					else
						aura_env.nextAction = 'IT'
					end
				elseif aura_env.runes[un].cd <= aura_env.runes[fn].cd and aura_env.runes[un].cd <= (aura_env.runes[bn].cd + aura_env.gcdFreeWhen + aura_env.fixedGCD + 0.05) then
					local a = aura_env.filler()
					if (aura_env.runes[un].cd > aura_env.gcdFreeWhen + aura_env.fixedGCD + 0.05) and a ~= '' then
						aura_env.nextAction = a
					else
						aura_env.nextAction = 'PS'
					end
				else
					local a = aura_env.filler()
					if (aura_env.runes[bn].cd > aura_env.gcdFreeWhen + aura_env.fixedGCD + 0.05) and a ~= '' then
						aura_env.nextAction = a
					else
						aura_env.nextAction = 'BS'
					end
				end
			elseif ff <= blCap and (uh > blCap) then
				if aura_env.runes[fn].cd <= (aura_env.runes[bn].cd + aura_env.gcdFreeWhen + aura_env.fixedGCD + 0.05) then
					if UnitPower('player') >= aura_env.FSRP and aura_env.runes[fn].cd > aura_env.fixedGCD / 2 then
						aura_env.nextAction = 'FS'
					else
						aura_env.nextAction = 'IT'
					end
				else
					if UnitPower('player') >= aura_env.FSRP and aura_env.runes[bn].cd > aura_env.fixedGCD / 2 then
						aura_env.nextAction = 'FS'
					else
						if uh > aura_env.runes[bl].cd + 0.1 then
							aura_env.nextAction = 'BS'
						else
							aura_env.nextAction = 'PES'
						end
					end
				end
			elseif ff > blCap and uh <= blCap then
				if aura_env.runes[un].cd <= (aura_env.runes[bn].cd + aura_env.gcdFreeWhen + aura_env.fixedGCD + 0.05) then
					if UnitPower('player') >= aura_env.FSRP and aura_env.runes[fn].cd > aura_env.fixedGCD / 2 then
						aura_env.nextAction = 'FS'
					else
						aura_env.nextAction = 'PS'
					end
				else
					if UnitPower('player') >= aura_env.FSRP and aura_env.runes[bn].cd > aura_env.fixedGCD / 2 then
						aura_env.nextAction = 'FS'
					else
						aura_env.nextAction = 'BS'
					end
				end
			end
		end
	end

	-- print("--")

	local uaR = 0

	if aura_env.runes[fn].cd <= 0.05 then
		uaR = fn
	elseif (aura_env.runes[fn].cd > aura_env.runes[1].cd and GetRuneType(1) == 4) then
		uaR = 1
	elseif (aura_env.runes[fn].cd > aura_env.runes[2].cd and GetRuneType(2) == 4) then
		uaR = 2
	end

	if aura_env.nextAction == 'OB' and expire > 1.5 * aura_env.fixedGCD then
		local obWhenTemp, obTimerTemp, rune1TagTemp, rune2TagTemp = aura_env.obFunctionUA_frost(uaR)

		local uab1 = GetRuneType(1) == 4 and aura_env.runes[fn].cd >= (aura_env.config.reaction / 1000) * 1.5
		local cond2 = rune1TagTemp == 1 and aura_env.runes[rune1TagTemp].cd >= aura_env.runes[rune2TagTemp].cd and obWhenTemp < 2.5
		local cond3 = rune2TagTemp == 1 and aura_env.runes[rune2TagTemp].cd >= aura_env.runes[rune1TagTemp].cd and obWhenTemp < 2.5
		local cond4 = (rune2TagTemp + rune1TagTemp == 3)
		if durationUA <= 0 and durationBT <= 0 and uab1 then
			WeakAuras.ScanEvents('fonsas_UA', true)
		elseif durationUA <= 0 and durationBT <= 0 and not cond2 and not cond3 and not cond4 then
			WeakAuras.ScanEvents('fonsas_UA', true)
		else
			WeakAuras.ScanEvents('fonsas_UA', false)
		end
	else
		WeakAuras.ScanEvents('fonsas_UA', false)
	end

	local var = aura_env.TTD - aura_env.fixedGCD + aura_env.gcdFreeWhen < 32 or UA1 > 1
	local var2 = GetRuneType(bl) == 4 or (GetRuneType(bn) == 4 and aura_env.runes[bl].cd < 0)

	if (aura_env.lastCastID == 50842 or aura_env.lastCastID == 51429 or aura_env.lastCastID == 51428 or aura_env.lastCastID == 51427 or aura_env.lastCastID == 51426) and durationERW <= 1.5 and var and GetRuneType(1) == 4 and GetRuneType(2) == 4 then
		WeakAuras.ScanEvents('fonsas_ERW_frost', true)
		WeakAuras.ScanEvents('fonsas_CANCEL_BT', false)
		WeakAuras.ScanEvents('fonsas_ERW_PLUS', false)
	elseif aura_env.nextAction == 'PES' and durationERW <= 1.5 and var2 and (aura_env.TTD - aura_env.fixedGCD + aura_env.gcdFreeWhen < 30 or UA1 > 1) then
		WeakAuras.ScanEvents('fonsas_ERW_frost', true)
		WeakAuras.ScanEvents('fonsas_CANCEL_BT', false)
		WeakAuras.ScanEvents('fonsas_ERW_PLUS', true)
	else
		WeakAuras.ScanEvents('fonsas_ERW_frost', false)
		WeakAuras.ScanEvents('fonsas_ERW_PLUS', false)
	end

	if aura_env.lastCastID == 49930 and aura_env.nextAction == 'BS' then
		aura_env.nextAction = 'PES'
	end
	if aura_env.lastCastID ~= 50842 and aura_env.nextAction == 'BS' and UA1 > 10 and expire < 10 then
		aura_env.nextAction = 'PES'
	end
	--if timeNow+aura_env.gcdFreeWhen-aura_env.combatStart>6.2 and aura_env.nextAction=="FS" and UnitPower("player")<=60

	if lastAction ~= aura_env.nextAction or aura_env.init < 3 then
		if aura_env.nextAction == 'OB' and (rune2Tag ~= 1 or rune1Tag ~= 1 or rune2Tag ~= 2 or rune1Tag ~= 2) then
			aura_env.desyncCounter = aura_env.desyncCounter + 1
		else
			aura_env.desyncCounter = 0
		end

		aura_env.stampWhenChanged = aura_env.gcdStamp
		aura_env.init = aura_env.init + 1

		if aura_env.lastCastID == 49930 and aura_env.nextAction == 'BS' then
			aura_env.nextAction = 'PES'
		end
		WeakAuras.ScanEvents('fonsas_action', aura_env.nextAction)

		-- print(rime)

		local startG, durationG = GetSpellCooldown(46584)
		if ((aura_env.nextAction == 'FS' and rime <= 0 and KM <= 0) or aura_env.nextAction == 'HOW') and durationG <= 1.5 and aura_env.RDencounter and UA1 > 0 and UA1 < 18 and not aura_env.varFlag2 and UnitPower('player') < 120 then
			WeakAuras.ScanEvents('fonsas_RD2', true)
		else
			WeakAuras.ScanEvents('fonsas_RD2', false)
		end
	end

	xRTF(1, 1, aura_env.nextAction)
end

local GetNumDebuffs = function()
	local a = 0
	while UnitAura('target', a + 1, 'PLAYER|HARMFUL') do
		a = a + 1
	end
	return a
end
local GetNumBuffs = function()
	local a = 0
	while UnitAura('player', a + 1, 'HELPFUL') do
		a = a + 1
	end
	return a
end

local GCD = function()
	local start, duration = GetSpellCooldown(61304)
	gcd_when = start + duration

	return gcd_when
end

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

local Filler = function(killing_machine, rime, horn_of_winter, strength_totem, unbreakable_armor, blood_tap, potion_of_speed, frost_fever, blood_plague)
	local fill = ''

	-- if aura_env.HoWTimer < 10 and not aura_env.totemDetected and aura_env.durationH <= 0 then
	-- 	NA = 'HOW'
	-- elseif aura_env.rime > 0.1 and aura_env.KM > 0.1 and UnitPower('player') < 121 then
	-- 	NA = 'HB'
	-- elseif aura_env.rime > 0.1 and aura_env.KM > 0.1 and UnitPower('player') >= aura_env.FSRP then
	-- 	NA = 'FS'
	-- elseif aura_env.rime > 0.1 then
	-- 	aura_env.nextAction = 'HB'
	-- elseif UnitPower('player') >= aura_env.FSRP then
	-- 	aura_env.nextAction = 'FS'
	-- elseif aura_env.durationH <= 0 then
	-- 	NA = 'HOW'
	-- end

	return fill
end

local TrackBuffs = function()
	local killing_machine = 0
	local rime = 0
	local horn_of_winter = 0
	local strength_totem = false
	local unbreakable_armor = 0
	local blood_tap = 0
	local potion_of_speed = 0
	local frost_fever = 0
	local blood_plague = 0

	for i = 1, GetNumBuffs() do
		local name, rank, icon, count, debuffType, expireWhen, expirationTime, unitCaster, isStealable, id, spellId = UnitAura('player', i, 'HELPFUL')

		if name == 'Horn of Winter' or id == 57330 or id == 57623 then
			horn_of_winter = expireWhen - GetTime()
		end
		if name == 'Killing Machine' or id == 51124 then
			killing_machine = expireWhen - GetTime()
		end
		if name == 'Freezing Fog' or id == 59052 then
			rime = expireWhen - GetTime()
		end
		if name == 'Strength of Earth' or id == 58646 or id == 10441 or id == 25362 or id == 25527 or id == 57621 then
			strength_totem = true
		end
		if name == 'Unbreakable Armor' or id == 51271 then
			unbreakable_armor = expireWhen - GetTime()
		end
		if name == 'Blood Tap' or id == 45529 then
			blood_tap = expireWhen - GetTime()
		end
		if name == 'Speed' or id == 53908 then
			potion_of_speed = expireWhen - GetTime()
		end
	end

	for i = 1, GetNumDebuffs() do
		local name, rank, icon, count, debuffType, expireWhen, expirationTime, unitCaster, isStealable, id, spellId = UnitAura('target', i, 'PLAYER|HARMFUL')

		if name == 'Frost Fever' then
			frost_fever = expireWhen - GetTime()
		end
		if name == 'Blood Plague' then
			blood_plague = expireWhen - GetTime()
		end
	end

	return killing_machine, rime, horn_of_winter, strength_totem, unbreakable_armor, blood_tap, potion_of_speed, frost_fever, blood_plague
end

local Rotation = function()
	if not UnitExists('target') then
		return false
	end

	local blood, frost, unholy, death = RuneCount()
	local killing_machine, rime, horn_of_winter, strength_totem, unbreakable_armor, blood_tap, potion_of_speed, frost_fever, blood_plague = TrackBuffs()
	local fill = Filler(killing_machine, rime, horn_of_winter, strength_totem, unbreakable_armor, blood_tap, potion_of_speed, frost_fever, blood_plague)
	local ff, ps = 0, 0
	local next_action

	print(blood, frost, unholy, death, killing_machine, rime, horn_of_winter, strength_totem, unbreakable_armor, blood_tap, potion_of_speed, frost_fever, blood_plague)
end

-- UIParent:HookScript('OnUpdate', Rotation)
