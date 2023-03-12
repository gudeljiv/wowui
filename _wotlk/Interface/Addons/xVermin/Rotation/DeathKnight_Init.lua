aura_env.ERWcounter = GetTime() - 300
aura_env.oblitCounter = 0
aura_env.gcdReaction = 0
aura_env.blood1Type = GetRuneType(1)
aura_env.blood1Type_cancelBT = false
--print( GetRuneType(1))
aura_env.combatStart = GetTime()
aura_env.RDencounter = false or aura_env.config.RDencounter
aura_env.durationH = 3
local hit = GetCombatRatingBonus(CR_HIT_MELEE) + GetHitModifier()
local exp = GetExpertise()
aura_env.desyncFlag = false
if exp >= aura_env.config.expRating and hit >= aura_env.config.hitRating and aura_env.config.normalR == false then
	aura_env.desyncFlag = true
end

aura_env.gcdReactionCount = 1
aura_env.gcdReactionTotal = 0
aura_env.gcdReactionNormalized = 0

local nameTalent, icon, tier, column, currRank, maxRank = GetTalentInfo(3, 5)
aura_env.subUH = false
if currRank > 1 then
	aura_env.subUH = true
end

aura_env.rime = 0
aura_env.KM = 0
aura_env.HoWTimer = 0

aura_env.desyncCounter = 0

aura_env.filler = function()
	local NA = ''
	if aura_env.HoWTimer < 10 and not aura_env.totemDetected and aura_env.durationH <= 0 then
		NA = 'HOW'
	elseif aura_env.rime > 0.1 and aura_env.KM > 0.1 and UnitPower('player') < 121 then
		NA = 'HB'
	elseif aura_env.rime > 0.1 and aura_env.KM > 0.1 and UnitPower('player') >= aura_env.FSRP then
		NA = 'FS'
	elseif aura_env.rime > 0.1 then
		aura_env.nextAction = 'HB'
	elseif UnitPower('player') >= aura_env.FSRP then
		aura_env.nextAction = 'FS'
	elseif aura_env.durationH <= 0 then
		NA = 'HOW'
	end

	return NA
end

--print( aura_env.subUH)
--[[
for tab = 1, GetNumTalentTabs() do
    for talent = 1, GetNumTalents(tab) do
        -- print(GetTalentInfo(tab, talent))
        
        local nameTalent, icon, tier, column, currRank, maxRank= GetTalentInfo(tab,talent);
        if nameTalent=="Epidemic" then 
            print(tab) 
            print(talent)     
        end
    end
end
]]
aura_env.OBlock = false
aura_env.varFlag1 = false
aura_env.varFlag2 = false
aura_env.totemDetected = false

local startUA, durationUA = GetSpellCooldown(51271)
 --ua\
if durationUA <= 10 and durationUA > 1.5 then
	aura_env.UAcast = GetTime() - 10
elseif durationUA <= 1.5 then
	aura_env.UAcast = GetTime() - 60
else
	aura_env.UAcast = 0
end

local startBT, durationBT = GetSpellCooldown(45529)
 --bt\
if durationBT <= 10 and durationBT > 1.5 then
	aura_env.BTcast = GetTime() - 10
elseif durationBT <= 1.5 then
	aura_env.BTcast = GetTime() - 60
else
	aura_env.BTcast = 0
end

local startH, durationHoW = GetSpellCooldown(57330)
if durationHoW <= 1.5 then
	aura_env.HoWcast = GetTime() - 20
else
	aura_env.HoWcast = 0
end

aura_env.oblitWhen = 0
aura_env.varFlag = false

aura_env.desync = false

aura_env.desyncCounter = 0

aura_env.lastRune1 = 0
aura_env.lastRune2 = 0

aura_env.runeUsed = 0

aura_env.stampWhenChanged = 0

aura_env.BTpredict = false
aura_env.initBT = 0
aura_env.lastCastID = 0
aura_env.bloodTapPredict = GetTime()

aura_env.ff = 0
aura_env.uh = 0
aura_env.des = 0
aura_env.gf = 0

aura_env.PEScasted = false

aura_env.FSRP = 40
for i = 1, 6 do
	local enabled, glyphType, glyphTooltipIndex, glyphSpellID, icon = GetGlyphSocketInfo(i)

	if glyphSpellID == 237635 then
		aura_env.FSRP = 32
	end
end

aura_env.GetNumDebuffs = function()
	local a = 0
	while UnitAura('target', a + 1, 'PLAYER|HARMFUL') do
		a = a + 1
	end
	--print(a)
	return a
end
aura_env.GetNumBuffs = function()
	local a = 0
	while UnitAura('player', a + 1, 'HELPFUL') do
		a = a + 1
	end
	--print(a)
	return a
end

aura_env.trackD_frost = function()
	local expireFF = 0
	local expureUh = 0

	for i = 1, aura_env.GetNumDebuffs() do
		-- n, rank, icon, count, debuffType, dur, expirationTime, unitCaster, isStealable, shouldConsolidate, id
		local name, rank, icon, count, debuffType, expireWhen, expirationTime, unitCaster, isStealable, id, spellId = UnitAura('target', i, 'PLAYER|HARMFUL')
		--print(locname)
		-- print(GetTime())
		--print(expireWhen)

		--55095 67719 67767 69917
		if name == 'Frost Fever' or id == 55095 or id == 67719 or id == 67767 or id == 69917 then
			--print(id)
			expireFF = expireWhen - GetTime()
		end
		-- BP fest
		if name == 'Blood Plague' or id == 55264 or id == 55973 or id == 55322 or id == 57601 or id == 58840 or id == 58844 or id == 59984 or id == 60950 or id == 61111 or id == 61601 or id == 67722 or id == 69911 or id == 55078 or id == 71923 then
			--print(id)
			expureUh = expireWhen - GetTime()
		end
	end

	return expireFF, expureUh
end

aura_env.cancelBT_frost = function()
	local BT = 0
	for i = 1, aura_env.GetNumBuffs() do
		-- n, rank, icon, count, debuffType, dur, expirationTime, unitCaster, isStealable, shouldConsolidate, id
		local name, rank, icon, count, debuffType, expireWhen, expirationTime, unitCaster, isStealable, id, spellId = UnitAura('player', i, 'HELPFUL')
		-- print(name)
		if name == 'Blood Tap' or id == 45529 then
			print('BT found, cancelling')
			CancelUnitBuff('player', i)
			print('BT cancel worked')
		end
	end
end

aura_env.trackB_frost = function()
	local KM = 0
	local rime = 0
	local how = 0
	local totem = false
	local UA = 0
	local BT = 0
	local speed = 0
	--local uhP = false

	for i = 1, aura_env.GetNumBuffs() do
		-- n, rank, icon, count, debuffType, dur, expirationTime, unitCaster, isStealable, shouldConsolidate, id
		local name, rank, icon, count, debuffType, expireWhen, expirationTime, unitCaster, isStealable, id, spellId = UnitAura('player', i, 'HELPFUL')
		-- print(name)

		if name == 'Horn of Winter' or id == 57330 or id == 57623 then
			--print(id)
			how = expireWhen - GetTime()
		end

		if name == 'Killing Machine' or id == 51124 then
			-- print(id)
			KM = expireWhen - GetTime()
		end
		if name == 'Freezing Fog' or id == 59052 then
			--print(id)
			rime = expireWhen - GetTime()
		end

		if name == 'Strength of Earth' or id == 58646 or id == 10441 or id == 25362 or id == 25527 or id == 57621 then
			--print(id)
			totem = true
		end

		if name == 'Unbreakable Armor' or id == 51271 then
			--print(id)
			UA = expireWhen - GetTime()
		end
		if name == 'Blood Tap' or id == 45529 then
			-- print(id)
			BT = expireWhen - GetTime()
		end
		if name == 'Speed' or id == 53908 then
			--print(id)
			speed = expireWhen - GetTime()
		--print(speed)
		end
	end

	return KM, rime, how, totem, UA, BT, speed

	--KM, rime, HoWTimer, totem
end

aura_env.encounter = false or aura_env.config.gary
aura_env.oStep = 0
aura_env.DDwhen = 0
aura_env.castStamp = 0
local start, duration = GetSpellCooldown(61304)
aura_env.gcdWhen = start + duration + aura_env.config.reaction / 1000
aura_env.fixedGCD = 1.5
aura_env.gcdStamp = start + duration
aura_env.gcdStampLast = 0

aura_env.init = 0
aura_env.runes = {}

aura_env.bloodTapLock = false
aura_env.DDlock = false

aura_env.runes[1] = {free = true, when = 0, cd = 0} --1
aura_env.runes[2] = {free = true, when = 0, cd = 0} --2
aura_env.runes[5] = {free = true, when = 0, cd = 0} --5
aura_env.runes[6] = {free = true, when = 0, cd = 0} --6
aura_env.runes[3] = {free = true, when = 0, cd = 0} --3
aura_env.runes[4] = {free = true, when = 0, cd = 0} --4

WeakAuras.WatchGCD()
aura_env.gcdWhen = WeakAuras.CalculatedGcdDuration()
aura_env.gcdFreeWhen = 0

aura_env.nextAction = 'clear'
WeakAuras.ScanEvents('fonsas_action', aura_env.nextAction)

--[[

aura_env.runeState_frost = function(ff, uh)
    local sync = true
    
    local expire = 0
    if ff<uh then expire = ff else expure = uh end
    expire = expire - aura_env.gcdFreeWhen
    local rune1CD = 20
    local rune1Tag = 3
    local rune1CDN = 20
    local rune1TagN = 4
    local rune1CDNN = 20
    local rune1TagNN = 1
    
    
    if aura_env.runes[3].cd<=aura_env.runes[4].cd then 
        rune1CD = aura_env.runes[3].cd
        rune1Tag = 3
    else
        rune1CD = aura_env.runes[4].cd
        rune1Tag = 4
    end
    
    if aura_env.runes[3].cd<=0 then 
        rune1CD = aura_env.runes[3].cd
        rune1Tag = 3
    elseif aura_env.runes[4].cd<=0 then 
        rune1CD = aura_env.runes[4].cd
        rune1Tag = 4
    end
    
    if aura_env.runes[5].cd<=aura_env.runes[6].cd then 
        rune2CD = aura_env.runes[5].cd
        rune2Tag = 5
    else
        rune2CD = aura_env.runes[6].cd
        rune2Tag = 6
    end
    if aura_env.runes[5].cd<=0 then 
        rune2CD = aura_env.runes[5].cd
        rune2Tag = 5
    elseif aura_env.runes[6].cd<=0 then 
        rune2CD = aura_env.runes[6].cd
        rune2Tag = 6
    end
    
    local death = 0 
    local other = 0
    
    if GetRuneType(1)==4 and GetRuneType(2)==4 then 
        if aura_env.runes[1].cd<=aura_env.runes[2].cd then 
            death = 1
            other = 2
        else 
            death = 2
            other = 1
        end
    elseif GetRuneType(1)==4  then
        death = 1
        other = 2
    elseif GetRuneType(2)==4  then
        death = 2
        other = 1
    end
    
    if death>0 then 
        local runeCD = 0
        local runeTag = 0
        if rune2CD>rune1CD and rune2CD>aura_env.runes[death].cd and expire > aura_env.config.reaction/1000*3+ 2*aura_env.fixedGCD and expire > aura_env.runes[other].cd + aura_env.config.reaction/1000*3 + 2*aura_env.fixedGCD then
            if rune2CD>aura_env.runes[death].cd and expire-temp > aura_env.config.reaction/1000*4+ aura_env.fixedGCD then
                
            end
        end
    end
end
]]
aura_env.obFunction_frost = function(bn)
	local rune1CD = 20
	local rune1Tag = 0
	local rune2CD = 20
	local rune2Tag = 0

	local rune1CD = aura_env.runes[6].cd
	local rune1Tag = 6
	local rune2CD = aura_env.runes[4].cd
	local rune2Tag = 4
	if rune1CD < 0 then
		rune1CD = 0
	end
	if rune2CD < 0 then
		rune2CD = 0
	end

	local cd2 = aura_env.runes[3].cd
	if cd2 <= 0 then
		cd2 = 0
	end
	--print("cd2: " .. tostring(cd2))
	if cd2 <= rune2CD then
		rune2Tag = 3
		rune2CD = aura_env.runes[3].cd
	end
	local cd1 = aura_env.runes[5].cd
	if cd1 <= 0 then
		cd1 = 0
	end
	if cd1 <= rune1CD then
		rune1Tag = 5
		rune1CD = aura_env.runes[5].cd
	end

	if rune1CD < 0 then
		rune1CD = 0
	end
	if rune2CD < 0 then
		rune2CD = 0
	end
	-- print()
	-- print(GetTime() - aura_env.ERWcounter  + aura_env.gcdFreeWhen)

	local a = (rune1CD - rune2CD > 0.1 or rune1CD - rune2CD < -0.1)
	local b = (GetRuneType(1) ~= 1 or GetRuneType(2) ~= 1)
	--local c =  (GetTime() - aura_env.ERWcounter + aura_env.gcdFreeWhen>2.9)
	--print(a and b and c)

	if a and b then
		-- pode haver death
		if rune1CD < rune2CD then
			if GetRuneType(2) ~= 1 then
				local dcd = aura_env.runes[2].cd
				if dcd < 0 then
					dcd = 0
				end
				if dcd + 0.01 < rune2CD then
					rune2Tag = 2
					rune2CD = aura_env.runes[2].cd
				end
			end
			if rune2CD < 0 then
				rune2CD = 0
			end
			if GetRuneType(1) ~= 1 then
				local dcd = aura_env.runes[1].cd
				if dcd < 0 then
					dcd = 0
				end
				if dcd + 0.01 < rune2CD then
					rune2Tag = 1
					rune2CD = aura_env.runes[1].cd
				end
			end
			if rune2CD < 0 then
				rune2CD = 0
			end
		else
			if GetRuneType(2) ~= 1 then
				local dcd = aura_env.runes[2].cd
				if dcd < 0 then
					dcd = 0
				end
				if dcd + 0.01 < rune1CD then
					rune1Tag = 2
					rune1CD = aura_env.runes[2].cd
				end
			end
			if rune1CD < 0 then
				rune1CD = 0
			end
			if GetRuneType(1) ~= 1 then
				local dcd = aura_env.runes[1].cd
				if dcd < 0 then
					dcd = 0
				end
				if dcd + 0.01 < rune1CD then
					rune1Tag = 1
					rune1CD = aura_env.runes[1].cd
				end
			end
			if rune1CD < 0 then
				rune1CD = 0
			end
		end
	end

	if (GetRuneType(1) ~= 1 and GetRuneType(2) ~= 1) then
		if
			(aura_env.runes[2].cd < aura_env.runes[3].cd and aura_env.runes[2].cd < aura_env.runes[4].cd and aura_env.runes[2].cd < aura_env.runes[5].cd and aura_env.runes[2].cd < aura_env.runes[6].cd and aura_env.runes[1].cd < aura_env.runes[3].cd and aura_env.runes[1].cd < aura_env.runes[4].cd and aura_env.runes[1].cd < aura_env.runes[5].cd and
				aura_env.runes[1].cd < aura_env.runes[6].cd) and
				(aura_env.runes[3].cd > 0 and aura_env.runes[4].cd > 0 and aura_env.runes[5].cd > 0 and aura_env.runes[6].cd > 0)
		 then
			rune1Tag = 1
			rune1CD = aura_env.runes[1].cd
			rune2Tag = 2
			rune2CD = aura_env.runes[2].cd
			if rune1CD < 0 then
				rune1CD = 0
			end
			if rune2CD < 0 then
				rune2CD = 0
			end
		end
	end

	--[[ for i=1, 6 do 
        if i~=3 and i~=4 and i~=bn then
            local cd = aura_env.runes[i].cd
            if cd<0 then cd = 0 end
            if cd <= rune1CD then 
                if GetRuneType(i)~=1 then 
                    local a = i
                    local b = a==1 or a==2 or a==3
                    if a==6 and aura_env.runes[5].cd==0 then 
                        a=5
                    elseif a==4 and aura_env.runes[3].cd==0 then 
                        a=3
                    elseif GetRuneType(1)~=1 and a==2 and aura_env.runes[1].cd==0 then
                        a=1
                    end
                    rune1Tag=a
                    rune1CD=aura_env.runes[a].cd
                end
            end
        end
    end
    
    for i=1, 4 do 
        if i~=bn and i~=rune1Tag then
            local cd = aura_env.runes[i].cd
            if cd<0 then cd = 0 end
            if cd <= rune2CD then 
                if GetRuneType(i)~=1 then 
                    if GetRuneType(rune1Tag)==4 then
                        rune2Tag=i 
                        rune2CD=aura_env.runes[i].cd 
                    elseif GetRuneType(rune1Tag)~=GetRuneType(i) then
                        rune2Tag=i 
                        rune2CD=aura_env.runes[i].cd 
                    end
                end
            end
        end
    end
    
    ]]
	local fn, un, fl, ul = 0
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

	--[[ if aura_env.runes[3].cd<=0 then 
        rune2Tag = 3
        rune2CD = aura_env.runes[3].cd
    elseif aura_env.runes[4].cd<=0 then
        rune2Tag = 4
        rune2CD = aura_env.runes[4].cd
    elseif GetRuneType(1)~=1 and  aura_env.runes[1].cd<=0 and rune1Tag ~= 1 and bn ~= 1 then
        rune2Tag = 1
        rune2CD = aura_env.runes[1].cd
    elseif GetRuneType(2)~=1 and aura_env.runes[2].cd<=0 and rune1Tag ~= 2 and bn ~= 2 then
        rune2Tag = 2
        rune2CD = aura_env.runes[2].cd
    end
    
    ]]
	local obWhen = 0
	local obRune = 0
	if aura_env.runes[rune2Tag].cd < aura_env.runes[rune1Tag].cd then
		obWhen = rune1CD
		obRune = rune2Tag
	else
		obWhen = rune2CD
		obRune = rune1Tag
	end
	if obWhen < 0 then
		obWhen = 0
	end

	local obTimer = 0

	if aura_env.runes[obRune].when - GetTime() - aura_env.gcdFreeWhen > -2.45 then
		obTimer = 2.45 + aura_env.runes[obRune].cd
	end
	--print("`")
	-- print("tag1: "..tostring(rune1Tag) .. " / tag2: "..tostring(rune2Tag))
	-- print("obWithin: ".. tostring(obTimer))

	local fncd = aura_env.runes[fn].when - GetTime() - aura_env.gcdFreeWhen + 2.45
	local uncd = aura_env.runes[un].when - GetTime() - aura_env.gcdFreeWhen + 2.45

	if rune1Tag == 1 or rune1Tag == 2 then
		if rune2Tag == 3 or rune2Tag == 4 then
			if obTimer > fncd then
				obTimer = fncd - 0.1
			end
		elseif rune2Tag == 5 or rune2Tag == 6 then
			if obTimer > uncd then
				obTimer = uncd - 0.1
			end
		end
	elseif rune2Tag == 1 or rune2Tag == 2 then
		if rune1Tag == 3 or rune1Tag == 4 then
			if obTimer > fncd then
				obTimer = fncd - 0.1
			end
		elseif rune1Tag == 5 or rune1Tag == 6 then
			if obTimer > uncd then
				obTimer = uncd - 0.1
			end
		end
	end

	return obWhen, obTimer, rune1Tag, rune2Tag
end

aura_env.obFunctionUA_frost = function(bn)
	local rune1CD = 20
	local rune1Tag = 0
	local rune2CD = 20
	local rune2Tag = 0

	local rune1CD = aura_env.runes[6].cd
	local rune1Tag = 6
	local rune2CD = aura_env.runes[4].cd
	local rune2Tag = 4
	if rune1CD < 0 then
		rune1CD = 0
	end
	if rune2CD < 0 then
		rune2CD = 0
	end

	local cd2 = aura_env.runes[3].cd
	if cd2 <= 0 then
		cd2 = 0
	end
	--print("cd2: " .. tostring(cd2))
	if cd2 <= rune2CD then
		rune2Tag = 3
		rune2CD = aura_env.runes[3].cd
	end
	local cd1 = aura_env.runes[5].cd
	if cd1 <= 0 then
		cd1 = 0
	end
	if cd1 <= rune1CD then
		rune1Tag = 5
		rune1CD = aura_env.runes[5].cd
	end

	if rune1CD < 0 then
		rune1CD = 0
	end
	if rune2CD < 0 then
		rune2CD = 0
	end

	if (rune1CD - rune2CD > 0.1 or rune1CD - rune2CD < -0.1) and (GetRuneType(1) ~= 1 or GetRuneType(2) ~= 1) then
		-- pode haver death
		if rune1CD < rune2CD then
			if GetRuneType(2) ~= 1 and bn ~= 2 then
				local dcd = aura_env.runes[2].cd
				if dcd < 0 then
					dcd = 0
				end
				if dcd + 0.01 < rune2CD then
					rune2Tag = 2
					rune2CD = aura_env.runes[2].cd
				end
			end
			if rune2CD < 0 then
				rune2CD = 0
			end
			if GetRuneType(1) ~= 1 and bn ~= 1 then
				local dcd = aura_env.runes[1].cd
				if dcd < 0 then
					dcd = 0
				end
				if dcd + 0.01 < rune2CD then
					rune2Tag = 1
					rune2CD = aura_env.runes[1].cd
				end
			end
			if rune2CD < 0 then
				rune2CD = 0
			end
		else
			if GetRuneType(2) ~= 1 and bn ~= 2 then
				local dcd = aura_env.runes[2].cd
				if dcd < 0 then
					dcd = 0
				end
				if dcd + 0.01 < rune1CD then
					rune1Tag = 2
					rune1CD = aura_env.runes[2].cd
				end
			end
			if rune1CD < 0 then
				rune1CD = 0
			end
			if GetRuneType(1) ~= 1 and bn ~= 1 then
				local dcd = aura_env.runes[1].cd
				if dcd < 0 then
					dcd = 0
				end
				if dcd + 0.01 < rune1CD then
					rune1Tag = 1
					rune1CD = aura_env.runes[1].cd
				end
			end
			if rune1CD < 0 then
				rune1CD = 0
			end
		end
	end

	local fn, un, fl, ul = 0
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

	if bn == 5 then
		fn = 6
	elseif bn == 6 then
		fn = 5
	end

	local obWhen = 0
	local obRune = 0

	if aura_env.runes[rune2Tag].cd < aura_env.runes[rune1Tag].cd then
		obWhen = rune1CD
		obRune = rune2Tag
	else
		obWhen = rune2CD
		obRune = rune1Tag
	end

	if obWhen < 0 then
		obWhen = 0
	end
	local obTimer = 0

	if aura_env.runes[obRune].when - GetTime() - aura_env.gcdFreeWhen > -2.45 then
		obTimer = 2.45 + aura_env.runes[obRune].cd
	end

	local fncd = aura_env.runes[fn].when - GetTime() - aura_env.gcdFreeWhen + 2.45
	local uncd = aura_env.runes[un].when - GetTime() - aura_env.gcdFreeWhen + 2.45

	if rune1Tag == 1 or rune1Tag == 2 then
		if rune2Tag == 3 or rune2Tag == 4 then
			if obTimer > fncd then
				obTimer = fncd - 0.1
			end
		elseif rune2Tag == 5 or rune2Tag == 6 then
			if obTimer > uncd then
				obTimer = uncd - 0.1
			end
		end
	elseif rune2Tag == 1 or rune2Tag == 2 then
		if rune1Tag == 3 or rune1Tag == 4 then
			if obTimer > fncd then
				obTimer = fncd - 0.1
			end
		elseif rune1Tag == 5 or rune1Tag == 6 then
			if obTimer > uncd then
				obTimer = uncd - 0.1
			end
		end
	end

	if obTimer < 0 then
		obTimer = 0
	end

	if obWhen == 0 then
		obTimer = 0
	end

	return obWhen, obTimer, rune1Tag, rune2Tag
end

aura_env.obFunctionNextNext_frost = function(r1, r2)
	local rune1CD = 20
	local rune1Tag = 0
	local rune2CD = 20
	local rune2Tag = 0

	for i = 1, 6 do
		if i ~= 3 and i ~= 4 and i ~= r1 and i ~= r2 then
			local cd = aura_env.runes[i].cd
			if cd < 0 then
				cd = 0
			end
			if cd <= rune1CD then
				if GetRuneType(i) ~= 1 then
					local a = i
					local b = a == 1 or a == 2 or a == 3
					if a == 6 and aura_env.runes[5].cd == 0 and r1 ~= 5 and r2 ~= 5 then
						a = 5
					elseif a == 4 and aura_env.runes[3].cd == 0 and r1 ~= 3 and r2 ~= 3 then
						a = 3
					elseif GetRuneType(1) ~= 1 and a == 2 and aura_env.runes[1].cd == 0 and r1 ~= 1 and r2 ~= 1 then
						a = 1
					end
					rune1Tag = a
					rune1CD = aura_env.runes[a].cd
				end
			end
		end
	end

	for i = 1, 4 do
		if i ~= r1 and i ~= r2 and i ~= rune1Tag then
			local cd = aura_env.runes[i].cd
			if cd < 0 then
				cd = 0
			end
			if cd <= rune2CD then
				if GetRuneType(i) ~= 1 then
					if GetRuneType(rune1Tag) == 4 then
						rune2Tag = i
						rune2CD = aura_env.runes[i].cd
					elseif GetRuneType(rune1Tag) ~= GetRuneType(i) then
						rune2Tag = i
						rune2CD = aura_env.runes[i].cd
					end
				end
			end
		end
	end

	local fn, un, fl, ul = 0
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

	if r1 == 5 then
		fn = 6
	elseif r1 == 6 then
		fn = 5
	end
	if r2 == 5 then
		fn = 6
	elseif r2 == 6 then
		fn = 5
	end
	if r1 == 3 then
		un = 4
	elseif r1 == 4 then
		un = 3
	end
	if r2 == 3 then
		un = 4
	elseif r2 == 4 then
		un = 3
	end

	if aura_env.runes[3].cd <= 0 and r2 ~= 3 and r1 ~= 3 then
		rune2Tag = 3
		rune2CD = aura_env.runes[3].cd
	elseif aura_env.runes[4].cd <= 0 and r2 ~= 4 and r1 ~= 4 then
		rune2Tag = 4
		rune2CD = aura_env.runes[4].cd
	elseif GetRuneType(1) ~= 1 and aura_env.runes[1].cd <= 0 and rune1Tag ~= 1 and r1 ~= 1 and r2 ~= 1 then
		rune2Tag = 1
		rune2CD = aura_env.runes[1].cd
	elseif GetRuneType(2) ~= 1 and aura_env.runes[2].cd <= 0 and rune1Tag ~= 2 and r1 ~= 2 and r2 ~= 2 then
		rune2Tag = 2
		rune2CD = aura_env.runes[2].cd
	end

	local obWhen = 0
	local obRune = 0

	if aura_env.runes[rune2Tag].cd < aura_env.runes[rune1Tag].cd then
		obWhen = rune1CD
		obRune = rune2Tag
	else
		obWhen = rune2CD
		obRune = rune1Tag
	end

	if obWhen < 0 then
		obWhen = 0
	end
	local obTimer = 0

	if aura_env.runes[obRune].when - GetTime() - aura_env.gcdFreeWhen > -2.45 then
		obTimer = 2.45 + aura_env.runes[obRune].cd
	end

	local fncd = aura_env.runes[fn].when - GetTime() - aura_env.gcdFreeWhen + 2.45
	local uncd = aura_env.runes[un].when - GetTime() - aura_env.gcdFreeWhen + 2.45

	if rune1Tag == 1 or rune1Tag == 2 then
		if rune2Tag == 3 or rune2Tag == 4 then
			if obTimer > fncd then
				obTimer = fncd - 0.1
			end
		elseif rune2Tag == 5 or rune2Tag == 6 then
			if obTimer > uncd then
				obTimer = uncd - 0.1
			end
		end
	elseif rune2Tag == 1 or rune2Tag == 2 then
		if rune1Tag == 3 or rune1Tag == 4 then
			if obTimer > fncd then
				obTimer = fncd - 0.1
			end
		elseif rune1Tag == 5 or rune1Tag == 6 then
			if obTimer > uncd then
				obTimer = uncd - 0.1
			end
		end
	end

	if obTimer < 0 then
		obTimer = 0
	end

	if obWhen == 0 then
		obTimer = 0
	end

	return obWhen, obTimer, rune1Tag, rune2Tag
end

aura_env.last = 0

aura_env.TTD = 180

-- Credit to Aethys https://github.com/herotc/hero-lib

local cache = {}
local units = {}

local iterableUnits = {'focus', 'target', 'mouseover'}
if not WeakAuras.IsClassic() then
	for i = 1, 5 do
		iterableUnits[#iterableUnits + 1] = 'boss' .. i
	end
end

for i = 1, 40 do
	iterableUnits[#iterableUnits + 1] = 'nameplate' .. i
end

function aura_env.TTDRefresh()
	local currentTime = GetTime()
	local checkedUnits = {}
	local historyCount = 100
	local historyTime = 10

	for _, unit in ipairs(iterableUnits) do
		if UnitExists(unit) then
			local GUID = UnitGUID(unit)
			if not checkedUnits[GUID] then
				checkedUnits[GUID] = true
				local health = UnitHealth(unit)
				local maxHealth = UnitHealthMax(unit)
				local healthPercentage = health ~= -1 and maxHealth ~= -1 and health / maxHealth * 100
				-- Check if it's a valid unit
				if UnitCanAttack('player', unit) and healthPercentage < 100 then
					local unitTable = units[GUID]
					-- Check if we have seen one time this unit, if we don't then initialize it.
					if not unitTable or healthPercentage > unitTable[1][1][2] then
						unitTable = {{}, currentTime}
						units[GUID] = unitTable
					end
					local values = unitTable[1]
					local time = currentTime - unitTable[2]
					-- Check if the % HP changed since the last check (or if there were none)
					if #values == 0 or healthPercentage ~= values[1][2] then
						local value
						local lastIndex = #cache
						-- Check if we can re-use a table from the cache -- Buds: i have doubt on the value of reusing table, with the high cost of tinsert on 1st index
						if lastIndex == 0 then
							value = {time, healthPercentage}
						else
							value = cache[lastIndex]
							cache[lastIndex] = nil
							value[1] = time
							value[2] = healthPercentage
						end
						table.insert(values, 1, value)
						local n = #values
						-- Delete values that are no longer valid
						while (n > historyCount) or (time - values[n][1] > historyTime) do
							cache[#cache + 1] = values[n]
							values[n] = nil
							n = n - 1
						end
					end
				end
			end
		end
	end
end

function aura_env.TimeToX(guid, percentage, minSamples)
	--if self:IsDummy() then return 6666 end
	--if self:IsAPlayer() and Player:CanAttack(self) then return 25 end
	local seconds = 8888
	local unitTable = units[guid]
	-- Simple linear regression
	-- ( E(x^2)  E(x) )  ( a )  ( E(xy) )
	-- ( E(x)     n  )  ( b ) = ( E(y)  )
	-- Format of the above: ( 2x2 Matrix ) * ( 2x1 Vector ) = ( 2x1 Vector )
	-- Solve to find a and b, satisfying y = a + bx
	-- Matrix arithmetic has been expanded and solved to make the following operation as fast as possible
	if unitTable then
		local values = unitTable[1]
		local n = #values
		if n > minSamples then
			local a, b = 0, 0
			local Ex2, Ex, Exy, Ey = 0, 0, 0, 0

			local value, x, y
			for i = 1, n do
				value = values[i]
				x, y = value[1], value[2]

				Ex2 = Ex2 + x * x
				Ex = Ex + x
				Exy = Exy + x * y
				Ey = Ey + y
			end
			-- invariant to find matrix inverse
			local invariant = 1 / (Ex2 * n - Ex * Ex)
			-- Solve for a and b
			a = (-Ex * Exy * invariant) + (Ex2 * Ey * invariant)
			b = (n * Exy * invariant) - (Ex * Ey * invariant)
			if b ~= 0 then
				-- Use best fit line to calculate estimated time to reach target health
				seconds = (percentage - a) / b
				-- Subtract current time to obtain "time remaining"
				seconds = math.min(7777, seconds - (GetTime() - unitTable[2]))
				if seconds < 0 then
					seconds = 9999
				end
			end
		end
	end
	return seconds
end

function aura_env.click(but)
	ActionButtonDown(but)
	ActionButtonUp(but)
	C_Timer.After(
		0.1,
		function()
			ActionButtonDown(but)
			ActionButtonUp(but)
		end
	)

	C_Timer.After(
		0.3,
		function()
			ActionButtonDown(but)
			ActionButtonUp(but)
		end
	)
end
