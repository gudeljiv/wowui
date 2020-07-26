
WeakAurasSaved = {
	["dynamicIconCache"] = {
	},
	["displays"] = {
		["Taunt"] = {
			["glow"] = false,
			["glowLength"] = 10,
			["yOffset"] = -68.14,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/Eh5J56-nY/1",
			["actions"] = {
				["start"] = {
					["do_glow"] = true,
					["glow_type"] = "Pixel",
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Hamstring", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["unit"] = "target",
						["debuffType"] = "HARMFUL",
						["type"] = "status",
						["names"] = {
						},
						["unevent"] = "auto",
						["useName"] = true,
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Cooldown Progress (Spell)",
						["subeventPrefix"] = "SPELL",
						["realSpellName"] = "Taunt",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_unit"] = true,
						["spellName"] = 355,
						["use_genericShowOn"] = true,
						["use_track"] = true,
						["duration"] = "1",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["duration"] = "1",
						["use_showCost"] = false,
						["unit"] = "player",
						["powertype"] = 1,
						["use_requirePowerType"] = false,
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Power",
						["use_unit"] = true,
						["use_powertype"] = true,
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				{
					["trigger"] = {
						["use_form"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Stance/Form/Aura",
						["subeventPrefix"] = "SPELL",
						["form"] = {
							["single"] = 2,
						},
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["type"] = "status",
						["use_unit"] = true,
					},
					["untrigger"] = {
					},
				}, -- [3]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 23,
			["glowXOffset"] = 0,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["desaturate"] = true,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["version"] = 1,
			["subRegions"] = {
				{
					["text_shadowXOffset"] = 0,
					["type"] = "subtext",
					["text_text"] = "%s",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = 0,
					["text_selfPoint"] = "AUTO",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["anchorYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["rotateText"] = "NONE",
				}, -- [1]
			},
			["height"] = 48,
			["parent"] = "Arms",
			["glowLines"] = 8,
			["frameStrata"] = 1,
			["glowFrequency"] = 0.25,
			["icon"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["glowType"] = "Pixel",
			["glowThickness"] = 1,
			["zoom"] = 0,
			["useglowColor"] = false,
			["xOffset"] = -125.5,
			["regionType"] = "icon",
			["load"] = {
				["use_class"] = true,
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["cooldownEdge"] = false,
			["selfPoint"] = "CENTER",
			["authorOptions"] = {
			},
			["tocversion"] = 11302,
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["glowScale"] = 1,
			["id"] = "Taunt",
			["width"] = 48,
			["alpha"] = 1,
			["glowYOffset"] = 0,
			["uid"] = "UR6aFO57kPH",
			["config"] = {
			},
			["inverse"] = false,
			["keepAspectRatio"] = false,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = -1,
						["variable"] = "incombat",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = 1,
							["property"] = "alpha",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 3,
						["op"] = "==",
						["value"] = 1,
						["variable"] = "form",
					},
					["changes"] = {
						{
							["value"] = 1,
							["property"] = "alpha",
						}, -- [1]
					},
				}, -- [2]
			},
			["cooldown"] = true,
			["glowBorder"] = false,
		},
		["Charge"] = {
			["glow"] = false,
			["xOffset"] = -125.50000536442,
			["yOffset"] = -67.141929208876,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/Eh5J56-nY/1",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["subeventPrefix"] = "SPELL",
						["type"] = "status",
						["duration"] = "1",
						["unevent"] = "auto",
						["subeventSuffix"] = "_CAST_START",
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["realSpellName"] = "Charge",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["names"] = {
						},
						["event"] = "Cooldown Progress (Spell)",
						["spellName"] = 100,
						["use_track"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Stance/Form/Aura",
						["subeventPrefix"] = "SPELL",
						["powertype"] = 1,
						["unit"] = "player",
						["use_form"] = true,
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["use_powertype"] = true,
						["form"] = {
							["single"] = 1,
						},
					},
					["untrigger"] = {
					},
				}, -- [2]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 23,
			["glowXOffset"] = 0,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["desaturate"] = true,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["version"] = 1,
			["subRegions"] = {
				{
					["text_shadowXOffset"] = 0,
					["type"] = "subtext",
					["text_text"] = "%s",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = 0,
					["text_selfPoint"] = "AUTO",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["anchorYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["rotateText"] = "NONE",
				}, -- [1]
			},
			["height"] = 48,
			["parent"] = "Arms",
			["glowLines"] = 8,
			["icon"] = true,
			["glowFrequency"] = 0.25,
			["config"] = {
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["glowType"] = "buttonOverlay",
			["glowThickness"] = 1,
			["useglowColor"] = false,
			["width"] = 48,
			["alpha"] = 1,
			["regionType"] = "icon",
			["load"] = {
				["use_class"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["cooldownEdge"] = false,
			["zoom"] = 0,
			["anchorFrameType"] = "SCREEN",
			["selfPoint"] = "CENTER",
			["tocversion"] = 11302,
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["glowScale"] = 1,
			["id"] = "Charge",
			["authorOptions"] = {
			},
			["frameStrata"] = 1,
			["glowYOffset"] = 0,
			["glowLength"] = 10,
			["uid"] = "1eakFHu4lhc",
			["inverse"] = false,
			["keepAspectRatio"] = false,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = -2,
						["variable"] = "AND",
						["checks"] = {
							{
								["trigger"] = 1,
								["variable"] = "spellInRange",
								["value"] = 1,
							}, -- [1]
							{
								["trigger"] = 1,
								["variable"] = "onCooldown",
								["value"] = 0,
							}, -- [2]
							{
								["trigger"] = 1,
								["variable"] = "spellUsable",
								["value"] = 1,
							}, -- [3]
						},
					},
					["changes"] = {
						{
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
			},
			["cooldown"] = true,
			["glowBorder"] = false,
		},
		["Execute"] = {
			["glow"] = false,
			["xOffset"] = 46,
			["yOffset"] = -89.000061035156,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/Eh5J56-nY/1",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["useglowColor"] = false,
			["internalVersion"] = 23,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["desaturate"] = true,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["parent"] = "Arms",
			["version"] = 1,
			["subRegions"] = {
				{
					["text_shadowXOffset"] = 0,
					["type"] = "subtext",
					["text_text"] = "%s",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = 0,
					["text_selfPoint"] = "AUTO",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["anchorYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["rotateText"] = "NONE",
				}, -- [1]
			},
			["height"] = 40,
			["anchorFrameType"] = "SCREEN",
			["glowLines"] = 8,
			["config"] = {
			},
			["glowFrequency"] = 0.25,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["selfPoint"] = "CENTER",
			["glowType"] = "buttonOverlay",
			["glowThickness"] = 1,
			["alpha"] = 1,
			["auto"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["use_form"] = true,
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "status",
						["matchesShowOn"] = "showAlways",
						["unevent"] = "auto",
						["subeventSuffix"] = "_CAST_START",
						["form"] = {
							["single"] = 1,
						},
						["event"] = "Cooldown Progress (Spell)",
						["subeventPrefix"] = "SPELL",
						["realSpellName"] = "Execute",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["names"] = {
						},
						["use_genericShowOn"] = true,
						["use_unit"] = true,
						["use_track"] = true,
						["spellName"] = 5283,
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "aura2",
						["subeventSuffix"] = "_CAST_START",
						["matchesShowOn"] = "showAlways",
						["event"] = "Health",
						["unit"] = "player",
						["ownOnly"] = true,
						["spellIds"] = {
						},
						["auranames"] = {
							"5283", -- [1]
						},
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["useName"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				{
					["trigger"] = {
						["use_form"] = true,
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["event"] = "Stance/Form/Aura",
						["use_unit"] = true,
						["realSpellName"] = 0,
						["use_spellName"] = true,
						["unevent"] = "auto",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["form"] = {
							["single"] = 1,
							["multi"] = {
								true, -- [1]
							},
						},
						["type"] = "status",
						["spellName"] = 0,
					},
					["untrigger"] = {
					},
				}, -- [3]
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Power",
						["subeventPrefix"] = "SPELL",
						["powertype"] = 1,
						["use_unit"] = true,
						["unit"] = "player",
						["use_powertype"] = true,
						["subeventSuffix"] = "_CAST_START",
					},
					["untrigger"] = {
					},
				}, -- [4]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["regionType"] = "icon",
			["width"] = 40,
			["load"] = {
				["use_class"] = true,
				["use_spellknown"] = false,
				["talent"] = {
					["multi"] = {
						[21] = true,
						[19] = true,
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["spellknown"] = 5283,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["cooldownEdge"] = false,
			["tocversion"] = 11302,
			["zoom"] = 0,
			["glowLength"] = 10,
			["cooldownTextDisabled"] = false,
			["useGlowColor"] = false,
			["glowScale"] = 1,
			["id"] = "Execute",
			["authorOptions"] = {
			},
			["frameStrata"] = 1,
			["glowYOffset"] = 0,
			["icon"] = true,
			["uid"] = "J(Q5Fk1)bb4",
			["inverse"] = false,
			["glowXOffset"] = 0,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 2,
						["op"] = "==",
						["value"] = 0,
						["variable"] = "buffed",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = -2,
						["variable"] = "AND",
						["checks"] = {
							{
								["trigger"] = 4,
								["op"] = ">=",
								["value"] = "1",
								["variable"] = "power",
							}, -- [1]
							{
								["trigger"] = 1,
								["variable"] = "spellUsable",
								["value"] = 1,
							}, -- [2]
						},
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
						{
							["value"] = false,
							["property"] = "desaturate",
						}, -- [2]
					},
				}, -- [2]
			},
			["cooldown"] = true,
			["glowBorder"] = false,
		},
		["Thunder Clap 2"] = {
			["glow"] = false,
			["xOffset"] = -2,
			["yOffset"] = -55,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/Eh5J56-nY/1",
			["actions"] = {
				["start"] = {
					["do_glow"] = true,
					["glow_type"] = "Pixel",
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["useglowColor"] = false,
			["internalVersion"] = 23,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = true,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["version"] = 1,
			["subRegions"] = {
				{
					["text_shadowXOffset"] = 0,
					["type"] = "subtext",
					["text_text"] = "%s",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = 0,
					["text_selfPoint"] = "AUTO",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["anchorYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["rotateText"] = "NONE",
				}, -- [1]
			},
			["height"] = 25,
			["parent"] = "Arms",
			["glowLines"] = 8,
			["width"] = 25,
			["glowFrequency"] = 0.25,
			["anchorFrameType"] = "SCREEN",
			["glowXOffset"] = 0,
			["glowType"] = "Pixel",
			["glowThickness"] = 1,
			["glowLength"] = 10,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura2",
						["auranames"] = {
							"Thunder Clap", -- [1]
						},
						["ownOnly"] = true,
						["event"] = "Health",
						["unit"] = "target",
						["useName"] = true,
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["matchesShowOn"] = "showAlways",
						["names"] = {
						},
						["debuffType"] = "HARMFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["auranames"] = {
							"Hamstring", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["unit"] = "target",
						["use_tooltip"] = false,
						["use_unit"] = true,
						["buffShowOn"] = "showOnMissing",
						["subeventSuffix"] = "_CAST_START",
						["debuffType"] = "HARMFUL",
						["subeventPrefix"] = "SPELL",
						["type"] = "status",
						["use_debuffClass"] = false,
						["unevent"] = "auto",
						["use_genericShowOn"] = true,
						["matchesShowOn"] = "showOnMissing",
						["event"] = "Cooldown Progress (Spell)",
						["spellName"] = 8198,
						["realSpellName"] = "Thunder Clap",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["useName"] = true,
						["useGroup_count"] = false,
						["combineMatches"] = "showLowest",
						["use_track"] = true,
						["names"] = {
						},
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [2]
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Power",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["powertype"] = 1,
						["spellIds"] = {
						},
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [3]
				{
					["trigger"] = {
						["use_form"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Stance/Form/Aura",
						["subeventPrefix"] = "SPELL",
						["form"] = {
							["single"] = 1,
						},
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["type"] = "status",
						["use_unit"] = true,
					},
					["untrigger"] = {
					},
				}, -- [4]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["regionType"] = "icon",
			["config"] = {
			},
			["load"] = {
				["use_class"] = true,
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["zoom"] = 0,
			["frameStrata"] = 1,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["tocversion"] = 11302,
			["id"] = "Thunder Clap 2",
			["authorOptions"] = {
			},
			["alpha"] = 1,
			["glowYOffset"] = 0,
			["glowScale"] = 1,
			["uid"] = "Fzd5JTdjVri",
			["inverse"] = false,
			["cooldownEdge"] = false,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 3,
						["op"] = ">=",
						["value"] = "20",
						["variable"] = "power",
					},
					["changes"] = {
						{
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "buffed",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
						{
							["value"] = false,
							["property"] = "desaturate",
						}, -- [2]
					},
				}, -- [2]
			},
			["cooldown"] = true,
			["glowBorder"] = false,
		},
		["Warrior"] = {
			["arcLength"] = 360,
			["controlledChildren"] = {
				"Revenge", -- [1]
				"Rend", -- [2]
				"Heroic Strike", -- [3]
				"Battle Shout", -- [4]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["xOffset"] = 0,
			["yOffset"] = -100,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["space"] = 0,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["names"] = {
						},
						["type"] = "aura2",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["event"] = "Health",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["columnSpace"] = 1,
			["internalVersion"] = 23,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["align"] = "CENTER",
			["stagger"] = 0,
			["subRegions"] = {
			},
			["load"] = {
				["use_class"] = "true",
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["animate"] = false,
			["useAnchorPerUnit"] = false,
			["scale"] = 1,
			["radius"] = 200,
			["border"] = false,
			["borderEdge"] = "1 Pixel",
			["regionType"] = "dynamicgroup",
			["borderSize"] = 2,
			["sort"] = "none",
			["grow"] = "HORIZONTAL",
			["useLimit"] = false,
			["constantFactor"] = "RADIUS",
			["rotation"] = 0,
			["borderOffset"] = 4,
			["borderInset"] = 1,
			["authorOptions"] = {
			},
			["id"] = "Warrior",
			["frameStrata"] = 1,
			["gridWidth"] = 5,
			["anchorFrameType"] = "SCREEN",
			["selfPoint"] = "CENTER",
			["uid"] = "8upzfUWamW8",
			["limit"] = 5,
			["rowSpace"] = 1,
			["conditions"] = {
			},
			["gridType"] = "RD",
			["config"] = {
			},
		},
		["Battle Shout"] = {
			["glow"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["url"] = "https://wago.io/JLiVMG_1s/3",
			["icon"] = true,
			["useglowColor"] = false,
			["internalVersion"] = 23,
			["glowXOffset"] = 0,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["parent"] = "Warrior",
			["desaturate"] = true,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["zoom"] = 0,
			["version"] = 3,
			["subRegions"] = {
				{
					["text_shadowXOffset"] = 0,
					["type"] = "subtext",
					["text_text"] = "%s",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = 0,
					["text_selfPoint"] = "AUTO",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["anchorYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["rotateText"] = "NONE",
					["anchorXOffset"] = 0,
					["text_fontSize"] = 12,
				}, -- [1]
			},
			["height"] = 40,
			["glowLength"] = 10,
			["load"] = {
				["use_class"] = true,
				["use_spellknown"] = false,
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["spellknown"] = 284,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
					["glow_type"] = "ACShine",
					["glow_action"] = "show",
				},
				["finish"] = {
					["do_glow"] = false,
				},
				["init"] = {
				},
			},
			["glowFrequency"] = 0.25,
			["authorOptions"] = {
			},
			["selfPoint"] = "CENTER",
			["glowType"] = "buttonOverlay",
			["glowThickness"] = 1,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 3,
						["variable"] = "power",
						["op"] = ">=",
						["value"] = "10",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "buffed",
						["value"] = 0,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
					},
				}, -- [2]
			},
			["cooldownEdge"] = false,
			["triggers"] = {
				{
					["trigger"] = {
						["useName"] = true,
						["auranames"] = {
							"Battle Shout", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["event"] = "Health",
						["unit"] = "player",
						["spellIds"] = {
						},
						["names"] = {
						},
						["type"] = "aura2",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["auranames"] = {
							"Heroic Strike", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["spellName"] = 284,
						["type"] = "status",
						["unevent"] = "auto",
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["use_unit"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["subeventPrefix"] = "SPELL",
						["realSpellName"] = "Heroic Strike",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["useName"] = true,
						["names"] = {
						},
						["use_genericShowOn"] = true,
						["use_track"] = true,
						["ownOnly"] = true,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [2]
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Power",
						["use_unit"] = true,
						["powertype"] = 1,
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["use_powertype"] = true,
						["subeventSuffix"] = "_CAST_START",
					},
					["untrigger"] = {
					},
				}, -- [3]
				["disjunctive"] = "all",
				["activeTriggerMode"] = 1,
			},
			["regionType"] = "icon",
			["uid"] = "1TGMbWPUxxN",
			["glowLines"] = 8,
			["width"] = 40,
			["frameStrata"] = 1,
			["tocversion"] = 11302,
			["auto"] = true,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.0.2",
			["glowScale"] = 1,
			["id"] = "Battle Shout",
			["glowYOffset"] = 0,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["xOffset"] = -100,
			["config"] = {
			},
			["inverse"] = false,
			["keepAspectRatio"] = false,
			["displayIcon"] = 132282,
			["cooldown"] = true,
			["glowBorder"] = false,
		},
		["Mortal Strike"] = {
			["glow"] = false,
			["xOffset"] = 100.49991951386,
			["yOffset"] = -76.113434840648,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["cooldownEdge"] = false,
			["icon"] = true,
			["useglowColor"] = false,
			["internalVersion"] = 23,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["desaturate"] = true,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["parent"] = "Arms",
			["version"] = 1,
			["subRegions"] = {
				{
					["text_shadowXOffset"] = 0,
					["type"] = "subtext",
					["text_text"] = "%s",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = 0,
					["text_selfPoint"] = "AUTO",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["anchorYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["rotateText"] = "NONE",
				}, -- [1]
			},
			["height"] = 67,
			["alpha"] = 1,
			["glowLines"] = 8,
			["config"] = {
			},
			["glowFrequency"] = 0.25,
			["glowXOffset"] = 0,
			["glowLength"] = 10,
			["glowType"] = "buttonOverlay",
			["glowThickness"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura2",
						["subeventSuffix"] = "_CAST_START",
						["matchesShowOn"] = "showAlways",
						["event"] = "Health",
						["unit"] = "player",
						["ownOnly"] = true,
						["spellIds"] = {
						},
						["auranames"] = {
							"Mortal Strike", -- [1]
						},
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["useName"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Power",
						["subeventPrefix"] = "SPELL",
						["powertype"] = 1,
						["use_unit"] = true,
						["unit"] = "player",
						["use_powertype"] = true,
						["subeventSuffix"] = "_CAST_START",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["regionType"] = "icon",
			["width"] = 67,
			["load"] = {
				["use_class"] = true,
				["use_spellknown"] = false,
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 18,
					["multi"] = {
						[21] = true,
						[19] = true,
					},
				},
				["use_talent"] = true,
				["spec"] = {
					["multi"] = {
					},
				},
				["spellknown"] = 5283,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["url"] = "https://wago.io/Eh5J56-nY/1",
			["tocversion"] = 11302,
			["zoom"] = 0,
			["authorOptions"] = {
			},
			["cooldownTextDisabled"] = false,
			["useGlowColor"] = false,
			["glowScale"] = 1,
			["id"] = "Mortal Strike",
			["selfPoint"] = "CENTER",
			["frameStrata"] = 1,
			["glowYOffset"] = 0,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["uid"] = "rHlAoLGGCWz",
			["inverse"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = 0,
						["variable"] = "buffed",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = -2,
						["variable"] = "AND",
						["checks"] = {
							{
								["trigger"] = 2,
								["op"] = ">=",
								["value"] = "1",
								["variable"] = "power",
							}, -- [1]
							{
								["value"] = 1,
								["variable"] = "spellUsable",
							}, -- [2]
						},
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
						{
							["value"] = false,
							["property"] = "desaturate",
						}, -- [2]
					},
				}, -- [2]
			},
			["cooldown"] = true,
			["glowBorder"] = false,
		},
		["Thunder Clap"] = {
			["glow"] = false,
			["xOffset"] = -2,
			["yOffset"] = -55,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/Eh5J56-nY/1",
			["actions"] = {
				["start"] = {
					["do_glow"] = true,
					["glow_type"] = "Pixel",
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["useglowColor"] = false,
			["internalVersion"] = 23,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["desaturate"] = true,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["version"] = 1,
			["subRegions"] = {
				{
					["text_shadowXOffset"] = 0,
					["type"] = "subtext",
					["text_text"] = "%s",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = 0,
					["text_selfPoint"] = "AUTO",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["anchorYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["rotateText"] = "NONE",
				}, -- [1]
			},
			["height"] = 25,
			["parent"] = "Arms",
			["glowLines"] = 8,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["glowFrequency"] = 0.25,
			["tocversion"] = 11302,
			["glowXOffset"] = 0,
			["glowType"] = "Pixel",
			["glowThickness"] = 1,
			["uid"] = "F5qcAw92t62",
			["glowLength"] = 10,
			["authorOptions"] = {
			},
			["regionType"] = "icon",
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Hamstring", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HARMFUL",
						["useName"] = true,
						["spellName"] = 8198,
						["unevent"] = "auto",
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Cooldown Progress (Spell)",
						["type"] = "status",
						["realSpellName"] = "Thunder Clap",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["matchesShowOn"] = "showAlways",
						["use_genericShowOn"] = true,
						["use_unit"] = true,
						["use_track"] = true,
						["unit"] = "target",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["duration"] = "1",
						["use_showCost"] = false,
						["unit"] = "player",
						["powertype"] = 1,
						["use_requirePowerType"] = false,
						["event"] = "Power",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["use_powertype"] = true,
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["form"] = {
							["single"] = 1,
						},
						["event"] = "Stance/Form/Aura",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["duration"] = "1",
						["subeventSuffix"] = "_CAST_START",
						["use_form"] = true,
						["use_unit"] = true,
					},
					["untrigger"] = {
					},
				}, -- [3]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["alpha"] = 1,
			["load"] = {
				["use_class"] = true,
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["selfPoint"] = "CENTER",
			["width"] = 25,
			["icon"] = true,
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["glowScale"] = 1,
			["id"] = "Thunder Clap",
			["zoom"] = 0,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["glowYOffset"] = 0,
			["config"] = {
			},
			["inverse"] = false,
			["cooldownEdge"] = false,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = -1,
						["variable"] = "incombat",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = 1,
							["property"] = "alpha",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 3,
						["op"] = "==",
						["value"] = 1,
						["variable"] = "form",
					},
					["changes"] = {
						{
							["value"] = 1,
							["property"] = "alpha",
						}, -- [1]
					},
				}, -- [2]
			},
			["cooldown"] = true,
			["glowBorder"] = false,
		},
		["Shield Block"] = {
			["glow"] = false,
			["authorOptions"] = {
			},
			["yOffset"] = -55,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/Eh5J56-nY/1",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["useglowColor"] = false,
			["internalVersion"] = 23,
			["glowXOffset"] = 0,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["desaturate"] = true,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["parent"] = "Arms",
			["version"] = 1,
			["subRegions"] = {
				{
					["text_shadowXOffset"] = 0,
					["type"] = "subtext",
					["text_text"] = "%s",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = 0,
					["text_selfPoint"] = "AUTO",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["anchorYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["rotateText"] = "NONE",
				}, -- [1]
			},
			["height"] = 25,
			["icon"] = true,
			["glowLines"] = 8,
			["frameStrata"] = 1,
			["glowFrequency"] = 0.25,
			["selfPoint"] = "CENTER",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["glowType"] = "buttonOverlay",
			["glowThickness"] = 1,
			["glowLength"] = 10,
			["triggers"] = {
				{
					["trigger"] = {
						["use_form"] = true,
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "status",
						["names"] = {
						},
						["unevent"] = "auto",
						["spellName"] = 2565,
						["form"] = {
							["single"] = 1,
						},
						["event"] = "Cooldown Progress (Spell)",
						["subeventSuffix"] = "_CAST_START",
						["realSpellName"] = "Shield Block",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["use_genericShowOn"] = true,
						["use_track"] = true,
						["duration"] = "1",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["useName"] = true,
						["auranames"] = {
							"Shield Block", -- [1]
						},
						["ownOnly"] = true,
						["event"] = "Health",
						["unit"] = "player",
						["type"] = "aura2",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["matchesShowOn"] = "showAlways",
						["names"] = {
						},
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				{
					["trigger"] = {
						["use_form"] = true,
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["event"] = "Stance/Form/Aura",
						["subeventPrefix"] = "SPELL",
						["realSpellName"] = 0,
						["use_spellName"] = true,
						["unevent"] = "auto",
						["unit"] = "player",
						["use_unit"] = true,
						["form"] = {
							["single"] = 2,
						},
						["type"] = "status",
						["spellName"] = 0,
					},
					["untrigger"] = {
					},
				}, -- [3]
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Power",
						["use_unit"] = true,
						["powertype"] = 1,
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["use_powertype"] = true,
						["subeventSuffix"] = "_CAST_START",
					},
					["untrigger"] = {
					},
				}, -- [4]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["load"] = {
				["use_class"] = true,
				["use_spellknown"] = false,
				["talent"] = {
					["multi"] = {
						[21] = true,
						[19] = true,
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["spellknown"] = 5283,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["regionType"] = "icon",
			["uid"] = "T)Whfq7kkCc",
			["width"] = 25,
			["zoom"] = 0,
			["useGlowColor"] = false,
			["anchorFrameType"] = "SCREEN",
			["tocversion"] = 11302,
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["glowScale"] = 1,
			["id"] = "Shield Block",
			["xOffset"] = -29,
			["alpha"] = 1,
			["glowYOffset"] = 0,
			["keepAspectRatio"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["cooldownEdge"] = false,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 2,
						["op"] = "==",
						["value"] = 0,
						["variable"] = "buffed",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = -2,
						["variable"] = "AND",
						["checks"] = {
							{
								["trigger"] = 4,
								["op"] = ">=",
								["value"] = "10",
								["variable"] = "power",
							}, -- [1]
							{
								["trigger"] = 1,
								["variable"] = "spellUsable",
								["value"] = 1,
							}, -- [2]
						},
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
						{
							["value"] = false,
							["property"] = "desaturate",
						}, -- [2]
					},
				}, -- [2]
			},
			["cooldown"] = true,
			["glowBorder"] = false,
		},
		["Taunt2"] = {
			["glow"] = false,
			["xOffset"] = -125.5,
			["yOffset"] = -68.14,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/Eh5J56-nY/1",
			["actions"] = {
				["start"] = {
					["do_glow"] = true,
					["glow_type"] = "Pixel",
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["useglowColor"] = false,
			["internalVersion"] = 23,
			["glowXOffset"] = 0,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["desaturate"] = true,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["version"] = 1,
			["subRegions"] = {
				{
					["text_shadowXOffset"] = 0,
					["type"] = "subtext",
					["text_text"] = "%s",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = 0,
					["text_selfPoint"] = "AUTO",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["anchorYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["rotateText"] = "NONE",
				}, -- [1]
			},
			["height"] = 48,
			["parent"] = "Arms",
			["glowLines"] = 8,
			["selfPoint"] = "CENTER",
			["glowFrequency"] = 0.25,
			["authorOptions"] = {
			},
			["cooldownEdge"] = false,
			["glowType"] = "Pixel",
			["glowThickness"] = 1,
			["anchorFrameType"] = "SCREEN",
			["uid"] = "4vdVpT9hRTh",
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "status",
						["unevent"] = "auto",
						["use_unit"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["subeventSuffix"] = "_CAST_START",
						["realSpellName"] = "Taunt",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["use_genericShowOn"] = true,
						["names"] = {
						},
						["use_track"] = true,
						["spellName"] = 355,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["useName"] = true,
						["auranames"] = {
							"Taunt", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["event"] = "Health",
						["unit"] = "target",
						["ownOnly"] = true,
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["type"] = "aura2",
						["debuffType"] = "HARMFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				{
					["trigger"] = {
						["use_requirePowerType"] = false,
						["type"] = "status",
						["subeventSuffix"] = "_CAST_START",
						["unevent"] = "auto",
						["use_unit"] = true,
						["duration"] = "1",
						["use_showCost"] = false,
						["unit"] = "player",
						["event"] = "Power",
						["powertype"] = 1,
						["spellIds"] = {
						},
						["use_power"] = false,
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [3]
				{
					["trigger"] = {
						["use_form"] = true,
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["event"] = "Stance/Form/Aura",
						["unit"] = "player",
						["use_unit"] = true,
						["unevent"] = "auto",
						["spellIds"] = {
						},
						["type"] = "status",
						["form"] = {
							["single"] = 2,
						},
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [4]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["regionType"] = "icon",
			["glowLength"] = 10,
			["load"] = {
				["use_class"] = true,
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["keepAspectRatio"] = false,
			["tocversion"] = 11302,
			["icon"] = true,
			["frameStrata"] = 1,
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["glowScale"] = 1,
			["id"] = "Taunt2",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["alpha"] = 1,
			["glowYOffset"] = 0,
			["width"] = 48,
			["config"] = {
			},
			["inverse"] = false,
			["zoom"] = 0,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = -2,
						["variable"] = "AND",
						["checks"] = {
							{
								["trigger"] = 4,
								["op"] = "==",
								["value"] = 2,
								["variable"] = "form",
							}, -- [1]
							{
								["trigger"] = 1,
								["variable"] = "onCooldown",
								["value"] = 1,
							}, -- [2]
						},
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
						{
							["property"] = "desaturate",
						}, -- [2]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "spellInRange",
						["value"] = 1,
					},
					["changes"] = {
						{
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [2]
			},
			["cooldown"] = true,
			["glowBorder"] = false,
		},
		["Arms"] = {
			["controlledChildren"] = {
				"Shield Bash", -- [1]
				"Shield Bash 2", -- [2]
				"Thunder Clap", -- [3]
				"Thunder Clap 2", -- [4]
				"Hamstring", -- [5]
				"Hamstring 2", -- [6]
				"Demoralizing Shout", -- [7]
				"Overpower", -- [8]
				"Shield Block", -- [9]
				"Execute", -- [10]
				"Shield Slam", -- [11]
				"Mortal Strike", -- [12]
				"Heroic Strike 2", -- [13]
				"Battle Shout 2", -- [14]
				"Taunt", -- [15]
				"Taunt2", -- [16]
				"Charge", -- [17]
				"Blood Rage", -- [18]
				"Swing Timer 2", -- [19]
				"Rage 2", -- [20]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["authorOptions"] = {
			},
			["yOffset"] = 581.005823168477,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["url"] = "https://wago.io/Eh5J56-nY/1",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["debuffType"] = "HELPFUL",
						["type"] = "aura2",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["event"] = "Health",
						["unit"] = "player",
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["internalVersion"] = 23,
			["selfPoint"] = "BOTTOMLEFT",
			["version"] = 1,
			["subRegions"] = {
			},
			["load"] = {
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["scale"] = 0.95,
			["border"] = false,
			["borderEdge"] = "1 Pixel",
			["regionType"] = "group",
			["borderSize"] = 2,
			["borderOffset"] = 4,
			["tocversion"] = 11302,
			["id"] = "Arms",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["uid"] = "Jw0wPIpkBVZ",
			["config"] = {
			},
			["xOffset"] = 11.2273854102869,
			["groupIcon"] = 132355,
			["conditions"] = {
			},
			["borderInset"] = 1,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
		},
		["Overpower"] = {
			["glow"] = false,
			["xOffset"] = 4,
			["yOffset"] = -89.000061035156,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["cooldownEdge"] = false,
			["icon"] = true,
			["useglowColor"] = false,
			["internalVersion"] = 23,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["desaturate"] = true,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["parent"] = "Arms",
			["version"] = 1,
			["subRegions"] = {
				{
					["text_shadowXOffset"] = 0,
					["type"] = "subtext",
					["text_text"] = "%s",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = 0,
					["text_selfPoint"] = "AUTO",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["anchorYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["rotateText"] = "NONE",
				}, -- [1]
			},
			["height"] = 40,
			["anchorFrameType"] = "SCREEN",
			["glowLines"] = 8,
			["glowXOffset"] = 0,
			["glowFrequency"] = 0.25,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["uid"] = "7)K8xWJ8t3W",
			["glowType"] = "buttonOverlay",
			["glowThickness"] = 1,
			["glowLength"] = 10,
			["triggers"] = {
				{
					["trigger"] = {
						["use_form"] = true,
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "status",
						["names"] = {
						},
						["unevent"] = "auto",
						["subeventSuffix"] = "_CAST_START",
						["form"] = {
							["single"] = 1,
						},
						["event"] = "Cooldown Progress (Spell)",
						["use_unit"] = true,
						["realSpellName"] = "Overpower",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["duration"] = "1",
						["spellName"] = 7384,
						["use_genericShowOn"] = true,
						["use_track"] = true,
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["use_form"] = true,
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["event"] = "Stance/Form/Aura",
						["use_unit"] = true,
						["realSpellName"] = 0,
						["use_spellName"] = true,
						["unevent"] = "auto",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["form"] = {
							["single"] = 1,
						},
						["type"] = "status",
						["spellName"] = 0,
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["glowScale"] = 1,
			["regionType"] = "icon",
			["load"] = {
				["use_class"] = true,
				["use_spellknown"] = true,
				["talent"] = {
					["multi"] = {
						[21] = true,
						[19] = true,
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["spellknown"] = 7384,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["width"] = 40,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["zoom"] = 0,
			["useGlowColor"] = false,
			["frameStrata"] = 1,
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["tocversion"] = 11302,
			["id"] = "Overpower",
			["authorOptions"] = {
			},
			["alpha"] = 1,
			["glowYOffset"] = 0,
			["selfPoint"] = "CENTER",
			["config"] = {
			},
			["inverse"] = false,
			["url"] = "https://wago.io/Eh5J56-nY/1",
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "spellUsable",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
						{
							["property"] = "desaturate",
						}, -- [2]
					},
				}, -- [1]
				{
					["check"] = {
					},
					["changes"] = {
						{
						}, -- [1]
					},
				}, -- [2]
			},
			["cooldown"] = true,
			["glowBorder"] = false,
		},
		["Shield Bash 2"] = {
			["glow"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = -55,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/Eh5J56-nY/1",
			["actions"] = {
				["start"] = {
					["do_glow"] = true,
					["glow_type"] = "Pixel",
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["useglowColor"] = false,
			["internalVersion"] = 23,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["desaturate"] = true,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["version"] = 1,
			["subRegions"] = {
				{
					["text_shadowXOffset"] = 0,
					["type"] = "subtext",
					["text_text"] = "%s",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = 0,
					["text_selfPoint"] = "AUTO",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["anchorYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["rotateText"] = "NONE",
				}, -- [1]
			},
			["height"] = 25,
			["parent"] = "Arms",
			["glowLines"] = 8,
			["glowXOffset"] = 0,
			["glowFrequency"] = 0.25,
			["tocversion"] = 11302,
			["cooldownEdge"] = false,
			["glowType"] = "Pixel",
			["glowThickness"] = 1,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0,
			["authorOptions"] = {
			},
			["regionType"] = "icon",
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "status",
						["unevent"] = "auto",
						["names"] = {
						},
						["event"] = "Cooldown Progress (Spell)",
						["subeventPrefix"] = "SPELL",
						["realSpellName"] = "Shield Bash",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["use_genericShowOn"] = true,
						["use_unit"] = true,
						["use_track"] = true,
						["spellName"] = 72,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "aura2",
						["auranames"] = {
							"Shield Bash", -- [1]
						},
						["ownOnly"] = true,
						["event"] = "Health",
						["unit"] = "target",
						["matchesShowOn"] = "showAlways",
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["useName"] = true,
						["names"] = {
						},
						["debuffType"] = "HARMFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				{
					["trigger"] = {
						["use_requirePowerType"] = false,
						["type"] = "status",
						["use_unit"] = true,
						["unevent"] = "auto",
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["use_showCost"] = false,
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["powertype"] = 1,
						["spellIds"] = {
						},
						["event"] = "Power",
						["use_power"] = false,
						["names"] = {
						},
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [3]
				{
					["trigger"] = {
						["use_form"] = true,
						["unevent"] = "auto",
						["form"] = {
							["single"] = 2,
						},
						["event"] = "Stance/Form/Aura",
						["unit"] = "player",
						["duration"] = "1",
						["names"] = {
						},
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["type"] = "status",
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [4]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["glowLength"] = 10,
			["load"] = {
				["use_class"] = true,
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["width"] = 25,
			["icon"] = true,
			["frameStrata"] = 1,
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["glowScale"] = 1,
			["id"] = "Shield Bash 2",
			["selfPoint"] = "CENTER",
			["alpha"] = 1,
			["glowYOffset"] = 0,
			["xOffset"] = -2,
			["config"] = {
			},
			["inverse"] = false,
			["uid"] = "Okt4bxlrNpr",
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = -2,
						["variable"] = "AND",
						["checks"] = {
							{
								["trigger"] = 4,
								["op"] = "==",
								["value"] = 2,
								["variable"] = "form",
							}, -- [1]
							{
								["trigger"] = 2,
								["op"] = "==",
								["value"] = "1",
								["variable"] = "stacks",
							}, -- [2]
						},
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
						{
							["property"] = "desaturate",
						}, -- [2]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 3,
						["op"] = ">=",
						["variable"] = "power",
						["value"] = "10",
					},
					["changes"] = {
						{
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [2]
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "onCooldown",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
						{
							["property"] = "desaturate",
						}, -- [2]
					},
				}, -- [3]
			},
			["cooldown"] = true,
			["glowBorder"] = false,
		},
		["Rage"] = {
			["sparkWidth"] = 10,
			["sparkOffsetX"] = 0,
			["parent"] = "RageBar - SwingTimer",
			["yOffset"] = -127.56465435028,
			["anchorPoint"] = "CENTER",
			["spark"] = false,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["url"] = "https://wago.io/JLiVMG_1s/3",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "status",
						["matchesShowOn"] = "showAlways",
						["unevent"] = "auto",
						["unit"] = "player",
						["duration"] = "1",
						["use_showCost"] = true,
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["powertype"] = 1,
						["spellIds"] = {
						},
						["use_unit"] = true,
						["event"] = "Power",
						["subeventPrefix"] = "SPELL",
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["internalVersion"] = 23,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["backdropInFront"] = false,
			["text"] = false,
			["barColor"] = {
				1, -- [1]
				0.066666666666667, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["icon"] = false,
			["sparkOffsetY"] = 0,
			["version"] = 3,
			["subRegions"] = {
				{
					["type"] = "aurabar_bar",
				}, -- [1]
				{
					["text_shadowXOffset"] = 1,
					["type"] = "subtext",
					["text_text"] = "%p",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = -1,
					["text_selfPoint"] = "AUTO",
					["text_anchorXOffset"] = 1,
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_LEFT",
					["anchorYOffset"] = 0,
					["text_fontSize"] = 12,
					["rotateText"] = "NONE",
					["anchorXOffset"] = 0,
					["text_fontType"] = "None",
				}, -- [2]
				{
					["text_shadowXOffset"] = 1,
					["type"] = "subtext",
					["text_text"] = "%n",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = -1,
					["text_selfPoint"] = "AUTO",
					["text_visible"] = false,
					["text_anchorPoint"] = "INNER_RIGHT",
					["anchorYOffset"] = 0,
					["text_fontType"] = "None",
					["rotateText"] = "NONE",
					["anchorXOffset"] = 0,
					["text_fontSize"] = 12,
				}, -- [3]
				{
					["border_offset"] = 5,
					["border_anchor"] = "bar",
					["type"] = "subborder",
					["border_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						0.5, -- [4]
					},
					["border_visible"] = false,
					["border_edge"] = "None",
					["border_size"] = 16,
				}, -- [4]
			},
			["height"] = 31.870697021484,
			["selfPoint"] = "CENTER",
			["load"] = {
				["use_class"] = true,
				["use_spellknown"] = false,
				["talent"] = {
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["spellknown"] = 7384,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["sparkBlendMode"] = "ADD",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["authorOptions"] = {
			},
			["xOffset"] = 18.249946594238,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["config"] = {
			},
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["borderInFront"] = true,
			["width"] = 230,
			["icon_side"] = "RIGHT",
			["frameStrata"] = 1,
			["sparkHeight"] = 30,
			["texture"] = "Armory",
			["sparkHidden"] = "NEVER",
			["zoom"] = 0,
			["auto"] = true,
			["tocversion"] = 11302,
			["id"] = "Rage",
			["semver"] = "1.0.2",
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["useAdjustededMax"] = false,
			["uid"] = "TTuNmPTb5xp",
			["inverse"] = false,
			["borderBackdrop"] = "Blizzard Tooltip",
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["stickyDuration"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
		},
		["Battle Shout 2"] = {
			["glow"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = -89,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["cooldownEdge"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["useglowColor"] = false,
			["internalVersion"] = 23,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["colorR"] = 1,
					["scalex"] = 0,
					["alphaType"] = "alphaPulse",
					["colorB"] = 1,
					["colorG"] = 1,
					["alphaFunc"] = "    function(progress, start, delta)\n      local angle = (progress * 2 * math.pi) - (math.pi / 2)\n      return start + (((math.sin(angle) + 1)/2) * delta)\n    end\n  ",
					["use_alpha"] = false,
					["scaleType"] = "pulse",
					["use_scale"] = false,
					["scaley"] = 0,
					["alpha"] = 0,
					["scaleFunc"] = "    function(progress, startX, startY, scaleX, scaleY)\n      local angle = (progress * 2 * math.pi) - (math.pi / 2)\n      return startX + (((math.sin(angle) + 1)/2) * (scaleX - 1)), startY + (((math.sin(angle) + 1)/2) * (scaleY - 1))\n    end\n  ",
					["y"] = 0,
					["x"] = 0,
					["use_color"] = false,
					["duration_type"] = "seconds",
					["type"] = "none",
					["rotate"] = 0,
					["duration"] = "1%",
					["colorA"] = 1,
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["parent"] = "Arms",
			["desaturate"] = false,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["icon"] = true,
			["version"] = 1,
			["subRegions"] = {
				{
					["text_shadowXOffset"] = 0,
					["type"] = "subtext",
					["text_text"] = "%s",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = 0,
					["text_selfPoint"] = "AUTO",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["anchorYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["rotateText"] = "NONE",
				}, -- [1]
			},
			["height"] = 40,
			["glowXOffset"] = 0,
			["glowLines"] = 8,
			["selfPoint"] = "CENTER",
			["glowFrequency"] = 0.25,
			["uid"] = "dVcL)VamKKc",
			["anchorFrameType"] = "SCREEN",
			["glowType"] = "buttonOverlay",
			["glowThickness"] = 1,
			["triggers"] = {
				{
					["trigger"] = {
						["useName"] = true,
						["auranames"] = {
							"Battle Shout", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["event"] = "Health",
						["unit"] = "player",
						["spellIds"] = {
						},
						["names"] = {
						},
						["type"] = "aura2",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["use_form"] = true,
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["powertype"] = 1,
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
						["use_unit"] = true,
						["use_remaining"] = false,
						["spellName"] = 5242,
						["unevent"] = "auto",
						["subeventSuffix"] = "_CAST_START",
						["type"] = "status",
						["event"] = "Cooldown Progress (Spell)",
						["duration"] = "1",
						["realSpellName"] = "Battle Shout",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["names"] = {
						},
						["use_inverse"] = true,
						["use_genericShowOn"] = true,
						["use_track"] = true,
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [2]
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Power",
						["use_unit"] = true,
						["powertype"] = 1,
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["use_powertype"] = true,
						["subeventSuffix"] = "_CAST_START",
					},
					["untrigger"] = {
					},
				}, -- [3]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["glowScale"] = 1,
			["load"] = {
				["use_class"] = true,
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["regionType"] = "icon",
			["url"] = "https://wago.io/Eh5J56-nY/1",
			["auto"] = false,
			["authorOptions"] = {
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "<=",
						["value"] = 0,
						["variable"] = "buffed",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [2]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 3,
						["op"] = ">=",
						["value"] = "15",
						["variable"] = "power",
					},
					["changes"] = {
						{
							["value"] = false,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [2]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = ">=",
						["value"] = 1,
						["variable"] = "buffed",
					},
					["changes"] = {
						{
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [3]
			},
			["frameStrata"] = 1,
			["zoom"] = 0,
			["cooldownTextDisabled"] = false,
			["useGlowColor"] = false,
			["tocversion"] = 11302,
			["id"] = "Battle Shout 2",
			["width"] = 40,
			["alpha"] = 1,
			["glowYOffset"] = 0,
			["xOffset"] = -80.000061035156,
			["config"] = {
			},
			["inverse"] = false,
			["glowLength"] = 10,
			["displayIcon"] = 132333,
			["cooldown"] = true,
			["glowBorder"] = false,
		},
		["Swing Timer"] = {
			["sparkWidth"] = 20,
			["sparkOffsetX"] = 0,
			["parent"] = "RageBar - SwingTimer",
			["yOffset"] = -156.12695744284,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["url"] = "https://wago.io/JLiVMG_1s/3",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["triggers"] = {
				{
					["trigger"] = {
						["use_castType"] = false,
						["type"] = "status",
						["matchesShowOn"] = "showAlways",
						["unevent"] = "auto",
						["event"] = "Swing Timer",
						["duration"] = "1",
						["use_spell"] = false,
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["spellIds"] = {
						},
						["use_hand"] = true,
						["names"] = {
						},
						["use_unit"] = true,
						["hand"] = "main",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["internalVersion"] = 23,
			["auto"] = true,
			["selfPoint"] = "CENTER",
			["backdropInFront"] = false,
			["barColor"] = {
				0, -- [1]
				0.63529411764706, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["stickyDuration"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["authorOptions"] = {
			},
			["version"] = 3,
			["subRegions"] = {
				{
					["type"] = "aurabar_bar",
				}, -- [1]
				{
					["text_shadowXOffset"] = 1,
					["type"] = "subtext",
					["text_text"] = "%p",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = -1,
					["text_selfPoint"] = "AUTO",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_LEFT",
					["anchorYOffset"] = 0,
					["text_fontType"] = "None",
					["rotateText"] = "NONE",
					["anchorXOffset"] = 0,
					["text_fontSize"] = 12,
				}, -- [2]
				{
					["text_shadowXOffset"] = 1,
					["type"] = "subtext",
					["text_text"] = "%n",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = -1,
					["text_selfPoint"] = "AUTO",
					["text_visible"] = false,
					["text_anchorPoint"] = "INNER_RIGHT",
					["anchorYOffset"] = 0,
					["text_fontType"] = "None",
					["rotateText"] = "NONE",
					["anchorXOffset"] = 0,
					["text_fontSize"] = 12,
				}, -- [3]
				{
					["border_offset"] = 5,
					["border_anchor"] = "bar",
					["type"] = "subborder",
					["border_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						0.5, -- [4]
					},
					["border_visible"] = false,
					["border_edge"] = "None",
					["border_size"] = 16,
				}, -- [4]
			},
			["height"] = 7,
			["borderBackdrop"] = "Blizzard Tooltip",
			["load"] = {
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["sparkBlendMode"] = "ADD",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["xOffset"] = 18.249756377361,
			["desaturate"] = false,
			["config"] = {
			},
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["borderInFront"] = true,
			["width"] = 230,
			["icon_side"] = "RIGHT",
			["alpha"] = 1,
			["sparkHeight"] = 20,
			["texture"] = "Armory",
			["sparkHidden"] = "NEVER",
			["zoom"] = 0,
			["spark"] = true,
			["tocversion"] = 11302,
			["id"] = "Swing Timer",
			["semver"] = "1.0.2",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["useAdjustededMax"] = false,
			["uid"] = "5jTwMsRORGQ",
			["inverse"] = true,
			["icon"] = false,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "interruptible",
						["value"] = 0,
					},
					["changes"] = {
						{
							["value"] = {
								0.8, -- [1]
								0.1, -- [2]
								0.1, -- [3]
								1, -- [4]
							},
							["property"] = "barColor",
						}, -- [1]
					},
				}, -- [1]
			},
			["sparkOffsetY"] = 0,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
		},
		["Shield Bash"] = {
			["glow"] = false,
			["xOffset"] = -2,
			["yOffset"] = -55,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/Eh5J56-nY/1",
			["actions"] = {
				["start"] = {
					["do_glow"] = true,
					["glow_type"] = "Pixel",
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["useglowColor"] = false,
			["internalVersion"] = 23,
			["glowXOffset"] = 0,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["desaturate"] = true,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["version"] = 1,
			["subRegions"] = {
				{
					["text_shadowXOffset"] = 0,
					["type"] = "subtext",
					["text_text"] = "%s",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = 0,
					["text_selfPoint"] = "AUTO",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["anchorYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["rotateText"] = "NONE",
				}, -- [1]
			},
			["height"] = 25,
			["parent"] = "Arms",
			["glowLines"] = 8,
			["selfPoint"] = "CENTER",
			["glowFrequency"] = 0.25,
			["authorOptions"] = {
			},
			["cooldownEdge"] = false,
			["glowType"] = "Pixel",
			["glowThickness"] = 1,
			["anchorFrameType"] = "SCREEN",
			["uid"] = "N0sP7H9uOys",
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Hamstring", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HARMFUL",
						["useName"] = true,
						["duration"] = "1",
						["unevent"] = "auto",
						["use_unit"] = true,
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Cooldown Progress (Spell)",
						["type"] = "status",
						["realSpellName"] = "Shield Bash",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_genericShowOn"] = true,
						["names"] = {
						},
						["unit"] = "target",
						["use_track"] = true,
						["spellName"] = 72,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["duration"] = "1",
						["use_showCost"] = false,
						["unit"] = "player",
						["powertype"] = 1,
						["use_requirePowerType"] = false,
						["event"] = "Power",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["use_powertype"] = true,
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				{
					["trigger"] = {
						["use_form"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Stance/Form/Aura",
						["unit"] = "player",
						["form"] = {
							["single"] = 2,
						},
						["subeventSuffix"] = "_CAST_START",
						["type"] = "status",
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
					},
				}, -- [3]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["regionType"] = "icon",
			["glowLength"] = 10,
			["load"] = {
				["use_class"] = true,
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["keepAspectRatio"] = false,
			["tocversion"] = 11302,
			["icon"] = true,
			["frameStrata"] = 1,
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["glowScale"] = 1,
			["id"] = "Shield Bash",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["alpha"] = 1,
			["glowYOffset"] = 0,
			["width"] = 25,
			["config"] = {
			},
			["inverse"] = false,
			["zoom"] = 0,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = -1,
						["variable"] = "incombat",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = 1,
							["property"] = "alpha",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 3,
						["op"] = "==",
						["value"] = 1,
						["variable"] = "form",
					},
					["changes"] = {
						{
							["value"] = 1,
							["property"] = "alpha",
						}, -- [1]
					},
				}, -- [2]
			},
			["cooldown"] = true,
			["glowBorder"] = false,
		},
		["Demoralizing Shout"] = {
			["glow"] = false,
			["authorOptions"] = {
			},
			["yOffset"] = -55,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/Eh5J56-nY/1",
			["actions"] = {
				["start"] = {
					["do_glow"] = true,
					["glow_type"] = "Pixel",
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["useglowColor"] = false,
			["internalVersion"] = 23,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["desaturate"] = true,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["version"] = 1,
			["subRegions"] = {
				{
					["text_shadowXOffset"] = 0,
					["type"] = "subtext",
					["text_text"] = "%s",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = 0,
					["text_selfPoint"] = "AUTO",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["anchorYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["rotateText"] = "NONE",
				}, -- [1]
			},
			["height"] = 25,
			["parent"] = "Arms",
			["glowLines"] = 8,
			["glowXOffset"] = 0,
			["glowFrequency"] = 0.25,
			["alpha"] = 1,
			["cooldownEdge"] = false,
			["glowType"] = "Pixel",
			["glowThickness"] = 1,
			["selfPoint"] = "CENTER",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura2",
						["auranames"] = {
							"Demoralizing Shout", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["event"] = "Health",
						["unit"] = "target",
						["spellIds"] = {
						},
						["names"] = {
						},
						["useName"] = true,
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HARMFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["auranames"] = {
							"Hamstring", -- [1]
						},
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showAlways",
						["names"] = {
						},
						["use_tooltip"] = false,
						["unit"] = "target",
						["useGroup_count"] = false,
						["subeventSuffix"] = "_CAST_START",
						["debuffType"] = "HARMFUL",
						["subeventPrefix"] = "SPELL",
						["type"] = "status",
						["use_debuffClass"] = false,
						["unevent"] = "auto",
						["matchesShowOn"] = "showOnMissing",
						["buffShowOn"] = "showOnMissing",
						["event"] = "Cooldown Progress (Spell)",
						["spellName"] = 1160,
						["realSpellName"] = "Demoralizing Shout",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["useName"] = true,
						["use_unit"] = true,
						["combineMatches"] = "showLowest",
						["use_track"] = true,
						["duration"] = "1",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [2]
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Power",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["powertype"] = 1,
						["spellIds"] = {
						},
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [3]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["regionType"] = "icon",
			["uid"] = "yBAFxpK6I3h",
			["load"] = {
				["use_class"] = true,
				["use_spellknown"] = false,
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["spellknown"] = 1160,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["anchorFrameType"] = "SCREEN",
			["tocversion"] = 11302,
			["icon"] = true,
			["xOffset"] = -85,
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["glowScale"] = 1,
			["id"] = "Demoralizing Shout",
			["glowLength"] = 10,
			["frameStrata"] = 1,
			["glowYOffset"] = 0,
			["width"] = 25,
			["config"] = {
			},
			["inverse"] = false,
			["zoom"] = 0,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 3,
						["op"] = ">=",
						["value"] = "10",
						["variable"] = "power",
					},
					["changes"] = {
						{
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "buffed",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
						{
							["value"] = false,
							["property"] = "desaturate",
						}, -- [2]
					},
				}, -- [2]
			},
			["cooldown"] = true,
			["glowBorder"] = false,
		},
		["Rend"] = {
			["glow"] = false,
			["authorOptions"] = {
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["url"] = "https://wago.io/JLiVMG_1s/3",
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
					["glow_type"] = "ACShine",
					["glow_action"] = "show",
				},
				["finish"] = {
					["do_glow"] = false,
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["useName"] = true,
						["auranames"] = {
							"Rend", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["event"] = "Health",
						["unit"] = "target",
						["spellIds"] = {
						},
						["names"] = {
						},
						["type"] = "aura2",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HARMFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["auranames"] = {
							"Heroic Strike", -- [1]
						},
						["ownOnly"] = true,
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["matchesShowOn"] = "showAlways",
						["useName"] = true,
						["use_genericShowOn"] = true,
						["unevent"] = "auto",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["event"] = "Cooldown Progress (Spell)",
						["use_unit"] = true,
						["realSpellName"] = "Heroic Strike",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["names"] = {
						},
						["type"] = "status",
						["duration"] = "1",
						["use_track"] = true,
						["spellName"] = 284,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [2]
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Power",
						["use_unit"] = true,
						["powertype"] = 1,
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["use_powertype"] = true,
						["subeventSuffix"] = "_CAST_START",
					},
					["untrigger"] = {
					},
				}, -- [3]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 23,
			["glowXOffset"] = 0,
			["selfPoint"] = "CENTER",
			["parent"] = "Warrior",
			["zoom"] = 0,
			["desaturate"] = true,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["glowLines"] = 8,
			["version"] = 3,
			["subRegions"] = {
				{
					["text_shadowXOffset"] = 0,
					["type"] = "subtext",
					["text_text"] = "%s",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = 0,
					["text_selfPoint"] = "AUTO",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["anchorYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["rotateText"] = "NONE",
					["anchorXOffset"] = 0,
					["text_fontSize"] = 12,
				}, -- [1]
			},
			["height"] = 40,
			["keepAspectRatio"] = false,
			["load"] = {
				["use_class"] = true,
				["use_spellknown"] = false,
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["spellknown"] = 284,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["glowFrequency"] = 0.25,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["useglowColor"] = false,
			["glowType"] = "buttonOverlay",
			["glowThickness"] = 1,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 3,
						["op"] = ">=",
						["variable"] = "power",
					},
					["changes"] = {
						{
							["value"] = false,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "buffed",
						["value"] = 1,
						["checks"] = {
							{
								["trigger"] = 3,
								["op"] = ">=",
								["value"] = "60",
								["variable"] = "power",
							}, -- [1]
							{
								["trigger"] = 2,
								["variable"] = "spellUsable",
								["value"] = 1,
							}, -- [2]
						},
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
						{
							["value"] = false,
							["property"] = "desaturate",
						}, -- [2]
					},
				}, -- [2]
			},
			["icon"] = true,
			["xOffset"] = 100,
			["regionType"] = "icon",
			["uid"] = "A9eLMzO1a9J",
			["cooldownEdge"] = false,
			["width"] = 40,
			["frameStrata"] = 1,
			["tocversion"] = 11302,
			["auto"] = true,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.0.2",
			["glowScale"] = 1,
			["id"] = "Rend",
			["glowYOffset"] = 0,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["glowLength"] = 10,
			["config"] = {
			},
			["inverse"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayIcon"] = 132282,
			["cooldown"] = true,
			["glowBorder"] = false,
		},
		["RageBar - SwingTimer"] = {
			["controlledChildren"] = {
				"Swing Timer", -- [1]
				"Rage", -- [2]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["authorOptions"] = {
			},
			["groupIcon"] = 132277,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["url"] = "https://wago.io/JLiVMG_1s/3",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["debuffType"] = "HELPFUL",
						["type"] = "aura2",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["event"] = "Health",
						["unit"] = "player",
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["internalVersion"] = 23,
			["selfPoint"] = "BOTTOMLEFT",
			["version"] = 3,
			["subRegions"] = {
			},
			["load"] = {
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["scale"] = 0.95,
			["border"] = false,
			["borderEdge"] = "1 Pixel",
			["regionType"] = "group",
			["borderSize"] = 2,
			["borderOffset"] = 4,
			["semver"] = "1.0.2",
			["tocversion"] = 11302,
			["id"] = "RageBar - SwingTimer",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["yOffset"] = -35,
			["config"] = {
			},
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["borderInset"] = 1,
			["conditions"] = {
			},
			["uid"] = "eaW)InGEEKD",
			["xOffset"] = -20,
		},
		["Rage 2"] = {
			["sparkWidth"] = 10,
			["borderBackdrop"] = "Blizzard Tooltip",
			["authorOptions"] = {
			},
			["yOffset"] = -127.56465435028,
			["anchorPoint"] = "CENTER",
			["parent"] = "Arms",
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["url"] = "https://wago.io/Eh5J56-nY/1",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "status",
						["unit"] = "player",
						["unevent"] = "auto",
						["matchesShowOn"] = "showAlways",
						["duration"] = "1",
						["use_showCost"] = true,
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["powertype"] = 1,
						["spellIds"] = {
						},
						["use_unit"] = true,
						["event"] = "Power",
						["subeventPrefix"] = "SPELL",
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["internalVersion"] = 23,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["backdropInFront"] = false,
			["text"] = false,
			["barColor"] = {
				1, -- [1]
				0.066666666666667, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["frameStrata"] = 1,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "aurabar_bar",
				}, -- [1]
				{
					["text_shadowXOffset"] = 1,
					["type"] = "subtext",
					["text_text"] = "%p",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = -1,
					["text_selfPoint"] = "AUTO",
					["text_anchorXOffset"] = 1,
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_LEFT",
					["anchorYOffset"] = 0,
					["text_fontType"] = "None",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["rotateText"] = "NONE",
				}, -- [2]
				{
					["text_shadowXOffset"] = 1,
					["type"] = "subtext",
					["text_text"] = "%n",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = -1,
					["text_selfPoint"] = "AUTO",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_RIGHT",
					["anchorYOffset"] = 0,
					["text_fontType"] = "None",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["rotateText"] = "NONE",
				}, -- [3]
				{
					["type"] = "subborder",
					["border_anchor"] = "bar",
					["border_offset"] = 5,
					["border_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						0.5, -- [4]
					},
					["border_visible"] = false,
					["border_edge"] = "None",
					["border_size"] = 16,
				}, -- [4]
			},
			["height"] = 31.870697021484,
			["sparkOffsetX"] = 0,
			["load"] = {
				["use_class"] = true,
				["use_spellknown"] = false,
				["talent"] = {
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["spellknown"] = 7384,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["sparkBlendMode"] = "ADD",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["auto"] = true,
			["sparkOffsetY"] = 0,
			["uid"] = "u76oiTx4Bc0",
			["width"] = 231.49967956543,
			["sparkHidden"] = "NEVER",
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["borderInFront"] = true,
			["config"] = {
			},
			["icon_side"] = "RIGHT",
			["icon"] = false,
			["sparkHeight"] = 30,
			["texture"] = "Blizzard",
			["zoom"] = 0,
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["spark"] = false,
			["tocversion"] = 11302,
			["id"] = "Rage 2",
			["useAdjustededMax"] = false,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["inverse"] = false,
			["xOffset"] = 18.249946594238,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["selfPoint"] = "CENTER",
			["stickyDuration"] = false,
		},
		["Heroic Strike"] = {
			["glow"] = false,
			["glowLength"] = 10,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["url"] = "https://wago.io/JLiVMG_1s/3",
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
					["glow_type"] = "ACShine",
					["glow_action"] = "show",
				},
				["init"] = {
				},
				["finish"] = {
					["do_glow"] = false,
				},
			},
			["useglowColor"] = false,
			["internalVersion"] = 23,
			["glowXOffset"] = 0,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["parent"] = "Warrior",
			["desaturate"] = true,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["cooldownTextDisabled"] = false,
			["version"] = 3,
			["subRegions"] = {
				{
					["text_shadowXOffset"] = 0,
					["type"] = "subtext",
					["text_text"] = "%s",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = 0,
					["text_selfPoint"] = "AUTO",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["anchorYOffset"] = 0,
					["rotateText"] = "NONE",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_fontType"] = "OUTLINE",
				}, -- [1]
			},
			["height"] = 40,
			["anchorFrameType"] = "SCREEN",
			["load"] = {
				["use_class"] = true,
				["use_spellknown"] = false,
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["spellknown"] = 284,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["glowFrequency"] = 0.25,
			["selfPoint"] = "CENTER",
			["triggers"] = {
				{
					["trigger"] = {
						["useName"] = true,
						["auranames"] = {
							"Heroic Strike", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["event"] = "Health",
						["unit"] = "player",
						["spellIds"] = {
						},
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["type"] = "aura2",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["auranames"] = {
							"Heroic Strike", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["ownOnly"] = true,
						["type"] = "status",
						["spellName"] = 284,
						["unevent"] = "auto",
						["use_genericShowOn"] = true,
						["names"] = {
						},
						["event"] = "Cooldown Progress (Spell)",
						["useName"] = true,
						["realSpellName"] = "Heroic Strike",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["use_track"] = true,
						["matchesShowOn"] = "showAlways",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [2]
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Power",
						["use_unit"] = true,
						["powertype"] = 1,
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["use_powertype"] = true,
						["unit"] = "player",
					},
					["untrigger"] = {
					},
				}, -- [3]
				["disjunctive"] = "all",
				["activeTriggerMode"] = 1,
			},
			["glowType"] = "buttonOverlay",
			["glowThickness"] = 1,
			["displayIcon"] = 132282,
			["keepAspectRatio"] = false,
			["authorOptions"] = {
			},
			["regionType"] = "icon",
			["config"] = {
			},
			["xOffset"] = 0,
			["glowYOffset"] = 0,
			["alpha"] = 1,
			["glowScale"] = 1,
			["semver"] = "1.0.2",
			["zoom"] = 0,
			["auto"] = true,
			["tocversion"] = 11302,
			["id"] = "Heroic Strike",
			["glowLines"] = 8,
			["frameStrata"] = 1,
			["width"] = 40,
			["cooldownEdge"] = false,
			["uid"] = "k9oMvzIfep1",
			["inverse"] = false,
			["icon"] = true,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "buffed",
						["value"] = 0,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = -2,
						["variable"] = "OR",
						["checks"] = {
							{
								["trigger"] = 3,
								["op"] = ">=",
								["variable"] = "power",
								["value"] = "60",
							}, -- [1]
							{
								["trigger"] = 2,
								["variable"] = "spellUsable",
								["value"] = 1,
							}, -- [2]
						},
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
						{
							["value"] = false,
							["property"] = "desaturate",
						}, -- [2]
					},
				}, -- [2]
			},
			["cooldown"] = true,
			["glowBorder"] = false,
		},
		["Swing Timer 2"] = {
			["sparkWidth"] = 20,
			["sparkOffsetX"] = 0,
			["authorOptions"] = {
			},
			["yOffset"] = -156.12695744284,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["url"] = "https://wago.io/Eh5J56-nY/1",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["triggers"] = {
				{
					["trigger"] = {
						["use_castType"] = false,
						["type"] = "status",
						["event"] = "Swing Timer",
						["unevent"] = "auto",
						["matchesShowOn"] = "showAlways",
						["duration"] = "1",
						["use_spell"] = false,
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["spellIds"] = {
						},
						["use_hand"] = true,
						["names"] = {
						},
						["use_unit"] = true,
						["hand"] = "main",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["internalVersion"] = 23,
			["parent"] = "Arms",
			["selfPoint"] = "CENTER",
			["backdropInFront"] = false,
			["barColor"] = {
				0, -- [1]
				0.63529411764706, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["stickyDuration"] = false,
			["icon"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "aurabar_bar",
				}, -- [1]
				{
					["text_shadowXOffset"] = 1,
					["type"] = "subtext",
					["text_text"] = "%p",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = -1,
					["text_selfPoint"] = "AUTO",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_LEFT",
					["anchorYOffset"] = 0,
					["text_fontType"] = "None",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["rotateText"] = "NONE",
				}, -- [2]
				{
					["text_shadowXOffset"] = 1,
					["type"] = "subtext",
					["text_text"] = "%n",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = -1,
					["text_selfPoint"] = "AUTO",
					["text_visible"] = false,
					["text_anchorPoint"] = "INNER_RIGHT",
					["anchorYOffset"] = 0,
					["text_fontType"] = "None",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["rotateText"] = "NONE",
				}, -- [3]
				{
					["type"] = "subborder",
					["border_anchor"] = "bar",
					["border_offset"] = 5,
					["border_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						0.5, -- [4]
					},
					["border_visible"] = false,
					["border_edge"] = "None",
					["border_size"] = 16,
				}, -- [4]
			},
			["height"] = 7,
			["alpha"] = 1,
			["load"] = {
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["sparkBlendMode"] = "ADD",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["sparkHidden"] = "NEVER",
			["desaturate"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["config"] = {
			},
			["spark"] = true,
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["borderInFront"] = true,
			["width"] = 231.49963378906,
			["icon_side"] = "RIGHT",
			["uid"] = "OTMA9LXkPr9",
			["sparkHeight"] = 20,
			["texture"] = "Blizzard",
			["borderBackdrop"] = "Blizzard Tooltip",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["auto"] = true,
			["tocversion"] = 11302,
			["id"] = "Swing Timer 2",
			["zoom"] = 0,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["useAdjustededMax"] = false,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["inverse"] = true,
			["xOffset"] = 18.249756377361,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "interruptible",
						["value"] = 0,
					},
					["changes"] = {
						{
							["value"] = {
								0.8, -- [1]
								0.1, -- [2]
								0.1, -- [3]
								1, -- [4]
							},
							["property"] = "barColor",
						}, -- [1]
					},
				}, -- [1]
			},
			["sparkOffsetY"] = 0,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
		},
		["Hamstring 2"] = {
			["glow"] = false,
			["glowLength"] = 10,
			["yOffset"] = -55,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/Eh5J56-nY/1",
			["actions"] = {
				["start"] = {
					["do_glow"] = true,
					["glow_type"] = "Pixel",
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura2",
						["auranames"] = {
							"Hamstring", -- [1]
						},
						["ownOnly"] = true,
						["event"] = "Health",
						["unit"] = "target",
						["matchesShowOn"] = "showAlways",
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["useName"] = true,
						["names"] = {
						},
						["debuffType"] = "HARMFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "status",
						["unevent"] = "auto",
						["names"] = {
						},
						["event"] = "Cooldown Progress (Spell)",
						["subeventPrefix"] = "SPELL",
						["realSpellName"] = "Hamstring",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["use_genericShowOn"] = true,
						["use_unit"] = true,
						["use_track"] = true,
						["spellName"] = 1715,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [2]
				{
					["trigger"] = {
						["use_requirePowerType"] = false,
						["type"] = "status",
						["subeventPrefix"] = "SPELL",
						["unevent"] = "auto",
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["use_showCost"] = false,
						["unit"] = "player",
						["names"] = {
						},
						["powertype"] = 1,
						["spellIds"] = {
						},
						["event"] = "Power",
						["use_power"] = false,
						["use_unit"] = true,
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [3]
				{
					["trigger"] = {
						["use_form"] = true,
						["unevent"] = "auto",
						["form"] = {
							["single"] = 1,
						},
						["event"] = "Stance/Form/Aura",
						["unit"] = "player",
						["duration"] = "1",
						["names"] = {
						},
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["type"] = "status",
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [4]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 23,
			["glowXOffset"] = 0,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["desaturate"] = true,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["version"] = 1,
			["subRegions"] = {
				{
					["text_shadowXOffset"] = 0,
					["type"] = "subtext",
					["text_text"] = "%s",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = 0,
					["text_selfPoint"] = "AUTO",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["anchorYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["rotateText"] = "NONE",
				}, -- [1]
			},
			["height"] = 25,
			["parent"] = "Arms",
			["glowLines"] = 8,
			["frameStrata"] = 1,
			["glowFrequency"] = 0.25,
			["icon"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["glowType"] = "Pixel",
			["glowThickness"] = 1,
			["zoom"] = 0,
			["useglowColor"] = false,
			["xOffset"] = -29,
			["regionType"] = "icon",
			["load"] = {
				["use_class"] = true,
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["cooldownEdge"] = false,
			["selfPoint"] = "CENTER",
			["authorOptions"] = {
			},
			["tocversion"] = 11302,
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["glowScale"] = 1,
			["id"] = "Hamstring 2",
			["width"] = 25,
			["alpha"] = 1,
			["glowYOffset"] = 0,
			["uid"] = "ZYKJHSpb5aF",
			["config"] = {
			},
			["inverse"] = false,
			["keepAspectRatio"] = false,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = -2,
						["variable"] = "AND",
						["checks"] = {
							{
								["trigger"] = 4,
								["op"] = "==",
								["value"] = 1,
								["variable"] = "form",
							}, -- [1]
							{
								["trigger"] = 1,
								["variable"] = "buffed",
								["value"] = 1,
							}, -- [2]
						},
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
						{
							["property"] = "desaturate",
						}, -- [2]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 3,
						["op"] = ">=",
						["value"] = "10",
						["variable"] = "power",
					},
					["changes"] = {
						{
							["value"] = false,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [2]
			},
			["cooldown"] = true,
			["glowBorder"] = false,
		},
		["Shield Slam"] = {
			["glow"] = false,
			["authorOptions"] = {
			},
			["yOffset"] = -89.000061035156,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/Eh5J56-nY/1",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["useglowColor"] = false,
			["internalVersion"] = 23,
			["glowXOffset"] = 0,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["desaturate"] = true,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["parent"] = "Arms",
			["version"] = 1,
			["subRegions"] = {
				{
					["text_shadowXOffset"] = 0,
					["type"] = "subtext",
					["text_text"] = "%s",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = 0,
					["text_selfPoint"] = "AUTO",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["anchorYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["rotateText"] = "NONE",
				}, -- [1]
			},
			["height"] = 40,
			["icon"] = true,
			["glowLines"] = 8,
			["frameStrata"] = 1,
			["glowFrequency"] = 0.25,
			["selfPoint"] = "CENTER",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["glowType"] = "buttonOverlay",
			["glowThickness"] = 1,
			["glowLength"] = 10,
			["triggers"] = {
				{
					["trigger"] = {
						["use_form"] = true,
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "status",
						["names"] = {
						},
						["unevent"] = "auto",
						["spellName"] = 0,
						["form"] = {
							["single"] = 1,
						},
						["event"] = "Cooldown Progress (Spell)",
						["subeventSuffix"] = "_CAST_START",
						["realSpellName"] = 0,
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["use_genericShowOn"] = true,
						["use_track"] = true,
						["duration"] = "1",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["useName"] = true,
						["auranames"] = {
							"Shield Slam", -- [1]
						},
						["ownOnly"] = true,
						["event"] = "Health",
						["unit"] = "player",
						["type"] = "aura2",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["matchesShowOn"] = "showAlways",
						["names"] = {
						},
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				{
					["trigger"] = {
						["use_form"] = true,
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["event"] = "Stance/Form/Aura",
						["subeventPrefix"] = "SPELL",
						["realSpellName"] = 0,
						["use_spellName"] = true,
						["unevent"] = "auto",
						["unit"] = "player",
						["use_unit"] = true,
						["form"] = {
							["single"] = 2,
							["multi"] = {
								true, -- [1]
							},
						},
						["type"] = "status",
						["spellName"] = 0,
					},
					["untrigger"] = {
					},
				}, -- [3]
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Power",
						["use_unit"] = true,
						["powertype"] = 1,
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["use_powertype"] = true,
						["subeventSuffix"] = "_CAST_START",
					},
					["untrigger"] = {
					},
				}, -- [4]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["load"] = {
				["use_class"] = true,
				["use_spellknown"] = false,
				["talent"] = {
					["multi"] = {
						[21] = true,
						[19] = true,
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["spellknown"] = 5283,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["regionType"] = "icon",
			["uid"] = "MKclO6OxqhA",
			["width"] = 40,
			["zoom"] = 0,
			["useGlowColor"] = false,
			["anchorFrameType"] = "SCREEN",
			["tocversion"] = 11302,
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["glowScale"] = 1,
			["id"] = "Shield Slam",
			["xOffset"] = 46,
			["alpha"] = 1,
			["glowYOffset"] = 0,
			["keepAspectRatio"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["cooldownEdge"] = false,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 2,
						["op"] = "==",
						["value"] = 0,
						["variable"] = "buffed",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = -2,
						["variable"] = "AND",
						["checks"] = {
							{
								["trigger"] = 4,
								["op"] = ">=",
								["value"] = "1",
								["variable"] = "power",
							}, -- [1]
							{
								["trigger"] = 1,
								["variable"] = "spellUsable",
								["value"] = 1,
							}, -- [2]
						},
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
						{
							["value"] = false,
							["property"] = "desaturate",
						}, -- [2]
					},
				}, -- [2]
			},
			["cooldown"] = true,
			["glowBorder"] = false,
		},
		["Blood Rage"] = {
			["glow"] = false,
			["authorOptions"] = {
			},
			["yOffset"] = -119.50000259706,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/Eh5J56-nY/1",
			["icon"] = true,
			["useglowColor"] = false,
			["internalVersion"] = 23,
			["glowXOffset"] = 0,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["desaturate"] = true,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["version"] = 1,
			["subRegions"] = {
				{
					["text_shadowXOffset"] = 0,
					["type"] = "subtext",
					["text_text"] = "%s",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = 0,
					["text_selfPoint"] = "AUTO",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["anchorYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["rotateText"] = "NONE",
				}, -- [1]
			},
			["height"] = 48,
			["parent"] = "Arms",
			["glowLines"] = 8,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["glowFrequency"] = 0.25,
			["tocversion"] = 11302,
			["keepAspectRatio"] = false,
			["glowType"] = "Pixel",
			["glowThickness"] = 1,
			["glowLength"] = 10,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0,
			["regionType"] = "icon",
			["triggers"] = {
				{
					["trigger"] = {
						["use_form"] = true,
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["powertype"] = 1,
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
						["duration"] = "1",
						["use_remaining"] = false,
						["unit"] = "player",
						["unevent"] = "auto",
						["subeventSuffix"] = "_CAST_START",
						["type"] = "status",
						["event"] = "Cooldown Progress (Spell)",
						["use_unit"] = true,
						["realSpellName"] = "Bloodrage",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_inverse"] = true,
						["use_genericShowOn"] = true,
						["names"] = {
						},
						["use_track"] = true,
						["spellName"] = 2687,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["useName"] = true,
						["unevent"] = "timed",
						["names"] = {
						},
						["duration"] = "1",
						["event"] = "Chat Message",
						["unit"] = "player",
						["type"] = "aura2",
						["subeventSuffix"] = "_CAST_START",
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["auranames"] = {
							"Bloodrage", -- [1]
						},
						["ownOnly"] = true,
						["matchesShowOn"] = "showAlways",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["uid"] = ")KEBzbJXtqP",
			["load"] = {
				["use_class"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["width"] = 48,
			["selfPoint"] = "CENTER",
			["frameStrata"] = 1,
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["glowScale"] = 1,
			["id"] = "Blood Rage",
			["xOffset"] = -125.5,
			["alpha"] = 1,
			["glowYOffset"] = 0,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["config"] = {
			},
			["inverse"] = false,
			["cooldownEdge"] = false,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 2,
						["variable"] = "buffed",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
						{
							["value"] = false,
							["property"] = "desaturate",
						}, -- [2]
					},
				}, -- [1]
			},
			["cooldown"] = true,
			["glowBorder"] = false,
		},
		["Hamstring"] = {
			["glow"] = false,
			["authorOptions"] = {
			},
			["yOffset"] = -55,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["cooldownEdge"] = false,
			["actions"] = {
				["start"] = {
					["do_glow"] = true,
					["glow_type"] = "Pixel",
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["useglowColor"] = false,
			["internalVersion"] = 23,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = true,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["version"] = 1,
			["subRegions"] = {
				{
					["text_shadowXOffset"] = 0,
					["type"] = "subtext",
					["text_text"] = "%s",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = 0,
					["text_selfPoint"] = "AUTO",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["anchorYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["rotateText"] = "NONE",
				}, -- [1]
			},
			["height"] = 25,
			["parent"] = "Arms",
			["glowLines"] = 8,
			["width"] = 25,
			["glowFrequency"] = 0.25,
			["zoom"] = 0,
			["glowXOffset"] = 0,
			["glowType"] = "Pixel",
			["glowThickness"] = 1,
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Hamstring", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["unit"] = "target",
						["debuffType"] = "HARMFUL",
						["useName"] = true,
						["duration"] = "1",
						["unevent"] = "auto",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["event"] = "Cooldown Progress (Spell)",
						["type"] = "status",
						["realSpellName"] = "Hamstring",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_unit"] = true,
						["use_genericShowOn"] = true,
						["names"] = {
						},
						["use_track"] = true,
						["spellName"] = 1715,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["duration"] = "1",
						["use_showCost"] = false,
						["unit"] = "player",
						["powertype"] = 1,
						["use_requirePowerType"] = false,
						["event"] = "Power",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["use_powertype"] = true,
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["form"] = {
							["single"] = 1,
						},
						["event"] = "Stance/Form/Aura",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["duration"] = "1",
						["subeventSuffix"] = "_CAST_START",
						["use_form"] = true,
						["use_unit"] = true,
					},
					["untrigger"] = {
					},
				}, -- [3]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["uid"] = "V)TOMWMcl8Z",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["alpha"] = 1,
			["load"] = {
				["use_class"] = true,
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["glowLength"] = 10,
			["tocversion"] = 11302,
			["icon"] = true,
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["glowScale"] = 1,
			["id"] = "Hamstring",
			["xOffset"] = -29,
			["frameStrata"] = 1,
			["glowYOffset"] = 0,
			["url"] = "https://wago.io/Eh5J56-nY/1",
			["config"] = {
			},
			["inverse"] = false,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = -1,
						["variable"] = "incombat",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = 1,
							["property"] = "alpha",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 3,
						["op"] = "==",
						["value"] = 2,
						["variable"] = "form",
					},
					["changes"] = {
						{
							["value"] = 1,
							["property"] = "alpha",
						}, -- [1]
					},
				}, -- [2]
			},
			["cooldown"] = true,
			["glowBorder"] = false,
		},
		["Revenge"] = {
			["glow"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/Eh5J56-nY/1",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["useglowColor"] = false,
			["internalVersion"] = 23,
			["glowXOffset"] = 0,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["parent"] = "Warrior",
			["desaturate"] = true,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["version"] = 1,
			["subRegions"] = {
				{
					["text_shadowXOffset"] = 0,
					["type"] = "subtext",
					["text_text"] = "%s",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = 0,
					["text_selfPoint"] = "AUTO",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["anchorYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["rotateText"] = "NONE",
				}, -- [1]
			},
			["height"] = 40,
			["useGlowColor"] = false,
			["glowLines"] = 8,
			["width"] = 40,
			["glowFrequency"] = 0.25,
			["selfPoint"] = "CENTER",
			["keepAspectRatio"] = false,
			["glowType"] = "buttonOverlay",
			["glowThickness"] = 1,
			["authorOptions"] = {
			},
			["glowYOffset"] = 0,
			["triggers"] = {
				{
					["trigger"] = {
						["use_form"] = true,
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "status",
						["use_unit"] = true,
						["subeventSuffix"] = "_CAST_START",
						["unevent"] = "auto",
						["form"] = {
							["single"] = 1,
						},
						["event"] = "Cooldown Progress (Spell)",
						["duration"] = "1",
						["realSpellName"] = "Revenge",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["spellName"] = 6572,
						["use_genericShowOn"] = true,
						["names"] = {
						},
						["use_track"] = true,
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["useName"] = true,
						["auranames"] = {
							"Revenge", -- [1]
						},
						["ownOnly"] = true,
						["event"] = "Health",
						["unit"] = "player",
						["type"] = "aura2",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["names"] = {
						},
						["matchesShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				{
					["trigger"] = {
						["use_form"] = true,
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["event"] = "Stance/Form/Aura",
						["unit"] = "player",
						["realSpellName"] = 0,
						["use_spellName"] = true,
						["unevent"] = "auto",
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["type"] = "status",
						["form"] = {
							["single"] = 2,
						},
						["spellName"] = 0,
					},
					["untrigger"] = {
					},
				}, -- [3]
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Power",
						["use_unit"] = true,
						["powertype"] = 1,
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["use_powertype"] = true,
						["subeventSuffix"] = "_CAST_START",
					},
					["untrigger"] = {
					},
				}, -- [4]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["regionType"] = "icon",
			["icon"] = true,
			["load"] = {
				["use_class"] = true,
				["use_spellknown"] = true,
				["talent"] = {
					["multi"] = {
						[21] = true,
						[19] = true,
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "dte(INTr8ED",
			["glowLength"] = 10,
			["frameStrata"] = 1,
			["tocversion"] = 11302,
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["glowScale"] = 1,
			["id"] = "Revenge",
			["xOffset"] = 100,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0,
			["config"] = {
			},
			["inverse"] = false,
			["cooldownEdge"] = false,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 2,
						["op"] = "==",
						["value"] = 0,
						["variable"] = "buffed",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = -2,
						["variable"] = "AND",
						["checks"] = {
							{
								["trigger"] = 4,
								["op"] = ">=",
								["value"] = "5",
								["variable"] = "power",
							}, -- [1]
							{
								["trigger"] = 1,
								["variable"] = "spellUsable",
								["value"] = 1,
							}, -- [2]
						},
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
						{
							["value"] = false,
							["property"] = "desaturate",
						}, -- [2]
					},
				}, -- [2]
			},
			["cooldown"] = true,
			["glowBorder"] = false,
		},
		["Heroic Strike 2"] = {
			["glow"] = false,
			["glowLength"] = 10,
			["yOffset"] = -89,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["url"] = "https://wago.io/Eh5J56-nY/1",
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
					["glow_type"] = "ACShine",
					["glow_action"] = "show",
				},
				["finish"] = {
					["do_glow"] = false,
				},
				["init"] = {
				},
			},
			["useglowColor"] = false,
			["internalVersion"] = 23,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["desaturate"] = true,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["parent"] = "Arms",
			["version"] = 1,
			["subRegions"] = {
				{
					["text_shadowXOffset"] = 0,
					["type"] = "subtext",
					["text_text"] = "%s",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = 0,
					["text_selfPoint"] = "AUTO",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["anchorYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["rotateText"] = "NONE",
				}, -- [1]
			},
			["height"] = 39.99995803833,
			["frameStrata"] = 1,
			["glowLines"] = 8,
			["width"] = 40,
			["glowFrequency"] = 0.25,
			["glowXOffset"] = 0,
			["uid"] = "dTFfZ8bZ9dX",
			["glowType"] = "buttonOverlay",
			["glowThickness"] = 1,
			["triggers"] = {
				{
					["trigger"] = {
						["useName"] = true,
						["auranames"] = {
							"Heroic Strike", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["event"] = "Health",
						["unit"] = "player",
						["spellIds"] = {
						},
						["names"] = {
						},
						["type"] = "aura2",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["auranames"] = {
							"Heroic Strike", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["matchesShowOn"] = "showAlways",
						["type"] = "status",
						["spellName"] = 284,
						["unevent"] = "auto",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["event"] = "Cooldown Progress (Spell)",
						["use_unit"] = true,
						["realSpellName"] = "Heroic Strike",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["useName"] = true,
						["names"] = {
						},
						["use_genericShowOn"] = true,
						["use_track"] = true,
						["ownOnly"] = true,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [2]
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Power",
						["use_unit"] = true,
						["powertype"] = 1,
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["use_powertype"] = true,
						["subeventSuffix"] = "_CAST_START",
					},
					["untrigger"] = {
					},
				}, -- [3]
				["disjunctive"] = "all",
				["activeTriggerMode"] = 1,
			},
			["icon"] = true,
			["load"] = {
				["use_class"] = true,
				["use_spellknown"] = false,
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["spellknown"] = 284,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["regionType"] = "icon",
			["selfPoint"] = "CENTER",
			["anchorFrameType"] = "SCREEN",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = 0,
						["variable"] = "buffed",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = -2,
						["variable"] = "OR",
						["checks"] = {
							{
								["trigger"] = 3,
								["op"] = ">=",
								["value"] = "15",
								["variable"] = "power",
							}, -- [1]
							{
								["trigger"] = 2,
								["variable"] = "spellUsable",
								["value"] = 1,
							}, -- [2]
						},
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "glow",
						}, -- [1]
						{
							["value"] = false,
							["property"] = "desaturate",
						}, -- [2]
					},
				}, -- [2]
			},
			["zoom"] = 0,
			["authorOptions"] = {
			},
			["cooldownTextDisabled"] = false,
			["auto"] = false,
			["tocversion"] = 11302,
			["id"] = "Heroic Strike 2",
			["xOffset"] = -38,
			["alpha"] = 1,
			["glowYOffset"] = 0,
			["glowScale"] = 1,
			["config"] = {
			},
			["inverse"] = false,
			["cooldownEdge"] = false,
			["displayIcon"] = 132282,
			["cooldown"] = true,
			["glowBorder"] = false,
		},
	},
	["minimap"] = {
		["minimapPos"] = 40.9233740823175,
		["hide"] = false,
	},
	["history"] = {
		["9sOwYXSR4N("] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201870,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["glowLength"] = 10,
				["yOffset"] = -204.99981689453,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["cooldownEdge"] = false,
				["icon"] = true,
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["selfPoint"] = "CENTER",
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 3,
				["subRegions"] = {
				},
				["height"] = 35,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["url"] = "https://wago.io/9EBTx7-J0/3",
				["triggers"] = {
					{
						["trigger"] = {
							["use_genericShowOn"] = true,
							["genericShowOn"] = "showAlways",
							["names"] = {
							},
							["debuffType"] = "HELPFUL",
							["type"] = "status",
							["subeventPrefix"] = "SPELL",
							["subeventSuffix"] = "_CAST_START",
							["use_showOn"] = true,
							["unit"] = "player",
							["event"] = "Cooldown Progress (Spell)",
							["unevent"] = "auto",
							["realSpellName"] = "Bloodrage",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["spellName"] = 2687,
							["use_absorbMode"] = true,
							["use_unit"] = true,
							["use_track"] = true,
							["duration"] = "1",
						},
						["untrigger"] = {
							["showOn"] = "showAlways",
							["spellName"] = 18499,
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["load"] = {
					["ingroup"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["talent2"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["use_spec"] = true,
					["spec"] = {
						["single"] = 2,
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["regionType"] = "icon",
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["config"] = {
				},
				["glowYOffset"] = 0,
				["anchorFrameType"] = "SCREEN",
				["frameStrata"] = 1,
				["keepAspectRatio"] = false,
				["auto"] = true,
				["tocversion"] = 11302,
				["cooldownTextDisabled"] = false,
				["semver"] = "1.0.2",
				["glowScale"] = 1,
				["id"] = "Bloodrage",
				["zoom"] = 0,
				["alpha"] = 1,
				["width"] = 35,
				["xOffset"] = 95,
				["uid"] = "9sOwYXSR4N(",
				["inverse"] = true,
				["parent"] = "Warrior",
				["authorOptions"] = {
				},
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "onCooldown",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = {
									0.43921568627451, -- [1]
									0.43921568627451, -- [2]
									0.43921568627451, -- [3]
									1, -- [4]
								},
								["property"] = "color",
							}, -- [1]
						},
					}, -- [1]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["u76oiTx4Bc0"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567277425,
			["allowUpdates"] = true,
			["data"] = {
				["sparkWidth"] = 10,
				["sparkOffsetX"] = 0,
				["parent"] = "Arms",
				["yOffset"] = -127.56465435028,
				["anchorPoint"] = "CENTER",
				["sparkRotation"] = 0,
				["sparkRotationMode"] = "AUTO",
				["url"] = "https://wago.io/Eh5J56-nY/1",
				["actions"] = {
					["start"] = {
					},
					["init"] = {
					},
					["finish"] = {
					},
				},
				["triggers"] = {
					{
						["trigger"] = {
							["type"] = "status",
							["duration"] = "1",
							["unevent"] = "auto",
							["names"] = {
							},
							["matchesShowOn"] = "showAlways",
							["use_showCost"] = true,
							["unit"] = "player",
							["subeventPrefix"] = "SPELL",
							["powertype"] = 1,
							["spellIds"] = {
							},
							["event"] = "Power",
							["use_unit"] = true,
							["subeventSuffix"] = "_CAST_START",
							["use_powertype"] = true,
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [1]
					["activeTriggerMode"] = -10,
				},
				["icon_color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["internalVersion"] = 23,
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["backdropInFront"] = false,
				["text"] = false,
				["barColor"] = {
					1, -- [1]
					0.066666666666667, -- [2]
					0, -- [3]
					1, -- [4]
				},
				["desaturate"] = false,
				["stickyDuration"] = false,
				["version"] = 1,
				["subRegions"] = {
					{
						["type"] = "aurabar_bar",
					}, -- [1]
					{
						["text_shadowXOffset"] = 1,
						["type"] = "subtext",
						["text_text"] = "%p",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = -1,
						["text_selfPoint"] = "AUTO",
						["rotateText"] = "NONE",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_LEFT",
						["anchorYOffset"] = 0,
						["text_fontType"] = "None",
						["text_fontSize"] = 12,
						["anchorXOffset"] = 0,
						["text_anchorXOffset"] = 1,
					}, -- [2]
					{
						["text_shadowXOffset"] = 1,
						["type"] = "subtext",
						["text_text"] = "%n",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = -1,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_RIGHT",
						["anchorYOffset"] = 0,
						["rotateText"] = "NONE",
						["text_fontSize"] = 12,
						["anchorXOffset"] = 0,
						["text_fontType"] = "None",
					}, -- [3]
					{
						["border_offset"] = 5,
						["border_anchor"] = "bar",
						["border_size"] = 16,
						["border_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							0.5, -- [4]
						},
						["border_visible"] = false,
						["border_edge"] = "None",
						["type"] = "subborder",
					}, -- [4]
				},
				["height"] = 31.870697021484,
				["selfPoint"] = "CENTER",
				["load"] = {
					["use_class"] = true,
					["use_spellknown"] = false,
					["talent"] = {
					},
					["spec"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["spellknown"] = 7384,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["sparkBlendMode"] = "ADD",
				["backdropColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					0.5, -- [4]
				},
				["borderBackdrop"] = "Blizzard Tooltip",
				["config"] = {
				},
				["xOffset"] = 18.249946594238,
				["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
				["sparkColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["smoothProgress"] = true,
				["useAdjustededMin"] = false,
				["regionType"] = "aurabar",
				["borderInFront"] = true,
				["backgroundColor"] = {
					0, -- [1]
					0, -- [2]
					0, -- [3]
					0.5, -- [4]
				},
				["icon_side"] = "RIGHT",
				["anchorFrameType"] = "SCREEN",
				["alpha"] = 1,
				["sparkHeight"] = 30,
				["texture"] = "Blizzard",
				["useAdjustededMax"] = false,
				["zoom"] = 0,
				["auto"] = true,
				["tocversion"] = 11302,
				["sparkHidden"] = "NEVER",
				["id"] = "Rage",
				["frameStrata"] = 1,
				["width"] = 231.49967956543,
				["spark"] = false,
				["uid"] = "u76oiTx4Bc0",
				["inverse"] = false,
				["icon"] = false,
				["orientation"] = "HORIZONTAL",
				["conditions"] = {
				},
				["authorOptions"] = {
				},
				["sparkOffsetY"] = 0,
			},
		},
		["05Et2oL4yqS"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201870,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["authorOptions"] = {
				},
				["yOffset"] = -73,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["url"] = "https://wago.io/9EBTx7-J0/3",
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
						["custom"] = "",
						["do_custom"] = false,
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 3,
				["subRegions"] = {
				},
				["height"] = 45,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["glowLength"] = 10,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["triggers"] = {
					{
						["trigger"] = {
							["track"] = "auto",
							["auranames"] = {
								"215572", -- [1]
							},
							["duration"] = "1",
							["genericShowOn"] = "showAlways",
							["subeventPrefix"] = "SPELL",
							["use_tooltip"] = false,
							["use_unit"] = true,
							["use_genericShowOn"] = true,
							["matchesShowOn"] = "showOnActive",
							["type"] = "status",
							["unevent"] = "auto",
							["debuffType"] = "HELPFUL",
							["name"] = "Spell Reflection",
							["useName"] = true,
							["use_debuffClass"] = false,
							["subeventSuffix"] = "_CAST_START",
							["spellName"] = 7379,
							["useGroup_count"] = false,
							["event"] = "Cooldown Progress (Spell)",
							["ownOnly"] = true,
							["realSpellName"] = "Revenge",
							["use_spellName"] = true,
							["spellIds"] = {
								215572, -- [1]
							},
							["buffShowOn"] = "showOnActive",
							["unit"] = "player",
							["combineMatches"] = "showLowest",
							["use_track"] = true,
							["names"] = {
								"Frothing Berserker", -- [1]
							},
						},
						["untrigger"] = {
							["genericShowOn"] = "showAlways",
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["load"] = {
					["talent2"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 15,
						["multi"] = {
							[15] = true,
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["ingroup"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["use_spec"] = true,
					["spec"] = {
						["single"] = 2,
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["xOffset"] = -100,
				["regionType"] = "icon",
				["selfPoint"] = "CENTER",
				["uid"] = "05Et2oL4yqS",
				["width"] = 45,
				["anchorFrameType"] = "SCREEN",
				["alpha"] = 1,
				["keepAspectRatio"] = false,
				["auto"] = true,
				["tocversion"] = 11302,
				["cooldownTextDisabled"] = false,
				["semver"] = "1.0.2",
				["glowScale"] = 1,
				["id"] = "Revenge - Usable",
				["zoom"] = 0,
				["frameStrata"] = 1,
				["glowYOffset"] = 0,
				["icon"] = true,
				["config"] = {
				},
				["inverse"] = false,
				["parent"] = "Warrior",
				["cooldownEdge"] = false,
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "spellUsable",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
							{
							}, -- [2]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "spellUsable",
							["value"] = 0,
						},
						["changes"] = {
							{
								["property"] = "alpha",
							}, -- [1]
						},
					}, -- [2]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["M6mSWwyS7S("] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201870,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["yOffset"] = -162,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["cooldownEdge"] = false,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["keepAspectRatio"] = false,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 3,
				["subRegions"] = {
				},
				["height"] = 45,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["xOffset"] = -100,
				["glowXOffset"] = 0,
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["glowLength"] = 10,
				["triggers"] = {
					{
						["trigger"] = {
							["use_genericShowOn"] = true,
							["genericShowOn"] = "showAlways",
							["subeventPrefix"] = "SPELL",
							["spellName"] = 12294,
							["type"] = "status",
							["debuffType"] = "HELPFUL",
							["subeventSuffix"] = "_CAST_START",
							["use_showOn"] = true,
							["unit"] = "player",
							["event"] = "Cooldown Progress (Spell)",
							["unevent"] = "auto",
							["realSpellName"] = "Mortal Strike",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["names"] = {
							},
							["use_absorbMode"] = true,
							["use_unit"] = true,
							["use_track"] = true,
							["duration"] = "1",
						},
						["untrigger"] = {
							["showOn"] = "showAlways",
							["spellName"] = 12294,
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["authorOptions"] = {
				},
				["regionType"] = "icon",
				["parent"] = "Warrior",
				["uid"] = "M6mSWwyS7S(",
				["anchorFrameType"] = "SCREEN",
				["width"] = 45,
				["frameStrata"] = 1,
				["icon"] = true,
				["auto"] = true,
				["tocversion"] = 11302,
				["zoom"] = 0,
				["semver"] = "1.0.2",
				["glowScale"] = 1,
				["id"] = "Mortal Strike",
				["cooldownTextDisabled"] = false,
				["alpha"] = 1,
				["glowYOffset"] = 0,
				["url"] = "https://wago.io/9EBTx7-J0/3",
				["config"] = {
				},
				["inverse"] = true,
				["load"] = {
					["ingroup"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 18,
						["multi"] = {
						},
					},
					["talent2"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_talent"] = true,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["use_spec"] = true,
					["spec"] = {
						["single"] = 1,
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["selfPoint"] = "CENTER",
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "onCooldown",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = {
									0.43921568627451, -- [1]
									0.43921568627451, -- [2]
									0.43921568627451, -- [3]
									1, -- [4]
								},
								["property"] = "color",
							}, -- [1]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "spellUsable",
							["value"] = 0,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [1]
							{
								["value"] = true,
								["property"] = "inverse",
							}, -- [2]
						},
					}, -- [2]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		[")KEBzbJXtqP"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567277425,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["parent"] = "Arms",
				["yOffset"] = -119.50000259706,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = false,
				["url"] = "https://wago.io/Eh5J56-nY/1",
				["actions"] = {
					["start"] = {
					},
					["init"] = {
					},
					["finish"] = {
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["keepAspectRatio"] = false,
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["desaturate"] = true,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 1,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["rotateText"] = "NONE",
						["text_fontSize"] = 12,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 48,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["glowLength"] = 10,
				["glowType"] = "Pixel",
				["glowThickness"] = 1,
				["glowXOffset"] = 0,
				["icon"] = true,
				["cooldownEdge"] = false,
				["regionType"] = "icon",
				["authorOptions"] = {
				},
				["config"] = {
				},
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["glowYOffset"] = 0,
				["alpha"] = 1,
				["xOffset"] = -125.5,
				["cooldownTextDisabled"] = false,
				["glowScale"] = 1,
				["zoom"] = 0,
				["auto"] = true,
				["tocversion"] = 11302,
				["id"] = "Blood Rage",
				["selfPoint"] = "CENTER",
				["frameStrata"] = 1,
				["anchorFrameType"] = "SCREEN",
				["width"] = 48,
				["uid"] = ")KEBzbJXtqP",
				["inverse"] = false,
				["load"] = {
					["use_class"] = true,
					["talent"] = {
						["multi"] = {
						},
					},
					["spec"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["triggers"] = {
					{
						["trigger"] = {
							["use_form"] = true,
							["duration"] = "1",
							["genericShowOn"] = "showAlways",
							["unit"] = "player",
							["powertype"] = 1,
							["use_powertype"] = true,
							["debuffType"] = "HELPFUL",
							["spellName"] = 2687,
							["use_remaining"] = false,
							["matchesShowOn"] = "showAlways",
							["subeventSuffix"] = "_CAST_START",
							["names"] = {
							},
							["use_genericShowOn"] = true,
							["event"] = "Cooldown Progress (Spell)",
							["use_inverse"] = true,
							["realSpellName"] = "Bloodrage",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["type"] = "status",
							["use_unit"] = true,
							["unevent"] = "auto",
							["use_track"] = true,
							["subeventPrefix"] = "SPELL",
						},
						["untrigger"] = {
							["genericShowOn"] = "showAlways",
						},
					}, -- [1]
					{
						["trigger"] = {
							["type"] = "aura2",
							["unevent"] = "timed",
							["unit"] = "player",
							["duration"] = "1",
							["event"] = "Chat Message",
							["names"] = {
							},
							["matchesShowOn"] = "showAlways",
							["ownOnly"] = true,
							["spellIds"] = {
							},
							["auranames"] = {
								"Bloodrage", -- [1]
							},
							["subeventPrefix"] = "SPELL",
							["subeventSuffix"] = "_CAST_START",
							["useName"] = true,
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [2]
					["disjunctive"] = "any",
					["activeTriggerMode"] = -10,
				},
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 2,
							["variable"] = "buffed",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
							{
								["value"] = false,
								["property"] = "desaturate",
							}, -- [2]
						},
					}, -- [1]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["2siOcknoDcX"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201870,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["yOffset"] = -162,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["cooldownEdge"] = false,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["keepAspectRatio"] = false,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 3,
				["subRegions"] = {
				},
				["height"] = 45,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["xOffset"] = 100,
				["glowXOffset"] = 0,
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["glowLength"] = 10,
				["triggers"] = {
					{
						["trigger"] = {
							["duration"] = "1",
							["genericShowOn"] = "showAlways",
							["subeventPrefix"] = "SPELL",
							["debuffType"] = "HELPFUL",
							["use_unit"] = true,
							["type"] = "status",
							["use_genericShowOn"] = true,
							["unevent"] = "auto",
							["use_showOn"] = true,
							["subeventSuffix"] = "_CAST_START",
							["event"] = "Cooldown Progress (Spell)",
							["unit"] = "player",
							["realSpellName"] = "Sweeping Strikes",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["spellName"] = 12292,
							["use_absorbMode"] = true,
							["names"] = {
							},
							["use_track"] = true,
							["use_charges"] = false,
						},
						["untrigger"] = {
							["showOn"] = "showAlways",
							["spellName"] = 260708,
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["authorOptions"] = {
				},
				["regionType"] = "icon",
				["parent"] = "Warrior",
				["uid"] = "2siOcknoDcX",
				["anchorFrameType"] = "SCREEN",
				["width"] = 45,
				["frameStrata"] = 1,
				["icon"] = true,
				["auto"] = true,
				["tocversion"] = 11302,
				["zoom"] = 0,
				["semver"] = "1.0.2",
				["glowScale"] = 1,
				["id"] = "Sweeping Strikes",
				["cooldownTextDisabled"] = false,
				["alpha"] = 1,
				["glowYOffset"] = 0,
				["url"] = "https://wago.io/9EBTx7-J0/3",
				["config"] = {
				},
				["inverse"] = true,
				["load"] = {
					["ingroup"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 13,
						["multi"] = {
						},
					},
					["talent2"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_talent"] = true,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["use_spec"] = true,
					["spec"] = {
						["single"] = 1,
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["selfPoint"] = "CENTER",
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "onCooldown",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = {
									0.43921568627451, -- [1]
									0.43921568627451, -- [2]
									0.43921568627451, -- [3]
									1, -- [4]
								},
								["property"] = "color",
							}, -- [1]
						},
					}, -- [1]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		[")9rwipN))Kg"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201685,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["parent"] = "ChUI - Debuff Tracker - Warrior",
				["yOffset"] = 0,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["cooldownEdge"] = false,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["selfPoint"] = "CENTER",
				["desaturate"] = true,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 1,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = false,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["text_fontType"] = "OUTLINE",
						["rotateText"] = "NONE",
						["anchorXOffset"] = 0,
						["text_fontSize"] = 12,
					}, -- [1]
				},
				["height"] = 50,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["animation"] = {
					["start"] = {
						["type"] = "preset",
						["preset"] = "slidebottom",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["type"] = "preset",
						["preset"] = "slidetop",
						["duration_type"] = "seconds",
					},
				},
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["keepAspectRatio"] = false,
				["authorOptions"] = {
				},
				["url"] = "https://wago.io/Okky1Eh5g/1",
				["regionType"] = "icon",
				["triggers"] = {
					{
						["trigger"] = {
							["type"] = "aura2",
							["auranames"] = {
								"Hamstring", -- [1]
							},
							["matchesShowOn"] = "showOnMissing",
							["event"] = "Health",
							["unit"] = "target",
							["spellIds"] = {
							},
							["subeventPrefix"] = "SPELL",
							["names"] = {
							},
							["subeventSuffix"] = "_CAST_START",
							["useName"] = true,
							["debuffType"] = "HARMFUL",
						},
						["untrigger"] = {
						},
					}, -- [1]
					["activeTriggerMode"] = -10,
				},
				["xOffset"] = -55,
				["uid"] = ")9rwipN))Kg",
				["width"] = 50,
				["anchorFrameType"] = "SCREEN",
				["frameStrata"] = 1,
				["icon"] = true,
				["tocversion"] = 11302,
				["zoom"] = 0,
				["auto"] = true,
				["glowScale"] = 1,
				["id"] = "Warrior: Hamstring DOWN",
				["cooldownTextDisabled"] = false,
				["alpha"] = 1,
				["glowYOffset"] = 0,
				["glowLength"] = 10,
				["config"] = {
				},
				["inverse"] = false,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					0.48225158452988, -- [4]
				},
				["load"] = {
					["use_class"] = true,
					["use_never"] = true,
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["use_combat"] = true,
					["spec"] = {
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["conditions"] = {
				},
				["cooldown"] = false,
				["glowBorder"] = false,
			},
		},
		["GfKszA)SWXs"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201870,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["xOffset"] = 100,
				["yOffset"] = -25,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["url"] = "https://wago.io/9EBTx7-J0/3",
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
						["custom"] = "",
						["do_custom"] = false,
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 3,
				["subRegions"] = {
				},
				["height"] = 45,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["glowLength"] = 10,
				["triggers"] = {
					{
						["trigger"] = {
							["useGroup_count"] = false,
							["matchesShowOn"] = "showOnActive",
							["use_specific_unit"] = false,
							["use_tooltip"] = false,
							["debuffType"] = "HELPFUL",
							["subeventPrefix"] = "SPELL",
							["useName"] = true,
							["stacksOperator"] = ">",
							["subeventSuffix"] = "_CAST_START",
							["unit"] = "player",
							["names"] = {
								"In For The Kill", -- [1]
							},
							["event"] = "Health",
							["ownOnly"] = true,
							["type"] = "aura2",
							["spellIds"] = {
								248622, -- [1]
							},
							["name"] = "Spell Reflection",
							["use_debuffClass"] = false,
							["auranames"] = {
								"Retaliation", -- [1]
							},
							["combineMatches"] = "showLowest",
							["stacks"] = "0",
							["buffShowOn"] = "showOnActive",
						},
						["untrigger"] = {
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["load"] = {
					["ingroup"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 16,
						["multi"] = {
							[16] = true,
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["talent2"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["use_spec"] = true,
					["spec"] = {
						["single"] = 1,
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["selfPoint"] = "CENTER",
				["regionType"] = "icon",
				["keepAspectRatio"] = false,
				["uid"] = "GfKszA)SWXs",
				["glowYOffset"] = 0,
				["width"] = 45,
				["alpha"] = 1,
				["icon"] = true,
				["auto"] = true,
				["tocversion"] = 11302,
				["cooldownTextDisabled"] = false,
				["semver"] = "1.0.2",
				["glowScale"] = 1,
				["id"] = "Retaliation - Buff",
				["zoom"] = 0,
				["frameStrata"] = 1,
				["anchorFrameType"] = "SCREEN",
				["authorOptions"] = {
				},
				["config"] = {
				},
				["inverse"] = false,
				["cooldownEdge"] = false,
				["parent"] = "Warrior",
				["conditions"] = {
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["ANv(K28pP9M"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567202218,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["authorOptions"] = {
				},
				["yOffset"] = 0,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["customTextUpdate"] = "update",
				["cooldownEdge"] = false,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["selfPoint"] = "CENTER",
				["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 32,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = " ",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["text_fontSize"] = 13,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 55,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["load"] = {
					["ingroup"] = {
						["multi"] = {
						},
					},
					["use_petbattle"] = false,
					["talent2"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 17,
						["multi"] = {
							[17] = true,
						},
					},
					["use_vehicleUi"] = false,
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["use_spec"] = true,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["use_combat"] = true,
					["spec"] = {
						["single"] = 1,
						["multi"] = {
							[2] = true,
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["url"] = "https://wago.io/SkBHabbrQ/32",
				["glowFrequency"] = 0.25,
				["displayIcon"] = "",
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 4,
				["stickyDuration"] = false,
				["glowLength"] = 10,
				["uid"] = "ANv(K28pP9M",
				["regionType"] = "icon",
				["glowLines"] = 8,
				["glowYOffset"] = 0,
				["alpha"] = 1,
				["parent"] = "Luxthos - Warrior Rotations",
				["icon"] = true,
				["xOffset"] = 116,
				["auto"] = true,
				["cooldownTextDisabled"] = false,
				["zoom"] = 0.33,
				["semver"] = "1.1.2",
				["glowScale"] = 1,
				["id"] = "Sweeping Strikes - Cooldown",
				["triggers"] = {
					{
						["trigger"] = {
							["track"] = "auto",
							["ownOnly"] = true,
							["genericShowOn"] = "showAlways",
							["use_specific_unit"] = false,
							["use_showgcd"] = true,
							["subeventPrefix"] = "SPELL",
							["spellName"] = 260708,
							["duration"] = "1",
							["type"] = "status",
							["unit"] = "player",
							["unevent"] = "auto",
							["use_showOn"] = true,
							["use_genericShowOn"] = true,
							["event"] = "Cooldown Progress (Spell)",
							["subeventSuffix"] = "_CAST_START",
							["realSpellName"] = "Sweeping Strikes",
							["use_spellName"] = true,
							["spellIds"] = {
								280757, -- [1]
							},
							["use_absorbMode"] = true,
							["use_unit"] = true,
							["names"] = {
								"Avatar", -- [1]
							},
							["use_track"] = true,
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
							["showOn"] = "showAlways",
							["spellName"] = 260708,
						},
					}, -- [1]
					{
						["trigger"] = {
							["auranames"] = {
								"18765", -- [1]
							},
							["matchesShowOn"] = "showOnMissing",
							["names"] = {
								"Sweeping Strikes", -- [1]
							},
							["use_tooltip"] = false,
							["debuffType"] = "HELPFUL",
							["useName"] = true,
							["use_debuffClass"] = false,
							["subeventSuffix"] = "_CAST_START",
							["event"] = "Health",
							["ownOnly"] = true,
							["buffShowOn"] = "showOnMissing",
							["spellIds"] = {
								18765, -- [1]
							},
							["type"] = "aura2",
							["useGroup_count"] = false,
							["combineMatches"] = "showLowest",
							["unit"] = "player",
							["subeventPrefix"] = "SPELL",
						},
						["untrigger"] = {
						},
					}, -- [2]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["frameStrata"] = 1,
				["anchorFrameType"] = "SCREEN",
				["width"] = 55,
				["config"] = {
				},
				["inverse"] = true,
				["desaturate"] = false,
				["keepAspectRatio"] = true,
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "onCooldown",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [1]
							{
								["value"] = true,
								["property"] = "cooldownEdge",
							}, -- [2]
						},
					}, -- [1]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["kZjDNJr8QN1"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201685,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["parent"] = "ChUI - Debuff Tracker - Warrior",
				["yOffset"] = 0,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["cooldownEdge"] = false,
				["icon"] = true,
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["keepAspectRatio"] = false,
				["animation"] = {
					["start"] = {
						["type"] = "preset",
						["preset"] = "slidebottom",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["type"] = "preset",
						["preset"] = "slidetop",
						["duration_type"] = "seconds",
					},
				},
				["desaturate"] = true,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 1,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = false,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["text_fontType"] = "OUTLINE",
						["rotateText"] = "NONE",
						["anchorXOffset"] = 0,
						["text_fontSize"] = 12,
					}, -- [1]
				},
				["height"] = 50,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					0.48225158452988, -- [4]
				},
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["url"] = "https://wago.io/Okky1Eh5g/1",
				["xOffset"] = 110,
				["regionType"] = "icon",
				["triggers"] = {
					{
						["trigger"] = {
							["useName"] = true,
							["auranames"] = {
								"Demoralizing Shout", -- [1]
							},
							["matchesShowOn"] = "showOnMissing",
							["event"] = "Health",
							["unit"] = "target",
							["spellIds"] = {
							},
							["subeventPrefix"] = "SPELL",
							["names"] = {
							},
							["subeventSuffix"] = "_CAST_START",
							["type"] = "aura2",
							["debuffType"] = "HARMFUL",
						},
						["untrigger"] = {
						},
					}, -- [1]
					["activeTriggerMode"] = -10,
				},
				["glowLength"] = 10,
				["uid"] = "kZjDNJr8QN1",
				["glowYOffset"] = 0,
				["anchorFrameType"] = "SCREEN",
				["frameStrata"] = 1,
				["glowXOffset"] = 0,
				["tocversion"] = 11302,
				["cooldownTextDisabled"] = false,
				["auto"] = true,
				["glowScale"] = 1,
				["id"] = "Warrior: Demo Shout DOWN",
				["zoom"] = 0,
				["alpha"] = 1,
				["width"] = 50,
				["authorOptions"] = {
				},
				["config"] = {
				},
				["inverse"] = false,
				["load"] = {
					["use_class"] = true,
					["use_never"] = true,
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["use_combat"] = true,
					["spec"] = {
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["selfPoint"] = "CENTER",
				["conditions"] = {
				},
				["cooldown"] = false,
				["glowBorder"] = false,
			},
		},
		["TTNuTdwJzLK"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201685,
			["allowUpdates"] = true,
			["data"] = {
				["backdropColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					0.5, -- [4]
				},
				["controlledChildren"] = {
				},
				["borderBackdrop"] = "Blizzard Tooltip",
				["xOffset"] = 0,
				["yOffset"] = -275,
				["border"] = false,
				["borderEdge"] = "1 Pixel",
				["regionType"] = "group",
				["borderSize"] = 2,
				["scale"] = 1,
				["borderColor"] = {
					0, -- [1]
					0, -- [2]
					0, -- [3]
					1, -- [4]
				},
				["anchorPoint"] = "CENTER",
				["url"] = "https://wago.io/Okky1Eh5g/1",
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["triggers"] = {
					{
						["trigger"] = {
							["debuffType"] = "HELPFUL",
							["type"] = "aura2",
							["spellIds"] = {
							},
							["subeventSuffix"] = "_CAST_START",
							["names"] = {
							},
							["subeventPrefix"] = "SPELL",
							["event"] = "Health",
							["unit"] = "player",
						},
						["untrigger"] = {
						},
					}, -- [1]
				},
				["internalVersion"] = 23,
				["borderOffset"] = 4,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["selfPoint"] = "BOTTOMLEFT",
				["id"] = "ChUI - Debuff Tracker - Warrior",
				["uid"] = "TTNuTdwJzLK",
				["frameStrata"] = 1,
				["anchorFrameType"] = "SCREEN",
				["borderInset"] = 1,
				["config"] = {
				},
				["version"] = 1,
				["subRegions"] = {
				},
				["tocversion"] = 11302,
				["conditions"] = {
				},
				["load"] = {
					["use_class"] = "true",
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["spec"] = {
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["authorOptions"] = {
				},
			},
		},
		["S5Vdf86u7j3"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201870,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["glowLength"] = 10,
				["yOffset"] = -162,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["url"] = "https://wago.io/9EBTx7-J0/3",
				["icon"] = true,
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 3,
				["subRegions"] = {
				},
				["height"] = 45,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["selfPoint"] = "CENTER",
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["cooldownEdge"] = false,
				["triggers"] = {
					{
						["trigger"] = {
							["use_genericShowOn"] = true,
							["genericShowOn"] = "showAlways",
							["subeventPrefix"] = "SPELL",
							["spellName"] = 23922,
							["type"] = "status",
							["debuffType"] = "HELPFUL",
							["subeventSuffix"] = "_CAST_START",
							["use_showOn"] = true,
							["unit"] = "player",
							["event"] = "Cooldown Progress (Spell)",
							["unevent"] = "auto",
							["realSpellName"] = "Shield Slam",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["names"] = {
							},
							["use_absorbMode"] = true,
							["use_unit"] = true,
							["use_track"] = true,
							["duration"] = "1",
						},
						["untrigger"] = {
							["showOn"] = "showAlways",
							["spellName"] = 12294,
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["regionType"] = "icon",
				["parent"] = "Warrior",
				["config"] = {
				},
				["glowYOffset"] = 0,
				["anchorFrameType"] = "SCREEN",
				["frameStrata"] = 1,
				["xOffset"] = -100,
				["auto"] = true,
				["tocversion"] = 11302,
				["zoom"] = 0,
				["semver"] = "1.0.2",
				["glowScale"] = 1,
				["id"] = "Shield Slam",
				["cooldownTextDisabled"] = false,
				["alpha"] = 1,
				["width"] = 45,
				["authorOptions"] = {
				},
				["uid"] = "S5Vdf86u7j3",
				["inverse"] = true,
				["keepAspectRatio"] = false,
				["load"] = {
					["ingroup"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 57,
						["multi"] = {
						},
					},
					["talent2"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_talent"] = true,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["use_spec"] = true,
					["spec"] = {
						["single"] = 1,
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "onCooldown",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = {
									0.43921568627451, -- [1]
									0.43921568627451, -- [2]
									0.43921568627451, -- [3]
									1, -- [4]
								},
								["property"] = "color",
							}, -- [1]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "spellUsable",
							["value"] = 0,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [1]
							{
								["value"] = true,
								["property"] = "inverse",
							}, -- [2]
						},
					}, -- [2]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["EUy80uqQYkk"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201870,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["xOffset"] = 100,
				["yOffset"] = -162,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["cooldownEdge"] = false,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["keepAspectRatio"] = false,
				["selfPoint"] = "CENTER",
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 3,
				["subRegions"] = {
				},
				["height"] = 45,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["url"] = "https://wago.io/9EBTx7-J0/3",
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["triggers"] = {
					{
						["trigger"] = {
							["duration"] = "1",
							["genericShowOn"] = "showAlways",
							["use_unit"] = true,
							["debuffType"] = "HELPFUL",
							["spellName"] = 12328,
							["type"] = "status",
							["use_genericShowOn"] = true,
							["unevent"] = "auto",
							["use_showOn"] = true,
							["subeventSuffix"] = "_CAST_START",
							["event"] = "Cooldown Progress (Spell)",
							["unit"] = "player",
							["realSpellName"] = "Death Wish",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["subeventPrefix"] = "SPELL",
							["use_absorbMode"] = true,
							["names"] = {
							},
							["use_track"] = true,
							["use_charges"] = false,
						},
						["untrigger"] = {
							["showOn"] = "showAlways",
							["spellName"] = 260708,
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["glowLength"] = 10,
				["load"] = {
					["ingroup"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 33,
						["multi"] = {
						},
					},
					["talent2"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_talent"] = true,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["use_spec"] = true,
					["spec"] = {
						["single"] = 1,
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["regionType"] = "icon",
				["parent"] = "Warrior",
				["uid"] = "EUy80uqQYkk",
				["glowYOffset"] = 0,
				["width"] = 45,
				["frameStrata"] = 1,
				["icon"] = true,
				["auto"] = true,
				["tocversion"] = 11302,
				["cooldownTextDisabled"] = false,
				["semver"] = "1.0.2",
				["glowScale"] = 1,
				["id"] = "Death Wish",
				["zoom"] = 0,
				["alpha"] = 1,
				["anchorFrameType"] = "SCREEN",
				["glowXOffset"] = 0,
				["config"] = {
				},
				["inverse"] = true,
				["authorOptions"] = {
				},
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "onCooldown",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = {
									0.43921568627451, -- [1]
									0.43921568627451, -- [2]
									0.43921568627451, -- [3]
									1, -- [4]
								},
								["property"] = "color",
							}, -- [1]
						},
					}, -- [1]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["OTMA9LXkPr9"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567277425,
			["allowUpdates"] = true,
			["data"] = {
				["sparkWidth"] = 20,
				["sparkOffsetX"] = 0,
				["authorOptions"] = {
				},
				["yOffset"] = -156.12695744284,
				["anchorPoint"] = "CENTER",
				["sparkRotation"] = 0,
				["sparkRotationMode"] = "AUTO",
				["url"] = "https://wago.io/Eh5J56-nY/1",
				["backgroundColor"] = {
					0, -- [1]
					0, -- [2]
					0, -- [3]
					0.5, -- [4]
				},
				["triggers"] = {
					{
						["trigger"] = {
							["use_castType"] = false,
							["type"] = "status",
							["use_spell"] = false,
							["unevent"] = "auto",
							["duration"] = "1",
							["matchesShowOn"] = "showAlways",
							["event"] = "Swing Timer",
							["unit"] = "player",
							["use_unit"] = true,
							["names"] = {
							},
							["spellIds"] = {
							},
							["use_hand"] = true,
							["subeventPrefix"] = "SPELL",
							["subeventSuffix"] = "_CAST_START",
							["hand"] = "main",
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [1]
					["disjunctive"] = "any",
					["activeTriggerMode"] = -10,
				},
				["icon_color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["internalVersion"] = 23,
				["selfPoint"] = "CENTER",
				["backdropInFront"] = false,
				["barColor"] = {
					0, -- [1]
					0.63529411764706, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["stickyDuration"] = false,
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["version"] = 1,
				["subRegions"] = {
					{
						["type"] = "aurabar_bar",
					}, -- [1]
					{
						["text_shadowXOffset"] = 1,
						["type"] = "subtext",
						["text_text"] = "%p",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = -1,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_LEFT",
						["anchorYOffset"] = 0,
						["rotateText"] = "NONE",
						["text_fontSize"] = 12,
						["anchorXOffset"] = 0,
						["text_fontType"] = "None",
					}, -- [2]
					{
						["text_shadowXOffset"] = 1,
						["type"] = "subtext",
						["text_text"] = "%n",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = -1,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = false,
						["text_anchorPoint"] = "INNER_RIGHT",
						["anchorYOffset"] = 0,
						["rotateText"] = "NONE",
						["text_fontSize"] = 12,
						["anchorXOffset"] = 0,
						["text_fontType"] = "None",
					}, -- [3]
					{
						["border_offset"] = 5,
						["border_anchor"] = "bar",
						["border_size"] = 16,
						["border_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							0.5, -- [4]
						},
						["border_visible"] = false,
						["border_edge"] = "None",
						["type"] = "subborder",
					}, -- [4]
				},
				["height"] = 7,
				["sparkOffsetY"] = 0,
				["load"] = {
					["class"] = {
						["multi"] = {
						},
					},
					["spec"] = {
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["sparkBlendMode"] = "ADD",
				["backdropColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					0.5, -- [4]
				},
				["parent"] = "Arms",
				["icon"] = false,
				["xOffset"] = 18.249756377361,
				["borderBackdrop"] = "Blizzard Tooltip",
				["sparkColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["smoothProgress"] = true,
				["useAdjustededMin"] = false,
				["regionType"] = "aurabar",
				["borderInFront"] = true,
				["useAdjustededMax"] = false,
				["icon_side"] = "RIGHT",
				["anchorFrameType"] = "SCREEN",
				["frameStrata"] = 1,
				["sparkHeight"] = 20,
				["texture"] = "Blizzard",
				["zoom"] = 0,
				["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
				["spark"] = true,
				["tocversion"] = 11302,
				["sparkHidden"] = "NEVER",
				["id"] = "Swing Timer",
				["alpha"] = 1,
				["width"] = 231.49963378906,
				["auto"] = true,
				["config"] = {
				},
				["inverse"] = true,
				["uid"] = "OTMA9LXkPr9",
				["orientation"] = "HORIZONTAL",
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "interruptible",
							["value"] = 0,
						},
						["changes"] = {
							{
								["value"] = {
									0.8, -- [1]
									0.1, -- [2]
									0.1, -- [3]
									1, -- [4]
								},
								["property"] = "barColor",
							}, -- [1]
						},
					}, -- [1]
				},
				["actions"] = {
					["start"] = {
					},
					["init"] = {
					},
					["finish"] = {
					},
				},
				["desaturate"] = false,
			},
		},
		["6g(HLjTc2tp"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201870,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["glowLength"] = 10,
				["yOffset"] = -204.99975585938,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["cooldownEdge"] = false,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
						["custom"] = "aura_env.region.stacks:SetPoint(\"BOTTOMRIGHT\", aura_env.region, \"BOTTOMRIGHT\", 0, 0)\naura_env.region.stacks:SetShadowOffset(1, -1)",
						["do_custom"] = false,
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["keepAspectRatio"] = false,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 3,
				["subRegions"] = {
				},
				["height"] = 35,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["glowXOffset"] = 0,
				["selfPoint"] = "CENTER",
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["triggers"] = {
					{
						["trigger"] = {
							["use_genericShowOn"] = true,
							["genericShowOn"] = "showAlways",
							["subeventPrefix"] = "SPELL",
							["spellName"] = 100,
							["type"] = "status",
							["debuffType"] = "HELPFUL",
							["subeventSuffix"] = "_CAST_START",
							["use_showOn"] = true,
							["unit"] = "player",
							["event"] = "Cooldown Progress (Spell)",
							["unevent"] = "auto",
							["realSpellName"] = "Charge",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["names"] = {
							},
							["use_absorbMode"] = true,
							["use_unit"] = true,
							["use_track"] = true,
							["duration"] = "1",
						},
						["untrigger"] = {
							["showOn"] = "showAlways",
							["spellName"] = 100,
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["load"] = {
					["talent2"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["ingroup"] = {
						["multi"] = {
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["race"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_combat"] = false,
					["spec"] = {
						["single"] = 1,
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["regionType"] = "icon",
				["authorOptions"] = {
				},
				["uid"] = "6g(HLjTc2tp",
				["glowYOffset"] = 0,
				["width"] = 35,
				["frameStrata"] = 1,
				["xOffset"] = 18.999877929688,
				["auto"] = true,
				["glowScale"] = 1,
				["cooldownTextDisabled"] = false,
				["semver"] = "1.0.2",
				["tocversion"] = 11302,
				["id"] = "Charge",
				["zoom"] = 0,
				["alpha"] = 1,
				["anchorFrameType"] = "SCREEN",
				["icon"] = true,
				["config"] = {
				},
				["inverse"] = false,
				["parent"] = "Warrior",
				["url"] = "https://wago.io/9EBTx7-J0/3",
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = -1,
							["op"] = "==",
							["variable"] = "incombat",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = {
									0.43921568627451, -- [1]
									0.43921568627451, -- [2]
									0.43921568627451, -- [3]
									1, -- [4]
								},
								["property"] = "color",
							}, -- [1]
							{
								["value"] = true,
								["property"] = "inverse",
							}, -- [2]
						},
					}, -- [1]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["MCB61TD9FkA"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567202218,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["authorOptions"] = {
				},
				["customText"] = "function()\n    return select(3, WA_GetUnitBuff(\"player\", 7384))\nend",
				["yOffset"] = 0,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["customTextUpdate"] = "update",
				["cooldownEdge"] = false,
				["icon"] = true,
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["selfPoint"] = "CENTER",
				["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
				["progressPrecision"] = 0,
				["glowLength"] = 10,
				["version"] = 32,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = " ",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["text_fontSize"] = 13,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 55,
				["url"] = "https://wago.io/SkBHabbrQ/32",
				["load"] = {
					["ingroup"] = {
						["multi"] = {
						},
					},
					["use_never"] = false,
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["use_class"] = true,
					["role"] = {
						["multi"] = {
						},
					},
					["use_spec"] = true,
					["size"] = {
						["multi"] = {
						},
					},
					["talent2"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 3,
						["multi"] = {
							[9] = true,
							[8] = true,
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							true, -- [1]
							true, -- [2]
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["use_vehicleUi"] = false,
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_petbattle"] = false,
					["use_combat"] = true,
					["race"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
				},
				["displayIcon"] = 136012,
				["glowFrequency"] = 0.25,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["stickyDuration"] = false,
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 4,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["uid"] = "MCB61TD9FkA",
				["glowLines"] = 8,
				["regionType"] = "icon",
				["glowYOffset"] = 0,
				["alpha"] = 1,
				["width"] = 55,
				["triggers"] = {
					{
						["trigger"] = {
							["duration"] = "1",
							["genericShowOn"] = "showAlways",
							["use_unit"] = true,
							["use_showgcd"] = true,
							["powertype"] = 1,
							["use_powertype"] = true,
							["debuffType"] = "HELPFUL",
							["type"] = "status",
							["unit"] = "player",
							["subeventSuffix"] = "_CAST_START",
							["use_showOn"] = true,
							["use_absorbMode"] = true,
							["event"] = "Cooldown Progress (Spell)",
							["unevent"] = "auto",
							["realSpellName"] = "Revenge",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["use_genericShowOn"] = true,
							["spellName"] = 6572,
							["names"] = {
							},
							["use_track"] = true,
							["subeventPrefix"] = "SPELL",
						},
						["untrigger"] = {
							["showOn"] = "showAlways",
							["spellName"] = 6572,
						},
					}, -- [1]
					{
						["trigger"] = {
							["auranames"] = {
								"202573", -- [1]
							},
							["matchesShowOn"] = "showAlways",
							["names"] = {
								"Vengeance: Ignore Pain", -- [1]
							},
							["use_tooltip"] = false,
							["debuffType"] = "HELPFUL",
							["type"] = "aura2",
							["use_debuffClass"] = false,
							["subeventSuffix"] = "_CAST_START",
							["event"] = "Health",
							["unit"] = "player",
							["ownOnly"] = true,
							["spellIds"] = {
								202574, -- [1]
							},
							["useName"] = true,
							["useGroup_count"] = false,
							["combineMatches"] = "showLowest",
							["subeventPrefix"] = "SPELL",
							["buffShowOn"] = "showAlways",
						},
						["untrigger"] = {
						},
					}, -- [2]
					{
						["trigger"] = {
							["auranames"] = {
								"5302", -- [1]
							},
							["matchesShowOn"] = "showAlways",
							["names"] = {
								"Revenge!", -- [1]
							},
							["use_tooltip"] = false,
							["debuffType"] = "HELPFUL",
							["type"] = "aura2",
							["use_debuffClass"] = false,
							["subeventSuffix"] = "_CAST_START",
							["event"] = "Health",
							["unit"] = "player",
							["ownOnly"] = true,
							["spellIds"] = {
								5302, -- [1]
							},
							["useName"] = true,
							["useGroup_count"] = false,
							["combineMatches"] = "showLowest",
							["subeventPrefix"] = "SPELL",
							["buffShowOn"] = "showAlways",
						},
						["untrigger"] = {
						},
					}, -- [3]
					["disjunctive"] = "any",
					["customTriggerLogic"] = "function(t)\n    if t[4] then\n        aura_env.region:SetGlow(true)\n    else \n        aura_env.region:SetGlow(false)\n    end\n    return t[3]\nend",
					["activeTriggerMode"] = -10,
				},
				["parent"] = "Luxthos - Warrior Rotations",
				["auto"] = true,
				["cooldownTextDisabled"] = false,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["zoom"] = 0.33,
				["semver"] = "1.1.2",
				["glowScale"] = 1,
				["id"] = "Revenge",
				["desaturate"] = false,
				["frameStrata"] = 3,
				["anchorFrameType"] = "SCREEN",
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["config"] = {
				},
				["inverse"] = true,
				["xOffset"] = 116,
				["keepAspectRatio"] = true,
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "onCooldown",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [1]
							{
								["value"] = true,
								["property"] = "cooldownEdge",
							}, -- [2]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = 1,
							["op"] = "<",
							["value"] = 1,
							["variable"] = "insufficientResources",
						},
						["changes"] = {
							{
								["value"] = {
									0.31764705882353, -- [1]
									0.40392156862745, -- [2]
									0.78039215686274, -- [3]
									1, -- [4]
								},
								["property"] = "color",
							}, -- [1]
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [2]
						},
					}, -- [2]
					{
						["check"] = {
							["trigger"] = 3,
							["variable"] = "buffed",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
						},
					}, -- [3]
					{
						["check"] = {
							["trigger"] = 2,
							["variable"] = "buffed",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
							{
								["value"] = "ACShine",
								["property"] = "glowType",
							}, -- [2]
						},
					}, -- [4]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["9(wssH567lA"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201870,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["authorOptions"] = {
				},
				["yOffset"] = -25,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["cooldownEdge"] = false,
				["icon"] = true,
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["keepAspectRatio"] = false,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 3,
				["subRegions"] = {
				},
				["height"] = 45,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["selfPoint"] = "CENTER",
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
						["custom"] = "",
						["do_custom"] = false,
					},
				},
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["triggers"] = {
					{
						["trigger"] = {
							["auranames"] = {
								"Recklessness", -- [1]
							},
							["matchesShowOn"] = "showOnActive",
							["use_specific_unit"] = false,
							["stacks"] = "0",
							["debuffType"] = "HELPFUL",
							["names"] = {
								"In For The Kill", -- [1]
							},
							["type"] = "aura2",
							["stacksOperator"] = ">",
							["subeventSuffix"] = "_CAST_START",
							["subeventPrefix"] = "SPELL",
							["useGroup_count"] = false,
							["event"] = "Health",
							["use_debuffClass"] = false,
							["useName"] = true,
							["spellIds"] = {
								248622, -- [1]
							},
							["name"] = "Spell Reflection",
							["ownOnly"] = true,
							["unit"] = "player",
							["combineMatches"] = "showLowest",
							["use_tooltip"] = false,
							["buffShowOn"] = "showOnActive",
						},
						["untrigger"] = {
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["load"] = {
					["talent2"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 16,
						["multi"] = {
							[16] = true,
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["ingroup"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["use_spec"] = true,
					["spec"] = {
						["single"] = 1,
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["parent"] = "Warrior",
				["regionType"] = "icon",
				["glowLength"] = 10,
				["uid"] = "9(wssH567lA",
				["glowYOffset"] = 0,
				["width"] = 45,
				["alpha"] = 1,
				["xOffset"] = 100,
				["auto"] = true,
				["glowScale"] = 1,
				["cooldownTextDisabled"] = false,
				["semver"] = "1.0.2",
				["tocversion"] = 11302,
				["id"] = "Recklessness - Buff",
				["zoom"] = 0,
				["frameStrata"] = 1,
				["anchorFrameType"] = "SCREEN",
				["glowXOffset"] = 0,
				["config"] = {
				},
				["inverse"] = false,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["url"] = "https://wago.io/9EBTx7-J0/3",
				["conditions"] = {
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["iu4iAmkGEuo"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201870,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["xOffset"] = -100,
				["yOffset"] = -73,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["cooldownEdge"] = false,
				["icon"] = true,
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 3,
				["subRegions"] = {
				},
				["height"] = 45,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["selfPoint"] = "CENTER",
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
						["custom"] = "",
						["do_custom"] = false,
					},
				},
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["triggers"] = {
					{
						["trigger"] = {
							["track"] = "auto",
							["auranames"] = {
								"215572", -- [1]
							},
							["matchesShowOn"] = "showOnActive",
							["genericShowOn"] = "showAlways",
							["subeventPrefix"] = "SPELL",
							["use_tooltip"] = false,
							["unit"] = "player",
							["use_unit"] = true,
							["use_genericShowOn"] = true,
							["type"] = "status",
							["unevent"] = "auto",
							["buffShowOn"] = "showOnActive",
							["name"] = "Spell Reflection",
							["useName"] = true,
							["use_debuffClass"] = false,
							["subeventSuffix"] = "_CAST_START",
							["duration"] = "1",
							["spellName"] = 7887,
							["event"] = "Cooldown Progress (Spell)",
							["useGroup_count"] = false,
							["realSpellName"] = "Overpower",
							["use_spellName"] = true,
							["spellIds"] = {
								215572, -- [1]
							},
							["debuffType"] = "HELPFUL",
							["ownOnly"] = true,
							["combineMatches"] = "showLowest",
							["use_track"] = true,
							["names"] = {
								"Frothing Berserker", -- [1]
							},
						},
						["untrigger"] = {
							["genericShowOn"] = "showAlways",
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["load"] = {
					["talent2"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 15,
						["multi"] = {
							[15] = true,
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["ingroup"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["use_spec"] = true,
					["spec"] = {
						["single"] = 2,
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["glowLength"] = 10,
				["regionType"] = "icon",
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["uid"] = "iu4iAmkGEuo",
				["glowYOffset"] = 0,
				["anchorFrameType"] = "SCREEN",
				["frameStrata"] = 1,
				["keepAspectRatio"] = false,
				["auto"] = true,
				["tocversion"] = 11302,
				["cooldownTextDisabled"] = false,
				["semver"] = "1.0.2",
				["glowScale"] = 1,
				["id"] = "Overpower - Usable",
				["zoom"] = 0,
				["alpha"] = 1,
				["width"] = 45,
				["authorOptions"] = {
				},
				["config"] = {
				},
				["inverse"] = false,
				["parent"] = "Warrior",
				["url"] = "https://wago.io/9EBTx7-J0/3",
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "spellUsable",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
							{
							}, -- [2]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "spellUsable",
							["value"] = 0,
						},
						["changes"] = {
							{
								["property"] = "alpha",
							}, -- [1]
						},
					}, -- [2]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["LSpSsxP(NIf"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201870,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["xOffset"] = 100.00048828125,
				["yOffset"] = -73,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["cooldownEdge"] = false,
				["icon"] = true,
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 3,
				["subRegions"] = {
				},
				["height"] = 45,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
						["custom"] = "\n\n",
						["do_custom"] = false,
					},
				},
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["url"] = "https://wago.io/9EBTx7-J0/3",
				["authorOptions"] = {
				},
				["triggers"] = {
					{
						["trigger"] = {
							["type"] = "aura2",
							["auranames"] = {
								"Concussion Blow", -- [1]
							},
							["ownOnly"] = true,
							["event"] = "Health",
							["unit"] = "target",
							["debuffType"] = "HARMFUL",
							["spellIds"] = {
								260708, -- [1]
							},
							["subeventSuffix"] = "_CAST_START",
							["useName"] = true,
							["subeventPrefix"] = "SPELL",
							["names"] = {
								"Sweeping Strikes", -- [1]
							},
							["buffShowOn"] = "showOnActive",
						},
						["untrigger"] = {
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["regionType"] = "icon",
				["selfPoint"] = "CENTER",
				["uid"] = "LSpSsxP(NIf",
				["parent"] = "Warrior",
				["anchorFrameType"] = "SCREEN",
				["frameStrata"] = 1,
				["load"] = {
					["ingroup"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 54,
						["multi"] = {
							[16] = true,
						},
					},
					["talent2"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_talent"] = true,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["use_spec"] = true,
					["spec"] = {
						["single"] = 1,
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["auto"] = true,
				["glowScale"] = 1,
				["cooldownTextDisabled"] = false,
				["semver"] = "1.0.2",
				["tocversion"] = 11302,
				["id"] = "Concussion Blow - Debuff",
				["zoom"] = 0,
				["alpha"] = 1,
				["glowYOffset"] = 0,
				["width"] = 45,
				["config"] = {
				},
				["inverse"] = false,
				["glowLength"] = 10,
				["keepAspectRatio"] = false,
				["conditions"] = {
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["7)K8xWJ8t3W"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567277425,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["xOffset"] = 4,
				["yOffset"] = -89.000061035156,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = false,
				["cooldownEdge"] = false,
				["actions"] = {
					["start"] = {
					},
					["init"] = {
					},
					["finish"] = {
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["desaturate"] = true,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 1,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["rotateText"] = "NONE",
						["text_fontSize"] = 12,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 40,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["keepAspectRatio"] = false,
				["glowLength"] = 10,
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["icon"] = true,
				["url"] = "https://wago.io/Eh5J56-nY/1",
				["width"] = 40,
				["regionType"] = "icon",
				["config"] = {
				},
				["selfPoint"] = "CENTER",
				["glowYOffset"] = 0,
				["alpha"] = 1,
				["authorOptions"] = {
				},
				["cooldownTextDisabled"] = false,
				["tocversion"] = 11302,
				["auto"] = true,
				["zoom"] = 0,
				["useGlowColor"] = false,
				["glowScale"] = 1,
				["id"] = "Overpower",
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["frameStrata"] = 1,
				["anchorFrameType"] = "SCREEN",
				["parent"] = "Arms",
				["uid"] = "7)K8xWJ8t3W",
				["inverse"] = false,
				["load"] = {
					["use_class"] = true,
					["use_spellknown"] = true,
					["talent"] = {
						["multi"] = {
							[21] = true,
							[19] = true,
						},
					},
					["spec"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["spellknown"] = 7384,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["triggers"] = {
					{
						["trigger"] = {
							["use_form"] = true,
							["matchesShowOn"] = "showAlways",
							["genericShowOn"] = "showAlways",
							["names"] = {
							},
							["debuffType"] = "HELPFUL",
							["type"] = "status",
							["subeventPrefix"] = "SPELL",
							["subeventSuffix"] = "_CAST_START",
							["use_unit"] = true,
							["form"] = {
								["single"] = 1,
							},
							["event"] = "Cooldown Progress (Spell)",
							["use_genericShowOn"] = true,
							["realSpellName"] = "Overpower",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["spellName"] = 7384,
							["duration"] = "1",
							["unevent"] = "auto",
							["use_track"] = true,
							["unit"] = "player",
						},
						["untrigger"] = {
						},
					}, -- [1]
					{
						["trigger"] = {
							["use_form"] = true,
							["subeventSuffix"] = "_CAST_START",
							["duration"] = "1",
							["event"] = "Stance/Form/Aura",
							["use_unit"] = true,
							["realSpellName"] = 0,
							["use_spellName"] = true,
							["unevent"] = "auto",
							["type"] = "status",
							["form"] = {
								["single"] = 1,
							},
							["subeventPrefix"] = "SPELL",
							["unit"] = "player",
							["spellName"] = 0,
						},
						["untrigger"] = {
						},
					}, -- [2]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "spellUsable",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
							{
								["property"] = "desaturate",
							}, -- [2]
						},
					}, -- [1]
					{
						["check"] = {
						},
						["changes"] = {
							{
							}, -- [1]
						},
					}, -- [2]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["F5qcAw92t62"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567277425,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["parent"] = "Arms",
				["yOffset"] = -55,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = false,
				["url"] = "https://wago.io/Eh5J56-nY/1",
				["actions"] = {
					["start"] = {
						["do_glow"] = true,
						["glow_type"] = "Pixel",
					},
					["init"] = {
					},
					["finish"] = {
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["keepAspectRatio"] = false,
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["desaturate"] = true,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 1,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["rotateText"] = "NONE",
						["text_fontSize"] = 12,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 25,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["glowType"] = "Pixel",
				["glowThickness"] = 1,
				["glowLength"] = 10,
				["authorOptions"] = {
				},
				["cooldownEdge"] = false,
				["regionType"] = "icon",
				["load"] = {
					["use_class"] = true,
					["spec"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["config"] = {
				},
				["glowYOffset"] = 0,
				["anchorFrameType"] = "SCREEN",
				["frameStrata"] = 1,
				["zoom"] = 0,
				["icon"] = true,
				["glowScale"] = 1,
				["cooldownTextDisabled"] = false,
				["auto"] = true,
				["tocversion"] = 11302,
				["id"] = "Thunder Clap",
				["selfPoint"] = "CENTER",
				["alpha"] = 1,
				["width"] = 25,
				["xOffset"] = -2,
				["uid"] = "F5qcAw92t62",
				["inverse"] = false,
				["glowXOffset"] = 0,
				["triggers"] = {
					{
						["trigger"] = {
							["auranames"] = {
								"Hamstring", -- [1]
							},
							["duration"] = "1",
							["genericShowOn"] = "showAlways",
							["names"] = {
							},
							["debuffType"] = "HARMFUL",
							["type"] = "status",
							["unit"] = "target",
							["unevent"] = "auto",
							["subeventSuffix"] = "_CAST_START",
							["use_unit"] = true,
							["event"] = "Cooldown Progress (Spell)",
							["use_genericShowOn"] = true,
							["realSpellName"] = "Thunder Clap",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["matchesShowOn"] = "showAlways",
							["useName"] = true,
							["subeventPrefix"] = "SPELL",
							["use_track"] = true,
							["spellName"] = 8198,
						},
						["untrigger"] = {
							["genericShowOn"] = "showAlways",
						},
					}, -- [1]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["duration"] = "1",
							["use_showCost"] = false,
							["unit"] = "player",
							["powertype"] = 1,
							["subeventPrefix"] = "SPELL",
							["event"] = "Power",
							["use_unit"] = true,
							["subeventSuffix"] = "_CAST_START",
							["use_powertype"] = true,
							["use_requirePowerType"] = false,
						},
						["untrigger"] = {
						},
					}, -- [2]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["form"] = {
								["single"] = 1,
							},
							["event"] = "Stance/Form/Aura",
							["unit"] = "player",
							["use_unit"] = true,
							["use_form"] = true,
							["subeventSuffix"] = "_CAST_START",
							["duration"] = "1",
							["subeventPrefix"] = "SPELL",
						},
						["untrigger"] = {
						},
					}, -- [3]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = -1,
							["variable"] = "incombat",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = 1,
								["property"] = "alpha",
							}, -- [1]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = 3,
							["op"] = "==",
							["variable"] = "form",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = 1,
								["property"] = "alpha",
							}, -- [1]
						},
					}, -- [2]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["Vgjk4G4Bxh3"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201870,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["xOffset"] = 100.00048828125,
				["yOffset"] = -76,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["cooldownEdge"] = false,
				["icon"] = true,
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 3,
				["subRegions"] = {
				},
				["height"] = 45,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
						["custom"] = "\n\n",
						["do_custom"] = false,
					},
				},
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["url"] = "https://wago.io/9EBTx7-J0/3",
				["authorOptions"] = {
				},
				["triggers"] = {
					{
						["trigger"] = {
							["useGroup_count"] = false,
							["matchesShowOn"] = "showOnActive",
							["subeventPrefix"] = "SPELL",
							["use_tooltip"] = false,
							["debuffType"] = "HARMFUL",
							["useName"] = true,
							["use_debuffClass"] = false,
							["subeventSuffix"] = "_CAST_START",
							["event"] = "Health",
							["names"] = {
								"Sweeping Strikes", -- [1]
							},
							["unit"] = "player",
							["spellIds"] = {
								260708, -- [1]
							},
							["type"] = "aura2",
							["auranames"] = {
								"Death Wish", -- [1]
							},
							["combineMatches"] = "showLowest",
							["ownOnly"] = true,
							["buffShowOn"] = "showOnActive",
						},
						["untrigger"] = {
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["regionType"] = "icon",
				["selfPoint"] = "CENTER",
				["uid"] = "Vgjk4G4Bxh3",
				["parent"] = "Warrior",
				["anchorFrameType"] = "SCREEN",
				["frameStrata"] = 1,
				["load"] = {
					["ingroup"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 33,
						["multi"] = {
							[16] = true,
						},
					},
					["talent2"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_talent"] = true,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["use_spec"] = true,
					["spec"] = {
						["single"] = 1,
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["auto"] = true,
				["glowScale"] = 1,
				["cooldownTextDisabled"] = false,
				["semver"] = "1.0.2",
				["tocversion"] = 11302,
				["id"] = "Death Wish - Buff",
				["zoom"] = 0,
				["alpha"] = 1,
				["glowYOffset"] = 0,
				["width"] = 45,
				["config"] = {
				},
				["inverse"] = false,
				["glowLength"] = 10,
				["keepAspectRatio"] = false,
				["conditions"] = {
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["4vdVpT9hRTh"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567277425,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["parent"] = "Arms",
				["yOffset"] = -68.14,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = false,
				["cooldownEdge"] = false,
				["actions"] = {
					["start"] = {
						["do_glow"] = true,
						["glow_type"] = "Pixel",
					},
					["init"] = {
					},
					["finish"] = {
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["selfPoint"] = "CENTER",
				["desaturate"] = true,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 1,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["rotateText"] = "NONE",
						["text_fontSize"] = 12,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 48,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["glowType"] = "Pixel",
				["glowThickness"] = 1,
				["authorOptions"] = {
				},
				["url"] = "https://wago.io/Eh5J56-nY/1",
				["zoom"] = 0,
				["regionType"] = "icon",
				["load"] = {
					["use_class"] = true,
					["spec"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["config"] = {
				},
				["width"] = 48,
				["glowYOffset"] = 0,
				["alpha"] = 1,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["xOffset"] = -125.5,
				["glowScale"] = 1,
				["cooldownTextDisabled"] = false,
				["auto"] = true,
				["tocversion"] = 11302,
				["id"] = "Taunt2",
				["icon"] = true,
				["frameStrata"] = 1,
				["anchorFrameType"] = "SCREEN",
				["keepAspectRatio"] = false,
				["uid"] = "4vdVpT9hRTh",
				["inverse"] = false,
				["glowLength"] = 10,
				["triggers"] = {
					{
						["trigger"] = {
							["duration"] = "1",
							["genericShowOn"] = "showAlways",
							["subeventPrefix"] = "SPELL",
							["debuffType"] = "HELPFUL",
							["type"] = "status",
							["subeventSuffix"] = "_CAST_START",
							["spellName"] = 355,
							["event"] = "Cooldown Progress (Spell)",
							["use_unit"] = true,
							["realSpellName"] = "Taunt",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["names"] = {
							},
							["unevent"] = "auto",
							["use_genericShowOn"] = true,
							["use_track"] = true,
							["unit"] = "player",
						},
						["untrigger"] = {
							["genericShowOn"] = "showAlways",
						},
					}, -- [1]
					{
						["trigger"] = {
							["useName"] = true,
							["auranames"] = {
								"Taunt", -- [1]
							},
							["matchesShowOn"] = "showAlways",
							["event"] = "Health",
							["unit"] = "target",
							["ownOnly"] = true,
							["spellIds"] = {
							},
							["type"] = "aura2",
							["subeventPrefix"] = "SPELL",
							["names"] = {
							},
							["subeventSuffix"] = "_CAST_START",
							["debuffType"] = "HARMFUL",
						},
						["untrigger"] = {
						},
					}, -- [2]
					{
						["trigger"] = {
							["subeventSuffix"] = "_CAST_START",
							["type"] = "status",
							["use_showCost"] = false,
							["unevent"] = "auto",
							["subeventPrefix"] = "SPELL",
							["duration"] = "1",
							["use_requirePowerType"] = false,
							["use_unit"] = true,
							["names"] = {
							},
							["powertype"] = 1,
							["spellIds"] = {
							},
							["use_power"] = false,
							["event"] = "Power",
							["unit"] = "player",
							["use_powertype"] = true,
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [3]
					{
						["trigger"] = {
							["use_form"] = true,
							["subeventSuffix"] = "_CAST_START",
							["duration"] = "1",
							["event"] = "Stance/Form/Aura",
							["unit"] = "player",
							["use_unit"] = true,
							["subeventPrefix"] = "SPELL",
							["spellIds"] = {
							},
							["names"] = {
							},
							["form"] = {
								["single"] = 2,
							},
							["type"] = "status",
							["unevent"] = "auto",
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [4]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "AND",
							["checks"] = {
								{
									["trigger"] = 4,
									["op"] = "==",
									["variable"] = "form",
									["value"] = 2,
								}, -- [1]
								{
									["trigger"] = 1,
									["variable"] = "onCooldown",
									["value"] = 1,
								}, -- [2]
							},
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
							{
								["property"] = "desaturate",
							}, -- [2]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "spellInRange",
							["value"] = 1,
						},
						["changes"] = {
							{
								["property"] = "desaturate",
							}, -- [1]
						},
					}, -- [2]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		[")RtUgV2fO6p"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567202218,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["authorOptions"] = {
					{
						["type"] = "toggle",
						["default"] = false,
						["width"] = 1,
						["name"] = "2+ Cold Steel, Hot Blood",
						["useDesc"] = true,
						["key"] = "cshb",
						["desc"] = "By toggling this option you will change the rotation to priotorize Bloodthirst over Raging Blow.",
					}, -- [1]
				},
				["customText"] = "function()\n    return select(3, WA_GetUnitBuff(\"player\", 7384))\nend",
				["yOffset"] = 0,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["customTextUpdate"] = "update",
				["cooldownEdge"] = false,
				["icon"] = true,
				["triggers"] = {
					{
						["trigger"] = {
							["track"] = "auto",
							["use_genericShowOn"] = true,
							["genericShowOn"] = "showAlways",
							["use_unit"] = true,
							["use_showgcd"] = true,
							["powertype"] = 1,
							["use_powertype"] = true,
							["debuffType"] = "HELPFUL",
							["type"] = "status",
							["names"] = {
							},
							["subeventSuffix"] = "_CAST_START",
							["use_showOn"] = true,
							["subeventPrefix"] = "SPELL",
							["event"] = "Cooldown Progress (Spell)",
							["unevent"] = "auto",
							["realSpellName"] = "Raging Blow",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["spellName"] = 85288,
							["duration"] = "1",
							["use_absorbMode"] = true,
							["use_track"] = true,
							["unit"] = "player",
						},
						["untrigger"] = {
							["showOn"] = "showAlways",
							["spellName"] = 85288,
						},
					}, -- [1]
					{
						["trigger"] = {
							["track"] = "auto",
							["use_absorbMode"] = true,
							["genericShowOn"] = "showAlways",
							["subeventPrefix"] = "SPELL",
							["spellName"] = 23881,
							["type"] = "status",
							["subeventSuffix"] = "_CAST_START",
							["use_showOn"] = true,
							["event"] = "Cooldown Progress (Spell)",
							["realSpellName"] = "Bloodthirst",
							["use_spellName"] = true,
							["use_unit"] = true,
							["unevent"] = "auto",
							["unit"] = "player",
							["duration"] = "1",
							["use_track"] = true,
							["use_genericShowOn"] = true,
						},
						["untrigger"] = {
							["genericShowOn"] = "showAlways",
							["spellName"] = 23881,
						},
					}, -- [2]
					{
						["trigger"] = {
							["buffShowOn"] = "showAlways",
							["useName"] = true,
							["use_debuffClass"] = false,
							["auranames"] = {
								"184362", -- [1]
							},
							["type"] = "aura2",
							["matchesShowOn"] = "showAlways",
							["event"] = "Health",
							["unit"] = "player",
							["subeventSuffix"] = "_CAST_START",
							["use_tooltip"] = false,
							["spellIds"] = {
								184362, -- [1]
							},
							["names"] = {
								"Enrage", -- [1]
							},
							["subeventPrefix"] = "SPELL",
							["combineMatches"] = "showLowest",
							["useGroup_count"] = false,
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [3]
					{
						["trigger"] = {
							["type"] = "status",
							["talent"] = {
								["single"] = 13,
							},
							["use_absorbMode"] = true,
							["event"] = "Talent Known",
							["unit"] = "player",
							["subeventPrefix"] = "SPELL",
							["use_unit"] = true,
							["subeventSuffix"] = "_CAST_START",
							["unevent"] = "auto",
							["use_talent"] = true,
							["duration"] = "1",
						},
						["untrigger"] = {
						},
					}, -- [4]
					{
						["trigger"] = {
							["type"] = "status",
							["subeventPrefix"] = "SPELL",
							["unevent"] = "auto",
							["unit"] = "player",
							["duration"] = "1",
							["genericShowOn"] = "showAlways",
							["use_unit"] = true,
							["realSpellName"] = "Rampage",
							["use_spellName"] = true,
							["subeventSuffix"] = "_CAST_START",
							["event"] = "Cooldown Progress (Spell)",
							["use_absorbMode"] = true,
							["use_genericShowOn"] = true,
							["use_track"] = true,
							["spellName"] = 184367,
						},
						["untrigger"] = {
							["genericShowOn"] = "showAlways",
						},
					}, -- [5]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["use_absorbMode"] = true,
							["event"] = "Power",
							["unit"] = "player",
							["powertype"] = 1,
							["subeventPrefix"] = "SPELL",
							["use_unit"] = true,
							["subeventSuffix"] = "_CAST_START",
							["use_powertype"] = true,
							["duration"] = "1",
						},
						["untrigger"] = {
						},
					}, -- [6]
					{
						["trigger"] = {
							["debuffType"] = "HELPFUL",
							["type"] = "aura2",
							["useName"] = true,
							["auranames"] = {
								"184362", -- [1]
							},
							["subeventSuffix"] = "_CAST_START",
							["subeventPrefix"] = "SPELL",
							["event"] = "Health",
							["unit"] = "player",
						},
						["untrigger"] = {
						},
					}, -- [7]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["duration"] = "1",
							["event"] = "Action Usable",
							["unit"] = "player",
							["realSpellName"] = 5308,
							["use_spellName"] = true,
							["subeventPrefix"] = "SPELL",
							["use_exact_spellName"] = true,
							["subeventSuffix"] = "_CAST_START",
							["use_unit"] = true,
							["use_absorbMode"] = true,
							["spellName"] = 5308,
						},
						["untrigger"] = {
						},
					}, -- [8]
					{
						["trigger"] = {
							["type"] = "custom",
							["unevent"] = "auto",
							["duration"] = "1",
							["event"] = "Health",
							["unit"] = "player",
							["use_unit"] = true,
							["use_absorbMode"] = true,
							["custom"] = "function()\n    return aura_env.config[\"cshb\"] == true\nend",
							["custom_type"] = "status",
							["check"] = "event",
							["events"] = "LUXTHOS_EVENT",
							["subeventSuffix"] = "_CAST_START",
							["subeventPrefix"] = "SPELL",
						},
						["untrigger"] = {
						},
					}, -- [9]
					["disjunctive"] = "any",
					["customTriggerLogic"] = "function(t)\n    if t[2] and t[3] and t[5] and t[6] then\n        aura_env.region:SetGlow(true)\n    elseif t[3] and t[4] and t[6] then\n        aura_env.region:SetGlow(true)\n    else \n        aura_env.region:SetGlow(false)\n    end\n    return t[1]\nend",
					["activeTriggerMode"] = -10,
				},
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["selfPoint"] = "CENTER",
				["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
				["progressPrecision"] = 0,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 32,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["text_fontSize"] = 13,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 55,
				["url"] = "https://wago.io/SkBHabbrQ/32",
				["load"] = {
					["use_petbattle"] = false,
					["use_never"] = false,
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["use_class"] = true,
					["role"] = {
						["multi"] = {
						},
					},
					["use_spec"] = true,
					["size"] = {
						["multi"] = {
						},
					},
					["talent2"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 3,
						["multi"] = {
							[9] = true,
							[8] = true,
						},
					},
					["spec"] = {
						["single"] = 2,
						["multi"] = {
							true, -- [1]
							true, -- [2]
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["use_vehicleUi"] = false,
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["use_combat"] = true,
					["race"] = {
						["multi"] = {
						},
					},
					["ingroup"] = {
						["multi"] = {
						},
					},
				},
				["displayIcon"] = 589119,
				["glowFrequency"] = 0.25,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["stickyDuration"] = false,
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 4,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["uid"] = ")RtUgV2fO6p",
				["glowLines"] = 8,
				["regionType"] = "icon",
				["glowYOffset"] = 0,
				["alpha"] = 1,
				["anchorFrameType"] = "SCREEN",
				["parent"] = "Luxthos - Warrior Rotations",
				["glowLength"] = 10,
				["auto"] = true,
				["cooldownTextDisabled"] = false,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["zoom"] = 0.33,
				["semver"] = "1.1.2",
				["glowScale"] = 1,
				["id"] = "Raging Blow",
				["useglowColor"] = false,
				["frameStrata"] = 1,
				["width"] = 55,
				["desaturate"] = false,
				["config"] = {
					["cshb"] = true,
				},
				["inverse"] = true,
				["keepAspectRatio"] = true,
				["xOffset"] = -58,
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["op"] = "==",
							["value"] = "0",
							["variable"] = "charges",
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [1]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "AND",
							["checks"] = {
								{
									["op"] = ">=",
									["checks"] = {
										{
											["trigger"] = 9,
											["variable"] = "show",
											["value"] = 1,
										}, -- [1]
										{
											["trigger"] = 1,
											["variable"] = "onCooldown",
											["value"] = 1,
										}, -- [2]
										{
											["trigger"] = 2,
											["op"] = ">=",
											["value"] = "1",
											["variable"] = "charges",
										}, -- [3]
									},
									["trigger"] = 2,
									["variable"] = "onCooldown",
									["value"] = 1,
								}, -- [1]
								{
									["op"] = ">=",
									["checks"] = {
										{
											["trigger"] = 9,
											["variable"] = "show",
											["value"] = 0,
										}, -- [1]
									},
									["trigger"] = 1,
									["variable"] = "charges",
									["value"] = "1",
								}, -- [2]
							},
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
						},
					}, -- [2]
					{
						["check"] = {
							["trigger"] = -2,
							["op"] = "==",
							["variable"] = "OR",
							["checks"] = {
								{
									["trigger"] = -2,
									["op"] = "==",
									["variable"] = "AND",
									["checks"] = {
										{
											["trigger"] = 9,
											["variable"] = "show",
											["value"] = 1,
										}, -- [1]
										{
											["trigger"] = 2,
											["variable"] = "onCooldown",
											["value"] = 1,
										}, -- [2]
										{
											["trigger"] = 1,
											["op"] = ">=",
											["value"] = "1",
											["variable"] = "charges",
										}, -- [3]
									},
								}, -- [1]
								{
									["trigger"] = -2,
									["variable"] = "AND",
									["checks"] = {
										{
											["trigger"] = 9,
											["variable"] = "show",
											["value"] = 0,
										}, -- [1]
										{
											["trigger"] = 1,
											["op"] = "==",
											["value"] = "2",
											["variable"] = "charges",
										}, -- [2]
										{
											["trigger"] = 3,
											["variable"] = "buffed",
											["value"] = 1,
										}, -- [3]
									},
								}, -- [2]
							},
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
						},
					}, -- [3]
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "AND",
							["checks"] = {
								{
									["trigger"] = 4,
									["variable"] = "show",
									["value"] = 0,
								}, -- [1]
								{
									["trigger"] = 5,
									["variable"] = "insufficientResources",
									["value"] = 0,
								}, -- [2]
							},
						},
						["changes"] = {
							{
								["property"] = "glow",
							}, -- [1]
						},
					}, -- [4]
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "AND",
							["checks"] = {
								{
									["trigger"] = 4,
									["variable"] = "show",
									["value"] = 1,
								}, -- [1]
								{
									["trigger"] = -2,
									["variable"] = "OR",
									["checks"] = {
										{
											["trigger"] = -2,
											["variable"] = "AND",
											["checks"] = {
												{
													["trigger"] = 7,
													["variable"] = "show",
													["value"] = 0,
												}, -- [1]
												{
													["trigger"] = 5,
													["variable"] = "insufficientResources",
													["value"] = 0,
												}, -- [2]
											},
										}, -- [1]
										{
											["trigger"] = 6,
											["op"] = ">=",
											["value"] = "90",
											["variable"] = "power",
										}, -- [2]
									},
								}, -- [2]
							},
						},
						["changes"] = {
							{
								["property"] = "glow",
							}, -- [1]
						},
					}, -- [5]
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "AND",
							["checks"] = {
								{
									["trigger"] = 8,
									["variable"] = "show",
									["value"] = 1,
								}, -- [1]
								{
									["trigger"] = 7,
									["variable"] = "show",
									["value"] = 1,
								}, -- [2]
							},
						},
						["changes"] = {
							{
								["property"] = "glow",
							}, -- [1]
						},
					}, -- [6]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["dte(INTr8ED"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567277425,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["yOffset"] = -89.000061035156,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = false,
				["url"] = "https://wago.io/Eh5J56-nY/1",
				["actions"] = {
					["start"] = {
					},
					["init"] = {
					},
					["finish"] = {
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["keepAspectRatio"] = false,
				["selfPoint"] = "CENTER",
				["desaturate"] = true,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 1,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["rotateText"] = "NONE",
						["text_fontSize"] = 12,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 40,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["glowXOffset"] = 0,
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["authorOptions"] = {
				},
				["cooldownEdge"] = false,
				["load"] = {
					["use_class"] = true,
					["use_spellknown"] = true,
					["talent"] = {
						["multi"] = {
							[21] = true,
							[19] = true,
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["spec"] = {
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["regionType"] = "icon",
				["config"] = {
				},
				["zoom"] = 0,
				["anchorFrameType"] = "SCREEN",
				["alpha"] = 1,
				["xOffset"] = 4,
				["width"] = 40,
				["glowScale"] = 1,
				["auto"] = true,
				["cooldownTextDisabled"] = false,
				["useGlowColor"] = false,
				["tocversion"] = 11302,
				["id"] = "Revenge",
				["glowLength"] = 10,
				["frameStrata"] = 1,
				["glowYOffset"] = 0,
				["parent"] = "Arms",
				["uid"] = "dte(INTr8ED",
				["inverse"] = false,
				["icon"] = true,
				["triggers"] = {
					{
						["trigger"] = {
							["use_form"] = true,
							["matchesShowOn"] = "showAlways",
							["genericShowOn"] = "showAlways",
							["use_unit"] = true,
							["debuffType"] = "HELPFUL",
							["type"] = "status",
							["subeventPrefix"] = "SPELL",
							["unevent"] = "auto",
							["duration"] = "1",
							["form"] = {
								["single"] = 1,
							},
							["event"] = "Cooldown Progress (Spell)",
							["names"] = {
							},
							["realSpellName"] = "Revenge",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["use_genericShowOn"] = true,
							["spellName"] = 6572,
							["subeventSuffix"] = "_CAST_START",
							["use_track"] = true,
							["unit"] = "player",
						},
						["untrigger"] = {
						},
					}, -- [1]
					{
						["trigger"] = {
							["type"] = "aura2",
							["auranames"] = {
								"Revenge", -- [1]
							},
							["ownOnly"] = true,
							["event"] = "Health",
							["unit"] = "player",
							["useName"] = true,
							["spellIds"] = {
							},
							["subeventPrefix"] = "SPELL",
							["matchesShowOn"] = "showAlways",
							["names"] = {
							},
							["subeventSuffix"] = "_CAST_START",
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [2]
					{
						["trigger"] = {
							["use_form"] = true,
							["subeventSuffix"] = "_CAST_START",
							["duration"] = "1",
							["event"] = "Stance/Form/Aura",
							["unit"] = "player",
							["realSpellName"] = 0,
							["use_spellName"] = true,
							["unevent"] = "auto",
							["form"] = {
								["single"] = 2,
							},
							["type"] = "status",
							["subeventPrefix"] = "SPELL",
							["use_unit"] = true,
							["spellName"] = 0,
						},
						["untrigger"] = {
						},
					}, -- [3]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["duration"] = "1",
							["event"] = "Power",
							["use_unit"] = true,
							["powertype"] = 1,
							["subeventSuffix"] = "_CAST_START",
							["subeventPrefix"] = "SPELL",
							["use_powertype"] = true,
							["unit"] = "player",
						},
						["untrigger"] = {
						},
					}, -- [4]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 2,
							["op"] = "==",
							["variable"] = "buffed",
							["value"] = 0,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [1]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "AND",
							["checks"] = {
								{
									["trigger"] = 4,
									["op"] = ">=",
									["variable"] = "power",
									["value"] = "5",
								}, -- [1]
								{
									["trigger"] = 1,
									["variable"] = "spellUsable",
									["value"] = 1,
								}, -- [2]
							},
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
							{
								["value"] = false,
								["property"] = "desaturate",
							}, -- [2]
						},
					}, -- [2]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["F3NePd4Y8Wk"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201870,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["xOffset"] = -100,
				["yOffset"] = -25,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["cooldownEdge"] = false,
				["icon"] = true,
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 3,
				["subRegions"] = {
				},
				["height"] = 45,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
						["custom"] = "",
						["do_custom"] = false,
					},
				},
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["url"] = "https://wago.io/9EBTx7-J0/3",
				["authorOptions"] = {
				},
				["triggers"] = {
					{
						["trigger"] = {
							["useGroup_count"] = false,
							["matchesShowOn"] = "showOnActive",
							["unit"] = "player",
							["use_tooltip"] = false,
							["debuffType"] = "HELPFUL",
							["use_specific_unit"] = false,
							["type"] = "aura2",
							["stacksOperator"] = ">",
							["subeventSuffix"] = "_CAST_START",
							["buffShowOn"] = "showOnActive",
							["subeventPrefix"] = "SPELL",
							["event"] = "Health",
							["use_debuffClass"] = false,
							["useName"] = true,
							["name"] = "Spell Reflection",
							["spellIds"] = {
								248622, -- [1]
							},
							["ownOnly"] = true,
							["auranames"] = {
								"Last Stand", -- [1]
							},
							["combineMatches"] = "showLowest",
							["names"] = {
								"In For The Kill", -- [1]
							},
							["stacks"] = "0",
						},
						["untrigger"] = {
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["regionType"] = "icon",
				["selfPoint"] = "CENTER",
				["uid"] = "F3NePd4Y8Wk",
				["parent"] = "Warrior",
				["anchorFrameType"] = "SCREEN",
				["frameStrata"] = 1,
				["load"] = {
					["ingroup"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 46,
						["multi"] = {
							[16] = true,
						},
					},
					["talent2"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_talent"] = true,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["use_spec"] = true,
					["spec"] = {
						["single"] = 1,
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["auto"] = true,
				["glowScale"] = 1,
				["cooldownTextDisabled"] = false,
				["semver"] = "1.0.2",
				["tocversion"] = 11302,
				["id"] = "Last Stand - Buff",
				["zoom"] = 0,
				["alpha"] = 1,
				["glowYOffset"] = 0,
				["width"] = 45,
				["config"] = {
				},
				["inverse"] = false,
				["glowLength"] = 10,
				["keepAspectRatio"] = false,
				["conditions"] = {
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["Okt4bxlrNpr"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567277425,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["parent"] = "Arms",
				["yOffset"] = -55,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = false,
				["cooldownEdge"] = false,
				["actions"] = {
					["start"] = {
						["do_glow"] = true,
						["glow_type"] = "Pixel",
					},
					["init"] = {
					},
					["finish"] = {
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["desaturate"] = true,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 1,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["rotateText"] = "NONE",
						["text_fontSize"] = 12,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 25,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["keepAspectRatio"] = false,
				["glowType"] = "Pixel",
				["glowThickness"] = 1,
				["url"] = "https://wago.io/Eh5J56-nY/1",
				["authorOptions"] = {
				},
				["uid"] = "Okt4bxlrNpr",
				["regionType"] = "icon",
				["load"] = {
					["use_class"] = true,
					["spec"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["xOffset"] = -2,
				["glowYOffset"] = 0,
				["alpha"] = 1,
				["selfPoint"] = "CENTER",
				["cooldownTextDisabled"] = false,
				["glowScale"] = 1,
				["zoom"] = 0,
				["auto"] = true,
				["tocversion"] = 11302,
				["id"] = "Shield Bash 2",
				["icon"] = true,
				["frameStrata"] = 1,
				["anchorFrameType"] = "SCREEN",
				["width"] = 25,
				["config"] = {
				},
				["inverse"] = false,
				["glowLength"] = 10,
				["triggers"] = {
					{
						["trigger"] = {
							["duration"] = "1",
							["genericShowOn"] = "showAlways",
							["subeventPrefix"] = "SPELL",
							["debuffType"] = "HELPFUL",
							["type"] = "status",
							["subeventSuffix"] = "_CAST_START",
							["spellName"] = 72,
							["event"] = "Cooldown Progress (Spell)",
							["names"] = {
							},
							["realSpellName"] = "Shield Bash",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["use_unit"] = true,
							["unevent"] = "auto",
							["use_genericShowOn"] = true,
							["use_track"] = true,
							["unit"] = "player",
						},
						["untrigger"] = {
							["genericShowOn"] = "showAlways",
						},
					}, -- [1]
					{
						["trigger"] = {
							["type"] = "aura2",
							["auranames"] = {
								"Shield Bash", -- [1]
							},
							["ownOnly"] = true,
							["event"] = "Health",
							["unit"] = "target",
							["matchesShowOn"] = "showAlways",
							["spellIds"] = {
							},
							["names"] = {
							},
							["useName"] = true,
							["subeventSuffix"] = "_CAST_START",
							["subeventPrefix"] = "SPELL",
							["debuffType"] = "HARMFUL",
						},
						["untrigger"] = {
						},
					}, -- [2]
					{
						["trigger"] = {
							["unevent"] = "auto",
							["type"] = "status",
							["use_showCost"] = false,
							["subeventSuffix"] = "_CAST_START",
							["names"] = {
							},
							["duration"] = "1",
							["use_requirePowerType"] = false,
							["use_unit"] = true,
							["use_power"] = false,
							["powertype"] = 1,
							["spellIds"] = {
							},
							["event"] = "Power",
							["subeventPrefix"] = "SPELL",
							["unit"] = "player",
							["use_powertype"] = true,
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [3]
					{
						["trigger"] = {
							["use_form"] = true,
							["unevent"] = "auto",
							["form"] = {
								["single"] = 2,
							},
							["event"] = "Stance/Form/Aura",
							["unit"] = "player",
							["duration"] = "1",
							["subeventPrefix"] = "SPELL",
							["spellIds"] = {
							},
							["use_unit"] = true,
							["type"] = "status",
							["subeventSuffix"] = "_CAST_START",
							["names"] = {
							},
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [4]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "AND",
							["checks"] = {
								{
									["trigger"] = 4,
									["op"] = "==",
									["variable"] = "form",
									["value"] = 2,
								}, -- [1]
								{
									["trigger"] = 2,
									["op"] = "==",
									["variable"] = "stacks",
									["value"] = "1",
								}, -- [2]
							},
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
							{
								["property"] = "desaturate",
							}, -- [2]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = 3,
							["op"] = ">=",
							["value"] = "10",
							["variable"] = "power",
						},
						["changes"] = {
							{
								["property"] = "desaturate",
							}, -- [1]
						},
					}, -- [2]
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "onCooldown",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
							{
								["property"] = "desaturate",
							}, -- [2]
						},
					}, -- [3]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["wkuSdyhtfkp"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567202218,
			["allowUpdates"] = true,
			["data"] = {
				["backdropColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					0.5, -- [4]
				},
				["controlledChildren"] = {
				},
				["borderBackdrop"] = "Blizzard Tooltip",
				["xOffset"] = 0,
				["yOffset"] = -180,
				["border"] = false,
				["borderEdge"] = "None",
				["regionType"] = "group",
				["borderSize"] = 16,
				["scale"] = 1,
				["borderColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					0.5, -- [4]
				},
				["anchorPoint"] = "CENTER",
				["url"] = "https://wago.io/SkBHabbrQ/32",
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["triggers"] = {
					{
						["trigger"] = {
							["type"] = "aura",
							["subeventSuffix"] = "_CAST_START",
							["event"] = "Health",
							["unit"] = "player",
							["spellIds"] = {
							},
							["buffShowOn"] = "showOnActive",
							["subeventPrefix"] = "SPELL",
							["names"] = {
							},
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["internalVersion"] = 23,
				["borderOffset"] = 5,
				["semver"] = "1.1.2",
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["id"] = "Luxthos - Warrior Rotations",
				["borderInset"] = 11,
				["frameStrata"] = 1,
				["desc"] = "Patch 8.1 - Created by Luxthos\nhttps://www.twitch.tv/luxthos",
				["config"] = {
				},
				["uid"] = "wkuSdyhtfkp",
				["version"] = 32,
				["anchorFrameType"] = "SCREEN",
				["selfPoint"] = "BOTTOMLEFT",
				["conditions"] = {
				},
				["load"] = {
					["ingroup"] = {
						["multi"] = {
						},
					},
					["affixes"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["multi"] = {
						},
					},
					["spec"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["use_class"] = "true",
					["race"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["talent2"] = {
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["authorOptions"] = {
				},
			},
		},
		["lGH9HJdb9nH"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567202218,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["authorOptions"] = {
				},
				["customText"] = "function()\n    return select(3, WA_GetUnitBuff(\"player\", 7384))\nend",
				["yOffset"] = 0,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["customTextUpdate"] = "update",
				["cooldownEdge"] = false,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["selfPoint"] = "CENTER",
				["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
				["progressPrecision"] = 0,
				["glowLength"] = 10,
				["version"] = 32,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = " ",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["text_fontSize"] = 13,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 55,
				["url"] = "https://wago.io/SkBHabbrQ/32",
				["load"] = {
					["use_petbattle"] = false,
					["use_never"] = false,
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["use_class"] = true,
					["role"] = {
						["multi"] = {
						},
					},
					["use_spec"] = true,
					["size"] = {
						["multi"] = {
						},
					},
					["talent2"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 3,
						["multi"] = {
							[9] = true,
							[8] = true,
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							true, -- [1]
							true, -- [2]
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["use_vehicleUi"] = false,
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["use_combat"] = true,
					["race"] = {
						["multi"] = {
						},
					},
					["ingroup"] = {
						["multi"] = {
						},
					},
				},
				["displayIcon"] = 136012,
				["glowFrequency"] = 0.25,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["stickyDuration"] = false,
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 4,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["uid"] = "lGH9HJdb9nH",
				["glowLines"] = 8,
				["regionType"] = "icon",
				["glowYOffset"] = 0,
				["alpha"] = 1,
				["anchorFrameType"] = "SCREEN",
				["parent"] = "Luxthos - Warrior Rotations",
				["xOffset"] = -116,
				["auto"] = true,
				["cooldownTextDisabled"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["zoom"] = 0.33,
				["semver"] = "1.1.2",
				["glowScale"] = 1,
				["id"] = "Shield Slam",
				["icon"] = true,
				["frameStrata"] = 3,
				["width"] = 55,
				["triggers"] = {
					{
						["trigger"] = {
							["track"] = "auto",
							["use_absorbMode"] = true,
							["genericShowOn"] = "showAlways",
							["use_unit"] = true,
							["use_showgcd"] = true,
							["powertype"] = 1,
							["use_powertype"] = true,
							["debuffType"] = "HELPFUL",
							["type"] = "status",
							["subeventPrefix"] = "SPELL",
							["subeventSuffix"] = "_CAST_START",
							["use_showOn"] = true,
							["unit"] = "player",
							["event"] = "Cooldown Progress (Spell)",
							["unevent"] = "auto",
							["realSpellName"] = "Shield Slam",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["duration"] = "1",
							["use_genericShowOn"] = true,
							["spellName"] = 23922,
							["use_track"] = true,
							["names"] = {
							},
						},
						["untrigger"] = {
							["showOn"] = "showAlways",
							["spellName"] = 23922,
						},
					}, -- [1]
					["disjunctive"] = "any",
					["customTriggerLogic"] = "function(t)\n    if t[2] and t[3] and t[5] then\n        aura_env.region:SetGlow(true)\n    elseif t[2] and t[4] and t[5] then\n        aura_env.region:SetGlow(true)\n    else \n        aura_env.region:SetGlow(false)\n    end\n    return t[1]\nend",
					["activeTriggerMode"] = -10,
				},
				["config"] = {
				},
				["inverse"] = true,
				["desaturate"] = false,
				["keepAspectRatio"] = true,
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "onCooldown",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [1]
							{
								["value"] = true,
								["property"] = "cooldownEdge",
							}, -- [2]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "onCooldown",
							["value"] = 0,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
						},
					}, -- [2]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["Jw0wPIpkBVZ"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567277424,
			["allowUpdates"] = true,
			["data"] = {
				["backdropColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					0.5, -- [4]
				},
				["controlledChildren"] = {
				},
				["borderBackdrop"] = "Blizzard Tooltip",
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["scale"] = 0.95,
				["borderInset"] = 1,
				["border"] = false,
				["yOffset"] = -139.3182427141,
				["anchorPoint"] = "CENTER",
				["borderSize"] = 2,
				["borderEdge"] = "1 Pixel",
				["borderColor"] = {
					0, -- [1]
					0, -- [2]
					0, -- [3]
					1, -- [4]
				},
				["groupIcon"] = 132355,
				["url"] = "https://wago.io/Eh5J56-nY/1",
				["actions"] = {
					["start"] = {
					},
					["init"] = {
					},
					["finish"] = {
					},
				},
				["triggers"] = {
					{
						["trigger"] = {
							["unit"] = "player",
							["type"] = "aura2",
							["spellIds"] = {
							},
							["subeventSuffix"] = "_CAST_START",
							["names"] = {
							},
							["subeventPrefix"] = "SPELL",
							["event"] = "Health",
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [1]
				},
				["xOffset"] = 0,
				["internalVersion"] = 23,
				["config"] = {
				},
				["selfPoint"] = "BOTTOMLEFT",
				["id"] = "Arms",
				["borderOffset"] = 4,
				["frameStrata"] = 1,
				["anchorFrameType"] = "SCREEN",
				["tocversion"] = 11302,
				["uid"] = "Jw0wPIpkBVZ",
				["version"] = 1,
				["subRegions"] = {
				},
				["regionType"] = "group",
				["conditions"] = {
				},
				["load"] = {
					["class"] = {
						["multi"] = {
						},
					},
					["spec"] = {
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["authorOptions"] = {
				},
			},
		},
		["12R66zDk06K"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201870,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["glowLength"] = 10,
				["yOffset"] = -162,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["url"] = "https://wago.io/9EBTx7-J0/3",
				["icon"] = true,
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 3,
				["subRegions"] = {
				},
				["height"] = 45,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["selfPoint"] = "CENTER",
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["cooldownEdge"] = false,
				["triggers"] = {
					{
						["trigger"] = {
							["duration"] = "1",
							["genericShowOn"] = "showAlways",
							["use_unit"] = true,
							["debuffType"] = "HELPFUL",
							["unit"] = "player",
							["type"] = "status",
							["use_genericShowOn"] = true,
							["unevent"] = "auto",
							["use_showOn"] = true,
							["subeventSuffix"] = "_CAST_START",
							["event"] = "Cooldown Progress (Spell)",
							["spellName"] = 12809,
							["realSpellName"] = "Concussion Blow",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["subeventPrefix"] = "SPELL",
							["use_absorbMode"] = true,
							["names"] = {
							},
							["use_track"] = true,
							["use_charges"] = false,
						},
						["untrigger"] = {
							["showOn"] = "showAlways",
							["spellName"] = 260708,
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["regionType"] = "icon",
				["parent"] = "Warrior",
				["config"] = {
				},
				["glowYOffset"] = 0,
				["anchorFrameType"] = "SCREEN",
				["frameStrata"] = 1,
				["xOffset"] = 100,
				["auto"] = true,
				["tocversion"] = 11302,
				["zoom"] = 0,
				["semver"] = "1.0.2",
				["glowScale"] = 1,
				["id"] = "Concussion Blow",
				["cooldownTextDisabled"] = false,
				["alpha"] = 1,
				["width"] = 45,
				["authorOptions"] = {
				},
				["uid"] = "12R66zDk06K",
				["inverse"] = true,
				["keepAspectRatio"] = false,
				["load"] = {
					["ingroup"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 54,
						["multi"] = {
						},
					},
					["talent2"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_talent"] = true,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["use_spec"] = true,
					["spec"] = {
						["single"] = 1,
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "onCooldown",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = {
									0.43921568627451, -- [1]
									0.43921568627451, -- [2]
									0.43921568627451, -- [3]
									1, -- [4]
								},
								["property"] = "color",
							}, -- [1]
						},
					}, -- [1]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["xNGo5SEVbG3"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567200331,
			["allowUpdates"] = true,
			["data"] = {
				["grow"] = "HORIZONTAL",
				["controlledChildren"] = {
				},
				["borderBackdrop"] = "Blizzard Tooltip",
				["xOffset"] = 0,
				["groupIcon"] = 136207,
				["anchorPoint"] = "TOP",
				["borderColor"] = {
					0, -- [1]
					0, -- [2]
					0, -- [3]
					1, -- [4]
				},
				["space"] = 2,
				["url"] = "https://wago.io/s8EGafICm/1",
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["triggers"] = {
					{
						["trigger"] = {
							["debuffType"] = "HELPFUL",
							["type"] = "aura2",
							["spellIds"] = {
							},
							["subeventSuffix"] = "_CAST_START",
							["subeventPrefix"] = "SPELL",
							["names"] = {
							},
							["event"] = "Health",
							["unit"] = "player",
						},
						["untrigger"] = {
						},
					}, -- [1]
				},
				["columnSpace"] = 1,
				["internalVersion"] = 23,
				["selfPoint"] = "BOTTOM",
				["align"] = "CENTER",
				["rotation"] = 0,
				["version"] = 1,
				["subRegions"] = {
				},
				["load"] = {
					["use_class"] = false,
					["spec"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["backdropColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					0.5, -- [4]
				},
				["useAnchorPerUnit"] = true,
				["animate"] = false,
				["authorOptions"] = {
				},
				["scale"] = 1,
				["sort"] = "none",
				["border"] = false,
				["borderEdge"] = "1 Pixel",
				["regionType"] = "dynamicgroup",
				["borderSize"] = 2,
				["limit"] = 5,
				["anchorPerUnit"] = "NAMEPLATE",
				["rowSpace"] = 1,
				["borderInset"] = 1,
				["config"] = {
				},
				["constantFactor"] = "RADIUS",
				["radius"] = 200,
				["borderOffset"] = 4,
				["semver"] = "1.0.1",
				["tocversion"] = 11302,
				["id"] = "Nameplate Debuffs",
				["gridWidth"] = 5,
				["frameStrata"] = 1,
				["anchorFrameType"] = "SCREEN",
				["stagger"] = 0,
				["uid"] = "xNGo5SEVbG3",
				["arcLength"] = 360,
				["gridType"] = "RD",
				["yOffset"] = 0,
				["conditions"] = {
				},
				["useLimit"] = false,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
			},
		},
		["5S3A2xvRYaD"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201685,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["parent"] = "ChUI - Debuff Tracker - Warrior",
				["yOffset"] = 0,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["url"] = "https://wago.io/Okky1Eh5g/1",
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["triggers"] = {
					{
						["trigger"] = {
							["type"] = "aura2",
							["auranames"] = {
								"Rend", -- [1]
							},
							["matchesShowOn"] = "showOnMissing",
							["event"] = "Health",
							["unit"] = "target",
							["names"] = {
							},
							["spellIds"] = {
							},
							["subeventSuffix"] = "_CAST_START",
							["subeventPrefix"] = "SPELL",
							["ownOnly"] = true,
							["useName"] = true,
							["debuffType"] = "HARMFUL",
						},
						["untrigger"] = {
						},
					}, -- [1]
					["activeTriggerMode"] = -10,
				},
				["internalVersion"] = 23,
				["keepAspectRatio"] = false,
				["selfPoint"] = "CENTER",
				["desaturate"] = true,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 1,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = false,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["text_fontType"] = "OUTLINE",
						["rotateText"] = "NONE",
						["anchorXOffset"] = 0,
						["text_fontSize"] = 12,
					}, -- [1]
				},
				["height"] = 50,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["animation"] = {
					["start"] = {
						["type"] = "preset",
						["preset"] = "slidebottom",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["type"] = "preset",
						["preset"] = "slidetop",
						["duration_type"] = "seconds",
					},
				},
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["glowXOffset"] = 0,
				["useglowColor"] = false,
				["authorOptions"] = {
				},
				["regionType"] = "icon",
				["cooldownEdge"] = false,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					0.48225158452988, -- [4]
				},
				["config"] = {
				},
				["anchorFrameType"] = "SCREEN",
				["width"] = 50,
				["frameStrata"] = 1,
				["icon"] = true,
				["tocversion"] = 11302,
				["zoom"] = 0,
				["auto"] = true,
				["glowScale"] = 1,
				["id"] = "Warrior: Rend DOWN",
				["cooldownTextDisabled"] = false,
				["alpha"] = 1,
				["glowYOffset"] = 0,
				["xOffset"] = 0,
				["uid"] = "5S3A2xvRYaD",
				["inverse"] = false,
				["load"] = {
					["use_class"] = true,
					["use_never"] = true,
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["use_combat"] = true,
					["spec"] = {
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["glowLength"] = 10,
				["conditions"] = {
				},
				["cooldown"] = false,
				["glowBorder"] = false,
			},
		},
		["tv)qQTOaTmo"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567202218,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["xOffset"] = -116,
				["customText"] = "function()\n    return select(3, WA_GetUnitBuff(\"player\", 7384))\nend",
				["yOffset"] = 0,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["customTextUpdate"] = "update",
				["cooldownEdge"] = false,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["selfPoint"] = "CENTER",
				["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
				["progressPrecision"] = 0,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 32,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%c",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["text_fontSize"] = 13,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 55,
				["url"] = "https://wago.io/SkBHabbrQ/32",
				["load"] = {
					["use_petbattle"] = false,
					["use_never"] = false,
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["use_class"] = true,
					["role"] = {
						["multi"] = {
						},
					},
					["use_spec"] = true,
					["size"] = {
						["multi"] = {
						},
					},
					["talent2"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 9,
						["multi"] = {
							[9] = true,
						},
					},
					["spec"] = {
						["single"] = 1,
						["multi"] = {
							true, -- [1]
							true, -- [2]
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_vehicleUi"] = false,
					["use_combat"] = true,
					["race"] = {
						["multi"] = {
						},
					},
					["ingroup"] = {
						["multi"] = {
						},
					},
				},
				["displayIcon"] = 132355,
				["glowFrequency"] = 0.25,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["stickyDuration"] = false,
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 4,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["uid"] = "tv)qQTOaTmo",
				["glowLines"] = 8,
				["regionType"] = "icon",
				["glowYOffset"] = 0,
				["alpha"] = 1,
				["anchorFrameType"] = "SCREEN",
				["icon"] = true,
				["glowLength"] = 10,
				["auto"] = false,
				["cooldownTextDisabled"] = false,
				["desaturate"] = false,
				["zoom"] = 0.33,
				["semver"] = "1.1.2",
				["glowScale"] = 1,
				["id"] = "Mortal Strike",
				["triggers"] = {
					{
						["trigger"] = {
							["use_genericShowOn"] = true,
							["genericShowOn"] = "showAlways",
							["use_unit"] = true,
							["use_showgcd"] = true,
							["use_specific_unit"] = false,
							["debuffType"] = "HARMFUL",
							["subeventPrefix"] = "SPELL",
							["type"] = "status",
							["names"] = {
								"Colossus Smash", -- [1]
							},
							["unevent"] = "auto",
							["unit"] = "target",
							["ownOnly"] = true,
							["event"] = "Cooldown Progress (Spell)",
							["subeventSuffix"] = "_CAST_START",
							["realSpellName"] = "Mortal Strike",
							["use_spellName"] = true,
							["spellIds"] = {
								208086, -- [1]
							},
							["spellName"] = 12294,
							["buffShowOn"] = "showOnActive",
							["use_absorbMode"] = true,
							["use_track"] = true,
							["duration"] = "1",
						},
						["untrigger"] = {
							["genericShowOn"] = "showAlways",
						},
					}, -- [1]
					{
						["trigger"] = {
							["type"] = "status",
							["talent"] = {
								["single"] = 7,
							},
							["duration"] = "1",
							["event"] = "Talent Known",
							["use_talent"] = true,
							["unit"] = "player",
							["use_absorbMode"] = true,
							["subeventSuffix"] = "_CAST_START",
							["use_unit"] = true,
							["subeventPrefix"] = "SPELL",
							["unevent"] = "auto",
						},
						["untrigger"] = {
						},
					}, -- [2]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["duration"] = "1",
							["event"] = "Health",
							["use_unit"] = true,
							["unit"] = "target",
							["subeventPrefix"] = "SPELL",
							["subeventSuffix"] = "_CAST_START",
							["use_absorbMode"] = true,
						},
						["untrigger"] = {
							["unit"] = "target",
						},
					}, -- [3]
					["disjunctive"] = "any",
					["customTriggerLogic"] = "",
					["activeTriggerMode"] = -10,
				},
				["frameStrata"] = 3,
				["width"] = 55,
				["parent"] = "Luxthos - Warrior Rotations",
				["config"] = {
				},
				["inverse"] = true,
				["keepAspectRatio"] = true,
				["authorOptions"] = {
				},
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "onCooldown",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [1]
							{
								["value"] = true,
								["property"] = "cooldownEdge",
							}, -- [2]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "insufficientResources",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = {
									0.31764705882353, -- [1]
									0.40392156862745, -- [2]
									0.78039215686274, -- [3]
									1, -- [4]
								},
								["property"] = "color",
							}, -- [1]
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [2]
						},
					}, -- [2]
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "AND",
							["checks"] = {
								{
									["trigger"] = 1,
									["variable"] = "onCooldown",
									["value"] = 0,
								}, -- [1]
								{
									["trigger"] = 2,
									["op"] = ">=",
									["value"] = 1,
									["variable"] = "show",
								}, -- [2]
								{
									["trigger"] = 3,
									["op"] = ">=",
									["value"] = "35",
									["variable"] = "percenthealth",
								}, -- [3]
							},
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
						},
					}, -- [3]
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "AND",
							["checks"] = {
								{
									["trigger"] = 1,
									["variable"] = "onCooldown",
									["value"] = 0,
								}, -- [1]
								{
									["trigger"] = 2,
									["variable"] = "show",
									["value"] = 0,
								}, -- [2]
								{
									["trigger"] = 3,
									["op"] = ">=",
									["value"] = "20",
									["variable"] = "percenthealth",
								}, -- [3]
							},
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
						},
					}, -- [4]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["dVcL)VamKKc"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567277425,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["yOffset"] = -89,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = false,
				["cooldownEdge"] = false,
				["icon"] = true,
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["selfPoint"] = "CENTER",
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 1,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["rotateText"] = "NONE",
						["text_fontSize"] = 12,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 40,
				["glowLines"] = 8,
				["animation"] = {
					["start"] = {
						["scaleFunc"] = "    function(progress, startX, startY, scaleX, scaleY)\n      local angle = (progress * 2 * math.pi) - (math.pi / 2)\n      return startX + (((math.sin(angle) + 1)/2) * (scaleX - 1)), startY + (((math.sin(angle) + 1)/2) * (scaleY - 1))\n    end\n  ",
						["use_scale"] = false,
						["alphaType"] = "alphaPulse",
						["colorB"] = 1,
						["colorG"] = 1,
						["alphaFunc"] = "    function(progress, start, delta)\n      local angle = (progress * 2 * math.pi) - (math.pi / 2)\n      return start + (((math.sin(angle) + 1)/2) * delta)\n    end\n  ",
						["use_alpha"] = false,
						["scaleType"] = "pulse",
						["colorA"] = 1,
						["scaley"] = 0,
						["alpha"] = 0,
						["duration"] = "1%",
						["y"] = 0,
						["x"] = 0,
						["colorR"] = 1,
						["type"] = "none",
						["duration_type"] = "seconds",
						["rotate"] = 0,
						["use_color"] = false,
						["scalex"] = 0,
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["glowFrequency"] = 0.25,
				["keepAspectRatio"] = false,
				["displayIcon"] = 132333,
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["glowLength"] = 10,
				["url"] = "https://wago.io/Eh5J56-nY/1",
				["config"] = {
				},
				["regionType"] = "icon",
				["xOffset"] = -80.000061035156,
				["glowYOffset"] = 0,
				["alpha"] = 1,
				["width"] = 40,
				["authorOptions"] = {
				},
				["tocversion"] = 11302,
				["useGlowColor"] = false,
				["cooldownTextDisabled"] = false,
				["zoom"] = 0,
				["auto"] = false,
				["glowScale"] = 1,
				["id"] = "Battle Shout",
				["actions"] = {
					["start"] = {
					},
					["init"] = {
					},
					["finish"] = {
					},
				},
				["frameStrata"] = 1,
				["anchorFrameType"] = "SCREEN",
				["parent"] = "Arms",
				["uid"] = "dVcL)VamKKc",
				["inverse"] = false,
				["load"] = {
					["use_class"] = true,
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["spec"] = {
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["triggers"] = {
					{
						["trigger"] = {
							["useName"] = true,
							["auranames"] = {
								"Battle Shout", -- [1]
							},
							["matchesShowOn"] = "showAlways",
							["event"] = "Health",
							["unit"] = "player",
							["spellIds"] = {
							},
							["names"] = {
							},
							["subeventPrefix"] = "SPELL",
							["subeventSuffix"] = "_CAST_START",
							["type"] = "aura2",
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [1]
					{
						["trigger"] = {
							["use_form"] = true,
							["matchesShowOn"] = "showAlways",
							["genericShowOn"] = "showAlways",
							["use_unit"] = true,
							["powertype"] = 1,
							["use_powertype"] = true,
							["debuffType"] = "HELPFUL",
							["subeventPrefix"] = "SPELL",
							["use_remaining"] = false,
							["unit"] = "player",
							["subeventSuffix"] = "_CAST_START",
							["use_genericShowOn"] = true,
							["use_inverse"] = true,
							["event"] = "Cooldown Progress (Spell)",
							["names"] = {
							},
							["realSpellName"] = "Battle Shout",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["type"] = "status",
							["duration"] = "1",
							["unevent"] = "auto",
							["use_track"] = true,
							["spellName"] = 5242,
						},
						["untrigger"] = {
							["genericShowOn"] = "showAlways",
						},
					}, -- [2]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["duration"] = "1",
							["event"] = "Power",
							["use_unit"] = true,
							["powertype"] = 1,
							["subeventSuffix"] = "_CAST_START",
							["subeventPrefix"] = "SPELL",
							["use_powertype"] = true,
							["unit"] = "player",
						},
						["untrigger"] = {
						},
					}, -- [3]
					["disjunctive"] = "any",
					["activeTriggerMode"] = -10,
				},
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["op"] = "<=",
							["variable"] = "buffed",
							["value"] = 0,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [1]
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [2]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = 3,
							["op"] = ">=",
							["variable"] = "power",
							["value"] = "15",
						},
						["changes"] = {
							{
								["value"] = false,
								["property"] = "desaturate",
							}, -- [1]
						},
					}, -- [2]
					{
						["check"] = {
							["trigger"] = 1,
							["op"] = ">=",
							["variable"] = "buffed",
							["value"] = 1,
						},
						["changes"] = {
							{
								["property"] = "desaturate",
							}, -- [1]
						},
					}, -- [3]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["ZYKJHSpb5aF"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567277425,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["parent"] = "Arms",
				["yOffset"] = -55,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = false,
				["url"] = "https://wago.io/Eh5J56-nY/1",
				["icon"] = true,
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["desaturate"] = true,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 1,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["rotateText"] = "NONE",
						["text_fontSize"] = 12,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 25,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["glowType"] = "Pixel",
				["glowThickness"] = 1,
				["triggers"] = {
					{
						["trigger"] = {
							["type"] = "aura2",
							["auranames"] = {
								"Hamstring", -- [1]
							},
							["ownOnly"] = true,
							["event"] = "Health",
							["unit"] = "target",
							["matchesShowOn"] = "showAlways",
							["spellIds"] = {
							},
							["names"] = {
							},
							["useName"] = true,
							["subeventSuffix"] = "_CAST_START",
							["subeventPrefix"] = "SPELL",
							["debuffType"] = "HARMFUL",
						},
						["untrigger"] = {
						},
					}, -- [1]
					{
						["trigger"] = {
							["duration"] = "1",
							["genericShowOn"] = "showAlways",
							["subeventPrefix"] = "SPELL",
							["debuffType"] = "HELPFUL",
							["type"] = "status",
							["subeventSuffix"] = "_CAST_START",
							["spellName"] = 1715,
							["event"] = "Cooldown Progress (Spell)",
							["names"] = {
							},
							["realSpellName"] = "Hamstring",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["use_unit"] = true,
							["unevent"] = "auto",
							["use_genericShowOn"] = true,
							["use_track"] = true,
							["unit"] = "player",
						},
						["untrigger"] = {
							["genericShowOn"] = "showAlways",
						},
					}, -- [2]
					{
						["trigger"] = {
							["unevent"] = "auto",
							["type"] = "status",
							["use_showCost"] = false,
							["subeventSuffix"] = "_CAST_START",
							["use_unit"] = true,
							["duration"] = "1",
							["use_requirePowerType"] = false,
							["subeventPrefix"] = "SPELL",
							["use_power"] = false,
							["powertype"] = 1,
							["spellIds"] = {
							},
							["event"] = "Power",
							["names"] = {
							},
							["unit"] = "player",
							["use_powertype"] = true,
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [3]
					{
						["trigger"] = {
							["use_form"] = true,
							["unevent"] = "auto",
							["form"] = {
								["single"] = 1,
							},
							["event"] = "Stance/Form/Aura",
							["unit"] = "player",
							["duration"] = "1",
							["subeventPrefix"] = "SPELL",
							["spellIds"] = {
							},
							["use_unit"] = true,
							["type"] = "status",
							["subeventSuffix"] = "_CAST_START",
							["names"] = {
							},
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [4]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["actions"] = {
					["start"] = {
						["do_glow"] = true,
						["glow_type"] = "Pixel",
					},
					["init"] = {
					},
					["finish"] = {
					},
				},
				["keepAspectRatio"] = false,
				["regionType"] = "icon",
				["cooldownEdge"] = false,
				["config"] = {
				},
				["selfPoint"] = "CENTER",
				["glowYOffset"] = 0,
				["alpha"] = 1,
				["width"] = 25,
				["cooldownTextDisabled"] = false,
				["glowScale"] = 1,
				["zoom"] = 0,
				["auto"] = true,
				["tocversion"] = 11302,
				["id"] = "Hamstring 2",
				["authorOptions"] = {
				},
				["frameStrata"] = 1,
				["anchorFrameType"] = "SCREEN",
				["glowLength"] = 10,
				["uid"] = "ZYKJHSpb5aF",
				["inverse"] = false,
				["load"] = {
					["use_class"] = true,
					["spec"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["xOffset"] = -29,
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "AND",
							["checks"] = {
								{
									["trigger"] = 4,
									["op"] = "==",
									["variable"] = "form",
									["value"] = 1,
								}, -- [1]
								{
									["trigger"] = 1,
									["variable"] = "buffed",
									["value"] = 1,
								}, -- [2]
							},
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
							{
								["property"] = "desaturate",
							}, -- [2]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = 3,
							["op"] = ">=",
							["variable"] = "power",
							["value"] = "10",
						},
						["changes"] = {
							{
								["value"] = false,
								["property"] = "desaturate",
							}, -- [1]
						},
					}, -- [2]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["EOl5a85L8iI"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201685,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["parent"] = "ChUI - Debuff Tracker - Warrior",
				["yOffset"] = 0,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["cooldownEdge"] = false,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["selfPoint"] = "CENTER",
				["desaturate"] = true,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 1,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = false,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["text_fontType"] = "OUTLINE",
						["rotateText"] = "NONE",
						["anchorXOffset"] = 0,
						["text_fontSize"] = 12,
					}, -- [1]
				},
				["height"] = 50,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["animation"] = {
					["start"] = {
						["type"] = "preset",
						["preset"] = "slidebottom",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["type"] = "preset",
						["preset"] = "slidetop",
						["duration_type"] = "seconds",
					},
				},
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["keepAspectRatio"] = false,
				["url"] = "https://wago.io/Okky1Eh5g/1",
				["triggers"] = {
					{
						["trigger"] = {
							["type"] = "aura2",
							["auranames"] = {
								"Thunder Clap", -- [1]
							},
							["matchesShowOn"] = "showOnMissing",
							["event"] = "Health",
							["names"] = {
							},
							["spellIds"] = {
							},
							["unit"] = "target",
							["useName"] = true,
							["subeventSuffix"] = "_CAST_START",
							["subeventPrefix"] = "SPELL",
							["debuffType"] = "HARMFUL",
						},
						["untrigger"] = {
						},
					}, -- [1]
					["activeTriggerMode"] = -10,
				},
				["regionType"] = "icon",
				["load"] = {
					["use_class"] = true,
					["use_never"] = true,
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["use_combat"] = true,
					["spec"] = {
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["authorOptions"] = {
				},
				["uid"] = "EOl5a85L8iI",
				["glowYOffset"] = 0,
				["anchorFrameType"] = "SCREEN",
				["frameStrata"] = 1,
				["icon"] = true,
				["tocversion"] = 11302,
				["cooldownTextDisabled"] = false,
				["auto"] = true,
				["glowScale"] = 1,
				["id"] = "Warrior: TC DOWN",
				["zoom"] = 0,
				["alpha"] = 1,
				["width"] = 50,
				["xOffset"] = 55,
				["config"] = {
				},
				["inverse"] = false,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					0.48225158452988, -- [4]
				},
				["glowLength"] = 10,
				["conditions"] = {
				},
				["cooldown"] = false,
				["glowBorder"] = false,
			},
		},
		["oa6qAn2uz7c"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201870,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["xOffset"] = 18.999877929688,
				["yOffset"] = -204.99975585938,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["cooldownEdge"] = false,
				["icon"] = true,
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["selfPoint"] = "CENTER",
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 3,
				["subRegions"] = {
				},
				["height"] = 35,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["glowLength"] = 10,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
						["custom"] = "aura_env.region.stacks:SetPoint(\"BOTTOMRIGHT\", aura_env.region, \"BOTTOMRIGHT\", 0, 0)\naura_env.region.stacks:SetShadowOffset(1, -1)",
						["do_custom"] = false,
					},
				},
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["url"] = "https://wago.io/9EBTx7-J0/3",
				["triggers"] = {
					{
						["trigger"] = {
							["use_genericShowOn"] = true,
							["genericShowOn"] = "showAlways",
							["subeventPrefix"] = "SPELL",
							["spellName"] = 20617,
							["type"] = "status",
							["debuffType"] = "HELPFUL",
							["subeventSuffix"] = "_CAST_START",
							["use_showOn"] = true,
							["unit"] = "player",
							["event"] = "Cooldown Progress (Spell)",
							["unevent"] = "auto",
							["realSpellName"] = "Intercept",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["use_unit"] = true,
							["use_absorbMode"] = true,
							["names"] = {
							},
							["use_track"] = true,
							["duration"] = "1",
						},
						["untrigger"] = {
							["showOn"] = "showAlways",
							["spellName"] = 100,
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["load"] = {
					["talent2"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["ingroup"] = {
						["multi"] = {
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["race"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_combat"] = true,
					["spec"] = {
						["single"] = 1,
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["regionType"] = "icon",
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["config"] = {
				},
				["glowYOffset"] = 0,
				["anchorFrameType"] = "SCREEN",
				["frameStrata"] = 1,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["auto"] = true,
				["glowScale"] = 1,
				["cooldownTextDisabled"] = false,
				["semver"] = "1.0.2",
				["tocversion"] = 11302,
				["id"] = "Intercept",
				["zoom"] = 0,
				["alpha"] = 1,
				["width"] = 35,
				["authorOptions"] = {
				},
				["uid"] = "oa6qAn2uz7c",
				["inverse"] = false,
				["parent"] = "Warrior",
				["keepAspectRatio"] = false,
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = -1,
							["op"] = "==",
							["value"] = 0,
							["variable"] = "incombat",
						},
						["changes"] = {
							{
								["value"] = {
									0.43921568627451, -- [1]
									0.43921568627451, -- [2]
									0.43921568627451, -- [3]
									1, -- [4]
								},
								["property"] = "color",
							}, -- [1]
							{
								["value"] = true,
								["property"] = "inverse",
							}, -- [2]
						},
					}, -- [1]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["rHlAoLGGCWz"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567277425,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["xOffset"] = 100.49991951386,
				["yOffset"] = -76.113434840648,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = false,
				["cooldownEdge"] = false,
				["icon"] = true,
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["desaturate"] = true,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 1,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["rotateText"] = "NONE",
						["text_fontSize"] = 12,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 67,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["glowLength"] = 10,
				["keepAspectRatio"] = false,
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["triggers"] = {
					{
						["trigger"] = {
							["type"] = "aura2",
							["subeventSuffix"] = "_CAST_START",
							["matchesShowOn"] = "showAlways",
							["event"] = "Health",
							["unit"] = "player",
							["ownOnly"] = true,
							["spellIds"] = {
							},
							["useName"] = true,
							["subeventPrefix"] = "SPELL",
							["names"] = {
							},
							["auranames"] = {
								"Mortal Strike", -- [1]
							},
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [1]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["duration"] = "1",
							["event"] = "Power",
							["subeventPrefix"] = "SPELL",
							["powertype"] = 1,
							["subeventSuffix"] = "_CAST_START",
							["unit"] = "player",
							["use_powertype"] = true,
							["use_unit"] = true,
						},
						["untrigger"] = {
						},
					}, -- [2]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["actions"] = {
					["start"] = {
					},
					["init"] = {
					},
					["finish"] = {
					},
				},
				["parent"] = "Arms",
				["regionType"] = "icon",
				["uid"] = "rHlAoLGGCWz",
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["glowYOffset"] = 0,
				["frameStrata"] = 1,
				["selfPoint"] = "CENTER",
				["cooldownTextDisabled"] = false,
				["glowScale"] = 1,
				["useGlowColor"] = false,
				["zoom"] = 0,
				["auto"] = true,
				["tocversion"] = 11302,
				["id"] = "Mortal Strike",
				["authorOptions"] = {
				},
				["alpha"] = 1,
				["anchorFrameType"] = "SCREEN",
				["url"] = "https://wago.io/Eh5J56-nY/1",
				["config"] = {
				},
				["inverse"] = false,
				["load"] = {
					["use_class"] = true,
					["use_spellknown"] = false,
					["size"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 18,
						["multi"] = {
							[21] = true,
							[19] = true,
						},
					},
					["spec"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["spellknown"] = 5283,
					["use_talent"] = true,
				},
				["width"] = 67,
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["op"] = "==",
							["variable"] = "buffed",
							["value"] = 0,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [1]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "AND",
							["checks"] = {
								{
									["trigger"] = 2,
									["op"] = ">=",
									["variable"] = "power",
									["value"] = "1",
								}, -- [1]
								{
									["value"] = 1,
									["variable"] = "spellUsable",
								}, -- [2]
							},
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
							{
								["value"] = false,
								["property"] = "desaturate",
							}, -- [2]
						},
					}, -- [2]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["GOdOjMqf1hX"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201870,
			["allowUpdates"] = true,
			["data"] = {
				["sparkWidth"] = 10,
				["sparkOffsetX"] = 0,
				["parent"] = "Warrior",
				["customText"] = "function()\n    if aura_env.region then\n        local rage = UnitPower(\"player\", Enum.PowerType.Rage)\n        aura_env.region.text3:SetText(rage)\n    end\nend\n\n\n\n\n\n\n\n\n\n\n\n",
				["yOffset"] = -126.99987792969,
				["anchorPoint"] = "CENTER",
				["sparkRotation"] = 0,
				["sparkRotationMode"] = "AUTO",
				["url"] = "https://wago.io/9EBTx7-J0/3",
				["icon"] = false,
				["fontFlags"] = "OUTLINE",
				["icon_color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["internalVersion"] = 23,
				["borderBackdrop"] = "None",
				["selfPoint"] = "CENTER",
				["backdropInFront"] = false,
				["stickyDuration"] = false,
				["barColor"] = {
					1, -- [1]
					0, -- [2]
					0, -- [3]
					1, -- [4]
				},
				["desaturate"] = false,
				["triggers"] = {
					{
						["trigger"] = {
							["duration"] = "1",
							["genericShowOn"] = "showOnActive",
							["names"] = {
							},
							["powertype"] = 1,
							["use_powertype"] = true,
							["custom_hide"] = "timed",
							["type"] = "status",
							["use_health"] = true,
							["subeventSuffix"] = "_CAST_START",
							["debuffType"] = "HELPFUL",
							["event"] = "Power",
							["unit"] = "player",
							["unevent"] = "auto",
							["health"] = "0",
							["spellIds"] = {
							},
							["health_operator"] = ">=",
							["subeventPrefix"] = "SPELL",
							["use_power"] = false,
							["use_showCost"] = true,
							["use_unit"] = true,
						},
						["untrigger"] = {
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["backgroundColor"] = {
					0.3921568627451, -- [1]
					0, -- [2]
					0, -- [3]
					0.60000002384186, -- [4]
				},
				["version"] = 3,
				["subRegions"] = {
					{
						["type"] = "aurabar_bar",
					}, -- [1]
					{
						["text_shadowXOffset"] = 1,
						["type"] = "subtext",
						["text_text"] = "%c ",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Expressway",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = -1,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = false,
						["text_anchorPoint"] = "INNER_RIGHT",
						["anchorYOffset"] = 0,
						["text_fontType"] = "None",
						["rotateText"] = "NONE",
						["anchorXOffset"] = 0,
						["text_fontSize"] = 15,
					}, -- [2]
					{
						["text_shadowXOffset"] = 1,
						["type"] = "subtext",
						["text_text"] = " ",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Expressway",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = -1,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_LEFT",
						["anchorYOffset"] = 0,
						["text_fontType"] = "None",
						["rotateText"] = "NONE",
						["anchorXOffset"] = 0,
						["text_fontSize"] = 18,
					}, -- [3]
					{
						["text_shadowXOffset"] = 1,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = -1,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = false,
						["text_anchorPoint"] = "ICON_CENTER",
						["anchorYOffset"] = 0,
						["text_fontType"] = "None",
						["rotateText"] = "NONE",
						["anchorXOffset"] = 0,
						["text_fontSize"] = 12,
					}, -- [4]
					{
						["border_size"] = 1,
						["border_anchor"] = "bar",
						["type"] = "subborder",
						["border_color"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["border_visible"] = true,
						["border_edge"] = "1 Pixel",
						["border_offset"] = 1,
					}, -- [5]
				},
				["height"] = 20,
				["backdropColor"] = {
					0, -- [1]
					0, -- [2]
					0, -- [3]
					1, -- [4]
				},
				["load"] = {
					["talent2"] = {
						["multi"] = {
						},
					},
					["use_never"] = false,
					["talent"] = {
						["multi"] = {
						},
					},
					["use_vehicle"] = false,
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 1,
						["multi"] = {
							true, -- [1]
							[3] = true,
						},
					},
					["ingroup"] = {
						["multi"] = {
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_petbattle"] = false,
					["role"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["sparkBlendMode"] = "ADD",
				["useAdjustededMax"] = false,
				["config"] = {
				},
				["uid"] = "GOdOjMqf1hX",
				["overlays"] = {
					{
						0.43529411764706, -- [1]
						0, -- [2]
						1, -- [3]
						0.25, -- [4]
					}, -- [1]
				},
				["anchorFrameType"] = "SCREEN",
				["frameStrata"] = 3,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["useAdjustededMin"] = false,
				["regionType"] = "aurabar",
				["borderInFront"] = true,
				["id"] = "Rage Bar",
				["icon_side"] = "RIGHT",
				["auto"] = true,
				["semver"] = "1.0.2",
				["sparkHeight"] = 30,
				["texture"] = "ElvUI Blank",
				["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
				["zoom"] = 0,
				["spark"] = false,
				["tocversion"] = 11302,
				["sparkHidden"] = "NEVER",
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
						["custom"] = "if aura_env.region then\n    local r = aura_env.region\n    if not r.text3 then\n        local text3 = r.bar:CreateFontString(nil, \"OVERLAY\")\n        r.text3 = text3\n        r.text3:SetJustifyH(\"CENTER\")\n        r.text3:SetJustifyV(\"MIDDLE\")\n        r.text3:SetPoint(\"CENTER\", r.bar, \"CENTER\")\n        r.text3:Show()\n    end\n    r.text3:SetShadowOffset(1, -1)\n    r.text3:SetFont(r.text:GetFont())\n    r.text3:SetTextColor(r.text:GetTextColor())\nend\n\n\n\n\n\n\n",
						["do_custom"] = true,
					},
				},
				["alpha"] = 1,
				["width"] = 245,
				["sparkOffsetY"] = 0,
				["sparkColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["inverse"] = false,
				["sparkDesature"] = false,
				["orientation"] = "HORIZONTAL",
				["conditions"] = {
				},
				["authorOptions"] = {
				},
				["xOffset"] = 0,
			},
		},
		["GxeJjwvUN0P"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201870,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["authorOptions"] = {
				},
				["yOffset"] = -204.99975585938,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["cooldownEdge"] = false,
				["icon"] = true,
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["keepAspectRatio"] = false,
				["selfPoint"] = "CENTER",
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 3,
				["subRegions"] = {
				},
				["height"] = 35,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
						["custom"] = "",
						["do_custom"] = false,
					},
				},
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["triggers"] = {
					{
						["trigger"] = {
							["auranames"] = {
								"Demoralizing Shout", -- [1]
							},
							["use_genericShowOn"] = true,
							["genericShowOn"] = "showAlways",
							["names"] = {
							},
							["unitExists"] = true,
							["unit"] = "target",
							["debuffType"] = "HARMFUL",
							["subeventPrefix"] = "SPELL",
							["useName"] = true,
							["unevent"] = "auto",
							["subeventSuffix"] = "_CAST_START",
							["use_showOn"] = true,
							["use_unit"] = true,
							["event"] = "Cooldown Progress (Spell)",
							["type"] = "aura2",
							["realSpellName"] = "Demoralizing Shout",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["spellName"] = 1160,
							["matchesShowOn"] = "showAlways",
							["use_absorbMode"] = true,
							["use_track"] = true,
							["duration"] = "1",
						},
						["untrigger"] = {
							["showOn"] = "showAlways",
							["spellName"] = 1160,
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["load"] = {
					["talent2"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["ingroup"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["use_spec"] = true,
					["spec"] = {
						["single"] = 3,
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["url"] = "https://wago.io/9EBTx7-J0/3",
				["regionType"] = "icon",
				["glowXOffset"] = 0,
				["uid"] = "GxeJjwvUN0P",
				["glowLength"] = 10,
				["width"] = 35,
				["alpha"] = 1,
				["glowYOffset"] = 0,
				["auto"] = true,
				["tocversion"] = 11302,
				["cooldownTextDisabled"] = false,
				["semver"] = "1.0.2",
				["glowScale"] = 1,
				["id"] = "Demoralizing Shout",
				["zoom"] = 0,
				["frameStrata"] = 1,
				["anchorFrameType"] = "SCREEN",
				["xOffset"] = -19.000244140625,
				["config"] = {
				},
				["inverse"] = true,
				["parent"] = "Warrior",
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["op"] = "==",
							["value"] = "0",
							["variable"] = "matchCount",
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [1]
						},
					}, -- [1]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["PhTRXEwvipC"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567202218,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["authorOptions"] = {
					{
						["type"] = "toggle",
						["default"] = false,
						["width"] = 1,
						["name"] = "2+ Cold Steel, Hot Blood",
						["useDesc"] = true,
						["key"] = "cshb",
						["desc"] = "By toggling this option you will change the rotation to priotorize Bloodthirst over Raging Blow.",
					}, -- [1]
				},
				["customText"] = "function()\n    return select(3, WA_GetUnitBuff(\"player\", 7384))\nend",
				["yOffset"] = 0,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["customTextUpdate"] = "update",
				["cooldownEdge"] = false,
				["icon"] = true,
				["triggers"] = {
					{
						["trigger"] = {
							["duration"] = "1",
							["genericShowOn"] = "showAlways",
							["use_unit"] = true,
							["use_showgcd"] = true,
							["powertype"] = 1,
							["use_powertype"] = true,
							["debuffType"] = "HELPFUL",
							["type"] = "status",
							["names"] = {
							},
							["subeventSuffix"] = "_CAST_START",
							["use_showOn"] = true,
							["unit"] = "player",
							["event"] = "Cooldown Progress (Spell)",
							["unevent"] = "auto",
							["realSpellName"] = "Bloodthirst",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["use_genericShowOn"] = true,
							["spellName"] = 23881,
							["use_absorbMode"] = true,
							["use_track"] = true,
							["subeventPrefix"] = "SPELL",
						},
						["untrigger"] = {
							["showOn"] = "showAlways",
							["spellName"] = 23881,
						},
					}, -- [1]
					{
						["trigger"] = {
							["type"] = "status",
							["subeventPrefix"] = "SPELL",
							["unevent"] = "auto",
							["unit"] = "player",
							["duration"] = "1",
							["genericShowOn"] = "showAlways",
							["use_unit"] = true,
							["realSpellName"] = "Raging Blow",
							["use_spellName"] = true,
							["subeventSuffix"] = "_CAST_START",
							["event"] = "Cooldown Progress (Spell)",
							["use_absorbMode"] = true,
							["use_genericShowOn"] = true,
							["use_track"] = true,
							["spellName"] = 85288,
						},
						["untrigger"] = {
							["genericShowOn"] = "showAlways",
						},
					}, -- [2]
					{
						["trigger"] = {
							["buffShowOn"] = "showAlways",
							["type"] = "aura2",
							["use_debuffClass"] = false,
							["useGroup_count"] = false,
							["useName"] = true,
							["matchesShowOn"] = "showAlways",
							["event"] = "Health",
							["unit"] = "player",
							["subeventSuffix"] = "_CAST_START",
							["use_tooltip"] = false,
							["spellIds"] = {
								184362, -- [1]
							},
							["subeventPrefix"] = "SPELL",
							["names"] = {
								"Enrage", -- [1]
							},
							["combineMatches"] = "showLowest",
							["auranames"] = {
								"184362", -- [1]
							},
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [3]
					{
						["trigger"] = {
							["type"] = "status",
							["talent"] = {
								["single"] = 13,
							},
							["use_absorbMode"] = true,
							["event"] = "Talent Known",
							["unit"] = "player",
							["subeventPrefix"] = "SPELL",
							["use_unit"] = true,
							["subeventSuffix"] = "_CAST_START",
							["unevent"] = "auto",
							["use_talent"] = true,
							["duration"] = "1",
						},
						["untrigger"] = {
						},
					}, -- [4]
					{
						["trigger"] = {
							["subeventSuffix"] = "_CAST_START",
							["type"] = "status",
							["duration"] = "1",
							["unevent"] = "auto",
							["use_exact_spellName"] = false,
							["use_genericShowOn"] = true,
							["genericShowOn"] = "showAlways",
							["subeventPrefix"] = "SPELL",
							["realSpellName"] = "Rampage",
							["use_spellName"] = true,
							["event"] = "Cooldown Progress (Spell)",
							["use_unit"] = true,
							["use_absorbMode"] = true,
							["unit"] = "player",
							["use_track"] = true,
							["spellName"] = 184367,
						},
						["untrigger"] = {
							["genericShowOn"] = "showAlways",
						},
					}, -- [5]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["use_absorbMode"] = true,
							["event"] = "Power",
							["unit"] = "player",
							["powertype"] = 1,
							["subeventPrefix"] = "SPELL",
							["use_unit"] = true,
							["subeventSuffix"] = "_CAST_START",
							["use_powertype"] = true,
							["duration"] = "1",
						},
						["untrigger"] = {
						},
					}, -- [6]
					{
						["trigger"] = {
							["debuffType"] = "HELPFUL",
							["type"] = "aura2",
							["useName"] = true,
							["auranames"] = {
								"184362", -- [1]
							},
							["subeventSuffix"] = "_CAST_START",
							["subeventPrefix"] = "SPELL",
							["event"] = "Health",
							["unit"] = "player",
						},
						["untrigger"] = {
						},
					}, -- [7]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["duration"] = "1",
							["event"] = "Action Usable",
							["unit"] = "player",
							["realSpellName"] = 5308,
							["use_spellName"] = true,
							["subeventPrefix"] = "SPELL",
							["use_exact_spellName"] = true,
							["subeventSuffix"] = "_CAST_START",
							["use_unit"] = true,
							["use_absorbMode"] = true,
							["spellName"] = 5308,
						},
						["untrigger"] = {
						},
					}, -- [8]
					{
						["trigger"] = {
							["type"] = "custom",
							["subeventSuffix"] = "_CAST_START",
							["event"] = "Health",
							["subeventPrefix"] = "SPELL",
							["events"] = "LUXTHOS_EVENT",
							["check"] = "event",
							["custom_type"] = "status",
							["custom"] = "function()\n    return aura_env.config[\"cshb\"] == true\nend",
							["custom_hide"] = "timed",
						},
						["untrigger"] = {
						},
					}, -- [9]
					["disjunctive"] = "any",
					["customTriggerLogic"] = "function(t)\n    if t[2] and t[3] and t[5] then\n        aura_env.region:SetGlow(true)\n    elseif t[2] and t[4] and t[5] then\n        aura_env.region:SetGlow(true)\n    else \n        aura_env.region:SetGlow(false)\n    end\n    return t[1]\nend",
					["activeTriggerMode"] = -10,
				},
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["selfPoint"] = "CENTER",
				["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["glowLength"] = 10,
				["version"] = 32,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = " ",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["text_fontSize"] = 13,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 55,
				["url"] = "https://wago.io/SkBHabbrQ/32",
				["load"] = {
					["use_petbattle"] = false,
					["use_never"] = false,
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["use_class"] = true,
					["role"] = {
						["multi"] = {
						},
					},
					["use_spec"] = true,
					["size"] = {
						["multi"] = {
						},
					},
					["talent2"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 3,
						["multi"] = {
							[9] = true,
							[8] = true,
						},
					},
					["spec"] = {
						["single"] = 2,
						["multi"] = {
							true, -- [1]
							true, -- [2]
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["use_vehicleUi"] = false,
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["use_combat"] = true,
					["race"] = {
						["multi"] = {
						},
					},
					["ingroup"] = {
						["multi"] = {
						},
					},
				},
				["displayIcon"] = 136012,
				["glowFrequency"] = 0.25,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["stickyDuration"] = false,
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 4,
				["xOffset"] = -116,
				["uid"] = "PhTRXEwvipC",
				["glowLines"] = 8,
				["regionType"] = "icon",
				["glowYOffset"] = 0,
				["alpha"] = 1,
				["anchorFrameType"] = "SCREEN",
				["parent"] = "Luxthos - Warrior Rotations",
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["auto"] = true,
				["cooldownTextDisabled"] = false,
				["desaturate"] = false,
				["zoom"] = 0.33,
				["semver"] = "1.1.2",
				["glowScale"] = 1,
				["id"] = "Bloodthirst",
				["useglowColor"] = false,
				["frameStrata"] = 3,
				["width"] = 55,
				["progressPrecision"] = 0,
				["config"] = {
					["cshb"] = true,
				},
				["inverse"] = true,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["keepAspectRatio"] = true,
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "onCooldown",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [1]
							{
								["value"] = true,
								["property"] = "cooldownEdge",
							}, -- [2]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "OR",
							["checks"] = {
								{
									["trigger"] = -2,
									["variable"] = "AND",
									["checks"] = {
										{
											["trigger"] = 9,
											["variable"] = "show",
											["value"] = 1,
										}, -- [1]
										{
											["trigger"] = 1,
											["variable"] = "onCooldown",
											["value"] = 0,
										}, -- [2]
									},
								}, -- [1]
								{
									["trigger"] = -2,
									["op"] = "<",
									["variable"] = "AND",
									["checks"] = {
										{
											["trigger"] = 9,
											["variable"] = "show",
											["value"] = 0,
										}, -- [1]
										{
											["trigger"] = 1,
											["variable"] = "onCooldown",
											["value"] = 0,
										}, -- [2]
										{
											["trigger"] = 2,
											["op"] = "<",
											["value"] = "2",
											["variable"] = "charges",
										}, -- [3]
									},
								}, -- [2]
							},
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
						},
					}, -- [2]
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "AND",
							["checks"] = {
								{
									["trigger"] = 1,
									["variable"] = "onCooldown",
									["value"] = 0,
								}, -- [1]
								{
									["trigger"] = 2,
									["op"] = "==",
									["value"] = "2",
									["variable"] = "charges",
								}, -- [2]
								{
									["trigger"] = 3,
									["variable"] = "buffed",
									["value"] = 0,
								}, -- [3]
							},
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
						},
					}, -- [3]
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "AND",
							["checks"] = {
								{
									["trigger"] = 4,
									["variable"] = "show",
									["value"] = 0,
								}, -- [1]
								{
									["trigger"] = 5,
									["variable"] = "insufficientResources",
									["value"] = 0,
								}, -- [2]
							},
						},
						["changes"] = {
							{
								["property"] = "glow",
							}, -- [1]
						},
					}, -- [4]
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "AND",
							["checks"] = {
								{
									["trigger"] = 4,
									["variable"] = "show",
									["value"] = 1,
								}, -- [1]
								{
									["trigger"] = -2,
									["variable"] = "OR",
									["checks"] = {
										{
											["trigger"] = -2,
											["variable"] = "AND",
											["checks"] = {
												{
													["trigger"] = 7,
													["variable"] = "show",
													["value"] = 0,
												}, -- [1]
												{
													["trigger"] = 5,
													["variable"] = "insufficientResources",
													["value"] = 0,
												}, -- [2]
											},
										}, -- [1]
										{
											["trigger"] = 6,
											["op"] = ">=",
											["value"] = "90",
											["variable"] = "power",
										}, -- [2]
									},
								}, -- [2]
							},
						},
						["changes"] = {
							{
								["property"] = "glow",
							}, -- [1]
						},
					}, -- [5]
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "AND",
							["checks"] = {
								{
									["trigger"] = 8,
									["variable"] = "show",
									["value"] = 1,
								}, -- [1]
								{
									["trigger"] = 7,
									["variable"] = "show",
									["value"] = 1,
								}, -- [2]
							},
						},
						["changes"] = {
							{
								["property"] = "glow",
							}, -- [1]
						},
					}, -- [6]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["krJIqDoBF7C"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201870,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["yOffset"] = -161.99966430664,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["url"] = "https://wago.io/9EBTx7-J0/3",
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["keepAspectRatio"] = false,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 3,
				["subRegions"] = {
				},
				["height"] = 45,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["selfPoint"] = "CENTER",
				["glowXOffset"] = 0,
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["glowLength"] = 10,
				["triggers"] = {
					{
						["trigger"] = {
							["auranames"] = {
								"772", -- [1]
							},
							["matchesShowOn"] = "showAlways",
							["use_specific_unit"] = false,
							["unitExists"] = true,
							["use_tooltip"] = false,
							["debuffType"] = "HARMFUL",
							["type"] = "aura2",
							["subeventSuffix"] = "_CAST_START",
							["event"] = "Health",
							["unit"] = "target",
							["names"] = {
								"Rend", -- [1]
							},
							["useName"] = true,
							["spellIds"] = {
								772, -- [1]
							},
							["useGroup_count"] = false,
							["subeventPrefix"] = "SPELL",
							["combineMatches"] = "showLowest",
							["ownOnly"] = true,
							["buffShowOn"] = "showAlways",
						},
						["untrigger"] = {
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["load"] = {
					["talent2"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 9,
						["multi"] = {
							[9] = true,
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["ingroup"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["use_spec"] = true,
					["spec"] = {
						["single"] = 1,
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["regionType"] = "icon",
				["xOffset"] = -50,
				["uid"] = "krJIqDoBF7C",
				["authorOptions"] = {
				},
				["width"] = 45,
				["alpha"] = 1,
				["icon"] = true,
				["auto"] = true,
				["tocversion"] = 11302,
				["cooldownTextDisabled"] = false,
				["semver"] = "1.0.2",
				["glowScale"] = 1,
				["id"] = "Rend",
				["zoom"] = 0,
				["frameStrata"] = 1,
				["glowYOffset"] = 0,
				["anchorFrameType"] = "SCREEN",
				["config"] = {
				},
				["inverse"] = false,
				["parent"] = "Warrior",
				["cooldownEdge"] = false,
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["op"] = "==",
							["value"] = "0",
							["variable"] = "matchCount",
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [1]
						},
					}, -- [1]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["hTqMISYfyXC"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567200331,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["cooldownTextEnabled"] = false,
				["customText"] = "",
				["yOffset"] = 0,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["customTextUpdate"] = "event",
				["url"] = "https://wago.io/s8EGafICm/1",
				["actions"] = {
					["start"] = {
						["custom"] = "aura_env.AddClone(aura_env.state.unit, aura_env.region)",
						["do_custom"] = false,
					},
					["finish"] = {
						["custom"] = "",
						["do_custom"] = false,
					},
					["init"] = {
						["custom"] = "\n\n",
						["do_custom"] = false,
					},
				},
				["triggers"] = {
					{
						["trigger"] = {
							["showClones"] = true,
							["debuffClass"] = {
								["magic"] = true,
								["enrage"] = true,
							},
							["unevent"] = "timed",
							["ownOnly"] = true,
							["event"] = "Health",
							["unit"] = "nameplate",
							["duration"] = "1",
							["spellIds"] = {
							},
							["subeventSuffix"] = "_CAST_START",
							["names"] = {
							},
							["type"] = "aura2",
							["subeventPrefix"] = "SPELL",
							["debuffType"] = "HARMFUL",
						},
						["untrigger"] = {
						},
					}, -- [1]
					["disjunctive"] = "any",
					["customTriggerLogic"] = "function(t) return t[1] and not t[2] end",
					["activeTriggerMode"] = 1,
				},
				["iconInset"] = 0,
				["internalVersion"] = 23,
				["keepAspectRatio"] = true,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["selfPoint"] = "CENTER",
				["useglowColor"] = false,
				["cooldownEdge"] = true,
				["stickyDuration"] = false,
				["progressPrecision"] = 4,
				["glowXOffset"] = 0,
				["version"] = 1,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "PT Sans Narrow",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["text_fontType"] = "OUTLINE",
						["rotateText"] = "NONE",
						["anchorXOffset"] = 0,
						["text_fontSize"] = 12,
					}, -- [1]
				},
				["height"] = 30,
				["glowLines"] = 8,
				["load"] = {
					["class"] = {
						["multi"] = {
						},
					},
					["spec"] = {
						["multi"] = {
						},
					},
					["use_never"] = false,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["config"] = {
				},
				["glowFrequency"] = 0.25,
				["parent"] = "Nameplate Debuffs",
				["anchorFrameType"] = "SCREEN",
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 4,
				["frameStrata"] = 1,
				["desaturate"] = false,
				["xOffset"] = 0,
				["regionType"] = "icon",
				["glowScale"] = 1,
				["auto"] = true,
				["zoom"] = 0,
				["glowYOffset"] = 0,
				["glowLength"] = 4,
				["anchorFrameParent"] = false,
				["useGlowColor"] = false,
				["icon"] = true,
				["cooldownTextDisabled"] = false,
				["semver"] = "1.0.1",
				["tocversion"] = 11302,
				["id"] = "Nameplate Anchor for Debuffs",
				["authorOptions"] = {
				},
				["alpha"] = 1,
				["width"] = 30,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["uid"] = "hTqMISYfyXC",
				["inverse"] = false,
				["glowParticules"] = 4,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["conditions"] = {
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["dTFfZ8bZ9dX"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567277425,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["glowLength"] = 10,
				["yOffset"] = -89,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["url"] = "https://wago.io/Eh5J56-nY/1",
				["actions"] = {
					["start"] = {
						["do_glow"] = false,
						["glow_type"] = "ACShine",
						["glow_action"] = "show",
					},
					["init"] = {
					},
					["finish"] = {
						["do_glow"] = false,
					},
				},
				["triggers"] = {
					{
						["trigger"] = {
							["useName"] = true,
							["auranames"] = {
								"Heroic Strike", -- [1]
							},
							["matchesShowOn"] = "showAlways",
							["event"] = "Health",
							["unit"] = "player",
							["spellIds"] = {
							},
							["names"] = {
							},
							["subeventPrefix"] = "SPELL",
							["subeventSuffix"] = "_CAST_START",
							["type"] = "aura2",
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [1]
					{
						["trigger"] = {
							["auranames"] = {
								"Heroic Strike", -- [1]
							},
							["matchesShowOn"] = "showAlways",
							["genericShowOn"] = "showAlways",
							["unit"] = "player",
							["debuffType"] = "HELPFUL",
							["ownOnly"] = true,
							["type"] = "status",
							["subeventSuffix"] = "_CAST_START",
							["unevent"] = "auto",
							["use_genericShowOn"] = true,
							["names"] = {
							},
							["event"] = "Cooldown Progress (Spell)",
							["useName"] = true,
							["realSpellName"] = "Heroic Strike",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["subeventPrefix"] = "SPELL",
							["use_unit"] = true,
							["duration"] = "1",
							["use_track"] = true,
							["spellName"] = 284,
						},
						["untrigger"] = {
							["genericShowOn"] = "showAlways",
						},
					}, -- [2]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["duration"] = "1",
							["event"] = "Power",
							["use_unit"] = true,
							["powertype"] = 1,
							["subeventSuffix"] = "_CAST_START",
							["subeventPrefix"] = "SPELL",
							["use_powertype"] = true,
							["unit"] = "player",
						},
						["untrigger"] = {
						},
					}, -- [3]
					["disjunctive"] = "all",
					["activeTriggerMode"] = 1,
				},
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["desaturate"] = true,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 1,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["rotateText"] = "NONE",
						["text_fontSize"] = 12,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 39.99995803833,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["keepAspectRatio"] = false,
				["useglowColor"] = false,
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["displayIcon"] = 132282,
				["cooldownEdge"] = false,
				["anchorFrameType"] = "SCREEN",
				["regionType"] = "icon",
				["config"] = {
				},
				["glowScale"] = 1,
				["glowYOffset"] = 0,
				["alpha"] = 1,
				["xOffset"] = -38,
				["icon"] = true,
				["authorOptions"] = {
				},
				["cooldownTextDisabled"] = false,
				["zoom"] = 0,
				["auto"] = false,
				["tocversion"] = 11302,
				["id"] = "Heroic Strike",
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["frameStrata"] = 1,
				["width"] = 40,
				["parent"] = "Arms",
				["uid"] = "k9oMvzIfep1",
				["inverse"] = false,
				["selfPoint"] = "CENTER",
				["load"] = {
					["use_class"] = true,
					["use_spellknown"] = false,
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["spec"] = {
						["multi"] = {
						},
					},
					["spellknown"] = 284,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["op"] = "==",
							["variable"] = "buffed",
							["value"] = 0,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [1]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "OR",
							["checks"] = {
								{
									["trigger"] = 3,
									["op"] = ">=",
									["variable"] = "power",
									["value"] = "15",
								}, -- [1]
								{
									["trigger"] = 2,
									["variable"] = "spellUsable",
									["value"] = 1,
								}, -- [2]
							},
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
							{
								["value"] = false,
								["property"] = "desaturate",
							}, -- [2]
						},
					}, -- [2]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["5yd)9uinH6)"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567202218,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["xOffset"] = 58,
				["customText"] = "function()\n    if aura_env.state and aura_env.state.tooltip1 and aura_env.state.duration ~= 0 then\n        return AbbreviateNumbers(aura_env.state.tooltip2)\n    end\nend",
				["yOffset"] = 0,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["customTextUpdate"] = "update",
				["cooldownEdge"] = false,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["selfPoint"] = "CENTER",
				["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
				["progressPrecision"] = 0,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 32,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%c",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "CENTER",
						["anchorYOffset"] = 0,
						["text_fontSize"] = 16,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 55,
				["url"] = "https://wago.io/SkBHabbrQ/32",
				["load"] = {
					["ingroup"] = {
						["multi"] = {
						},
					},
					["use_never"] = false,
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["use_class"] = true,
					["role"] = {
						["multi"] = {
						},
					},
					["use_spec"] = true,
					["size"] = {
						["multi"] = {
						},
					},
					["talent2"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 3,
						["multi"] = {
							[9] = true,
							[8] = true,
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							true, -- [1]
							true, -- [2]
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["use_vehicleUi"] = false,
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_petbattle"] = false,
					["use_combat"] = true,
					["race"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
				},
				["displayIcon"] = 1377132,
				["glowFrequency"] = 0.25,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["type"] = "custom",
						["colorR"] = 1,
						["scaley"] = 1,
						["duration_type"] = "seconds",
						["y"] = 0,
						["scalex"] = 1,
						["alpha"] = 0.3,
						["x"] = 0,
						["alphaType"] = "custom",
						["colorB"] = 1,
						["colorG"] = 1,
						["alphaFunc"] = "function(progress, start, delta)\n    if WeakAuras.GetActiveConditions(aura_env.id,aura_env.cloneId)[2] then\n        local angle = (progress * 2 * math.pi) - (math.pi / 2)\n        return start + (((math.sin(angle) + 1)/2) * delta)\n    end\nend",
						["colorA"] = 1,
						["rotate"] = 0,
						["duration"] = "0.7",
						["use_alpha"] = true,
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["stickyDuration"] = false,
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 4,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["uid"] = "5yd)9uinH6)",
				["glowLines"] = 8,
				["regionType"] = "icon",
				["glowYOffset"] = 0,
				["alpha"] = 1,
				["anchorFrameType"] = "SCREEN",
				["parent"] = "Luxthos - Warrior Rotations",
				["glowLength"] = 10,
				["auto"] = true,
				["cooldownTextDisabled"] = true,
				["desaturate"] = false,
				["zoom"] = 0.33,
				["semver"] = "1.1.2",
				["glowScale"] = 1,
				["id"] = "Ignore Pain",
				["icon"] = true,
				["frameStrata"] = 3,
				["width"] = 55,
				["triggers"] = {
					{
						["trigger"] = {
							["spellId"] = "190456",
							["useGroup_count"] = false,
							["matchesShowOn"] = "showOnActive",
							["names"] = {
								"Ignore Pain", -- [1]
							},
							["use_tooltip"] = false,
							["subcount"] = true,
							["debuffType"] = "HELPFUL",
							["auraspellids"] = {
								"190456", -- [1]
							},
							["type"] = "aura2",
							["use_debuffClass"] = false,
							["subeventSuffix"] = "_CAST_START",
							["subeventPrefix"] = "SPELL",
							["fetchTooltip"] = true,
							["event"] = "Health",
							["unit"] = "player",
							["spellIds"] = {
								190456, -- [1]
							},
							["use_spellId"] = true,
							["name"] = "Ignore Pain",
							["useExactSpellId"] = true,
							["buffShowOn"] = "showAlways",
							["combineMatches"] = "showLowest",
							["subcountCount"] = 2,
							["fullscan"] = true,
						},
						["untrigger"] = {
						},
					}, -- [1]
					{
						["trigger"] = {
							["track"] = "auto",
							["use_genericShowOn"] = true,
							["genericShowOn"] = "showAlways",
							["use_unit"] = true,
							["use_showgcd"] = false,
							["debuffType"] = "HELPFUL",
							["type"] = "status",
							["subeventSuffix"] = "_CAST_START",
							["spellName"] = 190456,
							["unit"] = "player",
							["event"] = "Cooldown Progress (Spell)",
							["unevent"] = "auto",
							["realSpellName"] = "Ignore Pain",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["subeventPrefix"] = "SPELL",
							["use_absorbMode"] = true,
							["names"] = {
							},
							["use_track"] = true,
							["duration"] = "1",
						},
						["untrigger"] = {
							["genericShowOn"] = "showAlways",
						},
					}, -- [2]
					{
						["trigger"] = {
							["buffShowOn"] = "showAlways",
							["useName"] = true,
							["use_debuffClass"] = false,
							["auranames"] = {
								"202574", -- [1]
							},
							["type"] = "aura2",
							["matchesShowOn"] = "showAlways",
							["event"] = "Health",
							["names"] = {
								"Vengeance: Revenge", -- [1]
							},
							["subeventSuffix"] = "_CAST_START",
							["use_tooltip"] = false,
							["spellIds"] = {
								202573, -- [1]
							},
							["useGroup_count"] = false,
							["subeventPrefix"] = "SPELL",
							["combineMatches"] = "showLowest",
							["unit"] = "player",
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [3]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["use_absorbMode"] = true,
							["event"] = "Power",
							["subeventPrefix"] = "SPELL",
							["powertype"] = 1,
							["use_unit"] = true,
							["unit"] = "player",
							["subeventSuffix"] = "_CAST_START",
							["use_powertype"] = true,
							["duration"] = "1",
						},
						["untrigger"] = {
						},
					}, -- [4]
					["disjunctive"] = "any",
					["customTriggerLogic"] = "function(t)\n    if t[2] and t[3] and t[5] then\n        aura_env.region:SetGlow(true)\n    elseif t[2] and t[4] and t[5] then\n        aura_env.region:SetGlow(true)\n    else \n        aura_env.region:SetGlow(false)\n    end\n    return t[1]\nend",
					["activeTriggerMode"] = -10,
				},
				["config"] = {
				},
				["inverse"] = true,
				["keepAspectRatio"] = true,
				["authorOptions"] = {
				},
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 2,
							["op"] = "<",
							["value"] = 1,
							["variable"] = "insufficientResources",
						},
						["changes"] = {
							{
								["value"] = {
									0.31764705882353, -- [1]
									0.40392156862745, -- [2]
									0.78039215686274, -- [3]
									1, -- [4]
								},
								["property"] = "color",
							}, -- [1]
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [2]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "show",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
							{
								["value"] = "ACShine",
								["property"] = "glowType",
							}, -- [2]
						},
					}, -- [2]
					{
						["check"] = {
							["trigger"] = 3,
							["variable"] = "buffed",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
							{
								["value"] = "ACShine",
								["property"] = "glowType",
							}, -- [2]
						},
					}, -- [3]
					{
						["check"] = {
							["trigger"] = 4,
							["op"] = ">=",
							["value"] = "70",
							["variable"] = "power",
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
							{
								["value"] = "buttonOverlay",
								["property"] = "glowType",
							}, -- [2]
						},
					}, -- [4]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["OMZl)(NJx5X"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201685,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["parent"] = "ChUI - Debuff Tracker - Warrior",
				["yOffset"] = 0,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["url"] = "https://wago.io/Okky1Eh5g/1",
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["keepAspectRatio"] = false,
				["selfPoint"] = "CENTER",
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 1,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = false,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["text_fontType"] = "OUTLINE",
						["rotateText"] = "NONE",
						["anchorXOffset"] = 0,
						["text_fontSize"] = 12,
					}, -- [1]
				},
				["height"] = 50,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["animation"] = {
					["start"] = {
						["type"] = "preset",
						["preset"] = "slidebottom",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["type"] = "preset",
						["preset"] = "slidetop",
						["duration_type"] = "seconds",
					},
				},
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["triggers"] = {
					{
						["trigger"] = {
							["useName"] = true,
							["auranames"] = {
								"Demoralizing Shout", -- [1]
							},
							["event"] = "Health",
							["unit"] = "target",
							["spellIds"] = {
							},
							["subeventPrefix"] = "SPELL",
							["subeventSuffix"] = "_CAST_START",
							["names"] = {
							},
							["type"] = "aura2",
							["debuffType"] = "HARMFUL",
						},
						["untrigger"] = {
						},
					}, -- [1]
					["activeTriggerMode"] = -10,
				},
				["cooldownEdge"] = false,
				["regionType"] = "icon",
				["load"] = {
					["use_class"] = true,
					["use_combat"] = true,
					["spec"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["glowLength"] = 10,
				["uid"] = "OMZl)(NJx5X",
				["glowYOffset"] = 0,
				["anchorFrameType"] = "SCREEN",
				["alpha"] = 1,
				["glowXOffset"] = 0,
				["glowScale"] = 1,
				["cooldownTextDisabled"] = false,
				["auto"] = true,
				["tocversion"] = 11302,
				["id"] = "Warrior: Demo Shout UP",
				["zoom"] = 0,
				["frameStrata"] = 1,
				["width"] = 50,
				["xOffset"] = 110,
				["config"] = {
				},
				["inverse"] = false,
				["authorOptions"] = {
				},
				["icon"] = true,
				["conditions"] = {
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["Kp015ZeUg7F"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567202218,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["authorOptions"] = {
				},
				["yOffset"] = 0,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["customTextUpdate"] = "update",
				["cooldownEdge"] = false,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["selfPoint"] = "CENTER",
				["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 32,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = " ",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["text_fontSize"] = 13,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 55,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["load"] = {
					["talent2"] = {
						["multi"] = {
						},
					},
					["use_petbattle"] = false,
					["spec"] = {
						["single"] = 1,
						["multi"] = {
							[2] = true,
						},
					},
					["talent"] = {
						["single"] = 17,
						["multi"] = {
							[17] = true,
						},
					},
					["use_vehicleUi"] = false,
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["use_spec"] = true,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["use_combat"] = true,
					["ingroup"] = {
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["url"] = "https://wago.io/SkBHabbrQ/32",
				["glowFrequency"] = 0.25,
				["displayIcon"] = "",
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 4,
				["stickyDuration"] = false,
				["glowLength"] = 10,
				["uid"] = "Kp015ZeUg7F",
				["regionType"] = "icon",
				["glowLines"] = 8,
				["glowYOffset"] = 0,
				["alpha"] = 1,
				["parent"] = "Luxthos - Warrior Rotations",
				["icon"] = true,
				["xOffset"] = 0,
				["auto"] = true,
				["cooldownTextDisabled"] = false,
				["zoom"] = 0.33,
				["semver"] = "1.1.2",
				["glowScale"] = 1,
				["id"] = "Colossus Smash - Cooldown",
				["triggers"] = {
					{
						["trigger"] = {
							["ownOnly"] = true,
							["genericShowOn"] = "showAlways",
							["subeventPrefix"] = "SPELL",
							["use_showgcd"] = true,
							["use_specific_unit"] = false,
							["spellName"] = 167105,
							["unit"] = "player",
							["type"] = "status",
							["use_genericShowOn"] = true,
							["unevent"] = "auto",
							["use_showOn"] = true,
							["subeventSuffix"] = "_CAST_START",
							["event"] = "Cooldown Progress (Spell)",
							["use_unit"] = true,
							["realSpellName"] = "Colossus Smash",
							["use_spellName"] = true,
							["spellIds"] = {
								280757, -- [1]
							},
							["duration"] = "1",
							["use_absorbMode"] = true,
							["names"] = {
								"Avatar", -- [1]
							},
							["use_track"] = true,
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
							["showOn"] = "showAlways",
							["spellName"] = 167105,
						},
					}, -- [1]
					{
						["trigger"] = {
							["useGroup_count"] = false,
							["matchesShowOn"] = "showOnMissing",
							["use_specific_unit"] = false,
							["unitExists"] = true,
							["use_tooltip"] = false,
							["debuffType"] = "HARMFUL",
							["useName"] = true,
							["use_debuffClass"] = false,
							["subeventSuffix"] = "_CAST_START",
							["event"] = "Health",
							["buffShowOn"] = "showOnMissing",
							["subeventPrefix"] = "SPELL",
							["unit"] = "target",
							["spellIds"] = {
								208086, -- [1]
							},
							["type"] = "aura2",
							["auranames"] = {
								"208086", -- [1]
							},
							["combineMatches"] = "showLowest",
							["ownOnly"] = true,
							["names"] = {
								"Colossus Smash", -- [1]
							},
						},
						["untrigger"] = {
						},
					}, -- [2]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["frameStrata"] = 1,
				["anchorFrameType"] = "SCREEN",
				["width"] = 55,
				["config"] = {
				},
				["inverse"] = true,
				["desaturate"] = false,
				["keepAspectRatio"] = true,
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "onCooldown",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [1]
							{
								["value"] = true,
								["property"] = "cooldownEdge",
							}, -- [2]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "onCooldown",
							["value"] = 0,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
						},
					}, -- [2]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["MliLblxR1di"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201685,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["parent"] = "ChUI - Debuff Tracker - Warrior",
				["yOffset"] = 0,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["cooldownEdge"] = false,
				["icon"] = true,
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["keepAspectRatio"] = false,
				["animation"] = {
					["start"] = {
						["type"] = "preset",
						["preset"] = "slidebottom",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["type"] = "preset",
						["preset"] = "slidetop",
						["duration_type"] = "seconds",
					},
				},
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 1,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = false,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["text_fontType"] = "OUTLINE",
						["rotateText"] = "NONE",
						["anchorXOffset"] = 0,
						["text_fontSize"] = 12,
					}, -- [1]
				},
				["height"] = 50,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["glowXOffset"] = 0,
				["authorOptions"] = {
				},
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["regionType"] = "icon",
				["url"] = "https://wago.io/Okky1Eh5g/1",
				["glowLength"] = 10,
				["uid"] = "MliLblxR1di",
				["glowYOffset"] = 0,
				["width"] = 50,
				["frameStrata"] = 1,
				["selfPoint"] = "CENTER",
				["tocversion"] = 11302,
				["cooldownTextDisabled"] = false,
				["auto"] = true,
				["glowScale"] = 1,
				["id"] = "Warrior: Hamstring UP",
				["zoom"] = 0,
				["alpha"] = 1,
				["anchorFrameType"] = "SCREEN",
				["xOffset"] = -55,
				["config"] = {
				},
				["inverse"] = false,
				["load"] = {
					["use_class"] = true,
					["use_combat"] = true,
					["spec"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["triggers"] = {
					{
						["trigger"] = {
							["type"] = "aura2",
							["auranames"] = {
								"Hamstring", -- [1]
							},
							["event"] = "Health",
							["unit"] = "target",
							["spellIds"] = {
							},
							["subeventPrefix"] = "SPELL",
							["useName"] = true,
							["subeventSuffix"] = "_CAST_START",
							["names"] = {
							},
							["debuffType"] = "HARMFUL",
						},
						["untrigger"] = {
						},
					}, -- [1]
					["activeTriggerMode"] = -10,
				},
				["conditions"] = {
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["OFhtNx6IT5P"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567202218,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["authorOptions"] = {
				},
				["customText"] = "function()\n    return select(3, WA_GetUnitBuff(\"player\", 7384))\nend",
				["yOffset"] = 0,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["customTextUpdate"] = "update",
				["cooldownEdge"] = false,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["selfPoint"] = "CENTER",
				["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
				["progressPrecision"] = 0,
				["glowLength"] = 10,
				["version"] = 32,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = " ",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["text_fontSize"] = 13,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 55,
				["url"] = "https://wago.io/SkBHabbrQ/32",
				["load"] = {
					["use_petbattle"] = false,
					["use_never"] = false,
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
							["WARRIOR"] = true,
						},
					},
					["use_class"] = true,
					["role"] = {
						["multi"] = {
						},
					},
					["use_spec"] = true,
					["size"] = {
						["multi"] = {
						},
					},
					["talent2"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 3,
						["multi"] = {
							[14] = true,
							[13] = true,
						},
					},
					["spec"] = {
						["single"] = 2,
						["multi"] = {
							true, -- [1]
							true, -- [2]
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_vehicleUi"] = false,
					["use_combat"] = true,
					["race"] = {
						["multi"] = {
						},
					},
					["ingroup"] = {
						["multi"] = {
						},
					},
				},
				["displayIcon"] = 132352,
				["glowFrequency"] = 0.25,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["type"] = "custom",
						["colorR"] = 1,
						["scaley"] = 1,
						["duration_type"] = "seconds",
						["y"] = 0,
						["scalex"] = 1,
						["alpha"] = 0.3,
						["x"] = 0,
						["alphaType"] = "custom",
						["colorB"] = 1,
						["colorG"] = 1,
						["alphaFunc"] = "function(progress, start, delta)\n    if WeakAuras.GetActiveConditions(aura_env.id,aura_env.cloneId)[2] then\n        local angle = (progress * 2 * math.pi) - (math.pi / 2)\n        return start + (((math.sin(angle) + 1)/2) * delta)\n    end\nend",
						["colorA"] = 1,
						["rotate"] = 0,
						["duration"] = "0.7",
						["use_alpha"] = true,
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["stickyDuration"] = false,
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 4,
				["desaturate"] = false,
				["uid"] = "OFhtNx6IT5P",
				["glowLines"] = 8,
				["regionType"] = "icon",
				["glowYOffset"] = 0,
				["alpha"] = 1,
				["width"] = 55,
				["parent"] = "Luxthos - Warrior Rotations",
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["auto"] = true,
				["cooldownTextDisabled"] = false,
				["xOffset"] = 116,
				["zoom"] = 0.33,
				["semver"] = "1.1.2",
				["glowScale"] = 1,
				["id"] = "Enrage",
				["icon"] = true,
				["frameStrata"] = 1,
				["anchorFrameType"] = "SCREEN",
				["triggers"] = {
					{
						["trigger"] = {
							["auranames"] = {
								"184362", -- [1]
							},
							["use_genericShowOn"] = true,
							["genericShowOn"] = "showAlways",
							["names"] = {
							},
							["use_showgcd"] = false,
							["powertype"] = 1,
							["use_power"] = true,
							["debuffType"] = "HELPFUL",
							["use_powertype"] = true,
							["spellName"] = 5308,
							["useName"] = true,
							["type"] = "aura2",
							["unevent"] = "auto",
							["subeventSuffix"] = "_CAST_START",
							["power_operator"] = ">=",
							["duration"] = "1",
							["event"] = "Cooldown Progress (Spell)",
							["use_exact_spellName"] = false,
							["realSpellName"] = "Execute",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["unit"] = "player",
							["use_unit"] = true,
							["use_absorbMode"] = true,
							["matchesShowOn"] = "showAlways",
							["subeventPrefix"] = "SPELL",
						},
						["untrigger"] = {
							["genericShowOn"] = "showAlways",
							["spellName"] = 184367,
						},
					}, -- [1]
					{
						["trigger"] = {
							["debuffType"] = "HELPFUL",
							["type"] = "aura2",
							["useName"] = true,
							["auranames"] = {
								"184362", -- [1]
							},
							["subeventSuffix"] = "_CAST_START",
							["subeventPrefix"] = "SPELL",
							["event"] = "Health",
							["unit"] = "player",
						},
						["untrigger"] = {
						},
					}, -- [2]
					["disjunctive"] = "any",
					["customTriggerLogic"] = "function(t)\n    if t[1] and t[3] then\n        aura_env.region:SetGlow(true)\n    elseif t[1] and t[2] then\n        aura_env.region:SetGlow(true)\n    else \n        aura_env.region:SetGlow(false)\n    end\n    return true\nend",
					["activeTriggerMode"] = 1,
				},
				["config"] = {
				},
				["inverse"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["keepAspectRatio"] = true,
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "buffed",
							["value"] = 0,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [1]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "buffed",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
							{
								["value"] = "ACShine",
								["property"] = "glowType",
							}, -- [2]
						},
					}, -- [2]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["T)Whfq7kkCc"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567277425,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["authorOptions"] = {
				},
				["yOffset"] = -55,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = false,
				["url"] = "https://wago.io/Eh5J56-nY/1",
				["icon"] = true,
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["desaturate"] = true,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 1,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["rotateText"] = "NONE",
						["text_fontSize"] = 12,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 25,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["glowLength"] = 10,
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["actions"] = {
					["start"] = {
					},
					["init"] = {
					},
					["finish"] = {
					},
				},
				["cooldownEdge"] = false,
				["selfPoint"] = "CENTER",
				["regionType"] = "icon",
				["config"] = {
				},
				["keepAspectRatio"] = false,
				["glowYOffset"] = 0,
				["alpha"] = 1,
				["xOffset"] = -29,
				["cooldownTextDisabled"] = false,
				["glowScale"] = 1,
				["auto"] = true,
				["zoom"] = 0,
				["useGlowColor"] = false,
				["tocversion"] = 11302,
				["id"] = "Shield Block",
				["anchorFrameType"] = "SCREEN",
				["frameStrata"] = 1,
				["width"] = 25,
				["parent"] = "Arms",
				["uid"] = "T)Whfq7kkCc",
				["inverse"] = false,
				["load"] = {
					["use_class"] = true,
					["use_spellknown"] = false,
					["talent"] = {
						["multi"] = {
							[21] = true,
							[19] = true,
						},
					},
					["spec"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["spellknown"] = 5283,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["triggers"] = {
					{
						["trigger"] = {
							["use_form"] = true,
							["matchesShowOn"] = "showAlways",
							["genericShowOn"] = "showAlways",
							["names"] = {
							},
							["debuffType"] = "HELPFUL",
							["type"] = "status",
							["duration"] = "1",
							["subeventSuffix"] = "_CAST_START",
							["unit"] = "player",
							["form"] = {
								["single"] = 1,
							},
							["event"] = "Cooldown Progress (Spell)",
							["use_genericShowOn"] = true,
							["realSpellName"] = "Shield Block",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["use_unit"] = true,
							["subeventPrefix"] = "SPELL",
							["unevent"] = "auto",
							["use_track"] = true,
							["spellName"] = 2565,
						},
						["untrigger"] = {
						},
					}, -- [1]
					{
						["trigger"] = {
							["type"] = "aura2",
							["auranames"] = {
								"Shield Block", -- [1]
							},
							["ownOnly"] = true,
							["event"] = "Health",
							["unit"] = "player",
							["useName"] = true,
							["spellIds"] = {
							},
							["names"] = {
							},
							["matchesShowOn"] = "showAlways",
							["subeventPrefix"] = "SPELL",
							["subeventSuffix"] = "_CAST_START",
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [2]
					{
						["trigger"] = {
							["use_form"] = true,
							["subeventSuffix"] = "_CAST_START",
							["duration"] = "1",
							["event"] = "Stance/Form/Aura",
							["subeventPrefix"] = "SPELL",
							["realSpellName"] = 0,
							["use_spellName"] = true,
							["unevent"] = "auto",
							["type"] = "status",
							["form"] = {
								["single"] = 2,
							},
							["use_unit"] = true,
							["unit"] = "player",
							["spellName"] = 0,
						},
						["untrigger"] = {
						},
					}, -- [3]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["duration"] = "1",
							["event"] = "Power",
							["use_unit"] = true,
							["powertype"] = 1,
							["subeventSuffix"] = "_CAST_START",
							["subeventPrefix"] = "SPELL",
							["use_powertype"] = true,
							["unit"] = "player",
						},
						["untrigger"] = {
						},
					}, -- [4]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 2,
							["op"] = "==",
							["variable"] = "buffed",
							["value"] = 0,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [1]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "AND",
							["checks"] = {
								{
									["trigger"] = 4,
									["op"] = ">=",
									["variable"] = "power",
									["value"] = "10",
								}, -- [1]
								{
									["trigger"] = 1,
									["variable"] = "spellUsable",
									["value"] = 1,
								}, -- [2]
							},
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
							{
								["value"] = false,
								["property"] = "desaturate",
							}, -- [2]
						},
					}, -- [2]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["3sPS1YjPbZ1"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201870,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["yOffset"] = -73,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["url"] = "https://wago.io/9EBTx7-J0/3",
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
						["custom"] = "",
						["do_custom"] = false,
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["keepAspectRatio"] = false,
				["selfPoint"] = "CENTER",
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 3,
				["subRegions"] = {
				},
				["height"] = 45,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["glowXOffset"] = 0,
				["cooldownEdge"] = false,
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["xOffset"] = 0,
				["triggers"] = {
					{
						["trigger"] = {
							["track"] = "auto",
							["auranames"] = {
								"215572", -- [1]
							},
							["duration"] = "1",
							["genericShowOn"] = "showAlways",
							["subeventPrefix"] = "SPELL",
							["use_tooltip"] = false,
							["unit"] = "player",
							["names"] = {
								"Frothing Berserker", -- [1]
							},
							["matchesShowOn"] = "showOnActive",
							["use_genericShowOn"] = true,
							["unevent"] = "auto",
							["buffShowOn"] = "showOnActive",
							["name"] = "Spell Reflection",
							["useName"] = true,
							["use_debuffClass"] = false,
							["subeventSuffix"] = "_CAST_START",
							["ownOnly"] = true,
							["type"] = "status",
							["event"] = "Cooldown Progress (Spell)",
							["useGroup_count"] = false,
							["realSpellName"] = "Execute",
							["use_spellName"] = true,
							["spellIds"] = {
								215572, -- [1]
							},
							["spellName"] = 20660,
							["debuffType"] = "HELPFUL",
							["combineMatches"] = "showLowest",
							["use_track"] = true,
							["use_unit"] = true,
						},
						["untrigger"] = {
							["genericShowOn"] = "showAlways",
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["regionType"] = "icon",
				["parent"] = "Warrior",
				["uid"] = "3sPS1YjPbZ1",
				["glowYOffset"] = 0,
				["width"] = 45,
				["alpha"] = 1,
				["glowLength"] = 10,
				["auto"] = true,
				["tocversion"] = 11302,
				["zoom"] = 0,
				["semver"] = "1.0.2",
				["glowScale"] = 1,
				["id"] = "Execute - Usable",
				["cooldownTextDisabled"] = false,
				["frameStrata"] = 1,
				["anchorFrameType"] = "SCREEN",
				["icon"] = true,
				["config"] = {
				},
				["inverse"] = false,
				["authorOptions"] = {
				},
				["load"] = {
					["ingroup"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 15,
						["multi"] = {
							[15] = true,
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["talent2"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["use_spec"] = true,
					["spec"] = {
						["single"] = 2,
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "spellUsable",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
							{
							}, -- [2]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "spellUsable",
							["value"] = 0,
						},
						["changes"] = {
							{
								["property"] = "alpha",
							}, -- [1]
						},
					}, -- [2]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["NH2He)NnhcY"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201870,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["yOffset"] = -162,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["cooldownEdge"] = false,
				["icon"] = true,
				["triggers"] = {
					{
						["trigger"] = {
							["auranames"] = {
								"Hamstring", -- [1]
							},
							["use_genericShowOn"] = true,
							["genericShowOn"] = "showAlways",
							["names"] = {
							},
							["unitExists"] = true,
							["unit"] = "target",
							["debuffType"] = "HARMFUL",
							["subeventPrefix"] = "SPELL",
							["useName"] = true,
							["unevent"] = "auto",
							["subeventSuffix"] = "_CAST_START",
							["use_showOn"] = true,
							["use_unit"] = true,
							["event"] = "Stance/Form/Aura",
							["type"] = "aura2",
							["realSpellName"] = "Hamstring",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["spellName"] = 7372,
							["matchesShowOn"] = "showAlways",
							["use_absorbMode"] = true,
							["use_track"] = true,
							["duration"] = "1",
						},
						["untrigger"] = {
							["showOn"] = "showAlways",
							["spellName"] = 2565,
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["internalVersion"] = 23,
				["keepAspectRatio"] = false,
				["selfPoint"] = "CENTER",
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 3,
				["subRegions"] = {
				},
				["height"] = 45,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["useglowColor"] = false,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
						["custom"] = "aura_env.region.stacks:SetPoint(\"BOTTOMRIGHT\", aura_env.region, \"BOTTOMRIGHT\", 0, 0)\naura_env.region.stacks:SetShadowOffset(1, -1)",
						["do_custom"] = false,
					},
				},
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["load"] = {
					["ingroup"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["talent2"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["use_spellknown"] = false,
					["faction"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_spec"] = true,
					["role"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["xOffset"] = 0,
				["glowXOffset"] = 0,
				["regionType"] = "icon",
				["url"] = "https://wago.io/9EBTx7-J0/3",
				["uid"] = "NH2He)NnhcY",
				["width"] = 45,
				["anchorFrameType"] = "SCREEN",
				["frameStrata"] = 1,
				["glowLength"] = 10,
				["auto"] = true,
				["glowScale"] = 1,
				["cooldownTextDisabled"] = false,
				["semver"] = "1.0.2",
				["tocversion"] = 11302,
				["id"] = "Hamstring",
				["zoom"] = 0,
				["alpha"] = 1,
				["glowYOffset"] = 0,
				["authorOptions"] = {
				},
				["config"] = {
				},
				["inverse"] = false,
				["parent"] = "Warrior",
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["op"] = "==",
							["variable"] = "matchCount",
							["value"] = "0",
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [1]
						},
					}, -- [1]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["O4zUI4DkWh1"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201685,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["parent"] = "ChUI - Debuff Tracker - Warrior",
				["yOffset"] = 0,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["url"] = "https://wago.io/Okky1Eh5g/1",
				["icon"] = true,
				["triggers"] = {
					{
						["trigger"] = {
							["useName"] = true,
							["auranames"] = {
								"Sunder Armor", -- [1]
							},
							["event"] = "Health",
							["unit"] = "target",
							["spellIds"] = {
							},
							["subeventPrefix"] = "SPELL",
							["subeventSuffix"] = "_CAST_START",
							["names"] = {
							},
							["type"] = "aura2",
							["debuffType"] = "HARMFUL",
						},
						["untrigger"] = {
						},
					}, -- [1]
					["activeTriggerMode"] = -10,
				},
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["animation"] = {
					["start"] = {
						["type"] = "preset",
						["preset"] = "slidebottom",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["type"] = "preset",
						["preset"] = "slidetop",
						["duration_type"] = "seconds",
					},
				},
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 1,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "2002 Bold",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["text_fontType"] = "OUTLINE",
						["rotateText"] = "NONE",
						["anchorXOffset"] = 0,
						["text_fontSize"] = 14,
					}, -- [1]
				},
				["height"] = 50,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["useglowColor"] = false,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["cooldownEdge"] = false,
				["regionType"] = "icon",
				["load"] = {
					["use_class"] = true,
					["use_combat"] = true,
					["spec"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["glowLength"] = 10,
				["uid"] = "O4zUI4DkWh1",
				["authorOptions"] = {
				},
				["width"] = 50,
				["alpha"] = 1,
				["xOffset"] = -110,
				["tocversion"] = 11302,
				["zoom"] = 0,
				["auto"] = true,
				["glowScale"] = 1,
				["id"] = "Warrior: SA UP",
				["cooldownTextDisabled"] = false,
				["frameStrata"] = 1,
				["glowYOffset"] = 0,
				["anchorFrameType"] = "SCREEN",
				["config"] = {
				},
				["inverse"] = false,
				["keepAspectRatio"] = false,
				["selfPoint"] = "CENTER",
				["conditions"] = {
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["J(Q5Fk1)bb4"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567277425,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["xOffset"] = 46,
				["yOffset"] = -89.000061035156,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = false,
				["url"] = "https://wago.io/Eh5J56-nY/1",
				["actions"] = {
					["start"] = {
					},
					["init"] = {
					},
					["finish"] = {
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["keepAspectRatio"] = false,
				["selfPoint"] = "CENTER",
				["desaturate"] = true,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 1,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["rotateText"] = "NONE",
						["text_fontSize"] = 12,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 40,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["triggers"] = {
					{
						["trigger"] = {
							["use_form"] = true,
							["matchesShowOn"] = "showAlways",
							["genericShowOn"] = "showAlways",
							["unit"] = "player",
							["debuffType"] = "HELPFUL",
							["type"] = "status",
							["spellName"] = 5283,
							["subeventSuffix"] = "_CAST_START",
							["subeventPrefix"] = "SPELL",
							["form"] = {
								["single"] = 1,
							},
							["event"] = "Cooldown Progress (Spell)",
							["use_unit"] = true,
							["realSpellName"] = "Execute",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["use_genericShowOn"] = true,
							["names"] = {
							},
							["unevent"] = "auto",
							["use_track"] = true,
							["duration"] = "1",
						},
						["untrigger"] = {
						},
					}, -- [1]
					{
						["trigger"] = {
							["type"] = "aura2",
							["subeventSuffix"] = "_CAST_START",
							["matchesShowOn"] = "showAlways",
							["event"] = "Health",
							["unit"] = "player",
							["ownOnly"] = true,
							["spellIds"] = {
							},
							["useName"] = true,
							["subeventPrefix"] = "SPELL",
							["names"] = {
							},
							["auranames"] = {
								"5283", -- [1]
							},
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [2]
					{
						["trigger"] = {
							["use_form"] = true,
							["subeventSuffix"] = "_CAST_START",
							["duration"] = "1",
							["event"] = "Stance/Form/Aura",
							["use_unit"] = true,
							["realSpellName"] = 0,
							["use_spellName"] = true,
							["unevent"] = "auto",
							["type"] = "status",
							["form"] = {
								["single"] = 1,
								["multi"] = {
									true, -- [1]
								},
							},
							["subeventPrefix"] = "SPELL",
							["unit"] = "player",
							["spellName"] = 0,
						},
						["untrigger"] = {
						},
					}, -- [3]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["duration"] = "1",
							["event"] = "Power",
							["subeventPrefix"] = "SPELL",
							["powertype"] = 1,
							["subeventSuffix"] = "_CAST_START",
							["unit"] = "player",
							["use_powertype"] = true,
							["use_unit"] = true,
						},
						["untrigger"] = {
						},
					}, -- [4]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["glowXOffset"] = 0,
				["parent"] = "Arms",
				["regionType"] = "icon",
				["uid"] = "J(Q5Fk1)bb4",
				["icon"] = true,
				["glowYOffset"] = 0,
				["frameStrata"] = 1,
				["authorOptions"] = {
				},
				["cooldownTextDisabled"] = false,
				["glowScale"] = 1,
				["useGlowColor"] = false,
				["zoom"] = 0,
				["auto"] = true,
				["tocversion"] = 11302,
				["id"] = "Execute",
				["glowLength"] = 10,
				["alpha"] = 1,
				["anchorFrameType"] = "SCREEN",
				["cooldownEdge"] = false,
				["config"] = {
				},
				["inverse"] = false,
				["load"] = {
					["use_class"] = true,
					["use_spellknown"] = false,
					["talent"] = {
						["multi"] = {
							[21] = true,
							[19] = true,
						},
					},
					["spec"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["spellknown"] = 5283,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["width"] = 40,
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 2,
							["op"] = "==",
							["variable"] = "buffed",
							["value"] = 0,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [1]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "AND",
							["checks"] = {
								{
									["trigger"] = 4,
									["op"] = ">=",
									["variable"] = "power",
									["value"] = "1",
								}, -- [1]
								{
									["trigger"] = 1,
									["variable"] = "spellUsable",
									["value"] = 1,
								}, -- [2]
							},
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
							{
								["value"] = false,
								["property"] = "desaturate",
							}, -- [2]
						},
					}, -- [2]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["MKclO6OxqhA"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567277425,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["authorOptions"] = {
				},
				["yOffset"] = -89.000061035156,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = false,
				["url"] = "https://wago.io/Eh5J56-nY/1",
				["icon"] = true,
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["desaturate"] = true,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 1,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["rotateText"] = "NONE",
						["text_fontSize"] = 12,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 40,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["glowLength"] = 10,
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["actions"] = {
					["start"] = {
					},
					["init"] = {
					},
					["finish"] = {
					},
				},
				["cooldownEdge"] = false,
				["selfPoint"] = "CENTER",
				["regionType"] = "icon",
				["config"] = {
				},
				["keepAspectRatio"] = false,
				["glowYOffset"] = 0,
				["alpha"] = 1,
				["xOffset"] = 46,
				["cooldownTextDisabled"] = false,
				["glowScale"] = 1,
				["auto"] = true,
				["zoom"] = 0,
				["useGlowColor"] = false,
				["tocversion"] = 11302,
				["id"] = "Shield Slam",
				["anchorFrameType"] = "SCREEN",
				["frameStrata"] = 1,
				["width"] = 40,
				["parent"] = "Arms",
				["uid"] = "MKclO6OxqhA",
				["inverse"] = false,
				["load"] = {
					["use_class"] = true,
					["use_spellknown"] = false,
					["talent"] = {
						["multi"] = {
							[21] = true,
							[19] = true,
						},
					},
					["spec"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["spellknown"] = 5283,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["triggers"] = {
					{
						["trigger"] = {
							["use_form"] = true,
							["matchesShowOn"] = "showAlways",
							["genericShowOn"] = "showAlways",
							["names"] = {
							},
							["debuffType"] = "HELPFUL",
							["type"] = "status",
							["duration"] = "1",
							["subeventSuffix"] = "_CAST_START",
							["unit"] = "player",
							["form"] = {
								["single"] = 1,
							},
							["event"] = "Cooldown Progress (Spell)",
							["use_genericShowOn"] = true,
							["realSpellName"] = 0,
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["use_unit"] = true,
							["subeventPrefix"] = "SPELL",
							["unevent"] = "auto",
							["use_track"] = true,
							["spellName"] = 0,
						},
						["untrigger"] = {
						},
					}, -- [1]
					{
						["trigger"] = {
							["type"] = "aura2",
							["auranames"] = {
								"Shield Slam", -- [1]
							},
							["ownOnly"] = true,
							["event"] = "Health",
							["unit"] = "player",
							["useName"] = true,
							["spellIds"] = {
							},
							["names"] = {
							},
							["matchesShowOn"] = "showAlways",
							["subeventPrefix"] = "SPELL",
							["subeventSuffix"] = "_CAST_START",
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [2]
					{
						["trigger"] = {
							["use_form"] = true,
							["subeventSuffix"] = "_CAST_START",
							["duration"] = "1",
							["event"] = "Stance/Form/Aura",
							["subeventPrefix"] = "SPELL",
							["realSpellName"] = 0,
							["use_spellName"] = true,
							["unevent"] = "auto",
							["type"] = "status",
							["form"] = {
								["single"] = 2,
								["multi"] = {
									true, -- [1]
								},
							},
							["use_unit"] = true,
							["unit"] = "player",
							["spellName"] = 0,
						},
						["untrigger"] = {
						},
					}, -- [3]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["duration"] = "1",
							["event"] = "Power",
							["use_unit"] = true,
							["powertype"] = 1,
							["subeventSuffix"] = "_CAST_START",
							["subeventPrefix"] = "SPELL",
							["use_powertype"] = true,
							["unit"] = "player",
						},
						["untrigger"] = {
						},
					}, -- [4]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 2,
							["op"] = "==",
							["variable"] = "buffed",
							["value"] = 0,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [1]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "AND",
							["checks"] = {
								{
									["trigger"] = 4,
									["op"] = ">=",
									["variable"] = "power",
									["value"] = "1",
								}, -- [1]
								{
									["trigger"] = 1,
									["variable"] = "spellUsable",
									["value"] = 1,
								}, -- [2]
							},
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
							{
								["value"] = false,
								["property"] = "desaturate",
							}, -- [2]
						},
					}, -- [2]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["zLHj98fOCac"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201870,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["authorOptions"] = {
				},
				["yOffset"] = -72.999755859375,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["url"] = "https://wago.io/9EBTx7-J0/3",
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
						["custom"] = "",
						["do_custom"] = false,
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 3,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 1,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["text_fontType"] = "OUTLINE",
						["rotateText"] = "NONE",
						["anchorXOffset"] = 0,
						["text_fontSize"] = 12,
					}, -- [1]
				},
				["height"] = 45,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["glowLength"] = 10,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["triggers"] = {
					{
						["trigger"] = {
							["useStacks"] = true,
							["useGroup_count"] = false,
							["matchesShowOn"] = "showOnActive",
							["use_specific_unit"] = false,
							["use_tooltip"] = false,
							["debuffType"] = "HELPFUL",
							["subeventPrefix"] = "SPELL",
							["useName"] = true,
							["use_debuffClass"] = false,
							["subeventSuffix"] = "_CAST_START",
							["unit"] = "player",
							["ownOnly"] = true,
							["event"] = "Health",
							["auranames"] = {
								"Shield Block", -- [1]
							},
							["type"] = "aura2",
							["name"] = "Spell Reflection",
							["spellIds"] = {
								248622, -- [1]
							},
							["buffShowOn"] = "showOnActive",
							["stacksOperator"] = ">",
							["combineMatches"] = "showLowest",
							["names"] = {
								"In For The Kill", -- [1]
							},
							["stacks"] = "0",
						},
						["untrigger"] = {
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["load"] = {
					["talent2"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 16,
						["multi"] = {
							[16] = true,
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["ingroup"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["use_spec"] = true,
					["spec"] = {
						["single"] = 1,
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["xOffset"] = 52.000732421875,
				["regionType"] = "icon",
				["selfPoint"] = "CENTER",
				["uid"] = "zLHj98fOCac",
				["width"] = 45,
				["anchorFrameType"] = "SCREEN",
				["alpha"] = 1,
				["keepAspectRatio"] = false,
				["auto"] = true,
				["tocversion"] = 11302,
				["cooldownTextDisabled"] = false,
				["semver"] = "1.0.2",
				["glowScale"] = 1,
				["id"] = "Shield Block - Buff",
				["zoom"] = 0,
				["frameStrata"] = 1,
				["glowYOffset"] = 0,
				["icon"] = true,
				["config"] = {
				},
				["inverse"] = false,
				["parent"] = "Warrior",
				["cooldownEdge"] = false,
				["conditions"] = {
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["ZamSJy1V18h"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201870,
			["allowUpdates"] = true,
			["data"] = {
				["backdropColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					0.5, -- [4]
				},
				["controlledChildren"] = {
				},
				["borderBackdrop"] = "Blizzard Tooltip",
				["scale"] = 1,
				["yOffset"] = -99.999938964844,
				["border"] = false,
				["borderEdge"] = "1 Pixel",
				["anchorPoint"] = "CENTER",
				["borderSize"] = 2,
				["xOffset"] = 0.00030517578125,
				["borderColor"] = {
					0, -- [1]
					0, -- [2]
					0, -- [3]
					1, -- [4]
				},
				["regionType"] = "group",
				["url"] = "https://wago.io/9EBTx7-J0/3",
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["triggers"] = {
					{
						["trigger"] = {
							["type"] = "aura",
							["subeventSuffix"] = "_CAST_START",
							["event"] = "Health",
							["unit"] = "player",
							["spellIds"] = {
							},
							["buffShowOn"] = "showOnActive",
							["names"] = {
							},
							["subeventPrefix"] = "SPELL",
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["internalVersion"] = 23,
				["borderOffset"] = 4,
				["semver"] = "1.0.2",
				["tocversion"] = 11302,
				["id"] = "Warrior",
				["uid"] = "ZamSJy1V18h",
				["frameStrata"] = 1,
				["anchorFrameType"] = "SCREEN",
				["borderInset"] = 1,
				["config"] = {
				},
				["version"] = 3,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["selfPoint"] = "BOTTOMLEFT",
				["conditions"] = {
				},
				["load"] = {
					["talent2"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["spec"] = {
						["multi"] = {
						},
					},
					["use_class"] = "true",
					["race"] = {
						["multi"] = {
						},
					},
					["ingroup"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["authorOptions"] = {
				},
			},
		},
		["Fzd5JTdjVri"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567277425,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["parent"] = "Arms",
				["yOffset"] = -55,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = false,
				["url"] = "https://wago.io/Eh5J56-nY/1",
				["icon"] = true,
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["selfPoint"] = "CENTER",
				["desaturate"] = true,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 1,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["rotateText"] = "NONE",
						["text_fontSize"] = 12,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 25,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["glowLength"] = 10,
				["glowType"] = "Pixel",
				["glowThickness"] = 1,
				["keepAspectRatio"] = false,
				["actions"] = {
					["start"] = {
						["do_glow"] = true,
						["glow_type"] = "Pixel",
					},
					["init"] = {
					},
					["finish"] = {
					},
				},
				["cooldownEdge"] = false,
				["regionType"] = "icon",
				["load"] = {
					["use_class"] = true,
					["spec"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["uid"] = "Fzd5JTdjVri",
				["glowScale"] = 1,
				["glowYOffset"] = 0,
				["alpha"] = 1,
				["authorOptions"] = {
				},
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["cooldownTextDisabled"] = false,
				["zoom"] = 0,
				["auto"] = true,
				["tocversion"] = 11302,
				["id"] = "Thunder Clap 2",
				["xOffset"] = -2,
				["frameStrata"] = 1,
				["width"] = 25,
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["config"] = {
				},
				["inverse"] = false,
				["anchorFrameType"] = "SCREEN",
				["triggers"] = {
					{
						["trigger"] = {
							["useName"] = true,
							["auranames"] = {
								"Thunder Clap", -- [1]
							},
							["ownOnly"] = true,
							["event"] = "Health",
							["unit"] = "target",
							["type"] = "aura2",
							["spellIds"] = {
							},
							["names"] = {
							},
							["matchesShowOn"] = "showAlways",
							["subeventPrefix"] = "SPELL",
							["subeventSuffix"] = "_CAST_START",
							["debuffType"] = "HARMFUL",
						},
						["untrigger"] = {
						},
					}, -- [1]
					{
						["trigger"] = {
							["auranames"] = {
								"Hamstring", -- [1]
							},
							["use_genericShowOn"] = true,
							["genericShowOn"] = "showAlways",
							["use_unit"] = true,
							["use_tooltip"] = false,
							["names"] = {
							},
							["subeventPrefix"] = "SPELL",
							["unevent"] = "auto",
							["buffShowOn"] = "showOnMissing",
							["useGroup_count"] = false,
							["type"] = "status",
							["use_debuffClass"] = false,
							["subeventSuffix"] = "_CAST_START",
							["useName"] = true,
							["matchesShowOn"] = "showOnMissing",
							["event"] = "Cooldown Progress (Spell)",
							["spellName"] = 8198,
							["realSpellName"] = "Thunder Clap",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["duration"] = "1",
							["unit"] = "target",
							["combineMatches"] = "showLowest",
							["use_track"] = true,
							["debuffType"] = "HARMFUL",
						},
						["untrigger"] = {
							["genericShowOn"] = "showAlways",
						},
					}, -- [2]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["duration"] = "1",
							["event"] = "Power",
							["unit"] = "player",
							["subeventPrefix"] = "SPELL",
							["powertype"] = 1,
							["spellIds"] = {
							},
							["names"] = {
							},
							["use_unit"] = true,
							["subeventSuffix"] = "_CAST_START",
							["use_powertype"] = true,
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [3]
					{
						["trigger"] = {
							["use_form"] = true,
							["unevent"] = "auto",
							["duration"] = "1",
							["event"] = "Stance/Form/Aura",
							["subeventPrefix"] = "SPELL",
							["use_unit"] = true,
							["type"] = "status",
							["subeventSuffix"] = "_CAST_START",
							["unit"] = "player",
							["form"] = {
								["single"] = 1,
							},
						},
						["untrigger"] = {
						},
					}, -- [4]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 3,
							["op"] = ">=",
							["variable"] = "power",
							["value"] = "20",
						},
						["changes"] = {
							{
								["property"] = "desaturate",
							}, -- [1]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "buffed",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
							{
								["value"] = false,
								["property"] = "desaturate",
							}, -- [2]
						},
					}, -- [2]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["d2183wcM2m0"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567202218,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = true,
				["authorOptions"] = {
				},
				["yOffset"] = 0,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["customTextUpdate"] = "update",
				["cooldownEdge"] = false,
				["icon"] = true,
				["triggers"] = {
					{
						["trigger"] = {
							["auranames"] = {
								"18765", -- [1]
							},
							["matchesShowOn"] = "showOnActive",
							["use_specific_unit"] = false,
							["use_tooltip"] = false,
							["debuffType"] = "HELPFUL",
							["useName"] = true,
							["use_debuffClass"] = false,
							["subeventSuffix"] = "_CAST_START",
							["event"] = "Health",
							["subeventPrefix"] = "SPELL",
							["ownOnly"] = true,
							["buffShowOn"] = "showOnActive",
							["spellIds"] = {
								18765, -- [1]
							},
							["useGroup_count"] = false,
							["type"] = "aura2",
							["combineMatches"] = "showLowest",
							["unit"] = "player",
							["names"] = {
								"Sweeping Strikes", -- [1]
							},
						},
						["untrigger"] = {
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["selfPoint"] = "CENTER",
				["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 32,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = " ",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["text_fontSize"] = 13,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 55,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["load"] = {
					["ingroup"] = {
						["multi"] = {
						},
					},
					["talent2"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 17,
						["multi"] = {
							[17] = true,
						},
					},
					["use_class"] = true,
					["spec"] = {
						["single"] = 1,
						["multi"] = {
							[2] = true,
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_vehicleUi"] = false,
					["faction"] = {
						["multi"] = {
						},
					},
					["use_spec"] = true,
					["use_petbattle"] = false,
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["url"] = "https://wago.io/SkBHabbrQ/32",
				["glowFrequency"] = 0.25,
				["displayIcon"] = "",
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["type"] = "preset",
						["preset"] = "alphaPulse",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["glowType"] = "ACShine",
				["glowThickness"] = 4,
				["stickyDuration"] = false,
				["glowLines"] = 8,
				["uid"] = "d2183wcM2m0",
				["regionType"] = "icon",
				["anchorFrameType"] = "SCREEN",
				["glowYOffset"] = 0,
				["alpha"] = 1,
				["xOffset"] = 116,
				["useglowColor"] = false,
				["glowLength"] = 10,
				["auto"] = true,
				["cooldownTextDisabled"] = false,
				["zoom"] = 0.33,
				["semver"] = "1.1.2",
				["glowScale"] = 1,
				["id"] = "Sweeping Strikes - Active",
				["parent"] = "Luxthos - Warrior Rotations",
				["frameStrata"] = 1,
				["width"] = 55,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["config"] = {
				},
				["inverse"] = false,
				["desaturate"] = false,
				["keepAspectRatio"] = true,
				["conditions"] = {
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["jnmJsMDe(6y"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201870,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["yOffset"] = -204.99984741211,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["cooldownEdge"] = false,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["keepAspectRatio"] = false,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 3,
				["subRegions"] = {
				},
				["height"] = 35,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["xOffset"] = -57.000061035156,
				["glowXOffset"] = 0,
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["glowLength"] = 10,
				["triggers"] = {
					{
						["trigger"] = {
							["use_genericShowOn"] = true,
							["genericShowOn"] = "showAlways",
							["subeventPrefix"] = "SPELL",
							["spellName"] = 5246,
							["type"] = "status",
							["debuffType"] = "HELPFUL",
							["subeventSuffix"] = "_CAST_START",
							["use_showOn"] = true,
							["unit"] = "player",
							["event"] = "Cooldown Progress (Spell)",
							["unevent"] = "auto",
							["realSpellName"] = "Intimidating Shout",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["names"] = {
							},
							["use_absorbMode"] = true,
							["use_unit"] = true,
							["use_track"] = true,
							["duration"] = "1",
						},
						["untrigger"] = {
							["showOn"] = "showAlways",
							["spellName"] = 5246,
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["authorOptions"] = {
				},
				["regionType"] = "icon",
				["parent"] = "Warrior",
				["uid"] = "jnmJsMDe(6y",
				["anchorFrameType"] = "SCREEN",
				["width"] = 35,
				["frameStrata"] = 1,
				["icon"] = true,
				["auto"] = true,
				["tocversion"] = 11302,
				["zoom"] = 0,
				["semver"] = "1.0.2",
				["glowScale"] = 1,
				["id"] = "Intimidating Shout",
				["cooldownTextDisabled"] = false,
				["alpha"] = 1,
				["glowYOffset"] = 0,
				["url"] = "https://wago.io/9EBTx7-J0/3",
				["config"] = {
				},
				["inverse"] = true,
				["load"] = {
					["talent2"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["ingroup"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["use_spec"] = true,
					["spec"] = {
						["single"] = 2,
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["selfPoint"] = "CENTER",
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "onCooldown",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = {
									0.43921568627451, -- [1]
									0.43921568627451, -- [2]
									0.43921568627451, -- [3]
									1, -- [4]
								},
								["property"] = "color",
							}, -- [1]
						},
					}, -- [1]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["JbxkwHSgmxP"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201870,
			["allowUpdates"] = true,
			["data"] = {
				["sparkWidth"] = 10,
				["sparkOffsetX"] = 0,
				["authorOptions"] = {
				},
				["yOffset"] = -105.99981689453,
				["anchorPoint"] = "CENTER",
				["sparkRotation"] = 0,
				["sparkRotationMode"] = "AUTO",
				["url"] = "https://wago.io/9EBTx7-J0/3",
				["backgroundColor"] = {
					0.31764705882353, -- [1]
					0.22745098039216, -- [2]
					0.16862745098039, -- [3]
					0.60000002384186, -- [4]
				},
				["triggers"] = {
					{
						["trigger"] = {
							["type"] = "status",
							["use_absorbMode"] = true,
							["unevent"] = "auto",
							["event"] = "Swing Timer",
							["duration"] = "1",
							["genericShowOn"] = "showOnActive",
							["unit"] = "player",
							["subeventSuffix"] = "_CAST_START",
							["use_unit"] = true,
							["spellIds"] = {
							},
							["use_hand"] = true,
							["subeventPrefix"] = "SPELL",
							["names"] = {
							},
							["hand"] = "main",
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [1]
					{
						["trigger"] = {
							["type"] = "status",
							["use_alwaystrue"] = true,
							["unevent"] = "auto",
							["use_absorbMode"] = true,
							["genericShowOn"] = "showOnActive",
							["unit"] = "player",
							["subeventPrefix"] = "SPELL",
							["subeventSuffix"] = "_CAST_START",
							["use_unit"] = true,
							["event"] = "Conditions",
							["duration"] = "1",
						},
						["untrigger"] = {
						},
					}, -- [2]
					["disjunctive"] = "any",
					["activeTriggerMode"] = -10,
				},
				["icon_color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["internalVersion"] = 23,
				["selfPoint"] = "CENTER",
				["backdropInFront"] = false,
				["desaturate"] = false,
				["barColor"] = {
					0.78039215686274, -- [1]
					0.61176470588235, -- [2]
					0.43137254901961, -- [3]
					1, -- [4]
				},
				["stickyDuration"] = false,
				["xOffset"] = 0,
				["fontFlags"] = "OUTLINE",
				["version"] = 3,
				["subRegions"] = {
					{
						["type"] = "aurabar_bar",
					}, -- [1]
					{
						["text_shadowXOffset"] = 1,
						["type"] = "subtext",
						["text_text"] = " ",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = -1,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = false,
						["text_anchorPoint"] = "INNER_RIGHT",
						["anchorYOffset"] = 0,
						["text_fontType"] = "None",
						["rotateText"] = "NONE",
						["anchorXOffset"] = 0,
						["text_fontSize"] = 12,
					}, -- [2]
					{
						["text_shadowXOffset"] = 1,
						["type"] = "subtext",
						["text_text"] = " ",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = -1,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = false,
						["text_anchorPoint"] = "INNER_LEFT",
						["anchorYOffset"] = 0,
						["text_fontType"] = "None",
						["rotateText"] = "NONE",
						["anchorXOffset"] = 0,
						["text_fontSize"] = 12,
					}, -- [3]
					{
						["text_shadowXOffset"] = 1,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = -1,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = false,
						["text_anchorPoint"] = "ICON_CENTER",
						["anchorYOffset"] = 0,
						["text_fontType"] = "None",
						["rotateText"] = "NONE",
						["anchorXOffset"] = 0,
						["text_fontSize"] = 12,
					}, -- [4]
					{
						["border_size"] = 1,
						["border_anchor"] = "bar",
						["type"] = "subborder",
						["border_color"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["border_visible"] = true,
						["border_edge"] = "1 Pixel",
						["border_offset"] = 1,
					}, -- [5]
				},
				["height"] = 15.000045776367,
				["borderBackdrop"] = "None",
				["load"] = {
					["talent2"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["ingroup"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["use_spec"] = true,
					["spec"] = {
						["single"] = 1,
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["sparkBlendMode"] = "ADD",
				["useAdjustededMax"] = false,
				["sparkOffsetY"] = 0,
				["uid"] = "JbxkwHSgmxP",
				["config"] = {
				},
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["anchorFrameType"] = "SCREEN",
				["alpha"] = 1,
				["useAdjustededMin"] = false,
				["regionType"] = "aurabar",
				["borderInFront"] = true,
				["backdropColor"] = {
					0, -- [1]
					0, -- [2]
					0, -- [3]
					1, -- [4]
				},
				["icon_side"] = "RIGHT",
				["sparkHidden"] = "NEVER",
				["zoom"] = 0,
				["sparkHeight"] = 30,
				["texture"] = "ElvUI Blank",
				["spark"] = false,
				["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
				["auto"] = true,
				["tocversion"] = 11302,
				["id"] = "Swing Timer",
				["semver"] = "1.0.2",
				["frameStrata"] = 1,
				["width"] = 244.99998474121,
				["icon"] = false,
				["sparkColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["inverse"] = false,
				["sparkDesature"] = false,
				["orientation"] = "HORIZONTAL",
				["conditions"] = {
				},
				["parent"] = "Warrior",
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
			},
		},
		["VhwjsfCnSz7"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567202218,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["xOffset"] = 58,
				["customText"] = "function()\n    return select(3, WA_GetUnitBuff(\"player\", 7384))\nend",
				["yOffset"] = 0,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["customTextUpdate"] = "update",
				["cooldownEdge"] = false,
				["icon"] = true,
				["triggers"] = {
					{
						["trigger"] = {
							["duration"] = "1",
							["genericShowOn"] = "showAlways",
							["use_unit"] = true,
							["use_showgcd"] = true,
							["powertype"] = 1,
							["spellName"] = 5308,
							["use_powertype"] = true,
							["debuffType"] = "HELPFUL",
							["subeventPrefix"] = "SPELL",
							["type"] = "status",
							["use_power"] = true,
							["unevent"] = "auto",
							["power_operator"] = ">=",
							["subeventSuffix"] = "_CAST_START",
							["event"] = "Cooldown Progress (Spell)",
							["use_exact_spellName"] = false,
							["realSpellName"] = "Execute",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["names"] = {
							},
							["use_genericShowOn"] = true,
							["use_absorbMode"] = true,
							["use_track"] = true,
							["unit"] = "player",
						},
						["untrigger"] = {
							["genericShowOn"] = "showAlways",
							["spellName"] = 184367,
						},
					}, -- [1]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["use_absorbMode"] = true,
							["event"] = "Action Usable",
							["unit"] = "player",
							["realSpellName"] = 5308,
							["use_spellName"] = true,
							["subeventPrefix"] = "SPELL",
							["use_exact_spellName"] = true,
							["subeventSuffix"] = "_CAST_START",
							["use_unit"] = true,
							["duration"] = "1",
							["spellName"] = 5308,
						},
						["untrigger"] = {
						},
					}, -- [2]
					{
						["trigger"] = {
							["useName"] = true,
							["auranames"] = {
								"184362", -- [1]
							},
							["matchesShowOn"] = "showAlways",
							["event"] = "Health",
							["unit"] = "player",
							["subeventPrefix"] = "SPELL",
							["type"] = "aura2",
							["subeventSuffix"] = "_CAST_START",
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [3]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["use_genericShowOn"] = true,
							["duration"] = "1",
							["genericShowOn"] = "showAlways",
							["unit"] = "player",
							["realSpellName"] = "Rampage",
							["use_spellName"] = true,
							["subeventSuffix"] = "_CAST_START",
							["use_unit"] = true,
							["event"] = "Cooldown Progress (Spell)",
							["subeventPrefix"] = "SPELL",
							["use_absorbMode"] = true,
							["spellName"] = 184367,
						},
						["untrigger"] = {
							["genericShowOn"] = "showAlways",
						},
					}, -- [4]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["use_absorbMode"] = true,
							["event"] = "Talent Known",
							["use_talent"] = true,
							["unit"] = "player",
							["subeventPrefix"] = "SPELL",
							["subeventSuffix"] = "_CAST_START",
							["use_unit"] = true,
							["talent"] = {
								["single"] = 13,
							},
							["duration"] = "1",
						},
						["untrigger"] = {
						},
					}, -- [5]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["duration"] = "1",
							["use_absorbMode"] = true,
							["genericShowOn"] = "showAlways",
							["unit"] = "player",
							["realSpellName"] = "Rampage",
							["use_spellName"] = true,
							["subeventSuffix"] = "_CAST_START",
							["use_unit"] = true,
							["event"] = "Cooldown Progress (Spell)",
							["subeventPrefix"] = "SPELL",
							["use_genericShowOn"] = true,
							["spellName"] = 184367,
						},
						["untrigger"] = {
							["genericShowOn"] = "showAlways",
						},
					}, -- [6]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["use_absorbMode"] = true,
							["event"] = "Power",
							["unit"] = "player",
							["powertype"] = 1,
							["subeventPrefix"] = "SPELL",
							["use_unit"] = true,
							["subeventSuffix"] = "_CAST_START",
							["use_powertype"] = true,
							["duration"] = "1",
						},
						["untrigger"] = {
						},
					}, -- [7]
					{
						["trigger"] = {
							["debuffType"] = "HELPFUL",
							["type"] = "aura2",
							["useName"] = true,
							["auranames"] = {
								"184362", -- [1]
							},
							["subeventSuffix"] = "_CAST_START",
							["subeventPrefix"] = "SPELL",
							["event"] = "Health",
							["unit"] = "player",
						},
						["untrigger"] = {
						},
					}, -- [8]
					["disjunctive"] = "any",
					["customTriggerLogic"] = "function(t)\n    if t[1] and t[3] then\n        aura_env.region:SetGlow(true)\n    elseif t[1] and t[2] then\n        aura_env.region:SetGlow(true)\n    else \n        aura_env.region:SetGlow(false)\n    end\n    return true\nend",
					["activeTriggerMode"] = 1,
				},
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["selfPoint"] = "CENTER",
				["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
				["progressPrecision"] = 0,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 32,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = " ",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["text_fontSize"] = 13,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 55,
				["url"] = "https://wago.io/SkBHabbrQ/32",
				["load"] = {
					["ingroup"] = {
						["multi"] = {
						},
					},
					["use_never"] = false,
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
							["WARRIOR"] = true,
						},
					},
					["use_class"] = true,
					["role"] = {
						["multi"] = {
						},
					},
					["use_spec"] = true,
					["size"] = {
						["multi"] = {
						},
					},
					["talent2"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 3,
						["multi"] = {
							[14] = true,
							[13] = true,
						},
					},
					["spec"] = {
						["single"] = 2,
						["multi"] = {
							true, -- [1]
							true, -- [2]
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["use_vehicleUi"] = false,
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["use_combat"] = true,
					["use_petbattle"] = false,
					["race"] = {
						["multi"] = {
						},
					},
				},
				["displayIcon"] = 132352,
				["glowFrequency"] = 0.25,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["stickyDuration"] = false,
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 4,
				["desaturate"] = false,
				["config"] = {
				},
				["glowLines"] = 8,
				["regionType"] = "icon",
				["glowYOffset"] = 0,
				["alpha"] = 1,
				["authorOptions"] = {
				},
				["anchorFrameType"] = "SCREEN",
				["glowLength"] = 10,
				["auto"] = true,
				["cooldownTextDisabled"] = false,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["zoom"] = 0.33,
				["semver"] = "1.1.2",
				["glowScale"] = 1,
				["id"] = "Execute Fury",
				["parent"] = "Luxthos - Warrior Rotations",
				["frameStrata"] = 1,
				["width"] = 55,
				["useglowColor"] = false,
				["uid"] = "VhwjsfCnSz7",
				["inverse"] = true,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["keepAspectRatio"] = true,
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "OR",
							["checks"] = {
								{
									["trigger"] = 1,
									["variable"] = "onCooldown",
									["value"] = 1,
								}, -- [1]
								{
									["trigger"] = 2,
									["variable"] = "show",
									["value"] = 0,
								}, -- [2]
							},
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [1]
							{
								["value"] = true,
								["property"] = "cooldownEdge",
							}, -- [2]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "AND",
							["checks"] = {
								{
									["trigger"] = 2,
									["variable"] = "show",
									["value"] = 1,
								}, -- [1]
								{
									["trigger"] = 3,
									["variable"] = "buffed",
									["value"] = 1,
								}, -- [2]
							},
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
						},
					}, -- [2]
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "AND",
							["checks"] = {
								{
									["trigger"] = 5,
									["variable"] = "show",
									["value"] = 0,
								}, -- [1]
								{
									["trigger"] = 6,
									["variable"] = "insufficientResources",
									["value"] = 0,
								}, -- [2]
							},
						},
						["changes"] = {
							{
								["property"] = "glow",
							}, -- [1]
						},
					}, -- [3]
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "AND",
							["checks"] = {
								{
									["trigger"] = 5,
									["variable"] = "show",
									["value"] = 1,
								}, -- [1]
								{
									["trigger"] = -2,
									["variable"] = "OR",
									["checks"] = {
										{
											["trigger"] = -2,
											["variable"] = "AND",
											["checks"] = {
												{
													["trigger"] = 8,
													["variable"] = "show",
													["value"] = 0,
												}, -- [1]
												{
													["trigger"] = 6,
													["variable"] = "insufficientResources",
													["value"] = 0,
												}, -- [2]
											},
										}, -- [1]
										{
											["trigger"] = 7,
											["op"] = ">=",
											["value"] = "90",
											["variable"] = "power",
										}, -- [2]
									},
								}, -- [2]
							},
						},
						["changes"] = {
							{
								["property"] = "glow",
							}, -- [1]
						},
					}, -- [4]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["3Kh7b5SPisQ"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201870,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["glowLength"] = 10,
				["yOffset"] = -162,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["cooldownEdge"] = false,
				["icon"] = true,
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 3,
				["subRegions"] = {
				},
				["height"] = 45,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["selfPoint"] = "CENTER",
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["triggers"] = {
					{
						["trigger"] = {
							["use_genericShowOn"] = true,
							["genericShowOn"] = "showAlways",
							["subeventPrefix"] = "SPELL",
							["spellName"] = 23881,
							["type"] = "status",
							["debuffType"] = "HELPFUL",
							["subeventSuffix"] = "_CAST_START",
							["use_showOn"] = true,
							["unit"] = "player",
							["event"] = "Cooldown Progress (Spell)",
							["unevent"] = "auto",
							["realSpellName"] = "Bloodthirst",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["names"] = {
							},
							["use_absorbMode"] = true,
							["use_unit"] = true,
							["use_track"] = true,
							["duration"] = "1",
						},
						["untrigger"] = {
							["showOn"] = "showAlways",
							["spellName"] = 12294,
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["load"] = {
					["ingroup"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 37,
						["multi"] = {
						},
					},
					["talent2"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_talent"] = true,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["use_spec"] = true,
					["spec"] = {
						["single"] = 1,
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["regionType"] = "icon",
				["url"] = "https://wago.io/9EBTx7-J0/3",
				["uid"] = "3Kh7b5SPisQ",
				["glowYOffset"] = 0,
				["anchorFrameType"] = "SCREEN",
				["frameStrata"] = 1,
				["parent"] = "Warrior",
				["auto"] = true,
				["tocversion"] = 11302,
				["zoom"] = 0,
				["semver"] = "1.0.2",
				["glowScale"] = 1,
				["id"] = "Bloodthirst",
				["cooldownTextDisabled"] = false,
				["alpha"] = 1,
				["width"] = 45,
				["authorOptions"] = {
				},
				["config"] = {
				},
				["inverse"] = true,
				["keepAspectRatio"] = false,
				["xOffset"] = -100,
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "onCooldown",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = {
									0.43921568627451, -- [1]
									0.43921568627451, -- [2]
									0.43921568627451, -- [3]
									1, -- [4]
								},
								["property"] = "color",
							}, -- [1]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "spellUsable",
							["value"] = 0,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [1]
							{
								["value"] = true,
								["property"] = "inverse",
							}, -- [2]
						},
					}, -- [2]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["yFE4Qj2huYm"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567202218,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["authorOptions"] = {
				},
				["yOffset"] = 0,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["customTextUpdate"] = "update",
				["cooldownEdge"] = false,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["triggers"] = {
					{
						["trigger"] = {
							["use_genericShowOn"] = true,
							["use_power"] = false,
							["names"] = {
								"Bone Shield", -- [1]
							},
							["rune"] = 0,
							["use_absorbMode"] = true,
							["genericShowOn"] = "showAlways",
							["use_unit"] = true,
							["use_showgcd"] = true,
							["powertype"] = 7,
							["use_runesCount"] = true,
							["duration"] = "1",
							["debuffType"] = "HELPFUL",
							["power"] = "0",
							["use_powertype"] = true,
							["spellName"] = 7384,
							["subeventSuffix"] = "_CAST_START",
							["type"] = "status",
							["use_requirePowerType"] = false,
							["unevent"] = "auto",
							["power_operator"] = ">",
							["runesCount_operator"] = ">=",
							["event"] = "Cooldown Progress (Spell)",
							["use_showOn"] = true,
							["realSpellName"] = "Overpower",
							["use_spellName"] = true,
							["spellIds"] = {
								266201, -- [1]
							},
							["ownOnly"] = true,
							["runesCount"] = "2",
							["unit"] = "player",
							["use_track"] = true,
							["subeventPrefix"] = "SPELL",
						},
						["untrigger"] = {
							["showOn"] = "showAlways",
							["spellName"] = 7384,
							["unit"] = "player",
						},
					}, -- [1]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["use_genericShowOn"] = true,
							["use_absorbMode"] = true,
							["genericShowOn"] = "showAlways",
							["subeventPrefix"] = "SPELL",
							["realSpellName"] = "Mortal Strike",
							["use_spellName"] = true,
							["subeventSuffix"] = "_CAST_START",
							["use_unit"] = true,
							["event"] = "Cooldown Progress (Spell)",
							["unit"] = "player",
							["duration"] = "1",
							["spellName"] = 12294,
						},
						["untrigger"] = {
							["genericShowOn"] = "showAlways",
						},
					}, -- [2]
					{
						["trigger"] = {
							["type"] = "status",
							["talent"] = {
								["single"] = 7,
							},
							["duration"] = "1",
							["event"] = "Talent Known",
							["use_talent"] = true,
							["unit"] = "player",
							["use_absorbMode"] = true,
							["subeventSuffix"] = "_CAST_START",
							["use_unit"] = true,
							["subeventPrefix"] = "SPELL",
							["unevent"] = "auto",
						},
						["untrigger"] = {
						},
					}, -- [3]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["duration"] = "1",
							["event"] = "Health",
							["use_unit"] = true,
							["unit"] = "target",
							["subeventPrefix"] = "SPELL",
							["subeventSuffix"] = "_CAST_START",
							["use_absorbMode"] = true,
						},
						["untrigger"] = {
							["unit"] = "target",
						},
					}, -- [4]
					["disjunctive"] = "any",
					["customTriggerLogic"] = "",
					["activeTriggerMode"] = -10,
				},
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["selfPoint"] = "CENTER",
				["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
				["progressPrecision"] = 0,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 32,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["text_fontSize"] = 13,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 55,
				["url"] = "https://wago.io/SkBHabbrQ/32",
				["load"] = {
					["use_petbattle"] = false,
					["use_never"] = false,
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["use_class"] = true,
					["role"] = {
						["multi"] = {
						},
					},
					["use_spec"] = true,
					["size"] = {
						["multi"] = {
						},
					},
					["talent2"] = {
						["single"] = 9,
						["multi"] = {
							[9] = true,
						},
					},
					["talent"] = {
						["single"] = 20,
						["multi"] = {
							[20] = true,
							[3] = true,
						},
					},
					["spec"] = {
						["single"] = 1,
						["multi"] = {
							true, -- [1]
							true, -- [2]
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_vehicleUi"] = false,
					["use_combat"] = true,
					["race"] = {
						["multi"] = {
						},
					},
					["ingroup"] = {
						["multi"] = {
						},
					},
				},
				["displayIcon"] = 132355,
				["glowFrequency"] = 0.25,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["stickyDuration"] = false,
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 4,
				["parent"] = "Luxthos - Warrior Rotations",
				["config"] = {
				},
				["glowLines"] = 8,
				["regionType"] = "icon",
				["glowYOffset"] = 0,
				["frameStrata"] = 1,
				["width"] = 55,
				["useglowColor"] = false,
				["desaturate"] = false,
				["auto"] = true,
				["cooldownTextDisabled"] = false,
				["glowLength"] = 10,
				["zoom"] = 0.33,
				["semver"] = "1.1.2",
				["glowScale"] = 1,
				["id"] = "Overpower",
				["icon"] = true,
				["alpha"] = 1,
				["anchorFrameType"] = "SCREEN",
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["uid"] = "yFE4Qj2huYm",
				["inverse"] = true,
				["xOffset"] = -58,
				["keepAspectRatio"] = true,
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["op"] = "==",
							["value"] = "0",
							["variable"] = "charges",
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [1]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "AND",
							["checks"] = {
								{
									["trigger"] = 1,
									["op"] = ">=",
									["value"] = "1",
									["variable"] = "charges",
								}, -- [1]
								{
									["trigger"] = 3,
									["variable"] = "show",
									["value"] = 1,
								}, -- [2]
								{
									["trigger"] = 4,
									["op"] = ">=",
									["value"] = "35",
									["variable"] = "percenthealth",
								}, -- [3]
								{
									["trigger"] = 2,
									["variable"] = "onCooldown",
									["value"] = 1,
								}, -- [4]
							},
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
						},
					}, -- [2]
					{
						["check"] = {
							["trigger"] = -2,
							["op"] = ">=",
							["variable"] = "AND",
							["checks"] = {
								{
									["trigger"] = 1,
									["op"] = ">=",
									["value"] = "1",
									["variable"] = "charges",
								}, -- [1]
								{
									["trigger"] = 3,
									["variable"] = "show",
									["value"] = 0,
								}, -- [2]
								{
									["trigger"] = 4,
									["op"] = ">=",
									["value"] = "20",
									["variable"] = "percenthealth",
								}, -- [3]
								{
									["trigger"] = 2,
									["variable"] = "onCooldown",
									["value"] = 1,
								}, -- [4]
							},
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
						},
					}, -- [3]
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "AND",
							["checks"] = {
								{
									["trigger"] = 1,
									["op"] = ">=",
									["value"] = "1",
									["variable"] = "charges",
								}, -- [1]
								{
									["trigger"] = 3,
									["variable"] = "show",
									["value"] = 1,
								}, -- [2]
								{
									["trigger"] = 4,
									["op"] = "<",
									["value"] = "35",
									["variable"] = "percenthealth",
								}, -- [3]
							},
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
						},
					}, -- [4]
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "AND",
							["checks"] = {
								{
									["trigger"] = 1,
									["op"] = ">=",
									["value"] = "1",
									["variable"] = "charges",
								}, -- [1]
								{
									["trigger"] = 3,
									["variable"] = "show",
									["value"] = 0,
								}, -- [2]
								{
									["trigger"] = 4,
									["op"] = "<",
									["value"] = "20",
									["variable"] = "percenthealth",
								}, -- [3]
							},
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
						},
					}, -- [5]
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "onCooldown",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "cooldownEdge",
							}, -- [1]
						},
					}, -- [6]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["V)TOMWMcl8Z"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567277425,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["parent"] = "Arms",
				["yOffset"] = -55,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = false,
				["cooldownEdge"] = false,
				["actions"] = {
					["start"] = {
						["do_glow"] = true,
						["glow_type"] = "Pixel",
					},
					["init"] = {
					},
					["finish"] = {
					},
				},
				["triggers"] = {
					{
						["trigger"] = {
							["auranames"] = {
								"Hamstring", -- [1]
							},
							["duration"] = "1",
							["genericShowOn"] = "showAlways",
							["subeventPrefix"] = "SPELL",
							["debuffType"] = "HARMFUL",
							["type"] = "status",
							["spellName"] = 1715,
							["unevent"] = "auto",
							["unit"] = "target",
							["names"] = {
							},
							["event"] = "Cooldown Progress (Spell)",
							["use_genericShowOn"] = true,
							["realSpellName"] = "Hamstring",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["use_unit"] = true,
							["useName"] = true,
							["matchesShowOn"] = "showAlways",
							["use_track"] = true,
							["subeventSuffix"] = "_CAST_START",
						},
						["untrigger"] = {
							["genericShowOn"] = "showAlways",
						},
					}, -- [1]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["duration"] = "1",
							["use_showCost"] = false,
							["unit"] = "player",
							["powertype"] = 1,
							["subeventPrefix"] = "SPELL",
							["event"] = "Power",
							["use_unit"] = true,
							["subeventSuffix"] = "_CAST_START",
							["use_powertype"] = true,
							["use_requirePowerType"] = false,
						},
						["untrigger"] = {
						},
					}, -- [2]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["form"] = {
								["single"] = 1,
							},
							["event"] = "Stance/Form/Aura",
							["unit"] = "player",
							["use_unit"] = true,
							["use_form"] = true,
							["subeventSuffix"] = "_CAST_START",
							["duration"] = "1",
							["subeventPrefix"] = "SPELL",
						},
						["untrigger"] = {
						},
					}, -- [3]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["internalVersion"] = 23,
				["keepAspectRatio"] = false,
				["selfPoint"] = "CENTER",
				["desaturate"] = true,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 1,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["rotateText"] = "NONE",
						["text_fontSize"] = 12,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 25,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["useglowColor"] = false,
				["glowType"] = "Pixel",
				["glowThickness"] = 1,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["glowXOffset"] = 0,
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["regionType"] = "icon",
				["authorOptions"] = {
				},
				["config"] = {
				},
				["url"] = "https://wago.io/Eh5J56-nY/1",
				["glowYOffset"] = 0,
				["frameStrata"] = 1,
				["xOffset"] = -29,
				["cooldownTextDisabled"] = false,
				["glowScale"] = 1,
				["zoom"] = 0,
				["auto"] = true,
				["tocversion"] = 11302,
				["id"] = "Hamstring",
				["anchorFrameType"] = "SCREEN",
				["alpha"] = 1,
				["width"] = 25,
				["icon"] = true,
				["uid"] = "V)TOMWMcl8Z",
				["inverse"] = false,
				["glowLength"] = 10,
				["load"] = {
					["use_class"] = true,
					["spec"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = -1,
							["variable"] = "incombat",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = 1,
								["property"] = "alpha",
							}, -- [1]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = 3,
							["op"] = "==",
							["variable"] = "form",
							["value"] = 2,
						},
						["changes"] = {
							{
								["value"] = 1,
								["property"] = "alpha",
							}, -- [1]
						},
					}, -- [2]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["heJVZYyKgwT"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567277425,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["parent"] = "Arms",
				["yOffset"] = -55,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = false,
				["cooldownEdge"] = false,
				["icon"] = true,
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["desaturate"] = true,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 1,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["rotateText"] = "NONE",
						["text_fontSize"] = 12,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 25,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["glowLength"] = 10,
				["glowType"] = "Pixel",
				["glowThickness"] = 1,
				["keepAspectRatio"] = false,
				["actions"] = {
					["start"] = {
						["do_glow"] = true,
						["glow_type"] = "Pixel",
					},
					["init"] = {
					},
					["finish"] = {
					},
				},
				["selfPoint"] = "CENTER",
				["regionType"] = "icon",
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["uid"] = "heJVZYyKgwT",
				["zoom"] = 0,
				["glowYOffset"] = 0,
				["alpha"] = 1,
				["anchorFrameType"] = "SCREEN",
				["xOffset"] = -57,
				["glowScale"] = 1,
				["cooldownTextDisabled"] = false,
				["auto"] = true,
				["tocversion"] = 11302,
				["id"] = "Rend",
				["authorOptions"] = {
				},
				["frameStrata"] = 1,
				["width"] = 25,
				["load"] = {
					["use_class"] = true,
					["spec"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["config"] = {
				},
				["inverse"] = false,
				["triggers"] = {
					{
						["trigger"] = {
							["useName"] = true,
							["auranames"] = {
								"Rend", -- [1]
							},
							["ownOnly"] = true,
							["event"] = "Health",
							["unit"] = "target",
							["type"] = "aura2",
							["spellIds"] = {
							},
							["names"] = {
							},
							["matchesShowOn"] = "showAlways",
							["subeventPrefix"] = "SPELL",
							["subeventSuffix"] = "_CAST_START",
							["debuffType"] = "HARMFUL",
						},
						["untrigger"] = {
						},
					}, -- [1]
					{
						["trigger"] = {
							["useGroup_count"] = false,
							["matchesShowOn"] = "showOnMissing",
							["genericShowOn"] = "showAlways",
							["unit"] = "target",
							["use_tooltip"] = false,
							["duration"] = "1",
							["unevent"] = "auto",
							["names"] = {
							},
							["debuffType"] = "HARMFUL",
							["use_unit"] = true,
							["type"] = "status",
							["use_debuffClass"] = false,
							["subeventSuffix"] = "_CAST_START",
							["useName"] = true,
							["auranames"] = {
								"Hamstring", -- [1]
							},
							["event"] = "Cooldown Progress (Spell)",
							["spellName"] = 6546,
							["realSpellName"] = "Rend",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["buffShowOn"] = "showOnMissing",
							["use_genericShowOn"] = true,
							["combineMatches"] = "showLowest",
							["use_track"] = true,
							["subeventPrefix"] = "SPELL",
						},
						["untrigger"] = {
							["genericShowOn"] = "showAlways",
						},
					}, -- [2]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["duration"] = "1",
							["event"] = "Power",
							["unit"] = "player",
							["subeventPrefix"] = "SPELL",
							["powertype"] = 1,
							["spellIds"] = {
							},
							["names"] = {
							},
							["use_unit"] = true,
							["subeventSuffix"] = "_CAST_START",
							["use_powertype"] = true,
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [3]
					["disjunctive"] = "any",
					["activeTriggerMode"] = -10,
				},
				["url"] = "https://wago.io/Eh5J56-nY/1",
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 3,
							["op"] = ">=",
							["variable"] = "power",
							["value"] = "10",
						},
						["changes"] = {
							{
								["property"] = "desaturate",
							}, -- [1]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "buffed",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
							{
								["value"] = false,
								["property"] = "desaturate",
							}, -- [2]
						},
					}, -- [2]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["L3zu3Gye1Ug"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201870,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["glowLength"] = 10,
				["yOffset"] = -204.99984741211,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["cooldownEdge"] = false,
				["icon"] = true,
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["selfPoint"] = "CENTER",
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 3,
				["subRegions"] = {
				},
				["height"] = 35,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["authorOptions"] = {
				},
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
						["custom"] = "aura_env.region.stacks:SetJustifyH(\"CENTER\")\naura_env.region.stacks:SetPoint(\"BOTTOMRIGHT\", aura_env.region, \"BOTTOMRIGHT\", 0, 0)\naura_env.region.stacks:SetShadowOffset(1, -1)",
						["do_custom"] = false,
					},
				},
				["triggers"] = {
					{
						["trigger"] = {
							["auranames"] = {
								"Battle Shout", -- [1]
							},
							["use_absorbMode"] = true,
							["genericShowOn"] = "showAlways",
							["subeventPrefix"] = "SPELL",
							["use_unit"] = true,
							["debuffType"] = "HELPFUL",
							["unit"] = "player",
							["useName"] = true,
							["unevent"] = "auto",
							["subeventSuffix"] = "_CAST_START",
							["use_showOn"] = true,
							["spellName"] = 6544,
							["event"] = "Cooldown Progress (Spell)",
							["type"] = "aura2",
							["realSpellName"] = 6544,
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["matchesShowOn"] = "showAlways",
							["use_genericShowOn"] = true,
							["names"] = {
							},
							["use_track"] = true,
							["duration"] = "1",
						},
						["untrigger"] = {
							["showOn"] = "showAlways",
							["spellName"] = 6544,
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["keepAspectRatio"] = false,
				["regionType"] = "icon",
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["uid"] = "L3zu3Gye1Ug",
				["parent"] = "Warrior",
				["anchorFrameType"] = "SCREEN",
				["alpha"] = 1,
				["width"] = 35,
				["auto"] = true,
				["tocversion"] = 11302,
				["cooldownTextDisabled"] = false,
				["semver"] = "1.0.2",
				["glowScale"] = 1,
				["id"] = "Battle Shout",
				["zoom"] = 0,
				["frameStrata"] = 1,
				["glowYOffset"] = 0,
				["xOffset"] = -95,
				["config"] = {
				},
				["inverse"] = true,
				["load"] = {
					["ingroup"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["spec"] = {
						["single"] = 1,
						["multi"] = {
						},
					},
					["use_class"] = true,
					["race"] = {
						["multi"] = {
						},
					},
					["talent2"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["url"] = "https://wago.io/9EBTx7-J0/3",
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["op"] = "==",
							["variable"] = "matchCount",
							["value"] = "0",
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [1]
						},
					}, -- [1]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["sYKPdk2L4)i"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201870,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["yOffset"] = -204.99981689453,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["cooldownEdge"] = false,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["keepAspectRatio"] = false,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 3,
				["subRegions"] = {
				},
				["height"] = 35,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["xOffset"] = 56.999450683594,
				["glowXOffset"] = 0,
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["glowLength"] = 10,
				["triggers"] = {
					{
						["trigger"] = {
							["use_genericShowOn"] = true,
							["genericShowOn"] = "showAlways",
							["subeventPrefix"] = "SPELL",
							["spellName"] = 18499,
							["type"] = "status",
							["debuffType"] = "HELPFUL",
							["subeventSuffix"] = "_CAST_START",
							["use_showOn"] = true,
							["unit"] = "player",
							["event"] = "Cooldown Progress (Spell)",
							["unevent"] = "auto",
							["realSpellName"] = "Berserker Rage",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["names"] = {
							},
							["use_absorbMode"] = true,
							["use_unit"] = true,
							["use_track"] = true,
							["duration"] = "1",
						},
						["untrigger"] = {
							["showOn"] = "showAlways",
							["spellName"] = 18499,
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["authorOptions"] = {
				},
				["regionType"] = "icon",
				["parent"] = "Warrior",
				["uid"] = "sYKPdk2L4)i",
				["anchorFrameType"] = "SCREEN",
				["width"] = 35,
				["frameStrata"] = 1,
				["icon"] = true,
				["auto"] = true,
				["tocversion"] = 11302,
				["zoom"] = 0,
				["semver"] = "1.0.2",
				["glowScale"] = 1,
				["id"] = "Berserker Rage",
				["cooldownTextDisabled"] = false,
				["alpha"] = 1,
				["glowYOffset"] = 0,
				["url"] = "https://wago.io/9EBTx7-J0/3",
				["config"] = {
				},
				["inverse"] = true,
				["load"] = {
					["talent2"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["ingroup"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["use_spec"] = true,
					["spec"] = {
						["single"] = 2,
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["selfPoint"] = "CENTER",
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "onCooldown",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = {
									0.43921568627451, -- [1]
									0.43921568627451, -- [2]
									0.43921568627451, -- [3]
									1, -- [4]
								},
								["property"] = "color",
							}, -- [1]
						},
					}, -- [1]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["N0sP7H9uOys"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567277425,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["parent"] = "Arms",
				["yOffset"] = -55,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = false,
				["cooldownEdge"] = false,
				["actions"] = {
					["start"] = {
						["do_glow"] = true,
						["glow_type"] = "Pixel",
					},
					["init"] = {
					},
					["finish"] = {
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["selfPoint"] = "CENTER",
				["desaturate"] = true,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 1,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["rotateText"] = "NONE",
						["text_fontSize"] = 12,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 25,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["glowType"] = "Pixel",
				["glowThickness"] = 1,
				["authorOptions"] = {
				},
				["url"] = "https://wago.io/Eh5J56-nY/1",
				["zoom"] = 0,
				["regionType"] = "icon",
				["load"] = {
					["use_class"] = true,
					["spec"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["config"] = {
				},
				["width"] = 25,
				["glowYOffset"] = 0,
				["alpha"] = 1,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["xOffset"] = -2,
				["glowScale"] = 1,
				["cooldownTextDisabled"] = false,
				["auto"] = true,
				["tocversion"] = 11302,
				["id"] = "Shield Bash",
				["icon"] = true,
				["frameStrata"] = 1,
				["anchorFrameType"] = "SCREEN",
				["keepAspectRatio"] = false,
				["uid"] = "N0sP7H9uOys",
				["inverse"] = false,
				["glowLength"] = 10,
				["triggers"] = {
					{
						["trigger"] = {
							["auranames"] = {
								"Hamstring", -- [1]
							},
							["duration"] = "1",
							["genericShowOn"] = "showAlways",
							["use_unit"] = true,
							["debuffType"] = "HARMFUL",
							["type"] = "status",
							["spellName"] = 72,
							["unevent"] = "auto",
							["subeventPrefix"] = "SPELL",
							["unit"] = "target",
							["event"] = "Cooldown Progress (Spell)",
							["names"] = {
							},
							["realSpellName"] = "Shield Bash",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["use_genericShowOn"] = true,
							["useName"] = true,
							["matchesShowOn"] = "showAlways",
							["use_track"] = true,
							["subeventSuffix"] = "_CAST_START",
						},
						["untrigger"] = {
							["genericShowOn"] = "showAlways",
						},
					}, -- [1]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["duration"] = "1",
							["use_showCost"] = false,
							["unit"] = "player",
							["powertype"] = 1,
							["subeventPrefix"] = "SPELL",
							["event"] = "Power",
							["use_unit"] = true,
							["subeventSuffix"] = "_CAST_START",
							["use_powertype"] = true,
							["use_requirePowerType"] = false,
						},
						["untrigger"] = {
						},
					}, -- [2]
					{
						["trigger"] = {
							["use_form"] = true,
							["unevent"] = "auto",
							["duration"] = "1",
							["event"] = "Stance/Form/Aura",
							["unit"] = "player",
							["subeventPrefix"] = "SPELL",
							["use_unit"] = true,
							["type"] = "status",
							["subeventSuffix"] = "_CAST_START",
							["form"] = {
								["single"] = 2,
							},
						},
						["untrigger"] = {
						},
					}, -- [3]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = -1,
							["variable"] = "incombat",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = 1,
								["property"] = "alpha",
							}, -- [1]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = 3,
							["op"] = "==",
							["variable"] = "form",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = 1,
								["property"] = "alpha",
							}, -- [1]
						},
					}, -- [2]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["001p0JRySTa"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567202218,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["authorOptions"] = {
				},
				["customText"] = "function()\n    return select(3, WA_GetUnitBuff(\"player\", 7384))\nend",
				["yOffset"] = 0,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["customTextUpdate"] = "update",
				["cooldownEdge"] = false,
				["icon"] = true,
				["triggers"] = {
					{
						["trigger"] = {
							["track"] = "auto",
							["use_absorbMode"] = true,
							["genericShowOn"] = "showAlways",
							["use_unit"] = true,
							["use_showgcd"] = false,
							["powertype"] = 1,
							["use_powertype"] = true,
							["debuffType"] = "HELPFUL",
							["type"] = "status",
							["subeventPrefix"] = "SPELL",
							["subeventSuffix"] = "_CAST_START",
							["use_showOn"] = true,
							["unit"] = "player",
							["event"] = "Cooldown Progress (Spell)",
							["unevent"] = "auto",
							["realSpellName"] = "Shield Block",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["duration"] = "1",
							["use_genericShowOn"] = true,
							["spellName"] = 2565,
							["use_track"] = true,
							["names"] = {
							},
						},
						["untrigger"] = {
							["showOn"] = "showAlways",
							["spellName"] = 2565,
						},
					}, -- [1]
					{
						["trigger"] = {
							["useName"] = true,
							["auranames"] = {
								"132404", -- [1]
							},
							["matchesShowOn"] = "showAlways",
							["event"] = "Health",
							["unit"] = "player",
							["subeventPrefix"] = "SPELL",
							["type"] = "aura2",
							["subeventSuffix"] = "_CAST_START",
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [2]
					{
						["trigger"] = {
							["useName"] = true,
							["auranames"] = {
								"12975", -- [1]
							},
							["use_absorbMode"] = true,
							["event"] = "Health",
							["unit"] = "player",
							["matchesShowOn"] = "showOnActive",
							["type"] = "aura2",
							["subeventSuffix"] = "_CAST_START",
							["subeventPrefix"] = "SPELL",
							["use_unit"] = true,
							["duration"] = "1",
							["unevent"] = "auto",
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [3]
					{
						["trigger"] = {
							["type"] = "status",
							["talent"] = {
								["single"] = 12,
							},
							["use_absorbMode"] = true,
							["event"] = "Talent Known",
							["unit"] = "player",
							["duration"] = "1",
							["subeventPrefix"] = "SPELL",
							["subeventSuffix"] = "_CAST_START",
							["use_unit"] = true,
							["use_talent"] = true,
							["unevent"] = "auto",
						},
						["untrigger"] = {
						},
					}, -- [4]
					["disjunctive"] = "any",
					["customTriggerLogic"] = "function(t)\n    if t[2] and t[3] and t[5] then\n        aura_env.region:SetGlow(true)\n    elseif t[2] and t[4] and t[5] then\n        aura_env.region:SetGlow(true)\n    else \n        aura_env.region:SetGlow(false)\n    end\n    return t[1]\nend",
					["activeTriggerMode"] = 1,
				},
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["selfPoint"] = "CENTER",
				["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 32,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["text_fontSize"] = 13,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 55,
				["url"] = "https://wago.io/SkBHabbrQ/32",
				["load"] = {
					["use_petbattle"] = false,
					["use_never"] = false,
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["use_class"] = true,
					["role"] = {
						["multi"] = {
						},
					},
					["use_spec"] = true,
					["size"] = {
						["multi"] = {
						},
					},
					["talent2"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 3,
						["multi"] = {
							[9] = true,
							[8] = true,
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							true, -- [1]
							true, -- [2]
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["use_vehicleUi"] = false,
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["use_combat"] = true,
					["race"] = {
						["multi"] = {
						},
					},
					["ingroup"] = {
						["multi"] = {
						},
					},
				},
				["displayIcon"] = 136012,
				["glowFrequency"] = 0.25,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["type"] = "custom",
						["colorR"] = 1,
						["scaley"] = 1,
						["duration_type"] = "seconds",
						["y"] = 0,
						["scalex"] = 1,
						["alpha"] = 0.3,
						["x"] = 0,
						["alphaType"] = "custom",
						["colorB"] = 1,
						["colorG"] = 1,
						["alphaFunc"] = "function(progress, start, delta)\n    if WeakAuras.GetActiveConditions(aura_env.id,aura_env.cloneId)[2] then\n        local angle = (progress * 2 * math.pi) - (math.pi / 2)\n        return start + (((math.sin(angle) + 1)/2) * delta)\n    end\nend",
						["colorA"] = 1,
						["rotate"] = 0,
						["duration"] = "0.7",
						["use_alpha"] = true,
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["stickyDuration"] = false,
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 4,
				["glowLength"] = 10,
				["config"] = {
				},
				["glowLines"] = 8,
				["regionType"] = "icon",
				["glowYOffset"] = 0,
				["alpha"] = 1,
				["anchorFrameType"] = "SCREEN",
				["progressPrecision"] = 0,
				["xOffset"] = 0,
				["auto"] = true,
				["cooldownTextDisabled"] = false,
				["parent"] = "Luxthos - Warrior Rotations",
				["zoom"] = 0.33,
				["semver"] = "1.1.2",
				["glowScale"] = 1,
				["id"] = "Shield Block",
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["frameStrata"] = 2,
				["width"] = 55,
				["useglowColor"] = false,
				["uid"] = "001p0JRySTa",
				["inverse"] = true,
				["desaturate"] = false,
				["keepAspectRatio"] = true,
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["op"] = "==",
							["value"] = "0",
							["variable"] = "charges",
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [1]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = 2,
							["variable"] = "buffed",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
							{
								["value"] = "ACShine",
								["property"] = "glowType",
							}, -- [2]
						},
					}, -- [2]
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "onCooldown",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "cooldownEdge",
							}, -- [1]
						},
					}, -- [3]
					{
						["check"] = {
							["trigger"] = 1,
							["op"] = "<",
							["value"] = 1,
							["variable"] = "insufficientResources",
						},
						["changes"] = {
							{
								["value"] = {
									0.31764705882353, -- [1]
									0.40392156862745, -- [2]
									0.78039215686274, -- [3]
									1, -- [4]
								},
								["property"] = "color",
							}, -- [1]
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [2]
						},
					}, -- [4]
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "AND",
							["checks"] = {
								{
									["trigger"] = 1,
									["op"] = ">=",
									["value"] = "1",
									["variable"] = "charges",
								}, -- [1]
								{
									["trigger"] = 1,
									["variable"] = "insufficientResources",
									["value"] = 0,
								}, -- [2]
								{
									["trigger"] = 2,
									["variable"] = "buffed",
									["value"] = 0,
								}, -- [3]
								{
									["trigger"] = -2,
									["variable"] = "OR",
									["checks"] = {
										{
											["trigger"] = -2,
											["variable"] = "AND",
											["checks"] = {
												{
													["trigger"] = 3,
													["variable"] = "show",
													["value"] = 0,
												}, -- [1]
												{
													["trigger"] = 4,
													["variable"] = "show",
													["value"] = 1,
												}, -- [2]
											},
										}, -- [1]
										{
											["trigger"] = -2,
											["variable"] = "AND",
											["checks"] = {
												{
													["trigger"] = 4,
													["variable"] = "show",
													["value"] = 0,
												}, -- [1]
											},
										}, -- [2]
									},
								}, -- [4]
							},
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
							{
								["value"] = "buttonOverlay",
								["property"] = "glowType",
							}, -- [2]
						},
					}, -- [5]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["sbF1Cfn)q1A"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201870,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["authorOptions"] = {
				},
				["yOffset"] = -76,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["url"] = "https://wago.io/9EBTx7-J0/3",
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
						["custom"] = "\n\n",
						["do_custom"] = false,
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 3,
				["subRegions"] = {
				},
				["height"] = 45,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["glowLength"] = 10,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["triggers"] = {
					{
						["trigger"] = {
							["useGroup_count"] = false,
							["ownOnly"] = true,
							["names"] = {
								"Sweeping Strikes", -- [1]
							},
							["use_tooltip"] = false,
							["debuffType"] = "HELPFUL",
							["useName"] = true,
							["use_debuffClass"] = false,
							["subeventSuffix"] = "_CAST_START",
							["event"] = "Health",
							["buffShowOn"] = "showOnActive",
							["matchesShowOn"] = "showOnActive",
							["spellIds"] = {
								260708, -- [1]
							},
							["type"] = "aura2",
							["auranames"] = {
								"Sweeping Strikes", -- [1]
							},
							["combineMatches"] = "showLowest",
							["unit"] = "player",
							["subeventPrefix"] = "SPELL",
						},
						["untrigger"] = {
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["load"] = {
					["ingroup"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 13,
						["multi"] = {
							[16] = true,
						},
					},
					["talent2"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_talent"] = true,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["use_spec"] = true,
					["spec"] = {
						["single"] = 1,
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["xOffset"] = 100.00048828125,
				["regionType"] = "icon",
				["selfPoint"] = "CENTER",
				["uid"] = "sbF1Cfn)q1A",
				["width"] = 45,
				["anchorFrameType"] = "SCREEN",
				["alpha"] = 1,
				["keepAspectRatio"] = false,
				["auto"] = true,
				["tocversion"] = 11302,
				["cooldownTextDisabled"] = false,
				["semver"] = "1.0.2",
				["glowScale"] = 1,
				["id"] = "Sweeping Strikes - Buff",
				["zoom"] = 0,
				["frameStrata"] = 1,
				["glowYOffset"] = 0,
				["icon"] = true,
				["config"] = {
				},
				["inverse"] = false,
				["parent"] = "Warrior",
				["cooldownEdge"] = false,
				["conditions"] = {
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["UBw0u7E8iRy"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201685,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["parent"] = "ChUI - Debuff Tracker - Warrior",
				["yOffset"] = 0,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["url"] = "https://wago.io/Okky1Eh5g/1",
				["icon"] = true,
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["animation"] = {
					["start"] = {
						["type"] = "preset",
						["preset"] = "slidebottom",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["type"] = "preset",
						["preset"] = "slidetop",
						["duration_type"] = "seconds",
					},
				},
				["desaturate"] = true,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 1,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = false,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["text_fontType"] = "OUTLINE",
						["rotateText"] = "NONE",
						["anchorXOffset"] = 0,
						["text_fontSize"] = 12,
					}, -- [1]
				},
				["height"] = 50,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["glowLength"] = 10,
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["selfPoint"] = "CENTER",
				["authorOptions"] = {
				},
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["regionType"] = "icon",
				["triggers"] = {
					{
						["trigger"] = {
							["useName"] = true,
							["auranames"] = {
								"Sunder Armor", -- [1]
							},
							["matchesShowOn"] = "showOnMissing",
							["event"] = "Health",
							["names"] = {
							},
							["spellIds"] = {
							},
							["subeventPrefix"] = "SPELL",
							["unit"] = "target",
							["subeventSuffix"] = "_CAST_START",
							["type"] = "aura2",
							["debuffType"] = "HARMFUL",
						},
						["untrigger"] = {
						},
					}, -- [1]
					["activeTriggerMode"] = -10,
				},
				["keepAspectRatio"] = false,
				["uid"] = "UBw0u7E8iRy",
				["load"] = {
					["use_class"] = true,
					["use_never"] = true,
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["use_combat"] = true,
					["spec"] = {
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["glowYOffset"] = 0,
				["frameStrata"] = 1,
				["width"] = 50,
				["tocversion"] = 11302,
				["zoom"] = 0,
				["auto"] = true,
				["glowScale"] = 1,
				["id"] = "Warrior: SA DOWN",
				["cooldownTextDisabled"] = false,
				["alpha"] = 1,
				["anchorFrameType"] = "SCREEN",
				["xOffset"] = -110,
				["config"] = {
				},
				["inverse"] = false,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					0.48225158452988, -- [4]
				},
				["cooldownEdge"] = false,
				["conditions"] = {
				},
				["cooldown"] = false,
				["glowBorder"] = false,
			},
		},
		["UR6aFO57kPH"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567277425,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["parent"] = "Arms",
				["yOffset"] = -68.14,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = false,
				["url"] = "https://wago.io/Eh5J56-nY/1",
				["icon"] = true,
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["desaturate"] = true,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 1,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["rotateText"] = "NONE",
						["text_fontSize"] = 12,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 48,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["glowType"] = "Pixel",
				["glowThickness"] = 1,
				["triggers"] = {
					{
						["trigger"] = {
							["auranames"] = {
								"Hamstring", -- [1]
							},
							["matchesShowOn"] = "showAlways",
							["genericShowOn"] = "showAlways",
							["names"] = {
							},
							["debuffType"] = "HARMFUL",
							["useName"] = true,
							["duration"] = "1",
							["unevent"] = "auto",
							["unit"] = "target",
							["use_genericShowOn"] = true,
							["event"] = "Cooldown Progress (Spell)",
							["spellName"] = 355,
							["realSpellName"] = "Taunt",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["use_unit"] = true,
							["type"] = "status",
							["subeventPrefix"] = "SPELL",
							["use_track"] = true,
							["subeventSuffix"] = "_CAST_START",
						},
						["untrigger"] = {
							["genericShowOn"] = "showAlways",
						},
					}, -- [1]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["duration"] = "1",
							["use_showCost"] = false,
							["unit"] = "player",
							["powertype"] = 1,
							["subeventPrefix"] = "SPELL",
							["subeventSuffix"] = "_CAST_START",
							["use_unit"] = true,
							["event"] = "Power",
							["use_powertype"] = true,
							["use_requirePowerType"] = false,
						},
						["untrigger"] = {
						},
					}, -- [2]
					{
						["trigger"] = {
							["use_form"] = true,
							["unevent"] = "auto",
							["duration"] = "1",
							["event"] = "Stance/Form/Aura",
							["subeventPrefix"] = "SPELL",
							["use_unit"] = true,
							["type"] = "status",
							["subeventSuffix"] = "_CAST_START",
							["unit"] = "player",
							["form"] = {
								["single"] = 2,
							},
						},
						["untrigger"] = {
						},
					}, -- [3]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["actions"] = {
					["start"] = {
						["do_glow"] = true,
						["glow_type"] = "Pixel",
					},
					["init"] = {
					},
					["finish"] = {
					},
				},
				["keepAspectRatio"] = false,
				["regionType"] = "icon",
				["cooldownEdge"] = false,
				["config"] = {
				},
				["selfPoint"] = "CENTER",
				["glowYOffset"] = 0,
				["alpha"] = 1,
				["width"] = 48,
				["cooldownTextDisabled"] = false,
				["glowScale"] = 1,
				["zoom"] = 0,
				["auto"] = true,
				["tocversion"] = 11302,
				["id"] = "Taunt",
				["authorOptions"] = {
				},
				["frameStrata"] = 1,
				["anchorFrameType"] = "SCREEN",
				["glowLength"] = 10,
				["uid"] = "UR6aFO57kPH",
				["inverse"] = false,
				["load"] = {
					["use_class"] = true,
					["spec"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["xOffset"] = -125.5,
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = -1,
							["variable"] = "incombat",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = 1,
								["property"] = "alpha",
							}, -- [1]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = 3,
							["op"] = "==",
							["variable"] = "form",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = 1,
								["property"] = "alpha",
							}, -- [1]
						},
					}, -- [2]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["A6yihryOJWy"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201685,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["parent"] = "ChUI - Debuff Tracker - Warrior",
				["yOffset"] = 0,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["url"] = "https://wago.io/Okky1Eh5g/1",
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["selfPoint"] = "CENTER",
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 1,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = false,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["text_fontType"] = "OUTLINE",
						["rotateText"] = "NONE",
						["anchorXOffset"] = 0,
						["text_fontSize"] = 12,
					}, -- [1]
				},
				["height"] = 50,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["animation"] = {
					["start"] = {
						["type"] = "preset",
						["preset"] = "slidebottom",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["type"] = "preset",
						["preset"] = "slidetop",
						["duration_type"] = "seconds",
					},
				},
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["keepAspectRatio"] = false,
				["triggers"] = {
					{
						["trigger"] = {
							["type"] = "aura2",
							["auranames"] = {
								"Rend", -- [1]
							},
							["ownOnly"] = true,
							["event"] = "Health",
							["unit"] = "target",
							["spellIds"] = {
							},
							["subeventPrefix"] = "SPELL",
							["names"] = {
							},
							["subeventSuffix"] = "_CAST_START",
							["useName"] = true,
							["debuffType"] = "HARMFUL",
						},
						["untrigger"] = {
						},
					}, -- [1]
					["activeTriggerMode"] = -10,
				},
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["regionType"] = "icon",
				["load"] = {
					["use_class"] = true,
					["use_combat"] = true,
					["spec"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["icon"] = true,
				["uid"] = "A6yihryOJWy",
				["xOffset"] = 0,
				["anchorFrameType"] = "SCREEN",
				["alpha"] = 1,
				["width"] = 50,
				["tocversion"] = 11302,
				["cooldownTextDisabled"] = false,
				["auto"] = true,
				["glowScale"] = 1,
				["id"] = "Warrior: Rend UP",
				["zoom"] = 0,
				["frameStrata"] = 1,
				["glowYOffset"] = 0,
				["authorOptions"] = {
				},
				["config"] = {
				},
				["inverse"] = false,
				["glowLength"] = 10,
				["cooldownEdge"] = false,
				["conditions"] = {
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["HqrgTWR5Xcc"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567202218,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["xOffset"] = -58,
				["customText"] = "function()\n    return select(3, WA_GetUnitBuff(\"player\", 7384))\nend",
				["yOffset"] = 0,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["customTextUpdate"] = "update",
				["cooldownEdge"] = false,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["selfPoint"] = "CENTER",
				["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["glowLength"] = 10,
				["version"] = 32,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = " ",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["text_fontSize"] = 13,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 55,
				["url"] = "https://wago.io/SkBHabbrQ/32",
				["load"] = {
					["use_petbattle"] = false,
					["use_never"] = false,
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["use_class"] = true,
					["role"] = {
						["multi"] = {
						},
					},
					["use_spec"] = true,
					["size"] = {
						["multi"] = {
						},
					},
					["talent2"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 3,
						["multi"] = {
							[9] = true,
							[8] = true,
						},
					},
					["spec"] = {
						["single"] = 3,
						["multi"] = {
							true, -- [1]
							true, -- [2]
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["use_vehicleUi"] = false,
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["use_combat"] = true,
					["race"] = {
						["multi"] = {
						},
					},
					["ingroup"] = {
						["multi"] = {
						},
					},
				},
				["displayIcon"] = 136012,
				["glowFrequency"] = 0.25,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["stickyDuration"] = false,
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 4,
				["authorOptions"] = {
				},
				["config"] = {
				},
				["glowLines"] = 8,
				["regionType"] = "icon",
				["glowYOffset"] = 0,
				["frameStrata"] = 3,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["triggers"] = {
					{
						["trigger"] = {
							["track"] = "auto",
							["use_absorbMode"] = true,
							["genericShowOn"] = "showAlways",
							["use_unit"] = true,
							["use_showgcd"] = true,
							["powertype"] = 1,
							["use_powertype"] = true,
							["debuffType"] = "HELPFUL",
							["type"] = "status",
							["subeventPrefix"] = "SPELL",
							["subeventSuffix"] = "_CAST_START",
							["use_showOn"] = true,
							["unit"] = "player",
							["event"] = "Cooldown Progress (Spell)",
							["unevent"] = "auto",
							["realSpellName"] = "Thunder Clap",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["duration"] = "1",
							["use_genericShowOn"] = true,
							["spellName"] = 6343,
							["use_track"] = true,
							["names"] = {
							},
						},
						["untrigger"] = {
							["showOn"] = "showAlways",
							["spellName"] = 6343,
						},
					}, -- [1]
					{
						["trigger"] = {
							["track"] = "auto",
							["type"] = "status",
							["use_absorbMode"] = true,
							["unevent"] = "auto",
							["use_unit"] = true,
							["duration"] = "1",
							["genericShowOn"] = "showAlways",
							["unit"] = "player",
							["realSpellName"] = "Shield Slam",
							["use_spellName"] = true,
							["subeventSuffix"] = "_CAST_START",
							["subeventPrefix"] = "SPELL",
							["event"] = "Cooldown Progress (Spell)",
							["use_genericShowOn"] = true,
							["use_track"] = true,
							["spellName"] = 23922,
						},
						["untrigger"] = {
							["genericShowOn"] = "showAlways",
						},
					}, -- [2]
					["disjunctive"] = "any",
					["customTriggerLogic"] = "function(t)\n    if t[2] and t[3] and t[5] then\n        aura_env.region:SetGlow(true)\n    elseif t[2] and t[4] and t[5] then\n        aura_env.region:SetGlow(true)\n    else \n        aura_env.region:SetGlow(false)\n    end\n    return t[1]\nend",
					["activeTriggerMode"] = 1,
				},
				["icon"] = true,
				["auto"] = true,
				["cooldownTextDisabled"] = false,
				["progressPrecision"] = 0,
				["zoom"] = 0.33,
				["semver"] = "1.1.2",
				["glowScale"] = 1,
				["id"] = "Thunder Clap",
				["desaturate"] = false,
				["alpha"] = 1,
				["anchorFrameType"] = "SCREEN",
				["width"] = 55,
				["uid"] = "HqrgTWR5Xcc",
				["inverse"] = true,
				["parent"] = "Luxthos - Warrior Rotations",
				["keepAspectRatio"] = true,
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "onCooldown",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [1]
							{
								["value"] = true,
								["property"] = "cooldownEdge",
							}, -- [2]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "AND",
							["checks"] = {
								{
									["trigger"] = 1,
									["variable"] = "onCooldown",
									["value"] = 0,
								}, -- [1]
								{
									["trigger"] = 2,
									["variable"] = "onCooldown",
									["value"] = 1,
								}, -- [2]
							},
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
						},
					}, -- [2]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["k9oMvzIfep1"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567202273,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["glowLength"] = 10,
				["yOffset"] = -89,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["cooldownEdge"] = false,
				["actions"] = {
					["start"] = {
						["do_glow"] = false,
						["glow_type"] = "ACShine",
						["glow_action"] = "show",
					},
					["finish"] = {
						["do_glow"] = false,
					},
					["init"] = {
					},
				},
				["triggers"] = {
					{
						["trigger"] = {
							["useName"] = true,
							["auranames"] = {
								"Heroic Strike", -- [1]
							},
							["matchesShowOn"] = "showAlways",
							["event"] = "Health",
							["unit"] = "player",
							["spellIds"] = {
							},
							["names"] = {
							},
							["type"] = "aura2",
							["subeventSuffix"] = "_CAST_START",
							["subeventPrefix"] = "SPELL",
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [1]
					{
						["trigger"] = {
							["auranames"] = {
								"Heroic Strike", -- [1]
							},
							["matchesShowOn"] = "showAlways",
							["genericShowOn"] = "showAlways",
							["unit"] = "player",
							["debuffType"] = "HELPFUL",
							["spellName"] = 284,
							["type"] = "status",
							["unevent"] = "auto",
							["subeventSuffix"] = "_CAST_START",
							["duration"] = "1",
							["use_unit"] = true,
							["event"] = "Cooldown Progress (Spell)",
							["subeventPrefix"] = "SPELL",
							["realSpellName"] = "Heroic Strike",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["useName"] = true,
							["names"] = {
							},
							["use_genericShowOn"] = true,
							["use_track"] = true,
							["ownOnly"] = true,
						},
						["untrigger"] = {
							["genericShowOn"] = "showAlways",
						},
					}, -- [2]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["duration"] = "1",
							["event"] = "Power",
							["use_unit"] = true,
							["powertype"] = 1,
							["unit"] = "player",
							["subeventPrefix"] = "SPELL",
							["use_powertype"] = true,
							["subeventSuffix"] = "_CAST_START",
						},
						["untrigger"] = {
						},
					}, -- [3]
					["disjunctive"] = "all",
					["activeTriggerMode"] = 1,
				},
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["desaturate"] = true,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 3,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["text_fontType"] = "OUTLINE",
						["rotateText"] = "NONE",
						["anchorXOffset"] = 0,
						["text_fontSize"] = 12,
					}, -- [1]
				},
				["height"] = 39.99995803833,
				["glowLines"] = 8,
				["useglowColor"] = false,
				["glowFrequency"] = 0.25,
				["url"] = "https://wago.io/JLiVMG_1s/3",
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["op"] = "==",
							["value"] = 0,
							["variable"] = "buffed",
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [1]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "OR",
							["checks"] = {
								{
									["trigger"] = 3,
									["op"] = ">=",
									["value"] = "15",
									["variable"] = "power",
								}, -- [1]
								{
									["trigger"] = 2,
									["variable"] = "spellUsable",
									["value"] = 1,
								}, -- [2]
							},
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
							{
								["value"] = false,
								["property"] = "desaturate",
							}, -- [2]
						},
					}, -- [2]
				},
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["load"] = {
					["use_class"] = true,
					["use_spellknown"] = false,
					["spec"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["spellknown"] = 284,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["selfPoint"] = "CENTER",
				["xOffset"] = -38,
				["regionType"] = "icon",
				["uid"] = "k9oMvzIfep1",
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["width"] = 40,
				["frameStrata"] = 1,
				["icon"] = true,
				["zoom"] = 0,
				["tocversion"] = 11302,
				["auto"] = false,
				["cooldownTextDisabled"] = false,
				["semver"] = "1.0.2",
				["glowScale"] = 1,
				["id"] = "Heroic Strike",
				["anchorFrameType"] = "SCREEN",
				["alpha"] = 1,
				["glowYOffset"] = 0,
				["authorOptions"] = {
				},
				["config"] = {
				},
				["inverse"] = false,
				["parent"] = "Arms",
				["keepAspectRatio"] = false,
				["displayIcon"] = 132282,
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["1eakFHu4lhc"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567277425,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["parent"] = "Arms",
				["yOffset"] = -67.141929208876,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = false,
				["url"] = "https://wago.io/Eh5J56-nY/1",
				["icon"] = true,
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["desaturate"] = true,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 1,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["rotateText"] = "NONE",
						["text_fontSize"] = 12,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 48,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["triggers"] = {
					{
						["trigger"] = {
							["debuffType"] = "HELPFUL",
							["type"] = "status",
							["subeventSuffix"] = "_CAST_START",
							["unevent"] = "auto",
							["use_genericShowOn"] = true,
							["duration"] = "1",
							["genericShowOn"] = "showAlways",
							["subeventPrefix"] = "SPELL",
							["realSpellName"] = "Charge",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["event"] = "Cooldown Progress (Spell)",
							["names"] = {
							},
							["unit"] = "player",
							["use_track"] = true,
							["spellName"] = 100,
						},
						["untrigger"] = {
						},
					}, -- [1]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["duration"] = "1",
							["event"] = "Stance/Form/Aura",
							["subeventPrefix"] = "SPELL",
							["powertype"] = 1,
							["form"] = {
								["single"] = 1,
							},
							["use_form"] = true,
							["use_unit"] = true,
							["subeventSuffix"] = "_CAST_START",
							["use_powertype"] = true,
							["unit"] = "player",
						},
						["untrigger"] = {
						},
					}, -- [2]
					["activeTriggerMode"] = -10,
				},
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["actions"] = {
					["start"] = {
					},
					["init"] = {
					},
					["finish"] = {
					},
				},
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["keepAspectRatio"] = false,
				["regionType"] = "icon",
				["xOffset"] = -125.50000536442,
				["uid"] = "1eakFHu4lhc",
				["glowLength"] = 10,
				["glowYOffset"] = 0,
				["frameStrata"] = 1,
				["authorOptions"] = {
				},
				["cooldownTextDisabled"] = false,
				["glowScale"] = 1,
				["zoom"] = 0,
				["auto"] = true,
				["tocversion"] = 11302,
				["id"] = "Charge",
				["selfPoint"] = "CENTER",
				["alpha"] = 1,
				["width"] = 48,
				["anchorFrameType"] = "SCREEN",
				["config"] = {
				},
				["inverse"] = false,
				["cooldownEdge"] = false,
				["load"] = {
					["use_class"] = true,
					["talent"] = {
						["multi"] = {
						},
					},
					["spec"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "AND",
							["checks"] = {
								{
									["trigger"] = 1,
									["variable"] = "spellInRange",
									["value"] = 1,
								}, -- [1]
								{
									["trigger"] = 1,
									["variable"] = "onCooldown",
									["value"] = 0,
								}, -- [2]
								{
									["trigger"] = 1,
									["variable"] = "spellUsable",
									["value"] = 1,
								}, -- [3]
							},
						},
						["changes"] = {
							{
								["property"] = "desaturate",
							}, -- [1]
						},
					}, -- [1]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["3ULYyioFzrz"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201870,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["authorOptions"] = {
				},
				["yOffset"] = -25,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["cooldownEdge"] = false,
				["icon"] = true,
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["keepAspectRatio"] = false,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 3,
				["subRegions"] = {
				},
				["height"] = 45,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
						["custom"] = "",
						["do_custom"] = false,
					},
				},
				["url"] = "https://wago.io/9EBTx7-J0/3",
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["triggers"] = {
					{
						["trigger"] = {
							["auranames"] = {
								"Shield Wall", -- [1]
							},
							["ownOnly"] = true,
							["use_specific_unit"] = false,
							["stacks"] = "0",
							["debuffType"] = "HELPFUL",
							["subeventPrefix"] = "SPELL",
							["useName"] = true,
							["stacksOperator"] = ">",
							["subeventSuffix"] = "_CAST_START",
							["names"] = {
								"In For The Kill", -- [1]
							},
							["unit"] = "player",
							["event"] = "Health",
							["matchesShowOn"] = "showOnActive",
							["type"] = "aura2",
							["spellIds"] = {
								248622, -- [1]
							},
							["name"] = "Spell Reflection",
							["use_debuffClass"] = false,
							["useGroup_count"] = false,
							["combineMatches"] = "showLowest",
							["use_tooltip"] = false,
							["buffShowOn"] = "showOnActive",
						},
						["untrigger"] = {
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["load"] = {
					["talent2"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 16,
						["multi"] = {
							[16] = true,
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["ingroup"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["use_spec"] = true,
					["spec"] = {
						["single"] = 1,
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["regionType"] = "icon",
				["xOffset"] = 100,
				["uid"] = "3ULYyioFzrz",
				["selfPoint"] = "CENTER",
				["width"] = 45,
				["frameStrata"] = 1,
				["anchorFrameType"] = "SCREEN",
				["auto"] = true,
				["glowScale"] = 1,
				["cooldownTextDisabled"] = false,
				["semver"] = "1.0.2",
				["tocversion"] = 11302,
				["id"] = "Shield Wall - Buff",
				["zoom"] = 0,
				["alpha"] = 1,
				["glowYOffset"] = 0,
				["glowXOffset"] = 0,
				["config"] = {
				},
				["inverse"] = false,
				["parent"] = "Warrior",
				["glowLength"] = 10,
				["conditions"] = {
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["BLnU21rzovH"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567202218,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = true,
				["authorOptions"] = {
				},
				["yOffset"] = 0,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["customTextUpdate"] = "update",
				["cooldownEdge"] = false,
				["icon"] = true,
				["triggers"] = {
					{
						["trigger"] = {
							["auranames"] = {
								"208086", -- [1]
							},
							["matchesShowOn"] = "showOnActive",
							["use_specific_unit"] = false,
							["use_tooltip"] = false,
							["debuffType"] = "HARMFUL",
							["type"] = "aura2",
							["use_debuffClass"] = false,
							["subeventSuffix"] = "_CAST_START",
							["event"] = "Health",
							["subeventPrefix"] = "SPELL",
							["unit"] = "target",
							["useGroup_count"] = false,
							["spellIds"] = {
								208086, -- [1]
							},
							["ownOnly"] = true,
							["useName"] = true,
							["combineMatches"] = "showLowest",
							["names"] = {
								"Colossus Smash", -- [1]
							},
							["buffShowOn"] = "showOnActive",
						},
						["untrigger"] = {
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["selfPoint"] = "CENTER",
				["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 32,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = " ",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["text_fontSize"] = 13,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 55,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["load"] = {
					["talent2"] = {
						["multi"] = {
						},
					},
					["use_petbattle"] = false,
					["spec"] = {
						["single"] = 1,
						["multi"] = {
							[2] = true,
						},
					},
					["talent"] = {
						["single"] = 17,
						["multi"] = {
							[17] = true,
						},
					},
					["use_vehicleUi"] = false,
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["use_spec"] = true,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["use_combat"] = true,
					["ingroup"] = {
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["url"] = "https://wago.io/SkBHabbrQ/32",
				["glowFrequency"] = 0.25,
				["displayIcon"] = "",
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["type"] = "preset",
						["preset"] = "alphaPulse",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["glowType"] = "ACShine",
				["glowThickness"] = 4,
				["stickyDuration"] = false,
				["glowLines"] = 8,
				["config"] = {
				},
				["regionType"] = "icon",
				["width"] = 55,
				["glowYOffset"] = 0,
				["alpha"] = 1,
				["xOffset"] = 0,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["parent"] = "Luxthos - Warrior Rotations",
				["auto"] = true,
				["cooldownTextDisabled"] = false,
				["zoom"] = 0.33,
				["semver"] = "1.1.2",
				["glowScale"] = 1,
				["id"] = "Colossus Smash - Active",
				["useglowColor"] = false,
				["frameStrata"] = 1,
				["anchorFrameType"] = "SCREEN",
				["glowLength"] = 10,
				["uid"] = "BLnU21rzovH",
				["inverse"] = false,
				["desaturate"] = false,
				["keepAspectRatio"] = true,
				["conditions"] = {
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["yBAFxpK6I3h"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567277425,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["parent"] = "Arms",
				["yOffset"] = -55,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = false,
				["url"] = "https://wago.io/Eh5J56-nY/1",
				["actions"] = {
					["start"] = {
						["do_glow"] = true,
						["glow_type"] = "Pixel",
					},
					["init"] = {
					},
					["finish"] = {
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["selfPoint"] = "CENTER",
				["desaturate"] = true,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 1,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["rotateText"] = "NONE",
						["text_fontSize"] = 12,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 25,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["animation"] = {
					["start"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
					["finish"] = {
						["type"] = "none",
						["duration_type"] = "seconds",
					},
				},
				["glowType"] = "Pixel",
				["glowThickness"] = 1,
				["keepAspectRatio"] = false,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["zoom"] = 0,
				["regionType"] = "icon",
				["load"] = {
					["use_class"] = true,
					["use_spellknown"] = false,
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["spec"] = {
						["multi"] = {
						},
					},
					["spellknown"] = 1160,
					["size"] = {
						["multi"] = {
						},
					},
				},
				["config"] = {
				},
				["width"] = 25,
				["glowYOffset"] = 0,
				["frameStrata"] = 1,
				["glowLength"] = 10,
				["xOffset"] = -85,
				["glowScale"] = 1,
				["cooldownTextDisabled"] = false,
				["auto"] = true,
				["tocversion"] = 11302,
				["id"] = "Demoralizing Shout",
				["icon"] = true,
				["alpha"] = 1,
				["anchorFrameType"] = "SCREEN",
				["authorOptions"] = {
				},
				["uid"] = "yBAFxpK6I3h",
				["inverse"] = false,
				["cooldownEdge"] = false,
				["triggers"] = {
					{
						["trigger"] = {
							["type"] = "aura2",
							["auranames"] = {
								"Demoralizing Shout", -- [1]
							},
							["matchesShowOn"] = "showAlways",
							["event"] = "Health",
							["unit"] = "target",
							["spellIds"] = {
							},
							["names"] = {
							},
							["subeventPrefix"] = "SPELL",
							["subeventSuffix"] = "_CAST_START",
							["useName"] = true,
							["debuffType"] = "HARMFUL",
						},
						["untrigger"] = {
						},
					}, -- [1]
					{
						["trigger"] = {
							["useGroup_count"] = false,
							["matchesShowOn"] = "showOnMissing",
							["genericShowOn"] = "showAlways",
							["unit"] = "target",
							["use_tooltip"] = false,
							["duration"] = "1",
							["unevent"] = "auto",
							["names"] = {
							},
							["debuffType"] = "HARMFUL",
							["use_unit"] = true,
							["type"] = "status",
							["use_debuffClass"] = false,
							["subeventSuffix"] = "_CAST_START",
							["useName"] = true,
							["auranames"] = {
								"Hamstring", -- [1]
							},
							["event"] = "Cooldown Progress (Spell)",
							["spellName"] = 1160,
							["realSpellName"] = "Demoralizing Shout",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["buffShowOn"] = "showOnMissing",
							["use_genericShowOn"] = true,
							["combineMatches"] = "showLowest",
							["use_track"] = true,
							["subeventPrefix"] = "SPELL",
						},
						["untrigger"] = {
							["genericShowOn"] = "showAlways",
						},
					}, -- [2]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["duration"] = "1",
							["event"] = "Power",
							["unit"] = "player",
							["subeventPrefix"] = "SPELL",
							["powertype"] = 1,
							["spellIds"] = {
							},
							["names"] = {
							},
							["use_unit"] = true,
							["subeventSuffix"] = "_CAST_START",
							["use_powertype"] = true,
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [3]
					["disjunctive"] = "any",
					["activeTriggerMode"] = -10,
				},
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 3,
							["op"] = ">=",
							["variable"] = "power",
							["value"] = "10",
						},
						["changes"] = {
							{
								["property"] = "desaturate",
							}, -- [1]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "buffed",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
							{
								["value"] = false,
								["property"] = "desaturate",
							}, -- [2]
						},
					}, -- [2]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["0TkwLNbsatm"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201685,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["parent"] = "ChUI - Debuff Tracker - Warrior",
				["yOffset"] = 0,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["cooldownEdge"] = false,
				["icon"] = true,
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["animation"] = {
					["start"] = {
						["type"] = "preset",
						["preset"] = "slidebottom",
						["duration_type"] = "seconds",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["type"] = "preset",
						["preset"] = "slidetop",
						["duration_type"] = "seconds",
					},
				},
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 1,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = "%s",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = false,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["text_fontType"] = "OUTLINE",
						["rotateText"] = "NONE",
						["anchorXOffset"] = 0,
						["text_fontSize"] = 12,
					}, -- [1]
				},
				["height"] = 50,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["keepAspectRatio"] = false,
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["url"] = "https://wago.io/Okky1Eh5g/1",
				["triggers"] = {
					{
						["trigger"] = {
							["type"] = "aura2",
							["auranames"] = {
								"Thunder Clap", -- [1]
							},
							["event"] = "Health",
							["unit"] = "target",
							["spellIds"] = {
							},
							["subeventPrefix"] = "SPELL",
							["useName"] = true,
							["subeventSuffix"] = "_CAST_START",
							["names"] = {
							},
							["debuffType"] = "HARMFUL",
						},
						["untrigger"] = {
						},
					}, -- [1]
					["activeTriggerMode"] = -10,
				},
				["regionType"] = "icon",
				["authorOptions"] = {
				},
				["xOffset"] = 55,
				["config"] = {
				},
				["width"] = 50,
				["anchorFrameType"] = "SCREEN",
				["frameStrata"] = 1,
				["selfPoint"] = "CENTER",
				["tocversion"] = 11302,
				["zoom"] = 0,
				["auto"] = true,
				["glowScale"] = 1,
				["id"] = "Warrior: TC UP",
				["cooldownTextDisabled"] = false,
				["alpha"] = 1,
				["glowYOffset"] = 0,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["uid"] = "0TkwLNbsatm",
				["inverse"] = false,
				["load"] = {
					["use_class"] = true,
					["use_combat"] = true,
					["spec"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["glowLength"] = 10,
				["conditions"] = {
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["HqJOg4nioGh"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201870,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["authorOptions"] = {
				},
				["yOffset"] = -162,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["url"] = "https://wago.io/9EBTx7-J0/3",
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["selfPoint"] = "CENTER",
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 3,
				["subRegions"] = {
				},
				["height"] = 45,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["triggers"] = {
					{
						["trigger"] = {
							["auranames"] = {
								"Thunder Clap", -- [1]
							},
							["use_genericShowOn"] = true,
							["genericShowOn"] = "showAlways",
							["use_unit"] = true,
							["unitExists"] = true,
							["subeventPrefix"] = "SPELL",
							["debuffType"] = "HARMFUL",
							["use_absorbMode"] = true,
							["useName"] = true,
							["unit"] = "target",
							["unevent"] = "auto",
							["use_showOn"] = true,
							["names"] = {
							},
							["event"] = "Cooldown Progress (Spell)",
							["type"] = "aura2",
							["realSpellName"] = "Thunder Clap",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["spellName"] = 6343,
							["matchesShowOn"] = "showAlways",
							["subeventSuffix"] = "_CAST_START",
							["use_track"] = true,
							["duration"] = "1",
						},
						["untrigger"] = {
							["showOn"] = "showAlways",
							["spellName"] = 6343,
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["load"] = {
					["talent2"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["ingroup"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["use_spec"] = true,
					["spec"] = {
						["single"] = 3,
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["cooldownEdge"] = false,
				["regionType"] = "icon",
				["xOffset"] = 50,
				["uid"] = "HqJOg4nioGh",
				["glowYOffset"] = 0,
				["width"] = 45,
				["alpha"] = 1,
				["icon"] = true,
				["auto"] = true,
				["tocversion"] = 11302,
				["cooldownTextDisabled"] = false,
				["semver"] = "1.0.2",
				["glowScale"] = 1,
				["id"] = "Thunder Clap",
				["zoom"] = 0,
				["frameStrata"] = 1,
				["anchorFrameType"] = "SCREEN",
				["glowLength"] = 10,
				["config"] = {
				},
				["inverse"] = true,
				["keepAspectRatio"] = false,
				["parent"] = "Warrior",
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["op"] = "==",
							["value"] = "0",
							["variable"] = "matchCount",
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [1]
						},
					}, -- [1]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["8OSKq4Oqv80"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567202218,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["authorOptions"] = {
				},
				["customText"] = "function()\n    return select(3, WA_GetUnitBuff(\"player\", 7384))\nend",
				["yOffset"] = 0,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["customTextUpdate"] = "update",
				["cooldownEdge"] = false,
				["icon"] = true,
				["triggers"] = {
					{
						["trigger"] = {
							["use_power"] = true,
							["genericShowOn"] = "showAlways",
							["names"] = {
							},
							["use_showgcd"] = true,
							["powertype"] = 1,
							["use_powertype"] = true,
							["debuffType"] = "HELPFUL",
							["subeventPrefix"] = "SPELL",
							["type"] = "status",
							["unit"] = "player",
							["subeventSuffix"] = "_CAST_START",
							["power_operator"] = ">=",
							["unevent"] = "auto",
							["event"] = "Cooldown Progress (Spell)",
							["duration"] = "1",
							["realSpellName"] = "Rampage",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["use_genericShowOn"] = true,
							["use_unit"] = true,
							["use_absorbMode"] = true,
							["use_track"] = true,
							["spellName"] = 184367,
						},
						["untrigger"] = {
							["genericShowOn"] = "showAlways",
							["spellName"] = 184367,
						},
					}, -- [1]
					{
						["trigger"] = {
							["type"] = "aura2",
							["auranames"] = {
								"184362", -- [1]
							},
							["duration"] = "1",
							["event"] = "Health",
							["subeventPrefix"] = "SPELL",
							["unit"] = "player",
							["useName"] = true,
							["subeventSuffix"] = "_CAST_START",
							["use_unit"] = true,
							["use_absorbMode"] = true,
							["unevent"] = "auto",
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [2]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["use_absorbMode"] = true,
							["event"] = "Power",
							["unit"] = "player",
							["powertype"] = 1,
							["subeventPrefix"] = "SPELL",
							["use_unit"] = true,
							["subeventSuffix"] = "_CAST_START",
							["use_powertype"] = true,
							["duration"] = "1",
						},
						["untrigger"] = {
						},
					}, -- [3]
					{
						["trigger"] = {
							["type"] = "status",
							["talent"] = {
								["single"] = 13,
							},
							["use_absorbMode"] = true,
							["event"] = "Talent Known",
							["unit"] = "player",
							["duration"] = "1",
							["subeventPrefix"] = "SPELL",
							["subeventSuffix"] = "_CAST_START",
							["use_unit"] = true,
							["use_talent"] = true,
							["unevent"] = "auto",
						},
						["untrigger"] = {
						},
					}, -- [4]
					["disjunctive"] = "any",
					["customTriggerLogic"] = "function(t)\n    if t[1] and t[3] then\n        aura_env.region:SetGlow(true)\n    elseif t[1] and t[2] then\n        aura_env.region:SetGlow(true)\n    else \n        aura_env.region:SetGlow(false)\n    end\n    return true\nend",
					["activeTriggerMode"] = 1,
				},
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["selfPoint"] = "CENTER",
				["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
				["progressPrecision"] = 0,
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 32,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = " ",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["text_fontSize"] = 13,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 55,
				["url"] = "https://wago.io/SkBHabbrQ/32",
				["load"] = {
					["ingroup"] = {
						["multi"] = {
						},
					},
					["use_never"] = false,
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["use_class"] = true,
					["role"] = {
						["multi"] = {
						},
					},
					["use_spec"] = true,
					["size"] = {
						["multi"] = {
						},
					},
					["talent2"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 3,
						["multi"] = {
							[14] = true,
							[13] = true,
						},
					},
					["spec"] = {
						["single"] = 2,
						["multi"] = {
							true, -- [1]
							true, -- [2]
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["use_vehicleUi"] = false,
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_petbattle"] = false,
					["use_combat"] = true,
					["race"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
				},
				["displayIcon"] = 132352,
				["glowFrequency"] = 0.25,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["stickyDuration"] = false,
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 4,
				["desaturate"] = false,
				["uid"] = "8OSKq4Oqv80",
				["glowLines"] = 8,
				["regionType"] = "icon",
				["glowYOffset"] = 0,
				["alpha"] = 1,
				["anchorFrameType"] = "SCREEN",
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["parent"] = "Luxthos - Warrior Rotations",
				["auto"] = true,
				["cooldownTextDisabled"] = false,
				["glowLength"] = 10,
				["zoom"] = 0.33,
				["semver"] = "1.1.2",
				["glowScale"] = 1,
				["id"] = "Rampage",
				["useglowColor"] = false,
				["frameStrata"] = 1,
				["width"] = 55,
				["xOffset"] = 0,
				["config"] = {
				},
				["inverse"] = true,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["keepAspectRatio"] = true,
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["op"] = "<",
							["value"] = 1,
							["variable"] = "insufficientResources",
						},
						["changes"] = {
							{
								["value"] = {
									0.31764705882353, -- [1]
									0.40392156862745, -- [2]
									0.78039215686274, -- [3]
									1, -- [4]
								},
								["property"] = "color",
							}, -- [1]
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [2]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "AND",
							["checks"] = {
								{
									["trigger"] = 4,
									["variable"] = "show",
									["value"] = 1,
								}, -- [1]
								{
									["trigger"] = -2,
									["variable"] = "OR",
									["checks"] = {
										{
											["trigger"] = -2,
											["variable"] = "AND",
											["checks"] = {
												{
													["trigger"] = 2,
													["variable"] = "show",
													["value"] = 0,
												}, -- [1]
												{
													["trigger"] = 1,
													["variable"] = "insufficientResources",
													["value"] = 0,
												}, -- [2]
											},
										}, -- [1]
										{
											["trigger"] = 3,
											["op"] = ">=",
											["value"] = "90",
											["variable"] = "power",
										}, -- [2]
									},
								}, -- [2]
							},
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
						},
					}, -- [2]
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "AND",
							["checks"] = {
								{
									["trigger"] = 4,
									["variable"] = "show",
									["value"] = 0,
								}, -- [1]
								{
									["trigger"] = 1,
									["variable"] = "insufficientResources",
									["value"] = 0,
								}, -- [2]
							},
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
						},
					}, -- [3]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["QKaMnpsGy5K"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567202218,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["authorOptions"] = {
				},
				["yOffset"] = 0,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["customTextUpdate"] = "update",
				["cooldownEdge"] = false,
				["icon"] = true,
				["triggers"] = {
					{
						["trigger"] = {
							["track"] = "auto",
							["use_absorbMode"] = true,
							["genericShowOn"] = "showAlways",
							["names"] = {
							},
							["use_showgcd"] = true,
							["powertype"] = 1,
							["use_powertype"] = true,
							["debuffType"] = "HELPFUL",
							["type"] = "status",
							["subeventSuffix"] = "_CAST_START",
							["use_unit"] = true,
							["unit"] = "player",
							["event"] = "Cooldown Progress (Spell)",
							["unevent"] = "auto",
							["realSpellName"] = "Execute",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["duration"] = "1",
							["use_genericShowOn"] = true,
							["spellName"] = 163201,
							["use_track"] = true,
							["subeventPrefix"] = "SPELL",
						},
						["untrigger"] = {
							["genericShowOn"] = "showAlways",
						},
					}, -- [1]
					{
						["trigger"] = {
							["buffShowOn"] = "showAlways",
							["useName"] = true,
							["use_debuffClass"] = false,
							["auranames"] = {
								"52437", -- [1]
							},
							["type"] = "aura2",
							["matchesShowOn"] = "showAlways",
							["event"] = "Health",
							["unit"] = "player",
							["subeventSuffix"] = "_CAST_START",
							["use_tooltip"] = false,
							["spellIds"] = {
								52437, -- [1]
							},
							["names"] = {
								"Sudden Death", -- [1]
							},
							["subeventPrefix"] = "SPELL",
							["combineMatches"] = "showLowest",
							["useGroup_count"] = false,
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
						},
					}, -- [2]
					{
						["trigger"] = {
							["type"] = "status",
							["talent"] = {
								["single"] = 7,
							},
							["duration"] = "1",
							["event"] = "Talent Known",
							["use_talent"] = true,
							["unit"] = "player",
							["use_absorbMode"] = true,
							["subeventSuffix"] = "_CAST_START",
							["use_unit"] = true,
							["subeventPrefix"] = "SPELL",
							["unevent"] = "auto",
						},
						["untrigger"] = {
						},
					}, -- [3]
					{
						["trigger"] = {
							["type"] = "status",
							["unevent"] = "auto",
							["duration"] = "1",
							["event"] = "Health",
							["subeventPrefix"] = "SPELL",
							["buffShowOn"] = "showOnActive",
							["names"] = {
							},
							["spellIds"] = {
							},
							["subeventSuffix"] = "_CAST_START",
							["use_unit"] = true,
							["unit"] = "target",
							["use_absorbMode"] = true,
							["debuffType"] = "HELPFUL",
						},
						["untrigger"] = {
							["unit"] = "target",
						},
					}, -- [4]
					{
						["trigger"] = {
							["debuffType"] = "HELPFUL",
							["type"] = "status",
							["subeventSuffix"] = "_CAST_START",
							["unevent"] = "auto",
							["names"] = {
							},
							["use_absorbMode"] = true,
							["event"] = "Action Usable",
							["subeventPrefix"] = "SPELL",
							["realSpellName"] = "Execute",
							["use_spellName"] = true,
							["spellIds"] = {
							},
							["duration"] = "1",
							["buffShowOn"] = "showOnActive",
							["use_unit"] = true,
							["unit"] = "player",
							["spellName"] = 281000,
						},
						["untrigger"] = {
						},
					}, -- [5]
					["disjunctive"] = "any",
					["customTriggerLogic"] = "",
					["activeTriggerMode"] = -10,
				},
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["selfPoint"] = "CENTER",
				["desc"] = "Created by Luxthos\nhttps://www.twitch.tv/luxthos",
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 32,
				["subRegions"] = {
					{
						["text_shadowXOffset"] = 0,
						["type"] = "subtext",
						["text_text"] = " ",
						["text_color"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["text_font"] = "Friz Quadrata TT",
						["text_shadowColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["text_shadowYOffset"] = 0,
						["text_selfPoint"] = "AUTO",
						["text_visible"] = true,
						["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
						["anchorYOffset"] = 0,
						["text_fontSize"] = 13,
						["anchorXOffset"] = 0,
						["text_fontType"] = "OUTLINE",
					}, -- [1]
				},
				["height"] = 55,
				["url"] = "https://wago.io/SkBHabbrQ/32",
				["load"] = {
					["use_petbattle"] = false,
					["use_never"] = false,
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["use_class"] = true,
					["role"] = {
						["multi"] = {
						},
					},
					["use_spec"] = true,
					["size"] = {
						["multi"] = {
						},
					},
					["talent2"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 3,
						["multi"] = {
							[9] = true,
							[8] = true,
						},
					},
					["spec"] = {
						["single"] = 1,
						["multi"] = {
							true, -- [1]
							true, -- [2]
						},
					},
					["difficulty"] = {
						["multi"] = {
						},
					},
					["use_vehicleUi"] = false,
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["use_combat"] = true,
					["race"] = {
						["multi"] = {
						},
					},
					["ingroup"] = {
						["multi"] = {
						},
					},
				},
				["displayIcon"] = 135358,
				["glowFrequency"] = 0.25,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["stickyDuration"] = false,
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 4,
				["desaturate"] = false,
				["uid"] = "QKaMnpsGy5K",
				["glowLines"] = 8,
				["regionType"] = "icon",
				["glowYOffset"] = 0,
				["alpha"] = 1,
				["anchorFrameType"] = "SCREEN",
				["parent"] = "Luxthos - Warrior Rotations",
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
					},
				},
				["auto"] = false,
				["cooldownTextDisabled"] = false,
				["glowLength"] = 10,
				["zoom"] = 0.33,
				["semver"] = "1.1.2",
				["glowScale"] = 1,
				["id"] = "Execute Arms",
				["progressPrecision"] = 0,
				["frameStrata"] = 1,
				["width"] = 55,
				["xOffset"] = 58,
				["config"] = {
				},
				["inverse"] = false,
				["useglowColor"] = false,
				["keepAspectRatio"] = true,
				["conditions"] = {
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "insufficientResources",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = {
									0.31764705882353, -- [1]
									0.40392156862745, -- [2]
									0.78039215686274, -- [3]
									1, -- [4]
								},
								["property"] = "color",
							}, -- [1]
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [2]
						},
					}, -- [1]
					{
						["check"] = {
							["trigger"] = 2,
							["variable"] = "buffed",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
						},
					}, -- [2]
					{
						["check"] = {
							["trigger"] = -2,
							["op"] = "==",
							["variable"] = "AND",
							["checks"] = {
								{
									["trigger"] = 3,
									["op"] = "==",
									["value"] = 1,
									["variable"] = "show",
								}, -- [1]
								{
									["trigger"] = 4,
									["op"] = "<",
									["value"] = "35",
									["variable"] = "percenthealth",
								}, -- [2]
							},
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
						},
					}, -- [3]
					{
						["check"] = {
							["trigger"] = -2,
							["variable"] = "AND",
							["checks"] = {
								{
									["trigger"] = 3,
									["variable"] = "show",
									["value"] = 0,
								}, -- [1]
								{
									["trigger"] = 4,
									["op"] = "<",
									["value"] = "20",
									["variable"] = "percenthealth",
								}, -- [2]
							},
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "glow",
							}, -- [1]
						},
					}, -- [4]
					{
						["check"] = {
							["trigger"] = 5,
							["variable"] = "show",
							["value"] = 0,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "desaturate",
							}, -- [1]
						},
					}, -- [5]
					{
						["check"] = {
							["trigger"] = 1,
							["variable"] = "onCooldown",
							["value"] = 1,
						},
						["changes"] = {
							{
								["value"] = true,
								["property"] = "cooldownEdge",
							}, -- [1]
						},
					}, -- [6]
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
		["U4SIS9WP55e"] = {
			["skippedVersions"] = {
			},
			["source"] = "import",
			["lastUpdate"] = 1567201870,
			["allowUpdates"] = true,
			["data"] = {
				["glow"] = false,
				["xOffset"] = -52,
				["yOffset"] = -73,
				["anchorPoint"] = "CENTER",
				["cooldownSwipe"] = true,
				["cooldownEdge"] = false,
				["actions"] = {
					["start"] = {
					},
					["finish"] = {
					},
					["init"] = {
						["custom"] = "",
						["do_custom"] = false,
					},
				},
				["useglowColor"] = false,
				["internalVersion"] = 23,
				["glowXOffset"] = 0,
				["animation"] = {
					["start"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["main"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
					["finish"] = {
						["duration_type"] = "seconds",
						["type"] = "none",
					},
				},
				["desaturate"] = false,
				["glowColor"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["version"] = 3,
				["subRegions"] = {
				},
				["height"] = 45,
				["glowLines"] = 8,
				["glowFrequency"] = 0.25,
				["keepAspectRatio"] = false,
				["url"] = "https://wago.io/9EBTx7-J0/3",
				["glowType"] = "buttonOverlay",
				["glowThickness"] = 1,
				["triggers"] = {
					{
						["trigger"] = {
							["useGroup_count"] = false,
							["matchesShowOn"] = "showOnActive",
							["use_specific_unit"] = false,
							["use_tooltip"] = false,
							["debuffType"] = "HELPFUL",
							["subeventPrefix"] = "SPELL",
							["useName"] = true,
							["stacksOperator"] = ">",
							["subeventSuffix"] = "_CAST_START",
							["unit"] = "player",
							["names"] = {
								"In For The Kill", -- [1]
							},
							["event"] = "Health",
							["ownOnly"] = true,
							["type"] = "aura2",
							["spellIds"] = {
								248622, -- [1]
							},
							["name"] = "Spell Reflection",
							["use_debuffClass"] = false,
							["auranames"] = {
								"13048", -- [1]
							},
							["combineMatches"] = "showLowest",
							["stacks"] = "0",
							["buffShowOn"] = "showOnActive",
						},
						["untrigger"] = {
						},
					}, -- [1]
					["disjunctive"] = "all",
					["activeTriggerMode"] = -10,
				},
				["color"] = {
					1, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				},
				["load"] = {
					["ingroup"] = {
						["multi"] = {
						},
					},
					["talent"] = {
						["single"] = 31,
						["multi"] = {
							[16] = true,
						},
					},
					["talent2"] = {
						["multi"] = {
						},
					},
					["class"] = {
						["single"] = "WARRIOR",
						["multi"] = {
						},
					},
					["role"] = {
						["multi"] = {
						},
					},
					["use_talent"] = true,
					["difficulty"] = {
						["multi"] = {
						},
					},
					["race"] = {
						["multi"] = {
						},
					},
					["faction"] = {
						["multi"] = {
						},
					},
					["pvptalent"] = {
						["multi"] = {
						},
					},
					["use_class"] = true,
					["use_spec"] = true,
					["spec"] = {
						["single"] = 1,
						["multi"] = {
						},
					},
					["size"] = {
						["multi"] = {
						},
					},
				},
				["regionType"] = "icon",
				["selfPoint"] = "CENTER",
				["uid"] = "U4SIS9WP55e",
				["glowLength"] = 10,
				["glowYOffset"] = 0,
				["alpha"] = 1,
				["icon"] = true,
				["auto"] = true,
				["tocversion"] = 11302,
				["cooldownTextDisabled"] = false,
				["semver"] = "1.0.2",
				["glowScale"] = 1,
				["id"] = "Enrage - Buff",
				["zoom"] = 0,
				["frameStrata"] = 1,
				["anchorFrameType"] = "SCREEN",
				["width"] = 45,
				["config"] = {
				},
				["inverse"] = false,
				["authorOptions"] = {
				},
				["parent"] = "Warrior",
				["conditions"] = {
				},
				["cooldown"] = true,
				["glowBorder"] = false,
			},
		},
	},
	["clearOldHistory"] = 30,
	["registered"] = {
	},
	["login_squelch_time"] = 10,
	["frame"] = {
		["xOffset"] = -1197.48687744141,
		["yOffset"] = -25.1282958984375,
		["height"] = 663.359191894531,
		["width"] = 903.026000976563,
	},
	["editor_theme"] = "Monokai",
}
