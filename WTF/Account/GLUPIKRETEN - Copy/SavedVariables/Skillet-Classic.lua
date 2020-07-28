
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
			[17035] = "Stranglethorn Seed",
			[52188] = "Jeweler's Setting",
			[17034] = "Maple Seed",
			[38682] = "Enchanting Vellum",
			[4399] = "Wooden Stock",
			[4539] = "Goldenbark Apple",
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
			["ignoreListLocation_x"] = 136.170593261719,
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
			["tradeSkillLocation_x"] = 181.063690185547,
			["tradeSkillLocation_point"] = "TOP",
			["tradeSkillLocation_y"] = -82.304443359375,
			["transparency"] = 0.95,
			["standaloneQueueLocation_scale"] = 1,
			["FixBugs"] = true,
			["standaloneQueueLocation_x"] = -280.833190917969,
			["WarnLog"] = true,
			["shoppingListLocation_point"] = "CENTER",
			["ignoreListLocation_scale"] = 1,
			["ignoreListLocation_y"] = 93.6171569824219,
			["standaloneQueueLocation_point"] = "BOTTOM",
			["ignoreListLocation_point"] = "CENTER",
			["shoppingListLocation_x"] = 158.235656738281,
			["shoppingListLocation_scale"] = 1,
			["standaloneQueueLocation_y"] = 247.500411987305,
			["enhanced_recipe_display"] = true,
			["shoppingListLocation_y"] = 157.881286621094,
			["tradeSkillLocation_scale"] = 1,
		},
		["Mxyz - Golemagg"] = {
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
		["Mxyzptlk - Golemagg"] = {
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
					[2836] = 5,
					[3770] = 15,
					[1205] = 28,
					[929] = 6,
					[6948] = 1,
					[5092] = 3,
					[3356] = 1,
					[2771] = 4,
					[2589] = 5,
					[2901] = 1,
					[5093] = 1,
					[1772] = 1,
					[20558] = 3,
					[4538] = 2,
					[2515] = 1017,
					[2450] = 4,
					[2453] = 1,
					[785] = 5,
					[5094] = 2,
					[1819] = 1,
					[2592] = 16,
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
					[2589] = 13,
					[6573] = 1,
					[14571] = 1,
					[12989] = 1,
					[774] = 1,
					[3385] = 1,
					[11135] = 21,
					[7752] = 1,
					[2840] = 35,
					[2997] = 1,
					[4575] = 1,
					[9802] = 1,
				},
				["Mxzq"] = {
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
						["rank"] = 140,
					},
					[2656] = {
						["maxRank"] = 225,
						["isCraft"] = false,
						["name"] = "Smelting (Mining)",
						["rank"] = 140,
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
						["name"] = "Mageroyal",
						["slot"] = 1,
						["id"] = 785,
						["count"] = 5,
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
						["name"] = "Melon Juice",
						["slot"] = 4,
						["id"] = 1205,
						["count"] = 10,
					}, -- [4]
					{
						["bag"] = 0,
						["name"] = "Briarthorn",
						["slot"] = 5,
						["id"] = 2450,
						["count"] = 4,
					}, -- [5]
					{
						["bag"] = 0,
						["name"] = "Coarse Stone",
						["slot"] = 6,
						["id"] = 2836,
						["count"] = 5,
					}, -- [6]
					{
						["bag"] = 0,
						["name"] = "Tin Ore",
						["slot"] = 7,
						["id"] = 2771,
						["count"] = 4,
					}, -- [7]
					{
						["bag"] = 0,
						["name"] = "Kingsblood",
						["slot"] = 8,
						["id"] = 3356,
						["count"] = 1,
					}, -- [8]
					{
						["bag"] = 0,
						["name"] = "Melon Juice",
						["slot"] = 9,
						["id"] = 1205,
						["count"] = 18,
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
						["name"] = "Wool Cloth",
						["slot"] = 11,
						["id"] = 2592,
						["count"] = 16,
					}, -- [11]
					{
						["bag"] = 0,
						["name"] = "Mutton Chop",
						["slot"] = 12,
						["id"] = 3770,
						["count"] = 15,
					}, -- [12]
					{
						["bag"] = 0,
						["name"] = "Charred Razormane Wand",
						["slot"] = 13,
						["id"] = 5092,
						["count"] = 1,
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
						["name"] = "Razormane War Shield",
						["slot"] = 15,
						["id"] = 5094,
						["count"] = 1,
					}, -- [15]
					{
						["bag"] = 0,
						["name"] = "Linen Cloth",
						["slot"] = 16,
						["id"] = 2589,
						["count"] = 5,
					}, -- [16]
					{
						["bag"] = 0,
						["name"] = "Razormane War Shield",
						["slot"] = 17,
						["id"] = 5094,
						["count"] = 1,
					}, -- [17]
					{
						["bag"] = 0,
						["name"] = "Snapvine Watermelon",
						["slot"] = 18,
						["id"] = 4538,
						["count"] = 2,
					}, -- [18]
					{
						["bag"] = 0,
						["name"] = "Razormane Backstabber",
						["slot"] = 19,
						["id"] = 5093,
						["count"] = 1,
					}, -- [19]
					{
						["bag"] = 0,
						["name"] = "Bruiseweed",
						["slot"] = 20,
						["id"] = 2453,
						["count"] = 1,
					}, -- [20]
					{
						["bag"] = 1,
						["name"] = "Sharp Arrow",
						["slot"] = 5,
						["id"] = 2515,
						["count"] = 17,
					}, -- [21]
					{
						["bag"] = 1,
						["name"] = "Sharp Arrow",
						["slot"] = 6,
						["id"] = 2515,
						["count"] = 200,
					}, -- [22]
					{
						["bag"] = 1,
						["name"] = "Sharp Arrow",
						["slot"] = 7,
						["id"] = 2515,
						["count"] = 200,
					}, -- [23]
					{
						["bag"] = 1,
						["name"] = "Sharp Arrow",
						["slot"] = 8,
						["id"] = 2515,
						["count"] = 200,
					}, -- [24]
					{
						["bag"] = 1,
						["name"] = "Sharp Arrow",
						["slot"] = 9,
						["id"] = 2515,
						["count"] = 200,
					}, -- [25]
					{
						["bag"] = 1,
						["name"] = "Sharp Arrow",
						["slot"] = 10,
						["id"] = 2515,
						["count"] = 200,
					}, -- [26]
					{
						["bag"] = 2,
						["name"] = "Gouging Pick",
						["slot"] = 1,
						["id"] = 1819,
						["count"] = 1,
					}, -- [27]
					{
						["bag"] = 2,
						["name"] = "Brocade Shoes",
						["slot"] = 2,
						["id"] = 1772,
						["count"] = 1,
					}, -- [28]
					{
						["bag"] = 2,
						["name"] = "Charred Razormane Wand",
						["slot"] = 3,
						["id"] = 5092,
						["count"] = 1,
					}, -- [29]
					{
						["bag"] = 2,
						["name"] = "Charred Razormane Wand",
						["slot"] = 4,
						["id"] = 5092,
						["count"] = 1,
					}, -- [30]
					{
						["bag"] = 3,
						["name"] = "Healing Potion",
						["slot"] = 2,
						["id"] = 929,
						["count"] = 1,
					}, -- [31]
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
