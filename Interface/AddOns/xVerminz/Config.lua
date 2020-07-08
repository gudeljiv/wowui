local _, xVerminz = ...

config = {
	font = {
		arial = "Fonts\\ARIALN.ttf",
		atari = "Interface\\AddOns\\xVerminz\\media\\fontAtari.ttf",
		damage = "Interface\\AddOns\\xVerminz\\media\\damagefont.ttf"
	},
	background = {
		white = "Interface\\Buttons\\WHITE8x8"
	},
	border = {
		buff = "Interface\\AddOns\\xVerminz\\media\\textureOverlay",
		debuff = "Interface\\AddOns\\xVerminz\\media\\textureDebuff"
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
		bordersize = 4,
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
		bordersize = 4,
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
