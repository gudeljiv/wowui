if GetLocale() ~= "deDE" then return end
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
		statLookup["Tempo"] = "SPEED";
		statLookup["Verstärkte Rüstung"] = "ARMOR";
		statLookup["Heilzauber"] = "HEALING_SPELL_POWER";
		statLookup["Alle Werte"] = GetCreateTable("STA","INT","AGI","STR","SPI");
		statLookup["Punkt(e) Mana"] = "MANA_REGEN"; --Anlegen: Stellt alle 5 Sek. 2 Punkt(e) Mana wieder her.
		statLookup["Gesundheit"] = "HEALTH_REGEN"; --Anlegen: Stellt alle 5 Sek. 2 Gesundheit wieder her.
		statLookup["Punkt(e) Gesundheit"] = "HEALTH_REGEN"; --Anlegen: Stellt alle 5 Sek. 5 Punkt(e) Gesundheit wieder her.
		statLookup["Erhöht durch Zauber und magische Effekte zugefügten Schaden und Heilung um bis zu"] = "SPELL_POWER"; --Anlegen: Erhöht durch Zauber und magische Effekte zugefügten Schaden und Heilung um bis zu 6.
		statLookup["Erhöht den Blockwert Eures Schildes um"] = "BLOCK_VALUE"; --Anlegen: Erhöht den Blockwert Eures Schildes um 23.
		statLookup["Erhöht Eure Chance, Angriffe mit einem Schild zu blocken, um"] = "BLOCK_CHANCE"; --Anlegen: Erhöht Eure Chance, Angriffe mit einem Schild zu blocken, um 2%.
		statLookup["Erhöht Eure Chance, einem Angriff auszuweichen, um"] = "DODGE_CHANCE"; --Anlegen: Erhöht Eure Chance, einem Angriff auszuweichen, um 1%.
		statLookup["Erhöht Eure Chance, einen kritischen Treffer zu erzielen, um"] = "CRIT_CHANCE"; --Anlegen: Erhöht Eure Chance, einen kritischen Treffer zu erzielen, um 1%.
		statLookup["Verbessert Eure Trefferchance um"] = "HIT_CHANCE"; --Anlegen: Verbessert Eure Trefferchance um 1%.
		statLookup["Erhöht Eure Chance mit Zaubern zu treffen um"] = "SPELL_HIT_CHANCE"; --Anlegen: Erhöht Eure Chance mit Zaubern zu treffen um 1%.
		statLookup["Erhöht Eure Chance, einen kritischen Treffer durch Zauber zu erzielen, um"] = "SPELL_CRIT_CHANCE"; --Anlegen: Erhöht Eure Chance, einen kritischen Treffer durch Zauber zu erzielen, um 1%.
		statLookup["Erhöht Eure Chance, einen Angriff zu parieren, um"] = "PARRY_CHANCE"; --Anlegen: Erhöht Eure Chance, einen Angriff zu parieren, um 1%.
		statLookup["Angriffskraft in Katzengestalt, Bärengestalt oder Terrorbärengestalt"] = "FERAL_ATTACK_POWER"; --Anlegen: +280 Angriffskraft in Katzengestalt, Bärengestalt oder Terrorbärengestalt.
		statLookup["Distanzangriffskraft"] = "RANGED_ATTACK_POWER"; --Anlegen: +14 Distanzangriffskraft.
		statLookup["Reduziert die Magiewiderstände der Ziele Eurer Zauber um"] = "SPELL_PENETRATION"; --Anlegen: Reduziert die Magiewiderstände der Ziele Eurer Zauber um 10.
		statLookup["Erhöht durch Zauber und Effekte verursachte Heilung um bis zu"] = "HEALING_SPELL_POWER"; --Anlegen: Erhöht durch Zauber und Effekte verursachte Heilung um bis zu 24.
		statLookup["Erhöht durch Arkanzauber und Arkaneffekte zugefügten Schaden um bis zu"] = "ARCANE_SPELL_POWER"; --Anlegen: Erhöht durch Arkanzauber und Arkaneffekte zugefügten Schaden um bis zu 14.
		statLookup["Erhöht durch Feuerzauber und Feuereffekte zugefügten Schaden um bis zu"] = "FIRE_SPELL_POWER"; --Anlegen: Erhöht durch Feuerzauber und Feuereffekte zugefügten Schaden um bis zu 7.
		statLookup["Erhöht durch Frostzauber und Frosteffekte zugefügten Schaden um bis zu"] = "FROST_SPELL_POWER"; --Anlegen: Erhöht durch Frostzauber und Frosteffekte zugefügten Schaden um bis zu 10.
		statLookup["Erhöht durch Schattenzauber und Schatteneffekte zugefügten Schaden um bis zu"] = "SHADOW_SPELL_POWER"; --Anlegen: Erhöht durch Schattenzauber und Schatteneffekte zugefügten Schaden um bis zu 11.
		statLookup["Erhöht durch Heiligzauber und Heiligeffekte zugefügten Schaden um bis zu"] = "HOLY_SPELL_POWER"; --Anlegen: Erhöht durch Heiligzauber und Heiligeffekte zugefügten Schaden um bis zu 16.
		statLookup["Erhöht durch Naturzauber und Natureffekte zugefügten Schaden um bis zu"] = "NATURE_SPELL_POWER"; --Anlegen: Erhöht durch Naturzauber und Natureffekte zugefügten Schaden um bis zu 19.
		statLookup["Angeln"] = "FISHING"; --Anlegen: Angeln +5.
	end

	function ISL.ParseText(line)
		--No numerals, skip this line to save cycles.
		if not FindCaptures(line, "(%d)") then return end

		--One number("+" optional), followed by one word. No punctuation, no parens.
		--e.g. +1 Willenskraft
		local value, statKey  = FindCaptures(line, "^%+?(%d+) ([%aäüö]+)$")
		if statKey then
			return SelectValueThenStats(statKey, value)
		end

		if strsub(line, #line-6)=="Schaden" then --10 - 16 Schaden
			local valueLow, valueHigh = FindCaptures(line, "^(%d+) %- (%d+) Schaden$")
			if valueLow then
				return (tonumber(valueLow)+tonumber(valueHigh))/2, "DAMAGE"
			end
		end
		
		local value, statKey = FindCaptures(line,"^%((%d+%.?%d*) (Schaden pro Sekunde)%)$") --(3.7 Schaden pro Sekunde)
		if statKey then
			return tonumber(value), "DPS"
		end
		
		if strsub(line, 1, #ITEM_SPELL_TRIGGER_ONEQUIP)==ITEM_SPELL_TRIGGER_ONEQUIP then
			statKey, value  = FindCaptures(line,"^Anlegen: ([%aäüö%s,]+) (%d+)%%?%.$")
			if statKey then
				return SelectValueThenStats(statKey, value)
			end

			value, statKey  = FindCaptures(line,"^Anlegen: Stellt alle 5 Sek. (%d+) ([%a%(%)]+%s?%a*) wieder her%.$")
			if statKey then
				return SelectValueThenStats(statKey, value)
			end

			value, statKey  = FindCaptures(line,"^Anlegen: %+(%d+) ([%aäüö%s,]+)%.$")
			if statKey then
				return SelectValueThenStats(statKey, value)
			end

			statKey, value  = FindCaptures(line,"^Anlegen: ([%aäüö]+) %+(%d+)%.$")
			if statKey then
				return SelectValueThenStats(statKey, value)
			end
		end

		--One number("+" optional), followed by two words.
		value, statKey  = FindCaptures(line, "^%+?(%d+) ([%aäüö]+%s?[%aäüö]*)$")
		if statKey then
			return SelectValueThenStats(statKey, value)
		end

		--One word, followed by one number("+" optional)
		statKey, value  = FindCaptures(line, "^([%aäüö]+) %+?(%d+,?%d*)%.?$")
		if statKey then
			return SelectValueThenStats(statKey, value:gsub(',', '.'))
		end

		--Two words, followed by one number("+" optional)
		statKey, value  = FindCaptures(line, "^([%aäüö]+%s?[%aäüö]*) %+?(%d+)%.?$")
		if statKey then
			return SelectValueThenStats(statKey, value)
		end
	end

	function ISL:Load()
		FindCaptures, SelectValueThenStats, GetCreateTable = 
			DGV.Modules.ItemStats.FindCaptures, DGV.Modules.ItemStats.SelectValueThenStats, DGV.GetCreateTable
	end
end