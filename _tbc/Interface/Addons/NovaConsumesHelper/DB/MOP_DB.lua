---------------------------
---NovaConsumesHelper DB--
---------------------------
--Novaspark-Arugal OCE (classic).
--https://www.curseforge.com/members/venomisto/projects

local _, NCH = ...;

if (not NCH.isMOP) then
	return;
end
local L = LibStub("AceLocale-3.0"):GetLocale("NovaConsumesHelper");
NCH.slots = {};
NCH.protSlots = {};
local tinsert = tinsert;
local loadCata = true;

NCH.flasks = {
	[1] = {
		name = "Flask of Spring Blossoms",
		spellID = 105689,
		itemID = 76084,
		icon = 609900,
		desc = "+1000 Agility",
		label = "Flask",
	},
	[2] = {
		name = "Flask of the Warm Sun",
		spellID = 105691,
		itemID = 76085,
		icon = 609902,
		desc = "+1000 Intellect",
		label = "Flask",
	},
	[3] = {
		name = "Flask of Winter's Bite",
		spellID = 105696,
		itemID = 76088,
		icon = 609901,
		desc = "+1000 Strength",
		label = "Flask",
	},
	[4] = {
		name = "Flask of Falling Leaves",
		spellID = 105693,
		itemID = 76086,
		icon = 609899,
		desc = "+1000 Spirit",
		label = "Flask",
	},
	[5] = {
		name = "Flask of the Earth",
		spellID = 105694,
		itemID = 76087,
		icon = 609903,
		desc = "+1500 Stamina",
		label = "Flask",
	},
	--[[[6] = {
		name = "Flask of Enhancement",
		spellID = 0,
		itemID = 58149,
		icon = 463532,
		desc = "Alchemy flask",
		label = "Flask",
	},]]
};

NCH.potions = {
	[1] = {
		name = "Crystal of Insanity",
		spellID = 127230,
		itemID = 86569,
		icon = 132885,
		desc = "Increases all stats by 500 for 1 hour.",
		label = "Pot",
	},
};

NCH.shortPotions = {
	--[[[1] = {
		name = "",
		spellID = ,
		itemID = ,
		icon = ,
		desc = "",
		label = "Pot",
	},]]
	[1] = {
		name = "Potion of the Jade Serpent",
		spellID = 105702,
		itemID = 76093,
		icon = 609895,
		desc = "Increases your Intellect by 4000 for 25 sec.",
		label = "Pot",
	},
	[2] = {
		name = "Potion of Mogu Power",
		spellID = 105706,
		itemID = 76095,
		icon = 609896,
		desc = "Increases your Strength by 4000 for 25 sec.",
		label = "Pot",
	},
	[3] = {
		name = "Virmen's Bite",
		spellID = 105697,
		itemID = 76089,
		icon = 609897,
		desc = "Increases your Agility by 4000 for 25 sec.",
		label = "Pot",
	},
	[4] = {
		name = "Potion of the Mountains",
		spellID = 105698,
		itemID = 76090,
		icon = 609892,
		desc = "Increases armor by 12000 for 25 sec.",
		label = "Pot",
	},
	[5] = {
		name = "Darkwater Potion",
		spellID = 105707,
		itemID = 76096,
		icon = 609891,
		desc = "Transforms you into a Jinyu assassin, increasing movement speed by 70% and swim speed by 200%. Lasts 15 sec.",
		label = "Pot",
	},
	[6] = {
		name = "Snap Root Tuber",
		spellID = 133024,
		itemID = 91803,
		icon = 134011,
		desc = "Increases haste by 4000 for 25 sec.",
		label = "Pot",
	},
	[7] = {
		name = "Invisibility Potion",
		spellID = 11392,
		itemID = 11464,
		icon = 134805,
		desc = "Gives the imbiber invisibility for 18 sec.",
		label = "Pot",
	},
	[8] = {
		name = "Master Healing Potion",
		spellID = 105708,
		itemID = 76097,
		icon = 650638,
		desc = "Restores 120000 health.",
		label = "Pot",
	},
	[9] = {
		name = "Master Mana Potion",
		spellID = 105709,
		itemID = 76098,
		icon = 650641,
		desc = "Restores 30000 mana.",
		label = "Pot",
	},
	--[[[7] = {
		name = "",
		spellID = 0,
		itemID = 0,
		icon = 0,
		desc = "",
		label = "Pot",
	},]]
};

NCH.foods = {
	--Seems they changed how buff food works and they all share the same food/drink buff now.
	--This means if someone has more than 1 food on the consumes bar it will show both as eating, it's only a small side effect though.
	[1] = {
		name = "Mogu Fish Stew",
		spellID = 104277,
		itemID = 74650,
		icon = 651582,
		desc = "+300 Intellect",
		label = "Food",
		eatingID = 104935,
	},
	[2] = {
		name = "Spiced Blossom Soup",
		spellID = 146806,
		itemID = 101748,
		icon = 134210,
		desc = "+300 Intellect",
		label = "Food",
		eatingID = 104935,
	},
	[3] = {
		name = "Steamed Crab Surprise",
		spellID = 104280,
		itemID = 74653,
		icon = 651595,
		desc = "+300 Spirit",
		label = "Food",
		eatingID = 104935,
	},
	[4] = {
		name = "Black Pepper Ribs and Shrimp",
		spellID = 104272,
		itemID = 74646,
		icon = 651331,
		desc = "+300 Strength",
		label = "Food",
		eatingID = 104935,
	},
	[5] = {
		name = "Chun Tian Spring Rolls",
		spellID = 104283,
		itemID = 74656,
		icon = 651594,
		desc = "+450 Stamina",
		label = "Food",
		eatingID = 104935,
	},
	[6] = {
		name = "Sea Mist Rice Noodles",
		spellID = 104275,
		itemID = 74648,
		icon = 651592,
		desc = "+300 Agility",
		label = "Food",
		eatingID = 104935,
	},
	[7] = {
		name = "Spicy Salmon",
		spellID = 125113,
		itemID = 86073,
		icon = 350563,
		desc = "+300 Hit",
		label = "Food",
		eatingID = 104935,
	},
	[8] = {
		name = "Spicy Vegetable Chips",
		spellID = 125115,
		itemID = 86074,
		icon = 649817,
		desc = "+300 Expertise",
		label = "Food",
		eatingID = 104935,
	},
	--5.4 foods.
	[9] = {
		name = "Fluffy Silkfeather Omelet",
		spellID = 146804,
		itemID = 101750,
		icon = 133948,
		desc = "+300 Strength",
		label = "Food",
		eatingID = 104935,
	},
	[10] = {
		name = "Stuffed Lushrooms",
		spellID = 146808,
		itemID = 101749,
		icon = 451162,
		desc = "+450 Stamina",
		label = "Food",
		eatingID = 104935,
	},
	[11] = {
		name = "Farmer's Delight",
		spellID = 146807,
		itemID = 101747,
		icon = 237331,
		desc = "+300 Spirit",
		label = "Food",
		eatingID = 104935,
	},
	[12] = {
		name = "Mango Ice",
		spellID = 146809,
		itemID = 101745,
		icon = 895874,
		desc = "+300 Mastery",
		label = "Food",
		eatingID = 104935,
	},
	[13] = {
		name = "Spiced Blossom Soup",
		spellID = 146806,
		itemID = 101748,
		icon = 134210,
		desc = "+300 Intellect",
		label = "Food",
		eatingID = 104935,
	},
	[14] = {
		name = "Seasoned Pomfruit Slices",
		spellID = 146805,
		itemID = 101746,
		icon = 646177,
		desc = "+300 Agility",
		label = "Food",
		eatingID = 104935,
	},
	--+275 foods.
	[15] = {
		name = "Eternal Blossom Fish",
		spellID = 104271,
		itemID = 74645,
		icon = 136000,
		desc = "+275 Strength",
		label = "Food",
		eatingID = 104934,
	},
	[16] = {
		name = "Twin Fish Platter",
		spellID = 104282,
		itemID = 74655,
		icon = 136000,
		desc = "+415 Stamina",
		label = "Food",
		eatingID = 104934,
	},
	[17] = {
		name = "Braised Turtle",
		spellID = 104276,
		itemID = 74649,
		icon = 651567,
		desc = "+275 Intellect",
		label = "Food",
		eatingID = 104934,
	},
	[18] = {
		name = "Fire Spirit Salmon",
		spellID = 104279,
		itemID = 74652,
		icon = 136000,
		desc = "+275 Spirit",
		label = "Food",
		eatingID = 104934,
	},
	[19] = {
		name = "Valley Stir Fry",
		spellID = 104274,
		itemID = 74647,
		icon = 136000,
		desc = "+275 Agility",
		label = "Food",
		eatingID = 104934,
	},
	[20] = {
		name = "Wildfowl Ginseng Soup",
		spellID = 125106,
		itemID = 86070,
		icon = 136000,
		desc = "+275 Hit",
		label = "Food",
		eatingID = 104934,
	},
	[21] = {
		name = "Rice Pudding",
		spellID = 125108,
		itemID = 86070,
		icon = 136000,
		desc = "+275 Expertise",
		label = "Food",
		eatingID = 104934,
	},
	--+250 food.
	[22] = {
		name = "Charbroiled Tiger Steak",
		spellID = 104267,
		itemID = 74642,
		icon = 136000,
		desc = "+275 Strength",
		label = "Food",
		eatingID = 104235,
	},
	[23] = {
		name = "Wildfowl Roast",
		spellID = 104281,
		itemID = 74654,
		icon = 136000,
		desc = "+375 Stamina",
		label = "Food",
		eatingID = 104235,
	},
	[24] = {
		name = "Swirling Mist Soup",
		spellID = 104264,
		itemID = 74644,
		icon = 136000,
		desc = "+275 Intellect",
		label = "Food",
		eatingID = 104235,
	},
	[25] = {
		name = "Shrimp Dumplings",
		spellID = 104278,
		itemID = 74651,
		icon = 136000,
		desc = "+275 Spirit",
		label = "Food",
		eatingID = 104235,
	},
	[26] = {
		name = "Sauteed Carrots",
		spellID = 104273,
		itemID = 74643,
		icon = 136000,
		desc = "+275 Agility",
		label = "Food",
		eatingID = 104235,
	},
	--[[[7] = {
		name = "",
		spellID = ,
		itemID = ,
		icon = ,
		desc = "",
		label = "Food",
		eatingID = ,
	},]]
	--[[[7] = { --Noodle cart.
		name = "Pandaren Treasure Noodle Soup",
		spellID = 104277, --Noolde cart gives the same spellID as the above single foods.
		itemID = 101618,
		icon = 879830,
		desc = "Noodle cart +300 stat food",
		label = "Food",
		eatingID = 148984,
	},]]
};
 
NCH.foods2 = {
	
};

--Even though these don't use enchantIDs in higher they still need 1 set for the addon to work along with noItemUseSpell = true.
NCH.tempEnchants = {
	
};

if (NCH.class == "ROGUE") then
	tinsert(NCH.tempEnchants, {
		name = "Wound Poison",
		enchantID = 703,
		spellID = 8679,
		icon = 134197,
		desc = "",
		label = "Weap",
		weaponSlot = "both",
		noItemUseSpell = true,
		noDisable = true,
	});
	tinsert(NCH.tempEnchants, {
		name = "Deadly Poison",
		enchantID = 7,
		spellID = 2823,
		icon = 132290,
		desc = "",
		label = "Weap",
		weaponSlot = "both",
		noItemUseSpell = true,
		noDisable = true,
	});
	tinsert(NCH.tempEnchants, {
		name = "Crippling Poison",
		enchantID = 22,
		spellID = 3408,
		icon = 132274,
		desc = "",
		label = "Weap",
		weaponSlot = "both",
		noItemUseSpell = true,
		noDisable = true,
	});
	tinsert(NCH.tempEnchants, {
		name = "Mind-Numbing Poison",
		enchantID = 35,
		spellID = 5761,
		icon = 136066,
		desc = "",
		label = "Weap",
		weaponSlot = "both",
		noItemUseSpell = true,
		noDisable = true,
	});
	tinsert(NCH.tempEnchants, {
		name = "Paralytic Poison",
		enchantID = 999,
		spellID = 108215,
		icon = 538441,
		desc = "",
		label = "Weap",
		weaponSlot = "both",
		noItemUseSpell = true,
		noDisable = true,
	});
end

if (NCH.class == "SHAMAN") then
	tinsert(NCH.tempEnchants, {
		name = "Earthliving Weapon",
		enchantID = 3345,
		spellID = 51730,
		icon = 462328,
		desc = "",
		label = "Weap",
		weaponSlot = "both",
		noItemUseSpell = true,
		noDisable = true,
	});
	tinsert(NCH.tempEnchants, {
		name = "Flametongue Weapon",
		enchantID = 5,
		spellID = 8024,
		icon = 462326,
		desc = "",
		label = "Weap",
		weaponSlot = "both",
		noItemUseSpell = true,
		noDisable = true,
	});
	tinsert(NCH.tempEnchants, {
		name = "Windfury Weapon",
		enchantID = 283,
		spellID = 8232,
		icon = 462329,
		desc = "",
		label = "Weap",
		weaponSlot = "both",
		noItemUseSpell = true,
		noDisable = true,
	});
	tinsert(NCH.tempEnchants, {
		name = "Rockbiter Weapon",
		enchantID = 3021,
		spellID = 8017,
		icon = 462325,
		desc = "",
		label = "Weap",
		weaponSlot = "both",
		noItemUseSpell = true,
		noDisable = true,
	});
	tinsert(NCH.tempEnchants, {
		name = "Frostbrand Weapon",
		enchantID = 2,
		spellID = 8033,
		icon = 462327,
		desc = "",
		label = "Weap",
		weaponSlot = "both",
		noItemUseSpell = true,
		noDisable = true,
	});
end

NCH.scrolls = {

};

NCH.misc = {
	[1] = {
		name = "Drums of Rage",
		spellID = 146555,
		itemID = 102351,
		icon = 133845,
		desc = "Increases melee, ranged, and spell haste by 25% for all party and raid members. Lasts 40 sec.",
		label = "Drum",
	},
	[2] = {
		name = "Savory Deviate Delight",
		spellID = 8219,
		itemID = 6657,
		icon = 134302,
		desc = "Changes your character display.",
		label = "Sav",
		sharedSpellIDs = {8220}, --Needs a 2nd spellID, male and female diff buffs.
	},
};

if (NCH.class == "ROGUE") then
	tinsert(NCH.misc, {
		name = "Thistle Tea",
		spellID = 9512,
		itemID = 7676,
		icon = 134197,
		desc = "Instantly restores 10 energy.",
		label = "Tea",
	});
end

if (loadCata) then
	--Flasks.
	tinsert(NCH.flasks, {
		name = "Flask of the Draconic Mind",
		spellID = 79470,
		itemID = 58086,
		icon = 463930,
		desc = "Increases Intellect by 300 for 1 hour.",
		label = "Flask",
	});
	tinsert(NCH.flasks, {
		name = "Flask of Titanic Strength",
		spellID = 79472,
		itemID = 58088,
		icon = 463931,
		desc = "Increases Strength by 300 for 1 hour.",
		label = "Flask",
	});
	tinsert(NCH.flasks, {
		name = "Flask of the Winds",
		spellID = 79471,
		--sharedSpellIDs = {64420}, --For testing.
		itemID = 58087,
		icon = 463927,
		desc = "Increases Agility by 300 for 1 hour.",
		label = "Flask",
	});
	tinsert(NCH.flasks, {
		name = "Flask of Steelskin",
		spellID = 79469,
		itemID = 58085,
		icon = 463926,
		desc = "Increases Stamina by 450 for 1 hour.",
		label = "Flask",
	});
	tinsert(NCH.flasks, {
		name = "Flask of Flowing Water",
		spellID = 94160,
		itemID = 67438,
		icon = 463929,
		desc = "Increases Spirit by 300 for 1 hour.",
		label = "Flask",
	});
	tinsert(NCH.flasks, {
		name = "Flask of Battle",
		spellID = 92679,
		sharedSpellIDs = {79470, 79472, 79471, 79469, 94160},
		itemID = 65455,
		icon = 134735,
		desc = "Grants the effect of a flask based on your class and talents.",
		label = "Flask",
	});
	
	--Potions.
	tinsert(NCH.potions, {
		name = "Elixir of the Master",
		spellID = 79635,
		itemID = 58148,
		icon = 463921,
		desc = "Increases your mastery rating by 225 for 1 hour.",
		label = "Batt",
	});
	tinsert(NCH.potions, {
		name = "Elixir of Impossible Accuracy",
		spellID = 79481,
		itemID = 58094,
		icon = 464029,
		desc = "Increases your hit rating by 225 for 1 hour.",
		label = "Batt",
	});
	tinsert(NCH.potions, {
		name = "Elixir of Mighty Speed",
		spellID = 79632,
		itemID = 58144,
		icon = 464025,
		desc = "Increases haste rating by 225 for 1 hour.",
		label = "Batt",
	});
	tinsert(NCH.potions, {
		name = "Prismatic Elixir",
		spellID = 79631,
		itemID = 58143,
		icon = 464027,
		desc = "Increases resistance to magic by 90 for 1 hour.",
		label = "Guar",
	});
	tinsert(NCH.potions, {
		name = "Elixir of the Naga",
		spellID = 79474,
		itemID = 58089,
		icon = 134792,
		desc = "Increases expertise rating by 225 for 1 hour.",
		label = "Batt",
	});
	tinsert(NCH.potions, {
		name = "Ghost Elixir",
		spellID = 79468,
		itemID = 58084,
		icon = 463924,
		desc = "Increases Spirit by 225 for 1 hour.",
		label = "Batt",
	});
	tinsert(NCH.potions, {
		name = "Elixir of Deep Earth",
		spellID = 79480,
		itemID = 58093,
		icon = 464028,
		desc = "Increases armor by 900 for 1 hour.",
		label = "Guar",
	});
	tinsert(NCH.potions, {
		name = "Elixir of the Cobra",
		spellID = 79477,
		itemID = 58092,
		icon = 463860,
		desc = "Increases critical strike rating by 225 for 1 hour.",
		label = "Batt",
	});

	--Short potions.
	tinsert(NCH.shortPotions, {
		name = "Potion of the Tol'vir",
		spellID = 79633,
		itemID = 58145,
		icon = 463923,
		desc = "Increases your Agility by 1200 for 25 sec.",
		label = "Pot",
	});
	tinsert(NCH.shortPotions, {
		name = "Volcanic Potion",
		spellID = 79476,
		itemID = 58091,
		icon = 463922,
		desc = "Increases Intellect by 1200 for 25 sec.",
		label = "Pot",
	});
	tinsert(NCH.shortPotions, {
		name = "Golemblood Potion",
		spellID = 79634,
		itemID = 58146,
		icon = 463920,
		desc = "Increases your Strength by 1200 for 25 sec.",
		label = "Pot",
	});
	tinsert(NCH.shortPotions, {
		name = "Earthen Potion",
		spellID = 79475,
		itemID = 58090,
		icon = 236874,
		desc = "Increases armor by 4800 for 25 sec.",
		label = "Pot",
	});
	tinsert(NCH.shortPotions, {
		name = "Potion of Concentration",
		spellID = 78993,
		itemID = 57194,
		icon = 463900,
		desc = "Puts the imbiber in an elevated state of concentration where they can restore up to 22000 mana over 10 sec",
		label = "Pot",
	});
	tinsert(NCH.shortPotions, {
		name = "Mighty Rejuvenation Potion",
		spellID = 78992,
		itemID = 57193,
		icon = 463546,
		desc = "Restores 9000 to 11000 mana and health.",
		label = "Pot",
	});
	tinsert(NCH.shortPotions, {
		name = "Mythical Healing Potion",
		spellID = 78989,
		itemID = 57191,
		icon = 463548,
		desc = "Restores 22500 to 27500 health.",
		label = "Pot",
	});
	tinsert(NCH.shortPotions, {
		name = "Mythical Mana Potion",
		spellID = 78990,
		itemID = 57192,
		icon = 463545,
		desc = "Restores 9250 to 10750 mana.",
		label = "Pot",
	});

	--Foods
	tinsert(NCH.foods, {
		name = "Tender Baked Turtle",
		spellID = 87557,
		itemID = 62658,
		icon = 350562,
		desc = "Agility and Stamina increased by 60.",
		label = "Food",
		eatingID = 87566,
	});
	tinsert(NCH.foods, {
		name = "Skewered Eel",
		spellID = 87546,
		itemID = 62669,
		icon = 351508,
		desc = "Agility and Stamina increased by 90.",
		label = "Food",
		eatingID = 87586,
	});
	tinsert(NCH.foods, {
		name = "Pickled Guppy",
		spellID = 87558,
		itemID = 62660,
		icon = 351507,
		desc = "Intellect and Stamina increased by 60.",
		label = "Food",
		eatingID = 87567,
	});
	tinsert(NCH.foods, {
		name = "Severed Sagefish Head",
		spellID = 87547,
		itemID = 62671,
		icon = 351505,
		desc = "Intellect and Stamina increased by 90.",
		label = "Food",
		eatingID = 87587,
	});
	tinsert(NCH.foods, {
		name = "Hearty Seafood Soup",
		spellID = 87556,
		itemID = 62659,
		icon = 350560,
		desc = "Strength and Stamina increased by 60. Lasts 1 hour.",
		label = "Food",
		eatingID = 87544,
	});
	tinsert(NCH.foods, {
		name = "Beer-Basted Crocolisk",
		spellID = 87545,
		itemID = 62670,
		icon = 350565,
		desc = "Strength and Stamina increased by 90.",
		label = "Food",
		eatingID = 87584,
	});
	tinsert(NCH.foods, {
		name = "Whitecrest Gumbo",
		spellID = 87559,
		itemID = 62656,
		icon = 350559,
		desc = "Spirit and Stamina increased by 60.",
		label = "Food",
		eatingID = 87568,
	});
	tinsert(NCH.foods, {
		name = "Delicious Sagefish Tail",
		spellID = 87548,
		itemID = 62666,
		icon = 351503,
		desc = "Spirit and Stamina increased by 90.",
		label = "Food",
		eatingID = 87588,
	});
	tinsert(NCH.foods, {
		name = "Lavascale Minestrone",
		spellID = 87549,
		itemID = 62663,
		icon = 351499,
		desc = "Mastery rating and Stamina increased by 90.",
		label = "Food",
		eatingID = 87594,
	});
	tinsert(NCH.foods, {
		name = "Blackbelly Sushi",
		spellID = 87555,
		itemID = 62668,
		icon = 351506,
		desc = "Parry rating and Stamina increased by 90.",
		label = "Food",
		eatingID = 87602,
	});
	tinsert(NCH.foods, {
		name = "Mushroom Sauce Mudfish",
		spellID = 87554,
		itemID = 62667,
		icon = 350558,
		desc = "Dodge rating and Stamina increased by 90.",
		label = "Food",
		eatingID = 87601,
	});
	tinsert(NCH.foods, {
		name = "Baked Rockfish",
		spellID = 87551,
		itemID = 62661,
		icon = 351500,
		desc = "Critical strike rating and Stamina increased by 90.",
		label = "Food",
		eatingID = 87597,
	});
	tinsert(NCH.foods, {
		name = "Grilled Dragon",
		spellID = 87550,
		itemID = 62662,
		icon = 237335,
		desc = "Hit rating and Stamina increased by 90.",
		label = "Food",
		eatingID = 87595,
	});
	tinsert(NCH.foods, {
		name = "Crocolisk Au Gratin",
		spellID = 87635,
		itemID = 62664,
		icon = 350567,
		desc = "Expertise rating and Stamina increased by 90.",
		label = "Food",
		eatingID = 87637,
	});
	tinsert(NCH.foods, {
		name = "Basilisk Liverdog",
		spellID = 87552,
		itemID = 62665,
		icon = 133973,
		desc = "Haste rating and Stamina increased by 90.",
		label = "Food",
		eatingID = 87599,
	});
	
	--Misc.
	tinsert(NCH.misc, {
		name = "Big Daddy",
		spellID = 89637,
		itemID = 63396,
		icon = 465879,
		desc = "Inflicts 5006 Fire damage and incapacitates targets for 5 sec in a 8 yard radius.",
		label = "Gren",
	});
	tinsert(NCH.misc, {
		name = "Global Thermal Sapper Charge",
		spellID = 56488,
		itemID = 42641,
		icon = 133035,
		desc = "Explodes when triggered, dealing 2188 to 2812 Fire damage to all enemies nearby and 2188 to 2812 damage to you.",
		label = "Sap",
	});
end

--Flask, Pot1, Pot2, Pot3, Pot4, Food, Oil, Misc1, Misc2, Misc3, Misc4, Misc4, Misc5
NCH.slots[1] = {name = L["Flask"], configSlot = 1};
for k, v in pairs(NCH.flasks) do
	tinsert(NCH.slots[1], v);
end

---Extra slots at the bottom of config options.
NCH.slots[19] = {name = L["Flask 2"], configSlot = 54};
for k, v in pairs(NCH.flasks) do
	tinsert(NCH.slots[19], v);
end

NCH.slots[20] = {name = L["Flask 3"], configSlot = 55};
for k, v in pairs(NCH.flasks) do
	tinsert(NCH.slots[20], v);
end


NCH.slots[21] = {name = L["Flask 4"], configSlot = 56};
for k, v in pairs(NCH.flasks) do
	tinsert(NCH.slots[21], v);
end


NCH.slots[22] = {name = L["Flask 5"], configSlot = 57};
for k, v in pairs(NCH.flasks) do
	tinsert(NCH.slots[22], v);
end


NCH.slots[2] = {name = L["Potion 1"], configSlot = 2};
for k, v in pairs(NCH.potions) do
	tinsert(NCH.slots[2], v);
end

NCH.slots[3] = {name = L["Potion 2"], configSlot = 3};
for k, v in pairs(NCH.potions) do
	tinsert(NCH.slots[3], v);
end

NCH.slots[4] = {name = L["Potion 3"], configSlot = 4};
for k, v in pairs(NCH.potions) do
	tinsert(NCH.slots[4], v);
end

NCH.slots[5] = {name = L["Potion 4"], configSlot = 5};
for k, v in pairs(NCH.potions) do
	tinsert(NCH.slots[5], v);
end

NCH.slots[6] = {name = L["Potion 5"], configSlot = 6};
for k, v in pairs(NCH.potions) do
	tinsert(NCH.slots[6], v);
end

NCH.slots[7] = {name = L["Potion 6"], configSlot = 15};
for k, v in pairs(NCH.potions) do
	tinsert(NCH.slots[7], v);
end

NCH.slots[8] = {name = L["Potion 7"], configSlot = 16};
for k, v in pairs(NCH.potions) do
	tinsert(NCH.slots[8], v);
end

---Extra slots at the bottom of config options.
NCH.slots[23] = {name = L["Potion 8"], configSlot = 19};
for k, v in pairs(NCH.potions) do
	tinsert(NCH.slots[23], v);
end
NCH.slots[24] = {name = L["Potion 9"], configSlot = 20};
for k, v in pairs(NCH.potions) do
	tinsert(NCH.slots[24], v);
end
NCH.slots[25] = {name = L["Potion 10"], configSlot = 21};
for k, v in pairs(NCH.potions) do
	tinsert(NCH.slots[25], v);
end
NCH.slots[26] = {name = L["Potion 11"], configSlot = 22};
for k, v in pairs(NCH.potions) do
	tinsert(NCH.slots[26], v);
end
NCH.slots[27] = {name = L["Potion 12"], configSlot = 23};
for k, v in pairs(NCH.potions) do
	tinsert(NCH.slots[27], v);
end
NCH.slots[28] = {name = L["Potion 13"], configSlot = 24};
for k, v in pairs(NCH.potions) do
	tinsert(NCH.slots[28], v);
end
NCH.slots[29] = {name = L["Potion 14"], configSlot = 25};
for k, v in pairs(NCH.potions) do
	tinsert(NCH.slots[29], v);
end
----------------------


NCH.slots[9] = {name = L["Food 1"], configSlot = 7};
for k, v in pairs(NCH.foods) do
	tinsert(NCH.slots[9], v);
end

NCH.slots[10] = {name = L["Food 2"], configSlot = 8};
for k, v in pairs(NCH.foods) do
	tinsert(NCH.slots[10], v);
end

---Extra slots at the bottom of config options.
NCH.slots[30] = {name = L["Food 3"], configSlot = 26};
for k, v in pairs(NCH.foods) do
	tinsert(NCH.slots[30], v);
end

NCH.slots[31] = {name = L["Food 4"], configSlot = 27};
for k, v in pairs(NCH.foods) do
	tinsert(NCH.slots[31], v);
end

NCH.slots[32] = {name = L["Food 5"], configSlot = 28};
for k, v in pairs(NCH.foods) do
	tinsert(NCH.slots[32], v);
end
----------------------


NCH.slots[11] = {name = L["Main Hand Oils/Stones/Enchants 1"], configSlot = 9};
for k, v in pairs(NCH.tempEnchants) do
	if (v.weaponSlot == "mainhand" or v.weaponSlot == "both") then
		local t = {};
		for k, v in pairs(v) do
			t[k] = v;
		end
		t.label = "MH";
		t.mainhand = true;
		tinsert(NCH.slots[11], t);
	end
end

NCH.slots[12] = {name = L["Off Hand Oils/Stones/Enchants 1"], configSlot = 10};
for k, v in pairs(NCH.tempEnchants) do
	if (v.weaponSlot == "offhand" or v.weaponSlot == "both") then
		local t = {};
		for k, v in pairs(v) do
			t[k] = v;
		end
		t.label = "OH";
		t.offhand = true;
		tinsert(NCH.slots[12], t);
	end
end

---Extra slots at the bottom of config options.
NCH.slots[33] = {name = L["Main Hand Oils/Stones/Enchants 2"], configSlot = 36};
for k, v in pairs(NCH.tempEnchants) do
	if (v.weaponSlot == "mainhand" or v.weaponSlot == "both") then
		local t = {};
		for k, v in pairs(v) do
			t[k] = v;
		end
		t.label = "MH";
		t.mainhand = true;
		tinsert(NCH.slots[33], t);
	end
end

NCH.slots[34] = {name = L["Main Hand Oils/Stones/Enchants 3"], configSlot = 37};
for k, v in pairs(NCH.tempEnchants) do
	if (v.weaponSlot == "mainhand" or v.weaponSlot == "both") then
		local t = {};
		for k, v in pairs(v) do
			t[k] = v;
		end
		t.label = "MH";
		t.mainhand = true;
		tinsert(NCH.slots[34], t);
	end
end

NCH.slots[35] = {name = L["Off Hand Oils/Stones/Enchants 2"], configSlot = 38};
for k, v in pairs(NCH.tempEnchants) do
	if (v.weaponSlot == "offhand" or v.weaponSlot == "both") then
		local t = {};
		for k, v in pairs(v) do
			t[k] = v;
		end
		t.label = "OH";
		t.offhand = true;
		tinsert(NCH.slots[35], t);
	end
end

NCH.slots[36] = {name = L["Off Hand Oils/Stones/Enchants 3"], configSlot = 39};
for k, v in pairs(NCH.tempEnchants) do
	if (v.weaponSlot == "offhand" or v.weaponSlot == "both") then
		local t = {};
		for k, v in pairs(v) do
			t[k] = v;
		end
		t.label = "OH";
		t.offhand = true;
		tinsert(NCH.slots[36], t);
	end
end

NCH.slots[13] = {name = L["Scroll 1"], configSlot = 11};
for k, v in pairs(NCH.scrolls) do
	tinsert(NCH.slots[13], v);
end

NCH.slots[37] = {name = L["Scroll 2"], configSlot = 40};
for k, v in pairs(NCH.scrolls) do
	tinsert(NCH.slots[37], v);
end

NCH.slots[38] = {name = L["Scroll 3"], configSlot = 41};
for k, v in pairs(NCH.scrolls) do
	tinsert(NCH.slots[38], v);
end

NCH.slots[14] = {name = L["Miscellaneous 1"], configSlot = 12};
for k, v in pairs(NCH.misc) do
	tinsert(NCH.slots[14], v);
end

NCH.slots[15] = {name = L["Miscellaneous 2"], configSlot = 13};
for k, v in pairs(NCH.misc) do
	tinsert(NCH.slots[15], v);
end

NCH.slots[16] = {name = L["Miscellaneous 3"], configSlot = 14};
for k, v in pairs(NCH.misc) do
	tinsert(NCH.slots[16], v);
end

NCH.slots[17] = {name = L["Miscellaneous 4"], configSlot = 17};
for k, v in pairs(NCH.misc) do
	tinsert(NCH.slots[17], v);
end

NCH.slots[18] = {name = L["Miscellaneous 5"], configSlot = 18};
for k, v in pairs(NCH.misc) do
	tinsert(NCH.slots[18], v);
end

---Extra slots at the bottom of config options.
NCH.slots[39] = {name = L["Miscellaneous 6"], configSlot = 29};
for k, v in pairs(NCH.misc) do
	tinsert(NCH.slots[39], v);
end

NCH.slots[40] = {name = L["Miscellaneous 7"], configSlot = 30};
for k, v in pairs(NCH.misc) do
	tinsert(NCH.slots[40], v);
end

NCH.slots[41] = {name = L["Miscellaneous 8"], configSlot = 31};
for k, v in pairs(NCH.misc) do
	tinsert(NCH.slots[41], v);
end

NCH.slots[42] = {name = L["Miscellaneous 9"], configSlot = 32};
for k, v in pairs(NCH.misc) do
	tinsert(NCH.slots[42], v);
end

NCH.slots[43] = {name = L["Miscellaneous 10"], configSlot = 33};
for k, v in pairs(NCH.misc) do
	tinsert(NCH.slots[43], v);
end

NCH.slots[44] = {name = L["Miscellaneous 11"], configSlot = 34};
for k, v in pairs(NCH.misc) do
	tinsert(NCH.slots[44], v);
end

NCH.slots[45] = {name = L["Miscellaneous 12"], configSlot = 35};
for k, v in pairs(NCH.misc) do
	tinsert(NCH.slots[45], v);
end
----------------------

NCH.slots[46] = {name = L["Short Duration (DPS) Pots 1"], configSlot = 42};
for k, v in pairs(NCH.shortPotions) do
	tinsert(NCH.slots[46], v);
end

NCH.slots[47] = {name = L["Short Duration (DPS) Pots 2"], configSlot = 43};
for k, v in pairs(NCH.shortPotions) do
	tinsert(NCH.slots[47], v);
end

NCH.slots[48] = {name = L["Short Duration (DPS) Pots 3"], configSlot = 44};
for k, v in pairs(NCH.shortPotions) do
	tinsert(NCH.slots[48], v);
end

NCH.slots[49] = {name = L["Short Duration (DPS) Pots 4"], configSlot = 45};
for k, v in pairs(NCH.shortPotions) do
	tinsert(NCH.slots[49], v);
end

NCH.slots[50] = {name = L["Short Duration (DPS) Pots 5"], configSlot = 46};
for k, v in pairs(NCH.shortPotions) do
	tinsert(NCH.slots[50], v);
end

NCH.slots[51] = {name = L["Short Duration (DPS) Pots 6"], configSlot = 47};
for k, v in pairs(NCH.shortPotions) do
	tinsert(NCH.slots[51], v);
end

NCH.slots[52] = {name = L["Short Duration (DPS) Pots 7"], configSlot = 48};
for k, v in pairs(NCH.shortPotions) do
	tinsert(NCH.slots[52], v);
end

NCH.slots[53] = {name = L["Short Duration (DPS) Pots 8"], configSlot = 49};
for k, v in pairs(NCH.shortPotions) do
	tinsert(NCH.slots[53], v);
end

NCH.slots[54] = {name = L["Short Duration (DPS) Pots 9"], configSlot = 50};
for k, v in pairs(NCH.shortPotions) do
	tinsert(NCH.slots[54], v);
end

NCH.slots[55] = {name = L["Short Duration (DPS) Pots 10"], configSlot = 51};
for k, v in pairs(NCH.shortPotions) do
	tinsert(NCH.slots[55], v);
end

NCH.slots[56] = {name = L["Short Duration (DPS) Pots 11"], configSlot = 52};
for k, v in pairs(NCH.shortPotions) do
	tinsert(NCH.slots[56], v);
end

NCH.slots[57] = {name = L["Short Duration (DPS) Pots 12"], configSlot = 53};
for k, v in pairs(NCH.shortPotions) do
	tinsert(NCH.slots[57], v);
end


NCH.protectionPots = {
	
};

function NCH:auditDatabase()
	print("Starting audit.");
	for k, v in ipairs(NCH.slots) do
		for item, itemData in ipairs(v) do
			if ((not itemData.spellID and not itemData.enchantID) or not itemData.name or not itemData.icon or not itemData.desc or not itemData.label) then
				print("Missing data:", itemData.name, itemData.itemID);
			end
			if (itemData.itemID) then
				local item = Item:CreateFromItemID(itemData.itemID);
				item:ContinueOnItemLoad(function()
					local itemName = item:GetItemName();
					if (itemName ~= itemData.name) then
						print("Item name mismatch:", itemData.name, " -> " .. itemName);
					end
					local icon = item:GetItemIcon();
					if (icon ~= itemData.icon) then
						print("Icon mismatch:", itemData.name, " -> " .. itemData.icon,  " -> " .. icon);
					end
				end);
			end
			--No real way to check spellIDs linked to itemID I guess.
			--[[if (itemData.spellID) then
				local spell = Spell:CreateFromSpellID(itemData.spellID);
				spell:ContinueOnSpellLoad(function()
					local spellName = spell:GetSpellName();
					if (spellName ~= itemData.name) then
						print("Spell name mismatch:", itemData.name, " -> " .. spellName);
					end
					local icon = spell:GetSpellTexure();
					if (icon ~= itemData.icon) then
						print("Icon mismatch:", itemData.name, " -> " .. itemData.icon,  " -> " .. icon);
					end
				end);
			end]]
		end
	end
end

function NCH:scanForUnique()
	print("Starting unique scan.");
	local tooltipScanner = CreateFrame("GameTooltip", "NCH_UniqueScanner", nil, "GameTooltipTemplate");
	tooltipScanner:SetOwner(WorldFrame, "ANCHOR_NONE");
	local tooltipLines = {
		[1] = NCH_UniqueScannerTextLeft2,
		[2] = NCH_UniqueScannerTextLeft3,
		[3] = NCH_UniqueScannerTextLeft4,
	};
	local slots = {NCH.flasks, NCH.potions, NCH.shortPotions, NCH.foods, NCH.foods2, NCH.tempEnchants, NCH.scrolls, NCH.misc}
	for k, v in ipairs(slots) do
		for item, itemData in ipairs(v) do
			if (itemData.itemID) then
				local item = Item:CreateFromItemID(itemData.itemID);
				item:ContinueOnItemLoad(function()
					local itemLink = item:GetItemLink();
					tooltipScanner:SetHyperlink(itemLink);
					local found;
		            for i = 1, 5 do
			            local text = _G["NCH_UniqueScannerTextLeft" .. i]:GetText();
			            if (text and strmatch(text, "Unique")) then
			            	if (itemData.unique) then
			            		print("|cFF00FF00Unique flag set:|r", item:GetItemName());
			            	else
			            		print("|cFFFF0000Missing unique flag:|r", item:GetItemName());
			            	end
			            	found = true;
			            end
		            end
		            if (itemData.unique and not found) then
		            	print("|cFFFF0000Not unique item with flag set:|r", item:GetItemName());
		            end
				end);
			end
		end
	end
end