
EnhancedRaidFramesDB = {
	["profileKeys"] = {
		["Vermin - Golemagg"] = "Default",
		["Pitchwise - Dreadnaught"] = "Pitchwise - Dreadnaught",
		["Mxyz - Golemagg"] = "Mxyz - Golemagg",
		["Mxzq - Golemagg"] = "Mxzq - Golemagg",
		["Battlearm - Golemagg"] = "Battlearm - Golemagg",
		["Moolatz - Golemagg"] = "Moolatz - Golemagg",
		["Vermina - Golemagg"] = "Vermina - Golemagg",
	},
	["global"] = {
		["DB_VERSION"] = 2,
	},
	["profiles"] = {
		["Mxzq - Golemagg"] = {
			["backgroundAlpha"] = 0.6000000000000001,
			["rangeAlpha"] = 0.2,
			["showBuffs"] = false,
			["showDispellableDebuffs"] = false,
			["showDebuffs"] = false,
		},
		["Vermina - Golemagg"] = {
		},
		["Mxyz - Golemagg"] = {
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
				["colorTextByDebuff"] = true,
				["textSize"] = 12,
				["showTooltip"] = false,
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
				["colorTextByDebuff"] = true,
				["textSize"] = 12,
				["mineOnly"] = true,
			},
			["backgroundAlpha"] = 0.7000000000000001,
			["showBuffs"] = false,
			["showRaidIcons"] = false,
			["showDebuffs"] = false,
			["showDispellableDebuffs"] = false,
			["rangeAlpha"] = 0.6000000000000001,
		},
		["Battlearm - Golemagg"] = {
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
			["showRaidIcons"] = false,
			["showBuffs"] = false,
			["showDebuffs"] = false,
			["showDispellableDebuffs"] = false,
			["rangeAlpha"] = 0.5,
		},
		["Default"] = {
		},
	},
}
