---------------------------
---NovaConsumesHelper DB--
---------------------------
--Novaspark-Arugal OCE (classic).
--https://www.curseforge.com/members/venomisto/projects

local _, NCH = ...;

if (not NCH.isClassic) then
	return;
end
local L = LibStub("AceLocale-3.0"):GetLocale("NovaConsumesHelper");
NCH.slots = {};
NCH.protSlots = {};
local tinsert = tinsert;

NCH.flasks = {
	[1] = {
		name = "Flask of Supreme Power",
		spellID = 17628,
		itemID = 13512,
		icon = 134821,
		desc = "+70 Spell Power",
		label = "Flask",
	},
	[2] = {
		name = "Flask of the Titans",
		spellID = 17626,
		itemID = 13510,
		icon = 134842,
		desc = "+1200 HP",
		label = "Flask",
	},
	[3] = {
		name = "Flask of Distilled Wisdom",
		spellID = 17627,
		itemID = 13511,
		icon = 134877,
		desc = "+65 Int",
		label = "Flask",
	},
	[4] = {
		name = "Flask of Chromatic Resistance",
		spellID = 17629,
		itemID = 13513,
		icon = 134828,
		desc = "+25 All Resistances",
		label = "Flask",
	},
};
if (NCH.isSOD) then
	--SoD P6 Flasks.
	tinsert(NCH.flasks, {
		name = "Flask of Unyielding Sorrow",
		spellID = 1213886,
		itemID = 233966,
		icon = 236877,
		desc = "+80 Healing, +27 SP, +12 MP5",
		label = "Flask",
	});
	tinsert(NCH.flasks, {
		name = "Flask of Ancient Knowledge",
		spellID = 1213892,
		itemID = 233964,
		icon = 236878,
		desc = "+180 Spell Power",
		label = "Flask",
	});
	tinsert(NCH.flasks, {
		name = "Flask of the Old Gods",
		spellID = 1213901,
		itemID = 233965,
		icon = 236879,
		desc = "+100 Stamina, +10 Defense",
		label = "Flask",
	});
	tinsert(NCH.flasks, {
		name = "Flask of Madness",
		spellID = 1213897,
		itemID = 233962,
		icon = 236880,
		desc = "+50 Attack Power",
		label = "Flask",
	});
end

NCH.potions = {
	[1] = {
		name = "Greater Arcane Elixir",
		spellID = 17539,
		itemID = 13454,
		icon = 134805,
		desc = "Increase spell damage by up to 35",
		label = "Pot",
	},
	[2] = {
		name = "Mageblood Potion",
		spellID = 24363,
		itemID = 20007,
		icon = 134825,
		desc = "+12 MP5",
		label = "Pot",
	},
	[3] = {
		name = "Elixir of Frost Power",
		spellID = 21920,
		itemID = 17708,
		icon = 134714,
		desc = "Increase spell frost damage by up to 15",
		label = "Pot",
	},
	[4] = {
		name = "Elixir of Greater Intellect",
		spellID = 11396,
		itemID = 9179,
		icon = 134721,
		desc = "+25 Intellect",
		label = "Pot",
	},
	[5] = {
		name = "Elixir of Giants",
		spellID = 11405,
		itemID = 9206,
		icon = 134841,
		desc = "+25 Strength",
		label = "Pot",
	},
	[6] = {
		name = "Elixir of Greater Agility",
		spellID = 11334,
		itemID = 9187,
		icon = 134874,
		desc = "+25 Agility",
		label = "Pot",
	},
	[7] = {
		name = "Elixir of Demonslaying",
		spellID = 11406,
		itemID = 9224,
		icon = 134807,
		desc = "Increase attack power by 265 against demons",
		label = "Pot",
	},
	[8] = {
		name = "Elixir of Greater Firepower",
		spellID = 26276,
		itemID = 21546,
		icon = 134840,
		desc = "Increase spell fire damage by up to 40",
		label = "Pot",
	},
	[9] = {
		name = "Elixir of Shadow Power",
		spellID = 11474,
		itemID = 9264,
		icon = 134826,
		desc = "Increase spell shadow damage by up to 40",
		label = "Pot",
	},
	[10] = {
		name = "Elixir of the Sages",
		spellID = 17535,
		itemID = 13447,
		icon = 134809,
		desc = "+18 Intellect, +18 Spirit",
		label = "Pot",
	},
	[11] = {
		name = "Elixir of Brute Force",
		spellID = 17537,
		itemID = 13453,
		icon = 134820,
		desc = "+18 Strength, +18 Stamina",
		label = "Pot",
	},
	[12] = {
		name = "Winterfall Firewater",
		spellID = 17038,
		sharedSpellIDs = {473469, 16329}, --Juju might/Cleansed Firewater, SoD cauldron, probably need to make spellIDs a table in the future if there ends up being more items with more than 1 spellID.
		itemID = 12820,
		icon = 134872,
		desc = "Increase melee attack power by 35",
		label = "Pot",
		hideCooldown = true, --Hide cooldowns for items with long cooldowns, like this with 1 minute, we just want to show short cooldowns while buffing up.
	},
	[13] = {
		name = "Elixir of the Mongoose",
		spellID = 17538,
		itemID = 13452,
		icon = 134812,
		desc = "+25 Agility and 2% Crit",
		label = "Pot",
	},
	[14] = {
        name = "Juju Power",
        spellID = 16323,
        itemID = 12451,
        icon = 134313,
        desc = "+30 Strength",
        label = "Juju",
    },
    [15] = {
        name = "Juju Might",
        spellID = 16329,
        itemID = 12460,
        icon = 134309,
        desc = "Increase attack power by 40",
        label = "Juju",
        sharedSpellIDs = {473469, 17038}, --Firewater/Cleansed Firewater, SoD cauldron, probably need to make spellIDs a table in the future if there ends up being more items with more than 1 spellID.
    },
    [16] = {
		name = "Elixir of Fortitude",
		spellID = 3593,
		itemID = 3825,
		icon = 134823,
		desc = "+120 Health",
		label = "Pot",
	},
	[17] = {
		name = "Elixir of Superior Defense",
		spellID = 11348,
		itemID = 13445,
		icon = 134846,
		desc = "+450 Armor",
		label = "Pot",
	},
	[18] = {
		name = "Major Troll's Blood Potion",
		spellID = 24361,
		itemID = 20004,
		icon = 134860,
		desc = "Regenerate 20 health every 5 seconds",
		label = "Pot",
	},
	[19] = {
		name = "Mighty Troll's Blood Potion",
		spellID = 3223,
		itemID = 3826,
		icon = 134859,
		desc = "Regenerate 12 health every 5 seconds",
		label = "Pot",
	},
	[20] = { --Are short terms potions really needed? People would usually have them on a hotbar and not need to track them running out.
		name = "Greater Stoneshield Potion",
		spellID = 17540,
		itemID = 13455,
		icon = 134849,
		desc = "Increases armor by 2000 for 2 min",
		label = "Pot",
	},
	[21] = {
		name = "Elixir of Firepower",
		spellID = 7844,
		itemID = 6373,
		icon = 134813,
		desc = "Increase spell fire damage by up to 10",
		label = "Pot",
	},
	[22] = {
        name = "Juju Ember",
        spellID = 16326,
        itemID = 12455,
        icon = 134317,
        desc = "Increases Fire resistance by 15 for 10 min.",
        label = "Juju",
    },
    [23] = {
        name = "Magic Resistance Potion",
        spellID = 11364,
        itemID = 9036,
        icon = 134787,
        desc = "Increases your resistance to all schools of magic by 50 for 3 min.",
        label = "Pot",
    },
    [24] = {
        name = "Juju Chill",
        spellID = 16325,
        itemID = 12457,
        icon = 134311,
        desc = "Increases Frost resistance by 15 for 10 min.",
        label = "Juju",
    },
    [25] = {
		name = "Arcane Elixir",
		spellID = 11390,
		itemID = 9155,
		icon = 134810,
		desc = "Increase spell damage by up to 20",
		label = "Pot",
	},
	[26] = {
        name = "Juju Flurry",
        spellID = 16322,
        itemID = 12450,
        icon = 134319,
        desc = "Increases the target's attack speed by 3% for 20 sec.",
        label = "Juju",
    },
    [27] = {
		name = "Elixir of Greater Defense",
		spellID = 11349,
		itemID = 8951,
		icon = 134845,
		desc = "+250 Armor",
		label = "Pot",
	},
};
if (NCH.isSOD) then
	tinsert(NCH.potions, {
        name = "Elixir of the Honey Badger",
        spellID = 1213904,
        itemID = 233967,
        icon = 134731,
        desc = "+30 Agi, +2% Crit, +15 Nature Res",
        label = "Pot",
    });
    tinsert(NCH.potions, {
        name = "Elixir of the Mage-Lord",
        spellID = 1213914,
        itemID = 233968,
        icon = 134733,
        desc = "+40 SP, +15 Nature Res",
        label = "Pot",
    });
    tinsert(NCH.potions, {
        name = "Elixir of the Ironside",
        spellID = 1213917,
        itemID = 233969,
        icon = 134730,
        desc = "+350 Armor, +5 Defense, +15 Nature Res",
       	label = "Pot",
    });
    tinsert(NCH.potions, {
        name = "Elixir of Alacrity",
		spellID = 1213922,
		itemID = 233977,
        icon = 134735,
        desc = "+15% Run Speed",
        label = "Pot",
    });
    tinsert(NCH.potions, {
        name = "Mildly Irradiated Rejuvenation Potion",
		spellID = 435973,
		itemID = 215162,
        icon = 236870,
        desc = "+50 Attack power, +35 Spell Power",
        label = "dps",
    });
end

NCH.shortPotions = {
	[1] = {
		name = "Free Action Potion",
		spellID = 6615,
		itemID = 5634,
		icon = 134715,
		desc = "Stun/Movement Immunity",
		label = "FAP",
	},
	[2] = {
		name = "Living Action Potion",
		spellID = 24364,
		itemID = 20008,
		icon = 134718,
		desc = "Stun/Movement Immunity",
		label = "FAP",
	},
	[3] = {
		name = "Limited Invulnerability Potion",
		spellID = 3169,
		itemID = 3387,
		icon = 134842,
		desc = "Imbiber is immune to physical attacks for the next 6 sec.",
		label = "LIP",
	},
	[4] = {
		name = "Mighty Rage Potion",
		spellID = 17528,
		itemID = 13442,
		icon = 134821,
		desc = "Increases Rage by 45 to 75 and increases Strength by 60 for 20 sec.",
		label = "MR",
	},
	[5] = {
        name = "Magic Resistance Potion",
        spellID = 11364,
        itemID = 9036,
        icon = 134787,
        desc = "Increases your resistance to all schools of magic by 50 for 3 min.",
        label = "Res",
    },
    [6] = {
		name = "Greater Stoneshield Potion",
		spellID = 17540,
		itemID = 13455,
		icon = 134849,
		desc = "Increases armor by 2000 for 2 min",
		label = "Ston",
	},
	[7] = {
		name = "Purification Potion",
		spellID = 17550,
		itemID = 13462,
		icon = 134811,
		desc = "Attempts to remove one Curse, one Disease and one Poison from the Imbiber.",
		label = "Pot",
	},
	[8] = {
		name = "Greater Dreamless Sleep Potion",
		spellID = 24360,
		itemID = 20002,
		icon = 134863,
		desc = "Puts the imbiber in a dreamless sleep for 12 sec. During that time the imbiber heals 2100 health and 2100 mana.",
		label = "Pot",
	},
	[9] = {
		name = "Flask of Petrification",
		spellID = 17624,
		itemID = 13506,
		icon = 134806,
		desc = "You turn to stone, protecting you from all physical attacks and spells for 1 min.",
		label = "Pot",
	},
	[10] = {
		name = "Restorative Potion",
		spellID = 11359,
		itemID = 9030,
		icon = 134712,
		desc = "Removes 1 magic, curse, poison or disease effect on you every 5 seconds for 30 seconds.",
		label = "Pot",
	},
	[11] = {
		name = "Swiftness Potion",
		spellID = 2379,
		itemID = 2459,
		icon = 134875,
		desc = "Increases run speed by 50% for 15 sec.",
		label = "Pot",
	},
	[12] = {
		name = "Invisibility Potion",
		spellID = 11392,
		itemID = 9172,
		icon = 134805,
		desc = "Gives the imbiber invisibility for 18 sec.",
		label = "Pot",
	},
	[13] = {
		name = "Elixir of Poison Resistance",
		spellID = 26677,
		itemID = 3386,
		icon = 134743,
		desc = "Imbiber is cured of up to four poisons up to level 60.",
		label = "Pot",
	},
	[14] = {
		name = "Major Healing Potion",
		spellID = 17534,
		itemID = 13446,
		icon = 134834,
		desc = "Restores 1050 to 1750 health.",
		label = "HP",
	},
	[15] = {
		name = "Superior Healing Potion",
		spellID = 4042,
		itemID = 3928,
		icon = 134833,
		desc = "Restores 700 to 900 health.",
		label = "HP",
	},
	[16] = {
		name = "Major Mana Potion",
		spellID = 17531,
		itemID = 13444,
		icon = 134856,
		desc = "Restores 1350 to 2250 mana.",
		label = "Mana",
	},
	[17] = {
		name = "Superior Mana Potion",
		spellID = 17530,
		itemID = 13443,
		icon = 134854,
		desc = "Restores 900 to 1500 mana.",
		label = "Mana",
	},
	[18] = {
		name = "Major Rejuvenation Potion",
		spellID = 22729,
		itemID = 18253,
		icon = 134827,
		desc = "Restores 1440 to 1760 mana and health.",
		label = "Pot",
	},
	[19] = {
		name = "Combat Mana Potion",
		spellID = 17530,
		itemID = 18841,
		icon = 134861,
		desc = "Restores 900 to 1500 mana.",
		label = "Pot",
	},
	[20] = {
		name = "Combat Healing Potion",
		spellID = 4042,
		itemID = 18839,
		icon = 134819,
		desc = "Restores 700 to 900 health.",
		label = "Pot",
	},
	[21] = {
		name = "Whipper Root Tuber",
		spellID = 15700,
		itemID = 11951,
		icon = 134011,
		desc = "Restores 700 to 900 health.",
		label = "Whip",
	},
};
if (NCH.isSOD) then
	tinsert(NCH.shortPotions, {
        name = "Mildly Irradiated Rejuvenation Potion",
		spellID = 435973,
		itemID = 215162,
        icon = 236870,
        desc = "+50 Attack power, +35 Spell Power",
        label = "dps",
    });
end

NCH.foods = {
	[1] = {
		name = "Runn Tum Tuber Surprise",
		spellID = 22730,
		itemID = 18254,
		icon = 134019,
		desc = "+10 Intelligence",
		label = "Food",
		eatingID = 22731,
	},
	[2] = {
		name = "Grilled Squid",
		spellID = 18192,
		itemID = 13928,
		icon = 133899,
		desc = "+10 Agility",
		label = "Food",
		eatingID = 18230,
		sharedSpellIDs = {24799, 18125}, --Shared Smoked Desert Dumplings/Blessed Sunfruit.
	},
	[3] = {
		name = "Nightfin Soup",
		spellID = 18194,
		itemID = 13931,
		icon = 132804,
		desc = "+8 MP5",
		label = "Food",
		eatingID = 18233,
	},
	[4] = {
		name = "Blessed Sunfruit",
		spellID = 18125,
		itemID = 13810,
		icon = 133997,
		desc = "+10 Strength",
		label = "Food",
		eatingID = 18124,
		sharedSpellIDs = {24799, 18192}, --Shared Smoked Desert Dumplings/Blessed Sunfruit.
	},
	[5] = {
		name = "Blessed Sunfruit Juice",
		spellID = 18141,
		itemID = 13813,
		icon = 132803,
		desc = "+10 Spirit",
		label = "Food",
		eatingID = 18140,
	},
	[6] = {
		name = "Dirge's Kickin' Chimaerok Chops",
		spellID = 25661,
		itemID = 21023,
		icon = 134021,
		desc = "+25 Stamina",
		label = "Food",
		eatingID = 25660,
	},
	[7] = {
		name = "Smoked Desert Dumplings",
		spellID = 24799,
		itemID = 20452,
		icon = 134020,
		desc = "+20 Strength",
		label = "Food",
		eatingID = 24800,
		sharedSpellIDs = {18125, 18192}, --Shared Smoked Desert Dumplings/Blessed Sunfruit.
	},
	[8] = {
		name = "Dragonbreath Chili",
		spellID = 15852,
		itemID = 12217,
		icon = 132804,
		desc = "Melee Fire Damage proc",
		label = "Chilli",
	},
	[9] = {
		name = "Clamlette Surprise",
		spellID = 19710,
		itemID = 16971,
		icon = 134433,
		desc = "+12 Stamina, +15 Spirit",
		label = "Food",
		eatingID = 10256,
	},
	[10] = {
		name = "Heavy Kodo Stew",
		spellID = 19710,
		itemID = 12215,
		icon = 132806,
		desc = "+12 Stamina, +15 Spirit",
		label = "Food",
		eatingID = 10256,
	},
	[11] = {
		name = "Monster Omelet",
		spellID = 19710,
		itemID = 12218,
		icon = 133948,
		desc = "+12 Stamina, +15 Spirit",
		label = "Food",
		eatingID = 10256,
	},
	[12] = {
		name = "Spiced Chili Crab",
		spellID = 19710,
		itemID = 12216,
		icon = 134004,
		desc = "+12 Stamina, +15 Spirit",
		label = "Food",
		eatingID = 10256,
	},
	[13] = {
		name = "Spider Sausage",
		spellID = 19710,
		itemID = 17222,
		icon = 134022,
		desc = "+12 Stamina, +15 Spirit",
		label = "Food",
		eatingID = 10256,
	},
	[14] = {
		name = "Tender Wolf Steak",
		spellID = 19710,
		itemID = 18045,
		icon = 134003,
		desc = "+12 Stamina, +15 Spirit",
		label = "Food",
		eatingID = 10256,
	},
	[15] = {
		name = "Cooked Glossy Mightfish",
		spellID = 18191,
		itemID = 13927,
		icon = 134301,
		desc = "+10 Stamina",
		label = "Food",
		eatingID = 18229,
	},
	[16] = {
		name = "Sagefish Delight",
		spellID = 25941,
		itemID = 21217,
		icon = 133907,
		desc = "+6 MP5",
		label = "Food",
		eatingID = 25691,
	},
	[17] = {
		name = "Elderberry Pie",
		spellID = 29335,
		itemID = 23435,
		icon = 133952,
		desc = "Increases Defense by 13 for 1 hour.",
		label = "Food",
		eatingID = 0,
	},
	--[[[18] = { --Moved to misc.
		name = "Fire-toasted Bun",
		spellID = 29332,
		itemID = 23327,
		icon = 133964,
		desc = "Improves your chance to hit by 2% for 1 hour.",
		label = "Food",
		eatingID = 0,
	},
	[19] = {
		name = "Midsummer Sausage",
		spellID = 29333,
		itemID = 23326,
		icon = 134009,
		desc = "Increases damage done from spells by up to 23 for 1 hour.",
		label = "Food",
		eatingID = 0,
	},
	[20] = {
		name = "Toasted Smorc",
		spellID = 29334,
		itemID = 23211,
		icon = 135267,
		desc = "Increases healing done by magical spells by up to 44 for 1 hour.",
		label = "Food",
		eatingID = 0,
	},]]
	
	--[[[9] = { --Test item.
		name = "Morning Glory Dew",
		spellID = 0,
		itemID = 8766,
		icon = 134712,
		desc = "Test item.",
		label = "Food",
		eatingID = 1137,
	},]]
};
if (NCH.isSOD) then
	tinsert(NCH.foods, {
		name = "Darkclaw Bisque",
		spellID = 470361,
		itemID = 232436,
		icon = 237331,
		desc = "+12 Spell Damage",
		label = "Food",
		eatingID = 470362,
	});
	tinsert(NCH.foods, {
		name = "Smoked Redgill",
		spellID = 470367,
		itemID = 232438,
		icon = 133965,
		desc = "+22 Healing",
		label = "Food",
		eatingID = 470369,
	});
	tinsert(NCH.foods, {
		name = "Prowler Steak",
		spellID = 1225778,
		itemID = 238637,
		icon = 134040,
		desc = "+25 Strength, +10 Stamina",
		label = "Food",
		eatingID = 1225769,
		sharedSpellIDs = {1225782},
	});
	tinsert(NCH.foods, {
		name = "Sunrise Omelette",
		spellID = 1225780,
		itemID = 238639,
		icon = 133991,
		desc = "+29 Spell Power, +55 Healing, +10 Stamina",
		label = "Food",
		eatingID = 1225772,
		sharedSpellIDs = {1225782},
		test = true,
	});
	tinsert(NCH.foods, {
		name = "Filet o' Flank",
		spellID = 1225779,
		itemID = 238638,
		icon = 134044,
		desc = "+25 Agility, +10 Stamina",
		label = "Food",
		eatingID = 1225771,
		sharedSpellIDs = {1225782},
	});
end
 
NCH.foods2 = {
	[1] = {
		name = "Dragonbreath Chili",
		spellID = 15852,
		itemID = 12217,
		icon = 132804,
		desc = "Melee Fire Damage proc",
		label = "Chilli",
	},
};

NCH.tempEnchants = {
	[1] = {
		name = "Brilliant Wizard Oil",
		enchantID = 2628,
		itemID = 20749,
		icon = 134727,
		desc = "Increases spell damage by up to 36 and increases spell critical chance by 1%.",
		label = "Weap",
		weaponSlot = "both",
	},
	[2] = {
		name = "Brilliant Mana Oil",
		enchantID = 2629,
		itemID = 20748,
		icon = 134722,
		desc = "Restores 12 mana to the caster every 5 seconds and increases the effect of healing spells by up to 25.",
		label = "Weap",
		weaponSlot = "both",
	},
	[3] = {
		name = "Blessed Wizard Oil",
		enchantID = 2685,
		itemID = 23123,
		icon = 134806,
		desc = "Increases spell damage against undead by up to 60.",
		label = "Weap",
		weaponSlot = "both",
	},
	[4] = {
		name = "Consecrated Sharpening Stone",
		enchantID = 2684,
		itemID = 23122,
		icon = 135249,
		desc = "Increases attack power against undead by 100.",
		label = "Weap",
		weaponSlot = "both",
	},
	[5] = {
		name = "Dense Sharpening Stone",
		enchantID = 1643,
		itemID = 12404,
		icon = 135252,
		desc = "Increase sharp weapon damage by 8.",
		label = "Weap",
		weaponSlot = "both",
	},
	[6] = {
		name = "Dense Weightstone",
		enchantID = 1703,
		itemID = 12643,
		icon = 135259,
		desc = "Increase the damage of a blunt weapon by 8.",
		label = "Weap",
		weaponSlot = "both",
	},
	[7] = {
		name = "Elemental Sharpening Stone",
		enchantID = 2506,
		itemID = 18262,
		icon = 135228,
		desc = "Increase critical chance on a melee weapon by 2%.",
		label = "Weap",
		weaponSlot = "both",
	},
	[8] = {
		name = "Frost Oil",
		enchantID = 26,
		itemID = 3829,
		icon = 134800,
		desc = "10% chance of casting Frostbolt at the opponent when it hits.",
		label = "Weap",
		weaponSlot = "both",
	},
	[9] = {
		name = "Shadow Oil",
		enchantID = 25,
		itemID = 3824,
		icon = 134803,
		desc = "15% chance of casting Shadow Bolt (Rank 3) at the opponent when it hits.",
		label = "Weap",
		weaponSlot = "both",
	},
	[10] = {
		name = "Wizard Oil",
		enchantID = 2627,
		itemID = 20750,
		icon = 134726,
		desc = "Increases spell damage by up to 24.",
		label = "Weap",
		weaponSlot = "both",
	},
	[11] = {
		name = "Lesser Mana Oil",
		enchantID = 2625,
		itemID = 20747,
		icon = 134879,
		desc = "Restores 8 mana to the caster every 5 seconds.",
		label = "Weap",
		weaponSlot = "both",
	},
};

if (NCH.class == "ROGUE") then
	if (NCH.isSOD) then
		tinsert(NCH.tempEnchants, {
			name = "Sebacious Poison",
			enchantID = 7254,
			itemID = 217345,
			icon = 132108,
			desc = "Each strike has a 30% chance of poisoning the enemy, reducing the enemy's armor by 1700 for 15 sec.",
			label = "Weap",
			weaponSlot = "both",
			noDisable = true,
		});
		tinsert(NCH.tempEnchants, {
			name = "Atrophic Poison",
			enchantID = 7256,
			itemID = 217347,
			icon = 132100,
			desc = "Each strike has a 30% chance of poisoning the enemy, reducing the enemy's melee attack power by 205 for 15 sec.",
			label = "Weap",
			weaponSlot = "both",
			noDisable = true,
		});
		tinsert(NCH.tempEnchants, {
			name = "Numbing Poison",
			enchantID = 7255,
			itemID = 217346,
			icon = 132098,
			desc = "Each strike has a 30% chance of poisoning the enemy, increasing the time between the enemy's melee attacks by 20% for 15 sec.",
			label = "Weap",
			weaponSlot = "both",
			noDisable = true,
		});
		tinsert(NCH.tempEnchants, {
			name = "Occult Poison I",
			enchantID = 7542,
			itemID = 226374,
			icon = 135935,
			desc = "Each strike has a 30% chance of poisoning the enemy for 108 Nature damage over 12 sec and causing the enemy to take 4% increased Arcane, Fire, Frost, Nature, and Shadow damage. Stacks 5 times.",
			label = "Weap",
			weaponSlot = "both",
			noDisable = true,
		});
		tinsert(NCH.tempEnchants, {
			name = "Occult Poison II",
			enchantID = 7651,
			itemID = 234444,
			icon = 135935,
			desc = "Each strike has a 30% chance of poisoning the enemy for 136 Nature damage over 12 sec and causing the enemy to take 4% increased Arcane, Fire, Frost, Nature, and Shadow damage. Stacks 5 times.",
			label = "Weap",
			weaponSlot = "both",
			noDisable = true,
		});
	end
	tinsert(NCH.tempEnchants, {
		name = "Wound Poison IV",
		enchantID = 706,
		itemID = 10922,
		icon = 134197,
		desc = "Each strike has a 30% chance of poisoning the enemy, causing 53 Nature damage and reducing all healing effects used on them by 10% for 15 sec.",
		label = "Weap",
		weaponSlot = "both",
		noDisable = true,
	});
	tinsert(NCH.tempEnchants, {
		name = "Mind-numbing Poison III",
		enchantID = 643,
		itemID = 9186,
		icon = 136066,
		desc = "Each strike has a 20% chance of poisoning the enemy, increasing their casting time by 60% for 14 sec.",
		label = "Weap",
		weaponSlot = "both",
		noDisable = true,
	});
	tinsert(NCH.tempEnchants, {
		name = "Instant Poison VI",
		enchantID = 625,
		itemID = 8928,
		icon = 132273,
		desc = "Each strike has a 20% chance of poisoning the enemy which instantly inflicts 112 to 148 Nature damage.",
		label = "Weap",
		weaponSlot = "both",
		noDisable = true,
	});
	tinsert(NCH.tempEnchants, {
		name = "Crippling Poison II",
		enchantID = 603,
		itemID = 3776,
		icon = 134799,
		desc = "Each strike has a 30% chance of poisoning the enemy, slowing their movement speed by 70% for 12 sec.",
		label = "Weap",
		weaponSlot = "both",
		noDisable = true,
	});
	tinsert(NCH.tempEnchants, {
		name = "Deadly Poison V",
		enchantID = 2630,
		itemID = 20844,
		icon = 132290,
		desc = "Each strike has a 30% chance of poisoning the enemy for 136 Nature damage over 12 sec.  Stacks up to 5 times on a single target.",
		label = "Weap",
		weaponSlot = "both",
		noDisable = true,
	});
end

if (NCH.class == "SHAMAN") then
	if (NCH.isSOD) then
		--SoD 1h buffs.
		tinsert(NCH.tempEnchants, {
			name = "Flametongue Weapon 6",
			enchantID = 7567,
			spellID = 461634,
			icon = 135814,
			desc = "Each hit causes 40 to 124 additional Fire damage, based on the speed of the weapon.",
			label = "Weap",
			weaponSlot = "both",
			noItemUseSpell = true,
			noDisable = true,
		});
		tinsert(NCH.tempEnchants, {
			name = "Frostbrand Weapon 5",
			enchantID = 7566,
			spellID = 461633,
			icon = 135847,
			desc = "Each hit has a chance of causing 215 additional Frost damage and slowing the target's movement speed by 25% for 8 sec.",
			label = "Weap",
			weaponSlot = "both",
			noItemUseSpell = true,
			noDisable = true,
		});
		tinsert(NCH.tempEnchants, {
			name = "Rockbiter Weapon 7",
			enchantID = 7568,
			spellID = 461635,
			icon = 136086,
			desc = "Increase weapon damage per second by 40.",
			label = "Weap",
			weaponSlot = "both",
			noItemUseSpell = true,
			noDisable = true,
		});
		tinsert(NCH.tempEnchants, {
			name = "Windfury Weapon 4",
			enchantID = 7569,
			spellID = 461636,
			icon = 136018,
			desc = "Each hit has a 20% chance of dealing additional damage equal to two extra attacks with 433 extra attack power.",
			label = "Weap",
			weaponSlot = "both",
			noItemUseSpell = true,
			noDisable = true,
		});
	else
		tinsert(NCH.tempEnchants, {
			name = "Flametongue Weapon 6",
			enchantID = 1666,
			spellID = 16342,
			icon = 135814,
			desc = "Each hit causes 40 to 124 additional Fire damage, based on the speed of the weapon.",
			label = "Weap",
			weaponSlot = "both",
			noItemUseSpell = true,
			noDisable = true,
		});
		tinsert(NCH.tempEnchants, {
			name = "Frostbrand Weapon 5",
			enchantID = 1668,
			spellID = 16356,
			icon = 135847,
			desc = "Each hit has a chance of causing 215 additional Frost damage and slowing the target's movement speed by 25% for 8 sec.",
			label = "Weap",
			weaponSlot = "both",
			noItemUseSpell = true,
			noDisable = true,
		});
		tinsert(NCH.tempEnchants, {
			name = "Rockbiter Weapon 7",
			enchantID = 1664,
			spellID = 16316,
			icon = 136086,
			desc = "Increase weapon damage per second by 40.",
			label = "Weap",
			weaponSlot = "both",
			noItemUseSpell = true,
			noDisable = true,
		});
		tinsert(NCH.tempEnchants, {
			name = "Windfury Weapon 4",
			enchantID = 1669,
			spellID = 16362,
			icon = 136018,
			desc = "Each hit has a 20% chance of dealing additional damage equal to two extra attacks with 433 extra attack power.",
			label = "Weap",
			weaponSlot = "both",
			noItemUseSpell = true,
			noDisable = true,
		});
	end
end

if (NCH.isSOD) then
	tinsert(NCH.tempEnchants, {
		name = "Conductive Shield Coating",
		enchantID = 7602,
		itemID = 228980,
		icon = 134722,
		desc = "While applied to target shield it increases spell damage and healing by up to 24.",
		label = "Weap",
		weaponSlot = "offhand",
	});
	tinsert(NCH.tempEnchants, {
		name = "Enchanted Repellent",
		enchantID = 7650,
		itemID = 233996,
		icon = 134723,
		desc = "While applied to target weapon or shield it increases spell damage by up to 45 and increases Spell Critical chance by 1%.",
		label = "Weap",
		weaponSlot = "both",
	});
	tinsert(NCH.tempEnchants, {
		name = "Magnificent Trollshine",
		enchantID = 7644,
		itemID = 232611,
		icon = 134876,
		desc = "While applied to target weapon or shield it increases spell damage by up to 3645 and increases Spell Critical chance by 1%.",
		label = "Weap",
		weaponSlot = "offhand",
	});
	--New IDs added in sod phase 7.
	--Override here.
	NCH.tempEnchants[3] = {
		name = "Blessed Wizard Oil",
		enchantID = 2685,
		itemID = 238234,
		icon = 134806,
		desc = "Increases spell damage against undead by up to 60.",
		label = "Weap",
		weaponSlot = "both", --Both hands in SoD version (shield).
	};
	NCH.tempEnchants[4] = {
		name = "Consecrated Sharpening Stone",
		enchantID = 2684,
		itemID = 238241,
		icon = 135249,
		desc = "Increases attack power against undead by 100.",
		label = "Weap",
		weaponSlot = "both",
	};
	tinsert(NCH.tempEnchants, { --SoD only 2h weapon.
		name = "Weighted Consecrated Sharpening Stone",
		enchantID = 7896,
		itemID = 237810,
		icon = 135248,
		desc = "Increases attack power against undead by 200.",
		label = "Weap",
		weaponSlot = "mainhand",
	});
end

NCH.scrolls = {
	[1] = {
		spellID = 8117,
		name = "Scroll of Agility III",
		desc = "+13 Agility",
		itemID = 4425,
		icon = 134938,
		label = "Scroll",
	},
	[2] = {
		spellID = 12174,
		name = "Scroll of Agility IV",
		desc = "+17 Agility",
		itemID = 10309,
		icon = 134938,
		label = "Scroll",
	},
	[3] = {
		spellID = 8120,
		name = "Scroll of Strength III",
		desc = "+13 Strength",
		itemID = 4426,
		icon = 134938,
		label = "Scroll",
	},
	[4] = {
		spellID = 12179,
		name = "Scroll of Strength IV",
		desc = "+17 Strength",
		itemID = 10310,
		icon = 134938,
		label = "Scroll",
	},
	[5] = {
		spellID = 8095,
		name = "Scroll of Protection III",
		desc = "+180 Armor",
		itemID = 4421,
		icon = 134943,
		label = "Scroll",
	},
	[6] = {
		spellID = 12175,
		name = "Scroll of Protection IV",
		desc = "+240 Armor",
		itemID = 10305,
		icon = 134943,
		label = "Scroll",
	},
	[7] = {
		spellID = 8098,
		name = "Scroll of Intellect III",
		desc = "+12 Intellect",
		itemID = 4419,
		icon = 134937,
		label = "Scroll",
	},
	[8] = {
		spellID = 12176,
		name = "Scroll of Intellect IV",
		desc = "+16 Intellect",
		itemID = 10308,
		icon = 134937,
		label = "Scroll",
	},
	[9] = {
		spellID = 8114,
		name = "Scroll of Spirit III",
		desc = "+11 Spirit",
		itemID = 4424,
		icon = 134937,
		label = "Scroll",
	},
	[10] = {
		spellID = 12177,
		name = "Scroll of Spirit IV",
		desc = "+15 Spirit",
		itemID = 10306,
		icon = 134937,
		label = "Scroll",
	},
	[11] = {
		spellID = 8101,
		name = "Scroll of Stamina III",
		desc = "+12 Stamina",
		itemID = 4422,
		icon = 134943,
		label = "Scroll",
	},
	[12] = {
		spellID = 12178,
		name = "Scroll of Stamina IV",
		desc = "+16 Stamina",
		itemID = 10307,
		icon = 134943,
		label = "Scroll",
	},
};

NCH.misc = {
	[1] = {
		name = "Gizzard Gum",
		spellID = 10693,
		itemID = 8424,
		icon = 133986,
		desc = "+25 Spirit",
		label = "Pot",
		unique = true,
		sharedSpellIDs = {24382, 24383, 24417, 10693, 10669, 10667, 10668, 10692}, --Zanzas/blasted lands buffs are shared.
	},
	[2] = {
		name = "Ground Scorpok Assay",
		spellID = 10669,
		itemID = 8412,
		icon = 133849,
		desc = "+25 Agility",
		label = "Pot",
		unique = true,
		sharedSpellIDs = {24382, 24383, 24417, 10693, 10669, 10667, 10668, 10692}, --Zanzas/blasted lands buffs are shared.
	},
	[3] = {
		name = "R.O.I.D.S.",
		spellID = 10667,
		itemID = 8410,
		icon = 135241,
		desc = "+25 Strength",
		label = "Pot",
		unique = true,
		sharedSpellIDs = {24382, 24383, 24417, 10693, 10669, 10667, 10668, 10692}, --Zanzas/blasted lands buffs are shared.
	},
	[4] = {
		name = "Lung Juice Cocktail",
		spellID = 10668,
		itemID = 8411,
		icon = 132799,
		desc = "+25 Stamina",
		label = "Pot",
		unique = true,
		sharedSpellIDs = {24382, 24383, 24417, 10693, 10669, 10667, 10668, 10692}, --Zanzas/blasted lands buffs are shared.
	},
	[5] = {
		name = "Cerebral Cortex Compound",
		spellID = 10692,
		itemID = 8423,
		icon = 134812,
		desc = "+25 Intellect",
		label = "Pot",
		unique = true,
		sharedSpellIDs = {24382, 24383, 24417, 10693, 10669, 10667, 10668, 10692}, --Zanzas/blasted lands buffs are shared.
	},
	[6] = {
		name = "Kreeg's Stout Beatdown",
		spellID = 22790,
		itemID = 18284,
		icon = 132792,
		desc = "25 Spirit and -5 Intellect",
		label = "Alc",
	},
	[7] = {
		name = "Gordok Green Grog",
		spellID = 22789,
		itemID = 18269,
		icon = 132790,
		desc = "10 Stamina",
		label = "Alc",
	},
	[8] = {
		name = "Rumsey Rum Black Label",
		spellID = 25804,
		itemID = 21151,
		icon = 132791,
		desc = "+15 Stamina",
		label = "Alc",
	},
	[9] = {
		name = "Gift of Arthas",
		spellID = 11371,
		itemID = 9088,
		icon = 134808,
		desc = "Increases shadow resist by 10 and may disease attackers.",
		label = "Arth",
	},
	[10] = {
		name = "Spirit of Zanza",
		spellID = 24382,
		itemID = 20079,
		icon = 134810,
		desc = "Increases the player's Spirit by 50 and Stamina by 50 for 2 hrs.",
		label = "Zan",
		unique = true,
		sharedSpellIDs = {24382, 24383, 24417, 10693, 10669, 10667, 10668, 10692}, --Zanzas/blasted lands buffs are shared.
	},
	[11] = {
		name = "Swiftness of Zanza",
		spellID = 24383,
		itemID = 20081,
		icon = 134811,
		desc = "Increases the player's run speed by 20% for 2 hrs.",
		label = "Zan",
		unique = true,
		sharedSpellIDs = {24382, 24383, 24417, 10693, 10669, 10667, 10668, 10692}, --Zanzas/blasted lands buffs are shared.
	},
	[12] = {
		name = "Sheen of Zanza",
		spellID = 24417,
		itemID = 20080,
		icon = 134809,
		desc = "Increases the chance that the player will reflect hostile spells cast on them by 3% for 2 hrs.",
		label = "Zan",
		unique = true,
		sharedSpellIDs = {24382, 24383, 24417, 10693, 10669, 10667, 10668, 10692}, --Zanzas/blasted lands buffs are shared.
	},
	[13] = {
		name = "Choc: Dark Desire",
		spellID = 27723,
		itemID = 22237,
		icon = 135460,
		desc = "Improves your chance to hit by 2% for 1 hour.",
		sharedSpellIDs = {29332}, --Fire-toasted Bun.
		label = "Choc",
	},
	[14] = {
		name = "Choc: Very Berry Cream",
		spellID = 27721,
		itemID = 22238,
		icon = 135458,
		desc = "Increases damage done from spells by up to 23 for 1 hour.",
		sharedSpellIDs = {29333}, --Midsummer Sausage.
		label = "Choc",
	},
	[15] = {
		name = "Choc: Buttermilk Delight",
		spellID = 27720,
		itemID = 22236,
		icon = 135457,
		desc = "Increases Defense by 13 for 1 hour.",
		sharedSpellIDs = {29335}, --Elderberry Pie.
		label = "Choc",
	},
	[16] = {
		name = "Choc: Sweet Surprise",
		spellID = 27722,
		itemID = 22239,
		icon = 135459,
		desc = "Increases healing done by magical spells by up to 44 for 1 hour.",
		sharedSpellIDs = {29334}, --Toasted Smorc.
		label = "Choc",
	},
	[17] = {
		name = "Bogling Root",
		spellID = 5665,
		itemID = 5206,
		icon = 134187,
		desc = "Increases physical damage by 1 for 10 min.",
		label = "Bog",
	},
	[18] = {
		name = "Greater Mark of the Dawn",
		spellID = 30090,
		itemID = 23196,
		icon = 134501,
		desc = "+31 Stamina for 1 hour",
		label = "Nax",
		unique = true,
	},
	[19] = {
		name = "Goblin Sapper Charge",
		spellID = 13241,
		itemID = 10646,
		icon = 135826,
		desc = "Explodes when triggered dealing 450 to 750 Fire damage to all enemies nearby and 375 to 625 damage to you.",
		label = "Sap",
	},
	[20] = {
		name = "Dense Dynamite",
		spellID = 23063,
		itemID = 18641,
		icon = 133714,
		desc = "Inflicts 340 to 460 Fire damage in a 5 yard radius.",
		label = "Dyn",
	},
	[21] = {
		name = "Fire-toasted Bun",
		spellID = 29332,
		itemID = 23327,
		icon = 133964,
		desc = "Improves your chance to hit by 2% for 1 hour.",
		sharedSpellIDs = {27723}, --Choc: Dark Desire.
		label = "Food",
		eatingID = 0,
	},
	[22] = {
		name = "Midsummer Sausage",
		spellID = 29333,
		itemID = 23326,
		icon = 134009,
		desc = "Increases damage done from spells by up to 23 for 1 hour.",
		sharedSpellIDs = {27721}, --Choc: Very Berry Cream.
		label = "Food",
		eatingID = 0,
	},
	[23] = {
		name = "Toasted Smorc",
		spellID = 29334,
		itemID = 23211,
		icon = 135267,
		desc = "Increases healing done by magical spells by up to 44 for 1 hour.",
		sharedSpellIDs = {27722}, --Choc: Sweet Surprise.
		label = "Food",
		eatingID = 0,
	},
	[24] = {
		name = "Elderberry Pie",
		spellID = 29335,
		itemID = 23435,
		icon = 133952,
		desc = "Increases Defense by 13 for 1 hour.",
		sharedSpellIDs = {27720}, --Choc: Buttermilk Delight.
		label = "Food",
		eatingID = 0,
	},
	[25] = {
		name = "Dark Rune",
		spellID = 27869,
		itemID = 20520,
		icon = 136192,
		desc = "Restores 900 to 1500 mana at the cost of 600 to 1000 life.",
		label = "Rune",
	},
	[26] = {
		name = "Demonic Rune",
		spellID = 16666,
		itemID = 12662,
		icon = 134417,
		desc = "Restores 900 to 1500 mana at the cost of 600 to 1000 life.",
		label = "Rune",
	},
	[27] = {
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
		icon = 132819,
		desc = "Instantly restores 100 energy.",
		label = "Tea",
		noBuff = true,
	});
end

if (NCH.isSOD) then
	if (NCH.class == "HUNTER") then
		tinsert(NCH.misc, {
			name = "Draught of the Sands",
			spellID = 1217084,
			itemID = 235497,
			icon = 133214,
			desc = "Increases all damage caused against targets in Silithus and Ahn'Qiraj by 3% and increases critical damage caused against targets in Silithus and Ahn'Qiraj by an additional 3%.",
			label = "Hunt",
		});
	elseif (NCH.class == "ROGUE") then
		tinsert(NCH.misc, {
			name = "Draught of the Sands",
			spellID = 1218485,
			itemID = 235825,
			icon = 133214,
			desc = "Increases all damage caused against targets in Silithus and Ahn'Qiraj by 2% and increases critical damage caused against targets in Silithus and Ahn'Qiraj by an additional 2%.",
			label = "Rog",
		});
	end
	tinsert(NCH.misc, {
		name = "Elixir of Coalesced Regret",
		spellID = 426606,
		itemID = 210708,
		icon = 134799,
		desc = "+1 all stats",
		label = "+2",
	});
	tinsert(NCH.misc, {
		name = "Scroll: Wrath of the Swarm",
		spellID = 1214001,
		itemID = 233995,
		icon = 237449,
		desc = "+40 Spell Power/Attack Power",
		label = "Ench",
	});
	tinsert(NCH.misc, {
		name = "Enchanted Sigil: Living Dreams",
		spellID = 446240,
		itemID = 221028,
		icon = 254882,
		desc = "+30 Spell Power/Attack Power",
		label = "Ench",
	});
	tinsert(NCH.misc, {
		name = "Enchanted Sigil: Flowing Waters",
		spellID = 463864,
		itemID = 228978,
		icon = 254883,
		desc = "+30 Spell Power/Attack Power",
		label = "Ench",
	});
	tinsert(NCH.misc, {
		name = "Warmed Rumsey Rum with Cream",
		spellID = 460332,
		itemID = 227286,
		icon = 132790,
		desc = "Increases Stamina by 30 for 45 min",
		label = "Alc",
	});
	tinsert(NCH.misc, {
		name = "The Fumigator",
		spellID = 1213935,
		itemID = 233985,
		icon = 135800,
		desc = "Explodes when triggered dealing 650 to 950 Fire damage to all enemies nearby and 475 to 725 damage to you.",
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
	[1] = {
		name = "Greater Arcane Protection Potion",
		spellID = 17549,
		itemID = 13461,
		icon = 134863,
		desc = "Absorbs 1950 to 3250 arcane damage. Last 1 hour.",
		label = "Arc",
		type = "GreaterArcane",
		school = 64,
		minAbsorb = 1950,
		maxAbsorb = 3250,
	},
	[2] = {
		name = "Greater Fire Protection Potion",
		spellID = 17543,
		icon = 134804,
		desc = "Absorbs 1950 to 3250 fire damage. Last 1 hour.",
		itemID = 13457,
		label = "Fire",
		type = "GreaterFire",
		school = 4,
		minAbsorb = 1950,
		maxAbsorb = 3250,
	},
	[3] = {
		name = "Greater Frost Protection Potion",
		spellID = 17544,
		itemID = 13456,
		icon = 134800,
		desc = "Absorbs 1950 to 3250 frost damage. Last 1 hour.",
		label = "Fros",
		type = "GreaterFrost",
		school = 16,
		minAbsorb = 1950,
		maxAbsorb = 3250,
	},
	[4] = {
		name = "Greater Nature Protection Potion",
		spellID = 17546,
		itemID = 13458,
		icon = 134802,
		desc = "Absorbs 1950 to 3250 nature damage. Last 1 hour.",
		label = "Nat",
		type = "GreaterNature",
		school = 8,
		minAbsorb = 1950,
		maxAbsorb = 3250,
	},
	[5] = {
		name = "Greater Shadow Protection Potion",
		spellID = 17548,
		itemID = 13459,
		icon = 134803,
		desc = "Absorbs 1950 to 3250 shadow damage.  Last 1 hour.",
		label = "Sha",
		type = "GreaterShadow",
		school = 32,
		minAbsorb = 1950,
		maxAbsorb = 3250,
	},
	[6] = { --Recipe 
		name = "Greater Holy Protection Potion",
		spellID = 17545,
		itemID = 13460,
		icon = 134720,
		desc = "Absorbs 1950 to 3250 holy damage. Last 1 hour.",
		label = "Holy",
		type = "GreaterHoly",
		school = 2,
		minAbsorb = 1950,
		maxAbsorb = 3250,
	},
	[7] = {
		name = "Fire Protection Potion",
		spellID = 7233,
		itemID = 6049,
		icon = 134787,
		desc = "Absorbs 975 to 1625 fire damage. Last 1 hour.",
		label = "Fire",
		type = "Fire",
		school = 4,
		minAbsorb = 975,
		maxAbsorb = 1625,
	},
	[8] = {
		name = "Frost Protection Potion",
		spellID = 7239,
		itemID = 6050,
		icon = 134754,
		desc = "Absorbs 1350 to 2250 frost damage. Last 1 hour.",
		label = "Fros",
		type = "Frost",
		school = 16,
		minAbsorb = 1350,
		maxAbsorb = 2250,
	},
	[9] = {
		name = "Nature Protection Potion",
		spellID = 7254,
		itemID = 6052,
		icon = 134717,
		desc = "Absorbs 1350 to 2250 nature damage. Last 1 hour.",
		label = "Nat",
		type = "Nature",
		school = 8,
		minAbsorb = 1350,
		maxAbsorb = 2250,
	},
	[10] = {
		name = "Shadow Protection Potion",
		spellID = 7242,
		itemID = 6048,
		icon = 134824,
		desc = "Absorbs 675 to 1125 shadow damage.  Last 1 hour.",
		label = "Sha",
		type = "Shadow",
		school = 32,
		minAbsorb = 625,
		maxAbsorb = 1125,
	},
	[11] = {
		name = "Holy Protection Potion",
		spellID = 7245,
		itemID = 6051,
		icon = 134720,
		desc = "Absorbs 300 to 500 holy damage. Last 1 hour.",
		label = "Holy",
		type = "Holy",
		school = 2,
		minAbsorb = 300,
		maxAbsorb = 500,
	},
	[12] = {
		name = "Frozen Rune",
		spellID = 29432,
		itemID = 22682,
		icon = 134422,
		desc = "Absorbs 1500 to 2500 fire damage. Last 1 hour.",
		label = "Rune",
		type = "FrozenRune",
		school = 4,
		minAbsorb = 1500,
		maxAbsorb = 2500,
	},
};
if (NCH.isSOD) then
	NCH.protectionPots[12] = {
		name = "Frozen Rune",
		spellID = 1220538,
		itemID = 236656,
		icon = 134422,
		desc = "Absorbs 1500 to 2500 fire damage. Last 1 hour.",
		label = "Rune",
		type = "FrozenRune",
		school = 4,
		minAbsorb = 3500,
		maxAbsorb = 4500,
	};
else
	NCH.protectionPots[12] = {
		name = "Frozen Rune",
		spellID = 29432,
		itemID = 22682,
		icon = 134422,
		desc = "Absorbs 1500 to 2500 fire damage. Last 1 hour.",
		label = "Rune",
		type = "FrozenRune",
		school = 4,
		minAbsorb = 1500,
		maxAbsorb = 2500,
	};
end

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