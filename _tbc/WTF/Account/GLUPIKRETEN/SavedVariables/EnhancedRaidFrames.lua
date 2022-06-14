
EnhancedRaidFramesDB = {
	["profileKeys"] = {
		["Vermin - Golemagg"] = "Vermin - Golemagg",
		["Pitchwise - Dreadnaught"] = "Pitchwise - Dreadnaught",
		["Mxyz - Golemagg"] = "Mxyz - Golemagg",
		["Moolatz - Golemagg"] = "Moolatz - Golemagg",
		["Mxzq - Golemagg"] = "Mxzq - Golemagg",
	},
	["global"] = {
		["DB_VERSION"] = 2,
	},
	["profiles"] = {
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
			["showBuffs"] = false,
			["showRaidIcons"] = false,
			["showDebuffs"] = false,
			["showDispellableDebuffs"] = false,
			["rangeAlpha"] = 0.1,
		},
		["Mxyz - Golemagg"] = {
		},
		["Moolatz - Golemagg"] = {
			{
				["indicatorSize"] = 22,
				["mineOnly"] = true,
				["showTooltip"] = false,
				["textSize"] = 12,
				["colorTextByDebuff"] = true,
				["auras"] = "Rejuvenation",
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
				["mineOnly"] = true,
				["showTooltip"] = false,
				["textSize"] = 12,
				["colorTextByDebuff"] = true,
				["auras"] = "Regrowth",
			},
			["rangeAlpha"] = 0.5,
			["showRaidIcons"] = false,
			["showBuffs"] = false,
			["showDispellableDebuffs"] = false,
			["backgroundAlpha"] = 0.7000000000000001,
			["showDebuffs"] = false,
		},
		["Mxzq - Golemagg"] = {
			["rangeAlpha"] = 0.2,
			["backgroundAlpha"] = 0.6000000000000001,
			["showBuffs"] = false,
			["showDispellableDebuffs"] = false,
			["showDebuffs"] = false,
		},
	},
}
