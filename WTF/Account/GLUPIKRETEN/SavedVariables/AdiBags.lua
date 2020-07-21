
AdiBagsDB = {
	["namespaces"] = {
		["ItemLevel"] = {
		},
		["FilterOverride"] = {
			["profiles"] = {
				["Default"] = {
					["version"] = 3,
				},
			},
		},
		["ItemCategory"] = {
			["profiles"] = {
				["Default"] = {
					["splitBySubclass"] = {
						["Recipe"] = false,
						["Consumable"] = false,
						["Trade Goods"] = false,
						["Miscellaneous"] = false,
					},
				},
			},
		},
		["NewItem"] = {
			["profiles"] = {
				["Default"] = {
					["glowColor"] = {
						0.0627450980392157, -- [1]
						nil, -- [2]
						0.243137254901961, -- [3]
						0.700000017881393, -- [4]
					},
					["highlight"] = "none",
				},
			},
		},
		["Equipment"] = {
		},
		["AdiBags_TooltipInfo"] = {
		},
		["DataSource"] = {
		},
		["Junk"] = {
		},
		["MoneyFrame"] = {
		},
	},
	["profileKeys"] = {
		["Vermin - Golemagg"] = "Default",
	},
	["profiles"] = {
		["Default"] = {
			["virtualStacks"] = {
				["stackable"] = true,
				["incomplete"] = true,
			},
			["scale"] = 0.9,
			["maxHeight"] = 0.7,
			["skin"] = {
				["BackpackColor"] = {
					nil, -- [1]
					nil, -- [2]
					nil, -- [3]
					0.705127239227295, -- [4]
				},
				["BankColor"] = {
					nil, -- [1]
					nil, -- [2]
					0, -- [3]
					0.694444328546524, -- [4]
				},
				["border"] = "None",
				["insets"] = 2,
			},
			["positions"] = {
				["anchor"] = {
					["xOffset"] = -177.833374023438,
					["yOffset"] = 386.666717529297,
				},
				["Backpack"] = {
					["xOffset"] = -219.500465738325,
					["yOffset"] = 356.33341341195,
				},
				["Bank"] = {
					["xOffset"] = 697.833032050847,
					["yOffset"] = -410.66689713089,
				},
			},
			["sectionFont"] = {
				["name"] = "Arial Narrow",
			},
			["positionMode"] = "manual",
			["columnWidth"] = {
				["Backpack"] = 12,
			},
			["sortingOrder"] = "byQualityAndLevel",
		},
	},
}
