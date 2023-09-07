if GetLocale() ~= "esMX" then return end
local _, GetCreateTable, FindCaptures, SelectValueThenStats
local DGV = DugisGuideViewer
local ISL = DGV:RegisterModule("ItemStatsLocal")
ISL.essential = true

function ISL:Initialize()

	function ISL.PopulateFlattenedStatLookup(statLookup)
		statLookup[SPELL_STAT3_NAME] = "STA";
		statLookup[SPELL_STAT4_NAME] = "INT";
		statLookup[SPELL_STAT2_NAME ] = "AGI";
		statLookup[SPELL_STAT1_NAME] = "STR";
		statLookup[SPELL_STAT5_NAME] = "SPI";
		statLookup[ARMOR] = "ARMOR";
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
		statLookup["bloqueo"] = "BLOCK_VALUE";
		statLookup[ITEM_MOD_ATTACK_POWER_SHORT] = "ATTACK_POWER";
		statLookup["el poder de ataque"] = "ATTACK_POWER";
		statLookup[DAMAGE_TOOLTIP] = "DAMAGE";
		statLookup[DAMAGE] = "DAMAGE";
		statLookup[STAT_SPEED] = "SPEED";
		statLookup[STAT_ATTACK_SPEED] = "SPEED";
		statLookup["Armadura reforzada"] = "ARMOR";
		statLookup["de armadura"] = "ARMOR";
		statLookup["el índice de defensa"] = "DEFENSE"; --Equipar: Aumenta 17 p. el índice de defensa.
		statLookup["Hechizos Curativos"] = "HEALING_SPELL_POWER";
		statLookup["Todas las estadísticas"] = GetCreateTable("STA","INT","AGI","STR","SPI");
		statLookup["de maná cada"] = "MANA_REGEN"; --Equipar: Restaura 2 p. de maná cada 5 s.
		statLookup["de salud cada"] = "HEALTH_REGEN"; --Equipar: Restaura 2 p. de salud cada 5 s.
		statLookup["el daño y la sanación de los hechizos y efectos mágicos"] = "SPELL_POWER"; --Equipar: Aumenta hasta 6 p. el daño y la sanación de los hechizos y efectos mágicos.
		statLookup["Aumenta el valor de bloqueo de tu escudo"] = "BLOCK_VALUE"; --Equipar: Aumenta el valor de bloqueo de tu escudo 23 p.
		statLookup["tu probabilidad de bloquear ataques con un escudo"] = "BLOCK_CHANCE"; --Equipar: Aumenta un 2% tu probabilidad de bloquear ataques con un escudo.
		statLookup["tu probabilidad de esquivar un ataque"] = "DODGE_CHANCE"; --Equipar: Aumenta un 1% tu probabilidad de esquivar un ataque.
		statLookup["tu probabilidad de conseguir un golpe crítico"] = "CRIT_CHANCE"; --Equipar: Mejora un 1% tu probabilidad de conseguir un golpe crítico.
		statLookup["Mejora tu probabilidad de asestar un golpe crítico con hechizos un"] = "SPELL_CRIT_CHANCE"; --Equipar: Mejora tu probabilidad de asestar un golpe crítico con hechizos un 1%.
		statLookup["Mejora tu probabilidad de golpear un"] = "HIT_CHANCE"; --Equipar: Mejora tu probabilidad de golpear un 1%.
		statLookup["tu probabilidad de golpear con hechizos"] = "SPELL_HIT_CHANCE"; --Equipar: Mejora un 1% tu probabilidad de golpear con hechizos.
		statLookup["tu probabilidad de parar un ataque"] = "PARRY_CHANCE"; --Equipar: Aumenta un 1% tu probabilidad de parar un ataque.
		statLookup["de poder de ataque solo en las formas felina, de oso y de oso temible"] = "FERAL_ATTACK_POWER"; --Equipar: +280 p. de poder de ataque solo en las formas felina, de oso y de oso temible.
		statLookup["el poder de ataque a distancia"] = "RANGED_ATTACK_POWER"; --Equipar: Aumenta 14 p. el poder de ataque a distancia.
		statLookup["Las resistencias mágicas de los objetivos de tus hechizos se reducen"] = "SPELL_PENETRATION"; --Equipar: Las resistencias mágicas de los objetivos de tus hechizos se reducen 10 p.
		statLookup["la sanación de los hechizos y efectos"] = "HEALING_SPELL_POWER"; --Equipar: Aumenta hasta 24 p. la sanación de los hechizos y efectos.
		statLookup["el daño que infligen los hechizos y efectos Arcanos"] = "ARCANE_SPELL_POWER"; --Equipar: Aumenta hasta 14 p. el daño que infligen los hechizos y efectos Arcanos.
		statLookup["el daño que infligen los hechizos y efectos de Fuego"] = "FIRE_SPELL_POWER"; --Equipar: Aumenta hasta 7 p. el daño que infligen los hechizos y efectos de Fuego.
		statLookup["el daño que infligen los hechizos y efectos de Escarcha"] = "FROST_SPELL_POWER"; --Equipar: Aumenta hasta 10 p. el daño que infligen los hechizos y efectos de Escarcha.
		statLookup["el daño que infligen los hechizos y efectos de las Sombras"] = "SHADOW_SPELL_POWER"; --Equipar: Aumenta hasta 11 p. el daño que infligen los hechizos y efectos de las Sombras.
		statLookup["el daño que infligen los hechizos y efectos Sagrados"] = "HOLY_SPELL_POWER"; --Equipar: Aumenta hasta 16 p. el daño que infligen los hechizos y efectos Sagrados.
		statLookup["el daño que infligen los hechizos y efectos de Naturaleza"] = "NATURE_SPELL_POWER"; --Equipar: Aumenta hasta 19 p. el daño que infligen los hechizos y efectos de Naturaleza.
		statLookup["Pesca aumentada"] = "FISHING"; --Equipar: Pesca aumentada +5 p.
	end

	function ISL.ParseText(line)
		--No numerals, skip this line to save cycles.
		if not FindCaptures(line, "(%d)") then return end

		--One number("+" optional), followed by one word. No punctuation, no parens.
		--e.g. +4 Espíritu
		local value, statKey  = FindCaptures(line, "^%+?(%d+) ([%aíá]+)$")
		if statKey then
			return SelectValueThenStats(statKey, value)
		end

		if strsub(line, #line-7)=="de daño" then
			local valueLow, valueHigh = FindCaptures(line, "^(%d+) %- (%d+) p%. de daño$")
			if valueLow then
				return (tonumber(valueLow)+tonumber(valueHigh))/2, "DAMAGE"
			end
		end
		
		local value, statKey = FindCaptures(line,"^%((%d+%.?%d*) (p. de daño por segundo)%)$") --(6.0 p. de daño por segundo)
		if statKey then
			return tonumber(value), "DPS"
		end
		
		if strsub(line, 1, #ITEM_SPELL_TRIGGER_ONEQUIP)==ITEM_SPELL_TRIGGER_ONEQUIP then
			statKey, value  = FindCaptures(line,"^Equipar: ([^%d]-) %+?(%d+)%s?p?%%?%.$")
			if statKey then
				return SelectValueThenStats(statKey, value)
			end

			value, statKey  = FindCaptures(line,"Equipar: %a+ %a*%s?(%d+)%s?p?%.?%%? ([^%d]+)%.$")
			if statKey then
				return SelectValueThenStats(statKey, value)
			end

			value, statKey  = FindCaptures(line,"^Equipar: Restaura (%d+) p. ([%aá%s]+) 5 s%.$")
			if statKey then
				return SelectValueThenStats(statKey, value)
			end

			value, statKey  = FindCaptures(line,"^Equipar: %+(%d+)%s?p?%.? ([^%d]+)%.$")
			if statKey then
				return SelectValueThenStats(statKey, value)
			end
		end

		--One number("+" optional), followed by two, three or four words.
		value, statKey  = FindCaptures(line, "^%+?(%d+%.?%d*)%s?p?%.? (%a+%s%a+%s?%a*%s?%a*)$")
		if statKey then
			return SelectValueThenStats(statKey, value)
		end

		--One word, followed by one number("+" optional)
		statKey, value  = FindCaptures(line, "^(%a+) %+?(%d+%.?%d*)%s?p?%.?$")
		if statKey then
			return SelectValueThenStats(statKey, value)
		end

		--Two, three or four words, followed by one number("+" optional)
		statKey, value  = FindCaptures(line, "^(%a+%s%a+%s?%a*%s?%a*) %+?(%d+%.?%d*)%s?p?%.?$")
		if statKey then
			return SelectValueThenStats(statKey, value)
		end
	end

	function ISL:Load()
		FindCaptures, SelectValueThenStats, GetCreateTable = 
			DGV.Modules.ItemStats.FindCaptures, DGV.Modules.ItemStats.SelectValueThenStats, DGV.GetCreateTable
	end
end