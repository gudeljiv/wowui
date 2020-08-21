local _, xVermin = ...

xVermin.Config = {
	-- scale = 768 / string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)"),
	UIscale = 0.62,
	font = {
		arial = "Fonts\\ARIALN.ttf",
		atari = "Interface\\AddOns\\xVermin\\Media\\Atari.ttf",
		damage = "Interface\\AddOns\\xVermin\\Media\\Damage.ttf"
	},
	background = {
		white = "Interface\\Buttons\\WHITE8x8"
	},
	border = {
		default = "Interface\\AddOns\\xVermin\\Media\\textureNormal",
		colorize = "Interface\\AddOns\\xVermin\\Media\\textureWhite",
		iq = {
			"Interface\\AddOns\\xVermin\\Media\\ItemQuality0",
			"Interface\\AddOns\\xVermin\\Media\\ItemQuality1",
			"Interface\\AddOns\\xVermin\\Media\\ItemQuality2",
			"Interface\\AddOns\\xVermin\\Media\\ItemQuality3",
			"Interface\\AddOns\\xVermin\\Media\\ItemQuality4",
			"Interface\\AddOns\\xVermin\\Media\\ItemQuality5",
			"Interface\\AddOns\\xVermin\\Media\\ItemQuality6",
			"Interface\\AddOns\\xVermin\\Media\\ItemQuality7"
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
	},
	Chat = {
		alwaysAlertOnWhisper = true,
		disableFade = false,
		chatOutline = false,
		enableChatWindowBorder = false,
		enableBottomButton = false,
		enableHyperlinkTooltip = false,
		enableBorderColoring = true,
		enableVoiceChatButtons = false,
		showInputBoxAbove = true, -- Show the chat input box above the chat window
		tab = {
			fontSize = 12,
			fontOutline = true,
			normalColor = {1, 1, 1},
			specialColor = {1, 0, 1},
			selectedColor = {0, 0.75, 1}
		}
	}
}
