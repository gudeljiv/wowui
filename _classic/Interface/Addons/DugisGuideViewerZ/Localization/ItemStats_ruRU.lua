if GetLocale() ~= "ruRU" then return end
local _, GetCreateTable, FindCaptures, SelectValueThenStats
local DGV = DugisGuideViewer
local ISL = DGV:RegisterModule("ItemStatsLocal")
ISL.essential = true

function ISL:Initialize()

	function ISL.PopulateFlattenedStatLookup(statLookup)
		statLookup[ITEM_MOD_STAMINA_SHORT] = "STA"; --+1 к выносливости
		statLookup[ITEM_MOD_INTELLECT_SHORT] = "INT"; --+1 к интеллекту
		statLookup[ITEM_MOD_AGILITY_SHORT ] = "AGI"; --+4 к ловкости
		statLookup[ITEM_MOD_STRENGTH_SHORT] = "STR"; --+1 к силе
		statLookup[ITEM_MOD_SPIRIT_SHORT] = "SPI"; --+1 к духу
		statLookup[ARMOR] = "ARMOR"; --Броня: 5
		statLookup[DEFENSE] = "DEFENSE";
		statLookup[MANA] = "MANA";
		statLookup[HEALTH] = "HEALTH";
		statLookup[BLOCK] = "BLOCK_VALUE";
		statLookup[RESISTANCE1_NAME] = "HOLY_RES";
		statLookup[RESISTANCE2_NAME] = "FIRE_RES";
		statLookup[RESISTANCE3_NAME] = "NATURE_RES";
		statLookup[RESISTANCE4_NAME] = "FROST_RES";
		statLookup[RESISTANCE5_NAME] = "SHADOW_RES";
		statLookup[RESISTANCE6_NAME] = "ARCANE_RES";
		statLookup[ITEM_MOD_BLOCK_VALUE_SHORT] = "BLOCK_VALUE";
		statLookup["Блокирование"] = "BLOCK_VALUE"; --Блокирование: 46
		statLookup[ITEM_MOD_ATTACK_POWER_SHORT] = "ATTACK_POWER";
		statLookup["Увеличивает силу атаки на"] = "ATTACK_POWER"; --Если на персонаже: Увеличивает силу атаки на 12.
		statLookup[DAMAGE_TOOLTIP] = "DAMAGE";
		statLookup[DAMAGE] = "DAMAGE";
		statLookup[STAT_SPEED] = "SPEED";
		statLookup[STAT_ATTACK_SPEED] = "SPEED";
		statLookup["Усиленная броня"] = "ARMOR";
		statLookup["Увеличение рейтинга защиты на"] = "DEFENSE"; --Если на персонаже: Увеличение рейтинга защиты на 17 ед.
		statLookup["к лечению"] = "HEALING_SPELL_POWER"; --+55 к лечению
		statLookup["ко всем характеристикам"] = GetCreateTable("STA","INT","AGI","STR","SPI"); --+3 ко всем характеристикам
		statLookup["маны раз в"] = "MANA_REGEN"; --Если на персонаже: Восполнение 2 ед. маны раз в 5 сек.
		statLookup["здоровья каждые"] = "HEALTH_REGEN"; --Если на персонаже: Восполняет 2 ед. здоровья каждые 5 сек.
		statLookup["Увеличение урона и целительного действия магических заклинаний и эффектов не более чем на"] = "SPELL_POWER"; --Если на персонаже: Увеличение урона и целительного действия магических заклинаний и эффектов не более чем на 6 ед.
		statLookup["Увеличение показателя блока щитом на"] = "BLOCK_VALUE"; --Если на персонаже: Увеличение показателя блока щитом на 23 ед.
		statLookup["Увеличение рейтинга блока щитом на"] = "BLOCK_CHANCE"; --Если на персонаже: Увеличение рейтинга блока щитом на 2%,
		statLookup["Увеличение рейтинга уклонения на"] = "DODGE_CHANCE"; --Если на персонаже: Увеличение рейтинга уклонения на 1%.
		statLookup["Увеличение вероятности нанесения критического урона на"] = "CRIT_CHANCE"; --Если на персонаже: Увеличение вероятности нанесения критического урона на 1%.
		statLookup["Вероятность нанесения удара увеличена на"] = "HIT_CHANCE"; --Если на персонаже: Вероятность нанесения удара увеличена на 1%.
		statLookup["Увеличение рейтинга критического эффекта заклинаний на"] = "SPELL_CRIT_CHANCE"; --Если на персонаже: Увеличение рейтинга критического эффекта заклинаний на 1%.
		statLookup["Увеличение рейтинга парирования атак на"] = "PARRY_CHANCE"; --Если на персонаже: Увеличение рейтинга парирования атак на 1%.
		statLookup["Увеличение силы атаки в дальнем бою на"] = "RANGED_ATTACK_POWER"; --Если на персонаже: Увеличение силы атаки в дальнем бою на 14 ед.
		statLookup["Снижает сопротивление магии целей ваших заклинаний на"] = "SPELL_PENETRATION"; --Если на персонаже: Снижает сопротивление магии целей ваших заклинаний на 10.
		statLookup["Усиливает исцеление от заклинаний и эффектов максимум на"] = "HEALING_SPELL_POWER"; --Если на персонаже: Усиливает исцеление от заклинаний и эффектов максимум на 24 ед.
		statLookup["Увеличение урона, наносимого заклинаниями и эффектами тайной магии, на"] = "ARCANE_SPELL_POWER"; --Если на персонаже: Увеличение урона, наносимого заклинаниями и эффектами тайной магии, на 14 ед.
		statLookup["Увеличение наносимого урона от заклинаний и эффектов огня не более чем на"] = "FIRE_SPELL_POWER"; --Если на персонаже: Увеличение наносимого урона от заклинаний и эффектов огня не более чем на 7 ед.
		statLookup["Увеличение урона, наносимого заклинаниями и эффектами льда, на"] = "FROST_SPELL_POWER"; --Если на персонаже: Увеличение урона, наносимого заклинаниями и эффектами льда, на 10 ед.
		statLookup["Увеличение урона, наносимого заклинаниями и эффектами темной магии, на"] = "SHADOW_SPELL_POWER"; --Если на персонаже: Увеличение урона, наносимого заклинаниями и эффектами темной магии, на 11 ед.
		statLookup["Увеличение урона, наносимого заклинаниями и эффектами светлой магии, на"] = "HOLY_SPELL_POWER"; --Если на персонаже: Увеличение урона, наносимого заклинаниями и эффектами светлой магии, на 16 ед.
		statLookup["Увеличение урона, наносимого заклинаниями и эффектами сил природы, на"] = "NATURE_SPELL_POWER"; --Если на персонаже: Увеличение урона, наносимого заклинаниями и эффектами сил природы, на 19 ед.
		statLookup["Увеличение навыка \"Рыбная ловля\" на"] = "FISHING"; --Если на персонаже: Увеличение навыка "Рыбная ловля" на +5.
	end

	function ISL.ParseText(line)
		--No numerals, skip this line to save cycles.
		if not FindCaptures(line, "(%d)") then return end

		--+4 к ловкости
		local value, statKey  = FindCaptures(line, "^%+?(%d+) (к [^d%s]+)$")
		if statKey then
			return SelectValueThenStats(statKey, value)
		end
		if strsub(line, 1, #"Урон:")=="Урон:" then --Урон: 10-16
			local valueLow, valueHigh = FindCaptures(line, "^Урон: (%d+)%-(%d+)$")
			if valueLow then
				return (tonumber(valueLow)+tonumber(valueHigh))/2, "DAMAGE"
			end
		end
		
		local value, statKey = FindCaptures(line,"^%((%d+%.?%d*) (ед. урона в секунду)%)$") --(5.0 ед. урона в секунду)
		if statKey then
			return tonumber(value), "DPS"
		end
		
		if strsub(line, 1, #ITEM_SPELL_TRIGGER_ONEQUIP)==ITEM_SPELL_TRIGGER_ONEQUIP then
			statKey, value  = FindCaptures(line,"^Если на персонаже: ([^%d]-) %+?(%d+)[%%%sед]*[%.,]$")
			if statKey then
				return SelectValueThenStats(statKey, value)
			end

			value, statKey  = FindCaptures(line,"^Если на персонаже: Восполн[^%s]+ (%d+) ед. ([^d]+) 5 сек%.$")
			if statKey then
				return SelectValueThenStats(statKey, value)
			end

			--Если на персонаже: Увеличивает силу атаки на 280 ед. в облике кошки, медведя и лютого медведя.
			value = FindCaptures(line,"^Если на персонаже: Увеличивает силу атаки на (%d+) ед%. в облике кошки, медведя и лютого медведя%.$")
			if value then
				return tonumber(value), "FERAL_ATTACK_POWER"
			end

			--Если на персонаже: Повышение на 1% рейтинга меткости заклинаний.
			value = FindCaptures(line, "^Если на персонаже: Повышение на (%d+)%% рейтинга меткости заклинаний%.$")
			if value then
				return tonumber(value), "SPELL_HIT_CHANCE"
			end
		end

		--One number("+" optional), followed by two, three or four words.
		value, statKey  = FindCaptures(line, "^%+?(%d+) ([^d%s]+%s[^d%s]+%s?[^d%s]*%s?[^d%s]*)$")
		if statKey then
			return SelectValueThenStats(statKey, value)
		end

		--One word, followed by one number("+" optional)
		statKey, value  = FindCaptures(line, "^([^d%s:]+):? %+?(%d+,?%d*)$")
		if statKey then
			return SelectValueThenStats(statKey, value:gsub(',', '.'))
		end

		--Two, three or four words, followed by one number("+" optional)
		statKey, value  = FindCaptures(line, "^([^d%s]+%s[^d%s:]+%s?[^d%s:]*%s?[^d%s:]*):? %+?(%d+)$")
		if statKey then
			return SelectValueThenStats(statKey, value)
		end
		
		-- +11 к урону от заклинаний и лечению\	
		value = FindCaptures(line, "^%+(%d+) к урону от заклинаний и лечению$")	
		if value then
		   addStat("SPELL_POWER", value)
		   return
		end		
	end

	function ISL:Load()
		FindCaptures, SelectValueThenStats, GetCreateTable = 
			DGV.Modules.ItemStats.FindCaptures, DGV.Modules.ItemStats.SelectValueThenStats, DGV.GetCreateTable
	end
end