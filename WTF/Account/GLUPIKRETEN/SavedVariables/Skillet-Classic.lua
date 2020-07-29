
SkilletDB = {
	["char"] = {
		["Mxzq - Golemagg"] = {
			["include_alts"] = false,
		},
	},
	["global"] = {
		["customVersion"] = 1,
		["MissingVendorItems"] = {
			[3857] = "Coal",
			[4539] = "Goldenbark Apple",
			[52188] = "Jeweler's Setting",
			[17034] = "Maple Seed",
			[17035] = "Stranglethorn Seed",
			[4399] = "Wooden Stock",
			[38682] = "Enchanting Vellum",
			[30817] = "Simple Flour",
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
			["FixBugs"] = true,
			["ignoreListLocation_point"] = "CENTER",
			["shoppingListLocation_scale"] = 1,
			["standaloneQueueLocation_x"] = -280.833190917969,
			["ignoreListLocation_x"] = 136.170593261719,
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
			["ignoreListLocation_scale"] = 1,
			["ignoreListLocation_y"] = 93.6171569824219,
			["tradeSkillLocation_x"] = 181.063690185547,
			["shoppingListLocation_x"] = 158.235656738281,
			["tradeSkillLocation_point"] = "TOP",
			["standaloneQueueLocation_y"] = 247.500411987305,
			["enhanced_recipe_display"] = true,
			["tradeSkillLocation_scale"] = 1,
			["transparency"] = 0.95,
			["shoppingListLocation_y"] = 157.881286621094,
			["standaloneQueueLocation_scale"] = 1,
			["standaloneQueueLocation_point"] = "BOTTOM",
			["shoppingListLocation_point"] = "CENTER",
			["tradeSkillLocation_y"] = -82.304443359375,
			["WarnLog"] = true,
		},
		["Mxyz - Golemagg"] = {
			["FixBugs"] = true,
			["WarnLog"] = true,
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
		},
		["Mxyzptlk - Golemagg"] = {
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
					[12467] = 1,
					[6948] = 1,
					[20558] = 3,
					[1708] = 38,
					[2771] = 22,
					[2772] = 9,
					[2840] = 35,
					[929] = 7,
					[2901] = 1,
					[3771] = 56,
					[3030] = 1914,
					[2775] = 6,
					[3385] = 2,
					[1205] = 1,
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
					[4306] = 3,
					[3369] = 2,
					[11138] = 1,
					[3356] = 6,
					[14125] = 1,
					[1705] = 1,
					[1529] = 1,
					[10998] = 1,
					[11135] = 21,
					[15517] = 1,
					[2452] = 1,
					[9767] = 1,
					[2592] = 46,
					[2836] = 6,
				},
				["Mxzq"] = {
					[3575] = 80,
					[14571] = 1,
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
			["inventoryData"] = {
				["Mxyz"] = {
				},
				["Mxzq"] = {
					[2771] = 22,
					[2772] = 9,
					[2840] = 35,
					[2775] = 6,
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
						["count"] = 16,
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
						["count"] = 18,
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
						["name"] = "Tin Ore",
						["slot"] = 9,
						["id"] = 2771,
						["count"] = 2,
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
						["name"] = "Mining Pick",
						["slot"] = 14,
						["id"] = 2901,
						["count"] = 1,
					}, -- [13]
					{
						["bag"] = 0,
						["name"] = "Lesser Mana Potion",
						["slot"] = 17,
						["id"] = 3385,
						["count"] = 2,
					}, -- [14]
					{
						["bag"] = 1,
						["name"] = "Razor Arrow",
						["slot"] = 1,
						["id"] = 3030,
						["count"] = 200,
					}, -- [15]
					{
						["bag"] = 1,
						["name"] = "Razor Arrow",
						["slot"] = 2,
						["id"] = 3030,
						["count"] = 200,
					}, -- [16]
					{
						["bag"] = 1,
						["name"] = "Razor Arrow",
						["slot"] = 3,
						["id"] = 3030,
						["count"] = 200,
					}, -- [17]
					{
						["bag"] = 1,
						["name"] = "Razor Arrow",
						["slot"] = 4,
						["id"] = 3030,
						["count"] = 200,
					}, -- [18]
					{
						["bag"] = 1,
						["name"] = "Razor Arrow",
						["slot"] = 5,
						["id"] = 3030,
						["count"] = 200,
					}, -- [19]
					{
						["bag"] = 1,
						["name"] = "Razor Arrow",
						["slot"] = 6,
						["id"] = 3030,
						["count"] = 200,
					}, -- [20]
					{
						["bag"] = 1,
						["name"] = "Razor Arrow",
						["slot"] = 7,
						["id"] = 3030,
						["count"] = 200,
					}, -- [21]
					{
						["bag"] = 1,
						["name"] = "Razor Arrow",
						["slot"] = 8,
						["id"] = 3030,
						["count"] = 200,
					}, -- [22]
					{
						["bag"] = 1,
						["name"] = "Razor Arrow",
						["slot"] = 9,
						["id"] = 3030,
						["count"] = 200,
					}, -- [23]
					{
						["bag"] = 1,
						["name"] = "Razor Arrow",
						["slot"] = 10,
						["id"] = 3030,
						["count"] = 114,
					}, -- [24]
					{
						["bag"] = 2,
						["name"] = "Tin Ore",
						["slot"] = 4,
						["id"] = 2771,
						["count"] = 10,
					}, -- [25]
					{
						["bag"] = 2,
						["name"] = "Iron Ore",
						["slot"] = 6,
						["id"] = 2772,
						["count"] = 9,
					}, -- [26]
					{
						["bag"] = 2,
						["name"] = "Alien Egg",
						["slot"] = 8,
						["id"] = 12467,
						["count"] = 1,
					}, -- [27]
					{
						["bag"] = 3,
						["name"] = "Healing Potion",
						["slot"] = 2,
						["id"] = 929,
						["count"] = 2,
					}, -- [28]
					{
						["bag"] = 3,
						["name"] = "Melon Juice",
						["slot"] = 12,
						["id"] = 1205,
						["count"] = 1,
					}, -- [29]
					{
						["bag"] = 4,
						["name"] = "Silver Ore",
						["slot"] = 3,
						["id"] = 2775,
						["count"] = 6,
					}, -- [30]
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
