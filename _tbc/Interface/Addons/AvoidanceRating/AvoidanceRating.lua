local function RepAvoidRating()
	local BaseDefValue
	local BaseDodgeValue
	local BaseParryValue
	local BaseBlockValue
	local BaseMissValue

	BaseDefValue = UnitDefense("player")
	BaseDefValue = ((BaseDefValue + math.floor(GetCombatRatingBonus(2))) - 350) * 0.04
	BaseDodgeValue = GetDodgeChance()
	BaseParryValue = GetParryChance()
	BaseBlockValue = GetBlockChance()
	BaseMissValue = 5

	print("Total Avoidance Target is 102.4%")
	print("   Pally's cast Holy Shield before using this mod")
	print("   Warrior's use Shield Block before using this mod")
	--print("Defense: ",string.format("%.2f%%",BaseDefValue));
	--print("Dodge: ",string.format("%.2f%%",BaseDodgeValue));
	--print("Parry: ",string.format("%.2f%%",BaseParryValue));
	--print("Block: ",string.format("%.2f%%",BaseBlockValue));
	--print("Miss: ",string.format("%.2f%%",BaseMissValue));
	print(
		"Your Total Avoidance Is:",
		string.format("%.2f%%", BaseDefValue + BaseDodgeValue + BaseParryValue + BaseBlockValue + BaseMissValue)
	)
end

local function JustRepAvoidRating()
	local BaseDefValue
	local BaseDodgeValue
	local BaseParryValue
	local BaseBlockValue
	local BaseMissValue

	BaseDefValue = UnitDefense("player")
	BaseDefValue = ((BaseDefValue + math.floor(GetCombatRatingBonus(2))) - 350) * 0.04
	BaseDodgeValue = GetDodgeChance()
	BaseParryValue = GetParryChance()
	BaseBlockValue = GetBlockChance()
	BaseMissValue = 5

	print(
		"Your Total Avoidance Is:",
		string.format("%.2f%%", BaseDefValue + BaseDodgeValue + BaseParryValue + BaseBlockValue + BaseMissValue)
	)
end

-- SLASH_REPAVOIDRATE1 = "/ar"
-- SlashCmdList.REPAVOIDRATE = RepAvoidRating;

-- SLASH_JUSTREPAVOIDRATE1 = "/jar"
-- SlashCmdList.JUSTREPAVOIDRATE = JustRepAvoidRating;
