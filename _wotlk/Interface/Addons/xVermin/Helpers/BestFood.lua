local _, xVermin = ...

local defaultFoodMacro = [[#showtooltip
/use [nocombat]<food>
/castsequence [combat] reset=combat <hPotions>
]]

local defaultPetFoodMacro = [[#showtooltip <petfood>
/cast feed pet
/use <petfood>
]]

local defaultDrinkMacro = [[#showtooltip
/use [nocombat]<drink>
/castsequence [combat] reset=combat <mPotions>
]]

local defaultHealthstoneMacro = [[#showtooltip
/use <healthstone>
]]

local defaultHealthPotionMacro = [[#showtooltip
/use <hPotion>
]]

local function CreateOrUpdateMacro(macroName, text)
	local macroID = GetMacroIndexByName(macroName)
	if macroID == 0 then
		CreateMacro(macroName, 'Inv_misc_questionmark', text, nil, nil)
	else
		EditMacro(macroID, macroName, 'Inv_misc_questionmark', text, nil, nil)
	end
end

local NeedsFoodBadly

NeedsFoodBadly = CreateFrame('frame')
NeedsFoodBadly:RegisterEvent('BAG_UPDATE_DELAYED')
NeedsFoodBadly:RegisterEvent('PLAYER_REGEN_ENABLED')
NeedsFoodBadly:RegisterEvent('PLAYER_LEVEL_CHANGED')
NeedsFoodBadly:RegisterEvent('UNIT_PET')
NeedsFoodBadly:RegisterEvent('PLAYER_ENTERING_WORLD')

NeedsFoodBadly.dirty = false
NeedsFoodBadly:SetScript(
	'OnEvent',
	function(self, event, ...)
		if event == 'BAG_UPDATE_DELAYED' or event == 'PLAYER_LEVEL_CHANGED' or event == 'UNIT_PET' or event == 'PLAYER_ENTERING_WORLD' then
			if InCombatLockdown() then
				NeedsFoodBadly.dirty = true
			else
				NeedsFoodBadly:UpdateMacros()
			end
		elseif event == 'PLAYER_REGEN_ENABLED' and NeedsFoodBadly.dirty then
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
	local foodMacro =
		defaultFoodMacro:gsub(
		'<%a+>',
		{
			['<food>'] = 'item:' .. tostring(best.food[1] and best.food[1].id or 00),
			['<buffFood>'] = 'item:' .. tostring(best.buffFood[1] and best.buffFood[1].id or 0),
			['<bandage>'] = 'item:' .. tostring(best.bandage[1] and best.bandage[1].id or 0),
			['<hPotions>'] = self:BuildSequence(best.healthstone, best.hPotion)
		}
	)
	local drinkMacro =
		defaultDrinkMacro:gsub(
		'<%a+>',
		{
			['<drink>'] = 'item:' .. tostring(best.drink[1] and best.drink[1].id or 0),
			['<buffDrink>'] = 'item:' .. tostring(best.buffDrink[1] and best.buffDrink[1].id or 0),
			['<manaBuff>'] = 'item:' .. tostring(best.buffDrink[1] and best.buffDrink[1].id or 0),
			['<mPotions>'] = self:BuildSequence(best.manaGem, best.mPotion)
			--["<mPotions>"] = 'item:'..tostring(best.mPotion[1] and best.mPotion[1].id or 0)
		}
	)
	local healthstoneMacro =
		defaultHealthstoneMacro:gsub(
		'<%a+>',
		{
			['<healthstone>'] = 'item:' .. tostring(best.healthstone[1] and best.healthstone[1].id or 0)
		}
	)
	local healthPotionMacro =
		defaultHealthPotionMacro:gsub(
		'<%a+>',
		{
			['<hPotion>'] = 'item:' .. tostring(best.hPotion[1] and best.hPotion[1].id or 0)
		}
	)

	CreateOrUpdateMacro('Food', foodMacro)
	CreateOrUpdateMacro('Drink', drinkMacro)
	CreateOrUpdateMacro('Stone', healthstoneMacro)
	CreateOrUpdateMacro('Potion', healthPotionMacro)

	if (UnitExists('pet') and xVermin.Class == 'HUNTER') then
		-- local petType = UnitCreatureFamily("pet")

		local petfoodMacro =
			defaultPetFoodMacro:gsub(
			'<%a+>',
			{
				['<petfood>'] = 'item:' .. tostring(best.petfood[1] and best.petfood[1].id or 0)
			}
		)
		CreateOrUpdateMacro('PF', petfoodMacro)
	end
end

function NeedsFoodBadly:Sorted(t, f)
	local sortedTable = {}
	for _, v in pairs(t) do
		table.insert(sortedTable, v)
	end
	table.sort(sortedTable, f)
	return sortedTable
end

function NeedsFoodBadly:IsUsableFood(food)
	return not (not (food and select(5, GetItemInfo(food.id)) and select(5, GetItemInfo(food.id)) <= UnitLevel('player') and food.hp))
	-- and food.lvl <= UnitLevel("player")
	-- and not (food.hp5 or food.mp5 or food.str or food.agi or food.stam or food.int or food.spi)
end

function NeedsFoodBadly:IsUsablePetFood(food)
	local diet = {}
	local petFoodList = {GetPetFoodTypes()}
	if #petFoodList > 0 then
		local index, foodType
		for index, foodType in pairs(petFoodList) do
			table.insert(diet, foodType)
		end
	end
	return not (not (food and self:FindPairInPetFoodArray(food, diet)))
end

function NeedsFoodBadly:FindPairInPetFoodArray(food, diet)
	for i, v in ipairs(diet) do
		if v == food.type then
			return true
		end
	end
	return false
end

function NeedsFoodBadly:IsUsableBuffFood(food)
	return not (not (food and select(5, GetItemInfo(food.id)) and select(5, GetItemInfo(food.id)) <= UnitLevel('player') and (food.hp and food.stam and food.spi)))
end

function NeedsFoodBadly:IsUsableDrink(food)
	return not (not (food and select(5, GetItemInfo(food.id)) and select(5, GetItemInfo(food.id)) <= UnitLevel('player') and food.mp))
	-- and not food.mp5
end

function NeedsFoodBadly:IsUsableBuffDrink(food)
	return not (not (food and select(5, GetItemInfo(food.id)) and select(5, GetItemInfo(food.id)) <= UnitLevel('player') and food.mp5))
end

function NeedsFoodBadly:IsUsableHPotion(potion)
	return not (not (potion and potion.lvl <= UnitLevel('player') and potion.hp and not potion.bg))
end

function NeedsFoodBadly:IsUsableMPotion(potion)
	return not (not (potion and potion.lvl <= UnitLevel('player') and potion.mp and not potion.bg))
end

function NeedsFoodBadly:IsUsableHealthstone(healthstone)
	return not (not (healthstone and healthstone.lvl <= UnitLevel('player')))
end

function NeedsFoodBadly:IsUsableManaGem(manaGem)
	return not (not (manaGem and manaGem.lvl <= UnitLevel('player')))
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
	if not a then
		return false
	end
	if not b then
		return false
	end

	if a.conj and not b.conj then
		return true
	elseif b.conj and not a.conj then
		return false
	end
	-- Percent food is stored as a decimal number, ie "Restores 2% health" is hp=0.02
	a_hp, b_hp = a.hp, b.hp
	if a_hp < 1 then
		a_hp = UnitHealthMax('player') * a_hp
	end
	if b_hp < 1 then
		b_hp = UnitHealthMax('player') * b_hp
	end
	return (a_hp > b_hp) or (a_hp == b_hp and GetItemCount(a.id) <= GetItemCount(b.id))
end

function NeedsFoodBadly.BetterPetFood(a, b)
	if not a then
		return false
	end
	if not b then
		return false
	end

	return GetItemCount(a.id) <= GetItemCount(b.id)
end

function NeedsFoodBadly.BetterBuffFood(a, b)
	if not a then
		return false
	end
	if not b then
		return false
	end

	return a.stam > b.stam or (a.stam == b.stam and GetItemCount(a.id) <= GetItemCount(b.id))
end

function NeedsFoodBadly.BetterDrink(a, b)
	if not a then
		return false
	end
	if not b then
		return false
	end

	if (a and a.conj) and (b and not b.conj) then
		return true
	elseif (b and b.conj) and (a and not a.conj) then
		return false
	end
	a_mp, b_mp = a.mp, b.mp
	if a_mp < 1 then
		a_mp = UnitHealthMax('player') * a_mp
	end
	if b_mp < 1 then
		b_mp = UnitHealthMax('player') * b_mp
	end

	return a_mp > b_mp or (a_mp == b_mp and GetItemCount(a.id) <= GetItemCount(b.id))
end

function NeedsFoodBadly.BetterBuffDrink(a, b)
	if not a then
		return false
	end
	if not b then
		return false
	end

	return a.mp5 > b.mp5 or (a.mp5 == b.mp5 and GetItemCount(a.id) <= GetItemCount(b.id))
end

function NeedsFoodBadly.BetterHPotion(a, b)
	if not a then
		return false
	end
	if not b then
		return false
	end

	return a.high >= b.high
end

function NeedsFoodBadly.BetterMPotion(a, b)
	if not a then
		return false
	end
	if not b then
		return false
	end

	return a.high >= b.high
end

function NeedsFoodBadly.BetterHealthstone(a, b)
	if not a then
		return false
	end
	if not b then
		return false
	end

	return a.hp >= b.hp
end

function NeedsFoodBadly.BetterManaGem(a, b)
	if not a then
		return false
	end
	if not b then
		return false
	end

	return a.high >= b.high
end

function NeedsFoodBadly.BetterBandage(a, b)
	if not a then
		return false
	end
	if not b then
		return false
	end

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
		table.insert(sequence, 'item:' .. tostring(stone[1].id))
	end
	for _, potion in pairs(potions) do
		-- for _ = 1, GetItemCount(potion.id) do
		table.insert(sequence, 'item:' .. tostring(potion.id))
		-- end
	end
	local sequenceStr = table.concat(sequence, ',', 1, math.min(table.getn(sequence), 14))
	return sequenceStr
end

NeedsFoodBadly.Food = {
	[8932] = {id = 8932, name = 'Alterac Swiss', lvl = 45, conj = false, hp = 2148},
	[4536] = {id = 4536, name = 'Shiny Red Apple', lvl = 1, conj = false, hp = 61.2},
	[13546] = {id = 13546, name = 'Bloodbelly Fish', lvl = 25, conj = false, hp = 1392},
	[159] = {id = 159, name = 'Refreshing Spring Water', lvl = 2, conj = false, mp = 151.2},
	[13928] = {id = 13928, name = 'Grilled Squid', lvl = 35, conj = false, hp = 874.8, agi = 10},
	[18254] = {id = 18254, name = 'Runn Tum Tuber Surprise', lvl = 45, conj = false, hp = 1933.2, int = 10},
	[12218] = {id = 12218, name = 'Monster Omelet', lvl = 40, conj = false, hp = 1392, stam = 12, spi = 12},
	[20452] = {id = 20452, name = 'Smoked Desert Dumplings', lvl = 45, conj = false, hp = 2148, str = 20},
	[12238] = {id = 12238, name = 'Darkshore Grouper', lvl = 5, conj = false, hp = 243.6},
	[4791] = {id = 4791, name = 'Enchanted Water', lvl = 25, conj = false, mp = 1344.6},
	[16971] = {id = 16971, name = 'Clamlette Surprise', lvl = 40, conj = false, hp = 1392, stam = 12, spi = 12},
	[21023] = {id = 21023, name = "Dirge's Kickin' Chimaerok Chops", lvl = 55, conj = false, hp = 4320, stam = 25},
	[4593] = {id = 4593, name = 'Bristle Whisker Catfish', lvl = 15, conj = false, hp = 552},
	[1179] = {id = 1179, name = 'Ice Cold Milk', lvl = 5, conj = false, mp = 436.8},
	[17222] = {id = 17222, name = 'Spider Sausage', lvl = 35, conj = false, hp = 1392, stam = 12, spi = 12},
	[18255] = {id = 18255, name = 'Runn Tum Tuber', lvl = 45, conj = false, hp = 1392},
	[11109] = {id = 11109, name = 'Special Chicken Feed', lvl = 0, conj = false, hp = 30},
	[13724] = {id = 13724, name = 'Enriched Manna Biscuit', lvl = 45, conj = false, hp = 2148, mp = 4410},
	[5527] = {id = 5527, name = 'Goblin Deviled Clams', lvl = 15, conj = false, hp = 552, stam = 6, spi = 6},
	[4592] = {id = 4592, name = 'Longjaw Mud Snapper', lvl = 5, conj = false, hp = 243.6},
	[3729] = {id = 3729, name = 'Soothing Turtle Bisque', lvl = 25, conj = false, hp = 874.8, stam = 8, spi = 8},
	[8952] = {id = 8952, name = 'Roasted Quail', lvl = 45, conj = false, hp = 2148},
	[13810] = {id = 13810, name = 'Blessed Sunfruit', lvl = 45, conj = false, hp = 1933.2, str = 10},
	[4457] = {id = 4457, name = 'Barbecued Buzzard Wing', lvl = 25, conj = false, hp = 874.8, stam = 8, spi = 8},
	[6299] = {id = 6299, name = 'Sickly Looking Fish', lvl = 0, conj = false, hp = 30},
	[8766] = {id = 8766, name = 'Morning Glory Dew', lvl = 45, conj = false, mp = 2934},
	[6887] = {id = 6887, name = 'Spotted Yellowtail', lvl = 35, conj = false, hp = 1392},
	[8079] = {id = 8079, name = 'Conjured Crystal Water', lvl = 55, conj = true, mp = 4200},
	[3771] = {id = 3771, name = 'Wild Hog Shank', lvl = 25, conj = false, hp = 874.8},
	[18045] = {id = 18045, name = 'Tender Wolf Steak', lvl = 40, conj = false, hp = 1392, stam = 12, spi = 12},
	[1645] = {id = 1645, name = 'Moonberry Juice', lvl = 35, conj = false, mp = 1992},
	[3770] = {id = 3770, name = 'Mutton Chop', lvl = 15, conj = false, hp = 552},
	[13851] = {id = 13851, name = 'Hot Wolf Ribs', lvl = 25, conj = false, hp = 874.8, stam = 8, spi = 8},
	[8364] = {id = 8364, name = 'Mithril Head Trout', lvl = 25, conj = false, hp = 874.8},
	[12216] = {id = 12216, name = 'Spiced Chili Crab', lvl = 40, conj = false, hp = 1392, stam = 12, spi = 12},
	[4594] = {id = 4594, name = 'Rockscale Cod', lvl = 25, conj = false, hp = 874.8},
	[4599] = {id = 4599, name = 'Cured Ham Steak', lvl = 35, conj = false, hp = 1392},
	[1708] = {id = 1708, name = 'Sweet Nectar', lvl = 25, conj = false, mp = 1344.6},
	[3927] = {id = 3927, name = 'Fine Aged Cheddar', lvl = 35, conj = false, hp = 1392},
	[12213] = {id = 12213, name = 'Carrion Surprise', lvl = 25, conj = false, hp = 874.8, stam = 8, spi = 8},
	[4544] = {id = 4544, name = 'Mulgore Spice Bread', lvl = 25, conj = false, hp = 874.8},
	[2684] = {id = 2684, name = 'Coyote Steak', lvl = 5, conj = false, hp = 243.6, stam = 4, spi = 4},
	[16766] = {id = 16766, name = 'Undermine Clam Chowder', lvl = 35, conj = false, hp = 1392},
	[13927] = {id = 13927, name = 'Cooked Glossy Mightfish', lvl = 35, conj = false, hp = 874.8, stam = 10},
	[12214] = {id = 12214, name = 'Mystery Stew', lvl = 25, conj = false, hp = 874.8, stam = 8, spi = 8},
	[117] = {id = 117, name = 'Tough Jerky', lvl = 6, conj = false, hp = 61.2},
	[5525] = {id = 5525, name = 'Boiled Clams', lvl = 5, conj = false, hp = 243.6, stam = 4, spi = 4},
	[3665] = {id = 3665, name = 'Curiously Tasty Omelet', lvl = 15, conj = false, hp = 552, stam = 6, spi = 6},
	[19301] = {id = 19301, name = 'Alterac Manna Biscuit', lvl = 51, conj = false, hp = 4410, mp = 4410},
	[5095] = {id = 5095, name = 'Rainbow Fin Albacore', lvl = 5, conj = false, hp = 243.6},
	[787] = {id = 787, name = 'Slitherskin Mackerel', lvl = 0, conj = false, hp = 61.2},
	[3728] = {id = 3728, name = 'Tasty Lion Steak', lvl = 20, conj = false, hp = 874.8, stam = 8, spi = 8},
	[6290] = {id = 6290, name = 'Brilliant Smallfish', lvl = 0, conj = false, hp = 61.2},
	[12212] = {id = 12212, name = 'Jungle Stew', lvl = 25, conj = false, hp = 874.8, stam = 8, spi = 8},
	[4604] = {id = 4604, name = 'Forest Mushroom Cap', lvl = 4, conj = false, hp = 61.2},
	[12210] = {id = 12210, name = 'Roast Raptor', lvl = 25, conj = false, hp = 874.8, stam = 8, spi = 8},
	[10841] = {id = 10841, name = 'Goldthorn Tea', lvl = 25, conj = false, mp = 1344.6},
	[2683] = {id = 2683, name = 'Crab Cake', lvl = 5, conj = false, hp = 243.6, stam = 4, spi = 4},
	[20074] = {id = 20074, name = 'Heavy Crocolisk Stew', lvl = 20, conj = false, hp = 874.8, stam = 8, spi = 8},
	[8078] = {id = 8078, name = 'Conjured Sparkling Water', lvl = 45, conj = true, mp = 2934},
	[13934] = {id = 13934, name = 'Mightfish Steak', lvl = 45, conj = false, hp = 1933.2, stam = 10},
	[2687] = {id = 2687, name = 'Dry Pork Ribs', lvl = 5, conj = false, hp = 243.6, stam = 4, spi = 4},
	[4539] = {id = 4539, name = 'Goldenbark Apple', lvl = 25, conj = false, hp = 874.8},
	[13930] = {id = 13930, name = 'Filet of Redgill', lvl = 35, conj = false, hp = 1392},
	[18300] = {id = 18300, name = 'Hyjal Nectar', lvl = 55, conj = false, mp = 4200},
	[6890] = {id = 6890, name = 'Smoked Bear Meat', lvl = 5, conj = false, hp = 243.6},
	[4607] = {id = 4607, name = 'Delicious Cave Mold', lvl = 25, conj = false, hp = 874.8},
	[1017] = {id = 1017, name = 'Seasoned Wolf Kabob', lvl = 15, conj = false, hp = 552, stam = 6, spi = 6},
	[4537] = {id = 4537, name = "Tel'Abim Banana", lvl = 5, conj = false, hp = 243.6},
	[13935] = {id = 13935, name = 'Baked Salmon', lvl = 45, conj = false, hp = 2148},
	[13929] = {id = 13929, name = 'Hot Smoked Bass', lvl = 35, conj = false, hp = 874.8, spi = 10},
	[4602] = {id = 4602, name = 'Moon Harvest Pumpkin', lvl = 35, conj = false, hp = 1392},
	[2888] = {id = 2888, name = 'Beer Basted Boar Ribs', lvl = 5, conj = false, hp = 61.2, stam = 2, spi = 2},
	[8077] = {id = 8077, name = 'Conjured Mineral Water', lvl = 35, conj = true, mp = 1992},
	[13933] = {id = 13933, name = 'Lobster Stew', lvl = 45, conj = false, hp = 2148},
	[5472] = {id = 5472, name = 'Kaldorei Spider Kabob', lvl = 1, conj = false, hp = 61.2, stam = 2, spi = 2},
	[22895] = {id = 22895, name = 'Conjured Cinnamon Roll', lvl = 55, conj = true, hp = 3180},
	[4608] = {id = 4608, name = 'Raw Black Truffle', lvl = 35, conj = false, hp = 1392},
	[3666] = {id = 3666, name = 'Gooey Spider Cake', lvl = 15, conj = false, hp = 552, stam = 6, spi = 6},
	[8957] = {id = 8957, name = 'Spinefin Halibut', lvl = 45, conj = false, hp = 2148},
	[3220] = {id = 3220, name = 'Blood Sausage', lvl = 5, conj = false, hp = 243.6, stam = 4, spi = 4},
	[7228] = {id = 7228, name = "Tigule and Foror's Strawberry Ice Cream", lvl = 15, conj = false, hp = 552},
	[1082] = {id = 1082, name = 'Redridge Goulash', lvl = 10, conj = false, hp = 552, stam = 6, spi = 6},
	[2287] = {id = 2287, name = 'Haunch of Meat', lvl = 5, conj = false, hp = 243.6},
	[1707] = {id = 1707, name = 'Stormwind Brie', lvl = 25, conj = false, hp = 874.8},
	[8950] = {id = 8950, name = 'Homemade Cherry Pie', lvl = 45, conj = false, hp = 2148},
	[18632] = {id = 18632, name = 'Moonbrook Riot Taffy', lvl = 25, conj = false, hp = 874.8},
	[8948] = {id = 8948, name = 'Dried King Bolete', lvl = 45, conj = false, hp = 2148},
	[3772] = {id = 3772, name = 'Conjured Spring Water', lvl = 25, conj = true, mp = 1344.6},
	[12209] = {id = 12209, name = 'Lean Wolf Steak', lvl = 15, conj = false, hp = 552, stam = 6, spi = 6},
	[3726] = {id = 3726, name = 'Big Bear Steak', lvl = 15, conj = false, hp = 552, stam = 6, spi = 6},
	[733] = {id = 733, name = 'Westfall Stew', lvl = 5, conj = false, hp = 552},
	[3664] = {id = 3664, name = 'Crocolisk Gumbo', lvl = 15, conj = false, hp = 552, stam = 6, spi = 6},
	[1205] = {id = 1205, name = 'Melon Juice', lvl = 15, conj = false, mp = 835.2},
	[4605] = {id = 4605, name = 'Red-speckled Mushroom', lvl = 5, conj = false, hp = 243.6},
	[2682] = {id = 2682, name = 'Cooked Crab Claw', lvl = 5, conj = false, hp = 294, mp = 294},
	[20031] = {id = 20031, name = 'Essence Mango', lvl = 55, conj = false, hp = 4320, mp = 4410},
	[5477] = {id = 5477, name = 'Strider Stew', lvl = 5, conj = false, hp = 243.6, stam = 4, spi = 4},
	[4606] = {id = 4606, name = 'Spongy Morel', lvl = 15, conj = false, hp = 552},
	[5478] = {id = 5478, name = 'Dig Rat Stew', lvl = 10, conj = false, hp = 552},
	[12215] = {id = 12215, name = 'Heavy Kodo Stew', lvl = 35, conj = false, hp = 1392, stam = 12, spi = 12},
	[3663] = {id = 3663, name = 'Murloc Fin Soup', lvl = 15, conj = false, hp = 552, stam = 6, spi = 6},
	[8953] = {id = 8953, name = 'Deep Fried Plantains', lvl = 45, conj = false, hp = 2148},
	[5480] = {id = 5480, name = 'Lean Venison', lvl = 15, conj = false, hp = 552, stam = 6, spi = 6},
	[2136] = {id = 2136, name = 'Conjured Purified Water', lvl = 15, conj = true, mp = 835.2},
	[2681] = {id = 2681, name = 'Roasted Boar Meat', lvl = 0, conj = false, hp = 61.2},
	[12224] = {id = 12224, name = 'Crispy Bat Wing', lvl = 0, conj = false, hp = 61.2, stam = 2, spi = 2},
	[4538] = {id = 4538, name = 'Snapvine Watermelon', lvl = 15, conj = false, hp = 552},
	[5479] = {id = 5479, name = 'Crispy Lizard Tail', lvl = 12, conj = false, hp = 552, stam = 6, spi = 6},
	[3727] = {id = 3727, name = 'Hot Lion Chops', lvl = 15, conj = false, hp = 552, stam = 6, spi = 6},
	[4601] = {id = 4601, name = 'Soft Banana Bread', lvl = 35, conj = false, hp = 1392},
	[3448] = {id = 3448, name = 'Senggin Root', lvl = 9, conj = false, hp = 294, mp = 294},
	[6807] = {id = 6807, name = 'Frog Leg Stew', lvl = 30, conj = false, hp = 874.8},
	[2680] = {id = 2680, name = 'Spiced Wolf Meat', lvl = 0, conj = false, hp = 61.2, stam = 2, spi = 2},
	[21552] = {id = 21552, name = 'Striped Yellowtail', lvl = 35, conj = false, hp = 1392},
	[2679] = {id = 2679, name = 'Charred Wolf Meat', lvl = 0, conj = false, hp = 61.2},
	[6038] = {id = 6038, name = 'Giant Clam Scorcho', lvl = 25, conj = false, hp = 874.8, stam = 8, spi = 8},
	[5066] = {id = 5066, name = 'Fissure Plant', lvl = 5, conj = false, hp = 243.6},
	[6888] = {id = 6888, name = 'Herb Baked Egg', lvl = 0, conj = false, hp = 61.2, stam = 2, spi = 2},
	[5526] = {id = 5526, name = 'Clam Chowder', lvl = 10, conj = false, hp = 552},
	[5350] = {id = 5350, name = 'Conjured Water', lvl = 0, conj = true, mp = 151.2},
	[1326] = {id = 1326, name = 'Sauteed Sunfish', lvl = 12, conj = false, hp = 243.6},
	[21215] = {id = 21215, name = "Graccu's Mince Meat Fruitcake", lvl = 40, conj = false, hp = 0.05, mp = 0.05},
	[8076] = {id = 8076, name = 'Conjured Sweet Roll', lvl = 45, conj = true, hp = 2148},
	[9451] = {id = 9451, name = 'Bubbling Water', lvl = 15, conj = false, mp = 835.2},
	[422] = {id = 422, name = 'Dwarven Mild', lvl = 15, conj = false, hp = 552},
	[2070] = {id = 2070, name = 'Darnassian Bleu', lvl = 1, conj = false, hp = 61.2},
	[4541] = {id = 4541, name = 'Freshly Baked Bread', lvl = 5, conj = false, hp = 243.6},
	[414] = {id = 414, name = 'Dalaran Sharp', lvl = 5, conj = false, hp = 243.6},
	[17197] = {id = 17197, name = 'Gingerbread Cookie', lvl = 0, conj = false, hp = 61.2, stam = 2, spi = 2},
	[17119] = {id = 17119, name = 'Deeprun Rat Kabob', lvl = 5, conj = false, hp = 243.6},
	[724] = {id = 724, name = 'Goretusk Liver Pie', lvl = 5, conj = false, hp = 243.6, stam = 4, spi = 4},
	[8075] = {id = 8075, name = 'Conjured Sourdough', lvl = 35, conj = true, hp = 1392},
	[4542] = {id = 4542, name = 'Moist Cornbread', lvl = 15, conj = false, hp = 552},
	[2288] = {id = 2288, name = 'Conjured Fresh Water', lvl = 5, conj = true, mp = 436.8},
	[17198] = {id = 17198, name = 'Egg Nog', lvl = 0, conj = false, hp = 61.2, stam = 2, spi = 2},
	[9681] = {id = 9681, name = 'Grilled King Crawler Legs', lvl = 35, conj = false, hp = 1392},
	[7097] = {id = 7097, name = 'Leg Meat', lvl = 0, conj = false, hp = 61.2},
	[19300] = {id = 19300, name = 'Bottled Winterspring Water', lvl = 35, conj = false, mp = 1992},
	[4540] = {id = 4540, name = 'Tough Hunk of Bread', lvl = 6, conj = false, hp = 61.2},
	[3662] = {id = 3662, name = 'Crocolisk Steak', lvl = 5, conj = false, hp = 243.6, stam = 4, spi = 4},
	[2685] = {id = 2685, name = 'Succulent Pork Ribs', lvl = 10, conj = false, hp = 552},
	[11584] = {id = 11584, name = 'Cactus Apple Surprise', lvl = 1, conj = false, hp = 61.2, stam = 2, spi = 2},
	[1487] = {id = 1487, name = 'Conjured Pumpernickel', lvl = 25, conj = true, hp = 874.8},
	[1113] = {id = 1113, name = 'Conjured Bread', lvl = 5, conj = true, hp = 243.6},
	[5474] = {id = 5474, name = 'Roasted Kodo Meat', lvl = 0, conj = false, hp = 61.2, stam = 2, spi = 2},
	[5349] = {id = 5349, name = 'Conjured Muffin', lvl = 0, conj = true, hp = 61.2},
	[19996] = {id = 19996, name = 'Harvest Fish', lvl = 0, conj = false, hp = 0.02},
	[961] = {id = 961, name = 'Healing Herb', lvl = 1, conj = false, hp = 61.2},
	[1114] = {id = 1114, name = 'Conjured Rye', lvl = 15, conj = true, hp = 552},
	[5476] = {id = 5476, name = 'Fillet of Frenzy', lvl = 5, conj = false, hp = 243.6, stam = 4, spi = 4},
	[21031] = {id = 21031, name = 'Cabbage Kimchi', lvl = 45, conj = false, hp = 2148},
	[23172] = {id = 23172, name = 'Refreshing Red Apple', lvl = 0, conj = false, hp = 0.04, mp = 0.04},
	[21254] = {id = 21254, name = 'Winter Veil Cookie', lvl = 0, conj = false, hp = 0.02, stam = 0.25, spi = 0.25},
	[11444] = {id = 11444, name = 'Grim Guzzler Boar', lvl = 45, conj = false, hp = 2148},
	[4656] = {id = 4656, name = 'Small Pumpkin', lvl = 8, conj = false, hp = 61.2},
	[11415] = {id = 11415, name = 'Mixed Berries', lvl = 45, conj = false, hp = 2148},
	[6316] = {id = 6316, name = 'Loch Frenzy Delight', lvl = 5, conj = false, hp = 243.6},
	[19299] = {id = 19299, name = 'Fizzy Faire Drink', lvl = 15, conj = false, mp = 835.2},
	[20516] = {id = 20516, name = 'Bobbing Apple', lvl = 0, conj = false, hp = 0.02, stam = 0.25, spi = 0.25},
	[19224] = {id = 19224, name = 'Red Hot Wings', lvl = 25, conj = false, hp = 874.8},
	[19696] = {id = 19696, name = 'Harvest Bread', lvl = 0, conj = true, hp = 0.02},
	[16170] = {id = 16170, name = 'Steamed Mandu', lvl = 15, conj = false, hp = 552},
	[17406] = {id = 17406, name = 'Holiday Cheesewheel', lvl = 5, conj = false, hp = 243.6},
	[21030] = {id = 21030, name = 'Darnassus Kimchi Pie', lvl = 35, conj = false, hp = 1392},
	[17404] = {id = 17404, name = 'Blended Bean Brew', lvl = 5, conj = false, mp = 436.8},
	[17344] = {id = 17344, name = 'Candy Cane', lvl = 0, conj = false, hp = 61.2},
	[22324] = {id = 22324, name = 'Winter Kimchi', lvl = 45, conj = false, hp = 2148},
	[16168] = {id = 16168, name = 'Heaven Peach', lvl = 35, conj = false, hp = 1392},
	[5057] = {id = 5057, name = 'Ripe Watermelon', lvl = 8, conj = false, hp = 61.2},
	[21236] = {id = 21236, name = 'Winter Veil Loaf', lvl = 0, conj = false, hp = 0.02},
	[8543] = {id = 8543, name = 'Underwater Mushroom Cap', lvl = 25, conj = false, hp = 874.8},
	[16167] = {id = 16167, name = 'Versicolor Treat', lvl = 5, conj = false, hp = 243.6},
	[12763] = {id = 12763, name = "Un'Goro Etherfruit", lvl = 45, conj = false, hp = 2148},
	[21235] = {id = 21235, name = 'Winter Veil Roast', lvl = 0, conj = false, hp = 0.02},
	[19306] = {id = 19306, name = 'Crunchy Frog', lvl = 35, conj = false, hp = 1392},
	[17407] = {id = 17407, name = "Graccu's Homemade Meat Pie", lvl = 25, conj = false, hp = 874.8},
	[16169] = {id = 16169, name = 'Wild Ricecake', lvl = 25, conj = false, hp = 874.8},
	[19304] = {id = 19304, name = 'Spiced Beef Jerky', lvl = 5, conj = false, hp = 243.6},
	[18633] = {id = 18633, name = "Styleen's Sour Suckerpop", lvl = 5, conj = false, hp = 243.6},
	[7807] = {id = 7807, name = 'Candy Bar', lvl = 0, conj = false, hp = 61.2, stam = 2, spi = 2},
	[7808] = {id = 7808, name = 'Chocolate Square', lvl = 0, conj = false, hp = 61.2, stam = 2, spi = 2},
	[19994] = {id = 19994, name = 'Harvest Fruit', lvl = 0, conj = false, hp = 0.02},
	[17199] = {id = 17199, name = 'Bad Egg Nog', lvl = 0, conj = false, hp = 61.2, stam = 2, spi = 2},
	[23160] = {id = 23160, name = 'Friendship Bread', lvl = 45, conj = false, hp = 2148},
	[17408] = {id = 17408, name = 'Spicy Beefstick', lvl = 35, conj = false, hp = 1392},
	[19223] = {id = 19223, name = 'Darkmoon Dog', lvl = 0, conj = false, hp = 61.2},
	[21033] = {id = 21033, name = 'Radish Kimchi', lvl = 45, conj = false, hp = 2148},
	[19995] = {id = 19995, name = 'Harvest Boar', lvl = 0, conj = false, hp = 0.02},
	[16171] = {id = 16171, name = 'Shinsollo', lvl = 45, conj = false, hp = 2148},
	[12211] = {id = 12211, name = 'Spiced Wolf Ribs', lvl = 25, conj = false, hp = 874.8, stam = 8, spi = 8},
	[7806] = {id = 7806, name = 'Lollipop', lvl = 0, conj = false, hp = 61.2, stam = 2, spi = 2},
	[19225] = {id = 19225, name = 'Deep Fried Candybar', lvl = 45, conj = false, hp = 2148},
	[18635] = {id = 18635, name = "Bellara's Nutterbar", lvl = 35, conj = false, hp = 1392},
	[21240] = {id = 21240, name = 'Winter Veil Candy', lvl = 0, conj = false, hp = 0.02},
	[1119] = {id = 1119, name = 'Bottled Spirits', lvl = 0, conj = false, hp = 552},
	[19305] = {id = 19305, name = 'Pickled Kodo Foot', lvl = 15, conj = false, hp = 552},
	[16166] = {id = 16166, name = 'Bean Soup', lvl = 0, conj = false, hp = 61.2},
	[13813] = {id = 13813, name = 'Blessed Sunfruit Juice', lvl = 45, conj = false, mp = 4410, spi = 10},
	[13931] = {id = 13931, name = 'Nightfin Soup', lvl = 35, conj = false, hp = 874.8, mp5 = 8},
	[21217] = {id = 21217, name = 'Sagefish Delight', lvl = 30, conj = false, hp = 840.0, mp = 1260, mp5 = 6},
	[21072] = {id = 21072, name = 'Smoked Sagefish', lvl = 10, conj = false, hp = 378.0, mp = 567, mp5 = 3},
	[13932] = {id = 13932, name = 'Poached Sunscale Salmon', lvl = 35, conj = false, hp = 874.8, hp5 = 6},
	[1401] = {id = 1401, name = 'Green Tea Leaf', lvl = 4, conj = false, hp = 30, mp = 60},
	[5473] = {id = 5473, name = 'Scorpid Surprise', lvl = 0, conj = false, hp = 294},
	[33052] = {id = 33052, name = "Fisherman's Feast", lvl = 65, conj = false, hp = 7500, spi = 20, stam = 30},
	[27657] = {id = 27657, name = 'Blackened Basilisk', lvl = 55, conj = false, hp = 7500, spi = 20, spldmg = 23},
	[31673] = {id = 31673, name = 'Crunchy Serpent', lvl = 55, conj = false, hp = 7500, spi = 20, spldmg = 23},
	[32453] = {id = 32453, name = "Star's Tears", lvl = 65, conj = false, mp = 7200},
	[33866] = {id = 33866, name = 'Stormchops', lvl = 55, conj = false, spldmg = 1},
	[33872] = {id = 33872, name = 'Spicy Hot Talbuk', lvl = 65, conj = false, hp = 7500, mlehitrtng = 20, rgdhitrtng = 20, spi = 20},
	[27665] = {id = 27665, name = 'Poached Bluefish', lvl = 55, conj = false, hp = 7500, spi = 20, spldmg = 23},
	[27658] = {id = 27658, name = 'Roasted Clefthoof', lvl = 55, conj = false, hp = 7500, spi = 20, str = 20},
	[27860] = {id = 27860, name = 'Purified Draenic Water', lvl = 65, conj = false, mp = 7200},
	[27666] = {id = 27666, name = 'Golden Fish Sticks', lvl = 55, conj = false, hp = 7500, spi = 20, splheal = 44},
	[27659] = {id = 27659, name = 'Warp Burger', lvl = 55, conj = false, hp = 7500, agi = 20, spi = 20},
	[31672] = {id = 31672, name = "Mok'Nathal Shortribs", lvl = 55, conj = false, hp = 7500, spi = 20, stam = 20},
	[27667] = {id = 27667, name = 'Spicy Crawdad', lvl = 55, conj = false, hp = 7500, spi = 20, stam = 30},
	[27664] = {id = 27664, name = 'Grilled Mudfish', lvl = 55, conj = false, hp = 7500, agi = 20, spi = 20},
	[34062] = {id = 34062, name = 'Conjured Manna Biscuit', lvl = 65, conj = true, hp = 7500, mp = 7200},
	[29451] = {id = 29451, name = 'Clefthoof Ribs', lvl = 65, conj = false, hp = 7500},
	[27854] = {id = 27854, name = 'Smoked Talbuk Venison', lvl = 55, conj = false, hp = 4320},
	[27655] = {id = 27655, name = 'Ravager Dog', lvl = 55, conj = false, hp = 4320, mleatkpwr = 40, rgdatkpwr = 40, spi = 20},
	[28399] = {id = 28399, name = 'Filtered Draenic Water', lvl = 60, conj = false, mp = 5100},
	[33053] = {id = 33053, name = 'Hot Buttered Trout', lvl = 65, conj = false, hp = 7500, mp = 7200},
	[27858] = {id = 27858, name = 'Sunspring Carp', lvl = 55, conj = false, hp = 4320},
	[33825] = {id = 33825, name = 'Skullfish Soup', lvl = 65, conj = false, mp = 7200, spi = 20, splcritstrkrtng = 20},
	[30361] = {id = 30361, name = "Oronok's Tuber of Spell Power", lvl = 65, conj = false, hp = 7500, spi = 20, spldmg = 23},
	[27651] = {id = 27651, name = 'Buzzard Bites', lvl = 55, conj = false, hp = 4320, spi = 20, stam = 20},
	[22018] = {id = 22018, name = 'Conjured Glacier Water', lvl = 65, conj = true, mp = 7200},
	[33048] = {id = 33048, name = 'Stewed Trout', lvl = 65, conj = false, hp = 7500},
	[27663] = {id = 27663, name = 'Blackened Sporefish', lvl = 55, conj = false, hp = 4320, manargn = 8, stam = 20},
	[30357] = {id = 30357, name = "Oronok's Tuber of Healing", lvl = 65, conj = false, hp = 7500, spi = 20, splheal = 44},
	[33867] = {id = 33867, name = 'Broiled Bloodfin', lvl = 55, conj = false, hp = 4320, arcres = 8, firres = 8, frores = 8, holres = 8, natres = 8, shares = 8},
	[30155] = {id = 30155, name = 'Clam Bar', lvl = 55, conj = false, hp = 4320, spi = 20, stam = 20},
	[30703] = {id = 30703, name = 'Conjured Mountain Spring Water', lvl = 60, conj = true, mp = 5100},
	[27661] = {id = 27661, name = 'Blackened Trout', lvl = 55, conj = false, hp = 4320},
	[33042] = {id = 33042, name = 'Black Coffee', lvl = 65, conj = false, mp = 7200},
	[27662] = {id = 27662, name = 'Feltail Delight', lvl = 55, conj = false, hp = 4320, spi = 20, stam = 20},
	[27660] = {id = 27660, name = 'Talbuk Steak', lvl = 55, conj = false, hp = 7500, spi = 20, stam = 20},
	[29292] = {id = 29292, name = 'Helboar Bacon', lvl = 55, conj = false, hp = 2148, str = 20},
	[29453] = {id = 29453, name = 'Sporeggar Mushroom', lvl = 65, conj = false, hp = 7500},
	[30358] = {id = 30358, name = "Oronok's Tuber of Agility", lvl = 65, conj = false, hp = 7500, agi = 20, spi = 20},
	[29449] = {id = 29449, name = 'Bladespire Bagel', lvl = 65, conj = false, hp = 7500},
	[32455] = {id = 32455, name = "Star's Lament", lvl = 55, conj = false, mp = 4200},
	[27856] = {id = 27856, name = 'Skethyl Berries', lvl = 55, conj = false, hp = 4320},
	[27859] = {id = 27859, name = 'Zangar Caps', lvl = 55, conj = false, hp = 4320},
	[32722] = {id = 32722, name = 'Enriched Terocone Juice', lvl = 65, conj = false, hp = 4320, mp = 5100},
	[30458] = {id = 30458, name = 'Stromgarde Muenster', lvl = 55, conj = false, hp = 4320},
	[32721] = {id = 32721, name = 'Skyguard Rations', lvl = 55, conj = false, hp = 6000, spi = 15, stam = 15},
	[29448] = {id = 29448, name = "Mag'har Mild Cheese", lvl = 65, conj = false, hp = 7500},
	[29454] = {id = 29454, name = 'Silverwine', lvl = 55, conj = false, mp = 5100},
	[29450] = {id = 29450, name = 'Telaari Grapes', lvl = 65, conj = false, hp = 7500},
	[34411] = {id = 34411, name = 'Hot Apple Cider', lvl = 65, conj = false, mp = 7200, manargn = 1200, spi = 20, stam = 20},
	[29395] = {id = 29395, name = 'Ethermead', lvl = 65, conj = false, mp = 7200},
	[30610] = {id = 30610, name = 'Smoked Black Bear Meat', lvl = 55, conj = false, hp = 4320},
	[24338] = {id = 24338, name = 'Hellfire Spineleaf', lvl = 55, conj = false, hp = 2148},
	[27857] = {id = 27857, name = 'Garadar Sharp', lvl = 55, conj = false, hp = 4320},
	[30359] = {id = 30359, name = "Oronok's Tuber of Strength", lvl = 65, conj = false, hp = 7500, spi = 20, str = 20},
	[30457] = {id = 30457, name = 'Gilneas Sparkling Water', lvl = 65, conj = false, mp = 7200},
	[22019] = {id = 22019, name = 'Conjured Croissant', lvl = 65, conj = true, hp = 7500},
	[29452] = {id = 29452, name = 'Zangar Trout', lvl = 65, conj = false, hp = 7500},
	[27855] = {id = 27855, name = "Mag'har Grainbread", lvl = 55, conj = false, hp = 4320},
	[34780] = {id = 34780, name = 'Naaru Ration', lvl = 65, conj = false, hp = 7500, mp = 7200},
	[35710] = {id = 35710, name = 'Delicious Baked Ham', lvl = 65, conj = false, hp = 7800},
	[32686] = {id = 32686, name = "Mingo's Fortune Giblets", lvl = 65, conj = false, hp = 7500},
	[38430] = {id = 38430, name = 'Blackrock Mineral Water', lvl = 60, conj = false, hp = 5100},
	[24009] = {id = 24009, name = 'Dried Fruit Rations', lvl = 55, conj = false, hp = 4320},
	[29393] = {id = 29393, name = 'Diamond Berries', lvl = 55, conj = false, hp = 4320},
	[24008] = {id = 24008, name = 'Dried Mushroom Rations', lvl = 55, conj = false, hp = 4320},
	[38428] = {id = 38428, name = 'Rock-Salted Pretzel', lvl = 65, conj = false, hp = 7500},
	[24539] = {id = 24539, name = 'Marsh Lichen', lvl = 55, conj = false, hp = 4320, spi = 10},
	[30355] = {id = 30355, name = 'Grilled Shadowmoon Tuber', lvl = 65, conj = false, hp = 7500},
	[38431] = {id = 38431, name = 'Blackrock Fortified Water', lvl = 65, conj = false, mp = 7200},
	[38427] = {id = 38427, name = 'Pickled Egg', lvl = 55, conj = false, hp = 4320},
	[20031] = {id = 20031, name = 'Essence Mango', lvl = 55, conj = false, hp = 4320, mp = 4410},
	[29401] = {id = 29401, name = 'Sparkling Southshore Cider', lvl = 65, conj = false, mp = 7200},
	[32668] = {id = 32668, name = 'Dos Ogris', lvl = 65, conj = false, mp = 7200},
	[32685] = {id = 32685, name = "Ogri'la Chicken Fingers", lvl = 65, conj = false, hp = 7500},
	[29394] = {id = 29394, name = 'Lyribread', lvl = 65, conj = false, hp = 7500},
	[29412] = {id = 29412, name = "Jessen's Special Slop", lvl = 55, conj = false, hp = 4320},
	[28486] = {id = 28486, name = "Moser's Magnificent Muffin", lvl = 55, conj = false, hp = 4320},
	[28501] = {id = 28501, name = 'Ravager Egg Omelet', lvl = 55, conj = false, hp = 4320},
	[29293] = {id = 29293, name = 'Bonestripper Buzzard Hotwings', lvl = 55, conj = false, hp = 2148, spi = 14, stam = 14},
	[33452] = {id = 33452, name = 'Honey-Spiced Lichen', lvl = 65, conj = false, hp = 18480},
	[33444] = {id = 33444, name = 'Pungent Seal Whey', lvl = 65, conj = false, mp = 12840}
}
NeedsFoodBadly.Potion = {
	[31677] = {id = 31677, name = 'Fel Mana Potion', lvl = 60, low = 3200, high = 3200, mp = true},
	[22829] = {id = 22829, name = 'Super Healing Potion', lvl = 55, low = 1500, high = 2500, hp = true},
	[33934] = {id = 33934, name = 'Crystal Healing Potion', lvl = 55, low = 1500, high = 2500, hp = true},
	[32947] = {id = 32947, name = 'Auchenai Healing Potion', lvl = 55, low = 1500, high = 2500, hp = true},
	[33092] = {id = 33092, name = 'Healing Potion Injector', lvl = 55, low = 1500, high = 2500, hp = true},
	[32904] = {id = 32904, name = 'Cenarion Healing Salve', lvl = 55, low = 1500, high = 2500, hp = true},
	[22832] = {id = 22832, name = 'Super Mana Potion', lvl = 55, low = 1800, high = 3000, mp = true},
	[33935] = {id = 33935, name = 'Crystal Mana Potion', lvl = 55, low = 1800, high = 3000, mp = true},
	[32948] = {id = 32948, name = 'Auchenai Mana Potion', lvl = 55, low = 1800, high = 3000, mp = true},
	[33093] = {id = 33093, name = 'Mana Potion Injector', lvl = 55, low = 1800, high = 3000, mp = true},
	[32903] = {id = 32903, name = 'Cenarion Mana Salve', lvl = 55, low = 1800, high = 3000, mp = true},
	[13446] = {id = 13446, name = 'Major Healing Potion', lvl = 45, low = 1050, high = 1750, hp = true},
	[28100] = {id = 28100, name = 'Volatile Healing Potion', lvl = 55, low = 1050, high = 1750, hp = true},
	[13444] = {id = 13444, name = 'Major Mana Potion', lvl = 49, low = 1350, high = 2250, mp = true},
	[28101] = {id = 28101, name = 'Unstable Mana Potion', lvl = 55, low = 1350, high = 2250, mp = true},
	[929] = {id = 929, name = 'Healing Potion', lvl = 12, low = 280, high = 360, hp = true},
	[6149] = {id = 6149, name = 'Greater Mana Potion', lvl = 31, low = 700, high = 900, mp = true},
	[1710] = {id = 1710, name = 'Greater Healing Potion', lvl = 21, low = 455, high = 585, hp = true},
	[13443] = {id = 13443, name = 'Superior Mana Potion', lvl = 41, low = 900, high = 1500, mp = true},
	[3928] = {id = 3928, name = 'Superior Healing Potion', lvl = 35, low = 700, high = 900, hp = true},
	[3827] = {id = 3827, name = 'Mana Potion', lvl = 22, low = 455, high = 585, mp = true},
	[858] = {id = 858, name = 'Lesser Healing Potion', lvl = 3, low = 140, high = 180, hp = true},
	[3385] = {id = 3385, name = 'Lesser Mana Potion', lvl = 14, low = 280, high = 360, mp = true},
	[118] = {id = 118, name = 'Minor Healing Potion', lvl = 0, low = 70, high = 90, hp = true},
	[2455] = {id = 2455, name = 'Minor Mana Potion', lvl = 5, low = 140, high = 180, mp = true},
	[18253] = {id = 18253, name = 'Major Rejuvenation Potion', lvl = 50, low = 1440, high = 1760, hp = true, mp = true},
	[9144] = {id = 9144, name = 'Wildvine Potion', lvl = 35, low = 1, high = 1500, hp = true, mp = true},
	[2456] = {id = 2456, name = 'Minor Rejuvenation Potion', lvl = 5, low = 90, high = 150, hp = true, mp = true},
	[4596] = {id = 4596, name = 'Discolored Healing Potion', lvl = 5, low = 140, high = 180, hp = true},
	[18839] = {id = 18839, name = 'Combat Healing Potion', lvl = 35, low = 700, high = 900, hp = true},
	[18841] = {id = 18841, name = 'Combat Mana Potion', lvl = 41, low = 900, high = 1500, mp = true},
	[3087] = {id = 3087, name = 'Mug of Shimmer Stout', lvl = 0, low = 140, high = 180, mp = true},
	[17351] = {id = 17351, name = 'Major Mana Draught', lvl = 45, low = 980, high = 1260, mp = true, bg = true},
	[17348] = {id = 17348, name = 'Major Healing Draught', lvl = 45, low = 980, high = 1260, hp = true, bg = true},
	[17349] = {id = 17349, name = 'Superior Healing Draught', lvl = 35, low = 560, high = 720, hp = true, bg = true},
	[17352] = {id = 17352, name = 'Superior Mana Draught', lvl = 35, low = 560, high = 720, mp = true, bg = true}
}
NeedsFoodBadly.Healthstone = {
	[19004] = {id = 19004, name = 'Minor Healthstone', lvl = 10, hp = 110},
	[19005] = {id = 19005, name = 'Minor Healthstone', lvl = 10, hp = 120},
	[19006] = {id = 19006, name = 'Lesser Healthstone', lvl = 22, hp = 275},
	[19007] = {id = 19007, name = 'Lesser Healthstone', lvl = 22, hp = 300},
	[19008] = {id = 19008, name = 'Healthstone', lvl = 34, hp = 550},
	[19009] = {id = 19009, name = 'Healthstone', lvl = 34, hp = 600},
	[19010] = {id = 19010, name = 'Greater Healthstone', lvl = 46, hp = 880},
	[19011] = {id = 19011, name = 'Greater Healthstone', lvl = 46, hp = 960},
	[19012] = {id = 19012, name = 'Major Healthstone', lvl = 48, hp = 1320},
	[5509] = {id = 5509, name = 'Healthstone', lvl = 34, hp = 500},
	[19013] = {id = 19013, name = 'Major Healthstone', lvl = 48, hp = 1440},
	[5510] = {id = 5510, name = 'Greater Healthstone', lvl = 46, hp = 800},
	[5511] = {id = 5511, name = 'Lesser Healthstone', lvl = 22, hp = 250},
	[5512] = {id = 5512, name = 'Minor Healthstone', lvl = 10, hp = 100},
	[9421] = {id = 9421, name = 'Major Healthstone', lvl = 48, hp = 1200},
	[22103] = {id = 22103, name = 'Master Healthstone', lvl = 60, hp = 2080},
	[22104] = {id = 22104, name = 'Master Healthstone', lvl = 60, hp = 2288},
	[22105] = {id = 22105, name = 'Master Healthstone', lvl = 60, hp = 2496}
}
NeedsFoodBadly.ManaGem = {
	[5514] = {id = 5514, name = 'Mana Agate', lvl = 1, low = 375, high = 425},
	[5513] = {id = 5513, name = 'Mana Jade', lvl = 38, low = 550, high = 650},
	[8007] = {id = 8007, name = 'Mana Citrine', lvl = 48, low = 775, high = 925},
	[8008] = {id = 8008, name = 'Mana Ruby', lvl = 58, low = 1000, high = 1200},
	[22044] = {id = 22044, name = 'Mana Emerald', lvl = 68, low = 2340, high = 2460}
}
NeedsFoodBadly.Bandage = {
	[21991] = {id = 21991, name = 'Heavy Netherweave Bandage', skill = 325, hp = 3400},
	[21990] = {id = 21990, name = 'Netherweave Bandage', skill = 300, hp = 2800},
	[8545] = {id = 8545, name = 'Heavy Mageweave Bandage', skill = 175, hp = 1104},
	[14529] = {id = 14529, name = 'Runecloth Bandage', skill = 200, hp = 1360},
	[14530] = {id = 14530, name = 'Heavy Runecloth Bandage', skill = 225, hp = 2000},
	[6450] = {id = 6450, name = 'Silk Bandage', skill = 100, hp = 400},
	[6451] = {id = 6451, name = 'Heavy Silk Bandage', skill = 125, hp = 640},
	[8544] = {id = 8544, name = 'Mageweave Bandage', skill = 150, hp = 800},
	[3530] = {id = 3530, name = 'Wool Bandage', skill = 50, hp = 161},
	[3531] = {id = 3531, name = 'Heavy Wool Bandage', skill = 75, hp = 301},
	[2581] = {id = 2581, name = 'Heavy Linen Bandage', skill = 20, hp = 114},
	[1251] = {id = 1251, name = 'Linen Bandage', skill = 1, hp = 66},
	[19307] = {id = 19307, name = 'Alterac Heavy Runecloth Bandage', skill = 225, hp = 2000},
	[23684] = {id = 23684, name = 'Crystal Infused Bandage', skill = 225, hp = 2500},
	[19068] = {id = 19068, name = 'Warsong Gulch Silk Bandage', lvl = 25, skill = 125, hp = 640, bg = 2},
	[19067] = {id = 19067, name = 'Warsong Gulch Mageweave Bandage', lvl = 35, skill = 175, hp = 1104, bg = 2},
	[19066] = {id = 19066, name = 'Warsong Gulch Runecloth Bandage', lvl = 45, skill = 225, hp = 2000, bg = 2},
	[20067] = {id = 20067, name = 'Arathi Basin Silk Bandage', lvl = 25, skill = 125, hp = 640, bg = 3},
	[20235] = {id = 20235, name = "Defiler's Silk Bandage", lvl = 25, skill = 125, hp = 640, bg = 3},
	[20244] = {id = 20244, name = "Highlander's Silk Bandage", lvl = 25, skill = 125, hp = 640, bg = 3},
	[20065] = {id = 20065, name = 'Arathi Basin Mageweave Bandage', lvl = 35, skill = 175, hp = 1104, bg = 3},
	[20232] = {id = 20232, name = "Defiler's Mageweave Bandage", lvl = 35, skill = 175, hp = 1104, bg = 3},
	[20237] = {id = 20237, name = "Highlander's Mageweave Bandage", lvl = 35, skill = 175, hp = 1104, bg = 3},
	[20066] = {id = 20066, name = 'Arathi Basin Runecloth Bandage', lvl = 45, skill = 225, hp = 2000, bg = 3},
	[20234] = {id = 20234, name = "Defiler's Runecloth Bandage", lvl = 45, skill = 225, hp = 2000, bg = 3},
	[20243] = {id = 20243, name = "Highlander's Runecloth Bandage", lvl = 45, skill = 225, hp = 2000, bg = 3}
}
NeedsFoodBadly.PetFood = {
	[117] = {id = 117, type = 'Meat'},
	[2287] = {id = 2287, type = 'Meat'},
	[2679] = {id = 2679, type = 'Meat'},
	[2681] = {id = 2681, type = 'Meat'},
	[2685] = {id = 2685, type = 'Meat'},
	[3770] = {id = 3770, type = 'Meat'},
	[3771] = {id = 3771, type = 'Meat'},
	[4599] = {id = 4599, type = 'Meat'},
	[5478] = {id = 5478, type = 'Meat'},
	[6890] = {id = 6890, type = 'Meat'},
	[7097] = {id = 7097, type = 'Meat'},
	[8952] = {id = 8952, type = 'Meat'},
	[9681] = {id = 9681, type = 'Meat'},
	[9681] = {id = 9681, type = 'Meat'},
	[11444] = {id = 11444, type = 'Meat'},
	[11444] = {id = 11444, type = 'Meat'},
	[17119] = {id = 17119, type = 'Meat'},
	[17407] = {id = 17407, type = 'Meat'},
	[19223] = {id = 19223, type = 'Meat'},
	[19224] = {id = 19224, type = 'Meat'},
	[19304] = {id = 19304, type = 'Meat'},
	[19305] = {id = 19305, type = 'Meat'},
	[19306] = {id = 19306, type = 'Meat'},
	[19995] = {id = 19995, type = 'Meat'},
	[21235] = {id = 21235, type = 'Meat'},
	[23495] = {id = 23495, type = 'Meat'},
	[27854] = {id = 27854, type = 'Meat'},
	[29451] = {id = 29451, type = 'Meat'},
	[30610] = {id = 30610, type = 'Meat'},
	[32685] = {id = 32685, type = 'Meat'},
	[32686] = {id = 32686, type = 'Meat'},
	[33254] = {id = 33254, type = 'Meat'},
	[33454] = {id = 33454, type = 'Meat'},
	[34747] = {id = 34747, type = 'Meat'},
	[35953] = {id = 35953, type = 'Meat'},
	[38427] = {id = 38427, type = 'Meat'},
	[38428] = {id = 38428, type = 'Meat'},
	[40202] = {id = 40202, type = 'Meat'},
	[40358] = {id = 40358, type = 'Meat'},
	[40359] = {id = 40359, type = 'Meat'},
	[41729] = {id = 41729, type = 'Meat'},
	[44072] = {id = 44072, type = 'Meat'},
	[57544] = {id = 57544, type = 'Meat'},
	[58268] = {id = 58268, type = 'Meat'},
	[58269] = {id = 58269, type = 'Meat'},
	[58280] = {id = 58280, type = 'Meat'},
	[59231] = {id = 59231, type = 'Meat'},
	[59232] = {id = 59232, type = 'Meat'},
	[60268] = {id = 60268, type = 'Meat'},
	[60377] = {id = 60377, type = 'Meat'},
	[62653] = {id = 62653, type = 'Meat'},
	[62658] = {id = 62658, type = 'Meat'},
	[62662] = {id = 62662, type = 'Meat'},
	[62664] = {id = 62664, type = 'Meat'},
	[62665] = {id = 62665, type = 'Meat'},
	[62670] = {id = 62670, type = 'Meat'},
	[62676] = {id = 62676, type = 'Meat'},
	[62909] = {id = 62909, type = 'Meat'},
	[62910] = {id = 62910, type = 'Meat'},
	[65730] = {id = 65730, type = 'Meat'},
	[65731] = {id = 65731, type = 'Meat'},
	[67230] = {id = 67230, type = 'Meat'},
	[67270] = {id = 67270, type = 'Meat'},
	[67271] = {id = 67271, type = 'Meat'},
	[67272] = {id = 67272, type = 'Meat'},
	[67273] = {id = 67273, type = 'Meat'},
	[74642] = {id = 74642, type = 'Meat'},
	[74646] = {id = 74646, type = 'Meat'},
	[74647] = {id = 74647, type = 'Meat'},
	[74648] = {id = 74648, type = 'Meat'},
	[74649] = {id = 74649, type = 'Meat'},
	[74650] = {id = 74650, type = 'Meat'},
	[74653] = {id = 74653, type = 'Meat'},
	[74654] = {id = 74654, type = 'Meat'},
	[74656] = {id = 74656, type = 'Meat'},
	[81917] = {id = 81917, type = 'Meat'},
	[81918] = {id = 81918, type = 'Meat'},
	[83097] = {id = 83097, type = 'Meat'},
	[85501] = {id = 85501, type = 'Meat'},
	[86070] = {id = 86070, type = 'Meat'},
	[90135] = {id = 90135, type = 'Meat'},
	[1017] = {id = 1017, type = 'Meat'},
	[2680] = {id = 2680, type = 'Meat'},
	[2684] = {id = 2684, type = 'Meat'},
	[2687] = {id = 2687, type = 'Meat'},
	[2888] = {id = 2888, type = 'Meat'},
	[3220] = {id = 3220, type = 'Meat'},
	[3662] = {id = 3662, type = 'Meat'},
	[3726] = {id = 3726, type = 'Meat'},
	[3727] = {id = 3727, type = 'Meat'},
	[3728] = {id = 3728, type = 'Meat'},
	[3729] = {id = 3729, type = 'Meat'},
	[4457] = {id = 4457, type = 'Meat'},
	[5472] = {id = 5472, type = 'Meat'},
	[5474] = {id = 5474, type = 'Meat'},
	[5477] = {id = 5477, type = 'Meat'},
	[5479] = {id = 5479, type = 'Meat'},
	[5480] = {id = 5480, type = 'Meat'},
	[12209] = {id = 12209, type = 'Meat'},
	[12210] = {id = 12210, type = 'Meat'},
	[12213] = {id = 12213, type = 'Meat'},
	[12224] = {id = 12224, type = 'Meat'},
	[13851] = {id = 13851, type = 'Meat'},
	[17222] = {id = 17222, type = 'Meat'},
	[18045] = {id = 18045, type = 'Meat'},
	[20074] = {id = 20074, type = 'Meat'},
	[21023] = {id = 21023, type = 'Meat'},
	[24105] = {id = 24105, type = 'Meat'},
	[27635] = {id = 27635, type = 'Meat'},
	[27636] = {id = 27636, type = 'Meat'},
	[27651] = {id = 27651, type = 'Meat'},
	[27655] = {id = 27655, type = 'Meat'},
	[27657] = {id = 27657, type = 'Meat'},
	[27658] = {id = 27658, type = 'Meat'},
	[27659] = {id = 27659, type = 'Meat'},
	[27660] = {id = 27660, type = 'Meat'},
	[29292] = {id = 29292, type = 'Meat'},
	[31672] = {id = 31672, type = 'Meat'},
	[31673] = {id = 31673, type = 'Meat'},
	[33872] = {id = 33872, type = 'Meat'},
	[34125] = {id = 34125, type = 'Meat'},
	[34410] = {id = 34410, type = 'Meat'},
	[34748] = {id = 34748, type = 'Meat'},
	[34749] = {id = 34749, type = 'Meat'},
	[34750] = {id = 34750, type = 'Meat'},
	[34751] = {id = 34751, type = 'Meat'},
	[34752] = {id = 34752, type = 'Meat'},
	[34754] = {id = 34754, type = 'Meat'},
	[34755] = {id = 34755, type = 'Meat'},
	[34756] = {id = 34756, type = 'Meat'},
	[34757] = {id = 34757, type = 'Meat'},
	[34758] = {id = 34758, type = 'Meat'},
	[35563] = {id = 35563, type = 'Meat'},
	[35565] = {id = 35565, type = 'Meat'},
	[42779] = {id = 42779, type = 'Meat'},
	[42994] = {id = 42994, type = 'Meat'},
	[42995] = {id = 42995, type = 'Meat'},
	[42997] = {id = 42997, type = 'Meat'},
	[43001] = {id = 43001, type = 'Meat'},
	[43488] = {id = 43488, type = 'Meat'},
	[46392] = {id = 46392, type = 'Meat'},
	[57519] = {id = 57519, type = 'Meat'},
	[62653] = {id = 62653, type = 'Meat'},
	[62658] = {id = 62658, type = 'Meat'},
	[62662] = {id = 62662, type = 'Meat'},
	[62664] = {id = 62664, type = 'Meat'},
	[62665] = {id = 62665, type = 'Meat'},
	[62670] = {id = 62670, type = 'Meat'},
	[64641] = {id = 64641, type = 'Meat'},
	[74642] = {id = 74642, type = 'Meat'},
	[74646] = {id = 74646, type = 'Meat'},
	[74647] = {id = 74647, type = 'Meat'},
	[74648] = {id = 74648, type = 'Meat'},
	[74649] = {id = 74649, type = 'Meat'},
	[74650] = {id = 74650, type = 'Meat'},
	[74653] = {id = 74653, type = 'Meat'},
	[74654] = {id = 74654, type = 'Meat'},
	[74656] = {id = 74656, type = 'Meat'},
	[81405] = {id = 81405, type = 'Meat'},
	[81413] = {id = 81413, type = 'Meat'},
	[86070] = {id = 86070, type = 'Meat'},
	[723] = {id = 723, type = 'Meat'},
	[729] = {id = 729, type = 'Meat'},
	[769] = {id = 769, type = 'Meat'},
	[1015] = {id = 1015, type = 'Meat'},
	[1080] = {id = 1080, type = 'Meat'},
	[1081] = {id = 1081, type = 'Meat'},
	[2672] = {id = 2672, type = 'Meat'},
	[2673] = {id = 2673, type = 'Meat'},
	[2677] = {id = 2677, type = 'Meat'},
	[2886] = {id = 2886, type = 'Meat'},
	[2924] = {id = 2924, type = 'Meat'},
	[3173] = {id = 3173, type = 'Meat'},
	[3404] = {id = 3404, type = 'Meat'},
	[3667] = {id = 3667, type = 'Meat'},
	[3712] = {id = 3712, type = 'Meat'},
	[3730] = {id = 3730, type = 'Meat'},
	[3731] = {id = 3731, type = 'Meat'},
	[4739] = {id = 4739, type = 'Meat'},
	[5051] = {id = 5051, type = 'Meat'},
	[5465] = {id = 5465, type = 'Meat'},
	[5467] = {id = 5467, type = 'Meat'},
	[5469] = {id = 5469, type = 'Meat'},
	[5470] = {id = 5470, type = 'Meat'},
	[5471] = {id = 5471, type = 'Meat'},
	[12037] = {id = 12037, type = 'Meat'},
	[12184] = {id = 12184, type = 'Meat'},
	[12202] = {id = 12202, type = 'Meat'},
	[12203] = {id = 12203, type = 'Meat'},
	[12204] = {id = 12204, type = 'Meat'},
	[12205] = {id = 12205, type = 'Meat'},
	[12208] = {id = 12208, type = 'Meat'},
	[12223] = {id = 12223, type = 'Meat'},
	[20424] = {id = 20424, type = 'Meat'},
	[21024] = {id = 21024, type = 'Meat'},
	[22644] = {id = 22644, type = 'Meat'},
	[23676] = {id = 23676, type = 'Meat'},
	[27668] = {id = 27668, type = 'Meat'},
	[27669] = {id = 27669, type = 'Meat'},
	[27671] = {id = 27671, type = 'Meat'},
	[27674] = {id = 27674, type = 'Meat'},
	[27677] = {id = 27677, type = 'Meat'},
	[27678] = {id = 27678, type = 'Meat'},
	[27681] = {id = 27681, type = 'Meat'},
	[27682] = {id = 27682, type = 'Meat'},
	[31670] = {id = 31670, type = 'Meat'},
	[31671] = {id = 31671, type = 'Meat'},
	[33120] = {id = 33120, type = 'Meat'},
	[34736] = {id = 34736, type = 'Meat'},
	[35562] = {id = 35562, type = 'Meat'},
	[35794] = {id = 35794, type = 'Meat'},
	[43009] = {id = 43009, type = 'Meat'},
	[43010] = {id = 43010, type = 'Meat'},
	[43011] = {id = 43011, type = 'Meat'},
	[43012] = {id = 43012, type = 'Meat'},
	[43013] = {id = 43013, type = 'Meat'},
	[62778] = {id = 62778, type = 'Meat'},
	[62779] = {id = 62779, type = 'Meat'},
	[62780] = {id = 62780, type = 'Meat'},
	[62781] = {id = 62781, type = 'Meat'},
	[62782] = {id = 62782, type = 'Meat'},
	[62783] = {id = 62783, type = 'Meat'},
	[62784] = {id = 62784, type = 'Meat'},
	[62785] = {id = 62785, type = 'Meat'},
	[67229] = {id = 67229, type = 'Meat'},
	[74833] = {id = 74833, type = 'Meat'},
	[74834] = {id = 74834, type = 'Meat'},
	[74837] = {id = 74837, type = 'Meat'},
	[74838] = {id = 74838, type = 'Meat'},
	[74839] = {id = 74839, type = 'Meat'},
	[75014] = {id = 75014, type = 'Meat'},
	[85506] = {id = 85506, type = 'Meat'},
	[787] = {id = 787, type = 'Fish'},
	[1326] = {id = 1326, type = 'Fish'},
	[2682] = {id = 2682, type = 'Fish'},
	[2682] = {id = 2682, type = 'Fish'},
	[4592] = {id = 4592, type = 'Fish'},
	[4593] = {id = 4593, type = 'Fish'},
	[4594] = {id = 4594, type = 'Fish'},
	[5095] = {id = 5095, type = 'Fish'},
	[6290] = {id = 6290, type = 'Fish'},
	[6316] = {id = 6316, type = 'Fish'},
	[6887] = {id = 6887, type = 'Fish'},
	[8364] = {id = 8364, type = 'Fish'},
	[8957] = {id = 8957, type = 'Fish'},
	[8959] = {id = 8959, type = 'Fish'},
	[12238] = {id = 12238, type = 'Fish'},
	[13546] = {id = 13546, type = 'Fish'},
	[13930] = {id = 13930, type = 'Fish'},
	[13933] = {id = 13933, type = 'Fish'},
	[13935] = {id = 13935, type = 'Fish'},
	[16766] = {id = 16766, type = 'Fish'},
	[19996] = {id = 19996, type = 'Fish'},
	[21071] = {id = 21071, type = 'Fish'},
	[21153] = {id = 21153, type = 'Fish'},
	[21552] = {id = 21552, type = 'Fish'},
	[27661] = {id = 27661, type = 'Fish'},
	[27858] = {id = 27858, type = 'Fish'},
	[29452] = {id = 29452, type = 'Fish'},
	[33004] = {id = 33004, type = 'Fish'},
	[33048] = {id = 33048, type = 'Fish'},
	[33053] = {id = 33053, type = 'Fish'},
	[33451] = {id = 33451, type = 'Fish'},
	[34759] = {id = 34759, type = 'Fish'},
	[34760] = {id = 34760, type = 'Fish'},
	[34761] = {id = 34761, type = 'Fish'},
	[35285] = {id = 35285, type = 'Fish'},
	[35951] = {id = 35951, type = 'Fish'},
	[43571] = {id = 43571, type = 'Fish'},
	[43646] = {id = 43646, type = 'Fish'},
	[43647] = {id = 43647, type = 'Fish'},
	[44049] = {id = 44049, type = 'Fish'},
	[44071] = {id = 44071, type = 'Fish'},
	[45932] = {id = 45932, type = 'Fish'},
	[56165] = {id = 56165, type = 'Fish'},
	[58262] = {id = 58262, type = 'Fish'},
	[58263] = {id = 58263, type = 'Fish'},
	[58277] = {id = 58277, type = 'Fish'},
	[62651] = {id = 62651, type = 'Fish'},
	[62652] = {id = 62652, type = 'Fish'},
	[62654] = {id = 62654, type = 'Fish'},
	[62655] = {id = 62655, type = 'Fish'},
	[62656] = {id = 62656, type = 'Fish'},
	[62657] = {id = 62657, type = 'Fish'},
	[62659] = {id = 62659, type = 'Fish'},
	[62660] = {id = 62660, type = 'Fish'},
	[62661] = {id = 62661, type = 'Fish'},
	[62663] = {id = 62663, type = 'Fish'},
	[62666] = {id = 62666, type = 'Fish'},
	[62667] = {id = 62667, type = 'Fish'},
	[62668] = {id = 62668, type = 'Fish'},
	[62669] = {id = 62669, type = 'Fish'},
	[62671] = {id = 62671, type = 'Fish'},
	[62677] = {id = 62677, type = 'Fish'},
	[68687] = {id = 68687, type = 'Fish'},
	[74636] = {id = 74636, type = 'Fish'},
	[74641] = {id = 74641, type = 'Fish'},
	[74644] = {id = 74644, type = 'Fish'},
	[74645] = {id = 74645, type = 'Fish'},
	[74651] = {id = 74651, type = 'Fish'},
	[74652] = {id = 74652, type = 'Fish'},
	[74655] = {id = 74655, type = 'Fish'},
	[82448] = {id = 82448, type = 'Fish'},
	[82449] = {id = 82449, type = 'Fish'},
	[86073] = {id = 86073, type = 'Fish'},
	[5476] = {id = 5476, type = 'Fish'},
	[5527] = {id = 5527, type = 'Fish'},
	[6038] = {id = 6038, type = 'Fish'},
	[12216] = {id = 12216, type = 'Fish'},
	[13927] = {id = 13927, type = 'Fish'},
	[13928] = {id = 13928, type = 'Fish'},
	[13929] = {id = 13929, type = 'Fish'},
	[13932] = {id = 13932, type = 'Fish'},
	[13934] = {id = 13934, type = 'Fish'},
	[16971] = {id = 16971, type = 'Fish'},
	[21072] = {id = 21072, type = 'Fish'},
	[21217] = {id = 21217, type = 'Fish'},
	[27662] = {id = 27662, type = 'Fish'},
	[27663] = {id = 27663, type = 'Fish'},
	[27664] = {id = 27664, type = 'Fish'},
	[27665] = {id = 27665, type = 'Fish'},
	[27666] = {id = 27666, type = 'Fish'},
	[27667] = {id = 27667, type = 'Fish'},
	[30155] = {id = 30155, type = 'Fish'},
	[33052] = {id = 33052, type = 'Fish'},
	[33867] = {id = 33867, type = 'Fish'},
	[34762] = {id = 34762, type = 'Fish'},
	[34763] = {id = 34763, type = 'Fish'},
	[34764] = {id = 34764, type = 'Fish'},
	[34765] = {id = 34765, type = 'Fish'},
	[34766] = {id = 34766, type = 'Fish'},
	[34767] = {id = 34767, type = 'Fish'},
	[34768] = {id = 34768, type = 'Fish'},
	[34769] = {id = 34769, type = 'Fish'},
	[37452] = {id = 37452, type = 'Fish'},
	[39691] = {id = 39691, type = 'Fish'},
	[42942] = {id = 42942, type = 'Fish'},
	[42993] = {id = 42993, type = 'Fish'},
	[42996] = {id = 42996, type = 'Fish'},
	[42998] = {id = 42998, type = 'Fish'},
	[42999] = {id = 42999, type = 'Fish'},
	[43000] = {id = 43000, type = 'Fish'},
	[43268] = {id = 43268, type = 'Fish'},
	[43491] = {id = 43491, type = 'Fish'},
	[43492] = {id = 43492, type = 'Fish'},
	[43572] = {id = 43572, type = 'Fish'},
	[43652] = {id = 43652, type = 'Fish'},
	[62651] = {id = 62651, type = 'Fish'},
	[62652] = {id = 62652, type = 'Fish'},
	[62654] = {id = 62654, type = 'Fish'},
	[62655] = {id = 62655, type = 'Fish'},
	[62656] = {id = 62656, type = 'Fish'},
	[62657] = {id = 62657, type = 'Fish'},
	[62659] = {id = 62659, type = 'Fish'},
	[62660] = {id = 62660, type = 'Fish'},
	[62661] = {id = 62661, type = 'Fish'},
	[62663] = {id = 62663, type = 'Fish'},
	[62666] = {id = 62666, type = 'Fish'},
	[62667] = {id = 62667, type = 'Fish'},
	[62668] = {id = 62668, type = 'Fish'},
	[62669] = {id = 62669, type = 'Fish'},
	[62671] = {id = 62671, type = 'Fish'},
	[74609] = {id = 74609, type = 'Fish'},
	[74644] = {id = 74644, type = 'Fish'},
	[74645] = {id = 74645, type = 'Fish'},
	[74651] = {id = 74651, type = 'Fish'},
	[74652] = {id = 74652, type = 'Fish'},
	[74655] = {id = 74655, type = 'Fish'},
	[81175] = {id = 81175, type = 'Fish'},
	[81402] = {id = 81402, type = 'Fish'},
	[81410] = {id = 81410, type = 'Fish'},
	[85504] = {id = 85504, type = 'Fish'},
	[86073] = {id = 86073, type = 'Fish'},
	[2674] = {id = 2674, type = 'Fish'},
	[2675] = {id = 2675, type = 'Fish'},
	[4603] = {id = 4603, type = 'Fish'},
	[4655] = {id = 4655, type = 'Fish'},
	[5468] = {id = 5468, type = 'Fish'},
	[5503] = {id = 5503, type = 'Fish'},
	[5504] = {id = 5504, type = 'Fish'},
	[6289] = {id = 6289, type = 'Fish'},
	[6291] = {id = 6291, type = 'Fish'},
	[6303] = {id = 6303, type = 'Fish'},
	[6308] = {id = 6308, type = 'Fish'},
	[6317] = {id = 6317, type = 'Fish'},
	[6361] = {id = 6361, type = 'Fish'},
	[6362] = {id = 6362, type = 'Fish'},
	[7974] = {id = 7974, type = 'Fish'},
	[8365] = {id = 8365, type = 'Fish'},
	[12206] = {id = 12206, type = 'Fish'},
	[12207] = {id = 12207, type = 'Fish'},
	[13754] = {id = 13754, type = 'Fish'},
	[13755] = {id = 13755, type = 'Fish'},
	[13756] = {id = 13756, type = 'Fish'},
	[13758] = {id = 13758, type = 'Fish'},
	[13759] = {id = 13759, type = 'Fish'},
	[13760] = {id = 13760, type = 'Fish'},
	[13888] = {id = 13888, type = 'Fish'},
	[13889] = {id = 13889, type = 'Fish'},
	[13890] = {id = 13890, type = 'Fish'},
	[13893] = {id = 13893, type = 'Fish'},
	[15924] = {id = 15924, type = 'Fish'},
	[24477] = {id = 24477, type = 'Fish'},
	[27422] = {id = 27422, type = 'Fish'},
	[27425] = {id = 27425, type = 'Fish'},
	[27429] = {id = 27429, type = 'Fish'},
	[27435] = {id = 27435, type = 'Fish'},
	[27437] = {id = 27437, type = 'Fish'},
	[27438] = {id = 27438, type = 'Fish'},
	[27439] = {id = 27439, type = 'Fish'},
	[27515] = {id = 27515, type = 'Fish'},
	[27516] = {id = 27516, type = 'Fish'},
	[33823] = {id = 33823, type = 'Fish'},
	[33824] = {id = 33824, type = 'Fish'},
	[36782] = {id = 36782, type = 'Fish'},
	[40199] = {id = 40199, type = 'Fish'},
	[41800] = {id = 41800, type = 'Fish'},
	[41801] = {id = 41801, type = 'Fish'},
	[41802] = {id = 41802, type = 'Fish'},
	[41803] = {id = 41803, type = 'Fish'},
	[41805] = {id = 41805, type = 'Fish'},
	[41806] = {id = 41806, type = 'Fish'},
	[41807] = {id = 41807, type = 'Fish'},
	[41808] = {id = 41808, type = 'Fish'},
	[41809] = {id = 41809, type = 'Fish'},
	[41810] = {id = 41810, type = 'Fish'},
	[41812] = {id = 41812, type = 'Fish'},
	[41813] = {id = 41813, type = 'Fish'},
	[41814] = {id = 41814, type = 'Fish'},
	[53062] = {id = 53062, type = 'Fish'},
	[53063] = {id = 53063, type = 'Fish'},
	[53064] = {id = 53064, type = 'Fish'},
	[53066] = {id = 53066, type = 'Fish'},
	[53067] = {id = 53067, type = 'Fish'},
	[53068] = {id = 53068, type = 'Fish'},
	[53069] = {id = 53069, type = 'Fish'},
	[53070] = {id = 53070, type = 'Fish'},
	[53071] = {id = 53071, type = 'Fish'},
	[53072] = {id = 53072, type = 'Fish'},
	[62791] = {id = 62791, type = 'Fish'},
	[74856] = {id = 74856, type = 'Fish'},
	[74857] = {id = 74857, type = 'Fish'},
	[74859] = {id = 74859, type = 'Fish'},
	[74860] = {id = 74860, type = 'Fish'},
	[74861] = {id = 74861, type = 'Fish'},
	[74863] = {id = 74863, type = 'Fish'},
	[74865] = {id = 74865, type = 'Fish'},
	[74865] = {id = 74865, type = 'Fish'},
	[74866] = {id = 74866, type = 'Fish'},
	[34062] = {id = 34062, type = 'Bread'},
	[43518] = {id = 43518, type = 'Bread'},
	[43523] = {id = 43523, type = 'Bread'},
	[65499] = {id = 65499, type = 'Bread'},
	[65500] = {id = 65500, type = 'Bread'},
	[65515] = {id = 65515, type = 'Bread'},
	[65516] = {id = 65516, type = 'Bread'},
	[65517] = {id = 65517, type = 'Bread'},
	[70924] = {id = 70924, type = 'Bread'},
	[70925] = {id = 70925, type = 'Bread'},
	[70926] = {id = 70926, type = 'Bread'},
	[70927] = {id = 70927, type = 'Bread'},
	[4540] = {id = 4540, type = 'Bread'},
	[4541] = {id = 4541, type = 'Bread'},
	[4542] = {id = 4542, type = 'Bread'},
	[4544] = {id = 4544, type = 'Bread'},
	[4601] = {id = 4601, type = 'Bread'},
	[8950] = {id = 8950, type = 'Bread'},
	[13724] = {id = 13724, type = 'Bread'},
	[16169] = {id = 16169, type = 'Bread'},
	[19301] = {id = 19301, type = 'Bread'},
	[19696] = {id = 19696, type = 'Bread'},
	[20857] = {id = 20857, type = 'Bread'},
	[23160] = {id = 23160, type = 'Bread'},
	[24072] = {id = 24072, type = 'Bread'},
	[27855] = {id = 27855, type = 'Bread'},
	[28486] = {id = 28486, type = 'Bread'},
	[29394] = {id = 29394, type = 'Bread'},
	[29449] = {id = 29449, type = 'Bread'},
	[30816] = {id = 30816, type = 'Bread'},
	[33449] = {id = 33449, type = 'Bread'},
	[34780] = {id = 34780, type = 'Bread'},
	[35950] = {id = 35950, type = 'Bread'},
	[42428] = {id = 42428, type = 'Bread'},
	[42429] = {id = 42429, type = 'Bread'},
	[42430] = {id = 42430, type = 'Bread'},
	[42431] = {id = 42431, type = 'Bread'},
	[42432] = {id = 42432, type = 'Bread'},
	[42433] = {id = 42433, type = 'Bread'},
	[42434] = {id = 42434, type = 'Bread'},
	[42778] = {id = 42778, type = 'Bread'},
	[44609] = {id = 44609, type = 'Bread'},
	[58260] = {id = 58260, type = 'Bread'},
	[58261] = {id = 58261, type = 'Bread'},
	[81406] = {id = 81406, type = 'Bread'},
	[82450] = {id = 82450, type = 'Bread'},
	[82451] = {id = 82451, type = 'Bread'},
	[86026] = {id = 86026, type = 'Bread'},
	[86069] = {id = 86069, type = 'Bread'},
	[90457] = {id = 90457, type = 'Bread'},
	[2683] = {id = 2683, type = 'Bread'},
	[3666] = {id = 3666, type = 'Bread'},
	[17197] = {id = 17197, type = 'Bread'},
	[43490] = {id = 43490, type = 'Bread'},
	[33924] = {id = 33924, type = 'Bread'},
	[81400] = {id = 81400, type = 'Bread'},
	[81408] = {id = 81408, type = 'Bread'},
	[81406] = {id = 81406, type = 'Bread'},
	[86026] = {id = 86026, type = 'Bread'},
	[86069] = {id = 86069, type = 'Bread'},
	[90457] = {id = 90457, type = 'Bread'},
	[414] = {id = 414, type = 'Cheese'},
	[422] = {id = 422, type = 'Cheese'},
	[1707] = {id = 1707, type = 'Cheese'},
	[2070] = {id = 2070, type = 'Cheese'},
	[3927] = {id = 3927, type = 'Cheese'},
	[8932] = {id = 8932, type = 'Cheese'},
	[17406] = {id = 17406, type = 'Cheese'},
	[27857] = {id = 27857, type = 'Cheese'},
	[29448] = {id = 29448, type = 'Cheese'},
	[30458] = {id = 30458, type = 'Cheese'},
	[33443] = {id = 33443, type = 'Cheese'},
	[35952] = {id = 35952, type = 'Cheese'},
	[44607] = {id = 44607, type = 'Cheese'},
	[44608] = {id = 44608, type = 'Cheese'},
	[44749] = {id = 44749, type = 'Cheese'},
	[58258] = {id = 58258, type = 'Cheese'},
	[58259] = {id = 58259, type = 'Cheese'},
	[81414] = {id = 81414, type = 'Cheese'},
	[81921] = {id = 81921, type = 'Cheese'},
	[81922] = {id = 81922, type = 'Cheese'},
	[3665] = {id = 3665, type = 'Cheese'},
	[12218] = {id = 12218, type = 'Cheese'},
	[81401] = {id = 81401, type = 'Cheese'},
	[81414] = {id = 81414, type = 'Cheese'},
	[4536] = {id = 4536, type = 'Fruit'},
	[4537] = {id = 4537, type = 'Fruit'},
	[4538] = {id = 4538, type = 'Fruit'},
	[4539] = {id = 4539, type = 'Fruit'},
	[4602] = {id = 4602, type = 'Fruit'},
	[8953] = {id = 8953, type = 'Fruit'},
	[16168] = {id = 16168, type = 'Fruit'},
	[19994] = {id = 19994, type = 'Fruit'},
	[20031] = {id = 20031, type = 'Fruit'},
	[21030] = {id = 21030, type = 'Fruit'},
	[21031] = {id = 21031, type = 'Fruit'},
	[21033] = {id = 21033, type = 'Fruit'},
	[22324] = {id = 22324, type = 'Fruit'},
	[27856] = {id = 27856, type = 'Fruit'},
	[28112] = {id = 28112, type = 'Fruit'},
	[29393] = {id = 29393, type = 'Fruit'},
	[29450] = {id = 29450, type = 'Fruit'},
	[35948] = {id = 35948, type = 'Fruit'},
	[35949] = {id = 35949, type = 'Fruit'},
	[37252] = {id = 37252, type = 'Fruit'},
	[40356] = {id = 40356, type = 'Fruit'},
	[43087] = {id = 43087, type = 'Fruit'},
	[58264] = {id = 58264, type = 'Fruit'},
	[58265] = {id = 58265, type = 'Fruit'},
	[58278] = {id = 58278, type = 'Fruit'},
	[60267] = {id = 60267, type = 'Fruit'},
	[74643] = {id = 74643, type = 'Fruit'},
	[75026] = {id = 75026, type = 'Fruit'},
	[79320] = {id = 79320, type = 'Fruit'},
	[81919] = {id = 81919, type = 'Fruit'},
	[81920] = {id = 81920, type = 'Fruit'},
	[86057] = {id = 86057, type = 'Fruit'},
	[86074] = {id = 86074, type = 'Fruit'},
	[11950] = {id = 11950, type = 'Fruit'},
	[13810] = {id = 13810, type = 'Fruit'},
	[20516] = {id = 20516, type = 'Fruit'},
	[24009] = {id = 24009, type = 'Fruit'},
	[32721] = {id = 32721, type = 'Fruit'},
	[74643] = {id = 74643, type = 'Fruit'},
	[79320] = {id = 79320, type = 'Fruit'},
	[81403] = {id = 81403, type = 'Fruit'},
	[81411] = {id = 81411, type = 'Fruit'},
	[86074] = {id = 86074, type = 'Fruit'},
	[74840] = {id = 74840, type = 'Fruit'},
	[74841] = {id = 74841, type = 'Fruit'},
	[74842] = {id = 74842, type = 'Fruit'},
	[74843] = {id = 74843, type = 'Fruit'},
	[74844] = {id = 74844, type = 'Fruit'},
	[74846] = {id = 74846, type = 'Fruit'},
	[74847] = {id = 74847, type = 'Fruit'},
	[74848] = {id = 74848, type = 'Fruit'},
	[74849] = {id = 74849, type = 'Fruit'},
	[74850] = {id = 74850, type = 'Fruit'},
	[3448] = {id = 3448, type = 'Fungus'},
	[4604] = {id = 4604, type = 'Fungus'},
	[4605] = {id = 4605, type = 'Fungus'},
	[4606] = {id = 4606, type = 'Fungus'},
	[4607] = {id = 4607, type = 'Fungus'},
	[4608] = {id = 4608, type = 'Fungus'},
	[8948] = {id = 8948, type = 'Fungus'},
	[27859] = {id = 27859, type = 'Fungus'},
	[29453] = {id = 29453, type = 'Fungus'},
	[30355] = {id = 30355, type = 'Fungus'},
	[33452] = {id = 33452, type = 'Fungus'},
	[35947] = {id = 35947, type = 'Fungus'},
	[41751] = {id = 41751, type = 'Fungus'},
	[58266] = {id = 58266, type = 'Fungus'},
	[58267] = {id = 58267, type = 'Fungus'},
	[58279] = {id = 58279, type = 'Fungus'},
	[59228] = {id = 59228, type = 'Fungus'},
	[81889] = {id = 81889, type = 'Fungus'},
	[81916] = {id = 81916, type = 'Fungus'},
	[24539] = {id = 24539, type = 'Fungus'},
	[24008] = {id = 24008, type = 'Fungus'},
	[81404] = {id = 81404, type = 'Fungus'},
	[81412] = {id = 81412, type = 'Fungus'},
	[27676] = {id = 27676, type = 'Fungus'}
}
