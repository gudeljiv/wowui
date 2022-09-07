
EnhancedRaidFramesDB = {
	["global"] = {
		["DB_VERSION"] = 2,
	},
	["profileKeys"] = {
		["Vermin - Golemagg"] = "Vermin - Golemagg",
		["Pitchwise - Dreadnaught"] = "Pitchwise - Dreadnaught",
		["Mxyz - Golemagg"] = "Mxyz - Golemagg",
		["Battlearm - Golemagg"] = "Battlearm - Golemagg",
		["Moolatz - Golemagg"] = "Moolatz - Golemagg",
		["Mxzq - Golemagg"] = "Mxzq - Golemagg",
	},
	["profiles"] = {
		["Mxzq - Golemagg"] = {
			["backgroundAlpha"] = 0.6000000000000001,
			["rangeAlpha"] = 0.2,
			["showDebuffs"] = false,
			["showDispellableDebuffs"] = false,
			["showBuffs"] = false,
		},
		["Mxyz - Golemagg"] = {
		},
		["Battlearm - Golemagg"] = {
		},
		["Moolatz - Golemagg"] = {
			{
				["indicatorSize"] = 22,
				["auras"] = "Rejuvenation",
				["showTooltip"] = false,
				["textSize"] = 12,
				["colorTextByDebuff"] = true,
				["mineOnly"] = true,
			}, -- [1]
			nil, -- [2]
			{
				["indicatorSize"] = 22,
				["auras"] = "Curse\nPoison",
				["showTooltip"] = false,
				["textSize"] = 12,
				["colorTextByDebuff"] = true,
			}, -- [3]
			{
				["indicatorSize"] = 22,
				["textSize"] = 12,
				["showText"] = "countdown",
				["colorTextByDebuff"] = true,
			}, -- [4]
			[7] = {
				["indicatorSize"] = 22,
				["auras"] = "Regrowth",
				["showTooltip"] = false,
				["textSize"] = 12,
				["colorTextByDebuff"] = true,
				["mineOnly"] = true,
			},
			["backgroundAlpha"] = 0.7000000000000001,
			["showBuffs"] = false,
			["showDebuffs"] = false,
			["showDispellableDebuffs"] = false,
			["rangeAlpha"] = 0.5,
			["showRaidIcons"] = false,
		},
		["Vermin - Golemagg"] = {
			{
				["indicatorSize"] = 22,
				["showTooltip"] = false,
				["colorTextByDebuff"] = true,
				["textSize"] = 12,
				["mineOnly"] = true,
			}, -- [1]
			nil, -- [2]
			{
				["indicatorSize"] = 22,
				["showTooltip"] = false,
				["textSize"] = 12,
				["colorTextByDebuff"] = true,
			}, -- [3]
			{
				["indicatorSize"] = 22,
				["textSize"] = 12,
				["showText"] = "countdown",
				["colorTextByDebuff"] = true,
			}, -- [4]
			[7] = {
				["indicatorSize"] = 22,
				["showTooltip"] = false,
				["colorTextByDebuff"] = true,
				["textSize"] = 12,
				["mineOnly"] = true,
			},
			["backgroundAlpha"] = 0.7000000000000001,
			["showDebuffs"] = false,
			["showRaidIcons"] = false,
			["showBuffs"] = false,
			["showDispellableDebuffs"] = false,
			["rangeAlpha"] = 0.1,
		},
	},
}
