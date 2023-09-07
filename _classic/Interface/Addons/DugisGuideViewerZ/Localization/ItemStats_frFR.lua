if GetLocale() ~= "frFR" then return end
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
		statLookup[RESISTANCE1_NAME] = "HOLY_RES";
		statLookup[RESISTANCE2_NAME] = "FIRE_RES";
		statLookup[RESISTANCE3_NAME] = "NATURE_RES";
		statLookup[RESISTANCE4_NAME] = "FROST_RES";
		statLookup[RESISTANCE5_NAME] = "SHADOW_RES";
		statLookup[RESISTANCE6_NAME] = "ARCANE_RES";
		statLookup[ITEM_MOD_BLOCK_VALUE_SHORT] = "BLOCK_VALUE";
		statLookup[ITEM_MOD_ATTACK_POWER_SHORT] = "ATTACK_POWER";
		statLookup[DAMAGE_TOOLTIP] = "DAMAGE";
		statLookup[DAMAGE] = "DAMAGE";
		statLookup[STAT_SPEED] = "SPEED";
		statLookup[STAT_ATTACK_SPEED] = "SPEED";
		statLookup["Bloquer"] = "BLOCK_VALUE";
		statLookup["Armure renforcée"] = "ARMOR";
		statLookup["Sorts de soins"] = "HEALING_SPELL_POWER";
		statLookup["Toutes les caractéristiques"] = GetCreateTable("STA","INT","AGI","STR","SPI");
		statLookup["mana"] = "MANA_REGEN"; --Equipé : Rend 2 points de mana toutes les 5 secondes.
		statLookup["vie"] = "HEALTH_REGEN"; --Equipé : Rend 2 points de vie toutes les 5 sec.
		statLookup["Défense augmentée de"] = "DEFENSE"; --Equipé : Défense augmentée de 17.
		statLookup["à la puissance d'attaque"] = "ATTACK_POWER"; --Equipé : +12 à la puissance d'attaque.
		statLookup["Augmente les soins et dégâts produits par les sorts et effets magiques de"] = "SPELL_POWER"; --Equipé : Augmente les soins et dégâts produits par les sorts et effets magiques de 6 au maximum.
		statLookup["Augmente le score de blocage de votre bouclier de"] = "BLOCK_VALUE"; --Equipé : Augmente le score de blocage de votre bouclier de 23.
		statLookup["Augmente vos chances de bloquer les attaques avec un bouclier de"] = "BLOCK_CHANCE"; --Equipé : Augmente vos chances de bloquer les attaques avec un bouclier de 2%.
		statLookup["Augmente vos chances d'esquiver une attaque de"] = "DODGE_CHANCE"; --Equipé : Augmente vos chances d'esquiver une attaque de 1%.
		statLookup["Augmente vos chances d'infliger un coup critique de"] = "CRIT_CHANCE"; --Equipé : Augmente vos chances d'infliger un coup critique de 1%.
		statLookup["Augmente vos chances de toucher de"] = "HIT_CHANCE"; --Equipé : Augmente vos chances de toucher de 1%.
		statLookup["Augmente vos chances de toucher avec des sorts de"] = "SPELL_HIT_CHANCE"; --Equipé : Augmente vos chances de toucher avec des sorts de 1%.
		statLookup["Augmente vos chances d'infliger un coup critique avec vos sorts de"] = "SPELL_CRIT_CHANCE"; --Equipé : Augmente vos chances d'infliger un coup critique avec vos sorts de 1%.
		statLookup["Augmente vos chances de parer une attaque de"] = "PARRY_CHANCE"; --Equipé : Augmente vos chances de parer une attaque de 1%.
		statLookup["à la puissance d'attaque pour les formes de félin, d'ours et d'ours redoutable uniquement"] = "FERAL_ATTACK_POWER"; --Equipé : +280 à la puissance d'attaque pour les formes de félin, d'ours et d'ours redoutable uniquement.
		statLookup["à la puissance des attaques à distance"] = "RANGED_ATTACK_POWER"; --Equipé : +14 à la puissance des attaques à distance.
		statLookup["Diminue les résistances magiques des cibles de vos sorts de"] = "SPELL_PENETRATION"; --Equipé : Diminue les résistances magiques des cibles de vos sorts de 10.
		statLookup["Augmente les soins prodigués par les sorts et effets de"] = "HEALING_SPELL_POWER"; --Equipé : Augmente les soins prodigués par les sorts et effets de 24 au maximum.
		statLookup["Augmente les dégâts infligés par les sorts et effets des Arcanes de"] = "ARCANE_SPELL_POWER"; --Equipé : Augmente les dégâts infligés par les sorts et effets des Arcanes de 14 au maximum.
		statLookup["Augmente les dégâts infligés par les sorts et effets de Feu de"] = "FIRE_SPELL_POWER"; --Equipé : Augmente les dégâts infligés par les sorts et effets de Feu de 7 au maximum.
		statLookup["Augmente les dégâts infligés par les sorts et effets de Givre de"] = "FROST_SPELL_POWER"; --Equipé : Augmente les dégâts infligés par les sorts et effets de Givre de 10 au maximum.
		statLookup["Augmente les dégâts infligés par les sorts et effets d'Ombre de"] = "SHADOW_SPELL_POWER"; --Equipé : Augmente les dégâts infligés par les sorts et effets d'Ombre de 11 au maximum.
		statLookup["Augmente les dégâts infligés par les sorts et effets du Sacré de"] = "HOLY_SPELL_POWER"; --Equipé : Augmente les dégâts infligés par les sorts et effets du Sacré de 16 au maximum.
		statLookup["Augmente les dégâts infligés par les sorts et effets de Nature de"] = "NATURE_SPELL_POWER"; --Equipé : Augmente les dégâts infligés par les sorts et effets de Nature de 19 au maximum.
		statLookup["Pêche augmentée de"] = "FISHING" --Equipé : Pêche augmentée de 5.
	end

	function ISL.ParseText(line)
		--No numerals, skip this line to save cycles.
		if not FindCaptures(line, "(%d)") then return end

		--One number("+" optional), followed by one word. No punctuation, no parens.
		--e.g. +1 Esprit
		local value, statKey  = FindCaptures(line, "^%+?(%d+) ([%aé'âà']+)$")
		if statKey then
			return SelectValueThenStats(statKey, value)
		end
		if strsub(line, 1, 10)=="Dégâts :" then --Dégâts : 10 - 16
			local valueLow, valueHigh = FindCaptures(line, "^Dégâts : (%d+) %- (%d+)$")
			if valueLow then
				return (tonumber(valueLow)+tonumber(valueHigh))/2, "DAMAGE"
			end
		end
		
		local value, statKey = FindCaptures(line,"^%((%d+%.?%d*) (dégâts par seconde)%)$") --(5.0 dégâts par seconde)
		if statKey then
			return tonumber(value), "DPS"
		end
		
		if strsub(line, 1, #ITEM_SPELL_TRIGGER_ONEQUIP)==ITEM_SPELL_TRIGGER_ONEQUIP then
			statKey, value  = FindCaptures(line,"^Equipé : ([%aéê'âà',%s]+) (%d+)%%?%s?a?u?%s?m?a?x?i?m?u?m?%.$")
			if statKey then
				return SelectValueThenStats(statKey, value)
			end

			value, statKey  = FindCaptures(line,"^Equipé : Rend (%d+) points de (%a+) toutes les 5 seco?n?d?e?s?%.$")
			if statKey then
				return SelectValueThenStats(statKey, value)
			end

			value, statKey  = FindCaptures(line,"^Equipé : %+(%d+) ([%aéê'âà',%s]+)%.$")
			if statKey then
				return SelectValueThenStats(statKey, value)
			end
		end

		--One number("+" optional), followed by two, three or four words.
		value, statKey  = FindCaptures(line, "^%+?(%d+) ([%aé'âà',]+%s[%aé'âà',]+%s?[%aé'âà',]*%s?[%aé'âà',]*)$")
		if statKey then
			return SelectValueThenStats(statKey, value)
		end

		--One word, followed by one number("+" optional)
		statKey, value  = FindCaptures(line, "^([%aé'âà']+)%s?:? %+?(%d+,?%d*)$")
		if statKey then
			return SelectValueThenStats(statKey, value:gsub(',', '.'))
		end

		--Two, three or four words, followed by one number("+" optional)
		statKey, value  = FindCaptures(line, "^([%aé'âà',]+%s[%aé'âà',]+%s?[%aé'âà',]*%s?[%aé'âà',]*)%s?:? %+?(%d+)$")
		if statKey then
			return SelectValueThenStats(statKey)
		end
	end

	function ISL:Load()
		FindCaptures, SelectValueThenStats, GetCreateTable = 
			DGV.Modules.ItemStats.FindCaptures, DGV.Modules.ItemStats.SelectValueThenStats, DGV.GetCreateTable
	end
end