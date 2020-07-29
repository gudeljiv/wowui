
SkilletDB = {
	["char"] = {
		["Mxzq - Golemagg"] = {
			["include_alts"] = false,
		},
	},
	["global"] = {
		["customVersion"] = 1,
		["MissingVendorItems"] = {
			[52188] = "Jeweler's Setting",
			[38682] = "Enchanting Vellum",
			[3857] = "Coal",
			[30817] = "Simple Flour",
			[4539] = "Goldenbark Apple",
			[4399] = "Wooden Stock",
			[17035] = "Stranglethorn Seed",
			[17034] = "Maple Seed",
		},
		["itemRecipeSource"] = {
			[2840] = {
				["Smelt Copper"] = true,
			},
			[3576] = {
				["Smelt Tin"] = true,
			},
			[2842] = {
				["Smelt Silver"] = true,
			},
			[3575] = {
				["Smelt Iron"] = true,
			},
			[2841] = {
				["Smelt Bronze"] = true,
			},
		},
		["locale"] = "enUS",
		["recipeDB"] = {
			["Smelt Tin"] = "2575 3576 2771:1 Forge",
			["Smelt Bronze"] = "2575 2841:2 2840:1:3576:1 Forge",
			["Smelt Iron"] = "2575 3575 2772:1 Forge",
			["Smelt Silver"] = "2575 2842 2775:1 Forge",
			["Smelt Copper"] = "2575 2840 2770:1 Forge",
		},
		["recipeVersion"] = 3,
		["wowBuild"] = "35186",
		["wowVersion"] = 11305,
		["queueVersion"] = 1,
		["dataVersion"] = 5,
		["itemRecipeUsedIn"] = {
			[2840] = {
				["Smelt Bronze"] = true,
			},
			[3576] = {
				["Smelt Bronze"] = true,
			},
			[2772] = {
				["Smelt Iron"] = true,
			},
			[2775] = {
				["Smelt Silver"] = true,
			},
			[2770] = {
				["Smelt Copper"] = true,
			},
			[2771] = {
				["Smelt Tin"] = true,
			},
		},
	},
	["profiles"] = {
		["Mxzq - Golemagg"] = {
			["shoppingListLocation_point"] = "CENTER",
			["plugins"] = {
				["ATL"] = {
					["buyFactor"] = 4,
					["markup"] = 1.05,
					["enabled"] = true,
				},
				["BBG"] = {
					["enabled"] = true,
				},
				["MTSL"] = {
					["enabled"] = false,
				},
				["ATR"] = {
					["buyFactor"] = 4,
					["markup"] = 1.05,
					["enabled"] = true,
				},
				["AUC"] = {
					["buyFactor"] = 4,
					["markup"] = 1.05,
					["enabled"] = true,
				},
				["AHDB"] = {
					["buyFactor"] = 4,
					["markup"] = 1.05,
					["enabled"] = true,
				},
				["beancounter"] = {
					["enabled"] = true,
					["days"] = 30,
				},
			},
			["tradeSkillLocation_x"] = 181.063690185547,
			["tradeSkillLocation_point"] = "TOP",
			["tradeSkillLocation_y"] = -82.304443359375,
			["transparency"] = 0.95,
			["tradeSkillLocation_scale"] = 1,
			["FixBugs"] = true,
			["standaloneQueueLocation_x"] = -280.833190917969,
			["WarnLog"] = true,
			["ignoreListLocation_x"] = 136.170593261719,
			["ignoreListLocation_scale"] = 1,
			["ignoreListLocation_y"] = 93.6171569824219,
			["standaloneQueueLocation_point"] = "BOTTOM",
			["ignoreListLocation_point"] = "CENTER",
			["shoppingListLocation_x"] = 158.235656738281,
			["shoppingListLocation_scale"] = 1,
			["standaloneQueueLocation_y"] = 247.500411987305,
			["enhanced_recipe_display"] = true,
			["shoppingListLocation_y"] = 157.881286621094,
			["standaloneQueueLocation_scale"] = 1,
		},
		["Mxyz - Golemagg"] = {
			["plugins"] = {
				["beancounter"] = {
					["enabled"] = true,
					["days"] = 30,
				},
				["BBG"] = {
					["enabled"] = true,
				},
				["MTSL"] = {
					["enabled"] = false,
				},
				["ATR"] = {
					["buyFactor"] = 4,
					["markup"] = 1.05,
					["enabled"] = true,
				},
				["ATL"] = {
					["buyFactor"] = 4,
					["markup"] = 1.05,
					["enabled"] = true,
				},
				["AHDB"] = {
					["buyFactor"] = 4,
					["markup"] = 1.05,
					["enabled"] = true,
				},
				["AUC"] = {
					["buyFactor"] = 4,
					["markup"] = 1.05,
					["enabled"] = true,
				},
			},
			["FixBugs"] = true,
			["WarnLog"] = true,
		},
		["Mxyzptlk - Golemagg"] = {
			["plugins"] = {
				["AUC"] = {
					["buyFactor"] = 4,
					["markup"] = 1.05,
					["enabled"] = true,
				},
				["BBG"] = {
					["enabled"] = true,
				},
				["MTSL"] = {
					["enabled"] = false,
				},
				["ATR"] = {
					["buyFactor"] = 4,
					["markup"] = 1.05,
					["enabled"] = true,
				},
				["beancounter"] = {
					["enabled"] = true,
					["days"] = 30,
				},
				["AHDB"] = {
					["buyFactor"] = 4,
					["markup"] = 1.05,
					["enabled"] = true,
				},
				["ATL"] = {
					["buyFactor"] = 4,
					["markup"] = 1.05,
					["enabled"] = true,
				},
			},
			["FixBugs"] = true,
			["WarnLog"] = true,
		},
	},
	["profileKeys"] = {
		["Mxzq - Golemagg"] = "Mxzq - Golemagg",
		["Mxyz - Golemagg"] = "Mxyz - Golemagg",
		["Mxyzptlk - Golemagg"] = "Mxyzptlk - Golemagg",
	},
	["realm"] = {
		["Golemagg"] = {
			["skillDB"] = {
				["Mxyz"] = {
				},
				["Mxzq"] = {
					[2575] = {
						"header Trade Goods", -- [1]
						"tSmelt Iron", -- [2]
						"tSmelt Bronze", -- [3]
						"tSmelt Tin", -- [4]
						"tSmelt Copper", -- [5]
						"tSmelt Silver", -- [6]
					},
				},
				["Mxyzptlk"] = {
				},
			},
			["bagData"] = {
				["Mxyz"] = {
					[6948] = 1,
				},
				["Mxzq"] = {
					[2836] = 8,
					[2775] = 3,
					[6948] = 1,
					[20558] = 3,
					[1708] = 40,
					[2771] = 16,
					[11967] = 1,
					[3355] = 4,
					[2840] = 35,
					[14133] = 1,
					[3771] = 59,
					[2450] = 2,
					[3356] = 11,
					[3030] = 2642,
					[2901] = 1,
					[929] = 7,
				},
				["Mxyzptlk"] = {
				},
			},
			["invSlot"] = {
				["Mxyz"] = {
				},
				["Mxzq"] = {
					[2575] = {
						[2840] = "",
						[2841] = "",
						["name"] = {
							[""] = 5,
						},
						[3575] = "",
						["selected"] = "None",
						[3576] = "",
						[2842] = "",
					},
				},
				["Mxyzptlk"] = {
				},
			},
			["auctionData"] = {
				["Mxyz"] = {
					[10978] = 1,
					[11138] = 1,
					[10998] = 1,
					[11135] = 21,
					[11083] = 2,
				},
				["Mxzq"] = {
					[14571] = 1,
					[3575] = 80,
					[2836] = 35,
				},
				["Mxyzptlk"] = {
				},
			},
			["reagentsInQueue"] = {
				["Mxyz"] = {
				},
				["Mxzq"] = {
				},
				["Mxyzptlk"] = {
				},
			},
			["tradeSkills"] = {
				["Mxyz"] = {
				},
				["Mxzq"] = {
					[2575] = {
						["maxRank"] = 225,
						["isCraft"] = false,
						["name"] = "Mining",
						["rank"] = 141,
					},
					[2656] = {
						["maxRank"] = 225,
						["isCraft"] = false,
						["name"] = "Smelting (Mining)",
						["rank"] = 141,
					},
				},
				["Mxyzptlk"] = {
				},
			},
			["queueData"] = {
				["Mxyz"] = {
				},
				["Mxzq"] = {
				},
				["Mxyzptlk"] = {
				},
			},
			["subClass"] = {
				["Mxyz"] = {
				},
				["Mxzq"] = {
					[2575] = {
						[2840] = "Trade Goods",
						[2841] = "Trade Goods",
						["name"] = {
							["Trade Goods"] = 5,
						},
						[3575] = "Trade Goods",
						["selected"] = "None",
						[3576] = "Trade Goods",
						[2842] = "Trade Goods",
					},
				},
				["Mxyzptlk"] = {
				},
			},
			["groupSN"] = {
			},
			["bankData"] = {
				["Mxyz"] = {
				},
				["Mxzq"] = {
				},
				["Mxyzptlk"] = {
				},
			},
			["bankDetails"] = {
				["Mxyz"] = {
				},
				["Mxzq"] = {
				},
				["Mxyzptlk"] = {
				},
			},
			["inventoryData"] = {
				["Mxyz"] = {
				},
				["Mxzq"] = {
					[2840] = 35,
					[2775] = 3,
					[2771] = 16,
				},
				["Mxyzptlk"] = {
				},
			},
			["options"] = {
				["Mxzq"] = {
					[2575] = {
						["filterLevel"] = 1,
						["searchtext"] = "",
						["hideuncraftable"] = false,
						["sortmethod"] = "By Difficulty",
						["grouping"] = "Flat",
					},
				},
			},
			["bagDetails"] = {
				["Mxyz"] = {
					{
						["bag"] = 0,
						["name"] = "Hearthstone",
						["slot"] = 1,
						["id"] = 6948,
						["count"] = 1,
					}, -- [1]
				},
				["Mxzq"] = {
					{
						["bag"] = 0,
						["name"] = "Wild Hog Shank",
						["slot"] = 1,
						["id"] = 3771,
						["count"] = 19,
					}, -- [1]
					{
						["bag"] = 0,
						["name"] = "Hearthstone",
						["slot"] = 2,
						["id"] = 6948,
						["count"] = 1,
					}, -- [2]
					{
						["bag"] = 0,
						["name"] = "Warsong Gulch Mark of Honor",
						["slot"] = 3,
						["id"] = 20558,
						["count"] = 3,
					}, -- [3]
					{
						["bag"] = 0,
						["name"] = "Wild Hog Shank",
						["slot"] = 4,
						["id"] = 3771,
						["count"] = 20,
					}, -- [4]
					{
						["bag"] = 0,
						["name"] = "Sweet Nectar",
						["slot"] = 5,
						["id"] = 1708,
						["count"] = 20,
					}, -- [5]
					{
						["bag"] = 0,
						["name"] = "Sweet Nectar",
						["slot"] = 6,
						["id"] = 1708,
						["count"] = 20,
					}, -- [6]
					{
						["bag"] = 0,
						["name"] = "Tin Ore",
						["slot"] = 7,
						["id"] = 2771,
						["count"] = 10,
					}, -- [7]
					{
						["bag"] = 0,
						["name"] = "Wild Hog Shank",
						["slot"] = 8,
						["id"] = 3771,
						["count"] = 20,
					}, -- [8]
					{
						["bag"] = 0,
						["name"] = "Razor Arrow",
						["slot"] = 9,
						["id"] = 3030,
						["count"] = 200,
					}, -- [9]
					{
						["bag"] = 0,
						["name"] = "Healing Potion",
						["slot"] = 10,
						["id"] = 929,
						["count"] = 5,
					}, -- [10]
					{
						["bag"] = 0,
						["name"] = "Copper Bar",
						["slot"] = 11,
						["id"] = 2840,
						["count"] = 15,
					}, -- [11]
					{
						["bag"] = 0,
						["name"] = "Copper Bar",
						["slot"] = 12,
						["id"] = 2840,
						["count"] = 20,
					}, -- [12]
					{
						["bag"] = 0,
						["name"] = "Razor Arrow",
						["slot"] = 13,
						["id"] = 3030,
						["count"] = 200,
					}, -- [13]
					{
						["bag"] = 0,
						["name"] = "Mining Pick",
						["slot"] = 14,
						["id"] = 2901,
						["count"] = 1,
					}, -- [14]
					{
						["bag"] = 0,
						["name"] = "Razor Arrow",
						["slot"] = 15,
						["id"] = 3030,
						["count"] = 200,
					}, -- [15]
					{
						["bag"] = 0,
						["name"] = "Kingsblood",
						["slot"] = 16,
						["id"] = 3356,
						["count"] = 11,
					}, -- [16]
					{
						["bag"] = 0,
						["name"] = "Razor Arrow",
						["slot"] = 17,
						["id"] = 3030,
						["count"] = 200,
					}, -- [17]
					{
						["bag"] = 1,
						["name"] = "Razor Arrow",
						["slot"] = 1,
						["id"] = 3030,
						["count"] = 200,
					}, -- [18]
					{
						["bag"] = 1,
						["name"] = "Razor Arrow",
						["slot"] = 2,
						["id"] = 3030,
						["count"] = 200,
					}, -- [19]
					{
						["bag"] = 1,
						["name"] = "Razor Arrow",
						["slot"] = 3,
						["id"] = 3030,
						["count"] = 200,
					}, -- [20]
					{
						["bag"] = 1,
						["name"] = "Razor Arrow",
						["slot"] = 4,
						["id"] = 3030,
						["count"] = 200,
					}, -- [21]
					{
						["bag"] = 1,
						["name"] = "Razor Arrow",
						["slot"] = 5,
						["id"] = 3030,
						["count"] = 200,
					}, -- [22]
					{
						["bag"] = 1,
						["name"] = "Razor Arrow",
						["slot"] = 6,
						["id"] = 3030,
						["count"] = 200,
					}, -- [23]
					{
						["bag"] = 1,
						["name"] = "Razor Arrow",
						["slot"] = 7,
						["id"] = 3030,
						["count"] = 200,
					}, -- [24]
					{
						["bag"] = 1,
						["name"] = "Razor Arrow",
						["slot"] = 8,
						["id"] = 3030,
						["count"] = 200,
					}, -- [25]
					{
						["bag"] = 1,
						["name"] = "Razor Arrow",
						["slot"] = 9,
						["id"] = 3030,
						["count"] = 200,
					}, -- [26]
					{
						["bag"] = 1,
						["name"] = "Razor Arrow",
						["slot"] = 10,
						["id"] = 3030,
						["count"] = 42,
					}, -- [27]
					{
						["bag"] = 2,
						["name"] = "Coarse Stone",
						["slot"] = 3,
						["id"] = 2836,
						["count"] = 8,
					}, -- [28]
					{
						["bag"] = 2,
						["name"] = "Tin Ore",
						["slot"] = 4,
						["id"] = 2771,
						["count"] = 6,
					}, -- [29]
					{
						["bag"] = 2,
						["name"] = "Briarthorn",
						["slot"] = 5,
						["id"] = 2450,
						["count"] = 2,
					}, -- [30]
					{
						["bag"] = 2,
						["name"] = "Zircon Band of Fire Resistance",
						["slot"] = 7,
						["id"] = 11967,
						["count"] = 1,
					}, -- [31]
					{
						["bag"] = 2,
						["name"] = "Ritual Tunic of Shadow Wrath",
						["slot"] = 9,
						["id"] = 14133,
						["count"] = 1,
					}, -- [32]
					{
						["bag"] = 2,
						["name"] = "Wild Steelbloom",
						["slot"] = 11,
						["id"] = 3355,
						["count"] = 4,
					}, -- [33]
					{
						["bag"] = 3,
						["name"] = "Healing Potion",
						["slot"] = 2,
						["id"] = 929,
						["count"] = 2,
					}, -- [34]
					{
						["bag"] = 4,
						["name"] = "Silver Ore",
						["slot"] = 3,
						["id"] = 2775,
						["count"] = 3,
					}, -- [35]
				},
				["Mxyzptlk"] = {
				},
			},
			["userIgnoredMats"] = {
				["Mxyz"] = {
				},
				["Mxzq"] = {
				},
				["Mxyzptlk"] = {
				},
			},
			["groupDB"] = {
			},
		},
	},
}
