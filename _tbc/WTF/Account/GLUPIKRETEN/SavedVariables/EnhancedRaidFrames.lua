
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
			["rangeAlpha"] = 0.1,
			["showRaidIcons"] = false,
			["showBuffs"] = false,
			["showDebuffs"] = false,
			["showDispellableDebuffs"] = false,
			["backgroundAlpha"] = 0.7000000000000001,
		},
		["Mxyz - Golemagg"] = {
		},
		["Moolatz - Golemagg"] = {
			{
				["indicatorSize"] = 22,
				["showTooltip"] = false,
				["mineOnly"] = true,
				["colorTextByDebuff"] = true,
				["textSize"] = 12,
				["auras"] = "Rejuvenation",
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
				["mineOnly"] = true,
				["colorTextByDebuff"] = true,
				["textSize"] = 12,
				["auras"] = "Regrowth",
			},
			["showDebuffs"] = false,
			["rangeAlpha"] = 0.5,
			["showBuffs"] = false,
			["showRaidIcons"] = false,
			["showDispellableDebuffs"] = false,
			["backgroundAlpha"] = 0.7000000000000001,
		},
		["Mxzq - Golemagg"] = {
			["backgroundAlpha"] = 0.6000000000000001,
			["showDebuffs"] = false,
			["showBuffs"] = false,
			["showDispellableDebuffs"] = false,
			["rangeAlpha"] = 0.2,
		},
	},
}
