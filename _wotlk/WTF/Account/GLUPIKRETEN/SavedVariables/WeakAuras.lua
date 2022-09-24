
WeakAurasSaved = {
	["dynamicIconCache"] = {
	},
	["editor_tab_spaces"] = 4,
	["login_squelch_time"] = 10,
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
			["cooldownSwipe"] = false,
			["cooldownEdge"] = false,
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
							"Backhand", -- [58]
							"Kodo Stomp", -- [59]
							"Smoke Bomb", -- [60]
							"Druid's Slumber", -- [61]
							"Scald", -- [62]
							"Terrifying Screech", -- [63]
							"11922", -- [64]
							"Charge", -- [65]
						},
						["useName"] = true,
						["debuffType"] = "HARMFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 53,
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
					["text_font"] = "Arial Narrow",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "OUTER_BOTTOM",
					["text_anchorYOffset"] = -30,
					["text_shadowXOffset"] = 3,
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_visible"] = true,
				}, -- [2]
				{
					["text_shadowXOffset"] = 2,
					["text_text"] = "%p",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "CENTER",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_p_time_format"] = 0,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["anchorXOffset"] = 0,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_text_format_p_time_precision"] = 1,
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
					["text_font"] = "Arial Narrow",
					["text_anchorYOffset"] = 20,
					["text_fontType"] = "OUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_TOP",
					["text_shadowYOffset"] = -2,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 26,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_p_time_mod_rate"] = true,
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
			["height"] = 40,
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
			["semver"] = "1.0.16",
			["config"] = {
			},
			["selfPoint"] = "CENTER",
			["useTooltip"] = false,
			["regionType"] = "icon",
			["cooldown"] = true,
			["parent"] = "Loss of Control Effects",
			["xOffset"] = 0,
			["authorOptions"] = {
			},
			["width"] = 40,
			["useCooldownModRate"] = true,
			["zoom"] = 0.3,
			["auto"] = true,
			["tocversion"] = 20503,
			["id"] = "Loss of Control Icon",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = true,
			["uid"] = "jbxJ5j0N4lg",
			["inverse"] = false,
			["url"] = "https://wago.io/pw_hjyCcX/17",
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
		["Main Hand"] = {
			["sparkWidth"] = 10,
			["sparkOffsetX"] = 0,
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["semver"] = "1.0.0",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["iconSource"] = -1,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
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
						["event"] = "Health",
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
			["internalVersion"] = 53,
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
			["icon"] = false,
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
					["text_text"] = "%p",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_precision"] = 1,
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
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 8,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
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
				["use_namerealm"] = true,
				["zoneIds"] = "",
				["namerealm"] = "xxxx",
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
				["use_combat"] = true,
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
			["xOffset"] = 0,
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 1,
			["sparkOffsetY"] = 0,
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["borderInFront"] = true,
			["sparkHidden"] = "NEVER",
			["icon_side"] = "RIGHT",
			["auto"] = true,
			["sparkHeight"] = 30,
			["texture"] = "Clean",
			["zoom"] = 0,
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["spark"] = false,
			["tocversion"] = 11302,
			["id"] = "Main Hand",
			["desaturate"] = false,
			["alpha"] = 1,
			["width"] = 200,
			["useAdjustededMax"] = false,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
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
				["debugLog"] = false,
				["ignoreOptionsEventErrors"] = true,
			},
			["parent"] = "Swing Timers",
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
			["internalVersion"] = 53,
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
					["text_text_format_p_time_precision"] = 1,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 26,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
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
			["auto"] = false,
			["uid"] = "IAzKObGM4EC",
			["parent"] = "Warlock 2.0",
			["selfPoint"] = "CENTER",
			["regionType"] = "icon",
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
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["url"] = "https://wago.io/Y8douZITb/12",
			["anchorFrameType"] = "SCREEN",
			["useCooldownModRate"] = true,
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.11",
			["tocversion"] = 11302,
			["id"] = "Warlock - Immolate",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 49,
			["zoom"] = 0.3,
			["config"] = {
			},
			["inverse"] = false,
			["xOffset"] = -98,
			["displayIcon"] = 135817,
			["cooldown"] = true,
			["icon"] = true,
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
			["internalVersion"] = 53,
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
			["semver"] = "1.0.0",
			["config"] = {
				["macro"] = {
					["text"] = "/cast Conjure Mana Agate",
				},
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
			["cooldownEdge"] = false,
			["regionType"] = "icon",
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
			["parent"] = "GEMS",
			["selfPoint"] = "CENTER",
			["width"] = 40,
			["useCooldownModRate"] = true,
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["tocversion"] = 11304,
			["id"] = "Agate",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0,
			["uid"] = "(9qU7Rw3V8a",
			["inverse"] = false,
			["xOffset"] = 0,
			["displayIcon"] = 134104,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					["key"] = "macro",
					["type"] = "group",
					["limitType"] = "none",
					["groupType"] = "simple",
					["collapse"] = false,
					["size"] = 10,
				}, -- [1]
			},
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
						["custom"] = "function()\n    \n    local uguid = UnitGUID(\"target\")\n    if uguid then\n        local sguid = {strsplit(\"-\",uguid)}\n        if sguid[1] == \"Creature\" then\n            local layerid = tonumber(sguid[5])\n            --- Orgrimmar ---\n            if layerid > 100 then\n                aura_env.text = \"L2\"\n            else\n                aura_env.text = \"L1\"\n            end\n        end\n    end\n    \n    return true\nend",
						["events"] = "PLAYER_TARGET_CHANGED",
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
			["internalVersion"] = 53,
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
			["conditions"] = {
			},
			["anchorFrameFrame"] = "Minimap",
			["regionType"] = "text",
			["preferToUpdate"] = false,
			["_table"] = "d",
			["automaticWidth"] = "Auto",
			["selfPoint"] = "CENTER",
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
			["semver"] = "1.0.3",
			["justify"] = "CENTER",
			["tocversion"] = 11304,
			["id"] = "Display Layer",
			["uid"] = "Sa)Gm93udM4",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SELECTFRAME",
			["shadowYOffset"] = -1,
			["config"] = {
			},
			["xOffset"] = 16,
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
			["displayText_format_c_format"] = "none",
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
			["xOffset"] = 15,
			["rowSpace"] = 1,
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
			["internalVersion"] = 53,
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["selfPoint"] = "LEFT",
			["animate"] = false,
			["arcLength"] = 360,
			["scale"] = 0.8,
			["fullCircle"] = true,
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "dynamicgroup",
			["borderSize"] = 2,
			["limit"] = 5,
			["sort"] = "none",
			["uid"] = "e(V6yQRHRNJ",
			["anchorFrameParent"] = true,
			["constantFactor"] = "RADIUS",
			["borderInset"] = 1,
			["borderOffset"] = 4,
			["semver"] = "1.0.0",
			["tocversion"] = 90001,
			["id"] = "DEBUFFS - PET",
			["gridWidth"] = 5,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SELECTFRAME",
			["anchorFrameFrame"] = "PetFrame",
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
			["gridType"] = "RD",
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["rotation"] = 0,
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
						["spellIds"] = {
						},
						["events"] = "PLAYER_ENTERING_WORLD WA_NAN_SHIELD",
						["subeventPrefix"] = "SPELL",
						["check"] = "update",
						["custom"] = "function(...)\n    return aura_env:on_tsu(...)\nend",
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
			["internalVersion"] = 53,
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
			["xOffset"] = 0,
			["texture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\target_indicator.tga",
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
			["discrete_rotation"] = 0,
			["semver"] = "1.0.0",
			["tocversion"] = 11305,
			["id"] = "nanShield:Segment",
			["parent"] = "Shield",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["width"] = 50,
			["uid"] = "VWzp20EQnk3",
			["config"] = {
				["direction"] = 1,
				["segmentCount"] = 20,
				["rotationOffset"] = 0,
				["curveAngle"] = 15,
				["debugEnabled"] = false,
			},
			["alpha"] = 0.48,
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
			["color"] = {
				0.1921568627451, -- [1]
				0.85882352941176, -- [2]
				1, -- [3]
				0.4200000166893, -- [4]
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
			["internalVersion"] = 53,
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
					["text_text_format_p_time_precision"] = 1,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 25,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
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
			["semver"] = "1.0.11",
			["config"] = {
			},
			["url"] = "https://wago.io/Y8douZITb/12",
			["parent"] = "Warlock 2.0",
			["regionType"] = "icon",
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
			["authorOptions"] = {
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
			["width"] = 35,
			["useCooldownModRate"] = true,
			["zoom"] = 0.3,
			["auto"] = false,
			["tocversion"] = 11302,
			["id"] = "Warlock - Healthstone #",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = false,
			["uid"] = "aJyTspXsqB0",
			["inverse"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["displayIcon"] = 135230,
			["cooldown"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
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
						["custom"] = "function()\n    local region = aura_env.region\n    local plate = C_NamePlate.GetNamePlateForUnit(\"target\")\n    \n    \n    if plate then\n        region:ClearAllPoints()\n        region:SetPoint(\"RIGHT\", plate, \"LEFT\", -60, 0)\n        return true\n    else\n        return false\n    end\nend",
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
			["internalVersion"] = 53,
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
				["size"] = {
					["multi"] = {
					},
				},
				["namerealm"] = "xxx",
				["use_combat"] = true,
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["fontSize"] = 24,
			["shadowXOffset"] = 1,
			["preferToUpdate"] = false,
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
			["selfPoint"] = "BOTTOM",
			["semver"] = "1.0.1",
			["uid"] = "skENiiv2ip)",
			["justify"] = "LEFT",
			["tocversion"] = 11306,
			["id"] = "MobHPPercentYELLOW",
			["xOffset"] = 0,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["shadowYOffset"] = -1,
			["config"] = {
			},
			["authorOptions"] = {
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
				["ignoreOptionsEventErrors"] = true,
			},
			["displayText_format_c_format"] = "none",
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
			["internalVersion"] = 53,
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
			["xOffset"] = 0,
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
			["automaticWidth"] = "Auto",
			["justify"] = "LEFT",
			["tocversion"] = 11302,
			["id"] = "Warrior - Defensive Stance",
			["config"] = {
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["authorOptions"] = {
			},
			["uid"] = "QwSE99UBSjg",
			["semver"] = "1.0.15",
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
						["events"] = "COMBAT_LOG_EVENT_UNFILTERED",
						["debuffType"] = "HELPFUL",
						["name"] = "Freezing Trap",
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
						["custom"] = "function(_,_,subEvent,_,sourceGUID,_,_,_,destGUID,_,_,_,_,spell)\n    local e = aura_env\n    if (subEvent == \"SPELL_AURA_APPLIED\" or subEvent == \"SPELL_AURA_REFRESH\") and spell == e.spell and sourceGUID == e.playerGUID then\n        e.target = destGUID\n        e.startTime = GetTime()\n        e.expirationTime = e.startTime + e.duration\n        e.broken = false\n        return true\n    elseif (subEvent == \"SPELL_AURA_REMOVED\" or subEvent == \"SPELL_AURA_BROKEN\") and spell == e.spell and sourceGUID == e.playerGUID then\n        e.target = e.target or \"\"\n        if destGUID == e.target then \n            e.broken = true\n        end\n    end\nend\n\n\n\n\n\n\n\n",
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
			["internalVersion"] = 53,
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
					["text_text_format_p_time_precision"] = 1,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
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
				["use_class"] = true,
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
				["class_and_spec"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["auto"] = true,
			["uid"] = "AmSea7yVXh4",
			["parent"] = "Warlock 2.0",
			["icon"] = true,
			["regionType"] = "icon",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["conditions"] = {
			},
			["xOffset"] = 71,
			["cooldownEdge"] = false,
			["anchorFrameType"] = "SCREEN",
			["useCooldownModRate"] = true,
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.11",
			["tocversion"] = 11302,
			["id"] = "Warlock - Banish Timer",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 35,
			["zoom"] = 0.3,
			["config"] = {
			},
			["inverse"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayIcon"] = 136135,
			["cooldown"] = true,
			["selfPoint"] = "CENTER",
		},
		["Druid - CP3"] = {
			["color"] = {
				0.99607843137255, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -275,
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
			["internalVersion"] = 53,
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
				["use_class"] = false,
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
			["selfPoint"] = "CENTER",
			["texture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_White",
			["discrete_rotation"] = 0,
			["parent"] = "DRUID / ROGUE",
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Druid - CP3",
			["xOffset"] = -1.0000610351562,
			["frameStrata"] = 2,
			["width"] = 67,
			["alpha"] = 1,
			["uid"] = "q5EKjjhf3aN",
			["config"] = {
			},
			["anchorFrameType"] = "SCREEN",
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["authorOptions"] = {
			},
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
			["internalVersion"] = 53,
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
					["text_text_format_p_time_precision"] = 1,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
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
			["semver"] = "1.0.11",
			["uid"] = "ZT61i6aT2So",
			["parent"] = "Warlock 2.0",
			["icon"] = true,
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
			["cooldownEdge"] = false,
			["selfPoint"] = "CENTER",
			["width"] = 35,
			["useCooldownModRate"] = true,
			["cooldownTextDisabled"] = true,
			["auto"] = false,
			["tocversion"] = 11302,
			["id"] = "Warlock  - Blood Fury",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["config"] = {
			},
			["inverse"] = false,
			["xOffset"] = 106,
			["displayIcon"] = 135726,
			["cooldown"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
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
						["spellIds"] = {
						},
						["custom"] = "function(...)\n    return aura_env:on_tsu(...)\nend",
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
			["internalVersion"] = 53,
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
			["url"] = "https://wago.io/TPKPLjUo4/1",
			["regionType"] = "text",
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
			["preferToUpdate"] = false,
			["shadowYOffset"] = 0,
			["displayText_format_p_time_precision"] = 1,
			["uid"] = "pGdpCt6LJm)",
			["parent"] = "Shield",
			["semver"] = "1.0.0",
			["justify"] = "CENTER",
			["tocversion"] = 11305,
			["id"] = "nanShield:Text",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.49742370843887, -- [4]
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["wordWrap"] = "WordWrap",
			["config"] = {
				["debugEnabled"] = false,
			},
			["displayText_format_p_time_legacy_floor"] = true,
			["displayText_format_p_time_dynamic_threshold"] = 0,
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
			["displayText_format_p_time_mod_rate"] = true,
		},
		["Ranged"] = {
			["sparkWidth"] = 10,
			["borderBackdrop"] = "Blizzard Tooltip",
			["parent"] = "Swing Timers",
			["preferToUpdate"] = false,
			["auto"] = true,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["sparkOffsetX"] = 0,
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
						["subeventPrefix"] = "SPELL",
						["use_inverse"] = false,
						["event"] = "Health",
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
			["internalVersion"] = 53,
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
					["text_text_format_p_time_precision"] = 1,
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
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 8,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
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
				["use_namerealm"] = true,
				["zoneIds"] = "",
				["namerealm"] = "xxxx",
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
				["use_combat"] = true,
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
			["authorOptions"] = {
			},
			["anchorFrameType"] = "SCREEN",
			["alpha"] = 1,
			["version"] = 1,
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["borderInFront"] = true,
			["sparkHidden"] = "NEVER",
			["icon_side"] = "RIGHT",
			["semver"] = "1.0.0",
			["sparkHeight"] = 30,
			["texture"] = "Clean",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["zoom"] = 0,
			["spark"] = false,
			["tocversion"] = 11302,
			["id"] = "Ranged",
			["stickyDuration"] = false,
			["frameStrata"] = 1,
			["width"] = 200,
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["config"] = {
			},
			["inverse"] = true,
			["icon"] = false,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["xOffset"] = 0,
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
			["internalVersion"] = 53,
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
			["stagger"] = 0,
			["version"] = 1,
			["subRegions"] = {
			},
			["borderInset"] = 1,
			["rowSpace"] = 1,
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
			["anchorPoint"] = "CENTER",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["radius"] = 300,
			["animate"] = false,
			["customGrow"] = "function(newPositions, activeRegions)\n    local offset = 9/64 -- target_indicator_glow texture center offset\n    local distance = 18/64\n    local angle, x, y, h, w, s, c, sb, cb, da\n    local curveAngle, segmentCount, direction, base, direction\n\n    for i, r in ipairs(activeRegions) do\n        if r.region.GetRotation then\n            direction = r.data.config.direction\n            base = (r.data.config.rotationOffset + direction * 180)\n            angle = r.region:GetRotation() - direction * 180\n            h = r.data.height\n            w = r.data.width\n            curveAngle = r.data.config.curveAngle\n            segmentCount = r.data.config.segmentCount\n            s = sin(angle)\n            c = cos(angle)\n            sb = sin(base + (direction - 1) * 180)\n            cb = cos(base + (direction - 1) * 180)\n            da = curveAngle / (segmentCount - 1)\n            radius = 0.5 * w * distance / sin(da / 2)\n            x = c * radius + s * w * offset * (direction - 1.5) * 2 + radius * cb\n            y = s * radius * h / w - c * h * offset * (direction - 1.5) * 2 + radius * h / w * sb\n        else\n            x = 0\n            y = 0\n        end\n\n        if newPositions[i] then\n            newPositions[i][1] = x\n            newPositions[i][2] = y\n        else\n            newPositions[i] = {x, y}\n        end\n    end\nend\n",
			["scale"] = 1,
			["useLimit"] = false,
			["border"] = false,
			["borderEdge"] = "1 Pixel",
			["regionType"] = "dynamicgroup",
			["borderSize"] = 2,
			["limit"] = 5,
			["sort"] = "none",
			["fullCircle"] = true,
			["constantFactor"] = "RADIUS",
			["arcLength"] = 30,
			["borderOffset"] = 4,
			["semver"] = "1.0.0",
			["tocversion"] = 11305,
			["id"] = "Shield",
			["frameStrata"] = 1,
			["gridWidth"] = 5,
			["anchorFrameType"] = "SCREEN",
			["authorOptions"] = {
			},
			["config"] = {
			},
			["uid"] = "QYuwGRyspxh",
			["groupIcon"] = 135988,
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["selfPoint"] = "CENTER",
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
			["internalVersion"] = 53,
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
					["text_text_format_p_time_precision"] = 1,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 26,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
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
			["semver"] = "1.0.11",
			["uid"] = "4JH1rebDRsF",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["url"] = "https://wago.io/Y8douZITb/12",
			["regionType"] = "icon",
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
			["xOffset"] = 99,
			["authorOptions"] = {
			},
			["width"] = 49,
			["useCooldownModRate"] = true,
			["cooldownTextDisabled"] = true,
			["auto"] = false,
			["tocversion"] = 11302,
			["id"] = "Warlock - Shadowburn",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["config"] = {
			},
			["inverse"] = false,
			["icon"] = true,
			["displayIcon"] = 136191,
			["cooldown"] = true,
			["selfPoint"] = "CENTER",
		},
		["Druid - Mana Bar "] = {
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
				["use_class"] = false,
				["race"] = {
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
				["role"] = {
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
			["texture"] = "Clean",
			["zoom"] = 0,
			["auto"] = true,
			["tocversion"] = 11302,
			["alpha"] = 1,
			["config"] = {
			},
			["sparkOffsetX"] = 0,
			["parent"] = "DRUID / ROGUE",
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
						["health_operator"] = ">=",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
						["use_requirePowerType"] = true,
						["use_percentpower"] = false,
						["subeventPrefix"] = "SPELL",
						["event"] = "Power",
						["health"] = "0",
						["spellIds"] = {
						},
						["duration"] = "1",
						["subeventSuffix"] = "_CAST_START",
						["genericShowOn"] = "showOnActive",
						["unevent"] = "auto",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "all",
				["customTriggerLogic"] = "function(trigger)\n    local glow = aura_env.region\n    \n    if (trigger[1]) then\n        glow:SetGlow(true)\n    else\n        glow:SetGlow(false)\n    end\n    \n    return trigger[2]\nend\n\n\n\n\n",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 53,
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
					["text_font"] = "Arial Narrow",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "INNER_RIGHT",
					["text_fontType"] = "None",
					["text_fontSize"] = 15,
					["anchorXOffset"] = 0,
					["text_text_format_c_format"] = "none",
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
				"Clean", -- [1]
			},
			["icon"] = false,
			["semver"] = "1.0.13",
			["anchorFrameType"] = "SCREEN",
			["id"] = "Druid - Mana Bar ",
			["spark"] = false,
			["frameStrata"] = 3,
			["width"] = 245,
			["sparkHidden"] = "NEVER",
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
			["internalVersion"] = 53,
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
			["semver"] = "1.0.0",
			["uid"] = ")OLyGVxasS6",
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
			["regionType"] = "icon",
			["cooldown"] = false,
			["displayIcon"] = 132805,
			["parent"] = "GEMS",
			["xOffset"] = 160,
			["anchorFrameType"] = "SCREEN",
			["useCooldownModRate"] = true,
			["cooldownTextDisabled"] = false,
			["auto"] = true,
			["tocversion"] = 11304,
			["id"] = "Water",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 40,
			["zoom"] = 0,
			["config"] = {
				["macro"] = {
					["text"] = "/cast Conjure Water",
				},
			},
			["inverse"] = false,
			["url"] = "https://wago.io/U0WH3IJ3S/1",
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
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
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
			["internalVersion"] = 53,
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
			["radius"] = 200,
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
				["role"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["use_class"] = "false",
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
				["difficulty"] = {
					["multi"] = {
					},
				},
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
			["useLimit"] = true,
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["uid"] = "RtwiT9kw4p3",
			["animate"] = false,
			["selfPoint"] = "TOP",
			["scale"] = 1,
			["rotation"] = 0,
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "dynamicgroup",
			["borderSize"] = 2,
			["limit"] = 1,
			["fullCircle"] = true,
			["sort"] = "none",
			["constantFactor"] = "RADIUS",
			["authorOptions"] = {
			},
			["borderOffset"] = 4,
			["semver"] = "1.0.1",
			["tocversion"] = 11306,
			["id"] = "TARGET HP PERCENT",
			["gridWidth"] = 5,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["groupIcon"] = 136168,
			["borderInset"] = 1,
			["rowSpace"] = 1,
			["grow"] = "DOWN",
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["anchorPoint"] = "CENTER",
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
				["finish"] = {
					["do_custom"] = true,
				},
				["init"] = {
					["custom"] = "C_ChatInfo.RegisterAddonMessagePrefix(\"AVT\")\naura_env.bosses = {\n    [11948] = true, -- Vanndar\n    [11946] = true, -- Drek\n    [11947] = true, -- Galv\n    [11949] = true, -- Balinda\n}\naura_env.timeTick = GetTime()\naura_env.locale = GetLocale()\naura_env.L = {\n    [\"enUS\"] = {\n        \"was taken by the\", -- HERALD/BG\n        \"(.-) was taken by the\", -- HERALD/BG\n        \"If left unchallenged, the\", -- BG\n        \"% claims the (.-)%!  If left unchallenged, the\", -- BG\n        \"If left unchecked, the\", -- HERALD\n        \"(.-) is under attack!  If left unchecked, the\", -- HERALD\n        \"Alliance\", -- HERALD ALLIANCE CHECK\n        \"1 minute until the battle for Alterac Valley begins.\", -- START\n        \"You are now AFK: Away from Keyboard\", -- AFK\n        \"WHO DARES SUMMON LOKHOLAR?\", -- Lokholar the Ice Lord\n    },\n}\n\n\n\nWorldStateScoreFrameLeaveButton:SetScript(\"PreClick\", function(self)\n        WeakAuras.ScanEvents(\"AVT_LEAVE\")\nend)\n\naura_env.timestamp = GetTime()\n\naura_env.IsBoss = function ()\n    \n    local _, _, _, _, _, id_mouseover = string.match(UnitGUID(\"mouseover\") or \"\",\"(%a+)-(%d+)-(%d+)-(%d+)-(%d+)-(%d+)\")\n    \n    if aura_env.bosses[tonumber(id_mouseover or 0)] == true then return true, UnitName(\"mouseover\"), UnitHealth(\"mouseover\") / UnitHealthMax(\"mouseover\") * 100 end\n    \n    if aura_env.timeTick + 0.5 < GetTime() then\n        aura_env.timeTick = GetTime() \n        \n        for unit in WA_IterateGroupMembers() do\n            local _, _, _, _, _, id = string.match(UnitGUID(unit .. \"target\") or \"\",\"(%a+)-(%d+)-(%d+)-(%d+)-(%d+)-(%d+)\")\n            \n            if aura_env.bosses[tonumber(id or 0)] == true then\n                return true, UnitName(unit .. \"target\"), UnitHealth(unit .. \"target\") / UnitHealthMax(unit .. \"target\") * 100\n            end\n        end\n        \n    end\n    \n    return false\nend",
					["do_custom"] = true,
				},
			},
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
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
			["load"] = {
				["use_never"] = false,
				["zone"] = "Alterac Valley",
				["class"] = {
					["multi"] = {
					},
				},
				["use_encounterid"] = false,
				["use_zone"] = true,
				["zoneIds"] = "",
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
			},
			["glowType"] = "buttonOverlay",
			["glowThickness"] = 1,
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["texture"] = "Clean",
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
			["internalVersion"] = 53,
			["glowXOffset"] = 0,
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
					["anchorYOffset"] = 0,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 3,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Expressway",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = -1,
					["text_shadowXOffset"] = 1,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_RIGHT",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_fontType"] = "None",
					["text_fontSize"] = 10,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
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
					["text_shadowXOffset"] = 1,
					["text_fontSize"] = 10,
					["anchorXOffset"] = 0,
					["text_visible"] = true,
				}, -- [4]
			},
			["height"] = 12,
			["glowLines"] = 8,
			["sparkBlendMode"] = "ADD",
			["glowFrequency"] = 0.25,
			["source"] = "import",
			["spark"] = false,
			["glowLength"] = 10,
			["icon"] = false,
			["zoom"] = 0,
			["authorOptions"] = {
			},
			["icon_side"] = "RIGHT",
			["useAdjustededMax"] = false,
			["cooldownTextDisabled"] = false,
			["sparkHeight"] = 30,
			["config"] = {
			},
			["anchorFrameType"] = "SCREEN",
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["custom_type"] = "stateupdate",
						["debuffType"] = "HELPFUL",
						["event"] = "Health",
						["unit"] = "player",
						["events"] = "AVT_LEAVE CHAT_MSG_SYSTEM CHAT_MSG_MONSTER_YELL CHAT_MSG_BG_SYSTEM_ALLIANCE CHAT_MSG_BG_SYSTEM_HORDE CHAT_MSG_BG_SYSTEM_NEUTRAL CHAT_MSG_ADDON COMBAT_LOG_EVENT_UNFILTERED:UNIT_DIED",
						["custom"] = "function(s, e, ...)\n    \n    -- Boss Death\n    if (e == \"COMBAT_LOG_EVENT_UNFILTERED\") then\n        local _, _, _, _, _, _, _, guid, bossName = select(1, ...)\n        local _, _, _, _, _, id = string.match(guid or \"\",\"(%a+)-(%d+)-(%d+)-(%d+)-(%d+)-(%d+)\")\n        \n        if aura_env.bosses[tonumber(id or 0)] == true then\n            C_ChatInfo.SendAddonMessage(\"AVT\", bossName .. \": \" .. 0, \"INSTANCE_CHAT\") \n            return true\n        end\n    end\n    \n    -- Boss HP\n    local prefix, text = select(1, ...)\n    \n    if (e == \"CHAT_MSG_ADDON\") and prefix == \"AVT\" then\n        local bossName = string.match(text or \"\", \"(.-):\")\n        local bossHP = tonumber(string.match(text, \"%d+\"))\n        \n        \n        if bossHP == 0 then\n            s[bossName] = {\n                show = false,\n                changed = true\n            }\n        else\n            s[bossName] = {\n                show = true,\n                changed = true,\n                progressType = \"static\",\n                total = 100,\n                value  = bossHP,\n                name = bossName,\n                index = -100000000000,\n                boss = true\n            }\n        end\n        \n        return true\n    end\n    \n    local msg = select(1,...)\n    \n    -- Clear timers\n    if e == \"AVT_LEAVE\" or \n    (e == \"CHAT_MSG_SYSTEM\" and string.find(msg or \"\", aura_env.L[aura_env.locale][9]) or 0 > 0) then\n        for _, state in pairs(s) do\n            state.show = false;\n            state.changed = true;\n        end\n        \n        return true\n    end\n    \n    -- BG begins timer\n    if e == \"CHAT_MSG_BG_SYSTEM_NEUTRAL\" then\n        if (string.find(msg or \"\", aura_env.L[aura_env.locale][8]) or 0 > 0) then\n            s[\"begin\"] = {\n                show = true,\n                changed = true,      \n                progressType = \"timed\",\n                duration = 62,\n                expirationTime = GetTime() + 62,\n                name = \"Begins\",\n                index = 0,\n                autoHide = true,\n                start = true\n            }\n        end\n        return true\n    end\n    \n    -- Tower/GY timers\n    if e == \"CHAT_MSG_BG_SYSTEM_ALLIANCE\" or \n    e == \"CHAT_MSG_BG_SYSTEM_HORDE\" or \n    e == \"CHAT_MSG_MONSTER_YELL\" then\n        \n        -- Re-take\n        if (string.find(msg or \"\", aura_env.L[aura_env.locale][1]) or 0 > 0) then\n            local tower = string.match(msg or \"\", aura_env.L[aura_env.locale][2])\n            \n            if s[tower] then\n                s[tower] = {\n                    show = false,\n                    changed = true,\n                }\n                return true\n            end\n        end\n        \n        -- Take\n        if (e == \"CHAT_MSG_MONSTER_YELL\" and \n            string.find(msg or \"\", aura_env.L[aura_env.locale][5]) or 0 > 0 or \n            string.find(msg or \"\", aura_env.L[aura_env.locale][3]) or 0 > 0) then\n            \n            local tower = (e == \"CHAT_MSG_MONSTER_YELL\" and \n                string.match(msg or \"\", aura_env.L[aura_env.locale][6]) or\n                string.match(msg or \"\", aura_env.L[aura_env.locale][4]))\n            \n            s[tower] = {\n                show = true,\n                changed = true,      \n                progressType = \"timed\",\n                duration = 240,\n                expirationTime = GetTime() + 240,\n                name = tower,\n                index = -(GetTime() + 240),\n                autoHide = true,\n                horde = (e == \"CHAT_MSG_MONSTER_YELL\" and \n                    (string.find(msg or \"\", aura_env.L[aura_env.locale][7]) or 0 > 0 and false or true) or\n                    (e == \"CHAT_MSG_BG_SYSTEM_ALLIANCE\" and false or true))\n            }\n            return true\n        end\n        \n        -- Lokholar the Ice Lord\n        if (e == \"CHAT_MSG_MONSTER_YELL\" and string.find(msg or \"\", aura_env.L[aura_env.locale][10])) then\n            \n            s[\"lokholar\"] = {\n                show = true,\n                changed = true,      \n                progressType = \"timed\",\n                duration = 600,\n                expirationTime = GetTime() + 600,\n                name = \"Lokholar\",\n                index = -(GetTime() + 600),\n                autoHide = true,\n                lokholar = true\n            }\n            return true\n        end\n        \n    end\n    \nend",
						["spellIds"] = {
						},
						["names"] = {
						},
						["check"] = "event",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["customVariables"] = "{\n    horde = \"bool\",\n    start = \"bool\",\n    boss = \"bool\",\n    lokholar = \"bool\",\n}",
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
						["subeventSuffix"] = "_CAST_START",
						["check"] = "update",
						["custom_type"] = "status",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["semver"] = "1.0.13",
			["sparkHidden"] = "NEVER",
			["id"] = "Av Timers",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["frameStrata"] = 1,
			["width"] = 250,
			["uid"] = "xLlxouEMW)Z",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["inverse"] = true,
			["tocversion"] = 20503,
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
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["authorOptions"] = {
			},
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "group",
			["borderSize"] = 2,
			["xOffset"] = -400,
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["selfPoint"] = "CENTER",
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
			["borderOffset"] = 4,
			["internalVersion"] = 53,
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
			["id"] = "MISSING BUFFS",
			["uid"] = "Q6V((Odtb2N",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["borderInset"] = 1,
			["config"] = {
			},
			["anchorPoint"] = "CENTER",
			["scale"] = 1,
			["conditions"] = {
			},
			["information"] = {
			},
			["yOffset"] = 400,
		},
		["Druid - CP2"] = {
			["color"] = {
				0.99607843137255, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -275,
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
			["internalVersion"] = 53,
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
				["use_class"] = false,
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
			["anchorFrameType"] = "SCREEN",
			["texture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_White",
			["parent"] = "DRUID / ROGUE",
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
			["frameStrata"] = 2,
			["width"] = 67,
			["alpha"] = 1,
			["uid"] = "fm4HOrzkFYa",
			["config"] = {
			},
			["authorOptions"] = {
			},
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
			["internalVersion"] = 53,
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
					["text_text_format_p_time_precision"] = 1,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
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
			["semver"] = "1.0.11",
			["uid"] = "P9GqvS8YXtq",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
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
			["icon"] = true,
			["anchorFrameType"] = "SCREEN",
			["useCooldownModRate"] = true,
			["cooldownTextDisabled"] = true,
			["auto"] = false,
			["tocversion"] = 11302,
			["id"] = "Warlock - Will of the Forsaken",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 35,
			["zoom"] = 0.3,
			["config"] = {
			},
			["inverse"] = false,
			["url"] = "https://wago.io/Y8douZITb/12",
			["displayIcon"] = 136187,
			["cooldown"] = true,
			["xOffset"] = 106,
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
			["internalVersion"] = 53,
			["selfPoint"] = "BOTTOMRIGHT",
			["align"] = "RIGHT",
			["anchorPerUnit"] = "NAMEPLATE",
			["frameStrata"] = 1,
			["groupIcon"] = 132281,
			["stagger"] = 0,
			["useLimit"] = false,
			["version"] = 5,
			["subRegions"] = {
			},
			["radius"] = 200,
			["rotation"] = 0,
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
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["authorOptions"] = {
			},
			["animate"] = false,
			["uid"] = "6GCI4uu)d8g",
			["scale"] = 1,
			["customAnchor"] = "ChatFrame3",
			["border"] = false,
			["anchorFrameFrame"] = "ChatFrame3",
			["regionType"] = "dynamicgroup",
			["borderSize"] = 2,
			["limit"] = 5,
			["useAnchorPerUnit"] = false,
			["config"] = {
			},
			["constantFactor"] = "RADIUS",
			["arcLength"] = 360,
			["borderOffset"] = 4,
			["semver"] = "1.0.4",
			["tocversion"] = 11302,
			["id"] = "Professions Skill Tracker",
			["sort"] = "none",
			["gridWidth"] = 5,
			["anchorFrameType"] = "SELECTFRAME",
			["borderEdge"] = "1 Pixel",
			["borderInset"] = 1,
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
			["rowSpace"] = 1,
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["anchorPoint"] = "TOPRIGHT",
		},
		["PST bar"] = {
			["sparkWidth"] = 10,
			["sparkOffsetX"] = 0,
			["xOffset"] = 0,
			["adjustedMax"] = 51,
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
						["spellIds"] = {
						},
						["events"] = "CHAT_MSG_SKILL, SKILL_LINES_CHANGED",
						["check"] = "event",
						["custom"] = "function(allstates, event, ...)\n    if event == \"OPTIONS\" then return false end\n    if event == \"CHAT_MSG_SKILL\" or event == \"SKILL_LINES_CHANGED\" then\n        local btns = aura_env.pst_btns\n        local profs = aura_env.pst_profs\n        for i=1,GetNumSkillLines() do\n            local skillName, isHeader, isExpanded, skillRank, numTempPoints, skillModifier,\n            skillMaxRank, isAbandonable, stepCost, rankCost, minLevel, skillCostType, skillDescription = GetSkillLineInfo(i)\n            if profs[skillName] and profs[skillName]['spell'] then\n                allstates[skillName] = allstates[skillName] or {}\n                local state = allstates[skillName] \n                if state.value == skillRank and state.total == skillMaxRank then state.changed = false\n                else\n                    state.name = skillName\n                    state.value = skillRank\n                    state.progressType = 'static'\n                    state.total = skillMaxRank\n                    state.custom = skillRank .. \" / \" .. skillMaxRank\n                    state.index = i\n                    --state.autoHide = true\n                    state.animation = true\n                    state.show = true\n                    state.changed = true\n                end\n            end \n        end\n--        C_Timer.After(3, function()\n--                for clId, clRegion in pairs(WeakAuras.clones['PST bar']) do\n--                    if not btns[clId] then            \n--                        btns[clId] = CreateFrame(\"Button\", nil, UIParent, \"SecureActionButtonTemplate\")            \n--                        btns[clId]:SetNormalTexture(profs[clId]['icon'])\n--                        if profs[clId]['spell'] ~= 'none' then\n--                            btns[clId]:SetAttribute(\"type\", \"spell\")\n--                            btns[clId]:SetAttribute(\"spell\", profs[clId]['spell'])\n--                        end\n--                    end\n--                    local point, relativeTo, relativePoint, xOfs, yOfs = clRegion:GetPoint()\n--                    btns[clId]:SetPoint(point, relativeTo, relativePoint, xOfs-30, yOfs+15)\n--                    btns[clId]:SetWidth(clRegion:GetHeight()+15)\n--                    btns[clId]:SetHeight(clRegion:GetHeight()+15)\n--                end\n--        end)\n    end\n    return true\nend",
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
			["internalVersion"] = 53,
			["iconSource"] = 0,
			["selfPoint"] = "CENTER",
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
			["useTooltip"] = true,
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
			["config"] = {
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
			["preferToUpdate"] = false,
			["anchorFrameType"] = "SCREEN",
			["alpha"] = 1,
			["sparkOffsetY"] = 0,
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["sparkHidden"] = "NEVER",
			["spark"] = true,
			["icon_side"] = "LEFT",
			["semver"] = "1.0.4",
			["sparkHeight"] = 10,
			["texture"] = "Clean",
			["backgroundColor"] = {
				0.031372549019608, -- [1]
				0.39607843137255, -- [2]
				0.79607843137255, -- [3]
				0.3313250541687, -- [4]
			},
			["sparkTexture"] = "Legionfall_BarSpark",
			["auto"] = false,
			["tocversion"] = 11302,
			["id"] = "PST bar",
			["sparkDesaturate"] = false,
			["frameStrata"] = 1,
			["width"] = 250,
			["color"] = {
			},
			["uid"] = "dfN5x1GBI6G",
			["inverse"] = false,
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
					["scaley"] = 1,
					["alpha"] = 0,
					["preset"] = "shrink",
					["y"] = 0,
					["colorType"] = "pulseColor",
					["rotate"] = 0,
					["duration_type"] = "seconds",
					["colorFunc"] = "    function(progress, r1, g1, b1, a1, r2, g2, b2, a2)\n      local angle = (progress * 2 * math.pi) - (math.pi / 2)\n      local newProgress = ((math.sin(angle) + 1)/2);\n      return r1 + (newProgress * (r2 - r1)),\n           g1 + (newProgress * (g2 - g1)),\n           b1 + (newProgress * (b2 - b1)),\n           a1 + (newProgress * (a2 - a1))\n    end\n  ",
					["easeStrength"] = 3,
					["x"] = 0,
					["use_color"] = true,
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
					["x"] = 0,
					["scaley"] = 1,
					["alpha"] = 0,
					["rotate"] = 0,
					["y"] = 0,
					["colorType"] = "custom",
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
					["x"] = 0,
					["preset"] = "grow",
					["alpha"] = 0,
					["rotate"] = 0,
					["y"] = 0,
					["colorType"] = "pulseColor",
					["duration_type"] = "seconds",
					["duration"] = "2",
					["colorFunc"] = "    function(progress, r1, g1, b1, a1, r2, g2, b2, a2)\n      local angle = (progress * 2 * math.pi) - (math.pi / 2)\n      local newProgress = ((math.sin(angle) + 1)/2);\n      return r1 + (newProgress * (r2 - r1)),\n           g1 + (newProgress * (g2 - g1)),\n           b1 + (newProgress * (b2 - b1)),\n           a1 + (newProgress * (a2 - a1))\n    end\n  ",
					["easeStrength"] = 3,
					["use_color"] = true,
					["scaley"] = 1,
				},
			},
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["parent"] = "Professions Skill Tracker",
		},
		["Druid - CP1"] = {
			["color"] = {
				0.99607843137255, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -275,
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
			["internalVersion"] = 53,
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
				["use_class"] = false,
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
			["anchorFrameType"] = "SCREEN",
			["texture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_White",
			["parent"] = "DRUID / ROGUE",
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
			["frameStrata"] = 2,
			["width"] = 67,
			["alpha"] = 1,
			["uid"] = "1G6vzVZFHu5",
			["config"] = {
			},
			["authorOptions"] = {
			},
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["xOffset"] = -99.99987792969,
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
			["internalVersion"] = 53,
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
			["auto"] = true,
			["uid"] = "fPDDaU)G8Wc",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["selfPoint"] = "CENTER",
			["regionType"] = "icon",
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
			["parent"] = "GEMS",
			["cooldownEdge"] = false,
			["width"] = 40,
			["useCooldownModRate"] = true,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.0.0",
			["tocversion"] = 11304,
			["id"] = "Citrine",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0,
			["config"] = {
				["macro"] = {
					["text"] = "/cast Conjure Mana Citrine",
				},
			},
			["inverse"] = false,
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
			["displayIcon"] = 134116,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["icon"] = true,
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
			["gridType"] = "RD",
			["internalVersion"] = 53,
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
			["authorOptions"] = {
			},
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["rowSpace"] = 1,
			["animate"] = false,
			["rotation"] = 0,
			["scale"] = 1,
			["useLimit"] = false,
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "dynamicgroup",
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
			["config"] = {
			},
			["anchorFrameParent"] = true,
			["constantFactor"] = "RADIUS",
			["anchorFrameFrame"] = "nHealthStatusBar",
			["borderOffset"] = 4,
			["semver"] = "1.0.0",
			["tocversion"] = 90001,
			["id"] = "DEBUFFS - TARGET",
			["frameStrata"] = 1,
			["gridWidth"] = 5,
			["anchorFrameType"] = "SELECTFRAME",
			["borderInset"] = 1,
			["uid"] = "8aXp4Du0m4R",
			["limit"] = 5,
			["grow"] = "RIGHT",
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["fullCircle"] = true,
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
						["events"] = "WA_NAN_SHIELD",
						["spellIds"] = {
						},
						["custom"] = "function(...)\n  return aura_env:on_tsu(...)\nend",
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
			["internalVersion"] = 53,
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
			["semver"] = "1.0.0",
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["width"] = 200,
			["alpha"] = 1,
			["icon_side"] = "RIGHT",
			["zoom"] = 0,
			["sparkHeight"] = 30,
			["texture"] = "Glamour2",
			["auto"] = true,
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["spark"] = false,
			["tocversion"] = 11305,
			["id"] = "nanShield:Bar",
			["overlayclip"] = false,
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
				["finish"] = {
				},
				["init"] = {
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
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["type"] = "aura2",
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
					["glowFrequency"] = 0.75,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["text_color"] = {
					},
					["glowThickness"] = 2,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0.85098039215686, -- [2]
						0.1843137254902, -- [3]
						1, -- [4]
					},
					["useGlowColor"] = true,
					["glowScale"] = 1,
					["glowType"] = "Pixel",
					["glowLength"] = 16,
					["glow"] = true,
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
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
					["text_fontType"] = "THICKOUTLINE",
					["text_anchorYOffset"] = 45,
					["text_text_format_t_time_precision"] = 1,
					["text_text_format_p_time_format"] = 0,
					["text_text"] = "%n",
					["text_anchorPoint"] = "CENTER",
					["text_shadowXOffset"] = 0,
					["text_text_format_p_abbreviate_max"] = 8,
					["text_justify"] = "CENTER",
					["text_text_format_t_time_dynamic_threshold"] = 60,
					["text_text_format_p_time_dynamic_threshold"] = 0,
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
				["use_class"] = false,
				["zoneIds"] = "",
				["class"] = {
					["single"] = "PALADIN",
					["multi"] = {
						["PALADIN"] = true,
					},
				},
				["use_never"] = false,
				["level"] = "60",
				["level_operator"] = ">=",
				["size"] = {
					["multi"] = {
					},
				},
			},
			["useCooldownModRate"] = true,
			["anchorFrameType"] = "SCREEN",
			["parent"] = "MISSING BUFFS",
			["xOffset"] = 0,
			["cooldown"] = false,
			["conditions"] = {
			},
			["regionType"] = "icon",
			["icon"] = true,
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["config"] = {
			},
			["url"] = "https://wago.io/v9qxdDgI4/2",
			["zoom"] = 0.3,
			["semver"] = "1.0.1",
			["cooldownTextDisabled"] = false,
			["auto"] = false,
			["tocversion"] = 20501,
			["id"] = "PALADIN",
			["authorOptions"] = {
			},
			["alpha"] = 1,
			["width"] = 65.000114440918,
			["frameStrata"] = 1,
			["uid"] = "OjIToprvHv1",
			["inverse"] = false,
			["internalVersion"] = 53,
			["displayIcon"] = "",
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
			["internalVersion"] = 53,
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
					["multi"] = {
						[11] = true,
					},
				},
				["use_talent"] = false,
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
			["fontSize"] = 31,
			["discrete_rotation"] = 0,
			["shadowXOffset"] = 1,
			["shadowYOffset"] = -1,
			["mirror"] = false,
			["wordWrap"] = "WordWrap",
			["regionType"] = "text",
			["conditions"] = {
			},
			["blendMode"] = "ADD",
			["selfPoint"] = "CENTER",
			["preferToUpdate"] = false,
			["texture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura4",
			["automaticWidth"] = "Auto",
			["width"] = 400,
			["justify"] = "LEFT",
			["tocversion"] = 11302,
			["id"] = "Warlock - Nightfall Proc",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["semver"] = "1.0.11",
			["uid"] = "qsj48Npc6ke",
			["authorOptions"] = {
			},
			["color"] = {
				0.50980392156863, -- [1]
				0.074509803921569, -- [2]
				0.74509803921569, -- [3]
				1, -- [4]
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
			["parent"] = "Warlock 2.0",
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
				["finish"] = {
				},
				["init"] = {
					["do_custom"] = false,
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
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Health",
						["custom_type"] = "status",
						["customDuration"] = "function()\n    -- Set the duration of the timer\n    local duration = aura_env.throttleTime\n    -- Set the progress bar fill time relative to GetTime()\n    -- ex: GetTime() + Spell Duration = Spell Complete Time\n    local expirationTime = aura_env.expirationTime\n    return duration, expirationTime\n    -- %p, %t\nend",
						["custom"] = "function()\n    local nextTrack\n    local herbTracking = GetSpellInfo(\"Find Herbs\")\n    local mineralTracking = GetSpellInfo(\"Find Minerals\")\n    local isNotTracking = GetTrackingTexture() == nil\n    local isInit = (aura_env.lastTrackToggleTime == nil)\n    local theTime = GetTime()\n    local notInCombat = not InCombatLockdown()\n    local notResting = not IsResting()\n    local IsFlying = IsFlying()\n    local notChanneling = not ChannelInfo()\n    local notCasting = not CastingInfo()\n    local haveTarget = UnitExists(\"target\")\n    local unitalive = not UnitIsDead(\"player\")\n    \n    local showProgressBar = true\n    \n    for i=1,80 do \n        local buff = UnitBuff(\"player\", i)\n        if buff and buff == \"Shadowy Disguise\" then \n            showProgressBar = false\n        end\n    end\n    \n    -- Set throttle speed based on mount status\n    if IsMounted() == false and aura_env.config.mvmtstatus == true then\n        aura_env.throttleTime = aura_env.config.wthrottlespeed\n    else\n        aura_env.throttleTime = aura_env.config.mthrottlespeed\n    end\n    \n    -- Check to see that either tracking method is known and the player is not in a resting area\n    if (herbTracking or mineralTracking) and unitalive and notInCombat and notResting and notCasting and notChanneling and not haveTarget and showProgressBar then\n        -- Only toggle if the duration has expired\n        if not aura_env.last or aura_env.last < theTime - aura_env.throttleTime then\n            -- Set the progress bar fill expiration time relative to GetTime()\n            -- ex: GetTime() + Spell Duration = Spell Complete Time\n            aura_env.expirationTime = theTime + aura_env.throttleTime\n            -- Print out the delay time the option is enabled\n            if aura_env.config.verbosetext == true then\n                print(\"Toggled after \" .. aura_env.throttleTime .. \" seconds.\")\n            end\n            aura_env.last = theTime\n            if herbTracking ~= nil and mineralTracking == nil and isNotTracking then\n                -- Turn on herb tracking if that's all that's been learned\n                nextTrack = herbTracking\n            elseif mineralTracking ~= nil and herbTracking == nil and isNotTracking then\n                -- Turn on mineral tracking if that's all that's been learned\n                nextTrack = mineralTracking\n            elseif herbTracking ~= nil and mineralTracking ~= nil then\n                -- If we have both herb and mineral tracking toggle between them\n                if aura_env.lastTrack ~= herbTracking then\n                    nextTrack = herbTracking\n                elseif aura_env.lastTrack ~= mineralTracking then\n                    nextTrack = mineralTracking\n                end\n            end\n            if nextTrack ~= nil  then\n                -- Print out the action if the option is enabled\n                if aura_env.config.verbosetext == true then\n                    if isInit then\n                        print(\"Initializing: \"..nextTrack)\n                    elseif aura_env.lastTrack ~= nil then\n                        print(\"Toggling: \"..aura_env.lastTrack..\" -> \"..nextTrack)\n                    else\n                        print(\"Missing: \"..nextTrack)\n                    end\n                end\n                -- Cast the spell\n                CastSpellByName(nextTrack)\n                aura_env.lastTrackToggleTime = theTime\n                aura_env.lastTrack = nextTrack\n            end\n        end\n        -- Return the bool custom option to show or hide the progress bar\n        return aura_env.config.showprogress\n    end\nend",
						["events"] = "UPDATE_SHAPESHIFT_FORM",
						["custom_hide"] = "timed",
						["check"] = "update",
						["spellIds"] = {
						},
						["use_unit"] = true,
						["names"] = {
						},
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
			["internalVersion"] = 53,
			["selfPoint"] = "CENTER",
			["barColor"] = {
				0.6313725490196078, -- [1]
				1, -- [2]
				0.2196078431372549, -- [3]
				1, -- [4]
			},
			["desc"] = "Made specifically for Druids with SWIFT flight form and both gathering professions, herbalism and mining.",
			["alpha"] = 1,
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
					["text_shadowXOffset"] = 1,
					["text_text_format_t_time_dynamic_threshold"] = 60,
					["text_text_format_p_format"] = "timed",
					["text_text_format_p_time_legacy_floor"] = true,
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["text_text_format_t_time_format"] = 0,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_t_format"] = "timed",
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_text_format_p_time_format"] = 0,
					["type"] = "subtext",
					["text_text_format_p_time_precision"] = 1,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_fontType"] = "None",
					["text_shadowYOffset"] = -1,
					["text_visible"] = false,
					["text_wordWrap"] = "WordWrap",
					["text_text_format_t_time_mod_rate"] = true,
					["text_anchorPoint"] = "INNER_LEFT",
					["anchorXOffset"] = 0,
					["text_text_format_t_time_legacy_floor"] = true,
					["text_fontSize"] = 12,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_p_time_mod_rate"] = true,
				}, -- [3]
			},
			["height"] = 4,
			["sparkOffsetX"] = 0,
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
				["zoneIds"] = "",
				["namerealm"] = "Mxzq",
				["use_exact_spellknown"] = false,
				["use_spellknown"] = false,
				["use_itemequiped"] = false,
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
				["use_combat"] = false,
				["spellknown"] = 2580,
				["itemtypeequipped"] = {
				},
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["icon"] = false,
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
			["version"] = 4,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["config"] = {
				["showprogress"] = true,
				["mthrottlespeed"] = 5,
				["mvmtstatus"] = false,
				["wthrottlespeed"] = 20,
				["verbosetext"] = false,
			},
			["zoom"] = 0,
			["icon_side"] = "RIGHT",
			["anchorFrameType"] = "SCREEN",
			["sparkHeight"] = 30,
			["texture"] = "Clean",
			["spark"] = false,
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["semver"] = "1.0.3",
			["tocversion"] = 20502,
			["id"] = "Herbaning Switch",
			["sparkHidden"] = "NEVER",
			["frameStrata"] = 1,
			["width"] = 99.999954223633,
			["auto"] = true,
			["uid"] = "dSVImVtgjk5",
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
			["authorOptions"] = {
				{
					["type"] = "range",
					["useDesc"] = true,
					["max"] = 10,
					["step"] = 0.5,
					["width"] = 1,
					["min"] = 0,
					["key"] = "mthrottlespeed",
					["default"] = 3.5,
					["name"] = "Cycle Time",
					["desc"] = "Change the delay between toggling on\\between find minerals and herbs while mounted.",
				}, -- [1]
				{
					["type"] = "range",
					["useDesc"] = true,
					["max"] = 20,
					["step"] = 0.5,
					["width"] = 1,
					["min"] = 0,
					["key"] = "wthrottlespeed",
					["default"] = 10,
					["name"] = "Dismounted Cycle Time",
					["desc"] = "Change the delay between toggling on\\between find minerals and herbs while dismounted.",
				}, -- [2]
				{
					["type"] = "space",
					["variableWidth"] = true,
					["height"] = 1,
					["useHeight"] = false,
					["width"] = 1,
				}, -- [3]
				{
					["type"] = "toggle",
					["key"] = "mvmtstatus",
					["width"] = 1,
					["name"] = "Mount Auto Throttle Control",
					["useDesc"] = true,
					["default"] = true,
					["desc"] = "Enables the \"Dismounted Cycle Time\" option to control the frequency of find toggles based on mount status.",
				}, -- [4]
				{
					["text"] = "",
					["type"] = "header",
					["useName"] = false,
					["width"] = 1,
				}, -- [5]
				{
					["type"] = "toggle",
					["key"] = "verbosetext",
					["width"] = 1,
					["name"] = "Verbose Text",
					["useDesc"] = true,
					["default"] = true,
					["desc"] = "Give detailed information in the chat pain on what the WeakAra is doing.",
				}, -- [6]
				{
					["type"] = "toggle",
					["key"] = "showprogress",
					["width"] = 1,
					["name"] = "Show Progress Bar",
					["useDesc"] = true,
					["default"] = true,
					["desc"] = "Shows a depleting progress bar for each cycle.",
				}, -- [7]
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
			["internalVersion"] = 53,
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
					["text_text_format_p_time_precision"] = 1,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
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
			["auto"] = false,
			["uid"] = "BW)LRVWY28d",
			["icon"] = true,
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
			["xOffset"] = 36,
			["cooldownEdge"] = false,
			["width"] = 35,
			["useCooldownModRate"] = true,
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.11",
			["tocversion"] = 11302,
			["id"] = "Warlock - Howl of Terror",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["config"] = {
			},
			["inverse"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayIcon"] = 136147,
			["cooldown"] = true,
			["selfPoint"] = "CENTER",
		},
		["DRUID / ROGUE"] = {
			["controlledChildren"] = {
				"Druid - Rage Bar", -- [1]
				"Druid - Mana Bar ", -- [2]
				"Druid - Energy Bar", -- [3]
				"Druid - Mana Bar Cat/Bear", -- [4]
				"Druid - CP1", -- [5]
				"Druid - CP2", -- [6]
				"Druid - CP3", -- [7]
				"Druid - CP4", -- [8]
				"Druid - CP5", -- [9]
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
			["internalVersion"] = 53,
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
			["id"] = "DRUID / ROGUE",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["xOffset"] = 0,
			["config"] = {
			},
			["borderInset"] = 1,
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
			["uid"] = "IUvIXiYBA4q",
		},
		["DRUID"] = {
			["iconSource"] = -1,
			["wagoID"] = "v9qxdDgI4",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
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
						["auranames"] = {
							"Mark of the Wild", -- [1]
							"Gift of the Wild", -- [2]
						},
						["matchesShowOn"] = "showOnMissing",
						["genericShowOn"] = "showOnReady",
						["unit"] = "player",
						["use_genericShowOn"] = true,
						["debuffType"] = "HELPFUL",
						["spellName"] = 34428,
						["type"] = "aura2",
						["useExactSpellId"] = false,
						["subeventSuffix"] = "_CAST_START",
						["duration"] = "1",
						["subeventPrefix"] = "SPELL",
						["event"] = "Action Usable",
						["useName"] = true,
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["names"] = {
						},
						["unevent"] = "auto",
						["useNamePattern"] = false,
						["use_track"] = true,
						["use_unit"] = true,
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
						["debuffType"] = "HELPFUL",
						["matchesShowOn"] = "showOnMissing",
						["useName"] = true,
						["unit"] = "player",
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
					["glowFrequency"] = 0.75,
					["type"] = "subglow",
					["useGlowColor"] = true,
					["text_color"] = {
					},
					["glowThickness"] = 2,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0.85098039215686, -- [2]
						0.1843137254902, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["glowScale"] = 1,
					["glow"] = true,
					["glowLength"] = 16,
					["glowType"] = "Pixel",
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
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
					["text_text_format_p_time_precision"] = 1,
					["text_anchorYOffset"] = 45,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_text_format_t_time_dynamic_threshold"] = 60,
					["text_text_format_p_abbreviate"] = false,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_abbreviate_max"] = 8,
					["text_text"] = "%n",
					["text_text_format_p_time_format"] = 0,
					["text_text_format_t_time_precision"] = 1,
					["text_fontType"] = "THICKOUTLINE",
				}, -- [3]
			},
			["height"] = 65.000022888184,
			["load"] = {
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["level_operator"] = ">=",
				["use_class"] = false,
				["size"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["use_level"] = false,
				["level"] = "60",
				["class"] = {
					["single"] = "PALADIN",
					["multi"] = {
						["DRUID"] = true,
					},
				},
				["zoneIds"] = "",
			},
			["alpha"] = 1,
			["width"] = 65.000114440918,
			["parent"] = "MISSING BUFFS",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["displayIcon"] = "",
			["regionType"] = "icon",
			["selfPoint"] = "CENTER",
			["internalVersion"] = 53,
			["uid"] = "d9W)ExaN7hc",
			["xOffset"] = 0,
			["cooldownEdge"] = false,
			["auto"] = false,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.0.1",
			["tocversion"] = 20501,
			["id"] = "DRUID",
			["zoom"] = 0.3,
			["useCooldownModRate"] = true,
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 1,
			["config"] = {
			},
			["inverse"] = false,
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["conditions"] = {
			},
			["cooldown"] = false,
			["icon"] = true,
		},
		["Predatory Strikes"] = {
			["controlledChildren"] = {
				"VrIcon 2", -- [1]
				"timer 2", -- [2]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["wagoID"] = "v9qxdDgI4",
			["xOffset"] = 0,
			["preferToUpdate"] = false,
			["yOffset"] = 530,
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
			["internalVersion"] = 53,
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
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
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
			["borderOffset"] = 4,
			["semver"] = "1.0.1",
			["tocversion"] = 20501,
			["id"] = "Predatory Strikes",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["uid"] = "5b1Ydv3(uLY",
			["borderInset"] = 1,
			["config"] = {
			},
			["selfPoint"] = "CENTER",
			["conditions"] = {
			},
			["information"] = {
			},
			["authorOptions"] = {
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
			["yOffset"] = -275,
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
			["internalVersion"] = 53,
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
				["use_class"] = false,
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
			["selfPoint"] = "CENTER",
			["texture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_White",
			["discrete_rotation"] = 0,
			["parent"] = "DRUID / ROGUE",
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Druid - CP5",
			["xOffset"] = 97.999755859375,
			["frameStrata"] = 2,
			["width"] = 69,
			["alpha"] = 1,
			["uid"] = "klWFLF0NXf8",
			["config"] = {
			},
			["anchorFrameType"] = "SCREEN",
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["authorOptions"] = {
			},
		},
		["VrIcon"] = {
			["iconSource"] = 0,
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
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["duration"] = "1",
						["genericShowOn"] = "showOnReady",
						["use_unit"] = true,
						["debuffType"] = "HELPFUL",
						["type"] = "spell",
						["unevent"] = "auto",
						["spellName"] = 34428,
						["event"] = "Action Usable",
						["unit"] = "player",
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["names"] = {
						},
						["use_genericShowOn"] = true,
						["subeventSuffix"] = "_CAST_START",
						["use_track"] = true,
						["subeventPrefix"] = "SPELL",
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
					["glowFrequency"] = 0.75,
					["type"] = "subglow",
					["useGlowColor"] = true,
					["text_color"] = {
					},
					["glowThickness"] = 2,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0.85098039215686, -- [2]
						0.1843137254902, -- [3]
						1, -- [4]
					},
					["glowXOffset"] = 0,
					["glowScale"] = 1,
					["glow"] = true,
					["glowLength"] = 16,
					["glowType"] = "Pixel",
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
				{
					["type"] = "subborder",
					["border_offset"] = 0,
					["border_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["border_visible"] = false,
					["border_edge"] = "Blizzard Dialog",
					["border_size"] = 1,
				}, -- [3]
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
					["text_shadowXOffset"] = 0,
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_text_format_t_time_dynamic_threshold"] = 60,
					["text_text_format_p_abbreviate"] = false,
					["text_justify"] = "CENTER",
					["text_text_format_t_time_mod_rate"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text"] = "%t",
					["text_text_format_t_time_precision"] = 1,
					["text_visible"] = true,
					["text_text_format_t_time_legacy_floor"] = true,
					["text_text_format_p_time_format"] = 0,
				}, -- [4]
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
					["text_anchorYOffset"] = -5,
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
					["text_shadowYOffset"] = 0,
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
					["text_text_format_p_time_format"] = 0,
				}, -- [5]
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
					["text_text_format_p_time_precision"] = 1,
					["type"] = "subtext",
					["anchorXOffset"] = 0,
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
					["text_fontType"] = "OUTLINE",
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_shadowXOffset"] = 0,
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 12,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_p_time_mod_rate"] = true,
				}, -- [6]
			},
			["height"] = 65.000022888184,
			["load"] = {
				["use_level"] = true,
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
				["size"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["spec"] = {
					["multi"] = {
					},
				},
				["level"] = "60",
				["level_operator"] = ">=",
				["zoneIds"] = "",
			},
			["frameStrata"] = 1,
			["width"] = 65.000114440918,
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["parent"] = "VictoryRush",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["displayIcon"] = 132342,
			["regionType"] = "icon",
			["url"] = "https://wago.io/v9qxdDgI4/2",
			["xOffset"] = 0,
			["uid"] = "1UZvvfknxj(",
			["authorOptions"] = {
			},
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["auto"] = false,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.0.1",
			["tocversion"] = 20501,
			["id"] = "VrIcon",
			["zoom"] = 0.3,
			["useCooldownModRate"] = true,
			["anchorFrameType"] = "SCREEN",
			["alpha"] = 1,
			["config"] = {
			},
			["inverse"] = false,
			["internalVersion"] = 53,
			["conditions"] = {
			},
			["cooldown"] = false,
			["selfPoint"] = "CENTER",
		},
		["Warrior 2.0"] = {
			["controlledChildren"] = {
				"Warrior - Battle Stance", -- [1]
				"Warrior - Berserker Stance", -- [2]
				"Warrior - Defensive Stance", -- [3]
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
			["internalVersion"] = 53,
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
				["race"] = {
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
				["role"] = {
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
			["borderEdge"] = "1 Pixel",
			["regionType"] = "group",
			["borderSize"] = 2,
			["borderOffset"] = 4,
			["semver"] = "1.0.15",
			["tocversion"] = 11302,
			["id"] = "Warrior 2.0",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["borderInset"] = 1,
			["config"] = {
			},
			["xOffset"] = 0.00030517578125,
			["selfPoint"] = "BOTTOMLEFT",
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
				["groupOffset"] = true,
			},
			["uid"] = "uZA7A7H08kt",
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
			["columnSpace"] = 1,
			["internalVersion"] = 53,
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
			["gridWidth"] = 5,
			["stagger"] = 0,
			["selfPoint"] = "TOP",
			["version"] = 14,
			["subRegions"] = {
			},
			["useLimit"] = false,
			["sortHybridTable"] = {
				["Av Timers"] = false,
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
			["gridType"] = "RD",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["animate"] = false,
			["source"] = "import",
			["rotation"] = 0,
			["scale"] = 1,
			["borderInset"] = 1,
			["border"] = false,
			["anchorFrameFrame"] = "Questie_BaseFrame",
			["regionType"] = "dynamicgroup",
			["borderSize"] = 2,
			["limit"] = 5,
			["rowSpace"] = 1,
			["arcLength"] = 360,
			["anchorFrameParent"] = true,
			["constantFactor"] = "RADIUS",
			["uid"] = "8E8nv4OfjBN",
			["borderOffset"] = 4,
			["semver"] = "1.0.13",
			["tocversion"] = 20503,
			["id"] = "AV Timers",
			["xOffset"] = -130,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SELECTFRAME",
			["sort"] = "none",
			["config"] = {
			},
			["borderEdge"] = "Square Full White",
			["radius"] = 200,
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
		},
		["Loss of Control Effects"] = {
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
			["yOffset"] = 280,
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
			["internalVersion"] = 53,
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
			["scale"] = 1.6,
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "group",
			["borderSize"] = 2,
			["borderOffset"] = 4,
			["semver"] = "1.0.16",
			["tocversion"] = 20503,
			["id"] = "Loss of Control Effects",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["uid"] = "TBWPr1GPJhe",
			["config"] = {
			},
			["selfPoint"] = "BOTTOMLEFT",
			["borderInset"] = 1,
			["conditions"] = {
			},
			["information"] = {
				["groupOffset"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["xOffset"] = 0,
		},
		["Druid - CP4"] = {
			["color"] = {
				0.99607843137255, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["preferToUpdate"] = false,
			["yOffset"] = -275,
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
			["internalVersion"] = 53,
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
				["use_class"] = false,
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
			["selfPoint"] = "CENTER",
			["texture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_White",
			["discrete_rotation"] = 0,
			["parent"] = "DRUID / ROGUE",
			["semver"] = "1.0.13",
			["tocversion"] = 11302,
			["id"] = "Druid - CP4",
			["xOffset"] = 47.999755859375,
			["frameStrata"] = 2,
			["width"] = 67,
			["alpha"] = 1,
			["uid"] = "JmoDu(YlHE3",
			["config"] = {
			},
			["anchorFrameType"] = "SCREEN",
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["authorOptions"] = {
			},
		},
		["VrIcon 2"] = {
			["iconSource"] = 0,
			["wagoID"] = "v9qxdDgI4",
			["parent"] = "Predatory Strikes",
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = true,
			["cooldownEdge"] = false,
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["auranames"] = {
							"Predator's Swiftness", -- [1]
						},
						["duration"] = "1",
						["genericShowOn"] = "showOnReady",
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
						["type"] = "aura2",
						["matchesShowOn"] = "showOnActive",
						["unevent"] = "auto",
						["useName"] = true,
						["subeventPrefix"] = "SPELL",
						["event"] = "Action Usable",
						["spellName"] = 0,
						["realSpellName"] = 0,
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["use_genericShowOn"] = true,
						["use_unit"] = true,
						["use_track"] = true,
						["names"] = {
						},
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
					["glowFrequency"] = 0.75,
					["type"] = "subglow",
					["glowXOffset"] = 0,
					["text_color"] = {
					},
					["glowThickness"] = 2,
					["glowYOffset"] = 0,
					["glowColor"] = {
						1, -- [1]
						0.85098039215686, -- [2]
						0.1843137254902, -- [3]
						1, -- [4]
					},
					["useGlowColor"] = true,
					["glowScale"] = 1,
					["glowType"] = "Pixel",
					["glowLength"] = 16,
					["glow"] = true,
					["glowLines"] = 6,
					["glowBorder"] = false,
				}, -- [2]
				{
					["border_offset"] = 0,
					["border_size"] = 1,
					["border_color"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["border_visible"] = false,
					["border_edge"] = "Blizzard Dialog",
					["type"] = "subborder",
				}, -- [3]
				{
					["text_shadowXOffset"] = 0,
					["text_text_format_s_format"] = "none",
					["text_text"] = "%t",
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
					["text_text_format_p_abbreviate"] = false,
					["text_text_format_t_format"] = "timed",
					["type"] = "subtext",
					["text_text_format_p_time_format"] = 0,
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_t_time_legacy_floor"] = true,
					["text_visible"] = false,
					["text_text_format_t_time_precision"] = 1,
					["text_text_format_p_time_precision"] = 1,
					["text_text_format_t_time_mod_rate"] = true,
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_big_number_format"] = "AbbreviateNumbers",
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_text_format_p_abbreviate_max"] = 8,
					["text_justify"] = "CENTER",
					["text_text_format_t_time_dynamic_threshold"] = 60,
				}, -- [4]
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
					["text_anchorXOffset"] = 5,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["anchorXOffset"] = 0,
					["text_anchorYOffset"] = -5,
					["text_shadowColor"] = {
						0, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "INNER_BOTTOMRIGHT",
					["text_text_format_p_time_precision"] = 1,
					["text_fontType"] = "OUTLINE",
					["text_fontSize"] = 20,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_shadowYOffset"] = 0,
				}, -- [5]
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
					["text_visible"] = false,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_p_format"] = "timed",
				}, -- [6]
			},
			["height"] = 65.000022888184,
			["load"] = {
				["use_never"] = false,
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
				["use_class"] = true,
				["zoneIds"] = "",
				["level_operator"] = ">=",
				["use_level"] = false,
				["level"] = "60",
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["useCooldownModRate"] = true,
			["anchorFrameType"] = "SCREEN",
			["url"] = "https://wago.io/v9qxdDgI4/2",
			["internalVersion"] = 53,
			["cooldown"] = false,
			["conditions"] = {
			},
			["regionType"] = "icon",
			["xOffset"] = 0,
			["desc"] = "Weak aura that shows if Victory Rush is usabe with a remaning duration.\n",
			["config"] = {
			},
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
			["semver"] = "1.0.1",
			["cooldownTextDisabled"] = false,
			["auto"] = false,
			["tocversion"] = 20501,
			["id"] = "VrIcon 2",
			["zoom"] = 0.3,
			["frameStrata"] = 1,
			["width"] = 65.000114440918,
			["alpha"] = 1,
			["uid"] = "h1vWgdcfhYt",
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["displayIcon"] = 132185,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["authorOptions"] = {
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
			["internalVersion"] = 53,
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
					["text_text_format_p_time_precision"] = 1,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 26,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
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
			["auto"] = false,
			["uid"] = "GsA28ml6aTO",
			["parent"] = "Warlock 2.0",
			["selfPoint"] = "CENTER",
			["regionType"] = "icon",
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
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["url"] = "https://wago.io/Y8douZITb/12",
			["anchorFrameType"] = "SCREEN",
			["useCooldownModRate"] = true,
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.11",
			["tocversion"] = 11302,
			["id"] = "Warlock - Corruption",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 49,
			["zoom"] = 0.3,
			["config"] = {
			},
			["inverse"] = false,
			["xOffset"] = 0,
			["displayIcon"] = 136118,
			["cooldown"] = true,
			["icon"] = true,
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
				["spec"] = {
					["multi"] = {
					},
				},
				["class"] = {
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
			["texture"] = "Clean",
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
						["unit"] = "player",
						["event"] = "Health",
						["names"] = {
						},
						["custom"] = "function(as)\n    local now = time()\n    \n    if aura_env.autoReset then\n        aura_env.doAutoReset();\n    end\n    \n    if GetTime() - aura_env.lastDisplayUpdate >= aura_env.config.updateInterval then\n        local thisToon = UnitName(\"player\") .. \"%s%p%s\" .. GetRealmName();\n        local s = {};\n        s.changed = true;\n        \n        local count = 0;\n        \n        for k,v in pairs(aura_env.db.History) do\n            if not (now > v.last + 3600 or v.last > now + 3600) then\n                count = count + 1; \n            end\n        end\n        \n        s.name = \"Instance History\";\n        \n        s.progressType = \"static\";\n        \n        s.additionalProgress = {};\n        local now = time();\n        \n        local czk = aura_env.histZoneKey();\n        \n        local ordered = {};\n        \n        local dayCount = 0;\n        for k,v in pairs(aura_env.db.HistoryDay) do\n            if string.match(k, thisToon) then\n                if not (now > v.last + 86400 or v.last > now + 86400) then\n                    dayCount = dayCount + 1;\n                end\n            end\n        end\n        \n        s.show = count >= aura_env.config.displayMin or dayCount >= aura_env.config.displayMin;\n        \n        if count > 0 then\n            s.value = 3600;\n            s.total = 3600;\n            local start = now-3600;\n            \n            for k,v in pairs(aura_env.db.History) do\n                if k == czk then\n                    v.last = now; \n                end\n                table.insert(ordered, {k, v.create});\n            end\n            \n            table.sort(ordered, function(a,b) return a[2]<b[2] end);\n            \n            for idx,t in pairs(ordered) do\n                local k = t[1];\n                local v = aura_env.db.History[k];\n                \n                if v.last >= start then\n                    \n                    local o = {};\n                    --o.max = math.min(3600, v.create - start);\n                    --o.min = math.max(0, math.min(v.last - start, o.max-25));\n                    \n                    o.max = math.max(0, math.min(3600, v.last - start));\n                    \n                    local prev = #s.additionalProgress > 0 and s.additionalProgress[#s.additionalProgress].max or 0;\n                    \n                    o.min = math.max(0, math.min(3600, math.min(math.max(prev+25, v.create - start), o.max-25)));\n                    \n                    --print(o.max, o.min)\n                    table.insert(s.additionalProgress, o);\n                end\n            end\n        elseif dayCount > 0 then\n            s.value = 86400;\n            s.total = 86400;\n            local start = now-86400;\n            \n            for k,v in pairs(aura_env.db.HistoryDay) do\n                if string.match(k, thisToon) then\n                    if k == czk then\n                        v.last = now; \n                    end\n                    table.insert(ordered, {k, v.create});\n                end\n            end\n            \n            table.sort(ordered, function(a,b) return a[2]<b[2] end);\n            \n            for idx,t in pairs(ordered) do\n                local k = t[1];\n                local v = aura_env.db.HistoryDay[k];\n                \n                if v.last >= start then\n                    \n                    local o = {};\n                    --o.max = math.min(86400, v.create - start);\n                    --o.min = math.max(0, math.min(v.last - start, o.max-25));\n                    \n                    o.max = math.max(0, math.min(86400, v.last - start));\n                    \n                    local prev = #s.additionalProgress > 0 and s.additionalProgress[#s.additionalProgress].max or 0;\n                    \n                    o.min = math.max(0, math.min(86400, math.min(math.max(prev+25, v.create - start), o.max-25)));\n                    \n                    --print(o.max, o.min)\n                    table.insert(s.additionalProgress, o);\n                end\n            end\n        end\n        \n        \n        --DevTools_Dump(s.additionalProgress)\n        \n        as[1] = s;\n        \n        aura_env.lastDisplayUpdate = GetTime();\n        return true;\n    else\n        return false;\n    end\nend",
						["events"] = "",
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
						["spellIds"] = {
						},
						["custom"] = "function(event, ...)\n    if aura_env[event] then\n        aura_env[event](...) \n    end\nend",
						["subeventSuffix"] = "_CAST_START",
						["names"] = {
						},
						["unit"] = "player",
						["events"] = "CHAT_MSG_SYSTEM,INSTANCE_BOOT_START, INSTANCE_BOOT_STOP, GROUP_ROSTER_UPDATE, PLAYER_ENTERING_WORLD, ZONE_CHANGED_NEW_AREA, RAID_INSTANCE_WELCOME, PLAYER_LEAVING_WORLD, PLAYER_CAMPING, CHAT_MSG_ADDON, SEND_INSTANCE_RESET_REQUEST",
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 53,
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
			["id"] = "INSTANCE LOCK",
			["anchorFrameType"] = "SELECTFRAME",
			["frameStrata"] = 1,
			["width"] = 270,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["sparkHidden"] = "NEVER",
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
			["internalVersion"] = 53,
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
					["text_text_format_p_time_precision"] = 1,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 26,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
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
			["semver"] = "1.0.11",
			["uid"] = "o2yJdzvUMP(",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["parent"] = "Warlock 2.0",
			["regionType"] = "icon",
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
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["anchorFrameType"] = "SCREEN",
			["useCooldownModRate"] = true,
			["cooldownTextDisabled"] = true,
			["auto"] = false,
			["tocversion"] = 11302,
			["id"] = "Warlock - Siphon",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 49,
			["zoom"] = 0.3,
			["config"] = {
			},
			["inverse"] = false,
			["cooldownEdge"] = false,
			["displayIcon"] = 136188,
			["cooldown"] = true,
			["xOffset"] = 50,
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
			["internalVersion"] = 53,
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
			["borderOffset"] = 4,
			["semver"] = "1.0.0",
			["tocversion"] = 11304,
			["id"] = "GEMS",
			["groupIcon"] = 134105,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SELECTFRAME",
			["anchorFrameFrame"] = "MultiBarBottomRightButton12",
			["borderInset"] = 1,
			["uid"] = "Ow32WYEI1Ji",
			["config"] = {
			},
			["conditions"] = {
			},
			["information"] = {
				["groupOffset"] = true,
				["ignoreOptionsEventErrors"] = true,
			},
			["xOffset"] = 40,
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
				["race"] = {
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
				["role"] = {
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
						["event"] = "Power",
						["use_percentpower"] = false,
						["custom_hide"] = "timed",
						["subeventSuffix"] = "_CAST_START",
						["health"] = "0",
						["spellIds"] = {
						},
						["genericShowOn"] = "showOnActive",
						["use_requirePowerType"] = false,
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
			["internalVersion"] = 53,
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
					["text_fontType"] = "None",
					["text_fontSize"] = 15,
					["anchorXOffset"] = 0,
					["text_text_format_c_format"] = "none",
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
		["SwingTimerAPI"] = {
			["sparkWidth"] = 10,
			["iconSource"] = 0,
			["xOffset"] = 0,
			["displayText"] = "%p",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["url"] = "https://wago.io/mfxY37Jl9/13",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
					["custom"] = "local MAJOR, MINOR = \"LibClassicSwingTimerAPI\", 3\n-- local lib = LibStub:NewLibrary(MAJOR, MINOR)\nlocal lib = lib or {}\nif not lib then\n    return\nend\n\nlocal frame = CreateFrame(\"Frame\")\nlocal C_Timer, tonumber = C_Timer, tonumber\nlocal GetSpellInfo, GetTime, CombatLogGetCurrentEventInfo = GetSpellInfo, GetTime, CombatLogGetCurrentEventInfo\nlocal UnitAttackSpeed, UnitAura, UnitGUID, UnitRangedDamage = UnitAttackSpeed, UnitAura, UnitGUID, UnitRangedDamage\n\nlocal reset_swing_spells = {\n    [16589] = true, -- Noggenfogger Elixir\n    [2645] = true, -- Ghost Wolf\n    [51533] = true, -- Feral Spirit\n    [2764] = true, -- Throw\n    [3018] = true, -- Shoots,\n    [5384] = true, -- Feign Death\n    [5019] = true, -- Shoot\n    [75] = true, -- Auto Shot\n    [20066] = true, -- Repentance\n}\n\nlocal prevent_swing_speed_update = {\n    [768] = true, -- Cat Form\n    [5487] = true, -- Bear Form\n    [9634] = true, -- Dire Bear Form\n}\n\nlocal next_melee_spells = {\n    [47450] = true, -- Heroic Strike (rank 13)\n    [47449] = true, -- Heroic Strike (rank 12)\n    [30324] = true, -- Heroic Strike (rank 11)\n    [29707] = true, -- Heroic Strike (rank 10)\n    [25286] = true, -- Heroic Strike (rank 9)\n    [11567] = true, -- Heroic Strike (rank 18)\n    [11566] = true, -- Heroic Strike (rank 7)\n    [11565] = true, -- Heroic Strike (rank 6)\n    [11564] = true, -- Heroic Strike (rank 5)\n    [1608] = true, -- Heroic Strike (rank 4)\n    [285] = true, -- Heroic Strike (rank 3)\n    [284] = true, -- Heroic Strike (rank 2)\n    [78] = true, -- Heroic Strike (rank 1)\n    [47520] = true, -- Cleave (rank 8)\n    [47519] = true, -- Cleave (rank 7)\n    [25231] = true, -- Cleave (rank 6)\n    [20569] = true, -- Cleave (rank 5)\n    [11609] = true, -- Cleave (rank 4)\n    [11608] = true, -- Cleave (rank 3)\n    [7369] = true, -- Cleave (rank 2)\n    [845] = true, -- Cleave (rank 1)\n    [48996] = true, -- Raptor Strike (rank 11)\n    [48995] = true, -- Raptor Strike (rank 10)\n    [27014] = true, -- Raptor Strike (rank 9)\n    [14266] = true, -- Raptor Strike (rank 8)\n    [14265] = true, -- Raptor Strike (rank 7)\n    [14264] = true, -- Raptor Strike (rank 6)\n    [14263] = true, -- Raptor Strike (rank 5)\n    [14262] = true, -- Raptor Strike (rank 4)\n    [14261] = true, -- Raptor Strike (rank 3)\n    [14260] = true, -- Raptor Strike (rank 2)\n    [2973] = true, -- Raptor Strike (rank 1)\n    [6807] = true, -- Maul (rank 1)\n    [6808] = true, -- Maul (rank 2)\n    [6809] = true, -- Maul (rank 3)\n    [8972] = true, -- Maul (rank 4)\n    [9745] = true, -- Maul (rank 5)\n    [9880] = true, -- Maul (rank 6)\n    [9881] = true, -- Maul (rank 7)\n    [26996] = true, -- Maul (rank 8)\n    [48479] = true, -- Maul (rank 9)\n    [48480] = true, -- Maul (rank 10)\n}\n\nlocal noreset_swing_spells = {\n    [23063] = true, -- Dense Dynamite\n    [4054] = true, -- Rough Dynamite\n    [4064] = true, -- Rough Copper Bomb\n    [4061] = true, -- Coarse Dynamite\n    [8331] = true, -- Ez-Thro Dynamite\n    [4065] = true, -- Large Copper Bomb\n    [4066] = true, -- Small Bronze Bomb\n    [4062] = true, -- Heavy Dynamite\n    [4067] = true, -- Big Bronze Bomb\n    [4068] = true, -- Iron Grenade\n    [23000] = true, -- Ez-Thro Dynamite II\n    [12421] = true, -- Mithril Frag Bomb\n    [4069] = true, -- Big Iron Bomb\n    [12562] = true, -- The Big One\n    [12543] = true, -- Hi-Explosive Bomb\n    [19769] = true, -- Thorium Grenade\n    [19784] = true, -- Dark Iron Bomb\n    [30216] = true, -- Fel Iron Bomb\n    [19821] = true, -- Arcane Bomb\n    [39965] = true, -- Frost Grenade\n    [30461] = true, -- The Bigger One\n    [30217] = true, -- Adamantite Grenade\n    [35476] = true, -- Drums of Battle\n    [35475] = true, -- Drums of War\n    [35477] = true, -- Drums of Speed\n    [35478] = true, -- Drums of Restoration\n    [56641] = true, -- Steady Shot (rank 1)\n    [34120] = true, -- Steady Shot (rank 2)\n    [49051] = true, -- Steady Shot (rank 3)\n    [49052] = true, -- Steady Shot (rank 4)\n    [19434] = true, -- Aimed Shot (rank 1)\n    [1464] = true, -- Slam (rank 1)\n    [8820] = true, -- Slam (rank 2)\n    [11604] = true, -- Slam (rank 3)\n    [11605] = true, -- Slam (rank 4)\n    [25241] = true, -- Slam (rank 5)\n    [25242] = true, -- Slam (rank 6)\n    [47474] = true, -- Slam (rank 7)\n    [47475] = true, -- Slam (rank 8)\n    [48467] = true, -- Hurricane (rank 5)\n    [27012] = true, -- Hurricane (rank 4)\n    [17402] = true, -- Hurricane (rank 3)\n    [17401] = true, -- Hurricane (rank 2)\n    [16914] = true, -- Hurricane (rank 1)\n    [12051] = true, -- Evocation\n    [58434] = true, -- Volley (rank 6)\n    [58431] = true, -- Volley (rank 5)\n    [27022] = true, -- Volley (rank 4)\n    [14295] = true, -- Volley (rank 3)\n    [14294] = true, -- Volley (rank 2)\n    [1510] = true, -- Volley (rank 1)\n    --35474 Drums of Panic DO reset the swing timer, do not add\n}\n\nlocal prevent_reset_swing_auras = {\n    [53817] = true, -- Maelstrom Weapon\n}\n\nlocal pause_swing_spells = {\n    [1464] = true, -- Slam (rank 1)\n    [8820] = true, -- Slam (rank 2)\n    [11604] = true, -- Slam (rank 3)\n    [11605] = true, -- Slam (rank 4)\n    [25241] = true, -- Slam (rank 5)\n    [25242] = true, -- Slam (rank 6)\n    [47474] = true, -- Slam (rank 7)\n    [47475] = true, -- Slam (rank 8)\n}\n\nlocal ranged_swing = {\n    [75] = true, -- Auto Shot\n    [3018] = true, -- Shoot\n    [2764] = true, -- Throw\n    [5019] = true, -- Shoot\n}\n\nlocal reset_ranged_swing = {\n    [58433] = true, -- Volley\n    [58432] = true, -- Volley\n    [42234] = true, -- Volley\n    [42245] = true, -- Volley\n    [42244] = true, -- Volley\n    [42243] = true,  -- Volley\n}\n\n-- lib.callbacks = lib.callbacks or LibStub(\"CallbackHandler-1.0\"):New(lib)\n\nfunction lib:Fire(event, ...)\n    WeakAuras.ScanEvents(event, ...)\nend\n\nfunction lib:ADDON_LOADED(_, addOnName)\n    if addOnName ~= MAJOR then\n        return\n    end\n    \n    self.unitGUID = UnitGUID(\"player\")\n    \n    local mainSpeed, offSpeed = UnitAttackSpeed(\"player\")\n    local now = GetTime()\n    \n    self.mainSpeed = mainSpeed\n    self.offSpeed = offSpeed or 0\n    \n    self.lastMainSwing = now\n    self.mainExpirationTime = self.lastMainSwing + self.mainSpeed\n    self.firstMainSwing = false\n    \n    self.lastOffSwing = now\n    self.offExpirationTime = self.lastMainSwing + self.mainSpeed\n    self.firstOffSwing = false\n    \n    self.lastRangedSwing = now\n    self.rangedSpeed = UnitRangedDamage(\"player\") or 0\n    self.rangedExpirationTime = self.lastRangedSwing + self.rangedSpeed\n    \n    self.mainTimer = nil\n    self.offTimer = nil\n    self.rangedTimer = nil\n    self.calculaDeltaTimer = nil\n    \n    self.casting = false\n    self.channeling = false\n    self.isAttacking = false\n    self.preventSwingReset = false\n    self.skipNextAttack = nil\n    self.skipNextAttackCount = 0\n    \n    self.skipNextAttackSpeedUpdate = nil\n    self.skipNextAttackSpeedUpdateCount = 0\nend\n\nlib:ADDON_LOADED(\"\",MAJOR)\n\nfunction lib:CalculateDelta()\n    if self.offSpeed > 0 and self.mainExpirationTime ~= nil and self.offExpirationTime ~= nil then\n        self:Fire(\"SWING_TIMER_DELTA\", self.mainExpirationTime - self.offExpirationTime)\n    end\nend\n\nfunction lib:SwingStart(hand, startTime, isReset)\n    if hand == \"mainhand\" then\n        if self.mainTimer and isReset then\n            self.mainTimer:Cancel()\n        end\n        self.lastMainSwing = startTime\n        local mainSpeed, _ = UnitAttackSpeed(\"player\")\n        self.mainSpeed = mainSpeed\n        self.mainExpirationTime = self.lastMainSwing + self.mainSpeed\n        self:Fire(\"SWING_TIMER_START\", self.mainSpeed, self.mainExpirationTime, hand)\n        if self.mainSpeed > 0 and self.mainExpirationTime - GetTime() > 0 then\n            self.mainTimer = C_Timer.NewTimer(self.mainExpirationTime - GetTime(), function()\n                    self:SwingEnd(\"mainhand\")\n            end)\n        end\n    elseif hand == \"offhand\" then\n        if self.offTimer and isReset then\n            self.offTimer:Cancel()\n        end\n        self.lastOffSwing = startTime\n        local _, offSpeed = UnitAttackSpeed(\"player\")\n        self.offSpeed = offSpeed or 0\n        self.offExpirationTime = self.lastOffSwing + self.offSpeed\n        if self.calculaDeltaTimer then\n            self.calculaDeltaTimer:Cancel()\n        end\n        if self.offSpeed > 0 and self.firstOffSwing == false and self.isAttacking then\n            self.offExpirationTime = self.lastOffSwing + (self.offSpeed / 2)\n            self:CalculateDelta()\n            self:Fire(\"SWING_TIMER_UPDATE\", self.offSpeed, self.offExpirationTime, hand)\n        elseif self.offSpeed > 0 then\n            self:Fire(\"SWING_TIMER_START\", self.offSpeed, self.offExpirationTime, hand)\n            self.calculaDeltaTimer = C_Timer.NewTimer(self.offSpeed / 2, function()\n                    self:CalculateDelta()\n            end)\n        end\n        if self.offSpeed > 0 and self.offExpirationTime - GetTime() > 0 then\n            self.offTimer = C_Timer.NewTimer(self.offExpirationTime - GetTime(), function()\n                    self:SwingEnd(\"offhand\")\n            end)\n        end\n    elseif hand == \"ranged\" then\n        if self.rangedTimer and isReset then\n            self.rangedTimer:Cancel()\n        end\n        self.rangedSpeed = UnitRangedDamage(\"player\") or 0\n        if self.rangedSpeed ~= nil and self.rangedSpeed > 0 then\n            self.rangedSpeed = self.rangedSpeed\n            self.lastRangedSwing = startTime\n            self.rangedExpirationTime = self.lastRangedSwing + self.rangedSpeed\n            self:Fire(\"SWING_TIMER_START\", self.rangedSpeed, self.rangedExpirationTime, hand)\n            if self.rangedExpirationTime - GetTime() > 0 then\n                self.rangedTimer = C_Timer.NewTimer(self.rangedExpirationTime - GetTime(), function()\n                        self:SwingEnd(\"ranged\")\n                end)\n            end\n        end\n    end\nend\n\nfunction lib:SwingEnd(hand)\n    self:Fire(\"SWING_TIMER_STOP\", hand)\n    if (self.casting or self.channeling) and self.isAttacking and hand ~= \"ranged\" then\n        local now = GetTime()\n        self:SwingStart(hand, now, true)\n        self:Fire(\"SWING_TIMER_CLIPPED\", hand)\n    end\nend\n\nfunction lib:SwingTimerInfo(hand)\n    if hand == \"mainhand\" then\n        return self.mainSpeed, self.mainExpirationTime, self.lastMainSwing\n    elseif hand == \"offhand\" then\n        return self.offSpeed, self.offExpirationTime, self.lastOffSwing\n    elseif hand == \"ranged\" then\n        return self.rangedSpeed, self.rangedExpirationTime, self.lastRangedSwing\n    end\nend\n\nfunction lib:COMBAT_LOG_EVENT_UNFILTERED(_, ts, subEvent, _, sourceGUID, _, _, _, destGUID, _, _, _, amount, overkill, _, resisted, _, _, _, _, _, isOffHand)\n    local now = GetTime()\n    if subEvent == \"SPELL_EXTRA_ATTACKS\" and sourceGUID == self.unitGUID then\n        self.skipNextAttack = ts\n        self.skipNextAttackCount = resisted\n    elseif (subEvent == \"SWING_DAMAGE\" or subEvent == \"SWING_MISSED\") and sourceGUID == self.unitGUID then\n        local isOffHand = isOffHand\n        if subEvent == \"SWING_MISSED\" then\n            isOffHand = overkill\n        end\n        if\n        self.skipNextAttack ~= nil\n        and tonumber(self.skipNextAttack)\n        and (ts - self.skipNextAttack) < 0.04\n        and tonumber(self.skipNextAttackCount)\n        and not isOffHand\n        then\n            if self.skipNextAttackCount > 0 then\n                self.skipNextAttackCount = self.skipNextAttackCount - 1\n                return false\n            end\n        end\n        if isOffHand then\n            self.firstOffSwing = true\n            self:SwingStart(\"offhand\", now, false)\n            self:SwingStart(\"ranged\", now, true)\n        else\n            self.firstMainSwing = true\n            self:SwingStart(\"mainhand\", now, false)\n            self:SwingStart(\"ranged\", now, true)\n        end\n    elseif subEvent == \"SWING_MISSED\" and amount ~= nil and amount == \"PARRY\" and destGUID == self.unitGUID then\n        if self.mainTimer then\n            self.mainTimer:Cancel()\n        end\n        local swing_timer_reduced_40p = self.mainExpirationTime - (0.4 * self.mainSpeed)\n        local min_swing_time = 0.2 * self.mainSpeed\n        if swing_timer_reduced_40p < min_swing_time then\n            self.mainExpirationTime = min_swing_time\n        else\n            self.mainExpirationTime = swing_timer_reduced_40p\n        end\n        self:Fire(\"SWING_TIMER_UPDATE\", self.mainSpeed, self.mainExpirationTime, \"mainhand\")\n        if self.mainSpeed > 0 and self.mainExpirationTime - GetTime() > 0 then\n            self.mainTimer = C_Timer.NewTimer(self.mainExpirationTime - GetTime(), function()\n                    self:SwingEnd(\"mainhand\")\n            end)\n        end\n    elseif (subEvent == \"SPELL_AURA_APPLIED\" or subEvent == \"SPELL_AURA_REMOVED\") and sourceGUID == self.unitGUID then\n        local spell = amount\n        if spell and prevent_swing_speed_update[spell] then\n            self.skipNextAttackSpeedUpdate = now\n            self.skipNextAttackSpeedUpdateCount = 2\n        end\n        if spell and prevent_reset_swing_auras[spell] then\n            self.preventSwingReset = subEvent == \"SPELL_AURA_APPLIED\"\n        end\n    elseif (subEvent == \"SPELL_DAMAGE\" or subEvent == \"SPELL_MISSED\") and sourceGUID == self.unitGUID then\n        local spell = amount\n        if reset_ranged_swing[spell] then\n            self:SwingStart(\"ranged\", GetTime(), true)\n        end\n    end\nend\n\nfunction lib:UNIT_ATTACK_SPEED()\n    local now = GetTime()\n    if\n    self.skipNextAttackSpeedUpdate\n    and tonumber(self.skipNextAttackSpeedUpdate)\n    and (now - self.skipNextAttackSpeedUpdate) < 0.04\n    and tonumber(self.skipNextAttackSpeedUpdateCount)\n    then\n        self.skipNextAttackSpeedUpdateCount = self.skipNextAttackSpeedUpdateCount - 1\n        return\n    end\n    if self.mainTimer then\n        self.mainTimer:Cancel()\n    end\n    if self.offTimer then\n        self.offTimer:Cancel()\n    end\n    local mainSpeedNew, offSpeedNew = UnitAttackSpeed(\"player\")\n    offSpeedNew = offSpeedNew or 0\n    if mainSpeedNew > 0 and self.mainSpeed > 0 and mainSpeedNew ~= self.mainSpeed then\n        local multiplier = mainSpeedNew / self.mainSpeed\n        local timeLeft = (self.lastMainSwing + self.mainSpeed - now) * multiplier\n        self.mainSpeed = mainSpeedNew\n        self.mainExpirationTime = now + timeLeft\n        self:Fire(\"SWING_TIMER_UPDATE\", self.mainSpeed, self.mainExpirationTime, \"mainhand\")\n        if self.mainSpeed > 0 and self.mainExpirationTime - GetTime() > 0 then\n            self.mainTimer = C_Timer.NewTimer(self.mainExpirationTime - GetTime(), function()\n                    self:SwingEnd(\"mainhand\")\n            end)\n        end\n    end\n    if offSpeedNew > 0 and self.offSpeed > 0 and offSpeedNew ~= self.offSpeed then\n        local multiplier = offSpeedNew / self.offSpeed\n        local timeLeft = (self.lastOffSwing + self.offSpeed - now) * multiplier\n        self.offSpeed = offSpeedNew\n        self.offExpirationTime = now + timeLeft\n        if self.calculaDeltaTimer ~= nil then\n            self.calculaDeltaTimer:Cancel()\n        end\n        self:Fire(\"SWING_TIMER_UPDATE\", self.offSpeed, self.offExpirationTime, \"offhand\")\n        if self.offSpeed > 0 and self.offExpirationTime - GetTime() > 0 then\n            self.offTimer = C_Timer.NewTimer(self.offExpirationTime - GetTime(), function()\n                    self:SwingEnd(\"offhand\")\n            end)\n        end\n    end\nend\n\nfunction lib:UNIT_SPELLCAST_INTERRUPTED_OR_FAILED(_, _, _, spell)\n    self.casting = false\n    if spell and pause_swing_spells[spell] and self.pauseSwingTime then\n        self.pauseSwingTime = nil\n        if self.mainSpeed > 0 then\n            if self.mainExpirationTime < GetTime() and self.isAttacking then\n                self.mainExpirationTime = self.mainExpirationTime + self.mainSpeed\n            end\n            self:Fire(\"SWING_TIMER_UPDATE\", self.mainSpeed, self.mainExpirationTime, \"mainhand\")\n            self.mainTimer = C_Timer.NewTimer(self.mainExpirationTime - GetTime(), function()\n                    self:SwingEnd(\"mainhand\")\n            end)\n        end\n        if self.offSpeed > 0 then\n            if self.offExpirationTime < GetTime() and self.isAttacking then\n                self.offExpirationTime = self.offExpirationTime + self.offSpeed\n            end\n            self:Fire(\"SWING_TIMER_UPDATE\", self.offSpeed, self.offExpirationTime, \"offhand\")\n            self.offTimer = C_Timer.NewTimer(self.offExpirationTime - GetTime(), function()\n                    self:SwingEnd(\"offhand\")\n            end)\n        end\n    end\nend\nfunction lib:UNIT_SPELLCAST_INTERRUPTED(...)\n    self:UNIT_SPELLCAST_INTERRUPTED_OR_FAILED(...)\nend\nfunction lib:UNIT_SPELLCAST_FAILED(...)\n    self:UNIT_SPELLCAST_INTERRUPTED_OR_FAILED(...)\nend\n\nfunction lib:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spell)\n    local now = GetTime()\n    if spell ~= nil and next_melee_spells[spell] then\n        self:SwingStart(\"mainhand\", now, false)\n        self:SwingStart(\"ranged\", now, true)\n    end\n    if (spell and reset_swing_spells[spell]) or (self.casting and not self.preventSwingReset) then\n        self:SwingStart(\"mainhand\", now, true)\n        self:SwingStart(\"offhand\", now, true)\n        self:SwingStart(\"ranged\", now, not ranged_swing[spell]) -- set reset flag to true if the spell is not in list of ranged swing spells\n    end\n    if spell and pause_swing_spells[spell] and self.pauseSwingTime then\n        local offset = now - self.pauseSwingTime\n        self.pauseSwingTime = nil\n        if self.mainSpeed > 0 then\n            self.mainExpirationTime = self.mainExpirationTime + offset\n            self:Fire(\"SWING_TIMER_UPDATE\", self.mainSpeed, self.mainExpirationTime, \"mainhand\")\n            self.mainTimer = C_Timer.NewTimer(self.mainExpirationTime - now, function()\n                    self:SwingEnd(\"mainhand\")\n            end)\n        end\n        if self.offSpeed > 0 then\n            self.offExpirationTime = self.offExpirationTime + offset\n            self:Fire(\"SWING_TIMER_UPDATE\", self.offSpeed, self.offExpirationTime, \"offhand\")\n            self.offTimer = C_Timer.NewTimer(self.offExpirationTime - now, function()\n                    self:SwingEnd(\"offhand\")\n            end)\n        end\n    end\n    if self.casting and spell ~= 6603 then -- 6603=Auto Attack prevent set casting to false when auto attack is toggle on\n        self.casting = false\n    end\nend\n\nfunction lib:UNIT_SPELLCAST_START(_, unit, _, spell)\n    if spell then\n        local now = GetTime()\n        local name, rank, icon, castTime, minRange, maxRange, spellId = GetSpellInfo(spell)\n        local endOfCast = now + (castTime / 1000) -- endOfCast is not use anywhere\n        self.casting = true\n        self.preventSwingReset = self.preventSwingReset or noreset_swing_spells[spell]\n        if spell and pause_swing_spells[spell] then\n            self.pauseSwingTime = now\n            if self.mainSpeed > 0 then\n                self:Fire(\"SWING_TIMER_PAUSED\", \"mainhand\")\n                if self.mainTimer then\n                    self.mainTimer:Cancel()\n                end\n            end\n            if self.offSpeed > 0 then\n                self:Fire(\"SWING_TIMER_PAUSED\", \"offhand\")\n                if self.offTimer then\n                    self.offTimer:Cancel()\n                end\n            end\n        end\n    end\nend\n\nfunction lib:UNIT_SPELLCAST_CHANNEL_START(_, _, _, spell)\n    self.casting = true\n    self.channeling = true\n    self.preventSwingReset = noreset_swing_spells[spell]\nend\n\nfunction lib:UNIT_SPELLCAST_CHANNEL_STOP()\n    self.channeling = false\nend\n\nfunction lib:PLAYER_EQUIPMENT_CHANGED(_, equipmentSlot)\n    if equipmentSlot == 16 or equipmentSlot == 17 or equipmentSlot == 18 then\n        local now = GetTime()\n        self:SwingStart(\"mainhand\", now, true)\n        self:SwingStart(\"offhand\", now, true)\n        self:SwingStart(\"ranged\", now, true)\n    end\nend\n\nfunction lib:PLAYER_ENTER_COMBAT()\n    local now = GetTime()\n    self.isAttacking = true\n    if now > (self.offExpirationTime - (self.offSpeed / 2)) then\n        if self.offTimer then\n            self.offTimer:Cancel()\n        end\n        self:SwingStart(\"offhand\", now, true)\n    end\nend\n\nfunction lib:PLAYER_LEAVE_COMBAT()\n    self.isAttacking = false\n    self.firstMainSwing = false\n    self.firstOffSwing = false\nend\n\nframe:RegisterEvent(\"COMBAT_LOG_EVENT_UNFILTERED\")\nframe:RegisterEvent(\"PLAYER_EQUIPMENT_CHANGED\")\nframe:RegisterEvent(\"PLAYER_ENTER_COMBAT\")\nframe:RegisterEvent(\"PLAYER_LEAVE_COMBAT\")\nframe:RegisterUnitEvent(\"UNIT_ATTACK_SPEED\", \"player\")\nframe:RegisterUnitEvent(\"UNIT_SPELLCAST_START\", \"player\")\nframe:RegisterUnitEvent(\"UNIT_SPELLCAST_INTERRUPTED\", \"player\")\nframe:RegisterUnitEvent(\"UNIT_SPELLCAST_FAILED\", \"player\")\nframe:RegisterUnitEvent(\"UNIT_SPELLCAST_SUCCEEDED\", \"player\")\nframe:RegisterUnitEvent(\"UNIT_SPELLCAST_CHANNEL_START\", \"player\")\nframe:RegisterUnitEvent(\"UNIT_SPELLCAST_CHANNEL_STOP\", \"player\")\nframe:RegisterEvent(\"ADDON_LOADED\")\n\nframe:SetScript(\"OnEvent\", function(_, event, ...)\n        if event == \"COMBAT_LOG_EVENT_UNFILTERED\" then\n            lib[event](lib, event, CombatLogGetCurrentEventInfo())\n        else\n            lib[event](lib, event, ...)\n        end\nend)",
					["do_custom"] = true,
				},
			},
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["barColor"] = {
				1, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["font"] = "Friz Quadrata TT",
			["sparkOffsetY"] = 0,
			["load"] = {
				["use_namerealm"] = false,
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "SHAMAN",
					["multi"] = {
						["SHAMAN"] = true,
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
			["shadowXOffset"] = 1,
			["useAdjustededMin"] = false,
			["regionType"] = "icon",
			["texture"] = "Blizzard",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["spark"] = false,
			["tocversion"] = 30400,
			["alpha"] = 0,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["outline"] = "OUTLINE",
			["sparkOffsetX"] = 0,
			["wagoID"] = "mfxY37Jl9",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["shadowYOffset"] = -1,
			["cooldownSwipe"] = true,
			["sparkRotationMode"] = "AUTO",
			["automaticWidth"] = "Auto",
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["use_alwaystrue"] = true,
						["subeventSuffix"] = "_CAST_START",
						["debuffType"] = "HELPFUL",
						["event"] = "Conditions",
						["use_unit"] = true,
						["custom_type"] = "event",
						["spellIds"] = {
						},
						["custom"] = "",
						["names"] = {
						},
						["events"] = "",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["custom_hide"] = "custom",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "any",
				["customTriggerLogic"] = "function(t)\n    return t[1] or t[3] or t[5] or t[7] or t[8] or t[2]\nend",
				["activeTriggerMode"] = 1,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
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
			["cooldown"] = false,
			["version"] = 13,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 30,
			["displayIcon"] = "136243",
			["orientation"] = "HORIZONTAL",
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["fontSize"] = 12,
			["source"] = "import",
			["zoom"] = 0,
			["uid"] = "vxHOuQHmVNr",
			["displayText_format_p_time_legacy_floor"] = false,
			["displayText_format_p_time_mod_rate"] = true,
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 1,
			["sparkRotation"] = 0,
			["id"] = "SwingTimerAPI",
			["icon_side"] = "RIGHT",
			["icon"] = false,
			["justify"] = "LEFT",
			["sparkHeight"] = 30,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["displayText_format_p_time_precision"] = 1,
			["semver"] = "1.0.12",
			["cooldownTextDisabled"] = false,
			["sparkHidden"] = "NEVER",
			["config"] = {
			},
			["useCooldownModRate"] = true,
			["width"] = 30,
			["customTextUpdate"] = "event",
			["cooldownEdge"] = false,
			["inverse"] = false,
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
			},
			["preferToUpdate"] = false,
		},
		["DK DOTS"] = {
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["controlledChildren"] = {
				"PLAGUE STRIKE", -- [1]
				"ICY TOUCH", -- [2]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["xOffset"] = 0,
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "group",
			["borderSize"] = 2,
			["anchorPoint"] = "CENTER",
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
			["internalVersion"] = 53,
			["yOffset"] = 437.5,
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
			["id"] = "DK DOTS",
			["borderOffset"] = 4,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["selfPoint"] = "CENTER",
			["borderInset"] = 1,
			["uid"] = "0rrGMYWRJ3X",
			["config"] = {
			},
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
			["scale"] = 0.8,
		},
		["Druid - Mana Bar Cat/Bear"] = {
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
				["use_class"] = false,
				["race"] = {
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
				["role"] = {
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
			["texture"] = "Clean",
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
			["parent"] = "DRUID / ROGUE",
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
						["event"] = "Power",
						["use_percentpower"] = false,
						["debuffType"] = "HELPFUL",
						["subeventSuffix"] = "_CAST_START",
						["health"] = "0",
						["spellIds"] = {
						},
						["unit"] = "player",
						["use_requirePowerType"] = false,
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
			["internalVersion"] = 53,
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
					["text_fontSize"] = 14,
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
					["text_font"] = "Arial Narrow",
					["text_visible"] = true,
					["text_anchorYOffset"] = -10,
					["text_text_format_t_time_precision"] = 1,
					["text_text_format_t_time_dynamic_threshold"] = 60,
					["text_text_format_t_time_mod_rate"] = true,
					["text_anchorPoint"] = "INNER_RIGHT",
					["anchorXOffset"] = 0,
					["text_text_format_p_time_format"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
					["text_shadowXOffset"] = 1,
					["text_text"] = "%p / %t",
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
				"Clean", -- [1]
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
			["sparkHidden"] = "NEVER",
			["config"] = {
			},
			["frameStrata"] = 3,
			["anchorFrameType"] = "SCREEN",
			["id"] = "Druid - Mana Bar Cat/Bear",
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
						["subeventPrefix"] = "SPELL",
						["duration"] = "1",
						["event"] = "Stance/Form/Aura",
						["unit"] = "player",
						["use_unit"] = true,
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_inverse"] = false,
						["names"] = {
						},
						["unevent"] = "auto",
						["form"] = {
							["single"] = 1,
						},
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 53,
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
			["selfPoint"] = "BOTTOM",
			["parent"] = "Warrior 2.0",
			["shadowYOffset"] = -1,
			["authorOptions"] = {
			},
			["semver"] = "1.0.15",
			["justify"] = "LEFT",
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
			["internalVersion"] = 53,
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
			["borderInset"] = 1,
			["uid"] = "GmwdiAzp9BQ",
			["xOffset"] = 0,
			["config"] = {
			},
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
		["HOT"] = {
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
							"Rejuvenation", -- [2]
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
			["internalVersion"] = 53,
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
				["use_namerealm"] = true,
				["namerealm"] = "xxx",
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
			["config"] = {
			},
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
			["uid"] = "COT6WtLOefa",
			["icon_side"] = "RIGHT",
			["zoom"] = 0,
			["sparkHeight"] = 30,
			["texture"] = "Clean",
			["sparkHidden"] = "NEVER",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["auto"] = true,
			["width"] = 175,
			["id"] = "HOT",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["anchorFrameType"] = "SELECTFRAME",
			["spark"] = false,
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
			["internalVersion"] = 53,
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
			["sparkOffsetX"] = 0,
			["authorOptions"] = {
			},
			["icon_side"] = "RIGHT",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["sparkHeight"] = 30,
			["texture"] = "Clean",
			["spark"] = false,
			["zoom"] = 0,
			["auto"] = true,
			["anchorFrameType"] = "SELECTFRAME",
			["sparkHidden"] = "NEVER",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 68,
			["id"] = "MEND PET",
			["uid"] = "FpXBk3sOate",
			["inverse"] = false,
			["config"] = {
			},
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
			},
			["selfPoint"] = "CENTER",
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
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["cooldownEdge"] = false,
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
			["internalVersion"] = 53,
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
			},
			["height"] = 40,
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
			["semver"] = "1.0.16",
			["config"] = {
			},
			["selfPoint"] = "CENTER",
			["useTooltip"] = false,
			["regionType"] = "icon",
			["cooldown"] = true,
			["parent"] = "Loss of Control Effects",
			["xOffset"] = -50,
			["authorOptions"] = {
			},
			["width"] = 40,
			["useCooldownModRate"] = true,
			["zoom"] = 0.3,
			["auto"] = true,
			["tocversion"] = 20503,
			["id"] = "Unstable govno",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = false,
			["uid"] = "FguV0)KEGj3",
			["inverse"] = false,
			["url"] = "https://wago.io/pw_hjyCcX/17",
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
						}, -- [1]
						{
							["value"] = true,
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
		["Off Hand"] = {
			["sparkWidth"] = 10,
			["borderBackdrop"] = "Blizzard Tooltip",
			["parent"] = "Swing Timers",
			["preferToUpdate"] = false,
			["spark"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["iconSource"] = -1,
			["sparkRotation"] = 0,
			["sparkRotationMode"] = "AUTO",
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
						["event"] = "Health",
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
			["internalVersion"] = 53,
			["sparkOffsetX"] = 0,
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
				0.1254901960784314, -- [1]
				0.8235294117647058, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["stickyDuration"] = false,
			["selfPoint"] = "CENTER",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
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
					["text_text"] = "%p",
					["text_text_format_p_format"] = "timed",
					["text_selfPoint"] = "AUTO",
					["text_automaticWidth"] = "Auto",
					["text_fixedWidth"] = 64,
					["anchorYOffset"] = 0,
					["text_justify"] = "CENTER",
					["rotateText"] = "NONE",
					["text_text_format_p_time_precision"] = 1,
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
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 8,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
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
			["uid"] = "(1XnfyKcJl3",
			["load"] = {
				["use_namerealm"] = true,
				["zoneIds"] = "",
				["namerealm"] = "xxxx",
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
				["use_combat"] = true,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["sparkBlendMode"] = "ADD",
			["useAdjustededMax"] = false,
			["config"] = {
			},
			["xOffset"] = 0,
			["width"] = 200,
			["alpha"] = 1,
			["sparkOffsetY"] = 0,
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["borderInFront"] = true,
			["id"] = "Off Hand",
			["icon_side"] = "RIGHT",
			["auto"] = true,
			["sparkHeight"] = 30,
			["texture"] = "Clean",
			["zoom"] = 0,
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["semver"] = "1.0.0",
			["tocversion"] = 11302,
			["sparkHidden"] = "NEVER",
			["desaturate"] = false,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["inverse"] = true,
			["icon"] = false,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["authorOptions"] = {
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
				["init"] = {
				},
				["finish"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Health",
						["unit"] = "player",
						["custom_hide"] = "timed",
						["spellIds"] = {
						},
						["events"] = "CHAT_MSG_PARTY, CHAT_MSG_RAID, CHAT_MSG_PARTY_LEADER, CHAT_MSG_RAID_LEADER",
						["subeventPrefix"] = "SPELL",
						["names"] = {
						},
						["custom_type"] = "event",
						["custom"] = "function(event, message, sender, ...)\n    local name = Ambiguate(sender, 'short')\n    local allowed_users = aura_env.config.allowed_users\n    if strlen(allowed_users)>0 then\n        if not tContains({strsplit(\",\", allowed_users)}, name) then\n            return\n        end\n    end\n    if message == aura_env.config.command_follow then\n        FollowUnit(name)     \n    elseif message == aura_env.config.command_stop then\n        FollowUnit(\"player\")\n    end\nend\n\n\n",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
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
				["level_operator"] = "<",
				["use_ingroup"] = false,
				["size"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["spec"] = {
					["multi"] = {
					},
				},
				["level"] = "60",
				["class"] = {
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["fontSize"] = 12,
			["source"] = "import",
			["shadowXOffset"] = 1,
			["automaticWidth"] = "Auto",
			["regionType"] = "text",
			["preferToUpdate"] = false,
			["selfPoint"] = "BOTTOM",
			["fixedWidth"] = 200,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayText_format_p_time_precision"] = 1,
			["authorOptions"] = {
				{
					["type"] = "input",
					["useDesc"] = true,
					["width"] = 1,
					["desc"] = "The keyword used to trigger the follow command.",
					["key"] = "command_follow",
					["name"] = "Follow Command",
					["default"] = "!follow",
					["length"] = 10,
					["multiline"] = false,
					["useLength"] = false,
				}, -- [1]
				{
					["type"] = "input",
					["useDesc"] = true,
					["width"] = 1,
					["desc"] = "The keyword used to trigger the stop command.",
					["key"] = "command_stop",
					["name"] = "Stop Command",
					["default"] = "!stop",
					["length"] = 10,
					["multiline"] = false,
					["useLength"] = false,
				}, -- [2]
				{
					["type"] = "input",
					["useDesc"] = true,
					["width"] = 1,
					["desc"] = "Players who are allowed to use this command, separated by a comma. Leave empty to allow anyone to use it.",
					["key"] = "allowed_users",
					["name"] = "Allowed Users",
					["default"] = "",
					["length"] = 10,
					["multiline"] = false,
					["useLength"] = false,
				}, -- [3]
			},
			["uid"] = "K4voXrFr5jp",
			["displayText"] = "%p",
			["justify"] = "LEFT",
			["tocversion"] = 20504,
			["id"] = "Victorious' FollowMe",
			["semver"] = "1.1.2",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["shadowYOffset"] = -1,
			["config"] = {
				["command_stop"] = "!!stop",
				["command_follow"] = "!!follow",
				["allowed_users"] = "",
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
			["displayText_format_p_time_legacy_floor"] = true,
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
			["displayText_format_p_time_mod_rate"] = true,
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
						["custom_type"] = "stateupdate",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Chat Message",
						["duration"] = "1",
						["genericShowOn"] = "showOnActive",
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["events"] = " NAME_PLATE_UNIT_ADDED NAME_PLATE_UNIT_REMOVED COMBAT_LOG_EVENT_UNFILTERED ",
						["spellIds"] = {
						},
						["custom"] = "function(allstates, event,unit, ...)    \n    if event == \"NAME_PLATE_UNIT_ADDED\" then\n        if unit then\n            local guid = UnitGUID(unit)                   \n            --print(name)\n            allstates[guid] = {\n                changed = true,\n                show = false,\n                PassUnit = unit,\n                glow = false,\n            }            \n        end\n    end\n    \n    if event == \"NAME_PLATE_UNIT_REMOVED\" then\n        if unit then\n            local guid = UnitGUID(unit)\n            if allstates[guid] then\n                allstates[guid].changed = true\n                allstates[guid].PassUnit = \"none\"\n            end\n        end\n    end\n    \n    if event == \"COMBAT_LOG_EVENT_UNFILTERED\" then\n        local subEvent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = ...\n        local spellID,spellName,spellSchool\n        local missType = \"\"\n        local stanceIndex = GetShapeshiftForm()\n        \n        if subEvent == \"SWING_MISSED\" and sourceName == UnitName(\"player\")  then\n            --if subEvent == \"SWING_MISSED\" and sourceName == UnitName(\"player\") and stanceIndex == 1 then\n            missType = select(11,...)\n            --print(missType .. \"SWING missed\")\n            --print(missType .. \"  SWING \")\n        elseif subEvent == \"SPELL_MISSED\" and sourceName == UnitName(\"player\") then\n            --elseif subEvent == \"SPELL_MISSED\" and sourceName == UnitName(\"player\") and stanceIndex == 1 then\n            \n            spellID,spellName,spellSchool,missType = select(11, ...)\n            --print(missType .. \"SPELL missed\")\n            --print(missType .. \"  SPELL \")            \n        end\n        \n        if missType == \"DODGE\" then\n            for i = 1,40 do\n                local u = \"nameplate\"..i                \n                if UnitExists(u) and UnitGUID(u) == destGUID then            \n                    allstates[destGUID] = {\n                        changed = true,\n                        show = true,          \n                        PassUnit = u,\n                        glow = true,\n                        autoHide = true,\n                        progressType = \"timed\",\n                        duration = aura_env.config.duration,\n                    } \n                    break\n                    \n                end\n            end\n        end\n    end\n    \n    return true\n    \nend",
						["check"] = "event",
						["unit"] = "player",
						["unevent"] = "auto",
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
			["internalVersion"] = 53,
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
					["text_visible"] = false,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_c_format"] = "none",
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
					["text_text_format_2.p_time_precision"] = 1,
					["text_shadowYOffset"] = -1,
					["text_text_format_2.p_time_dynamic_threshold"] = 60,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "None",
					["text_anchorPoint"] = "CENTER",
					["text_text_format_2.p_time_legacy_floor"] = true,
					["text_visible"] = true,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_2.p_time_mod_rate"] = true,
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
				["use_namerealm"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["namerealm"] = "no",
				["talent"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
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
			["width"] = 40,
			["semver"] = "1.0.2",
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
			["cooldown"] = false,
			["conditions"] = {
			},
			["mirror"] = false,
			["anchorFrameFrame"] = "WeakAuras:Nameplate Point Anchor",
			["regionType"] = "icon",
			["rotation"] = 0,
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
			["config"] = {
				["yoff"] = 0,
				["xoff"] = 0,
				["duration"] = 4,
			},
			["texture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura53",
			["useCooldownModRate"] = true,
			["zoom"] = 0,
			["auto"] = false,
			["tocversion"] = 11302,
			["id"] = "Overpower on Nameplate",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = false,
			["uid"] = "R0zLHbigXLR",
			["inverse"] = false,
			["xOffset"] = -10,
			["displayIcon"] = 132223,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["cooldownEdge"] = false,
		},
		["PLAGUE STRIKE"] = {
			["iconSource"] = -1,
			["wagoID"] = "pw_hjyCcX",
			["xOffset"] = -32,
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["cooldownEdge"] = false,
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
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura2",
						["use_debuffClass"] = false,
						["useExactSpellId"] = false,
						["subeventPrefix"] = "SPELL",
						["event"] = "Health",
						["unit"] = "target",
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["spellIds"] = {
						},
						["auraspellids"] = {
						},
						["combineMode"] = "showHighest",
						["auranames"] = {
							"Blood Plague", -- [1]
						},
						["useName"] = true,
						["debuffType"] = "HARMFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["useTooltip"] = false,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 17,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 60,
			["load"] = {
				["use_namerealm"] = true,
				["ingroup"] = {
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
				["use_class"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "DEATHKNIGHT",
					["multi"] = {
						["PRIEST"] = true,
						["PALADIN"] = true,
					},
				},
				["namerealm"] = "xxxx",
				["zoneIds"] = "",
			},
			["auto"] = true,
			["config"] = {
			},
			["icon"] = true,
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
			["cooldown"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["authorOptions"] = {
			},
			["url"] = "https://wago.io/pw_hjyCcX/17",
			["width"] = 60,
			["frameStrata"] = 1,
			["zoom"] = 0.3,
			["semver"] = "1.0.16",
			["tocversion"] = 20503,
			["id"] = "PLAGUE STRIKE",
			["cooldownTextDisabled"] = false,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["useCooldownModRate"] = true,
			["uid"] = "A)neyY(zskG",
			["inverse"] = false,
			["internalVersion"] = 53,
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
						}, -- [1]
						{
							["value"] = true,
						}, -- [2]
					},
				}, -- [1]
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["parent"] = "DK DOTS",
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
			["internalVersion"] = 53,
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
			["useLimit"] = false,
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["rowSpace"] = 1,
			["animate"] = true,
			["gridType"] = "RD",
			["scale"] = 1.2,
			["selfPoint"] = "TOP",
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "dynamicgroup",
			["borderSize"] = 2,
			["limit"] = 5,
			["authorOptions"] = {
			},
			["radius"] = 200,
			["constantFactor"] = "RADIUS",
			["sort"] = "none",
			["borderOffset"] = 16,
			["semver"] = "1.0.0",
			["tocversion"] = 11302,
			["id"] = "Swing Timers",
			["gridWidth"] = 5,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["stagger"] = 0,
			["uid"] = "h90hJC1QDXk",
			["arcLength"] = 360,
			["config"] = {
			},
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["fullCircle"] = true,
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
			["internalVersion"] = 53,
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
					["text_text_format_p_time_precision"] = 1,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
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
			["auto"] = false,
			["uid"] = "hvReIaqy7dk",
			["parent"] = "Warlock 2.0",
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
			["icon"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["width"] = 35,
			["useCooldownModRate"] = true,
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.11",
			["tocversion"] = 11302,
			["id"] = "Warlock - Escape Artist",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["config"] = {
			},
			["inverse"] = false,
			["cooldownEdge"] = false,
			["displayIcon"] = 132309,
			["cooldown"] = true,
			["selfPoint"] = "CENTER",
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
			["internalVersion"] = 53,
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
					["text_text_format_p_time_precision"] = 1,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 25,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
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
			["uid"] = "esE633vv0KS",
			["cooldownTextDisabled"] = false,
			["icon"] = true,
			["regionType"] = "icon",
			["xOffset"] = -69.78,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["authorOptions"] = {
			},
			["parent"] = "Warlock 2.0",
			["auto"] = true,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["semver"] = "1.0.11",
			["tocversion"] = 11302,
			["id"] = "Warlock - Soul Shard #",
			["alpha"] = 1,
			["useCooldownModRate"] = true,
			["width"] = 35,
			["frameStrata"] = 1,
			["config"] = {
			},
			["inverse"] = false,
			["url"] = "https://wago.io/Y8douZITb/12",
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
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["cooldownEdge"] = false,
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
			["internalVersion"] = 53,
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
				{
					["text_shadowXOffset"] = 0,
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
					["text_text_format_p_time_precision"] = 1,
					["type"] = "subtext",
					["text_anchorXOffset"] = 15,
					["text_color"] = {
						0.8117647058823529, -- [1]
						1, -- [2]
						0.4352941176470588, -- [3]
						1, -- [4]
					},
					["text_font"] = "Arial Narrow",
					["anchorXOffset"] = 0,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "OUTER_RIGHT",
					["text_text_format_p_format"] = "timed",
					["text_text_format_p_time_format"] = 0,
					["text_fontSize"] = 16,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_n_format"] = "none",
				}, -- [3]
			},
			["height"] = 40,
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
			["semver"] = "1.0.16",
			["config"] = {
			},
			["selfPoint"] = "CENTER",
			["useTooltip"] = false,
			["regionType"] = "icon",
			["cooldown"] = true,
			["parent"] = "Loss of Control Effects",
			["xOffset"] = 50,
			["authorOptions"] = {
			},
			["width"] = 40,
			["useCooldownModRate"] = true,
			["zoom"] = 0.3,
			["auto"] = true,
			["tocversion"] = 20503,
			["id"] = "Curses and Viper",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = true,
			["uid"] = "XYzKgm6z7d(",
			["inverse"] = false,
			["url"] = "https://wago.io/pw_hjyCcX/17",
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
			["internalVersion"] = 53,
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
					["text_text_format_p_time_precision"] = 1,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
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
			["auto"] = false,
			["uid"] = "dzfoy4spTeX",
			["parent"] = "Warlock 2.0",
			["cooldownEdge"] = false,
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
			["anchorFrameType"] = "SCREEN",
			["useCooldownModRate"] = true,
			["cooldownTextDisabled"] = true,
			["semver"] = "1.0.11",
			["tocversion"] = 11302,
			["id"] = "Warlock - Spell Lock",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 35,
			["zoom"] = 0.3,
			["config"] = {
			},
			["inverse"] = false,
			["icon"] = true,
			["displayIcon"] = 136174,
			["cooldown"] = true,
			["xOffset"] = 0,
		},
		["timer"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "v9qxdDgI4",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayText"] = "%p",
			["yOffset"] = 30,
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
						["unit"] = "player",
						["names"] = {
						},
						["spellName"] = 34428,
						["sourceUnit"] = "player",
						["type"] = "spell",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["use_genericShowOn"] = true,
						["use_spellId"] = false,
						["event"] = "Action Usable",
						["use_sourceFlags2"] = false,
						["realSpellName"] = "Victory Rush",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["use_sourceUnit"] = true,
						["use_critical"] = true,
						["use_destUnit"] = false,
						["use_track"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
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
			["shadowXOffset"] = 1,
			["shadowYOffset"] = -1,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["regionType"] = "text",
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
			["fixedWidth"] = 200,
			["preferToUpdate"] = false,
			["xOffset"] = 0,
			["displayText_format_p_time_precision"] = 1,
			["uid"] = "4)0S2Za6LFo",
			["wordWrap"] = "WordWrap",
			["semver"] = "1.0.1",
			["justify"] = "LEFT",
			["tocversion"] = 20501,
			["id"] = "timer",
			["authorOptions"] = {
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["automaticWidth"] = "Auto",
			["config"] = {
			},
			["displayText_format_p_time_legacy_floor"] = true,
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
			},
			["displayText_format_p_time_mod_rate"] = true,
		},
		["Druid - Energy Bar"] = {
			["sparkWidth"] = 10,
			["iconSource"] = -1,
			["xOffset"] = 0.0003662109375,
			["preferToUpdate"] = false,
			["yOffset"] = -300,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["url"] = "https://wago.io/HCaWT5tJa/14",
			["backgroundColor"] = {
				1, -- [1]
				0.82352941176471, -- [2]
				0, -- [3]
				0.30000001192093, -- [4]
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
						["ROGUE"] = true,
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
				["use_class"] = false,
				["race"] = {
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
				["role"] = {
					["multi"] = {
					},
				},
				["use_petbattle"] = false,
				["zoneIds"] = "",
			},
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["texture"] = "Clean",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["spark"] = false,
			["tocversion"] = 11302,
			["alpha"] = 1,
			["uid"] = "c5D6XJKEyid",
			["sparkOffsetX"] = 0,
			["parent"] = "DRUID / ROGUE",
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
						["spellIds"] = {
						},
						["health"] = "0",
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
			["internalVersion"] = 53,
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
					["text_font"] = "Arial Narrow",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = false,
					["text_anchorPoint"] = "INNER_RIGHT",
					["text_fontType"] = "None",
					["text_fontSize"] = 15,
					["anchorXOffset"] = 0,
					["text_text_format_c_format"] = "none",
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
			["borderBackdrop"] = "None",
			["authorOptions"] = {
			},
			["borderInFront"] = true,
			["sparkRotationMode"] = "AUTO",
			["icon_side"] = "RIGHT",
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
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["sparkHeight"] = 30,
			["sparkHidden"] = "NEVER",
			["overlaysTexture"] = {
				"Clean", -- [1]
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
			["auto"] = true,
			["frameStrata"] = 3,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0,
			["icon"] = false,
			["inverse"] = false,
			["sparkDesature"] = false,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["config"] = {
			},
		},
		["timer 2"] = {
			["outline"] = "OUTLINE",
			["wagoID"] = "v9qxdDgI4",
			["xOffset"] = 0,
			["displayText_format_p_time_dynamic_threshold"] = 60,
			["shadowYOffset"] = -1,
			["anchorPoint"] = "CENTER",
			["displayText_format_p_time_format"] = 0,
			["customTextUpdate"] = "event",
			["url"] = "https://wago.io/v9qxdDgI4/2",
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
						["use_destFlags2"] = false,
						["spellId"] = "34428",
						["auranames"] = {
							"Predator's Swiftness", -- [1]
						},
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showOnCooldown",
						["names"] = {
						},
						["debuffType"] = "HELPFUL",
						["use_track"] = true,
						["spellName"] = 34428,
						["useName"] = true,
						["type"] = "aura2",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_SUCCESS",
						["use_critical"] = true,
						["use_spellName"] = true,
						["event"] = "Action Usable",
						["use_sourceFlags2"] = false,
						["realSpellName"] = "Victory Rush",
						["use_spellId"] = false,
						["spellIds"] = {
						},
						["use_sourceUnit"] = true,
						["duration"] = "0",
						["use_destUnit"] = false,
						["sourceUnit"] = "player",
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "all",
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
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
			["font"] = "PT Sans Narrow",
			["version"] = 2,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["load"] = {
				["use_class"] = true,
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
			["shadowXOffset"] = 1,
			["preferToUpdate"] = false,
			["wordWrap"] = "WordWrap",
			["regionType"] = "text",
			["parent"] = "Predatory Strikes",
			["conditions"] = {
			},
			["selfPoint"] = "BOTTOM",
			["yOffset"] = 30,
			["displayText_format_p_time_precision"] = 1,
			["config"] = {
			},
			["displayText_format_p_time_legacy_floor"] = true,
			["justify"] = "LEFT",
			["semver"] = "1.0.1",
			["tocversion"] = 20501,
			["id"] = "timer 2",
			["authorOptions"] = {
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["automaticWidth"] = "Auto",
			["uid"] = "DAiRBlKdX3k",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayText"] = "%p",
			["shadowColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["information"] = {
			},
			["displayText_format_p_time_mod_rate"] = true,
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
			["internalVersion"] = 53,
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
					["text_text_format_p_time_precision"] = 1,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
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
			["semver"] = "1.0.11",
			["uid"] = "LlweJVq9JnC",
			["parent"] = "Warlock 2.0",
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
			["cooldownEdge"] = false,
			["icon"] = true,
			["width"] = 35,
			["useCooldownModRate"] = true,
			["cooldownTextDisabled"] = true,
			["auto"] = false,
			["tocversion"] = 11302,
			["id"] = "Warlock - Perception",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0.3,
			["config"] = {
			},
			["inverse"] = false,
			["xOffset"] = 106,
			["displayIcon"] = 136090,
			["cooldown"] = true,
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
			["yOffset"] = 0,
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
						["unit"] = "player",
						["use_inverse"] = false,
						["event"] = "Stance/Form/Aura",
						["names"] = {
						},
						["use_unit"] = true,
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["duration"] = "1",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["form"] = {
							["single"] = 3,
						},
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["internalVersion"] = 53,
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
			["parent"] = "Warrior 2.0",
			["url"] = "https://wago.io/z6xqQay0S/16",
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
			["semver"] = "1.0.15",
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
				["ignoreOptionsEventErrors"] = true,
			},
			["preferToUpdate"] = false,
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
						["spellName"] = 16893,
						["unit"] = "player",
						["type"] = "item",
						["use_remaining"] = false,
						["subeventSuffix"] = "_CAST_START",
						["unevent"] = "auto",
						["event"] = "Cooldown Progress (Item)",
						["use_itemName"] = true,
						["use_exact_spellName"] = false,
						["realSpellName"] = "Nature Protection ",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["useExactSpellId"] = true,
						["auraspellids"] = {
							"7744", -- [1]
						},
						["debuffType"] = "HELPFUL",
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
			["internalVersion"] = 53,
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
					["text_text_format_p_time_precision"] = 1,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
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
			["anchorFrameType"] = "SCREEN",
			["xOffset"] = -105,
			["selfPoint"] = "CENTER",
			["icon"] = true,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["regionType"] = "icon",
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
			["parent"] = "Warlock 2.0",
			["useTooltip"] = false,
			["config"] = {
			},
			["alpha"] = 1,
			["frameStrata"] = 1,
			["zoom"] = 0.3,
			["auto"] = false,
			["tocversion"] = 11302,
			["id"] = "Warlock - Soul Stone",
			["semver"] = "1.0.11",
			["useCooldownModRate"] = true,
			["width"] = 35.5,
			["cooldownTextDisabled"] = true,
			["uid"] = "NFJFRFkttht",
			["inverse"] = false,
			["cooldownEdge"] = false,
			["displayIcon"] = 136210,
			["cooldown"] = true,
			["authorOptions"] = {
			},
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
						["subeventSuffix"] = "_CAST_START",
						["events"] = "COMBAT_LOG_EVENT_UNFILTERED DELAYED_PLAYER_ENTERING_WORLD",
						["spellIds"] = {
						},
						["event"] = "Conditions",
						["customStacks"] = "",
						["customDuration"] = "",
						["customName"] = "",
						["custom"] = "function(...)\n    aura_env:on_cleu(...)\nend\n\n\n",
						["names"] = {
						},
						["check"] = "event",
						["unevent"] = "auto",
						["custom_type"] = "status",
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["displayText_format_p_format"] = "timed",
			["internalVersion"] = 53,
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
			["selfPoint"] = "BOTTOM",
			["displayText_format_p_time_dynamic_threshold"] = 0,
			["regionType"] = "text",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["parent"] = "Shield",
			["yOffset"] = -10,
			["displayText_format_p_time_precision"] = 1,
			["config"] = {
				["debugEnabled"] = false,
			},
			["preferToUpdate"] = false,
			["justify"] = "CENTER",
			["semver"] = "1.0.0",
			["tocversion"] = 11305,
			["id"] = "nanShield:Value",
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
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["automaticWidth"] = "Auto",
			["uid"] = "gURA36O1i4T",
			["displayText_format_p_time_legacy_floor"] = true,
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
			["displayText_format_p_time_mod_rate"] = true,
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
						["custom"] = "function()\n    local region = aura_env.region\n    local plate = C_NamePlate.GetNamePlateForUnit(\"target\")\n    \n    \n    if plate then\n        region:ClearAllPoints()\n        region:SetPoint(\"RIGHT\", plate, \"LEFT\", -60, 0)\n        return true\n    else\n        return false\n    end\nend",
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
			["internalVersion"] = 53,
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
				["size"] = {
					["multi"] = {
					},
				},
				["namerealm"] = "xxx",
				["use_combat"] = true,
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["fontSize"] = 24,
			["shadowXOffset"] = 1,
			["preferToUpdate"] = false,
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
			["selfPoint"] = "BOTTOM",
			["semver"] = "1.0.1",
			["uid"] = "L9pe9C7xoBj",
			["justify"] = "LEFT",
			["tocversion"] = 11306,
			["id"] = "MobHPPercentRED",
			["xOffset"] = 0,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["shadowYOffset"] = -1,
			["config"] = {
			},
			["authorOptions"] = {
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
				["ignoreOptionsEventErrors"] = true,
			},
			["displayText_format_c_format"] = "none",
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
				["spec"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["multi"] = {
					},
				},
				["use_combat"] = true,
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
			["gridType"] = "RD",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["fullCircle"] = true,
			["animate"] = true,
			["limit"] = 5,
			["scale"] = 1,
			["arcLength"] = 360,
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "dynamicgroup",
			["borderSize"] = 2,
			["sort"] = "none",
			["internalVersion"] = 53,
			["stagger"] = 0,
			["constantFactor"] = "RADIUS",
			["uid"] = "XLzBWxn1LoM",
			["borderOffset"] = 16,
			["authorOptions"] = {
			},
			["anchorFrameType"] = "SCREEN",
			["id"] = "Details! Aura Group",
			["frameStrata"] = 1,
			["gridWidth"] = 5,
			["width"] = 199.999969482422,
			["config"] = {
			},
			["borderInset"] = 0,
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
			["useLimit"] = false,
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["rowSpace"] = 1,
		},
		["ICY TOUCH"] = {
			["iconSource"] = -1,
			["wagoID"] = "pw_hjyCcX",
			["parent"] = "DK DOTS",
			["preferToUpdate"] = false,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["cooldownSwipe"] = false,
			["url"] = "https://wago.io/pw_hjyCcX/17",
			["actions"] = {
				["start"] = {
					["message"] = "",
					["do_message"] = false,
					["message_type"] = "RAID_WARNING",
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura2",
						["use_debuffClass"] = false,
						["useExactSpellId"] = false,
						["unit"] = "target",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["useName"] = true,
						["auranames"] = {
							"Frost Fever", -- [1]
						},
						["spellIds"] = {
						},
						["auraspellids"] = {
						},
						["combineMode"] = "showHighest",
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
			["internalVersion"] = 53,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["desaturate"] = false,
			["version"] = 17,
			["subRegions"] = {
				{
					["type"] = "subbackground",
				}, -- [1]
			},
			["height"] = 60,
			["load"] = {
				["use_namerealm"] = true,
				["ingroup"] = {
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
				["use_class"] = true,
				["zoneIds"] = "",
				["class"] = {
					["single"] = "DEATHKNIGHT",
					["multi"] = {
						["PALADIN"] = true,
						["PRIEST"] = true,
					},
				},
				["namerealm"] = "xxxx",
				["size"] = {
					["multi"] = {
					},
				},
			},
			["zoom"] = 0.3,
			["uid"] = "Enbdwe6Y3vG",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
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
			["regionType"] = "icon",
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["icon"] = true,
			["useTooltip"] = false,
			["authorOptions"] = {
			},
			["anchorFrameType"] = "SCREEN",
			["alpha"] = 1,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.0.16",
			["tocversion"] = 20503,
			["id"] = "ICY TOUCH",
			["frameStrata"] = 1,
			["useCooldownModRate"] = true,
			["width"] = 60,
			["auto"] = true,
			["config"] = {
			},
			["inverse"] = false,
			["xOffset"] = 32,
			["conditions"] = {
				{
					["check"] = {
						["trigger"] = 1,
						["op"] = "==",
						["variable"] = "debuffClass",
						["value"] = "magic",
					},
					["changes"] = {
						{
							["value"] = {
								0.2, -- [1]
								0.6, -- [2]
								1, -- [3]
								1, -- [4]
							},
						}, -- [1]
						{
							["value"] = true,
						}, -- [2]
					},
				}, -- [1]
			},
			["cooldown"] = true,
			["cooldownEdge"] = false,
		},
		["Druid - Rage Bar"] = {
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
				["use_class"] = false,
				["race"] = {
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
				["role"] = {
					["multi"] = {
					},
				},
				["use_petbattle"] = false,
				["zoneIds"] = "",
			},
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["texture"] = "Clean",
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
			["parent"] = "DRUID / ROGUE",
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
						["spellIds"] = {
						},
						["health"] = "0",
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
			["internalVersion"] = 53,
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
					["text_font"] = "Arial Narrow",
					["text_shadowYOffset"] = -1,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_RIGHT",
					["text_fontType"] = "None",
					["text_fontSize"] = 15,
					["anchorXOffset"] = 0,
					["text_text_format_c_format"] = "none",
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
				"Clean", -- [1]
			},
			["auto"] = true,
			["semver"] = "1.0.13",
			["anchorFrameType"] = "SCREEN",
			["sparkHidden"] = "NEVER",
			["config"] = {
			},
			["frameStrata"] = 3,
			["width"] = 245,
			["id"] = "Druid - Rage Bar",
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
			["gridType"] = "RD",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["fullCircle"] = true,
			["animate"] = true,
			["limit"] = 5,
			["scale"] = 1,
			["arcLength"] = 360,
			["border"] = false,
			["borderEdge"] = "Square Full White",
			["regionType"] = "dynamicgroup",
			["borderSize"] = 2,
			["sort"] = "none",
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
			["stagger"] = 0,
			["constantFactor"] = "RADIUS",
			["uid"] = "N5YikxjcJsU",
			["borderOffset"] = 16,
			["authorOptions"] = {
			},
			["anchorFrameType"] = "SCREEN",
			["id"] = "Details! Boss Mods Group",
			["frameStrata"] = 1,
			["gridWidth"] = 5,
			["width"] = 359.096801757813,
			["config"] = {
			},
			["borderInset"] = 0,
			["internalVersion"] = 53,
			["useLimit"] = false,
			["conditions"] = {
			},
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["rowSpace"] = 1,
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
			["internalVersion"] = 53,
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
					["text_text_format_p_time_format"] = 0,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_legacy_floor"] = true,
					["text_shadowYOffset"] = 0,
					["text_text_format_p_time_precision"] = 1,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_visible"] = true,
					["text_fontSize"] = 16,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
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
					["text_text_format_p_time_precision"] = 1,
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
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_text_format_p_time_format"] = 0,
					["text_fontSize"] = 12,
					["anchorXOffset"] = 0,
					["text_text_format_c_format"] = "none",
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
			["auto"] = true,
			["config"] = {
			},
			["parent"] = "DEBUFFS - TARGET",
			["useTooltip"] = true,
			["regionType"] = "icon",
			["information"] = {
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
			["authorOptions"] = {
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["width"] = 36,
			["useCooldownModRate"] = true,
			["zoom"] = 0.3,
			["semver"] = "1.0.0",
			["tocversion"] = 90001,
			["id"] = "targetdebuffs ",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["cooldownTextDisabled"] = true,
			["uid"] = "6DKG8nfVQ8x",
			["inverse"] = false,
			["selfPoint"] = "CENTER",
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
						["custom"] = "function()\n    local region = aura_env.region\n    local plate = C_NamePlate.GetNamePlateForUnit(\"target\")\n    \n    \n    if plate then\n        region:ClearAllPoints()\n        region:SetPoint(\"RIGHT\", plate, \"LEFT\", -60, 0)\n        return true\n    else\n        return false\n    end\nend",
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
			["internalVersion"] = 53,
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
				["size"] = {
					["multi"] = {
					},
				},
				["namerealm"] = "xxx",
				["use_combat"] = true,
				["class"] = {
					["single"] = "WARRIOR",
					["multi"] = {
					},
				},
				["zoneIds"] = "",
			},
			["fontSize"] = 24,
			["shadowXOffset"] = 1,
			["preferToUpdate"] = false,
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
			["selfPoint"] = "BOTTOM",
			["semver"] = "1.0.1",
			["uid"] = "eckTlXrxzPt",
			["justify"] = "LEFT",
			["tocversion"] = 11306,
			["id"] = "MobHPPercentGREEN",
			["xOffset"] = 0,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["shadowYOffset"] = -1,
			["config"] = {
			},
			["authorOptions"] = {
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
				["ignoreOptionsEventErrors"] = true,
			},
			["displayText_format_c_format"] = "none",
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
			["internalVersion"] = 53,
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
					["text_text_format_p_time_precision"] = 1,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Vixar",
					["text_text_format_p_time_format"] = 0,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 26,
					["anchorXOffset"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
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
			["semver"] = "1.0.11",
			["uid"] = "jRRk0BDjOIS",
			["url"] = "https://wago.io/Y8douZITb/12",
			["parent"] = "Warlock 2.0",
			["regionType"] = "icon",
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
			["xOffset"] = -49,
			["icon"] = true,
			["anchorFrameType"] = "SCREEN",
			["useCooldownModRate"] = true,
			["cooldownTextDisabled"] = true,
			["auto"] = true,
			["tocversion"] = 11302,
			["id"] = "Warlock - Curse Of Agony",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 49,
			["zoom"] = 0.3,
			["config"] = {
			},
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["displayIcon"] = 136139,
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
			["internalVersion"] = 53,
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
			["auto"] = true,
			["uid"] = "ToLYidE5fIK",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
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
			["regionType"] = "icon",
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
			["parent"] = "GEMS",
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
			["anchorFrameType"] = "SCREEN",
			["useCooldownModRate"] = true,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.0.0",
			["tocversion"] = 11304,
			["id"] = "Jade",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["width"] = 40,
			["zoom"] = 0,
			["config"] = {
				["macro"] = {
					["text"] = "/cast Conjure Mana Jade",
				},
			},
			["inverse"] = false,
			["cooldownEdge"] = false,
			["displayIcon"] = 134105,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
		},
		["VictoryRush"] = {
			["controlledChildren"] = {
				"VrIcon", -- [1]
				"timer", -- [2]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["wagoID"] = "v9qxdDgI4",
			["authorOptions"] = {
			},
			["preferToUpdate"] = false,
			["yOffset"] = 450,
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
			["internalVersion"] = 53,
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
			["borderInset"] = 1,
			["uid"] = "0EznwWi8AYW",
			["config"] = {
			},
			["xOffset"] = 0,
			["conditions"] = {
			},
			["information"] = {
			},
			["selfPoint"] = "CENTER",
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
			["internalVersion"] = 53,
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
			["auto"] = true,
			["config"] = {
				["macro"] = {
					["text"] = "/cast Conjure Mana Ruby",
				},
			},
			["xOffset"] = 120,
			["url"] = "https://wago.io/U0WH3IJ3S/1",
			["regionType"] = "icon",
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
			["parent"] = "GEMS",
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
			["width"] = 40,
			["useCooldownModRate"] = true,
			["cooldownTextDisabled"] = false,
			["semver"] = "1.0.0",
			["tocversion"] = 11304,
			["id"] = "Ruby",
			["frameStrata"] = 1,
			["alpha"] = 1,
			["anchorFrameType"] = "SCREEN",
			["zoom"] = 0,
			["uid"] = "UvSV5jPJMlO",
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["displayIcon"] = 134128,
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
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
					["key"] = "macro",
					["type"] = "group",
					["limitType"] = "none",
					["groupType"] = "simple",
					["collapse"] = false,
					["size"] = 10,
				}, -- [1]
			},
		},
		["Mainhand swing bar"] = {
			["sparkWidth"] = 10,
			["sparkOffsetX"] = 0,
			["xOffset"] = 0.000244140625,
			["preferToUpdate"] = false,
			["yOffset"] = -75,
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
						["type"] = "custom",
						["subeventSuffix"] = "_CAST_START",
						["custom_hide"] = "custom",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["customDuration"] = "function()\n    if aura_env.swingStop ~= nil then\n        return aura_env.swingStop, aura_env.speed, true\n    else\n        return aura_env.speed, aura_env.expirationTime\n    end\nend",
						["events"] = "SWING_TIMER_START SWING_TIMER_UPDATE SWING_TIMER_PAUSED",
						["spellIds"] = {
						},
						["custom_type"] = "event",
						["custom"] = "function(event, speed, expirationTime, hand)\n    if event == \"SWING_TIMER_PAUSED\" and speed == \"mainhand\" then\n        aura_env.swingStop = aura_env.expirationTime - GetTime()\n        return true\n    elseif event ~= \"OPTIONS\" and hand == \"mainhand\" and speed ~= nil and expirationTime ~= nil then\n        aura_env.speed = speed\n        aura_env.expirationTime = expirationTime\n        aura_env.swingStop = nil\n        return true\n    else\n        return false\n    end\nend",
						["names"] = {
						},
						["unit"] = "player",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "unit",
						["use_hostility"] = true,
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Unit Characteristics",
						["use_character"] = false,
						["unit"] = "target",
						["use_unit"] = true,
						["hostility"] = "hostile",
						["spellIds"] = {
						},
						["unitisunit"] = "target",
						["subeventPrefix"] = "SPELL",
						["use_unitisunit"] = true,
						["names"] = {
						},
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [2]
				{
					["trigger"] = {
						["use_unit"] = true,
						["type"] = "unit",
						["use_alwaystrue"] = true,
						["names"] = {
						},
						["spellIds"] = {
						},
						["unit"] = "player",
						["event"] = "Conditions",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [3]
				["disjunctive"] = "all",
				["customTriggerLogic"] = "function(t)\n    return t[1] or t[3] or t[2]\nend",
				["activeTriggerMode"] = 1,
			},
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["internalVersion"] = 53,
			["selfPoint"] = "CENTER",
			["barColor"] = {
				0.5372549019607843, -- [1]
				0.5372549019607843, -- [2]
				0.5372549019607843, -- [3]
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
					["text_text_format_p_time_legacy_floor"] = false,
					["type"] = "subtext",
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["text_text_format_p_time_precision"] = 1,
					["text_shadowYOffset"] = -1,
					["text_text_format_p_time_mod_rate"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_visible"] = true,
					["text_anchorPoint"] = "INNER_LEFT",
					["text_text_format_p_time_format"] = 0,
					["text_fontType"] = "None",
					["text_fontSize"] = 8,
					["anchorXOffset"] = 0,
					["text_text_format_p_format"] = "timed",
				}, -- [3]
			},
			["height"] = 8,
			["load"] = {
				["use_class"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "DEATHKNIGHT",
					["multi"] = {
						["DEATHKNIGHT"] = true,
						["WARRIOR"] = true,
						["PALADIN"] = true,
						["DRUID"] = true,
						["ROGUE"] = true,
						["SHAMAN"] = true,
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
			["sparkHidden"] = "NEVER",
			["source"] = "import",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
					["do_custom"] = true,
					["custom"] = "local mainSpeed = UnitAttackSpeed(\"player\")\naura_env.speed = mainSpeed or 0\naura_env.expirationTime = GetTime() + aura_env.speed\naura_env.swingStop = nil",
				},
				["finish"] = {
				},
			},
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
				["main"] = {
					["colorR"] = 1,
					["scalex"] = 1,
					["colorB"] = 1,
					["colorG"] = 1,
					["type"] = "custom",
					["easeType"] = "none",
					["use_color"] = true,
					["alpha"] = 0,
					["scaley"] = 1,
					["y"] = 0,
					["x"] = 0,
					["colorA"] = 1,
					["rotate"] = 0,
					["colorFunc"] = "function()\n    local c = RAID_CLASS_COLORS[select(2, UnitClass(\"player\"))]\n    return c.r, c.g, c.b\nend",
					["easeStrength"] = 3,
					["colorType"] = "custom",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["easeStrength"] = 3,
					["duration_type"] = "seconds",
					["easeType"] = "none",
				},
			},
			["smoothProgress"] = true,
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["authorOptions"] = {
			},
			["iconSource"] = -1,
			["icon_side"] = "RIGHT",
			["zoom"] = 0,
			["sparkHeight"] = 30,
			["texture"] = "Clean",
			["uid"] = "PvvHF4p7rlH",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["spark"] = false,
			["tocversion"] = 30400,
			["id"] = "Mainhand swing bar",
			["anchorFrameType"] = "SCREEN",
			["alpha"] = 1,
			["width"] = 200,
			["frameStrata"] = 1,
			["config"] = {
			},
			["inverse"] = true,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["information"] = {
			},
			["icon"] = false,
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
					["text_text_format_p_time_format"] = 0,
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
					["text_text_format_p_format"] = "timed",
					["text_text_format_p_time_legacy_floor"] = true,
					["text_fontSize"] = 16,
					["text_text_format_p_time_dynamic_threshold"] = 0,
					["text_text_format_p_time_mod_rate"] = true,
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
					["text_text_format_p_time_precision"] = 1,
					["text_color"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["text_font"] = "Friz Quadrata TT",
					["anchorXOffset"] = 0,
					["text_shadowYOffset"] = 0,
					["text_visible"] = true,
					["text_wordWrap"] = "WordWrap",
					["text_fontType"] = "OUTLINE",
					["text_anchorPoint"] = "CENTER",
					["text_text_format_p_format"] = "timed",
					["text_text_format_p_time_format"] = 0,
					["text_fontSize"] = 12,
					["text_text_format_p_time_dynamic_threshold"] = 60,
					["text_text_format_c_format"] = "none",
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
			["semver"] = "1.0.0",
			["uid"] = "DMEkSzl4NuN",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["selfPoint"] = "CENTER",
			["regionType"] = "icon",
			["cooldown"] = true,
			["xOffset"] = 0,
			["internalVersion"] = 53,
			["cooldownEdge"] = false,
			["anchorFrameType"] = "SCREEN",
			["useCooldownModRate"] = true,
			["zoom"] = 0.3,
			["auto"] = true,
			["tocversion"] = 90001,
			["id"] = "targetdebuffs  2",
			["alpha"] = 1,
			["frameStrata"] = 1,
			["width"] = 36,
			["cooldownTextDisabled"] = true,
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
			["information"] = {
				["ignoreOptionsEventErrors"] = true,
			},
			["parent"] = "DEBUFFS - PET",
		},
	},
	["editor_font_size"] = 12,
	["lastArchiveClear"] = 1602609267,
	["minimap"] = {
		["hide"] = true,
	},
	["lastUpgrade"] = 1662193007,
	["dbVersion"] = 53,
	["personalRessourceDisplayFrame"] = {
		["xOffset"] = -422.8046555407566,
		["yOffset"] = -497.8042091158466,
	},
	["registered"] = {
	},
	["instanceHistoryDb"] = {
		["sess"] = {
			["histOldest"] = "54 |4Min:Min;",
			["enterLoc"] = {
				["instance"] = -1,
			},
			["delayUpdate"] = 1664049563,
			["histLiveCount"] = 1,
		},
		["History"] = {
			["Moolatz - Golemagg:Hellfire Citadel: Ramparts:party:1:580"] = {
				["last"] = 1664049250,
				["create"] = 1664047957,
				["desc"] = "Moolatz - Golemagg: Hellfire Citadel: Ramparts - Normal",
			},
		},
		["HistoryDay"] = {
			["Vermin - Golemagg:Tempest Keep: The Arcatraz:party:1:550"] = {
				["last"] = 1664021811,
				["create"] = 1664019987,
				["desc"] = "Vermin - Golemagg: Tempest Keep: The Arcatraz - Normal",
			},
			["Moolatz - Golemagg:Hellfire Citadel: Ramparts:party:1:580"] = {
				["last"] = 1664049250,
				["create"] = 1664047957,
				["desc"] = "Moolatz - Golemagg: Hellfire Citadel: Ramparts - Normal",
			},
		},
		["histGeneration"] = 581,
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
	["frame"] = {
		["xOffset"] = -1322.03466796875,
		["yOffset"] = -74.39111328125,
		["height"] = 956.4474487304688,
		["width"] = 993.678466796875,
	},
	["bgtimetotsave"] = 0,
	["editor_theme"] = "Monokai",
}
