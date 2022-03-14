
WeakAurasSaved = {
	["dynamicIconCache"] = {
	},
	["editor_tab_spaces"] = 4,
	["displays"] = {
		["Loss of Control Icon"] = {
			["iconSource"] = -1,
			["wagoID"] = "pw_hjyCcX",
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
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura2",
						["useExactSpellId"] = true,
						["subeventPrefix"] = "SPELL",
						["event"] = "Health",
						["unit"] = "player",
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["spellIds"] = {
						},
						["auraspellids"] = {
							"19386", -- [1]
							"24131", -- [2]
							"24133", -- [3]
							"27068", -- [4]
						},
						["combineMode"] = "showHighest",
						["auranames"] = {
							"7922", -- [1]
							"20615", -- [2]
							"118", -- [3]
							"6409", -- [4]
							"408", -- [5]
							"25", -- [6]
							"15269", -- [7]
							"10890", -- [8]
							"30002", -- [9]
							"19503", -- [10]
							"14309", -- [11]
							"30225", -- [12]
							"2139", -- [13]
							"6358", -- [14]
							"35954", -- [15]
							"5530", -- [16]
							"2070", -- [17]
							"12540", -- [18]
							"605", -- [19]
							"8983", -- [20]
							"19577", -- [21]
							"853", -- [22]
							"18093", -- [23]
							"20433", -- [24]
							"21152", -- [25]
							"5246", -- [26]
							"2094", -- [27]
							"16097", -- [28]
							"20549", -- [29]
							"8281", -- [30]
							"22289", -- [31]
							"23171", -- [32]
							"12888", -- [33]
							"785", -- [34]
							"19641", -- [35]
							"19364", -- [36]
							"5164", -- [37]
							"12598", -- [38]
							"28730", -- [39]
							"20066", -- [40]
							"33786", -- [41]
							"676", -- [42]
							"1330", -- [43]
							"18469", -- [44]
							"18658", -- [45]
							"710", -- [46]
							"1513", -- [47]
							"19134", -- [48]
							"30283", -- [49]
							"31661", -- [50]
							"22570", -- [51]
							"34490", -- [52]
							"5484", -- [53]
							"27006", -- [54]
							"19410", -- [55]
							"12355", -- [56]
							"12809", -- [57]
						},
						["useName"] = true,
						["debuffType"] = "HARMFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 50,
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
			["version"] = 17,
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
					["text_selfPoint"] = "BOTTOM",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["type"] = "subtext",
					["text_anchorXOffset"] = 0,
					["text_color"] = {
						1, -- [1]
						0.80392156862745, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_font"] = "AR ZhongkaiGBK Medium",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "OUTER_BOTTOM",
					["text_anchorYOffset"] = -35,
					["text_shadowXOffset"] = 3,
					["text_fontSize"] = 15,
					["anchorXOffset"] = 0,
					["text_visible"] = false,
				}, -- [2]
				{
					["text_shadowXOffset"] = 2,
					["text_text"] = "%p",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "CENTER",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_format"] = 0,
					["anchorXOffset"] = 0,
					["type"] = "subtext",
					["text_anchorXOffset"] = 1.7,
					["text_color"] = {
						1, -- [1]
						0.10980392156863, -- [2]
						0.10980392156863, -- [3]
						0.99000000022352, -- [4]
					},
					["border_color"] = {
					},
					["text_anchorYOffset"] = 15,
					["text_shadowYOffset"] = -2,
					["text_fontType"] = "OUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_TOP",
					["text_text_format_p_time_precision"] = 1,
					["text_font"] = "AR CrystalzcuheiGBK Demibold",
					["text_fontSize"] = 17,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
				}, -- [3]
				{
					["type"] = "subborder",
					["border_size"] = 2,
					["text_color"] = {
					},
					["border_color"] = {
						0.10980392156863, -- [1]
						0.10980392156863, -- [2]
						0.10980392156863, -- [3]
						0.6700000166893, -- [4]
					},
					["border_visible"] = true,
					["border_edge"] = "1 Pixel",
					["border_offset"] = 1,
				}, -- [4]
			},
			["height"] = 37,
			["load"] = {
				["ingroup"] = {
				},
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
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["config"] = {
			},
			["url"] = "https://wago.io/pw_hjyCcX/17",
			["useTooltip"] = false,
			["regionType"] = "icon",
			["parent"] = "Superlilya's Loss of Control Effects",
			["cooldown"] = true,
			["xOffset"] = 0,
			["authorOptions"] = {
			},
			["auto"] = true,
			["width"] = 37,
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.16",
			["tocversion"] = 20503,
			["id"] = "Loss of Control Icon",
			["alpha"] = 0.99,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.05,
			["uid"] = "jbxJ5j0N4lg",
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "none",
						["variable"] = "debuffClass",
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								0, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["property"] = "sub.4.border_color",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "magic",
						["variable"] = "debuffClass",
					},
					["changes"] = {
						{
							["value"] = {
								0.2, -- [1]
								0.6, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["property"] = "sub.4.border_color",
						}, -- [1]
					},
				}, -- [2]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "poison",
						["variable"] = "debuffClass",
					},
					["changes"] = {
						{
							["value"] = {
								0, -- [1]
								0.6, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["property"] = "sub.4.border_color",
						}, -- [1]
					},
				}, -- [3]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "curse",
						["variable"] = "debuffClass",
					},
					["changes"] = {
						{
							["value"] = {
								0.6, -- [1]
								0, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["property"] = "sub.4.border_color",
						}, -- [1]
					},
				}, -- [4]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "disease",
						["variable"] = "debuffClass",
					},
					["changes"] = {
						{
							["value"] = {
								0.6, -- [1]
								0.4, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["property"] = "sub.4.border_color",
						}, -- [1]
					},
				}, -- [5]
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["actions"] = {
				["start"] = {
					["message"] = "",
					["do_message"] = false,
					["message_type"] = "RAID_WARNING",
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
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
						["type"] = "item",
						["use_count"] = true,
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["event"] = "Item Count",
						["subeventPrefix"] = "SPELL",
						["use_includeBank"] = false,
						["itemName"] = 8008,
						["count"] = "0",
						["unevent"] = "auto",
						["use_itemName"] = true,
						["unit"] = "player",
						["use_unit"] = true,
						["count_operator"] = "==",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["customTriggerLogic"] = "",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 49,
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
					["glowScale"] = 1,
					["glowThickness"] = 1,
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
				["level_operator"] = ">=",
				["use_class"] = false,
				["use_spellknown"] = false,
				["size"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["level"] = "58",
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["MAGE"] = true,
					},
				},
				["zoneIds"] = "",
			},
			["authorMode"] = true,
			["config"] = {
				["macro"] = {
					["text"] = "/cast Conjure Mana Ruby",
				},
			},
			["parent"] = "GEMS",
			["url"] = "https://wago.io/U0WH3IJ3S/1",
			["regionType"] = "icon",
			["authorOptions"] = {
				{
					["subOptions"] = {
						{
							["type"] = "input",
							["useDesc"] = false,
							["width"] = 1,
							["name"] = "Text",
							["default"] = "",
							["key"] = "text",
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
			["cooldown"] = false,
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
			["selfPoint"] = "CENTER",
			["cooldownTextDisabled"] = false,
			["width"] = 40,
			["zoom"] = 0,
			["auto"] = true,
			["tocversion"] = 11304,
			["id"] = "Ruby",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["semver"] = "1.0.0",
			["uid"] = "UvSV5jPJMlO",
			["inverse"] = false,
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
			["displayIcon"] = 134128,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["xOffset"] = 120,
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
			["yOffset"] = -40,
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
			["useLimit"] = false,
			["align"] = "CENTER",
			["stagger"] = 0,
			["version"] = 1,
			["subRegions"] = {
			},
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
			["selfPoint"] = "LEFT",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["rotation"] = 0,
			["animate"] = false,
			["xOffset"] = 15,
			["scale"] = 0.8,
			["arcLength"] = 360,
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "dynamicgroup",
			["borderSize"] = 2,
			["limit"] = 5,
			["sort"] = "none",
			["uid"] = "e(V6yQRHRNJ",
			["anchorFrameParent"] = true,
			["constantFactor"] = "RADIUS",
			["rowSpace"] = 1,
			["borderOffset"] = 4,
			["semver"] = "1.0.0",
			["tocversion"] = 90001,
			["id"] = "DEBUFFS - PET",
			["gridWidth"] = 5,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SELECTFRAME",
			["internalVersion"] = 49,
			["config"] = {
			},
			["anchorFrameFrame"] = "PetFrame",
			["gridType"] = "RD",
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["fullCircle"] = true,
		},
		["Druid - Shadowmeld"] = {
			["iconSource"] = 0,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -327,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/HCaWT5tJa/14",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Rend", -- [1]
						},
						["ownOnly"] = true,
						["genericShowOn"] = "showAlways",
						["use_unit"] = true,
						["unitExists"] = true,
						["spellName"] = 743,
						["names"] = {
						},
						["useName"] = true,
						["use_genericShowOn"] = true,
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["duration"] = "1",
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = 743,
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["unit"] = "target",
						["type"] = "spell",
						["matchesShowOn"] = "showAlways",
						["use_track"] = true,
						["debuffType"] = "HARMFUL",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				["disjunctive"] = "any",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_fontType"] = "OUTLINE",
					["text_shadowYOffset"] = 0,
					["anchorXOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_time_format"] = 0,
					["text_text_format_p_format"] = "timed",
					["text_fontSize"] = 12,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_p_time_precision"] = 1,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_race"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["HUNTER"] = true,
						["ROGUE"] = true,
					},
				},
				["use_class"] = true,
				["race"] = {
					["single"] = "NightElf",
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "Q3mcnlUnNBa",
			["xOffset"] = 106,
			["cooldownEdge"] = false,
			["regionType"] = "icon",
			["parent"] = "Druid 2.0",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
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
			["zoom"] = 0.3,
			["width"] = 35,
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Druid - Shadowmeld",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["authorOptions"] = {
			},
			["displayIcon"] = 132089,
			["cooldown"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
		},
		["Priest - Dispel Magic"] = {
			["iconSource"] = 0,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -327,
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
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Flame Shock", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["unit"] = "target",
						["unitExists"] = true,
						["debuffType"] = "HARMFUL",
						["use_genericShowOn"] = true,
						["type"] = "spell",
						["ownOnly"] = true,
						["subeventSuffix"] = "_CAST_START",
						["names"] = {
						},
						["spellName"] = 527,
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Dispel Magic",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["useName"] = true,
						["use_track"] = true,
						["duration"] = "1",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 22,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_class"] = true,
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
					["single"] = "PRIEST",
					["multi"] = {
						["SHAMAN"] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = ")hGBnYjIYO3",
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
			["authorOptions"] = {
			},
			["regionType"] = "icon",
			["parent"] = "Priest 2.0",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["icon"] = true,
			["zoom"] = 0.3,
			["width"] = 35,
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Priest - Dispel Magic",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["url"] = "https://wago.io/R8xGfpcxa/14",
			["displayIcon"] = 135894,
			["cooldown"] = true,
			["xOffset"] = -69.777954101563,
		},
		["Priest - Touch of Weakness"] = {
			["iconSource"] = 0,
			["parent"] = "Priest 2.0",
			["preferToUpdate"] = false,
			["yOffset"] = -327,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/R8xGfpcxa/14",
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
							"Flame Shock", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["unitExists"] = true,
						["debuffType"] = "HARMFUL",
						["use_unit"] = true,
						["useName"] = true,
						["use_genericShowOn"] = true,
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "target",
						["spellName"] = 2652,
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Touch of Weakness",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["names"] = {
						},
						["type"] = "spell",
						["ownOnly"] = true,
						["use_track"] = true,
						["matchesShowOn"] = "showAlways",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 22,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_race"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "PRIEST",
					["multi"] = {
						["SHAMAN"] = true,
					},
				},
				["use_class"] = true,
				["race"] = {
					["single"] = "Scourge",
				},
				["zoneIds"] = "",
				["spec"] = {
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
			["cooldownEdge"] = false,
			["icon"] = true,
			["regionType"] = "icon",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["selfPoint"] = "CENTER",
			["zoom"] = 0.3,
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Priest - Touch of Weakness",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 35.5,
			["auto"] = false,
			["uid"] = "V3DT9P4HaWK",
			["inverse"] = false,
			["authorOptions"] = {
			},
			["displayIcon"] = 136143,
			["cooldown"] = true,
			["xOffset"] = -105.77795410156,
		},
		["Priest - Starshards"] = {
			["iconSource"] = 0,
			["parent"] = "Priest 2.0",
			["preferToUpdate"] = false,
			["yOffset"] = -327,
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
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["auranames"] = {
							"Rend", -- [1]
						},
						["ownOnly"] = true,
						["genericShowOn"] = "showAlways",
						["use_unit"] = true,
						["unitExists"] = true,
						["subeventPrefix"] = "SPELL",
						["spellName"] = 19296,
						["unit"] = "target",
						["type"] = "spell",
						["debuffType"] = "HARMFUL",
						["subeventSuffix"] = "_CAST_START",
						["matchesShowOn"] = "showAlways",
						["useName"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["use_exact_spellName"] = false,
						["realSpellName"] = "Starshards",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["duration"] = "1",
						["unevent"] = "auto",
						["use_genericShowOn"] = true,
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
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_race"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "PRIEST",
					["multi"] = {
						["SHAMAN"] = true,
					},
				},
				["use_class"] = true,
				["race"] = {
					["single"] = "NightElf",
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["spec"] = {
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
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["url"] = "https://wago.io/R8xGfpcxa/14",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["icon"] = true,
			["cooldownTextDisabled"] = true,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["auto"] = false,
			["tocversion"] = 11302,
			["id"] = "Priest - Starshards",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["width"] = 35,
			["semver"] = "1.0.13",
			["uid"] = "dCE593jz0My",
			["inverse"] = false,
			["xOffset"] = 71,
			["displayIcon"] = 135753,
			["cooldown"] = true,
			["authorOptions"] = {
			},
		},
		["Warlock - Healthstone #"] = {
			["iconSource"] = 0,
			["xOffset"] = -34.78,
			["preferToUpdate"] = false,
			["yOffset"] = -327,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["itemName"] = 5512,
						["use_count"] = false,
						["auranames"] = {
							"Immolate", -- [1]
						},
						["duration"] = "1",
						["use_unit"] = true,
						["unitExists"] = true,
						["debuffType"] = "HARMFUL",
						["useName"] = true,
						["subeventSuffix"] = "_CAST_START",
						["use_itemName"] = true,
						["event"] = "Item Count",
						["names"] = {
						},
						["spellIds"] = {
						},
						["type"] = "item",
						["unevent"] = "auto",
						["subeventPrefix"] = "SPELL",
						["matchesShowOn"] = "showAlways",
						["unit"] = "target",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 12,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 25,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_class"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class"] = {
					["single"] = "WARLOCK",
					["multi"] = {
						["WARLOCK"] = true,
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
			["config"] = {
			},
			["authorOptions"] = {
			},
			["parent"] = "Warlock 2.0",
			["regionType"] = "icon",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "<=",
						["value"] = "0",
						["variable"] = "value",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
						{
							["value"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								0.49479150772095, -- [4]
							},
							["property"] = "color",
						}, -- [2]
					},
				}, -- [1]
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["auto"] = false,
			["width"] = 35,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.0.11",
			["tocversion"] = 11302,
			["id"] = "Warlock - Healthstone #",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["uid"] = "aJyTspXsqB0",
			["inverse"] = false,
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
			["displayIcon"] = 135230,
			["cooldown"] = true,
			["url"] = "https://wago.io/Y8douZITb/12",
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
						["duration"] = "1",
						["percenthealth"] = "50",
						["event"] = "Health",
						["use_unit"] = true,
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["spellIds"] = {
						},
						["unit"] = "target",
						["subeventPrefix"] = "SPELL",
						["use_percenthealth"] = true,
						["percenthealth_operator"] = "<=",
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
						["unit"] = "target",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["use_percenthealth"] = true,
						["percenthealth_operator"] = ">",
						["percenthealth"] = "20",
					},
					["untrigger"] = {
						["unit"] = "target",
					},
				}, -- [2]
				{
					["trigger"] = {
						["type"] = "custom",
						["custom"] = "function()\n    local region = aura_env.region\n    local plate = C_NamePlate.GetNamePlateForUnit(\"target\")\n    \n    \n    if plate then\n        region:ClearAllPoints()\n        region:SetPoint(\"RIGHT\", plate, \"LEFT\", -20, 0)\n        return true\n    else\n        return false\n    end\nend",
						["custom_type"] = "status",
						["check"] = "update",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [3]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["wordWrap"] = "WordWrap",
			["font"] = "Friz Quadrata TT",
			["version"] = 2,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
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
				["use_combat"] = true,
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
			["fontSize"] = 24,
			["shadowXOffset"] = 1,
			["regionType"] = "text",
			["conditions"] = {
			},
			["parent"] = "TARGET HP PERCENT",
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
			["automaticWidth"] = "Auto",
			["selfPoint"] = "BOTTOM",
			["justify"] = "LEFT",
			["semver"] = "1.0.1",
			["tocversion"] = 11306,
			["id"] = "MobHPPercentYELLOW",
			["uid"] = "skENiiv2ip)",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["xOffset"] = 0,
			["config"] = {
			},
			["shadowYOffset"] = -1,
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["preferToUpdate"] = false,
		},
		["Priest - Fear Ward"] = {
			["iconSource"] = 0,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -327,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/R8xGfpcxa/14",
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
							"Flame Shock", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["unit"] = "target",
						["unitExists"] = true,
						["debuffType"] = "HARMFUL",
						["names"] = {
						},
						["type"] = "spell",
						["use_unit"] = true,
						["subeventSuffix"] = "_CAST_START",
						["matchesShowOn"] = "showAlways",
						["ownOnly"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Fear Ward",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["useName"] = true,
						["spellName"] = 6346,
						["use_genericShowOn"] = true,
						["use_track"] = true,
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 22,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_race"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "PRIEST",
					["multi"] = {
						["SHAMAN"] = true,
					},
				},
				["use_class"] = true,
				["race"] = {
					["single"] = "Dwarf",
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "KCIutHFMs2u",
			["xOffset"] = -105.77795410156,
			["selfPoint"] = "CENTER",
			["regionType"] = "icon",
			["parent"] = "Priest 2.0",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["icon"] = true,
			["zoom"] = 0.3,
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Priest - Fear Ward",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 35.5,
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["authorOptions"] = {
			},
			["displayIcon"] = 135902,
			["cooldown"] = true,
			["cooldownEdge"] = false,
		},
		["Warrior - Rage Bar"] = {
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
			["yOffset"] = -126.99987792969,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["url"] = "https://wago.io/z6xqQay0S/16",
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
			["fontFlags"] = "OUTLINE",
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["selfPoint"] = "CENTER",
			["barColor"] = {
				1, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["sparkOffsetY"] = 0,
			["load"] = {
				["size"] = {
					["multi"] = {
					},
				},
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
					["single"] = "WARRIOR",
					["multi"] = {
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
				["use_class"] = true,
				["role"] = {
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
				["pvptalent"] = {
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
			["texture"] = "Glamour2",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["auto"] = true,
			["tocversion"] = 11302,
			["alpha"] = 1,
			["config"] = {
			},
			["borderBackdrop"] = "None",
			["parent"] = "Warrior 2.0",
			["customText"] = "function()\n    if aura_env.region then\n        local rage = UnitPower(\"player\", Enum.PowerType.Rage)\n        aura_env.region.text3:SetText(rage)\n    end\nend\n\n\n\n\n\n\n\n\n\n\n\n",
			["sparkRotationMode"] = "AUTO",
			["triggers"] = {
				{
					["trigger"] = {
						["use_power"] = false,
						["use_showCost"] = true,
						["unit"] = "player",
						["powertype"] = 1,
						["use_powertype"] = true,
						["custom_hide"] = "timed",
						["type"] = "unit",
						["use_health"] = true,
						["health_operator"] = ">=",
						["genericShowOn"] = "showOnActive",
						["event"] = "Power",
						["use_unit"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["health"] = "0",
						["debuffType"] = "HELPFUL",
						["spellIds"] = {
						},
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
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
			["version"] = 16,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subforeground",
				}, -- [2]
				{
					["text_shadowXOffset"] = 1,
					["text_text"] = "%c ",
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
					["text_visible"] = false,
					["text_anchorPoint"] = "INNER_RIGHT",
					["text_fontSize"] = 15,
					["anchorXOffset"] = 0,
					["text_fontType"] = "None",
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
					["text_font"] = "Expressway",
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
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "ICON_CENTER",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_fontType"] = "None",
				}, -- [5]
				{
					["type"] = "subborder",
					["border_anchor"] = "bar",
					["border_offset"] = 1,
					["border_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["border_visible"] = true,
					["border_edge"] = "1 Pixel",
					["border_size"] = 1,
				}, -- [6]
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
			["uid"] = "StyMi5xaN5(",
			["borderInFront"] = true,
			["xOffset"] = 0,
			["icon_side"] = "RIGHT",
			["icon"] = false,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["sparkHeight"] = 30,
			["sparkOffsetX"] = 0,
			["overlaysTexture"] = {
				"Glamour2", -- [1]
			},
			["width"] = 245,
			["semver"] = "1.0.15",
			["useAdjustededMax"] = false,
			["id"] = "Warrior - Rage Bar",
			["sparkHidden"] = "NEVER",
			["frameStrata"] = 3,
			["anchorFrameType"] = "SCREEN",
			["backgroundColor"] = {
				0.3921568627451, -- [1]
				0, -- [2]
				0, -- [3]
				0.60000002384186, -- [4]
			},
			["zoom"] = 0,
			["inverse"] = false,
			["sparkDesature"] = false,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["spark"] = false,
		},
		["Druid - CP3"] = {
			["color"] = {
				0.99607843137255, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -227,
			["anchorPoint"] = "CENTER",
			["url"] = "https://wago.io/HCaWT5tJa/14",
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
						["use_power"] = true,
						["genericShowOn"] = "showOnActive",
						["use_unit"] = true,
						["powertype"] = 4,
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "unit",
						["unevent"] = "auto",
						["power_operator"] = ">=",
						["event"] = "Power",
						["duration"] = "1",
						["names"] = {
						},
						["spellIds"] = {
						},
						["use_requirePowerType"] = false,
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["power"] = "3",
						["unit"] = "player",
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
						["type"] = "item",
						["event"] = "Item Equipped",
						["use_inverse"] = true,
						["unevent"] = "auto",
						["use_itemName"] = true,
						["use_unit"] = true,
						["unit"] = "player",
					},
					["untrigger"] = {
						["itemName"] = 150936,
					},
				}, -- [2]
				["disjunctive"] = "all",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 49,
			["animation"] = {
				["start"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["preset"] = "slideright",
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
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["preset"] = "slideleft",
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
			["height"] = 30,
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
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["level"] = "70",
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
				["size"] = {
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["use_level"] = false,
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["use_combat"] = true,
				["race"] = {
					["multi"] = {
					},
				},
				["level_operator"] = "<",
			},
			["textureWrapMode"] = "CLAMP",
			["mirror"] = false,
			["regionType"] = "texture",
			["blendMode"] = "BLEND",
			["frameStrata"] = 2,
			["texture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_White",
			["parent"] = "Druid 2.0",
			["xOffset"] = -1.0000610351562,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Druid - CP3",
			["selfPoint"] = "CENTER",
			["alpha"] = 1,
			["width"] = 67,
			["config"] = {
			},
			["uid"] = "q5EKjjhf3aN",
			["anchorFrameType"] = "SCREEN",
			["authorOptions"] = {
			},
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["discrete_rotation"] = 0,
		},
		["Warlock  - Blood Fury"] = {
			["iconSource"] = 0,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -326.63,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["url"] = "https://wago.io/Y8douZITb/12",
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
							"Rend", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["unitExists"] = true,
						["spellName"] = 20572,
						["names"] = {
						},
						["type"] = "spell",
						["unit"] = "target",
						["subeventSuffix"] = "_CAST_START",
						["matchesShowOn"] = "showAlways",
						["useName"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Blood Fury",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["ownOnly"] = true,
						["use_unit"] = true,
						["use_genericShowOn"] = true,
						["use_track"] = true,
						["debuffType"] = "HARMFUL",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 12,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_race"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARLOCK",
					["multi"] = {
						["ROGUE"] = true,
					},
				},
				["use_class"] = true,
				["race"] = {
					["single"] = "Orc",
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "ZT61i6aT2So",
			["cooldownEdge"] = false,
			["icon"] = true,
			["regionType"] = "icon",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["xOffset"] = 106,
			["cooldownTextDisabled"] = true,
			["width"] = 35,
			["zoom"] = 0.3,
			["semver"] = "1.0.11",
			["tocversion"] = 11302,
			["id"] = "Warlock  - Blood Fury",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["displayIcon"] = 135726,
			["cooldown"] = true,
			["parent"] = "Warlock 2.0",
		},
		["Priest - Power Word: Shield"] = {
			["iconSource"] = 0,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -327,
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
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Power Word: Shield", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["unitExists"] = true,
						["matchesShowOn"] = "showAlways",
						["debuffType"] = "HELPFUL",
						["use_genericShowOn"] = true,
						["type"] = "spell",
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["useName"] = true,
						["subeventPrefix"] = "SPELL",
						["event"] = "Cooldown Progress (Spell)",
						["use_exact_spellName"] = false,
						["realSpellName"] = "Power Word: Shield",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["ownOnly"] = true,
						["unevent"] = "auto",
						["spellName"] = 17,
						["use_track"] = true,
						["use_unit"] = true,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_class"] = true,
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
					["single"] = "PRIEST",
					["multi"] = {
						["SHAMAN"] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "y9bZTQ4meEA",
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
			["authorOptions"] = {
			},
			["regionType"] = "icon",
			["parent"] = "Priest 2.0",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["icon"] = true,
			["zoom"] = 0.3,
			["width"] = 35,
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Priest - Power Word: Shield",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["url"] = "https://wago.io/R8xGfpcxa/14",
			["displayIcon"] = 135940,
			["cooldown"] = true,
			["xOffset"] = -34.78,
		},
		["nanShield:Text"] = {
			["outline"] = "OUTLINE",
			["xOffset"] = -8,
			["displayText"] = "%p",
			["yOffset"] = -87,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "update",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["custom"] = "function aura_env:on_tsu(allstates, ...)\n    -- self:log('TSU', self.config.segmentCount)\n    local now = GetTime()\n    local timestamp = self.timestamp or 0\n    local currentAbsorb = self.currentAbsorb\n    local state = allstates[1]\n\n    if not state then\n        state = {\n            changed = true,\n            show = false,\n            progressType = \"static\",\n            school = \"All\",\n            value = 0,\n            total = 0,\n        }\n        allstates[1] = state\n    end\n\n    if state.show ~= (currentAbsorb > 0) then\n        state.show = currentAbsorb > 0\n        state.changed = true\n        state.value = currentAbsorb\n        state.total = self.totalAbsorb\n        state.school = self.currentSchool\n        self.timestamp = now\n    elseif state.value ~= currentAbsorb then\n        state.changed = true\n        state.value = currentAbsorb\n        state.total = self.totalAbsorb\n        state.school = self.currentSchool\n        self.timestamp = now\n    end\n\n    return state.changed\nend\nfunction aura_env:on_nan_shield(event, ...)\n    self:log(event, ...)\n    local minValue, totalAbsorb, minIdx = self:LowestAbsorb(...)\n    self.currentAbsorb = ceil(minValue)\n    self.currentSchool = self.schools[minIdx]\n    self.totalAbsorb = ceil(totalAbsorb)\n    self:log('SetValues', self.currentSchool, self.currentAbsorb, self.totalAbsorb)\nend\naura_env.logPalette = {\n    \"ff6e7dda\",\n    \"ff21dfb9\",\n    \"ffe3f57a\",\n    \"ffed705a\",\n    \"fff8a3e6\",\n}\n\nfunction aura_env:log(...)\n    if self.config and self.config.debugEnabled then\n        local palette = self.logPalette\n        local args = {\n            self.cloneId and\n            format(\"[%s:%s]\", self.id, self.cloneId) or\n            format(\"[%s]\", self.id),\n            ...\n        }\n        for i = 1, #args do\n            args[i] = format(\n                \"|c%s%s|r\",\n                palette[1 + (i - 1) % #palette],\n                tostring(args[i]))\n        end\n        print(unpack(args))\n    end\nend\nfunction aura_env:LowestAbsorb(totalAbsorb, all, physical, magic, ...)\n    self:log('LowestAbsorb', all, physical, magic, ...)\n    local minValue\n    local minIdx\n    local value\n\n    for i = 1, select('#', ...) do\n        value = select(i, ...)\n        if value > 0 and value <= (minValue or value) then\n            minIdx = i + 3\n            minValue = value\n        end\n    end\n\n    if minIdx then\n        minValue = minValue + magic\n    elseif magic > 0 then\n        minValue = magic\n        minIdx = 3\n    end\n\n    if physical > 0 and physical <= (minValue or physical) then\n        minValue = physical\n        minIdx = 2\n    end\n\n    if minIdx then\n        minValue = minValue + all\n    else\n        minValue = all\n        minIdx = 1\n    end\n\n    self:log('LowestAbsorbResult', minValue, totalAbsorb, minIdx)\n    return minValue, totalAbsorb, minIdx\nend\naura_env.schools = {\n    \"All\",\n    \"Physical\",\n    \"Magic\",\n    \"Holy\",\n    \"Fire\",\n    \"Nature\",\n    \"Frost\",\n    \"Shadow\",\n    \"Arcane\",\n}\naura_env.schoolIds = { 127, 1, 126, 2, 4, 8, 16, 32, 64 }\naura_env.schoolIdx = {}\nfor idx, id in ipairs(aura_env.schoolIds) do\n    aura_env.schoolIdx[id] = idx\nend\n",
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
						["event"] = "Health",
						["unit"] = "player",
						["customVariables"] = "{\n    school = {\n        type = \"select\",\n        display = \"Damage Type\",\n        values = {\n            [\"All\"] = \"All\",\n            [\"Physical\"] = \"Physical\",\n            [\"Magic\"] = \"Magic\",\n            [\"Holy\"] = \"Holy\",\n            [\"Fire\"] = \"Fire\",\n            [\"Nature\"] = \"Nature\",\n            [\"Frost\"] = \"Frost\",\n            [\"Shadow\"] = \"Shadow\",\n            [\"Arcane\"] = \"Arcane\"\n        }\n    }\n}",
						["custom"] = "function(...)\n    return aura_env:on_tsu(...)\nend",
						["spellIds"] = {
						},
						["names"] = {
						},
						["check"] = "update",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["subeventPrefix"] = "SPELL",
						["type"] = "custom",
						["events"] = "WA_NAN_SHIELD",
						["subeventSuffix"] = "_CAST_START",
						["custom_type"] = "event",
						["custom"] = "function(...)\n    return aura_env:on_nan_shield(...)\nend",
						["event"] = "Health",
						["custom_hide"] = "custom",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = 1,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 49,
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
			["font"] = "Arial Narrow",
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_class"] = false,
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
					["single"] = "MAGE",
					["multi"] = {
						["MAGE"] = true,
						["PRIEST"] = true,
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["fontSize"] = 18,
			["shadowXOffset"] = 0,
			["url"] = "https://wago.io/TPKPLjUo4/1",
			["regionType"] = "text",
			["displayText_format_p_time_dynamic_threshold"] = 0,
			["selfPoint"] = "BOTTOM",
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "All",
						["variable"] = "school",
					},
					["changes"] = {
						{
							["value"] = {
								0.94901960784314, -- [1]
								0.89411764705882, -- [2]
								0.56078431372549, -- [3]
								0.55140444636345, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "Magic",
						["variable"] = "school",
					},
					["changes"] = {
						{
							["value"] = {
								0, -- [1]
								0.50196078431373, -- [2]
								1, -- [3]
								0.55000001192093, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [2]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "Physical",
						["variable"] = "school",
					},
					["changes"] = {
						{
							["value"] = {
								0.9921568627451, -- [1]
								0.7921568627451, -- [2]
								0.63529411764706, -- [3]
								0.55000001192093, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [3]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "school",
						["value"] = "Arcane",
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								0.61176470588235, -- [2]
								1, -- [3]
								0.55000001192093, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [4]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "Fire",
						["variable"] = "school",
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								0.50196078431373, -- [2]
								0, -- [3]
								0.55000001192093, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [5]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "Frost",
						["variable"] = "school",
					},
					["changes"] = {
						{
							["value"] = {
								0, -- [1]
								1, -- [2]
								1, -- [3]
								0.55000001192093, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [6]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "Holy",
						["variable"] = "school",
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								1, -- [2]
								0, -- [3]
								0.49487835168839, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [7]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "Nature",
						["variable"] = "school",
					},
					["changes"] = {
						{
							["value"] = {
								0.50196078431373, -- [1]
								1, -- [2]
								0, -- [3]
								0.55000001192093, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [8]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "Shadow",
						["variable"] = "school",
					},
					["changes"] = {
						{
							["value"] = {
								0.72941176470588, -- [1]
								0.45882352941177, -- [2]
								1, -- [3]
								0.55000001192093, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [9]
			},
			["displayText_format_p_time_precision"] = 1,
			["shadowYOffset"] = 0,
			["semver"] = "1.0.0",
			["uid"] = "pGdpCt6LJm)",
			["justify"] = "CENTER",
			["tocversion"] = 11305,
			["id"] = "nanShield:Text",
			["authorOptions"] = {
				{
					["type"] = "toggle",
					["name"] = "Enable Debug Info",
					["default"] = false,
					["useDesc"] = false,
					["key"] = "debugEnabled",
					["width"] = 1,
				}, -- [1]
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.49742370843887, -- [4]
			},
			["config"] = {
				["debugEnabled"] = false,
			},
			["wordWrap"] = "WordWrap",
			["parent"] = "Shield",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["preferToUpdate"] = false,
		},
		["Ranged"] = {
			["sparkWidth"] = 10,
			["sparkOffsetX"] = 0,
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["auto"] = true,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["parent"] = "Swing Timers",
			["sparkRotation"] = 0,
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/fpdm12tUX/1",
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
						["subeventPrefix"] = "SPELL",
						["use_inverse"] = false,
						["event"] = "Swing Timer",
						["use_unit"] = true,
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["spellIds"] = {
						},
						["use_hand"] = true,
						["unit"] = "player",
						["names"] = {
						},
						["hand"] = "ranged",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
						["hand"] = "ranged",
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
			["internalVersion"] = 49,
			["iconSource"] = -1,
			["selfPoint"] = "CENTER",
			["backdropInFront"] = false,
			["sparkRotationMode"] = "AUTO",
			["barColor"] = {
				1, -- [1]
				0.6078431372549019, -- [2]
				0.06274509803921569, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["spark"] = false,
			["authorOptions"] = {
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
					["text_text_format_p_format"] = "timed",
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
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = -1,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "INNER_RIGHT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_visible"] = false,
					["text_fontSize"] = 8,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [3]
				{
					["text_shadowXOffset"] = 0,
					["text_text"] = "Ranged",
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
					["text_fontType"] = "None",
					["text_anchorPoint"] = "INNER_LEFT",
					["text_fontSize"] = 8,
					["anchorXOffset"] = 0,
					["text_visible"] = false,
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
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "ICON_CENTER",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_visible"] = false,
				}, -- [5]
				{
					["type"] = "subborder",
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
					["border_offset"] = 5,
				}, -- [6]
			},
			["height"] = 6,
			["uid"] = "(R3kCEqElPt",
			["load"] = {
				["zoneIds"] = "",
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
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
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["anchorFrameType"] = "SCREEN",
			["alpha"] = 1,
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
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["borderInFront"] = true,
			["sparkHidden"] = "NEVER",
			["icon_side"] = "RIGHT",
			["icon"] = false,
			["sparkHeight"] = 30,
			["texture"] = "Glamour2",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["zoom"] = 0,
			["semver"] = "1.0.0",
			["tocversion"] = 11302,
			["id"] = "Ranged",
			["version"] = 1,
			["frameStrata"] = 1,
			["width"] = 200,
			["stickyDuration"] = false,
			["config"] = {
			},
			["inverse"] = true,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["borderBackdrop"] = "Blizzard Tooltip",
		},
		["Warrior - Will of the Forsaken"] = {
			["iconSource"] = 0,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -155.78,
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
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Rend", -- [1]
						},
						["ownOnly"] = true,
						["genericShowOn"] = "showAlways",
						["unit"] = "target",
						["unitExists"] = true,
						["debuffType"] = "HARMFUL",
						["names"] = {
						},
						["useName"] = true,
						["type"] = "spell",
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["spellName"] = 7744,
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Will of the Forsaken",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["use_genericShowOn"] = true,
						["use_track"] = true,
						["matchesShowOn"] = "showAlways",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 16,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_race"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
						["ROGUE"] = true,
					},
				},
				["use_class"] = true,
				["race"] = {
					["single"] = "Scourge",
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "g6K7fjhvX5L",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["xOffset"] = 106,
			["regionType"] = "icon",
			["parent"] = "Warrior 2.0",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["selfPoint"] = "CENTER",
			["zoom"] = 0.3,
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.15",
			["tocversion"] = 11302,
			["id"] = "Warrior - Will of the Forsaken",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 35,
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["url"] = "https://wago.io/z6xqQay0S/16",
			["displayIcon"] = 136187,
			["cooldown"] = true,
			["icon"] = true,
		},
		["Shield"] = {
			["grow"] = "CUSTOM",
			["controlledChildren"] = {
				"nanShield:Value", -- [1]
				"nanShield:Text", -- [2]
				"nanShield:Bar", -- [3]
				"nanShield:Segment", -- [4]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["xOffset"] = 375,
			["preferToUpdate"] = false,
			["yOffset"] = 100,
			["gridType"] = "RD",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["space"] = 2,
			["url"] = "https://wago.io/TPKPLjUo4/1",
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
			["internalVersion"] = 49,
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
			["rotation"] = 345,
			["arcLength"] = 30,
			["version"] = 1,
			["subRegions"] = {
			},
			["borderInset"] = 1,
			["groupIcon"] = 135988,
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
					["single"] = "MAGE",
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["fullCircle"] = true,
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["stagger"] = 0,
			["animate"] = false,
			["customGrow"] = "function(newPositions, activeRegions)\n    local offset = 9/64 -- target_indicator_glow texture center offset\n    local distance = 18/64\n    local angle, x, y, h, w, s, c, sb, cb, da\n    local curveAngle, segmentCount, direction, base, direction\n\n    for i, r in ipairs(activeRegions) do\n        if r.region.GetRotation then\n            direction = r.data.config.direction\n            base = (r.data.config.rotationOffset + direction * 180)\n            angle = r.region:GetRotation() - direction * 180\n            h = r.data.height\n            w = r.data.width\n            curveAngle = r.data.config.curveAngle\n            segmentCount = r.data.config.segmentCount\n            s = sin(angle)\n            c = cos(angle)\n            sb = sin(base + (direction - 1) * 180)\n            cb = cos(base + (direction - 1) * 180)\n            da = curveAngle / (segmentCount - 1)\n            radius = 0.5 * w * distance / sin(da / 2)\n            x = c * radius + s * w * offset * (direction - 1.5) * 2 + radius * cb\n            y = s * radius * h / w - c * h * offset * (direction - 1.5) * 2 + radius * h / w * sb\n        else\n            x = 0\n            y = 0\n        end\n\n        if newPositions[i] then\n            newPositions[i][1] = x\n            newPositions[i][2] = y\n        else\n            newPositions[i] = {x, y}\n        end\n    end\nend\n",
			["scale"] = 1,
			["authorOptions"] = {
			},
			["border"] = false,
			["borderEdge"] = "1 Pixel",
			["regionType"] = "dynamicgroup",
			["borderSize"] = 2,
			["sort"] = "none",
			["limit"] = 5,
			["selfPoint"] = "CENTER",
			["constantFactor"] = "RADIUS",
			["uid"] = "QYuwGRyspxh",
			["borderOffset"] = 4,
			["semver"] = "1.0.0",
			["tocversion"] = 11305,
			["id"] = "Shield",
			["frameStrata"] = 1,
			["gridWidth"] = 5,
			["anchorFrameType"] = "SCREEN",
			["radius"] = 300,
			["config"] = {
			},
			["rowSpace"] = 1,
			["anchorPoint"] = "CENTER",
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["useLimit"] = false,
		},
		["Druid - Rage Bar"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -298.03799438477,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["url"] = "https://wago.io/HCaWT5tJa/14",
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
			["fontFlags"] = "OUTLINE",
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["selfPoint"] = "CENTER",
			["barColor"] = {
				1, -- [1]
				0.011764705882353, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["sparkOffsetY"] = 0,
			["load"] = {
				["size"] = {
					["multi"] = {
					},
				},
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
						["DRUID"] = true,
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
				["use_class"] = true,
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
			["texture"] = "Glamour2",
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
			["parent"] = "Druid 2.0",
			["customText"] = "function()\n    if aura_env.region then\n        local rage = UnitPower(\"player\", Enum.PowerType.Rage)\n        aura_env.region.text3:SetText(rage)\n    end\nend\n\n\n\n\n\n\n\n\n\n\n\n",
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
						["use_showCost"] = true,
						["type"] = "unit",
						["use_health"] = true,
						["unevent"] = "auto",
						["subeventPrefix"] = "SPELL",
						["custom_hide"] = "timed",
						["use_requirePowerType"] = true,
						["use_percentpower"] = false,
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Power",
						["health"] = "0",
						["spellIds"] = {
						},
						["duration"] = "1",
						["use_unit"] = true,
						["health_operator"] = ">=",
						["names"] = {
						},
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "all",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
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
					["text_shadowXOffset"] = 1,
					["text_text"] = "%c ",
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
					["text_visible"] = false,
					["text_anchorPoint"] = "INNER_RIGHT",
					["text_fontSize"] = 15,
					["anchorXOffset"] = 0,
					["text_fontType"] = "None",
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
					["text_font"] = "Expressway",
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
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "ICON_CENTER",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_fontType"] = "None",
				}, -- [5]
				{
					["type"] = "subborder",
					["border_anchor"] = "bar",
					["border_offset"] = 1,
					["border_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["border_visible"] = true,
					["border_edge"] = "1 Pixel",
					["border_size"] = 1,
				}, -- [6]
			},
			["height"] = 20,
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["xOffset"] = 0.0003662109375,
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
			["backgroundColor"] = {
				1, -- [1]
				0.011764705882353, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["overlaysTexture"] = {
				"Glamour2", -- [1]
			},
			["auto"] = true,
			["semver"] = "1.0.13",
			["anchorFrameType"] = "SCREEN",
			["id"] = "Druid - Rage Bar",
			["config"] = {
			},
			["frameStrata"] = 3,
			["width"] = 245,
			["sparkHidden"] = "NEVER",
			["zoom"] = 0,
			["inverse"] = false,
			["sparkDesature"] = false,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["uid"] = "EfHcVtp57kn",
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
							["multiline"] = false,
							["length"] = 10,
							["default"] = "",
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
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = false,
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
						["itemName"] = 8078,
						["use_count"] = true,
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["event"] = "Item Count",
						["subeventPrefix"] = "SPELL",
						["use_includeBank"] = false,
						["type"] = "item",
						["count"] = "4",
						["use_unit"] = true,
						["unit"] = "player",
						["use_itemName"] = true,
						["unevent"] = "auto",
						["count_operator"] = "<=",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["customTriggerLogic"] = "",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 49,
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
					["glow"] = true,
					["glowXOffset"] = 0,
					["glowThickness"] = 1,
					["glowScale"] = 1,
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
				["size"] = {
					["multi"] = {
					},
				},
				["level_operator"] = ">=",
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["MAGE"] = true,
					},
				},
				["level"] = "8",
				["use_never"] = false,
				["zoneIds"] = "",
			},
			["uid"] = ")OLyGVxasS6",
			["parent"] = "GEMS",
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
			["regionType"] = "icon",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["cooldown"] = false,
			["displayIcon"] = 132805,
			["url"] = "https://wago.io/U0WH3IJ3S/1",
			["cooldownTextDisabled"] = false,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0,
			["semver"] = "1.0.0",
			["tocversion"] = 11304,
			["id"] = "Water",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["width"] = 40,
			["auto"] = true,
			["config"] = {
				["macro"] = {
					["text"] = "/cast Conjure Water",
				},
			},
			["inverse"] = false,
			["xOffset"] = 160,
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
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["icon"] = true,
		},
		["Priest - Shadowmeld"] = {
			["iconSource"] = 0,
			["parent"] = "Priest 2.0",
			["preferToUpdate"] = false,
			["yOffset"] = -327,
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
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Rend", -- [1]
						},
						["ownOnly"] = true,
						["genericShowOn"] = "showAlways",
						["unit"] = "target",
						["unitExists"] = true,
						["debuffType"] = "HARMFUL",
						["use_unit"] = true,
						["type"] = "spell",
						["use_genericShowOn"] = true,
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["spellName"] = 743,
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = 743,
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["useName"] = true,
						["subeventPrefix"] = "SPELL",
						["names"] = {
						},
						["use_track"] = true,
						["matchesShowOn"] = "showAlways",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_race"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "PRIEST",
					["multi"] = {
						["ROGUE"] = true,
					},
				},
				["use_class"] = true,
				["race"] = {
					["single"] = "NightElf",
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "l5cVrtQzoYw",
			["selfPoint"] = "CENTER",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["authorOptions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["xOffset"] = 106,
			["cooldownTextDisabled"] = true,
			["width"] = 35,
			["zoom"] = 0.3,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Priest - Shadowmeld",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["icon"] = true,
			["displayIcon"] = 132089,
			["cooldown"] = true,
			["url"] = "https://wago.io/R8xGfpcxa/14",
		},
		["Druid - Faerie Fire"] = {
			["iconSource"] = 0,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -327,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/HCaWT5tJa/14",
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
						["subeventSuffix"] = "_CAST_START",
						["ownOnly"] = true,
						["event"] = "Health",
						["names"] = {
						},
						["unitExists"] = true,
						["useName"] = true,
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["auranames"] = {
							"770", -- [1]
							"1414", -- [2]
							"1415", -- [3]
							"1416", -- [4]
							"2889", -- [5]
							"13424", -- [6]
							"13752", -- [7]
							"3739", -- [8]
							"17396", -- [9]
							"17397", -- [10]
						},
						["matchesShowOn"] = "showAlways",
						["unit"] = "target",
						["debuffType"] = "HARMFUL",
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
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_shadowXOffset"] = 0,
					["text_text"] = " %p",
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
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
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
					["single"] = "DRUID",
					["multi"] = {
						["WARLOCK"] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["parent"] = "Druid 2.0",
			["uid"] = "17c9aSE2j1O",
			["xOffset"] = -105,
			["cooldownEdge"] = false,
			["regionType"] = "icon",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["conditions"] = {
			},
			["useTooltip"] = false,
			["authorOptions"] = {
			},
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 1,
			["cooldownTextDisabled"] = true,
			["auto"] = false,
			["tocversion"] = 11302,
			["id"] = "Druid - Faerie Fire",
			["zoom"] = 0.3,
			["alpha"] = 1,
			["width"] = 35.5,
			["semver"] = "1.0.13",
			["config"] = {
			},
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["displayIcon"] = 136033,
			["cooldown"] = true,
			["icon"] = true,
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
				["init"] = {
				},
				["finish"] = {
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
						["debuffType"] = "HELPFUL",
						["subeventPrefix"] = "SPELL",
						["names"] = {
						},
						["buffShowOn"] = "showOnActive",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = 1,
			},
			["columnSpace"] = 1,
			["internalVersion"] = 49,
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
			["desc"] = "Big display of target health percentage with Colors",
			["stagger"] = 0,
			["version"] = 2,
			["authorOptions"] = {
			},
			["config"] = {
			},
			["load"] = {
				["zoneIds"] = "",
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
				["class_and_spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
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
				["use_class"] = "false",
				["spec"] = {
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
			["fullCircle"] = true,
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["rotation"] = 0,
			["animate"] = false,
			["borderInset"] = 1,
			["scale"] = 1,
			["groupIcon"] = 136168,
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "dynamicgroup",
			["borderSize"] = 2,
			["sort"] = "none",
			["grow"] = "DOWN",
			["radius"] = 200,
			["constantFactor"] = "RADIUS",
			["rowSpace"] = 1,
			["borderOffset"] = 4,
			["semver"] = "1.0.1",
			["tocversion"] = 11306,
			["id"] = "TARGET HP PERCENT",
			["gridWidth"] = 5,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["limit"] = 1,
			["uid"] = "RtwiT9kw4p3",
			["anchorPoint"] = "CENTER",
			["selfPoint"] = "TOP",
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["useLimit"] = true,
		},
		["Druid - Barkskin"] = {
			["iconSource"] = 0,
			["parent"] = "Druid 2.0",
			["preferToUpdate"] = false,
			["yOffset"] = -327,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/HCaWT5tJa/14",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Rend", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["unit"] = "target",
						["unitExists"] = true,
						["debuffType"] = "HARMFUL",
						["use_genericShowOn"] = true,
						["useName"] = true,
						["ownOnly"] = true,
						["subeventSuffix"] = "_CAST_START",
						["names"] = {
						},
						["type"] = "spell",
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Barkskin",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["spellName"] = 22812,
						["use_track"] = true,
						["duration"] = "1",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
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
				["disjunctive"] = "any",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 35,
			["load"] = {
				["use_class"] = true,
				["race"] = {
					["single"] = "NightElf",
					["multi"] = {
						["NightElf"] = true,
					},
				},
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["HUNTER"] = true,
						["ROGUE"] = true,
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
			["uid"] = "PH7Ez0qFoLH",
			["xOffset"] = 71,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["regionType"] = "icon",
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
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["zoom"] = 0.3,
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Druid - Barkskin",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 35,
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["cooldownEdge"] = false,
			["displayIcon"] = 136097,
			["cooldown"] = true,
			["authorOptions"] = {
			},
		},
		["Druid - Bash"] = {
			["iconSource"] = 0,
			["parent"] = "Druid 2.0",
			["preferToUpdate"] = false,
			["yOffset"] = -327,
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
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Rend", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["unit"] = "target",
						["unitExists"] = true,
						["debuffType"] = "HARMFUL",
						["names"] = {
						},
						["type"] = "spell",
						["use_genericShowOn"] = true,
						["subeventSuffix"] = "_CAST_START",
						["matchesShowOn"] = "showAlways",
						["spellName"] = 5211,
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Bash",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["useName"] = true,
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["use_track"] = true,
						["ownOnly"] = true,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 35,
			["load"] = {
				["use_class"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["HUNTER"] = true,
						["ROGUE"] = true,
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
			["uid"] = "PqPk)HEOg(u",
			["authorOptions"] = {
			},
			["selfPoint"] = "CENTER",
			["regionType"] = "icon",
			["icon"] = true,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["url"] = "https://wago.io/HCaWT5tJa/14",
			["cooldownTextDisabled"] = true,
			["width"] = 35,
			["zoom"] = 0.3,
			["auto"] = false,
			["tocversion"] = 11302,
			["id"] = "Druid - Bash",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["semver"] = "1.0.13",
			["config"] = {
			},
			["inverse"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayIcon"] = 132114,
			["cooldown"] = true,
			["xOffset"] = -69.78,
		},
		["Priest - Feedback"] = {
			["iconSource"] = 0,
			["xOffset"] = -105.77795410156,
			["preferToUpdate"] = false,
			["yOffset"] = -327,
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
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Flame Shock", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["unitExists"] = true,
						["debuffType"] = "HARMFUL",
						["names"] = {
						},
						["useName"] = true,
						["unit"] = "target",
						["subeventSuffix"] = "_CAST_START",
						["matchesShowOn"] = "showAlways",
						["spellName"] = 19273,
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Feedback",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_unit"] = true,
						["type"] = "spell",
						["use_genericShowOn"] = true,
						["use_track"] = true,
						["ownOnly"] = true,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
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
						["subeventPrefix"] = "SPELL",
						["unevent"] = "auto",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 22,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_race"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "PRIEST",
					["multi"] = {
						["SHAMAN"] = true,
					},
				},
				["use_class"] = true,
				["race"] = {
					["single"] = "Human",
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "N5e2dO1wIP8",
			["icon"] = true,
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
			["regionType"] = "icon",
			["url"] = "https://wago.io/R8xGfpcxa/14",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["authorOptions"] = {
			},
			["cooldownTextDisabled"] = true,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Priest - Feedback",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 35.5,
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayIcon"] = 136189,
			["cooldown"] = true,
			["parent"] = "Priest 2.0",
		},
		["Priest - Psychic Scream"] = {
			["iconSource"] = 0,
			["parent"] = "Priest 2.0",
			["preferToUpdate"] = false,
			["yOffset"] = -327,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/R8xGfpcxa/14",
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
							"Rend", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["unit"] = "target",
						["unitExists"] = true,
						["debuffType"] = "HARMFUL",
						["use_genericShowOn"] = true,
						["type"] = "spell",
						["ownOnly"] = true,
						["subeventSuffix"] = "_CAST_START",
						["names"] = {
						},
						["spellName"] = 8122,
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Psychic Scream",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["useName"] = true,
						["use_track"] = true,
						["duration"] = "1",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_class"] = true,
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
					["single"] = "PRIEST",
					["multi"] = {
						["SHAMAN"] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["config"] = {
			},
			["xOffset"] = 36,
			["selfPoint"] = "CENTER",
			["regionType"] = "icon",
			["cooldownEdge"] = false,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["authorOptions"] = {
			},
			["cooldownTextDisabled"] = true,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Priest - Psychic Scream",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["width"] = 35,
			["auto"] = false,
			["uid"] = "lDumAeeX(Io",
			["inverse"] = false,
			["icon"] = true,
			["displayIcon"] = 136184,
			["cooldown"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Warrior - Execute."] = {
			["iconSource"] = 0,
			["xOffset"] = 50,
			["preferToUpdate"] = false,
			["yOffset"] = -75,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/z6xqQay0S/16",
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
						["track"] = "auto",
						["auranames"] = {
							"2687    ", -- [1]
						},
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showAlways",
						["unit"] = "target",
						["unitExists"] = true,
						["use_unit"] = true,
						["use_track"] = true,
						["subeventPrefix"] = "SPELL",
						["useName"] = true,
						["unevent"] = "auto",
						["spellName"] = 5308,
						["spellIds"] = {
						},
						["type"] = "spell",
						["use_health"] = false,
						["subeventSuffix"] = "_CAST_START",
						["debuffType"] = "HELPFUL",
						["percenthealth"] = "20",
						["event"] = "Cooldown Progress (Spell)",
						["health_operator"] = "<=",
						["realSpellName"] = "Execute",
						["use_spellName"] = true,
						["health"] = "20",
						["matchesShowOn"] = "showAlways",
						["names"] = {
						},
						["use_percenthealth"] = true,
						["percenthealth_operator"] = "<=",
						["duration"] = "1",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["customTriggerLogic"] = "\n\n\n",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 16,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0,
					["type"] = "subglow",
					["useGlowColor"] = true,
					["glowType"] = "Pixel",
					["glowLength"] = 6.4,
					["glowYOffset"] = 0,
					["glowColor"] = {
						0.51764705882353, -- [1]
						0, -- [2]
						0.047058823529412, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["glow"] = false,
					["glowScale"] = 1,
					["glowThickness"] = 1.9,
					["glowLines"] = 13,
					["glowBorder"] = false,
				}, -- [2]
			},
			["height"] = 49,
			["load"] = {
				["use_class"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
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
			["uid"] = "SObCNWXhhIu",
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
			["authorOptions"] = {
			},
			["regionType"] = "icon",
			["cooldownEdge"] = false,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["conditions"] = {
				{
					["check"] = {
						["value"] = 1,
						["op"] = "<=",
						["variable"] = "spellUsable",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "sub.2.glow",
						}, -- [1]
					},
				}, -- [1]
			},
			["parent"] = "Warrior 2.0",
			["cooldownTextDisabled"] = true,
			["width"] = 49,
			["zoom"] = 0.3,
			["auto"] = false,
			["tocversion"] = 11302,
			["id"] = "Warrior - Execute.",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["semver"] = "1.0.15",
			["config"] = {
			},
			["inverse"] = false,
			["icon"] = true,
			["displayIcon"] = 135358,
			["cooldown"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Druid - CP1"] = {
			["color"] = {
				0.99607843137255, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -227,
			["anchorPoint"] = "CENTER",
			["url"] = "https://wago.io/HCaWT5tJa/14",
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
						["use_form"] = true,
						["use_power"] = true,
						["genericShowOn"] = "showOnActive",
						["unit"] = "player",
						["powertype"] = 4,
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "unit",
						["subeventSuffix"] = "_CAST_START",
						["power_operator"] = ">=",
						["duration"] = "1",
						["use_requirePowerType"] = false,
						["use_inverse"] = true,
						["unevent"] = "auto",
						["subeventPrefix"] = "SPELL",
						["spellIds"] = {
						},
						["use_unit"] = true,
						["rune"] = 0,
						["power"] = "1",
						["event"] = "Power",
						["names"] = {
						},
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
						["type"] = "item",
						["event"] = "Item Equipped",
						["use_inverse"] = true,
						["unevent"] = "auto",
						["use_itemName"] = true,
						["use_unit"] = true,
						["unit"] = "player",
					},
					["untrigger"] = {
						["itemName"] = 150936,
					},
				}, -- [2]
				["disjunctive"] = "all",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 49,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["discrete_rotation"] = 0,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 30,
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
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["level"] = "70",
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
				["size"] = {
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["use_level"] = false,
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["use_combat"] = true,
				["race"] = {
					["multi"] = {
					},
				},
				["level_operator"] = "<",
			},
			["textureWrapMode"] = "CLAMP",
			["mirror"] = false,
			["regionType"] = "texture",
			["blendMode"] = "BLEND",
			["frameStrata"] = 2,
			["texture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_White",
			["parent"] = "Druid 2.0",
			["rotation"] = 0,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Druid - CP1",
			["animation"] = {
				["start"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["preset"] = "slideright",
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
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["preset"] = "slideleft",
				},
			},
			["alpha"] = 1,
			["width"] = 67,
			["config"] = {
			},
			["uid"] = "1G6vzVZFHu5",
			["authorOptions"] = {
			},
			["anchorFrameType"] = "SCREEN",
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["xOffset"] = -99.99987792969,
		},
		["Warrior - Berserker Rage"] = {
			["iconSource"] = 0,
			["parent"] = "Warrior 2.0",
			["preferToUpdate"] = false,
			["yOffset"] = -155.78,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/z6xqQay0S/16",
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
							"Rend", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["unit"] = "target",
						["unitExists"] = true,
						["debuffType"] = "HARMFUL",
						["names"] = {
						},
						["type"] = "spell",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["ownOnly"] = true,
						["useName"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Berserker Rage",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["spellName"] = 18499,
						["use_genericShowOn"] = true,
						["duration"] = "1",
						["use_track"] = true,
						["use_unit"] = true,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 16,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_class"] = true,
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
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "cuxwaVwhj58",
			["authorOptions"] = {
			},
			["selfPoint"] = "CENTER",
			["regionType"] = "icon",
			["icon"] = true,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["cooldownEdge"] = false,
			["zoom"] = 0.3,
			["width"] = 35,
			["cooldownTextDisabled"] = true,
			["auto"] = false,
			["tocversion"] = 11302,
			["id"] = "Warrior - Berserker Rage",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["semver"] = "1.0.15",
			["config"] = {
			},
			["inverse"] = false,
			["xOffset"] = 0,
			["displayIcon"] = 136009,
			["cooldown"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Druid - 5Second+ManaRegenSmall"] = {
			["sparkWidth"] = 25,
			["sparkOffsetX"] = 0,
			["color"] = {
			},
			["preferToUpdate"] = false,
			["spark"] = true,
			["yOffset"] = -349.04,
			["anchorPoint"] = "CENTER",
			["iconSource"] = -1,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["url"] = "https://wago.io/HCaWT5tJa/14",
			["icon"] = false,
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "2",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "custom",
						["subeventPrefix"] = "SPELL",
						["unevent"] = "auto",
						["unit"] = "player",
						["subeventSuffix"] = "_ENERGIZE",
						["event"] = "Health",
						["names"] = {
						},
						["custom"] = "function(a, e, t)\n    local currentMana = UnitPower(\"player\" , 0)\n    \n    if currentMana >= UnitPowerMax(\"player\", 0) then\n        return false\n    end\n    \n    if e == \"UNIT_POWER_FREQUENT\" and currentMana > aura_env.lastMana then\n        local duration = 2\n        a[\"\"] = {\n            show = true,\n            changed = true,\n            duration = duration,\n            expirationTime = GetTime() + duration,\n            progressType = \"timed\",\n            autoHide = true\n        }\n        aura_env.lastMana = currentMana\n        \n    elseif e == \"UNIT_SPELLCAST_SUCCEEDED\" and currentMana < aura_env.lastMana then\n        local duration = 6.45 -- why?\n        --local duration = 5\n        a[\"\"] = {\n            show = true,\n            changed = true,\n            duration = duration,\n            expirationTime = GetTime() + duration,\n            progressType = \"timed\",\n            autoHide = true\n        }\n        aura_env.lastMana = currentMana\n    end\n    \n    --aura_env.lastMana = currentMana\n    return true\nend",
						["spellIds"] = {
						},
						["events"] = "UNIT_SPELLCAST_SUCCEEDED:player UNIT_POWER_FREQUENT:player",
						["use_sourceUnit"] = true,
						["check"] = "event",
						["custom_type"] = "stateupdate",
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
			["internalVersion"] = 49,
			["backgroundColor"] = {
				0, -- [1]
				0.22352941176471, -- [2]
				1, -- [3]
				0, -- [4]
			},
			["selfPoint"] = "CENTER",
			["backdropInFront"] = false,
			["borderBackdrop"] = "Blizzard Tooltip",
			["barColor"] = {
				0, -- [1]
				0.23529411764706, -- [2]
				1, -- [3]
				0, -- [4]
			},
			["stickyDuration"] = false,
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
			["parent"] = "Druid 2.0",
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
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_anchorYOffset"] = -10,
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "SPARK",
					["text_fontType"] = "None",
					["text_text_format_p_format"] = "timed",
					["text_fontSize"] = 20,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_precision"] = 1,
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
			["height"] = 1,
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
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
				["size"] = {
					["multi"] = {
					},
				},
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["config"] = {
			},
			["desaturate"] = false,
			["anchorFrameType"] = "SCREEN",
			["alpha"] = 1,
			["version"] = 14,
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["borderInFront"] = true,
			["id"] = "Druid - 5Second+ManaRegenSmall",
			["icon_side"] = "RIGHT",
			["auto"] = true,
			["sparkHeight"] = 35,
			["texture"] = "Glamour2",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["zoom"] = 0,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["sparkHidden"] = "FULL",
			["sparkColor"] = {
				0.97254901960784, -- [1]
				0.96078431372549, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["frameStrata"] = 4,
			["width"] = 245,
			["xOffset"] = 0,
			["uid"] = "kiKo1WailoT",
			["inverse"] = false,
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
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "<",
						["variable"] = "duration",
						["value"] = "5",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "inverse",
						}, -- [1]
					},
				}, -- [1]
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["authorOptions"] = {
			},
		},
		["Priest - Shadowguard"] = {
			["iconSource"] = 0,
			["parent"] = "Priest 2.0",
			["preferToUpdate"] = false,
			["yOffset"] = -327,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/R8xGfpcxa/14",
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
						["track"] = "auto",
						["auranames"] = {
							"Shadowguard", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["unitExists"] = true,
						["ownOnly"] = true,
						["spellName"] = 18137,
						["names"] = {
						},
						["useName"] = true,
						["use_unit"] = true,
						["subeventSuffix"] = "_CAST_START",
						["debuffType"] = "HELPFUL",
						["subeventPrefix"] = "SPELL",
						["event"] = "Cooldown Progress (Spell)",
						["use_exact_spellName"] = false,
						["realSpellName"] = "Shadowguard",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["duration"] = "1",
						["unevent"] = "auto",
						["type"] = "aura2",
						["use_track"] = true,
						["use_genericShowOn"] = true,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 14,
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
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_shadowYOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_fontType"] = "OUTLINE",
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_race"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "PRIEST",
					["multi"] = {
						["SHAMAN"] = true,
					},
				},
				["use_class"] = true,
				["race"] = {
					["single"] = "Troll",
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "ugkIrcgp8zn",
			["xOffset"] = 71,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["cooldownEdge"] = false,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["icon"] = true,
			["zoom"] = 0.3,
			["width"] = 35,
			["cooldownTextDisabled"] = true,
			["auto"] = false,
			["tocversion"] = 11302,
			["id"] = "Priest - Shadowguard",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["semver"] = "1.0.13",
			["config"] = {
			},
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["displayIcon"] = 136051,
			["cooldown"] = true,
			["authorOptions"] = {
			},
		},
		["Warlock - Howl of Terror"] = {
			["iconSource"] = 0,
			["parent"] = "Warlock 2.0",
			["preferToUpdate"] = false,
			["yOffset"] = -327,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["url"] = "https://wago.io/Y8douZITb/12",
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
							"Rend", -- [1]
						},
						["ownOnly"] = true,
						["genericShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["unitExists"] = true,
						["debuffType"] = "HARMFUL",
						["names"] = {
						},
						["useName"] = true,
						["use_genericShowOn"] = true,
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "target",
						["spellName"] = 5484,
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Howl of Terror",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["matchesShowOn"] = "showAlways",
						["type"] = "spell",
						["use_unit"] = true,
						["use_track"] = true,
						["duration"] = "1",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 12,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_class"] = true,
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
					["single"] = "WARLOCK",
					["multi"] = {
						["MAGE"] = true,
						["PRIEST"] = true,
						["WARLOCK"] = true,
						["SHAMAN"] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "BW)LRVWY28d",
			["xOffset"] = 36,
			["authorOptions"] = {
			},
			["regionType"] = "icon",
			["selfPoint"] = "CENTER",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["cooldownTextDisabled"] = true,
			["width"] = 35,
			["zoom"] = 0.3,
			["auto"] = false,
			["tocversion"] = 11302,
			["id"] = "Warlock - Howl of Terror",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["semver"] = "1.0.11",
			["config"] = {
			},
			["inverse"] = false,
			["cooldownEdge"] = false,
			["displayIcon"] = 136147,
			["cooldown"] = true,
			["icon"] = true,
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
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["unit"] = "player",
						["type"] = "aura",
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
				["activeTriggerMode"] = -10,
			},
			["columnSpace"] = 1,
			["radius"] = 200,
			["selfPoint"] = "TOP",
			["align"] = "CENTER",
			["rotation"] = 0,
			["subRegions"] = {
			},
			["height"] = 121.503601074219,
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
				["size"] = {
					["multi"] = {
					},
				},
				["spec"] = {
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
			["arcLength"] = 360,
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["rowSpace"] = 1,
			["animate"] = true,
			["sort"] = "none",
			["scale"] = 1,
			["authorOptions"] = {
			},
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "dynamicgroup",
			["borderSize"] = 2,
			["limit"] = 5,
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
			["fullCircle"] = true,
			["constantFactor"] = "RADIUS",
			["uid"] = "N5YikxjcJsU",
			["borderOffset"] = 16,
			["config"] = {
			},
			["anchorFrameType"] = "SCREEN",
			["id"] = "Details! Boss Mods Group",
			["frameStrata"] = 1,
			["gridWidth"] = 5,
			["width"] = 359.096801757813,
			["gridType"] = "RD",
			["borderInset"] = 0,
			["stagger"] = 0,
			["useLimit"] = false,
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["internalVersion"] = 49,
		},
		["Warrior - Death Wish"] = {
			["iconSource"] = -1,
			["xOffset"] = -98,
			["preferToUpdate"] = false,
			["yOffset"] = -75,
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
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["auranames"] = {
							"Immolate", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["names"] = {
						},
						["unitExists"] = true,
						["use_unit"] = true,
						["debuffType"] = "HARMFUL",
						["use_genericShowOn"] = true,
						["use_remaining"] = false,
						["unit"] = "target",
						["subeventSuffix"] = "_CAST_START",
						["spellName"] = 12328,
						["type"] = "spell",
						["event"] = "Cooldown Progress (Spell)",
						["use_exact_spellName"] = false,
						["realSpellName"] = "Sweeping Strikes",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["duration"] = "1",
						["unevent"] = "auto",
						["useName"] = true,
						["use_track"] = true,
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 16,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 26,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 49,
			["load"] = {
				["use_class"] = true,
				["use_talent"] = true,
				["use_never"] = false,
				["talent"] = {
					["single"] = 33,
					["multi"] = {
						[33] = true,
					},
				},
				["zoneIds"] = "",
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
			["uid"] = "yIHqRGW2Ajd",
			["selfPoint"] = "CENTER",
			["authorOptions"] = {
			},
			["regionType"] = "icon",
			["parent"] = "Warrior 2.0",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
			},
			["url"] = "https://wago.io/z6xqQay0S/16",
			["zoom"] = 0.3,
			["width"] = 49,
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.15",
			["tocversion"] = 11302,
			["id"] = "Warrior - Death Wish",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = true,
			["config"] = {
			},
			["inverse"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayIcon"] = 135817,
			["cooldown"] = true,
			["icon"] = true,
		},
		["Druid - Clearcasting"] = {
			["iconSource"] = 0,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -263,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["auranames"] = {
							"Berserking", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["unitExists"] = true,
						["debuffType"] = "HELPFUL",
						["use_genericShowOn"] = true,
						["type"] = "aura2",
						["spellName"] = 20572,
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["matchesShowOn"] = "showOnActive",
						["event"] = "Cooldown Progress (Spell)",
						["auraspellids"] = {
							"16870", -- [1]
						},
						["realSpellName"] = "Blood Fury",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["unevent"] = "auto",
						["subeventPrefix"] = "SPELL",
						["useExactSpellId"] = true,
						["use_track"] = true,
						["names"] = {
						},
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
						["track"] = "auto",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "custom",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 26,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
				{
					["glowFrequency"] = 0,
					["type"] = "subglow",
					["useGlowColor"] = true,
					["glowType"] = "Pixel",
					["glowLength"] = 6.4,
					["glowYOffset"] = 0,
					["glowColor"] = {
						0.6156862745098, -- [1]
						1, -- [2]
						0.64705882352941, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["glow"] = true,
					["glowScale"] = 1,
					["glowThickness"] = 1.9,
					["glowLines"] = 13,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 49,
			["load"] = {
				["use_class"] = true,
				["race"] = {
					["single"] = "Tauren",
					["multi"] = {
						["Tauren"] = true,
					},
				},
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
					["single"] = "DRUID",
					["multi"] = {
						["DRUID"] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "tkj10H6W5I1",
			["xOffset"] = 99,
			["parent"] = "Druid 2.0",
			["regionType"] = "icon",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = 1,
						["variable"] = "show",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "sub.3.glow",
						}, -- [1]
					},
				}, -- [1]
			},
			["selfPoint"] = "CENTER",
			["cooldownTextDisabled"] = true,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Druid - Clearcasting",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 49,
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["authorOptions"] = {
			},
			["displayIcon"] = 136170,
			["cooldown"] = true,
			["url"] = "https://wago.io/HCaWT5tJa/14",
		},
		["Priest - Hex of Weakness"] = {
			["iconSource"] = 0,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -327,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/R8xGfpcxa/14",
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
							"Flame Shock", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["unit"] = "target",
						["unitExists"] = true,
						["spellName"] = 9035,
						["names"] = {
						},
						["useName"] = true,
						["use_genericShowOn"] = true,
						["unevent"] = "auto",
						["debuffType"] = "HARMFUL",
						["ownOnly"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["subeventSuffix"] = "_CAST_START",
						["realSpellName"] = "Hex of Weakness",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["duration"] = "1",
						["type"] = "spell",
						["use_unit"] = true,
						["use_track"] = true,
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
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
						["subeventPrefix"] = "SPELL",
						["unevent"] = "auto",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 22,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_race"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "PRIEST",
					["multi"] = {
						["SHAMAN"] = true,
					},
				},
				["use_class"] = true,
				["race"] = {
					["single"] = "Troll",
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "LMDBaezptLd",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["xOffset"] = -105.77795410156,
			["regionType"] = "icon",
			["parent"] = "Priest 2.0",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["cooldownEdge"] = false,
			["zoom"] = 0.3,
			["width"] = 35.5,
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Priest - Hex of Weakness",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["displayIcon"] = 136157,
			["cooldown"] = true,
			["icon"] = true,
		},
		["Priest - Mind Blast"] = {
			["iconSource"] = 0,
			["parent"] = "Priest 2.0",
			["preferToUpdate"] = false,
			["yOffset"] = -262,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/R8xGfpcxa/14",
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
						["track"] = "auto",
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["spellName"] = 8092,
						["names"] = {
						},
						["type"] = "spell",
						["use_genericShowOn"] = true,
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["useExactSpellId"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["auraspellids"] = {
							"7384", -- [1]
						},
						["realSpellName"] = "Mind Blast",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["matchesShowOn"] = "showAlways",
						["unit"] = "player",
						["unevent"] = "auto",
						["use_track"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 26,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 49,
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
			["uid"] = "SIqr2)W99s6",
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
			["xOffset"] = 0,
			["regionType"] = "icon",
			["cooldownEdge"] = false,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["icon"] = true,
			["zoom"] = 0.3,
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Priest - Mind Blast",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 49,
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["authorOptions"] = {
			},
			["displayIcon"] = 136224,
			["cooldown"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
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
						["type"] = "aura",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["unit"] = "player",
						["event"] = "Health",
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
			["subRegions"] = {
			},
			["height"] = 20,
			["load"] = {
				["size"] = {
					["multi"] = {
					},
				},
				["race"] = {
					["multi"] = {
					},
				},
				["use_combat"] = true,
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
				["role"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["arcLength"] = 360,
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["rowSpace"] = 1,
			["animate"] = true,
			["sort"] = "none",
			["scale"] = 1,
			["authorOptions"] = {
			},
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "dynamicgroup",
			["borderSize"] = 2,
			["limit"] = 5,
			["internalVersion"] = 49,
			["fullCircle"] = true,
			["constantFactor"] = "RADIUS",
			["uid"] = "XLzBWxn1LoM",
			["borderOffset"] = 16,
			["config"] = {
			},
			["anchorFrameType"] = "SCREEN",
			["id"] = "Details! Aura Group",
			["frameStrata"] = 1,
			["gridWidth"] = 5,
			["width"] = 199.999969482422,
			["gridType"] = "RD",
			["borderInset"] = 0,
			["stagger"] = 0,
			["useLimit"] = false,
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
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
		},
		["Druid - Mana Bar Cat/Bear"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = -349.03799438477,
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
			["selfPoint"] = "CENTER",
			["barColor"] = {
				0.32549019607843, -- [1]
				0.53725490196078, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["sparkOffsetY"] = 0,
			["load"] = {
				["size"] = {
					["multi"] = {
					},
				},
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
						["DRUID"] = true,
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
				["use_class"] = true,
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
				["ingroup"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["texture"] = "Glamour2",
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
			["parent"] = "Druid 2.0",
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
						["use_power"] = false,
						["type"] = "unit",
						["use_health"] = true,
						["unevent"] = "auto",
						["use_showCost"] = true,
						["subeventPrefix"] = "SPELL",
						["use_requirePowerType"] = false,
						["use_percentpower"] = false,
						["debuffType"] = "HELPFUL",
						["subeventSuffix"] = "_CAST_START",
						["spellIds"] = {
						},
						["health"] = "0",
						["unit"] = "player",
						["event"] = "Power",
						["health_operator"] = ">=",
						["use_unit"] = true,
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "all",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
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
					["type"] = "subborder",
					["border_offset"] = 1,
					["border_anchor"] = "bar",
					["text_color"] = {
					},
					["border_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["border_visible"] = true,
					["border_edge"] = "1 Pixel",
					["border_size"] = 1,
				}, -- [3]
			},
			["height"] = 6,
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["authorOptions"] = {
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
			["backgroundColor"] = {
				0.32549019607843, -- [1]
				0.53725490196078, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["overlaysTexture"] = {
				"Glamour2", -- [1]
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "\n\n\n\n\n\n",
					["do_custom"] = false,
				},
			},
			["semver"] = "1.0.13",
			["width"] = 245,
			["id"] = "Druid - Mana Bar Cat/Bear",
			["config"] = {
			},
			["frameStrata"] = 3,
			["anchorFrameType"] = "SCREEN",
			["sparkHidden"] = "NEVER",
			["uid"] = "AOIYnN7jUVG",
			["inverse"] = false,
			["sparkDesature"] = false,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["zoom"] = 0,
		},
		["MEND PET"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["xOffset"] = 18,
			["yOffset"] = 10,
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
						["unit"] = "pet",
						["names"] = {
						},
						["type"] = "aura2",
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
			["internalVersion"] = 49,
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
			["barColor"] = {
				0.2, -- [1]
				1, -- [2]
				0.0862745098039216, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
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
					["text_anchorYOffset"] = 4,
					["text_text_format_n_format"] = "none",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_visible"] = false,
				}, -- [3]
			},
			["height"] = 3,
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
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["icon"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["anchorFrameFrame"] = "PetFrame",
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["config"] = {
			},
			["authorOptions"] = {
			},
			["icon_side"] = "RIGHT",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["sparkHeight"] = 30,
			["texture"] = "Glamour2",
			["auto"] = true,
			["zoom"] = 0,
			["spark"] = false,
			["anchorFrameType"] = "SELECTFRAME",
			["id"] = "MEND PET",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 68,
			["sparkHidden"] = "NEVER",
			["uid"] = "FpXBk3sOate",
			["inverse"] = false,
			["sparkOffsetX"] = 0,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
			},
			["selfPoint"] = "CENTER",
		},
		["Warrior - Shadowmeld"] = {
			["iconSource"] = 0,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -155.78,
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
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Rend", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["unit"] = "target",
						["unitExists"] = true,
						["spellName"] = 743,
						["subeventPrefix"] = "SPELL",
						["useName"] = true,
						["use_unit"] = true,
						["unevent"] = "auto",
						["debuffType"] = "HARMFUL",
						["use_genericShowOn"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["subeventSuffix"] = "_CAST_START",
						["realSpellName"] = 743,
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["ownOnly"] = true,
						["type"] = "spell",
						["names"] = {
						},
						["use_track"] = true,
						["duration"] = "1",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 16,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_race"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
						["ROGUE"] = true,
					},
				},
				["use_class"] = true,
				["race"] = {
					["single"] = "NightElf",
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "wHlOsTERh6p",
			["icon"] = true,
			["selfPoint"] = "CENTER",
			["regionType"] = "icon",
			["parent"] = "Warrior 2.0",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["xOffset"] = 106,
			["cooldownTextDisabled"] = true,
			["width"] = 35,
			["zoom"] = 0.3,
			["semver"] = "1.0.15",
			["tocversion"] = 11302,
			["id"] = "Warrior - Shadowmeld",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["authorOptions"] = {
			},
			["displayIcon"] = 132089,
			["cooldown"] = true,
			["url"] = "https://wago.io/z6xqQay0S/16",
		},
		["Warrior - Rend"] = {
			["iconSource"] = 0,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -75,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/z6xqQay0S/16",
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
							"772 ", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["unitExists"] = true,
						["useName"] = true,
						["spellIds"] = {
						},
						["unit"] = "target",
						["ownOnly"] = true,
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
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 16,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 26,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 49,
			["load"] = {
				["use_class"] = true,
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
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "XiUTxk5Fcnj",
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
			["cooldownEdge"] = false,
			["regionType"] = "icon",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["conditions"] = {
			},
			["parent"] = "Warrior 2.0",
			["cooldownTextDisabled"] = true,
			["width"] = 49,
			["zoom"] = 0.3,
			["semver"] = "1.0.15",
			["tocversion"] = 11302,
			["id"] = "Warrior - Rend",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["xOffset"] = -49,
			["displayIcon"] = 132155,
			["cooldown"] = true,
			["icon"] = true,
		},
		["Curses and Viper"] = {
			["iconSource"] = -1,
			["wagoID"] = "pw_hjyCcX",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -39,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = true,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["useName"] = true,
						["use_debuffClass"] = false,
						["useExactSpellId"] = false,
						["subeventPrefix"] = "SPELL",
						["event"] = "Health",
						["unit"] = "player",
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["spellIds"] = {
						},
						["auraspellids"] = {
						},
						["combineMode"] = "showHighest",
						["auranames"] = {
							"1714", -- [1]
							"980", -- [2]
							"702", -- [3]
							"1490", -- [4]
							"18223", -- [5]
							"704", -- [6]
							"3034", -- [7]
							"9035", -- [8]
						},
						["type"] = "aura2",
						["debuffType"] = "HARMFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 50,
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
			["version"] = 17,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subborder",
					["border_size"] = 1,
					["text_color"] = {
					},
					["border_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["border_visible"] = false,
					["border_edge"] = "Square Full White",
					["border_offset"] = 0.5,
				}, -- [2]
			},
			["height"] = 30,
			["load"] = {
				["ingroup"] = {
				},
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
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["config"] = {
			},
			["url"] = "https://wago.io/pw_hjyCcX/17",
			["useTooltip"] = false,
			["regionType"] = "icon",
			["parent"] = "Superlilya's Loss of Control Effects",
			["cooldown"] = true,
			["xOffset"] = 0,
			["authorOptions"] = {
			},
			["auto"] = true,
			["width"] = 30,
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.16",
			["tocversion"] = 20503,
			["id"] = "Curses and Viper",
			["alpha"] = 0.99,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.05,
			["uid"] = "XYzKgm6z7d(",
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "curse",
						["variable"] = "debuffClass",
					},
					["changes"] = {
						{
							["value"] = {
								0.6, -- [1]
								0, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["property"] = "sub.2.border_color",
						}, -- [1]
						{
							["value"] = true,
							["property"] = "sub.2.border_visible",
						}, -- [2]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "poison",
						["variable"] = "debuffClass",
					},
					["changes"] = {
						{
							["value"] = {
								0, -- [1]
								0.6, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["property"] = "sub.2.border_color",
						}, -- [1]
						{
							["value"] = true,
							["property"] = "sub.2.border_visible",
						}, -- [2]
					},
				}, -- [2]
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["actions"] = {
				["start"] = {
					["message"] = "",
					["do_message"] = false,
					["message_type"] = "RAID_WARNING",
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
		},
		["Warrior - Heroic Strike"] = {
			["iconSource"] = 0,
			["parent"] = "Warrior 2.0",
			["preferToUpdate"] = false,
			["yOffset"] = -75,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["url"] = "https://wago.io/z6xqQay0S/16",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "-- aura_env.slotList = C_ActionBar.FindSpellActionButtons(select(7, GetSpellInfo(\"Heroic Strike\")))",
					["do_custom"] = false,
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["subeventSuffix"] = "_CAST_START",
						["custom_hide"] = "timed",
						["names"] = {
						},
						["event"] = "Health",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["spellIds"] = {
						},
						["custom"] = "function(e)\n    if e == \"ACTIONBAR_UPDATE_STATE\" then\n        if aura_env.slotList and IsCurrentAction(aura_env.slotList[1]) then\n            return true\n        end\n    elseif e == \"ACTIONBAR_SLOT_CHANGED\" or e ==\"ACTIONBAR_PAGE_CHANGED\" then\n        local _, _, icon, _, _, _, spellid = GetSpellInfo(aura_env.config.spell)\n        if icon and spellid then\n            aura_env.icon = icon\n            aura_env.slotList = C_ActionBar.FindSpellActionButtons(spellid)\n        end\n    end\nend",
						["customIcon"] = "function() return aura_env.icon end",
						["check"] = "event",
						["events"] = "ACTIONBAR_UPDATE_STATE ACTIONBAR_SLOT_CHANGED ACTIONBAR_PAGE_CHANGED",
						["custom_type"] = "status",
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
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["unevent"] = "auto",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 16,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 49,
			["load"] = {
				["use_class"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
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
			["uid"] = "8Fc4DuMlcxl",
			["icon"] = true,
			["xOffset"] = -98,
			["regionType"] = "icon",
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
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["conditions"] = {
			},
			["authorOptions"] = {
				{
					["type"] = "input",
					["useDesc"] = false,
					["width"] = 2,
					["name"] = "Spell name or ID",
					["default"] = "Heroic Strike",
					["key"] = "spell",
					["length"] = 10,
					["multiline"] = false,
					["useLength"] = false,
				}, -- [1]
			},
			["cooldownTextDisabled"] = false,
			["width"] = 49,
			["zoom"] = 0.3,
			["semver"] = "1.0.15",
			["tocversion"] = 11302,
			["id"] = "Warrior - Heroic Strike",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = false,
			["config"] = {
				["spell"] = "Heroic Strike",
			},
			["inverse"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayIcon"] = 132282,
			["cooldown"] = false,
			["cooldownEdge"] = false,
		},
		["Warrior - Whirlwind"] = {
			["iconSource"] = 0,
			["parent"] = "Warrior 2.0",
			["preferToUpdate"] = false,
			["yOffset"] = -155.33386230469,
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
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
						},
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showOnCooldown",
						["unit"] = "target",
						["unitExists"] = true,
						["debuffType"] = "HARMFUL",
						["use_genericShowOn"] = true,
						["useName"] = true,
						["duration"] = "1",
						["subeventSuffix"] = "_CAST_START",
						["ownOnly"] = true,
						["spellName"] = 1680,
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Whirlwind",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["type"] = "spell",
						["names"] = {
						},
						["use_track"] = true,
						["use_unit"] = true,
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
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 16,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["text_shadowXOffset"] = 0,
					["text_text"] = " %p",
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
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_class"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
						["WARLOCK"] = true,
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
			["xOffset"] = -105.77807617188,
			["uid"] = "GyOJ1ydR7kv",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["regionType"] = "icon",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["selfPoint"] = "CENTER",
			["icon"] = true,
			["width"] = 35.5,
			["frameStrata"] = 1,
			["zoom"] = 0.3,
			["auto"] = false,
			["tocversion"] = 11302,
			["id"] = "Warrior - Whirlwind",
			["cooldownTextDisabled"] = true,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["semver"] = "1.0.15",
			["config"] = {
			},
			["inverse"] = false,
			["useTooltip"] = false,
			["displayIcon"] = 132369,
			["cooldown"] = true,
			["url"] = "https://wago.io/z6xqQay0S/16",
		},
		["Warlock - Perception"] = {
			["iconSource"] = 0,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -326.63,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["url"] = "https://wago.io/Y8douZITb/12",
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
							"Rend", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["names"] = {
						},
						["unitExists"] = true,
						["spellName"] = 20600,
						["duration"] = "1",
						["type"] = "spell",
						["use_unit"] = true,
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["useName"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Perception",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["ownOnly"] = true,
						["use_genericShowOn"] = true,
						["unit"] = "target",
						["use_track"] = true,
						["debuffType"] = "HARMFUL",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 12,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_race"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARLOCK",
					["multi"] = {
						["ROGUE"] = true,
					},
				},
				["use_class"] = true,
				["race"] = {
					["single"] = "Human",
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "LlweJVq9JnC",
			["cooldownEdge"] = false,
			["authorOptions"] = {
			},
			["regionType"] = "icon",
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
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["xOffset"] = 106,
			["cooldownTextDisabled"] = true,
			["width"] = 35,
			["zoom"] = 0.3,
			["semver"] = "1.0.11",
			["tocversion"] = 11302,
			["id"] = "Warlock - Perception",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["icon"] = true,
			["displayIcon"] = 136090,
			["cooldown"] = true,
			["parent"] = "Warlock 2.0",
		},
		["nanShield:Value"] = {
			["outline"] = "OUTLINE",
			["xOffset"] = 0,
			["displayText"] = "%p",
			["customText"] = "",
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["url"] = "https://wago.io/TPKPLjUo4/1",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["custom"] = "aura_env.active = 0\naura_env.spellSchool = {}\naura_env.currentAbsorb = {}\naura_env.maxAbsorb = {}\naura_env.totalAbsorb = 0\naura_env.schoolAbsorb = {0, 0, 0, 0, 0, 0, 0, 0, 0}\n\nlocal function improvedPowerWordShieldMultiplier()\n    -- FIXME: GetTalentInfo(1, 5)\n    return 1.15\nend\n\naura_env.talentMultiplier = {\n    [   17] = improvedPowerWordShieldMultiplier,\n    [  592] = improvedPowerWordShieldMultiplier,\n    [  600] = improvedPowerWordShieldMultiplier,\n    [ 3747] = improvedPowerWordShieldMultiplier,\n    [ 6065] = improvedPowerWordShieldMultiplier,\n    [ 6066] = improvedPowerWordShieldMultiplier,\n    [10898] = improvedPowerWordShieldMultiplier,\n    [10899] = improvedPowerWordShieldMultiplier,\n    [10900] = improvedPowerWordShieldMultiplier,\n    [10901] = improvedPowerWordShieldMultiplier,\n}\n\nfunction aura_env:CalculateAbsorbValue(spellName, spellId, absorbInfo)\n    -- FIXME: if caster != player\n    local value = 0\n    local keys = self.absorbDbKeys\n    local bonusHealing = GetSpellBonusHealing()\n    local level = UnitLevel(\"player\")\n    local base = absorbInfo[keys.basePoints]\n    local perLevel = absorbInfo[keys.pointsPerLevel]\n    local baseLevel = absorbInfo[keys.baseLevel]\n    local maxLevel = absorbInfo[keys.maxLevel]\n    local spellLevel = absorbInfo[keys.spellLevel]\n    local bonusMult = absorbInfo[keys.healingMultiplier]\n    local baseMultFn = self.talentMultiplier[spellId]\n    local levelPenalty = min(1, 1 - (20 - spellLevel) * .0375)\n    local levels = max(0, min(level, maxLevel) - baseLevel)\n    local baseMult = baseMultFn and baseMultFn() or 1\n    \n    value = (\n        baseMult * (base + levels * perLevel) +\n        bonusHealing * bonusMult * levelPenalty\n    )\n    \n    self:log('CalculateAbsorbValue', spellName,\n        value, base, perLevel, levels, baseMult,\n    bonusHealing, bonusMult, levelPenalty)\n    \n    return value\nend\n\nfunction aura_env:GetBuffId(spellName)\n    local auraName, spellId\n    for i = 1, 255 do\n        auraName, _, _, _, _, _, _, _, _, spellId = UnitBuff(\"player\", i)\n        if auraName == spellName then\n            break\n        elseif not auraName then\n            spellId = nil\n            break\n        end\n    end\n    return spellId\nend\n\nfunction aura_env:ApplyAura(spellName)\n    local school = self.spellSchool[spellName]\n    self:log('ApplyAura', spellName, school)\n    \n    if 0 ~= school then\n        local spellId = self:GetBuffId(spellName)\n        local absorbInfo = self.absorbDb[spellId]\n        \n        self:log('ApplyAuraAbsorbOrNew', spellId)\n        \n        if absorbInfo then\n            local value = self:CalculateAbsorbValue(\n            spellName, spellId, absorbInfo)\n            \n            self:log('ApplyAuraSchool', school)\n            if nil == school then\n                school = absorbInfo[self.absorbDbKeys.school]\n                self.spellSchool[spellName] = school\n            end\n            \n            if self.maxAbsorb[spellName] then\n                self:log('ApplyAuraUpdateCurrent', spellName, value)\n                self.currentAbsorb[spellName] = value\n            else\n                self:log('ApplyAuraSetCurrent', spellName, value)\n                self.active = self.active + 1\n                \n                -- If damage event happened before aura was removed\n                local prevValue = self.currentAbsorb[spellName]\n                self.currentAbsorb[spellName] = value + (prevValue or 0)\n            end\n            \n            self:log('ApplyAuraSetMax', spellName, value)\n            self.maxAbsorb[spellName] = value\n            self:UpdateValues()\n        end\n    end\nend\n\nfunction aura_env:RemoveAura(spellName)\n    self:log('RemoveAura', spellName)\n    if self.currentAbsorb[spellName] then\n        self.currentAbsorb[spellName] = nil\n        self.active = self.active - 1\n        self:log('RemoveAuraRemaining', self.active)\n        if self.active < 1 then\n            self.active = 0\n            wipe(self.maxAbsorb)\n        end\n        self:UpdateValues()\n    end\nend\n\nfunction aura_env:ApplyDamage(spellName, value)\n    self:log('ApplyDamage', spellName, value)\n    local newValue = (self.currentAbsorb[spellName] or 0) - value\n    if self.maxAbsorb[spellName] then\n        self.currentAbsorb[spellName] = max(0, newValue)\n        self:UpdateValues()\n    else\n        self.currentAbsorb[spellName] = newValue\n    end\nend\n\nfunction aura_env:ResetValues()\n    self:log('ResetValues')\n    local spellName\n    wipe(self.currentAbsorb)\n    wipe(self.maxAbsorb)\n    self.active = 0\n    for i = 1, 255 do\n        spellName = UnitBuff(\"player\", i)\n        if not spellName then\n            break\n        end\n        self:ApplyAura(spellName)\n    end\n    self:UpdateValues()\nend\n\nfunction aura_env:UpdateValues()\n    self:log('UpdateValues')\n    local values = self.schoolAbsorb\n    local keys = self.schoolIdx\n    local spellSchool = self.spellSchool\n    local current = self.currentAbsorb\n    local total = 0\n    local key, value, school\n    \n    for i = 1, #values do\n        values[i] = 0\n    end\n    \n    for spell, maxValue in pairs(self.maxAbsorb) do\n        school = spellSchool[spell]\n        key = keys[school]\n        total = total + maxValue\n        value = (current[spell] or 0)\n        values[key] = values[key] + value\n        self:log('UpdateValues', spell, school, key, maxValue, value)\n    end\n    \n    self.totalAbsorb = total\n    WeakAuras.ScanEvents(\"WA_NAN_SHIELD\", total, unpack(values))\n    self:log('UpdateValues', total > 0)\nend\nfunction aura_env:on_cleu(triggerEvent, ...)\n    local event, spellName, spellId, auraName, value\n    local casterGUID = select(8, ...)\n    \n    if triggerEvent == 'OPTIONS' then\n        self:log(triggerEvent, ...)\n    elseif self.playerGUID == casterGUID then\n        self:log(triggerEvent, ...)\n        event = select(2, ...)\n        if event == \"SPELL_AURA_APPLIED\" or event == \"SPELL_AURA_REFRESH\" then\n            spellName = select(13, ...)\n            self:ApplyAura(spellName)\n        elseif event == \"SPELL_AURA_REMOVED\" then\n            spellName = select(13, ...)\n            self:RemoveAura(spellName)\n        elseif event == \"SPELL_ABSORBED\" then\n            if select(20, ...) then\n                spellName = select(20, ...)\n                value = select(22, ...) or 0\n            else\n                spellName = select(17, ...)\n                value = select(19, ...) or 0\n            end\n            self:ApplyDamage(spellName, value)\n        end\n    elseif not casterGUID then\n        self:log(triggerEvent, ...)\n        self:ResetValues()\n    end\nend\naura_env.playerGUID = UnitGUID(\"player\")\naura_env.logPalette = {\n    \"ff6e7dda\",\n    \"ff21dfb9\",\n    \"ffe3f57a\",\n    \"ffed705a\",\n    \"fff8a3e6\",\n}\n\nfunction aura_env:log(...)\n    if self.config and self.config.debugEnabled then\n        local palette = self.logPalette\n        local args = {\n            self.cloneId and\n            format(\"[%s:%s]\", self.id, self.cloneId) or\n            format(\"[%s]\", self.id),\n            ...\n        }\n        for i = 1, #args do\n            args[i] = format(\n                \"|c%s%s|r\",\n                palette[1 + (i - 1) % #palette],\n                tostring(args[i]))\n        end\n        print(unpack(args))\n    end\nend\nfunction aura_env:LowestAbsorb(totalAbsorb, all, physical, magic, ...)\n    self:log('LowestAbsorb', all, physical, magic, ...)\n    local minValue\n    local minIdx\n    local value\n    \n    for i = 1, select('#', ...) do\n        value = select(i, ...)\n        if value > 0 and value <= (minValue or value) then\n            minIdx = i + 3\n            minValue = value\n        end\n    end\n    \n    if minIdx then\n        minValue = minValue + magic\n    elseif magic > 0 then\n        minValue = magic\n        minIdx = 3\n    end\n    \n    if physical > 0 and physical <= (minValue or physical) then\n        minValue = physical\n        minIdx = 2\n    end\n    \n    if minIdx then\n        minValue = minValue + all\n    else\n        minValue = all\n        minIdx = 1\n    end\n    \n    self:log('LowestAbsorbResult', minValue, totalAbsorb, minIdx)\n    return minValue, totalAbsorb, minIdx\nend\naura_env.schools = {\n    \"All\",\n    \"Physical\",\n    \"Magic\",\n    \"Holy\",\n    \"Fire\",\n    \"Nature\",\n    \"Frost\",\n    \"Shadow\",\n    \"Arcane\",\n}\naura_env.schoolIds = { 127, 1, 126, 2, 4, 8, 16, 32, 64 }\naura_env.schoolIdx = {}\nfor idx, id in ipairs(aura_env.schoolIds) do\n    aura_env.schoolIdx[id] = idx\nend\n-- Generated by nan-wa-utils\naura_env.absorbDbKeys = {\n    [\"school\"] = 1,\n    [\"basePoints\"] = 2,\n    [\"pointsPerLevel\"] = 3,\n    [\"baseLevel\"] = 4,\n    [\"maxLevel\"] = 5,\n    [\"spellLevel\"] = 6,\n    [\"healingMultiplier\"] = 7,\n}\naura_env.absorbDb = {\n    [  7848] = {   1,    49,    0,  0,  0,  0, 0  }, -- Absorption\n    [ 25750] = {   1,   247,    0, 20,  0,  0, 0  }, -- Damage Absorb\n    [ 25747] = {   1,   309,    0, 20,  0,  0, 0  }, -- Damage Absorb\n    [ 25746] = {   1,   391,    0, 20,  0,  0, 0  }, -- Damage Absorb\n    [ 23991] = {   1,   494,    0, 20,  0,  0, 0  }, -- Damage Absorb\n    [ 11657] = {   1,    54,    0, 48,  0, 48, 0  }, -- Jang'thraze\n    [  7447] = {   1,    24,    0,  0,  0,  0, 0  }, -- Lesser Absorption\n    [  8373] = {   1,   999,    0,  0,  0,  0, 0  }, -- Mana Shield (PT)\n    [  7423] = {   1,     9,    0,  0,  0,  0, 0  }, -- Minor Absorption\n    [  3288] = {   1,    19,    0, 21,  0, 21, 0  }, -- Moss Hide\n    [ 21956] = {   1,   349,    0, 20,  0,  0, 0  }, -- Physical Protection\n    [  7245] = {   2,   299,    0, 20,  0,  0, 0  }, -- Holy Protection (Rank 1)\n    [ 16892] = {   2,   299,    0, 20,  0,  0, 0  }, -- Holy Protection (Rank 1)\n    [  7246] = {   2,   524,    0, 25,  0,  0, 0  }, -- Holy Protection (Rank 2)\n    [  7247] = {   2,   674,    0, 30,  0,  0, 0  }, -- Holy Protection (Rank 3)\n    [  7248] = {   2,   974,    0, 35,  0,  0, 0  }, -- Holy Protection (Rank 4)\n    [  7249] = {   2,  1349,    0, 40,  0,  0, 0  }, -- Holy Protection (Rank 5)\n    [ 17545] = {   2,  1949,    0, 40,  0,  0, 0  }, -- Holy Protection (Rank 6)\n    [ 27536] = {   2,   299,    0, 60,  0,  0, 0  }, -- Holy Resistance\n    [ 29432] = {   4,  1499,    0, 35,  0,  0, 0  }, -- Fire Protection\n    [ 17543] = {   4,  1949,    0, 35,  0,  0, 0  }, -- Fire Protection\n    [ 18942] = {   4,  1949,    0, 35,  0,  0, 0  }, -- Fire Protection\n    [  7230] = {   4,   299,    0, 20,  0,  0, 0  }, -- Fire Protection (Rank 1)\n    [ 12561] = {   4,   299,    0, 20,  0,  0, 0  }, -- Fire Protection (Rank 1)\n    [  7231] = {   4,   524,    0, 25,  0,  0, 0  }, -- Fire Protection (Rank 2)\n    [  7232] = {   4,   674,    0, 30,  0,  0, 0  }, -- Fire Protection (Rank 3)\n    [  7233] = {   4,   974,    0, 35,  0,  0, 0  }, -- Fire Protection (Rank 4)\n    [ 16894] = {   4,   974,    0, 35,  0,  0, 0  }, -- Fire Protection (Rank 4)\n    [  7234] = {   4,  1349,    0, 35,  0,  0, 0  }, -- Fire Protection (Rank 5)\n    [ 27533] = {   4,   299,    0, 60,  0,  0, 0  }, -- Fire Resistance\n    [  4057] = {   4,   499,    0,  0,  0, 25, 0  }, -- Fire Resistance\n    [ 17546] = {   8,  1949,    0, 40,  0,  0, 0  }, -- Nature Protection\n    [  7250] = {   8,   299,    0, 20,  0,  0, 0  }, -- Nature Protection (Rank 1)\n    [  7251] = {   8,   524,    0, 25,  0,  0, 0  }, -- Nature Protection (Rank 2)\n    [  7252] = {   8,   674,    0, 30,  0,  0, 0  }, -- Nature Protection (Rank 3)\n    [  7253] = {   8,   974,    0, 35,  0,  0, 0  }, -- Nature Protection (Rank 4)\n    [  7254] = {   8,  1349,    0, 40,  0,  0, 0  }, -- Nature Protection (Rank 5)\n    [ 16893] = {   8,  1349,    0, 40,  0,  0, 0  }, -- Nature Protection (Rank 5)\n    [ 27538] = {   8,   299,    0, 60,  0,  0, 0  }, -- Nature Resistance\n    [ 17544] = {  16,  1949,    0, 40,  0,  0, 0  }, -- Frost Protection\n    [  7240] = {  16,   299,    0, 20,  0,  0, 0  }, -- Frost Protection (Rank 1)\n    [  7236] = {  16,   524,    0, 25,  0,  0, 0  }, -- Frost Protection (Rank 2)\n    [  7238] = {  16,   674,    0, 30,  0,  0, 0  }, -- Frost Protection (Rank 3)\n    [  7237] = {  16,   974,    0, 35,  0,  0, 0  }, -- Frost Protection (Rank 4)\n    [  7239] = {  16,  1349,    0, 40,  0,  0, 0  }, -- Frost Protection (Rank 5)\n    [ 16895] = {  16,  1349,    0, 40,  0,  0, 0  }, -- Frost Protection (Rank 5)\n    [ 27534] = {  16,   299,    0, 60,  0,  0, 0  }, -- Frost Resistance\n    [  4077] = {  16,   599,    0,  0,  0, 25, 0  }, -- Frost Resistance\n    [ 17548] = {  32,  1949,    0, 40,  0,  0, 0  }, -- Shadow Protection\n    [  7235] = {  32,   299,    0, 20,  0,  0, 0  }, -- Shadow Protection (Rank 1)\n    [  7241] = {  32,   524,    0, 25,  0,  0, 0  }, -- Shadow Protection (Rank 2)\n    [  7242] = {  32,   674,    0, 30,  0,  0, 0  }, -- Shadow Protection (Rank 3)\n    [ 16891] = {  32,   674,    0, 30,  0,  0, 0  }, -- Shadow Protection (Rank 3)\n    [  7243] = {  32,   974,    0, 35,  0,  0, 0  }, -- Shadow Protection (Rank 4)\n    [  7244] = {  32,  1349,    0, 40,  0,  0, 0  }, -- Shadow Protection (Rank 5)\n    [ 27535] = {  32,   299,    0, 60,  0,  0, 0  }, -- Shadow Resistance\n    [  6229] = {  32,   289,    0, 32,  0, 32, 0  }, -- Shadow Ward (Rank 1)\n    [ 11739] = {  32,   469,    0, 42,  0, 42, 0  }, -- Shadow Ward (Rank 2)\n    [ 11740] = {  32,   674,    0, 52,  0, 52, 0  }, -- Shadow Ward (Rank 3)\n    [ 28610] = {  32,   919,    0, 60,  0, 60, 0  }, -- Shadow Ward (Rank 4)\n    [ 17549] = {  64,  1949,    0, 35,  0,  0, 0  }, -- Arcane Protection\n    [ 27540] = {  64,   299,    0, 60,  0,  0, 0  }, -- Arcane Resistance\n    [ 10618] = { 126,   599,    0, 30,  0,  0, 0  }, -- Elemental Protection\n    [ 20620] = { 127, 29999,    0, 20,  0, 20, 0  }, -- Aegis of Ragnaros\n    [ 23506] = { 127,   749,    0, 20,  0,  0, 0  }, -- Aura of Protection\n    [ 11445] = { 127,   277,    0, 35,  0, 35, 0  }, -- Bone Armor\n    [ 16431] = { 127,  1387,    0, 55,  0, 55, 0  }, -- Bone Armor\n    [ 27688] = { 127,  2499,    0,  0,  0,  0, 0  }, -- Bone Shield\n    [ 13234] = { 127,   499,    0,  0,  0,  0, 0  }, -- Harm Prevention Belt\n    [  9800] = { 127,   174,    0, 52,  0,  0, 0  }, -- Holy Shield\n    [ 17252] = { 127,   499,    0,  0,  0,  0, 0  }, -- Mark of the Dragon Lord\n    [ 11835] = { 127,   115,    0, 20,  0, 20, 0.1}, -- Power Word: Shield\n    [ 11974] = { 127,   136, 6.85, 20,  0, 20, 0.1}, -- Power Word: Shield\n    [ 22187] = { 127,   205, 10.2, 20,  0, 20, 0.1}, -- Power Word: Shield\n    [ 17139] = { 127,   273, 13.7, 20,  0, 20, 0.1}, -- Power Word: Shield\n    [ 11647] = { 127,   780,  3.9, 54, 59,  1, 0.1}, -- Power Word: Shield\n    [ 20697] = { 127,  4999,    0,  0,  0,  0, 0.1}, -- Power Word: Shield\n    [ 12040] = { 127,   199,   10, 20,  0, 20, 0  }, -- Shadow Shield\n    [ 22417] = { 127,   399,   20, 20,  0, 20, 0  }, -- Shadow Shield\n    [ 27759] = { 127,    49,    0,  0,  0,  0, 0  }, -- Shield Generator\n    [ 29506] = { 127,   899,    0, 20,  0,  0, 0  }, -- The Burrower's Shell\n    [ 10368] = { 127,   199,  2.3, 30, 35, 30, 0  }, -- Uther's Light Effect (Rank 1)\n    [ 28810] = { 127,   499,    0,  0,  0,  1, 0  }, -- [Priest] Armor of Faith\n    [ 27779] = { 127,   349,  2.3,  0,  0,  0, 0  }, -- [Priest] Divine Protection\n    [    17] = { 127,    43,  0.8,  6, 11,  6, 0.1}, -- [Priest] Power Word: Shield (Rank 1)\n    [ 10901] = { 127,   941,  4.3, 60, 65, 60, 0.1}, -- [Priest] Power Word: Shield (Rank 10)\n    [ 27607] = { 127,   941,  4.3, 60, 65, 60, 0.1}, -- [Priest] Power Word: Shield (Rank 10)\n    [   592] = { 127,    87,  1.2, 12, 17, 12, 0.1}, -- [Priest] Power Word: Shield (Rank 2)\n    [   600] = { 127,   157,  1.6, 18, 23, 18, 0.1}, -- [Priest] Power Word: Shield (Rank 3)\n    [  3747] = { 127,   233,    2, 24, 29, 24, 0.1}, -- [Priest] Power Word: Shield (Rank 4)\n    [  6065] = { 127,   300,  2.3, 30, 35, 30, 0.1}, -- [Priest] Power Word: Shield (Rank 5)\n    [  6066] = { 127,   380,  2.6, 36, 41, 36, 0.1}, -- [Priest] Power Word: Shield (Rank 6)\n    [ 10898] = { 127,   483,    3, 42, 47, 42, 0.1}, -- [Priest] Power Word: Shield (Rank 7)\n    [ 10899] = { 127,   604,  3.4, 48, 53, 48, 0.1}, -- [Priest] Power Word: Shield (Rank 8)\n    [ 10900] = { 127,   762,  3.9, 54, 59, 54, 0.1}, -- [Priest] Power Word: Shield (Rank 9)\n    [ 20706] = { 127,   499,    3, 42, 47, 42, 0  }, -- [Priest] Power Word: Shield 500 (Rank 7)\n    [ 17740] = {   1,   119,    6, 20,  0, 20, 0  }, -- [Mage] Mana Shield\n    [ 17741] = {   1,   119,    6, 20,  0, 20, 0  }, -- [Mage] Mana Shield\n    [  1463] = {   1,   119,    0, 20,  0, 20, 0  }, -- [Mage] Mana Shield (Rank 1)\n    [  8494] = {   1,   209,    0, 28,  0, 28, 0  }, -- [Mage] Mana Shield (Rank 2)\n    [  8495] = {   1,   299,    0, 36,  0, 36, 0  }, -- [Mage] Mana Shield (Rank 3)\n    [ 10191] = {   1,   389,    0, 44,  0, 44, 0  }, -- [Mage] Mana Shield (Rank 4)\n    [ 10192] = {   1,   479,    0, 52,  0, 52, 0  }, -- [Mage] Mana Shield (Rank 5)\n    [ 10193] = {   1,   569,    0, 60,  0, 60, 0  }, -- [Mage] Mana Shield (Rank 6)\n    [ 15041] = {   4,   119,    0, 20,  0, 20, 0  }, -- [Mage] Fire Ward\n    [   543] = {   4,   164,    0, 20,  0, 20, 0  }, -- [Mage] Fire Ward (Rank 1)\n    [  8457] = {   4,   289,    0, 30,  0, 30, 0  }, -- [Mage] Fire Ward (Rank 2)\n    [  8458] = {   4,   469,    0, 40,  0, 40, 0  }, -- [Mage] Fire Ward (Rank 3)\n    [ 10223] = {   4,   674,    0, 50,  0, 50, 0  }, -- [Mage] Fire Ward (Rank 4)\n    [ 10225] = {   4,   919,    0, 60,  0, 60, 0  }, -- [Mage] Fire Ward (Rank 5)\n    [ 15044] = {  16,   119,    0, 20,  0, 20, 0  }, -- [Mage] Frost Ward\n    [  6143] = {  16,   164,    0, 22,  0, 22, 0  }, -- [Mage] Frost Ward (Rank 1)\n    [  8461] = {  16,   289,    0, 32,  0, 32, 0  }, -- [Mage] Frost Ward (Rank 2)\n    [  8462] = {  16,   469,    0, 42,  0, 42, 0  }, -- [Mage] Frost Ward (Rank 3)\n    [ 10177] = {  16,   674,    0, 52,  0, 52, 0  }, -- [Mage] Frost Ward (Rank 4)\n    [ 28609] = {  16,   919,    0, 60,  0, 60, 0  }, -- [Mage] Frost Ward (Rank 5)\n    [ 11426] = { 127,   437,  2.8, 40, 46, 40, 0.1}, -- [Mage] Ice Barrier (Rank 1)\n    [ 13031] = { 127,   548,  3.2, 46, 52, 46, 0.1}, -- [Mage] Ice Barrier (Rank 2)\n    [ 13032] = { 127,   677,  3.6, 52, 58, 52, 0.1}, -- [Mage] Ice Barrier (Rank 3)\n    [ 13033] = { 127,   817,    4, 58, 64, 58, 0.1}, -- [Mage] Ice Barrier (Rank 4)\n    [ 26470] = { 127,     0,    0,  0,  0,  1, 0  }, -- [Mage] Persistent Shield\n    [ 17729] = { 126,   649,    0, 48,  0, 48, 0  }, -- [Warlock] Greater Spellstone\n    [ 17730] = { 126,   899,    0, 60,  0, 60, 0  }, -- [Warlock] Major Spellstone\n    [   128] = { 126,   399,    0, 36,  0, 36, 0  }, -- [Warlock] Spellstone\n    [  7812] = { 127,   304,  2.3, 16, 22, 16, 0  }, -- [Warlock] Sacrifice (Rank 1)\n    [ 19438] = { 127,   509,  3.1, 24, 30, 24, 0  }, -- [Warlock] Sacrifice (Rank 2)\n    [ 19440] = { 127,   769,  3.9, 32, 38, 32, 0  }, -- [Warlock] Sacrifice (Rank 3)\n    [ 19441] = { 127,  1094,  4.7, 40, 46, 40, 0  }, -- [Warlock] Sacrifice (Rank 4)\n    [ 19442] = { 127,  1469,  5.5, 48, 54, 48, 0  }, -- [Warlock] Sacrifice (Rank 5)\n    [ 19443] = { 127,  1904,  6.4, 56, 62, 56, 0  }, -- [Warlock] Sacrifice (Rank 6)\n}",
					["do_custom"] = true,
				},
				["finish"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "1",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
						["custom_hide"] = "custom",
						["type"] = "custom",
						["unit"] = "player",
						["custom_type"] = "status",
						["spellIds"] = {
						},
						["events"] = "COMBAT_LOG_EVENT_UNFILTERED DELAYED_PLAYER_ENTERING_WORLD",
						["event"] = "Conditions",
						["customStacks"] = "",
						["customDuration"] = "",
						["customName"] = "",
						["custom"] = "function(...)\n    aura_env:on_cleu(...)\nend\n\n\n",
						["names"] = {
						},
						["check"] = "event",
						["unevent"] = "auto",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 49,
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
			["font"] = "Arial Narrow",
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_class"] = false,
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
					["single"] = "MAGE",
					["multi"] = {
						["MAGE"] = true,
						["PRIEST"] = true,
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["fontSize"] = 18,
			["shadowXOffset"] = 1,
			["displayText_format_p_time_dynamic_threshold"] = 0,
			["regionType"] = "text",
			["wordWrap"] = "WordWrap",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["displayText_format_p_time_precision"] = 1,
			["yOffset"] = -10,
			["justify"] = "CENTER",
			["config"] = {
				["debugEnabled"] = false,
			},
			["semver"] = "1.0.0",
			["tocversion"] = 11305,
			["id"] = "nanShield:Value",
			["selfPoint"] = "BOTTOM",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["authorOptions"] = {
				{
					["type"] = "toggle",
					["name"] = "Enable Debug Info",
					["default"] = false,
					["useDesc"] = false,
					["key"] = "debugEnabled",
					["width"] = 2,
				}, -- [1]
			},
			["uid"] = "gURA36O1i4T",
			["automaticWidth"] = "Auto",
			["preferToUpdate"] = false,
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["parent"] = "Shield",
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
						["duration"] = "1",
						["percenthealth"] = "20",
						["event"] = "Health",
						["use_unit"] = true,
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["spellIds"] = {
						},
						["unit"] = "target",
						["subeventPrefix"] = "SPELL",
						["use_percenthealth"] = true,
						["percenthealth_operator"] = "<=",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "custom",
						["custom"] = "function()\n    local region = aura_env.region\n    local plate = C_NamePlate.GetNamePlateForUnit(\"target\")\n    \n    \n    if plate then\n        region:ClearAllPoints()\n        region:SetPoint(\"RIGHT\", plate, \"LEFT\", -20, 0)\n        return true\n    else\n        return false\n    end\nend",
						["custom_type"] = "status",
						["check"] = "update",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["wordWrap"] = "WordWrap",
			["font"] = "Friz Quadrata TT",
			["version"] = 2,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
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
				["use_combat"] = true,
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
			["fontSize"] = 24,
			["shadowXOffset"] = 1,
			["regionType"] = "text",
			["conditions"] = {
			},
			["parent"] = "TARGET HP PERCENT",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["easeType"] = "none",
					["easeStrength"] = 3,
					["preset"] = "alphaPulse",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["automaticWidth"] = "Auto",
			["selfPoint"] = "BOTTOM",
			["justify"] = "LEFT",
			["semver"] = "1.0.1",
			["tocversion"] = 11306,
			["id"] = "MobHPPercentRED",
			["uid"] = "L9pe9C7xoBj",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["xOffset"] = 0,
			["config"] = {
			},
			["shadowYOffset"] = -1,
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["preferToUpdate"] = false,
		},
		["Druid 2.0"] = {
			["controlledChildren"] = {
				"Druid - Shred", -- [1]
				"Druid - Tiger's Fury", -- [2]
				"Druid - Clearcasting", -- [3]
				"Druid - Moonfire", -- [4]
				"Druid - Rip", -- [5]
				"Druid - War Stomp", -- [6]
				"Druid - Shadowmeld", -- [7]
				"Druid - Faerie Fire", -- [8]
				"Druid - Barkskin", -- [9]
				"Druid - Nature's Grasp", -- [10]
				"Druid - Rebirth", -- [11]
				"Druid - Bash", -- [12]
				"Druid - Nature's Swiftness", -- [13]
				"Druid - Mana Bar ", -- [14]
				"Druid - 5Second+ManaRegenSmall", -- [15]
				"Druid - Mana Bar Cat/Bear", -- [16]
				"Druid - Rage Bar", -- [17]
				"Druid - Energy Regen", -- [18]
				"Druid - Energy Bar", -- [19]
				"Druid - CP1", -- [20]
				"Druid - CP2", -- [21]
				"Druid - CP3", -- [22]
				"Druid - CP4", -- [23]
				"Druid - CP5", -- [24]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -20,
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
			["internalVersion"] = 49,
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
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "DRUID",
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
			["scale"] = 0.8,
			["border"] = false,
			["borderEdge"] = "1 Pixel",
			["regionType"] = "group",
			["borderSize"] = 2,
			["borderOffset"] = 4,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Druid 2.0",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
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
			["borderInset"] = 1,
			["uid"] = "IUvIXiYBA4q",
			["config"] = {
			},
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
				["groupOffset"] = true,
			},
			["xOffset"] = 0,
		},
		["Warrior - Bloodthirst"] = {
			["iconSource"] = -1,
			["xOffset"] = 99,
			["preferToUpdate"] = false,
			["yOffset"] = -75,
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
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["auranames"] = {
							"Immolate", -- [1]
						},
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showAlways",
						["names"] = {
						},
						["unitExists"] = true,
						["duration"] = "1",
						["debuffType"] = "HARMFUL",
						["use_unit"] = true,
						["type"] = "spell",
						["matchesShowOn"] = "showAlways",
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "target",
						["use_remaining"] = false,
						["event"] = "Cooldown Progress (Spell)",
						["use_exact_spellName"] = false,
						["realSpellName"] = "Bloodthirst",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["useName"] = true,
						["unevent"] = "auto",
						["spellName"] = 23881,
						["use_track"] = true,
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 16,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 26,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 49,
			["load"] = {
				["use_class"] = true,
				["use_talent"] = true,
				["use_never"] = false,
				["talent"] = {
					["single"] = 37,
					["multi"] = {
						[13] = true,
					},
				},
				["zoneIds"] = "",
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
			["uid"] = "UPlfbn2TasR",
			["authorOptions"] = {
			},
			["url"] = "https://wago.io/z6xqQay0S/16",
			["regionType"] = "icon",
			["parent"] = "Warrior 2.0",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["zoom"] = 0.3,
			["width"] = 49,
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.15",
			["tocversion"] = 11302,
			["id"] = "Warrior - Bloodthirst",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = true,
			["config"] = {
			},
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["displayIcon"] = 135817,
			["cooldown"] = true,
			["icon"] = true,
		},
		["Warrior - Mortal Strike"] = {
			["iconSource"] = -1,
			["parent"] = "Warrior 2.0",
			["preferToUpdate"] = false,
			["yOffset"] = -75,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/z6xqQay0S/16",
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
						["track"] = "auto",
						["auranames"] = {
							"Immolate", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["names"] = {
						},
						["unitExists"] = true,
						["use_unit"] = true,
						["debuffType"] = "HARMFUL",
						["use_genericShowOn"] = true,
						["use_remaining"] = false,
						["unit"] = "target",
						["subeventSuffix"] = "_CAST_START",
						["spellName"] = 12294,
						["type"] = "spell",
						["event"] = "Cooldown Progress (Spell)",
						["use_exact_spellName"] = false,
						["realSpellName"] = "Mortal Strike",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["duration"] = "1",
						["unevent"] = "auto",
						["useName"] = true,
						["use_track"] = true,
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 16,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 26,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 49,
			["load"] = {
				["use_class"] = true,
				["use_talent"] = true,
				["use_never"] = false,
				["talent"] = {
					["single"] = 18,
					["multi"] = {
						[13] = true,
					},
				},
				["zoneIds"] = "",
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
			["uid"] = "bSg4avET(Jn",
			["cooldownEdge"] = false,
			["xOffset"] = 99,
			["regionType"] = "icon",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["authorOptions"] = {
			},
			["cooldownTextDisabled"] = true,
			["width"] = 49,
			["zoom"] = 0.3,
			["semver"] = "1.0.15",
			["tocversion"] = 11302,
			["id"] = "Warrior - Mortal Strike",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = true,
			["config"] = {
			},
			["inverse"] = false,
			["icon"] = true,
			["displayIcon"] = 135817,
			["cooldown"] = true,
			["selfPoint"] = "CENTER",
		},
		["Druid - Energy Regen"] = {
			["sparkWidth"] = 25,
			["sparkOffsetX"] = -1,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["spark"] = true,
			["yOffset"] = -298.04,
			["anchorPoint"] = "CENTER",
			["iconSource"] = -1,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["url"] = "https://wago.io/HCaWT5tJa/14",
			["icon"] = false,
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Health",
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["custom"] = "function(a, e, t)\n    local currEnergy = UnitPower(\"player\", 3)\n    local dur = 2\n    if (e == \"UNIT_POWER_FREQUENT\" and currEnergy > (aura_env.lastEnergy or 0))\n    or (e == \"ENERGYTICK\" and t and currEnergy == UnitPowerMax(\"player\", 3))\n    then\n        if not a[\"\"]  then\n            a[\"\"] = {\n                show = true,\n                changed = true,\n                duration = dur,\n                expirationTime = GetTime() + dur,\n                progressType = \"timed\"\n            }\n        else\n            local s = a[\"\"]\n            s.changed = true\n            s.duration = dur\n            s.expirationTime = GetTime() + dur\n            s.show = true\n            C_Timer.After(2, function() WeakAuras.ScanEvents(\"ENERGYTICK\", true) end)\n        end\n    end\n    aura_env.lastEnergy = currEnergy\n    return true\nend\n\n\n\n",
						["spellIds"] = {
						},
						["custom_type"] = "stateupdate",
						["check"] = "event",
						["unit"] = "player",
						["events"] = "UNIT_POWER_FREQUENT:player ENERGYTICK",
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
						["event"] = "Power",
						["subeventPrefix"] = "SPELL",
						["powertype"] = 3,
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_showCost"] = false,
						["use_unit"] = true,
						["use_powertype"] = true,
						["use_requirePowerType"] = true,
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["internalVersion"] = 49,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["selfPoint"] = "CENTER",
			["backdropInFront"] = false,
			["borderBackdrop"] = "Blizzard Tooltip",
			["barColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0, -- [4]
			},
			["desaturate"] = false,
			["xOffset"] = 0,
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
			["sparkOffsetY"] = 0,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subforeground",
				}, -- [2]
			},
			["height"] = 20,
			["config"] = {
			},
			["load"] = {
				["use_class"] = true,
				["zoneIds"] = "",
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["ROGUE"] = true,
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
			["sparkColor"] = {
				0.90196078431373, -- [1]
				1, -- [2]
				0.92156862745098, -- [3]
				1, -- [4]
			},
			["parent"] = "Druid 2.0",
			["anchorFrameType"] = "SCREEN",
			["alpha"] = 1,
			["version"] = 14,
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["borderInFront"] = true,
			["sparkHidden"] = "NEVER",
			["icon_side"] = "LEFT",
			["auto"] = true,
			["sparkHeight"] = 35,
			["texture"] = "Glamour2",
			["zoom"] = 0,
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Druid - Energy Regen",
			["stickyDuration"] = false,
			["frameStrata"] = 1,
			["width"] = 242.5,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0, -- [4]
			},
			["uid"] = "j6dtOjIV(2(",
			["inverse"] = false,
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["orientation"] = "HORIZONTAL_INVERSE",
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
						["trigger"] = -1,
						["variable"] = "incombat",
						["value"] = 0,
					},
					["changes"] = {
						{
							["value"] = 0.25,
							["property"] = "alpha",
						}, -- [1]
					},
				}, -- [2]
				{
					["check"] = {
						["trigger"] = -1,
						["variable"] = "hastarget",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = 1,
							["property"] = "alpha",
						}, -- [1]
					},
				}, -- [3]
				{
					["check"] = {
					},
					["changes"] = {
						{
						}, -- [1]
					},
				}, -- [4]
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["color"] = {
			},
		},
		["Priest - Mana Bar"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["xOffset"] = 0.0003662109375,
			["preferToUpdate"] = false,
			["yOffset"] = -298.03799438477,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["url"] = "https://wago.io/R8xGfpcxa/14",
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
			["fontFlags"] = "OUTLINE",
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["selfPoint"] = "CENTER",
			["barColor"] = {
				0.1843137254901961, -- [1]
				0.3764705882352941, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["sparkOffsetY"] = 0,
			["load"] = {
				["size"] = {
					["multi"] = {
					},
				},
				["use_petbattle"] = false,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["use_vehicle"] = false,
				["class"] = {
					["single"] = "PRIEST",
					["multi"] = {
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
				["use_class"] = true,
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
				["ingroup"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["texture"] = "Glamour2",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["spark"] = false,
			["tocversion"] = 11302,
			["alpha"] = 1,
			["uid"] = "algLApoUMIu",
			["borderBackdrop"] = "None",
			["parent"] = "Priest 2.0",
			["customText"] = "function()\n    if aura_env.region then\n        local mana = UnitPower(\"player\", Enum.PowerType.Mana)\n        aura_env.region.text3:SetText(mana)\n    end\nend\n\n\n\n\n\n\n\n\n\n\n\n",
			["customTextUpdate"] = "event",
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
						["unit"] = "player",
						["type"] = "unit",
						["use_health"] = true,
						["unevent"] = "auto",
						["genericShowOn"] = "showOnActive",
						["debuffType"] = "HELPFUL",
						["use_requirePowerType"] = false,
						["use_percentpower"] = false,
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Power",
						["health"] = "0",
						["spellIds"] = {
						},
						["duration"] = "1",
						["health_operator"] = ">=",
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
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
					["text_shadowXOffset"] = 1,
					["text_text"] = "%c ",
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
					["text_visible"] = false,
					["text_anchorPoint"] = "INNER_RIGHT",
					["text_fontSize"] = 15,
					["anchorXOffset"] = 0,
					["text_fontType"] = "None",
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
					["text_font"] = "Expressway",
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
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "ICON_CENTER",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_fontType"] = "None",
				}, -- [5]
				{
					["type"] = "subborder",
					["border_anchor"] = "bar",
					["border_offset"] = 1,
					["border_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						0.6092168390750885, -- [4]
					},
					["border_visible"] = true,
					["border_edge"] = "1 Pixel",
					["border_size"] = 1,
				}, -- [6]
			},
			["height"] = 20,
			["sparkBlendMode"] = "ADD",
			["backdropColor"] = {
				0, -- [1]
				0, -- [2]
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
			["sparkOffsetX"] = 0,
			["authorOptions"] = {
			},
			["borderInFront"] = true,
			["sparkRotationMode"] = "AUTO",
			["icon_side"] = "RIGHT",
			["backgroundColor"] = {
				0.32549019607843, -- [1]
				0.53725490196078, -- [2]
				1, -- [3]
				0.16197288036346, -- [4]
			},
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["sparkHeight"] = 30,
			["icon"] = false,
			["overlaysTexture"] = {
				"Glamour2", -- [1]
			},
			["useAdjustededMax"] = false,
			["semver"] = "1.0.13",
			["width"] = 245,
			["id"] = "Priest - Mana Bar",
			["config"] = {
			},
			["frameStrata"] = 3,
			["anchorFrameType"] = "SCREEN",
			["sparkHidden"] = "NEVER",
			["auto"] = true,
			["inverse"] = false,
			["sparkDesature"] = false,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["zoom"] = 0,
		},
		["Warrior  - Berserker"] = {
			["iconSource"] = -1,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -155.78,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/z6xqQay0S/16",
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
						["track"] = "auto",
						["auranames"] = {
							"Rend", -- [1]
						},
						["ownOnly"] = true,
						["genericShowOn"] = "showAlways",
						["unit"] = "target",
						["unitExists"] = true,
						["debuffType"] = "HARMFUL",
						["use_genericShowOn"] = true,
						["useName"] = true,
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["use_unit"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Berserking",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["matchesShowOn"] = "showAlways",
						["type"] = "spell",
						["spellName"] = 20554,
						["use_track"] = true,
						["names"] = {
						},
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 16,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_race"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
						["ROGUE"] = true,
					},
				},
				["use_class"] = true,
				["race"] = {
					["single"] = "Troll",
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "5jREPXKBwPS",
			["icon"] = true,
			["cooldownEdge"] = false,
			["regionType"] = "icon",
			["selfPoint"] = "CENTER",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["parent"] = "Warrior 2.0",
			["cooldownTextDisabled"] = true,
			["width"] = 35,
			["zoom"] = 0.3,
			["semver"] = "1.0.15",
			["tocversion"] = 11302,
			["id"] = "Warrior  - Berserker",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = true,
			["config"] = {
			},
			["inverse"] = false,
			["xOffset"] = 106,
			["displayIcon"] = 132289,
			["cooldown"] = true,
			["authorOptions"] = {
			},
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
			["useTooltip"] = true,
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_fontType"] = "OUTLINE",
					["text_shadowYOffset"] = 0,
					["anchorXOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
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
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_visible"] = true,
					["text_shadowYOffset"] = 0,
					["anchorXOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
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
			["uid"] = "DMEkSzl4NuN",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["selfPoint"] = "CENTER",
			["regionType"] = "icon",
			["xOffset"] = 0,
			["cooldown"] = true,
			["internalVersion"] = 49,
			["cooldownEdge"] = false,
			["zoom"] = 0.3,
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.0",
			["tocversion"] = 90001,
			["id"] = "targetdebuffs  2",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["width"] = 36,
			["auto"] = true,
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
				["ignoreOptionsEventErrors"] = true,
			},
			["parent"] = "DEBUFFS - PET",
		},
		["Warrior - Overpower"] = {
			["iconSource"] = 0,
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = -75,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/z6xqQay0S/16",
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
						["track"] = "auto",
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["use_unit"] = true,
						["names"] = {
						},
						["debuffType"] = "HELPFUL",
						["use_genericShowOn"] = true,
						["type"] = "spell",
						["subeventPrefix"] = "SPELL",
						["unevent"] = "auto",
						["matchesShowOn"] = "showAlways",
						["spellName"] = 7384,
						["event"] = "Cooldown Progress (Spell)",
						["use_exact_spellName"] = true,
						["realSpellName"] = 7384,
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["useExactSpellId"] = true,
						["auraspellids"] = {
							"7384", -- [1]
						},
						["subeventSuffix"] = "_CAST_START",
						["use_track"] = true,
						["unit"] = "player",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = true,
			["version"] = 16,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0.2,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["glowType"] = "Pixel",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["useGlowColor"] = false,
					["glow"] = false,
					["glowScale"] = 1,
					["glowThickness"] = 1,
					["glowLines"] = 12,
					["glowBorder"] = false,
				}, -- [2]
			},
			["height"] = 49,
			["load"] = {
				["use_class"] = true,
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
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "sszQePISw6T",
			["icon"] = true,
			["cooldownEdge"] = false,
			["regionType"] = "icon",
			["parent"] = "Warrior 2.0",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
							["property"] = "sub.2.glow",
						}, -- [1]
					},
				}, -- [1]
			},
			["selfPoint"] = "CENTER",
			["zoom"] = 0.3,
			["width"] = 49,
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.15",
			["tocversion"] = 11302,
			["id"] = "Warrior - Overpower",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayIcon"] = 132223,
			["cooldown"] = true,
			["authorOptions"] = {
			},
		},
		["Priest - 5Second+ManaRegen"] = {
			["sparkWidth"] = 25,
			["borderBackdrop"] = "Blizzard Tooltip",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["spark"] = true,
			["yOffset"] = -298.04,
			["anchorPoint"] = "CENTER",
			["iconSource"] = -1,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["url"] = "https://wago.io/R8xGfpcxa/14",
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
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "2",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "custom",
						["names"] = {
						},
						["subeventSuffix"] = "_ENERGIZE",
						["unevent"] = "auto",
						["subeventPrefix"] = "SPELL",
						["event"] = "Health",
						["use_unit"] = true,
						["events"] = "UNIT_SPELLCAST_SUCCEEDED:player UNIT_POWER_FREQUENT:player",
						["custom"] = "function(a, e, t)\n    local currentMana = UnitPower(\"player\" , 0)\n    \n    if currentMana >= UnitPowerMax(\"player\", 0) then\n        return false\n    end\n    \n    if e == \"UNIT_POWER_FREQUENT\" and currentMana > aura_env.lastMana then\n        local duration = 2\n        a[\"\"] = {\n            show = true,\n            changed = true,\n            duration = duration,\n            expirationTime = GetTime() + duration,\n            progressType = \"timed\",\n            autoHide = true\n        }\n        aura_env.lastMana = currentMana\n        \n    elseif e == \"UNIT_SPELLCAST_SUCCEEDED\" and currentMana < aura_env.lastMana then\n        local duration = 6.45 -- why?\n        --local duration = 5\n        a[\"\"] = {\n            show = true,\n            changed = true,\n            duration = duration,\n            expirationTime = GetTime() + duration,\n            progressType = \"timed\",\n            autoHide = true\n        }\n        aura_env.lastMana = currentMana\n    end\n    \n    --aura_env.lastMana = currentMana\n    return true\nend",
						["spellIds"] = {
						},
						["use_sourceUnit"] = true,
						["check"] = "event",
						["custom_type"] = "stateupdate",
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
			["internalVersion"] = 49,
			["color"] = {
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
			["backdropInFront"] = false,
			["sparkOffsetX"] = 0,
			["barColor"] = {
				0, -- [1]
				0.23529411764706, -- [2]
				1, -- [3]
				0, -- [4]
			},
			["stickyDuration"] = false,
			["icon"] = false,
			["parent"] = "Priest 2.0",
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
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_shadowYOffset"] = -1,
					["text_anchorYOffset"] = -10,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "SPARK",
					["text_visible"] = false,
					["text_text_format_p_format"] = "timed",
					["text_fontSize"] = 20,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_precision"] = 1,
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
			["height"] = 20,
			["config"] = {
			},
			["load"] = {
				["use_class"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class"] = {
					["single"] = "PRIEST",
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
			["useAdjustededMax"] = false,
			["uid"] = "sK9p9XTo02X",
			["desaturate"] = false,
			["width"] = 245,
			["frameStrata"] = 4,
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["borderInFront"] = true,
			["id"] = "Priest - 5Second+ManaRegen",
			["icon_side"] = "RIGHT",
			["auto"] = true,
			["sparkHeight"] = 35,
			["texture"] = "Glamour2",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["zoom"] = 0,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["sparkHidden"] = "FULL",
			["version"] = 14,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["backgroundColor"] = {
				0, -- [1]
				0.22352941176471, -- [2]
				1, -- [3]
				0, -- [4]
			},
			["sparkColor"] = {
				0.97254901960784, -- [1]
				0.96078431372549, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "<",
						["variable"] = "duration",
						["value"] = "5",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "inverse",
						}, -- [1]
					},
				}, -- [1]
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["xOffset"] = 0,
		},
		["Warrior - War Stomp"] = {
			["iconSource"] = -1,
			["parent"] = "Warrior 2.0",
			["preferToUpdate"] = false,
			["yOffset"] = -155.78,
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
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Rend", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["use_unit"] = true,
						["unitExists"] = true,
						["debuffType"] = "HARMFUL",
						["unit"] = "target",
						["useName"] = true,
						["matchesShowOn"] = "showAlways",
						["subeventSuffix"] = "_CAST_START",
						["ownOnly"] = true,
						["type"] = "spell",
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "War Stomp",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["spellName"] = 19482,
						["use_genericShowOn"] = true,
						["use_track"] = true,
						["names"] = {
						},
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 16,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_race"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
						["ROGUE"] = true,
					},
				},
				["use_class"] = true,
				["race"] = {
					["single"] = "Tauren",
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "8Nwayz)AIhj",
			["url"] = "https://wago.io/z6xqQay0S/16",
			["xOffset"] = 106,
			["regionType"] = "icon",
			["selfPoint"] = "CENTER",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["icon"] = true,
			["cooldownTextDisabled"] = true,
			["width"] = 35,
			["zoom"] = 0.3,
			["auto"] = true,
			["tocversion"] = 11302,
			["id"] = "Warrior - War Stomp",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["semver"] = "1.0.15",
			["config"] = {
			},
			["inverse"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayIcon"] = 136187,
			["cooldown"] = true,
			["authorOptions"] = {
			},
		},
		["Main Hand"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["auto"] = true,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["xOffset"] = 0,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["url"] = "https://wago.io/fpdm12tUX/1",
			["icon"] = false,
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "unit",
						["unevent"] = "auto",
						["subeventPrefix"] = "SPELL",
						["use_inverse"] = false,
						["event"] = "Swing Timer",
						["use_unit"] = true,
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["spellIds"] = {
						},
						["use_hand"] = true,
						["unit"] = "player",
						["names"] = {
						},
						["hand"] = "main",
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
			["internalVersion"] = 49,
			["borderBackdrop"] = "Blizzard Tooltip",
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
			["customTextUpdate"] = "update",
			["barColor"] = {
				0.6470588235294118, -- [1]
				1, -- [2]
				0.1450980392156863, -- [3]
				1, -- [4]
			},
			["stickyDuration"] = false,
			["selfPoint"] = "CENTER",
			["version"] = 1,
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
					["text_text_format_p_format"] = "timed",
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
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = -1,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "INNER_RIGHT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_visible"] = false,
					["text_fontSize"] = 8,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [3]
				{
					["text_shadowXOffset"] = 0,
					["text_text"] = "Main Hand",
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
					["text_fontType"] = "None",
					["text_anchorPoint"] = "INNER_LEFT",
					["text_fontSize"] = 8,
					["anchorXOffset"] = 0,
					["text_visible"] = false,
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
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "ICON_CENTER",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_visible"] = false,
				}, -- [5]
				{
					["type"] = "subborder",
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
					["border_offset"] = 5,
				}, -- [6]
			},
			["height"] = 6,
			["config"] = {
			},
			["load"] = {
				["zoneIds"] = "",
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
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
			["sparkBlendMode"] = "ADD",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["uid"] = "bv7d0Eti5pa",
			["semver"] = "1.0.0",
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 1,
			["useAdjustededMax"] = false,
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["borderInFront"] = true,
			["sparkHidden"] = "NEVER",
			["icon_side"] = "RIGHT",
			["parent"] = "Swing Timers",
			["sparkHeight"] = 30,
			["texture"] = "Glamour2",
			["zoom"] = 0,
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["spark"] = false,
			["tocversion"] = 11302,
			["id"] = "Main Hand",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["alpha"] = 1,
			["width"] = 200,
			["desaturate"] = false,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
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
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["sparkOffsetX"] = 0,
		},
		["Warlock - Immolate"] = {
			["iconSource"] = 0,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -262,
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
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura2",
						["subeventSuffix"] = "_CAST_START",
						["matchesShowOn"] = "showAlways",
						["event"] = "Health",
						["names"] = {
						},
						["unitExists"] = true,
						["subeventPrefix"] = "SPELL",
						["spellIds"] = {
						},
						["useName"] = true,
						["auranames"] = {
							"Immolate", -- [1]
						},
						["ownOnly"] = true,
						["unit"] = "target",
						["debuffType"] = "HARMFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 12,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 26,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
				{
					["glowFrequency"] = 0.25,
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
					["useGlowColor"] = false,
					["glow"] = false,
					["glowScale"] = 1,
					["glowThickness"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 49,
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
					["single"] = "WARLOCK",
					["multi"] = {
						["WARLOCK"] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "IAzKObGM4EC",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["selfPoint"] = "CENTER",
			["regionType"] = "icon",
			["icon"] = true,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = -2,
						["variable"] = "AND",
						["checks"] = {
							{
								["trigger"] = -1,
								["variable"] = "incombat",
								["value"] = 1,
							}, -- [1]
							{
								["trigger"] = 1,
								["variable"] = "buffed",
								["value"] = 1,
							}, -- [2]
							{
								["trigger"] = 1,
								["op"] = "<=",
								["value"] = "2",
								["variable"] = "expirationTime",
							}, -- [3]
						},
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "sub.3.glow",
						}, -- [1]
					},
				}, -- [1]
			},
			["xOffset"] = -98,
			["cooldownTextDisabled"] = true,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["auto"] = false,
			["tocversion"] = 11302,
			["id"] = "Warlock - Immolate",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["width"] = 49,
			["semver"] = "1.0.11",
			["config"] = {
			},
			["inverse"] = false,
			["url"] = "https://wago.io/Y8douZITb/12",
			["displayIcon"] = 135817,
			["cooldown"] = true,
			["parent"] = "Warlock 2.0",
		},
		["Display Layer"] = {
			["outline"] = "OUTLINE",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayText"] = "%c",
			["customText"] = "function()\n    return aura_env.text\nend",
			["yOffset"] = 12,
			["anchorPoint"] = "BOTTOMLEFT",
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/bZy7c9fQw/4",
			["actions"] = {
				["start"] = {
					["glow_frame_type"] = "FRAMESELECTOR",
					["b"] = 0,
					["message_type"] = "PRINT",
					["do_message"] = false,
					["message"] = "Click on an NPC to show your current layer number.",
					["glow_action"] = "show",
					["sound"] = "Interface\\AddOns\\ElvUI\\Media\\Sounds\\Whisper.ogg",
					["do_sound"] = false,
					["r"] = 1,
					["do_glow"] = false,
					["do_custom"] = false,
					["g"] = 0.28235294117647,
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "aura_env.text = \"|cffff4800L0|r\"",
					["do_custom"] = true,
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["custom_type"] = "event",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["custom_hide"] = "custom",
						["events"] = "PLAYER_TARGET_CHANGED",
						["custom"] = "function()\n    \n    local uguid = UnitGUID(\"target\")\n    if uguid then\n        local sguid = {strsplit(\"-\",uguid)}\n        if sguid[1] == \"Creature\" then\n            local layerid = tonumber(sguid[5])\n            --- Orgrimmar ---\n            if layerid > 100 then\n                aura_env.text = \"L2\"\n            else\n                aura_env.text = \"L1\"\n            end\n        end\n    end\n    \n    return true\nend",
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["spellIds"] = {
						},
						["names"] = {
						},
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
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["unevent"] = "auto",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["wordWrap"] = "WordWrap",
			["font"] = "Arial Narrow",
			["version"] = 4,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_size"] = true,
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
					["single"] = "none",
					["multi"] = {
					},
				},
			},
			["fontSize"] = 14,
			["shadowXOffset"] = 1,
			["anchorFrameFrame"] = "Minimap",
			["regionType"] = "text",
			["selfPoint"] = "CENTER",
			["_table"] = "d",
			["preferToUpdate"] = false,
			["conditions"] = {
			},
			["authorOptions"] = {
			},
			["justify"] = "CENTER",
			["semver"] = "1.0.3",
			["tocversion"] = 11304,
			["id"] = "Display Layer",
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
			["anchorFrameType"] = "SELECTFRAME",
			["uid"] = "Sa)Gm93udM4",
			["config"] = {
			},
			["shadowYOffset"] = -1,
			["xOffset"] = 16,
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["automaticWidth"] = "Auto",
		},
		["nanShield:Segment"] = {
			["authorOptions"] = {
				{
					["type"] = "range",
					["useDesc"] = false,
					["max"] = 360,
					["step"] = 1,
					["width"] = 1,
					["min"] = 1,
					["key"] = "curveAngle",
					["name"] = "Curve",
					["default"] = 15,
				}, -- [1]
				{
					["type"] = "range",
					["useDesc"] = false,
					["max"] = 180,
					["step"] = 1,
					["width"] = 1,
					["min"] = -180,
					["name"] = "Rotation",
					["key"] = "rotationOffset",
					["default"] = 0,
				}, -- [2]
				{
					["type"] = "range",
					["useDesc"] = false,
					["max"] = 100,
					["step"] = 1,
					["width"] = 1,
					["min"] = 3,
					["key"] = "segmentCount",
					["name"] = "Segments",
					["default"] = 20,
				}, -- [3]
				{
					["type"] = "select",
					["values"] = {
						"Counter Clockwise", -- [1]
						"Clockwise", -- [2]
					},
					["default"] = 1,
					["key"] = "direction",
					["useDesc"] = false,
					["name"] = "Direction",
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
					["name"] = "Enable Debug Info",
					["default"] = false,
					["useDesc"] = false,
					["key"] = "debugEnabled",
					["width"] = 1,
				}, -- [6]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["url"] = "https://wago.io/TPKPLjUo4/1",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["custom"] = "function aura_env:rotate()\n    local segments = self.config.segmentCount\n    local angle = self.config.curveAngle\n    local direction = -(self.config.direction - 1.5) * 2\n    local base = (self.config.rotationOffset + self.config.direction * 180)\n    self.region:Rotate(base + direction * (angle / (segments - 1)) * (self.cloneId - (segments + 1) / 2))\nend\nfunction aura_env:on_tsu(allstates, ...)\n    -- self:log('TSU', self.config.segmentCount)\n    local now = GetTime()\n    local timestamp = self.timestamp or 0\n    local active = self.active or 0\n    local changed\n\n    for i = #allstates + 1, self.config.segmentCount do\n        allstates[i] = {\n            changed = true,\n            show = false,\n            school = \"All\"\n        }\n    end\n\n    if now - timestamp > 0.25 / self.config.segmentCount then\n        self.timestamp = now\n        if active < #allstates and allstates[active + 1].show then\n            for i = #allstates, active + 1, -1 do\n                if allstates[i].show then\n                    allstates[i].show = false\n                    allstates[i].changed = true\n                    changed = true\n                    break\n                end\n            end\n        else\n            for i = 1, active do\n                if not allstates[i].show then\n                    allstates[i].show = true\n                    allstates[i].changed = true\n                    changed = true\n                    break\n                end\n            end\n        end\n        for i = 1, active do\n            if allstates[i].show then\n                if allstates[i].school ~= self.segmentSchool[i] then\n                    self:log('TSUSchool', i, allstates[i].school, self.segmentSchool[i])\n                    allstates[i].school = self.segmentSchool[i]\n                    allstates[i].changed = true\n                    changed = true\n                end\n            end\n        end\n    end\n    return changed\nend\naura_env.segmentSchool = {}\n\nfunction aura_env:on_nan_shield(event, totalAbsorb, ...)\n    self:log(event, totalAbsorb, ...)\n    local currentAbsorb = 0\n    local value\n    local prevSegment = 0\n    local segment\n    self.active = 0\n\n    if event == 'OPTIONS' then\n        self.active = self.config.segmentCount or 10\n        self:log(event, self.active)\n    else\n        for i = 1, select(\"#\", ...) do\n            value = select(i, ...)\n            currentAbsorb = currentAbsorb + value\n            segment = ceil(currentAbsorb / totalAbsorb * self.config.segmentCount)\n            if value > 0 then\n                for s = prevSegment + 1, segment do\n                    self.segmentSchool[s] = self.schools[i]\n                end\n                prevSegment = segment\n            end\n        end\n\n        if currentAbsorb > 0 and totalAbsorb > 0 then\n            self.active = ceil(currentAbsorb / totalAbsorb * self.config.segmentCount)\n        end\n    end\nend\naura_env.logPalette = {\n    \"ff6e7dda\",\n    \"ff21dfb9\",\n    \"ffe3f57a\",\n    \"ffed705a\",\n    \"fff8a3e6\",\n}\n\nfunction aura_env:log(...)\n    if self.config and self.config.debugEnabled then\n        local palette = self.logPalette\n        local args = {\n            self.cloneId and\n            format(\"[%s:%s]\", self.id, self.cloneId) or\n            format(\"[%s]\", self.id),\n            ...\n        }\n        for i = 1, #args do\n            args[i] = format(\n                \"|c%s%s|r\",\n                palette[1 + (i - 1) % #palette],\n                tostring(args[i]))\n        end\n        print(unpack(args))\n    end\nend\nfunction aura_env:LowestAbsorb(totalAbsorb, all, physical, magic, ...)\n    self:log('LowestAbsorb', all, physical, magic, ...)\n    local minValue\n    local minIdx\n    local value\n\n    for i = 1, select('#', ...) do\n        value = select(i, ...)\n        if value > 0 and value <= (minValue or value) then\n            minIdx = i + 3\n            minValue = value\n        end\n    end\n\n    if minIdx then\n        minValue = minValue + magic\n    elseif magic > 0 then\n        minValue = magic\n        minIdx = 3\n    end\n\n    if physical > 0 and physical <= (minValue or physical) then\n        minValue = physical\n        minIdx = 2\n    end\n\n    if minIdx then\n        minValue = minValue + all\n    else\n        minValue = all\n        minIdx = 1\n    end\n\n    self:log('LowestAbsorbResult', minValue, totalAbsorb, minIdx)\n    return minValue, totalAbsorb, minIdx\nend\naura_env.schools = {\n    \"All\",\n    \"Physical\",\n    \"Magic\",\n    \"Holy\",\n    \"Fire\",\n    \"Nature\",\n    \"Frost\",\n    \"Shadow\",\n    \"Arcane\",\n}\naura_env.schoolIds = { 127, 1, 126, 2, 4, 8, 16, 32, 64 }\naura_env.schoolIdx = {}\nfor idx, id in ipairs(aura_env.schoolIds) do\n    aura_env.schoolIdx[id] = idx\nend\n",
					["do_custom"] = true,
				},
				["finish"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["subeventSuffix"] = "_CAST_START",
						["debuffType"] = "HELPFUL",
						["event"] = "Health",
						["unit"] = "player",
						["names"] = {
						},
						["events"] = "PLAYER_ENTERING_WORLD WA_NAN_SHIELD",
						["custom"] = "function(...)\n    return aura_env:on_tsu(...)\nend",
						["subeventPrefix"] = "SPELL",
						["check"] = "update",
						["spellIds"] = {
						},
						["custom_type"] = "stateupdate",
						["customVariables"] = "{\n    school = {\n        type = \"select\",\n        display = \"Damage Type\",\n        values = {\n            [\"All\"] = \"All\",\n            [\"Physical\"] = \"Physical\",\n            [\"Magic\"] = \"Magic\",\n            [\"Holy\"] = \"Holy\",\n            [\"Fire\"] = \"Fire\",\n            [\"Nature\"] = \"Nature\",\n            [\"Frost\"] = \"Frost\",\n            [\"Shadow\"] = \"Shadow\",\n            [\"Arcane\"] = \"Arcane\"\n        }\n    }\n}",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["subeventPrefix"] = "SPELL",
						["type"] = "custom",
						["events"] = "WA_NAN_SHIELD",
						["custom_type"] = "event",
						["subeventSuffix"] = "_CAST_START",
						["custom"] = "function(...)\n    return aura_env:on_nan_shield(...)\nend",
						["event"] = "Health",
						["custom_hide"] = "custom",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 49,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["rotation"] = 180,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 25,
			["rotate"] = true,
			["load"] = {
				["use_class"] = false,
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
					["single"] = "MAGE",
					["multi"] = {
						["MAGE"] = true,
						["PRIEST"] = true,
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["textureWrapMode"] = "CLAMP",
			["mirror"] = false,
			["regionType"] = "texture",
			["blendMode"] = "BLEND",
			["anchorFrameType"] = "SCREEN",
			["texture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\target_indicator.tga",
			["discrete_rotation"] = 0,
			["parent"] = "Shield",
			["semver"] = "1.0.0",
			["tocversion"] = 11305,
			["id"] = "nanShield:Segment",
			["xOffset"] = 0,
			["frameStrata"] = 1,
			["width"] = 50,
			["config"] = {
				["direction"] = 1,
				["segmentCount"] = 20,
				["rotationOffset"] = 0,
				["curveAngle"] = 15,
				["debugEnabled"] = false,
			},
			["uid"] = "VWzp20EQnk3",
			["alpha"] = 0.48,
			["color"] = {
				0.1921568627451, -- [1]
				0.85882352941176, -- [2]
				1, -- [3]
				0.4200000166893, -- [4]
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "show",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = {
								["custom"] = "aura_env:rotate()",
							},
							["property"] = "customcode",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "All",
						["variable"] = "school",
					},
					["changes"] = {
						{
							["value"] = {
								0.32941176470588, -- [1]
								0.83137254901961, -- [2]
								1, -- [3]
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
						["value"] = "Magic",
						["variable"] = "school",
					},
					["changes"] = {
						{
							["value"] = {
								0, -- [1]
								0.50196078431373, -- [2]
								1, -- [3]
								0.80000001192093, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [3]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "Physical",
						["variable"] = "school",
					},
					["changes"] = {
						{
							["value"] = {
								0.9921568627451, -- [1]
								0.7921568627451, -- [2]
								0.63529411764706, -- [3]
								0.80000001192093, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [4]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "Arcane",
						["variable"] = "school",
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								0.61176470588235, -- [2]
								1, -- [3]
								0.80000001192093, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [5]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "Fire",
						["variable"] = "school",
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								0.50196078431373, -- [2]
								0, -- [3]
								0.80000001192093, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [6]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "Frost",
						["variable"] = "school",
					},
					["changes"] = {
						{
							["value"] = {
								0, -- [1]
								1, -- [2]
								1, -- [3]
								0.80000001192093, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [7]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "Holy",
						["variable"] = "school",
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								1, -- [2]
								0, -- [3]
								0.80000001192093, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [8]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "Nature",
						["variable"] = "school",
					},
					["changes"] = {
						{
							["value"] = {
								0.50196078431373, -- [1]
								1, -- [2]
								0, -- [3]
								0.80000001192093, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [9]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "Shadow",
						["variable"] = "school",
					},
					["changes"] = {
						{
							["value"] = {
								0.72941176470588, -- [1]
								0.45882352941177, -- [2]
								1, -- [3]
								0.80000001192093, -- [4]
							},
							["property"] = "color",
						}, -- [1]
					},
				}, -- [10]
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["animation"] = {
				["start"] = {
					["scaleFunc"] = "    function(progress, startX, startY, scaleX, scaleY)\n      return startX + (progress * (scaleX - startX)), startY + (progress * (scaleY - startY))\n    end\n  ",
					["duration"] = "0.2",
					["alphaType"] = "straight",
					["colorB"] = 1,
					["colorG"] = 1,
					["alphaFunc"] = "    function(progress, start, delta)\n      return start + (progress * delta)\n    end\n  ",
					["use_alpha"] = true,
					["scaleType"] = "straightScale",
					["colorA"] = 1,
					["easeType"] = "none",
					["scalex"] = 2,
					["scaley"] = 1,
					["alpha"] = 0,
					["easeStrength"] = 3,
					["y"] = 0,
					["x"] = 0,
					["preset"] = "fade",
					["colorR"] = 1,
					["type"] = "none",
					["rotate"] = 0,
					["duration_type"] = "seconds",
					["use_scale"] = true,
				},
				["main"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["finish"] = {
					["colorR"] = 1,
					["scalex"] = 1.5,
					["alphaType"] = "straight",
					["colorB"] = 1,
					["colorG"] = 1,
					["alphaFunc"] = "function(progress, start, delta)\n    return start + (progress * delta)\nend\n",
					["use_translate"] = true,
					["use_alpha"] = true,
					["colorA"] = 1,
					["type"] = "custom",
					["duration"] = "0.2",
					["easeType"] = "none",
					["translateFunc"] = "function(progress, startX, startY, deltaX, deltaY)\n    return startX + (progress * deltaX), startY + (progress * deltaY)\nend\n",
					["scaley"] = 1.5,
					["alpha"] = 0,
					["easeStrength"] = 3,
					["y"] = 20,
					["x"] = 5,
					["scaleFunc"] = "function(progress, startX, startY, scaleX, scaleY)\n    return startX + (progress * (scaleX - startX)), startY + (progress * (scaleY - startY))\nend\n",
					["scaleType"] = "straightScale",
					["translateType"] = "straightTranslate",
					["rotate"] = 0,
					["duration_type"] = "seconds",
					["use_scale"] = true,
				},
			},
		},
		["Priest - Holy Fire"] = {
			["iconSource"] = 0,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -262,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/R8xGfpcxa/14",
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
						["track"] = "auto",
						["auranames"] = {
							"14914", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["unit"] = "target",
						["unitExists"] = true,
						["debuffType"] = "HARMFUL",
						["useName"] = true,
						["subeventPrefix"] = "SPELL",
						["unevent"] = "auto",
						["use_genericShowOn"] = true,
						["spellName"] = 20572,
						["event"] = "Cooldown Progress (Spell)",
						["matchesShowOn"] = "showAlways",
						["realSpellName"] = "Blood Fury",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["type"] = "aura2",
						["names"] = {
						},
						["use_track"] = true,
						["use_unit"] = true,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
						["track"] = "auto",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 26,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 49,
			["load"] = {
				["use_class"] = true,
				["race"] = {
					["single"] = "Scourge",
					["multi"] = {
						["Scourge"] = true,
					},
				},
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
			["uid"] = "ueRN)tUmMAl",
			["selfPoint"] = "CENTER",
			["icon"] = true,
			["regionType"] = "icon",
			["parent"] = "Priest 2.0",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
							["property"] = "desaturate",
						}, -- [1]
						{
						}, -- [2]
					},
				}, -- [1]
			},
			["xOffset"] = 50,
			["zoom"] = 0.3,
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = true,
			["auto"] = false,
			["tocversion"] = 11302,
			["id"] = "Priest - Holy Fire",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 49,
			["semver"] = "1.0.13",
			["config"] = {
			},
			["inverse"] = false,
			["cooldownEdge"] = false,
			["displayIcon"] = 135972,
			["cooldown"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Druid - Nature's Swiftness"] = {
			["iconSource"] = 0,
			["parent"] = "Druid 2.0",
			["preferToUpdate"] = false,
			["yOffset"] = -327,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/HCaWT5tJa/14",
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
							"Rend", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["names"] = {
						},
						["unitExists"] = true,
						["debuffType"] = "HARMFUL",
						["unit"] = "target",
						["useName"] = true,
						["use_genericShowOn"] = true,
						["subeventSuffix"] = "_CAST_START",
						["ownOnly"] = true,
						["duration"] = "1",
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Nature's Swiftness",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["type"] = "spell",
						["use_unit"] = true,
						["spellName"] = 17116,
						["use_track"] = true,
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 35,
			["load"] = {
				["use_class"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["HUNTER"] = true,
						["ROGUE"] = true,
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
			["uid"] = "L7DtM9p)HKp",
			["icon"] = true,
			["cooldownEdge"] = false,
			["regionType"] = "icon",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["selfPoint"] = "CENTER",
			["cooldownTextDisabled"] = true,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["auto"] = false,
			["tocversion"] = 11302,
			["id"] = "Druid - Nature's Swiftness",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 35,
			["semver"] = "1.0.13",
			["config"] = {
			},
			["inverse"] = false,
			["authorOptions"] = {
			},
			["displayIcon"] = 136076,
			["cooldown"] = true,
			["xOffset"] = 0,
		},
		["Warlock 2.0"] = {
			["controlledChildren"] = {
				"Warlock - Nightfall Proc", -- [1]
				"Warlock - Curse Of Agony", -- [2]
				"Warlock - Siphon", -- [3]
				"Warlock - Shadowburn", -- [4]
				"Warlock - Immolate", -- [5]
				"Warlock - Corruption", -- [6]
				"Warlock - Healthstone #", -- [7]
				"Warlock - Soul Shard #", -- [8]
				"Warlock - Banish Timer", -- [9]
				"Warlock - Soul Stone", -- [10]
				"Warlock - Escape Artist", -- [11]
				"Warlock - Perception", -- [12]
				"Warlock - Will of the Forsaken", -- [13]
				"Warlock  - Blood Fury", -- [14]
				"Warlock - Spell Lock", -- [15]
				"Warlock - Howl of Terror", -- [16]
				"Warlock - Mana Bar ", -- [17]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -30,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["url"] = "https://wago.io/Y8douZITb/12",
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
			["internalVersion"] = 49,
			["selfPoint"] = "BOTTOMLEFT",
			["version"] = 12,
			["subRegions"] = {
			},
			["load"] = {
				["use_class"] = "true",
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class"] = {
					["single"] = "WARLOCK",
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
			["scale"] = 0.8,
			["border"] = false,
			["borderEdge"] = "1 Pixel",
			["regionType"] = "group",
			["borderSize"] = 2,
			["borderOffset"] = 4,
			["semver"] = "1.0.11",
			["tocversion"] = 11302,
			["id"] = "Warlock 2.0",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["uid"] = "GmwdiAzp9BQ",
			["config"] = {
			},
			["xOffset"] = 0,
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
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
				["groupOffset"] = true,
			},
			["borderInset"] = 1,
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
			["yOffset"] = -49.500030517578,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/z6xqQay0S/16",
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
						["form"] = {
							["single"] = 2,
						},
						["event"] = "Stance/Form/Aura",
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["names"] = {
						},
						["spellIds"] = {
						},
						["duration"] = "1",
						["subeventSuffix"] = "_CAST_START",
						["use_form"] = true,
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["selfPoint"] = "BOTTOM",
			["font"] = "Vixar",
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
				["zoneIds"] = "",
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
			["fontSize"] = 21,
			["shadowXOffset"] = 1,
			["regionType"] = "text",
			["fixedWidth"] = 200,
			["parent"] = "Warrior 2.0",
			["xOffset"] = 0,
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
			["shadowYOffset"] = -1,
			["automaticWidth"] = "Auto",
			["semver"] = "1.0.15",
			["tocversion"] = 11302,
			["id"] = "Warrior - Defensive Stance",
			["config"] = {
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["authorOptions"] = {
			},
			["uid"] = "QwSE99UBSjg",
			["justify"] = "LEFT",
			["wordWrap"] = "WordWrap",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["preferToUpdate"] = false,
		},
		["Priest - Inner Fire"] = {
			["iconSource"] = 0,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -327,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/R8xGfpcxa/14",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Inner Fire", -- [1]
						},
						["ownOnly"] = true,
						["genericShowOn"] = "showAlways",
						["use_unit"] = true,
						["unitExists"] = true,
						["debuffType"] = "HELPFUL",
						["use_genericShowOn"] = true,
						["type"] = "aura2",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["spellName"] = 6346,
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Fear Ward",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["useName"] = true,
						["use_track"] = true,
						["matchesShowOn"] = "showAlways",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 14,
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
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_shadowYOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "BOTTOM",
					["text_anchorYOffset"] = 5,
					["text_fontSize"] = 9,
					["anchorXOffset"] = 0,
					["text_fontType"] = "OUTLINE",
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_class"] = true,
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
					["single"] = "PRIEST",
					["multi"] = {
						["SHAMAN"] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "dCkT4A4Ng6X",
			["cooldownEdge"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["regionType"] = "icon",
			["selfPoint"] = "CENTER",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["xOffset"] = 0,
			["cooldownTextDisabled"] = true,
			["width"] = 35,
			["zoom"] = 0.3,
			["auto"] = false,
			["tocversion"] = 11302,
			["id"] = "Priest - Inner Fire",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["semver"] = "1.0.13",
			["config"] = {
			},
			["inverse"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayIcon"] = 135926,
			["cooldown"] = true,
			["parent"] = "Priest 2.0",
		},
		["Priest - Fade"] = {
			["iconSource"] = 0,
			["xOffset"] = 99,
			["preferToUpdate"] = false,
			["yOffset"] = -262,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/R8xGfpcxa/14",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["auranames"] = {
							"Fade", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["unitExists"] = true,
						["debuffType"] = "HELPFUL",
						["useName"] = true,
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["names"] = {
						},
						["matchesShowOn"] = "showAlways",
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Fade",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["type"] = "spell",
						["use_genericShowOn"] = true,
						["use_unit"] = true,
						["use_track"] = true,
						["spellName"] = 586,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["use_unit"] = true,
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 26,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 49,
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
			["uid"] = "C5kjw8rrB)h",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["cooldownEdge"] = false,
			["regionType"] = "icon",
			["parent"] = "Priest 2.0",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["zoom"] = 0.3,
			["width"] = 49,
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Priest - Fade",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["authorOptions"] = {
			},
			["displayIcon"] = 135994,
			["cooldown"] = true,
			["selfPoint"] = "CENTER",
		},
		["INSTANCE LOCK"] = {
			["sparkWidth"] = 15,
			["iconSource"] = -1,
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = 5,
			["anchorPoint"] = "TOP",
			["sparkRotation"] = 0,
			["url"] = "https://wago.io/ynSYGaSVC/6",
			["icon"] = false,
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["selfPoint"] = "BOTTOM",
			["barColor"] = {
				0.4, -- [1]
				0.4, -- [2]
				0.4, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["rotation"] = 0,
			["sparkOffsetY"] = 0,
			["load"] = {
				["size"] = {
					["single"] = "none",
					["multi"] = {
					},
				},
				["use_zone"] = false,
				["use_itemequiped"] = false,
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
				["use_never"] = false,
				["zoneIds"] = "",
			},
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["blendMode"] = "BLEND",
			["texture"] = "Glamour2",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["spark"] = false,
			["tocversion"] = 11305,
			["alpha"] = 1,
			["config"] = {
				["displayMin"] = 0,
				["debug"] = false,
				["updateInterval"] = 5,
				["ShowServer"] = false,
				["ReportResets"] = false,
				["showTimeSpent"] = false,
			},
			["sparkOffsetX"] = 0,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.75, -- [4]
			},
			["customText"] = "function()\n    local now = time()\n    \n    local oldestKey, oldestTime;\n    local oldestKeyDay, oldestTimeDay;\n    local count = 0;\n    local thisToon = UnitName(\"player\") .. \"%s%p%s\" .. GetRealmName();\n    \n    local instances = {}\n    \n    for k,v in pairs(aura_env.db.History) do\n        if not (now > v.last + 3600 or v.last > now + 3600) then\n            instances[count] = v;\n            count = count + 1;\n            \n            if not oldestTime or v.last < oldestTime then\n                oldestKey = k;\n                oldestTime = v.last;\n            end\n        end\n    end\n    \n    local dayCount = 0;\n    for k,v in pairs(aura_env.db.HistoryDay) do\n        if string.match(k, thisToon) then\n            if not (now > v.last + 86400 or v.last > now + 86400) then\n                dayCount = dayCount + 1;\n                \n                if not oldestTimeDay or v.last < oldestTimeDay then\n                    oldestKeyDay = k;\n                    oldestTimeDay = v.last;\n                end\n            end\n        end\n    end\n    \n    \n    local remDay = oldestTimeDay and (oldestTimeDay + 86400 - now);\n    \n    local instanceStr = \"\"\n    local needLineBreak = false;\n    local timeSpentStr = \"\"\n    \n    if count >= aura_env.config.displayMin then\n        local rem = oldestTime and (oldestTime + 3600 - now);\n        instanceStr = string.format(\"Hourly: %d/5; More in %s.\", count, rem and SecondsToTime(rem) or \"n/a\");\n        needLineBreak = true;\n        \n        -- Time spent in instance\n        if aura_env.config.showTimeSpent then\n            table.sort(instances, function (i1, i2) return i1.create < i2.create end)\n            for k,v in pairs(instances) do\n                if timeSpentStr ~= \"\" then\n                    timeSpentStr = timeSpentStr .. \" / \";\n                end\n                \n                local timeSpent = v.last - v.create;\n                local minutes = math.floor(timeSpent / 60);\n                local seconds = timeSpent - minutes * 60;\n                timeSpentStr = timeSpentStr .. string.format(\"%02d:%02d\", minutes, seconds);\n            end\n        end\n    end\n    if dayCount >= aura_env.config.displayMin then\n        if needLineBreak then\n            instanceStr = instanceStr .. \"\\n\";\n        end\n        \n         -- instanceStr = instanceStr .. string.format(\"Daily (%s): %d/30; More in %s\", UnitName(\"player\"), dayCount, remDay and SecondsToTime(remDay) or \"n/a\");\n         instanceStr = instanceStr .. string.format(\"Daily: %d/30; More in %s\", dayCount, remDay and SecondsToTime(remDay) or \"n/a\");\n    end    \n    \n    return instanceStr, timeSpentStr;\nend",
			["customTextUpdate"] = "update",
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["custom_type"] = "stateupdate",
						["customVariables"] = "\n\n",
						["names"] = {
						},
						["event"] = "Health",
						["unit"] = "player",
						["events"] = "",
						["custom"] = "function(as)\n    local now = time()\n    \n    if aura_env.autoReset then\n        aura_env.doAutoReset();\n    end\n    \n    if GetTime() - aura_env.lastDisplayUpdate >= aura_env.config.updateInterval then\n        local thisToon = UnitName(\"player\") .. \"%s%p%s\" .. GetRealmName();\n        local s = {};\n        s.changed = true;\n        \n        local count = 0;\n        \n        for k,v in pairs(aura_env.db.History) do\n            if not (now > v.last + 3600 or v.last > now + 3600) then\n                count = count + 1; \n            end\n        end\n        \n        s.name = \"Instance History\";\n        \n        s.progressType = \"static\";\n        \n        s.additionalProgress = {};\n        local now = time();\n        \n        local czk = aura_env.histZoneKey();\n        \n        local ordered = {};\n        \n        local dayCount = 0;\n        for k,v in pairs(aura_env.db.HistoryDay) do\n            if string.match(k, thisToon) then\n                if not (now > v.last + 86400 or v.last > now + 86400) then\n                    dayCount = dayCount + 1;\n                end\n            end\n        end\n        \n        s.show = count >= aura_env.config.displayMin or dayCount >= aura_env.config.displayMin;\n        \n        if count > 0 then\n            s.value = 3600;\n            s.total = 3600;\n            local start = now-3600;\n            \n            for k,v in pairs(aura_env.db.History) do\n                if k == czk then\n                    v.last = now; \n                end\n                table.insert(ordered, {k, v.create});\n            end\n            \n            table.sort(ordered, function(a,b) return a[2]<b[2] end);\n            \n            for idx,t in pairs(ordered) do\n                local k = t[1];\n                local v = aura_env.db.History[k];\n                \n                if v.last >= start then\n                    \n                    local o = {};\n                    --o.max = math.min(3600, v.create - start);\n                    --o.min = math.max(0, math.min(v.last - start, o.max-25));\n                    \n                    o.max = math.max(0, math.min(3600, v.last - start));\n                    \n                    local prev = #s.additionalProgress > 0 and s.additionalProgress[#s.additionalProgress].max or 0;\n                    \n                    o.min = math.max(0, math.min(3600, math.min(math.max(prev+25, v.create - start), o.max-25)));\n                    \n                    --print(o.max, o.min)\n                    table.insert(s.additionalProgress, o);\n                end\n            end\n        elseif dayCount > 0 then\n            s.value = 86400;\n            s.total = 86400;\n            local start = now-86400;\n            \n            for k,v in pairs(aura_env.db.HistoryDay) do\n                if string.match(k, thisToon) then\n                    if k == czk then\n                        v.last = now; \n                    end\n                    table.insert(ordered, {k, v.create});\n                end\n            end\n            \n            table.sort(ordered, function(a,b) return a[2]<b[2] end);\n            \n            for idx,t in pairs(ordered) do\n                local k = t[1];\n                local v = aura_env.db.HistoryDay[k];\n                \n                if v.last >= start then\n                    \n                    local o = {};\n                    --o.max = math.min(86400, v.create - start);\n                    --o.min = math.max(0, math.min(v.last - start, o.max-25));\n                    \n                    o.max = math.max(0, math.min(86400, v.last - start));\n                    \n                    local prev = #s.additionalProgress > 0 and s.additionalProgress[#s.additionalProgress].max or 0;\n                    \n                    o.min = math.max(0, math.min(86400, math.min(math.max(prev+25, v.create - start), o.max-25)));\n                    \n                    --print(o.max, o.min)\n                    table.insert(s.additionalProgress, o);\n                end\n            end\n        end\n        \n        \n        --DevTools_Dump(s.additionalProgress)\n        \n        as[1] = s;\n        \n        aura_env.lastDisplayUpdate = GetTime();\n        return true;\n    else\n        return false;\n    end\nend",
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["check"] = "update",
						["subeventSuffix"] = "_CAST_START",
						["debuffType"] = "HELPFUL",
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "custom",
						["custom_type"] = "event",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["custom"] = "function(event, ...)\n    if aura_env[event] then\n        aura_env[event](...) \n    end\nend",
						["events"] = "CHAT_MSG_SYSTEM,INSTANCE_BOOT_START, INSTANCE_BOOT_STOP, GROUP_ROSTER_UPDATE, PLAYER_ENTERING_WORLD, ZONE_CHANGED_NEW_AREA, RAID_INSTANCE_WELCOME, PLAYER_LEAVING_WORLD, PLAYER_CAMPING, CHAT_MSG_ADDON, SEND_INSTANCE_RESET_REQUEST",
						["subeventSuffix"] = "_CAST_START",
						["names"] = {
						},
						["unit"] = "player",
						["spellIds"] = {
						},
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["useAdjustedMin"] = false,
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
			["backdropInFront"] = false,
			["stickyDuration"] = false,
			["discrete_rotation"] = 0,
			["version"] = 6,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subforeground",
				}, -- [2]
				{
					["text_shadowXOffset"] = 0,
					["text_text"] = "%c1",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "BOTTOM",
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
					["text_font"] = "PT Sans Narrow",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "TOP",
					["text_text_format_c1_format"] = "none",
					["text_anchorYOffset"] = 3,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_visible"] = true,
				}, -- [3]
				{
					["text_shadowXOffset"] = 1,
					["text_text"] = "%c2",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_selfPoint"] = "BOTTOM",
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
						0.6059664785862, -- [4]
					},
					["text_font"] = "PT Sans Narrow",
					["text_shadowYOffset"] = -1,
					["text_text_format_c2_format"] = "none",
					["text_visible"] = true,
					["text_anchorPoint"] = "BOTTOM",
					["text_anchorYOffset"] = -15,
					["text_wordWrap"] = "WordWrap",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_fontType"] = "None",
				}, -- [4]
				{
					["type"] = "subborder",
					["border_anchor"] = "bar",
					["border_offset"] = 0,
					["border_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["border_visible"] = true,
					["border_edge"] = "ElvUI GlowBorder",
					["border_size"] = 1,
				}, -- [5]
			},
			["height"] = 8,
			["rotate"] = true,
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["useAdjustedMax"] = false,
			["mirror"] = false,
			["anchorFrameFrame"] = "KillCountFrame",
			["borderInFront"] = true,
			["authorOptions"] = {
				{
					["type"] = "toggle",
					["name"] = "Debug Mode",
					["default"] = false,
					["key"] = "debug",
					["useDesc"] = false,
					["width"] = 1,
				}, -- [1]
				{
					["type"] = "toggle",
					["name"] = "Report Resets to Chat",
					["default"] = false,
					["key"] = "ReportResets",
					["useDesc"] = false,
					["width"] = 1,
				}, -- [2]
				{
					["type"] = "toggle",
					["name"] = "Show Server Name",
					["default"] = false,
					["key"] = "ShowServer",
					["useDesc"] = false,
					["width"] = 1,
				}, -- [3]
				{
					["type"] = "toggle",
					["key"] = "showTimeSpent",
					["default"] = false,
					["name"] = "Show time spent in instances",
					["useDesc"] = false,
					["width"] = 1,
				}, -- [4]
				{
					["type"] = "range",
					["useDesc"] = false,
					["max"] = 10,
					["step"] = 0.05,
					["width"] = 1,
					["min"] = 0.5,
					["key"] = "updateInterval",
					["default"] = 5,
					["name"] = "Display Update Interval",
				}, -- [5]
				{
					["type"] = "range",
					["useDesc"] = true,
					["max"] = 5,
					["step"] = 1,
					["width"] = 1,
					["min"] = 0,
					["name"] = "Display Threshold",
					["default"] = 2,
					["key"] = "displayMin",
					["desc"] = "Minimum number of instances before display appears",
				}, -- [6]
			},
			["icon_side"] = "LEFT",
			["auto"] = true,
			["zoom"] = 0,
			["sparkHeight"] = 30,
			["borderBackdrop"] = "Blizzard Tooltip",
			["sparkRotationMode"] = "AUTO",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["semver"] = "1.0.5",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "-- Do not remove this comment, it is part of this trigger: Instance History\nlocal function chatMsg(...)\n    DEFAULT_CHAT_FRAME:AddMessage(\"\\124cFFFF0000\"..(aura_env and aura_env.id or \"Instance History\")..\"\\124r: \"..string.format(...))\nend\n\nlocal function debug(...)\n    local db = WeakAurasSaved.instanceHistoryDb;\n    \n    if db.config.debug then\n        chatMsg(...)\n    end\nend\n\nlocal function deepcopy(orig)\n    local orig_type = type(orig)\n    local copy\n    if orig_type == 'table' then\n        copy = {}\n        for orig_key, orig_value in next, orig, nil do\n            copy[deepcopy(orig_key)] = deepcopy(orig_value)\n        end\n        setmetatable(copy, deepcopy(getmetatable(orig)))\n    else -- number, string, boolean, etc\n        copy = orig\n    end\n    return copy\nend\n\nlocal function pad(n)\n    local s = \"\";\n    \n    for i=1,n do\n        s = s..\"     \";\n    end\n    \n    return s;\nend\n\nlocal function dump(t, depth)\n    if DevTools_Dump then\n        DevTools_Dump(t)\n        return\n    end\n    \n    if type(t) == \"table\" then\n        if not depth then\n            depth = 1;\n            debug(\"Table dump: {\")\n        end\n        \n        if depth > 5 then return end\n        \n        for k,v in pairs(t) do\n            if type(v) == \"string\" or type(v) == \"number\" then\n                print(pad(depth)..k..\"=\"..v);\n            elseif type(v) == \"table\" then\n                print(pad(depth)..k..\"={\");\n                dump(v, depth+1);\n                print(pad(depth)..\"}\");\n            end\n        end\n        \n        print(\"}\");\n    else\n        print(t);\n    end\nend\n\nlocal db;\n\nif WeakAurasSaved.instanceHistoryDb then\n    db = WeakAurasSaved.instanceHistoryDb;\n    \n    --debug(\"loaded save data\")\n    \n    --dump(WeakAurasSaved.instanceHistoryDb)\nelse\n    WeakAurasSaved.instanceHistoryDb = WeakAurasSaved.instanceHistoryDb or {};\n    db = WeakAurasSaved.instanceHistoryDb;\nend\n\naura_env.db = db;\n\ndb.histGeneration = db.histGeneration or 1;\ndb.History = db.History or {};\ndb.HistoryDay = db.HistoryDay or {};\ndb.Instances = db.Instances or {};\ndb.config = deepcopy(aura_env.config);\n\n-- session variables\ndb.sess = {}; -- session variables, reset em each time \n-- db.sess.delayedReset;\n-- db.sess.delayUpdate;\n-- db.sess.histLastZone;\n-- db.sess.histInGroup;\n-- db.sess.lasthistdbg;\n-- db.sess.histLiveCount;\n-- db.sess.histOldest;\n-- db.sess.enterLoc;\naura_env.lastDisplayUpdate = 0;\n\n-- constant stuff\nlocal histReapTime = 60*60 -- 1 hour\nlocal histReapTimeDay = 60*60*24 -- 1 day\nlocal histLimit = 5 -- instances per hour\nlocal maxdiff = 33 -- max number of instance difficulties\nlocal LimitWarn = true;\nlocal prefix = \"instHistory\";\n\nlocal f = {};\n\nC_ChatInfo.RegisterAddonMessagePrefix(prefix);\nlocal thisToon = UnitName(\"player\") .. \" - \" .. GetRealmName()\n\nlocal transInstance = {\n    -- lockout hyperlink id = LFDID\n    [543] = 188,     -- Hellfire Citadel: Ramparts\n    [540] = 189,     -- Hellfire Citadel: Shattered Halls : deDE\n    [542] = 187,  -- Hellfire Citadel: Blood Furnace esES\n    [534] = 195,     -- The Battle for Mount Hyjal\n    [509] = 160,     -- Ruins of Ahn'Qiraj\n    [557] = 179,  -- Auchindoun: Mana-Tombs : ticket 72 zhTW\n    [556] = 180,  -- Auchindoun: Sethekk Halls : ticket 151 frFR\n    [568] = 340,  -- Zul'Aman: frFR\n    [1004] = 474, -- Scarlet Monastary: deDE\n    [600] = 215,  -- Drak'Tharon: ticket 105 deDE\n    [560] = 183,  -- Escape from Durnholde Keep: ticket 124 deDE\n    [531] = 161,  -- AQ temple: ticket 137 frFR\n    [1228] = 897, -- Highmaul: ticket 175 ruRU\n    [552] = 1011, -- Arcatraz: ticket 216 frFR\n    [1516] = 1190, -- Arcway: ticket 227/233 ptBR\n    [1651] = 1347, -- Return to Karazhan: ticket 237 (fake LFDID)\n    [545] = 185, -- The Steamvault: issue #143 esES\n    [1530] = 1353, -- The Nighthold: issue #186 frFR\n    [585] = 1154, -- Magisters' Terrace: issue #293 frFR\n}\n\nlocal function InGroup()\n    if IsInRaid() then return \"RAID\"\n    elseif GetNumGroupMembers() > 0 then return \"PARTY\"\n    else return nil end\nend\n\nlocal function histZoneKey()\n    local instname, insttype, diff, diffname, maxPlayers, playerDifficulty, isDynamicInstance = GetInstanceInfo()\n    \n    if insttype == nil or insttype == \"none\" or insttype == \"arena\" or insttype == \"pvp\" then -- pvp doesnt count\n        return nil\n    end\n    \n    --[[\n    if (IsInLFGDungeon() or IsInScenarioGroup()) and diff ~= 19 then -- LFG instances don't count, but Holiday Event counts\n        return nil\n    end\n]]\n    \n    -- check if we're locked (using FindInstance so we don't complain about unsaved unknown instances)\n    local truename = f.FindInstance(instname, insttype == \"raid\")\n    local locked = false\n    local inst = truename and db.Instances[truename]\n    inst = inst and inst[thisToon]\n    \n    for d=1,maxdiff do\n        if inst and inst[d] and inst[d].Locked then\n            locked = true\n        end\n    end\n    \n    if diff == 1 and maxPlayers == 5 then -- never locked to 5-man regs\n        locked = false\n    end\n    \n    local toonstr = thisToon\n    \n    if db.config.ShowServer then\n        toonstr = strsplit(\" - \", toonstr)\n    end\n    \n    local desc = toonstr .. \": \" .. instname\n    \n    if diffname and #diffname > 0 then\n        desc = desc .. \" - \" .. diffname\n    end\n    \n    local key = thisToon..\":\"..instname..\":\"..insttype..\":\"..diff\n    \n    if not locked then\n        key = key..\":\"..db.histGeneration\n    end\n    \n    return key, desc, locked\nend\n\naura_env.histZoneKey = histZoneKey;\n\nlocal function normalizeName(str)\n    return str:gsub(\"%p\",\"\"):gsub(\"%s\",\" \"):gsub(\"%s%s\",\" \"):gsub(\"^%s+\",\"\"):gsub(\"%s+$\",\"\"):upper()\nend\n\n-- some instances (like sethekk halls) are named differently by GetSavedInstanceInfo() and LFGGetDungeonInfoByID()\n-- we use the latter name to key our database, and this function to convert as needed\nf.FindInstance = function(name, raid)\n    if not name or #name == 0 then return nil end\n    \n    local nname = normalizeName(name)\n    -- first pass, direct match\n    local info = db.Instances[name]\n    \n    if info then\n        return name, info.LFDID\n    end\n    \n    -- hyperlink id lookup: must precede substring match for ticket 99\n    -- (so transInstance can override incorrect substring matches)\n    for i = 1, GetNumSavedInstances() do\n        local link = GetSavedInstanceChatLink(i) or \"\"\n        local lid,lname = link:match(\":(%d+):%d+:%d+\\124h%[(.+)%]\\124h\")\n        lname = lname and normalizeName(lname)\n        lid = lid and tonumber(lid)\n        local lfdid = lid and transInstance[lid]\n        if lname == nname and lfdid then\n            local truename = addon:UpdateInstance(lfdid)\n            if truename then\n                return truename, lfdid\n            end\n        end\n    end\n    -- normalized substring match\n    for truename, info in pairs(db.Instances) do\n        local tname = addon:normalizeName(truename)\n        if (tname:find(nname, 1, true) or nname:find(tname, 1, true)) and\n        info.Raid == raid then -- Tempest Keep: The Botanica\n            --debug(\"FindInstance(\"..name..\") => \"..truename)\n            return truename, info.LFDID\n        end\n    end\n    return nil\nend\n\nlocal function generationAdvance()\n    debug(\"HistoryUpdate generation advance\")\n    db.histGeneration = (db.histGeneration + 1) % 100000\n    db.sess.delayedReset = false\nend\n\nlocal function HistoryUpdate(forcereset, forcemesg)\n    local db = WeakAurasSaved.instanceHistoryDb;\n    db.histGeneration = db.histGeneration or 1;\n    \n    if forcereset and histZoneKey() then -- delay reset until we zone out\n        debug(\"HistoryUpdate reset delayed\")\n        db.sess.delayedReset = true\n    end\n    \n    if (forcereset or db.sess.delayedReset) and not histZoneKey() then\n        generationAdvance();\n    elseif db.lastLoc then\n        if not db.sess.enterLoc then\n            -- delay until enterLoc is defined\n            C_Timer.After(1, HistoryUpdate);\n            return;\n        end\n        \n        if db.sess.enterLoc.instance == db.lastLoc.instance and db.lastLoc.instance >= 0 and db.sess.enterLoc.subzone ~= db.lastLoc.subzone then\n            debug(\"Offline forced reset detected.\")\n            generationAdvance();\n        else\n            debug(\"Location data resolved, no reset detected.\")\n            \n            --[[if db.config.debug then\n                print(db.sess.enterLoc.instance, db.sess.enterLoc.subzone, db.lastLoc.instance, db.lastLoc.subzone)\n            end]]\n        end\n        \n        --[[if db.lastLoc then\n            debug(\"lastLoc cleared\")\n        end]]\n        \n        db.lastLoc = nil;\n    end\n    \n    local now = time()\n    \n    if db.sess.delayUpdate and now < db.sess.delayUpdate then\n        --debug(\"HistoryUpdate delayed\")\n        C_Timer.After(db.sess.delayUpdate - now + 0.05, HistoryUpdate)\n        return\n    end\n    \n    local zoningin = false\n    local newzone, newdesc, locked = histZoneKey()\n    \n    -- touch zone we left\n    if db.sess.histLastZone then\n        local lz = db.History[db.sess.histLastZone]\n        local lzDay = db.HistoryDay[db.sess.histLastZone]\n        if lz then\n            lz.last = now\n            lzDay.last = now\n        end\n    elseif newzone then\n        zoningin = true\n    end\n    \n    db.sess.histLastZone = newzone\n    db.sess.histInGroup = InGroup()\n    \n    -- touch/create new zone\n    if newzone and not string.match(newzone, \"Blackwing%sLair\") and not string.match(newzone, \"Molten%sCore\") and not string.match(newzone, \"Ahn.Qiraj\") and not string.match(newzone, \"Naxxramas\") then\n        local nz = db.History[newzone]\n        local nzDay = db.HistoryDay[newzone]\n        \n        if not nz then\n            nz = { create = now, desc = newdesc }\n            nzDay = nz\n            db.History[newzone] = nz\n            db.HistoryDay[newzone] = nzDay\n            \n            if locked then -- creating a locked instance, delete unlocked version\n                db.History[newzone..\":\"..db.histGeneration] = nil\n                db.HistoryDay[newzone..\":\"..db.histGeneration] = nil\n            end\n        elseif not nzDay then\n            nzDay = nz\n            db.HistoryDay[newzone] = nzDay\n            \n            if locked then -- creating a locked instance, delete unlocked version\n                db.HistoryDay[newzone..\":\"..db.histGeneration] = nil\n            end\n        end\n        \n        \n        nz.last = now\n        nzDay.last = now\n    end\n    \n    -- reap old zones\n    local livecnt = 0\n    local oldestkey, oldesttime\n    \n    for zk, zi in pairs(db.History) do\n        if now > zi.last + histReapTime or\n        zi.last > (now + 3600) then -- temporary bug fix\n            debug(\"Reaping %s\",zi.desc)\n            db.History[zk] = nil\n        else\n            livecnt = livecnt + 1\n            \n            if not oldesttime or zi.last < oldesttime then\n                oldestkey = zk\n                oldesttime = zi.last\n            end\n        end\n    end\n    \n    -- reap old zones per day\n    for zk, zi in pairs(db.HistoryDay) do\n        if now > zi.last + histReapTimeDay or\n        zi.last > (now + 86400) then -- temporary bug fix\n            debug(\"Reaping %s from day\",zi.desc)\n            db.HistoryDay[zk] = nil\n        end\n    end\n    \n    local oldestrem = oldesttime and (oldesttime+histReapTime-now)\n    local oldestremt = (oldestrem and SecondsToTime(oldestrem,false,false,1)) or \"n/a\"\n    local oldestremtm = (oldestrem and SecondsToTime(math.floor((oldestrem+59)/60)*60,false,false,1)) or \"n/a\"\n    \n    if db.config.debug then\n        local msg = livecnt..\" live instances, oldest (\"..(oldestkey or \"none\")..\") expires in \"..oldestremt..\". Current Zone=\"..(newzone or \"nil\")\n        if msg ~= db.sess.lasthistdbg then\n            db.sess.lasthistdbg = msg\n            debug(msg)\n        end\n        \n        --dump(db.History)\n    end\n    -- display update\n    \n    if forcemesg or (LimitWarn and zoningin and livecnt >= histLimit-1) then\n        chatMsg(\"Warning: You've entered about %i instances recently and are approaching the %i instance per hour limit for your account. More instances should be available in %s.\",livecnt, histLimit, oldestremt)\n    end\n    \n    db.sess.histLiveCount = livecnt\n    db.sess.histOldest = oldestremt\n    \n    --[[\n    if db.Tooltip.HistoryText and livecnt > 0 then\n        addon.dataobject.text = \"(\"..livecnt..\"/\"..(oldestremt or \"?\")..\")\"\n        addon.histTextthrottle = math.min(oldestrem+1, addon.histTextthrottle or 15)\n        addon.resetDetect:SetScript(\"OnUpdate\", addon.histTextUpdate)\n    else\n        addon.dataobject.text = addonAbbrev\n        addon.resetDetect:SetScript(\"OnUpdate\", nil)\n    end\n]]\nend\n\n-- fixme localize or something\nfunction doExplicitReset(instancemsg, failed)\n    if InGroup() and not UnitIsGroupLeader(\"player\") then\n        return\n    end\n    \n    local db = WeakAurasSaved.instanceHistoryDb;\n    \n    if not failed then\n        HistoryUpdate(true)\n    end\n    \n    local reportchan = InGroup()\n    \n    if reportchan then\n        if not failed then\n            C_ChatInfo.SendAddonMessage(prefix, \"GENERATION_ADVANCE\", reportchan)\n        end\n        if db.config.ReportResets then\n            local msg = instancemsg or RESET_INSTANCES\n            msg = msg:gsub(\"\\1241.+;.+;\",\"\") -- ticket 76, remove |1;; escapes on koKR\n            -- SendChatMessage(\"All instances have been reset.\", reportchan)\n        end\n    end\nend\n\nhooksecurefunc(\"ResetInstances\", doExplicitReset)\n\naura_env.CHAT_MSG_SYSTEM = function(msg)\n    local raiddiffmsg = ERR_RAID_DIFFICULTY_CHANGED_S:gsub(\"%%s\",\".+\")\n    local dungdiffmsg = ERR_DUNGEON_DIFFICULTY_CHANGED_S:gsub(\"%%s\",\".+\")\n    \n    if msg == INSTANCE_SAVED then -- just got saved\n        C_Timer.After(4, HistoryUpdate)\n    elseif (msg:match(\"^\"..raiddiffmsg..\"$\") or msg:match(\"^\"..dungdiffmsg..\"$\")) and\n    not histZoneKey() then -- ignore difficulty messages when creating a party while inside an instance\n        HistoryUpdate(true)\n    elseif msg:match(TRANSFER_ABORT_TOO_MANY_INSTANCES) then\n        HistoryUpdate(false,true)\n    end\nend\n\naura_env.INSTANCE_BOOT_START = function()\n    HistoryUpdate(true)\nend\n\naura_env.INSTANCE_BOOT_STOP = function()\n    if InGroup() then\n        db.sess.delayedReset = false\n    end\nend\n\naura_env.GROUP_ROSTER_UPDATE = function()\n    if db.sess.histInGroup and not InGroup() and -- ignore failed invites when solo\n    not histZoneKey() then -- left group outside instance, resets now\n        HistoryUpdate(true)\n    end\nend\n\nlocal function zoneChanged(extraDelay)\n    -- delay updates while settings stabilize\n    local waittime = 3 + math.max(0,10 - GetFramerate()) + (extraDelay or 0)\n    local d = time() + waittime\n    \n    if d > (db.sess.delayUpdate or 0) then\n        db.sess.delayUpdate = d;\n    end\n    \n    C_Timer.After(waittime + 0.05, HistoryUpdate)\nend\n\nlocal function getLocation()\n    local name, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceID, instanceGroupSize, LfgDungeonID = GetInstanceInfo();\n    \n    local loc;\n    \n    if instanceType == \"none\" then\n        loc = {};\n        loc.instance = -1;\n    else\n        loc = {};\n        --loc.instance = histZoneKey();\n        loc.instance = instanceID;\n        loc.subzone = GetSubZoneText();\n    end\n    \n    --[[\n    if db.config.debug then\n        dump(loc)\n    end\n]]\n    \n    return loc;\nend\n\naura_env.PLAYER_ENTERING_WORLD = function()\n    C_Timer.After(6, function()\n            db.sess.enterLoc = getLocation();\n    end)\n    \n    zoneChanged();\nend\n\naura_env.ZONE_CHANGED_NEW_AREA = function()\n    zoneChanged();\nend\n\naura_env.RAID_INSTANCE_WELCOME = function()\n    zoneChanged();\nend\n\naura_env.PLAYER_CAMPING = function()\n    db.lastLoc = getLocation();\n    --debug(\"Set lastLoc\")\n    \n    --dump(WeakAurasSaved.instanceHistoryDb)\nend\n\naura_env.CHAT_MSG_ADDON = function(pre, msg, channel, sender)\n    if pre == prefix then\n        if msg == \"GENERATION_ADVANCE\" and not UnitIsUnit(sender, \"player\") then\n            HistoryUpdate(true);\n        elseif msg == \"RESET_REQUEST\" then\n            if UnitIsGroupLeader(\"player\") then\n                chatMsg(string.format(\"Received reset request from %s. All instances will be reset once %s is offline.\", sender, sender))\n                aura_env.autoReset = string.match(sender, \"^[^%-]+\");\n            end\n        end\n    end\nend\n\naura_env.SEND_INSTANCE_RESET_REQUEST = function()\n    local channel = InGroup();\n    \n    if channel then\n        C_ChatInfo.SendAddonMessage(prefix, \"RESET_REQUEST\", reportchan);\n    end\nend\n\naura_env.doAutoReset = function()\n    if not aura_env.autoReset then\n        return;\n    end\n    \n    if not UnitIsGroupLeader(\"player\") then\n        debug(\"Player is not leader, auto reset disabled.\")\n        aura_env.autoReset = nil;\n        return;\n    end\n    \n    local name = aura_env.autoReset;\n    \n    if UnitExists(name) then\n        if not UnitIsConnected(name) then\n            C_Timer.After(1, function()\n                    ResetInstances();\n            end)\n            aura_env.autoReset = nil;\n            return;\n        end\n    else\n        debug(\"Sender does not exist, auto reset disabled.\")\n        aura_env.autoReset = nil;\n        return;\n    end\nend\n\n--[[\naura_env.PLAYER_LEAVING_WORLD = function()\n    db.lastLoc = getLocation();\n    debug(\"Set lastLoc\")\nend\n]]\n\n--DevTools_Dump(getLocation())\n\n\n--HistoryUpdate();\n\n--print(histZoneKey())",
					["do_custom"] = true,
				},
			},
			["sparkHidden"] = "NEVER",
			["width"] = 270,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SELECTFRAME",
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["id"] = "INSTANCE LOCK",
			["inverse"] = false,
			["backgroundColor"] = {
				0.101960784313725, -- [1]
				0.101960784313725, -- [2]
				0.101960784313725, -- [3]
				0.691175431013107, -- [4]
			},
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["uid"] = "JnXsI)Znc0b",
		},
		["Warrior - Overpower Active"] = {
			["iconSource"] = -1,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -75,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
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
						["useGroup_count"] = false,
						["use_tooltip"] = false,
						["use_genericShowOn"] = true,
						["unit"] = "player",
						["buffShowOn"] = "showOnActive",
						["useName"] = true,
						["spellIds"] = {
							215572, -- [1]
						},
						["spellName"] = 7384,
						["unevent"] = "auto",
						["type"] = "spell",
						["use_debuffClass"] = false,
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["debuffType"] = "HELPFUL",
						["event"] = "Cooldown Progress (Spell)",
						["use_exact_spellName"] = false,
						["realSpellName"] = "Overpower",
						["use_spellName"] = true,
						["name"] = "Spell Reflection",
						["names"] = {
							"Frothing Berserker", -- [1]
						},
						["ownOnly"] = true,
						["combineMatches"] = "showLowest",
						["use_track"] = true,
						["use_unit"] = true,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["unevent"] = "auto",
						["power_operator"] = ">=",
						["duration"] = "1",
						["event"] = "Power",
						["subeventPrefix"] = "SPELL",
						["powertype"] = 1,
						["use_unit"] = true,
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["use_power"] = true,
						["use_powertype"] = true,
						["power"] = "0",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 16,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0,
					["type"] = "subglow",
					["useGlowColor"] = true,
					["glowType"] = "Pixel",
					["glowLength"] = 6.4,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["glow"] = true,
					["glowScale"] = 1,
					["glowThickness"] = 1.9,
					["glowLines"] = 13,
					["glowBorder"] = false,
				}, -- [2]
			},
			["height"] = 49,
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
				["zoneIds"] = "",
				["spec"] = {
					["single"] = 2,
					["multi"] = {
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
				["difficulty"] = {
					["multi"] = {
					},
				},
				["race"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["faction"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["use_class"] = true,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["zoom"] = 0.3,
			["xOffset"] = 0,
			["regionType"] = "icon",
			["authorOptions"] = {
			},
			["parent"] = "Warrior 2.0",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["icon"] = true,
			["uid"] = "hmEgAO(zumK",
			["semver"] = "1.0.15",
			["cooldownTextDisabled"] = true,
			["auto"] = true,
			["tocversion"] = 11302,
			["id"] = "Warrior - Overpower Active",
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 1,
			["width"] = 49,
			["alpha"] = 1,
			["config"] = {
			},
			["inverse"] = false,
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
							["property"] = "sub.2.glow",
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
							["property"] = "alpha",
						}, -- [1]
					},
				}, -- [2]
				{
					["check"] = {
						["trigger"] = 2,
						["op"] = "<",
						["value"] = "5",
						["variable"] = "power",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [3]
			},
			["cooldown"] = true,
			["url"] = "https://wago.io/z6xqQay0S/16",
		},
		["Priest  - Berserking"] = {
			["iconSource"] = -1,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -327,
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
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["auranames"] = {
							"Rend", -- [1]
						},
						["ownOnly"] = true,
						["genericShowOn"] = "showAlways",
						["unit"] = "target",
						["unitExists"] = true,
						["debuffType"] = "HARMFUL",
						["use_genericShowOn"] = true,
						["useName"] = true,
						["spellName"] = 20554,
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["matchesShowOn"] = "showAlways",
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Berserking",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["names"] = {
						},
						["use_unit"] = true,
						["type"] = "spell",
						["use_track"] = true,
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_race"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "PRIEST",
					["multi"] = {
						["ROGUE"] = true,
					},
				},
				["use_class"] = true,
				["race"] = {
					["single"] = "Troll",
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "tbnNGRFBTP)",
			["xOffset"] = 106,
			["icon"] = true,
			["regionType"] = "icon",
			["parent"] = "Priest 2.0",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
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
			["cooldownTextDisabled"] = true,
			["width"] = 35,
			["zoom"] = 0.3,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Priest  - Berserking",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = true,
			["config"] = {
			},
			["inverse"] = false,
			["authorOptions"] = {
			},
			["displayIcon"] = 132289,
			["cooldown"] = true,
			["url"] = "https://wago.io/R8xGfpcxa/14",
		},
		["Warlock - Mana Bar "] = {
			["overlays"] = {
				{
					0.43529411764706, -- [1]
					0, -- [2]
					1, -- [3]
					0.25, -- [4]
				}, -- [1]
			},
			["iconSource"] = -1,
			["xOffset"] = 0.0003662109375,
			["preferToUpdate"] = false,
			["yOffset"] = -298.03799438477,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["url"] = "https://wago.io/Y8douZITb/12",
			["icon"] = false,
			["fontFlags"] = "OUTLINE",
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["selfPoint"] = "CENTER",
			["barColor"] = {
				0.32549019607843, -- [1]
				0.53725490196078, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["sparkOffsetY"] = 0,
			["load"] = {
				["size"] = {
					["multi"] = {
					},
				},
				["use_petbattle"] = false,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["use_vehicle"] = false,
				["class"] = {
					["single"] = "WARLOCK",
					["multi"] = {
						["WARLOCK"] = true,
						["DRUID"] = true,
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
				["use_class"] = true,
				["role"] = {
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
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["race"] = {
					["multi"] = {
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["texture"] = "Glamour2",
			["zoom"] = 0,
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
			["parent"] = "Warlock 2.0",
			["customText"] = "function()\n    if aura_env.region then\n        local mana = UnitPower(\"player\", Enum.PowerType.Mana)\n        aura_env.region.text3:SetText(mana)\n    end\nend\n\n\n\n\n\n\n\n\n\n\n\n",
			["customTextUpdate"] = "event",
			["triggers"] = {
				{
					["trigger"] = {
						["use_power"] = false,
						["use_showCost"] = true,
						["unit"] = "player",
						["powertype"] = 0,
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
						["duration"] = "1",
						["type"] = "unit",
						["use_health"] = true,
						["unevent"] = "auto",
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["use_requirePowerType"] = false,
						["use_percentpower"] = false,
						["custom_hide"] = "timed",
						["subeventSuffix"] = "_CAST_START",
						["spellIds"] = {
						},
						["health"] = "0",
						["genericShowOn"] = "showOnActive",
						["event"] = "Power",
						["health_operator"] = ">=",
						["names"] = {
						},
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
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
			["version"] = 12,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subforeground",
				}, -- [2]
				{
					["text_shadowXOffset"] = 1,
					["text_text"] = "%c ",
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
					["text_visible"] = false,
					["text_anchorPoint"] = "INNER_RIGHT",
					["text_fontSize"] = 15,
					["anchorXOffset"] = 0,
					["text_fontType"] = "None",
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
					["text_font"] = "Expressway",
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
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "ICON_CENTER",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_fontType"] = "None",
				}, -- [5]
				{
					["type"] = "subborder",
					["border_anchor"] = "bar",
					["border_offset"] = 1,
					["border_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["border_visible"] = true,
					["border_edge"] = "1 Pixel",
					["border_size"] = 1,
				}, -- [6]
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
			["borderBackdrop"] = "None",
			["authorOptions"] = {
			},
			["borderInFront"] = true,
			["sparkRotationMode"] = "AUTO",
			["icon_side"] = "RIGHT",
			["backgroundColor"] = {
				0.32549019607843, -- [1]
				0.53725490196078, -- [2]
				1, -- [3]
				0.60000002384186, -- [4]
			},
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["sparkHeight"] = 30,
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
			["overlaysTexture"] = {
				"Glamour2", -- [1]
			},
			["useAdjustededMax"] = false,
			["semver"] = "1.0.11",
			["anchorFrameType"] = "SCREEN",
			["sparkHidden"] = "NEVER",
			["id"] = "Warlock - Mana Bar ",
			["frameStrata"] = 3,
			["width"] = 245,
			["config"] = {
			},
			["uid"] = "rXIsMos0cPN",
			["inverse"] = false,
			["sparkDesature"] = false,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["spark"] = false,
		},
		["Warlock - Shadowburn"] = {
			["iconSource"] = 0,
			["parent"] = "Warlock 2.0",
			["preferToUpdate"] = false,
			["yOffset"] = -262,
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
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Shadowburn", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showOnCooldown",
						["names"] = {
						},
						["unitExists"] = true,
						["debuffType"] = "HARMFUL",
						["use_genericShowOn"] = true,
						["useName"] = true,
						["spellName"] = 17877,
						["subeventSuffix"] = "_CAST_START",
						["matchesShowOn"] = "showAlways",
						["ownOnly"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Shadowburn",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["unit"] = "target",
						["use_unit"] = true,
						["type"] = "spell",
						["use_track"] = true,
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["use_unit"] = true,
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 12,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 26,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
				{
					["glowFrequency"] = 0.25,
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
					["useGlowColor"] = false,
					["glow"] = false,
					["glowScale"] = 1,
					["glowThickness"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 49,
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
					["single"] = "WARLOCK",
					["multi"] = {
						["WARLOCK"] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "4JH1rebDRsF",
			["xOffset"] = 99,
			["url"] = "https://wago.io/Y8douZITb/12",
			["regionType"] = "icon",
			["selfPoint"] = "CENTER",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = -2,
						["variable"] = "AND",
						["checks"] = {
							{
								["trigger"] = -1,
								["variable"] = "incombat",
								["value"] = 1,
							}, -- [1]
							{
								["trigger"] = 1,
								["variable"] = "buffed",
								["value"] = 1,
							}, -- [2]
							{
								["trigger"] = 1,
								["op"] = "<=",
								["value"] = "2",
								["variable"] = "expirationTime",
							}, -- [3]
						},
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "sub.3.glow",
						}, -- [1]
					},
				}, -- [1]
			},
			["icon"] = true,
			["cooldownTextDisabled"] = true,
			["width"] = 49,
			["zoom"] = 0.3,
			["semver"] = "1.0.11",
			["tocversion"] = 11302,
			["id"] = "Warlock - Shadowburn",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["authorOptions"] = {
			},
			["displayIcon"] = 136191,
			["cooldown"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Druid - Nature's Grasp"] = {
			["iconSource"] = 0,
			["xOffset"] = -34.777954101563,
			["preferToUpdate"] = false,
			["yOffset"] = -327,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/HCaWT5tJa/14",
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
							"Rend", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["unit"] = "target",
						["unitExists"] = true,
						["debuffType"] = "HARMFUL",
						["names"] = {
						},
						["type"] = "spell",
						["use_genericShowOn"] = true,
						["subeventSuffix"] = "_CAST_START",
						["matchesShowOn"] = "showAlways",
						["spellName"] = 16689,
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Nature's Grasp",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["useName"] = true,
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["use_track"] = true,
						["ownOnly"] = true,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 35,
			["load"] = {
				["use_class"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["HUNTER"] = true,
						["ROGUE"] = true,
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
			["config"] = {
			},
			["icon"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["parent"] = "Druid 2.0",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["authorOptions"] = {
			},
			["zoom"] = 0.3,
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Druid - Nature's Grasp",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 35,
			["auto"] = false,
			["uid"] = "dMBq074)mwJ",
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["displayIcon"] = 136063,
			["cooldown"] = true,
			["cooldownEdge"] = false,
		},
		["Warrior - Concussion Blow"] = {
			["iconSource"] = 0,
			["xOffset"] = -98,
			["preferToUpdate"] = false,
			["yOffset"] = -75,
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
			["triggers"] = {
				{
					["trigger"] = {
						["use_alwaystrue"] = true,
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "spell",
						["unevent"] = "auto",
						["use_genericShowOn"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["spellName"] = 12809,
						["realSpellName"] = "Concussion Blow",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["names"] = {
						},
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_track"] = true,
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 16,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 26,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 49,
			["load"] = {
				["use_class"] = true,
				["use_talent"] = true,
				["use_never"] = false,
				["talent"] = {
					["single"] = 54,
					["multi"] = {
						[54] = true,
					},
				},
				["zoneIds"] = "",
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
			["icon"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["url"] = "https://wago.io/z6xqQay0S/16",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
							["property"] = "desaturate",
						}, -- [1]
					},
				}, -- [1]
			},
			["parent"] = "Warrior 2.0",
			["cooldownTextDisabled"] = true,
			["width"] = 49,
			["zoom"] = 0.3,
			["semver"] = "1.0.15",
			["tocversion"] = 11302,
			["id"] = "Warrior - Concussion Blow",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = false,
			["uid"] = "Ovp2)itxu3j",
			["inverse"] = false,
			["authorOptions"] = {
			},
			["displayIcon"] = 132325,
			["cooldown"] = true,
			["selfPoint"] = "CENTER",
		},
		["MANA REGEN"] = {
			["sparkWidth"] = 15,
			["borderBackdrop"] = "Blizzard Tooltip",
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["auto"] = true,
			["yOffset"] = 5,
			["anchorPoint"] = "TOP",
			["backgroundColor"] = {
				0, -- [1]
				0.0784313725490196, -- [2]
				0.352941176470588, -- [3]
				0.382352113723755, -- [4]
			},
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["url"] = "https://wago.io/d1KmPR0Rj/1",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["custom"] = "aura_env.lastMana = UnitPower(\"player\" , 0)\naura_env.lastCast = GetTime()",
					["do_custom"] = true,
				},
				["finish"] = {
					["custom"] = "WeakAuras.ScanEvents(\"TICKUPDATE\", true)",
					["do_custom"] = false,
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "2",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "custom",
						["names"] = {
						},
						["subeventSuffix"] = "_ENERGIZE",
						["unevent"] = "auto",
						["custom_type"] = "stateupdate",
						["event"] = "Health",
						["use_unit"] = true,
						["spellIds"] = {
						},
						["events"] = "UNIT_SPELLCAST_SUCCEEDED:player UNIT_POWER_FREQUENT:player",
						["custom"] = "function(a, e, t)\n    local currentMana = UnitPower(\"player\" , 0)\n    \n    if currentMana >= UnitPowerMax(\"player\", 0) then\n        return false\n    end\n    \n    if e == \"UNIT_POWER_FREQUENT\" and currentMana > aura_env.lastMana and GetTime() >= aura_env.lastCast + 5 then\n        local duration = 2\n        a[\"\"] = {\n            show = true,\n            changed = true,\n            duration = duration,\n            expirationTime = GetTime() + duration,\n            progressType = \"timed\",\n            autoHide = true\n        }\n        aura_env.lastMana = currentMana\n        \n    elseif e == \"UNIT_SPELLCAST_SUCCEEDED\" and currentMana < aura_env.lastMana then\n        local duration = 6 -- why?\n        --local duration = 5\n        a[\"\"] = {\n            show = true,\n            changed = true,\n            duration = duration,\n            expirationTime = GetTime() + duration,\n            progressType = \"timed\",\n            autoHide = true\n        }\n        aura_env.lastMana = currentMana\n        aura_env.lastCast = GetTime()\n    end\n    return true\nend",
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
			["internalVersion"] = 49,
			["sparkOffsetX"] = 0,
			["selfPoint"] = "BOTTOM",
			["backdropInFront"] = false,
			["authorOptions"] = {
			},
			["barColor"] = {
				0, -- [1]
				0.235294117647059, -- [2]
				1, -- [3]
				0.676470726728439, -- [4]
			},
			["desaturate"] = false,
			["stickyDuration"] = false,
			["icon"] = false,
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
					["text_text_format_p_time_precision"] = 1,
					["type"] = "subtext",
					["text_anchorXOffset"] = 15,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Accidental Presidency",
					["anchorXOffset"] = 0,
					["text_shadowYOffset"] = -1,
					["text_anchorYOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "SPARK",
					["text_text_format_p_format"] = "timed",
					["text_visible"] = false,
					["text_fontSize"] = 20,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_p_time_format"] = 0,
				}, -- [3]
				{
					["type"] = "subborder",
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
					["border_offset"] = 5,
				}, -- [4]
			},
			["height"] = 7,
			["useAdjustededMax"] = false,
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
				["zoneIds"] = "",
			},
			["sparkBlendMode"] = "ADD",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["uid"] = "dvZawXAyrxC",
			["version"] = 1,
			["anchorFrameType"] = "SELECTFRAME",
			["frameStrata"] = 5,
			["useAdjustededMin"] = false,
			["smoothProgress"] = false,
			["anchorFrameFrame"] = "PlayerFrameHealthBar",
			["regionType"] = "aurabar",
			["borderInFront"] = true,
			["id"] = "MANA REGEN",
			["icon_side"] = "RIGHT",
			["spark"] = true,
			["sparkHeight"] = 30,
			["texture"] = "Glamour2",
			["sparkTexture"] = "GarrMission_EncounterBar-Spark",
			["zoom"] = 0,
			["semver"] = "1.0.0",
			["tocversion"] = 11302,
			["sparkHidden"] = "NEVER",
			["config"] = {
			},
			["alpha"] = 1,
			["width"] = 115,
			["color"] = {
			},
			["sparkColor"] = {
				0.93725490196078, -- [1]
				1, -- [2]
				0.94509803921569, -- [3]
				1, -- [4]
			},
			["inverse"] = false,
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
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["iconSource"] = -1,
		},
		["Druid - Shred"] = {
			["iconSource"] = 0,
			["parent"] = "Druid 2.0",
			["preferToUpdate"] = false,
			["yOffset"] = -263,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Rake", -- [1]
						},
						["ownOnly"] = true,
						["genericShowOn"] = "showOnCooldown",
						["unit"] = "target",
						["unitExists"] = true,
						["debuffType"] = "HARMFUL",
						["use_genericShowOn"] = true,
						["useName"] = true,
						["use_unit"] = true,
						["subeventSuffix"] = "_CAST_START",
						["names"] = {
						},
						["spellName"] = 2983,
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Sprint",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["matchesShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["type"] = "aura2",
						["use_track"] = true,
						["duration"] = "1",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 26,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 49,
			["load"] = {
				["use_class"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["DRUID"] = true,
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
			["uid"] = "5Xv9eG7rh3B",
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
			["xOffset"] = -49,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["conditions"] = {
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
			["cooldownTextDisabled"] = true,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Druid - Shred",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 49,
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["url"] = "https://wago.io/HCaWT5tJa/14",
			["displayIcon"] = 132122,
			["cooldown"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Druid - CP2"] = {
			["color"] = {
				0.99607843137255, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -227,
			["anchorPoint"] = "CENTER",
			["url"] = "https://wago.io/HCaWT5tJa/14",
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
						["use_power"] = true,
						["genericShowOn"] = "showOnActive",
						["use_unit"] = true,
						["powertype"] = 4,
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "unit",
						["unevent"] = "auto",
						["power_operator"] = ">=",
						["event"] = "Power",
						["duration"] = "1",
						["names"] = {
						},
						["spellIds"] = {
						},
						["use_requirePowerType"] = false,
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["power"] = "2",
						["unit"] = "player",
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
						["type"] = "item",
						["event"] = "Item Equipped",
						["use_inverse"] = true,
						["unevent"] = "auto",
						["use_itemName"] = true,
						["use_unit"] = true,
						["unit"] = "player",
					},
					["untrigger"] = {
						["itemName"] = 150936,
					},
				}, -- [2]
				["disjunctive"] = "all",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 49,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["discrete_rotation"] = 0,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 30,
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
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["level"] = "70",
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
				["size"] = {
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["use_level"] = false,
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["use_combat"] = true,
				["race"] = {
					["multi"] = {
					},
				},
				["level_operator"] = "<",
			},
			["textureWrapMode"] = "CLAMP",
			["mirror"] = false,
			["regionType"] = "texture",
			["blendMode"] = "BLEND",
			["frameStrata"] = 2,
			["texture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_White",
			["parent"] = "Druid 2.0",
			["rotation"] = 0,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Druid - CP2",
			["animation"] = {
				["start"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["preset"] = "slideright",
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
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["preset"] = "slideleft",
				},
			},
			["alpha"] = 1,
			["width"] = 67,
			["config"] = {
			},
			["uid"] = "fm4HOrzkFYa",
			["authorOptions"] = {
			},
			["anchorFrameType"] = "SCREEN",
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["xOffset"] = -50.999877929688,
		},
		["Warlock - Will of the Forsaken"] = {
			["iconSource"] = 0,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -326.63,
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
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Rend", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["unitExists"] = true,
						["debuffType"] = "HARMFUL",
						["unit"] = "target",
						["type"] = "spell",
						["use_genericShowOn"] = true,
						["subeventSuffix"] = "_CAST_START",
						["names"] = {
						},
						["useName"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Will of the Forsaken",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_unit"] = true,
						["duration"] = "1",
						["spellName"] = 7744,
						["use_track"] = true,
						["ownOnly"] = true,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 12,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_race"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARLOCK",
					["multi"] = {
						["ROGUE"] = true,
					},
				},
				["use_class"] = true,
				["race"] = {
					["single"] = "Scourge",
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "P9GqvS8YXtq",
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
			["parent"] = "Warlock 2.0",
			["regionType"] = "icon",
			["xOffset"] = 106,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["url"] = "https://wago.io/Y8douZITb/12",
			["auto"] = false,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["semver"] = "1.0.11",
			["tocversion"] = 11302,
			["id"] = "Warlock - Will of the Forsaken",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["width"] = 35,
			["cooldownTextDisabled"] = true,
			["config"] = {
			},
			["inverse"] = false,
			["icon"] = true,
			["displayIcon"] = 136187,
			["cooldown"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Druid - Rip"] = {
			["iconSource"] = 0,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -263,
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
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["auranames"] = {
							"Rip", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["spellName"] = 7384,
						["duration"] = "1",
						["useName"] = true,
						["unit"] = "target",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["unevent"] = "auto",
						["event"] = "Cooldown Progress (Spell)",
						["auraspellids"] = {
							"259491", -- [1]
						},
						["realSpellName"] = "Overpower",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["names"] = {
						},
						["type"] = "aura2",
						["use_genericShowOn"] = true,
						["use_track"] = true,
						["debuffType"] = "HARMFUL",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 26,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
				{
					["glowFrequency"] = 0.25,
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
					["useGlowColor"] = false,
					["glow"] = false,
					["glowScale"] = 1,
					["glowThickness"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 49,
			["load"] = {
				["use_class"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["DRUID"] = true,
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
			["uid"] = "YEuFSA(NAUg",
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
			["parent"] = "Druid 2.0",
			["regionType"] = "icon",
			["authorOptions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
							["property"] = "sub.3.glow",
						}, -- [1]
						{
							["property"] = "desaturate",
						}, -- [2]
						{
						}, -- [3]
					},
				}, -- [1]
			},
			["icon"] = true,
			["cooldownTextDisabled"] = true,
			["width"] = 49,
			["zoom"] = 0.3,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Druid - Rip",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["url"] = "https://wago.io/HCaWT5tJa/14",
			["displayIcon"] = 132152,
			["cooldown"] = true,
			["xOffset"] = 0,
		},
		["Druid - War Stomp"] = {
			["iconSource"] = -1,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -327,
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
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Rend", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["unit"] = "target",
						["unitExists"] = true,
						["debuffType"] = "HARMFUL",
						["ownOnly"] = true,
						["type"] = "spell",
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["useName"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "War Stomp",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["spellName"] = 19482,
						["use_genericShowOn"] = true,
						["use_unit"] = true,
						["use_track"] = true,
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_fontType"] = "OUTLINE",
					["text_shadowYOffset"] = 0,
					["anchorXOffset"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_time_format"] = 0,
					["text_text_format_p_format"] = "timed",
					["text_fontSize"] = 12,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_p_time_precision"] = 1,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_race"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["HUNTER"] = true,
						["ROGUE"] = true,
					},
				},
				["use_class"] = true,
				["race"] = {
					["single"] = "Tauren",
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "ee1W0GHGwQK",
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
			["parent"] = "Druid 2.0",
			["regionType"] = "icon",
			["xOffset"] = 106,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["url"] = "https://wago.io/HCaWT5tJa/14",
			["cooldownTextDisabled"] = true,
			["width"] = 35,
			["zoom"] = 0.3,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Druid - War Stomp",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = true,
			["config"] = {
			},
			["inverse"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayIcon"] = 136187,
			["cooldown"] = true,
			["icon"] = true,
		},
		["PST bar"] = {
			["sparkWidth"] = 10,
			["iconSource"] = 0,
			["parent"] = "Professions Skill Tracker",
			["preferToUpdate"] = false,
			["adjustedMin"] = 62,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["zoom"] = 0,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["url"] = "https://wago.io/XvH-Hqsxz/5",
			["actions"] = {
				["start"] = {
					["sound"] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\CatMeow2.ogg",
					["do_sound"] = false,
				},
				["init"] = {
					["custom"] = "function define()\n    local profs = {}\n    local result = {}\n    local loc = GetLocale()\n    local associated_spells_icons = {['spell'] = {'same', 'same', 'same', 'same', 'same', 'same', 'same', 'none', 'same', GetSpellInfo(2656), 'none', 'same'}, ['icon'] = {136240, 136241, 133971, 136244, 136243, 135966, 136245, 133939, 133611, 136248, 134366, 136249}}\n    --- Replace your locale here in exact word-to-word way\n    if loc == 'enUS' or loc== 'enGB'then profs = {'Alchemy', 'Blacksmithing', 'Cooking', 'Enchanting', 'Engineering', 'First Aid', 'Fishing', 'Herbalism', 'Leatherworking','Mining', 'Skinning', 'Tailoring'}\n    elseif loc == 'ruRU' then profs = {'Алхимия', 'Кузнечное дело', 'Кулинария', 'Наложение чар', 'Инженерное дело', 'Первая помощь', 'Рыбная ловля', 'Травничество', 'Кожевничество', 'Горное дело', 'Снятие шкур', 'Портняжное дело'}\n    elseif loc == 'deDE' then profs = {'Alchemie', 'Schmiedekunst', 'Kochkunst', 'Verzauberkunst', 'Ingenieurskunst', 'Erste Hilfe', 'Angeln', 'Kräuterkunde', 'Lederverarbeitung','Bergbau', 'Kürschnerei', 'Schneiderei'}\n    elseif loc == 'frFR' then profs = {'Alchimie', 'Forge', 'Cuisine', 'Enchantement', 'Ingénierie', 'Secourisme', 'Pêche', 'Herboristerie', 'Travail du cuir','Minage', 'Dépeçage', 'Couture'}\n    end\n    \n    for i, val in ipairs(profs) do\n        --print(val)        \n        if associated_spells_icons['spell'][i] == 'same' then            \n            result[val] =  {['spell'] = val, ['icon'] = associated_spells_icons['icon'][i]}\n        elseif associated_spells_icons['spell'][i] == 'none' then\n            result[val] =  {['spell'] = 'none', ['icon'] = associated_spells_icons['icon'][i]}\n        else result[val] = {['spell'] = associated_spells_icons['spell'][i], ['icon'] = associated_spells_icons['icon'][i]}\n        end\n    end\n    return result\nend\n\naura_env.pst_btns = aura_env.pst_btns or {}\naura_env.pst_profs = aura_env.pst_profs or define()",
					["do_custom"] = true,
				},
				["finish"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["subeventSuffix"] = "_CAST_START",
						["custom_hide"] = "timed",
						["event"] = "Health",
						["names"] = {
						},
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["custom"] = "function(allstates, event, ...)\n    if event == \"OPTIONS\" then return false end\n    if event == \"CHAT_MSG_SKILL\" or event == \"SKILL_LINES_CHANGED\" then\n        local btns = aura_env.pst_btns\n        local profs = aura_env.pst_profs\n        for i=1,GetNumSkillLines() do\n            local skillName, isHeader, isExpanded, skillRank, numTempPoints, skillModifier,\n            skillMaxRank, isAbandonable, stepCost, rankCost, minLevel, skillCostType, skillDescription = GetSkillLineInfo(i)\n            if profs[skillName] and profs[skillName]['spell'] then\n                allstates[skillName] = allstates[skillName] or {}\n                local state = allstates[skillName] \n                if state.value == skillRank and state.total == skillMaxRank then state.changed = false\n                else\n                    state.name = skillName\n                    state.value = skillRank\n                    state.progressType = 'static'\n                    state.total = skillMaxRank\n                    state.custom = skillRank .. \" / \" .. skillMaxRank\n                    state.index = i\n                    --state.autoHide = true\n                    state.animation = true\n                    state.show = true\n                    state.changed = true\n                end\n            end \n        end\n--        C_Timer.After(3, function()\n--                for clId, clRegion in pairs(WeakAuras.clones['PST bar']) do\n--                    if not btns[clId] then            \n--                        btns[clId] = CreateFrame(\"Button\", nil, UIParent, \"SecureActionButtonTemplate\")            \n--                        btns[clId]:SetNormalTexture(profs[clId]['icon'])\n--                        if profs[clId]['spell'] ~= 'none' then\n--                            btns[clId]:SetAttribute(\"type\", \"spell\")\n--                            btns[clId]:SetAttribute(\"spell\", profs[clId]['spell'])\n--                        end\n--                    end\n--                    local point, relativeTo, relativePoint, xOfs, yOfs = clRegion:GetPoint()\n--                    btns[clId]:SetPoint(point, relativeTo, relativePoint, xOfs-30, yOfs+15)\n--                    btns[clId]:SetWidth(clRegion:GetHeight()+15)\n--                    btns[clId]:SetHeight(clRegion:GetHeight()+15)\n--                end\n--        end)\n    end\n    return true\nend",
						["events"] = "CHAT_MSG_SKILL, SKILL_LINES_CHANGED",
						["check"] = "event",
						["spellIds"] = {
						},
						["custom_type"] = "stateupdate",
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
			["useTooltip"] = true,
			["xOffset"] = 0,
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
					["colorA"] = 1,
					["use_color"] = true,
					["alpha"] = 0,
					["preset"] = "shrink",
					["y"] = 0,
					["x"] = 0,
					["rotate"] = 0,
					["duration_type"] = "seconds",
					["colorFunc"] = "    function(progress, r1, g1, b1, a1, r2, g2, b2, a2)\n      local angle = (progress * 2 * math.pi) - (math.pi / 2)\n      local newProgress = ((math.sin(angle) + 1)/2);\n      return r1 + (newProgress * (r2 - r1)),\n           g1 + (newProgress * (g2 - g1)),\n           b1 + (newProgress * (b2 - b1)),\n           a1 + (newProgress * (a2 - a1))\n    end\n  ",
					["easeStrength"] = 3,
					["colorType"] = "pulseColor",
					["scaley"] = 1,
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
					["duration"] = "",
					["easeType"] = "none",
					["colorType"] = "custom",
					["scaley"] = 1,
					["alpha"] = 0,
					["rotate"] = 0,
					["y"] = 0,
					["x"] = 0,
					["preset"] = "alphaPulse",
					["use_color"] = true,
					["colorFunc"] = "function(progress, r1, g1, b1, a1, r2, g2, b2, a2)    \n    if aura_env.state.animation then\n        local angle = (progress *  2 * math.pi) - (math.pi / 2)\n        local newProgress = ((math.sin(angle) + 1)/2);\n        if newProgress == 0 then aura_env.state.animation = false end\n        return r1 + (newProgress * (r2 - r1)), g1 + (newProgress * (g2 - g1)), b1 + (newProgress * (b2 - b1)), a1 + (newProgress * (a2 - a1))\n    end    \nend",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["colorA"] = 1,
				},
				["finish"] = {
					["colorR"] = 1,
					["scalex"] = 1,
					["colorA"] = 1,
					["colorG"] = 0.10196078431373,
					["type"] = "none",
					["colorB"] = 0,
					["easeType"] = "none",
					["colorType"] = "pulseColor",
					["scaley"] = 1,
					["alpha"] = 0,
					["rotate"] = 0,
					["y"] = 0,
					["x"] = 0,
					["duration_type"] = "seconds",
					["duration"] = "2",
					["colorFunc"] = "    function(progress, r1, g1, b1, a1, r2, g2, b2, a2)\n      local angle = (progress * 2 * math.pi) - (math.pi / 2)\n      local newProgress = ((math.sin(angle) + 1)/2);\n      return r1 + (newProgress * (r2 - r1)),\n           g1 + (newProgress * (g2 - g1)),\n           b1 + (newProgress * (b2 - b1)),\n           a1 + (newProgress * (a2 - a1))\n    end\n  ",
					["easeStrength"] = 3,
					["preset"] = "grow",
					["use_color"] = true,
				},
			},
			["authorOptions"] = {
			},
			["displayIcon"] = 136000,
			["barColor"] = {
				0, -- [1]
				0.65882352941177, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["icon"] = false,
			["selfPoint"] = "CENTER",
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
					["text_anchorYOffset"] = 12,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "RIGHT",
					["text_fontType"] = "None",
					["text_shadowYOffset"] = -1,
					["text_fontSize"] = 10,
					["anchorXOffset"] = 0,
					["text_text_format_custom_format"] = "none",
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
					["text_visible"] = true,
					["text_anchorYOffset"] = 12,
					["text_fontSize"] = 10,
					["anchorXOffset"] = 0,
					["text_text_format_n_format"] = "none",
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
			["adjustedMax"] = 51,
			["load"] = {
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
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["sparkOffsetY"] = 0,
			["anchorFrameType"] = "SCREEN",
			["alpha"] = 1,
			["icon_side"] = "LEFT",
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["id"] = "PST bar",
			["auto"] = false,
			["sparkDesaturate"] = false,
			["spark"] = true,
			["sparkHeight"] = 10,
			["texture"] = "Glamour2",
			["uid"] = "dfN5x1GBI6G",
			["sparkTexture"] = "Legionfall_BarSpark",
			["semver"] = "1.0.4",
			["tocversion"] = 11302,
			["sparkHidden"] = "NEVER",
			["backgroundColor"] = {
				0.031372549019608, -- [1]
				0.39607843137255, -- [2]
				0.79607843137255, -- [3]
				0.3313250541687, -- [4]
			},
			["frameStrata"] = 1,
			["width"] = 200,
			["color"] = {
			},
			["config"] = {
			},
			["inverse"] = false,
			["internalVersion"] = 49,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["sparkOffsetX"] = 0,
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
						["names"] = {
						},
						["unevent"] = "auto",
						["unit"] = "player",
						["use_unit"] = true,
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
						["duration"] = "1",
						["use_itemName"] = true,
						["use_unit"] = true,
						["use_includeBank"] = false,
						["type"] = "item",
						["count"] = "0",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Item Count",
						["subeventPrefix"] = "SPELL",
						["unit"] = "player",
						["count_operator"] = "==",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["customTriggerLogic"] = "",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 49,
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
					["glowScale"] = 1,
					["glowThickness"] = 1,
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
				["level_operator"] = ">=",
				["use_class"] = false,
				["use_spellknown"] = false,
				["size"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["level"] = "48",
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["MAGE"] = true,
					},
				},
				["zoneIds"] = "",
			},
			["authorMode"] = true,
			["uid"] = "fPDDaU)G8Wc",
			["parent"] = "GEMS",
			["selfPoint"] = "CENTER",
			["regionType"] = "icon",
			["icon"] = true,
			["cooldown"] = false,
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
			["authorOptions"] = {
				{
					["subOptions"] = {
						{
							["type"] = "input",
							["useDesc"] = false,
							["width"] = 1,
							["name"] = "Text",
							["default"] = "",
							["key"] = "text",
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
					["collapse"] = false,
					["type"] = "group",
					["limitType"] = "none",
					["groupType"] = "simple",
					["key"] = "macro",
					["size"] = 10,
				}, -- [1]
			},
			["cooldownTextDisabled"] = false,
			["width"] = 40,
			["zoom"] = 0,
			["auto"] = true,
			["tocversion"] = 11304,
			["id"] = "Citrine",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["semver"] = "1.0.0",
			["config"] = {
				["macro"] = {
					["text"] = "/cast Conjure Mana Citrine",
				},
			},
			["inverse"] = false,
			["cooldownEdge"] = false,
			["displayIcon"] = 134116,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Warrior - Bloodrage"] = {
			["iconSource"] = 0,
			["xOffset"] = 36,
			["preferToUpdate"] = false,
			["yOffset"] = -155.78,
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
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Rend", -- [1]
						},
						["ownOnly"] = true,
						["genericShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["unitExists"] = true,
						["spellName"] = 2687,
						["use_unit"] = true,
						["type"] = "spell",
						["debuffType"] = "HARMFUL",
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "target",
						["useName"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Bloodrage",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["names"] = {
						},
						["use_genericShowOn"] = true,
						["duration"] = "1",
						["use_track"] = true,
						["matchesShowOn"] = "showAlways",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 16,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_class"] = true,
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
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "iZvKn8lfu2K",
			["icon"] = true,
			["authorOptions"] = {
			},
			["regionType"] = "icon",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["parent"] = "Warrior 2.0",
			["cooldownTextDisabled"] = true,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["semver"] = "1.0.15",
			["tocversion"] = 11302,
			["id"] = "Warrior - Bloodrage",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 35,
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["url"] = "https://wago.io/z6xqQay0S/16",
			["displayIcon"] = 132277,
			["cooldown"] = true,
			["selfPoint"] = "CENTER",
		},
		["nanShield:Bar"] = {
			["sparkWidth"] = 10,
			["sparkOffsetX"] = 0,
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["url"] = "https://wago.io/TPKPLjUo4/1",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "1",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "custom",
						["unevent"] = "timed",
						["custom_hide"] = "custom",
						["customOverlay1"] = "",
						["event"] = "Chat Message",
						["custom_type"] = "stateupdate",
						["names"] = {
						},
						["spellIds"] = {
						},
						["custom"] = "function(...)\n  return aura_env:on_tsu(...)\nend",
						["events"] = "WA_NAN_SHIELD",
						["check"] = "event",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["customVariables"] = "{\n    additionalProgress = 9,\n    school = {\n        type = \"select\",\n        display = \"Damage Type\",\n        values = {\n            [\"All\"] = \"All\",\n            [\"Physical\"] = \"Physical\",\n            [\"Magic\"] = \"Magic\",\n            [\"Holy\"] = \"Holy\",\n            [\"Fire\"] = \"Fire\",\n            [\"Nature\"] = \"Nature\",\n            [\"Frost\"] = \"Frost\",\n            [\"Shadow\"] = \"Shadow\",\n            [\"Arcane\"] = \"Arcane\"\n        }\n    }\n}",
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
			["internalVersion"] = 49,
			["selfPoint"] = "CENTER",
			["sparkHidden"] = "NEVER",
			["barColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["authorOptions"] = {
				{
					["type"] = "toggle",
					["key"] = "isHealthPct",
					["desc"] = "When enabled, the bar's total will be set to player's max health",
					["default"] = false,
					["useDesc"] = true,
					["name"] = "Show as %HP",
					["width"] = 1,
				}, -- [1]
				{
					["useName"] = false,
					["text"] = "",
					["type"] = "header",
					["width"] = 1,
				}, -- [2]
				{
					["type"] = "toggle",
					["name"] = "Enable Debug Info",
					["default"] = false,
					["useDesc"] = false,
					["key"] = "debugEnabled",
					["width"] = 1,
				}, -- [3]
			},
			["iconSource"] = -1,
			["version"] = 1,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subforeground",
				}, -- [2]
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
					["text_font"] = "FORCED SQUARE",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "THICKOUTLINE",
					["text_anchorPoint"] = "INNER_CENTER",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_visible"] = true,
				}, -- [3]
			},
			["height"] = 20,
			["parent"] = "Shield",
			["load"] = {
				["use_class"] = false,
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
					["single"] = "MAGE",
					["multi"] = {
						["MAGE"] = true,
						["PRIEST"] = true,
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
			["overlays"] = {
				{
					0.94901960784314, -- [1]
					0.89411764705882, -- [2]
					0.56078431372549, -- [3]
					1, -- [4]
				}, -- [1]
				{
					0.9921568627451, -- [1]
					0.7921568627451, -- [2]
					0.63529411764706, -- [3]
					1, -- [4]
				}, -- [2]
				{
					0, -- [1]
					0.50196078431373, -- [2]
					1, -- [3]
					1, -- [4]
				}, -- [3]
				{
					1, -- [1]
					1, -- [2]
					0, -- [3]
					1, -- [4]
				}, -- [4]
				{
					1, -- [1]
					0.50196078431373, -- [2]
					0, -- [3]
					1, -- [4]
				}, -- [5]
				{
					0.50196078431373, -- [1]
					1, -- [2]
					0, -- [3]
					1, -- [4]
				}, -- [6]
				{
					0, -- [1]
					1, -- [2]
					1, -- [3]
					1, -- [4]
				}, -- [7]
			},
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["custom"] = "function aura_env:on_tsu(allstates, event, ...)\n    self:log(event, ...)\n    local changed = false\n    local state = allstates[1] or {\n        show = true,\n        changed = true,\n        progressType = 'static',\n        value = 0,\n        total = 0,\n        stacks = 0,\n        additionalProgress = {\n            {}, {}, {},\n            {}, {}, {},\n            {}, {}, {},\n        }\n    }\n    allstates[1] = state\n\n    if event == 'WA_NAN_SHIELD' and select(1, ...) then\n        local value, school\n        local minValue, totalAbsorb, minIdx = self:LowestAbsorb(...)\n        minValue = ceil(minValue)\n        totalAbsorb = ceil(totalAbsorb)\n\n        if self.config.isHealthPct then\n            totalAbsorb = UnitHealthMax(\"player\")\n        end\n\n        changed = changed or state.total ~= totalAbsorb\n        changed = changed or state.stacks ~= minValue\n        changed = changed or state.show ~= (minValue > 0)\n        state.show = minValue > 0\n        state.total = totalAbsorb\n        state.stacks = minValue\n        state.school = self.schools[minIdx]\n\n        local progressOffset = 0\n        for i, ap in ipairs(state.additionalProgress) do\n            value = select(i + 1, ...)\n            school = self.schools[i]\n            self:log('Set', school, value)\n            changed = changed or ap.width ~= value\n            ap.min = progressOffset\n            ap.max = progressOffset + value\n            ap.school = school\n            progressOffset = progressOffset + value\n        end\n\n        allstates[1].changed = changed\n    end\n    return changed\nend\naura_env.logPalette = {\n    \"ff6e7dda\",\n    \"ff21dfb9\",\n    \"ffe3f57a\",\n    \"ffed705a\",\n    \"fff8a3e6\",\n}\n\nfunction aura_env:log(...)\n    if self.config and self.config.debugEnabled then\n        local palette = self.logPalette\n        local args = {\n            self.cloneId and\n            format(\"[%s:%s]\", self.id, self.cloneId) or\n            format(\"[%s]\", self.id),\n            ...\n        }\n        for i = 1, #args do\n            args[i] = format(\n                \"|c%s%s|r\",\n                palette[1 + (i - 1) % #palette],\n                tostring(args[i]))\n        end\n        print(unpack(args))\n    end\nend\nfunction aura_env:LowestAbsorb(totalAbsorb, all, physical, magic, ...)\n    self:log('LowestAbsorb', all, physical, magic, ...)\n    local minValue\n    local minIdx\n    local value\n\n    for i = 1, select('#', ...) do\n        value = select(i, ...)\n        if value > 0 and value <= (minValue or value) then\n            minIdx = i + 3\n            minValue = value\n        end\n    end\n\n    if minIdx then\n        minValue = minValue + magic\n    elseif magic > 0 then\n        minValue = magic\n        minIdx = 3\n    end\n\n    if physical > 0 and physical <= (minValue or physical) then\n        minValue = physical\n        minIdx = 2\n    end\n\n    if minIdx then\n        minValue = minValue + all\n    else\n        minValue = all\n        minIdx = 1\n    end\n\n    self:log('LowestAbsorbResult', minValue, totalAbsorb, minIdx)\n    return minValue, totalAbsorb, minIdx\nend\naura_env.schools = {\n    \"All\",\n    \"Physical\",\n    \"Magic\",\n    \"Holy\",\n    \"Fire\",\n    \"Nature\",\n    \"Frost\",\n    \"Shadow\",\n    \"Arcane\",\n}\naura_env.schoolIds = { 127, 1, 126, 2, 4, 8, 16, 32, 64 }\naura_env.schoolIdx = {}\nfor idx, id in ipairs(aura_env.schoolIds) do\n    aura_env.schoolIdx[id] = idx\nend\n",
					["do_custom"] = true,
				},
				["finish"] = {
				},
			},
			["icon"] = false,
			["config"] = {
				["isHealthPct"] = false,
				["debugEnabled"] = false,
			},
			["auto"] = true,
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["width"] = 200,
			["alpha"] = 1,
			["icon_side"] = "RIGHT",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["overlayclip"] = false,
			["texture"] = "Glamour2",
			["semver"] = "1.0.0",
			["zoom"] = 0,
			["spark"] = false,
			["tocversion"] = 11305,
			["id"] = "nanShield:Bar",
			["sparkHeight"] = 30,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["uid"] = "nNYjECvELIW",
			["inverse"] = false,
			["sparkOffsetY"] = 0,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "All",
						["variable"] = "school",
					},
					["changes"] = {
						{
							["value"] = {
								0.94901960784314, -- [1]
								0.89411764705882, -- [2]
								0.56078431372549, -- [3]
								1, -- [4]
							},
							["property"] = "sub.3.text_color",
						}, -- [1]
					},
				}, -- [1]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "school",
						["value"] = "Magic",
					},
					["changes"] = {
						{
							["value"] = {
								0, -- [1]
								0.50196078431373, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["property"] = "sub.3.text_color",
						}, -- [1]
					},
				}, -- [2]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "Physical",
						["variable"] = "school",
					},
					["changes"] = {
						{
							["value"] = {
								0.9921568627451, -- [1]
								0.7921568627451, -- [2]
								0.63529411764706, -- [3]
								1, -- [4]
							},
							["property"] = "sub.3.text_color",
						}, -- [1]
					},
				}, -- [3]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "Arcane",
						["variable"] = "school",
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								0.61176470588235, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["property"] = "sub.3.text_color",
						}, -- [1]
					},
				}, -- [4]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "Fire",
						["variable"] = "school",
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								0.50196078431373, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["property"] = "sub.3.text_color",
						}, -- [1]
					},
				}, -- [5]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "Frost",
						["variable"] = "school",
					},
					["changes"] = {
						{
							["value"] = {
								0, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["property"] = "sub.3.text_color",
						}, -- [1]
					},
				}, -- [6]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "school",
						["value"] = "Holy",
					},
					["changes"] = {
						{
							["value"] = {
								1, -- [1]
								1, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["property"] = "sub.3.text_color",
						}, -- [1]
					},
				}, -- [7]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "Nature",
						["variable"] = "school",
					},
					["changes"] = {
						{
							["value"] = {
								0.50196078431373, -- [1]
								1, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["property"] = "sub.3.text_color",
						}, -- [1]
					},
				}, -- [8]
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "Shadow",
						["variable"] = "school",
					},
					["changes"] = {
						{
							["value"] = {
								0.72941176470588, -- [1]
								0.45882352941177, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["property"] = "sub.3.text_color",
						}, -- [1]
					},
				}, -- [9]
			},
			["information"] = {
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
		["Warrior  - Blood Fury"] = {
			["iconSource"] = 0,
			["parent"] = "Warrior 2.0",
			["preferToUpdate"] = false,
			["yOffset"] = -155.78,
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
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Rend", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["use_unit"] = true,
						["unitExists"] = true,
						["debuffType"] = "HARMFUL",
						["unit"] = "target",
						["useName"] = true,
						["matchesShowOn"] = "showAlways",
						["subeventSuffix"] = "_CAST_START",
						["ownOnly"] = true,
						["type"] = "spell",
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Blood Fury",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["spellName"] = 20572,
						["use_genericShowOn"] = true,
						["use_track"] = true,
						["names"] = {
						},
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 16,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_race"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
						["ROGUE"] = true,
					},
				},
				["use_class"] = true,
				["race"] = {
					["single"] = "Orc",
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "7GXCvVYSDjH",
			["url"] = "https://wago.io/z6xqQay0S/16",
			["xOffset"] = 106,
			["regionType"] = "icon",
			["selfPoint"] = "CENTER",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["icon"] = true,
			["cooldownTextDisabled"] = true,
			["width"] = 35,
			["zoom"] = 0.3,
			["auto"] = false,
			["tocversion"] = 11302,
			["id"] = "Warrior  - Blood Fury",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["semver"] = "1.0.15",
			["config"] = {
			},
			["inverse"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayIcon"] = 135726,
			["cooldown"] = true,
			["authorOptions"] = {
			},
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
						["unevent"] = "auto",
						["unit"] = "player",
						["use_unit"] = true,
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
						["duration"] = "1",
						["use_itemName"] = true,
						["unit"] = "player",
						["use_includeBank"] = false,
						["itemName"] = 5513,
						["count"] = "0",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Item Count",
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["count_operator"] = "==",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["customTriggerLogic"] = "",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 49,
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
					["glowScale"] = 1,
					["glowThickness"] = 1,
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
				["level_operator"] = ">=",
				["use_class"] = false,
				["use_spellknown"] = false,
				["size"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["level"] = "18",
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["MAGE"] = true,
					},
				},
				["zoneIds"] = "",
			},
			["authorMode"] = true,
			["uid"] = "ToLYidE5fIK",
			["parent"] = "GEMS",
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
			["authorOptions"] = {
				{
					["subOptions"] = {
						{
							["type"] = "input",
							["useDesc"] = false,
							["width"] = 1,
							["name"] = "Text",
							["default"] = "",
							["key"] = "text",
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
					["collapse"] = false,
					["type"] = "group",
					["limitType"] = "none",
					["groupType"] = "simple",
					["key"] = "macro",
					["size"] = 10,
				}, -- [1]
			},
			["cooldown"] = false,
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
			["cooldownEdge"] = false,
			["cooldownTextDisabled"] = false,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0,
			["auto"] = true,
			["tocversion"] = 11304,
			["id"] = "Jade",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 40,
			["semver"] = "1.0.0",
			["config"] = {
				["macro"] = {
					["text"] = "/cast Conjure Mana Jade",
				},
			},
			["inverse"] = false,
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
			["displayIcon"] = 134105,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Priest - Perception"] = {
			["iconSource"] = 0,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -327,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/R8xGfpcxa/14",
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
							"Rend", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["unit"] = "target",
						["unitExists"] = true,
						["spellName"] = 20600,
						["duration"] = "1",
						["type"] = "spell",
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["useName"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Perception",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_unit"] = true,
						["use_genericShowOn"] = true,
						["ownOnly"] = true,
						["use_track"] = true,
						["debuffType"] = "HARMFUL",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_race"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "PRIEST",
					["multi"] = {
						["ROGUE"] = true,
					},
				},
				["use_class"] = true,
				["race"] = {
					["single"] = "Human",
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "4q3gB4K7Rcr",
			["cooldownEdge"] = false,
			["icon"] = true,
			["regionType"] = "icon",
			["authorOptions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["xOffset"] = 106,
			["cooldownTextDisabled"] = true,
			["width"] = 35,
			["zoom"] = 0.3,
			["auto"] = false,
			["tocversion"] = 11302,
			["id"] = "Priest - Perception",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["semver"] = "1.0.13",
			["config"] = {
			},
			["inverse"] = false,
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
			["displayIcon"] = 136090,
			["cooldown"] = true,
			["parent"] = "Priest 2.0",
		},
		["Warlock - Nightfall Proc"] = {
			["outline"] = "OUTLINE",
			["xOffset"] = 0,
			["displayText"] = "NIGHTFALL\n",
			["yOffset"] = -221.00009155273,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/Y8douZITb/12",
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
						["useName"] = true,
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["spellIds"] = {
						},
						["type"] = "aura2",
						["auranames"] = {
							"Shadow Trance", -- [1]
						},
						["unit"] = "player",
						["names"] = {
						},
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["animation"] = {
				["start"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["preset"] = "fade",
				},
				["main"] = {
					["type"] = "none",
					["easeType"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["preset"] = "bounce",
				},
				["finish"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["preset"] = "fade",
				},
			},
			["desaturate"] = false,
			["rotation"] = 0,
			["font"] = "Vixar",
			["version"] = 12,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 400,
			["rotate"] = true,
			["load"] = {
				["use_class"] = true,
				["zoneIds"] = "",
				["talent"] = {
					["single"] = 11,
					["multi"] = {
						[11] = true,
					},
				},
				["use_talent"] = true,
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARLOCK",
					["multi"] = {
						["WARLOCK"] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["config"] = {
			},
			["fontSize"] = 31,
			["wordWrap"] = "WordWrap",
			["shadowXOffset"] = 1,
			["preferToUpdate"] = false,
			["mirror"] = false,
			["color"] = {
				0.50980392156863, -- [1]
				0.074509803921569, -- [2]
				0.74509803921569, -- [3]
				1, -- [4]
			},
			["regionType"] = "text",
			["conditions"] = {
			},
			["blendMode"] = "ADD",
			["discrete_rotation"] = 0,
			["shadowYOffset"] = -1,
			["texture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura4",
			["automaticWidth"] = "Auto",
			["width"] = 400,
			["semver"] = "1.0.11",
			["tocversion"] = 11302,
			["id"] = "Warlock - Nightfall Proc",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["justify"] = "LEFT",
			["uid"] = "qsj48Npc6ke",
			["parent"] = "Warlock 2.0",
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["selfPoint"] = "CENTER",
		},
		["Priest - Desperate Prayer"] = {
			["iconSource"] = 0,
			["xOffset"] = 71,
			["preferToUpdate"] = false,
			["yOffset"] = -327,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/R8xGfpcxa/14",
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
						["track"] = "auto",
						["auranames"] = {
							"Rend", -- [1]
						},
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showAlways",
						["use_unit"] = true,
						["unitExists"] = true,
						["ownOnly"] = true,
						["spellName"] = 19338,
						["matchesShowOn"] = "showAlways",
						["useName"] = true,
						["duration"] = "1",
						["subeventSuffix"] = "_CAST_START",
						["debuffType"] = "HARMFUL",
						["subeventPrefix"] = "SPELL",
						["event"] = "Cooldown Progress (Spell)",
						["use_exact_spellName"] = false,
						["realSpellName"] = 19338,
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["names"] = {
						},
						["unevent"] = "auto",
						["type"] = "spell",
						["use_track"] = true,
						["unit"] = "target",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
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
						["subeventPrefix"] = "SPELL",
						["unevent"] = "auto",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_race"] = false,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "PRIEST",
					["multi"] = {
						["SHAMAN"] = true,
					},
				},
				["use_class"] = true,
				["race"] = {
					["multi"] = {
						["Dwarf"] = true,
						["Human"] = true,
					},
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "8DPj9t)n8zF",
			["cooldownEdge"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["parent"] = "Priest 2.0",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["icon"] = true,
			["zoom"] = 0.3,
			["width"] = 35,
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Priest - Desperate Prayer",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["authorOptions"] = {
			},
			["displayIcon"] = 135954,
			["cooldown"] = true,
			["selfPoint"] = "CENTER",
		},
		["Warrior - Execute"] = {
			["iconSource"] = -1,
			["parent"] = "Warrior 2.0",
			["preferToUpdate"] = false,
			["yOffset"] = -75,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["auranames"] = {
							"2687    ", -- [1]
						},
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showAlways",
						["use_unit"] = true,
						["unitExists"] = true,
						["names"] = {
						},
						["use_track"] = true,
						["duration"] = "1",
						["useName"] = true,
						["subeventSuffix"] = "_CAST_START",
						["spellName"] = 5308,
						["spellIds"] = {
						},
						["type"] = "spell",
						["use_health"] = false,
						["health_operator"] = "<=",
						["subeventPrefix"] = "SPELL",
						["percenthealth"] = "20",
						["event"] = "Action Usable",
						["debuffType"] = "HELPFUL",
						["realSpellName"] = "Execute",
						["use_spellName"] = true,
						["health"] = "20",
						["unevent"] = "auto",
						["unit"] = "target",
						["use_percenthealth"] = true,
						["percenthealth_operator"] = "<=",
						["matchesShowOn"] = "showAlways",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "spell",
						["subeventSuffix"] = "_CAST_START",
						["use_genericShowOn"] = true,
						["duration"] = "1",
						["event"] = "Cooldown Progress (Spell)",
						["unit"] = "player",
						["realSpellName"] = "Execute",
						["use_spellName"] = true,
						["unevent"] = "auto",
						["use_unit"] = true,
						["genericShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["use_track"] = true,
						["spellName"] = 5308,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [2]
				["disjunctive"] = "custom",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 16,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["glowFrequency"] = 0,
					["type"] = "subglow",
					["useGlowColor"] = true,
					["glowType"] = "Pixel",
					["glowLength"] = 6.4,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["glow"] = true,
					["glowScale"] = 1,
					["glowThickness"] = 1.9,
					["glowLines"] = 13,
					["glowBorder"] = false,
				}, -- [2]
			},
			["height"] = 49,
			["load"] = {
				["use_class"] = true,
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
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "2xCNeTbV9v8",
			["xOffset"] = 50,
			["authorOptions"] = {
			},
			["regionType"] = "icon",
			["url"] = "https://wago.io/z6xqQay0S/16",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 2,
						["op"] = "<=",
						["value"] = 1,
						["variable"] = "spellUsable",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "sub.2.glow",
						}, -- [1]
					},
				}, -- [1]
			},
			["selfPoint"] = "CENTER",
			["cooldownTextDisabled"] = true,
			["width"] = 49,
			["zoom"] = 0.3,
			["semver"] = "1.0.15",
			["tocversion"] = 11302,
			["id"] = "Warrior - Execute",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = true,
			["config"] = {
			},
			["inverse"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayIcon"] = 136188,
			["cooldown"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
		},
		["Warrior - Thunderclap"] = {
			["iconSource"] = 0,
			["parent"] = "Warrior 2.0",
			["preferToUpdate"] = false,
			["yOffset"] = -75,
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
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["auranames"] = {
							"Blood Fury", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["unitExists"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "spell",
						["unit"] = "player",
						["unevent"] = "auto",
						["names"] = {
						},
						["spellName"] = 6343,
						["event"] = "Cooldown Progress (Spell)",
						["duration"] = "1",
						["realSpellName"] = "Thunder Clap",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["use_genericShowOn"] = true,
						["use_unit"] = true,
						["use_track"] = true,
						["useName"] = true,
					},
					["untrigger"] = {
						["track"] = "auto",
						["genericShowOn"] = "showAlways",
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
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["unevent"] = "auto",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 16,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 26,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 49,
			["load"] = {
				["use_level"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["use_class"] = true,
				["race"] = {
					["single"] = "Troll",
					["multi"] = {
						["Troll"] = true,
					},
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["level"] = "36",
				["level_operator"] = ">=",
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "6zKJiIZ3hei",
			["icon"] = true,
			["url"] = "https://wago.io/z6xqQay0S/16",
			["regionType"] = "icon",
			["selfPoint"] = "CENTER",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
						}, -- [2]
					},
				}, -- [1]
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["zoom"] = 0.3,
			["width"] = 49,
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.15",
			["tocversion"] = 11302,
			["id"] = "Warrior - Thunderclap",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["authorOptions"] = {
			},
			["displayIcon"] = 136105,
			["cooldown"] = true,
			["xOffset"] = 99,
		},
		["Druid - Energy Bar"] = {
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
			["yOffset"] = -298.03799438477,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["url"] = "https://wago.io/HCaWT5tJa/14",
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
			["fontFlags"] = "OUTLINE",
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["selfPoint"] = "CENTER",
			["barColor"] = {
				1, -- [1]
				0.82352941176471, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["sparkOffsetY"] = 0,
			["load"] = {
				["size"] = {
					["multi"] = {
					},
				},
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
						["DRUID"] = true,
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
				["use_class"] = true,
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
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["texture"] = "Glamour2",
			["zoom"] = 0,
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
			["parent"] = "Druid 2.0",
			["customText"] = "function()\n    if aura_env.region then\n        local energy = UnitPower(\"player\", Enum.PowerType.Energy)\n        aura_env.region.text3:SetText(energy)\n    end\nend\n\n\n\n\n\n\n\n\n\n\n\n",
			["customTextUpdate"] = "event",
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
						["use_showCost"] = true,
						["type"] = "unit",
						["use_health"] = true,
						["unevent"] = "auto",
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["use_requirePowerType"] = true,
						["use_percentpower"] = false,
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Power",
						["health"] = "0",
						["spellIds"] = {
						},
						["debuffType"] = "HELPFUL",
						["unit"] = "player",
						["health_operator"] = ">=",
						["use_power"] = false,
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "all",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
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
					["text_shadowXOffset"] = 1,
					["text_text"] = "%c ",
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
					["text_font"] = "Vixar",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "INNER_RIGHT",
					["text_fontSize"] = 15,
					["anchorXOffset"] = 0,
					["text_fontType"] = "None",
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
					["text_font"] = "Vixar",
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
					["text_font"] = "Vixar",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "ICON_CENTER",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_fontType"] = "None",
				}, -- [5]
				{
					["type"] = "subborder",
					["border_anchor"] = "bar",
					["border_offset"] = 1,
					["border_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["border_visible"] = true,
					["border_edge"] = "1 Pixel",
					["border_size"] = 1,
				}, -- [6]
			},
			["height"] = 20,
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["sparkWidth"] = 10,
			["config"] = {
			},
			["xOffset"] = 0.0003662109375,
			["borderInFront"] = true,
			["sparkRotationMode"] = "AUTO",
			["icon_side"] = "RIGHT",
			["icon"] = false,
			["backgroundColor"] = {
				1, -- [1]
				0.82352941176471, -- [2]
				0, -- [3]
				0.30000001192093, -- [4]
			},
			["sparkHeight"] = 30,
			["borderBackdrop"] = "None",
			["overlaysTexture"] = {
				"Glamour2", -- [1]
			},
			["width"] = 245,
			["semver"] = "1.0.13",
			["backdropColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["id"] = "Druid - Energy Bar",
			["sparkHidden"] = "NEVER",
			["frameStrata"] = 3,
			["anchorFrameType"] = "SCREEN",
			["uid"] = "c5D6XJKEyid",
			["spark"] = false,
			["inverse"] = false,
			["sparkDesature"] = false,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
		},
		["Priest - Devouring Plague"] = {
			["iconSource"] = 0,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -327,
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
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["auranames"] = {
							"Devouring Plague", -- [1]
						},
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showAlways",
						["use_unit"] = true,
						["unitExists"] = true,
						["matchesShowOn"] = "showAlways",
						["debuffType"] = "HARMFUL",
						["unit"] = "target",
						["type"] = "aura2",
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["useName"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["use_exact_spellName"] = false,
						["realSpellName"] = "Devouring Plague",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["ownOnly"] = true,
						["unevent"] = "auto",
						["spellName"] = 19280,
						["use_track"] = true,
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
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
						["subeventPrefix"] = "SPELL",
						["unevent"] = "auto",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_race"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "PRIEST",
					["multi"] = {
						["SHAMAN"] = true,
					},
				},
				["use_class"] = true,
				["race"] = {
					["single"] = "Scourge",
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "XmCkO5TdaXO",
			["selfPoint"] = "CENTER",
			["url"] = "https://wago.io/R8xGfpcxa/14",
			["regionType"] = "icon",
			["authorOptions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["xOffset"] = 71,
			["cooldownTextDisabled"] = true,
			["width"] = 35,
			["zoom"] = 0.3,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Priest - Devouring Plague",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["icon"] = true,
			["displayIcon"] = 136123,
			["cooldown"] = true,
			["parent"] = "Priest 2.0",
		},
		["Unstable govno"] = {
			["iconSource"] = -1,
			["wagoID"] = "pw_hjyCcX",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = 60,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = true,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["useName"] = true,
						["use_debuffClass"] = false,
						["useExactSpellId"] = false,
						["subeventPrefix"] = "SPELL",
						["event"] = "Health",
						["unit"] = "player",
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["spellIds"] = {
						},
						["auraspellids"] = {
						},
						["combineMode"] = "showHighest",
						["auranames"] = {
							"30108", -- [1]
						},
						["type"] = "aura2",
						["debuffType"] = "HARMFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 50,
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
			["version"] = 17,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
				{
					["type"] = "subborder",
					["border_size"] = 1,
					["text_color"] = {
					},
					["border_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["border_visible"] = false,
					["border_edge"] = "Square Full White",
					["border_offset"] = 0.5,
				}, -- [2]
			},
			["height"] = 30,
			["load"] = {
				["use_class"] = false,
				["ingroup"] = {
				},
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
					["multi"] = {
						["PRIEST"] = true,
						["PALADIN"] = true,
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["config"] = {
			},
			["url"] = "https://wago.io/pw_hjyCcX/17",
			["useTooltip"] = false,
			["regionType"] = "icon",
			["parent"] = "Superlilya's Loss of Control Effects",
			["cooldown"] = true,
			["xOffset"] = 0,
			["authorOptions"] = {
			},
			["auto"] = true,
			["width"] = 30,
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.16",
			["tocversion"] = 20503,
			["id"] = "Unstable govno",
			["alpha"] = 0.99,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.05,
			["uid"] = "FguV0)KEGj3",
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["value"] = "magic",
						["variable"] = "debuffClass",
					},
					["changes"] = {
						{
							["value"] = {
								0.2, -- [1]
								0.6, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["property"] = "sub.2.border_color",
						}, -- [1]
						{
							["value"] = true,
							["property"] = "sub.2.border_visible",
						}, -- [2]
					},
				}, -- [1]
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["actions"] = {
				["start"] = {
					["message"] = "",
					["do_message"] = false,
					["message_type"] = "RAID_WARNING",
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
		},
		["Druid - CP5"] = {
			["color"] = {
				0.99607843137255, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -227,
			["anchorPoint"] = "CENTER",
			["url"] = "https://wago.io/HCaWT5tJa/14",
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
						["use_power"] = true,
						["genericShowOn"] = "showOnActive",
						["use_unit"] = true,
						["powertype"] = 4,
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "unit",
						["unevent"] = "auto",
						["power_operator"] = "==",
						["event"] = "Power",
						["duration"] = "1",
						["names"] = {
						},
						["spellIds"] = {
						},
						["use_requirePowerType"] = false,
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["power"] = "5",
						["unit"] = "player",
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
						["type"] = "item",
						["event"] = "Item Equipped",
						["use_inverse"] = true,
						["unevent"] = "auto",
						["use_itemName"] = true,
						["use_unit"] = true,
						["unit"] = "player",
					},
					["untrigger"] = {
						["itemName"] = 150936,
					},
				}, -- [2]
				["disjunctive"] = "all",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 49,
			["animation"] = {
				["start"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["preset"] = "slideright",
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
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["preset"] = "slideleft",
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
			["height"] = 30,
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
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["level"] = "70",
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
				["size"] = {
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["use_level"] = false,
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["use_combat"] = true,
				["race"] = {
					["multi"] = {
					},
				},
				["level_operator"] = "<",
			},
			["textureWrapMode"] = "CLAMP",
			["mirror"] = false,
			["regionType"] = "texture",
			["blendMode"] = "BLEND",
			["frameStrata"] = 2,
			["texture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_White",
			["parent"] = "Druid 2.0",
			["xOffset"] = 97.999755859375,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Druid - CP5",
			["selfPoint"] = "CENTER",
			["alpha"] = 1,
			["width"] = 69,
			["config"] = {
			},
			["uid"] = "klWFLF0NXf8",
			["anchorFrameType"] = "SCREEN",
			["authorOptions"] = {
			},
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["discrete_rotation"] = 0,
		},
		["Off Hand"] = {
			["sparkWidth"] = 10,
			["borderBackdrop"] = "Blizzard Tooltip",
			["parent"] = "Swing Timers",
			["preferToUpdate"] = false,
			["spark"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["xOffset"] = 0,
			["sparkRotation"] = 0,
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/fpdm12tUX/1",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "unit",
						["unevent"] = "auto",
						["use_unit"] = true,
						["use_inverse"] = false,
						["event"] = "Swing Timer",
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["spellIds"] = {
						},
						["use_hand"] = true,
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["hand"] = "off",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
						["hand"] = "off",
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
			["internalVersion"] = 49,
			["iconSource"] = -1,
			["selfPoint"] = "CENTER",
			["backdropInFront"] = false,
			["sparkRotationMode"] = "AUTO",
			["barColor"] = {
				0.1254901960784314, -- [1]
				0.8235294117647058, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["auto"] = true,
			["authorOptions"] = {
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
					["text_text_format_p_format"] = "timed",
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
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = -1,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "INNER_RIGHT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_visible"] = false,
					["text_fontSize"] = 8,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [3]
				{
					["text_shadowXOffset"] = 0,
					["text_text"] = "Off Hand",
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
					["text_fontType"] = "None",
					["text_anchorPoint"] = "INNER_LEFT",
					["text_fontSize"] = 8,
					["anchorXOffset"] = 0,
					["text_visible"] = false,
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
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "ICON_CENTER",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_visible"] = false,
				}, -- [5]
				{
					["type"] = "subborder",
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
					["border_offset"] = 5,
				}, -- [6]
			},
			["height"] = 6,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["load"] = {
				["zoneIds"] = "",
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
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
			["sparkBlendMode"] = "ADD",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["config"] = {
			},
			["version"] = 1,
			["width"] = 200,
			["alpha"] = 1,
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
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["borderInFront"] = true,
			["sparkHidden"] = "NEVER",
			["icon_side"] = "RIGHT",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["sparkHeight"] = 30,
			["texture"] = "Glamour2",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["zoom"] = 0,
			["semver"] = "1.0.0",
			["tocversion"] = 11302,
			["id"] = "Off Hand",
			["useAdjustededMax"] = false,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["stickyDuration"] = false,
			["uid"] = "(1XnfyKcJl3",
			["inverse"] = true,
			["icon"] = false,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["sparkOffsetX"] = 0,
		},
		["Druid - CP4"] = {
			["color"] = {
				0.99607843137255, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -227,
			["anchorPoint"] = "CENTER",
			["url"] = "https://wago.io/HCaWT5tJa/14",
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
						["use_power"] = true,
						["genericShowOn"] = "showOnActive",
						["use_unit"] = true,
						["powertype"] = 4,
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "unit",
						["unevent"] = "auto",
						["power_operator"] = ">=",
						["event"] = "Power",
						["duration"] = "1",
						["names"] = {
						},
						["spellIds"] = {
						},
						["use_requirePowerType"] = false,
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["power"] = "4",
						["unit"] = "player",
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
						["type"] = "item",
						["event"] = "Item Equipped",
						["use_inverse"] = true,
						["unevent"] = "auto",
						["use_itemName"] = true,
						["use_unit"] = true,
						["unit"] = "player",
					},
					["untrigger"] = {
						["itemName"] = 150936,
					},
				}, -- [2]
				["disjunctive"] = "all",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 49,
			["animation"] = {
				["start"] = {
					["type"] = "preset",
					["easeType"] = "none",
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["preset"] = "slideright",
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
					["duration_type"] = "seconds",
					["easeStrength"] = 3,
					["preset"] = "slideleft",
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
			["height"] = 30,
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
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["level"] = "70",
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
				["size"] = {
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["use_level"] = false,
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["use_vehicleUi"] = false,
				["use_combat"] = true,
				["race"] = {
					["multi"] = {
					},
				},
				["level_operator"] = "<",
			},
			["textureWrapMode"] = "CLAMP",
			["mirror"] = false,
			["regionType"] = "texture",
			["blendMode"] = "BLEND",
			["frameStrata"] = 2,
			["texture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_White",
			["parent"] = "Druid 2.0",
			["xOffset"] = 47.999755859375,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Druid - CP4",
			["selfPoint"] = "CENTER",
			["alpha"] = 1,
			["width"] = 67,
			["config"] = {
			},
			["uid"] = "JmoDu(YlHE3",
			["anchorFrameType"] = "SCREEN",
			["authorOptions"] = {
			},
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["discrete_rotation"] = 0,
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
						["type"] = "item",
						["use_count"] = true,
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["event"] = "Item Count",
						["subeventPrefix"] = "SPELL",
						["use_includeBank"] = false,
						["itemName"] = 5514,
						["count"] = "0",
						["unevent"] = "auto",
						["use_itemName"] = true,
						["unit"] = "player",
						["use_unit"] = true,
						["count_operator"] = "==",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["customTriggerLogic"] = "",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 49,
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
					["glowScale"] = 1,
					["glowThickness"] = 1,
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
				["level_operator"] = ">=",
				["use_class"] = false,
				["use_spellknown"] = false,
				["size"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["level"] = "28",
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["MAGE"] = true,
					},
				},
				["zoneIds"] = "",
			},
			["config"] = {
				["macro"] = {
					["text"] = "/cast Conjure Mana Agate",
				},
			},
			["parent"] = "GEMS",
			["cooldownEdge"] = false,
			["regionType"] = "icon",
			["authorOptions"] = {
				{
					["subOptions"] = {
						{
							["type"] = "input",
							["useDesc"] = false,
							["width"] = 1,
							["name"] = "Text",
							["default"] = "",
							["key"] = "text",
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
			["cooldown"] = false,
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
			["xOffset"] = 0,
			["cooldownTextDisabled"] = false,
			["width"] = 40,
			["zoom"] = 0,
			["semver"] = "1.0.0",
			["tocversion"] = 11304,
			["id"] = "Agate",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = true,
			["uid"] = "(9qU7Rw3V8a",
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["displayIcon"] = 134104,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
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
		},
		["Warlock - Corruption"] = {
			["iconSource"] = 0,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -262,
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
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura2",
						["subeventSuffix"] = "_CAST_START",
						["matchesShowOn"] = "showAlways",
						["event"] = "Health",
						["names"] = {
						},
						["unitExists"] = true,
						["subeventPrefix"] = "SPELL",
						["spellIds"] = {
						},
						["useName"] = true,
						["auranames"] = {
							"Corruption", -- [1]
						},
						["ownOnly"] = true,
						["unit"] = "target",
						["debuffType"] = "HARMFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 12,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 26,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
				{
					["glowFrequency"] = 0.25,
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
					["useGlowColor"] = false,
					["glow"] = false,
					["glowScale"] = 1,
					["glowThickness"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 49,
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
					["single"] = "WARLOCK",
					["multi"] = {
						["WARLOCK"] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "GsA28ml6aTO",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["selfPoint"] = "CENTER",
			["regionType"] = "icon",
			["icon"] = true,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = -2,
						["variable"] = "AND",
						["checks"] = {
							{
								["trigger"] = -1,
								["variable"] = "incombat",
								["value"] = 1,
							}, -- [1]
							{
								["trigger"] = 1,
								["variable"] = "buffed",
								["value"] = 1,
							}, -- [2]
							{
								["trigger"] = 1,
								["op"] = "<=",
								["value"] = "2",
								["variable"] = "expirationTime",
							}, -- [3]
						},
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "sub.3.glow",
						}, -- [1]
					},
				}, -- [1]
			},
			["xOffset"] = 0,
			["cooldownTextDisabled"] = true,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["auto"] = false,
			["tocversion"] = 11302,
			["id"] = "Warlock - Corruption",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["width"] = 49,
			["semver"] = "1.0.11",
			["config"] = {
			},
			["inverse"] = false,
			["url"] = "https://wago.io/Y8douZITb/12",
			["displayIcon"] = 136118,
			["cooldown"] = true,
			["parent"] = "Warlock 2.0",
		},
		["Warrior - Shield Slam"] = {
			["iconSource"] = -1,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -75,
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
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["auranames"] = {
							"Immolate", -- [1]
						},
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["unitExists"] = true,
						["duration"] = "1",
						["debuffType"] = "HARMFUL",
						["use_unit"] = true,
						["type"] = "spell",
						["matchesShowOn"] = "showAlways",
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "target",
						["useName"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["use_exact_spellName"] = false,
						["realSpellName"] = "Shield Slam",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_remaining"] = false,
						["unevent"] = "auto",
						["spellName"] = 23922,
						["use_track"] = true,
						["names"] = {
						},
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 16,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 26,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 49,
			["load"] = {
				["use_class"] = true,
				["use_talent"] = true,
				["use_never"] = false,
				["talent"] = {
					["single"] = 57,
					["multi"] = {
						[13] = true,
					},
				},
				["zoneIds"] = "",
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
			["url"] = "https://wago.io/z6xqQay0S/16",
			["xOffset"] = 99,
			["regionType"] = "icon",
			["parent"] = "Warrior 2.0",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["authorOptions"] = {
			},
			["zoom"] = 0.3,
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.15",
			["tocversion"] = 11302,
			["id"] = "Warrior - Shield Slam",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 49,
			["auto"] = true,
			["uid"] = "fsHMS2PlDib",
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["displayIcon"] = 135817,
			["cooldown"] = true,
			["icon"] = true,
		},
		["Warrior - Battle Stance"] = {
			["outline"] = "OUTLINE",
			["xOffset"] = 0,
			["displayText"] = "BATTLE STANCE",
			["yOffset"] = -49.500030517578,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
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
						["use_form"] = true,
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["form"] = {
							["single"] = 1,
						},
						["event"] = "Stance/Form/Aura",
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_inverse"] = false,
						["names"] = {
						},
						["unevent"] = "auto",
						["duration"] = "1",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
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
			["font"] = "Vixar",
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
				["zoneIds"] = "",
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
			["fontSize"] = 21,
			["shadowXOffset"] = 1,
			["regionType"] = "text",
			["conditions"] = {
			},
			["parent"] = "Warrior 2.0",
			["selfPoint"] = "BOTTOM",
			["shadowYOffset"] = -1,
			["authorOptions"] = {
			},
			["justify"] = "LEFT",
			["semver"] = "1.0.15",
			["tocversion"] = 11302,
			["id"] = "Warrior - Battle Stance",
			["config"] = {
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["color"] = {
				1, -- [1]
				0.37254901960784, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["uid"] = "CuJBPUabQKw",
			["url"] = "https://wago.io/z6xqQay0S/16",
			["wordWrap"] = "WordWrap",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["preferToUpdate"] = false,
		},
		["RENEW"] = {
			["sparkWidth"] = 10,
			["sparkOffsetX"] = 0,
			["xOffset"] = 20,
			["yOffset"] = 50,
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
						["type"] = "aura2",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["spellIds"] = {
						},
						["auranames"] = {
							"Renew", -- [1]
						},
						["useName"] = true,
						["names"] = {
						},
						["unit"] = "player",
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
			["internalVersion"] = 49,
			["selfPoint"] = "CENTER",
			["barColor"] = {
				0.2, -- [1]
				1, -- [2]
				0.0862745098039216, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
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
					["text_text"] = "Renew",
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
					["text_visible"] = true,
					["text_text_format_n_format"] = "none",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_anchorYOffset"] = 4,
				}, -- [3]
			},
			["height"] = 3,
			["load"] = {
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
			["uid"] = "COT6WtLOefa",
			["iconSource"] = -1,
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
			["useAdjustededMin"] = false,
			["smoothProgress"] = true,
			["anchorFrameFrame"] = "PlayerFrame",
			["regionType"] = "aurabar",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["config"] = {
			},
			["icon_side"] = "RIGHT",
			["zoom"] = 0,
			["sparkHeight"] = 30,
			["texture"] = "Glamour2",
			["id"] = "RENEW",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["spark"] = false,
			["width"] = 175,
			["sparkHidden"] = "NEVER",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["anchorFrameType"] = "SELECTFRAME",
			["auto"] = true,
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
			},
			["icon"] = false,
		},
		["Warrior - Perception"] = {
			["iconSource"] = 0,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -155.78,
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
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Rend", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["unitExists"] = true,
						["spellName"] = 20600,
						["use_unit"] = true,
						["type"] = "spell",
						["debuffType"] = "HARMFUL",
						["subeventSuffix"] = "_CAST_START",
						["ownOnly"] = true,
						["useName"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Perception",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["names"] = {
						},
						["use_genericShowOn"] = true,
						["matchesShowOn"] = "showAlways",
						["use_track"] = true,
						["unit"] = "target",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 16,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_race"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
						["ROGUE"] = true,
					},
				},
				["use_class"] = true,
				["race"] = {
					["single"] = "Human",
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "ZajK4gwJStQ",
			["xOffset"] = 106,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["parent"] = "Warrior 2.0",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["url"] = "https://wago.io/z6xqQay0S/16",
			["zoom"] = 0.3,
			["width"] = 35,
			["cooldownTextDisabled"] = true,
			["auto"] = false,
			["tocversion"] = 11302,
			["id"] = "Warrior - Perception",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["semver"] = "1.0.15",
			["config"] = {
			},
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["displayIcon"] = 136090,
			["cooldown"] = true,
			["icon"] = true,
		},
		["Priest - Stoneform"] = {
			["iconSource"] = 0,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -327,
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
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Rend", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["unitExists"] = true,
						["spellName"] = 20594,
						["use_unit"] = true,
						["useName"] = true,
						["use_genericShowOn"] = true,
						["subeventSuffix"] = "_CAST_START",
						["ownOnly"] = true,
						["matchesShowOn"] = "showAlways",
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Stoneform",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["unit"] = "target",
						["type"] = "spell",
						["names"] = {
						},
						["use_track"] = true,
						["debuffType"] = "HARMFUL",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_race"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "PRIEST",
					["multi"] = {
						["ROGUE"] = true,
					},
				},
				["use_class"] = true,
				["race"] = {
					["single"] = "Dwarf",
				},
				["zoneIds"] = "",
				["spec"] = {
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
			["url"] = "https://wago.io/R8xGfpcxa/14",
			["selfPoint"] = "CENTER",
			["regionType"] = "icon",
			["parent"] = "Priest 2.0",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["icon"] = true,
			["zoom"] = 0.3,
			["width"] = 35,
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Priest - Stoneform",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = false,
			["uid"] = "TIpTFZUU4Ix",
			["inverse"] = false,
			["xOffset"] = 106,
			["displayIcon"] = 136225,
			["cooldown"] = true,
			["authorOptions"] = {
			},
		},
		["Warlock - Soul Shard #"] = {
			["iconSource"] = -1,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -327,
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
			["triggers"] = {
				{
					["trigger"] = {
						["itemName"] = 6265,
						["use_count"] = false,
						["auranames"] = {
							"Immolate", -- [1]
						},
						["duration"] = "1",
						["names"] = {
						},
						["unitExists"] = true,
						["debuffType"] = "HARMFUL",
						["useName"] = true,
						["subeventSuffix"] = "_CAST_START",
						["use_itemName"] = true,
						["event"] = "Item Count",
						["unit"] = "target",
						["spellIds"] = {
						},
						["type"] = "item",
						["unevent"] = "auto",
						["subeventPrefix"] = "SPELL",
						["matchesShowOn"] = "showAlways",
						["use_unit"] = true,
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 12,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 25,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_class"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class"] = {
					["single"] = "WARLOCK",
					["multi"] = {
						["WARLOCK"] = true,
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
			["cooldownTextDisabled"] = false,
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
			["regionType"] = "icon",
			["url"] = "https://wago.io/Y8douZITb/12",
			["authorOptions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["xOffset"] = -69.78,
			["uid"] = "esE633vv0KS",
			["semver"] = "1.0.11",
			["zoom"] = 0.3,
			["auto"] = true,
			["tocversion"] = 11302,
			["id"] = "Warlock - Soul Shard #",
			["width"] = 35,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 1,
			["config"] = {
			},
			["inverse"] = false,
			["icon"] = true,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "<=",
						["variable"] = "value",
						["value"] = "0",
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "desaturate",
						}, -- [1]
						{
							["value"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								0.49479150772095, -- [4]
							},
							["property"] = "color",
						}, -- [2]
					},
				}, -- [1]
			},
			["cooldown"] = true,
			["parent"] = "Warlock 2.0",
		},
		["Druid - Rebirth"] = {
			["iconSource"] = 0,
			["parent"] = "Druid 2.0",
			["preferToUpdate"] = false,
			["yOffset"] = -327,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/HCaWT5tJa/14",
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
							"Charge", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["names"] = {
						},
						["unitExists"] = true,
						["debuffType"] = "HARMFUL",
						["unit"] = "target",
						["useName"] = true,
						["use_genericShowOn"] = true,
						["subeventSuffix"] = "_CAST_START",
						["ownOnly"] = true,
						["duration"] = "1",
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Rebirth",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["type"] = "spell",
						["use_unit"] = true,
						["spellName"] = 20484,
						["use_track"] = true,
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 35,
			["load"] = {
				["use_class"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["HUNTER"] = true,
						["ROGUE"] = true,
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
			["uid"] = "(DMzZaB)vdt",
			["icon"] = true,
			["cooldownEdge"] = false,
			["regionType"] = "icon",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["selfPoint"] = "CENTER",
			["cooldownTextDisabled"] = true,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["auto"] = false,
			["tocversion"] = 11302,
			["id"] = "Druid - Rebirth",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 35,
			["semver"] = "1.0.13",
			["config"] = {
			},
			["inverse"] = false,
			["authorOptions"] = {
			},
			["displayIcon"] = 136080,
			["cooldown"] = true,
			["xOffset"] = 36,
		},
		["Warrior - Taunt Resisted"] = {
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
			["url"] = "https://wago.io/z6xqQay0S/16",
			["actions"] = {
				["start"] = {
					["message"] = "TAUNT RESISTED!",
					["do_message"] = true,
					["message_type"] = "SAY",
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "1",
						["unit"] = "player",
						["use_missType"] = false,
						["debuffType"] = "HELPFUL",
						["type"] = "combatlog",
						["unevent"] = "timed",
						["names"] = {
						},
						["event"] = "Combat Log",
						["spellName"] = "Taunt",
						["subeventSuffix"] = "_MISSED",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = true,
						["missType"] = "RESIST",
						["use_destUnit"] = false,
						["sourceUnit"] = "player",
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 16,
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
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_fontType"] = "OUTLINE",
				}, -- [2]
			},
			["height"] = 1,
			["load"] = {
				["use_class"] = true,
				["use_size"] = false,
				["zoneIds"] = "",
				["talent"] = {
					["multi"] = {
					},
				},
				["ingroup"] = {
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
					["single"] = "party",
					["multi"] = {
						["party"] = true,
						["ten"] = true,
						["twentyfive"] = true,
						["twenty"] = true,
						["fortyman"] = true,
					},
				},
			},
			["uid"] = "S98f9KsSjga",
			["authorOptions"] = {
			},
			["selfPoint"] = "CENTER",
			["regionType"] = "icon",
			["parent"] = "Warrior 2.0",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["variable"] = "show",
						["value"] = 1,
					},
					["changes"] = {
						{
							["value"] = {
								["message"] = "TAUNT RESISTED!",
								["message_type"] = "YELL",
							},
							["property"] = "chat",
						}, -- [1]
					},
				}, -- [1]
			},
			["icon"] = true,
			["zoom"] = 0.3,
			["width"] = 1,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.0.15",
			["tocversion"] = 11302,
			["id"] = "Warrior - Taunt Resisted",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = true,
			["config"] = {
			},
			["inverse"] = false,
			["xOffset"] = 0,
			["displayIcon"] = 136080,
			["cooldown"] = false,
			["cooldownEdge"] = false,
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
			["internalVersion"] = 49,
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
			["scale"] = 1,
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "group",
			["borderSize"] = 2,
			["uid"] = "Ow32WYEI1Ji",
			["borderOffset"] = 4,
			["semver"] = "1.0.0",
			["tocversion"] = 11304,
			["id"] = "GEMS",
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
			["anchorFrameType"] = "SELECTFRAME",
			["groupIcon"] = 134105,
			["config"] = {
			},
			["borderInset"] = 1,
			["anchorFrameFrame"] = "MultiBarBottomRightButton12",
			["conditions"] = {
			},
			["information"] = {
				["groupOffset"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["xOffset"] = 40,
		},
		["Warrior - Escape Artist"] = {
			["iconSource"] = 0,
			["parent"] = "Warrior 2.0",
			["preferToUpdate"] = false,
			["yOffset"] = -155.78,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Rend", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["unitExists"] = true,
						["spellName"] = 20589,
						["names"] = {
						},
						["type"] = "spell",
						["debuffType"] = "HARMFUL",
						["subeventSuffix"] = "_CAST_START",
						["ownOnly"] = true,
						["useName"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Escape Artist",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_unit"] = true,
						["use_genericShowOn"] = true,
						["matchesShowOn"] = "showAlways",
						["use_track"] = true,
						["unit"] = "target",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 16,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_race"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
						["ROGUE"] = true,
					},
				},
				["use_class"] = true,
				["race"] = {
					["single"] = "Gnome",
				},
				["zoneIds"] = "",
				["spec"] = {
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
			["authorOptions"] = {
			},
			["url"] = "https://wago.io/z6xqQay0S/16",
			["regionType"] = "icon",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["xOffset"] = 106,
			["cooldownTextDisabled"] = true,
			["width"] = 35,
			["zoom"] = 0.3,
			["semver"] = "1.0.15",
			["tocversion"] = 11302,
			["id"] = "Warrior - Escape Artist",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = false,
			["uid"] = "gdrSiz1PIND",
			["inverse"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayIcon"] = 132309,
			["cooldown"] = true,
			["selfPoint"] = "CENTER",
		},
		["Priest - Vampiric Embrace"] = {
			["iconSource"] = 0,
			["parent"] = "Priest 2.0",
			["preferToUpdate"] = false,
			["yOffset"] = -262,
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
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["auranames"] = {
							"15286", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["unit"] = "target",
						["unitExists"] = true,
						["debuffType"] = "HARMFUL",
						["useName"] = true,
						["names"] = {
						},
						["unevent"] = "auto",
						["use_genericShowOn"] = true,
						["subeventPrefix"] = "SPELL",
						["event"] = "Cooldown Progress (Spell)",
						["duration"] = "1",
						["realSpellName"] = "Blood Fury",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["type"] = "aura2",
						["spellName"] = 20572,
						["use_track"] = true,
						["use_unit"] = true,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
						["track"] = "auto",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 26,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 49,
			["load"] = {
				["use_class"] = true,
				["race"] = {
					["single"] = "Scourge",
					["multi"] = {
						["Scourge"] = true,
					},
				},
				["use_talent"] = true,
				["talent"] = {
					["single"] = 53,
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class"] = {
					["single"] = "PRIEST",
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
			["config"] = {
			},
			["selfPoint"] = "CENTER",
			["url"] = "https://wago.io/R8xGfpcxa/14",
			["regionType"] = "icon",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
							["property"] = "desaturate",
						}, -- [1]
						{
						}, -- [2]
					},
				}, -- [1]
			},
			["xOffset"] = 50,
			["cooldownTextDisabled"] = true,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Priest - Vampiric Embrace",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 49,
			["auto"] = false,
			["uid"] = "cGLikbQl0a6",
			["inverse"] = false,
			["icon"] = true,
			["displayIcon"] = 136230,
			["cooldown"] = true,
			["authorOptions"] = {
			},
		},
		["Warlock - Curse Of Agony"] = {
			["iconSource"] = -1,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -262,
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
			["triggers"] = {
				{
					["trigger"] = {
						["useName"] = true,
						["subeventSuffix"] = "_CAST_START",
						["ownOnly"] = true,
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["unitExists"] = true,
						["type"] = "aura2",
						["spellIds"] = {
						},
						["names"] = {
						},
						["auranames"] = {
							"Curse of Agony", -- [1]
							"Curse of Recklessness", -- [2]
							"Curse of Tongues", -- [3]
							"Curse of Weakness", -- [4]
						},
						["matchesShowOn"] = "showAlways",
						["unit"] = "target",
						["debuffType"] = "HARMFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 12,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 26,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
				{
					["glowFrequency"] = 0.25,
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
					["useGlowColor"] = false,
					["glow"] = false,
					["glowScale"] = 1,
					["glowThickness"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 49,
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
					["single"] = "WARLOCK",
					["multi"] = {
						["WARLOCK"] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "jRRk0BDjOIS",
			["xOffset"] = -49,
			["parent"] = "Warlock 2.0",
			["regionType"] = "icon",
			["authorOptions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = -2,
						["variable"] = "AND",
						["checks"] = {
							{
								["trigger"] = -1,
								["variable"] = "incombat",
								["value"] = 1,
							}, -- [1]
							{
								["trigger"] = 1,
								["variable"] = "buffed",
								["value"] = 1,
							}, -- [2]
							{
								["trigger"] = 1,
								["op"] = "<=",
								["value"] = "2",
								["variable"] = "expirationTime",
							}, -- [3]
						},
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "sub.3.glow",
						}, -- [1]
					},
				}, -- [1]
			},
			["selfPoint"] = "CENTER",
			["auto"] = true,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["semver"] = "1.0.11",
			["tocversion"] = 11302,
			["id"] = "Warlock - Curse Of Agony",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["width"] = 49,
			["cooldownTextDisabled"] = true,
			["config"] = {
			},
			["inverse"] = false,
			["icon"] = true,
			["displayIcon"] = 136139,
			["cooldown"] = true,
			["url"] = "https://wago.io/Y8douZITb/12",
		},
		["Druid - Tiger's Fury"] = {
			["iconSource"] = 0,
			["parent"] = "Druid 2.0",
			["preferToUpdate"] = false,
			["yOffset"] = -263,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/HCaWT5tJa/14",
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
						["track"] = "auto",
						["auranames"] = {
							"Bloodrage", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["unit"] = "player",
						["unitExists"] = true,
						["debuffType"] = "HELPFUL",
						["useName"] = true,
						["subeventPrefix"] = "SPELL",
						["unevent"] = "auto",
						["use_genericShowOn"] = true,
						["duration"] = "1",
						["event"] = "Cooldown Progress (Spell)",
						["use_unit"] = true,
						["realSpellName"] = "Tiger's Fury",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["type"] = "spell",
						["spellName"] = 5217,
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
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 26,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 49,
			["load"] = {
				["use_class"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["DRUID"] = true,
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
			["uid"] = "nvE6oi6Jksa",
			["cooldownEdge"] = false,
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
			["regionType"] = "icon",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["authorOptions"] = {
			},
			["zoom"] = 0.3,
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Druid - Tiger's Fury",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 49,
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["xOffset"] = 50,
			["displayIcon"] = 132242,
			["cooldown"] = true,
			["icon"] = true,
		},
		["Warlock - Banish Timer"] = {
			["iconSource"] = -1,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -326.63,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["url"] = "https://wago.io/Y8douZITb/12",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "local e = aura_env\ne.playerGUID = UnitGUID(\"player\")\ne.startTime = 0\ne.expirationTime = 0\ne.duration = 20\ne.spell = GetSpellInfo(710)\n\n\n\n",
					["do_custom"] = true,
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "60",
						["genericShowOn"] = "showOnActive",
						["names"] = {
						},
						["use_specific_unit"] = false,
						["unit"] = "multi",
						["subeventPrefix"] = "SPELL",
						["spellName"] = "Freezing Trap",
						["custom"] = "function(_,_,subEvent,_,sourceGUID,_,_,_,destGUID,_,_,_,_,spell)\n    local e = aura_env\n    if (subEvent == \"SPELL_AURA_APPLIED\" or subEvent == \"SPELL_AURA_REFRESH\") and spell == e.spell and sourceGUID == e.playerGUID then\n        e.target = destGUID\n        e.startTime = GetTime()\n        e.expirationTime = e.startTime + e.duration\n        e.broken = false\n        return true\n    elseif (subEvent == \"SPELL_AURA_REMOVED\" or subEvent == \"SPELL_AURA_BROKEN\") and spell == e.spell and sourceGUID == e.playerGUID then\n        e.target = e.target or \"\"\n        if destGUID == e.target then \n            e.broken = true\n        end\n    end\nend\n\n\n\n\n\n\n\n",
						["debuffType"] = "HELPFUL",
						["events"] = "COMBAT_LOG_EVENT_UNFILTERED",
						["type"] = "custom",
						["subeventSuffix"] = "_AURA_APPLIED",
						["custom_type"] = "status",
						["unevent"] = "timed",
						["auraType"] = "DEBUFF",
						["event"] = "Combat Log",
						["spellIds"] = {
						},
						["customDuration"] = "function()\n    return aura_env.duration, aura_env.expirationTime\nend\n\n\n\n\n\n\n\n",
						["use_spellName"] = true,
						["name"] = "Freezing Trap",
						["use_sourceUnit"] = true,
						["check"] = "event",
						["use_destUnit"] = false,
						["sourceUnit"] = "player",
						["use_auraType"] = true,
					},
					["untrigger"] = {
						["custom"] = "function()\n    local e = aura_env\n    return e.broken or GetTime() - e.startTime > e.duration \nend\n\n\n\n\n\n\n\n\n\n",
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
				["disjunctive"] = "any",
				["customTriggerLogic"] = "\n\n\n\n\n\n\n\n",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 12,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
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
					["single"] = "WARLOCK",
					["multi"] = {
						["HUNTER"] = true,
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
				["use_class"] = true,
				["race"] = {
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
				["role"] = {
					["multi"] = {
					},
				},
				["class_and_spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["uid"] = "AmSea7yVXh4",
			["xOffset"] = 71,
			["icon"] = true,
			["regionType"] = "icon",
			["selfPoint"] = "CENTER",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["conditions"] = {
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["cooldownTextDisabled"] = true,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["auto"] = true,
			["tocversion"] = 11302,
			["id"] = "Warlock - Banish Timer",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["width"] = 35,
			["semver"] = "1.0.11",
			["config"] = {
			},
			["inverse"] = false,
			["cooldownEdge"] = false,
			["displayIcon"] = 136135,
			["cooldown"] = true,
			["parent"] = "Warlock 2.0",
		},
		["Overpower on Nameplate"] = {
			["iconSource"] = 0,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["customText"] = "function()\n    if aura_env.state and aura_env.state.PassUnit then\n        local region = aura_env.region\n        local plate = C_NamePlate.GetNamePlateForUnit(aura_env.state.PassUnit)\n        if plate then\n            region:ClearAllPoints()\n            region:SetPoint(\"LEFT\", plate, \"RIGHT\", aura_env.config.xoff, aura_env.config.yoff)\n            region:Show()\n        else\n            region:Hide()\n        end\n    end\nend\n\n\n",
			["yOffset"] = -5,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["customTextUpdate"] = "event",
			["url"] = "https://wago.io/nuh2DOgJo/3",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["custom_hide"] = "timed",
						["type"] = "custom",
						["subeventSuffix"] = "_CAST_START",
						["unevent"] = "auto",
						["genericShowOn"] = "showOnActive",
						["duration"] = "1",
						["event"] = "Chat Message",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["spellIds"] = {
						},
						["custom"] = "function(allstates, event,unit, ...)    \n    if event == \"NAME_PLATE_UNIT_ADDED\" then\n        if unit then\n            local guid = UnitGUID(unit)                   \n            --print(name)\n            allstates[guid] = {\n                changed = true,\n                show = false,\n                PassUnit = unit,\n                glow = false,\n            }            \n        end\n    end\n    \n    if event == \"NAME_PLATE_UNIT_REMOVED\" then\n        if unit then\n            local guid = UnitGUID(unit)\n            if allstates[guid] then\n                allstates[guid].changed = true\n                allstates[guid].PassUnit = \"none\"\n            end\n        end\n    end\n    \n    if event == \"COMBAT_LOG_EVENT_UNFILTERED\" then\n        local subEvent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = ...\n        local spellID,spellName,spellSchool\n        local missType = \"\"\n        local stanceIndex = GetShapeshiftForm()\n        \n        if subEvent == \"SWING_MISSED\" and sourceName == UnitName(\"player\")  then\n            --if subEvent == \"SWING_MISSED\" and sourceName == UnitName(\"player\") and stanceIndex == 1 then\n            missType = select(11,...)\n            --print(missType .. \"SWING missed\")\n            --print(missType .. \"  SWING \")\n        elseif subEvent == \"SPELL_MISSED\" and sourceName == UnitName(\"player\") then\n            --elseif subEvent == \"SPELL_MISSED\" and sourceName == UnitName(\"player\") and stanceIndex == 1 then\n            \n            spellID,spellName,spellSchool,missType = select(11, ...)\n            --print(missType .. \"SPELL missed\")\n            --print(missType .. \"  SPELL \")            \n        end\n        \n        if missType == \"DODGE\" then\n            for i = 1,40 do\n                local u = \"nameplate\"..i                \n                if UnitExists(u) and UnitGUID(u) == destGUID then            \n                    allstates[destGUID] = {\n                        changed = true,\n                        show = true,          \n                        PassUnit = u,\n                        glow = true,\n                        autoHide = true,\n                        progressType = \"timed\",\n                        duration = aura_env.config.duration,\n                    } \n                    break\n                    \n                end\n            end\n        end\n    end\n    \n    return true\n    \nend",
						["events"] = " NAME_PLATE_UNIT_ADDED NAME_PLATE_UNIT_REMOVED COMBAT_LOG_EVENT_UNFILTERED ",
						["check"] = "event",
						["names"] = {
						},
						["custom_type"] = "stateupdate",
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
						["event"] = "Cooldown Progress (Spell)",
						["subeventPrefix"] = "SPELL",
						["realSpellName"] = "Overpower",
						["use_spellName"] = true,
						["unit"] = "player",
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showAlways",
						["use_unit"] = true,
						["use_track"] = true,
						["spellName"] = 7887,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [2]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["discrete_rotation"] = 0,
			["version"] = 3,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_visible"] = false,
				}, -- [2]
				{
					["text_shadowXOffset"] = 1,
					["text_text"] = "%2.p",
					["text_text_format_2.p_time_format"] = 0,
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
					["text_text_format_2.p_format"] = "timed",
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = -1,
					["text_text_format_2.p_time_dynamic_threshold"] = 60,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "CENTER",
					["text_text_format_2.p_time_precision"] = 1,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_visible"] = true,
				}, -- [3]
				{
					["glowFrequency"] = 0.25,
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
					["useGlowColor"] = false,
					["glow"] = true,
					["glowScale"] = 1,
					["glowThickness"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [4]
			},
			["height"] = 40,
			["rotate"] = true,
			["load"] = {
				["use_class"] = false,
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
					["multi"] = {
						["WARRIOR"] = true,
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["zoom"] = 0,
			["config"] = {
				["yoff"] = 0,
				["xoff"] = 0,
				["duration"] = 4,
			},
			["actions"] = {
				["start"] = {
					["custom"] = "\n\n",
					["do_custom"] = false,
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "if aura_env.config.duration <=  0 then\n    aura_env.config.duration = 2\nend",
					["do_custom"] = true,
				},
			},
			["authorOptions"] = {
				{
					["type"] = "number",
					["useDesc"] = false,
					["max"] = 200,
					["step"] = 0.05,
					["width"] = 1,
					["min"] = 0,
					["key"] = "xoff",
					["default"] = 0,
					["name"] = "X-Offset",
				}, -- [1]
				{
					["type"] = "number",
					["useDesc"] = false,
					["max"] = 200,
					["step"] = 0.05,
					["width"] = 1,
					["min"] = 0,
					["name"] = "Y-Offset",
					["default"] = 0,
					["key"] = "yoff",
				}, -- [2]
				{
					["type"] = "number",
					["useDesc"] = false,
					["max"] = 5,
					["step"] = 0.1,
					["width"] = 2,
					["min"] = 0,
					["key"] = "duration",
					["default"] = 3,
					["name"] = "Duration",
				}, -- [3]
			},
			["cooldown"] = false,
			["mirror"] = false,
			["anchorFrameFrame"] = "WeakAuras:Nameplate Point Anchor",
			["regionType"] = "icon",
			["conditions"] = {
			},
			["blendMode"] = "BLEND",
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
			["xOffset"] = -10,
			["texture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura53",
			["width"] = 40,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.0.2",
			["tocversion"] = 11302,
			["id"] = "Overpower on Nameplate",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = false,
			["uid"] = "R0zLHbigXLR",
			["inverse"] = false,
			["cooldownEdge"] = false,
			["displayIcon"] = 132223,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["rotation"] = 0,
		},
		["Priest - Inner Focus"] = {
			["iconSource"] = 0,
			["parent"] = "Priest 2.0",
			["preferToUpdate"] = false,
			["yOffset"] = -262,
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
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["auranames"] = {
							"Immolate", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["use_unit"] = true,
						["unitExists"] = true,
						["spellName"] = 14751,
						["duration"] = "1",
						["type"] = "spell",
						["unit"] = "target",
						["subeventSuffix"] = "_CAST_START",
						["use_remaining"] = false,
						["useName"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Inner Focus",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["use_genericShowOn"] = true,
						["use_track"] = true,
						["debuffType"] = "HARMFUL",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["use_unit"] = true,
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 26,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 49,
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
			["uid"] = "3GJKzQBe8Y2",
			["icon"] = true,
			["authorOptions"] = {
			},
			["regionType"] = "icon",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["selfPoint"] = "CENTER",
			["zoom"] = 0.3,
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Priest - Inner Focus",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 49,
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["xOffset"] = -98,
			["displayIcon"] = 135863,
			["cooldown"] = true,
			["url"] = "https://wago.io/R8xGfpcxa/14",
		},
		["Swing Timers"] = {
			["grow"] = "DOWN",
			["controlledChildren"] = {
				"Main Hand", -- [1]
				"Off Hand", -- [2]
				"Ranged", -- [3]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = -59,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["space"] = 2,
			["url"] = "https://wago.io/fpdm12tUX/1",
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
			["internalVersion"] = 49,
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
			["align"] = "CENTER",
			["rotation"] = 0,
			["version"] = 1,
			["borderInset"] = 0,
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
			["fullCircle"] = true,
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["limit"] = 5,
			["animate"] = true,
			["config"] = {
			},
			["scale"] = 1.2,
			["rowSpace"] = 1,
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "dynamicgroup",
			["borderSize"] = 2,
			["sort"] = "none",
			["radius"] = 200,
			["selfPoint"] = "TOP",
			["constantFactor"] = "RADIUS",
			["stagger"] = 0,
			["borderOffset"] = 16,
			["semver"] = "1.0.0",
			["tocversion"] = 11302,
			["id"] = "Swing Timers",
			["gridWidth"] = 5,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["arcLength"] = 360,
			["uid"] = "h90hJC1QDXk",
			["gridType"] = "RD",
			["useLimit"] = false,
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["authorOptions"] = {
			},
		},
		["Warlock - Escape Artist"] = {
			["iconSource"] = 0,
			["xOffset"] = 106,
			["preferToUpdate"] = false,
			["yOffset"] = -326.63,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["url"] = "https://wago.io/Y8douZITb/12",
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
							"Rend", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["unit"] = "target",
						["unitExists"] = true,
						["spellName"] = 20589,
						["ownOnly"] = true,
						["type"] = "spell",
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["debuffType"] = "HARMFUL",
						["matchesShowOn"] = "showAlways",
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Escape Artist",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["useName"] = true,
						["use_genericShowOn"] = true,
						["use_unit"] = true,
						["use_track"] = true,
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 12,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_race"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARLOCK",
					["multi"] = {
						["ROGUE"] = true,
					},
				},
				["use_class"] = true,
				["race"] = {
					["single"] = "Gnome",
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "hvReIaqy7dk",
			["icon"] = true,
			["authorOptions"] = {
			},
			["regionType"] = "icon",
			["selfPoint"] = "CENTER",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["cooldownEdge"] = false,
			["cooldownTextDisabled"] = true,
			["width"] = 35,
			["zoom"] = 0.3,
			["auto"] = false,
			["tocversion"] = 11302,
			["id"] = "Warlock - Escape Artist",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["semver"] = "1.0.11",
			["config"] = {
			},
			["inverse"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayIcon"] = 132309,
			["cooldown"] = true,
			["parent"] = "Warlock 2.0",
		},
		["Druid - Mana Bar "] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -298.03799438477,
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
			["selfPoint"] = "CENTER",
			["barColor"] = {
				0.32549019607843, -- [1]
				0.53725490196078, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["sparkOffsetY"] = 0,
			["load"] = {
				["size"] = {
					["multi"] = {
					},
				},
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
						["DRUID"] = true,
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
				["use_class"] = true,
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
				["ingroup"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["texture"] = "Glamour2",
			["zoom"] = 0,
			["auto"] = true,
			["tocversion"] = 11302,
			["alpha"] = 1,
			["config"] = {
			},
			["sparkOffsetX"] = 0,
			["parent"] = "Druid 2.0",
			["customText"] = "function()\n    if aura_env.region then\n        local mana = UnitPower(\"player\", Enum.PowerType.Mana)\n        aura_env.region.text3:SetText(mana)\n    end\nend\n\n\n\n\n\n\n\n\n\n\n\n",
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
						["unit"] = "player",
						["type"] = "unit",
						["use_health"] = true,
						["unevent"] = "auto",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
						["use_requirePowerType"] = true,
						["use_percentpower"] = false,
						["subeventPrefix"] = "SPELL",
						["event"] = "Power",
						["spellIds"] = {
						},
						["health"] = "0",
						["duration"] = "1",
						["subeventSuffix"] = "_CAST_START",
						["genericShowOn"] = "showOnActive",
						["health_operator"] = ">=",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "all",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
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
					["text_shadowXOffset"] = 1,
					["text_text"] = "%c ",
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
					["text_visible"] = false,
					["text_anchorPoint"] = "INNER_RIGHT",
					["text_fontSize"] = 15,
					["anchorXOffset"] = 0,
					["text_fontType"] = "None",
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
					["text_font"] = "Expressway",
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
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "ICON_CENTER",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_fontType"] = "None",
				}, -- [5]
				{
					["type"] = "subborder",
					["border_anchor"] = "bar",
					["border_offset"] = 1,
					["border_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["border_visible"] = true,
					["border_edge"] = "1 Pixel",
					["border_size"] = 1,
				}, -- [6]
			},
			["height"] = 20,
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["xOffset"] = 0.0003662109375,
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
			["overlaysTexture"] = {
				"Glamour2", -- [1]
			},
			["icon"] = false,
			["semver"] = "1.0.13",
			["anchorFrameType"] = "SCREEN",
			["sparkHidden"] = "NEVER",
			["spark"] = false,
			["frameStrata"] = 3,
			["width"] = 245,
			["id"] = "Druid - Mana Bar ",
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
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["overlays"] = {
				{
					0.43529411764706, -- [1]
					0, -- [2]
					1, -- [3]
					0.25, -- [4]
				}, -- [1]
			},
		},
		["Priest - Will of the Forsaken"] = {
			["iconSource"] = 0,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -327,
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
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Rend", -- [1]
						},
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showAlways",
						["unit"] = "target",
						["unitExists"] = true,
						["spellName"] = 7744,
						["use_unit"] = true,
						["useName"] = true,
						["ownOnly"] = true,
						["subeventSuffix"] = "_CAST_START",
						["debuffType"] = "HARMFUL",
						["matchesShowOn"] = "showAlways",
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Will of the Forsaken",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["names"] = {
						},
						["duration"] = "1",
						["type"] = "spell",
						["use_track"] = true,
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_race"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "PRIEST",
					["multi"] = {
						["ROGUE"] = true,
					},
				},
				["use_class"] = true,
				["race"] = {
					["single"] = "Scourge",
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "5GpogMAooSY",
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
			["icon"] = true,
			["regionType"] = "icon",
			["parent"] = "Priest 2.0",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["url"] = "https://wago.io/R8xGfpcxa/14",
			["zoom"] = 0.3,
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Priest - Will of the Forsaken",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 35,
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["xOffset"] = 106,
			["displayIcon"] = 136187,
			["cooldown"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Warlock - Soul Stone"] = {
			["iconSource"] = 0,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -326.63,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["url"] = "https://wago.io/Y8douZITb/12",
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
						["track"] = "auto",
						["itemName"] = 16893,
						["remaining_operator"] = "<=",
						["genericShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["use_genericShowOn"] = true,
						["duration"] = "1",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
						["unit"] = "player",
						["type"] = "item",
						["use_remaining"] = false,
						["auraspellids"] = {
							"7744", -- [1]
						},
						["unevent"] = "auto",
						["event"] = "Cooldown Progress (Item)",
						["use_itemName"] = true,
						["use_exact_spellName"] = false,
						["realSpellName"] = "Nature Protection ",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["useExactSpellId"] = true,
						["spellName"] = 16893,
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
				["disjunctive"] = "any",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 12,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_class"] = true,
				["race"] = {
					["single"] = "Scourge",
					["multi"] = {
						["Scourge"] = true,
					},
				},
				["talent"] = {
					["single"] = 28,
					["multi"] = {
						[28] = true,
					},
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARLOCK",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["icon"] = true,
			["config"] = {
			},
			["selfPoint"] = "CENTER",
			["parent"] = "Warlock 2.0",
			["regionType"] = "icon",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
							["value"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["property"] = "color",
						}, -- [2]
					},
				}, -- [1]
			},
			["useTooltip"] = false,
			["authorOptions"] = {
			},
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 1,
			["zoom"] = 0.3,
			["semver"] = "1.0.11",
			["tocversion"] = 11302,
			["id"] = "Warlock - Soul Stone",
			["cooldownTextDisabled"] = true,
			["alpha"] = 1,
			["width"] = 35.5,
			["auto"] = false,
			["uid"] = "NFJFRFkttht",
			["inverse"] = false,
			["cooldownEdge"] = false,
			["displayIcon"] = 136210,
			["cooldown"] = true,
			["xOffset"] = -105,
		},
		["Priest 2.0"] = {
			["controlledChildren"] = {
				"Priest - Shadow Word: Pain", -- [1]
				"Priest - Fade", -- [2]
				"Priest - Holy Fire", -- [3]
				"Priest - Vampiric Embrace", -- [4]
				"Priest - Inner Focus", -- [5]
				"Priest - Spirit Tap", -- [6]
				"Priest - Mind Blast", -- [7]
				"Priest - Dispel Magic", -- [8]
				"Priest - Feedback", -- [9]
				"Priest - Fear Ward", -- [10]
				"Priest - Elune's Grace", -- [11]
				"Priest - Touch of Weakness", -- [12]
				"Priest - Hex of Weakness", -- [13]
				"Priest - Power Word: Shield", -- [14]
				"Priest - Inner Fire", -- [15]
				"Priest - Psychic Scream", -- [16]
				"Priest - Desperate Prayer", -- [17]
				"Priest - Starshards", -- [18]
				"Priest - Devouring Plague", -- [19]
				"Priest - Shadowguard", -- [20]
				"Priest  - Berserking", -- [21]
				"Priest - Shadowmeld", -- [22]
				"Priest - Will of the Forsaken", -- [23]
				"Priest - Perception", -- [24]
				"Priest - Stoneform", -- [25]
				"Priest - 5Second+ManaRegen", -- [26]
				"Priest - Mana Bar", -- [27]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -20,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["url"] = "https://wago.io/R8xGfpcxa/14",
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
			["internalVersion"] = 49,
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
				["zoneIds"] = "",
				["class"] = {
					["single"] = "PRIEST",
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
			["scale"] = 0.8,
			["border"] = false,
			["borderEdge"] = "1 Pixel",
			["regionType"] = "group",
			["borderSize"] = 2,
			["borderOffset"] = 4,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Priest 2.0",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["borderInset"] = 1,
			["config"] = {
			},
			["uid"] = "rBMoijW85EM",
			["xOffset"] = 0,
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
				["groupOffset"] = true,
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
		},
		["Warrior - Berserker Stance"] = {
			["outline"] = "OUTLINE",
			["xOffset"] = 0,
			["displayText"] = "BERSERKER STANCE",
			["yOffset"] = -49.500030517578,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
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
						["use_form"] = true,
						["unevent"] = "auto",
						["names"] = {
						},
						["form"] = {
							["single"] = 3,
						},
						["event"] = "Stance/Form/Aura",
						["unit"] = "player",
						["use_unit"] = true,
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["duration"] = "1",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["use_inverse"] = false,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["wordWrap"] = "WordWrap",
			["font"] = "Vixar",
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
				["zoneIds"] = "",
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
			["fontSize"] = 21,
			["shadowXOffset"] = 1,
			["regionType"] = "text",
			["fixedWidth"] = 200,
			["url"] = "https://wago.io/z6xqQay0S/16",
			["parent"] = "Warrior 2.0",
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
			["shadowYOffset"] = -1,
			["authorOptions"] = {
			},
			["justify"] = "LEFT",
			["tocversion"] = 11302,
			["id"] = "Warrior - Berserker Stance",
			["config"] = {
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["color"] = {
				1, -- [1]
				0.37254901960784, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["uid"] = "rPVBYBZyMKI",
			["semver"] = "1.0.15",
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
				["ignoreOptionsEventErrors"] = true,
			},
			["preferToUpdate"] = false,
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
			["fullCircle"] = true,
			["space"] = 20,
			["url"] = "https://wago.io/XvH-Hqsxz/5",
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
			["columnSpace"] = 1,
			["internalVersion"] = 49,
			["selfPoint"] = "BOTTOMRIGHT",
			["align"] = "RIGHT",
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
			["frameStrata"] = 1,
			["rowSpace"] = 1,
			["stagger"] = 0,
			["groupIcon"] = 132281,
			["version"] = 5,
			["subRegions"] = {
			},
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["radius"] = 200,
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
			["authorOptions"] = {
			},
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["rotation"] = 0,
			["animate"] = false,
			["borderInset"] = 1,
			["scale"] = 1,
			["customAnchor"] = "ChatFrame3",
			["border"] = false,
			["borderEdge"] = "1 Pixel",
			["regionType"] = "dynamicgroup",
			["borderSize"] = 2,
			["sort"] = "none",
			["limit"] = 5,
			["anchorFrameFrame"] = "ChatFrame3",
			["constantFactor"] = "RADIUS",
			["uid"] = "6GCI4uu)d8g",
			["borderOffset"] = 4,
			["semver"] = "1.0.4",
			["tocversion"] = 11302,
			["id"] = "Professions Skill Tracker",
			["anchorPerUnit"] = "NAMEPLATE",
			["gridWidth"] = 5,
			["anchorFrameType"] = "SELECTFRAME",
			["arcLength"] = 360,
			["config"] = {
			},
			["anchorPoint"] = "TOPRIGHT",
			["useAnchorPerUnit"] = false,
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["useLimit"] = false,
		},
		["Warrior - Shield Wall"] = {
			["iconSource"] = 0,
			["xOffset"] = 71,
			["preferToUpdate"] = false,
			["yOffset"] = -155.78,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/z6xqQay0S/16",
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
							"Rend", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["unit"] = "target",
						["unitExists"] = true,
						["debuffType"] = "HARMFUL",
						["names"] = {
						},
						["type"] = "spell",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["ownOnly"] = true,
						["useName"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Shield Wall",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["spellName"] = 871,
						["use_genericShowOn"] = true,
						["duration"] = "1",
						["use_track"] = true,
						["use_unit"] = true,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 16,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 35,
			["load"] = {
				["use_class"] = true,
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
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "(fuPZEW1Ilf",
			["cooldownEdge"] = false,
			["authorOptions"] = {
			},
			["regionType"] = "icon",
			["icon"] = true,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["parent"] = "Warrior 2.0",
			["cooldownTextDisabled"] = true,
			["width"] = 35,
			["zoom"] = 0.3,
			["semver"] = "1.0.15",
			["tocversion"] = 11302,
			["id"] = "Warrior - Shield Wall",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayIcon"] = 132362,
			["cooldown"] = true,
			["selfPoint"] = "CENTER",
		},
		["Warrior - Sweeping Strikes"] = {
			["iconSource"] = 0,
			["xOffset"] = -98,
			["preferToUpdate"] = false,
			["yOffset"] = -75,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/z6xqQay0S/16",
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
						["track"] = "auto",
						["auranames"] = {
							"Immolate", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["use_unit"] = true,
						["unitExists"] = true,
						["matchesShowOn"] = "showAlways",
						["spellName"] = 12292,
						["names"] = {
						},
						["useName"] = true,
						["unit"] = "target",
						["subeventSuffix"] = "_CAST_START",
						["debuffType"] = "HARMFUL",
						["type"] = "spell",
						["event"] = "Cooldown Progress (Spell)",
						["use_exact_spellName"] = false,
						["realSpellName"] = "Death Wish",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_remaining"] = false,
						["unevent"] = "auto",
						["use_genericShowOn"] = true,
						["use_track"] = true,
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 16,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 26,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 49,
			["load"] = {
				["use_class"] = true,
				["use_talent"] = true,
				["use_never"] = false,
				["talent"] = {
					["single"] = 13,
					["multi"] = {
						[13] = true,
					},
				},
				["zoneIds"] = "",
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
			["uid"] = "avxsN)xYZoh",
			["icon"] = true,
			["cooldownEdge"] = false,
			["regionType"] = "icon",
			["parent"] = "Warrior 2.0",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["selfPoint"] = "CENTER",
			["zoom"] = 0.3,
			["width"] = 49,
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.15",
			["tocversion"] = 11302,
			["id"] = "Warrior - Sweeping Strikes",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayIcon"] = 132306,
			["cooldown"] = true,
			["authorOptions"] = {
			},
		},
		["Priest - Spirit Tap"] = {
			["iconSource"] = 0,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -262,
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
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["auranames"] = {
							"Spirit Tap", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["unitExists"] = true,
						["debuffType"] = "HELPFUL",
						["use_genericShowOn"] = true,
						["use_remaining"] = false,
						["spellName"] = 14751,
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["names"] = {
						},
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Inner Focus",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_unit"] = true,
						["type"] = "aura2",
						["useName"] = true,
						["use_track"] = true,
						["matchesShowOn"] = "showOnActive",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 26,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 49,
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
			["uid"] = "iZNzQGprV7)",
			["icon"] = true,
			["selfPoint"] = "CENTER",
			["regionType"] = "icon",
			["parent"] = "Priest 2.0",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["url"] = "https://wago.io/R8xGfpcxa/14",
			["cooldownTextDisabled"] = true,
			["width"] = 49,
			["zoom"] = 0.3,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Priest - Spirit Tap",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["xOffset"] = -98,
			["displayIcon"] = 136188,
			["cooldown"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Priest - Elune's Grace"] = {
			["iconSource"] = 0,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -327,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/R8xGfpcxa/14",
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
							"Flame Shock", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["unitExists"] = true,
						["spellName"] = 2651,
						["ownOnly"] = true,
						["useName"] = true,
						["unit"] = "target",
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["use_unit"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Elune's Grace",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["names"] = {
						},
						["type"] = "spell",
						["use_genericShowOn"] = true,
						["use_track"] = true,
						["debuffType"] = "HARMFUL",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
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
						["subeventPrefix"] = "SPELL",
						["unevent"] = "auto",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 22,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_race"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "PRIEST",
					["multi"] = {
						["SHAMAN"] = true,
					},
				},
				["use_class"] = true,
				["race"] = {
					["single"] = "NightElf",
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "pq(HuBXt1jJ",
			["icon"] = true,
			["selfPoint"] = "CENTER",
			["regionType"] = "icon",
			["cooldownEdge"] = false,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["xOffset"] = -105.77795410156,
			["cooldownTextDisabled"] = true,
			["width"] = 35.5,
			["zoom"] = 0.3,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Priest - Elune's Grace",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["authorOptions"] = {
			},
			["displayIcon"] = 135900,
			["cooldown"] = true,
			["parent"] = "Priest 2.0",
		},
		["Warrior - Intercept"] = {
			["iconSource"] = 0,
			["parent"] = "Warrior 2.0",
			["preferToUpdate"] = false,
			["yOffset"] = -155.77850341797,
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
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Rend", -- [1]
						},
						["ownOnly"] = true,
						["genericShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["unitExists"] = true,
						["spellName"] = 20252,
						["use_unit"] = true,
						["type"] = "spell",
						["debuffType"] = "HARMFUL",
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "target",
						["useName"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Intercept",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["names"] = {
						},
						["use_genericShowOn"] = true,
						["duration"] = "1",
						["use_track"] = true,
						["matchesShowOn"] = "showAlways",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 16,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_class"] = true,
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
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "9bYNGS4oSki",
			["xOffset"] = -34.777954101563,
			["authorOptions"] = {
			},
			["regionType"] = "icon",
			["url"] = "https://wago.io/z6xqQay0S/16",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["selfPoint"] = "CENTER",
			["zoom"] = 0.3,
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.15",
			["tocversion"] = 11302,
			["id"] = "Warrior - Intercept",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 35,
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayIcon"] = 132307,
			["cooldown"] = true,
			["icon"] = true,
		},
		["Priest - Shadow Word: Pain"] = {
			["iconSource"] = 0,
			["parent"] = "Priest 2.0",
			["preferToUpdate"] = false,
			["yOffset"] = -262,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/R8xGfpcxa/14",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["useName"] = true,
						["subeventSuffix"] = "_CAST_START",
						["ownOnly"] = true,
						["event"] = "Health",
						["unit"] = "target",
						["unitExists"] = true,
						["names"] = {
						},
						["spellIds"] = {
						},
						["type"] = "aura2",
						["auranames"] = {
							"Shadow Word: Pain", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HARMFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 26,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 49,
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
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["selfPoint"] = "CENTER",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["conditions"] = {
			},
			["cooldownEdge"] = false,
			["zoom"] = 0.3,
			["width"] = 49,
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Priest - Shadow Word: Pain",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = false,
			["uid"] = "M6ilNamtk(4",
			["inverse"] = false,
			["xOffset"] = -49,
			["displayIcon"] = 136207,
			["cooldown"] = true,
			["authorOptions"] = {
			},
		},
		["Druid - Moonfire"] = {
			["iconSource"] = 0,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -263,
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
			["triggers"] = {
				{
					["trigger"] = {
						["track"] = "auto",
						["auranames"] = {
							"Moonfire", -- [1]
						},
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showAlways",
						["unit"] = "target",
						["unitExists"] = true,
						["ownOnly"] = true,
						["debuffType"] = "HARMFUL",
						["spellName"] = 14287,
						["useName"] = true,
						["use_unit"] = true,
						["subeventSuffix"] = "_CAST_START",
						["type"] = "aura2",
						["subeventPrefix"] = "SPELL",
						["event"] = "Chat Message",
						["use_remaining"] = false,
						["realSpellName"] = "Arcane Shot",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["matchesShowOn"] = "showAlways",
						["unevent"] = "timed",
						["duration"] = "1",
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
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 14,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 26,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 49,
			["load"] = {
				["use_class"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
				["class"] = {
					["single"] = "DRUID",
					["multi"] = {
						["DRUID"] = true,
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
			["uid"] = "CQQqQGrYaS7",
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
			["parent"] = "Druid 2.0",
			["regionType"] = "icon",
			["authorOptions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["conditions"] = {
			},
			["icon"] = true,
			["cooldownTextDisabled"] = true,
			["width"] = 49,
			["zoom"] = 0.3,
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Druid - Moonfire",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["url"] = "https://wago.io/HCaWT5tJa/14",
			["displayIcon"] = 136096,
			["cooldown"] = true,
			["xOffset"] = -98,
		},
		["Warrior - Stoneform"] = {
			["iconSource"] = 0,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -155.78,
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
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Rend", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["unit"] = "target",
						["unitExists"] = true,
						["debuffType"] = "HARMFUL",
						["use_genericShowOn"] = true,
						["useName"] = true,
						["duration"] = "1",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["ownOnly"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Stoneform",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["type"] = "spell",
						["spellName"] = 20594,
						["use_track"] = true,
						["names"] = {
						},
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 16,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_race"] = true,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
						["ROGUE"] = true,
					},
				},
				["use_class"] = true,
				["race"] = {
					["single"] = "Dwarf",
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "L7seVJnuZcH",
			["xOffset"] = 106,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["parent"] = "Warrior 2.0",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["selfPoint"] = "CENTER",
			["zoom"] = 0.3,
			["width"] = 35,
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.15",
			["tocversion"] = 11302,
			["id"] = "Warrior - Stoneform",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["auto"] = false,
			["config"] = {
			},
			["inverse"] = false,
			["url"] = "https://wago.io/z6xqQay0S/16",
			["displayIcon"] = 136225,
			["cooldown"] = true,
			["icon"] = true,
		},
		["Warlock - Spell Lock"] = {
			["iconSource"] = 0,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -327,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["url"] = "https://wago.io/Y8douZITb/12",
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
							"Rend", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showAlways",
						["unit"] = "pet",
						["unitExists"] = true,
						["debuffType"] = "HARMFUL",
						["matchesShowOn"] = "showAlways",
						["useName"] = true,
						["use_unit"] = true,
						["subeventSuffix"] = "_CAST_START",
						["ownOnly"] = true,
						["spellName"] = 19244,
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Spell Lock",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["names"] = {
						},
						["type"] = "spell",
						["use_genericShowOn"] = true,
						["use_track"] = true,
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 12,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_class"] = true,
				["use_never"] = false,
				["talent"] = {
					["single"] = 49,
					["multi"] = {
						[49] = true,
					},
				},
				["zoneIds"] = "",
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "WARLOCK",
					["multi"] = {
						["MAGE"] = true,
						["PRIEST"] = true,
						["WARLOCK"] = true,
						["SHAMAN"] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "dzfoy4spTeX",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["cooldownEdge"] = false,
			["regionType"] = "icon",
			["xOffset"] = 0,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["icon"] = true,
			["cooldownTextDisabled"] = true,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["auto"] = false,
			["tocversion"] = 11302,
			["id"] = "Warlock - Spell Lock",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["width"] = 35,
			["semver"] = "1.0.11",
			["config"] = {
			},
			["inverse"] = false,
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
			["displayIcon"] = 136174,
			["cooldown"] = true,
			["parent"] = "Warlock 2.0",
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
			["internalVersion"] = 49,
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_text_format_p_time_precision"] = 1,
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_fontType"] = "OUTLINE",
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
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_time_format"] = 0,
					["text_text_format_p_format"] = "timed",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_visible"] = true,
				}, -- [4]
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
			["config"] = {
			},
			["selfPoint"] = "CENTER",
			["useTooltip"] = true,
			["regionType"] = "icon",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["authorOptions"] = {
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["zoom"] = 0.3,
			["width"] = 36,
			["cooldownTextDisabled"] = true,
			["auto"] = true,
			["tocversion"] = 90001,
			["id"] = "targetdebuffs ",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["semver"] = "1.0.0",
			["uid"] = "6DKG8nfVQ8x",
			["inverse"] = false,
			["parent"] = "DEBUFFS - TARGET",
			["conditions"] = {
			},
			["cooldown"] = true,
			["url"] = "https://wago.io/W1QyYtaAz/1",
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
						["duration"] = "1",
						["percenthealth"] = "100",
						["event"] = "Health",
						["use_unit"] = true,
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["spellIds"] = {
						},
						["unit"] = "target",
						["subeventPrefix"] = "SPELL",
						["use_percenthealth"] = true,
						["percenthealth_operator"] = "<=",
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
						["unit"] = "target",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["use_percenthealth"] = true,
						["percenthealth_operator"] = ">",
						["percenthealth"] = "50",
					},
					["untrigger"] = {
						["unit"] = "target",
					},
				}, -- [2]
				{
					["trigger"] = {
						["type"] = "custom",
						["custom"] = "function()\n    local region = aura_env.region\n    local plate = C_NamePlate.GetNamePlateForUnit(\"target\")\n    \n    \n    if plate then\n        region:ClearAllPoints()\n        region:SetPoint(\"RIGHT\", plate, \"LEFT\", -20, 0)\n        return true\n    else\n        return false\n    end\nend",
						["custom_type"] = "status",
						["check"] = "update",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [3]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["wordWrap"] = "WordWrap",
			["font"] = "Friz Quadrata TT",
			["version"] = 2,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
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
				["use_combat"] = true,
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
			["fontSize"] = 24,
			["shadowXOffset"] = 1,
			["regionType"] = "text",
			["conditions"] = {
			},
			["parent"] = "TARGET HP PERCENT",
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
			["automaticWidth"] = "Auto",
			["selfPoint"] = "BOTTOM",
			["justify"] = "LEFT",
			["semver"] = "1.0.1",
			["tocversion"] = 11306,
			["id"] = "MobHPPercentGREEN",
			["uid"] = "eckTlXrxzPt",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["xOffset"] = 0,
			["config"] = {
			},
			["shadowYOffset"] = -1,
			["authorOptions"] = {
			},
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["preferToUpdate"] = false,
		},
		["Warrior - Charge"] = {
			["iconSource"] = 0,
			["parent"] = "Warrior 2.0",
			["preferToUpdate"] = false,
			["yOffset"] = -155.77850341797,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/z6xqQay0S/16",
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
							"Charge", -- [1]
						},
						["matchesShowOn"] = "showAlways",
						["genericShowOn"] = "showAlways",
						["unit"] = "target",
						["unitExists"] = true,
						["debuffType"] = "HARMFUL",
						["names"] = {
						},
						["type"] = "spell",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["ownOnly"] = true,
						["useName"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["unevent"] = "auto",
						["realSpellName"] = "Charge",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["spellName"] = 6178,
						["use_genericShowOn"] = true,
						["duration"] = "1",
						["use_track"] = true,
						["use_unit"] = true,
					},
					["untrigger"] = {
						["genericShowOn"] = "showAlways",
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["event"] = "Conditions",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 16,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
			},
			["height"] = 35,
			["load"] = {
				["use_class"] = true,
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
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "eZ25lvk)KIQ",
			["authorOptions"] = {
			},
			["selfPoint"] = "CENTER",
			["regionType"] = "icon",
			["icon"] = true,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					},
				}, -- [1]
			},
			["cooldownEdge"] = false,
			["zoom"] = 0.3,
			["width"] = 35,
			["cooldownTextDisabled"] = true,
			["auto"] = false,
			["tocversion"] = 11302,
			["id"] = "Warrior - Charge",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["semver"] = "1.0.15",
			["config"] = {
			},
			["inverse"] = false,
			["xOffset"] = -69.777954101563,
			["displayIcon"] = 132337,
			["cooldown"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Warlock - Siphon"] = {
			["iconSource"] = 0,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -262,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["url"] = "https://wago.io/Y8douZITb/12",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura2",
						["subeventSuffix"] = "_CAST_START",
						["matchesShowOn"] = "showAlways",
						["event"] = "Health",
						["names"] = {
						},
						["unitExists"] = true,
						["subeventPrefix"] = "SPELL",
						["spellIds"] = {
						},
						["useName"] = true,
						["auranames"] = {
							"Siphon Life", -- [1]
						},
						["ownOnly"] = true,
						["unit"] = "target",
						["debuffType"] = "HARMFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 49,
			["keepAspectRatio"] = false,
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
			["desaturate"] = false,
			["version"] = 12,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
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
					["type"] = "subtext",
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 26,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
				}, -- [2]
				{
					["glowFrequency"] = 0.25,
					["type"] = "subglow",
					["useGlowColor"] = true,
					["glowType"] = "Pixel",
					["glowLength"] = 10,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["glow"] = false,
					["glowScale"] = 1,
					["glowThickness"] = 1,
					["glowLines"] = 8,
					["glowBorder"] = false,
				}, -- [3]
			},
			["height"] = 49,
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
					["single"] = "WARLOCK",
					["multi"] = {
						["WARLOCK"] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["uid"] = "o2yJdzvUMP(",
			["selfPoint"] = "CENTER",
			["parent"] = "Warlock 2.0",
			["regionType"] = "icon",
			["xOffset"] = 50,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = -2,
						["variable"] = "AND",
						["checks"] = {
							{
								["trigger"] = -1,
								["variable"] = "incombat",
								["value"] = 1,
							}, -- [1]
							{
								["trigger"] = 1,
								["variable"] = "buffed",
								["value"] = 1,
							}, -- [2]
							{
								["trigger"] = 1,
								["op"] = "<=",
								["value"] = "2",
								["variable"] = "expirationTime",
							}, -- [3]
						},
					},
					["changes"] = {
						{
							["value"] = true,
							["property"] = "sub.3.glow",
						}, -- [1]
					},
				}, -- [1]
			},
			["cooldownEdge"] = false,
			["auto"] = false,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["semver"] = "1.0.11",
			["tocversion"] = 11302,
			["id"] = "Warlock - Siphon",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["width"] = 49,
			["cooldownTextDisabled"] = true,
			["config"] = {
			},
			["inverse"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayIcon"] = 136188,
			["cooldown"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
		},
		["Warrior - Swing Timer"] = {
			["sparkWidth"] = 10,
			["sparkOffsetX"] = 0,
			["zoom"] = 0,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -107.99981689453,
			["anchorPoint"] = "CENTER",
			["iconSource"] = -1,
			["xOffset"] = 0,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
			["url"] = "https://wago.io/z6xqQay0S/16",
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
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Swing Timer",
						["use_absorbMode"] = true,
						["genericShowOn"] = "showOnActive",
						["use_unit"] = true,
						["names"] = {
						},
						["unit"] = "player",
						["spellIds"] = {
						},
						["use_hand"] = true,
						["subeventPrefix"] = "SPELL",
						["duration"] = "1",
						["hand"] = "main",
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
						["use_absorbMode"] = true,
						["event"] = "Conditions",
						["use_unit"] = true,
						["unevent"] = "auto",
						["duration"] = "1",
						["genericShowOn"] = "showOnActive",
						["subeventPrefix"] = "SPELL",
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
			["internalVersion"] = 49,
			["icon"] = false,
			["selfPoint"] = "CENTER",
			["backdropInFront"] = false,
			["fontFlags"] = "OUTLINE",
			["barColor"] = {
				0.78039215686274, -- [1]
				0.61176470588235, -- [2]
				0.43137254901961, -- [3]
				1, -- [4]
			},
			["stickyDuration"] = false,
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
			["useAdjustededMax"] = false,
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
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "INNER_RIGHT",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_fontType"] = "None",
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
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "INNER_LEFT",
					["text_fontSize"] = 12,
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
					["text_font"] = "Friz Quadrata TT",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "ICON_CENTER",
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_fontType"] = "None",
				}, -- [5]
				{
					["type"] = "subborder",
					["border_anchor"] = "bar",
					["border_offset"] = 1,
					["border_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["border_visible"] = true,
					["border_edge"] = "1 Pixel",
					["border_size"] = 1,
				}, -- [6]
			},
			["height"] = 15.000045776367,
			["config"] = {
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
				["zoneIds"] = "",
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
				["use_class"] = true,
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["faction"] = {
					["multi"] = {
					},
				},
				["ingroup"] = {
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
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["width"] = 244.99998474121,
			["alpha"] = 1,
			["backgroundColor"] = {
				0.31764705882353, -- [1]
				0.22745098039216, -- [2]
				0.16862745098039, -- [3]
				0.60000002384186, -- [4]
			},
			["id"] = "Warrior - Swing Timer",
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["borderInFront"] = true,
			["semver"] = "1.0.15",
			["icon_side"] = "RIGHT",
			["spark"] = false,
			["sparkHeight"] = 30,
			["texture"] = "Glamour2",
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["auto"] = true,
			["tocversion"] = 11302,
			["sparkHidden"] = "NEVER",
			["borderBackdrop"] = "None",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["version"] = 16,
			["uid"] = "Iywz9yb7Ws3",
			["inverse"] = true,
			["sparkDesature"] = false,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["parent"] = "Warrior 2.0",
		},
		["Superlilya's Loss of Control Effects"] = {
			["controlledChildren"] = {
				"Unstable govno", -- [1]
				"Loss of Control Icon", -- [2]
				"Curses and Viper", -- [3]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["wagoID"] = "pw_hjyCcX",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -23.169149785976,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["url"] = "https://wago.io/pw_hjyCcX/17",
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
			["internalVersion"] = 50,
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
			["desc"] = "Remake of https://wago.io/J6ydOqMsD/1",
			["version"] = 17,
			["subRegions"] = {
			},
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
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["scale"] = 0.9,
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "group",
			["borderSize"] = 2,
			["borderOffset"] = 4,
			["semver"] = "1.0.16",
			["tocversion"] = 20503,
			["id"] = "Superlilya's Loss of Control Effects",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["config"] = {
			},
			["borderInset"] = 1,
			["selfPoint"] = "BOTTOMLEFT",
			["xOffset"] = -0.87788903615603,
			["conditions"] = {
			},
			["information"] = {
				["groupOffset"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["uid"] = "TBWPr1GPJhe",
		},
		["Warrior 2.0"] = {
			["controlledChildren"] = {
				"Warrior - Battle Stance", -- [1]
				"Warrior - Berserker Stance", -- [2]
				"Warrior - Defensive Stance", -- [3]
				"Warrior - Taunt Resisted", -- [4]
				"Warrior - Rend", -- [5]
				"Warrior - Execute.", -- [6]
				"Warrior - Execute", -- [7]
				"Warrior - Thunderclap", -- [8]
				"Warrior - Shield Slam", -- [9]
				"Warrior - Bloodthirst", -- [10]
				"Warrior - Mortal Strike", -- [11]
				"Warrior - Shield Wall", -- [12]
				"Warrior - Charge", -- [13]
				"Warrior - Bloodrage", -- [14]
				"Warrior - Intercept", -- [15]
				"Warrior - Berserker Rage", -- [16]
				"Warrior - Heroic Strike", -- [17]
				"Warrior - Sweeping Strikes", -- [18]
				"Warrior - Death Wish", -- [19]
				"Warrior - Concussion Blow", -- [20]
				"Warrior - Overpower", -- [21]
				"Warrior - Overpower Active", -- [22]
				"Warrior - Whirlwind", -- [23]
				"Warrior  - Berserker", -- [24]
				"Warrior  - Blood Fury", -- [25]
				"Warrior - War Stomp", -- [26]
				"Warrior - Stoneform", -- [27]
				"Warrior - Shadowmeld", -- [28]
				"Warrior - Escape Artist", -- [29]
				"Warrior - Will of the Forsaken", -- [30]
				"Warrior - Perception", -- [31]
				"Warrior - Swing Timer", -- [32]
				"Warrior - Rage Bar", -- [33]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = -200,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["url"] = "https://wago.io/z6xqQay0S/16",
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
			["internalVersion"] = 49,
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
			["version"] = 16,
			["subRegions"] = {
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
				["use_class"] = "true",
				["role"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
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
				["race"] = {
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
			["scale"] = 0.8,
			["border"] = false,
			["borderEdge"] = "1 Pixel",
			["regionType"] = "group",
			["borderSize"] = 2,
			["borderOffset"] = 4,
			["semver"] = "1.0.15",
			["tocversion"] = 11302,
			["id"] = "Warrior 2.0",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["selfPoint"] = "BOTTOMLEFT",
			["uid"] = "uZA7A7H08kt",
			["xOffset"] = 0.0003814697265625,
			["config"] = {
			},
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
				["groupOffset"] = true,
			},
			["borderInset"] = 1,
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
			["selfPoint"] = "LEFT",
			["align"] = "CENTER",
			["stagger"] = 0,
			["version"] = 1,
			["subRegions"] = {
			},
			["borderEdge"] = "Square Full White",
			["fullCircle"] = true,
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
			["rotation"] = 0,
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["grow"] = "RIGHT",
			["animate"] = false,
			["useLimit"] = false,
			["scale"] = 1,
			["gridType"] = "RD",
			["border"] = false,
			["anchorFrameFrame"] = "nHealthStatusBar",
			["regionType"] = "dynamicgroup",
			["borderSize"] = 2,
			["limit"] = 5,
			["authorOptions"] = {
			},
			["config"] = {
			},
			["anchorFrameParent"] = true,
			["constantFactor"] = "RADIUS",
			["rowSpace"] = 1,
			["borderOffset"] = 4,
			["semver"] = "1.0.0",
			["tocversion"] = 90001,
			["id"] = "DEBUFFS - TARGET",
			["frameStrata"] = 1,
			["gridWidth"] = 5,
			["anchorFrameType"] = "SELECTFRAME",
			["borderInset"] = 1,
			["uid"] = "8aXp4Du0m4R",
			["sort"] = "none",
			["internalVersion"] = 49,
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
		},
	},
	["lastArchiveClear"] = 1602609267,
	["minimap"] = {
		["hide"] = true,
	},
	["lastUpgrade"] = 1642768680,
	["personalRessourceDisplayFrame"] = {
		["xOffset"] = -422.8046555407566,
		["yOffset"] = -497.8042091158466,
	},
	["dbVersion"] = 49,
	["registered"] = {
	},
	["login_squelch_time"] = 10,
	["frame"] = {
		["xOffset"] = -1520.731628417969,
		["yOffset"] = -65.8218994140625,
		["height"] = 858.9764404296875,
		["width"] = 916.6781005859375,
	},
	["instanceHistoryDb"] = {
		["sess"] = {
			["enterLoc"] = {
				["instance"] = -1,
			},
			["histOldest"] = "n/a",
			["delayUpdate"] = 1647176827,
			["histLiveCount"] = 0,
		},
		["History"] = {
		},
		["HistoryDay"] = {
		},
		["histGeneration"] = 235,
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
}
