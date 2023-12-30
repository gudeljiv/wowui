
CellDB = {
	["indicatorPreviewAlpha"] = 0.5,
	["general"] = {
		["showSolo"] = true,
		["fadeOut"] = false,
		["hideTooltipsInCombat"] = true,
		["enableTooltips"] = false,
		["showParty"] = true,
		["sortPartyByRole"] = false,
		["locked"] = false,
		["tooltipsPosition"] = {
			"BOTTOMLEFT", -- [1]
			"Unit Button", -- [2]
			"TOPLEFT", -- [3]
			0, -- [4]
			15, -- [5]
		},
		["showPartyPets"] = true,
		["hideBlizzard"] = true,
	},
	["raidTools"] = {
		["deathReport"] = {
			false, -- [1]
			10, -- [2]
		},
		["marks"] = "both",
		["marksPosition"] = {
		},
		["pullTimer"] = {
			"ExRT", -- [1]
			7, -- [2]
		},
		["showBuffTracker"] = false,
		["buttonsPosition"] = {
		},
		["buffTrackerPosition"] = {
		},
		["showButtons"] = false,
		["showMarks"] = false,
		["showBattleRes"] = true,
	},
	["appearance"] = {
		["optionsFontSizeOffset"] = 0,
		["bgAlpha"] = 1,
		["scale"] = 1,
		["targetColor"] = {
			1, -- [1]
			0.31, -- [2]
			0.31, -- [3]
			1, -- [4]
		},
		["iconAnimation"] = "duration",
		["overshield"] = true,
		["barAnimation"] = "Flash",
		["texture"] = "Cell Default",
		["highlightSize"] = 1,
		["lossColor"] = {
			"Class Color (dark)", -- [1]
			{
				0.667, -- [1]
				0, -- [2]
				0, -- [3]
			}, -- [2]
		},
		["barColor"] = {
			"Class Color", -- [1]
			{
				0.2, -- [1]
				0.2, -- [2]
				0.2, -- [3]
			}, -- [2]
		},
		["lossAlpha"] = 1,
		["shield"] = true,
		["mouseoverColor"] = {
			1, -- [1]
			1, -- [2]
			1, -- [3]
			0.6, -- [4]
		},
		["healPrediction"] = true,
		["outOfRangeAlpha"] = 0.45,
		["healAbsorb"] = true,
		["barAlpha"] = 1,
		["powerColor"] = {
			"Power Color", -- [1]
			{
				0.7, -- [1]
				0.7, -- [2]
				0.7, -- [3]
			}, -- [2]
		},
	},
	["clickCastings"] = {
		["WARRIOR"] = {
			["useCommon"] = true,
			["alwaysTargeting"] = {
				["common"] = "disabled",
			},
			["common"] = {
				{
					"type1", -- [1]
					"target", -- [2]
				}, -- [1]
				{
					"type2", -- [1]
					"togglemenu", -- [2]
				}, -- [2]
			},
		},
	},
}
