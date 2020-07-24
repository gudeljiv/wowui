
AdiBagsDB = {
	["namespaces"] = {
		["ItemLevel"] = {
			["profiles"] = {
				["Default"] = {
					["colorScheme"] = "none",
					["ignoreJunk"] = false,
					["equippableOnly"] = false,
				},
			},
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
	["char"] = {
		["Vermin - Golemagg"] = {
			["collapsedSections"] = {
				["Bag #3#Bag #3"] = true,
				["Bag #2#Bag #2"] = true,
				["Bag #4#Bag #4"] = true,
				["Bag #1#Bag #1"] = true,
			},
		},
	},
	["profileKeys"] = {
		["Mxzq - Golemagg"] = "Default",
		["Mxyzptlk - Golemagg"] = "Default",
		["Mxyz - Golemagg"] = "Default",
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
					["xOffset"] = -225.883741936414,
					["yOffset"] = 376.900862818271,
				},
				["Bank"] = {
					["xOffset"] = 796.211313136119,
					["yOffset"] = -430.914589465603,
				},
			},
			["rightClickConfig"] = false,
			["sortingOrder"] = "byQualityAndLevel",
			["sectionFont"] = {
				["name"] = "Arial Narrow",
			},
			["positionMode"] = "manual",
			["columnWidth"] = {
				["Backpack"] = 14,
				["Bank"] = 18,
			},
		},
	},
}
