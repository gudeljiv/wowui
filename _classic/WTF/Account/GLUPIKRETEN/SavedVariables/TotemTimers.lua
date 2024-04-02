
TotemTimers_GlobalSettings = {
	["Sink"] = {
		["sink20OutputSink"] = "MikSBT",
		["sink20ScrollArea"] = "Notification",
	},
	["Version"] = 11.3,
	["Profiles"] = {
		["Jutarnjedrvo"] = {
			{
				["party"] = "default",
				["scenario"] = "default",
				["pvp"] = "default",
				["raid"] = "default",
				["arena"] = "default",
				["none"] = "default",
			}, -- [1]
			{
				["party"] = "default",
				["scenario"] = "default",
				["pvp"] = "default",
				["raid"] = "default",
				["arena"] = "default",
				["none"] = "default",
			}, -- [2]
			{
				["party"] = "default",
				["scenario"] = "default",
				["pvp"] = "default",
				["raid"] = "default",
				["arena"] = "default",
				["none"] = "default",
			}, -- [3]
		},
	},
}
TotemTimers_Profiles = {
	["default"] = {
		["EnhanceCDsOneRow"] = false,
		["PowerSurge"] = false,
		["MaelstromSize"] = 2,
		["EnhanceCDsTimeHeight"] = 12,
		["TimerSpacing"] = 5,
		["MaelstromNumberOnly"] = false,
		["PowerSurgeOverlay"] = true,
		["EnhanceCDs_Spells"] = {
			{
				true, -- [1]
				true, -- [2]
				true, -- [3]
				true, -- [4]
				true, -- [5]
				true, -- [6]
				true, -- [7]
				true, -- [8]
				true, -- [9]
				true, -- [10]
				true, -- [11]
				[20] = true,
			}, -- [1]
			{
				true, -- [1]
				true, -- [2]
				true, -- [3]
				true, -- [4]
				true, -- [5]
				true, -- [6]
				true, -- [7]
				true, -- [8]
				true, -- [9]
				true, -- [10]
				true, -- [11]
				true, -- [12]
				[21] = true,
				[22] = true,
				[20] = true,
			}, -- [2]
			{
				true, -- [1]
				true, -- [2]
				true, -- [3]
				true, -- [4]
				true, -- [5]
				true, -- [6]
				true, -- [7]
				[20] = true,
			}, -- [3]
		},
		["TwistingTimer"] = false,
		["EnhanceCDsMaelstrom"] = true,
		["EnhanceCDsOOCAlpha"] = 0.4,
		["TrackerSize"] = 30,
		["EnhanceCDsClickthrough"] = false,
		["TooltipsAtButtons"] = false,
		["EarthShieldOnSelf"] = false,
		["OOCAlpha"] = 1,
		["TotemTimerBarWidth"] = 36,
		["TimeFont"] = "Friz Quadrata TT",
		["FlameShockDurationSize"] = 2,
		["EarthShieldTargetName"] = true,
		["PartyRangePosition"] = "TOP",
		["TotemSets"] = {
		},
		["FlashRed"] = true,
		["EnhanceCDsStopPulse"] = false,
		["EnhanceCDs"] = false,
		["ReverseBarBindings"] = false,
		["Warnings"] = {
			["TotemWarning"] = {
				["a"] = 1,
				["r"] = 1,
				["b"] = 0,
				["g"] = 0,
				["text"] = "Totem Expiring",
				["sound"] = "",
				["enabled"] = true,
			},
			["PowerSurge"] = {
				["a"] = 1,
				["r"] = 1,
				["b"] = 0,
				["g"] = 0,
				["text"] = "Power Surge",
				["sound"] = "",
				["enabled"] = true,
			},
			["TotemDestroyed"] = {
				["a"] = 1,
				["r"] = 1,
				["b"] = 0,
				["g"] = 0,
				["text"] = "Totem Destroyed",
				["sound"] = "",
				["enabled"] = true,
			},
			["TotemExpiration"] = {
				["a"] = 1,
				["r"] = 1,
				["b"] = 0,
				["g"] = 0,
				["text"] = "Totem Expired",
				["sound"] = "",
				["enabled"] = true,
			},
			["Shield"] = {
				["a"] = 1,
				["r"] = 1,
				["b"] = 0,
				["g"] = 0,
				["text"] = "Shield removed",
				["sound"] = "",
				["enabled"] = true,
			},
			["EarthShield"] = {
				["a"] = 1,
				["r"] = 1,
				["b"] = 0,
				["g"] = 0,
				["text"] = "Shield removed",
				["sound"] = "",
				["enabled"] = true,
			},
			["Maelstrom"] = {
				["a"] = 1,
				["r"] = 1,
				["b"] = 0,
				["g"] = 0,
				["text"] = "Maelstrom",
				["sound"] = "",
				["enabled"] = true,
			},
			["Weapon"] = {
				["a"] = 1,
				["r"] = 1,
				["b"] = 0,
				["g"] = 0,
				["text"] = "Shield removed",
				["sound"] = "",
				["enabled"] = true,
			},
		},
		["ColorTimerBars"] = true,
		["TimerTimePos"] = "BOTTOM",
		["TimerTimeHeight"] = 10,
		["MaelstromStopPulse"] = false,
		["CooldownAlpha"] = 0.8,
		["ShieldLeftButton"] = 324,
		["IncludeInMacro"] = {
			true, -- [1]
			true, -- [2]
			true, -- [3]
			true, -- [4]
		},
		["LastOffEnchants"] = {
		},
		["MultiCast"] = true,
		["BarBindings"] = true,
		["EarthShieldRightButton"] = "target",
		["FulminationGlow"] = true,
		["ShieldChargesOnly"] = false,
		["HiddenTotems"] = {
			[2484] = false,
			[8071] = false,
		},
		["CrowdControlHex"] = true,
		["Lock"] = true,
		["ShieldTracker"] = false,
		["LastWeaponEnchant"] = "Rockbiter Weapon",
		["LavaSurgeAura"] = true,
		["CrowdControlArrange"] = "horizontal",
		["ShowRaidRangeTooltip"] = true,
		["StopPulse"] = false,
		["Tracker_Clickthrough"] = false,
		["LongCooldownSpells"] = {
		},
		["TimerPositions"] = {
			{
				"CENTER", -- [1]
				nil, -- [2]
				"CENTER", -- [3]
				-50, -- [4]
				-40, -- [5]
			}, -- [1]
			{
				"CENTER", -- [1]
				nil, -- [2]
				"CENTER", -- [3]
				-70, -- [4]
				0, -- [5]
			}, -- [2]
			{
				"CENTER", -- [1]
				nil, -- [2]
				"CENTER", -- [3]
				-30, -- [4]
				0, -- [5]
			}, -- [3]
			{
				"CENTER", -- [1]
				nil, -- [2]
				"CENTER", -- [3]
				-50, -- [4]
				40, -- [5]
			}, -- [4]
		},
		["TrackerStopPulse"] = false,
		["EnhanceCDsMaelstromHeight"] = 14,
		["EarthShieldTracker"] = false,
		["AnkhTracker"] = false,
		["CheckRaidRange"] = true,
		["OpenOnRightclick"] = false,
		["LongCooldowns"] = false,
		["ProcFlash"] = true,
		["EarthShieldButton4"] = "player",
		["FlameShockDurationOnTop"] = false,
		["TimerBarTexture"] = "xVerminClean",
		["WeaponGlow"] = true,
		["WeaponTracker"] = false,
		["CrowdControlSize"] = 30,
		["CrowdControlClickthrough"] = false,
		["LavaSurgeGlow"] = true,
		["TimerBarColor"] = {
			["a"] = 1,
			["r"] = 0.5,
			["g"] = 0.5,
			["b"] = 1,
		},
		["EnhanceCDsTotemTwisting"] = true,
		["TrackerTimeHeight"] = 12,
		["ShowKeybinds"] = true,
		["TimersOnButtons"] = true,
		["EnhanceCDsSize"] = 30,
		["ShowCooldowns"] = true,
		["CrowdControlEnable"] = true,
		["TotemMenuSpacing"] = 0,
		["ESMainTankMenu"] = true,
		["ShieldButton4"] = 408514,
		["WindfuryDownrank"] = false,
		["MiniIcons"] = true,
		["TimerSize"] = 36,
		["ESMainTankMenuDirection"] = "auto",
		["ActivateHiddenTimers"] = false,
		["CrowdControlTimePos"] = "BOTTOM",
		["TrackerTimeSpacing"] = 0,
		["MacroReset"] = 15,
		["LastMainEnchants"] = {
		},
		["TimerTimeSpacing"] = 0,
		["TrackerTimePos"] = "BOTTOM",
		["CooldownSpacing"] = 5,
		["TimeColor"] = {
			["a"] = 1,
			["r"] = 1,
			["g"] = 1,
			["b"] = 1,
		},
		["FlameShockDurationStopPulse"] = false,
		["Arrange"] = "horizontal",
		["TrackerTimerBarWidth"] = 36,
		["CrowdControlBindElemental"] = true,
		["ShieldRightButton"] = 408510,
		["EarthShieldLeftButton"] = "recast",
		["CastBarDirection"] = "up",
		["Order"] = {
			1, -- [1]
			2, -- [2]
			3, -- [3]
			4, -- [4]
		},
		["EnhanceCDs_Order"] = {
			{
				1, -- [1]
				2, -- [2]
				3, -- [3]
				4, -- [4]
				5, -- [5]
				6, -- [6]
				7, -- [7]
				8, -- [8]
				9, -- [9]
				10, -- [10]
				11, -- [11]
				12, -- [12]
			}, -- [1]
			{
				1, -- [1]
				2, -- [2]
				3, -- [3]
				4, -- [4]
				5, -- [5]
				6, -- [6]
				7, -- [7]
				8, -- [8]
				9, -- [9]
				10, -- [10]
				11, -- [11]
				12, -- [12]
			}, -- [2]
			{
				1, -- [1]
				2, -- [2]
				3, -- [3]
				4, -- [4]
				5, -- [5]
				6, -- [6]
				7, -- [7]
				8, -- [8]
				9, -- [9]
				10, -- [10]
				11, -- [11]
				12, -- [12]
			}, -- [3]
		},
		["Tooltips"] = true,
		["ESChargesOnly"] = false,
		["EnhanceCDsFlameShockDuration_Specialization"] = {
			true, -- [1]
			false, -- [2]
			true, -- [3]
		},
		["EnhanceCDsFlameShockDuration"] = true,
		["MenusAlwaysVisible"] = false,
		["HideBlizzTimers"] = true,
		["LongCooldownsArrange"] = "horizontal",
		["CheckPlayerRange"] = true,
		["WeaponMenuOnRightclick"] = false,
		["TrackerArrange"] = "horizontal",
		["WeaponBarDirection"] = "auto",
		["LongCooldownsStopPulse"] = false,
		["HideInVehicle"] = true,
		["ShowOmniCCOnEnhanceCDs"] = true,
		["TimeStyle"] = "mm:ss",
		["FramePositions"] = {
			["TotemTimers_CastBar2"] = {
				"CENTER", -- [1]
				nil, -- [2]
				"CENTER", -- [3]
				-200, -- [4]
				-225, -- [5]
			},
			["TotemTimers_TrackerFrame"] = {
				"CENTER", -- [1]
				nil, -- [2]
				"CENTER", -- [3]
				304.9333190917969, -- [4]
				19.55558586120606, -- [5]
			},
			["TotemTimers_LongCooldownsFrame"] = {
				"RIGHT", -- [1]
				nil, -- [2]
				"RIGHT", -- [3]
				-340.5221557617188, -- [4]
				-11.73330497741699, -- [5]
			},
			["TotemTimers_EnhanceCDsFrame"] = {
				"RIGHT", -- [1]
				nil, -- [2]
				"RIGHT", -- [3]
				-282.1666259765625, -- [4]
				-32.39974975585938, -- [5]
			},
			["TotemTimersFrame"] = {
				"CENTER", -- [1]
				nil, -- [2]
				"CENTER", -- [3]
				-34.66678619384766, -- [4]
				-116.9780426025391, -- [5]
			},
			["TotemTimers_CastBar3"] = {
				"CENTER", -- [1]
				nil, -- [2]
				"CENTER", -- [3]
				50, -- [4]
				-190.0000152587891, -- [5]
			},
			["TotemTimers_CrowdControlFrame"] = {
				"CENTER", -- [1]
				nil, -- [2]
				"CENTER", -- [3]
				-50, -- [4]
				-50, -- [5]
			},
			["TotemTimers_MultiSpellFrame"] = {
				"CENTER", -- [1]
				nil, -- [2]
				"CENTER", -- [3]
				-300, -- [4]
				-205.0000152587891, -- [5]
			},
			["TotemTimers_CastBar4"] = {
				"CENTER", -- [1]
				nil, -- [2]
				"CENTER", -- [3]
				50, -- [4]
				-225, -- [5]
			},
			["TotemTimers_CastBar1"] = {
				"CENTER", -- [1]
				nil, -- [2]
				"CENTER", -- [3]
				-200, -- [4]
				-190.0000152587891, -- [5]
			},
		},
		["DisabledMultiSpells"] = {
		},
		["OverlayGlow"] = true,
		["FulminationAura"] = true,
		["CDTimersOnButtons"] = true,
		["LastTotems"] = {
			6364, -- [1]
			8160, -- [2]
			10495, -- [3]
			8512, -- [4]
		},
		["TrackerSpacing"] = 5,
		["EarthShieldMiddleButton"] = "targettarget",
		["Show"] = true,
		["Timer_Clickthrough"] = false,
		["TotemOrder"] = {
			{
				8181, -- [1]
				1535, -- [2]
				3599, -- [3]
				8190, -- [4]
				8227, -- [5]
			}, -- [1]
			{
				425874, -- [1]
				5730, -- [2]
				8071, -- [3]
				8075, -- [4]
				2484, -- [5]
				8143, -- [6]
			}, -- [2]
			{
				5394, -- [1]
				16190, -- [2]
				8166, -- [3]
				8170, -- [4]
				8184, -- [5]
				5675, -- [6]
			}, -- [3]
			{
				10595, -- [1]
				25908, -- [2]
				8177, -- [3]
				8835, -- [4]
				6495, -- [5]
				15107, -- [6]
				8512, -- [7]
			}, -- [4]
		},
	},
}
