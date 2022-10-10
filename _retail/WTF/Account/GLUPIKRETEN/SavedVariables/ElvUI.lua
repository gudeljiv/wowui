
ElvDB = {
	["global"] = {
		["general"] = {
			["UIScale"] = 0.5333333333333333,
		},
		["datatexts"] = {
			["settings"] = {
				["Currencies"] = {
					["tooltipData"] = {
						{
							nil, -- [1]
							nil, -- [2]
							nil, -- [3]
							true, -- [4]
						}, -- [1]
						nil, -- [2]
						nil, -- [3]
						nil, -- [4]
						{
							nil, -- [1]
							nil, -- [2]
							nil, -- [3]
							true, -- [4]
						}, -- [5]
						nil, -- [6]
						{
							nil, -- [1]
							nil, -- [2]
							nil, -- [3]
							true, -- [4]
						}, -- [7]
						nil, -- [8]
						nil, -- [9]
						nil, -- [10]
						nil, -- [11]
						nil, -- [12]
						{
							nil, -- [1]
							nil, -- [2]
							nil, -- [3]
							true, -- [4]
						}, -- [13]
						nil, -- [14]
						nil, -- [15]
						{
							nil, -- [1]
							nil, -- [2]
							nil, -- [3]
							true, -- [4]
						}, -- [16]
					},
				},
			},
		},
		["nameplates"] = {
			["filters"] = {
				["ElvUI_NonTarget"] = {
				},
				["ElvUI_Explosives"] = {
				},
				["ElvUI_Target"] = {
				},
				["ElvUI_Boss"] = {
				},
			},
		},
	},
	["DisabledAddOns"] = {
	},
	["namespaces"] = {
		["LibDualSpec-1.0"] = {
		},
	},
	["class"] = {
		["Dentarg"] = {
			["Korupcija"] = "PALADIN",
			["Mulac"] = "DRUID",
			["Handrmandr"] = "MONK",
			["Vermins"] = "WARRIOR",
			["Govance"] = "MAGE",
			["Verson"] = "WARLOCK",
			["Kostur"] = "PRIEST",
			["Battitude"] = "ROGUE",
			["Pitchwise"] = "SHAMAN",
			["Tuka"] = "HUNTER",
			["Konza"] = "DEATHKNIGHT",
		},
	},
	["profiles"] = {
		["Default"] = {
			["currentTutorial"] = 3,
			["general"] = {
				["totems"] = {
					["size"] = 50,
					["growthDirection"] = "HORIZONTAL",
					["spacing"] = 8,
				},
				["valuecolor"] = {
					["r"] = 0.7764688730239868,
					["g"] = 0.6078417897224426,
					["b"] = 0.427450031042099,
				},
				["font"] = "Arial Narrow",
				["objectiveFrameHeight"] = 400,
				["minimap"] = {
					["locationFont"] = "Arial Narrow",
					["size"] = 220,
				},
				["backdropcolor"] = {
					["a"] = 1,
				},
				["talkingHeadFrameScale"] = 1,
				["bonusObjectivePosition"] = "AUTO",
			},
			["bags"] = {
				["itemLevelFont"] = "Arial Narrow",
				["bagSize"] = 42,
				["itemLevelCustomColorEnable"] = true,
				["itemLevelFontSize"] = 12,
				["bankSize"] = 42,
				["scrapIcon"] = true,
				["countFontSize"] = 12,
				["bagWidth"] = 474,
				["countFont"] = "Arial Narrow",
				["bankWidth"] = 474,
			},
			["chat"] = {
				["panelSnapRightID"] = 4,
				["font"] = "Arial Narrow",
				["panelWidth"] = 472,
				["panelHeight"] = 236,
				["panelSnapLeftID"] = 1,
				["fontSize"] = 12,
				["tabFont"] = "Arial Narrow",
			},
			["dbConverted"] = 12.91,
			["layoutSet"] = "dpsCaster",
			["layoutSetting"] = "dpsCaster",
			["convertPages"] = true,
			["tooltip"] = {
				["cursorAnchorType"] = "ANCHOR_CURSOR_RIGHT",
				["healthBar"] = {
					["font"] = "Arial Narrow",
					["fontOutline"] = "MONOCHROMEOUTLINE",
					["height"] = 12,
				},
				["cursorAnchorY"] = 30,
				["font"] = "Arial Narrow",
				["fontSize"] = 12,
				["headerFont"] = "Arial Narrow",
				["cursorAnchor"] = true,
				["headerFontSize"] = 12,
				["cursorAnchorX"] = 10,
			},
			["movers"] = {
				["TopCenterContainerMover"] = "TOP,ElvUIParent,TOP,0,-30",
				["PetAB"] = "RIGHT,ElvUI_Bar4,LEFT,-4,0",
				["LeftChatMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,4,4",
				["GMMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,250,-5",
				["BuffsMover"] = "TOPRIGHT,MMHolder,TOPLEFT,-7,-1",
				["MirrorTimer3Mover"] = "TOP,MirrorTimer2,BOTTOM,0,0",
				["BossButton"] = "BOTTOM,ElvUIParent,BOTTOM,-1,293",
				["LootFrameMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,250,-104",
				["ZoneAbility"] = "BOTTOM,ElvUIParent,BOTTOM,-1,293",
				["SocialMenuMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-187",
				["ElvUF_AssistMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-248",
				["ElvUF_FocusMover"] = "BOTTOM,ElvUIParent,BOTTOM,342,59",
				["ElvUF_Raid3Mover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,482",
				["ElvUF_FocusCastbarMover"] = "TOPLEFT,ElvUF_Focus,BOTTOMLEFT,0,-1",
				["RightChatMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-4,4",
				["DurabilityFrameMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-135,-300",
				["ElvUF_PetCastbarMover"] = "TOPLEFT,ElvUF_Pet,BOTTOMLEFT,0,-1",
				["VehicleSeatMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-4",
				["ElvUF_TargetTargetMover"] = "BOTTOM,ElvUIParent,BOTTOM,342,100",
				["ExperienceBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,43",
				["ElvUIBagMover"] = "BOTTOMRIGHT,RightChatPanel,BOTTOMRIGHT,0,25",
				["ElvUF_TargetMover"] = "BOTTOM,ElvUIParent,BOTTOM,342,139",
				["ElvUF_PlayerMover"] = "BOTTOM,ElvUIParent,BOTTOM,-342,139",
				["LossControlMover"] = "BOTTOM,ElvUIParent,BOTTOM,-1,507",
				["LevelUpBossBannerMover"] = "TOP,ElvUIParent,TOP,-1,-120",
				["MirrorTimer1Mover"] = "TOP,ElvUIParent,TOP,-1,-96",
				["ElvUF_Raid1Mover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,202,373",
				["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,-1,191",
				["ElvUF_PetMover"] = "BOTTOM,ElvUIParent,BOTTOM,-342,100",
				["BelowMinimapContainerMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-4,-274",
				["ElvAB_6"] = "BOTTOM,ElvUIParent,BOTTOM,-1,139",
				["TalkingHeadFrameMover"] = "BOTTOM,ElvUIParent,BOTTOM,-1,373",
				["ElvUF_TargetCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,97",
				["AltPowerBarMover"] = "TOP,ElvUIParent,TOP,-1,-36",
				["ElvUIBankMover"] = "BOTTOMLEFT,LeftChatPanel,BOTTOMLEFT,0,25",
				["ElvAB_5"] = "BOTTOM,ElvUIParent,BOTTOM,0,4",
				["VehicleLeaveButton"] = "BOTTOM,ElvUIParent,BOTTOM,0,300",
				["AzeriteBarMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-3,-245",
				["ShiftAB"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,273",
				["ObjectiveFrameMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-163,-325",
				["MirrorTimer2Mover"] = "TOP,MirrorTimer1,BOTTOM,0,0",
				["VOICECHAT"] = "TOPLEFT,ElvUIParent,TOPLEFT,250,-82",
				["BNETMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-4,-274",
				["HonorBarMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-3,-255",
				["ArenaHeaderMover"] = "BOTTOMRIGHT,ElvUIParent,RIGHT,-105,-165",
				["TooltipMover"] = "BOTTOMRIGHT,RightChatToggleButton,BOTTOMRIGHT,0,0",
				["ElvUF_TankMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-186",
				["BossHeaderMover"] = "BOTTOMRIGHT,ElvUIParent,RIGHT,-105,-165",
				["TotemBarMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,490,4",
				["ElvUF_PlayerCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,243",
				["ElvUF_PartyMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,4,248",
				["AlertFrameMover"] = "TOP,ElvUIParent,TOP,-1,-18",
				["DebuffsMover"] = "BOTTOMRIGHT,MMHolder,BOTTOMLEFT,-7,1",
				["MinimapMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-3,-3",
			},
			["unitframe"] = {
				["font"] = "Arial Narrow",
				["units"] = {
					["raid3"] = {
						["rdebuffs"] = {
							["font"] = "Arial Narrow",
						},
					},
					["focus"] = {
						["castbar"] = {
							["width"] = 270,
						},
						["width"] = 270,
					},
					["target"] = {
						["orientation"] = "LEFT",
						["aurabar"] = {
							["enable"] = false,
						},
						["castbar"] = {
							["insideInfoPanel"] = false,
							["width"] = 405,
							["height"] = 40,
						},
						["healPrediction"] = {
							["absorbStyle"] = "NORMAL",
						},
						["disableMouseoverGlow"] = true,
						["infoPanel"] = {
							["enable"] = true,
						},
						["name"] = {
							["attachTextTo"] = "InfoPanel",
						},
						["power"] = {
							["attachTextTo"] = "InfoPanel",
							["height"] = 22,
						},
						["height"] = 82,
						["health"] = {
							["attachTextTo"] = "InfoPanel",
						},
					},
					["raid2"] = {
						["rdebuffs"] = {
							["font"] = "Arial Narrow",
						},
					},
					["pet"] = {
						["debuffs"] = {
							["enable"] = true,
							["anchorPoint"] = "TOPRIGHT",
						},
						["castbar"] = {
							["iconSize"] = 32,
						},
						["width"] = 270,
						["infoPanel"] = {
							["height"] = 14,
						},
						["disableTargetGlow"] = false,
					},
					["player"] = {
						["debuffs"] = {
							["attachTo"] = "BUFFS",
						},
						["healPrediction"] = {
							["absorbStyle"] = "NORMAL",
						},
						["disableMouseoverGlow"] = true,
						["height"] = 82,
						["buffs"] = {
							["enable"] = true,
							["attachTo"] = "FRAME",
						},
						["infoPanel"] = {
							["enable"] = true,
						},
						["aurabar"] = {
							["enable"] = false,
						},
						["castbar"] = {
							["insideInfoPanel"] = false,
							["width"] = 405,
							["height"] = 40,
						},
						["health"] = {
							["attachTextTo"] = "InfoPanel",
						},
						["classbar"] = {
							["height"] = 14,
						},
						["power"] = {
							["attachTextTo"] = "InfoPanel",
							["height"] = 22,
						},
					},
					["raid1"] = {
						["roleIcon"] = {
							["attachTo"] = "InfoPanel",
							["xOffset"] = 0,
							["size"] = 12,
						},
						["infoPanel"] = {
							["enable"] = true,
						},
						["name"] = {
							["attachTextTo"] = "InfoPanel",
							["position"] = "BOTTOMLEFT",
							["xOffset"] = 2,
						},
						["rdebuffs"] = {
							["xOffset"] = 30,
							["yOffset"] = 25,
							["font"] = "Arial Narrow",
							["size"] = 30,
						},
						["numGroups"] = 8,
						["growthDirection"] = "RIGHT_UP",
						["resurrectIcon"] = {
							["attachTo"] = "BOTTOMRIGHT",
						},
						["width"] = 92,
					},
					["targettarget"] = {
						["debuffs"] = {
							["enable"] = false,
							["anchorPoint"] = "TOPRIGHT",
						},
						["threatStyle"] = "GLOW",
						["power"] = {
							["enable"] = false,
						},
						["disableMouseoverGlow"] = true,
						["width"] = 270,
						["raidicon"] = {
							["attachTo"] = "LEFT",
							["xOffset"] = 2,
							["enable"] = false,
							["yOffset"] = 0,
						},
					},
					["party"] = {
						["targetsGroup"] = {
							["disableMouseoverGlow"] = false,
							["disableFocusGlow"] = false,
							["disableTargetGlow"] = false,
						},
						["height"] = 74,
						["rdebuffs"] = {
							["font"] = "Arial Narrow",
						},
						["power"] = {
							["height"] = 13,
						},
						["width"] = 231,
						["petsGroup"] = {
							["disableTargetGlow"] = false,
							["disableMouseoverGlow"] = false,
							["disableFocusGlow"] = false,
						},
					},
					["boss"] = {
						["debuffs"] = {
							["sizeOverride"] = 27,
							["yOffset"] = -16,
							["maxDuration"] = 300,
						},
						["castbar"] = {
							["width"] = 246,
						},
						["width"] = 246,
						["infoPanel"] = {
							["height"] = 17,
						},
						["height"] = 60,
						["buffs"] = {
							["sizeOverride"] = 27,
							["yOffset"] = 16,
							["maxDuration"] = 300,
						},
					},
				},
				["statusbar"] = "Melli",
				["colors"] = {
					["healthclass"] = true,
					["auraBarBuff"] = {
						["r"] = 0,
						["g"] = 0.4392147064208984,
						["b"] = 0.8666647672653198,
					},
					["castClassColor"] = true,
					["castColor"] = {
						["r"] = 0.1,
						["g"] = 0.1,
						["b"] = 0.1,
					},
					["health"] = {
						["r"] = 0.1,
						["g"] = 0.1,
						["b"] = 0.1,
					},
				},
				["smoothbars"] = true,
			},
			["datatexts"] = {
				["font"] = "Arial Narrow",
				["panels"] = {
					["LeftChatDataPanel"] = {
						[3] = "Quick Join",
					},
				},
			},
			["actionbar"] = {
				["bar3"] = {
					["enabled"] = false,
					["visibility"] = "[petbattle] hide; show",
				},
				["extraActionButton"] = {
					["macroFontOutline"] = "MONOCHROMEOUTLINE",
					["countFontOutline"] = "MONOCHROMEOUTLINE",
				},
				["font"] = "Arial Narrow",
				["bar1"] = {
					["buttonSpacing"] = 1,
					["buttonSize"] = 50,
					["buttons"] = 8,
				},
				["barPet"] = {
					["macroFontOutline"] = "MONOCHROMEOUTLINE",
				},
				["bar6"] = {
					["enabled"] = true,
					["buttonsPerRow"] = 10,
					["visibility"] = "[petbattle] hide; show",
					["buttonSpacing"] = 1,
					["buttons"] = 8,
					["buttonSize"] = 50,
				},
				["microbar"] = {
					["buttons"] = 11,
				},
				["vehicleExitButton"] = {
					["macroFontOutline"] = "MONOCHROMEOUTLINE",
					["countFontOutline"] = "MONOCHROMEOUTLINE",
				},
				["bar5"] = {
					["buttonsPerRow"] = 12,
					["visibility"] = "[petbattle] hide; show",
					["buttonSpacing"] = 1,
					["buttons"] = 9,
					["buttonSize"] = 38,
				},
				["bar2"] = {
					["visibility"] = "[petbattle] hide; show",
				},
				["stanceBar"] = {
					["macroFontOutline"] = "MONOCHROMEOUTLINE",
					["countFontOutline"] = "MONOCHROMEOUTLINE",
				},
				["bar4"] = {
					["enabled"] = false,
					["visibility"] = "[petbattle] hide; show",
				},
			},
			["nameplates"] = {
				["statusbar"] = "Melli",
				["font"] = "Arial Narrow",
			},
			["v11NamePlateReset"] = true,
			["auras"] = {
				["debuffs"] = {
					["countFontSize"] = 12,
					["size"] = 40,
					["countFont"] = "Arial Narrow",
					["timeFontSize"] = 12,
					["timeFont"] = "Arial Narrow",
				},
				["buffs"] = {
					["countFontSize"] = 12,
					["size"] = 40,
					["countFont"] = "Arial Narrow",
					["timeFontSize"] = 12,
					["timeFont"] = "Arial Narrow",
				},
			},
		},
	},
	["gold"] = {
		["Dentarg"] = {
			["Korupcija"] = 69,
			["Mulac"] = 66,
			["Handrmandr"] = 83,
			["Vermins"] = 1956766292,
			["Govance"] = 38,
			["Verson"] = 85,
			["Kostur"] = 34,
			["Battitude"] = 12,
			["Pitchwise"] = 9823257,
			["Tuka"] = 79,
			["Konza"] = 29,
		},
	},
	["serverID"] = {
		[1084] = {
			["Dentarg"] = true,
		},
	},
	["profileKeys"] = {
		["Konza - Dentarg"] = "Default",
		["Mulac - Dentarg"] = "Default",
		["Handrmandr - Dentarg"] = "Default",
		["Govance - Dentarg"] = "Default",
		["Verson - Dentarg"] = "Default",
		["Pitchwise - Dentarg"] = "Default",
		["Kostur - Dentarg"] = "Default",
		["Vermins - Dentarg"] = "Default",
		["Tuka - Dentarg"] = "Default",
		["Korupcija - Dentarg"] = "Default",
		["Battitude - Dentarg"] = "Default",
	},
	["faction"] = {
		["Dentarg"] = {
			["Korupcija"] = "Horde",
			["Mulac"] = "Horde",
			["Handrmandr"] = "Horde",
			["Vermins"] = "Horde",
			["Govance"] = "Horde",
			["Verson"] = "Horde",
			["Kostur"] = "Horde",
			["Battitude"] = "Horde",
			["Pitchwise"] = "Horde",
			["Tuka"] = "Horde",
			["Konza"] = "Horde",
		},
	},
	["LuaErrorDisabledAddOns"] = {
	},
}
ElvPrivateDB = {
	["profileKeys"] = {
		["Konza - Dentarg"] = "Konza - Dentarg",
		["Mulac - Dentarg"] = "Mulac - Dentarg",
		["Handrmandr - Dentarg"] = "Handrmandr - Dentarg",
		["Govance - Dentarg"] = "Govance - Dentarg",
		["Verson - Dentarg"] = "Verson - Dentarg",
		["Pitchwise - Dentarg"] = "Pitchwise - Dentarg",
		["Kostur - Dentarg"] = "Kostur - Dentarg",
		["Vermins - Dentarg"] = "Vermins - Dentarg",
		["Tuka - Dentarg"] = "Tuka - Dentarg",
		["Korupcija - Dentarg"] = "Korupcija - Dentarg",
		["Battitude - Dentarg"] = "Battitude - Dentarg",
	},
	["profiles"] = {
		["Konza - Dentarg"] = {
			["install_complete"] = 12.91,
		},
		["Mulac - Dentarg"] = {
			["install_complete"] = 12.91,
		},
		["Handrmandr - Dentarg"] = {
			["install_complete"] = 12.91,
		},
		["Govance - Dentarg"] = {
			["install_complete"] = 12.91,
		},
		["Verson - Dentarg"] = {
			["install_complete"] = 12.91,
		},
		["Pitchwise - Dentarg"] = {
			["theme"] = "class",
			["install_complete"] = 11.49,
		},
		["Kostur - Dentarg"] = {
			["install_complete"] = 12.91,
		},
		["Vermins - Dentarg"] = {
			["general"] = {
				["normTex"] = "Melli",
				["dmgfont"] = "Arial Narrow",
				["nameplateFont"] = "Arial Narrow",
				["namefont"] = "Arial Narrow",
				["nameplateLargeFont"] = "Arial Narrow",
				["glossTex"] = "Melli",
			},
			["bags"] = {
				["enable"] = false,
			},
			["install_complete"] = 12.91,
		},
		["Tuka - Dentarg"] = {
			["install_complete"] = 12.91,
		},
		["Korupcija - Dentarg"] = {
			["install_complete"] = 12.91,
		},
		["Battitude - Dentarg"] = {
			["install_complete"] = 12.91,
		},
	},
}
