--[[ TODO
    * Add configuration options
        * Give option to treat buff food as low priority regular food
        * Allow other buff foods (eg agi/str), and let user prioritize them
        * Allow custom macro templates
        * Prefer PVP potions/bandages in battlegrounds (they're ignored for now)
]]
--local defaultFoodMacro = [[#showtooltip
--/use [mod:shift]<bandage>;[nocombat,mod]<buffFood>;[nocombat]<food>;[combat]<hPotions>
--]]
local defaultFoodMacro = [[#showtooltip
/use [nocombat]<food>
/castsequence [combat]<hPotions>
]]
local defaultPetFoodMacro = [[#showtooltip <petfood>
/cast feed pet
/use <petfood>
]]
--local defaultDrinkMacro = [[#showtooltip
--/use [nocombat,mod]<manaBuff>;[nocombat]<drink>;[combat]<mPotions>
--]]
local defaultDrinkMacro = [[#showtooltip
/use [nocombat]<drink>
/castsequence [combat]<mPotions>
]]

local function CreateOrUpdateMacro(macroName, text)
	local macroID = GetMacroIndexByName(macroName)
	if macroID == 0 then
		CreateMacro(macroName, "Inv_misc_questionmark", text, nil, nil)
	else
		EditMacro(macroID, macroName, "Inv_misc_questionmark", text, nil, nil)
	end
end

NeedsFoodBadly = CreateFrame("frame")
NeedsFoodBadly:RegisterEvent("BAG_UPDATE_DELAYED")
NeedsFoodBadly:RegisterEvent("PLAYER_REGEN_ENABLED")
NeedsFoodBadly:RegisterEvent("PLAYER_LEVEL_UP")
NeedsFoodBadly:RegisterEvent("UNIT_PET")

NeedsFoodBadly.dirty = false
NeedsFoodBadly:SetScript(
	"OnEvent",
	function(self, event, ...)
		if event == "BAG_UPDATE_DELAYED" or event == "PLAYER_LEVEL_UP" or event == "UNIT_PET" then
			if InCombatLockdown() then
				NeedsFoodBadly.dirty = true
			else
				NeedsFoodBadly:UpdateMacros()
			end
		elseif event == "PLAYER_REGEN_ENABLED" and NeedsFoodBadly.dirty then
			NeedsFoodBadly:UpdateMacros()
			NeedsFoodBadly.dirty = false
		end
	end
)

function NeedsFoodBadly:UpdateMacros()
	local best = {
		food = {},
		petfood = {},
		buffFood = {},
		drink = {},
		buffDrink = {},
		hPotion = {},
		mPotion = {},
		healthstone = {},
		manaGem = {},
		bandage = {}
	}
	for bag = 0, 4 do
		for slot = 1, GetContainerNumSlots(bag) do
			local id = GetContainerItemID(bag, slot)
			if not best.food[id] and self:IsUsableFood(self.Food[id]) then
				best.food[id] = self.Food[id]
			end
			if not best.petfood[id] and self:IsUsablePetFood(self.PetFood[id]) then
				best.petfood[id] = self.PetFood[id]
			end
			if not best.buffFood[id] and self:IsUsableBuffFood(self.Food[id]) then
				best.buffFood[id] = self.Food[id]
			end
			if not best.drink[id] and self:IsUsableDrink(self.Food[id]) then
				best.drink[id] = self.Food[id]
			end
			if not best.buffDrink[id] and self:IsUsableBuffDrink(self.Food[id]) then
				best.buffDrink[id] = self.Food[id]
			end
			if not best.hPotion[id] and self:IsUsableHPotion(self.Potion[id]) then
				best.hPotion[id] = self.Potion[id]
			end
			if not best.mPotion[id] and self:IsUsableMPotion(self.Potion[id]) then
				best.mPotion[id] = self.Potion[id]
			end
			if not best.healthstone[id] and self:IsUsableHealthstone(self.Healthstone[id]) then
				best.healthstone[id] = self.Healthstone[id]
			end
			if not best.manaGem[id] and self:IsUsableManaGem(self.ManaGem[id]) then
				best.manaGem[id] = self.ManaGem[id]
			end
			if not best.bandage[id] and self:IsUsableBandage(self.Bandage[id]) then
				best.bandage[id] = self.Bandage[id]
			end
		end
	end
	best.food = self:Sorted(best.food, self.BetterFood)
	best.petfood = self:Sorted(best.petfood, self.BetterPetFood)
	best.buffFood = self:Sorted(best.buffFood, self.BetterBuffFood)
	best.drink = self:Sorted(best.drink, self.BetterDrink)
	best.buffDrink = self:Sorted(best.buffDrink, self.BetterBuffDrink)
	best.hPotion = self:Sorted(best.hPotion, self.BetterHPotion)
	best.mPotion = self:Sorted(best.mPotion, self.BetterMPotion)
	best.healthstone = self:Sorted(best.healthstone, self.BetterHealthstone)
	best.manaGem = self:Sorted(best.manaGem, self.BetterManaGem)
	best.bandage = self:Sorted(best.bandage, self.BetterBandage)
	foodMacro =
		defaultFoodMacro:gsub(
		"<%a+>",
		{
			["<food>"] = "item:" .. tostring(best.food[1] and best.food[1].id or 0),
			["<buffFood>"] = "item:" .. tostring(best.buffFood[1] and best.buffFood[1].id or 0),
			["<bandage>"] = "item:" .. tostring(best.bandage[1] and best.bandage[1].id or 0),
			["<hPotions>"] = self:BuildSequence(best.healthstone, best.hPotion)
		}
	)
	drinkMacro =
		defaultDrinkMacro:gsub(
		"<%a+>",
		{
			["<drink>"] = "item:" .. tostring(best.drink[1] and best.drink[1].id or 0),
			["<manaBuff>"] = "item:" .. tostring(best.buffDrink[1] and best.buffDrink[1].id or 0),
			["<mPotions>"] = self:BuildSequence(best.manaGem, best.mPotion)
			--["<mPotions>"] = 'item:'..tostring(best.mPotion[1] and best.mPotion[1].id or 0)
		}
	)
	CreateOrUpdateMacro("Food", foodMacro)
	CreateOrUpdateMacro("Drink", drinkMacro)

	local _, class, _ = UnitClass("player")
	if (UnitExists("pet") and class == "HUNTER") then
		local petType = UnitCreatureFamily("pet")
		if
			(petType == "Bat" or petType == "Crab" or petType == "Gorilla" or petType == "Tallstrider" or petType == "Turtle" or
				petType == "Wind Serpent")
		 then
			petfoodMacro =
				defaultPetFoodMacro:gsub(
				"<%a+>",
				{
					["<petfood>"] = "item:" .. tostring(best.food[1] and best.food[1].id or 0)
				}
			)
			CreateOrUpdateMacro("PetFood", petfoodMacro)
		else
			petfoodMacro =
				defaultPetFoodMacro:gsub(
				"<%a+>",
				{
					["<petfood>"] = "item:" .. tostring(best.petfood[1] and best.petfood[1].id or 0)
				}
			)
			CreateOrUpdateMacro("PetFood", petfoodMacro)
		end
	end
end

function NeedsFoodBadly:Sorted(t, f)
	sortedTable = {}
	for _, v in pairs(t) do
		table.insert(sortedTable, v)
	end
	table.sort(sortedTable, f)
	return sortedTable
end

function NeedsFoodBadly:IsUsableFood(food)
	return not (not (food and food.lvl <= UnitLevel("player") and food.hp and
		not (food.hp5 or food.mp5 or food.str or food.agi or food.stam or food.int or food.spi)))
end

function NeedsFoodBadly:IsUsablePetFood(food)
	local diet = {}
	if (food) then
		-- item type
		local petFoodList = {GetPetFoodTypes()}
		if #petFoodList > 0 then
			local index, foodType
			for index, foodType in pairs(petFoodList) do
				table.insert(diet, foodType)
			end
		end
	end

	return not (not (food and self:AvailableInArray(food, diet)))
end

function NeedsFoodBadly:AvailableInArray(food, diet)
	for i, v in ipairs(table) do
		if v == value then
			return true
		end
	end
	return false
end

function NeedsFoodBadly:IsUsableBuffFood(food)
	return not (not (food and food.lvl <= UnitLevel("player") and (food.hp and food.stam and food.spi)))
end

function NeedsFoodBadly:IsUsableDrink(food)
	return not (not (food and food.lvl <= UnitLevel("player") and food.mp and not food.mp5))
end

function NeedsFoodBadly:IsUsableBuffDrink(food)
	return not (not (food and food.lvl <= UnitLevel("player") and food.mp5))
end

function NeedsFoodBadly:IsUsableHPotion(potion)
	return not (not (potion and potion.lvl <= UnitLevel("player") and potion.hp and not potion.bg))
end

function NeedsFoodBadly:IsUsableMPotion(potion)
	return not (not (potion and potion.lvl <= UnitLevel("player") and potion.mp and not potion.bg))
end

function NeedsFoodBadly:IsUsableHealthstone(healthstone)
	return not (not (healthstone and healthstone.lvl <= UnitLevel("player")))
end

function NeedsFoodBadly:IsUsableManaGem(manaGem)
	return not (not (manaGem and manaGem.lvl <= UnitLevel("player")))
end

local function FirstAidSkillPoints()
	for i = 1, GetNumSkillLines() do
		local skillName, _, _, skillRank, numTempPoints, skillModifier = GetSkillLineInfo(i)
		if skillName == PROFESSIONS_FIRST_AID then
			return skillRank + numTempPoints + skillModifier
		end
	end
	return 0
end

function NeedsFoodBadly:IsUsableBandage(bandage)
	return not (not (bandage and bandage.skill <= FirstAidSkillPoints() and not bandage.bg))
end

function NeedsFoodBadly.BetterFood(a, b)
	if a.conj and not b.conj then
		return true
	elseif b.conj and not a.conj then
		return false
	end
	-- Percent food is stored as a decimal number, ie "Restores 2% health" is hp=0.02
	a_hp, b_hp = a.hp, b.hp
	if a_hp < 1 then
		a_hp = UnitHealthMax("player") * a_hp
	end
	if b_hp < 1 then
		b_hp = UnitHealthMax("player") * b_hp
	end
	return (a_hp > b_hp) or (a_hp == b_hp and GetItemCount(a.id) <= GetItemCount(b.id))
end

function NeedsFoodBadly.BetterPetFood(a, b)
	if a.conj and not b.conj then
		return true
	elseif b.conj and not a.conj then
		return false
	end
	-- Percent food is stored as a decimal number, ie "Restores 2% health" is hp=0.02
	a_hp, b_hp = a.hp, b.hp
	if a_hp < 1 then
		a_hp = UnitHealthMax("pet") * a_hp
	end
	if b_hp < 1 then
		b_hp = UnitHealthMax("pet") * b_hp
	end
	return (a_hp > b_hp) or (a_hp == b_hp and GetItemCount(a.id) <= GetItemCount(b.id))
end

function NeedsFoodBadly.BetterBuffFood(a, b)
	return a.stam > b.stam or (a.stam == b.stam and GetItemCount(a.id) <= GetItemCount(b.id))
end

function NeedsFoodBadly.BetterDrink(a, b)
	if a.conj and not b.conj then
		return true
	elseif b.conj and not a.conj then
		return false
	end
	a_mp, b_mp = a.mp, b.mp
	if a_mp < 1 then
		a_mp = UnitHealthMax("player") * a_mp
	end
	if b_mp < 1 then
		b_mp = UnitHealthMax("player") * b_mp
	end
	return a_mp > b_mp or (a_mp == b_mp and GetItemCount(a.id) <= GetItemCount(b.id))
end

function NeedsFoodBadly.BetterBuffDrink(a, b)
	return a.mp5 > b.mp5 or (a.mp5 == b.mp5 and GetItemCount(a.id) <= GetItemCount(b.id))
end

function NeedsFoodBadly.BetterHPotion(a, b)
	return a.high >= b.high
end

function NeedsFoodBadly.BetterMPotion(a, b)
	return a.high >= b.high
end

function NeedsFoodBadly.BetterHealthstone(a, b)
	return a.hp >= b.hp
end

function NeedsFoodBadly.BetterManaGem(a, b)
	return a.high >= b.high
end

function NeedsFoodBadly.BetterBandage(a, b)
	if a.bg and not b.bg then
		return true
	elseif b.bg and not a.bg then
		return false
	end
	return a.hp >= b.hp
end

function NeedsFoodBadly:BuildSequence(stone, potions)
	local sequence = {}

	if stone[1] then
		table.insert(sequence, "item:" .. tostring(stone[1].id))
	end
	for _, potion in pairs(potions) do
		for _ = 1, GetItemCount(potion.id) do
			table.insert(sequence, "item:" .. tostring(potion.id))
		end
	end
	sequenceStr = table.concat(sequence, ",", 1, math.min(table.getn(sequence), 14))
	return sequenceStr
end

NeedsFoodBadly.Food = {
	[8932] = {id = 8932, name = "Alterac Swiss", lvl = 45, conj = false, hp = 2148},
	[4536] = {id = 4536, name = "Shiny Red Apple", lvl = 1, conj = false, hp = 61.2},
	[13546] = {id = 13546, name = "Bloodbelly Fish", lvl = 25, conj = false, hp = 1392},
	[159] = {id = 159, name = "Refreshing Spring Water", lvl = 2, conj = false, mp = 151.2},
	[13928] = {id = 13928, name = "Grilled Squid", lvl = 35, conj = false, hp = 874.8, agi = 10},
	[18254] = {id = 18254, name = "Runn Tum Tuber Surprise", lvl = 45, conj = false, hp = 1933.2, int = 10},
	[12218] = {id = 12218, name = "Monster Omelet", lvl = 40, conj = false, hp = 1392, stam = 12, spi = 12},
	[20452] = {id = 20452, name = "Smoked Desert Dumplings", lvl = 45, conj = false, hp = 2148, str = 20},
	[12238] = {id = 12238, name = "Darkshore Grouper", lvl = 5, conj = false, hp = 243.6},
	[4791] = {id = 4791, name = "Enchanted Water", lvl = 25, conj = false, mp = 1344.6},
	[16971] = {id = 16971, name = "Clamlette Surprise", lvl = 40, conj = false, hp = 1392, stam = 12, spi = 12},
	[21023] = {id = 21023, name = "Dirge's Kickin' Chimaerok Chops", lvl = 55, conj = false, hp = 2550, stam = 25},
	[4593] = {id = 4593, name = "Bristle Whisker Catfish", lvl = 15, conj = false, hp = 552},
	[1179] = {id = 1179, name = "Ice Cold Milk", lvl = 5, conj = false, mp = 436.8},
	[17222] = {id = 17222, name = "Spider Sausage", lvl = 35, conj = false, hp = 1392, stam = 12, spi = 12},
	[18255] = {id = 18255, name = "Runn Tum Tuber", lvl = 45, conj = false, hp = 1392},
	[11109] = {id = 11109, name = "Special Chicken Feed", lvl = 0, conj = false, hp = 30},
	[13724] = {id = 13724, name = "Enriched Manna Biscuit", lvl = 45, conj = false, hp = 2148, mp = 4410},
	[5527] = {id = 5527, name = "Goblin Deviled Clams", lvl = 15, conj = false, hp = 552, stam = 6, spi = 6},
	[4592] = {id = 4592, name = "Longjaw Mud Snapper", lvl = 5, conj = false, hp = 243.6},
	[3729] = {id = 3729, name = "Soothing Turtle Bisque", lvl = 25, conj = false, hp = 874.8, stam = 8, spi = 8},
	[8952] = {id = 8952, name = "Roasted Quail", lvl = 45, conj = false, hp = 2148},
	[13810] = {id = 13810, name = "Blessed Sunfruit", lvl = 45, conj = false, hp = 1933.2, str = 10},
	[4457] = {id = 4457, name = "Barbecued Buzzard Wing", lvl = 25, conj = false, hp = 874.8, stam = 8, spi = 8},
	[6299] = {id = 6299, name = "Sickly Looking Fish", lvl = 0, conj = false, hp = 30},
	[8766] = {id = 8766, name = "Morning Glory Dew", lvl = 45, conj = false, mp = 2934},
	[6887] = {id = 6887, name = "Spotted Yellowtail", lvl = 35, conj = false, hp = 1392},
	[8079] = {id = 8079, name = "Conjured Crystal Water", lvl = 55, conj = true, mp = 4200},
	[3771] = {id = 3771, name = "Wild Hog Shank", lvl = 25, conj = false, hp = 874.8},
	[18045] = {id = 18045, name = "Tender Wolf Steak", lvl = 40, conj = false, hp = 1392, stam = 12, spi = 12},
	[1645] = {id = 1645, name = "Moonberry Juice", lvl = 35, conj = false, mp = 1992},
	[3770] = {id = 3770, name = "Mutton Chop", lvl = 15, conj = false, hp = 552},
	[13851] = {id = 13851, name = "Hot Wolf Ribs", lvl = 25, conj = false, hp = 874.8, stam = 8, spi = 8},
	[8364] = {id = 8364, name = "Mithril Head Trout", lvl = 25, conj = false, hp = 874.8},
	[12216] = {id = 12216, name = "Spiced Chili Crab", lvl = 40, conj = false, hp = 1392, stam = 12, spi = 12},
	[4594] = {id = 4594, name = "Rockscale Cod", lvl = 25, conj = false, hp = 874.8},
	[4599] = {id = 4599, name = "Cured Ham Steak", lvl = 35, conj = false, hp = 1392},
	[1708] = {id = 1708, name = "Sweet Nectar", lvl = 25, conj = false, mp = 1344.6},
	[3927] = {id = 3927, name = "Fine Aged Cheddar", lvl = 35, conj = false, hp = 1392},
	[12213] = {id = 12213, name = "Carrion Surprise", lvl = 25, conj = false, hp = 874.8, stam = 8, spi = 8},
	[4544] = {id = 4544, name = "Mulgore Spice Bread", lvl = 25, conj = false, hp = 874.8},
	[2684] = {id = 2684, name = "Coyote Steak", lvl = 5, conj = false, hp = 243.6, stam = 4, spi = 4},
	[16766] = {id = 16766, name = "Undermine Clam Chowder", lvl = 35, conj = false, hp = 1392},
	[13927] = {id = 13927, name = "Cooked Glossy Mightfish", lvl = 35, conj = false, hp = 874.8, stam = 10},
	[12214] = {id = 12214, name = "Mystery Stew", lvl = 25, conj = false, hp = 874.8, stam = 8, spi = 8},
	[117] = {id = 117, name = "Tough Jerky", lvl = 6, conj = false, hp = 61.2},
	[5525] = {id = 5525, name = "Boiled Clams", lvl = 5, conj = false, hp = 243.6, stam = 4, spi = 4},
	[3665] = {id = 3665, name = "Curiously Tasty Omelet", lvl = 15, conj = false, hp = 552, stam = 6, spi = 6},
	[19301] = {id = 19301, name = "Alterac Manna Biscuit", lvl = 51, conj = false, hp = 4410, mp = 4410},
	[5095] = {id = 5095, name = "Rainbow Fin Albacore", lvl = 5, conj = false, hp = 243.6},
	[787] = {id = 787, name = "Slitherskin Mackerel", lvl = 0, conj = false, hp = 61.2},
	[3728] = {id = 3728, name = "Tasty Lion Steak", lvl = 20, conj = false, hp = 874.8, stam = 8, spi = 8},
	[6290] = {id = 6290, name = "Brilliant Smallfish", lvl = 0, conj = false, hp = 61.2},
	[12212] = {id = 12212, name = "Jungle Stew", lvl = 25, conj = false, hp = 874.8, stam = 8, spi = 8},
	[4604] = {id = 4604, name = "Forest Mushroom Cap", lvl = 4, conj = false, hp = 61.2},
	[12210] = {id = 12210, name = "Roast Raptor", lvl = 25, conj = false, hp = 874.8, stam = 8, spi = 8},
	[10841] = {id = 10841, name = "Goldthorn Tea", lvl = 25, conj = false, mp = 1344.6},
	[2683] = {id = 2683, name = "Crab Cake", lvl = 5, conj = false, hp = 243.6, stam = 4, spi = 4},
	[20074] = {id = 20074, name = "Heavy Crocolisk Stew", lvl = 20, conj = false, hp = 874.8, stam = 8, spi = 8},
	[8078] = {id = 8078, name = "Conjured Sparkling Water", lvl = 45, conj = true, mp = 2934},
	[13934] = {id = 13934, name = "Mightfish Steak", lvl = 45, conj = false, hp = 1933.2, stam = 10},
	[2687] = {id = 2687, name = "Dry Pork Ribs", lvl = 5, conj = false, hp = 243.6, stam = 4, spi = 4},
	[4539] = {id = 4539, name = "Goldenbark Apple", lvl = 25, conj = false, hp = 874.8},
	[13930] = {id = 13930, name = "Filet of Redgill", lvl = 35, conj = false, hp = 1392},
	[18300] = {id = 18300, name = "Hyjal Nectar", lvl = 55, conj = false, mp = 4200},
	[6890] = {id = 6890, name = "Smoked Bear Meat", lvl = 5, conj = false, hp = 243.6},
	[4607] = {id = 4607, name = "Delicious Cave Mold", lvl = 25, conj = false, hp = 874.8},
	[1017] = {id = 1017, name = "Seasoned Wolf Kabob", lvl = 15, conj = false, hp = 552, stam = 6, spi = 6},
	[4537] = {id = 4537, name = "Tel'Abim Banana", lvl = 5, conj = false, hp = 243.6},
	[13935] = {id = 13935, name = "Baked Salmon", lvl = 45, conj = false, hp = 2148},
	[13929] = {id = 13929, name = "Hot Smoked Bass", lvl = 35, conj = false, hp = 874.8, spi = 10},
	[4602] = {id = 4602, name = "Moon Harvest Pumpkin", lvl = 35, conj = false, hp = 1392},
	[2888] = {id = 2888, name = "Beer Basted Boar Ribs", lvl = 5, conj = false, hp = 61.2, stam = 2, spi = 2},
	[8077] = {id = 8077, name = "Conjured Mineral Water", lvl = 35, conj = true, mp = 1992},
	[13933] = {id = 13933, name = "Lobster Stew", lvl = 45, conj = false, hp = 2148},
	[5472] = {id = 5472, name = "Kaldorei Spider Kabob", lvl = 1, conj = false, hp = 61.2, stam = 2, spi = 2},
	[6361] = {id = 6361, name = "Raw Rainbow Fin Albacore", lvl = 5, conj = false, hp = 61.2},
	[22895] = {id = 22895, name = "Conjured Cinnamon Roll", lvl = 55, conj = true, hp = 3180},
	[4608] = {id = 4608, name = "Raw Black Truffle", lvl = 35, conj = false, hp = 1392},
	[3666] = {id = 3666, name = "Gooey Spider Cake", lvl = 15, conj = false, hp = 552, stam = 6, spi = 6},
	[8957] = {id = 8957, name = "Spinefin Halibut", lvl = 45, conj = false, hp = 2148},
	[3220] = {id = 3220, name = "Blood Sausage", lvl = 5, conj = false, hp = 243.6, stam = 4, spi = 4},
	[7228] = {id = 7228, name = "Tigule and Foror's Strawberry Ice Cream", lvl = 15, conj = false, hp = 552},
	[1082] = {id = 1082, name = "Redridge Goulash", lvl = 10, conj = false, hp = 552, stam = 6, spi = 6},
	[2287] = {id = 2287, name = "Haunch of Meat", lvl = 5, conj = false, hp = 243.6},
	[1707] = {id = 1707, name = "Stormwind Brie", lvl = 25, conj = false, hp = 874.8},
	[8950] = {id = 8950, name = "Homemade Cherry Pie", lvl = 45, conj = false, hp = 2148},
	[18632] = {id = 18632, name = "Moonbrook Riot Taffy", lvl = 25, conj = false, hp = 874.8},
	[8948] = {id = 8948, name = "Dried King Bolete", lvl = 45, conj = false, hp = 2148},
	[3772] = {id = 3772, name = "Conjured Spring Water", lvl = 25, conj = true, mp = 1344.6},
	[12209] = {id = 12209, name = "Lean Wolf Steak", lvl = 15, conj = false, hp = 552, stam = 6, spi = 6},
	[3726] = {id = 3726, name = "Big Bear Steak", lvl = 15, conj = false, hp = 552, stam = 6, spi = 6},
	[733] = {id = 733, name = "Westfall Stew", lvl = 5, conj = false, hp = 552},
	[3664] = {id = 3664, name = "Crocolisk Gumbo", lvl = 15, conj = false, hp = 552, stam = 6, spi = 6},
	[1205] = {id = 1205, name = "Melon Juice", lvl = 15, conj = false, mp = 835.2},
	[4605] = {id = 4605, name = "Red-speckled Mushroom", lvl = 5, conj = false, hp = 243.6},
	[2682] = {id = 2682, name = "Cooked Crab Claw", lvl = 5, conj = false, hp = 294, mp = 294},
	[20031] = {id = 20031, name = "Essence Mango", lvl = 55, conj = false, hp = 2550, mp = 4410},
	[5477] = {id = 5477, name = "Strider Stew", lvl = 5, conj = false, hp = 243.6, stam = 4, spi = 4},
	[4606] = {id = 4606, name = "Spongy Morel", lvl = 15, conj = false, hp = 552},
	[5478] = {id = 5478, name = "Dig Rat Stew", lvl = 10, conj = false, hp = 552},
	[12215] = {id = 12215, name = "Heavy Kodo Stew", lvl = 35, conj = false, hp = 1392, stam = 12, spi = 12},
	[3663] = {id = 3663, name = "Murloc Fin Soup", lvl = 15, conj = false, hp = 552, stam = 6, spi = 6},
	[8953] = {id = 8953, name = "Deep Fried Plantains", lvl = 45, conj = false, hp = 2148},
	[5480] = {id = 5480, name = "Lean Venison", lvl = 15, conj = false, hp = 552, stam = 6, spi = 6},
	[2136] = {id = 2136, name = "Conjured Purified Water", lvl = 15, conj = true, mp = 835.2},
	[2681] = {id = 2681, name = "Roasted Boar Meat", lvl = 0, conj = false, hp = 61.2},
	[12224] = {id = 12224, name = "Crispy Bat Wing", lvl = 0, conj = false, hp = 61.2, stam = 2, spi = 2},
	[4538] = {id = 4538, name = "Snapvine Watermelon", lvl = 15, conj = false, hp = 552},
	[5479] = {id = 5479, name = "Crispy Lizard Tail", lvl = 12, conj = false, hp = 552, stam = 6, spi = 6},
	[3727] = {id = 3727, name = "Hot Lion Chops", lvl = 15, conj = false, hp = 552, stam = 6, spi = 6},
	[4601] = {id = 4601, name = "Soft Banana Bread", lvl = 35, conj = false, hp = 1392},
	[3448] = {id = 3448, name = "Senggin Root", lvl = 9, conj = false, hp = 294, mp = 294},
	[6807] = {id = 6807, name = "Frog Leg Stew", lvl = 30, conj = false, hp = 874.8},
	[2680] = {id = 2680, name = "Spiced Wolf Meat", lvl = 0, conj = false, hp = 61.2, stam = 2, spi = 2},
	[21552] = {id = 21552, name = "Striped Yellowtail", lvl = 35, conj = false, hp = 1392},
	[2679] = {id = 2679, name = "Charred Wolf Meat", lvl = 0, conj = false, hp = 61.2},
	[6038] = {id = 6038, name = "Giant Clam Scorcho", lvl = 25, conj = false, hp = 874.8, stam = 8, spi = 8},
	[5066] = {id = 5066, name = "Fissure Plant", lvl = 5, conj = false, hp = 243.6},
	[6888] = {id = 6888, name = "Herb Baked Egg", lvl = 0, conj = false, hp = 61.2, stam = 2, spi = 2},
	[5526] = {id = 5526, name = "Clam Chowder", lvl = 10, conj = false, hp = 552},
	[5350] = {id = 5350, name = "Conjured Water", lvl = 0, conj = true, mp = 151.2},
	[1326] = {id = 1326, name = "Sauteed Sunfish", lvl = 12, conj = false, hp = 243.6},
	[21215] = {id = 21215, name = "Graccu's Mince Meat Fruitcake", lvl = 40, conj = false, hp = 0.05, mp = 0.05},
	[8076] = {id = 8076, name = "Conjured Sweet Roll", lvl = 45, conj = true, hp = 2148},
	[9451] = {id = 9451, name = "Bubbling Water", lvl = 15, conj = false, mp = 835.2},
	[422] = {id = 422, name = "Dwarven Mild", lvl = 15, conj = false, hp = 552},
	[2070] = {id = 2070, name = "Darnassian Bleu", lvl = 1, conj = false, hp = 61.2},
	[4541] = {id = 4541, name = "Freshly Baked Bread", lvl = 5, conj = false, hp = 243.6},
	[414] = {id = 414, name = "Dalaran Sharp", lvl = 5, conj = false, hp = 243.6},
	[17197] = {id = 17197, name = "Gingerbread Cookie", lvl = 0, conj = false, hp = 61.2, stam = 2, spi = 2},
	[17119] = {id = 17119, name = "Deeprun Rat Kabob", lvl = 5, conj = false, hp = 243.6},
	[724] = {id = 724, name = "Goretusk Liver Pie", lvl = 5, conj = false, hp = 243.6, stam = 4, spi = 4},
	[8075] = {id = 8075, name = "Conjured Sourdough", lvl = 35, conj = true, hp = 1392},
	[4542] = {id = 4542, name = "Moist Cornbread", lvl = 15, conj = false, hp = 552},
	[2288] = {id = 2288, name = "Conjured Fresh Water", lvl = 5, conj = true, mp = 436.8},
	[17198] = {id = 17198, name = "Egg Nog", lvl = 0, conj = false, hp = 61.2, stam = 2, spi = 2},
	[9681] = {id = 9681, name = "Grilled King Crawler Legs", lvl = 35, conj = false, hp = 1392},
	[7097] = {id = 7097, name = "Leg Meat", lvl = 0, conj = false, hp = 61.2},
	[19300] = {id = 19300, name = "Bottled Winterspring Water", lvl = 35, conj = false, mp = 1992},
	[4540] = {id = 4540, name = "Tough Hunk of Bread", lvl = 6, conj = false, hp = 61.2},
	[3662] = {id = 3662, name = "Crocolisk Steak", lvl = 5, conj = false, hp = 243.6, stam = 4, spi = 4},
	[2685] = {id = 2685, name = "Succulent Pork Ribs", lvl = 10, conj = false, hp = 552},
	[11584] = {id = 11584, name = "Cactus Apple Surprise", lvl = 1, conj = false, hp = 61.2, stam = 2, spi = 2},
	[1487] = {id = 1487, name = "Conjured Pumpernickel", lvl = 25, conj = true, hp = 874.8},
	[1113] = {id = 1113, name = "Conjured Bread", lvl = 5, conj = true, hp = 243.6},
	[5474] = {id = 5474, name = "Roasted Kodo Meat", lvl = 0, conj = false, hp = 61.2, stam = 2, spi = 2},
	[5349] = {id = 5349, name = "Conjured Muffin", lvl = 0, conj = true, hp = 61.2},
	[19996] = {id = 19996, name = "Harvest Fish", lvl = 0, conj = false, hp = 0.02},
	[961] = {id = 961, name = "Healing Herb", lvl = 1, conj = false, hp = 61.2},
	[1114] = {id = 1114, name = "Conjured Rye", lvl = 15, conj = true, hp = 552},
	[5476] = {id = 5476, name = "Fillet of Frenzy", lvl = 5, conj = false, hp = 243.6, stam = 4, spi = 4},
	[21031] = {id = 21031, name = "Cabbage Kimchi", lvl = 45, conj = false, hp = 2148},
	[23172] = {id = 23172, name = "Refreshing Red Apple", lvl = 0, conj = false, hp = 0.04, mp = 0.04},
	[21254] = {id = 21254, name = "Winter Veil Cookie", lvl = 0, conj = false, hp = 0.02, stam = 0.25, spi = 0.25},
	[11444] = {id = 11444, name = "Grim Guzzler Boar", lvl = 45, conj = false, hp = 2148},
	[4656] = {id = 4656, name = "Small Pumpkin", lvl = 8, conj = false, hp = 61.2},
	[11415] = {id = 11415, name = "Mixed Berries", lvl = 45, conj = false, hp = 2148},
	[6316] = {id = 6316, name = "Loch Frenzy Delight", lvl = 5, conj = false, hp = 243.6},
	[19299] = {id = 19299, name = "Fizzy Faire Drink", lvl = 15, conj = false, mp = 835.2},
	[20516] = {id = 20516, name = "Bobbing Apple", lvl = 0, conj = false, hp = 0.02, stam = 0.25, spi = 0.25},
	[19224] = {id = 19224, name = "Red Hot Wings", lvl = 25, conj = false, hp = 874.8},
	[19696] = {id = 19696, name = "Harvest Bread", lvl = 0, conj = true, hp = 0.02},
	[16170] = {id = 16170, name = "Steamed Mandu", lvl = 15, conj = false, hp = 552},
	[17406] = {id = 17406, name = "Holiday Cheesewheel", lvl = 5, conj = false, hp = 243.6},
	[21030] = {id = 21030, name = "Darnassus Kimchi Pie", lvl = 35, conj = false, hp = 1392},
	[17404] = {id = 17404, name = "Blended Bean Brew", lvl = 5, conj = false, mp = 436.8},
	[17344] = {id = 17344, name = "Candy Cane", lvl = 0, conj = false, hp = 61.2},
	[22324] = {id = 22324, name = "Winter Kimchi", lvl = 45, conj = false, hp = 2148},
	[16168] = {id = 16168, name = "Heaven Peach", lvl = 35, conj = false, hp = 1392},
	[5057] = {id = 5057, name = "Ripe Watermelon", lvl = 8, conj = false, hp = 61.2},
	[21236] = {id = 21236, name = "Winter Veil Loaf", lvl = 0, conj = false, hp = 0.02},
	[8543] = {id = 8543, name = "Underwater Mushroom Cap", lvl = 25, conj = false, hp = 874.8},
	[16167] = {id = 16167, name = "Versicolor Treat", lvl = 5, conj = false, hp = 243.6},
	[12763] = {id = 12763, name = "Un'Goro Etherfruit", lvl = 45, conj = false, hp = 2148},
	[21235] = {id = 21235, name = "Winter Veil Roast", lvl = 0, conj = false, hp = 0.02},
	[19306] = {id = 19306, name = "Crunchy Frog", lvl = 35, conj = false, hp = 1392},
	[17407] = {id = 17407, name = "Graccu's Homemade Meat Pie", lvl = 25, conj = false, hp = 874.8},
	[16169] = {id = 16169, name = "Wild Ricecake", lvl = 25, conj = false, hp = 874.8},
	[19304] = {id = 19304, name = "Spiced Beef Jerky", lvl = 5, conj = false, hp = 243.6},
	[18633] = {id = 18633, name = "Styleen's Sour Suckerpop", lvl = 5, conj = false, hp = 243.6},
	[7807] = {id = 7807, name = "Candy Bar", lvl = 0, conj = false, hp = 61.2, stam = 2, spi = 2},
	[7808] = {id = 7808, name = "Chocolate Square", lvl = 0, conj = false, hp = 61.2, stam = 2, spi = 2},
	[19994] = {id = 19994, name = "Harvest Fruit", lvl = 0, conj = false, hp = 0.02},
	[17199] = {id = 17199, name = "Bad Egg Nog", lvl = 0, conj = false, hp = 61.2, stam = 2, spi = 2},
	[23160] = {id = 23160, name = "Friendship Bread", lvl = 45, conj = false, hp = 2148},
	[17408] = {id = 17408, name = "Spicy Beefstick", lvl = 35, conj = false, hp = 1392},
	[19223] = {id = 19223, name = "Darkmoon Dog", lvl = 0, conj = false, hp = 61.2},
	[21033] = {id = 21033, name = "Radish Kimchi", lvl = 45, conj = false, hp = 2148},
	[19995] = {id = 19995, name = "Harvest Boar", lvl = 0, conj = false, hp = 0.02},
	[16171] = {id = 16171, name = "Shinsollo", lvl = 45, conj = false, hp = 2148},
	[12211] = {id = 12211, name = "Spiced Wolf Ribs", lvl = 25, conj = false, hp = 874.8, stam = 8, spi = 8},
	[7806] = {id = 7806, name = "Lollipop", lvl = 0, conj = false, hp = 61.2, stam = 2, spi = 2},
	[19225] = {id = 19225, name = "Deep Fried Candybar", lvl = 45, conj = false, hp = 2148},
	[18635] = {id = 18635, name = "Bellara's Nutterbar", lvl = 35, conj = false, hp = 1392},
	[21240] = {id = 21240, name = "Winter Veil Candy", lvl = 0, conj = false, hp = 0.02},
	[1119] = {id = 1119, name = "Bottled Spirits", lvl = 0, conj = false, hp = 552},
	[19305] = {id = 19305, name = "Pickled Kodo Foot", lvl = 15, conj = false, hp = 552},
	[16166] = {id = 16166, name = "Bean Soup", lvl = 0, conj = false, hp = 61.2},
	[13813] = {id = 13813, name = "Blessed Sunfruit Juice", lvl = 45, conj = false, mp = 4410, spi = 10},
	[13931] = {id = 13931, name = "Nightfin Soup", lvl = 35, conj = false, hp = 874.8, mp5 = 8},
	[21217] = {id = 21217, name = "Sagefish Delight", lvl = 30, conj = false, hp = 840.0, mp = 1260, mp5 = 6},
	[21072] = {id = 21072, name = "Smoked Sagefish", lvl = 10, conj = false, hp = 378.0, mp = 567, mp5 = 3},
	[13932] = {id = 13932, name = "Poached Sunscale Salmon", lvl = 35, conj = false, hp = 874.8, hp5 = 6},
	[1401] = {id = 1401, name = "Green Tea Leaf", lvl = 4, conj = false, hp = 30, mp = 60},
	[5473] = {id = 5473, name = "Scorpid Surprise", lvl = 0, conj = false, hp = 294}
}
NeedsFoodBadly.Potion = {
	[13446] = {id = 13446, name = "Major Healing Potion", lvl = 45, low = 1050, high = 1750, hp = true},
	[13444] = {id = 13444, name = "Major Mana Potion", lvl = 49, low = 1350, high = 2250, mp = true},
	[929] = {id = 929, name = "Healing Potion", lvl = 12, low = 280, high = 360, hp = true},
	[6149] = {id = 6149, name = "Greater Mana Potion", lvl = 31, low = 700, high = 900, mp = true},
	[1710] = {id = 1710, name = "Greater Healing Potion", lvl = 21, low = 455, high = 585, hp = true},
	[13443] = {id = 13443, name = "Superior Mana Potion", lvl = 41, low = 900, high = 1500, mp = true},
	[3928] = {id = 3928, name = "Superior Healing Potion", lvl = 35, low = 700, high = 900, hp = true},
	[3827] = {id = 3827, name = "Mana Potion", lvl = 22, low = 455, high = 585, mp = true},
	[858] = {id = 858, name = "Lesser Healing Potion", lvl = 3, low = 140, high = 180, hp = true},
	[3385] = {id = 3385, name = "Lesser Mana Potion", lvl = 14, low = 280, high = 360, mp = true},
	[118] = {id = 118, name = "Minor Healing Potion", lvl = 0, low = 70, high = 90, hp = true},
	[2455] = {id = 2455, name = "Minor Mana Potion", lvl = 5, low = 140, high = 180, mp = true},
	[18253] = {id = 18253, name = "Major Rejuvenation Potion", lvl = 50, low = 1440, high = 1760, hp = true, mp = true},
	[9144] = {id = 9144, name = "Wildvine Potion", lvl = 35, low = 1, high = 1500, hp = true, mp = true},
	[2456] = {id = 2456, name = "Minor Rejuvenation Potion", lvl = 5, low = 90, high = 150, hp = true, mp = true},
	[4596] = {id = 4596, name = "Discolored Healing Potion", lvl = 5, low = 140, high = 180, hp = true},
	[18839] = {id = 18839, name = "Combat Healing Potion", lvl = 35, low = 700, high = 900, hp = true},
	[18841] = {id = 18841, name = "Combat Mana Potion", lvl = 41, low = 900, high = 1500, mp = true},
	[3087] = {id = 3087, name = "Mug of Shimmer Stout", lvl = 0, low = 140, high = 180, mp = true},
	[17351] = {id = 17351, name = "Major Mana Draught", lvl = 45, low = 980, high = 1260, mp = true, bg = true},
	[17348] = {id = 17348, name = "Major Healing Draught", lvl = 45, low = 980, high = 1260, hp = true, bg = true},
	[17349] = {id = 17349, name = "Superior Healing Draught", lvl = 35, low = 560, high = 720, hp = true, bg = true},
	[17352] = {id = 17352, name = "Superior Mana Draught", lvl = 35, low = 560, high = 720, mp = true, bg = true}
}
NeedsFoodBadly.Healthstone = {
	[19004] = {id = 19004, name = "Minor Healthstone", lvl = 10, hp = 110},
	[19005] = {id = 19005, name = "Minor Healthstone", lvl = 10, hp = 120},
	[19006] = {id = 19006, name = "Lesser Healthstone", lvl = 22, hp = 275},
	[19007] = {id = 19007, name = "Lesser Healthstone", lvl = 22, hp = 300},
	[19008] = {id = 19008, name = "Healthstone", lvl = 34, hp = 550},
	[19009] = {id = 19009, name = "Healthstone", lvl = 34, hp = 600},
	[19010] = {id = 19010, name = "Greater Healthstone", lvl = 46, hp = 880},
	[19011] = {id = 19011, name = "Greater Healthstone", lvl = 46, hp = 960},
	[19012] = {id = 19012, name = "Major Healthstone", lvl = 58, hp = 1320},
	[5509] = {id = 5509, name = "Healthstone", lvl = 34, hp = 500},
	[19013] = {id = 19013, name = "Major Healthstone", lvl = 58, hp = 1440},
	[5510] = {id = 5510, name = "Greater Healthstone", lvl = 46, hp = 800},
	[5511] = {id = 5511, name = "Lesser Healthstone", lvl = 22, hp = 250},
	[5512] = {id = 5512, name = "Minor Healthstone", lvl = 10, hp = 100},
	[9421] = {id = 9421, name = "Major Healthstone", lvl = 58, hp = 1200}
}
NeedsFoodBadly.ManaGem = {
	[5514] = {id = 5514, name = "Mana Agate", lvl = 1, low = 375, high = 425},
	[5513] = {id = 5513, name = "Mana Jade", lvl = 38, low = 550, high = 650},
	[8007] = {id = 8007, name = "Mana Citrine", lvl = 48, low = 775, high = 925},
	[8008] = {id = 8008, name = "Mana Ruby", lvl = 58, low = 1000, high = 1200}
}
NeedsFoodBadly.Bandage = {
	[8545] = {id = 8545, name = "Heavy Mageweave Bandage", skill = 175, hp = 1104},
	[14529] = {id = 14529, name = "Runecloth Bandage", skill = 200, hp = 1360},
	[14530] = {id = 14530, name = "Heavy Runecloth Bandage", skill = 225, hp = 2000},
	[6450] = {id = 6450, name = "Silk Bandage", skill = 100, hp = 400},
	[6451] = {id = 6451, name = "Heavy Silk Bandage", skill = 125, hp = 640},
	[8544] = {id = 8544, name = "Mageweave Bandage", skill = 150, hp = 800},
	[3530] = {id = 3530, name = "Wool Bandage", skill = 50, hp = 161},
	[3531] = {id = 3531, name = "Heavy Wool Bandage", skill = 75, hp = 301},
	[2581] = {id = 2581, name = "Heavy Linen Bandage", skill = 20, hp = 114},
	[1251] = {id = 1251, name = "Linen Bandage", skill = 1, hp = 66},
	[19307] = {id = 19307, name = "Alterac Heavy Runecloth Bandage", skill = 225, hp = 2000},
	[23684] = {id = 23684, name = "Crystal Infused Bandage", skill = 225, hp = 2500},
	[19068] = {id = 19068, name = "Warsong Gulch Silk Bandage", lvl = 25, skill = 125, hp = 640, bg = 2},
	[19067] = {id = 19067, name = "Warsong Gulch Mageweave Bandage", lvl = 35, skill = 175, hp = 1104, bg = 2},
	[19066] = {id = 19066, name = "Warsong Gulch Runecloth Bandage", lvl = 45, skill = 225, hp = 2000, bg = 2},
	[20067] = {id = 20067, name = "Arathi Basin Silk Bandage", lvl = 25, skill = 125, hp = 640, bg = 3},
	[20235] = {id = 20235, name = "Defiler's Silk Bandage", lvl = 25, skill = 125, hp = 640, bg = 3},
	[20244] = {id = 20244, name = "Highlander's Silk Bandage", lvl = 25, skill = 125, hp = 640, bg = 3},
	[20065] = {id = 20065, name = "Arathi Basin Mageweave Bandage", lvl = 35, skill = 175, hp = 1104, bg = 3},
	[20232] = {id = 20232, name = "Defiler's Mageweave Bandage", lvl = 35, skill = 175, hp = 1104, bg = 3},
	[20237] = {id = 20237, name = "Highlander's Mageweave Bandage", lvl = 35, skill = 175, hp = 1104, bg = 3},
	[20066] = {id = 20066, name = "Arathi Basin Runecloth Bandage", lvl = 45, skill = 225, hp = 2000, bg = 3},
	[20234] = {id = 20234, name = "Defiler's Runecloth Bandage", lvl = 45, skill = 225, hp = 2000, bg = 3},
	[20243] = {id = 20243, name = "Highlander's Runecloth Bandage", lvl = 45, skill = 225, hp = 2000, bg = 3}
}
NeedsFoodBadly.PetFood = {
	[Meat] = {
		[117] = F.BASIC,
		[2287] = F.BASIC,
		[2679] = F.BASIC,
		[2681] = F.BASIC,
		[2685] = F.BASIC,
		[3770] = F.BASIC,
		[3771] = F.BASIC,
		[4599] = F.BASIC,
		[5478] = F.BASIC,
		[6890] = F.BASIC,
		[7097] = F.BASIC,
		[8952] = F.BASIC,
		[9681] = F.BASIC,
		[9681] = F.BASIC,
		[11444] = F.BASIC,
		[11444] = F.BASIC,
		[17119] = F.BASIC,
		[17407] = F.BASIC,
		[19223] = F.BASIC,
		[19224] = F.BASIC,
		[19304] = F.BASIC,
		[19305] = F.BASIC,
		[19306] = F.BASIC,
		[19995] = F.BASIC,
		[21235] = F.BASIC,
		[23495] = F.BASIC,
		[27854] = F.BASIC,
		[29451] = F.BASIC,
		[30610] = F.BASIC,
		[32685] = F.BASIC,
		[32686] = F.BASIC,
		[33254] = F.BASIC,
		[33454] = F.BASIC,
		[34747] = F.BASIC,
		[35953] = F.BASIC,
		[38427] = F.BASIC,
		[38428] = F.BASIC,
		[40202] = F.BASIC,
		[40358] = F.BASIC,
		[40359] = F.BASIC,
		[41729] = F.BASIC,
		[44072] = F.BASIC,
		[57544] = F.BASIC,
		[58268] = F.BASIC,
		[58269] = F.BASIC,
		[58280] = F.BASIC,
		[59231] = F.BASIC,
		[59232] = F.BASIC,
		[60268] = F.BASIC,
		[60377] = F.BASIC,
		[62653] = F.BASIC,
		[62658] = F.BASIC,
		[62662] = F.BASIC,
		[62664] = F.BASIC,
		[62665] = F.BASIC,
		[62670] = F.BASIC,
		[62676] = F.BASIC,
		[62909] = F.BASIC,
		[62910] = F.BASIC,
		[65730] = F.BASIC,
		[65731] = F.BASIC,
		[67230] = F.BASIC,
		[67270] = F.BASIC,
		[67271] = F.BASIC,
		[67272] = F.BASIC,
		[67273] = F.BASIC,
		[74642] = F.BASIC,
		[74646] = F.BASIC,
		[74647] = F.BASIC,
		[74648] = F.BASIC,
		[74649] = F.BASIC,
		[74650] = F.BASIC,
		[74653] = F.BASIC,
		[74654] = F.BASIC,
		[74656] = F.BASIC,
		[81917] = F.BASIC,
		[81918] = F.BASIC,
		[83097] = F.BASIC,
		[85501] = F.BASIC,
		[86070] = F.BASIC,
		[90135] = F.BASIC,
		[1017] = F.BONUS,
		[2680] = F.BONUS,
		[2684] = F.BONUS,
		[2687] = F.BONUS,
		[2888] = F.BONUS,
		[3220] = F.BONUS,
		[3662] = F.BONUS,
		[3726] = F.BONUS,
		[3727] = F.BONUS,
		[3728] = F.BONUS,
		[3729] = F.BONUS,
		[4457] = F.BONUS,
		[5472] = F.BONUS,
		[5474] = F.BONUS,
		[5477] = F.BONUS,
		[5479] = F.BONUS,
		[5480] = F.BONUS,
		[12209] = F.BONUS,
		[12210] = F.BONUS,
		[12213] = F.BONUS,
		[12224] = F.BONUS,
		[13851] = F.BONUS,
		[17222] = F.BONUS,
		[18045] = F.BONUS,
		[20074] = F.BONUS,
		[21023] = F.BONUS,
		[24105] = F.BONUS,
		[27635] = F.BONUS,
		[27636] = F.BONUS,
		[27651] = F.BONUS,
		[27655] = F.BONUS,
		[27657] = F.BONUS,
		[27658] = F.BONUS,
		[27659] = F.BONUS,
		[27660] = F.BONUS,
		[29292] = F.BONUS,
		[31672] = F.BONUS,
		[31673] = F.BONUS,
		[33872] = F.BONUS,
		[34125] = F.BONUS,
		[34410] = F.BONUS,
		[34748] = F.BONUS,
		[34749] = F.BONUS,
		[34750] = F.BONUS,
		[34751] = F.BONUS,
		[34752] = F.BONUS,
		[34754] = F.BONUS,
		[34755] = F.BONUS,
		[34756] = F.BONUS,
		[34757] = F.BONUS,
		[34758] = F.BONUS,
		[35563] = F.BONUS,
		[35565] = F.BONUS,
		[42779] = F.BONUS,
		[42994] = F.BONUS,
		[42995] = F.BONUS,
		[42997] = F.BONUS,
		[43001] = F.BONUS,
		[43488] = F.BONUS,
		[46392] = F.BONUS,
		[57519] = F.BONUS,
		[62653] = F.BONUS,
		[62658] = F.BONUS,
		[62662] = F.BONUS,
		[62664] = F.BONUS,
		[62665] = F.BONUS,
		[62670] = F.BONUS,
		[64641] = F.BONUS,
		[74642] = F.BONUS,
		[74646] = F.BONUS,
		[74647] = F.BONUS,
		[74648] = F.BONUS,
		[74649] = F.BONUS,
		[74650] = F.BONUS,
		[74653] = F.BONUS,
		[74654] = F.BONUS,
		[74656] = F.BONUS,
		[81405] = F.BONUS,
		[81413] = F.BONUS,
		[86070] = F.BONUS,
		[723] = F.INEDIBLE,
		[729] = F.INEDIBLE,
		[769] = F.INEDIBLE,
		[1015] = F.INEDIBLE,
		[1080] = F.INEDIBLE,
		[1081] = F.INEDIBLE,
		[2672] = F.INEDIBLE,
		[2673] = F.INEDIBLE,
		[2677] = F.INEDIBLE,
		[2886] = F.INEDIBLE,
		[2924] = F.INEDIBLE,
		[3173] = F.INEDIBLE,
		[3404] = F.INEDIBLE,
		[3667] = F.INEDIBLE,
		[3712] = F.INEDIBLE,
		[3730] = F.INEDIBLE,
		[3731] = F.INEDIBLE,
		[4739] = F.INEDIBLE,
		[5051] = F.INEDIBLE,
		[5465] = F.INEDIBLE,
		[5467] = F.INEDIBLE,
		[5469] = F.INEDIBLE,
		[5470] = F.INEDIBLE,
		[5471] = F.INEDIBLE,
		[12037] = F.INEDIBLE,
		[12184] = F.INEDIBLE,
		[12202] = F.INEDIBLE,
		[12203] = F.INEDIBLE,
		[12204] = F.INEDIBLE,
		[12205] = F.INEDIBLE,
		[12208] = F.INEDIBLE,
		[12223] = F.INEDIBLE,
		[20424] = F.INEDIBLE,
		[21024] = F.INEDIBLE,
		[22644] = F.INEDIBLE,
		[23676] = F.INEDIBLE,
		[27668] = F.INEDIBLE,
		[27669] = F.INEDIBLE,
		[27671] = F.INEDIBLE,
		[27674] = F.INEDIBLE,
		[27677] = F.INEDIBLE,
		[27678] = F.INEDIBLE,
		[27681] = F.INEDIBLE,
		[27682] = F.INEDIBLE,
		[31670] = F.INEDIBLE,
		[31671] = F.INEDIBLE,
		[33120] = F.INEDIBLE,
		[34736] = F.INEDIBLE,
		[35562] = F.INEDIBLE,
		[35794] = F.INEDIBLE,
		[43009] = F.INEDIBLE,
		[43010] = F.INEDIBLE,
		[43011] = F.INEDIBLE,
		[43012] = F.INEDIBLE,
		[43013] = F.INEDIBLE,
		[62778] = F.INEDIBLE,
		[62779] = F.INEDIBLE,
		[62780] = F.INEDIBLE,
		[62781] = F.INEDIBLE,
		[62782] = F.INEDIBLE,
		[62783] = F.INEDIBLE,
		[62784] = F.INEDIBLE,
		[62785] = F.INEDIBLE,
		[67229] = F.INEDIBLE,
		[74833] = F.INEDIBLE,
		[74834] = F.INEDIBLE,
		[74837] = F.INEDIBLE,
		[74838] = F.INEDIBLE,
		[74839] = F.INEDIBLE,
		[75014] = F.INEDIBLE,
		[85506] = F.INEDIBLE
	},
	[Fish] = {
		-- Mists and before
		[787] = F.BASIC,
		[1326] = F.BASIC,
		[2682] = F.BASIC,
		[2682] = F.BASIC,
		[4592] = F.BASIC,
		[4593] = F.BASIC,
		[4594] = F.BASIC,
		[5095] = F.BASIC,
		[6290] = F.BASIC,
		[6316] = F.BASIC,
		[6887] = F.BASIC,
		[8364] = F.BASIC,
		[8957] = F.BASIC,
		[8959] = F.BASIC,
		[12238] = F.BASIC,
		[13546] = F.BASIC,
		[13930] = F.BASIC,
		[13933] = F.BASIC,
		[13935] = F.BASIC,
		[16766] = F.BASIC,
		[19996] = F.BASIC,
		[21071] = F.BASIC,
		[21153] = F.BASIC,
		[21552] = F.BASIC,
		[27661] = F.BASIC,
		[27858] = F.BASIC,
		[29452] = F.BASIC,
		[33004] = F.BASIC,
		[33048] = F.BASIC,
		[33053] = F.BASIC,
		[33451] = F.BASIC,
		[34759] = F.BASIC,
		[34760] = F.BASIC,
		[34761] = F.BASIC,
		[35285] = F.BASIC,
		[35951] = F.BASIC,
		[43571] = F.BASIC,
		[43646] = F.BASIC,
		[43647] = F.BASIC,
		[44049] = F.BASIC,
		[44071] = F.BASIC,
		[45932] = F.BASIC,
		[56165] = F.BASIC,
		[58262] = F.BASIC,
		[58263] = F.BASIC,
		[58277] = F.BASIC,
		[62651] = F.BASIC,
		[62652] = F.BASIC,
		[62654] = F.BASIC,
		[62655] = F.BASIC,
		[62656] = F.BASIC,
		[62657] = F.BASIC,
		[62659] = F.BASIC,
		[62660] = F.BASIC,
		[62661] = F.BASIC,
		[62663] = F.BASIC,
		[62666] = F.BASIC,
		[62667] = F.BASIC,
		[62668] = F.BASIC,
		[62669] = F.BASIC,
		[62671] = F.BASIC,
		[62677] = F.BASIC,
		[68687] = F.BASIC,
		[74636] = F.BASIC,
		[74641] = F.BASIC,
		[74644] = F.BASIC,
		[74645] = F.BASIC,
		[74651] = F.BASIC,
		[74652] = F.BASIC,
		[74655] = F.BASIC,
		[82448] = F.BASIC,
		[82449] = F.BASIC,
		[86073] = F.BASIC,
		[5476] = F.BONUS,
		[5527] = F.BONUS,
		[6038] = F.BONUS,
		[12216] = F.BONUS,
		[13927] = F.BONUS,
		[13928] = F.BONUS,
		[13929] = F.BONUS,
		[13932] = F.BONUS,
		[13934] = F.BONUS,
		[16971] = F.BONUS,
		[21072] = F.BONUS,
		[21217] = F.BONUS,
		[27662] = F.BONUS,
		[27663] = F.BONUS,
		[27664] = F.BONUS,
		[27665] = F.BONUS,
		[27666] = F.BONUS,
		[27667] = F.BONUS,
		[30155] = F.BONUS,
		[33052] = F.BONUS,
		[33867] = F.BONUS,
		[34762] = F.BONUS,
		[34763] = F.BONUS,
		[34764] = F.BONUS,
		[34765] = F.BONUS,
		[34766] = F.BONUS,
		[34767] = F.BONUS,
		[34768] = F.BONUS,
		[34769] = F.BONUS,
		[37452] = F.BONUS,
		[39691] = F.BONUS,
		[42942] = F.BONUS,
		[42993] = F.BONUS,
		[42996] = F.BONUS,
		[42998] = F.BONUS,
		[42999] = F.BONUS,
		[43000] = F.BONUS,
		[43268] = F.BONUS,
		[43491] = F.BONUS,
		[43492] = F.BONUS,
		[43572] = F.BONUS,
		[43652] = F.BONUS,
		[62651] = F.BONUS,
		[62652] = F.BONUS,
		[62654] = F.BONUS,
		[62655] = F.BONUS,
		[62656] = F.BONUS,
		[62657] = F.BONUS,
		[62659] = F.BONUS,
		[62660] = F.BONUS,
		[62661] = F.BONUS,
		[62663] = F.BONUS,
		[62666] = F.BONUS,
		[62667] = F.BONUS,
		[62668] = F.BONUS,
		[62669] = F.BONUS,
		[62671] = F.BONUS,
		[74609] = F.BONUS,
		[74644] = F.BONUS,
		[74645] = F.BONUS,
		[74651] = F.BONUS,
		[74652] = F.BONUS,
		[74655] = F.BONUS,
		[81175] = F.BONUS,
		[81402] = F.BONUS,
		[81410] = F.BONUS,
		[85504] = F.BONUS,
		[86073] = F.BONUS,
		[2674] = F.INEDIBLE,
		[2675] = F.INEDIBLE,
		[4603] = F.INEDIBLE,
		[4655] = F.INEDIBLE,
		[5468] = F.INEDIBLE,
		[5503] = F.INEDIBLE,
		[5504] = F.INEDIBLE,
		[6289] = F.INEDIBLE,
		[6291] = F.INEDIBLE,
		[6303] = F.INEDIBLE,
		[6308] = F.INEDIBLE,
		[6317] = F.INEDIBLE,
		[6361] = F.INEDIBLE,
		[6362] = F.INEDIBLE,
		[7974] = F.INEDIBLE,
		[8365] = F.INEDIBLE,
		[12206] = F.INEDIBLE,
		[12207] = F.INEDIBLE,
		[13754] = F.INEDIBLE,
		[13755] = F.INEDIBLE,
		[13756] = F.INEDIBLE,
		[13758] = F.INEDIBLE,
		[13759] = F.INEDIBLE,
		[13760] = F.INEDIBLE,
		[13888] = F.INEDIBLE,
		[13889] = F.INEDIBLE,
		[13890] = F.INEDIBLE,
		[13893] = F.INEDIBLE,
		[15924] = F.INEDIBLE,
		[24477] = F.INEDIBLE,
		[27422] = F.INEDIBLE,
		[27425] = F.INEDIBLE,
		[27429] = F.INEDIBLE,
		[27435] = F.INEDIBLE,
		[27437] = F.INEDIBLE,
		[27438] = F.INEDIBLE,
		[27439] = F.INEDIBLE,
		[27515] = F.INEDIBLE,
		[27516] = F.INEDIBLE,
		[33823] = F.INEDIBLE,
		[33824] = F.INEDIBLE,
		[36782] = F.INEDIBLE,
		[40199] = F.INEDIBLE,
		[41800] = F.INEDIBLE,
		[41801] = F.INEDIBLE,
		[41802] = F.INEDIBLE,
		[41803] = F.INEDIBLE,
		[41805] = F.INEDIBLE,
		[41806] = F.INEDIBLE,
		[41807] = F.INEDIBLE,
		[41808] = F.INEDIBLE,
		[41809] = F.INEDIBLE,
		[41810] = F.INEDIBLE,
		[41812] = F.INEDIBLE,
		[41813] = F.INEDIBLE,
		[41814] = F.INEDIBLE,
		[53062] = F.INEDIBLE,
		[53063] = F.INEDIBLE,
		[53064] = F.INEDIBLE,
		[53066] = F.INEDIBLE,
		[53067] = F.INEDIBLE,
		[53068] = F.INEDIBLE,
		[53069] = F.INEDIBLE,
		[53070] = F.INEDIBLE,
		[53071] = F.INEDIBLE,
		[53072] = F.INEDIBLE,
		[62791] = F.INEDIBLE,
		[74856] = F.INEDIBLE,
		[74857] = F.INEDIBLE,
		[74859] = F.INEDIBLE,
		[74860] = F.INEDIBLE,
		[74861] = F.INEDIBLE,
		[74863] = F.INEDIBLE,
		[74865] = F.INEDIBLE,
		[74865] = F.INEDIBLE,
		[74866] = F.INEDIBLE
	},
	[Bread] = {
		-- Mists and before
		[34062] = F.CONJURED,
		[43518] = F.CONJURED,
		[43523] = F.CONJURED,
		[65499] = F.CONJURED,
		[65500] = F.CONJURED,
		[65515] = F.CONJURED,
		[65516] = F.CONJURED,
		[65517] = F.CONJURED,
		[70924] = F.CONJURED,
		[70925] = F.CONJURED,
		[70926] = F.CONJURED,
		[70927] = F.CONJURED,
		[4540] = F.BASIC,
		[4541] = F.BASIC,
		[4542] = F.BASIC,
		[4544] = F.BASIC,
		[4601] = F.BASIC,
		[8950] = F.BASIC,
		[13724] = F.BASIC,
		[16169] = F.BASIC,
		[19301] = F.BASIC,
		[19696] = F.BASIC,
		[20857] = F.BASIC,
		[23160] = F.BASIC,
		[24072] = F.BASIC,
		[27855] = F.BASIC,
		[28486] = F.BASIC,
		[29394] = F.BASIC,
		[29449] = F.BASIC,
		[30816] = F.BASIC,
		[33449] = F.BASIC,
		[34780] = F.BASIC,
		[35950] = F.BASIC,
		[42428] = F.BASIC,
		[42429] = F.BASIC,
		[42430] = F.BASIC,
		[42431] = F.BASIC,
		[42432] = F.BASIC,
		[42433] = F.BASIC,
		[42434] = F.BASIC,
		[42778] = F.BASIC,
		[44609] = F.BASIC,
		[58260] = F.BASIC,
		[58261] = F.BASIC,
		[81406] = F.BASIC,
		[82450] = F.BASIC,
		[82451] = F.BASIC,
		[86026] = F.BASIC,
		[86069] = F.BASIC,
		[90457] = F.BASIC,
		[2683] = F.BONUS,
		[3666] = F.BONUS,
		[17197] = F.BONUS,
		[43490] = F.BONUS,
		[33924] = F.BONUS,
		[81400] = F.BONUS,
		[81408] = F.BONUS,
		[81406] = F.BONUS,
		[86026] = F.BONUS,
		[86069] = F.BONUS,
		[90457] = F.BONUS
	},
	[Cheese] = {
		-- Mists and before
		[414] = F.BASIC,
		[422] = F.BASIC,
		[1707] = F.BASIC,
		[2070] = F.BASIC,
		[3927] = F.BASIC,
		[8932] = F.BASIC,
		[17406] = F.BASIC,
		[27857] = F.BASIC,
		[29448] = F.BASIC,
		[30458] = F.BASIC,
		[33443] = F.BASIC,
		[35952] = F.BASIC,
		[44607] = F.BASIC,
		[44608] = F.BASIC,
		[44749] = F.BASIC,
		[58258] = F.BASIC,
		[58259] = F.BASIC,
		[81414] = F.BASIC,
		[81921] = F.BASIC,
		[81922] = F.BASIC,
		[3665] = F.BONUS,
		[12218] = F.BONUS,
		[81401] = F.BONUS,
		[81414] = F.BONUS
	},
	[Fruit] = {
		-- Mists and before
		[4536] = F.BASIC,
		[4537] = F.BASIC,
		[4538] = F.BASIC,
		[4539] = F.BASIC,
		[4602] = F.BASIC,
		[8953] = F.BASIC,
		[16168] = F.BASIC,
		[19994] = F.BASIC,
		[20031] = F.BASIC,
		[21030] = F.BASIC,
		[21031] = F.BASIC,
		[21033] = F.BASIC,
		[22324] = F.BASIC,
		[27856] = F.BASIC,
		[28112] = F.BASIC,
		[29393] = F.BASIC,
		[29450] = F.BASIC,
		[35948] = F.BASIC,
		[35949] = F.BASIC,
		[37252] = F.BASIC,
		[40356] = F.BASIC,
		[43087] = F.BASIC,
		[58264] = F.BASIC,
		[58265] = F.BASIC,
		[58278] = F.BASIC,
		[60267] = F.BASIC,
		[74643] = F.BASIC,
		[75026] = F.BASIC,
		[79320] = F.BASIC,
		[81919] = F.BASIC,
		[81920] = F.BASIC,
		[86057] = F.BASIC,
		[86074] = F.BASIC,
		[11950] = F.BONUS,
		[13810] = F.BONUS,
		[20516] = F.BONUS,
		[24009] = F.BONUS,
		[32721] = F.BONUS,
		[74643] = F.BONUS,
		[79320] = F.BONUS,
		[81403] = F.BONUS,
		[81411] = F.BONUS,
		[86074] = F.BONUS,
		[74840] = F.INEDIBLE,
		[74841] = F.INEDIBLE,
		[74842] = F.INEDIBLE,
		[74843] = F.INEDIBLE,
		[74844] = F.INEDIBLE,
		[74846] = F.INEDIBLE,
		[74847] = F.INEDIBLE,
		[74848] = F.INEDIBLE,
		[74849] = F.INEDIBLE,
		[74850] = F.INEDIBLE
	},
	[Fungus] = {
		-- Mists and before
		[3448] = F.BASIC,
		[4604] = F.BASIC,
		[4605] = F.BASIC,
		[4606] = F.BASIC,
		[4607] = F.BASIC,
		[4608] = F.BASIC,
		[8948] = F.BASIC,
		[27859] = F.BASIC,
		[29453] = F.BASIC,
		[30355] = F.BASIC,
		[33452] = F.BASIC,
		[35947] = F.BASIC,
		[41751] = F.BASIC,
		[58266] = F.BASIC,
		[58267] = F.BASIC,
		[58279] = F.BASIC,
		[59228] = F.BASIC,
		[81889] = F.BASIC,
		[81916] = F.BASIC,
		[24539] = F.BONUS,
		[24008] = F.BONUS,
		[81404] = F.BONUS,
		[81412] = F.BONUS,
		[27676] = F.INEDIBLE
	}
}
