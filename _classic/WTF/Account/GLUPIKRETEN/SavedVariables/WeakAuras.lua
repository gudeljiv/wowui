
WeakAurasSaved = {
	["editor_tab_spaces"] = 4,
	["login_squelch_time"] = 10,
	["mousePointerFrame"] = {
		["xOffset"] = -873.55859375,
		["yOffset"] = -419.6339721679688,
	},
	["minimap"] = {
		["hide"] = true,
	},
	["dbVersion"] = 70,
	["instanceHistoryDb"] = {
		["sess"] = {
			["delayUpdate"] = 1666881109,
			["enterLoc"] = {
				["instance"] = -1,
			},
			["histOldest"] = "n/a",
			["histLiveCount"] = 0,
		},
		["History"] = {
		},
		["HistoryDay"] = {
		},
		["histGeneration"] = 771,
		["config"] = {
			["displayMin"] = 0,
			["debug"] = false,
			["updateInterval"] = 5,
			["ShowServer"] = false,
			["ReportResets"] = false,
			["showTimeSpent"] = false,
		},
		["Instances"] = {
		},
	},
	["editor_theme"] = "Monokai",
	["dynamicIconCache"] = {
	},
	["editor_font_size"] = 12,
	["lastArchiveClear"] = 1602609267,
	["personalRessourceDisplayFrame"] = {
		["xOffset"] = -422.8046555407566,
		["yOffset"] = -497.8042091158466,
	},
	["lastUpgrade"] = 1700301679,
	["bgtimetotsave"] = 0,
	["editor_bracket_matching"] = true,
	["unitscan GUI"] = {
	},
	["registered"] = {
	},
	["displays"] = {
		["Vermin Priest"] = {
			["grow"] = "LEFT",
			["controlledChildren"] = {
				"Power Word Fortitude", -- [1]
				"Power Word: Shield", -- [2]
				"Spirit Tap", -- [3]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["authorOptions"] = {
			},
			["yOffset"] = 20,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["rowSpace"] = 1,
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
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["event"] = "Health",
						["names"] = {
						},
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["columnSpace"] = 1,
			["radius"] = 200,
			["useLimit"] = false,
			["align"] = "CENTER",
			["rotation"] = 0,
			["config"] = {
			},
			["space"] = 2,
			["load"] = {
				["talent"] = {
					["multi"] = {
					},
				},
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
			["borderEdge"] = "Square Full White",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["xOffset"] = -135,
			["animate"] = true,
			["stagger"] = 0,
			["scale"] = 1,
			["centerType"] = "LR",
			["border"] = false,
			["anchorFrameFrame"] = "PlayerFrame",
			["stepAngle"] = 15,
			["borderSize"] = 2,
			["sort"] = "none",
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["internalVersion"] = 70,
			["constantFactor"] = "RADIUS",
			["regionType"] = "dynamicgroup",
			["borderOffset"] = 4,
			["gridType"] = "RD",
			["gridWidth"] = 5,
			["id"] = "Vermin Priest",
			["borderInset"] = 1,
			["frameStrata"] = 5,
			["anchorFrameType"] = "SCREEN",
			["limit"] = 5,
			["uid"] = "S3ES06vW5Vw",
			["selfPoint"] = "RIGHT",
			["fullCircle"] = true,
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["arcLength"] = 360,
		},
		["Mark of the Wild"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["wagoID"] = "v9qxdDgI4",
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["sparkHeight"] = 30,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["sparkOffsetX"] = 0,
			["cooldownSwipe"] = true,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Mark of the Wild", -- [1]
							"Gift of the Wild", -- [2]
						},
						["matchesShowOn"] = "showOnMissing",
						["genericShowOn"] = "showOnReady",
						["names"] = {
						},
						["debuffType"] = "HELPFUL",
						["use_unit"] = true,
						["useName"] = true,
						["subeventSuffix"] = "_CAST_START",
						["unevent"] = "auto",
						["subeventPrefix"] = "SPELL",
						["spellName"] = 34428,
						["event"] = "Action Usable",
						["use_genericShowOn"] = true,
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["unit"] = "player",
						["type"] = "aura2",
						["duration"] = "1",
						["use_track"] = true,
						["useIgnoreName"] = false,
					},
					["untrigger"] = {
						["genericShowOn"] = "showOnReady",
					},
				}, -- [1]
				{
					["trigger"] = {
						["unit"] = "player",
						["rem"] = "30",
						["debuffType"] = "HELPFUL",
						["auranames"] = {
							"Mark of the Wild", -- [1]
							"Gift of the Wild", -- [2]
						},
						["remOperator"] = "<=",
						["useName"] = true,
						["type"] = "aura2",
						["useRem"] = true,
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
			["internalVersion"] = 70,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["authorOptions"] = {
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["barColor"] = {
				0.2, -- [1]
				1, -- [2]
				0.0862745098039216, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["useTooltip"] = false,
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.5,
					["type"] = "subglow",
					["useGlowColor"] = true,
					["text_color"] = {
					},
					["glowThickness"] = 2,
					["glowDuration"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0.5215686559677124, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 16,
					["glow"] = true,
					["glowScale"] = 1,
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_p_time_precision"] = 1,
					["text_text"] = "%p",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "OUTER_TOP",
					["text_shadowXOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 10,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
				}, -- [3]
			},
			["height"] = 36,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["load"] = {
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["zoneIds"] = "",
				["use_class"] = true,
				["use_spellknown"] = true,
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
					},
				},
				["use_level"] = false,
				["level"] = {
					"5", -- [1]
				},
				["spellknown"] = 5232,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["uid"] = "dSKOb6n5acg",
			["cooldown"] = false,
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["displayIcon"] = "",
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "icon",
			["parent"] = "Vermin Druid",
			["config"] = {
			},
			["icon_side"] = "RIGHT",
			["anchorFrameFrame"] = "PlayerFrame",
			["sparkHidden"] = "NEVER",
			["anchorFrameParent"] = false,
			["texture"] = "Melli",
			["width"] = 36,
			["zoom"] = 0,
			["auto"] = false,
			["frameStrata"] = 1,
			["id"] = "Mark of the Wild",
			["cooldownTextDisabled"] = false,
			["useCooldownModRate"] = true,
			["anchorFrameType"] = "SCREEN",
			["spark"] = false,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["inverse"] = false,
			["alpha"] = 1,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
		},
		["Sweeping Strikes"] = {
			["sparkWidth"] = 10,
			["sparkOffsetX"] = 0,
			["wagoID"] = "v9qxdDgI4",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["sparkHeight"] = 30,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["iconSource"] = -1,
			["cooldownSwipe"] = true,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["cooldownEdge"] = false,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Sweeping Strikes", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showOnReady",
						["names"] = {
						},
						["debuffType"] = "HELPFUL",
						["type"] = "aura2",
						["unit"] = "player",
						["unevent"] = "auto",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Action Usable",
						["useName"] = true,
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_genericShowOn"] = true,
						["spellName"] = 34428,
						["use_unit"] = true,
						["use_track"] = true,
						["useIgnoreName"] = false,
					},
					["untrigger"] = {
						["genericShowOn"] = "showOnReady",
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
			["internalVersion"] = 70,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["xOffset"] = 0,
			["barColor"] = {
				0.2, -- [1]
				1, -- [2]
				0.0862745098039216, -- [3]
				1, -- [4]
			},
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["icon"] = true,
			["useTooltip"] = false,
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.75,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["text_color"] = {
					},
					["glowThickness"] = 2,
					["glowDuration"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0.85098039215686, -- [2]
						0.1843137254902, -- [3]
						1, -- [4]
					},
					["useGlowColor"] = true,
					["glow"] = true,
					["glowLength"] = 16,
					["glowType"] = "buttonOverlay",
					["glowScale"] = 1,
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "%p",
					["text_text_format_p_time_mod_rate"] = true,
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_format"] = "timed",
					["type"] = "subtext",
					["anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_shadowXOffset"] = 0,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 12,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
				}, -- [3]
				{
					["text_shadowXOffset"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_precision"] = 1,
					["anchorXOffset"] = 0,
					["type"] = "subtext",
					["text_text_format_p_format"] = "timed",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_format"] = 0,
					["text_anchorYOffset"] = 25,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_time_mod_rate"] = true,
					["text_shadowYOffset"] = 0,
					["text_fontSize"] = 12,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_p_time_legacy_floor"] = false,
				}, -- [4]
			},
			["height"] = 36,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["load"] = {
				["use_level"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["use_class"] = false,
				["size"] = {
					["multi"] = {
					},
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["use_never"] = false,
				["level"] = {
					"60", -- [1]
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
						["WARRIOR"] = true,
					},
				},
				["zoneIds"] = "",
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["parent"] = "Vermin Warrior",
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["desaturate"] = false,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["conditions"] = {
			},
			["smoothProgress"] = true,
			["anchorFrameFrame"] = "PlayerFrame",
			["regionType"] = "icon",
			["useCooldownModRate"] = true,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["icon_side"] = "RIGHT",
			["useAdjustededMin"] = false,
			["id"] = "Sweeping Strikes",
			["anchorFrameParent"] = false,
			["texture"] = "Melli",
			["width"] = 36,
			["zoom"] = 0.3,
			["spark"] = false,
			["frameStrata"] = 1,
			["sparkHidden"] = "NEVER",
			["uid"] = "vSO1BWwktHA",
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["auto"] = false,
			["orientation"] = "HORIZONTAL",
			["displayIcon"] = "",
			["cooldown"] = false,
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
		},
		["Ruby"] = {
			["iconSource"] = -1,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["event"] = "Conditions",
						["subeventPrefix"] = "SPELL",
						["spellIds"] = {
						},
						["use_unit"] = true,
						["names"] = {
						},
						["unit"] = "player",
						["unevent"] = "auto",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "item",
						["use_count"] = true,
						["subeventSuffix"] = "_CAST_START",
						["use_exact_itemName"] = true,
						["duration"] = "1",
						["event"] = "Item Count",
						["subeventPrefix"] = "SPELL",
						["use_includeBank"] = false,
						["itemName"] = 8008,
						["count"] = "0",
						["use_unit"] = true,
						["unit"] = "player",
						["use_itemName"] = true,
						["unevent"] = "auto",
						["count_operator"] = "==",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["customTriggerLogic"] = "",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.25,
					["glow"] = true,
					["useGlowColor"] = false,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowDuration"] = 1,
					["type"] = "subglow",
					["glowThickness"] = 1,
					["glowScale"] = 1,
					["glowXOffset"] = 0,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [2]
			},
			["height"] = 40,
			["load"] = {
				["use_level"] = true,
				["talent"] = {
					["single"] = 9,
					["multi"] = {
						[9] = true,
					},
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["use_class"] = false,
				["use_spellknown"] = false,
				["zoneIds"] = "",
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["MAGE"] = true,
					},
				},
				["use_never"] = false,
				["level"] = {
					"58", -- [1]
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
			["authorMode"] = true,
			["zoom"] = 0,
			["uid"] = "UvSV5jPJMlO",
			["parent"] = "GEMS",
			["authorOptions"] = {
				{
					["subOptions"] = {
						{
							["type"] = "input",
							["useDesc"] = false,
							["width"] = 1,
							["name"] = "Text",
							["default"] = "",
							["multiline"] = false,
							["length"] = 10,
							["key"] = "text",
							["useLength"] = false,
						}, -- [1]
					},
					["hideReorder"] = true,
					["useDesc"] = false,
					["nameSource"] = 0,
					["width"] = 1,
					["useCollapse"] = false,
					["key"] = "macro",
					["name"] = "Macro",
					["collapse"] = false,
					["limitType"] = "none",
					["groupType"] = "simple",
					["type"] = "group",
					["size"] = 10,
				}, -- [1]
			},
			["regionType"] = "icon",
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["displayIcon"] = 134128,
			["xOffset"] = 120,
			["selfPoint"] = "CENTER",
			["anchorFrameType"] = "SCREEN",
			["alpha"] = 1,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.0.0",
			["tocversion"] = 11304,
			["id"] = "Ruby",
			["auto"] = true,
			["useCooldownModRate"] = true,
			["width"] = 40,
			["frameStrata"] = 1,
			["config"] = {
				["macro"] = {
					["text"] = "/cast Conjure Mana Ruby",
				},
			},
			["inverse"] = false,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["custom"] = "local text = aura_env.config.macro.text\n\naura_env.button = CreateFrame(\"Button\", \"buffButton\", aura_env.region, \"SecureActionButtonTemplate\")\naura_env.button:SetAllPoints()\naura_env.button:SetAttribute(\"unit\", \"player\")\naura_env.button:SetAttribute(\"type\",\"macro\")\naura_env.button:SetAttribute(\"macrotext\", text)",
					["do_custom"] = true,
				},
				["finish"] = {
					["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\CartoonWalking.ogg",
					["do_sound"] = false,
				},
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 2,
						["variable"] = "show",
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
						["trigger"] = 2,
						["variable"] = "show",
						["value"] = 0,
					},
					["changes"] = {
						{
							["property"] = "alpha",
						}, -- [1]
					},
				}, -- [2]
			},
			["cooldown"] = false,
			["url"] = "https://wago.io/U0WH3IJ3S/1",
		},
		["DEBUFFS - PET"] = {
			["grow"] = "RIGHT",
			["controlledChildren"] = {
				"targetdebuffs  2", -- [1]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -20,
			["anchorPoint"] = "BOTTOMLEFT",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["space"] = 0,
			["url"] = "https://wago.io/W1QyYtaAz/1",
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
			["radius"] = 200,
			["useLimit"] = false,
			["align"] = "CENTER",
			["anchorFrameFrame"] = "PetFrame",
			["stagger"] = 0,
			["rotation"] = 0,
			["version"] = 1,
			["subRegions"] = {
			},
			["rowSpace"] = 1,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["load"] = {
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
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
			["fullCircle"] = true,
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["internalVersion"] = 70,
			["animate"] = false,
			["gridType"] = "RD",
			["scale"] = 0.6,
			["centerType"] = "LR",
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["stepAngle"] = 15,
			["borderSize"] = 2,
			["limit"] = 5,
			["config"] = {
			},
			["regionType"] = "dynamicgroup",
			["anchorFrameParent"] = true,
			["constantFactor"] = "RADIUS",
			["frameStrata"] = 1,
			["borderOffset"] = 4,
			["semver"] = "1.0.0",
			["tocversion"] = 90001,
			["id"] = "DEBUFFS - PET",
			["borderInset"] = 1,
			["gridWidth"] = 5,
			["anchorFrameType"] = "SELECTFRAME",
			["sort"] = "none",
			["uid"] = "e(V6yQRHRNJ",
			["arcLength"] = 360,
			["selfPoint"] = "LEFT",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["xOffset"] = 20,
		},
		["Heroic Strike"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["wagoID"] = "v9qxdDgI4",
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["zoom"] = 0.3,
			["cooldownSwipe"] = true,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"29838", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showOnReady",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["spellName"] = 78,
						["useName"] = true,
						["use_unit"] = true,
						["unevent"] = "auto",
						["unit"] = "player",
						["type"] = "spell",
						["event"] = "Queued Action",
						["use_exact_spellName"] = false,
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_genericShowOn"] = true,
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["use_track"] = true,
						["useIgnoreName"] = false,
					},
					["untrigger"] = {
						["genericShowOn"] = "showOnReady",
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
			["internalVersion"] = 70,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["sparkOffsetX"] = 0,
			["authorOptions"] = {
			},
			["barColor"] = {
				0.2, -- [1]
				1, -- [2]
				0.0862745098039216, -- [3]
				1, -- [4]
			},
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["uid"] = "XmKfgNOliNz",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.75,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["text_color"] = {
					},
					["glowThickness"] = 2,
					["glowDuration"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0.85098039215686, -- [2]
						0.1843137254902, -- [3]
						1, -- [4]
					},
					["useGlowColor"] = true,
					["glow"] = true,
					["glowLength"] = 16,
					["glowType"] = "buttonOverlay",
					["glowScale"] = 1,
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "%p",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["type"] = "subtext",
					["anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_shadowXOffset"] = 0,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 12,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_p_time_mod_rate"] = true,
				}, -- [3]
			},
			["height"] = 40,
			["useTooltip"] = false,
			["load"] = {
				["use_level"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["size"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
						["WARRIOR"] = true,
					},
				},
				["use_never"] = false,
				["level"] = {
					"60", -- [1]
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["selfPoint"] = "CENTER",
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["conditions"] = {
			},
			["desaturate"] = false,
			["cooldownTextDisabled"] = false,
			["smoothProgress"] = true,
			["anchorFrameFrame"] = "PlayerFrame",
			["regionType"] = "icon",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["icon_side"] = "RIGHT",
			["parent"] = "Skills",
			["width"] = 40,
			["sparkHeight"] = 30,
			["texture"] = "Melli",
			["alpha"] = 1,
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["auto"] = false,
			["sparkHidden"] = "NEVER",
			["id"] = "Heroic Strike",
			["useAdjustededMin"] = false,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["spark"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["useCooldownModRate"] = true,
			["orientation"] = "HORIZONTAL",
			["displayIcon"] = 132282,
			["cooldown"] = false,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
		},
		["Quest Reward Value"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "erPK23xH_",
			["authorOptions"] = {
				{
					["width"] = 1,
					["type"] = "select",
					["values"] = {
						"Text", -- [1]
						"Icon", -- [2]
					},
					["name"] = "Display Type (text or icon)",
					["useDesc"] = true,
					["key"] = "type",
					["default"] = 1,
					["desc"] = "Display a dollar sign text or a coin icon on the highest quest reward? Text displays over the reward picture and icon displays over the reward text.",
				}, -- [1]
			},
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["url"] = "https://wago.io/erPK23xH_/3",
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
					["do_custom"] = false,
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Health",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["custom"] = "function(event)\n    if (event == \"QUEST_COMPLETE\" or event == \"OPTIONS\") then\n        if (not _G[\"NovaHighestValueQuestReward\"]) then\n            local f = CreateFrame(\"Frame\", \"NovaHighestValueQuestReward\");\n            f.fs = f:CreateFontString(\"NovaHighestValueQuestRewardFS\", \"ARTWORK\");\n            f.fs:SetPoint(\"CENTER\", 0, 0);\n            f.fs:SetFont(\"Fonts\\\\ARIALN.ttf\", 24);\n            f.texture = f:CreateTexture(nil, \"ARTWORK\");\n            -- f.texture:SetTexture(\"Interface\\\\Icons\\\\INV_Misc_Coin_02\");\n            f.texture:SetTexture(\"Interface\\\\MONEYFRAME\\\\UI-GoldIcon\");\n            f.texture:SetAllPoints(f);\n            f:SetSize(16, 16);\n        end\n        local highest, id = 0, 0;\n        for i = 1, GetNumQuestChoices() do\n            local link = GetQuestItemLink(\"choice\", i);\n            local name = GetQuestItemInfo(\"choice\", i);\n            if (not link) then\n                return;\n            end\n            if (name and not link) then\n                print(\"Missing quest itemlink for:\", name);\n            end\n            local itemID = GetItemInfoInstant(link);\n            if (itemID) then\n                local _, _, _, _, _, _, _, _, _, _, sellPrice = GetItemInfo(itemID);\n                if (sellPrice and sellPrice > highest) then\n                    highest = sellPrice;\n                    id = i;\n                end\n            end\n        end\n        if (_G[\"QuestInfoRewardsFrameQuestInfoItem\" .. id]) then\n            _G[\"NovaHighestValueQuestReward\"]:Show();\n            _G[\"NovaHighestValueQuestReward\"]:SetParent(_G[\"QuestInfoRewardsFrameQuestInfoItem\" .. id]);\n            if (aura_env.config.type == 1) then\n                _G[\"NovaHighestValueQuestReward\"].fs:SetPoint(\"CENTER\", _G[\"QuestInfoRewardsFrameQuestInfoItem\" .. id], \"LEFT\", 20, 0);\n                _G[\"NovaHighestValueQuestReward\"].fs:SetText(\"|CFFFFFF00$\");\n                _G[\"NovaHighestValueQuestReward\"].texture:Hide();\n            else\n                _G[\"NovaHighestValueQuestReward\"]:SetPoint(\"TOPRIGHT\", _G[\"QuestInfoRewardsFrameQuestInfoItem\" .. id], \"TOPRIGHT\", -6, -2);\n                _G[\"NovaHighestValueQuestReward\"].fs:SetText(\"\");\n                _G[\"NovaHighestValueQuestReward\"].texture:Show();\n            end\n        end\n    elseif (event == \"QUEST_FINISHED\" or event == \"QUEST_TURNED_IN\") then\n        if (_G[\"NovaHighestValueQuestReward\"]) then\n            _G[\"NovaHighestValueQuestReward\"]:Hide();\n        end\n    end\nend",
						["events"] = "QUEST_COMPLETE,QUEST_FINISHED,QUEST_TURNED_IN",
						["custom_type"] = "event",
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["spellIds"] = {
						},
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_time_mod_rate"] = true,
			["internalVersion"] = 70,
			["selfPoint"] = "BOTTOM",
			["desc"] = "Shows highest gold value quest reward when completing a quest, has config option for $ text or a gold icon.",
			["font"] = "Friz Quadrata TT",
			["version"] = 3,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_never"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
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
			["fontSize"] = 12,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["wordWrap"] = "WordWrap",
			["regionType"] = "text",
			["automaticWidth"] = "Auto",
			["displayText_format_p_format"] = "timed",
			["conditions"] = {
			},
			["preferToUpdate"] = false,
			["displayText_format_p_time_precision"] = 1,
			["displayText"] = "%p",
			["config"] = {
				["type"] = 2,
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["semver"] = "1.0.2",
			["tocversion"] = 30401,
			["id"] = "Quest Reward Value",
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["justify"] = "LEFT",
			["uid"] = "MZOVhjvTTEF",
			["xOffset"] = 0,
			["displayText_format_p_time_legacy_floor"] = true,
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
				["forceEvents"] = true,
			},
			["yOffset"] = 0,
		},
		["Raptor Strike"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["wagoID"] = "v9qxdDgI4",
			["parent"] = "Skills",
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownTextDisabled"] = false,
			["cooldownSwipe"] = true,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["cooldownEdge"] = false,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"29838", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showOnReady",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["spellName"] = 2973,
						["useName"] = true,
						["unevent"] = "auto",
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["names"] = {
						},
						["event"] = "Queued Action",
						["use_exact_spellName"] = false,
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_genericShowOn"] = true,
						["type"] = "spell",
						["use_unit"] = true,
						["use_track"] = true,
						["useIgnoreName"] = false,
					},
					["untrigger"] = {
						["genericShowOn"] = "showOnReady",
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
			["useTooltip"] = false,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["sparkOffsetX"] = 0,
			["xOffset"] = 0,
			["barColor"] = {
				0.2, -- [1]
				1, -- [2]
				0.0862745098039216, -- [3]
				1, -- [4]
			},
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
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
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.75,
					["type"] = "subglow",
					["useGlowColor"] = true,
					["text_color"] = {
					},
					["glowThickness"] = 2,
					["glowDuration"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0.85098039215686, -- [2]
						0.1843137254902, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 16,
					["glow"] = true,
					["glowScale"] = 1,
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_p_time_precision"] = 1,
					["text_text"] = "%p",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_shadowXOffset"] = 0,
					["text_visible"] = true,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
				}, -- [3]
			},
			["height"] = 40,
			["internalVersion"] = 70,
			["load"] = {
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["zoneIds"] = "",
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
						["WARRIOR"] = true,
					},
				},
				["use_level"] = false,
				["level"] = {
					"60", -- [1]
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
			["useAdjustededMax"] = false,
			["selfPoint"] = "CENTER",
			["cooldown"] = false,
			["displayIcon"] = 132223,
			["desaturate"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["smoothProgress"] = true,
			["anchorFrameFrame"] = "PlayerFrame",
			["regionType"] = "icon",
			["uid"] = "Up5ylVYe)GK",
			["alpha"] = 1,
			["icon_side"] = "RIGHT",
			["width"] = 40,
			["frameStrata"] = 1,
			["sparkHeight"] = 30,
			["texture"] = "Melli",
			["sparkHidden"] = "NEVER",
			["zoom"] = 0.3,
			["spark"] = false,
			["useAdjustededMin"] = false,
			["id"] = "Raptor Strike",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["useCooldownModRate"] = true,
			["anchorFrameType"] = "SCREEN",
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["icon"] = true,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Combo Points Foreground"] = {
			["outline"] = "OUTLINE",
			["parent"] = "Nameplate Combo Points",
			["displayText"] = "%c",
			["customText"] = "function()\n    return aura_env.cpdisplay[GetComboPoints(\"player\", \"target\")]\nend\n\n\n\n",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "event",
			["url"] = "https://wago.io/sv0bnASk1/1",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "aura_env.cpdisplay = {\".\", \"..\", \"...\", \"....\", \".....\"}",
					["do_custom"] = true,
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["debuffType"] = "HELPFUL",
						["type"] = "custom",
						["subeventSuffix"] = "_CAST_START",
						["custom_type"] = "event",
						["names"] = {
						},
						["use_absorbMode"] = true,
						["event"] = "Health",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["custom"] = "function(e, ...)\n    local region = aura_env.region\n    local target = C_NamePlate.GetNamePlateForUnit(\"target\")\n    local attackable = not UnitIsFriend(\"player\", \"target\")\n    \n    if e == \"NAME_PLATE_UNIT_REMOVED\" then\n        local unit = ...\n        if unit and UnitGUID(unit) == UnitGUID(\"target\") then\n            region:Color(0,0,0,0)\n        end\n    elseif target and attackable then\n        local color = aura_env.config.cpcolor\n        \n        region:ClearAllPoints()\n        region:SetPoint(\"TOP\", target, \"BOTTOM\", aura_env.config.xoffset, aura_env.config.yoffset)\n        \n        region:Color(color[1], color[2], color[3], color[4])\n    else\n        region:Color(0,0,0,0)\n    end\n    return true\nend",
						["events"] = "PLAYER_TARGET_CHANGED, NAME_PLATE_UNIT_ADDED, NAME_PLATE_UNIT_REMOVED, PLAYER_ENTERING_WORLD",
						["spellIds"] = {
						},
						["check"] = "event",
						["use_unit"] = true,
						["unevent"] = "auto",
						["custom_hide"] = "custom",
					},
					["untrigger"] = {
						["custom"] = "function()\n    return true\nend",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["debuffType"] = "HELPFUL",
						["unevent"] = "auto",
						["use_track"] = true,
						["duration"] = "1",
						["genericShowOn"] = "showOnCooldown",
						["use_unit"] = true,
						["realSpellName"] = 0,
						["use_spellName"] = true,
						["unit"] = "player",
						["use_genericShowOn"] = true,
						["event"] = "Power",
						["powertype"] = 4,
						["use_powertype"] = true,
						["spellName"] = 0,
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 70,
			["wordWrap"] = "Elide",
			["font"] = "Arial Narrow",
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 11.99995803833,
			["load"] = {
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
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
				["use_never"] = true,
				["class"] = {
					["single"] = "HUNTER",
					["multi"] = {
						["ROGUE"] = true,
						["DRUID"] = true,
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
				["spec"] = {
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
				["talent3"] = {
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
				["race"] = {
					["multi"] = {
					},
				},
				["use_class"] = false,
				["zoneIds"] = "",
			},
			["displayText_format_s_format"] = "none",
			["fontSize"] = 62,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["regionType"] = "text",
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["color"] = {
				0.85882352941176, -- [1]
				0.10588235294118, -- [2]
				0.62745098039216, -- [3]
				0, -- [4]
			},
			["conditions"] = {
			},
			["authorOptions"] = {
				{
					["type"] = "color",
					["default"] = {
						0.85098039215686, -- [1]
						0.14117647058823, -- [2]
						0.55686274509804, -- [3]
						1, -- [4]
					},
					["key"] = "cpcolor",
					["name"] = "Combo Point Color",
					["useDesc"] = false,
					["width"] = 1,
				}, -- [1]
				{
					["type"] = "number",
					["useDesc"] = false,
					["max"] = 200,
					["step"] = 1,
					["width"] = 1,
					["min"] = -200,
					["key"] = "xoffset",
					["default"] = 0,
					["name"] = "X Offset",
				}, -- [2]
				{
					["type"] = "number",
					["useDesc"] = false,
					["max"] = 100,
					["step"] = 1,
					["width"] = 1,
					["min"] = -100,
					["key"] = "yoffset",
					["default"] = 0,
					["name"] = "Y Offset",
				}, -- [3]
			},
			["config"] = {
				["xoffset"] = 39,
				["cpcolor"] = {
					0.89411764705882, -- [1]
					0.090196078431373, -- [2]
					0.3843137254902, -- [3]
					1, -- [4]
				},
				["yoffset"] = 52,
			},
			["shadowYOffset"] = -1,
			["justify"] = "LEFT",
			["tocversion"] = 11305,
			["id"] = "Combo Points Foreground",
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 4,
			["width"] = 15.999987602234,
			["semver"] = "1.0.0",
			["uid"] = "Nbw(s4DDUct",
			["selfPoint"] = "TOP",
			["displayText_format_c_format"] = "none",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0, -- [4]
			},
			["fixedWidth"] = 150,
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["automaticWidth"] = "Fixed",
		},
		["Food"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["wagoID"] = "v9qxdDgI4",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["sparkHeight"] = 30,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["sparkOffsetX"] = 0,
			["cooldownSwipe"] = true,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["cooldownEdge"] = false,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Food", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showOnReady",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["type"] = "aura2",
						["use_unit"] = true,
						["unevent"] = "auto",
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Action Usable",
						["useName"] = true,
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_genericShowOn"] = true,
						["spellName"] = 34428,
						["unit"] = "player",
						["use_track"] = true,
						["useIgnoreName"] = false,
					},
					["untrigger"] = {
						["genericShowOn"] = "showOnReady",
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
			["internalVersion"] = 70,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["parent"] = "Vermin Warrior",
			["authorOptions"] = {
			},
			["barColor"] = {
				0.2, -- [1]
				1, -- [2]
				0.0862745098039216, -- [3]
				1, -- [4]
			},
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["useTooltip"] = false,
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.75,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["text_color"] = {
					},
					["glowThickness"] = 2,
					["glowDuration"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0.85098039215686, -- [2]
						0.1843137254902, -- [3]
						1, -- [4]
					},
					["useGlowColor"] = true,
					["glow"] = true,
					["glowLength"] = 16,
					["glowType"] = "buttonOverlay",
					["glowScale"] = 1,
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "%p",
					["text_text_format_p_time_mod_rate"] = true,
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_format"] = "timed",
					["type"] = "subtext",
					["anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_shadowXOffset"] = 0,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 12,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
				}, -- [3]
			},
			["height"] = 36,
			["selfPoint"] = "CENTER",
			["load"] = {
				["use_level"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["use_class"] = false,
				["size"] = {
					["multi"] = {
					},
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["use_never"] = false,
				["level"] = {
					"60", -- [1]
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
						["WARRIOR"] = true,
					},
				},
				["zoneIds"] = "",
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["xOffset"] = 0,
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["desaturate"] = false,
			["icon"] = true,
			["conditions"] = {
			},
			["smoothProgress"] = true,
			["anchorFrameFrame"] = "PlayerFrame",
			["regionType"] = "icon",
			["frameStrata"] = 1,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["icon_side"] = "RIGHT",
			["useAdjustededMin"] = false,
			["id"] = "Food",
			["anchorFrameParent"] = false,
			["texture"] = "Melli",
			["width"] = 36,
			["cooldownTextDisabled"] = false,
			["spark"] = false,
			["useCooldownModRate"] = true,
			["sparkHidden"] = "NEVER",
			["uid"] = "ktvKzEaRutG",
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["config"] = {
			},
			["inverse"] = false,
			["auto"] = false,
			["orientation"] = "HORIZONTAL",
			["displayIcon"] = "",
			["cooldown"] = false,
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
		},
		["MobHPPercentYELLOW"] = {
			["outline"] = "THICKOUTLINE",
			["color"] = {
				1, -- [1]
				0.95294117647059, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["displayText"] = "%c%",
			["customText"] = "function()\nlocal percent = (UnitHealth(\"target\")/UnitHealthMax(\"target\"))*100\nreturn (\"%.f\"):format(percent)\nend",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/B_hMNakf_/2",
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
						["type"] = "unit",
						["unevent"] = "auto",
						["percenthealth"] = {
							"50", -- [1]
						},
						["duration"] = "1",
						["event"] = "Health",
						["use_unit"] = true,
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["unit"] = "target",
						["use_percenthealth"] = true,
						["percenthealth_operator"] = {
							"<=", -- [1]
						},
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Health",
						["use_unit"] = true,
						["percenthealth"] = {
							"20", -- [1]
						},
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["use_percenthealth"] = true,
						["percenthealth_operator"] = {
							">", -- [1]
						},
						["unit"] = "target",
					},
					["untrigger"] = {
						["unit"] = "target",
					},
				}, -- [2]
				{
					["trigger"] = {
						["type"] = "custom",
						["custom"] = "function()\n    local region = aura_env.region\n    local plate = C_NamePlate.GetNamePlateForUnit(\"target\")\n    \n    \n    if plate then\n        region:ClearAllPoints()\n        region:SetPoint(\"RIGHT\", plate, \"LEFT\", -60, 0)\n        return true\n    else\n        return false\n    end\nend",
						["custom_type"] = "status",
						["check"] = "update",
						["debuffType"] = "HELPFUL",
						["unit"] = "player",
					},
					["untrigger"] = {
					},
				}, -- [3]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["wordWrap"] = "WordWrap",
			["font"] = "Friz Quadrata TT",
			["version"] = 2,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_namerealm"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["namerealm"] = "xxx",
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 24,
			["shadowXOffset"] = 1,
			["preferToUpdate"] = false,
			["regionType"] = "text",
			["displayText_format_c_format"] = "none",
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["fixedWidth"] = 200,
			["anchorFrameParent"] = false,
			["automaticWidth"] = "Auto",
			["authorOptions"] = {
			},
			["config"] = {
			},
			["semver"] = "1.0.1",
			["tocversion"] = 11306,
			["id"] = "MobHPPercentYELLOW",
			["shadowYOffset"] = -1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["xOffset"] = 0,
			["uid"] = "skENiiv2ip)",
			["justify"] = "LEFT",
			["selfPoint"] = "BOTTOM",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["parent"] = "TARGET HP PERCENT",
		},
		["Redoubt"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["wagoID"] = "v9qxdDgI4",
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["sparkHeight"] = 30,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["sparkOffsetX"] = 0,
			["cooldownSwipe"] = true,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Redoubt", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showOnReady",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["type"] = "aura2",
						["unevent"] = "auto",
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["use_unit"] = true,
						["event"] = "Action Usable",
						["spellName"] = 34428,
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_genericShowOn"] = true,
						["useName"] = true,
						["names"] = {
						},
						["use_track"] = true,
						["useIgnoreName"] = false,
					},
					["untrigger"] = {
						["genericShowOn"] = "showOnReady",
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
			["useTooltip"] = false,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["parent"] = "Vermin Paladin",
			["authorOptions"] = {
			},
			["barColor"] = {
				0.2, -- [1]
				1, -- [2]
				0.0862745098039216, -- [3]
				1, -- [4]
			},
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["internalVersion"] = 70,
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.75,
					["type"] = "subglow",
					["useGlowColor"] = true,
					["text_color"] = {
					},
					["glowThickness"] = 2,
					["glowDuration"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0.85098039215686, -- [2]
						0.1843137254902, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 16,
					["glow"] = true,
					["glowScale"] = 1,
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_p_time_precision"] = 1,
					["text_text"] = "%p",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_mod_rate"] = true,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_shadowXOffset"] = 0,
					["text_visible"] = true,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_p_format"] = "timed",
				}, -- [3]
				{
					["text_shadowXOffset"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_p_time_legacy_floor"] = false,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["anchorYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["type"] = "subtext",
					["text_text_format_p_time_precision"] = 1,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = 0,
					["text_anchorYOffset"] = 25,
					["text_text_format_p_time_mod_rate"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_fontType"] = "OUTLINE",
					["text_text_format_p_time_format"] = 0,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
				}, -- [4]
			},
			["height"] = 40,
			["selfPoint"] = "CENTER",
			["load"] = {
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "PALADIN",
					["multi"] = {
					},
				},
				["use_class"] = true,
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["use_level"] = false,
				["level"] = {
					"60", -- [1]
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["uid"] = "NlXQ18Rjuhe",
			["cooldown"] = false,
			["desaturate"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["displayIcon"] = "",
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "icon",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["config"] = {
			},
			["icon_side"] = "RIGHT",
			["anchorFrameFrame"] = "PlayerFrame",
			["sparkHidden"] = "NEVER",
			["anchorFrameParent"] = false,
			["texture"] = "Melli",
			["anchorFrameType"] = "SCREEN",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["auto"] = false,
			["useCooldownModRate"] = true,
			["id"] = "Redoubt",
			["zoom"] = 0.3,
			["alpha"] = 1,
			["width"] = 40,
			["spark"] = false,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["inverse"] = false,
			["frameStrata"] = 1,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["cooldownTextDisabled"] = false,
		},
		["Time To Die - Background"] = {
			["wagoID"] = "_AoX6WW26",
			["parent"] = "Global - Time To Die",
			["preferToUpdate"] = false,
			["customText"] = "function(...)\n    local health = UnitHealth(\"target\")\n    local time = GetTime()\n    local text = \" - - \"\n    local oldhealth\n    if oldhealth ~= health then\n        oldhealth = health\n        if health == UnitHealthMax(\"target\") then\n            health0, time0, mhealth, mtime = nil\n            text = \" - - \"\n            return text\n        end\n        \n        if not health0 then -- GOOD\n            health0, time0 = health, time\n            mhealth, mtime = health, time\n            return \" - - \"\n        end\n        \n        mhealth = (mhealth + health) * .5\n        mtime = (mtime + time) * .5\n        \n        if mhealth >= health0 then\n            text = \" - - \"\n            health0, time0, mhealth, mtime = nil\n        else\n            time = health * (time0 - mtime) / (mhealth - health0)\n            if (time <= 60) then\n                text = format(\"00:%0.2d\", time)           \n            elseif (time > 60) then\n                text = format(\"%d:%0.2d\", time / 60, time % 60)\n            end\n            return text\n        end\n    end\n    return text\nend",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["url"] = "https://wago.io/_AoX6WW26/1",
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
						["type"] = "unit",
						["use_hostility"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Unit Characteristics",
						["hostility"] = "hostile",
						["names"] = {
						},
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["unit"] = "target",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
						["unit"] = "target",
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["rotation"] = 0,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 25,
			["rotate"] = true,
			["load"] = {
				["use_never"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["textureWrapMode"] = "CLAMPTOBLACKADDITIVE",
			["source"] = "import",
			["mirror"] = false,
			["anchorFrameFrame"] = "WeakAuras:TimeToDie - Text",
			["regionType"] = "texture",
			["blendMode"] = "BLEND",
			["texture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_FullWhite",
			["alpha"] = 1,
			["authorOptions"] = {
			},
			["semver"] = "1.0.0",
			["tocversion"] = 20503,
			["id"] = "Time To Die - Background",
			["color"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SELECTFRAME",
			["xOffset"] = 25,
			["config"] = {
			},
			["uid"] = "ZzlwpmGqSM4",
			["width"] = 50,
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["selfPoint"] = "CENTER",
		},
		["Entering Combat"] = {
			["outline"] = "THICKOUTLINE",
			["wagoID"] = "03U1JIxdy",
			["parent"] = "Fade in-out Text Combat Indicator",
			["displayText"] = "Entering Combat",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/03U1JIxdy/1",
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
						["showClones"] = true,
						["useName"] = false,
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Unit Characteristics",
						["unit"] = "player",
						["use_inCombat"] = true,
						["auranames"] = {
							"Shadowform", -- [1]
						},
						["spellIds"] = {
						},
						["use_unit"] = true,
						["names"] = {
						},
						["type"] = "unit",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["colorR"] = 1,
					["duration_type"] = "seconds",
					["alphaType"] = "straight",
					["colorA"] = 1,
					["colorG"] = 1,
					["alphaFunc"] = "function(progress, start, delta)\n    return start + (progress * delta)\nend\n",
					["use_translate"] = true,
					["use_alpha"] = true,
					["type"] = "custom",
					["easeType"] = "none",
					["translateFunc"] = "function(progress, startX, startY, deltaX, deltaY)\n    return startX + (progress * deltaX), startY + (progress * deltaY)\nend\n",
					["scaley"] = 1,
					["alpha"] = 0,
					["scalex"] = 1,
					["y"] = 0,
					["x"] = -200,
					["use_color"] = false,
					["easeStrength"] = 3,
					["colorB"] = 1,
					["rotate"] = 0,
					["translateType"] = "straightTranslate",
					["duration"] = "2",
				},
				["main"] = {
					["colorR"] = 1,
					["scalex"] = 1,
					["alphaType"] = "hide",
					["colorA"] = 1,
					["colorG"] = 1,
					["alphaFunc"] = "function()\n    return 0\nend\n",
					["use_translate"] = false,
					["use_alpha"] = true,
					["type"] = "custom",
					["easeType"] = "none",
					["translateFunc"] = "    function(progress, startX, startY, deltaX, deltaY)\n      return startX + (progress * deltaX), startY + (progress * deltaY)\n    end\n  ",
					["scaley"] = 1,
					["alpha"] = 0,
					["y"] = 0,
					["x"] = 200,
					["colorB"] = 1,
					["duration"] = "",
					["easeStrength"] = 3,
					["rotate"] = 0,
					["translateType"] = "straightTranslate",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["colorR"] = 1,
					["scalex"] = 1,
					["alphaType"] = "straight",
					["colorA"] = 1,
					["colorG"] = 1,
					["alphaFunc"] = "    function(progress, start, delta)\n      return start + (progress * delta)\n    end\n  ",
					["use_translate"] = true,
					["use_alpha"] = true,
					["type"] = "none",
					["easeType"] = "none",
					["translateFunc"] = "    function(progress, startX, startY, deltaX, deltaY)\n      return startX + (progress * deltaX), startY + (progress * deltaY)\n    end\n  ",
					["scaley"] = 1,
					["alpha"] = 0,
					["y"] = 0,
					["x"] = 200,
					["colorB"] = 1,
					["rotate"] = 0,
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["translateType"] = "straightTranslate",
				},
			},
			["desc"] = "Made by cakemos",
			["font"] = "Friz Quadrata TT",
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_never"] = false,
				["talent"] = {
					["single"] = 98,
					["multi"] = {
						[56] = true,
						[98] = true,
					},
				},
				["zoneIds"] = "",
				["class"] = {
					["single"] = "PRIEST",
					["multi"] = {
						["PRIEST"] = true,
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
			["fontSize"] = 40,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["regionType"] = "text",
			["fixedWidth"] = 200,
			["automaticWidth"] = "Auto",
			["authorOptions"] = {
			},
			["yOffset"] = 0,
			["wordWrap"] = "WordWrap",
			["semver"] = "1.0.0",
			["justify"] = "LEFT",
			["tocversion"] = 30400,
			["id"] = "Entering Combat",
			["uid"] = "2kfOrK4jgEH",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["xOffset"] = 0,
			["config"] = {
			},
			["selfPoint"] = "BOTTOM",
			["color"] = {
				1, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["preferToUpdate"] = false,
		},
		["Energy Bar"] = {
			["overlays"] = {
				{
					0.43529411764706, -- [1]
					0, -- [2]
					1, -- [3]
					0.25, -- [4]
				}, -- [1]
			},
			["iconSource"] = -1,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -300,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["url"] = "https://wago.io/HCaWT5tJa/14",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["custom"] = "if aura_env.region then\n    local r = aura_env.region\n    if not r.text3 then\n        local text3 = r.bar:CreateFontString(nil, \"OVERLAY\")\n        r.text3 = text3\n        r.text3:SetJustifyH(\"CENTER\")\n        r.text3:SetJustifyV(\"MIDDLE\")\n        r.text3:SetPoint(\"CENTER\", r.bar, \"CENTER\")\n        r.text3:Show()\n    end\n    r.text3:SetShadowOffset(1, -1)\n    r.text3:SetFont(r.text:GetFont())\n    r.text3:SetTextColor(r.text:GetTextColor())\nend\n\n\n\n\n\n\n",
					["do_custom"] = false,
				},
				["finish"] = {
				},
			},
			["fontFlags"] = "OUTLINE",
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["enableGradient"] = false,
			["selfPoint"] = "CENTER",
			["barColor"] = {
				1, -- [1]
				0.82352941176471, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["sparkOffsetY"] = 0,
			["gradientOrientation"] = "HORIZONTAL",
			["load"] = {
				["zoneIds"] = "",
				["ingroup"] = {
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
					["single"] = "DRUID",
					["multi"] = {
						["ROGUE"] = true,
						["DRUID"] = true,
					},
				},
				["use_petbattle"] = false,
				["role"] = {
					["multi"] = {
					},
				},
				["use_class"] = false,
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
				["difficulty"] = {
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
				["talent2"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["texture"] = "xVerminClean",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["spark"] = false,
			["tocversion"] = 11302,
			["alpha"] = 1,
			["uid"] = "c5D6XJKEyid",
			["sparkOffsetX"] = 0,
			["parent"] = "MANA BAR + DRUID / ROGUE CPOINTS",
			["customText"] = "",
			["sparkRotationMode"] = "AUTO",
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "1",
						["genericShowOn"] = "showOnActive",
						["names"] = {
						},
						["powertype"] = 3,
						["use_powertype"] = true,
						["custom_hide"] = "timed",
						["use_power"] = false,
						["type"] = "unit",
						["use_health"] = true,
						["unevent"] = "auto",
						["health_operator"] = ">=",
						["unit"] = "player",
						["use_requirePowerType"] = true,
						["use_percentpower"] = false,
						["debuffType"] = "HELPFUL",
						["health"] = "0",
						["spellIds"] = {
						},
						["event"] = "Power",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["use_showCost"] = true,
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "all",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
			},
			["backdropInFront"] = false,
			["stickyDuration"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subforeground",
				}, -- [2]
				{
					["text_shadowXOffset"] = 1,
					["text_text"] = "%p",
					["text_text_format_t_time_legacy_floor"] = false,
					["text_text_format_t_time_dynamic_threshold"] = 60,
					["text_text_format_p_format"] = "timed",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_text_format_c_format"] = "none",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_t_time_format"] = 0,
					["text_text_format_p_time_legacy_floor"] = false,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_t_format"] = "timed",
					["text_text_format_p_time_mod_rate"] = true,
					["text_fontType"] = "None",
					["type"] = "subtext",
					["text_visible"] = true,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Arial Narrow",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_shadowYOffset"] = -1,
					["text_text_format_p_time_format"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_text_format_t_time_mod_rate"] = true,
					["text_anchorPoint"] = "INNER_RIGHT",
					["text_text_format_p_time_precision"] = 1,
					["anchorYOffset"] = 0,
					["text_fontSize"] = 15,
					["anchorXOffset"] = 0,
					["text_text_format_t_time_precision"] = 1,
				}, -- [3]
				{
					["text_shadowXOffset"] = 1,
					["text_text"] = " ",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Arial Narrow",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_LEFT",
					["text_fontSize"] = 18,
					["anchorXOffset"] = 0,
					["text_fontType"] = "None",
				}, -- [4]
				{
					["text_shadowXOffset"] = 1,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Arial Narrow",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "ICON_CENTER",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_fontType"] = "None",
				}, -- [5]
			},
			["height"] = 20,
			["sparkBlendMode"] = "ADD",
			["backdropColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["sparkWidth"] = 10,
			["barColor2"] = {
				1, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["config"] = {
			},
			["xOffset"] = 0.0003662109375,
			["borderInFront"] = true,
			["customTextUpdate"] = "event",
			["icon_side"] = "RIGHT",
			["backgroundColor"] = {
				1, -- [1]
				0.82352941176471, -- [2]
				0, -- [3]
				0.30000001192093, -- [4]
			},
			["icon"] = false,
			["sparkHeight"] = 30,
			["zoom"] = 0,
			["overlaysTexture"] = {
				"xVerminClean", -- [1]
			},
			["anchorFrameType"] = "SCREEN",
			["semver"] = "1.0.13",
			["sparkHidden"] = "NEVER",
			["id"] = "Energy Bar",
			["auto"] = true,
			["frameStrata"] = 3,
			["width"] = 245,
			["useAdjustededMax"] = false,
			["borderBackdrop"] = "None",
			["inverse"] = false,
			["sparkDesature"] = false,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["CP5"] = {
			["color"] = {
				0.99607843137255, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -283,
			["anchorPoint"] = "CENTER",
			["url"] = "https://wago.io/HCaWT5tJa/14",
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
						["use_power"] = true,
						["genericShowOn"] = "showOnActive",
						["use_unit"] = true,
						["powertype"] = 4,
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "unit",
						["unevent"] = "auto",
						["power_operator"] = {
							"==", -- [1]
						},
						["event"] = "Power",
						["unit"] = "player",
						["power"] = {
							"5", -- [1]
						},
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["use_requirePowerType"] = false,
						["names"] = {
						},
						["duration"] = "1",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["itemName"] = 150936,
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["genericShowOn"] = "showOnActive",
						["subeventPrefix"] = "SPELL",
						["unit"] = "player",
						["use_unit"] = true,
						["use_itemName"] = true,
						["unevent"] = "auto",
						["use_inverse"] = true,
						["event"] = "Item Equipped",
						["type"] = "item",
					},
					["untrigger"] = {
						["itemName"] = 150936,
					},
				}, -- [2]
				["disjunctive"] = "all",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["duration_type"] = "seconds",
					["preset"] = "slideright",
					["easeStrength"] = 3,
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["duration_type"] = "seconds",
					["preset"] = "slideleft",
					["easeStrength"] = 3,
				},
			},
			["desaturate"] = false,
			["rotation"] = 0,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 10,
			["rotate"] = true,
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["ROGUE"] = true,
						["DRUID"] = true,
					},
				},
				["use_class"] = false,
				["role"] = {
					["multi"] = {
					},
				},
				["level"] = {
					"70", -- [1]
				},
				["zoneIds"] = "",
				["talent2"] = {
					["multi"] = {
					},
				},
				["affixes"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 9,
					["multi"] = {
						[7] = true,
						[9] = true,
					},
				},
				["use_vehicle"] = false,
				["spec"] = {
					["multi"] = {
					},
				},
				["level_operator"] = {
					"<", -- [1]
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
				["use_vehicleUi"] = false,
				["use_combat"] = true,
				["use_level"] = false,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["textureWrapMode"] = "CLAMP",
			["mirror"] = false,
			["regionType"] = "texture",
			["blendMode"] = "BLEND",
			["alpha"] = 1,
			["texture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_White",
			["discrete_rotation"] = 0,
			["xOffset"] = 99,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "CP5",
			["parent"] = "MANA BAR + DRUID / ROGUE CPOINTS",
			["frameStrata"] = 2,
			["width"] = 69,
			["config"] = {
			},
			["uid"] = "klWFLF0NXf8",
			["selfPoint"] = "CENTER",
			["anchorFrameType"] = "SCREEN",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["authorOptions"] = {
			},
		},
		["TARGET HP PERCENT"] = {
			["arcLength"] = 360,
			["controlledChildren"] = {
				"MobHPPercentGREEN", -- [1]
				"MobHPPercentYELLOW", -- [2]
				"MobHPPercentRED", -- [3]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = -90,
			["gridType"] = "RD",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["space"] = 2,
			["url"] = "https://wago.io/B_hMNakf_/2",
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
						["type"] = "unit",
						["use_alwaystrue"] = false,
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Conditions",
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
				["activeTriggerMode"] = 1,
			},
			["columnSpace"] = 1,
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["align"] = "CENTER",
			["desc"] = "Big display of target health percentage with Colors",
			["stagger"] = 0,
			["borderInset"] = 1,
			["version"] = 2,
			["limit"] = 1,
			["selfPoint"] = "TOP",
			["anchorPoint"] = "CENTER",
			["load"] = {
				["size"] = {
					["multi"] = {
					},
				},
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
				["talent2"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["use_class"] = "false",
				["role"] = {
					["multi"] = {
					},
				},
				["talent3"] = {
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
				["race"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["rowSpace"] = 1,
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["radius"] = 200,
			["animate"] = false,
			["useLimit"] = true,
			["scale"] = 1,
			["centerType"] = "LR",
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["stepAngle"] = 15,
			["borderSize"] = 2,
			["sort"] = "none",
			["rotation"] = 0,
			["config"] = {
			},
			["constantFactor"] = "RADIUS",
			["frameStrata"] = 1,
			["borderOffset"] = 4,
			["semver"] = "1.0.1",
			["tocversion"] = 11306,
			["id"] = "TARGET HP PERCENT",
			["authorOptions"] = {
			},
			["gridWidth"] = 5,
			["anchorFrameType"] = "SCREEN",
			["fullCircle"] = true,
			["uid"] = "RtwiT9kw4p3",
			["regionType"] = "dynamicgroup",
			["grow"] = "DOWN",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["groupIcon"] = 136168,
		},
		["Adamantite Ore"] = {
			["iconSource"] = -1,
			["parent"] = "Ore Count",
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = false,
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
						["itemName"] = 23425,
						["use_count"] = true,
						["duration"] = "1",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["type"] = "item",
						["subeventSuffix"] = "_CAST_START",
						["use_exact_itemName"] = true,
						["unit"] = "player",
						["use_itemName"] = true,
						["names"] = {
						},
						["use_includeBank"] = true,
						["use_absorbMode"] = true,
						["spellIds"] = {
						},
						["event"] = "Item Count",
						["count"] = "0",
						["unevent"] = "auto",
						["use_unit"] = true,
						["count_operator"] = ">",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_shadowXOffset"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_shadowYOffset"] = 0,
					["type"] = "subtext",
					["text_anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "PT Sans Narrow",
					["anchorXOffset"] = 0,
					["text_anchorYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_fontSize"] = 16,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
				{
					["glowFrequency"] = 0,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowDuration"] = 1,
					["useGlowColor"] = false,
					["glow"] = true,
					["glowThickness"] = 1,
					["glowScale"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 40,
			["load"] = {
				["use_namerealm"] = true,
				["ingroup"] = {
					["single"] = "solo",
				},
				["namerealm"] = "Mxzq",
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["use_ingroup"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["use_never"] = true,
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["source"] = "import",
			["uid"] = "ePmimnKBVju",
			["useTooltip"] = true,
			["xOffset"] = 0,
			["regionType"] = "icon",
			["information"] = {
				["forceEvents"] = true,
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["icon"] = true,
			["authorOptions"] = {
			},
			["anchorFrameParent"] = false,
			["zoom"] = 0.3,
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = false,
			["semver"] = "1.0.0",
			["tocversion"] = 90002,
			["id"] = "Adamantite Ore",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["width"] = 40,
			["useCooldownModRate"] = true,
			["config"] = {
			},
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["conditions"] = {
			},
			["cooldown"] = false,
			["url"] = "https://wago.io/iST6tz9t8/1",
		},
		["Blade Barrier"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["wagoID"] = "v9qxdDgI4",
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["sparkHeight"] = 30,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["sparkOffsetX"] = 0,
			["cooldownSwipe"] = true,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Blade Barrier", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showOnReady",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["type"] = "aura2",
						["unevent"] = "auto",
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["use_unit"] = true,
						["event"] = "Action Usable",
						["spellName"] = 34428,
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_genericShowOn"] = true,
						["useName"] = true,
						["names"] = {
						},
						["use_track"] = true,
						["useIgnoreName"] = false,
					},
					["untrigger"] = {
						["genericShowOn"] = "showOnReady",
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
			["internalVersion"] = 70,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["barColor"] = {
				0.2, -- [1]
				1, -- [2]
				0.0862745098039216, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["useTooltip"] = true,
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.75,
					["type"] = "subglow",
					["useGlowColor"] = true,
					["text_color"] = {
					},
					["glowThickness"] = 2,
					["glowDuration"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0.85098039215686, -- [2]
						0.1843137254902, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 16,
					["glow"] = true,
					["glowScale"] = 1,
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_p_time_precision"] = 1,
					["text_text"] = "%p",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_mod_rate"] = true,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_shadowXOffset"] = 0,
					["text_visible"] = true,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_p_format"] = "timed",
				}, -- [3]
			},
			["height"] = 40,
			["selfPoint"] = "CENTER",
			["load"] = {
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "DEATHKNIGHT",
					["multi"] = {
					},
				},
				["use_class"] = true,
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["use_level"] = false,
				["level"] = {
					"60", -- [1]
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["parent"] = "Vermin Death Knight",
			["cooldown"] = false,
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["displayIcon"] = "",
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "icon",
			["alpha"] = 1,
			["uid"] = "kNGL7WKGKAu",
			["icon_side"] = "RIGHT",
			["anchorFrameFrame"] = "PlayerFrame",
			["id"] = "Blade Barrier",
			["anchorFrameParent"] = false,
			["texture"] = "Melli",
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["spark"] = false,
			["frameStrata"] = 1,
			["sparkHidden"] = "NEVER",
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["useCooldownModRate"] = true,
			["width"] = 40,
			["cooldownTextDisabled"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["auto"] = false,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
		},
		["Av Timers"] = {
			["sparkWidth"] = 10,
			["glow"] = false,
			["iconSource"] = -1,
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = 1.6689300537109e-05,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["url"] = "https://wago.io/RDC5y57BB/14",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["custom"] = "C_ChatInfo.RegisterAddonMessagePrefix(\"AVT\")\naura_env.bosses = {\n    [11948] = true, -- Vanndar\n    [11946] = true, -- Drek\n    [11947] = true, -- Galv\n    [11949] = true, -- Balinda\n}\naura_env.timeTick = GetTime()\naura_env.locale = GetLocale()\naura_env.L = {\n    [\"enUS\"] = {\n        \"was taken by the\", -- HERALD/BG\n        \"(.-) was taken by the\", -- HERALD/BG\n        \"If left unchallenged, the\", -- BG\n        \"% claims the (.-)%!  If left unchallenged, the\", -- BG\n        \"If left unchecked, the\", -- HERALD\n        \"(.-) is under attack!  If left unchecked, the\", -- HERALD\n        \"Alliance\", -- HERALD ALLIANCE CHECK\n        \"1 minute until the battle for Alterac Valley begins.\", -- START\n        \"You are now AFK: Away from Keyboard\", -- AFK\n        \"WHO DARES SUMMON LOKHOLAR?\", -- Lokholar the Ice Lord\n    },\n}\n\n\n\nWorldStateScoreFrameLeaveButton:SetScript(\"PreClick\", function(self)\n        WeakAuras.ScanEvents(\"AVT_LEAVE\")\nend)\n\naura_env.timestamp = GetTime()\n\naura_env.IsBoss = function ()\n    \n    local _, _, _, _, _, id_mouseover = string.match(UnitGUID(\"mouseover\") or \"\",\"(%a+)-(%d+)-(%d+)-(%d+)-(%d+)-(%d+)\")\n    \n    if aura_env.bosses[tonumber(id_mouseover or 0)] == true then return true, UnitName(\"mouseover\"), UnitHealth(\"mouseover\") / UnitHealthMax(\"mouseover\") * 100 end\n    \n    if aura_env.timeTick + 0.5 < GetTime() then\n        aura_env.timeTick = GetTime() \n        \n        for unit in WA_IterateGroupMembers() do\n            local _, _, _, _, _, id = string.match(UnitGUID(unit .. \"target\") or \"\",\"(%a+)-(%d+)-(%d+)-(%d+)-(%d+)-(%d+)\")\n            \n            if aura_env.bosses[tonumber(id or 0)] == true then\n                return true, UnitName(unit .. \"target\"), UnitHealth(unit .. \"target\") / UnitHealthMax(unit .. \"target\") * 100\n            end\n        end\n        \n    end\n    \n    return false\nend",
					["do_custom"] = true,
				},
				["finish"] = {
					["do_custom"] = true,
				},
			},
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["enableGradient"] = false,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["barColor"] = {
				1, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["glowColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["sparkOffsetY"] = 0,
			["gradientOrientation"] = "HORIZONTAL",
			["load"] = {
				["use_namerealm"] = true,
				["use_never"] = false,
				["zone"] = "Alterac Valley",
				["class"] = {
					["multi"] = {
					},
				},
				["use_encounterid"] = false,
				["use_zone"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["namerealm"] = "never",
				["spec"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["glowType"] = "buttonOverlay",
			["glowThickness"] = 1,
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["texture"] = "Melli",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["auto"] = true,
			["glowScale"] = 1,
			["alpha"] = 1,
			["glowYOffset"] = 0,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["sparkOffsetX"] = 0,
			["wagoID"] = "RDC5y57BB",
			["parent"] = "AV Timers",
			["cooldownSwipe"] = true,
			["sparkRotationMode"] = "AUTO",
			["cooldownEdge"] = false,
			["useglowColor"] = false,
			["internalVersion"] = 70,
			["glowXOffset"] = 0,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subforeground",
				}, -- [2]
				{
					["text_text_format_p_time_precision"] = 1,
					["text_text"] = "%p",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_mod_rate"] = true,
					["type"] = "subtext",
					["anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Expressway",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = -1,
					["text_fontType"] = "None",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_RIGHT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowXOffset"] = 1,
					["text_fontSize"] = 10,
					["text_text_format_p_time_dynamic_threshold"] = 3,
					["anchorYOffset"] = 0,
				}, -- [3]
				{
					["text_text_format_n_format"] = "none",
					["text_text"] = "%n",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Expressway",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "INNER_LEFT",
					["text_visible"] = true,
					["text_fontSize"] = 10,
					["anchorXOffset"] = 0,
					["text_shadowXOffset"] = 1,
				}, -- [4]
			},
			["height"] = 12,
			["glowLines"] = 8,
			["sparkBlendMode"] = "ADD",
			["glowFrequency"] = 0.25,
			["source"] = "import",
			["spark"] = false,
			["barColor2"] = {
				1, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["glowLength"] = 10,
			["icon"] = false,
			["zoom"] = 0,
			["tocversion"] = 20503,
			["useAdjustededMax"] = false,
			["icon_side"] = "RIGHT",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["width"] = 250,
			["anchorFrameParent"] = false,
			["sparkHeight"] = 30,
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["custom_type"] = "stateupdate",
						["customVariables"] = "{\n    horde = \"bool\",\n    start = \"bool\",\n    boss = \"bool\",\n    lokholar = \"bool\",\n}",
						["event"] = "Health",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["events"] = "AVT_LEAVE CHAT_MSG_SYSTEM CHAT_MSG_MONSTER_YELL CHAT_MSG_BG_SYSTEM_ALLIANCE CHAT_MSG_BG_SYSTEM_HORDE CHAT_MSG_BG_SYSTEM_NEUTRAL CHAT_MSG_ADDON COMBAT_LOG_EVENT_UNFILTERED:UNIT_DIED",
						["names"] = {
						},
						["check"] = "event",
						["spellIds"] = {
						},
						["custom"] = "function(s, e, ...)\n    \n    -- Boss Death\n    if (e == \"COMBAT_LOG_EVENT_UNFILTERED\") then\n        local _, _, _, _, _, _, _, guid, bossName = select(1, ...)\n        local _, _, _, _, _, id = string.match(guid or \"\",\"(%a+)-(%d+)-(%d+)-(%d+)-(%d+)-(%d+)\")\n        \n        if aura_env.bosses[tonumber(id or 0)] == true then\n            C_ChatInfo.SendAddonMessage(\"AVT\", bossName .. \": \" .. 0, \"INSTANCE_CHAT\") \n            return true\n        end\n    end\n    \n    -- Boss HP\n    local prefix, text = select(1, ...)\n    \n    if (e == \"CHAT_MSG_ADDON\") and prefix == \"AVT\" then\n        local bossName = string.match(text or \"\", \"(.-):\")\n        local bossHP = tonumber(string.match(text, \"%d+\"))\n        \n        \n        if bossHP == 0 then\n            s[bossName] = {\n                show = false,\n                changed = true\n            }\n        else\n            s[bossName] = {\n                show = true,\n                changed = true,\n                progressType = \"static\",\n                total = 100,\n                value  = bossHP,\n                name = bossName,\n                index = -100000000000,\n                boss = true\n            }\n        end\n        \n        return true\n    end\n    \n    local msg = select(1,...)\n    \n    -- Clear timers\n    if e == \"AVT_LEAVE\" or \n    (e == \"CHAT_MSG_SYSTEM\" and string.find(msg or \"\", aura_env.L[aura_env.locale][9]) or 0 > 0) then\n        for _, state in pairs(s) do\n            state.show = false;\n            state.changed = true;\n        end\n        \n        return true\n    end\n    \n    -- BG begins timer\n    if e == \"CHAT_MSG_BG_SYSTEM_NEUTRAL\" then\n        if (string.find(msg or \"\", aura_env.L[aura_env.locale][8]) or 0 > 0) then\n            s[\"begin\"] = {\n                show = true,\n                changed = true,      \n                progressType = \"timed\",\n                duration = 62,\n                expirationTime = GetTime() + 62,\n                name = \"Begins\",\n                index = 0,\n                autoHide = true,\n                start = true\n            }\n        end\n        return true\n    end\n    \n    -- Tower/GY timers\n    if e == \"CHAT_MSG_BG_SYSTEM_ALLIANCE\" or \n    e == \"CHAT_MSG_BG_SYSTEM_HORDE\" or \n    e == \"CHAT_MSG_MONSTER_YELL\" then\n        \n        -- Re-take\n        if (string.find(msg or \"\", aura_env.L[aura_env.locale][1]) or 0 > 0) then\n            local tower = string.match(msg or \"\", aura_env.L[aura_env.locale][2])\n            \n            if s[tower] then\n                s[tower] = {\n                    show = false,\n                    changed = true,\n                }\n                return true\n            end\n        end\n        \n        -- Take\n        if (e == \"CHAT_MSG_MONSTER_YELL\" and \n            string.find(msg or \"\", aura_env.L[aura_env.locale][5]) or 0 > 0 or \n            string.find(msg or \"\", aura_env.L[aura_env.locale][3]) or 0 > 0) then\n            \n            local tower = (e == \"CHAT_MSG_MONSTER_YELL\" and \n                string.match(msg or \"\", aura_env.L[aura_env.locale][6]) or\n                string.match(msg or \"\", aura_env.L[aura_env.locale][4]))\n            \n            s[tower] = {\n                show = true,\n                changed = true,      \n                progressType = \"timed\",\n                duration = 240,\n                expirationTime = GetTime() + 240,\n                name = tower,\n                index = -(GetTime() + 240),\n                autoHide = true,\n                horde = (e == \"CHAT_MSG_MONSTER_YELL\" and \n                    (string.find(msg or \"\", aura_env.L[aura_env.locale][7]) or 0 > 0 and false or true) or\n                    (e == \"CHAT_MSG_BG_SYSTEM_ALLIANCE\" and false or true))\n            }\n            return true\n        end\n        \n        -- Lokholar the Ice Lord\n        if (e == \"CHAT_MSG_MONSTER_YELL\" and string.find(msg or \"\", aura_env.L[aura_env.locale][10])) then\n            \n            s[\"lokholar\"] = {\n                show = true,\n                changed = true,      \n                progressType = \"timed\",\n                duration = 600,\n                expirationTime = GetTime() + 600,\n                name = \"Lokholar\",\n                index = -(GetTime() + 600),\n                autoHide = true,\n                lokholar = true\n            }\n            return true\n        end\n        \n    end\n    \nend",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "custom",
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Health",
						["use_unit"] = true,
						["custom"] = "function()\n    \n    if GetTime() > aura_env.timestamp + 0.1 then \n        \n        aura_env.timestamp = GetTime()\n        \n        local found, bossName, bossHP = aura_env.IsBoss()\n        \n        if found == true then \n            C_ChatInfo.SendAddonMessage(\"AVT\", bossName .. \": \" .. bossHP, \"INSTANCE_CHAT\") \n        end    \n        \n    end\n    \nend",
						["subeventPrefix"] = "SPELL",
						["check"] = "update",
						["unit"] = "player",
						["custom_type"] = "status",
						["subeventSuffix"] = "_CAST_START",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["sparkHidden"] = "NEVER",
			["semver"] = "1.0.13",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["id"] = "Av Timers",
			["uid"] = "xLlxouEMW)Z",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["config"] = {
			},
			["cooldownTextDisabled"] = false,
			["inverse"] = true,
			["authorOptions"] = {
			},
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "horde",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = {
								0, -- [1]
								0, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["property"] = "barColor",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "start",
						["value"] = 1,
					},
					["changes"] = {
						{
							["property"] = "barColor",
						}, -- [1]
					},
				}, -- [2]
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "boss",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["property"] = "barColor",
						}, -- [1]
						{
							["value"] = 29.999983310699,
							["property"] = "yOffsetRelative",
						}, -- [2]
					},
				}, -- [3]
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "lokholar",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = {
								0, -- [1]
								1, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["property"] = "barColor",
						}, -- [1]
					},
				}, -- [4]
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["glowBorder"] = false,
		},
		["MISSING BUFFS"] = {
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["controlledChildren"] = {
				"PALADIN", -- [1]
				"DRUID", -- [2]
				"PRIEST", -- [3]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["scale"] = 1,
			["border"] = false,
			["yOffset"] = 400,
			["anchorPoint"] = "CENTER",
			["borderSize"] = 2,
			["regionType"] = "group",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["xOffset"] = -400,
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
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["event"] = "Health",
						["names"] = {
						},
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["internalVersion"] = 70,
			["borderEdge"] = "Square Full White",
			["selfPoint"] = "CENTER",
			["id"] = "MISSING BUFFS",
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["borderOffset"] = 4,
			["borderInset"] = 1,
			["config"] = {
			},
			["uid"] = "Q6V((Odtb2N",
			["conditions"] = {
			},
			["load"] = {
				["talent"] = {
					["multi"] = {
					},
				},
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
			["authorOptions"] = {
			},
		},
		["PRIEST"] = {
			["iconSource"] = -1,
			["wagoID"] = "v9qxdDgI4",
			["parent"] = "MISSING BUFFS",
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/v9qxdDgI4/2",
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
					["glow_action"] = "hide",
				},
				["init"] = {
					["do_custom"] = false,
					["custom"] = "\nfunction()\n    \n    return\nend",
				},
				["finish"] = {
					["do_custom"] = false,
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Power Word: Fortitude", -- [1]
						},
						["matchesShowOn"] = "showOnMissing",
						["genericShowOn"] = "showOnReady",
						["use_unit"] = true,
						["use_genericShowOn"] = true,
						["debuffType"] = "HELPFUL",
						["unevent"] = "auto",
						["useName"] = true,
						["subeventSuffix"] = "_CAST_START",
						["useExactSpellId"] = false,
						["duration"] = "1",
						["subeventPrefix"] = "SPELL",
						["event"] = "Action Usable",
						["names"] = {
						},
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["type"] = "aura2",
						["unit"] = "player",
						["useNamePattern"] = false,
						["use_track"] = true,
						["spellName"] = 34428,
					},
					["untrigger"] = {
						["genericShowOn"] = "showOnReady",
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["useTooltip"] = false,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "relative",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 2,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_text_format_t_time_precision"] = 1,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%n",
					["text_text_format_p_realm_name"] = "never",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_fixedWidth"] = 64,
					["rotateText"] = "NONE",
					["text_text_format_p_decimal_precision"] = 1,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_text_format_p_color"] = true,
					["text_fontSize"] = 18,
					["anchorXOffset"] = 0,
					["text_text_format_n_format"] = "none",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_text_format_t_time_format"] = 0,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["text_text_format_t_format"] = "timed",
					["type"] = "subtext",
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_precision"] = 1,
					["text_anchorYOffset"] = 45,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_text_format_t_time_dynamic_threshold"] = 60,
					["text_text_format_p_abbreviate"] = false,
					["text_anchorPoint"] = "CENTER",
					["text_shadowXOffset"] = 0,
					["text_text_format_p_big_number_format"] = "AbbreviateNumbers",
					["text_text_format_p_abbreviate_max"] = 8,
					["text_fontType"] = "THICKOUTLINE",
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
				{
					["glowFrequency"] = 0.25,
					["type"] = "subglow",
					["useGlowColor"] = false,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowDuration"] = 1,
					["glow"] = false,
					["glowScale"] = 1,
					["glowThickness"] = 1,
					["glowXOffset"] = 0,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 65.000022888184,
			["load"] = {
				["use_namerealm"] = false,
				["use_never"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["use_alive"] = true,
				["use_combat"] = true,
				["use_class"] = false,
				["use_spellknown"] = false,
				["namerealm"] = "xxx",
				["class"] = {
					["single"] = "PALADIN",
					["multi"] = {
						["PRIEST"] = true,
					},
				},
				["use_level"] = false,
				["level"] = {
					"60", -- [1]
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["useCooldownModRate"] = false,
			["width"] = 65.000114440918,
			["xOffset"] = 0,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["displayIcon"] = "",
			["regionType"] = "icon",
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["internalVersion"] = 70,
			["uid"] = "L9IW(XZ2MhM",
			["selfPoint"] = "CENTER",
			["alpha"] = 1,
			["semver"] = "1.0.1",
			["zoom"] = 0.3,
			["auto"] = false,
			["tocversion"] = 20501,
			["id"] = "PRIEST",
			["cooldownTextDisabled"] = false,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["cooldownEdge"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["authorOptions"] = {
			},
			["conditions"] = {
			},
			["cooldown"] = false,
			["icon"] = true,
		},
		["Timer"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "v9qxdDgI4",
			["authorOptions"] = {
			},
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["yOffset"] = 40,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["url"] = "https://wago.io/v9qxdDgI4/2",
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
						["use_destFlags2"] = false,
						["names"] = {
						},
						["subeventSuffix"] = "",
						["unit"] = "player",
						["duration"] = "20",
						["event"] = "Combat Log",
						["use_critical"] = true,
						["subeventPrefix"] = "PARTY_KILL",
						["type"] = "combatlog",
						["spellIds"] = {
						},
						["use_sourceUnit"] = true,
						["use_sourceFlags2"] = false,
						["use_destUnit"] = false,
						["sourceUnit"] = "player",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["use_destFlags2"] = false,
						["spellId"] = "34428",
						["duration"] = "0",
						["genericShowOn"] = "showOnCooldown",
						["subeventPrefix"] = "SPELL",
						["names"] = {
						},
						["debuffType"] = "HELPFUL",
						["sourceUnit"] = "player",
						["type"] = "spell",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["use_genericShowOn"] = true,
						["use_spellId"] = false,
						["event"] = "Action Usable",
						["use_critical"] = true,
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = true,
						["use_sourceFlags2"] = false,
						["use_destUnit"] = false,
						["use_track"] = true,
						["spellName"] = 402927,
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["displayText_format_p_time_legacy_floor"] = true,
			["selfPoint"] = "BOTTOM",
			["font"] = "PT Sans Narrow",
			["version"] = 2,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
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
			["fontSize"] = 25,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["preferToUpdate"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["regionType"] = "text",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["displayText_format_p_time_mod_rate"] = true,
			["automaticWidth"] = "Auto",
			["displayText_format_p_time_precision"] = 1,
			["uid"] = "4)0S2Za6LFo",
			["wordWrap"] = "WordWrap",
			["semver"] = "1.0.1",
			["justify"] = "LEFT",
			["tocversion"] = 20501,
			["id"] = "Timer",
			["shadowYOffset"] = -1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["xOffset"] = 0,
			["config"] = {
			},
			["internalVersion"] = 70,
			["parent"] = "VictoryRush",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["displayText"] = "%p",
		},
		["PALADIN"] = {
			["iconSource"] = -1,
			["wagoID"] = "v9qxdDgI4",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = false,
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
						["useName"] = true,
						["auranames"] = {
							"Seal of Command", -- [1]
						},
						["matchesShowOn"] = "showOnMissing",
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
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["useTooltip"] = false,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 2,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_text_format_p_time_precision"] = 1,
					["text_text_format_s_format"] = "none",
					["text_text_format_p_big_number_format"] = "AbbreviateNumbers",
					["text_text_format_p_realm_name"] = "never",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_fixedWidth"] = 64,
					["rotateText"] = "NONE",
					["text_text_format_p_decimal_precision"] = 1,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_text_format_p_color"] = true,
					["text_fontSize"] = 18,
					["anchorXOffset"] = 0,
					["text_text_format_n_format"] = "none",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_text_format_t_time_format"] = 0,
					["anchorYOffset"] = 0,
					["text_text_format_p_abbreviate"] = false,
					["text_text_format_t_format"] = "timed",
					["type"] = "subtext",
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_anchorYOffset"] = 45,
					["text_text_format_t_time_dynamic_threshold"] = 60,
					["text_justify"] = "CENTER",
					["text_text_format_p_abbreviate_max"] = 8,
					["text_anchorPoint"] = "CENTER",
					["text_shadowXOffset"] = 0,
					["text_text"] = "%n",
					["text_text_format_p_time_format"] = 0,
					["text_text_format_t_time_precision"] = 1,
					["text_fontType"] = "THICKOUTLINE",
				}, -- [2]
				{
					["glowFrequency"] = 0.25,
					["glow"] = false,
					["useGlowColor"] = false,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowDuration"] = 1,
					["type"] = "subglow",
					["glowThickness"] = 1,
					["glowScale"] = 1,
					["glowXOffset"] = 0,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 65.000022888184,
			["load"] = {
				["use_level"] = false,
				["talent"] = {
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
				["use_alive"] = true,
				["use_combat"] = true,
				["level_operator"] = {
					">=", -- [1]
				},
				["use_exact_spellknown"] = false,
				["use_never"] = true,
				["level"] = {
					"60", -- [1]
				},
				["class"] = {
					["single"] = "PALADIN",
					["multi"] = {
						["PALADIN"] = true,
					},
				},
				["zoneIds"] = "",
			},
			["frameStrata"] = 1,
			["width"] = 65.000114440918,
			["icon"] = true,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["displayIcon"] = "",
			["regionType"] = "icon",
			["parent"] = "MISSING BUFFS",
			["internalVersion"] = 70,
			["uid"] = "OjIToprvHv1",
			["url"] = "https://wago.io/v9qxdDgI4/2",
			["alpha"] = 1,
			["semver"] = "1.0.1",
			["zoom"] = 0.3,
			["auto"] = false,
			["tocversion"] = 20501,
			["id"] = "PALADIN",
			["cooldownTextDisabled"] = false,
			["useCooldownModRate"] = true,
			["anchorFrameType"] = "SCREEN",
			["authorOptions"] = {
			},
			["config"] = {
			},
			["inverse"] = false,
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["conditions"] = {
			},
			["cooldown"] = false,
			["xOffset"] = 0,
		},
		["Aspect of the Hawk"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["wagoID"] = "v9qxdDgI4",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["parent"] = "Vermin Hunter",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["sparkOffsetX"] = 0,
			["cooldownSwipe"] = true,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
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
						["auranames"] = {
							"Aspect of the Hawk", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showOnReady",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
						["matchesShowOn"] = "showOnMissing",
						["useName"] = true,
						["names"] = {
						},
						["unevent"] = "auto",
						["unit"] = "player",
						["spellName"] = 34428,
						["event"] = "Action Usable",
						["use_genericShowOn"] = true,
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["type"] = "aura2",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["use_track"] = true,
						["useIgnoreName"] = false,
					},
					["untrigger"] = {
						["genericShowOn"] = "showOnReady",
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
			["useTooltip"] = false,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["xOffset"] = 0,
			["authorOptions"] = {
			},
			["barColor"] = {
				0.2, -- [1]
				1, -- [2]
				0.0862745098039216, -- [3]
				1, -- [4]
			},
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["icon"] = true,
			["internalVersion"] = 70,
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.75,
					["type"] = "subglow",
					["useGlowColor"] = true,
					["text_color"] = {
					},
					["glowThickness"] = 2,
					["glowDuration"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0.85098039215686, -- [2]
						0.1843137254902, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 16,
					["glow"] = true,
					["glowScale"] = 1,
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_p_time_precision"] = 1,
					["text_text"] = "%p",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_shadowXOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
				}, -- [3]
				{
					["text_text_format_p_time_precision"] = 1,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_legacy_floor"] = false,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["type"] = "subtext",
					["text_shadowXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_anchorYOffset"] = 25,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_visible"] = true,
					["text_text_format_p_time_format"] = 0,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
				}, -- [4]
			},
			["height"] = 40,
			["selfPoint"] = "CENTER",
			["load"] = {
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["use_class"] = true,
				["use_spellknown"] = false,
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["use_level"] = true,
				["level"] = {
					"10", -- [1]
				},
				["class"] = {
					["single"] = "HUNTER",
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
			["uid"] = "QdrVWzVpDS5",
			["cooldown"] = false,
			["desaturate"] = false,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["displayIcon"] = "",
			["smoothProgress"] = true,
			["anchorFrameFrame"] = "PlayerFrame",
			["regionType"] = "icon",
			["useCooldownModRate"] = true,
			["config"] = {
			},
			["icon_side"] = "RIGHT",
			["useAdjustededMin"] = false,
			["id"] = "Aspect of the Hawk",
			["sparkHeight"] = 30,
			["texture"] = "Melli",
			["width"] = 40,
			["cooldownTextDisabled"] = false,
			["auto"] = false,
			["frameStrata"] = 1,
			["sparkHidden"] = "NEVER",
			["anchorFrameParent"] = false,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["inverse"] = false,
			["spark"] = false,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
		},
		["Vermin Warrior Stance"] = {
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["controlledChildren"] = {
				"Warrior - Battle Stance", -- [1]
				"Warrior - Berserker Stance", -- [2]
				"Warrior - Defensive Stance", -- [3]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["scale"] = 1,
			["border"] = false,
			["yOffset"] = -200,
			["anchorPoint"] = "CENTER",
			["borderSize"] = 2,
			["regionType"] = "group",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["xOffset"] = 0,
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
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["event"] = "Health",
						["names"] = {
						},
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["internalVersion"] = 70,
			["borderEdge"] = "Square Full White",
			["selfPoint"] = "CENTER",
			["id"] = "Vermin Warrior Stance",
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["borderOffset"] = 4,
			["uid"] = "Pt2lZW6tFcu",
			["config"] = {
			},
			["borderInset"] = 1,
			["conditions"] = {
			},
			["load"] = {
				["talent"] = {
					["multi"] = {
					},
				},
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
			["authorOptions"] = {
			},
		},
		["Herbaning Switch"] = {
			["sparkWidth"] = 20,
			["iconSource"] = -1,
			["wagoID"] = "zdwG-dB_p",
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = -105,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["url"] = "https://wago.io/zdwG-dB_p/4",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["do_custom"] = false,
				},
				["finish"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "1",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "custom",
						["unevent"] = "auto",
						["names"] = {
						},
						["use_unit"] = true,
						["event"] = "Health",
						["spellIds"] = {
						},
						["customDuration"] = "function()\n    -- Set the duration of the timer\n    local duration = aura_env.throttleTime\n    -- Set the progress bar fill time relative to GetTime()\n    -- ex: GetTime() + Spell Duration = Spell Complete Time\n    local expirationTime = aura_env.expirationTime\n    return duration, expirationTime\n    -- %p, %t\nend",
						["events"] = "UPDATE_SHAPESHIFT_FORM",
						["custom"] = "function()\n    local nextTrack\n    local herbTracking = GetSpellInfo(\"Find Herbs\")\n    local mineralTracking = GetSpellInfo(\"Find Minerals\")\n    local isNotTracking = GetTrackingTexture() == nil\n    local isInit = (aura_env.lastTrackToggleTime == nil)\n    local theTime = GetTime()\n    local notInCombat = not InCombatLockdown()\n    local notResting = not IsResting()\n    local IsFlying = IsFlying()\n    local notChanneling = not ChannelInfo()\n    local notCasting = not CastingInfo()\n    local haveTarget = UnitExists(\"target\")\n    local unitalive = not UnitIsDead(\"player\")\n    \n    local showProgressBar = true\n    \n    for i=1,80 do \n        local buff = UnitBuff(\"player\", i)\n        if buff and buff == \"Shadowy Disguise\" then \n            showProgressBar = false\n        end\n    end\n    \n    -- Set throttle speed based on mount status\n    if IsMounted() == false and aura_env.config.mvmtstatus == true then\n        aura_env.throttleTime = aura_env.config.wthrottlespeed\n    else\n        aura_env.throttleTime = aura_env.config.mthrottlespeed\n    end\n    \n    -- Check to see that either tracking method is known and the player is not in a resting area\n    if (herbTracking or mineralTracking) and unitalive and notInCombat and notResting and notCasting and notChanneling and not haveTarget and showProgressBar then\n        -- Only toggle if the duration has expired\n        if not aura_env.last or aura_env.last < theTime - aura_env.throttleTime then\n            -- Set the progress bar fill expiration time relative to GetTime()\n            -- ex: GetTime() + Spell Duration = Spell Complete Time\n            aura_env.expirationTime = theTime + aura_env.throttleTime\n            -- Print out the delay time the option is enabled\n            if aura_env.config.verbosetext == true then\n                print(\"Toggled after \" .. aura_env.throttleTime .. \" seconds.\")\n            end\n            aura_env.last = theTime\n            if herbTracking ~= nil and mineralTracking == nil and isNotTracking then\n                -- Turn on herb tracking if that's all that's been learned\n                nextTrack = herbTracking\n            elseif mineralTracking ~= nil and herbTracking == nil and isNotTracking then\n                -- Turn on mineral tracking if that's all that's been learned\n                nextTrack = mineralTracking\n            elseif herbTracking ~= nil and mineralTracking ~= nil then\n                -- If we have both herb and mineral tracking toggle between them\n                if aura_env.lastTrack ~= herbTracking then\n                    nextTrack = herbTracking\n                elseif aura_env.lastTrack ~= mineralTracking then\n                    nextTrack = mineralTracking\n                end\n            end\n            if nextTrack ~= nil  then\n                -- Print out the action if the option is enabled\n                if aura_env.config.verbosetext == true then\n                    if isInit then\n                        print(\"Initializing: \"..nextTrack)\n                    elseif aura_env.lastTrack ~= nil then\n                        print(\"Toggling: \"..aura_env.lastTrack..\" -> \"..nextTrack)\n                    else\n                        print(\"Missing: \"..nextTrack)\n                    end\n                end\n                -- Cast the spell\n                CastSpellByName(nextTrack)\n                aura_env.lastTrackToggleTime = theTime\n                aura_env.lastTrack = nextTrack\n            end\n        end\n        -- Return the bool custom option to show or hide the progress bar\n        return aura_env.config.showprogress\n    end\nend",
						["custom_hide"] = "timed",
						["check"] = "update",
						["custom_type"] = "status",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "all",
				["customTriggerLogic"] = "function(t)\n    return t[1] and t[2]\nend",
				["activeTriggerMode"] = 1,
			},
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["internalVersion"] = 70,
			["zoom"] = 0,
			["selfPoint"] = "CENTER",
			["enableGradient"] = false,
			["barColor"] = {
				0.6313725490196078, -- [1]
				1, -- [2]
				0.2196078431372549, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["barColor2"] = {
				1, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["desc"] = "Made specifically for Druids with SWIFT flight form and both gathering professions, herbalism and mining.",
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subforeground",
				}, -- [2]
				{
					["text_text_format_t_time_precision"] = 1,
					["text_text"] = "%p / %t",
					["text_text_format_p_time_mod_rate"] = true,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_p_format"] = "timed",
					["anchorYOffset"] = 0,
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_t_time_format"] = 0,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_t_format"] = "timed",
					["text_text_format_t_time_legacy_floor"] = true,
					["anchorXOffset"] = 0,
					["type"] = "subtext",
					["text_text_format_p_time_precision"] = 1,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_t_time_mod_rate"] = true,
					["text_shadowYOffset"] = -1,
					["text_visible"] = false,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "INNER_LEFT",
					["text_text_format_p_time_format"] = 0,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_fontSize"] = 12,
					["text_text_format_t_time_dynamic_threshold"] = 60,
					["text_shadowXOffset"] = 1,
				}, -- [3]
			},
			["height"] = 2,
			["gradientOrientation"] = "HORIZONTAL",
			["load"] = {
				["use_namerealm"] = true,
				["ingroup"] = {
					["single"] = "raid",
					["multi"] = {
						["solo"] = true,
					},
				},
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "HUNTER",
					["multi"] = {
						["HUNTER"] = true,
					},
				},
				["itemtypeequipped"] = {
				},
				["namerealm"] = "Dopesnare",
				["use_combat"] = false,
				["use_spellknown"] = false,
				["use_itemequiped"] = false,
				["size"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["use_exact_spellknown"] = false,
				["spellknown"] = 2580,
				["zoneIds"] = "",
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["sparkOffsetX"] = 0,
			["version"] = 4,
			["config"] = {
				["showprogress"] = true,
				["mthrottlespeed"] = 5,
				["mvmtstatus"] = false,
				["wthrottlespeed"] = 20,
				["verbosetext"] = false,
			},
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["width"] = 99.999954223633,
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["frameStrata"] = 1,
			["uid"] = "dSVImVtgjk5",
			["icon_side"] = "RIGHT",
			["sparkHidden"] = "NEVER",
			["sparkHeight"] = 30,
			["texture"] = "Melli Dark",
			["auto"] = true,
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["spark"] = false,
			["tocversion"] = 20502,
			["id"] = "Herbaning Switch",
			["semver"] = "1.0.3",
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["icon"] = false,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["inverse"] = true,
			["authorOptions"] = {
				{
					["type"] = "range",
					["useDesc"] = true,
					["max"] = 10,
					["step"] = 0.5,
					["width"] = 1,
					["min"] = 0,
					["key"] = "mthrottlespeed",
					["desc"] = "Change the delay between toggling on\\between find minerals and herbs while mounted.",
					["name"] = "Cycle Time",
					["default"] = 3.5,
				}, -- [1]
				{
					["type"] = "range",
					["useDesc"] = true,
					["max"] = 20,
					["step"] = 0.5,
					["width"] = 1,
					["min"] = 0,
					["key"] = "wthrottlespeed",
					["desc"] = "Change the delay between toggling on\\between find minerals and herbs while dismounted.",
					["name"] = "Dismounted Cycle Time",
					["default"] = 10,
				}, -- [2]
				{
					["type"] = "space",
					["variableWidth"] = true,
					["height"] = 1,
					["width"] = 1,
					["useHeight"] = false,
				}, -- [3]
				{
					["type"] = "toggle",
					["key"] = "mvmtstatus",
					["desc"] = "Enables the \"Dismounted Cycle Time\" option to control the frequency of find toggles based on mount status.",
					["default"] = true,
					["useDesc"] = true,
					["name"] = "Mount Auto Throttle Control",
					["width"] = 1,
				}, -- [4]
				{
					["type"] = "header",
					["text"] = "",
					["useName"] = false,
					["width"] = 1,
				}, -- [5]
				{
					["type"] = "toggle",
					["key"] = "verbosetext",
					["desc"] = "Give detailed information in the chat pain on what the WeakAra is doing.",
					["default"] = true,
					["useDesc"] = true,
					["name"] = "Verbose Text",
					["width"] = 1,
				}, -- [6]
				{
					["type"] = "toggle",
					["key"] = "showprogress",
					["desc"] = "Shows a depleting progress bar for each cycle.",
					["default"] = true,
					["useDesc"] = true,
					["name"] = "Show Progress Bar",
					["width"] = 1,
				}, -- [7]
			},
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
		},
		["Swing Timer OH"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["wagoID"] = "jEBcD-xSW",
			["xOffset"] = 0,
			["preferToUpdate"] = true,
			["yOffset"] = -85,
			["anchorPoint"] = "CENTER",
			["zoom"] = 0,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["url"] = "https://wago.io/jEBcD-xSW/8",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["custom"] = "aura_env.nextSwingTime = 0\n\naura_env.UseOffHand = function()\n    return aura_env.config[\"offHand\"]\nend\n\naura_env.MELEE_SWING_SPELLS = {\n    [\"Heroic Strike\"] = true,\n    [\"Cleave\"] = true,\n    [\"Raptor Strike\"] = true,\n    [\"Maul\"] = true,\n    [\"Rune Strike\"] = true\n}\n\naura_env.RANGED_SWING_SPELLS = {\n    [\"Shoot\"] = true,\n    [\"Throw\"] = true,\n    [\"Auto Shot\"] = true\n}",
					["do_custom"] = true,
				},
				["finish"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["dynamicDuration"] = true,
						["customIcon"] = "function()\n  if aura_env.rangedSwing then\n    return GetInventoryItemTexture(\"player\", 18)\n  elseif aura_env.UseOffHand() then\n    return GetInventoryItemTexture(\"player\", 17)\n  else\n    return GetInventoryItemTexture(\"player\", 16)\n  end\nend",
						["debuffType"] = "HELPFUL",
						["type"] = "custom",
						["subeventSuffix"] = "_CAST_START",
						["custom_hide"] = "timed",
						["custom"] = "function(event, ...)\n    local function IsSpellCastSlam(...)\n        local spellId = select(3, ...)\n        local spellName = GetSpellInfo(spellId)\n        \n        -- if select(2, UnitClass('player')) == \"WARRIOR\" then\n        --     if GetShapeshiftForm() == 3 then return false end\n        -- end\n        \n        if IsSpellKnown(23881) then return false end\n        \n        return spellName == \"Slam\"\n    end\n    \n    if event == \"COMBAT_LOG_EVENT_UNFILTERED\" then\n        local subEvent = select(2, ...)\n        local sourceGUID = select(4, ...)\n        local destGUID = select(8, ...)\n        local playerGUID = UnitGUID(\"player\")\n        local useOffHand = aura_env.UseOffHand()\n        \n        if subEvent == \"SWING_MISSED\" and destGUID == playerGUID and not useOffHand and not aura_env.rangedSwing then\n            local missType = select(12, ...)\n            \n            if missType == \"PARRY\" then\n                aura_env.parryHaste = true\n                return true\n            else\n                return false\n            end\n        elseif sourceGUID ~= playerGUID then\n            return false\n        end\n        \n        if subEvent == \"SPELL_CAST_SUCCESS\" and not useOffHand then\n            local spellName = select(13, ...)\n            \n            if aura_env.MELEE_SWING_SPELLS[spellName] then\n                aura_env.rangedSwing = false\n                return true\n            elseif aura_env.RANGED_SWING_SPELLS[spellName] then\n                aura_env.rangedSwing = true\n                return true\n            else\n                return false\n            end\n        end\n        \n        local isOffHand = false\n        \n        if subEvent == \"SWING_DAMAGE\" then\n            isOffHand = select(21, ...)\n        elseif subEvent == \"SWING_MISSED\" then\n            isOffHand = select(13, ...)\n        end\n        \n        aura_env.rangedSwing = false\n        return (useOffHand and isOffHand) or (not useOffHand and not isOffHand)\n    elseif event == \"UNIT_SPELLCAST_START\" and IsSpellCastSlam(...) then\n        aura_env.rangedSwing = false\n        aura_env.pauseState = \"PAUSING\"\n        return true\n    elseif event == \"UNIT_SPELLCAST_STOP\" and IsSpellCastSlam(...) then\n        aura_env.rangedSwing = false\n        aura_env.pauseState = \"INTERRUPTED\"\n        return true\n    elseif event == \"UNIT_SPELLCAST_SUCCEEDED\" and IsSpellCastSlam(...) then\n        aura_env.rangedSwing = false\n        aura_env.pauseState = \"RESUMING\"\n        return true\n    end\nend",
						["event"] = "Health",
						["spellIds"] = {
						},
						["customDuration"] = "function()\n  local now = GetTime()\n  local useOffHand = aura_env.UseOffHand()\n  \n  local function CalculateParryHaste(current, total)\n    return math.max(current - total * 0.4, math.min(current, total * 0.2))\n  end\n  \n  local swingSpeed\n  \n  if aura_env.rangedSwing then\n    swingSpeed = UnitRangedDamage(\"player\")\n  else\n    local mainSpeed, offSpeed = UnitAttackSpeed(\"player\")\n    \n    if useOffHand and offSpeed then\n      swingSpeed = offSpeed\n    else\n      swingSpeed = mainSpeed\n    end\n  end\n  \n  if aura_env.parryHaste then\n    local remainingDuration = aura_env.nextSwingTime - now\n    local remainingAfterHaste = CalculateParryHaste(remainingDuration, swingSpeed)\n    local hasteDuration = remainingDuration - remainingAfterHaste\n    \n    aura_env.parryHaste = false\n    return swingSpeed, aura_env.nextSwingTime - hasteDuration\n  elseif aura_env.pauseState == \"PAUSING\" then\n    local remainingDuration = math.max(aura_env.nextSwingTime - now, 0)\n    \n    aura_env.pauseTime = now\n    aura_env.pauseState = \"PAUSED\"\n    return remainingDuration, swingSpeed, true\n  elseif aura_env.pauseState == \"INTERRUPTED\" then\n    aura_env.pauseState = \"RESUMED\"\n    return swingSpeed, aura_env.nextSwingTime\n  elseif aura_env.pauseState == \"RESUMING\" then\n    local pauseDuration = now - aura_env.pauseTime\n    local newSwingTime = aura_env.nextSwingTime + pauseDuration\n    \n    aura_env.nextSwingTime = newSwingTime\n    aura_env.pauseState = \"RESUMED\"\n    return swingSpeed, newSwingTime\n  end\n  \n  local nextSwingTime = now + swingSpeed\n  \n  aura_env.nextSwingTime = nextSwingTime\n  return swingSpeed, nextSwingTime\nend",
						["customName"] = "function()\n  local function GetSlotItemName(slotId)\n    local slotItemId = GetInventoryItemID(\"player\", slotId)\n    \n    if slotItemId then\n      return GetItemInfo(slotItemId)\n    end\n  end\n  \n  if aura_env.rangedSwing then\n    return GetSlotItemName(18)\n  elseif aura_env.UseOffHand() then\n    return GetSlotItemName(17)\n  else\n    return GetSlotItemName(16) or \"Unarmed\"\n  end\nend",
						["events"] = "CLEU:SWING_DAMAGE,CLEU:SWING_MISSED,CLEU:SPELL_CAST_SUCCESS,UNIT_SPELLCAST_START:player,UNIT_SPELLCAST_STOP:player,UNIT_SPELLCAST_SUCCEEDED:player",
						["customTexture"] = "",
						["custom_type"] = "event",
						["unit"] = "player",
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
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
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["colorR"] = 1,
					["duration_type"] = "relative",
					["colorB"] = 1,
					["colorG"] = 1,
					["type"] = "custom",
					["easeType"] = "none",
					["duration"] = "100",
					["use_color"] = true,
					["alpha"] = 0,
					["x"] = 0,
					["y"] = 0,
					["colorType"] = "custom",
					["rotate"] = 0,
					["colorA"] = 1,
					["colorFunc"] = "function()\n    local c =  select(2, UnitClass('player'))\n    local cl = RAID_CLASS_COLORS[c]\n    \n    local hs = IsCurrentSpell( select(7,GetSpellInfo('Heroic Strike')) )\n    local cleave = IsCurrentSpell(select(7,GetSpellInfo('Cleave')))\n    local runestrike = IsCurrentSpell(select(7,GetSpellInfo('Rune Strike')))\n    local raptorstrike = IsCurrentSpell(select(7,GetSpellInfo('Raptor Strike')))\n    local maul = IsCurrentSpell(select(7,GetSpellInfo('Maul')))\n    \n    if hs then \n        return 168/255,45/255,20/255,1\n    end\n    \n    if cleave then \n        return 152/255,192/255,42/255,1\n    end\n    \n    if runestrike then \n        return 24/255,105/255,119/255,1\n    end\n    \n    if raptorstrike then \n        return 154/255,194/255,212/255,1\n    end\n    \n    if maul then \n        return 96/255,100/255,126/255,1\n    end\n    \n    return cl.r,cl.g,cl.b,1\nend",
					["easeStrength"] = 3,
					["scaley"] = 1,
					["scalex"] = 1,
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["sparkOffsetX"] = 0,
			["barColor2"] = {
				1, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["barColor"] = {
				1, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["icon"] = false,
			["enableGradient"] = false,
			["version"] = 8,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subforeground",
				}, -- [2]
				{
					["text_shadowXOffset"] = 0,
					["text_text"] = "%p",
					["text_text_format_p_time_mod_rate"] = true,
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_p_format"] = "Number",
					["text_text_format_p_time_legacy_floor"] = false,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["anchorXOffset"] = 0,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						0, -- [4]
					},
					["text_text_format_p_decimal_precision"] = 1,
					["type"] = "subtext",
					["text_anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = 0,
					["text_anchorYOffset"] = -5,
					["text_text_format_p_time_format"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "TOP",
					["text_fontType"] = "OUTLINE",
					["anchorYOffset"] = 0,
					["text_fontSize"] = 14,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_p_time_precision"] = 1,
				}, -- [3]
				{
					["text_text_format_t_time_precision"] = 1,
					["text_text_format_t_time_legacy_floor"] = false,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						0, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_t_time_format"] = 0,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_t_format"] = "Number",
					["text_text_format_t_decimal_precision"] = 1,
					["type"] = "subtext",
					["anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text"] = "%t",
					["text_shadowYOffset"] = 0,
					["text_visible"] = false,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "INNER_CENTER",
					["text_text_format_n_format"] = "none",
					["text_text_format_t_time_mod_rate"] = true,
					["text_fontSize"] = 10,
					["text_text_format_t_time_dynamic_threshold"] = 60,
					["text_shadowXOffset"] = 0,
				}, -- [4]
				{
					["border_offset"] = 0,
					["border_anchor"] = "bar",
					["border_size"] = 2,
					["border_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["border_visible"] = false,
					["border_edge"] = "Drop Shadow",
					["type"] = "subborder",
				}, -- [5]
			},
			["height"] = 6,
			["selfPoint"] = "CENTER",
			["load"] = {
				["size"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["use_itemequiped"] = false,
				["itemtypeequipped"] = {
				},
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["sparkOffsetY"] = 0,
			["source"] = "import",
			["config"] = {
				["offHand"] = true,
			},
			["desc"] = "Martymoo-Whitemane",
			["width"] = 220,
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["alpha"] = 1,
			["gradientOrientation"] = "HORIZONTAL",
			["icon_side"] = "RIGHT",
			["sparkHidden"] = "NEVER",
			["sparkHeight"] = 30,
			["texture"] = "xVerminClean",
			["semver"] = "1.0.7",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["spark"] = false,
			["tocversion"] = 30400,
			["id"] = "Swing Timer OH",
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["uid"] = "xrn6TyjU(E6",
			["inverse"] = true,
			["authorOptions"] = {
				{
					["type"] = "toggle",
					["default"] = false,
					["desc"] = "Track only the swings made using your off hand weapon.",
					["key"] = "offHand",
					["useDesc"] = true,
					["name"] = "Off Hand",
					["width"] = 1,
				}, -- [1]
			},
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["parent"] = "SwingTimer - Queue skills",
		},
		["Details! Boss Mods Group"] = {
			["grow"] = "DOWN",
			["controlledChildren"] = {
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["xOffset"] = 0,
			["yOffset"] = 370,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["space"] = 2,
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
						["type"] = "unit",
						["use_alwaystrue"] = false,
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Conditions",
						["names"] = {
						},
						["spellIds"] = {
						},
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["columnSpace"] = 1,
			["radius"] = 200,
			["selfPoint"] = "TOP",
			["align"] = "CENTER",
			["rotation"] = 0,
			["borderInset"] = 0,
			["subRegions"] = {
			},
			["height"] = 121.503601074219,
			["rowSpace"] = 1,
			["load"] = {
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
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
				["zoneIds"] = "",
				["use_class"] = false,
				["race"] = {
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
			["regionType"] = "dynamicgroup",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["arcLength"] = 360,
			["animate"] = true,
			["useLimit"] = false,
			["scale"] = 1,
			["centerType"] = "LR",
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["stepAngle"] = 15,
			["borderSize"] = 2,
			["limit"] = 5,
			["fullCircle"] = true,
			["stagger"] = 0,
			["constantFactor"] = "RADIUS",
			["sort"] = "none",
			["borderOffset"] = 16,
			["width"] = 359.096801757813,
			["gridWidth"] = 5,
			["id"] = "Details! Boss Mods Group",
			["config"] = {
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["authorOptions"] = {
			},
			["uid"] = "N5YikxjcJsU",
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
			},
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["gridType"] = "RD",
		},
		["Clearcasting"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["wagoID"] = "v9qxdDgI4",
			["parent"] = "Vermin Druid",
			["preferToUpdate"] = false,
			["sparkHeight"] = 30,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["sparkOffsetX"] = 0,
			["cooldownSwipe"] = true,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
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
						["auranames"] = {
							"Clearcasting", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showOnReady",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "aura2",
						["subeventSuffix"] = "_CAST_START",
						["unevent"] = "auto",
						["unit"] = "player",
						["names"] = {
						},
						["event"] = "Action Usable",
						["spellName"] = 34428,
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_genericShowOn"] = true,
						["useName"] = true,
						["subeventPrefix"] = "SPELL",
						["use_track"] = true,
						["useIgnoreName"] = false,
					},
					["untrigger"] = {
						["genericShowOn"] = "showOnReady",
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
			["internalVersion"] = 70,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["xOffset"] = 0,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["barColor"] = {
				0.2, -- [1]
				1, -- [2]
				0.0862745098039216, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["icon"] = true,
			["useTooltip"] = false,
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.5,
					["type"] = "subglow",
					["useGlowColor"] = true,
					["text_color"] = {
					},
					["glowThickness"] = 3,
					["glowDuration"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						0, -- [1]
						1, -- [2]
						0.08627451211214066, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 16,
					["glow"] = true,
					["glowScale"] = 1,
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_p_time_precision"] = 1,
					["text_text"] = "%p",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_mod_rate"] = true,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "OUTER_TOP",
					["text_shadowXOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 10,
					["anchorXOffset"] = 0,
					["text_text_format_p_format"] = "timed",
				}, -- [3]
			},
			["height"] = 36,
			["selfPoint"] = "CENTER",
			["load"] = {
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
					},
				},
				["use_class"] = true,
				["use_spellknown"] = true,
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["use_level"] = false,
				["level"] = {
					"5", -- [1]
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["authorOptions"] = {
			},
			["cooldown"] = false,
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["displayIcon"] = "",
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "icon",
			["auto"] = false,
			["uid"] = "8gslC0ziYq6",
			["icon_side"] = "RIGHT",
			["anchorFrameFrame"] = "PlayerFrame",
			["sparkHidden"] = "NEVER",
			["anchorFrameParent"] = false,
			["texture"] = "Melli",
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = false,
			["spark"] = false,
			["alpha"] = 1,
			["id"] = "Clearcasting",
			["zoom"] = 0,
			["useCooldownModRate"] = true,
			["width"] = 36,
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["config"] = {
			},
			["inverse"] = false,
			["frameStrata"] = 1,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Vermin Death Knight"] = {
			["arcLength"] = 360,
			["controlledChildren"] = {
				"Anti-Magic Shell", -- [1]
				"Icebound Fortitude", -- [2]
				"Blade Barrier", -- [3]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["xOffset"] = -135,
			["yOffset"] = 20,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["space"] = 2,
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
			["radius"] = 200,
			["selfPoint"] = "RIGHT",
			["align"] = "CENTER",
			["stagger"] = 0,
			["uid"] = "NLkveGaWbw7",
			["internalVersion"] = 70,
			["load"] = {
				["size"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["multi"] = {
					},
				},
			},
			["anchorFrameFrame"] = "PlayerFrame",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["useLimit"] = false,
			["animate"] = true,
			["rotation"] = 0,
			["scale"] = 1,
			["centerType"] = "LR",
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["stepAngle"] = 15,
			["borderSize"] = 2,
			["sort"] = "none",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["fullCircle"] = true,
			["constantFactor"] = "RADIUS",
			["regionType"] = "dynamicgroup",
			["borderOffset"] = 4,
			["limit"] = 5,
			["frameStrata"] = 1,
			["id"] = "Vermin Death Knight",
			["borderInset"] = 1,
			["gridWidth"] = 5,
			["anchorFrameType"] = "SCREEN",
			["gridType"] = "RD",
			["config"] = {
			},
			["rowSpace"] = 1,
			["authorOptions"] = {
			},
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["grow"] = "LEFT",
		},
		["Copper Ore"] = {
			["iconSource"] = -1,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = false,
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
						["itemName"] = 2770,
						["use_count"] = true,
						["duration"] = "1",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["type"] = "item",
						["subeventSuffix"] = "_CAST_START",
						["use_exact_itemName"] = true,
						["unit"] = "player",
						["event"] = "Item Count",
						["use_unit"] = true,
						["use_includeBank"] = true,
						["spellIds"] = {
						},
						["count"] = "0",
						["unevent"] = "auto",
						["use_absorbMode"] = true,
						["use_itemName"] = true,
						["names"] = {
						},
						["count_operator"] = ">",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_anchorYOffset"] = 0,
					["type"] = "subtext",
					["text_anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "PT Sans Narrow",
					["anchorXOffset"] = 0,
					["text_shadowYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_fontSize"] = 16,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_shadowXOffset"] = 0,
				}, -- [2]
				{
					["glowFrequency"] = 0,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowDuration"] = 1,
					["useGlowColor"] = false,
					["glow"] = true,
					["glowThickness"] = 1,
					["glowScale"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 40,
			["load"] = {
				["use_namerealm"] = true,
				["ingroup"] = {
					["single"] = "solo",
				},
				["namerealm"] = "Mxzq",
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["use_ingroup"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["use_never"] = true,
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["source"] = "import",
			["uid"] = "hlCr6LtK9Ws",
			["icon"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["information"] = {
				["forceEvents"] = true,
			},
			["url"] = "https://wago.io/iST6tz9t8/1",
			["useTooltip"] = true,
			["parent"] = "Ore Count",
			["anchorFrameParent"] = false,
			["cooldownTextDisabled"] = false,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["semver"] = "1.0.0",
			["tocversion"] = 90002,
			["id"] = "Copper Ore",
			["useCooldownModRate"] = true,
			["alpha"] = 1,
			["width"] = 40,
			["frameStrata"] = 1,
			["config"] = {
			},
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["conditions"] = {
			},
			["cooldown"] = false,
			["xOffset"] = 0,
		},
		["MANA BAR + DRUID / ROGUE CPOINTS"] = {
			["controlledChildren"] = {
				"Rage Bar", -- [1]
				"Mana Bar ", -- [2]
				"Energy Bar", -- [3]
				"Mana Bar Cat/Bear", -- [4]
				"CP1", -- [5]
				"CP2", -- [6]
				"CP3", -- [7]
				"CP4", -- [8]
				"CP5", -- [9]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = 120,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["url"] = "https://wago.io/HCaWT5tJa/14",
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
			["internalVersion"] = 70,
			["selfPoint"] = "BOTTOMLEFT",
			["version"] = 14,
			["subRegions"] = {
			},
			["load"] = {
				["use_class"] = "true",
				["talent"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["scale"] = 0.8,
			["border"] = false,
			["borderEdge"] = "1 Pixel",
			["regionType"] = "group",
			["borderSize"] = 2,
			["borderOffset"] = 4,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "MANA BAR + DRUID / ROGUE CPOINTS",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["xOffset"] = 0,
			["config"] = {
			},
			["uid"] = "IUvIXiYBA4q",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
			},
			["conditions"] = {
			},
			["information"] = {
				["groupOffset"] = true,
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["borderInset"] = 1,
		},
		["Mana Bar"] = {
			["overlays"] = {
				{
					0.43529411764706, -- [1]
					0, -- [2]
					1, -- [3]
					0.25, -- [4]
				}, -- [1]
			},
			["iconSource"] = -1,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -100,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["url"] = "https://wago.io/HCaWT5tJa/14",
			["backgroundColor"] = {
				0.32549019607843, -- [1]
				0.53725490196078, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["fontFlags"] = "OUTLINE",
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["enableGradient"] = false,
			["selfPoint"] = "CENTER",
			["barColor"] = {
				0.32549019607843, -- [1]
				0.53725490196078, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["sparkOffsetY"] = 0,
			["gradientOrientation"] = "HORIZONTAL",
			["load"] = {
				["size"] = {
					["multi"] = {
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_never"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["use_vehicle"] = false,
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["WARLOCK"] = true,
						["PALADIN"] = true,
						["MAGE"] = true,
						["SHAMAN"] = true,
						["PRIEST"] = true,
					},
				},
				["talent2"] = {
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
				["use_class"] = false,
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
				["faction"] = {
					["multi"] = {
					},
				},
				["race"] = {
					["multi"] = {
					},
				},
				["use_petbattle"] = false,
				["zoneIds"] = "",
			},
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["texture"] = "xVerminClean",
			["zoom"] = 0,
			["auto"] = true,
			["tocversion"] = 11302,
			["alpha"] = 1,
			["config"] = {
			},
			["borderBackdrop"] = "None",
			["parent"] = "Power Bar Group",
			["customText"] = "",
			["customTextUpdate"] = "event",
			["triggers"] = {
				{
					["trigger"] = {
						["use_power"] = false,
						["genericShowOn"] = "showOnActive",
						["names"] = {
						},
						["powertype"] = 0,
						["use_powertype"] = true,
						["custom_hide"] = "timed",
						["unit"] = "player",
						["type"] = "unit",
						["use_health"] = true,
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
						["use_requirePowerType"] = true,
						["use_percentpower"] = false,
						["subeventPrefix"] = "SPELL",
						["event"] = "Power",
						["spellIds"] = {
						},
						["health"] = "0",
						["health_operator"] = ">=",
						["duration"] = "1",
						["use_showCost"] = true,
						["unevent"] = "auto",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "all",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
			},
			["backdropInFront"] = false,
			["stickyDuration"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subforeground",
				}, -- [2]
				{
					["text_text_format_t_time_precision"] = 1,
					["text_text_format_t_time_legacy_floor"] = false,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_fixedWidth"] = 64,
					["text_text_format_p_time_legacy_floor"] = false,
					["rotateText"] = "NONE",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_text_format_ct_format"] = "none",
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_text_format_t_time_format"] = 0,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["text_text_format_t_format"] = "timed",
					["type"] = "subtext",
					["text_visible"] = true,
					["text_text_format_p_time_format"] = 0,
					["text_font"] = "Arial Narrow",
					["text_shadowYOffset"] = -1,
					["text_anchorYOffset"] = -1,
					["text_text"] = "%p / %t",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_t_time_mod_rate"] = true,
					["text_anchorPoint"] = "INNER_CENTER",
					["text_text_format_p_time_precision"] = 1,
					["text_text_format_p_time_mod_rate"] = true,
					["text_shadowXOffset"] = 1,
					["text_text_format_t_time_dynamic_threshold"] = 60,
					["text_text_format_c_format"] = "none",
				}, -- [3]
			},
			["height"] = 6,
			["sparkBlendMode"] = "ADD",
			["backdropColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["xOffset"] = 0,
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["borderInFront"] = true,
			["sparkWidth"] = 10,
			["icon_side"] = "RIGHT",
			["sparkOffsetX"] = 0,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "if aura_env.region then\n    local r = aura_env.region\n    if not r.text3 then\n        local text3 = r.bar:CreateFontString(nil, \"OVERLAY\")\n        r.text3 = text3\n        r.text3:SetJustifyH(\"CENTER\")\n        r.text3:SetJustifyV(\"MIDDLE\")\n        r.text3:SetPoint(\"CENTER\", r.bar, \"CENTER\")\n        r.text3:Show()\n    end\n    r.text3:SetShadowOffset(1, -1)\n    r.text3:SetFont(r.text:GetFont())\n    r.text3:SetTextColor(r.text:GetTextColor())\nend\n\n\n\n\n\n\n",
					["do_custom"] = false,
				},
			},
			["sparkHeight"] = 30,
			["icon"] = false,
			["overlaysTexture"] = {
				"Melli Dark", -- [1]
			},
			["anchorFrameType"] = "SCREEN",
			["semver"] = "1.0.13",
			["sparkHidden"] = "NEVER",
			["id"] = "Mana Bar",
			["spark"] = false,
			["frameStrata"] = 3,
			["width"] = 220,
			["sparkRotationMode"] = "AUTO",
			["useAdjustededMax"] = false,
			["inverse"] = false,
			["sparkDesature"] = false,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["barColor2"] = {
				1, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["uid"] = "YyLfdSMZJ89",
		},
		["Nameplate Combo Points"] = {
			["controlledChildren"] = {
				"Combo Points Background", -- [1]
				"Combo Points Foreground", -- [2]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["groupIcon"] = "136183",
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["url"] = "https://wago.io/sv0bnASk1/1",
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
						["names"] = {
						},
						["type"] = "aura2",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["event"] = "Health",
						["unit"] = "player",
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["version"] = 1,
			["subRegions"] = {
			},
			["load"] = {
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
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
			["source"] = "import",
			["scale"] = 1,
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "group",
			["borderSize"] = 2,
			["borderOffset"] = 4,
			["semver"] = "1.0.0",
			["tocversion"] = 11305,
			["id"] = "Nameplate Combo Points",
			["yOffset"] = 0,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["xOffset"] = 0,
			["config"] = {
			},
			["uid"] = "iOnxJbg5Fqx",
			["borderInset"] = 1,
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["groupOffset"] = true,
			},
			["selfPoint"] = "BOTTOMLEFT",
		},
		["MEND PET"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["xOffset"] = 0,
			["yOffset"] = -30,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["triggers"] = {
				{
					["trigger"] = {
						["useName"] = true,
						["auranames"] = {
							"Mend Pet", -- [1]
						},
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["type"] = "aura2",
						["names"] = {
						},
						["unit"] = "pet",
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
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["barColor"] = {
				0.1529411822557449, -- [1]
				0.760784387588501, -- [2]
				0.06666667014360428, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["frameStrata"] = 1,
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subforeground",
				}, -- [2]
				{
					["text_shadowXOffset"] = 1,
					["text_text"] = "Mend Pet",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "INNER_BOTTOMLEFT",
					["text_visible"] = false,
					["text_text_format_n_format"] = "none",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_anchorYOffset"] = 4,
				}, -- [3]
			},
			["height"] = 8,
			["gradientOrientation"] = "HORIZONTAL",
			["load"] = {
				["use_namerealm"] = false,
				["namerealm"] = "dont load",
				["talent"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["barColor2"] = {
				1, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["enableGradient"] = false,
			["selfPoint"] = "CENTER",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["useAdjustededMin"] = false,
			["smoothProgress"] = true,
			["anchorFrameFrame"] = "SUFUnitpet",
			["regionType"] = "aurabar",
			["uid"] = "FpXBk3sOate",
			["sparkOffsetX"] = 0,
			["icon_side"] = "RIGHT",
			["width"] = 180,
			["sparkHeight"] = 30,
			["texture"] = "xVerminClean",
			["config"] = {
			},
			["zoom"] = 0,
			["spark"] = false,
			["id"] = "MEND PET",
			["sparkHidden"] = "NEVER",
			["auto"] = true,
			["alpha"] = 1,
			["anchorFrameType"] = "SELECTFRAME",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["inverse"] = false,
			["authorOptions"] = {
			},
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["icon"] = false,
		},
		["Cleave"] = {
			["sparkWidth"] = 10,
			["sparkOffsetX"] = 0,
			["wagoID"] = "v9qxdDgI4",
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownTextDisabled"] = false,
			["cooldownSwipe"] = true,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["cooldownEdge"] = false,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"29838", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showOnReady",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
						["spellName"] = 845,
						["useName"] = true,
						["unevent"] = "auto",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["names"] = {
						},
						["event"] = "Queued Action",
						["use_exact_spellName"] = false,
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_genericShowOn"] = true,
						["type"] = "spell",
						["unit"] = "player",
						["use_track"] = true,
						["useIgnoreName"] = false,
					},
					["untrigger"] = {
						["genericShowOn"] = "showOnReady",
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
			["useTooltip"] = false,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["iconSource"] = -1,
			["authorOptions"] = {
			},
			["barColor"] = {
				0.2, -- [1]
				1, -- [2]
				0.0862745098039216, -- [3]
				1, -- [4]
			},
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["config"] = {
			},
			["icon"] = true,
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.75,
					["type"] = "subglow",
					["useGlowColor"] = true,
					["text_color"] = {
					},
					["glowThickness"] = 2,
					["glowDuration"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0.85098039215686, -- [2]
						0.1843137254902, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 16,
					["glow"] = true,
					["glowScale"] = 1,
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_p_time_precision"] = 1,
					["text_text"] = "%p",
					["text_text_format_p_time_mod_rate"] = true,
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_format"] = "timed",
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_shadowXOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
				}, -- [3]
			},
			["height"] = 40,
			["internalVersion"] = 70,
			["load"] = {
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["level_operator"] = {
					">=", -- [1]
				},
				["use_level"] = false,
				["level"] = {
					"60", -- [1]
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
						["WARRIOR"] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["cooldown"] = false,
			["displayIcon"] = 132338,
			["desaturate"] = false,
			["zoom"] = 0.3,
			["smoothProgress"] = true,
			["anchorFrameFrame"] = "PlayerFrame",
			["regionType"] = "icon",
			["parent"] = "Skills",
			["uid"] = "HxUbmoeo4w1",
			["icon_side"] = "RIGHT",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["width"] = 40,
			["sparkHeight"] = 30,
			["texture"] = "Melli",
			["alpha"] = 1,
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["spark"] = false,
			["id"] = "Cleave",
			["sparkHidden"] = "NEVER",
			["useAdjustededMin"] = false,
			["useCooldownModRate"] = true,
			["anchorFrameType"] = "SCREEN",
			["auto"] = false,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["inverse"] = false,
			["frameStrata"] = 1,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
		},
		["Victorious' FollowMe"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "KIVs1t-Ni",
			["xOffset"] = 0,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["url"] = "https://wago.io/KIVs1t-Ni/4",
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
						["type"] = "custom",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Health",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["custom"] = "function(event, message, sender, ...)\n    local name = Ambiguate(sender, 'short')\n    local allowed_users = aura_env.config.allowed_users\n    if strlen(allowed_users)>0 then\n        if not tContains({strsplit(\",\", allowed_users)}, name) then\n            return\n        end\n    end\n    if message == aura_env.config.command_follow then\n        FollowUnit(name)     \n    elseif message == aura_env.config.command_stop then\n        FollowUnit(\"player\")\n    end\nend\n\n\n",
						["spellIds"] = {
						},
						["custom_type"] = "event",
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["events"] = "CHAT_MSG_PARTY, CHAT_MSG_RAID, CHAT_MSG_PARTY_LEADER, CHAT_MSG_RAID_LEADER",
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 70,
			["wordWrap"] = "WordWrap",
			["font"] = "Friz Quadrata TT",
			["version"] = 4,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["ingroup"] = {
					["single"] = "group",
					["multi"] = {
						["group"] = true,
						["raid"] = true,
					},
				},
				["use_level"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["level_operator"] = {
					"<", -- [1]
				},
				["use_ingroup"] = false,
				["zoneIds"] = "",
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["level"] = {
					"60", -- [1]
				},
				["use_never"] = false,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 12,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["displayText_format_p_time_legacy_floor"] = true,
			["regionType"] = "text",
			["displayText_format_p_time_mod_rate"] = true,
			["selfPoint"] = "BOTTOM",
			["conditions"] = {
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayText_format_p_time_precision"] = 1,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["config"] = {
				["command_stop"] = "!!stop",
				["command_follow"] = "!!follow",
				["allowed_users"] = "",
			},
			["shadowYOffset"] = -1,
			["justify"] = "LEFT",
			["tocversion"] = 20504,
			["id"] = "Victorious' FollowMe",
			["semver"] = "1.1.2",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["displayText"] = "%p",
			["uid"] = "K4voXrFr5jp",
			["authorOptions"] = {
				{
					["type"] = "input",
					["useDesc"] = true,
					["width"] = 1,
					["desc"] = "The keyword used to trigger the follow command.",
					["key"] = "command_follow",
					["multiline"] = false,
					["default"] = "!follow",
					["length"] = 10,
					["name"] = "Follow Command",
					["useLength"] = false,
				}, -- [1]
				{
					["type"] = "input",
					["useDesc"] = true,
					["width"] = 1,
					["desc"] = "The keyword used to trigger the stop command.",
					["key"] = "command_stop",
					["multiline"] = false,
					["default"] = "!stop",
					["length"] = 10,
					["name"] = "Stop Command",
					["useLength"] = false,
				}, -- [2]
				{
					["type"] = "input",
					["useDesc"] = true,
					["width"] = 1,
					["desc"] = "Players who are allowed to use this command, separated by a comma. Leave empty to allow anyone to use it.",
					["key"] = "allowed_users",
					["multiline"] = false,
					["default"] = "",
					["length"] = 10,
					["name"] = "Allowed Users",
					["useLength"] = false,
				}, -- [3]
			},
			["automaticWidth"] = "Auto",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["preferToUpdate"] = false,
		},
		["Time To Die - Text"] = {
			["outline"] = "None",
			["wagoID"] = "_AoX6WW26",
			["parent"] = "Global - Time To Die",
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["customText"] = "function()\n    local health = UnitHealth(\"target\")\n    local time = GetTime()\n    local text = \"00:00\"\n    local oldhealth\n    if oldhealth ~= health then\n        oldhealth = health\n        if health == UnitHealthMax(\"target\") then\n            aura_env.health0, aura_env.time0, aura_env.mhealth, aura_env.mtime = nil\n            text = \"00:00\"\n            return text\n        end\n        \n        if not aura_env.health0 then\n            aura_env.health0, aura_env.time0 = health, time\n            aura_env.mhealth, aura_env.mtime = health, time\n            return \"00:00\"\n        end\n        \n        aura_env.mhealth = (aura_env.mhealth + health) * .5\n        aura_env.mtime = (aura_env.mtime + time) * .5\n        \n        if aura_env.mhealth >= aura_env.health0 then\n            text = \"00:00\"\n            aura_env.health0, aura_env.time0, aura_env.mhealth, aura_env.mtime = nil\n        else\n            time = health * (aura_env.time0 - aura_env.mtime) / (aura_env.mhealth - aura_env.health0)\n            if (time <= 60) then\n                text = format(\"00:%0.2d\", time)           \n            elseif (time > 60) then\n                text = format(\"%d:%0.2d\", time / 60, time % 60)\n            end\n            return text\n        end\n    end\n    return text\nend",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
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
						["type"] = "unit",
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Health",
						["unit"] = "target",
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
						["unit"] = "target",
					},
				}, -- [1]
				{
					["trigger"] = {
						["use_hostility"] = true,
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showOnCooldown",
						["unit"] = "target",
						["debuffType"] = "HELPFUL",
						["type"] = "unit",
						["unevent"] = "auto",
						["event"] = "Unit Characteristics",
						["use_threatUnit"] = true,
						["realSpellName"] = 0,
						["use_spellName"] = true,
						["threatUnit"] = "target",
						["hostility"] = "hostile",
						["duration"] = "1",
						["use_unit"] = true,
						["use_track"] = true,
						["spellName"] = 0,
					},
					["untrigger"] = {
						["unit"] = "target",
					},
				}, -- [2]
				["activeTriggerMode"] = 1,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["font"] = "ArchivoNarrow-Bold",
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_never"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["fontSize"] = 17,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["url"] = "https://wago.io/_AoX6WW26/1",
			["regionType"] = "text",
			["selfPoint"] = "CENTER",
			["authorOptions"] = {
			},
			["fixedWidth"] = 200,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.70000001788139, -- [4]
			},
			["displayText_format_p_time_precision"] = 1,
			["xOffset"] = 19.500000923228,
			["config"] = {
			},
			["wordWrap"] = "WordWrap",
			["justify"] = "LEFT",
			["tocversion"] = 20503,
			["id"] = "Time To Die - Text",
			["shadowYOffset"] = -1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["semver"] = "1.0.0",
			["uid"] = "WCdlXkHpf3m",
			["displayText"] = "%c",
			["displayText_format_c_format"] = "none",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["preferToUpdate"] = false,
		},
		["Mana Bar Cat/Bear"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = -315,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["url"] = "https://wago.io/HCaWT5tJa/14",
			["icon"] = false,
			["fontFlags"] = "OUTLINE",
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["enableGradient"] = false,
			["selfPoint"] = "CENTER",
			["barColor"] = {
				0.32549019607843, -- [1]
				0.53725490196078, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["sparkOffsetY"] = 0,
			["gradientOrientation"] = "HORIZONTAL",
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["DRUID"] = true,
					},
				},
				["use_class"] = false,
				["role"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["multi"] = {
					},
				},
				["use_vehicle"] = false,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
						[3] = true,
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
				["race"] = {
					["multi"] = {
					},
				},
				["use_petbattle"] = false,
				["size"] = {
					["multi"] = {
					},
				},
				["use_group_leader"] = false,
			},
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["texture"] = "xVerminClean",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["auto"] = true,
			["tocversion"] = 11302,
			["alpha"] = 1,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["sparkOffsetX"] = 0,
			["parent"] = "MANA BAR + DRUID / ROGUE CPOINTS",
			["customText"] = "function()\n    if aura_env.region then\n        local mana = UnitPower(\"player\", Enum.PowerType.Mana)\n        aura_env.region.text3:SetText(mana)\n    end\nend\n\n\n\n\n\n\n\n\n\n\n\n",
			["customTextUpdate"] = "event",
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "1",
						["genericShowOn"] = "showOnActive",
						["names"] = {
						},
						["powertype"] = 0,
						["use_powertype"] = true,
						["custom_hide"] = "timed",
						["use_unit"] = true,
						["type"] = "unit",
						["use_health"] = true,
						["unevent"] = "auto",
						["health_operator"] = ">=",
						["use_requirePowerType"] = false,
						["event"] = "Power",
						["use_percentpower"] = false,
						["unit"] = "player",
						["spellIds"] = {
						},
						["health"] = "0",
						["subeventSuffix"] = "_CAST_START",
						["debuffType"] = "HELPFUL",
						["subeventPrefix"] = "SPELL",
						["use_showCost"] = true,
						["use_power"] = false,
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "aura2",
						["auranames"] = {
							"Cat Form", -- [1]
							"Bear Form", -- [2]
							"Dire Bear Form", -- [3]
						},
						["unit"] = "player",
						["useName"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "all",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
			},
			["backdropInFront"] = false,
			["stickyDuration"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subforeground",
				}, -- [2]
				{
					["text_text_format_p_time_precision"] = 1,
					["text_text_format_t_time_legacy_floor"] = true,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_fixedWidth"] = 64,
					["text_text_format_p_time_legacy_floor"] = true,
					["rotateText"] = "NONE",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_fontSize"] = 12,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_n_format"] = "none",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_text_format_t_time_format"] = 0,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["text_text_format_t_format"] = "timed",
					["type"] = "subtext",
					["text_anchorXOffset"] = 4,
					["text_font"] = "Arial Narrow",
					["text_text"] = "%p / %t",
					["text_anchorYOffset"] = -12,
					["text_shadowXOffset"] = 1,
					["text_text_format_p_time_mod_rate"] = true,
					["text_text_format_t_time_mod_rate"] = true,
					["text_anchorPoint"] = "INNER_RIGHT",
					["text_text_format_p_time_format"] = 0,
					["anchorXOffset"] = 0,
					["text_text_format_t_time_dynamic_threshold"] = 60,
					["text_text_format_t_time_precision"] = 1,
					["text_visible"] = true,
				}, -- [3]
			},
			["height"] = 6,
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["zoom"] = 0,
			["barColor2"] = {
				1, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["overlays"] = {
				{
					0.32549019607843, -- [1]
					0.53725490196078, -- [2]
					1, -- [3]
					0.31999999284744, -- [4]
				}, -- [1]
			},
			["backdropColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["borderInFront"] = true,
			["borderBackdrop"] = "None",
			["icon_side"] = "RIGHT",
			["spark"] = false,
			["sparkRotationMode"] = "AUTO",
			["sparkHeight"] = 30,
			["uid"] = "AOIYnN7jUVG",
			["overlaysTexture"] = {
				"xVerminClean", -- [1]
			},
			["anchorFrameType"] = "SCREEN",
			["semver"] = "1.0.13",
			["id"] = "Mana Bar Cat/Bear",
			["sparkHidden"] = "NEVER",
			["config"] = {
			},
			["frameStrata"] = 3,
			["width"] = 245,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["custom"] = "\n\n\n\n\n\n",
					["do_custom"] = false,
				},
				["finish"] = {
				},
			},
			["backgroundColor"] = {
				0.32549019607843, -- [1]
				0.53725490196078, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["inverse"] = false,
			["sparkDesature"] = false,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["authorOptions"] = {
			},
		},
		["Rage Bar Warrior"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -100,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["url"] = "https://wago.io/HCaWT5tJa/14",
			["icon"] = false,
			["fontFlags"] = "OUTLINE",
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["enableGradient"] = false,
			["selfPoint"] = "CENTER",
			["barColor"] = {
				1, -- [1]
				0, -- [2]
				0.1490196138620377, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["sparkOffsetY"] = 0,
			["gradientOrientation"] = "HORIZONTAL",
			["load"] = {
				["zoneIds"] = "",
				["use_petbattle"] = false,
				["use_never"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["use_vehicle"] = false,
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["WARRIOR"] = true,
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
				["use_class"] = false,
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
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
						[3] = true,
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["texture"] = "xVerminClean",
			["zoom"] = 0,
			["auto"] = true,
			["tocversion"] = 11302,
			["alpha"] = 1,
			["config"] = {
			},
			["sparkOffsetX"] = 0,
			["parent"] = "Power Bar Group",
			["customText"] = "",
			["sparkRotationMode"] = "AUTO",
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "1",
						["use_showCost"] = true,
						["names"] = {
						},
						["powertype"] = 1,
						["use_powertype"] = true,
						["custom_hide"] = "timed",
						["genericShowOn"] = "showOnActive",
						["type"] = "unit",
						["use_health"] = true,
						["unevent"] = "auto",
						["use_power"] = false,
						["health_operator"] = ">=",
						["use_requirePowerType"] = true,
						["use_percentpower"] = false,
						["subeventSuffix"] = "_CAST_START",
						["health"] = "0",
						["spellIds"] = {
						},
						["event"] = "Power",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["use_unit"] = true,
						["unit"] = "player",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "all",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
			},
			["backdropInFront"] = false,
			["stickyDuration"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subforeground",
				}, -- [2]
				{
					["text_shadowXOffset"] = 1,
					["text_text"] = "%p / %t",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_fixedWidth"] = 64,
					["text_text_format_c_format"] = "none",
					["rotateText"] = "NONE",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_text_format_ct_format"] = "none",
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_text_format_t_time_format"] = 0,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["text_text_format_t_format"] = "timed",
					["type"] = "subtext",
					["text_text_format_p_time_mod_rate"] = true,
					["text_text_format_p_time_precision"] = 1,
					["text_font"] = "Arial Narrow",
					["text_text_format_p_time_legacy_floor"] = false,
					["text_anchorYOffset"] = -1,
					["text_text_format_t_time_dynamic_threshold"] = 60,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_t_time_mod_rate"] = true,
					["text_anchorPoint"] = "INNER_CENTER",
					["text_text_format_t_time_legacy_floor"] = false,
					["text_shadowYOffset"] = -1,
					["text_text_format_t_time_precision"] = 1,
					["text_text_format_p_time_format"] = 0,
					["text_visible"] = true,
				}, -- [3]
			},
			["height"] = 6,
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["barColor2"] = {
				1, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["uid"] = "PF1pRLYxwlE",
			["overlays"] = {
				{
					0.43529411764706, -- [1]
					0, -- [2]
					1, -- [3]
					0.25, -- [4]
				}, -- [1]
			},
			["borderInFront"] = true,
			["borderBackdrop"] = "None",
			["icon_side"] = "RIGHT",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["custom"] = "if aura_env.region then\n    local r = aura_env.region\n    if not r.text3 then\n        local text3 = r.bar:CreateFontString(nil, \"OVERLAY\")\n        r.text3 = text3\n        r.text3:SetJustifyH(\"CENTER\")\n        r.text3:SetJustifyV(\"MIDDLE\")\n        r.text3:SetPoint(\"CENTER\", r.bar, \"CENTER\")\n        r.text3:Show()\n    end\n    r.text3:SetShadowOffset(1, -1)\n    r.text3:SetFont(r.text:GetFont())\n    r.text3:SetTextColor(r.text:GetTextColor())\nend\n\n\n\n\n\n\n",
					["do_custom"] = false,
				},
				["finish"] = {
				},
			},
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["sparkHeight"] = 30,
			["backdropColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["overlaysTexture"] = {
				"Melli Dark", -- [1]
			},
			["width"] = 220,
			["semver"] = "1.0.13",
			["id"] = "Rage Bar Warrior",
			["sparkHidden"] = "NEVER",
			["spark"] = false,
			["frameStrata"] = 3,
			["anchorFrameType"] = "SCREEN",
			["backgroundColor"] = {
				1, -- [1]
				0, -- [2]
				0.1607843190431595, -- [3]
				0.5, -- [4]
			},
			["customTextUpdate"] = "event",
			["inverse"] = false,
			["sparkDesature"] = false,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["xOffset"] = 0,
		},
		["Light's Grace"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["wagoID"] = "v9qxdDgI4",
			["parent"] = "Vermin Paladin",
			["preferToUpdate"] = false,
			["sparkHeight"] = 30,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["sparkOffsetX"] = 0,
			["cooldownSwipe"] = true,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Light's Grace", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showOnReady",
						["names"] = {
						},
						["debuffType"] = "HELPFUL",
						["useName"] = true,
						["subeventSuffix"] = "_CAST_START",
						["unevent"] = "auto",
						["subeventPrefix"] = "SPELL",
						["unit"] = "player",
						["event"] = "Action Usable",
						["type"] = "aura2",
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_genericShowOn"] = true,
						["spellName"] = 34428,
						["use_unit"] = true,
						["use_track"] = true,
						["useIgnoreName"] = false,
					},
					["untrigger"] = {
						["genericShowOn"] = "showOnReady",
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
			["useTooltip"] = false,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["authorOptions"] = {
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["barColor"] = {
				0.2, -- [1]
				1, -- [2]
				0.0862745098039216, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["internalVersion"] = 70,
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.75,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["text_color"] = {
					},
					["glowThickness"] = 2,
					["glowDuration"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0.85098039215686, -- [2]
						0.1843137254902, -- [3]
						1, -- [4]
					},
					["useGlowColor"] = true,
					["glow"] = true,
					["glowLength"] = 16,
					["glowType"] = "buttonOverlay",
					["glowScale"] = 1,
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "%p",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["type"] = "subtext",
					["anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_shadowXOffset"] = 0,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 12,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_p_time_mod_rate"] = true,
				}, -- [3]
				{
					["text_text_format_p_time_precision"] = 1,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_p_time_legacy_floor"] = false,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_format"] = "timed",
					["anchorXOffset"] = 0,
					["type"] = "subtext",
					["text_shadowXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_format"] = 0,
					["text_anchorYOffset"] = 25,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_time_mod_rate"] = true,
					["text_shadowYOffset"] = 0,
					["text_fontSize"] = 12,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["anchorYOffset"] = 0,
				}, -- [4]
			},
			["height"] = 40,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["load"] = {
				["use_level"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["use_class"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "PALADIN",
					["multi"] = {
					},
				},
				["use_never"] = false,
				["level"] = {
					"60", -- [1]
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["conditions"] = {
			},
			["smoothProgress"] = true,
			["anchorFrameFrame"] = "PlayerFrame",
			["regionType"] = "icon",
			["xOffset"] = 0,
			["config"] = {
			},
			["icon_side"] = "RIGHT",
			["useAdjustededMin"] = false,
			["id"] = "Light's Grace",
			["anchorFrameParent"] = false,
			["texture"] = "Melli",
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = false,
			["auto"] = false,
			["alpha"] = 1,
			["sparkHidden"] = "NEVER",
			["zoom"] = 0.3,
			["useCooldownModRate"] = true,
			["width"] = 40,
			["spark"] = false,
			["uid"] = "CAA(0r6q)ih",
			["inverse"] = false,
			["frameStrata"] = 1,
			["orientation"] = "HORIZONTAL",
			["displayIcon"] = "",
			["cooldown"] = false,
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
		},
		["Icebound Fortitude"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["wagoID"] = "v9qxdDgI4",
			["parent"] = "Vermin Death Knight",
			["preferToUpdate"] = false,
			["sparkHeight"] = 30,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["sparkOffsetX"] = 0,
			["cooldownSwipe"] = true,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Icebound Fortitude", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showOnReady",
						["names"] = {
						},
						["debuffType"] = "HELPFUL",
						["useName"] = true,
						["subeventSuffix"] = "_CAST_START",
						["unevent"] = "auto",
						["subeventPrefix"] = "SPELL",
						["unit"] = "player",
						["event"] = "Action Usable",
						["type"] = "aura2",
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_genericShowOn"] = true,
						["spellName"] = 34428,
						["use_unit"] = true,
						["use_track"] = true,
						["useIgnoreName"] = false,
					},
					["untrigger"] = {
						["genericShowOn"] = "showOnReady",
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
			["internalVersion"] = 70,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["xOffset"] = 0,
			["authorOptions"] = {
			},
			["barColor"] = {
				0.2, -- [1]
				1, -- [2]
				0.0862745098039216, -- [3]
				1, -- [4]
			},
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["useTooltip"] = true,
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.75,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["text_color"] = {
					},
					["glowThickness"] = 2,
					["glowDuration"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0.85098039215686, -- [2]
						0.1843137254902, -- [3]
						1, -- [4]
					},
					["useGlowColor"] = true,
					["glow"] = true,
					["glowLength"] = 16,
					["glowType"] = "buttonOverlay",
					["glowScale"] = 1,
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "%p",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["type"] = "subtext",
					["anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_shadowXOffset"] = 0,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 12,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_p_time_mod_rate"] = true,
				}, -- [3]
			},
			["height"] = 40,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["load"] = {
				["use_level"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["use_class"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "DEATHKNIGHT",
					["multi"] = {
					},
				},
				["use_never"] = false,
				["level"] = {
					"60", -- [1]
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["config"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["desaturate"] = false,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["conditions"] = {
			},
			["smoothProgress"] = true,
			["anchorFrameFrame"] = "PlayerFrame",
			["regionType"] = "icon",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["uid"] = "D5SrjKKh683",
			["icon_side"] = "RIGHT",
			["useAdjustededMin"] = false,
			["id"] = "Icebound Fortitude",
			["anchorFrameParent"] = false,
			["texture"] = "Melli",
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = false,
			["auto"] = false,
			["useCooldownModRate"] = true,
			["sparkHidden"] = "NEVER",
			["zoom"] = 0.3,
			["frameStrata"] = 1,
			["width"] = 40,
			["spark"] = false,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["inverse"] = false,
			["alpha"] = 1,
			["orientation"] = "HORIZONTAL",
			["displayIcon"] = "",
			["cooldown"] = false,
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
		},
		["Power Bar Group"] = {
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["controlledChildren"] = {
				"Rage Bar Warrior", -- [1]
				"Mana Bar", -- [2]
				"Runic Power Bar", -- [3]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["authorOptions"] = {
			},
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "group",
			["borderSize"] = 2,
			["yOffset"] = 0,
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
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
			["triggers"] = {
				{
					["trigger"] = {
						["debuffType"] = "HELPFUL",
						["type"] = "aura2",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["event"] = "Health",
						["names"] = {
						},
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["information"] = {
			},
			["borderOffset"] = 4,
			["internalVersion"] = 70,
			["selfPoint"] = "CENTER",
			["id"] = "Power Bar Group",
			["scale"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["config"] = {
			},
			["borderInset"] = 1,
			["uid"] = "hxVt8zOs3Is",
			["anchorPoint"] = "CENTER",
			["conditions"] = {
			},
			["load"] = {
				["talent"] = {
					["multi"] = {
					},
				},
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
			["xOffset"] = 0,
		},
		["Recklessness"] = {
			["sparkWidth"] = 10,
			["sparkOffsetX"] = 0,
			["wagoID"] = "v9qxdDgI4",
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["sparkHeight"] = 30,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["iconSource"] = -1,
			["cooldownSwipe"] = true,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["cooldownEdge"] = false,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Recklessness", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showOnReady",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "aura2",
						["subeventPrefix"] = "SPELL",
						["unevent"] = "auto",
						["use_unit"] = true,
						["names"] = {
						},
						["event"] = "Action Usable",
						["spellName"] = 34428,
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_genericShowOn"] = true,
						["useName"] = true,
						["subeventSuffix"] = "_CAST_START",
						["use_track"] = true,
						["useIgnoreName"] = false,
					},
					["untrigger"] = {
						["genericShowOn"] = "showOnReady",
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
			["internalVersion"] = 70,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["parent"] = "Vermin Warrior",
			["barColor"] = {
				0.2, -- [1]
				1, -- [2]
				0.0862745098039216, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["useTooltip"] = false,
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.75,
					["type"] = "subglow",
					["useGlowColor"] = true,
					["text_color"] = {
					},
					["glowThickness"] = 2,
					["glowDuration"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0.85098039215686, -- [2]
						0.1843137254902, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 16,
					["glow"] = true,
					["glowScale"] = 1,
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_p_time_precision"] = 1,
					["text_text"] = "%p",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_mod_rate"] = true,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_shadowXOffset"] = 0,
					["text_visible"] = true,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_p_format"] = "timed",
				}, -- [3]
			},
			["height"] = 36,
			["selfPoint"] = "CENTER",
			["load"] = {
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
						["WARRIOR"] = true,
					},
				},
				["use_class"] = false,
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["use_level"] = false,
				["level"] = {
					"60", -- [1]
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["config"] = {
			},
			["cooldown"] = false,
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["icon"] = true,
			["displayIcon"] = "",
			["smoothProgress"] = true,
			["anchorFrameFrame"] = "PlayerFrame",
			["regionType"] = "icon",
			["authorOptions"] = {
			},
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["icon_side"] = "RIGHT",
			["useAdjustededMin"] = false,
			["sparkHidden"] = "NEVER",
			["anchorFrameParent"] = false,
			["texture"] = "Melli",
			["anchorFrameType"] = "SCREEN",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["auto"] = false,
			["frameStrata"] = 1,
			["id"] = "Recklessness",
			["zoom"] = 0.3,
			["useCooldownModRate"] = true,
			["width"] = 36,
			["spark"] = false,
			["uid"] = "j5VoEwQm2DA",
			["inverse"] = false,
			["alpha"] = 1,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["cooldownTextDisabled"] = false,
		},
		["Luxthos - Experience Group"] = {
			["controlledChildren"] = {
				"Experience Bar - Luxthos", -- [1]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["wagoID"] = "3GaU4Ttxj",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -50,
			["anchorPoint"] = "TOP",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["url"] = "https://wago.io/LuxthosExperienceBar/40",
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
						["names"] = {
						},
						["type"] = "aura2",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["event"] = "Health",
						["unit"] = "player",
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desc"] = "Created by Luxthos & Daemoos\nwww.twitch.tv/luxthos",
			["version"] = 40,
			["subRegions"] = {
			},
			["load"] = {
				["talent"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["source"] = "import",
			["scale"] = 0.8,
			["border"] = false,
			["anchorFrameFrame"] = "UIParent",
			["regionType"] = "group",
			["borderSize"] = 2,
			["anchorFrameParent"] = false,
			["borderEdge"] = "Square Full White",
			["borderOffset"] = 4,
			["semver"] = "3.0.5",
			["tocversion"] = 100002,
			["id"] = "Luxthos - Experience Group",
			["selfPoint"] = "BOTTOMLEFT",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["groupIcon"] = "132996",
			["uid"] = "71NVVv0hq7p",
			["borderInset"] = 1,
			["config"] = {
			},
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["groupOffset"] = true,
			},
			["xOffset"] = 0,
		},
		["Swing Timer"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["wagoID"] = "jEBcD-xSW",
			["authorOptions"] = {
				{
					["type"] = "toggle",
					["default"] = false,
					["width"] = 1,
					["name"] = "Off Hand",
					["useDesc"] = true,
					["key"] = "offHand",
					["desc"] = "Track only the swings made using your off hand weapon.",
				}, -- [1]
			},
			["preferToUpdate"] = true,
			["yOffset"] = -75,
			["anchorPoint"] = "CENTER",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["url"] = "https://wago.io/jEBcD-xSW/8",
			["icon"] = false,
			["triggers"] = {
				{
					["trigger"] = {
						["dynamicDuration"] = true,
						["customIcon"] = "function()\n  if aura_env.rangedSwing then\n    return GetInventoryItemTexture(\"player\", 18)\n  elseif aura_env.UseOffHand() then\n    return GetInventoryItemTexture(\"player\", 17)\n  else\n    return GetInventoryItemTexture(\"player\", 16)\n  end\nend",
						["custom_hide"] = "timed",
						["type"] = "custom",
						["custom_type"] = "event",
						["subeventPrefix"] = "SPELL",
						["names"] = {
						},
						["event"] = "Health",
						["unit"] = "player",
						["customDuration"] = "function()\n  local now = GetTime()\n  local useOffHand = aura_env.UseOffHand()\n  \n  local function CalculateParryHaste(current, total)\n    return math.max(current - total * 0.4, math.min(current, total * 0.2))\n  end\n  \n  local swingSpeed\n  \n  if aura_env.rangedSwing then\n    swingSpeed = UnitRangedDamage(\"player\")\n  else\n    local mainSpeed, offSpeed = UnitAttackSpeed(\"player\")\n    \n    if useOffHand and offSpeed then\n      swingSpeed = offSpeed\n    else\n      swingSpeed = mainSpeed\n    end\n  end\n  \n  if aura_env.parryHaste then\n    local remainingDuration = aura_env.nextSwingTime - now\n    local remainingAfterHaste = CalculateParryHaste(remainingDuration, swingSpeed)\n    local hasteDuration = remainingDuration - remainingAfterHaste\n    \n    aura_env.parryHaste = false\n    return swingSpeed, aura_env.nextSwingTime - hasteDuration\n  elseif aura_env.pauseState == \"PAUSING\" then\n    local remainingDuration = math.max(aura_env.nextSwingTime - now, 0)\n    \n    aura_env.pauseTime = now\n    aura_env.pauseState = \"PAUSED\"\n    return remainingDuration, swingSpeed, true\n  elseif aura_env.pauseState == \"INTERRUPTED\" then\n    aura_env.pauseState = \"RESUMED\"\n    return swingSpeed, aura_env.nextSwingTime\n  elseif aura_env.pauseState == \"RESUMING\" then\n    local pauseDuration = now - aura_env.pauseTime\n    local newSwingTime = aura_env.nextSwingTime + pauseDuration\n    \n    aura_env.nextSwingTime = newSwingTime\n    aura_env.pauseState = \"RESUMED\"\n    return swingSpeed, newSwingTime\n  end\n  \n  local nextSwingTime = now + swingSpeed\n  \n  aura_env.nextSwingTime = nextSwingTime\n  return swingSpeed, nextSwingTime\nend",
						["customName"] = "function()\n  local function GetSlotItemName(slotId)\n    local slotItemId = GetInventoryItemID(\"player\", slotId)\n    \n    if slotItemId then\n      return GetItemInfo(slotItemId)\n    end\n  end\n  \n  if aura_env.rangedSwing then\n    return GetSlotItemName(18)\n  elseif aura_env.UseOffHand() then\n    return GetSlotItemName(17)\n  else\n    return GetSlotItemName(16) or \"Unarmed\"\n  end\nend",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["customTexture"] = "",
						["custom"] = "function(event, ...)\n    local function IsSpellCastSlam(...)\n        local spellId = select(3, ...)\n        local spellName = GetSpellInfo(spellId)\n        \n        -- if select(2, UnitClass('player')) == \"WARRIOR\" then\n        --    if GetShapeshiftForm() == 3 then return false end\n        -- end\n        \n        if IsSpellKnown(23881) then return false end\n            \n            return spellName == \"Slam\"\n        end\n        \n        if event == \"COMBAT_LOG_EVENT_UNFILTERED\" then\n            local subEvent = select(2, ...)\n            local sourceGUID = select(4, ...)\n            local destGUID = select(8, ...)\n            local playerGUID = UnitGUID(\"player\")\n            local useOffHand = aura_env.UseOffHand()\n            \n            if subEvent == \"SWING_MISSED\" and destGUID == playerGUID and not useOffHand and not aura_env.rangedSwing then\n                local missType = select(12, ...)\n                \n                if missType == \"PARRY\" then\n                    aura_env.parryHaste = true\n                    return true\n                else\n                    return false\n                end\n            elseif sourceGUID ~= playerGUID then\n                return false\n            end\n            \n            if subEvent == \"SPELL_CAST_SUCCESS\" and not useOffHand then\n                local spellName = select(13, ...)\n                \n                if aura_env.MELEE_SWING_SPELLS[spellName] then\n                    aura_env.rangedSwing = false\n                    return true\n                elseif aura_env.RANGED_SWING_SPELLS[spellName] then\n                    aura_env.rangedSwing = true\n                    return true\n                else\n                    return false\n                end\n            end\n            \n            local isOffHand = false\n            \n            if subEvent == \"SWING_DAMAGE\" then\n                isOffHand = select(21, ...)\n            elseif subEvent == \"SWING_MISSED\" then\n                isOffHand = select(13, ...)\n            end\n            \n            aura_env.rangedSwing = false\n            return (useOffHand and isOffHand) or (not useOffHand and not isOffHand)\n        elseif event == \"UNIT_SPELLCAST_START\" and IsSpellCastSlam(...) then\n            aura_env.rangedSwing = false\n            aura_env.pauseState = \"PAUSING\"\n            return true\n        elseif event == \"UNIT_SPELLCAST_STOP\" and IsSpellCastSlam(...) then\n            aura_env.rangedSwing = false\n            aura_env.pauseState = \"INTERRUPTED\"\n            return true\n        elseif event == \"UNIT_SPELLCAST_SUCCEEDED\" and IsSpellCastSlam(...) then\n            aura_env.rangedSwing = false\n            aura_env.pauseState = \"RESUMING\"\n            return true\n        end\n    end",
						["events"] = "CLEU:SWING_DAMAGE,CLEU:SWING_MISSED,CLEU:SPELL_CAST_SUCCESS,UNIT_SPELLCAST_START:player,UNIT_SPELLCAST_STOP:player,UNIT_SPELLCAST_SUCCEEDED:player",
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
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["colorR"] = 1,
					["duration"] = "100",
					["colorB"] = 1,
					["colorG"] = 1,
					["type"] = "custom",
					["easeType"] = "none",
					["scalex"] = 1,
					["use_color"] = true,
					["alpha"] = 0,
					["scaley"] = 1,
					["y"] = 0,
					["colorType"] = "custom",
					["easeStrength"] = 3,
					["x"] = 0,
					["colorFunc"] = "function()\n    local c =  select(2, UnitClass('player'))\n    local cl = RAID_CLASS_COLORS[c]\n    \n    local hs = IsCurrentSpell( select(7,GetSpellInfo('Heroic Strike')) )\n    local cleave = IsCurrentSpell(select(7,GetSpellInfo('Cleave')))\n    local runestrike = IsCurrentSpell(select(7,GetSpellInfo('Rune Strike')))\n    local raptorstrike = IsCurrentSpell(select(7,GetSpellInfo('Raptor Strike')))\n    local maul = IsCurrentSpell(select(7,GetSpellInfo('Maul')))\n    \n    if hs then \n        return 168/255,45/255,20/255,1\n    end\n    \n    if cleave then \n        return 152/255,192/255,42/255,1\n    end\n    \n    if runestrike then \n        return 24/255,105/255,119/255,1\n    end\n    \n    if raptorstrike then \n        return 154/255,194/255,212/255,1\n    end\n    \n    if maul then \n        return 96/255,100/255,126/255,1\n    end\n    \n    return cl.r,cl.g,cl.b,1\nend",
					["rotate"] = 0,
					["colorA"] = 1,
					["duration_type"] = "relative",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["sparkOffsetX"] = 0,
			["barColor2"] = {
				1, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["barColor"] = {
				1, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["desc"] = "Martymoo-Whitemane",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "aura_env.nextSwingTime = 0\n\naura_env.UseOffHand = function()\n    return aura_env.config[\"offHand\"]\nend\n\naura_env.MELEE_SWING_SPELLS = {\n    [\"Heroic Strike\"] = true,\n    [\"Cleave\"] = true,\n    [\"Raptor Strike\"] = true,\n    [\"Maul\"] = true,\n    [\"Rune Strike\"] = true\n}\n\naura_env.RANGED_SWING_SPELLS = {\n    [\"Shoot\"] = true,\n    [\"Throw\"] = true,\n    [\"Auto Shot\"] = true\n}",
					["do_custom"] = true,
				},
			},
			["enableGradient"] = false,
			["version"] = 8,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subforeground",
				}, -- [2]
				{
					["text_shadowXOffset"] = 0,
					["text_text"] = "%p",
					["text_text_format_p_format"] = "Number",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_p_time_precision"] = 1,
					["text_text_format_p_time_legacy_floor"] = false,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						0, -- [4]
					},
					["text_text_format_p_decimal_precision"] = 1,
					["type"] = "subtext",
					["text_anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["anchorYOffset"] = 0,
					["text_anchorYOffset"] = 5,
					["text_visible"] = false,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "BOTTOM",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_fontSize"] = 14,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
				}, -- [3]
				{
					["text_text_format_t_decimal_precision"] = 1,
					["text_text_format_t_time_legacy_floor"] = false,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						0, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_t_time_format"] = 0,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_t_format"] = "Number",
					["text_shadowXOffset"] = 0,
					["type"] = "subtext",
					["text_text_format_t_time_dynamic_threshold"] = 60,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text"] = "%t",
					["text_shadowYOffset"] = 0,
					["text_fontType"] = "None",
					["text_wordWrap"] = "WordWrap",
					["text_text_format_t_time_mod_rate"] = true,
					["text_anchorPoint"] = "INNER_CENTER",
					["text_text_format_n_format"] = "none",
					["text_visible"] = false,
					["text_fontSize"] = 10,
					["anchorXOffset"] = 0,
					["text_text_format_t_time_precision"] = 1,
				}, -- [4]
				{
					["border_offset"] = 0,
					["border_anchor"] = "bar",
					["border_size"] = 1,
					["border_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["border_visible"] = false,
					["border_edge"] = "Drop Shadow",
					["type"] = "subborder",
				}, -- [5]
			},
			["height"] = 6,
			["selfPoint"] = "CENTER",
			["load"] = {
				["itemtypeequipped"] = {
				},
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["use_itemequiped"] = false,
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
			["useAdjustededMax"] = false,
			["xOffset"] = 0,
			["source"] = "import",
			["config"] = {
				["offHand"] = false,
			},
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["anchorFrameType"] = "SCREEN",
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["frameStrata"] = 1,
			["desaturate"] = false,
			["icon_side"] = "RIGHT",
			["id"] = "Swing Timer",
			["sparkHeight"] = 30,
			["texture"] = "xVerminClean",
			["semver"] = "1.0.7",
			["zoom"] = 0,
			["spark"] = false,
			["tocversion"] = 30400,
			["sparkHidden"] = "NEVER",
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["alpha"] = 1,
			["width"] = 220,
			["gradientOrientation"] = "HORIZONTAL",
			["uid"] = "v0uJOFAgKPV",
			["inverse"] = true,
			["sparkOffsetY"] = 0,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["parent"] = "SwingTimer - Queue skills",
		},
		["MobHPPercentRED"] = {
			["outline"] = "THICKOUTLINE",
			["color"] = {
				1, -- [1]
				0.047058823529412, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["displayText"] = "%c%",
			["customText"] = "function()\nlocal percent = (UnitHealth(\"target\")/UnitHealthMax(\"target\"))*100\nreturn (\"%.f\"):format(percent)\nend",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/B_hMNakf_/2",
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
					["glow_frame"] = "WeakAuras:MobHPPercentRED",
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "unit",
						["unevent"] = "auto",
						["percenthealth"] = {
							"20", -- [1]
						},
						["duration"] = "1",
						["event"] = "Health",
						["use_unit"] = true,
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["unit"] = "target",
						["use_percenthealth"] = true,
						["percenthealth_operator"] = {
							"<=", -- [1]
						},
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "custom",
						["custom"] = "function()\n    local region = aura_env.region\n    local plate = C_NamePlate.GetNamePlateForUnit(\"target\")\n    \n    \n    if plate then\n        region:ClearAllPoints()\n        region:SetPoint(\"RIGHT\", plate, \"LEFT\", -60, 0)\n        return true\n    else\n        return false\n    end\nend",
						["custom_type"] = "status",
						["check"] = "update",
						["debuffType"] = "HELPFUL",
						["unit"] = "player",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["wordWrap"] = "WordWrap",
			["font"] = "Friz Quadrata TT",
			["version"] = 2,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_namerealm"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["namerealm"] = "xxx",
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 24,
			["shadowXOffset"] = 1,
			["preferToUpdate"] = false,
			["regionType"] = "text",
			["displayText_format_c_format"] = "none",
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "alphaPulse",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["fixedWidth"] = 200,
			["anchorFrameParent"] = false,
			["automaticWidth"] = "Auto",
			["authorOptions"] = {
			},
			["config"] = {
			},
			["semver"] = "1.0.1",
			["tocversion"] = 11306,
			["id"] = "MobHPPercentRED",
			["shadowYOffset"] = -1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["xOffset"] = 0,
			["uid"] = "L9pe9C7xoBj",
			["justify"] = "LEFT",
			["selfPoint"] = "BOTTOM",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["parent"] = "TARGET HP PERCENT",
		},
		["Power Word Fortitude"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["wagoID"] = "v9qxdDgI4",
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["sparkHeight"] = 30,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["sparkOffsetX"] = 0,
			["cooldownSwipe"] = true,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Power Word: Fortitude", -- [1]
						},
						["matchesShowOn"] = "showOnMissing",
						["genericShowOn"] = "showOnReady",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
						["subeventPrefix"] = "SPELL",
						["useName"] = true,
						["unevent"] = "auto",
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["type"] = "aura2",
						["event"] = "Action Usable",
						["unit"] = "player",
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["spellName"] = 34428,
						["use_genericShowOn"] = true,
						["names"] = {
						},
						["use_track"] = true,
						["useIgnoreName"] = false,
					},
					["untrigger"] = {
						["genericShowOn"] = "showOnReady",
					},
				}, -- [1]
				{
					["trigger"] = {
						["useRem"] = true,
						["rem"] = "30",
						["type"] = "aura2",
						["auranames"] = {
							"Power Word: Fortitude", -- [1]
						},
						["remOperator"] = "<=",
						["useName"] = true,
						["debuffType"] = "HELPFUL",
						["unit"] = "player",
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
			["internalVersion"] = 70,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["authorOptions"] = {
			},
			["parent"] = "Vermin Priest",
			["barColor"] = {
				0.2, -- [1]
				1, -- [2]
				0.0862745098039216, -- [3]
				1, -- [4]
			},
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["useTooltip"] = false,
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.5,
					["type"] = "subglow",
					["glowDuration"] = 1,
					["text_color"] = {
					},
					["glowThickness"] = 2,
					["useGlowColor"] = true,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0.5215686559677124, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["glowScale"] = 1,
					["glow"] = true,
					["glowLength"] = 16,
					["glowType"] = "buttonOverlay",
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "%p",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_mod_rate"] = true,
					["type"] = "subtext",
					["anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "OUTER_TOP",
					["text_shadowXOffset"] = 0,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 10,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_p_format"] = "timed",
				}, -- [3]
			},
			["height"] = 36,
			["selfPoint"] = "CENTER",
			["load"] = {
				["use_never"] = false,
				["talent"] = {
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
				["use_class"] = true,
				["use_spellknown"] = true,
				["level_operator"] = {
					">=", -- [1]
				},
				["class"] = {
					["single"] = "PRIEST",
					["multi"] = {
					},
				},
				["use_level"] = false,
				["level"] = {
					"5", -- [1]
				},
				["spellknown"] = 1243,
				["zoneIds"] = "",
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["desaturate"] = false,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["conditions"] = {
			},
			["smoothProgress"] = true,
			["anchorFrameFrame"] = "PlayerFrame",
			["regionType"] = "icon",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["config"] = {
			},
			["icon_side"] = "RIGHT",
			["useAdjustededMin"] = false,
			["sparkHidden"] = "NEVER",
			["anchorFrameParent"] = false,
			["texture"] = "Melli",
			["width"] = 36,
			["cooldownTextDisabled"] = false,
			["spark"] = false,
			["frameStrata"] = 1,
			["id"] = "Power Word Fortitude",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["useCooldownModRate"] = true,
			["anchorFrameType"] = "SCREEN",
			["auto"] = false,
			["uid"] = "bLg)2D8MOPH",
			["inverse"] = false,
			["alpha"] = 1,
			["orientation"] = "HORIZONTAL",
			["displayIcon"] = "",
			["cooldown"] = false,
			["zoom"] = 0,
		},
		["Talent and Equipment swap (clickable)"] = {
			["controlledChildren"] = {
				"Zyein Death Knight - Primary Talents - \"Tank\"", -- [1]
				"Zyein Death Knight - Secondary Talents - \"Frost\"", -- [2]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["wagoID"] = "Jzpifubqi",
			["xOffset"] = 724.54248046875,
			["preferToUpdate"] = false,
			["yOffset"] = 191.20989990234,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["url"] = "https://wago.io/Jzpifubqi/2",
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
						["names"] = {
						},
						["type"] = "aura2",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["event"] = "Health",
						["unit"] = "player",
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["version"] = 2,
			["subRegions"] = {
			},
			["load"] = {
				["size"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["multi"] = {
					},
				},
			},
			["backdropColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["source"] = "import",
			["scale"] = 1,
			["border"] = true,
			["borderEdge"] = "Blizzard Dialog",
			["regionType"] = "group",
			["borderSize"] = 10,
			["borderOffset"] = 4,
			["semver"] = "1.0.1",
			["tocversion"] = 30400,
			["id"] = "Talent and Equipment swap (clickable)",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["authorOptions"] = {
			},
			["borderInset"] = 1,
			["uid"] = "cBL75HqYPiW",
			["selfPoint"] = "CENTER",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["config"] = {
			},
		},
		["Ore Count"] = {
			["grow"] = "HORIZONTAL",
			["controlledChildren"] = {
				"Cobalt Ore", -- [1]
				"Dark Iron Ore", -- [2]
				"Mithril Ore", -- [3]
				"Thorium Ore", -- [4]
				"Copper Ore", -- [5]
				"Truesilver Ore", -- [6]
				"Iron Ore", -- [7]
				"Gold Ore", -- [8]
				"Tin Ore", -- [9]
				"Silver Ore", -- [10]
				"Fel Iron Ore", -- [11]
				"Adamantite Ore", -- [12]
				"Saronite Ore", -- [13]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["xOffset"] = 0,
			["yOffset"] = -30,
			["anchorPoint"] = "TOP",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["space"] = 5,
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
			["radius"] = 200,
			["selfPoint"] = "CENTER",
			["align"] = "CENTER",
			["stagger"] = 0,
			["uid"] = "BiUy4gY8pJ(",
			["internalVersion"] = 70,
			["load"] = {
				["size"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["multi"] = {
					},
				},
			},
			["rotation"] = 0,
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["authorOptions"] = {
			},
			["animate"] = true,
			["useLimit"] = false,
			["scale"] = 1,
			["centerType"] = "LR",
			["border"] = false,
			["anchorFrameFrame"] = "ChatFrame3",
			["regionType"] = "dynamicgroup",
			["borderSize"] = 2,
			["sort"] = "none",
			["stepAngle"] = 15,
			["borderEdge"] = "Square Full White",
			["anchorFrameParent"] = false,
			["constantFactor"] = "RADIUS",
			["arcLength"] = 360,
			["borderOffset"] = 4,
			["limit"] = 5,
			["frameStrata"] = 1,
			["id"] = "Ore Count",
			["borderInset"] = 1,
			["gridWidth"] = 5,
			["anchorFrameType"] = "SCREEN",
			["gridType"] = "RD",
			["config"] = {
			},
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["rowSpace"] = 1,
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["fullCircle"] = true,
		},
		["Zyein Death Knight - Secondary Talents - \"Frost\""] = {
			["iconSource"] = -1,
			["wagoID"] = "Jzpifubqi",
			["parent"] = "Talent and Equipment swap (clickable)",
			["preferToUpdate"] = false,
			["customText"] = "function()\n   return aura_env.config[\"equipmentSetName\"] \nend",
			["yOffset"] = -48,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["url"] = "https://wago.io/Jzpifubqi/2",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "aura_env.TALENT_GROUP = aura_env.config[\"talentGroup\"] --Which talent spec to activiate, either 1 or 2\nlocal TALENT_GROUP = aura_env.TALENT_GROUP\n\nlocal r = WeakAuras.regions[aura_env.id].region\nlocal b = CreateFrame(\"Button\", aura_env.id, r)\n\nb:SetAllPoints()\nb:SetHighlightTexture(\"Interface\\\\ContainerFrame\\\\UI-Icon-QuestBorder\") --yellow glow\nb:RegisterForClicks(\"LeftButtonUp\") --\"AnyUp\"\nb:SetScript(\"OnClick\",\n    function(self, button, down)\n        WeakAuras.ScanEvents(\"WA_TALENT_EQUIP_SWAP\", TALENT_GROUP, true)\n    end\n)\n--[[\nb:SetScript('OnEnter',\n    function()\n        WeakAuras.ScanEvents('WA_TALENT_EQUIP_SWAP_MOUSEOVER', true)\n    end\n)\nb:SetScript('OnLeave',\n    function()\n        WeakAuras.ScanEvents('WA_TALENT_EQUIP_SWAP_MOUSEOVER', false)\n    end\n)\n--]]",
					["do_custom"] = true,
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["custom_type"] = "event",
						["debuffType"] = "HELPFUL",
						["duration"] = "5",
						["event"] = "Health",
						["unit"] = "player",
						["names"] = {
						},
						["custom"] = "function(e, talentGroup, wasClicked)\n    --WA_TALENT_EQUIP_SWAP is fired when our button is clicked\n    --EQUIPMENT_SETS_CHANGED (no args) is fired by Blizzard's Equipment Manager, we use it to update our icons\n    if wasClicked and talentGroup == aura_env.TALENT_GROUP then\n        SetActiveTalentGroup(aura_env.TALENT_GROUP)\n        return GetActiveTalentGroup() ~= aura_env.TALENT_GROUP --show 5s glow only when swap talents\n    end\n    return false\nend\n\n\n",
						["spellIds"] = {
						},
						["customIcon"] = "function(e)\n    local equipmentSet = aura_env.config[\"equipmentSetName\"]\n    if equipmentSet ~= \"\" then\n        if aura_env.config[\"equipmentManager\"] == 2 then\n            if ItemRack and ItemRackUser.Sets[equipmentSet] then --ItemRack is installed, ItemRack equipment set exists\n                return ItemRackUser.Sets[equipmentSet].icon\n            else\n                return 134400 --Inv_misc_questionmark, ItemRack equipment set doesn't exist\n            end\n        elseif aura_env.config[\"equipmentManager\"] == 1 then\n            local equipmentSetID = C_EquipmentSet.GetEquipmentSetID(equipmentSet)\n            if equipmentSetID then\n                return select(2, C_EquipmentSet.GetEquipmentSetInfo(equipmentSetID))\n            else\n                return 134400 --Inv_misc_questionmark, Blizzard's equipment set doesn't exist\n            end\n        else\n            return 237091 --Inv_inscription_majorglyph01, unknown config option\n        end\n    end\n    return select(2, GetTalentTabInfo(aura_env.TALENT_GROUP)) --not using an equipment set, use the talent tab's icon\nend",
						["events"] = "WA_TALENT_EQUIP_SWAP EQUIPMENT_SETS_CHANGED",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
						["custom"] = "",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "custom",
						["events"] = "ACTIVE_TALENT_GROUP_CHANGED",
						["custom_type"] = "status",
						["check"] = "event",
						["debuffType"] = "HELPFUL",
						["custom"] = "function(e, curr, prev)\n    \n    if curr == aura_env.TALENT_GROUP then\n        \n        local equipmentSetName = aura_env.config[\"equipmentSetName\"]\n        \n        if aura_env.config[\"equipmentManager\"] == 2 then\n            if ItemRack then --ItemRack is installed\n                --ItemRack.EquipSet(aura_env.config[\"equipmentSetName\"]) --there's a race condition preventing this from working, so we add a 0.1 second delay to fix it\n                C_Timer.After(0.1, function() ItemRack.EquipSet(equipmentSetName) end)\n            else\n                print(\"[WA][\"..aura_env.id..\"] Configured to use ItemRack, but ItemRack is not installed.\")\n            end\n        elseif aura_env.config[\"equipmentManager\"] == 1 then\n            local equipmentSetID = C_EquipmentSet.GetEquipmentSetID(equipmentSetName)\n            if equipmentSetID then\n                C_EquipmentSet.UseEquipmentSet(equipmentSetID)\n            else\n                print(\"[WA][\"..aura_env.id..\"] Equipment Manager set \\\"\"..equipmentSetName..\"\\\" does not exist.\")\n            end\n        else\n            print(\"[WA][\"..aura_env.id..\"] ERROR Unknown Equipment Manger config: \"..aura_env.getEquipmentManager())\n        end\n    end\n    \n    return GetActiveTalentGroup() == aura_env.TALENT_GROUP\nend",
						["unit"] = "player",
					},
					["untrigger"] = {
						["custom"] = "function(e, curr, prev)\n    return true\nend",
					},
				}, -- [2]
				{
					["trigger"] = {
						["type"] = "custom",
						["custom_type"] = "status",
						["event"] = "Unit Characteristics",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
						["events"] = "PLAYER_ENTERING_WORLD",
						["unit"] = "player",
						["check"] = "event",
						["talent"] = {
						},
						["custom"] = "function()\n    local dualSpecLearned = GetNumTalentGroups() >= 2\n    return dualSpecLearned\nend",
						["custom_hide"] = "custom",
					},
					["untrigger"] = {
						["custom"] = "",
					},
				}, -- [3]
				["disjunctive"] = "custom",
				["customTriggerLogic"] = "function(t)\n    return t[3] --Dual spec has been learned\nend",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 2,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_shadowXOffset"] = 0,
					["text_text"] = "secondary",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_p_time_legacy_floor"] = false,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_format"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["type"] = "subtext",
					["text_text_format_p_time_precision"] = 1,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = 0,
					["text_anchorYOffset"] = 0,
					["anchorYOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "INNER_TOP",
					["text_fontType"] = "OUTLINE",
					["text_text_format_p_format"] = "timed",
					["text_fontSize"] = 8,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
				}, -- [2]
				{
					["text_shadowXOffset"] = 0,
					["text_text"] = "%c",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_p_time_legacy_floor"] = false,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["anchorYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["type"] = "subtext",
					["text_text_format_p_time_mod_rate"] = true,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOM",
					["text_fontType"] = "OUTLINE",
					["text_text_format_p_time_format"] = 0,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_c_format"] = "none",
				}, -- [3]
				{
					["border_size"] = 14,
					["type"] = "subborder",
					["border_color"] = {
						0.28627450980392, -- [1]
						1, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["border_visible"] = true,
					["border_edge"] = "Blizzard Tooltip",
					["border_offset"] = 0,
				}, -- [4]
				{
					["glowFrequency"] = 0.25,
					["type"] = "subglow",
					["glowDuration"] = 1,
					["glowType"] = "ACShine",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["useGlowColor"] = false,
					["glowXOffset"] = 0,
					["glowScale"] = 1,
					["glowThickness"] = 1,
					["glow"] = false,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [5]
			},
			["height"] = 48,
			["load"] = {
				["use_namerealm"] = true,
				["use_group_leader"] = false,
				["namerealm"] = "Zyein-Mankrik",
				["talent"] = {
					["multi"] = {
					},
				},
				["itemtypeequipped"] = {
				},
				["class"] = {
					["single"] = "DEATHKNIGHT",
					["multi"] = {
						["DEATHKNIGHT"] = true,
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["raid_role"] = {
				},
				["use_class"] = true,
				["role"] = {
					["single"] = "DAMAGER",
					["multi"] = {
					},
				},
				["use_itemequiped"] = false,
				["level_operator"] = {
					">=", -- [1]
				},
				["use_level"] = true,
				["level"] = {
					"40", -- [1]
				},
				["use_item_bonusid_equipped"] = false,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["source"] = "import",
			["config"] = {
				["equipmentSetName"] = "Frost",
				["talentGroup"] = 2,
				["equipmentManager"] = 2,
			},
			["xOffset"] = 0,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["icon"] = true,
			["cooldown"] = false,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "show",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "sub.5.glow",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 2,
						["variable"] = "show",
						["value"] = 0,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
						{
							["value"] = {
								0.67450980392157, -- [1]
								0.67450980392157, -- [2]
								0.67450980392157, -- [3]
								1, -- [4]
							},
							["property"] = "color",
						}, -- [2]
						{
							["property"] = "sub.4.border_visible",
						}, -- [3]
					},
				}, -- [2]
			},
			["cooldownEdge"] = false,
			["cooldownTextDisabled"] = false,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0,
			["semver"] = "1.0.1",
			["tocversion"] = 30400,
			["id"] = "Zyein Death Knight - Secondary Talents - \"Frost\"",
			["frameStrata"] = 1,
			["useCooldownModRate"] = true,
			["width"] = 48,
			["alpha"] = 1,
			["uid"] = "3zJUqOR97Lf",
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["displayIcon"] = "",
			["information"] = {
				["forceEvents"] = true,
			},
			["authorOptions"] = {
				{
					["width"] = 1,
					["type"] = "select",
					["values"] = {
						"Primary Talents", -- [1]
						"Secondary Talents", -- [2]
					},
					["name"] = "Talent Group",
					["useDesc"] = true,
					["key"] = "talentGroup",
					["default"] = 2,
					["desc"] = "Which talent spec should activate when clicked? Requires a /reload after changing this.",
				}, -- [1]
				{
					["type"] = "space",
					["variableWidth"] = true,
					["height"] = 1,
					["useHeight"] = false,
					["width"] = 1,
				}, -- [2]
				{
					["width"] = 1,
					["type"] = "select",
					["values"] = {
						"[Feature] Equipment Manager", -- [1]
						"[AddOn] ItemRack", -- [2]
					},
					["name"] = "Equipment Manager",
					["useDesc"] = true,
					["key"] = "equipmentManager",
					["default"] = 1,
					["desc"] = "Which equipment manager to pull data from.",
				}, -- [3]
				{
					["type"] = "input",
					["useDesc"] = true,
					["width"] = 1,
					["default"] = "",
					["name"] = "Equipment set name",
					["multiline"] = false,
					["key"] = "equipmentSetName",
					["length"] = 10,
					["desc"] = "Which equipment set should be equipped when clicked? Leave empty to not equip a set.",
					["useLength"] = false,
				}, -- [4]
			},
		},
		["Power Word: Shield"] = {
			["iconSource"] = -1,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = true,
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
						["auraspellids"] = {
							"80240", -- [1]
						},
						["useExactSpellId"] = false,
						["useMatch_count"] = false,
						["match_countOperator"] = ">",
						["event"] = "Health",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["names"] = {
						},
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["match_count"] = "0",
						["useName"] = true,
						["auranames"] = {
							"Power Word: Shield", -- [1]
						},
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "spell",
						["subeventSuffix"] = "_CAST_START",
						["unevent"] = "auto",
						["use_genericShowOn"] = true,
						["duration"] = "1",
						["event"] = "Cooldown Progress (Spell)",
						["use_unit"] = true,
						["realSpellName"] = 34477,
						["use_spellName"] = true,
						["subeventPrefix"] = "SPELL",
						["use_absorbMode"] = true,
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["use_track"] = true,
						["spellName"] = 34477,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_shadowXOffset"] = 1,
					["text_text_format_s_format"] = "none",
					["text_text_format_2.p_time_mod_rate"] = true,
					["text_text_format_2.p_time_format"] = 0,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_text_format_2.p_time_legacy_floor"] = true,
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_2.p_format"] = "timed",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Arial Narrow",
					["text_automaticWidth"] = "Auto",
					["text_shadowYOffset"] = -1,
					["text_text_format_2.p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "CENTER",
					["text_visible"] = false,
					["text_text_format_2.p_time_precision"] = 1,
					["text_fontSize"] = 24,
					["anchorXOffset"] = 0,
					["text_text"] = "%2.p",
				}, -- [2]
				{
					["text_shadowXOffset"] = 0,
					["text_text_format_1.p_time_legacy_floor"] = true,
					["text_text_format_p_format"] = "timed",
					["text_text"] = "%1.p",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_1.p_time_format"] = 0,
					["anchorYOffset"] = 0,
					["text_text_format_1.p_time_mod_rate"] = true,
					["rotateText"] = "NONE",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_p_time_precision"] = 1,
					["text_text_format_1.p_time_precision"] = 1,
					["type"] = "subtext",
					["text_fontType"] = "OUTLINE",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Arial Narrow",
					["text_text_format_1.p_format"] = "timed",
					["text_shadowYOffset"] = 0,
					["text_text_format_1.p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_time_format"] = 0,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_justify"] = "CENTER",
				}, -- [3]
				{
					["glowFrequency"] = 0.25,
					["glow"] = true,
					["useGlowColor"] = true,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						0.1058823615312576, -- [1]
						1, -- [2]
						0.294117659330368, -- [3]
						1, -- [4]
					},
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["glowDuration"] = 1,
					["glowScale"] = 1,
					["glowThickness"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [4]
			},
			["height"] = 40,
			["load"] = {
				["use_class"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "PRIEST",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["source"] = "import",
			["cooldownTextDisabled"] = true,
			["authorOptions"] = {
			},
			["parent"] = "Vermin Priest",
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["regionType"] = "icon",
			["displayIcon"] = "",
			["icon"] = true,
			["selfPoint"] = "CENTER",
			["config"] = {
			},
			["anchorFrameParent"] = false,
			["width"] = 40,
			["alpha"] = 1,
			["zoom"] = 0,
			["auto"] = true,
			["tocversion"] = 80300,
			["id"] = "Power Word: Shield",
			["useCooldownModRate"] = true,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["semver"] = "1.0.0",
			["uid"] = "q9q)gYG82mF",
			["inverse"] = true,
			["url"] = "https://wago.io/E9AeMcIo0/1",
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = -2,
						["variable"] = "AND",
						["checks"] = {
							{
								["trigger"] = 2,
								["variable"] = "onCooldown",
								["value"] = 1,
							}, -- [1]
							{
								["trigger"] = 1,
								["variable"] = "show",
								["value"] = 1,
							}, -- [2]
						},
					},
					["changes"] = {
						{
							["property"] = "desaturate",
						}, -- [1]
						{
							["value"] = {
								["custom"] = "local reg = WeakAuras.GetRegion(aura_env.id)\n\nreg.glowicon = reg.glowicon or CreateFrame(\"Button\", aura_env.id..\"Glower\" )\nreg.glowicon:SetSize( reg.icon:GetWidth() - 2, reg.icon:GetHeight() - 2)\nreg.glowicon:SetPoint( \"CENTER\", reg.icon, \"CENTER\" )\nActionButton_ShowOverlayGlow( reg.glowicon )",
							},
							["property"] = "customcode",
						}, -- [2]
						{
							["property"] = "inverse",
						}, -- [3]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "show",
						["value"] = 0,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "sub.2.text_visible",
						}, -- [1]
						{
							["property"] = "sub.3.text_visible",
						}, -- [2]
						{
							["value"] = {
								["custom"] = "local reg = WeakAuras.GetRegion(aura_env.id)\n\nreg.glowicon = reg.glowicon or CreateFrame(\"Button\", aura_env.id..\"Glower\" )\nreg.glowicon:SetSize( reg.icon:GetWidth() - 1, reg.icon:GetHeight() - 1)\nreg.glowicon:SetPoint( \"CENTER\", reg.icon, \"CENTER\" )\nActionButton_HideOverlayGlow( reg.glowicon )",
							},
							["property"] = "customcode",
						}, -- [3]
					},
				}, -- [2]
				{
					["check"] = {
						["trigger"] = -2,
						["variable"] = "AND",
						["checks"] = {
							{
								["trigger"] = 2,
								["variable"] = "onCooldown",
								["value"] = 1,
							}, -- [1]
							{
								["trigger"] = 1,
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
					},
				}, -- [3]
			},
			["cooldown"] = false,
			["xOffset"] = 0,
		},
		["Holy Shield"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["wagoID"] = "v9qxdDgI4",
			["parent"] = "Vermin Paladin",
			["preferToUpdate"] = false,
			["sparkHeight"] = 30,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["sparkOffsetX"] = 0,
			["cooldownSwipe"] = true,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Holy Shield", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showOnReady",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
						["useName"] = true,
						["unevent"] = "auto",
						["subeventSuffix"] = "_CAST_START",
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["event"] = "Action Usable",
						["spellName"] = 34428,
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_genericShowOn"] = true,
						["type"] = "aura2",
						["unit"] = "player",
						["use_track"] = true,
						["useIgnoreName"] = false,
					},
					["untrigger"] = {
						["genericShowOn"] = "showOnReady",
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
			["useTooltip"] = false,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["authorOptions"] = {
			},
			["xOffset"] = 0,
			["barColor"] = {
				0.2, -- [1]
				1, -- [2]
				0.0862745098039216, -- [3]
				1, -- [4]
			},
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["internalVersion"] = 70,
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.75,
					["type"] = "subglow",
					["useGlowColor"] = true,
					["text_color"] = {
					},
					["glowThickness"] = 2,
					["glowDuration"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0.85098039215686, -- [2]
						0.1843137254902, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 16,
					["glow"] = true,
					["glowScale"] = 1,
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_p_time_precision"] = 1,
					["text_text"] = "%p",
					["text_text_format_p_time_mod_rate"] = true,
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_format"] = "timed",
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_shadowXOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
				}, -- [3]
				{
					["text_shadowXOffset"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_legacy_floor"] = false,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["type"] = "subtext",
					["text_text_format_p_time_precision"] = 1,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_anchorYOffset"] = 25,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_visible"] = true,
					["text_text_format_p_time_format"] = 0,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_p_format"] = "timed",
				}, -- [4]
			},
			["height"] = 40,
			["selfPoint"] = "CENTER",
			["load"] = {
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["use_class"] = true,
				["zoneIds"] = "",
				["level_operator"] = {
					">=", -- [1]
				},
				["use_level"] = false,
				["level"] = {
					"60", -- [1]
				},
				["class"] = {
					["single"] = "PALADIN",
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
			["uid"] = "PTD5D1uPbgk",
			["cooldown"] = false,
			["desaturate"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["displayIcon"] = "",
			["smoothProgress"] = true,
			["anchorFrameFrame"] = "PlayerFrame",
			["regionType"] = "icon",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["config"] = {
			},
			["icon_side"] = "RIGHT",
			["useAdjustededMin"] = false,
			["sparkHidden"] = "NEVER",
			["anchorFrameParent"] = false,
			["texture"] = "Melli",
			["width"] = 40,
			["zoom"] = 0.3,
			["auto"] = false,
			["useCooldownModRate"] = true,
			["id"] = "Holy Shield",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["spark"] = false,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["inverse"] = false,
			["alpha"] = 1,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["cooldownTextDisabled"] = false,
		},
		["Skills"] = {
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["controlledChildren"] = {
				"Heroic Strike", -- [1]
				"Cleave", -- [2]
				"Maul", -- [3]
				"Raptor Strike", -- [4]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["parent"] = "SwingTimer - Queue skills",
			["information"] = {
				["forceEvents"] = true,
			},
			["border"] = false,
			["yOffset"] = -70,
			["anchorPoint"] = "CENTER",
			["borderSize"] = 2,
			["borderEdge"] = "Square Full White",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
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
						["debuffType"] = "HELPFUL",
						["type"] = "aura2",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["event"] = "Health",
						["names"] = {
						},
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["scale"] = 0.7,
			["internalVersion"] = 70,
			["borderOffset"] = 4,
			["selfPoint"] = "CENTER",
			["id"] = "Skills",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["config"] = {
			},
			["borderInset"] = 1,
			["uid"] = "dBGlw5laZUE",
			["xOffset"] = 0,
			["conditions"] = {
			},
			["load"] = {
				["size"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["multi"] = {
					},
				},
			},
			["regionType"] = "group",
		},
		["targetdebuffs  2"] = {
			["iconSource"] = -1,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["customText"] = "",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/W1QyYtaAz/1",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["showClones"] = true,
						["type"] = "aura2",
						["subeventSuffix"] = "_CAST_START",
						["useIgnoreExactSpellId"] = false,
						["fetchTooltip"] = true,
						["event"] = "Health",
						["unit"] = "pet",
						["useIgnoreName"] = false,
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["names"] = {
						},
						["ignoreAuraSpellids"] = {
							"206151", -- [1]
						},
						["ignoreAuraNames"] = {
							"", -- [1]
						},
						["debuffType"] = "HARMFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "any",
				["customTriggerLogic"] = "print(name)",
				["activeTriggerMode"] = -10,
			},
			["useTooltip"] = true,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_shadowXOffset"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_anchorXOffset"] = 14,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "OUTER_TOP",
					["text_anchorYOffset"] = -38,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_fontType"] = "OUTLINE",
				}, -- [2]
				{
					["text_shadowXOffset"] = 0,
					["text_text"] = "%p",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_mod_rate"] = true,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [3]
				{
					["text_shadowXOffset"] = 0,
					["text_text"] = "%c",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_text_format_c_format"] = "none",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_shadowYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_time_format"] = 0,
					["text_text_format_p_format"] = "timed",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_precision"] = 1,
				}, -- [4]
				{
					["glowFrequency"] = 0.25,
					["glow"] = true,
					["useGlowColor"] = false,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowDuration"] = 1,
					["type"] = "subglow",
					["glowThickness"] = 1,
					["glowScale"] = 1,
					["glowXOffset"] = 0,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [5]
			},
			["height"] = 36,
			["load"] = {
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
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
			["cooldownTextDisabled"] = true,
			["internalVersion"] = 70,
			["parent"] = "DEBUFFS - PET",
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["regionType"] = "icon",
			["xOffset"] = 0,
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
				},
			},
			["config"] = {
			},
			["anchorFrameParent"] = false,
			["width"] = 36,
			["frameStrata"] = 1,
			["zoom"] = 0.3,
			["auto"] = true,
			["tocversion"] = 90001,
			["id"] = "targetdebuffs  2",
			["semver"] = "1.0.0",
			["useCooldownModRate"] = true,
			["anchorFrameType"] = "SCREEN",
			["alpha"] = 1,
			["uid"] = "DMEkSzl4NuN",
			["inverse"] = false,
			["cooldownEdge"] = false,
			["conditions"] = {
			},
			["cooldown"] = false,
			["selfPoint"] = "CENTER",
		},
		["Loss of Control Background"] = {
			["wagoID"] = "JiQILDF99",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["url"] = "https://wago.io/JiQILDF99/1",
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
						["type"] = "custom",
						["custom_type"] = "event",
						["custom_hide"] = "custom",
						["event"] = "Health",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["events"] = "LOSS_OF_CONTROL_UPDATE",
						["names"] = {
						},
						["check"] = "event",
						["spellIds"] = {
						},
						["custom"] = "function (allstates, event, ...)\n    local activeLossOfControlCount = C_LossOfControl.GetActiveLossOfControlDataCount()\n    if activeLossOfControlCount > 0 then return true end\n    return false\nend",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
						["custom"] = "function (allstates, event, ...)\n    local activeLossOfControlCount = C_LossOfControl.GetActiveLossOfControlDataCount()\n    if activeLossOfControlCount <= 0 then return true end\n    return false\nend",
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["colorR"] = 1,
					["duration"] = "0.2",
					["alphaType"] = "straight",
					["colorA"] = 1,
					["colorG"] = 1,
					["alphaFunc"] = "function(progress, start, delta)\n    return start + (progress * delta)\nend\n",
					["use_alpha"] = true,
					["type"] = "custom",
					["easeType"] = "none",
					["scaley"] = 1,
					["alpha"] = 0,
					["y"] = 0,
					["x"] = 0,
					["scalex"] = 1,
					["preset"] = "fade",
					["easeStrength"] = 3,
					["rotate"] = 0,
					["colorB"] = 1,
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["colorR"] = 1,
					["duration"] = "0.2",
					["alphaType"] = "straight",
					["colorA"] = 1,
					["colorG"] = 1,
					["alphaFunc"] = "function(progress, start, delta)\n    return start + (progress * delta)\nend\n",
					["use_alpha"] = true,
					["type"] = "custom",
					["easeType"] = "none",
					["scaley"] = 1,
					["alpha"] = 0,
					["y"] = 0,
					["x"] = 0,
					["scalex"] = 1,
					["preset"] = "fade",
					["easeStrength"] = 3,
					["rotate"] = 0,
					["colorB"] = 1,
					["duration_type"] = "seconds",
				},
			},
			["desaturate"] = true,
			["rotation"] = 180,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 54,
			["rotate"] = false,
			["load"] = {
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
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
			["textureWrapMode"] = "CLAMPTOBLACKADDITIVE",
			["source"] = "import",
			["mirror"] = false,
			["regionType"] = "texture",
			["blendMode"] = "BLEND",
			["color"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["discrete_rotation"] = 180,
			["texture"] = "Interface\\Cooldown\\LoC-ShadowBG",
			["xOffset"] = 0,
			["displayIcon"] = 136071,
			["semver"] = "1.0.0",
			["tocversion"] = 30400,
			["id"] = "Loss of Control Background",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["width"] = 200,
			["config"] = {
			},
			["uid"] = "54vuWPE(kBZ",
			["parent"] = "Loss of Control Alert (WOTLK)",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["selfPoint"] = "CENTER",
		},
		["Savage Roar"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["wagoID"] = "v9qxdDgI4",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["anchorFrameParent"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["sparkOffsetX"] = 0,
			["cooldownSwipe"] = true,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["cooldownEdge"] = false,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Savage Roar", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showOnReady",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "aura2",
						["unevent"] = "auto",
						["subeventSuffix"] = "_CAST_START",
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["event"] = "Action Usable",
						["useName"] = true,
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_genericShowOn"] = true,
						["spellName"] = 34428,
						["use_unit"] = true,
						["use_track"] = true,
						["useIgnoreName"] = false,
					},
					["untrigger"] = {
						["genericShowOn"] = "showOnReady",
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
			["useTooltip"] = false,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["parent"] = "Vermin Druid",
			["authorOptions"] = {
			},
			["barColor"] = {
				0.2, -- [1]
				1, -- [2]
				0.0862745098039216, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["internalVersion"] = 70,
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.5,
					["type"] = "subglow",
					["glowDuration"] = 1,
					["text_color"] = {
					},
					["glowThickness"] = 3,
					["useGlowColor"] = true,
					["glowYOffset"] = 0,
					["glowColor"] = {
						0, -- [1]
						1, -- [2]
						0.08627451211214066, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["glowScale"] = 1,
					["glow"] = true,
					["glowLength"] = 16,
					["glowType"] = "buttonOverlay",
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "%p",
					["text_text_format_p_time_mod_rate"] = true,
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_format"] = "timed",
					["type"] = "subtext",
					["anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "OUTER_TOP",
					["text_shadowXOffset"] = 0,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 10,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
				}, -- [3]
			},
			["height"] = 36,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["load"] = {
				["use_level"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["use_class"] = true,
				["use_spellknown"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["use_never"] = false,
				["level"] = {
					"5", -- [1]
				},
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["icon"] = true,
			["conditions"] = {
			},
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "icon",
			["useCooldownModRate"] = true,
			["config"] = {
			},
			["icon_side"] = "RIGHT",
			["anchorFrameFrame"] = "PlayerFrame",
			["zoom"] = 0,
			["sparkHeight"] = 30,
			["texture"] = "Melli",
			["width"] = 36,
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["spark"] = false,
			["frameStrata"] = 1,
			["sparkHidden"] = "NEVER",
			["id"] = "Savage Roar",
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = false,
			["uid"] = "gYbNE)w3Hbw",
			["inverse"] = false,
			["auto"] = false,
			["orientation"] = "HORIZONTAL",
			["displayIcon"] = "",
			["cooldown"] = false,
			["xOffset"] = 0,
		},
		["VictoryRush"] = {
			["controlledChildren"] = {
				"VrIcon", -- [1]
				"Timer", -- [2]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["wagoID"] = "v9qxdDgI4",
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = 350,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["url"] = "https://wago.io/v9qxdDgI4/2",
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
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["event"] = "Health",
						["names"] = {
						},
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["version"] = 2,
			["subRegions"] = {
			},
			["load"] = {
				["talent"] = {
					["multi"] = {
					},
				},
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
			["source"] = "import",
			["scale"] = 1,
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "group",
			["borderSize"] = 2,
			["borderOffset"] = 4,
			["semver"] = "1.0.1",
			["tocversion"] = 20501,
			["id"] = "VictoryRush",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["authorOptions"] = {
			},
			["borderInset"] = 1,
			["config"] = {
			},
			["selfPoint"] = "CENTER",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["uid"] = "0EznwWi8AYW",
		},
		["Mana 5SecondRule + Ticks"] = {
			["sparkWidth"] = 10,
			["sparkOffsetX"] = 0,
			["anchorFrameType"] = "SCREEN",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["borderBackdrop"] = "Blizzard Tooltip",
			["yOffset"] = -143,
			["anchorPoint"] = "CENTER",
			["iconSource"] = -1,
			["xOffset"] = 1,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["url"] = "https://wago.io/8jnpoLFyU/1",
			["icon"] = false,
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "2",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "custom",
						["use_unit"] = true,
						["custom_type"] = "stateupdate",
						["subeventSuffix"] = "_ENERGIZE",
						["names"] = {
						},
						["event"] = "Health",
						["unevent"] = "auto",
						["spellIds"] = {
						},
						["events"] = "UNIT_SPELLCAST_SUCCEEDED:player UNIT_POWER_FREQUENT:player",
						["custom"] = "function(a, e, t)\n    local currentMana = UnitPower(\"player\" , 0)\n    \n    if currentMana >= UnitPowerMax(\"player\", 0) then\n        return false\n    end\n    \n    if e == \"UNIT_POWER_FREQUENT\" and currentMana > aura_env.lastMana then\n        local duration = 2\n        a[\"\"] = {\n            show = true,\n            changed = true,\n            duration = duration,\n            expirationTime = GetTime() + duration,\n            progressType = \"timed\",\n            autoHide = true\n        }\n        aura_env.lastMana = currentMana\n        \n    elseif e == \"UNIT_SPELLCAST_SUCCEEDED\" and currentMana < aura_env.lastMana then\n        local duration = 6.45 -- why?\n        --local duration = 5\n        a[\"\"] = {\n            show = true,\n            changed = true,\n            duration = duration,\n            expirationTime = GetTime() + duration,\n            progressType = \"timed\",\n            autoHide = true\n        }\n        aura_env.lastMana = currentMana\n    end\n    \n    --aura_env.lastMana = currentMana\n    return true\nend",
						["use_sourceUnit"] = true,
						["check"] = "event",
						["subeventPrefix"] = "SPELL",
						["sourceUnit"] = "player",
						["customVariables"] = "{\n    duration = true\n}",
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
			["enableGradient"] = false,
			["alpha"] = 1,
			["selfPoint"] = "CENTER",
			["backdropInFront"] = false,
			["color"] = {
			},
			["barColor"] = {
				0, -- [1]
				0.23529411764706, -- [2]
				1, -- [3]
				0, -- [4]
			},
			["desaturate"] = false,
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["backgroundColor"] = {
				0, -- [1]
				0.22352941176471, -- [2]
				1, -- [3]
				0, -- [4]
			},
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subforeground",
				}, -- [2]
				{
					["text_shadowXOffset"] = 1,
					["text_text"] = "%p",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_legacy_floor"] = true,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_p_time_format"] = 0,
					["type"] = "subtext",
					["text_anchorXOffset"] = 15,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Accidental Presidency",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = -1,
					["text_visible"] = false,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "SPARK",
					["text_text_format_p_format"] = "timed",
					["text_anchorYOffset"] = -10,
					["text_fontSize"] = 20,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
				}, -- [3]
				{
					["border_size"] = 16,
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
					["border_offset"] = 5,
				}, -- [4]
			},
			["gradientOrientation"] = "HORIZONTAL",
			["internalVersion"] = 70,
			["load"] = {
				["use_class"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class"] = {
					["single"] = "ROGUE",
					["multi"] = {
						["HUNTER"] = true,
						["WARLOCK"] = true,
						["SHAMAN"] = true,
						["MAGE"] = true,
						["DRUID"] = true,
						["PALADIN"] = true,
						["PRIEST"] = true,
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
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
			},
			["source"] = "import",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
					["custom"] = "WeakAuras.ScanEvents(\"TICKUPDATE\", true)",
					["do_custom"] = false,
				},
				["init"] = {
					["custom"] = "aura_env.lastMana = UnitPower(\"player\" , 0)",
					["do_custom"] = true,
				},
			},
			["stickyDuration"] = false,
			["spark"] = true,
			["smoothProgress"] = false,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["borderInFront"] = true,
			["version"] = 1,
			["icon_side"] = "RIGHT",
			["height"] = 6,
			["useAdjustededMax"] = false,
			["sparkHeight"] = 30,
			["texture"] = "xVerminClean",
			["config"] = {
			},
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["auto"] = true,
			["tocversion"] = 11302,
			["id"] = "Mana 5SecondRule + Ticks",
			["zoom"] = 0,
			["frameStrata"] = 4,
			["width"] = 185,
			["semver"] = "1.0.0",
			["uid"] = "dvZawXAyrxC",
			["inverse"] = false,
			["sparkHidden"] = "NEVER",
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "<",
						["value"] = "5",
						["variable"] = "duration",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "inverse",
						}, -- [1]
					},
				}, -- [1]
			},
			["barColor2"] = {
				1, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Overpower"] = {
			["outline"] = "OUTLINE",
			["iconSource"] = 0,
			["authorOptions"] = {
			},
			["displayText"] = "Overpower\n\n",
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
						["duration"] = "3",
						["use_unit"] = true,
						["use_missType"] = true,
						["debuffType"] = "HELPFUL",
						["use_sourceName"] = false,
						["subeventSuffix"] = "_MISSED",
						["buffShowOn"] = "showOnActive",
						["event"] = "Combat Log",
						["missType"] = "DODGE",
						["unit"] = "player",
						["names"] = {
						},
						["spellIds"] = {
						},
						["use_sourceUnit"] = true,
						["unevent"] = "timed",
						["type"] = "combatlog",
						["sourceUnit"] = "player",
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["duration"] = "3",
						["use_unit"] = true,
						["use_missType"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["missType"] = "DODGE",
						["unevent"] = "timed",
						["event"] = "Combat Log",
						["subeventPrefix"] = "SWING",
						["names"] = {
						},
						["subeventSuffix"] = "_MISSED",
						["spellIds"] = {
						},
						["use_sourceUnit"] = true,
						["unit"] = "player",
						["use_sourceName"] = false,
						["sourceUnit"] = "player",
						["buffShowOn"] = "showOnActive",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = false,
			["wordWrap"] = "WordWrap",
			["desaturate"] = false,
			["justify"] = "LEFT",
			["font"] = "Friz Quadrata TT",
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.25,
					["type"] = "subglow",
					["glowDuration"] = 1,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["useGlowColor"] = false,
					["glow"] = true,
					["glowScale"] = 1,
					["glowThickness"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [2]
			},
			["height"] = 36,
			["automaticWidth"] = "Auto",
			["load"] = {
				["use_class"] = false,
				["use_never"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class"] = {
					["multi"] = {
						["WARRIOR"] = true,
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
			["preferToUpdate"] = false,
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["fontSize"] = 24,
			["source"] = "import",
			["conditions"] = {
				{
					["check"] = {
						["value"] = 1,
						["variable"] = "onCooldown",
					},
					["changes"] = {
						{
							["value"] = 0,
							["property"] = "alpha",
						}, -- [1]
					},
				}, -- [1]
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
			},
			["config"] = {
			},
			["url"] = "https://wago.io/8jodVwYqI/1",
			["regionType"] = "icon",
			["width"] = 36,
			["alpha"] = 1,
			["selfPoint"] = "BOTTOM",
			["parent"] = "Vermin Warrior",
			["anchorFrameParent"] = false,
			["auto"] = false,
			["zoom"] = 0.25,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.0.0",
			["tocversion"] = 11302,
			["id"] = "Overpower",
			["xOffset"] = 0,
			["useCooldownModRate"] = true,
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 1,
			["uid"] = "nknfjEhjMr2",
			["inverse"] = false,
			["displayIcon"] = 132223,
			["fixedWidth"] = 200,
			["cooldown"] = false,
			["icon"] = true,
		},
		["Divine Protection"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["wagoID"] = "v9qxdDgI4",
			["parent"] = "Vermin Paladin",
			["preferToUpdate"] = false,
			["sparkHeight"] = 30,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["sparkOffsetX"] = 0,
			["cooldownSwipe"] = true,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["cooldownEdge"] = false,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Divine Protection", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showOnReady",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "aura2",
						["subeventPrefix"] = "SPELL",
						["unevent"] = "auto",
						["use_unit"] = true,
						["names"] = {
						},
						["event"] = "Action Usable",
						["spellName"] = 34428,
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_genericShowOn"] = true,
						["useName"] = true,
						["subeventSuffix"] = "_CAST_START",
						["use_track"] = true,
						["useIgnoreName"] = false,
					},
					["untrigger"] = {
						["genericShowOn"] = "showOnReady",
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
			["useTooltip"] = false,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["barColor"] = {
				0.2, -- [1]
				1, -- [2]
				0.0862745098039216, -- [3]
				1, -- [4]
			},
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["icon"] = true,
			["internalVersion"] = 70,
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.75,
					["type"] = "subglow",
					["useGlowColor"] = true,
					["text_color"] = {
					},
					["glowThickness"] = 2,
					["glowDuration"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0.85098039215686, -- [2]
						0.1843137254902, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 16,
					["glow"] = true,
					["glowScale"] = 1,
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_p_time_precision"] = 1,
					["text_text"] = "%p",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_mod_rate"] = true,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_shadowXOffset"] = 0,
					["text_visible"] = true,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_p_format"] = "timed",
				}, -- [3]
				{
					["text_shadowXOffset"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_p_time_legacy_floor"] = false,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["anchorYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["type"] = "subtext",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = 0,
					["text_anchorYOffset"] = 25,
					["text_text_format_p_time_mod_rate"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_fontType"] = "OUTLINE",
					["text_text_format_p_time_format"] = 0,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_precision"] = 1,
				}, -- [4]
			},
			["height"] = 40,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["load"] = {
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "PALADIN",
					["multi"] = {
					},
				},
				["use_class"] = true,
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["use_level"] = false,
				["level"] = {
					"60", -- [1]
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["config"] = {
			},
			["cooldown"] = false,
			["desaturate"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["displayIcon"] = "",
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "icon",
			["xOffset"] = 0,
			["uid"] = "91mA2IkcG5o",
			["icon_side"] = "RIGHT",
			["anchorFrameFrame"] = "PlayerFrame",
			["id"] = "Divine Protection",
			["anchorFrameParent"] = false,
			["texture"] = "Melli",
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["auto"] = false,
			["alpha"] = 1,
			["sparkHidden"] = "NEVER",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["frameStrata"] = 1,
			["width"] = 40,
			["spark"] = false,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["inverse"] = false,
			["useCooldownModRate"] = true,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["cooldownTextDisabled"] = false,
		},
		["Omen of Clarity"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["wagoID"] = "v9qxdDgI4",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["id"] = "Omen of Clarity",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["sparkOffsetX"] = 0,
			["cooldownSwipe"] = true,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["cooldownEdge"] = false,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Omen of Clarity", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showOnReady",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
						["names"] = {
						},
						["useName"] = true,
						["unevent"] = "auto",
						["subeventSuffix"] = "_CAST_START",
						["matchesShowOn"] = "showOnMissing",
						["unit"] = "player",
						["event"] = "Action Usable",
						["type"] = "aura2",
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_genericShowOn"] = true,
						["spellName"] = 34428,
						["subeventPrefix"] = "SPELL",
						["use_track"] = true,
						["useIgnoreName"] = false,
					},
					["untrigger"] = {
						["genericShowOn"] = "showOnReady",
					},
				}, -- [1]
				{
					["trigger"] = {
						["useRem"] = true,
						["type"] = "aura2",
						["rem"] = "30",
						["auranames"] = {
							"Omen of Clarity", -- [1]
						},
						["remOperator"] = "<=",
						["useName"] = true,
						["debuffType"] = "HELPFUL",
						["unit"] = "player",
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
			["useTooltip"] = false,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["xOffset"] = 0,
			["parent"] = "Vermin Druid",
			["barColor"] = {
				0.2, -- [1]
				1, -- [2]
				0.0862745098039216, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["icon"] = true,
			["internalVersion"] = 70,
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.5,
					["type"] = "subglow",
					["glowDuration"] = 1,
					["text_color"] = {
					},
					["glowThickness"] = 2,
					["useGlowColor"] = true,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0.5215686559677124, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["glowScale"] = 1,
					["glow"] = true,
					["glowLength"] = 16,
					["glowType"] = "buttonOverlay",
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "%p",
					["text_text_format_p_time_mod_rate"] = true,
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_format"] = "timed",
					["type"] = "subtext",
					["anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "OUTER_TOP",
					["text_shadowXOffset"] = 0,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 10,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
				}, -- [3]
			},
			["height"] = 36,
			["selfPoint"] = "CENTER",
			["load"] = {
				["use_never"] = false,
				["talent"] = {
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
				["use_class"] = true,
				["use_spellknown"] = true,
				["level_operator"] = {
					">=", -- [1]
				},
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
					},
				},
				["use_level"] = false,
				["level"] = {
					"5", -- [1]
				},
				["spellknown"] = 16864,
				["zoneIds"] = "",
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["useCooldownModRate"] = true,
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["conditions"] = {
			},
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "icon",
			["auto"] = false,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["icon_side"] = "RIGHT",
			["anchorFrameFrame"] = "PlayerFrame",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["sparkHeight"] = 30,
			["texture"] = "Melli",
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = false,
			["spark"] = false,
			["frameStrata"] = 1,
			["sparkHidden"] = "NEVER",
			["anchorFrameParent"] = false,
			["alpha"] = 1,
			["width"] = 36,
			["authorOptions"] = {
			},
			["config"] = {
			},
			["inverse"] = false,
			["zoom"] = 0,
			["orientation"] = "HORIZONTAL",
			["displayIcon"] = "",
			["cooldown"] = false,
			["uid"] = "5BUifE2Nagu",
		},
		["Combo Points Background"] = {
			["outline"] = "OUTLINE",
			["parent"] = "Nameplate Combo Points",
			["displayText"] = ".....",
			["customText"] = "",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/sv0bnASk1/1",
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
						["type"] = "custom",
						["subeventSuffix"] = "_CAST_START",
						["custom_type"] = "event",
						["names"] = {
						},
						["use_absorbMode"] = true,
						["event"] = "Health",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["custom"] = "function(e, ...)\n    local region = aura_env.region\n    local target = C_NamePlate.GetNamePlateForUnit(\"target\")\n    local attackable = not UnitIsFriend(\"player\", \"target\")\n    \n    if e == \"NAME_PLATE_UNIT_REMOVED\" then\n        local unit = ...\n        if unit and UnitGUID(unit) == UnitGUID(\"target\") then\n            region:Color(0,0,0,0)\n        end\n    elseif target and attackable then\n        local color = aura_env.config.bgcolor\n        \n        region:ClearAllPoints()\n        region:SetPoint(\"TOP\", target, \"BOTTOM\", aura_env.config.xoffset, aura_env.config.yoffset)\n        \n        region:Color(color[1], color[2], color[3], color[4])\n    else\n        region:Color(0,0,0,0)\n    end\n    return true\nend",
						["events"] = "PLAYER_TARGET_CHANGED, NAME_PLATE_UNIT_ADDED, NAME_PLATE_UNIT_REMOVED, PLAYER_ENTERING_WORLD",
						["spellIds"] = {
						},
						["check"] = "event",
						["use_unit"] = true,
						["unevent"] = "auto",
						["custom_hide"] = "custom",
					},
					["untrigger"] = {
						["custom"] = "function()\n    return true\nend",
					},
				}, -- [1]
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 70,
			["wordWrap"] = "Elide",
			["font"] = "Arial Narrow",
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 11.99995803833,
			["load"] = {
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
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
				["use_never"] = true,
				["class"] = {
					["single"] = "HUNTER",
					["multi"] = {
						["ROGUE"] = true,
						["DRUID"] = true,
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
				["spec"] = {
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
				["talent3"] = {
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
				["race"] = {
					["multi"] = {
					},
				},
				["use_class"] = false,
				["zoneIds"] = "",
			},
			["displayText_format_s_format"] = "none",
			["fontSize"] = 62,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["preferToUpdate"] = false,
			["regionType"] = "text",
			["conditions"] = {
			},
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["automaticWidth"] = "Fixed",
			["xOffset"] = 0,
			["authorOptions"] = {
				{
					["type"] = "color",
					["default"] = {
						0.54901960784314, -- [1]
						0.54901960784314, -- [2]
						0.54901960784314, -- [3]
						0.4046875834465, -- [4]
					},
					["key"] = "bgcolor",
					["name"] = "Background Color",
					["useDesc"] = false,
					["width"] = 1,
				}, -- [1]
				{
					["type"] = "number",
					["useDesc"] = false,
					["max"] = 200,
					["step"] = 1,
					["width"] = 1,
					["min"] = -200,
					["key"] = "xoffset",
					["default"] = 0,
					["name"] = "X Offset",
				}, -- [2]
				{
					["type"] = "number",
					["useDesc"] = false,
					["max"] = 100,
					["step"] = 1,
					["width"] = 1,
					["min"] = -100,
					["key"] = "yoffset",
					["default"] = 0,
					["name"] = "Y Offset",
				}, -- [3]
			},
			["config"] = {
				["xoffset"] = 39,
				["bgcolor"] = {
					0.89019607843137, -- [1]
					0.89019607843137, -- [2]
					0.89019607843137, -- [3]
					0.5, -- [4]
				},
				["yoffset"] = 52,
			},
			["justify"] = "LEFT",
			["tocversion"] = 11305,
			["id"] = "Combo Points Background",
			["shadowYOffset"] = -1,
			["frameStrata"] = 3,
			["width"] = 15.999987602234,
			["anchorFrameType"] = "SCREEN",
			["uid"] = "w4vNKFCGnie",
			["semver"] = "1.0.0",
			["selfPoint"] = "TOP",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.74000000953674, -- [4]
			},
			["fixedWidth"] = 150,
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["color"] = {
				0.74117647058823, -- [1]
				0.74117647058823, -- [2]
				0.74117647058823, -- [3]
				0, -- [4]
			},
		},
		["Warrior - Defensive Stance"] = {
			["outline"] = "OUTLINE",
			["color"] = {
				1, -- [1]
				0.37254901960784, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["displayText"] = "DEFENSIVE STANCE",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/z6xqQay0S/16",
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
						["type"] = "unit",
						["unevent"] = "auto",
						["form"] = {
							["single"] = 2,
						},
						["event"] = "Stance/Form/Aura",
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["unit"] = "player",
						["spellIds"] = {
						},
						["use_form"] = true,
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["names"] = {
						},
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["selfPoint"] = "BOTTOM",
			["font"] = "Arial Narrow",
			["version"] = 16,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_class"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["size"] = {
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
				["zoneIds"] = "",
			},
			["fontSize"] = 21,
			["shadowXOffset"] = 1,
			["regionType"] = "text",
			["conditions"] = {
			},
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
			},
			["wordWrap"] = "WordWrap",
			["semver"] = "1.0.15",
			["justify"] = "LEFT",
			["tocversion"] = 11302,
			["id"] = "Warrior - Defensive Stance",
			["uid"] = "QwSE99UBSjg",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["authorOptions"] = {
			},
			["config"] = {
			},
			["automaticWidth"] = "Auto",
			["shadowYOffset"] = -1,
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["parent"] = "Vermin Warrior Stance",
		},
		["Tin Ore"] = {
			["iconSource"] = -1,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["url"] = "https://wago.io/iST6tz9t8/1",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["itemName"] = 2771,
						["use_count"] = true,
						["duration"] = "1",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "item",
						["unevent"] = "auto",
						["use_exact_itemName"] = true,
						["use_unit"] = true,
						["use_itemName"] = true,
						["names"] = {
						},
						["use_includeBank"] = true,
						["subeventPrefix"] = "SPELL",
						["spellIds"] = {
						},
						["event"] = "Item Count",
						["count"] = "0",
						["subeventSuffix"] = "_CAST_START",
						["use_absorbMode"] = true,
						["count_operator"] = ">",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["useTooltip"] = true,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_shadowXOffset"] = 0,
					["type"] = "subtext",
					["text_anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "PT Sans Narrow",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_text_format_p_time_precision"] = 1,
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_anchorYOffset"] = 0,
				}, -- [2]
				{
					["glowFrequency"] = 0,
					["type"] = "subglow",
					["useGlowColor"] = false,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowDuration"] = 1,
					["glowXOffset"] = 0,
					["glowThickness"] = 1,
					["glow"] = true,
					["glowScale"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 40,
			["load"] = {
				["use_namerealm"] = true,
				["ingroup"] = {
					["single"] = "solo",
				},
				["namerealm"] = "Mxzq",
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["use_ingroup"] = true,
				["zoneIds"] = "",
				["use_never"] = true,
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["source"] = "import",
			["config"] = {
			},
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["cooldownEdge"] = false,
			["regionType"] = "icon",
			["cooldown"] = false,
			["xOffset"] = 0,
			["parent"] = "Ore Count",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["anchorFrameParent"] = false,
			["cooldownTextDisabled"] = false,
			["width"] = 40,
			["zoom"] = 0.3,
			["semver"] = "1.0.0",
			["tocversion"] = 90002,
			["id"] = "Tin Ore",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["useCooldownModRate"] = true,
			["uid"] = "z6rO(YSvyJb",
			["inverse"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["internalVersion"] = 70,
		},
		["Last Stand"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["wagoID"] = "v9qxdDgI4",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["sparkHeight"] = 30,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["sparkOffsetX"] = 0,
			["cooldownSwipe"] = true,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Last Stand", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showOnReady",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["type"] = "aura2",
						["useName"] = true,
						["unevent"] = "auto",
						["names"] = {
						},
						["use_unit"] = true,
						["event"] = "Action Usable",
						["spellName"] = 34428,
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_genericShowOn"] = true,
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["use_track"] = true,
						["useIgnoreName"] = false,
					},
					["untrigger"] = {
						["genericShowOn"] = "showOnReady",
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
			["internalVersion"] = 70,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["parent"] = "Vermin Warrior",
			["authorOptions"] = {
			},
			["barColor"] = {
				0.2, -- [1]
				1, -- [2]
				0.0862745098039216, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["useTooltip"] = false,
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.75,
					["type"] = "subglow",
					["useGlowColor"] = true,
					["text_color"] = {
					},
					["glowThickness"] = 2,
					["glowDuration"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0.85098039215686, -- [2]
						0.1843137254902, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 16,
					["glow"] = true,
					["glowScale"] = 1,
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_p_time_precision"] = 1,
					["text_text"] = "%p",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_shadowXOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
				}, -- [3]
			},
			["height"] = 36,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["load"] = {
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["use_class"] = false,
				["zoneIds"] = "",
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
						["WARRIOR"] = true,
					},
				},
				["use_level"] = false,
				["level"] = {
					"60", -- [1]
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
			["useAdjustededMax"] = false,
			["xOffset"] = 0,
			["cooldown"] = false,
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["displayIcon"] = "",
			["smoothProgress"] = true,
			["anchorFrameFrame"] = "PlayerFrame",
			["regionType"] = "icon",
			["alpha"] = 1,
			["uid"] = "M0FDBXCgVgs",
			["icon_side"] = "RIGHT",
			["useAdjustededMin"] = false,
			["sparkHidden"] = "NEVER",
			["anchorFrameParent"] = false,
			["texture"] = "Melli",
			["anchorFrameType"] = "SCREEN",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["spark"] = false,
			["useCooldownModRate"] = true,
			["id"] = "Last Stand",
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["frameStrata"] = 1,
			["width"] = 36,
			["cooldownTextDisabled"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["auto"] = false,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["zoom"] = 0.3,
		},
		["Info - ThreatSituation"] = {
			["sparkWidth"] = 5,
			["sparkOffsetX"] = 0,
			["authorOptions"] = {
				{
					["type"] = "number",
					["useDesc"] = false,
					["max"] = 40,
					["step"] = 1,
					["width"] = 1,
					["min"] = 0,
					["name"] = "Number of shown entries",
					["key"] = "numElements",
					["default"] = 8,
				}, -- [1]
				{
					["useName"] = true,
					["type"] = "header",
					["text"] = "sort order",
					["noMerge"] = false,
					["width"] = 1,
				}, -- [2]
				{
					["type"] = "select",
					["default"] = 2,
					["name"] = "Sort by",
					["key"] = "sort",
					["useDesc"] = false,
					["values"] = {
						"threatValue", -- [1]
						"rawPercentage", -- [2]
						"scaledPercentage", -- [3]
					},
					["width"] = 1,
				}, -- [3]
				{
					["type"] = "description",
					["text"] = "threatValue: The unit's total threat value on the mobUnit.\n\nrawPercentage: The unit's threat percentage against mobUnit relative to the threat of mobUnit's primary target. Can be greater than 100, up to 255. Stops updating when you become the primary target.\n\nscaledPercentage: The unit's threat percentage against mobUnit. At 100% the unit will become the primary target (tanking). This value is also scaled the closer the unit is to the mobUnit.",
					["fontSize"] = "medium",
					["width"] = 2,
				}, -- [4]
				{
					["useName"] = false,
					["type"] = "header",
					["text"] = "",
					["noMerge"] = false,
					["width"] = 1,
				}, -- [5]
				{
					["type"] = "description",
					["text"] = "A list of available icons can be found under the following link (click on it and use the icon ID).\nhttps://classic.wowhead.com/icons",
					["fontSize"] = "medium",
					["width"] = 2,
				}, -- [6]
				{
					["type"] = "number",
					["useDesc"] = true,
					["max"] = 999999,
					["step"] = 1,
					["width"] = 2,
					["min"] = 0,
					["name"] = "Status 0 icon",
					["desc"] = "Status 0: unit has less than 100% threat for mobUnit",
					["key"] = "icon0",
					["default"] = 132320,
				}, -- [7]
				{
					["type"] = "number",
					["useDesc"] = true,
					["max"] = 999999,
					["step"] = 1,
					["width"] = 2,
					["min"] = 0,
					["name"] = "Status 1 icon",
					["desc"] = "Status 1: unit has higher than 100% threat for mobUnit (aggro), but isn't the primary target (tanking)",
					["key"] = "icon1",
					["default"] = 132347,
				}, -- [8]
				{
					["type"] = "number",
					["useDesc"] = true,
					["max"] = 999999,
					["step"] = 1,
					["width"] = 2,
					["min"] = 0,
					["name"] = "Status 2 icon",
					["desc"] = "Status 2: unit is the primary target (tanking) for mobUnit, but another unit has higher than 100% threat (aggro)",
					["key"] = "icon2",
					["default"] = 132341,
				}, -- [9]
				{
					["type"] = "number",
					["useDesc"] = true,
					["max"] = 999999,
					["step"] = 1,
					["width"] = 2,
					["min"] = 0,
					["name"] = "Status 3 icon",
					["desc"] = "Status 3: unit is the primary target (tanking) for mobUnit and no other unit has higher than 100% threat (aggro)",
					["key"] = "icon3",
					["default"] = 132341,
				}, -- [10]
				{
					["type"] = "description",
					["text"] = "Note: The bar color for the respective status can be adjusted under 'Conditions'..",
					["fontSize"] = "medium",
					["width"] = 2,
				}, -- [11]
			},
			["preferToUpdate"] = false,
			["customText"] = "function(...)\n--print(...)\nend",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["selfPoint"] = "CENTER",
			["iconSource"] = -1,
			["sparkRotation"] = 0,
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/xfKIUqvJH/2",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["custom"] = "-- lint\nlocal _G = _G\nlocal IsInRaid = _G.IsInRaid\nlocal UnitName = _G.UnitName\nlocal GetNumGroupMembers = _G.GetNumGroupMembers\nlocal UnitDetailedThreatSituation = _G.UnitDetailedThreatSituation\n\n-- vars\nlocal aura_env = aura_env -- luacheck: ignore\nlocal WeakAuras = WeakAuras -- luacheck: ignore\nlocal Player = UnitName('player')\n\nlocal Threat = {\n    Insert = function(threat, unit)\n        -- https://wow.gamepedia.com/API_UnitDetailedThreatSituation\n        local _, status, scaled, raw, value = UnitDetailedThreatSituation(unit, 'target')\n        if (status) then\n            scaled = math.floor(scaled * 100 + 0.5) / 100\n            value = math.floor(value / 100 + 0.5)\n            unit = UnitName(unit)\n            if (not threat[unit]) then\n                threat[unit] = { unit = unit, status = status, scaled = scaled, raw = raw, threat = value }\n                threat[#threat+1] = threat[unit]\n            end\n        end\n    end,\n    UpdateRaid = function(self)\n        local threat = {}\n        if (UnitName('target')) then\n            self.Insert(threat, 'pet')\n            for i = 1, GetNumGroupMembers() do self.Insert(threat, 'raid'..i) end\n            self.TSU(threat)\n        end\n    end,\n    UpdateGroup = function(self)\n        local threat = {}\n        if (UnitName('target')) then\n            self.Insert(threat, 'pet')\n            self.Insert(threat, 'player')\n            for i = 1, 5 do self.Insert(threat, 'party'..i) end\n            self.TSU(threat)\n        end\n    end,\n    TSU = function(threat)\n        if (aura_env.config.sort == 1) then table.sort(threat, function(a, b) return a.scaled > b.scaled end)\n        elseif (aura_env.config.sort == 2) then table.sort(threat, function(a, b) return a.raw > b.raw end)\n        else table.sort(threat, function(a, b) return a.threat > b.threat end) end\n        \n        for i = 1, #threat do\n            local o, t = aura_env.dyn[i] or { progressType = 'static', total = 100 }, threat[i]\n            if (t) then\n                o.name, o.value, o.threat, o.status, o.player, o.show = t.unit, t.scaled, t.threat, t.status, (t.unit == Player), true\n                if (t.status == 0) then o.icon = aura_env.config.icon0 or 132320 -- unit has less than 100% threat for mobUnit\n                elseif (t.status == 1) then o.icon = aura_env.config.icon1 or 132347 -- unit has higher than 100% threat for mobUnit (aggro), but isn't the primary target (tanking)\n                elseif (t.status == 2) then o.icon = aura_env.config.icon2 or 132341 -- unit is the primary target (tanking) for mobUnit, but another unit has higher than 100% threat (aggro)\n                else o.icon = aura_env.config.icon3 or 132341 end -- 3 = unit is the primary target (tanking) for mobUnit and no other unit has higher than 100% threat (aggro)\n            else\n                o.name, o.value, o.player, o.show = '', 0, false, false\n            end\n            \n            if (i <= aura_env.config.numElements) then\n                o.changed, o.index = true, i\n                aura_env.dyn[i] = o\n            elseif (o.player) then\n                o.changed, o.index = true, #aura_env.dyn\n                aura_env.dyn[#aura_env.dyn] = o\n            end\n        end\n    end,\n    Reset = function()\n        for i = 1, aura_env.config.numElements do\n            local o = aura_env.dyn[i]\n            if (o) then o.name, o.value, o.player, o.show, o.changed = '', 0, false, false, true end\n            aura_env.dyn[i] = o\n        end\n    end\n}\n\n-- event\naura_env.UNIT_THREAT_LIST_UPDATE = function()\n    if (IsInRaid()) then Threat:UpdateRaid()\n    else Threat:UpdateGroup() end\nend\n\naura_env.PLAYER_REGEN_DISABLED = function()\n    Threat:Reset()\n    aura_env.UNIT_THREAT_LIST_UPDATE()\nend\n\naura_env.PLAYER_REGEN_ENABLED = aura_env.PLAYER_REGEN_DISABLED\naura_env.PLAYER_TARGET_CHANGED = aura_env.PLAYER_REGEN_DISABLED\naura_env.UNIT_THREAT_SITUATION_UPDATE = aura_env.PLAYER_REGEN_DISABLED\n\naura_env.OPTIONS = function() -- weakaura options is opend\n    if (WeakAuras.IsOptionsOpen()) then\n        local threat = {}\n        for _,unit in pairs({'Willie', 'Eli', 'Minnie', 'Goofy', 'Mickey', 'Sylvester', 'Pluto', 'Milton', 'Salty', 'Duffy', UnitName('player')}) do\n            local v = math.random(0, 9001)\n            threat[#threat+1] = { unit = unit, status = math.random(0, 3), scaled = math.floor((100 / 9001 * v) * 100 + 0.5) / 100, raw = math.floor((255 / 9001 * v) * 100 + 0.5) / 100, threat = v }\n        end\n        Threat.TSU(threat)\n    end\nend",
					["do_custom"] = true,
				},
				["finish"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["custom_type"] = "stateupdate",
						["debuffType"] = "HELPFUL",
						["event"] = "Health",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["names"] = {
						},
						["spellIds"] = {
						},
						["events"] = "PLAYER_REGEN_DISABLED, PLAYER_REGEN_ENABLED, UNIT_THREAT_LIST_UPDATE:target, UNIT_THREAT_SITUATION_UPDATE:target, PLAYER_TARGET_CHANGED",
						["check"] = "event",
						["custom"] = "function(frame, event, ...)\n    aura_env.dyn = frame\n    if aura_env[event] then aura_env[event](...) end\n    return true\nend",
						["subeventSuffix"] = "_CAST_START",
						["customVariables"] = "{\n    threat = 'number',\n    status = 'number',\n    player = 'bool'\n}",
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
			["internalVersion"] = 70,
			["xOffset"] = 0,
			["animation"] = {
				["start"] = {
					["colorR"] = 1,
					["duration_type"] = "relative",
					["colorB"] = 1,
					["colorG"] = 1,
					["type"] = "none",
					["duration"] = "100",
					["easeType"] = "none",
					["scalex"] = 1,
					["use_color"] = true,
					["alpha"] = 0,
					["easeStrength"] = 3,
					["y"] = 0,
					["colorType"] = "custom",
					["scaley"] = 1,
					["preset"] = "fade",
					["colorFunc"] = "function()\n    local c =  select(2, UnitClass('player'))\n    local cl = RAID_CLASS_COLORS[c]\n    \n    return cl.r,cl.g,cl.b,1\nend",
					["rotate"] = 0,
					["x"] = 0,
					["colorA"] = 1,
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["preset"] = "fade",
					["duration_type"] = "seconds",
				},
			},
			["config"] = {
				["icon0"] = 132320,
				["sort"] = 1,
				["numElements"] = 6,
				["icon2"] = 132341,
				["icon3"] = 132341,
				["icon1"] = 132347,
			},
			["barColor2"] = {
				1, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["barColor"] = {
				0.60392156862745, -- [1]
				0.60392156862745, -- [2]
				0.60392156862745, -- [3]
				0.80000001192093, -- [4]
			},
			["desaturate"] = false,
			["sparkRotationMode"] = "AUTO",
			["icon"] = false,
			["version"] = 2,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subforeground",
				}, -- [2]
				{
					["text_text_format_n_format"] = "none",
					["text_text"] = "%n",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_anchorXOffset"] = 0,
					["text_color"] = {
						0.94901960784314, -- [1]
						0.96470588235294, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Arial Narrow",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "INNER_TOPLEFT",
					["text_anchorYOffset"] = 1,
					["text_shadowXOffset"] = 1,
					["text_fontSize"] = 10,
					["anchorXOffset"] = 0,
					["text_visible"] = true,
				}, -- [3]
				{
					["text_shadowXOffset"] = 1,
					["text_text"] = "(%threat) %p%%",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_text_format_scaled_format"] = "none",
					["text_fixedWidth"] = 64,
					["text_text_format_p_time_legacy_floor"] = true,
					["rotateText"] = "NONE",
					["text_color"] = {
						0.94901960784314, -- [1]
						0.96470588235294, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_fontSize"] = 8,
					["text_text_format_t_time_dynamic_threshold"] = 60,
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_text_format_t_time_format"] = 0,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["text_text_format_t_format"] = "timed",
					["type"] = "subtext",
					["text_anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
					["text_font"] = "Arial Narrow",
					["text_text_format_timeleft_format"] = "none",
					["text_anchorYOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
					["text_visible"] = true,
					["text_text_format_threat_format"] = "none",
					["text_anchorPoint"] = "INNER_RIGHT",
					["anchorXOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["border_color"] = {
					},
					["text_text_format_p_time_precision"] = 1,
					["text_text_format_t_time_precision"] = 1,
				}, -- [4]
				{
					["border_offset"] = 0,
					["border_size"] = 2,
					["border_anchor"] = "bar",
					["text_color"] = {
					},
					["border_color"] = {
						0.086274509803922, -- [1]
						0.090196078431373, -- [2]
						0.10196078431373, -- [3]
						1, -- [4]
					},
					["border_visible"] = false,
					["border_edge"] = "Blizzard Tooltip",
					["type"] = "subborder",
				}, -- [5]
				{
					["border_offset"] = 0,
					["border_anchor"] = "icon",
					["border_size"] = 1,
					["border_color"] = {
						0.086274509803922, -- [1]
						0.090196078431373, -- [2]
						0.10196078431373, -- [3]
						1, -- [4]
					},
					["border_visible"] = false,
					["border_edge"] = "Blizzard Party",
					["type"] = "subborder",
				}, -- [6]
				{
					["glowFrequency"] = 0.25,
					["glow"] = false,
					["useGlowColor"] = false,
					["glowType"] = "buttonOverlay",
					["glowThickness"] = 1,
					["glowDuration"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["type"] = "subglow",
					["glowLength"] = 10,
					["glowXOffset"] = 0,
					["glow_anchor"] = "icon",
					["glowScale"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [7]
			},
			["height"] = 12,
			["enableGradient"] = false,
			["load"] = {
				["size"] = {
					["multi"] = {
					},
				},
				["use_never"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "PRIEST",
					["multi"] = {
						["PRIEST"] = true,
					},
				},
				["use_combat"] = true,
				["zoneIds"] = "",
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["displayIcon"] = "133473",
			["source"] = "import",
			["auto"] = true,
			["backgroundColor"] = {
				0.6980392156862745, -- [1]
				0.6980392156862745, -- [2]
				0.6980392156862745, -- [3]
				0.2178025841712952, -- [4]
			},
			["uid"] = "0NBlQkcHV5x",
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["sparkOffsetY"] = 0,
			["gradientOrientation"] = "HORIZONTAL",
			["icon_side"] = "LEFT",
			["id"] = "Info - ThreatSituation",
			["anchorFrameType"] = "SCREEN",
			["sparkHeight"] = 2,
			["texture"] = "xVerminClean",
			["alpha"] = 1,
			["sparkTexture"] = "bonusobjectives-bar-spark",
			["spark"] = false,
			["tocversion"] = 11305,
			["sparkHidden"] = "NEVER",
			["semver"] = "1.0.1",
			["frameStrata"] = 1,
			["width"] = 175,
			["zoom"] = 0.3,
			["sparkColor"] = {
				0.63921568627451, -- [1]
				0.65098039215686, -- [2]
				0.68627450980392, -- [3]
				0.5, -- [4]
			},
			["inverse"] = false,
			["anchorFrameParent"] = false,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "status",
						["value"] = "0",
					},
					["changes"] = {
						{
							["value"] = {
								0.32549019607843, -- [1]
								1, -- [2]
								0, -- [3]
								0.65000000596047, -- [4]
							},
							["property"] = "barColor",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "status",
						["value"] = "1",
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								0.99607843137255, -- [2]
								0, -- [3]
								0.80000001192093, -- [4]
							},
							["property"] = "barColor",
						}, -- [1]
					},
				}, -- [2]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "status",
						["value"] = "2",
					},
					["changes"] = {
						{
							["value"] = {
								0.98039215686274, -- [1]
								0.32549019607843, -- [2]
								0, -- [3]
								0.80000001192093, -- [4]
							},
							["property"] = "barColor",
						}, -- [1]
					},
				}, -- [3]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "status",
						["value"] = "3",
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								0, -- [2]
								0, -- [3]
								0.80000001192093, -- [4]
							},
							["property"] = "barColor",
						}, -- [1]
					},
				}, -- [4]
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "player",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "sub.7.glow",
						}, -- [1]
					},
				}, -- [5]
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "player",
						["value"] = 0,
					},
					["changes"] = {
						{
							["property"] = "sub.7.glow",
						}, -- [1]
					},
				}, -- [6]
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["parent"] = "Threat List",
		},
		["Mithril Ore"] = {
			["iconSource"] = -1,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = false,
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
						["itemName"] = 3858,
						["use_count"] = true,
						["duration"] = "1",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["type"] = "item",
						["subeventSuffix"] = "_CAST_START",
						["use_exact_itemName"] = true,
						["unit"] = "player",
						["event"] = "Item Count",
						["use_unit"] = true,
						["use_includeBank"] = true,
						["spellIds"] = {
						},
						["count"] = "0",
						["unevent"] = "auto",
						["use_absorbMode"] = true,
						["use_itemName"] = true,
						["names"] = {
						},
						["count_operator"] = ">",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_anchorYOffset"] = 0,
					["type"] = "subtext",
					["text_anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "PT Sans Narrow",
					["anchorXOffset"] = 0,
					["text_shadowYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_fontSize"] = 16,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_shadowXOffset"] = 0,
				}, -- [2]
				{
					["glowFrequency"] = 0,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowDuration"] = 1,
					["useGlowColor"] = false,
					["glow"] = true,
					["glowThickness"] = 1,
					["glowScale"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 40,
			["load"] = {
				["use_namerealm"] = true,
				["ingroup"] = {
					["single"] = "solo",
				},
				["namerealm"] = "Mxzq",
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["use_ingroup"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["use_never"] = true,
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["source"] = "import",
			["uid"] = "53BfeKjl5ft",
			["icon"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["information"] = {
				["forceEvents"] = true,
			},
			["url"] = "https://wago.io/iST6tz9t8/1",
			["useTooltip"] = true,
			["parent"] = "Ore Count",
			["anchorFrameParent"] = false,
			["cooldownTextDisabled"] = false,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["semver"] = "1.0.0",
			["tocversion"] = 90002,
			["id"] = "Mithril Ore",
			["useCooldownModRate"] = true,
			["alpha"] = 1,
			["width"] = 40,
			["frameStrata"] = 1,
			["config"] = {
			},
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["conditions"] = {
			},
			["cooldown"] = false,
			["xOffset"] = 0,
		},
		["Cobalt Ore"] = {
			["iconSource"] = -1,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = false,
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
						["itemName"] = 36909,
						["use_count"] = true,
						["duration"] = "1",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["type"] = "item",
						["subeventSuffix"] = "_CAST_START",
						["use_exact_itemName"] = true,
						["unit"] = "player",
						["event"] = "Item Count",
						["use_unit"] = true,
						["use_includeBank"] = true,
						["spellIds"] = {
						},
						["count"] = "0",
						["unevent"] = "auto",
						["use_absorbMode"] = true,
						["use_itemName"] = true,
						["names"] = {
						},
						["count_operator"] = ">",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_anchorYOffset"] = 0,
					["type"] = "subtext",
					["text_anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "PT Sans Narrow",
					["anchorXOffset"] = 0,
					["text_shadowYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_fontSize"] = 16,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_shadowXOffset"] = 0,
				}, -- [2]
				{
					["glowFrequency"] = 0,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowDuration"] = 1,
					["useGlowColor"] = false,
					["glow"] = true,
					["glowThickness"] = 1,
					["glowScale"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 40,
			["load"] = {
				["use_namerealm"] = true,
				["ingroup"] = {
					["single"] = "solo",
				},
				["namerealm"] = "Mxzq",
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["use_ingroup"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["use_never"] = true,
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["source"] = "import",
			["uid"] = "MEOaW5KsVz(",
			["icon"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["information"] = {
				["forceEvents"] = true,
			},
			["url"] = "https://wago.io/iST6tz9t8/1",
			["useTooltip"] = true,
			["parent"] = "Ore Count",
			["anchorFrameParent"] = false,
			["cooldownTextDisabled"] = false,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["semver"] = "1.0.0",
			["tocversion"] = 90002,
			["id"] = "Cobalt Ore",
			["useCooldownModRate"] = true,
			["alpha"] = 1,
			["width"] = 40,
			["frameStrata"] = 1,
			["config"] = {
			},
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["conditions"] = {
				{
					["check"] = {
					},
					["changes"] = {
						{
						}, -- [1]
					},
				}, -- [1]
			},
			["cooldown"] = false,
			["xOffset"] = 0,
		},
		["Misdirection"] = {
			["iconSource"] = -1,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = true,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura2",
						["useName"] = true,
						["auranames"] = {
							"Misdirection", -- [1]
						},
						["auraspellids"] = {
							"80240", -- [1]
						},
						["useExactSpellId"] = false,
						["event"] = "Health",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["spellIds"] = {
						},
						["names"] = {
						},
						["match_count"] = "0",
						["match_countOperator"] = ">",
						["useMatch_count"] = false,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "spell",
						["subeventSuffix"] = "_CAST_START",
						["unevent"] = "auto",
						["duration"] = "1",
						["use_genericShowOn"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["use_unit"] = true,
						["realSpellName"] = 34477,
						["use_spellName"] = true,
						["unit"] = "player",
						["genericShowOn"] = "showAlways",
						["use_absorbMode"] = true,
						["subeventPrefix"] = "SPELL",
						["use_track"] = true,
						["spellName"] = 34477,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_shadowXOffset"] = 1,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%2.p",
					["text_text_format_2.p_time_format"] = 0,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_text_format_2.p_time_legacy_floor"] = true,
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_2.p_format"] = "timed",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Arial Narrow",
					["text_text_format_2.p_time_mod_rate"] = true,
					["text_shadowYOffset"] = -1,
					["text_text_format_2.p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "CENTER",
					["text_visible"] = false,
					["text_text_format_2.p_time_precision"] = 1,
					["text_fontSize"] = 24,
					["anchorXOffset"] = 0,
					["text_automaticWidth"] = "Auto",
				}, -- [2]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text_format_1.p_time_legacy_floor"] = true,
					["text_text_format_p_format"] = "timed",
					["text_justify"] = "CENTER",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_1.p_time_format"] = 0,
					["anchorYOffset"] = 0,
					["text_text_format_1.p_time_mod_rate"] = true,
					["rotateText"] = "NONE",
					["anchorXOffset"] = 0,
					["text_shadowXOffset"] = 0,
					["text_text_format_p_time_precision"] = 1,
					["type"] = "subtext",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Arial Narrow",
					["text_anchorPoint"] = "CENTER",
					["text_shadowYOffset"] = 0,
					["text_text_format_1.p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_text_format_1.p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_text_format_1.p_time_precision"] = 1,
					["text_fontSize"] = 16,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text"] = "%1.p",
				}, -- [3]
			},
			["height"] = 40,
			["load"] = {
				["use_class"] = true,
				["use_never"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "HUNTER",
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["source"] = "import",
			["uid"] = "Ltt41BdE31T",
			["url"] = "https://wago.io/E9AeMcIo0/1",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["cooldown"] = false,
			["xOffset"] = 0,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["zoom"] = 0,
			["anchorFrameParent"] = false,
			["semver"] = "1.0.0",
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = true,
			["auto"] = true,
			["tocversion"] = 80300,
			["id"] = "Misdirection",
			["frameStrata"] = 1,
			["useCooldownModRate"] = true,
			["width"] = 40,
			["alpha"] = 1,
			["config"] = {
			},
			["inverse"] = true,
			["selfPoint"] = "CENTER",
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = -2,
						["variable"] = "AND",
						["checks"] = {
							{
								["trigger"] = 2,
								["variable"] = "onCooldown",
								["value"] = 1,
							}, -- [1]
							{
								["trigger"] = 1,
								["variable"] = "show",
								["value"] = 1,
							}, -- [2]
						},
					},
					["changes"] = {
						{
							["property"] = "desaturate",
						}, -- [1]
						{
							["value"] = {
								["custom"] = "local reg = WeakAuras.GetRegion(aura_env.id)\n\nreg.glowicon = reg.glowicon or CreateFrame(\"Button\", aura_env.id..\"Glower\" )\nreg.glowicon:SetSize( reg.icon:GetWidth() - 2, reg.icon:GetHeight() - 2)\nreg.glowicon:SetPoint( \"CENTER\", reg.icon, \"CENTER\" )\nActionButton_ShowOverlayGlow( reg.glowicon )",
							},
							["property"] = "customcode",
						}, -- [2]
						{
							["property"] = "inverse",
						}, -- [3]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "show",
						["value"] = 0,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "sub.2.text_visible",
						}, -- [1]
						{
							["property"] = "sub.3.text_visible",
						}, -- [2]
						{
							["value"] = {
								["custom"] = "local reg = WeakAuras.GetRegion(aura_env.id)\n\nreg.glowicon = reg.glowicon or CreateFrame(\"Button\", aura_env.id..\"Glower\" )\nreg.glowicon:SetSize( reg.icon:GetWidth() - 1, reg.icon:GetHeight() - 1)\nreg.glowicon:SetPoint( \"CENTER\", reg.icon, \"CENTER\" )\nActionButton_HideOverlayGlow( reg.glowicon )",
							},
							["property"] = "customcode",
						}, -- [3]
					},
				}, -- [2]
				{
					["check"] = {
						["trigger"] = -2,
						["variable"] = "AND",
						["checks"] = {
							{
								["trigger"] = 2,
								["variable"] = "onCooldown",
								["value"] = 1,
							}, -- [1]
							{
								["trigger"] = 1,
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
					},
				}, -- [3]
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["parent"] = "Vermin Hunter",
		},
		["CP1"] = {
			["color"] = {
				0.99607843137255, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -283,
			["anchorPoint"] = "CENTER",
			["url"] = "https://wago.io/HCaWT5tJa/14",
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
						["use_form"] = true,
						["use_power"] = true,
						["genericShowOn"] = "showOnActive",
						["unit"] = "player",
						["powertype"] = 4,
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "unit",
						["subeventSuffix"] = "_CAST_START",
						["power_operator"] = {
							">=", -- [1]
						},
						["names"] = {
						},
						["use_requirePowerType"] = false,
						["event"] = "Power",
						["power"] = {
							"1", -- [1]
						},
						["subeventPrefix"] = "SPELL",
						["spellIds"] = {
						},
						["use_unit"] = true,
						["rune"] = 0,
						["unevent"] = "auto",
						["use_inverse"] = true,
						["duration"] = "1",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["itemName"] = 150936,
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["genericShowOn"] = "showOnActive",
						["subeventPrefix"] = "SPELL",
						["unit"] = "player",
						["use_unit"] = true,
						["use_itemName"] = true,
						["unevent"] = "auto",
						["use_inverse"] = true,
						["event"] = "Item Equipped",
						["type"] = "item",
					},
					["untrigger"] = {
						["itemName"] = 150936,
					},
				}, -- [2]
				["disjunctive"] = "all",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 70,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["rotation"] = 0,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 10,
			["rotate"] = true,
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["ROGUE"] = true,
						["DRUID"] = true,
					},
				},
				["use_class"] = false,
				["role"] = {
					["multi"] = {
					},
				},
				["level"] = {
					"70", -- [1]
				},
				["zoneIds"] = "",
				["talent2"] = {
					["multi"] = {
					},
				},
				["affixes"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 9,
					["multi"] = {
						[7] = true,
						[9] = true,
					},
				},
				["use_vehicle"] = false,
				["spec"] = {
					["multi"] = {
					},
				},
				["level_operator"] = {
					"<", -- [1]
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
				["use_vehicleUi"] = false,
				["use_combat"] = true,
				["use_level"] = false,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["textureWrapMode"] = "CLAMP",
			["mirror"] = false,
			["regionType"] = "texture",
			["blendMode"] = "BLEND",
			["alpha"] = 1,
			["texture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_White",
			["discrete_rotation"] = 0,
			["xOffset"] = -99,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "CP1",
			["animation"] = {
				["start"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["duration_type"] = "seconds",
					["preset"] = "slideright",
					["easeStrength"] = 3,
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["duration_type"] = "seconds",
					["preset"] = "slideleft",
					["easeStrength"] = 3,
				},
			},
			["frameStrata"] = 2,
			["anchorFrameType"] = "SCREEN",
			["width"] = 67,
			["uid"] = "1G6vzVZFHu5",
			["authorOptions"] = {
			},
			["config"] = {
			},
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["parent"] = "MANA BAR + DRUID / ROGUE CPOINTS",
		},
		["CP4"] = {
			["color"] = {
				0.99607843137255, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -283,
			["anchorPoint"] = "CENTER",
			["url"] = "https://wago.io/HCaWT5tJa/14",
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
						["use_power"] = true,
						["genericShowOn"] = "showOnActive",
						["use_unit"] = true,
						["powertype"] = 4,
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "unit",
						["unevent"] = "auto",
						["power_operator"] = {
							">=", -- [1]
						},
						["event"] = "Power",
						["unit"] = "player",
						["power"] = {
							"4", -- [1]
						},
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["use_requirePowerType"] = false,
						["names"] = {
						},
						["duration"] = "1",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["itemName"] = 150936,
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["genericShowOn"] = "showOnActive",
						["subeventPrefix"] = "SPELL",
						["unit"] = "player",
						["use_unit"] = true,
						["use_itemName"] = true,
						["unevent"] = "auto",
						["use_inverse"] = true,
						["event"] = "Item Equipped",
						["type"] = "item",
					},
					["untrigger"] = {
						["itemName"] = 150936,
					},
				}, -- [2]
				["disjunctive"] = "all",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["duration_type"] = "seconds",
					["preset"] = "slideright",
					["easeStrength"] = 3,
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["duration_type"] = "seconds",
					["preset"] = "slideleft",
					["easeStrength"] = 3,
				},
			},
			["desaturate"] = false,
			["rotation"] = 0,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 10,
			["rotate"] = true,
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["ROGUE"] = true,
						["DRUID"] = true,
					},
				},
				["use_class"] = false,
				["role"] = {
					["multi"] = {
					},
				},
				["level"] = {
					"70", -- [1]
				},
				["zoneIds"] = "",
				["talent2"] = {
					["multi"] = {
					},
				},
				["affixes"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 9,
					["multi"] = {
						[7] = true,
						[9] = true,
					},
				},
				["use_vehicle"] = false,
				["spec"] = {
					["multi"] = {
					},
				},
				["level_operator"] = {
					"<", -- [1]
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
				["use_vehicleUi"] = false,
				["use_combat"] = true,
				["use_level"] = false,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["textureWrapMode"] = "CLAMP",
			["mirror"] = false,
			["regionType"] = "texture",
			["blendMode"] = "BLEND",
			["alpha"] = 1,
			["texture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_White",
			["discrete_rotation"] = 0,
			["xOffset"] = 50,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "CP4",
			["parent"] = "MANA BAR + DRUID / ROGUE CPOINTS",
			["frameStrata"] = 2,
			["width"] = 67,
			["config"] = {
			},
			["uid"] = "JmoDu(YlHE3",
			["selfPoint"] = "CENTER",
			["anchorFrameType"] = "SCREEN",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["authorOptions"] = {
			},
		},
		["Loss of Control Alert"] = {
			["iconSource"] = -1,
			["wagoID"] = "JiQILDF99",
			["xOffset"] = -60,
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = true,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["customVariables"] = "{\n    school = \"number\",\n    priority = \"number\",\n    secondary = \"bool\"\n}",
						["type"] = "custom",
						["unevent"] = "timed",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["duration"] = "1",
						["event"] = "Chat Message",
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["spellIds"] = {
						},
						["custom"] = "function (allstates, event, ...)\n    allstates[1] = \n    {\n        show = false,\n        changed = true,\n        priority = -1,\n        expirationTime = 0\n    }\n    \n    local activeLossOfControlCount = C_LossOfControl.GetActiveLossOfControlDataCount()\n    local lossName = nil\n    for i=1,activeLossOfControlCount do\n        local data = C_LossOfControl.GetActiveLossOfControlData(i)\n        \n        lossName = data.displayText\n        if data.locType == \"SCHOOL_INTERRUPT\" then\n            if data.lockoutSchool and data.lockoutSchool ~= 0 then\n                lossName = string.format(\"%s Locked\", GetSchoolString(data.lockoutSchool));\n            end\n        end\n        \n        if (allstates[1].priority <= data.priority and allstates[1].expirationTime < (GetTime() + (data.timeRemaining or 0))) then\n            allstates[1] = \n            {\n                show = true,\n                changed = true,\n                index = 2,\n                duration = data.duration,\n                expirationTime = GetTime() + (data.timeRemaining or 0),\n                progressType = \"timed\",\n                autoHide = true,\n                icon = data.iconTexture,\n                name = lossName,\n                school = data.lockoutSchool,            \n                priority = data.priority,\n                secondary = false\n            }\n        end\n    end\n    if (aura_env.config.nextLOC.showNext) then\n        allstates[2] = \n        {\n            show = false,\n            changed = true,\n            priority = -1,\n            expirationTime = allstates[1].expirationTime\n        }\n        for i=1,activeLossOfControlCount do\n            local data = C_LossOfControl.GetActiveLossOfControlData(i)\n            \n            lossName = data.displayText\n            if data.locType == \"SCHOOL_INTERRUPT\" then\n                if data.lockoutSchool and data.lockoutSchool ~= 0 then\n                    lossName = string.format(\"%s Locked\", GetSchoolString(data.lockoutSchool));\n                end\n            end\n            \n            if (allstates[2].priority <= data.priority and allstates[2].expirationTime < (GetTime() + (data.timeRemaining or 0)) and data.priority < allstates[1].priority) then\n                allstates[2] = \n                {\n                    show = true,\n                    changed = true,\n                    index = 1,\n                    duration = data.duration,\n                    expirationTime = GetTime() + (data.timeRemaining or 0),\n                    progressType = \"timed\",\n                    autoHide = true,\n                    icon = data.iconTexture,\n                    name = lossName,\n                    school = data.lockoutSchool,            \n                    priority = data.priority,\n                    secondary = true\n                }         \n            end\n        end        \n    end\n    return true\nend",
						["events"] = "LOSS_OF_CONTROL_UPDATE LOSS_OF_CONTROL_ADDED",
						["check"] = "event",
						["unit"] = "player",
						["custom_type"] = "stateupdate",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["useTooltip"] = false,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_text_format_n_format"] = "none",
					["text_text"] = "%n",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "LEFT",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_anchorXOffset"] = 3,
					["text_color"] = {
						1, -- [1]
						0.92549019607843, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_font"] = "Naowh",
					["text_shadowYOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "THICKOUTLINE",
					["text_anchorPoint"] = "OUTER_RIGHT",
					["text_visible"] = true,
					["text_shadowXOffset"] = 0,
					["text_fontSize"] = 18,
					["anchorXOffset"] = 0,
					["text_anchorYOffset"] = 7,
				}, -- [2]
				{
					["text_text_format_p_time_precision"] = 1,
					["text_text"] = "%p seconds",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "LEFT",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_shadowXOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["anchorYOffset"] = 0,
					["type"] = "subtext",
					["text_anchorXOffset"] = 3,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Naowh",
					["text_text_format_p_time_mod_rate"] = true,
					["text_shadowYOffset"] = 0,
					["text_fontType"] = "THICKOUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "OUTER_RIGHT",
					["text_text_format_p_time_format"] = 0,
					["text_anchorYOffset"] = -11,
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_format"] = "timed",
				}, -- [3]
				{
					["border_size"] = 1,
					["border_offset"] = 1,
					["border_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["border_visible"] = true,
					["border_edge"] = "1 Pixel",
					["type"] = "subborder",
				}, -- [4]
			},
			["height"] = 40,
			["load"] = {
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
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
			["alpha"] = 0.85,
			["source"] = "import",
			["width"] = 40,
			["internalVersion"] = 70,
			["desc"] = "",
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["displayIcon"] = 136071,
			["regionType"] = "icon",
			["parent"] = "Loss of Control Alert (WOTLK)",
			["url"] = "https://wago.io/JiQILDF99/1",
			["config"] = {
				["nextLOC"] = {
					["showNext"] = true,
				},
			},
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["do_custom"] = false,
				},
				["finish"] = {
				},
			},
			["useCooldownModRate"] = true,
			["semver"] = "1.0.0",
			["zoom"] = 0.3,
			["auto"] = true,
			["tocversion"] = 30400,
			["id"] = "Loss of Control Alert",
			["cooldownTextDisabled"] = false,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["uid"] = "hADcUVUEpD1",
			["inverse"] = true,
			["authorOptions"] = {
				{
					["subOptions"] = {
						{
							["type"] = "toggle",
							["default"] = false,
							["desc"] = "Show the next lower priority LOC effect that has a longer duration than the current one in the bottom right of the current LOC effect",
							["key"] = "showNext",
							["useDesc"] = true,
							["name"] = "Show",
							["width"] = 1,
						}, -- [1]
					},
					["type"] = "group",
					["nameSource"] = 0,
					["width"] = 1,
					["useCollapse"] = true,
					["name"] = "Next LOC Options",
					["key"] = "nextLOC",
					["collapse"] = false,
					["limitType"] = "none",
					["groupType"] = "simple",
					["hideReorder"] = true,
					["size"] = 10,
				}, -- [1]
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "secondary",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = 20,
							["property"] = "width",
						}, -- [1]
						{
							["value"] = 20,
							["property"] = "height",
						}, -- [2]
						{
							["value"] = -30,
							["property"] = "xOffsetRelative",
						}, -- [3]
						{
							["value"] = -10,
							["property"] = "yOffsetRelative",
						}, -- [4]
						{
							["value"] = false,
							["property"] = "sub.2.text_visible",
						}, -- [5]
						{
							["property"] = "sub.3.text_visible",
						}, -- [6]
					},
				}, -- [1]
			},
			["cooldown"] = false,
			["animation"] = {
				["start"] = {
					["colorR"] = 1,
					["duration_type"] = "seconds",
					["alphaType"] = "straight",
					["colorB"] = 1,
					["colorG"] = 1,
					["alphaFunc"] = "function(progress, start, delta)\n    return start + (progress * delta)\nend\n",
					["use_alpha"] = false,
					["scaleType"] = "straightScale",
					["easeType"] = "none",
					["colorA"] = 1,
					["scaley"] = 2,
					["alpha"] = 0,
					["scalex"] = 2,
					["y"] = 0,
					["x"] = 0,
					["easeStrength"] = 3,
					["use_scale"] = true,
					["scaleFunc"] = "function(progress, startX, startY, scaleX, scaleY)\n    return startX + (progress * (scaleX - startX)), startY + (progress * (scaleY - startY))\nend\n",
					["rotate"] = 0,
					["type"] = "custom",
					["duration"] = "0.2",
				},
				["main"] = {
					["type"] = "preset",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["colorR"] = 1,
					["duration"] = "0.2",
					["alphaType"] = "straight",
					["colorA"] = 1,
					["colorG"] = 1,
					["alphaFunc"] = "function(progress, start, delta)\n    return start + (progress * delta)\nend\n",
					["use_alpha"] = true,
					["type"] = "custom",
					["easeType"] = "none",
					["scaley"] = 1,
					["alpha"] = 0,
					["y"] = 0,
					["x"] = 0,
					["scalex"] = 1,
					["preset"] = "fade",
					["easeStrength"] = 3,
					["rotate"] = 0,
					["colorB"] = 1,
					["duration_type"] = "seconds",
				},
			},
		},
		["Threat List"] = {
			["grow"] = "DOWN",
			["controlledChildren"] = {
				"Info - ThreatSituation", -- [1]
			},
			["borderBackdrop"] = "Solid",
			["xOffset"] = -375,
			["preferToUpdate"] = false,
			["groupIcon"] = "133473",
			["gridType"] = "RD",
			["fullCircle"] = true,
			["space"] = 1,
			["url"] = "https://wago.io/xfKIUqvJH/2",
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
						["subeventPrefix"] = "SPELL",
						["names"] = {
						},
						["event"] = "Health",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["columnSpace"] = 1,
			["internalVersion"] = 70,
			["limit"] = 5,
			["selfPoint"] = "TOP",
			["align"] = "CENTER",
			["anchorFrameFrame"] = "PlayerFrame",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["rowSpace"] = 1,
			["stagger"] = 0,
			["useLimit"] = false,
			["version"] = 2,
			["subRegions"] = {
			},
			["authorOptions"] = {
			},
			["anchorPoint"] = "CENTER",
			["load"] = {
				["use_class"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["yOffset"] = 250,
			["backdropColor"] = {
				0.086274509803922, -- [1]
				0.090196078431373, -- [2]
				0.10196078431373, -- [3]
				0.65000000596047, -- [4]
			},
			["uid"] = "WiRsd0lRNQ2",
			["source"] = "import",
			["borderInset"] = 1,
			["scale"] = 1.2,
			["centerType"] = "LR",
			["border"] = false,
			["borderEdge"] = "Blizzard Tooltip",
			["stepAngle"] = 15,
			["borderSize"] = 5,
			["sort"] = "none",
			["animate"] = false,
			["gridWidth"] = 5,
			["constantFactor"] = "RADIUS",
			["arcLength"] = 360,
			["borderOffset"] = 4,
			["semver"] = "1.0.1",
			["tocversion"] = 11305,
			["id"] = "Threat List",
			["regionType"] = "dynamicgroup",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["rotation"] = 0,
			["config"] = {
			},
			["radius"] = 200,
			["borderColor"] = {
				0.086274509803922, -- [1]
				0.090196078431373, -- [2]
				0.10196078431373, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["sortHybridTable"] = {
				["Info - ThreatSituation"] = false,
			},
		},
		["Professions Skill Tracker"] = {
			["grow"] = "UP",
			["controlledChildren"] = {
				"PST bar", -- [1]
			},
			["borderBackdrop"] = "None",
			["xOffset"] = -10,
			["preferToUpdate"] = false,
			["yOffset"] = 20,
			["gridType"] = "RD",
			["anchorPerUnit"] = "NAMEPLATE",
			["fullCircle"] = true,
			["space"] = 20,
			["url"] = "https://wago.io/XvH-Hqsxz/5",
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
						["unit"] = "player",
						["type"] = "aura2",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["names"] = {
						},
						["event"] = "Health",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["columnSpace"] = 1,
			["internalVersion"] = 70,
			["anchorFrameFrame"] = "ChatFrame3",
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
			},
			["align"] = "RIGHT",
			["authorOptions"] = {
			},
			["useLimit"] = false,
			["useAnchorPerUnit"] = false,
			["rotation"] = 0,
			["selfPoint"] = "BOTTOMRIGHT",
			["version"] = 5,
			["subRegions"] = {
			},
			["stagger"] = 0,
			["rowSpace"] = 1,
			["load"] = {
				["use_class"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
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
			["borderInset"] = 1,
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["anchorPoint"] = "TOPRIGHT",
			["animate"] = false,
			["centerType"] = "LR",
			["scale"] = 1,
			["customAnchor"] = "ChatFrame3",
			["border"] = false,
			["borderEdge"] = "1 Pixel",
			["regionType"] = "dynamicgroup",
			["borderSize"] = 2,
			["sort"] = "none",
			["gridWidth"] = 5,
			["limit"] = 5,
			["constantFactor"] = "RADIUS",
			["arcLength"] = 360,
			["borderOffset"] = 4,
			["semver"] = "1.0.4",
			["tocversion"] = 11302,
			["id"] = "Professions Skill Tracker",
			["stepAngle"] = 15,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SELECTFRAME",
			["radius"] = 200,
			["uid"] = "6GCI4uu)d8g",
			["config"] = {
			},
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["groupIcon"] = 132281,
		},
		["PST bar"] = {
			["sparkWidth"] = 10,
			["iconSource"] = 0,
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["url"] = "https://wago.io/XvH-Hqsxz/5",
			["icon"] = false,
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["useTooltip"] = true,
			["selfPoint"] = "CENTER",
			["barColor"] = {
				0, -- [1]
				0.65882352941177, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["sparkOffsetY"] = 0,
			["gradientOrientation"] = "HORIZONTAL",
			["load"] = {
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
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
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["sparkDesaturate"] = false,
			["texture"] = "xVerminClean",
			["zoom"] = 0,
			["auto"] = false,
			["tocversion"] = 11302,
			["alpha"] = 1,
			["config"] = {
			},
			["displayIcon"] = 136000,
			["sparkOffsetX"] = 0,
			["parent"] = "Professions Skill Tracker",
			["adjustedMin"] = 62,
			["sparkRotationMode"] = "AUTO",
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["subeventSuffix"] = "_CAST_START",
						["debuffType"] = "HELPFUL",
						["event"] = "Health",
						["names"] = {
						},
						["custom_type"] = "stateupdate",
						["custom"] = "function(allstates, event, ...)\n    if event == \"OPTIONS\" then return false end\n    if event == \"CHAT_MSG_SKILL\" or event == \"SKILL_LINES_CHANGED\" then\n        local btns = aura_env.pst_btns\n        local profs = aura_env.pst_profs\n        for i=1,GetNumSkillLines() do\n            local skillName, isHeader, isExpanded, skillRank, numTempPoints, skillModifier,\n            skillMaxRank, isAbandonable, stepCost, rankCost, minLevel, skillCostType, skillDescription = GetSkillLineInfo(i)\n            if profs[skillName] and profs[skillName]['spell'] then\n                allstates[skillName] = allstates[skillName] or {}\n                local state = allstates[skillName] \n                if state.value == skillRank and state.total == skillMaxRank then state.changed = false\n                else\n                    state.name = skillName\n                    state.value = skillRank\n                    state.progressType = 'static'\n                    state.total = skillMaxRank\n                    state.custom = skillRank .. \" / \" .. skillMaxRank\n                    state.index = i\n                    --state.autoHide = true\n                    state.animation = true\n                    state.show = true\n                    state.changed = true\n                end\n            end \n        end\n        --        C_Timer.After(3, function()\n        --                for clId, clRegion in pairs(WeakAuras.clones['PST bar']) do\n        --                    if not btns[clId] then            \n        --                        btns[clId] = CreateFrame(\"Button\", nil, UIParent, \"SecureActionButtonTemplate\")            \n        --                        btns[clId]:SetNormalTexture(profs[clId]['icon'])\n        --                        if profs[clId]['spell'] ~= 'none' then\n        --                            btns[clId]:SetAttribute(\"type\", \"spell\")\n        --                            btns[clId]:SetAttribute(\"spell\", profs[clId]['spell'])\n        --                        end\n        --                    end\n        --                    local point, relativeTo, relativePoint, xOfs, yOfs = clRegion:GetPoint()\n        --                    btns[clId]:SetPoint(point, relativeTo, relativePoint, xOfs-30, yOfs+15)\n        --                    btns[clId]:SetWidth(clRegion:GetHeight()+15)\n        --                    btns[clId]:SetHeight(clRegion:GetHeight()+15)\n        --                end\n        --        end)\n    end\n    return true\nend",
						["spellIds"] = {
						},
						["events"] = "CHAT_MSG_SKILL, SKILL_LINES_CHANGED",
						["check"] = "event",
						["subeventPrefix"] = "SPELL",
						["unit"] = "player",
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["colorR"] = 1,
					["scalex"] = 1,
					["alphaType"] = "straight",
					["colorB"] = 0.4078431372549,
					["colorG"] = 0,
					["alphaFunc"] = "    function(progress, start, delta)\n      return start + (progress * delta)\n    end\n  ",
					["use_alpha"] = true,
					["type"] = "none",
					["easeType"] = "none",
					["use_color"] = true,
					["scaley"] = 1,
					["alpha"] = 0,
					["x"] = 0,
					["y"] = 0,
					["colorType"] = "pulseColor",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["colorFunc"] = "    function(progress, r1, g1, b1, a1, r2, g2, b2, a2)\n      local angle = (progress * 2 * math.pi) - (math.pi / 2)\n      local newProgress = ((math.sin(angle) + 1)/2);\n      return r1 + (newProgress * (r2 - r1)),\n           g1 + (newProgress * (g2 - g1)),\n           b1 + (newProgress * (b2 - b1)),\n           a1 + (newProgress * (a2 - a1))\n    end\n  ",
					["rotate"] = 0,
					["preset"] = "shrink",
					["colorA"] = 1,
				},
				["main"] = {
					["colorR"] = 1,
					["scalex"] = 1,
					["alphaType"] = "straight",
					["colorB"] = 0.51372549019608,
					["colorG"] = 0,
					["alphaFunc"] = "    function(progress, start, delta)\n      return start + (progress * delta)\n    end\n  ",
					["use_alpha"] = false,
					["type"] = "custom",
					["colorA"] = 1,
					["easeType"] = "none",
					["duration_type"] = "seconds",
					["scaley"] = 1,
					["alpha"] = 0,
					["easeStrength"] = 3,
					["y"] = 0,
					["x"] = 0,
					["preset"] = "alphaPulse",
					["use_color"] = true,
					["colorFunc"] = "function(progress, r1, g1, b1, a1, r2, g2, b2, a2)    \n    if aura_env.state.animation then\n        local angle = (progress *  2 * math.pi) - (math.pi / 2)\n        local newProgress = ((math.sin(angle) + 1)/2);\n        if newProgress == 0 then aura_env.state.animation = false end\n        return r1 + (newProgress * (r2 - r1)), g1 + (newProgress * (g2 - g1)), b1 + (newProgress * (b2 - b1)), a1 + (newProgress * (a2 - a1))\n    end    \nend",
					["rotate"] = 0,
					["colorType"] = "custom",
					["duration"] = "",
				},
				["finish"] = {
					["colorR"] = 1,
					["scalex"] = 1,
					["colorA"] = 1,
					["colorG"] = 0.10196078431373,
					["type"] = "none",
					["scaley"] = 1,
					["easeType"] = "none",
					["use_color"] = true,
					["preset"] = "grow",
					["alpha"] = 0,
					["easeStrength"] = 3,
					["y"] = 0,
					["x"] = 0,
					["duration_type"] = "seconds",
					["duration"] = "2",
					["colorFunc"] = "    function(progress, r1, g1, b1, a1, r2, g2, b2, a2)\n      local angle = (progress * 2 * math.pi) - (math.pi / 2)\n      local newProgress = ((math.sin(angle) + 1)/2);\n      return r1 + (newProgress * (r2 - r1)),\n           g1 + (newProgress * (g2 - g1)),\n           b1 + (newProgress * (b2 - b1)),\n           a1 + (newProgress * (a2 - a1))\n    end\n  ",
					["rotate"] = 0,
					["colorType"] = "pulseColor",
					["colorB"] = 0,
				},
			},
			["version"] = 5,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_shadowXOffset"] = 1,
					["text_text"] = "%custom",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "RIGHT",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_anchorYOffset"] = 8,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "RIGHT",
					["text_text_format_custom_format"] = "none",
					["text_shadowYOffset"] = -1,
					["text_fontSize"] = 10,
					["anchorXOffset"] = 0,
					["text_fontType"] = "None",
				}, -- [2]
				{
					["text_shadowXOffset"] = 1,
					["text_text"] = "%n",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "LEFT",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "LEFT",
					["text_text_format_n_format"] = "none",
					["text_anchorYOffset"] = 8,
					["text_fontSize"] = 10,
					["anchorXOffset"] = 0,
					["text_visible"] = true,
				}, -- [3]
				{
					["type"] = "subforeground",
					["text_shadowColor"] = {
					},
					["text_color"] = {
					},
				}, -- [4]
			},
			["height"] = 2,
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["barColor2"] = {
				1, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["icon_side"] = "LEFT",
			["adjustedMax"] = 51,
			["actions"] = {
				["start"] = {
					["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\CatMeow2.ogg",
					["do_sound"] = false,
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "function define()\n    local profs = {}\n    local result = {}\n    local associated_spells_icons = {['spell'] = {'same', 'same', 'same', 'same', 'same', 'same', 'same', 'none', 'same', GetSpellInfo(2656), 'none', 'same', 'none', 'none'}, ['icon'] = {136240, 136241, 133971, 136244, 136243, 135966, 136245, 133939, 133611, 136248, 134366, 136249}}\n    \n    profs = {'Alchemy', 'Blacksmithing', 'Cooking', 'Enchanting', 'Engineering', 'First Aid', 'Fishing', 'Herbalism', 'Leatherworking', 'Mining', 'Skinning', 'Tailoring', 'Inscription', 'Jewelcrafting'}\n    \n    for i, val in ipairs(profs) do\n        \n        if associated_spells_icons['spell'][i] == 'same' then            \n            result[val] =  {['spell'] = val, ['icon'] = associated_spells_icons['icon'][i]}\n        elseif associated_spells_icons['spell'][i] == 'none' then\n            result[val] =  {['spell'] = 'none', ['icon'] = associated_spells_icons['icon'][i]}\n        else result[val] = {['spell'] = associated_spells_icons['spell'][i], ['icon'] = associated_spells_icons['icon'][i]}\n        end\n    end\n    return result\nend\n\naura_env.pst_btns = aura_env.pst_btns or {}\naura_env.pst_profs = aura_env.pst_profs or define()",
					["do_custom"] = true,
				},
			},
			["anchorFrameParent"] = false,
			["backgroundColor"] = {
				0.031372549019608, -- [1]
				0.39607843137255, -- [2]
				0.79607843137255, -- [3]
				0.3313250541687, -- [4]
			},
			["enableGradient"] = false,
			["id"] = "PST bar",
			["semver"] = "1.0.4",
			["spark"] = true,
			["sparkHidden"] = "NEVER",
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 1,
			["width"] = 250,
			["color"] = {
			},
			["sparkTexture"] = "Legionfall_BarSpark",
			["inverse"] = false,
			["uid"] = "dfN5x1GBI6G",
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["sparkHeight"] = 10,
		},
		["Citrine"] = {
			["iconSource"] = -1,
			["xOffset"] = 80,
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["url"] = "https://wago.io/U0WH3IJ3S/1",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["custom"] = "local text = aura_env.config.macro.text\n\naura_env.button = CreateFrame(\"Button\", \"buffButton\", aura_env.region, \"SecureActionButtonTemplate\")\naura_env.button:SetAllPoints()\naura_env.button:SetAttribute(\"unit\", \"player\")\naura_env.button:SetAttribute(\"type\",\"macro\")\naura_env.button:SetAttribute(\"macrotext\", text)",
					["do_custom"] = true,
				},
				["finish"] = {
					["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\CartoonWalking.ogg",
					["do_sound"] = false,
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["event"] = "Conditions",
						["subeventPrefix"] = "SPELL",
						["spellIds"] = {
						},
						["names"] = {
						},
						["use_unit"] = true,
						["unit"] = "player",
						["unevent"] = "auto",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["itemName"] = 8007,
						["use_count"] = true,
						["unevent"] = "auto",
						["use_exact_itemName"] = true,
						["duration"] = "1",
						["use_itemName"] = true,
						["use_unit"] = true,
						["use_includeBank"] = false,
						["type"] = "item",
						["count"] = "0",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["event"] = "Item Count",
						["subeventSuffix"] = "_CAST_START",
						["count_operator"] = "==",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["customTriggerLogic"] = "",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.25,
					["glow"] = true,
					["useGlowColor"] = false,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowDuration"] = 1,
					["type"] = "subglow",
					["glowThickness"] = 1,
					["glowScale"] = 1,
					["glowXOffset"] = 0,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [2]
			},
			["height"] = 40,
			["load"] = {
				["use_level"] = true,
				["talent"] = {
					["single"] = 9,
					["multi"] = {
						[9] = true,
					},
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["use_class"] = false,
				["use_spellknown"] = false,
				["zoneIds"] = "",
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["MAGE"] = true,
					},
				},
				["use_never"] = false,
				["level"] = {
					"48", -- [1]
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
			["authorMode"] = true,
			["zoom"] = 0,
			["config"] = {
				["macro"] = {
					["text"] = "/cast Conjure Mana Citrine",
				},
			},
			["parent"] = "GEMS",
			["icon"] = true,
			["regionType"] = "icon",
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["displayIcon"] = 134116,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
				{
					["subOptions"] = {
						{
							["type"] = "input",
							["useDesc"] = false,
							["width"] = 1,
							["name"] = "Text",
							["default"] = "",
							["multiline"] = false,
							["length"] = 10,
							["key"] = "text",
							["useLength"] = false,
						}, -- [1]
					},
					["hideReorder"] = true,
					["useDesc"] = false,
					["nameSource"] = 0,
					["width"] = 1,
					["useCollapse"] = false,
					["collapse"] = false,
					["name"] = "Macro",
					["key"] = "macro",
					["limitType"] = "none",
					["groupType"] = "simple",
					["type"] = "group",
					["size"] = 10,
				}, -- [1]
			},
			["anchorFrameType"] = "SCREEN",
			["alpha"] = 1,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.0.0",
			["tocversion"] = 11304,
			["id"] = "Citrine",
			["auto"] = true,
			["useCooldownModRate"] = true,
			["width"] = 40,
			["frameStrata"] = 1,
			["uid"] = "fPDDaU)G8Wc",
			["inverse"] = false,
			["cooldownEdge"] = false,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 2,
						["variable"] = "show",
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
						["trigger"] = 2,
						["variable"] = "show",
						["value"] = 0,
					},
					["changes"] = {
						{
							["property"] = "alpha",
						}, -- [1]
					},
				}, -- [2]
			},
			["cooldown"] = false,
			["selfPoint"] = "CENTER",
		},
		["DEBUFFS - TARGET"] = {
			["arcLength"] = 360,
			["controlledChildren"] = {
				"targetdebuffs ", -- [1]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = -30,
			["anchorPoint"] = "BOTTOMLEFT",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["space"] = 4,
			["url"] = "https://wago.io/W1QyYtaAz/1",
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
						["subeventPrefix"] = "SPELL",
						["names"] = {
						},
						["event"] = "Health",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["columnSpace"] = 1,
			["radius"] = 200,
			["selfPoint"] = "LEFT",
			["align"] = "CENTER",
			["limit"] = 5,
			["stagger"] = 0,
			["rowSpace"] = 1,
			["version"] = 1,
			["subRegions"] = {
			},
			["useLimit"] = false,
			["gridType"] = "RD",
			["load"] = {
				["talent"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["internalVersion"] = 70,
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["authorOptions"] = {
			},
			["animate"] = false,
			["fullCircle"] = true,
			["scale"] = 1,
			["centerType"] = "LR",
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["stepAngle"] = 15,
			["borderSize"] = 2,
			["sort"] = "none",
			["uid"] = "8aXp4Du0m4R",
			["config"] = {
			},
			["anchorFrameParent"] = true,
			["constantFactor"] = "RADIUS",
			["gridWidth"] = 5,
			["borderOffset"] = 4,
			["semver"] = "1.0.0",
			["tocversion"] = 90001,
			["id"] = "DEBUFFS - TARGET",
			["anchorFrameFrame"] = "nHealthStatusBar",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SELECTFRAME",
			["regionType"] = "dynamicgroup",
			["borderInset"] = 1,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["grow"] = "RIGHT",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["rotation"] = 0,
		},
		["Rage Bar"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -300,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["url"] = "https://wago.io/HCaWT5tJa/14",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["custom"] = "if aura_env.region then\n    local r = aura_env.region\n    if not r.text3 then\n        local text3 = r.bar:CreateFontString(nil, \"OVERLAY\")\n        r.text3 = text3\n        r.text3:SetJustifyH(\"CENTER\")\n        r.text3:SetJustifyV(\"MIDDLE\")\n        r.text3:SetPoint(\"CENTER\", r.bar, \"CENTER\")\n        r.text3:Show()\n    end\n    r.text3:SetShadowOffset(1, -1)\n    r.text3:SetFont(r.text:GetFont())\n    r.text3:SetTextColor(r.text:GetTextColor())\nend\n\n\n\n\n\n\n",
					["do_custom"] = false,
				},
				["finish"] = {
				},
			},
			["fontFlags"] = "OUTLINE",
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["enableGradient"] = false,
			["selfPoint"] = "CENTER",
			["barColor"] = {
				1, -- [1]
				0.011764705882353, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["sparkOffsetY"] = 0,
			["gradientOrientation"] = "HORIZONTAL",
			["load"] = {
				["zoneIds"] = "",
				["ingroup"] = {
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
					["single"] = "DRUID",
					["multi"] = {
						["WARRIOR"] = true,
						["DRUID"] = true,
					},
				},
				["use_petbattle"] = false,
				["role"] = {
					["multi"] = {
					},
				},
				["use_class"] = false,
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
				["difficulty"] = {
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
				["talent2"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["texture"] = "xVerminClean",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["spark"] = false,
			["tocversion"] = 11302,
			["alpha"] = 1,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["sparkOffsetX"] = 0,
			["parent"] = "MANA BAR + DRUID / ROGUE CPOINTS",
			["customText"] = "",
			["customTextUpdate"] = "event",
			["triggers"] = {
				{
					["trigger"] = {
						["use_power"] = false,
						["genericShowOn"] = "showOnActive",
						["unit"] = "player",
						["powertype"] = 1,
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
						["names"] = {
						},
						["type"] = "unit",
						["use_health"] = true,
						["unevent"] = "auto",
						["health_operator"] = ">=",
						["use_unit"] = true,
						["use_requirePowerType"] = true,
						["use_percentpower"] = false,
						["duration"] = "1",
						["health"] = "0",
						["spellIds"] = {
						},
						["event"] = "Power",
						["subeventSuffix"] = "_CAST_START",
						["custom_hide"] = "timed",
						["subeventPrefix"] = "SPELL",
						["use_showCost"] = true,
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "all",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
			},
			["backdropInFront"] = false,
			["stickyDuration"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subforeground",
				}, -- [2]
				{
					["text_shadowXOffset"] = 1,
					["text_text"] = "%p",
					["text_text_format_t_time_legacy_floor"] = false,
					["text_text_format_t_time_dynamic_threshold"] = 60,
					["text_text_format_p_format"] = "timed",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_text_format_c_format"] = "none",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_t_time_format"] = 0,
					["text_text_format_p_time_legacy_floor"] = false,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_t_format"] = "timed",
					["text_text_format_p_time_mod_rate"] = true,
					["text_fontType"] = "None",
					["type"] = "subtext",
					["text_visible"] = true,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Arial Narrow",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_shadowYOffset"] = -1,
					["text_text_format_p_time_format"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_text_format_t_time_mod_rate"] = true,
					["text_anchorPoint"] = "INNER_RIGHT",
					["text_text_format_p_time_precision"] = 1,
					["anchorYOffset"] = 0,
					["text_fontSize"] = 15,
					["anchorXOffset"] = 0,
					["text_text_format_t_time_precision"] = 1,
				}, -- [3]
				{
					["text_shadowXOffset"] = 1,
					["text_text"] = " ",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Arial Narrow",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_LEFT",
					["text_fontSize"] = 18,
					["anchorXOffset"] = 0,
					["text_fontType"] = "None",
				}, -- [4]
				{
					["text_shadowXOffset"] = 1,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Arial Narrow",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "ICON_CENTER",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_fontType"] = "None",
				}, -- [5]
			},
			["height"] = 20,
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["uid"] = "EfHcVtp57kn",
			["barColor2"] = {
				1, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["overlays"] = {
				{
					0.43529411764706, -- [1]
					0, -- [2]
					1, -- [3]
					0.25, -- [4]
				}, -- [1]
			},
			["backdropColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["borderInFront"] = true,
			["borderBackdrop"] = "None",
			["icon_side"] = "RIGHT",
			["sparkRotationMode"] = "AUTO",
			["icon"] = false,
			["sparkHeight"] = 30,
			["zoom"] = 0,
			["overlaysTexture"] = {
				"xVerminClean", -- [1]
			},
			["width"] = 245,
			["semver"] = "1.0.13",
			["id"] = "Rage Bar",
			["sparkHidden"] = "NEVER",
			["config"] = {
			},
			["frameStrata"] = 3,
			["anchorFrameType"] = "SCREEN",
			["auto"] = true,
			["backgroundColor"] = {
				1, -- [1]
				0.011764705882353, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["inverse"] = false,
			["sparkDesature"] = false,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["xOffset"] = 0.0003662109375,
		},
		["Thorns"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["wagoID"] = "v9qxdDgI4",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["sparkHidden"] = "NEVER",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["sparkOffsetX"] = 0,
			["cooldownSwipe"] = true,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Thorns", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showOnReady",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
						["matchesShowOn"] = "showOnMissing",
						["type"] = "aura2",
						["unevent"] = "auto",
						["subeventSuffix"] = "_CAST_START",
						["names"] = {
						},
						["unit"] = "player",
						["event"] = "Action Usable",
						["useName"] = true,
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_genericShowOn"] = true,
						["spellName"] = 34428,
						["subeventPrefix"] = "SPELL",
						["use_track"] = true,
						["useIgnoreName"] = false,
					},
					["untrigger"] = {
						["genericShowOn"] = "showOnReady",
					},
				}, -- [1]
				{
					["trigger"] = {
						["unit"] = "player",
						["rem"] = "30",
						["debuffType"] = "HELPFUL",
						["auranames"] = {
							"Thorns", -- [1]
						},
						["remOperator"] = "<=",
						["useName"] = true,
						["type"] = "aura2",
						["useRem"] = true,
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
			["internalVersion"] = 70,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["parent"] = "Vermin Druid",
			["authorOptions"] = {
			},
			["barColor"] = {
				0.2, -- [1]
				1, -- [2]
				0.0862745098039216, -- [3]
				1, -- [4]
			},
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["useTooltip"] = false,
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.5,
					["type"] = "subglow",
					["glowDuration"] = 1,
					["text_color"] = {
					},
					["glowThickness"] = 3,
					["useGlowColor"] = true,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0.7058823704719543, -- [2]
						0.01568627543747425, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["glowScale"] = 1,
					["glow"] = true,
					["glowLength"] = 16,
					["glowType"] = "buttonOverlay",
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "%p",
					["text_text_format_p_time_mod_rate"] = true,
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_format"] = "timed",
					["type"] = "subtext",
					["anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "OUTER_TOP",
					["text_shadowXOffset"] = 0,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 10,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
				}, -- [3]
			},
			["height"] = 36,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeType"] = "none",
					["duration_type"] = "seconds",
					["preset"] = "bounceDecay",
					["easeStrength"] = 3,
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["load"] = {
				["use_level"] = false,
				["talent"] = {
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
				["use_class"] = true,
				["use_spellknown"] = true,
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
					},
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["use_never"] = false,
				["level"] = {
					"5", -- [1]
				},
				["spellknown"] = 467,
				["zoneIds"] = "",
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["desaturate"] = false,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["conditions"] = {
			},
			["smoothProgress"] = true,
			["anchorFrameFrame"] = "PlayerFrame",
			["regionType"] = "icon",
			["frameStrata"] = 1,
			["config"] = {
			},
			["icon_side"] = "RIGHT",
			["useAdjustededMin"] = false,
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["sparkHeight"] = 30,
			["texture"] = "Melli",
			["width"] = 36,
			["cooldownTextDisabled"] = false,
			["auto"] = false,
			["alpha"] = 1,
			["id"] = "Thorns",
			["anchorFrameParent"] = false,
			["useCooldownModRate"] = true,
			["anchorFrameType"] = "SCREEN",
			["xOffset"] = 0,
			["uid"] = "pqBqMLrgAw1",
			["inverse"] = false,
			["zoom"] = 0,
			["orientation"] = "HORIZONTAL",
			["displayIcon"] = "",
			["cooldown"] = false,
			["spark"] = false,
		},
		["Truesilver Ore"] = {
			["iconSource"] = -1,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = false,
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
						["itemName"] = 7911,
						["use_count"] = true,
						["duration"] = "1",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["type"] = "item",
						["subeventSuffix"] = "_CAST_START",
						["use_exact_itemName"] = true,
						["unit"] = "player",
						["event"] = "Item Count",
						["use_unit"] = true,
						["use_includeBank"] = true,
						["spellIds"] = {
						},
						["count"] = "0",
						["unevent"] = "auto",
						["use_absorbMode"] = true,
						["use_itemName"] = true,
						["names"] = {
						},
						["count_operator"] = ">",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_anchorYOffset"] = 0,
					["type"] = "subtext",
					["text_anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "PT Sans Narrow",
					["anchorXOffset"] = 0,
					["text_shadowYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_fontSize"] = 16,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_shadowXOffset"] = 0,
				}, -- [2]
				{
					["glowFrequency"] = 0,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowDuration"] = 1,
					["useGlowColor"] = false,
					["glow"] = true,
					["glowThickness"] = 1,
					["glowScale"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 40,
			["load"] = {
				["use_namerealm"] = true,
				["ingroup"] = {
					["single"] = "solo",
				},
				["namerealm"] = "Mxzq",
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["use_ingroup"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["use_never"] = true,
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["source"] = "import",
			["uid"] = "vxG)cuf9NrH",
			["icon"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["information"] = {
				["forceEvents"] = true,
			},
			["url"] = "https://wago.io/iST6tz9t8/1",
			["useTooltip"] = true,
			["parent"] = "Ore Count",
			["anchorFrameParent"] = false,
			["cooldownTextDisabled"] = false,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["semver"] = "1.0.0",
			["tocversion"] = 90002,
			["id"] = "Truesilver Ore",
			["useCooldownModRate"] = true,
			["alpha"] = 1,
			["width"] = 40,
			["frameStrata"] = 1,
			["config"] = {
			},
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["conditions"] = {
			},
			["cooldown"] = false,
			["xOffset"] = 0,
		},
		["Loss of Control Alert (WOTLK)"] = {
			["controlledChildren"] = {
				"Loss of Control Background", -- [1]
				"Loss of Control Top", -- [2]
				"Loss of Control Bottom", -- [3]
				"Loss of Control Alert", -- [4]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["wagoID"] = "JiQILDF99",
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = 83.33333333333333,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["url"] = "https://wago.io/JiQILDF99/1",
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
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["event"] = "Health",
						["names"] = {
						},
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["version"] = 1,
			["subRegions"] = {
			},
			["load"] = {
				["talent"] = {
					["multi"] = {
					},
				},
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
			["source"] = "import",
			["scale"] = 1.2,
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "group",
			["borderSize"] = 2,
			["borderOffset"] = 4,
			["semver"] = "1.0.0",
			["tocversion"] = 30400,
			["id"] = "Loss of Control Alert (WOTLK)",
			["authorOptions"] = {
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["groupIcon"] = 136071,
			["config"] = {
			},
			["uid"] = "RaWaTrdL9bd",
			["borderInset"] = 1,
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["selfPoint"] = "CENTER",
		},
		["Jade"] = {
			["iconSource"] = -1,
			["xOffset"] = 40,
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["url"] = "https://wago.io/U0WH3IJ3S/1",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["event"] = "Conditions",
						["subeventPrefix"] = "SPELL",
						["spellIds"] = {
						},
						["names"] = {
						},
						["use_unit"] = true,
						["unit"] = "player",
						["unevent"] = "auto",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "item",
						["use_count"] = true,
						["unevent"] = "auto",
						["use_exact_itemName"] = true,
						["duration"] = "1",
						["use_itemName"] = true,
						["unit"] = "player",
						["use_includeBank"] = false,
						["itemName"] = 5513,
						["count"] = "0",
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["event"] = "Item Count",
						["subeventSuffix"] = "_CAST_START",
						["count_operator"] = "==",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["customTriggerLogic"] = "",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.25,
					["glow"] = true,
					["useGlowColor"] = false,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowDuration"] = 1,
					["type"] = "subglow",
					["glowThickness"] = 1,
					["glowScale"] = 1,
					["glowXOffset"] = 0,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [2]
			},
			["height"] = 40,
			["load"] = {
				["use_level"] = true,
				["talent"] = {
					["single"] = 9,
					["multi"] = {
						[9] = true,
					},
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["use_class"] = false,
				["use_spellknown"] = false,
				["zoneIds"] = "",
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["MAGE"] = true,
					},
				},
				["use_never"] = false,
				["level"] = {
					"18", -- [1]
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
			["authorMode"] = true,
			["zoom"] = 0,
			["config"] = {
				["macro"] = {
					["text"] = "/cast Conjure Mana Jade",
				},
			},
			["parent"] = "GEMS",
			["authorOptions"] = {
				{
					["subOptions"] = {
						{
							["type"] = "input",
							["useDesc"] = false,
							["width"] = 1,
							["name"] = "Text",
							["default"] = "",
							["multiline"] = false,
							["length"] = 10,
							["key"] = "text",
							["useLength"] = false,
						}, -- [1]
					},
					["hideReorder"] = true,
					["useDesc"] = false,
					["nameSource"] = 0,
					["width"] = 1,
					["useCollapse"] = false,
					["collapse"] = false,
					["name"] = "Macro",
					["key"] = "macro",
					["limitType"] = "none",
					["groupType"] = "simple",
					["type"] = "group",
					["size"] = 10,
				}, -- [1]
			},
			["regionType"] = "icon",
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["displayIcon"] = 134105,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["cooldownEdge"] = false,
			["width"] = 40,
			["alpha"] = 1,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.0.0",
			["tocversion"] = 11304,
			["id"] = "Jade",
			["auto"] = true,
			["useCooldownModRate"] = true,
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 1,
			["uid"] = "ToLYidE5fIK",
			["inverse"] = false,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["custom"] = "local text = aura_env.config.macro.text\n\naura_env.button = CreateFrame(\"Button\", \"buffButton\", aura_env.region, \"SecureActionButtonTemplate\")\naura_env.button:SetAllPoints()\naura_env.button:SetAttribute(\"unit\", \"player\")\naura_env.button:SetAttribute(\"type\",\"macro\")\naura_env.button:SetAttribute(\"macrotext\", text)",
					["do_custom"] = true,
				},
				["finish"] = {
					["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\CartoonWalking.ogg",
					["do_sound"] = false,
				},
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 2,
						["variable"] = "show",
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
						["trigger"] = 2,
						["variable"] = "show",
						["value"] = 0,
					},
					["changes"] = {
						{
							["property"] = "alpha",
						}, -- [1]
					},
				}, -- [2]
			},
			["cooldown"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
		},
		["Loss of Control Bottom"] = {
			["wagoID"] = "JiQILDF99",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -42,
			["anchorPoint"] = "CENTER",
			["url"] = "https://wago.io/JiQILDF99/1",
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
						["type"] = "custom",
						["custom_type"] = "event",
						["custom_hide"] = "custom",
						["event"] = "Health",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["events"] = "LOSS_OF_CONTROL_UPDATE",
						["names"] = {
						},
						["check"] = "event",
						["spellIds"] = {
						},
						["custom"] = "function (allstates, event, ...)\n    local activeLossOfControlCount = C_LossOfControl.GetActiveLossOfControlDataCount()\n    if activeLossOfControlCount > 0 then return true end\n    return false\nend",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
						["custom"] = "function (allstates, event, ...)\n    local activeLossOfControlCount = C_LossOfControl.GetActiveLossOfControlDataCount()\n    if activeLossOfControlCount <= 0 then return true end\n    return false\nend",
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["colorR"] = 1,
					["duration"] = "0.2",
					["alphaType"] = "straight",
					["colorA"] = 1,
					["colorG"] = 1,
					["alphaFunc"] = "function(progress, start, delta)\n    return start + (progress * delta)\nend\n",
					["use_alpha"] = true,
					["type"] = "custom",
					["easeType"] = "none",
					["scaley"] = 1,
					["alpha"] = 0,
					["y"] = 0,
					["x"] = 0,
					["scalex"] = 1,
					["preset"] = "fade",
					["easeStrength"] = 3,
					["rotate"] = 0,
					["colorB"] = 1,
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["colorR"] = 1,
					["duration"] = "0.2",
					["alphaType"] = "straight",
					["colorA"] = 1,
					["colorG"] = 1,
					["alphaFunc"] = "function(progress, start, delta)\n    return start + (progress * delta)\nend\n",
					["use_alpha"] = true,
					["type"] = "custom",
					["easeType"] = "none",
					["scaley"] = 1,
					["alpha"] = 0,
					["y"] = 0,
					["x"] = 0,
					["scalex"] = 1,
					["preset"] = "fade",
					["easeStrength"] = 3,
					["rotate"] = 0,
					["colorB"] = 1,
					["duration_type"] = "seconds",
				},
			},
			["desaturate"] = false,
			["rotation"] = 180,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 30,
			["rotate"] = false,
			["load"] = {
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
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
			["textureWrapMode"] = "CLAMPTOBLACKADDITIVE",
			["source"] = "import",
			["mirror"] = false,
			["regionType"] = "texture",
			["blendMode"] = "ADD",
			["color"] = {
				1, -- [1]
				0, -- [2]
				0.007843137254902, -- [3]
				1, -- [4]
			},
			["discrete_rotation"] = 180,
			["texture"] = "Interface\\Cooldown\\Loc-RedLine",
			["xOffset"] = 0,
			["displayIcon"] = 136071,
			["semver"] = "1.0.0",
			["tocversion"] = 30400,
			["id"] = "Loss of Control Bottom",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["width"] = 200,
			["config"] = {
			},
			["uid"] = "MZtnL7eKvGn",
			["parent"] = "Loss of Control Alert (WOTLK)",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["selfPoint"] = "CENTER",
		},
		["Warrior - Shield Equipped"] = {
			["iconSource"] = -1,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = 300,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["url"] = "https://wago.io/PaRAjwLdm/1",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "item",
						["use_itemTypeName"] = true,
						["unevent"] = "auto",
						["itemTypeName"] = {
							["single"] = 1030,
						},
						["duration"] = "1",
						["use_itemName"] = true,
						["use_unit"] = true,
						["names"] = {
						},
						["unit"] = "player",
						["spellIds"] = {
						},
						["event"] = "Item Type Equipped",
						["subeventPrefix"] = "SPELL",
						["itemName"] = 0,
						["subeventSuffix"] = "_CAST_START",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_shadowXOffset"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "SHIELD",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "INNER_BOTTOM",
					["text_fontSize"] = 27,
					["anchorXOffset"] = 0,
					["text_visible"] = false,
				}, -- [2]
				{
					["glowFrequency"] = 0.25,
					["type"] = "subglow",
					["glowDuration"] = 1,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["useGlowColor"] = false,
					["glowXOffset"] = 0,
					["glow"] = true,
					["glowThickness"] = 1,
					["glowScale"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 100,
			["load"] = {
				["use_class"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["size"] = {
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
				["zoneIds"] = "",
			},
			["source"] = "import",
			["cooldownTextDisabled"] = false,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["regionType"] = "icon",
			["xOffset"] = -300,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["displayIcon"] = 134952,
			["uid"] = "R)Jj9eCABj8",
			["useCooldownModRate"] = true,
			["zoom"] = 0,
			["semver"] = "1.0.0",
			["tocversion"] = 11306,
			["id"] = "Warrior - Shield Equipped",
			["width"] = 100,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 1,
			["config"] = {
			},
			["inverse"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["conditions"] = {
			},
			["cooldown"] = false,
			["cooldownEdge"] = false,
		},
		["Warrior - Battle Stance"] = {
			["outline"] = "OUTLINE",
			["xOffset"] = 0,
			["displayText"] = "BATTLE STANCE",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["automaticWidth"] = "Auto",
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
						["type"] = "unit",
						["use_form"] = true,
						["subeventSuffix"] = "_CAST_START",
						["form"] = {
							["single"] = 1,
						},
						["duration"] = "1",
						["event"] = "Stance/Form/Aura",
						["subeventPrefix"] = "SPELL",
						["unevent"] = "auto",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["names"] = {
						},
						["use_inverse"] = false,
						["use_unit"] = true,
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
			},
			["font"] = "Arial Narrow",
			["version"] = 16,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_class"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["size"] = {
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
				["zoneIds"] = "",
			},
			["fontSize"] = 21,
			["shadowXOffset"] = 1,
			["regionType"] = "text",
			["fixedWidth"] = 200,
			["selfPoint"] = "BOTTOM",
			["preferToUpdate"] = false,
			["shadowYOffset"] = -1,
			["wordWrap"] = "WordWrap",
			["url"] = "https://wago.io/z6xqQay0S/16",
			["semver"] = "1.0.15",
			["tocversion"] = 11302,
			["id"] = "Warrior - Battle Stance",
			["uid"] = "CuJBPUabQKw",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["color"] = {
				1, -- [1]
				0.37254901960784, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["config"] = {
			},
			["justify"] = "LEFT",
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["parent"] = "Vermin Warrior Stance",
		},
		["Iron Ore"] = {
			["iconSource"] = -1,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["url"] = "https://wago.io/iST6tz9t8/1",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["itemName"] = 2772,
						["use_count"] = true,
						["use_absorbMode"] = true,
						["names"] = {
						},
						["debuffType"] = "HELPFUL",
						["type"] = "item",
						["subeventSuffix"] = "_CAST_START",
						["use_exact_itemName"] = true,
						["unit"] = "player",
						["event"] = "Item Count",
						["duration"] = "1",
						["use_includeBank"] = true,
						["spellIds"] = {
						},
						["count"] = "0",
						["unevent"] = "auto",
						["use_itemName"] = true,
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["count_operator"] = ">",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_shadowXOffset"] = 0,
					["type"] = "subtext",
					["text_anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "PT Sans Narrow",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_anchorYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_text_format_p_time_precision"] = 1,
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_shadowYOffset"] = 0,
				}, -- [2]
				{
					["glowFrequency"] = 0,
					["type"] = "subglow",
					["useGlowColor"] = false,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowDuration"] = 1,
					["glowXOffset"] = 0,
					["glowThickness"] = 1,
					["glow"] = true,
					["glowScale"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 40,
			["load"] = {
				["use_namerealm"] = true,
				["ingroup"] = {
					["single"] = "solo",
				},
				["namerealm"] = "Mxzq",
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["use_ingroup"] = true,
				["zoneIds"] = "",
				["use_never"] = true,
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["source"] = "import",
			["config"] = {
			},
			["useTooltip"] = true,
			["parent"] = "Ore Count",
			["regionType"] = "icon",
			["cooldown"] = false,
			["xOffset"] = 0,
			["selfPoint"] = "CENTER",
			["authorOptions"] = {
			},
			["anchorFrameParent"] = false,
			["zoom"] = 0.3,
			["width"] = 40,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.0.0",
			["tocversion"] = 90002,
			["id"] = "Iron Ore",
			["useCooldownModRate"] = true,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["alpha"] = 1,
			["uid"] = "WbgHXRR3HGd",
			["inverse"] = false,
			["cooldownEdge"] = false,
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
		},
		["Frenzy Effect"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["wagoID"] = "v9qxdDgI4",
			["parent"] = "Vermin Hunter",
			["preferToUpdate"] = false,
			["sparkHeight"] = 30,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["sparkOffsetX"] = 0,
			["cooldownSwipe"] = true,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Frenzy Effect", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showOnReady",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["type"] = "aura2",
						["use_unit"] = true,
						["unevent"] = "auto",
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Action Usable",
						["useName"] = true,
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_genericShowOn"] = true,
						["spellName"] = 34428,
						["unit"] = "pet",
						["use_track"] = true,
						["useIgnoreName"] = false,
					},
					["untrigger"] = {
						["genericShowOn"] = "showOnReady",
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
			["useTooltip"] = false,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["xOffset"] = 0,
			["barColor"] = {
				0.2, -- [1]
				1, -- [2]
				0.0862745098039216, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["internalVersion"] = 70,
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.75,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["text_color"] = {
					},
					["glowThickness"] = 2,
					["glowDuration"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0.85098039215686, -- [2]
						0.1843137254902, -- [3]
						1, -- [4]
					},
					["useGlowColor"] = true,
					["glow"] = true,
					["glowLength"] = 16,
					["glowType"] = "buttonOverlay",
					["glowScale"] = 1,
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "%p",
					["text_text_format_p_time_mod_rate"] = true,
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_format"] = "timed",
					["type"] = "subtext",
					["anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_shadowXOffset"] = 0,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 12,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
				}, -- [3]
				{
					["text_shadowXOffset"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_precision"] = 1,
					["anchorXOffset"] = 0,
					["type"] = "subtext",
					["text_text_format_p_format"] = "timed",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_time_mod_rate"] = true,
					["text_anchorYOffset"] = 25,
					["text_fontSize"] = 12,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_p_time_legacy_floor"] = false,
				}, -- [4]
			},
			["height"] = 40,
			["selfPoint"] = "CENTER",
			["load"] = {
				["use_level"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["use_class"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["use_never"] = false,
				["level"] = {
					"60", -- [1]
				},
				["class"] = {
					["single"] = "HUNTER",
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["authorOptions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["desc"] = "",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["conditions"] = {
			},
			["smoothProgress"] = true,
			["anchorFrameFrame"] = "PlayerFrame",
			["regionType"] = "icon",
			["cooldownTextDisabled"] = false,
			["uid"] = "JX2NZu1XLej",
			["icon_side"] = "RIGHT",
			["useAdjustededMin"] = false,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["anchorFrameParent"] = false,
			["texture"] = "Melli",
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["spark"] = false,
			["useCooldownModRate"] = true,
			["sparkHidden"] = "NEVER",
			["id"] = "Frenzy Effect",
			["alpha"] = 1,
			["width"] = 40,
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["config"] = {
			},
			["inverse"] = false,
			["auto"] = false,
			["orientation"] = "HORIZONTAL",
			["displayIcon"] = 134296,
			["cooldown"] = false,
			["frameStrata"] = 1,
		},
		["target cast bar - interruptable"] = {
			["sparkWidth"] = 20,
			["iconSource"] = 0,
			["user_x"] = 0,
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["sameTexture"] = true,
			["url"] = "https://wago.io/r19H1zQ4Z/1",
			["icon"] = false,
			["fontFlags"] = "OUTLINE",
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["enableGradient"] = false,
			["selfPoint"] = "CENTER",
			["barColor"] = {
				0.22745098039216, -- [1]
				1, -- [2]
				0.30980392156863, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["rotation"] = 0,
			["sparkOffsetY"] = 0,
			["gradientOrientation"] = "HORIZONTAL",
			["load"] = {
				["talent2"] = {
					["multi"] = {
					},
				},
				["use_never"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
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
				["size"] = {
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
				["race"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["startAngle"] = 0,
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["blendMode"] = "BLEND",
			["texture"] = "xVerminClean",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["spark"] = false,
			["compress"] = false,
			["alpha"] = 1,
			["config"] = {
			},
			["backgroundOffset"] = 2,
			["borderBackdrop"] = "Birg00",
			["color"] = {
			},
			["desaturateBackground"] = false,
			["sparkRotationMode"] = "AUTO",
			["desaturateForeground"] = false,
			["triggers"] = {
				{
					["trigger"] = {
						["use_interruptible"] = true,
						["type"] = "unit",
						["subeventSuffix"] = "_CAST_START",
						["custom_hide"] = "timed",
						["sourceUnit"] = "target",
						["event"] = "Cast",
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["unevent"] = "auto",
						["spellIds"] = {
						},
						["use_sourceUnit"] = true,
						["use_unit"] = true,
						["unit"] = "target",
						["use_cloneId"] = false,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
						["unit"] = "target",
					},
				}, -- [1]
				["disjunctive"] = "all",
				["activeTriggerMode"] = 1,
			},
			["endAngle"] = 360,
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["preset"] = "fade",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["preset"] = "fade",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
				},
			},
			["version"] = 1,
			["subRegions"] = {
				{
					["border_size"] = 1,
					["border_anchor"] = "bar",
					["border_offset"] = 3,
					["border_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						0.60000002384186, -- [4]
					},
					["border_visible"] = false,
					["border_edge"] = "Square Clean",
					["type"] = "subborder",
				}, -- [1]
				{
					["type"] = "subbackground",
				}, -- [2]
				{
					["type"] = "subforeground",
				}, -- [3]
				{
					["text_shadowXOffset"] = 1,
					["text_text"] = "%p",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_n_format"] = "none",
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["anchorXOffset"] = 0,
					["text_text_format_p_time_precision"] = 1,
					["text_text_format_p_format"] = "timed",
					["type"] = "subtext",
					["text_anchorXOffset"] = -10,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Homespun (xCT+)",
					["text_shadowYOffset"] = -1,
					["text_anchorYOffset"] = -2,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "INNER_RIGHT",
					["text_text_format_p_time_format"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
					["text_fontSize"] = 30,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_p_time_legacy_floor"] = false,
				}, -- [4]
				{
					["text_shadowXOffset"] = 1,
					["text_text"] = "%n",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_anchorXOffset"] = 10,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Arial Narrow",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "INNER_LEFT",
					["text_text_format_n_format"] = "none",
					["text_visible"] = true,
					["text_fontSize"] = 30,
					["anchorXOffset"] = 0,
					["text_anchorYOffset"] = -2,
				}, -- [5]
				{
					["text_text_format_t_time_precision"] = 1,
					["text_text_format_s_format"] = "none",
					["text_text_format_t_time_legacy_floor"] = false,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_fixedWidth"] = 64,
					["text_text_format_p_time_legacy_floor"] = false,
					["rotateText"] = "NONE",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_text_format_t_time_format"] = 0,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["text_text_format_t_format"] = "timed",
					["type"] = "subtext",
					["text_font"] = "Arial Narrow",
					["text_text_format_t_time_dynamic_threshold"] = 60,
					["text_anchorYOffset"] = -2,
					["text_fontType"] = "OUTLINE",
					["text_text_format_p_time_format"] = 0,
					["text_text_format_t_time_mod_rate"] = true,
					["text_anchorPoint"] = "ICON_CENTER",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_p_time_precision"] = 1,
					["text_text_format_p_time_mod_rate"] = true,
					["text_text"] = "%p",
					["text_shadowXOffset"] = 1,
				}, -- [6]
				{
					["border_offset"] = 0,
					["border_anchor"] = "bar",
					["border_size"] = 2,
					["border_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["border_visible"] = true,
					["border_edge"] = "Drop Shadow",
					["type"] = "subborder",
				}, -- [7]
			},
			["height"] = 50,
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["backgroundTexture"] = "Textures\\SpellActivationOverlays\\Eclipse_Sun",
			["source"] = "import",
			["sparkOffsetX"] = 0,
			["barColor2"] = {
				1, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["crop_x"] = 0.41,
			["mirror"] = false,
			["crop_y"] = 0.41,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["crop"] = 0.41,
			["foregroundTexture"] = "Textures\\SpellActivationOverlays\\Eclipse_Sun",
			["icon_side"] = "LEFT",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.60000002384186, -- [4]
			},
			["width"] = 1000,
			["sparkHeight"] = 70,
			["user_y"] = 0,
			["parent"] = "1. Target Cast Bar",
			["id"] = "target cast bar - interruptable",
			["semver"] = "1.0.0",
			["authorOptions"] = {
			},
			["sparkHidden"] = "NEVER",
			["foregroundColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0,
			["backdropColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
			},
			["inverse"] = false,
			["uid"] = "WSk37iR8lUQ",
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["DRUID"] = {
			["iconSource"] = -1,
			["wagoID"] = "v9qxdDgI4",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/v9qxdDgI4/2",
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
					["glow_action"] = "hide",
				},
				["finish"] = {
					["do_custom"] = false,
				},
				["init"] = {
					["do_custom"] = false,
					["custom"] = "\nfunction()\n    \n    return\nend",
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Mark of the Wild", -- [1]
							"Gift of the Wild", -- [2]
							"Blessing of D.E.H.T.A.", -- [3]
						},
						["matchesShowOn"] = "showOnMissing",
						["genericShowOn"] = "showOnReady",
						["unit"] = "player",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
						["spellName"] = 34428,
						["type"] = "aura2",
						["subeventSuffix"] = "_CAST_START",
						["useExactSpellId"] = false,
						["unevent"] = "auto",
						["names"] = {
						},
						["event"] = "Action Usable",
						["useName"] = true,
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["duration"] = "1",
						["useNamePattern"] = false,
						["use_track"] = true,
						["use_genericShowOn"] = true,
					},
					["untrigger"] = {
						["genericShowOn"] = "showOnReady",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "aura2",
						["auranames"] = {
							"Thorns", -- [1]
						},
						["unit"] = "player",
						["matchesShowOn"] = "showOnMissing",
						["useName"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["useTooltip"] = false,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "relative",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 2,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_shadowXOffset"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text_format_p_big_number_format"] = "AbbreviateNumbers",
					["text_text_format_p_realm_name"] = "never",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_fixedWidth"] = 64,
					["rotateText"] = "NONE",
					["text_text_format_p_decimal_precision"] = 1,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_text_format_p_color"] = true,
					["text_fontSize"] = 18,
					["anchorXOffset"] = 0,
					["text_text_format_n_format"] = "none",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_text_format_t_time_format"] = 0,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["text_text_format_t_format"] = "timed",
					["type"] = "subtext",
					["text_font"] = "Friz Quadrata TT",
					["text_fontType"] = "THICKOUTLINE",
					["text_anchorYOffset"] = 45,
					["text_text_format_t_time_precision"] = 1,
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "%n",
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_abbreviate_max"] = 8,
					["text_text_format_p_abbreviate"] = false,
					["text_text_format_t_time_dynamic_threshold"] = 60,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_text_format_p_time_precision"] = 1,
				}, -- [2]
				{
					["glowFrequency"] = 0.25,
					["glow"] = false,
					["useGlowColor"] = false,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowDuration"] = 1,
					["type"] = "subglow",
					["glowThickness"] = 1,
					["glowScale"] = 1,
					["glowXOffset"] = 0,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 65.000022888184,
			["load"] = {
				["use_namerealm"] = false,
				["use_never"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["level_operator"] = {
					">=", -- [1]
				},
				["use_alive"] = true,
				["use_combat"] = true,
				["use_class"] = false,
				["use_spellknown"] = false,
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "PALADIN",
					["multi"] = {
						["DRUID"] = true,
					},
				},
				["use_level"] = false,
				["level"] = {
					"60", -- [1]
				},
				["namerealm"] = "xxx",
				["size"] = {
					["multi"] = {
					},
				},
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["selfPoint"] = "CENTER",
			["icon"] = true,
			["cooldown"] = false,
			["conditions"] = {
			},
			["regionType"] = "icon",
			["parent"] = "MISSING BUFFS",
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["config"] = {
			},
			["xOffset"] = 0,
			["useCooldownModRate"] = false,
			["auto"] = false,
			["zoom"] = 0.3,
			["semver"] = "1.0.1",
			["tocversion"] = 20501,
			["id"] = "DRUID",
			["cooldownTextDisabled"] = false,
			["alpha"] = 1,
			["width"] = 65.000114440918,
			["cooldownEdge"] = false,
			["uid"] = "d9W)ExaN7hc",
			["inverse"] = false,
			["internalVersion"] = 70,
			["displayIcon"] = "",
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["PvP Flag Timer"] = {
			["sparkWidth"] = 10,
			["xOffset"] = 10,
			["displayText_format_p_time_dynamic_threshold"] = 0,
			["yOffset"] = 0,
			["anchorPoint"] = "TOPRIGHT",
			["displayText_format_p_time_format"] = 0,
			["url"] = "https://wago.io/vANDyyv-u/2",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["fontFlags"] = "OUTLINE",
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["selfPoint"] = "TOPLEFT",
			["barColor"] = {
				1, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["font"] = "Arial Narrow",
			["sparkOffsetY"] = 0,
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["affixes"] = {
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
				["race"] = {
					["multi"] = {
					},
				},
				["talent3"] = {
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
				["talent2"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["shadowXOffset"] = 1,
			["useAdjustededMin"] = false,
			["regionType"] = "text",
			["texture"] = "Blizzard Raid Bar",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["auto"] = false,
			["tocversion"] = 11307,
			["alpha"] = 1,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["outline"] = "None",
			["sparkOffsetX"] = 0,
			["wagoID"] = "vANDyyv-u",
			["color"] = {
				1, -- [1]
				0, -- [2]
				0.07058823853731155, -- [3]
				1, -- [4]
			},
			["shadowYOffset"] = -1,
			["customTextUpdate"] = "update",
			["automaticWidth"] = "Auto",
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["debuffType"] = "HELPFUL",
						["custom_type"] = "status",
						["subeventSuffix"] = "_CAST_START",
						["genericShowOn"] = "showOnActive",
						["event"] = "Health",
						["names"] = {
						},
						["customDuration"] = "function()\n    return 299, startPVP + 299\nend",
						["custom"] = "function()\n    if GetPVPTimer() ~= 301000 then \n        startPVP = startPVP or GetTime()\n        return true\n    end\nend\n\n\n\n\n\n\n",
						["spellIds"] = {
						},
						["events"] = "PLAYER_FLAGS_CHANGED",
						["check"] = "update",
						["subeventPrefix"] = "SPELL",
						["unit"] = "player",
						["custom_hide"] = "custom",
					},
					["untrigger"] = {
						["custom"] = "function()\n    if GetPVPTimer() == 301000 then \n        startPVP = GetTime()\n        return true\n    end\nend\n\n\n\n\n\n\n",
					},
				}, -- [1]
				["activeTriggerMode"] = 1,
			},
			["displayText_format_p_format"] = "timed",
			["displayText_format_p_time_legacy_floor"] = true,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["version"] = 2,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 13.103708267212,
			["uid"] = "4TIaerZ8Mbz",
			["preferToUpdate"] = false,
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["fontSize"] = 18,
			["source"] = "import",
			["authorOptions"] = {
			},
			["orientation"] = "HORIZONTAL",
			["spark"] = false,
			["displayIcon"] = 132486,
			["anchorFrameFrame"] = "SUFUnitplayer",
			["internalVersion"] = 70,
			["displayText"] = "%p",
			["anchorFrameType"] = "SELECTFRAME",
			["icon_side"] = "RIGHT",
			["sparkRotationMode"] = "AUTO",
			["displayText_format_p_time_precision"] = 1,
			["sparkHeight"] = 30,
			["id"] = "PvP Flag Timer",
			["sparkRotation"] = 0,
			["semver"] = "1.0.1",
			["justify"] = "LEFT",
			["zoom"] = 0,
			["sparkHidden"] = "NEVER",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["frameStrata"] = 1,
			["width"] = 200,
			["wordWrap"] = "WordWrap",
			["icon"] = false,
			["inverse"] = false,
			["config"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["displayText_format_p_time_mod_rate"] = true,
		},
		["Overpower Death"] = {
			["iconSource"] = -1,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["url"] = "https://wago.io/ip9svzmFy/1",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["custom"] = "aura_env.OverpowerActive = false",
					["do_custom"] = true,
				},
				["finish"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["names"] = {
						},
						["debuffType"] = "HELPFUL",
						["type"] = "spell",
						["unevent"] = "auto",
						["subeventPrefix"] = "SPELL",
						["event"] = "Cooldown Progress (Spell)",
						["use_genericShowOn"] = true,
						["realSpellName"] = "Overpower",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["unit"] = "player",
						["use_track"] = true,
						["spellName"] = 7384,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "custom",
						["subeventSuffix"] = "_CAST_START",
						["custom_hide"] = "custom",
						["duration"] = "5",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["customDuration"] = "function()\n    return 5, GetTime()+5\nend",
						["unit"] = "player",
						["spellIds"] = {
						},
						["custom"] = "function (event,...)\n    if event == \"COMBAT_LOG_EVENT_UNFILTERED\" then\n        if select(4,...)==UnitGUID(\"player\") and select(8,...)==UnitGUID(\"target\") then\n            if select(2,...) == \"SWING_MISSED\" then --sub event\n                if select(12,...) ==\"DODGE\" then --miss type\n                    aura_env.DodgeTime=select(1,...)\n                    aura_env.OverpowerActive =true\n                    return true\n                end\n            end\n            if select(2,...) == \"SPELL_MISSED\" \n            and select(13,...) ~= \"Revenge\" then\n                if select(15,...) ==\"DODGE\" then\n                    aura_env.DodgeTime=select(1,...)\n                    aura_env.OverpowerActive=true\n                    return true\n                end\n            end\n        end\n    end\nend\n\n\n",
						["custom_type"] = "event",
						["names"] = {
						},
						["events"] = "CLEU, PLAYER_TARGET_CHANGED",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
						["custom"] = "function (event,...)\n    if event == \"COMBAT_LOG_EVENT_UNFILTERED\" then\n        if aura_env.OverpowerActive == true\n        and select(1,...) > 5+aura_env.DodgeTime then\n            aura_env.OverpowerActive = false\n            return true\n        end\n        \n        if select(4,...)==UnitGUID(\"player\") and select(8,...)==UnitGUID(\"target\") then\n            if select(2,...) == \"SPELL_CAST_SUCCESS\"\n            or select(2,...) == \"SPELL_CAST_FAILED\" then --sub event\n                if select(13,...) ==\"Overpower\"\n                or select(13,...) == \"Revenge\" then --spell name\n                    aura_env.OverpowerActive = false\n                    return true\n                end\n            end\n            \n        end\n    end\n    if event == \"PLAYER_TARGET_CHANGED\" then\n        aura_env.OverpowerActive = false\n        return true\n    end \nend\n\n\n\n",
					},
				}, -- [2]
				{
					["trigger"] = {
						["type"] = "unit",
						["unevent"] = "auto",
						["power_operator"] = {
							"<", -- [1]
						},
						["duration"] = "1",
						["event"] = "Power",
						["use_unit"] = true,
						["powertype"] = 1,
						["subeventSuffix"] = "_CAST_START",
						["power"] = {
							"5", -- [1]
						},
						["subeventPrefix"] = "SPELL",
						["use_power"] = true,
						["use_powertype"] = true,
						["unit"] = "player",
					},
					["untrigger"] = {
					},
				}, -- [3]
				["disjunctive"] = "custom",
				["customTriggerLogic"] = "function(t)\n    return t[2];\nend",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_shadowXOffset"] = 0,
					["text_text"] = "%2.p",
					["text_text_format_2.p_time_format"] = 0,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_text_format_2.p_time_legacy_floor"] = true,
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_2.p_format"] = "timed",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_2.p_time_mod_rate"] = true,
					["text_shadowYOffset"] = 0,
					["text_text_format_2.p_time_dynamic_threshold"] = 60,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_visible"] = true,
					["text_text_format_2.p_time_precision"] = 1,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_automaticWidth"] = "Auto",
				}, -- [2]
				{
					["glowFrequency"] = 0.25,
					["glow"] = true,
					["useGlowColor"] = false,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["glowDuration"] = 1,
					["glowScale"] = 1,
					["glowThickness"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 36,
			["load"] = {
				["use_class"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["size"] = {
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
				["zoneIds"] = "",
			},
			["source"] = "import",
			["cooldownTextDisabled"] = false,
			["config"] = {
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["cooldownEdge"] = false,
			["regionType"] = "icon",
			["cooldown"] = false,
			["displayIcon"] = 132223,
			["selfPoint"] = "CENTER",
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["useCooldownModRate"] = true,
			["zoom"] = 0.3,
			["semver"] = "1.0.0",
			["tocversion"] = 11302,
			["id"] = "Overpower Death",
			["xOffset"] = 0,
			["frameStrata"] = 1,
			["width"] = 36,
			["auto"] = true,
			["uid"] = "rzS2KLTw86g",
			["inverse"] = false,
			["icon"] = true,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 3,
						["variable"] = "show",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["parent"] = "Vermin Warrior",
		},
		["VrIcon"] = {
			["iconSource"] = 1,
			["wagoID"] = "v9qxdDgI4",
			["parent"] = "VictoryRush",
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "1",
						["genericShowOn"] = "showOnReady",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "spell",
						["subeventSuffix"] = "_CAST_START",
						["spellName"] = 402927,
						["event"] = "Action Usable",
						["subeventPrefix"] = "SPELL",
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["names"] = {
						},
						["unevent"] = "auto",
						["use_genericShowOn"] = true,
						["use_track"] = true,
						["use_unit"] = true,
					},
					["untrigger"] = {
						["genericShowOn"] = "showOnReady",
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["useTooltip"] = false,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 2,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.5,
					["type"] = "subglow",
					["glowDuration"] = 1,
					["text_color"] = {
					},
					["glowThickness"] = 3,
					["useGlowColor"] = true,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0.85098039215686, -- [2]
						0.1843137254902, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["glow"] = true,
					["glowLength"] = 17.6,
					["glowType"] = "buttonOverlay",
					["glowScale"] = 1,
					["glowLines"] = 4,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_t_time_precision"] = 1,
					["text_text_format_s_format"] = "none",
					["text_text_format_t_time_legacy_floor"] = true,
					["text_text_format_p_realm_name"] = "never",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_fixedWidth"] = 64,
					["rotateText"] = "NONE",
					["text_text_format_p_decimal_precision"] = 1,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "THICKOUTLINE",
					["text_text_format_p_color"] = true,
					["text_fontSize"] = 40,
					["anchorXOffset"] = 0,
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_text_format_t_time_format"] = 0,
					["anchorYOffset"] = 0,
					["text_text_format_p_abbreviate_max"] = 8,
					["text_text_format_t_format"] = "timed",
					["type"] = "subtext",
					["text_text_format_p_big_number_format"] = "AbbreviateNumbers",
					["text_font"] = "Friz Quadrata TT",
					["text_shadowXOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_text_format_t_time_dynamic_threshold"] = 60,
					["text_text_format_p_time_precision"] = 1,
					["text_text_format_t_time_mod_rate"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_abbreviate"] = false,
					["text_justify"] = "CENTER",
					["text_visible"] = true,
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "%t",
				}, -- [3]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_shadowYOffset"] = 0,
					["type"] = "subtext",
					["text_anchorXOffset"] = 5,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_anchorYOffset"] = -5,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["text_fontType"] = "OUTLINE",
					["text_text_format_p_time_precision"] = 1,
					["text_fontSize"] = 20,
					["anchorXOffset"] = 0,
					["text_shadowXOffset"] = 0,
				}, -- [4]
				{
					["text_text_format_p_time_precision"] = 1,
					["text_text"] = "%p",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_mod_rate"] = true,
					["type"] = "subtext",
					["anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_shadowXOffset"] = 0,
					["text_fontSize"] = 12,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["anchorYOffset"] = 0,
				}, -- [5]
			},
			["height"] = 65.000022888184,
			["load"] = {
				["use_level"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["use_class"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["spec"] = {
					["multi"] = {
					},
				},
				["level"] = {
					"60", -- [1]
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["frameStrata"] = 1,
			["source"] = "import",
			["width"] = 65.000114440918,
			["authorOptions"] = {
			},
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["displayIcon"] = 132342,
			["regionType"] = "icon",
			["url"] = "https://wago.io/v9qxdDgI4/2",
			["alpha"] = 1,
			["uid"] = "1UZvvfknxj(",
			["internalVersion"] = 70,
			["selfPoint"] = "CENTER",
			["semver"] = "1.0.1",
			["cooldownTextDisabled"] = false,
			["auto"] = false,
			["tocversion"] = 20501,
			["id"] = "VrIcon",
			["zoom"] = 0.3,
			["useCooldownModRate"] = true,
			["anchorFrameType"] = "SCREEN",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["config"] = {
			},
			["inverse"] = false,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["conditions"] = {
			},
			["cooldown"] = false,
			["xOffset"] = 0,
		},
		["@ Avoidance / Defense Cap (Wrath of the Lich King)"] = {
			["iconSource"] = -1,
			["xOffset"] = -55,
			["displayText"] = "\n",
			["yOffset"] = 165,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["url"] = "https://wago.io/qYKsfPe_W/17",
			["icon"] = true,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desc"] = "\"Black Panther was an ok movie\"",
			["rotation"] = 0,
			["font"] = "Expressway",
			["load"] = {
				["use_class"] = false,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "PALADIN",
					["multi"] = {
						["DEATHKNIGHT"] = true,
						["DRUID"] = true,
						["WARRIOR"] = true,
						["PALADIN"] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["textureWrapMode"] = "CLAMPTOBLACKADDITIVE",
			["shadowXOffset"] = 1,
			["regionType"] = "icon",
			["blendMode"] = "BLEND",
			["texture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\square_border_1px.tga",
			["cooldownTextDisabled"] = false,
			["tocversion"] = 30400,
			["alpha"] = 1,
			["config"] = {
			},
			["fixedWidth"] = 200,
			["outline"] = "OUTLINE",
			["wagoID"] = "qYKsfPe_W",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0, -- [4]
			},
			["customText"] = "function()\n  return aura_env.getAvoidance()\nend\n\n\n",
			["shadowYOffset"] = -1,
			["cooldownSwipe"] = true,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Conditions",
						["unit"] = "player",
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["names"] = {
						},
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "any",
				["customTriggerLogic"] = "function(trigger)\n  print(trigger[2])\n  aura_env.id = 123\n  return true\nend\n\n\n",
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["discrete_rotation"] = 0,
			["version"] = 17,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 25,
			["rotate"] = true,
			["fontSize"] = 12,
			["source"] = "import",
			["displayText_format_n_format"] = "none",
			["mirror"] = false,
			["anchorFrameFrame"] = "PaperDollFrame",
			["authorOptions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["preferToUpdate"] = true,
			["displayIcon"] = 135995,
			["uid"] = "pmBhPjLakzv",
			["displayText_format_p_time_precision"] = 1,
			["cooldownEdge"] = false,
			["wordWrap"] = "WordWrap",
			["desaturate"] = false,
			["justify"] = "LEFT",
			["anchorFrameType"] = "SELECTFRAME",
			["id"] = "@ Avoidance / Defense Cap (Wrath of the Lich King)",
			["useCooldownModRate"] = true,
			["frameStrata"] = 1,
			["width"] = 100,
			["semver"] = "1.0.16",
			["actions"] = {
				["start"] = {
					["custom"] = "aura_env.id = aura_env.getAvoidance()\nprint(aura_env.id)",
					["do_custom"] = false,
				},
				["init"] = {
					["custom"] = "local CLASS = (select(3, UnitClass(\"player\")))\n\nlocal function defenseCap()\n    local cap = 540\n    if class == 11 then\n        --get ranks of Survival of the Fittest Talent\n        local _,_,_,_,rank = GetTalentInfo(2, 16)\n        local talentOffset = rank * (25 * 2) -- \n        \n        cap = 540 - talentOffset\n    end\n    \n    local resilience = GetCombatRatingBonus(15) / 0.04\n    --local resilience = (GetCombatRating(15) * (1/82)) / 0.04 --resilience to defense rating calculation\n    \n    if resilience > 0 then\n        return string.format(\"%.2f\", cap - resilience)\n    else \n        return cap\n    end\nend\n\n\nlocal function overlay()\n    local defense = (select(1, UnitDefense(\"player\"))) + (select(2, UnitDefense(\"player\")))\n    \n    local miss = 5 + ((defense - (UnitLevel(\"player\") * 5)) * 0.04)\n    local block = GetBlockChance()\n    local parry = GetParryChance()\n    local dodge = GetDodgeChance()\n    \n    local avoidance = miss + block + parry + dodge\n    \n    return \"|cff12ffff Avoidance:|r \" .. string.format(\"%.2f\", avoidance) .. \"% / \".. 102.4 .. \n    \"%\\n|cff12ffff Defense:|r \" .. defense .. \"/\" .. defenseCap()\nend\n\nlocal function tooltip()\n    local defense = (select(1, UnitDefense(\"player\"))) + (select(2, UnitDefense(\"player\")))\n    \n    local miss = 5 + ((defense - (UnitLevel(\"player\") * 5)) * 0.04)\n    \n    GameTooltip:AddLine(\"|cffffffffDefensive Stats|r\")\n    GameTooltip:AddLine(\"Miss: \" .. miss ..\"%\")\n    \n    if CLASS == 1 or CLASS == 2 or CLASS == 6 then\n        GameTooltip:AddLine(\"Parry: \".. string.format(\"%.2f\", GetParryChance()) ..\"%\")\n    end\n    \n    GameTooltip:AddLine(\"Dodge: \".. string.format(\"%.2f\", GetDodgeChance()) ..\"%\")\n    \n    if CLASS == 1 or CLASS == 2 then\n        GameTooltip:AddLine(\"Block: \".. string.format(\"%.2f\", GetBlockChance()) ..\"%  (\" .. GetShieldBlock() .. \")\")\n    end\n    \nend\n\n--CREATE FRAME\nif not aura_env.AvoidanceFrame then\n    local f = CreateFrame(\"Frame\", nil, aura_env.region)\n    \n    f:SetAllPoints()\n    \n    f.text = f:CreateFontString(nil, \"OVERLAY\")\n    f.text:SetFontObject(\"GameFontNormal\")\n    f.text:SetPoint(\"TOP\", 0, -5)\n    f.text:SetText(overlay())\n    f.text:SetJustifyH(\"LEFT\")\n    f:SetScale(0.8)\n    \n    f:RegisterEvent(\"COMBAT_RATING_UPDATE\")\n    f:RegisterEvent(\"PLAYER_ENTERING_WORLD\")\n    f:RegisterEvent(\"PLAYER_DAMAGE_DONE_MODS\")\n    f:SetScript(\"OnEvent\", function(self)      \n            f.text:SetText(overlay())\n    end)\n    \n    f:SetScript(\"OnEnter\", function(self) \n            GameTooltip:SetOwner(self, \"ANCHOR_BOTTOM\", 0, 0)\n            tooltip()\n            GameTooltip:Show()\n    end)\n    \n    f:SetScript(\"OnLeave\", function() \n            GameTooltip:Hide() \n    end)\n    \n    aura_env.AvoidanceFrame = f\nend",
					["do_custom"] = true,
				},
				["finish"] = {
				},
			},
			["inverse"] = false,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["cooldown"] = false,
			["zoom"] = 0,
		},
		["Spirit Tap"] = {
			["iconSource"] = -1,
			["parent"] = "Vermin Priest",
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = true,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["useMatch_count"] = false,
						["auraspellids"] = {
							"80240", -- [1]
						},
						["match_countOperator"] = ">",
						["auranames"] = {
							"Spirit Tap", -- [1]
						},
						["useName"] = true,
						["event"] = "Health",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["spellIds"] = {
						},
						["names"] = {
						},
						["match_count"] = "0",
						["type"] = "aura2",
						["useExactSpellId"] = false,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "spell",
						["subeventSuffix"] = "_CAST_START",
						["unevent"] = "auto",
						["duration"] = "1",
						["use_genericShowOn"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["use_unit"] = true,
						["realSpellName"] = 34477,
						["use_spellName"] = true,
						["unit"] = "player",
						["genericShowOn"] = "showAlways",
						["use_absorbMode"] = true,
						["subeventPrefix"] = "SPELL",
						["use_track"] = true,
						["spellName"] = 34477,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_shadowXOffset"] = 1,
					["text_text_format_s_format"] = "none",
					["text_text_format_2.p_time_mod_rate"] = true,
					["text_text_format_2.p_time_format"] = 0,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_text_format_2.p_time_legacy_floor"] = true,
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_2.p_format"] = "timed",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Arial Narrow",
					["text_text"] = "%2.p",
					["text_shadowYOffset"] = -1,
					["text_text_format_2.p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "CENTER",
					["text_visible"] = false,
					["text_text_format_2.p_time_precision"] = 1,
					["text_fontSize"] = 24,
					["anchorXOffset"] = 0,
					["text_automaticWidth"] = "Auto",
				}, -- [2]
				{
					["text_text_format_p_time_precision"] = 1,
					["text_text"] = "%1.p",
					["text_text_format_p_format"] = "timed",
					["text_justify"] = "CENTER",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_1.p_time_format"] = 0,
					["anchorYOffset"] = 0,
					["text_text_format_1.p_time_mod_rate"] = true,
					["text_text_format_1.p_time_precision"] = 1,
					["anchorXOffset"] = 0,
					["text_text_format_1.p_time_legacy_floor"] = true,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["type"] = "subtext",
					["text_text_format_p_time_format"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Arial Narrow",
					["text_anchorPoint"] = "CENTER",
					["text_shadowYOffset"] = 0,
					["text_text_format_1.p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_text_format_1.p_format"] = "timed",
					["text_visible"] = true,
					["text_shadowXOffset"] = 0,
					["text_fontSize"] = 16,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["rotateText"] = "NONE",
				}, -- [3]
				{
					["glowFrequency"] = 0.25,
					["glow"] = true,
					["useGlowColor"] = false,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["glowDuration"] = 1,
					["glowScale"] = 1,
					["glowThickness"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [4]
			},
			["height"] = 40,
			["load"] = {
				["use_class"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "PRIEST",
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["source"] = "import",
			["zoom"] = 0,
			["url"] = "https://wago.io/E9AeMcIo0/1",
			["selfPoint"] = "CENTER",
			["cooldown"] = false,
			["regionType"] = "icon",
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = -2,
						["variable"] = "AND",
						["checks"] = {
							{
								["trigger"] = 2,
								["variable"] = "onCooldown",
								["value"] = 1,
							}, -- [1]
							{
								["trigger"] = 1,
								["variable"] = "show",
								["value"] = 1,
							}, -- [2]
						},
					},
					["changes"] = {
						{
							["property"] = "desaturate",
						}, -- [1]
						{
							["value"] = {
								["custom"] = "local reg = WeakAuras.GetRegion(aura_env.id)\n\nreg.glowicon = reg.glowicon or CreateFrame(\"Button\", aura_env.id..\"Glower\" )\nreg.glowicon:SetSize( reg.icon:GetWidth() - 2, reg.icon:GetHeight() - 2)\nreg.glowicon:SetPoint( \"CENTER\", reg.icon, \"CENTER\" )\nActionButton_ShowOverlayGlow( reg.glowicon )",
							},
							["property"] = "customcode",
						}, -- [2]
						{
							["property"] = "inverse",
						}, -- [3]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "show",
						["value"] = 0,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "sub.2.text_visible",
						}, -- [1]
						{
							["property"] = "sub.3.text_visible",
						}, -- [2]
						{
							["value"] = {
								["custom"] = "local reg = WeakAuras.GetRegion(aura_env.id)\n\nreg.glowicon = reg.glowicon or CreateFrame(\"Button\", aura_env.id..\"Glower\" )\nreg.glowicon:SetSize( reg.icon:GetWidth() - 1, reg.icon:GetHeight() - 1)\nreg.glowicon:SetPoint( \"CENTER\", reg.icon, \"CENTER\" )\nActionButton_HideOverlayGlow( reg.glowicon )",
							},
							["property"] = "customcode",
						}, -- [3]
					},
				}, -- [2]
				{
					["check"] = {
						["trigger"] = -2,
						["variable"] = "AND",
						["checks"] = {
							{
								["trigger"] = 2,
								["variable"] = "onCooldown",
								["value"] = 1,
							}, -- [1]
							{
								["trigger"] = 1,
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
					},
				}, -- [3]
			},
			["xOffset"] = 0,
			["authorOptions"] = {
			},
			["uid"] = "2xTKAqls4vQ",
			["anchorFrameParent"] = false,
			["anchorFrameType"] = "SCREEN",
			["alpha"] = 1,
			["cooldownTextDisabled"] = true,
			["auto"] = true,
			["tocversion"] = 80300,
			["id"] = "Spirit Tap",
			["frameStrata"] = 1,
			["useCooldownModRate"] = true,
			["width"] = 40,
			["semver"] = "1.0.0",
			["config"] = {
			},
			["inverse"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayIcon"] = "",
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
		},
		["Threat Differential on Nameplates"] = {
			["xOffset"] = 30,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["yOffset"] = 0,
			["anchorPoint"] = "RIGHT",
			["displayText_format_p_time_format"] = 0,
			["url"] = "https://wago.io/yssC_nf5K/15",
			["icon"] = true,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desc"] = "Shows the threat difference between yourself and the party/raid member with the most threat on enemy nameplates.\n\nColor determined by Tankstatus:\n\"Securely Tanking\"  (default: green)\n\"Tanking\" (default: yellow)\n\"Insecurely Tanking\" (default: orange \"!!!\")\n\"Tanked by Other Tank\"  (default: blue)\n\"Untanked\" (default: red)\n\nOther Tanks are people marked as \"Main Tank\" in raid.",
			["font"] = "Friz Quadrata TT",
			["displayText_format_thing_format"] = "none",
			["shadowXOffset"] = 1,
			["customAnchor"] = "function()\n    if (aura_env.state.unitId) then\n        return C_NamePlate.GetNamePlateForUnit(aura_env.state.unitId)\n    end\nend\n\n\n",
			["regionType"] = "text",
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["tocversion"] = 30400,
			["alpha"] = 1,
			["config"] = {
				["secureThreatValue"] = 10000,
			},
			["fixedWidth"] = 200,
			["outline"] = "OUTLINE",
			["wagoID"] = "yssC_nf5K",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["customText"] = "function()\n    local value = aura_env.state and aura_env.state.value\n    if value then\n        if value < 1 then\n            return \"!!!\"\n        else\n            return AbbreviateNumbers(value) or value\n        end\n    end\nend",
			["shadowYOffset"] = -1,
			["cooldownSwipe"] = true,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["custom_type"] = "stateupdate",
						["customVariables"] = "{\n    status = {\n        display = \"Threat Status\",\n        type = \"select\",\n        values = {\n            [1] = \"Untanked\", \n            [2] = \"Insecurely Tanking\", \n            [3] = \"Tanking\",\n            [4] = \"Tanked by Other Tank\",\n            [5] = \"Securely tanking\"\n        }\n    }\n}",
						["genericShowOn"] = "showOnActive",
						["event"] = "Health",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["custom"] = "function(allstates, event, unitId)\n    if not unitId then\n        return\n    end\n    \n    if event == \"NAME_PLATE_UNIT_REMOVED\" then\n        local state = allstates[unitId]\n        if state then\n            state.show = false\n            state.changed = true\n            return true\n        end\n        \n    elseif unitId ~= \"target\" then\n        if UnitIsPlayer(unitId) then\n            return\n        end\n        \n        local isTanking, threatStatus, scaledPercentage, _, threatValue = UnitDetailedThreatSituation(\"player\", unitId)\n        \n        if not threatValue then\n            return \n        end\n        \n        local firstUnit, firstThreat, secondUnit, secondThreat = aura_env.ThreatFunc(unitId)\n        local displayValue\n        \n        if isTanking then\n            displayValue = threatValue - secondThreat\n            if Round(math.abs(displayValue) / 100) > aura_env.secureThreatValue then\n                threatStatus = 5\n            end\n        else\n            displayValue = threatValue - firstThreat\n            if firstUnit and not UnitIsUnit(firstUnit, \"player\") and GetPartyAssignment(\"MAINTANK\",firstUnit) then\n                threatStatus = 4\n            end\n        end\n        \n        allstates[unitId] = allstates[unitId] or {unit = unitId}\n        local state = allstates[unitId]\n        state.changed = true\n        state.show = true\n        state.status = threatStatus < 1 and 1 or threatStatus\n        state.value = Round(math.abs(displayValue) / 100)\n        return true\n    end\nend",
						["spellIds"] = {
						},
						["events"] = "NAME_PLATE_UNIT_ADDED, NAME_PLATE_UNIT_REMOVED, UNIT_THREAT_LIST_UPDATE, GROUP_ROSTER_UPDATE",
						["check"] = "event",
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["colorR"] = 1,
					["duration_type"] = "seconds",
					["colorA"] = 1,
					["colorG"] = 1,
					["type"] = "none",
					["easeType"] = "none",
					["scaley"] = 1,
					["alpha"] = 0,
					["colorB"] = 1,
					["y"] = 0,
					["x"] = 0,
					["scalex"] = 1,
					["easeStrength"] = 3,
					["colorFunc"] = "function()    \n    --if not aura_env.state then return 0, 0, 0, 1 end  -- error checking.\n    if aura_env.state.status == 3 then\n        return unpack(aura_env.config[\"color_tanking\"]) -- Reminder: return R, G, B, Alpha (using numbers between 0 and 1)\n    elseif aura_env.state.status == 2 then        \n        return unpack(aura_env.config[\"color_insecure\"])\n    elseif aura_env.state.status == 4  then\n        return unpack(aura_env.config[\"color_others\"])\n    elseif aura_env.state.status <= 1 then\n        return unpack(aura_env.config[\"color_untanked\"])\n    else\n        return 0,0,0,1\n    end \nend",
					["rotate"] = 0,
					["colorType"] = "custom",
					["use_color"] = false,
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["displayText_format_c2_format"] = "none",
			["stickyDuration"] = false,
			["version"] = 15,
			["displayText_format_c_format"] = "none",
			["height"] = 40,
			["displayText_format_s_format"] = "none",
			["fontSize"] = 16,
			["source"] = "import",
			["preferToUpdate"] = false,
			["cooldownEdge"] = false,
			["displayText_format_displayValue_format"] = "none",
			["zoom"] = 0,
			["authorOptions"] = {
				{
					["type"] = "number",
					["useDesc"] = true,
					["max"] = 100000,
					["step"] = 100,
					["width"] = 1,
					["min"] = 0,
					["key"] = "secureThreatValue",
					["desc"] = "The securely tanking threat differential value.",
					["name"] = "Secure Threat Target",
					["default"] = 10000,
				}, -- [1]
			},
			["displayText"] = "%c\n",
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
				["zoneIds"] = "",
				["class"] = {
					["multi"] = {
					},
				},
				["affixes"] = {
					["single"] = 16,
					["multi"] = {
						[16] = true,
					},
				},
				["use_affixes"] = true,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["race"] = {
					["multi"] = {
					},
				},
				["spec"] = {
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
				["ingroup"] = {
					["multi"] = {
						["group"] = true,
						["raid"] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["actions"] = {
				["start"] = {
					["custom"] = "",
					["do_custom"] = false,
				},
				["init"] = {
					["custom"] = "aura_env.secureThreatValue = aura_env.config.secureThreatValue\n\naura_env.ThreatFunc = function(unit)\n    local firstUnit, secondUnit\n    local firstThreat, secondThreat = 0, 0\n    local threat, pet\n    for member in WA_IterateGroupMembers() do\n        threat = select(5, UnitDetailedThreatSituation(member, unit))\n        if threat then\n            if threat > firstThreat then\n                secondUnit = firstUnit\n                secondThreat = firstThreat\n                firstUnit = member\n                firstThreat = threat\n            elseif threat > secondThreat then\n                secondUnit = member\n                secondThreat = threat\n            end\n        end\n        \n        pet = member..\"pet\"\n        if UnitExists(pet) then\n            threat = select(5, UnitDetailedThreatSituation(pet, unit))\n            if threat then\n                if threat > firstThreat then\n                    secondUnit = firstUnit\n                    secondThreat = firstThreat\n                    firstUnit = pet\n                    firstThreat = threat\n                elseif threat > secondThreat then\n                    secondUnit = pet\n                    secondThreat = threat\n                end\n            end\n        end\n    end\n    return firstUnit, firstThreat, secondUnit, secondThreat\nend",
					["do_custom"] = true,
				},
				["finish"] = {
					["do_custom"] = false,
				},
			},
			["displayText_format_p_time_precision"] = 1,
			["displayText_format_formatDiff_format"] = "none",
			["displayText_format_c1_format"] = "none",
			["anchorFrameType"] = "NAMEPLATE",
			["semver"] = "1.0.14",
			["desaturate"] = false,
			["id"] = "Threat Differential on Nameplates",
			["justify"] = "LEFT",
			["frameStrata"] = 1,
			["width"] = 40,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["anchorFrameParent"] = true,
			["inverse"] = false,
			["wordWrap"] = "WordWrap",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "status",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								0, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "status",
						["value"] = 2,
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								0.50196078431373, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [2]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "status",
						["value"] = 3,
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								1, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [3]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "status",
						["value"] = 4,
					},
					["changes"] = {
						{
							["value"] = {
								0, -- [1]
								0, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [4]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "status",
						["value"] = 5,
					},
					["changes"] = {
						{
							["value"] = {
								0, -- [1]
								1, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [5]
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["uid"] = "1L3Mp1qQdkX",
		},
		["Fel Iron Ore"] = {
			["iconSource"] = -1,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["itemName"] = 23424,
						["use_count"] = true,
						["use_absorbMode"] = true,
						["names"] = {
						},
						["debuffType"] = "HELPFUL",
						["type"] = "item",
						["unevent"] = "auto",
						["use_exact_itemName"] = true,
						["subeventPrefix"] = "SPELL",
						["use_itemName"] = true,
						["use_unit"] = true,
						["use_includeBank"] = true,
						["spellIds"] = {
						},
						["count"] = "0",
						["event"] = "Item Count",
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["unit"] = "player",
						["count_operator"] = ">",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_shadowXOffset"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_format"] = 0,
					["type"] = "subtext",
					["text_anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "PT Sans Narrow",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_anchorYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_text_format_p_time_precision"] = 1,
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_shadowYOffset"] = 0,
				}, -- [2]
				{
					["glowFrequency"] = 0,
					["type"] = "subglow",
					["useGlowColor"] = false,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowDuration"] = 1,
					["glowXOffset"] = 0,
					["glowThickness"] = 1,
					["glow"] = true,
					["glowScale"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 40,
			["load"] = {
				["use_namerealm"] = true,
				["ingroup"] = {
					["single"] = "solo",
				},
				["namerealm"] = "Mxzq",
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["use_ingroup"] = true,
				["zoneIds"] = "",
				["use_never"] = true,
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["source"] = "import",
			["config"] = {
			},
			["useTooltip"] = true,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["regionType"] = "icon",
			["cooldown"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["parent"] = "Ore Count",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["anchorFrameParent"] = false,
			["cooldownTextDisabled"] = false,
			["width"] = 40,
			["zoom"] = 0.3,
			["semver"] = "1.0.0",
			["tocversion"] = 90002,
			["id"] = "Fel Iron Ore",
			["frameStrata"] = 1,
			["useCooldownModRate"] = true,
			["anchorFrameType"] = "SCREEN",
			["alpha"] = 1,
			["uid"] = "ax30yT3st6L",
			["inverse"] = false,
			["xOffset"] = 0,
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["url"] = "https://wago.io/iST6tz9t8/1",
		},
		["SwingTimer - Queue skills"] = {
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["controlledChildren"] = {
				"Swing Timer", -- [1]
				"Swing Timer OH", -- [2]
				"Skills", -- [3]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["scale"] = 1,
			["load"] = {
				["talent"] = {
					["multi"] = {
					},
				},
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
			["border"] = false,
			["anchorFrameFrame"] = "WeakAuras:Swing Timer",
			["anchorPoint"] = "CENTER",
			["borderSize"] = 2,
			["authorOptions"] = {
			},
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["borderEdge"] = "Square Full White",
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
						["unit"] = "player",
						["names"] = {
						},
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["xOffset"] = 0,
			["internalVersion"] = 70,
			["yOffset"] = 0,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["id"] = "SwingTimer - Queue skills",
			["borderInset"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["uid"] = "hY)mjw)wuNd",
			["config"] = {
			},
			["borderOffset"] = 4,
			["selfPoint"] = "CENTER",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["regionType"] = "group",
		},
		["Anti-Magic Shell"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["wagoID"] = "v9qxdDgI4",
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["sparkHeight"] = 30,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["sparkOffsetX"] = 0,
			["cooldownSwipe"] = true,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["cooldownEdge"] = false,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Anti-Magic Shell", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showOnReady",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "aura2",
						["subeventSuffix"] = "_CAST_START",
						["unevent"] = "auto",
						["unit"] = "player",
						["names"] = {
						},
						["event"] = "Action Usable",
						["spellName"] = 34428,
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_genericShowOn"] = true,
						["useName"] = true,
						["subeventPrefix"] = "SPELL",
						["use_track"] = true,
						["useIgnoreName"] = false,
					},
					["untrigger"] = {
						["genericShowOn"] = "showOnReady",
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
			["internalVersion"] = 70,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["barColor"] = {
				0.2, -- [1]
				1, -- [2]
				0.0862745098039216, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["icon"] = true,
			["useTooltip"] = true,
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.75,
					["type"] = "subglow",
					["useGlowColor"] = true,
					["text_color"] = {
					},
					["glowThickness"] = 2,
					["glowDuration"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0.85098039215686, -- [2]
						0.1843137254902, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 16,
					["glow"] = true,
					["glowScale"] = 1,
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_p_time_precision"] = 1,
					["text_text"] = "%p",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_mod_rate"] = true,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_shadowXOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_p_format"] = "timed",
				}, -- [3]
			},
			["height"] = 40,
			["selfPoint"] = "CENTER",
			["load"] = {
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "DEATHKNIGHT",
					["multi"] = {
					},
				},
				["use_class"] = true,
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["use_level"] = false,
				["level"] = {
					"60", -- [1]
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["uid"] = "a3a2jKpBkcl",
			["cooldown"] = false,
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["displayIcon"] = "",
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "icon",
			["parent"] = "Vermin Death Knight",
			["config"] = {
			},
			["icon_side"] = "RIGHT",
			["anchorFrameFrame"] = "PlayerFrame",
			["id"] = "Anti-Magic Shell",
			["anchorFrameParent"] = false,
			["texture"] = "Melli",
			["width"] = 40,
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["auto"] = false,
			["useCooldownModRate"] = true,
			["sparkHidden"] = "NEVER",
			["cooldownTextDisabled"] = false,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["spark"] = false,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["inverse"] = false,
			["frameStrata"] = 1,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["zoom"] = 0.3,
		},
		["CP3"] = {
			["color"] = {
				0.99607843137255, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -283,
			["anchorPoint"] = "CENTER",
			["url"] = "https://wago.io/HCaWT5tJa/14",
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
						["use_power"] = true,
						["genericShowOn"] = "showOnActive",
						["use_unit"] = true,
						["powertype"] = 4,
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "unit",
						["unevent"] = "auto",
						["power_operator"] = {
							">=", -- [1]
						},
						["event"] = "Power",
						["unit"] = "player",
						["power"] = {
							"3", -- [1]
						},
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["use_requirePowerType"] = false,
						["names"] = {
						},
						["duration"] = "1",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["itemName"] = 150936,
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["genericShowOn"] = "showOnActive",
						["subeventPrefix"] = "SPELL",
						["unit"] = "player",
						["use_unit"] = true,
						["use_itemName"] = true,
						["unevent"] = "auto",
						["use_inverse"] = true,
						["event"] = "Item Equipped",
						["type"] = "item",
					},
					["untrigger"] = {
						["itemName"] = 150936,
					},
				}, -- [2]
				["disjunctive"] = "all",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["duration_type"] = "seconds",
					["preset"] = "slideright",
					["easeStrength"] = 3,
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["duration_type"] = "seconds",
					["preset"] = "slideleft",
					["easeStrength"] = 3,
				},
			},
			["desaturate"] = false,
			["rotation"] = 0,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 10,
			["rotate"] = true,
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["ROGUE"] = true,
						["DRUID"] = true,
					},
				},
				["use_class"] = false,
				["role"] = {
					["multi"] = {
					},
				},
				["level"] = {
					"70", -- [1]
				},
				["zoneIds"] = "",
				["talent2"] = {
					["multi"] = {
					},
				},
				["affixes"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 9,
					["multi"] = {
						[7] = true,
						[9] = true,
					},
				},
				["use_vehicle"] = false,
				["spec"] = {
					["multi"] = {
					},
				},
				["level_operator"] = {
					"<", -- [1]
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
				["use_vehicleUi"] = false,
				["use_combat"] = true,
				["use_level"] = false,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["textureWrapMode"] = "CLAMP",
			["mirror"] = false,
			["regionType"] = "texture",
			["blendMode"] = "BLEND",
			["alpha"] = 1,
			["texture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_White",
			["discrete_rotation"] = 0,
			["xOffset"] = 0,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "CP3",
			["parent"] = "MANA BAR + DRUID / ROGUE CPOINTS",
			["frameStrata"] = 2,
			["width"] = 67,
			["config"] = {
			},
			["uid"] = "q5EKjjhf3aN",
			["selfPoint"] = "CENTER",
			["anchorFrameType"] = "SCREEN",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["authorOptions"] = {
			},
		},
		["1. Target Cast Bar"] = {
			["controlledChildren"] = {
				"target cast bar - interruptable", -- [1]
				"target cast bar - uninterruptable", -- [2]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = 430,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["url"] = "https://wago.io/r19H1zQ4Z/1",
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
						["type"] = "unit",
						["use_alwaystrue"] = false,
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Conditions",
						["subeventPrefix"] = "SPELL",
						["spellIds"] = {
						},
						["names"] = {
						},
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
			},
			["version"] = 1,
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
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
				["use_class"] = false,
				["race"] = {
					["multi"] = {
					},
				},
				["role"] = {
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
				["faction"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["source"] = "import",
			["scale"] = 1,
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "group",
			["borderSize"] = 2,
			["borderOffset"] = 4,
			["semver"] = "1.0.0",
			["id"] = "1. Target Cast Bar",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["uid"] = "wmcOTwTtaQ9",
			["borderInset"] = 1,
			["authorOptions"] = {
			},
			["config"] = {
			},
			["conditions"] = {
			},
			["information"] = {
				["groupOffset"] = true,
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["selfPoint"] = "BOTTOMLEFT",
		},
		["Runic Power Bar"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -100,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["url"] = "https://wago.io/HCaWT5tJa/14",
			["backgroundColor"] = {
				0.32549019607843, -- [1]
				0.53725490196078, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["fontFlags"] = "OUTLINE",
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["enableGradient"] = false,
			["selfPoint"] = "CENTER",
			["barColor"] = {
				0.32549019607843, -- [1]
				0.53725490196078, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["sparkOffsetY"] = 0,
			["gradientOrientation"] = "HORIZONTAL",
			["load"] = {
				["zoneIds"] = "",
				["use_petbattle"] = false,
				["use_never"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["use_vehicle"] = false,
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["DEATHKNIGHT"] = true,
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
				["use_class"] = false,
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
				["difficulty"] = {
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
				["talent2"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["texture"] = "xVerminClean",
			["zoom"] = 0,
			["auto"] = true,
			["tocversion"] = 11302,
			["alpha"] = 1,
			["config"] = {
			},
			["sparkOffsetX"] = 0,
			["parent"] = "Power Bar Group",
			["customText"] = "",
			["sparkRotationMode"] = "AUTO",
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "1",
						["use_showCost"] = true,
						["names"] = {
						},
						["powertype"] = 6,
						["use_powertype"] = true,
						["custom_hide"] = "timed",
						["genericShowOn"] = "showOnActive",
						["type"] = "unit",
						["use_health"] = true,
						["unevent"] = "auto",
						["use_power"] = false,
						["health_operator"] = ">=",
						["use_requirePowerType"] = true,
						["use_percentpower"] = false,
						["subeventSuffix"] = "_CAST_START",
						["health"] = "0",
						["spellIds"] = {
						},
						["event"] = "Power",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["use_unit"] = true,
						["unit"] = "player",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "all",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
			},
			["backdropInFront"] = false,
			["stickyDuration"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subforeground",
				}, -- [2]
				{
					["text_shadowXOffset"] = 1,
					["text_text"] = "%p / %t",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_fixedWidth"] = 64,
					["text_text_format_c_format"] = "none",
					["rotateText"] = "NONE",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_text_format_ct_format"] = "none",
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_text_format_t_time_format"] = 0,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["text_text_format_t_format"] = "timed",
					["type"] = "subtext",
					["text_text_format_p_time_mod_rate"] = true,
					["text_text_format_p_time_precision"] = 1,
					["text_font"] = "Arial Narrow",
					["text_text_format_p_time_legacy_floor"] = false,
					["text_anchorYOffset"] = -1,
					["text_text_format_t_time_dynamic_threshold"] = 60,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_t_time_mod_rate"] = true,
					["text_anchorPoint"] = "INNER_CENTER",
					["text_text_format_t_time_legacy_floor"] = false,
					["text_shadowYOffset"] = -1,
					["text_text_format_t_time_precision"] = 1,
					["text_text_format_p_time_format"] = 0,
					["text_visible"] = true,
				}, -- [3]
			},
			["height"] = 6,
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["uid"] = "1WKr(cyEFvs",
			["barColor2"] = {
				1, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["borderInFront"] = true,
			["overlays"] = {
				{
					0.43529411764706, -- [1]
					0, -- [2]
					1, -- [3]
					0.25, -- [4]
				}, -- [1]
			},
			["icon_side"] = "RIGHT",
			["borderBackdrop"] = "None",
			["backdropColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["sparkHeight"] = 30,
			["customTextUpdate"] = "event",
			["overlaysTexture"] = {
				"xVerminClean", -- [1]
			},
			["width"] = 220,
			["semver"] = "1.0.13",
			["sparkHidden"] = "NEVER",
			["id"] = "Runic Power Bar",
			["spark"] = false,
			["frameStrata"] = 3,
			["anchorFrameType"] = "SCREEN",
			["icon"] = false,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["custom"] = "if aura_env.region then\n    local r = aura_env.region\n    if not r.text3 then\n        local text3 = r.bar:CreateFontString(nil, \"OVERLAY\")\n        r.text3 = text3\n        r.text3:SetJustifyH(\"CENTER\")\n        r.text3:SetJustifyV(\"MIDDLE\")\n        r.text3:SetPoint(\"CENTER\", r.bar, \"CENTER\")\n        r.text3:Show()\n    end\n    r.text3:SetShadowOffset(1, -1)\n    r.text3:SetFont(r.text:GetFont())\n    r.text3:SetTextColor(r.text:GetTextColor())\nend\n\n\n\n\n\n\n",
					["do_custom"] = false,
				},
				["finish"] = {
				},
			},
			["inverse"] = true,
			["sparkDesature"] = false,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["xOffset"] = 0,
		},
		["Vermin ItemRack SetSwapper"] = {
			["grow"] = "LEFT",
			["controlledChildren"] = {
				"DPS", -- [1]
				"HEAL", -- [2]
				"TANK", -- [3]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["xOffset"] = -135,
			["preferToUpdate"] = false,
			["yOffset"] = -20,
			["gridType"] = "RD",
			["fullCircle"] = true,
			["useAnchorPerUnit"] = false,
			["url"] = "https://wago.io/Efx8AqHgR/2",
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
			["columnSpace"] = 1,
			["internalVersion"] = 70,
			["useLimit"] = true,
			["align"] = "CENTER",
			["limit"] = 6,
			["gridWidth"] = 3,
			["stagger"] = 0,
			["rotation"] = 0,
			["sortHybridTable"] = {
				["S2"] = false,
				["S1"] = false,
				["S3"] = false,
				["S4"] = false,
				["S5"] = false,
			},
			["version"] = 2,
			["subRegions"] = {
			},
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["space"] = 2,
			["load"] = {
				["use_class"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
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
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["rowSpace"] = 1,
			["source"] = "import",
			["uid"] = "UzQWUcp9ivi",
			["scale"] = 1,
			["centerType"] = "LR",
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["stepAngle"] = 15,
			["borderSize"] = 2,
			["sort"] = "none",
			["selfPoint"] = "RIGHT",
			["animate"] = false,
			["constantFactor"] = "RADIUS",
			["anchorPoint"] = "CENTER",
			["borderOffset"] = 4,
			["semver"] = "1.0.1",
			["tocversion"] = 11305,
			["id"] = "Vermin ItemRack SetSwapper",
			["regionType"] = "dynamicgroup",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["borderInset"] = 1,
			["config"] = {
			},
			["authorOptions"] = {
			},
			["radius"] = 200,
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["arcLength"] = 360,
		},
		["DPS"] = {
			["iconSource"] = -1,
			["parent"] = "Vermin ItemRack SetSwapper",
			["preferToUpdate"] = false,
			["customText"] = "function()\n    return aura_env.config.set\nend",
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
					["custom"] = "if not aura_env.region._clickableFrame1 then\n    aura_env.region._clickableFrame1 = CreateFrame(\"BUTTON\", nil, aura_env.region)\nend\nlocal options_input1 = aura_env.config[\"set\"]\naura_env.region._clickableFrame1:SetAllPoints()\naura_env.region._clickableFrame1:SetScript(\"OnClick\", function()\n        EquipSet(options_input1)\n    end\n)",
					["do_custom"] = true,
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["subeventSuffix"] = "_CAST_START",
						["names"] = {
						},
						["event"] = "Health",
						["unit"] = "player",
						["custom_type"] = "status",
						["subeventPrefix"] = "SPELL",
						["spellIds"] = {
						},
						["customIcon"] = "function(e)\n    local set = aura_env.config[\"set\"]\n    if ItemRackUser.Sets[set] then\n        return ItemRackUser.Sets[set].icon\n    end\nend",
						["check"] = "event",
						["events"] = "PLAYER_ENTERING_WORLD, PLAYER_EQUIPMENT_CHANGED",
						["custom"] = "function ()\n    local thingy1 = IsSetEquipped(aura_env.config[\"set\"])\n    if thingy1 == true then\n        return true\n    end\nend",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["unevent"] = "auto",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "custom",
				["customTriggerLogic"] = "function(e)\n    local set = aura_env.config[\"set\"]\n    if ItemRackUser.Sets[set] then\n        return true\n    else\n        return false\n    end\nend",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 2,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.25,
					["type"] = "subglow",
					["glowDuration"] = 1,
					["glowScale"] = 1,
					["glowThickness"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						0.3490196168422699, -- [1]
						0.8352941870689392, -- [2]
						0.8078432083129883, -- [3]
						1, -- [4]
					},
					["useGlowColor"] = false,
					["glowXOffset"] = 0,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glow"] = false,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "%c",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_shadowXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "OUTER_BOTTOM",
					["text_text_format_p_time_precision"] = 1,
					["text_text_format_p_format"] = "timed",
					["text_fontSize"] = 10,
					["anchorXOffset"] = 0,
					["text_text_format_c_format"] = "none",
				}, -- [3]
			},
			["height"] = 32,
			["load"] = {
				["use_level"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["DRUID"] = true,
					},
				},
				["zoneIds"] = "",
				["level_operator"] = {
					"==", -- [1]
				},
				["use_never"] = false,
				["level"] = {
					"60", -- [1]
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
			["source"] = "import",
			["cooldownTextDisabled"] = false,
			["xOffset"] = 0,
			["authorOptions"] = {
				{
					["type"] = "input",
					["useDesc"] = false,
					["width"] = 1,
					["default"] = "",
					["name"] = "Set",
					["multiline"] = false,
					["key"] = "set",
					["length"] = 10,
					["desc"] = "Enter the exact name of the set from ItemRack",
					["useLength"] = false,
				}, -- [1]
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["regionType"] = "icon",
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = -1,
						["variable"] = "incombat",
						["value"] = 1,
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
						["variable"] = "show",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "sub.2.glow",
						}, -- [1]
					},
				}, -- [2]
			},
			["selfPoint"] = "CENTER",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["config"] = {
				["set"] = "dps",
			},
			["anchorFrameParent"] = false,
			["width"] = 32,
			["useCooldownModRate"] = true,
			["zoom"] = 0,
			["auto"] = true,
			["tocversion"] = 11305,
			["id"] = "DPS",
			["semver"] = "1.0.1",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["alpha"] = 1,
			["uid"] = "i4dqb61BNMq",
			["inverse"] = false,
			["icon"] = true,
			["displayIcon"] = 136235,
			["cooldown"] = true,
			["url"] = "https://wago.io/Efx8AqHgR/2",
		},
		["Melee Range Reminder"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "Noeo3Gn5Q",
			["authorOptions"] = {
			},
			["displayText"] = "%c",
			["customText"] = "function()\n    \n    if not aura_env.last or aura_env.last < GetTime() - 0.05 then\n        aura_env.last = GetTime()\n        \n        \n        if UnitExists(\"target\") and not IsItemInRange(16114, \"target\") then -- Foreman's Blackjack\n            aura_env.displayText = \"TOO FAR\"\n        elseif IsCurrentSpell(6603) == false then -- Auto Attack\n            aura_env.displayText = \"NOT ATTACKING\"\n        else \n            aura_env.displayText = \"\"\n        end\n        \n    end\n    \n    return aura_env.displayText\n    \nend\n\n\n",
			["yOffset"] = 180,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/Noeo3Gn5Q/5",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "aura_env.displayText=\"\"",
					["do_custom"] = true,
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "unit",
						["use_incombat"] = true,
						["unevent"] = "auto",
						["percenthealth"] = "0",
						["duration"] = "1",
						["event"] = "Conditions",
						["use_unit"] = true,
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["unit"] = "target",
						["use_percenthealth"] = true,
						["percenthealth_operator"] = ">",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
						["unit"] = "target",
					},
				}, -- [1]
				{
					["trigger"] = {
						["use_class"] = true,
						["type"] = "unit",
						["unit"] = "player",
						["use_unit"] = true,
						["classification"] = {
						},
						["class"] = "DEATHKNIGHT",
						["event"] = "Unit Characteristics",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				{
					["trigger"] = {
						["use_class"] = true,
						["type"] = "unit",
						["debuffType"] = "HELPFUL",
						["use_unit"] = true,
						["class"] = "WARRIOR",
						["event"] = "Unit Characteristics",
						["unit"] = "player",
					},
					["untrigger"] = {
					},
				}, -- [3]
				{
					["trigger"] = {
						["type"] = "unit",
						["class"] = "DRUID",
						["event"] = "Unit Characteristics",
						["unit"] = "player",
						["use_class"] = true,
						["use_character"] = false,
						["classification"] = {
						},
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [4]
				{
					["trigger"] = {
						["type"] = "unit",
						["debuffType"] = "HELPFUL",
						["use_form"] = true,
						["use_unit"] = true,
						["form"] = {
							["single"] = 1,
						},
						["event"] = "Stance/Form/Aura",
						["unit"] = "player",
					},
					["untrigger"] = {
					},
				}, -- [5]
				{
					["trigger"] = {
						["type"] = "unit",
						["debuffType"] = "HELPFUL",
						["use_form"] = true,
						["use_unit"] = true,
						["form"] = {
							["single"] = 3,
						},
						["event"] = "Stance/Form/Aura",
						["unit"] = "player",
					},
					["untrigger"] = {
					},
				}, -- [6]
				{
					["trigger"] = {
						["use_class"] = true,
						["type"] = "unit",
						["unit"] = "player",
						["use_unit"] = true,
						["class"] = "PALADIN",
						["event"] = "Unit Characteristics",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [7]
				["disjunctive"] = "custom",
				["customTriggerLogic"] = "function(trigger)\n    return trigger[1] and (trigger[2] or trigger[3] or trigger[7] or (trigger[4] and (trigger[5] or trigger[6])));\nend",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["preset"] = "bounce",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["font"] = "Arial Narrow",
			["version"] = 5,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_namerealm"] = false,
				["namerealm"] = "Wherefore",
				["talent"] = {
					["multi"] = {
					},
				},
				["use_vehicle"] = false,
				["class"] = {
					["single"] = "ROGUE",
					["multi"] = {
						["DEATHKNIGHT"] = true,
						["WARRIOR"] = true,
						["DRUID"] = true,
					},
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["use_never"] = false,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 55,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["regionType"] = "text",
			["conditions"] = {
			},
			["selfPoint"] = "CENTER",
			["displayText_format_c_format"] = "none",
			["automaticWidth"] = "Auto",
			["shadowYOffset"] = -1,
			["color"] = {
				1, -- [1]
				0.011764705882353, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["semver"] = "1.0.4",
			["tocversion"] = 30400,
			["id"] = "Melee Range Reminder",
			["config"] = {
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "UIPARENT",
			["xOffset"] = 0,
			["uid"] = "0XxQZlEF0)k",
			["justify"] = "CENTER",
			["wordWrap"] = "WordWrap",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["preferToUpdate"] = false,
		},
		["Maul"] = {
			["sparkWidth"] = 10,
			["sparkOffsetX"] = 0,
			["wagoID"] = "v9qxdDgI4",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["cooldownSwipe"] = true,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"29838", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showOnReady",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
						["spellName"] = 9881,
						["useName"] = true,
						["unit"] = "player",
						["unevent"] = "auto",
						["subeventSuffix"] = "_CAST_START",
						["names"] = {
						},
						["event"] = "Queued Action",
						["use_exact_spellName"] = false,
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_genericShowOn"] = true,
						["type"] = "spell",
						["subeventPrefix"] = "SPELL",
						["use_track"] = true,
						["useIgnoreName"] = false,
					},
					["untrigger"] = {
						["genericShowOn"] = "showOnReady",
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
			["useTooltip"] = false,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["iconSource"] = -1,
			["parent"] = "Skills",
			["barColor"] = {
				0.2, -- [1]
				1, -- [2]
				0.0862745098039216, -- [3]
				1, -- [4]
			},
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["config"] = {
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.75,
					["type"] = "subglow",
					["useGlowColor"] = true,
					["text_color"] = {
					},
					["glowThickness"] = 2,
					["glowDuration"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0.85098039215686, -- [2]
						0.1843137254902, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 16,
					["glow"] = true,
					["glowScale"] = 1,
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_p_time_precision"] = 1,
					["text_text"] = "%p",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_mod_rate"] = true,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_shadowXOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_p_format"] = "timed",
				}, -- [3]
			},
			["height"] = 40,
			["internalVersion"] = 70,
			["load"] = {
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
						["WARRIOR"] = true,
					},
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["use_level"] = false,
				["level"] = {
					"60", -- [1]
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["selfPoint"] = "CENTER",
			["cooldown"] = false,
			["displayIcon"] = 132136,
			["desaturate"] = false,
			["cooldownTextDisabled"] = false,
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "icon",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["icon_side"] = "RIGHT",
			["xOffset"] = 0,
			["width"] = 40,
			["sparkHeight"] = 30,
			["texture"] = "Melli",
			["useCooldownModRate"] = true,
			["zoom"] = 0.3,
			["auto"] = false,
			["sparkHidden"] = "NEVER",
			["id"] = "Maul",
			["anchorFrameFrame"] = "PlayerFrame",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["spark"] = false,
			["uid"] = "CYV)viIZ0wT",
			["inverse"] = false,
			["alpha"] = 1,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
		},
		["Shield Wall"] = {
			["sparkWidth"] = 10,
			["sparkOffsetX"] = 0,
			["wagoID"] = "v9qxdDgI4",
			["parent"] = "Vermin Warrior",
			["preferToUpdate"] = false,
			["sparkHeight"] = 30,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["iconSource"] = -1,
			["cooldownSwipe"] = true,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["cooldownEdge"] = false,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Shield Wall", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showOnReady",
						["names"] = {
						},
						["debuffType"] = "HELPFUL",
						["type"] = "aura2",
						["use_unit"] = true,
						["unevent"] = "auto",
						["subeventPrefix"] = "SPELL",
						["unit"] = "player",
						["event"] = "Action Usable",
						["subeventSuffix"] = "_CAST_START",
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_genericShowOn"] = true,
						["useName"] = true,
						["spellName"] = 34428,
						["use_track"] = true,
						["useIgnoreName"] = false,
					},
					["untrigger"] = {
						["genericShowOn"] = "showOnReady",
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
			["internalVersion"] = 70,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["xOffset"] = 0,
			["authorOptions"] = {
			},
			["barColor"] = {
				0.2, -- [1]
				1, -- [2]
				0.0862745098039216, -- [3]
				1, -- [4]
			},
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["useTooltip"] = false,
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.75,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["text_color"] = {
					},
					["glowThickness"] = 2,
					["glowDuration"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0.85098039215686, -- [2]
						0.1843137254902, -- [3]
						1, -- [4]
					},
					["useGlowColor"] = true,
					["glow"] = true,
					["glowLength"] = 16,
					["glowType"] = "buttonOverlay",
					["glowScale"] = 1,
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "%p",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_mod_rate"] = true,
					["type"] = "subtext",
					["anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_shadowXOffset"] = 0,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 12,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_p_format"] = "timed",
				}, -- [3]
			},
			["height"] = 36,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["load"] = {
				["use_level"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
						["WARRIOR"] = true,
					},
				},
				["use_class"] = false,
				["size"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["level"] = {
					"60", -- [1]
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["zoneIds"] = "",
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["uid"] = "HmB0mh3vIQc",
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["desaturate"] = false,
			["icon"] = true,
			["conditions"] = {
			},
			["smoothProgress"] = true,
			["anchorFrameFrame"] = "PlayerFrame",
			["regionType"] = "icon",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["config"] = {
			},
			["icon_side"] = "RIGHT",
			["useAdjustededMin"] = false,
			["id"] = "Shield Wall",
			["anchorFrameParent"] = false,
			["texture"] = "Melli",
			["width"] = 36,
			["cooldownTextDisabled"] = false,
			["auto"] = false,
			["alpha"] = 1,
			["sparkHidden"] = "NEVER",
			["zoom"] = 0.3,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["spark"] = false,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["inverse"] = false,
			["useCooldownModRate"] = true,
			["orientation"] = "HORIZONTAL",
			["displayIcon"] = "",
			["cooldown"] = false,
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
		},
		["Warrior - Berserker Stance"] = {
			["outline"] = "OUTLINE",
			["xOffset"] = 0,
			["displayText"] = "BERSERKER STANCE",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["automaticWidth"] = "Auto",
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
						["type"] = "unit",
						["use_form"] = true,
						["unevent"] = "auto",
						["form"] = {
							["single"] = 3,
						},
						["use_inverse"] = false,
						["event"] = "Stance/Form/Aura",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["duration"] = "1",
						["use_unit"] = true,
						["names"] = {
						},
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["wordWrap"] = "WordWrap",
			["font"] = "Arial Narrow",
			["version"] = 16,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_class"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["size"] = {
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
				["zoneIds"] = "",
			},
			["fontSize"] = 21,
			["shadowXOffset"] = 1,
			["regionType"] = "text",
			["conditions"] = {
			},
			["parent"] = "Vermin Warrior Stance",
			["preferToUpdate"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
			},
			["selfPoint"] = "BOTTOM",
			["justify"] = "LEFT",
			["semver"] = "1.0.15",
			["tocversion"] = 11302,
			["id"] = "Warrior - Berserker Stance",
			["uid"] = "rPVBYBZyMKI",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["color"] = {
				1, -- [1]
				0.37254901960784, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["config"] = {
			},
			["authorOptions"] = {
			},
			["shadowYOffset"] = -1,
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["url"] = "https://wago.io/z6xqQay0S/16",
		},
		["Loss of Control Top"] = {
			["wagoID"] = "JiQILDF99",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = 42,
			["anchorPoint"] = "CENTER",
			["url"] = "https://wago.io/JiQILDF99/1",
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
						["type"] = "custom",
						["custom_type"] = "event",
						["custom_hide"] = "custom",
						["event"] = "Health",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["events"] = "LOSS_OF_CONTROL_UPDATE",
						["names"] = {
						},
						["check"] = "event",
						["spellIds"] = {
						},
						["custom"] = "function (allstates, event, ...)\n    local activeLossOfControlCount = C_LossOfControl.GetActiveLossOfControlDataCount()\n    if activeLossOfControlCount > 0 then return true end\n    return false\nend",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
						["custom"] = "function (allstates, event, ...)\n    local activeLossOfControlCount = C_LossOfControl.GetActiveLossOfControlDataCount()\n    if activeLossOfControlCount <= 0 then return true end\n    return false\nend",
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["colorR"] = 1,
					["duration"] = "0.2",
					["alphaType"] = "straight",
					["colorA"] = 1,
					["colorG"] = 1,
					["alphaFunc"] = "function(progress, start, delta)\n    return start + (progress * delta)\nend\n",
					["use_alpha"] = true,
					["type"] = "custom",
					["easeType"] = "none",
					["scaley"] = 1,
					["alpha"] = 0,
					["y"] = 0,
					["x"] = 0,
					["scalex"] = 1,
					["preset"] = "fade",
					["easeStrength"] = 3,
					["rotate"] = 0,
					["colorB"] = 1,
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["colorR"] = 1,
					["duration"] = "0.2",
					["alphaType"] = "straight",
					["colorA"] = 1,
					["colorG"] = 1,
					["alphaFunc"] = "function(progress, start, delta)\n    return start + (progress * delta)\nend\n",
					["use_alpha"] = true,
					["type"] = "custom",
					["easeType"] = "none",
					["scaley"] = 1,
					["alpha"] = 0,
					["y"] = 0,
					["x"] = 0,
					["scalex"] = 1,
					["preset"] = "fade",
					["easeStrength"] = 3,
					["rotate"] = 0,
					["colorB"] = 1,
					["duration_type"] = "seconds",
				},
			},
			["desaturate"] = false,
			["rotation"] = 0,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 30,
			["rotate"] = false,
			["load"] = {
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
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
			["textureWrapMode"] = "CLAMPTOBLACKADDITIVE",
			["source"] = "import",
			["mirror"] = false,
			["regionType"] = "texture",
			["blendMode"] = "ADD",
			["color"] = {
				1, -- [1]
				0, -- [2]
				0.007843137254902, -- [3]
				1, -- [4]
			},
			["discrete_rotation"] = 0,
			["texture"] = "Interface\\Cooldown\\Loc-RedLine",
			["xOffset"] = 0,
			["displayIcon"] = 136071,
			["semver"] = "1.0.0",
			["tocversion"] = 30400,
			["id"] = "Loss of Control Top",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["width"] = 200,
			["config"] = {
			},
			["uid"] = "uOWR(23TCVs",
			["parent"] = "Loss of Control Alert (WOTLK)",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["selfPoint"] = "CENTER",
		},
		["Fade in-out Text Combat Indicator"] = {
			["controlledChildren"] = {
				"Entering Combat", -- [1]
				"Leaving Combat", -- [2]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["wagoID"] = "03U1JIxdy",
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["url"] = "https://wago.io/03U1JIxdy/1",
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
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["event"] = "Health",
						["names"] = {
						},
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desc"] = "Made by cakemos",
			["version"] = 1,
			["subRegions"] = {
			},
			["load"] = {
				["talent"] = {
					["multi"] = {
					},
				},
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
			["source"] = "import",
			["scale"] = 0.9,
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "group",
			["borderSize"] = 2,
			["borderOffset"] = 4,
			["semver"] = "1.0.0",
			["tocversion"] = 30400,
			["id"] = "Fade in-out Text Combat Indicator",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["uid"] = "BqsbsH4)Oho",
			["config"] = {
			},
			["borderInset"] = 1,
			["authorOptions"] = {
			},
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["selfPoint"] = "CENTER",
		},
		["Revenge Death"] = {
			["iconSource"] = -1,
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["type"] = "spell",
						["unevent"] = "auto",
						["use_unit"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["use_genericShowOn"] = true,
						["realSpellName"] = "Revenge",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["spellName"] = 6572,
						["use_track"] = true,
						["names"] = {
						},
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "custom",
						["debuffType"] = "HELPFUL",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["duration"] = "5",
						["event"] = "Health",
						["unit"] = "player",
						["customDuration"] = "function()\n    return 5, GetTime()+5\nend",
						["events"] = "CLEU",
						["spellIds"] = {
						},
						["names"] = {
						},
						["check"] = "event",
						["custom"] = "function (event,...)\n    if select(8,...)==UnitGUID(\"player\") then\n        if select(2,...) == \"SWING_MISSED\" then --sub event\n            if select(12,...) ==\"DODGE\" \n            or select(12,...) ==\"BLOCK\" \n            or select(12,...) ==\"PARRY\" then --miss type\n                aura_env.RevengeTime=select(1,...)\n                aura_env.RevengeActive =true\n                return true\n            end\n        end\n        if select(2,...) == \"RANGE_MISSED\" then\n            if select(15,...) ==\"BLOCK\" then\n                aura_env.RevengeTime=select(1,...)\n                aura_env.RevengeActive=true\n                return true\n            end\n        end\n    end\nend",
						["custom_type"] = "event",
						["custom_hide"] = "custom",
					},
					["untrigger"] = {
						["custom"] = "function (event,...)\n    if aura_env.RevengeActive == true\n    and select(1,...) > 5+aura_env.RevengeTime then\n        aura_env.RevengeActive = false\n        return true\n    end\n    \n    if select(4,...)==UnitGUID(\"player\") and select(8,...)==UnitGUID(\"target\") then\n        if select(2,...) == \"SPELL_CAST_SUCCESS\"\n        or select(2,...) == \"SPELL_CAT_FAILED\" then --sub event\n            if select(13,...) ==\"Revenge\"\n            or select(13,...) == \"Overpower\" then --spell name\n                aura_env.RevengeActive = false\n                return true\n            end\n        end\n        \n    end\nend\n\n\n\n",
					},
				}, -- [2]
				{
					["trigger"] = {
						["type"] = "unit",
						["unevent"] = "auto",
						["power_operator"] = {
							"<", -- [1]
						},
						["duration"] = "1",
						["event"] = "Power",
						["use_unit"] = true,
						["powertype"] = 1,
						["unit"] = "player",
						["power"] = {
							"5", -- [1]
						},
						["use_power"] = true,
						["subeventPrefix"] = "SPELL",
						["use_powertype"] = true,
						["subeventSuffix"] = "_CAST_START",
					},
					["untrigger"] = {
					},
				}, -- [3]
				["disjunctive"] = "custom",
				["customTriggerLogic"] = "function(t)\n    return t[2];\nend",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.25,
					["glow"] = true,
					["useGlowColor"] = false,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["glowThickness"] = 1,
					["glowScale"] = 1,
					["glowDuration"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_shadowXOffset"] = 0,
					["text_text"] = "%2.p",
					["text_text_format_2.p_time_format"] = 0,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_text_format_2.p_time_legacy_floor"] = true,
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_2.p_format"] = "timed",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_automaticWidth"] = "Auto",
					["text_shadowYOffset"] = 0,
					["text_text_format_2.p_time_dynamic_threshold"] = 60,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_visible"] = true,
					["text_text_format_2.p_time_precision"] = 1,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_2.p_time_mod_rate"] = true,
				}, -- [3]
			},
			["height"] = 36,
			["load"] = {
				["use_class"] = false,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
						["WARRIOR"] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["source"] = "import",
			["zoom"] = 0,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
			},
			["parent"] = "Vermin Warrior",
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["regionType"] = "icon",
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 3,
						["variable"] = "show",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "aura_env.RevengeActive = false",
					["do_custom"] = true,
				},
			},
			["config"] = {
			},
			["anchorFrameParent"] = false,
			["width"] = 36,
			["frameStrata"] = 1,
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["tocversion"] = 11302,
			["id"] = "Revenge Death",
			["useCooldownModRate"] = true,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["semver"] = "1.0.0",
			["uid"] = "CoEZMPpiTY2",
			["inverse"] = false,
			["url"] = "https://wago.io/TisJLTlYN/1",
			["displayIcon"] = 132223,
			["cooldown"] = false,
			["authorOptions"] = {
			},
		},
		["Fury of Stormrage"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["wagoID"] = "v9qxdDgI4",
			["parent"] = "Vermin Druid",
			["preferToUpdate"] = false,
			["id"] = "Fury of Stormrage",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["sparkOffsetX"] = 0,
			["cooldownSwipe"] = true,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Fury of Stormrage", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showOnReady",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["useName"] = true,
						["unevent"] = "auto",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["event"] = "Action Usable",
						["type"] = "aura2",
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_genericShowOn"] = true,
						["spellName"] = 34428,
						["names"] = {
						},
						["use_track"] = true,
						["useIgnoreName"] = false,
					},
					["untrigger"] = {
						["genericShowOn"] = "showOnReady",
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
			["useTooltip"] = false,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["xOffset"] = 0,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["barColor"] = {
				0.2, -- [1]
				1, -- [2]
				0.0862745098039216, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["internalVersion"] = 70,
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.5,
					["type"] = "subglow",
					["glowDuration"] = 1,
					["text_color"] = {
					},
					["glowThickness"] = 3,
					["useGlowColor"] = true,
					["glowYOffset"] = 0,
					["glowColor"] = {
						0, -- [1]
						1, -- [2]
						0.08627451211214066, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["glowScale"] = 1,
					["glow"] = true,
					["glowLength"] = 16,
					["glowType"] = "buttonOverlay",
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "%p",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["type"] = "subtext",
					["anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "OUTER_TOP",
					["text_shadowXOffset"] = 0,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 10,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_p_time_mod_rate"] = true,
				}, -- [3]
			},
			["height"] = 36,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["load"] = {
				["use_level"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["use_class"] = true,
				["use_spellknown"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
					},
				},
				["use_never"] = false,
				["level"] = {
					"5", -- [1]
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["authorOptions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["conditions"] = {
			},
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "icon",
			["config"] = {
			},
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["icon_side"] = "RIGHT",
			["anchorFrameFrame"] = "PlayerFrame",
			["useCooldownModRate"] = true,
			["sparkHeight"] = 30,
			["texture"] = "Melli",
			["width"] = 36,
			["zoom"] = 0,
			["spark"] = false,
			["alpha"] = 1,
			["sparkHidden"] = "NEVER",
			["anchorFrameParent"] = false,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = false,
			["uid"] = "9kDPIykmPmk",
			["inverse"] = false,
			["auto"] = false,
			["orientation"] = "HORIZONTAL",
			["displayIcon"] = "",
			["cooldown"] = false,
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
		},
		["Mana Bar "] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -300,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["url"] = "https://wago.io/HCaWT5tJa/14",
			["backgroundColor"] = {
				0.32549019607843, -- [1]
				0.53725490196078, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["fontFlags"] = "OUTLINE",
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["enableGradient"] = false,
			["selfPoint"] = "CENTER",
			["barColor"] = {
				0.32549019607843, -- [1]
				0.53725490196078, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["sparkOffsetY"] = 0,
			["gradientOrientation"] = "HORIZONTAL",
			["load"] = {
				["zoneIds"] = "",
				["use_petbattle"] = false,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["use_vehicle"] = false,
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["HUNTER"] = true,
						["WARLOCK"] = true,
						["SHAMAN"] = true,
						["MAGE"] = true,
						["DRUID"] = true,
						["PALADIN"] = true,
						["PRIEST"] = true,
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
				["role"] = {
					["multi"] = {
					},
				},
				["use_class"] = false,
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
				["difficulty"] = {
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
				["talent2"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["texture"] = "xVerminClean",
			["zoom"] = 0,
			["auto"] = true,
			["tocversion"] = 11302,
			["alpha"] = 1,
			["config"] = {
			},
			["sparkOffsetX"] = 0,
			["parent"] = "MANA BAR + DRUID / ROGUE CPOINTS",
			["customText"] = "",
			["sparkRotationMode"] = "AUTO",
			["triggers"] = {
				{
					["trigger"] = {
						["use_power"] = false,
						["use_showCost"] = true,
						["names"] = {
						},
						["powertype"] = 0,
						["use_powertype"] = true,
						["custom_hide"] = "timed",
						["unevent"] = "auto",
						["type"] = "unit",
						["use_health"] = true,
						["health_operator"] = ">=",
						["genericShowOn"] = "showOnActive",
						["subeventSuffix"] = "_CAST_START",
						["use_requirePowerType"] = true,
						["use_percentpower"] = false,
						["duration"] = "1",
						["spellIds"] = {
						},
						["health"] = "0",
						["event"] = "Power",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["use_unit"] = true,
						["unit"] = "player",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "all",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
			},
			["backdropInFront"] = false,
			["stickyDuration"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subforeground",
				}, -- [2]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "%p / %t",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_fixedWidth"] = 64,
					["text_text_format_c_format"] = "none",
					["rotateText"] = "NONE",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_text_format_ct_format"] = "none",
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_text_format_t_time_format"] = 0,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["text_text_format_t_format"] = "timed",
					["type"] = "subtext",
					["text_text_format_t_time_legacy_floor"] = false,
					["text_font"] = "Arial Narrow",
					["text_shadowXOffset"] = 1,
					["text_text_format_p_time_legacy_floor"] = false,
					["text_text_format_t_time_precision"] = 1,
					["text_text_format_t_time_dynamic_threshold"] = 60,
					["text_text_format_t_time_mod_rate"] = true,
					["text_anchorPoint"] = "INNER_RIGHT",
					["text_text_format_p_time_mod_rate"] = true,
					["text_text_format_p_time_precision"] = 1,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_shadowYOffset"] = -1,
					["text_visible"] = true,
				}, -- [3]
				{
					["text_shadowXOffset"] = 1,
					["text_text"] = " ",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Arial Narrow",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_LEFT",
					["text_fontSize"] = 18,
					["anchorXOffset"] = 0,
					["text_fontType"] = "None",
				}, -- [4]
				{
					["text_shadowXOffset"] = 1,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Arial Narrow",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "ICON_CENTER",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_fontType"] = "None",
				}, -- [5]
			},
			["height"] = 20,
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["overlays"] = {
				{
					0.43529411764706, -- [1]
					0, -- [2]
					1, -- [3]
					0.25, -- [4]
				}, -- [1]
			},
			["barColor2"] = {
				1, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["backdropColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["borderBackdrop"] = "None",
			["borderInFront"] = true,
			["uid"] = "s26VuU36rAY",
			["icon_side"] = "RIGHT",
			["customTextUpdate"] = "event",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["sparkHeight"] = 30,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["overlaysTexture"] = {
				"xVerminClean", -- [1]
			},
			["width"] = 245,
			["semver"] = "1.0.13",
			["sparkHidden"] = "NEVER",
			["id"] = "Mana Bar ",
			["spark"] = false,
			["frameStrata"] = 3,
			["anchorFrameType"] = "SCREEN",
			["icon"] = false,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["custom"] = "if aura_env.region then\n    local r = aura_env.region\n    if not r.text3 then\n        local text3 = r.bar:CreateFontString(nil, \"OVERLAY\")\n        r.text3 = text3\n        r.text3:SetJustifyH(\"CENTER\")\n        r.text3:SetJustifyV(\"MIDDLE\")\n        r.text3:SetPoint(\"CENTER\", r.bar, \"CENTER\")\n        r.text3:Show()\n    end\n    r.text3:SetShadowOffset(1, -1)\n    r.text3:SetFont(r.text:GetFont())\n    r.text3:SetTextColor(r.text:GetTextColor())\nend\n\n\n\n\n\n\n",
					["do_custom"] = false,
				},
				["finish"] = {
				},
			},
			["inverse"] = false,
			["sparkDesature"] = false,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["xOffset"] = 0.0003662109375,
		},
		["Vermin Warrior"] = {
			["grow"] = "LEFT",
			["controlledChildren"] = {
				"Last Stand", -- [1]
				"Shield Wall", -- [2]
				"Retaliation", -- [3]
				"Recklessness", -- [4]
				"Sweeping Strikes", -- [5]
				"Revenge Death", -- [6]
				"Overpower Death", -- [7]
				"Overpower", -- [8]
				"Food", -- [9]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["xOffset"] = -135,
			["yOffset"] = 20,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["space"] = 2,
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
			["radius"] = 200,
			["selfPoint"] = "RIGHT",
			["align"] = "CENTER",
			["stagger"] = 0,
			["uid"] = "D9TtZ3sXWX0",
			["useLimit"] = false,
			["load"] = {
				["size"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["multi"] = {
					},
				},
			},
			["anchorFrameFrame"] = "PlayerFrame",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["rowSpace"] = 1,
			["animate"] = true,
			["fullCircle"] = true,
			["scale"] = 1,
			["centerType"] = "LR",
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["stepAngle"] = 15,
			["borderSize"] = 2,
			["sort"] = "none",
			["rotation"] = 0,
			["arcLength"] = 360,
			["constantFactor"] = "RADIUS",
			["regionType"] = "dynamicgroup",
			["borderOffset"] = 4,
			["limit"] = 5,
			["frameStrata"] = 1,
			["id"] = "Vermin Warrior",
			["borderInset"] = 1,
			["gridWidth"] = 5,
			["anchorFrameType"] = "SCREEN",
			["gridType"] = "RD",
			["config"] = {
			},
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["authorOptions"] = {
			},
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["internalVersion"] = 70,
		},
		["Vermin Paladin"] = {
			["arcLength"] = 360,
			["controlledChildren"] = {
				"Divine Protection", -- [1]
				"Reckoning", -- [2]
				"Redoubt", -- [3]
				"Holy Shield", -- [4]
				"Light's Grace", -- [5]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["xOffset"] = -135,
			["yOffset"] = 20,
			["anchorPoint"] = "CENTER",
			["fullCircle"] = true,
			["space"] = 2,
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
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["event"] = "Health",
						["names"] = {
						},
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["columnSpace"] = 1,
			["internalVersion"] = 70,
			["selfPoint"] = "RIGHT",
			["align"] = "CENTER",
			["stagger"] = 0,
			["config"] = {
			},
			["radius"] = 200,
			["load"] = {
				["talent"] = {
					["multi"] = {
					},
				},
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
			["anchorFrameFrame"] = "PlayerFrame",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["grow"] = "LEFT",
			["animate"] = true,
			["authorOptions"] = {
			},
			["scale"] = 1,
			["centerType"] = "LR",
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["stepAngle"] = 15,
			["borderSize"] = 2,
			["sort"] = "none",
			["rotation"] = 0,
			["rowSpace"] = 1,
			["constantFactor"] = "RADIUS",
			["regionType"] = "dynamicgroup",
			["borderOffset"] = 4,
			["gridType"] = "RD",
			["gridWidth"] = 5,
			["id"] = "Vermin Paladin",
			["borderInset"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["limit"] = 5,
			["uid"] = "uIfZeMoFAaJ",
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["useLimit"] = false,
		},
		["Saronite Ore"] = {
			["iconSource"] = -1,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["itemName"] = 0,
						["use_count"] = true,
						["duration"] = "1",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "item",
						["unevent"] = "auto",
						["use_exact_itemName"] = true,
						["use_unit"] = true,
						["use_itemName"] = true,
						["subeventPrefix"] = "SPELL",
						["use_includeBank"] = true,
						["spellIds"] = {
						},
						["count"] = "0",
						["event"] = "Item Count",
						["subeventSuffix"] = "_CAST_START",
						["use_absorbMode"] = true,
						["names"] = {
						},
						["count_operator"] = ">",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_shadowXOffset"] = 0,
					["type"] = "subtext",
					["text_anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "PT Sans Narrow",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_text_format_p_time_precision"] = 1,
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_anchorYOffset"] = 0,
				}, -- [2]
				{
					["glowFrequency"] = 0,
					["type"] = "subglow",
					["useGlowColor"] = false,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowDuration"] = 1,
					["glowXOffset"] = 0,
					["glowThickness"] = 1,
					["glow"] = true,
					["glowScale"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 40,
			["load"] = {
				["use_namerealm"] = true,
				["ingroup"] = {
					["single"] = "solo",
				},
				["namerealm"] = "Mxzq",
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["use_ingroup"] = true,
				["zoneIds"] = "",
				["use_never"] = true,
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["source"] = "import",
			["config"] = {
			},
			["url"] = "https://wago.io/iST6tz9t8/1",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["regionType"] = "icon",
			["cooldown"] = false,
			["useTooltip"] = true,
			["selfPoint"] = "CENTER",
			["parent"] = "Ore Count",
			["anchorFrameParent"] = false,
			["zoom"] = 0.3,
			["width"] = 40,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.0.0",
			["tocversion"] = 90002,
			["id"] = "Saronite Ore",
			["useCooldownModRate"] = true,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["alpha"] = 1,
			["uid"] = "RuUAMb)kWx1",
			["inverse"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["xOffset"] = 0,
		},
		["Details! Aura Group"] = {
			["grow"] = "RIGHT",
			["controlledChildren"] = {
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["xOffset"] = -678.999450683594,
			["yOffset"] = 212.765991210938,
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
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = false,
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Conditions",
						["unit"] = "player",
						["spellIds"] = {
						},
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["columnSpace"] = 1,
			["radius"] = 200,
			["selfPoint"] = "LEFT",
			["align"] = "CENTER",
			["rotation"] = 0,
			["borderInset"] = 0,
			["subRegions"] = {
			},
			["height"] = 20,
			["rowSpace"] = 1,
			["load"] = {
				["zoneIds"] = "",
				["race"] = {
					["multi"] = {
					},
				},
				["role"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["regionType"] = "dynamicgroup",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["arcLength"] = 360,
			["animate"] = true,
			["useLimit"] = false,
			["scale"] = 1,
			["centerType"] = "LR",
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["stepAngle"] = 15,
			["borderSize"] = 2,
			["limit"] = 5,
			["fullCircle"] = true,
			["stagger"] = 0,
			["constantFactor"] = "RADIUS",
			["sort"] = "none",
			["borderOffset"] = 16,
			["width"] = 199.999969482422,
			["gridWidth"] = 5,
			["id"] = "Details! Aura Group",
			["config"] = {
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["authorOptions"] = {
			},
			["uid"] = "XLzBWxn1LoM",
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
			},
			["internalVersion"] = 70,
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["gridType"] = "RD",
		},
		["Water"] = {
			["iconSource"] = -1,
			["authorOptions"] = {
				{
					["subOptions"] = {
						{
							["type"] = "input",
							["useDesc"] = false,
							["width"] = 1,
							["name"] = "Text",
							["key"] = "text",
							["default"] = "",
							["length"] = 10,
							["multiline"] = false,
							["useLength"] = false,
						}, -- [1]
					},
					["hideReorder"] = true,
					["useDesc"] = false,
					["nameSource"] = 0,
					["width"] = 1,
					["useCollapse"] = false,
					["name"] = "Macro",
					["key"] = "macro",
					["type"] = "group",
					["limitType"] = "none",
					["groupType"] = "simple",
					["collapse"] = false,
					["size"] = 10,
				}, -- [1]
			},
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
					["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\CartoonWalking.ogg",
					["do_sound"] = false,
				},
				["init"] = {
					["custom"] = "local text = aura_env.config.macro.text\n\naura_env.button = CreateFrame(\"Button\", \"buffButton\", aura_env.region, \"SecureActionButtonTemplate\")\naura_env.button:SetAllPoints()\naura_env.button:SetAttribute(\"unit\", \"player\")\naura_env.button:SetAttribute(\"type\",\"macro\")\naura_env.button:SetAttribute(\"macrotext\", text)",
					["do_custom"] = true,
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["event"] = "Conditions",
						["subeventPrefix"] = "SPELL",
						["spellIds"] = {
						},
						["use_unit"] = true,
						["unevent"] = "auto",
						["unit"] = "player",
						["names"] = {
						},
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["itemName"] = 8078,
						["use_count"] = true,
						["subeventSuffix"] = "_CAST_START",
						["use_exact_itemName"] = true,
						["duration"] = "1",
						["event"] = "Item Count",
						["subeventPrefix"] = "SPELL",
						["use_includeBank"] = false,
						["type"] = "item",
						["count"] = "4",
						["unevent"] = "auto",
						["use_itemName"] = true,
						["unit"] = "player",
						["use_unit"] = true,
						["count_operator"] = "<=",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["customTriggerLogic"] = "",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.25,
					["type"] = "subglow",
					["useGlowColor"] = false,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowDuration"] = 1,
					["glow"] = true,
					["glowScale"] = 1,
					["glowThickness"] = 1,
					["glowXOffset"] = 0,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [2]
			},
			["height"] = 40,
			["load"] = {
				["use_level"] = true,
				["talent"] = {
					["single"] = 9,
					["multi"] = {
						[9] = true,
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["use_class"] = false,
				["use_spellknown"] = false,
				["zoneIds"] = "",
				["use_never"] = false,
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["MAGE"] = true,
					},
				},
				["level"] = {
					"8", -- [1]
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["zoom"] = 0,
			["config"] = {
				["macro"] = {
					["text"] = "/cast Conjure Water",
				},
			},
			["parent"] = "GEMS",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 2,
						["variable"] = "show",
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
						["trigger"] = 2,
						["variable"] = "show",
						["value"] = 0,
					},
					["changes"] = {
						{
							["property"] = "alpha",
						}, -- [1]
					},
				}, -- [2]
			},
			["icon"] = true,
			["url"] = "https://wago.io/U0WH3IJ3S/1",
			["width"] = 40,
			["frameStrata"] = 1,
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["tocversion"] = 11304,
			["id"] = "Water",
			["semver"] = "1.0.0",
			["useCooldownModRate"] = true,
			["anchorFrameType"] = "SCREEN",
			["alpha"] = 1,
			["uid"] = ")OLyGVxasS6",
			["inverse"] = false,
			["xOffset"] = 160,
			["displayIcon"] = 132805,
			["cooldown"] = false,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
		},
		["Vermin Hunter"] = {
			["arcLength"] = 360,
			["controlledChildren"] = {
				"Misdirection", -- [1]
				"Frenzy Effect", -- [2]
				"Aspect of the Hawk", -- [3]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["authorOptions"] = {
			},
			["yOffset"] = 20,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["rowSpace"] = 1,
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
			["internalVersion"] = 70,
			["useLimit"] = false,
			["align"] = "CENTER",
			["stagger"] = 0,
			["uid"] = "H67q1C9K6oT",
			["radius"] = 200,
			["load"] = {
				["size"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["multi"] = {
					},
				},
			},
			["anchorFrameFrame"] = "PlayerFrame",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["xOffset"] = -135,
			["animate"] = true,
			["selfPoint"] = "RIGHT",
			["scale"] = 1,
			["centerType"] = "LR",
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["stepAngle"] = 15,
			["borderSize"] = 2,
			["sort"] = "none",
			["fullCircle"] = true,
			["grow"] = "LEFT",
			["constantFactor"] = "RADIUS",
			["regionType"] = "dynamicgroup",
			["borderOffset"] = 4,
			["limit"] = 5,
			["frameStrata"] = 1,
			["id"] = "Vermin Hunter",
			["borderInset"] = 1,
			["gridWidth"] = 5,
			["anchorFrameType"] = "SCREEN",
			["gridType"] = "RD",
			["config"] = {
			},
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["rotation"] = 0,
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["space"] = 2,
		},
		["Agate"] = {
			["iconSource"] = -1,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["url"] = "https://wago.io/U0WH3IJ3S/1",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["event"] = "Conditions",
						["subeventPrefix"] = "SPELL",
						["spellIds"] = {
						},
						["use_unit"] = true,
						["names"] = {
						},
						["unit"] = "player",
						["unevent"] = "auto",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "item",
						["use_count"] = true,
						["subeventSuffix"] = "_CAST_START",
						["use_exact_itemName"] = true,
						["duration"] = "1",
						["event"] = "Item Count",
						["subeventPrefix"] = "SPELL",
						["use_includeBank"] = false,
						["itemName"] = 5514,
						["count"] = "0",
						["use_unit"] = true,
						["unit"] = "player",
						["use_itemName"] = true,
						["unevent"] = "auto",
						["count_operator"] = "==",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["customTriggerLogic"] = "",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.25,
					["glow"] = true,
					["useGlowColor"] = false,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowDuration"] = 1,
					["type"] = "subglow",
					["glowThickness"] = 1,
					["glowScale"] = 1,
					["glowXOffset"] = 0,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [2]
			},
			["height"] = 40,
			["load"] = {
				["use_level"] = true,
				["talent"] = {
					["single"] = 9,
					["multi"] = {
						[9] = true,
					},
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["use_class"] = false,
				["use_spellknown"] = false,
				["zoneIds"] = "",
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["MAGE"] = true,
					},
				},
				["use_never"] = false,
				["level"] = {
					"28", -- [1]
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
			["zoom"] = 0,
			["uid"] = "(9qU7Rw3V8a",
			["parent"] = "GEMS",
			["authorOptions"] = {
				{
					["subOptions"] = {
						{
							["type"] = "input",
							["useDesc"] = false,
							["width"] = 1,
							["name"] = "Text",
							["default"] = "",
							["multiline"] = false,
							["length"] = 10,
							["key"] = "text",
							["useLength"] = false,
						}, -- [1]
					},
					["hideReorder"] = true,
					["useDesc"] = false,
					["nameSource"] = 0,
					["width"] = 1,
					["useCollapse"] = false,
					["key"] = "macro",
					["name"] = "Macro",
					["collapse"] = false,
					["limitType"] = "none",
					["groupType"] = "simple",
					["type"] = "group",
					["size"] = 10,
				}, -- [1]
			},
			["regionType"] = "icon",
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["displayIcon"] = 134104,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["custom"] = "local text = aura_env.config.macro.text\n\naura_env.button = CreateFrame(\"Button\", \"buffButton\", aura_env.region, \"SecureActionButtonTemplate\")\naura_env.button:SetAllPoints()\naura_env.button:SetAttribute(\"unit\", \"player\")\naura_env.button:SetAttribute(\"type\",\"macro\")\naura_env.button:SetAttribute(\"macrotext\", text)",
					["do_custom"] = true,
				},
				["finish"] = {
					["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\CartoonWalking.ogg",
					["do_sound"] = false,
				},
			},
			["xOffset"] = 0,
			["anchorFrameType"] = "SCREEN",
			["alpha"] = 1,
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["tocversion"] = 11304,
			["id"] = "Agate",
			["semver"] = "1.0.0",
			["useCooldownModRate"] = true,
			["width"] = 40,
			["frameStrata"] = 1,
			["config"] = {
				["macro"] = {
					["text"] = "/cast Conjure Mana Agate",
				},
			},
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 2,
						["variable"] = "show",
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
						["trigger"] = 2,
						["variable"] = "show",
						["value"] = 0,
					},
					["changes"] = {
						{
							["property"] = "alpha",
						}, -- [1]
					},
				}, -- [2]
			},
			["cooldown"] = false,
			["cooldownEdge"] = false,
		},
		["Experience Bar - Luxthos"] = {
			["sparkWidth"] = 10,
			["iconSource"] = 0,
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["url"] = "https://wago.io/LuxthosExperienceBar/40",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["enableGradient"] = true,
			["selfPoint"] = "TOP",
			["barColor"] = {
				0.33725491166115, -- [1]
				0.38823533058166, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["sparkOffsetY"] = 0,
			["gradientOrientation"] = "HORIZONTAL",
			["load"] = {
				["use_petbattle"] = false,
				["use_level"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["level_operator"] = {
					"<", -- [1]
				},
				["zoneIds"] = "",
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["level"] = {
					"25", -- [1]
				},
				["use_never"] = false,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["overlayclip"] = true,
			["texture"] = "xVerminClean",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["spark"] = false,
			["tocversion"] = 100002,
			["alpha"] = 1,
			["uid"] = "UpaCp8I(Gtg",
			["displayIcon"] = 894556,
			["sparkOffsetX"] = 0,
			["wagoID"] = "3GaU4Ttxj",
			["parent"] = "Luxthos - Experience Group",
			["customText"] = "function()\n    local t = aura_env.customTexts\n    \n    return t.c1, t.c2, t.c3, t.c4, t.c5, t.c6, t.c7\nend",
			["sparkRotationMode"] = "AUTO",
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "1",
						["genericShowOn"] = "showOnCooldown",
						["subeventPrefix"] = "",
						["unit"] = "player",
						["customOverlay1"] = "",
						["use_genericShowOn"] = true,
						["debuffType"] = "HELPFUL",
						["events"] = "LWA_EXPERIENCE_UPDATE",
						["custom_hide"] = "custom",
						["spellIds"] = {
						},
						["type"] = "custom",
						["use_spellName"] = true,
						["subeventSuffix"] = "",
						["realSpellName"] = 0,
						["unevent"] = "timed",
						["event"] = "Combat Log",
						["spellName"] = {
							0, -- [1]
						},
						["customDuration"] = "",
						["customName"] = "",
						["custom"] = "function(allstates, event, ...)\n    local cfg = aura_env.config\n    local show = cfg[\"showmaxlevel\"] or not aura_env.isPlayerMaxLevel\n    \n    allstates[\"\"] = allstates[\"\"] or { show = false }\n    \n    if show then\n        local WAS = aura_env.GetSavedVars()\n        local level = aura_env.level or UnitLevel(\"player\")\n        local totalTime = WAS.session.realTotalTime or 0\n        local levelTime = WAS.session.realLevelTime or 0\n        local currentTime = time()\n        local sessionTime = 0\n        local gainedXP = WAS.session.gainedXP or 0\n        local coeff, hourlyXP, timeToLevel = 0, 0, 0\n        \n        local currentXP = UnitXP(\"player\") or 0\n        local totalXP = UnitXPMax(\"player\") or 0\n        local remainingXP = totalXP - currentXP\n        local restedXP = GetXPExhaustion() or 0\n        local questXP = aura_env.questXP or 0\n        local completeXP = aura_env.completeXP or 0\n        local incompleteXP = aura_env.incompleteXP or 0\n        \n        if cfg[\"leveltime-text\"] and WAS.session.lastTimePlayedRequest > 0 then\n            totalTime = currentTime - WAS.session.lastTimePlayedRequest + WAS.session.realTotalTime\n            levelTime = currentTime - WAS.session.lastTimePlayedRequest + WAS.session.realLevelTime\n        end\n        \n        if cfg[\"sessiontime-text\"] or cfg[\"showxphour-text\"] then\n            if WAS.session.startTime > 0 then\n                sessionTime = currentTime - WAS.session.startTime\n                \n                coeff = sessionTime / 3600\n                \n                if coeff > 0 and gainedXP > 0 then\n                    hourlyXP = ceil(gainedXP / coeff)\n                    timeToLevel = ceil(remainingXP / hourlyXP * 3600)\n                end\n            end\n        end\n        \n        allstates[\"\"] = {\n            show = true,\n            changed = true,\n            progressType = \"static\",\n            value = currentXP,\n            total = totalXP,\n            \n            -- Usable Variables\n            level = level,\n            currentXP = currentXP,\n            totalXP = totalXP,\n            remainingXP = remainingXP,\n            restedXP = restedXP,\n            questXP = questXP,\n            completeXP = completeXP,\n            incompleteXP = incompleteXP,\n            hourlyXP = hourlyXP,\n            timeToLevel = timeToLevel,\n            timeToLevelText = timeToLevel > 0 and aura_env.FormatTime(timeToLevel) or \"--\",\n            totalTime = totalTime,\n            totalTimeText = aura_env.FormatTime(totalTime),\n            levelTime = levelTime,\n            levelTimeText = aura_env.FormatTime(levelTime),\n            sessionTime = sessionTime,\n            sessionTimeText = aura_env.FormatTime(sessionTime),\n            percentXP = totalXP > 0 and ((currentXP / totalXP) * 100) or 0,\n            percentremaining = totalXP > 0 and ((remainingXP / totalXP) * 100) or 0,\n            percentrested = totalXP > 0 and ((restedXP / totalXP) * 100) or 0,\n            percentquest = totalXP > 0 and ((questXP / totalXP) * 100) or 0,\n            percentcomplete = totalXP > 0 and ((completeXP / totalXP) * 100) or 0,\n            percentincomplete = totalXP > 0 and ((incompleteXP / totalXP) * 100) or 0,\n            totalpercentcomplete = totalXP > 0 and (((completeXP + currentXP) / totalXP) * 100) or 0,\n            \n            additionalProgress = {\n                {\n                    -- Complete Quest XP\n                    direction = \"forward\",\n                    width = completeXP\n                },\n                {\n                    -- Incomplete Quest XP\n                    direction = \"forward\",\n                    width = aura_env.config[\"showincompletequest-bar\"] and incompleteXP or 0,\n                    offset = completeXP,\n                },\n                {\n                    -- Rested XP\n                    direction = \"forward\",\n                    width = restedXP,\n                    offset = completeXP + (aura_env.config[\"showincompletequest-bar\"] and incompleteXP or 0)\n                }\n            }\n        }\n        \n        aura_env.UpdateCustomTexts(allstates[\"\"])\n        \n        if aura_env.timerHandler then\n            aura_env.timerHandler:Cancel()\n            aura_env.timerHandler = nil\n        end\n        \n        aura_env.timerHandler = C_Timer.NewTimer(1, function()\n                WeakAuras.ScanEvents(\"LWA_EXPERIENCE_UPDATE\")\n        end)\n        \n        return true\n        \n    elseif allstates[\"\"][\"show\"] then\n        allstates[\"\"] = {\n            show = false,\n            changed = true,\n        }\n        \n        return true\n    end\nend",
						["custom_type"] = "stateupdate",
						["check"] = "event",
						["names"] = {
						},
						["use_track"] = true,
						["customVariables"] = "{\n    additionalProgress = 3,\n    \n    level = {\n        display = WeakAuras.L[\"Level\"],\n        type = \"number\",\n    },\n    currentXP = {\n        display = WeakAuras.L[\"Current Experience\"],\n        type = \"number\",\n    },\n    percentXP = {\n        display = WeakAuras.L[\"Experience (%)\"],\n        type = \"number\",\n    },\n    totalXP = {\n        display = WeakAuras.L[\"Total Experience\"],\n        type = \"number\",\n    },\n    remainingXP = {\n        display = WeakAuras.L[\"Remaining Experience\"],\n        type = \"number\",\n    },\n    percentremaining = {\n        display = WeakAuras.L[\"Remaining Experience (%)\"],\n        type = \"number\",\n    },\n    restedXP = {\n        display = WeakAuras.L[\"Rested Experience\"],\n        type = \"number\",\n    },\n    percentrested = {\n        display = WeakAuras.L[\"Rested Experience (%)\"],\n        type = \"number\",\n    },\n    questXP = {\n        display = WeakAuras.L[\"Quest Experience\"],\n        type = \"number\",\n    },\n    percentquest = {\n        display = WeakAuras.L[\"Quest Experience (%)\"],\n        type = \"number\",\n    },\n    completeXP = {\n        display = WeakAuras.L[\"Completed Experience\"],\n        type = \"number\",\n    },\n    percentcomplete = {\n        display = WeakAuras.L[\"Completed Experience (%)\"],\n        type = \"number\",\n    }\n}",
					},
					["untrigger"] = {
						["custom"] = "",
					},
				}, -- [1]
				{
					["trigger"] = {
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showOnCooldown",
						["subeventPrefix"] = "",
						["debuffType"] = "HELPFUL",
						["type"] = "custom",
						["spellName"] = {
							0, -- [1]
						},
						["subeventSuffix"] = "",
						["unit"] = "player",
						["custom_type"] = "event",
						["event"] = "Combat Log",
						["custom"] = "function(event, arg1, arg2, arg3, arg4, ...)\n    local currentXP = UnitXP(\"player\")\n    local maxXP = UnitXPMax(\"player\")\n    local currentTime = time()\n    local WAS = aura_env.GetSavedVars()\n    \n    --print(event, arg1, arg2)\n    \n    if aura_env.timerHandler then\n        aura_env.timerHandler:Cancel()\n        aura_env.timerHandler = nil\n    end\n    \n    if \"PLAYER_ENTERING_WORLD\" == event then\n        if arg1 or (arg2 and aura_env.config.reset_reload) then\n            WAS.session.gainedXP = 0\n            WAS.session.lastXP = currentXP\n            WAS.session.maxXP = maxXP\n            WAS.session.startTime = currentTime\n        end\n        \n        if arg1 or arg2 then\n            WAS.session.realTotalTime = 0\n            WAS.session.realLevelTime = 0\n            WAS.session.lastTimePlayedRequest = 0\n        end\n        \n        if aura_env.config[\"leveltime-text\"] and WAS.session.lastTimePlayedRequest <= 0 then\n            aura_env.RequestTimePlayed()\n        end\n        \n    elseif \"PLAYER_LEVEL_UP\" == event then\n        aura_env.level = arg1 or aura_env.level\n        aura_env.isPlayerMaxLevel = aura_env.level >= GetMaxLevelForExpansionLevel(GetExpansionLevel())\n        \n        WAS.session.realLevelTime = 0\n        WAS.session.maxXP = maxXP\n        \n        WAS.session.lastTimePlayedRequest = currentTime\n        \n    elseif \"UPDATE_EXPANSION_LEVEL\" == event then\n        local minExpLevel = min(arg1, arg2, arg3, arg4)\n        local maxExpLevel = max(arg1, arg2, arg3, arg4)\n        \n        aura_env.isPlayerMaxLevel = aura_env.level >= GetMaxLevelForExpansionLevel(maxExpLevel)\n        \n        if aura_env.level == GetMaxLevelForExpansionLevel(minExpLevel) or (currentTime - WAS.session.startTime >= (86400 * 3)) then\n            WAS.session.startTime = currentTime\n        end\n        \n    elseif \"QUEST_LOG_UPDATE\" == event or (\"UNIT_QUEST_LOG_CHANGED\" == event and arg1 == \"player\") then\n        aura_env.UpdateQuestXP()\n        \n    elseif \"TIME_PLAYED_MSG\" == event and arg2 then\n        WAS.session.realTotalTime = arg1\n        WAS.session.realLevelTime = arg2\n        \n        WAS.session.lastTimePlayedRequest = currentTime\n        \n        aura_env.ClearTickerRTP()\n        \n    elseif \"PLAYER_XP_UPDATE\" == event then\n        local gainedXP = currentXP - WAS.session.lastXP\n        \n        if gainedXP < 0 then\n            gainedXP = WAS.session.maxXP - WAS.session.lastXP + currentXP\n        end\n        \n        WAS.session.gainedXP = WAS.session.gainedXP + gainedXP\n        WAS.session.lastXP = currentXP\n        WAS.session.maxXP = maxXP\n        \n    elseif \"OPTIONS\" == event then\n        if aura_env.config[\"leveltime-text\"] then\n            if WAS.session.lastTimePlayedRequest <= 0 or WeakAuras.IsImporting() then\n                aura_env.RequestTimePlayed()\n            end\n        else\n            aura_env.ClearTickerRTP()\n        end\n        \n        if currentTime - WAS.session.startTime >= (86400 * 3) then\n            WAS.session.startTime = currentTime\n        end\n        \n        if StatusTrackingBarManager then\n            if aura_env.config.hide_xpbar then\n                StatusTrackingBarManager:Hide()\n                StatusTrackingBarManager.Show = nop\n            else\n                UIParent.Show(StatusTrackingBarManager)\n            end\n        end\n    end\n    \n    WeakAuras.ScanEvents(\"LWA_EXPERIENCE_UPDATE\")\n    \n    return true\nend",
						["realSpellName"] = 0,
						["use_spellName"] = true,
						["events"] = "PLAYER_ENTERING_WORLD QUEST_LOG_UPDATE UNIT_QUEST_LOG_CHANGED PLAYER_XP_UPDATE PLAYER_LEVEL_UP UPDATE_EXHAUSTION UPDATE_EXPANSION_LEVEL TIME_PLAYED_MSG ENABLE_XP_GAIN DISABLE_XP_GAIN",
						["unevent"] = "timed",
						["check"] = "event",
						["duration"] = "1",
						["use_track"] = true,
						["custom_hide"] = "custom",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "custom",
				["customTriggerLogic"] = "function()\n    return not IsXPUserDisabled() and (aura_env.config[\"showmaxlevel\"] or not aura_env.isPlayerMaxLevel)\nend",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["version"] = 40,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subforeground",
				}, -- [2]
				{
					["text_shadowXOffset"] = 1,
					["text_text_format_level_format"] = "none",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_format"] = "timed",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["type"] = "subtext",
					["text_anchorXOffset"] = 5,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text"] = "%c1",
					["text_shadowYOffset"] = -1,
					["text_anchorPoint"] = "INNER_LEFT",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_text_format_c1_format"] = "none",
					["text_text_format_p_time_format"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_precision"] = 1,
				}, -- [3]
				{
					["text_shadowXOffset"] = 1,
					["text_text"] = "%c2",
					["text_text_format_restedXP_format"] = "none",
					["text_text_format_completeXP_format"] = "none",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_fixedWidth"] = 64,
					["rotateText"] = "NONE",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_text_format_currentXP_big_number_format"] = "AbbreviateLargeNumbers",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_text_format_questXP_format"] = "none",
					["text_text_format_totalXP_format"] = "none",
					["anchorXOffset"] = 0,
					["text_text_format_percentXP_round_type"] = "floor",
					["text_text_format_n_format"] = "none",
					["text_text_format_totalXP_big_number_format"] = "AbbreviateLargeNumbers",
					["text_selfPoint"] = "AUTO",
					["text_text_format_percentXP_format"] = "Number",
					["anchorYOffset"] = 0,
					["text_text_format_percentXP_decimal_precision"] = 0,
					["text_text_format_remainingXP_big_number_format"] = "AbbreviateLargeNumbers",
					["text_text_format_currentXP_round_type"] = "floor",
					["text_text_format_currentXP_decimal_precision"] = 0,
					["text_font"] = "Friz Quadrata TT",
					["text_justify"] = "CENTER",
					["text_text_format_totalXP_decimal_precision"] = 0,
					["type"] = "subtext",
					["text_automaticWidth"] = "Auto",
					["text_text_format_remainingXP_format"] = "none",
					["text_text_format_currentXP_format"] = "none",
					["text_anchorPoint"] = "INNER_CENTER",
					["text_text_format_c2_format"] = "none",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 14,
					["text_text_format_totalXP_round_type"] = "floor",
				}, -- [4]
				{
					["text_shadowXOffset"] = 1,
					["text_text"] = "%c3",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_text_format_percentcomplete_color"] = true,
					["text_fixedWidth"] = 64,
					["text_text_format_percentcomplete_decimal_precision"] = 0,
					["text_text_format_totalpercentcomplete_format"] = "Number",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_text_format_2.t_time_format"] = 0,
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_text_format_totalXP_format"] = "none",
					["anchorXOffset"] = 0,
					["text_text_format_percentXP_round_type"] = "floor",
					["text_text_format_n_format"] = "none",
					["text_text_format_totalpercentcomplete_round_type"] = "floor",
					["text_text_format_percentcomplete_round_type"] = "floor",
					["text_text_format_2.t_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_text_format_percentXP_format"] = "Number",
					["text_text_format_percentcomplete_format"] = "Number",
					["text_fontType"] = "OUTLINE",
					["anchorYOffset"] = 0,
					["text_text_format_percentcomplete_abbreviate_max"] = 8,
					["text_text_format_2.t_time_precision"] = 1,
					["text_text_format_percentcomplete_realm_name"] = "never",
					["text_justify"] = "CENTER",
					["text_text_format_percentXP_decimal_precision"] = 1,
					["type"] = "subtext",
					["text_anchorXOffset"] = -5,
					["text_fontSize"] = 16,
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_percentrested_round_type"] = "floor",
					["text_text_format_totalpercentcomplete_decimal_precision"] = 1,
					["text_text_format_2.t_time_dynamic_threshold"] = 60,
					["text_anchorPoint"] = "INNER_RIGHT",
					["text_text_format_c3_format"] = "none",
					["text_text_format_currentXP_format"] = "none",
					["text_automaticWidth"] = "Auto",
					["rotateText"] = "NONE",
					["text_text_format_percentcomplete_abbreviate"] = false,
					["text_text_format_percentrested_decimal_precision"] = 0,
					["text_text_format_percentrested_format"] = "Number",
				}, -- [5]
				{
					["text_shadowXOffset"] = 1,
					["text_text"] = "%c4",
					["text_text_format_percentcomplete_round_type"] = "floor",
					["text_text_format_percentcomplete_format"] = "Number",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_text_format_c7_format"] = "none",
					["text_selfPoint"] = "LEFT",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_percentcomplete_decimal_precision"] = 0,
					["anchorYOffset"] = 0,
					["text_justify"] = "LEFT",
					["rotateText"] = "NONE",
					["text_text_format_n_format"] = "none",
					["text_text_format_c4_format"] = "none",
					["text_anchorPoint"] = "BOTTOMLEFT",
					["type"] = "subtext",
					["text_visible"] = true,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_percentrested_round_type"] = "floor",
					["text_anchorYOffset"] = -18,
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_text_format_c1_format"] = "none",
					["text_text_format_percentreste_format"] = "none",
					["text_text_format_percentrested_decimal_precision"] = 0,
					["text_fontSize"] = 14,
					["anchorXOffset"] = 0,
					["text_text_format_percentrested_format"] = "Number",
				}, -- [6]
				{
					["text_shadowXOffset"] = 1,
					["text_text"] = "%c5",
					["text_text_format_n_format"] = "none",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_text_format_percentcomplete_round_type"] = "floor",
					["anchorYOffset"] = 0,
					["text_selfPoint"] = "RIGHT",
					["text_automaticWidth"] = "Auto",
					["text_text_format_percentcomplete_format"] = "Number",
					["text_text_format_c4_format"] = "none",
					["text_text_format_percentcomplete_decimal_precision"] = 0,
					["text_justify"] = "RIGHT",
					["rotateText"] = "NONE",
					["text_text_format_percentreste_format"] = "none",
					["text_anchorPoint"] = "BOTTOMRIGHT",
					["text_fontType"] = "OUTLINE",
					["type"] = "subtext",
					["text_anchorYOffset"] = -18,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_percentrested_round_type"] = "floor",
					["text_shadowYOffset"] = -1,
					["text_fixedWidth"] = 64,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_text_format_c1_format"] = "none",
					["text_text_format_percentrested_decimal_precision"] = 0,
					["text_text_format_c5_format"] = "none",
					["text_fontSize"] = 14,
					["anchorXOffset"] = 0,
					["text_text_format_percentrested_format"] = "Number",
				}, -- [7]
				{
					["text_shadowXOffset"] = 1,
					["text_text"] = "%c6",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "TOPLEFT",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_n_format"] = "none",
					["text_anchorYOffset"] = 24,
					["type"] = "subtext",
					["text_shadowYOffset"] = -1,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_c6_format"] = "none",
					["text_text_format_levelTime_format"] = "none",
					["text_fontType"] = "OUTLINE",
					["text_text_format_c2_format"] = "none",
					["text_visible"] = true,
					["text_anchorPoint"] = "TOPLEFT",
					["text_wordWrap"] = "WordWrap",
					["text_text_format_c5_format"] = "none",
					["text_fontSize"] = 14,
					["anchorXOffset"] = 0,
					["text_text_format_C_format"] = "none",
				}, -- [8]
				{
					["text_shadowXOffset"] = 1,
					["text_text"] = "%c7",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_text_format_c7_format"] = "none",
					["text_selfPoint"] = "TOPRIGHT",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_text_format_n_format"] = "none",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_c6_format"] = "none",
					["text_anchorYOffset"] = 24,
					["text_fontType"] = "OUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "TOPRIGHT",
					["text_text_format_c3_format"] = "none",
					["text_text_format_sessionTime_format"] = "none",
					["text_fontSize"] = 14,
					["anchorXOffset"] = 0,
					["text_shadowYOffset"] = -1,
				}, -- [9]
			},
			["height"] = 30,
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["source"] = "import",
			["authorOptions"] = {
				{
					["type"] = "toggle",
					["default"] = true,
					["width"] = 1,
					["name"] = "Played Time Text",
					["useDesc"] = true,
					["key"] = "leveltime-text",
					["desc"] = "Enabling this will give you the time played at this level or total at max level.",
				}, -- [1]
				{
					["type"] = "toggle",
					["default"] = true,
					["width"] = 1,
					["name"] = "Session Time Text",
					["useDesc"] = true,
					["key"] = "sessiontime-text",
					["desc"] = "Enabling this will give you the time spent in this current session.",
				}, -- [2]
				{
					["type"] = "toggle",
					["default"] = true,
					["key"] = "showxphour-text",
					["name"] = "Leveling Time & XP/Hour Text",
					["useDesc"] = false,
					["width"] = 1,
				}, -- [3]
				{
					["type"] = "toggle",
					["default"] = true,
					["width"] = 1,
					["name"] = "Completed & Rested Text",
					["useDesc"] = true,
					["key"] = "questrested-text",
					["desc"] = "Enabling this will give you Completed and Rested text information at the bottom of the Experience Bar.",
				}, -- [4]
				{
					["type"] = "toggle",
					["default"] = false,
					["key"] = "showincompletequest-bar",
					["name"] = "Show Incomplete Quests Bar",
					["useDesc"] = false,
					["width"] = 1,
				}, -- [5]
				{
					["type"] = "toggle",
					["default"] = false,
					["key"] = "showmaxlevel",
					["name"] = "Show Bar at Max Level",
					["useDesc"] = false,
					["width"] = 1,
				}, -- [6]
				{
					["type"] = "toggle",
					["default"] = false,
					["key"] = "reset_reload",
					["name"] = "Reset Session Time and XP/Hour on Reload UI",
					["useDesc"] = false,
					["width"] = 2,
				}, -- [7]
				{
					["type"] = "toggle",
					["default"] = false,
					["key"] = "hide_xpbar",
					["name"] = "Hide Default Experience Bar (Retail)",
					["useDesc"] = false,
					["width"] = 2,
				}, -- [8]
			},
			["barColor2"] = {
				0.77647066116333, -- [1]
				0.38039219379425, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["overlays"] = {
				{
					1, -- [1]
					0.5921568627451, -- [2]
					0, -- [3]
					1, -- [4]
				}, -- [1]
				{
					1, -- [1]
					0.82352941176471, -- [2]
					0.30980392156863, -- [3]
					1, -- [4]
				}, -- [2]
				{
					0.30980392156863, -- [1]
					0.56470588235294, -- [2]
					1, -- [3]
					0.54487144947052, -- [4]
				}, -- [3]
			},
			["icon_side"] = "LEFT",
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["actions"] = {
				["start"] = {
					["custom"] = "\n\n",
					["do_custom"] = false,
				},
				["finish"] = {
					["hide_all_glows"] = false,
				},
				["init"] = {
					["custom"] = "local aura_env = aura_env\n\naura_env.timerHandler = aura_env.timerHandler or nil\n\naura_env.GetSavedVars = function()\n    local WAS = aura_env.saved or {}\n    aura_env.saved = WAS\n    \n    WAS.session = WAS.session or {}\n    \n    WAS.session.gainedXP = WAS.session.gainedXP or 0\n    WAS.session.lastXP = WAS.session.lastXP or UnitXP(\"player\")\n    WAS.session.maxXP = WAS.session.maxXP or UnitXPMax(\"player\")\n    WAS.session.startTime = WAS.session.startTime or time()\n    WAS.session.realTotalTime = WAS.session.realTotalTime or 0\n    WAS.session.realLevelTime = WAS.session.realLevelTime or 0\n    WAS.session.lastTimePlayedRequest = WAS.session.lastTimePlayedRequest or 0\n    \n    return WAS\nend\n\naura_env.level = UnitLevel(\"player\")\naura_env.isPlayerMaxLevel = aura_env.level >= GetMaxLevelForExpansionLevel(GetExpansionLevel())\n\nif not IsXPUserDisabled then\n    IsXPUserDisabled = function() return false end\nend\n\nlocal GetNumQuestLogEntries = C_QuestLog.GetNumQuestLogEntries or GetNumQuestLogEntries\nlocal GetQuestIDForLogIndex = C_QuestLog.GetQuestIDForLogIndex or function(i)\n    return select(8, GetQuestLogTitle(i))\nend\nlocal SelectQuestLogEntry = SelectQuestLogEntry or function() end\nlocal IsQuestComplete = C_QuestLog.IsComplete or IsQuestComplete\nlocal QuestReadyForTurnIn = C_QuestLog.ReadyForTurnIn or function(questID) return false end\n\naura_env.UpdateQuestXP = function()\n    local numQ = GetNumQuestLogEntries()\n    local questXP = 0\n    local completeXP = 0\n    local incompleteXP = 0\n    local questID, rewardXP\n    local selQ = 0\n    local GetQuestLogRewardXP = GetQuestLogRewardXP or function(questID)\n        return 0\n    end\n    \n    if GetQuestLogSelection then\n        selQ = GetQuestLogSelection()\n    end\n    \n    for i = 1, numQ do\n        SelectQuestLogEntry(i)\n        questID = GetQuestIDForLogIndex(i)\n        \n        if questID > 0 then\n            rewardXP = GetQuestLogRewardXP(questID) or 0\n            \n            if rewardXP > 0 then\n                questXP = questXP + rewardXP\n                \n                if IsQuestComplete(questID) or QuestReadyForTurnIn(questID) then\n                    completeXP = completeXP + rewardXP\n                else\n                    incompleteXP = incompleteXP + rewardXP\n                end\n            end\n        end\n    end\n    \n    aura_env.questXP = questXP\n    aura_env.completeXP = completeXP\n    aura_env.incompleteXP = incompleteXP\n    \n    if selQ > 0 then\n        SelectQuestLogEntry(selQ)\n        StaticPopup_Hide(\"ABANDON_QUEST\")\n        StaticPopup_Hide(\"ABANDON_QUEST_WITH_ITEMS\")\n        \n        if QuestLogControlPanel_UpdateState then\n            local SetAbandonQuest = SetAbandonQuest or function() end\n            \n            QuestLogControlPanel_UpdateState()\n            SetAbandonQuest()\n        end\n    end\nend\n\naura_env.UpdateQuestXP()\n\naura_env.round = function(num, decimals)\n    local mult = 10^(decimals or 0)\n    \n    return Round(num * mult) / mult\nend\n\naura_env.FormatTime = function(time, format)\n    if time <= 59 then\n        return \"< 1m\"\n    end\n    \n    local d, h, m, s = ChatFrame_TimeBreakDown(time)\n    local t = format or \"%dd %hh %mm\" --\"%d:%H:%M:%S\"\n    \n    \n    local pad = function(v)\n        return v < 10 and \"0\" .. v or v\n    end\n    \n    local subs = {\n        [\"%%D([Dd]?)\"] = d > 0 and (pad(d) .. \"%1\") or \"\",\n        [\"%%d([Dd]?)\"] = d > 0 and (d .. \"%1\") or \"\",\n        [\"%%H([Hh]?)\"] = (d > 0 or h > 0) and (pad(h) .. \"%1\") or \"\",\n        [\"%%h([Hh]?)\"] = (d > 0 or h > 0) and (h .. \"%1\") or \"\",\n        [\"%%M([Mm]?)\"] = pad(m) .. \"%1\",\n        [\"%%m([Mm]?)\"] = m .. \"%1\",\n        [\"%%S([Ss]?)\"] = pad(s) .. \"%1\",\n        [\"%%s([Ss]?)\"] = s .. \"%1\",\n    }\n    \n    for k,v in pairs(subs) do\n        t = t:gsub(k, v)\n    end\n    \n    -- Remove trailing spaces/zeroes/symbols\n    return strtrim(t:gsub(\"^%s*0*\", \"\"):gsub(\"^%s*[DdHhMm]\", \"\"), \" :/-|\")\nend\n\naura_env.tickerRTP = aura_env.tickerRTP or nil\naura_env.requestingTimePlayed = false\n\naura_env.ClearTickerRTP = function()\n    if aura_env.tickerRTP then\n        aura_env.tickerRTP:Cancel()\n        aura_env.tickerRTP = nil\n    end\n    \n    aura_env.requestingTimePlayed = false\nend\n\naura_env.RequestTimePlayed = function()\n    if not aura_env.requestingTimePlayed then\n        aura_env.ClearTickerRTP()\n        \n        aura_env.requestingTimePlayed = true\n        \n        aura_env.tickerRTP = C_Timer.NewTimer(0.5, function() RequestTimePlayed() end)\n    end\nend\n\naura_env.customTexts = {\n    c1 = \"Level \" .. aura_env.level,\n    c2 = \"0 / 0 (0)\",\n    c3 = \"0%\",\n    c4 = \"\",\n    c5 = \"\",\n    c6 = \"\",\n    c7 = \"\",\n}\n\naura_env.UpdateCustomTexts = function(state)\n    local c1, c2, c3, c4, c5, c6, c7\n    local s = state or aura_env.state\n    local cfg = aura_env.config\n    local round = aura_env.round\n    local isMaxLevel = aura_env.isPlayerMaxLevel\n    \n    c1 = \"Level \" .. (s.level or UnitLevel(\"player\"))\n    \n    if isMaxLevel then\n        c2 = \"Max Level\"\n    else\n        c2 = string.format(\"%s / %s (%s)\", FormatLargeNumber(s.currentXP or 0), FormatLargeNumber(s.totalXP or 0), FormatLargeNumber(s.remainingXP or 0))\n    end\n    \n    c3 = string.format(\"%s%%\" .. ((s.percentcomplete or 0) > 0 and \" (%s%%)\" or \"\"), round(s.percentXP or 0, 1), round(s.totalpercentcomplete or 0, 1))\n    \n    if not isMaxLevel then\n        if cfg[\"showxphour-text\"] then\n            local hourlyXP = s.hourlyXP or 0\n            \n            c4 = string.format(\"Leveling in: %s (%s%s XP/Hour)\", s.timeToLevelText or \"\", hourlyXP > 10000 and round(hourlyXP / 1000, 1) or FormatLargeNumber(hourlyXP), hourlyXP > 10000 and \"K\" or \"\")\n        end\n        \n        if cfg[\"questrested-text\"] then\n            c5 = string.format(\"Completed: |cFFFF9700%s%%|r - Rested: |cFF4F90FF%s%%|r\", round(s.percentcomplete or 0, 1), round(s.percentrested or 0, 1))\n        end\n    end\n    \n    if cfg[\"leveltime-text\"] then\n        if isMaxLevel then\n            c6 = \"Time played: \" .. (s.totalTimeText or \"\")\n        else\n            c6 = \"Time this level: \" .. (s.levelTimeText or \"\")\n        end\n    end\n    \n    if cfg[\"sessiontime-text\"] then\n        c7 = \"Time this session: \" .. (s.sessionTimeText or \"\")\n    end\n    \n    aura_env.customTexts = {\n        c1 = c1,\n        c2 = c2,\n        c3 = c3,\n        c4 = c4,\n        c5 = c5,\n        c6 = c6,\n        c7 = c7,\n    }\nend",
					["do_custom"] = true,
				},
			},
			["sparkHeight"] = 30,
			["desc"] = "Created by Luxthos & Daemoos\nwww.twitch.tv/luxthos",
			["overlaysTexture"] = {
				"xVerminClean", -- [1]
				"xVerminClean", -- [2]
				"xVerminClean", -- [3]
			},
			["zoom"] = 0,
			["semver"] = "3.0.5",
			["config"] = {
				["questrested-text"] = true,
				["showincompletequest-bar"] = true,
				["showxphour-text"] = true,
				["leveltime-text"] = true,
				["hide_xpbar"] = true,
				["reset_reload"] = false,
				["sessiontime-text"] = true,
				["showmaxlevel"] = false,
			},
			["id"] = "Experience Bar - Luxthos",
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 1,
			["width"] = 600,
			["sparkHidden"] = "NEVER",
			["auto"] = false,
			["inverse"] = false,
			["icon"] = false,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["saved"] = "JrXkQ4ulU4mZpVYskNelUKiciLcUurPMyoHKFjajYm3u54Lc2u6jMzEPMsebWyq5MyfreahrTGjvCjjwujGKxJuRTd9bRfFsTSubRfxQOarbzyGKoGCsSYutjOulS0ulUeWQfWp",
			},
			["useTooltip"] = false,
		},
		["Silver Ore"] = {
			["iconSource"] = -1,
			["parent"] = "Ore Count",
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["url"] = "https://wago.io/iST6tz9t8/1",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["itemName"] = 2775,
						["use_count"] = true,
						["use_absorbMode"] = true,
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "item",
						["subeventSuffix"] = "_CAST_START",
						["use_exact_itemName"] = true,
						["names"] = {
						},
						["use_itemName"] = true,
						["unit"] = "player",
						["use_includeBank"] = true,
						["duration"] = "1",
						["spellIds"] = {
						},
						["event"] = "Item Count",
						["count"] = "0",
						["unevent"] = "auto",
						["subeventPrefix"] = "SPELL",
						["count_operator"] = ">",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_anchorYOffset"] = 0,
					["type"] = "subtext",
					["text_anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "PT Sans Narrow",
					["anchorXOffset"] = 0,
					["text_shadowYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_fontSize"] = 16,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_shadowXOffset"] = 0,
				}, -- [2]
				{
					["glowFrequency"] = 0,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowDuration"] = 1,
					["useGlowColor"] = false,
					["glow"] = true,
					["glowThickness"] = 1,
					["glowScale"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 40,
			["load"] = {
				["use_namerealm"] = true,
				["ingroup"] = {
					["single"] = "solo",
				},
				["namerealm"] = "Mxzq",
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["use_ingroup"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["use_never"] = true,
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["source"] = "import",
			["uid"] = "SNwIXidkSmY",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["xOffset"] = 0,
			["regionType"] = "icon",
			["information"] = {
				["forceEvents"] = true,
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["useTooltip"] = true,
			["anchorFrameParent"] = false,
			["cooldownTextDisabled"] = false,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["semver"] = "1.0.0",
			["tocversion"] = 90002,
			["id"] = "Silver Ore",
			["useCooldownModRate"] = true,
			["alpha"] = 1,
			["width"] = 40,
			["frameStrata"] = 1,
			["config"] = {
			},
			["inverse"] = false,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["conditions"] = {
			},
			["cooldown"] = false,
			["cooldownEdge"] = false,
		},
		["target cast bar - uninterruptable"] = {
			["sparkWidth"] = 20,
			["iconSource"] = 0,
			["user_x"] = 0,
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["sameTexture"] = true,
			["url"] = "https://wago.io/r19H1zQ4Z/1",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.60000002384186, -- [4]
			},
			["fontFlags"] = "OUTLINE",
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["enableGradient"] = false,
			["selfPoint"] = "CENTER",
			["barColor"] = {
				0.92549019607843, -- [1]
				0, -- [2]
				0.047058823529412, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["rotation"] = 0,
			["sparkOffsetY"] = 0,
			["gradientOrientation"] = "HORIZONTAL",
			["crop_y"] = 0.41,
			["startAngle"] = 0,
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["blendMode"] = "BLEND",
			["texture"] = "xVerminClean",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["spark"] = false,
			["compress"] = false,
			["alpha"] = 1,
			["config"] = {
			},
			["backgroundOffset"] = 2,
			["borderBackdrop"] = "Birg00",
			["color"] = {
			},
			["desaturateBackground"] = false,
			["sparkRotationMode"] = "AUTO",
			["desaturateForeground"] = false,
			["triggers"] = {
				{
					["trigger"] = {
						["use_castType"] = false,
						["type"] = "unit",
						["debuffType"] = "HELPFUL",
						["unevent"] = "auto",
						["sourceUnit"] = "target",
						["names"] = {
						},
						["event"] = "Cast",
						["subeventPrefix"] = "SPELL",
						["unit"] = "target",
						["use_unit"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = true,
						["subeventSuffix"] = "_CAST_START",
						["use_interruptible"] = false,
						["use_cloneId"] = false,
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
						["unit"] = "target",
					},
				}, -- [1]
				["disjunctive"] = "all",
				["activeTriggerMode"] = 1,
			},
			["endAngle"] = 360,
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["preset"] = "fade",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["preset"] = "fade",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
				},
			},
			["version"] = 1,
			["subRegions"] = {
				{
					["border_size"] = 1,
					["border_anchor"] = "bar",
					["border_offset"] = 3,
					["border_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						0.60000002384186, -- [4]
					},
					["border_visible"] = false,
					["border_edge"] = "Square Clean",
					["type"] = "subborder",
				}, -- [1]
				{
					["type"] = "subbackground",
				}, -- [2]
				{
					["type"] = "subforeground",
				}, -- [3]
				{
					["text_shadowXOffset"] = 1,
					["text_text"] = "%p",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_n_format"] = "none",
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["anchorXOffset"] = 0,
					["text_text_format_p_time_precision"] = 1,
					["text_text_format_p_format"] = "timed",
					["type"] = "subtext",
					["text_anchorXOffset"] = -10,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Homespun (xCT+)",
					["text_shadowYOffset"] = -1,
					["text_anchorYOffset"] = -2,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "INNER_RIGHT",
					["text_text_format_p_time_format"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
					["text_fontSize"] = 30,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_p_time_legacy_floor"] = false,
				}, -- [4]
				{
					["text_shadowXOffset"] = 1,
					["text_text"] = "%n",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_anchorXOffset"] = 10,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Arial Narrow",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "INNER_LEFT",
					["text_text_format_n_format"] = "none",
					["text_visible"] = true,
					["text_fontSize"] = 30,
					["anchorXOffset"] = 0,
					["text_anchorYOffset"] = -2,
				}, -- [5]
				{
					["text_text_format_t_time_precision"] = 1,
					["text_text_format_s_format"] = "none",
					["text_text_format_t_time_legacy_floor"] = false,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_fixedWidth"] = 64,
					["text_text_format_p_time_legacy_floor"] = false,
					["rotateText"] = "NONE",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_text_format_t_time_format"] = 0,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["text_text_format_t_format"] = "timed",
					["type"] = "subtext",
					["text_font"] = "Arial Narrow",
					["text_text_format_t_time_dynamic_threshold"] = 60,
					["text_anchorYOffset"] = -2,
					["text_fontType"] = "OUTLINE",
					["text_text_format_p_time_format"] = 0,
					["text_text_format_t_time_mod_rate"] = true,
					["text_anchorPoint"] = "ICON_CENTER",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_p_time_precision"] = 1,
					["text_text_format_p_time_mod_rate"] = true,
					["text_text"] = "%p",
					["text_shadowXOffset"] = 1,
				}, -- [6]
				{
					["border_offset"] = 0,
					["border_anchor"] = "bar",
					["border_size"] = 2,
					["border_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["border_visible"] = true,
					["border_edge"] = "Drop Shadow",
					["type"] = "subborder",
				}, -- [7]
			},
			["height"] = 50,
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["backgroundTexture"] = "Textures\\SpellActivationOverlays\\Eclipse_Sun",
			["source"] = "import",
			["icon"] = false,
			["barColor2"] = {
				1, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["crop_x"] = 0.41,
			["mirror"] = false,
			["backdropColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
			},
			["load"] = {
				["talent2"] = {
					["multi"] = {
					},
				},
				["use_never"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
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
				["size"] = {
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
				["race"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["foregroundTexture"] = "Textures\\SpellActivationOverlays\\Eclipse_Sun",
			["parent"] = "1. Target Cast Bar",
			["icon_side"] = "LEFT",
			["user_y"] = 0,
			["width"] = 1000,
			["sparkHeight"] = 70,
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
			["id"] = "target cast bar - uninterruptable",
			["semver"] = "1.0.0",
			["foregroundColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["sparkHidden"] = "NEVER",
			["crop"] = 0.41,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["inverse"] = false,
			["sparkOffsetX"] = 0,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["uid"] = "FEzEiNc)qo0",
		},
		["GEMS"] = {
			["controlledChildren"] = {
				"Agate", -- [1]
				"Jade", -- [2]
				"Citrine", -- [3]
				"Ruby", -- [4]
				"Water", -- [5]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["url"] = "https://wago.io/U0WH3IJ3S/1",
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
			["internalVersion"] = 70,
			["selfPoint"] = "BOTTOMLEFT",
			["version"] = 1,
			["subRegions"] = {
			},
			["load"] = {
				["use_class"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
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
			["scale"] = 1,
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "group",
			["borderSize"] = 2,
			["config"] = {
			},
			["borderOffset"] = 4,
			["semver"] = "1.0.0",
			["tocversion"] = 11304,
			["id"] = "GEMS",
			["xOffset"] = 40,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SELECTFRAME",
			["anchorFrameFrame"] = "MultiBarBottomRightButton12",
			["borderInset"] = 1,
			["uid"] = "Ow32WYEI1Ji",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
				["forceEvents"] = true,
				["groupOffset"] = true,
			},
			["groupIcon"] = 134105,
		},
		["Gold Ore"] = {
			["iconSource"] = -1,
			["parent"] = "Ore Count",
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["url"] = "https://wago.io/iST6tz9t8/1",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["itemName"] = 2776,
						["use_count"] = true,
						["duration"] = "1",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["type"] = "item",
						["subeventSuffix"] = "_CAST_START",
						["use_exact_itemName"] = true,
						["unit"] = "player",
						["event"] = "Item Count",
						["use_absorbMode"] = true,
						["use_includeBank"] = true,
						["spellIds"] = {
						},
						["count"] = "0",
						["unevent"] = "auto",
						["names"] = {
						},
						["use_itemName"] = true,
						["use_unit"] = true,
						["count_operator"] = ">",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_shadowXOffset"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_shadowYOffset"] = 0,
					["type"] = "subtext",
					["text_anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "PT Sans Narrow",
					["anchorXOffset"] = 0,
					["text_anchorYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_fontSize"] = 16,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
				{
					["glowFrequency"] = 0,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowDuration"] = 1,
					["useGlowColor"] = false,
					["glow"] = true,
					["glowThickness"] = 1,
					["glowScale"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 40,
			["load"] = {
				["use_namerealm"] = true,
				["ingroup"] = {
					["single"] = "solo",
				},
				["namerealm"] = "Mxzq",
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["use_ingroup"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["use_never"] = true,
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["source"] = "import",
			["uid"] = "5OWh9H2wVJm",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["xOffset"] = 0,
			["regionType"] = "icon",
			["information"] = {
				["forceEvents"] = true,
			},
			["selfPoint"] = "CENTER",
			["cooldownEdge"] = false,
			["useTooltip"] = true,
			["anchorFrameParent"] = false,
			["zoom"] = 0.3,
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = false,
			["semver"] = "1.0.0",
			["tocversion"] = 90002,
			["id"] = "Gold Ore",
			["alpha"] = 1,
			["useCooldownModRate"] = true,
			["width"] = 40,
			["frameStrata"] = 1,
			["config"] = {
			},
			["inverse"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["cooldown"] = false,
			["authorOptions"] = {
			},
		},
		["Leaving Combat"] = {
			["outline"] = "THICKOUTLINE",
			["wagoID"] = "03U1JIxdy",
			["parent"] = "Fade in-out Text Combat Indicator",
			["displayText"] = "Leaving Combat",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/03U1JIxdy/1",
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
						["showClones"] = true,
						["useName"] = false,
						["use_incombat"] = false,
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Conditions",
						["unit"] = "player",
						["use_inCombat"] = true,
						["auranames"] = {
							"Shadowform", -- [1]
						},
						["spellIds"] = {
						},
						["use_unit"] = true,
						["names"] = {
						},
						["type"] = "unit",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["colorR"] = 1,
					["duration_type"] = "seconds",
					["alphaType"] = "straight",
					["colorA"] = 1,
					["colorG"] = 1,
					["alphaFunc"] = "function(progress, start, delta)\n    return start + (progress * delta)\nend\n",
					["use_translate"] = true,
					["use_alpha"] = true,
					["type"] = "custom",
					["easeType"] = "none",
					["translateFunc"] = "function(progress, startX, startY, deltaX, deltaY)\n    return startX + (progress * deltaX), startY + (progress * deltaY)\nend\n",
					["scaley"] = 1,
					["alpha"] = 0,
					["scalex"] = 1,
					["y"] = 0,
					["x"] = -200,
					["use_color"] = false,
					["easeStrength"] = 3,
					["colorB"] = 1,
					["rotate"] = 0,
					["translateType"] = "straightTranslate",
					["duration"] = "2",
				},
				["main"] = {
					["colorR"] = 1,
					["scalex"] = 1,
					["alphaType"] = "hide",
					["colorA"] = 1,
					["colorG"] = 1,
					["alphaFunc"] = "function()\n    return 0\nend\n",
					["use_translate"] = true,
					["use_alpha"] = true,
					["type"] = "custom",
					["easeType"] = "none",
					["translateFunc"] = "function(progress, startX, startY, deltaX, deltaY)\n    return startX + (progress * deltaX), startY + (progress * deltaY)\nend\n",
					["scaley"] = 1,
					["alpha"] = 0,
					["preset"] = "shake",
					["y"] = 0,
					["x"] = 200,
					["colorB"] = 1,
					["easeStrength"] = 3,
					["duration"] = "2",
					["rotate"] = 0,
					["translateType"] = "straightTranslate",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["colorR"] = 1,
					["scalex"] = 1,
					["alphaType"] = "hide",
					["colorA"] = 1,
					["colorG"] = 1,
					["alphaFunc"] = "function()\n    return 0\nend\n",
					["use_translate"] = true,
					["use_alpha"] = true,
					["type"] = "none",
					["easeType"] = "none",
					["translateFunc"] = "function(progress, startX, startY, deltaX, deltaY)\n    return startX + (progress * deltaX), startY + (progress * deltaY)\nend\n",
					["scaley"] = 1,
					["alpha"] = 0,
					["y"] = 0,
					["x"] = 200,
					["duration"] = "2",
					["colorB"] = 1,
					["rotate"] = 0,
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["translateType"] = "straightTranslate",
				},
			},
			["desc"] = "Made by cakemos",
			["font"] = "Friz Quadrata TT",
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_never"] = false,
				["talent"] = {
					["single"] = 98,
					["multi"] = {
						[56] = true,
						[98] = true,
					},
				},
				["zoneIds"] = "",
				["class"] = {
					["single"] = "PRIEST",
					["multi"] = {
						["PRIEST"] = true,
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
			["fontSize"] = 40,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["regionType"] = "text",
			["fixedWidth"] = 200,
			["automaticWidth"] = "Auto",
			["authorOptions"] = {
			},
			["yOffset"] = 0,
			["wordWrap"] = "WordWrap",
			["semver"] = "1.0.0",
			["justify"] = "LEFT",
			["tocversion"] = 30400,
			["id"] = "Leaving Combat",
			["uid"] = "VgBdg6ZT9TS",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["xOffset"] = 270,
			["config"] = {
			},
			["selfPoint"] = "BOTTOM",
			["color"] = {
				0, -- [1]
				1, -- [2]
				0.011764705882353, -- [3]
				1, -- [4]
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["preferToUpdate"] = false,
		},
		["Dark Iron Ore"] = {
			["iconSource"] = -1,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = false,
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
						["itemName"] = 11370,
						["use_count"] = true,
						["duration"] = "1",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["type"] = "item",
						["subeventSuffix"] = "_CAST_START",
						["use_exact_itemName"] = true,
						["unit"] = "player",
						["event"] = "Item Count",
						["use_unit"] = true,
						["use_includeBank"] = true,
						["spellIds"] = {
						},
						["count"] = "0",
						["unevent"] = "auto",
						["use_absorbMode"] = true,
						["use_itemName"] = true,
						["names"] = {
						},
						["count_operator"] = ">",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_anchorYOffset"] = 0,
					["type"] = "subtext",
					["text_anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "PT Sans Narrow",
					["anchorXOffset"] = 0,
					["text_shadowYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_fontSize"] = 16,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_shadowXOffset"] = 0,
				}, -- [2]
				{
					["glowFrequency"] = 0,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowDuration"] = 1,
					["useGlowColor"] = false,
					["glow"] = true,
					["glowThickness"] = 1,
					["glowScale"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 40,
			["load"] = {
				["use_namerealm"] = true,
				["ingroup"] = {
					["single"] = "solo",
				},
				["namerealm"] = "Mxzq",
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["use_ingroup"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["use_never"] = true,
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["source"] = "import",
			["uid"] = "oN2SA6pc0W4",
			["icon"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["information"] = {
				["forceEvents"] = true,
			},
			["url"] = "https://wago.io/iST6tz9t8/1",
			["useTooltip"] = true,
			["parent"] = "Ore Count",
			["anchorFrameParent"] = false,
			["cooldownTextDisabled"] = false,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["semver"] = "1.0.0",
			["tocversion"] = 90002,
			["id"] = "Dark Iron Ore",
			["useCooldownModRate"] = true,
			["alpha"] = 1,
			["width"] = 40,
			["frameStrata"] = 1,
			["config"] = {
			},
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["conditions"] = {
			},
			["cooldown"] = false,
			["xOffset"] = 0,
		},
		["CP2"] = {
			["color"] = {
				0.99607843137255, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -283,
			["anchorPoint"] = "CENTER",
			["url"] = "https://wago.io/HCaWT5tJa/14",
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
						["use_power"] = true,
						["genericShowOn"] = "showOnActive",
						["use_unit"] = true,
						["powertype"] = 4,
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "unit",
						["unevent"] = "auto",
						["power_operator"] = {
							">=", -- [1]
						},
						["event"] = "Power",
						["unit"] = "player",
						["power"] = {
							"2", -- [1]
						},
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["use_requirePowerType"] = false,
						["names"] = {
						},
						["duration"] = "1",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["itemName"] = 150936,
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["genericShowOn"] = "showOnActive",
						["subeventPrefix"] = "SPELL",
						["unit"] = "player",
						["use_unit"] = true,
						["use_itemName"] = true,
						["unevent"] = "auto",
						["use_inverse"] = true,
						["event"] = "Item Equipped",
						["type"] = "item",
					},
					["untrigger"] = {
						["itemName"] = 150936,
					},
				}, -- [2]
				["disjunctive"] = "all",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 70,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["rotation"] = 0,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 10,
			["rotate"] = true,
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["ROGUE"] = true,
						["DRUID"] = true,
					},
				},
				["use_class"] = false,
				["role"] = {
					["multi"] = {
					},
				},
				["level"] = {
					"70", -- [1]
				},
				["zoneIds"] = "",
				["talent2"] = {
					["multi"] = {
					},
				},
				["affixes"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 9,
					["multi"] = {
						[7] = true,
						[9] = true,
					},
				},
				["use_vehicle"] = false,
				["spec"] = {
					["multi"] = {
					},
				},
				["level_operator"] = {
					"<", -- [1]
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
				["use_vehicleUi"] = false,
				["use_combat"] = true,
				["use_level"] = false,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["textureWrapMode"] = "CLAMP",
			["mirror"] = false,
			["regionType"] = "texture",
			["blendMode"] = "BLEND",
			["alpha"] = 1,
			["texture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_White",
			["discrete_rotation"] = 0,
			["xOffset"] = -50,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "CP2",
			["animation"] = {
				["start"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["duration_type"] = "seconds",
					["preset"] = "slideright",
					["easeStrength"] = 3,
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["duration_type"] = "seconds",
					["preset"] = "slideleft",
					["easeStrength"] = 3,
				},
			},
			["frameStrata"] = 2,
			["anchorFrameType"] = "SCREEN",
			["width"] = 67,
			["uid"] = "fm4HOrzkFYa",
			["authorOptions"] = {
			},
			["config"] = {
			},
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["parent"] = "MANA BAR + DRUID / ROGUE CPOINTS",
		},
		["Vermin Druid"] = {
			["grow"] = "LEFT",
			["controlledChildren"] = {
				"Mark of the Wild", -- [1]
				"Omen of Clarity", -- [2]
				"Thorns", -- [3]
				"Fury of Stormrage", -- [4]
				"Clearcasting", -- [5]
				"Savage Roar", -- [6]
				"Dash", -- [7]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["authorOptions"] = {
			},
			["yOffset"] = 20,
			["anchorPoint"] = "CENTER",
			["fullCircle"] = true,
			["rowSpace"] = 1,
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
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["event"] = "Health",
						["names"] = {
						},
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["columnSpace"] = 1,
			["radius"] = 200,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["align"] = "CENTER",
			["stagger"] = 0,
			["config"] = {
			},
			["xOffset"] = -135,
			["load"] = {
				["talent"] = {
					["multi"] = {
					},
				},
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
			["anchorFrameFrame"] = "AceGUI30DropDown4Button",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["useLimit"] = false,
			["animate"] = true,
			["selfPoint"] = "RIGHT",
			["scale"] = 1,
			["centerType"] = "LR",
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["stepAngle"] = 15,
			["borderSize"] = 2,
			["sort"] = "none",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["arcLength"] = 360,
			["constantFactor"] = "RADIUS",
			["regionType"] = "dynamicgroup",
			["borderOffset"] = 4,
			["gridType"] = "RD",
			["gridWidth"] = 5,
			["id"] = "Vermin Druid",
			["borderInset"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["limit"] = 5,
			["uid"] = "jqdDR4yB1fg",
			["space"] = 2,
			["rotation"] = 0,
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
			},
			["internalVersion"] = 70,
		},
		["HEAL"] = {
			["iconSource"] = -1,
			["authorOptions"] = {
				{
					["type"] = "input",
					["useDesc"] = false,
					["width"] = 1,
					["default"] = "",
					["name"] = "Set",
					["multiline"] = false,
					["key"] = "set",
					["length"] = 10,
					["desc"] = "Enter the exact name of the set from ItemRack",
					["useLength"] = false,
				}, -- [1]
			},
			["preferToUpdate"] = false,
			["customText"] = "function()\n    return aura_env.config.set\nend",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["url"] = "https://wago.io/Efx8AqHgR/2",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["custom_type"] = "status",
						["custom_hide"] = "timed",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Health",
						["unit"] = "player",
						["events"] = "PLAYER_ENTERING_WORLD, PLAYER_EQUIPMENT_CHANGED",
						["spellIds"] = {
						},
						["custom"] = "function ()\n    local thingy2 = IsSetEquipped(aura_env.config[\"set\"])\n    if thingy2 == true then\n        return true\n    end\nend",
						["customIcon"] = "function(e)\n    local set = aura_env.config[\"set\"]\n    if ItemRackUser.Sets[set] then\n        return ItemRackUser.Sets[set].icon\n    end\nend",
						["check"] = "event",
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["unevent"] = "auto",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "custom",
				["customTriggerLogic"] = "function(e)\n    local set = aura_env.config[\"set\"]\n    if ItemRackUser.Sets[set] then\n        return true\n    else\n        return false\n    end\nend",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 2,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.25,
					["type"] = "subglow",
					["glowDuration"] = 1,
					["glowScale"] = 1,
					["glowThickness"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["useGlowColor"] = false,
					["glowXOffset"] = 0,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glow"] = false,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "%c",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_shadowXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "OUTER_BOTTOM",
					["text_text_format_p_time_precision"] = 1,
					["text_text_format_p_format"] = "timed",
					["text_fontSize"] = 10,
					["anchorXOffset"] = 0,
					["text_text_format_c_format"] = "none",
				}, -- [3]
			},
			["height"] = 32,
			["load"] = {
				["use_level"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["DRUID"] = true,
					},
				},
				["zoneIds"] = "",
				["level_operator"] = {
					"==", -- [1]
				},
				["use_never"] = false,
				["level"] = {
					"60", -- [1]
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
			["source"] = "import",
			["cooldownTextDisabled"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "if not aura_env.region._clickableFrame2 then\n    aura_env.region._clickableFrame2 = CreateFrame(\"BUTTON\", nil, aura_env.region)\nend\nlocal options_input2 = aura_env.config[\"set\"]\naura_env.region._clickableFrame2:SetAllPoints()\naura_env.region._clickableFrame2:SetScript(\"OnClick\", function()\n        EquipSet(options_input2)\n    end\n)",
					["do_custom"] = true,
				},
			},
			["xOffset"] = 0,
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["regionType"] = "icon",
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = -1,
						["variable"] = "incombat",
						["value"] = 1,
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
						["variable"] = "show",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "sub.2.glow",
						}, -- [1]
					},
				}, -- [2]
			},
			["parent"] = "Vermin ItemRack SetSwapper",
			["selfPoint"] = "CENTER",
			["config"] = {
				["set"] = "heal",
			},
			["anchorFrameParent"] = false,
			["width"] = 32,
			["alpha"] = 1,
			["zoom"] = 0,
			["auto"] = true,
			["tocversion"] = 11305,
			["id"] = "HEAL",
			["semver"] = "1.0.1",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["useCooldownModRate"] = true,
			["uid"] = "xlG4SLLAMuW",
			["inverse"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayIcon"] = 136235,
			["cooldown"] = true,
			["cooldownEdge"] = false,
		},
		["AV Timers"] = {
			["grow"] = "DOWN",
			["controlledChildren"] = {
				"Av Timers", -- [1]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["wagoID"] = "RDC5y57BB",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "TOPLEFT",
			["fullCircle"] = true,
			["space"] = 2,
			["url"] = "https://wago.io/RDC5y57BB/14",
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
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["event"] = "Health",
						["names"] = {
						},
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["columnSpace"] = 1,
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["align"] = "CENTER",
			["source"] = "import",
			["useLimit"] = false,
			["gridType"] = "RD",
			["stagger"] = 0,
			["radius"] = 200,
			["version"] = 14,
			["subRegions"] = {
			},
			["rowSpace"] = 1,
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["load"] = {
				["use_class"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
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
			["arcLength"] = 360,
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["uid"] = "8E8nv4OfjBN",
			["animate"] = true,
			["sortHybridTable"] = {
				["Av Timers"] = false,
			},
			["scale"] = 1,
			["centerType"] = "LR",
			["border"] = false,
			["anchorFrameFrame"] = "Questie_BaseFrame",
			["stepAngle"] = 15,
			["borderSize"] = 2,
			["limit"] = 5,
			["borderEdge"] = "Square Full White",
			["frameStrata"] = 1,
			["anchorFrameParent"] = true,
			["constantFactor"] = "RADIUS",
			["sort"] = "ascending",
			["borderOffset"] = 4,
			["semver"] = "1.0.13",
			["tocversion"] = 20503,
			["id"] = "AV Timers",
			["regionType"] = "dynamicgroup",
			["gridWidth"] = 5,
			["anchorFrameType"] = "SELECTFRAME",
			["borderInset"] = 1,
			["config"] = {
			},
			["xOffset"] = -130,
			["rotation"] = 0,
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["selfPoint"] = "TOP",
		},
		["TANK"] = {
			["iconSource"] = -1,
			["parent"] = "Vermin ItemRack SetSwapper",
			["preferToUpdate"] = false,
			["customText"] = "function()\n    return aura_env.config.set\nend",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["url"] = "https://wago.io/Efx8AqHgR/2",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "if not aura_env.region._clickableFrame3 then\n    aura_env.region._clickableFrame3 = CreateFrame(\"BUTTON\", nil, aura_env.region)\nend\nlocal options_input3 = aura_env.config[\"set\"]\naura_env.region._clickableFrame3:SetAllPoints()\naura_env.region._clickableFrame3:SetScript(\"OnClick\", function()\n        EquipSet(options_input3)\n    end\n)",
					["do_custom"] = true,
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["custom_type"] = "status",
						["custom_hide"] = "timed",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Health",
						["unit"] = "player",
						["events"] = "PLAYER_ENTERING_WORLD, PLAYER_EQUIPMENT_CHANGED",
						["spellIds"] = {
						},
						["custom"] = "function ()\n    local thingy3 = IsSetEquipped(aura_env.config[\"set\"])\n    if thingy3 == true then\n        return true\n    end\nend",
						["customIcon"] = "function(e)\n    local set = aura_env.config[\"set\"]\n    if ItemRackUser.Sets[set] then\n        return ItemRackUser.Sets[set].icon\n    end\nend",
						["check"] = "event",
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["unevent"] = "auto",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "custom",
				["customTriggerLogic"] = "function(e)\n    local set = aura_env.config[\"set\"]\n    if ItemRackUser.Sets[set] then\n        return true\n    else\n        return false\n    end\nend",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 2,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.25,
					["type"] = "subglow",
					["glowDuration"] = 1,
					["glowScale"] = 1,
					["glowThickness"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["useGlowColor"] = false,
					["glowXOffset"] = 0,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glow"] = false,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "%c",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_shadowXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "OUTER_BOTTOM",
					["text_text_format_p_time_precision"] = 1,
					["text_text_format_p_format"] = "timed",
					["text_fontSize"] = 10,
					["anchorXOffset"] = 0,
					["text_text_format_c_format"] = "none",
				}, -- [3]
			},
			["height"] = 32,
			["load"] = {
				["use_level"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["DRUID"] = true,
					},
				},
				["zoneIds"] = "",
				["level_operator"] = {
					"==", -- [1]
				},
				["use_never"] = false,
				["level"] = {
					"60", -- [1]
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
			["source"] = "import",
			["zoom"] = 0,
			["cooldownEdge"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["regionType"] = "icon",
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = -1,
						["variable"] = "incombat",
						["value"] = 1,
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
						["variable"] = "show",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "sub.2.glow",
						}, -- [1]
					},
				}, -- [2]
			},
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["icon"] = true,
			["config"] = {
				["set"] = "tank",
			},
			["anchorFrameParent"] = false,
			["width"] = 32,
			["alpha"] = 1,
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["tocversion"] = 11305,
			["id"] = "TANK",
			["semver"] = "1.0.1",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["useCooldownModRate"] = true,
			["uid"] = "YsfZKf0Od)H",
			["inverse"] = false,
			["xOffset"] = 0,
			["displayIcon"] = 136235,
			["cooldown"] = true,
			["authorOptions"] = {
				{
					["type"] = "input",
					["useDesc"] = false,
					["width"] = 1,
					["default"] = "",
					["name"] = "Set",
					["multiline"] = false,
					["key"] = "set",
					["length"] = 10,
					["desc"] = "Enter the exact name of the set from ItemRack",
					["useLength"] = false,
				}, -- [1]
			},
		},
		["targetdebuffs "] = {
			["iconSource"] = -1,
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["customText"] = "",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["customTextUpdate"] = "update",
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["showClones"] = true,
						["type"] = "aura2",
						["subeventSuffix"] = "_CAST_START",
						["useIgnoreExactSpellId"] = true,
						["fetchTooltip"] = true,
						["event"] = "Health",
						["unit"] = "target",
						["debuffType"] = "HARMFUL",
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["names"] = {
						},
						["ignoreAuraSpellids"] = {
							"206151", -- [1]
						},
						["ignoreAuraNames"] = {
							"", -- [1]
						},
						["useIgnoreName"] = false,
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "any",
				["customTriggerLogic"] = "print(name)",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_shadowXOffset"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_anchorXOffset"] = 14,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "OUTER_TOP",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_anchorYOffset"] = -38,
				}, -- [2]
				{
					["text_shadowXOffset"] = 0,
					["text_text"] = "%p",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_mod_rate"] = true,
					["type"] = "subtext",
					["anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_legacy_floor"] = true,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_text_format_p_time_precision"] = 1,
					["text_fontSize"] = 16,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [3]
				{
					["text_shadowXOffset"] = 0,
					["text_text"] = "%c",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_text_format_c_format"] = "none",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["anchorXOffset"] = 0,
					["text_shadowYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_time_format"] = 0,
					["text_text_format_p_format"] = "timed",
					["text_fontSize"] = 12,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_p_time_precision"] = 1,
				}, -- [4]
			},
			["height"] = 36,
			["load"] = {
				["use_namerealm"] = true,
				["namerealm"] = "dont",
				["talent"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["cooldownTextDisabled"] = true,
			["authorOptions"] = {
			},
			["url"] = "https://wago.io/W1QyYtaAz/1",
			["cooldown"] = false,
			["regionType"] = "icon",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["parent"] = "DEBUFFS - TARGET",
			["selfPoint"] = "CENTER",
			["uid"] = "6DKG8nfVQ8x",
			["anchorFrameParent"] = false,
			["anchorFrameType"] = "SCREEN",
			["alpha"] = 1,
			["zoom"] = 0.3,
			["semver"] = "1.0.0",
			["tocversion"] = 90001,
			["id"] = "targetdebuffs ",
			["auto"] = true,
			["useCooldownModRate"] = true,
			["width"] = 36,
			["frameStrata"] = 1,
			["config"] = {
			},
			["inverse"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["useTooltip"] = true,
		},
		["MobHPPercentGREEN"] = {
			["outline"] = "THICKOUTLINE",
			["color"] = {
				0.098039215686274, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["displayText"] = "%c%",
			["customText"] = "function()\nlocal percent = (UnitHealth(\"target\")/UnitHealthMax(\"target\"))*100\nreturn (\"%.f\"):format(percent)\nend",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/B_hMNakf_/2",
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
						["type"] = "unit",
						["unevent"] = "auto",
						["percenthealth"] = {
							"100", -- [1]
						},
						["duration"] = "1",
						["event"] = "Health",
						["use_unit"] = true,
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["unit"] = "target",
						["use_percenthealth"] = true,
						["percenthealth_operator"] = {
							"<=", -- [1]
						},
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Health",
						["use_unit"] = true,
						["percenthealth"] = {
							"50", -- [1]
						},
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["use_percenthealth"] = true,
						["percenthealth_operator"] = {
							">", -- [1]
						},
						["unit"] = "target",
					},
					["untrigger"] = {
						["unit"] = "target",
					},
				}, -- [2]
				{
					["trigger"] = {
						["type"] = "custom",
						["custom"] = "function()\n    local region = aura_env.region\n    local plate = C_NamePlate.GetNamePlateForUnit(\"target\")\n    \n    \n    if plate then\n        region:ClearAllPoints()\n        region:SetPoint(\"RIGHT\", plate, \"LEFT\", -60, 0)\n        return true\n    else\n        return false\n    end\nend",
						["custom_type"] = "status",
						["check"] = "update",
						["debuffType"] = "HELPFUL",
						["unit"] = "player",
					},
					["untrigger"] = {
					},
				}, -- [3]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["wordWrap"] = "WordWrap",
			["font"] = "Friz Quadrata TT",
			["version"] = 2,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_namerealm"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["namerealm"] = "xxx",
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 24,
			["shadowXOffset"] = 1,
			["preferToUpdate"] = false,
			["regionType"] = "text",
			["displayText_format_c_format"] = "none",
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["fixedWidth"] = 200,
			["anchorFrameParent"] = false,
			["automaticWidth"] = "Auto",
			["authorOptions"] = {
			},
			["config"] = {
			},
			["semver"] = "1.0.1",
			["tocversion"] = 11306,
			["id"] = "MobHPPercentGREEN",
			["shadowYOffset"] = -1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["xOffset"] = 0,
			["uid"] = "eckTlXrxzPt",
			["justify"] = "LEFT",
			["selfPoint"] = "BOTTOM",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["parent"] = "TARGET HP PERCENT",
		},
		["Thorium Ore"] = {
			["iconSource"] = -1,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = false,
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
						["itemName"] = 10620,
						["use_count"] = true,
						["duration"] = "1",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["type"] = "item",
						["subeventSuffix"] = "_CAST_START",
						["use_exact_itemName"] = true,
						["unit"] = "player",
						["event"] = "Item Count",
						["use_unit"] = true,
						["use_includeBank"] = true,
						["spellIds"] = {
						},
						["count"] = "0",
						["unevent"] = "auto",
						["use_absorbMode"] = true,
						["use_itemName"] = true,
						["names"] = {
						},
						["count_operator"] = ">",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_anchorYOffset"] = 0,
					["type"] = "subtext",
					["text_anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "PT Sans Narrow",
					["anchorXOffset"] = 0,
					["text_shadowYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_fontSize"] = 16,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_shadowXOffset"] = 0,
				}, -- [2]
				{
					["glowFrequency"] = 0,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["glowType"] = "buttonOverlay",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowDuration"] = 1,
					["useGlowColor"] = false,
					["glow"] = true,
					["glowThickness"] = 1,
					["glowScale"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 40,
			["load"] = {
				["use_namerealm"] = true,
				["ingroup"] = {
					["single"] = "solo",
				},
				["namerealm"] = "Mxzq",
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["use_ingroup"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["use_never"] = true,
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["source"] = "import",
			["uid"] = "J)RSbn6il4O",
			["icon"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["information"] = {
				["forceEvents"] = true,
			},
			["url"] = "https://wago.io/iST6tz9t8/1",
			["useTooltip"] = true,
			["parent"] = "Ore Count",
			["anchorFrameParent"] = false,
			["cooldownTextDisabled"] = false,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["semver"] = "1.0.0",
			["tocversion"] = 90002,
			["id"] = "Thorium Ore",
			["useCooldownModRate"] = true,
			["alpha"] = 1,
			["width"] = 40,
			["frameStrata"] = 1,
			["config"] = {
			},
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["conditions"] = {
			},
			["cooldown"] = false,
			["xOffset"] = 0,
		},
		["Retaliation"] = {
			["sparkWidth"] = 10,
			["sparkOffsetX"] = 0,
			["wagoID"] = "v9qxdDgI4",
			["parent"] = "Vermin Warrior",
			["preferToUpdate"] = false,
			["sparkHeight"] = 30,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["iconSource"] = -1,
			["cooldownSwipe"] = true,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["cooldownEdge"] = false,
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
						["auranames"] = {
							"Retaliation", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showOnReady",
						["names"] = {
						},
						["debuffType"] = "HELPFUL",
						["type"] = "aura2",
						["unit"] = "player",
						["unevent"] = "auto",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Action Usable",
						["useName"] = true,
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_genericShowOn"] = true,
						["spellName"] = 34428,
						["use_unit"] = true,
						["use_track"] = true,
						["useIgnoreName"] = false,
					},
					["untrigger"] = {
						["genericShowOn"] = "showOnReady",
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
			["useTooltip"] = false,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["xOffset"] = 0,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["barColor"] = {
				0.2, -- [1]
				1, -- [2]
				0.0862745098039216, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["internalVersion"] = 70,
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.75,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["text_color"] = {
					},
					["glowThickness"] = 2,
					["glowDuration"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0.85098039215686, -- [2]
						0.1843137254902, -- [3]
						1, -- [4]
					},
					["useGlowColor"] = true,
					["glow"] = true,
					["glowLength"] = 16,
					["glowType"] = "buttonOverlay",
					["glowScale"] = 1,
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "%p",
					["text_text_format_p_time_mod_rate"] = true,
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_format"] = "timed",
					["type"] = "subtext",
					["anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_shadowXOffset"] = 0,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 12,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
				}, -- [3]
			},
			["height"] = 36,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["load"] = {
				["use_level"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["use_class"] = false,
				["size"] = {
					["multi"] = {
					},
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["use_never"] = false,
				["level"] = {
					"60", -- [1]
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
						["WARRIOR"] = true,
					},
				},
				["zoneIds"] = "",
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["uid"] = "FwT(c989vwc",
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["icon"] = true,
			["conditions"] = {
			},
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "icon",
			["authorOptions"] = {
			},
			["config"] = {
			},
			["icon_side"] = "RIGHT",
			["anchorFrameFrame"] = "PlayerFrame",
			["sparkHidden"] = "NEVER",
			["anchorFrameParent"] = false,
			["texture"] = "Melli",
			["width"] = 36,
			["cooldownTextDisabled"] = false,
			["auto"] = false,
			["useCooldownModRate"] = true,
			["id"] = "Retaliation",
			["zoom"] = 0.3,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["spark"] = false,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["inverse"] = false,
			["frameStrata"] = 1,
			["orientation"] = "HORIZONTAL",
			["displayIcon"] = "",
			["cooldown"] = false,
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
		},
		["Dash"] = {
			["sparkWidth"] = 10,
			["sparkOffsetX"] = 0,
			["wagoID"] = "v9qxdDgI4",
			["parent"] = "Vermin Druid",
			["preferToUpdate"] = false,
			["sparkHeight"] = 30,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["iconSource"] = -1,
			["cooldownSwipe"] = true,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["cooldownEdge"] = false,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Dash", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showOnReady",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["useName"] = true,
						["spellName"] = 34428,
						["unevent"] = "auto",
						["unit"] = "player",
						["use_unit"] = true,
						["event"] = "Action Usable",
						["subeventSuffix"] = "_CAST_START",
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_genericShowOn"] = true,
						["type"] = "aura2",
						["names"] = {
						},
						["use_track"] = true,
						["useIgnoreName"] = false,
					},
					["untrigger"] = {
						["genericShowOn"] = "showOnReady",
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
			["internalVersion"] = 70,
			["keepAspectRatio"] = true,
			["selfPoint"] = "CENTER",
			["xOffset"] = 0,
			["authorOptions"] = {
			},
			["barColor"] = {
				0.2, -- [1]
				1, -- [2]
				0.0862745098039216, -- [3]
				1, -- [4]
			},
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["useTooltip"] = false,
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.5,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["text_color"] = {
					},
					["glowThickness"] = 3,
					["glowDuration"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						0, -- [1]
						1, -- [2]
						0.08235294371843338, -- [3]
						1, -- [4]
					},
					["useGlowColor"] = true,
					["glow"] = true,
					["glowLength"] = 16,
					["glowType"] = "buttonOverlay",
					["glowScale"] = 1,
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "%p",
					["text_text_format_p_time_mod_rate"] = true,
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_format"] = "timed",
					["type"] = "subtext",
					["anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "OUTER_TOP",
					["text_shadowXOffset"] = 0,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 10,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
				}, -- [3]
			},
			["height"] = 36,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["load"] = {
				["use_level"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["use_class"] = true,
				["use_spellknown"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
					},
				},
				["use_never"] = false,
				["level"] = {
					"5", -- [1]
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["zoneIds"] = "",
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["desaturate"] = false,
			["icon"] = true,
			["conditions"] = {
			},
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "icon",
			["spark"] = false,
			["config"] = {
			},
			["icon_side"] = "RIGHT",
			["anchorFrameFrame"] = "PlayerFrame",
			["id"] = "Dash",
			["anchorFrameParent"] = false,
			["texture"] = "Melli",
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = false,
			["auto"] = false,
			["frameStrata"] = 1,
			["sparkHidden"] = "NEVER",
			["zoom"] = 0,
			["useCooldownModRate"] = true,
			["width"] = 36,
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["uid"] = "YJ1QoxqN6FH",
			["inverse"] = false,
			["alpha"] = 1,
			["orientation"] = "HORIZONTAL",
			["displayIcon"] = "",
			["cooldown"] = false,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Zyein Death Knight - Primary Talents - \"Tank\""] = {
			["iconSource"] = -1,
			["wagoID"] = "Jzpifubqi",
			["parent"] = "Talent and Equipment swap (clickable)",
			["preferToUpdate"] = false,
			["customText"] = "function()\n   return aura_env.config[\"equipmentSetName\"] \nend",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["url"] = "https://wago.io/Jzpifubqi/2",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "aura_env.TALENT_GROUP = aura_env.config[\"talentGroup\"] --Which talent spec to activiate, either 1 or 2\nlocal TALENT_GROUP = aura_env.TALENT_GROUP\n\nlocal r = WeakAuras.regions[aura_env.id].region\nlocal b = CreateFrame(\"Button\", aura_env.id, r)\n\nb:SetAllPoints()\nb:SetHighlightTexture(\"Interface\\\\ContainerFrame\\\\UI-Icon-QuestBorder\") --yellow glow\nb:RegisterForClicks(\"LeftButtonUp\") --\"AnyUp\"\nb:SetScript(\"OnClick\",\n    function(self, button, down)\n        WeakAuras.ScanEvents(\"WA_TALENT_EQUIP_SWAP\", TALENT_GROUP, true)\n    end\n)\n--[[\nb:SetScript('OnEnter',\n    function()\n        WeakAuras.ScanEvents('WA_TALENT_EQUIP_SWAP_MOUSEOVER', true)\n    end\n)\nb:SetScript('OnLeave',\n    function()\n        WeakAuras.ScanEvents('WA_TALENT_EQUIP_SWAP_MOUSEOVER', false)\n    end\n)\n--]]",
					["do_custom"] = true,
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["custom_type"] = "event",
						["debuffType"] = "HELPFUL",
						["duration"] = "5",
						["event"] = "Health",
						["unit"] = "player",
						["names"] = {
						},
						["custom"] = "function(e, talentGroup, wasClicked)\n    --WA_TALENT_EQUIP_SWAP is fired when our button is clicked\n    --EQUIPMENT_SETS_CHANGED (no args) is fired by Blizzard's Equipment Manager, we use it to update our icons\n    if wasClicked and talentGroup == aura_env.TALENT_GROUP then\n        SetActiveTalentGroup(aura_env.TALENT_GROUP)\n        return GetActiveTalentGroup() ~= aura_env.TALENT_GROUP --show 5s glow only when swap talents\n    end\n    return false\nend\n\n\n",
						["spellIds"] = {
						},
						["customIcon"] = "function(e)\n    local equipmentSet = aura_env.config[\"equipmentSetName\"]\n    if equipmentSet ~= \"\" then\n        if aura_env.config[\"equipmentManager\"] == 2 then\n            if ItemRack and ItemRackUser.Sets[equipmentSet] then --ItemRack is installed, ItemRack equipment set exists\n                return ItemRackUser.Sets[equipmentSet].icon\n            else\n                return 134400 --Inv_misc_questionmark, ItemRack equipment set doesn't exist\n            end\n        elseif aura_env.config[\"equipmentManager\"] == 1 then\n            local equipmentSetID = C_EquipmentSet.GetEquipmentSetID(equipmentSet)\n            if equipmentSetID then\n                return select(2, C_EquipmentSet.GetEquipmentSetInfo(equipmentSetID))\n            else\n                return 134400 --Inv_misc_questionmark, Blizzard's equipment set doesn't exist\n            end\n        else\n            return 237091 --Inv_inscription_majorglyph01, unknown config option\n        end\n    end\n    return select(2, GetTalentTabInfo(aura_env.TALENT_GROUP)) --not using an equipment set, use the talent tab's icon\nend",
						["events"] = "WA_TALENT_EQUIP_SWAP EQUIPMENT_SETS_CHANGED",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
						["custom"] = "",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "custom",
						["events"] = "ACTIVE_TALENT_GROUP_CHANGED",
						["custom_type"] = "status",
						["check"] = "event",
						["debuffType"] = "HELPFUL",
						["custom"] = "function(e, curr, prev)\n    \n    if curr == aura_env.TALENT_GROUP then\n        \n        local equipmentSetName = aura_env.config[\"equipmentSetName\"]\n        \n        if aura_env.config[\"equipmentManager\"] == 2 then\n            if ItemRack then --ItemRack is installed\n                --ItemRack.EquipSet(aura_env.config[\"equipmentSetName\"]) --there's a race condition preventing this from working, so we add a 0.1 second delay to fix it\n                C_Timer.After(0.1, function() ItemRack.EquipSet(equipmentSetName) end)\n            else\n                print(\"[WA][\"..aura_env.id..\"] Configured to use ItemRack, but ItemRack is not installed.\")\n            end\n        elseif aura_env.config[\"equipmentManager\"] == 1 then\n            local equipmentSetID = C_EquipmentSet.GetEquipmentSetID(equipmentSetName)\n            if equipmentSetID then\n                C_EquipmentSet.UseEquipmentSet(equipmentSetID)\n            else\n                print(\"[WA][\"..aura_env.id..\"] Equipment Manager set \\\"\"..equipmentSetName..\"\\\" does not exist.\")\n            end\n        else\n            print(\"[WA][\"..aura_env.id..\"] ERROR Unknown Equipment Manger config: \"..aura_env.getEquipmentManager())\n        end\n    end\n    \n    return GetActiveTalentGroup() == aura_env.TALENT_GROUP\nend",
						["unit"] = "player",
					},
					["untrigger"] = {
						["custom"] = "function(e, curr, prev)\n    return true\nend",
					},
				}, -- [2]
				{
					["trigger"] = {
						["type"] = "custom",
						["custom_type"] = "status",
						["event"] = "Unit Characteristics",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
						["events"] = "PLAYER_ENTERING_WORLD",
						["unit"] = "player",
						["check"] = "event",
						["talent"] = {
						},
						["custom"] = "function()\n    local dualSpecLearned = GetNumTalentGroups() >= 2\n    return dualSpecLearned\nend",
						["custom_hide"] = "custom",
					},
					["untrigger"] = {
						["custom"] = "",
					},
				}, -- [3]
				["disjunctive"] = "custom",
				["customTriggerLogic"] = "function(t)\n    return t[3] --Dual spec has been learned\nend",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 70,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desaturate"] = false,
			["version"] = 2,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_shadowXOffset"] = 0,
					["text_text"] = "primary",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_p_time_legacy_floor"] = false,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_format"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["type"] = "subtext",
					["text_text_format_p_time_precision"] = 1,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = 0,
					["text_anchorYOffset"] = 0,
					["anchorYOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "INNER_TOP",
					["text_fontType"] = "OUTLINE",
					["text_text_format_p_format"] = "timed",
					["text_fontSize"] = 8,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
				}, -- [2]
				{
					["text_shadowXOffset"] = 0,
					["text_text"] = "%c",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_p_time_legacy_floor"] = false,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["anchorYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["type"] = "subtext",
					["text_text_format_p_time_mod_rate"] = true,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_BOTTOM",
					["text_fontType"] = "OUTLINE",
					["text_text_format_p_time_format"] = 0,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_c_format"] = "none",
				}, -- [3]
				{
					["border_size"] = 14,
					["type"] = "subborder",
					["border_color"] = {
						0.28627450980392, -- [1]
						1, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["border_visible"] = true,
					["border_edge"] = "Blizzard Tooltip",
					["border_offset"] = 0,
				}, -- [4]
				{
					["glowFrequency"] = 0.25,
					["type"] = "subglow",
					["glowDuration"] = 1,
					["glowType"] = "ACShine",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["useGlowColor"] = false,
					["glowXOffset"] = 0,
					["glowScale"] = 1,
					["glowThickness"] = 1,
					["glow"] = false,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [5]
			},
			["height"] = 48,
			["load"] = {
				["use_namerealm"] = true,
				["use_group_leader"] = false,
				["namerealm"] = "Zyein-Mankrik",
				["talent"] = {
					["multi"] = {
					},
				},
				["itemtypeequipped"] = {
				},
				["class"] = {
					["single"] = "DEATHKNIGHT",
					["multi"] = {
						["DEATHKNIGHT"] = true,
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["raid_role"] = {
				},
				["use_class"] = true,
				["role"] = {
					["single"] = "DAMAGER",
					["multi"] = {
					},
				},
				["use_itemequiped"] = false,
				["level_operator"] = {
					">=", -- [1]
				},
				["use_level"] = true,
				["level"] = {
					"40", -- [1]
				},
				["use_item_bonusid_equipped"] = false,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["source"] = "import",
			["config"] = {
				["equipmentSetName"] = "Tank",
				["talentGroup"] = 1,
				["equipmentManager"] = 2,
			},
			["xOffset"] = 0,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["icon"] = true,
			["cooldown"] = false,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "show",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "sub.5.glow",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 2,
						["variable"] = "show",
						["value"] = 0,
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
						{
							["value"] = {
								0.67450980392157, -- [1]
								0.67450980392157, -- [2]
								0.67450980392157, -- [3]
								1, -- [4]
							},
							["property"] = "color",
						}, -- [2]
						{
							["property"] = "sub.4.border_visible",
						}, -- [3]
					},
				}, -- [2]
			},
			["cooldownEdge"] = false,
			["cooldownTextDisabled"] = false,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0,
			["semver"] = "1.0.1",
			["tocversion"] = 30400,
			["id"] = "Zyein Death Knight - Primary Talents - \"Tank\"",
			["frameStrata"] = 1,
			["useCooldownModRate"] = true,
			["width"] = 48,
			["alpha"] = 1,
			["uid"] = "fXTlL3erNrY",
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["displayIcon"] = "",
			["information"] = {
				["forceEvents"] = true,
			},
			["authorOptions"] = {
				{
					["width"] = 1,
					["type"] = "select",
					["values"] = {
						"Primary Talents", -- [1]
						"Secondary Talents", -- [2]
					},
					["name"] = "Talent Group",
					["useDesc"] = true,
					["key"] = "talentGroup",
					["default"] = 1,
					["desc"] = "Which talent spec should activate when clicked? Requires a /reload after changing this.",
				}, -- [1]
				{
					["type"] = "space",
					["variableWidth"] = true,
					["height"] = 1,
					["useHeight"] = false,
					["width"] = 1,
				}, -- [2]
				{
					["width"] = 1,
					["type"] = "select",
					["values"] = {
						"[Feature] Equipment Manager", -- [1]
						"[AddOn] ItemRack", -- [2]
					},
					["name"] = "Equipment Manager",
					["useDesc"] = true,
					["key"] = "equipmentManager",
					["default"] = 1,
					["desc"] = "Which equipment manager to pull data from.",
				}, -- [3]
				{
					["type"] = "input",
					["useDesc"] = true,
					["width"] = 1,
					["default"] = "",
					["name"] = "Equipment set name",
					["multiline"] = false,
					["key"] = "equipmentSetName",
					["length"] = 10,
					["desc"] = "Which equipment set should be equipped when clicked? Leave empty to not equip a set.",
					["useLength"] = false,
				}, -- [4]
			},
		},
		["Global - Time To Die"] = {
			["controlledChildren"] = {
				"Time To Die - Background", -- [1]
				"Time To Die - Text", -- [2]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["wagoID"] = "_AoX6WW26",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -35,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["url"] = "https://wago.io/_AoX6WW26/1",
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
						["names"] = {
						},
						["type"] = "aura2",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["event"] = "Health",
						["unit"] = "player",
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["internalVersion"] = 70,
			["animation"] = {
				["start"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["easeStrength"] = 3,
					["type"] = "none",
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["desc"] = "Author - Merfin\nDiscord: https://discord.gg/q9z5Az6\nCompability: MerfinUI v2",
			["version"] = 1,
			["subRegions"] = {
			},
			["load"] = {
				["talent"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["source"] = "import",
			["scale"] = 1,
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "group",
			["borderSize"] = 2,
			["borderOffset"] = 4,
			["semver"] = "1.0.0",
			["tocversion"] = 20503,
			["id"] = "Global - Time To Die",
			["config"] = {
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["groupIcon"] = "Interface\\Icons\\Ability_Rogue_Disguise",
			["borderInset"] = 1,
			["uid"] = "Fapn7H09iwS",
			["selfPoint"] = "BOTTOMLEFT",
			["conditions"] = {
			},
			["information"] = {
				["groupOffset"] = true,
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["xOffset"] = 63,
		},
		["Reckoning"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["wagoID"] = "v9qxdDgI4",
			["parent"] = "Vermin Paladin",
			["preferToUpdate"] = false,
			["sparkHeight"] = 30,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["sparkOffsetX"] = 0,
			["cooldownSwipe"] = true,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["cooldownEdge"] = false,
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
						["auranames"] = {
							"Reckoning", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showOnReady",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["useName"] = true,
						["use_unit"] = true,
						["unevent"] = "auto",
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["event"] = "Action Usable",
						["type"] = "aura2",
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_genericShowOn"] = true,
						["spellName"] = 34428,
						["names"] = {
						},
						["use_track"] = true,
						["useIgnoreName"] = false,
					},
					["untrigger"] = {
						["genericShowOn"] = "showOnReady",
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
			["useTooltip"] = false,
			["keepAspectRatio"] = true,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["authorOptions"] = {
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["barColor"] = {
				0.2, -- [1]
				1, -- [2]
				0.0862745098039216, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["icon"] = true,
			["internalVersion"] = 70,
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.75,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["text_color"] = {
					},
					["glowThickness"] = 2,
					["glowDuration"] = 1,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0.85098039215686, -- [2]
						0.1843137254902, -- [3]
						1, -- [4]
					},
					["useGlowColor"] = true,
					["glow"] = true,
					["glowLength"] = 16,
					["glowType"] = "buttonOverlay",
					["glowScale"] = 1,
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
				{
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "%p",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["type"] = "subtext",
					["anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_shadowXOffset"] = 0,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 12,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_p_time_mod_rate"] = true,
				}, -- [3]
				{
					["text_text_format_p_time_precision"] = 1,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%s",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_p_time_legacy_floor"] = false,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_format"] = "timed",
					["anchorXOffset"] = 0,
					["type"] = "subtext",
					["text_shadowXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_fontType"] = "OUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_time_mod_rate"] = true,
					["text_anchorYOffset"] = 25,
					["text_fontSize"] = 12,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["anchorYOffset"] = 0,
				}, -- [4]
			},
			["height"] = 40,
			["selfPoint"] = "CENTER",
			["load"] = {
				["use_level"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["level_operator"] = {
					">=", -- [1]
				},
				["use_class"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "PALADIN",
					["multi"] = {
					},
				},
				["use_never"] = false,
				["level"] = {
					"60", -- [1]
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["uid"] = "sjBDpdGEOJU",
			["information"] = {
				["forceEvents"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["conditions"] = {
			},
			["smoothProgress"] = true,
			["anchorFrameFrame"] = "PlayerFrame",
			["regionType"] = "icon",
			["xOffset"] = 0,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["icon_side"] = "RIGHT",
			["useAdjustededMin"] = false,
			["sparkHidden"] = "NEVER",
			["anchorFrameParent"] = false,
			["texture"] = "Melli",
			["anchorFrameType"] = "SCREEN",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["spark"] = false,
			["alpha"] = 1,
			["id"] = "Reckoning",
			["zoom"] = 0.3,
			["useCooldownModRate"] = true,
			["width"] = 40,
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["frameStrata"] = 1,
			["orientation"] = "HORIZONTAL",
			["displayIcon"] = "",
			["cooldown"] = false,
			["cooldownTextDisabled"] = false,
		},
	},
}
