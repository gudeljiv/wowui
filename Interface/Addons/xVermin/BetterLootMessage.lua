local function stringPaternMatch(oldString, newString)
	local oldPatern = string.gmatch(oldString, "%%.")
	local newPatern = string.gmatch(newString, "%%.")
	local oldPaternIteration = oldPatern()
	local newPaternIteration = newPatern()
	while oldPaternIteration ~= nil or newPaternIteration ~= nil do
		if oldPaternIteration ~= newPaternIteration then
			return false
		end
		oldPaternIteration = oldPatern()
		newPaternIteration = newPatern()
	end
	return true
end

local translateTable = {
	["CURRENCY_GAINED"] = "+ %s",
	["CURRENCY_GAINED_MULTIPLE"] = "+ %s x%d",
	["CURRENCY_GAINED_MULTIPLE_BONUS"] = "+ %s x%d (bonus)",
	["CURRENCY_LOST_FROM_DEATH"] = "- %s x%d",
	["LOOT_CURRENCY_REFUND"] = "+ %s x%d",
	["LOOT_DISENCHANT_CREDIT"] = "- %s: %s (Disenchant)",
	["LOOT_ITEM"] = "+ %s: %s",
	["LOOT_ITEM_BONUS_ROLL"] = "+ %s: %s (bonus)",
	["LOOT_ITEM_BONUS_ROLL_MULTIPLE"] = "+ %s: %s x%d (bonus)",
	["LOOT_ITEM_BONUS_ROLL_SELF"] = "+ %s (bonus)",
	["LOOT_ITEM_BONUS_ROLL_SELF_MULTIPLE"] = "+ %s x%d (bonus)",
	["LOOT_ITEM_MULTIPLE"] = "+ %s: %s x%d",
	["LOOT_ITEM_PUSHED"] = "+ %s: %s",
	["LOOT_ITEM_PUSHED_MULTIPLE"] = "+ %s: %s x%d",
	["LOOT_ITEM_PUSHED_SELF"] = "+ %s",
	["LOOT_ITEM_PUSHED_SELF_MULTIPLE"] = "+ %s x%d",
	["LOOT_ITEM_REFUND"] = "+ %s",
	["LOOT_ITEM_REFUND_MULTIPLE"] = "+ %s x%d",
	["LOOT_ITEM_SELF"] = "+ %s",
	["LOOT_ITEM_SELF_MULTIPLE"] = "+ %s x%d",
	["LOOT_ITEM_WHILE_PLAYER_INELIGIBLE"] = "+ %s: %s",
	["GUILD_NEWS_FORMAT4"] = "+ %s: %s (craft)",
	["GUILD_NEWS_FORMAT8"] = "+ %s: %s",
	["CREATED_ITEM"] = "+ %s: %s (craft)",
	["CREATED_ITEM_MULTIPLE"] = "+ %s: %s x%d (craft)",
	["LOOT_ITEM_CREATED_SELF"] = "+ %s (craft)",
	["LOOT_ITEM_CREATED_SELF_MULTIPLE"] = "+ %s x%d (craft)",
	["YOU_LOOT_MONEY"] = "+ %s",
	["YOU_LOOT_MONEY_GUILD"] = "+ %s (%s Guild)",
	["TRADESKILL_LOG_FIRSTPERSON"] = "+ %s (craft)",
	["TRADESKILL_LOG_THIRDPERSON"] = "+ %s: %s (craft)",
	["COMBATLOG_XPGAIN_EXHAUSTION1"] = "%s: +%d xp (%s %s)",
	["COMBATLOG_XPGAIN_EXHAUSTION1_GROUP"] = "%s: +%d xp (%s %s, +%d group)",
	["COMBATLOG_XPGAIN_EXHAUSTION1_RAID"] = "%s: +%d xp (%s %s, -%d raid)",
	["COMBATLOG_XPGAIN_EXHAUSTION2"] = "%s: +%d xp (%s %s)",
	["COMBATLOG_XPGAIN_EXHAUSTION2_GROUP"] = "%s: +%d xp (%s %s, +%d group)",
	["COMBATLOG_XPGAIN_EXHAUSTION2_RAID"] = "%s: +%d xp (%s %s, -%d raid)",
	["COMBATLOG_XPGAIN_EXHAUSTION4"] = "%s: +%d xp (%s penalty %s)",
	["COMBATLOG_XPGAIN_EXHAUSTION4_GROUP"] = "%s: +%d xp (%s penalty %s, +%d group)",
	["COMBATLOG_XPGAIN_EXHAUSTION4_RAID"] = "%s: +%d xp (%s xp %s, -%d raid)",
	["COMBATLOG_XPGAIN_EXHAUSTION5"] = "%s: +%d xp (%s penalty %s)",
	["COMBATLOG_XPGAIN_EXHAUSTION5_GROUP"] = "%s: +%d xp (%s penalty %s, +%d group)",
	["COMBATLOG_XPGAIN_EXHAUSTION5_RAID"] = "%s: +%d xp (%s penalty %s, -%d raid)",
	["COMBATLOG_XPGAIN_FIRSTPERSON"] = "%s: +%d xp",
	["COMBATLOG_XPGAIN_QUEST"] = "+%d xp (%s %s)",
	["COMBATLOG_XPGAIN_FIRSTPERSON_UNNAMED"] = "+%d xp",
	["COMBATLOG_XPGAIN_FIRSTPERSON_GROUP"] = "%s: +%d xp (+%d group)",
	["COMBATLOG_XPGAIN_FIRSTPERSON_RAID"] = "%s: +%d xp (-%d raid)",
	["FACTION_STANDING_CHANGED"] = "%s: %s",
	["FACTION_STANDING_CHANGED_GUILD"] = "%s: guild",
	["FACTION_STANDING_CHANGED_GUILDNAME"] = "%s: %s",
	["FACTION_STANDING_DECREASED"] = "%s - %d",
	["FACTION_STANDING_DECREASED_GENERIC"] = "%s -",
	["FACTION_STANDING_INCREASED"] = "%s: + %d",
	["FACTION_STANDING_INCREASED_ACH_BONUS"] = "%s: + %d (+%.1f bonus)",
	["FACTION_STANDING_INCREASED_ACH_PART"] = "(+%.1f bonus)",
	["FACTION_STANDING_INCREASED_BONUS"] = "%s: + %d. (+%.1f bonus)",
	["FACTION_STANDING_INCREASED_DOUBLE_BONUS"] = "%s: + %d. (+%.1f + %.1f bonus)",
	["FACTION_STANDING_INCREASED_GENERIC"] = "%s: +",
	["SKILL_RANK_UP"] = "%s = %d"
}

table.foreach(
	translateTable,
	function(k, v)
		if _G[k] ~= nil and stringPaternMatch(_G[k], v) == true then
			_G[k] = v
		end
	end
)
