if GetLocale() ~= "ptBR" then return end
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
		statLookup["Bloqueio de"] = "BLOCK_VALUE";
		statLookup[ITEM_MOD_ATTACK_POWER_SHORT] = "ATTACK_POWER";
		statLookup["de Poder de Ataque"] = "ATTACK_POWER";
		statLookup[DAMAGE_TOOLTIP] = "DAMAGE";
		statLookup[DAMAGE] = "DAMAGE";
		statLookup[STAT_SPEED] = "SPEED";
		statLookup[STAT_ATTACK_SPEED] = "SPEED";
		statLookup["Armadura Reforçada"] = "ARMOR";
		statLookup["de Armadura"] = "ARMOR";
		statLookup["Perícia Defesa Aumentada"] = "DEFENSE";
		statLookup["Feitiços de Cura"] = "HEALING_SPELL_POWER";
		statLookup["Todos os Atributos"] = GetCreateTable("STA","INT","AGI","STR","SPI");
		statLookup["de mana a cada"] = "MANA_REGEN";
		statLookup["pontos de vida a cada"] = "HEALTH_REGEN";
		statLookup["o dano causado e a cura realizada por feitiços e efeitos mágicos"] = "SPELL_POWER";
		statLookup["o valor de bloqueio do seu escudo"] = "BLOCK_VALUE";
		statLookup["a chance de bloquear ataques com o escudo"] = "BLOCK_CHANCE";
		statLookup["a chance de esquivar-se de ataques"] = "DODGE_CHANCE";
		statLookup["a chance de realizar acertos críticos"] = "CRIT_CHANCE";
		statLookup["a chance de realizar acertos críticos com feitiços"] = "SPELL_CRIT_CHANCE";
		statLookup["Defesa aumentada em"] = "DEFENSE";
		statLookup["a chance de acerto"] = "HIT_CHANCE";
		statLookup["sua chance de acertar com feitiços"] = "SPELL_HIT_CHANCE";
		statLookup["a sua chance de aparar ataques"] = "PARRY_CHANCE";
		statLookup["de Poder de Ataque sob forma de Felino, Urso e Urso Hediondo"] = "FERAL_ATTACK_POWER";
		statLookup["de Poder de Ataque de Longo Alcance"] = "RANGED_ATTACK_POWER";
		statLookup["as resistências mágicas dos alvos dos seus feitiços"] = "SPELL_PENETRATION";
		statLookup["a cura realizada por feitiços e efeitos mágicos"] = "HEALING_SPELL_POWER";
		statLookup["o dano causado por feitiços e efeitos Arcanos"] = "ARCANE_SPELL_POWER";
		statLookup["o dano causado por feitiços e efeitos de Fogo"] = "FIRE_SPELL_POWER";
		statLookup["o dano causado por feitiços e efeitos de Gelo"] = "FROST_SPELL_POWER";
		statLookup["o dano causado por feitiços e efeitos de Sombra"] = "SHADOW_SPELL_POWER";
		statLookup["o dano causado por feitiços e efeitos Sagrados"] = "HOLY_SPELL_POWER";
		statLookup["o dano causado por feitiços e efeitos de Natureza"] = "NATURE_SPELL_POWER";
		statLookup["a perícia em Pesca"] = "FISHING"; --Equipado: Aumenta em 5 a perícia em Pesca.
	end

	function ISL.ParseText(line)
		--No numerals, skip this line to save cycles.
		if not FindCaptures(line, "(%d)") then return end

		--One number("+" optional), followed by one word. No punctuation, no parens.
		--e.g. +4 Agilidade
		local value, statKey  = FindCaptures(line, "^%+?(%d+) ([^%d%s]+)$")
		if statKey then
			return SelectValueThenStats(statKey, value)
		end

		if strsub(line, #line-6)=="de dano" then
			local valueLow, valueHigh = FindCaptures(line, "^(%d+) %- (%d+) de dano$")
			if valueLow then
				return (tonumber(valueLow)+tonumber(valueHigh))/2, "DAMAGE"
			end
		end
		
		local value, statKey = FindCaptures(line,"^%((%d+%.?%d*) (de dano por segundo)%)$") --(0.9 de dano por segundo)
		if statKey then
			return tonumber(value), "DPS"
		end
		
		if strsub(line, 1, #ITEM_SPELL_TRIGGER_ONEQUIP)==ITEM_SPELL_TRIGGER_ONEQUIP then
			statKey, value  = FindCaptures(line,"^Equipado: ([^%d]-) %+?(%d+)%%?%.$")
			if statKey then
				return SelectValueThenStats(statKey, value)
			end

			value, statKey  = FindCaptures(line,"Equipado: %a+ em [até ]*(%d+)%%? ([^%d]+)%.$")
			if statKey then
				return SelectValueThenStats(statKey, value)
			end

			value, statKey  = FindCaptures(line,"^Equipado: %a+ (%d+) ([%a%s]+) 5 s%.$")
			if statKey then
				return SelectValueThenStats(statKey, value)
			end

			value, statKey  = FindCaptures(line,"^Equipado: %+(%d+) ([^%d]+)%.$")
			if statKey then
				return SelectValueThenStats(statKey, value)
			end
		end

		--One number("+" optional), followed by two or three words.
		value, statKey  = FindCaptures(line, "^%+?(%d+,?%d*) (%a+%s%a+%s?%a*)$")
		if statKey then
			return SelectValueThenStats(statKey, value:gsub(',', '.'))
		end

		--One word, followed by one number("+" optional)
		statKey, value  = FindCaptures(line, "^(%a+) %+?(%d+,?%d*)$")
		if statKey then
			return SelectValueThenStats(statKey, value:gsub(',', '.'))
		end

		--Two or three words, followed by one number("+" optional)
		statKey, value  = FindCaptures(line, "^(%a+%s%a+%s?%a*) %+?(%d+,?%d*)$")
		if statKey then
			return SelectValueThenStats(statKey, value:gsub(',', '.'))
		end
	end

	function ISL:Load()
		FindCaptures, SelectValueThenStats, GetCreateTable = 
			DGV.Modules.ItemStats.FindCaptures, DGV.Modules.ItemStats.SelectValueThenStats, DGV.GetCreateTable
	end
end