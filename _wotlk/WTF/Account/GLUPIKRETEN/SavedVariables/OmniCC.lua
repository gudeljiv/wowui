
OmniCCDB = {
	["global"] = {
		["dbVersion"] = 6,
		["addonVersion"] = "10.0.4",
	},
	["profileKeys"] = {
		["Mxzq - Golemagg"] = "Default",
		["Vermina - Golemagg"] = "Default",
		["Mxyz - Golemagg"] = "Default",
		["Battlearm - Golemagg"] = "Default",
		["Battitude - Golemagg"] = "Default",
		["Kaonac - Jin'do"] = "Default",
		["Wells - Jin'do"] = "Default",
		["Handrmandr - Golemagg"] = "Default",
		["Tandaram - Jin'do"] = "Default",
		["Pitchwise - Ashbringer"] = "Default",
		["Vermin - Golemagg"] = "Default",
		["Tudum - Ashbringer"] = "Default",
		["Augustin - Golemagg"] = "Default",
		["Moolatz - Golemagg"] = "Default",
		["Miqa - Golemagg"] = "Default",
		["Mxyzptlk - Golemagg"] = "Default",
		["Battlearm - Jin'do"] = "Default",
		["Poklopac - Mirage Raceway"] = "Default",
		["Provokator - Jin'do"] = "Default",
		["Tudum - Jin'do"] = "Default",
		["Battlearm - Gehennas"] = "Default",
		["Tadibey - Golemagg"] = "Default",
		["Battledog - Gehennas"] = "Default",
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
					["name"] = "ActionBars",
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
						["soon"] = {
						},
						["seconds"] = {
						},
						["minutes"] = {
						},
					},
					["cooldownOpacity"] = 0,
				},
				["Default"] = {
					["textStyles"] = {
						["soon"] = {
						},
						["minutes"] = {
							["scale"] = 0.9,
						},
						["seconds"] = {
						},
						["hours"] = {
							["scale"] = 0.8,
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
					["cooldownOpacity"] = 0,
					["spiralOpacity"] = 1.00999997742474,
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
					["cooldownOpacity"] = 0,
					["minDuration"] = 3,
					["enableText"] = false,
					["spiralOpacity"] = 1,
				},
			},
		},
	},
}
OmniCC4Config = {
	["version"] = "8.1.1",
	["groupSettings"] = {
		["base"] = {
			["enabled"] = true,
			["fontSize"] = 18,
			["yOff"] = 0,
			["effect"] = "pulse",
			["scaleText"] = true,
			["minEffectDuration"] = 30,
			["anchor"] = "CENTER",
			["spiralOpacity"] = 1.00999997742474,
			["minDuration"] = 2,
			["xOff"] = 0,
			["tenthsDuration"] = 0,
			["fontOutline"] = "OUTLINE",
			["minSize"] = 0.5,
			["mmSSDuration"] = 0,
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
			["fontFace"] = "Fonts\\ARIALN.TTF",
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
			["fontSize"] = 18,
			["effect"] = "pulse",
			["fontFace"] = "Fonts\\FRIZQT__.TTF",
			["mmSSDuration"] = 0,
			["minSize"] = 0.5,
			["spiralOpacity"] = 1,
			["yOff"] = 0,
			["xOff"] = 0,
			["tenthsDuration"] = 0,
			["fontOutline"] = "OUTLINE",
			["anchor"] = "CENTER",
			["minEffectDuration"] = 30,
			["minDuration"] = 3,
			["scaleText"] = true,
		},
	},
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
}
