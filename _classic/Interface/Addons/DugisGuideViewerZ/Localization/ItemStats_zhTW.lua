if GetLocale() ~= "zhTW" then return end
local _, GetCreateTable, FindCaptures, SelectValueThenStats
local DGV = DugisGuideViewer
local ISL = DGV:RegisterModule("ItemStatsLocal")
ISL.essential = true

function ISL:Initialize()

	function ISL.PopulateFlattenedStatLookup(statLookup)
		statLookup[ITEM_MOD_STAMINA_SHORT] = "STA"; --+1耐力
		statLookup[ITEM_MOD_INTELLECT_SHORT] = "INT"; --+1智力
		statLookup[ITEM_MOD_AGILITY_SHORT ] = "AGI"; --+4敏捷
		statLookup[ITEM_MOD_STRENGTH_SHORT] = "STR"; --+1力量
		statLookup[ITEM_MOD_SPIRIT_SHORT] = "SPI"; --+1精神
		statLookup["點護甲"] = "ARMOR"; --5點護甲
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
		statLookup["格擋"] = "BLOCK_VALUE"; --46格擋
		statLookup[ITEM_MOD_ATTACK_POWER_SHORT] = "ATTACK_POWER";
		statLookup["전투력"] = "ATTACK_POWER"; --裝備： +12攻擊強度。
		statLookup[DAMAGE_TOOLTIP] = "DAMAGE";
		statLookup[DAMAGE] = "DAMAGE";
		statLookup[STAT_SPEED] = "SPEED";
		statLookup[STAT_ATTACK_SPEED] = "SPEED";
		statLookup["强化护甲"] = "ARMOR"; --强化护甲 +8
		statLookup["防禦技能提高"] = "DEFENSE"; --裝備： 防禦技能提高17點。
		statLookup["治疗法术"] = "HEALING_SPELL_POWER"; --治疗法术 +55
		statLookup["所有属性"] = GetCreateTable("STA","INT","AGI","STR","SPI"); --所有属性 +4
		statLookup["法"] = "MANA_REGEN"; --裝備： 每5秒恢復2點法力。
		statLookup["生命"] = "HEALTH_REGEN"; --裝備： 每5秒恢復2點生命力。
		statLookup["提高法術和魔法效果所造成的傷害和治療效果，最多"] = "SPELL_POWER"; --裝備： 提高法術和魔法效果所造成的傷害和治療效果，最多6點。
		statLookup["使你的盾牌格擋值提高"] = "BLOCK_VALUE"; --裝備： 使你的盾牌格擋值提高23點。
		statLookup["使你用盾牌格擋攻擊的機率提高"] = "BLOCK_CHANCE"; --裝備： 使你用盾牌格擋攻擊的機率提高2%。
		statLookup["使你躲閃攻擊的機率提高"] = "DODGE_CHANCE"; --裝備： 使你躲閃攻擊的機率提高1%。
		statLookup["使你造成致命一擊的機率提高"] = "CRIT_CHANCE"; --裝備： 使你造成致命一擊的機率提高1%。
		statLookup["使你擊中目標的機率提高"] = "HIT_CHANCE"; --裝備： 使你擊中目標的機率提高1%。
		statLookup["使你的法術造成致命一擊的機率提高"] = "SPELL_CRIT_CHANCE"; --裝備： 使你的法術造成致命一擊的機率提高1%。
		statLookup["使你招架攻擊的機率提高"] = "PARRY_CHANCE"; --裝備： 使你招架攻擊的機率提高1%。
		statLookup["遠程攻擊強度"] = "RANGED_ATTACK_POWER"; --裝備： +14遠程攻擊強度。
		statLookup["使你法術目標的魔法抗性降低"] = "SPELL_PENETRATION"; --裝備： 使你法術目標的魔法抗性降低10點。
		statLookup["提高法術和魔法效果所造成的治療效果，最多"] = "HEALING_SPELL_POWER"; --裝備： 提高法術和魔法效果所造成的治療效果，最多24點。
		statLookup["祕法法術和效果造成的傷害提高最多"] = "ARCANE_SPELL_POWER"; --裝備： 祕法法術和效果造成的傷害提高最多14點。
		statLookup["提高火焰法術和效果所造成的傷害，最多"] = "FIRE_SPELL_POWER"; --裝備： 提高火焰法術和效果所造成的傷害，最多7點。
		statLookup["提高冰霜法術和效果所造成的傷害，最多"] = "FROST_SPELL_POWER"; --裝備： 提高冰霜法術和效果所造成的傷害，最多10點。
		statLookup["提高暗影法術和效果所造成的傷害，最多"] = "SHADOW_SPELL_POWER"; --裝備： 提高暗影法術和效果所造成的傷害，最多11點。
		statLookup["提高神聖法術和效果所造成的傷害，最多"] = "HOLY_SPELL_POWER"; --裝備： 提高神聖法術和效果所造成的傷害，最多16點。
		statLookup["提高自然法術和效果所造成的傷害，最多"] = "NATURE_SPELL_POWER"; --裝備： 提高自然法術和效果所造成的傷害，最多19點。
		statLookup["使你的法術擊中敵人的機率提高"] = "SPELL_HIT_CHANCE"; --裝備： 使你的法術擊中敵人的機率提高1%。
		statLookup["在獵豹、熊或巨熊形態下的攻擊強度提高"] = "FERAL_ATTACK_POWER"; --裝備： 在獵豹、熊或巨熊形態下的攻擊強度提高280點。
		statLookup["釣魚技能提高"] = "FISHING"; --裝備： 釣魚技能提高5點。
	end

	function ISL.ParseText(line)
		--No numerals, skip this line to save cycles.
		if not FindCaptures(line, "(%d)") then return end

		--+1耐力
		local value, statKey  = FindCaptures(line, "^%+?(%d+)([^%d%s]+)$")
		if value then
			return SelectValueThenStats(statKey, value)
		end

		if strsub(line, #line-#"傷害"+1)=="傷害" then --10 - 16傷害
			local valueLow, valueHigh = FindCaptures(line, "^(%d+) %- (%d+)傷害$")
			if valueLow then
				return (tonumber(valueLow)+tonumber(valueHigh))/2, "DAMAGE"
			end
		end
		
		local value = FindCaptures(line,"^（每秒傷害(%d+%.?%d*)）$") --（每秒傷害5.0）
		if value then
			return tonumber(value), "DPS"
		end
		
		local statKey
		if strsub(line, 1, #ITEM_SPELL_TRIGGER_ONEQUIP)==ITEM_SPELL_TRIGGER_ONEQUIP then
			statKey, value  = FindCaptures(line,"^裝備： ([^%d%s]+)(%d+)[%%點]-。$")
			if statKey then
				return SelectValueThenStats(statKey, value)
			end

			value, statKey  = FindCaptures(line,"^裝備： 每5秒恢復(%d+)點([^%d%s]+)力。$")
			if statKey then
				return SelectValueThenStats(statKey, value)
			end

			value, statKey  = FindCaptures(line,"^裝備： %+(%d+)([^%d%s]+)。$")
			if statKey then
				return SelectValueThenStats(statKey, value)
			end
		end

		--强化护甲 +8
		--速度 1.70
		--One word, followed by one number("+" optional)
		statKey, value  = FindCaptures(line, "^([^d%s]+)%s?%+?(%d+%.?%d*)$")
		if statKey then
			return SelectValueThenStats(statKey, value)
		end
	end

	function ISL:Load()
		FindCaptures, SelectValueThenStats, GetCreateTable = 
			DGV.Modules.ItemStats.FindCaptures, DGV.Modules.ItemStats.SelectValueThenStats, DGV.GetCreateTable
	end
end