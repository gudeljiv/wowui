if GetLocale() ~= "esES" then return end
local _, GetCreateTable, FindCaptures, SelectValueThenStats
local DGV = DugisGuideViewer
local ISL = DGV:RegisterModule("ItemStatsLocal")
ISL.essential = true

function ISL:Initialize()

	function ISL.PopulateFlattenedStatLookup(statLookup)
		statLookup[ITEM_MOD_STAMINA_SHORT] = "STA";
		statLookup[ITEM_MOD_INTELLECT_SHORT] = "INT";
		statLookup[ITEM_MOD_AGILITY_SHORT ] = "AGI";
		statLookup[ITEM_MOD_STRENGTH_SHORT] = "STR";
		statLookup[ITEM_MOD_SPIRIT_SHORT] = "SPI";
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
		statLookup["bloquear"] = "BLOCK_VALUE";
		statLookup[ITEM_MOD_ATTACK_POWER_SHORT] = "ATTACK_POWER";
		statLookup["de poder de ataque"] = "ATTACK_POWER"; --Equipar: +12 p. de poder de ataque.
		statLookup[DAMAGE_TOOLTIP] = "DAMAGE";
		statLookup[DAMAGE] = "DAMAGE";
		statLookup[STAT_SPEED] = "SPEED";
		statLookup[STAT_ATTACK_SPEED] = "SPEED";
		statLookup["Armadura reforzada"] = "ARMOR";
		statLookup["armadura"] = "ARMOR"; --5 armadura
		statLookup["Defensa aumentada"] = "DEFENSE"; --Equipar: Defensa aumentada +17.
		statLookup["Hechizos Curativos"] = "HEALING_SPELL_POWER";
		statLookup["Todas las estadísticas"] = GetCreateTable("STA","INT","AGI","STR","SPI");
		statLookup["de maná cada"] = "MANA_REGEN"; --Equipar: Restaura 2 p. de maná cada 5 s.
		statLookup["de salud cada"] = "HEALTH_REGEN"; --Equipar: Restaura 5 p. de salud cada 5 s.
		statLookup["Aumenta el daño y la curación de los hechizos mágicos y los efectos hasta en"] = "SPELL_POWER"; --Equipar: Aumenta el daño y la curación de los hechizos mágicos y los efectos hasta en 6 p.
		statLookup["Aumenta el valor de bloqueo de tu escudo en"] = "BLOCK_VALUE"; --Equipar: Aumenta el valor de bloqueo de tu escudo en 23 p.
		statLookup["Aumenta la probabilidad de bloquear ataques con un escudo en un"] = "BLOCK_CHANCE"; --Equipar: Aumenta la probabilidad de bloquear ataques con un escudo en un 2%.
		statLookup["Aumenta la probabilidad de esquivar un ataque en un"] = "DODGE_CHANCE"; --Equipar: Aumenta la probabilidad de esquivar un ataque en un 1%.
		statLookup["Mejora tu probabilidad de conseguir un golpe crítico en"] = "CRIT_CHANCE"; --Equipar: Mejora tu probabilidad de conseguir un golpe crítico en 1%.
		statLookup["Mejora tu probabilidad de alcanzar el objetivo en un"] = "HIT_CHANCE"; --Equipar: Mejora tu probabilidad de alcanzar el objetivo en un 1%.
		statLookup["Mejora tu probabilidad de alcanzar el objetivo con hechizos en un"] = "SPELL_HIT_CHANCE"; --Equipar: Mejora tu probabilidad de alcanzar el objetivo con hechizos en un 1%.
		statLookup["Aumenta la probabilidad de parar un ataque en un"] = "PARRY_CHANCE"; --Equipar: Aumenta la probabilidad de parar un ataque en un 1%.
		statLookup["de poder de ataque solo bajo formas felinas, de oso y de oso nefasto"] = "FERAL_ATTACK_POWER"; --Equipar: +280 p. de poder de ataque solo bajo formas felinas, de oso y de oso nefasto.
		statLookup["de poder de ataque a distancia"] = "RANGED_ATTACK_POWER"; --Equipar: +14 p. de poder de ataque a distancia.
		statLookup["Reduce las resistencias mágicas de los objetivos de tus hechizos en"] = "SPELL_PENETRATION"; --Equipar: Reduce las resistencias mágicas de los objetivos de tus hechizos en 10 p.
		statLookup["Aumenta la curación de los hechizos y los efectos hasta en"] = "HEALING_SPELL_POWER"; --Equipar: Aumenta la curación de los hechizos y los efectos hasta en 24 p.
		statLookup["Aumenta el daño causado por los hechizos Arcanos y los efectos hasta en"] = "ARCANE_SPELL_POWER"; --Equipar: Aumenta el daño causado por los hechizos Arcanos y los efectos hasta en 14 p.
		statLookup["Aumenta el daño causado por los hechizos de Fuego y los efectos hasta en"] = "FIRE_SPELL_POWER"; --Equipar: Aumenta el daño causado por los hechizos de Fuego y los efectos hasta en 7 p.
		statLookup["Aumenta el daño causado por los hechizos de Escarcha y los efectos hasta en"] = "FROST_SPELL_POWER"; --Equipar: Aumenta el daño causado por los hechizos de Escarcha y los efectos hasta en 10 p.
		statLookup["Aumenta el daño causado por los hechizos de Sombras y los efectos hasta en"] = "SHADOW_SPELL_POWER"; --Equipar: Aumenta el daño causado por los hechizos de Sombras y los efectos hasta en 11 p.
		statLookup["Aumenta el daño causado por los hechizos Sagrados y los efectos hasta en"] = "HOLY_SPELL_POWER"; --Equipar: Aumenta el daño causado por los hechizos Sagrados y los efectos hasta en 16 p.
		statLookup["Aumenta el daño causado por los hechizos de Naturaleza y los efectos hasta en"] = "NATURE_SPELL_POWER"; --Equipar: Aumenta el daño causado por los hechizos de Naturaleza y los efectos hasta en 19 p.
		statLookup["Pesca aumentada"] = "FISHING"; ----Equipar: Pesca aumentada +5.
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

		if strsub(line, #line-4)=="Daño" then --10 - 16 Daño
			local valueLow, valueHigh = FindCaptures(line, "^(%d+) %- (%d+) Daño$")
			if valueLow then
				return (tonumber(valueLow)+tonumber(valueHigh))/2, "DAMAGE"
			end
		end
		
		local value, statKey = FindCaptures(line,"^%((%d+%.?%d*) (daño por segundo)%)$") --(6.0 p. de daño por segundo)
		if statKey then
			return tonumber(value), "DPS"
		end
		
		if strsub(line, 1, #ITEM_SPELL_TRIGGER_ONEQUIP)==ITEM_SPELL_TRIGGER_ONEQUIP then
			statKey, value  = FindCaptures(line,"^Equipar: ([^%d]-) %+?(%d+)%s?p?%%?%.$")
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

			--Equipar: Mejora tu probabilidad de conseguir un golpe crítico en 1% con los hechizos.
			value = FindCaptures(line, "^Equipar: Mejora tu probabilidad de conseguir un golpe crítico en (%d+)%% con los hechizos%.$")
			if value then
				return tonumber(value), "SPELL_CRIT_CHANCE"
			end
		end

		--One number("+" optional), followed by two, three or four words.
		value, statKey  = FindCaptures(line, "^%+?(%d+,?%d*)%s?p?%.? (%a+%s%a+%s?%a*%s?%a*)$")
		if statKey then
			return SelectValueThenStats(statKey, value:gsub(',', '.'))
		end

		--One word, followed by one number("+" optional)
		statKey, value  = FindCaptures(line, "^(%a+) %+?(%d+,?%d*)%s?p?%.?$")
		if statKey then
			return SelectValueThenStats(statKey, value:gsub(',', '.'))
		end

		--Two, three or four words, followed by one number("+" optional)
		statKey, value  = FindCaptures(line, "^(%a+%s%a+%s?%a*%s?%a*) %+?(%d+,?%d*)%s?p?%.?$")
		if statKey then
			return SelectValueThenStats(statKey, value:gsub(',', '.'))
		end
	end

	function ISL:Load()
		FindCaptures, SelectValueThenStats, GetCreateTable = 
			DGV.Modules.ItemStats.FindCaptures, DGV.Modules.ItemStats.SelectValueThenStats, DGV.GetCreateTable
	end
end