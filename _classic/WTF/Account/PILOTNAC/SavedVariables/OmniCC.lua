
OmniCCDB = {
	["global"] = {
		["dbVersion"] = 6,
		["addonVersion"] = "10.1.2",
	},
	["profileKeys"] = {
		["Dopede - Stitches"] = "Default",
		["Dopesnare - Stitches"] = "Default",
		["Lonac - Stitches"] = "Default",
		["Dopesick - Stitches"] = "Default",
		["Dopecure - Stitches"] = "Default",
		["Dopeclaw - Stitches"] = "Default",
		["Dopeah - Stitches"] = "Default",
		["Mxzq - Golemagg"] = "Default",
	},
	["profiles"] = {
		["Default"] = {
			["rules"] = {
				{
					["patterns"] = {
						"LossOfControl", -- [1]
						"TotemFrame", -- [2]
					},
					["id"] = "Ignore",
					["priority"] = 1,
					["theme"] = "Ignore",
				}, -- [1]
				{
					["enabled"] = false,
					["patterns"] = {
						"Aura", -- [1]
						"Buff", -- [2]
						"Debuff", -- [3]
					},
					["name"] = "Auras",
					["id"] = "auras",
				}, -- [2]
				{
					["enabled"] = false,
					["patterns"] = {
						"Plate", -- [1]
					},
					["name"] = "Unit Nameplates",
					["id"] = "plates",
				}, -- [3]
				{
					["enabled"] = false,
					["patterns"] = {
						"ActionButton", -- [1]
					},
					["name"] = "Action Bars",
					["id"] = "actions",
				}, -- [4]
				{
					["patterns"] = {
						"PlaterMainAuraIcon", -- [1]
						"PlaterSecondaryAuraIcon", -- [2]
						"ExtraIconRowIcon", -- [3]
					},
					["id"] = "Plater Nameplates Rule",
					["priority"] = 5,
					["theme"] = "Plater Nameplates Theme",
				}, -- [5]
			},
			["themes"] = {
				["Plater Nameplates Theme"] = {
					["textStyles"] = {
						["seconds"] = {
						},
						["soon"] = {
						},
						["minutes"] = {
						},
					},
				},
				["Default"] = {
					["textStyles"] = {
						["soon"] = {
						},
						["minutes"] = {
						},
						["seconds"] = {
						},
						["charging"] = {
							["r"] = 1,
							["scale"] = 0.649999976158142,
							["g"] = 0.98,
							["b"] = 0.4,
						},
						["controlled"] = {
							["scale"] = 1.20000004768372,
						},
					},
					["fontSize"] = 16,
					["spiralOpacity"] = 1.00999997742474,
					["fontFace"] = "Fonts\\ARIALN.TTF",
				},
				["Ignore"] = {
					["textStyles"] = {
						["seconds"] = {
						},
						["soon"] = {
						},
						["minutes"] = {
						},
						["charging"] = {
							["r"] = 1,
							["scale"] = 0.65,
							["g"] = 0.98,
							["b"] = 0.4,
						},
					},
					["enableText"] = false,
					["spiralOpacity"] = 1,
					["minDuration"] = 3,
				},
			},
		},
	},
}
OmniCC4Config = {
	["groups"] = {
		{
			["id"] = "Ignore",
			["rules"] = {
				"LossOfControl", -- [1]
				"TotemFrame", -- [2]
			},
			["enabled"] = true,
		}, -- [1]
	},
	["engine"] = "AniUpdater",
	["groupSettings"] = {
		["base"] = {
			["enabled"] = true,
			["fontSize"] = 18,
			["fontFace"] = "Fonts\\ARIALN.TTF",
			["effect"] = "pulse",
			["styles"] = {
				["seconds"] = {
					["a"] = 1,
					["r"] = 1,
					["scale"] = 1,
					["g"] = 1,
					["b"] = 0.1,
				},
				["soon"] = {
					["a"] = 1,
					["r"] = 1,
					["scale"] = 1.5,
					["g"] = 0.1,
					["b"] = 0.1,
				},
				["minutes"] = {
					["a"] = 1,
					["r"] = 1,
					["scale"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["hours"] = {
					["a"] = 1,
					["r"] = 0.7,
					["scale"] = 0.75,
					["g"] = 0.7,
					["b"] = 0.7,
				},
				["charging"] = {
					["a"] = 0.8,
					["r"] = 1,
					["scale"] = 0.649999976158142,
					["g"] = 0.98,
					["b"] = 0.4,
				},
				["controlled"] = {
					["scale"] = 1.20000004768372,
				},
			},
			["mmSSDuration"] = 0,
			["minSize"] = 0.5,
			["spiralOpacity"] = 1.00999997742474,
			["scaleText"] = true,
			["xOff"] = 0,
			["tenthsDuration"] = 0,
			["fontOutline"] = "OUTLINE",
			["anchor"] = "CENTER",
			["minEffectDuration"] = 30,
			["yOff"] = 0,
			["minDuration"] = 2,
		},
		["Ignore"] = {
			["enabled"] = false,
			["styles"] = {
				["soon"] = {
					["a"] = 1,
					["r"] = 1,
					["scale"] = 1.5,
					["g"] = 0.1,
					["b"] = 0.1,
				},
				["minutes"] = {
					["a"] = 1,
					["r"] = 1,
					["scale"] = 1,
					["g"] = 1,
					["b"] = 1,
				},
				["seconds"] = {
					["a"] = 1,
					["r"] = 1,
					["scale"] = 1,
					["g"] = 1,
					["b"] = 0.1,
				},
				["hours"] = {
					["a"] = 1,
					["r"] = 0.7,
					["scale"] = 0.75,
					["g"] = 0.7,
					["b"] = 0.7,
				},
				["charging"] = {
					["a"] = 0.8,
					["r"] = 1,
					["scale"] = 0.65,
					["g"] = 0.98,
					["b"] = 0.4,
				},
				["controlled"] = {
				},
			},
			["minDuration"] = 3,
			["effect"] = "pulse",
			["yOff"] = 0,
			["minEffectDuration"] = 30,
			["anchor"] = "CENTER",
			["spiralOpacity"] = 1,
			["scaleText"] = true,
			["xOff"] = 0,
			["tenthsDuration"] = 0,
			["fontOutline"] = "OUTLINE",
			["minSize"] = 0.5,
			["mmSSDuration"] = 0,
			["fontFace"] = "Fonts\\FRIZQT__.TTF",
			["fontSize"] = 18,
		},
	},
	["version"] = "8.1.1",
}
