
EnhancedRaidFramesDB = {
	["global"] = {
		["DB_VERSION"] = 2,
	},
	["profileKeys"] = {
		["Vermin - Golemagg"] = "Vermin - Golemagg",
		["Pitchwise - Dreadnaught"] = "Pitchwise - Dreadnaught",
		["Mxyz - Golemagg"] = "Mxyz - Golemagg",
		["Moolatz - Golemagg"] = "Moolatz - Golemagg",
		["Mxzq - Golemagg"] = "Mxzq - Golemagg",
	},
	["profiles"] = {
		["Vermin - Golemagg"] = {
			{
				["indicatorSize"] = 22,
				["showTooltip"] = false,
				["textSize"] = 12,
				["colorTextByDebuff"] = true,
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
				["textSize"] = 12,
				["colorTextByDebuff"] = true,
				["mineOnly"] = true,
			},
			["backgroundAlpha"] = 0.7000000000000001,
			["showDebuffs"] = false,
			["showBuffs"] = false,
			["showDispellableDebuffs"] = false,
			["rangeAlpha"] = 0.1,
			["showRaidIcons"] = false,
		},
		["Mxzq - Golemagg"] = {
			["backgroundAlpha"] = 0.6000000000000001,
			["showDebuffs"] = false,
			["showBuffs"] = false,
			["showDispellableDebuffs"] = false,
			["rangeAlpha"] = 0.2,
		},
		["Mxyz - Golemagg"] = {
		},
		["Moolatz - Golemagg"] = {
			{
				["indicatorSize"] = 22,
				["showTooltip"] = false,
				["auras"] = "Rejuvenation",
				["colorTextByDebuff"] = true,
				["textSize"] = 12,
				["mineOnly"] = true,
			}, -- [1]
			nil, -- [2]
			{
				["indicatorSize"] = 22,
				["showTooltip"] = false,
				["colorTextByDebuff"] = true,
				["textSize"] = 12,
				["auras"] = "Curse\nPoison",
			}, -- [3]
			{
				["indicatorSize"] = 22,
				["showText"] = "countdown",
				["textSize"] = 12,
				["colorTextByDebuff"] = true,
			}, -- [4]
			[7] = {
				["indicatorSize"] = 22,
				["showTooltip"] = false,
				["auras"] = "Regrowth",
				["colorTextByDebuff"] = true,
				["textSize"] = 12,
				["mineOnly"] = true,
			},
			["backgroundAlpha"] = 0.7000000000000001,
			["showBuffs"] = false,
			["showRaidIcons"] = false,
			["showDebuffs"] = false,
			["showDispellableDebuffs"] = false,
			["rangeAlpha"] = 0.5,
		},
	},
}
