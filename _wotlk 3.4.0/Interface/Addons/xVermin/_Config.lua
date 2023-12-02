local _, xVermin = ...

-- local resolution = ({GetScreenResolutions()})[GetCurrentResolution()]
local width, height = GetPhysicalScreenSize()
-- local scale = 0.58

-- if height == 2240 then
-- 	scale = 0.55
-- end

scale = 1232 / height
-- local resolution_width = string.match(resolution, "%d+x(%d+)")
-- local scale = tonumber(resolution_width) > 2000 and 0.55 or 768 / resolution_width

xVermin.Config = {
	UIscale = 0.56,
	font = {
		arial = 'Fonts\\ARIALN.ttf',
		atari = 'Interface\\AddOns\\xVermin\\Media\\Atari.ttf',
		damage = 'Interface\\AddOns\\xVermin\\Media\\Damage.ttf'
	},
	texture = {
		coins = 'Interface\\AddOns\\xVermin\\Media\\textureNormal\\Coins'
	},
	background = {
		white = 'Interface\\Buttons\\WHITE8x8'
	},
	border = {
		default = 'Interface\\AddOns\\xVermin\\Media\\textureNormal',
		colorize = 'Interface\\AddOns\\xVermin\\Media\\textureWhite',
		glow = 'Interface\\AddOns\\xVermin\\Media\\textureGlow',
		iq = {
			'Interface\\AddOns\\xVermin\\Media\\ItemQuality0',
			'Interface\\AddOns\\xVermin\\Media\\ItemQuality1',
			'Interface\\AddOns\\xVermin\\Media\\ItemQuality2',
			'Interface\\AddOns\\xVermin\\Media\\ItemQuality3',
			'Interface\\AddOns\\xVermin\\Media\\ItemQuality4',
			'Interface\\AddOns\\xVermin\\Media\\ItemQuality5',
			'Interface\\AddOns\\xVermin\\Media\\ItemQuality6',
			'Interface\\AddOns\\xVermin\\Media\\ItemQuality7'
		}
	},
	buff = {
		scale = 1.3,
		fontsize = 9,
		outline = 'THINOUTLINE',
		bordersize = 6,
		position = {
			'BOTTOMRIGHT',
			frame,
			'BOTTOMRIGHT',
			0,
			2
		}
	},
	debuff = {
		scale = 1.3,
		fontsize = 9,
		outline = 'THINOUTLINE',
		bordersize = 6,
		position = {
			'BOTTOMRIGHT',
			frame,
			'BOTTOMRIGHT',
			0,
			2
		}
	},
	petbuff = {
		fontsize = 9,
		outline = 'THINOUTLINE',
		bordersize = 6,
		position = {
			'BOTTOMRIGHT',
			frame,
			'BOTTOMRIGHT',
			0,
			2
		}
	},
	petdebuff = {
		fontsize = 9,
		outline = 'THINOUTLINE',
		bordersize = 6,
		position = {
			'BOTTOMRIGHT',
			frame,
			'BOTTOMRIGHT',
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

local function GatherData()
	xVermin.Config.Data = {}
	xVermin.Config.Data.player = {
		health = {
			current = UnitHealth('player'),
			max = UnitHealthMax('player'),
			percentage = tonumber(string.format('%.0f', UnitHealth('player') / UnitHealthMax('player') * 100))
		},
		mana = {
			current = UnitPower('player'),
			max = UnitPowerMax('player'),
			percentage = tonumber(string.format('%.0f', UnitPower('player') / UnitPowerMax('player') * 100))
		},
		xp = {
			current = UnitXP('player'),
			max = UnitXPMax('player'),
			percentage = tonumber(string.format('%.0f', UnitXP('player') / UnitXPMax('player') * 100))
		}
	}

	xVermin.Config.Data.target = {
		exists = false,
		health = {},
		mana = {},
		xp = {}
	}

	if UnitExists('target') then
		xVermin.Config.Data.target = {
			exists = true,
			health = {
				current = UnitHealth('target'),
				max = UnitHealthMax('target'),
				percentage = tonumber(string.format('%.0f', UnitHealth('target') / UnitHealthMax('target') * 100))
			},
			mana = {
				current = UnitPower('target'),
				max = UnitPowerMax('target'),
				percentage = tonumber(string.format('%.0f', UnitPower('target') / UnitPowerMax('target') * 100))
			},
			xp = {
				current = UnitXP('target'),
				max = UnitXPMax('target'),
				percentage = tonumber(string.format('%.0f', UnitXP('target') / UnitXPMax('target') * 100))
			}
		}
	end
end

-- PlayerFrame:HookScript("OnUpdate", GatherData)
