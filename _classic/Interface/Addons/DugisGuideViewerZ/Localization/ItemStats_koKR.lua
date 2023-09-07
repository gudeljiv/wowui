if GetLocale() ~= "koKR" then return end
local _, GetCreateTable, FindCaptures, SelectValueThenStats
local DGV = DugisGuideViewer
local ISL = DGV:RegisterModule("ItemStatsLocal")
ISL.essential = true

function ISL:Initialize()

	function ISL.PopulateFlattenedStatLookup(statLookup)
		statLookup[ITEM_MOD_STAMINA_SHORT] = "STA"; --체력 +1
		statLookup[ITEM_MOD_INTELLECT_SHORT] = "INT"; --지능 +1
		statLookup[ITEM_MOD_AGILITY_SHORT ] = "AGI"; --민첩성 +4
		statLookup[ITEM_MOD_STRENGTH_SHORT] = "STR"; --힘 +1
		statLookup[ITEM_MOD_SPIRIT_SHORT] = "SPI"; --정신력 +1
		statLookup[ARMOR] = "ARMOR"; --방어도 5
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
		statLookup["피해 방어"] = "BLOCK_VALUE"; --46의 피해 방어
		statLookup[ITEM_MOD_ATTACK_POWER_SHORT] = "ATTACK_POWER";
		statLookup["전투력"] = "ATTACK_POWER"; --착용 효과: 전투력 +12
		statLookup[DAMAGE_TOOLTIP] = "DAMAGE";
		statLookup[DAMAGE] = "DAMAGE";
		statLookup[STAT_SPEED] = "SPEED";
		statLookup[STAT_ATTACK_SPEED] = "SPEED";
		statLookup["속도"] = "SPEED";
		statLookup["방어 강화"] = "ARMOR";
		statLookup["방어 숙련도"] = "DEFENSE"; --착용 효과: 방어 숙련도 +17
		statLookup["치유 효과 증가"] = "HEALING_SPELL_POWER"; --치유 효과 증가 +55
		statLookup["모든 능력치"] = GetCreateTable("STA","INT","AGI","STR","SPI"); --모든 능력치 +4 
		statLookup["마나가"] = "MANA_REGEN"; --착용 효과: 매 5초마다 2의 마나가 회복됩니다.
		statLookup["생명력이"] = "HEALTH_REGEN"; --착용 효과: 매 5초마다 2의 생명력이 회복됩니다.
		statLookup["모든 주문 및 효과에 의한 피해와 치유량이 최대"] = "SPELL_POWER"; --착용 효과: 모든 주문 및 효과에 의한 피해와 치유량이 최대 6만큼 증가합니다.
		statLookup["방패의 피해 방어량이"] = "BLOCK_VALUE"; --착용 효과: 방패의 피해 방어량이 23만큼 증가합니다.
		statLookup["방패로 적의 공격을 방어할 확률이"] = "BLOCK_CHANCE"; --착용 효과: 방패로 적의 공격을 방어할 확률이 2%만큼 증가합니다.
		statLookup["공격을 회피할 확률이"] = "DODGE_CHANCE"; --착용 효과: 공격을 회피할 확률이 1%만큼 증가합니다.
		statLookup["치명타를 적중시킬 확률이"] = "CRIT_CHANCE"; --착용 효과: 치명타를 적중시킬 확률이 1%만큼 증가합니다.
		statLookup["무기의 적중률이"] = "HIT_CHANCE"; --착용 효과: 무기의 적중률이 1%만큼 증가합니다.
		statLookup["주문이 극대화 효과를 낼 확률이"] = "SPELL_CRIT_CHANCE"; --착용 효과: 주문이 극대화 효과를 낼 확률이 1%만큼 증가합니다.
		statLookup["무기 막기 확률이"] = "PARRY_CHANCE"; --착용 효과: 무기 막기 확률이 1%만큼 증가합니다.
		statLookup["원거리 전투력"] = "RANGED_ATTACK_POWER"; --착용 효과: 원거리 전투력 +14
		statLookup["자신의 주문에 대한 대상의 마법 저항력을"] = "SPELL_PENETRATION"; --착용 효과: 자신의 주문에 대한 대상의 마법 저항력을 10만큼 감소시킵니다.
		statLookup["모든 주문 및 효과에 의한 치유량이 최대"] = "HEALING_SPELL_POWER"; --착용 효과: 모든 주문 및 효과에 의한 치유량이 최대 24만큼 증가합니다.
		statLookup["비전 계열의 주문과 효과의 공격력이 최대"] = "ARCANE_SPELL_POWER"; --착용 효과: 비전 계열의 주문과 효과의 공격력이 최대 14만큼 증가합니다.
		statLookup["화염 계열의 주문과 효과의 공격력이 최대"] = "FIRE_SPELL_POWER"; --착용 효과: 화염 계열의 주문과 효과의 공격력이 최대 7만큼 증가합니다.
		statLookup["냉기 계열의 주문과 효과의 공격력이 최대"] = "FROST_SPELL_POWER"; --착용 효과: 냉기 계열의 주문과 효과의 공격력이 최대 10만큼 증가합니다.
		statLookup["암흑 계열의 주문과 효과의 공격력이 최대"] = "SHADOW_SPELL_POWER"; --착용 효과: 암흑 계열의 주문과 효과의 공격력이 최대 11만큼 증가합니다.
		statLookup["신성 계열의 주문과 효과의 공격력이 최대"] = "HOLY_SPELL_POWER"; --착용 효과: 신성 계열의 주문과 효과의 공격력이 최대 16만큼 증가합니다.
		statLookup["자연 계열의 주문과 효과의 공격력이 최대"] = "NATURE_SPELL_POWER"; --착용 효과: 자연 계열의 주문과 효과의 공격력이 최대 19만큼 증가합니다.
		statLookup["주문의 적중률이"] = "SPELL_HIT_CHANCE"; --착용 효과: 주문의 적중률이 1%만큼 증가합니다.
		statLookup["표범, 광포한 곰, 곰 변신 상태일 때 전투력이"] = "FERAL_ATTACK_POWER"; --착용 효과: 표범, 광포한 곰, 곰 변신 상태일 때 전투력이 280만큼 증가합니다.
		statLookup["낚시 숙련도"] = "FISHING"; --착용 효과: 낚시 숙련도 +5
	end

	function ISL.ParseText(line)
		--No numerals, skip this line to save cycles.
		if not FindCaptures(line, "(%d)") then return end

		--체력 +1
		--속도 1.70
		local statKey, value  = FindCaptures(line, "^([^d%s]+) %+?(%d+%.?%d*)$")
		if value then
			return SelectValueThenStats(statKey, value)
		end
		if strsub(line, 1, #"공격력")=="공격력" then --공격력 10 - 16
			local valueLow, valueHigh = FindCaptures(line, "^공격력 (%d+) %- (%d+)$")
			if valueLow then
				return (tonumber(valueLow)+tonumber(valueHigh))/2, "DAMAGE"
			end
		end
		
		local value = FindCaptures(line,"^%(초당 공격력 (%d+%.?%d*)%)$") --(초당 공격력 5.0)
		if value then
			return tonumber(value), "DPS"
		end
		
		local statKey
		if strsub(line, 1, #ITEM_SPELL_TRIGGER_ONEQUIP)==ITEM_SPELL_TRIGGER_ONEQUIP then
			statKey, value  = FindCaptures(line,"^착용 효과: ([^%d]+) %+?(%d+)[%%%s만큼 감소시킵만큼 증가합니다%.]*$")
			if statKey then
				return SelectValueThenStats(statKey, value)
			end

			value, statKey  = FindCaptures(line,"^착용 효과: 매 5초마다 (%d+)의 ([^%s]+) 회복됩니다%.$")
			if statKey then
				return SelectValueThenStats(statKey, value)
			end
		end

		--One number("+" optional), followed by one, two or three words.
		value, statKey  = FindCaptures(line, "^%+?(%d+)의? ([^d%s]+%s?[^d%s]*%s?[^d%s]*)$")
		if statKey then
			return SelectValueThenStats(statKey, value)
		end

		--Two or three words, followed by one number("+" optional)
		statKey, value  = FindCaptures(line, "^([^d%s]+%s[^d%s]+%s?[^d%s]*) %+?(%d+)$")
		if statKey then
			return SelectValueThenStats(statKey, value)
		end
	end

	function ISL:Load()
		FindCaptures, SelectValueThenStats, GetCreateTable = 
			DGV.Modules.ItemStats.FindCaptures, DGV.Modules.ItemStats.SelectValueThenStats, DGV.GetCreateTable
	end
end