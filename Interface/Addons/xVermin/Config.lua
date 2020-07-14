local _, ns = ...

-- ns.config = {}
-- local config = ns.config

config = {
	font = {
		arial = "Fonts\\ARIALN.ttf",
		atari = "Interface\\AddOns\\xVermin\\media\\fontAtari.ttf",
		damage = "Interface\\AddOns\\xVermin\\media\\damagefont.ttf"
	},
	background = {
		white = "Interface\\Buttons\\WHITE8x8"
	},
	border = {
		default = "Interface\\AddOns\\xVermin\\media\\textureNormal",
		colorize = "Interface\\AddOns\\xVermin\\media\\textureWhite",
		iq = {
			"Interface\\AddOns\\xVermin\\media\\ItemQuality0",
			"Interface\\AddOns\\xVermin\\media\\ItemQuality1",
			"Interface\\AddOns\\xVermin\\media\\ItemQuality2",
			"Interface\\AddOns\\xVermin\\media\\ItemQuality3",
			"Interface\\AddOns\\xVermin\\media\\ItemQuality4",
			"Interface\\AddOns\\xVermin\\media\\ItemQuality5",
			"Interface\\AddOns\\xVermin\\media\\ItemQuality6",
			"Interface\\AddOns\\xVermin\\media\\ItemQuality7"
		}
	},
	buff = {
		scale = 1.3,
		fontsize = 10,
		outline = "THINOUTLINE",
		bordersize = 6,
		position = {
			"BOTTOMRIGHT",
			frame,
			"BOTTOMRIGHT",
			0,
			2
		}
	},
	debuff = {
		scale = 1.3,
		fontsize = 10,
		outline = "THINOUTLINE",
		bordersize = 6,
		position = {
			"BOTTOMRIGHT",
			frame,
			"BOTTOMRIGHT",
			0,
			2
		}
	},
	petbuff = {
		fontsize = 10,
		outline = "THINOUTLINE",
		bordersize = 6,
		position = {
			"BOTTOMRIGHT",
			frame,
			"BOTTOMRIGHT",
			0,
			2
		}
	},
	petdebuff = {
		fontsize = 10,
		outline = "THINOUTLINE",
		bordersize = 6,
		position = {
			"BOTTOMRIGHT",
			frame,
			"BOTTOMRIGHT",
			0,
			2
		}
	},
	ReplacedDebuffTypeColor = {
		none = {r = 0.80, g = 0, b = 0},
		Magic = {r = 0.20, g = 0.60, b = 1.00},
		Curse = {r = 0.60, g = 0.00, b = 1.00},
		Disease = {r = 0.60, g = 0.40, b = 0},
		Poison = {r = 0.00, g = 0.60, b = 0}
	}
}
